Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5861606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IT+71Z7z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQLL9-0002sK-TC; Mon, 09 Nov 2026 04:07:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xQLL0-0002hr-OS
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 04:06:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xQLKy-0002tW-AB
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 04:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794215206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bMqgMs09NZ1fTnxZ7vEX/RAjLX1amMYxtW6zAGIJ0Rg=;
 b=IT+71Z7zg1fEjq9JHc8uh+RTm9O81geUIOuV7vvZcgawm5UQeiMPtyfE5AUAX0N4LwN4mM
 UOZYsMZ5kIdqBqSbRm4Uva+h2RKfCYBS1OgLvvQvnQFvi4dwnG0RE35/PM6afUPoXZ+rii
 Lkr9VGVVs5AyFeD4RgzueVap52rx1nY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-WvDWVX5jNqmLVZfz6sx3FA-1; Mon,
 09 Nov 2026 04:06:44 -0500
X-MC-Unique: WvDWVX5jNqmLVZfz6sx3FA-1
X-Mimecast-MFC-AGG-ID: WvDWVX5jNqmLVZfz6sx3FA_1794215203
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB6571800544; Mon,  9 Nov 2026 09:06:43 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8FB7B30000E5; Mon,  9 Nov 2026 09:06:42 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-12.0 8/9] vfio/pci: Extract ROM handling into pci-rom.c
Date: Mon,  9 Nov 2026 10:06:24 +0100
Message-ID: <20261109090625.908592-9-clg@redhat.com>
In-Reply-To: <20261109090625.908592-1-clg@redhat.com>
References: <20261109090625.908592-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move ROM handling routines into a dedicated pci-rom.c file.

No functional change. Retain existing license 'GPL-2.0-only'.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h       |   1 +
 hw/vfio/pci-rom.c   | 239 ++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c       | 218 ----------------------------------------
 hw/vfio/meson.build |   1 +
 4 files changed, 241 insertions(+), 218 deletions(-)
 create mode 100644 hw/vfio/pci-rom.c

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index bcbb582c13d3..faf0e9dcf022 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -251,6 +251,7 @@ bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp);
 void vfio_pci_config_register_vga(VFIOPCIDevice *vdev);
 
 /* ROM */
+void vfio_pci_size_rom(VFIOPCIDevice *vdev);
 bool vfio_opt_rom_in_denylist(VFIOPCIDevice *vdev);
 
 /* VGA */
