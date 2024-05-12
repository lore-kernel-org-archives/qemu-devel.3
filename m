Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A90DC25B4F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 23:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6IdA-00032W-Mk; Sun, 12 May 2024 19:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6Ico-0002Dm-Iz; Sun, 12 May 2024 19:29:02 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6Icl-0000T4-Rh; Sun, 12 May 2024 19:29:01 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 44CEB4E678F;
 Mon, 13 May 2024 01:28:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Atl7UipGm4ZS; Mon, 13 May 2024 01:28:30 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 51A744E6790; Mon, 13 May 2024 01:28:30 +0200 (CEST)
Message-Id: <1c1d77b5dfeaef8166900da6a410a0ef209911f3.1715555763.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715555763.git.balaton@eik.bme.hu>
References: <cover.1715555763.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v7 55/61] target/ppc/mmu_common.c: Stop using ctx in
 ppc6xx_tlb_check()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 13 May 2024 01:28:30 +0200 (CEST)
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

Pass raddr and prot in function parameters instead.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 331e00b71c..1137ec197b 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -91,10 +91,9 @@ int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
 
 /* Software driven TLB helpers */
 
-static int ppc6xx_tlb_check(CPUPPCState *env,
-                            mmu_ctx_t *ctx, target_ulong eaddr,
-                            MMUAccessType access_type, target_ulong ptem,
-                            bool key, bool nx)
+static int ppc6xx_tlb_check(CPUPPCState *env, hwaddr *raddr, int *prot,
+                            target_ulong eaddr, MMUAccessType access_type,
+                            target_ulong ptem, bool key, bool nx)
 {
     ppc6xx_tlb_t *tlb;
     target_ulong *pte1p;
@@ -102,7 +101,7 @@ static int ppc6xx_tlb_check(CPUPPCState *env,
     bool is_code = (access_type == MMU_INST_FETCH);
 
     /* Initialize real address with an invalid value */
-    ctx->raddr = (hwaddr)-1ULL;
+    *raddr = (hwaddr)-1ULL;
     best = -1;
     ret = -1; /* No TLB found */
     for (way = 0; way < env->nb_ways; way++) {
@@ -130,17 +129,17 @@ static int ppc6xx_tlb_check(CPUPPCState *env,
             continue;
         }
         /* all matches should have equal RPN, WIMG & PP */
-        if (ctx->raddr != (hwaddr)-1ULL &&
-            (ctx->raddr & PTE_CHECK_MASK) != (tlb->pte1 & PTE_CHECK_MASK)) {
+        if (*raddr != (hwaddr)-1ULL &&
+            (*raddr & PTE_CHECK_MASK) != (tlb->pte1 & PTE_CHECK_MASK)) {
             qemu_log_mask(CPU_LOG_MMU, "Bad RPN/WIMG/PP\n");
             /* TLB inconsistency */
             continue;
         }
         /* Keep the matching PTE information */
         best = nr;
-        ctx->raddr = tlb->pte1;
-        ctx->prot = ppc_hash32_pp_prot(key, tlb->pte1 & HPTE32_R_PP, nx);
-        if (check_prot_access_type(ctx->prot, access_type)) {
+        *raddr = tlb->pte1;
+        *prot = ppc_hash32_pp_prot(key, tlb->pte1 & HPTE32_R_PP, nx);
+        if (check_prot_access_type(*prot, access_type)) {
             qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
             ret = 0;
             break;
@@ -152,7 +151,7 @@ static int ppc6xx_tlb_check(CPUPPCState *env,
     if (best != -1) {
         qemu_log_mask(CPU_LOG_MMU, "found TLB at addr " HWADDR_FMT_plx
                       " prot=%01x ret=%d\n",
-                      ctx->raddr & TARGET_PAGE_MASK, ctx->prot, ret);
+                      *raddr & TARGET_PAGE_MASK, *prot, ret);
         /* Update page flags */
         pte1p = &env->tlb.tlb6[best].pte1;
         *pte1p |= 0x00000100; /* Update accessed flag */
@@ -162,7 +161,7 @@ static int ppc6xx_tlb_check(CPUPPCState *env,
                 *pte1p |= 0x00000080;
             } else {
                 /* Force page fault for first write access */
-                ctx->prot &= ~PAGE_WRITE;
+                *prot &= ~PAGE_WRITE;
             }
         }
     }
@@ -344,7 +343,8 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
         *hashp = hash;
 
         /* Software TLB search */
-        return ppc6xx_tlb_check(env, ctx, eaddr, access_type, ptem, key, nx);
+        return ppc6xx_tlb_check(env, &ctx->raddr, &ctx->prot, eaddr,
+                                access_type, ptem, key, nx);
     }
 
     /* Direct-store segment : absolutely *BUGGY* for now */
-- 
2.30.9


