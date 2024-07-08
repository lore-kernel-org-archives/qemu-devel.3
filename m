Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0C8C3DA42
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 14:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQpSH-0005P9-Oz; Mon, 08 Jul 2024 10:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sQpSB-0004sh-8I
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:34:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sQpS9-0002Y2-GA
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:34:54 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fTPe013142;
 Mon, 8 Jul 2024 14:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=Y
 c3OnvUrU3PWhiR2Avzv9BTvcSxWo6/reCBxayOrcSg=; b=SzvJVd8qBc1B50xlL
 lnwkmmYm+UxTzypRnaxxJ2ZTqfrkGTPb00Xy9U2Cv1cTm2C71eIEFSScwjfOYXRa
 eXegOJaV7NrMHbE+Q3zXxd6/er9cnOVovF8rZ7aO8IZTh5uPlfWXuxMRaz+xiRzh
 dWsi3mqT9RdjMsnk0Xu5wMChXKmAJVv/dfbCcOjiup+ElawgV6d3EYg0Nc5+C6MQ
 oDYMx6pDSL1AMOVahLawRFURNXcMnD4AwYQ5PIeF64KrSprjcevI+zE+1lsFWiZU
 9MrAECB0JoAc15R1/MLDbxd0MVngYUSqiWKKlKbeqc3IiZBxvCtktenSzmIyxKrU
 NOJPA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wgptt73-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jul 2024 14:34:51 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 468DOSFQ008768; Mon, 8 Jul 2024 14:34:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 407tu1r76c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jul 2024 14:34:50 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 468EXkZN037381;
 Mon, 8 Jul 2024 14:34:49 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-56-128.vpn.oracle.com
 [10.175.56.128])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 407tu1r6ms-11; Mon, 08 Jul 2024 14:34:49 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v3 10/10] vfio/common: Allow disabling device dirty page
 tracking
Date: Mon,  8 Jul 2024 15:34:20 +0100
Message-Id: <20240708143420.16953-11-joao.m.martins@oracle.com>
In-Reply-To: <20240708143420.16953-1-joao.m.martins@oracle.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=971
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080109
X-Proofpoint-ORIG-GUID: -8JAGnEatpol7mdoBZdPmK6HJVJ4t7nK
X-Proofpoint-GUID: -8JAGnEatpol7mdoBZdPmK6HJVJ4t7nK
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
 include/hw/vfio/vfio-common.h | 1 +
 hw/vfio/common.c              | 3 +++
 hw/vfio/migration.c           | 3 ++-
 hw/vfio/pci.c                 | 3 +++
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 7ce925cfab19..9db3fd31cfae 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -137,6 +137,7 @@ typedef struct VFIODevice {
     VFIOMigration *migration;
     Error *migration_blocker;
     OnOffAuto pre_copy_dirty_page_tracking;
+    OnOffAuto device_dirty_page_tracking;
     bool dirty_pages_supported;
     bool dirty_tracking;
     HostIOMMUDevice *hiod;
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7cdb969fd396..eaa33d9ee037 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -199,6 +199,9 @@ bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer)
     VFIODevice *vbasedev;
 
     QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
+        if (vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF) {
+            return false;
+        }
         if (!vbasedev->dirty_pages_supported) {
             return false;
         }
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 89195928666f..35d67332db20 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1037,7 +1037,8 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
         return !vfio_block_migration(vbasedev, err, errp);
     }
 
-    if (!vbasedev->dirty_pages_supported &&
+    if ((!vbasedev->dirty_pages_supported ||
+         vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF) &&
         (vbasedev->iommufd &&
          !hiodc->get_cap(vbasedev->hiod,
                          HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING, NULL))) {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index e03d9f3ba546..22819b2036b3 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3362,6 +3362,9 @@ static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("x-pre-copy-dirty-page-tracking", VFIOPCIDevice,
                             vbasedev.pre_copy_dirty_page_tracking,
                             ON_OFF_AUTO_ON),
+    DEFINE_PROP_ON_OFF_AUTO("x-device-dirty-page-tracking", VFIOPCIDevice,
+                            vbasedev.device_dirty_page_tracking,
+                            ON_OFF_AUTO_ON),
     DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
                             display, ON_OFF_AUTO_OFF),
     DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
-- 
2.17.2


