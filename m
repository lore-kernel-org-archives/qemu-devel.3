Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DD5606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=rCJpFsCn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3Hd-00063u-7p; Mon, 16 Nov 2026 15:26:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3HT-0005KA-UP; Mon, 16 Nov 2026 15:26:24 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3HQ-00070m-8E; Mon, 16 Nov 2026 15:26:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860763; bh=lzsaAoRw8OAij13MG0mlwwySxQNp3H0aLTQR7xnlLPM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=rCJpFsCnWbjDFp5qA4Kk+e06XxNqNvGyeXd/OjHlESsCQ5V/kqSDjUiBvGDXSvjIu
 fmZBNuzt404IFd2Wx0ssarnu67MWbsNSDMDUThtcIqifIm9mY7N8QbFp3ubIHILpxX
 LAJnkzw+2fI+MDLICxccs3TjRGn3+P4jxG+i4lDT0uDNk+HDL+7hWS8atjU/kqurCe
 8ode72JXA1n6Rfs7Yh04sCcfJ8hmsUaCnQ9tYD9B2t8x6jCmBxIpTS7tJ4T8fa6apF
 zdFDwBJMsOfKrhANVbuGG6vV0HdfR3fGtMNUV7ms05sxOoDfKx4wvJdy0/HXZAdMMR
 UmnUXVbFULXlw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BDC821E719E;
 Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B886C45FBCA;
 Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 82EF0B8E58; Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bin Meng <bin.meng@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 09/63] hw/sd/sdcard: Keep high-capacity memory blocks
 at 512 bytes
Date: Mon, 16 Nov 2026 23:24:48 +0300
Message-ID: <20261116202554.535325-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Bin Meng <bin.meng@processmission.com>

SDHC and SDXC memory commands always transfer 512-byte blocks regardless
of the length selected by CMD16. QEMU stores that selected length for
LOCK_UNLOCK but also used it directly for several memory command paths.

Route single- and multi-block memory sizing through the existing helper
that distinguishes high-capacity cards from SDSC.

This lets PolarFire SoC HSS validate the complete GPT header and locate
its boot partition instead of receiving only the eight-byte signature.

