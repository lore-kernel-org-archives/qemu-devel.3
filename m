Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162B1C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 23:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Jc3-0002Tz-IE; Wed, 01 May 2024 19:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s2Jbo-0002LX-Si; Wed, 01 May 2024 19:43:32 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s2Jbn-00052l-8A; Wed, 01 May 2024 19:43:32 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B5F674E603A;
 Thu, 02 May 2024 01:43:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id SyLe_59pytDd; Thu,  2 May 2024 01:43:26 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CA7504E6054; Thu, 02 May 2024 01:43:26 +0200 (CEST)
Message-Id: <55ea002eb081fd1fdc6ff6f0e3f25ba892044e9d.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1714606359.git.balaton@eik.bme.hu>
References: <cover.1714606359.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 20/28] target/ppc/mmu_common.c: Make
 get_physical_address_wtlb() static
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 02 May 2024 01:43:26 +0200 (CEST)
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

This function is not used from any other files so make it static and
fix the maybe used uninitialised warnings this has uncovered.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/internal.h   | 5 +----
 target/ppc/mmu_common.c | 5 ++++-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 601c0b533f..7a99f08dc8 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -261,10 +261,7 @@ typedef struct mmu_ctx_t mmu_ctx_t;
 bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
                       hwaddr *raddrp, int *psizep, int *protp,
                       int mmu_idx, bool guest_visible);
-int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
-                                     target_ulong eaddr,
-                                     MMUAccessType access_type, int type,
-                                     int mmu_idx);
+
 /* Software driven TLB helpers */
 int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
                                     int way, int is_code);
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 762b13805b..4852cb5571 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -666,6 +666,7 @@ static int mmubooke_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     hwaddr raddr = (hwaddr)-1ULL;
     int i, ret = -1;
 
+    ctx->prot = 0;
     for (i = 0; i < env->nb_tlb; i++) {
         tlb = &env->tlb.tlbe[i];
         ret = mmubooke_check_tlb(env, tlb, &raddr, &ctx->prot, address,
@@ -873,6 +874,7 @@ static int mmubooke206_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     hwaddr raddr = (hwaddr)-1ULL;
     int i, j, ways, ret = -1;
 
+    ctx->prot = 0;
     for (i = 0; i < BOOKE206_MAX_TLBN; i++) {
         ways = booke206_tlb_ways(env, i);
         for (j = 0; j < ways; j++) {
@@ -1144,7 +1146,7 @@ void dump_mmu(CPUPPCState *env)
     }
 }
 
-int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
+static int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
                                      target_ulong eaddr,
                                      MMUAccessType access_type, int type,
                                      int mmu_idx)
@@ -1163,6 +1165,7 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
     if (real_mode && (env->mmu_model == POWERPC_MMU_SOFT_6xx ||
                       env->mmu_model == POWERPC_MMU_SOFT_4xx ||
                       env->mmu_model == POWERPC_MMU_REAL)) {
+        memset(ctx, 0, sizeof(*ctx));
         ctx->raddr = eaddr;
         ctx->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
         return 0;
-- 
2.30.9


