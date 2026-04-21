Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2E4F8FA90
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFE4x-0004sw-Rq; Tue, 21 Apr 2026 12:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wFE40-0004aG-OM
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:35:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wFE3q-0007KT-Cc
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776789293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gZWM2kQuZy+59YJLKvLBs1e6rIWb4i3/E9198uvLvD8=;
 b=aQQBaBSOweyTE5ICGaC61E2inXtFkjqq+p0PmcRTLXfhE26SPhsevPy8w3NWKf8e/esMf3
 zwgCiGHRWdDQ9R87PWp58+Otr3uO+a7p28084prnpcFztUfwwe7kqO5kwgc1Y+yOchmHxb
 QRTwK6i14Cx6/tCUO4Vs/3pqvBGx3KY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-86wLxg-MNCC-FDZkFmCEaw-1; Tue,
 21 Apr 2026 12:34:47 -0400
X-MC-Unique: 86wLxg-MNCC-FDZkFmCEaw-1
X-Mimecast-MFC-AGG-ID: 86wLxg-MNCC-FDZkFmCEaw_1776789286
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD9D21800464; Tue, 21 Apr 2026 16:34:46 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.70])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A61B1956095; Tue, 21 Apr 2026 16:34:44 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/14] hw/vfio/helpers.c: extract kvm helpers in kvm-helpers.c
Date: Tue, 21 Apr 2026 18:34:26 +0200
Message-ID: <20260421163438.3447280-3-clg@redhat.com>
In-Reply-To: <20260421163438.3447280-1-clg@redhat.com>
References: <20260421163438.3447280-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Because those functions use kvm specific types, they need to be isolated
in another source file.
This allows us to link kvm-helpers only in configurations with
CONFIG_KVM.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260318174733.1717643-3-pierrick.bouvier@linaro.org
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/helpers.c     | 172 -------------------------------------
 hw/vfio/kvm-helpers.c | 192 ++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/kvm-stubs.c   |  26 ++++++
 hw/vfio/meson.build   |   2 +
 4 files changed, 220 insertions(+), 172 deletions(-)
 create mode 100644 hw/vfio/kvm-helpers.c
 create mode 100644 hw/vfio/kvm-stubs.c

diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 00d42d3b98ef98368bb30ff11098615c881cf0a8..65c6dba0428954170ce8a889edffa34ce9b24b13 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -22,7 +22,6 @@
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
 
-#include "system/kvm.h"
 #include "exec/cpu-common.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/core/hw-error.h"
@@ -107,177 +106,6 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
     return true;
 }
 
