Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E298C3ABD9
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEV9U-0003wT-0g; Mon, 12 May 2025 11:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9O-0003k8-1I
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:06 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9L-0006eQ-8H
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:05 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9jOt018660;
 Mon, 12 May 2025 15:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=VDrOZmpXtHMyp8bH9l2olMxhP3gdnmlPtCcHIsthUxo=; b=
 Ws5TCFhlGfH+3peI2bnYsj8tlH0parPw6bPKhfPhQiBBhrEyeTHLbn6TB7smVzdC
 cj4001FRSwL2LNtLChvyOc0kWHI4OWqvXDabIUkjhezKyY+4nUehHSdnC9sme8dK
 GhkLiSgw9ys1PON3a04fJu9qgXJg1gQZw/k0VjB8yGATNXm0W1ijvsdkTPRU2wCV
 49o/fN9XV36473dCUbYsbKNN89lG/k9Wy2RhMrvANoIomeReqBePQSvZcDzQ7hNG
 ZVWuhK9RM9HWVNRTgYi0R0U/ENFwwLMAq35FvYg8LAQD0FbvKF00B8GYt5wxoRQ7
 1QhoQWbBy4DuU++5q7Bw/g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j13r2sd2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:00 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CE7HT3002521; Mon, 12 May 2025 15:32:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx3666g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:32:59 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk4o030605;
 Mon, 12 May 2025 15:32:59 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-7; Mon, 12 May 2025 15:32:59 +0000
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
Subject: [PATCH V3 06/42] vfio/container: register container for cpr
Date: Mon, 12 May 2025 08:32:17 -0700
Message-Id: <1747063973-124548-7-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfX2FATGxsChh9K
 lnh4f2iOpqIQbQY5Ai/ZKqgBs+zvC2U/jI3nz4aBoonxRCuIAugccLvFzIblSmpBl4XDeOGOEyf
 JexgrvU3xUfHyO7wCwTy1vNFCXIM/+U22zrRLq1L555AHnDlP1sb8GWA0IRiuLlY2doHi6lGi9V
 Uwsod3V6AsTmqxXrTnAqUwma8XLaT0RyF1cFQh6K3MjQQ+MOlhdbtlDPWFSJfbqd9pFEgBCo9iE
 aKG708MOpcY0exm0yHbikuk2iHksL1iWpYJ3Sm8/0k3Xn+gty+50JYIkhLjreIRFwk6H0EpIJG5
 CEHS2tOm3kky8J0/7t9onoJNc3nzcHS18lPhtIB0xijUeAO1ec2yVpanw6yPRoV/683t+3YO4kN
 LXoRHYBRNJWd4vqM+Jf+T0W1gIreooCIzuN8yHibbgx9fHDHj4gYT2HujdxhE0Mfm0UIGZ4w
X-Proofpoint-GUID: k85TAGavVri-D8FWjR3LoH5_s3qgFQ32
X-Proofpoint-ORIG-GUID: k85TAGavVri-D8FWjR3LoH5_s3qgFQ32
X-Authority-Analysis: v=2.4 cv=M6hNKzws c=1 sm=1 tr=0 ts=682214ac b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=Wa8AqhRQI3GCQIrSjY4A:9
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Register a legacy container for cpr-transfer, replacing the generic CPR
register call with a more specific legacy container register call.  Add a
blocker if the kernel does not support VFIO_UPDATE_VADDR or VFIO_UNMAP_ALL.

This is mostly boiler plate.  The fields to to saved and restored are added
in subsequent patches.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/container.c              |  6 ++--
 hw/vfio/cpr-legacy.c             | 70 ++++++++++++++++++++++++++++++++++++++++
 hw/vfio/cpr.c                    |  5 ++-
 hw/vfio/meson.build              |  1 +
 include/hw/vfio/vfio-container.h |  2 ++
 include/hw/vfio/vfio-cpr.h       | 14 ++++++++
 6 files changed, 92 insertions(+), 6 deletions(-)
 create mode 100644 hw/vfio/cpr-legacy.c

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index eb56f00..85c76da 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -642,7 +642,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
     new_container = true;
     bcontainer = &container->bcontainer;
 
