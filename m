Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DADC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 09:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjxQX-0001pf-P7; Mon, 17 Feb 2025 04:28:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1tjxQU-0001o8-CR; Mon, 17 Feb 2025 04:28:30 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1tjxQS-0000uh-8M; Mon, 17 Feb 2025 04:28:30 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-220d28c215eso57676015ad.1; 
 Mon, 17 Feb 2025 01:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739784506; x=1740389306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7k9xy97KVspCgOHJ8VeGnGCHWrmII8BOuhEsECDFsI=;
 b=kP7tERMxDKqTtWvmzX6UZEmfxXqDuoa1UQUKV9c/J1u9Ab9KTQtPh7MfTniofGBU5e
 IRpNSWtFYSjsIRo52WY4sQy2aXzrWhU7qOQL84iZIhp6t2E7xE1a1imQg39wUxSE7Rvc
 rQI4ezx8L+3N94LD6LVvIWbRb7YA2+WXW1DCXlcm1CmxYg9mQAGbWyv2io3Zp3N8tN7I
 6XSbFZI2kzz3nayba0po3rUYv4gcTI8Xb8xtAl6TCQ01ucvz3OMT/8uY0S1kO3erLn/y
 ItrEJTFp0EgGDWrt+RtnGAdFHNnGjF+/4kIJ88cJ7NFnvrVDqs4Zj9Xe4DLHagk0bFV3
 OR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739784506; x=1740389306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F7k9xy97KVspCgOHJ8VeGnGCHWrmII8BOuhEsECDFsI=;
 b=EMGabM06Uogq0s2MS2UpLGzFFZopFjmxxqUSNEXPANvyK9py2q19H9v9G0+aK8GAqh
 HjVMDytPeM+OH6rkvRE6CAY+Gw5ZUw9CBzwaD/EcMZCCiPU61nm3R1i5ow80nJeXvwxm
 Q9mRuNkk4D3vLB2f1BQjTqeb6n3qRW14U5TxP7RDo0lBCJ/deXpVcAX+QKKSnVhGysEF
 joGDHU8RYSIzsiDgz7V6gz5O5Sk5Z0zC7zLrp35T188ENIerrYbIL/w6jKlLZ4jrop26
 Vc4+37V3/hN4NFoJr3uj9B8+YwzHGjk1ytyZY95xER/xjFmk0mxqw8W7OF+QF6g3kEQu
 vtTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWr6EQOpBc2Y5uJQxv1XUWwRgtuuzqhEwGOiBgJSWgipx7gBZRKK0nmhKTXOrBDpTSgF7bQE5IizNDe@nongnu.org
X-Gm-Message-State: AOJu0Yzgu2PcbwCyD2rn0gfDNusSmLJ9AuBp/fXaaZjycLAykk7nEMTq
 rRbjok6QzHXTOhRQbwZBeTYFNW6TeczYaOpy+WAikrVvVH9AyXgX8qxacQ==
X-Gm-Gg: ASbGnct6sve0wCAw41bBK8hGAnYIW52aZzF7zgdMyfpu77LVl6hOZALO2sU3WVGQfoE
 QaMBYwQyoSvQx1DTS9G1eZVanMAyPwnFRVl4wYCqPZ/0nGRZ7CL/q34MMp25EgK6qeBtNWb6zdL
 mIc8zmwWFdb7D7hf3VNuQY8A/usS/+XzK+JJVNhZmirkCuqxcHZ9AVb1+Ke0uS3J4M9A7lt4mjk
 n9s/C0c8YuKfrCKuCMfNzTJtxWJQec5ZLxhmAyQaXditJ6vjclNH+ojqo0cMM57yqXWnZUrMro+
 oDjiI8Fvsla/Br3dbu4=
