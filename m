Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D5FC3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 12:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUmRW-0001o2-FY; Fri, 19 Jul 2024 08:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sUmRN-0001J1-63
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 08:10:26 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sUmRL-0007UO-Bg
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 08:10:24 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JC5X0X024683;
 Fri, 19 Jul 2024 12:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=/
 LFxmvwv7vuHhJK2tagye6IGULM/ax2W4PVw648ofXE=; b=FOnmqulPPRyeZBxlC
 3xcTyU6Li0vvLYE9fm0mcKyUljO53CF9tkMR209S7Ca/7FcKeZ9uhNCkuf6gDAyg
 bcTdEoFOqwNHVTM1Uyo9gta0K29WsGsz+5g8D4JCj1nD2Le7wRJgk4kWdmfFQPJ0
 Km65j8aCmYUlkG6Lxhh35F8KbbsfC2my/2TuqSuOd8HA/eb5jAnkJftdaGapC4W4
 0g7T4x7Riidqlar7DHy4xkUUYZyI9hm1DjOawLxKFnzn9pidepSUGUgDpInGEQdH
 zPuOE+RMvz4DzlipraAeH4FUOuJRMkV5VJaTHaLyoEqx1NJOWvFCgPseOsp6JsCR
 uX8Vw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40fqub80my-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jul 2024 12:10:21 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46JAPYHx039605; Fri, 19 Jul 2024 12:05:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwexk3af-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jul 2024 12:05:20 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46JC5DMF011010;
 Fri, 19 Jul 2024 12:05:19 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-12-11.vpn.oracle.com
 [10.175.12.11])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 40dwexk34j-3; Fri, 19 Jul 2024 12:05:19 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v5 02/13] vfio/iommufd: Don't initialize nor set a
 HOST_IOMMU_DEVICE with mdev
Date: Fri, 19 Jul 2024 13:04:50 +0100
Message-Id: <20240719120501.81279-3-joao.m.martins@oracle.com>
In-Reply-To: <20240719120501.81279-1-joao.m.martins@oracle.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407190093
X-Proofpoint-ORIG-GUID: MOOrL-TIcx-zgLJBwDNaKzW-nCTA-xTs
X-Proofpoint-GUID: MOOrL-TIcx-zgLJBwDNaKzW-nCTA-xTs
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

mdevs aren't "physical" devices and when asking for backing IOMMU info, it
fails the entire provisioning of the guest. Fix that by skipping
HostIOMMUDevice initialization in the presence of mdevs, and skip setting
an iommu device when it is known to be an mdev.

Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>
Fixes: 930589520128 ("vfio/iommufd: Implement HostIOMMUDeviceClass::realize() handler")
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/common.c |  4 ++++
 hw/vfio/pci.c    | 11 ++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7cdb969fd396..b0beed44116e 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1556,6 +1556,10 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
         return false;
     }
 
+    if (vbasedev->mdev) {
+        return true;
+    }
+
     hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
     if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
         object_unref(hiod);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b34e91468a53..265d3cb82ffc 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3115,7 +3115,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     vfio_bars_register(vdev);
 
-    if (!pci_device_set_iommu_device(pdev, vbasedev->hiod, errp)) {
+    if (!vbasedev->mdev &&
+        !pci_device_set_iommu_device(pdev, vbasedev->hiod, errp)) {
         error_prepend(errp, "Failed to set iommu_device: ");
         goto out_teardown;
     }
@@ -3238,7 +3239,9 @@ out_deregister:
         timer_free(vdev->intx.mmap_timer);
     }
 out_unset_idev:
-    pci_device_unset_iommu_device(pdev);
+    if (!vbasedev->mdev) {
+        pci_device_unset_iommu_device(pdev);
+    }
 out_teardown:
     vfio_teardown_msi(vdev);
     vfio_bars_exit(vdev);
@@ -3283,7 +3286,9 @@ static void vfio_exitfn(PCIDevice *pdev)
     vfio_pci_disable_rp_atomics(vdev);
     vfio_bars_exit(vdev);
     vfio_migration_exit(vbasedev);
-    pci_device_unset_iommu_device(pdev);
+    if (!vbasedev->mdev) {
+        pci_device_unset_iommu_device(pdev);
+    }
 }
 
 static void vfio_pci_reset(DeviceState *dev)
-- 
2.17.2


