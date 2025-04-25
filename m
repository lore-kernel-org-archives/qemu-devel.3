Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13241C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8EjY-0003vb-PS; Fri, 25 Apr 2025 04:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EjI-0003SF-KE
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:48:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EjE-0003Gh-FU
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s30yRNqQjluROqGY+qZrtxBuCfrpV+9NHGTuq8+0ywE=;
 b=BaoUTIijxnKGu8Tu8eokvaWVx6Loo/HWciRcfkFIgKjDPy3/nxPCUmWgDn4Y0mO7iiVF6O
 DuYQV1KJun3ugbkGqZx0T+TZGyL1ua0e4ArvDkfuKoAjhjuuejajbuPdVqpF6dpAO0u51G
 LruJdS0pATR2sz3xgdOb0UfdxWKDCgY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-z41OSc6xMUKUg0l1n6CXEg-1; Fri,
 25 Apr 2025 04:48:06 -0400
X-MC-Unique: z41OSc6xMUKUg0l1n6CXEg-1
X-Mimecast-MFC-AGG-ID: z41OSc6xMUKUg0l1n6CXEg_1745570885
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B466A1800876; Fri, 25 Apr 2025 08:48:05 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 67A3130001A2; Fri, 25 Apr 2025 08:48:03 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PULL 22/50] vfio: Move vfio_kvm_device_add/del_fd() to helpers.c
Date: Fri, 25 Apr 2025 10:46:15 +0200
Message-ID: <20250425084644.102196-23-clg@redhat.com>
In-Reply-To: <20250425084644.102196-1-clg@redhat.com>
References: <20250425084644.102196-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

vfio_kvm_device_add/del_fd() are low level routines. Move them with
the other helpers.

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-18-clg@redhat.com
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-19-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/vfio-helpers.h        |  3 ++
 include/hw/vfio/vfio-common.h |  3 --
 hw/vfio/common.c              | 58 ----------------------------------
 hw/vfio/helpers.c             | 59 +++++++++++++++++++++++++++++++++++
 hw/vfio/iommufd.c             |  1 +
 hw/vfio/meson.build           |  2 +-
 6 files changed, 64 insertions(+), 62 deletions(-)

diff --git a/hw/vfio/vfio-helpers.h b/hw/vfio/vfio-helpers.h
index 9af43878b8b90c0247221543423a5aca8be2eef5..5d91e33d27be1bdd8eb9b3ce74c39a4ac1991adc 100644
--- a/hw/vfio/vfio-helpers.h
+++ b/hw/vfio/vfio-helpers.h
@@ -26,4 +26,7 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
 
 int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size);
 
+int vfio_kvm_device_add_fd(int fd, Error **errp);
+int vfio_kvm_device_del_fd(int fd, Error **errp);
+
 #endif /* HW_VFIO_VFIO_HELPERS_H */
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index be2558f7e4e1e577caf69ee98798e490e80be96b..442ec287d799538e1d3669a6c470960cce5459a0 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -130,9 +130,6 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
 void vfio_detach_device(VFIODevice *vbasedev);
 VFIODevice *vfio_get_vfio_device(Object *obj);
 
-int vfio_kvm_device_add_fd(int fd, Error **errp);
-int vfio_kvm_device_del_fd(int fd, Error **errp);
-
 bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
 void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 18e5aacbd1b5e8033221df99999739cd58c883b0..2b3af051cc46118799b882a9a8e3ae96e556952b 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1333,64 +1333,6 @@ void vfio_reset_handler(void *opaque)
     }
 }
 
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
index 1a584ba5f007995a16d2364faeb72cb2b22de4e9..e6b75baa805241b4df28769338b15a6fe9b99501 100644
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
index 2ec15bc2692e2eb90299e5a1c09ab6b738c69cf0..85b5a8146ac401af6be8109c28ea4c7a39e84521 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -26,6 +26,7 @@
 #include "qemu/chardev_open.h"
 #include "pci.h"
 #include "vfio-iommufd.h"
+#include "vfio-helpers.h"
 
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
2.49.0


