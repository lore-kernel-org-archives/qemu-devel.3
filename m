Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E6CC25B10
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 01:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5bpo-000876-CN; Fri, 10 May 2024 21:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5bp4-0005Ia-AB; Fri, 10 May 2024 21:46:51 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5bot-0003d9-KN; Fri, 10 May 2024 21:46:49 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2100A4E6785;
 Sat, 11 May 2024 03:46:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id IM-jAP9avWS3; Sat, 11 May 2024 03:46:15 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B95144E6782; Sat, 11 May 2024 03:46:15 +0200 (CEST)
Message-Id: <f7a4eb96fb35c3cac701ba6805389a30fd9de16a.1715390232.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715390232.git.balaton@eik.bme.hu>
References: <cover.1715390232.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v6 35/48] target/ppc: Move out BookE and related MMU functions
 from mmu_common.c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Sat, 11 May 2024 03:46:15 +0200 (CEST)
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

Add a new mmu-booke.c file for BookE and related MMU bits from
mmu_common.c.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h        |   4 -
 target/ppc/meson.build  |   1 +
 target/ppc/mmu-booke.c  | 531 ++++++++++++++++++++++++++++++++++++++++
 target/ppc/mmu-booke.h  |  17 ++
 target/ppc/mmu_common.c | 507 +-------------------------------------
 target/ppc/mmu_helper.c |   1 +
 6 files changed, 551 insertions(+), 510 deletions(-)
 create mode 100644 target/ppc/mmu-booke.c
 create mode 100644 target/ppc/mmu-booke.h

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index cfb3ba5ac8..92b50a1be2 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1606,10 +1606,6 @@ void ppc_tlb_invalidate_all(CPUPPCState *env);
 void ppc_tlb_invalidate_one(CPUPPCState *env, target_ulong addr);
 void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp);
 void cpu_ppc_set_1lpar(PowerPCCPU *cpu);
-int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb, hwaddr *raddrp,
-                     target_ulong address, uint32_t pid);
-int ppcemb_tlb_search(CPUPPCState *env, target_ulong address, uint32_t pid);
-hwaddr booke206_tlb_to_page_size(CPUPPCState *env, ppcmas_tlb_t *tlb);
 #endif
 
 void ppc_store_fpscr(CPUPPCState *env, target_ulong val);
diff --git a/target/ppc/meson.build b/target/ppc/meson.build
index 0b89f9b89f..db3b7a0c33 100644
--- a/target/ppc/meson.build
+++ b/target/ppc/meson.build
@@ -37,6 +37,7 @@ ppc_system_ss.add(files(
   'arch_dump.c',
   'machine.c',
   'mmu-hash32.c',
+  'mmu-booke.c',
   'mmu_common.c',
   'ppc-qmp-cmds.c',
 ))
