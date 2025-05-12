Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CA6C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEVA5-0005Th-Ro; Mon, 12 May 2025 11:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9j-0004Zt-KJ
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9g-0006jV-Oh
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:27 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9fFR026123;
 Mon, 12 May 2025 15:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=FIV79X8gtIh/ebYK0VhtGeS2eGvJTIkh+fZTNlU7s3c=; b=
 eTNR4PQKlPMFJFl3d3lLFiKa+crt9vljXV+YFsJi/ijz5wwY4j0nG5UWOTwhHCbM
 6yhUiaEo0Sk6rfsm80rUJheIHg0WEJoHH0kkGLitqYExSnbRxOAmtXIBix0sPOZN
 7IVB4jF1or/4hkv3n4OZoVI8pVBeaZx3VTQpx61cYnQDqiqRbcbpg9LDnUi/6Hqe
 qU2BNhHdhyzgrAj5Se/yZkWbLpssvsc85SaDGwzTpJw5g56upAd8C/narrU0tcuR
 OZNXTPHFTPnW3UR4m7VCt9viGfQ/lft676j8FRYZ1Stb2bmGEwsB20Hd9RTXuZB2
 N2UeHQVqM8QbgYSzj+d2BA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j11c2rbd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:21 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CE0xHv002520; Mon, 12 May 2025 15:33:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx366sh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:20 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk5k030605;
 Mon, 12 May 2025 15:33:20 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-35; Mon, 12 May 2025 15:33:19 +0000
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
Subject: [PATCH V3 34/42] vfio/iommufd: invariant device name
Date: Mon, 12 May 2025 08:32:45 -0700
Message-Id: <1747063973-124548-35-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfXwC9yPn0ZZrQ5
 PEzlDFpRTXwwBgGY3+8wfB/k8s5CB2bvNaZGgXDPmN1gFepVq4dwhd4ztwMmaaP46EO7G5UNHZS
 LgaqdtRRsOKXYI6/PRZw8nJel+fA2MXlSl63WJn2vLQN8KSKPuRalkuBH2Mn2zCwDfBaxRVwODP
 l8saI5FyVqsJjspFKqmhgaoDLmrcGjRS6K6/I5OqCtRf2Pflf0znMnIm9aWylHb65hno+FHsRXB
 Xikda+ezPR9L9Y3eJnFhKDY0Ut4BcYaJ2kXxNiU34bvEdPQlCSdP7k7qqIWq7LBrEUyurowGqIB
 sMGaGCXJ0CNca4UW+Bn3mi7W+r71IE/ltUgSsfiZhulE50Dk/9LlTJeqBm38SSoQEi0+vIHEgG0
 v50McJrwSYOZmVpdPtSIXWBMgDwNOhue4QRVGp9h9NJ1IOAlSk88VBuSsSOUX+CU4IGC9xbB
X-Authority-Analysis: v=2.4 cv=YJ2fyQGx c=1 sm=1 tr=0 ts=682214c1 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=jW3JSsOLmrHkCanS8uoA:9
X-Proofpoint-GUID: YFz_CnLePWHz-yRBnI0LgKZMGjYb1_kU
X-Proofpoint-ORIG-GUID: YFz_CnLePWHz-yRBnI0LgKZMGjYb1_kU
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

cpr-transfer will use the device name as a key to find the value
of the device descriptor in new QEMU.  However, if the descriptor
number is specified by a command-line fd parameter, then
vfio_device_get_name creates a name that includes the fd number.
This causes a chicken-and-egg problem: new QEMU must know the fd
number to construct a name to find the fd number.

To fix, create an invariant name based on the id command-line
parameter.  If id is not defined, add a CPR blocker.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/cpr.c              | 21 +++++++++++++++++++++
 hw/vfio/device.c           | 10 ++++------
 hw/vfio/iommufd.c          |  2 ++
 include/hw/vfio/vfio-cpr.h |  4 ++++
 4 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index 6081a89..7609c62 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -11,6 +11,7 @@
 #include "hw/vfio/pci.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/msi.h"
+#include "migration/blocker.h"
 #include "migration/cpr.h"
 #include "qapi/error.h"
 #include "system/runstate.h"
@@ -184,3 +185,23 @@ const VMStateDescription vfio_cpr_pci_vmstate = {
         VMSTATE_END_OF_LIST()
     }
 };
+
+bool vfio_cpr_set_device_name(VFIODevice *vbasedev, Error **errp)
+{
+    if (vbasedev->dev->id) {
+        vbasedev->name = g_strdup(vbasedev->dev->id);
+        return true;
+    } else {
+        /*
+         * Assign a name so any function printing it will not break, but the
+         * fd number changes across processes, so this cannot be used as an
+         * invariant name for CPR.
+         */
+        vbasedev->name = g_strdup_printf("VFIO_FD%d", vbasedev->fd);
+        error_setg(&vbasedev->cpr.id_blocker,
+                   "vfio device with fd=%d needs an id property",
+                   vbasedev->fd);
+        return migrate_add_blocker_modes(&vbasedev->cpr.id_blocker, errp,
+                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
+    }
+}
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 9fba2c7..8e9de68 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -28,6 +28,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
+#include "migration/cpr.h"
 #include "monitor/monitor.h"
 #include "vfio-helpers.h"
 
@@ -284,6 +285,7 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
 {
     ERRP_GUARD();
     struct stat st;
+    bool ret = true;
 
     if (vbasedev->fd < 0) {
         if (stat(vbasedev->sysfsdev, &st) < 0) {
@@ -300,16 +302,12 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
             error_setg(errp, "Use FD passing only with iommufd backend");
             return false;
         }
-        /*
-         * Give a name with fd so any function printing out vbasedev->name
-         * will not break.
-         */
         if (!vbasedev->name) {
-            vbasedev->name = g_strdup_printf("VFIO_FD%d", vbasedev->fd);
+            ret = vfio_cpr_set_device_name(vbasedev, errp);
         }
     }
 
-    return true;
+    return ret;
 }
 
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 8661947..ea99b8d 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -25,6 +25,7 @@
 #include "system/reset.h"
 #include "qemu/cutils.h"
 #include "qemu/chardev_open.h"
+#include "migration/blocker.h"
 #include "pci.h"
 #include "vfio-iommufd.h"
 #include "vfio-helpers.h"
@@ -669,6 +670,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
     iommufd_cdev_container_destroy(container);
     vfio_address_space_put(space);
 
+    migrate_del_blocker(&vbasedev->cpr.id_blocker);
     iommufd_cdev_unbind_and_disconnect(vbasedev);
     close(vbasedev->fd);
 }
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 765e334..d06d117 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -23,12 +23,14 @@ typedef struct VFIOContainerCPR {
 typedef struct VFIODeviceCPR {
     bool reused;
     Error *mdev_blocker;
+    Error *id_blocker;
 } VFIODeviceCPR;
 
 struct VFIOContainer;
 struct VFIOContainerBase;
 struct VFIOGroup;
 struct VFIOPCIDevice;
+struct VFIODevice;
 
 bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
                                         Error **errp);
@@ -59,4 +61,6 @@ void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
 
 extern const VMStateDescription vfio_cpr_pci_vmstate;
 
+bool vfio_cpr_set_device_name(struct VFIODevice *vbasedev, Error **errp);
+
 #endif /* HW_VFIO_VFIO_CPR_H */
-- 
1.8.3.1


