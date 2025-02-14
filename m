Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA851C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwUt-0000mj-6a; Fri, 14 Feb 2025 09:16:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwTp-0006P8-Hd
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:15:47 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwTc-0004jI-Dh
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:15:38 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECtRtR011440;
 Fri, 14 Feb 2025 14:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=+P4swyqEuKwf82Z7npEcCzUwXba/Uv9ke6CHl/B23lU=; b=
 OzmzLs34kEN9XB67C9q/0f4Bne8WYk/dnxRJJZltSD+dKWaHm/zIjoQx0jQq265c
 NVjFlxgEOJQWY3Jwu5wgTnx27rfb7JX5rDqVbtgEGI/zPfCxHFcrfwn4hIpwfyBl
 GCjvqG9uPXPOzWewkn/8AZNq27MzZnvNquO2LOEQxCR273KcQqLO5/DPsdLLezb/
 sBtYFQAJx1UaTPd41/VdO5dt6+bONEbrTVmFhcpf/S3Uh0miIkQ/YWuLo4SU0DL1
 hrnyEZ81JVhrk5W408p9twWtGrUqXBEtKfWQYRLT3/c+Abt0dUMFmi4xVyApIrM7
 CIV9Ugt4gYWSH+JJDcw7aA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0sqbwns-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:15:19 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51ECIvBo025325; Fri, 14 Feb 2025 14:15:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqksh2y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:15:18 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51EEETQP006920;
 Fri, 14 Feb 2025 14:15:17 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 44nwqksg2h-37; Fri, 14 Feb 2025 14:15:17 +0000
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
Subject: [PATCH V2 36/45] vfio/iommufd: invariant device name
Date: Fri, 14 Feb 2025 06:14:18 -0800
Message-Id: <1739542467-226739-37-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: eBzRyyiEyc6R0yDlcg1rsRrW81wLNpPB
X-Proofpoint-GUID: eBzRyyiEyc6R0yDlcg1rsRrW81wLNpPB
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
 hw/vfio/helpers.c          | 10 ++++------
 hw/vfio/iommufd.c          |  2 ++
 include/hw/vfio/vfio-cpr.h |  4 ++++
 4 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index a2400ca..e3ea2bf 100644
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
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 4b255d4..4ff794c 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -29,6 +29,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
+#include "migration/cpr.h"
 #include "monitor/monitor.h"
 
 /*
@@ -637,6 +638,7 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
 {
     ERRP_GUARD();
     struct stat st;
+    bool ret = true;
 
     if (vbasedev->fd < 0) {
         if (stat(vbasedev->sysfsdev, &st) < 0) {
@@ -653,16 +655,12 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
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
index 7c0cdd7..2de2811 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -24,6 +24,7 @@
 #include "system/reset.h"
 #include "qemu/cutils.h"
 #include "qemu/chardev_open.h"
+#include "migration/blocker.h"
 #include "pci.h"
 #include "exec/ram_addr.h"
 
@@ -661,6 +662,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
     iommufd_cdev_container_destroy(container);
     vfio_put_address_space(space);
 
+    migrate_del_blocker(&vbasedev->cpr.id_blocker);
     iommufd_cdev_unbind_and_disconnect(vbasedev);
     close(vbasedev->fd);
 }
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index a9f2fbe..8a30d30 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -22,12 +22,14 @@ typedef struct VFIOContainerCPR {
 typedef struct VFIODeviceCPR {
     bool reused;
     Error *mdev_blocker;
+    Error *id_blocker;
 } VFIODeviceCPR;
 
 struct VFIOContainer;
 struct VFIOGroup;
 struct VFIOContainerBase;
 struct VFIOPCIDevice;
+struct VFIODevice;
 
 int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
                              Error **errp);
@@ -53,4 +55,6 @@ void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
                                int nr);
 
 extern const VMStateDescription vfio_cpr_pci_vmstate;
+
+bool vfio_cpr_set_device_name(struct VFIODevice *vbasedev, Error **errp);
 #endif
-- 
1.8.3.1


