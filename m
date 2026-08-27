Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5355C61DBD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 01:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzPEC-00025W-JY; Wed, 26 Aug 2026 21:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wzPEA-00024z-2y
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 21:48:26 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wzPE7-0007pR-KU
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 21:48:25 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx+9Fil49qg4YFAA--.15590S3;
 Thu, 27 Aug 2026 09:48:18 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCx+c1dl49q1KwTAA--.16714S5;
 Thu, 27 Aug 2026 09:48:18 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Bibo Mao <maobibo@loongson.cn>,
 "Andrew S . Rightenburg" <andrew@rail5.org>, Song Gao <17746591750@163.com>
Subject: [PULL 3/3] target/loongarch: Fix SWI interrupt delivery via CSR_ESTAT
Date: Thu, 27 Aug 2026 09:28:11 +0800
Message-Id: <20260827012811.1008381-4-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260827012811.1008381-1-gaosong@loongson.cn>
References: <20260827012811.1008381-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCx+c1dl49q1KwTAA--.16714S5
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

From: Bibo Mao <maobibo@loongson.cn>

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
Reviewed-by:  Song Gao <17746591750@163.com>
Message-ID: <20260806120315.1059413-1-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.c            | 26 ++++++++++++++++++++------
 target/loongarch/internals.h      |  1 +
 target/loongarch/tcg/csr_helper.c | 10 ++++++++++
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index bd819247c7..84a130956d 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -58,12 +58,29 @@ static vaddr loongarch_cpu_get_pc(CPUState *cs)
 #ifndef CONFIG_USER_ONLY
 #include "hw/loongarch/virt.h"
 
+void loongarch_cpu_update_irq(LoongArchCPU *cpu, uint64_t old)
+{
+    CPULoongArchState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+    CPUSysState *sys = env_sys(env);
+
+    if (FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS)) {
+        if (!FIELD_EX64(old, CSR_ESTAT, IS)) {
+            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+        }
+    } else {
+        if (FIELD_EX64(old, CSR_ESTAT, IS)) {
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+        }
+    }
+}
+
 void loongarch_cpu_set_irq(void *opaque, int irq, int level)
 {
     LoongArchCPU *cpu = opaque;
     CPULoongArchState *env = &cpu->env;
-    CPUState *cs = CPU(cpu);
     CPUSysState *sys = env_sys(env);
+    uint64_t old;
 
     if (irq < 0 || irq >= N_IRQS) {
         return;
@@ -72,12 +89,9 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
     if (kvm_enabled()) {
         kvm_loongarch_set_interrupt(cpu, irq, level);
     } else if (tcg_enabled()) {
+        old = sys->CSR_ESTAT;
         sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, irq, 1, level != 0);
-        if (FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS)) {
-            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
-        } else {
-            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
-        }
+        loongarch_cpu_update_irq(cpu, old);
     }
 }
 
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index e01dbed40f..0b670f9466 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -31,6 +31,7 @@ void restore_fp_status(CPULoongArchState *env);
 #ifndef CONFIG_USER_ONLY
 extern const VMStateDescription vmstate_loongarch_cpu;
 
+void loongarch_cpu_update_irq(LoongArchCPU *cpu, uint64_t old);
 void loongarch_cpu_set_irq(void *opaque, int irq, int level);
 
 void loongarch_constant_timer_cb(void *opaque);
diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index 7dc33bc180..155482efc6 100644
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
+    if (sys->CSR_ESTAT != old_v) {
+        bql_lock();
+        loongarch_cpu_update_irq(env_archcpu(env), old_v);
+        bql_unlock();
+    }
 
     return old_v;
 }
-- 
2.55.0


