Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6853FCD4851
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 08:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNRAK-0004fy-Fm; Thu, 14 May 2026 04:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wNRA7-0004cD-Av
 for qemu-devel@nongnu.org; Thu, 14 May 2026 04:11:21 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wNRA3-0001d2-NP
 for qemu-devel@nongnu.org; Thu, 14 May 2026 04:11:18 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2ba1e9d3687so50761065ad.3
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 01:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778746274; x=1779351074; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Sz9zFadj0eryy1N/x2Rp41/1bN8n6orxsfMSg68s36k=;
 b=dXq9SO4DphHhucqZT7GzPHbWhRxgzLup4ctdcs9GTFvQmwFUOonBYRfVwzOQEUxofj
 GznImhZSVpkbQCF38wPiemLR8Eem4DPTh1ryp6VUJgD253JYlMzZIFy5BmlNNBU934oo
 fv7XsakoDJ7xIh3Hwef/Ywep5W+ProoAk4OVzToaTM2sTpOPrpGl6CAahf7f9PZBbKr/
 tTBWQtS/T3xbPIEkTNMuYmjE4Hi7znoYMwei/5H23RvYXfoE0LTVmXQzcAU1Xz8puQeV
 QYVbtaEAH5czyROXpgoGc9pysEmmqGxu6u6Duyudkzyus+dlvy3KestO3RgJqBSq63HU
 54jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778746274; x=1779351074;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Sz9zFadj0eryy1N/x2Rp41/1bN8n6orxsfMSg68s36k=;
 b=sLofKh9WYj3SrniprAc3dNFLDwe7uDZXaXqAA0i/utSKs8UBVt/NEa2Bg41p7VotGu
 2y3ZBoZJAv6C0SarC0vOMNj8xV5HkH0z5blbflru46pDJPcHWzx0aw3UPG8uzG1o2Xww
 msT0tgGoDDc48V61r98uBawjmXkoIVl9dBcHkG9YxkTAf6L3PIvxxOrMrkJbgIB5/a9g
 FZ+yxrgJyEHWfZJsmoHEJZvYKbBYcULNs0U1oa+4j3VIaxw3DVYCqi1j7MABwGZlrOgB
 QhMAMO+tSLB8WxFYTQWo7W5Bo810oHWDu6aAYRjCmhWLgQpOoIHfP6IXqhyTw+JCspdK
 gVfA==
X-Gm-Message-State: AOJu0YxIubYMic1M+6ITPx5hkiJzbR0gH3tmOYcqIe6ILgMwPbsYUIvt
 BRyghCzz/N9s/xq2FOfxZkAeiKCFh5NXrLDeb07giCooN7QjZXZdUmzV
X-Gm-Gg: Acq92OFm7dg//YIGz9y3aAq7YXRhCGn9Th0YmGzXi8NE2tUpujTGhgH6JBe/LpOsR/f
 fp/OvtcrljhrGsLlL9Ak9nlaZ+xGS6bprpkn+RqAZj8kgt35xE3TgaYbIB9SPGafcGHZZJQBVvU
 EdCioqFENEkec2ZHDyjBLnMnTGDwaPvrniJxoB8X0owJS7KBfYqaNtPShaMheENUUbX1OwtExGS
 UHJKwYKsjMbCtyjU1rYug2Erfaw+YlfxEFyygtBU4vFpmME3BNXJnq4lgijdblhbW1qEHlvtu0t
 XUOsvK9MMBmPRqLSUCs9LpwuKVjYxsdUDSRW8gp+wfM0s14EhMkt331rRH2eYsuT3iP/k8on/oA
 0+sOz064JLCvk28nf/itF07Ues6qCzVsaQduehDCegCk5lkcJkzH9nmfTu7EazWby3hGwmI6Snq
 p6oUUMzFrlu4PTMuuNKkckTPKmP+3a8A==
X-Received: by 2002:a17:902:d486:b0:2b9:87e0:1f80 with SMTP id
 d9443c01a7336-2bd30210d53mr69678485ad.24.1778746273318; 
 Thu, 14 May 2026 01:11:13 -0700 (PDT)
