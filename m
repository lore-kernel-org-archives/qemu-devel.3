Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8EA10D14A3
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7AsY-00019J-UK; Mon, 30 Mar 2026 07:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jaemyung.lee@samsung.com>)
 id 1w7AsX-000190-NG
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:33:57 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jaemyung.lee@samsung.com>)
 id 1w7AsT-0001Rc-LZ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:33:57 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20260330113350epoutp0469e5b7e25d2642c874fa359a65255401~hm0C33BNo3269332693epoutp04y
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 11:33:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20260330113350epoutp0469e5b7e25d2642c874fa359a65255401~hm0C33BNo3269332693epoutp04y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1774870430;
 bh=gczioRrcSTxNgslueZB38Od9SCsDV8D0L/VBI/AswqU=;
 h=Subject:Reply-To:From:To:CC:Date:References:From;
 b=SgT8nBqj2Xnuvuv3Fc7jq7ZRM88PX2NVdxQS7dqzrYCqzN0elYxx99R68Z1u4V5Hq
 J4wAeGarVQZPidNEqZ0nf6US6AH5hVFOvmq28XveNsNy43PheD7G6Mu+wWn+wa4UjK
 D2RwLNb0phORWFf3LqFIcpz87LvmaRqDQ7Le+78E=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
 20260330113350epcas2p1d1d8f779843490ffb40160c9187d81e3~hm0CfPhG61781117811epcas2p1G;
 Mon, 30 Mar 2026 11:33:50 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.38.203]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4fkpzd4r2kz6B9m7; Mon, 30 Mar
 2026 11:33:49 +0000 (GMT)
Mime-Version: 1.0
Subject: [PATCH 4/5] hw/ufs: Add UFS Write Booster Support
From: Jaemyung Lee <jaemyung.lee@samsung.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Jeuk Kim <jeuk20.kim@samsung.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "hreitz@redhat.com" <hreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "farosas@suse.de"
 <farosas@suse.de>, "lvivier@redhat.com" <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260330113348epcms2p2d7a91b4e09f78a4fce6d3cd5514e2871@epcms2p2>
Date: Mon, 30 Mar 2026 20:33:48 +0900
X-CMS-MailID: 20260330113348epcms2p2d7a91b4e09f78a4fce6d3cd5514e2871
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260330112748epcms2p1717e93009f7fb87a8156ee07a9400502
References: <CGME20260330112748epcms2p1717e93009f7fb87a8156ee07a9400502@epcms2p2>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=jaemyung.lee@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: jaemyung.lee@samsung.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add UFS Write Booster implementation which follows UFS 4.1 Spec.

Signed-off-by: Jaemyung Lee <jameyung.lee@samsung.com>
---
 hw/ufs/lu.c         |  85 ++++++++++++
 hw/ufs/ufs.c        | 330 +++++++++++++++++++++++++++++++++++++++++---
 hw/ufs/ufs.h        |  39 ++++++
 include/block/ufs.h |  51 +++++++
 4 files changed, 486 insertions(+), 19 deletions(-)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 3f3c9589ce..7c25c15169 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -247,6 +247,89 @@ static UfsReqResult ufs_emulate_scsi_cmd(UfsLu *lu, UfsRequest *req)
     return UFS_REQUEST_SUCCESS;
 }

