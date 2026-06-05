Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209F7CD6E7B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 08:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVPr2-0006UO-BB; Fri, 05 Jun 2026 04:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wVPqz-0006Sp-BL
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:24:33 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wVPqv-0004hQ-D2
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:24:33 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8CxRXi4hyJqqOMQAA--.22030S3;
 Fri, 05 Jun 2026 16:24:24 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJCxvsKuhyJqnLucAA--.34744S6;
 Fri, 05 Jun 2026 16:24:22 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v3 04/14] target/loongarch: Use sys_state in file arch_dump.c
 when accessing CSR registers
Date: Fri,  5 Jun 2026 16:25:42 +0800
Message-ID: <20260605082552.175336-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605082552.175336-1-maobibo@loongson.cn>
References: <20260605082552.175336-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxvsKuhyJqnLucAA--.34744S6
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAr45KF45ArW3KFW8WF17Arc_yoWrKw4rpr
 WxurWjkr48KrWDZas7ta98XF1DXr17W34I9a1SkryIyF45Xr13Z3Wkt3s2qF1UA3y5WrWj
 vF1rZw1j9a17ZacCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
 AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
 6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
 CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF
 0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
 AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
 KfnxnUUI43ZEXa7IU8XyCJUUUUU==
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

When accessing CSR registers in file arch_dump.c, use sys_state rather
than env.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
---
 hw/intc/loongarch_dintc.c             |  4 +++-
 target/loongarch/arch_dump.c          |  5 +++--
 target/loongarch/cpu-mmu.h            |  4 +++-
 target/loongarch/gdbstub.c            |  3 ++-
 target/loongarch/tcg/constant_timer.c | 10 ++++++----
 5 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/hw/intc/loongarch_dintc.c b/hw/intc/loongarch_dintc.c
index c42a919df4..c877a8003b 100644
--- a/hw/intc/loongarch_dintc.c
+++ b/hw/intc/loongarch_dintc.c
@@ -35,10 +35,12 @@ static void do_set_vcpu_dintc_irq(CPUState *cs, run_on_cpu_data data)
 {
     int irq = data.host_int;
     CPULoongArchState *env;
+    CPUSysState *sys;
 
     env = &LOONGARCH_CPU(cs)->env;
+    sys = env_sys(env);
     cpu_synchronize_state(cs);
-    set_bit(irq, (unsigned long *)&env->CSR_MSGIS);
+    set_bit(irq, (unsigned long *)&sys->CSR_MSGIS);
 }
 
 static void loongarch_dintc_mem_write(void *opaque, hwaddr addr,
diff --git a/target/loongarch/arch_dump.c b/target/loongarch/arch_dump.c
index 2b0955a209..9d84faef96 100644
--- a/target/loongarch/arch_dump.c
+++ b/target/loongarch/arch_dump.c
@@ -116,6 +116,7 @@ int loongarch_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
 {
     struct loongarch_note note;
     CPULoongArchState *env = &LOONGARCH_CPU(cs)->env;
+    CPUSysState *sys = env_sys(env);
     int ret, i;
 
     loongarch_note_init(&note, s, "CORE", 5, NT_PRSTATUS,
@@ -126,8 +127,8 @@ int loongarch_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
     for (i = 0; i < 32; ++i) {
         note.prstatus.pr_reg.gpr[i] = cpu_to_dump64(s, env->gpr[i]);
     }
-    note.prstatus.pr_reg.csr_era  = cpu_to_dump64(s, env->CSR_ERA);
-    note.prstatus.pr_reg.csr_badv = cpu_to_dump64(s, env->CSR_BADV);
+    note.prstatus.pr_reg.csr_era  = cpu_to_dump64(s, sys->CSR_ERA);
+    note.prstatus.pr_reg.csr_badv = cpu_to_dump64(s, sys->CSR_BADV);
     ret = f(&note, LOONGARCH_PRSTATUS_NOTE_SIZE, s);
     if (ret < 0) {
         return -1;
diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index 2d7ebb2d72..54fb732d62 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -32,7 +32,9 @@ typedef struct MMUContext {
 
 static inline bool cpu_has_ptw(CPULoongArchState *env)
 {
-    return !!FIELD_EX64(env->CSR_PWCH, CSR_PWCH, HPTW_EN);
+    CPUSysState *sys = env_sys(env);
+
+    return !!FIELD_EX64(sys->CSR_PWCH, CSR_PWCH, HPTW_EN);
 }
 
 static inline bool pte_present(CPULoongArchState *env, uint64_t entry)
diff --git a/target/loongarch/gdbstub.c b/target/loongarch/gdbstub.c
index 3e9bdfa8bb..e02354cdb9 100644
--- a/target/loongarch/gdbstub.c
+++ b/target/loongarch/gdbstub.c
@@ -34,6 +34,7 @@ void write_fcc(CPULoongArchState *env, uint64_t val)
 int loongarch_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     CPULoongArchState *env = cpu_env(cs);
+    CPUSysState *sys = env_sys(env);
 
     if (0 <= n && n <= 34) {
         uint64_t val;
@@ -46,7 +47,7 @@ int loongarch_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         } else if (n == 33) {
             val = env->pc;
         } else /* if (n == 34) */ {
-            val = env->CSR_BADV;
+            val = sys->CSR_BADV;
         }
 
         if (is_la64(env)) {
diff --git a/target/loongarch/tcg/constant_timer.c b/target/loongarch/tcg/constant_timer.c
index 1851f53fd6..f56e76d482 100644
--- a/target/loongarch/tcg/constant_timer.c
+++ b/target/loongarch/tcg/constant_timer.c
@@ -34,9 +34,10 @@ void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
                                                uint64_t value)
 {
     CPULoongArchState *env = &cpu->env;
+    CPUSysState *sys = env_sys(env);
     uint64_t now, next;
 
-    env->CSR_TCFG = value;
+    sys->CSR_TCFG = value;
     if (value & CONSTANT_TIMER_ENABLE) {
         now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
         next = now + (value & CONSTANT_TIMER_TICK_MASK) * TIMER_PERIOD;
@@ -50,14 +51,15 @@ void loongarch_constant_timer_cb(void *opaque)
 {
     LoongArchCPU *cpu  = opaque;
     CPULoongArchState *env = &cpu->env;
+    CPUSysState *sys = env_sys(env);
     uint64_t now, next;
 
-    if (FIELD_EX64(env->CSR_TCFG, CSR_TCFG, PERIODIC)) {
+    if (FIELD_EX64(sys->CSR_TCFG, CSR_TCFG, PERIODIC)) {
         now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        next = now + (env->CSR_TCFG & CONSTANT_TIMER_TICK_MASK) * TIMER_PERIOD;
+        next = now + (sys->CSR_TCFG & CONSTANT_TIMER_TICK_MASK) * TIMER_PERIOD;
         timer_mod(&cpu->timer, next);
     } else {
-        env->CSR_TCFG = FIELD_DP64(env->CSR_TCFG, CSR_TCFG, EN, 0);
+        sys->CSR_TCFG = FIELD_DP64(sys->CSR_TCFG, CSR_TCFG, EN, 0);
     }
 
     loongarch_cpu_set_irq(opaque, IRQ_TIMER, 1);
-- 
2.54.0


