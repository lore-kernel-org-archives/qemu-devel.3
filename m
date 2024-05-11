Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF09C25B75
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 01:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5bpX-0006DF-NP; Fri, 10 May 2024 21:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5boU-00050N-9B; Fri, 10 May 2024 21:46:16 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5boR-0003aO-M7; Fri, 10 May 2024 21:46:13 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3E2D24E6775;
 Sat, 11 May 2024 03:46:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id RzH2bDQ6d2nV; Sat, 11 May 2024 03:46:06 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4C0724E6778; Sat, 11 May 2024 03:46:06 +0200 (CEST)
Message-Id: <cb7e9b62fa93635fcd0dc77f2c189a452758b2ff.1715390232.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715390232.git.balaton@eik.bme.hu>
References: <cover.1715390232.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v6 26/48] target/ppc/mmu_common.c: Split off 40x cases from
 ppc_jumbo_xlate()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Sat, 11 May 2024 03:46:06 +0200 (CEST)
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

Introduce ppc_40x_xlate() to split off 40x handlning leaving only 6xx
in ppc_jumbo_xlate() now.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 150 +++++++++++++++++++++++++---------------
 1 file changed, 93 insertions(+), 57 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 14d05d84e1..7829bd81ef 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -1218,6 +1218,74 @@ static bool ppc_real_mode_xlate(PowerPCCPU *cpu, vaddr eaddr,
     return false;
 }
 
