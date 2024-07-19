Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAF2C3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 12:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUmUO-0006bj-8k; Fri, 19 Jul 2024 08:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sUmUK-00066Y-H2
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 08:13:28 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sUmU3-000056-OB
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 08:13:15 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JC51l5023753;
 Fri, 19 Jul 2024 12:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=9
 liA1bCUYFMvSERPxDNd9PQbhxGm5nBPb0PG1ToOlPg=; b=aJj+SaR5RwpmAjbzx
 XPpsoPEDlo+VxnGJdoQzi4vUzWDw40qT1dHHz2xoh/HTKDD7VhDF06VOUY2tWTMg
 nFay9vXEGVwyigV/d1AICATXaNDngidoTAjaKMQ/eVpJYs7rKEae/q5DhRAUeYZ2
 cfIicjMk+2VQ90g0kl7j+pmJ78MCWsMlqT4yh1CpPuCDEce82l00DflEUYQLlSv9
 /cJuxQf+j2ySdTLeCngBgu4RoRbDFwbZNPaZwB2Abbix3FS9mIxI3FLcHUrdQgqK
 ISvfEcxlJsdkbvPUT6serM/OCZxgWfu+abIzwPhdFrS7thLEwumWg/bNgOle9pAj
 UdmJg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40fqub80tu-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jul 2024 12:13:07 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46JBci3L039556; Fri, 19 Jul 2024 12:05:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwexk416-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jul 2024 12:05:50 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46JC5DMb011010;
 Fri, 19 Jul 2024 12:05:50 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-12-11.vpn.oracle.com
 [10.175.12.11])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 40dwexk34j-14; Fri, 19 Jul 2024 12:05:49 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v5 13/13] vfio/common: Allow disabling device dirty page
 tracking
Date: Fri, 19 Jul 2024 13:05:01 +0100
Message-Id: <20240719120501.81279-14-joao.m.martins@oracle.com>
In-Reply-To: <20240719120501.81279-1-joao.m.martins@oracle.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=950
 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407190093
X-Proofpoint-ORIG-GUID: lDuZF6yLYE5x9JseHnE9FxVBzgB_tPeD
X-Proofpoint-GUID: lDuZF6yLYE5x9JseHnE9FxVBzgB_tPeD
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
index 00b9e933449e..61dd48e79b71 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -138,6 +138,7 @@ typedef struct VFIODevice {
     VFIOMigration *migration;
     Error *migration_blocker;
     OnOffAuto pre_copy_dirty_page_tracking;
+    OnOffAuto device_dirty_page_tracking;
     bool dirty_pages_supported;
     bool dirty_tracking;
     HostIOMMUDevice *hiod;
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index cc14f0e3fe24..070a4a2df020 100644
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
index 63ffa46c9652..88fdc6efbcc9 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1036,7 +1036,8 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
         return !vfio_block_migration(vbasedev, err, errp);
     }
 
-    if (!vbasedev->dirty_pages_supported &&
+    if ((!vbasedev->dirty_pages_supported ||
+         vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF) &&
         !iommufd_hwpt_dirty_tracking(vbasedev->hwpt)) {
         if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO) {
             error_setg(&err,
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 265d3cb82ffc..2407720c3530 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3361,6 +3361,9 @@ static Property vfio_pci_dev_properties[] = {
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