Received: from [172.17.0.5] ([168.126.243.22])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c2631basm14480165ad.34.2026.05.14.01.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 01:11:12 -0700 (PDT)
From: Jaemyung Lee <ldc.jml@gmail.com>
X-Google-Original-From: Jaemyung Lee <jaemyung.lee@samsung.com>
Date: Thu, 14 May 2026 17:10:47 +0900
Subject: [PATCH v7 4/5] hw/ufs: Add UFS Write Booster Support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-write_booster-v7-4-c3ae3452980f@samsung.com>
References: <20260514-write_booster-v7-0-c3ae3452980f@samsung.com>
In-Reply-To: <20260514-write_booster-v7-0-c3ae3452980f@samsung.com>
To: qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Jaemyung Lee <jaemyung.lee@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778746262; l=31293;
 i=jaemyung.lee@samsung.com; s=20260402; h=from:subject:message-id;
 bh=fADtbB20gBW3+kSqBvzGtRoIc5kmaPhtiYA+5a9N5ms=;
 b=anVjcThHzU+FVv0HOgVPlrzRZ+w+Aj94Aky/ywQH0YhafNiDbyCE70yQpUelvbfvwooh3kKgU
 E/KjWCSDKBID0oa0M84DMs3BWT7mPb+pdMDfBGSi5Dw9WZ4peXeNQim
X-Developer-Key: i=jaemyung.lee@samsung.com; a=ed25519;
 pk=bZPd7A/kteUO62FfUM6IrI1LuBPe5QrcqfvsitM1ZjE=
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=ldc.jml@gmail.com; helo=mail-pl1-x62e.google.com
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
 hw/ufs/lu.c         | 102 +++++++++++-
 hw/ufs/ufs.c        | 448 +++++++++++++++++++++++++++++++++++++++++++++++++---
 hw/ufs/ufs.h        |  47 ++++++
 include/block/ufs.h |  55 +++++++
 4 files changed, 632 insertions(+), 20 deletions(-)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 3f3c9589cee57ae3e77e2f486476d5fcec204d80..b33587cc85a1ae64e9b82fffed26bef8530e87e8 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -58,13 +58,113 @@ static void ufs_build_scsi_response_upiu(UfsRequest *req, uint8_t *sense,
                           status, data_segment_length);
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
+static void ufs_wb_process_write_normal(UfsHc *u, uint32_t transfered_len)
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
+    wb->used_bytes += MIN(remain_bytes, transfered_len);
+}
+
+#define UFS_WB_TOTAL_WRITTEN_DIV (10 * 1024 * 1024) /* 10MiB */
+static void ufs_wb_process_write_pinned(UfsHc *u, uint32_t transfered_len)
+{
+    UfsWb *wb = &u->wb;
+    uint64_t remain_bytes, remain_data;
+    uint32_t total_written;
+
+    if (!wb->pinned_curr_bytes) {
+        ufs_wb_process_write_normal(u, transfered_len);
+        return;
+    }
+
+    if (wb->pinned_used_bytes >= wb->pinned_curr_bytes) {
+        ufs_wb_process_write_normal(u, transfered_len);
+        return;
+    }
+
+    remain_bytes = wb->pinned_curr_bytes - wb->pinned_used_bytes;
+    if (remain_bytes >= transfered_len) {
+        wb->pinned_total_written_bytes += transfered_len;
+        wb->pinned_used_bytes += transfered_len;
+        wb->used_bytes += transfered_len;
+        remain_data = 0;
+
+    } else {
+        wb->pinned_total_written_bytes += remain_bytes;
+        wb->pinned_used_bytes += remain_bytes;
+        wb->used_bytes += remain_bytes;
+        remain_data = transfered_len - remain_bytes;
+    }
+
+    total_written = wb->pinned_total_written_bytes / UFS_WB_TOTAL_WRITTEN_DIV;
+    u->attributes.pinned_wb_cumm_written_size = cpu_to_be32(total_written);
+
+    ufs_wb_process_write_normal(u, remain_data);
+}
+
+static void ufs_wb_process_write_req(UfsRequest *req, uint32_t transfered_len)
+{
+    UfsHc *u = req->hc;
+
+    if (!u->flags.wb_en || !ufs_is_write_req(req)) {
+        return;
+    }
+
+    if (ufs_wb_check_write_pinned(u, req)) {
+        ufs_wb_process_write_pinned(u, transfered_len);
+    } else {
+        ufs_wb_process_write_normal(u, transfered_len);
+    }
+
+    ufs_wb_update_avail_buffer(u);
+}
+
 static void ufs_scsi_command_complete(SCSIRequest *scsi_req, size_t resid)
 {
     UfsRequest *req = scsi_req->hba_private;
     int16_t status = scsi_req->status;
-
     uint32_t transfered_len = scsi_req->cmd.xfer - resid;
 
+    /* WB accounting should only happen for successful commands */
+    if (status == GOOD) {
+        ufs_wb_process_write_req(req, transfered_len);
+    }
+
     ufs_build_scsi_response_upiu(req, scsi_req->sense, scsi_req->sense_len,
                                  transfered_len, status);
 
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index c504a0d7e3fb89eb5558cfd9c410cda9396bc3b4..98ff612d9a4df3abb659458e73256e906c968317 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -375,7 +375,12 @@ static void ufs_process_uiccmd(UfsHc *u, uint32_t val)
         u->reg.hcs = FIELD_DP32(u->reg.hcs, HCS, UTMRLRDY, 1);
         u->reg.ucmdarg2 = UFS_UIC_CMD_RESULT_SUCCESS;
         break;
-    /* TODO: Revisit it when Power Management is implemented */
+    /*
+     * TODO: Revisit after PM implementation
+     * Power Management is not supported in current QEMU-UFS,
+     * So Write Booster's Flush during Hibern8 operation is also remained
+     * as not considered.
+     */
     case UFS_UIC_CMD_DME_HIBER_ENTER:
         u->reg.is = FIELD_DP32(u->reg.is, IS, UHES, 1);
         u->reg.hcs = FIELD_DP32(u->reg.hcs, HCS, UPMCRS, UFS_PWR_LOCAL);
@@ -872,6 +877,32 @@ static const MemoryRegionOps ufs_mmio_ops = {
     },
 };
 
