Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408B4C3ABD7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEVBB-0007Gw-Fv; Mon, 12 May 2025 11:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9m-0004eu-Mu
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9i-0006k3-2T
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:30 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9e1i029134;
 Mon, 12 May 2025 15:33:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=457N7ybNax9/cGmjm0Z9j80VLHxXbfSo/qOxEtY0mCc=; b=
 dznZP2B0Xv4wn7I7bG1NdP68YsMvQjyE+rw8/IjecZiLyVBT6sI7+IGw+wJjlxxq
 P2osHFj7lMBwU//AGUGls8QABvepWwI7CL8Epjvx1SXnOedVceEPurJPTf7gjBpi
 AUboqVUYpxjzBXxp2KSphiAxCyPSbro0cjCCsotjqFmcq74L4Ta5GFcS+d+8lDC6
 bl3a0kMZC4pFokJbS4PkPwX+kmNbFaeZVzWL0lAO5qX0yT0h4Qctz5StTj4K3HqX
 d+bTJX0MRwMW4XmFujd+lWPRp6NJhhC1WsQZicwiUfb2QHDLKIMn31XsyrCSNRZg
 Eo+WjBK9ci+DesXc+A6Cqw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j0gwju7j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:22 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CE6vNN002823; Mon, 12 May 2025 15:33:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx366tj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:21 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk5o030605;
 Mon, 12 May 2025 15:33:21 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-37; Mon, 12 May 2025 15:33:21 +0000
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
Subject: [PATCH V3 36/42] vfio/iommufd: preserve descriptors
Date: Mon, 12 May 2025 08:32:47 -0700
Message-Id: <1747063973-124548-37-git-send-email-steven.sistare@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=M8hNKzws c=1 sm=1 tr=0 ts=682214c2 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=28-vp7vVO8PgcjRJnlAA:9
X-Proofpoint-GUID: 9tbdGRPuMdrSXJeHPMx2KsJPLKtC30F_
X-Proofpoint-ORIG-GUID: 9tbdGRPuMdrSXJeHPMx2KsJPLKtC30F_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfX3VbrAP70kygh
 TT/i5DbY/4oxM4yuAWqynKycl7Yg9CqfR5j5+bAEOqaN/qDsawzsYsVy2tpPPdRgzNtnuLD82FH
 g9o1asQ3D+1Nhj6M8bSSwr2OQJUDwtR+RGbtTUBsvpyZZXvI8sCDelW36RhPhXq1mzQd+rjYTDH
 tdpeg877NRRgymM8HUQb1vgJ8yM7qe2TBiIog8Va2XnDq39dz7TwzA6ACT6/PUtaG+Z7RhJfVwI
 SA10mLak182KVPEu/Z1vCqjwEyLeJypzIVsz7WE6SXI0gVgDgnBDLez2uvk3bo6X1S0aUETonqq
 seZ9e2sAzL+OSPsudSsTtmfaI+anT82yPmjQ1s3YNGgpx4IjnzCkfwKxvSxiI+nHhe3vtnn8KDJ
 BBwjS/btzI/Ztwdeoq93+T+NlOPNAcwlFH7HAh1E53TGIhrndHShgC50nQg+cjPC05AwMoac
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

Save the iommu and vfio device fd in CPR state when it is created.
After CPR, the fd number is found in CPR state and reused.  Remember
the reused status for subsequent patches.  The reused status is cleared
when vmstate load finishes.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 backends/iommufd.c       | 19 ++++++++++---------
 hw/vfio/cpr-iommufd.c    | 16 ++++++++++++++++
 hw/vfio/device.c         | 10 ++--------
 hw/vfio/iommufd.c        | 13 +++++++++++--
 include/system/iommufd.h |  1 +
 5 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 6fed1c1..492747c 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -16,12 +16,18 @@
 #include "qemu/module.h"
 #include "qom/object_interfaces.h"
 #include "qemu/error-report.h"
+#include "migration/cpr.h"
 #include "monitor/monitor.h"
 #include "trace.h"
 #include "hw/vfio/vfio-device.h"
 #include <sys/ioctl.h>
 #include <linux/iommufd.h>
 
