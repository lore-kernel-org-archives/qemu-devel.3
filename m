Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF979C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEVAc-0005qs-Re; Mon, 12 May 2025 11:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9k-0004bu-OJ
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:29 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9h-0006jw-3U
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:28 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9e8k029127;
 Mon, 12 May 2025 15:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=7ZDTK+QRGCyskqM6p+NmXNNlLCzo2ogZX9GxKgviPGs=; b=
 IRfUPwYVwFUF4oLkdB0DExfx5ozjY7iph9B/vjh57OvdABPsYKZrzsurXkD2omiH
 M9GC8WBkhekytDya4sWjzt8kQ9akkMoEDTWtf1r6qibnscERtpapp0gJE1MBfN6k
 cCb7HkqQQNpk9STeQHOXszA5kU83gGzFYJ0TLeCwnpYmWAx6GzUjusRETkUI29lW
 FEGkJLWkafmnOpbbK/Gte3OjuE+hlF8wHaxyrhYf2REkPiYxSOqOm7bIUspvz/rF
 QcLV3qyMPXRw8EQqmXBpcjk5INXECc/jbcqCmi1sCcySwduwsNG7aodm1/0aRq3B
 GF/6GvLkoZozbOlhEZELiw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j0gwju7h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:22 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CE9APk002492; Mon, 12 May 2025 15:33:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx366t0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:21 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk5m030605;
 Mon, 12 May 2025 15:33:20 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-36; Mon, 12 May 2025 15:33:20 +0000
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
Subject: [PATCH V3 35/42] vfio/iommufd: register container for cpr
Date: Mon, 12 May 2025 08:32:46 -0700
Message-Id: <1747063973-124548-36-git-send-email-steven.sistare@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=M8hNKzws c=1 sm=1 tr=0 ts=682214c2 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=5jwUPUheXx9_u-38UnQA:9
X-Proofpoint-GUID: gkZaZrSd14uV8Ywi6hF30lG7bsyMVtM0
X-Proofpoint-ORIG-GUID: gkZaZrSd14uV8Ywi6hF30lG7bsyMVtM0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfXyuDqtXnyk9eq
 3vK+IwplldUB4lU5lWi5wO72wSuWWWcsSkSxVorh/7S6dQ5PdmGlXqU+/IKvqmt9jnP2lE329fh
 NGNx3oQCK4pZF2puKmusn1B0PPJdbZztPRyahDVc8bFCZIpLZjUTvAUUuCf0CABMG/nWPdZSjfO
 fKPPKpEL1spDk1sLOK1ag7FtQRxgjy5RWtf6G1ODuuvy8REM/DwyHLt7jAlPctBREPiPdzFPxhO
 e9IpLyGH0up/fksUhz0/a+NMLkTmYaMTTVHdAnxCl+pZzTE7QMcz/NV0vCYLMoeBL5bt1tqy38y
 t855PqDX4VbSmr8fHXsUTecWMJl4R+Ie4tXiPG5uk9h+PFOQ9cuyDNrcbIEHQAK44aS0W0FHCjC
 HbbBIq9dbP1F2KAFnjwOYF6qDhKs4Fp2UJOxR8IxcfY4HPXNljVWbplVPzy7NznD0weeLsjF
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

Register a vfio iommufd container and device for CPR, replacing the generic
CPR register call with a more specific iommufd register call.  Add a
blocker if the kernel does not support IOMMU_IOAS_CHANGE_PROCESS.

This is mostly boiler plate.  The fields to to saved and restored are added
in subsequent patches.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/cpr-iommufd.c      | 97 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/iommufd.c          |  6 ++-
 hw/vfio/meson.build        |  1 +
 hw/vfio/vfio-iommufd.h     |  1 +
 include/hw/vfio/vfio-cpr.h |  8 ++++
 5 files changed, 111 insertions(+), 2 deletions(-)
 create mode 100644 hw/vfio/cpr-iommufd.c

diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
new file mode 100644
index 0000000..46f2006
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
+#include "hw/vfio/vfio-cpr.h"
+#include "migration/blocker.h"
+#include "migration/cpr.h"
+#include "migration/migration.h"
+#include "migration/vmstate.h"
+#include "system/iommufd.h"
+#include "vfio-iommufd.h"
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
index ea99b8d..dabb948 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -460,7 +460,7 @@ static void iommufd_cdev_container_destroy(VFIOIOMMUFDContainer *container)
     if (!QLIST_EMPTY(&bcontainer->device_list)) {
         return;
     }
-    vfio_cpr_unregister_container(bcontainer);
+    vfio_iommufd_cpr_unregister_container(container);
     vfio_listener_unregister(bcontainer);
     iommufd_backend_free_id(container->be, container->ioas_id);
     object_unref(container);
@@ -611,7 +611,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         goto err_listener_register;
     }
 
-    if (!vfio_cpr_register_container(bcontainer, errp)) {
+    if (!vfio_iommufd_cpr_register_container(container, errp)) {
         goto err_listener_register;
     }
 
@@ -633,6 +633,7 @@ found_container:
     }
 
     vfio_device_prepare(vbasedev, bcontainer, &dev_info);
+    vfio_iommufd_cpr_register_device(vbasedev);
 
     trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
                                    vbasedev->num_regions, vbasedev->flags);
@@ -671,6 +672,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
     vfio_address_space_put(space);
 
     migrate_del_blocker(&vbasedev->cpr.id_blocker);
+    vfio_iommufd_cpr_unregister_device(vbasedev);
     iommufd_cdev_unbind_and_disconnect(vbasedev);
     close(vbasedev->fd);
 }
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 73d29f9..a158fd8 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -21,6 +21,7 @@ system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
 system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
 system_ss.add(when: 'CONFIG_VFIO', if_true: files(
   'cpr.c',
+  'cpr-iommufd.c',
   'cpr-legacy.c',
   'device.c',
   'migration.c',
diff --git a/hw/vfio/vfio-iommufd.h b/hw/vfio/vfio-iommufd.h
index 5615dcd..cc57a05 100644
--- a/hw/vfio/vfio-iommufd.h
+++ b/hw/vfio/vfio-iommufd.h
@@ -25,6 +25,7 @@ typedef struct IOMMUFDBackend IOMMUFDBackend;
 typedef struct VFIOIOMMUFDContainer {
     VFIOContainerBase bcontainer;
     IOMMUFDBackend *be;
+    Error *cpr_blocker;
     uint32_t ioas_id;
     QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
 } VFIOIOMMUFDContainer;
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index d06d117..1379b20 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -31,6 +31,7 @@ struct VFIOContainerBase;
 struct VFIOGroup;
 struct VFIOPCIDevice;
 struct VFIODevice;
+struct VFIOIOMMUFDContainer;
 
 bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
                                         Error **errp);
@@ -43,6 +44,13 @@ bool vfio_cpr_register_container(struct VFIOContainerBase *bcontainer,
                                  Error **errp);
 void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
 
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