+#define UFS_GROUP_NUMBER_MASK 0x1F
+#define UFS_WB_GROUP_NUMBER_PINNED 0x18 /* 11000b */
+static bool ufs_wb_check_write_pinned(UfsHc *u, UfsRequest *req)
+{
+    uint8_t group_number = req->req_upiu.sc.cdb[6] & UFS_GROUP_NUMBER_MASK;
+
+    if (u->attributes.wb_buffer_partial_flush_mode != UFS_WB_FLUSH_PINNED) {
+        return false;
+    }
+
+    return (group_number == UFS_WB_GROUP_NUMBER_PINNED);
+}
+
+#define UFS_WB_TOTAL_WRITTEN_SHIFT 21 /* 10MB */
+static void ufs_wb_process_write_pinned(UfsHc *u, UfsRequest *req)
+{
+    UfsWb *wb = &u->wb;
+    uint64_t remain_bytes, remain_data;
+    uint32_t total_written;
+
+    if (!wb->pinned_curr_bytes) {
+        return;
+    }
+
+    if (wb->pinned_used_bytes >= wb->pinned_curr_bytes) {
+        return;
+    }
+
+    remain_bytes = wb->pinned_curr_bytes - wb->pinned_used_bytes;
+    if (remain_bytes >= req->data_len) {
+        wb->pinned_total_written_bytes += req->data_len;
+        wb->pinned_used_bytes += req->data_len;
+        remain_data = 0;
+
+    } else {
+        wb->pinned_total_written_bytes += remain_bytes;
+        wb->pinned_used_bytes += remain_bytes;
+        remain_data = req->data_len - remain_bytes;
+    }
+
+    total_written = wb->pinned_total_written_bytes >> UFS_WB_TOTAL_WRITTEN_SHIFT;
+    u->attributes.pinned_wb_cumm_written_size = cpu_to_be32(total_written);
+
+    remain_bytes = wb->curr_bytes - wb->used_bytes;
+    wb->used_bytes += MIN(remain_bytes, remain_data);
+}
+
+static void ufs_wb_process_write_normal(UfsHc *u, UfsRequest *req)
+{
+    UfsWb *wb = &u->wb;
+    uint64_t curr_bytes, used_bytes, remain_bytes;
+
+    if (!wb->curr_bytes) {
+        return;
+    }
+
+    curr_bytes = wb->curr_bytes - wb->pinned_curr_bytes;
+    used_bytes = wb->used_bytes - wb->pinned_used_bytes;
+
+    if (used_bytes >= curr_bytes) {
+        return;
+    }
+
+    remain_bytes = curr_bytes - used_bytes;
+    wb->used_bytes += MIN(remain_bytes, req->data_len);
+}
+
+static void ufs_wb_process_write_cmd(UfsRequest *req)
+{
+    uint8_t command = req->req_upiu.sc.cdb[0];
+    UfsHc *u = req->hc;
+
+    if (command != WRITE_10 || !u->flags.wb_en) {
+        return;
+    }
+
+    if (ufs_wb_check_write_pinned(u, req)) {
+        ufs_wb_process_write_pinned(u, req);
+    } else {
+        ufs_wb_process_write_normal(u, req);
+    }
+}
+
 static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
 {
     uint8_t task_tag = req->req_upiu.header.task_tag;
@@ -261,6 +344,8 @@ static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
         return ufs_emulate_scsi_cmd(lu, req);
     }

+    ufs_wb_process_write_cmd(req);
+
     SCSIRequest *scsi_req =
         scsi_req_new(lu->scsi_dev, task_tag, lu->lun, req->req_upiu.sc.cdb,
                      UFS_CDB_SIZE, req);
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 19438c89e1..22a8e39617 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -996,11 +996,15 @@ static const int flag_permission[UFS_QUERY_FLAG_IDN_COUNT] = {
     [UFS_QUERY_FLAG_IDN_FPHYRESOURCEREMOVAL] = UFS_QUERY_FLAG_READ,
     [UFS_QUERY_FLAG_IDN_BUSY_RTC] = UFS_QUERY_FLAG_READ,
     [UFS_QUERY_FLAG_IDN_PERMANENTLY_DISABLE_FW_UPDATE] = UFS_QUERY_FLAG_READ,
-    /* Write Booster is not supported */
-    [UFS_QUERY_FLAG_IDN_WB_EN] = UFS_QUERY_FLAG_READ,
-    [UFS_QUERY_FLAG_IDN_WB_BUFF_FLUSH_EN] = UFS_QUERY_FLAG_READ,
+    [UFS_QUERY_FLAG_IDN_WB_EN] = UFS_QUERY_FLAG_READ | UFS_QUERY_FLAG_SET |
+                                 UFS_QUERY_FLAG_CLEAR | UFS_QUERY_FLAG_TOGGLE,
+    [UFS_QUERY_FLAG_IDN_WB_BUFF_FLUSH_EN] =
+        UFS_QUERY_FLAG_READ | UFS_QUERY_FLAG_SET | UFS_QUERY_FLAG_CLEAR |
+        UFS_QUERY_FLAG_TOGGLE,
     [UFS_QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8] = UFS_QUERY_FLAG_READ,
-    [UFS_QUERY_FLAG_IDN_UNPIN_EN] = UFS_QUERY_FLAG_READ,
+    [UFS_QUERY_FLAG_IDN_UNPIN_EN] = UFS_QUERY_FLAG_READ | UFS_QUERY_FLAG_SET |
+                                    UFS_QUERY_FLAG_CLEAR |
+                                    UFS_QUERY_FLAG_TOGGLE,
 };

 static inline QueryRespCode ufs_flag_check_idn_valid(uint8_t idn, int op)
@@ -1097,6 +1101,9 @@ static QueryRespCode ufs_write_flag_value(UfsHc *u, uint8_t idn, uint8_t value)
     case UFS_QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8:
         u->flags.wb_buffer_flush_during_hibernate = value;
         break;
+    case UFS_QUERY_FLAG_IDN_UNPIN_EN:
+        u->flags.unpin_en = value;
+        break;
     default:
         return UFS_QUERY_RESULT_INVALID_VALUE;
     }
