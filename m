Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B6FCAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 06:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1fYq-0008T0-Ab; Thu, 25 Sep 2025 02:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1v1fYV-00083B-Vv
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 02:34:19 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1v1fXj-0000UD-Cl
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 02:33:40 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bx2tEy4tRo32sOAA--.31356S3;
 Thu, 25 Sep 2025 14:33:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJBxpeQq4tRoj+iuAA--.30453S13;
 Thu, 25 Sep 2025 14:33:22 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 11/11] hw/loongarch: Implement DINTC plug/unplug interfaces
Date: Thu, 25 Sep 2025 14:09:36 +0800
Message-Id: <20250925060936.898618-12-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250925060936.898618-1-gaosong@loongson.cn>
References: <20250925060936.898618-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxpeQq4tRoj+iuAA--.30453S13
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

when cpu added, connect dintc irq to cpu INT_DMSI irq pin.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20250916122109.749813-12-gaosong@loongson.cn>
---
 hw/intc/loongarch_dintc.c | 71 +++++++++++++++++++++++++++++++++++++++
 hw/loongarch/virt.c       | 11 ++++++
 2 files changed, 82 insertions(+)

diff --git a/hw/intc/loongarch_dintc.c b/hw/intc/loongarch_dintc.c
index 08e70a0a0a..743eae9bc2 100644
--- a/hw/intc/loongarch_dintc.c
+++ b/hw/intc/loongarch_dintc.c
@@ -115,14 +115,81 @@ static void loongarch_dintc_init(Object *obj)
     return;
 }
 
+static DINTCCore *loongarch_dintc_get_cpu(LoongArchDINTCState *s,
+                                        DeviceState *dev)
+{
+    CPUClass *k = CPU_GET_CLASS(dev);
+    uint64_t arch_id = k->get_arch_id(CPU(dev));
+    int i;
+
+    for (i = 0; i < s->num_cpu; i++) {
+        if (s->cpu[i].arch_id == arch_id) {
+            return &s->cpu[i];
+        }
+    }
+
+    return NULL;
+}
+
+static void loongarch_dintc_cpu_plug(HotplugHandler *hotplug_dev,
+                                   DeviceState *dev, Error **errp)
+{
+    LoongArchDINTCState *s = LOONGARCH_DINTC(hotplug_dev);
+    Object *obj = OBJECT(dev);
+    DINTCCore *core;
+    int index;
+
+    if (!object_dynamic_cast(obj, TYPE_LOONGARCH_CPU)) {
+        warn_report("LoongArch DINTC: Invalid %s device type",
+                                       object_get_typename(obj));
+        return;
+    }
+    core = loongarch_dintc_get_cpu(s, dev);
+    if (!core) {
+        return;
+    }
+
+    core->cpu = CPU(dev);
+    index = core - s->cpu;
+
+    /* connect dintc msg irq to cpu irq */
+    qdev_connect_gpio_out(DEVICE(s), index, qdev_get_gpio_in(dev, INT_DMSI));
+    return;
+}
+
+static void loongarch_dintc_cpu_unplug(HotplugHandler *hotplug_dev,
+                                     DeviceState *dev, Error **errp)
+{
+    LoongArchDINTCState *s = LOONGARCH_DINTC(hotplug_dev);
+    Object *obj = OBJECT(dev);
+    DINTCCore *core;
+
+    if (!object_dynamic_cast(obj, TYPE_LOONGARCH_CPU)) {
+        warn_report("LoongArch DINTC: Invalid %s device type",
+                                       object_get_typename(obj));
+        return;
+    }
+
+    core = loongarch_dintc_get_cpu(s, dev);
+
+    if (!core) {
+        return;
+    }
+
+    core->cpu = NULL;
+}
+
 static void loongarch_dintc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
     LoongArchDINTCClass *lac = LOONGARCH_DINTC_CLASS(klass);
 
     dc->unrealize = loongarch_dintc_unrealize;
     device_class_set_parent_realize(dc, loongarch_dintc_realize,
                                     &lac->parent_realize);
+    hc->plug = loongarch_dintc_cpu_plug;
+    hc->unplug = loongarch_dintc_cpu_unplug;
 }
 
 static const TypeInfo loongarch_dintc_info = {
@@ -131,6 +198,10 @@ static const TypeInfo loongarch_dintc_info = {
     .instance_size = sizeof(LoongArchDINTCState),
     .instance_init = loongarch_dintc_init,
     .class_init    = loongarch_dintc_class_init,
+    .interfaces    = (const InterfaceInfo[]) {
+        { TYPE_HOTPLUG_HANDLER },
+        { }
+    },
 };
 
 static void loongarch_dintc_register_types(void)
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index ccd94f5328..92035a2024 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -381,6 +381,10 @@ static void virt_cpu_irq_init(LoongArchVirtMachineState *lvms)
                              &error_abort);
         hotplug_handler_plug(HOTPLUG_HANDLER(lvms->extioi), DEVICE(cs),
                              &error_abort);
+	if (lvms->dintc) {
+            hotplug_handler_plug(HOTPLUG_HANDLER(lvms->dintc), DEVICE(cs),
+                                 &error_abort);
+        }
     }
 }
 
@@ -1103,6 +1107,9 @@ static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
     /* Notify ipi and extioi irqchip to remove interrupt routing to CPU */
     hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->ipi), dev, &error_abort);
     hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->extioi), dev, &error_abort);
+    if (lvms->dintc) {
+        hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->dintc), dev, &error_abort);
+    }
 
     /* Notify acpi ged CPU removed */
     hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &error_abort);
@@ -1127,6 +1134,10 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
         hotplug_handler_plug(HOTPLUG_HANDLER(lvms->extioi), dev, &error_abort);
     }
 
+    if (lvms->dintc) {
+        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->dintc), dev, &error_abort);
+    }
+
     if (lvms->acpi_ged) {
         hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev,
                              &error_abort);
-- 
2.47.0


