Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99F8C25B7E
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 23:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBN4o-0004RL-6b; Sun, 26 May 2024 19:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN4l-0004Oa-ED; Sun, 26 May 2024 19:14:51 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN4h-0003iN-Cv; Sun, 26 May 2024 19:14:51 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A474A4E63BF;
 Mon, 27 May 2024 01:13:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id w-6wHNXnj4os; Mon, 27 May 2024 01:13:06 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B79294E61E6; Mon, 27 May 2024 01:13:06 +0200 (CEST)
Message-Id: <d024465e3cf461c3106e758d753b93cc2590eaba.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1716763435.git.balaton@eik.bme.hu>
References: <cover.1716763435.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 30/43] target/ppc: Unexport some functions from mmu-book3s-v3.h
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 27 May 2024 01:13:06 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The ppc_hash64_hpt_base() and ppc_hash64_hpt_mask() functions are
mostly used by mmu-hash64.c only but there is one call to
ppc_hash64_hpt_mask() in hw/ppc/spapr_vhyp_mmu.c.in a helper function
that can be moved to mmu-hash64.c which allows these functions to be
removed from the header.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/spapr_vhyp_mmu.c    | 21 ++++------------
 target/ppc/mmu-book3s-v3.h | 40 -------------------------------
 target/ppc/mmu-hash64.c    | 49 ++++++++++++++++++++++++++++++++++++++
 target/ppc/mmu-hash64.h    |  1 +
 4 files changed, 54 insertions(+), 57 deletions(-)

diff --git a/hw/ppc/spapr_vhyp_mmu.c b/hw/ppc/spapr_vhyp_mmu.c
index b3dd8b3a59..2d41d7f77b 100644
--- a/hw/ppc/spapr_vhyp_mmu.c
+++ b/hw/ppc/spapr_vhyp_mmu.c
@@ -15,19 +15,6 @@
 #include "helper_regs.h"
 #include "hw/ppc/spapr.h"
 #include "mmu-hash64.h"
-#include "mmu-book3s-v3.h"
-
-
-static inline bool valid_ptex(PowerPCCPU *cpu, target_ulong ptex)
-{
-    /*
-     * hash value/pteg group index is normalized by HPT mask
-     */
-    if (((ptex & ~7ULL) / HPTES_PER_GROUP) & ~ppc_hash64_hpt_mask(cpu)) {
-        return false;
-    }
-    return true;
-}
 
 static target_ulong h_enter(PowerPCCPU *cpu, SpaprMachineState *spapr,
                             target_ulong opcode, target_ulong *args)
