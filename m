Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9476AC79F8C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 02:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3PGI-0000eu-8d; Sun, 06 Sep 2026 22:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x3PGH-0000eT-7d
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 22:39:09 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x3PGD-0007vN-5u
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 22:39:08 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8Ax29HCI55qBEsJAA--.26823S3;
 Mon, 07 Sep 2026 10:38:58 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJBxpMy8I55qtj0cAA--.33287S5;
 Mon, 07 Sep 2026 10:38:58 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH 3/3] target/loongarch: Add CPUTimerState structure
Date: Mon,  7 Sep 2026 10:40:12 +0800
Message-ID: <20260907024012.2992255-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260907024012.2992255-1-maobibo@loongson.cn>
References: <20260907024012.2992255-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxpMy8I55qtj0cAA--.33287S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Gr47ArW8XFWfZr1rtw17CFX_yoW3Cw4fpr
 WxCry7Kr48trZrA3Z7J398WF1DWr17Ww129a1ftrWIkanrJr4fu3Wkt39FgF4DAa4rWrW2
 qFn5Za15XFW7X3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
 jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2I
 x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
 8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
 0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1LvtUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Structure CPUTimerState is added here, QEMUTimer and IRQ number is
included, also the CPUSysState pointer is in this structure, so it is
easy to add another separate timer in guest mode.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c            | 10 ++++++++--
 target/loongarch/cpu.h            | 14 +++++++++++++-
 target/loongarch/internals.h      |  6 +++---
 target/loongarch/tcg/csr_helper.c |  7 ++-----
 target/loongarch/tcg/op_helper.c  |  3 +--
 target/loongarch/tcg/timer.c      | 27 ++++++++++++---------------
 6 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index cba227fd1b..7182b85058 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -758,11 +758,17 @@ static void loongarch_cpu_init(Object *obj)
 {
 #ifndef CONFIG_USER_ONLY
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+    CPULoongArchState *env = &cpu->env;
+    CPUTimerState *timer;
 
     qdev_init_gpio_in(DEVICE(cpu), loongarch_cpu_set_irq, N_IRQS);
 #ifdef CONFIG_TCG
-    timer_init_ns(&cpu->timer, QEMU_CLOCK_VIRTUAL,
-                  &cpu_loongarch_timer_cb, cpu);
+    timer = env_timer(env);
+    timer->irq = IRQ_TIMER;
+    timer->cs  = CPU(obj);
+    timer->sys_state = &env->sys_states[0];
+    timer_init_ns(&timer->timer, QEMU_CLOCK_VIRTUAL,
+                  &cpu_loongarch_timer_cb, timer);
 #endif
 #endif
 }
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 97db3b453f..0d7679f3be 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -382,6 +382,13 @@ typedef struct CPUSysState {
     uint64_t CSR_MSGIE;
 } CPUSysState;
 
+typedef struct CPUTimerState {
+    QEMUTimer timer;
+    int irq;
+    CPUState *cs;
+    CPUSysState *sys_state;
+} CPUTimerState;
+
 typedef struct CPUArchState {
     uint64_t gpr[32];
     uint64_t pc;
@@ -418,6 +425,7 @@ typedef struct CPUArchState {
 
     AddressSpace *address_space_iocsr;
     uint32_t mp_state;
+    CPUTimerState timer_states[1];
 #endif
     CPUSysState *sys_state;
 } CPULoongArchState;
@@ -438,7 +446,6 @@ struct ArchCPU {
     CPUState parent_obj;
 
     CPULoongArchState env;
-    QEMUTimer timer;
     uint32_t  phy_id;
     OnOffAuto lbt;
     OnOffAuto pmu;
@@ -496,6 +503,11 @@ static inline void set_sys_state(CPULoongArchState *env, CPUSysState *sys)
     env->sys_state = sys;
 }
 
+static inline CPUTimerState *env_timer(CPULoongArchState *env)
+{
+    return &env->timer_states[0];
+}
+
 static inline bool is_la64(CPULoongArchState *env)
 {
     return FIELD_EX32(env->cpucfg[1], CPUCFG1, ARCH) == CPUCFG1_ARCH_LA64;
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index 8c5f095782..f9a0680fe0 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -35,9 +35,9 @@ void loongarch_cpu_update_irq(LoongArchCPU *cpu, uint64_t old);
 void loongarch_cpu_set_irq(void *opaque, int irq, int level);
 
 void cpu_loongarch_timer_cb(void *opaque);
-uint64_t cpu_loongarch_get_timer_counter(LoongArchCPU *cpu);
-uint64_t cpu_loongarch_get_timer_ticks(LoongArchCPU *cpu);
-void cpu_loongarch_set_timer_config(LoongArchCPU *cpu, uint64_t value);
+uint64_t cpu_loongarch_get_timer_counter(CPUTimerState *timer);
+uint64_t cpu_loongarch_get_timer_ticks(CPUTimerState *timer);
+void cpu_loongarch_set_timer_config(CPUTimerState *timer, uint64_t value);
 bool loongarch_cpu_has_work(CPUState *cs);
 bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env);
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index b1a0b005e9..bc6511a6f0 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -72,9 +72,7 @@ target_ulong helper_csrrd_cpuid(CPULoongArchState *env)
 
 target_ulong helper_csrrd_tval(CPULoongArchState *env)
 {
-    LoongArchCPU *cpu = env_archcpu(env);
-
-    return cpu_loongarch_get_timer_ticks(cpu);
+    return cpu_loongarch_get_timer_ticks(env_timer(env));
 }
 
 target_ulong helper_csrrd_msgir(CPULoongArchState *env)
@@ -135,11 +133,10 @@ target_ulong helper_csrwr_asid(CPULoongArchState *env, target_ulong val)
 
 target_ulong helper_csrwr_tcfg(CPULoongArchState *env, target_ulong val)
 {
-    LoongArchCPU *cpu = env_archcpu(env);
     CPUSysState *sys = env_sys(env);
     int64_t old_v = sys->CSR_TCFG;
 
-    cpu_loongarch_set_timer_config(cpu, val);
+    cpu_loongarch_set_timer_config(env_timer(env), val);
 
     return old_v;
 }
diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
index c090d5b12e..76d7201aea 100644
--- a/target/loongarch/tcg/op_helper.c
+++ b/target/loongarch/tcg/op_helper.c
@@ -73,7 +73,6 @@ uint64_t helper_rdtime_d(CPULoongArchState *env)
     return cpu_get_host_ticks();
 #else
     uint64_t plv;
-    LoongArchCPU *cpu = env_archcpu(env);
     CPUSysState *sys = env_sys(env);
 
     plv = FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PLV);
