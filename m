Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177A8C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 14:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td9Ic-0000fD-SF; Wed, 29 Jan 2025 09:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1td9Ib-0000ek-8P
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:44:13 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1td9IZ-0001OG-Df
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:44:13 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TEbAZr007524;
 Wed, 29 Jan 2025 14:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=WKa651mN2NNSEZD+2QEoBB8PQPBvkMwFFWRK+gIEq6o=; b=
 KJVxYKKqYGgCaImdDaAdyca/s2M7t6mTR2ew9ecHKUUv8NtETRKw8G89RaxyPQAs
 F+dKkya8EpzRxIyYtcDuenz1VO1WtEJDmNifMtEpyWkeMQTHiRYMDkp1v3i27oPh
 r8MIO51XKhlD9Mw/2zc4lr6lGI/B+s5J+JlsQQxuhnp7WjzY3nL7ZXL1XCAC20zC
 Vej8MvRs0oNTe0A5oxi/C/xkRjaPeoAWF0BnME/aLvMRJYjZpMbcr3giNHWm6UuR
 kQu69ta6v+tK3Ro0zSOEysu5SV7QDm1D4CDvk/4XIiKY7dpbQk0SlKWDbxR9ZvtI
 aKW2Hb/rGjHHyUYYn8hXuQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fp8e00rh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 14:43:58 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50TDo8GP034292; Wed, 29 Jan 2025 14:43:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44cpd9s4uw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 14:43:57 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50TEhf90003307;
 Wed, 29 Jan 2025 14:43:57 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 44cpd9s49q-24; Wed, 29 Jan 2025 14:43:57 +0000
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
Subject: [PATCH V1 23/26] vfio/iommufd: register container for cpr
Date: Wed, 29 Jan 2025 06:43:19 -0800
Message-Id: <1738161802-172631-24-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290119
X-Proofpoint-ORIG-GUID: IeCykdG45YSBN_lQYD9j--_93Qc4u0jA
X-Proofpoint-GUID: IeCykdG45YSBN_lQYD9j--_93Qc4u0jA
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.498,
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

Register a vfio iommufd container for CPR.  Add a blocker if the kernel does
not support IOMMU_IOAS_CHANGE_PROCESS.

This is mostly boiler plate.  The fields to to saved and restored are added
in subsequent patches.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/cpr-iommufd.c         | 96 +++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/iommufd.c             | 12 +++---
 hw/vfio/meson.build           |  1 +
 include/hw/vfio/vfio-common.h |  6 +++
 4 files changed, 110 insertions(+), 5 deletions(-)
 create mode 100644 hw/vfio/cpr-iommufd.c

diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
new file mode 100644
index 0000000..4eb358a
--- /dev/null
+++ b/hw/vfio/cpr-iommufd.c
@@ -0,0 +1,96 @@
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
+    if (!vfio_cpr_register_container(bcontainer, errp)) {
+        return false;
+    }
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
+    vfio_cpr_unregister_container(bcontainer);
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
index 8308715..ae78e00 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -592,6 +592,10 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
 
     bcontainer->initialized = true;
 
+    if (!vfio_iommufd_cpr_register_container(container, errp)) {
+        goto err_listener_register;
+    }
+
 found_container:
     ret = ioctl(devfd, VFIO_DEVICE_GET_INFO, &dev_info);
     if (ret) {
@@ -599,10 +603,6 @@ found_container:
         goto err_listener_register;
     }
 
-    if (!vfio_cpr_register_container(bcontainer, errp)) {
-        goto err_listener_register;
-    }
-
     /*
      * TODO: examine RAM_BLOCK_DISCARD stuff, should we do group level
      * for discarding incompatibility check as well?
@@ -619,6 +619,7 @@ found_container:
     vbasedev->bcontainer = bcontainer;
     QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
     QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
+    vfio_iommufd_cpr_register_device(vbasedev);
 
     trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
                                    vbasedev->num_regions, vbasedev->flags);
@@ -653,12 +654,13 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
         iommufd_cdev_ram_block_discard_disable(false);
     }
 
-    vfio_cpr_unregister_container(bcontainer);
+    vfio_iommufd_cpr_unregister_container(container);
     iommufd_cdev_detach_container(vbasedev, container);
     iommufd_cdev_container_destroy(container);
     vfio_put_address_space(space);
 
     migrate_del_blocker(&vbasedev->cpr_id_blocker);
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
index 37e7c26..add44d4 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -113,6 +113,7 @@ typedef struct VFIOIOASHwpt {
 typedef struct VFIOIOMMUFDContainer {
     VFIOContainerBase bcontainer;
     IOMMUFDBackend *be;
+    Error *cpr_blocker;
     uint32_t ioas_id;
     QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
 } VFIOIOMMUFDContainer;
@@ -271,6 +272,11 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp);
 void vfio_legacy_cpr_unregister_container(VFIOContainer *container);
 bool iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
                                       uint32_t ioas_id, Error **errp);
+bool vfio_iommufd_cpr_register_container(VFIOIOMMUFDContainer *container,
+                                         Error **errp);
+void vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer *container);
+void vfio_iommufd_cpr_register_device(VFIODevice *vbasedev);
+void vfio_iommufd_cpr_unregister_device(VFIODevice *vbasedev);
 
 extern const MemoryRegionOps vfio_region_ops;
 typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
-- 
1.8.3.1


