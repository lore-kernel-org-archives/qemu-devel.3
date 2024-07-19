Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C916AC3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 22:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUw69-0003n1-Ad; Fri, 19 Jul 2024 18:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sUw68-0003mX-2i
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 18:29:08 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sUw65-0005L6-QO
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 18:29:07 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JMQqBL014761;
 Fri, 19 Jul 2024 22:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=Y
 /WlHq74swFTeW5SEntl+tpnI+j131zUsPVk97tyYKs=; b=gbtiIg7I7Z7VwtzQS
 AB+U3kcd/N/lmjRXKbx3P+n9aue7pj5iAlUz4c+KE1mJ7xOpptknmL2M0Z2MREsK
 wwGK9YVz0g/StHQtToaJDf5BfCkDDyQMr49uptR0mV96RQUJnANUbK7QuNfC8/wV
 9ENBVmgXrtGbTISf/XikzArfZtbiDxZUlymgiVBEkmyGMjtgHetxSeap8xfK/CT5
 xDjur50pxUHjVSj0A17oOku2rraQVxFhti45bMzUGnRB6aUYcuDS3sC7vVLolabb
 kIyx2aubG9NGVWpsMKpB2QethhuEENkbcWo46bxhZgTo1am2nl0jeSvyexSWV9EN
 +i3Ew==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40g0wy8048-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jul 2024 22:29:01 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46JLL0E7021786; Fri, 19 Jul 2024 22:20:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwewegm0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jul 2024 22:20:03 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46JMK3IF036443;
 Fri, 19 Jul 2024 22:20:03 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-14-236.vpn.oracle.com
 [10.175.14.236])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 40dweweghg-1; Fri, 19 Jul 2024 22:20:02 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v5.1 12/13] vfio/migration: Don't block migration device dirty
 tracking is unsupported
Date: Fri, 19 Jul 2024 23:19:46 +0100
Message-Id: <20240719221946.97794-1-joao.m.martins@oracle.com>
In-Reply-To: <20240719120501.81279-1-joao.m.martins@oracle.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_08,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407190165
X-Proofpoint-ORIG-GUID: lsDZ5O5gs0Y7MhJDWR_omS_tNV7-yExK
X-Proofpoint-GUID: lsDZ5O5gs0Y7MhJDWR_omS_tNV7-yExK
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

By default VFIO migration is set to auto, which will support live
migration if the migration capability is set *and* also dirty page
tracking is supported.

For testing purposes one can force enable without dirty page tracking
via enable-migration=on, but that option is generally left for testing
purposes.

So starting with IOMMU dirty tracking it can use to accomodate the lack of
VF dirty page tracking allowing us to minimize the VF requirements for
migration and thus enabling migration by default for those too.

While at it change the error messages to mention IOMMU dirty tracking as
well.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
Same patch as v5, but fixes builds that have CONFIG_IOMMUFD=n

Sending just this one as it doesn't justify sending the whole series
again.
---
 hw/vfio/iommufd.c             |  2 +-
 hw/vfio/migration.c           | 11 ++++++-----
 include/hw/vfio/vfio-common.h |  8 ++++++++
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 7dd5d43ce06a..a998e8578552 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -111,7 +111,7 @@ static void iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
     iommufd_backend_disconnect(vbasedev->iommufd);
 }
 
-static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
+bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
 {
     return hwpt && hwpt->hwpt_flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
 }
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 34d4be2ce1b1..63ffa46c9652 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1036,16 +1036,17 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
         return !vfio_block_migration(vbasedev, err, errp);
     }
 
-    if (!vbasedev->dirty_pages_supported) {
+    if (!vbasedev->dirty_pages_supported &&
+        !iommufd_hwpt_dirty_tracking(vbasedev->hwpt)) {
         if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO) {
             error_setg(&err,
-                       "%s: VFIO device doesn't support device dirty tracking",
-                       vbasedev->name);
+                       "%s: VFIO device doesn't support device and "
+                       "IOMMU dirty tracking", vbasedev->name);
             goto add_blocker;
         }
 
-        warn_report("%s: VFIO device doesn't support device dirty tracking",
-                    vbasedev->name);
+        warn_report("%s: VFIO device doesn't support device and "
+                    "IOMMU dirty tracking", vbasedev->name);
     }
 
     ret = vfio_block_multiple_devices_migration(vbasedev, errp);
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 7e530c7869dc..333cabbf4362 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -299,6 +299,14 @@ int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                 VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
 int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
                           uint64_t size, ram_addr_t ram_addr, Error **errp);
+#ifdef CONFIG_IOMMUFD
+bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt);
+#else
+static inline bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
+{
+    return false;
+}
+#endif
 
 /* Returns 0 on success, or a negative errno. */
 bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
-- 
2.39.3


