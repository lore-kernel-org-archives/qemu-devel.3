Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6416EF99C76
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 05:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEhCH-0008IF-7f; Mon, 20 Apr 2026 01:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wEhCC-0008Fb-41
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 01:29:20 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wEhC6-00082R-JY
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 01:29:19 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-35d965648a2so2235351a91.0
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2026 22:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776662951; x=1777267751; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8O87Untgd2ja5zoymtIHsPWYco5t+oSB6+mY+a9OYMM=;
 b=YwHnR6K38s49WXTWIaOlLNJ+6RMg+kX3xrKzxCmvhM7Xy01xjRdcv6p7ZYh4BNkB0x
 FIOeAvCU22L/gbLls0+8DU3mErTRSFHj5N2S094JFyuK4LRibnv3aMDqRs3ZZEtxlGRX
 UMmqtjGvKnTtzBeZJDkN9kV1yzcgIHEQ/UN1tDizFePXH7VaTujvM5QhJYp8B542rmXp
 djhXs/EUtQng7ImfOm67CrSf/Kv+Hq2+Phpn8TE3yywps/nG//rrnLCr/rIaTIJCbltY
 ckeugzsywR6hzhMxzM9bZtbVjRpUCAE0VO96AQ4bRxA/IKOPnXaUADaqjpLJUaNBBu4i
 RXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776662951; x=1777267751;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8O87Untgd2ja5zoymtIHsPWYco5t+oSB6+mY+a9OYMM=;
 b=WM8VVsDWUmT4RGV5U8+5Q2zKbw8r08EIJBSuGNkxKLT4qxmyKKXHQBJ4HrHPP95uTF
 OnKh8YorjSZ/t63eXWxvp/6XvYXFmnkMNs2EJ7wKefrfQM9TXLH18k/yDJTPQM1c41sL
 9j1ZQ8jBeXSdcmoBwu64cMmizMcTKRVWK0rIaCOmNd2MEiNcDXRDnXA9h4W3pcXjaA+4
 s85wxvnWHCQJ/Lc6itI86d5j+pe+P9yc7Pbi9nPtuNiACYgR7WmcRa/y8aHQrSfJJSbF
 psp3zIodMq2hqcBQiVb/X8NfIEr+kn476I0Dw1keYR4kNX7oLth29dk+47ceG7wdxZz5
 ibOQ==
X-Gm-Message-State: AOJu0YzQvWtkGziwT5g52iRPw53y/4tVA/PkhnxViYzhSYS1sJ+Ez8uH
 lSTLXIfEyq0qMMf79iZzdY/i7oWSSAuByInhgzESFwNYTKY4u+dJyThGg0EFDFkCZsg=
X-Gm-Gg: AeBDietlBmfXubzjsXK2ZvmjuQg3Bip1NQ+1UIeSXypuVx8eBU6ogc/isMlVNGtxeS5
 E+e63otom0E0+6+NsqctLn90QGO16PuijEjj0sjB+jSM19cKmiQpykrs4NGzTv/iqKd2bFc1ALl
 WlF6PCE0zjn67oyR4MNJQbto5Gbcr9ZgBYgvl4B6kM5JWMNT6yJmHCClRugx3zR9Z3yHUT7wngw
 66DZW6paOmcjXbHIuj3WRDJjhP8771jlG23qncGl5221bxfqz2vvyjZYtMD1Sn3txeTBtBPaZVf
 Q1k3UPMP6OFO2lW/tHOOEsIbTInPXd2j8HWf4J0zZEYDkFAkbi24+iim62gANeRuT6a+/vKPPmr
 SVxezvCRjF9V9fHM2w0BN79OiYWjvt05Mmr79Mat2kKqffZ7G5UvByHn5YIFIjhYY6QZkdgzqwg
 kn+Y+r50gCTN9yFNaKsVa+b5pOAqXOVpGIc4zjoCsM
X-Received: by 2002:a17:90b:2785:b0:35d:9efd:7956 with SMTP id
 98e67ed59e1d1-361403f0fa6mr13478949a91.11.1776662950734; 
 Sun, 19 Apr 2026 22:29:10 -0700 (PDT)
Received: from [172.17.0.5] ([168.126.243.22])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab3ad18sm93099675ad.71.2026.04.19.22.29.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 22:29:10 -0700 (PDT)
From: Jaemyung Lee <ldc.jml@gmail.com>
X-Google-Original-From: Jaemyung Lee <jaemyung.lee@samsung.com>
Date: Mon, 20 Apr 2026 14:28:52 +0900
Subject: [PATCH v6 4/5] hw/ufs: Add UFS Write Booster Support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-write_booster-v6-4-8c49acba03d4@samsung.com>
References: <20260420-write_booster-v6-0-8c49acba03d4@samsung.com>
In-Reply-To: <20260420-write_booster-v6-0-8c49acba03d4@samsung.com>
To: qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Jaemyung Lee <jaemyung.lee@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776662940; l=26500;
 i=jaemyung.lee@samsung.com; s=20260402; h=from:subject:message-id;
 bh=yFMWzjnf+Mp6Xk3PRYRL+yNQ2lD5iySwbfTktOCYeBA=;
 b=V/cMvrb+wKCxUSToQACQe9BvheUi32hIVmh5QZPDKF7yC6pQaTTQTgyJfyiQ7/fu0wE/xnlan
 G8vg6L6IRt6D7NU7K535S6keXSRhwy1SBGmeeItIBg0F7XQ4PxeQElW
