Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE245C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKisx-0004iT-4b; Thu, 29 May 2025 15:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisY-0004FV-9b
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisV-0000Sc-OB
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:25 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfsTk031396;
 Thu, 29 May 2025 19:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=2yVcyt2UtODNZwL+TCnFei12v5KPoNovUVPdMhLLsVc=; b=
 eAEDKs825bZshsoiTZg8Ts1G9FNBQOMek5EZ/sMCFvzUNKVtRSLD2fUMHnoa7CcH
 Yj8Cm02Sqj2Dz1PuO7+BqG69v4yU2T/xRtQjjvry3XTo4pRSnpZgvR2IPeq4gH8S
 y/UutfWHrEY5AjuzRiJ0C7Q5uGR1MefXexlnYblKts1O6lATnIVa0TFt2TQ+57fN
 p3HBwhGoM7Fx4SBbRUi7Dn1J1v9n9a+Bbf/8zXmDfEfSGvWcqGzlL0xX0xRuW1Sj
 nUI72yz8+gpwU2tFymaOVshj0BauGdeI06gQyPKCrmy19FeiAr1Zw8UvmKv4bykP
 kabbRh/yCaGuXotlVnw6Cg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v33n0yd8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:10 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54THgiDt020516; Thu, 29 May 2025 19:25:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4w6h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:10 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeRv022158;
 Thu, 29 May 2025 19:25:09 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-36; Thu, 29 May 2025 19:25:09 +0000
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
Subject: [PATCH V4 35/43] vfio/iommufd: register container for cpr
Date: Thu, 29 May 2025 12:24:31 -0700
Message-Id: <1748546679-154091-36-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfXxaWIst0fALVW
 1ATClN69ZyPnx+Oqi+uRzr6QpCwt6NJiLZchaFIVYPLIZ4rrV4zg16RzI+UPl/ARIUmSm18KkQk
 BCeckL8sPjtsMWnPkpzsb1WFPyhnli99a79nD/BdMRMFPMHANhcMYw8H1aYiSpKE+PAxMkfszjL
 I4H2+jkDVkn32zfof6k93yEyGWprTtlO66J253olFvHs9jpuIWYw6EUS6Lm7BPU6nrvYUp2WeBr
 eS4AmZlrv9Kz1fdIUUBk/j5iy34a4r6UOWqjdN1hvrn/8L7zJeH6WMHH9cRfrc5Wmv6EWPPo/t0
 0RDGQgzzSTsSdyv/wqYtVvwGgu9hedWzG3kwoEtio/N7NCXDM2+sOdXX4VjS0U+DZ04QAdX/XAw
 EeOY3nEh4gDiEyv3728AtozzQl4eubbnUE3y5FXcRJkz90StMl2LKePYVvLmq+u2NgjN61+H
X-Proofpoint-GUID: AqgNbh_aUvadHNxi70PPiKmBXaySj92k
X-Authority-Analysis: v=2.4 cv=aO/wqa9m c=1 sm=1 tr=0 ts=6838b496 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=OehiaK9QsM9hzHfbWWAA:9
X-Proofpoint-ORIG-GUID: AqgNbh_aUvadHNxi70PPiKmBXaySj92k
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
 hw/vfio/cpr-iommufd.c      | 84 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/iommufd.c          |  6 ++--
 hw/vfio/meson.build        |  1 +
 6 files changed, 112 insertions(+), 2 deletions(-)
 create mode 100644 hw/vfio/cpr-iommufd.c

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 170a116..b9b77ae 100644
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
index db9ed53..3c58ea8 100644
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
index ed8bb4c..2e9d6cb 100644
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
index 0000000..60bd7e8
--- /dev/null
+++ b/hw/vfio/cpr-iommufd.c
@@ -0,0 +1,84 @@
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
index ca00d08..c690c2c 100644
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
 
@@ -619,6 +619,7 @@ found_container:
     }
 
     vfio_device_prepare(vbasedev, bcontainer, &dev_info);
+    vfio_iommufd_cpr_register_device(vbasedev);
 
     trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
                                    vbasedev->num_regions, vbasedev->flags);
@@ -656,6 +657,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
     iommufd_cdev_container_destroy(container);
     vfio_address_space_put(space);
 
+    vfio_iommufd_cpr_unregister_device(vbasedev);
     iommufd_cdev_unbind_and_disconnect(vbasedev);
     close(vbasedev->fd);
 }
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 98134a7..12711fb 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -23,6 +23,7 @@ system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
 system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
 system_ss.add(when: 'CONFIG_VFIO', if_true: files(
   'cpr.c',
+  'cpr-iommufd.c',
   'cpr-legacy.c',
   'device.c',
   'migration.c',
-- 
1.8.3.1