@@ -1189,16 +1196,20 @@ static const int attr_permission[UFS_QUERY_ATTR_IDN_COUNT] = {
     [UFS_QUERY_ATTR_IDN_HID_PROG_RATIO] = UFS_QUERY_ATTR_READ,
     [UFS_QUERY_ATTR_IDN_HID_STATE] = UFS_QUERY_ATTR_READ,
     [UFS_QUERY_ATTR_IDN_WB_BUFF_RESIZE_HINT] = UFS_QUERY_ATTR_READ,
-    [UFS_QUERY_ATTR_IDN_WB_BUFF_RESIZE_EN] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_WB_BUFF_RESIZE_EN] = UFS_QUERY_ATTR_WRITE,
     [UFS_QUERY_ATTR_IDN_WB_BUFF_RESIZE_STATUS] = UFS_QUERY_ATTR_READ,
-    [UFS_QUERY_ATTR_IDN_WB_BUFF_PARTIAL_FLUSH_MODE] = UFS_QUERY_ATTR_READ,
-    [UFS_QUERY_ATTR_IDN_MAX_FIFO_WB_PARTIAL_FLUSH_MODE] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_WB_BUFF_PARTIAL_FLUSH_MODE] =
+        UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR_WRITE,
+    [UFS_QUERY_ATTR_IDN_MAX_FIFO_WB_PARTIAL_FLUSH_MODE] =
+        UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR_WRITE,
     [UFS_QUERY_ATTR_IDN_CURR_FIFO_WB_PARTIAL_FLUSH_MODE] = UFS_QUERY_ATTR_READ,
     [UFS_QUERY_ATTR_IDN_PINNED_WB_BUFF_CURR_ALLOC_UNITS] = UFS_QUERY_ATTR_READ,
     [UFS_QUERY_ATTR_IDN_PINNED_WB_BUFF_AVAIL_PERCENT] = UFS_QUERY_ATTR_READ,
     [UFS_QUERY_ATTR_IDN_PINNED_WB_CUMM_WRITTEN_SIZE] = UFS_QUERY_ATTR_READ,
-    [UFS_QUERY_ATTR_IDN_PINNED_WB_NUM_ALLOC_UNITS] = UFS_QUERY_ATTR_READ,
-    [UFS_QUERY_ATTR_IDN_NON_PINNED_WB_MIN_NUM_ALLOC_UNITS] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_PINNED_WB_NUM_ALLOC_UNITS] =
+        UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR_WRITE,
+    [UFS_QUERY_ATTR_IDN_NON_PINNED_WB_MIN_NUM_ALLOC_UNITS] =
+        UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR_WRITE,
 };

 static inline QueryRespCode ufs_attr_check_idn_valid(uint8_t idn, int op)
@@ -1238,6 +1249,27 @@ static inline uint8_t ufs_read_device_temp(UfsHc *u)
     return 0;
 }

