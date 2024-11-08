Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99667D5E145
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 08:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9KCb-0001ie-GE; Fri, 08 Nov 2024 03:18:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1t9KBM-00005x-4a
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 03:17:29 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1t9KBH-0005gM-1i
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 03:17:25 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxeeEMyS1nqS85AA--.48699S3;
 Fri, 08 Nov 2024 16:17:16 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDxxsAIyS1nea9MAA--.4604S9;
 Fri, 08 Nov 2024 16:17:16 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 07/10] hw/intc/loongarch_extioi: Add common file
 loongarch_extioi_common
Date: Fri,  8 Nov 2024 16:17:09 +0800
Message-Id: <20241108081712.632890-8-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241108081712.632890-1-maobibo@loongson.cn>
References: <20241108081712.632890-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxxsAIyS1nea9MAA--.4604S9
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

Add new common file loongarch_extioi_common.c, and move vmstate
and property structure to common file.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_extioi.c        | 59 +----------------------------
 hw/intc/loongarch_extioi_common.c | 63 +++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 57 deletions(-)
 create mode 100644 hw/intc/loongarch_extioi_common.c

diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index 73b2234754..a6f489b885 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -323,15 +323,8 @@ static const MemoryRegionOps extioi_virt_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static void loongarch_extioi_common_realize(DeviceState *dev, Error **errp)
-{
-    LoongArchExtIOICommonState *s = (LoongArchExtIOICommonState *)dev;
-
-    if (s->num_cpu == 0) {
-        error_setg(errp, "num-cpu must be at least 1");
-        return;
-    }
-}
+static int vmstate_extioi_post_load(void *opaque, int version_id);
+#include "loongarch_extioi_common.c"
 
 static void loongarch_extioi_realize(DeviceState *dev, Error **errp)
 {
@@ -408,54 +401,6 @@ static int vmstate_extioi_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static int loongarch_extioi_common_post_load(void *opaque, int version_id)
-{
-    return vmstate_extioi_post_load(opaque, version_id);
-}
-
-static const VMStateDescription vmstate_extioi_core = {
-    .name = "extioi-core",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT32_ARRAY(coreisr, ExtIOICore, EXTIOI_IRQS_GROUP_COUNT),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static const VMStateDescription vmstate_loongarch_extioi = {
-    .name = "loongarch.extioi",
-    .version_id = 3,
-    .minimum_version_id = 3,
-    .post_load = loongarch_extioi_common_post_load,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT32_ARRAY(bounce, LoongArchExtIOICommonState,
-                             EXTIOI_IRQS_GROUP_COUNT),
-        VMSTATE_UINT32_ARRAY(nodetype, LoongArchExtIOICommonState,
-                             EXTIOI_IRQS_NODETYPE_COUNT / 2),
-        VMSTATE_UINT32_ARRAY(enable, LoongArchExtIOICommonState,
-                             EXTIOI_IRQS / 32),
-        VMSTATE_UINT32_ARRAY(isr, LoongArchExtIOICommonState,
-                             EXTIOI_IRQS / 32),
-        VMSTATE_UINT32_ARRAY(ipmap, LoongArchExtIOICommonState,
-                             EXTIOI_IRQS_IPMAP_SIZE / 4),
-        VMSTATE_UINT32_ARRAY(coremap, LoongArchExtIOICommonState,
-                             EXTIOI_IRQS / 4),
-        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, LoongArchExtIOICommonState,
-                             num_cpu, vmstate_extioi_core, ExtIOICore),
-        VMSTATE_UINT32(features, LoongArchExtIOICommonState),
-        VMSTATE_UINT32(status, LoongArchExtIOICommonState),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static Property extioi_properties[] = {
-    DEFINE_PROP_UINT32("num-cpu", LoongArchExtIOICommonState, num_cpu, 1),
-    DEFINE_PROP_BIT("has-virtualization-extension", LoongArchExtIOICommonState,
-                    features, EXTIOI_HAS_VIRT_EXTENSION, 0),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void loongarch_extioi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/intc/loongarch_extioi_common.c b/hw/intc/loongarch_extioi_common.c
new file mode 100644
index 0000000000..13f02fc5ab
--- /dev/null
+++ b/hw/intc/loongarch_extioi_common.c
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Loongson extioi interrupt controller emulation
+ * Copyright (C) 2024 Loongson Technology Corporation Limited
+ */
+
+static void loongarch_extioi_common_realize(DeviceState *dev, Error **errp)
+{
+    LoongArchExtIOICommonState *s = (LoongArchExtIOICommonState *)dev;
+
+    if (s->num_cpu == 0) {
+        error_setg(errp, "num-cpu must be at least 1");
+        return;
+    }
+}
+
+static int loongarch_extioi_common_post_load(void *opaque, int version_id)
+{
+    return vmstate_extioi_post_load(opaque, version_id);
+}
+
+static const VMStateDescription vmstate_extioi_core = {
+    .name = "extioi-core",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(coreisr, ExtIOICore, EXTIOI_IRQS_GROUP_COUNT),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_loongarch_extioi = {
+    .name = "loongarch.extioi",
+    .version_id = 3,
+    .minimum_version_id = 3,
+    .post_load = loongarch_extioi_common_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(bounce, LoongArchExtIOICommonState,
+                             EXTIOI_IRQS_GROUP_COUNT),
+        VMSTATE_UINT32_ARRAY(nodetype, LoongArchExtIOICommonState,
+                             EXTIOI_IRQS_NODETYPE_COUNT / 2),
+        VMSTATE_UINT32_ARRAY(enable, LoongArchExtIOICommonState,
+                             EXTIOI_IRQS / 32),
+        VMSTATE_UINT32_ARRAY(isr, LoongArchExtIOICommonState,
+                             EXTIOI_IRQS / 32),
+        VMSTATE_UINT32_ARRAY(ipmap, LoongArchExtIOICommonState,
+                             EXTIOI_IRQS_IPMAP_SIZE / 4),
+        VMSTATE_UINT32_ARRAY(coremap, LoongArchExtIOICommonState,
+                             EXTIOI_IRQS / 4),
+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, LoongArchExtIOICommonState,
+                             num_cpu, vmstate_extioi_core, ExtIOICore),
+        VMSTATE_UINT32(features, LoongArchExtIOICommonState),
+        VMSTATE_UINT32(status, LoongArchExtIOICommonState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property extioi_properties[] = {
+    DEFINE_PROP_UINT32("num-cpu", LoongArchExtIOICommonState, num_cpu, 1),
+    DEFINE_PROP_BIT("has-virtualization-extension", LoongArchExtIOICommonState,
+                    features, EXTIOI_HAS_VIRT_EXTENSION, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
-- 
2.39.3


