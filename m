Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9DCE9539C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 13:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vncqM-0003Kt-5t; Wed, 04 Feb 2026 08:22:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1vncqI-0003Ib-Um; Wed, 04 Feb 2026 08:22:50 -0500
Received: from mail.avm.de ([2001:bf0:244:244::120])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1vncqE-000311-Js; Wed, 04 Feb 2026 08:22:49 -0500
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.0)
 (envelope-from <c.speich@avm.de>)
 id 6983481f-cb91-7f0000032729-7f000001d8ec-1
 for <multiple-recipients>; Wed, 04 Feb 2026 14:22:39 +0100
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Wed,  4 Feb 2026 14:22:39 +0100 (CET)
Received: from [127.0.1.1] ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2026020414223965-15149 ;
 Wed, 4 Feb 2026 14:22:39 +0100 
Date: Wed, 04 Feb 2026 14:22:26 +0100
Subject: [PATCH v3 2/6] hw/sd/sd: Allow multi-byte read/write for generic paths
MIME-Version: 1.0
Message-Id: <20260204-sdcard-performance-b4-v3-2-dc1cf172ee57@avm.de>
References: <20260204-sdcard-performance-b4-v3-0-dc1cf172ee57@avm.de>
In-Reply-To: <20260204-sdcard-performance-b4-v3-0-dc1cf172ee57@avm.de>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Bin Meng
 <bmeng.cn@gmail.com>, qemu-block@nongnu.org, Christian Speich
 <c.speich@avm.de>
X-Mailer: b4 0.14.2
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 14.0FP4|March 10,
 2025) at 04.02.2026 14:22:39,
 Serialize by Router on ANIS1/AVM(Release 14.0FP4|March 10, 2025) at
 04.02.2026 14:22:39, Serialize complete at 04.02.2026 14:22:39
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-purgate-ID: 149429::1770211359-C964C71A-CF93AFD6/0/0
X-purgate-type: clean
X-purgate-size: 7006
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
Received-SPF: pass client-ip=2001:bf0:244:244::120;
 envelope-from=c.speich@avm.de; helo=mail.avm.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Reply-to:  Christian Speich <c.speich@avm.de>
From:  Christian Speich via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Paths that use sd_generic_write/read_data can now write/read multiple
bytes with one call.

Signed-off-by: Christian Speich <c.speich@avm.de>
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


