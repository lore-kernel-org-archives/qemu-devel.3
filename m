Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E3FC10F1A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 23:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2JcM-0002xI-KF; Wed, 01 May 2024 19:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s2JcF-0002oU-Rf; Wed, 01 May 2024 19:44:00 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s2JcC-00054D-KM; Wed, 01 May 2024 19:43:58 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 169AB4E6040;
 Thu, 02 May 2024 01:43:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id UHQr-fxQ_NX7; Thu,  2 May 2024 01:43:33 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 232204E603A; Thu, 02 May 2024 01:43:33 +0200 (CEST)
Message-Id: <d5d70791bdf598cd28ee70fd058f51c257a2b969.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1714606359.git.balaton@eik.bme.hu>
References: <cover.1714606359.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 26/28] target/ppc/mmu_common.c: Move BookE MMU functions
 together
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 02 May 2024 01:43:33 +0200 (CEST)
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
 target/ppc/mmu_common.c | 300 ++++++++++++++++++++--------------------
 1 file changed, 150 insertions(+), 150 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index b76611da80..204b8af455 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -910,6 +910,156 @@ found_tlb:
     return ret;
 }
 
+static void booke206_update_mas_tlb_miss(CPUPPCState *env, target_ulong address,
+                                         MMUAccessType access_type, int mmu_idx)
+{
+    uint32_t epid;
+    bool as, pr;
+    uint32_t missed_tid = 0;
+    bool use_epid = mmubooke206_get_as(env, mmu_idx, &epid, &as, &pr);
+
+    if (access_type == MMU_INST_FETCH) {
+        as = FIELD_EX64(env->msr, MSR, IR);
+    }
+    env->spr[SPR_BOOKE_MAS0] = env->spr[SPR_BOOKE_MAS4] & MAS4_TLBSELD_MASK;
+    env->spr[SPR_BOOKE_MAS1] = env->spr[SPR_BOOKE_MAS4] & MAS4_TSIZED_MASK;
+    env->spr[SPR_BOOKE_MAS2] = env->spr[SPR_BOOKE_MAS4] & MAS4_WIMGED_MASK;
+    env->spr[SPR_BOOKE_MAS3] = 0;
+    env->spr[SPR_BOOKE_MAS6] = 0;
+    env->spr[SPR_BOOKE_MAS7] = 0;
+
+    /* AS */
+    if (as) {
+        env->spr[SPR_BOOKE_MAS1] |= MAS1_TS;
+        env->spr[SPR_BOOKE_MAS6] |= MAS6_SAS;
+    }
+
+    env->spr[SPR_BOOKE_MAS1] |= MAS1_VALID;
+    env->spr[SPR_BOOKE_MAS2] |= address & MAS2_EPN_MASK;
+
+    if (!use_epid) {
+        switch (env->spr[SPR_BOOKE_MAS4] & MAS4_TIDSELD_PIDZ) {
+        case MAS4_TIDSELD_PID0:
+            missed_tid = env->spr[SPR_BOOKE_PID];
+            break;
+        case MAS4_TIDSELD_PID1:
+            missed_tid = env->spr[SPR_BOOKE_PID1];
+            break;
+        case MAS4_TIDSELD_PID2:
+            missed_tid = env->spr[SPR_BOOKE_PID2];
+            break;
+        }
+        env->spr[SPR_BOOKE_MAS6] |= env->spr[SPR_BOOKE_PID] << 16;
+    } else {
+        missed_tid = epid;
+        env->spr[SPR_BOOKE_MAS6] |= missed_tid << 16;
+    }
+    env->spr[SPR_BOOKE_MAS1] |= (missed_tid << MAS1_TID_SHIFT);
+
+
+    /* next victim logic */
+    env->spr[SPR_BOOKE_MAS0] |= env->last_way << MAS0_ESEL_SHIFT;
+    env->last_way++;
+    env->last_way &= booke206_tlb_ways(env, 0) - 1;
+    env->spr[SPR_BOOKE_MAS0] |= env->last_way << MAS0_NV_SHIFT;
+}
+
+static bool ppc_booke_xlate(PowerPCCPU *cpu, vaddr eaddr,
+                            MMUAccessType access_type,
+                            hwaddr *raddrp, int *psizep, int *protp,
+                            int mmu_idx, bool guest_visible)
+{
+    CPUState *cs = CPU(cpu);
+    CPUPPCState *env = &cpu->env;
+    mmu_ctx_t ctx;
+    int ret;
+
+    if (env->mmu_model == POWERPC_MMU_BOOKE206) {
+        ret = mmubooke206_get_physical_address(env, &ctx, eaddr, access_type,
+                                               mmu_idx);
+    } else {
+        ret = mmubooke_get_physical_address(env, &ctx, eaddr, access_type);
+    }
+    if (ret == 0) {
+        *raddrp = ctx.raddr;
+        *protp = ctx.prot;
+        *psizep = TARGET_PAGE_BITS;
+        return true;
+    } else if (!guest_visible) {
+        return false;
+    }
+
+    log_cpu_state_mask(CPU_LOG_MMU, cs, 0);
+    env->error_code = 0;
+    if (env->mmu_model == POWERPC_MMU_BOOKE206 && ret == -1) {
+        booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
+    }
+    if (access_type == MMU_INST_FETCH) {
+        if (ret == -1) {
+            /* No matches in page tables or TLB */
+            cs->exception_index = POWERPC_EXCP_ITLB;
+            env->spr[SPR_BOOKE_DEAR] = eaddr;
+            env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
+        } else {
+            cs->exception_index = POWERPC_EXCP_ISI;
+            if (ret == -3) {
+                /* No execute protection violation */
+                env->spr[SPR_BOOKE_ESR] = 0;
+            }
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
+            break;
+        case ACCESS_RES:
+            /* lwarx, ldarx or stwcx. */
+            cs->exception_index = POWERPC_EXCP_DSI;
+            if (access_type == MMU_DATA_STORE) {
+                env->spr[SPR_DSISR] = 0x06000000;
+            } else {
+                env->spr[SPR_DSISR] = 0x04000000;
+            }
+            break;
+        case ACCESS_EXT:
+            /* eciwx or ecowx */
+            cs->exception_index = POWERPC_EXCP_DSI;
+            if (access_type == MMU_DATA_STORE) {
+                env->spr[SPR_DSISR] = 0x06100000;
+            } else {
+                env->spr[SPR_DSISR] = 0x04100000;
+            }
+            break;
+        default:
+            printf("DSI: invalid exception (%d)\n", ret);
+            cs->exception_index = POWERPC_EXCP_PROGRAM;
+            env->error_code = POWERPC_EXCP_INVAL | POWERPC_EXCP_INVAL_INVAL;
+            break;
+        }
+    }
+    return false;
+}
+
 static const char *book3e_tsize_to_str[32] = {
     "1K", "2K", "4K", "8K", "16K", "32K", "64K", "128K", "256K", "512K",
     "1M", "2M", "4M", "8M", "16M", "32M", "64M", "128M", "256M", "512M",
@@ -1181,156 +1331,6 @@ static int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
     }
 }
 
