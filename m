Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF854E9539C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 13:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vncqL-0003KS-NA; Wed, 04 Feb 2026 08:22:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1vncqH-0003IM-8j; Wed, 04 Feb 2026 08:22:50 -0500
Received: from mail.avm.de ([2001:bf0:244:244::120])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1vncqE-00030z-AP; Wed, 04 Feb 2026 08:22:48 -0500
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.0)
 (envelope-from <c.speich@avm.de>)
 id 6983481e-cb91-7f0000032729-7f000001d8e8-1
 for <multiple-recipients>; Wed, 04 Feb 2026 14:22:38 +0100
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Wed,  4 Feb 2026 14:22:38 +0100 (CET)
Received: from [127.0.1.1] ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2026020414223964-15148 ;
 Wed, 4 Feb 2026 14:22:39 +0100 
Date: Wed, 04 Feb 2026 14:22:25 +0100
Subject: [PATCH v3 1/6] hw/sd: Switch read/write primitive to buf+len
MIME-Version: 1.0
Message-Id: <20260204-sdcard-performance-b4-v3-1-dc1cf172ee57@avm.de>
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
X-purgate-ID: 149429::1770211358-B8E7371A-5E025E8A/0/0
X-purgate-type: clean
X-purgate-size: 10788
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

Currently, read/writes are broken down into individual bytes which result
in many function calls. This is quite bad for performance and since both
the layer below and above work with larger buffers, it should be
corrected.

This patch is the first that switches the corresponding interface over to
use a buf+len instead of a single byte. However, for most cases the
implementation still only reads one byte and is then called again with
the remaining buffer.

Optimizations taking advantage of this new interface are to follow in the
next commits.

Signed-off-by: Christian Speich <c.speich@avm.de>
---
 hw/sd/core.c       | 26 ++++++++++++++---------
 hw/sd/sd.c         | 62 +++++++++++++++++++++++++++++++++++-------------------
 include/hw/sd/sd.h | 22 +++++++++++++------
 3 files changed, 71 insertions(+), 39 deletions(-)

diff --git a/hw/sd/core.c b/hw/sd/core.c
index 3568a81e809fe107cfd0b5cc33b8b5761b11ce04..594c5e011ba30940a33799f9032c92494ee0ca19 100644
--- a/hw/sd/core.c
+++ b/hw/sd/core.c
@@ -113,21 +113,24 @@ void sdbus_write_byte(SDBus *sdbus, uint8_t value)
     if (card) {
         SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
 
-        sc->write_byte(card, value);
+        sc->write_data(card, &value, 1);
     }
 }
 
 void sdbus_write_data(SDBus *sdbus, const void *buf, size_t length)
 {
     SDState *card = get_card(sdbus);
-    const uint8_t *data = buf;
 
     if (card) {
         SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
 
-        for (size_t i = 0; i < length; i++) {
-            trace_sdbus_write(sdbus_name(sdbus), data[i]);
-            sc->write_byte(card, data[i]);
+        while (length > 0) {
+            size_t written = sc->write_data(card, buf, length);
+
+            g_assert(written >= 1);
+
+            buf += written;
+            length -= written;
         }
     }
 }
@@ -140,7 +143,7 @@ uint8_t sdbus_read_byte(SDBus *sdbus)
     if (card) {
         SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
 
-        value = sc->read_byte(card);
+        sc->read_data(card, &value, 1);
     }
     trace_sdbus_read(sdbus_name(sdbus), value);
 
@@ -150,14 +153,17 @@ uint8_t sdbus_read_byte(SDBus *sdbus)
 void sdbus_read_data(SDBus *sdbus, void *buf, size_t length)
 {
     SDState *card = get_card(sdbus);
-    uint8_t *data = buf;
 
     if (card) {
         SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
 
-        for (size_t i = 0; i < length; i++) {
-            data[i] = sc->read_byte(card);
-            trace_sdbus_read(sdbus_name(sdbus), data[i]);
+        while (length > 0) {
+            size_t read = sc->read_data(card, buf, length);
+
+            g_assert(read >= 1);
+
+            buf += read;
+            length -= read;
         }
     }
 }
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 37f6e0702b0bce85915ef727ba1ec05f02f9c32c..135113add29b5ee3cb11d9d535355eba8f6cb3f7 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2638,30 +2638,37 @@ static bool sd_generic_read_byte(SDState *sd, uint8_t *value)
     return false;
 }
 
-static void sd_write_byte(SDState *sd, uint8_t value)
+static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
 {
     unsigned int partition_access;
     int i;
+    const uint8_t *value = buf;
 
     if (!sd->blk || !blk_is_inserted(sd->blk)) {
-        return;
+        return length;
     }
 
     if (sd->state != sd_receivingdata_state) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: not in Receiving-Data state\n", __func__);
-        return;
+        return length;
     }
 
     if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION))
-        return;
+        return length;
+
+    /*
+     * Only read one byte at a time. We will be called again with the
+     * remaining.
+     */
+    length = 1;
 
     trace_sdcard_write_data(sd->proto->name,
                             sd->last_cmd_name,
-                            sd->current_cmd, sd->data_offset, value);
+                            sd->current_cmd, sd->data_offset, value[0]);
     switch (sd->current_cmd) {
     case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
-        if (sd_generic_write_byte(sd, value)) {
+        if (sd_generic_write_byte(sd, value[0])) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             sd_blk_write(sd, sd->data_start, sd->data_offset);
@@ -2686,7 +2693,7 @@ static void sd_write_byte(SDState *sd, uint8_t value)
                 }
             }
         }
-        sd->data[sd->data_offset++] = value;
+        sd->data[sd->data_offset++] = value[0];
         if (sd->data_offset >= sd->blk_len) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
