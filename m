Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EF4FF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABWG-000851-2F; Tue, 07 Apr 2026 14:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wABTm-0004Gt-NF
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:48:50 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wA3g4-0003Mr-3V
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 06:29:02 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-824c9da9928so3860299b3a.3
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 03:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775557738; x=1776162538; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1LF+OEOyk4QHLrmOZ4ySHJ1oxjvYbO7qeGvc/JtrerQ=;
 b=ouFbhqxQ7EEQfzyxMSxL9eU573ESDcKpsYA9Uso+NsUQ3F+0cX5sK8mhS20OESODD5
 /E/LxVehAaDszfypVf4UGzo74Rdni87SCQJXaZE2dWws0XiWOTthUCIh7MzQnYrRSyJa
 a0FQ8AD3hFG1AhWrz84+PGbxG65vs1pFM4GcclhDFf4dqeAE15fIVvpx+4CDr6YkGS02
 HlFHNm3fDeEjCvGPyylc6n57kgViSU0k/JE/F3lrPGz3oyQ5ZKZVULsNd+KR/lB3+Iwt
 aToGl2O3WxioxayjKKLhOZvc13xLql0azXC715wDgsjQ4H5hBiRnHit1FjSQfmMFXEga
 siwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775557738; x=1776162538;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1LF+OEOyk4QHLrmOZ4ySHJ1oxjvYbO7qeGvc/JtrerQ=;
 b=XRcIKrDIRnugQiw/mODZvZcZYzz4WVju5t0LWfSxW/ewO6zuRSrzyNQ5my49+NneX6
 0y1atoSkhxiSBM1fm6TEhO0oHaG9/W0YWSnyg8cQBptQ5eZbQwgvclxoC4aTFRNGvfvF
 CurNYGtAXLNpniFzHUbThDFsGobNxZdrEO5hbPCWBcRgQ37pnvfqx5HB/oWH44XI9CNm
 fIhcScuAFUDp9gq2x/jjax6gFEVnxMrwrE3QQkKiZx6EXXwvqIjqzHIJxSF/WVdYUSyt
 01AOs3mJSqbHjCBmAUtEZAkZCCiCFBEHYamp27wXMXSp8AsPXvosyXEmhoWUnoaryVwz
 qoig==
X-Gm-Message-State: AOJu0YzQNebbDnoxfsyKzIVrsytwJruXbsgxqsJhWLcchuxHfZHs7f1s
 IEvWjVbpZaAM65jALsP3XU6Tr1KcRZLGOv/P9fFNcMFlPEC0Vh2GWilvVqt7EugRfxmvdg==
X-Gm-Gg: AeBDiet89KBwI80/dQeUWQhpwHTGUFMHFQWzcK3liRFLG3SGfGz/vCCF1ayO5rzeJEk
 k9dQxt7bfgFFZ09NoTAcdLZwNwfqMRWmeTMiU6IEU6heEvOc0x+xayTOcseKLXiPvPp18i1ykt5
 87q3z1VoH67YxdRQ54Qn1ZSuPjpp3xlIT0Wx8bE9H9gqKzmdbpfxLAjH9aDpYEWK0OvsR0pRLS6
 S5lfSOKCtZCMDPwmkp8sElH38urVMrroX46l3X7KXCghyP4Hj3iYNRVVEWiHtSy9VuJHuwGGIbF
 NxyyBRP/o/iYzDZgEaT/xs8s6+qUvNPI8qwQ/E48MwbHHDCFd45m5CZ+LHoZlW28sK+t0rM9LxT
 Xil+zoVSocPe/NiMauSD5MZ4GHsBeWPLCJjbuoSYZlGw9VJ4CRNC7tXfBAmWwQK4Zew2jaD2cYp
 73LADueqy+5PhhRVkS+tAezRHAL6rCSQ==
X-Received: by 2002:a05:6a00:3e05:b0:82a:60ad:874 with SMTP id
 d2e1a72fcca58-82d0da5972fmr15507726b3a.19.1775557738377; 
 Tue, 07 Apr 2026 03:28:58 -0700 (PDT)
