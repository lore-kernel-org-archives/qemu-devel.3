Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A16C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXc4B-0000BN-7h; Fri, 04 Jul 2025 04:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc47-0008VT-95
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:46:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc45-000186-5b
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751618796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kaTS+0aZpyNuV/JhVP9aCHEbDpEONk4O446liL6Tlto=;
 b=aFm7GRY1NF6wmm4kQ0fC73T3H0sL52HqFTv4SeTpIbE2Z2z8YavCvcQ8UxlfnKpsahB46M
 8ath+Hh4FjGLOg/0uBA5uxsiVV29rBAwBObHZ/oO68O6yRStG2V2Tst+u4XViEU833FbVz
 CjXkNQpVbJMSXrL1CEZhShrktg2uvRs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-FetbsOEdPSe4rQE1MGYCTA-1; Fri,
 04 Jul 2025 04:46:33 -0400
X-MC-Unique: FetbsOEdPSe4rQE1MGYCTA-1
X-Mimecast-MFC-AGG-ID: FetbsOEdPSe4rQE1MGYCTA_1751618792
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00B121944A8C; Fri,  4 Jul 2025 08:46:32 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.43])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 186F819560A7; Fri,  4 Jul 2025 08:46:29 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 21/27] vfio/iommufd: preserve descriptors
Date: Fri,  4 Jul 2025 10:45:22 +0200
Message-ID: <20250704084528.1412959-22-clg@redhat.com>
In-Reply-To: <20250704084528.1412959-1-clg@redhat.com>
References: <20250704084528.1412959-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Save the iommu and vfio device fd in CPR state when it is created.
After CPR, the fd number is found in CPR state and reused.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/1751493538-202042-16-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 backends/iommufd.c    | 35 +++++++++++++++++++++++++++++------
 hw/vfio/cpr-iommufd.c | 10 ++++++++++
 hw/vfio/device.c      |  9 +--------
 3 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index c554ce5385dd603ba35f97167ab8031750ecdc2f..e0917923bffbb60dc5c58235880335c4d5eb7df7 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -16,12 +16,18 @@
 #include "qemu/module.h"
 #include "qom/object_interfaces.h"
 #include "qemu/error-report.h"
+#include "migration/cpr.h"
 #include "monitor/monitor.h"
 #include "trace.h"
 #include "hw/vfio/vfio-device.h"
 #include <sys/ioctl.h>
 #include <linux/iommufd.h>
 
+static const char *iommufd_fd_name(IOMMUFDBackend *be)
+{
+    return object_get_canonical_path_component(OBJECT(be));
+}
+
 static void iommufd_backend_init(Object *obj)
 {
     IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
@@ -64,11 +70,27 @@ static bool iommufd_backend_can_be_deleted(UserCreatable *uc)
     return !be->users;
 }
 
+static void iommufd_backend_complete(UserCreatable *uc, Error **errp)
+{
+    IOMMUFDBackend *be = IOMMUFD_BACKEND(uc);
+    const char *name = iommufd_fd_name(be);
+
+    if (!be->owned) {
+        /* fd came from the command line. Fetch updated value from cpr state. */
+        if (cpr_is_incoming()) {
+            be->fd = cpr_find_fd(name, 0);
+        } else {
+            cpr_save_fd(name, 0, be->fd);
+        }
+    }
+}
+
 static void iommufd_backend_class_init(ObjectClass *oc, const void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
     ucc->can_be_deleted = iommufd_backend_can_be_deleted;
+    ucc->complete = iommufd_backend_complete;
 
     object_class_property_add_str(oc, "fd", NULL, iommufd_backend_set_fd);
 }
@@ -102,7 +124,7 @@ bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
     int fd;
 
     if (be->owned && !be->users) {
-        fd = qemu_open("/dev/iommu", O_RDWR, errp);
+        fd = cpr_open_fd("/dev/iommu", O_RDWR, iommufd_fd_name(be), 0, errp);
         if (fd < 0) {
             return false;
         }
@@ -127,14 +149,15 @@ void iommufd_backend_disconnect(IOMMUFDBackend *be)
         goto out;
     }
     be->users--;
-    if (!be->users && be->owned) {
-        close(be->fd);
-        be->fd = -1;
-    }
-out:
     if (!be->users) {
         vfio_iommufd_cpr_unregister_iommufd(be);
+        if (be->owned) {
+            cpr_delete_fd(iommufd_fd_name(be), 0);
+            close(be->fd);
+            be->fd = -1;
+        }
     }
+out:
     trace_iommufd_backend_disconnect(be->fd, be->users);
 }
 
diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index 4166201e3f70441ff97aef23c3b6f8bf506c76ad..a72b68daa8e4da19b9cbf3ab50631211965cdf37 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -166,12 +166,18 @@ void vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer *container)
 void vfio_iommufd_cpr_register_device(VFIODevice *vbasedev)
 {
     if (!cpr_is_incoming()) {
+        /*
+         * Beware fd may have already been saved by vfio_device_set_fd,
+         * so call resave to avoid a duplicate entry.
+         */
+        cpr_resave_fd(vbasedev->name, 0, vbasedev->fd);
         vfio_cpr_save_device(vbasedev);
     }
 }
 
 void vfio_iommufd_cpr_unregister_device(VFIODevice *vbasedev)
 {
+    cpr_delete_fd(vbasedev->name, 0);
     vfio_cpr_delete_device(vbasedev->name);
 }
 
@@ -180,5 +186,9 @@ void vfio_cpr_load_device(VFIODevice *vbasedev)
     if (cpr_is_incoming()) {
         bool ret = vfio_cpr_find_device(vbasedev);
         g_assert(ret);
+
+        if (vbasedev->fd < 0) {
+            vbasedev->fd = cpr_find_fd(vbasedev->name, 0);
+        }
     }
 }
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 0ae3f3c6607d329e08fd435d2934e23affc27264..96cf21462cb10f9ebaf1bda54fed13a95b79f223 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -351,14 +351,7 @@ void vfio_device_free_name(VFIODevice *vbasedev)
 
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
 {
-    ERRP_GUARD();
-    int fd = monitor_fd_param(monitor_cur(), str, errp);
-
-    if (fd < 0) {
-        error_prepend(errp, "Could not parse remote object fd %s:", str);
-        return;
-    }
-    vbasedev->fd = fd;
+    vbasedev->fd = cpr_get_fd_param(vbasedev->dev->id, str, 0, errp);
 }
 
 static VFIODeviceIOOps vfio_device_io_ops_ioctl;
-- 
2.50.0


