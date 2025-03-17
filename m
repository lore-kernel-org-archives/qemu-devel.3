Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB04CC28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 19:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuGSE-0007eY-Hd; Mon, 17 Mar 2025 15:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1tuDZ7-0003Vs-Hx
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:43:58 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1tuDZ3-0001DB-CW
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:43:48 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-225d66a4839so56114685ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 09:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742229818; x=1742834618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mFCl+PuL71rwLfqWjVxR8UqDMsn9wX/Wj1FpBaxlxKs=;
 b=I6vInkTO9/9TReoVaGSE72so7BMImRPk+kxcdY6oGVOrn+39IaNxtQwjuZKfX046GF
 nqhUCiICUWgOyHJHGYrEzp68vou1UR3ZOWIzRv4hg477MDVxcNpISSZ+9L6fL/zoiKgX
 uBo8dfksz6gVU56hBe036dl7KEssLJSmHe899SuEDb4sJFG60ny47Vgl+TV4WN0meS3U
 Xi98GB7SNHPzrU1H9TxkBp9vOGBW+nOwXSSabeDbbdmRMZkz997kziOtoOfxSkaimfua
 XzayvgKbNbiafzZot9+bUl59zLsOVHhz9s0XykzOxZ1NySeti+q7WdrrxEGwAAs+E0n7
 /iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742229818; x=1742834618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mFCl+PuL71rwLfqWjVxR8UqDMsn9wX/Wj1FpBaxlxKs=;
 b=uWQA25ZaIIKVkwWplEw0mYyPfVA/iMxHuS+afLSmNrNUAgOuyuh4VbeDr4diSwtUi5
 dUf9U2sYhk5Kei/hG6smiWsqtu/2j4TcPStQHksptyWD285iodugEpI6UPjImQBf6JrE
 aEewlDgM6PLHYr4nkej1ArAr8ebvT7OxUprkhXb831fHZZ7NelxIh9SQlJNt1RUluNVF
 0NVXTofSAETctCezVrxZPqDDkKtY6ZTg2QMr7U7Q8N/DBKf9FAmrluTxtpMBZdJulCwl
 13J+qtQrTzCFR8SKpwfM4lQN2iIIVh1fJV1Gff8rlhoe9hgS2jFbh1R+uPN+P3Kpx0Gw
 ztSg==
X-Gm-Message-State: AOJu0Yx/KSUhc7sgYo4H+Jb4V38KzzDuJjdUQSeQBmJFEzuWaaamEdey
 z1VJO7500mwaCkErYa5BbHtM57WkXSq5BwuIoKt5ropzRwcA/E0EbjJFEg==
X-Gm-Gg: ASbGncsij62MKFJekdu+w92CBfLAU4nuCLYyHCl41+gyxq5un324ZwbdBIQq2Rjgkk2
 rEi+I//JnkTC0L3W3CFRRXOEYiumgWEse6tFHVovdEmFwbebfHmao6NHKZjPOmW7i/+hZaKo+N0
 8nmVUOJXGI+9Kz7UU8VS7musiyJFLSGMN5RW+qngJ4O2apf4HbK/onPe059HvwsAjIC059zLlBn
 X7gZKsYy4jywI2Q7gfLFEeWmdRGlBu4VGgHdYWvWUQXL/DOmQIFEBZVQmQGc1WkH9rLsmPiVbL4
 AumXXpr6YEp1lSyDE5Fgy6wlkloy5WMSVRNS63jv/2leuM25sk4zbKap8/EDQcfDNg==
X-Google-Smtp-Source: AGHT+IEyirkL/BekZ2sWuYBKXsGbAnndgmUTBSB4qasF2yNHne2DfTlFWrpxNJXBQMHxhsjOyLsxtA==
X-Received: by 2002:a17:903:228c:b0:226:194f:48ef with SMTP id
 d9443c01a7336-2262c9d26d4mr1856565ad.13.1742229818322; 
 Mon, 17 Mar 2025 09:43:38 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6888461sm77810085ad.23.2025.03.17.09.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 09:43:38 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: [PATCH 2/9] cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
Date: Mon, 17 Mar 2025 16:31:29 +0000
Message-ID: <20250317164204.2299371-3-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317164204.2299371-1-anisa.su887@gmail.com>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=anisa.su887@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 17 Mar 2025 15:48:00 -0400
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

From: Anisa Su <anisa.su@samsung.com>

