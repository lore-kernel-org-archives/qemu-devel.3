Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420A9C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 14:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts0LH-0000WV-Am; Tue, 11 Mar 2025 10:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ts0LE-0000Ul-J4; Tue, 11 Mar 2025 10:12:20 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ts0LC-0006sl-JW; Tue, 11 Mar 2025 10:12:20 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZBwc55ggtz6D9b5;
 Tue, 11 Mar 2025 22:09:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id A266D140B63;
 Tue, 11 Mar 2025 22:12:16 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Mar 2025 15:12:09 +0100
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial infrastructure
 for smmuv3-accel device
Date: Tue, 11 Mar 2025 14:10:28 +0000
Message-ID: <20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.203.177.241]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Based on SMMUv3 as a parent device, add a user-creatable smmuv3-accel
device. In order to support vfio-pci dev assignment with a Guest
SMMUv3, the physical SMMUv3 has to be configured in nested(S1+s2)
mode, with Guest owning the S1 page tables. Subsequent patches will
add support for smmuv3-accel to provide this.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/Kconfig                |  5 ++++
 hw/arm/meson.build            |  1 +
 hw/arm/smmu-common.c          |  1 +
 hw/arm/smmuv3-accel.c         | 51 +++++++++++++++++++++++++++++++++++
 include/hw/arm/smmu-common.h  |  3 +++
 include/hw/arm/smmuv3-accel.h | 31 +++++++++++++++++++++
 6 files changed, 92 insertions(+)
 create mode 100644 hw/arm/smmuv3-accel.c
 create mode 100644 include/hw/arm/smmuv3-accel.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 504841ccab..f889842dd8 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -14,6 +14,7 @@ config ARM_VIRT
     select ARM_GIC
     select ACPI
     select ARM_SMMUV3
+    select ARM_SMMUV3_ACCEL
     select GPIO_KEY
     select DEVICE_TREE
     select FW_CFG_DMA
@@ -596,6 +597,10 @@ config FSL_IMX7
 config ARM_SMMUV3
     bool
 
+config ARM_SMMUV3_ACCEL
+    select ARM_SMMUV3
+    bool
+
 config FSL_IMX6UL
     bool
     default y
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 465c757f97..e8593363b0 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -55,6 +55,7 @@ arm_ss.add(when: 'CONFIG_MUSCA', if_true: files('musca.c'))
 arm_ss.add(when: 'CONFIG_ARMSSE', if_true: files('armsse.c'))
 arm_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d-sabre.c'))
 arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
+arm_ss.add(when: 'CONFIG_ARM_SMMUV3_ACCEL', if_true: files('smmuv3-accel.c'))
 arm_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
 arm_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
 arm_ss.add(when: 'CONFIG_XEN', if_true: files(
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 8c1b407b82..f5caf1665c 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -943,6 +943,7 @@ static const Property smmu_dev_properties[] = {
     DEFINE_PROP_UINT8("bus_num", SMMUState, bus_num, 0),
     DEFINE_PROP_LINK("primary-bus", SMMUState, primary_bus,
                      TYPE_PCI_BUS, PCIBus *),
+    DEFINE_PROP_BOOL("accel", SMMUState, accel, false),
 };
 
 static void smmu_base_class_init(ObjectClass *klass, void *data)
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
new file mode 100644
index 0000000000..c327661636
--- /dev/null
+++ b/hw/arm/smmuv3-accel.c
@@ -0,0 +1,51 @@
+/*
+ * Copyright (c) 2025 Huawei Technologies R & D (UK) Ltd
+ * Copyright (C) 2025 NVIDIA
+ * Written by Nicolin Chen, Shameer Kolothum
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/arm/smmuv3-accel.h"
+
+static void smmu_accel_realize(DeviceState *d, Error **errp)
+{
+    SMMUv3AccelState *s_accel = ARM_SMMUV3_ACCEL(d);
+    SMMUv3AccelClass *c = ARM_SMMUV3_ACCEL_GET_CLASS(s_accel);
+    SysBusDevice *dev = SYS_BUS_DEVICE(d);
+    Error *local_err = NULL;
+
+    object_property_set_bool(OBJECT(dev), "accel", true, &error_abort);
+    c->parent_realize(d, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+}
+
+static void smmuv3_accel_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    SMMUv3AccelClass *c = ARM_SMMUV3_ACCEL_CLASS(klass);
+
+    device_class_set_parent_realize(dc, smmu_accel_realize,
+                                    &c->parent_realize);
+    dc->hotpluggable = false;
+}
+
+static const TypeInfo smmuv3_accel_type_info = {
+    .name          = TYPE_ARM_SMMUV3_ACCEL,
+    .parent        = TYPE_ARM_SMMUV3,
+    .instance_size = sizeof(SMMUv3AccelState),
+    .class_size    = sizeof(SMMUv3AccelClass),
+    .class_init    = smmuv3_accel_class_init,
+};
+
+static void smmuv3_accel_register_types(void)
+{
+    type_register_static(&smmuv3_accel_type_info);
+}
+
+type_init(smmuv3_accel_register_types)
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index d1a4a64551..b5c63cfd5d 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -157,6 +157,9 @@ struct SMMUState {
     QLIST_HEAD(, SMMUDevice) devices_with_notifiers;
     uint8_t bus_num;
     PCIBus *primary_bus;
+
+    /* For smmuv3-accel */
+    bool accel;
 };
 
 struct SMMUBaseClass {
diff --git a/include/hw/arm/smmuv3-accel.h b/include/hw/arm/smmuv3-accel.h
new file mode 100644
index 0000000000..56fe376bf4
--- /dev/null
+++ b/include/hw/arm/smmuv3-accel.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright (c) 2025 Huawei Technologies R & D (UK) Ltd
+ * Copyright (C) 2025 NVIDIA
+ * Written by Nicolin Chen, Shameer Kolothum
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_ARM_SMMUV3_ACCEL_H
+#define HW_ARM_SMMUV3_ACCEL_H
+
+#include "hw/arm/smmu-common.h"
+#include "hw/arm/smmuv3.h"
+#include "qom/object.h"
+
+#define TYPE_ARM_SMMUV3_ACCEL   "arm-smmuv3-accel"
+OBJECT_DECLARE_TYPE(SMMUv3AccelState, SMMUv3AccelClass, ARM_SMMUV3_ACCEL)
+
+struct SMMUv3AccelState {
+    SMMUv3State smmuv3_state;
+};
+
+struct SMMUv3AccelClass {
+    /*< private >*/
+    SMMUv3Class smmuv3_class;
+    /*< public >*/
+
+    DeviceRealize parent_realize;
+};
+
+#endif /* HW_ARM_SMMUV3_ACCEL_H */
-- 
2.34.1


