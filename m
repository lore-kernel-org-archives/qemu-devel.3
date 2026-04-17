Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CEFBF43688
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDfxH-00031t-4P; Fri, 17 Apr 2026 05:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1wDfx9-0002jp-Uj; Fri, 17 Apr 2026 05:57:35 -0400
Received: from mail.avm.de ([212.42.244.119])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1wDfx5-00030T-HO; Fri, 17 Apr 2026 05:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1776419845; bh=QoyvxQROiGbE6vAvJxaG+85jruxRTacuSs9YktkmEG0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=OPKm0GxdEpwO+n7aXHamI33uktNSIId8uheR7V3/x/MCVl1IjvdFq85n1S1ChZs/c
 gBk5D1rjOAVORQGUdDDXoXEfUwPZvU066FU9OYQ91F2ZWPaCwGI42O13y7GfQ6mIo0
 V2TwgMroMnWGDsXUXuy5qsEZOIL3LL0uZ7tcUino=
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.2)
 (envelope-from <c.speich@avm.de>)
 id 69e20405-1e6c-7f0000032729-7f000001c51e-1
 for <multiple-recipients>; Fri, 17 Apr 2026 11:57:25 +0200
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Fri, 17 Apr 2026 11:57:25 +0200 (CEST)
Received: from [127.0.1.1] ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2026041711572443-2976 ;
 Fri, 17 Apr 2026 11:57:24 +0200 
From: Christian Speich <c.speich@avm.de>
Date: Fri, 17 Apr 2026 11:51:36 +0200
Subject: [PATCH v4 3/7] hw/sd/sd: Use multi-byte/block writes for block
 path
MIME-Version: 1.0
Message-Id: <20260417-sdcard-performance-b4-v4-3-119e66be10c2@avm.de>
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
 17.04.2026 11:57:25, Serialize complete at 17.04.2026 11:57:25
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-purgate-ID: 149429::1776419845-4BF2C233-2AF0D54D/0/0
X-purgate-type: clean
X-purgate-size: 12969
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

When writing/reading blocks via WRITE/READ_MULTIPLE_BLOCK we try to
directly pass this request down to the block layer. This can only be done
for properly sized and aligned accesses, other access still use a bounce
buffer but still benefit from copying as much data in one memcpy as
possible.

RPMB is limited to the slow path using a bounce buffer.

Signed-off-by: Christian Speich <c.speich@avm.de>
---
 hw/sd/sd.c | 228 ++++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 172 insertions(+), 56 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 2c81776df316feda75f97e15cc9bbd1538f1a21c..b27fed2e563e5971dd32787498eb8abed9ffe9be 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1112,24 +1112,36 @@ static const VMStateDescription sd_vmstate = {
     },
 };
 
-static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
+static void sd_blk_read(SDState *sd, void* buf, uint64_t addr,
+                        uint32_t len)
 {
     trace_sdcard_read_block(addr, len);
     addr += sd_part_offset(sd);
-    if (!sd->blk || blk_pread(sd->blk, addr, len, sd->data, 0) < 0) {
+    if (!sd->blk || blk_pread(sd->blk, addr, len, buf, 0) < 0) {
         fprintf(stderr, "sd_blk_read: read error on host side\n");
     }
 }
 
-static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
+static void sd_blk_read_bounce_buffer(SDState *sd, uint64_t addr, uint32_t len)
+{
+    sd_blk_read(sd, sd->data, addr, len);
+}
+
+static void sd_blk_write(SDState *sd, const void *buf, uint64_t addr,
+                         uint32_t len)
 {
     trace_sdcard_write_block(addr, len);
     addr += sd_part_offset(sd);
-    if (!sd->blk || blk_pwrite(sd->blk, addr, len, sd->data, 0) < 0) {
+    if (!sd->blk || blk_pwrite(sd->blk, addr, len, buf, 0) < 0) {
         fprintf(stderr, "sd_blk_write: write error on host side\n");
     }
 }
 
+static void sd_blk_write_bounce_buffer(SDState *sd, uint64_t addr, uint32_t len)
+{
+    sd_blk_write(sd, sd->data, addr, len);
+}
+
 static bool rpmb_calc_hmac(SDState *sd, const RPMBDataFrame *frame,
                            unsigned int num_blocks, uint8_t *mac)
 {
@@ -1363,7 +1375,7 @@ static void sd_erase(SDState *sd)
                 continue;
             }
         }
-        sd_blk_write(sd, erase_addr, erase_len);
+        sd_blk_write_bounce_buffer(sd, erase_addr, erase_len);
     }
 }
 
