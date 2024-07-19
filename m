Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32593C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 12:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUmNp-0004F7-1b; Fri, 19 Jul 2024 08:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sUmMr-00026u-MN
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 08:05:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sUmMm-0005Iq-9t
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 08:05:43 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JC5bIh024705;
 Fri, 19 Jul 2024 12:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=
 corp-2023-11-20; bh=aBTMLAUOErrtBaaALRZRpVobwfHDxEUKoLKiKNS2p88=; b=
 iigKY6vlgsfzmv+2h+hMZmQQVcPreRAav/kVxY8NJ9nvVInuqAqIt0L91sUq43Nu
 UXPO716lxq2M5S4aVVw6qWLfAzx3JdjZfFIR1IKlOsYCGXZoae4v9O0+hn+226r0
 VKMRkwyHUMajmkhTZEfK61HrH40qqHR8u7/mmVUppIjJ5bPwHf287/dJc6IGOqhm
 lv9qmpS1ExYAfElq6eGddhFqLlmclSuOMmrp7PsrxRzYNOeuvBpLRfrJsn7eZbNW
 RYgZxUcBOciGD1rUG9WWYNqHi9PQumONG02S6aEoC4KEV9hmbqz0Fd3sD6Vx6neG
 jlOEKjW+h1INjFbBMm4MDg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40fqub800b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jul 2024 12:05:37 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46JBmhoO038864; Fri, 19 Jul 2024 12:05:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwexk3ne-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jul 2024 12:05:36 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46JC5DMR011010;
 Fri, 19 Jul 2024 12:05:36 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-12-11.vpn.oracle.com
 [10.175.12.11])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 40dwexk34j-9; Fri, 19 Jul 2024 12:05:35 +0000
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v5 08/13] vfio/{iommufd,
 container}: Invoke HostIOMMUDevice::realize() during attach_device()
Date: Fri, 19 Jul 2024 13:04:56 +0100
Message-Id: <20240719120501.81279-9-joao.m.martins@oracle.com>
In-Reply-To: <20240719120501.81279-1-joao.m.martins@oracle.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407190093
X-Proofpoint-ORIG-GUID: roiO00xDCXN-_HBV2jMEkRG-wyf1t-OZ
X-Proofpoint-GUID: roiO00xDCXN-_HBV2jMEkRG-wyf1t-OZ
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
Reply-to:  Joao Martins <joao.m.martins@oracle.com>
From:  Joao Martins via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Move the HostIOMMUDevice::realize() to be invoked during the attach of the device
before we allocate IOMMUFD hardware pagetable objects (HWPT). This allows the use
of the hw_caps obtained by IOMMU_GET_HW_INFO that essentially tell if the IOMMU
behind the device supports dirty tracking.

Note: The HostIOMMUDevice data from legacy backend is static and doesn't
need any information from the (type1-iommu) backend to be initialized.
In contrast however, the IOMMUFD HostIOMMUDevice data requires the
iommufd FD to be connected and having a devid to be able to successfully
GET_HW_INFO. This means vfio_device_hiod_realize() is called in
different places within the backend .attach_device() implementation.

Suggested-by: Cédric Le Goater <clg@redhat.cm>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 include/hw/vfio/vfio-common.h |  1 +
 hw/vfio/common.c              | 16 ++++++----------
 hw/vfio/container.c           |  4 ++++
 hw/vfio/helpers.c             | 11 +++++++++++
 hw/vfio/iommufd.c             |  4 ++++
 5 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 1a96678f8c38..4e44b26d3c45 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -242,6 +242,7 @@ void vfio_region_finalize(VFIORegion *region);
 void vfio_reset_handler(void *opaque);
 struct vfio_device_info *vfio_get_device_info(int fd);
 bool vfio_device_is_mdev(VFIODevice *vbasedev);
+bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
 bool vfio_attach_device(char *name, VFIODevice *vbasedev,
                         AddressSpace *as, Error **errp);
 void vfio_detach_device(VFIODevice *vbasedev);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index b0beed44116e..cc14f0e3fe24 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1544,7 +1544,7 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
 {
     const VFIOIOMMUClass *ops =
         VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
-    HostIOMMUDevice *hiod;
+    HostIOMMUDevice *hiod = NULL;
 
     if (vbasedev->iommufd) {
         ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
@@ -1552,21 +1552,17 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
 
     assert(ops);
 
-    if (!ops->attach_device(name, vbasedev, as, errp)) {
-        return false;
-    }
 
-    if (vbasedev->mdev) {
-        return true;
+    if (!vbasedev->mdev) {
+        hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
+        vbasedev->hiod = hiod;
     }
 
-    hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
-    if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
+    if (!ops->attach_device(name, vbasedev, as, errp)) {
         object_unref(hiod);
-        ops->detach_device(vbasedev);
+        vbasedev->hiod = NULL;
         return false;
     }
-    vbasedev->hiod = hiod;
 
     return true;
 }
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index c27f448ba26e..adb302216e23 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -917,6 +917,10 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
 
     trace_vfio_attach_device(vbasedev->name, groupid);
 
+    if (!vfio_device_hiod_realize(vbasedev, errp)) {
+        return false;
+    }
+
     group = vfio_get_group(groupid, as, errp);
     if (!group) {
         return false;
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 7e23e9080c9d..ea15c79db0a3 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -689,3 +689,14 @@ bool vfio_device_is_mdev(VFIODevice *vbasedev)
     subsys = realpath(tmp, NULL);
     return subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
 }
+
+bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp)
+{
+    HostIOMMUDevice *hiod = vbasedev->hiod;
+
+    if (!hiod) {
+        return true;
+    }
+
+    return HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp);
+}
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 7a10b1e90a6f..bb44d948c735 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -403,6 +403,10 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
 
     space = vfio_get_address_space(as);
 
+    if (!vfio_device_hiod_realize(vbasedev, errp)) {
+        return false;
+    }
+
     /* try to attach to an existing container in this space */
     QLIST_FOREACH(bcontainer, &space->containers, next) {
         container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
-- 
2.17.2


