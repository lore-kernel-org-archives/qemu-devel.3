Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC08CC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 09:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuTfI-0004GV-Vn; Tue, 18 Mar 2025 05:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTfG-0004Fr-Rz
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:55:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTfE-0002HS-Ey
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742291711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WP7LL0ODjYpEMaOhkGwzW2aOxOYEleLkXCMa29Sjc9Q=;
 b=CBlQnHtnknIOYptcRLEydT1gxVNM361kexCpclNYVgE21yvKstR+S4W3AHzB4bPOJakA4T
 IaIOmYfCoCbCwlgMBeDn+zwi6MQLKRZOUTP4p2lGvjD2f/dYTocPM8P7vuWc3YHPpBfESO
 +Xvwl1JDM+9SziColgerT74xLeoJDXM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-4gpUmmH1NDa1lvBtLT08Uw-1; Tue,
 18 Mar 2025 05:55:08 -0400
X-MC-Unique: 4gpUmmH1NDa1lvBtLT08Uw-1
X-Mimecast-MFC-AGG-ID: 4gpUmmH1NDa1lvBtLT08Uw_1742291707
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E214D1955DCF; Tue, 18 Mar 2025 09:55:06 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 641A41828A84; Tue, 18 Mar 2025 09:55:04 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 06/32] vfio: Introduce a new header file for internal
 migration services
Date: Tue, 18 Mar 2025 10:53:49 +0100
Message-ID: <20250318095415.670319-7-clg@redhat.com>
In-Reply-To: <20250318095415.670319-1-clg@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Gather all VFIO migration related declarations into "migration.h" to
reduce exposure of VFIO internals in "hw/vfio/vfio-common.h".

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/migration.h           | 72 +++++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h | 54 +-------------------------
 hw/vfio/common.c              | 17 +--------
 hw/vfio/iommufd.c             |  1 +
 hw/vfio/migration-multifd.c   |  1 +
 hw/vfio/migration.c           | 17 +++++++++
 hw/vfio/pci.c                 |  1 +
 7 files changed, 94 insertions(+), 69 deletions(-)
 create mode 100644 hw/vfio/migration.h

diff --git a/hw/vfio/migration.h b/hw/vfio/migration.h
new file mode 100644
index 0000000000000000000000000000000000000000..7ad2141d06a7c97f034db908f9ce19fd06f415b9
--- /dev/null
+++ b/hw/vfio/migration.h
@@ -0,0 +1,72 @@
+/*
+ * VFIO migration
+ *
+ * Copyright Red Hat, Inc. 2025
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_VFIO_MIGRATION_H
+#define HW_VFIO_MIGRATION_H
+
+#ifdef CONFIG_LINUX
+#include <linux/vfio.h>
+#endif
+
+#include "qemu/notify.h"
+
+/*
+ * Flags to be used as unique delimiters for VFIO devices in the migration
+ * stream. These flags are composed as:
+ * 0xffffffff => MSB 32-bit all 1s
+ * 0xef10     => Magic ID, represents emulated (virtual) function IO
+ * 0x0000     => 16-bits reserved for flags
+ *
+ * The beginning of state information is marked by _DEV_CONFIG_STATE,
+ * _DEV_SETUP_STATE, or _DEV_DATA_STATE, respectively. The end of a
+ * certain state information is marked by _END_OF_STATE.
+ */
+#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
+#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
+#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
+#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
+#define VFIO_MIG_FLAG_DEV_INIT_DATA_SENT (0xffffffffef100005ULL)
+
+typedef struct VFIODevice VFIODevice;
+typedef struct VFIOMultifd VFIOMultifd;
+
+typedef struct VFIOMigration {
+    struct VFIODevice *vbasedev;
+    VMChangeStateEntry *vm_state;
+    NotifierWithReturn migration_state;
+    uint32_t device_state;
+    int data_fd;
+    void *data_buffer;
+    size_t data_buffer_size;
+    uint64_t mig_flags;
+    uint64_t precopy_init_size;
+    uint64_t precopy_dirty_size;
+    bool multifd_transfer;
+    VFIOMultifd *multifd;
+    bool initial_data_sent;
+
+    bool event_save_iterate_started;
+    bool event_precopy_empty_hit;
+} VFIOMigration;
+
+
+bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
+void vfio_migration_exit(VFIODevice *vbasedev);
+bool vfio_device_state_is_running(VFIODevice *vbasedev);
+bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
+int vfio_save_device_config_state(QEMUFile *f, void *opaque, Error **errp);
+int vfio_load_device_config_state(QEMUFile *f, void *opaque);
+
+#ifdef CONFIG_LINUX
+int vfio_migration_set_state(VFIODevice *vbasedev,
+                             enum vfio_device_mig_state new_state,
+                             enum vfio_device_mig_state recover_state,
+                             Error **errp);
+#endif
+
+#endif /* HW_VFIO_MIGRATION_H */
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 0aae88131cffda1a90b8ccd0224387133c0fa83a..799e12d43747addbf444c15052f629b65978322f 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -23,7 +23,6 @@
 
 #include "exec/memory.h"
 #include "qemu/queue.h"
