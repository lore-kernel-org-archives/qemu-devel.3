Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB2AC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 11:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSEkg-0005mj-SL; Fri, 12 Jul 2024 07:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sSEkK-0005Uc-8t
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:47:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sSEkF-0007cF-HH
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:47:28 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46C1BcTH018652;
 Fri, 12 Jul 2024 11:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=K
 a3prPYoEe/KSHCLuHyyuvQyvjBT8EDPgFMoR5YBJF8=; b=IOEQuxaK9Gd9mMsuO
 m4ARxgH2a1Z+U70Ni9X0gaGUXrYZfR+YDXX2CIWTUHNu0aAaYM3eX3p2kIkNPKDH
 tcaiOse+FMwGJTeI+tIV8jdDJxkjlcb2ESoOAtxrPwIQo7aC/kxT1DtKdnn65Ojt
 A636ppuBj0bt4i93Y482ontwTs+bDlbcTSs51Ipz10gHQzmjy4Agk6RtpkXZmiln
 xCf1SnQBDY3Nwx2BHhMcXTQAy3EbnS26Qm0abUz57MagJz0nJUCpueX9QQLbXoie
 A2xiJtW84sjKbYjnuPyKEMkkmoTV9bPZ8t64bPJUG4M65TcYo9JzyA+liRAlJIsL
 8Pkgw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkckm7t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 11:47:19 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46CB2Gvt022045; Fri, 12 Jul 2024 11:47:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 409vv3pq18-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 11:47:18 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46CBlCCW008041;
 Fri, 12 Jul 2024 11:47:18 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-0-59.vpn.oracle.com
 [10.175.0.59])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 409vv3ppxv-3; Fri, 12 Jul 2024 11:47:18 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v4 02/12] vfio/iommufd: Don't initialize nor set a
 HOST_IOMMU_DEVICE with mdev
Date: Fri, 12 Jul 2024 12:46:54 +0100
Message-Id: <20240712114704.8708-3-joao.m.martins@oracle.com>
In-Reply-To: <20240712114704.8708-1-joao.m.martins@oracle.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_08,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120080
X-Proofpoint-ORIG-GUID: 4h5CV6SrapTsSFzDeNIZXIbLFVzZK-LJ
X-Proofpoint-GUID: 4h5CV6SrapTsSFzDeNIZXIbLFVzZK-LJ
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
---
 hw/vfio/common.c |  4 ++++
 hw/vfio/pci.c    | 10 +++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

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
index 585f23a18406..3fc72e898a25 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3116,7 +3116,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     vfio_bars_register(vdev);
 
-    if (!pci_device_set_iommu_device(pdev, vbasedev->hiod, errp)) {
+    if (!is_mdev && !pci_device_set_iommu_device(pdev, vbasedev->hiod, errp)) {
         error_prepend(errp, "Failed to set iommu_device: ");
         goto out_teardown;
     }
@@ -3239,7 +3239,9 @@ out_deregister:
         timer_free(vdev->intx.mmap_timer);
     }
 out_unset_idev:
-    pci_device_unset_iommu_device(pdev);
+    if (!is_mdev) {
+        pci_device_unset_iommu_device(pdev);
+    }
 out_teardown:
     vfio_teardown_msi(vdev);
     vfio_bars_exit(vdev);
@@ -3284,7 +3286,9 @@ static void vfio_exitfn(PCIDevice *pdev)
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


