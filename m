Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D543C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 22:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX5U5-0003Th-B7; Wed, 02 Jul 2025 17:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5U2-0003Qy-3c
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:14 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5U0-0003iN-5D
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:13 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562LQfwV030336;
 Wed, 2 Jul 2025 21:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=xU3oBYlMHrd+RJ5ijtWnil0WGogPKqNK6HHG/6M50LM=; b=
 o6jGk3yd7j3R/2L4M/l0aaSvc/EzqDjRbULSoqUYk5wRxjQI1FfpP7nDDKqhYOqk
 ncd7AoSpLVBnkUjghqM9ERyG+fUTBXW/OcVgCTLol4FwumZfUA3wjA+f+iKFbXrG
 nI7PjPH8bDkjZNiR2lmIfmgr9gPSviJADGtBwZunpY73yuY4A48f+nax1TN6sUyL
 doVE+nqnNTMFOSJL4RQIi+GzyosaOLMgcrvJrRZKaNvw/gKeyLb/x1kuv+KuUPMu
 wRSAZ3WtUjJ8BUdXyje114WUJxV1ykbuy7Au6F7VeoAivi3Ivv/rmCfyTyYX79me
 iWpt82mz+7i5pNl7gaAgrg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j766fyqp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:09 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562LOF4W033659; Wed, 2 Jul 2025 21:59:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6ubtd4f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:08 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 562LwxgI020012;
 Wed, 2 Jul 2025 21:59:08 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47j6ubtcxb-13; Wed, 02 Jul 2025 21:59:08 +0000
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
Subject: [PATCH V6 12/21] vfio/iommufd: register container for cpr
Date: Wed,  2 Jul 2025 14:58:49 -0700
Message-Id: <1751493538-202042-13-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
References: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020182
X-Proofpoint-GUID: TkeNPzxF0FhbWLy7HOz0H5Pyf5BLMrEm
X-Proofpoint-ORIG-GUID: TkeNPzxF0FhbWLy7HOz0H5Pyf5BLMrEm
X-Authority-Analysis: v=2.4 cv=b82y4sGx c=1 sm=1 tr=0 ts=6865abad cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=fS_Gbb5f5KdBT8J5e8AA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE4MSBTYWx0ZWRfX5tEaVQdmw33q
 uDw6HsUxNbN+NSyKMHEk0UrGNBZOjFDQ3YAoozL9KD3t+8Nat84hPeitx+WOvsLbPJ0LDeeeuZ6
 GFn6WD0zVofWvBeBvfy8DTSDqyx99HJuir1YRnk9hfccVwwzzfAultbbStHqHCamUp2tVSd5Dna
 OmkWJ8P0F9zac9p8XOTKp8qq2oFapyMcYV7TIpfYGrMuA6u9gjcrfr63UTIh5kJfCjaIx3NK3hT
 Yi5gyHQzq/kAPvTQkBOUth9VKZkz6qd6x5S/HPtOGp42EE5aWX0dNxGIfJ1AVuj96RuILuZghKO
 rUyknskRU84cf9Jyy1Xoy0/ExFNb6baDpuCxcFT+bmfuRFv2OFblLww2rmjg3LvKRLJ7XRl0kOc
 7F/rphNLAfyW7r4KGqejL1ygd47n2qsCqXB/H5DuU5g3oaUStJMABqBY4jj9Iuh+Hu5A5ci1
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
 include/hw/vfio/vfio-cpr.h | 12 +++++++
 include/system/iommufd.h   |  1 +
 backends/iommufd.c         | 10 ++++++
 hw/vfio/cpr-iommufd.c      | 86 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/iommufd.c          |  6 ++--
 hw/vfio/meson.build        |  1 +
 6 files changed, 114 insertions(+), 2 deletions(-)
 create mode 100644 hw/vfio/cpr-iommufd.c

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 76eafc0..e0e3ee2 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -15,7 +15,10 @@
 struct VFIOContainer;
 struct VFIOContainerBase;
 struct VFIOGroup;
+struct VFIODevice;
 struct VFIOPCIDevice;
