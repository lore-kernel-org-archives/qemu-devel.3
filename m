Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCC3C25B4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 00:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4V07-0002k1-Cw; Tue, 07 May 2024 20:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4UyA-0007HI-Rh; Tue, 07 May 2024 20:15:43 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4Uy5-0003lB-Q4; Tue, 07 May 2024 20:15:37 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 335014E65C0;
 Wed, 08 May 2024 02:15:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id fAD3JFsxLV-T; Wed,  8 May 2024 02:15:10 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 445744E65CD; Wed, 08 May 2024 02:15:10 +0200 (CEST)
Message-Id: <6fece3877d80ad4d82a36de3b10f61aedd796f62.1715125376.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715125376.git.balaton@eik.bme.hu>
References: <cover.1715125376.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 17/33] target/ppc/mmu_common.c: Simplify
 mmubooke206_get_physical_address()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Wed, 08 May 2024 02:15:10 +0200 (CEST)
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

This function is similar to mmubooke_get_physical_address() and can be
simplified the same way.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 9793e6d282..a5bc747f40 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -859,15 +859,11 @@ static int mmubooke206_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
                                             int mmu_idx)
 {
     ppcmas_tlb_t *tlb;
-    hwaddr raddr;
-    int i, j, ret;
-
-    ret = -1;
-    raddr = (hwaddr)-1ULL;
+    hwaddr raddr = (hwaddr)-1ULL;
+    int i, j, ret = -1;
 
     for (i = 0; i < BOOKE206_MAX_TLBN; i++) {
         int ways = booke206_tlb_ways(env, i);
-
         for (j = 0; j < ways; j++) {
             tlb = booke206_get_tlbm(env, i, address, j);
             if (!tlb) {
@@ -876,6 +872,9 @@ static int mmubooke206_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
             ret = mmubooke206_check_tlb(env, tlb, &raddr, &ctx->prot, address,
                                         access_type, mmu_idx);
             if (ret != -1) {
+                if (ret >= 0) {
+                    ctx->raddr = raddr;
+                }
                 goto found_tlb;
             }
         }
@@ -883,17 +882,10 @@ static int mmubooke206_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
 
 found_tlb:
 
-    if (ret >= 0) {
-        ctx->raddr = raddr;
-         qemu_log_mask(CPU_LOG_MMU, "%s: access granted " TARGET_FMT_lx
-                       " => " HWADDR_FMT_plx " %d %d\n", __func__, address,
-                       ctx->raddr, ctx->prot, ret);
-    } else {
-         qemu_log_mask(CPU_LOG_MMU, "%s: access refused " TARGET_FMT_lx
-                       " => " HWADDR_FMT_plx " %d %d\n", __func__, address,
-                       raddr, ctx->prot, ret);
-    }
-
+    qemu_log_mask(CPU_LOG_MMU, "%s: access %s " TARGET_FMT_lx " => "
+                  HWADDR_FMT_plx " %d %d\n", __func__,
+                  ret < 0 ? "refused" : "granted", address, raddr,
+                  ctx->prot, ret);
     return ret;
 }
 
-- 
2.30.9


