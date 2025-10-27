Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A46CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 21:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDUaM-0002Xi-Bi; Mon, 27 Oct 2025 17:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vDUZr-0002Uc-Rm
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 17:16:32 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vDUZl-0004yv-OT
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 17:16:28 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0464A45D85;
 Mon, 27 Oct 2025 21:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A60CC113D0;
 Mon, 27 Oct 2025 21:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761599772;
 bh=D/ZHEbgaMlKUFGet457khYnQ7gpazEoXuF0X4RvvnCA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FwNADtJnlqCp3c/ki3ADsGxbmMcfSsOxxeu6Rhoyg3WXWQJwU4ffv+8WjypMG08jm
 tbXu6h4rusYlonrcFH1RvIqJMpu2sHTAyIdehhQX311g24CPmx0cUhD2kB7G9GTEoD
 nbUt2ln+jlsdJts/aKtQCYosW+XLQKt7qIzO2UnwA7wYJrfDgQqUaVqfWJBGzLY/dH
 ZpLPc+K7Mwg1omsZj8dnxkBRtGUbCs0F4FM33RH12ZjQG7OkB1Ps7oaAkAMuhw4spP
 I1CgqeCcYyIibRC7kxvElUPoAQLwh4ZVrZyubr/XixAuFf2/xHv85GYFE2lPk6iMx1
 V6OPpYhyQDaag==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fam Zheng <fam@euphon.net>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, deller@gmx.de
Subject: [PULL 02/11] lasi_ncr710: Add LASI wrapper for NCR 53c710 SCSI chip
Date: Mon, 27 Oct 2025 22:15:54 +0100
Message-ID: <20251027211603.7141-3-deller@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027211603.7141-1-deller@kernel.org>
References: <20251027211603.7141-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>

The LASI multi I/O chip in older PA-RISC machines includes a SCSI
core based on the NCR 53c710 SCSI chip.
This driver adds the glue code to talk to the NCR710 via LASI.

