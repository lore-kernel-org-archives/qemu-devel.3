Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFB5CF58F1
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 09:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srZZv-0006v8-If; Fri, 20 Sep 2024 05:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1srZZs-0006je-57
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 05:05:24 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1srZZm-0003yW-Cg
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 05:05:22 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxOOnKOu1mWu8LAA--.26264S3;
 Fri, 20 Sep 2024 17:05:14 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxn+TDOu1mdmoKAA--.59343S10;
 Fri, 20 Sep 2024 17:05:13 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 08/10] hw/intc/loongarch_extioi: Inherit from
 loongarch_extioi_common
Date: Fri, 20 Sep 2024 17:05:05 +0800
Message-Id: <20240920090507.2692125-9-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240920090507.2692125-1-maobibo@loongson.cn>
References: <20240920090507.2692125-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn+TDOu1mdmoKAA--.59343S10
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

Set TYPE_LOONGARCH_EXTIOI inherit from TYPE_LOONGARCH_EXTIOI_COMMON
object, it shares vmsate and property of TYPE_LOONGARCH_EXTIOI_COMMON,
and has its own realize() function.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_extioi.c                | 37 ++++++++++-----------
 hw/intc/loongarch_extioi_common.c         | 39 ++++++++++++++++++++++-
 hw/intc/meson.build                       |  2 +-
 include/hw/intc/loongarch_extioi.h        | 17 ++++++++--
 include/hw/intc/loongarch_extioi_common.h | 13 ++++++++
 5 files changed, 84 insertions(+), 24 deletions(-)

diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index a6f489b885..adaf9dc2c5 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -323,17 +323,15 @@ static const MemoryRegionOps extioi_virt_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static int vmstate_extioi_post_load(void *opaque, int version_id);
-#include "loongarch_extioi_common.c"
-
 static void loongarch_extioi_realize(DeviceState *dev, Error **errp)
 {
-    LoongArchExtIOI *s = LOONGARCH_EXTIOI(dev);
+    LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI_COMMON(dev);
+    LoongArchExtIOIClass *lec = LOONGARCH_EXTIOI_GET_CLASS(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     Error *local_err = NULL;
     int i, pin;
 
-    loongarch_extioi_common_realize(dev, &local_err);
+    lec->parent_realize(dev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -404,24 +402,23 @@ static int vmstate_extioi_post_load(void *opaque, int version_id)
 static void loongarch_extioi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    LoongArchExtIOIClass *lec = LOONGARCH_EXTIOI_CLASS(klass);
+    LoongArchExtIOICommonClass *lecc = LOONGARCH_EXTIOI_COMMON_CLASS(klass);
 
-    dc->realize = loongarch_extioi_realize;
-    dc->unrealize = loongarch_extioi_unrealize;
+    device_class_set_parent_realize(dc, loongarch_extioi_realize,
+                                    &lec->parent_realize);
+    device_class_set_parent_unrealize(dc, loongarch_extioi_unrealize,
+                                      &lec->parent_unrealize);
     device_class_set_legacy_reset(dc, loongarch_extioi_reset);
-    device_class_set_props(dc, extioi_properties);
-    dc->vmsd = &vmstate_loongarch_extioi;
+    lecc->post_load = vmstate_extioi_post_load;
 }
 
-static const TypeInfo loongarch_extioi_info = {
-    .name          = TYPE_LOONGARCH_EXTIOI,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(struct LoongArchExtIOI),
-    .class_init    = loongarch_extioi_class_init,
+static const TypeInfo loongarch_extioi_types[] = {
+    {
+        .name         = TYPE_LOONGARCH_EXTIOI,
+        .parent       = TYPE_LOONGARCH_EXTIOI_COMMON,
+        .class_init   = loongarch_extioi_class_init,
+    }
 };
 
-static void loongarch_extioi_register_types(void)
-{
-    type_register_static(&loongarch_extioi_info);
-}
-
-type_init(loongarch_extioi_register_types)
+DEFINE_TYPES(loongarch_extioi_types)
diff --git a/hw/intc/loongarch_extioi_common.c b/hw/intc/loongarch_extioi_common.c
index 13f02fc5ab..af15ec3531 100644
--- a/hw/intc/loongarch_extioi_common.c
+++ b/hw/intc/loongarch_extioi_common.c
@@ -3,6 +3,12 @@
  * Loongson extioi interrupt controller emulation
  * Copyright (C) 2024 Loongson Technology Corporation Limited
  */
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "hw/qdev-properties.h"
+#include "hw/intc/loongarch_extioi_common.h"
+#include "migration/vmstate.h"
 
 static void loongarch_extioi_common_realize(DeviceState *dev, Error **errp)
 {
@@ -16,7 +22,14 @@ static void loongarch_extioi_common_realize(DeviceState *dev, Error **errp)
 
 static int loongarch_extioi_common_post_load(void *opaque, int version_id)
 {
-    return vmstate_extioi_post_load(opaque, version_id);
+    LoongArchExtIOICommonState *s = (LoongArchExtIOICommonState *)opaque;
+    LoongArchExtIOICommonClass *lecc = LOONGARCH_EXTIOI_COMMON_GET_CLASS(s);
+
+    if (lecc->post_load) {
+        return lecc->post_load(s, version_id);
+    }
+
+    return 0;
 }
 
 static const VMStateDescription vmstate_extioi_core = {
@@ -61,3 +74,27 @@ static Property extioi_properties[] = {
                     features, EXTIOI_HAS_VIRT_EXTENSION, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
+
+static void loongarch_extioi_common_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    LoongArchExtIOICommonClass *lecc = LOONGARCH_EXTIOI_COMMON_CLASS(klass);
+
+    device_class_set_parent_realize(dc, loongarch_extioi_common_realize,
+                                    &lecc->parent_realize);
+    device_class_set_props(dc, extioi_properties);
+    dc->vmsd = &vmstate_loongarch_extioi;
+}
+
+static const TypeInfo loongarch_extioi_common_types[] = {
+    {
+        .name               = TYPE_LOONGARCH_EXTIOI_COMMON,
+        .parent             = TYPE_SYS_BUS_DEVICE,
+        .instance_size      = sizeof(LoongArchExtIOICommonState),
+        .class_size         = sizeof(LoongArchExtIOICommonClass),
+        .class_init         = loongarch_extioi_common_class_init,
+        .abstract           = true,
+    }
+};
+
+DEFINE_TYPES(loongarch_extioi_common_types)
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 6bfdc4eb33..2f936d9f80 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -73,4 +73,4 @@ specific_ss.add(when: 'CONFIG_LOONGSON_IPI', if_true: files('loongson_ipi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_IPI', if_true: files('loongarch_ipi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_PIC', if_true: files('loongarch_pch_pic.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_MSI', if_true: files('loongarch_pch_msi.c'))
-specific_ss.add(when: 'CONFIG_LOONGARCH_EXTIOI', if_true: files('loongarch_extioi.c'))
+specific_ss.add(when: 'CONFIG_LOONGARCH_EXTIOI', if_true: files('loongarch_extioi.c', 'loongarch_extioi_common.c'))
diff --git a/include/hw/intc/loongarch_extioi.h b/include/hw/intc/loongarch_extioi.h
index d6747046b4..cc160c52dc 100644
--- a/include/hw/intc/loongarch_extioi.h
+++ b/include/hw/intc/loongarch_extioi.h
@@ -10,7 +10,20 @@
 
 #include "hw/intc/loongarch_extioi_common.h"
 
-#define LoongArchExtIOI LoongArchExtIOICommonState
 #define TYPE_LOONGARCH_EXTIOI "loongarch.extioi"
-OBJECT_DECLARE_SIMPLE_TYPE(LoongArchExtIOI, LOONGARCH_EXTIOI)
+OBJECT_DECLARE_TYPE(LoongArchExtIOIState, LoongArchExtIOIClass, LOONGARCH_EXTIOI)
+
+struct LoongArchExtIOIState {
+    LoongArchExtIOICommonState parent_obj;
+};
+
+struct LoongArchExtIOIClass {
+    LoongArchExtIOICommonClass parent_class;
+
+    DeviceRealize parent_realize;
+    DeviceUnrealize parent_unrealize;
+};
+
+#define LoongArchExtIOI         LoongArchExtIOICommonState
+#define LOONGARCH_EXTIOI(obj)   ((LoongArchExtIOICommonState *)obj)
 #endif /* LOONGARCH_EXTIOI_H */
diff --git a/include/hw/intc/loongarch_extioi_common.h b/include/hw/intc/loongarch_extioi_common.h
index 51243b8092..91947c81db 100644
--- a/include/hw/intc/loongarch_extioi_common.h
+++ b/include/hw/intc/loongarch_extioi_common.h
@@ -7,6 +7,7 @@
 #ifndef LOONGARCH_EXTIOI_COMMON_H
 #define LOONGARCH_EXTIOI_COMMON_H
 
+#include "qom/object.h"
 #include "hw/sysbus.h"
 #include "hw/loongarch/virt.h"
 
@@ -56,6 +57,10 @@
 #define EXTIOI_VIRT_COREMAP_START    (0x40)
 #define EXTIOI_VIRT_COREMAP_END      (0x240)
 
+#define TYPE_LOONGARCH_EXTIOI_COMMON "loongarch_extioi_common"
+OBJECT_DECLARE_TYPE(LoongArchExtIOICommonState,
+                    LoongArchExtIOICommonClass, LOONGARCH_EXTIOI_COMMON)
+
 typedef struct ExtIOICore {
     uint32_t coreisr[EXTIOI_IRQS_GROUP_COUNT];
     DECLARE_BITMAP(sw_isr[LS3A_INTC_IP], EXTIOI_IRQS);
@@ -82,4 +87,12 @@ struct LoongArchExtIOICommonState {
     MemoryRegion extioi_system_mem;
     MemoryRegion virt_extend;
 };
+
+struct LoongArchExtIOICommonClass {
+    SysBusDeviceClass parent_class;
+
+    DeviceRealize parent_realize;
+    DeviceUnrealize parent_unrealize;
+    int (*post_load)(void *s, int version_id);
+};
 #endif /* LOONGARCH_EXTIOI_H */
-- 
2.39.3