Received: from [172.17.0.5] ([168.126.243.22])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b2714dsm21217324b3a.1.2026.04.07.03.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 03:28:57 -0700 (PDT)
From: Jaemyung Lee <ldc.jml@gmail.com>
X-Google-Original-From: Jaemyung Lee <jaemyung.lee@samsung.com>
Date: Tue, 07 Apr 2026 19:23:42 +0900
Subject: [PATCH v2 4/5] hw/ufs: Add UFS Write Booster Support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-write_booster-v2-4-dd772bb30194@samsung.com>
References: <20260407-write_booster-v2-0-dd772bb30194@samsung.com>
In-Reply-To: <20260407-write_booster-v2-0-dd772bb30194@samsung.com>
To: qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Jaemyung Lee <jaemyung.lee@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775557727; l=25754;
 i=jaemyung.lee@samsung.com; s=20260402; h=from:subject:message-id;
 bh=H08ksa3f84X0PoRwSgicOjf+OMZih42Lwk6V0+sVl2g=;
 b=0iHD4aPnhZSZz5z+lOuXTeHr6t4iPHLYcjMAN4QgAMBqKYe2xrVlttLS+W3eWmSCwQR3wM3u1
 r/TbD7xTlxBCFZq2yOqaZaZuf3M9jzOzCdaHGbNTORuzZ850l1Zi5Ws
X-Developer-Key: i=jaemyung.lee@samsung.com; a=ed25519;
 pk=bZPd7A/kteUO62FfUM6IrI1LuBPe5QrcqfvsitM1ZjE=
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=ldc.jml@gmail.com; helo=mail-pf1-x42f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add UFS Write Booster implementation which follows UFS 4.1 Spec.

Signed-off-by: Jaemyung Lee <jaemyung.lee@samsung.com>
---
 hw/ufs/ufs.c        | 425 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 hw/ufs/ufs.h        |  47 ++++++
 include/block/ufs.h |  51 +++++++
 3 files changed, 508 insertions(+), 15 deletions(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 5102d9bbab640faded69c93be73cbe319db68646..cfaff454e8eec84c8d171b688679a11e113fb495 100644
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
@@ -1347,6 +1377,32 @@ static uint32_t ufs_read_attr_value(UfsHc *u, uint8_t idn)
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
@@ -1383,6 +1439,27 @@ static QueryRespCode ufs_write_attr_value(UfsHc *u, uint8_t idn, uint32_t value)
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
@@ -1725,6 +1802,98 @@ static void ufs_process_req(void *opaque)
     }
 }
 
