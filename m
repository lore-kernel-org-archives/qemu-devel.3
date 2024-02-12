Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EE9C4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 13:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZWor-0007BH-HV; Mon, 12 Feb 2024 08:58:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rZWoM-0006mC-DQ
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 08:57:32 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rZWoI-0007Gi-Qh
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 08:57:29 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41CDJNIr031779; Mon, 12 Feb 2024 13:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=bbKNI2tWJGb34lA30BIrwS3R/lj2i0DvpPnuPLxdUgY=;
 b=WvY2llUu2pyvC4BOrkkplAmUcXzWtnrdOx4Ys/+jEEyjRbIEZkYJujfwxHZHXREwadzm
 Ub8yoem+IqkWKrXeiEkI52iXiwR3FiTgall1Uqp7PRwg+jnOc37ASeGTI0ElK7+XblOt
 HCkwe6o1IXKmBu46MGUCE+xUqukU9NJ9MNNMMtssaPvhU3laEY/lw4sbP+zSjM54WT/I
 C9mnXvhBBdlWwEzOTl4bZ96t2w/8/foVJ5zgeLW6OJqjNbhlYqijU/syayho7Ni33se4
 iWNfqcpUBAi1Iu67ofj6K8xT1i/SWW97qDa+/gszBSJ/Hu2Mm2UZ1Vv0BaIFKqST9L82 7w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7m40g331-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 13:57:18 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41CCGuLL024016; Mon, 12 Feb 2024 13:57:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3w5ykc217k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 13:57:18 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CDuqiJ026744;
 Mon, 12 Feb 2024 13:57:17 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-27-30.vpn.oracle.com
 [10.175.27.30])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3w5ykc20rs-9; Mon, 12 Feb 2024 13:57:17 +0000
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
Subject: [PATCH RFCv2 8/8] vfio/common: Allow disabling device dirty page
 tracking
Date: Mon, 12 Feb 2024 13:56:43 +0000
Message-Id: <20240212135643.5858-9-joao.m.martins@oracle.com>
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
X-Proofpoint-GUID: nihlGWdeBZ5OniBfhGB8I0HvBUYAzDGA
X-Proofpoint-ORIG-GUID: nihlGWdeBZ5OniBfhGB8I0HvBUYAzDGA
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

The property 'x-pre-copy-dirty-page-tracking' allows disabling the whole
tracking of VF pre-copy phase of dirty page tracking, though it means
that it will only be used at the start of the switchover phase.

Add an option that disables the VF dirty page tracking, and fall
back into container-based dirty page tracking. This also allows to
use IOMMU dirty tracking even on VFs with their own dirty
tracker scheme.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 hw/vfio/common.c              | 7 +++++++
 hw/vfio/migration.c           | 3 ++-
 hw/vfio/pci.c                 | 3 +++
 include/hw/vfio/vfio-common.h | 1 +
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index a940c0b6ede8..9fe113ea016d 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -213,6 +213,9 @@ bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer)
     VFIODevice *vbasedev;
 
     QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
+        if (vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF) {
+            return false;
+        }
         if (!vbasedev->dirty_pages_supported) {
             return false;
         }
@@ -236,6 +239,10 @@ bool vfio_device_dirty_pages_supported(VFIODevice *vbasedev)
         return false;
     }
 
+    if (vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF) {
+        return false;
+    }
+
     return !vbasedev->dirty_pages_supported;
 }
 
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 674e76b3f3df..09e742fbeb9f 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -938,7 +938,8 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
         return !vfio_block_migration(vbasedev, err, errp);
     }
 
-    if (!vbasedev->dirty_pages_supported &&
+    if ((!vbasedev->dirty_pages_supported ||
+         vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF) &&
         (vbasedev->iommufd_dev.iommufd &&
          !iommufd_dirty_pages_supported(&vbasedev->iommufd_dev, &err))) {
         if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO) {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index dedb64fc080e..d3b516b2e4d3 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3349,6 +3349,9 @@ static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("x-pre-copy-dirty-page-tracking", VFIOPCIDevice,
                             vbasedev.pre_copy_dirty_page_tracking,
                             ON_OFF_AUTO_ON),
+    DEFINE_PROP_ON_OFF_AUTO("x-device-dirty-page-tracking", VFIOPCIDevice,
+                            vbasedev.device_dirty_page_tracking,
+                            ON_OFF_AUTO_ON),
     DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
                             display, ON_OFF_AUTO_OFF),
     DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index a3e691c126c6..e67f5e74cebd 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -136,6 +136,7 @@ typedef struct VFIODevice {
     VFIOMigration *migration;
     Error *migration_blocker;
     OnOffAuto pre_copy_dirty_page_tracking;
+    OnOffAuto device_dirty_page_tracking;
     bool dirty_pages_supported;
     bool dirty_tracking;
     union {
-- 
2.39.3


