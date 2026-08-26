Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB74C61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 10:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzAuo-000265-2G; Wed, 26 Aug 2026 06:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1wzAuO-0001uh-K8
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:31:04 -0400
Received: from [2a14:640:1:12b5::1] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1wzAuM-0003NM-Hp
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:31:04 -0400
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id 0C58CDF9B;
 Wed, 26 Aug 2026 16:00:57 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, xianglai li <lixianglai@loongson.cn>,
 SignKirigami <prcups@krgm.moe>, Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v4 06/14] target/loongarch: Add LVZ guest timer support
Date: Wed, 26 Aug 2026 18:30:10 +0800
Message-ID: <0de498ed984527f0c4e86a18295c12354f81ebdf.1787739852.git.prcups@krgm.moe>
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

Add a separate guest constant timer, preserve its remaining ticks across VM
exits, and provide TVAL and TCFG helpers for accesses to the guest CSR bank.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu.c                |  2 +
 target/loongarch/internals.h          |  6 ++-
 target/loongarch/tcg/constant_timer.c | 67 ++++++++++++++++++++++-----
 target/loongarch/tcg/csr_helper.c     | 22 ++++++++-
 target/loongarch/tcg/helper.h         |  2 +
 5 files changed, 84 insertions(+), 15 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index b12e8944de..ff36294aa5 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -795,6 +795,8 @@ static void loongarch_cpu_init(Object *obj)
 #ifdef CONFIG_TCG
     timer_init_ns(&cpu->timer, QEMU_CLOCK_VIRTUAL,
                   &loongarch_constant_timer_cb, cpu);
+    timer_init_ns(&cpu->guest_timer, QEMU_CLOCK_VIRTUAL,
+                  &loongarch_constant_timer_cb_guest, cpu);
 #endif
 #endif
 }
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index a23b0d3d58..8ae3507c71 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -36,10 +36,12 @@ void loongarch_cpu_set_irq_impl(void *opaque, int irq, int level,
                                 bool guest);
 
 void loongarch_constant_timer_cb(void *opaque);
+void loongarch_constant_timer_cb_guest(void *opaque);
 uint64_t cpu_loongarch_get_constant_timer_counter(LoongArchCPU *cpu);
-uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu);
+uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu, bool guest);
+void cpu_loongarch_set_guest_timer(LoongArchCPU *cpu, bool on);
 void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
-                                               uint64_t value);
+                                               uint64_t value, bool guest);
 bool loongarch_cpu_has_work(CPUState *cs);
 bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env, bool guest);
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/loongarch/tcg/constant_timer.c b/target/loongarch/tcg/constant_timer.c
index f56e76d482..a341f48489 100644
--- a/target/loongarch/tcg/constant_timer.c
+++ b/target/loongarch/tcg/constant_timer.c
@@ -20,47 +20,92 @@ uint64_t cpu_loongarch_get_constant_timer_counter(LoongArchCPU *cpu)
     return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / TIMER_PERIOD;
 }
 
-uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu)
+uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu, bool guest)
 {
+    CPULoongArchState *env = &cpu->env;
     uint64_t now, expire;
+    CPUSysState *sys = get_sys(env, guest);
+
+    if (guest && env_vm_level(env) != LOONGARCH_VM_LEVEL_GUEST) {
+        return sys->CSR_TVAL;
+    }
 
     now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    expire = timer_expire_time_ns(&cpu->timer);
+    expire = timer_expire_time_ns(guest ? &cpu->guest_timer : &cpu->timer);
 
     return (expire - now) / TIMER_PERIOD;
 }
 
 void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
-                                               uint64_t value)
+                                               uint64_t value, bool guest)
 {
     CPULoongArchState *env = &cpu->env;
-    CPUSysState *sys = env_sys(env);
     uint64_t now, next;
+    CPUSysState *sys = get_sys(env, guest);
+    QEMUTimer *timer = guest ? &cpu->guest_timer : &cpu->timer;
 
     sys->CSR_TCFG = value;
+    if (guest && env_vm_level(env) != LOONGARCH_VM_LEVEL_GUEST) {
+        return;
+    }
+
     if (value & CONSTANT_TIMER_ENABLE) {
         now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
         next = now + (value & CONSTANT_TIMER_TICK_MASK) * TIMER_PERIOD;
-        timer_mod(&cpu->timer, next);
+        timer_mod(timer, next);
     } else {
-        timer_del(&cpu->timer);
+        timer_del(timer);
     }
 }
 
