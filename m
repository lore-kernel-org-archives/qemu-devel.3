Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07230E95396
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 13:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vncqR-0003M4-8e; Wed, 04 Feb 2026 08:22:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1vncqJ-0003Jg-TJ; Wed, 04 Feb 2026 08:22:52 -0500
Received: from mail.avm.de ([2001:bf0:244:244::120])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1vncqH-00031v-If; Wed, 04 Feb 2026 08:22:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1770211360; bh=/RihI8u1CDF18VzrgDTdBBmYo+lDolq/JxdSpafWOnc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=wvvkJa6MZxgWGU/HuGmrfY2ZYQZef7wj9cNE+B6BfJNZ6GFbCNP271Nn4dF6UVsMU
 Hr9m5I3ZkXZ40bOGdyQdu1Xje5eKimOKLQeRLidRflonzI+MxBjlQ4KPyqP2IjuqqI
 eMMJcglI0kZn/jcVdcMutmeEja/ApyEnyIF8zhsg=
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.0)
 (envelope-from <c.speich@avm.de>)
 id 69834820-cb91-7f0000032729-7f000001e250-1
 for <multiple-recipients>; Wed, 04 Feb 2026 14:22:40 +0100
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Wed,  4 Feb 2026 14:22:40 +0100 (CET)
Received: from [127.0.1.1] ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2026020414223967-15153 ;
 Wed, 4 Feb 2026 14:22:39 +0100 
From: Christian Speich <c.speich@avm.de>
Date: Wed, 04 Feb 2026 14:22:30 +0100
Subject: [PATCH v3 6/6] hw/sd/sdcard: Optimize erase blocks as zero.
MIME-Version: 1.0
Message-Id: <20260204-sdcard-performance-b4-v3-6-dc1cf172ee57@avm.de>
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
 04.02.2026 14:22:41, Serialize complete at 04.02.2026 14:22:41
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-purgate-ID: 149429::1770211360-C265E65A-0BDC057E/0/0
X-purgate-type: clean
X-purgate-size: 3416
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
 hw/sd/sd.c | 44 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 5ddaa08d77b6b7606005fb59f42f107d254d6e5c..6e3afedbf45d59c2c9b48505ed144a788bc76760 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1331,6 +1331,17 @@ exit:
     trace_sdcard_rpmb_write_block(req, lduw_be_p(&sd->rpmb.result.result));
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
@@ -1338,7 +1349,6 @@ static void sd_erase(SDState *sd)
     bool sdsc = true;
     uint64_t wpnum;
     uint64_t erase_addr;
-    int erase_len = 1 << HWBLOCK_SHIFT;
 
     trace_sdcard_erase(sd->erase_start, sd->erase_end);
     if (sd->erase_start == INVALID_ADDRESS
@@ -1367,24 +1377,38 @@ static void sd_erase(SDState *sd)
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


