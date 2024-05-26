Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4148C41513
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 23:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBN4l-0004OR-3z; Sun, 26 May 2024 19:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN4i-0004LA-V3; Sun, 26 May 2024 19:14:49 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN4h-0003hy-Au; Sun, 26 May 2024 19:14:48 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 86F864E60F5;
 Mon, 27 May 2024 01:13:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 8boPFWQ_pytE; Mon, 27 May 2024 01:13:03 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9BC554E64E4; Mon, 27 May 2024 01:13:03 +0200 (CEST)
Message-Id: <de272971970fc6772ac84b691d01e4b03b2e47cf.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1716763435.git.balaton@eik.bme.hu>
References: <cover.1716763435.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 27/43] target/ppc/mmu_common.c: Remove mmu_ctx_t
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 27 May 2024 01:13:03 +0200 (CEST)
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

Completely get rid of mmu_ctx_t after converting the remaining
functions to pass raddr and prot without the context struct.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 4770b43630..60f8736210 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -37,12 +37,6 @@
 
 /* #define DUMP_PAGE_TABLES */
 
-/* Context used internally during MMU translations */
-typedef struct {
-    hwaddr raddr;      /* Real address             */
-    int prot;          /* Protection bits          */
-} mmu_ctx_t;
-
 void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
 {
     PowerPCCPU *cpu = env_archcpu(env);
@@ -264,8 +258,8 @@ static int get_bat_6xx_tlb(CPUPPCState *env, hwaddr *raddr, int *prot,
     return ret;
 }
 
-static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
-                                       target_ulong eaddr,
+static int mmu6xx_get_physical_address(CPUPPCState *env, hwaddr *raddr,
+                                       int *prot, target_ulong eaddr,
                                        hwaddr *hashp, bool *keyp,
                                        MMUAccessType access_type, int type)
 {
@@ -277,8 +271,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
 
     /* First try to find a BAT entry if there are any */
     if (env->nb_BATs &&
-        get_bat_6xx_tlb(env, &ctx->raddr, &ctx->prot, eaddr,
-                        access_type, pr) == 0) {
+        get_bat_6xx_tlb(env, raddr, prot, eaddr, access_type, pr) == 0) {
         return 0;
     }
 
@@ -316,7 +309,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
         *hashp = hash;
 
         /* Software TLB search */
-        return ppc6xx_tlb_check(env, &ctx->raddr, &ctx->prot, eaddr,
+        return ppc6xx_tlb_check(env, raddr, prot, eaddr,
                                 access_type, ptem, key, nx);
     }
 
@@ -333,7 +326,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
          * Should make the instruction do no-op.  As it already do
          * no-op, it's quite easy :-)
          */
-        ctx->raddr = eaddr;
+        *raddr = eaddr;
         return 0;
     case ACCESS_CODE: /* No code fetch is allowed in direct-store areas */
     case ACCESS_FLOAT: /* Floating point load/store */
@@ -343,7 +336,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     }
     if ((access_type == MMU_DATA_STORE || !key) &&
         (access_type == MMU_DATA_LOAD || key)) {
-        ctx->raddr = eaddr;
+        *raddr = eaddr;
         return 2;
     }
     return -2;
@@ -681,7 +674,6 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eaddr,
 {
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
-    mmu_ctx_t ctx;
     hwaddr hash = 0; /* init to 0 to avoid used uninit warning */
     bool key;
     int type, ret;
@@ -700,12 +692,9 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eaddr,
         type = ACCESS_INT;
     }
 
-    ctx.prot = 0;
-    ret = mmu6xx_get_physical_address(env, &ctx, eaddr, &hash, &key,
+    ret = mmu6xx_get_physical_address(env, raddrp, protp, eaddr, &hash, &key,
                                       access_type, type);
     if (ret == 0) {
-        *raddrp = ctx.raddr;
-        *protp = ctx.prot;
         *psizep = TARGET_PAGE_BITS;
         return true;
     } else if (!guest_visible) {
-- 
2.30.9


