Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553C2C021A2
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 14:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thrKp-0006S0-HH; Tue, 11 Feb 2025 09:33:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thrKn-0006R5-3h
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 09:33:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thrKl-0001sM-0T
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 09:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739284434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LR3a9Hsz2ORFTdSz+PBwkbusc7qS/KoezzL1HBR2I3g=;
 b=idwB9xGwap5YIywnt3kijziNreThkCLwVVa/3zM0RIAMrbpwEIbtGNp/wvn15aFCbHCx/i
 v3O4BVEd5d/csRKlxEWBEw4u/hYiYzNgovnTmGL9t7O/Ec3H6vWiIz/C5vDIRF6QmuPQbN
 upNGEIDbEeO20MANeClhOYBNRUDu3Ag=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-rjZZeqPiPaOqIPGdIJgyzw-1; Tue,
 11 Feb 2025 09:33:52 -0500
X-MC-Unique: rjZZeqPiPaOqIPGdIJgyzw-1
X-Mimecast-MFC-AGG-ID: rjZZeqPiPaOqIPGdIJgyzw
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73E361956094; Tue, 11 Feb 2025 14:33:51 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.39])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 013A91800570; Tue, 11 Feb 2025 14:33:49 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 02/12] vfio/pci: declare generic quirks in a new header file
Date: Tue, 11 Feb 2025 15:33:30 +0100
Message-ID: <20250211143340.787996-3-clg@redhat.com>
In-Reply-To: <20250211143340.787996-1-clg@redhat.com>
References: <20250211143340.787996-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
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

From: Tomita Moeko <tomitamoeko@gmail.com>

Declare generic vfio_generic_{window_address,window_data,mirror}_quirk
in newly created pci_quirks.h so that they can be used elsewhere, like
igd.c.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/r/20250104154219.7209-2-tomitamoeko@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci-quirks.h | 71 ++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci-quirks.c | 55 +++-------------------------------
 2 files changed, 75 insertions(+), 51 deletions(-)
 create mode 100644 hw/vfio/pci-quirks.h

diff --git a/hw/vfio/pci-quirks.h b/hw/vfio/pci-quirks.h
new file mode 100644
index 0000000000000000000000000000000000000000..c0e96a01cc64bd82013d6bd87adb7ce3d31bf060
--- /dev/null
+++ b/hw/vfio/pci-quirks.h
@@ -0,0 +1,71 @@
+/*
+ * vfio generic region quirks (mostly backdoors to PCI config space)
+ *
+ * Copyright Red Hat, Inc. 2012-2015
+ *
+ * Authors:
+ *  Alex Williamson <alex.williamson@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ */
+#ifndef HW_VFIO_VFIO_PCI_QUIRKS_H
+#define HW_VFIO_VFIO_PCI_QUIRKS_H
+
+#include "qemu/osdep.h"
+#include "exec/memop.h"
+
+/*
+ * The generic window quirks operate on an address and data register,
+ * vfio_generic_window_address_quirk handles the address register and
+ * vfio_generic_window_data_quirk handles the data register.  These ops
+ * pass reads and writes through to hardware until a value matching the
+ * stored address match/mask is written.  When this occurs, the data
+ * register access emulated PCI config space for the device rather than
+ * passing through accesses.  This enables devices where PCI config space
+ * is accessible behind a window register to maintain the virtualization
+ * provided through vfio.
+ */
+typedef struct VFIOConfigWindowMatch {
+    uint32_t match;
+    uint32_t mask;
+} VFIOConfigWindowMatch;
+
+typedef struct VFIOConfigWindowQuirk {
+    struct VFIOPCIDevice *vdev;
+
+    uint32_t address_val;
+
+    uint32_t address_offset;
+    uint32_t data_offset;
+
+    bool window_enabled;
+    uint8_t bar;
+
+    MemoryRegion *addr_mem;
+    MemoryRegion *data_mem;
+
+    uint32_t nr_matches;
+    VFIOConfigWindowMatch matches[];
+} VFIOConfigWindowQuirk;
+
+extern const MemoryRegionOps vfio_generic_window_address_quirk;
+extern const MemoryRegionOps vfio_generic_window_data_quirk;
+
+/*
+ * The generic mirror quirk handles devices which expose PCI config space
+ * through a region within a BAR.  When enabled, reads and writes are
+ * redirected through to emulated PCI config space.  XXX if PCI config space
+ * used memory regions, this could just be an alias.
+ */
+typedef struct VFIOConfigMirrorQuirk {
+    struct VFIOPCIDevice *vdev;
+    uint32_t offset;
+    uint8_t bar;
+    MemoryRegion *mem;
+    uint8_t data[];
+} VFIOConfigMirrorQuirk;
+
+extern const MemoryRegionOps vfio_generic_mirror_quirk;
+
+#endif /* HW_VFIO_VFIO_PCI_QUIRKS_H */
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index c8e60475d5166593f012e0d87993de3801920411..2258fdda5f1fd4ae4f57fd163beb24bfe2116717 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -25,6 +25,7 @@
 #include "hw/nvram/fw_cfg.h"
 #include "hw/qdev-properties.h"
 #include "pci.h"
