Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9623C35FF3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 14:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts0MV-0004F5-Qx; Tue, 11 Mar 2025 10:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ts0MO-0003zA-Ga; Tue, 11 Mar 2025 10:13:32 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ts0ML-00074T-4X; Tue, 11 Mar 2025 10:13:32 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZBwdR23DZz6D9Ry;
 Tue, 11 Mar 2025 22:10:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 2783C14034E;
 Tue, 11 Mar 2025 22:13:26 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Mar 2025 15:13:18 +0100
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [RFC PATCH v2 10/20] hw/arm/smmuv3-accel: Support nested STE
 install/uninstall support
Date: Tue, 11 Mar 2025 14:10:35 +0000
Message-ID: <20250311141045.66620-11-shameerali.kolothum.thodi@huawei.com>
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

Allocates a s1 HWPT for the Guest s1 stage and attaches that
to the dev. This will be invoked in a subsequent patch when
Guest issues SMMU_CMD_CFGI_STE.

While at it, we are also exporting both smmu_find_ste() and
smmuv3_flush_config() from smmuv3.c for use here.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/smmuv3-accel.c         | 111 ++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-internal.h      |  13 ++++
 hw/arm/smmuv3.c               |   5 +-
 hw/arm/trace-events           |   1 +
 include/hw/arm/smmuv3-accel.h |   6 ++
 5 files changed, 133 insertions(+), 3 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 1c696649d5..d3a5cf9551 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -13,6 +13,8 @@
 #include "hw/arm/smmuv3-accel.h"
 #include "hw/pci/pci_bridge.h"
 
+#include "smmuv3-internal.h"
+
 static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *s, SMMUPciBus *sbus,
                                                 PCIBus *bus, int devfn)
 {
@@ -32,6 +34,115 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *s, SMMUPciBus *sbus,
     return accel_dev;
 }
 
+static void
+smmuv3_accel_dev_uninstall_nested_ste(SMMUv3AccelDevice *accel_dev, bool abort)
+{
+    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
+    SMMUS1Hwpt *s1_hwpt = accel_dev->s1_hwpt;
+    uint32_t hwpt_id;
+
+    if (!s1_hwpt || !accel_dev->viommu) {
+        return;
+    }
+
+    if (abort) {
+        hwpt_id = accel_dev->viommu->abort_hwpt_id;
+    } else {
+        hwpt_id = accel_dev->viommu->bypass_hwpt_id;
+    }
+
+    host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, &error_abort);
+    iommufd_backend_free_id(s1_hwpt->iommufd, s1_hwpt->hwpt_id);
+    accel_dev->s1_hwpt = NULL;
+    g_free(s1_hwpt);
+}
+
+static int
+smmuv3_accel_dev_install_nested_ste(SMMUv3AccelDevice *accel_dev,
+                                    uint32_t data_type, uint32_t data_len,
+                                    void *data)
+{
+    SMMUViommu *viommu = accel_dev->viommu;
+    SMMUS1Hwpt *s1_hwpt = accel_dev->s1_hwpt;
+    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
+
+    if (!idev || !viommu) {
+        return -ENOENT;
+    }
+
+    if (s1_hwpt) {
+        smmuv3_accel_dev_uninstall_nested_ste(accel_dev, false);
+    }
+
+    s1_hwpt = g_new0(SMMUS1Hwpt, 1);
+    if (!s1_hwpt) {
+        return -ENOMEM;
+    }
+
+    s1_hwpt->iommufd = idev->iommufd;
+    iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
+                               viommu->core.viommu_id, 0, data_type, data_len,
+                               data, &s1_hwpt->hwpt_id, &error_abort);
+    host_iommu_device_iommufd_attach_hwpt(idev, s1_hwpt->hwpt_id, &error_abort);
+    accel_dev->s1_hwpt = s1_hwpt;
+    return 0;
+}
+
+void smmuv3_accel_install_nested_ste(SMMUDevice *sdev, int sid)
+{
+    SMMUv3AccelDevice *accel_dev;
+    SMMUEventInfo event = {.type = SMMU_EVT_NONE, .sid = sid,
+                           .inval_ste_allowed = true};
+    struct iommu_hwpt_arm_smmuv3 nested_data = {};
+    SMMUv3State *s = sdev->smmu;
+    SMMUState *bs = &s->smmu_state;
+    uint32_t config;
+    STE ste;
+    int ret;
+
+    if (!bs->accel) {
+        return;
+    }
+
+    accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
+    if (!accel_dev->viommu) {
+        return;
+    }
+
+    ret = smmu_find_ste(sdev->smmu, sid, &ste, &event);
+    if (ret) {
+        /*
+         * For a 2-level Stream Table, the level-2 table might not be ready
+         * until the device gets inserted to the stream table. Ignore this.
+         */
+        return;
+    }
+
+    config = STE_CONFIG(&ste);
+    if (!STE_VALID(&ste) || !STE_CFG_S1_ENABLED(config)) {
+        smmuv3_accel_dev_uninstall_nested_ste(accel_dev, STE_CFG_ABORT(config));
+        smmuv3_flush_config(sdev);
+        return;
+    }
+
+    nested_data.ste[0] = (uint64_t)ste.word[0] | (uint64_t)ste.word[1] << 32;
+    nested_data.ste[1] = (uint64_t)ste.word[2] | (uint64_t)ste.word[3] << 32;
+    /* V | CONFIG | S1FMT | S1CTXPTR | S1CDMAX */
+    nested_data.ste[0] &= 0xf80fffffffffffffULL;
+    /* S1DSS | S1CIR | S1COR | S1CSH | S1STALLD | EATS */
+    nested_data.ste[1] &= 0x380000ffULL;
+    ret = smmuv3_accel_dev_install_nested_ste(accel_dev,
+                                              IOMMU_HWPT_DATA_ARM_SMMUV3,
+                                              sizeof(nested_data),
+                                              &nested_data);
+    if (ret) {
+        error_report("Unable to install nested STE=%16LX:%16LX, ret=%d",
+                     nested_data.ste[1], nested_data.ste[0], ret);
+    }
+    trace_smmuv3_accel_install_nested_ste(sid, nested_data.ste[1],
+                                          nested_data.ste[0]);
+}
+
 static bool
 smmuv3_accel_dev_attach_viommu(SMMUv3AccelDevice *accel_dev,
                                HostIOMMUDeviceIOMMUFD *idev, Error **errp)
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index b6b7399347..46c8bcae14 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -24,6 +24,8 @@
 #include "hw/registerfields.h"
 #include "hw/arm/smmu-common.h"
 
