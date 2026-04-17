Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1313DF43688
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDfxO-0003Ek-Ct; Fri, 17 Apr 2026 05:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1wDfx9-0002jW-I8; Fri, 17 Apr 2026 05:57:35 -0400
Received: from mail.avm.de ([212.42.244.119])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1wDfx5-000302-HO; Fri, 17 Apr 2026 05:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1776419845; bh=hEncSpiJ83XFws/L5Xd2Q4V9lgBRfDDWRPUG5zSMWVU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=E28HWfUHpE7UwXsF/9AJCkDWBgBQMTs2CFrv+Y79SGIPEBnx1twKaG+80LpmPQcCG
 VKRtrAz5GGEp6yvdveMg7qdAvej/86a8GBoWYkcIwJOo6Ixgj5xETcy0Oiy6ExlpQ8
 3xG4GXoft2Fa1WD1V8sFtMbWSMQCealMpA6DaKvA=
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.2)
 (envelope-from <c.speich@avm.de>)
 id 69e20405-1e6c-7f0000032729-7f000001c518-1
 for <multiple-recipients>; Fri, 17 Apr 2026 11:57:25 +0200
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Fri, 17 Apr 2026 11:57:25 +0200 (CEST)
Received: from [127.0.1.1] ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2026041711572443-2975 ;
 Fri, 17 Apr 2026 11:57:24 +0200 
From: Christian Speich <c.speich@avm.de>
Date: Fri, 17 Apr 2026 11:51:35 +0200
Subject: [PATCH v4 2/7] hw/sd/sd: Allow multi-byte read/write for generic paths
MIME-Version: 1.0
Message-Id: <20260417-sdcard-performance-b4-v4-2-119e66be10c2@avm.de>
References: <20260417-sdcard-performance-b4-v4-0-119e66be10c2@avm.de>
In-Reply-To: <20260417-sdcard-performance-b4-v4-0-119e66be10c2@avm.de>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Bin Meng
 <bmeng.cn@gmail.com>, qemu-block@nongnu.org, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu
 <zhao1.liu@intel.com>, Christian Speich <c.speich@avm.de>
X-Mailer: b4 0.14.2
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 14.0FP4|March 10,
 2025) at 17.04.2026 11:57:24,
 Serialize by Router on ANIS1/AVM(Release 14.0FP4|March 10, 2025) at
 17.04.2026 11:57:24, Serialize complete at 17.04.2026 11:57:24
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
X-purgate-ID: 149429::1776419845-38707233-2F1C2574/0/0
X-purgate-type: clean
X-purgate-size: 7064
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
Received-SPF: pass client-ip=212.42.244.119; envelope-from=c.speich@avm.de;
 helo=mail.avm.de
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Paths that use sd_generic_write/read_data can now write/read multiple
bytes with one call.

Signed-off-by: Christian Speich <c.speich@avm.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 62 +++++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 135113add29b5ee3cb11d9d535355eba8f6cb3f7..2c81776df316feda75f97e15cc9bbd1538f1a21c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1609,7 +1609,7 @@ static sd_rsp_type_t sd_cmd_optional(SDState *sd, SDRequest req)
     return sd_illegal;
 }
 
-/* Configure fields for following sd_generic_write_byte() calls */
+/* Configure fields for following sd_generic_write_data() calls */
 static sd_rsp_type_t sd_cmd_to_receivingdata(SDState *sd, SDRequest req,
                                              uint64_t start, size_t size)
 {
@@ -1624,7 +1624,7 @@ static sd_rsp_type_t sd_cmd_to_receivingdata(SDState *sd, SDRequest req,
     return sd_r1;
 }
 
-/* Configure fields for following sd_generic_read_byte() calls */
+/* Configure fields for following sd_generic_read_data() calls */
 static sd_rsp_type_t sd_cmd_to_sendingdata(SDState *sd, SDRequest req,
                                            uint64_t start,
                                            const void *data, size_t size)
@@ -2614,11 +2614,15 @@ send_response:
 }
 
 /* Return true if buffer is consumed. Configured by sd_cmd_to_receivingdata() */
