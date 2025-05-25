Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0410C54FB3
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 12:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJACW-0002Dk-Ey; Sun, 25 May 2025 08:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJABY-0007wq-C1; Sun, 25 May 2025 08:10:36 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJABV-0003p5-Vc; Sun, 25 May 2025 08:10:36 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 661D2124E62;
 Sun, 25 May 2025 15:08:18 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 73ADE215FC9;
 Sun, 25 May 2025 15:08:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.1 48/59] target/riscv/kvm: add kvm_csr_cfgs[]
Date: Sun, 25 May 2025 15:08:05 +0300
Message-Id: <20250525120818.273372-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-10.0.1-20250525112807@cover.tls.msk.ru>
References: <qemu-stable-10.0.1-20250525112807@cover.tls.msk.ru>
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

At this moment we're not checking if the host has support for any
specific CSR before doing get/put regs. This will cause problems if the
host KVM doesn't support it (see [1] as an example).

We'll use the same approach done with the CPU extensions: read all known
KVM CSRs during init() to check for availability, then read/write them
if they are present. This will be made by either using get-reglist or by
directly reading the CSRs.

For now we'll just convert the CSRs to use a kvm_csr_cfg[] array,
reusing the same KVMCPUConfig abstraction we use for extensions, and use
the array in (get|put)_csr_regs() instead of manually listing them. A
lot of boilerplate will be added but at least we'll automate the get/put
procedure for CSRs, i.e. adding a new CSR in the future will be a matter
of adding it in kvm_csr_regs[] and everything else will be taken care
of.

Despite all the code changes no behavioral change is made.

[1] https://lore.kernel.org/qemu-riscv/CABJz62OfUDHYkQ0T3rGHStQprf1c7_E0qBLbLKhfv=+jb0SYAw@mail.gmail.com/

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250429124421.223883-6-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
(cherry picked from commit d3b6f1742c36e3a3c1e74cb60646ee98a4e39ea3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 51e49e03de..7a56666f9a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -79,6 +79,7 @@ const char *riscv_get_misa_ext_name(uint32_t bit);
 const char *riscv_get_misa_ext_description(uint32_t bit);
 
 #define CPU_CFG_OFFSET(_prop) offsetof(struct RISCVCPUConfig, _prop)
+#define ENV_CSR_OFFSET(_csr) offsetof(CPURISCVState, _csr)
 
 typedef struct riscv_cpu_profile {
     struct riscv_cpu_profile *u_parent;
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 1afc4b729e..751494a8ec 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -114,22 +114,6 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
     KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_VECTOR, \
                            KVM_REG_RISCV_VECTOR_CSR_REG(name))
 
-#define KVM_RISCV_GET_CSR(cs, env, csr, reg) \
-    do { \
-        int _ret = kvm_get_one_reg(cs, RISCV_CSR_REG(csr), &reg); \
-        if (_ret) { \
-            return _ret; \
-        } \
-    } while (0)
-
-#define KVM_RISCV_SET_CSR(cs, env, csr, reg) \
-    do { \
-        int _ret = kvm_set_one_reg(cs, RISCV_CSR_REG(csr), &reg); \
-        if (_ret) { \
-            return _ret; \
-        } \
-    } while (0)
-
 #define KVM_RISCV_GET_TIMER(cs, name, reg) \
     do { \
         int ret = kvm_get_one_reg(cs, RISCV_TIMER_REG(name), &reg); \
@@ -251,6 +235,53 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
     }
 }
 
