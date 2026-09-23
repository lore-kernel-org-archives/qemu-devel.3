Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D842DC982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 03:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9DMM-00050R-7R; Tue, 22 Sep 2026 23:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x9DMK-00050E-K0
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 23:09:24 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x9DMH-0001yJ-4w
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 23:09:23 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8Axj9HVQrNqF+QOAA--.43771S3;
 Wed, 23 Sep 2026 11:09:10 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJDxxMzTQrNqLgokAA--.49521S2;
 Wed, 23 Sep 2026 11:09:07 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH] target/loongarch: Set CPU_INTERRUPT_HARD unless no pending irq
Date: Wed, 23 Sep 2026 11:10:29 +0800
Message-ID: <20260923031029.127490-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxxMzTQrNqLgokAA--.49521S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZw1DZrW7uF1DWF4fGw4xXwc_yoW5urW7pr
 W7uF12qw48KrWDZa4Dtas8Wr1DZr17Ww129an3K34fCF45Xryjqr1kt39F9F4DG3s8WrWj
 qF4Fyw1UZa1xZFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
 jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2I
 x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
 8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
 0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07URa0PUUUUU=
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

On LoongArch CPU_INTERRUPT_HARD is set only when interrupt is injected
at the first time. Function cpu_interrupt() is not called if there is
pending irq already, this will not set CPU_INTERRUPT_HARD bit, however
QEMU TCG framework will clear CPU_INTERRUPT_HARD bit when handling IRQ
flow. There will be new interrupt lost issue when handling old one,
the similar with other architectures set CPU_INTERRUPT_HARD bit always if
there is pending interrupt.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c            | 14 ++++----------
 target/loongarch/internals.h      |  2 +-
 target/loongarch/tcg/csr_helper.c |  2 +-
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index f22f64efb8..54c2699897 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -58,20 +58,16 @@ static vaddr loongarch_cpu_get_pc(CPUState *cs)
 #ifndef CONFIG_USER_ONLY
 #include "hw/loongarch/virt.h"
 
-void loongarch_cpu_update_irq(LoongArchCPU *cpu, uint64_t old)
+void loongarch_cpu_update_irq(LoongArchCPU *cpu)
 {
     CPULoongArchState *env = &cpu->env;
     CPUState *cs = CPU(cpu);
     CPUSysState *sys = env_sys(env);
 
     if (FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS)) {
-        if (!FIELD_EX64(old, CSR_ESTAT, IS)) {
-            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
-        }
+        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
     } else {
-        if (FIELD_EX64(old, CSR_ESTAT, IS)) {
-            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
-        }
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
     }
 }
 
@@ -81,13 +77,11 @@ static void loongarch_cpu_self_set_irq(CPUState *cs, run_on_cpu_data data)
     CPULoongArchState *env = cpu_env(cs);
     CPUSysState *sys = env_sys(env);
     int irq, level;
-    uint64_t old;
 
     irq = data.host_int & ~BIT(31);
     level = (data.host_int >> 31) & 1;
-    old = sys->CSR_ESTAT;
     sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, irq, 1, level != 0);
-    loongarch_cpu_update_irq(cpu, old);
+    loongarch_cpu_update_irq(cpu);
 }
 
 void loongarch_cpu_set_irq(void *opaque, int irq, int level)
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index f9a0680fe0..ff956823fd 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -31,7 +31,7 @@ void restore_fp_status(CPULoongArchState *env);
 #ifndef CONFIG_USER_ONLY
 extern const VMStateDescription vmstate_loongarch_cpu;
 
-void loongarch_cpu_update_irq(LoongArchCPU *cpu, uint64_t old);
+void loongarch_cpu_update_irq(LoongArchCPU *cpu);
 void loongarch_cpu_set_irq(void *opaque, int irq, int level);
 
 void cpu_loongarch_timer_cb(void *opaque);
diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index 88656b5344..1a6919417f 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -111,7 +111,7 @@ target_ulong helper_csrwr_estat(CPULoongArchState *env, target_ulong val)
      */
     if (sys->CSR_ESTAT != old_v) {
         bql_lock();
-        loongarch_cpu_update_irq(env_archcpu(env), old_v);
+        loongarch_cpu_update_irq(env_archcpu(env));
         bql_unlock();
     }
 

base-commit: 7074591d7954876951f84c15b994a43251d5a3c1
-- 
2.54.0


