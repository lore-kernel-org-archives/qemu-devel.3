Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0402A606A33B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmvS-0002rp-N5; Fri, 13 Nov 2026 03:46:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xRmvQ-0002qQ-UR
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:25 -0500
Received: from [2a14:640:1:12b5::1] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xRmvO-0007Qv-RD
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:24 -0500
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id C04691DD;
 Fri, 13 Nov 2026 14:16:20 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v6 07/26] target/loongarch: add LVZ guest interrupt state
Date: Fri, 13 Nov 2026 16:45:22 +0800
Message-ID: <015462504acdaaa48e6af38ac3bd1825c936f317.1794558695.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794558695.git.prcups@krgm.moe>
References: <cover.1794558695.git.prcups@krgm.moe>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2a14:640:1:12b5::1 (failed)
Received-SPF: pass client-ip=2a14:640:1:12b5::1; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Route configured hardware interrupts into the guest CSR bank, track guest
interrupt requests separately, and expose guest pending and enable checks
to the TCG runtime.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu.c            | 32 +++++++++++++++++++--------
 target/loongarch/cpu.h            |  3 +++
 target/loongarch/internals.h      |  4 ++--
 target/loongarch/tcg/csr_helper.c |  2 +-
 target/loongarch/tcg/tcg_cpu.c    | 36 ++++++++++++++++++++++---------
 5 files changed, 55 insertions(+), 22 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index fc432cfda0..20209c1bfc 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -58,16 +58,20 @@ static vaddr loongarch_cpu_get_pc(CPUState *cs)
 #ifndef CONFIG_USER_ONLY
 #include "hw/loongarch/virt.h"
 
-void loongarch_cpu_update_irq(LoongArchCPU *cpu)
+void loongarch_cpu_update_irq(LoongArchCPU *cpu, int vm_level)
 {
     CPULoongArchState *env = &cpu->env;
     CPUState *cs = CPU(cpu);
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
+    int interrupt = vm_level ? CPU_INTERRUPT_GUEST : CPU_INTERRUPT_HARD;
 
+    if (vm_level == VM_LEVEL1 && env_vm_level(env) != VM_LEVEL1) {
+        return;
+    }
     if (FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS)) {
-        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+        cpu_interrupt(cs, interrupt);
     } else {
-        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+        cpu_reset_interrupt(cs, interrupt);
     }
 }
 
@@ -75,13 +79,19 @@ static void loongarch_cpu_self_set_irq(CPUState *cs, run_on_cpu_data data)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(cs);
     CPULoongArchState *env = cpu_env(cs);
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys;
+    int vm_level = 0;
     int irq, level;
 
     irq = data.host_int & ~BIT(31);
     level = (data.host_int >> 31) & 1;
+    if (irq >= N_IRQS) {
+        irq -= N_IRQS;
+        vm_level = 1;
+    }
+    sys = get_sys(env, vm_level);
     sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, irq, 1, level != 0);
-    loongarch_cpu_update_irq(cpu);
+    loongarch_cpu_update_irq(cpu, vm_level);
 }
 
 void loongarch_cpu_set_irq(void *opaque, int irq, int level)
@@ -104,11 +114,11 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
 }
 
 /* Check if there is pending and not masked out interrupt */
-bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
+bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env, int vm_level)
 {
     uint32_t pending;
     uint32_t status;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
 
     pending = FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS);
     status  = FIELD_EX64(sys->CSR_ECFG, CSR_ECFG, LIE);
@@ -123,7 +133,11 @@ static bool loongarch_cpu_has_work(CPUState *cs)
     bool has_work = false;
 
     if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
-        cpu_loongarch_hw_interrupts_pending(cpu_env(cs))) {
+        cpu_loongarch_hw_interrupts_pending(cpu_env(cs), VM_LEVEL0)) {
+        has_work = true;
+    }
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_GUEST) &&
+        cpu_loongarch_hw_interrupts_pending(cpu_env(cs), VM_LEVEL1)) {
         has_work = true;
     }
 
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 14316fc9c5..22f2b0aa47 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -20,6 +20,8 @@
 #include "cpu-csr.h"
 #include "cpu-qom.h"
 
