Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15772C41513
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 23:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4qpf-0003Ga-CY; Wed, 08 May 2024 19:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4qpd-0003EK-9B; Wed, 08 May 2024 19:36:17 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4qpb-0002WN-J5; Wed, 08 May 2024 19:36:17 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1D77E4E646F;
 Thu, 09 May 2024 01:36:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id UxQ7I2ybIdBK; Thu,  9 May 2024 01:36:12 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2C6454E63BF; Thu, 09 May 2024 01:36:12 +0200 (CEST)
Message-Id: <55792441865b72b8a402f769480d0a4ed8946b99.1715209155.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715209155.git.balaton@eik.bme.hu>
References: <cover.1715209155.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 09/33] target/ppc/mmu_common.c: Introduce
 mmu6xx_get_physical_address()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 09 May 2024 01:36:12 +0200 (CEST)
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

Repurpose get_segment_6xx_tlb() to do the whole address translation
for POWERPC_MMU_SOFT_6xx MMU model by moving the BAT check there and
renaming it to match other similar functions. These are only called
once together so no need to keep these separate functions and
combining them simplifies the caller allowing further restructuring.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 3391df61cb..b7c07cf515 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -360,19 +360,23 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
     return ret;
 }
 
-/* Perform segment based translation */
-static int get_segment_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
-                               target_ulong eaddr, MMUAccessType access_type,
-                               int type)
+static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
+                                       target_ulong eaddr,
+                                       MMUAccessType access_type, int type)
 {
     PowerPCCPU *cpu = env_archcpu(env);
     hwaddr hash;
-    target_ulong vsid;
+    target_ulong vsid, sr, pgidx;
     int ds, target_page_bits;
     bool pr;
     int ret;
-    target_ulong sr, pgidx;
 
+    /* First try to find a BAT entry if there are any */
+    if (env->nb_BATs && get_bat_6xx_tlb(env, ctx, eaddr, access_type) == 0) {
+        return 0;
+    }
+
+    /* Perform segment based translation when no BATs matched */
     pr = FIELD_EX64(env->msr, MSR, PR);
     ctx->eaddr = eaddr;
 
@@ -1194,14 +1198,8 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
         if (real_mode) {
             ret = check_physical(env, ctx, eaddr, access_type);
         } else {
-            /* Try to find a BAT */
-            if (env->nb_BATs != 0) {
-                ret = get_bat_6xx_tlb(env, ctx, eaddr, access_type);
-            }
-            if (ret < 0) {
-                /* We didn't match any BAT entry or don't have BATs */
-                ret = get_segment_6xx_tlb(env, ctx, eaddr, access_type, type);
-            }
+            ret = mmu6xx_get_physical_address(env, ctx, eaddr, access_type,
+                                              type);
         }
         break;
 
-- 
2.30.9