+static void ufs_wb_update_ee_status(UfsHc *u, uint16_t *ee_status)
+{
+    UfsWb *wb = &u->wb;
+    uint64_t curr_bytes = wb->curr_bytes - wb->pinned_curr_bytes;
+    uint64_t used_bytes = wb->used_bytes - wb->pinned_used_bytes;
+
+    if (curr_bytes != 0 && used_bytes >= curr_bytes) {
+        *ee_status |= MASK_EE_WB_FLUSH_NEEDED;
+    } else {
+        *ee_status &= ~MASK_EE_WB_FLUSH_NEEDED;
+    }
+
+    if (u->attributes.wb_buffer_resize_hint != UFS_WB_HINT_KEEP) {
+        *ee_status |= MASK_EE_WB_RESIZE_HINT;
+    } else {
+        *ee_status &= ~MASK_EE_WB_RESIZE_HINT;
+    }
+
+    if (wb->pinned_used_bytes != 0 &&
+        wb->pinned_used_bytes >= wb->pinned_curr_bytes) {
+        *ee_status |= MASK_EE_PINNED_WB_FULL;
+    } else {
+        *ee_status &= ~MASK_EE_PINNED_WB_FULL;
+    }
+}
+
 static void ufs_update_ee_status(UfsHc *u)
 {
     uint16_t ee_status = be16_to_cpu(u->attributes.exception_event_status);
@@ -890,6 +921,8 @@ static void ufs_update_ee_status(UfsHc *u)
         ee_status &= ~MASK_EE_TOO_LOW_TEMP;
     }
 
+    ufs_wb_update_ee_status(u, &ee_status);
+
     u->attributes.exception_event_status = cpu_to_be16(ee_status);
 }
 
@@ -996,11 +1029,16 @@ static const int flag_permission[UFS_QUERY_FLAG_IDN_COUNT] = {
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
+    /* TODO: Revisit after PM implementation */
     [UFS_QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8] = UFS_QUERY_FLAG_READ,
-    [UFS_QUERY_FLAG_IDN_UNPIN_EN] = UFS_QUERY_FLAG_READ,
+    [UFS_QUERY_FLAG_IDN_UNPIN_EN] = UFS_QUERY_FLAG_READ | UFS_QUERY_FLAG_SET |
+                                    UFS_QUERY_FLAG_CLEAR |
+                                    UFS_QUERY_FLAG_TOGGLE,
 };
 
 static inline QueryRespCode ufs_flag_check_idn_valid(uint8_t idn, int op)
