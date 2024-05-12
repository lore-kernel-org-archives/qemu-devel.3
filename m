Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC033C25B4F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 23:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6IcA-0001OV-Sn; Sun, 12 May 2024 19:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6Ic9-0001Nu-FU; Sun, 12 May 2024 19:28:21 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6Ic7-0000L5-TT; Sun, 12 May 2024 19:28:21 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 620724E6774;
 Mon, 13 May 2024 01:27:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id GqT4SOTBSVQq; Mon, 13 May 2024 01:27:55 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 718D14E6765; Mon, 13 May 2024 01:27:55 +0200 (CEST)
Message-Id: <296aaa24c73c2ed5e133421335d4e3259e5cf8ae.1715555763.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715555763.git.balaton@eik.bme.hu>
References: <cover.1715555763.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v7 22/61] target/ppc/mmu_common.c: Simplify ppc_booke_xlate()
 part 1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 13 May 2024 01:27:55 +0200 (CEST)
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

Move setting error_code that appears in every case out in front and
hoist the common fall through case for BOOKE206 as well which allows
removing the nested switches.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 41 ++++++++++++-----------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 09a780bb7a..611092966b 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -1220,58 +1220,41 @@ static bool ppc_booke_xlate(PowerPCCPU *cpu, vaddr eaddr,
     }
 
     log_cpu_state_mask(CPU_LOG_MMU, cs, 0);
+    env->error_code = 0;
+    if (ret == -1) {
+        if (env->mmu_model == POWERPC_MMU_BOOKE206) {
+            booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
+        }
+    }
     if (access_type == MMU_INST_FETCH) {
         switch (ret) {
         case -1:
             /* No matches in page tables or TLB */
-            switch (env->mmu_model) {
-            case POWERPC_MMU_BOOKE206:
-                booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
-                /* fall through */
-            case POWERPC_MMU_BOOKE:
-                cs->exception_index = POWERPC_EXCP_ITLB;
-                env->error_code = 0;
-                env->spr[SPR_BOOKE_DEAR] = eaddr;
-                env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
-                break;
-            default:
-                g_assert_not_reached();
-            }
+            cs->exception_index = POWERPC_EXCP_ITLB;
+            env->spr[SPR_BOOKE_DEAR] = eaddr;
+            env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
             break;
         case -2:
             /* Access rights violation */
             cs->exception_index = POWERPC_EXCP_ISI;
-            env->error_code = 0;
             break;
         case -3:
             /* No execute protection violation */
             cs->exception_index = POWERPC_EXCP_ISI;
             env->spr[SPR_BOOKE_ESR] = 0;
-            env->error_code = 0;
             break;
         }
     } else {
         switch (ret) {
         case -1:
             /* No matches in page tables or TLB */
-            switch (env->mmu_model) {
-            case POWERPC_MMU_BOOKE206:
-                booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
-                /* fall through */
-            case POWERPC_MMU_BOOKE:
-                cs->exception_index = POWERPC_EXCP_DTLB;
-                env->error_code = 0;
-                env->spr[SPR_BOOKE_DEAR] = eaddr;
-                env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
-                break;
-            default:
-                g_assert_not_reached();
-            }
+            cs->exception_index = POWERPC_EXCP_DTLB;
+            env->spr[SPR_BOOKE_DEAR] = eaddr;
+            env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
             break;
         case -2:
             /* Access rights violation */
             cs->exception_index = POWERPC_EXCP_DSI;
-            env->error_code = 0;
             env->spr[SPR_BOOKE_DEAR] = eaddr;
             env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
             break;
-- 
2.30.9


