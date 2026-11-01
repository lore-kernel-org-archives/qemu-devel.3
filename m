Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E558606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 03:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNM3J-00039b-A8; Sat, 31 Oct 2026 23:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xNM3C-00035D-Rm; Sat, 31 Oct 2026 23:16:06 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xNM39-0000KA-D4; Sat, 31 Oct 2026 23:16:06 -0400
Received: from k3-03 (unknown [159.226.43.8])
 by APP-03 (Coremail) with SMTP id rQCowAAXJ5jlruZqSD4aAA--.22476S6;
 Sun, 01 Nov 2026 11:15:57 +0800 (CST)
From: Tan Chi <tanchi25@mails.ucas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, Tan Chi <tanchi25@mails.ucas.ac.cn>
Subject: [PATCH 4/5] hw/riscv: Pass socket topology to KVM AIA
Date: Sun,  1 Nov 2026 11:15:46 +0800
Message-ID: <20261101031547.125591-5-tanchi25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101031547.125591-1-tanchi25@mails.ucas.ac.cn>
References: <20261101031547.125591-1-tanchi25@mails.ucas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAXJ5jlruZqSD4aAA--.22476S6
X-Coremail-Antispam: 1UD129KBjvJXoW3JF1UCw4ftr17JF1DXF4DCFg_yoW7Aw43pF
 WrGrsrArWrtFyxXrs3ta1kXF18Jw4jka13J348Xr40yanxKrWru3yq93yjyF1DGFWkAr1Y
 vF18Cr42y3WSqr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUHS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
 4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4U
 JVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64
 xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j
 6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI
 8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK
 67AK6r48MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
 AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
 c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
 AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
 Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjahF3
 UUUUU==
X-CM-SenderInfo: pwdquxrlsvqzpdlo2hpxfd2hldfou0/
Received-SPF: pass client-ip=159.226.251.81;
 envelope-from=tanchi25@mails.ucas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

KVM AIA initialization uses the RISC-V NUMA helpers to query
the socket count and per-socket hart topology.

However, KVM support can be enabled without CONFIG_RISCV_NUMA.
In this configuration, kvm-cpu.c is built while numa.c is not,
resulting in undefined references to riscv_socket_count(),
riscv_socket_hart_count() and riscv_socket_first_hartid().

The virt machine already determines the hart topology when
initializing its hart arrays. Pass the socket topology directly
to KVM AIA instead of querying the NUMA helpers again.

This removes the build-time dependency on CONFIG_RISCV_NUMA
without changing the IMSIC address configuration.

Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
---
 hw/riscv/aia.h               |  5 +++++
 hw/riscv/virt.c              | 10 +++++++++-
 target/riscv/kvm/kvm-cpu.c   | 10 +++++-----
 target/riscv/kvm/kvm-stub.c  |  3 ++-
 target/riscv/kvm/kvm_riscv.h |  5 ++++-
 5 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
index e4dcc5aae0..ed9b613f3c 100644
--- a/hw/riscv/aia.h
+++ b/hw/riscv/aia.h
@@ -12,6 +12,11 @@
 #include "exec/hwaddr.h"
 #include "qemu/bitops.h"
 
+typedef struct RISCVAIASocket {
+    uint32_t hartid_base;
+    uint32_t num_harts;
+} RISCVAIASocket;
+
 static inline uint32_t imsic_num_bits(uint32_t count)
 {
     uint32_t ret = 0;
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 7ec7596b24..f1b1353647 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -853,7 +853,15 @@ static void virt_machine_init(MachineState *machine)
     }
 
     if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) {
-        kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
+        g_autofree RISCVAIASocket *aia_sockets =
+                g_new(RISCVAIASocket, socket_count);
+        for (i = 0; i < socket_count; i++) {
+            aia_sockets[i].hartid_base = s->soc[i].hartid_base;
+            aia_sockets[i].num_harts = s->soc[i].num_harts;
+        }
+
+        kvm_riscv_aia_create(aia_sockets, socket_count,
+                             IMSIC_MMIO_GROUP_MIN_SHIFT,
                              VIRT_IRQCHIP_NUM_SOURCES, VIRT_IRQCHIP_NUM_MSIS,
                              s->memmap[VIRT_APLIC_S].base,
                              s->memmap[VIRT_IMSIC_S].base,
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 45ad5e1525..1a74b9a37e 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -46,7 +46,7 @@
 #include "sbi_ecall_interface.h"
 #include "chardev/char-fe.h"
 #include "system/runstate.h"
-#include "hw/riscv/numa.h"
+#include "hw/riscv/aia.h"
 
 #define PR_RISCV_V_SET_CONTROL            69
 #define PR_RISCV_V_VSTATE_CTRL_ON          2
@@ -1897,7 +1897,8 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
                                     "auto");
 }
 
-void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
+void kvm_riscv_aia_create(const RISCVAIASocket *sockets,
+                          uint32_t socket_count, uint64_t group_shift,
                           uint64_t aia_irq_num, uint64_t aia_msi_num,
                           uint64_t aplic_base, uint64_t imsic_base,
                           uint64_t guest_num)
@@ -1905,7 +1906,6 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
     int ret, i;
     int aia_fd = -1;
     uint64_t default_aia_mode;
-    uint64_t socket_count = riscv_socket_count(machine);
     uint64_t max_hart_per_socket = 0;
     uint64_t socket, base_hart, hart_count, socket_imsic_base, imsic_addr;
     uint64_t socket_bits, hart_bits, guest_bits;
@@ -2006,8 +2006,8 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
 
     for (socket = 0; socket < socket_count; socket++) {
         socket_imsic_base = imsic_base + socket * (1U << group_shift);
-        hart_count = riscv_socket_hart_count(machine, socket);
-        base_hart = riscv_socket_first_hartid(machine, socket);
+        hart_count = sockets[socket].num_harts;
+        base_hart = sockets[socket].hartid_base;
 
         if (max_hart_per_socket < hart_count) {
             max_hart_per_socket = hart_count;
diff --git a/target/riscv/kvm/kvm-stub.c b/target/riscv/kvm/kvm-stub.c
index 64e39c96d8..f929161628 100644
--- a/target/riscv/kvm/kvm-stub.c
+++ b/target/riscv/kvm/kvm-stub.c
@@ -9,7 +9,8 @@
 #include "qemu/osdep.h"
 #include "target/riscv/kvm/kvm_riscv.h"
 
-void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
+void kvm_riscv_aia_create(const RISCVAIASocket *sockets,
+                          uint32_t socket_count, uint64_t group_shift,
                           uint64_t aia_irq_num, uint64_t aia_msi_num,
                           uint64_t aplic_base, uint64_t imsic_base,
                           uint64_t guest_num)
diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
index aef681f0a2..bad78e28f4 100644
--- a/target/riscv/kvm/kvm_riscv.h
+++ b/target/riscv/kvm/kvm_riscv.h
@@ -21,6 +21,8 @@
 
 #include "target/riscv/cpu-qom.h"
 
+typedef struct RISCVAIASocket RISCVAIASocket;
+
 void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
 /**
  * kvm_riscv_set_irq:
@@ -29,7 +31,8 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
  * @level: %0 to clear the interrupt, non-zero to set it.
  */
 void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
-void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
+void kvm_riscv_aia_create(const RISCVAIASocket *sockets,
+                          uint32_t socket_count, uint64_t group_shift,
                           uint64_t aia_irq_num, uint64_t aia_msi_num,
                           uint64_t aplic_base, uint64_t imsic_base,
                           uint64_t guest_num);
-- 
2.53.0