X-Developer-Key: i=jaemyung.lee@samsung.com; a=ed25519;
 pk=bZPd7A/kteUO62FfUM6IrI1LuBPe5QrcqfvsitM1ZjE=
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=ldc.jml@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 hw/ufs/lu.c         |  97 ++++++++++++++-
 hw/ufs/ufs.c        | 345 +++++++++++++++++++++++++++++++++++++++++++++++++---
 hw/ufs/ufs.h        |  47 +++++++
 include/block/ufs.h |  51 ++++++++
 4 files changed, 524 insertions(+), 16 deletions(-)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 3f3c9589cee57ae3e77e2f486476d5fcec204d80..fd8c9ef6007c2b093a1594a6aaa35f98a5fefdea 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -58,13 +58,108 @@ static void ufs_build_scsi_response_upiu(UfsRequest *req, uint8_t *sense,
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
+#define UFS_WB_TOTAL_WRITTEN_DIV (10 * 1024 * 1024) /* 10MiB */
+static void ufs_wb_process_write_pinned(UfsHc *u, uint32_t transfered_len)
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
+    if (remain_bytes >= transfered_len) {
+        wb->pinned_total_written_bytes += transfered_len;
+        wb->pinned_used_bytes += transfered_len;
+        remain_data = 0;
+
+    } else {
+        wb->pinned_total_written_bytes += remain_bytes;
+        wb->pinned_used_bytes += remain_bytes;
+        remain_data = transfered_len - remain_bytes;
+    }
+
+    total_written = wb->pinned_total_written_bytes / UFS_WB_TOTAL_WRITTEN_DIV;
+    u->attributes.pinned_wb_cumm_written_size = cpu_to_be32(total_written);
+
+    remain_bytes = wb->curr_bytes - wb->used_bytes;
+    wb->used_bytes += MIN(remain_bytes, remain_data);
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
index c504a0d7e3fb89eb5558cfd9c410cda9396bc3b4..c26a906d4bb445cde9c754427bedb2b53f4effee 100644
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
@@ -1238,6 +1249,31 @@ static inline uint8_t ufs_read_device_temp(UfsHc *u)
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
@@ -1292,7 +1328,7 @@ static uint32_t ufs_read_attr_value(UfsHc *u, uint8_t idn)
     case UFS_QUERY_ATTR_IDN_THROTTLING_STATUS:
         return u->attributes.throttling_status;
     case UFS_QUERY_ATTR_IDN_WB_FLUSH_STATUS:
-        return u->attributes.wb_buffer_flush_status;
+        return ufs_wb_read_flush_status(u);
     case UFS_QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE:
         return u->attributes.available_wb_buffer_size;
     case UFS_QUERY_ATTR_IDN_WB_BUFF_LIFE_TIME_EST:
@@ -1323,10 +1359,8 @@ static uint32_t ufs_read_attr_value(UfsHc *u, uint8_t idn)
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
@@ -1347,6 +1381,32 @@ static uint32_t ufs_read_attr_value(UfsHc *u, uint8_t idn)
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
@@ -1383,6 +1443,30 @@ static QueryRespCode ufs_write_attr_value(UfsHc *u, uint8_t idn, uint32_t value)
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
+        if (value > u->params.wb_max_size) {
+            return UFS_QUERY_RESULT_INVALID_VALUE;
+        }
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
@@ -1801,9 +1885,177 @@ static void ufs_sendback_req(void *opaque)
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
+            u->attributes.wb_buffer_flush_status = UFS_WB_FLUSH_SUSPENDED;
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
 
@@ -1885,6 +2137,11 @@ static bool ufs_check_constraints(UfsHc *u, Error **errp)
         return false;
     }
 
+    if (u->params.wb_min_size > u->params.wb_max_size) {
+        error_setg(errp, "wb-min-size must be less than or equal wb-max-size");
+        return false;
+    }
+
     return true;
 }
 
@@ -1923,11 +2180,47 @@ static void ufs_init_state(UfsHc *u)
     }
 }
 
+static void ufs_wb_init(UfsHc *u)
+{
+    UfsWb *wb = &u->wb;
+    uint32_t max_units = u->params.wb_max_size;
+
+    wb->max_bytes = ufs_unit_to_byte(u, max_units);
+    wb->min_bytes = ufs_unit_to_byte(u, max_units);
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
+    u->attributes.pinned_wb_num_alloc_units = cpu_to_be32(max_units);
+    u->attributes.non_pinned_wb_min_num_alloc_units = 0;
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
@@ -1989,8 +2282,13 @@ static void ufs_init_hc(UfsHc *u)
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
@@ -2006,6 +2304,16 @@ static void ufs_init_hc(UfsHc *u)
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
@@ -2020,6 +2328,8 @@ static void ufs_init_hc(UfsHc *u)
     memset(&u->flags, 0, sizeof(u->flags));
     u->flags.permanently_disable_fw_update = 1;
 
+    ufs_wb_init(u);
+
     /*
      * The temperature value is fixed to UFS_TEMPERATURE and does not change
      * dynamically
@@ -2085,6 +2395,11 @@ static const Property ufs_props[] = {
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


