Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4563BC61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 10:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzAul-00021X-Lh; Wed, 26 Aug 2026 06:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1wzAuO-0001ug-F6
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:31:04 -0400
Received: from [2a14:640:1:12b5::1] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1wzAuM-0003NH-FC
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:31:04 -0400
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id 59333DFA5;
 Wed, 26 Aug 2026 16:00:57 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, xianglai li <lixianglai@loongson.cn>,
 SignKirigami <prcups@krgm.moe>, Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v4 05/14] target/loongarch: Add LVZ guest interrupt state
Date: Wed, 26 Aug 2026 18:30:09 +0800
Message-ID: <32e816aa68489d4e6b0b2b24e99a6c8a4e3469bf.1787739852.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787739852.git.prcups@krgm.moe>
References: <cover.1787739852.git.prcups@krgm.moe>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Route configured hardware interrupts into the guest CSR bank, track guest
interrupt requests separately, and expose guest pending and enable checks
to the TCG runtime.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu.c         | 43 +++++++++++++++++++++++++---------
 target/loongarch/internals.h   |  4 +++-
 target/loongarch/tcg/tcg_cpu.c | 36 +++++++++++++++++++---------
 3 files changed, 60 insertions(+), 23 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index c5c7f3e0e3..b12e8944de 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -57,41 +57,57 @@ static vaddr loongarch_cpu_get_pc(CPUState *cs)
 #ifndef CONFIG_USER_ONLY
 #include "hw/loongarch/virt.h"
 
-void loongarch_cpu_set_irq(void *opaque, int irq, int level)
+void loongarch_cpu_set_irq_impl(void *opaque, int irq, int level,
+                                bool guest)
 {
     LoongArchCPU *cpu = opaque;
     CPULoongArchState *env = &cpu->env;
     CPUState *cs = CPU(cpu);
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, guest);
+    int interrupt = guest ? CPU_INTERRUPT_GUEST : CPU_INTERRUPT_HARD;
 
     if (irq < 0 || irq >= N_IRQS) {
         return;
     }
 
-    if (kvm_enabled()) {
+    if (!guest && kvm_enabled()) {
         kvm_loongarch_set_interrupt(cpu, irq, level);
     } else if (tcg_enabled()) {
+        if (!guest && irq >= 2 && irq < 10 &&
+            (FIELD_EX64(sys->CSR_GINTC, CSR_GINTC, HWIP) &
+             BIT(irq - 2))) {
+            loongarch_cpu_set_irq_impl(opaque, irq, level, true);
+            return;
+        }
         sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, irq, 1, level != 0);
-        if (FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS)) {
-            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
-        } else {
-            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+        if (!guest || env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST) {
+            if (FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS)) {
+                cpu_interrupt(cs, interrupt);
+            } else {
+                cpu_reset_interrupt(cs, interrupt);
+            }
         }
     }
 }
 
+void loongarch_cpu_set_irq(void *opaque, int irq, int level)
+{
+    loongarch_cpu_set_irq_impl(opaque, irq, level, false);
+}
+
 /* Check if there is pending and not masked out interrupt */
-bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
+bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env, bool guest)
 {
     uint32_t pending;
     uint32_t status;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, guest);
 
     pending = FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS);
-    status  = FIELD_EX64(sys->CSR_ECFG, CSR_ECFG, LIE);
+    status = FIELD_EX64(sys->CSR_ECFG, CSR_ECFG, LIE);
 
     return (pending & status) != 0;
 }
+
 #endif
 
 #ifndef CONFIG_USER_ONLY
@@ -100,7 +116,12 @@ bool loongarch_cpu_has_work(CPUState *cs)
     bool has_work = false;
 
     if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
-        cpu_loongarch_hw_interrupts_pending(cpu_env(cs))) {
+        cpu_loongarch_hw_interrupts_pending(cpu_env(cs), false)) {
+        has_work = true;
+    }
+
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_GUEST) &&
+        cpu_loongarch_hw_interrupts_pending(cpu_env(cs), true)) {
         has_work = true;
     }
 
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index e01dbed40f..a23b0d3d58 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -32,6 +32,8 @@ void restore_fp_status(CPULoongArchState *env);
 extern const VMStateDescription vmstate_loongarch_cpu;
 
 void loongarch_cpu_set_irq(void *opaque, int irq, int level);
+void loongarch_cpu_set_irq_impl(void *opaque, int irq, int level,
+                                bool guest);
 
 void loongarch_constant_timer_cb(void *opaque);
 uint64_t cpu_loongarch_get_constant_timer_counter(LoongArchCPU *cpu);
@@ -39,7 +41,7 @@ uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu);
 void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
                                                uint64_t value);
 bool loongarch_cpu_has_work(CPUState *cs);
-bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env);
+bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env, bool guest);
 #endif /* !CONFIG_USER_ONLY */
 
 uint64_t read_fcc(CPULoongArchState *env);
diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 4b1d44a164..e84ef5f305 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -238,29 +238,43 @@ static void loongarch_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
     }
 }
 
-static inline bool cpu_loongarch_hw_interrupts_enabled(CPULoongArchState *env)
+static inline bool cpu_loongarch_hw_interrupts_enabled(CPULoongArchState *env, bool guest)
 {
     bool ret = 0;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, guest);
+    CPUSysState *host = get_sys(env, LOONGARCH_VM_LEVEL_HOST);
 
     ret = (FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, IE) &&
-          !(FIELD_EX64(sys->CSR_DBG, CSR_DBG, DST)));
+          !(FIELD_EX64(host->CSR_DBG, CSR_DBG, DST)));
 
     return ret;
 }
 
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
+        if (cpu_loongarch_hw_interrupts_enabled(env, false) &&
+            cpu_loongarch_hw_interrupts_pending(env, false)) {
+            if (env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST) {
+                trigger_vm_exit(env);
+            }
+            has_interrupt = true;
         }
+    } else if (interrupt_request & CPU_INTERRUPT_GUEST) {
+        if (cpu_loongarch_hw_interrupts_enabled(env, true) &&
+            cpu_loongarch_hw_interrupts_pending(env, true) &&
+            env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST) {
+            has_interrupt = true;
+        }
+    }
+    if (has_interrupt) {
+        /* Raise it */
+        cs->exception_index = EXCCODE_INT;
+        loongarch_cpu_do_interrupt(cs);
+        return true;
     }
     return false;
 }
-- 
2.55.0


