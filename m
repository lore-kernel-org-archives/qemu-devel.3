Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A028FC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 09:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7X9G-0007lN-CK; Thu, 16 May 2024 05:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s7X9D-0007jQ-8n
 for qemu-devel@nongnu.org; Thu, 16 May 2024 05:11:35 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s7X9A-0006Nt-Rs
 for qemu-devel@nongnu.org; Thu, 16 May 2024 05:11:34 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cxyem8zUVmJHQNAA--.20194S3;
 Thu, 16 May 2024 17:11:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cx71u4zUVm+8ciAA--.2860S3; 
 Thu, 16 May 2024 17:11:23 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 1/5] hw/loongarch: Add compat machine for 9.1
Date: Thu, 16 May 2024 17:11:16 +0800
Message-Id: <20240516091120.1021435-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240516091120.1021435-1-gaosong@loongson.cn>
References: <20240516091120.1021435-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx71u4zUVm+8ciAA--.2860S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

From: Bibo Mao <maobibo@loongson.cn>

Since migration test case requires compat machine type support,
compat machine is added for qemu 9.1 here.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240511034220.3030560-2-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/virt.c | 61 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 48 insertions(+), 13 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index f0640d2d80..f24ff5fcf4 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1231,18 +1231,53 @@ static void virt_class_init(ObjectClass *oc, void *data)
 #endif
 }
 
-static const TypeInfo virt_machine_types[] = {
-    {
-        .name           = TYPE_LOONGARCH_VIRT_MACHINE,
-        .parent         = TYPE_MACHINE,
-        .instance_size  = sizeof(LoongArchVirtMachineState),
-        .class_init     = virt_class_init,
-        .instance_init  = virt_initfn,
-        .interfaces = (InterfaceInfo[]) {
-         { TYPE_HOTPLUG_HANDLER },
-         { }
-        },
-    }
+#define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
+    static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
+                                                    void *data) \
+    { \
+        MachineClass *mc = MACHINE_CLASS(oc); \
+        virt_machine_##major##_##minor##_options(mc); \
+        mc->desc = "QEMU " # major "." # minor " LoongArch Virtual Machine"; \
+        if (latest) { \
+            mc->alias = "virt"; \
+        } \
+    } \
+    static const TypeInfo machvirt_##major##_##minor##_info = { \
+        .name = MACHINE_TYPE_NAME("virt-" # major "." # minor), \
+        .parent = TYPE_LOONGARCH_VIRT_MACHINE, \
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
+
+static const TypeInfo virt_machine_info = {
+    .name           = TYPE_LOONGARCH_VIRT_MACHINE,
+    .parent         = TYPE_MACHINE,
+    .abstract       = true,
+    .instance_size  = sizeof(LoongArchVirtMachineState),
+    .class_init     = virt_class_init,
+    .instance_init  = virt_initfn,
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
+static void virt_machine_9_1_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(9, 1)
-- 
2.34.1


