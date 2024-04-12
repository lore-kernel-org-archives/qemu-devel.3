Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1580C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBcP-0003S4-DZ; Fri, 12 Apr 2024 03:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvBcN-0003Rj-M1; Fri, 12 Apr 2024 03:46:39 -0400
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvBcI-0000xE-Bp; Fri, 12 Apr 2024 03:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712907987; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=U5gWdPjnZ8jAyzXeyOkRDORRmrHe3OHO1qDDOYZ+XK4=;
 b=uXUYWVOlY7lTqr3pOw58VDC80urbXQvks5H4a2C9rO+WuwVEIgKU7mbVFXf6MWcEen62ocuzTq9WIqmwl6PLxqxfeRaDaddNKgstgvAjld2aZy6AD/mkufgzbKdru3NGrJz9CWOZiWTJEKxd0XLn/YE836sA5OQT8kBy8bSdQKA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R411e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NVSM._1712907986; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NVSM._1712907986) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 15:46:26 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 04/65] target/riscv: Override some csr ops for XTheadVector
Date: Fri, 12 Apr 2024 15:36:34 +0800
Message-ID: <20240412073735.76413-5-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Some CSR operations have different behavior when XTheadVector is enabled.
In this patch, we override the RISC-V standard implementation of these
CSRs with a vendor implementation. Additionally, we attempt to use the
decorator pattern to explicitly list the different behaviors between
xtheadvector and the RISC-V standard.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/cpu.h      |  36 +++++++++
 target/riscv/cpu_bits.h |  18 +++++
 target/riscv/csr.c      |  42 +++++-----
 target/riscv/th_csr.c   | 169 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 243 insertions(+), 22 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8d0b500758..6558e652df 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -813,6 +813,42 @@ void riscv_add_satp_mode_properties(Object *obj);
 bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
 
 /* CSR function table */
+RISCVException fs(CPURISCVState *env, int csrno);
+RISCVException vs(CPURISCVState *env, int csrno);
+RISCVException any(CPURISCVState *env, int csrno);
+RISCVException smode(CPURISCVState *env, int csrno);
+RISCVException read_fcsr(CPURISCVState *env, int csrno,
+                         target_ulong *val);
+RISCVException write_fcsr(CPURISCVState *env, int csrno,
+                          target_ulong val);
+RISCVException read_vtype(CPURISCVState *env, int csrno,
+                          target_ulong *val);
+RISCVException read_vl(CPURISCVState *env, int csrno,
+                       target_ulong *val);
+RISCVException read_vlenb(CPURISCVState *env, int csrno,
+                          target_ulong *val);
+RISCVException read_vxrm(CPURISCVState *env, int csrno,
+                         target_ulong *val);
+RISCVException write_vxrm(CPURISCVState *env, int csrno,
+                          target_ulong val);
+RISCVException read_vxsat(CPURISCVState *env, int csrno,
+                          target_ulong *val);
+RISCVException write_vxsat(CPURISCVState *env, int csrno,
+                           target_ulong val);
+RISCVException read_vstart(CPURISCVState *env, int csrno,
+                           target_ulong *val);
+RISCVException write_vstart(CPURISCVState *env, int csrno,
+                            target_ulong val);
+RISCVException read_mstatus(CPURISCVState *env, int csrno,
+                            target_ulong *val);
+RISCVException write_mstatus(CPURISCVState *env, int csrno,
+                             target_ulong val);
+RISCVException write_sstatus(CPURISCVState *env, int csrno,
+                             target_ulong val);
+RISCVException read_sstatus(CPURISCVState *env, int csrno,
+                            target_ulong *val);
+RISCVException read_vcsr(CPURISCVState *env, int csrno, target_ulong *val);
+RISCVException write_vcsr(CPURISCVState *env, int csrno, target_ulong val);
 extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
 
 extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index fc2068ee4d..5a5e0ed444 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -904,4 +904,22 @@ typedef enum RISCVException {
 #define MCONTEXT64                         0x0000000000001FFFULL
 #define MCONTEXT32_HCONTEXT                0x0000007F
 #define MCONTEXT64_HCONTEXT                0x0000000000003FFFULL
+
+/* Xuantie custom CSRs */
+#define TH_MSTATUS_VS     0x01800000
+
+#define TH_FSR_VXRM_SHIFT      9
+#define TH_FSR_VXRM            (0x3 << TH_FSR_VXRM_SHIFT)
+
+#define TH_FSR_VXSAT_SHIFT     8
+#define TH_FSR_VXSAT           (0x1 << TH_FSR_VXSAT_SHIFT)
+
+#define TH_VTYPE_LMUL_SHIFT    0
+#define TH_VTYPE_LMUL          (0x3 << TH_VTYPE_LMUL_SHIFT)
+
+#define TH_VTYPE_SEW_SHIFT     2
+#define TH_VTYPE_SEW           (0x7 << TH_VTYPE_SEW_SHIFT)
+
+#define TH_VTYPE_CLEAR_SHIFT   5
+#define TH_VTYPE_CLEAR         (0x7 << TH_VTYPE_CLEAR_SHIFT)
 #endif
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 726096444f..797929d5b9 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -76,7 +76,7 @@ RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit)
 }
 #endif
 
