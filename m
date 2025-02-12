Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6971CC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 05:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti4vp-0004UL-Kf; Wed, 12 Feb 2025 00:05:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1ti4vj-0004TK-0z
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 00:04:59 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1ti4vg-0004Kf-UU
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 00:04:58 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21f5268cf50so70051375ad.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 21:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739336695; x=1739941495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vhiJos3NyChxzeYINVp45yOD0HybRIiXzqJ2nZlxZvs=;
 b=egN8tw1oELLjMnWaljNWOfrJhk8l3h95ayzupT2mZeUbBA9uzMSszKTRLMdY7jx3jy
 UyIYNgbs08gEhj6LMSR01b0+nXXgytuqJj0WcFfDCdrn7BAwnQH5jKrBjK1L7W7tEbH5
 dehOO2cjc4eDzw/cPya917/S5O3mfcshrmHeTX1wj4iSr1YYBhsAQJIWih/gChWgmAeI
 NKaC2FHOydkjshS7jw7443Y9kphqQ3Ja6f0rgzxKnY8+99DVDxfkVkNr1Pv62VPoVmi0
 pa3Sp8bjICtT5eA6hCBc3UJ49YBGtAQxFcRymQgUgJDWyPjfyc+eJML3H1meQI9EMwin
 n6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739336695; x=1739941495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vhiJos3NyChxzeYINVp45yOD0HybRIiXzqJ2nZlxZvs=;
 b=w+xqrKANm9TS1qkZ0QEbJKXXwsFVjqHF7mA7lVaHLsW1UwWas6qBH24VWb2+RyptKW
 CAI97w2iFjI8Bckm+4BIJky7UB3KwzEWvU475ttfkbQDTwLaqw92KSmL16fkVf32JB1T
 QYI4TRJ1iaV8tuicDB0UTz3Ady68tt2Y2xdDCxnTyqrmDujuaRKBT9z9Z1snV3rnpO+C
 /+A14DRfpl0Y0UJjutmShZqjatN1/IQ+356zVefwBmS4sdGu1b9vFokfqWwb+0PqPucK
 RCQu2Td7RIjUCx6PYnB+JFs1w4dcKJILIITPm8AH9/KTXbvh++kguCxe/KuxNMqaB7KD
 77eA==
X-Gm-Message-State: AOJu0YxAr4gDCuBamfAohbM77QJhNAMTwxvIUQrwubQhRLaE2UbZPZRi
 A7YCBeCEPRDHymslWD4E130wAdDGUvHBhFS0w85oCwNOmyaX2b67
X-Gm-Gg: ASbGncvu+8amk1yB0qKgatPZGqq5Ogd7tVB3Vqv9fQ6YMRdwWEn3V8Ggl/HgFS57Xwk
 +31yRn/LbST4ExWPRuroRZR2MWHkQHck1FOm9ReODblHFgz9rgCsIDxAqzB4JO6xLqGYar9yyak
 sGFKtdIGthacTR1OSWIPf40bGLB/yoyQ18wKsTjm7g87m5FWlLIfmy/VPTFydOI3DalvvAKki7X
 i0lKvakmjYA1IzLxb7yfuqxW21k2dDorkXoSAlkUOynzP9ntokoryAV5INTog1ATFlSIzIKfpNq
 M17J6NAVuDiQVDOrXosDXg==
X-Google-Smtp-Source: AGHT+IEUcVqTCqa89stONZidG9PDTbuMuSRa/RI+jkqD2wusZxlrO4WT7kWdgcZBcmGeaLzhFSKqVw==
X-Received: by 2002:a05:6a21:e85:b0:1e1:f281:8d07 with SMTP id
 adf61e73a8af0-1ee5e550b25mr1940373637.10.1739336695037; 
 Tue, 11 Feb 2025 21:04:55 -0800 (PST)
Received: from jeuk-MS-7D42.. ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048bf1421sm10480602b3a.101.2025.02.11.21.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 21:04:54 -0800 (PST)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: jeuk20.kim@samsung.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, j-young.choi@samsung.com, keosung.park@samsung.com
Subject: [PATCH 3/3] tests/qtest/ufs-test: Add test code for MCQ functionality
Date: Wed, 12 Feb 2025 14:04:21 +0900
Message-ID: <6f1a8e7f4542f24972f3e0ce4872574b83a515c9.1739336154.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739336154.git.jeuk20.kim@samsung.com>
References: <cover.1739336154.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x630.google.com
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


