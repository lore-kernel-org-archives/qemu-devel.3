Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5377AC25B5C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 23:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Jbt-0002PN-4T; Wed, 01 May 2024 19:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s2Jbq-0002NQ-Kg; Wed, 01 May 2024 19:43:34 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s2Jbo-00053F-D5; Wed, 01 May 2024 19:43:33 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E1EAB4E6056;
 Thu, 02 May 2024 01:43:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 1HHeoly10UHp; Thu,  2 May 2024 01:43:28 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id EE6924E602F; Thu, 02 May 2024 01:43:28 +0200 (CEST)
Message-Id: <cc6221f9333bae65037c42ca9ba0540f9e96c493.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1714606359.git.balaton@eik.bme.hu>
References: <cover.1714606359.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 22/28] target/ppc: Remove ppc_hash32_pp_prot() and reuse
 common function
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 02 May 2024 01:43:28 +0200 (CEST)
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

The ppc_hash32_pp_prot() function in mmu-hash32.c is the same as
pp_check() in mmu_common.c. Rename the latter to ppc_pte_prot() and
merge with ppc_hash32_pp_prot() to remove duplicated code.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/internal.h   |  2 +-
 target/ppc/mmu-hash32.c | 47 +----------------------------------------
 target/ppc/mmu_common.c | 19 +++++++++--------
 3 files changed, 12 insertions(+), 56 deletions(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 61c2aadd0d..d7c923b017 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -255,7 +255,7 @@ static inline int prot_for_access_type(MMUAccessType access_type)
 #ifndef CONFIG_USER_ONLY
 
 /* PowerPC MMU emulation */
-
+int ppc_pte_prot(int key, int pp, int nx);
 bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
                       hwaddr *raddrp, int *psizep, int *protp,
                       int mmu_idx, bool guest_visible);
diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 3976416840..ee9df351ae 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -42,51 +42,6 @@ struct mmu_ctx_hash32 {
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
@@ -95,7 +50,7 @@ static int ppc_hash32_pte_prot(int mmu_idx,
     key = !!(mmuidx_pr(mmu_idx) ? (sr & SR32_KP) : (sr & SR32_KS));
     pp = pte.pte1 & HPTE32_R_PP;
 
-    return ppc_hash32_pp_prot(key, pp, !!(sr & SR32_NX));
+    return ppc_pte_prot(key, pp, !!(sr & SR32_NX));
 }
 
 static target_ulong hash32_bat_size(int mmu_idx,
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 41ef174ab4..0ce5c1e841 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -75,22 +75,23 @@ void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
 /*****************************************************************************/
 /* PowerPC MMU emulation */
 
-static int pp_check(int key, int pp, int nx)
+int ppc_pte_prot(int key, int pp, int nx)
 {
     int access;
 
     /* Compute access rights */
-    access = 0;
     if (key == 0) {
         switch (pp) {
         case 0x0:
         case 0x1:
         case 0x2:
-            access |= PAGE_WRITE;
-            /* fall through */
+            access = PAGE_READ | PAGE_WRITE;
+            break;
         case 0x3:
-            access |= PAGE_READ;
+            access = PAGE_READ;
             break;
+        default:
+            g_assert_not_reached();
         }
     } else {
         switch (pp) {
@@ -104,6 +105,8 @@ static int pp_check(int key, int pp, int nx)
         case 0x2:
             access = PAGE_READ | PAGE_WRITE;
             break;
+        default:
+            g_assert_not_reached();
         }
     }
     if (nx == 0) {
@@ -140,7 +143,7 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
                                 MMUAccessType access_type)
 {
     target_ulong ptem, mmask;
-    int access, ret, pteh, ptev, pp;
+    int ret, pteh, ptev, pp;
 
     ret = -1;
     /* Check validity and table match */
@@ -159,11 +162,9 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
                     return -3;
                 }
             }
-            /* Compute access rights */
-            access = pp_check(ctx->key, pp, ctx->nx);
             /* Keep the matching PTE information */
             ctx->raddr = pte1;
-            ctx->prot = access;
+            ctx->prot = ppc_pte_prot(ctx->key, pp, ctx->nx);
             ret = check_prot(ctx->prot, access_type);
             if (ret == 0) {
                 /* Access granted */
-- 
2.30.9


