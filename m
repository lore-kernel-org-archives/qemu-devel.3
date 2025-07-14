Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AC7C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 17:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubMXf-0002h1-H7; Mon, 14 Jul 2025 13:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubLcj-0005Tu-Vd; Mon, 14 Jul 2025 12:01:52 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubLci-0008O3-2S; Mon, 14 Jul 2025 12:01:49 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bgn8x28qBz6M56C;
 Tue, 15 Jul 2025 00:00:33 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id E609B14033F;
 Tue, 15 Jul 2025 00:01:45 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Jul 2025 18:01:37 +0200
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <shameerkolothum@gmail.com>
Subject: [RFC PATCH v3 10/15] hw/arm/smmuv3-accel: Allocate a vDEVICE object
 for device
Date: Mon, 14 Jul 2025 16:59:36 +0100
Message-ID: <20250714155941.22176-11-shameerali.kolothum.thodi@huawei.com>
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

Allocate and associate a vDEVICE object for the Guest device
with the vIOMMU. This will help the kernel to do the
vSID --> sid translation whenever required (eg: device specific
invalidations).

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/smmuv3-accel.c    | 25 +++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h    |  1 +
 include/system/iommufd.h |  5 +++++
 3 files changed, 31 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 74bf20cfaf..f1584dd775 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -93,6 +93,23 @@ void smmuv3_accel_install_nested_ste(SMMUState *bs, SMMUDevice *sdev, int sid)
         return;
     }
 
+    if (!accel_dev->vdev && accel_dev->idev) {
+        IOMMUFDVdev *vdev;
+        uint32_t vdev_id;
+        SMMUViommu *viommu = accel_dev->viommu;
+
+        iommufd_backend_alloc_vdev(viommu->core.iommufd, accel_dev->idev->devid,
+                                   viommu->core.viommu_id, sid, &vdev_id,
+                                   &error_abort);
+        vdev = g_new(IOMMUFDVdev, 1);
+        vdev->vdev_id = vdev_id;
+        vdev->dev_id = sid;
+        accel_dev->vdev = vdev;
+        host_iommu_device_iommufd_attach_hwpt(accel_dev->idev,
+                                              accel_dev->viommu->bypass_hwpt_id,
+                                              &error_abort);
+    }
+
     ret = smmu_find_ste(sdev->smmu, sid, &ste, &event);
     if (ret) {
         error_report("failed to find STE for sid 0x%x", sid);
@@ -287,6 +304,7 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     SMMUPciBus *sbus = g_hash_table_lookup(bs->smmu_pcibus_by_busptr, bus);
     SMMUv3AccelDevice *accel_dev;
     SMMUViommu *viommu;
+    IOMMUFDVdev *vdev;
     SMMUDevice *sdev;
 
     if (!sbus) {
@@ -310,6 +328,13 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     trace_smmuv3_accel_unset_iommu_device(devfn, smmu_get_sid(sdev));
 
     viommu = s->s_accel->viommu;
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
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 06e81b630d..21028e60c8 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -40,6 +40,7 @@ typedef struct SMMUv3AccelDevice {
     HostIOMMUDeviceIOMMUFD *idev;
     SMMUS1Hwpt  *s1_hwpt;
     SMMUViommu *viommu;
+    IOMMUFDVdev  *vdev;
     QLIST_ENTRY(SMMUv3AccelDevice) next;
 } SMMUv3AccelDevice;
 
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index b7ad2cf10c..8de559d448 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -44,6 +44,11 @@ typedef struct IOMMUFDViommu {
     uint32_t viommu_id;
 } IOMMUFDViommu;
 
+typedef struct IOMMUFDVdev {
+    uint32_t vdev_id;
+    uint32_t dev_id;
+} IOMMUFDVdev;
+
 bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
 void iommufd_backend_disconnect(IOMMUFDBackend *be);
 
-- 
2.34.1


