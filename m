Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A43EC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 16:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubMVv-0008Il-Ar; Mon, 14 Jul 2025 12:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubLcU-0005R4-PJ; Mon, 14 Jul 2025 12:01:49 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubLcQ-0008Lr-QT; Mon, 14 Jul 2025 12:01:33 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bgn602Kfxz6L5Md;
 Mon, 14 Jul 2025 23:58:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id A75D814038F;
 Tue, 15 Jul 2025 00:01:27 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Jul 2025 18:01:18 +0200
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <shameerkolothum@gmail.com>
Subject: [RFC PATCH v3 08/15] hw/arm/smmuv3-accel: Add set/unset_iommu_device
 callback
Date: Mon, 14 Jul 2025 16:59:34 +0100
Message-ID: <20250714155941.22176-9-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.203.177.241]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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

Implement a set_iommu_device callback:
 -If found an existing viommu reuse that.
   (Devices behind the same physical SMMU should share an S2 HWPT)
 -Else,
    Allocate a viommu with the nested parent S2 hwpt allocated by VFIO.
    Allocate bypass and abort hwpt.
 -And add the dev to viommu device list

Also add an unset_iommu_device to unwind/cleanup above.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/smmuv3-accel.c    | 154 +++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h    |  20 +++++
 hw/arm/trace-events      |   4 +
 include/system/iommufd.h |   6 ++
 4 files changed, 184 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 66cd4f5ece..fe90d48675 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -7,6 +7,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "trace.h"
 #include "qemu/error-report.h"
 
 #include "hw/arm/smmuv3.h"
@@ -17,6 +18,9 @@
 
 #include "smmuv3-accel.h"
 
+#define SMMU_STE_VALID      (1ULL << 0)
+#define SMMU_STE_CFG_BYPASS (1ULL << 3)
+
 static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
                                                 PCIBus *bus, int devfn)
 {
@@ -39,6 +43,154 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
     return accel_dev;
 }
 
