Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41584C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 23:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2JcI-0002qu-Ga; Wed, 01 May 2024 19:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s2JcE-0002lj-C9; Wed, 01 May 2024 19:43:58 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s2JcC-00053q-EK; Wed, 01 May 2024 19:43:58 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0A6944E602D;
 Thu, 02 May 2024 01:43:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id kdJ1YfbE5Stx; Thu,  2 May 2024 01:43:32 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1773D4E6040; Thu, 02 May 2024 01:43:32 +0200 (CEST)
Message-Id: <b3caa952ce91c07bcc958a3662349418c5716673.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1714606359.git.balaton@eik.bme.hu>
References: <cover.1714606359.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 25/28] target/ppc/mmu_common.c: Simplify ppc_booke_xlate()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 02 May 2024 01:43:32 +0200 (CEST)
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

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 147 +++++++++++++++-------------------------
 1 file changed, 56 insertions(+), 91 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index d61c41d8c9..b76611da80 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -1261,106 +1261,71 @@ static bool ppc_booke_xlate(PowerPCCPU *cpu, vaddr eaddr,
     }
 
     log_cpu_state_mask(CPU_LOG_MMU, cs, 0);
+    env->error_code = 0;
+    if (env->mmu_model == POWERPC_MMU_BOOKE206 && ret == -1) {
+        booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
+    }
     if (access_type == MMU_INST_FETCH) {
-        switch (ret) {
-        case -1:
+        if (ret == -1) {
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
-            break;
-        case -2:
-            /* Access rights violation */
-            cs->exception_index = POWERPC_EXCP_ISI;
-            env->error_code = 0;
-            break;
-        case -3:
-            /* No execute protection violation */
-            cs->exception_index = POWERPC_EXCP_ISI;
-            env->spr[SPR_BOOKE_ESR] = 0;
-            env->error_code = 0;
-            break;
-        case -4:
-            /* Direct store exception */
-            /* No code fetch is allowed in direct-store areas */
+            cs->exception_index = POWERPC_EXCP_ITLB;
+            env->spr[SPR_BOOKE_DEAR] = eaddr;
+            env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
+        } else {
             cs->exception_index = POWERPC_EXCP_ISI;
-            env->error_code = 0;
-            break;
-        }
-    } else {
-        switch (ret) {
-        case -1:
-            /* No matches in page tables or TLB */
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
+            if (ret == -3) {
+                /* No execute protection violation */
+                env->spr[SPR_BOOKE_ESR] = 0;
             }
+        }
+        return false;
+    }
+
+    switch (ret) {
+    case -1:
+        /* No matches in page tables or TLB */
+        cs->exception_index = POWERPC_EXCP_DTLB;
+        env->spr[SPR_BOOKE_DEAR] = eaddr;
+        env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
+        break;
+    case -2:
+        /* Access rights violation */
+        cs->exception_index = POWERPC_EXCP_DSI;
+        env->spr[SPR_BOOKE_DEAR] = eaddr;
+        env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
+        break;
+    case -4:
+        /* Direct store exception */
+        env->spr[SPR_DAR] = eaddr;
+        switch (env->access_type) {
+        case ACCESS_FLOAT:
+            /* Floating point load/store */
+            cs->exception_index = POWERPC_EXCP_ALIGN;
+            env->error_code = POWERPC_EXCP_ALIGN_FP;
             break;
-        case -2:
-            /* Access rights violation */
+        case ACCESS_RES:
+            /* lwarx, ldarx or stwcx. */
             cs->exception_index = POWERPC_EXCP_DSI;
-            env->error_code = 0;
-            env->spr[SPR_BOOKE_DEAR] = eaddr;
-            env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
+            if (access_type == MMU_DATA_STORE) {
+                env->spr[SPR_DSISR] = 0x06000000;
+            } else {
+                env->spr[SPR_DSISR] = 0x04000000;
+            }
             break;
-        case -4:
-            /* Direct store exception */
-            switch (env->access_type) {
-            case ACCESS_FLOAT:
-                /* Floating point load/store */
-                cs->exception_index = POWERPC_EXCP_ALIGN;
-                env->error_code = POWERPC_EXCP_ALIGN_FP;
-                env->spr[SPR_DAR] = eaddr;
-                break;
-            case ACCESS_RES:
-                /* lwarx, ldarx or stwcx. */
-                cs->exception_index = POWERPC_EXCP_DSI;
-                env->error_code = 0;
-                env->spr[SPR_DAR] = eaddr;
-                if (access_type == MMU_DATA_STORE) {
-                    env->spr[SPR_DSISR] = 0x06000000;
-                } else {
-                    env->spr[SPR_DSISR] = 0x04000000;
-                }
-                break;
-            case ACCESS_EXT:
-                /* eciwx or ecowx */
-                cs->exception_index = POWERPC_EXCP_DSI;
-                env->error_code = 0;
-                env->spr[SPR_DAR] = eaddr;
-                if (access_type == MMU_DATA_STORE) {
-                    env->spr[SPR_DSISR] = 0x06100000;
-                } else {
-                    env->spr[SPR_DSISR] = 0x04100000;
-                }
-                break;
-            default:
-                printf("DSI: invalid exception (%d)\n", ret);
-                cs->exception_index = POWERPC_EXCP_PROGRAM;
-                env->error_code = POWERPC_EXCP_INVAL | POWERPC_EXCP_INVAL_INVAL;
-                env->spr[SPR_DAR] = eaddr;
-                break;
+        case ACCESS_EXT:
+            /* eciwx or ecowx */
+            cs->exception_index = POWERPC_EXCP_DSI;
+            if (access_type == MMU_DATA_STORE) {
+                env->spr[SPR_DSISR] = 0x06100000;
+            } else {
+                env->spr[SPR_DSISR] = 0x04100000;
             }
             break;
+        default:
+            printf("DSI: invalid exception (%d)\n", ret);
+            cs->exception_index = POWERPC_EXCP_PROGRAM;
+            env->error_code = POWERPC_EXCP_INVAL | POWERPC_EXCP_INVAL_INVAL;
+            break;
         }
     }
     return false;
-- 
2.30.9