@@ -1094,8 +1132,8 @@ static QueryRespCode ufs_write_flag_value(UfsHc *u, uint8_t idn, uint8_t value)
     case UFS_QUERY_FLAG_IDN_WB_BUFF_FLUSH_EN:
         u->flags.wb_buffer_flush_en = value;
         break;
-    case UFS_QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8:
-        u->flags.wb_buffer_flush_during_hibernate = value;
+    case UFS_QUERY_FLAG_IDN_UNPIN_EN:
+        u->flags.unpin_en = value;
         break;
     default:
         return UFS_QUERY_RESULT_INVALID_VALUE;
@@ -1189,16 +1227,20 @@ static const int attr_permission[UFS_QUERY_ATTR_IDN_COUNT] = {
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
@@ -1238,6 +1280,31 @@ static inline uint8_t ufs_read_device_temp(UfsHc *u)
     return 0;
 }
 
+static inline uint32_t ufs_wb_read_flush_status(UfsHc *u)
+{
+    uint32_t value = u->attributes.wb_buffer_flush_status;
+
+    if (value == UFS_WB_FLUSH_SUSPENDED ||
+        value == UFS_WB_FLUSH_COMPLETED ||
+        value == UFS_WB_FLUSH_FAILED) {
+        u->attributes.wb_buffer_flush_status = UFS_WB_FLUSH_IDLE;
+    }
+
+    return value;
+}
+
+static inline uint32_t ufs_wb_read_resize_status(UfsHc *u)
+{
+    uint32_t value = u->attributes.wb_buffer_resize_status;
+
+    if (value == UFS_WB_RESIZE_COMPLETED ||
+        value == UFS_WB_RESIZE_FAILED) {
+        u->attributes.wb_buffer_resize_status = UFS_WB_RESIZE_IDLE;
+    }
+
+    return value;
+}
+
 static uint32_t ufs_read_attr_value(UfsHc *u, uint8_t idn)
 {
     switch (idn) {
@@ -1292,7 +1359,7 @@ static uint32_t ufs_read_attr_value(UfsHc *u, uint8_t idn)
     case UFS_QUERY_ATTR_IDN_THROTTLING_STATUS:
         return u->attributes.throttling_status;
     case UFS_QUERY_ATTR_IDN_WB_FLUSH_STATUS:
-        return u->attributes.wb_buffer_flush_status;
+        return ufs_wb_read_flush_status(u);
     case UFS_QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE:
         return u->attributes.available_wb_buffer_size;
     case UFS_QUERY_ATTR_IDN_WB_BUFF_LIFE_TIME_EST:
@@ -1323,10 +1390,8 @@ static uint32_t ufs_read_attr_value(UfsHc *u, uint8_t idn)
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
@@ -1347,6 +1412,132 @@ static uint32_t ufs_read_attr_value(UfsHc *u, uint8_t idn)
     return 0;
 }
 
+static void ufs_wb_resize_op(UfsHc *u, uint32_t value)
+{
+    if (u->attributes.wb_buffer_resize_status == UFS_WB_RESIZE_IN_PROGRESS) {
+        return;
+    }
+
+    if (value == UFS_WB_IDLE) {
+        return;
+    }
+
+    u->attributes.wb_buffer_resize_en = value;
+    u->attributes.wb_buffer_resize_status = UFS_WB_RESIZE_IN_PROGRESS;
+    u->attributes.wb_buffer_resize_hint = UFS_WB_HINT_KEEP;
+}
+
+void ufs_wb_update_avail_buffer(UfsHc *u)
+{
+    UfsWb *wb = &u->wb;
+    uint64_t non_pinned_curr_bytes, non_pinned_used_bytes;
+    uint32_t units;
+
+    units = ufs_byte_to_unit(u, wb->fifo_curr_bytes);
+    u->attributes.curr_fifo_wb_partial_flush_mode = cpu_to_be32(units);
+
+    units = ufs_byte_to_unit(u, wb->pinned_curr_bytes);
+    u->attributes.pinned_wb_buffer_curr_alloc_units = cpu_to_be32(units);
+
+    if (wb->pinned_curr_bytes <= wb->pinned_used_bytes)
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
+
+    assert(wb->curr_bytes >= wb->pinned_curr_bytes);
+    assert(wb->used_bytes >= wb->pinned_used_bytes);
+}
+
+static void ufs_wb_sync_buffer_size(UfsHc *u)
+{
+    UfsWb *wb = &u->wb;
+    uint64_t avail_bytes;
+
+    wb->fifo_curr_bytes = MIN(wb->curr_bytes, wb->fifo_max_bytes);
+    avail_bytes = wb->curr_bytes - wb->used_bytes + wb->pinned_used_bytes;
+
+    if ((u->attributes.wb_buffer_partial_flush_mode != UFS_WB_FLUSH_PINNED) ||
+        (wb->curr_bytes <= wb->non_pinned_min_bytes)) {
+        wb->pinned_curr_bytes = 0;
+        wb->pinned_used_bytes = 0;
+
+    } else if (avail_bytes <= wb->pinned_max_bytes) {
+        wb->pinned_curr_bytes = avail_bytes;
+        wb->pinned_used_bytes = MIN(wb->pinned_curr_bytes,
+                                    wb->pinned_used_bytes);
+
+    } else {
+        wb->pinned_curr_bytes = wb->pinned_max_bytes;
+        wb->pinned_used_bytes = MIN(wb->pinned_curr_bytes,
+                                    wb->pinned_used_bytes);
+    }
+
+    ufs_wb_update_avail_buffer(u);
+}
+
+static bool ufs_wb_max_fifo(UfsHc *u, uint32_t value)
+{
+    UfsWb *wb = &u->wb;
+    uint64_t fifo_max_bytes = ufs_unit_to_byte(u, value);
+
+    if (fifo_max_bytes > wb->max_bytes) {
+        return false;
+    }
+
+    u->attributes.max_fifo_wb_partial_flush_mode = cpu_to_be32(value);
+    wb->fifo_max_bytes = fifo_max_bytes;
+    ufs_wb_sync_buffer_size(u);
+
+    return true;
+}
+
+static bool ufs_wb_pinned_max_size(UfsHc *u, uint32_t value)
+{
+    UfsWb *wb = &u->wb;
+    uint64_t pinned_max_bytes = ufs_unit_to_byte(u, value);
+
+    if (wb->max_bytes < wb->non_pinned_min_bytes + pinned_max_bytes) {
+        return false;
+    }
+
+    u->attributes.pinned_wb_num_alloc_units = cpu_to_be32(value);
+    wb->pinned_max_bytes = pinned_max_bytes;
+    ufs_wb_sync_buffer_size(u);
+
+    return true;
+}
+
+static bool ufs_wb_pinned_min_size(UfsHc *u, uint32_t value)
+{
+    UfsWb *wb = &u->wb;
+    uint64_t non_pinned_min_bytes = ufs_unit_to_byte(u, value);
+
+    if (wb->max_bytes < non_pinned_min_bytes + wb->pinned_max_bytes) {
+        return false;
+    }
+
+    u->attributes.non_pinned_wb_min_num_alloc_units = cpu_to_be32(value);
+    wb->non_pinned_min_bytes = non_pinned_min_bytes;
+    ufs_wb_sync_buffer_size(u);
+
+    return true;
+}
+
 static QueryRespCode ufs_write_attr_value(UfsHc *u, uint8_t idn, uint32_t value)
 {
     switch (idn) {
@@ -1383,6 +1574,34 @@ static QueryRespCode ufs_write_attr_value(UfsHc *u, uint8_t idn, uint32_t value)
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
+        ufs_wb_sync_buffer_size(u);
+        break;
+    case UFS_QUERY_ATTR_IDN_MAX_FIFO_WB_PARTIAL_FLUSH_MODE:
+        if (!ufs_wb_max_fifo(u, value)) {
+            return UFS_QUERY_RESULT_INVALID_VALUE;
+        }
+        break;
+    case UFS_QUERY_ATTR_IDN_PINNED_WB_NUM_ALLOC_UNITS:
+        if (!ufs_wb_pinned_max_size(u, value)) {
+            return UFS_QUERY_RESULT_INVALID_VALUE;
+        }
+        break;
+    case UFS_QUERY_ATTR_IDN_NON_PINNED_WB_MIN_NUM_ALLOC_UNITS:
+        if (!ufs_wb_pinned_min_size(u, value)) {
+            return UFS_QUERY_RESULT_INVALID_VALUE;
+        }
+        break;
     default:
         g_assert_not_reached();
         return 0;
@@ -1801,10 +2020,136 @@ static void ufs_sendback_req(void *opaque)
     ufs_irq_check(u);
 }
 
+static inline uint64_t ufs_wb_total_flush_bytes(UfsHc *u)
+{
+    UfsWb *wb = &u->wb;
+    uint64_t no_flush_bytes;
+
+    switch (u->attributes.wb_buffer_partial_flush_mode) {
+    case UFS_WB_FLUSH_NONE:
+        no_flush_bytes = 0;
+        break;
+    case UFS_WB_FLUSH_FIFO:
+        no_flush_bytes = wb->fifo_curr_bytes;
+        break;
+    case UFS_WB_FLUSH_PINNED:
+        no_flush_bytes = (u->flags.unpin_en) ? 0 : wb->pinned_used_bytes;
+        break;
+    default:
+        g_assert_not_reached();
+        break;
+    }
+
+    if (wb->used_bytes < no_flush_bytes) {
+        return 0;
+    }
+
+    return wb->used_bytes - no_flush_bytes;
+}
+
+#define UFS_WB_FLUSH_BYTES (4096 * 1024)
+static void ufs_wb_process_flush(UfsHc *u)
+{
+    UfsWb *wb = &u->wb;
+    uint64_t flush_bytes, total_flush_bytes;
+
+    switch (u->attributes.wb_buffer_flush_status) {
+    case UFS_WB_FLUSH_IDLE:
+    case UFS_WB_FLUSH_SUSPENDED:
+        if (!u->flags.wb_buffer_flush_en || !ufs_wb_total_flush_bytes(u)) {
+            break;
+        }
+
+        u->attributes.wb_buffer_flush_status = UFS_WB_FLUSH_IN_PROGRESS;
+        /* fallthrough */
+    case UFS_WB_FLUSH_IN_PROGRESS:
+        if (!u->flags.wb_buffer_flush_en) {
+            u->attributes.wb_buffer_flush_status = UFS_WB_FLUSH_SUSPENDED;
+            break;
+        }
+
+        total_flush_bytes = ufs_wb_total_flush_bytes(u);
+        if (!total_flush_bytes) {
+            u->attributes.wb_buffer_flush_status = UFS_WB_FLUSH_COMPLETED;
+            break;
+        }
+
+       /* Flush Pinned first */
+        if (wb->pinned_used_bytes && u->flags.unpin_en) {
+            flush_bytes = MIN(wb->pinned_used_bytes, UFS_WB_FLUSH_BYTES);
+            wb->pinned_used_bytes -= flush_bytes;
+            wb->used_bytes -= flush_bytes;
+        } else {
+            flush_bytes = MIN(total_flush_bytes, UFS_WB_FLUSH_BYTES);
+            wb->used_bytes -= flush_bytes;
+        }
+
+        u->attributes.wb_buffer_flush_status = UFS_WB_FLUSH_COMPLETED;
+        /* fallthrough */
+    case UFS_WB_FLUSH_COMPLETED:
+        if (ufs_wb_total_flush_bytes(u)) {
+            u->attributes.wb_buffer_flush_status =
+                (u->flags.wb_buffer_flush_en) ? UFS_WB_FLUSH_IN_PROGRESS :
+                                                UFS_WB_FLUSH_IDLE;
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
+    case UFS_WB_IDLE:
+        /* Do nothing. Complete resize directly. */
+        break;
+    case UFS_WB_DECREASE:
+        if (wb->curr_bytes <= wb->min_bytes ||
+            wb->curr_bytes <= wb->used_bytes) {
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
 static void ufs_process_idle(UfsHc *u)
 {
-    /* Currently do nothing */
-    return;
+    ufs_wb_process_flush(u);
+    ufs_wb_process_resize(u);
+    ufs_wb_sync_buffer_size(u);
 }
 
 static inline bool ufs_check_idle(UfsHc *u)
@@ -1885,6 +2230,11 @@ static bool ufs_check_constraints(UfsHc *u, Error **errp)
         return false;
     }
 
+    if (u->params.wb_min_size > u->params.wb_max_size) {
+        error_setg(errp, "wb-min-size must be less than or equal wb-max-size");
+        return false;
+    }
+
     return true;
 }
 
@@ -1923,11 +2273,54 @@ static void ufs_init_state(UfsHc *u)
     }
 }
 
+static void ufs_wb_init(UfsHc *u)
+{
+    UfsWb *wb = &u->wb;
+    uint32_t max_units = u->params.wb_max_size;
+    uint32_t min_units = u->params.wb_min_size;
+
+    wb->max_bytes = ufs_unit_to_byte(u, max_units);
+    wb->min_bytes = ufs_unit_to_byte(u, min_units);
+
+    wb->curr_bytes = wb->max_bytes;
+    wb->used_bytes = 0;
+    wb->resize_bytes = (wb->max_bytes - wb->min_bytes) / 10;
+
+    u->attributes.wb_buffer_flush_status = UFS_WB_FLUSH_IDLE;
+    u->attributes.available_wb_buffer_size = 0xA;
+    u->attributes.wb_buffer_life_time_est = 0x1;
+    u->attributes.current_wb_buffer_size = cpu_to_be32(max_units);
+
+    u->attributes.wb_buffer_resize_hint = UFS_WB_HINT_KEEP;
+    u->attributes.wb_buffer_resize_status = UFS_WB_RESIZE_IDLE;
+
+    u->attributes.wb_buffer_partial_flush_mode = UFS_WB_FLUSH_NONE;
+
+    u->attributes.max_fifo_wb_partial_flush_mode = cpu_to_be32(max_units);
+    u->attributes.curr_fifo_wb_partial_flush_mode = cpu_to_be32(max_units);
+
+    wb->fifo_max_bytes = ufs_unit_to_byte(u, max_units);
+    wb->fifo_curr_bytes = ufs_unit_to_byte(u, max_units);
+
+    u->attributes.pinned_wb_num_alloc_units = cpu_to_be32(max_units);
+    u->attributes.non_pinned_wb_min_num_alloc_units = 0;
+
+    wb->pinned_curr_bytes = 0;
+    wb->pinned_used_bytes = 0;
+    wb->pinned_max_bytes = ufs_unit_to_byte(u, max_units);
+    wb->non_pinned_min_bytes = 0;
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
@@ -1989,8 +2382,13 @@ static void ufs_init_hc(UfsHc *u)
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
@@ -2006,6 +2404,14 @@ static void ufs_init_hc(UfsHc *u)
         0x0; /* out-of-order data transfer is not supported */
     u->geometry_desc.max_context_id_number = 0x5;
     u->geometry_desc.supported_memory_types = cpu_to_be16(0x8001);
+    u->geometry_desc.write_booster_buffer_max_n_alloc_units =
+        cpu_to_be32(u->params.wb_max_size);
+    u->geometry_desc.device_max_write_booster_l_us = 0x1;
+    u->geometry_desc.write_booster_buffer_cap_adj_fac = 0x3;
+    u->geometry_desc.supported_write_booster_buffer_user_space_reduction_types =
+        0x1;
+    u->geometry_desc.supported_write_booster_buffer_types =
+        0x1; /* lu-dedicated buffer type is not supported */
 
     memset(&u->attributes, 0, sizeof(u->attributes));
     u->attributes.max_data_in_size = 0x08;
@@ -2020,6 +2426,8 @@ static void ufs_init_hc(UfsHc *u)
     memset(&u->flags, 0, sizeof(u->flags));
     u->flags.permanently_disable_fw_update = 1;
 
+    ufs_wb_init(u);
+
     /*
      * The temperature value is fixed to UFS_TEMPERATURE and does not change
      * dynamically
@@ -2085,6 +2493,8 @@ static const Property ufs_props[] = {
     DEFINE_PROP_UINT8("nutmrs", UfsHc, params.nutmrs, 8),
     DEFINE_PROP_BOOL("mcq", UfsHc, params.mcq, false),
     DEFINE_PROP_UINT8("mcq-maxq", UfsHc, params.mcq_maxq, 2),
+    DEFINE_PROP_UINT32("wb-max-size", UfsHc, params.wb_max_size, 0x400),
+    DEFINE_PROP_UINT32("wb-min-size", UfsHc, params.wb_min_size, 0x100),
 };
 
 static const VMStateDescription ufs_vmstate = {
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index b5f040302129f4d02732ddd20ef82eb33c41922a..6ae8e235b145f7596ba24a9d27a4ab4a4f90d8de 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -91,6 +91,8 @@ typedef struct UfsParams {
     bool mcq; /* Multiple Command Queue support */
     uint8_t mcq_qcfgptr; /* MCQ Queue Configuration Pointer in MCQCAP */
     uint8_t mcq_maxq; /* MCQ Maximum number of Queues */
+    uint32_t wb_max_size; /* WB Maximum allocation units */
+    uint32_t wb_min_size; /* WB Minimum allocation units */
 } UfsParams;
 
 /*
@@ -118,6 +120,26 @@ typedef struct UfsCq {
     QTAILQ_HEAD(, UfsRequest) req_list;
 } UfsCq;
 
+/*
+ * Extended features
+ */
+typedef struct UfsWb {
+    uint64_t max_bytes;
+    uint64_t min_bytes;
+    uint64_t curr_bytes;
+    uint64_t used_bytes;
+    uint64_t resize_bytes;
+
+    uint64_t fifo_max_bytes;
+    uint64_t fifo_curr_bytes;
+
+    uint64_t pinned_max_bytes;
+    uint64_t non_pinned_min_bytes;
+    uint64_t pinned_curr_bytes;
+    uint64_t pinned_used_bytes;
+    uint64_t pinned_total_written_bytes;
+} UfsWb;
+
 typedef struct UfsHc {
     PCIDevice parent_obj;
     UfsBus bus;
@@ -147,6 +169,9 @@ typedef struct UfsHc {
     UfsSq *sq[UFS_MAX_MCQ_QNUM];
     UfsCq *cq[UFS_MAX_MCQ_QNUM];
 
+    /* Extended features */
+    UfsWb wb;
+
     uint8_t temperature;
 
     QEMUTimer idle_timer;
@@ -211,6 +236,27 @@ static inline bool ufs_mcq_cq_full(UfsHc *u, uint32_t qid)
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
 
@@ -243,5 +289,6 @@ void ufs_build_upiu_header(UfsRequest *req, uint8_t trans_type, uint8_t flags,
                            uint16_t data_segment_length);
 void ufs_build_query_response(UfsRequest *req);
 void ufs_complete_req(UfsRequest *req, UfsReqResult req_result);
+void ufs_wb_update_avail_buffer(UfsHc *u);
 void ufs_init_wlu(UfsLu *wlu, uint8_t wlun);
 #endif /* HW_UFS_UFS_H */
diff --git a/include/block/ufs.h b/include/block/ufs.h
index 4dacfb776f947a285d86018add82115f148b7dd9..0f7cc9c21b8c5e9f31b1256ee4768aff700968fc 100644
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
@@ -1153,6 +1166,9 @@ enum ufs_lu_wp_type {
 enum {
     MASK_EE_TOO_HIGH_TEMP = BIT(3),
     MASK_EE_TOO_LOW_TEMP = BIT(4),
+    MASK_EE_WB_FLUSH_NEEDED = BIT(5),
+    MASK_EE_WB_RESIZE_HINT = BIT(8),
+    MASK_EE_PINNED_WB_FULL = BIT(10),
 };
 
 /* UTP QUERY Transaction Specific Fields OpCode */
@@ -1207,6 +1223,45 @@ enum ufs_dev_pwr_mode {
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
+    UFS_WB_HINT_INCREASE = 2,
+    UFS_WB_RESIZE_HINT_MAX,
+};
+
+enum ufs_wb_resize_op {
+    UFS_WB_IDLE = 0,
+    UFS_WB_DECREASE = 1,
+    UFS_WB_INCREASE = 2,
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