-#ifdef CONFIG_KVM
-/*
- * We have a single VFIO pseudo device per KVM VM.  Once created it lives
- * for the life of the VM.  Closing the file descriptor only drops our
- * reference to it and the device's reference to kvm.  Therefore once
- * initialized, this file descriptor is only released on QEMU exit and
- * we'll re-use it should another vfio device be attached before then.
- */
-int vfio_kvm_device_fd = -1;
-
-/*
- * Confidential virtual machines:
- * During reset of confidential vms, the kvm vm file descriptor changes.
- * In this case, the old vfio kvm file descriptor is
- * closed and a new descriptor is created against the new kvm vm file
- * descriptor.
- */
-
-typedef struct VFIODeviceFd {
-    int fd;
-    QLIST_ENTRY(VFIODeviceFd) node;
-} VFIODeviceFd;
-
-static QLIST_HEAD(, VFIODeviceFd) vfio_device_fds =
-    QLIST_HEAD_INITIALIZER(vfio_device_fds);
-
-static void vfio_device_fd_list_add(int fd)
-{
-    VFIODeviceFd *file_fd;
-    file_fd = g_malloc0(sizeof(*file_fd));
-    file_fd->fd = fd;
-    QLIST_INSERT_HEAD(&vfio_device_fds, file_fd, node);
-}
-
-static void vfio_device_fd_list_remove(int fd)
-{
-    VFIODeviceFd *file_fd, *next;
-
-    QLIST_FOREACH_SAFE(file_fd, &vfio_device_fds, node, next) {
-        if (file_fd->fd == fd) {
-            QLIST_REMOVE(file_fd, node);
-            g_free(file_fd);
-            break;
-        }
-    }
-}
-
-static int vfio_device_fd_rebind(NotifierWithReturn *notifier, void *data,
-                                  Error **errp)
-{
-    VFIODeviceFd *file_fd;
-    struct kvm_device_attr attr = {
-        .group = KVM_DEV_VFIO_FILE,
-        .attr = KVM_DEV_VFIO_FILE_ADD,
-    };
-    struct kvm_create_device cd = {
-        .type = KVM_DEV_TYPE_VFIO,
-    };
-
-    /* we are not interested in pre vmfd change notification */
-    if (((VmfdChangeNotifier *)data)->pre) {
-        return 0;
-    }
-
-    if (kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd)) {
-        error_setg_errno(errp, errno, "Failed to create KVM VFIO device");
-        return -errno;
-    }
-
-    if (vfio_kvm_device_fd != -1) {
-        close(vfio_kvm_device_fd);
-    }
-
-    vfio_kvm_device_fd = cd.fd;
-
-    QLIST_FOREACH(file_fd, &vfio_device_fds, node) {
-        attr.addr = (uint64_t)(unsigned long)&file_fd->fd;
-        if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
-            error_setg_errno(errp, errno,
-                             "Failed to add fd %d to KVM VFIO device",
-                             file_fd->fd);
-            return -errno;
-        }
-    }
-    return 0;
-}
-
-static struct NotifierWithReturn vfio_vmfd_change_notifier = {
-    .notify = vfio_device_fd_rebind,
-};
-
-#endif
-
-void vfio_kvm_device_close(void)
-{
-#ifdef CONFIG_KVM
-    kvm_close();
-    if (vfio_kvm_device_fd != -1) {
-        close(vfio_kvm_device_fd);
-        vfio_kvm_device_fd = -1;
-    }
-#endif
-}
-
-int vfio_kvm_device_add_fd(int fd, Error **errp)
-{
-#ifdef CONFIG_KVM
-    struct kvm_device_attr attr = {
-        .group = KVM_DEV_VFIO_FILE,
-        .attr = KVM_DEV_VFIO_FILE_ADD,
-        .addr = (uint64_t)(unsigned long)&fd,
-    };
-
-    if (!kvm_enabled()) {
-        return 0;
-    }
-
-    if (vfio_kvm_device_fd < 0) {
-        struct kvm_create_device cd = {
-            .type = KVM_DEV_TYPE_VFIO,
-        };
-
-        if (kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd)) {
-            error_setg_errno(errp, errno, "Failed to create KVM VFIO device");
-            return -errno;
-        }
-
-        vfio_kvm_device_fd = cd.fd;
-        /*
-         * If the vm file descriptor changes, add a notifier so that we can
-         * re-create the vfio_kvm_device_fd.
-         */
-        kvm_vmfd_add_change_notifier(&vfio_vmfd_change_notifier);
-    }
-
-    if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
-        error_setg_errno(errp, errno, "Failed to add fd %d to KVM VFIO device",
-                         fd);
-        return -errno;
-    }
-
-    vfio_device_fd_list_add(fd);
-#endif
-    return 0;
-}
-
-int vfio_kvm_device_del_fd(int fd, Error **errp)
-{
-#ifdef CONFIG_KVM
-    struct kvm_device_attr attr = {
-        .group = KVM_DEV_VFIO_FILE,
-        .attr = KVM_DEV_VFIO_FILE_DEL,
-        .addr = (uint64_t)(unsigned long)&fd,
-    };
-
-    if (vfio_kvm_device_fd < 0) {
-        error_setg(errp, "KVM VFIO device isn't created yet");
-        return -EINVAL;
-    }
-
-    if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
-        error_setg_errno(errp, errno,
-                         "Failed to remove fd %d from KVM VFIO device", fd);
-        return -errno;
-    }
-
-    vfio_device_fd_list_remove(fd);
-#endif
-    return 0;
-}
-
 struct vfio_device_info *vfio_get_device_info(int fd)
 {
     struct vfio_device_info *info;
diff --git a/hw/vfio/kvm-helpers.c b/hw/vfio/kvm-helpers.c
new file mode 100644
index 0000000000000000000000000000000000000000..d71c9590aaa53dc4e436987a34575f57a6397c6b
--- /dev/null
+++ b/hw/vfio/kvm-helpers.c
@@ -0,0 +1,192 @@
+/*
+ * low level and IOMMU backend agnostic helpers used by VFIO devices,
+ * related to regions, interrupts, capabilities
+ *
+ * Copyright Red Hat, Inc. 2012
+ *
+ * Authors:
+ *  Alex Williamson <alex.williamson@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Based on qemu-kvm device-assignment:
+ *  Adapted for KVM by Qumranet.
+ *  Copyright (c) 2007, Neocleus, Alex Novik (alex@neocleus.com)
+ *  Copyright (c) 2007, Neocleus, Guy Zana (guy@neocleus.com)
+ *  Copyright (C) 2008, Qumranet, Amit Shah (amit.shah@qumranet.com)
+ *  Copyright (C) 2008, Red Hat, Amit Shah (amit.shah@redhat.com)
+ *  Copyright (C) 2008, IBM, Muli Ben-Yehuda (muli@il.ibm.com)
+ */
+
+#include "qemu/osdep.h"
+#include <sys/ioctl.h>
+
+#include <linux/kvm.h>
+#include "system/kvm.h"
+#include "exec/cpu-common.h"
+#include "hw/vfio/vfio-device.h"
+#include "hw/core/hw-error.h"
+#include "qapi/error.h"
+#include "vfio-helpers.h"
+
+/*
+ * We have a single VFIO pseudo device per KVM VM.  Once created it lives
+ * for the life of the VM.  Closing the file descriptor only drops our
+ * reference to it and the device's reference to kvm.  Therefore once
+ * initialized, this file descriptor is only released on QEMU exit and
+ * we'll re-use it should another vfio device be attached before then.
+ */
+int vfio_kvm_device_fd = -1;
+
+/*
+ * Confidential virtual machines:
+ * During reset of confidential vms, the kvm vm file descriptor changes.
+ * In this case, the old vfio kvm file descriptor is
+ * closed and a new descriptor is created against the new kvm vm file
+ * descriptor.
+ */
+
+typedef struct VFIODeviceFd {
+    int fd;
+    QLIST_ENTRY(VFIODeviceFd) node;
+} VFIODeviceFd;
+
+static QLIST_HEAD(, VFIODeviceFd) vfio_device_fds =
+    QLIST_HEAD_INITIALIZER(vfio_device_fds);
+
+static void vfio_device_fd_list_add(int fd)
+{
+    VFIODeviceFd *file_fd;
+    file_fd = g_malloc0(sizeof(*file_fd));
+    file_fd->fd = fd;
+    QLIST_INSERT_HEAD(&vfio_device_fds, file_fd, node);
+}
+
+static void vfio_device_fd_list_remove(int fd)
+{
+    VFIODeviceFd *file_fd, *next;
+
+    QLIST_FOREACH_SAFE(file_fd, &vfio_device_fds, node, next) {
+        if (file_fd->fd == fd) {
+            QLIST_REMOVE(file_fd, node);
+            g_free(file_fd);
+            break;
+        }
+    }
+}
+
+static int vfio_device_fd_rebind(NotifierWithReturn *notifier, void *data,
+                                  Error **errp)
+{
+    VFIODeviceFd *file_fd;
+    struct kvm_device_attr attr = {
+        .group = KVM_DEV_VFIO_FILE,
+        .attr = KVM_DEV_VFIO_FILE_ADD,
+    };
+    struct kvm_create_device cd = {
+        .type = KVM_DEV_TYPE_VFIO,
+    };
+
+    /* we are not interested in pre vmfd change notification */
+    if (((VmfdChangeNotifier *)data)->pre) {
+        return 0;
+    }
+
+    if (kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd)) {
+        error_setg_errno(errp, errno, "Failed to create KVM VFIO device");
+        return -errno;
+    }
+
+    if (vfio_kvm_device_fd != -1) {
+        close(vfio_kvm_device_fd);
+    }
+
+    vfio_kvm_device_fd = cd.fd;
+
+    QLIST_FOREACH(file_fd, &vfio_device_fds, node) {
+        attr.addr = (uint64_t)(unsigned long)&file_fd->fd;
+        if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
+            error_setg_errno(errp, errno,
+                             "Failed to add fd %d to KVM VFIO device",
+                             file_fd->fd);
+            return -errno;
+        }
+    }
+    return 0;
+}
+
+static struct NotifierWithReturn vfio_vmfd_change_notifier = {
+    .notify = vfio_device_fd_rebind,
+};
+
+void vfio_kvm_device_close(void)
+{
+    kvm_close();
+    if (vfio_kvm_device_fd != -1) {
+        close(vfio_kvm_device_fd);
+        vfio_kvm_device_fd = -1;
+    }
+}
+
+int vfio_kvm_device_add_fd(int fd, Error **errp)
+{
+    struct kvm_device_attr attr = {
+        .group = KVM_DEV_VFIO_FILE,
+        .attr = KVM_DEV_VFIO_FILE_ADD,
+        .addr = (uint64_t)(unsigned long)&fd,
+    };
+
+    if (!kvm_enabled()) {
+        return 0;
+    }
+
+    if (vfio_kvm_device_fd < 0) {
+        struct kvm_create_device cd = {
+            .type = KVM_DEV_TYPE_VFIO,
+        };
+
+        if (kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd)) {
+            error_setg_errno(errp, errno, "Failed to create KVM VFIO device");
+            return -errno;
+        }
+
+        vfio_kvm_device_fd = cd.fd;
+        /*
+         * If the vm file descriptor changes, add a notifier so that we can
+         * re-create the vfio_kvm_device_fd.
+         */
+        kvm_vmfd_add_change_notifier(&vfio_vmfd_change_notifier);
+    }
+
+    if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
+        error_setg_errno(errp, errno, "Failed to add fd %d to KVM VFIO device",
+                         fd);
+        return -errno;
+    }
+
+    vfio_device_fd_list_add(fd);
+    return 0;
+}
+
+int vfio_kvm_device_del_fd(int fd, Error **errp)
+{
+    struct kvm_device_attr attr = {
+        .group = KVM_DEV_VFIO_FILE,
+        .attr = KVM_DEV_VFIO_FILE_DEL,
+        .addr = (uint64_t)(unsigned long)&fd,
+    };
+
+    if (vfio_kvm_device_fd < 0) {
+        error_setg(errp, "KVM VFIO device isn't created yet");
+        return -EINVAL;
+    }
+
+    if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
+        error_setg_errno(errp, errno,
+                         "Failed to remove fd %d from KVM VFIO device", fd);
+        return -errno;
+    }
+
+    vfio_device_fd_list_remove(fd);
+    return 0;
+}
diff --git a/hw/vfio/kvm-stubs.c b/hw/vfio/kvm-stubs.c
new file mode 100644
index 0000000000000000000000000000000000000000..5a489d1b7110a5564054398cc354bb806ac39334
--- /dev/null
+++ b/hw/vfio/kvm-stubs.c
@@ -0,0 +1,26 @@
+/*
+ * Stubs for kvm helpers
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/vfio/vfio-device.h"
+#include "qapi/error.h"
+#include "vfio-helpers.h"
+
+void vfio_kvm_device_close(void)
+{
+    return;
+}
+
+int vfio_kvm_device_add_fd(int fd, Error **errp)
+{
+    return 0;
+}
+
+int vfio_kvm_device_del_fd(int fd, Error **errp)
+{
+    return 0;
+}
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 82f68698fb8483196d5ced096f79d1024bf9c4bc..f2a7728d3d00f70b6a6f6e3ea24749e6246b5c43 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -7,6 +7,8 @@ vfio_ss.add(files(
   'container-legacy.c',
   'helpers.c',
 ))
+vfio_ss.add(when: 'CONFIG_KVM', if_true: files('kvm-helpers.c'))
+stub_ss.add(files('kvm-stubs.c'))
 vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'pci-quirks.c',
-- 
2.53.0


