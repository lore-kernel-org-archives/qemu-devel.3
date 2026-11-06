Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A95606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 22:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DZox7cJV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPSGZ-0001jE-N0; Fri, 06 Nov 2026 17:18:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xPSGX-0001iR-7X
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 17:18:33 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xPSGT-0001Dv-IH
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 17:18:32 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 93E83408B4;
 Fri,  6 Nov 2026 22:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AE81F008A1;
 Fri,  6 Nov 2026 22:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794003508;
 bh=fcnkv5YCTw8rRj6rsa0m4vbDRNvuoxrLXL6vrSmBlDc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DZox7cJVVGpkJkmYzSdxxKaqlUdQ3Utk9oLyCi9sVrAAyhIFCujcDFnRaDXJdaquP
 ex/lh51Th6S87IPh1v1FHDHAhIK11fDILqGBdu+/7nGYjqKdm2IoFF7uAHtIoquEOl
 1IYer/+IXkaPfHpuVi0EJfjWVNc4i/ikI7kO/M9Z5d8CiaCTMA4KI8/edIwZtKsytv
 b85G4e4HjlZphXBGQEIk8ouIDFgV+OOd/5/8qBly6AzbEuJ4f0obCLo14O3Bww5aOJ
 hgphheXEpasRKT+TPlQ8gmKLWjMdmpksoM7yh5oq/wRFdXloMosQYiS+x7hBO1c0uY
 GE+/HEs3Z3pRA==
From: Helge Deller <deller@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>,
 Keith Monahan <keith@techtravels.org>, BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 3/4] lasi_ncr710: Wire up the new ncr53c710_v2 driver in LASI
Date: Fri,  6 Nov 2026 23:18:17 +0100
Message-ID: <20261106221818.139086-4-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261106221818.139086-1-deller@kernel.org>
References: <20261106221818.139086-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Helge Deller <deller@gmx.de>

Signed-off-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/scsi/lasi_ncr710.c | 119 +++++++++++++++++-------------------------
 hw/scsi/lasi_ncr710.h |  30 ++---------
 hw/scsi/meson.build   |   2 +-
 3 files changed, 52 insertions(+), 99 deletions(-)

diff --git a/hw/scsi/lasi_ncr710.c b/hw/scsi/lasi_ncr710.c
index 4fde2265b5..42b0dcb626 100644
--- a/hw/scsi/lasi_ncr710.c
+++ b/hw/scsi/lasi_ncr710.c
@@ -1,19 +1,18 @@
 /*
- * LASI Wrapper for NCR710 SCSI Controller
+ * LASI wrapper for the NCR 53C710 SCSI controller
  *
  * Copyright (c) 2025 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
- * This driver was developed during the Google Summer of Code 2025 program.
- * Mentored by Helge Deller <deller@gmx.de>
+ * Developed during Google Summer of Code 2025, mentored by
+ * Helge Deller <deller@gmx.de>.
  *
- * NCR710 SCSI Controller implementation
- * Based on the NCR53C710 Technical Manual Version 3.2, December 2000
+ * LASI module glue around the 53C710 core in ncr53c710.c: it embeds one
+ * NCR710State by value and maps it onto the HP 715 (-M 715) LASI bus.
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #include "qemu/osdep.h"
 #include "hw/scsi/lasi_ncr710.h"
-#include "hw/scsi/ncr53c710.h"
 #include "hw/core/sysbus.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
@@ -24,7 +23,6 @@
 #include "system/dma.h"
 
 #define LASI_710_SVERSION    0x00082
-#define SCNR                 0xBEEFBABE
 #define LASI_710_HVERSION    0x3D
 #define HPHW_FIO             5        /* Fixed I/O module */
 
