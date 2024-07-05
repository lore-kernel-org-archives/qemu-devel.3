Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE86C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 13:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPiXZ-0007JF-8i; Fri, 05 Jul 2024 08:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sPiXW-0007F6-Sb
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 08:59:50 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sPiXU-0004Zo-Im
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 08:59:50 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFtqc5yvJz6K6ZH;
 Fri,  5 Jul 2024 20:58:36 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 00257140A30;
 Fri,  5 Jul 2024 20:59:47 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 13:59:46 +0100
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: <fan.ni@samsung.com>, Davidlohr Bueso <dave@stgolabs.net>, Fan Ni
 <nifan.cxl@gmail.com>, <linuxarm@huawei.com>
Subject: [PATCH v4 1/1] hw/cxl: Support firmware updates
Date: Fri, 5 Jul 2024 13:59:15 +0100
Message-ID: <20240705125915.991672-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240705125915.991672-1-Jonathan.Cameron@huawei.com>
References: <20240705125915.991672-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Davidlohr Bueso <dave@stgolabs.net>

Implement transfer and activate functionality per 3.1 spec for
supporting update metadata (no actual buffers). Transfer times
are arbitrarily set to ten and two seconds for full and part
transfers, respectively.

cxl update-firmware mem0 -F fw.img

<on-going fw update>

cxl update-firmware mem0
  "memdev":"mem0",
  "pmem_size":"1024.00 MiB (1073.74 MB)",
  "serial":"0",
  "host":"0000:0d:00.0",
  "firmware":{
    "num_slots":2,
    "active_slot":1,
    "online_activate_capable":true,
    "slot_1_version":"BWFW VERSION 0",
    "fw_update_in_progress":true,
    "remaining_size":22400
  }
}

<completed fw update>

cxl update-firmware mem0
{
  "memdev":"mem0",
  "pmem_size":"1024.00 MiB (1073.74 MB)",
  "serial":"0",
  "host":"0000:0d:00.0",
  "firmware":{
    "num_slots":2,
    "active_slot":1,
    "staged_slot":2,
    "online_activate_capable":true,
    "slot_1_version":"BWFW VERSION 0",
    "slot_2_version":"BWFW VERSION 1",
    "fw_update_in_progress":false
  }
}

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Link: https://lore.kernel.org/r/20240627164912.25630-1-dave@stgolabs.net
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v4: Rebased due to tree reordering.
    Fixed a couple of tab / space issues reported by checkpatch.
---
 include/hw/cxl/cxl_device.h |  15 +++
 hw/cxl/cxl-mailbox-utils.c  | 205 +++++++++++++++++++++++++++++++++++-
 2 files changed, 215 insertions(+), 5 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 5cae7159e6..fdd0f4e62b 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -181,6 +181,21 @@ typedef struct CXLCCI {
         uint64_t runtime;
         QEMUTimer *timer;
     } bg;
