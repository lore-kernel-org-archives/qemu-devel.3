Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F7DC5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 17:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP27y-0003f7-1D; Tue, 10 Jun 2025 12:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15y-0004bl-UD
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:41:03 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15v-0006FS-6X
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:41:01 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXbKw030408;
 Tue, 10 Jun 2025 15:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=2Q+lus6ZQOkU1qFt3aRUPnGZy4Qw4GAoZXuObms1bJ4=; b=
 buw1DBtAW2HXO5RH9qYDGoRtS7o/WcUJ1b6UvTpG89OpaCCXL5WZbxyLzpNBxLbS
 X7vHWpQwFHmqs4lVQBvBeTmcrcyEnipT+fl0JjetsHL2lwO1iSzX0Ou9QL1NfPKf
 uFqHrK9WqrEjUROWOP2iImI9gwoWZwYZnc+z9d2Wl9RmhpKinJdXQaNr+a0GTnlQ
 29JVfLTE8+cVuhDXI1aKLM7odvuKaUfKpse9OPHjbWOlNP1g1JkYu4S15mbwsGdT
 BoX2obuJ4q/wnwBnTOGpqW4059frCoGyreTrOp6CGeoY1nDpgCwbGyrDVT9QoBfM
 z0Obz/AoHwgIRvCClt344g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c14cgxc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:45 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AF52CT003304; Tue, 10 Jun 2025 15:40:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv8wbxu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:44 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AFdrgB028825;
 Tue, 10 Jun 2025 15:40:43 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 474bv8wak1-33; Tue, 10 Jun 2025 15:40:43 +0000
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
Subject: [PATCH V5 32/38] vfio/iommufd: preserve descriptors
Date: Tue, 10 Jun 2025 08:39:45 -0700
Message-Id: <1749569991-25171-33-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100125
X-Proofpoint-GUID: KBEesrKLH791ltuhS3QUJnSeMPKHIX2u
X-Authority-Analysis: v=2.4 cv=GcEXnRXL c=1 sm=1 tr=0 ts=684851fd b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=I2KNaNdY-GqYJbIdq80A:9 cc=ntf
 awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyNiBTYWx0ZWRfX6ujhrmsrb/uE
 syVB8m4Xmx4VUduEqeirvO3zg3tSIt+i8Q7Lo+sV+wsQVxT72oKihink/smAfT84KyN/SKd5zAY
 YJCISKuNUSGuf8xtQSwRbgTOw696aFw/UIO8ZigIG+EVDyqPksSJhOc4Jt6Fjxj9/1PYjjk4IeH
 VoHuFM72dXjCMJXCd3mVt5Ppwa1W4e4KLjbTnXwKq4R9y6ZpNK4R5XgzKE8q16TewG5e5JK8PUf
 RcLTmi9j/Z276dbS0VMMDwqUhNUYpSFSmhUqMkA1LoNUAFNOqzKqeg9jmQn4oa4Oq8iBnsl2nQM
 jtglJXgmUP4Iorz773nGKrUifQXkp5fNsux6IJi8nr/tFam7iCN2/xTE8A1VeCKbKBRktzql07x
 kc/UBuiQh6h38q5tsz1XND3+Ux3ltUpYH9xDMQmLyyWASIuLMED3Ql1/nwRR0giOQYsxfBfk
X-Proofpoint-ORIG-GUID: KBEesrKLH791ltuhS3QUJnSeMPKHIX2u
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
After CPR, the fd number is found in CPR state and reused.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 backends/iommufd.c    | 25 ++++++++++++++++++++++++-
 hw/vfio/cpr-iommufd.c | 10 ++++++++++
 hw/vfio/device.c      |  9 +--------
 3 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index c554ce5..e02f06e 100644
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
index 8c3835b..6bcc65c 100644
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


