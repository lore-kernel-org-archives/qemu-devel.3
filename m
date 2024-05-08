Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F126C19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 00:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4V0W-0005Gm-Mp; Tue, 07 May 2024 20:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4UyW-0007u4-Sc; Tue, 07 May 2024 20:16:01 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4UyL-0003nO-L7; Tue, 07 May 2024 20:16:00 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E46174E65CB;
 Wed, 08 May 2024 02:15:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id P5kzcoG7fTkH; Wed,  8 May 2024 02:15:22 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id EC9FE4E65CE; Wed, 08 May 2024 02:15:22 +0200 (CEST)
Message-Id: <086e96a04a2b70da0ec39d734634ade9dfc2ff45.1715125376.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715125376.git.balaton@eik.bme.hu>
References: <cover.1715125376.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 29/33] target/ppc: Remove id_tlbs flag from CPU env
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Wed, 08 May 2024 02:15:22 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This flag for split instruction/data TLBs is only set for 6xx soft TLB
MMU model and not used otherwise so no need to have a separate flag
for that.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pegasos2.c        |  2 +-
 target/ppc/cpu.h         |  1 -
 target/ppc/cpu_init.c    | 19 +++++--------------
 target/ppc/helper_regs.c |  1 -
 target/ppc/mmu_common.c  | 10 ++--------
 target/ppc/mmu_helper.c  | 12 ++----------
 6 files changed, 10 insertions(+), 35 deletions(-)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 04d6decb2b..dfc6fab180 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -984,7 +984,7 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
                           cpu->env.icache_line_size);
     qemu_fdt_setprop_cell(fdt, cp, "i-cache-line-size",
                           cpu->env.icache_line_size);
