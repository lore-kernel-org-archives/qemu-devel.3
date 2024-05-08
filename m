Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135A2C10F1A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 00:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4V0f-0005pq-6M; Tue, 07 May 2024 20:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4UyP-0007nL-01; Tue, 07 May 2024 20:15:53 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4UyM-0003o9-JB; Tue, 07 May 2024 20:15:52 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1845B4E65BB;
 Wed, 08 May 2024 02:15:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id EyxdzFCqp8IT; Wed,  8 May 2024 02:15:27 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 258654E65D5; Wed, 08 May 2024 02:15:27 +0200 (CEST)
Message-Id: <a91a1b9455f88cbbeff2652fc4f44acd89e98215.1715125376.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715125376.git.balaton@eik.bme.hu>
References: <cover.1715125376.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 33/33] target/ppc: Add a macro to check for page protection
 bit
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Wed, 08 May 2024 02:15:27 +0200 (CEST)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

Checking if a page protection bit is set for a given access type is a
common operation. Add a macro to avoid repeating the same check at
multiple places and also avoid a function call. As this relies on
access type and page protection bit values having certain relation
also add an assert to ensure that this assumption holds.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/cpu_init.c    |  4 ++++
 target/ppc/internal.h    | 20 ++------------------
 target/ppc/mmu-hash32.c  |  6 +++---
 target/ppc/mmu-hash64.c  |  2 +-
 target/ppc/mmu-radix64.c |  2 +-
 target/ppc/mmu_common.c  | 26 +++++++++++++-------------
 6 files changed, 24 insertions(+), 36 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 92c71b2a09..6639235544 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7377,6 +7377,10 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
     resettable_class_set_parent_phases(rc, NULL, ppc_cpu_reset_hold, NULL,
                                        &pcc->parent_phases);
 
+    /* CHECK_PROT_ACCESS relies on this MMU access and PAGE bits relation */
+    assert(MMU_DATA_LOAD == 0 && MMU_DATA_STORE == 1 && MMU_INST_FETCH == 2 &&
+           PAGE_READ == 1 && PAGE_WRITE == 2 && PAGE_EXEC == 4);
+
     cc->class_by_name = ppc_cpu_class_by_name;
     cc->has_work = ppc_cpu_has_work;
     cc->mmu_index = ppc_cpu_mmu_index;
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 46176c4711..9880422ce3 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -234,24 +234,8 @@ void destroy_ppc_opcodes(PowerPCCPU *cpu);
 void ppc_gdb_init(CPUState *cs, PowerPCCPUClass *ppc);
 const gchar *ppc_gdb_arch_name(CPUState *cs);
 
-/**
- * prot_for_access_type:
- * @access_type: Access type
- *
- * Return the protection bit required for the given access type.
- */
-static inline int prot_for_access_type(MMUAccessType access_type)
-{
-    switch (access_type) {
-    case MMU_INST_FETCH:
-        return PAGE_EXEC;
-    case MMU_DATA_LOAD:
-        return PAGE_READ;
-    case MMU_DATA_STORE:
-        return PAGE_WRITE;
-    }
-    g_assert_not_reached();
-}
+/* Check if permission bit required for the access_type is set in prot */
+#define CHECK_PROT_ACCESS(prot, access_type) ((prot) & (1 << (access_type)))
 
 #ifndef CONFIG_USER_ONLY
 
diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index b5d7aeed4e..fa4a4ced6d 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -213,7 +213,7 @@ static bool ppc_hash32_direct_store(PowerPCCPU *cpu, target_ulong sr,
     }
 
     *prot = key ? PAGE_READ | PAGE_WRITE : PAGE_READ;
