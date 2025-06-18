use Final_Project;

/* 建立Table (users、admins、categories、items、borrow_records、check_logs) */
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    role ENUM('student', 'staff') NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE admins (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    name VARCHAR(50),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    category_id INT NOT NULL,
    quantity INT DEFAULT 1,
    available_quantity INT DEFAULT 1,
    location VARCHAR(100),
    status ENUM('active', 'inactive') DEFAULT 'active',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE borrow_records (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    item_id INT NOT NULL,
    borrow_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    due_time DATETIME NOT NULL,
    return_time DATETIME DEFAULT NULL,
    status ENUM('borrowed', 'returned', 'overdue') DEFAULT 'borrowed',
    notes TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

CREATE TABLE check_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    record_id INT NOT NULL,
    checked_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_overdue BOOLEAN,
    note TEXT,
    FOREIGN KEY (record_id) REFERENCES borrow_records(record_id)
);

/* ---------------------------------------------------------------------------------- */
/* 插入資料 */
-- users
DELETE FROM users;
ALTER TABLE users AUTO_INCREMENT = 1;

INSERT INTO users (name, email, phone, role)
VALUES
('林小明', 'ming.lin@example.com', '0912345678', 'student'),
('張美華', 'mei.hua@example.com', '0922333444', 'staff'),
('陳志偉', 'zhi.wei@example.com', '0987654321', 'student'),
('黃怡婷', 'ting.huang@example.com', '0911222333', 'student'),
('吳建宏', 'chien.hung@example.com', '0933444555', 'staff'),
('李佳蓉', 'jia.rong@example.com', '0966111222', 'student'),
('周柏宇', 'bo.yu@example.com', '0955111333', 'staff'),
('游子涵', 'han.yu@example.com', '0988222555', 'student'),
('蔡承融', 'cheng.rong@example.com', '0977555123', 'student'),
('何佩琪', 'pei.chi@example.com', '0933111222', 'staff');

SELECT * FROM users;

-- admins
DELETE FROM admins;
ALTER TABLE admins AUTO_INCREMENT = 1;

INSERT INTO admins (username, password, name)
VALUES
('admin01', 'pass123', '管理員小王'),
('admin02', 'secure456', '管理員小李'),
('root99', 'adminroot', '資深管理員'),
('admin_chen', 'test789', '陳主任'),
('boss01', 'iamtheboss', '總務處主任');

SELECT * FROM admins;

-- categories
DELETE FROM categories;
ALTER TABLE categories AUTO_INCREMENT = 1;

INSERT INTO categories (category_name, description)
VALUES
('球類運動', '如籃球、排球、羽球等球類項目'),
('健身器材', '啞鈴、壺鈴、彈力帶等訓練器材'),
('防護裝備', '護膝、護腕、頭盔等保護裝備'),
('輔助工具', '計分板、秒錶、哨子等輔助用品'),
('其他', '不屬於其他分類的器材');

SELECT * FROM categories;

-- items
DELETE FROM items;
ALTER TABLE items AUTO_INCREMENT = 1;

INSERT INTO items (item_name, category_id, quantity, available_quantity, location, status)
VALUES
('籃球', 1, 10, 8, '器材室 A', 'active'),
('排球', 1, 8, 5, '器材室 A', 'active'),
('羽球拍', 1, 20, 18, '器材室 A', 'active'),
('壺鈴 10kg', 2, 6, 6, '健身房', 'active'),
('啞鈴組合', 2, 10, 10, '健身房', 'active'),
('彈力帶', 2, 15, 12, '健身房', 'active'),
('護膝', 3, 12, 11, '護具櫃', 'active'),
('頭盔', 3, 6, 6, '護具櫃', 'active'),
('秒錶', 4, 5, 4, '器材室 B', 'active'),
('哨子', 4, 10, 10, '器材室 B', 'active'),
('計分板', 4, 3, 2, '器材室 B', 'active'),
('瑜珈墊', 5, 10, 9, '器材室 C', 'active'),
('拉伸繩', 5, 8, 8, '器材室 C', 'active'),
('地墊清潔劑', 5, 5, 5, '清潔櫃', 'inactive'),
('伸展棒', 5, 7, 7, '器材室 C', 'active');

SELECT * FROM items;

-- borrow_records
DELETE FROM borrow_records;
ALTER TABLE borrow_records AUTO_INCREMENT = 1;

INSERT INTO borrow_records (user_id, item_id, borrow_time, due_time, return_time, status, notes)
VALUES
(3, 4, '2024-06-01 09:30:00', '2024-06-03 09:30:00', '2024-06-03 09:00:00', 'returned', NULL),
(6, 2, '2024-05-28 14:00:00', '2024-05-30 14:00:00', NULL, 'overdue', '忘記歸還'),
(2, 10, '2024-06-03 10:15:00', '2024-06-05 10:15:00', NULL, 'borrowed', NULL),
(5, 7, '2024-06-02 13:00:00', '2024-06-04 13:00:00', '2024-06-04 12:50:00', 'returned', NULL),
(9, 3, '2024-06-01 11:00:00', '2024-06-03 11:00:00', NULL, 'borrowed', NULL),
(1, 1, '2024-05-29 15:00:00', '2024-05-31 15:00:00', '2024-05-30 14:45:00', 'returned', NULL),
(7, 5, '2024-06-04 09:00:00', '2024-06-06 09:00:00', NULL, 'borrowed', NULL),
(4, 9, '2024-05-25 13:30:00', '2024-05-27 13:30:00', '2024-05-28 08:00:00', 'returned', '逾期歸還'),
(10, 13, '2024-06-02 16:00:00', '2024-06-04 16:00:00', NULL, 'borrowed', NULL),
(8, 6, '2024-06-01 08:00:00', '2024-06-03 08:00:00', NULL, 'overdue', '尚未歸還'),
(2, 11, '2024-06-02 12:00:00', '2024-06-04 12:00:00', NULL, 'borrowed', NULL),
(5, 8, '2024-06-01 10:00:00', '2024-06-03 10:00:00', '2024-06-03 09:45:00', 'returned', NULL),
(9, 12, '2024-05-31 14:00:00', '2024-06-02 14:00:00', NULL, 'overdue', '未歸還'),
(6, 14, '2024-06-04 15:30:00', '2024-06-06 15:30:00', NULL, 'borrowed', NULL),
(3, 15, '2024-05-20 11:00:00', '2024-05-22 11:00:00', '2024-05-22 10:50:00', 'returned', NULL),
(4, 2, '2024-06-01 14:30:00', '2024-06-03 14:30:00', '2024-06-03 14:00:00', 'returned', NULL),
(7, 10, '2024-06-02 13:00:00', '2024-06-04 13:00:00', NULL, 'borrowed', NULL),
(1, 7, '2024-05-30 10:00:00', '2024-06-01 10:00:00', NULL, 'overdue', '超過兩天未還'),
(8, 1, '2024-06-03 11:00:00', '2024-06-05 11:00:00', '2024-06-05 10:50:00', 'returned', NULL),
(10, 6, '2024-05-27 09:00:00', '2024-05-29 09:00:00', NULL, 'overdue', '遺失器材');

SELECT * FROM borrow_records;

/* ---------------------------------------------------------------------------------- */
/* 交易機制 */
BEGIN;

-- 更新器材數量
UPDATE items
SET available_quantity = available_quantity - 1
WHERE item_id = 5 AND available_quantity > 0;

-- 新增借用紀錄
INSERT INTO borrow_records (user_id, item_id, due_time, status)
VALUES (1, 5, DATE_ADD(NOW(), INTERVAL 7 DAY), 'borrowed');

-- 查看變更是否正確
SELECT * FROM borrow_records WHERE user_id = 1 ORDER BY record_id DESC;

-- 若正確，再執行：
COMMIT;
-- 或
-- ROLLBACK; -- 若中間有錯誤，則回滾所有操作

/* ---------------------------------------------------------------------------------- */
/* Trigger */
  /* 自動處理更新事件 */
CREATE TRIGGER trg_check_overdue
AFTER UPDATE ON borrow_records
FOR EACH ROW
INSERT INTO check_logs (record_id, checked_at, is_overdue, note)
SELECT NEW.record_id, NOW(),
  CASE
    WHEN NEW.return_time IS NOT NULL AND NEW.return_time > NEW.due_time THEN TRUE
    WHEN NEW.return_time IS NOT NULL THEN FALSE
    ELSE NULL
  END,
  CASE
    WHEN NEW.return_time IS NOT NULL AND NEW.return_time > NEW.due_time THEN '逾期歸還'
    WHEN NEW.return_time IS NOT NULL THEN '準時歸還'
    ELSE NULL
  END;

SHOW TRIGGERS FROM Final_Project;

-- 逾期未還
UPDATE borrow_records
SET return_time = '2024-05-28 08:00:00', status = 'returned'
WHERE record_id = 8;

SELECT * FROM check_logs ORDER BY log_id DESC;


-- 準時歸還
UPDATE borrow_records
SET return_time = '2024-06-02 08:00:00', status = 'returned'
WHERE record_id = 4;

SELECT * FROM check_logs ORDER BY log_id DESC;

  /* 自動處理插入事件 */
CREATE TRIGGER trg_check_insert
AFTER INSERT ON borrow_records
FOR EACH ROW
INSERT INTO check_logs (record_id, checked_at, is_overdue, note)
VALUES (
  NEW.record_id,
  NOW(),
  NULL,
  '新增借用紀錄'
);
-- 新增一筆借用紀錄（假設 user_id=1, item_id=1 存在）
INSERT INTO borrow_records (user_id, item_id, due_time)
VALUES (1, 1, '2024-07-01 12:00:00');
-- 驗證
SELECT * FROM check_logs ORDER BY log_id DESC;

  /* 自動處理刪除事件 */
-- 刪除 users 後，自動刪除該使用者的借用紀錄
CREATE TRIGGER trg_log_on_borrow_delete
AFTER DELETE ON borrow_records
FOR EACH ROW
INSERT INTO check_logs (record_id, checked_at, is_overdue, note)
VALUES (
  OLD.record_id,
  NOW(),
  NULL,
  '刪除借用紀錄'
);
-- 刪除
DELETE FROM borrow_records WHERE record_id = 22;
-- 驗證
SELECT * FROM check_logs ORDER BY log_id DESC;

/* ---------------------------------------------------------------------------------- */
/* 聚合函數 + GROUP BY 統計每位使用者借過幾筆資料 */
SELECT 
  u.name,
  COUNT(br.record_id) AS total_borrowed
FROM 
  borrow_records br
JOIN 
  users u ON br.user_id = u.user_id
GROUP BY 
  br.user_id;

/* ---------------------------------------------------------------------------------- */
/* GROUP BY + HAVING 只顯示借用次數大於 2 次的人 */
SELECT 
  u.name,
  COUNT(br.record_id) AS borrow_count
FROM 
  borrow_records br
JOIN 
  users u ON br.user_id = u.user_id
GROUP BY 
  br.user_id
HAVING 
  COUNT(br.record_id) > 2;


-- 因為沒人超過兩次所以再插入幾筆讓 user_id = 1 的人看起來很愛借
INSERT INTO borrow_records (user_id, item_id, borrow_time, due_time, status)
VALUES
(1, 3, NOW(), DATE_ADD(NOW(), INTERVAL 3 DAY), 'borrowed'),
(1, 4, NOW(), DATE_ADD(NOW(), INTERVAL 3 DAY), 'borrowed'),
(1, 5, NOW(), DATE_ADD(NOW(), INTERVAL 3 DAY), 'borrowed');

/* ---------------------------------------------------------------------------------- */
/* 子查詢（Subquery） 查詢借過「籃球」的所有人 */
SELECT DISTINCT u.name
FROM users u
WHERE u.user_id IN (
  SELECT br.user_id
  FROM borrow_records br
  JOIN items i ON br.item_id = i.item_id
  WHERE i.item_name = '籃球'
);

/* ---------------------------------------------------------------------------------- */
/* 複雜查詢（JOIN + GROUP BY + ORDER） 列出最常被借的前三個器材 */
SELECT 
  i.item_name,
  COUNT(*) AS borrow_count
FROM 
  borrow_records br
JOIN 
  items i ON br.item_id = i.item_id
GROUP BY 
  br.item_id
ORDER BY 
  borrow_count DESC
LIMIT 3;

/* ---------------------------------------------------------------------------------- */
/* Stored Procedure 統計某個使用者的借用總數與已還總數 */
DROP PROCEDURE IF EXISTS get_user_borrow_stats;

CREATE PROCEDURE get_user_borrow_stats(IN uid INT)
BEGIN
  SELECT 
    u.name,
    COUNT(*) AS total_borrowed,
    SUM(CASE WHEN br.return_time IS NOT NULL THEN 1 ELSE 0 END) AS returned_count
  FROM 
    borrow_records br
  JOIN 
    users u ON br.user_id = u.user_id
  WHERE 
    br.user_id = uid
  GROUP BY 
    br.user_id;
END;

CALL get_user_borrow_stats(1);

/* ---------------------------------------------------------------------------------- */
/* 安全性與權限管理 (可選)：建立 ROLE、分配權限。 */
-- 建立一個角色：borrow_viewer
CREATE ROLE borrow_viewer;
-- 分配權限給這個角色
GRANT SELECT ON Final_Project.borrow_records TO borrow_viewer;
-- 建立一個使用者帳號：viewer1
CREATE USER 'viewer1'@'localhost' IDENTIFIED BY '123456';
-- 指定角色給這個使用者：
GRANT borrow_viewer TO 'viewer1'@'localhost';
-- 測試這個帳號能不能 SELECT
SELECT * FROM Final_Project.borrow_records;
