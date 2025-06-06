Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA81C5B549
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 03:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNO0H-0001Bz-4c; Thu, 05 Jun 2025 23:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mengzhuo@iscas.ac.cn>)
 id 1uNO0E-0001Bi-Ek; Thu, 05 Jun 2025 23:44:22 -0400
Received: from smtp84.cstnet.cn ([159.226.251.84] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mengzhuo@iscas.ac.cn>)
 id 1uNO09-00038l-N4; Thu, 05 Jun 2025 23:44:22 -0400
Received: from iscas.ac.cn (unknown [113.16.146.215])
 by APP-05 (Coremail) with SMTP id zQCowAAHUxH_Y0JoYzbmAw--.10740S2;
 Fri, 06 Jun 2025 11:44:00 +0800 (CST)
From: Meng Zhuo <mengzhuo@iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: Meng Zhuo <mengzhuo@iscas.ac.cn>, Andrew Jones <ajones@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH v6] target/riscv/kvm: add max_satp_mode from host cpu
Date: Fri,  6 Jun 2025 11:42:51 +0800
Message-Id: <20250606034250.181707-1-mengzhuo@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAHUxH_Y0JoYzbmAw--.10740S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1xZr48Jry7KF18ur4rKrg_yoW8Kw48pF
 W5GrZ5Crs3tryxJayftrn7XF15Krs5KFW7ta1jgw1xX3Z8JFW8Wr1vg3yaqF98XF4xZFs8
 AFsYyr4xCF4YqFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
 1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
 6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
 6r1q6r43MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
 kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
 67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
 CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
 MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvf
 C2KfnxnUUI43ZEXa7VUj8pnPUUUUU==
X-Originating-IP: [113.16.146.215]
X-CM-SenderInfo: pphqw6xkxrqxpvfd2hldfou0/1tbiCRAEEmhBD5iDLQABse
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

This patch adds max_satp_mode from host kvm cpu setting.

Tested on: Milkv Megrez (Eswin 7700x)

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2931
Signed-off-by: Meng Zhuo <mengzhuo@iscas.ac.cn>
---
Change in v6:
- Rebase on https://github.com/alistair23/qemu/tree/riscv-to-apply.next
- Minor change in title

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
---
 target/riscv/kvm/kvm-cpu.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index e1a04be20f..502d33f404 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -999,6 +999,19 @@ static void kvm_riscv_destroy_scratch_vcpu(KVMScratchCPU *scratch)
     close(scratch->kvmfd);
 }
 
+static void kvm_riscv_init_max_satp_mode(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
+{
+    struct kvm_one_reg reg;
+    int ret;
+
+    reg.id = RISCV_CONFIG_REG(satp_mode);
+    reg.addr = (uint64_t)&cpu->cfg.max_satp_mode;
+    ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
+    if (ret != 0) {
+        error_report("Unable to retrieve satp mode from host, error %d", ret);
+    }
+}
+
 static void kvm_riscv_init_machine_ids(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
 {
     struct kvm_one_reg reg;
@@ -1302,6 +1315,7 @@ static void riscv_init_kvm_registers(Object *cpu_obj)
     kvm_riscv_init_machine_ids(cpu, &kvmcpu);
     kvm_riscv_init_misa_ext_mask(cpu, &kvmcpu);
     kvm_riscv_init_cfg(cpu, &kvmcpu);
+    kvm_riscv_init_max_satp_mode(cpu, &kvmcpu);
 
     kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
 }
@@ -1985,7 +1999,7 @@ static bool kvm_cpu_realize(CPUState *cs, Error **errp)
         }
     }
 
-   return true;
+    return true;
 }
 
 void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
-- 
2.39.5


