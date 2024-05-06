Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06430C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 03:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3ocP-000770-7o; Sun, 05 May 2024 23:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1s3ocK-00073e-VH
 for qemu-devel@nongnu.org; Sun, 05 May 2024 23:02:17 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1s3ocH-0008H3-La
 for qemu-devel@nongnu.org; Sun, 05 May 2024 23:02:16 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxLOsxSDhmQOIHAA--.15497S3;
 Mon, 06 May 2024 11:02:09 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxvlcuSDhmFvwRAA--.31503S5; 
 Mon, 06 May 2024 11:02:08 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v3 3/5] hw/loongarch: Add compat machine for 9.0
Date: Mon,  6 May 2024 11:02:04 +0800
Message-Id: <20240506030206.2119832-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240506030206.2119832-1-maobibo@loongson.cn>
References: <20240506030206.2119832-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxvlcuSDhmFvwRAA--.31503S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
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

Since migration test case requires compat machine type support,
compat machine is added for qemu 9.0 here.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c | 60 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 13 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index c8d697f38f..8a6e2d6677 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -408,6 +408,32 @@ static void fdt_add_pcie_irq_map_node(const VirtMachineState *vms,
         }
     }
 
+#define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
+    static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
+                                                    void *data) \
+    { \
+        MachineClass *mc = MACHINE_CLASS(oc); \
+        virt_machine_##major##_##minor##_options(mc); \
+        mc->desc = "QEMU " # major "." # minor " ARM Virtual Machine"; \
+        if (latest) { \
+            mc->alias = "virt"; \
+        } \
+    } \
+    static const TypeInfo machvirt_##major##_##minor##_info = { \
+        .name = MACHINE_TYPE_NAME("virt-" # major "." # minor), \
+        .parent = TYPE_VIRT_MACHINE, \
+        .class_init = virt_##major##_##minor##_class_init, \
+    }; \
+    static void machvirt_machine_##major##_##minor##_init(void) \
+    { \
+        type_register_static(&machvirt_##major##_##minor##_info); \
+    } \
+    type_init(machvirt_machine_##major##_##minor##_init);
+
+#define DEFINE_VIRT_MACHINE_AS_LATEST(major, minor) \
+    DEFINE_VIRT_MACHINE_LATEST(major, minor, true)
+#define DEFINE_VIRT_MACHINE(major, minor) \
+    DEFINE_VIRT_MACHINE_LATEST(major, minor, false)
 
     qemu_fdt_setprop(ms->fdt, nodename, "interrupt-map", full_irq_map,
                      GPEX_NUM_IRQS * GPEX_NUM_IRQS *
@@ -1241,18 +1267,26 @@ static void virt_class_init(ObjectClass *oc, void *data)
 #endif
 }
 
-static const TypeInfo virt_machine_types[] = {
-    {
-        .name           = TYPE_VIRT_MACHINE,
-        .parent         = TYPE_MACHINE,
-        .instance_size  = sizeof(VirtMachineState),
-        .class_init     = virt_class_init,
-        .instance_init = virt_machine_initfn,
-        .interfaces = (InterfaceInfo[]) {
-         { TYPE_HOTPLUG_HANDLER },
-         { }
-        },
-    }
+static const TypeInfo virt_machine_info = {
+    .name           = TYPE_VIRT_MACHINE,
+    .parent         = TYPE_MACHINE,
+    .abstract       = true,
+    .instance_size  = sizeof(VirtMachineState),
+    .class_init     = virt_class_init,
+    .instance_init = virt_machine_initfn,
+    .interfaces = (InterfaceInfo[]) {
+    { TYPE_HOTPLUG_HANDLER },
+    { }
+    },
 };
 
-DEFINE_TYPES(virt_machine_types)
+static void machvirt_machine_init(void)
+{
+    type_register_static(&virt_machine_info);
+}
+type_init(machvirt_machine_init);
+
+static void virt_machine_9_0_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(9, 0)
-- 
2.39.3


