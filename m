Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F25FC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 07:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJSif-0001rg-JF; Mon, 26 May 2025 03:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mengzhuo@iscas.ac.cn>)
 id 1uJSiX-0001oF-Is; Mon, 26 May 2025 03:57:53 -0400
Received: from smtp84.cstnet.cn ([159.226.251.84] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mengzhuo@iscas.ac.cn>)
 id 1uJSiQ-0001Fv-M5; Mon, 26 May 2025 03:57:52 -0400
Received: from iscas.ac.cn (unknown [180.140.173.24])
 by APP-05 (Coremail) with SMTP id zQCowABXpRPpHjRofekYAA--.12997S2;
 Mon, 26 May 2025 15:57:30 +0800 (CST)
From: Meng Zhuo <mengzhuo@iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: Meng Zhuo <mengzhuo@iscas.ac.cn>, Andrew Jones <ajones@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH v5] target/riscv/kvm: add satp mode for host cpu
Date: Mon, 26 May 2025 15:57:27 +0800
Message-Id: <20250526075727.105004-1-mengzhuo@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABXpRPpHjRofekYAA--.12997S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw15AF13tF1fCrWDWFWDXFb_yoW5KF4kpr
 W5GrZ5CrWftF9rJayxtr1kXF45Jws5Kr42ka1j9r17Xan8JrWUWF1kKa13CF98JF47AFnx
 A3WFkrW3CF40yFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
 tVW8ZwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
 v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
 1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
 AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
 42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
 VjvjDU0xZFpf9x0JU2oGQUUUUU=
X-Originating-IP: [180.140.173.24]
X-CM-SenderInfo: pphqw6xkxrqxpvfd2hldfou0/1tbiBwsOEmgz9QejzAAAsW
Received-SPF: pass client-ip=159.226.251.84; envelope-from=mengzhuo@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch adds host satp mode while kvm/host cpu satp mode is not
set.

This patch not change the output of errno nor errno strings pattern
like other functions do. See [v3] for further information.

Change in v5:
- Adds R-B comment from Andrew Jones

Change in v4:
- Adds changelog in commit message
- Link to v3: https://lists.nongnu.org/archive/html/qemu-devel/2025-05/msg04629.html

Change in v3:
- Rebase on https://github.com/alistair23/qemu/tree/riscv-to-apply.next
  as requested
- Link to v2: https://lists.nongnu.org/archive/html/qemu-devel/2025-04/msg05203.html

Changes in v2:
- use set_satp_mode_max_supported instead of hard code
- Link to v1: https://lists.nongnu.org/archive/html/qemu-devel/2025-04/msg05094.html

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2931
Signed-off-by: Meng Zhuo <mengzhuo@iscas.ac.cn>
---
 target/riscv/cpu.c         |  3 +--
 target/riscv/cpu.h         |  1 +
 target/riscv/kvm/kvm-cpu.c | 20 +++++++++++++++++++-
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d92874baa0..a84edd3a3b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -433,8 +433,7 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit)
     g_assert_not_reached();
 }
 
-static void set_satp_mode_max_supported(RISCVCPU *cpu,
-                                        uint8_t satp_mode)
+void set_satp_mode_max_supported(RISCVCPU *cpu, uint8_t satp_mode)
 {
     bool rv32 = riscv_cpu_mxl(&cpu->env) == MXL_RV32;
     const bool *valid_vm = rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b56d3afa69..d7136f1d72 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -915,6 +915,7 @@ char *riscv_cpu_get_name(RISCVCPU *cpu);
 
 void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
 void riscv_add_satp_mode_properties(Object *obj);
+void set_satp_mode_max_supported(RISCVCPU *cpu, uint8_t satp_mode);
 bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
 
 /* CSR function table */
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 82f9728636..18fbca1a08 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -999,6 +999,23 @@ static void kvm_riscv_destroy_scratch_vcpu(KVMScratchCPU *scratch)
     close(scratch->kvmfd);
 }
 
+static void kvm_riscv_init_satp_mode(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
+{
+    CPURISCVState *env = &cpu->env;
+    struct kvm_one_reg reg;
+    int ret;
+    uint64_t val;
+
+    reg.id = RISCV_CONFIG_REG(env, satp_mode);
+    reg.addr = (uint64_t)&val;
+    ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
+    if (ret != 0) {
+        error_report("Unable to retrieve satp from host, error %d", ret);
+    }
+
+    set_satp_mode_max_supported(cpu, val);
+}
+
 static void kvm_riscv_init_machine_ids(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
 {
     struct kvm_one_reg reg;
@@ -1302,6 +1319,7 @@ static void riscv_init_kvm_registers(Object *cpu_obj)
     kvm_riscv_init_machine_ids(cpu, &kvmcpu);
     kvm_riscv_init_misa_ext_mask(cpu, &kvmcpu);
     kvm_riscv_init_cfg(cpu, &kvmcpu);
+    kvm_riscv_init_satp_mode(cpu, &kvmcpu);
 
     kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
 }
@@ -1980,7 +1998,7 @@ static bool kvm_cpu_realize(CPUState *cs, Error **errp)
         }
     }
 
-   return true;
+    return true;
 }
 
 void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
-- 
2.39.5