Cc: qemu-stable@nongnu.org
Fixes: 2d7adea4fe57 ("hw/sd: Support SDHC size cards")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261014012323.322790-12-bin.meng@processmission.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit b5424abaf8e9a24ef1bcdd43e426405b3991801a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 780e9f62953..5cb84155541 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1975,18 +1975,20 @@ static sd_rsp_type_t sd_cmd_SET_BLOCKLEN(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_cmd_READ_SINGLE_BLOCK(SDState *sd, SDRequest req)
 {
     uint64_t addr;
+    uint32_t blk_len;
 
     if (sd->state != sd_transfer_state) {
         return sd_invalid_state_for_cmd(sd, req);
     }
 
+    blk_len = sd_blk_len(sd);
     addr = sd_req_get_address(sd, req);
-    if (!address_in_range(sd, "READ_SINGLE_BLOCK", addr, sd->blk_len)) {
+    if (!address_in_range(sd, "READ_SINGLE_BLOCK", addr, blk_len)) {
         return sd_r1;
     }
 
-    sd_blk_read(sd, addr, sd->blk_len);
-    return sd_cmd_to_sendingdata(sd, req, addr, NULL, sd->blk_len);
+    sd_blk_read(sd, addr, blk_len);
+    return sd_cmd_to_sendingdata(sd, req, addr, NULL, blk_len);
 }
 
 /* CMD19 */
@@ -2025,13 +2027,15 @@ static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_cmd_WRITE_SINGLE_BLOCK(SDState *sd, SDRequest req)
 {
     uint64_t addr;
+    uint32_t blk_len;
 
     if (sd->state != sd_transfer_state) {
         return sd_invalid_state_for_cmd(sd, req);
     }
 
+    blk_len = sd_blk_len(sd);
     addr = sd_req_get_address(sd, req);
-    if (!address_in_range(sd, "WRITE_SINGLE_BLOCK", addr, sd->blk_len)) {
+    if (!address_in_range(sd, "WRITE_SINGLE_BLOCK", addr, blk_len)) {
         return sd_r1;
     }
 
@@ -2045,7 +2049,7 @@ static sd_rsp_type_t sd_cmd_WRITE_SINGLE_BLOCK(SDState *sd, SDRequest req)
     }
 
     sd->blk_written = 0;
-    return sd_cmd_to_receivingdata(sd, req, addr, sd->blk_len);
+    return sd_cmd_to_receivingdata(sd, req, addr, blk_len);
 }
 
 /* CMD26 */
@@ -2372,7 +2376,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         switch (sd->state) {
         case sd_transfer_state:
 
-            if (!address_in_range(sd, "READ_BLOCK", addr, sd->blk_len)) {
+            if (!address_in_range(sd, "READ_BLOCK", addr, sd_blk_len(sd))) {
                 return sd_r1;
             }
 
@@ -2392,7 +2396,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         switch (sd->state) {
         case sd_transfer_state:
 
-            if (!address_in_range(sd, "WRITE_BLOCK", addr, sd->blk_len)) {
+            if (!address_in_range(sd, "WRITE_BLOCK", addr,
+                                  sd_blk_len(sd))) {
                 return sd_r1;
             }
 
@@ -2662,6 +2667,7 @@ static void sdcard_write_data_dump(const char *proto, const char *cmd_desc,
 static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
 {
     unsigned int partition_access;
+    uint32_t blk_len;
     int i;
     const uint8_t *value = buf;
 
@@ -2678,6 +2684,7 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
     if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION))
         return length;
 
+    blk_len = sd_blk_len(sd);
     sdcard_write_data_dump(sd->proto->name,
                            sd->last_cmd_name,
                            sd->current_cmd, sd->data_offset, buf, length);
@@ -2704,7 +2711,7 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
         if (sd->data_offset == 0) {
             /* Start of the block - let's check the address is valid */
             if (!address_in_range(sd, "WRITE_MULTIPLE_BLOCK",
-                                  sd->data_start, sd->blk_len)) {
+                                  sd->data_start, blk_len)) {
                 break;
             }
             if (sd->size <= SDSC_MAX_CAPACITY) {
@@ -2715,7 +2722,7 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
             }
         }
         sd->data[sd->data_offset++] = value[0];
-        if (sd->data_offset >= sd->blk_len) {
+        if (sd->data_offset >= blk_len) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             partition_access = sd->ext_csd[EXT_CSD_PART_CONFIG]
@@ -2726,7 +2733,7 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
                 sd_blk_write(sd, sd->data_start, sd->data_offset);
             }
             sd->blk_written++;
-            sd->data_start += sd->blk_len;
+            sd->data_start += blk_len;
             sd->data_offset = 0;
             sd->csd[14] |= 0x40;
 
@@ -2810,7 +2817,7 @@ static size_t sd_read_data(SDState *sd, void *buf, size_t length)
     /* TODO: Append CRCs */
     const uint8_t dummy_byte = 0x00;
     unsigned int partition_access;
-    uint32_t io_len;
+    uint32_t blk_len;
     uint8_t *value = buf;
 
     if (!sd->blk || !blk_is_inserted(sd->blk)) {
@@ -2830,11 +2837,11 @@ static size_t sd_read_data(SDState *sd, void *buf, size_t length)
         return length;
     }
 
-    io_len = sd_blk_len(sd);
+    blk_len = sd_blk_len(sd);
 
     trace_sdcard_read_data(sd->proto->name,
                            sd->last_cmd_name, sd->current_cmd,
-                           sd->data_offset, sd->data_size, io_len);
+                           sd->data_offset, sd->data_size, blk_len);
     switch (sd->current_cmd) {
     case 6:  /* CMD6:   SWITCH_FUNCTION */
     case 8:  /* CMD8:   SEND_EXT_CSD */
@@ -2859,22 +2866,22 @@ static size_t sd_read_data(SDState *sd, void *buf, size_t length)
 
         if (sd->data_offset == 0) {
             if (!address_in_range(sd, "READ_MULTIPLE_BLOCK",
-                                  sd->data_start, io_len)) {
+                                  sd->data_start, blk_len)) {
                 *value = dummy_byte;
                 return length;
             }
             partition_access = sd->ext_csd[EXT_CSD_PART_CONFIG]
                     & EXT_CSD_PART_CONFIG_ACC_MASK;
             if (partition_access == EXT_CSD_PART_CONFIG_ACC_RPMB) {
-                emmc_rpmb_blk_read(sd, sd->data_start, io_len);
+                emmc_rpmb_blk_read(sd, sd->data_start, blk_len);
             } else {
-                sd_blk_read(sd, sd->data_start, io_len);
+                sd_blk_read(sd, sd->data_start, blk_len);
             }
         }
         *value = sd->data[sd->data_offset++];
 
-        if (sd->data_offset >= io_len) {
-            sd->data_start += io_len;
+        if (sd->data_offset >= blk_len) {
+            sd->data_start += blk_len;
             sd->data_offset = 0;
 
             if (sd->multi_blk_cnt != 0) {
-- 
2.47.3