+
+    /* firmware update */
+    struct {
+        uint8_t active_slot;
+        uint8_t staged_slot;
+        bool slot[4];
+        uint8_t curr_action;
+        uint8_t curr_slot;
+        /* handle partial transfers */
+        bool transferring;
+        size_t prev_offset;
+        size_t prev_len;
+        time_t last_partxfer;
+    } fw;
+
     size_t payload_max;
     /* Pointer to device hosting the CCI */
     DeviceState *d;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index df919ad7ed..9cfcde8ffc 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -63,6 +63,8 @@ enum {
         #define SET_INTERRUPT_POLICY   0x3
     FIRMWARE_UPDATE = 0x02,
         #define GET_INFO      0x0
+        #define TRANSFER      0x1
+        #define ACTIVATE      0x2
     TIMESTAMP   = 0x03,
         #define GET           0x0
         #define SET           0x1
@@ -626,6 +628,9 @@ static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+#define CXL_FW_SLOTS 2
+#define CXL_FW_SIZE  0x02000000 /* 32 mb */
+
 /* CXL r3.1 Section 8.2.9.3.1: Get FW Info (Opcode 0200h) */
 static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
                                                uint8_t *payload_in,
@@ -657,15 +662,192 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
     fw_info = (void *)payload_out;
     memset(fw_info, 0, sizeof(*fw_info));
 
-    fw_info->slots_supported = 2;
-    fw_info->slot_info = BIT(0) | BIT(3);
-    fw_info->caps = 0;
-    pstrcpy(fw_info->fw_rev1, sizeof(fw_info->fw_rev1), "BWFW VERSION 0");
+    fw_info->slots_supported = CXL_FW_SLOTS;
+    fw_info->slot_info = (cci->fw.active_slot & 0x7) |
+            ((cci->fw.staged_slot & 0x7) << 3);
+    fw_info->caps = BIT(0);  /* online update supported */
+
+    if (cci->fw.slot[0]) {
+        pstrcpy(fw_info->fw_rev1, sizeof(fw_info->fw_rev1), "BWFW VERSION 0");
+    }
+    if (cci->fw.slot[1]) {
+        pstrcpy(fw_info->fw_rev2, sizeof(fw_info->fw_rev2), "BWFW VERSION 1");
+    }
 
     *len_out = sizeof(*fw_info);
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.1 section 8.2.9.3.2: Transfer FW (Opcode 0201h) */
+#define CXL_FW_XFER_ALIGNMENT   128
+
+#define CXL_FW_XFER_ACTION_FULL     0x0
+#define CXL_FW_XFER_ACTION_INIT     0x1
+#define CXL_FW_XFER_ACTION_CONTINUE 0x2
+#define CXL_FW_XFER_ACTION_END      0x3
+#define CXL_FW_XFER_ACTION_ABORT    0x4
+
+static CXLRetCode cmd_firmware_update_transfer(const struct cxl_cmd *cmd,
+                                               uint8_t *payload_in,
+                                               size_t len,
+                                               uint8_t *payload_out,
+                                               size_t *len_out,
+                                               CXLCCI *cci)
+{
+    struct {
+        uint8_t action;
+        uint8_t slot;
+        uint8_t rsvd1[2];
+        uint32_t offset;
+        uint8_t rsvd2[0x78];
+        uint8_t data[];
+    } QEMU_PACKED *fw_transfer = (void *)payload_in;
+    size_t offset, length;
+
+    if (fw_transfer->action == CXL_FW_XFER_ACTION_ABORT) {
+        /*
+         * At this point there aren't any on-going transfers
+         * running in the bg - this is serialized before this
+         * call altogether. Just mark the state machine and
+         * disregard any other input.
+         */
+        cci->fw.transferring = false;
+        return CXL_MBOX_SUCCESS;
+    }
+
+    offset = fw_transfer->offset * CXL_FW_XFER_ALIGNMENT;
+    length = len - sizeof(*fw_transfer);
+    if (offset + length > CXL_FW_SIZE) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    if (cci->fw.transferring) {
+        if (fw_transfer->action == CXL_FW_XFER_ACTION_FULL ||
+            fw_transfer->action == CXL_FW_XFER_ACTION_INIT) {
+            return CXL_MBOX_FW_XFER_IN_PROGRESS;
+        }
+        /*
+         * Abort partitioned package transfer if over 30 secs
+         * between parts. As opposed to the explicit ABORT action,
+         * semantically treat this condition as an error - as
+         * if a part action were passed without a previous INIT.
+         */
+        if (difftime(time(NULL), cci->fw.last_partxfer) > 30.0) {
+            cci->fw.transferring = false;
+            return CXL_MBOX_INVALID_INPUT;
+        }
+    } else if (fw_transfer->action == CXL_FW_XFER_ACTION_CONTINUE ||
+               fw_transfer->action == CXL_FW_XFER_ACTION_END) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    /* allow back-to-back retransmission */
+    if ((offset != cci->fw.prev_offset || length != cci->fw.prev_len) &&
+        (fw_transfer->action == CXL_FW_XFER_ACTION_CONTINUE ||
+         fw_transfer->action == CXL_FW_XFER_ACTION_END)) {
+        /* verify no overlaps */
+        if (offset < cci->fw.prev_offset + cci->fw.prev_len) {
+            return CXL_MBOX_FW_XFER_OUT_OF_ORDER;
+        }
+    }
+
+    switch (fw_transfer->action) {
+    case CXL_FW_XFER_ACTION_FULL: /* ignores offset */
+    case CXL_FW_XFER_ACTION_END:
+        if (fw_transfer->slot == 0 ||
+            fw_transfer->slot == cci->fw.active_slot ||
+            fw_transfer->slot > CXL_FW_SLOTS) {
+            return CXL_MBOX_FW_INVALID_SLOT;
+        }
+
+        /* mark the slot used upon bg completion */
+        break;
+    case CXL_FW_XFER_ACTION_INIT:
+        if (offset != 0) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+
+        cci->fw.transferring = true;
+        cci->fw.prev_offset = offset;
+        cci->fw.prev_len = length;
+        break;
+    case CXL_FW_XFER_ACTION_CONTINUE:
+        cci->fw.prev_offset = offset;
+        cci->fw.prev_len = length;
+        break;
+    default:
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    if (fw_transfer->action == CXL_FW_XFER_ACTION_FULL) {
+        cci->bg.runtime = 10 * 1000UL;
+    } else {
+        cci->bg.runtime = 2 * 1000UL;
+    }
+    /* keep relevant context for bg completion */
+    cci->fw.curr_action = fw_transfer->action;
+    cci->fw.curr_slot = fw_transfer->slot;
+    *len_out = 0;
+
+    return CXL_MBOX_BG_STARTED;
+}
+
+static void __do_firmware_xfer(CXLCCI *cci)
+{
+    switch (cci->fw.curr_action) {
+    case CXL_FW_XFER_ACTION_FULL:
+    case CXL_FW_XFER_ACTION_END:
+        cci->fw.slot[cci->fw.curr_slot - 1] = true;
+        cci->fw.transferring = false;
+        break;
+    case CXL_FW_XFER_ACTION_INIT:
+    case CXL_FW_XFER_ACTION_CONTINUE:
+        time(&cci->fw.last_partxfer);
+        break;
+    default:
+        break;
+    }
+}
+
+/* CXL r3.1 section 8.2.9.3.3: Activate FW (Opcode 0202h) */
+static CXLRetCode cmd_firmware_update_activate(const struct cxl_cmd *cmd,
+                                               uint8_t *payload_in,
+                                               size_t len,
+                                               uint8_t *payload_out,
+                                               size_t *len_out,
+                                               CXLCCI *cci)
+{
+    struct {
+        uint8_t action;
+        uint8_t slot;
+    } QEMU_PACKED *fw_activate = (void *)payload_in;
+    QEMU_BUILD_BUG_ON(sizeof(*fw_activate) != 0x2);
+
+    if (fw_activate->slot == 0 ||
+        fw_activate->slot == cci->fw.active_slot ||
+        fw_activate->slot > CXL_FW_SLOTS) {
+        return CXL_MBOX_FW_INVALID_SLOT;
+    }
+
+    /* ensure that an actual fw package is there */
+    if (!cci->fw.slot[fw_activate->slot - 1]) {
+        return CXL_MBOX_FW_INVALID_SLOT;
+    }
+
+    switch (fw_activate->action) {
+    case 0: /* online */
+        cci->fw.active_slot = fw_activate->slot;
+        break;
+    case 1: /* reset */
+        cci->fw.staged_slot = fw_activate->slot;
+        break;
+    default:
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    return CXL_MBOX_SUCCESS;
+}
+
 /* CXL r3.1 Section 8.2.9.4.1: Get Timestamp (Opcode 0300h) */
 static CXLRetCode cmd_timestamp_get(const struct cxl_cmd *cmd,
                                     uint8_t *payload_in,
@@ -2501,6 +2683,10 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
                                       ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHANGE },
     [FIRMWARE_UPDATE][GET_INFO] = { "FIRMWARE_UPDATE_GET_INFO",
         cmd_firmware_update_get_info, 0, 0 },
+    [FIRMWARE_UPDATE][TRANSFER] = { "FIRMWARE_UPDATE_TRANSFER",
+        cmd_firmware_update_transfer, ~0, CXL_MBOX_BACKGROUND_OPERATION },
+    [FIRMWARE_UPDATE][ACTIVATE] = { "FIRMWARE_UPDATE_ACTIVATE",
+        cmd_firmware_update_activate, 2, CXL_MBOX_BACKGROUND_OPERATION },
     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
     [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set,
                          8, CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
@@ -2629,7 +2815,9 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
                 h == cmd_media_get_poison_list ||
                 h == cmd_media_inject_poison ||
                 h == cmd_media_clear_poison ||
-                h == cmd_sanitize_overwrite) {
+                h == cmd_sanitize_overwrite ||
+                h == cmd_firmware_update_transfer ||
+                h == cmd_firmware_update_activate) {
                 return CXL_MBOX_MEDIA_DISABLED;
             }
         }
@@ -2674,6 +2862,9 @@ static void bg_timercb(void *opaque)
         cci->bg.complete_pct = 100;
         cci->bg.ret_code = ret;
         switch (cci->bg.opcode) {
+        case 0x0201: /* fw transfer */
+            __do_firmware_xfer(cci);
+            break;
         case 0x4400: /* sanitize */
         {
             CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
@@ -2745,6 +2936,10 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
     cci->bg.runtime = 0;
     cci->bg.timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
                                  bg_timercb, cci);
+
+    memset(&cci->fw, 0, sizeof(cci->fw));
+    cci->fw.active_slot = 1;
+    cci->fw.slot[cci->fw.active_slot - 1] = true;
 }
 
 static void cxl_copy_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmds)[256])
-- 
2.43.0


