Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA3ECFD2F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 14:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQRY4-0005AG-0O; Tue, 02 Dec 2025 09:40:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1vQRY2-00058A-0s; Tue, 02 Dec 2025 09:40:10 -0500
Received: from mail.avm.de ([2001:bf0:244:244::120])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1vQRXz-0001OI-7w; Tue, 02 Dec 2025 09:40:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1764686403; bh=W0C+B/HQ6E2rn8f69u0hr2rqispXBPZi8uNq7mykuhg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Y6+U46lHZ2GrR8CHuSI+ek7+oTstm2phLfLEAcnDdBTNALb5u17MysFpzcnTBcHCu
 KDUwVLEXtzSjZBo3Z0vstHnFZEHAKrQjRABgGy8SxZe2PliKpef2pbf71qtAhpMtpN
 Vxf2kkgnH+xKR/T3aGeD59a9HEcQfr3cTIs6n9sA=
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.53.4)
 (envelope-from <c.speich@avm.de>)
 id 692efa3f-a0ff-7f0000032729-7f000001967c-1
 for <multiple-recipients>; Tue, 02 Dec 2025 15:39:59 +0100
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Tue,  2 Dec 2025 15:39:59 +0100 (CET)
Received: from [127.0.1.1] ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2025120215400012-18429 ;
 Tue, 2 Dec 2025 15:40:00 +0100 
From: Christian Speich <c.speich@avm.de>
Date: Tue, 02 Dec 2025 15:39:34 +0100
Subject: [PATCH v2 4/4] hw/sd/sdcard: Optimize erase blocks as zero.
MIME-Version: 1.0
Message-Id: <20251202-sdcard-performance-b4-v2-4-d42490b11322@avm.de>
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
X-purgate-ID: 149429::1764686399-C5E23D7E-CF67ABBC/0/0
X-purgate-type: clean
X-purgate-size: 3451
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

When erasing blocks as zero, we can use optimized block functions to
achieve this.

These allow us to request a large rage to be zeroed, possible optimizing
this operation and freeing disk space for sparsesly stored images.

This only is possible when erase-blocks-as-zero=true is used and can
provide a significant performance boost. The case where 0xFF is used
during erase is as slow as before.

Signed-off-by: Christian Speich <c.speich@avm.de>
---
 hw/sd/sd.c | 44 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index af7e40faf67c66995b2b615080265dc31da150a6..7fa8e90d36b3b04666de9dfefad5830cb2252b1f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1083,6 +1083,17 @@ static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
     sd_blk_write_direct(sd, sd->data, addr, len);
 }
 
+/* Requires sd->buf to be filled with 0xFF */
+static void sd_erase_ff(SDState *sd, uint64_t addr, size_t len)
+{
+    int erase_len = 1 << HWBLOCK_SHIFT;
+    uint64_t erase_addr;
+
+    for (erase_addr = addr; erase_addr < addr + len; erase_addr += erase_len) {
+        sd_blk_write(sd, erase_addr, erase_len);
+    }
+}
+
 static void sd_erase(SDState *sd)
 {
     uint64_t erase_start = sd->erase_start;
@@ -1090,7 +1101,6 @@ static void sd_erase(SDState *sd)
     bool sdsc = true;
     uint64_t wpnum;
     uint64_t erase_addr;
-    int erase_len = 1 << HWBLOCK_SHIFT;
 
     trace_sdcard_erase(sd->erase_start, sd->erase_end);
     if (sd->erase_start == INVALID_ADDRESS
@@ -1119,24 +1129,38 @@ static void sd_erase(SDState *sd)
     sd->erase_end = INVALID_ADDRESS;
     sd->csd[14] |= 0x40;
 
-    if (sd->erase_blocks_as_zero) {
-        memset(sd->data, 0x0, erase_len);
-    } else {
-        memset(sd->data, 0xFF, erase_len);
+    if (!sd->erase_blocks_as_zero) {
+        memset(sd->data, 0xFF, 1 << HWBLOCK_SHIFT);
     }
 
-    for (erase_addr = erase_start; erase_addr <= erase_end;
-         erase_addr += erase_len) {
-        if (sdsc) {
-            /* Only SDSC cards support write protect groups */
+    /* Only SDSC cards support write protect groups */
+    if (sdsc) {
+        for (erase_addr = erase_start; erase_addr <= erase_end;
+             erase_addr = ROUND_UP(erase_addr + 1, WPGROUP_SIZE)) {
+            uint64_t wp_group_end = ROUND_UP(erase_addr + 1, WPGROUP_SIZE) - 1;
+            size_t to_erase = MIN(erase_end, wp_group_end) - erase_addr;
+
             wpnum = sd_addr_to_wpnum(erase_addr);
             assert(wpnum < sd->wp_group_bits);
             if (test_bit(wpnum, sd->wp_group_bmap)) {
                 sd->card_status |= WP_ERASE_SKIP;
                 continue;
             }
+
+            if (sd->erase_blocks_as_zero) {
+                blk_pwrite_zeroes(sd->blk, erase_addr + sd_part_offset(sd),
+                                  to_erase, 0);
+            } else {
+                sd_erase_ff(sd, erase_addr, to_erase);
+            }
+        }
+    } else {
+        if (sd->erase_blocks_as_zero) {
+            blk_pwrite_zeroes(sd->blk, erase_start + sd_part_offset(sd),
+                              erase_end - erase_start, 0);
+        } else {
+            sd_erase_ff(sd, erase_start, erase_end - erase_start);
         }
-        sd_blk_write(sd, erase_addr, erase_len);
     }
 }
 

-- 
2.43.0


