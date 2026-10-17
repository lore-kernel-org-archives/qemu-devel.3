Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98426CCF2C1
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 14:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI5nH-0004wi-6B; Sat, 17 Oct 2026 10:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xI5ma-0004ql-73; Sat, 17 Oct 2026 10:53:13 -0400
Received: from mxhk.zte.com.cn ([160.30.148.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xI5mX-0006fr-4m; Sat, 17 Oct 2026 10:53:11 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4j6Pth4LPJz8Xrkn;
 Sat, 17 Oct 2026 22:53:00 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
 by mse-fl2.zte.com.cn with SMTP id 69HEqqa3033850;
 Sat, 17 Oct 2026 22:52:52 +0800 (+08)
 (envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
 by smtp (Zmail) with SMTP; Sat, 17 Oct 2026 22:52:55 +0800
X-Zmail-TransId: 3e816ad38bc7024-fb159
X-Zmail-LocalSMTP: 1
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
X-Zmail-RealSender: wang.yechao255@zte.com.cn
From: Wang Yechao <wang.yechao255@zte.com.cn>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Wang Yechao <wang.yechao255@zte.com.cn>
Subject: [PATCH 2/3] target/riscv/kvm: Sync SBI STA shmem registers with KVM
Date: Sat, 17 Oct 2026 22:51:46 +0800
Message-ID: <20261017145211.219258-3-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20261017145211.219258-1-wang.yechao255@zte.com.cn>
References: <20261017145211.219258-1-wang.yechao255@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl2.zte.com.cn 69HEqqa3033850
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 17 Oct 2026 22:53:00 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AD38BCC.000/4j6Pth4LPJz8Xrkn
Received-SPF: pass client-ip=160.30.148.35;
 envelope-from=wang.yechao255@zte.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now that SBI STA support is detected, synchronize the shared memory
address (shmem_lo and shmem_hi) between KVM and QEMU using the
KVM_REG_RISCV_SBI_STA one-reg interface.

The shmem address is configured by the guest, so QEMU does not
need to perform put reg operations during reset.

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 target/riscv/cpu.h         |  6 +++
 target/riscv/kvm/kvm-cpu.c | 97 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b65d631994..4da7963d3d 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -34,6 +34,9 @@
 #include "cpu_cfg.h"
 #include "qapi/qapi-types-common.h"
 #include "cpu-qom.h"
+#ifdef CONFIG_KVM
+#include <linux/kvm.h>
+#endif
 
 typedef struct CPUArchState CPURISCVState;
 
@@ -550,6 +553,9 @@ struct CPUArchState {
     /* KVM multiprocessor state */
     uint32_t kvm_mp_state;
     bool kvm_mp_state_loaded;
+
+    /* kvm sbi state */
+    struct kvm_riscv_sbi_sta kvm_sbi_sta;
 #endif /* CONFIG_KVM */
 };
 
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 8ab43432dd..ba5ba63854 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -123,6 +123,11 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
     KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_VECTOR, \
                            KVM_REG_RISCV_VECTOR_CSR_REG(name))
 
+#define RISCV_SBI_STA_REG(name) \
+    KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_SBI_STATE, \
+                           KVM_REG_RISCV_SBI_STA | \
+                           KVM_REG_RISCV_SBI_STA_REG(name))
+
 #define KVM_RISCV_GET_TIMER(cs, name, reg) \
     do { \
         int ret = kvm_get_one_reg(cs, RISCV_TIMER_REG(name), &reg); \
@@ -1010,6 +1015,88 @@ static int kvm_riscv_put_regs_vector(CPUState *cs)
     return ret;
 }
 
+static int kvm_riscv_get_regs_sbi_sta(CPUState *cs)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+    target_ulong reg;
+    int ret = 0;
+
+    if (!kvm_sbi_sta.supported) {
+        return 0;
+    }
+
+    ret = kvm_get_one_reg(cs, RISCV_SBI_STA_REG(shmem_lo), &reg);
+    if (ret) {
+        return ret;
+    }
+    env->kvm_sbi_sta.shmem_lo = reg;
+
+    ret = kvm_get_one_reg(cs, RISCV_SBI_STA_REG(shmem_hi), &reg);
+    if (ret) {
+        return ret;
+    }
+    env->kvm_sbi_sta.shmem_hi = reg;
+
+    return ret;
+}
+
+static int kvm_riscv_get_regs_sbi_state(CPUState *cs)
+{
+    int ret = 0;
+
+    ret = kvm_riscv_get_regs_sbi_sta(cs);
+    if (ret) {
+        return ret;
+    }
+
+    return 0;
+}
+
+static int kvm_riscv_put_regs_sbi_sta(CPUState *cs)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+    target_ulong reg;
+    int ret = 0;
+
+    if (!kvm_sbi_sta.supported) {
+        return 0;
+    }
+
+    reg = env->kvm_sbi_sta.shmem_lo;
+    ret = kvm_set_one_reg(cs, RISCV_SBI_STA_REG(shmem_lo), &reg);
+    if (ret) {
+        return ret;
+    }
+
+    reg = env->kvm_sbi_sta.shmem_hi;
+    ret = kvm_set_one_reg(cs, RISCV_SBI_STA_REG(shmem_hi), &reg);
+    if (ret) {
+        return ret;
+    }
+
+    return ret;
+}
+
+static int kvm_riscv_put_regs_sbi_state(CPUState *cs, KvmPutState level)
+{
+    int ret = 0;
+
+    /*
+     * The shmem address of SBI STA is configured by the guest. During reset,
+     * QEMU does not need to perform put reg operations.
+     */
+    if (level != KVM_PUT_RESET_STATE) {
+        ret = kvm_riscv_put_regs_sbi_sta(cs);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    return ret;
+}
+
 typedef struct KVMScratchCPU {
     int kvmfd;
     int vmfd;
@@ -1433,6 +1520,11 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
         return ret;
     }
 
+    ret = kvm_riscv_get_regs_sbi_state(cs);
+    if (ret) {
+        return ret;
+    }
+
     if (cap_has_mp_state) {
         struct kvm_mp_state mp_state;
 
@@ -1520,6 +1612,11 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
         return ret;
     }
 
+    ret = kvm_riscv_put_regs_sbi_state(cs, level);
+    if (ret) {
+        return ret;
+    }
+
     if (KVM_PUT_RESET_STATE == level) {
         CPURISCVState *env = &RISCV_CPU(cs)->env;
 
-- 
2.27.0