diff --git a/target/ppc/mmu-booke.c b/target/ppc/mmu-booke.c
new file mode 100644
index 0000000000..55e5dd7c6b
--- /dev/null
+++ b/target/ppc/mmu-booke.c
@@ -0,0 +1,531 @@
+/*
+ *  PowerPC BookE MMU, TLB emulation helpers for QEMU.
+ *
+ *  Copyright (c) 2003-2007 Jocelyn Mayer
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "exec/page-protection.h"
+#include "exec/log.h"
+#include "cpu.h"
+#include "internal.h"
+#include "mmu-booke.h"
+
+/* Generic TLB check function for embedded PowerPC implementations */
+static bool ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
+                             hwaddr *raddrp,
+                             target_ulong address, uint32_t pid, int i)
+{
+    target_ulong mask;
+
+    /* Check valid flag */
+    if (!(tlb->prot & PAGE_VALID)) {
+        return false;
+    }
+    mask = ~(tlb->size - 1);
+    qemu_log_mask(CPU_LOG_MMU, "%s: TLB %d address " TARGET_FMT_lx
+                  " PID %u <=> " TARGET_FMT_lx " " TARGET_FMT_lx " %u %x\n",
+                  __func__, i, address, pid, tlb->EPN,
+                  mask, (uint32_t)tlb->PID, tlb->prot);
+    /* Check PID */
+    if (tlb->PID != 0 && tlb->PID != pid) {
+        return false;
+    }
+    /* Check effective address */
+    if ((address & mask) != tlb->EPN) {
+        return false;
+    }
+    *raddrp = (tlb->RPN & mask) | (address & ~mask);
+    return true;
+}
+
+/* Generic TLB search function for PowerPC embedded implementations */
+int ppcemb_tlb_search(CPUPPCState *env, target_ulong address, uint32_t pid)
+{
+    ppcemb_tlb_t *tlb;
+    hwaddr raddr;
+    int i;
+
+    for (i = 0; i < env->nb_tlb; i++) {
+        tlb = &env->tlb.tlbe[i];
+        if (ppcemb_tlb_check(env, tlb, &raddr, address, pid, i)) {
+            return i;
+        }
+    }
+    return -1;
+}
+
+int mmu40x_get_physical_address(CPUPPCState *env, hwaddr *raddr, int *prot,
+                                target_ulong address,
+                                MMUAccessType access_type)
+{
+    ppcemb_tlb_t *tlb;
+    int i, ret, zsel, zpr, pr;
+
+    ret = -1;
+    pr = FIELD_EX64(env->msr, MSR, PR);
+    for (i = 0; i < env->nb_tlb; i++) {
+        tlb = &env->tlb.tlbe[i];
+        if (!ppcemb_tlb_check(env, tlb, raddr, address,
+                              env->spr[SPR_40x_PID], i)) {
+            continue;
+        }
+        zsel = (tlb->attr >> 4) & 0xF;
+        zpr = (env->spr[SPR_40x_ZPR] >> (30 - (2 * zsel))) & 0x3;
+        qemu_log_mask(CPU_LOG_MMU,
+                      "%s: TLB %d zsel %d zpr %d ty %d attr %08x\n",
+                      __func__, i, zsel, zpr, access_type, tlb->attr);
+        /* Check execute enable bit */
+        switch (zpr) {
+        case 0x2:
+            if (pr != 0) {
+                goto check_perms;
+            }
+            /* fall through */
+        case 0x3:
+            /* All accesses granted */
+            *prot = PAGE_RWX;
+            ret = 0;
+            break;
+
+        case 0x0:
+            if (pr != 0) {
+                /* Raise Zone protection fault.  */
+                env->spr[SPR_40x_ESR] = 1 << 22;
+                *prot = 0;
+                ret = -2;
+                break;
+            }
+            /* fall through */
+        case 0x1:
+check_perms:
+            /* Check from TLB entry */
+            *prot = tlb->prot;
+            if (check_prot_access_type(*prot, access_type)) {
+                ret = 0;
+            } else {
+                env->spr[SPR_40x_ESR] = 0;
+                ret = -2;
+            }
+            break;
+        }
+    }
+    qemu_log_mask(CPU_LOG_MMU, "%s: access %s " TARGET_FMT_lx " => "
+                  HWADDR_FMT_plx " %d %d\n",  __func__,
+                  ret < 0 ? "refused" : "granted", address,
+                  ret < 0 ? 0 : *raddr, *prot, ret);
+
+    return ret;
+}
+
+static bool mmubooke_check_pid(CPUPPCState *env, ppcemb_tlb_t *tlb,
+                               hwaddr *raddr, target_ulong addr, int i)
+{
+    if (ppcemb_tlb_check(env, tlb, raddr, addr, env->spr[SPR_BOOKE_PID], i)) {
+        if (!env->nb_pids) {
+            /* Extend the physical address to 36 bits */
+            *raddr |= (uint64_t)(tlb->RPN & 0xF) << 32;
+        }
+        return true;
+    } else if (!env->nb_pids) {
+        return false;
+    }
+    if (env->spr[SPR_BOOKE_PID1] &&
+        ppcemb_tlb_check(env, tlb, raddr, addr, env->spr[SPR_BOOKE_PID1], i)) {
+        return true;
+    }
+    if (env->spr[SPR_BOOKE_PID2] &&
+        ppcemb_tlb_check(env, tlb, raddr, addr, env->spr[SPR_BOOKE_PID2], i)) {
+        return true;
+    }
+    return false;
+}
+
+static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
+                              hwaddr *raddr, int *prot, target_ulong address,
+                              MMUAccessType access_type, int i)
+{
+    if (!mmubooke_check_pid(env, tlb, raddr, address, i)) {
+        qemu_log_mask(CPU_LOG_MMU, "%s: TLB entry not found\n", __func__);
+        return -1;
+    }
+
+    /* Check the address space */
+    if ((access_type == MMU_INST_FETCH ?
+        FIELD_EX64(env->msr, MSR, IR) :
+        FIELD_EX64(env->msr, MSR, DR)) != (tlb->attr & 1)) {
+        qemu_log_mask(CPU_LOG_MMU, "%s: AS doesn't match\n", __func__);
+        return -1;
+    }
+
+    if (FIELD_EX64(env->msr, MSR, PR)) {
+        *prot = tlb->prot & 0xF;
+    } else {
+        *prot = (tlb->prot >> 4) & 0xF;
+    }
+    if (check_prot_access_type(*prot, access_type)) {
+        qemu_log_mask(CPU_LOG_MMU, "%s: good TLB!\n", __func__);
+        return 0;
+    }
+
+    qemu_log_mask(CPU_LOG_MMU, "%s: no prot match: %x\n", __func__, *prot);
+    return access_type == MMU_INST_FETCH ? -3 : -2;
+}
+
+static int mmubooke_get_physical_address(CPUPPCState *env, hwaddr *raddr,
+                                         int *prot, target_ulong address,
+                                         MMUAccessType access_type)
+{
+    ppcemb_tlb_t *tlb;
+    int i, ret = -1;
+
+    for (i = 0; i < env->nb_tlb; i++) {
+        tlb = &env->tlb.tlbe[i];
+        ret = mmubooke_check_tlb(env, tlb, raddr, prot, address,
+                                 access_type, i);
+        if (ret != -1) {
+            break;
+        }
+    }
+    qemu_log_mask(CPU_LOG_MMU,
+                  "%s: access %s " TARGET_FMT_lx " => " HWADDR_FMT_plx
+                  " %d %d\n", __func__, ret < 0 ? "refused" : "granted",
+                  address, ret < 0 ? -1 : *raddr, ret == -1 ? 0 : *prot, ret);
+    return ret;
+}
+
+hwaddr booke206_tlb_to_page_size(CPUPPCState *env, ppcmas_tlb_t *tlb)
+{
+    int tlbm_size;
+
+    tlbm_size = (tlb->mas1 & MAS1_TSIZE_MASK) >> MAS1_TSIZE_SHIFT;
+
+    return 1024ULL << tlbm_size;
+}
+
+/* TLB check function for MAS based SoftTLBs */
+int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb, hwaddr *raddrp,
+                     target_ulong address, uint32_t pid)
+{
+    hwaddr mask;
+    uint32_t tlb_pid;
+
+    if (!FIELD_EX64(env->msr, MSR, CM)) {
+        /* In 32bit mode we can only address 32bit EAs */
+        address = (uint32_t)address;
+    }
+
+    /* Check valid flag */
+    if (!(tlb->mas1 & MAS1_VALID)) {
+        return -1;
+    }
+
+    mask = ~(booke206_tlb_to_page_size(env, tlb) - 1);
+    qemu_log_mask(CPU_LOG_MMU, "%s: TLB ADDR=0x" TARGET_FMT_lx
+                  " PID=0x%x MAS1=0x%x MAS2=0x%" PRIx64 " mask=0x%"
+                  HWADDR_PRIx " MAS7_3=0x%" PRIx64 " MAS8=0x%" PRIx32 "\n",
+                  __func__, address, pid, tlb->mas1, tlb->mas2, mask,
+                  tlb->mas7_3, tlb->mas8);
+
+    /* Check PID */
+    tlb_pid = (tlb->mas1 & MAS1_TID_MASK) >> MAS1_TID_SHIFT;
+    if (tlb_pid != 0 && tlb_pid != pid) {
+        return -1;
+    }
+
+    /* Check effective address */
+    if ((address & mask) != (tlb->mas2 & MAS2_EPN_MASK)) {
+        return -1;
+    }
+
+    if (raddrp) {
+        *raddrp = (tlb->mas7_3 & mask) | (address & ~mask);
+    }
+
+    return 0;
+}
+
+static bool is_epid_mmu(int mmu_idx)
+{
+    return mmu_idx == PPC_TLB_EPID_STORE || mmu_idx == PPC_TLB_EPID_LOAD;
+}
+
+static uint32_t mmubooke206_esr(int mmu_idx, MMUAccessType access_type)
+{
+    uint32_t esr = 0;
+    if (access_type == MMU_DATA_STORE) {
+        esr |= ESR_ST;
+    }
+    if (is_epid_mmu(mmu_idx)) {
+        esr |= ESR_EPID;
+    }
+    return esr;
+}
+
+/*
+ * Get EPID register given the mmu_idx. If this is regular load,
+ * construct the EPID access bits from current processor state
+ *
+ * Get the effective AS and PR bits and the PID. The PID is returned
+ * only if EPID load is requested, otherwise the caller must detect
+ * the correct EPID.  Return true if valid EPID is returned.
+ */
+static bool mmubooke206_get_as(CPUPPCState *env,
+                               int mmu_idx, uint32_t *epid_out,
+                               bool *as_out, bool *pr_out)
+{
+    if (is_epid_mmu(mmu_idx)) {
+        uint32_t epidr;
+        if (mmu_idx == PPC_TLB_EPID_STORE) {
+            epidr = env->spr[SPR_BOOKE_EPSC];
+        } else {
+            epidr = env->spr[SPR_BOOKE_EPLC];
+        }
+        *epid_out = (epidr & EPID_EPID) >> EPID_EPID_SHIFT;
+        *as_out = !!(epidr & EPID_EAS);
+        *pr_out = !!(epidr & EPID_EPR);
+        return true;
+    } else {
+        *as_out = FIELD_EX64(env->msr, MSR, DS);
+        *pr_out = FIELD_EX64(env->msr, MSR, PR);
+        return false;
+    }
+}
+
+/* Check if the tlb found by hashing really matches */
+static int mmubooke206_check_tlb(CPUPPCState *env, ppcmas_tlb_t *tlb,
+                                 hwaddr *raddr, int *prot,
+                                 target_ulong address,
+                                 MMUAccessType access_type, int mmu_idx)
+{
+    uint32_t epid;
+    bool as, pr;
+    bool use_epid = mmubooke206_get_as(env, mmu_idx, &epid, &as, &pr);
+
+    if (!use_epid) {
+        if (ppcmas_tlb_check(env, tlb, raddr, address,
+                             env->spr[SPR_BOOKE_PID]) >= 0) {
+            goto found_tlb;
+        }
+
+        if (env->spr[SPR_BOOKE_PID1] &&
+            ppcmas_tlb_check(env, tlb, raddr, address,
+                             env->spr[SPR_BOOKE_PID1]) >= 0) {
+            goto found_tlb;
+        }
+
+        if (env->spr[SPR_BOOKE_PID2] &&
+            ppcmas_tlb_check(env, tlb, raddr, address,
+                             env->spr[SPR_BOOKE_PID2]) >= 0) {
+            goto found_tlb;
+        }
+    } else {
+        if (ppcmas_tlb_check(env, tlb, raddr, address, epid) >= 0) {
+            goto found_tlb;
+        }
+    }
+
+    qemu_log_mask(CPU_LOG_MMU, "%s: No TLB entry found for effective address "
+                  "0x" TARGET_FMT_lx "\n", __func__, address);
+    return -1;
+
+found_tlb:
+
+    /* Check the address space and permissions */
+    if (access_type == MMU_INST_FETCH) {
+        /* There is no way to fetch code using epid load */
+        assert(!use_epid);
+        as = FIELD_EX64(env->msr, MSR, IR);
+    }
+
+    if (as != ((tlb->mas1 & MAS1_TS) >> MAS1_TS_SHIFT)) {
+        qemu_log_mask(CPU_LOG_MMU, "%s: AS doesn't match\n", __func__);
+        return -1;
+    }
+
+    *prot = 0;
+    if (pr) {
+        if (tlb->mas7_3 & MAS3_UR) {
+            *prot |= PAGE_READ;
+        }
+        if (tlb->mas7_3 & MAS3_UW) {
+            *prot |= PAGE_WRITE;
+        }
+        if (tlb->mas7_3 & MAS3_UX) {
+            *prot |= PAGE_EXEC;
+        }
+    } else {
+        if (tlb->mas7_3 & MAS3_SR) {
+            *prot |= PAGE_READ;
+        }
+        if (tlb->mas7_3 & MAS3_SW) {
+            *prot |= PAGE_WRITE;
+        }
+        if (tlb->mas7_3 & MAS3_SX) {
+            *prot |= PAGE_EXEC;
+        }
+    }
+    if (check_prot_access_type(*prot, access_type)) {
+        qemu_log_mask(CPU_LOG_MMU, "%s: good TLB!\n", __func__);
+        return 0;
+    }
+
+    qemu_log_mask(CPU_LOG_MMU, "%s: no prot match: %x\n", __func__, *prot);
+    return access_type == MMU_INST_FETCH ? -3 : -2;
+}
+
+static int mmubooke206_get_physical_address(CPUPPCState *env, hwaddr *raddr,
+                                            int *prot, target_ulong address,
+                                            MMUAccessType access_type,
+                                            int mmu_idx)
+{
+    ppcmas_tlb_t *tlb;
+    int i, j, ret = -1;
+
+    for (i = 0; i < BOOKE206_MAX_TLBN; i++) {
+        int ways = booke206_tlb_ways(env, i);
+        for (j = 0; j < ways; j++) {
+            tlb = booke206_get_tlbm(env, i, address, j);
+            if (!tlb) {
+                continue;
+            }
+            ret = mmubooke206_check_tlb(env, tlb, raddr, prot, address,
+                                        access_type, mmu_idx);
+            if (ret != -1) {
+                goto found_tlb;
+            }
+        }
+    }
+
+found_tlb:
+
+    qemu_log_mask(CPU_LOG_MMU, "%s: access %s " TARGET_FMT_lx " => "
+                  HWADDR_FMT_plx " %d %d\n", __func__,
+                  ret < 0 ? "refused" : "granted", address,
+                  ret < 0 ? -1 : *raddr, ret == -1 ? 0 : *prot, ret);
+    return ret;
+}
+
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
+bool ppc_booke_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
+                     hwaddr *raddrp, int *psizep, int *protp, int mmu_idx,
+                     bool guest_visible)
+{
+    CPUState *cs = CPU(cpu);
+    CPUPPCState *env = &cpu->env;
+    hwaddr raddr;
+    int prot, ret;
+
+    if (env->mmu_model == POWERPC_MMU_BOOKE206) {
+        ret = mmubooke206_get_physical_address(env, &raddr, &prot, eaddr,
+                                               access_type, mmu_idx);
+    } else {
+        ret = mmubooke_get_physical_address(env, &raddr, &prot, eaddr,
+                                            access_type);
+    }
+    if (ret == 0) {
+        *raddrp = raddr;
+        *protp = prot;
+        *psizep = TARGET_PAGE_BITS;
+        return true;
+    } else if (!guest_visible) {
+        return false;
+    }
+
+    log_cpu_state_mask(CPU_LOG_MMU, cs, 0);
+    env->error_code = 0;
+    switch (ret) {
+    case -1:
+        /* No matches in page tables or TLB */
+        if (env->mmu_model == POWERPC_MMU_BOOKE206) {
+            booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
+        }
+        cs->exception_index = (access_type == MMU_INST_FETCH) ?
+                              POWERPC_EXCP_ITLB : POWERPC_EXCP_DTLB;
+        env->spr[SPR_BOOKE_DEAR] = eaddr;
+        env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
+        break;
+    case -2:
+        /* Access rights violation */
+        cs->exception_index = (access_type == MMU_INST_FETCH) ?
+                              POWERPC_EXCP_ISI : POWERPC_EXCP_DSI;
+        if (access_type != MMU_INST_FETCH) {
+            env->spr[SPR_BOOKE_DEAR] = eaddr;
+            env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
+        }
+        break;
+    case -3:
+        /* No execute protection violation */
+        cs->exception_index = POWERPC_EXCP_ISI;
+        env->spr[SPR_BOOKE_ESR] = 0;
+        break;
+    }
+
+    return false;
+}
diff --git a/target/ppc/mmu-booke.h b/target/ppc/mmu-booke.h
new file mode 100644
index 0000000000..f972843bbb
--- /dev/null
+++ b/target/ppc/mmu-booke.h
@@ -0,0 +1,17 @@
+#ifndef PPC_MMU_BOOKE_H
+#define PPC_MMU_BOOKE_H
+
+#include "cpu.h"
+
+int ppcemb_tlb_search(CPUPPCState *env, target_ulong address, uint32_t pid);
+int mmu40x_get_physical_address(CPUPPCState *env, hwaddr *raddr, int *prot,
+                                target_ulong address,
+                                MMUAccessType access_type);
+hwaddr booke206_tlb_to_page_size(CPUPPCState *env, ppcmas_tlb_t *tlb);
+int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb, hwaddr *raddrp,
+                     target_ulong address, uint32_t pid);
+bool ppc_booke_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
+                     hwaddr *raddrp, int *psizep, int *protp, int mmu_idx,
+                     bool guest_visible);
+
+#endif
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index ca914fefea..9e0bfbda67 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -33,6 +33,7 @@
 #include "internal.h"
 #include "mmu-book3s-v3.h"
 #include "mmu-radix64.h"