-    if (cpu->env.id_tlbs) {
+    if (cpu->env.tlb_type == TLB_6XX) {
         qemu_fdt_setprop_cell(fdt, cp, "i-tlb-sets", cpu->env.nb_ways);
         qemu_fdt_setprop_cell(fdt, cp, "i-tlb-size", cpu->env.tlb_per_way);
         qemu_fdt_setprop_cell(fdt, cp, "d-tlb-sets", cpu->env.nb_ways);
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0ac55d6b25..21e12a4f0d 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1260,7 +1260,6 @@ struct CPUArchState {
     int tlb_per_way; /* Speed-up helper: used to avoid divisions at run time */
     int nb_ways;     /* Number of ways in the TLB set */
     int last_way;    /* Last used way used to allocate TLB in a LRU way */
-    int id_tlbs;     /* If 1, MMU has separated TLBs for instructions & data */
     int nb_pids;     /* Number of available PID registers */
     int tlb_type;    /* Type of TLB we're dealing with */
     ppc_tlb_t tlb;   /* TLB is optional. Allocate them only if needed */
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index c11a69fd90..07ad788e54 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2117,7 +2117,6 @@ static void init_proc_405(CPUPPCState *env)
 #if !defined(CONFIG_USER_ONLY)
     env->nb_tlb = 64;
     env->nb_ways = 1;
-    env->id_tlbs = 0;
     env->tlb_type = TLB_EMB;
 #endif
     init_excp_4xx(env);
@@ -2190,7 +2189,6 @@ static void init_proc_440EP(CPUPPCState *env)
 #if !defined(CONFIG_USER_ONLY)
     env->nb_tlb = 64;
     env->nb_ways = 1;
-    env->id_tlbs = 0;
     env->tlb_type = TLB_EMB;
 #endif
     init_excp_BookE(env);
@@ -2288,7 +2286,6 @@ static void init_proc_440GP(CPUPPCState *env)
 #if !defined(CONFIG_USER_ONLY)
     env->nb_tlb = 64;
     env->nb_ways = 1;
-    env->id_tlbs = 0;
     env->tlb_type = TLB_EMB;
 #endif
     init_excp_BookE(env);
@@ -2362,7 +2359,6 @@ static void init_proc_440x5(CPUPPCState *env)
 #if !defined(CONFIG_USER_ONLY)
     env->nb_tlb = 64;
     env->nb_ways = 1;
-    env->id_tlbs = 0;
     env->tlb_type = TLB_EMB;
 #endif
     init_excp_BookE(env);
@@ -2724,7 +2720,6 @@ static void init_proc_e200(CPUPPCState *env)
 #if !defined(CONFIG_USER_ONLY)
     env->nb_tlb = 64;
     env->nb_ways = 1;
-    env->id_tlbs = 0;
     env->tlb_type = TLB_EMB;
 #endif
     init_excp_e200(env, 0xFFFF0000UL);
@@ -2843,7 +2838,6 @@ static void init_proc_e500(CPUPPCState *env, int version)
     /* Memory management */
     env->nb_pids = 3;
     env->nb_ways = 2;
-    env->id_tlbs = 0;
     switch (version) {
     case fsl_e500v1:
         tlbncfg[0] = register_tlbncfg(2, 1, 1, 0, 256);
@@ -6800,20 +6794,17 @@ static void init_ppc_proc(PowerPCCPU *cpu)
     }
     /* Allocate TLBs buffer when needed */
 #if !defined(CONFIG_USER_ONLY)
-    if (env->nb_tlb != 0) {
-        int nb_tlb = env->nb_tlb;
-        if (env->id_tlbs != 0) {
-            nb_tlb *= 2;
-        }
+    if (env->nb_tlb) {
         switch (env->tlb_type) {
         case TLB_6XX:
-            env->tlb.tlb6 = g_new0(ppc6xx_tlb_t, nb_tlb);
+            /* 6xx has separate TLBs for instructions and data hence times 2 */
+            env->tlb.tlb6 = g_new0(ppc6xx_tlb_t, 2 * env->nb_tlb);
             break;
         case TLB_EMB:
-            env->tlb.tlbe = g_new0(ppcemb_tlb_t, nb_tlb);
+            env->tlb.tlbe = g_new0(ppcemb_tlb_t, env->nb_tlb);
             break;
         case TLB_MAS:
-            env->tlb.tlbm = g_new0(ppcmas_tlb_t, nb_tlb);
+            env->tlb.tlbm = g_new0(ppcmas_tlb_t, env->nb_tlb);
             break;
         }
         /* Pre-compute some useful values */
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 25258986e3..ed583fe9b3 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -693,7 +693,6 @@ void register_6xx_7xx_soft_tlb(CPUPPCState *env, int nb_tlbs, int nb_ways)
 #if !defined(CONFIG_USER_ONLY)
     env->nb_tlb = nb_tlbs;
     env->nb_ways = nb_ways;
-    env->id_tlbs = 1;
     env->tlb_type = TLB_6XX;
     spr_register(env, SPR_DMISS, "DMISS",
                  SPR_NOACCESS, SPR_NOACCESS,
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index a6e7b64049..eff015066d 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -90,8 +90,8 @@ int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
     nr = (eaddr >> TARGET_PAGE_BITS) & (env->tlb_per_way - 1);
     /* Select TLB way */
     nr += env->tlb_per_way * way;
-    /* 6xx have separate TLBs for instructions and data */
-    if (is_code && env->id_tlbs == 1) {
+    /* 6xx has separate TLBs for instructions and data */
+    if (is_code) {
         nr += env->nb_tlb;
     }
 
@@ -1153,13 +1153,7 @@ static void mmu6xx_dump_mmu(CPUPPCState *env)
     mmu6xx_dump_BATs(env, ACCESS_INT);
     mmu6xx_dump_BATs(env, ACCESS_CODE);
 
-    if (env->id_tlbs != 1) {
-        qemu_printf("ERROR: 6xx MMU should have separated TLB"
-                    " for code and data\n");
-    }
-
     qemu_printf("\nTLBs                       [EPN    EPN + SIZE]\n");
-
     for (type = 0; type < 2; type++) {
         for (way = 0; way < env->nb_ways; way++) {
             for (entry = env->nb_tlb * type + env->tlb_per_way * way;
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 421e777ee6..680ca0b618 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -45,14 +45,8 @@
 static inline void ppc6xx_tlb_invalidate_all(CPUPPCState *env)
 {
     ppc6xx_tlb_t *tlb;
-    int nr, max;
+    int nr, max = 2 * env->nb_tlb;
 
-    /* LOG_SWTLB("Invalidate all TLBs\n"); */
-    /* Invalidate all defined software TLB */
-    max = env->nb_tlb;
-    if (env->id_tlbs == 1) {
-        max *= 2;
-    }
     for (nr = 0; nr < max; nr++) {
         tlb = &env->tlb.tlb6[nr];
         pte_invalidate(&tlb->pte0);
@@ -308,9 +302,7 @@ void ppc_tlb_invalidate_one(CPUPPCState *env, target_ulong addr)
     switch (env->mmu_model) {
     case POWERPC_MMU_SOFT_6xx:
         ppc6xx_tlb_invalidate_virt(env, addr, 0);
-        if (env->id_tlbs == 1) {
-            ppc6xx_tlb_invalidate_virt(env, addr, 1);
-        }
+        ppc6xx_tlb_invalidate_virt(env, addr, 1);
         break;
     case POWERPC_MMU_32B:
         /*
-- 
2.30.9


