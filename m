Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C726DC3DA59
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 19:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVFZ9-00077R-Vc; Sat, 20 Jul 2024 15:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVFYv-0006py-OQ
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:16:14 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVFYj-0000pi-2M
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:16:03 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46KJC5S7024759;
 Sat, 20 Jul 2024 19:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=qRto/pvnEyoMMJwjO7J8WazkfLwLTPRBpNgqAp8ROR8=; b=
 PA5kzuaoH35bwTX0JBMRGQ33d5PJNrYycNTfYC+MGuzq4euCt+X1Q5Zp3+Mf6D9R
 SGM9WXft1Hmg6jeVNETMAVqYekgr3h/KNmz2tAsZZR+ZhJPCyj64y0eZrr40GF/J
 4KIKZ0ytG51H3rn7bNDVCCV9rkCbQbNK8o5mIawXdAY0J+f24+3vSy4wkwRggyty
 IKZSJPp4VqUKCnD/7NXyQ9601RJOL2Pbu1YFh+AmprfYh/p+gLPSUveupN0iZ/m8
 7GWUCjOk07/Z78HKUW1SqwQT7KOK+Qqo+PTEnklfRm5AEUMqm26vPqQGxpJrG9N2
 JYFu49+qniiQxizg51ZHOQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40gk5jr04d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 19:15:47 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46KIfsYr027542; Sat, 20 Jul 2024 19:15:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40g3p5puu9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 19:15:46 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46KJFdfB028365;
 Sat, 20 Jul 2024 19:15:46 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 40g3p5pusv-6; Sat, 20 Jul 2024 19:15:46 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 05/12] iommufd: preserve device fd
Date: Sat, 20 Jul 2024 12:15:30 -0700
Message-Id: <1721502937-87102-6-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1721502937-87102-1-git-send-email-steven.sistare@oracle.com>
References: <1721502937-87102-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-20_16,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407200140
X-Proofpoint-GUID: I4keliZ8JNp44lv8SGujXGpB6lDuvuEu
X-Proofpoint-ORIG-GUID: I4keliZ8JNp44lv8SGujXGpB6lDuvuEu
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Save the iommu and vfio device fd in CPR state when it is created, and fetch
the fd from that state after CPR.  Save the devid as the fd id.  Remember
that the fd was reused, for subsequent patches.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 backends/iommufd.c       | 12 +++++++++++-
 hw/vfio/iommufd.c        | 17 ++++++++++++++++-
 include/sysemu/iommufd.h |  1 +
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index fc37386..4bdbad2 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -16,6 +16,7 @@
 #include "qemu/module.h"
 #include "qom/object_interfaces.h"
 #include "qemu/error-report.h"
+#include "migration/cpr.h"
 #include "monitor/monitor.h"
 #include "trace.h"
 #include <sys/ioctl.h>
@@ -77,11 +78,17 @@ bool iommufd_backend_connect(IOMMUFDBackend *be, const char *name, Error **errp)
     int fd;
 
     if (be->owned && !be->users) {
-        fd = qemu_open_old("/dev/iommu", O_RDWR);
+        g_autofree char *iname = g_strdup_printf("%s_iommu", name);
+        fd = cpr_find_fd(iname, 0);
+        be->reused = (fd >= 0);
+        if (!be->reused) {
+            fd = qemu_open_old("/dev/iommu", O_RDWR);
+        }
         if (fd < 0) {
             error_setg_errno(errp, errno, "/dev/iommu opening failed");
             return false;
         }
+        cpr_resave_fd(iname, 0, fd);
         be->fd = fd;
     }
     be->users++;
@@ -92,6 +99,8 @@ bool iommufd_backend_connect(IOMMUFDBackend *be, const char *name, Error **errp)
 
 void iommufd_backend_disconnect(IOMMUFDBackend *be, const char *name)
 {
+    g_autofree char *iname = g_strdup_printf("%s_iommu", name);
+
     if (!be->users) {
         goto out;
     }
@@ -101,6 +110,7 @@ void iommufd_backend_disconnect(IOMMUFDBackend *be, const char *name)
         be->fd = -1;
     }
 out:
+    cpr_delete_fd(iname, 0);
     trace_iommufd_backend_disconnect(be->fd, be->users);
 }
 
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 255966a..cefc9e0 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -24,6 +24,7 @@
 #include "sysemu/reset.h"
 #include "qemu/cutils.h"
 #include "qemu/chardev_open.h"
+#include "migration/cpr.h"
 #include "pci.h"
 
 static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
@@ -84,6 +85,11 @@ static bool iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
         goto err_kvm_device_add;
     }
 
+    if (vbasedev->reused) {
+        /* Already bound, and devid was set in iommufd_cdev_attach */
+        goto skip_bind;
+    }
+
     /* Bind device to iommufd */
     bind.iommufd = iommufd->fd;
     if (ioctl(vbasedev->fd, VFIO_DEVICE_BIND_IOMMUFD, &bind)) {
@@ -95,6 +101,8 @@ static bool iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
     vbasedev->devid = bind.out_devid;
     trace_iommufd_cdev_connect_and_bind(bind.iommufd, vbasedev->name,
                                         vbasedev->fd, vbasedev->devid);
+
+skip_bind:
     return true;
 err_bind:
     iommufd_cdev_kvm_device_del(vbasedev);
@@ -305,13 +313,18 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
 
     if (vbasedev->fd < 0) {
-        devfd = iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
+        devfd = cpr_find_fd_any(vbasedev->name, (int *)&vbasedev->devid);
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
+        vbasedev->reused = false;
     }
 
     if (!iommufd_cdev_connect_and_bind(vbasedev, errp)) {
@@ -413,6 +426,7 @@ found_container:
     vbasedev->bcontainer = bcontainer;
     QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
     QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
+    cpr_resave_fd(vbasedev->name, vbasedev->devid, devfd);
 
     trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
                                    vbasedev->num_regions, vbasedev->flags);
@@ -452,6 +466,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
     iommufd_cdev_container_destroy(container);
     vfio_put_address_space(space);
 
+    cpr_delete_fd(vbasedev->name, vbasedev->devid);
     iommufd_cdev_unbind_and_disconnect(vbasedev);
     close(vbasedev->fd);
 }
diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
index aa195d1..6955ebd 100644
--- a/include/sysemu/iommufd.h
+++ b/include/sysemu/iommufd.h
@@ -32,6 +32,7 @@ struct IOMMUFDBackend {
     /*< protected >*/
     int fd;            /* /dev/iommu file descriptor */
     bool owned;        /* is the /dev/iommu opened internally */
+    bool reused;       /* fd is reused after CPR */
     uint32_t users;
 
     /*< public >*/
-- 
1.8.3.1


