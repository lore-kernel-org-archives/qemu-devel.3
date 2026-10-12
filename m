Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B819CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGAog-0003Ql-0x; Mon, 12 Oct 2026 03:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xGAoe-0003QB-5K
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 03:51:24 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xGAob-0005BP-It
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 03:51:23 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8Bxb9NukcxqsN8UAA--.60527S3;
 Mon, 12 Oct 2026 15:51:10 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJDxxMxskcxqulkrAA--.64510S2;
 Mon, 12 Oct 2026 15:51:08 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH] target/loongarch: Add dynamic irq_nr field
Date: Mon, 12 Oct 2026 15:52:34 +0800
Message-ID: <20261012075234.2323986-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxxMxskcxqulkrAA--.64510S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uF4DKFy8tF13KFWfuF17Arc_yoW8ArWkpr
 ZrZr12gF48WFWkt34kC3yrur1DXr17WrW2va13tr97Cr4UJr4YgF1kt39F9Fn8Xa4rWF4I
 vF1rJ345XF4UXacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
 0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
 7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcV
 C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
 04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
 CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcUUUUU=
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

By default, the number of IRQs on the CPU side is N_IRQS. It will become
N_IRQS * 2 if LVZ is enabled in the future. This patch adds a
CPUArchState::irq_nr field to record the supported IRQ count.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c | 8 +++++---
 target/loongarch/cpu.h | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 54c2699897..9cf566f0f6 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -88,8 +88,9 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
 {
     LoongArchCPU *cpu = opaque;
     CPUState *cs = CPU(cpu);
+    CPULoongArchState *env = &cpu->env;
 
-    if (irq < 0 || irq >= N_IRQS) {
+    if (irq < 0 || irq >= env->irq_nr) {
         return;
     }
 
@@ -724,12 +725,13 @@ static void loongarch_cpu_init(Object *obj)
 {
 #ifndef CONFIG_USER_ONLY
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
-#ifdef CONFIG_TCG
     CPULoongArchState *env = &cpu->env;
+#ifdef CONFIG_TCG
     CPUTimerState *timer;
 #endif
 
-    qdev_init_gpio_in(DEVICE(cpu), loongarch_cpu_set_irq, N_IRQS);
+    env->irq_nr = N_IRQS;
+    qdev_init_gpio_in(DEVICE(cpu), loongarch_cpu_set_irq, env->irq_nr);
 #ifdef CONFIG_TCG
     timer = env_timer(env);
     timer->irq = IRQ_TIMER;
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index c592f69885..77ea8f03f9 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -437,6 +437,7 @@ typedef struct CPUArchState {
     uint32_t mp_state;
 #endif
     CPUSysState *sys_state;
+    unsigned int irq_nr;
 } CPULoongArchState;
 
 typedef struct LoongArchCPUTopo {

base-commit: 615ece3c406b262996e569f29ea6eed0d81c4d8d
-- 
2.54.0