+static inline uint32_t ufs_wb_read_flush_status(UfsHc *u)
+{
+    if (u->attributes.wb_buffer_flush_status == UFS_WB_FLUSH_SUSPENDED ||
+        u->attributes.wb_buffer_flush_status == UFS_WB_FLUSH_COMPLETED ||
+        u->attributes.wb_buffer_flush_status == UFS_WB_FLUSH_FAILED) {
+        u->attributes.wb_buffer_flush_status = UFS_WB_FLUSH_IDLE;
+    }
+
+    return u->attributes.wb_buffer_flush_status;
+}
+
+static inline uint32_t ufs_wb_read_resize_status(UfsHc *u)
+{
+    if (u->attributes.wb_buffer_resize_status == UFS_WB_RESIZE_COMPLETED ||
+        u->attributes.wb_buffer_resize_status == UFS_WB_RESIZE_FAILED) {
+        u->attributes.wb_buffer_resize_status = UFS_WB_RESIZE_IDLE;
+    }
+
+    return u->attributes.wb_buffer_resize_status;
+}
+
 static uint32_t ufs_read_attr_value(UfsHc *u, uint8_t idn)
 {
     switch (idn) {
@@ -1292,7 +1324,7 @@ static uint32_t ufs_read_attr_value(UfsHc *u, uint8_t idn)
     case UFS_QUERY_ATTR_IDN_THROTTLING_STATUS:
         return u->attributes.throttling_status;
     case UFS_QUERY_ATTR_IDN_WB_FLUSH_STATUS:
-        return u->attributes.wb_buffer_flush_status;
+        return ufs_wb_read_flush_status(u);
     case UFS_QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE:
         return u->attributes.available_wb_buffer_size;
     case UFS_QUERY_ATTR_IDN_WB_BUFF_LIFE_TIME_EST:
@@ -1323,10 +1355,8 @@ static uint32_t ufs_read_attr_value(UfsHc *u, uint8_t idn)
         return u->attributes.hid_state;
     case UFS_QUERY_ATTR_IDN_WB_BUFF_RESIZE_HINT:
         return u->attributes.wb_buffer_resize_hint;
-    case UFS_QUERY_ATTR_IDN_WB_BUFF_RESIZE_EN:
-        return u->attributes.wb_buffer_resize_en;
     case UFS_QUERY_ATTR_IDN_WB_BUFF_RESIZE_STATUS:
-        return u->attributes.wb_buffer_resize_status;
+        return ufs_wb_read_resize_status(u);
     case UFS_QUERY_ATTR_IDN_WB_BUFF_PARTIAL_FLUSH_MODE:
         return u->attributes.wb_buffer_partial_flush_mode;
     case UFS_QUERY_ATTR_IDN_MAX_FIFO_WB_PARTIAL_FLUSH_MODE:
@@ -1347,6 +1377,31 @@ static uint32_t ufs_read_attr_value(UfsHc *u, uint8_t idn)
     return 0;
 }

+static void ufs_wb_resize_op(UfsHc *u, uint32_t value)
+{
+    if (u->attributes.wb_buffer_resize_status == UFS_WB_RESIZE_IN_PROGRESS) {
+        return;
+    }
+
+    u->attributes.wb_buffer_resize_en = value;
+    u->attributes.wb_buffer_resize_status = UFS_WB_RESIZE_IN_PROGRESS;
+}
+
+static void ufs_wb_pinned_max_size(UfsHc *u, uint32_t value)
+{
+    UfsWb *wb = &u->wb;
+
+    u->attributes.pinned_wb_num_alloc_units = cpu_to_be32(value);
+    wb->pinned_max_bytes = ufs_unit_to_byte(u, value);
+}
+
+static void ufs_wb_pinned_min_size(UfsHc *u, uint32_t value)
+{
+    UfsWb *wb = &u->wb;
+
+    u->attributes.non_pinned_wb_min_num_alloc_units = cpu_to_be32(value);
+    wb->pinned_min_bytes = ufs_unit_to_byte(u, value);
+}
+
 static QueryRespCode ufs_write_attr_value(UfsHc *u, uint8_t idn, uint32_t value)
 {
     switch (idn) {
@@ -1383,6 +1438,27 @@ static QueryRespCode ufs_write_attr_value(UfsHc *u, uint8_t idn, uint32_t value)
     case UFS_QUERY_ATTR_IDN_TIMESTAMP:
         u->attributes.timestamp = cpu_to_be64(value);
         break;
+    case UFS_QUERY_ATTR_IDN_WB_BUFF_RESIZE_EN:
+        if (value >= UFS_WB_RESIZE_OP_MAX) {
+            return UFS_QUERY_RESULT_INVALID_VALUE;
+        }
+        ufs_wb_resize_op(u, value);
+        break;
+    case UFS_QUERY_ATTR_IDN_WB_BUFF_PARTIAL_FLUSH_MODE:
+        if (value >= UFS_WB_FLUSH_MODE_MAX) {
+            return UFS_QUERY_RESULT_INVALID_VALUE;
+        }
+        u->attributes.wb_buffer_partial_flush_mode = value;
+        break;
+    case UFS_QUERY_ATTR_IDN_MAX_FIFO_WB_PARTIAL_FLUSH_MODE:
+        u->attributes.max_fifo_wb_partial_flush_mode = cpu_to_be32(value);
+        break;
+    case UFS_QUERY_ATTR_IDN_PINNED_WB_NUM_ALLOC_UNITS:
+        ufs_wb_pinned_max_size(u, value);
+        break;
+    case UFS_QUERY_ATTR_IDN_NON_PINNED_WB_MIN_NUM_ALLOC_UNITS:
+        ufs_wb_pinned_min_size(u, value);
+        break;
     default:
         g_assert_not_reached();
         return 0;
@@ -1801,11 +1877,174 @@ static void ufs_sendback_req(void *opaque)
     ufs_irq_check(u);
 }

+static inline void ufs_wb_update_avail_buffer(UfsHc *u)
+{
+    UfsWb *wb = &u->wb;
+    uint64_t non_pinned_curr_bytes, non_pinned_used_bytes;
+    uint32_t units;
+
+    units = ufs_byte_to_unit(u, wb->pinned_curr_bytes);
+    u->attributes.pinned_wb_buffer_curr_alloc_units = cpu_to_be32(units);
+
+    if (!wb->pinned_curr_bytes)
+        u->attributes.pinned_wb_buffer_avail_percent = 0;
+    else
+        u->attributes.pinned_wb_buffer_avail_percent =
+            (wb->pinned_curr_bytes - wb->pinned_used_bytes) * 10 /
+            wb->pinned_curr_bytes;
+
+    non_pinned_curr_bytes = wb->curr_bytes - wb->pinned_curr_bytes;
+    non_pinned_used_bytes = wb->used_bytes - wb->pinned_used_bytes;
+
+    units = ufs_byte_to_unit(u, non_pinned_curr_bytes);
+    u->attributes.current_wb_buffer_size = cpu_to_be32(units);
+
+    if (!non_pinned_curr_bytes)
+        u->attributes.available_wb_buffer_size = 0;
+    else
+        u->attributes.available_wb_buffer_size =
+            (non_pinned_curr_bytes - non_pinned_used_bytes) * 10 /
+            non_pinned_curr_bytes;
+}
+
+static inline bool ufs_wb_is_flush_needed(UfsHc *u, uint64_t *no_flush_bytes)
+{
+    UfsWb *wb = &u->wb;
+    uint32_t max_unit;
+
+    switch (u->attributes.wb_buffer_partial_flush_mode) {
+    case UFS_WB_FLUSH_NONE:
+        *no_flush_bytes = 0;
+        break;
+    case UFS_WB_FLUSH_FIFO:
+        max_unit = be32_to_cpu(u->attributes.max_fifo_wb_partial_flush_mode);
+        *no_flush_bytes = ufs_unit_to_byte(u, max_unit);
+        break;
+    case UFS_WB_FLUSH_PINNED:
+        *no_flush_bytes = (u->flags.unpin_en) ? 0 : wb->pinned_used_bytes;
+        break;
+    default:
+        g_assert_not_reached();
+        break;
+    }
+
+    return wb->used_bytes > *no_flush_bytes;
+}
+
+#define UFS_WB_FLUSH_BYTES (4096 * 1024)
+static void ufs_wb_process_flush(UfsHc *u)
+{
+    UfsWb *wb = &u->wb;
+    uint64_t flush_bytes, no_flush_bytes;
+
+    switch (u->attributes.wb_buffer_flush_status) {
+    case UFS_WB_FLUSH_IDLE:
+        if (u->flags.wb_buffer_flush_en &&
+            ufs_wb_is_flush_needed(u, &no_flush_bytes)) {
+            u->attributes.wb_buffer_flush_status = UFS_WB_FLUSH_IN_PROGRESS;
+        }
+
+        break;
+    case UFS_WB_FLUSH_IN_PROGRESS:
+        if (!u->flags.wb_buffer_flush_en) {
+            u->attributes.wb_buffer_flush_status = UFS_WB_FLUSH_FAILED;
+
+        } else if (!ufs_wb_is_flush_needed(u, &no_flush_bytes)) {
+            u->attributes.wb_buffer_flush_status = UFS_WB_FLUSH_COMPLETED;
+
+        } else if (wb->pinned_used_bytes && u->flags.unpin_en) {
+            flush_bytes = MIN(wb->pinned_used_bytes, UFS_WB_FLUSH_BYTES);
+            wb->pinned_used_bytes -= flush_bytes;
+            wb->used_bytes -= flush_bytes;
+
+        } else {
+            flush_bytes = MIN(wb->used_bytes - no_flush_bytes, UFS_WB_FLUSH_BYTES);
+            wb->used_bytes -= flush_bytes;
+        }
+
+        break;
+    case UFS_WB_FLUSH_COMPLETED:
+        if (ufs_wb_is_flush_needed(u, &no_flush_bytes)) {
+            u->attributes.wb_buffer_flush_status =
+                (u->flags.wb_buffer_flush_en) ? UFS_WB_FLUSH_IDLE :
+                                                UFS_WB_FLUSH_IN_PROGRESS;
+        }
+    }
+}
+
+static void ufs_wb_process_resize(UfsHc *u)
+{
+    UfsWb *wb = &u->wb;
+
+    if (u->attributes.wb_buffer_resize_status != UFS_WB_RESIZE_IN_PROGRESS) {
+        return;
+    }
+
+    switch (u->attributes.wb_buffer_resize_en) {
+    case UFS_WB_DECREASE:
+        if (wb->curr_bytes <= wb->min_bytes) {
+            u->attributes.wb_buffer_resize_status = UFS_WB_RESIZE_FAILED;
+            return;
+
+        } else if (wb->curr_bytes <= wb->used_bytes) {
+            u->attributes.wb_buffer_resize_status = UFS_WB_RESIZE_FAILED;
+            return;
+        }
+
+        if (wb->curr_bytes - wb->used_bytes >= wb->resize_bytes) {
+            wb->curr_bytes -= wb->resize_bytes;
+        } else {
+            wb->curr_bytes = wb->used_bytes;
+        }
+
+        if (wb->curr_bytes < wb->min_bytes) {
+            wb->curr_bytes = wb->min_bytes;
+        }
+
+        break;
+    case UFS_WB_INCREASE:
+        if (wb->curr_bytes >= wb->max_bytes) {
+            u->attributes.wb_buffer_resize_status = UFS_WB_RESIZE_FAILED;
+            return;
+        }
+
+        wb->curr_bytes += wb->resize_bytes;
+        if (wb->curr_bytes >= wb->max_bytes) {
+            wb->curr_bytes = wb->max_bytes;
+        }
+
+        break;
+    default:
+        g_assert_not_reached();
+        break;
+    }
+
+    u->attributes.wb_buffer_resize_status = UFS_WB_RESIZE_COMPLETED;
+}
+
+static void ufs_wb_process_pinned(UfsHc *u)
+{
+    UfsWb *wb = &u->wb;
+    uint64_t avail_bytes;
+
+    avail_bytes = wb->curr_bytes - wb->used_bytes + wb->pinned_used_bytes;
+
+    if ((u->attributes.wb_buffer_partial_flush_mode != UFS_WB_FLUSH_PINNED) ||
+        (wb->curr_bytes <= wb->pinned_min_bytes)) {
+        wb->pinned_curr_bytes = 0;
+        wb->pinned_used_bytes = 0;
+
+    } else if (avail_bytes <= wb->pinned_max_bytes) {
+        wb->pinned_curr_bytes = avail_bytes;
+
+    } else {
+        wb->pinned_curr_bytes = wb->pinned_max_bytes;
+    }
+}
+
 /* IDLE */
 static void ufs_process_idle(UfsHc *u)
 {
-    /* Currently do nothing */
-    return;
+    ufs_wb_process_flush(u);
+    ufs_wb_process_resize(u);
+    ufs_wb_process_pinned(u);
+    ufs_wb_update_avail_buffer(u);
 }

 static inline bool ufs_check_idle(UfsHc *u)
@@ -1832,7 +2071,7 @@ static inline bool ufs_mcq_check_idle(UfsHc *u)
 static void ufs_idle_timer_cb(void *opaque)
 {
     UfsHc *u = opaque;
-    int64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+    int64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT);

     if (ufs_check_idle(u) && ufs_mcq_check_idle(u)) {
         ufs_process_idle(u);
@@ -1898,12 +2137,43 @@ static void ufs_init_state(UfsHc *u)
     }
 }

+static void ufs_wb_init(UfsHc *u)
+{
+    UfsWb *wb = &u->wb;
+
+    wb->max_bytes = ufs_unit_to_byte(u, u->params.wb_max_size);
+    wb->min_bytes = ufs_unit_to_byte(u, u->params.wb_min_size);
+
+    wb->curr_bytes = wb->max_bytes;
+    wb->used_bytes = 0;
+    wb->resize_bytes = (wb->max_bytes - wb->min_bytes) / 10;
+
+    u->attributes.wb_buffer_flush_status = UFS_WB_FLUSH_IDLE;
+    u->attributes.available_wb_buffer_size = 0xA;
+    u->attributes.wb_buffer_life_time_est = 0x1;
+    u->attributes.current_wb_buffer_size = cpu_to_be32(u->params.wb_max_size);
+
+    u->attributes.wb_buffer_resize_hint = UFS_WB_HINT_KEEP;
+    u->attributes.wb_buffer_resize_status = UFS_WB_RESIZE_IDLE;
+
+    u->attributes.wb_buffer_partial_flush_mode = UFS_WB_FLUSH_NONE;
+
+    wb->pinned_curr_bytes = 0;
+    wb->pinned_used_bytes = 0;
+    wb->pinned_min_bytes = 0;
+    wb->pinned_total_written_bytes = 0;
+}
+
 static void ufs_init_hc(UfsHc *u)
 {
     uint32_t cap = 0;
     uint32_t mcqconfig = 0;
     uint32_t mcqcap = 0;
-    int64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+    uint32_t ext_wb_sup = WB_RESIZE | WB_FIFO | WB_PINNED;
+    uint32_t ext_ufs_feat_sup = UFS_DEV_WB_SUPPORT |
+                                UFS_DEV_HIGH_TEMP_NOTIF |
+                                UFS_DEV_LOW_TEMP_NOTIF;
+    int64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT);

     u->reg_size = pow2ceil(ufs_reg_size(u));

@@ -1964,8 +2234,13 @@ static void ufs_init_hc(UfsHc *u)
         UFS_DEV_LOW_TEMP_NOTIF;
     u->device_desc.queue_depth = u->params.nutrs;
     u->device_desc.product_revision_level = 0x04;
+    u->device_desc.extended_wb_support |= cpu_to_be16(ext_wb_sup);
     u->device_desc.extended_ufs_features_support =
-        cpu_to_be32(UFS_DEV_HIGH_TEMP_NOTIF | UFS_DEV_LOW_TEMP_NOTIF);
+        cpu_to_be32((ext_ufs_feat_sup));
+    u->device_desc.write_booster_buffer_preserve_user_space_en = 0x01;
+    u->device_desc.write_booster_buffer_type = 0x01;
+    u->device_desc.num_shared_write_booster_buffer_alloc_units =
+        cpu_to_be32(0x400); /* 4GB */

     memset(&u->geometry_desc, 0, sizeof(GeometryDescriptor));
     u->geometry_desc.length = sizeof(GeometryDescriptor);
@@ -1981,6 +2256,16 @@ static void ufs_init_hc(UfsHc *u)
         0x0; /* out-of-order data transfer is not supported */
     u->geometry_desc.max_context_id_number = 0x5;
     u->geometry_desc.supported_memory_types = cpu_to_be16(0x8001);
+    u->geometry_desc.write_booster_buffer_max_n_alloc_units =
+        cpu_to_be32(u->params.wb_max_size);
+    u->geometry_desc.device_max_write_booster_l_us =
+        u->params.wb_max_lus;
+    u->geometry_desc.write_booster_buffer_cap_adj_fac =
+        u->params.wb_cap_adj_fac;
+    u->geometry_desc.supported_write_booster_buffer_user_space_reduction_types =
+        u->params.wb_reduction;
+    u->geometry_desc.supported_write_booster_buffer_types =
+        0x1; /* lu-dedicated buffer type is not supported */

     memset(&u->attributes, 0, sizeof(u->attributes));
     u->attributes.max_data_in_size = 0x08;
@@ -1995,13 +2280,15 @@ static void ufs_init_hc(UfsHc *u)
     memset(&u->flags, 0, sizeof(u->flags));
     u->flags.permanently_disable_fw_update = 1;

+    ufs_wb_init(u);
+
     /*
      * The temperature value is fixed to UFS_TEMPERATURE and does not change
      * dynamically
      */
     u->temperature = UFS_TEMPERATURE;

-    timer_init_ms(&u->idle_timer, QEMU_CLOCK_VIRTUAL, ufs_idle_timer_cb, u);
+    timer_init_ms(&u->idle_timer, QEMU_CLOCK_VIRTUAL_RT, ufs_idle_timer_cb, u);
     timer_mod(&u->idle_timer, now + UFS_IDLE_TIMER_TICK);
 }

