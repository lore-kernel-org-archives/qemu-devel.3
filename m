Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FE2CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 13:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbcJ-0004WV-DB; Fri, 19 Sep 2025 09:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1uzaKq-0001xu-Lp; Fri, 19 Sep 2025 08:35:32 -0400
Received: from mail.avm.de ([212.42.244.120])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1uzaKh-00005R-T4; Fri, 19 Sep 2025 08:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1758285310; bh=+xeUtlXnOkzvUlUWqkuBl6HavCwXzUB2iouZMxnO2Xc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=HfDCIJZDLoZ2gxExc0bZa0v/Xx+bghyCTUJK9eQa8g6cBYYpKrOYvOXyY0xkT4L3r
 sfUtoL7Nlv2vovmU5Diiu1XTPrROimCpdnS6+6/bt1FDtYUqKGYliH0ehS/8CDn6M9
 14GCWOFIGS1G+Vwtiiw5xWfctQ2nuHZcLdJON3Lw=
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.53.4)
 (envelope-from <c.speich@avm.de>)
 id 68cd4dfe-c042-7f0000032729-7f000001888a-1
 for <multiple-recipients>; Fri, 19 Sep 2025 14:35:10 +0200
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Fri, 19 Sep 2025 14:35:10 +0200 (CEST)
Received: from [127.0.1.1] ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2025091914351039-13018 ;
 Fri, 19 Sep 2025 14:35:10 +0200 
From: Christian Speich <c.speich@avm.de>
Date: Fri, 19 Sep 2025 14:34:43 +0200
Subject: [PATCH 4/4] hw/sd/sdcard: Erase in large blocks
MIME-Version: 1.0
Message-Id: <20250919-sdcard-performance-b4-v1-4-e1037e481a19@avm.de>
References: <20250919-sdcard-performance-b4-v1-0-e1037e481a19@avm.de>
In-Reply-To: <20250919-sdcard-performance-b4-v1-0-e1037e481a19@avm.de>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Bin Meng
 <bmeng.cn@gmail.com>, qemu-block@nongnu.org, Christian Speich
 <c.speich@avm.de>
X-Mailer: b4 0.14.2
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 14.0FP4|March 10,
 2025) at 19.09.2025 14:35:10,
 Serialize by Router on ANIS1/AVM(Release 14.0FP4|March 10, 2025) at
 19.09.2025 14:35:11, Serialize complete at 19.09.2025 14:35:11
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-purgate-ID: 149429::1758285310-16E67DB6-1A0AF395/0/0
X-purgate-type: clean
X-purgate-size: 2076
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
Received-SPF: pass client-ip=212.42.244.120; envelope-from=c.speich@avm.de;
 helo=mail.avm.de
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 19 Sep 2025 09:57:37 -0400
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

Erasing each block individually is slow, so this patch reworks the logic
to erase as much as possible in one go.

Signed-off-by: Christian Speich <c.speich@avm.de>
---
 hw/sd/sd.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 94ef3cc62582717ee044c4b114b7f22bd1b4a256..42870fa19414be61e43d2e07619ed193cc514319 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1086,7 +1086,6 @@ static void sd_erase(SDState *sd)
     bool sdsc = true;
     uint64_t wpnum;
     uint64_t erase_addr;
-    int erase_len = 1 << HWBLOCK_SHIFT;
 
     trace_sdcard_erase(sd->erase_start, sd->erase_end);
     if (sd->erase_start == INVALID_ADDRESS
@@ -1115,19 +1114,26 @@ static void sd_erase(SDState *sd)
     sd->erase_end = INVALID_ADDRESS;
     sd->csd[14] |= 0x40;
 
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
+            blk_pwrite_zeroes(sd->blk, erase_addr + sd_part_offset(sd),
+                              to_erase, 0);
         }
-        blk_pwrite_zeroes(sd->blk, erase_addr + sd_part_offset(sd),
-                          erase_len, 0);
+    } else {
+        blk_pwrite_zeroes(sd->blk, erase_start + sd_part_offset(sd),
+                          erase_end - erase_start, 0);
     }
 }
 

-- 
2.43.0