@@ -81,7 +80,7 @@ uint64_t helper_rdtime_d(CPULoongArchState *env)
         do_raise_exception(env, EXCCODE_IPE, GETPC());
     }
 
-    return cpu_loongarch_get_timer_counter(cpu);
+    return cpu_loongarch_get_timer_counter(env_timer(env));
 #endif
 }
 
diff --git a/target/loongarch/tcg/timer.c b/target/loongarch/tcg/timer.c
index a25312b9ab..9c5aa6720f 100644
--- a/target/loongarch/tcg/timer.c
+++ b/target/loongarch/tcg/timer.c
@@ -15,60 +15,57 @@
 #define CONSTANT_TIMER_TICK_MASK    0xfffffffffffcUL
 #define CONSTANT_TIMER_ENABLE       0x1UL
 
-uint64_t cpu_loongarch_get_timer_counter(LoongArchCPU *cpu)
+uint64_t cpu_loongarch_get_timer_counter(CPUTimerState *timer)
 {
     return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / TIMER_PERIOD;
 }
 
-uint64_t cpu_loongarch_get_timer_ticks(LoongArchCPU *cpu)
+uint64_t cpu_loongarch_get_timer_ticks(CPUTimerState *timer)
 {
-    CPULoongArchState *env = &cpu->env;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = timer->sys_state;
     uint64_t now, expire;
 
     if ((sys->CSR_TCFG & CONSTANT_TIMER_ENABLE) &&
         (sys->CSR_TVAL < sys->CSR_TCFG)) {
         now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        expire = timer_expire_time_ns(&cpu->timer);
+        expire = timer_expire_time_ns(&timer->timer);
         sys->CSR_TVAL = (expire - now) / TIMER_PERIOD;
     }
 
     return sys->CSR_TVAL;
 }
 
-void cpu_loongarch_set_timer_config(LoongArchCPU *cpu, uint64_t value)
+void cpu_loongarch_set_timer_config(CPUTimerState *timer, uint64_t value)
 {
-    CPULoongArchState *env = &cpu->env;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = timer->sys_state;
     uint64_t now, next;
 
     sys->CSR_TCFG = value;
     if (value & CONSTANT_TIMER_ENABLE) {
         now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
         next = now + (value & CONSTANT_TIMER_TICK_MASK) * TIMER_PERIOD;
-        timer_mod(&cpu->timer, next);
+        timer_mod(&timer->timer, next);
         sys->CSR_TVAL = sys->CSR_TCFG & CONSTANT_TIMER_TICK_MASK;
     } else {
-        timer_del(&cpu->timer);
+        timer_del(&timer->timer);
         sys->CSR_TVAL = 0;
     }
 }
 
 void cpu_loongarch_timer_cb(void *opaque)
 {
-    LoongArchCPU *cpu  = opaque;
-    CPULoongArchState *env = &cpu->env;
-    CPUSysState *sys = env_sys(env);
+    CPUTimerState *timer = opaque;
+    CPUSysState *sys = timer->sys_state;
     uint64_t now, next;
 
     if (FIELD_EX64(sys->CSR_TCFG, CSR_TCFG, PERIODIC)) {
         now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
         next = now + (sys->CSR_TCFG & CONSTANT_TIMER_TICK_MASK) * TIMER_PERIOD;
-        timer_mod(&cpu->timer, next);
+        timer_mod(&timer->timer, next);
         sys->CSR_TVAL = sys->CSR_TCFG & CONSTANT_TIMER_TICK_MASK;
     } else {
         sys->CSR_TVAL = CONSTANT_TIMER_TICK_MASK;
     }
 
-    loongarch_cpu_set_irq(opaque, IRQ_TIMER, 1);
+    loongarch_cpu_set_irq(LOONGARCH_CPU(timer->cs), timer->irq, 1);
 }
-- 
2.54.0


