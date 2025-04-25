Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D01D9C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Eis-0002sv-LF; Fri, 25 Apr 2025 04:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Eip-0002rU-IX
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:47:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Eil-0003EL-6K
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ku80WnsyoY1yoKJVZbi1RE32bDtPSkPy28YgWR2YXGE=;
 b=MwITkoqgmQDd99EnPId/mCR2ctfhvAOmb4jYnVXeHERYCjEdx0Q4meRtYPfYvJgC4Rw0ET
 F9jbJmIgHkDdLnsK1bjRfpRwwCjYO40aSo0quH9fM9BPWkZ/G/w6xOtDm2DQnAZYf6y0gQ
 vMwy4aERtKJBbcFU1I7WiY5XxEgmxic=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-UJ2lJQuFPaCkK0J4QNFL5g-1; Fri,
 25 Apr 2025 04:47:35 -0400
X-MC-Unique: UJ2lJQuFPaCkK0J4QNFL5g-1
X-Mimecast-MFC-AGG-ID: UJ2lJQuFPaCkK0J4QNFL5g_1745570854
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 180431956087; Fri, 25 Apr 2025 08:47:34 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3A0E930001A2; Fri, 25 Apr 2025 08:47:31 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PULL 12/50] vfio: Introduce a new header file for VFIOdisplay
 declarations
Date: Fri, 25 Apr 2025 10:46:05 +0200
Message-ID: <20250425084644.102196-13-clg@redhat.com>
In-Reply-To: <20250425084644.102196-1-clg@redhat.com>
References: <20250425084644.102196-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

Gather all VFIOdisplay related declarations into "vfio-display.h" to
reduce exposure of VFIO internals in "hw/vfio/vfio-common.h".

Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-8-clg@redhat.com
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-9-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h                 |  1 +
 hw/vfio/vfio-display.h        | 41 +++++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h | 28 ------------------------
 hw/vfio/display.c             |  2 +-
 4 files changed, 43 insertions(+), 29 deletions(-)
 create mode 100644 hw/vfio/vfio-display.h

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 6c59300248f279f56cff46874085992eeb3f82f9..62fd5f49978845ba24613ada972e625e629c5080 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -20,6 +20,7 @@
 #include "qemu/timer.h"
 #include "qom/object.h"
 #include "system/kvm.h"
+#include "vfio-display.h"
 
 #define PCI_ANY_ID (~0)
 
diff --git a/hw/vfio/vfio-display.h b/hw/vfio/vfio-display.h
new file mode 100644
index 0000000000000000000000000000000000000000..99b8cb67ef7558d3eefe3105a831e3fcb30afc4d
--- /dev/null
+++ b/hw/vfio/vfio-display.h
@@ -0,0 +1,41 @@
+/*
+ * VFIO display
+ *
+ * Copyright Red Hat, Inc. 2025
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_VFIO_VFIO_DISPLAY_H
+#define HW_VFIO_VFIO_DISPLAY_H
+
+#include "ui/console.h"
+#include "hw/display/ramfb.h"
+
+typedef struct VFIODMABuf {
+    QemuDmaBuf *buf;
+    uint32_t pos_x, pos_y, pos_updates;
+    uint32_t hot_x, hot_y, hot_updates;
+    int dmabuf_id;
+    QTAILQ_ENTRY(VFIODMABuf) next;
+} VFIODMABuf;
+
+typedef struct VFIODisplay {
+    QemuConsole *con;
+    RAMFBState *ramfb;
+    struct vfio_region_info *edid_info;
+    struct vfio_region_gfx_edid *edid_regs;
+    uint8_t *edid_blob;
+    QEMUTimer *edid_link_timer;
+    struct {
+        VFIORegion buffer;
+        DisplaySurface *surface;
+    } region;
+    struct {
+        QTAILQ_HEAD(, VFIODMABuf) bufs;
+        VFIODMABuf *primary;
+        VFIODMABuf *cursor;
+    } dmabuf;
+} VFIODisplay;
+
+#endif /* HW_VFIO_VFIO_DISPLAY_H */
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index fa0b74d5eac53cc49e9da97007cc36ca7b8d8611..528eafadf9f2886d567584c45cc3fc749ef8ddd7 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -23,8 +23,6 @@
 
 #include "system/memory.h"
 #include "qemu/queue.h"
-#include "ui/console.h"
-#include "hw/display/ramfb.h"
 #ifdef CONFIG_LINUX
 #include <linux/vfio.h>
 #endif
@@ -182,32 +180,6 @@ typedef struct VFIOGroup {
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO \
             TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
 
-typedef struct VFIODMABuf {
-    QemuDmaBuf *buf;
-    uint32_t pos_x, pos_y, pos_updates;
-    uint32_t hot_x, hot_y, hot_updates;
-    int dmabuf_id;
-    QTAILQ_ENTRY(VFIODMABuf) next;
-} VFIODMABuf;
-
-typedef struct VFIODisplay {
-    QemuConsole *con;
-    RAMFBState *ramfb;
-    struct vfio_region_info *edid_info;
-    struct vfio_region_gfx_edid *edid_regs;
-    uint8_t *edid_blob;
-    QEMUTimer *edid_link_timer;
-    struct {
-        VFIORegion buffer;
-        DisplaySurface *surface;
-    } region;
-    struct {
-        QTAILQ_HEAD(, VFIODMABuf) bufs;
-        VFIODMABuf *primary;
-        VFIODMABuf *cursor;
-    } dmabuf;
-} VFIODisplay;
-
 VFIOAddressSpace *vfio_get_address_space(AddressSpace *as);
 void vfio_put_address_space(VFIOAddressSpace *space);
 void vfio_address_space_insert(VFIOAddressSpace *space,
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 4fdcef505da59477e52df14ff9e611797bac162c..70cfd685bd049aadf97b73d06086a0e44eb3f9cb 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -16,9 +16,9 @@
 
 #include "qemu/error-report.h"
 #include "hw/display/edid.h"
-#include "ui/console.h"
 #include "qapi/error.h"
 #include "pci.h"
+#include "vfio-display.h"
 #include "trace.h"
 
 #ifndef DRM_PLANE_TYPE_PRIMARY
-- 
2.49.0