+#define CPU_INTERRUPT_GUEST CPU_INTERRUPT_TGT_EXT_0
+
 #define FCSR0_M1    0x1f         /* FCSR1 mask, Enables */
 #define FCSR0_M2    0x1f1f0000   /* FCSR2 mask, Cause and Flags */
 #define FCSR0_M3    0x300        /* FCSR3 mask, Round Mode */
@@ -242,6 +244,7 @@ extern const char * const fregnames[32];
 #define IRQ_TIMER   11
 #define IRQ_IPI     12
 #define INT_DMSI    14
+#define N_VIRQS     (N_IRQS * 2)
 
 #define MAX_PERF_EVENTS        16
 #define LOONGARCH_STLB         2048 /* 2048 STLB */
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index bc32bba7f7..616afd2e94 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -31,14 +31,14 @@ void restore_fp_status(CPULoongArchState *env);
 #ifndef CONFIG_USER_ONLY
 extern const VMStateDescription vmstate_loongarch_cpu;
 
-void loongarch_cpu_update_irq(LoongArchCPU *cpu);
+void loongarch_cpu_update_irq(LoongArchCPU *cpu, int vm_level);
 void loongarch_cpu_set_irq(void *opaque, int irq, int level);
 
 void cpu_loongarch_timer_cb(void *opaque);
 uint64_t cpu_loongarch_get_timer_counter(CPUTimerState *timer);
 uint64_t cpu_loongarch_get_timer_ticks(CPUTimerState *timer);
 void cpu_loongarch_set_timer_config(CPUTimerState *timer, uint64_t value);
-bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env);
+bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env, int vm_level);
 #endif /* !CONFIG_USER_ONLY */
 
 const char *loongarch_exception_name(int exception);
diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index 7cba8035df..e0fcac8da8 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -111,7 +111,7 @@ target_ulong HELPER(csrwr_estat)(CPULoongArchState *env, target_ulong val)
      */
     if (sys->CSR_ESTAT != old_v) {
         bql_lock();
-        loongarch_cpu_update_irq(env_archcpu(env));
+        loongarch_cpu_update_irq(env_archcpu(env), false);
         bql_unlock();
     }
 
diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 7babc1a1f9..8765bda0d1 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -198,10 +198,10 @@ static void loongarch_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
     }
 }
 
-static inline bool cpu_loongarch_hw_interrupts_enabled(CPULoongArchState *env)
+static inline bool cpu_loongarch_hw_interrupts_enabled(CPULoongArchState *env, int vm_level)
 {
     bool ret = 0;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
 
     ret = (FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, IE) &&
           !(FIELD_EX64(sys->CSR_DBG, CSR_DBG, DST)));
@@ -211,17 +211,33 @@ static inline bool cpu_loongarch_hw_interrupts_enabled(CPULoongArchState *env)
 
 static bool loongarch_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
+    CPULoongArchState *env = cpu_env(cs);
+    bool has_interrupt = false;
+
     if (interrupt_request & CPU_INTERRUPT_HARD) {
-        CPULoongArchState *env = cpu_env(cs);
-
-        if (cpu_loongarch_hw_interrupts_enabled(env) &&
-            cpu_loongarch_hw_interrupts_pending(env)) {
-            /* Raise it */
-            cs->exception_index = EXCCODE_INT;
-            loongarch_cpu_do_interrupt(cs);
-            return true;
+
+        if (cpu_loongarch_hw_interrupts_enabled(env, VM_LEVEL0) &&
+            cpu_loongarch_hw_interrupts_pending(env, VM_LEVEL0)) {
+            if (env_vm_level(env) != VM_LEVEL0) {
+                trigger_vm_exit(env);
+            }
+            has_interrupt = true;
         }
+    } else if (interrupt_request & CPU_INTERRUPT_GUEST) {
+        if (cpu_loongarch_hw_interrupts_enabled(env, VM_LEVEL1) &&
+            cpu_loongarch_hw_interrupts_pending(env, VM_LEVEL1) &&
+            env_vm_level(env) == VM_LEVEL1) {
+            has_interrupt = true;
+        }
+    }
+
+    if (has_interrupt) {
+        /* Raise it */
+        cs->exception_index = EXCCODE_INT;
+        loongarch_cpu_do_interrupt(cs);
+        return true;
     }
+
     return false;
 }
 
-- 
2.56.0


