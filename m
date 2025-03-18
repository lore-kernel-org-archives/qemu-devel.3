Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C8EC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 09:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuTfr-0004pn-Uk; Tue, 18 Mar 2025 05:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTfl-0004iZ-VS
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:55:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTfj-0002Lr-K7
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742291740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DfUgHgwiez10smVgfqHZV1RcWPSOeAEvs/ghQf6T1RQ=;
 b=KFWp1A48YnNfjd+4qK9dw+aHjLWtWMo2TT4bVBnetHRjMBfytxqpzgnt+ZiIe119IgYHx/
 FIGGKXQFh2Rc2FSJiFfgBY5t7B+BFA7LYuHFfhofEwh6me66YcP0spiwrooIQCmJtrgk5/
 aK3+P9XM1J5pVt9RFMQB7XI5ETbEG34=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-cJb5aANRO7iyUc6FmlDknw-1; Tue,
 18 Mar 2025 05:55:38 -0400
X-MC-Unique: cJb5aANRO7iyUc6FmlDknw-1
X-Mimecast-MFC-AGG-ID: cJb5aANRO7iyUc6FmlDknw_1742291737
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A6541956053; Tue, 18 Mar 2025 09:55:37 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 59DC11828A84; Tue, 18 Mar 2025 09:55:35 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 17/32] vfio: Move vfio_kvm_device_add/del_fd() to
 helpers.c
Date: Tue, 18 Mar 2025 10:54:00 +0100
Message-ID: <20250318095415.670319-18-clg@redhat.com>
In-Reply-To: <20250318095415.670319-1-clg@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

vfio_kvm_device_add/del_fd() are low level routines. Move them with
the other helpers.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/helpers.h             |  3 ++
 include/hw/vfio/vfio-common.h |  3 --
 hw/vfio/common.c              | 58 ----------------------------------
 hw/vfio/helpers.c             | 59 +++++++++++++++++++++++++++++++++++
 hw/vfio/iommufd.c             |  1 +
 hw/vfio/meson.build           |  2 +-
 6 files changed, 64 insertions(+), 62 deletions(-)

diff --git a/hw/vfio/helpers.h b/hw/vfio/helpers.h
index c70eef4fd6f98fc1df9bc8ecbf72fa1ea484e3c0..397908735c6b285d3d9e012f30488589408235ae 100644
--- a/hw/vfio/helpers.h
+++ b/hw/vfio/helpers.h
@@ -26,4 +26,7 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
 
 int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size);
 
+int vfio_kvm_device_add_fd(int fd, Error **errp);
+int vfio_kvm_device_del_fd(int fd, Error **errp);
+
 #endif /* HW_VFIO_HELPERS_H */
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index b7c1f049582c07aefdc2a0cef2805e7b478ffe84..35b765357f85346ecfabfae782f3aa8d83d9e7ae 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -129,9 +129,6 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
 void vfio_detach_device(VFIODevice *vbasedev);
 VFIODevice *vfio_get_vfio_device(Object *obj);
 
-int vfio_kvm_device_add_fd(int fd, Error **errp);
-int vfio_kvm_device_del_fd(int fd, Error **errp);
-
 bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
 void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 3a20b121fcaf361596bc975437f9a358effc7f88..9c1b635a813ffff97426d2c3beec84de1b9afe63 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1302,64 +1302,6 @@ const MemoryListener vfio_memory_listener = {
     .log_sync = vfio_listener_log_sync,
 };
 
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
-    }
-
-    if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
-        error_setg_errno(errp, errno, "Failed to add fd %d to KVM VFIO device",
-                         fd);
-        return -errno;
-    }
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
-#endif
-    return 0;
-}
-
 struct vfio_device_info *vfio_get_device_info(int fd)
 {
     struct vfio_device_info *info;
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index f42dcf82c58c978a45975eb1d015d64f4e39b3cf..cec9e2008ba146c15e54a2865d5a40984e7dfc8c 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -22,6 +22,7 @@
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
 
+#include "system/kvm.h"
 #include "hw/vfio/vfio-common.h"
 #include "hw/vfio/pci.h"
 #include "hw/hw.h"
@@ -253,6 +254,64 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
     return true;
 }
 
+int vfio_kvm_device_add_fd(int fd, Error **errp)
+{
+#ifdef CONFIG_KVM
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
+    }
+
+    if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
+        error_setg_errno(errp, errno, "Failed to add fd %d to KVM VFIO device",
+                         fd);
+        return -errno;
+    }
+#endif
+    return 0;
+}
+
+int vfio_kvm_device_del_fd(int fd, Error **errp)
+{
+#ifdef CONFIG_KVM
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
+#endif
+    return 0;
+}
+
 int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
                              uint32_t subtype, struct vfio_region_info **info)
 {
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index ce47c85c0dde424b36b482344ff8c92fc2485f9f..bc586e02803af984d1801159eb427d3415e373ab 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -27,6 +27,7 @@
 #include "pci.h"
 #include "migration.h"
 #include "iommufd.h"
+#include "helpers.h"
 
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO             \
             TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 07010c7c9e01a39ae3449c54d2027a2cdd0a7a4d..21795b3d19e5db0c93993c0cb4a951a70d260f10 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -2,6 +2,7 @@ vfio_ss = ss.source_set()
 vfio_ss.add(files(
   'common.c',
   'container.c',
+  'helpers.c',
 ))
 vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
@@ -18,7 +19,6 @@ specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
 system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
 system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
 system_ss.add(when: 'CONFIG_VFIO', if_true: files(
-  'helpers.c',
   'container-base.c',
   'migration.c',
   'migration-multifd.c',
-- 
2.48.1


