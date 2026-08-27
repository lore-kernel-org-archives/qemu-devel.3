Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F40C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzUu9-0003ul-PF; Thu, 27 Aug 2026 03:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wzUu6-0003rH-LL
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 03:52:06 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wzUu3-00050j-Eu
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 03:52:06 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8Ax39Ka7I9quZwFAA--.15510S3;
 Thu, 27 Aug 2026 15:51:54 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJAxnM6Z7I9qFvwTAA--.16948S4;
 Thu, 27 Aug 2026 15:51:54 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Subject: [PATCH 2/3] hw/intc/loongarch_pch_pic: Add pic interrupt status
 display
Date: Thu, 27 Aug 2026 15:53:09 +0800
Message-ID: <20260827075310.1389232-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827075310.1389232-1-maobibo@loongson.cn>
References: <20260827075310.1389232-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxnM6Z7I9qFvwTAA--.16948S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJFW5Jr45GFWfury8Jw43urX_yoW5CF43pF
 W7uFnxJr4DGFsrXr93Z345ZF1FqFyxur13KanxA3y0krZ8Gr1DXa48trW29F1UK393Cr12
 gws5t3WYg3WUCrbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
 kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2nYFDUUUU
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

When irqchip in kernel is enabled, the register status of pch_pic irqchip
is in KVM kernel. Here add interrupt status display in user side in order
to debug pch_pic irqchip driver.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c | 38 +++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index e87c7497c1..34090514ec 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -9,6 +9,7 @@
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "hw/core/irq.h"
+#include "hw/intc/intc.h"
 #include "hw/intc/loongarch_pch_pic.h"
 #include "system/kvm.h"
 #include "trace.h"
@@ -331,11 +332,43 @@ static int loongarch_pic_post_load(LoongArchPICCommonState *opaque,
     return 0;
 }
 
+static void loongarch_pic_print_info(InterruptStatsProvider *obj, GString *buf)
+{
+    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(obj);
+    uint64_t *vector;
+
+    loongarch_pic_pre_save(s);
+    g_string_append_printf(buf, "%s:\n", object_get_typename(OBJECT(obj)));
+
+    g_string_append_printf(buf, "  mask     0x%016"PRIx64" msi_en 0x%016"PRIx64
+                                " edge 0x%016"PRIx64" clr    0x%016"PRIx64"\n",
+                                s->int_mask, s->htmsi_en, s->intedge,
+                                s->intclr);
+
+    g_string_append_printf(buf, "  last_irr 0x%016"PRIx64" irr    0x%016"PRIx64
+                                " isr  0x%016"PRIx64" polary 0x%016"PRIx64"\n",
+                                s->last_intirr, s->intirr, s->intisr,
+                                s->int_polarity);
+
+    vector = (uint64_t *)s->htmsi_vector;
+    g_string_append_printf(buf, "  MSI map  0x%016"PRIx64" 0x%016"PRIx64
+                                " 0x%016"PRIx64" 0x%016"PRIx64"\n",
+                                *vector, *(vector + 1), *(vector + 2),
+                                *(vector + 3));
+
+    vector += 4;
+    g_string_append_printf(buf, "           0x%016"PRIx64" 0x%016"PRIx64
+                                " 0x%016"PRIx64" 0x%016"PRIx64"\n",
+                                *vector, *(vector + 1), *(vector + 2),
+                                *(vector + 3));
+}
+
 static void loongarch_pic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     LoongarchPICClass *lpc = LOONGARCH_PIC_CLASS(klass);
     LoongArchPICCommonClass *lpcc = LOONGARCH_PIC_COMMON_CLASS(klass);
+    InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     resettable_class_set_parent_phases(rc, NULL, loongarch_pic_reset_hold,
@@ -344,6 +377,7 @@ static void loongarch_pic_class_init(ObjectClass *klass, const void *data)
                                     &lpc->parent_realize);
     lpcc->pre_save = loongarch_pic_pre_save;
     lpcc->post_load = loongarch_pic_post_load;
+    ic->print_info = loongarch_pic_print_info;
 }
 
 static const TypeInfo loongarch_pic_types[] = {
@@ -353,6 +387,10 @@ static const TypeInfo loongarch_pic_types[] = {
         .instance_size      = sizeof(LoongarchPICState),
         .class_size         = sizeof(LoongarchPICClass),
         .class_init         = loongarch_pic_class_init,
+        .interfaces         = (const InterfaceInfo[]) {
+            { TYPE_INTERRUPT_STATS_PROVIDER },
+            { }
+        },
     }
 };
 
-- 
2.54.0


