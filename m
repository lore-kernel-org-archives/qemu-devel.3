Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E08C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 08:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9KIV-00074k-7k; Mon, 28 Apr 2025 04:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mengzhuo@iscas.ac.cn>)
 id 1u9KIK-0006v0-Ta; Mon, 28 Apr 2025 04:56:57 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mengzhuo@iscas.ac.cn>)
 id 1u9KIB-0006kd-8D; Mon, 28 Apr 2025 04:56:51 -0400
Received: from iscas.ac.cn (unknown [180.136.146.38])
 by APP-01 (Coremail) with SMTP id qwCowAAHsQHAQg9olVHqDA--.21979S2;
 Mon, 28 Apr 2025 16:56:34 +0800 (CST)
From: Meng Zhuo <mengzhuo@iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Meng Zhuo <mengzhuo@iscas.ac.cn>
Subject: [PATCH v2] target/riscv/kvm: add satp mode for host cpu
Date: Mon, 28 Apr 2025 16:56:32 +0800
Message-Id: <20250428085632.3102-1-mengzhuo@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAAHsQHAQg9olVHqDA--.21979S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4UXr18Kry8Kw15XFy3twb_yoW5WF4Upr
 W5G398CrW3JFZrJayfJr1kXF45Jws5Kr4aka1xCr13Xan8trW5WF1vg3W7AF98GF48AF13
 u3W0yrW7CF48tFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
 JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
 AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
 rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
 v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
 JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUBVbkUUU
 UU=
X-Originating-IP: [180.136.146.38]
X-CM-SenderInfo: pphqw6xkxrqxpvfd2hldfou0/1tbiDAUGEmgPGOBFCQABsP
Received-SPF: pass client-ip=159.226.251.21; envelope-from=mengzhuo@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2931
Signed-off-by: Meng Zhuo <mengzhuo@iscas.ac.cn>
---
 target/riscv/cpu.c         |  3 +--
 target/riscv/cpu.h         |  1 +
 target/riscv/kvm/kvm-cpu.c | 20 +++++++++++++++++++-
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2b830b3317..98f78886e6 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -434,8 +434,7 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit)
     g_assert_not_reached();
 }
 
-static void set_satp_mode_max_supported(RISCVCPU *cpu,
-                                        uint8_t satp_mode)
+void set_satp_mode_max_supported(RISCVCPU *cpu, uint8_t satp_mode)
 {
     bool rv32 = riscv_cpu_mxl(&cpu->env) == MXL_RV32;
     const bool *valid_vm = rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 167909c89b..44318d2e97 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -916,6 +916,7 @@ char *riscv_cpu_get_name(RISCVCPU *cpu);
 
 void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
 void riscv_add_satp_mode_properties(Object *obj);
+void set_satp_mode_max_supported(RISCVCPU *cpu, uint8_t satp_mode);
 bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
 
 /* CSR function table */
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 5315134e08..8f465119f5 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -953,6 +953,23 @@ static void kvm_riscv_destroy_scratch_vcpu(KVMScratchCPU *scratch)
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
     CPURISCVState *env = &cpu->env;
@@ -1212,6 +1229,7 @@ static void riscv_init_kvm_registers(Object *cpu_obj)
     kvm_riscv_init_machine_ids(cpu, &kvmcpu);
     kvm_riscv_init_misa_ext_mask(cpu, &kvmcpu);
     kvm_riscv_init_multiext_cfg(cpu, &kvmcpu);
+    kvm_riscv_init_satp_mode(cpu, &kvmcpu);
 
     kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
 }
@@ -1891,7 +1909,7 @@ static bool kvm_cpu_realize(CPUState *cs, Error **errp)
         }
     }
 
-   return true;
+    return true;
 }
 
 void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
-- 
2.39.5


