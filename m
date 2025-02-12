Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9483BC021A2
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 05:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti4vp-0004UJ-Jj; Wed, 12 Feb 2025 00:05:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1ti4vk-0004Tg-8M
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 00:05:01 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1ti4vf-0004KY-E5
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 00:04:59 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21f61b01630so6685985ad.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 21:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739336693; x=1739941493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sXlRK2vxV1YvoIP4KQ3wefbHp7zT6doPeT+nh5oN52A=;
 b=l3h9sbbWh1TvMCVQfmtGiFA0Ji9JhuHGb2xr6ur6YUqWCn8z/tMT1XwR43cpJ1Krv1
 zvHSBDvptJuBty443t3DcpIQZw6iizkauOz8gmja8a63Epsd2CTw77AGeW7W70fjBnQc
 owdHcMyB6Xe1BYXTpAWCbmCbQ1yOnjavhoXvKg0aNFGixbHRNegeKhsUYHA7BZYqs+AC
 syUwQaLiBRNM0wgh/J6AJ9ihgR0habOF2m9r9iDYvbQ2cY2XxVH2RAfNDqDFLO/IQVFJ
 j5PmPfOTHt9XLfdNwsVldIZVcxoC244KoybXwUKO+NJVICfwa8EGygpolo1t+HipEDwF
 FE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739336693; x=1739941493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sXlRK2vxV1YvoIP4KQ3wefbHp7zT6doPeT+nh5oN52A=;
 b=M4rgq5mMM254istHKsp7yPBxdE3lDMoxVCtkILi7fNK7TS6kWD7qe/g8ncfOTvVlC5
 Mh8t83kY4gOEfRAjEFP6njPQlXtDAKnOaTUj5ya0RP05L7lYKZ/+gurY1INeTnSVtkpX
 W/UiVrXkDt2kDexwiAWjV9da5rjc1mJPOGshkvw0MeAZwbjhEYz6WwwCtoysX5uHy6Tb
 7NLjP8BRI5oDnSMZqHg6lBCgsOFu2qGM8Ces9kb9Xuz5nF/ntgNsZZa1drN24LCh47nq
 58/jLHH+OnI5t79HziUiCWsup1O3Qes54a3nOdJcvdiw+/w/B+ts9rxXpuumVziTiSwW
 s1ng==
X-Gm-Message-State: AOJu0YwzQowRplxjbaTaY1u186nJkgPtuqwe362rr40m/i6I0W76M+ul
 nXH/Hq4/z3lCJp9d2aT+ps6CLpJAb28Npi8Td7bqFPJUzgWLuQoS
X-Gm-Gg: ASbGnctAoSnioZxnOJIg8U4A63BNbPs/wkjiWnw0NqY2yYKAV/u8OF63eSmhbdEbTf7
 ioVDAiwWrSI4kSuaIxKXFvKYrnZR6sMQ/tDrLM0QavetViYuyNyxzKv7gyJrng1FoxhauBS0LDP
 Bc66zYnmjHYQCmxO98fBnCCoBNvlpWGB8ho3g6pbXehxJG0Z9QjZ1y44q+2VfM9Vy6EDD9NIfEU
 QIadJrD/Wg1EHLJfRYlunpInyMHpKpJuYAbh8c6m1EHT75OSEcCUvGmoGUz/mf4SExQ1ZvP+6UD
 SJ70vJHxIusjJO666VnlJA==
X-Google-Smtp-Source: AGHT+IGKaYtLysqwN/87+h54omUaXjmK72930LmYdx/0jtx/ubZTiAx5X65Yr0xH3JPiPXu5ueFvOQ==
X-Received: by 2002:aa7:88c1:0:b0:730:949d:2d52 with SMTP id
 d2e1a72fcca58-7322beed136mr3171199b3a.3.1739336691607; 
 Tue, 11 Feb 2025 21:04:51 -0800 (PST)
Received: from jeuk-MS-7D42.. ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048bf1421sm10480602b3a.101.2025.02.11.21.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 21:04:51 -0800 (PST)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: jeuk20.kim@samsung.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, j-young.choi@samsung.com, keosung.park@samsung.com
Subject: [PATCH 2/3] tests/qtest/ufs-test: Prepare for MCQ test
Date: Wed, 12 Feb 2025 14:04:20 +0900
Message-ID: <c187fff3417293b719dbcbacb75cbdceff17be71.1739336154.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739336154.git.jeuk20.kim@samsung.com>
References: <cover.1739336154.git.jeuk20.kim@samsung.com>
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

In legacy doorbell mode, the command descriptor slot matched
the UTRD slot. To maintain consistency in MCQ mode, command descriptor
slot allocation and deallocation now use a bitmap-based approach.

Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 tests/qtest/ufs-test.c | 562 +++++++++++++++++++++--------------------
 1 file changed, 295 insertions(+), 267 deletions(-)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index ce8b398c6b..f5b311554b 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -13,6 +13,7 @@
 #include "libqos/pci.h"
 #include "scsi/constants.h"
 #include "block/ufs.h"
