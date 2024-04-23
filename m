Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC21AC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOgD-0001T9-2E; Tue, 23 Apr 2024 18:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rzOgA-0001SC-QM; Tue, 23 Apr 2024 18:31:58 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rzOg9-0004fD-5e; Tue, 23 Apr 2024 18:31:58 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B2DC24E6054;
 Wed, 24 Apr 2024 00:31:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id yEdFVZzD8MNB; Wed, 24 Apr 2024 00:31:33 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CB7C14E6031; Wed, 24 Apr 2024 00:31:33 +0200 (CEST)
Message-Id: <517eaa380f883622276f34af2db9485bb00003a5.1713907038.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1713907038.git.balaton@eik.bme.hu>
References: <cover.1713907038.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 22/24] target/ppc/mmu_common.c: Remove BookE handling from
 get_physical_address_wtlb()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Wed, 24 Apr 2024 00:31:33 +0200 (CEST)
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

This function is no longer called for BookE MMU model so remove parts
related to it. This has uncovered a few may be used uninitialised
warnings that are also fixed.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index b7803c1c26..ce1cf5cb77 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -687,12 +687,10 @@ static int mmubooke_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
         ret = mmubooke_check_tlb(env, tlb, &raddr, &ctx->prot, address,
                                  access_type, i);
         if (ret != -1) {
-            if (ret >= 0) {
-                ctx->raddr = raddr;
-            }
             break;
         }
     }
+    ctx->raddr = raddr;
     qemu_log_mask(CPU_LOG_MMU,
                   "%s: access %s " TARGET_FMT_lx " => " HWADDR_FMT_plx
                   " %d %d\n", __func__, ret < 0 ? "refused" : "granted",
@@ -902,9 +900,6 @@ static int mmubooke206_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
             ret = mmubooke206_check_tlb(env, tlb, &raddr, &ctx->prot, address,
                                         access_type, mmu_idx);
             if (ret != -1) {
-                if (ret >= 0) {
-                    ctx->raddr = raddr;
-                }
                 goto found_tlb;
             }
         }
@@ -912,6 +907,7 @@ static int mmubooke206_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
 
 found_tlb:
 
+    ctx->raddr = raddr;
     qemu_log_mask(CPU_LOG_MMU, "%s: access %s " TARGET_FMT_lx " => "
                   HWADDR_FMT_plx " %d %d\n", __func__,
                   ret < 0 ? "refused" : "granted", address, raddr,
@@ -1168,20 +1164,9 @@ static int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
                                      MMUAccessType access_type, int type,
                                      int mmu_idx)
 {
-    bool real_mode;
-
-    if (env->mmu_model == POWERPC_MMU_BOOKE) {
-        return mmubooke_get_physical_address(env, ctx, eaddr, access_type);
-    } else if (env->mmu_model == POWERPC_MMU_BOOKE206) {
-        return mmubooke206_get_physical_address(env, ctx, eaddr, access_type,
-                                                mmu_idx);
-    }
-
-    real_mode = (type == ACCESS_CODE) ? !FIELD_EX64(env->msr, MSR, IR)
-                                      : !FIELD_EX64(env->msr, MSR, DR);
-    if (real_mode && (env->mmu_model == POWERPC_MMU_SOFT_6xx ||
-                      env->mmu_model == POWERPC_MMU_SOFT_4xx ||
-                      env->mmu_model == POWERPC_MMU_REAL)) {
+    bool real_mode = (type == ACCESS_CODE) ? !FIELD_EX64(env->msr, MSR, IR)
+                                           : !FIELD_EX64(env->msr, MSR, DR);
+    if (real_mode) {
         memset(ctx, 0, sizeof(*ctx));
         ctx->raddr = eaddr;
         ctx->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-- 
2.30.9