-#include "qemu/notify.h"
 #include "ui/console.h"
 #include "hw/display/ramfb.h"
 #ifdef CONFIG_LINUX
@@ -36,23 +35,6 @@
 
 #define VFIO_MSG_PREFIX "vfio %s: "
 
-/*
- * Flags to be used as unique delimiters for VFIO devices in the migration
- * stream. These flags are composed as:
- * 0xffffffff => MSB 32-bit all 1s
- * 0xef10     => Magic ID, represents emulated (virtual) function IO
- * 0x0000     => 16-bits reserved for flags
- *
- * The beginning of state information is marked by _DEV_CONFIG_STATE,
- * _DEV_SETUP_STATE, or _DEV_DATA_STATE, respectively. The end of a
- * certain state information is marked by _END_OF_STATE.
- */
-#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
-#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
-#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
-#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
-#define VFIO_MIG_FLAG_DEV_INIT_DATA_SENT (0xffffffffef100005ULL)
-
 enum {
     VFIO_DEVICE_TYPE_PCI = 0,
     VFIO_DEVICE_TYPE_PLATFORM = 1,
@@ -78,27 +60,6 @@ typedef struct VFIORegion {
     uint8_t nr; /* cache the region number for debug */
 } VFIORegion;
 
-typedef struct VFIOMultifd VFIOMultifd;
-
-typedef struct VFIOMigration {
-    struct VFIODevice *vbasedev;
-    VMChangeStateEntry *vm_state;
-    NotifierWithReturn migration_state;
-    uint32_t device_state;
-    int data_fd;
-    void *data_buffer;
-    size_t data_buffer_size;
-    uint64_t mig_flags;
-    uint64_t precopy_init_size;
-    uint64_t precopy_dirty_size;
-    bool multifd_transfer;
-    VFIOMultifd *multifd;
-    bool initial_data_sent;
-
-    bool event_save_iterate_started;
-    bool event_precopy_empty_hit;
-} VFIOMigration;
-
 struct VFIOGroup;
 
 typedef struct VFIOContainer {
@@ -136,6 +97,7 @@ typedef struct VFIOIOMMUFDContainer {
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer, VFIO_IOMMU_IOMMUFD);
 
 typedef struct VFIODeviceOps VFIODeviceOps;
+typedef struct VFIOMigration VFIOMigration;
 
 typedef struct VFIODevice {
     QLIST_ENTRY(VFIODevice) next;
@@ -290,12 +252,6 @@ extern VFIODeviceList vfio_device_list;
 extern const MemoryListener vfio_memory_listener;
 extern int vfio_kvm_device_fd;
 
-bool vfio_device_state_is_running(VFIODevice *vbasedev);
-bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
-
-int vfio_save_device_config_state(QEMUFile *f, void *opaque, Error **errp);
-int vfio_load_device_config_state(QEMUFile *f, void *opaque);
-
 #ifdef CONFIG_LINUX
 int vfio_get_region_info(VFIODevice *vbasedev, int index,
                          struct vfio_region_info **info);
@@ -310,16 +266,8 @@ struct vfio_info_cap_header *
 vfio_get_device_info_cap(struct vfio_device_info *info, uint16_t id);
 struct vfio_info_cap_header *
 vfio_get_cap(void *ptr, uint32_t cap_offset, uint16_t id);
-
-int vfio_migration_set_state(VFIODevice *vbasedev,
-                             enum vfio_device_mig_state new_state,
-                             enum vfio_device_mig_state recover_state,
-                             Error **errp);
 #endif
 
-bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
-void vfio_migration_exit(VFIODevice *vbasedev);
-
 int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size);
 bool vfio_devices_all_dirty_tracking_started(
     const VFIOContainerBase *bcontainer);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 0b9b071cd0490867bb6aa4ceb261350ccd6e1125..0e3746eddd1c08e98bf57a59d542e158487d346e 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -44,6 +44,7 @@
 #include "migration/qemu-file.h"
 #include "system/tcg.h"
 #include "system/tpm.h"
+#include "migration.h"
 
 VFIODeviceList vfio_device_list =
     QLIST_HEAD_INITIALIZER(vfio_device_list);
@@ -72,22 +73,6 @@ static void vfio_set_migration_error(int ret)
     }
 }
 