X-Google-Smtp-Source: AGHT+IFxXWVdjaZTuUts7kZiRTGZWgWV8H05jVfg5jRBJ7i97LexP8tZkLplgZHdn3utNy/uKQhARQ==
X-Received: by 2002:a05:6a00:995:b0:730:949d:2d3f with SMTP id
 d2e1a72fcca58-732617a0c39mr14752226b3a.7.1739784505679; 
 Mon, 17 Feb 2025 01:28:25 -0800 (PST)
Received: from jeuk-MS-7D42.. ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73265f98e18sm4152940b3a.106.2025.02.17.01.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 01:28:25 -0800 (PST)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Cc: pbonzini@redhat.com, qemu-block@nongnu.org, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com, farosas@suse.de, lvivier@redhat.com,
 Jeuk Kim <jeuk20.kim@gmail.com>
Subject: [PULL 4/4] tests/qtest/ufs-test: Add test code for MCQ functionality
Date: Mon, 17 Feb 2025 18:27:55 +0900
Message-ID: <a54596a96006096798b172a368ae952a231f9f72.1739784105.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739784105.git.jeuk20.kim@samsung.com>
References: <cover.1739784105.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch tests whether MCQ initialization and basic read-write
operations work correctly when the MCQ parameter of hw/ufs is enabled.

Acked-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 tests/qtest/ufs-test.c | 171 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 142 insertions(+), 29 deletions(-)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index f5b311554b..d5076bdeb5 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -15,6 +15,7 @@
 #include "block/ufs.h"
 #include "qemu/bitmap.h"
 
+#define DWORD_BYTE 4
 /* Test images sizes in Bytes */
 #define TEST_IMAGE_SIZE (64 * 1024 * 1024)
 /* Timeout for various operations, in seconds. */
@@ -28,6 +29,10 @@
 #define UTP_PRDT_UPIU_OFFSET 2048
 #define UTRD_TEST_SLOT 0
 #define UFS_MAX_CMD_DESC 32
+/* Constants for MCQ */
+#define TEST_QID 0
+#define QUEUE_SIZE 32
+#define UFS_MCQ_MAX_QNUM 32
 
 typedef struct QUfs QUfs;
 
@@ -36,12 +41,22 @@ struct QUfs {
     QPCIDevice dev;
     QPCIBar bar;
 
-    uint64_t utrlba;
     DECLARE_BITMAP(cmd_desc_bitmap, UFS_MAX_CMD_DESC);
     uint64_t cmd_desc_addr;
     uint64_t data_buffer_addr;
 
     bool enabled;
+    bool support_mcq;
+
+    /* for legacy doorbell mode */
+    uint64_t utrlba;
+
+    /* for mcq mode */
+    uint32_t maxq;
+    uint64_t sqlba[UFS_MCQ_MAX_QNUM];
+    uint64_t cqlba[UFS_MCQ_MAX_QNUM];
+    uint64_t sqdao[UFS_MCQ_MAX_QNUM];
+    uint64_t cqdao[UFS_MCQ_MAX_QNUM];
 };
 
 static inline uint32_t ufs_rreg(QUfs *ufs, size_t offset)
@@ -106,31 +121,67 @@ static UtpTransferReqDesc ufs_build_req_utrd(uint64_t command_desc_base_addr,
 }
 
 static enum UtpOcsCodes
-ufs_send_transfer_request_sync(QUfs *ufs, uint8_t lun,
-                               const UtpTransferReqDesc *utrd)
+__ufs_send_transfer_request_doorbell(QUfs *ufs, uint8_t lun,
+                                     const UtpTransferReqDesc *utrd)
 {
-    UtpTransferReqDesc utrd_result;
-    /*
-     * Currently, the transfer request is sent synchronously, so UTRD_TEST_SLOT
-     * is fixed to 0. If asynchronous testing is added in the future, this value
-     * should be adjusted dynamically.
-     */
     uint64_t utrd_addr =
         ufs->utrlba + UTRD_TEST_SLOT * sizeof(UtpTransferReqDesc);
+    UtpTransferReqDesc utrd_result;
+
     qtest_memwrite(ufs->dev.bus->qts, utrd_addr, utrd, sizeof(*utrd));
 
-    /* Ring Doorbell */
+    /* Ring the doorbell */
     ufs_wreg(ufs, A_UTRLDBR, 1);
     ufs_wait_for_irq(ufs);
     g_assert_true(FIELD_EX32(ufs_rreg(ufs, A_IS), IS, UTRCS));
     ufs_wreg(ufs, A_IS, FIELD_DP32(0, IS, UTRCS, 1));
 
+    /* Handle completed command */
     qtest_memread(ufs->dev.bus->qts, utrd_addr, &utrd_result,
                   sizeof(utrd_result));
-
     return le32_to_cpu(utrd_result.header.dword_2) & 0xf;
 }
 
