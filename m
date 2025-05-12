Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBB1C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEVBQ-0007zh-2R; Mon, 12 May 2025 11:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9j-0004a2-WD
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:28 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9g-0006jT-PO
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:27 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9fVo026113;
 Mon, 12 May 2025 15:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=RFIaSmRfSFfl0IVQgc2+1JuBrRVDQ6vjBMPgQRZhQUk=; b=
 C/2EuQWff5j8B1WX2tAnfOeQxR1L5wC1+CU43fU0rtWSs5lv/p63VjR24Unf33E2
 TgO0uM/tAupbsX1Q7yWkbVEj4fMc3W8oiJzxvS1rmztuxD8bhI9FblT7YSoFpe9M
 fMd2oybbCFuS7DkzbbAlts2hlSL4N+p6k6qt6T6fBlZBBpablhIMp49a1macg8vm
 l1A4YrIwZYzPDqrBtIqg4PcXn0LV2yNkC+hMXMRubKCuLEfE22uZClGhnU66h+Hn
 jJMY2T4WlOtzNqnmOciThgwPuR0Z0HeMgWJ+PWPI9gv6U4o4SN7+kszpM5T0p2mZ
 mPq8q5yKNYa2zurVuhuDRw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j11c2rbc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:21 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CE214t002394; Mon, 12 May 2025 15:33:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx366s2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:20 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk5i030605;
 Mon, 12 May 2025 15:33:19 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-34; Mon, 12 May 2025 15:33:19 +0000
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
Subject: [PATCH V3 33/42] vfio/iommufd: define hwpt constructors
Date: Mon, 12 May 2025 08:32:44 -0700
Message-Id: <1747063973-124548-34-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_05,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120161
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfXwE5Ek02T2HM4
 ZVkHVctDDqioPRRK2RGk5wVS8ovsAhCm2fU5wze9C/UajeWdZ24ZLdi67dS0h3F0hcZr1ePPpEb
 riGFbSUSSCIoMrwaHJs9KO47wPR3azFHRStFWHHuUk92iwiIVAcyVg+2fvJK+ph53vtblpPAoD9
 KZ1oYT7QNg7QYaeUesOnBI9wgYgPWEVBgCQSQHPkGWFAhpR+rcnyDMp6BKaC6FlPub4XKh/QIG1
 ImyF1dh2oq3MX3ln1zmD1PDxe/wlhEB7F5zFnfoqkmoRuPXjxQHUS3knjZ7jvsWwHRf1CRGGOey
 UGvtsqiDy90HOAu5WvMDCahRe964PLlhf+d47GCgH6ODiElloN7/5Fh0gJw69eLRJ90AXV2E0UB
 QElUzg6J3A7EGd/0A+hoO/vC/WsHsE12G9PQek40oEAZ1mf42R77foxneHf18nyhJqPG6aFc
X-Authority-Analysis: v=2.4 cv=YJ2fyQGx c=1 sm=1 tr=0 ts=682214c1 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=BlNAZMo-1VRLLe_Oo1QA:9
X-Proofpoint-GUID: l56goCQKkshWcOTLYWR-aulF0mNTKW-f
X-Proofpoint-ORIG-GUID: l56goCQKkshWcOTLYWR-aulF0mNTKW-f
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
helpers iommufd_cdev_use_hwpt and iommufd_cdev_make_hwpt.  These will
be used by CPR in a subsequent patch.

Call vfio_device_hiod_create_and_realize earlier so iommufd_cdev_make_hwpt
can use vbasedev->hiod hw_caps, avoiding an extra call to
iommufd_backend_get_device_info

No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/iommufd.c | 116 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 65 insertions(+), 51 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index f645a62..8661947 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -310,16 +310,70 @@ static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
     return true;
 }
 