-bool vfio_device_state_is_running(VFIODevice *vbasedev)
-{
-    VFIOMigration *migration = vbasedev->migration;
-
-    return migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
-           migration->device_state == VFIO_DEVICE_STATE_RUNNING_P2P;
-}
-
-bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
-{
-    VFIOMigration *migration = vbasedev->migration;
-
-    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY ||
-           migration->device_state == VFIO_DEVICE_STATE_PRE_COPY_P2P;
-}
-
 static bool vfio_devices_all_device_dirty_tracking_started(
     const VFIOContainerBase *bcontainer)
 {
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 42c8412bbf50724dddb43f9b19a3aa40c8bc311d..2fb2a01ec6d29dbc284cfd9830c24e78ce560dd0 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -25,6 +25,7 @@
 #include "qemu/cutils.h"
 #include "qemu/chardev_open.h"
 #include "pci.h"
+#include "migration.h"
 
 static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly)
diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index fe84735ec2c7bd085820d25c06be558761fbe0d5..285f9a9a18dd8f0847ac5ac3fdaa304779a2d0db 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -22,6 +22,7 @@
 #include "io/channel-buffer.h"
 #include "migration/qemu-file.h"
 #include "migration-multifd.h"
+#include "migration.h"
 #include "trace.h"
 
 #define VFIO_DEVICE_STATE_CONFIG_STATE (1)
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index a1ba993ce549fce0d2a9a60ba07d4782c87c0c09..46c4cfecce25ba1146a1d8f2de0d7c51425afe8e 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -31,6 +31,7 @@
 #include "pci.h"
 #include "trace.h"
 #include "hw/hw.h"
+#include "migration.h"
 
 /*
  * This is an arbitrary size based on migration of mlx5 devices, where typically
@@ -1222,3 +1223,19 @@ void vfio_migration_exit(VFIODevice *vbasedev)
 
     migrate_del_blocker(&vbasedev->migration_blocker);
 }
+
+bool vfio_device_state_is_running(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+
+    return migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
+           migration->device_state == VFIO_DEVICE_STATE_RUNNING_P2P;
+}
+
+bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+
+    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY ||
+           migration->device_state == VFIO_DEVICE_STATE_PRE_COPY_P2P;
+}
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 7f1532fbed9aed2eae2c98f6fd79a9056ff1e84f..3612f6fe7d0864fe3789f4ea221da01ef87d0664 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -44,6 +44,7 @@
 #include "migration/blocker.h"
 #include "migration/qemu-file.h"
 #include "system/iommufd.h"
+#include "migration.h"
 
 #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
 
-- 
2.48.1


