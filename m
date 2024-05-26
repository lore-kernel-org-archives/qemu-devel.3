Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658A0C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 23:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBN5I-0006Ac-Nb; Sun, 26 May 2024 19:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN5E-0005qX-84; Sun, 26 May 2024 19:15:20 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN55-0003oo-Ud; Sun, 26 May 2024 19:15:19 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 28D654E6551;
 Mon, 27 May 2024 01:13:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id AbEElVP9mDll; Mon, 27 May 2024 01:13:18 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2D3624E6552; Mon, 27 May 2024 01:13:18 +0200 (CEST)
Message-Id: <3e26fb6adddef0804adfbfb2fdc0fe664555ef0a.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1716763435.git.balaton@eik.bme.hu>
References: <cover.1716763435.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 41/43] target/ppc: Change MMU xlate functions to take CPUState
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 27 May 2024 01:13:18 +0200 (CEST)
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

The callers of xlate functions get CPUState which is then cast to
PowerPCCPU that is then cast back to CPUState by most xlate functions.
Avoid this back and forth casting by passing the existing CPUState to
xlate functions and let them convert it as needed.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/internal.h    |  2 +-
 target/ppc/mmu-booke.c   |  5 ++--
 target/ppc/mmu-booke.h   |  2 +-
 target/ppc/mmu-hash32.c  |  4 +--
 target/ppc/mmu-hash32.h  |  2 +-
 target/ppc/mmu-hash64.c  |  4 +--
 target/ppc/mmu-hash64.h  |  2 +-
 target/ppc/mmu-radix64.c |  7 +++---
 target/ppc/mmu-radix64.h |  2 +-
 target/ppc/mmu_common.c  | 54 +++++++++++++++++++---------------------
 target/ppc/mmu_helper.c  |  9 +++----
 11 files changed, 45 insertions(+), 48 deletions(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 66ce22bbe9..753fae219c 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -251,7 +251,7 @@ static inline int check_prot_access_type(int prot, MMUAccessType access_type)
 
 /* PowerPC MMU emulation */
 
-bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
+bool ppc_xlate(CPUState *cs, vaddr eaddr, MMUAccessType access_type,
                       hwaddr *raddrp, int *psizep, int *protp,
                       int mmu_idx, bool guest_visible);
 
diff --git a/target/ppc/mmu-booke.c b/target/ppc/mmu-booke.c
index 55e5dd7c6b..dd4ea48151 100644
--- a/target/ppc/mmu-booke.c
+++ b/target/ppc/mmu-booke.c
@@ -473,12 +473,11 @@ static void booke206_update_mas_tlb_miss(CPUPPCState *env, target_ulong address,
     env->spr[SPR_BOOKE_MAS0] |= env->last_way << MAS0_NV_SHIFT;
 }
 
-bool ppc_booke_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
+bool ppc_booke_xlate(CPUState *cs, vaddr eaddr, MMUAccessType access_type,
                      hwaddr *raddrp, int *psizep, int *protp, int mmu_idx,
                      bool guest_visible)
 {
-    CPUState *cs = CPU(cpu);
-    CPUPPCState *env = &cpu->env;
+    CPUPPCState *env = cpu_env(cs);
     hwaddr raddr;
     int prot, ret;
 
diff --git a/target/ppc/mmu-booke.h b/target/ppc/mmu-booke.h
index f972843bbb..6c90139be0 100644
--- a/target/ppc/mmu-booke.h
+++ b/target/ppc/mmu-booke.h
@@ -10,7 +10,7 @@ int mmu40x_get_physical_address(CPUPPCState *env, hwaddr *raddr, int *prot,
 hwaddr booke206_tlb_to_page_size(CPUPPCState *env, ppcmas_tlb_t *tlb);
 int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb, hwaddr *raddrp,
                      target_ulong address, uint32_t pid);
-bool ppc_booke_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
+bool ppc_booke_xlate(CPUState *cs, vaddr eaddr, MMUAccessType access_type,
                      hwaddr *raddrp, int *psizep, int *protp, int mmu_idx,
                      bool guest_visible);
 
diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index f18faf0f46..82a02881c2 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -279,11 +279,11 @@ static hwaddr ppc_hash32_htab_lookup(PowerPCCPU *cpu,
     return pte_addr;
 }
 
-bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
+bool ppc_hash32_xlate(CPUState *cs, vaddr eaddr, MMUAccessType access_type,
                       hwaddr *raddrp, int *psizep, int *protp, int mmu_idx,
                       bool guest_visible)
 {
-    CPUState *cs = CPU(cpu);
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
     target_ulong sr;
     hwaddr pte_addr, raddr;
diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
index ec8d881def..d9e4977bdc 100644
--- a/target/ppc/mmu-hash32.h
+++ b/target/ppc/mmu-hash32.h
@@ -3,7 +3,7 @@
 
 #ifndef CONFIG_USER_ONLY
 
-bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
+bool ppc_hash32_xlate(CPUState *cs, vaddr eaddr, MMUAccessType access_type,
                       hwaddr *raddrp, int *psizep, int *protp, int mmu_idx,
                       bool guest_visible);
 
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 5e1983e334..1559683626 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -979,11 +979,11 @@ static int build_vrma_slbe(PowerPCCPU *cpu, ppc_slb_t *slb)
     return -1;
 }
 
-bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
+bool ppc_hash64_xlate(CPUState *cs, vaddr eaddr, MMUAccessType access_type,
                       hwaddr *raddrp, int *psizep, int *protp, int mmu_idx,
                       bool guest_visible)
 {
-    CPUState *cs = CPU(cpu);
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
     ppc_slb_t vrma_slbe;
     ppc_slb_t *slb;
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index ae8d4b37ae..0c475642e0 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -7,7 +7,7 @@
 void dump_slb(PowerPCCPU *cpu);
 int ppc_store_slb(PowerPCCPU *cpu, target_ulong slot,
                   target_ulong esid, target_ulong vsid);
-bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
+bool ppc_hash64_xlate(CPUState *cs, vaddr eaddr, MMUAccessType access_type,
                       hwaddr *raddrp, int *psizep, int *protp, int mmu_idx,
                       bool guest_visible);
 void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu,
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index be7a45f254..1ca7f9089a 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -675,11 +675,12 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu,
  *              | = On        | Process Scoped |    Scoped     |
  *              +-------------+----------------+---------------+
  */
-static bool ppc_radix64_xlate_impl(PowerPCCPU *cpu, vaddr eaddr,
+static bool ppc_radix64_xlate_impl(CPUState *cs, vaddr eaddr,
                                    MMUAccessType access_type, hwaddr *raddr,
                                    int *psizep, int *protp, int mmu_idx,
                                    bool guest_visible)
 {
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
     uint64_t lpid, pid;
     ppc_v3_pate_t pate;
@@ -805,11 +806,11 @@ static bool ppc_radix64_xlate_impl(PowerPCCPU *cpu, vaddr eaddr,
     return true;
 }
 
-bool ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
+bool ppc_radix64_xlate(CPUState *cs, vaddr eaddr, MMUAccessType access_type,
                        hwaddr *raddrp, int *psizep, int *protp, int mmu_idx,
                        bool guest_visible)
 {
-    bool ret = ppc_radix64_xlate_impl(cpu, eaddr, access_type, raddrp,
+    bool ret = ppc_radix64_xlate_impl(cs, eaddr, access_type, raddrp,
                                       psizep, protp, mmu_idx, guest_visible);
 
     qemu_log_mask(CPU_LOG_MMU, "%s for %s @0x%"VADDR_PRIx
diff --git a/target/ppc/mmu-radix64.h b/target/ppc/mmu-radix64.h
index 6620b3d648..3758393883 100644
--- a/target/ppc/mmu-radix64.h
+++ b/target/ppc/mmu-radix64.h
@@ -14,7 +14,7 @@
 #define R_EADDR_QUADRANT2       0x8000000000000000
 #define R_EADDR_QUADRANT3       0xC000000000000000
 
-bool ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
+bool ppc_radix64_xlate(CPUState *cs, vaddr eaddr, MMUAccessType access_type,
                        hwaddr *raddr, int *psizep, int *protp, int mmu_idx,
                        bool guest_visible);
 
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index ab055ca96b..8d590a9496 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -579,11 +579,11 @@ void dump_mmu(CPUPPCState *env)
 }
 
 
-static bool ppc_real_mode_xlate(PowerPCCPU *cpu, vaddr eaddr,
+static bool ppc_real_mode_xlate(CPUState *cs, vaddr eaddr,
                                 MMUAccessType access_type,
                                 hwaddr *raddrp, int *psizep, int *protp)
 {
-    CPUPPCState *env = &cpu->env;
+    CPUPPCState *env = cpu_env(cs);
 
     if (access_type == MMU_INST_FETCH ? !FIELD_EX64(env->msr, MSR, IR)
                                       : !FIELD_EX64(env->msr, MSR, DR)) {
@@ -592,21 +592,20 @@ static bool ppc_real_mode_xlate(PowerPCCPU *cpu, vaddr eaddr,
         *psizep = TARGET_PAGE_BITS;
         return true;
     } else if (env->mmu_model == POWERPC_MMU_REAL) {
-        cpu_abort(CPU(cpu), "PowerPC in real mode shold not do translation\n");
+        cpu_abort(cs, "PowerPC in real mode shold not do translation\n");
     }
     return false;
 }
 
-static bool ppc_40x_xlate(PowerPCCPU *cpu, vaddr eaddr,
+static bool ppc_40x_xlate(CPUState *cs, vaddr eaddr,
                           MMUAccessType access_type,
                           hwaddr *raddrp, int *psizep, int *protp,
                           int mmu_idx, bool guest_visible)
 {
-    CPUState *cs = CPU(cpu);
-    CPUPPCState *env = &cpu->env;
+    CPUPPCState *env = cpu_env(cs);
     int ret;
 
-    if (ppc_real_mode_xlate(cpu, eaddr, access_type, raddrp, psizep, protp)) {
+    if (ppc_real_mode_xlate(cs, eaddr, access_type, raddrp, psizep, protp)) {
         return true;
     }
 
@@ -665,18 +664,17 @@ static bool ppc_40x_xlate(PowerPCCPU *cpu, vaddr eaddr,
     return false;
 }
 
-static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eaddr,
+static bool ppc_6xx_xlate(CPUState *cs, vaddr eaddr,
                           MMUAccessType access_type,
                           hwaddr *raddrp, int *psizep, int *protp,
                           int mmu_idx, bool guest_visible)
 {
-    CPUState *cs = CPU(cpu);
-    CPUPPCState *env = &cpu->env;
+    CPUPPCState *env = cpu_env(cs);
     hwaddr hash = 0; /* init to 0 to avoid used uninit warning */
     bool key;
     int type, ret;
 
-    if (ppc_real_mode_xlate(cpu, eaddr, access_type, raddrp, psizep, protp)) {
+    if (ppc_real_mode_xlate(cs, eaddr, access_type, raddrp, psizep, protp)) {
         return true;
     }
 
@@ -803,15 +801,15 @@ tlb_miss:
 
 /*****************************************************************************/
 
-bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
+bool ppc_xlate(CPUState *cs, vaddr eaddr, MMUAccessType access_type,
                       hwaddr *raddrp, int *psizep, int *protp,
                       int mmu_idx, bool guest_visible)
 {
-    switch (cpu->env.mmu_model) {
+    switch (cpu_env(cs)->mmu_model) {
 #if defined(TARGET_PPC64)
     case POWERPC_MMU_3_00:
-        if (ppc64_v3_radix(&cpu->env)) {
-            return ppc_radix64_xlate(cpu, eaddr, access_type, raddrp,
+        if (ppc64_v3_radix(cpu_env(cs))) {
+            return ppc_radix64_xlate(cs, eaddr, access_type, raddrp,
                                      psizep, protp, mmu_idx, guest_visible);
         }
         /* fall through */
@@ -819,36 +817,36 @@ bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     case POWERPC_MMU_2_03:
     case POWERPC_MMU_2_06:
     case POWERPC_MMU_2_07:
-        return ppc_hash64_xlate(cpu, eaddr, access_type,
+        return ppc_hash64_xlate(cs, eaddr, access_type,
                                 raddrp, psizep, protp, mmu_idx, guest_visible);
 #endif
 
     case POWERPC_MMU_32B:
-        return ppc_hash32_xlate(cpu, eaddr, access_type, raddrp,
+        return ppc_hash32_xlate(cs, eaddr, access_type, raddrp,
                                psizep, protp, mmu_idx, guest_visible);
     case POWERPC_MMU_BOOKE:
     case POWERPC_MMU_BOOKE206:
-        return ppc_booke_xlate(cpu, eaddr, access_type, raddrp,
+        return ppc_booke_xlate(cs, eaddr, access_type, raddrp,
                                psizep, protp, mmu_idx, guest_visible);
     case POWERPC_MMU_SOFT_4xx:
-        return ppc_40x_xlate(cpu, eaddr, access_type, raddrp,
+        return ppc_40x_xlate(cs, eaddr, access_type, raddrp,
                              psizep, protp, mmu_idx, guest_visible);
     case POWERPC_MMU_SOFT_6xx:
-        return ppc_6xx_xlate(cpu, eaddr, access_type, raddrp,
+        return ppc_6xx_xlate(cs, eaddr, access_type, raddrp,
                              psizep, protp, mmu_idx, guest_visible);
     case POWERPC_MMU_REAL:
-        return ppc_real_mode_xlate(cpu, eaddr, access_type, raddrp, psizep,
+        return ppc_real_mode_xlate(cs, eaddr, access_type, raddrp, psizep,
                                    protp);
     case POWERPC_MMU_MPC8xx:
-        cpu_abort(env_cpu(&cpu->env), "MPC8xx MMU model is not implemented\n");
+        cpu_abort(cs, "MPC8xx MMU model is not implemented\n");
     default:
-        cpu_abort(CPU(cpu), "Unknown or invalid MMU model\n");
+        cpu_abort(cs, "Unknown or invalid MMU model\n");
     }
 }
 
 hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = cpu_env(cs);
     hwaddr raddr;
     int s, p;
 
@@ -857,10 +855,10 @@ hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
      * try an MMU_DATA_LOAD, we may not be able to read instructions
      * mapped by code TLBs, so we also try a MMU_INST_FETCH.
      */
-    if (ppc_xlate(cpu, addr, MMU_DATA_LOAD, &raddr, &s, &p,
-                  ppc_env_mmu_index(&cpu->env, false), false) ||
-        ppc_xlate(cpu, addr, MMU_INST_FETCH, &raddr, &s, &p,
-                  ppc_env_mmu_index(&cpu->env, true), false)) {
+    if (ppc_xlate(cs, addr, MMU_DATA_LOAD, &raddr, &s, &p,
+                  ppc_env_mmu_index(env, false), false) ||
+        ppc_xlate(cs, addr, MMU_INST_FETCH, &raddr, &s, &p,
+                  ppc_env_mmu_index(env, true), false)) {
         return raddr & TARGET_PAGE_MASK;
     }
     return -1;
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index b0a0676beb..cf7ee3b92d 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -1361,12 +1361,11 @@ bool ppc_cpu_tlb_fill(CPUState *cs, vaddr eaddr, int size,
                       MMUAccessType access_type, int mmu_idx,
                       bool probe, uintptr_t retaddr)
 {
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
     hwaddr raddr;
     int page_size, prot;
 
-    if (ppc_xlate(cpu, eaddr, access_type, &raddr,
-                  &page_size, &prot, mmu_idx, !probe)) {
+    if (ppc_xlate(cs, eaddr, access_type, &raddr, &page_size, &prot,
+                  mmu_idx, !probe)) {
         tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr & TARGET_PAGE_MASK,
                      prot, mmu_idx, 1UL << page_size);
         return true;
@@ -1374,6 +1373,6 @@ bool ppc_cpu_tlb_fill(CPUState *cs, vaddr eaddr, int size,
     if (probe) {
         return false;
     }
-    raise_exception_err_ra(&cpu->env, cs->exception_index,
-                           cpu->env.error_code, retaddr);
+    raise_exception_err_ra(cpu_env(cs), cs->exception_index,
+                           cpu_env(cs)->error_code, retaddr);
 }
-- 
2.30.9