diff --git a/hw/vfio/pci-rom.c b/hw/vfio/pci-rom.c
new file mode 100644
index 000000000000..c8c59727bf7e
--- /dev/null
+++ b/hw/vfio/pci-rom.c
@@ -0,0 +1,239 @@
+/*
+ * vfio PCI device - ROM support
+ *
+ * Copyright Red Hat, Inc. 2012-2026
+ *
+ * Authors:
+ *  Alex Williamson <alex.williamson@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-only
+ */
+
+#include "qemu/osdep.h"
+#include <linux/vfio.h>
+
+#include "hw/core/hw-error.h"
+#include "hw/pci/pci_device.h"
+#include "qemu/error-report.h"
+#include "pci.h"
+#include "trace.h"
+#include "qapi/error.h"
+#include "vfio-helpers.h"
+
+static bool vfio_pci_load_rom(VFIOPCIDevice *vdev, Error **errp)
+{
+    VFIODevice *vbasedev = &vdev->vbasedev;
+    struct vfio_region_info *reg_info = NULL;
+    uint64_t size;
+    off_t off = 0;
+    ssize_t bytes;
+    int ret;
+
+    ret = vfio_device_get_region_info(vbasedev, VFIO_PCI_ROM_REGION_INDEX,
+                                      &reg_info);
+
+    if (ret != 0) {
+        error_setg_errno(errp, -ret, "vfio: Error getting ROM info");
+        return false;
+    }
+
+    trace_vfio_pci_load_rom(vbasedev->name, (unsigned long)reg_info->size,
+                            (unsigned long)reg_info->offset,
+                            (unsigned long)reg_info->flags);
+
+    vdev->rom_size = size = reg_info->size;
+    vdev->rom_offset = reg_info->offset;
+
+    if (!vdev->rom_size) {
+        vdev->rom_size = 0;
+        vdev->rom_offset = 0;
+        error_setg(errp, "vfio-pci: Device ROM size is zero at %s",
+                   vbasedev->name);
+        error_append_hint(errp, "Device option ROM contents are probably "
+                          "invalid (check dmesg).\nSkip option ROM probe "
+                          "with rombar=0, or load from file with romfile=\n");
+        return false;
+    }
+
+    vdev->rom = g_malloc(size);
+    memset(vdev->rom, 0xff, size);
+
+    while (size) {
+        bytes = vbasedev->io_ops->region_read(vbasedev,
+                                              VFIO_PCI_ROM_REGION_INDEX,
+                                              off, size, vdev->rom + off);
+
+        if (bytes == 0) {
+            break;
+        } else if (bytes > 0) {
+            off += bytes;
+            size -= bytes;
+        } else {
+            if (bytes == -EINTR || bytes == -EAGAIN) {
+                continue;
+            }
+            error_setg_errno(errp, -bytes, "vfio: Error reading device ROM");
+            g_free(vdev->rom);
+            vdev->rom = NULL;
+            vdev->rom_size = 0;
+            vdev->rom_offset = 0;
+            return false;
+        }
+    }
+
+    /*
+     * Test the ROM signature against our device, if the vendor is correct
+     * but the device ID doesn't match, store the correct device ID and
+     * recompute the checksum.  Intel IGD devices need this and are known
+     * to have bogus checksums so we can't simply adjust the checksum.
+     */
+    if (pci_get_word(vdev->rom) == 0xaa55 &&
+        pci_get_word(vdev->rom + 0x18) + 8 < vdev->rom_size &&
+        !memcmp(vdev->rom + pci_get_word(vdev->rom + 0x18), "PCIR", 4)) {
+        uint16_t vid, did;
+
+        vid = pci_get_word(vdev->rom + pci_get_word(vdev->rom + 0x18) + 4);
+        did = pci_get_word(vdev->rom + pci_get_word(vdev->rom + 0x18) + 6);
+
+        if (vid == vdev->vendor_id && did != vdev->device_id) {
+            int i;
+            uint8_t csum, *data = vdev->rom;
+
+            pci_set_word(vdev->rom + pci_get_word(vdev->rom + 0x18) + 6,
+                         vdev->device_id);
+            data[6] = 0;
+
+            for (csum = 0, i = 0; i < vdev->rom_size; i++) {
+                csum += data[i];
+            }
+
+            data[6] = -csum;
+        }
+    }
+
+    vfio_rom_quirk_setup(vdev);
+
+    return true;
+}
+
+static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
+{
+    VFIOPCIDevice *vdev = opaque;
+    union {
+        uint8_t byte;
+        uint16_t word;
+        uint32_t dword;
+        uint64_t qword;
+    } val = { .qword = ~0ULL };
+    uint64_t data = 0;
+
+    /* Load the ROM lazily when the guest tries to read it */
+    if (unlikely(!vdev->rom && !vdev->rom_read_failed)) {
+        Error *local_err = NULL;
+
+        vdev->rom_read_failed = !vfio_pci_load_rom(vdev, &local_err);
+        if (vdev->rom_read_failed) {
+            error_report_err(local_err);
+        }
+    }
+
+    memcpy(&val, vdev->rom + addr,
+           (addr < vdev->rom_size) ? MIN(size, vdev->rom_size - addr) : 0);
+
+    switch (size) {
+    case 1:
+        data = val.byte;
+        break;
+    case 2:
+        data = le16_to_cpu(val.word);
+        break;
+    case 4:
+        data = le32_to_cpu(val.dword);
+        break;
+    default:
+        hw_error("vfio: unsupported read size, %d bytes\n", size);
+        break;
+    }
+
+    trace_vfio_rom_read(vdev->vbasedev.name, addr, size, data);
+
+    return data;
+}
+
+static void vfio_rom_write(void *opaque, hwaddr addr,
+                           uint64_t data, unsigned size)
+{
+}
+
+static const MemoryRegionOps vfio_rom_ops = {
+    .read = vfio_rom_read,
+    .write = vfio_rom_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+void vfio_pci_size_rom(VFIOPCIDevice *vdev)
+{
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
+    uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
+    char *name;
+
+    if (pdev->romfile || !pdev->rom_bar) {
+        /* Since pci handles romfile, just print a message and return */
+        if (vfio_opt_rom_in_denylist(vdev) && pdev->romfile) {
+            warn_report("Device at %s is known to cause system instability"
+                        " issues during option rom execution",
+                        vdev->vbasedev.name);
+            error_printf("Proceeding anyway since user specified romfile\n");
+        }
+        return;
+    }
+
+    /*
+     * Use the same size ROM BAR as the physical device.  The contents
+     * will get filled in later when the guest tries to read it.
+     */
+    if (vfio_pci_config_space_read(vdev, PCI_ROM_ADDRESS, 4, &orig) != 4 ||
+        vfio_pci_config_space_write(vdev, PCI_ROM_ADDRESS, 4, &size) != 4 ||
+        vfio_pci_config_space_read(vdev, PCI_ROM_ADDRESS, 4, &size) != 4 ||
+        vfio_pci_config_space_write(vdev, PCI_ROM_ADDRESS, 4, &orig) != 4) {
+
+        error_report("%s(%s) ROM access failed", __func__, vbasedev->name);
+        return;
+    }
+
+    size = ~(le32_to_cpu(size) & PCI_ROM_ADDRESS_MASK) + 1;
+
+    if (!size) {
+        return;
+    }
+
+    if (vfio_opt_rom_in_denylist(vdev)) {
+        if (pdev->rom_bar > 0) {
+            warn_report("Device at %s is known to cause system instability"
+                        " issues during option rom execution",
+                        vdev->vbasedev.name);
+            error_printf("Proceeding anyway since user specified"
+                         " positive value for rombar\n");
+        } else {
+            warn_report("Rom loading for device at %s has been disabled"
+                        " due to system instability issues",
+                        vdev->vbasedev.name);
+            error_printf("Specify rombar=1 or romfile to force\n");
+            return;
+        }
+    }
+
+    trace_vfio_pci_size_rom(vdev->vbasedev.name, size);
+
+    name = g_strdup_printf("vfio[%s].rom", vdev->vbasedev.name);
+
+    memory_region_init_io(&pdev->rom, OBJECT(vdev),
+                          &vfio_rom_ops, vdev, name, size);
+    g_free(name);
+
+    pci_register_bar(pdev, PCI_ROM_SLOT,
+                     PCI_BASE_ADDRESS_SPACE_MEMORY, &pdev->rom);
+
+    vdev->rom_read_failed = false;
+}
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 075166b56d3c..34dbef744564 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -47,102 +47,6 @@
 #include "vfio-migration-internal.h"
 #include "vfio-helpers.h"
 
-static bool vfio_pci_load_rom(VFIOPCIDevice *vdev, Error **errp)
-{
-    VFIODevice *vbasedev = &vdev->vbasedev;
-    struct vfio_region_info *reg_info = NULL;
-    uint64_t size;
-    off_t off = 0;
-    ssize_t bytes;
-    int ret;
-
-    ret = vfio_device_get_region_info(vbasedev, VFIO_PCI_ROM_REGION_INDEX,
-                                      &reg_info);
-
-    if (ret != 0) {
-        error_setg_errno(errp, -ret, "vfio: Error getting ROM info");
-        return false;
-    }
-
-    trace_vfio_pci_load_rom(vbasedev->name, (unsigned long)reg_info->size,
-                            (unsigned long)reg_info->offset,
-                            (unsigned long)reg_info->flags);
-
-    vdev->rom_size = size = reg_info->size;
-    vdev->rom_offset = reg_info->offset;
-
-    if (!vdev->rom_size) {
-        vdev->rom_size = 0;
-        vdev->rom_offset = 0;
-        error_setg(errp, "vfio-pci: Device ROM size is zero at %s",
-                   vbasedev->name);
-        error_append_hint(errp, "Device option ROM contents are probably "
-                          "invalid (check dmesg).\nSkip option ROM probe "
-                          "with rombar=0, or load from file with romfile=\n");
-        return false;
-    }
-
-    vdev->rom = g_malloc(size);
-    memset(vdev->rom, 0xff, size);
-
-    while (size) {
-        bytes = vbasedev->io_ops->region_read(vbasedev,
-                                              VFIO_PCI_ROM_REGION_INDEX,
-                                              off, size, vdev->rom + off);
-
-        if (bytes == 0) {
-            break;
-        } else if (bytes > 0) {
-            off += bytes;
-            size -= bytes;
-        } else {
-            if (bytes == -EINTR || bytes == -EAGAIN) {
-                continue;
-            }
-            error_setg_errno(errp, -bytes, "vfio: Error reading device ROM");
-            g_free(vdev->rom);
-            vdev->rom = NULL;
-            vdev->rom_size = 0;
-            vdev->rom_offset = 0;
-            return false;
-        }
-    }
-
-    /*
-     * Test the ROM signature against our device, if the vendor is correct
-     * but the device ID doesn't match, store the correct device ID and
-     * recompute the checksum.  Intel IGD devices need this and are known
-     * to have bogus checksums so we can't simply adjust the checksum.
-     */
-    if (pci_get_word(vdev->rom) == 0xaa55 &&
-        pci_get_word(vdev->rom + 0x18) + 8 < vdev->rom_size &&
-        !memcmp(vdev->rom + pci_get_word(vdev->rom + 0x18), "PCIR", 4)) {
-        uint16_t vid, did;
-
-        vid = pci_get_word(vdev->rom + pci_get_word(vdev->rom + 0x18) + 4);
-        did = pci_get_word(vdev->rom + pci_get_word(vdev->rom + 0x18) + 6);
-
-        if (vid == vdev->vendor_id && did != vdev->device_id) {
-            int i;
-            uint8_t csum, *data = vdev->rom;
-
-            pci_set_word(vdev->rom + pci_get_word(vdev->rom + 0x18) + 6,
-                         vdev->device_id);
-            data[6] = 0;
-
-            for (csum = 0, i = 0; i < vdev->rom_size; i++) {
-                csum += data[i];
-            }
-
-            data[6] = -csum;
-        }
-    }
-
-    vfio_rom_quirk_setup(vdev);
-
-    return true;
-}
-
 /* "Raw" read of underlying config space. */
 int vfio_pci_config_space_read(VFIOPCIDevice *vdev, off_t offset,
                                uint32_t size, void *data)
@@ -161,128 +65,6 @@ int vfio_pci_config_space_write(VFIOPCIDevice *vdev, off_t offset,
                                                offset, size, data, false);
 }
 
