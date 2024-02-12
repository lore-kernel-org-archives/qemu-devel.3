Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47C5C4829D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 13:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZWoQ-0006qZ-Ie; Mon, 12 Feb 2024 08:57:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rZWo5-0006WX-A7
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 08:57:14 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rZWnz-0007DX-OZ
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 08:57:09 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41CDJU1X031824; Mon, 12 Feb 2024 13:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=ZqpDDFb94Rtg9GoTde3iZeO3BEp0KehjNyFIO+jKnqw=;
 b=AVWLTioHL0r3fLc0qeMPNtfE/QeMZ5lkpr5gXkWmBFm3GuOLvO8aEBZTvVWUc6JdAR3n
 K0oOxlGqvkYJx8oGhYNB8vecEC9m8+TclvHyCoQz9yg/xj/ES/3kiM+rgPUGiO8VOTZ9
 /ljkN+XaDvCu2AJatTs3GkippqWiwSjt0egQ+q/2CVo4H/SuHcThyITDfoskGmGKUx/C
 hPVNhgaokhbUb/JhtzeqUXUDcACg4EDH3aAVyN+9h+KypSZBY95ZW37QTJbORCbSjz9b
 jnyFDt0vHp6hyz2l4irM4UyhBRZ6vfp1sNqsFH6KwELxGhpOgx+qOhtZRPH9CEf5Uq6Y aQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7m40g323-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 13:57:03 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41CDkHL3024638; Mon, 12 Feb 2024 13:57:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3w5ykc20xh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 13:57:03 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CDuqi9026744;
 Mon, 12 Feb 2024 13:57:02 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-27-30.vpn.oracle.com
 [10.175.27.30])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3w5ykc20rs-4; Mon, 12 Feb 2024 13:57:02 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH RFCv2 3/8] vfio/iommufd: Probe and request hwpt dirty tracking
 capability
Date: Mon, 12 Feb 2024 13:56:38 +0000
Message-Id: <20240212135643.5858-4-joao.m.martins@oracle.com>
In-Reply-To: <20240212135643.5858-1-joao.m.martins@oracle.com>
References: <20240212135643.5858-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_10,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120105
X-Proofpoint-GUID: Z3_RBTLr-c4QDTNygh7Tt0MB_KFI_V9b
X-Proofpoint-ORIG-GUID: Z3_RBTLr-c4QDTNygh7Tt0MB_KFI_V9b
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Probe hardware dirty tracking support by querying device hw capabilities
via IOMMUFD_GET_HW_INFO.

In preparation to using the dirty tracking UAPI, request dirty tracking in
the HWPT flags when the device doesn't support dirty page tracking or has
it disabled; or when support when the VF backing IOMMU supports dirty
tracking. The latter is in the possibility of a device being attached
that doesn't have a dirty tracker.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 hw/vfio/common.c              | 18 ++++++++++++++++++
 hw/vfio/iommufd.c             | 25 ++++++++++++++++++++++++-
 include/hw/vfio/vfio-common.h |  2 ++
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index f7f85160be88..d8fc7077f839 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -216,6 +216,24 @@ bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer)
     return true;
 }
 
+bool vfio_device_migration_supported(VFIODevice *vbasedev)
+{
+    if (!vbasedev->migration) {
+        return false;
+    }
+
+    return vbasedev->migration->mig_flags & VFIO_MIGRATION_STOP_COPY;
+}
+
+bool vfio_device_dirty_pages_supported(VFIODevice *vbasedev)
+{
+    if (vbasedev->pre_copy_dirty_page_tracking == ON_OFF_AUTO_OFF) {
+        return false;
+    }
+
+    return !vbasedev->dirty_pages_supported;
+}
+
 /*
  * Check if all VFIO devices are running and migration is active, which is
  * essentially equivalent to the migration being in pre-copy phase.
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index ca7ec45e725c..edacb6d72748 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -219,11 +219,26 @@ static int iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
     return ret;
 }
 
+static bool iommufd_dirty_pages_supported(IOMMUFDDevice *iommufd_dev,
+                                          Error **errp)
+{
+    uint64_t caps;
+    int r;
+
+    r = iommufd_device_get_hw_capabilities(iommufd_dev, &caps, errp);
+    if (r) {
+        return false;
+    }
+
+    return caps & IOMMU_HW_CAP_DIRTY_TRACKING;
+}
+
 static int iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
                                         VFIOIOMMUFDContainer *container,
                                         Error **errp)
 {
     int iommufd = vbasedev->iommufd_dev.iommufd->fd;
+    uint32_t flags = 0;
     VFIOIOASHwpt *hwpt;
     Error *err = NULL;
     int ret = -EINVAL;
@@ -245,9 +260,15 @@ static int iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
         }
     }
 
+    if ((vfio_device_migration_supported(vbasedev) &&
+         !vfio_device_dirty_pages_supported(vbasedev)) ||
+        iommufd_dirty_pages_supported(&vbasedev->iommufd_dev, &err)) {
+        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
+    }
+
     ret = iommufd_backend_alloc_hwpt(iommufd,
                                      vbasedev->iommufd_dev.devid,
-                                     container->ioas_id, 0, 0, 0,
+                                     container->ioas_id, flags, 0, 0,
                                      NULL, &hwpt_id);
     if (ret) {
         error_append_hint(&err,
@@ -271,6 +292,8 @@ static int iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
     vbasedev->hwpt = hwpt;
     QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
     QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
+    container->bcontainer.dirty_pages_supported =
+                              (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING);
     return 0;
 }
 
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 7f7d823221e2..a3e691c126c6 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -271,6 +271,8 @@ bool
 vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer);
 bool
 vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
+bool vfio_device_migration_supported(VFIODevice *vbasedev);
+bool vfio_device_dirty_pages_supported(VFIODevice *vbasedev);
 int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                                     VFIOBitmap *vbmap, hwaddr iova,
                                     hwaddr size);
-- 
2.39.3