FM DCD Management command 0x5600 implemented per CXL 3.2 Spec Section 7.6.7.6.1

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 67 ++++++++++++++++++++++++++++++++++++++
 hw/cxl/i2c_mctp_cxl.c      |  6 +++-
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 1b62d36101..e9991fd1a7 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -122,6 +122,8 @@ enum {
         #define MANAGEMENT_COMMAND     0x0
     MHD = 0x55,
         #define GET_MHD_INFO 0x0
+    FMAPI_DCD_MGMT = 0x56,
+        #define GET_DCD_INFO 0x0
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3341,6 +3343,62 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * CXL r3.2 section 7.6.7.6.1: Get DCD Info (Opcode 5600h)
+ */
+static CXLRetCode cmd_fm_get_dcd_info(const struct cxl_cmd *cmd,
+                                      uint8_t *payload_in,
+                                      size_t len_in,
+                                      uint8_t *payload_out,
+                                      size_t *len_out,
+                                      CXLCCI *cci)
+{
+    struct {
+        uint8_t num_hosts;
+        uint8_t num_regions_supported;
+        uint8_t rsvd1[2];
+        uint16_t add_select_policy_bitmask;
+        uint8_t rsvd2[2];
+        uint16_t release_select_policy_bitmask;
+        uint8_t sanitize_on_release_bitmask;
+        uint8_t rsvd3;
+        uint64_t total_dynamic_capacity;
+        uint64_t region_blk_size_bitmasks[8];
+    } QEMU_PACKED *out;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDCRegion region;
+    int i;
+
+    if (ct3d->dc.num_regions == 0) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
+    out = (void *)payload_out;
+
+    /* TODO: num hosts set to 1 for now */
+    out->num_hosts = 1;
+    out->num_regions_supported = ct3d->dc.num_regions;
+    /* TODO: only prescriptive supported for now */
+    stw_le_p(&out->add_select_policy_bitmask,
+             CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE);
+    stw_le_p(&out->release_select_policy_bitmask,
+             CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE);
+    /* TODO: sanitize on release bitmask cleared for now */
+    out->sanitize_on_release_bitmask = 0;
+
+    stq_le_p(&out->total_dynamic_capacity,
+             ct3d->dc.total_capacity / CXL_CAPACITY_MULTIPLIER);
+
+    for (i = 0; i < ct3d->dc.num_regions; i++) {
+        region = ct3d->dc.regions[i];
+        memcpy(&out->region_blk_size_bitmasks[i],
+                &region.supported_blk_size_bitmask, 8);
+    }
+
+    *len_out = sizeof(*out);
+    return CXL_MBOX_SUCCESS;
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3462,6 +3520,11 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
                                      cmd_tunnel_management_cmd, ~0, 0 },
 };
 
+static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
+    [FMAPI_DCD_MGMT][GET_DCD_INFO] = { "GET_DCD_INFO",
+        cmd_fm_get_dcd_info, 0, 0},
+};
+
 /*
  * While the command is executing in the background, the device should
  * update the percentage complete in the Background Command Status Register
@@ -3764,7 +3827,11 @@ void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
                                            DeviceState *intf,
                                            size_t payload_max)
 {
+    CXLType3Dev *ct3d = CXL_TYPE3(d);
     cxl_copy_cci_commands(cci, cxl_cmd_set_t3_fm_owned_ld_mctp);
+    if (ct3d->dc.num_regions) {
+        cxl_copy_cci_commands(cci, cxl_cmd_set_fm_dcd);
+    }
     cci->d = d;
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
diff --git a/hw/cxl/i2c_mctp_cxl.c b/hw/cxl/i2c_mctp_cxl.c
index 7d2cbc3b75..df95182925 100644
--- a/hw/cxl/i2c_mctp_cxl.c
+++ b/hw/cxl/i2c_mctp_cxl.c
@@ -46,6 +46,9 @@
 /* Implementation choice - may make this configurable */
 #define MCTP_CXL_MAILBOX_BYTES 512
 
+/* Supported FMAPI Cmds */
+#define FMAPI_CMD_MAX_OPCODE 0x57
+
 typedef struct CXLMCTPMessage {
     /*
      * DSP0236 (MCTP Base) Integrity Check + Message Type
@@ -200,7 +203,8 @@ static void i2c_mctp_cxl_handle_message(MCTPI2CEndpoint *mctp)
         if (!(msg->message_type == MCTP_MT_CXL_TYPE3 &&
               msg->command_set < 0x51) &&
             !(msg->message_type == MCTP_MT_CXL_FMAPI &&
-              msg->command_set >= 0x51 && msg->command_set < 0x56)) {
+              msg->command_set >= 0x51 &&
+              msg->command_set < FMAPI_CMD_MAX_OPCODE)) {
             buf->rc = CXL_MBOX_UNSUPPORTED;
             st24_le_p(buf->pl_length, len_out);
             s->len = s->pos;
-- 
2.47.2