+#define KVM_CSR_CFG(_name, _env_prop, reg_id) \
+    {.name = _name, .offset = ENV_CSR_OFFSET(_env_prop), \
+     .kvm_reg_id = reg_id}
+
+static KVMCPUConfig kvm_csr_cfgs[] = {
+    KVM_CSR_CFG("sstatus",    mstatus,    RISCV_CSR_REG(sstatus)),
+    KVM_CSR_CFG("sie",        mie,        RISCV_CSR_REG(sie)),
+    KVM_CSR_CFG("stvec",      stvec,      RISCV_CSR_REG(stvec)),
+    KVM_CSR_CFG("sscratch",   sscratch,   RISCV_CSR_REG(sscratch)),
+    KVM_CSR_CFG("sepc",       sepc,       RISCV_CSR_REG(sepc)),
+    KVM_CSR_CFG("scause",     scause,     RISCV_CSR_REG(scause)),
+    KVM_CSR_CFG("stval",      stval,      RISCV_CSR_REG(stval)),
+    KVM_CSR_CFG("sip",        mip,        RISCV_CSR_REG(sip)),
+    KVM_CSR_CFG("satp",       satp,       RISCV_CSR_REG(satp)),
+};
+
+static void *kvmconfig_get_env_addr(RISCVCPU *cpu, KVMCPUConfig *csr_cfg)
+{
+    return (void *)&cpu->env + csr_cfg->offset;
+}
+
+static uint32_t kvm_cpu_csr_get_u32(RISCVCPU *cpu, KVMCPUConfig *csr_cfg)
+{
+    uint32_t *val32 = kvmconfig_get_env_addr(cpu, csr_cfg);
+    return *val32;
+}
+
+static uint64_t kvm_cpu_csr_get_u64(RISCVCPU *cpu, KVMCPUConfig *csr_cfg)
+{
+    uint64_t *val64 = kvmconfig_get_env_addr(cpu, csr_cfg);
+    return *val64;
+}
+
+static void kvm_cpu_csr_set_u32(RISCVCPU *cpu, KVMCPUConfig *csr_cfg,
+                                uint32_t val)
+{
+    uint32_t *val32 = kvmconfig_get_env_addr(cpu, csr_cfg);
+    *val32 = val;
+}
+
+static void kvm_cpu_csr_set_u64(RISCVCPU *cpu, KVMCPUConfig *csr_cfg,
+                                uint64_t val)
+{
+    uint64_t *val64 = kvmconfig_get_env_addr(cpu, csr_cfg);
+    *val64 = val;
+}
+
 #define KVM_EXT_CFG(_name, _prop, _reg_id) \
     {.name = _name, .offset = CPU_CFG_OFFSET(_prop), \
      .kvm_reg_id = _reg_id}
@@ -598,34 +629,52 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
 
 static int kvm_riscv_get_regs_csr(CPUState *cs)
 {
-    CPURISCVState *env = &RISCV_CPU(cs)->env;
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    uint64_t reg;
+    int i, ret;
+
+    for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
+        KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
 
-    KVM_RISCV_GET_CSR(cs, env, sstatus, env->mstatus);
-    KVM_RISCV_GET_CSR(cs, env, sie, env->mie);
-    KVM_RISCV_GET_CSR(cs, env, stvec, env->stvec);
-    KVM_RISCV_GET_CSR(cs, env, sscratch, env->sscratch);
-    KVM_RISCV_GET_CSR(cs, env, sepc, env->sepc);
-    KVM_RISCV_GET_CSR(cs, env, scause, env->scause);
-    KVM_RISCV_GET_CSR(cs, env, stval, env->stval);
-    KVM_RISCV_GET_CSR(cs, env, sip, env->mip);
-    KVM_RISCV_GET_CSR(cs, env, satp, env->satp);
+        ret = kvm_get_one_reg(cs, csr_cfg->kvm_reg_id, &reg);
+        if (ret) {
+            return ret;
+        }
+
+        if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint32_t)) {
+            kvm_cpu_csr_set_u32(cpu, csr_cfg, reg);
+        } else if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint64_t)) {
+            kvm_cpu_csr_set_u64(cpu, csr_cfg, reg);
+        } else {
+            g_assert_not_reached();
+        }
+    }
 
     return 0;
 }
 
 static int kvm_riscv_put_regs_csr(CPUState *cs)
 {
-    CPURISCVState *env = &RISCV_CPU(cs)->env;
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    uint64_t reg;
+    int i, ret;
+
+    for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
+        KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
+
+        if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint32_t)) {
+            reg = kvm_cpu_csr_get_u32(cpu, csr_cfg);
+        } else if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint64_t)) {
+            reg = kvm_cpu_csr_get_u64(cpu, csr_cfg);
+        } else {
+            g_assert_not_reached();
+        }
 
-    KVM_RISCV_SET_CSR(cs, env, sstatus, env->mstatus);
-    KVM_RISCV_SET_CSR(cs, env, sie, env->mie);
-    KVM_RISCV_SET_CSR(cs, env, stvec, env->stvec);
-    KVM_RISCV_SET_CSR(cs, env, sscratch, env->sscratch);
-    KVM_RISCV_SET_CSR(cs, env, sepc, env->sepc);
-    KVM_RISCV_SET_CSR(cs, env, scause, env->scause);
-    KVM_RISCV_SET_CSR(cs, env, stval, env->stval);
-    KVM_RISCV_SET_CSR(cs, env, sip, env->mip);
-    KVM_RISCV_SET_CSR(cs, env, satp, env->satp);
+        ret = kvm_set_one_reg(cs, csr_cfg->kvm_reg_id, &reg);
+        if (ret) {
+            return ret;
+        }
+    }
 
     return 0;
 }
-- 
2.39.5


