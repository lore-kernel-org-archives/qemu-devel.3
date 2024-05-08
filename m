Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF611C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 23:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4qpk-0003OE-5O; Wed, 08 May 2024 19:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4qpg-0003Hr-Kv; Wed, 08 May 2024 19:36:20 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4qpe-0002Xx-Rr; Wed, 08 May 2024 19:36:20 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4D8344E65D4;
 Thu, 09 May 2024 01:36:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id TrYHc2MBkM6U; Thu,  9 May 2024 01:36:15 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 586074E65D5; Thu, 09 May 2024 01:36:15 +0200 (CEST)
Message-Id: <e2ea5e687829967324015f1fbf35fbcfbe6cb3e3.1715209155.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715209155.git.balaton@eik.bme.hu>
References: <cover.1715209155.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 12/33] target/ppc/mmu_common.c: Eliminate ret from
 mmu6xx_get_physical_address()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 09 May 2024 01:36:15 +0200 (CEST)
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

Return directly, which is simpler than dragging a return value through
multpile if and else blocks.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 84 +++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 45 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 89bfd9aa45..03d9e6bfda 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -386,7 +386,6 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     target_ulong vsid, sr, pgidx;
     int ds, target_page_bits;
     bool pr;
-    int ret;
 
     /* First try to find a BAT entry if there are any */
     if (env->nb_BATs && get_bat_6xx_tlb(env, ctx, eaddr, access_type) == 0) {
@@ -419,7 +418,6 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     qemu_log_mask(CPU_LOG_MMU,
             "pte segment: key=%d ds %d nx %d vsid " TARGET_FMT_lx "\n",
             ctx->key, ds, ctx->nx, vsid);
-    ret = -1;
     if (!ds) {
         /* Check if instruction fetch is allowed, if needed */
         if (type == ACCESS_CODE && ctx->nx) {
@@ -436,51 +434,47 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
         /* Initialize real address with an invalid value */
         ctx->raddr = (hwaddr)-1ULL;
         /* Software TLB search */
-        ret = ppc6xx_tlb_check(env, ctx, eaddr, access_type);
-    } else {
-        qemu_log_mask(CPU_LOG_MMU, "direct store...\n");
-        /* Direct-store segment : absolutely *BUGGY* for now */
-
-        switch (type) {
-        case ACCESS_INT:
-            /* Integer load/store : only access allowed */
-            break;
-        case ACCESS_CODE:
-            /* No code fetch is allowed in direct-store areas */
-            return -4;
-        case ACCESS_FLOAT:
-            /* Floating point load/store */
-            return -4;
-        case ACCESS_RES:
-            /* lwarx, ldarx or srwcx. */
-            return -4;
-        case ACCESS_CACHE:
-            /*
-             * dcba, dcbt, dcbtst, dcbf, dcbi, dcbst, dcbz, or icbi
-             *
-             * Should make the instruction do no-op.  As it already do
-             * no-op, it's quite easy :-)
-             */
-            ctx->raddr = eaddr;
-            return 0;
-        case ACCESS_EXT:
-            /* eciwx or ecowx */
-            return -4;
-        default:
-            qemu_log_mask(CPU_LOG_MMU, "ERROR: instruction should not need "
-                          "address translation\n");
-            return -4;
-        }
-        if ((access_type == MMU_DATA_STORE || ctx->key != 1) &&
-            (access_type == MMU_DATA_LOAD || ctx->key != 0)) {
-            ctx->raddr = eaddr;
-            ret = 2;
-        } else {
-            ret = -2;
-        }
+        return ppc6xx_tlb_check(env, ctx, eaddr, access_type);
     }
 
-    return ret;
+    /* Direct-store segment : absolutely *BUGGY* for now */
+    qemu_log_mask(CPU_LOG_MMU, "direct store...\n");
+    switch (type) {
+    case ACCESS_INT:
+        /* Integer load/store : only access allowed */
+        break;
+    case ACCESS_CODE:
+        /* No code fetch is allowed in direct-store areas */
+        return -4;
+    case ACCESS_FLOAT:
+        /* Floating point load/store */
+        return -4;
+    case ACCESS_RES:
+        /* lwarx, ldarx or srwcx. */
+        return -4;
+    case ACCESS_CACHE:
+        /*
+         * dcba, dcbt, dcbtst, dcbf, dcbi, dcbst, dcbz, or icbi
+         *
+         * Should make the instruction do no-op.  As it already do
+         * no-op, it's quite easy :-)
+         */
+        ctx->raddr = eaddr;
+        return 0;
+    case ACCESS_EXT:
+        /* eciwx or ecowx */
+        return -4;
+    default:
+        qemu_log_mask(CPU_LOG_MMU, "ERROR: instruction should not need address"
+                                   " translation\n");
+        return -4;
+    }
+    if ((access_type == MMU_DATA_STORE || ctx->key != 1) &&
+        (access_type == MMU_DATA_LOAD || ctx->key != 0)) {
+        ctx->raddr = eaddr;
+        return 2;
+    }
+    return -2;
 }
 
 /* Generic TLB check function for embedded PowerPC implementations */
-- 
2.30.9


