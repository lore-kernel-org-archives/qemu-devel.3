Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2731EC25B74
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 20:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5ALI-0000Ql-AM; Thu, 09 May 2024 16:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5AKz-0000Dg-0D; Thu, 09 May 2024 16:25:58 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5AKx-000150-2V; Thu, 09 May 2024 16:25:56 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7CFD64E6028;
 Thu, 09 May 2024 22:25:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id YdnbfcgvLhGD; Thu,  9 May 2024 22:25:51 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8ED684E65D5; Thu, 09 May 2024 22:25:51 +0200 (CEST)
Message-Id: <5532cf1b506a19cfb0dfe031872f4602aaa9a971.1715285340.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715285340.git.balaton@eik.bme.hu>
References: <cover.1715285340.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 17/32] target/ppc/mmu_common.c: Don't use mmu_ctx_t in
 mmubooke_get_physical_address()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 09 May 2024 22:25:51 +0200 (CEST)
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

mmubooke_get_physical_address() only uses the raddr and prot fields
from mmu_ctx_t. Pass these directly instead of using a ctx struct.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index adce6cceb8..12dac9e63a 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -634,36 +634,25 @@ static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
     return access_type == MMU_INST_FETCH ? -3 : -2;
 }
 
-static int mmubooke_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
-                                         target_ulong address,
+static int mmubooke_get_physical_address(CPUPPCState *env, hwaddr *raddr,
+                                         int *prot, target_ulong address,
                                          MMUAccessType access_type)
 {
     ppcemb_tlb_t *tlb;
-    hwaddr raddr;
-    int i, ret;
+    int i, ret = -1;
 
-    ret = -1;
-    raddr = (hwaddr)-1ULL;
     for (i = 0; i < env->nb_tlb; i++) {
         tlb = &env->tlb.tlbe[i];
-        ret = mmubooke_check_tlb(env, tlb, &raddr, &ctx->prot, address,
+        ret = mmubooke_check_tlb(env, tlb, raddr, prot, address,
                                  access_type, i);
         if (ret != -1) {
             break;
         }
     }
-
-    if (ret >= 0) {
-        ctx->raddr = raddr;
-        qemu_log_mask(CPU_LOG_MMU, "%s: access granted " TARGET_FMT_lx
-                      " => " HWADDR_FMT_plx " %d %d\n", __func__,
-                      address, ctx->raddr, ctx->prot, ret);
-    } else {
-         qemu_log_mask(CPU_LOG_MMU, "%s: access refused " TARGET_FMT_lx
-                       " => " HWADDR_FMT_plx " %d %d\n", __func__,
-                       address, raddr, ctx->prot, ret);
-    }
-
+    qemu_log_mask(CPU_LOG_MMU,
+                  "%s: access %s " TARGET_FMT_lx " => " HWADDR_FMT_plx
+                  " %d %d\n", __func__, ret < 0 ? "refused" : "granted",
+                  address, ret < 0 ? -1 : *raddr, ret == -1 ? 0 : *prot, ret);
     return ret;
 }
 
@@ -1143,7 +1132,8 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
     bool real_mode;
 
     if (env->mmu_model == POWERPC_MMU_BOOKE) {
-        return mmubooke_get_physical_address(env, ctx, eaddr, access_type);
+        return mmubooke_get_physical_address(env, &ctx->raddr, &ctx->prot,
+                                             eaddr, access_type);
     } else if (env->mmu_model == POWERPC_MMU_BOOKE206) {
         return mmubooke206_get_physical_address(env, ctx, eaddr, access_type,
                                                 mmu_idx);
-- 
2.30.9