-    if (*prot & prot_for_access_type(access_type)) {
+    if (CHECK_PROT_ACCESS(*prot, access_type)) {
         *raddr = eaddr;
         return true;
     }
@@ -364,7 +364,7 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     if (env->nb_BATs != 0) {
         raddr = ppc_hash32_bat_lookup(cpu, eaddr, access_type, protp, mmu_idx);
         if (raddr != -1) {
-            if (prot_for_access_type(access_type) & ~*protp) {
+            if (!CHECK_PROT_ACCESS(*protp, access_type)) {
                 if (guest_visible) {
                     if (access_type == MMU_INST_FETCH) {
                         cs->exception_index = POWERPC_EXCP_ISI;
@@ -432,7 +432,7 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
 
     prot = ppc_hash32_pte_prot(mmu_idx, sr, pte);
 
-    if (prot_for_access_type(access_type) & ~prot) {
+    if (!CHECK_PROT_ACCESS(prot, access_type)) {
         /* Access right violation */
         qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
         if (guest_visible) {
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 5a0d80feda..14c2116ae7 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -1097,7 +1097,7 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     amr_prot = ppc_hash64_amr_prot(cpu, pte);
     prot = exec_prot & pp_prot & amr_prot;
 
-    need_prot = prot_for_access_type(access_type);
+    need_prot = CHECK_PROT_ACCESS(PAGE_RWX, access_type);
     if (need_prot & ~prot) {
         /* Access right violation */
         qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 395ce3b782..a72cd927c4 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -209,7 +209,7 @@ static bool ppc_radix64_check_prot(PowerPCCPU *cpu, MMUAccessType access_type,
     }
 
     /* Check if requested access type is allowed */
-    if (prot_for_access_type(access_type) & ~*prot) {
+    if (!CHECK_PROT_ACCESS(*prot, access_type)) {
         /* Page Protected for that Access */
         *fault_cause |= access_type == MMU_INST_FETCH ? SRR1_NOEXEC_GUARD :
                                                         DSISR_PROTFAULT;
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index eff015066d..24d68926b4 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -76,11 +76,6 @@ void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
 /*****************************************************************************/
 /* PowerPC MMU emulation */
 
-static int check_prot(int prot, MMUAccessType access_type)
-{
-    return prot & prot_for_access_type(access_type) ? 0 : -2;
-}
-
 int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
                                     int way, int is_code)
 {
@@ -125,13 +120,14 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
             /* Keep the matching PTE information */
             ctx->raddr = pte1;
             ctx->prot = ppc_hash32_pp_prot(ctx->key, pp, ctx->nx);
-            ret = check_prot(ctx->prot, access_type);
-            if (ret == 0) {
+            if (CHECK_PROT_ACCESS(ctx->prot, access_type)) {
                 /* Access granted */
                 qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
+                ret = 0;
             } else {
                 /* Access right violation */
                 qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
+                ret = -2;
             }
         }
     }
@@ -317,12 +313,14 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
                     (virtual & 0x0001F000);
                 /* Compute access rights */
                 ctx->prot = prot;
-                ret = check_prot(ctx->prot, access_type);
-                if (ret == 0) {
+                if (CHECK_PROT_ACCESS(ctx->prot, access_type)) {
                     qemu_log_mask(CPU_LOG_MMU, "BAT %d match: r " HWADDR_FMT_plx
                                   " prot=%c%c\n", i, ctx->raddr,
                                   ctx->prot & PAGE_READ ? 'R' : '-',
                                   ctx->prot & PAGE_WRITE ? 'W' : '-');
+                    ret = 0;
+                } else {
+                    ret = -2;
                 }
                 break;
             }
@@ -540,9 +538,11 @@ static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
         check_perms:
             /* Check from TLB entry */
             ctx->prot = tlb->prot;
-            ret = check_prot(ctx->prot, access_type);
-            if (ret == -2) {
+            if (CHECK_PROT_ACCESS(ctx->prot, access_type)) {
+                ret = 0;
+            } else {
                 env->spr[SPR_40x_ESR] = 0;
+                ret = -2;
             }
             break;
         }
@@ -607,7 +607,7 @@ static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
     } else {
         *prot = (tlb->prot >> 4) & 0xF;
     }
-    if (*prot & prot_for_access_type(access_type)) {
+    if (CHECK_PROT_ACCESS(*prot, access_type)) {
         qemu_log_mask(CPU_LOG_MMU, "%s: good TLB!\n", __func__);
         return 0;
     }
@@ -811,7 +811,7 @@ found_tlb:
             *prot |= PAGE_EXEC;
         }
     }
-    if (*prot & prot_for_access_type(access_type)) {
+    if (CHECK_PROT_ACCESS(*prot, access_type)) {
         qemu_log_mask(CPU_LOG_MMU, "%s: good TLB!\n", __func__);
         return 0;
     }
-- 
2.30.9


