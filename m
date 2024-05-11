Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B14C25B4F
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 01:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5bpp-0008Mn-Uo; Fri, 10 May 2024 21:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5bp2-0005GD-6D; Fri, 10 May 2024 21:46:49 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5bp0-0003kG-Hi; Fri, 10 May 2024 21:46:47 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 19D8B4E678A;
 Sat, 11 May 2024 03:46:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id pNA_okxGUsI3; Sat, 11 May 2024 03:46:23 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2BE374E678F; Sat, 11 May 2024 03:46:23 +0200 (CEST)
Message-Id: <46a54798fc07441f6ddedb925752a8fb39f19cea.1715390232.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715390232.git.balaton@eik.bme.hu>
References: <cover.1715390232.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v6 42/48] target/ppc/mmu_common.c: Simplify
 ppc6xx_tlb_pte_check()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Sat, 11 May 2024 03:46:23 +0200 (CEST)
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

Invert conditions to avoid deep nested ifs and return early instead.
Remove some obvious comments that don't add more clarity.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 44 ++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index a035cefcad..564fcc7cfb 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -99,32 +99,26 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
                                 MMUAccessType access_type)
 {
     /* Check validity and table match */
-    if (pte_is_valid(pte0) && ((pte0 >> 6) & 1) == pteh) {
-        /* Check vsid & api */
-        if ((pte0 & PTE_PTEM_MASK) == ctx->ptem) {
-            if (ctx->raddr != (hwaddr)-1ULL) {
-                /* all matches should have equal RPN, WIMG & PP */
-                if ((ctx->raddr & PTE_CHECK_MASK) != (pte1 & PTE_CHECK_MASK)) {
-                    qemu_log_mask(CPU_LOG_MMU, "Bad RPN/WIMG/PP\n");
-                    return -3;
-                }
-            }
-            /* Keep the matching PTE information */
-            ctx->raddr = pte1;
-            ctx->prot = ppc_hash32_pp_prot(ctx->key, pte1 & HPTE32_R_PP,
-                                           ctx->nx);
-            if (check_prot_access_type(ctx->prot, access_type)) {
-                /* Access granted */
-                qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
-                return 0;
-            } else {
-                /* Access right violation */
-                qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
-                return -2;
-            }
-        }
+    if (!pte_is_valid(pte0) || ((pte0 >> 6) & 1) != pteh ||
+        (pte0 & PTE_PTEM_MASK) != ctx->ptem) {
+        return -1;
+    }
+    /* all matches should have equal RPN, WIMG & PP */
+    if (ctx->raddr != (hwaddr)-1ULL &&
+        (ctx->raddr & PTE_CHECK_MASK) != (pte1 & PTE_CHECK_MASK)) {
+        qemu_log_mask(CPU_LOG_MMU, "Bad RPN/WIMG/PP\n");
+        return -3;
+    }
+    /* Keep the matching PTE information */
+    ctx->raddr = pte1;
+    ctx->prot = ppc_hash32_pp_prot(ctx->key, pte1 & HPTE32_R_PP, ctx->nx);
+    if (check_prot_access_type(ctx->prot, access_type)) {
+        qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
+        return 0;
+    } else {
+        qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
+        return -2;
     }
-    return -1;
 }
 
 /* Software driven TLB helpers */
-- 
2.30.9