+static bool
+smmuv3_accel_dev_alloc_viommu(SMMUv3AccelDevice *accel_dev,
+                               HostIOMMUDeviceIOMMUFD *idev, Error **errp)
+{
+    struct iommu_hwpt_arm_smmuv3 bypass_data = {
+        .ste = { SMMU_STE_CFG_BYPASS | SMMU_STE_VALID, 0x0ULL },
+    };
+    struct iommu_hwpt_arm_smmuv3 abort_data = {
+        .ste = { SMMU_STE_VALID, 0x0ULL },
+    };
+    SMMUDevice *sdev = &accel_dev->sdev;
+    SMMUState *bs = sdev->smmu;
+    SMMUv3State *s = ARM_SMMUV3(bs);
+    SMMUv3AccelState *s_accel = s->s_accel;
+    uint32_t s2_hwpt_id = idev->hwpt_id;
+    SMMUS2Hwpt *s2_hwpt;
+    SMMUViommu *viommu;
+    uint32_t viommu_id;
+
+    if (s_accel->viommu) {
+        accel_dev->viommu = s_accel->viommu;
+        return true;
+    }
+
+    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
+                                      IOMMU_VIOMMU_TYPE_ARM_SMMUV3,
+                                      s2_hwpt_id, &viommu_id, errp)) {
+        return false;
+    }
+
+    viommu = g_new0(SMMUViommu, 1);
+    viommu->core.viommu_id = viommu_id;
+    viommu->core.s2_hwpt_id = s2_hwpt_id;
+    viommu->core.iommufd = idev->iommufd;
+
+    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
+                                    viommu->core.viommu_id, 0,
+                                    IOMMU_HWPT_DATA_ARM_SMMUV3,
+                                    sizeof(abort_data), &abort_data,
+                                    &viommu->abort_hwpt_id, errp)) {
+        goto free_viommu;
+    }
+
+    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
+                                    viommu->core.viommu_id, 0,
+                                    IOMMU_HWPT_DATA_ARM_SMMUV3,
+                                    sizeof(bypass_data), &bypass_data,
+                                    &viommu->bypass_hwpt_id, errp)) {
+        goto free_abort_hwpt;
+    }
+
+    s2_hwpt = g_new(SMMUS2Hwpt, 1);
+    s2_hwpt->iommufd = idev->iommufd;
+    s2_hwpt->hwpt_id = s2_hwpt_id;
+
+    viommu->iommufd = idev->iommufd;
+    viommu->s2_hwpt = s2_hwpt;
+
+    s_accel->viommu = viommu;
+    accel_dev->viommu = viommu;
+    return true;
+
+free_abort_hwpt:
+    iommufd_backend_free_id(idev->iommufd, viommu->abort_hwpt_id);
+free_viommu:
+    iommufd_backend_free_id(idev->iommufd, viommu->core.viommu_id);
+    g_free(viommu);
+    return false;
+}
+
+static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
+                                          HostIOMMUDevice *hiod, Error **errp)
+{
+    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
+    SMMUState *bs = opaque;
+    SMMUv3State *s = ARM_SMMUV3(bs);
+    SMMUv3AccelState *s_accel = s->s_accel;
+    SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
+    SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
+    SMMUDevice *sdev = &accel_dev->sdev;
+
+    if (!idev) {
+        return true;
+    }
+
+    if (accel_dev->idev) {
+        if (accel_dev->idev != idev) {
+            error_report("Device 0x%x already has an associated idev",
+                         smmu_get_sid(sdev));
+            return false;
+        } else {
+            return true;
+        }
+    }
+
+    if (!smmuv3_accel_dev_alloc_viommu(accel_dev, idev, errp)) {
+        error_report("Device 0x%x: Unable to alloc viommu", smmu_get_sid(sdev));
+        return false;
+    }
+
+    accel_dev->idev = idev;
+    QLIST_INSERT_HEAD(&s_accel->viommu->device_list, accel_dev, next);
+    trace_smmuv3_accel_set_iommu_device(devfn, smmu_get_sid(sdev));
+    return true;
+}
+
+static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
+                                            int devfn)
+{
+    SMMUState *bs = opaque;
+    SMMUv3State *s = ARM_SMMUV3(bs);
+    SMMUPciBus *sbus = g_hash_table_lookup(bs->smmu_pcibus_by_busptr, bus);
+    SMMUv3AccelDevice *accel_dev;
+    SMMUViommu *viommu;
+    SMMUDevice *sdev;
+
+    if (!sbus) {
+        return;
+    }
+
+    sdev = sbus->pbdev[devfn];
+    if (!sdev) {
+        return;
+    }
+
+    accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
+    if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->idev,
+                                               accel_dev->idev->hwpt_id,
+                                               NULL)) {
+        error_report("Unable to attach dev to the default HW pagetable");
+    }
+
+    accel_dev->idev = NULL;
+    QLIST_REMOVE(accel_dev, next);
+    trace_smmuv3_accel_unset_iommu_device(devfn, smmu_get_sid(sdev));
+
+    viommu = s->s_accel->viommu;
+    if (QLIST_EMPTY(&viommu->device_list)) {
+        iommufd_backend_free_id(viommu->iommufd, viommu->bypass_hwpt_id);
+        iommufd_backend_free_id(viommu->iommufd, viommu->abort_hwpt_id);
+        iommufd_backend_free_id(viommu->iommufd, viommu->core.viommu_id);
+        iommufd_backend_free_id(viommu->iommufd, viommu->s2_hwpt->hwpt_id);
+        g_free(viommu->s2_hwpt);
+        g_free(viommu);
+        s->s_accel->viommu = NULL;
+    }
+}
+
 static bool smmuv3_accel_pdev_allowed(PCIDevice *pdev, bool *vfio_pci)
 {
 
@@ -98,6 +250,8 @@ static uint64_t smmuv3_accel_get_viommu_cap(void *opaque)
 static const PCIIOMMUOps smmuv3_accel_ops = {
     .get_address_space = smmuv3_accel_find_add_as,
     .get_viommu_cap = smmuv3_accel_get_viommu_cap,
+    .set_iommu_device = smmuv3_accel_set_iommu_device,
+    .unset_iommu_device = smmuv3_accel_unset_iommu_device,
 };
 
 void smmuv3_accel_init(SMMUv3State *s)
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 2cd343103f..55a6a353fc 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -11,16 +11,36 @@
 
 #include "hw/arm/smmuv3.h"
 #include "hw/arm/smmu-common.h"
+#include "system/iommufd.h"
+#include <linux/iommufd.h>
 #include CONFIG_DEVICES
 
+typedef struct SMMUS2Hwpt {
+    IOMMUFDBackend *iommufd;
+    uint32_t hwpt_id;
+} SMMUS2Hwpt;
+
+typedef struct SMMUViommu {
+    IOMMUFDBackend *iommufd;
+    IOMMUFDViommu core;
+    SMMUS2Hwpt *s2_hwpt;
+    uint32_t bypass_hwpt_id;
+    uint32_t abort_hwpt_id;
+    QLIST_HEAD(, SMMUv3AccelDevice) device_list;
+} SMMUViommu;
+
 typedef struct SMMUv3AccelDevice {
     SMMUDevice  sdev;
     AddressSpace as_sysmem;
+    HostIOMMUDeviceIOMMUFD *idev;
+    SMMUViommu *viommu;
+    QLIST_ENTRY(SMMUv3AccelDevice) next;
 } SMMUv3AccelDevice;
 
 typedef struct SMMUv3AccelState {
     MemoryRegion root;
     MemoryRegion sysmem;
+    SMMUViommu *viommu;
 } SMMUv3AccelState;
 
 #if defined(CONFIG_ARM_SMMUV3) && defined(CONFIG_IOMMUFD)
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index f3386bd7ae..c4537ca1d6 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -66,6 +66,10 @@ smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s
 smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages, int stage) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" stage=%d"
 smmu_reset_exit(void) ""
 
+#smmuv3-accel.c
+smmuv3_accel_set_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x)"
+smmuv3_accel_unset_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x"
+
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
 strongarm_ssp_read_underrun(void) "SSP rx underrun"
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 6ab3ba3cb6..b7ad2cf10c 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -38,6 +38,12 @@ struct IOMMUFDBackend {
     /*< public >*/
 };
 
+typedef struct IOMMUFDViommu {
+    IOMMUFDBackend *iommufd;
+    uint32_t s2_hwpt_id;
+    uint32_t viommu_id;
+} IOMMUFDViommu;
+
 bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
 void iommufd_backend_disconnect(IOMMUFDBackend *be);
 
-- 
2.34.1


