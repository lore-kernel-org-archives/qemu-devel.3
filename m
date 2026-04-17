Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDB1F4368A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDfxf-0003Ku-Fg; Fri, 17 Apr 2026 05:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1wDfxB-0002pp-OO; Fri, 17 Apr 2026 05:57:37 -0400
Received: from mail.avm.de ([2001:bf0:244:244::119])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1wDfx9-000389-GR; Fri, 17 Apr 2026 05:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1776419846; bh=5SYH+A8NyAGbb6vSKm8RhEoSuVLKy93+R7omElZI8D4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=ZK9i54fox3XJjwgzlj4oZZGMT+xviuIjKa+l5O2HvQKizvFaHch20mI7QrWVrhR7G
 XkISUDdCmBiW5aQYukofDLW5d5bDLo6CdBz0ziQDpBt5zdHrQrhKqSLoPkHIIqdZfQ
 ooHJafZY5mXIDPjh+dBlIRsOKJRQ6aNcYzQ+yBrk=
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.2)
 (envelope-from <c.speich@avm.de>)
 id 69e20406-1e6c-7f0000032729-7f000001b2c4-1
 for <multiple-recipients>; Fri, 17 Apr 2026 11:57:26 +0200
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Fri, 17 Apr 2026 11:57:26 +0200 (CEST)
Received: from [127.0.1.1] ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2026041711572445-2979 ;
 Fri, 17 Apr 2026 11:57:24 +0200 
From: Christian Speich <c.speich@avm.de>
Date: Fri, 17 Apr 2026 11:51:39 +0200
Subject: [PATCH v4 6/7] hw/sd/sdcard: Optimize erase blocks as zero.
MIME-Version: 1.0
Message-Id: <20260417-sdcard-performance-b4-v4-6-119e66be10c2@avm.de>
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
 17.04.2026 11:57:26, Serialize complete at 17.04.2026 11:57:26
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-purgate-ID: 149429::1776419846-50F26373-590759AA/0/0
X-purgate-type: clean
X-purgate-size: 3267
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
Received-SPF: pass client-ip=2001:bf0:244:244::119;
 envelope-from=c.speich@avm.de; helo=mail.avm.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When erasing blocks as zero, we can use optimized block functions to
achieve this.

These allow us to request a large rage to be zeroed, possible optimizing
this operation and freeing disk space for sparsesly stored images.

This only is possible when erase-blocks-as-zero=true is used and can
provide a significant performance boost. The case where 0xFF is used
during erase is as slow as before.

Signed-off-by: Christian Speich <c.speich@avm.de>
---
 hw/sd/sd.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 0f997ed8cc80e38645101cb8f47c86f1c30d5a25..d1ff9badb39b699ce734a533ccebfab894958d2d 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1331,6 +1331,26 @@ exit:
     trace_sdcard_rpmb_write_block(req, lduw_be_p(&sd->rpmb.result.result));
 }
 
+/* Requires sd->buf to be filled with 0xFF */
+static void sd_erase_ff(SDState *sd, uint64_t addr, size_t len)
+{
+    int erase_len = 1 << HWBLOCK_SHIFT;
+    uint64_t erase_addr;
+
+    for (erase_addr = addr; erase_addr < addr + len; erase_addr += erase_len) {
+        sd_blk_write_bounce_buffer(sd, erase_addr, erase_len);
+    }
+}
+
+static void sd_blk_erase(SDState *sd, uint64_t addr, size_t len)
+{
+    if (sd->erase_blocks_as_zero) {
+        blk_pwrite_zeroes(sd->blk, addr + sd_part_offset(sd), len, 0);
+    } else {
+        sd_erase_ff(sd, addr, len);
+    }
+}
+
 static void sd_erase(SDState *sd)
 {
     uint64_t erase_start = sd->erase_start;
@@ -1338,7 +1358,6 @@ static void sd_erase(SDState *sd)
     bool sdsc = true;
     uint64_t wpnum;
     uint64_t erase_addr;
-    int erase_len = 1 << HWBLOCK_SHIFT;
 
     trace_sdcard_erase(sd->erase_start, sd->erase_end);
     if (sd->erase_start == INVALID_ADDRESS
@@ -1367,24 +1386,28 @@ static void sd_erase(SDState *sd)
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
+            size_t erase_len = MIN(erase_end, wp_group_end) - erase_addr;
+
             wpnum = sd_addr_to_wpnum(erase_addr);
             assert(wpnum < sd->wp_group_bits);
             if (test_bit(wpnum, sd->wp_group_bmap)) {
                 sd->card_status |= WP_ERASE_SKIP;
                 continue;
             }
+
+            sd_blk_erase(sd, erase_addr, erase_len);
         }
-        sd_blk_write_bounce_buffer(sd, erase_addr, erase_len);
+    } else {
+        sd_blk_erase(sd, erase_start, erase_end - erase_start);
     }
 }
 

-- 
2.43.0


