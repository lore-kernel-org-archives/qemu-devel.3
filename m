Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AC9C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 02:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x729H-0006O0-DD; Wed, 16 Sep 2026 22:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x7292-0006L1-Tw
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 22:46:41 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x7290-000591-N6
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 22:46:40 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8Axj9GIVKtqBuEMAA--.37807S3;
 Thu, 17 Sep 2026 10:46:32 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJCx+c18VKtqA60hAA--.39456S3;
 Thu, 17 Sep 2026 10:46:31 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Miao Wang <shankerwangmiao@gmail.com>, Xianglai Li <lixianglai@loongson.cn>
Subject: [PULL 01/11] target/loongarch: Fix data race in CSR_ESTAT
Date: Thu, 17 Sep 2026 10:47:32 +0800
Message-ID: <20260917024742.200257-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260917024742.200257-1-maobibo@loongson.cn>
References: <20260917024742.200257-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCx+c18VKtqA60hAA--.39456S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFy7tw1fWrW8CF15Cr1DCFX_yoW8Kr1kpr
 y7uryYqw4kGrZxZ3s5Ga9xXFn8ZF4fWF1IvanIkryfuFW5Jw45Wryvyas7XF1Du34rWF40
 9FWrJFW5WF4UCFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
 jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2I
 x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
 8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
 0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcUUUUU=
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

The CSR_ESTAT register of a CPU can be read and written by both the
CPU thread and other threads (e.g., the interrupt controller thread).
Currently the possible readers and writers of CSR_ESTAT are:

The access from the CPU thread is not synchronized with the access from
other threads, which may lead to data races. The above readers and
writers shall all run on the corresponding CPU thread except for
loongarch_cpu_set_irq(). To fix this, the access to CSR_ESTAT in
loongarch_cpu_set_irq() is moved to the CPU thread by using
async_run_on_cpu().

Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by:   Xianglai Li <lixianglai@loongson.cn>
---
 target/loongarch/cpu.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 18d73ebc1b..cd39572b5c 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -75,13 +75,26 @@ void loongarch_cpu_update_irq(LoongArchCPU *cpu, uint64_t old)
     }
 }
 
-void loongarch_cpu_set_irq(void *opaque, int irq, int level)
+static void loongarch_cpu_self_set_irq(CPUState *cs, run_on_cpu_data data)
 {
-    LoongArchCPU *cpu = opaque;
-    CPULoongArchState *env = &cpu->env;
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPULoongArchState *env = cpu_env(cs);
     CPUSysState *sys = env_sys(env);
+    int irq, level;
     uint64_t old;
 
+    irq = data.host_int & ~BIT(31);
+    level = (data.host_int >> 31) & 1;
+    old = sys->CSR_ESTAT;
+    sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, irq, 1, level != 0);
+    loongarch_cpu_update_irq(cpu, old);
+}
+
+void loongarch_cpu_set_irq(void *opaque, int irq, int level)
+{
+    LoongArchCPU *cpu = opaque;
+    CPUState *cs = CPU(cpu);
+
     if (irq < 0 || irq >= N_IRQS) {
         return;
     }
@@ -89,9 +102,9 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
     if (kvm_enabled()) {
         kvm_loongarch_set_interrupt(cpu, irq, level);
     } else if (tcg_enabled()) {
-        old = sys->CSR_ESTAT;
-        sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, irq, 1, level != 0);
-        loongarch_cpu_update_irq(cpu, old);
+        irq |= (level & 1) << 31;
+        async_run_on_cpu(cs, loongarch_cpu_self_set_irq,
+                         RUN_ON_CPU_HOST_INT(irq));
     }
 }
 
-- 
2.54.0


