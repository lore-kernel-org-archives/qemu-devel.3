Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90DA6C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 09:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXGaW-0007wg-6G; Thu, 03 Jul 2025 05:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uXGZq-0007No-A8
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:50:04 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uXGZo-0000SI-8k
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:49:58 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bx22o2UmZoV8AhAQ--.38509S3;
 Thu, 03 Jul 2025 17:49:42 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCxM+QuUmZoNv4HAA--.46770S13;
 Thu, 03 Jul 2025 17:49:42 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH v4 11/11] hw/loongarch: Implement AVEC plug/unplug interfaces
Date: Thu,  3 Jul 2025 17:26:50 +0800
Message-Id: <20250703092650.2598059-12-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250703092650.2598059-1-gaosong@loongson.cn>
References: <20250703092650.2598059-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxM+QuUmZoNv4HAA--.46770S13
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

when cpu added, connect avec irq to cpu INT_AVEC irq pin.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_avec.c | 71 ++++++++++++++++++++++++++++++++++++++++
 hw/loongarch/virt.c      |  7 ++++
 2 files changed, 78 insertions(+)

diff --git a/hw/intc/loongarch_avec.c b/hw/intc/loongarch_avec.c
index 8ccd6092e6..caca92bab6 100644
--- a/hw/intc/loongarch_avec.c
+++ b/hw/intc/loongarch_avec.c
@@ -117,14 +117,81 @@ static void loongarch_avec_init(Object *obj)
     return;
 }
 
+static AVECCore *loongarch_avec_get_cpu(LoongArchAVECState *s,
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
+static void loongarch_avec_cpu_plug(HotplugHandler *hotplug_dev,
+                                   DeviceState *dev, Error **errp)
+{
+    LoongArchAVECState *s = LOONGARCH_AVEC(hotplug_dev);
+    Object *obj = OBJECT(dev);
+    AVECCore *core;
+    int index;
+
+    if (!object_dynamic_cast(obj, TYPE_LOONGARCH_CPU)) {
+        warn_report("LoongArch AVEC: Invalid %s device type",
+                                       object_get_typename(obj));
+        return;
+    }
+    core = loongarch_avec_get_cpu(s, dev);
+    if (!core) {
+        return;
+    }
+
+    core->cpu = CPU(dev);
+    index = core - s->cpu;
+
+    /* connect avec msg irq to cpu irq */
+    qdev_connect_gpio_out(DEVICE(s), index, qdev_get_gpio_in(dev, INT_AVEC));
+    return;
+}
+
+static void loongarch_avec_cpu_unplug(HotplugHandler *hotplug_dev,
+                                     DeviceState *dev, Error **errp)
+{
+    LoongArchAVECState *s = LOONGARCH_AVEC(hotplug_dev);
+    Object *obj = OBJECT(dev);
+    AVECCore *core;
+
+    if (!object_dynamic_cast(obj, TYPE_LOONGARCH_CPU)) {
+        warn_report("LoongArch AVEC: Invalid %s device type",
+                                       object_get_typename(obj));
+        return;
+    }
+
+    core = loongarch_avec_get_cpu(s, dev);
+
+    if (!core) {
+        return;
+    }
+
+    core->cpu = NULL;
+}
+
 static void loongarch_avec_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
     LoongArchAVECClass *lac = LOONGARCH_AVEC_CLASS(klass);
 
     dc->unrealize = loongarch_avec_unrealize;
     device_class_set_parent_realize(dc, loongarch_avec_realize,
                                     &lac->parent_realize);
+    hc->plug = loongarch_avec_cpu_plug;
+    hc->unplug = loongarch_avec_cpu_unplug;
 }
 
 static const TypeInfo loongarch_avec_info = {
@@ -133,6 +200,10 @@ static const TypeInfo loongarch_avec_info = {
     .instance_size = sizeof(LoongArchAVECState),
     .instance_init = loongarch_avec_init,
     .class_init    = loongarch_avec_class_init,
+    .interfaces    = (const InterfaceInfo[]) {
+        { TYPE_HOTPLUG_HANDLER },
+        { }
+    },
 };
 
 static void loongarch_avec_register_types(void)
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 4a842ba3e6..d367c80624 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -377,6 +377,8 @@ static void virt_cpu_irq_init(LoongArchVirtMachineState *lvms)
                              &error_abort);
         hotplug_handler_plug(HOTPLUG_HANDLER(lvms->extioi), DEVICE(cs),
                              &error_abort);
+        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->avec), DEVICE(cs),
+                             &error_abort);
     }
 }
 
@@ -1088,6 +1090,7 @@ static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
     /* Notify ipi and extioi irqchip to remove interrupt routing to CPU */
     hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->ipi), dev, &error_abort);
     hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->extioi), dev, &error_abort);
+    hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->avec), dev, &error_abort);
 
     /* Notify acpi ged CPU removed */
     hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &error_abort);
@@ -1111,6 +1114,10 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
         hotplug_handler_plug(HOTPLUG_HANDLER(lvms->extioi), dev, &error_abort);
     }
 
+    if (lvms->avec) {
+        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->avec), dev, &error_abort);
+    }
+
     if (lvms->acpi_ged) {
         hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev,
                              &error_abort);
-- 
2.34.1