@@ -70,7 +57,7 @@ static target_ulong h_enter(PowerPCCPU *cpu, SpaprMachineState *spapr,
 
     pteh &= ~0x60ULL;
 
-    if (!valid_ptex(cpu, ptex)) {
+    if (!ppc_hash64_valid_ptex(cpu, ptex)) {
         return H_PARAMETER;
     }
 
@@ -119,7 +106,7 @@ static RemoveResult remove_hpte(PowerPCCPU *cpu
     const ppc_hash_pte64_t *hptes;
     target_ulong v, r;
 
-    if (!valid_ptex(cpu, ptex)) {
+    if (!ppc_hash64_valid_ptex(cpu, ptex)) {
         return REMOVE_PARM;
     }
 
@@ -250,7 +237,7 @@ static target_ulong h_protect(PowerPCCPU *cpu, SpaprMachineState *spapr,
     const ppc_hash_pte64_t *hptes;
     target_ulong v, r;
 
-    if (!valid_ptex(cpu, ptex)) {
+    if (!ppc_hash64_valid_ptex(cpu, ptex)) {
         return H_PARAMETER;
     }
 
@@ -287,7 +274,7 @@ static target_ulong h_read(PowerPCCPU *cpu, SpaprMachineState *spapr,
     int i, ridx, n_entries = 1;
     const ppc_hash_pte64_t *hptes;
 
-    if (!valid_ptex(cpu, ptex)) {
+    if (!ppc_hash64_valid_ptex(cpu, ptex)) {
         return H_PARAMETER;
     }
 
diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
index f3f7993958..263ce55c1f 100644
--- a/target/ppc/mmu-book3s-v3.h
+++ b/target/ppc/mmu-book3s-v3.h
@@ -83,46 +83,6 @@ static inline bool ppc64_v3_radix(PowerPCCPU *cpu)
     return !!(cpu->env.spr[SPR_LPCR] & LPCR_HR);
 }
 
-static inline hwaddr ppc_hash64_hpt_base(PowerPCCPU *cpu)
-{
-    uint64_t base;
-
-    if (cpu->vhyp) {
-        return 0;
-    }
-    if (cpu->env.mmu_model == POWERPC_MMU_3_00) {
-        ppc_v3_pate_t pate;
-
-        if (!ppc64_v3_get_pate(cpu, cpu->env.spr[SPR_LPIDR], &pate)) {
-            return 0;
-        }
-        base = pate.dw0;
-    } else {
-        base = cpu->env.spr[SPR_SDR1];
-    }
-    return base & SDR_64_HTABORG;
-}
-
-static inline hwaddr ppc_hash64_hpt_mask(PowerPCCPU *cpu)
-{
-    uint64_t base;
-
-    if (cpu->vhyp) {
-        return cpu->vhyp_class->hpt_mask(cpu->vhyp);
-    }
-    if (cpu->env.mmu_model == POWERPC_MMU_3_00) {
-        ppc_v3_pate_t pate;
-
-        if (!ppc64_v3_get_pate(cpu, cpu->env.spr[SPR_LPIDR], &pate)) {
-            return 0;
-        }
-        base = pate.dw0;
-    } else {
-        base = cpu->env.spr[SPR_SDR1];
-    }
-    return (1ULL << ((base & SDR_64_HTABSIZE) + 18 - 7)) - 1;
-}
-
 #endif /* TARGET_PPC64 */
 
 #endif /* CONFIG_USER_ONLY */
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index cbc8efa0c3..7bc0323f26 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -508,6 +508,46 @@ static int ppc_hash64_amr_prot(PowerPCCPU *cpu, ppc_hash_pte64_t pte)
     return prot;
 }
 
+static hwaddr ppc_hash64_hpt_base(PowerPCCPU *cpu)
+{
+    uint64_t base;
+
+    if (cpu->vhyp) {
+        return 0;
+    }
+    if (cpu->env.mmu_model == POWERPC_MMU_3_00) {
+        ppc_v3_pate_t pate;
+
+        if (!ppc64_v3_get_pate(cpu, cpu->env.spr[SPR_LPIDR], &pate)) {
+            return 0;
+        }
+        base = pate.dw0;
+    } else {
+        base = cpu->env.spr[SPR_SDR1];
+    }
+    return base & SDR_64_HTABORG;
+}
+
+static hwaddr ppc_hash64_hpt_mask(PowerPCCPU *cpu)
+{
+    uint64_t base;
+
+    if (cpu->vhyp) {
+        return cpu->vhyp_class->hpt_mask(cpu->vhyp);
+    }
+    if (cpu->env.mmu_model == POWERPC_MMU_3_00) {
+        ppc_v3_pate_t pate;
+
+        if (!ppc64_v3_get_pate(cpu, cpu->env.spr[SPR_LPIDR], &pate)) {
+            return 0;
+        }
+        base = pate.dw0;
+    } else {
+        base = cpu->env.spr[SPR_SDR1];
+    }
+    return (1ULL << ((base & SDR_64_HTABSIZE) + 18 - 7)) - 1;
+}
+
 const ppc_hash_pte64_t *ppc_hash64_map_hptes(PowerPCCPU *cpu,
                                              hwaddr ptex, int n)
 {
@@ -545,6 +585,15 @@ void ppc_hash64_unmap_hptes(PowerPCCPU *cpu, const ppc_hash_pte64_t *hptes,
                         false, n * HASH_PTE_SIZE_64);
 }
 
+bool ppc_hash64_valid_ptex(PowerPCCPU *cpu, target_ulong ptex)
+{
+    /* hash value/pteg group index is normalized by HPT mask */
+    if (((ptex & ~7ULL) / HPTES_PER_GROUP) & ~ppc_hash64_hpt_mask(cpu)) {
+        return false;
+    }
+    return true;
+}
+
 static unsigned hpte_page_shift(const PPCHash64SegmentPageSizes *sps,
                                 uint64_t pte0, uint64_t pte1)
 {
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index de653fcae5..ae8d4b37ae 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -120,6 +120,7 @@ const ppc_hash_pte64_t *ppc_hash64_map_hptes(PowerPCCPU *cpu,
                                              hwaddr ptex, int n);
 void ppc_hash64_unmap_hptes(PowerPCCPU *cpu, const ppc_hash_pte64_t *hptes,
                             hwaddr ptex, int n);
+bool ppc_hash64_valid_ptex(PowerPCCPU *cpu, target_ulong ptex);
 
 static inline uint64_t ppc_hash64_hpte0(PowerPCCPU *cpu,
                                         const ppc_hash_pte64_t *hptes, int i)
-- 
2.30.9


