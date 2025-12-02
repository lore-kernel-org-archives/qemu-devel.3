Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C8FCFD2F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 14:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQRY6-0005Dv-5b; Tue, 02 Dec 2025 09:40:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1vQRY2-00058y-Qo; Tue, 02 Dec 2025 09:40:10 -0500
Received: from mail.avm.de ([2001:bf0:244:244::120])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1vQRXy-0001Bp-So; Tue, 02 Dec 2025 09:40:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1764686399; bh=aKRkTVXly2VJrZBrFWevF8CUBqxGW2YarXf7kPGQFmY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=kOSwPe8XO2riTY9Zbn7ucwQ/bGvxB/USuLF/JdtgnvkXyREgBxmMNwfBsRVVZDdlj
 rpHNi5kdLt+E5KfzmNQL5MZRkyEn1TwM0FnTr5P8d08vrRAUUysBgRcjJjKImbxLxY
 OihQoXtIP5/Hkln5o/HJpaLHjJ8iHJvQ+GmgiT0c=
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.53.4)
 (envelope-from <c.speich@avm.de>)
 id 692efa3f-a0ff-7f0000032729-7f0000019630-1
 for <multiple-recipients>; Tue, 02 Dec 2025 15:39:59 +0100
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Tue,  2 Dec 2025 15:39:59 +0100 (CET)
Received: from [127.0.1.1] ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2025120215400010-18426 ;
 Tue, 2 Dec 2025 15:40:00 +0100 
From: Christian Speich <c.speich@avm.de>
Date: Tue, 02 Dec 2025 15:39:31 +0100
Subject: [PATCH v2 1/4] hw/sd: Switch from byte-wise to buf+len read/writes
MIME-Version: 1.0
Message-Id: <20251202-sdcard-performance-b4-v2-1-d42490b11322@avm.de>
References: <20251202-sdcard-performance-b4-v2-0-d42490b11322@avm.de>
In-Reply-To: <20251202-sdcard-performance-b4-v2-0-d42490b11322@avm.de>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Bin Meng
 <bmeng.cn@gmail.com>, qemu-block@nongnu.org, Christian Speich
 <c.speich@avm.de>
X-Mailer: b4 0.14.2
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 14.0FP4|March 10,
 2025) at 02.12.2025 15:40:00,
 Serialize by Router on ANIS1/AVM(Release 14.0FP4|March 10, 2025) at
 02.12.2025 15:40:00, Serialize complete at 02.12.2025 15:40:00
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-purgate-ID: 149429::1764686399-50E2DC3E-94747950/0/0
X-purgate-type: clean
X-purgate-size: 19729
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
Received-SPF: pass client-ip=2001:bf0:244:244::120;
 envelope-from=c.speich@avm.de; helo=mail.avm.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, each read/write is eventually split into individual bytes and
then later reconstructed into blocks. Byte-wise operation is always bad
for performance.

This patch switches from the read_byte/write_byte primitives to
read_data/write_data which take a buf + length that should be filled.
Byte-wise operation is still supported via sdbus_{read,write}_byte.

As before, arbitrarily sized and aligned data can be passed. The new
primitives try to pass the largest possible buffer down to the block
layer. This enhances speed and if possible avoids the local bounce
buffer.

Signed-off-by: Christian Speich <c.speich@avm.de>
---
 hw/sd/core.c       |  16 +---
 hw/sd/sd.c         | 257 +++++++++++++++++++++++++++++++++++++++++------------
 include/hw/sd/sd.h |  13 +--
 3 files changed, 209 insertions(+), 77 deletions(-)

diff --git a/hw/sd/core.c b/hw/sd/core.c
index d3c9017445e01c2885a115656ecf23dc336d3b0f..5f05748b9942d5a359d7dee3e0369cf96fc3571b 100644
--- a/hw/sd/core.c
+++ b/hw/sd/core.c
@@ -113,22 +113,18 @@ void sdbus_write_byte(SDBus *sdbus, uint8_t value)
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
-        }
+        sc->write_data(card, buf, length);
     }
 }
 
@@ -140,7 +136,7 @@ uint8_t sdbus_read_byte(SDBus *sdbus)
     if (card) {
         SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
 
-        value = sc->read_byte(card);
+        sc->read_data(card, &value, 1);
     }
     trace_sdbus_read(sdbus_name(sdbus), value);
 