+static bool ppc_40x_xlate(PowerPCCPU *cpu, vaddr eaddr,
+                          MMUAccessType access_type,
+                          hwaddr *raddrp, int *psizep, int *protp,
+                          int mmu_idx, bool guest_visible)
+{
+    CPUState *cs = CPU(cpu);
+    CPUPPCState *env = &cpu->env;
+    int ret;
+
+    if (ppc_real_mode_xlate(cpu, eaddr, access_type, raddrp, psizep, protp)) {
+        return true;
+    }
+
+    ret = mmu40x_get_physical_address(env, raddrp, protp, eaddr, access_type);
+    if (ret == 0) {
+        *psizep = TARGET_PAGE_BITS;
+        return true;
+    } else if (!guest_visible) {
+        return false;
+    }
+
+    log_cpu_state_mask(CPU_LOG_MMU, cs, 0);
+    if (access_type == MMU_INST_FETCH) {
+        switch (ret) {
+        case -1:
+            /* No matches in page tables or TLB */
+            cs->exception_index = POWERPC_EXCP_ITLB;
+            env->error_code = 0;
+            env->spr[SPR_40x_DEAR] = eaddr;
+            env->spr[SPR_40x_ESR] = 0x00000000;
+            break;
+        case -2:
+            /* Access rights violation */
+            cs->exception_index = POWERPC_EXCP_ISI;
+            env->error_code = 0x08000000;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    } else {
+        switch (ret) {
+        case -1:
+            /* No matches in page tables or TLB */
+            cs->exception_index = POWERPC_EXCP_DTLB;
+            env->error_code = 0;
+            env->spr[SPR_40x_DEAR] = eaddr;
+            if (access_type == MMU_DATA_STORE) {
+                env->spr[SPR_40x_ESR] = 0x00800000;
+            } else {
+                env->spr[SPR_40x_ESR] = 0x00000000;
+            }
+            break;
+        case -2:
+            /* Access rights violation */
+            cs->exception_index = POWERPC_EXCP_DSI;
+            env->error_code = 0;
+            env->spr[SPR_40x_DEAR] = eaddr;
+            if (access_type == MMU_DATA_STORE) {
+                env->spr[SPR_40x_ESR] |= 0x00800000;
+            }
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+    return false;
+}
+
 /* Perform address translation */
 /* TODO: Split this by mmu_model. */
 static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
@@ -1261,23 +1329,11 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
         switch (ret) {
         case -1:
             /* No matches in page tables or TLB */
-            switch (env->mmu_model) {
-            case POWERPC_MMU_SOFT_6xx:
-                cs->exception_index = POWERPC_EXCP_IFTLB;
-                env->error_code = 1 << 18;
-                env->spr[SPR_IMISS] = eaddr;
-                env->spr[SPR_ICMP] = 0x80000000 | ctx.ptem;
-                goto tlb_miss;
-            case POWERPC_MMU_SOFT_4xx:
-                cs->exception_index = POWERPC_EXCP_ITLB;
-                env->error_code = 0;
-                env->spr[SPR_40x_DEAR] = eaddr;
-                env->spr[SPR_40x_ESR] = 0x00000000;
-                break;
-            default:
-                g_assert_not_reached();
-            }
-            break;
+            cs->exception_index = POWERPC_EXCP_IFTLB;
+            env->error_code = 1 << 18;
+            env->spr[SPR_IMISS] = eaddr;
+            env->spr[SPR_ICMP] = 0x80000000 | ctx.ptem;
+            goto tlb_miss;
         case -2:
             /* Access rights violation */
             cs->exception_index = POWERPC_EXCP_ISI;
@@ -1299,54 +1355,31 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
         switch (ret) {
         case -1:
             /* No matches in page tables or TLB */
-            switch (env->mmu_model) {
-            case POWERPC_MMU_SOFT_6xx:
-                if (access_type == MMU_DATA_STORE) {
-                    cs->exception_index = POWERPC_EXCP_DSTLB;
-                    env->error_code = 1 << 16;
-                } else {
-                    cs->exception_index = POWERPC_EXCP_DLTLB;
-                    env->error_code = 0;
-                }
-                env->spr[SPR_DMISS] = eaddr;
-                env->spr[SPR_DCMP] = 0x80000000 | ctx.ptem;
-            tlb_miss:
-                env->error_code |= ctx.key << 19;
-                env->spr[SPR_HASH1] = ppc_hash32_hpt_base(cpu) +
-                  get_pteg_offset32(cpu, ctx.hash[0]);
-                env->spr[SPR_HASH2] = ppc_hash32_hpt_base(cpu) +
-                  get_pteg_offset32(cpu, ctx.hash[1]);
-                break;
-            case POWERPC_MMU_SOFT_4xx:
-                cs->exception_index = POWERPC_EXCP_DTLB;
+            if (access_type == MMU_DATA_STORE) {
+                cs->exception_index = POWERPC_EXCP_DSTLB;
+                env->error_code = 1 << 16;
+            } else {
+                cs->exception_index = POWERPC_EXCP_DLTLB;
                 env->error_code = 0;
-                env->spr[SPR_40x_DEAR] = eaddr;
-                if (access_type == MMU_DATA_STORE) {
-                    env->spr[SPR_40x_ESR] = 0x00800000;
-                } else {
-                    env->spr[SPR_40x_ESR] = 0x00000000;
-                }
-                break;
-            default:
-                g_assert_not_reached();
             }
+            env->spr[SPR_DMISS] = eaddr;
+            env->spr[SPR_DCMP] = 0x80000000 | ctx.ptem;
+tlb_miss:
+            env->error_code |= ctx.key << 19;
+            env->spr[SPR_HASH1] = ppc_hash32_hpt_base(cpu) +
+                                  get_pteg_offset32(cpu, ctx.hash[0]);
+            env->spr[SPR_HASH2] = ppc_hash32_hpt_base(cpu) +
+                                  get_pteg_offset32(cpu, ctx.hash[1]);
             break;
         case -2:
             /* Access rights violation */
             cs->exception_index = POWERPC_EXCP_DSI;
             env->error_code = 0;
-            if (env->mmu_model == POWERPC_MMU_SOFT_4xx) {
-                env->spr[SPR_40x_DEAR] = eaddr;
-                if (access_type == MMU_DATA_STORE) {
-                    env->spr[SPR_40x_ESR] |= 0x00800000;
-                }
+            env->spr[SPR_DAR] = eaddr;
+            if (access_type == MMU_DATA_STORE) {
+                env->spr[SPR_DSISR] = 0x0A000000;
             } else {
-                env->spr[SPR_DAR] = eaddr;
-                if (access_type == MMU_DATA_STORE) {
-                    env->spr[SPR_DSISR] = 0x0A000000;
-                } else {
-                    env->spr[SPR_DSISR] = 0x08000000;
-                }
+                env->spr[SPR_DSISR] = 0x08000000;
             }
             break;
         case -4:
@@ -1422,6 +1455,9 @@ bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     case POWERPC_MMU_BOOKE206:
         return ppc_booke_xlate(cpu, eaddr, access_type, raddrp,
                                psizep, protp, mmu_idx, guest_visible);
+    case POWERPC_MMU_SOFT_4xx:
+        return ppc_40x_xlate(cpu, eaddr, access_type, raddrp,
+                             psizep, protp, mmu_idx, guest_visible);
     case POWERPC_MMU_REAL:
         return ppc_real_mode_xlate(cpu, eaddr, access_type, raddrp, psizep,
                                    protp);
-- 
2.30.9