-static RISCVException fs(CPURISCVState *env, int csrno)
+RISCVException fs(CPURISCVState *env, int csrno)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (!env->debugger && !riscv_cpu_fp_enabled(env) &&
@@ -91,7 +91,7 @@ static RISCVException fs(CPURISCVState *env, int csrno)
     return RISCV_EXCP_NONE;
 }
 
-static RISCVException vs(CPURISCVState *env, int csrno)
+RISCVException vs(CPURISCVState *env, int csrno)
 {
     if (riscv_cpu_cfg(env)->ext_zve32f) {
 #if !defined(CONFIG_USER_ONLY)
@@ -227,7 +227,7 @@ static RISCVException sscofpmf(CPURISCVState *env, int csrno)
     return RISCV_EXCP_NONE;
 }
 
-static RISCVException any(CPURISCVState *env, int csrno)
+RISCVException any(CPURISCVState *env, int csrno)
 {
     return RISCV_EXCP_NONE;
 }
@@ -260,7 +260,7 @@ static RISCVException aia_any32(CPURISCVState *env, int csrno)
     return any32(env, csrno);
 }
 
-static RISCVException smode(CPURISCVState *env, int csrno)
+RISCVException smode(CPURISCVState *env, int csrno)
 {
     if (riscv_has_ext(env, RVS)) {
         return RISCV_EXCP_NONE;
@@ -635,7 +635,7 @@ static RISCVException write_frm(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-static RISCVException read_fcsr(CPURISCVState *env, int csrno,
+RISCVException read_fcsr(CPURISCVState *env, int csrno,
                                 target_ulong *val)
 {
     *val = (riscv_cpu_get_fflags(env) << FSR_AEXC_SHIFT)
@@ -643,7 +643,7 @@ static RISCVException read_fcsr(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-static RISCVException write_fcsr(CPURISCVState *env, int csrno,
+RISCVException write_fcsr(CPURISCVState *env, int csrno,
                                  target_ulong val)
 {
 #if !defined(CONFIG_USER_ONLY)
@@ -656,7 +656,7 @@ static RISCVException write_fcsr(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-static RISCVException read_vtype(CPURISCVState *env, int csrno,
+RISCVException read_vtype(CPURISCVState *env, int csrno,
                                  target_ulong *val)
 {
     uint64_t vill;
@@ -674,28 +674,28 @@ static RISCVException read_vtype(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-static RISCVException read_vl(CPURISCVState *env, int csrno,
+RISCVException read_vl(CPURISCVState *env, int csrno,
                               target_ulong *val)
 {
     *val = env->vl;
     return RISCV_EXCP_NONE;
 }
 
-static RISCVException read_vlenb(CPURISCVState *env, int csrno,
+RISCVException read_vlenb(CPURISCVState *env, int csrno,
                                  target_ulong *val)
 {
     *val = riscv_cpu_cfg(env)->vlenb;
     return RISCV_EXCP_NONE;
 }
 
-static RISCVException read_vxrm(CPURISCVState *env, int csrno,
+RISCVException read_vxrm(CPURISCVState *env, int csrno,
                                 target_ulong *val)
 {
     *val = env->vxrm;
     return RISCV_EXCP_NONE;
 }
 
-static RISCVException write_vxrm(CPURISCVState *env, int csrno,
+RISCVException write_vxrm(CPURISCVState *env, int csrno,
                                  target_ulong val)
 {
 #if !defined(CONFIG_USER_ONLY)
@@ -705,14 +705,14 @@ static RISCVException write_vxrm(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-static RISCVException read_vxsat(CPURISCVState *env, int csrno,
+RISCVException read_vxsat(CPURISCVState *env, int csrno,
                                  target_ulong *val)
 {
     *val = env->vxsat;
     return RISCV_EXCP_NONE;
 }
 
-static RISCVException write_vxsat(CPURISCVState *env, int csrno,
+RISCVException write_vxsat(CPURISCVState *env, int csrno,
                                   target_ulong val)
 {
 #if !defined(CONFIG_USER_ONLY)
@@ -722,14 +722,14 @@ static RISCVException write_vxsat(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-static RISCVException read_vstart(CPURISCVState *env, int csrno,
+RISCVException read_vstart(CPURISCVState *env, int csrno,
                                   target_ulong *val)
 {
     *val = env->vstart;
     return RISCV_EXCP_NONE;
 }
 
-static RISCVException write_vstart(CPURISCVState *env, int csrno,
+RISCVException write_vstart(CPURISCVState *env, int csrno,
                                    target_ulong val)
 {
 #if !defined(CONFIG_USER_ONLY)
@@ -743,14 +743,14 @@ static RISCVException write_vstart(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-static RISCVException read_vcsr(CPURISCVState *env, int csrno,
+RISCVException read_vcsr(CPURISCVState *env, int csrno,
                                 target_ulong *val)
 {
     *val = (env->vxrm << VCSR_VXRM_SHIFT) | (env->vxsat << VCSR_VXSAT_SHIFT);
     return RISCV_EXCP_NONE;
 }
 
-static RISCVException write_vcsr(CPURISCVState *env, int csrno,
+RISCVException write_vcsr(CPURISCVState *env, int csrno,
                                  target_ulong val)
 {
 #if !defined(CONFIG_USER_ONLY)
@@ -1286,7 +1286,7 @@ static uint64_t add_status_sd(RISCVMXL xl, uint64_t status)
     return status;
 }
 
-static RISCVException read_mstatus(CPURISCVState *env, int csrno,
+RISCVException read_mstatus(CPURISCVState *env, int csrno,
                                    target_ulong *val)
 {
     *val = add_status_sd(riscv_cpu_mxl(env), env->mstatus);
@@ -1351,7 +1351,7 @@ static target_ulong legalize_mpp(CPURISCVState *env, target_ulong old_mpp,
     return val;
 }
 
-static RISCVException write_mstatus(CPURISCVState *env, int csrno,
+RISCVException write_mstatus(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
     uint64_t mstatus = env->mstatus;
@@ -2639,7 +2639,7 @@ static RISCVException read_sstatus_i128(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-static RISCVException read_sstatus(CPURISCVState *env, int csrno,
+RISCVException read_sstatus(CPURISCVState *env, int csrno,
                                    target_ulong *val)
 {
     target_ulong mask = (sstatus_v1_10_mask);
@@ -2651,7 +2651,7 @@ static RISCVException read_sstatus(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-static RISCVException write_sstatus(CPURISCVState *env, int csrno,
+RISCVException write_sstatus(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
     target_ulong mask = (sstatus_v1_10_mask);
diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
index dc087b1ffa..4fc488fc10 100644
--- a/target/riscv/th_csr.c
+++ b/target/riscv/th_csr.c
@@ -41,7 +41,124 @@ static int test_thead_mvendorid(RISCVCPU *cpu)
     return 0;
 }
 
+/*
+ * In XTheadVector, vcsr is inaccessible
+ * and we just check ext_xtheadvector instead of ext_zve32f
+ */
+static RISCVException th_vs(CPURISCVState *env, int csrno)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+    if (cpu->cfg.ext_xtheadvector) {
+        if (csrno == CSR_VCSR) {
+            return RISCV_EXCP_ILLEGAL_INST;
+        }
+        return RISCV_EXCP_NONE;
+    }
+    return vs(env, csrno);
+}
+
+static RISCVException
+th_read_fcsr(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+    RISCVException ret = read_fcsr(env, csrno, val);
+    if (cpu->cfg.ext_xtheadvector) {
+        *val = set_field(*val, TH_FSR_VXRM,  env->vxrm);
+        *val = set_field(*val, TH_FSR_VXSAT,  env->vxsat);
+    }
+    return ret;
+}
+
+static RISCVException
+th_write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+    if (cpu->cfg.ext_xtheadvector) {
+        env->vxrm = get_field(val, TH_FSR_VXRM);
+        env->vxsat = get_field(val, TH_FSR_VXSAT);
+    }
+    return write_fcsr(env, csrno, val);
+}
+
+/*
+ * We use the RVV1.0 format for env->vtype
+ * When reading vtype, we need to change the format.
+ * In RVV1.0:
+ *   vtype[7] -> vma
+ *   vtype[6] -> vta
+ *   vtype[5:3] -> vsew
+ *   vtype[2:0] -> vlmul
+ * In XTheadVector:
+ *   vtype[6:5] -> vediv
+ *   vtype[4:2] -> vsew
+ *   vtype[1:0] -> vlmul
+ * Although vlmul size is different between RVV1.0 and XTheadVector,
+ * the lower 2 bits have the same meaning.
+ * vma, vta and vediv are useless in XTheadVector, So we need to clear
+ * vtype[7:5] for XTheadVector
+ */
+static RISCVException
+th_read_vtype(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+    RISCVException ret = read_vtype(env, csrno, val);
+    if (cpu->cfg.ext_xtheadvector) {
+        *val = set_field(*val, TH_VTYPE_LMUL,
+                          FIELD_EX64(*val, VTYPE, VLMUL));
+        *val = set_field(*val, TH_VTYPE_SEW,
+                          FIELD_EX64(*val, VTYPE, VSEW));
+        *val = set_field(*val, TH_VTYPE_CLEAR, 0);
+    }
+    return ret;
+}
+
 #if !defined(CONFIG_USER_ONLY)
+static RISCVException
+th_read_mstatus(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+    RISCVException ret = read_mstatus(env, csrno, val);
+    if (cpu->cfg.ext_xtheadvector) {
+        *val = set_field(*val, TH_MSTATUS_VS,
+                         get_field(*val, MSTATUS_VS));
+    }
+    return ret;
+}
+
+static RISCVException
+th_write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+    if (cpu->cfg.ext_xtheadvector) {
+        val = set_field(val, MSTATUS_VS,
+                        get_field(val, TH_MSTATUS_VS));
+    }
+    return write_mstatus(env, csrno, val);
+}
+
+static RISCVException
+th_read_sstatus(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+    RISCVException ret = read_sstatus(env, csrno, val);
+    if (cpu->cfg.ext_xtheadvector) {
+        *val = set_field(*val, TH_MSTATUS_VS,
+                        get_field(*val, MSTATUS_VS));
+    }
+    return ret;
+}
+
+static RISCVException
+th_write_sstatus(CPURISCVState *env, int csrno, target_ulong val)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+    if (cpu->cfg.ext_xtheadvector) {
+        val = set_field(val, MSTATUS_VS,
+                        get_field(val, TH_MSTATUS_VS));
+    }
+    return write_sstatus(env, csrno, val);
+}
+
 static RISCVException s_mode_csr(CPURISCVState *env, int csrno)
 {
     if (env->debugger)
@@ -63,13 +180,63 @@ static RISCVException read_th_sxstatus(CPURISCVState *env, int csrno,
 #endif
 
 static riscv_csr th_csr_list[] = {
+    {
+        .csrno = CSR_FCSR,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "fcsr", fs, th_read_fcsr, th_write_fcsr }
+    },
+    {
+        .csrno = CSR_VSTART,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "vstart", th_vs, read_vstart, write_vstart }
+    },
+    {
+        .csrno = CSR_VXSAT,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "vxsat", th_vs, read_vxsat, write_vxsat }
+    },
+    {
+        .csrno = CSR_VXRM,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "vxrm", th_vs, read_vxrm, write_vxrm }
+    },
+    {
+        .csrno = CSR_VCSR,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "vcsr", th_vs, read_vcsr, write_vcsr }
+    },
+    {
+        .csrno = CSR_VL,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "vl", th_vs, read_vl}
+    },
+    {
+        .csrno = CSR_VTYPE,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "vtype", th_vs, th_read_vtype}
+    },
+    {
+        .csrno = CSR_VLENB,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "vlenb", th_vs, read_vlenb}
+    },
 #if !defined(CONFIG_USER_ONLY)
+    {
+        .csrno = CSR_MSTATUS,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "mstatus", any, th_read_mstatus, th_write_mstatus}
+    },
+    {
+        .csrno = CSR_SSTATUS,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "sstatus", smode, th_read_sstatus, th_write_sstatus}
+    },
     {
         .csrno = CSR_TH_SXSTATUS,
         .insertion_test = test_thead_mvendorid,
         .csr_ops = { "th.sxstatus", s_mode_csr, read_th_sxstatus }
     },
-#endif
+#endif /* !CONFIG_USER_ONLY */
 };
 
 void th_register_custom_csrs(RISCVCPU *cpu)
-- 
2.44.0


