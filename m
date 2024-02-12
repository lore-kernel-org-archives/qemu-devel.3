Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66E0C48297
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 13:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZWpb-000862-EH; Mon, 12 Feb 2024 08:58:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rZWoK-0006hT-2r
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 08:57:28 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rZWoH-0007G7-Aa
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 08:57:26 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41CDJReS031799; Mon, 12 Feb 2024 13:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=0NZhiOEWz7ONTB49CXHlw2TDED4An2pbk9tsG7osT8I=;
 b=BmwYjwT7Lnb6mS9ePN1AIDCZQTerFQoPp/Sf/9LhL2QArbqh5NvV1tvkddJ3atIqIyaS
 gXUQQDbECyQn3cYMWmyAB3WaxhfPRbqwFrd8pv2xbSimZoMrm1wu5gg2meBL7ZKnSNk/
 uioOpryL8ITX9kDO7uWSwhilRgLxa7oePMqCXO9QqeHEyaX6xHWhmnlfH/P032XIC5Vt
 VGgMVBezmp2NczX946H3PLqu5G4zaf+cX1RrttNv3Zyj2G43AGmKPyshgFUbywBrlmLe
 sC/DSf6k2HA41gfpcHhQurj7eYvBGP6FTNd0Z1F5llBo7nTaU5emViZfj6zKCSZds8hE vg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7m40g32t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 13:57:15 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41CDltKF024567; Mon, 12 Feb 2024 13:57:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3w5ykc215b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 13:57:15 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CDuqiH026744;
 Mon, 12 Feb 2024 13:57:14 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-27-30.vpn.oracle.com
 [10.175.27.30])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3w5ykc20rs-8; Mon, 12 Feb 2024 13:57:14 +0000
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
Subject: [PATCH RFCv2 7/8] vfio/migration: Don't block migration device dirty
 tracking is unsupported
Date: Mon, 12 Feb 2024 13:56:42 +0000
Message-Id: <20240212135643.5858-8-joao.m.martins@oracle.com>
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
X-Proofpoint-GUID: 1CIXOrjp6UaOMH_Z8Dg81fxCOj5oXpP1
X-Proofpoint-ORIG-GUID: 1CIXOrjp6UaOMH_Z8Dg81fxCOj5oXpP1
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

By default VFIO migration is set to auto, which will support live
migration if the migration capability is set *and* also dirty page
tracking is supported.

For testing purposes one can force enable without dirty page tracking
via enable-migration=on, but that option is generally left for testing
purposes.

So starting with IOMMU dirty tracking it can use to acomodate the lack of
VF dirty page tracking allowing us to minimize the VF requirements for
migration and thus enabling migration by default for those.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 hw/vfio/iommufd.c        | 3 +--
 hw/vfio/migration.c      | 4 +++-
 include/sysemu/iommufd.h | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 697d40841d7f..78d8f4391b68 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -275,8 +275,7 @@ static int iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
     return ret;
 }
 
-static bool iommufd_dirty_pages_supported(IOMMUFDDevice *iommufd_dev,
-                                          Error **errp)
+bool iommufd_dirty_pages_supported(IOMMUFDDevice *iommufd_dev, Error **errp)
 {
     uint64_t caps;
     int r;
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 70e6b1a709f9..674e76b3f3df 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -938,7 +938,9 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
         return !vfio_block_migration(vbasedev, err, errp);
     }
 
-    if (!vbasedev->dirty_pages_supported) {
+    if (!vbasedev->dirty_pages_supported &&
+        (vbasedev->iommufd_dev.iommufd &&
+         !iommufd_dirty_pages_supported(&vbasedev->iommufd_dev, &err))) {
         if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO) {
             error_setg(&err,
                        "%s: VFIO device doesn't support device dirty tracking",
diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
index bc6607e3d444..d6be49f2ac78 100644
--- a/include/sysemu/iommufd.h
+++ b/include/sysemu/iommufd.h
@@ -53,6 +53,7 @@ typedef struct IOMMUFDDevice {
 void iommufd_device_init(IOMMUFDDevice *idev);
 int iommufd_device_get_hw_capabilities(IOMMUFDDevice *idev, uint64_t *caps,
                                        Error **errp);
+bool iommufd_dirty_pages_supported(IOMMUFDDevice *idev, Error **errp);
 int iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id,
                                uint32_t pt_id, uint32_t flags,
                                uint32_t data_type, uint32_t data_len,
-- 
2.39.3