+static enum UtpOcsCodes
+__ufs_send_transfer_request_mcq(QUfs *ufs, uint8_t lun,
+                                const UtpTransferReqDesc *utrd)
+{
+    uint32_t sqtp = ufs_rreg(ufs, ufs->sqdao[TEST_QID] + 0x4);
+    uint64_t utrd_addr = ufs->sqlba[TEST_QID] + sqtp;
+    uint32_t cqhp;
+    uint64_t cqentry_addr;
+    UfsCqEntry cqentry;
+
+    qtest_memwrite(ufs->dev.bus->qts, utrd_addr, utrd, sizeof(*utrd));
+
+    /* Insert a new entry into the submission queue */
+    sqtp = ufs_rreg(ufs, ufs->sqdao[TEST_QID] + 0x4);
+    sqtp = (sqtp + sizeof(UfsSqEntry)) % (QUEUE_SIZE * sizeof(UfsSqEntry));
+    ufs_wreg(ufs, ufs->sqdao[TEST_QID] + 0x4, sqtp);
+    ufs_wait_for_irq(ufs);
+    g_assert_true(FIELD_EX32(ufs_rreg(ufs, A_IS), IS, CQES));
+    ufs_wreg(ufs, A_IS, FIELD_DP32(0, IS, CQES, 1));
+
+    /* Handle the completed command from the completion queue */
+    cqhp = ufs_rreg(ufs, ufs->cqdao[TEST_QID]);
+    cqentry_addr = ufs->cqlba[TEST_QID] + cqhp;
+    qtest_memread(ufs->dev.bus->qts, cqentry_addr, &cqentry, sizeof(cqentry));
+    ufs_wreg(ufs, ufs->cqdao[TEST_QID], cqhp);
+
+    return cqentry.status;
+}
+
+static enum UtpOcsCodes
+ufs_send_transfer_request_sync(QUfs *ufs, uint8_t lun,
+                               const UtpTransferReqDesc *utrd)
+{
+    if (ufs->support_mcq) {
+        return __ufs_send_transfer_request_mcq(ufs, lun, utrd);
+    }
+
+    return __ufs_send_transfer_request_doorbell(ufs, lun, utrd);
+}
+
 static enum UtpOcsCodes ufs_send_nop_out(QUfs *ufs, UtpUpiuRsp *rsp_out)
 {
     int cmd_desc_slot = alloc_cmd_desc_slot(ufs);
@@ -342,6 +393,10 @@ static void ufs_init(QUfs *ufs, QGuestAllocator *alloc)
     g_assert_true(FIELD_EX32(hcs, HCS, UTRLRDY));
     g_assert_true(FIELD_EX32(hcs, HCS, UCRDY));
 
+    /* Check MCQ support */
+    cap = ufs_rreg(ufs, A_CAP);
+    ufs->support_mcq = FIELD_EX32(cap, CAP, MCQS);
+
     /* Enable all interrupt functions */
     ie = FIELD_DP32(ie, IE, UTRCE, 1);
     ie = FIELD_DP32(ie, IE, UEE, 1);
@@ -354,21 +409,66 @@ static void ufs_init(QUfs *ufs, QGuestAllocator *alloc)
     ie = FIELD_DP32(ie, IE, HCFEE, 1);
     ie = FIELD_DP32(ie, IE, SBFEE, 1);
     ie = FIELD_DP32(ie, IE, CEFEE, 1);
+    if (ufs->support_mcq) {
+        ie = FIELD_DP32(ie, IE, CQEE, 1);
+    }
     ufs_wreg(ufs, A_IE, ie);
     ufs_wreg(ufs, A_UTRIACR, 0);
 
     /* Enable transfer request */
-    cap = ufs_rreg(ufs, A_CAP);
-    nutrs = FIELD_EX32(cap, CAP, NUTRS) + 1;
     ufs->cmd_desc_addr =
         guest_alloc(alloc, UFS_MAX_CMD_DESC * UTP_COMMAND_DESCRIPTOR_SIZE);
     ufs->data_buffer_addr =
         guest_alloc(alloc, MAX_PRD_ENTRY_COUNT * PRD_ENTRY_DATA_SIZE);
-    ufs->utrlba = guest_alloc(alloc, nutrs * sizeof(UtpTransferReqDesc));
 
-    ufs_wreg(ufs, A_UTRLBA, ufs->utrlba & 0xffffffff);
-    ufs_wreg(ufs, A_UTRLBAU, ufs->utrlba >> 32);
-    ufs_wreg(ufs, A_UTRLRSR, 1);
+    if (ufs->support_mcq) {
+        uint32_t mcqcap, qid, qcfgptr, mcq_reg_offset;
+        uint32_t cqattr = 0, sqattr = 0;
+
+        mcqcap = ufs_rreg(ufs, A_MCQCAP);
+        qcfgptr = FIELD_EX32(mcqcap, MCQCAP, QCFGPTR);
+        ufs->maxq = FIELD_EX32(mcqcap, MCQCAP, MAXQ) + 1;
+        for (qid = 0; qid < ufs->maxq; ++qid) {
+            ufs->sqlba[qid] =
+                guest_alloc(alloc, QUEUE_SIZE * sizeof(UtpTransferReqDesc));
+            ufs->cqlba[qid] =
+                guest_alloc(alloc, QUEUE_SIZE * sizeof(UtpTransferReqDesc));
+            mcq_reg_offset = qcfgptr * 0x200 + qid * 0x40;
+
+            ufs_wreg(ufs, mcq_reg_offset + A_SQLBA,
+                     ufs->sqlba[qid] & 0xffffffff);
+            ufs_wreg(ufs, mcq_reg_offset + A_SQUBA, ufs->sqlba[qid] >> 32);
+            ufs_wreg(ufs, mcq_reg_offset + A_CQLBA,
+                     ufs->cqlba[qid] & 0xffffffff);
+            ufs_wreg(ufs, mcq_reg_offset + A_CQUBA, ufs->cqlba[qid] >> 32);
+
+            /* Enable Completion Queue */
+            cqattr = FIELD_DP32(cqattr, CQATTR, CQEN, 1);
+            cqattr = FIELD_DP32(cqattr, CQATTR, SIZE,
+                                QUEUE_SIZE * sizeof(UtpTransferReqDesc) /
+                                    DWORD_BYTE);
+            ufs_wreg(ufs, mcq_reg_offset + A_CQATTR, cqattr);
+
+            /* Enable Submission Queue */
+            sqattr = FIELD_DP32(sqattr, SQATTR, SQEN, 1);
+            sqattr = FIELD_DP32(sqattr, SQATTR, SIZE,
+                                QUEUE_SIZE * sizeof(UtpTransferReqDesc) /
+                                    DWORD_BYTE);
+            sqattr = FIELD_DP32(sqattr, SQATTR, CQID, qid);
+            ufs_wreg(ufs, mcq_reg_offset + A_SQATTR, sqattr);
+
+            /* Cache head & tail pointer */
+            ufs->sqdao[qid] = ufs_rreg(ufs, mcq_reg_offset + A_SQDAO);
+            ufs->cqdao[qid] = ufs_rreg(ufs, mcq_reg_offset + A_CQDAO);
+        }
+    } else {
+        nutrs = FIELD_EX32(cap, CAP, NUTRS) + 1;
+        ufs->utrlba = guest_alloc(alloc, nutrs * sizeof(UtpTransferReqDesc));
+
+        ufs_wreg(ufs, A_UTRLBA, ufs->utrlba & 0xffffffff);
+        ufs_wreg(ufs, A_UTRLBAU, ufs->utrlba >> 32);
+        ufs_wreg(ufs, A_UTRLRSR, 1);
+    }
 
     /* Send nop out to test transfer request */
     ocs = ufs_send_nop_out(ufs, &rsp_upiu);
@@ -402,7 +502,15 @@ static void ufs_init(QUfs *ufs, QGuestAllocator *alloc)
 static void ufs_exit(QUfs *ufs, QGuestAllocator *alloc)
 {
     if (ufs->enabled) {
-        guest_free(alloc, ufs->utrlba);
+        if (ufs->support_mcq) {
+            for (uint32_t qid = 0; qid < ufs->maxq; ++qid) {
+                guest_free(alloc, ufs->sqlba[qid]);
+                guest_free(alloc, ufs->cqlba[qid]);
+            }
+        } else {
+            guest_free(alloc, ufs->utrlba);
+        }
+
         guest_free(alloc, ufs->cmd_desc_addr);
         guest_free(alloc, ufs->data_buffer_addr);
     }
@@ -966,12 +1074,16 @@ static void ufs_register_nodes(void)
     QOSGraphEdgeOptions edge_opts = {
         .before_cmd_line = "-blockdev null-co,node-name=drv0,read-zeroes=on",
         .after_cmd_line = "-device ufs-lu,bus=ufs0,drive=drv0,lun=0",
-        .extra_device_opts = "addr=04.0,id=ufs0,nutrs=32,nutmrs=8"
+        .extra_device_opts = "addr=04.0,id=ufs0"
     };
 
-    QOSGraphTestOptions io_test_opts = {
-        .before = ufs_blk_test_setup,
-    };
+    QOSGraphTestOptions io_test_opts = { .before = ufs_blk_test_setup,
+                                         .edge.extra_device_opts =
+                                             "mcq=false,nutrs=32,nutmrs=8" };
+
+    QOSGraphTestOptions mcq_test_opts = { .before = ufs_blk_test_setup,
+                                          .edge.extra_device_opts =
+                                              "mcq=true,mcq-maxq=1" };
 
     add_qpci_address(&edge_opts, &(QPCIAddress){ .devfn = QPCI_DEVFN(4, 0) });
 
@@ -991,13 +1103,14 @@ static void ufs_register_nodes(void)
         return;
     }
     qos_add_test("init", "ufs", ufstest_init, NULL);
-    qos_add_test("read-write", "ufs", ufstest_read_write, &io_test_opts);
-    qos_add_test("flag read-write", "ufs",
-                 ufstest_query_flag_request, &io_test_opts);
-    qos_add_test("attr read-write", "ufs",
-                 ufstest_query_attr_request, &io_test_opts);
-    qos_add_test("desc read-write", "ufs",
-                 ufstest_query_desc_request, &io_test_opts);
+    qos_add_test("legacy-read-write", "ufs", ufstest_read_write, &io_test_opts);
+    qos_add_test("mcq-read-write", "ufs", ufstest_read_write, &mcq_test_opts);
+    qos_add_test("query-flag", "ufs", ufstest_query_flag_request,
+                 &io_test_opts);
+    qos_add_test("query-attribute", "ufs", ufstest_query_attr_request,
+                 &io_test_opts);
+    qos_add_test("query-desciptor", "ufs", ufstest_query_desc_request,
+                 &io_test_opts);
 }
 
 libqos_init(ufs_register_nodes);
-- 
2.43.0


