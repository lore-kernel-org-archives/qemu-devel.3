Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D8DC54E90
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 12:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJACL-0001Q2-1d; Sun, 25 May 2025 08:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJABd-0008C9-Jz; Sun, 25 May 2025 08:10:43 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJABZ-0003pZ-BF; Sun, 25 May 2025 08:10:41 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 70399124E63;
 Sun, 25 May 2025 15:08:18 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7D1AF215FCA;
 Sun, 25 May 2025 15:08:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrea Bolognani <abologna@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.1 49/59] target/riscv/kvm: do not read unavailable CSRs
Date: Sun, 25 May 2025 15:08:06 +0300
Message-Id: <20250525120818.273372-26-mjt@tls.msk.ru>
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

[1] reports that commit 4db19d5b21 broke a KVM guest running kernel 6.6.
This happens because the kernel does not know 'senvcfg', making it
unable to boot because QEMU is reading/wriiting it without any checks.

After converting the CSRs to do "automated" get/put reg procedures in
the previous patch we can now scan for availability. Two functions are
created:

- kvm_riscv_read_csr_cfg_legacy() will check if the CSR exists by brute
  forcing KVM_GET_ONE_REG in each one of them, interpreting an EINVAL
  return as indication that the CSR isn't available. This will be use in
  absence of KVM_GET_REG_LIST;

- kvm_riscv_read_csr_cfg() will use the existing result of get_reg_list
  to check if the CSRs ids are present.

kvm_riscv_init_multiext_cfg() is now kvm_riscv_init_cfg() to reflect that
the function is also dealing with CSRs.

[1] https://lore.kernel.org/qemu-riscv/CABJz62OfUDHYkQ0T3rGHStQprf1c7_E0qBLbLKhfv=+jb0SYAw@mail.gmail.com/

Fixes: 4db19d5b21 ("target/riscv/kvm: add missing KVM CSRs")
Reported-by: Andrea Bolognani <abologna@redhat.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250429124421.223883-7-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
(cherry picked from commit f396c217a53d9b7960dd002fbb07cfe1d46b27aa)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 751494a8ec..8001ca153e 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -636,6 +636,10 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
     for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
         KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
 
+        if (!csr_cfg->supported) {
+            continue;
+        }
+
         ret = kvm_get_one_reg(cs, csr_cfg->kvm_reg_id, &reg);
         if (ret) {
             return ret;
@@ -662,6 +666,10 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
     for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
         KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
 
+        if (!csr_cfg->supported) {
+            continue;
+        }
+
         if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint32_t)) {
             reg = kvm_cpu_csr_get_u32(cpu, csr_cfg);
         } else if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint64_t)) {
@@ -1090,6 +1098,32 @@ static void kvm_riscv_read_multiext_legacy(RISCVCPU *cpu,
     }
 }
 
+static void kvm_riscv_read_csr_cfg_legacy(KVMScratchCPU *kvmcpu)
+{
+    uint64_t val;
+    int i, ret;
+
+    for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
+        KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
+        struct kvm_one_reg reg;
+
+        reg.id = csr_cfg->kvm_reg_id;
+        reg.addr = (uint64_t)&val;
+        ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
+        if (ret != 0) {
+            if (errno == EINVAL) {
+                csr_cfg->supported = false;
+            } else {
+                error_report("Unable to read KVM CSR %s: %s",
+                             csr_cfg->name, strerror(errno));
+                exit(EXIT_FAILURE);
+            }
+        } else {
+            csr_cfg->supported = true;
+        }
+    }
+}
+
 static int uint64_cmp(const void *a, const void *b)
 {
     uint64_t val1 = *(const uint64_t *)a;
@@ -1146,7 +1180,26 @@ static void kvm_riscv_read_vlenb(RISCVCPU *cpu, KVMScratchCPU *kvmcpu,
     }
 }
 
-static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
+static void kvm_riscv_read_csr_cfg(struct kvm_reg_list *reglist)
+{
+    struct kvm_reg_list *reg_search;
+    uint64_t reg_id;
+
+    for (int i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
+        KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
+
+        reg_id = csr_cfg->kvm_reg_id;
+        reg_search = bsearch(&reg_id, reglist->reg, reglist->n,
+                             sizeof(uint64_t), uint64_cmp);
+        if (!reg_search) {
+            continue;
+        }
+
+        csr_cfg->supported = true;
+    }
+}
+
+static void kvm_riscv_init_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
 {
     g_autofree struct kvm_reg_list *reglist = NULL;
     KVMCPUConfig *multi_ext_cfg;
@@ -1163,7 +1216,9 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
      * (EINVAL). Use read_legacy() in this case.
      */
     if (errno == EINVAL) {
-        return kvm_riscv_read_multiext_legacy(cpu, kvmcpu);
+        kvm_riscv_read_multiext_legacy(cpu, kvmcpu);
+        kvm_riscv_read_csr_cfg_legacy(kvmcpu);
+        return;
     } else if (errno != E2BIG) {
         /*
          * E2BIG is an expected error message for the API since we
@@ -1226,6 +1281,7 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
     }
 
     kvm_riscv_check_sbi_dbcn_support(cpu, reglist);
+    kvm_riscv_read_csr_cfg(reglist);
 }
 
 static void riscv_init_kvm_registers(Object *cpu_obj)
@@ -1239,7 +1295,7 @@ static void riscv_init_kvm_registers(Object *cpu_obj)
 
     kvm_riscv_init_machine_ids(cpu, &kvmcpu);
     kvm_riscv_init_misa_ext_mask(cpu, &kvmcpu);
-    kvm_riscv_init_multiext_cfg(cpu, &kvmcpu);
+    kvm_riscv_init_cfg(cpu, &kvmcpu);
 
     kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
 }
-- 
2.39.5


