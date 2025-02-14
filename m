Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23385C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwUa-0007gV-Cb; Fri, 14 Feb 2025 09:16:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwTj-0006F8-II
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:15:40 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwTa-0004iy-5K
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:15:33 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECtSpa006439;
 Fri, 14 Feb 2025 14:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=jivM27DVJP4ghdtnYsoXrniOA5k7eFfXLtJN3lmwVyg=; b=
 UkDLvw3VaPX4/9N5766hVYUhRp/X2eEasQtSfVj2nDV4HOmv2ncusCF7uWyOfXXq
 wlMFiARWfuEOjFp/W0hTg7wUjZrYHKXJGh/xG+IVVxmsS8IdXMMQXtZZrpQxM49a
 Zv3jGR4oB1T4sja2qwMoWOHDMMgO5MXTqQVZYC0HiMyqnTYyWAuzViNvoZbhpCfg
 Ic35FPPsD++IDeFdnvdVq+CZiB6Wv/1tIH0zjjeNLs9LHnsqbRSSRgnVD+0PVlTZ
 71CESpKTrMN9N96pCClrKDb/WrDajbc4ZcXn4F4s160O/S+dL5pAHAa4OFSMMg7l
 416socZP3PIJ9E4dhcyw6Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qaknwv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:15:17 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51ED5ZWp025287; Fri, 14 Feb 2025 14:15:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqksh1j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:15:16 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51EEETQN006920;
 Fri, 14 Feb 2025 14:15:16 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 44nwqksg2h-36; Fri, 14 Feb 2025 14:15:16 +0000
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
Subject: [PATCH V2 35/45] vfio/iommufd: define hwpt constructors
Date: Fri, 14 Feb 2025 06:14:17 -0800
Message-Id: <1739542467-226739-36-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140104
X-Proofpoint-GUID: wAB1pfZegL2um3YpEQbuh-fDj_0WoFOd
X-Proofpoint-ORIG-GUID: wAB1pfZegL2um3YpEQbuh-fDj_0WoFOd
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
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

Extract hwpt creation code from iommufd_cdev_autodomains_get into the
helpers iommufd_cdev_set_hwpt and iommufd_cdev_make_hwpt.  These will
be used by CPR in a subsequent patch.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/iommufd.c | 52 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index a6e24a7..7c0cdd7 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -287,6 +287,34 @@ static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
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
@@ -316,13 +344,10 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
 
             return false;
         } else {
-            vbasedev->hwpt = hwpt;
-            QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
-            vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
+            iommufd_cdev_set_hwpt(vbasedev, hwpt);
             return true;
         }
     }
-
     /*
      * This is quite early and VFIO Migration state isn't yet fully
      * initialized, thus rely only on IOMMU hardware capabilities as to
@@ -341,24 +366,15 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
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