+static const char *iommufd_fd_name(IOMMUFDBackend *be)
+{
+    return object_get_canonical_path_component(OBJECT(be));
+}
+
 static void iommufd_backend_init(Object *obj)
 {
     IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
@@ -47,9 +53,8 @@ static void iommufd_backend_set_fd(Object *obj, const char *str, Error **errp)
     IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
     int fd = -1;
 
-    fd = monitor_fd_param(monitor_cur(), str, errp);
+    fd = cpr_get_fd_param(iommufd_fd_name(be), str, 0, &be->cpr_reused, errp);
     if (fd == -1) {
-        error_prepend(errp, "Could not parse remote object fd %s:", str);
         return;
     }
     be->fd = fd;
@@ -95,14 +100,9 @@ bool iommufd_change_process(IOMMUFDBackend *be, Error **errp)
 
 bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
 {
-    int fd;
-
     if (be->owned && !be->users) {
-        fd = qemu_open("/dev/iommu", O_RDWR, errp);
-        if (fd < 0) {
-            return false;
-        }
-        be->fd = fd;
+        be->fd = cpr_open_fd("/dev/iommu", O_RDWR, iommufd_fd_name(be), 0,
+                             &be->cpr_reused, errp);
     }
     be->users++;
 
@@ -121,6 +121,7 @@ void iommufd_backend_disconnect(IOMMUFDBackend *be)
         be->fd = -1;
     }
 out:
+    cpr_delete_fd(iommufd_fd_name(be), 0);
     trace_iommufd_backend_disconnect(be->fd, be->users);
 }
 
diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index 46f2006..b760bd3 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -8,6 +8,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/vfio/vfio-cpr.h"
+#include "hw/vfio/vfio-device.h"
 #include "migration/blocker.h"
 #include "migration/cpr.h"
 #include "migration/migration.h"
@@ -25,10 +26,25 @@ static bool vfio_cpr_supported(VFIOIOMMUFDContainer *container, Error **errp)
     return true;
 }
 
+static int vfio_container_post_load(void *opaque, int version_id)
+{
+    VFIOIOMMUFDContainer *container = opaque;
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIODevice *vbasedev;
+
+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
+        vbasedev->cpr.reused = false;
+    }
+    container->be->cpr_reused = false;
+
+    return 0;
+}
+
 static const VMStateDescription vfio_container_vmstate = {
     .name = "vfio-iommufd-container",
     .version_id = 0,
     .minimum_version_id = 0,
+    .post_load = vfio_container_post_load,
     .needed = cpr_needed_for_reuse,
     .fields = (VMStateField[]) {
         VMSTATE_END_OF_LIST()
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 8e9de68..02f384e 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -312,14 +312,8 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
 
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
 {
-    ERRP_GUARD();
-    int fd = monitor_fd_param(monitor_cur(), str, errp);
-
-    if (fd < 0) {
-        error_prepend(errp, "Could not parse remote object fd %s:", str);
-        return;
-    }
-    vbasedev->fd = fd;
+    vbasedev->fd = cpr_get_fd_param(vbasedev->dev->id, str, 0,
+                                    &vbasedev->cpr.reused, errp);
 }
 
 static VFIODeviceIOOps vfio_device_io_ops_ioctl;
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index dabb948..046f601 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -26,6 +26,7 @@
 #include "qemu/cutils.h"
 #include "qemu/chardev_open.h"
 #include "migration/blocker.h"
+#include "migration/cpr.h"
 #include "pci.h"
 #include "vfio-iommufd.h"
 #include "vfio-helpers.h"
@@ -530,13 +531,18 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
 
     if (vbasedev->fd < 0) {
-        devfd = iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
+        devfd = cpr_find_fd(vbasedev->name, 0);
+        vbasedev->cpr.reused = (devfd >= 0);
+        if (!vbasedev->cpr.reused) {
+            devfd = iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
+        }
         if (devfd < 0) {
             return false;
         }
         vbasedev->fd = devfd;
     } else {
         devfd = vbasedev->fd;
+        /* reused was set in iommufd_backend_set_fd */
     }
 
     if (!iommufd_cdev_connect_and_bind(vbasedev, errp)) {
@@ -634,7 +640,9 @@ found_container:
 
     vfio_device_prepare(vbasedev, bcontainer, &dev_info);
     vfio_iommufd_cpr_register_device(vbasedev);
-
+    if (!vbasedev->cpr.reused) {
+        cpr_save_fd(vbasedev->name, 0, vbasedev->fd);
+    }
     trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
                                    vbasedev->num_regions, vbasedev->flags);
     return true;
@@ -673,6 +681,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
 
     migrate_del_blocker(&vbasedev->cpr.id_blocker);
     vfio_iommufd_cpr_unregister_device(vbasedev);
+    cpr_delete_fd(vbasedev->name, 0);
     iommufd_cdev_unbind_and_disconnect(vbasedev);
     close(vbasedev->fd);
 }
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index db9ed53..5c17abd 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -32,6 +32,7 @@ struct IOMMUFDBackend {
     /*< protected >*/
     int fd;            /* /dev/iommu file descriptor */
     bool owned;        /* is the /dev/iommu opened internally */
+    bool cpr_reused;   /* fd is reused after CPR */
     uint32_t users;
 
     /*< public >*/
-- 
1.8.3.1


