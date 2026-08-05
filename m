Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D869AC55822
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 08:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrXGE-0005GP-KO; Wed, 05 Aug 2026 04:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wrXGC-0005GA-PZ
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 04:46:00 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wrXG9-0004J3-RV
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 04:46:00 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8Bx+aA4+HJqrpYKAA--.11215S3;
 Wed, 05 Aug 2026 16:45:44 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJDxTsc4+HJqeYUkAA--.57145S2;
 Wed, 05 Aug 2026 16:45:44 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
 "Andrew S . Rightenburg" <andrew@rail5.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2] target/loongarch: Fix SWI interrupt delivery via CSR_ESTAT
Date: Wed,  5 Aug 2026 16:47:05 +0800
Message-ID: <20260805084705.898107-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxTsc4+HJqeYUkAA--.57145S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJFWrJr4fuF4DAr15GFykWFX_yoWrJr17pr
 W7ur15tw48GrWDJas8Was8urn8Zr47Gry29an3K34fCrW5Jw1aqF1vyasFgFs8G345Wry0
 qFyFyw18Za1UZacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
 kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU70PfDUUUU
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

In TCG mode, helper_csrwr_estat() updates CSR.ESTAT.IS[1:0] (SWI0/SWI1)
when the guest writes CSR_ESTAT, but it did not update the CPU interrupt
request state. As a result, software interrupts could be observed as pending
in CSR.ESTAT while no interrupt exception was taken.

Update CPU_INTERRUPT_HARD after modifying CSR_ESTAT, matching the behavior of
loongarch_cpu_set_irq(). The helper runs without the Big QEMU Lock (BQL), so
take the BQL while calling cpu_interrupt().

Fixes: 5b1dedfe848b ("target/loongarch: Add LoongArch CSR instruction")
Reported-by: Andrew S. Rightenburg <andrew@rail5.org>
Signed-off-by: Andrew S. Rightenburg <andrew@rail5.org>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c            | 20 ++++++++++++++------
 target/loongarch/internals.h      |  1 +
 target/loongarch/tcg/csr_helper.c | 10 ++++++++++
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index fb03424ffa..4d9f7b08de 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -57,11 +57,23 @@ static vaddr loongarch_cpu_get_pc(CPUState *cs)
 #ifndef CONFIG_USER_ONLY
 #include "hw/loongarch/virt.h"
 
+void loongarch_cpu_update_irq(LoongArchCPU *cpu)
+{
+    CPULoongArchState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+    CPUSysState *sys = env_sys(env);
+
+    if (FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS)) {
+        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+    } else {
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+    }
+}
+
 void loongarch_cpu_set_irq(void *opaque, int irq, int level)
 {
     LoongArchCPU *cpu = opaque;
     CPULoongArchState *env = &cpu->env;
-    CPUState *cs = CPU(cpu);
     CPUSysState *sys = env_sys(env);
 
     if (irq < 0 || irq >= N_IRQS) {
@@ -72,11 +84,7 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
         kvm_loongarch_set_interrupt(cpu, irq, level);
     } else if (tcg_enabled()) {
         sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, irq, 1, level != 0);
-        if (FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS)) {
-            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
-        } else {
-            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
-        }
+        loongarch_cpu_update_irq(cpu);
     }
 }
 
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index e01dbed40f..40565ee91b 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -31,6 +31,7 @@ void restore_fp_status(CPULoongArchState *env);
 #ifndef CONFIG_USER_ONLY
 extern const VMStateDescription vmstate_loongarch_cpu;
 
+void loongarch_cpu_update_irq(LoongArchCPU *cpu);
 void loongarch_cpu_set_irq(void *opaque, int irq, int level);
 
 void loongarch_constant_timer_cb(void *opaque);
diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index 7dc33bc180..a9db071098 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -106,6 +106,16 @@ target_ulong helper_csrwr_estat(CPULoongArchState *env, target_ulong val)
 
     /* Only IS[1:0] can be written */
     sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, 0, 2, val);
+    /*
+     * Software interrupts (SWI0/SWI1) are latched in CSR.ESTAT.IS[1:0].
+     * Make sure the CPU interrupt request state tracks the pending bits,
+     * matching the behavior of loongarch_cpu_set_irq().
+     */
+    if ((old_v ^ val) & 0x3) {
+        bql_lock();
+        loongarch_cpu_update_irq(env_archcpu(env));
+        bql_unlock();
+    }
 
     return old_v;
 }

base-commit: b428fe036233cbd15d37e3c027ab6ca4d3661a80
-- 
2.54.0