-static bool sd_generic_write_byte(SDState *sd, uint8_t value)
+static bool sd_generic_write_data(SDState *sd, const void *buf, size_t *len)
 {
-    sd->data[sd->data_offset] = value;
+    size_t to_write = MIN(sd->data_size - sd->data_offset, *len);
 
-    if (++sd->data_offset >= sd->data_size) {
+    memcpy(sd->data, buf, to_write);
+    sd->data_offset += to_write;
+    *len = to_write;
+
+    if (sd->data_offset >= sd->data_size) {
         sd->state = sd_transfer_state;
         return true;
     }
@@ -2626,11 +2630,15 @@ static bool sd_generic_write_byte(SDState *sd, uint8_t value)
 }
 
 /* Return true when buffer is consumed. Configured by sd_cmd_to_sendingdata() */
-static bool sd_generic_read_byte(SDState *sd, uint8_t *value)
+static bool sd_generic_read_data(SDState *sd, void *buf, size_t *len)
 {
-    *value = sd->data[sd->data_offset];
+    size_t to_read = MIN(sd->data_size - sd->data_offset, *len);
+
+    memcpy(buf, sd->data, to_read);
+    sd->data_offset += to_read;
+    *len = to_read;
 
-    if (++sd->data_offset >= sd->data_size) {
+    if (sd->data_offset >= sd->data_size) {
         sd->state = sd_transfer_state;
         return true;
     }
@@ -2657,18 +2665,12 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
     if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION))
         return length;
 
-    /*
-     * Only read one byte at a time. We will be called again with the
-     * remaining.
-     */
-    length = 1;
-
     trace_sdcard_write_data(sd->proto->name,
                             sd->last_cmd_name,
                             sd->current_cmd, sd->data_offset, value[0]);
     switch (sd->current_cmd) {
     case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
-        if (sd_generic_write_byte(sd, value[0])) {
+        if (sd_generic_write_data(sd, buf, &length)) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             sd_blk_write(sd, sd->data_start, sd->data_offset);
@@ -2680,6 +2682,12 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
         break;
 
     case 25:  /* CMD25:  WRITE_MULTIPLE_BLOCK */
+        /*
+         * Only read one byte at a time. We will be called again with the
+         * remaining.
+         */
+        length = 1;
+
         if (sd->data_offset == 0) {
             /* Start of the block - let's check the address is valid */
             if (!address_in_range(sd, "WRITE_MULTIPLE_BLOCK",
@@ -2723,7 +2731,7 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
         break;
 
     case 26:  /* CMD26:  PROGRAM_CID */
-        if (sd_generic_write_byte(sd, value[0])) {
+        if (sd_generic_write_data(sd, buf, &length)) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             for (i = 0; i < sizeof(sd->cid); i ++)
@@ -2741,7 +2749,7 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
         break;
 
     case 27:  /* CMD27:  PROGRAM_CSD */
-        if (sd_generic_write_byte(sd, value[0])) {
+        if (sd_generic_write_data(sd, buf, &length)) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             for (i = 0; i < sizeof(sd->csd); i ++)
@@ -2764,7 +2772,7 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
         break;
 
     case 42:  /* CMD42:  LOCK_UNLOCK */
-        if (sd_generic_write_byte(sd, value[0])) {
+        if (sd_generic_write_data(sd, buf, &length)) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             sd_lock_command(sd);
@@ -2774,7 +2782,7 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
         break;
 
     case 56:  /* CMD56:  GEN_CMD */
-        sd_generic_write_byte(sd, value[0]);
+        sd_generic_write_data(sd, buf, &length);
         break;
 
     default:
@@ -2809,12 +2817,6 @@ static size_t sd_read_data(SDState *sd, void *buf, size_t length)
         return length;
     }
 
-    /*
-     * We will only read one byte at a time. We will be called again with the
-     * remaining buffer.
-     */
-    length = 1;
-
     io_len = sd_blk_len(sd);
 
     trace_sdcard_read_data(sd->proto->name,
@@ -2832,10 +2834,16 @@ static size_t sd_read_data(SDState *sd, void *buf, size_t length)
     case 30: /* CMD30:  SEND_WRITE_PROT */
     case 51: /* ACMD51: SEND_SCR */
     case 56: /* CMD56:  GEN_CMD */
-        sd_generic_read_byte(sd, value);
+        sd_generic_read_data(sd, buf, &length);
         break;
 
     case 18:  /* CMD18:  READ_MULTIPLE_BLOCK */
+        /*
+         * We will only read one byte at a time. We will be called again with
+         * the remaining buffer.
+         */
+        length = 1;
+
         if (sd->data_offset == 0) {
             if (!address_in_range(sd, "READ_MULTIPLE_BLOCK",
                                   sd->data_start, io_len)) {
@@ -2868,7 +2876,7 @@ static size_t sd_read_data(SDState *sd, void *buf, size_t length)
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: DAT read illegal for command %s\n",
                                        __func__, sd->last_cmd_name);
-        *value = dummy_byte;
+        memset(buf, dummy_byte, length);
     }
 
     return length;

-- 
2.43.0