-static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
-{
-    VFIOPCIDevice *vdev = opaque;
-    union {
-        uint8_t byte;
-        uint16_t word;
-        uint32_t dword;
-        uint64_t qword;
-    } val = { .qword = ~0ULL };
-    uint64_t data = 0;
-
-    /* Load the ROM lazily when the guest tries to read it */
-    if (unlikely(!vdev->rom && !vdev->rom_read_failed)) {
-        Error *local_err = NULL;
-
-        vdev->rom_read_failed = !vfio_pci_load_rom(vdev, &local_err);
-        if (vdev->rom_read_failed) {
-            error_report_err(local_err);
-        }
-    }
-
-    memcpy(&val, vdev->rom + addr,
-           (addr < vdev->rom_size) ? MIN(size, vdev->rom_size - addr) : 0);
-
-    switch (size) {
-    case 1:
-        data = val.byte;
-        break;
-    case 2:
-        data = le16_to_cpu(val.word);
-        break;
-    case 4:
-        data = le32_to_cpu(val.dword);
-        break;
-    default:
-        hw_error("vfio: unsupported read size, %d bytes\n", size);
-        break;
-    }
-
-    trace_vfio_rom_read(vdev->vbasedev.name, addr, size, data);
-
-    return data;
-}
-
-static void vfio_rom_write(void *opaque, hwaddr addr,
-                           uint64_t data, unsigned size)
-{
-}
-
-static const MemoryRegionOps vfio_rom_ops = {
-    .read = vfio_rom_read,
-    .write = vfio_rom_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
-{
-    PCIDevice *pdev = PCI_DEVICE(vdev);
-    VFIODevice *vbasedev = &vdev->vbasedev;
-    uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
-    char *name;
-
-    if (pdev->romfile || !pdev->rom_bar) {
-        /* Since pci handles romfile, just print a message and return */
-        if (vfio_opt_rom_in_denylist(vdev) && pdev->romfile) {
-            warn_report("Device at %s is known to cause system instability"
-                        " issues during option rom execution",
-                        vdev->vbasedev.name);
-            error_printf("Proceeding anyway since user specified romfile\n");
-        }
-        return;
-    }
-
-    /*
-     * Use the same size ROM BAR as the physical device.  The contents
-     * will get filled in later when the guest tries to read it.
-     */
-    if (vfio_pci_config_space_read(vdev, PCI_ROM_ADDRESS, 4, &orig) != 4 ||
-        vfio_pci_config_space_write(vdev, PCI_ROM_ADDRESS, 4, &size) != 4 ||
-        vfio_pci_config_space_read(vdev, PCI_ROM_ADDRESS, 4, &size) != 4 ||
-        vfio_pci_config_space_write(vdev, PCI_ROM_ADDRESS, 4, &orig) != 4) {
-
-        error_report("%s(%s) ROM access failed", __func__, vbasedev->name);
-        return;
-    }
-
-    size = ~(le32_to_cpu(size) & PCI_ROM_ADDRESS_MASK) + 1;
-
-    if (!size) {
-        return;
-    }
-
-    if (vfio_opt_rom_in_denylist(vdev)) {
-        if (pdev->rom_bar > 0) {
-            warn_report("Device at %s is known to cause system instability"
-                        " issues during option rom execution",
-                        vdev->vbasedev.name);
-            error_printf("Proceeding anyway since user specified"
-                         " positive value for rombar\n");
-        } else {
-            warn_report("Rom loading for device at %s has been disabled"
-                        " due to system instability issues",
-                        vdev->vbasedev.name);
-            error_printf("Specify rombar=1 or romfile to force\n");
-            return;
-        }
-    }
-
-    trace_vfio_pci_size_rom(vdev->vbasedev.name, size);
-
-    name = g_strdup_printf("vfio[%s].rom", vdev->vbasedev.name);
-
-    memory_region_init_io(&pdev->rom, OBJECT(vdev),
-                          &vfio_rom_ops, vdev, name, size);
-    g_free(name);
-
-    pci_register_bar(pdev, PCI_ROM_SLOT,
-                     PCI_BASE_ADDRESS_SPACE_MEMORY, &pdev->rom);
-
-    vdev->rom_read_failed = false;
-}
-
 void vfio_vga_write(void *opaque, hwaddr addr,
                            uint64_t data, unsigned size)
 {
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 0ac1a568e58c..84cec8f077ad 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -15,6 +15,7 @@ vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'pci-caps.c',
   'pci-irq.c',
   'pci-quirks.c',
+  'pci-rom.c',
   'pci.c',
 ))
 vfio_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
-- 
2.56.0


