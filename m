Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02BFC25B4F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 23:37:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Id6-0002kp-BN; Sun, 12 May 2024 19:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6Icd-00020v-Rg; Sun, 12 May 2024 19:28:53 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6Icb-0000R0-0Y; Sun, 12 May 2024 19:28:51 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F18E24E678A;
 Mon, 13 May 2024 01:28:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id dcCSVDzx_v2j; Mon, 13 May 2024 01:28:25 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0A4F14E678B; Mon, 13 May 2024 01:28:25 +0200 (CEST)
Message-Id: <3201d0f7ef4db12de4055a44ef0c863f3f333fe6.1715555763.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715555763.git.balaton@eik.bme.hu>
References: <cover.1715555763.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v7 50/61] target/ppc/mmu_common.c: Remove ptem field from
 mmu_ctx_t
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 13 May 2024 01:28:25 +0200 (CEST)
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

Instead of passing around ptem in context use it once in the same
function so it can be removed from mmu_ctx_t.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index a4bb8c8c3e..f09f7417c2 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -41,7 +41,6 @@
 typedef struct {
     hwaddr raddr;      /* Real address             */
     int prot;          /* Protection bits          */
-    target_ulong ptem; /* Virtual segment ID | API */
     int key;           /* Access key               */
 } mmu_ctx_t;
 
@@ -95,16 +94,18 @@ int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
 
 static int ppc6xx_tlb_check(CPUPPCState *env,
                             mmu_ctx_t *ctx, target_ulong eaddr,
-                            MMUAccessType access_type, bool nx)
+                            MMUAccessType access_type, target_ulong ptem,
+                            bool nx)
 {
     ppc6xx_tlb_t *tlb;
     target_ulong *pte1p;
     int nr, best, way, ret;
+    bool is_code = (access_type == MMU_INST_FETCH);
 
     best = -1;
     ret = -1; /* No TLB found */
     for (way = 0; way < env->nb_ways; way++) {
-        nr = ppc6xx_tlb_getnum(env, eaddr, way, access_type == MMU_INST_FETCH);
+        nr = ppc6xx_tlb_getnum(env, eaddr, way, is_code);
         tlb = &env->tlb.tlb6[nr];
         /* This test "emulates" the PTE index match for hardware TLBs */
         if ((eaddr & TARGET_PAGE_MASK) != tlb->EPN) {
@@ -124,7 +125,7 @@ static int ppc6xx_tlb_check(CPUPPCState *env,
                       access_type == MMU_INST_FETCH ? 'I' : 'D');
         /* Check validity and table match */
         if (!pte_is_valid(tlb->pte0) || ((tlb->pte0 >> 6) & 1) != 0 ||
-            (tlb->pte0 & PTE_PTEM_MASK) != ctx->ptem) {
+            (tlb->pte0 & PTE_PTEM_MASK) != ptem) {
             continue;
         }
         /* all matches should have equal RPN, WIMG & PP */
@@ -164,6 +165,10 @@ static int ppc6xx_tlb_check(CPUPPCState *env,
             }
         }
     }
+    if (ret == -1) {
+        int r = is_code ? SPR_ICMP : SPR_DCMP;
+        env->spr[r] = ptem;
+    }
 #if defined(DUMP_PAGE_TABLES)
     if (qemu_loglevel_mask(CPU_LOG_MMU)) {
         CPUState *cs = env_cpu(env);
@@ -293,7 +298,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
 {
     PowerPCCPU *cpu = env_archcpu(env);
     hwaddr hash;
-    target_ulong vsid, sr, pgidx;
+    target_ulong vsid, sr, pgidx, ptem;
     bool pr, ds, nx;
 
     /* First try to find a BAT entry if there are any */
@@ -320,7 +325,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
                   access_type == MMU_DATA_STORE, type);
     pgidx = (eaddr & ~SEGMENT_MASK_256M) >> TARGET_PAGE_BITS;
     hash = vsid ^ pgidx;
-    ctx->ptem = (vsid << 7) | (pgidx >> 10);
+    ptem = (vsid << 7) | (pgidx >> 10); /* Virtual segment ID | API */
 
     qemu_log_mask(CPU_LOG_MMU, "pte segment: key=%d ds %d nx %d vsid "
                   TARGET_FMT_lx "\n", ctx->key, ds, nx, vsid);
@@ -339,7 +344,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
         /* Initialize real address with an invalid value */
         ctx->raddr = (hwaddr)-1ULL;
         /* Software TLB search */
-        return ppc6xx_tlb_check(env, ctx, eaddr, access_type, nx);
+        return ppc6xx_tlb_check(env, ctx, eaddr, access_type, ptem, nx);
     }
 
     /* Direct-store segment : absolutely *BUGGY* for now */
@@ -741,7 +746,7 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eaddr,
             cs->exception_index = POWERPC_EXCP_IFTLB;
             env->error_code = 1 << 18;
             env->spr[SPR_IMISS] = eaddr;
-            env->spr[SPR_ICMP] = 0x80000000 | ctx.ptem;
+            env->spr[SPR_ICMP] |= 0x80000000;
             goto tlb_miss;
         case -2:
             /* Access rights violation */
@@ -772,7 +777,7 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eaddr,
                 env->error_code = 0;
             }
             env->spr[SPR_DMISS] = eaddr;
-            env->spr[SPR_DCMP] = 0x80000000 | ctx.ptem;
+            env->spr[SPR_DCMP] |= 0x80000000;
 tlb_miss:
             env->error_code |= ctx.key << 19;
             env->spr[SPR_HASH1] = ppc_hash32_hpt_base(cpu) +
-- 
2.30.9


