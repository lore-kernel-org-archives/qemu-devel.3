Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8F7C88E42
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 07:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4ZT1-00059i-Kx; Thu, 10 Sep 2026 03:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x4ZSy-00057p-SW
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 03:45:04 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x4ZSv-00072d-OX
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 03:45:04 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8DxjdL3X6Jq63cKAA--.30002S3;
 Thu, 10 Sep 2026 15:44:55 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJBx5cz1X6JqCW0eAA--.38445S5;
 Thu, 10 Sep 2026 15:44:54 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] target/loongarch: Add CPUTimerState structure
Date: Thu, 10 Sep 2026 15:46:13 +0800
Message-ID: <20260910074613.3486127-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260910074613.3486127-1-maobibo@loongson.cn>
References: <20260910074613.3486127-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBx5cz1X6JqCW0eAA--.38445S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxKFWUJrykuw4xur45ur4UGFX_yoWfGw1Dpr
 W2kry7Kr18JrZrJwn7ta98WF1DXr17Ww129a1SyrWIkan7Jr48ua4kt39FgFWUu3yrWrWa
 qFn5Aa15XFW7XacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
 0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
 7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcV
 C0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
 04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
 CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8wNVDUUUUU==
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

Structure CPUTimerState is added in structure CPUSysState, QEMUTimer
and IRQ number is included, so it is easy to add another separate
timer if LVZ feature is supported.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c            | 12 ++++++++++--
 target/loongarch/cpu.h            | 15 ++++++++++++++-
 target/loongarch/internals.h      |  6 +++---
 target/loongarch/tcg/csr_helper.c | 14 ++++++--------
 target/loongarch/tcg/op_helper.c  |  6 +++---
 target/loongarch/tcg/timer.c      | 27 ++++++++++++---------------
 6 files changed, 48 insertions(+), 32 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index eb143800e0..81dacbbaec 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -720,11 +720,19 @@ static void loongarch_cpu_init(Object *obj)
 {
 #ifndef CONFIG_USER_ONLY
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+#ifdef CONFIG_TCG
+    CPULoongArchState *env = &cpu->env;
+    CPUTimerState *timer;
+#endif
+
 
     qdev_init_gpio_in(DEVICE(cpu), loongarch_cpu_set_irq, N_IRQS);
 #ifdef CONFIG_TCG
-    timer_init_ns(&cpu->timer, QEMU_CLOCK_VIRTUAL,
-                  &cpu_loongarch_timer_cb, cpu);
+    timer = env_timer(env);
+    timer->irq = IRQ_TIMER;
+    timer->cs  = CPU(obj);
+    timer_init_ns(&timer->timer, QEMU_CLOCK_VIRTUAL,
+                  &cpu_loongarch_timer_cb, timer);
 #endif
 #endif
 }
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index d83dcef6f8..c592f69885 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -315,6 +315,12 @@ typedef struct  LoongArchBT {
     uint32_t ftop;
 } lbt_t;
 
+typedef struct CPUTimerState {
+    QEMUTimer timer;
+    int irq;
+    CPUState *cs;
+} CPUTimerState;
+
 #define CPU_VENDOR_LOONGSON   "Loongson"
 #define CPU_MODEL_3A5000      "3A5000"
 #define CPU_MODEL_1C101       "1C101"
@@ -384,6 +390,9 @@ typedef struct CPUSysState {
     uint64_t CSR_PRCFG1;
     uint64_t CSR_PRCFG2;
     uint64_t CSR_PRCFG3;
+#ifdef CONFIG_TCG
+    CPUTimerState timer_state;
+#endif
 } CPUSysState;
 
 typedef struct CPUArchState {
@@ -446,7 +455,6 @@ struct ArchCPU {
     CPUState parent_obj;
 
     CPULoongArchState env;
-    QEMUTimer timer;
     uint32_t  phy_id;
     OnOffAuto lbt;
     OnOffAuto pmu;
@@ -504,6 +512,11 @@ static inline void set_sys_state(CPULoongArchState *env, CPUSysState *sys)
     env->sys_state = sys;
 }
 
+static inline CPUTimerState *env_timer(CPULoongArchState *env)
+{
+    return &env->sys_states[0].timer_state;
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
index b1a0b005e9..88656b5344 100644
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
@@ -135,23 +133,23 @@ target_ulong helper_csrwr_asid(CPULoongArchState *env, target_ulong val)
 
 target_ulong helper_csrwr_tcfg(CPULoongArchState *env, target_ulong val)
 {
-    LoongArchCPU *cpu = env_archcpu(env);
-    CPUSysState *sys = env_sys(env);
+    CPUTimerState *timer = env_timer(env);
+    CPUSysState *sys = container_of(timer, CPUSysState, timer_state);
     int64_t old_v = sys->CSR_TCFG;
 
-    cpu_loongarch_set_timer_config(cpu, val);
+    cpu_loongarch_set_timer_config(timer, val);
 
     return old_v;
 }
 
 target_ulong helper_csrwr_ticlr(CPULoongArchState *env, target_ulong val)
 {
-    LoongArchCPU *cpu = env_archcpu(env);
+    CPUTimerState *timer = env_timer(env);
     int64_t old_v = 0;
 
     if (val & 0x1) {
         bql_lock();
-        loongarch_cpu_set_irq(cpu, IRQ_TIMER, 0);
+        loongarch_cpu_set_irq(LOONGARCH_CPU(timer->cs), timer->irq, 0);
         bql_unlock();
     }
     return old_v;
diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
index c090d5b12e..f98fe4d4a1 100644
--- a/target/loongarch/tcg/op_helper.c
+++ b/target/loongarch/tcg/op_helper.c
@@ -73,15 +73,15 @@ uint64_t helper_rdtime_d(CPULoongArchState *env)
     return cpu_get_host_ticks();
 #else
     uint64_t plv;
-    LoongArchCPU *cpu = env_archcpu(env);
-    CPUSysState *sys = env_sys(env);
+    CPUTimerState *timer = env_timer(env);
+    CPUSysState *sys = container_of(timer, CPUSysState, timer_state);
 
     plv = FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PLV);
     if (extract64(sys->CSR_MISC, R_CSR_MISC_DRDTL_SHIFT + plv, 1)) {
         do_raise_exception(env, EXCCODE_IPE, GETPC());
     }
 
-    return cpu_loongarch_get_timer_counter(cpu);
+    return cpu_loongarch_get_timer_counter(timer);
 #endif
 }
 
diff --git a/target/loongarch/tcg/timer.c b/target/loongarch/tcg/timer.c
index a25312b9ab..6a96dfd429 100644
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
+    CPUSysState *sys = container_of(timer, CPUSysState, timer_state);
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
+    CPUSysState *sys = container_of(timer, CPUSysState, timer_state);
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
+    CPUSysState *sys = container_of(timer, CPUSysState, timer_state);
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


