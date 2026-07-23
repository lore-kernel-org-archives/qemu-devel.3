Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5FDC531F7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 20:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmzf4-0007ib-BE; Thu, 23 Jul 2026 16:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wmzeI-0007Oe-IC; Thu, 23 Jul 2026 16:04:06 -0400
Received: from [115.124.30.111] (helo=out30-111.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wmzeA-0005Rt-P7; Thu, 23 Jul 2026 16:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1784837022; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=M07UVfnU/2nidLWov/BOD//BB/HPNCPhrhQsGIpMnPg=;
 b=RoZ6H5qhWrQXc1ePvUyTeyT/LTbLYzT3vm+XeIU1XdBDykxE98RfUoTXin8MXdDjg18Dgqo++d+0+/OlYoYWRDnkFVcFodD/wVrrYlZ3B9gxawZwcEgSYccG+paMl+RKnKzLdlgFghBIeowWO/8swbclHIzwcyvODkMRTJYd0Nw=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0X7h4UuO_1784837021; 
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0X7h4UuO_1784837021 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 24 Jul 2026 04:03:41 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com,
 daniel.barboza@oss.qualcomm.com, chao.liu.zevorn@gmail.com,
 liwei1518@gmail.com, qemu-riscv@nongnu.org, rahul@summations.net,
 xiangyi.zeng@linux.alibaba.com, cxx194832@alibaba-inc.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v8 04/11] target/riscv: Integrate SMMPT checks into MMU and
 TLB fill
Date: Fri, 24 Jul 2026 04:03:18 +0800
Message-Id: <20260723200325.24969-5-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260723200325.24969-1-zhiwei_liu@linux.alibaba.com>
References: <20260723200325.24969-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.111 (deferred)
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

With the core MPT lookup logic in place, this patch integrates the
permission checks into QEMU's main MMU processing functions.

A new helper, `get_physical_address_mpt`, is introduced to check the
permissions for a given physical address against the MPT. This helper
is then called at two critical points:

1. During page table walks (`get_physical_address`): The physical
   address of the Page Table Entry (PTE) itself is checked to ensure
   the supervisor has permission to read it.

2. After successful address translation (`riscv_cpu_tlb_fill`): The final
   guest-physical address is checked against the MPT before the access
   is allowed to proceed.

This ensures that SMMPT protection is enforced for both the translation
process and the final memory access, as required by the specification.

Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/tcg/cpu_helper.c | 113 ++++++++++++++++++++++++++++++----
 1 file changed, 100 insertions(+), 13 deletions(-)

diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 354506c565..e3aac26931 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -976,6 +976,53 @@ static bool check_svukte_addr(CPURISCVState *env, vaddr addr)
     return !high_bit;
 }
 