-void loongarch_constant_timer_cb(void *opaque)
+void cpu_loongarch_set_guest_timer(LoongArchCPU *cpu, bool on)
 {
-    LoongArchCPU *cpu  = opaque;
     CPULoongArchState *env = &cpu->env;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *guest = get_sys(env, LOONGARCH_VM_LEVEL_GUEST);
+    uint64_t now, next, ticks;
+
+    if (!(guest->CSR_TCFG & CONSTANT_TIMER_ENABLE)) {
+        return;
+    }
+
+    if (on) {
+        now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        ticks = guest->CSR_TVAL ? guest->CSR_TVAL :
+                                  (guest->CSR_TCFG & CONSTANT_TIMER_TICK_MASK);
+        guest->CSR_TVAL = 0;
+        next = now + ticks * TIMER_PERIOD;
+        timer_mod(&cpu->guest_timer, next);
+    } else {
+        guest->CSR_TVAL = cpu_loongarch_get_constant_timer_ticks(cpu, true);
+        timer_del(&cpu->guest_timer);
+    }
+}
+
+static void loongarch_constant_timer_cb_impl(void *opaque, bool guest)
+{
+    LoongArchCPU *cpu = opaque;
+    CPULoongArchState *env = &cpu->env;
+    CPUSysState *sys = get_sys(env, guest);
+    QEMUTimer *timer = guest ? &cpu->guest_timer : &cpu->timer;
     uint64_t now, next;
 
     if (FIELD_EX64(sys->CSR_TCFG, CSR_TCFG, PERIODIC)) {
         now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
         next = now + (sys->CSR_TCFG & CONSTANT_TIMER_TICK_MASK) * TIMER_PERIOD;
-        timer_mod(&cpu->timer, next);
+        timer_mod(timer, next);
     } else {
         sys->CSR_TCFG = FIELD_DP64(sys->CSR_TCFG, CSR_TCFG, EN, 0);
     }
 
-    loongarch_cpu_set_irq(opaque, IRQ_TIMER, 1);
+    loongarch_cpu_set_irq_impl(opaque, IRQ_TIMER, 1, guest);
+}
+
+void loongarch_constant_timer_cb(void *opaque)
+{
+    loongarch_constant_timer_cb_impl(opaque, false);
+}
+
+void loongarch_constant_timer_cb_guest(void *opaque)
+{
+    loongarch_constant_timer_cb_impl(opaque, true);
 }
diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index 7dc33bc180..fa75508244 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -74,7 +74,14 @@ target_ulong helper_csrrd_tval(CPULoongArchState *env)
 {
     LoongArchCPU *cpu = env_archcpu(env);
 
-    return cpu_loongarch_get_constant_timer_ticks(cpu);
+    return cpu_loongarch_get_constant_timer_ticks(cpu, false);
+}
+
+target_ulong helper_gcsrrd_tval(CPULoongArchState *env)
+{
+    LoongArchCPU *cpu = env_archcpu(env);
+
+    return cpu_loongarch_get_constant_timer_ticks(cpu, true);
 }
 
 target_ulong helper_csrrd_msgir(CPULoongArchState *env)
@@ -129,7 +136,18 @@ target_ulong helper_csrwr_tcfg(CPULoongArchState *env, target_ulong val)
     CPUSysState *sys = env_sys(env);
     int64_t old_v = sys->CSR_TCFG;
 
-    cpu_loongarch_store_constant_timer_config(cpu, val);
+    cpu_loongarch_store_constant_timer_config(cpu, val, false);
+
+    return old_v;
+}
+
+target_ulong helper_gcsrwr_tcfg(CPULoongArchState *env, target_ulong val)
+{
+    LoongArchCPU *cpu = env_archcpu(env);
+    CPUSysState *guest = get_sys(env, LOONGARCH_VM_LEVEL_GUEST);
+    int64_t old_v = guest->CSR_TCFG;
+
+    cpu_loongarch_store_constant_timer_config(cpu, val, true);
 
     return old_v;
 }
diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
index 8a6c62f116..a003266827 100644
--- a/target/loongarch/tcg/helper.h
+++ b/target/loongarch/tcg/helper.h
@@ -100,11 +100,13 @@ DEF_HELPER_1(rdtime_d, i64, env)
 DEF_HELPER_1(csrrd_pgd, i64, env)
 DEF_HELPER_1(csrrd_cpuid, i64, env)
 DEF_HELPER_1(csrrd_tval, i64, env)
+DEF_HELPER_1(gcsrrd_tval, i64, env)
 DEF_HELPER_1(csrrd_msgir, i64, env)
 DEF_HELPER_2(csrwr_stlbps, i64, env, tl)
 DEF_HELPER_2(csrwr_estat, i64, env, tl)
 DEF_HELPER_2(csrwr_asid, i64, env, tl)
 DEF_HELPER_2(csrwr_tcfg, i64, env, tl)
+DEF_HELPER_2(gcsrwr_tcfg, i64, env, tl)
 DEF_HELPER_2(csrwr_ticlr, i64, env, tl)
 DEF_HELPER_2(csrwr_pwcl, i64, env, tl)
 DEF_HELPER_2(csrwr_pwch, i64, env, tl)
-- 
2.55.0