+#include "mmu-booke.h"
 
 /* #define DUMP_PAGE_TABLES */
 
@@ -429,401 +430,6 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     return -2;
 }
 
-/* Generic TLB check function for embedded PowerPC implementations */
-static bool ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
-                             hwaddr *raddrp,
-                             target_ulong address, uint32_t pid, int i)
-{
-    target_ulong mask;
-
-    /* Check valid flag */
-    if (!(tlb->prot & PAGE_VALID)) {
-        return false;
-    }
-    mask = ~(tlb->size - 1);
-    qemu_log_mask(CPU_LOG_MMU, "%s: TLB %d address " TARGET_FMT_lx
-                  " PID %u <=> " TARGET_FMT_lx " " TARGET_FMT_lx " %u %x\n",
-                  __func__, i, address, pid, tlb->EPN,
-                  mask, (uint32_t)tlb->PID, tlb->prot);
-    /* Check PID */
-    if (tlb->PID != 0 && tlb->PID != pid) {
-        return false;
-    }
-    /* Check effective address */
-    if ((address & mask) != tlb->EPN) {
-        return false;
-    }
-    *raddrp = (tlb->RPN & mask) | (address & ~mask);
-    return true;
-}
-
-/* Generic TLB search function for PowerPC embedded implementations */
-int ppcemb_tlb_search(CPUPPCState *env, target_ulong address, uint32_t pid)
-{
-    ppcemb_tlb_t *tlb;
-    hwaddr raddr;
-    int i;
-
-    for (i = 0; i < env->nb_tlb; i++) {
-        tlb = &env->tlb.tlbe[i];
-        if (ppcemb_tlb_check(env, tlb, &raddr, address, pid, i)) {
-            return i;
-        }
-    }
-    return -1;
-}
-
-static int mmu40x_get_physical_address(CPUPPCState *env, hwaddr *raddr,
-                                       int *prot, target_ulong address,
-                                       MMUAccessType access_type)
-{
-    ppcemb_tlb_t *tlb;
-    int i, ret, zsel, zpr, pr;
-
-    ret = -1;
-    pr = FIELD_EX64(env->msr, MSR, PR);
-    for (i = 0; i < env->nb_tlb; i++) {
-        tlb = &env->tlb.tlbe[i];
-        if (!ppcemb_tlb_check(env, tlb, raddr, address,
-                              env->spr[SPR_40x_PID], i)) {
-            continue;
-        }
-        zsel = (tlb->attr >> 4) & 0xF;
-        zpr = (env->spr[SPR_40x_ZPR] >> (30 - (2 * zsel))) & 0x3;
-        qemu_log_mask(CPU_LOG_MMU,
-                      "%s: TLB %d zsel %d zpr %d ty %d attr %08x\n",
-                      __func__, i, zsel, zpr, access_type, tlb->attr);
-        /* Check execute enable bit */
-        switch (zpr) {
-        case 0x2:
-            if (pr != 0) {
-                goto check_perms;
-            }
-            /* fall through */
-        case 0x3:
-            /* All accesses granted */
-            *prot = PAGE_RWX;
-            ret = 0;
-            break;
-
-        case 0x0:
-            if (pr != 0) {
-                /* Raise Zone protection fault.  */
-                env->spr[SPR_40x_ESR] = 1 << 22;
-                *prot = 0;
-                ret = -2;
-                break;
-            }
-            /* fall through */
-        case 0x1:
-check_perms:
-            /* Check from TLB entry */
-            *prot = tlb->prot;
-            if (check_prot_access_type(*prot, access_type)) {
-                ret = 0;
-            } else {
-                env->spr[SPR_40x_ESR] = 0;
-                ret = -2;
-            }
-            break;
-        }
-    }
-    qemu_log_mask(CPU_LOG_MMU, "%s: access %s " TARGET_FMT_lx " => "
-                  HWADDR_FMT_plx " %d %d\n",  __func__,
-                  ret < 0 ? "refused" : "granted", address,
-                  ret < 0 ? 0 : *raddr, *prot, ret);
-
-    return ret;
-}
-
-static bool mmubooke_check_pid(CPUPPCState *env, ppcemb_tlb_t *tlb,
-                               hwaddr *raddr, target_ulong addr, int i)
-{
-    if (ppcemb_tlb_check(env, tlb, raddr, addr, env->spr[SPR_BOOKE_PID], i)) {
-        if (!env->nb_pids) {
-            /* Extend the physical address to 36 bits */
-            *raddr |= (uint64_t)(tlb->RPN & 0xF) << 32;
-        }
-        return true;
-    } else if (!env->nb_pids) {
-        return false;
-    }
-    if (env->spr[SPR_BOOKE_PID1] &&
-        ppcemb_tlb_check(env, tlb, raddr, addr, env->spr[SPR_BOOKE_PID1], i)) {
-        return true;
-    }
-    if (env->spr[SPR_BOOKE_PID2] &&
-        ppcemb_tlb_check(env, tlb, raddr, addr, env->spr[SPR_BOOKE_PID2], i)) {
-        return true;
-    }
-    return false;
-}
-
-static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
-                              hwaddr *raddr, int *prot, target_ulong address,
-                              MMUAccessType access_type, int i)
-{
-    if (!mmubooke_check_pid(env, tlb, raddr, address, i)) {
-        qemu_log_mask(CPU_LOG_MMU, "%s: TLB entry not found\n", __func__);
-        return -1;
-    }
-
-    /* Check the address space */
-    if ((access_type == MMU_INST_FETCH ?
-        FIELD_EX64(env->msr, MSR, IR) :
-        FIELD_EX64(env->msr, MSR, DR)) != (tlb->attr & 1)) {
-        qemu_log_mask(CPU_LOG_MMU, "%s: AS doesn't match\n", __func__);
-        return -1;
-    }
-
-    if (FIELD_EX64(env->msr, MSR, PR)) {
-        *prot = tlb->prot & 0xF;
-    } else {
-        *prot = (tlb->prot >> 4) & 0xF;
-    }
-    if (check_prot_access_type(*prot, access_type)) {
-        qemu_log_mask(CPU_LOG_MMU, "%s: good TLB!\n", __func__);
-        return 0;
-    }
-
-    qemu_log_mask(CPU_LOG_MMU, "%s: no prot match: %x\n", __func__, *prot);
-    return access_type == MMU_INST_FETCH ? -3 : -2;
-}
-
-static int mmubooke_get_physical_address(CPUPPCState *env, hwaddr *raddr,
-                                         int *prot, target_ulong address,
-                                         MMUAccessType access_type)
-{
-    ppcemb_tlb_t *tlb;
-    int i, ret = -1;
-
-    for (i = 0; i < env->nb_tlb; i++) {
-        tlb = &env->tlb.tlbe[i];
-        ret = mmubooke_check_tlb(env, tlb, raddr, prot, address,
-                                 access_type, i);
-        if (ret != -1) {
-            break;
-        }
-    }
-    qemu_log_mask(CPU_LOG_MMU,
-                  "%s: access %s " TARGET_FMT_lx " => " HWADDR_FMT_plx
-                  " %d %d\n", __func__, ret < 0 ? "refused" : "granted",
-                  address, ret < 0 ? -1 : *raddr, ret == -1 ? 0 : *prot, ret);
-    return ret;
-}
-
-hwaddr booke206_tlb_to_page_size(CPUPPCState *env, ppcmas_tlb_t *tlb)
-{
-    int tlbm_size;
-
-    tlbm_size = (tlb->mas1 & MAS1_TSIZE_MASK) >> MAS1_TSIZE_SHIFT;
-
-    return 1024ULL << tlbm_size;
-}
-
-/* TLB check function for MAS based SoftTLBs */
-int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb, hwaddr *raddrp,
-                     target_ulong address, uint32_t pid)
-{
-    hwaddr mask;
-    uint32_t tlb_pid;
-
-    if (!FIELD_EX64(env->msr, MSR, CM)) {
-        /* In 32bit mode we can only address 32bit EAs */
-        address = (uint32_t)address;
-    }
-
-    /* Check valid flag */
-    if (!(tlb->mas1 & MAS1_VALID)) {
-        return -1;
-    }
-
-    mask = ~(booke206_tlb_to_page_size(env, tlb) - 1);
-    qemu_log_mask(CPU_LOG_MMU, "%s: TLB ADDR=0x" TARGET_FMT_lx
-                  " PID=0x%x MAS1=0x%x MAS2=0x%" PRIx64 " mask=0x%"
-                  HWADDR_PRIx " MAS7_3=0x%" PRIx64 " MAS8=0x%" PRIx32 "\n",
-                  __func__, address, pid, tlb->mas1, tlb->mas2, mask,
-                  tlb->mas7_3, tlb->mas8);
-
-    /* Check PID */
-    tlb_pid = (tlb->mas1 & MAS1_TID_MASK) >> MAS1_TID_SHIFT;
-    if (tlb_pid != 0 && tlb_pid != pid) {
-        return -1;
-    }
-
-    /* Check effective address */
-    if ((address & mask) != (tlb->mas2 & MAS2_EPN_MASK)) {
-        return -1;
-    }
-
-    if (raddrp) {
-        *raddrp = (tlb->mas7_3 & mask) | (address & ~mask);
-    }
-
-    return 0;
-}
-
-static bool is_epid_mmu(int mmu_idx)
-{
-    return mmu_idx == PPC_TLB_EPID_STORE || mmu_idx == PPC_TLB_EPID_LOAD;
-}
-
-static uint32_t mmubooke206_esr(int mmu_idx, MMUAccessType access_type)
-{
-    uint32_t esr = 0;
-    if (access_type == MMU_DATA_STORE) {
-        esr |= ESR_ST;
-    }
-    if (is_epid_mmu(mmu_idx)) {
-        esr |= ESR_EPID;
-    }
-    return esr;
-}
-
-/*
- * Get EPID register given the mmu_idx. If this is regular load,
- * construct the EPID access bits from current processor state
- *
- * Get the effective AS and PR bits and the PID. The PID is returned
- * only if EPID load is requested, otherwise the caller must detect
- * the correct EPID.  Return true if valid EPID is returned.
- */
-static bool mmubooke206_get_as(CPUPPCState *env,
-                               int mmu_idx, uint32_t *epid_out,
-                               bool *as_out, bool *pr_out)
-{
-    if (is_epid_mmu(mmu_idx)) {
-        uint32_t epidr;
-        if (mmu_idx == PPC_TLB_EPID_STORE) {
-            epidr = env->spr[SPR_BOOKE_EPSC];
-        } else {
-            epidr = env->spr[SPR_BOOKE_EPLC];
-        }
-        *epid_out = (epidr & EPID_EPID) >> EPID_EPID_SHIFT;
-        *as_out = !!(epidr & EPID_EAS);
-        *pr_out = !!(epidr & EPID_EPR);
-        return true;
-    } else {
-        *as_out = FIELD_EX64(env->msr, MSR, DS);
-        *pr_out = FIELD_EX64(env->msr, MSR, PR);
-        return false;
-    }
-}
-
-/* Check if the tlb found by hashing really matches */
-static int mmubooke206_check_tlb(CPUPPCState *env, ppcmas_tlb_t *tlb,
-                                 hwaddr *raddr, int *prot,
-                                 target_ulong address,
-                                 MMUAccessType access_type, int mmu_idx)
-{
-    uint32_t epid;
-    bool as, pr;
-    bool use_epid = mmubooke206_get_as(env, mmu_idx, &epid, &as, &pr);
-
-    if (!use_epid) {
-        if (ppcmas_tlb_check(env, tlb, raddr, address,
-                             env->spr[SPR_BOOKE_PID]) >= 0) {
-            goto found_tlb;
-        }
-
-        if (env->spr[SPR_BOOKE_PID1] &&
-            ppcmas_tlb_check(env, tlb, raddr, address,
-                             env->spr[SPR_BOOKE_PID1]) >= 0) {
-            goto found_tlb;
-        }
-
-        if (env->spr[SPR_BOOKE_PID2] &&
-            ppcmas_tlb_check(env, tlb, raddr, address,
-                             env->spr[SPR_BOOKE_PID2]) >= 0) {
-            goto found_tlb;
-        }
-    } else {
-        if (ppcmas_tlb_check(env, tlb, raddr, address, epid) >= 0) {
-            goto found_tlb;
-        }
-    }
-
-    qemu_log_mask(CPU_LOG_MMU, "%s: No TLB entry found for effective address "
-                  "0x" TARGET_FMT_lx "\n", __func__, address);
-    return -1;
-
-found_tlb:
-
-    /* Check the address space and permissions */
-    if (access_type == MMU_INST_FETCH) {
-        /* There is no way to fetch code using epid load */
-        assert(!use_epid);
-        as = FIELD_EX64(env->msr, MSR, IR);
-    }
-
-    if (as != ((tlb->mas1 & MAS1_TS) >> MAS1_TS_SHIFT)) {
-        qemu_log_mask(CPU_LOG_MMU, "%s: AS doesn't match\n", __func__);
-        return -1;
-    }
-
-    *prot = 0;
-    if (pr) {
-        if (tlb->mas7_3 & MAS3_UR) {
-            *prot |= PAGE_READ;
-        }
-        if (tlb->mas7_3 & MAS3_UW) {
-            *prot |= PAGE_WRITE;
-        }
-        if (tlb->mas7_3 & MAS3_UX) {
-            *prot |= PAGE_EXEC;
-        }
-    } else {
-        if (tlb->mas7_3 & MAS3_SR) {
-            *prot |= PAGE_READ;
-        }
-        if (tlb->mas7_3 & MAS3_SW) {
-            *prot |= PAGE_WRITE;
-        }
-        if (tlb->mas7_3 & MAS3_SX) {
-            *prot |= PAGE_EXEC;
-        }
-    }
-    if (check_prot_access_type(*prot, access_type)) {
-        qemu_log_mask(CPU_LOG_MMU, "%s: good TLB!\n", __func__);
-        return 0;
-    }
-
-    qemu_log_mask(CPU_LOG_MMU, "%s: no prot match: %x\n", __func__, *prot);
-    return access_type == MMU_INST_FETCH ? -3 : -2;
-}
-
-static int mmubooke206_get_physical_address(CPUPPCState *env, hwaddr *raddr,
-                                            int *prot, target_ulong address,
-                                            MMUAccessType access_type,
-                                            int mmu_idx)
-{
-    ppcmas_tlb_t *tlb;
-    int i, j, ret = -1;
-
-    for (i = 0; i < BOOKE206_MAX_TLBN; i++) {
-        int ways = booke206_tlb_ways(env, i);
-        for (j = 0; j < ways; j++) {
-            tlb = booke206_get_tlbm(env, i, address, j);
-            if (!tlb) {
-                continue;
-            }
-            ret = mmubooke206_check_tlb(env, tlb, raddr, prot, address,
-                                        access_type, mmu_idx);
-            if (ret != -1) {
-                goto found_tlb;
-            }
-        }
-    }
-
-found_tlb:
-
-    qemu_log_mask(CPU_LOG_MMU, "%s: access %s " TARGET_FMT_lx " => "
-                  HWADDR_FMT_plx " %d %d\n", __func__,
-                  ret < 0 ? "refused" : "granted", address,
-                  ret < 0 ? -1 : *raddr, ret == -1 ? 0 : *prot, ret);
-    return ret;
-}
-
 static const char *book3e_tsize_to_str[32] = {
     "1K", "2K", "4K", "8K", "16K", "32K", "64K", "128K", "256K", "512K",
     "1M", "2M", "4M", "8M", "16M", "32M", "64M", "128M", "256M", "512M",
@@ -1062,117 +668,6 @@ void dump_mmu(CPUPPCState *env)
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
-    hwaddr raddr;
-    int prot, ret;
-
-    if (env->mmu_model == POWERPC_MMU_BOOKE206) {
-        ret = mmubooke206_get_physical_address(env, &raddr, &prot, eaddr,
-                                               access_type, mmu_idx);
-    } else {
-        ret = mmubooke_get_physical_address(env, &raddr, &prot, eaddr,
-                                            access_type);
-    }
-    if (ret == 0) {
-        *raddrp = raddr;
-        *protp = prot;
-        *psizep = TARGET_PAGE_BITS;
-        return true;
-    } else if (!guest_visible) {
-        return false;
-    }
-
-    log_cpu_state_mask(CPU_LOG_MMU, cs, 0);
-    env->error_code = 0;
-    switch (ret) {
-    case -1:
-        /* No matches in page tables or TLB */
-        if (env->mmu_model == POWERPC_MMU_BOOKE206) {
-            booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
-        }
-        cs->exception_index = (access_type == MMU_INST_FETCH) ?
-                              POWERPC_EXCP_ITLB : POWERPC_EXCP_DTLB;
-        env->spr[SPR_BOOKE_DEAR] = eaddr;
-        env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
-        break;
-    case -2:
-        /* Access rights violation */
-        cs->exception_index = (access_type == MMU_INST_FETCH) ?
-                              POWERPC_EXCP_ISI : POWERPC_EXCP_DSI;
-        if (access_type != MMU_INST_FETCH) {
-            env->spr[SPR_BOOKE_DEAR] = eaddr;
-            env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
-        }
-        break;
-    case -3:
-        /* No execute protection violation */
-        cs->exception_index = POWERPC_EXCP_ISI;
-        env->spr[SPR_BOOKE_ESR] = 0;
-        break;
-    }
-
-    return false;
-}
 
 static bool ppc_real_mode_xlate(PowerPCCPU *cpu, vaddr eaddr,
                                 MMUAccessType access_type,
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 680ca0b618..87bfe26220 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -33,6 +33,7 @@
 #include "internal.h"
 #include "mmu-book3s-v3.h"
 #include "mmu-radix64.h"
+#include "mmu-booke.h"
 #include "exec/helper-proto.h"
 #include "exec/cpu_ldst.h"
 
-- 
2.30.9