@@ -150,15 +146,11 @@ uint8_t sdbus_read_byte(SDBus *sdbus)
 void sdbus_read_data(SDBus *sdbus, void *buf, size_t length)
 {
     SDState *card = get_card(sdbus);
-    uint8_t *data = buf;
 
     if (card) {
         SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
 
-        for (size_t i = 0; i < length; i++) {
-            data[i] = sc->read_byte(card);
-            trace_sdbus_read(sdbus_name(sdbus), data[i]);
-        }
+        sc->read_data(card, buf, length);
     }
 }
 
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d7a496d77c9200d45c267e2b8ee31d026ca34795..23764ed99f36cf39ee7abe02f08e51897c05e718 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1049,24 +1049,36 @@ static const VMStateDescription sd_vmstate = {
     },
 };
 
-static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
+static void sd_blk_read_direct(SDState *sd, void* buf, uint64_t addr,
+                               uint32_t len)
 {
     trace_sdcard_read_block(addr, len);
     addr += sd_part_offset(sd);
-    if (!sd->blk || blk_pread(sd->blk, addr, len, sd->data, 0) < 0) {
+    if (!sd->blk || blk_pread(sd->blk, addr, len, buf, 0) < 0) {
         fprintf(stderr, "sd_blk_read: read error on host side\n");
     }
 }
 
-static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
+static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
+{
+    sd_blk_read_direct(sd, sd->data, addr, len);
+}
+
+static void sd_blk_write_direct(SDState *sd, const void *buf, uint64_t addr,
+                                uint32_t len)
 {
     trace_sdcard_write_block(addr, len);
     addr += sd_part_offset(sd);
-    if (!sd->blk || blk_pwrite(sd->blk, addr, len, sd->data, 0) < 0) {
+    if (!sd->blk || blk_pwrite(sd->blk, addr, len, buf, 0) < 0) {
         fprintf(stderr, "sd_blk_write: write error on host side\n");
     }
 }
 
+static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
+{
+    sd_blk_write_direct(sd, sd->data, addr, len);
+}
+
 static void sd_erase(SDState *sd)
 {
     uint64_t erase_start = sd->erase_start;
@@ -1348,7 +1360,7 @@ static sd_rsp_type_t sd_cmd_optional(SDState *sd, SDRequest req)
     return sd_illegal;
 }
 
-/* Configure fields for following sd_generic_write_byte() calls */
+/* Configure fields for following sd_generic_write_date() calls */
 static sd_rsp_type_t sd_cmd_to_receivingdata(SDState *sd, SDRequest req,
                                              uint64_t start, size_t size)
 {
@@ -1363,7 +1375,7 @@ static sd_rsp_type_t sd_cmd_to_receivingdata(SDState *sd, SDRequest req,
     return sd_r1;
 }
 
-/* Configure fields for following sd_generic_read_byte() calls */
+/* Configure fields for following sd_generic_read_data() calls */
 static sd_rsp_type_t sd_cmd_to_sendingdata(SDState *sd, SDRequest req,
                                            uint64_t start,
                                            const void *data, size_t size)
@@ -2352,23 +2364,35 @@ send_response:
 }
 
 /* Return true if buffer is consumed. Configured by sd_cmd_to_receivingdata() */
-static bool sd_generic_write_byte(SDState *sd, uint8_t value)
+static bool sd_generic_write_data(SDState *sd, const void* buf, size_t length)
 {
-    sd->data[sd->data_offset] = value;
+    size_t to_write = MIN(sd->data_size - sd->data_offset, length);
 
-    if (++sd->data_offset >= sd->data_size) {
+    memcpy(sd->data, buf, to_write);
+    sd->data_offset += to_write;
+
+    if (sd->data_offset >= sd->data_size) {
         sd->state = sd_transfer_state;
         return true;
     }
+
     return false;
 }
 
 /* Return true when buffer is consumed. Configured by sd_cmd_to_sendingdata() */
-static bool sd_generic_read_byte(SDState *sd, uint8_t *value)
+static bool sd_generic_read_data(SDState *sd, void *buf, size_t length)
 {
-    *value = sd->data[sd->data_offset];
+    size_t to_read = MIN(sd->data_size - sd->data_offset, length);
+
+    memcpy(buf, sd->data, to_read);
+    sd->data_offset += to_read;
+
+    /* Fill remaining with zero, if requested to read more than requested. */
+    if (to_read < length) {
+        memset(buf + to_read, 0, length - to_read);
+    }
 
-    if (++sd->data_offset >= sd->data_size) {
+    if (sd->data_offset >= sd->data_size) {
         sd->state = sd_transfer_state;
         return true;
     }
@@ -2376,7 +2400,7 @@ static bool sd_generic_read_byte(SDState *sd, uint8_t *value)
     return false;
 }
 
-static void sd_write_byte(SDState *sd, uint8_t value)
+static void sd_write_data(SDState *sd, const void *buf, size_t length)
 {
     int i;
 
@@ -2395,10 +2419,10 @@ static void sd_write_byte(SDState *sd, uint8_t value)
 
     trace_sdcard_write_data(sd->proto->name,
                             sd->last_cmd_name,
-                            sd->current_cmd, sd->data_offset, value);
+                            sd->current_cmd, sd->data_offset, 0);
     switch (sd->current_cmd) {
     case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
-        if (sd_generic_write_byte(sd, value)) {
+        if (sd_generic_write_data(sd, buf, length)) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             sd_blk_write(sd, sd->data_start, sd->data_offset);
@@ -2410,32 +2434,76 @@ static void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 25:  /* CMD25:  WRITE_MULTIPLE_BLOCK */
-        if (sd->data_offset == 0) {
-            /* Start of the block - let's check the address is valid */
-            if (!address_in_range(sd, "WRITE_MULTIPLE_BLOCK",
-                                  sd->data_start, sd->blk_len)) {
-                break;
-            }
-            if (sd->size <= SDSC_MAX_CAPACITY) {
-                if (sd_wp_addr(sd, sd->data_start)) {
+        if (!address_in_range(sd, "WRITE_MULTIPLE_BLOCK",
+                              sd->data_start + sd->data_offset, length)) {
+            /* Limit writing data to our device size */
+            length = sd->size - sd->data_start - sd->data_offset;
+        }
+
+        if (sd->size <= SDSC_MAX_CAPACITY) {
+            uint64_t start = sd->data_start + sd->data_offset;
+
+            /*
+             * Check if any covered address violates WP. If so, limit our write
+             * up to the allowed address.
+             */
+            for (uint64_t addr = start; addr < start + length;
+                 addr = ROUND_UP(addr + 1, WPGROUP_SIZE)) {
+                if (sd_wp_addr(sd, addr)) {
                     sd->card_status |= WP_VIOLATION;
+
+                    length = addr - start - 1;
                     break;
                 }
             }
         }
-        sd->data[sd->data_offset++] = value;
-        if (sd->data_offset >= sd->blk_len) {
-            /* TODO: Check CRC before committing */
+
+        /* Partial write */
+        if (sd->data_offset > 0) {
+            size_t to_write = MIN(sd->blk_len - sd->data_offset, length);
+
+            memcpy(sd->data + sd->data_offset, buf, to_write);
+            sd->data_offset += to_write;
+            buf += to_write;
+            length -= to_write;
+
+            if (sd->data_offset >= sd->blk_len) {
+                sd->state = sd_programming_state;
+                sd_blk_write(sd, sd->data_start, sd->blk_len);
+                sd->blk_written++;
+                sd->data_start += sd->blk_len;
+                sd->data_offset = 0;
+                sd->csd[14] |= 0x40;
+
+                /* Bzzzzzzztt .... Operation complete.  */
+                if (sd->multi_blk_cnt != 0) {
+                    if (--sd->multi_blk_cnt == 0) {
+                        /* Stop! */
+                        sd->state = sd_transfer_state;
+                        break;
+                    }
+                }
+
+                sd->state = sd_receivingdata_state;
+            }
+        }
+
+        /* Try to write multiple of block sizes */
+        if (length >= sd->blk_len) {
+            size_t to_write = QEMU_ALIGN_DOWN(length, sd->blk_len);
+
             sd->state = sd_programming_state;
-            sd_blk_write(sd, sd->data_start, sd->data_offset);
-            sd->blk_written++;
-            sd->data_start += sd->blk_len;
-            sd->data_offset = 0;
+            sd_blk_write_direct(sd, buf, sd->data_start, to_write);
+            sd->blk_written += to_write / sd->blk_len;
+            sd->data_start += to_write;
             sd->csd[14] |= 0x40;
+            buf += to_write;
+            length -= to_write;
 
-            /* Bzzzzzzztt .... Operation complete.  */
             if (sd->multi_blk_cnt != 0) {
-                if (--sd->multi_blk_cnt == 0) {
+                sd->multi_blk_cnt -= to_write / sd->blk_len;
+
+                if (sd->multi_blk_cnt == 0) {
                     /* Stop! */
                     sd->state = sd_transfer_state;
                     break;
@@ -2444,10 +2512,16 @@ static void sd_write_byte(SDState *sd, uint8_t value)
 
             sd->state = sd_receivingdata_state;
         }
+
+        /* Partial write */
+        if (length > 0) {
+            memcpy(sd->data, buf, length);
+            sd->data_offset = length;
+        }
         break;
 
     case 26:  /* CMD26:  PROGRAM_CID */
-        if (sd_generic_write_byte(sd, value)) {
+        if (sd_generic_write_data(sd, buf, length)) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             for (i = 0; i < sizeof(sd->cid); i ++)
@@ -2465,7 +2539,7 @@ static void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 27:  /* CMD27:  PROGRAM_CSD */
-        if (sd_generic_write_byte(sd, value)) {
+        if (sd_generic_write_data(sd, buf, length)) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             for (i = 0; i < sizeof(sd->csd); i ++)
@@ -2488,7 +2562,7 @@ static void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 42:  /* CMD42:  LOCK_UNLOCK */
-        if (sd_generic_write_byte(sd, value)) {
+        if (sd_generic_write_data(sd, buf, length)) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             sd_lock_command(sd);
@@ -2498,7 +2572,7 @@ static void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 56:  /* CMD56:  GEN_CMD */
-        sd_generic_write_byte(sd, value);
+        sd_generic_write_data(sd, buf, length);
         break;
 
     default:
@@ -2506,25 +2580,28 @@ static void sd_write_byte(SDState *sd, uint8_t value)
     }
 }
 
-static uint8_t sd_read_byte(SDState *sd)
+static void sd_read_data(SDState *sd, void *data, size_t length)
 {
     /* TODO: Append CRCs */
     const uint8_t dummy_byte = 0x00;
-    uint8_t ret;
     uint32_t io_len;
+    void *fill_end = data + length;
 
     if (!sd->blk || !blk_is_inserted(sd->blk)) {
-        return dummy_byte;
+        memset(data, dummy_byte, length);
+        return;
     }
 
     if (sd->state != sd_sendingdata_state) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: not in Sending-Data state\n", __func__);
-        return dummy_byte;
+        memset(data, dummy_byte, length);
+        return;
     }
 
     if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION)) {
-        return dummy_byte;
+        memset(data, dummy_byte, length);
+        return;
     }
 
     io_len = sd_blk_len(sd);
@@ -2544,40 +2621,102 @@ static uint8_t sd_read_byte(SDState *sd)
     case 30: /* CMD30:  SEND_WRITE_PROT */
     case 51: /* ACMD51: SEND_SCR */
     case 56: /* CMD56:  GEN_CMD */
-        sd_generic_read_byte(sd, &ret);
+        sd_generic_read_data(sd, data, length);
         break;
 
     case 18:  /* CMD18:  READ_MULTIPLE_BLOCK */
-        if (sd->data_offset == 0) {
-            if (!address_in_range(sd, "READ_MULTIPLE_BLOCK",
-                                  sd->data_start, io_len)) {
-                return dummy_byte;
+        if (!address_in_range(sd, "READ_MULTIPLE_BLOCK",
+                              sd->data_start + sd->data_offset, length)) {
+            /* Limit reading data to our device size */
+            length = sd->size - sd->data_start - sd->data_offset;
+        }
+
+        /* We have a partially read block. */
+        if (sd->data_offset > 0) {
+            size_t to_read = MIN(sd->data_size - sd->data_offset, length);
+
+            memcpy(data, sd->data + sd->data_offset, to_read);
+
+            sd->data_offset += to_read;
+            data += to_read;
+            length -= to_read;
+
+            /* Partial read is complete, clear state. */
+            if (sd->data_offset >= sd->data_size) {
+                sd->data_start += io_len;
+                sd->data_size = 0;
+                sd->data_offset = 0;
+
+                if (sd->multi_blk_cnt != 0) {
+                    if (--sd->multi_blk_cnt == 0) {
+                        sd->state = sd_transfer_state;
+                    }
+                }
             }
-            sd_blk_read(sd, sd->data_start, io_len);
         }
-        ret = sd->data[sd->data_offset ++];
 
-        if (sd->data_offset >= io_len) {
-            sd->data_start += io_len;
-            sd->data_offset = 0;
+        /*
+         * Try to read multiples of the block size directly bypassing the local
+         * bounce buffer.
+         */
+        if (sd->state == sd_sendingdata_state && length >= io_len) {
+            size_t to_read = QEMU_ALIGN_DOWN(length, io_len);
 
+            /* For limited reads, only read the requested block count. */
             if (sd->multi_blk_cnt != 0) {
-                if (--sd->multi_blk_cnt == 0) {
-                    /* Stop! */
+                to_read = MIN(to_read, sd->multi_blk_cnt * io_len);
+            }
+
+            sd_blk_read_direct(sd, data, sd->data_start,
+                               to_read);
+
+            sd->data_start += to_read;
+            data += to_read;
+            length -= to_read;
+
+            if (sd->multi_blk_cnt != 0) {
+                sd->multi_blk_cnt -= to_read / io_len;
+
+                if (sd->multi_blk_cnt == 0) {
                     sd->state = sd_transfer_state;
-                    break;
                 }
             }
         }
+
+        /* Read partial at the end */
+        if (sd->state == sd_sendingdata_state && length > 0) {
+            /* Fill the buffer */
+            sd_blk_read(sd, sd->data_start, io_len);
+
+            memcpy(data, sd->data, length);
+
+            sd->data_size = io_len;
+            sd->data_offset = length;
+            data += length;
+            length = 0;
+
+            /*
+             * No need to check multi_blk_cnt, as to_read will always be
+             * < io_len and we will never finish a block here.
+             */
+        }
+
+        /*
+         * We always need to fill the supplied buffer fully, recalulate
+         * remaining length based on the actual buffer end and not a possible
+         * early end due to a read past the device size.
+         */
+        length = fill_end - data;
+        if (length > 0) {
+            memset(data, 0, length);
+        }
         break;
 
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: DAT read illegal for command %s\n",
                                        __func__, sd->last_cmd_name);
-        return dummy_byte;
+        memset(data, dummy_byte, length);
     }
-
-    return ret;
 }
 
 static bool sd_receive_ready(SDState *sd)
@@ -2859,8 +2998,8 @@ static void sdmmc_common_class_init(ObjectClass *klass, const void *data)
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
index 91b5c40a5f893ee41cff21ebbe78d7dfa753d94e..56cd30391bfefd867f4ce97a58de5cc0acd84e97 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -107,22 +107,23 @@ struct SDCardClass {
     size_t (*do_command)(SDState *sd, SDRequest *req,
                          uint8_t *resp, size_t respsz);
     /**
-     * Write a byte to a SD card.
+     * Write data to a SD card.
      * @sd: card
-     * @value: byte to write
+     * @value: data to write
      *
      * Write a byte on the data lines of a SD card.
      */
-    void (*write_byte)(SDState *sd, uint8_t value);
+    void (*write_data)(SDState *sd, const void* buf, size_t len);
     /**
-     * Read a byte from a SD card.
+     * Read data from a SD card.
      * @sd: card
      *
-     * Read a byte from the data lines of a SD card.
+     * Read data from the data lines of a SD card. The requestes length is
+     * always filled even if an error occours.
      *
      * Return: byte value read
      */
-    uint8_t (*read_byte)(SDState *sd);
+    void (*read_data)(SDState *sd, void* buf, size_t len);
     bool (*receive_ready)(SDState *sd);
     bool (*data_ready)(SDState *sd);
     void (*set_voltage)(SDState *sd, uint16_t millivolts);

-- 
2.43.0


