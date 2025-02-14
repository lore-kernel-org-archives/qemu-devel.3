Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868FBC021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwUe-0007zk-E8; Fri, 14 Feb 2025 09:16:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwTr-0006UR-Ku
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:15:47 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwTk-0004kZ-Le
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:15:46 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECtfkF011618;
 Fri, 14 Feb 2025 14:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=JiVpgb+Q1o93jKYbFztC7nGqDo9Po9K1XF/ulP7GSAI=; b=
 CVM+qVCk/o1VUHQnmvJCHfcFFFhgh3RYRKKI8JWTNtTUCmcaWBhmaVmPfYj9EdOg
 GKJowPDVnVc4rGctzH2kpz5exiUavXbRyy2Y82b1cTwuKsU+lYG0EYHhmuUStpPU
 Vh56512bN+ZNB6ZpbazsnQhy9FUxRX7A24Kxs4Tpbu3jLy4WEpcNvrk/C0yl7hip
 Y3m/I0SJr0Zis6gCyTbq2juX0bSF8yo+X0PsgH/PpwTYWOFmZwq8zE/Y5fb+Qm5X
 iWPpoj7qx2EA+PBk5BM+hL3e8Y/CnjnonV55Wl8wXp9/ezPcECqqvULSoRiFXbMu
 gU5yp286d1+WekC2uyuMNw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0sqbwp3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:15:26 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51ECSkjj025168; Fri, 14 Feb 2025 14:15:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqksh9j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:15:26 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51EEETQb006920;
 Fri, 14 Feb 2025 14:15:25 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 44nwqksg2h-43; Fri, 14 Feb 2025 14:15:25 +0000
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
Subject: [PATCH V2 42/45] vfio/iommufd: reconstruct hwpt
Date: Fri, 14 Feb 2025 06:14:24 -0800
Message-Id: <1739542467-226739-43-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: hym0yEbttVOxLou658T3fB4gzoH4Ncjm
X-Proofpoint-GUID: hym0yEbttVOxLou658T3fB4gzoH4Ncjm
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

Save the hwpt_id in vmstate.  In realize, skip its allocation from
iommufd_cdev_attach -> iommufd_cdev_attach_container ->
iommufd_cdev_autodomains_get.  Rebuild userland structures to hold
hwpt_id by calling iommufd_cdev_rebuild_hwpt at post load time.
This depends on hw_caps, which was restored by the post_load call to
vfio_device_hiod_realize.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/cpr-iommufd.c         |  7 +++++++
 hw/vfio/iommufd.c             | 19 +++++++++++++++++++
 hw/vfio/trace-events          |  1 +
 include/hw/vfio/vfio-common.h |  2 ++
 include/hw/vfio/vfio-cpr.h    |  1 +
 5 files changed, 30 insertions(+)

diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index a1ac517..4b78ebf 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -108,6 +108,12 @@ static int vfio_device_post_load(void *opaque, int version_id)
         error_report_err(err);
         return false;
     }
+    if (!vbasedev->mdev) {
+        VFIOIOMMUFDContainer *container = container_of(vbasedev->bcontainer,
+                                                       VFIOIOMMUFDContainer,
+                                                       bcontainer);
+        iommufd_cdev_rebuild_hwpt(vbasedev, container);
+    }
     return true;
 }
 
@@ -119,6 +125,7 @@ static const VMStateDescription vfio_device_vmstate = {
     .needed = cpr_needed_for_reuse,
     .fields = (VMStateField[]) {
         VMSTATE_INT32(devid, VFIODevice),
+        VMSTATE_UINT32(cpr.hwpt_id, VFIODevice),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 693ed19..cf92c96 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -298,6 +298,7 @@ static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
 static void iommufd_cdev_set_hwpt(VFIODevice *vbasedev, VFIOIOASHwpt *hwpt)
 {
     vbasedev->hwpt = hwpt;
+    vbasedev->cpr.hwpt_id = hwpt->hwpt_id;
     vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
     QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
 }
@@ -323,6 +324,24 @@ static VFIOIOASHwpt *iommufd_cdev_make_hwpt(VFIODevice *vbasedev,
     return hwpt;
 }
 
+void iommufd_cdev_rebuild_hwpt(VFIODevice *vbasedev,
+                               VFIOIOMMUFDContainer *container)
+{
+    VFIOIOASHwpt *hwpt;
+    int hwpt_id = vbasedev->cpr.hwpt_id;
+
+    trace_iommufd_cdev_rebuild_hwpt(container->be->fd, hwpt_id);
+
+    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
+        if (hwpt->hwpt_id == hwpt_id) {
+            iommufd_cdev_set_hwpt(vbasedev, hwpt);
+            return;
+        }
+    }
+    hwpt = iommufd_cdev_make_hwpt(vbasedev, container, hwpt_id);
+    iommufd_cdev_set_hwpt(vbasedev, hwpt);
+}
+
 static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
                                          VFIOIOMMUFDContainer *container,
                                          Error **errp)
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index cab1cf1..25ff04c 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -176,6 +176,7 @@ iommufd_cdev_connect_and_bind(int iommufd, const char *name, int devfd, int devi
 iommufd_cdev_getfd(const char *dev, int devfd) " %s (fd=%d)"
 iommufd_cdev_attach_ioas_hwpt(int iommufd, const char *name, int devfd, int id) " [iommufd=%d] Successfully attached device %s (%d) to id=%d"
 iommufd_cdev_detach_ioas_hwpt(int iommufd, const char *name) " [iommufd=%d] Successfully detached %s"
+iommufd_cdev_rebuild_hwpt(int iommufd, int hwpt_id) " [iommufd=%d] hwpt %d"
 iommufd_cdev_fail_attach_existing_container(const char *msg) " %s"
 iommufd_cdev_alloc_ioas(int iommufd, int ioas_id) " [iommufd=%d] new IOMMUFD container with ioasid=%d"
 iommufd_cdev_device_info(char *name, int devfd, int num_irqs, int num_regions, int flags) " %s (%d) num_irqs=%d num_regions=%d flags=%d"
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 6701393..00831b7 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -265,6 +265,8 @@ void vfio_kvm_device_close(void);
 bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
 void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
 
+void iommufd_cdev_rebuild_hwpt(VFIODevice *vbasedev,
+                               VFIOIOMMUFDContainer *container);
 bool iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
                                       uint32_t ioas_id, Error **errp);
 
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index fa4b928..d195ce6 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -23,6 +23,7 @@ typedef struct VFIODeviceCPR {
     bool reused;
     Error *mdev_blocker;
     Error *id_blocker;
+    uint32_t hwpt_id;
 } VFIODeviceCPR;
 
 struct VFIOContainer;
-- 
1.8.3.1


