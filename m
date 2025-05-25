Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE63C54F30
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 09:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJ7u5-0000d6-8K; Sun, 25 May 2025 05:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJ7u3-0000Z5-IR; Sun, 25 May 2025 05:44:23 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJ7tz-0004ej-R9; Sun, 25 May 2025 05:44:23 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B82DE124DE8;
 Sun, 25 May 2025 12:42:47 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 99E4A215F10;
 Sun, 25 May 2025 12:42:48 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.4 54/62] target/riscv/kvm: turn kvm_riscv_reg_id_ulong()
 into a macro
Date: Sun, 25 May 2025 12:42:37 +0300
Message-Id: <20250525094246.174612-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.4-20250525112803@cover.tls.msk.ru>
References: <qemu-stable-9.2.4-20250525112803@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

We need the reg_id_ulong() helper to be a macro to be able to create a
static array of KVMCPUConfig that will hold CSR information.

Despite the amount of changes all of them are tedious/trivial:

- replace instances of "kvm_riscv_reg_id_ulong" with
  "KVM_RISCV_REG_ID_ULONG";

- RISCV_CORE_REG(), RISCV_CSR_REG(), RISCV_CONFIG_REG() and
  RISCV_VECTOR_CSR_REG() only receives one 'name' arg. Remove unneeded
  'env' variables when applicable.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250429124421.223883-5-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
(cherry picked from commit 11766e17616a5a4181d4a63f88adf67ac52c553b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index dcf5fee38a..b646bb034b 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -64,23 +64,11 @@ static bool cap_has_mp_state;
 #define KVM_RISCV_REG_ID_U64(type, idx) (KVM_REG_RISCV | KVM_REG_SIZE_U64 | \
                                          type | idx)
 
-static uint64_t kvm_riscv_reg_id_ulong(CPURISCVState *env, uint64_t type,
-                                 uint64_t idx)
-{
-    uint64_t id = KVM_REG_RISCV | type | idx;
-
-    switch (riscv_cpu_mxl(env)) {
-    case MXL_RV32:
-        id |= KVM_REG_SIZE_U32;
-        break;
-    case MXL_RV64:
-        id |= KVM_REG_SIZE_U64;
-        break;
-    default:
-        g_assert_not_reached();
-    }
-    return id;
-}
+#if defined(TARGET_RISCV64)
+#define KVM_RISCV_REG_ID_ULONG(type, idx) KVM_RISCV_REG_ID_U64(type, idx)
+#else
+#define KVM_RISCV_REG_ID_ULONG(type, idx) KVM_RISCV_REG_ID_U32(type, idx)
+#endif
 
 static uint64_t kvm_encode_reg_size_id(uint64_t id, size_t size_b)
 {
@@ -103,16 +91,16 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
     return kvm_encode_reg_size_id(id, size_b);
 }
 
-#define RISCV_CORE_REG(env, name) \
-    kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CORE, \
+#define RISCV_CORE_REG(name) \
+    KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CORE, \
                            KVM_REG_RISCV_CORE_REG(name))
 
-#define RISCV_CSR_REG(env, name) \
-    kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CSR, \
+#define RISCV_CSR_REG(name) \
+    KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CSR, \
                            KVM_REG_RISCV_CSR_REG(name))
 
-#define RISCV_CONFIG_REG(env, name) \
-    kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CONFIG, \
+#define RISCV_CONFIG_REG(name) \
+    KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CONFIG, \
                            KVM_REG_RISCV_CONFIG_REG(name))
 
 #define RISCV_TIMER_REG(name)  KVM_RISCV_REG_ID_U64(KVM_REG_RISCV_TIMER, \
@@ -122,13 +110,13 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
 
 #define RISCV_FP_D_REG(idx)  KVM_RISCV_REG_ID_U64(KVM_REG_RISCV_FP_D, idx)
 