+#include "qemu/bitmap.h"
 
 /* Test images sizes in Bytes */
 #define TEST_IMAGE_SIZE (64 * 1024 * 1024)
@@ -25,6 +26,8 @@
 #define UTP_COMMAND_DESCRIPTOR_SIZE 4096
 #define UTP_RESPONSE_UPIU_OFFSET 1024
 #define UTP_PRDT_UPIU_OFFSET 2048
+#define UTRD_TEST_SLOT 0
+#define UFS_MAX_CMD_DESC 32
 
 typedef struct QUfs QUfs;
 
@@ -34,6 +37,7 @@ struct QUfs {
     QPCIBar bar;
 
     uint64_t utrlba;
+    DECLARE_BITMAP(cmd_desc_bitmap, UFS_MAX_CMD_DESC);
     uint64_t cmd_desc_addr;
     uint64_t data_buffer_addr;
 
@@ -50,6 +54,24 @@ static inline void ufs_wreg(QUfs *ufs, size_t offset, uint32_t value)
     qpci_io_writel(&ufs->dev, ufs->bar, offset, value);
 }
 
+static int alloc_cmd_desc_slot(QUfs *ufs)
+{
+    int slot = find_first_zero_bit(ufs->cmd_desc_bitmap, UFS_MAX_CMD_DESC);
+    if (slot == UFS_MAX_CMD_DESC) {
+        g_assert_not_reached();
+    }
+    set_bit(slot, ufs->cmd_desc_bitmap);
+    return slot;
+}
+
+static void release_cmd_desc_slot(QUfs *ufs, int slot)
+{
+    if (!test_bit(slot, ufs->cmd_desc_bitmap)) {
+        g_assert_not_reached();
+    }
+    clear_bit(slot, ufs->cmd_desc_bitmap);
+}
+
 static void ufs_wait_for_irq(QUfs *ufs)
 {
     uint64_t end_time;
@@ -62,14 +84,11 @@ static void ufs_wait_for_irq(QUfs *ufs)
     } while (is == 0 && g_get_monotonic_time() < end_time);
 }
 
