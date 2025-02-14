Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92641C021A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwSt-0004Os-F4; Fri, 14 Feb 2025 09:14:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwSs-0004Nw-Ew
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:14:46 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwSq-0004S8-6W
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:14:46 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECtUnj001530;
 Fri, 14 Feb 2025 14:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=25agqrVRl+Z/STHiqShSmbHb9RkMccnzJxBqfaWd/OY=; b=
 HD/Wtuq1oIt2xMD4tEOzBM9mgnCAR72NMJLarz7xpT8/1MfwUPfZD8Vp77TWYanm
 oi7KxsUKbvDCUfo2wjbHSLA2kHeKQpjrD88TShLD3/t+UxqyCkDEFRMDmEMtI1QV
 WyeC4cycoxdF4xSvexF6AsrK5HK9GM1Cxc48WSxyAZefQjVH7pMbB/NsfEzbygO+
 Sz1OIwuxZ1DPunKD7SQL6tZWYUg2piwK1yOEtQ0MmzimU6pViwtPF4P0WxFsCtkZ
 rQPATXP0I/YojShZiNGXx1Xi00CH8oBqrJyPWprbJL5xJikb4h9ZUJqpO12t26Sy
 FSIRN4YQbrC/havgTW8Erw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0q2kruj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:14:41 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51ECxs2W025360; Fri, 14 Feb 2025 14:14:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqksg7y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:14:40 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51EEETPT006920;
 Fri, 14 Feb 2025 14:14:40 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 44nwqksg2h-9; Fri, 14 Feb 2025 14:14:39 +0000
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
Subject: [PATCH V2 08/45] vfio/container: register container for cpr
Date: Fri, 14 Feb 2025 06:13:50 -0800
Message-Id: <1739542467-226739-9-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: ML9W1fauc_XAXLYKOFeLQxL-gi3OEz2L
X-Proofpoint-ORIG-GUID: ML9W1fauc_XAXLYKOFeLQxL-gi3OEz2L
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
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

Register a legacy container for cpr-transfer, replacing the generic CPR
register call with a more specific legacy container register call.  Add a
blocker if the kernel does not support VFIO_UPDATE_VADDR or VFIO_UNMAP_ALL.

This is mostly boiler plate.  The fields to to saved and restored are added
in subsequent patches.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 MAINTAINERS                   |  1 +
 hw/vfio/container.c           |  6 ++--
 hw/vfio/cpr-legacy.c          | 69 +++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/cpr.c                 |  6 ++--
 hw/vfio/meson.build           |  3 +-
 include/hw/vfio/vfio-common.h |  2 ++
 include/hw/vfio/vfio-cpr.h    | 25 ++++++++++++++++
 7 files changed, 105 insertions(+), 7 deletions(-)
 create mode 100644 hw/vfio/cpr-legacy.c
 create mode 100644 include/hw/vfio/vfio-cpr.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 2f9a6da..aee1342 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2957,6 +2957,7 @@ M: Fabiano Rosas <farosas@suse.de>
 R: Steve Sistare <steven.sistare@oracle.com>
 S: Supported
 F: hw/vfio/cpr*
+F: include/hw/vfio/vfio-cpr.h
 F: include/migration/cpr.h
 F: migration/cpr*
 F: tests/qtest/migration/cpr*
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index c5bbb03..eca3362 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -641,7 +641,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     new_container = true;
     bcontainer = &container->bcontainer;
 
-    if (!vfio_cpr_register_container(bcontainer, errp)) {
+    if (!vfio_legacy_cpr_register_container(container, errp)) {
         goto fail;
     }
 
@@ -682,7 +682,7 @@ fail:
         vioc->release(bcontainer);
     }
     if (new_container) {
-        vfio_cpr_unregister_container(bcontainer);
+        vfio_legacy_cpr_unregister_container(container);
         object_unref(container);
     }
     if (fd >= 0) {
@@ -722,7 +722,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
         VFIOAddressSpace *space = bcontainer->space;
 
         trace_vfio_disconnect_container(container->fd);
-        vfio_cpr_unregister_container(bcontainer);
+        vfio_legacy_cpr_unregister_container(container);
         close(container->fd);
         object_unref(container);
 
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
new file mode 100644
index 0000000..d0557af
--- /dev/null
+++ b/hw/vfio/cpr-legacy.c
@@ -0,0 +1,69 @@
+/*
+ * Copyright (c) 2021-2025 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include <sys/ioctl.h>
+#include "qemu/osdep.h"
+#include "hw/vfio/vfio-common.h"
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
index 3d1c8d2..6790f8a 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -7,12 +7,12 @@
 
 #include "qemu/osdep.h"
 #include "hw/vfio/vfio-common.h"
-#include "migration/misc.h"
+#include "hw/vfio/vfio-cpr.h"
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
index bba776f..5487815 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -5,13 +5,14 @@ vfio_ss.add(files(
   'container-base.c',
   'container.c',
   'migration.c',
-  'cpr.c',
 ))
 vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
 vfio_ss.add(when: 'CONFIG_IOMMUFD', if_true: files(
   'iommufd.c',
 ))
 vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
+  'cpr.c',
+  'cpr-legacy.c',
   'display.c',
   'pci-quirks.c',
   'pci.c',
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index d601eea..c482364 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -31,6 +31,7 @@
 #endif
 #include "system/system.h"
 #include "hw/vfio/vfio-container-base.h"
+#include "hw/vfio/vfio-cpr.h"
 #include "system/host_iommu_device.h"
 #include "system/iommufd.h"
 
@@ -85,6 +86,7 @@ typedef struct VFIOContainer {
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
     unsigned iommu_type;
     QLIST_HEAD(, VFIOGroup) group_list;
+    VFIOContainerCPR cpr;
 } VFIOContainer;
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOContainer, VFIO_IOMMU_LEGACY);
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
new file mode 100644
index 0000000..d4f8346
--- /dev/null
+++ b/include/hw/vfio/vfio-cpr.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (c) 2025 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_VFIO_VFIO_CPR_H
+#define HW_VFIO_VFIO_CPR_H
+
+#include "migration/misc.h"
+
+typedef struct VFIOContainerCPR {
+    Error *blocker;
+} VFIOContainerCPR;
+
+struct VFIOContainer;
+
+int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
+                             Error **errp);
+
+bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
+                                        Error **errp);
+void vfio_legacy_cpr_unregister_container(struct VFIOContainer *container);
+#endif
-- 
1.8.3.1


