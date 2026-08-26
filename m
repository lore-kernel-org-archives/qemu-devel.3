Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5C7C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 10:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzAus-00027H-0N; Wed, 26 Aug 2026 06:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1wzAua-000214-Mp
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:31:18 -0400
Received: from [2a14:640:1:12b5::1] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1wzAuZ-0003Op-3O
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:31:16 -0400
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id AA5ABD0CE;
 Wed, 26 Aug 2026 16:01:03 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, xianglai li <lixianglai@loongson.cn>,
 SignKirigami <prcups@krgm.moe>, numpy1314 <xzj13@mail.ustc.edu.cn>
Subject: [PATCH v4 14/14] fix(tcg/loongarch): strip flag bits in lddir/ldpte
 address calculation
Date: Wed, 26 Aug 2026 18:30:18 +0800
Message-ID: <372f72246c404586bc810e48862a650b39cc4866.1787739852.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787739852.git.prcups@krgm.moe>
References: <cover.1787739852.git.prcups@krgm.moe>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2a14:640:1:12b5::1 (failed)
Received-SPF: pass client-ip=2a14:640:1:12b5::1; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 target/loongarch/tcg/tlb_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 776626072d..d75e20baf0 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -887,7 +887,10 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
     }
 
     badvaddr = sys->CSR_TLBRBADV;
-    base = base & palen_mask;
+    /* Extract only the PPN field (bits 12-47) from the directory entry.
+     * Flag bits (V, D, PLV, MAT, etc.) at positions 0-11 must not
+     * participate in the next-level address calculation. */
+    base = (target_ulong)FIELD_EX64(base, TLBENTRY_64, PPN) << TARGET_PAGE_BITS;
     get_dir_base_width(env, &dir_base, &dir_width, level,
                        env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST);
     index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
@@ -912,11 +915,9 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
     uint64_t badv;
     uint64_t ptbase = FIELD_EX64(sys->CSR_PWCL, CSR_PWCL, PTBASE);
     uint64_t ptwidth = FIELD_EX64(sys->CSR_PWCL, CSR_PWCL, PTWIDTH);
-    uint64_t palen_mask = loongarch_palen_mask(env);
     uint64_t dir_base, dir_width;
     uint8_t  ps;
 
-
     /*
      * The parameter "base" has only two types,
      * one is the page table base address,
@@ -959,9 +960,8 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
         }
     } else {
         badv = sys->CSR_TLBRBADV;
-
-        base = base & palen_mask;
-
+        /* Strip flag bits (0-11) from base before address calculation. */
+        base = (target_ulong)FIELD_EX64(base, TLBENTRY_64, PPN) << TARGET_PAGE_BITS;
         ptindex = (badv >> ptbase) & ((1 << ptwidth) - 1);
         ptindex = ptindex & ~0x1;   /* clear bit 0 */
         ptoffset0 = ptindex << 3;
-- 
2.55.0


