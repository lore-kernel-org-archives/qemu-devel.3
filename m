Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC46C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 14:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts0MT-00041u-Ig; Tue, 11 Mar 2025 10:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ts0ME-0003QO-GL; Tue, 11 Mar 2025 10:13:24 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ts0MB-00072v-3w; Tue, 11 Mar 2025 10:13:22 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZBwdG1bclz6D9dy;
 Tue, 11 Mar 2025 22:10:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 07C451404F5;
 Tue, 11 Mar 2025 22:13:17 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Mar 2025 15:13:09 +0100
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [RFC PATCH v2 09/20] hw/arm/smmuv3-accel: Add set/unset_iommu_device
 callback
Date: Tue, 11 Mar 2025 14:10:34 +0000
Message-ID: <20250311141045.66620-10-shameerali.kolothum.thodi@huawei.com>
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

Implement a set_iommu_device callback:
 -Find an existing S2 hwpt to test attach() or allocate a new one
   (Devices behind the same physical SMMU should share an S2 HWPT.)
 -Attach the device to the S2 hwp
 -Allocate a viommu with the returned s2 hwpt.
 -Allocate bypass and abort hwpt and attach bypass hwpt.
 -and add it to its device list

Also add an unset_iommu_device doing the opposite cleanup routine.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/meson.build            |   2 +-
 hw/arm/smmuv3-accel.c         | 183 ++++++++++++++++++++++++++++++++++
 hw/arm/trace-events           |   4 +
 include/hw/arm/smmuv3-accel.h |  23 +++++
 include/system/iommufd.h      |   6 ++
 5 files changed, 217 insertions(+), 1 deletion(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index e8593363b0..dd41a86619 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -55,7 +55,7 @@ arm_ss.add(when: 'CONFIG_MUSCA', if_true: files('musca.c'))
 arm_ss.add(when: 'CONFIG_ARMSSE', if_true: files('armsse.c'))
 arm_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d-sabre.c'))
 arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
-arm_ss.add(when: 'CONFIG_ARM_SMMUV3_ACCEL', if_true: files('smmuv3-accel.c'))
+arm_ss.add(when: ['CONFIG_ARM_SMMUV3_ACCEL', 'CONFIG_IOMMUFD'], if_true: files('smmuv3-accel.c'))
 arm_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
 arm_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
 arm_ss.add(when: 'CONFIG_XEN', if_true: files(
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 6610ebe4be..1c696649d5 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -7,6 +7,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "trace.h"
+#include "qemu/error-report.h"
 
 #include "hw/arm/smmuv3-accel.h"
 #include "hw/pci/pci_bridge.h"
@@ -30,6 +32,185 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *s, SMMUPciBus *sbus,
     return accel_dev;
 }
 
+static bool
+smmuv3_accel_dev_attach_viommu(SMMUv3AccelDevice *accel_dev,
+                               HostIOMMUDeviceIOMMUFD *idev, Error **errp)
+{
+    struct iommu_hwpt_arm_smmuv3 bypass_data = {
+        .ste = { 0x9ULL, 0x0ULL },
+    };
+    struct iommu_hwpt_arm_smmuv3 abort_data = {
+        .ste = { 0x1ULL, 0x0ULL },
+    };
+    SMMUDevice *sdev = &accel_dev->sdev;
+    SMMUState *s = sdev->smmu;
+    SMMUv3AccelState *s_accel = ARM_SMMUV3_ACCEL(s);
+    SMMUS2Hwpt *s2_hwpt;
+    SMMUViommu *viommu;
+    uint32_t s2_hwpt_id;
+    uint32_t viommu_id;
+
+    if (s_accel->viommu) {
+        accel_dev->viommu = s_accel->viommu;
+        return host_iommu_device_iommufd_attach_hwpt(
+                       idev, s_accel->viommu->s2_hwpt->hwpt_id, errp);
+    }
+
+    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid, idev->ioas_id,
+                                    IOMMU_HWPT_ALLOC_NEST_PARENT,
+                                    IOMMU_HWPT_DATA_NONE, 0, NULL,
+                                    &s2_hwpt_id, errp)) {
+        return false;
+    }
+
+    /* Attach to S2 for MSI cookie */
+    if (!host_iommu_device_iommufd_attach_hwpt(idev, s2_hwpt_id, errp)) {
+        goto free_s2_hwpt;
+    }
+
+    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
+                                      IOMMU_VIOMMU_TYPE_ARM_SMMUV3,
+                                      s2_hwpt_id, &viommu_id, errp)) {
+        goto detach_s2_hwpt;
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
+        error_report("failed to allocate an abort pagetable");
+        goto free_viommu;
+    }
+
+    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
+                                    viommu->core.viommu_id, 0,
+                                    IOMMU_HWPT_DATA_ARM_SMMUV3,
+                                    sizeof(bypass_data), &bypass_data,
+                                    &viommu->bypass_hwpt_id, errp)) {
+        error_report("failed to allocate a bypass pagetable");
+        goto free_abort_hwpt;
+    }
+
+    /*
+     * Attach the bypass STE which means S1 bypass and S2 translate.
+     * This is to make sure that the vIOMMU object is now associated
+     * with the device and has this STE installed in the host SMMUV3.
+     */
+    if (!host_iommu_device_iommufd_attach_hwpt(
+                idev, viommu->bypass_hwpt_id, errp)) {
+        error_report("failed to attach the bypass pagetable");
+        goto free_bypass_hwpt;
+    }
+
+    s2_hwpt = g_new0(SMMUS2Hwpt, 1);
+    s2_hwpt->iommufd = idev->iommufd;
+    s2_hwpt->hwpt_id = s2_hwpt_id;
+    s2_hwpt->ioas_id = idev->ioas_id;
+
+    viommu->iommufd = idev->iommufd;
+    viommu->s2_hwpt = s2_hwpt;
+
+    s_accel->viommu = viommu;
+    accel_dev->viommu = viommu;
+    return true;
+
+free_bypass_hwpt:
+    iommufd_backend_free_id(idev->iommufd, viommu->bypass_hwpt_id);
+free_abort_hwpt:
+    iommufd_backend_free_id(idev->iommufd, viommu->abort_hwpt_id);
+free_viommu:
+    iommufd_backend_free_id(idev->iommufd, viommu->core.viommu_id);
+    g_free(viommu);
+detach_s2_hwpt:
+    host_iommu_device_iommufd_attach_hwpt(idev, accel_dev->idev->ioas_id, errp);
+free_s2_hwpt:
+    iommufd_backend_free_id(idev->iommufd, s2_hwpt_id);
+    return false;
+}
+
+static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
+                                          HostIOMMUDevice *hiod, Error **errp)
+{
+    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
+    SMMUState *s = opaque;
+    SMMUv3AccelState *s_accel = ARM_SMMUV3_ACCEL(s);
+    SMMUPciBus *sbus = smmu_get_sbus(s, bus);
+    SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(s, sbus, bus, devfn);
+    SMMUDevice *sdev = &accel_dev->sdev;
+
+    if (!idev) {
+        return true;
+    }
+
+    if (accel_dev->idev) {
+        if (accel_dev->idev != idev) {
+            error_report("Device 0x%x already ha an associated idev",
+                         smmu_get_sid(sdev));
+            return false;
+        } else {
+            return true;
+        }
+    }
+
+    if (!smmuv3_accel_dev_attach_viommu(accel_dev, idev, errp)) {
+        error_report("Unable to attach viommu");
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
+    SMMUDevice *sdev;
+    SMMUv3AccelDevice *accel_dev;
+    SMMUViommu *viommu;
+    SMMUState *s = opaque;
+    SMMUv3AccelState *s_accel = ARM_SMMUV3_ACCEL(s);
+    SMMUPciBus *sbus = g_hash_table_lookup(s->smmu_pcibus_by_busptr, bus);
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
+                                               accel_dev->idev->ioas_id,
+                                               NULL)) {
+        error_report("Unable to attach dev to the default HW pagetable");
+    }
+
+
+    accel_dev->idev = NULL;
+    QLIST_REMOVE(accel_dev, next);
+    trace_smmuv3_accel_unset_iommu_device(devfn, smmu_get_sid(sdev));
+
+    viommu = s_accel->viommu;
+    if (QLIST_EMPTY(&viommu->device_list)) {
+        iommufd_backend_free_id(viommu->iommufd, viommu->bypass_hwpt_id);
+        iommufd_backend_free_id(viommu->iommufd, viommu->abort_hwpt_id);
+        iommufd_backend_free_id(viommu->iommufd, viommu->core.viommu_id);
+        iommufd_backend_free_id(viommu->iommufd, viommu->s2_hwpt->hwpt_id);
+        g_free(viommu->s2_hwpt);
+        g_free(viommu);
+        s_accel->viommu = NULL;
+    }
+}
 static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
                                               int devfn)
 {
@@ -77,6 +258,8 @@ static void smmu_accel_realize(DeviceState *d, Error **errp)
         return;
     }
     bs->get_address_space = smmuv3_accel_find_add_as;