+/*
+ * get_physical_address_mpt - check mpt permission for this physical address
+ *
+ * Lookup the Memory Protection Table and check permission for this
+ * physical address. Returns 0 if the permission checking was successful
+ *
+ * @env: CPURISCVState
+ * @prot: The returned protection attributes
+ * @addr: The physical address to be checked permission
+ * @access_type: The type of MMU access
+ * @mode: Indicates current privilege level.
+ */
+static int get_physical_address_mpt(CPURISCVState *env, int *prot, hwaddr addr,
+                                    MMUAccessType access_type, int mode)
+{
+    /*
+     * If the extension is not supported or the mmpt.mode is Bare,
+     * there is no protection, return success.
+     */
+    if (!riscv_cpu_cfg(env)->ext_smmpt || env->mptmode == SMMPTBARE) {
+        *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+        return TRANSLATE_SUCCESS;
+    }
+
+    /*
+     * MPT is checked for all accesses to physical memory, unless the
+     * effective privilege mode is M.
+     *
+     * Data accesses in M-mode when the MPRV bit in mstatus is set and
+     * the MPP field in mstatus contains S or U are subject to MPT checks.
+     *
+     * In riscv_env_mmu_index, The MPRV and MPP bits are already checked and
+     * encoded to mmu_idx, So we do not need to check it here.
+     */
+    if (mode == PRV_M) {
+        *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+        return TRANSLATE_SUCCESS;
+    }
+
+    if (!smmpt_check_access(env, addr, prot, access_type)) {
+        *prot = 0;
+        return TRANSLATE_MPT_FAIL;
+    }
+
+    return TRANSLATE_SUCCESS;
+}
+
 /*
  * get_physical_address - get the physical address for this virtual address
  *
@@ -1174,6 +1221,13 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
             pte_addr = base + idx * ptesize;
         }
 
+        int mpt_prot;
+        int mpt_ret = get_physical_address_mpt(env, &mpt_prot, pte_addr,
+                                               MMU_DATA_LOAD, PRV_S);
+        if (mpt_ret != TRANSLATE_SUCCESS) {
+            return mpt_ret;
+        }
+
         int pmp_prot;
         int pmp_ret = get_physical_address_pmp(env, &pmp_prot, pte_addr,
                                                sxlen_bytes,
@@ -1657,7 +1711,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     CPURISCVState *env = &cpu->env;
     vaddr im_address;
     hwaddr pa = 0;
-    int prot, prot2, prot_pmp;
+    int prot, prot2, prot_pmp, mpt_prot;
     bool pmp_pma_violation = false;
     bool first_stage_error = true;
     bool two_stage_lookup = mmuidx_2stage(mmu_idx);
@@ -1710,26 +1764,42 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
             prot &= prot2;
 
             if (ret == TRANSLATE_SUCCESS) {
-                ret = get_physical_address_pmp(env, &prot_pmp, pa,
-                                               size, access_type, mode);
-                tlb_size = pmp_get_tlb_size(env, pa);
+                ret = get_physical_address_mpt(env, &mpt_prot, pa,
+                                               access_type, mode);
+                if (riscv_cpu_cfg(env)->ext_smmpt) {
+                    qemu_log_mask(CPU_LOG_MMU,
+                                  "%s MPT address=" HWADDR_FMT_plx " ret %d"
+                                  " prot %d\n",
+                                  __func__, pa, ret, mpt_prot);
+                }
+                prot &= mpt_prot;
 
-                qemu_log_mask(CPU_LOG_MMU,
-                              "%s PMP address=" HWADDR_FMT_plx " ret %d prot"
-                              " %d tlb_size %" HWADDR_PRIu "\n",
-                              __func__, pa, ret, prot_pmp, tlb_size);
+                if (ret == TRANSLATE_SUCCESS) {
+                    ret = get_physical_address_pmp(env, &prot_pmp, pa,
+                                                   size, access_type, mode);
+                    tlb_size = pmp_get_tlb_size(env, pa);
+
+                    qemu_log_mask(CPU_LOG_MMU,
+                                  "%s PMP address=" HWADDR_FMT_plx
+                                  " ret %d prot %d tlb_size %"
+                                  HWADDR_PRIu "\n",
+                                  __func__, pa, ret, prot_pmp,
+                                  tlb_size);
 
-                prot &= prot_pmp;
+                    prot &= prot_pmp;
+                }
             } else {
                 /*
                  * Guest physical address translation failed, this is a HS
                  * level exception
                  */
                 first_stage_error = false;
-                if (ret != TRANSLATE_PMP_FAIL) {
+                if (ret != TRANSLATE_PMP_FAIL &&
+                    ret != TRANSLATE_MPT_FAIL) {
                     env->guest_phys_fault_addr = (im_address |
                                                   (address &
-                                                   (TARGET_PAGE_SIZE - 1))) >> 2;
+                                                   (TARGET_PAGE_SIZE - 1)))
+                                                 >> 2;
                 }
             }
         }
@@ -1744,6 +1814,18 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                       HWADDR_FMT_plx " prot %d\n",
                       __func__, address, ret, pa, prot);
 
+        if (ret == TRANSLATE_SUCCESS) {
+            ret = get_physical_address_mpt(env, &mpt_prot, pa,
+                                           access_type, mode);
+            if (riscv_cpu_cfg(env)->ext_smmpt) {
+                qemu_log_mask(CPU_LOG_MMU,
+                              "%s MPT address=" HWADDR_FMT_plx " ret %d"
+                              " prot %d\n",
+                              __func__, pa, ret, mpt_prot);
+            }
+            prot &= mpt_prot;
+        }
+
         if (ret == TRANSLATE_SUCCESS) {
             ret = get_physical_address_pmp(env, &prot_pmp, pa,
                                            size, access_type, mode);
@@ -1757,8 +1839,13 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
             prot &= prot_pmp;
         }
     }
-
-    if (ret == TRANSLATE_PMP_FAIL || ret == TRANSLATE_PMA_FAIL) {
+    /*
+     * Both MPT (Machine-level Memory Protection Table, Smmpt extension) and
+     * PMP (Physical Memory Protection) follow the same exception reporting
+     * rule when an access violation is detected
+     */
+    if (ret == TRANSLATE_PMP_FAIL || ret == TRANSLATE_PMA_FAIL ||
+        ret == TRANSLATE_MPT_FAIL) {
         pmp_pma_violation = true;
     }
 
-- 
2.43.0