-static void booke206_update_mas_tlb_miss(CPUPPCState *env, target_ulong address,
-                                         MMUAccessType access_type, int mmu_idx)
-{
-    uint32_t epid;
-    bool as, pr;
-    uint32_t missed_tid = 0;
-    bool use_epid = mmubooke206_get_as(env, mmu_idx, &epid, &as, &pr);
-
-    if (access_type == MMU_INST_FETCH) {
-        as = FIELD_EX64(env->msr, MSR, IR);
-    }
-    env->spr[SPR_BOOKE_MAS0] = env->spr[SPR_BOOKE_MAS4] & MAS4_TLBSELD_MASK;
-    env->spr[SPR_BOOKE_MAS1] = env->spr[SPR_BOOKE_MAS4] & MAS4_TSIZED_MASK;
-    env->spr[SPR_BOOKE_MAS2] = env->spr[SPR_BOOKE_MAS4] & MAS4_WIMGED_MASK;
-    env->spr[SPR_BOOKE_MAS3] = 0;
-    env->spr[SPR_BOOKE_MAS6] = 0;
-    env->spr[SPR_BOOKE_MAS7] = 0;
-
-    /* AS */
-    if (as) {
-        env->spr[SPR_BOOKE_MAS1] |= MAS1_TS;
-        env->spr[SPR_BOOKE_MAS6] |= MAS6_SAS;
-    }
-
-    env->spr[SPR_BOOKE_MAS1] |= MAS1_VALID;
-    env->spr[SPR_BOOKE_MAS2] |= address & MAS2_EPN_MASK;
-
-    if (!use_epid) {
-        switch (env->spr[SPR_BOOKE_MAS4] & MAS4_TIDSELD_PIDZ) {
-        case MAS4_TIDSELD_PID0:
-            missed_tid = env->spr[SPR_BOOKE_PID];
-            break;
-        case MAS4_TIDSELD_PID1:
-            missed_tid = env->spr[SPR_BOOKE_PID1];
-            break;
-        case MAS4_TIDSELD_PID2:
-            missed_tid = env->spr[SPR_BOOKE_PID2];
-            break;
-        }
-        env->spr[SPR_BOOKE_MAS6] |= env->spr[SPR_BOOKE_PID] << 16;
-    } else {
-        missed_tid = epid;
-        env->spr[SPR_BOOKE_MAS6] |= missed_tid << 16;
-    }
-    env->spr[SPR_BOOKE_MAS1] |= (missed_tid << MAS1_TID_SHIFT);
-
-
-    /* next victim logic */
-    env->spr[SPR_BOOKE_MAS0] |= env->last_way << MAS0_ESEL_SHIFT;
-    env->last_way++;
-    env->last_way &= booke206_tlb_ways(env, 0) - 1;
-    env->spr[SPR_BOOKE_MAS0] |= env->last_way << MAS0_NV_SHIFT;
-}
-
-static bool ppc_booke_xlate(PowerPCCPU *cpu, vaddr eaddr,
-                            MMUAccessType access_type,
-                            hwaddr *raddrp, int *psizep, int *protp,
-                            int mmu_idx, bool guest_visible)
-{
-    CPUState *cs = CPU(cpu);
-    CPUPPCState *env = &cpu->env;
-    mmu_ctx_t ctx;
-    int ret;
-
-    if (env->mmu_model == POWERPC_MMU_BOOKE206) {
-        ret = mmubooke206_get_physical_address(env, &ctx, eaddr, access_type,
-                                               mmu_idx);
-    } else {
-        ret = mmubooke_get_physical_address(env, &ctx, eaddr, access_type);
-    }
-    if (ret == 0) {
-        *raddrp = ctx.raddr;
-        *protp = ctx.prot;
-        *psizep = TARGET_PAGE_BITS;
-        return true;
-    } else if (!guest_visible) {
-        return false;
-    }
-
-    log_cpu_state_mask(CPU_LOG_MMU, cs, 0);
-    env->error_code = 0;
-    if (env->mmu_model == POWERPC_MMU_BOOKE206 && ret == -1) {
-        booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
-    }
-    if (access_type == MMU_INST_FETCH) {
-        if (ret == -1) {
-            /* No matches in page tables or TLB */
-            cs->exception_index = POWERPC_EXCP_ITLB;
-            env->spr[SPR_BOOKE_DEAR] = eaddr;
-            env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
-        } else {
-            cs->exception_index = POWERPC_EXCP_ISI;
-            if (ret == -3) {
-                /* No execute protection violation */
-                env->spr[SPR_BOOKE_ESR] = 0;
-            }
-        }
-        return false;
-    }
-
-    switch (ret) {
-    case -1:
-        /* No matches in page tables or TLB */
-        cs->exception_index = POWERPC_EXCP_DTLB;
-        env->spr[SPR_BOOKE_DEAR] = eaddr;
-        env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
-        break;
-    case -2:
-        /* Access rights violation */
-        cs->exception_index = POWERPC_EXCP_DSI;
-        env->spr[SPR_BOOKE_DEAR] = eaddr;
-        env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
-        break;
-    case -4:
-        /* Direct store exception */
-        env->spr[SPR_DAR] = eaddr;
-        switch (env->access_type) {
-        case ACCESS_FLOAT:
-            /* Floating point load/store */
-            cs->exception_index = POWERPC_EXCP_ALIGN;
-            env->error_code = POWERPC_EXCP_ALIGN_FP;
-            break;
-        case ACCESS_RES:
-            /* lwarx, ldarx or stwcx. */
-            cs->exception_index = POWERPC_EXCP_DSI;
-            if (access_type == MMU_DATA_STORE) {
-                env->spr[SPR_DSISR] = 0x06000000;
-            } else {
-                env->spr[SPR_DSISR] = 0x04000000;
-            }
-            break;
-        case ACCESS_EXT:
-            /* eciwx or ecowx */
-            cs->exception_index = POWERPC_EXCP_DSI;
-            if (access_type == MMU_DATA_STORE) {
-                env->spr[SPR_DSISR] = 0x06100000;
-            } else {
-                env->spr[SPR_DSISR] = 0x04100000;
-            }
-            break;
-        default:
-            printf("DSI: invalid exception (%d)\n", ret);
-            cs->exception_index = POWERPC_EXCP_PROGRAM;
-            env->error_code = POWERPC_EXCP_INVAL | POWERPC_EXCP_INVAL_INVAL;
-            break;
-        }
-    }
-    return false;
-}
-
 /* Perform address translation */
 /* TODO: Split this by mmu_model. */
 static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
-- 
2.30.9


