Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A939CC8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 22:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX5UG-0003Xx-NN; Wed, 02 Jul 2025 17:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5UF-0003X7-3W
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5UC-0003jX-Fy
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:26 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562LQf1Q014606;
 Wed, 2 Jul 2025 21:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=OzALD2fsFEdS/IShgruUdRHOQtTLvq07jI1ADEkvc28=; b=
 k9F+dhzPOf4UxyISbljt0AVRuDWVelZZ2qT2Ny9dd/qCPubUo9ZccUVVPDu7PaN+
 OgqrpoLuyfc7N8viS7WBcNfDkLy6a9/Vq6L0v5oIvDwqTFcSu5Sn6M7jRqLBQzlc
 fwKspTnp6Q855iQHd57dpG4Bm23H0h7w7E17KWrYQQbzvGdgMwf5Pw6aQBL16X/t
 XCPF0QTNgBgAGteKJeRtpnDzo/fmLwIkeb4T7PS2WLY4O9+JjNtv/myAxeZyubH6
 S72COAC+rdeM6wtIk03pv4unQchTca/KTVZNkPIKl2kOXzemIThlAkIpM4Q46JPq
 HIjKZwZDxfuiDs0hVTQW/w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8xx7vd1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:11 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562LTgjp033925; Wed, 2 Jul 2025 21:59:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6ubtd5r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:11 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 562LwxgO020012;
 Wed, 2 Jul 2025 21:59:10 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47j6ubtcxb-16; Wed, 02 Jul 2025 21:59:10 +0000
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
Subject: [PATCH V6 15/21] vfio/iommufd: preserve descriptors
Date: Wed,  2 Jul 2025 14:58:52 -0700
Message-Id: <1751493538-202042-16-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
References: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020182
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE4MiBTYWx0ZWRfX0zVmfrLZ8nzu
 Gtid50ST4UtXnZs/c0/wAON1jofUdVnomibLeTdIXrJQ3jtAF/iYWwt0o8Z6lSVly9+5T4ZTX+C
 LK+ccDwKbqgZY+HYAj2mUHsZcpjVgMK2Bm798t1eVsBh4j5XeC8NGdQ/nKHiVGxFRYCVD1DgiAZ
 aQNJjIsIsGYJdWLMovbfbpAYe8IK0MTiVDkwPGwuZSml5+S628friDqGQrT6KMkCZoR++85COQ7
 YvA7GJsh9a1cwgB6T/RpYkBXlVzrELEZm2hjqI66CtaAwW5wFJCa7nqKdG94P4q+q+uX98o3PJ6
 VBYViZCqrAv1xPz1nU9UOs64bf73CSpobNxbvMKAokUZ5VR/aTlRB+VS1VgpNhACjCqmCvY4t28
 Ika4MjJo2Xzh4xliIji/CXbgudCqJ7vdRYCEs0WLrIY+/vQSAfvkD8X8jHFVqt8Z1mMXhsz1
X-Proofpoint-ORIG-GUID: cJf3ORlPbjJ-GemAetf2fqjNUj02cUwK
X-Proofpoint-GUID: cJf3ORlPbjJ-GemAetf2fqjNUj02cUwK
X-Authority-Analysis: v=2.4 cv=QfRmvtbv c=1 sm=1 tr=0 ts=6865abaf cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=I2KNaNdY-GqYJbIdq80A:9
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
After CPR, the fd number is found in CPR state and reused.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 backends/iommufd.c    | 35 +++++++++++++++++++++++++++++------
 hw/vfio/cpr-iommufd.c | 10 ++++++++++
 hw/vfio/device.c      |  9 +--------
 3 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index c554ce5..e091792 100644
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
@@ -64,11 +70,27 @@ static bool iommufd_backend_can_be_deleted(UserCreatable *uc)
     return !be->users;
 }
 
+static void iommufd_backend_complete(UserCreatable *uc, Error **errp)
+{
+    IOMMUFDBackend *be = IOMMUFD_BACKEND(uc);
+    const char *name = iommufd_fd_name(be);
+
+    if (!be->owned) {
+        /* fd came from the command line. Fetch updated value from cpr state. */
+        if (cpr_is_incoming()) {
+            be->fd = cpr_find_fd(name, 0);
+        } else {
+            cpr_save_fd(name, 0, be->fd);
+        }
+    }
+}
+
 static void iommufd_backend_class_init(ObjectClass *oc, const void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
     ucc->can_be_deleted = iommufd_backend_can_be_deleted;
+    ucc->complete = iommufd_backend_complete;
 
     object_class_property_add_str(oc, "fd", NULL, iommufd_backend_set_fd);
 }
@@ -102,7 +124,7 @@ bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
     int fd;
 
     if (be->owned && !be->users) {
-        fd = qemu_open("/dev/iommu", O_RDWR, errp);
+        fd = cpr_open_fd("/dev/iommu", O_RDWR, iommufd_fd_name(be), 0, errp);
         if (fd < 0) {
             return false;
         }
@@ -127,14 +149,15 @@ void iommufd_backend_disconnect(IOMMUFDBackend *be)
         goto out;
     }
     be->users--;
-    if (!be->users && be->owned) {
-        close(be->fd);
-        be->fd = -1;
-    }
-out:
     if (!be->users) {
         vfio_iommufd_cpr_unregister_iommufd(be);
+        if (be->owned) {
+            cpr_delete_fd(iommufd_fd_name(be), 0);
+            close(be->fd);
+            be->fd = -1;
+        }
     }
+out:
     trace_iommufd_backend_disconnect(be->fd, be->users);
 }
 
diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index 4166201..a72b68d 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -166,12 +166,18 @@ void vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer *container)
 void vfio_iommufd_cpr_register_device(VFIODevice *vbasedev)
 {
     if (!cpr_is_incoming()) {
+        /*
+         * Beware fd may have already been saved by vfio_device_set_fd,
+         * so call resave to avoid a duplicate entry.
+         */
+        cpr_resave_fd(vbasedev->name, 0, vbasedev->fd);
         vfio_cpr_save_device(vbasedev);
     }
 }
 
 void vfio_iommufd_cpr_unregister_device(VFIODevice *vbasedev)
 {
+    cpr_delete_fd(vbasedev->name, 0);
     vfio_cpr_delete_device(vbasedev->name);
 }
 
@@ -180,5 +186,9 @@ void vfio_cpr_load_device(VFIODevice *vbasedev)
     if (cpr_is_incoming()) {
         bool ret = vfio_cpr_find_device(vbasedev);
         g_assert(ret);
+
+        if (vbasedev->fd < 0) {
+            vbasedev->fd = cpr_find_fd(vbasedev->name, 0);
+        }
     }
 }
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 0ae3f3c..96cf214 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -351,14 +351,7 @@ void vfio_device_free_name(VFIODevice *vbasedev)
 
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
+    vbasedev->fd = cpr_get_fd_param(vbasedev->dev->id, str, 0, errp);
 }
 
 static VFIODeviceIOOps vfio_device_io_ops_ioctl;
-- 
1.8.3.1