+#define UFS_GROUP_NUMBER_MASK 0x1F
+#define UFS_WB_GROUP_NUMBER_DEFAULT 0x00 /* 00000b */
+#define UFS_WB_GROUP_NUMBER_PINNED 0x18 /* 11000b */
+static bool ufs_wb_check_write_pinned(UfsHc *u, UfsRequest *req)
+{
+    uint8_t cmd = req->req_upiu.sc.cdb[0];
+    uint8_t group_number = UFS_WB_GROUP_NUMBER_DEFAULT;
+
+    if (u->attributes.wb_buffer_partial_flush_mode != UFS_WB_FLUSH_PINNED) {
+        return false;
+    }
+
+    if (cmd == WRITE_16) {
+        group_number = req->req_upiu.sc.cdb[14] & UFS_GROUP_NUMBER_MASK;
+
+    } else if (cmd == WRITE_10) {
+        group_number = req->req_upiu.sc.cdb[6] & UFS_GROUP_NUMBER_MASK;
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
+static void ufs_wb_process_write_req(UfsRequest *req)
+{
+    UfsHc *u = req->hc;
+
+    if (!u->flags.wb_en || !ufs_is_write_req(req)) {
+        return;
+    }
+
+    if (ufs_wb_check_write_pinned(u, req)) {
+        ufs_wb_process_write_pinned(u, req);
+
+    } else {
+        ufs_wb_process_write_normal(u, req);
+    }
+}
+
 void ufs_complete_req(UfsRequest *req, UfsReqResult req_result)
 {
     UfsHc *u = req->hc;
@@ -1732,6 +1901,7 @@ void ufs_complete_req(UfsRequest *req, UfsReqResult req_result)
 
     if (req_result == UFS_REQUEST_SUCCESS) {
         req->utrd.header.dword_2 = cpu_to_le32(UFS_OCS_SUCCESS);
+        ufs_wb_process_write_req(req);
     } else {
         req->utrd.header.dword_2 = cpu_to_le32(UFS_OCS_INVALID_CMD_TABLE_ATTR);
     }
@@ -1801,9 +1971,177 @@ static void ufs_sendback_req(void *opaque)
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
 static void ufs_process_idle(UfsHc *u)
 {
-    /* Currently do nothing */
+    ufs_wb_process_flush(u);
+    ufs_wb_process_resize(u);
+    ufs_wb_process_pinned(u);
+    ufs_wb_update_avail_buffer(u);
     return;
 }
 
@@ -1873,6 +2211,10 @@ static bool ufs_check_constraints(UfsHc *u, Error **errp)
         return false;
     }
 
+    if (u->params.wb_min_size > u->params.wb_max_size) {
+        error_setg(errp, "wb-min-size must be less than or equal wb-max-size");
+    }
+
     return true;
 }
 
@@ -1911,11 +2253,42 @@ static void ufs_init_state(UfsHc *u)
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
+    uint32_t ext_wb_sup = WB_RESIZE | WB_FIFO | WB_PINNED;
+    uint32_t ext_ufs_feat_sup = UFS_DEV_WB_SUPPORT |
+                                UFS_DEV_HIGH_TEMP_NOTIF |
+                                UFS_DEV_LOW_TEMP_NOTIF;
     int64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT);
 
     u->reg_size = pow2ceil(ufs_reg_size(u));
@@ -1977,8 +2350,13 @@ static void ufs_init_hc(UfsHc *u)
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
+        cpu_to_be32(u->params.wb_max_size);
 
     memset(&u->geometry_desc, 0, sizeof(GeometryDescriptor));
     u->geometry_desc.length = sizeof(GeometryDescriptor);
@@ -1994,6 +2372,16 @@ static void ufs_init_hc(UfsHc *u)
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
@@ -2008,6 +2396,8 @@ static void ufs_init_hc(UfsHc *u)
     memset(&u->flags, 0, sizeof(u->flags));
     u->flags.permanently_disable_fw_update = 1;
 
+    ufs_wb_init(u);
+
     /*
      * The temperature value is fixed to UFS_TEMPERATURE and does not change
      * dynamically
@@ -2073,6 +2463,11 @@ static const Property ufs_props[] = {
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
index b5f040302129f4d02732ddd20ef82eb33c41922a..42a20245128a765afc2560342135ced81dcc684c 100644
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
 
     QEMUTimer idle_timer;
@@ -211,6 +237,27 @@ static inline bool ufs_mcq_cq_full(UfsHc *u, uint32_t qid)
     return tail == ufs_mcq_cq_head(u, qid);
 }
 
+static inline uint64_t ufs_unit_to_byte(UfsHc *u, uint32_t unit)
+{
+    return (uint64_t)unit * u->geometry_desc.allocation_unit_size *
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
+static inline bool ufs_is_write_req(UfsRequest *req)
+{
+    uint8_t cmd = req->req_upiu.sc.cdb[0];
+
+    /* UFS 4.1 Specifiaction doesn't support WRITE_12 */
+    return (cmd == WRITE_6) || (cmd == WRITE_10) || (cmd == WRITE_16);
+}
+
 #define TYPE_UFS "ufs"
 #define UFS(obj) OBJECT_CHECK(UfsHc, (obj), TYPE_UFS)
 
diff --git a/include/block/ufs.h b/include/block/ufs.h
index 4dacfb776f947a285d86018add82115f148b7dd9..aa0dde805826d0b06ab80fb74034192ba06c2045 100644
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
2.48.1


