Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59288C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKis5-000409-2Z; Thu, 29 May 2025 15:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKis2-0003yt-1O
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:24:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKirz-0000Cp-S3
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:24:53 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGg51N031585;
 Thu, 29 May 2025 19:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=z6u+p/BgfGW8RZmR2Ut99lqUaSk0ZyVt5Ta4KuYGcJE=; b=
 EAG4ZSP0pmNPy4Ghh2tPSgrjlUtZ8yepRJdHWjaObV+ckQMAI62ltYASrCvWPi8L
 r4QAlbPpd/5RUpqDorS6HhIeI6CddGo+5a0ahEFrzmImbjNwzZlzR/TSOkk3FJ6Q
 E5IMM/LUhcJ1DeXGIOwjKvw6wg3oDW6q6qPSBzDgtwSvz0iAIW7dX+alwomO1Wzr
 Mi91rEYfwKDMLVvAm6P2F7lG2sf/UjJFZmcVg3EldlrtK+r0GStRlfN+Vm7Wuv1x
 XKfRviHB0i44YksTJ8NDX1X7iZm7LvzWU+ZA3j7SZr1wDg9bJY1zDX1VrQbmMQJX
 i87747qt//X1CQ1ZLO5JAQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v33n0yc0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:49 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54THgPjr020337; Thu, 29 May 2025 19:24:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4vqc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:48 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeR5022158;
 Thu, 29 May 2025 19:24:48 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-10; Thu, 29 May 2025 19:24:48 +0000
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
Subject: [PATCH V4 09/43] vfio/container: register container for cpr
Date: Thu, 29 May 2025 12:24:05 -0700
Message-Id: <1748546679-154091-10-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfX1p0gF2c/y+GI
 /PYzUJFsFcCBBgtW6202rBfbOu1xNyEVMV108y0SXtEcvwn4no2LfKOOM474Z3CbeoYTR5AFZ+h
 aF8/+GSnDGVZUMjgrGSOFaLjGpYSpnB7IK1LhcvQTb5wcw4xT02CsaSf1fLaxnRFep+RahhDFnC
 s6CTFKL6/AoQN/WIdpK0B8xoSbrArrOGPFwQgMhlTVbda8K7iBFB+ilbEQnJCYfg96qR4beECWq
 jGIb57uhblczDXkAwDa+G0sh2VMoK2XBiX3sBMLs5bQSKb45B+qgtmxQnBGkDj2/YKtufm+7L03
 eZKfZsiT6qLYmqB6LvX2UvBG23JBS2HzufQq9cZ9GxEN1Wk2upPlUa3JYRQ/qDP9Dg3OzbAZ1dL
 ZiLtSSONfXzKTAJ8BkivW8m+l3as+E5Cl3hpOTfmPNJRhlO0HBPoQ+iAgd29gSz+8zLhNzBt
X-Proofpoint-GUID: R-AD1n_TJCs_CRx0dDnC5kuNqZZ3KcCM
X-Authority-Analysis: v=2.4 cv=aO/wqa9m c=1 sm=1 tr=0 ts=6838b481 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=AABqGAaGSB0UP_gAvAYA:9
X-Proofpoint-ORIG-GUID: R-AD1n_TJCs_CRx0dDnC5kuNqZZ3KcCM
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
 include/hw/vfio/vfio-container.h |  2 ++
 include/hw/vfio/vfio-cpr.h       | 15 +++++++++
 hw/vfio/container.c              |  6 ++--
 hw/vfio/cpr-legacy.c             | 69 ++++++++++++++++++++++++++++++++++++++++
 hw/vfio/cpr.c                    |  5 ++-
 hw/vfio/meson.build              |  1 +
 6 files changed, 92 insertions(+), 6 deletions(-)
 create mode 100644 hw/vfio/cpr-legacy.c

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
index 750ea5b..d4e0bd5 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -9,8 +9,23 @@
 #ifndef HW_VFIO_VFIO_CPR_H
 #define HW_VFIO_VFIO_CPR_H
 
+#include "migration/misc.h"
+
+struct VFIOContainer;
 struct VFIOContainerBase;
 
+typedef struct VFIOContainerCPR {
+    Error *blocker;
+} VFIOContainerCPR;
+
+
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
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 0f948d0..7d2035c 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -643,7 +643,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
     new_container = true;
     bcontainer = &container->bcontainer;
 
-    if (!vfio_cpr_register_container(bcontainer, errp)) {
+    if (!vfio_legacy_cpr_register_container(container, errp)) {
         goto fail;
     }
 
@@ -679,7 +679,7 @@ fail:
         vioc->release(bcontainer);
     }
     if (new_container) {
-        vfio_cpr_unregister_container(bcontainer);
+        vfio_legacy_cpr_unregister_container(container);
         object_unref(container);
     }
     if (fd >= 0) {
@@ -720,7 +720,7 @@ static void vfio_container_disconnect(VFIOGroup *group)
         VFIOAddressSpace *space = bcontainer->space;
 
         trace_vfio_container_disconnect(container->fd);
-        vfio_cpr_unregister_container(bcontainer);
+        vfio_legacy_cpr_unregister_container(container);
         close(container->fd);
         object_unref(container);
 
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
new file mode 100644
index 0000000..419b9fb
--- /dev/null
+++ b/hw/vfio/cpr-legacy.c
@@ -0,0 +1,69 @@
+/*
+ * Copyright (c) 2021-2025 Oracle and/or its affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
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
+    .needed = cpr_incoming_needed,
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
-- 
1.8.3.1