+#include "pci-quirks.h"
 #include "trace.h"
 
 /*
@@ -66,40 +67,6 @@ bool vfio_opt_rom_in_denylist(VFIOPCIDevice *vdev)
  * Device specific region quirks (mostly backdoors to PCI config space)
  */
 
-/*
- * The generic window quirks operate on an address and data register,
- * vfio_generic_window_address_quirk handles the address register and
- * vfio_generic_window_data_quirk handles the data register.  These ops
- * pass reads and writes through to hardware until a value matching the
- * stored address match/mask is written.  When this occurs, the data
- * register access emulated PCI config space for the device rather than
- * passing through accesses.  This enables devices where PCI config space
- * is accessible behind a window register to maintain the virtualization
- * provided through vfio.
- */
-typedef struct VFIOConfigWindowMatch {
-    uint32_t match;
-    uint32_t mask;
-} VFIOConfigWindowMatch;
-
-typedef struct VFIOConfigWindowQuirk {
-    struct VFIOPCIDevice *vdev;
-
-    uint32_t address_val;
-
-    uint32_t address_offset;
-    uint32_t data_offset;
-
-    bool window_enabled;
-    uint8_t bar;
-
-    MemoryRegion *addr_mem;
-    MemoryRegion *data_mem;
-
-    uint32_t nr_matches;
-    VFIOConfigWindowMatch matches[];
-} VFIOConfigWindowQuirk;
-
 static uint64_t vfio_generic_window_quirk_address_read(void *opaque,
                                                        hwaddr addr,
                                                        unsigned size)
@@ -135,7 +102,7 @@ static void vfio_generic_window_quirk_address_write(void *opaque, hwaddr addr,
     }
 }
 
-static const MemoryRegionOps vfio_generic_window_address_quirk = {
+const MemoryRegionOps vfio_generic_window_address_quirk = {
     .read = vfio_generic_window_quirk_address_read,
     .write = vfio_generic_window_quirk_address_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
@@ -178,26 +145,12 @@ static void vfio_generic_window_quirk_data_write(void *opaque, hwaddr addr,
                       addr + window->data_offset, data, size);
 }
 
-static const MemoryRegionOps vfio_generic_window_data_quirk = {
+const MemoryRegionOps vfio_generic_window_data_quirk = {
     .read = vfio_generic_window_quirk_data_read,
     .write = vfio_generic_window_quirk_data_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-/*
- * The generic mirror quirk handles devices which expose PCI config space
- * through a region within a BAR.  When enabled, reads and writes are
- * redirected through to emulated PCI config space.  XXX if PCI config space
- * used memory regions, this could just be an alias.
- */
-typedef struct VFIOConfigMirrorQuirk {
-    struct VFIOPCIDevice *vdev;
-    uint32_t offset;
-    uint8_t bar;
-    MemoryRegion *mem;
-    uint8_t data[];
-} VFIOConfigMirrorQuirk;
-
 static uint64_t vfio_generic_quirk_mirror_read(void *opaque,
                                                hwaddr addr, unsigned size)
 {
@@ -228,7 +181,7 @@ static void vfio_generic_quirk_mirror_write(void *opaque, hwaddr addr,
                                           addr, data);
 }
 
-static const MemoryRegionOps vfio_generic_mirror_quirk = {
+const MemoryRegionOps vfio_generic_mirror_quirk = {
     .read = vfio_generic_quirk_mirror_read,
     .write = vfio_generic_quirk_mirror_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
-- 
2.48.1


