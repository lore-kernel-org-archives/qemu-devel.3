Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB52C021A1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 03:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thgdq-0007Cf-7f; Mon, 10 Feb 2025 22:08:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1thgdm-0007AT-Oj
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 22:08:50 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1thgdi-0000Lz-K8
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 22:08:50 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Bx3642v6pnC9dxAA--.49439S3;
 Tue, 11 Feb 2025 11:08:38 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxbsUyv6pnL1YLAA--.43924S5;
 Tue, 11 Feb 2025 11:08:38 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Subject: [PATCH v5 3/7] hw/loongarch/virt: Add basic cpu plug interface
 framework
Date: Tue, 11 Feb 2025 11:08:30 +0800
Message-Id: <20250211030834.3276732-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250211030834.3276732-1-maobibo@loongson.cn>
References: <20250211030834.3276732-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxbsUyv6pnL1YLAA--.43924S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
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

Add basic cpu hotplug interface framework, cpu hotplug interface is
stub function and only framework is added here.

Co-developed-by: Xianglai Li <lixianglai@loongson.cn>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c    | 29 +++++++++++++++++++++++++++++
 target/loongarch/cpu.c | 13 +++++++++++++
 target/loongarch/cpu.h |  1 +
 3 files changed, 43 insertions(+)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index cc53cf0b4a..a36b66c64d 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -824,6 +824,26 @@ static int virt_get_arch_id_from_topo(MachineState *ms, LoongArchCPUTopo *topo)
     return arch_id;
 }
 
+static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
+                              DeviceState *dev, Error **errp)
+{
+}
+
+static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
+                                    DeviceState *dev, Error **errp)
+{
+}
+
+static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
+                            DeviceState *dev, Error **errp)
+{
+}
+
+static void virt_cpu_plug(HotplugHandler *hotplug_dev,
+                          DeviceState *dev, Error **errp)
+{
+}
+
 static bool memhp_type_supported(DeviceState *dev)
 {
     /* we only support pc dimm now */
@@ -842,6 +862,8 @@ static void virt_device_pre_plug(HotplugHandler *hotplug_dev,
 {
     if (memhp_type_supported(dev)) {
         virt_mem_pre_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU)) {
+        virt_cpu_pre_plug(hotplug_dev, dev, errp);
     }
 }
 
@@ -860,6 +882,8 @@ static void virt_device_unplug_request(HotplugHandler *hotplug_dev,
 {
     if (memhp_type_supported(dev)) {
         virt_mem_unplug_request(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU)) {
+        virt_cpu_unplug_request(hotplug_dev, dev, errp);
     }
 }
 
@@ -878,6 +902,8 @@ static void virt_device_unplug(HotplugHandler *hotplug_dev,
 {
     if (memhp_type_supported(dev)) {
         virt_mem_unplug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU)) {
+        virt_cpu_unplug(hotplug_dev, dev, errp);
     }
 }
 
@@ -905,6 +931,8 @@ static void virt_device_plug_cb(HotplugHandler *hotplug_dev,
         }
     } else if (memhp_type_supported(dev)) {
         virt_mem_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU)) {
+        virt_cpu_plug(hotplug_dev, dev, errp);
     }
 }
 
@@ -914,6 +942,7 @@ static HotplugHandler *virt_get_hotplug_handler(MachineState *machine,
     MachineClass *mc = MACHINE_GET_CLASS(machine);
 
     if (device_is_dynamic_sysbus(mc, dev) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU) ||
         object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI) ||
         memhp_type_supported(dev)) {
         return HOTPLUG_HANDLER(machine);
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 3c877312cd..7e38949c56 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -641,6 +641,17 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
     lacc->parent_realize(dev, errp);
 }
 
+static void loongarch_cpu_unrealizefn(DeviceState *dev)
+{
+    LoongArchCPUClass *lacc = LOONGARCH_CPU_GET_CLASS(dev);
+
+#ifndef CONFIG_USER_ONLY
+    cpu_remove_sync(CPU(dev));
+#endif
+
+    lacc->parent_unrealize(dev);
+}
+
 static bool loongarch_get_lsx(Object *obj, Error **errp)
 {
     return LOONGARCH_CPU(obj)->lsx != ON_OFF_AUTO_OFF;
@@ -927,6 +938,8 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
     device_class_set_props(dc, loongarch_cpu_properties);
     device_class_set_parent_realize(dc, loongarch_cpu_realizefn,
                                     &lacc->parent_realize);
+    device_class_set_parent_unrealize(dc, loongarch_cpu_unrealizefn,
+                                      &lacc->parent_unrealize);
     resettable_class_set_parent_phases(rc, NULL, loongarch_cpu_reset_hold, NULL,
                                        &lacc->parent_phases);
 
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 0fb82a218b..cf93a0e7ad 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -434,6 +434,7 @@ struct LoongArchCPUClass {
     CPUClass parent_class;
 
     DeviceRealize parent_realize;
+    DeviceUnrealize parent_unrealize;
     ResettablePhases parent_phases;
 };
 
-- 
2.39.3