@@ -2060,6 +2347,11 @@ static const Property ufs_props[] = {
     DEFINE_PROP_UINT8("nutmrs", UfsHc, params.nutmrs, 8),
     DEFINE_PROP_BOOL("mcq", UfsHc, params.mcq, false),
     DEFINE_PROP_UINT8("mcq-maxq", UfsHc, params.mcq_maxq, 2),
+    DEFINE_PROP_UINT32("wb-max-size", UfsHc, params.wb_max_size, 0x400),
+    DEFINE_PROP_UINT32("wb-min-size", UfsHc, params.wb_min_size, 0x100),
+    DEFINE_PROP_UINT8("wb-max-lus", UfsHc, params.wb_max_lus, 1),
+    DEFINE_PROP_UINT8("wb-cap-adj-fac", UfsHc, params.wb_cap_adj_fac, 3),
+    DEFINE_PROP_UINT8("wb-reduction", UfsHc, params.wb_reduction, 1),
 };

 static const VMStateDescription ufs_vmstate = {
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index f0b1f8b0e0..a993140567 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -91,6 +91,11 @@ typedef struct UfsParams {
     bool mcq; /* Multiple Command Queue support */
     uint8_t mcq_qcfgptr; /* MCQ Queue Configuration Pointer in MCQCAP */
     uint8_t mcq_maxq; /* MCQ Maximum number of Queues */
+    uint32_t wb_max_size; /* WB Maximum allocation units */
+    uint32_t wb_min_size; /* WB Minimum allocation units */
+    uint8_t wb_max_lus; /* WB Maximum number of LUs */
+    uint8_t wb_cap_adj_fac; /* WB Capacity Adjustment Factor */
+    uint8_t wb_reduction; /* WB User Space Reduction */
 } UfsParams;

 /*
@@ -118,6 +123,24 @@ typedef struct UfsCq {
     QTAILQ_HEAD(, UfsRequest) req_list;
 } UfsCq;

+/*
+ * Extended features
+ */
+typedef struct UfsWb {
+    struct UfsHc *u;
+    uint64_t max_bytes;
+    uint64_t min_bytes;
+    uint64_t curr_bytes;
+    uint64_t used_bytes;
+    uint64_t resize_bytes;
+
+    uint64_t pinned_max_bytes;
+    uint64_t pinned_min_bytes;
+    uint64_t pinned_curr_bytes;
+    uint64_t pinned_used_bytes;
+    uint64_t pinned_total_written_bytes;
+} UfsWb;
+
 typedef struct UfsHc {
     PCIDevice parent_obj;
     UfsBus bus;
@@ -147,6 +170,9 @@ typedef struct UfsHc {
     UfsSq *sq[UFS_MAX_MCQ_QNUM];
     UfsCq *cq[UFS_MAX_MCQ_QNUM];

+    /* Extended features */
+    UfsWb wb;
+
     uint8_t temperature;

     /* IDLE timer */
@@ -212,6 +238,19 @@ static inline bool ufs_mcq_cq_full(UfsHc *u, uint32_t qid)
     return tail == ufs_mcq_cq_head(u, qid);
 }

+static inline uint64_t ufs_unit_to_byte(UfsHc *u, uint32_t unit)
+{
+    return unit * u->geometry_desc.allocation_unit_size *
+           be32_to_cpu(u->geometry_desc.segment_size) * BDRV_SECTOR_SIZE;
+}
+
+static inline uint32_t ufs_byte_to_unit(UfsHc *u, uint64_t byte)
+{
+    return byte / BDRV_SECTOR_SIZE /
+           be32_to_cpu(u->geometry_desc.segment_size) /
+           u->geometry_desc.allocation_unit_size;
+}
+
 #define TYPE_UFS "ufs"
 #define UFS(obj) OBJECT_CHECK(UfsHc, (obj), TYPE_UFS)

diff --git a/include/block/ufs.h b/include/block/ufs.h
index 4dacfb776f..aa0dde8058 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -1126,11 +1126,24 @@ enum health_desc_param {
     UFS_HEALTH_DESC_PARAM_LIFE_TIME_EST_B = 0x4,
 };

+/* Possible values for bUFSFeaturesSupport */
 enum {
     UFS_DEV_HIGH_TEMP_NOTIF = BIT(4),
     UFS_DEV_LOW_TEMP_NOTIF = BIT(5),
 };

+/* Possible values for dExtendedWriteBoosterSupport */
+enum {
+    WB_RESIZE = BIT(0),
+    WB_FIFO = BIT(1),
+    WB_PINNED = BIT(2),
+};
+
+/* Possible values for dExtendedUFSFeaturesSupport */
+enum {
+    UFS_DEV_WB_SUPPORT = BIT(8),
+};
+
 /* WriteBooster buffer mode */
 enum {
     UFS_WB_BUF_MODE_LU_DEDICATED = 0x0,
@@ -1207,6 +1220,44 @@ enum ufs_dev_pwr_mode {
     UFS_DEEPSLEEP_PWR_MODE = 4,
 };

+/* UFS Write Booster */
+enum ufs_wb_flush_status {
+    UFS_WB_FLUSH_IDLE = 0,
+    UFS_WB_FLUSH_IN_PROGRESS = 1,
+    UFS_WB_FLUSH_SUSPENDED = 2,
+    UFS_WB_FLUSH_COMPLETED = 3,
+    UFS_WB_FLUSH_FAILED = 4,
+    UFS_WB_FLUSH_STATUS_MAX,
+};
+
+enum ufs_wb_flush_mode {
+    UFS_WB_FLUSH_NONE = 0,
+    UFS_WB_FLUSH_FIFO = 1,
+    UFS_WB_FLUSH_PINNED = 2,
+    UFS_WB_FLUSH_MODE_MAX,
+};
+
+enum ufs_wb_resize_hint {
+    UFS_WB_HINT_KEEP = 0,
+    UFS_WB_HINT_DECREASE = 1,
+    UFS_WB_HINT_ENCREASE = 2,
+    UFS_WB_RESIZE_HINT_MAX,
+};
+
+enum ufs_wb_resize_op {
+    UFS_WB_DECREASE = 0,
+    UFS_WB_INCREASE = 1,
+    UFS_WB_RESIZE_OP_MAX,
+};
+
+enum ufs_wb_resize_status {
+    UFS_WB_RESIZE_IDLE = 0,
+    UFS_WB_RESIZE_IN_PROGRESS = 1,
+    UFS_WB_RESIZE_COMPLETED = 2,
+    UFS_WB_RESIZE_FAILED = 3,
+    UFS_WB_RESIZE_STATUS_MAX,
+};
+
 /*
  * struct UtpCmdRsp - Response UPIU structure
  * @residual_transfer_count: Residual transfer count DW-3
--
2.34.1

