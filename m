Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF5FD5C0C6
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 12:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9OX6-00051h-Kh; Fri, 08 Nov 2024 07:56:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1t9OX4-00050A-31; Fri, 08 Nov 2024 07:56:10 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1t9OX2-0006gg-H0; Fri, 08 Nov 2024 07:56:09 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XlJpS0SpFz6DBX0;
 Fri,  8 Nov 2024 20:56:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 7C12A140B73;
 Fri,  8 Nov 2024 20:56:05 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 8 Nov 2024 13:55:58 +0100
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <linuxarm@huawei.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [RFC PATCH 3/5] hw/arm/smmuv3: Associate a pci bus with a SMMUv3
 Nested device
Date: Fri, 8 Nov 2024 12:52:40 +0000
Message-ID: <20241108125242.60136-4-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
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
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Subsequent patches will add IORT modifications to get this working.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/smmuv3.c         | 27 +++++++++++++++++++++++++++
 include/hw/arm/smmuv3.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 0033eb8125..9b0a776769 100644
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
@@ -2201,12 +2202,32 @@ static void smmu_realize(DeviceState *d, Error **errp)
     smmu_init_irq(s, dev);
 }
 
+static int smmuv3_nested_pci_host_bridge(Object *obj, void *opaque)
+{
+    DeviceState *d = opaque;
+    SMMUv3NestedState *s_nested = ARM_SMMUV3_NESTED(d);
+
+    if (object_dynamic_cast(obj, TYPE_PCI_HOST_BRIDGE)) {
+        PCIBus *bus = PCI_HOST_BRIDGE(obj)->bus;
+        if (s_nested->pci_bus && !strcmp(bus->qbus.name, s_nested->pci_bus)) {
+            object_property_set_link(OBJECT(d), "primary-bus", OBJECT(bus),
+                                     &error_abort);
+        }
+    }
+    return 0;
+}
+
 static void smmu_nested_realize(DeviceState *d, Error **errp)
 {
     SMMUv3NestedState *s_nested = ARM_SMMUV3_NESTED(d);
     SMMUv3NestedClass *c = ARM_SMMUV3_NESTED_GET_CLASS(s_nested);
+    SysBusDevice *dev = SYS_BUS_DEVICE(d);
     Error *local_err = NULL;
 
+    object_child_foreach_recursive(object_get_root(),
+                                   smmuv3_nested_pci_host_bridge, d);
+    object_property_set_bool(OBJECT(dev), "nested", true, &error_abort);
+
     c->parent_realize(d, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -2293,6 +2314,11 @@ static Property smmuv3_properties[] = {
     DEFINE_PROP_END_OF_LIST()
 };
 
+static Property smmuv3_nested_properties[] = {
+    DEFINE_PROP_STRING("pci-bus", SMMUv3NestedState, pci_bus),
+    DEFINE_PROP_END_OF_LIST()
+};
+
 static void smmuv3_instance_init(Object *obj)
 {
     /* Nothing much to do here as of now */
@@ -2320,6 +2346,7 @@ static void smmuv3_nested_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_smmuv3;
     device_class_set_parent_realize(dc, smmu_nested_realize,
                                     &c->parent_realize);
+    device_class_set_props(dc, smmuv3_nested_properties);
     dc->user_creatable = true;
     dc->hotpluggable = false;
 }
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 87e628be7a..96513fce56 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -89,6 +89,8 @@ OBJECT_DECLARE_TYPE(SMMUv3NestedState, SMMUv3NestedClass, ARM_SMMUV3_NESTED)
 
 struct SMMUv3NestedState {
     SMMUv3State smmuv3_state;
+
+    char *pci_bus;
 };
 
 struct SMMUv3NestedClass {
-- 
2.34.1