This driver was developed as part of the Google Summer of Code 2025 program.

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 MAINTAINERS           |   1 +
 hw/scsi/lasi_ncr710.c | 282 ++++++++++++++++++++++++++++++++++++++++++
 hw/scsi/lasi_ncr710.h |  57 +++++++++
 hw/scsi/trace-events  |  17 +++
 4 files changed, 357 insertions(+)
 create mode 100644 hw/scsi/lasi_ncr710.c
 create mode 100644 hw/scsi/lasi_ncr710.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 84cfd85e1f..a204c38754 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1283,6 +1283,7 @@ F: hw/net/*i82596*
 F: hw/misc/lasi.c
 F: hw/pci-host/astro.c
 F: hw/pci-host/dino.c
+F: hw/scsi/lasi_ncr710.*
 F: include/hw/input/lasips2.h
 F: include/hw/misc/lasi.h
 F: include/hw/net/lasi_82596.h
diff --git a/hw/scsi/lasi_ncr710.c b/hw/scsi/lasi_ncr710.c
new file mode 100644
index 0000000000..b674a4066f
--- /dev/null
+++ b/hw/scsi/lasi_ncr710.c
@@ -0,0 +1,282 @@
+/*
+ * LASI Wrapper for NCR710 SCSI Controller
+ *
+ * Copyright (c) 2025 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
+ * This driver was developed during the Google Summer of Code 2025 program.
+ * Mentored by Helge Deller <deller@gmx.de>
+ *
+ * NCR710 SCSI Controller implementation
+ * Based on the NCR53C710 Technical Manual Version 3.2, December 2000
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/scsi/lasi_ncr710.h"
+#include "hw/scsi/ncr53c710.h"
+#include "hw/sysbus.h"
+#include "qemu/timer.h"
+#include "qemu/log.h"
+#include "trace.h"
+#include "system/blockdev.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "system/dma.h"
+
+#define LASI_710_SVERSION    0x00082
+#define SCNR                 0xBEEFBABE
+#define LASI_710_HVERSION    0x3D
+#define HPHW_FIO             5        /* Fixed I/O module */
+
+static uint64_t lasi_ncr710_reg_read(void *opaque, hwaddr addr,
+                                    unsigned size)
+{
+    LasiNCR710State *s = LASI_NCR710(opaque);
+    uint64_t val = 0;
+
+    trace_lasi_ncr710_reg_read(addr, 0, size);
+
+    if (addr == 0x00) {  /* Device ID */
+        val = (HPHW_FIO << 24) | LASI_710_SVERSION;
+        trace_lasi_ncr710_reg_read_id(HPHW_FIO, LASI_710_SVERSION, val);
+        return val;
+    }
+
+    if (addr == 0x08) {  /* HVersion */
+        val = LASI_710_HVERSION;
+        trace_lasi_ncr710_reg_read_hversion(val);
+        return val;
+    }
+
+    if (addr >= 0x100) {
+        hwaddr ncr_addr = addr - 0x100;
+        if (size == 1) {
+            ncr_addr ^= 3;
+            NCR710_DPRINTF("Reading value to LASI WRAPPER == 0x%lx%s, "
+                           "val=0x%lx, size=%u\n",
+                           addr - 0x100, size == 1 ? " (XORed)" : "",
+                           val, size);
+            val = ncr710_reg_read(&s->ncr710, ncr_addr, size);
+        } else {
+            val = 0;
+            for (unsigned i = 0; i < size; i++) {
+                uint8_t byte_val = ncr710_reg_read(&s->ncr710, ncr_addr + i, 1);
+                val |= ((uint64_t)byte_val) << (i * 8);
+                NCR710_DPRINTF("  Read byte %u from NCR addr 0x%lx: "
+                               "0x%02x\n", i, ncr_addr + i, byte_val);
+            }
+            NCR710_DPRINTF("  Reconstructed %u-byte value: 0x%lx\n",
+                           size, val);
+        }
+
+        trace_lasi_ncr710_reg_forward_read(addr, val);
+    } else {
+        val = 0;
+        trace_lasi_ncr710_reg_read(addr, val, size);
+    }
+    return val;
+}
+
+static void lasi_ncr710_reg_write(void *opaque, hwaddr addr,
+                                   uint64_t val, unsigned size)
+{
+    LasiNCR710State *s = LASI_NCR710(opaque);
+
+    trace_lasi_ncr710_reg_write(addr, val, size);
+
+    if (addr <= 0x0F) {
+        return;
+    }
+
+    if (addr >= 0x100) {
+        hwaddr ncr_addr = addr - 0x100;
+
+        if (size == 1) {
+            ncr_addr ^= 3;
+            NCR710_DPRINTF("Writing value to LASI WRAPPER == 0x%lx%s, "
+                           "val=0x%lx, size=%u\n",
+                           addr - 0x100, size == 1 ? " (XORed)" : "",
+                           val, size);
+            ncr710_reg_write(&s->ncr710, ncr_addr, val, size);
+        } else {
+            for (unsigned i = 0; i < size; i++) {
+                uint8_t byte_val = (val >> (i * 8)) & 0xff;
+                 NCR710_DPRINTF("  Writing byte %u to NCR addr 0x%lx: 0x%02x\n",
+                       i, ncr_addr + i, byte_val);
+                ncr710_reg_write(&s->ncr710, ncr_addr + i, byte_val, 1);
+            }
+        }
+
+        trace_lasi_ncr710_reg_forward_write(addr, val);
+    } else {
+        trace_lasi_ncr710_reg_write(addr, val, size);
+    }
+}
+
+/*
+ * req_cancelled, command_complete, transfer_data forwards
+ * commands to its core counterparts.
+ */
+static void lasi_ncr710_request_cancelled(SCSIRequest *req)
+{
+    trace_lasi_ncr710_request_cancelled(req);
+    ncr710_request_cancelled(req);
+}
+
+static void lasi_ncr710_command_complete(SCSIRequest *req, size_t resid)
+{
+    trace_lasi_ncr710_command_complete(req->status, resid);
+    ncr710_command_complete(req, resid);
+}
+
+ static void lasi_ncr710_transfer_data(SCSIRequest *req, uint32_t len)
+{
+    trace_lasi_ncr710_transfer_data(len);
+    ncr710_transfer_data(req, len);
+}
+
+static const struct SCSIBusInfo lasi_ncr710_scsi_info = {
+    .tcq = true,
+    .max_target = 8,
+    .max_lun = 8,  /* full LUN support */
+
+    .transfer_data = lasi_ncr710_transfer_data,
+    .complete = lasi_ncr710_command_complete,
+    .cancel = lasi_ncr710_request_cancelled,
+};
+
+static const MemoryRegionOps lasi_ncr710_mmio_ops = {
+    .read = lasi_ncr710_reg_read,
+    .write = lasi_ncr710_reg_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static const VMStateDescription vmstate_lasi_ncr710 = {
+    .name = "lasi-ncr710",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void lasi_ncr710_realize(DeviceState *dev, Error **errp)
+{
+    LasiNCR710State *s = LASI_NCR710(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    trace_lasi_ncr710_device_realize();
+
+    scsi_bus_init(&s->ncr710.bus, sizeof(s->ncr710.bus), dev,
+                  &lasi_ncr710_scsi_info);
+    s->ncr710.as = &address_space_memory;
+    s->ncr710.irq = s->lasi_irq;
+
+    s->ncr710.reselection_retry_timer =
+        timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                     ncr710_reselection_retry_callback,
+                     &s->ncr710);
+
+    ncr710_soft_reset(&s->ncr710);
+
+    trace_lasi_ncr710_timers_initialized(
+        (uint64_t)s->ncr710.reselection_retry_timer);
+
+    /* Initialize memory region */
+    memory_region_init_io(&s->mmio, OBJECT(dev), &lasi_ncr710_mmio_ops, s,
+                          "lasi-ncr710", 0x200);
+    sysbus_init_mmio(sbd, &s->mmio);
+}
+
+void lasi_ncr710_handle_legacy_cmdline(DeviceState *lasi_dev)
+{
+    LasiNCR710State *s = LASI_NCR710(lasi_dev);
+    SCSIBus *bus = &s->ncr710.bus;
+    int found_drives = 0;
+
+    if (!bus) {
+        return;
+    }
+
+    for (int unit = 0; unit <= 7; unit++) {
+        DriveInfo *dinfo = drive_get(IF_SCSI, bus->busnr, unit);
+        if (dinfo) {
+            trace_lasi_ncr710_legacy_drive_found(bus->busnr, unit);
+            found_drives++;
+        }
+    }
+
+    trace_lasi_ncr710_handle_legacy_cmdline(bus->busnr, found_drives);
+
+    scsi_bus_legacy_handle_cmdline(bus);
+    BusChild *kid;
+    QTAILQ_FOREACH(kid, &bus->qbus.children, sibling) {
+        trace_lasi_ncr710_scsi_device_created(
+            object_get_typename(OBJECT(kid->child)));
+    }
+}
+
+DeviceState *lasi_ncr710_init(MemoryRegion *addr_space, hwaddr hpa,
+                               qemu_irq irq)
+{
+    DeviceState *dev;
+    LasiNCR710State *s;
+    SysBusDevice *sbd;
+
+    dev = qdev_new(TYPE_LASI_NCR710);
+    s = LASI_NCR710(dev);
+    sbd = SYS_BUS_DEVICE(dev);
+    s->lasi_irq = irq;
+    sysbus_realize_and_unref(sbd, &error_fatal);
+    memory_region_add_subregion(addr_space, hpa,
+                               sysbus_mmio_get_region(sbd, 0));
+    return dev;
+}
+
+static void lasi_ncr710_reset(DeviceState *dev)
+{
+    LasiNCR710State *s = LASI_NCR710(dev);
+    trace_lasi_ncr710_device_reset();
+    ncr710_soft_reset(&s->ncr710);
+}
+
+static void lasi_ncr710_instance_init(Object *obj)
+{
+    LasiNCR710State *s = LASI_NCR710(obj);
+
+    s->hw_type = HPHW_FIO;
+    s->sversion = LASI_710_SVERSION;
+    s->hversion = LASI_710_HVERSION;
+}
+
+static void lasi_ncr710_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = lasi_ncr710_realize;
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    dc->fw_name = "scsi";
+    dc->desc = "HP-PARISC LASI NCR710 SCSI adapter";
+    device_class_set_legacy_reset(dc, lasi_ncr710_reset);
+    dc->vmsd = &vmstate_lasi_ncr710;
+    dc->user_creatable = false;
+}
+
+static const TypeInfo lasi_ncr710_info = {
+    .name          = TYPE_LASI_NCR710,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(LasiNCR710State),
+    .instance_init = lasi_ncr710_instance_init,
+    .class_init    = lasi_ncr710_class_init,
+};
+
+static void lasi_ncr710_register_types(void)
+{
+    type_register_static(&lasi_ncr710_info);
+}
+
+type_init(lasi_ncr710_register_types)
diff --git a/hw/scsi/lasi_ncr710.h b/hw/scsi/lasi_ncr710.h
new file mode 100644
index 0000000000..3711233b0f
--- /dev/null
+++ b/hw/scsi/lasi_ncr710.h
@@ -0,0 +1,57 @@
+/*
+ * LASI Wrapper for NCR710 SCSI Controller
+ *
+ * Copyright (c) 2025 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
+ * This driver was developed during the Google Summer of Code 2025 program.
+ * Mentored by Helge Deller <deller@gmx.de>
+ *
+ * NCR710 SCSI Controller implementation
+ * Based on the NCR53C710 Technical Manual Version 3.2, December 2000
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_LASI_NCR710_H
+#define HW_LASI_NCR710_H
+
+#include "hw/sysbus.h"
+#include "qemu/osdep.h"
+#include "exec/memattrs.h"
+#include "hw/scsi/scsi.h"
+#include "hw/scsi/ncr53c710.h"
+
+#define TYPE_LASI_NCR710 "lasi-ncr710"
+OBJECT_DECLARE_SIMPLE_TYPE(LasiNCR710State, LASI_NCR710)
+
+#define LASI_SCSI_RESET         0x000   /* SCSI Reset Register */
+#define LASI_SCSI_NCR710_BASE   0x100   /* NCR710 Base Register Offset */
+
+#define PARISC_DEVICE_ID_OFF    0x00    /* HW type, HVERSION, SVERSION */
+#define PARISC_DEVICE_CONFIG_OFF 0x04   /* Configuration data */
+
+#define PHASE_MASK              7
+#define PHASE_DO                0
+
+#define NCR710_SCNTL1_RST       0x08    /* SCSI Reset */
+#define NCR710_ISTAT_RST        0x40    /* Device Reset */
+#define NCR710_ISTAT_ABRT       0x80    /* Script Abort */
+#define NCR710_ISTAT_CON        0x08    /* ISTAT_Connected */
+#define NCR710_DSTAT_DFE        0x80    /* DMA FIFO Empty */
+#define NCR710_CTEST2_DACK      0x01    /* DMA Acknowledge */
+
+typedef struct LasiNCR710State {
+    SysBusDevice parent_obj;
+    MemoryRegion mmio;
+    qemu_irq lasi_irq;       /* IRQ line to LASI controller */
+    uint32_t hw_type;        /* Hardware type (HPHW_*) */
+    uint32_t sversion;       /* Software version */
+    uint32_t hversion;       /* Hardware version */
+    SCSIBus bus;
+    NCR710State ncr710;
+} LasiNCR710State;
+
+DeviceState *lasi_ncr710_init(MemoryRegion *addr_space, hwaddr hpa,
+                               qemu_irq irq);
+void lasi_ncr710_handle_legacy_cmdline(DeviceState *lasi_dev);
+
+#endif
diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
index 6c2788e202..0604050a67 100644
--- a/hw/scsi/trace-events
+++ b/hw/scsi/trace-events
@@ -306,6 +306,23 @@ lsi_reg_write(const char *name, int offset, uint8_t val) "Write reg %s 0x%x = 0x
 lsi_scripts_timer_triggered(void) "SCRIPTS timer triggered"
 lsi_scripts_timer_start(void) "SCRIPTS timer started"
 
+# lasi_ncr710.c
+lasi_ncr710_device_realize(void) "Device realized"
+lasi_ncr710_device_reset(void) "Device reset"
+lasi_ncr710_reg_read(uint32_t addr, uint32_t val, unsigned size) "addr=0x%03x val=0x%08x size=%u"
+lasi_ncr710_reg_write(uint32_t addr, uint32_t val, unsigned size) "addr=0x%03x val=0x%08x size=%u"
+lasi_ncr710_reg_read_id(uint32_t hw_type, uint32_t sversion, uint32_t val) "hw_type=%u sversion=0x%04x val=0x%08x"
+lasi_ncr710_reg_read_hversion(uint32_t hversion) "LASI NCR710: HVersion read -> 0x%02x"
+lasi_ncr710_reg_forward_read(uint32_t addr, uint32_t val) "LASI NCR710: Forward read to NCR710 core addr=0x%03x val=0x%08x"
+lasi_ncr710_reg_forward_write(uint32_t addr, uint32_t val) "LASI NCR710: Forward write to NCR710 core addr=0x%03x val=0x%08x"
+lasi_ncr710_command_complete(uint32_t status, size_t resid) "LASI NCR710: Command complete status=0x%02x resid=%zu"
+lasi_ncr710_transfer_data(uint32_t len) "LASI NCR710: Transfer data len=%u"
+lasi_ncr710_request_cancelled(void *req) "LASI NCR710: Request cancelled req=%p"
+lasi_ncr710_timers_initialized(uint64_t reselection) "Timers: reselection=0x%" PRIx64
+lasi_ncr710_handle_legacy_cmdline(int busnr, int found_drives) "LASI NCR710: Handle legacy cmdline busnr=%d found_drives=%d"
+lasi_ncr710_legacy_drive_found(int busnr, int unit) "LASI NCR710: Found legacy drive at bus=%d unit=%d"
+lasi_ncr710_scsi_device_created(const char *type) "LASI NCR710: SCSI device created: %s"
+
 # virtio-scsi.c
 virtio_scsi_cmd_req(int lun, uint32_t tag, uint8_t cmd) "virtio_scsi_cmd_req lun=%u tag=0x%x cmd=0x%x"
 virtio_scsi_cmd_resp(int lun, uint32_t tag, int response, uint8_t status) "virtio_scsi_cmd_resp lun=%u tag=0x%x response=%d status=0x%x"
-- 
2.51.0


