Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E4FC982CC
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 02:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7297-0006Ly-TJ; Wed, 16 Sep 2026 22:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x7293-0006L3-Bk
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 22:46:41 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x7291-00059C-Gr
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 22:46:41 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8DxTtONVKtqEOEMAA--.37253S3;
 Thu, 17 Sep 2026 10:46:37 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJBxKs6LVKtqCq0hAA--.39703S4;
 Thu, 17 Sep 2026 10:46:35 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Song Gao <17746591750@163.com>
Subject: [PULL 06/11] hw/intc/loongarch_dintc: Check irqchip in kernel mode
 firstly
Date: Thu, 17 Sep 2026 10:47:37 +0800
Message-ID: <20260917024742.200257-7-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260917024742.200257-1-maobibo@loongson.cn>
References: <20260917024742.200257-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxKs6LVKtqCq0hAA--.39703S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cr1xJrW5Jw17ury3trW8GrX_yoW8Xry3pr
 W7C390gF4rZ3s8Jrs3ta48Zr15Crsa9342qFsIkFyxCF48Xr1DWr1xJr17XFyUK34Uuayj
 vr1rG3W5uF15AFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
 0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
 7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcV
 C0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
 04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
 CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8xOz3UUUUU==
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
Reviewed-by:   Song Gao <17746591750@163.com>
---
 hw/intc/loongarch_dintc.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/intc/loongarch_dintc.c b/hw/intc/loongarch_dintc.c
index 1bedfbce43..674f5d1357 100644
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


