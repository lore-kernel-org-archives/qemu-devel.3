Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0690C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3qLx-0002CG-HR; Tue, 08 Sep 2026 03:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x3qLu-0002AF-O5
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 03:34:46 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x3qLr-000070-9K
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 03:34:46 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8Bxn9GOup9qtbcJAA--.27746S3;
 Tue, 08 Sep 2026 15:34:38 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJBxrM6Nup9qVA0dAA--.29211S3;
 Tue, 08 Sep 2026 15:34:38 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>
Subject: [PULL 5/5] hw/intc/loongarch_extioi: Add extioi interrupt status
 display
Date: Tue,  8 Sep 2026 15:35:48 +0800
Message-ID: <20260908073548.3249551-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260908073548.3249551-1-maobibo@loongson.cn>
References: <20260908073548.3249551-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxrM6Nup9qVA0dAA--.29211S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWF1fAFyrGFy5GF48ZrWfCrX_yoW5Kw1rpF
 43uFW3Wr4UGanxJr9xWayDuF1rtws3ur12qFZFv348uayUGryDuas2qry7XF4UCws7t3Wv
 kwn5tryYgF1DArcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
 0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
 7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcV
 C0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
 04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
 CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1LiSJUUUUU==
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

When irqchip in kernel is enabled, the register status of extioi irqchip
is in KVM kernel. Here add interrupt status display in user side in order
to debug extioi irqchip driver.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Xianglai Li <lixianglai@loongson.cn>
---
 hw/intc/loongarch_extioi.c | 58 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index 2999740269..06f2aa7b14 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -10,6 +10,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "hw/core/irq.h"
+#include "hw/intc/intc.h"
 #include "hw/loongarch/virt.h"
 #include "system/address-spaces.h"
 #include "system/kvm.h"
@@ -420,11 +421,63 @@ static int vmstate_extioi_post_load(void *opaque, int version_id)
     return 0;
 }
 
+static void loongarch_extioi_print_info(InterruptStatsProvider *obj,
+                                        GString *buf)
+{
+    LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI_COMMON(obj);
+    uint64_t *val;
+    unsigned long irq;
+    ExtIOICore *core;
+    int i;
+
+    vmstate_extioi_pre_save(s);
+    g_string_append_printf(buf, "%s:\n", object_get_typename(OBJECT(obj)));
+
+    val = (uint64_t *)s->isr;
+    g_string_append_printf(buf, "  ISR     0x%016"PRIx64" 0x%016"PRIx64
+                                " 0x%016"PRIx64" 0x%016"PRIx64"\n",
+                                *val, *(val + 1), *(val + 2), *(val + 3));
+    val = (uint64_t *)s->enable;
+    g_string_append_printf(buf, "  ENABLE  0x%016"PRIx64" 0x%016"PRIx64
+                                " 0x%016"PRIx64" 0x%016"PRIx64"\n",
+                                *val, *(val + 1), *(val + 2), *(val + 3));
+    val = (uint64_t *)s->ipmap;
+    g_string_append_printf(buf, "  IPMAP   0x%016"PRIx64"\n", *val);
+
+    val = (uint64_t *)s->coremap;
+    for (i = 0; i < EXTIOI_IRQS; i += 32) {
+        g_string_append_printf(buf, "  COREMAP 0x%016"PRIx64" 0x%016"PRIx64
+                                    " 0x%016"PRIx64" 0x%016"PRIx64"\n",
+                                    *val, *(val + 1), *(val + 2), *(val + 3));
+        val += 4;
+    }
+
+    core = s->cpu;
+    for (i = 0; i < s->num_cpu; i++, core++) {
+        if (!core->cpu) {
+            continue;
+        }
+
+        irq = find_first_bit((unsigned long *)core->coreisr, EXTIOI_IRQS);
+        /* No pending IRQ */
+        if (irq == EXTIOI_IRQS) {
+            continue;
+        }
+
+        val = (uint64_t *)core->coreisr;
+        g_string_append_printf(buf, "  CPU[%d] ISR 0x%016"PRIx64" 0x%016"PRIx64
+                                    " 0x%016"PRIx64" 0x%016"PRIx64"\n",
+                                    i, *val, *(val + 1), *(val + 2),
+                                    *(val + 3));
+    }
+}
+
 static void loongarch_extioi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     LoongArchExtIOIClass *lec = LOONGARCH_EXTIOI_CLASS(klass);
     LoongArchExtIOICommonClass *lecc = LOONGARCH_EXTIOI_COMMON_CLASS(klass);
+    InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     device_class_set_parent_realize(dc, loongarch_extioi_realize,
@@ -433,6 +486,7 @@ static void loongarch_extioi_class_init(ObjectClass *klass, const void *data)
                                        NULL, &lec->parent_phases);
     lecc->pre_save  = vmstate_extioi_pre_save;
     lecc->post_load = vmstate_extioi_post_load;
+    ic->print_info = loongarch_extioi_print_info;
 }
 
 static const TypeInfo loongarch_extioi_types[] = {
@@ -442,6 +496,10 @@ static const TypeInfo loongarch_extioi_types[] = {
         .instance_size = sizeof(LoongArchExtIOIState),
         .class_size    = sizeof(LoongArchExtIOIClass),
         .class_init    = loongarch_extioi_class_init,
+        .interfaces         = (const InterfaceInfo[]) {
+            { TYPE_INTERRUPT_STATS_PROVIDER },
+            { }
+        },
     }
 };
 
-- 
2.54.0


