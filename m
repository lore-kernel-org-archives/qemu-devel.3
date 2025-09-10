Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE44BCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 09:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwHFR-0003t9-4e; Wed, 10 Sep 2025 05:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xb@ultrarisc.com>)
 id 1uwHFM-0003pj-1v; Wed, 10 Sep 2025 05:36:12 -0400
Received: from [218.76.62.146] (helo=ultrarisc.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xb@ultrarisc.com>)
 id 1uwHFC-0007iI-Jv; Wed, 10 Sep 2025 05:36:11 -0400
Received: from ur-dp1000.. (unknown [192.168.100.1])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAfwDnYNCsRsFo_7ssAA--.43755S3; 
 Wed, 10 Sep 2025 17:36:53 +0800 (CST)
From: Xie Bo <xb@ultrarisc.com>
To: qemu-devel@nongnu.org
Cc: ajones@ventanamicro.com, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 anup@brainfault.org, alistair.francis@wdc.com, rkrcmar@ventanamicro.com,
 palmer@dabbelt.com, xiamy@ultrarisc.com, Xie Bo <xb@ultrarisc.com>
Subject: [PATCH v6 1/2] Set KVM initial privilege mode and mp_state
Date: Wed, 10 Sep 2025 17:35:27 +0800
Message-ID: <20250910093529.614305-2-xb@ultrarisc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910093529.614305-1-xb@ultrarisc.com>
References: <20250910093529.614305-1-xb@ultrarisc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDnYNCsRsFo_7ssAA--.43755S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4UJr15AFy3ZF45AFy7ZFb_yoW5Jw4xpF
 4kCw4akrZ5Xa97Jw4fJrykWr18uw4kGr4UCw4xArWxAFs8ArWYgF4ktryUCFyDWFW5AryI
 9as8Ar1rAa1UZ3JanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUlY14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
 x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
 ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2kK
 e7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
 80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCj
 c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YV
 CY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE-syl42xK82IYc2Ij
 64vIr41l4c8EcI0En4kS14v26r126r1DMxAqzxv26xkF7I0En4kS14v26r4a6rW5MxC20s
 026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
 JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
 v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
 j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
 W8JrUvcSsGvfC2KfnxnUUI43ZEXa7sR_zuWtUUUUU==
X-CM-SenderInfo: l0e63zxwud2x1vfou0bp/1tbiAQABB2jA1vAAIQAAso
X-Host-Lookup-Failed: Reverse DNS lookup failed for 218.76.62.146 (failed)
Received-SPF: pass client-ip=218.76.62.146; envelope-from=xb@ultrarisc.com;
 helo=ultrarisc.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

For KVM mode, the privilege mode should not include M-mode, and the 
initial value should be set to S-mode. Additionally, a following patch 
adds the implementation of putting the vCPU privilege mode to KVM. 
When the vCPU runs for the first time, QEMU will first put the privilege 
state to KVM. If the initial value is set to M-mode, KVM will encounter
an error.

In addition, this patch introduces the 'mp_state' field to RISC-V 
vCPUs, following the convention used by KVM on x86. The 'mp_state' 
reflects the multiprocessor state of a vCPU, and is used to control 
whether the vCPU is runnable by KVM. Randomly select one CPU as the 
boot CPU.

Signed-off-by: Xie Bo <xb@ultrarisc.com>
---
 target/riscv/cpu.c | 17 ++++++++++++++++-
 target/riscv/cpu.h |  2 ++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 09ded6829a..57b8c421bd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -38,6 +38,7 @@
 #include "kvm/kvm_riscv.h"
 #include "tcg/tcg-cpu.h"
 #include "tcg/tcg.h"
+#include "hw/boards.h"
 
 /* RISC-V CPU definitions */
 static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
@@ -1031,18 +1032,32 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 #ifndef CONFIG_USER_ONLY
     uint8_t iprio;
     int i, irq, rdzero;
+    static int boot_cpu_index = -1;
 #endif
     CPUState *cs = CPU(obj);
     RISCVCPU *cpu = RISCV_CPU(cs);
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(obj);
     CPURISCVState *env = &cpu->env;
+    MachineState *ms = MACHINE(qdev_get_machine());
 
     if (mcc->parent_phases.hold) {
         mcc->parent_phases.hold(obj, type);
     }
 #ifndef CONFIG_USER_ONLY
     env->misa_mxl = mcc->misa_mxl_max;
-    env->priv = PRV_M;
+    if (kvm_enabled()) {
+        env->priv = PRV_S;
+    } else {
+        env->priv = PRV_M;
+    }
+    if (boot_cpu_index < 0) {
+        boot_cpu_index = g_random_int() % ms->smp.cpus;
+    }
+    if (cs->cpu_index == boot_cpu_index) {
+        env->mp_state = KVM_MP_STATE_RUNNABLE;
+    } else {
+        env->mp_state = KVM_MP_STATE_STOPPED;
+    }
     env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
     if (env->misa_mxl > MXL_RV32) {
         /*
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 51e49e03de..4b1c5bf0e4 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -256,6 +256,8 @@ struct CPUArchState {
 #endif
 
     target_ulong priv;
+    /* Current multiprocessor state of this vCPU. */
+    uint32_t mp_state;
     /* CSRs for execution environment configuration */
     uint64_t menvcfg;
     target_ulong senvcfg;
-- 
2.43.0


