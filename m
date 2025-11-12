Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977AACCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 06:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ4h4-0006aV-2Y; Wed, 12 Nov 2025 01:51:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1vJ4gC-0006Lf-M5; Wed, 12 Nov 2025 01:50:20 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1vJ4g4-0001W7-LN; Wed, 12 Nov 2025 01:50:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1762930192; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=D6hxXjspeNA6pycvYior6h12FLtDmYammcdZitMD384=;
 b=dzoHVROryC0cvd168JdX8AqK3xMWGbqNm/3HULFRPT1XmYMoKj2q+uz5f4mYzaUNMYLuCbqGsU3e1yRIRxb2zGroB9BaUOtpIieALds+MMo+c9t1m74G1s48Lu5VtnVRkanhYRt3xdYCVge7Gzfagfj8G401F1JUvzdwAoosYLE=
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WsFCrAE_1762930191 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 12 Nov 2025 14:49:51 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>
Subject: [PATCH v4 3/6] target/riscv: Integrate SMMPT checks into MMU and TLB
 fill
Date: Wed, 12 Nov 2025 14:49:42 +0800
Message-Id: <20251112064945.46533-4-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20251112064945.46533-1-zhiwei_liu@linux.alibaba.com>
References: <20251112064945.46533-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.132;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-132.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
---
 target/riscv/cpu_helper.c | 76 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index a055a8ab20..e4d52a37af 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1161,6 +1161,60 @@ static bool check_svukte_addr(CPURISCVState *env, vaddr addr)
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
+    mpt_access_t mpt_access;
+    bool mpt_has_access;
+
+    /*
+     * If the extension is not supported or the mmpt.mode is Bare,
+     * there is no protection, return success.
+     */
+    if (!riscv_cpu_cfg(env)->ext_smmpt || env->mptmode == 0) {
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
+    mpt_has_access = smmpt_check_access(env, addr,
+                                      &mpt_access, access_type);
+    if (!mpt_has_access) {
+        *prot = 0;
+        return TRANSLATE_MPT_FAIL;
+    }
+
+    *prot = smmpt_access_to_page_prot(mpt_access);
+
+    return TRANSLATE_SUCCESS;
+}
+
 /*
  * get_physical_address - get the physical address for this virtual address
  *
@@ -1355,6 +1409,13 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
             pte_addr = base + idx * ptesize;
         }
 
+        int mpt_prot;
+        int mpt_ret = get_physical_address_mpt(env, &mpt_prot, pte_addr,
+                                               MMU_DATA_LOAD, PRV_S);
+        if (mpt_ret != TRANSLATE_SUCCESS) {
+            return TRANSLATE_MPT_FAIL;
+        }
+
         int pmp_prot;
         int pmp_ret = get_physical_address_pmp(env, &pmp_prot, pte_addr,
                                                sxlen_bytes,
@@ -1765,7 +1826,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     CPURISCVState *env = &cpu->env;
     vaddr im_address;
     hwaddr pa = 0;
-    int prot, prot2, prot_pmp;
+    int prot, prot2, prot_pmp, mpt_prot;
     bool pmp_violation = false;
     bool first_stage_error = true;
     bool two_stage_lookup = mmuidx_2stage(mmu_idx);
@@ -1819,6 +1880,13 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
             prot &= prot2;
 
             if (ret == TRANSLATE_SUCCESS) {
+                ret = get_physical_address_mpt(env, &mpt_prot, pa,
+                                               access_type, mode);
+                qemu_log_mask(CPU_LOG_MMU,
+                              "%s MPT address=" HWADDR_FMT_plx " ret %d prot"
+                              " %d\n",
+                              __func__, pa, ret, mpt_prot);
+                prot &= mpt_prot;
                 ret = get_physical_address_pmp(env, &prot_pmp, pa,
                                                size, access_type, mode);
                 tlb_size = pmp_get_tlb_size(env, pa);
@@ -1854,6 +1922,12 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                       __func__, address, ret, pa, prot);
 
         if (ret == TRANSLATE_SUCCESS) {
+            ret = get_physical_address_mpt(env, &mpt_prot, pa,
+                                           access_type, mode);
+            qemu_log_mask(CPU_LOG_MMU,
+                          "%s MPT address=" HWADDR_FMT_plx " ret %d prot %d\n",
+                          __func__, pa, ret, mpt_prot);
+            prot &= mpt_prot;
             ret = get_physical_address_pmp(env, &prot_pmp, pa,
                                            size, access_type, mode);
             tlb_size = pmp_get_tlb_size(env, pa);
-- 
2.25.1


