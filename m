Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E106C25B77
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 23:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Id9-0002yW-Nn; Sun, 12 May 2024 19:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6Ick-00029U-OT; Sun, 12 May 2024 19:28:59 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6Ici-0000SM-Hg; Sun, 12 May 2024 19:28:58 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 325834E678E;
 Mon, 13 May 2024 01:28:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id GT6zxEyRV8ni; Mon, 13 May 2024 01:28:29 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3DB2E4E678F; Mon, 13 May 2024 01:28:29 +0200 (CEST)
Message-Id: <90e8b118a647eab178c98d515569566f57e92fd1.1715555763.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715555763.git.balaton@eik.bme.hu>
References: <cover.1715555763.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v7 54/61] target/ppc/mmu_common.c: Remove key field from
 mmu_ctx_t
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 13 May 2024 01:28:29 +0200 (CEST)
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

Pass it as a function argument and remove it from mmu_ctx_t.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index ccc1c76a06..331e00b71c 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -41,7 +41,6 @@
 typedef struct {
     hwaddr raddr;      /* Real address             */
     int prot;          /* Protection bits          */
-    int key;           /* Access key               */
 } mmu_ctx_t;
 
 void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
@@ -95,7 +94,7 @@ int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
 static int ppc6xx_tlb_check(CPUPPCState *env,
                             mmu_ctx_t *ctx, target_ulong eaddr,
                             MMUAccessType access_type, target_ulong ptem,
-                            bool nx)
+                            bool key, bool nx)
 {
     ppc6xx_tlb_t *tlb;
     target_ulong *pte1p;
@@ -140,7 +139,7 @@ static int ppc6xx_tlb_check(CPUPPCState *env,
         /* Keep the matching PTE information */
         best = nr;
         ctx->raddr = tlb->pte1;
-        ctx->prot = ppc_hash32_pp_prot(ctx->key, tlb->pte1 & HPTE32_R_PP, nx);
+        ctx->prot = ppc_hash32_pp_prot(key, tlb->pte1 & HPTE32_R_PP, nx);
         if (check_prot_access_type(ctx->prot, access_type)) {
             qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
             ret = 0;
@@ -295,13 +294,14 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
 }
 
 static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
-                                       target_ulong eaddr, hwaddr *hashp,
+                                       target_ulong eaddr,
+                                       hwaddr *hashp, bool *keyp,
                                        MMUAccessType access_type, int type)
 {
     PowerPCCPU *cpu = env_archcpu(env);
     hwaddr hash;
     target_ulong vsid, sr, pgidx, ptem;
-    bool pr, ds, nx;
+    bool key, pr, ds, nx;
 
     /* First try to find a BAT entry if there are any */
     if (env->nb_BATs && get_bat_6xx_tlb(env, ctx, eaddr, access_type) == 0) {
@@ -312,7 +312,8 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     pr = FIELD_EX64(env->msr, MSR, PR);
 
     sr = env->sr[eaddr >> 28];
-    ctx->key = ppc_hash32_key(pr, sr);
+    key = ppc_hash32_key(pr, sr);
+    *keyp = key;
     ds = sr & SR32_T;
     nx = sr & SR32_NX;
     vsid = sr & SR32_VSID;
@@ -329,7 +330,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     ptem = (vsid << 7) | (pgidx >> 10); /* Virtual segment ID | API */
 
     qemu_log_mask(CPU_LOG_MMU, "pte segment: key=%d ds %d nx %d vsid "
-                  TARGET_FMT_lx "\n", ctx->key, ds, nx, vsid);
+                  TARGET_FMT_lx "\n", key, ds, nx, vsid);
     if (!ds) {
         /* Check if instruction fetch is allowed, if needed */
         if (type == ACCESS_CODE && nx) {
@@ -343,7 +344,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
         *hashp = hash;
 
         /* Software TLB search */
-        return ppc6xx_tlb_check(env, ctx, eaddr, access_type, ptem, nx);
+        return ppc6xx_tlb_check(env, ctx, eaddr, access_type, ptem, key, nx);
     }
 
     /* Direct-store segment : absolutely *BUGGY* for now */
@@ -367,8 +368,8 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     case ACCESS_EXT: /* eciwx or ecowx */
         return -4;
     }
-    if ((access_type == MMU_DATA_STORE || ctx->key != 1) &&
-        (access_type == MMU_DATA_LOAD || ctx->key != 0)) {
+    if ((access_type == MMU_DATA_STORE || !key) &&
+        (access_type == MMU_DATA_LOAD || key)) {
         ctx->raddr = eaddr;
         return 2;
     }
@@ -709,6 +710,7 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eaddr,
     CPUPPCState *env = &cpu->env;
     mmu_ctx_t ctx;
     hwaddr hash = 0; /* init to 0 to avoid used uninit warning */
+    bool key;
     int type, ret;
 
     if (ppc_real_mode_xlate(cpu, eaddr, access_type, raddrp, psizep, protp)) {
@@ -726,7 +728,7 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eaddr,
     }
 
     ctx.prot = 0;
-    ret = mmu6xx_get_physical_address(env, &ctx, eaddr, &hash,
+    ret = mmu6xx_get_physical_address(env, &ctx, eaddr, &hash, &key,
                                       access_type, type);
     if (ret == 0) {
         *raddrp = ctx.raddr;
@@ -778,7 +780,7 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eaddr,
             env->spr[SPR_DMISS] = eaddr;
             env->spr[SPR_DCMP] |= 0x80000000;
 tlb_miss:
-            env->error_code |= ctx.key << 19;
+            env->error_code |= key << 19;
             env->spr[SPR_HASH1] = ppc_hash32_hpt_base(cpu) +
                                   get_pteg_offset32(cpu, hash);
             env->spr[SPR_HASH2] = ppc_hash32_hpt_base(cpu) +
-- 
2.30.9


