Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AEF4C25B10
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 20:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5AL9-0000JD-KZ; Thu, 09 May 2024 16:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5AKy-0000Cl-3k; Thu, 09 May 2024 16:25:56 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5AKw-00014m-9C; Thu, 09 May 2024 16:25:55 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6F44A4E6006;
 Thu, 09 May 2024 22:25:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id x8t7H7RODXcw; Thu,  9 May 2024 22:25:50 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7C69A4E65D4; Thu, 09 May 2024 22:25:50 +0200 (CEST)
Message-Id: <e7b040e29e2bfc8d08a3dadec4940ca70e776e5a.1715285340.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715285340.git.balaton@eik.bme.hu>
References: <cover.1715285340.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 16/32] target/ppc/mmu_common.c: Don't use mmu_ctx_t for
 mmu40x_get_physical_address()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 09 May 2024 22:25:50 +0200 (CEST)
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

mmu40x_get_physical_address() only uses the raddr and prot fields from
mmu_ctx_t. Pass these directly instead of using a ctx struct.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 6570b280ca..adce6cceb8 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -519,20 +519,18 @@ int ppcemb_tlb_search(CPUPPCState *env, target_ulong address, uint32_t pid)
     return -1;
 }
 
-static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
-                                       target_ulong address,
+static int mmu40x_get_physical_address(CPUPPCState *env, hwaddr *raddr,
+                                       int *prot, target_ulong address,
                                        MMUAccessType access_type)
 {
     ppcemb_tlb_t *tlb;
-    hwaddr raddr;
     int i, ret, zsel, zpr, pr;
 
     ret = -1;
-    raddr = (hwaddr)-1ULL;
     pr = FIELD_EX64(env->msr, MSR, PR);
     for (i = 0; i < env->nb_tlb; i++) {
         tlb = &env->tlb.tlbe[i];
-        if (!ppcemb_tlb_check(env, tlb, &raddr, address,
+        if (!ppcemb_tlb_check(env, tlb, raddr, address,
                               env->spr[SPR_40x_PID], i)) {
             continue;
         }
@@ -550,40 +548,34 @@ static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
             /* fall through */
         case 0x3:
             /* All accesses granted */
-            ctx->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+            *prot = PAGE_RWX;
             ret = 0;
             break;
+
         case 0x0:
             if (pr != 0) {
                 /* Raise Zone protection fault.  */
                 env->spr[SPR_40x_ESR] = 1 << 22;
-                ctx->prot = 0;
+                *prot = 0;
                 ret = -2;
                 break;
             }
             /* fall through */
         case 0x1:
-        check_perms:
+check_perms:
             /* Check from TLB entry */
-            ctx->prot = tlb->prot;
-            ret = check_prot(ctx->prot, access_type);
+            *prot = tlb->prot;
+            ret = check_prot(*prot, access_type);
             if (ret == -2) {
                 env->spr[SPR_40x_ESR] = 0;
             }
             break;
         }
-        if (ret >= 0) {
-            ctx->raddr = raddr;
-            qemu_log_mask(CPU_LOG_MMU, "%s: access granted " TARGET_FMT_lx
-                          " => " HWADDR_FMT_plx
-                          " %d %d\n", __func__, address, ctx->raddr, ctx->prot,
-                          ret);
-            return 0;
-        }
     }
-    qemu_log_mask(CPU_LOG_MMU, "%s: access refused " TARGET_FMT_lx
-                  " => " HWADDR_FMT_plx " %d %d\n",
-                  __func__, address, raddr, ctx->prot, ret);
+    qemu_log_mask(CPU_LOG_MMU, "%s: access %s " TARGET_FMT_lx " => "
+                  HWADDR_FMT_plx " %d %d\n",  __func__,
+                  ret < 0 ? "refused" : "granted", address,
+                  ret < 0 ? 0 : *raddr, *prot, ret);
 
     return ret;
 }
@@ -1171,7 +1163,8 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
     case POWERPC_MMU_SOFT_6xx:
         return mmu6xx_get_physical_address(env, ctx, eaddr, access_type, type);
     case POWERPC_MMU_SOFT_4xx:
-        return mmu40x_get_physical_address(env, ctx, eaddr, access_type);
+        return mmu40x_get_physical_address(env, &ctx->raddr, &ctx->prot, eaddr,
+                                           access_type);
     case POWERPC_MMU_REAL:
         cpu_abort(env_cpu(env),
                   "PowerPC in real mode do not do any translation\n");
-- 
2.30.9