@@ -1984,7 +1996,7 @@ static sd_rsp_type_t sd_cmd_READ_SINGLE_BLOCK(SDState *sd, SDRequest req)
         return sd_r1;
     }
 
-    sd_blk_read(sd, addr, sd->blk_len);
+    sd_blk_read_bounce_buffer(sd, addr, sd->blk_len);
     return sd_cmd_to_sendingdata(sd, req, addr, NULL, sd->blk_len);
 }
 
@@ -2673,7 +2685,7 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
         if (sd_generic_write_data(sd, buf, &length)) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
-            sd_blk_write(sd, sd->data_start, sd->data_offset);
+            sd_blk_write_bounce_buffer(sd, sd->data_start, sd->data_offset);
             sd->blk_written ++;
             sd->csd[14] |= 0x40;
             /* Bzzzzzzztt .... Operation complete.  */
@@ -2682,44 +2694,85 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
         break;
 
     case 25:  /* CMD25:  WRITE_MULTIPLE_BLOCK */
-        /*
-         * Only read one byte at a time. We will be called again with the
-         * remaining.
-         */
-        length = 1;
-
-        if (sd->data_offset == 0) {
-            /* Start of the block - let's check the address is valid */
-            if (!address_in_range(sd, "WRITE_MULTIPLE_BLOCK",
-                                  sd->data_start, sd->blk_len)) {
-                break;
+        if (!address_in_range(sd, "WRITE_MULTIPLE_BLOCK",
+                            sd->data_start + sd->data_offset, length)) {
+            /* Limit writing data to our device size */
+            length = sd->size - sd->data_start - sd->data_offset;
+
+            /* We've read past the end, return a dummy write. */
+            if (length == 0) {
+                return 1;
             }
-            if (sd->size <= SDSC_MAX_CAPACITY) {
-                if (sd_wp_addr(sd, sd->data_start)) {
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
-        sd->data[sd->data_offset++] = value[0];
-        if (sd->data_offset >= sd->blk_len) {
-            /* TODO: Check CRC before committing */
-            sd->state = sd_programming_state;
-            partition_access = sd->ext_csd[EXT_CSD_PART_CONFIG]
-                    & EXT_CSD_PART_CONFIG_ACC_MASK;
-            if (partition_access == EXT_CSD_PART_CONFIG_ACC_RPMB) {
-                emmc_rpmb_blk_write(sd, sd->data_start, sd->data_offset);
-            } else {
-                sd_blk_write(sd, sd->data_start, sd->data_offset);
+
+        partition_access = sd->ext_csd[EXT_CSD_PART_CONFIG]
+                            & EXT_CSD_PART_CONFIG_ACC_MASK;
+
+        /* Partial write or RPMB (single block only for now) */
+        if (sd->data_offset > 0
+            || partition_access == EXT_CSD_PART_CONFIG_ACC_RPMB) {
+            length = MIN(sd->blk_len - sd->data_offset, length);
+
+            memcpy(sd->data + sd->data_offset, buf, length);
+            sd->data_offset += length;
+
+            if (sd->data_offset >= sd->blk_len) {
+                sd->state = sd_programming_state;
+                if (partition_access == EXT_CSD_PART_CONFIG_ACC_RPMB) {
+                    emmc_rpmb_blk_write(sd, sd->data_start, sd->data_offset);
+                } else {
+                    sd_blk_write_bounce_buffer(sd, sd->data_start,
+                                               sd->data_offset);
+                }
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
             }
-            sd->blk_written++;
-            sd->data_start += sd->blk_len;
-            sd->data_offset = 0;
+        }
+        /* Try to write multiple of block sizes */
+        else if (length >= sd->blk_len) {
+            length = QEMU_ALIGN_DOWN(length, sd->blk_len);
+
+            sd->state = sd_programming_state;
+            sd_blk_write(sd, buf, sd->data_start, length);
+            sd->blk_written += length / sd->blk_len;
+            sd->data_start += length;
             sd->csd[14] |= 0x40;
 
-            /* Bzzzzzzztt .... Operation complete.  */
             if (sd->multi_blk_cnt != 0) {
-                if (--sd->multi_blk_cnt == 0) {
+                sd->multi_blk_cnt -= length / sd->blk_len;
+
+                if (sd->multi_blk_cnt == 0) {
                     /* Stop! */
                     sd->state = sd_transfer_state;
                     break;
@@ -2728,6 +2781,12 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
 
             sd->state = sd_receivingdata_state;
         }
+        /* Partial write */
+        else if (length > 0) {
+            memcpy(sd->data, buf, length);
+            sd->data_offset = length;
+        }
+
         break;
 
     case 26:  /* CMD26:  PROGRAM_CID */
@@ -2798,7 +2857,6 @@ static size_t sd_read_data(SDState *sd, void *buf, size_t length)
     const uint8_t dummy_byte = 0x00;
     unsigned int partition_access;
     uint32_t io_len;
-    uint8_t *value = buf;
 
     if (!sd->blk || !blk_is_inserted(sd->blk)) {
         memset(buf, dummy_byte, length);
@@ -2838,36 +2896,94 @@ static size_t sd_read_data(SDState *sd, void *buf, size_t length)
         break;
 
     case 18:  /* CMD18:  READ_MULTIPLE_BLOCK */
+        if (!address_in_range(sd, "READ_MULTIPLE_BLOCK",
+                              sd->data_start + sd->data_offset, length)) {
+            /* Limit reading data to our device size */
+            length = sd->size - sd->data_start - sd->data_offset;
+
+            /* We read past the end, return a dummy read. */
+            if (length == 0) {
+                memset(buf, dummy_byte, 1);
+                return 1;
+            }
+        }
+
+        partition_access = sd->ext_csd[EXT_CSD_PART_CONFIG]
+                & EXT_CSD_PART_CONFIG_ACC_MASK;
+
+        /* We have a partially read block. */
+        if (sd->data_offset > 0) {
+            length = MIN(sd->data_size - sd->data_offset, length);
+
+            memcpy(buf, sd->data + sd->data_offset, length);
+
+            sd->data_offset += length;
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
+            }
+        }
         /*
-         * We will only read one byte at a time. We will be called again with
-         * the remaining buffer.
+         * Try to read multiples of the block size directly bypassing the local
+         * bounce buffer.
+         * Not for RPMB.
          */
-        length = 1;
+        else if (length >= io_len
+                 && partition_access != EXT_CSD_PART_CONFIG_ACC_RPMB) {
+            length = QEMU_ALIGN_DOWN(length, io_len);
 
-        if (sd->data_offset == 0) {
-            if (!address_in_range(sd, "READ_MULTIPLE_BLOCK",
-                                  sd->data_start, io_len)) {
-                return dummy_byte;
+            /* For limited reads, only read the requested block count. */
+            if (sd->multi_blk_cnt != 0) {
+                length = MIN(length, sd->multi_blk_cnt * io_len);
             }
-            partition_access = sd->ext_csd[EXT_CSD_PART_CONFIG]
-                    & EXT_CSD_PART_CONFIG_ACC_MASK;
+
+            sd_blk_read(sd, buf, sd->data_start, length);
+
+            sd->data_start += length;
+
+            if (sd->multi_blk_cnt != 0) {
+                sd->multi_blk_cnt -= length / io_len;
+
+                if (sd->multi_blk_cnt == 0) {
+                    sd->state = sd_transfer_state;
+                }
+            }
+        }
+        /* Read partial at the end or sinlge-block RPMB */
+        else if (length > 0) {
+            length = MIN(length, io_len);
+
+            /* Fill the buffer */
             if (partition_access == EXT_CSD_PART_CONFIG_ACC_RPMB) {
                 emmc_rpmb_blk_read(sd, sd->data_start, io_len);
             } else {
-                sd_blk_read(sd, sd->data_start, io_len);
+                sd_blk_read_bounce_buffer(sd, sd->data_start, io_len);
             }
-        }
-        *value = sd->data[sd->data_offset++];
 
-        if (sd->data_offset >= io_len) {
-            sd->data_start += io_len;
-            sd->data_offset = 0;
+            memcpy(buf, sd->data, length);
 
-            if (sd->multi_blk_cnt != 0) {
-                if (--sd->multi_blk_cnt == 0) {
-                    /* Stop! */
-                    sd->state = sd_transfer_state;
-                    break;
+            sd->data_size = io_len;
+            sd->data_offset = length;
+
+            if (sd->data_offset >= io_len) {
+                sd->data_start += io_len;
+                sd->data_offset = 0;
+
+                if (sd->multi_blk_cnt != 0) {
+                    if (--sd->multi_blk_cnt == 0) {
+                        /* Stop! */
+                        sd->state = sd_transfer_state;
+                        break;
+                    }
                 }
             }
         }

-- 
2.43.0


