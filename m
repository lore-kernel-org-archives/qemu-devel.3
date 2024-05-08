Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73979C25B74
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 23:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4qqX-0004xx-Oa; Wed, 08 May 2024 19:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4qqE-0004Qq-5P; Wed, 08 May 2024 19:37:00 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4qqB-0002cJ-Hr; Wed, 08 May 2024 19:36:53 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0524F4E65D5;
 Thu, 09 May 2024 01:36:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id OrL-jVA7k5od; Thu,  9 May 2024 01:36:27 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 13B0F4E65D7; Thu, 09 May 2024 01:36:27 +0200 (CEST)
Message-Id: <7a27b5545592078f858b49670dd9e06f4c97fef5.1715209155.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715209155.git.balaton@eik.bme.hu>
References: <cover.1715209155.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 23/33] target/ppc: Remove pp_check() and reuse
 ppc_hash32_pp_prot()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 09 May 2024 01:36:27 +0200 (CEST)
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

The ppc_hash32_pp_prot() function in mmu-hash32.c is the same as
pp_check() in mmu_common.c, merge these to remove duplicated code.
Define the common function in internal.h as static lnline otherwise
exporting the function from mmu-hash32.c would stop the compiler
inlining it which results in slightly lower performance.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/internal.h   | 35 ++++++++++++++++++++++++++++++++
 target/ppc/mmu-hash32.c | 45 -----------------------------------------
 target/ppc/mmu_common.c | 44 ++--------------------------------------
 3 files changed, 37 insertions(+), 87 deletions(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 4a90dd2584..46176c4711 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -256,6 +256,41 @@ static inline int prot_for_access_type(MMUAccessType access_type)
 #ifndef CONFIG_USER_ONLY
 
 /* PowerPC MMU emulation */
+static inline int ppc_hash32_pp_prot(int key, int pp, int nx)
+{
+    int prot;
+
+    if (key == 0) {
+        switch (pp) {
+        case 0x0:
+        case 0x1:
+        case 0x2:
+            prot = PAGE_READ | PAGE_WRITE;
+            break;
+        case 0x3:
+            prot = PAGE_READ;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    } else {
+        switch (pp) {
+        case 0x0:
+            prot = 0;
+            break;
+        case 0x1:
+        case 0x3:
+            prot = PAGE_READ;
+            break;
+        case 0x2:
+            prot = PAGE_READ | PAGE_WRITE;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+    return nx ? prot : prot | PAGE_EXEC;
+}
 
 bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
                       hwaddr *raddrp, int *psizep, int *protp,
diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 6dfedab11d..960751a50e 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -43,51 +43,6 @@ struct mmu_ctx_hash32 {
     int key;                       /* Access key                */
 };
 
-static int ppc_hash32_pp_prot(int key, int pp, int nx)
-{
-    int prot;
-
-    if (key == 0) {
-        switch (pp) {
-        case 0x0:
-        case 0x1:
-        case 0x2:
-            prot = PAGE_READ | PAGE_WRITE;
-            break;
-
-        case 0x3:
-            prot = PAGE_READ;
-            break;
-
-        default:
-            abort();
-        }
-    } else {
-        switch (pp) {
-        case 0x0:
-            prot = 0;
-            break;
-
-        case 0x1:
-        case 0x3:
-            prot = PAGE_READ;
-            break;
-
-        case 0x2:
-            prot = PAGE_READ | PAGE_WRITE;
-            break;
-
-        default:
-            abort();
-        }
-    }
-    if (nx == 0) {
-        prot |= PAGE_EXEC;
-    }
-
-    return prot;
-}
-
 static int ppc_hash32_pte_prot(int mmu_idx,
                                target_ulong sr, ppc_hash_pte32_t pte)
 {
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 2a7b4a275c..72811d47c9 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -76,44 +76,6 @@ void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
 /*****************************************************************************/
 /* PowerPC MMU emulation */
 
-static int pp_check(int key, int pp, int nx)
-{
-    int access;
-
-    /* Compute access rights */
-    access = 0;
-    if (key == 0) {
-        switch (pp) {
-        case 0x0:
-        case 0x1:
-        case 0x2:
-            access |= PAGE_WRITE;
-            /* fall through */
-        case 0x3:
-            access |= PAGE_READ;
-            break;
-        }
-    } else {
-        switch (pp) {
-        case 0x0:
-            access = 0;
-            break;
-        case 0x1:
-        case 0x3:
-            access = PAGE_READ;
-            break;
-        case 0x2:
-            access = PAGE_READ | PAGE_WRITE;
-            break;
-        }
-    }
-    if (nx == 0) {
-        access |= PAGE_EXEC;
-    }
-
-    return access;
-}
-
 static int check_prot(int prot, MMUAccessType access_type)
 {
     return prot & prot_for_access_type(access_type) ? 0 : -2;
@@ -141,7 +103,7 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
                                 MMUAccessType access_type)
 {
     target_ulong ptem, mmask;
-    int access, ret, pteh, ptev, pp;
+    int ret, pteh, ptev, pp;
 
     ret = -1;
     /* Check validity and table match */
@@ -160,11 +122,9 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
                     return -3;
                 }
             }
-            /* Compute access rights */
-            access = pp_check(ctx->key, pp, ctx->nx);
             /* Keep the matching PTE information */
             ctx->raddr = pte1;
-            ctx->prot = access;
+            ctx->prot = ppc_hash32_pp_prot(ctx->key, pp, ctx->nx);
             ret = check_prot(ctx->prot, access_type);
             if (ret == 0) {
                 /* Access granted */
-- 
2.30.9


