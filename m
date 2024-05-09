Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5411AC10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 20:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5ALB-0000Kg-Fq; Thu, 09 May 2024 16:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5AL5-0000GG-J1; Thu, 09 May 2024 16:26:03 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5AL2-00016o-81; Thu, 09 May 2024 16:26:03 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BBA284E65D4;
 Thu, 09 May 2024 22:25:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id yWjLQCYo73wX; Thu,  9 May 2024 22:25:56 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C867C4E65D6; Thu, 09 May 2024 22:25:56 +0200 (CEST)
Message-Id: <cae0920abcbb61058bf92e75ebb349b45f8a9421.1715285340.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715285340.git.balaton@eik.bme.hu>
References: <cover.1715285340.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 22/32] target/ppc/mmu_common.c: Eliminate
 get_physical_address_wtlb()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 09 May 2024 22:25:56 +0200 (CEST)
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

Inline get_physical_address_wtlb() in its only caller and remove it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/internal.h   |  5 +---
 target/ppc/mmu_common.c | 66 +++++++++++++++++------------------------
 2 files changed, 28 insertions(+), 43 deletions(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index ffdf6c075d..5b28e8f3b0 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -297,10 +297,7 @@ typedef struct mmu_ctx_t mmu_ctx_t;
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
index d0d49c696b..d7e4baa9cf 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -1072,35 +1072,6 @@ void dump_mmu(CPUPPCState *env)
     }
 }
 
-int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
-                                     target_ulong eaddr,
-                                     MMUAccessType access_type, int type,
-                                     int mmu_idx)
-{
-    bool real_mode = (type == ACCESS_CODE) ? !FIELD_EX64(env->msr, MSR, IR)
-                                           : !FIELD_EX64(env->msr, MSR, DR);
-    if (real_mode) {
-        ctx->raddr = eaddr;
-        ctx->prot = PAGE_RWX;
-        return 0;
-    }
-
-    switch (env->mmu_model) {
-    case POWERPC_MMU_SOFT_6xx:
-        return mmu6xx_get_physical_address(env, ctx, eaddr, access_type, type);
-    case POWERPC_MMU_SOFT_4xx:
-        /* avoid maybe used uninitialized warnings for unused fields in ctx */
-        memset(ctx, 0, sizeof(*ctx));
-        return mmu40x_get_physical_address(env, &ctx->raddr, &ctx->prot, eaddr,
-                                           access_type);
-    case POWERPC_MMU_REAL:
-        cpu_abort(env_cpu(env),
-                  "PowerPC in real mode do not do any translation\n");
-    default:
-        cpu_abort(env_cpu(env), "Unknown or invalid MMU model\n");
-    }
-}
-
 static void booke206_update_mas_tlb_miss(CPUPPCState *env, target_ulong address,
                                          MMUAccessType access_type, int mmu_idx)
 {
@@ -1255,6 +1226,15 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
     int type;
     int ret;
 
+    /* If in real_mode then no translation */
+    if (access_type == MMU_INST_FETCH ? !FIELD_EX64(env->msr, MSR, IR)
+                                      : !FIELD_EX64(env->msr, MSR, DR)) {
+        *raddrp = eaddr;
+        *protp = PAGE_RWX;
+        *psizep = TARGET_PAGE_BITS;
+        return true;
+    }
+
     if (access_type == MMU_INST_FETCH) {
         /* code access */
         type = ACCESS_CODE;
@@ -1265,8 +1245,22 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
         type = ACCESS_INT;
     }
 
-    ret = get_physical_address_wtlb(env, &ctx, eaddr, access_type,
-                                    type, mmu_idx);
+    switch (env->mmu_model) {
+    case POWERPC_MMU_SOFT_6xx:
+        ret = mmu6xx_get_physical_address(env, &ctx, eaddr, access_type, type);
+        break;
+    case POWERPC_MMU_SOFT_4xx:
+        /* avoid maybe used uninitialized warnings for unused fields in ctx */
+        memset(&ctx, 0, sizeof(ctx));
+        ret = mmu40x_get_physical_address(env, &ctx.raddr, &ctx.prot, eaddr,
+                                          access_type);
+        break;
+    case POWERPC_MMU_REAL:
+        cpu_abort(cs, "PowerPC in real mode do not do any translation\n");
+    default:
+        cpu_abort(cs, "Unknown or invalid MMU model\n");
+    }
+
     if (ret == 0) {
         *raddrp = ctx.raddr;
         *protp = ctx.prot;
@@ -1294,11 +1288,8 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
                 env->spr[SPR_40x_DEAR] = eaddr;
                 env->spr[SPR_40x_ESR] = 0x00000000;
                 break;
-            case POWERPC_MMU_REAL:
-                cpu_abort(cs, "PowerPC in real mode should never raise "
-                              "any MMU exceptions\n");
             default:
-                cpu_abort(cs, "Unknown or invalid MMU model\n");
+                g_assert_not_reached();
             }
             break;
         case -2:
@@ -1350,11 +1341,8 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
                     env->spr[SPR_40x_ESR] = 0x00000000;
                 }
                 break;
-            case POWERPC_MMU_REAL:
-                cpu_abort(cs, "PowerPC in real mode should never raise "
-                              "any MMU exceptions\n");
             default:
-                cpu_abort(cs, "Unknown or invalid MMU model\n");
+                g_assert_not_reached();
             }
             break;
         case -2:
-- 
2.30.9


