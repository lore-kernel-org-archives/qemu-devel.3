Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054A7C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 14:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts0Mj-0005Yg-72; Tue, 11 Mar 2025 10:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ts0Mg-0005Ly-PB; Tue, 11 Mar 2025 10:13:50 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ts0Me-00077k-Nx; Tue, 11 Mar 2025 10:13:50 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZBwdp1tZcz6D9r2;
 Tue, 11 Mar 2025 22:10:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 211F3140CF4;
 Tue, 11 Mar 2025 22:13:45 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Mar 2025 15:13:37 +0100
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [RFC PATCH v2 12/20] hw/arm/smmuv3-accel: Return sysmem if stage-1 is
 bypassed
Date: Tue, 11 Mar 2025 14:10:37 +0000
Message-ID: <20250311141045.66620-13-shameerali.kolothum.thodi@huawei.com>
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

From: Nicolin Chen <nicolinc@nvidia.com>

When nested translation is enabled, there are 2-stage translation
occuring to two different address spaces: stage-1 in the iommu as,
while stage-2 in the system as.

If a device attached to the vSMMU doesn't enable stage-1 translation,
e.g. vSTE sets to Config=Bypass, the system as should be returned,
so QEMU can set up system memory mappings onto the stage-2 page table.
This is crucial for an iommufd enabled VFIO device as the VFIO core
code would register an iommu notifier and replay the address space
which should be bypassed for this nested translation case.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/smmuv3-accel.c         | 22 +++++++++++++++++++++-
 include/hw/arm/smmuv3-accel.h |  3 +++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 056bd23b2e..76134d106a 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -18,6 +18,7 @@
 static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *s, SMMUPciBus *sbus,
                                                 PCIBus *bus, int devfn)
 {
+    SMMUv3AccelState *s_accel = ARM_SMMUV3_ACCEL(s);
     SMMUDevice *sdev = sbus->pbdev[devfn];
     SMMUv3AccelDevice *accel_dev;
 
@@ -29,6 +30,8 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *s, SMMUPciBus *sbus,
 
         sbus->pbdev[devfn] = sdev;
         smmu_init_sdev(s, sdev, bus, devfn);
+        address_space_init(&accel_dev->as_sysmem, &s_accel->root,
+                           "smmuv3-accel-sysmem");
     }
 
     return accel_dev;
@@ -351,12 +354,23 @@ static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
     SMMUPciBus *sbus;
     SMMUv3AccelDevice *accel_dev;
     SMMUDevice *sdev;
+    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
+    bool has_iommufd = false;
+
+    if (pdev) {
+        has_iommufd = object_property_find(OBJECT(pdev), "iommufd");
+    }
 
     sbus = smmu_get_sbus(s, bus);
     accel_dev = smmuv3_accel_get_dev(s, sbus, bus, devfn);
     sdev = &accel_dev->sdev;
 
-    return &sdev->as;
+    /* Return the system as if the device uses stage-2 only */
+    if (has_iommufd && !accel_dev->s1_hwpt) {
+        return &accel_dev->as_sysmem;
+    } else {
+        return &sdev->as;
+    }
 }
 
 static int smmuv3_accel_pxb_pcie_bus(Object *obj, void *opaque)
@@ -390,6 +404,12 @@ static void smmu_accel_realize(DeviceState *d, Error **errp)
         error_propagate(errp, local_err);
         return;
     }
+
+    memory_region_init(&s_accel->root, OBJECT(s_accel), "root", UINT64_MAX);
+    memory_region_init_alias(&s_accel->sysmem, OBJECT(s_accel),
+                             "smmuv3-accel-sysmem", get_system_memory(), 0,
+                             memory_region_size(get_system_memory()));
+    memory_region_add_subregion(&s_accel->root, 0, &s_accel->sysmem);
     bs->get_address_space = smmuv3_accel_find_add_as;
     bs->set_iommu_device = smmuv3_accel_set_iommu_device;
     bs->unset_iommu_device = smmuv3_accel_unset_iommu_device;
diff --git a/include/hw/arm/smmuv3-accel.h b/include/hw/arm/smmuv3-accel.h
index 54b217ab4f..58e68534c0 100644
--- a/include/hw/arm/smmuv3-accel.h
+++ b/include/hw/arm/smmuv3-accel.h
@@ -51,12 +51,15 @@ typedef struct SMMUv3AccelDevice {
     SMMUS1Hwpt  *s1_hwpt;
     SMMUViommu *viommu;
     SMMUVdev   *vdev;
+    AddressSpace as_sysmem;
     QLIST_ENTRY(SMMUv3AccelDevice) next;
 } SMMUv3AccelDevice;
 
 struct SMMUv3AccelState {
     SMMUv3State smmuv3_state;
     SMMUViommu *viommu;
+    MemoryRegion root;
+    MemoryRegion sysmem;
 };
 
 struct SMMUv3AccelClass {
-- 
2.34.1


