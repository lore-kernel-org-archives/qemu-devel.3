Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D632E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 01:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN0LX-0006JE-Ht; Sun, 15 Dec 2024 20:56:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tN0LO-0006Gn-Gl
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 20:56:25 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tN0LL-0007mO-I8
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 20:56:21 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Axjq_BiF9nhEBXAA--.15556S3;
 Mon, 16 Dec 2024 09:56:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxnsK3iF9nKNCEAA--.50112S8;
 Mon, 16 Dec 2024 09:56:15 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 06/18] hw/intc/loongarch_pch: Inherit from loongarch_pic_common
Date: Mon, 16 Dec 2024 09:55:55 +0800
Message-Id: <20241216015607.1795880-7-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241216015607.1795880-1-maobibo@loongson.cn>
References: <20241216015607.1795880-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxnsK3iF9nKNCEAA--.50112S8
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Set TYPE_LOONGARCH_PIC inherit from TYPE_LOONGARCH_PIC_COMMON object,
it shares vmsate and property of TYPE_LOONGARCH_PIC_COMMON, and has
its own realize() function.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c            | 38 ++++++++++++--------------
 hw/intc/loongarch_pic_common.c         | 32 +++++++++++++++++++++-
 hw/intc/meson.build                    |  2 +-
 include/hw/intc/loongarch_pch_pic.h    | 21 +++++++++++---
 include/hw/intc/loongarch_pic_common.h | 10 +++++++
 5 files changed, 77 insertions(+), 26 deletions(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index 25c612b366..11effd4cc9 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -379,14 +379,14 @@ static void loongarch_pch_pic_reset(DeviceState *d)
     s->int_polarity = 0x0;
 }
 
