Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A88F01801
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 07:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyPi6-00087h-4g; Fri, 06 Mar 2026 02:34:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@rail5.org>)
 id 1vyPi5-00087Q-2R; Fri, 06 Mar 2026 02:34:57 -0500
Received: from layka.disroot.org ([178.21.23.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@rail5.org>)
 id 1vyPi3-0002R1-5n; Fri, 06 Mar 2026 02:34:56 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id A6EAC27160;
 Fri,  6 Mar 2026 08:34:53 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rUPdr_VlaXXg; Fri,  6 Mar 2026 08:34:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rail5.org; s=mail;
 t=1772782492; bh=B19YiHxKnJEJtqa02qtLmUPljqI6OXAD7JQY4aObme8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=T7C0fmrWioJCCvdy1PnGoE2yJ75N08/7/GPpdfU405pDzwKkj76sZBvDRUyqUftTT
 1VhAhpBUldjX6FUN5syXWf9NwbgRkKzLl45bMPFhXSiy0QsEwJMnOtcLXSK+VvfqrZ
 laiPUNqo6mtQfGLHymhU/QN17HVIViFBUrHmwBpnili/Qg9tkt0KlU6DRB0SI+fq1c
 strWDoddXcBJpOCYww2y4ihJ1/6YRPLaYO1t5pXRUpahbJ/Wwh8yTC5rz4lS23fkf7
 FTayB5sHN4k3Bw565Z2f2VrxK7aGfJZJd+1VA00o20loc4eNVKsjA+aUoQvxjKQP3q
 olyoxTtZrNu8A==
To: qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, maobibo@loongson.cn, qemu-stable@nongnu.org,
 rail5 <andrew@rail5.org>
Subject: [PATCH v2 1/2] target/loongarch: Preserve PTE permission bits in LDPTE
Date: Fri,  6 Mar 2026 15:33:36 +0800
Message-ID: <20260306073355.899858-2-andrew@rail5.org>
In-Reply-To: <20260306073355.899858-1-andrew@rail5.org>
References: <20260306073355.899858-1-andrew@rail5.org>
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

The LDPTE helper loads a page table entry (or huge page entry) from guest
memory and currently applies the PALEN mask to the whole 64-bit value.

That mask is intended to constrain the physical address bits, but masking
the full entry also clears upper permission bits in the PTE, including NX
(bit 62). As a result, LoongArch TCG can incorrectly allow instruction
fetches from NX mappings when translation is driven through software
page-walk.

Fix this by masking only the PPN/address field with PALEN while preserving
permission bits, and by clearing any non-architectural (software) bits
using a hardware PTE mask. LDDIR is unchanged since it returns the base
address of the next page table level.

Reported at: https://gitlab.com/qemu-project/qemu/-/issues/3319

Fixes: 56599a705f2 ("target/loongarch: Introduce loongarch_palen_mask()")
Cc: qemu-stable@nongnu.org
Signed-off-by: rail5 (Andrew S. Rightenburg) <andrew@rail5.org>
---
 target/loongarch/cpu.c            | 11 +++++++++++
 target/loongarch/cpu.h            |  1 +
 target/loongarch/tcg/tlb_helper.c | 25 ++++++++++++++++++++++---
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 8e8b10505d..e22568c84a 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -596,6 +596,17 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
 
 #ifdef CONFIG_TCG
     env->fcsr0_mask = FCSR0_M1 | FCSR0_M2 | FCSR0_M3;
+
+    if (is_la64(env)) {
+        env->hw_pte_mask = MAKE_64BIT_MASK(0, 9) |
+                           R_TLBENTRY_64_PPN_MASK |
+                           R_TLBENTRY_64_NR_MASK |
+                           R_TLBENTRY_64_NX_MASK |
+                           R_TLBENTRY_64_RPLV_MASK;
+    } else {
+        env->hw_pte_mask = MAKE_64BIT_MASK(0, 9) |
+                           R_TLBENTRY_32_PPN_MASK;
+    }
 #endif
     env->fcsr0 = 0x0;
 
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index d2dfdc8520..4d333806ed 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -406,6 +406,7 @@ typedef struct CPUArchState {
     uint64_t llval;
     uint64_t llval_high; /* For 128-bit atomic SC.Q */
     uint64_t llbit_scq; /* Potential LL.D+LD.D+SC.Q sequence in effect */
+    uint64_t hw_pte_mask; /* Mask of architecturally-defined (hardware) PTE bits. */
 #endif
 #ifndef CONFIG_USER_ONLY
 #ifdef CONFIG_TCG
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index c1dc77a8f8..6581b3b898 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -686,6 +686,21 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     cpu_loop_exit_restore(cs, retaddr);
 }
 
+static inline uint64_t loongarch_sanitize_hw_pte(CPULoongArchState *env,
+                                                 uint64_t pte)
+{
+    uint64_t palen_mask = loongarch_palen_mask(env);
+    uint64_t ppn_mask = is_la64(env) ? R_TLBENTRY_64_PPN_MASK : R_TLBENTRY_32_PPN_MASK;
+
+    /*
+     * Keep only architecturally-defined PTE bits. Guests may use some
+     * otherwise-unused bits for software purposes.
+     */
+    pte &= env->hw_pte_mask;
+
+    return (pte & ~ppn_mask) | ((pte & ppn_mask) & palen_mask);
+}
+
 target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
                           uint32_t level, uint32_t mem_idx)
 {
@@ -729,6 +744,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
 {
     CPUState *cs = env_cpu(env);
     hwaddr phys, tmp0, ptindex, ptoffset0, ptoffset1;
+    uint64_t pte_raw;
     uint64_t badv;
     uint64_t ptbase = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
     uint64_t ptwidth = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
@@ -744,7 +760,6 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
      * and the other is the huge page entry,
      * whose bit 6 should be 1.
      */
-    base = base & palen_mask;
     if (FIELD_EX64(base, TLBENTRY, HUGE)) {
         /*
          * Gets the huge page level and Gets huge page size.
@@ -768,10 +783,11 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
          * when loaded into the tlb,
          * so the tlb page size needs to be divided by 2.
          */
-        tmp0 = base;
+        tmp0 = loongarch_sanitize_hw_pte(env, base);
         if (odd) {
             tmp0 += MAKE_64BIT_MASK(ps, 1);
         }
+        tmp0 = loongarch_sanitize_hw_pte(env, tmp0);
 
         if (!check_ps(env, ps)) {
             qemu_log_mask(LOG_GUEST_ERROR, "Illegal huge pagesize %d\n", ps);
@@ -780,12 +796,15 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
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
+        tmp0 = loongarch_sanitize_hw_pte(env, pte_raw);
         ps = ptbase;
     }
 
-- 
2.47.3


