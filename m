Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA73C982CC
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 02:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x87Vk-0006ZL-Uw; Sat, 19 Sep 2026 22:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1x87Vi-0006ZD-UH
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 22:42:34 -0400
Received: from krgm.moe ([103.47.186.116])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1x87Vg-0005Ms-QW
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 22:42:34 -0400
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id 27B2CDFC8;
 Sun, 20 Sep 2026 08:12:26 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 SignKirigami <prcups@krgm.moe>, numpy1314 <xzj13@mail.ustc.edu.cn>
Subject: [PATCH v2 RESEND] tcg/loongarch: strip flag bits in lddir/ldpte
 address calculation
Date: Sun, 20 Sep 2026 10:42:17 +0800
Message-ID: <20260920024217.18116-1-prcups@krgm.moe>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.47.186.116; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

helper_lddir and helper_ldpte used TARGET_PHYS_MASK (bits 0-47) when
extracting the base address from a directory entry.  This retained flag
bits (V, D, PLV, MAT, etc.) at positions 0-11, which were then OR'd
with the next-level index, producing a wrong physical address whenever
the directory entry carried non-zero flags.

Fix both helpers to extract only the PPN field (bits 12-47) before
computing the address of the next-level page table entry.

Signed-off-by: numpy1314 <xzj13@mail.ustc.edu.cn>
Signed-off-by: SignKirigami <prcups@krgm.moe>
---
This patch is a resend of [1], Sorry for wrongly handling Signed-off-by.
 
[1]: https://lists.gnu.org/archive/html/qemu-devel/2026-09/msg05581.html.
 
 target/loongarch/tcg/tlb_helper.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 40cc076424..529b22347d 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -750,7 +750,7 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
     }
 
     badvaddr = sys->CSR_TLBRBADV;
-    base = base & palen_mask;
+    base = base & palen_mask & ~MAKE_64BIT_MASK(0, 12);
     get_dir_base_width(env, &dir_base, &dir_width, level);
     index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
     phys = base | index << 3;
@@ -773,7 +773,6 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
     uint64_t dir_base, dir_width;
     uint8_t  ps;
 
-
     /*
      * The parameter "base" has only two types,
      * one is the page table base address,
@@ -815,9 +814,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
         }
     } else {
         badv = sys->CSR_TLBRBADV;
-
-        base = base & palen_mask;
-
+        base = base & palen_mask & ~MAKE_64BIT_MASK(0, 12);
         ptindex = (badv >> ptbase) & ((1 << ptwidth) - 1);
         ptindex = ptindex & ~0x1;   /* clear bit 0 */
         ptoffset0 = ptindex << 3;
-- 
2.55.0