@@ -2716,7 +2723,7 @@ static void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 26:  /* CMD26:  PROGRAM_CID */
-        if (sd_generic_write_byte(sd, value)) {
+        if (sd_generic_write_byte(sd, value[0])) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             for (i = 0; i < sizeof(sd->cid); i ++)
@@ -2734,7 +2741,7 @@ static void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 27:  /* CMD27:  PROGRAM_CSD */
-        if (sd_generic_write_byte(sd, value)) {
+        if (sd_generic_write_byte(sd, value[0])) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             for (i = 0; i < sizeof(sd->csd); i ++)
@@ -2757,7 +2764,7 @@ static void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 42:  /* CMD42:  LOCK_UNLOCK */
-        if (sd_generic_write_byte(sd, value)) {
+        if (sd_generic_write_byte(sd, value[0])) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             sd_lock_command(sd);
@@ -2767,36 +2774,47 @@ static void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 56:  /* CMD56:  GEN_CMD */
-        sd_generic_write_byte(sd, value);
+        sd_generic_write_byte(sd, value[0]);
         break;
 
     default:
         g_assert_not_reached();
     }
+
+    return length;
 }
 
-static uint8_t sd_read_byte(SDState *sd)
+static size_t sd_read_data(SDState *sd, void *buf, size_t length)
 {
     /* TODO: Append CRCs */
     const uint8_t dummy_byte = 0x00;
     unsigned int partition_access;
-    uint8_t ret;
     uint32_t io_len;
+    uint8_t *value = buf;
 
     if (!sd->blk || !blk_is_inserted(sd->blk)) {
-        return dummy_byte;
+        memset(buf, dummy_byte, length);
+        return length;
     }
 
     if (sd->state != sd_sendingdata_state) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: not in Sending-Data state\n", __func__);
-        return dummy_byte;
+        memset(buf, dummy_byte, length);
+        return length;
     }
 
     if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION)) {
-        return dummy_byte;
+        memset(buf, dummy_byte, length);
+        return length;
     }
 
+    /*
+     * We will only read one byte at a time. We will be called again with the
+     * remaining buffer.
+     */
+    length = 1;
+
     io_len = sd_blk_len(sd);
 
     trace_sdcard_read_data(sd->proto->name,
@@ -2814,7 +2832,7 @@ static uint8_t sd_read_byte(SDState *sd)
     case 30: /* CMD30:  SEND_WRITE_PROT */
     case 51: /* ACMD51: SEND_SCR */
     case 56: /* CMD56:  GEN_CMD */
-        sd_generic_read_byte(sd, &ret);
+        sd_generic_read_byte(sd, value);
         break;
 
     case 18:  /* CMD18:  READ_MULTIPLE_BLOCK */
@@ -2831,7 +2849,7 @@ static uint8_t sd_read_byte(SDState *sd)
                 sd_blk_read(sd, sd->data_start, io_len);
             }
         }
-        ret = sd->data[sd->data_offset ++];
+        *value = sd->data[sd->data_offset++];
 
         if (sd->data_offset >= io_len) {
             sd->data_start += io_len;
@@ -2850,10 +2868,10 @@ static uint8_t sd_read_byte(SDState *sd)
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: DAT read illegal for command %s\n",
                                        __func__, sd->last_cmd_name);
-        return dummy_byte;
+        *value = dummy_byte;
     }
 
-    return ret;
+    return length;
 }
 
 static bool sd_receive_ready(SDState *sd)
@@ -3173,8 +3191,8 @@ static void sdmmc_common_class_init(ObjectClass *klass, const void *data)
     sc->get_dat_lines = sd_get_dat_lines;
     sc->get_cmd_line = sd_get_cmd_line;
     sc->do_command = sd_do_command;
-    sc->write_byte = sd_write_byte;
-    sc->read_byte = sd_read_byte;
+    sc->write_data = sd_write_data;
+    sc->read_data = sd_read_data;
     sc->receive_ready = sd_receive_ready;
     sc->data_ready = sd_data_ready;
     sc->get_inserted = sd_get_inserted;
diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index d12f24955a5ba3c1ba9ab851d75992e830c00608..2162fb584020110bcdaa7a92c2a05b6cfc041d2f 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -107,22 +107,30 @@ struct SDCardClass {
     size_t (*do_command)(SDState *sd, SDRequest *req,
                          uint8_t *resp, size_t respsz);
     /**
-     * Write a byte to a SD card.
+     * Write data to a SD card.
      * @sd: card
-     * @value: byte to write
+     * @value: data to write
+     * @len: length of data
      *
-     * Write a byte on the data lines of a SD card.
+     * Write data on the data lines of a SD card. May write not all data, in
+     * which case it should be called again. At least one byte must be consumed.
+     *
+     * Return: number of bytes actually written. >= 1
      */
-    void (*write_byte)(SDState *sd, uint8_t value);
+    size_t (*write_data)(SDState *sd, const void *buf, size_t len);
     /**
      * Read a byte from a SD card.
      * @sd: card
+     * @buf: buffer to receive the data
+     * @len: size of data to read
      *
-     * Read a byte from the data lines of a SD card.
+     * Read data from the data lines of a SD card. This may not read all
+     * requested data, in this case it should be called again with the remaining
+     * buffer. At least one byte must be read.
      *
-     * Return: byte value read
+     * Return: number of bytes actually read. >= 1
      */
-    uint8_t (*read_byte)(SDState *sd);
+    size_t (*read_data)(SDState *sd, void* buf, size_t len);
     bool (*receive_ready)(SDState *sd);
     bool (*data_ready)(SDState *sd);
     void (*set_voltage)(SDState *sd, uint16_t millivolts);

-- 
2.43.0