@@ -34,8 +32,6 @@ static uint64_t lasi_ncr710_reg_read(void *opaque, hwaddr addr,
     LasiNCR710State *s = LASI_NCR710(opaque);
     uint64_t val = 0;
 
-    trace_lasi_ncr710_reg_read(addr, 0, size);
-
     if (addr == 0x00) {  /* Device ID */
         val = (HPHW_FIO << 24) | LASI_710_SVERSION;
         trace_lasi_ncr710_reg_read_id(HPHW_FIO, LASI_710_SVERSION, val);
@@ -51,22 +47,22 @@ static uint64_t lasi_ncr710_reg_read(void *opaque, hwaddr addr,
     if (addr >= 0x100) {
         hwaddr ncr_addr = addr - 0x100;
         if (size == 1) {
+            /*
+             * Single byte access: flip the byte lane (PA-RISC big endian
+             * access -> the chip's little endian register order).
+             */
             ncr_addr ^= 3;
-            NCR710_DPRINTF("Reading value to LASI WRAPPER == 0x%lx%s, "
-                           "val=0x%lx, size=%u\n",
-                           addr - 0x100, size == 1 ? " (XORed)" : "",
-                           val, size);
             val = ncr710_reg_read(&s->ncr710, ncr_addr, size);
         } else {
+            /*
+             * Multibyte access: gather little endian, no lane flip, so
+             * the 24/32 bit registers assemble correctly.
+             */
             val = 0;
             for (unsigned i = 0; i < size; i++) {
                 uint8_t byte_val = ncr710_reg_read(&s->ncr710, ncr_addr + i, 1);
                 val |= ((uint64_t)byte_val) << (i * 8);
-                NCR710_DPRINTF("  Read byte %u from NCR addr 0x%lx: "
-                               "0x%02x\n", i, ncr_addr + i, byte_val);
             }
-            NCR710_DPRINTF("  Reconstructed %u-byte value: 0x%lx\n",
-                           size, val);
         }
 
         trace_lasi_ncr710_reg_forward_read(addr, val);
@@ -84,7 +80,13 @@ static void lasi_ncr710_reg_write(void *opaque, hwaddr addr,
 
     trace_lasi_ncr710_reg_write(addr, val, size);
 
-    if (addr <= 0x0F) {
+    /*
+     * 0x00..0x0f is the read only LASI module header (ID/SVERSION/HVERSION) and
+     * 0x10..0xff is unmapped module space; writes to both are ignored.  The
+     * SCSI bus reset is driven through the chip's SCNTL1.RST at forwarded
+     * offset 0x101 (see ncr53c710.c), not through this window.
+     */
+    if (addr <= 0x0f) {
         return;
     }
 
@@ -93,16 +95,10 @@ static void lasi_ncr710_reg_write(void *opaque, hwaddr addr,
 
         if (size == 1) {
             ncr_addr ^= 3;
-            NCR710_DPRINTF("Writing value to LASI WRAPPER == 0x%lx%s, "
-                           "val=0x%lx, size=%u\n",
-                           addr - 0x100, size == 1 ? " (XORed)" : "",
-                           val, size);
             ncr710_reg_write(&s->ncr710, ncr_addr, val, size);
         } else {
             for (unsigned i = 0; i < size; i++) {
                 uint8_t byte_val = (val >> (i * 8)) & 0xff;
-                 NCR710_DPRINTF("  Writing byte %u to NCR addr 0x%lx: 0x%02x\n",
-                       i, ncr_addr + i, byte_val);
                 ncr710_reg_write(&s->ncr710, ncr_addr + i, byte_val, 1);
             }
         }
@@ -113,10 +109,7 @@ static void lasi_ncr710_reg_write(void *opaque, hwaddr addr,
     }
 }
 
-/*
- * req_cancelled, command_complete, transfer_data forwards
- * commands to its core counterparts.
- */
+/* SCSIBusInfo callbacks: trace, then forward to the ncr53c710 core. */
 static void lasi_ncr710_request_cancelled(SCSIRequest *req)
 {
     trace_lasi_ncr710_request_cancelled(req);
@@ -129,20 +122,27 @@ static void lasi_ncr710_command_complete(SCSIRequest *req, size_t resid)
     ncr710_command_complete(req, resid);
 }
 
- static void lasi_ncr710_transfer_data(SCSIRequest *req, uint32_t len)
+static void lasi_ncr710_transfer_data(SCSIRequest *req, uint32_t len)
 {
     trace_lasi_ncr710_transfer_data(len);
     ncr710_transfer_data(req, len);
 }
 
+static void lasi_ncr710_free_request(SCSIBus *bus, void *priv)
+{
+    g_free(priv);
+}
+
 static const struct SCSIBusInfo lasi_ncr710_scsi_info = {
     .tcq = true,
-    .max_target = 8,
-    .max_lun = 8,  /* full LUN support */
+    /* 8-bit bus: targets and LUNs 0-7 (scsi-bus.c maxima are inclusive). */
+    .max_target = 7,
+    .max_lun = 7,
 
     .transfer_data = lasi_ncr710_transfer_data,
     .complete = lasi_ncr710_command_complete,
     .cancel = lasi_ncr710_request_cancelled,
+    .free_request = lasi_ncr710_free_request,
 };
 
 static const MemoryRegionOps lasi_ncr710_mmio_ops = {
@@ -157,12 +157,9 @@ static const MemoryRegionOps lasi_ncr710_mmio_ops = {
 
 static const VMStateDescription vmstate_lasi_ncr710 = {
     .name = "lasi-ncr710",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(hw_type, LasiNCR710State),
-        VMSTATE_UINT32(sversion, LasiNCR710State),
-        VMSTATE_UINT32(hversion, LasiNCR710State),
         VMSTATE_STRUCT(ncr710, LasiNCR710State, 1, vmstate_ncr710, NCR710State),
         VMSTATE_END_OF_LIST()
     }
@@ -179,49 +176,36 @@ static void lasi_ncr710_realize(DeviceState *dev, Error **errp)
                   &lasi_ncr710_scsi_info);
     s->ncr710.as = &address_space_memory;
     s->ncr710.irq = s->lasi_irq;
+    QTAILQ_INIT(&s->ncr710.queue);
 
-    s->ncr710.reselection_retry_timer =
+    s->ncr710.scripts_timer =
         timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                     ncr710_reselection_retry_callback,
+                     ncr710_scripts_timer_callback,
                      &s->ncr710);
 
     ncr710_soft_reset(&s->ncr710);
 
     trace_lasi_ncr710_timers_initialized(
-        (uint64_t)s->ncr710.reselection_retry_timer);
+        (uint64_t)s->ncr710.scripts_timer);
 
-    /* Initialize memory region */
     memory_region_init_io(&s->mmio, OBJECT(dev), &lasi_ncr710_mmio_ops, s,
                           "lasi-ncr710", 0x200);
     sysbus_init_mmio(sbd, &s->mmio);
 }
 
-void lasi_ncr710_handle_legacy_cmdline(DeviceState *lasi_dev)
+static void lasi_ncr710_unrealize(DeviceState *dev)
 {
-    LasiNCR710State *s = LASI_NCR710(lasi_dev);
-    SCSIBus *bus = &s->ncr710.bus;
-    int found_drives = 0;
-
-    if (!bus) {
-        return;
-    }
+    LasiNCR710State *s = LASI_NCR710(dev);
 
-    for (int unit = 0; unit <= 7; unit++) {
-        DriveInfo *dinfo = drive_get(IF_SCSI, bus->busnr, unit);
-        if (dinfo) {
-            trace_lasi_ncr710_legacy_drive_found(bus->busnr, unit);
-            found_drives++;
-        }
-    }
+    timer_free(s->ncr710.scripts_timer);
+    s->ncr710.scripts_timer = NULL;
+}
 
-    trace_lasi_ncr710_handle_legacy_cmdline(bus->busnr, found_drives);
+void lasi_ncr710_handle_legacy_cmdline(DeviceState *lasi_dev)
+{
+    LasiNCR710State *s = LASI_NCR710(lasi_dev);
 
-    scsi_bus_legacy_handle_cmdline(bus);
-    BusChild *kid;
-    QTAILQ_FOREACH(kid, &bus->qbus.children, sibling) {
-        trace_lasi_ncr710_scsi_device_created(
-            object_get_typename(OBJECT(kid->child)));
-    }
+    scsi_bus_legacy_handle_cmdline(&s->ncr710.bus);
 }
 
 DeviceState *lasi_ncr710_init(MemoryRegion *addr_space, hwaddr hpa,
@@ -248,20 +232,12 @@ static void lasi_ncr710_reset(DeviceState *dev)
     ncr710_soft_reset(&s->ncr710);
 }
 
-static void lasi_ncr710_instance_init(Object *obj)
-{
-    LasiNCR710State *s = LASI_NCR710(obj);
-
-    s->hw_type = HPHW_FIO;
-    s->sversion = LASI_710_SVERSION;
-    s->hversion = LASI_710_HVERSION;
-}
-
 static void lasi_ncr710_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = lasi_ncr710_realize;
+    dc->unrealize = lasi_ncr710_unrealize;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     dc->fw_name = "scsi";
     dc->desc = "HP-PARISC LASI NCR710 SCSI adapter";
@@ -274,7 +250,6 @@ static const TypeInfo lasi_ncr710_info = {
     .name          = TYPE_LASI_NCR710,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(LasiNCR710State),
-    .instance_init = lasi_ncr710_instance_init,
     .class_init    = lasi_ncr710_class_init,
 };
 
diff --git a/hw/scsi/lasi_ncr710.h b/hw/scsi/lasi_ncr710.h
index 450fb7e1c3..968604c2e7 100644
--- a/hw/scsi/lasi_ncr710.h
+++ b/hw/scsi/lasi_ncr710.h
@@ -1,12 +1,9 @@
 /*
- * LASI Wrapper for NCR710 SCSI Controller
+ * LASI wrapper for the NCR 53C710 SCSI controller
  *
  * Copyright (c) 2025 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
- * This driver was developed during the Google Summer of Code 2025 program.
- * Mentored by Helge Deller <deller@gmx.de>
- *
- * NCR710 SCSI Controller implementation
- * Based on the NCR53C710 Technical Manual Version 3.2, December 2000
+ * Developed during Google Summer of Code 2025, mentored by
+ * Helge Deller <deller@gmx.de>.
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
@@ -17,34 +14,15 @@
 #include "hw/core/sysbus.h"
 #include "exec/memattrs.h"
 #include "hw/scsi/scsi.h"
-#include "hw/scsi/ncr53c710.h"
+#include "hw/scsi/ncr53c710_v2.h"
 
 #define TYPE_LASI_NCR710 "lasi-ncr710"
 OBJECT_DECLARE_SIMPLE_TYPE(LasiNCR710State, LASI_NCR710)
 
-#define LASI_SCSI_RESET         0x000   /* SCSI Reset Register */
-#define LASI_SCSI_NCR710_BASE   0x100   /* NCR710 Base Register Offset */
-
-#define PARISC_DEVICE_ID_OFF    0x00    /* HW type, HVERSION, SVERSION */
-#define PARISC_DEVICE_CONFIG_OFF 0x04   /* Configuration data */
-
-#define PHASE_MASK              7
-#define PHASE_DO                0
-
-#define NCR710_SCNTL1_RST       0x08    /* SCSI Reset */
-#define NCR710_ISTAT_RST        0x40    /* Device Reset */
-#define NCR710_ISTAT_ABRT       0x80    /* Script Abort */
-#define NCR710_ISTAT_CON        0x08    /* ISTAT_Connected */
-#define NCR710_DSTAT_DFE        0x80    /* DMA FIFO Empty */
-#define NCR710_CTEST2_DACK      0x01    /* DMA Acknowledge */
-
 typedef struct LasiNCR710State {
     SysBusDevice parent_obj;
     MemoryRegion mmio;
     qemu_irq lasi_irq;       /* IRQ line to LASI controller */
-    uint32_t hw_type;        /* Hardware type (HPHW_*) */
-    uint32_t sversion;       /* Software version */
-    uint32_t hversion;       /* Hardware version */
     NCR710State ncr710;
 } LasiNCR710State;
 
diff --git a/hw/scsi/meson.build b/hw/scsi/meson.build
index 69fde0cf84..066d95f464 100644
--- a/hw/scsi/meson.build
+++ b/hw/scsi/meson.build
@@ -11,7 +11,7 @@ scsi_ss.add(files(
 scsi_ss.add(when: 'CONFIG_ESP', if_true: files('esp.c'))
 scsi_ss.add(when: 'CONFIG_ESP_PCI', if_true: files('esp-pci.c'))
 scsi_ss.add(when: 'CONFIG_LSI_SCSI_PCI', if_true: files('lsi53c895a.c'))
-scsi_ss.add(when: 'CONFIG_NCR710_SCSI', if_true: files('ncr53c710.c', 'lasi_ncr710.c'))
+scsi_ss.add(when: 'CONFIG_NCR710_SCSI', if_true: files('ncr53c710_v2.c', 'lasi_ncr710.c'))
 scsi_ss.add(when: 'CONFIG_MEGASAS_SCSI_PCI', if_true: files('megasas.c'))
 scsi_ss.add(when: 'CONFIG_MPTSAS_SCSI_PCI', if_true: files('mptsas.c', 'mptconfig.c', 'mptendian.c'))
 scsi_ss.add(when: 'CONFIG_VMW_PVSCSI_SCSI_PCI', if_true: files('vmw_pvscsi.c'))
-- 
2.54.0


