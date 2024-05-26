Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3D6C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 23:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBN4B-000436-5v; Sun, 26 May 2024 19:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN49-00040p-Mo; Sun, 26 May 2024 19:14:13 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN46-0003Uv-SX; Sun, 26 May 2024 19:14:12 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 377F44E6000;
 Mon, 27 May 2024 01:12:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id aD5tb5RZVQPE; Mon, 27 May 2024 01:12:36 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3DB594E6001; Mon, 27 May 2024 01:12:36 +0200 (CEST)
Message-Id: <3e66168f9d3d1667b5a1d81f74cf019ecfdd9c62.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1716763435.git.balaton@eik.bme.hu>
References: <cover.1716763435.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 01/43] target/ppc: Reorganise and rename ppc_hash32_pp_prot()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 27 May 2024 01:12:36 +0200 (CEST)
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

Reorganise ppc_hash32_pp_prot() swapping the if legs so it does not
test for negative first and clean up to make it shorter. Also rename
it to ppc_hash32_prot().

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu-hash32.c |  2 +-
 target/ppc/mmu-hash32.h | 35 +++++++++++++----------------------
 target/ppc/mmu_common.c |  2 +-
 3 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index d5f2057eb1..8a446c8a7d 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -45,7 +45,7 @@ static int ppc_hash32_pte_prot(int mmu_idx,
     key = !!(mmuidx_pr(mmu_idx) ? (sr & SR32_KP) : (sr & SR32_KS));
     pp = pte.pte1 & HPTE32_R_PP;
 
-    return ppc_hash32_pp_prot(key, pp, !!(sr & SR32_NX));
+    return ppc_hash32_prot(key, pp, !!(sr & SR32_NX));
 }
 
 static target_ulong hash32_bat_size(int mmu_idx,
diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
index f0ce6951b4..bc4eedbecc 100644
--- a/target/ppc/mmu-hash32.h
+++ b/target/ppc/mmu-hash32.h
@@ -102,49 +102,40 @@ static inline void ppc_hash32_store_hpte1(PowerPCCPU *cpu,
     stl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2, pte1);
 }
 
-static inline int ppc_hash32_pp_prot(bool key, int pp, bool nx)
+static inline int ppc_hash32_prot(bool key, int pp, bool nx)
 {
     int prot;
 
-    if (key == 0) {
+    if (key) {
         switch (pp) {
         case 0x0:
-        case 0x1:
-        case 0x2:
-            prot = PAGE_READ | PAGE_WRITE;
+            prot = 0;
             break;
-
+        case 0x1:
         case 0x3:
             prot = PAGE_READ;
             break;
-
+        case 0x2:
+            prot = PAGE_READ | PAGE_WRITE;
+            break;
         default:
-            abort();
+            g_assert_not_reached();
         }
     } else {
         switch (pp) {
         case 0x0:
-            prot = 0;
-            break;
-
         case 0x1:
-        case 0x3:
-            prot = PAGE_READ;
-            break;
-
         case 0x2:
             prot = PAGE_READ | PAGE_WRITE;
             break;
-
+        case 0x3:
+            prot = PAGE_READ;
+            break;
         default:
-            abort();
+            g_assert_not_reached();
         }
     }
-    if (nx == 0) {
-        prot |= PAGE_EXEC;
-    }
-
-    return prot;
+    return nx ? prot : prot | PAGE_EXEC;
 }
 
 typedef struct {
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index e2542694f0..08c5b61f76 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -120,7 +120,7 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
             }
             /* Keep the matching PTE information */
             ctx->raddr = pte1;
-            ctx->prot = ppc_hash32_pp_prot(ctx->key, pp, ctx->nx);
+            ctx->prot = ppc_hash32_prot(ctx->key, pp, ctx->nx);
             if (check_prot_access_type(ctx->prot, access_type)) {
                 /* Access granted */
                 qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
-- 
2.30.9


