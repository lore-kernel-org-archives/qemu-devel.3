Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0087C02190
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 14:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td9Ii-0000g4-1b; Wed, 29 Jan 2025 09:44:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1td9Ib-0000fC-VB
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:44:14 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1td9IZ-0001OS-P7
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:44:13 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TEXk6c006554;
 Wed, 29 Jan 2025 14:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=nE7wuTh9USZkkNmT+UVS0+zVkHM32tvpNteq2BHkwMY=; b=
 hyJPp37DqhJCD8l3JJvdM6WQPq5ji37h54YL+5m/B6kVVVYXJimMUKSjk2ZhFkST
 l+8HLNjRSZbCd/kV07q+SySoUJ2g7vyZB9vknW2fTeb23DwHkTMJKfkOIW4Z45R5
 FCYoe6Y6pEfM4ykuydzSFlqTcCcc01AfYo4pUPmqpqyBI0Sq0tceT+IZQnnx6LCX
 4cZZ3NGkihdI8X3yPPFmam/l0/VxRYMBiRLaxw8igz54fi8oBB7abodMxZDazPjj
 znqsjlRC+xtfR9h4A+5uUgHS+PdJOLhq1/myII7zHXod8iZnmaPd47iN29wYgpZ9
 V7/etZN61iPltN2e7QPGVw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fmf808um-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 14:43:59 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50TDGTtK037021; Wed, 29 Jan 2025 14:43:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44cpd9s4v7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 14:43:58 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50TEhf92003307;
 Wed, 29 Jan 2025 14:43:57 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 44cpd9s49q-25; Wed, 29 Jan 2025 14:43:57 +0000
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
Subject: [PATCH V1 24/26] vfio/iommufd: preserve descriptors
Date: Wed, 29 Jan 2025 06:43:20 -0800
Message-Id: <1738161802-172631-25-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: N_ECke_chYsCxpeYv6lHl2diCuXCyyg0
X-Proofpoint-ORIG-GUID: N_ECke_chYsCxpeYv6lHl2diCuXCyyg0
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.498,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

Save the iommu and vfio device fd in CPR state when it is created.
After CPR, the fd number is found in CPR state and reused.  Remember
the reused status for subsequent patches.  The reused status is cleared
when vmstate load finishes.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 backends/iommufd.c       | 24 ++++++++++++++++++++----
 hw/vfio/cpr-iommufd.c    | 15 +++++++++++++++
 hw/vfio/helpers.c        | 10 ++--------
 hw/vfio/iommufd.c        | 10 +++++++++-
 include/system/iommufd.h |  1 +
 5 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index be5f6a3..e9452e4 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -16,12 +16,18 @@
 #include "qemu/module.h"
 #include "qom/object_interfaces.h"
 #include "qemu/error-report.h"
+#include "migration/cpr.h"
 #include "monitor/monitor.h"
 #include "trace.h"
 #include "hw/vfio/vfio-common.h"
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
@@ -46,10 +52,10 @@ static void iommufd_backend_set_fd(Object *obj, const char *str, Error **errp)
     ERRP_GUARD();
     IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
     int fd = -1;
+    const char *name = iommufd_fd_name(be);
 
-    fd = monitor_fd_param(monitor_cur(), str, errp);
+    fd = cpr_get_fd_param(name, str, 0, &be->reused, errp);
     if (fd == -1) {
-        error_prepend(errp, "Could not parse remote object fd %s:", str);
         return;
     }
     be->fd = fd;
@@ -98,10 +104,16 @@ bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
     int fd;
 
     if (be->owned && !be->users) {
-        fd = qemu_open("/dev/iommu", O_RDWR, errp);
+        const char *name = iommufd_fd_name(be);
+        fd = cpr_find_fd(name, 0);
+        be->reused = (fd >= 0);
+        if (!be->reused) {
+            fd = qemu_open("/dev/iommu", O_RDWR, errp);
+        }
         if (fd < 0) {
             return false;
         }
+        cpr_resave_fd(name, 0, fd);
         be->fd = fd;
     }
     be->users++;
@@ -112,6 +124,9 @@ bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
 
 void iommufd_backend_disconnect(IOMMUFDBackend *be)
 {
+    int fd = be->fd;
+    const char *name = iommufd_fd_name(be);
+
     if (!be->users) {
         goto out;
     }
@@ -121,7 +136,8 @@ void iommufd_backend_disconnect(IOMMUFDBackend *be)
         be->fd = -1;
     }
 out:
-    trace_iommufd_backend_disconnect(be->fd, be->users);
+    cpr_delete_fd(name, 0);
+    trace_iommufd_backend_disconnect(fd, be->users);
 }
 
 bool iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index 4eb358a..053ff8c 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -24,10 +24,25 @@ static bool vfio_cpr_supported(VFIOIOMMUFDContainer *container, Error **errp)
     return true;
 }
 
+static int vfio_container_post_load(void *opaque, int version_id)
+{
+    VFIOIOMMUFDContainer *container = opaque;
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIODevice *vbasedev;
+
+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
+        vbasedev->reused = false;
+    }
+    container->be->reused = false;
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
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index bd94b86..7f69707 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -678,14 +678,8 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
 
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
+                                    &vbasedev->reused, errp);
 }
 
 void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index ae78e00..abd17b6 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -25,6 +25,7 @@
 #include "qemu/cutils.h"
 #include "qemu/chardev_open.h"
 #include "migration/blocker.h"
+#include "migration/cpr.h"
 #include "pci.h"
 #include "exec/ram_addr.h"
 
@@ -499,13 +500,18 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
 
     if (vbasedev->fd < 0) {
-        devfd = iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
+        devfd = cpr_find_fd(vbasedev->name, 0);
+        vbasedev->reused = (devfd >= 0);
+        if (!vbasedev->reused) {
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
@@ -620,6 +626,7 @@ found_container:
     QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
     QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
     vfio_iommufd_cpr_register_device(vbasedev);
+    cpr_resave_fd(vbasedev->name, 0, devfd);
 
     trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
                                    vbasedev->num_regions, vbasedev->flags);
@@ -661,6 +668,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
 
     migrate_del_blocker(&vbasedev->cpr_id_blocker);
     vfio_iommufd_cpr_unregister_device(vbasedev);
+    cpr_delete_fd(vbasedev->name, 0);
     iommufd_cdev_unbind_and_disconnect(vbasedev);
     close(vbasedev->fd);
 }
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 4e9c037..6618248 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -32,6 +32,7 @@ struct IOMMUFDBackend {
     /*< protected >*/
     int fd;            /* /dev/iommu file descriptor */
     bool owned;        /* is the /dev/iommu opened internally */
+    bool reused;       /* fd is reused after CPR */
     uint32_t users;
 
     /*< public >*/
-- 
1.8.3.1