-static UtpTransferReqDesc ufs_build_req_utrd(uint64_t cmd_desc_addr,
-                                             uint8_t slot,
+static UtpTransferReqDesc ufs_build_req_utrd(uint64_t command_desc_base_addr,
                                              uint32_t data_direction,
                                              uint16_t prd_table_length)
 {
     UtpTransferReqDesc req = { 0 };
-    uint64_t command_desc_base_addr =
-        cmd_desc_addr + slot * UTP_COMMAND_DESCRIPTOR_SIZE;
 
     req.header.dword_0 =
         cpu_to_le32(1 << 28 | data_direction | UFS_UTP_REQ_DESC_INT_CMD);
@@ -86,54 +105,73 @@ static UtpTransferReqDesc ufs_build_req_utrd(uint64_t cmd_desc_addr,
     return req;
 }
 
-static void ufs_send_nop_out(QUfs *ufs, uint8_t slot,
-                             UtpTransferReqDesc *utrd_out, UtpUpiuRsp *rsp_out)
+static enum UtpOcsCodes
+ufs_send_transfer_request_sync(QUfs *ufs, uint8_t lun,
+                               const UtpTransferReqDesc *utrd)
 {
-    /* Build up utp transfer request descriptor */
-    UtpTransferReqDesc utrd = ufs_build_req_utrd(ufs->cmd_desc_addr, slot,
-                                                 UFS_UTP_NO_DATA_TRANSFER, 0);
-    uint64_t utrd_addr = ufs->utrlba + slot * sizeof(UtpTransferReqDesc);
+    UtpTransferReqDesc utrd_result;
+    /*
+     * Currently, the transfer request is sent synchronously, so UTRD_TEST_SLOT
+     * is fixed to 0. If asynchronous testing is added in the future, this value
+     * should be adjusted dynamically.
+     */
+    uint64_t utrd_addr =
+        ufs->utrlba + UTRD_TEST_SLOT * sizeof(UtpTransferReqDesc);
+    qtest_memwrite(ufs->dev.bus->qts, utrd_addr, utrd, sizeof(*utrd));
+
+    /* Ring Doorbell */
+    ufs_wreg(ufs, A_UTRLDBR, 1);
+    ufs_wait_for_irq(ufs);
+    g_assert_true(FIELD_EX32(ufs_rreg(ufs, A_IS), IS, UTRCS));
+    ufs_wreg(ufs, A_IS, FIELD_DP32(0, IS, UTRCS, 1));
+
+    qtest_memread(ufs->dev.bus->qts, utrd_addr, &utrd_result,
+                  sizeof(utrd_result));
+
+    return le32_to_cpu(utrd_result.header.dword_2) & 0xf;
+}
+
+static enum UtpOcsCodes ufs_send_nop_out(QUfs *ufs, UtpUpiuRsp *rsp_out)
+{
+    int cmd_desc_slot = alloc_cmd_desc_slot(ufs);
     uint64_t req_upiu_addr =
-        ufs->cmd_desc_addr + slot * UTP_COMMAND_DESCRIPTOR_SIZE;
+        ufs->cmd_desc_addr + cmd_desc_slot * UTP_COMMAND_DESCRIPTOR_SIZE;
     uint64_t rsp_upiu_addr = req_upiu_addr + UTP_RESPONSE_UPIU_OFFSET;
-    qtest_memwrite(ufs->dev.bus->qts, utrd_addr, &utrd, sizeof(utrd));
 
     /* Build up request upiu */
     UtpUpiuReq req_upiu = { 0 };
     req_upiu.header.trans_type = UFS_UPIU_TRANSACTION_NOP_OUT;
-    req_upiu.header.task_tag = slot;
+    req_upiu.header.task_tag = cmd_desc_slot;
     qtest_memwrite(ufs->dev.bus->qts, req_upiu_addr, &req_upiu,
                    sizeof(req_upiu));
 
-    /* Ring Doorbell */
-    ufs_wreg(ufs, A_UTRLDBR, 1);
-    ufs_wait_for_irq(ufs);
-    g_assert_true(FIELD_EX32(ufs_rreg(ufs, A_IS), IS, UTRCS));
-    ufs_wreg(ufs, A_IS, FIELD_DP32(0, IS, UTRCS, 1));
+    /* Build up utp transfer request descriptor */
+    UtpTransferReqDesc utrd =
+        ufs_build_req_utrd(req_upiu_addr, UFS_UTP_NO_DATA_TRANSFER, 0);
+
+    /* Send Transfer Request */
+    enum UtpOcsCodes ret = ufs_send_transfer_request_sync(ufs, 0, &utrd);
 
-    qtest_memread(ufs->dev.bus->qts, utrd_addr, utrd_out, sizeof(*utrd_out));
     qtest_memread(ufs->dev.bus->qts, rsp_upiu_addr, rsp_out, sizeof(*rsp_out));
+    release_cmd_desc_slot(ufs, cmd_desc_slot);
+    return ret;
 }
 
-static void ufs_send_query(QUfs *ufs, uint8_t slot, uint8_t query_function,
-                           uint8_t query_opcode, uint8_t idn, uint8_t index,
-                           uint8_t selector, uint32_t attr_value,
-                           UtpTransferReqDesc *utrd_out, UtpUpiuRsp *rsp_out)
+static enum UtpOcsCodes ufs_send_query(QUfs *ufs, uint8_t query_function,
+                                       uint8_t query_opcode, uint8_t idn,
+                                       uint8_t index, uint8_t selector,
+                                       uint32_t attr_value, UtpUpiuRsp *rsp_out)
 {
-    /* Build up utp transfer request descriptor */
-    UtpTransferReqDesc utrd = ufs_build_req_utrd(ufs->cmd_desc_addr, slot,
-                                                 UFS_UTP_NO_DATA_TRANSFER, 0);
-    uint64_t utrd_addr = ufs->utrlba + slot * sizeof(UtpTransferReqDesc);
+    int cmd_desc_slot = alloc_cmd_desc_slot(ufs);
     uint64_t req_upiu_addr =
-        ufs->cmd_desc_addr + slot * UTP_COMMAND_DESCRIPTOR_SIZE;
+        ufs->cmd_desc_addr + cmd_desc_slot * UTP_COMMAND_DESCRIPTOR_SIZE;
     uint64_t rsp_upiu_addr = req_upiu_addr + UTP_RESPONSE_UPIU_OFFSET;
-    qtest_memwrite(ufs->dev.bus->qts, utrd_addr, &utrd, sizeof(utrd));
 
     /* Build up request upiu */
     UtpUpiuReq req_upiu = { 0 };
     req_upiu.header.trans_type = UFS_UPIU_TRANSACTION_QUERY_REQ;
     req_upiu.header.query_func = query_function;
-    req_upiu.header.task_tag = slot;
+    req_upiu.header.task_tag = cmd_desc_slot;
     /*
      * QEMU UFS does not currently support Write descriptor,
      * so the value of data_segment_length is always 0.
@@ -148,22 +186,23 @@ static void ufs_send_query(QUfs *ufs, uint8_t slot, uint8_t query_function,
     qtest_memwrite(ufs->dev.bus->qts, req_upiu_addr, &req_upiu,
                    sizeof(req_upiu));
 
-    /* Ring Doorbell */
-    ufs_wreg(ufs, A_UTRLDBR, 1);
-    ufs_wait_for_irq(ufs);
-    g_assert_true(FIELD_EX32(ufs_rreg(ufs, A_IS), IS, UTRCS));
-    ufs_wreg(ufs, A_IS, FIELD_DP32(0, IS, UTRCS, 1));
+    /* Build up utp transfer request descriptor */
+    UtpTransferReqDesc utrd =
+        ufs_build_req_utrd(req_upiu_addr, UFS_UTP_NO_DATA_TRANSFER, 0);
+
+    /* Send Transfer Request */
+    enum UtpOcsCodes ret = ufs_send_transfer_request_sync(ufs, 0, &utrd);
 
-    qtest_memread(ufs->dev.bus->qts, utrd_addr, utrd_out, sizeof(*utrd_out));
     qtest_memread(ufs->dev.bus->qts, rsp_upiu_addr, rsp_out, sizeof(*rsp_out));
+    release_cmd_desc_slot(ufs, cmd_desc_slot);
+    return ret;
 }
 
-static void ufs_send_scsi_command(QUfs *ufs, uint8_t slot, uint8_t lun,
-                                  const uint8_t *cdb, const uint8_t *data_in,
-                                  size_t data_in_len, uint8_t *data_out,
-                                  size_t data_out_len,
-                                  UtpTransferReqDesc *utrd_out,
-                                  UtpUpiuRsp *rsp_out)
+static enum UtpOcsCodes
+ufs_send_scsi_command(QUfs *ufs, uint8_t lun, const uint8_t *cdb,
+                      const uint8_t *data_in, size_t data_in_len,
+                      uint8_t *data_out, size_t data_out_len,
+                      UtpUpiuRsp *rsp_out)
 
 {
     /* Build up PRDT */
@@ -173,8 +212,9 @@ static void ufs_send_scsi_command(QUfs *ufs, uint8_t slot, uint8_t lun,
     uint8_t flags;
     uint16_t prd_table_length, i;
     uint32_t data_direction, data_len;
+    int cmd_desc_slot = alloc_cmd_desc_slot(ufs);
     uint64_t req_upiu_addr =
-        ufs->cmd_desc_addr + slot * UTP_COMMAND_DESCRIPTOR_SIZE;
+        ufs->cmd_desc_addr + cmd_desc_slot * UTP_COMMAND_DESCRIPTOR_SIZE;
     uint64_t prdt_addr = req_upiu_addr + UTP_PRDT_UPIU_OFFSET;
 
     g_assert_true(data_in_len < MAX_PRD_ENTRY_COUNT * PRD_ENTRY_DATA_SIZE);
@@ -216,36 +256,33 @@ static void ufs_send_scsi_command(QUfs *ufs, uint8_t slot, uint8_t lun,
     qtest_memwrite(ufs->dev.bus->qts, prdt_addr, entries,
                    prd_table_length * sizeof(UfshcdSgEntry));
 
-    /* Build up utp transfer request descriptor */
-    UtpTransferReqDesc utrd = ufs_build_req_utrd(
-        ufs->cmd_desc_addr, slot, data_direction, prd_table_length);
-    uint64_t utrd_addr = ufs->utrlba + slot * sizeof(UtpTransferReqDesc);
     uint64_t rsp_upiu_addr = req_upiu_addr + UTP_RESPONSE_UPIU_OFFSET;
-    qtest_memwrite(ufs->dev.bus->qts, utrd_addr, &utrd, sizeof(utrd));
 
     /* Build up request upiu */
     UtpUpiuReq req_upiu = { 0 };
     req_upiu.header.trans_type = UFS_UPIU_TRANSACTION_COMMAND;
     req_upiu.header.flags = flags;
     req_upiu.header.lun = lun;
-    req_upiu.header.task_tag = slot;
+    req_upiu.header.task_tag = cmd_desc_slot;
     req_upiu.sc.exp_data_transfer_len = cpu_to_be32(data_len);
     memcpy(req_upiu.sc.cdb, cdb, UFS_CDB_SIZE);
     qtest_memwrite(ufs->dev.bus->qts, req_upiu_addr, &req_upiu,
                    sizeof(req_upiu));
 
-    /* Ring Doorbell */
-    ufs_wreg(ufs, A_UTRLDBR, 1);
-    ufs_wait_for_irq(ufs);
-    g_assert_true(FIELD_EX32(ufs_rreg(ufs, A_IS), IS, UTRCS));
-    ufs_wreg(ufs, A_IS, FIELD_DP32(0, IS, UTRCS, 1));
+    /* Build up utp transfer request descriptor */
+    UtpTransferReqDesc utrd =
+        ufs_build_req_utrd(req_upiu_addr, data_direction, prd_table_length);
+
+    /* Send Transfer Request */
+    enum UtpOcsCodes ret = ufs_send_transfer_request_sync(ufs, lun, &utrd);
 
-    qtest_memread(ufs->dev.bus->qts, utrd_addr, utrd_out, sizeof(*utrd_out));
     qtest_memread(ufs->dev.bus->qts, rsp_upiu_addr, rsp_out, sizeof(*rsp_out));
     if (data_out_len) {
         qtest_memread(ufs->dev.bus->qts, ufs->data_buffer_addr, data_out,
                       data_out_len);
     }
+    release_cmd_desc_slot(ufs, cmd_desc_slot);
+    return ret;
 }
 
 /**
@@ -258,7 +295,7 @@ static void ufs_init(QUfs *ufs, QGuestAllocator *alloc)
     uint32_t nutrs;
     uint32_t hcs, is, ucmdarg2, cap;
     uint32_t hce = 0, ie = 0;
-    UtpTransferReqDesc utrd;
+    enum UtpOcsCodes ocs;
     UtpUpiuRsp rsp_upiu;
 
     ufs->bar = qpci_iomap(&ufs->dev, 0, NULL);
@@ -320,11 +357,11 @@ static void ufs_init(QUfs *ufs, QGuestAllocator *alloc)
     ufs_wreg(ufs, A_IE, ie);
     ufs_wreg(ufs, A_UTRIACR, 0);
 
-    /* Enable transfer request and task management request */
+    /* Enable transfer request */
     cap = ufs_rreg(ufs, A_CAP);
     nutrs = FIELD_EX32(cap, CAP, NUTRS) + 1;
     ufs->cmd_desc_addr =
-        guest_alloc(alloc, nutrs * UTP_COMMAND_DESCRIPTOR_SIZE);
+        guest_alloc(alloc, UFS_MAX_CMD_DESC * UTP_COMMAND_DESCRIPTOR_SIZE);
     ufs->data_buffer_addr =
         guest_alloc(alloc, MAX_PRD_ENTRY_COUNT * PRD_ENTRY_DATA_SIZE);
     ufs->utrlba = guest_alloc(alloc, nutrs * sizeof(UtpTransferReqDesc));
@@ -334,23 +371,27 @@ static void ufs_init(QUfs *ufs, QGuestAllocator *alloc)
     ufs_wreg(ufs, A_UTRLRSR, 1);
 
     /* Send nop out to test transfer request */
-    ufs_send_nop_out(ufs, 0, &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_nop_out(ufs, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
 
     /* Set fDeviceInit flag via query request */
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_SET_FLAG,
-                   UFS_QUERY_FLAG_IDN_FDEVICEINIT, 0, 0, 0, &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_SET_FLAG,
+                         UFS_QUERY_FLAG_IDN_FDEVICEINIT, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
 
     /* Wait for device to reset */
     end_time = g_get_monotonic_time() + TIMEOUT_SECONDS * G_TIME_SPAN_SECOND;
     do {
         qtest_clock_step(ufs->dev.bus->qts, 100);
-        ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
-                       UFS_UPIU_QUERY_OPCODE_READ_FLAG,
-                       UFS_QUERY_FLAG_IDN_FDEVICEINIT, 0, 0, 0, &utrd,
-                       &rsp_upiu);
+        ocs =
+            ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                           UFS_UPIU_QUERY_OPCODE_READ_FLAG,
+                           UFS_QUERY_FLAG_IDN_FDEVICEINIT, 0, 0, 0, &rsp_upiu);
+        g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+        g_assert_cmpuint(rsp_upiu.header.response, ==,
+                         UFS_COMMAND_RESULT_SUCCESS);
     } while (be32_to_cpu(rsp_upiu.qr.value) != 0 &&
              g_get_monotonic_time() < end_time);
     g_assert_cmpuint(be32_to_cpu(rsp_upiu.qr.value), ==, 0);
@@ -424,15 +465,15 @@ static void ufstest_init(void *obj, void *data, QGuestAllocator *alloc)
     const uint8_t request_sense_cdb[UFS_CDB_SIZE] = {
         REQUEST_SENSE,
     };
-    UtpTransferReqDesc utrd;
+    enum UtpOcsCodes ocs;
     UtpUpiuRsp rsp_upiu;
 
     ufs_init(ufs, alloc);
 
     /* Check REPORT_LUNS */
-    ufs_send_scsi_command(ufs, 0, 0, report_luns_cdb, NULL, 0, buf, sizeof(buf),
-                          &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_scsi_command(ufs, 0, report_luns_cdb, NULL, 0, buf,
+                                sizeof(buf), &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
     /* LUN LIST LENGTH should be 8, in big endian */
     g_assert_cmpuint(buf[3], ==, 8);
@@ -440,15 +481,15 @@ static void ufstest_init(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmpuint(buf[9], ==, 0);
 
     /* Clear Unit Attention */
-    ufs_send_scsi_command(ufs, 0, 0, request_sense_cdb, NULL, 0, buf,
-                          sizeof(buf), &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_scsi_command(ufs, 0, request_sense_cdb, NULL, 0, buf,
+                                sizeof(buf), &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, CHECK_CONDITION);
 
     /* Check TEST_UNIT_READY */
-    ufs_send_scsi_command(ufs, 0, 0, test_unit_ready_cdb, NULL, 0, NULL, 0,
-                          &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_scsi_command(ufs, 0, test_unit_ready_cdb, NULL, 0, NULL, 0,
+                                &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
 
     ufs_exit(ufs, alloc);
@@ -490,22 +531,22 @@ static void ufstest_read_write(void *obj, void *data, QGuestAllocator *alloc)
         WRITE_10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00
     };
     uint32_t block_size;
-    UtpTransferReqDesc utrd;
+    enum UtpOcsCodes ocs;
     UtpUpiuRsp rsp_upiu;
     const int test_lun = 1;
 
     ufs_init(ufs, alloc);
 
     /* Clear Unit Attention */
-    ufs_send_scsi_command(ufs, 0, test_lun, request_sense_cdb, NULL, 0,
-                          read_buf, sizeof(read_buf), &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_scsi_command(ufs, test_lun, request_sense_cdb, NULL, 0,
+                                read_buf, sizeof(read_buf), &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, CHECK_CONDITION);
 
     /* Read capacity */
-    ufs_send_scsi_command(ufs, 0, test_lun, read_capacity_cdb, NULL, 0,
-                          read_buf, sizeof(read_buf), &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_scsi_command(ufs, test_lun, read_capacity_cdb, NULL, 0,
+                                read_buf, sizeof(read_buf), &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.scsi_status, ==,
                      UFS_COMMAND_RESULT_SUCCESS);
     block_size = ldl_be_p(&read_buf[8]);
@@ -513,16 +554,16 @@ static void ufstest_read_write(void *obj, void *data, QGuestAllocator *alloc)
 
     /* Write data */
     memset(write_buf, 0xab, block_size);
-    ufs_send_scsi_command(ufs, 0, test_lun, write_cdb, write_buf, block_size,
-                          NULL, 0, &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_scsi_command(ufs, test_lun, write_cdb, write_buf, block_size,
+                                NULL, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.scsi_status, ==,
                      UFS_COMMAND_RESULT_SUCCESS);
 
     /* Read data and verify */
-    ufs_send_scsi_command(ufs, 0, test_lun, read_cdb, NULL, 0, read_buf,
-                          block_size, &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_scsi_command(ufs, test_lun, read_cdb, NULL, 0, read_buf,
+                                block_size, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.scsi_status, ==,
                      UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpint(memcmp(read_buf, write_buf, block_size), ==, 0);
@@ -535,76 +576,74 @@ static void ufstest_query_flag_request(void *obj, void *data,
 {
     QUfs *ufs = obj;
 
-    UtpTransferReqDesc utrd;
+    enum UtpOcsCodes ocs;
     UtpUpiuRsp rsp_upiu;
     ufs_init(ufs, alloc);
 
     /* Read read-only flag */
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_READ_FLAG,
-                   UFS_QUERY_FLAG_IDN_FDEVICEINIT, 0, 0, 0, &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_FLAG,
+                         UFS_QUERY_FLAG_IDN_FDEVICEINIT, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpuint(rsp_upiu.qr.opcode, ==, UFS_UPIU_QUERY_OPCODE_READ_FLAG);
     g_assert_cmpuint(rsp_upiu.qr.idn, ==, UFS_QUERY_FLAG_IDN_FDEVICEINIT);
     g_assert_cmpuint(rsp_upiu.qr.value, ==, be32_to_cpu(0));
 
     /* Flag Set, Clear, Toggle Test with fDeviceLifeSpanModeEn */
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_READ_FLAG,
-                   UFS_QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE, 0, 0, 0, &utrd,
-                   &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_FLAG,
+                         UFS_QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE, 0, 0, 0,
+                         &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpuint(rsp_upiu.qr.value, ==, be32_to_cpu(0));
 
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_SET_FLAG,
-                   UFS_QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE, 0, 0, 0, &utrd,
-                   &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_SET_FLAG,
+                         UFS_QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE, 0, 0, 0,
+                         &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpuint(rsp_upiu.qr.value, ==, be32_to_cpu(1));
 
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_CLEAR_FLAG,
-                   UFS_QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE, 0, 0, 0, &utrd,
-                   &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_CLEAR_FLAG,
+                         UFS_QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE, 0, 0, 0,
+                         &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpuint(rsp_upiu.qr.value, ==, be32_to_cpu(0));
 
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_TOGGLE_FLAG,
-                   UFS_QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE, 0, 0, 0, &utrd,
-                   &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_TOGGLE_FLAG,
+                         UFS_QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE, 0, 0, 0,
+                         &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpuint(rsp_upiu.qr.value, ==, be32_to_cpu(1));
 
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_TOGGLE_FLAG,
-                   UFS_QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE, 0, 0, 0, &utrd,
-                   &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_TOGGLE_FLAG,
+                         UFS_QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE, 0, 0, 0,
+                         &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpuint(rsp_upiu.qr.value, ==, be32_to_cpu(0));
 
     /* Read Write-only Flag (Intended Failure) */
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_READ_FLAG,
-                   UFS_QUERY_FLAG_IDN_PURGE_ENABLE, 0, 0, 0, &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==,
-                     UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_FLAG,
+                         UFS_QUERY_FLAG_IDN_PURGE_ENABLE, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
     g_assert_cmpuint(rsp_upiu.header.response, ==,
                      UFS_QUERY_RESULT_NOT_READABLE);
 
     /* Write Read-Only Flag (Intended Failure) */
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_SET_FLAG, UFS_QUERY_FLAG_IDN_BUSY_RTC,
-                   0, 0, 0, &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==,
-                     UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_SET_FLAG,
+                         UFS_QUERY_FLAG_IDN_BUSY_RTC, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
     g_assert_cmpuint(rsp_upiu.header.response, ==,
                      UFS_QUERY_RESULT_NOT_WRITEABLE);
 
@@ -616,130 +655,122 @@ static void ufstest_query_attr_request(void *obj, void *data,
 {
     QUfs *ufs = obj;
 
-    UtpTransferReqDesc utrd;
+    enum UtpOcsCodes ocs;
     UtpUpiuRsp rsp_upiu;
     ufs_init(ufs, alloc);
 
     /* Read Readable Attributes*/
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_READ_ATTR,
-                   UFS_QUERY_ATTR_IDN_BOOT_LU_EN, 0, 0, 0, &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                         UFS_QUERY_ATTR_IDN_BOOT_LU_EN, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpuint(rsp_upiu.qr.opcode, ==, UFS_UPIU_QUERY_OPCODE_READ_ATTR);
     g_assert_cmpuint(rsp_upiu.qr.idn, ==, UFS_QUERY_ATTR_IDN_BOOT_LU_EN);
     g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x00));
 
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_READ_ATTR,
-                   UFS_QUERY_ATTR_IDN_BKOPS_STATUS, 0, 0, 0, &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                         UFS_QUERY_ATTR_IDN_BKOPS_STATUS, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x00));
 
     /* Write Writable Attributes & Read Again */
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
-                   UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL, 0, 0, 0x03, &utrd,
-                   &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
+                         UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL, 0, 0, 0x03,
+                         &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x03));
 
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
-                   UFS_QUERY_ATTR_IDN_EE_CONTROL, 0, 0, 0x07, &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
+                         UFS_QUERY_ATTR_IDN_EE_CONTROL, 0, 0, 0x07, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x07));
 
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_READ_ATTR,
-                   UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL, 0, 0, 0, &utrd,
-                   &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                         UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x03));
 
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_READ_ATTR,
-                   UFS_QUERY_ATTR_IDN_EE_CONTROL, 0, 0, 0, &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                         UFS_QUERY_ATTR_IDN_EE_CONTROL, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x07));
 
     /* Write Invalid Value (Intended Error) */
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
-                   UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL, 0, 0, 0x10, &utrd,
-                   &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==,
-                     UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
+                         UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL, 0, 0, 0x10,
+                         &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
     g_assert_cmpuint(rsp_upiu.header.response, ==,
                      UFS_QUERY_RESULT_INVALID_VALUE);
 
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_READ_ATTR,
-                   UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL, 0, 0, 0, &utrd,
-                   &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                         UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x03));
 
     /* Read Write-Only Attribute (Intended Error) */
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_READ_ATTR,
-                   UFS_QUERY_ATTR_IDN_SECONDS_PASSED, 0, 0, 0, &utrd,
-                   &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==,
-                     UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                         UFS_QUERY_ATTR_IDN_SECONDS_PASSED, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
     g_assert_cmpuint(rsp_upiu.header.response, ==,
                      UFS_QUERY_RESULT_NOT_READABLE);
 
     /* Write Read-Only Attribute (Intended Error) */
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
-                   UFS_QUERY_ATTR_IDN_POWER_MODE, 0, 0, 0x01, &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==,
-                     UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
+                         UFS_QUERY_ATTR_IDN_POWER_MODE, 0, 0, 0x01, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
     g_assert_cmpuint(rsp_upiu.header.response, ==,
                      UFS_QUERY_RESULT_NOT_WRITEABLE);
 
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_READ_ATTR,
-                   UFS_QUERY_ATTR_IDN_POWER_MODE, 0, 0, 0, &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                         UFS_QUERY_ATTR_IDN_POWER_MODE, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x00));
 
     /* Reset Written Attributes */
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
-                   UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL, 0, 0, 0, &utrd,
-                   &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
+                         UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x00));
 
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
-                   UFS_QUERY_ATTR_IDN_EE_CONTROL, 0, 0, 0, &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
+                         UFS_QUERY_ATTR_IDN_EE_CONTROL, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x00));
 
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_READ_ATTR,
-                   UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL, 0, 0, 0, &utrd,
-                   &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                         UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x00));
 
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_READ_ATTR,
-                   UFS_QUERY_ATTR_IDN_EE_CONTROL, 0, 0, 0, &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                         UFS_QUERY_ATTR_IDN_EE_CONTROL, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x00));
 
