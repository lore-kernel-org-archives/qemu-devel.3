Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4760C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 14:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td9IX-0000cB-LT; Wed, 29 Jan 2025 09:44:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1td9IO-0000YY-FU
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:44:00 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1td9IL-0001NO-U0
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:43:59 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TEY0l6031380;
 Wed, 29 Jan 2025 14:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=+AKEkt32BwKo0VjU6pwERzhRxGPKMq7ug0mCN6QZXAM=; b=
 WaHLu6M3PxHNDHkCoNOxZO5iYS6ijQJFj1FslSkIAlkTZXKtrwml4UFMDT7Iaofd
 VJPVKZ1Suoi5AHK6vh5pPickhQedOOT8j/PGMXYOS0CoSGgLQScJAa4eeA5LgYRN
 ejKV//B3BD2CeHp/t84c88TEGy4B3CX4vSuPEubDVQf28uh2R3yTYx5/gubU5FBD
 CExOCJEjyUVtHBhuvVAN2rTnyzxTDImnYXtBZLTcwRV+sv3sfbzmPnD3FkmjxtiD
 pNYN5rg7wmH+H8doNg8fNqBU2GkSkZYkhr9rI7uXeH3v2uyrx6zkPjOAdogbHn4W
 agJC8KM7Is2gWinGlIHLxQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fp1a81dr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 14:43:55 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50TDus2s034933; Wed, 29 Jan 2025 14:43:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44cpd9s4td-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 14:43:54 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50TEhf8o003307;
 Wed, 29 Jan 2025 14:43:53 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 44cpd9s49q-19; Wed, 29 Jan 2025 14:43:53 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 18/26] vfio/iommufd: define iommufd_cdev_make_hwpt
Date: Wed, 29 Jan 2025 06:43:14 -0800
Message-Id: <1738161802-172631-19-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290119
X-Proofpoint-GUID: bMBn0Y_bFMuvM-SJCFlyTA-EvFAhaIA8
X-Proofpoint-ORIG-GUID: bMBn0Y_bFMuvM-SJCFlyTA-EvFAhaIA8
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.498,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Refactor and define iommufd_cdev_make_hwpt, to be called by CPR in a
a later patch.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/iommufd.c | 69 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 41 insertions(+), 28 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 3490a8f..42ba63f 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -275,6 +275,41 @@ static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
     return true;
 }
 
+static void iommufd_cdev_set_hwpt(VFIODevice *vbasedev, VFIOIOASHwpt *hwpt)
+{
+    vbasedev->hwpt = hwpt;
+    vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
+    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
+}
+
+static VFIOIOASHwpt *iommufd_cdev_make_hwpt(VFIODevice *vbasedev,
+                                            VFIOIOMMUFDContainer *container,
+                                            uint32_t hwpt_id)
+{
+    VFIOIOASHwpt *hwpt = g_malloc0(sizeof(*hwpt));
+    uint32_t flags = 0;
+
+    /*
+     * This is quite early and VFIO Migration state isn't yet fully
+     * initialized, thus rely only on IOMMU hardware capabilities as to
+     * whether IOMMU dirty tracking is going to be requested. Later
+     * vfio_migration_realize() may decide to use VF dirty tracking
+     * instead.
+     */
+    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
+        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
+    }
+
+    hwpt->hwpt_id = hwpt_id;
+    hwpt->hwpt_flags = flags;
+    QLIST_INIT(&hwpt->device_list);
+
+    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
+    container->bcontainer.dirty_pages_supported |=
+                                vbasedev->iommu_dirty_tracking;
+    return hwpt;
+}
+
 static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
                                          VFIOIOMMUFDContainer *container,
                                          Error **errp)
@@ -304,24 +339,11 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
 
             return false;
         } else {
-            vbasedev->hwpt = hwpt;
-            QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
-            vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
+            iommufd_cdev_set_hwpt(vbasedev, hwpt);
             return true;
         }
     }
 
-    /*
-     * This is quite early and VFIO Migration state isn't yet fully
-     * initialized, thus rely only on IOMMU hardware capabilities as to
-     * whether IOMMU dirty tracking is going to be requested. Later
-     * vfio_migration_realize() may decide to use VF dirty tracking
-     * instead.
-     */
-    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
-        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
-    }
-
     if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
                                     container->ioas_id, flags,
                                     IOMMU_HWPT_DATA_NONE, 0, NULL,
@@ -329,24 +351,15 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
         return false;
     }
 
-    hwpt = g_malloc0(sizeof(*hwpt));
-    hwpt->hwpt_id = hwpt_id;
-    hwpt->hwpt_flags = flags;
-    QLIST_INIT(&hwpt->device_list);
-
-    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
+    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt_id, errp);
     if (ret) {
-        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
-        g_free(hwpt);
+        iommufd_backend_free_id(container->be, hwpt_id);
         return false;
     }
 
-    vbasedev->hwpt = hwpt;
-    vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
-    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
-    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
-    container->bcontainer.dirty_pages_supported |=
-                                vbasedev->iommu_dirty_tracking;
+    hwpt = iommufd_cdev_make_hwpt(vbasedev, container, hwpt_id);
+    iommufd_cdev_set_hwpt(vbasedev, hwpt);
+
     if (container->bcontainer.dirty_pages_supported &&
         !vbasedev->iommu_dirty_tracking) {
         warn_report("IOMMU instance for device %s doesn't support dirty tracking",
-- 
1.8.3.1


