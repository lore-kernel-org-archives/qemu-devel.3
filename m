Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5242C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 11:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSEko-0006GZ-IY; Fri, 12 Jul 2024 07:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sSEkV-0005YK-Cn
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:47:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sSEkS-0007eg-3l
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:47:38 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46C9mTWI018637;
 Fri, 12 Jul 2024 11:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=
 corp-2023-11-20; bh=XfT1W7GX/5K7SqPB1l3VjJYEXfu3NPoeRozKhr2EtAU=; b=
 L9+xp3WeSX244tB8EYKrfjQbP3x8bH5oFNWDafkRfL+OJPq4Vmx/L8QC0J56mkX1
 n0WaDfXgS36eh/rRMUePIlzsFYf1udK+9n1C4Wg1lIoCSk7Vx1x7O0RFqzftUVp0
 na972SC0/RQ66vbR7PbYOWThuc+PQchblnk5NdOC26ZmhOiDLgGoHBagi0/6w0tp
 nA5koR1NphXUgT6qqyw+zwm3GXnhwzUfUuaSuyA1yJZIwBv7JdHG4pBAAVG5Qafd
 2UjHAAGn2fIK+JM/Vtv2mlMc4O7OXfsdA+hk8TN/Y1oy3JrP1wGtVy61bJwmlMgm
 Wjl58ryFkuyyWYQPw+yZ9w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkckm89-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 11:47:33 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46CAYOU9022020; Fri, 12 Jul 2024 11:47:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 409vv3pq6k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 11:47:32 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46CBlCCg008041;
 Fri, 12 Jul 2024 11:47:31 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-0-59.vpn.oracle.com
 [10.175.0.59])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 409vv3ppxv-8; Fri, 12 Jul 2024 11:47:31 +0000
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v4 07/12] vfio/{iommufd,
 container}: Initialize HostIOMMUDeviceCaps during attach_device()
Date: Fri, 12 Jul 2024 12:46:59 +0100
Message-Id: <20240712114704.8708-8-joao.m.martins@oracle.com>
In-Reply-To: <20240712114704.8708-1-joao.m.martins@oracle.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_08,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120080
X-Proofpoint-ORIG-GUID: hBUvswmuHey_5MiS-ejp6VIsy9JD1Nfz
X-Proofpoint-GUID: hBUvswmuHey_5MiS-ejp6VIsy9JD1Nfz
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

Fetch IOMMU hw raw caps behind the device and thus move the
HostIOMMUDevice::realize() to be done during the attach of the device. It
allows it to cache the information obtained from IOMMU_GET_HW_INFO from
iommufd early on. However, while legacy HostIOMMUDevice caps
always return true and doesn't have dependency on other things, the IOMMUFD
backend requires the iommufd FD to be connected and having a devid to be
able to query capabilities. Hence when exactly is HostIOMMUDevice
initialized inside backend ::attach_device() implementation is backend
specific.

This is in preparation to fetch parse hw capabilities and understand if
dirty tracking is supported by device backing IOMMU without necessarily
duplicating the amount of calls we do to IOMMU_GET_HW_INFO.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 include/sysemu/host_iommu_device.h |  1 +
 hw/vfio/common.c                   | 16 ++++++----------
 hw/vfio/container.c                |  6 ++++++
 hw/vfio/iommufd.c                  |  7 +++++++
 4 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
index 20e77cf54568..b1e5f4b8ac3e 100644
--- a/include/sysemu/host_iommu_device.h
+++ b/include/sysemu/host_iommu_device.h
@@ -24,6 +24,7 @@
  */
 typedef struct HostIOMMUDeviceCaps {
     uint32_t type;
+    uint64_t hw_caps;
 } HostIOMMUDeviceCaps;
 
 #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
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
index c27f448ba26e..29da261bbf3e 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -907,6 +907,7 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
                                       AddressSpace *as, Error **errp)
 {
     int groupid = vfio_device_groupid(vbasedev, errp);
+    HostIOMMUDevice *hiod = vbasedev->hiod;
     VFIODevice *vbasedev_iter;
     VFIOGroup *group;
     VFIOContainerBase *bcontainer;
@@ -917,6 +918,11 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
 
     trace_vfio_attach_device(vbasedev->name, groupid);
 
+    if (hiod &&
+        !HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
+        return false;
+    }
+
     group = vfio_get_group(groupid, as, errp);
     if (!group) {
         return false;
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 873c919e319c..d34dc88231ec 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -384,6 +384,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
     Error *err = NULL;
     const VFIOIOMMUClass *iommufd_vioc =
         VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
+    HostIOMMUDevice *hiod = vbasedev->hiod;
 
     if (vbasedev->fd < 0) {
         devfd = iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
@@ -401,6 +402,11 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
 
     space = vfio_get_address_space(as);
 
+    if (hiod &&
+        !HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
+        return false;
+    }
+
     /* try to attach to an existing container in this space */
     QLIST_FOREACH(bcontainer, &space->containers, next) {
         container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
@@ -722,6 +728,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
 
     hiod->name = g_strdup(vdev->name);
     caps->type = type;
+    caps->hw_caps = hw_caps;
 
     return true;
 }
-- 
2.17.2