@@ -751,17 +782,17 @@ static void ufstest_query_desc_request(void *obj, void *data,
 {
     QUfs *ufs = obj;
 
-    UtpTransferReqDesc utrd;
+    enum UtpOcsCodes ocs;
     UtpUpiuRsp rsp_upiu;
     ufs_init(ufs, alloc);
 
     /* Write Descriptor is not supported yet */
 
     /* Read Device Descriptor */
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_DEVICE,
-                   0, 0, 0, &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_DESC,
+                         UFS_QUERY_DESC_IDN_DEVICE, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpuint(rsp_upiu.qr.opcode, ==, UFS_UPIU_QUERY_OPCODE_READ_DESC);
     g_assert_cmpuint(rsp_upiu.qr.idn, ==, UFS_QUERY_DESC_IDN_DEVICE);
@@ -771,126 +802,123 @@ static void ufstest_query_desc_request(void *obj, void *data,
     /* Read Configuration Descriptor is not supported yet*/
 
     /* Read Unit Descriptor */
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_UNIT, 0,
-                   0, 0, &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_DESC,
+                         UFS_QUERY_DESC_IDN_UNIT, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpuint(rsp_upiu.qr.data[0], ==, sizeof(UnitDescriptor));
     g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_UNIT);
     g_assert_cmpuint(rsp_upiu.qr.data[2], ==, 0);
 
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_UNIT, 1,
-                   0, 0, &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_DESC,
+                         UFS_QUERY_DESC_IDN_UNIT, 1, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpuint(rsp_upiu.qr.data[0], ==, sizeof(UnitDescriptor));
     g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_UNIT);
     g_assert_cmpuint(rsp_upiu.qr.data[2], ==, 1);
 
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_UNIT,
-                   UFS_UPIU_RPMB_WLUN, 0, 0, &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs =
+        ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                       UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_UNIT,
+                       UFS_UPIU_RPMB_WLUN, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpuint(rsp_upiu.qr.data[0], ==, sizeof(RpmbUnitDescriptor));
     g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_UNIT);
     g_assert_cmpuint(rsp_upiu.qr.data[2], ==, UFS_UPIU_RPMB_WLUN);
 
     /* Read Interconnect Descriptor */
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_READ_DESC,
-                   UFS_QUERY_DESC_IDN_INTERCONNECT, 0, 0, 0, &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_DESC,
+                         UFS_QUERY_DESC_IDN_INTERCONNECT, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpuint(rsp_upiu.qr.data[0], ==, sizeof(InterconnectDescriptor));
     g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_INTERCONNECT);
 
     /* Read String Descriptor */
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_STRING,
-                   0, 0, 0, &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_DESC,
+                         UFS_QUERY_DESC_IDN_STRING, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpuint(rsp_upiu.qr.data[0], ==, 0x12);
     g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_STRING);
 
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_STRING,
-                   1, 0, 0, &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_DESC,
+                         UFS_QUERY_DESC_IDN_STRING, 1, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpuint(rsp_upiu.qr.data[0], ==, 0x22);
     g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_STRING);
 
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_STRING,
-                   4, 0, 0, &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_DESC,
+                         UFS_QUERY_DESC_IDN_STRING, 4, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpuint(rsp_upiu.qr.data[0], ==, 0x0a);
     g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_STRING);
 
     /* Read Geometry Descriptor */
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_GEOMETRY,
-                   0, 0, 0, &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_DESC,
+                         UFS_QUERY_DESC_IDN_GEOMETRY, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpuint(rsp_upiu.qr.data[0], ==, sizeof(GeometryDescriptor));
     g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_GEOMETRY);
 
     /* Read Power Descriptor */
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_POWER, 0,
-                   0, 0, &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_DESC,
+                         UFS_QUERY_DESC_IDN_POWER, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpuint(rsp_upiu.qr.data[0], ==,
                      sizeof(PowerParametersDescriptor));
     g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_POWER);
 
     /* Read Health Descriptor */
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_HEALTH,
-                   0, 0, 0, &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_DESC,
+                         UFS_QUERY_DESC_IDN_HEALTH, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpuint(rsp_upiu.qr.data[0], ==, sizeof(DeviceHealthDescriptor));
     g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_HEALTH);
 
     /* Invalid Index (Intended Failure) */
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_UNIT, 4,
-                   0, 0, &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==,
-                     UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_DESC,
+                         UFS_QUERY_DESC_IDN_UNIT, 4, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
     g_assert_cmpuint(rsp_upiu.header.response, ==,
                      UFS_QUERY_RESULT_INVALID_INDEX);
 
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_STRING,
-                   5, 0, 0, &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==,
-                     UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_DESC,
+                         UFS_QUERY_DESC_IDN_STRING, 5, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
     g_assert_cmpuint(rsp_upiu.header.response, ==,
                      UFS_QUERY_RESULT_INVALID_INDEX);
 
     /* Invalid Selector (Intended Failure) */
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_DEVICE,
-                   0, 1, 0, &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==,
-                     UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_DESC,
+                         UFS_QUERY_DESC_IDN_DEVICE, 0, 1, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
     g_assert_cmpuint(rsp_upiu.header.response, ==,
                      UFS_QUERY_RESULT_INVALID_SELECTOR);
 
-    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
-                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_STRING,
-                   0, 1, 0, &utrd, &rsp_upiu);
-    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==,
-                     UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_DESC,
+                         UFS_QUERY_DESC_IDN_STRING, 0, 1, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
     g_assert_cmpuint(rsp_upiu.header.response, ==,
                      UFS_QUERY_RESULT_INVALID_SELECTOR);
 
-- 
2.43.0


