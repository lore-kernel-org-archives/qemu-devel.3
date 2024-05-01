Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F45CC25B5C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 23:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Jbn-0002K8-TP; Wed, 01 May 2024 19:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s2Jbk-0002Gl-IZ; Wed, 01 May 2024 19:43:28 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s2Jbj-000520-10; Wed, 01 May 2024 19:43:28 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7B2CC4E6039;
 Thu, 02 May 2024 01:43:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id ZXqQLzlQZZHy; Thu,  2 May 2024 01:43:22 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 91D7A4E602F; Thu, 02 May 2024 01:43:22 +0200 (CEST)
Message-Id: <14bc4664f49e6634e49f454971d8281c69ff0ff2.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1714606359.git.balaton@eik.bme.hu>
References: <cover.1714606359.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 16/28] target/ppc/mmu_common.c: Simplify
 mmubooke206_get_physical_address()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 02 May 2024 01:43:22 +0200 (CEST)
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

This function is similar to mmubooke_get_physical_address() and can be
simplified the same way.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 760e4072b2..ebf18a751c 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -872,15 +872,11 @@ static int mmubooke206_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
                                             int mmu_idx)
 {
     ppcmas_tlb_t *tlb;
-    hwaddr raddr;
-    int i, j, ret;
-
-    ret = -1;
-    raddr = (hwaddr)-1ULL;
+    hwaddr raddr = (hwaddr)-1ULL;
+    int i, j, ways, ret = -1;
 
     for (i = 0; i < BOOKE206_MAX_TLBN; i++) {
-        int ways = booke206_tlb_ways(env, i);
-
+        ways = booke206_tlb_ways(env, i);
         for (j = 0; j < ways; j++) {
             tlb = booke206_get_tlbm(env, i, address, j);
             if (!tlb) {
@@ -889,6 +885,9 @@ static int mmubooke206_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
             ret = mmubooke206_check_tlb(env, tlb, &raddr, &ctx->prot, address,
                                         access_type, mmu_idx);
             if (ret != -1) {
+                if (ret >= 0) {
+                    ctx->raddr = raddr;
+                }
                 goto found_tlb;
             }
         }
@@ -896,17 +895,10 @@ static int mmubooke206_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
 
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


