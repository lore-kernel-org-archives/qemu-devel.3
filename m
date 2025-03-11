Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE44C35FF1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 14:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts0MG-0003Pq-Sv; Tue, 11 Mar 2025 10:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ts0M1-0002x5-24; Tue, 11 Mar 2025 10:13:09 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ts0Lz-000718-7P; Tue, 11 Mar 2025 10:13:08 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZBwd23hbpz6D9dy;
 Tue, 11 Mar 2025 22:09:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 5F1281404F5;
 Tue, 11 Mar 2025 22:13:05 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Mar 2025 15:12:57 +0100
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [RFC PATCH v2 08/20] hw/arm/smmuv3-accel: Provide get_address_space
 callback
Date: Tue, 11 Mar 2025 14:10:33 +0000
Message-ID: <20250311141045.66620-9-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Also introduce a struct SMMUv3AccelDevice to hold accelerator specific
device info. This will be populated accordingly in subsequent patches.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/smmuv3-accel.c         | 36 +++++++++++++++++++++++++++++++++++
 include/hw/arm/smmuv3-accel.h |  4 ++++
 2 files changed, 40 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 1471b65374..6610ebe4be 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -11,6 +11,40 @@
 #include "hw/arm/smmuv3-accel.h"
 #include "hw/pci/pci_bridge.h"
 
+static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *s, SMMUPciBus *sbus,
+                                                PCIBus *bus, int devfn)
+{
+    SMMUDevice *sdev = sbus->pbdev[devfn];
+    SMMUv3AccelDevice *accel_dev;
+
+    if (sdev) {
+        accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
+    } else {
+        accel_dev = g_new0(SMMUv3AccelDevice, 1);
+        sdev = &accel_dev->sdev;
+
+        sbus->pbdev[devfn] = sdev;
+        smmu_init_sdev(s, sdev, bus, devfn);
+    }
+
+    return accel_dev;
+}
+
+static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
+                                              int devfn)
+{
+    SMMUState *s = opaque;
+    SMMUPciBus *sbus;
+    SMMUv3AccelDevice *accel_dev;
+    SMMUDevice *sdev;
+
+    sbus = smmu_get_sbus(s, bus);
+    accel_dev = smmuv3_accel_get_dev(s, sbus, bus, devfn);
+    sdev = &accel_dev->sdev;
+
+    return &sdev->as;
+}
+
 static int smmuv3_accel_pxb_pcie_bus(Object *obj, void *opaque)
 {
     DeviceState *d = opaque;
@@ -30,6 +64,7 @@ static void smmu_accel_realize(DeviceState *d, Error **errp)
     SMMUv3AccelState *s_accel = ARM_SMMUV3_ACCEL(d);
     SMMUv3AccelClass *c = ARM_SMMUV3_ACCEL_GET_CLASS(s_accel);
     SysBusDevice *dev = SYS_BUS_DEVICE(d);
+    SMMUState *bs = ARM_SMMU(d);
     Error *local_err = NULL;
 
     object_child_foreach_recursive(object_get_root(),
@@ -41,6 +76,7 @@ static void smmu_accel_realize(DeviceState *d, Error **errp)
         error_propagate(errp, local_err);
         return;
     }
+    bs->get_address_space = smmuv3_accel_find_add_as;
 }
 
 static void smmuv3_accel_class_init(ObjectClass *klass, void *data)
diff --git a/include/hw/arm/smmuv3-accel.h b/include/hw/arm/smmuv3-accel.h
index 56fe376bf4..86c0523063 100644
--- a/include/hw/arm/smmuv3-accel.h
+++ b/include/hw/arm/smmuv3-accel.h
@@ -16,6 +16,10 @@
 #define TYPE_ARM_SMMUV3_ACCEL   "arm-smmuv3-accel"
 OBJECT_DECLARE_TYPE(SMMUv3AccelState, SMMUv3AccelClass, ARM_SMMUV3_ACCEL)
 
+typedef struct SMMUv3AccelDevice {
+    SMMUDevice  sdev;
+} SMMUv3AccelDevice;
+
 struct SMMUv3AccelState {
     SMMUv3State smmuv3_state;
 };
-- 
2.34.1


