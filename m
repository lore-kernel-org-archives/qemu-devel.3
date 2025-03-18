Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E85C35FF8
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 09:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuTfN-0004IM-Ds; Tue, 18 Mar 2025 05:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTfK-0004Gj-Cs
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:55:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTfI-0002IE-Dx
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742291715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u0jhqhhyfoZE0zakWSUHeqQdsaLsa+hUV7crYG16SEc=;
 b=XDMCuk8sTHwBgCw6z1p0VijywpUvkg5KmNzoJH3l9/aXEtts6UONouuVlfc6psjWXbtWMF
 BVy+jC3JxUGHj6Yim4HnQqheFde0j//DAdQQfJGipxQkUbnpRz2BZ6PbQGB+6YimCN/wbs
 3h+ojoDlotKrhwMcwcDrq/ftkdAig/4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-1dK4fwHEP4-uz1tYHcxdMg-1; Tue,
 18 Mar 2025 05:55:10 -0400
X-MC-Unique: 1dK4fwHEP4-uz1tYHcxdMg-1
X-Mimecast-MFC-AGG-ID: 1dK4fwHEP4-uz1tYHcxdMg_1742291709
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 918BA1955DC5; Tue, 18 Mar 2025 09:55:09 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6A92218001EF; Tue, 18 Mar 2025 09:55:07 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 07/32] vfio: Introduce a new header file for
 VFIOdisplay declarations
Date: Tue, 18 Mar 2025 10:53:50 +0100
Message-ID: <20250318095415.670319-8-clg@redhat.com>
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

Gather all VFIOdisplay related declarations into "display.h" to
reduce exposure of VFIO internals in "hw/vfio/vfio-common.h".

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/display.h             | 41 +++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h                 |  1 +
 include/hw/vfio/vfio-common.h | 28 ------------------------
 hw/vfio/display.c             |  2 +-
 4 files changed, 43 insertions(+), 29 deletions(-)
 create mode 100644 hw/vfio/display.h

diff --git a/hw/vfio/display.h b/hw/vfio/display.h
new file mode 100644
index 0000000000000000000000000000000000000000..93a4df2dfa5b39946d700b3df76233f0d7b0343f
--- /dev/null
+++ b/hw/vfio/display.h
@@ -0,0 +1,41 @@
+/*
+ * VFIO display
+ *
+ * Copyright Red Hat, Inc. 2025
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_VFIO_DISPLAY_H
+#define HW_VFIO_DISPLAY_H
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
+#endif /* HW_VFIO_DISPLAY_H */
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index d94ecaba689c4681687c0a6796ffbcda522ae179..c84bba81487136d205ca30049c812d00e832c377 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -20,6 +20,7 @@
 #include "qemu/timer.h"
 #include "qom/object.h"
 #include "system/kvm.h"
+#include "display.h"
 
 #define PCI_ANY_ID (~0)
 
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 799e12d43747addbf444c15052f629b65978322f..288c2fb3d0e792427c0e7655002248829b4d189a 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -23,8 +23,6 @@
 
 #include "exec/memory.h"
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
index ea87830fe0d5fc66f3f27a16bde5d75b7b6280c0..2c06361c67cb074b88f2649b3b9fd21b7bacf07c 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -16,9 +16,9 @@
 
 #include "qemu/error-report.h"
 #include "hw/display/edid.h"
-#include "ui/console.h"
 #include "qapi/error.h"
 #include "pci.h"
+#include "display.h"
 #include "trace.h"
 
 #ifndef DRM_PLANE_TYPE_PRIMARY
-- 
2.48.1


