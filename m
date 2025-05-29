Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21219C5B543
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKisq-0004Kt-O4; Thu, 29 May 2025 15:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisQ-0004Cl-El
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:18 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisO-0000TF-JG
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:18 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfqbN014966;
 Thu, 29 May 2025 19:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=4tqaedrg/VrAxJzlMdPUPjSt/wWoP+X6XzqmXlGAPLM=; b=
 G9QrYmGrPM0D0K89IHmLbd5b+Gh5li0rW2W2fdY7omrzEImzPxZZp39I/4o0gqAH
 oS1gDQmuCTBmOtfM7tU4cItVgO7eZKqlJMzUrnSequLW9sO7TyZNqauVvH43jtWO
 kBYIRSK+VtP6Wtpb3/Qiop/UItTT/zYZj8KKky8W5OqsmK/qMHMfZMJl+EmDStZd
 hWRufJvPDu2CxxN/sDtB+x9xxSsHzC6vy3hRKpWerYKpvfJ3ZwYCaEvJhcGFP/Fe
 94aII7tHEnLEXID2RVF5jEP7nVTQg/wmiuY+aeEtOn2zMKb260ndwOIVDQeNDep0
 0hHyBvBBnfISPj8Thqntqw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v21s8t94-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:13 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54TJOfot020338; Thu, 29 May 2025 19:25:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4w8y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:12 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeS3022158;
 Thu, 29 May 2025 19:25:12 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-39; Thu, 29 May 2025 19:25:12 +0000
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
Subject: [PATCH V4 38/43] vfio/iommufd: preserve descriptors
Date: Thu, 29 May 2025 12:24:34 -0700
Message-Id: <1748546679-154091-39-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_09,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290189
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfXzd7bMCouy5GF
 LTi3NVq3fp9GsLhMsoTtttkFqLUu3ssDPhHkAYoaaudgouY1bbSwQTh23iMn76YyjtWFYMd1adb
 ps+oib1o3cZrPWaw1XwZH9Xd5ouJO3FHXXiyi3sl5gpw5FGjBLvMWrBl8moiW3+QQdADK8WVvde
 N2cPWad78MoXqd2NcrM6Tf+0r1o3KeCVKjw5ZvA0GyNiMu+eSfJt9oFm7Y5kSFKpsi0N//k1Quq
 Q+UWlJ4s5KhZzFidRMObX+8XGyPJ3Sj7CZM7PpICR9lepC6ubgWmTv+JZOhaMkqdiO5sVnf2lsW
 S9B1rWssL1L/h2kANPHcj8VCeFoWo3YOVouHdrRaeSBvcS8M7h4KSw0vI3M1nTIxHfG2O8tpRW2
 x6YlXXNom3X9sjEoJXQVYT2cHK1ALOVFNZIKOzDx53lgWNbhu0iTOGZk0JkqvpKely7SUM0Z
X-Proofpoint-GUID: qHm8SuQ8iSEEfJhpOQRZ7T5utCAx4HRp
X-Authority-Analysis: v=2.4 cv=UvhjN/wB c=1 sm=1 tr=0 ts=6838b49a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=I2KNaNdY-GqYJbIdq80A:9
X-Proofpoint-ORIG-GUID: qHm8SuQ8iSEEfJhpOQRZ7T5utCAx4HRp
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
After CPR, the fd number is found in CPR state and reused.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 backends/iommufd.c    | 25 ++++++++++++++++++++++++-
 hw/vfio/cpr-iommufd.c | 10 ++++++++++
 hw/vfio/device.c      |  9 +--------
 3 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 2e9d6cb..98d83aa 100644
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
@@ -134,6 +156,7 @@ void iommufd_backend_disconnect(IOMMUFDBackend *be)
 out:
     if (!be->users) {
         vfio_iommufd_cpr_unregister_iommufd(be);
+        cpr_delete_fd(iommufd_fd_name(be), 0);
     }
     trace_iommufd_backend_disconnect(be->fd, be->users);
 }
diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index 2eca8a6..152a661 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -162,17 +162,27 @@ void vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer *container)
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
 
 void vfio_cpr_load_device(VFIODevice *vbasedev)
 {
+    if (vbasedev->fd < 0) {
+        vbasedev->fd = cpr_find_fd(vbasedev->name, 0);
+    }
+
     if (cpr_is_incoming()) {
         bool ret = vfio_cpr_find_device(vbasedev);
         g_assert(ret);
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 0f29063..3dd3bd9 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -335,14 +335,7 @@ void vfio_device_free_name(VFIODevice *vbasedev)
 
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


