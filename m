Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48086C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 14:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td9IJ-0000WS-3i; Wed, 29 Jan 2025 09:43:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1td9IF-0000V3-2p
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:43:51 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1td9IC-0001KS-NG
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:43:50 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TEXjLi006509;
 Wed, 29 Jan 2025 14:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=equkl4PFueOKpfkrVaJeUTC9NSmqllHeha8OhdSWRB8=; b=
 O6cRx/XRVDT7jjjfxccrh3Nfgf0MrYUXSt7yTHPXbTNR22S0LQhd2EVAz7AJDjKD
 fR6jfBJT7PnSqYYBEZ7NL2Um9O/xTNY6+uNh/r55C7uMAyESidn4rmOHbWo8eRtm
 0PkEF3VJnK/I7eaABkALcfvznFyWhNri5uf0+LekmOK60YvhKaDDCzLtFt2JSDf+
 KyiJk3flzgrX93mRJ+c0kAbMt4QXPDeT+0p+Pei2pM0Ylv/4Cr4WtxiA7Ep6g+Yr
 0nawg+zO789MMSgja7P/Dli133S/N9PixsDgudM3YBayiKdXFMk/RAxMfUSmgYSE
 D1TzDaD/LUU5DI7mjExImA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fmf808sw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 14:43:45 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50TDC19K034407; Wed, 29 Jan 2025 14:43:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44cpd9s4px-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 14:43:44 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50TEhf8M003307;
 Wed, 29 Jan 2025 14:43:44 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 44cpd9s49q-5; Wed, 29 Jan 2025 14:43:44 +0000
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
Subject: [PATCH V1 04/26] vfio/container: register container for cpr
Date: Wed, 29 Jan 2025 06:43:00 -0800
Message-Id: <1738161802-172631-5-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: LnareuZpnGzbKkOFSMJ-TJUCtOS78XvV
X-Proofpoint-ORIG-GUID: LnareuZpnGzbKkOFSMJ-TJUCtOS78XvV
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

Register a legacy container for cpr-transfer.  Add a blocker if the kernel
does not support VFIO_UPDATE_VADDR or VFIO_UNMAP_ALL.

This is mostly boiler plate.  The fields to to saved and restored are added
in subsequent patches.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/container.c           |  6 ++--
 hw/vfio/cpr-legacy.c          | 68 +++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/meson.build           |  3 +-
 include/hw/vfio/vfio-common.h |  3 ++
 4 files changed, 76 insertions(+), 4 deletions(-)
 create mode 100644 hw/vfio/cpr-legacy.c

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 4ebb526..a90ce6c 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -618,7 +618,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     }
     bcontainer = &container->bcontainer;
 
-    if (!vfio_cpr_register_container(bcontainer, errp)) {
+    if (!vfio_legacy_cpr_register_container(container, errp)) {
         goto free_container_exit;
     }
 
@@ -666,7 +666,7 @@ enable_discards_exit:
     vfio_ram_block_discard_disable(container, false);
 
 unregister_container_exit:
-    vfio_cpr_unregister_container(bcontainer);
+    vfio_legacy_cpr_unregister_container(container);
 
 free_container_exit:
     object_unref(container);
@@ -710,7 +710,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
         VFIOAddressSpace *space = bcontainer->space;
 
         trace_vfio_disconnect_container(container->fd);
-        vfio_cpr_unregister_container(bcontainer);
+        vfio_legacy_cpr_unregister_container(container);
         close(container->fd);
         object_unref(container);
 
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
new file mode 100644
index 0000000..d3bbc05
--- /dev/null
+++ b/hw/vfio/cpr-legacy.c
@@ -0,0 +1,68 @@
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
+
+    return true;
+}
+
+void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
+{
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+
+    vfio_cpr_unregister_container(bcontainer);
+    migrate_del_blocker(&container->cpr_blocker);
+    vmstate_unregister(NULL, &vfio_container_vmstate, container);
+}
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
index 0c60be5..53e554f 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -84,6 +84,7 @@ typedef struct VFIOContainer {
     VFIOContainerBase bcontainer;
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
     unsigned iommu_type;
+    Error *cpr_blocker;
     QLIST_HEAD(, VFIOGroup) group_list;
 } VFIOContainer;
 
@@ -258,6 +259,8 @@ int vfio_kvm_device_del_fd(int fd, Error **errp);
 
 bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
 void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
+bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp);
+void vfio_legacy_cpr_unregister_container(VFIOContainer *container);
 
 extern const MemoryRegionOps vfio_region_ops;
 typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
-- 
1.8.3.1


