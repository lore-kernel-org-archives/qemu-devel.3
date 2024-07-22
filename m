Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8E0C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0MK-00023l-10; Mon, 22 Jul 2024 17:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sW0ME-0001id-Gy
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:14:11 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sW0MA-0006Nu-Ez
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:14:09 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MKti3K002764;
 Mon, 22 Jul 2024 21:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=
 corp-2023-11-20; bh=caUnH35mSVtS4izDKjB8ltn8+MTG4h9W+WbcJ24IdDA=; b=
 U67ekzvSg8G1yzrH78NoYOlQ6L9BwZPf58GPJbIUb2tJPFYQPhhCaha3EoJq3ZGn
 /Uhql8iXnj0QSsO5ZUZAmvV/+th18aJLGFgTjwqP3sdX8dP7enoWFYiqRFgCf5x3
 91bOyBg/Eq0hioDAlnLqK4uvmpshmQJqfc7K407xC7B/Ad4smEpfUG9YfiS4X1gt
 7keAzJ55liIE1ua23Mc7ugYdkY3GA9g78Xt+L2PK9SWOnHpyCoaPMQPz3dqgQgSg
 2Uo8vcBZtRDs9usTAVy8dNL/ZN7sTnFXmMA8+aMjN+Rsw/h7YRMwVnb0C3nBBJ+r
 iZkkaUR5o7EZJo6yOA7bYQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hghckghd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 21:13:59 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46MJnpmq010983; Mon, 22 Jul 2024 21:13:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40h29qa7gp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 21:13:58 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46ML6tx9040372;
 Mon, 22 Jul 2024 21:13:58 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-61-12.vpn.oracle.com
 [10.175.61.12])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 40h29qa7av-5; Mon, 22 Jul 2024 21:13:58 +0000
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v6 4/9] vfio/{iommufd,
 container}: Invoke HostIOMMUDevice::realize() during attach_device()
Date: Mon, 22 Jul 2024 22:13:21 +0100
Message-Id: <20240722211326.70162-5-joao.m.martins@oracle.com>
In-Reply-To: <20240722211326.70162-1-joao.m.martins@oracle.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_14,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220157
X-Proofpoint-GUID: 7hunzv29OFVjWeJpn-lyLs7ywPoRbbGd
X-Proofpoint-ORIG-GUID: 7hunzv29OFVjWeJpn-lyLs7ywPoRbbGd
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
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
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
index 784e266e6aab..da12cbd56408 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1537,7 +1537,7 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
 {
     const VFIOIOMMUClass *ops =
         VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
-    HostIOMMUDevice *hiod;
+    HostIOMMUDevice *hiod = NULL;
 
     if (vbasedev->iommufd) {
         ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
@@ -1545,21 +1545,17 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
 
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
index 10cb4b4320ac..9ccdb639ac84 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -914,6 +914,10 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
 
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
index 5e2fc1ce089d..2324bf892c56 100644
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


