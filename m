Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3EDC28B30
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 14:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts0MZ-0004bW-U6; Tue, 11 Mar 2025 10:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ts0MV-0004IA-Rw; Tue, 11 Mar 2025 10:13:39 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ts0MT-00076B-Qr; Tue, 11 Mar 2025 10:13:39 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZBwfG61yfz6D8cT;
 Tue, 11 Mar 2025 22:11:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 6EC7A140B63;
 Tue, 11 Mar 2025 22:13:35 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Mar 2025 15:13:28 +0100
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [RFC PATCH v2 11/20] hw/arm/smmuv3-accel: Allocate a vDEVICE object
 for device
Date: Tue, 11 Mar 2025 14:10:36 +0000
Message-ID: <20250311141045.66620-12-shameerali.kolothum.thodi@huawei.com>
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

Allocate and associate a vDEVICE object for the Guest device
with the vIOMMU. This will help the kernel to do the
vSID --> sid translation whenever required (eg: device specific
invalidations).

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/smmuv3-accel.c         | 22 ++++++++++++++++++++++
 include/hw/arm/smmuv3-accel.h |  6 ++++++
 2 files changed, 28 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index d3a5cf9551..056bd23b2e 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -109,6 +109,20 @@ void smmuv3_accel_install_nested_ste(SMMUDevice *sdev, int sid)
         return;
     }
 
+    if (!accel_dev->vdev && accel_dev->idev) {
+        SMMUVdev *vdev;
+        uint32_t vdev_id;
+        SMMUViommu *viommu = accel_dev->viommu;
+
+        iommufd_backend_alloc_vdev(viommu->core.iommufd, accel_dev->idev->devid,
+                                   viommu->core.viommu_id, sid, &vdev_id,
+                                   &error_abort);
+        vdev = g_new0(SMMUVdev, 1);
+        vdev->vdev_id = vdev_id;
+        vdev->sid = sid;
+        accel_dev->vdev = vdev;
+    }
+
     ret = smmu_find_ste(sdev->smmu, sid, &ste, &event);
     if (ret) {
         /*
@@ -283,6 +297,7 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
 static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
                                             int devfn)
 {
+    SMMUVdev *vdev;
     SMMUDevice *sdev;
     SMMUv3AccelDevice *accel_dev;
     SMMUViommu *viommu;
@@ -312,6 +327,13 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     trace_smmuv3_accel_unset_iommu_device(devfn, smmu_get_sid(sdev));
 
     viommu = s_accel->viommu;
+    vdev = accel_dev->vdev;
+    if (vdev) {
+        iommufd_backend_free_id(viommu->iommufd, vdev->vdev_id);
+        g_free(vdev);
+        accel_dev->vdev = NULL;
+    }
+
     if (QLIST_EMPTY(&viommu->device_list)) {
         iommufd_backend_free_id(viommu->iommufd, viommu->bypass_hwpt_id);
         iommufd_backend_free_id(viommu->iommufd, viommu->abort_hwpt_id);
diff --git a/include/hw/arm/smmuv3-accel.h b/include/hw/arm/smmuv3-accel.h
index d6b0b1ca30..54b217ab4f 100644
--- a/include/hw/arm/smmuv3-accel.h
+++ b/include/hw/arm/smmuv3-accel.h
@@ -35,6 +35,11 @@ typedef struct SMMUViommu {
     QLIST_ENTRY(SMMUViommu) next;
 } SMMUViommu;
 
+typedef struct SMMUVdev {
+    uint32_t vdev_id;
+    uint32_t sid;
+} SMMUVdev;
+
 typedef struct SMMUS1Hwpt {
     IOMMUFDBackend *iommufd;
     uint32_t hwpt_id;
@@ -45,6 +50,7 @@ typedef struct SMMUv3AccelDevice {
     HostIOMMUDeviceIOMMUFD *idev;
     SMMUS1Hwpt  *s1_hwpt;
     SMMUViommu *viommu;
+    SMMUVdev   *vdev;
     QLIST_ENTRY(SMMUv3AccelDevice) next;
 } SMMUv3AccelDevice;
 
-- 
2.34.1