-    if (!vfio_cpr_register_container(bcontainer, errp)) {
+    if (!vfio_legacy_cpr_register_container(container, errp)) {
         goto fail;
     }
 
@@ -678,7 +678,7 @@ fail:
         vioc->release(bcontainer);
     }
     if (new_container) {
-        vfio_cpr_unregister_container(bcontainer);
+        vfio_legacy_cpr_unregister_container(container);
         object_unref(container);
     }
     if (fd >= 0) {
@@ -719,7 +719,7 @@ static void vfio_container_disconnect(VFIOGroup *group)
         VFIOAddressSpace *space = bcontainer->space;
 
         trace_vfio_container_disconnect(container->fd);
-        vfio_cpr_unregister_container(bcontainer);
+        vfio_legacy_cpr_unregister_container(container);
         close(container->fd);
         object_unref(container);
 
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
new file mode 100644
index 0000000..fac323c
--- /dev/null
+++ b/hw/vfio/cpr-legacy.c
@@ -0,0 +1,70 @@
+/*
+ * Copyright (c) 2021-2025 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include <sys/ioctl.h>
+#include <linux/vfio.h>
+#include "qemu/osdep.h"
+#include "hw/vfio/vfio-container.h"
+#include "hw/vfio/vfio-cpr.h"
+#include "migration/blocker.h"
+#include "migration/cpr.h"
+#include "migration/migration.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+
+static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
+{
+    if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UPDATE_VADDR)) {
+        error_setg(errp, "VFIO container does not support VFIO_UPDATE_VADDR");
+        return false;
+
+    } else if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UNMAP_ALL)) {
+        error_setg(errp, "VFIO container does not support VFIO_UNMAP_ALL");
+        return false;
+
+    } else {
+        return true;
+    }
+}
+
+static const VMStateDescription vfio_container_vmstate = {
+    .name = "vfio-container",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .needed = cpr_needed_for_reuse,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
+{
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+    Error **cpr_blocker = &container->cpr.blocker;
+
+    migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
+                                vfio_cpr_reboot_notifier,
+                                MIG_MODE_CPR_REBOOT);
+
+    if (!vfio_cpr_supported(container, cpr_blocker)) {
+        return migrate_add_blocker_modes(cpr_blocker, errp,
+                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
+    }
+
+    vmstate_register(NULL, -1, &vfio_container_vmstate, container);
+
+    return true;
+}
+
+void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
+{
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+
+    migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
+    migrate_del_blocker(&container->cpr.blocker);
+    vmstate_unregister(NULL, &vfio_container_vmstate, container);
+}
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index 0210e76..0e59612 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -7,13 +7,12 @@
 
 #include "qemu/osdep.h"
 #include "hw/vfio/vfio-device.h"
-#include "migration/misc.h"
 #include "hw/vfio/vfio-cpr.h"
 #include "qapi/error.h"
 #include "system/runstate.h"
 
-static int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
-                                    MigrationEvent *e, Error **errp)
+int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
+                             MigrationEvent *e, Error **errp)
 {
     if (e->type == MIG_EVENT_PRECOPY_SETUP &&
         !runstate_check(RUN_STATE_SUSPENDED) && !vm_get_suspended()) {
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index bccb050..73d29f9 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -21,6 +21,7 @@ system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
 system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
 system_ss.add(when: 'CONFIG_VFIO', if_true: files(
   'cpr.c',
+  'cpr-legacy.c',
   'device.c',
   'migration.c',
   'migration-multifd.c',
diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
index afc498d..21e5807 100644
--- a/include/hw/vfio/vfio-container.h
+++ b/include/hw/vfio/vfio-container.h
@@ -10,6 +10,7 @@
 #define HW_VFIO_CONTAINER_H
 
 #include "hw/vfio/vfio-container-base.h"
+#include "hw/vfio/vfio-cpr.h"
 
 typedef struct VFIOContainer VFIOContainer;
 typedef struct VFIODevice VFIODevice;
@@ -29,6 +30,7 @@ typedef struct VFIOContainer {
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
     unsigned iommu_type;
     QLIST_HEAD(, VFIOGroup) group_list;
+    VFIOContainerCPR cpr;
 } VFIOContainer;
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOContainer, VFIO_IOMMU_LEGACY);
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 750ea5b..f864547 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -9,8 +9,22 @@
 #ifndef HW_VFIO_VFIO_CPR_H
 #define HW_VFIO_VFIO_CPR_H
 
+#include "migration/misc.h"
+
+typedef struct VFIOContainerCPR {
+    Error *blocker;
+} VFIOContainerCPR;
+
+struct VFIOContainer;
 struct VFIOContainerBase;
 
+bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
+                                        Error **errp);
+void vfio_legacy_cpr_unregister_container(struct VFIOContainer *container);
+
+int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
+                             Error **errp);
+
 bool vfio_cpr_register_container(struct VFIOContainerBase *bcontainer,
                                  Error **errp);
 void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
-- 
1.8.3.1


