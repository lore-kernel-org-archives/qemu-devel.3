Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D4EC021A6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwV2-0001U9-7w; Fri, 14 Feb 2025 09:17:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwTp-0006PD-HY
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:15:47 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwTg-0004jl-68
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:15:40 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECuZE9002760;
 Fri, 14 Feb 2025 14:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=i068UHPtSe3Srh6HjpHZBZMHQ6vg8Ckh26gSYkmd/uQ=; b=
 n4+mp8GTBeozGtmYfRMwJvVDdEpdBhopaRsooevpSdRwqUvyebzIAAgSdmWMs60Q
 E/ltuLQd11nJJ7fyB0pdiaslVFQ4TBGZPuoR++K7QsgWF0gLS8rdVH+WDhcyDiCf
 fMXqusnwhrRdH+vn5uj1bwEyDv8Tva74R5H7+J0PHYgqTgE0NX4tKL6Tga3Ww2Da
 4Ob39CgBq1qwkwmhmygYl3SV9eonGj31gCDAl8hHQsU2R/xaUYMdE5bQwL906Aan
 5zQtnuYMZRtWeRH8RTzeLF/A8j1+1n5WIsgTzSUG3Ct+KzFd8pVhi+5NfCddpW/2
 BkkjEuTB3togy92umuuCmQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0q2krvj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:15:22 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51EC5VhD025186; Fri, 14 Feb 2025 14:15:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqksh60-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:15:21 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51EEETQT006920;
 Fri, 14 Feb 2025 14:15:20 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 44nwqksg2h-39; Fri, 14 Feb 2025 14:15:20 +0000
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
Subject: [PATCH V2 38/45] vfio/iommufd: register container for cpr
Date: Fri, 14 Feb 2025 06:14:20 -0800
Message-Id: <1739542467-226739-39-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: MWIoH5jvwtNehtuc9S65sro3hK7aBoDG
X-Proofpoint-ORIG-GUID: MWIoH5jvwtNehtuc9S65sro3hK7aBoDG
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

Register a vfio iommufd container and device for CPR, replacing the generic
CPR register call with a more specific iommufd register call.  Add a
blocker if the kernel does not support IOMMU_IOAS_CHANGE_PROCESS.

This is mostly boiler plate.  The fields to to saved and restored are added
in subsequent patches.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/cpr-iommufd.c         | 97 +++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/iommufd.c             |  8 ++--
 hw/vfio/meson.build           |  1 +
 include/hw/vfio/vfio-common.h |  1 +
 include/hw/vfio/vfio-cpr.h    |  8 ++++
 5 files changed, 112 insertions(+), 3 deletions(-)
 create mode 100644 hw/vfio/cpr-iommufd.c

diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
new file mode 100644
index 0000000..9fd0c82
--- /dev/null
+++ b/hw/vfio/cpr-iommufd.c
@@ -0,0 +1,97 @@
+/*
+ * Copyright (c) 2024-2025 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-cpr.h"
+#include "migration/blocker.h"
+#include "migration/cpr.h"
+#include "migration/migration.h"
+#include "migration/vmstate.h"
+#include "system/iommufd.h"
+
+static bool vfio_cpr_supported(VFIOIOMMUFDContainer *container, Error **errp)
+{
+    if (!iommufd_change_process_capable(container->be)) {
+        error_setg(errp,
+                   "VFIO container does not support IOMMU_IOAS_CHANGE_PROCESS");
+        return false;
+    }
+    return true;
+}
+
+static const VMStateDescription vfio_container_vmstate = {
+    .name = "vfio-iommufd-container",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .needed = cpr_needed_for_reuse,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription iommufd_cpr_vmstate = {
+    .name = "iommufd",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .needed = cpr_needed_for_reuse,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+bool vfio_iommufd_cpr_register_container(VFIOIOMMUFDContainer *container,
+                                         Error **errp)
+{
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+    Error **cpr_blocker = &container->cpr_blocker;
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
+    vmstate_register(NULL, -1, &iommufd_cpr_vmstate, container->be);
+
+    return true;
+}
+
+void vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer *container)
+{
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+
+    vmstate_unregister(NULL, &iommufd_cpr_vmstate, container->be);
+    vmstate_unregister(NULL, &vfio_container_vmstate, container);
+    migrate_del_blocker(&container->cpr_blocker);
+    migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
+}
+
+static const VMStateDescription vfio_device_vmstate = {
+    .name = "vfio-iommufd-device",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .needed = cpr_needed_for_reuse,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+void vfio_iommufd_cpr_register_device(VFIODevice *vbasedev)
+{
+    vmstate_register(NULL, -1, &vfio_device_vmstate, vbasedev);
+}
+
+void vfio_iommufd_cpr_unregister_device(VFIODevice *vbasedev)
+{
+    vmstate_unregister(NULL, &vfio_device_vmstate, vbasedev);
+}
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 87c3bc2c..ddb3d23 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -596,7 +596,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
 
     bcontainer->initialized = true;
 
-    if (!vfio_cpr_register_container(bcontainer, errp)) {
+    if (!vfio_iommufd_cpr_register_container(container, errp)) {
         goto err_listener_register;
     }
 
@@ -623,13 +623,14 @@ found_container:
     vbasedev->bcontainer = bcontainer;
     QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
     QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
+    vfio_iommufd_cpr_register_device(vbasedev);
 
     trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
                                    vbasedev->num_regions, vbasedev->flags);
     return true;
 
 err_listener_register:
-    vfio_cpr_unregister_container(bcontainer);
+    vfio_iommufd_cpr_unregister_container(container);
     iommufd_cdev_ram_block_discard_disable(false);
 err_discard_disable:
     iommufd_cdev_detach_container(vbasedev, container);
@@ -658,12 +659,13 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
         iommufd_cdev_ram_block_discard_disable(false);
     }
 
-    vfio_cpr_unregister_container(bcontainer);
+    vfio_iommufd_cpr_unregister_container(container);
     iommufd_cdev_detach_container(vbasedev, container);
     iommufd_cdev_container_destroy(container);
     vfio_put_address_space(space);
 
     migrate_del_blocker(&vbasedev->cpr.id_blocker);
+    vfio_iommufd_cpr_unregister_device(vbasedev);
     iommufd_cdev_unbind_and_disconnect(vbasedev);
     close(vbasedev->fd);
 }
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 5487815..998adb5 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -13,6 +13,7 @@ vfio_ss.add(when: 'CONFIG_IOMMUFD', if_true: files(
 vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'cpr.c',
   'cpr-legacy.c',
+  'cpr-iommufd.c',
   'display.c',
   'pci-quirks.c',
   'pci.c',
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 9ca40d0..6701393 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -110,6 +110,7 @@ typedef struct VFIOIOASHwpt {
 typedef struct VFIOIOMMUFDContainer {
     VFIOContainerBase bcontainer;
     IOMMUFDBackend *be;
+    Error *cpr_blocker;
     uint32_t ioas_id;
     QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
 } VFIOIOMMUFDContainer;
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 8a30d30..fa4b928 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -30,6 +30,7 @@ struct VFIOGroup;
 struct VFIOContainerBase;
 struct VFIOPCIDevice;
 struct VFIODevice;
+struct VFIOIOMMUFDContainer;
 
 int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
                              Error **errp);
@@ -38,6 +39,13 @@ bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
                                         Error **errp);
 void vfio_legacy_cpr_unregister_container(struct VFIOContainer *container);
 
+bool vfio_iommufd_cpr_register_container(struct VFIOIOMMUFDContainer *container,
+                                         Error **errp);
+void vfio_iommufd_cpr_unregister_container(
+    struct VFIOIOMMUFDContainer *container);
+void vfio_iommufd_cpr_register_device(struct VFIODevice *vbasedev);
+void vfio_iommufd_cpr_unregister_device(struct VFIODevice *vbasedev);
+
 bool vfio_cpr_container_match(struct VFIOContainer *container,
                               struct VFIOGroup *group, int *fd);
 
-- 
1.8.3.1


