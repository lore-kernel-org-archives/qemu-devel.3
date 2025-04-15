Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A08C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 08:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4bOw-0003W0-DW; Tue, 15 Apr 2025 04:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1u4bOq-0003Hm-Uh; Tue, 15 Apr 2025 04:12:08 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1u4bOl-0001oy-VR; Tue, 15 Apr 2025 04:12:07 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZcGx06x9lz6K9Ry;
 Tue, 15 Apr 2025 16:07:48 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id C4C44140114;
 Tue, 15 Apr 2025 16:11:59 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Apr 2025 10:11:52 +0200
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [PATCH 1/5] hw/arm/smmuv3: Introduce SMMUv3 device
Date: Tue, 15 Apr 2025 09:11:00 +0100
Message-ID: <20250415081104.71708-2-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20250415081104.71708-1-shameerali.kolothum.thodi@huawei.com>
References: <20250415081104.71708-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.203.177.241]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
From:  Shameer Kolothum via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Initial support to have a user-creatable SMMUv3 device associated
with a PCIe root complex,

-device arm-smmuv3-dev,bus=pcie.x

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/smmuv3.c         | 54 +++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/smmuv3.h | 16 ++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 1a96287ba9..e3b8e13ca3 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -24,6 +24,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/qdev-core.h"
 #include "hw/pci/pci.h"
+#include "hw/pci/pci_bridge.h"
 #include "cpu.h"
 #include "trace.h"
 #include "qemu/log.h"
@@ -1873,6 +1874,38 @@ static void smmu_reset_exit(Object *obj, ResetType type)
     smmuv3_init_regs(s);
 }
 
+static int smmuv3_dev_pcie_bus(Object *obj, void *opaque)
+{
+    DeviceState *d = opaque;
+    PCIBus *bus;
+
+    if (!object_dynamic_cast(obj, TYPE_PCI_HOST_BRIDGE)) {
+        return 0;
+    }
+
+    bus = PCI_HOST_BRIDGE(obj)->bus;
+    if (d->parent_bus && !strcmp(bus->qbus.name, d->parent_bus->name)) {
+        object_property_set_link(OBJECT(d), "primary-bus", OBJECT(bus),
+                                 &error_abort);
+        return 1;
+    }
+    return 0;
+}
+
+static void smmuv3_dev_realize(DeviceState *d, Error **errp)
+{
+    SMMUv3DevState *s_nested = ARM_SMMUV3_DEV(d);
+    SMMUv3DevClass *c = ARM_SMMUV3_DEV_GET_CLASS(s_nested);
+    Error *local_err = NULL;
+
+    object_child_foreach_recursive(object_get_root(), smmuv3_dev_pcie_bus, d);
+    c->parent_realize(d, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+}
+
 static void smmu_realize(DeviceState *d, Error **errp)
 {
     SMMUState *sys = ARM_SMMU(d);
@@ -1983,6 +2016,18 @@ static void smmuv3_instance_init(Object *obj)
     /* Nothing much to do here as of now */
 }
 
+static void smmuv3_dev_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    SMMUv3DevClass *c = ARM_SMMUV3_DEV_CLASS(klass);
+
+    dc->vmsd = &vmstate_smmuv3;
+    device_class_set_parent_realize(dc, smmuv3_dev_realize,
+                                    &c->parent_realize);
+    dc->hotpluggable = false;
+    dc->bus_type = TYPE_PCIE_BUS;
+}
+
 static void smmuv3_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -2038,6 +2083,14 @@ static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
     imrc->notify_flag_changed = smmuv3_notify_flag_changed;
 }
 
+static const TypeInfo smmuv3_dev_type_info = {
+    .name          = TYPE_ARM_SMMUV3_DEV,
+    .parent        = TYPE_ARM_SMMUV3,
+    .instance_size = sizeof(SMMUv3DevState),
+    .class_size    = sizeof(SMMUv3DevClass),
+    .class_init    = smmuv3_dev_class_init,
+};
+
 static const TypeInfo smmuv3_type_info = {
     .name          = TYPE_ARM_SMMUV3,
     .parent        = TYPE_ARM_SMMU,
@@ -2056,6 +2109,7 @@ static const TypeInfo smmuv3_iommu_memory_region_info = {
 static void smmuv3_register_types(void)
 {
     type_register_static(&smmuv3_type_info);
+    type_register_static(&smmuv3_dev_type_info);
     type_register_static(&smmuv3_iommu_memory_region_info);
 }
 
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index d183a62766..7d3846ac40 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -87,4 +87,20 @@ OBJECT_DECLARE_TYPE(SMMUv3State, SMMUv3Class, ARM_SMMUV3)
 #define STAGE1_SUPPORTED(s)      FIELD_EX32(s->idr[0], IDR0, S1P)
 #define STAGE2_SUPPORTED(s)      FIELD_EX32(s->idr[0], IDR0, S2P)
 
+struct SMMUv3DevState {
+    SMMUv3State smmuv3_state;
+};
+
+struct SMMUv3DevClass {
+    /*< private >*/
+    SMMUv3Class smmuv3_class;
+    /*< public >*/
+
+    DeviceRealize parent_realize;
+};
+
+/* User creatable smmuv3 device */
+#define TYPE_ARM_SMMUV3_DEV   "arm-smmuv3-dev"
+OBJECT_DECLARE_TYPE(SMMUv3DevState, SMMUv3DevClass, ARM_SMMUV3_DEV)
+
 #endif
-- 
2.34.1