+#include CONFIG_DEVICES
+
 typedef enum SMMUTranslationStatus {
     SMMU_TRANS_DISABLE,
     SMMU_TRANS_ABORT,
@@ -547,6 +549,17 @@ typedef struct CD {
     uint32_t word[16];
 } CD;
 
+int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
+                  SMMUEventInfo *event);
+void smmuv3_flush_config(SMMUDevice *sdev);
+
+#if defined(CONFIG_ARM_SMMUV3_ACCEL) && defined(CONFIG_IOMMUFD)
+void smmuv3_accel_install_nested_ste(SMMUDevice *sdev, int sid);
+#else
+static inline void smmuv3_accel_install_nested_ste(SMMUDevice *sdev, int sid)
+{
+}
+#endif
 /* STE fields */
 
 #define STE_VALID(x)   extract32((x)->word[0], 0, 1)
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index b49a59b64c..ea63731d61 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -628,8 +628,7 @@ bad_ste:
  * Supports linear and 2-level stream table
  * Return 0 on success, -EINVAL otherwise
  */
-static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
-                         SMMUEventInfo *event)
+int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
 {
     dma_addr_t addr, strtab_base;
     uint32_t log2size;
@@ -898,7 +897,7 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event)
     return cfg;
 }
 
-static void smmuv3_flush_config(SMMUDevice *sdev)
+void smmuv3_flush_config(SMMUDevice *sdev)
 {
     SMMUv3State *s = sdev->smmu;
     SMMUState *bc = &s->smmu_state;
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 17960794bf..cd2eac31c2 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -61,6 +61,7 @@ smmu_reset_exit(void) ""
 #smmuv3-accel.c
 smmuv3_accel_set_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x)"
 smmuv3_accel_unset_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x"
+smmuv3_accel_install_nested_ste(uint32_t sid, uint64_t ste_1, uint64_t ste_0) "sid=%d ste=%"PRIx64":%"PRIx64
 
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
diff --git a/include/hw/arm/smmuv3-accel.h b/include/hw/arm/smmuv3-accel.h
index aca6838dca..d6b0b1ca30 100644
--- a/include/hw/arm/smmuv3-accel.h
+++ b/include/hw/arm/smmuv3-accel.h
@@ -35,9 +35,15 @@ typedef struct SMMUViommu {
     QLIST_ENTRY(SMMUViommu) next;
 } SMMUViommu;
 
+typedef struct SMMUS1Hwpt {
+    IOMMUFDBackend *iommufd;
+    uint32_t hwpt_id;
+} SMMUS1Hwpt;
+
 typedef struct SMMUv3AccelDevice {
     SMMUDevice  sdev;
     HostIOMMUDeviceIOMMUFD *idev;
+    SMMUS1Hwpt  *s1_hwpt;
     SMMUViommu *viommu;
     QLIST_ENTRY(SMMUv3AccelDevice) next;
 } SMMUv3AccelDevice;
-- 
2.34.1


