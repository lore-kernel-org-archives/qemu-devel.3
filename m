Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3466C25B74
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 23:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6IcJ-0001VB-2p; Sun, 12 May 2024 19:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6IcF-0001P7-ML; Sun, 12 May 2024 19:28:27 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6IcD-0000MQ-87; Sun, 12 May 2024 19:28:27 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C5B944E6076;
 Mon, 13 May 2024 01:28:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id dZGQBz5w2Tuj; Mon, 13 May 2024 01:28:01 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D739D4E677A; Mon, 13 May 2024 01:28:01 +0200 (CEST)
Message-Id: <213dd134f56b35f0935305e579ab3bc8acaaa52d.1715555763.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715555763.git.balaton@eik.bme.hu>
References: <cover.1715555763.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v7 28/61] target/ppc/mmu_common.c: Remove pte_update_flags()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 13 May 2024 01:28:01 +0200 (CEST)
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

This function is used only once, its return value is ignored and one
of its parameter is a return value from a previous call. It is better
to inline it in the caller and remove it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 41 +++++++++++++----------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 34200d9cb1..4fb93cbf40 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -179,39 +179,14 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
     return ret;
 }
 
-static int pte_update_flags(mmu_ctx_t *ctx, target_ulong *pte1p,
-                            int ret, MMUAccessType access_type)
-{
-    int store = 0;
-
-    /* Update page flags */
-    if (!(*pte1p & 0x00000100)) {
-        /* Update accessed flag */
-        *pte1p |= 0x00000100;
-        store = 1;
-    }
-    if (!(*pte1p & 0x00000080)) {
-        if (access_type == MMU_DATA_STORE && ret == 0) {
-            /* Update changed flag */
-            *pte1p |= 0x00000080;
-            store = 1;
-        } else {
-            /* Force page fault for first write access */
-            ctx->prot &= ~PAGE_WRITE;
-        }
-    }
-
-    return store;
-}
-
 /* Software driven TLB helpers */
 
 static int ppc6xx_tlb_check(CPUPPCState *env, mmu_ctx_t *ctx,
                             target_ulong eaddr, MMUAccessType access_type)
 {
     ppc6xx_tlb_t *tlb;
-    int nr, best, way;
-    int ret;
+    target_ulong *pte1p;
+    int nr, best, way, ret;
 
     best = -1;
     ret = -1; /* No TLB found */
@@ -264,7 +239,17 @@ done:
                       " prot=%01x ret=%d\n",
                       ctx->raddr & TARGET_PAGE_MASK, ctx->prot, ret);
         /* Update page flags */
-        pte_update_flags(ctx, &env->tlb.tlb6[best].pte1, ret, access_type);
+        pte1p = &env->tlb.tlb6[best].pte1;
+        *pte1p |= 0x00000100; /* Update accessed flag */
+        if (!(*pte1p & 0x00000080)) {
+            if (access_type == MMU_DATA_STORE && ret == 0) {
+                /* Update changed flag */
+                *pte1p |= 0x00000080;
+            } else {
+                /* Force page fault for first write access */
+                ctx->prot &= ~PAGE_WRITE;
+            }
+        }
     }
 #if defined(DUMP_PAGE_TABLES)
     if (qemu_loglevel_mask(CPU_LOG_MMU)) {
-- 
2.30.9


