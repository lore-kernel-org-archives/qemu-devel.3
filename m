Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0895E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 09:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWAxD-00025A-Iv; Fri, 10 Jan 2025 04:05:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tWAwp-0001fp-Bc
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:04:58 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tWAwi-0005O4-Gb
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:04:53 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Cx73Om4oBn1g9hAA--.5175S3;
 Fri, 10 Jan 2025 17:04:38 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDx7sWk4oBn718cAA--.42742S4;
 Fri, 10 Jan 2025 17:04:38 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 2/4] hw/intc/loongarch_extioi: Add basic hotplug framework
Date: Fri, 10 Jan 2025 17:04:34 +0800
Message-Id: <20250110090436.2831690-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250110090436.2831690-1-maobibo@loongson.cn>
References: <20250110090436.2831690-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDx7sWk4oBn718cAA--.42742S4
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

LoongArch extioi interrupt controller routes peripheral interrupt
to multiple CPUs, physical cpu id is used in interrupt routing table.
Here hotplug interface is added for extioi object, so that parent irq
line can be connected, and routing table can be added for new created
cpu.

Here only basic hotplug framework is added, it is stub function.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_extioi_common.c | 33 +++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/hw/intc/loongarch_extioi_common.c b/hw/intc/loongarch_extioi_common.c
index e3a38b318a..19e19a9f73 100644
--- a/hw/intc/loongarch_extioi_common.c
+++ b/hw/intc/loongarch_extioi_common.c
@@ -4,11 +4,37 @@
  * Copyright (C) 2024 Loongson Technology Corporation Limited
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "hw/qdev-properties.h"
 #include "hw/intc/loongarch_extioi_common.h"
 #include "migration/vmstate.h"
+#include "target/loongarch/cpu.h"
+
+static void loongarch_extioi_cpu_plug(HotplugHandler *hotplug_dev,
+                                      DeviceState *dev, Error **errp)
+{
+    Object *obj = OBJECT(dev);
+
+    if (!object_dynamic_cast(obj, TYPE_LOONGARCH_CPU)) {
+        warn_report("LoongArch extioi: Invalid %s device type",
+                                       object_get_typename(obj));
+        return;
+    }
+}
+
+static void loongarch_extioi_cpu_unplug(HotplugHandler *hotplug_dev,
+                                        DeviceState *dev, Error **errp)
+{
+    Object *obj = OBJECT(dev);
+
+    if (!object_dynamic_cast(obj, TYPE_LOONGARCH_CPU)) {
+        warn_report("LoongArch extioi: Invalid %s device type",
+                                       object_get_typename(obj));
+        return;
+    }
+}
 
 static void loongarch_extioi_common_realize(DeviceState *dev, Error **errp)
 {
@@ -107,11 +133,14 @@ static void loongarch_extioi_common_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     LoongArchExtIOICommonClass *lecc = LOONGARCH_EXTIOI_COMMON_CLASS(klass);
+    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
 
     device_class_set_parent_realize(dc, loongarch_extioi_common_realize,
                                     &lecc->parent_realize);
     device_class_set_props(dc, extioi_properties);
     dc->vmsd = &vmstate_loongarch_extioi;
+    hc->plug = loongarch_extioi_cpu_plug;
+    hc->unplug = loongarch_extioi_cpu_unplug;
 }
 
 static const TypeInfo loongarch_extioi_common_types[] = {
@@ -121,6 +150,10 @@ static const TypeInfo loongarch_extioi_common_types[] = {
         .instance_size      = sizeof(LoongArchExtIOICommonState),
         .class_size         = sizeof(LoongArchExtIOICommonClass),
         .class_init         = loongarch_extioi_common_class_init,
+        .interfaces         = (InterfaceInfo[]) {
+            { TYPE_HOTPLUG_HANDLER },
+            { }
+        },
         .abstract           = true,
     }
 };
-- 
2.39.3