+    bs->set_iommu_device = smmuv3_accel_set_iommu_device;
+    bs->unset_iommu_device = smmuv3_accel_unset_iommu_device;
 }
 
 static void smmuv3_accel_class_init(ObjectClass *klass, void *data)
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 7790db780e..17960794bf 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -58,6 +58,10 @@ smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s
 smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages, int stage) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" stage=%d"
 smmu_reset_exit(void) ""
 
+#smmuv3-accel.c
+smmuv3_accel_set_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x)"
+smmuv3_accel_unset_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x"
+
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
 strongarm_ssp_read_underrun(void) "SSP rx underrun"
diff --git a/include/hw/arm/smmuv3-accel.h b/include/hw/arm/smmuv3-accel.h
index 86c0523063..aca6838dca 100644
--- a/include/hw/arm/smmuv3-accel.h
+++ b/include/hw/arm/smmuv3-accel.h
@@ -12,16 +12,39 @@
 #include "hw/arm/smmu-common.h"
 #include "hw/arm/smmuv3.h"
 #include "qom/object.h"
+#include "system/iommufd.h"
+
+#include <linux/iommufd.h>
 
 #define TYPE_ARM_SMMUV3_ACCEL   "arm-smmuv3-accel"
 OBJECT_DECLARE_TYPE(SMMUv3AccelState, SMMUv3AccelClass, ARM_SMMUV3_ACCEL)
 
+typedef struct SMMUS2Hwpt {
+    IOMMUFDBackend *iommufd;
+    uint32_t hwpt_id;
+    uint32_t ioas_id;
+} SMMUS2Hwpt;
+
+typedef struct SMMUViommu {
+    IOMMUFDBackend *iommufd;
+    IOMMUFDViommu core;
+    SMMUS2Hwpt *s2_hwpt;
+    uint32_t bypass_hwpt_id;
+    uint32_t abort_hwpt_id;
+    QLIST_HEAD(, SMMUv3AccelDevice) device_list;
+    QLIST_ENTRY(SMMUViommu) next;
+} SMMUViommu;
+
 typedef struct SMMUv3AccelDevice {
     SMMUDevice  sdev;
+    HostIOMMUDeviceIOMMUFD *idev;
+    SMMUViommu *viommu;
+    QLIST_ENTRY(SMMUv3AccelDevice) next;
 } SMMUv3AccelDevice;
 
 struct SMMUv3AccelState {
     SMMUv3State smmuv3_state;
+    SMMUViommu *viommu;
 };
 
 struct SMMUv3AccelClass {
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 53920bae5b..9c106ea078 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -37,6 +37,12 @@ struct IOMMUFDBackend {
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