-#include "loongarch_pic_common.c"
-static void loongarch_pch_pic_realize(DeviceState *dev, Error **errp)
+static void loongarch_pic_realize(DeviceState *dev, Error **errp)
 {
-    LoongArchPCHPIC *s = LOONGARCH_PCH_PIC(dev);
-    SysBusDevice *sbd  = SYS_BUS_DEVICE(dev);
+    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(dev);
+    LoongarchPICClass *lpc = LOONGARCH_PIC_GET_CLASS(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     Error *local_err = NULL;
 
-    loongarch_pic_common_realize(dev, &local_err);
+    lpc->parent_realize(dev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -408,26 +408,24 @@ static void loongarch_pch_pic_realize(DeviceState *dev, Error **errp)
 
 }
 
-static void loongarch_pch_pic_class_init(ObjectClass *klass, void *data)
+static void loongarch_pic_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    LoongarchPICClass *lpc = LOONGARCH_PIC_CLASS(klass);
 
-    dc->realize = loongarch_pch_pic_realize;
     device_class_set_legacy_reset(dc, loongarch_pch_pic_reset);
-    dc->vmsd = &vmstate_loongarch_pic_common;
-    device_class_set_props(dc, loongarch_pic_common_properties);
+    device_class_set_parent_realize(dc, loongarch_pic_realize,
+                                    &lpc->parent_realize);
 }
 
-static const TypeInfo loongarch_pch_pic_info = {
-    .name          = TYPE_LOONGARCH_PCH_PIC,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(LoongArchPCHPIC),
-    .class_init    = loongarch_pch_pic_class_init,
+static const TypeInfo loongarch_pic_types[] = {
+   {
+        .name               = TYPE_LOONGARCH_PIC,
+        .parent             = TYPE_LOONGARCH_PIC_COMMON,
+        .instance_size      = sizeof(LoongarchPICState),
+        .class_size         = sizeof(LoongarchPICClass),
+        .class_init         = loongarch_pic_class_init,
+    }
 };
 
-static void loongarch_pch_pic_register_types(void)
-{
-    type_register_static(&loongarch_pch_pic_info);
-}
-
-type_init(loongarch_pch_pic_register_types)
+DEFINE_TYPES(loongarch_pic_types)
diff --git a/hw/intc/loongarch_pic_common.c b/hw/intc/loongarch_pic_common.c
index c8e0490d40..28e9376557 100644
--- a/hw/intc/loongarch_pic_common.c
+++ b/hw/intc/loongarch_pic_common.c
@@ -4,9 +4,15 @@
  * Copyright (C) 2024 Loongson Technology Corporation Limited
  */
 
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/intc/loongarch_pic_common.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+
 static void loongarch_pic_common_realize(DeviceState *dev, Error **errp)
 {
-    LoongArchPICCommonState *s = LOONGARCH_PCH_PIC(dev);
+    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(dev);
 
     if (!s->irq_num || s->irq_num  > VIRT_PCH_PIC_IRQ_NUM) {
         error_setg(errp, "Invalid 'pic_irq_num'");
@@ -39,3 +45,27 @@ static const VMStateDescription vmstate_loongarch_pic_common = {
         VMSTATE_END_OF_LIST()
     }
 };
+
+static void loongarch_pic_common_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    LoongArchPICCommonClass *lpcc = LOONGARCH_PIC_COMMON_CLASS(klass);
+
+    device_class_set_parent_realize(dc, loongarch_pic_common_realize,
+                                    &lpcc->parent_realize);
+    device_class_set_props(dc, loongarch_pic_common_properties);
+    dc->vmsd = &vmstate_loongarch_pic_common;
+}
+
+static const TypeInfo loongarch_pic_common_types[] = {
+    {
+        .name               = TYPE_LOONGARCH_PIC_COMMON,
+        .parent             = TYPE_SYS_BUS_DEVICE,
+        .instance_size      = sizeof(LoongArchPICCommonState),
+        .class_size         = sizeof(LoongArchPICCommonClass),
+        .class_init         = loongarch_pic_common_class_init,
+        .abstract           = true,
+    }
+};
+
+DEFINE_TYPES(loongarch_pic_common_types)
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 6bfdc4eb33..848cb6685e 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -71,6 +71,6 @@ specific_ss.add(when: 'CONFIG_M68K_IRQC', if_true: files('m68k_irqc.c'))
 specific_ss.add(when: 'CONFIG_LOONGSON_IPI_COMMON', if_true: files('loongson_ipi_common.c'))
 specific_ss.add(when: 'CONFIG_LOONGSON_IPI', if_true: files('loongson_ipi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_IPI', if_true: files('loongarch_ipi.c'))
-specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_PIC', if_true: files('loongarch_pch_pic.c'))
+specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_PIC', if_true: files('loongarch_pch_pic.c', 'loongarch_pic_common.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_MSI', if_true: files('loongarch_pch_msi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_EXTIOI', if_true: files('loongarch_extioi.c'))
diff --git a/include/hw/intc/loongarch_pch_pic.h b/include/hw/intc/loongarch_pch_pic.h
index 381accbf2b..f84be0ac62 100644
--- a/include/hw/intc/loongarch_pch_pic.h
+++ b/include/hw/intc/loongarch_pch_pic.h
@@ -10,9 +10,22 @@
 
 #include "hw/intc/loongarch_pic_common.h"
 
-#define LoongArchPCHPIC LoongArchPICCommonState
-#define TYPE_LOONGARCH_PCH_PIC "loongarch_pch_pic"
-#define PCH_PIC_NAME(name) TYPE_LOONGARCH_PCH_PIC#name
-OBJECT_DECLARE_SIMPLE_TYPE(LoongArchPCHPIC, LOONGARCH_PCH_PIC)
+#define TYPE_LOONGARCH_PIC  "loongarch_pic"
+#define PCH_PIC_NAME(name)  TYPE_LOONGARCH_PIC#name
+OBJECT_DECLARE_TYPE(LoongarchPICState, LoongarchPICClass, LOONGARCH_PIC)
+
+struct LoongarchPICState {
+    LoongArchPICCommonState parent_obj;
+};
+
+struct LoongarchPICClass {
+    LoongArchPICCommonClass parent_class;
+
+    DeviceRealize parent_realize;
+};
+
+#define TYPE_LOONGARCH_PCH_PIC TYPE_LOONGARCH_PIC
+typedef struct LoongArchPICCommonState LoongArchPCHPIC;
+#define LOONGARCH_PCH_PIC(obj)   ((struct LoongArchPICCommonState *)(obj))
 
 #endif /* HW_LOONGARCH_PCH_PIC_H */
diff --git a/include/hw/intc/loongarch_pic_common.h b/include/hw/intc/loongarch_pic_common.h
index 124bb7d226..0a1a28063c 100644
--- a/include/hw/intc/loongarch_pic_common.h
+++ b/include/hw/intc/loongarch_pic_common.h
@@ -40,6 +40,10 @@
 #define POL_LO_START                    0x40
 #define POL_HI_START                    0x44
 
+#define TYPE_LOONGARCH_PIC_COMMON "loongarch_pic_common"
+OBJECT_DECLARE_TYPE(LoongArchPICCommonState,
+                    LoongArchPICCommonClass, LOONGARCH_PIC_COMMON)
+
 struct LoongArchPICCommonState {
     SysBusDevice parent_obj;
 
@@ -67,4 +71,10 @@ struct LoongArchPICCommonState {
     MemoryRegion iomem8;
     unsigned int irq_num;
 };
+
+struct LoongArchPICCommonClass {
+    SysBusDeviceClass parent_class;
+
+    DeviceRealize parent_realize;
+};
 #endif  /* HW_LOONGARCH_PIC_COMMON_H */
-- 
2.43.5