-#define RISCV_VECTOR_CSR_REG(env, name) \
-    kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_VECTOR, \
+#define RISCV_VECTOR_CSR_REG(name) \
+    KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_VECTOR, \
                            KVM_REG_RISCV_VECTOR_CSR_REG(name))
 
 #define KVM_RISCV_GET_CSR(cs, env, csr, reg) \
     do { \
-        int _ret = kvm_get_one_reg(cs, RISCV_CSR_REG(env, csr), &reg); \
+        int _ret = kvm_get_one_reg(cs, RISCV_CSR_REG(csr), &reg); \
         if (_ret) { \
             return _ret; \
         } \
@@ -136,7 +124,7 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
 
 #define KVM_RISCV_SET_CSR(cs, env, csr, reg) \
     do { \
-        int _ret = kvm_set_one_reg(cs, RISCV_CSR_REG(env, csr), &reg); \
+        int _ret = kvm_set_one_reg(cs, RISCV_CSR_REG(csr), &reg); \
         if (_ret) { \
             return _ret; \
         } \
@@ -244,7 +232,7 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
 
         /* If we're here we're going to disable the MISA bit */
         reg = 0;
-        id = kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_ISA_EXT,
+        id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_ISA_EXT,
                                     misa_cfg->kvm_reg_id);
         ret = kvm_set_one_reg(cs, id, &reg);
         if (ret != 0) {
@@ -422,7 +410,6 @@ static KVMCPUConfig kvm_sbi_dbcn = {
 
 static void kvm_riscv_update_cpu_cfg_isa_ext(RISCVCPU *cpu, CPUState *cs)
 {
-    CPURISCVState *env = &cpu->env;
     uint64_t id, reg;
     int i, ret;
 
@@ -433,7 +420,7 @@ static void kvm_riscv_update_cpu_cfg_isa_ext(RISCVCPU *cpu, CPUState *cs)
             continue;
         }
 
-        id = kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_ISA_EXT,
+        id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_ISA_EXT,
                                     multi_ext_cfg->kvm_reg_id);
         reg = kvm_cpu_cfg_get(cpu, multi_ext_cfg);
         ret = kvm_set_one_reg(cs, id, &reg);
@@ -558,14 +545,14 @@ static int kvm_riscv_get_regs_core(CPUState *cs)
     target_ulong reg;
     CPURISCVState *env = &RISCV_CPU(cs)->env;
 
-    ret = kvm_get_one_reg(cs, RISCV_CORE_REG(env, regs.pc), &reg);
+    ret = kvm_get_one_reg(cs, RISCV_CORE_REG(regs.pc), &reg);
     if (ret) {
         return ret;
     }
     env->pc = reg;
 
     for (i = 1; i < 32; i++) {
-        uint64_t id = kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CORE, i);
+        uint64_t id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CORE, i);
         ret = kvm_get_one_reg(cs, id, &reg);
         if (ret) {
             return ret;
@@ -584,13 +571,13 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
     CPURISCVState *env = &RISCV_CPU(cs)->env;
 
     reg = env->pc;
-    ret = kvm_set_one_reg(cs, RISCV_CORE_REG(env, regs.pc), &reg);
+    ret = kvm_set_one_reg(cs, RISCV_CORE_REG(regs.pc), &reg);
     if (ret) {
         return ret;
     }
 
     for (i = 1; i < 32; i++) {
-        uint64_t id = kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CORE, i);
+        uint64_t id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CORE, i);
         reg = env->gpr[i];
         ret = kvm_set_one_reg(cs, id, &reg);
         if (ret) {
@@ -788,26 +775,26 @@ static int kvm_riscv_get_regs_vector(CPUState *cs)
         return 0;
     }
 
-    ret = kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vstart), &reg);
+    ret = kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(vstart), &reg);
     if (ret) {
         return ret;
     }
     env->vstart = reg;
 
-    ret = kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vl), &reg);
+    ret = kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(vl), &reg);
     if (ret) {
         return ret;
     }
     env->vl = reg;
 
-    ret = kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vtype), &reg);
+    ret = kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(vtype), &reg);
     if (ret) {
         return ret;
     }
     env->vtype = reg;
 
     if (kvm_v_vlenb.supported) {
-        ret = kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vlenb), &reg);
+        ret = kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(vlenb), &reg);
         if (ret) {
             return ret;
         }
@@ -845,26 +832,26 @@ static int kvm_riscv_put_regs_vector(CPUState *cs)
     }
 
     reg = env->vstart;
-    ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vstart), &reg);
+    ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(vstart), &reg);
     if (ret) {
         return ret;
     }
 
     reg = env->vl;
-    ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vl), &reg);
+    ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(vl), &reg);
     if (ret) {
         return ret;
     }
 
     reg = env->vtype;
