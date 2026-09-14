Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD1FC88E5C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 02:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5wCE-0001H7-Hd; Sun, 13 Sep 2026 22:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x5wC1-0001CI-Ag
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 22:13:13 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x5wBw-0007C4-Ma
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 22:13:10 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8BxLtMvWKdqf6ULAA--.33681S3;
 Mon, 14 Sep 2026 10:13:03 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJDxTs8rWKdqC2ggAA--.4739S3;
 Mon, 14 Sep 2026 10:13:02 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Subject: [PATCH 1/6] hw/intc/loongarch_dintc: Check irqchip in kernel mode
 firstly
Date: Mon, 14 Sep 2026 10:14:15 +0800
Message-ID: <20260914021420.4065683-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260914021420.4065683-1-maobibo@loongson.cn>
References: <20260914021420.4065683-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxTs8rWKdqC2ggAA--.4739S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cr1xJrW5Jw17CF4UZw15ZFc_yoW8Gw13pr
 W7u390gF4rA398XFs3ta48Zr15Crsa9342qFsIkFyxCF4kXrn8Wr1xJr1xXFyUK34UWayj
 vrn5G3W5uF15AFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
 jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
 x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
 8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
 0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7TKZDUUUU
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

when inject MSI interrupt, check irqchip in kernel mode at first and
then check validity of MSI message in TCG mode, since irqchip in kernel
is used at most popular.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_dintc.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/intc/loongarch_dintc.c b/hw/intc/loongarch_dintc.c
index c01f1fe07e..dd6fe6e241 100644
--- a/hw/intc/loongarch_dintc.c
+++ b/hw/intc/loongarch_dintc.c
@@ -72,6 +72,15 @@ static void loongarch_dintc_mem_write(void *opaque, hwaddr addr,
     DINTCCore *core;
     CPUState *cs;
 
+    if (kvm_irqchip_in_kernel()) {
+        MSIMessage msg;
+
+        msg.address = msg_addr;
+        msg.data = val;
+        kvm_irqchip_send_msi(kvm_state, msg);
+        return;
+    }
+
     arch_id = FIELD_EX64(msg_addr, MSG_ADDR, CPU_NUM);
     core = loongarch_dintc_cpu_by_arch_id(s, arch_id);
     if (!core || !core->cpu) {
@@ -83,16 +92,6 @@ static void loongarch_dintc_mem_write(void *opaque, hwaddr addr,
     cpu_num = core - s->cpu;
     cs = core->cpu;
     irq_num = FIELD_EX64(msg_addr, MSG_ADDR, IRQ_NUM);
-
-    if (kvm_irqchip_in_kernel()) {
-        MSIMessage msg;
-
-        msg.address = msg_addr;
-        msg.data = val;
-        kvm_irqchip_send_msi(kvm_state, msg);
-        return;
-    }
-
     async_run_on_cpu(cs, do_set_vcpu_dintc_irq,
                          RUN_ON_CPU_HOST_INT(irq_num));
     qemu_set_irq(s->cpu[cpu_num].parent_irq, 1);
-- 
2.54.0