+struct VFIOIOMMUFDContainer;
+struct IOMMUFDBackend;
 
 typedef struct VFIOContainerCPR {
     Error *blocker;
@@ -43,6 +46,15 @@ bool vfio_cpr_register_container(struct VFIOContainerBase *bcontainer,
                                  Error **errp);
 void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
 
+bool vfio_iommufd_cpr_register_container(struct VFIOIOMMUFDContainer *container,
+                                         Error **errp);
+void vfio_iommufd_cpr_unregister_container(
+    struct VFIOIOMMUFDContainer *container);
+bool vfio_iommufd_cpr_register_iommufd(struct IOMMUFDBackend *be, Error **errp);
+void vfio_iommufd_cpr_unregister_iommufd(struct IOMMUFDBackend *be);
+void vfio_iommufd_cpr_register_device(struct VFIODevice *vbasedev);
+void vfio_iommufd_cpr_unregister_device(struct VFIODevice *vbasedev);
+
 int vfio_cpr_group_get_device_fd(int d, const char *name);
 
 bool vfio_cpr_container_match(struct VFIOContainer *container,
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index db5f2c7..c9c72ff 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -32,6 +32,7 @@ struct IOMMUFDBackend {
     /*< protected >*/
     int fd;            /* /dev/iommu file descriptor */
     bool owned;        /* is the /dev/iommu opened internally */
+    Error *cpr_blocker;/* set if be does not support CPR */
     uint32_t users;
 
     /*< public >*/
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 87f81a0..c554ce5 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -108,6 +108,13 @@ bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
         }
         be->fd = fd;
     }
+    if (!be->users && !vfio_iommufd_cpr_register_iommufd(be, errp)) {
+        if (be->owned) {
+            close(be->fd);
+            be->fd = -1;
+        }
+        return false;
+    }
     be->users++;
 
     trace_iommufd_backend_connect(be->fd, be->owned, be->users);
@@ -125,6 +132,9 @@ void iommufd_backend_disconnect(IOMMUFDBackend *be)
         be->fd = -1;
     }
 out:
+    if (!be->users) {
+        vfio_iommufd_cpr_unregister_iommufd(be);
+    }
     trace_iommufd_backend_disconnect(be->fd, be->users);
 }
 
diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
new file mode 100644
index 0000000..2f58b43
--- /dev/null
+++ b/hw/vfio/cpr-iommufd.c
@@ -0,0 +1,86 @@
+/*
+ * Copyright (c) 2024-2025 Oracle and/or its affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
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
+static bool vfio_cpr_supported(IOMMUFDBackend *be, Error **errp)
+{
+    if (!iommufd_change_process_capable(be)) {
+        if (errp) {
+            error_setg(errp, "vfio iommufd backend does not support "
+                       "IOMMU_IOAS_CHANGE_PROCESS");
+        }
+        return false;
+    }
+    return true;
+}
+
+static const VMStateDescription iommufd_cpr_vmstate = {
+    .name = "iommufd",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .needed = cpr_incoming_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+bool vfio_iommufd_cpr_register_iommufd(IOMMUFDBackend *be, Error **errp)
+{
+    Error **cpr_blocker = &be->cpr_blocker;
+
+    if (!vfio_cpr_supported(be, cpr_blocker)) {
+        return migrate_add_blocker_modes(cpr_blocker, errp,
+                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
+    }
+
+    vmstate_register(NULL, -1, &iommufd_cpr_vmstate, be);
+
+    return true;
+}
+
+void vfio_iommufd_cpr_unregister_iommufd(IOMMUFDBackend *be)
+{
+    vmstate_unregister(NULL, &iommufd_cpr_vmstate, be);
+    migrate_del_blocker(&be->cpr_blocker);
+}
+
+bool vfio_iommufd_cpr_register_container(VFIOIOMMUFDContainer *container,
+                                         Error **errp)
+{
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+
+    migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
+                                vfio_cpr_reboot_notifier,
+                                MIG_MODE_CPR_REBOOT);
+
+    vfio_cpr_add_kvm_notifier();
+
+    return true;
+}
+
+void vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer *container)
+{
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+
+    migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
+}
+
+void vfio_iommufd_cpr_register_device(VFIODevice *vbasedev)
+{
+}
+
+void vfio_iommufd_cpr_unregister_device(VFIODevice *vbasedev)
+{
+}
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 962a1e2..ff291be 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -446,7 +446,7 @@ static void iommufd_cdev_container_destroy(VFIOIOMMUFDContainer *container)
     if (!QLIST_EMPTY(&bcontainer->device_list)) {
         return;
     }
-    vfio_cpr_unregister_container(bcontainer);
+    vfio_iommufd_cpr_unregister_container(container);
     vfio_listener_unregister(bcontainer);
     iommufd_backend_free_id(container->be, container->ioas_id);
     object_unref(container);
@@ -592,7 +592,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         goto err_listener_register;
     }
 
-    if (!vfio_cpr_register_container(bcontainer, errp)) {
+    if (!vfio_iommufd_cpr_register_container(container, errp)) {
         goto err_listener_register;
     }
 
@@ -623,6 +623,7 @@ found_container:
     }
 
     vfio_device_prepare(vbasedev, bcontainer, &dev_info);
+    vfio_iommufd_cpr_register_device(vbasedev);
 
     trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
                                    vbasedev->num_regions, vbasedev->flags);
@@ -660,6 +661,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
     iommufd_cdev_container_destroy(container);
     vfio_address_space_put(space);
 
+    vfio_iommufd_cpr_unregister_device(vbasedev);
     iommufd_cdev_unbind_and_disconnect(vbasedev);
     close(vbasedev->fd);
 }
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 63ea393..7a88174 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -31,6 +31,7 @@ system_ss.add(when: 'CONFIG_VFIO', if_true: files(
 ))
 system_ss.add(when: ['CONFIG_VFIO', 'CONFIG_IOMMUFD'], if_true: files(
   'iommufd.c',
+  'cpr-iommufd.c',
 ))
 system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'display.c',
-- 
1.8.3.1