-    ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vtype), &reg);
+    ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(vtype), &reg);
     if (ret) {
         return ret;
     }
 
     if (kvm_v_vlenb.supported) {
         reg = cpu->cfg.vlenb;
-        ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vlenb), &reg);
+        ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(vlenb), &reg);
 
         for (int i = 0; i < 32; i++) {
             /*
@@ -943,25 +930,24 @@ static void kvm_riscv_destroy_scratch_vcpu(KVMScratchCPU *scratch)
 
 static void kvm_riscv_init_machine_ids(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
 {
-    CPURISCVState *env = &cpu->env;
     struct kvm_one_reg reg;
     int ret;
 
-    reg.id = RISCV_CONFIG_REG(env, mvendorid);
+    reg.id = RISCV_CONFIG_REG(mvendorid);
     reg.addr = (uint64_t)&cpu->cfg.mvendorid;
     ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
     if (ret != 0) {
         error_report("Unable to retrieve mvendorid from host, error %d", ret);
     }
 
-    reg.id = RISCV_CONFIG_REG(env, marchid);
+    reg.id = RISCV_CONFIG_REG(marchid);
     reg.addr = (uint64_t)&cpu->cfg.marchid;
     ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
     if (ret != 0) {
         error_report("Unable to retrieve marchid from host, error %d", ret);
     }
 
-    reg.id = RISCV_CONFIG_REG(env, mimpid);
+    reg.id = RISCV_CONFIG_REG(mimpid);
     reg.addr = (uint64_t)&cpu->cfg.mimpid;
     ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
     if (ret != 0) {
@@ -976,7 +962,7 @@ static void kvm_riscv_init_misa_ext_mask(RISCVCPU *cpu,
     struct kvm_one_reg reg;
     int ret;
 
-    reg.id = RISCV_CONFIG_REG(env, isa);
+    reg.id = RISCV_CONFIG_REG(isa);
     reg.addr = (uint64_t)&env->misa_ext_mask;
     ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
 
@@ -993,11 +979,10 @@ static void kvm_riscv_init_misa_ext_mask(RISCVCPU *cpu,
 static void kvm_riscv_read_cbomz_blksize(RISCVCPU *cpu, KVMScratchCPU *kvmcpu,
                                          KVMCPUConfig *cbomz_cfg)
 {
-    CPURISCVState *env = &cpu->env;
     struct kvm_one_reg reg;
     int ret;
 
-    reg.id = kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CONFIG,
+    reg.id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CONFIG,
                                     cbomz_cfg->kvm_reg_id);
     reg.addr = (uint64_t)kvmconfig_get_cfg_addr(cpu, cbomz_cfg);
     ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
@@ -1011,7 +996,6 @@ static void kvm_riscv_read_cbomz_blksize(RISCVCPU *cpu, KVMScratchCPU *kvmcpu,
 static void kvm_riscv_read_multiext_legacy(RISCVCPU *cpu,
                                            KVMScratchCPU *kvmcpu)
 {
-    CPURISCVState *env = &cpu->env;
     uint64_t val;
     int i, ret;
 
@@ -1019,7 +1003,7 @@ static void kvm_riscv_read_multiext_legacy(RISCVCPU *cpu,
         KVMCPUConfig *multi_ext_cfg = &kvm_multi_ext_cfgs[i];
         struct kvm_one_reg reg;
 
-        reg.id = kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_ISA_EXT,
+        reg.id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_ISA_EXT,
                                         multi_ext_cfg->kvm_reg_id);
         reg.addr = (uint64_t)&val;
         ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
@@ -1151,7 +1135,7 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
 
     for (i = 0; i < ARRAY_SIZE(kvm_multi_ext_cfgs); i++) {
         multi_ext_cfg = &kvm_multi_ext_cfgs[i];
-        reg_id = kvm_riscv_reg_id_ulong(&cpu->env, KVM_REG_RISCV_ISA_EXT,
+        reg_id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_ISA_EXT,
                                         multi_ext_cfg->kvm_reg_id);
         reg_search = bsearch(&reg_id, reglist->reg, reglist->n,
                              sizeof(uint64_t), uint64_cmp);
@@ -1330,12 +1314,11 @@ void kvm_arch_init_irq_routing(KVMState *s)
 
 static int kvm_vcpu_set_machine_ids(RISCVCPU *cpu, CPUState *cs)
 {
-    CPURISCVState *env = &cpu->env;
     target_ulong reg;
     uint64_t id;
     int ret;
 
-    id = RISCV_CONFIG_REG(env, mvendorid);
+    id = RISCV_CONFIG_REG(mvendorid);
     /*
      * cfg.mvendorid is an uint32 but a target_ulong will
      * be written. Assign it to a target_ulong var to avoid
@@ -1347,13 +1330,13 @@ static int kvm_vcpu_set_machine_ids(RISCVCPU *cpu, CPUState *cs)
         return ret;
     }
 
-    id = RISCV_CONFIG_REG(env, marchid);
+    id = RISCV_CONFIG_REG(marchid);
     ret = kvm_set_one_reg(cs, id, &cpu->cfg.marchid);
     if (ret != 0) {
         return ret;
     }
 
-    id = RISCV_CONFIG_REG(env, mimpid);
+    id = RISCV_CONFIG_REG(mimpid);
     ret = kvm_set_one_reg(cs, id, &cpu->cfg.mimpid);
 
     return ret;
@@ -1909,7 +1892,7 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     if (cpu->cfg.ext_zicbom &&
         riscv_cpu_option_set(kvm_cbom_blocksize.name)) {
 
-        reg.id = kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CONFIG,
+        reg.id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CONFIG,
                                         kvm_cbom_blocksize.kvm_reg_id);
         reg.addr = (uint64_t)&val;
         ret = ioctl(kvmcpu.cpufd, KVM_GET_ONE_REG, &reg);
@@ -1928,7 +1911,7 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     if (cpu->cfg.ext_zicboz &&
         riscv_cpu_option_set(kvm_cboz_blocksize.name)) {
 
-        reg.id = kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CONFIG,
+        reg.id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CONFIG,
                                         kvm_cboz_blocksize.kvm_reg_id);
         reg.addr = (uint64_t)&val;
         ret = ioctl(kvmcpu.cpufd, KVM_GET_ONE_REG, &reg);
-- 
2.39.5


