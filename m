Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F4AC3DA59
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 19:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVFZA-000786-2x; Sat, 20 Jul 2024 15:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVFYx-0006q7-JX
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:16:14 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVFYk-0000rL-Sm
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:16:06 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46KJAjSN021362;
 Sat, 20 Jul 2024 19:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=DpTciMWL5BAj6n1iFBVHsSIkDF5ym/ImJcxqzxWgfVM=; b=
 HmApqsn91G1CDYkSxmlgQTxqrGQpck7Zr2TuIl2cqJ7WAW0KIq9DvXIjElG5oiQ1
 9LC1OnX7gLhdsbRkhGLCb/gZarT6s5jYutewWkjOJX/+sNTXUgcWTbobnwiPv0Bu
 E2D9oFVBWXJfjtwna8esOHZxH4b/DONoY2P4BEzVh8tEWVjxZxsjj9bw/RYvleP5
 RcV+VMNuPreneGeg0QsSYw8XdzCcK5x9MuPn02nPDId1crGMQhPX9WbH3ee6WP8w
 pyOvHFhBOtl2l81j5fmnWtEGCFxckNv1HZzbzfWF/RUuZF2KbKyXrbb/cHjRFsDn
 5AXeL8FXtoluVWR6eGWRrw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40gk5gr05b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 19:15:51 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46KHe1JX027443; Sat, 20 Jul 2024 19:15:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40g3p5puvf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 19:15:50 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46KJFdfH028365;
 Sat, 20 Jul 2024 19:15:50 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 40g3p5pusv-9; Sat, 20 Jul 2024 19:15:50 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 08/12] vfio/iommufd: register container for cpr
Date: Sat, 20 Jul 2024 12:15:33 -0700
Message-Id: <1721502937-87102-9-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1721502937-87102-1-git-send-email-steven.sistare@oracle.com>
References: <1721502937-87102-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-20_16,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407200140
X-Proofpoint-GUID: 2CudywQa5VHt7u50sWxOlsNDjiJAKXKE
X-Proofpoint-ORIG-GUID: 2CudywQa5VHt7u50sWxOlsNDjiJAKXKE
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 backends/iommufd.c            |  8 ++++++
 hw/vfio/cpr-iommufd.c         | 60 +++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/iommufd.c             |  2 ++
 hw/vfio/meson.build           |  1 +
 include/hw/vfio/vfio-common.h |  3 +++
 include/sysemu/iommufd.h      |  1 +
 6 files changed, 75 insertions(+)
 create mode 100644 hw/vfio/cpr-iommufd.c

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 4bdbad2..243178e 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -73,6 +73,14 @@ static void iommufd_backend_class_init(ObjectClass *oc, void *data)
     object_class_property_add_str(oc, "fd", NULL, iommufd_backend_set_fd);
 }
 
+bool iommufd_change_process_capable(IOMMUFDBackend *be)
+{
+    struct iommu_ioas_change_process args = {.n_umap = -1};
+
+    ioctl(be->fd, IOMMU_IOAS_CHANGE_PROCESS, &args);
+    return (errno != ENOTTY);
+}
+
 bool iommufd_backend_connect(IOMMUFDBackend *be, const char *name, Error **errp)
 {
     int fd;
diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
new file mode 100644
index 0000000..f2e34f4
--- /dev/null
+++ b/hw/vfio/cpr-iommufd.c
@@ -0,0 +1,60 @@
+/*
+ * Copyright (c) 2021-2024 Oracle and/or its affiliates.
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
+#include "sysemu/iommufd.h"
+
+#define IOMMUFD_CONTAINER(base) \
+    container_of(base, VFIOIOMMUFDContainer, bcontainer)
+
+static bool vfio_can_cpr_exec(VFIOIOMMUFDContainer *container, Error **errp)
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
+bool vfio_iommufd_cpr_register_container(VFIOContainerBase *bcontainer,
+                                         Error **errp)
+{
+    VFIOIOMMUFDContainer *container = IOMMUFD_CONTAINER(bcontainer);
+
+    if (!vfio_can_cpr_exec(container, &bcontainer->cpr_blocker)) {
+        return migrate_add_blocker_modes(&bcontainer->cpr_blocker, errp,
+                                        MIG_MODE_CPR_EXEC, -1) == 0;
+    }
+
+    vmstate_register(NULL, -1, &vfio_container_vmstate, container);
+
+    return true;
+}
+
+void vfio_iommufd_cpr_unregister_container(VFIOContainerBase *bcontainer)
+{
+    VFIOIOMMUFDContainer *container = IOMMUFD_CONTAINER(bcontainer);
+
+    vmstate_unregister(NULL, &vfio_container_vmstate, container);
+}
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 6d77daa..585bf09 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -632,6 +632,8 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
     vioc->attach_device = iommufd_cdev_attach;
     vioc->detach_device = iommufd_cdev_detach;
     vioc->pci_hot_reset = iommufd_cdev_pci_hot_reset;
+    vioc->cpr_register = vfio_iommufd_cpr_register_container;
+    vioc->cpr_unregister = vfio_iommufd_cpr_unregister_container;
 };
 
 static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
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
index ec5b7168..8aa02d4 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -247,6 +247,9 @@ bool vfio_legacy_cpr_register_container(VFIOContainerBase *bcontainer,
 void vfio_legacy_cpr_unregister_container(VFIOContainerBase *bcontainer);
 bool iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
                                       uint32_t ioas_id, Error **errp);
+bool vfio_iommufd_cpr_register_container(VFIOContainerBase *bcontainer,
+                                         Error **errp);
+void vfio_iommufd_cpr_unregister_container(VFIOContainerBase *bcontainer);
 
 extern const MemoryRegionOps vfio_region_ops;
 typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
index 6955ebd..f80b968 100644
--- a/include/sysemu/iommufd.h
+++ b/include/sysemu/iommufd.h
@@ -52,6 +52,7 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
 bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
                                      uint32_t *type, void *data, uint32_t len,
                                      Error **errp);
+bool iommufd_change_process_capable(IOMMUFDBackend *be);
 
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
 #endif
-- 
1.8.3.1


