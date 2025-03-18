Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B9CC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 09:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuTgL-00061M-39; Tue, 18 Mar 2025 05:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTg8-0005Dy-8E
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:56:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTg2-0002Q0-1q
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742291761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VEUGgV3wY/Dy5IyTAhePWZilw36mrAFjIhmsA57AOtA=;
 b=N91bghofAYcLbUf8UxodaoJAq3/PwahhtgP6xcWn29eyNmG4DlPbTpUhDe+7nprW4kzdsO
 507dvPqWW8w31D71NSLiqgEoa+prcK1REXKDARs0Eb2Ng9xi/7D0HsL1ydjrpW384b70+H
 6nb9/uMz7V2oKZ2g6Fm4ZbIXrvxUX9Y=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-lP4son0NN6edbRnZZy6g0A-1; Tue,
 18 Mar 2025 05:55:57 -0400
X-MC-Unique: lP4son0NN6edbRnZZy6g0A-1
X-Mimecast-MFC-AGG-ID: lP4son0NN6edbRnZZy6g0A_1742291756
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE94E1955E98; Tue, 18 Mar 2025 09:55:56 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F5CB1828A83; Tue, 18 Mar 2025 09:55:53 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 24/32] vfio: Introduce new files for dirty tracking
 definitions and declarations
Date: Tue, 18 Mar 2025 10:54:07 +0100
Message-ID: <20250318095415.670319-25-clg@redhat.com>
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

File "common.c" has been emptied of most of its definitions by the
previous changes and the only definitions left are related to dirty
tracking. Rename it to "dirty-tracking.c" and introduce its associated
"dirty-tracking.h" header file for the declarations.

Cleanup a little the includes while at it.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/dirty-tracking.h               | 22 ++++++++++++++++++++++
 include/hw/vfio/vfio-common.h          | 10 ----------
 hw/vfio/container.c                    |  1 +
 hw/vfio/{common.c => dirty-tracking.c} |  5 +----
 hw/vfio/iommufd.c                      |  1 +
 hw/vfio/meson.build                    |  2 +-
 hw/vfio/trace-events                   |  2 +-
 7 files changed, 27 insertions(+), 16 deletions(-)
 create mode 100644 hw/vfio/dirty-tracking.h
 rename hw/vfio/{common.c => dirty-tracking.c} (99%)

diff --git a/hw/vfio/dirty-tracking.h b/hw/vfio/dirty-tracking.h
new file mode 100644
index 0000000000000000000000000000000000000000..4b83dc54ab50dabfff040d7cc3db27b80bfe2d3a
--- /dev/null
+++ b/hw/vfio/dirty-tracking.h
@@ -0,0 +1,22 @@
+/*
+ * VFIO dirty page tracking routines
+ *
+ * Copyright Red Hat, Inc. 2025
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_VFIO_DIRTY_TRACKING_H
+#define HW_VFIO_DIRTY_TRACKING_H
+
+extern const MemoryListener vfio_memory_listener;
+
+bool vfio_devices_all_dirty_tracking_started(const VFIOContainerBase *bcontainer);
+bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
+int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
+                                    VFIOBitmap *vbmap, hwaddr iova, hwaddr size,
+                                    Error **errp);
+int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
+                          uint64_t size, ram_addr_t ram_addr, Error **errp);
+
+#endif /* HW_VFIO_DIRTY_TRACKING_H */
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 184a422916f62259158e8759efc473a5efb2b2f7..cc20110d9de8ac173b67e6e878d4d61818497426 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -130,7 +130,6 @@ VFIODevice *vfio_get_vfio_device(Object *obj);
 
 typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
 extern VFIODeviceList vfio_device_list;
-extern const MemoryListener vfio_memory_listener;
 
 #ifdef CONFIG_LINUX
 int vfio_get_region_info(VFIODevice *vbasedev, int index,
@@ -140,15 +139,6 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
 bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type);
 #endif
 
-bool vfio_devices_all_dirty_tracking_started(
-    const VFIOContainerBase *bcontainer);
-bool
-vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
-int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
-                VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
-int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
-                          uint64_t size, ram_addr_t ram_addr, Error **errp);
-
 /* Returns 0 on success, or a negative errno. */
 bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 4e41a7476549a0c5e464e499d059db5aca6e3470..e88dfe12edd6dee469c06ee2e46ab9c8b5019ae7 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -35,6 +35,7 @@
 #include "hw/vfio/vfio-container.h"
 #include "helpers.h"
 #include "cpr.h"
+#include "dirty-tracking.h"
 
 #define TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO TYPE_HOST_IOMMU_DEVICE "-legacy-vfio"
 
diff --git a/hw/vfio/common.c b/hw/vfio/dirty-tracking.c
similarity index 99%
rename from hw/vfio/common.c
rename to hw/vfio/dirty-tracking.c
index ed2f2ed8839caaf40fabb0cbbcaa1df2c5b70d67..441f9d9a08c06a88dda44ef143dcee5f0a89a900 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/dirty-tracking.c
@@ -20,14 +20,10 @@
 
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
-#ifdef CONFIG_KVM
-#include <linux/kvm.h>
-#endif
 #include <linux/vfio.h>
 
 #include "hw/vfio/vfio-common.h"
 #include "hw/vfio/pci.h"
-#include "exec/address-spaces.h"
 #include "exec/memory.h"
 #include "exec/ram_addr.h"
 #include "exec/target_page.h"
@@ -45,6 +41,7 @@
 #include "system/tpm.h"
 #include "migration.h"
 #include "helpers.h"
+#include "dirty-tracking.h"
 
 /*
  * Device state interfaces
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index b25f3b4086d7b7fc6fcd519a9b8b2904513a655f..9335a17920b32dc2bf9cb4eeb2b8f57382f14ac8 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -29,6 +29,7 @@
 #include "iommufd.h"
 #include "helpers.h"
 #include "cpr.h"
+#include "dirty-tracking.h"
 
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO             \
             TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 1f89bd28c13dea55bcfff476ce99d51b453d8533..b6f5a7eeeda035b5872c2a19f8086384e000f420 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -1,6 +1,6 @@
 vfio_ss = ss.source_set()
 vfio_ss.add(files(
-  'common.c',
+  'dirty-tracking.c',
   'container.c',
   'helpers.c',
 ))
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index a1d01e9dde6ec52964d4804e9cbce5a6a32b7879..f3bdcebe938dcca77b913ef81a74644c622b5d8a 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -89,7 +89,7 @@ vfio_pci_igd_bdsm_enabled(const char *name, int size) "%s %dMB"
 vfio_pci_igd_host_bridge_enabled(const char *name) "%s"
 vfio_pci_igd_lpc_bridge_enabled(const char *name) "%s"
 
-# common.c
+# dirty-tracking.c
 vfio_iommu_map_notify(const char *op, uint64_t iova_start, uint64_t iova_end) "iommu %s @ 0x%"PRIx64" - 0x%"PRIx64
 vfio_listener_region_skip(const char *name, uint64_t start, uint64_t end) "SKIPPING %s 0x%"PRIx64" - 0x%"PRIx64
 vfio_spapr_group_attach(int groupfd, int tablefd) "Attached groupfd %d to liobn fd %d"
-- 
2.48.1


