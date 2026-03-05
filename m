Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E7EF33A7C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 15:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyACK-0000eA-8A; Thu, 05 Mar 2026 10:01:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@rail5.org>)
 id 1vy9A1-00017r-BH; Thu, 05 Mar 2026 08:54:41 -0500
Received: from layka.disroot.org ([178.21.23.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@rail5.org>)
 id 1vy99z-0006Rf-NM; Thu, 05 Mar 2026 08:54:41 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 3922426F6D;
 Thu,  5 Mar 2026 14:54:38 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id omLkePT48Bul; Thu,  5 Mar 2026 14:54:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rail5.org; s=mail;
 t=1772718877; bh=uEqaoNxvMmFgVA7r47PFAEQsfQQDjD7evQP317PaK30=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ct6j/030fhDKhmLRC0ke04qB8PWgnLIBAMCQKaTUqAWD2WxLkzs74zMSCDmRzhB9n
 1tRj7Fou5ADmWV5hcw+qqcUT9A5twefQBdLvi/0KhbFgT22n9Os+2iyASwJuVLNepL
 hQ8V7ekQQxZxxS4D6iIzuPfLFvGEqTPBb0E16ytF5hZuRocaQN9lSzprbI03N3ynht
 ZC9nidSm7ruCx9IZwXWAWoVRK33z1nUXf4eaq7OIvzBsHd0Yxybhe9BFCWhrHw1Y/X
 6w/j9zZBD5SvB7D6Sv+A9lIRvpL4aiZyXJDC3GTp0cPjIXDxpIqMQ3jOiCDVVoss9N
 CrtftJCaxbxCQ==
To: qemu-devel@nongnu.org
Cc: gaosong@loongson.cn,
	rail5 <andrew@rail5.org>,
	qemu-stable@nongnu.org
Subject: [PATCH 1/2] target/loongarch: Preserve PTE permission bits in
 LDDIR/LDPTE
Date: Thu,  5 Mar 2026 21:54:00 +0800
Message-ID: <20260305135403.831693-2-andrew@rail5.org>
In-Reply-To: <20260305135403.831693-1-andrew@rail5.org>
References: <20260305135403.831693-1-andrew@rail5.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.21.23.139; envelope-from=andrew@rail5.org;
 helo=layka.disroot.org
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 05 Mar 2026 10:00:46 -0500
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
Reply-to:  "Andrew S. Rightenburg" <andrew@rail5.org>
From:  "Andrew S. Rightenburg" via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: rail5 <andrew@rail5.org>

The LDDIR/LDPTE helpers load a page table entry (or huge page entry)
from guest memory and currently apply the PALEN mask to the whole
64-bit value.

That mask is intended to constrain the physical address bits, but masking
the full entry also clears permission bits in the upper part of the PTE,
including NX (bit 62). As a result, LoongArch TCG can incorrectly allow
instruction fetches from NX mappings when translation is driven through
these helpers.

Mask only the PPN/address field and preserve the rest of the PTE.

This was reported as a bug at:
https://gitlab.com/qemu-project/qemu/-/issues/3319

Fixes: 56599a705f2 ("target/loongarch: Introduce loongarch_palen_mask()")
Cc: qemu-stable@nongnu.org
Signed-off-by: rail5 (Andrew S. Rightenburg) <andrew@rail5.org>
---
 target/loongarch/tcg/tlb_helper.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index c1dc77a8f8..8747fa2a0f 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -686,6 +686,24 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     cpu_loop_exit_restore(cs, retaddr);
 }
 
+static inline uint64_t loongarch_mask_pte_ppn(CPULoongArchState *env,
+                                              uint64_t pte)
+{
+    uint64_t palen_mask = loongarch_palen_mask(env);
+
+    if (is_la64(env)) {
+        uint64_t ppn_bits = pte & MAKE_64BIT_MASK(12, 36);
+        uint64_t ppn_masked = ppn_bits & palen_mask;
+
+        return (pte & ~MAKE_64BIT_MASK(12, 36)) | ppn_masked;
+    } else {
+        uint64_t ppn_bits = pte & MAKE_64BIT_MASK(8, 24);
+        uint64_t ppn_masked = ppn_bits & palen_mask;
+
+        return (pte & ~MAKE_64BIT_MASK(8, 24)) | ppn_masked;
+    }
+}
+
 target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
                           uint32_t level, uint32_t mem_idx)
 {
@@ -721,7 +739,7 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
     get_dir_base_width(env, &dir_base, &dir_width, level);
     index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
     phys = base | index << 3;
-    return ldq_le_phys(cs->as, phys) & palen_mask;
+    return loongarch_mask_pte_ppn(env, ldq_le_phys(cs->as, phys));
 }
 
 void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
@@ -729,6 +747,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
 {
     CPUState *cs = env_cpu(env);
     hwaddr phys, tmp0, ptindex, ptoffset0, ptoffset1;
+    uint64_t pte_raw;
     uint64_t badv;
     uint64_t ptbase = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
     uint64_t ptwidth = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
@@ -744,7 +763,6 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
      * and the other is the huge page entry,
      * whose bit 6 should be 1.
      */
-    base = base & palen_mask;
     if (FIELD_EX64(base, TLBENTRY, HUGE)) {
         /*
          * Gets the huge page level and Gets huge page size.
@@ -768,7 +786,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
          * when loaded into the tlb,
          * so the tlb page size needs to be divided by 2.
          */
-        tmp0 = base;
+        tmp0 = loongarch_mask_pte_ppn(env, base);
         if (odd) {
             tmp0 += MAKE_64BIT_MASK(ps, 1);
         }
@@ -780,12 +798,15 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
     } else {
         badv = env->CSR_TLBRBADV;
 
+        base = base & palen_mask;
+
         ptindex = (badv >> ptbase) & ((1 << ptwidth) - 1);
         ptindex = ptindex & ~0x1;   /* clear bit 0 */
         ptoffset0 = ptindex << 3;
         ptoffset1 = (ptindex + 1) << 3;
         phys = base | (odd ? ptoffset1 : ptoffset0);
-        tmp0 = ldq_le_phys(cs->as, phys) & palen_mask;
+        pte_raw = ldq_le_phys(cs->as, phys);
+        tmp0 = loongarch_mask_pte_ppn(env, pte_raw);
         ps = ptbase;
     }
 
-- 
2.47.3