+static void iommufd_cdev_use_hwpt(VFIODevice *vbasedev, VFIOIOASHwpt *hwpt)
+{
+    vbasedev->hwpt = hwpt;
+    vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
+    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
+}
+
+/*
+ * iommufd_cdev_make_hwpt: If @alloc_id, allocate a hwpt_id, else use @hwpt_id.
+ * Create and add a hwpt struct to the container's list and to the device.
+ * Always succeeds if !@alloc_id.
+ */
+static bool iommufd_cdev_make_hwpt(VFIODevice *vbasedev,
+                                   VFIOIOMMUFDContainer *container,
+                                   uint32_t hwpt_id, bool alloc_id,
+                                   Error **errp)
+{
+    VFIOIOASHwpt *hwpt;
+    uint32_t flags = 0;
+
+    /*
+     * This is quite early and VFIO Migration state isn't yet fully
+     * initialized, thus rely only on IOMMU hardware capabilities as to
+     * whether IOMMU dirty tracking is going to be requested. Later
+     * vfio_migration_realize() may decide to use VF dirty tracking
+     * instead.
+     */
+    g_assert(vbasedev->hiod);
+    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
+        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
+    }
+
+    if (alloc_id) {
+        if (!iommufd_backend_alloc_hwpt(vbasedev->iommufd, vbasedev->devid,
+                                        container->ioas_id, flags,
+                                        IOMMU_HWPT_DATA_NONE, 0, NULL,
+                                        &hwpt_id, errp)) {
+            return false;
+        }
+
+        if (iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt_id, errp)) {
+            iommufd_backend_free_id(container->be, hwpt_id);
+            return false;
+        }
+    }
+
+    hwpt = g_malloc0(sizeof(*hwpt));
+    hwpt->hwpt_id = hwpt_id;
+    hwpt->hwpt_flags = flags;
+    QLIST_INIT(&hwpt->device_list);
+
+    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
+    container->bcontainer.dirty_pages_supported |=
+                                vbasedev->iommu_dirty_tracking;
+    iommufd_cdev_use_hwpt(vbasedev, hwpt);
+    return true;
+}
+
 static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
                                          VFIOIOMMUFDContainer *container,
                                          Error **errp)
 {
     ERRP_GUARD();
-    IOMMUFDBackend *iommufd = vbasedev->iommufd;
-    uint32_t type, flags = 0;
-    uint64_t hw_caps;
     VFIOIOASHwpt *hwpt;
-    uint32_t hwpt_id;
     int ret;
 
     /* Try to find a domain */
@@ -340,54 +394,14 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
 
             return false;
         } else {
-            vbasedev->hwpt = hwpt;
-            QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
-            vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
+            iommufd_cdev_use_hwpt(vbasedev, hwpt);
             return true;
         }
     }
-
-    /*
-     * This is quite early and VFIO Migration state isn't yet fully
-     * initialized, thus rely only on IOMMU hardware capabilities as to
-     * whether IOMMU dirty tracking is going to be requested. Later
-     * vfio_migration_realize() may decide to use VF dirty tracking
-     * instead.
-     */
-    if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
-                                         &type, NULL, 0, &hw_caps, errp)) {
-        return false;
-    }
-
-    if (hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
-        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
-    }
-
-    if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
-                                    container->ioas_id, flags,
-                                    IOMMU_HWPT_DATA_NONE, 0, NULL,
-                                    &hwpt_id, errp)) {
-        return false;
-    }
-
-    hwpt = g_malloc0(sizeof(*hwpt));
-    hwpt->hwpt_id = hwpt_id;
-    hwpt->hwpt_flags = flags;
-    QLIST_INIT(&hwpt->device_list);
-
-    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
-    if (ret) {
-        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
-        g_free(hwpt);
+    if (!iommufd_cdev_make_hwpt(vbasedev, container, 0, true, errp)) {
         return false;
     }
 
-    vbasedev->hwpt = hwpt;
-    vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
-    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
-    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
-    container->bcontainer.dirty_pages_supported |=
-                                vbasedev->iommu_dirty_tracking;
     if (container->bcontainer.dirty_pages_supported &&
         !vbasedev->iommu_dirty_tracking) {
         warn_report("IOMMU instance for device %s doesn't support dirty tracking",
@@ -530,6 +544,11 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
 
     space = vfio_address_space_get(as);
 
+    if (!vfio_device_hiod_create_and_realize(vbasedev,
+            TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO, errp)) {
+        goto err_alloc_ioas;
+    }
+
     /* try to attach to an existing container in this space */
     QLIST_FOREACH(bcontainer, &space->containers, next) {
         container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
@@ -604,11 +623,6 @@ found_container:
         goto err_listener_register;
     }
 
-    if (!vfio_device_hiod_create_and_realize(vbasedev,
-                     TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO, errp)) {
-        goto err_listener_register;
-    }
-
     /*
      * TODO: examine RAM_BLOCK_DISCARD stuff, should we do group level
      * for discarding incompatibility check as well?
-- 
1.8.3.1


