Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3BEC79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3WUA-000838-Ga; Mon, 07 Sep 2026 06:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3WU8-00082f-Nv; Mon, 07 Sep 2026 06:21:56 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3WU5-00026H-M0; Mon, 07 Sep 2026 06:21:56 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4hdjlt2R9rz83JF;
 Mon,  7 Sep 2026 12:21:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788776490;
 bh=Y0vTjKDptsPlgAdXpFia4d+W56tEq3YShBUGE8fW7mg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gT7lTiTVdC5ZnogN988gKL/kNeoX8ifNrJkFfADIbc+Fl+wjgPA717o+pJfBE0D1z
 3yui4XhUeLxyFuzxPDPOncEK/D51nlVQFJpku7UQ/VGNS80m+IKOi64OvA4gsJfKlB
 zRyiwjqoeVYQ3fmhRCP9D13YvFFPdsHmL0dLWh7wK4qN5YMJlR2j5PrKV4Sophfe5R
 5SnW3eopk9yTIzFvqQ/WZyphb+iEy84KIufNX5osYBVBhyyIqlOpsPN4HXa+Sw+Z9S
 RRhKANauQ++XMYd9cmG5MaUZbC08xkIeteBF3lud+mQObjrlodoBK9AkMNXfqHj7nO
 RT8HDppa6Oy/A==
Received: from localhost.localdomain (unknown [134.206.232.123])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hdjlt0yTNz7wpK;
 Mon,  7 Sep 2026 12:21:30 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 Gilles Grimaud <gilles.grimaud@univ-lille.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v3 34/36] hw/arm: add optional Pico SDK exit handling
Date: Mon,  7 Sep 2026 12:21:26 +0200
Message-ID: <20260907102128.55676-4-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907102128.55676-1-gilles.grimaud@univ-lille.fr>
References: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
 <20260907102128.55676-1-gilles.grimaud@univ-lille.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.106;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-2.univ-lille.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add an opt-in raspi-pico machine property that converts the Pico SDK's BKPT
architectural BKPT-to-HardFault behavior unchanged and chain non-BKPT
faults to the application handler.

Patch the application HardFault vector through a page-sized ROM device
overlay. This lets TCG execute the first XIP page directly instead of
generating one-instruction translation blocks. Switch the overlay back to
callback dispatch while flash is busy, and synchronize its contents after
changes to the underlying flash page.

Cover the default HardFault path, explicit semihosting exit, and the
optional Pico SDK exit path with compiled check-tcg guests.

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/arm/raspi_pico.c                           |  23 +++
 hw/arm/rp2040.c                               | 164 ++++++++++++++++++
 hw/ssi/rp2040_xip.c                           |  24 +++
 include/hw/arm/rp2040.h                       |   9 +
 include/hw/ssi/rp2040_xip.h                   |  14 ++
 tests/tcg/arm/system/meson.build              |  26 +++
 tests/tcg/arm/system/rp2040-bkpt-hardfault.S  |  94 ++++++++++
 .../tcg/arm/system/rp2040-bkpt-hardfault.ref  |   2 +
 tests/tcg/arm/system/rp2040-check-exit.sh     |  14 ++
 tests/tcg/arm/system/rp2040-exit.S            |  55 ++++++
 10 files changed, 425 insertions(+)
 create mode 100644 tests/tcg/arm/system/rp2040-bkpt-hardfault.S
 create mode 100644 tests/tcg/arm/system/rp2040-bkpt-hardfault.ref
 create mode 100755 tests/tcg/arm/system/rp2040-check-exit.sh
 create mode 100644 tests/tcg/arm/system/rp2040-exit.S

diff --git a/hw/arm/raspi_pico.c b/hw/arm/raspi_pico.c
index c99ff2660e..7ba6555130 100644
--- a/hw/arm/raspi_pico.c
+++ b/hw/arm/raspi_pico.c
@@ -33,6 +33,7 @@ struct RaspiPicoMachineState {
     uint64_t rosc_random_seed;
     bool rosc_random_seed_set;
     bool strict_uart_pins;
+    bool pico_sdk_exit;
 };
 
 static char *raspi_pico_get_flash_file(Object *obj, Error **errp)
@@ -156,6 +157,7 @@ static void raspi_pico_init(MachineState *machine)
 
     rp2040_xip_load_image(&s->soc.xip, machine->kernel_filename,
                           &error_fatal);
+    rp2040_set_pico_sdk_exit(&s->soc, s->pico_sdk_exit, &error_fatal);
     armv7m_load_kernel(s->soc.armv7m[0].cpu, NULL,
                        RP2040_XIP_BASE, 2 * MiB);
     rp2040_xip_set_writable(&s->soc.xip, false);
@@ -184,6 +186,21 @@ static void raspi_pico_set_strict_uart_pins(Object *obj, bool value,
     s->strict_uart_pins = value;
 }
 
+static bool raspi_pico_get_pico_sdk_exit(Object *obj, Error **errp)
+{
+    RaspiPicoMachineState *s = RASPI_PICO_MACHINE(obj);
+
+    return s->pico_sdk_exit;
+}
+
+static void raspi_pico_set_pico_sdk_exit(Object *obj, bool value,
+                                         Error **errp)
+{
+    RaspiPicoMachineState *s = RASPI_PICO_MACHINE(obj);
+
+    s->pico_sdk_exit = value;
+}
+
 static void raspi_pico_machine_initfn(Object *obj)
 {
     RaspiPicoMachineState *s = RASPI_PICO_MACHINE(obj);
@@ -232,6 +249,12 @@ static void raspi_pico_machine_class_init(ObjectClass *oc, const void *data)
                                           "Require the RP2040 IO_BANK0 "
                                           "UART pinmux before UART0 or UART1 "
                                           "reaches its host serial backend");
+    object_class_property_add_bool(oc, "pico-sdk-exit",
+                                   raspi_pico_get_pico_sdk_exit,
+                                   raspi_pico_set_pico_sdk_exit);
+    object_class_property_set_description(oc, "pico-sdk-exit",
+                                          "Convert Pico SDK exit BKPT #0 "
+                                          "HardFaults into QEMU exits");
 }
 
 static const TypeInfo raspi_pico_machine_info = {
diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
index 436b3be7f2..572fff0c7d 100644
--- a/hw/arm/rp2040.c
+++ b/hw/arm/rp2040.c
@@ -20,6 +20,7 @@
 #include "qemu/datadir.h"
 #include "qemu/log.h"
 #include "system/address-spaces.h"
+#include "system/runstate.h"
 #include "target/arm/cpu.h"
 #include "target/arm/cpu-qom.h"
 #include "trace.h"
@@ -72,6 +73,8 @@
 #define RP2040_BOOTROM_FLOAT_STUBS_OFFSET 0x0600
 #define RP2040_BOOTROM_DOUBLE_STUBS_OFFSET 0x0b00
 #define RP2040_BOOTROM_FP_STUB_SIZE 36
+#define RP2040_APP_HARDFAULT_VECTOR_OFFSET 0x10c
+#define RP2040_PICO_SDK_EXIT_ORIGINAL_HANDLER_OFFSET 0x38
 
 #define RP2040_SYNTHETIC_ROM_DBG_CMD  0x00
 #define RP2040_SYNTHETIC_ROM_DBG_ARG0 0x04
@@ -83,6 +86,7 @@
 #define RP2040_SYNTHETIC_ROM_DBG_RESULT2 0x1c
 #define RP2040_SYNTHETIC_ROM_DBG_RESULT3 0x20
 #define RP2040_SYNTHETIC_ROM_DBG_FLASH_COUNT0 0x40
+#define RP2040_SYNTHETIC_ROM_DBG_CMD_EXIT 0x54495845 /* "EXIT" */
 
 #define RP2040_SYNTHETIC_FP_CMD_MASK   0xffffff00
 #define RP2040_SYNTHETIC_FP_CMD_FLOAT  0x80000000
@@ -471,6 +475,17 @@ static const uint8_t rp2040_bootrom_nyi_stub[] = {
     0x00, 0x00, 0x00, 0x00, /* function code literal */
 };
 
+static const uint8_t rp2040_pico_sdk_exit_trampoline[] = {
+    0x73, 0x46, 0x04, 0x22, 0x13, 0x42, 0x02, 0xd0,
+    0xef, 0xf3, 0x09, 0x80, 0x01, 0xe0, 0xef, 0xf3,
+    0x08, 0x80, 0x81, 0x69, 0x0a, 0x88, 0x05, 0x4b,
+    0x9a, 0x42, 0x05, 0xd1, 0x01, 0x68, 0x04, 0x4a,
+    0x51, 0x60, 0x04, 0x49, 0x11, 0x60, 0xfe, 0xe7,
+    0x03, 0x48, 0x00, 0x47, 0x00, 0xbe, 0x00, 0x00,
+    0x00, 0x00, 0xff, 0x5f, 0x45, 0x58, 0x49, 0x54,
+    0x00, 0x00, 0x00, 0x00,
+};
+
 static void rp2040_store_hword(uint8_t *rom, uint32_t offset, uint16_t value)
 {
     rom[offset] = value;
@@ -1252,6 +1267,12 @@ static void rp2040_synthetic_rom_dbg_write(void *opaque, hwaddr addr,
         return;
     }
 
+    if (command == RP2040_SYNTHETIC_ROM_DBG_CMD_EXIT) {
+        qemu_system_shutdown_request_with_code(SHUTDOWN_CAUSE_GUEST_SHUTDOWN,
+                                               s->synthetic_rom_dbg_arg[0]);
+        return;
+    }
+
     switch (code) {
     case RP2040_ROM_TABLE_CODE('C', 'X'):
         rp2040_synthetic_flash_helper_hit(
@@ -1358,6 +1379,88 @@ static const MemoryRegionOps rp2040_synthetic_rom_dbg_ops = {
     },
 };
 
+static MemTxResult rp2040_pico_sdk_exit_page_read(void *opaque, hwaddr addr,
+                                                  uint64_t *data,
+                                                  unsigned size,
+                                                  MemTxAttrs attrs)
+{
+    RP2040State *s = opaque;
+    MemTxResult result;
+    unsigned int i;
+
+    result = rp2040_xip_read_data(&s->xip, addr, data, size);
+    if (result != MEMTX_OK) {
+        return result;
+    }
+
+    for (i = 0; i < size; i++) {
+        hwaddr cur = addr + i;
+
+        if (cur >= RP2040_APP_HARDFAULT_VECTOR_OFFSET &&
+            cur < RP2040_APP_HARDFAULT_VECTOR_OFFSET + sizeof(uint32_t)) {
+            uint8_t byte = extract32(
+                RP2040_PICO_SDK_EXIT_TRAMPOLINE_BASE | 1,
+                (cur - RP2040_APP_HARDFAULT_VECTOR_OFFSET) * 8, 8);
+
+            *data = deposit64(*data, i * 8, 8, byte);
+        }
+    }
+    return MEMTX_OK;
+}
+
+static MemTxResult rp2040_pico_sdk_exit_page_write(void *opaque,
+                                                   hwaddr addr,
+                                                   uint64_t value,
+                                                   unsigned size,
+                                                   MemTxAttrs attrs)
+{
+    return MEMTX_ERROR;
+}
+
+static const MemoryRegionOps rp2040_pico_sdk_exit_page_ops = {
+    .read_with_attrs = rp2040_pico_sdk_exit_page_read,
+    .write_with_attrs = rp2040_pico_sdk_exit_page_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+        .unaligned = true,
+    },
+};
+
+static void rp2040_pico_sdk_exit_patch_page(RP2040State *s)
+{
+    stl_le_p(s->pico_sdk_exit_page_storage +
+             RP2040_APP_HARDFAULT_VECTOR_OFFSET,
+             RP2040_PICO_SDK_EXIT_TRAMPOLINE_BASE | 1);
+}
+
+static void rp2040_pico_sdk_exit_xip_busy(void *opaque, bool busy)
+{
+    RP2040State *s = opaque;
+
+    if (s->pico_sdk_exit_enabled) {
+        memory_region_rom_device_set_romd(&s->pico_sdk_exit_page, !busy);
+    }
+}
+
+static void rp2040_pico_sdk_exit_xip_changed(void *opaque, hwaddr addr,
+                                             hwaddr size)
+{
+    RP2040State *s = opaque;
+    hwaddr length;
+
+    if (!s->pico_sdk_exit_enabled || addr >= 4 * KiB || !size) {
+        return;
+    }
+
+    length = MIN(size, 4 * KiB - addr);
+    memcpy(s->pico_sdk_exit_page_storage + addr, s->xip.storage + addr,
+           length);
+    rp2040_pico_sdk_exit_patch_page(s);
+    memory_region_flush_rom_device(&s->pico_sdk_exit_page, 0, 4 * KiB);
+}
+
 static void rp2040_update_nmi(RP2040State *s)
 {
     unsigned core;
@@ -1630,6 +1733,15 @@ static bool rp2040_init_memory(RP2040State *s, Error **errp)
     memory_region_add_subregion(s->board_memory,
                                  RP2040_SYNTHETIC_ROM_DBG_BASE,
                                  &s->synthetic_rom_dbg);
+    if (!memory_region_init_rom(&s->pico_sdk_exit_trampoline, OBJECT(s),
+                                "rp2040.pico-sdk-exit-trampoline",
+                                RP2040_PICO_SDK_EXIT_TRAMPOLINE_SIZE, errp)) {
+        return false;
+    }
+    memory_region_add_subregion(s->board_memory,
+                                 RP2040_PICO_SDK_EXIT_TRAMPOLINE_BASE,
+                                 &s->pico_sdk_exit_trampoline);
+    memory_region_set_enabled(&s->pico_sdk_exit_trampoline, false);
     return true;
 }
 
@@ -1676,6 +1788,21 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->xip), 1, RP2040_XIP_CTRL_BASE);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->xip), 2, RP2040_XIP_SSI_BASE);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->xip), 3, RP2040_XIP_AUX_BASE);
+    if (!memory_region_init_rom_device(&s->pico_sdk_exit_page, OBJECT(dev),
+                                       &rp2040_pico_sdk_exit_page_ops, s,
+                                       "rp2040.pico-sdk-exit-page", 4 * KiB,
+                                       errp)) {
+        return;
+    }
+    s->pico_sdk_exit_page_storage =
+        memory_region_get_ram_ptr(&s->pico_sdk_exit_page);
+    memory_region_add_subregion_overlap(
+        s->board_memory, RP2040_XIP_BASE, &s->pico_sdk_exit_page, 1);
+    memory_region_set_enabled(&s->pico_sdk_exit_page, false);
+    rp2040_xip_set_busy_callback(&s->xip,
+                                 rp2040_pico_sdk_exit_xip_busy, s);
+    rp2040_xip_set_changed_callback(&s->xip,
+                                    rp2040_pico_sdk_exit_xip_changed, s);
     memory_region_add_subregion(get_system_memory(), RP2040_XIP_NOALLOC_BASE,
                                 &s->xip.xip_noalloc);
     memory_region_add_subregion(get_system_memory(), RP2040_XIP_NOCACHE_BASE,
@@ -1911,6 +2038,43 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
     rp2040_update_uart_pins(s);
 }
 
+void rp2040_set_pico_sdk_exit(RP2040State *s, bool enabled, Error **errp)
+{
+    uint8_t *trampoline;
+    uint32_t original_handler;
+
+    memory_region_set_enabled(&s->pico_sdk_exit_page, false);
+    memory_region_set_enabled(&s->pico_sdk_exit_trampoline, false);
+    s->pico_sdk_exit_enabled = false;
+    if (!enabled) {
+        return;
+    }
+
+    original_handler = ldl_le_p(
+        s->xip.storage + RP2040_APP_HARDFAULT_VECTOR_OFFSET);
+    if (!(original_handler & 1) || original_handler == UINT32_MAX) {
+        error_setg(errp, "pico-sdk-exit requires a valid Thumb HardFault "
+                   "handler at 0x%08x",
+                   RP2040_XIP_BASE + RP2040_APP_HARDFAULT_VECTOR_OFFSET);
+        return;
+    }
+
+    trampoline = memory_region_get_ram_ptr(&s->pico_sdk_exit_trampoline);
+    memset(trampoline, 0, RP2040_PICO_SDK_EXIT_TRAMPOLINE_SIZE);
+    memcpy(trampoline, rp2040_pico_sdk_exit_trampoline,
+           sizeof(rp2040_pico_sdk_exit_trampoline));
+    stl_le_p(trampoline + RP2040_PICO_SDK_EXIT_ORIGINAL_HANDLER_OFFSET,
+             original_handler);
+    s->pico_sdk_exit_original_handler = original_handler;
+    memcpy(s->pico_sdk_exit_page_storage, s->xip.storage, 4 * KiB);
+    rp2040_pico_sdk_exit_patch_page(s);
+    memory_region_flush_rom_device(&s->pico_sdk_exit_page, 0, 4 * KiB);
+    memory_region_rom_device_set_romd(&s->pico_sdk_exit_page, !s->xip.busy);
+    s->pico_sdk_exit_enabled = true;
+    memory_region_set_enabled(&s->pico_sdk_exit_trampoline, true);
+    memory_region_set_enabled(&s->pico_sdk_exit_page, true);
+}
+
 static const Property rp2040_soc_properties[] = {
     DEFINE_PROP_LINK("memory", RP2040State, board_memory, TYPE_MEMORY_REGION,
                      MemoryRegion *),
diff --git a/hw/ssi/rp2040_xip.c b/hw/ssi/rp2040_xip.c
index 4312a88b6f..738629749e 100644
--- a/hw/ssi/rp2040_xip.c
+++ b/hw/ssi/rp2040_xip.c
@@ -306,13 +306,21 @@ static uint8_t rp2040_xip_flash_uid_byte(RP2040XipState *s, unsigned index)
 
 static void rp2040_xip_set_busy(RP2040XipState *s, bool busy)
 {
+    bool changed = s->busy != busy;
+
     s->busy = busy;
     memory_region_rom_device_set_romd(&s->xip, !busy);
+    if (changed && s->busy_cb) {
+        s->busy_cb(s->busy_opaque, busy);
+    }
 }
 
 static void rp2040_xip_changed(RP2040XipState *s, hwaddr addr, hwaddr size)
 {
     memory_region_flush_rom_device(&s->xip, addr, size);
+    if (s->changed_cb) {
+        s->changed_cb(s->changed_opaque, addr, size);
+    }
 }
 
 static void rp2040_xip_finish_busy(RP2040XipState *s)
@@ -1060,6 +1068,22 @@ void rp2040_xip_set_writable(RP2040XipState *s, bool writable)
     s->xip_writable = writable;
 }
 
+void rp2040_xip_set_busy_callback(RP2040XipState *s,
+                                  RP2040XipBusyCallback callback,
+                                  void *opaque)
+{
+    s->busy_cb = callback;
+    s->busy_opaque = opaque;
+}
+
+void rp2040_xip_set_changed_callback(RP2040XipState *s,
+                                     RP2040XipChangedCallback callback,
+                                     void *opaque)
+{
+    s->changed_cb = callback;
+    s->changed_opaque = opaque;
+}
+
 void rp2040_xip_qspi_cs(RP2040XipState *s, bool high)
 {
     if (s->qspi_cs_high == high) {
diff --git a/include/hw/arm/rp2040.h b/include/hw/arm/rp2040.h
index e13610d71c..498d36dd5c 100644
--- a/include/hw/arm/rp2040.h
+++ b/include/hw/arm/rp2040.h
@@ -54,6 +54,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(RP2040State, RP2040)
 #define RP2040_USBCTRL_REGS_SIZE  0x4000
 #define RP2040_SYNTHETIC_ROM_DBG_BASE 0x5fff0000
 #define RP2040_SYNTHETIC_ROM_DBG_SIZE 0x1000
+#define RP2040_PICO_SDK_EXIT_TRAMPOLINE_BASE 0x00004000
+#define RP2040_PICO_SDK_EXIT_TRAMPOLINE_SIZE 0x1000
 #define RP2040_SYNTHETIC_ROM_FLASH_HELPER_COUNT 6
 
 #define RP2040_NUM_CORES      2
@@ -94,6 +96,9 @@ struct RP2040State {
     MemoryRegion usbctrl_dpram;
     MemoryRegion usbctrl_regs;
     MemoryRegion synthetic_rom_dbg;
+    MemoryRegion pico_sdk_exit_trampoline;
+    MemoryRegion pico_sdk_exit_page;
+    uint8_t *pico_sdk_exit_page_storage;
     uint32_t usbctrl_reg[0x100 / sizeof(uint32_t)];
     char *bootrom_file;
 
@@ -110,8 +115,12 @@ struct RP2040State {
     uint32_t synthetic_rom_dbg_result[4];
     uint32_t synthetic_rom_flash_helper_count[
         RP2040_SYNTHETIC_ROM_FLASH_HELPER_COUNT];
+    uint32_t pico_sdk_exit_original_handler;
+    bool pico_sdk_exit_enabled;
 
     Clock *sysclk;
 };
 
+void rp2040_set_pico_sdk_exit(RP2040State *s, bool enabled, Error **errp);
+
 #endif
diff --git a/include/hw/ssi/rp2040_xip.h b/include/hw/ssi/rp2040_xip.h
index f132ec1ba5..f06f90ba9b 100644
--- a/include/hw/ssi/rp2040_xip.h
+++ b/include/hw/ssi/rp2040_xip.h
@@ -14,6 +14,10 @@
 #define TYPE_RP2040_XIP "rp2040-xip"
 OBJECT_DECLARE_SIMPLE_TYPE(RP2040XipState, RP2040_XIP)
 
+typedef void (*RP2040XipBusyCallback)(void *opaque, bool busy);
+typedef void (*RP2040XipChangedCallback)(void *opaque, hwaddr addr,
+                                         hwaddr size);
+
 #define RP2040_XIP_CTRL_BASE 0x14000000
 #define RP2040_XIP_SSI_BASE  0x18000000
 #define RP2040_XIP_AUX_BASE  0x50400000
@@ -40,6 +44,10 @@ struct RP2040XipState {
     uint64_t flash_uid;
     uint8_t *storage;
     bool xip_writable;
+    RP2040XipBusyCallback busy_cb;
+    void *busy_opaque;
+    RP2040XipChangedCallback changed_cb;
+    void *changed_opaque;
 
     uint32_t xip_ctrl;
 
@@ -79,6 +87,12 @@ struct RP2040XipState {
 };
 
 void rp2040_xip_set_writable(RP2040XipState *s, bool writable);
+void rp2040_xip_set_busy_callback(RP2040XipState *s,
+                                  RP2040XipBusyCallback callback,
+                                  void *opaque);
+void rp2040_xip_set_changed_callback(RP2040XipState *s,
+                                     RP2040XipChangedCallback callback,
+                                     void *opaque);
 MemTxResult rp2040_xip_read_data(RP2040XipState *s, hwaddr addr,
                                  uint64_t *data, unsigned size);
 void rp2040_xip_load_image(RP2040XipState *s, const char *filename,
diff --git a/tests/tcg/arm/system/meson.build b/tests/tcg/arm/system/meson.build
index b410e004d0..edb0de1b34 100644
--- a/tests/tcg/arm/system/meson.build
+++ b/tests/tcg/arm/system/meson.build
@@ -28,6 +28,7 @@ rp2040_uart1_qemu_args = ['-M', 'raspi-pico,strict-uart-pins=off',
                           '-monitor', 'none', '-serial', 'null',
                           '-serial', 'stdio', qemu_base_args]
 rp2040_flash_persist = find_program('rp2040-flash-persist.sh')
+rp2040_check_exit = find_program('rp2040-check-exit.sh')
 
 # Multi arch tests
 multi_src = []
@@ -172,6 +173,31 @@ tests += {
     'qemu_args': rp2040_uart_qemu_args,
     'expected_output': 'rp2040-flash-lockout.ref',
   },
+  'rp2040-bkpt-hardfault.S': {
+    'cflags': rp2040_cflags,
+    'qemu_args': rp2040_uart_qemu_args,
+    'expected_output': 'rp2040-bkpt-hardfault.ref',
+  },
+  'rp2040-exit.S': {
+    'exe_name': 'rp2040-semihost-exit',
+    'test_name': 'rp2040-semihost-exit',
+    'cflags': rp2040_cflags + ['-DEXIT_MODE=0'],
+    'qemu_args': ['-M', 'raspi-pico', '-monitor', 'none',
+                  '-serial', 'none', qemu_base_args],
+    'wrapper': [rp2040_check_exit, '23'],
+  },
+}
+
+tests += {
+  'rp2040-exit.S': {
+    'exe_name': 'rp2040-pico-sdk-exit',
+    'test_name': 'rp2040-pico-sdk-exit',
+    'cflags': rp2040_cflags + ['-DEXIT_MODE=1'],
+    'qemu_args': ['-M', 'raspi-pico,pico-sdk-exit=on',
+                  '-monitor', 'none', '-display', 'none',
+                  '-serial', 'none', '-kernel'],
+    'wrapper': [rp2040_check_exit, '23'],
+  },
   'semiconsole.c': {
     'cflags': cflags,
     'qemu_args': ['-serial', 'none', '-chardev', 'stdio,mux=on,id=stdio0',
diff --git a/tests/tcg/arm/system/rp2040-bkpt-hardfault.S b/tests/tcg/arm/system/rp2040-bkpt-hardfault.S
new file mode 100644
index 0000000000..68873d6a8d
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-bkpt-hardfault.S
@@ -0,0 +1,94 @@
+/*
+ * Raspberry Pi Pico BKPT-to-HardFault test
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+.syntax unified
+.cpu cortex-m0plus
+.thumb
+
+#define SRAM_END               0x20042000
+#define UART0_DR               0x40034000
+#define HARDFAULT_EXCEPTION    3
+#define SYS_EXIT               0x18
+#define ADP_STOPPED_APPLICATION_EXIT 0x20026
+#define ADP_STOPPED_RUNTIME_ERROR    0x20023
+
+.section .vectors, "a", %progbits
+.global vector_table
+vector_table:
+    .word SRAM_END
+    .word reset_handler + 1
+    .word default_handler + 1
+    .word hardfault_handler + 1
+
+.section .text, "ax", %progbits
+.thumb_func
+.global reset_handler
+reset_handler:
+    ldr r0, =start_message
+    bl puts
+    bkpt 0
+
+    ldr r0, =fail_return_message
+    b test_failed
+
+.thumb_func
+hardfault_handler:
+    mrs r0, ipsr
+    cmp r0, HARDFAULT_EXCEPTION
+    bne fail_exception
+
+    ldr r0, =ok_message
+    bl puts
+    movs r0, SYS_EXIT
+    ldr r1, =ADP_STOPPED_APPLICATION_EXIT
+    bkpt 0xab
+
+1:
+    b 1b
+
+fail_exception:
+    ldr r0, =fail_exception_message
+
+test_failed:
+    bl puts
+    movs r0, SYS_EXIT
+    ldr r1, =ADP_STOPPED_RUNTIME_ERROR
+    bkpt 0xab
+
+2:
+    b 2b
+
+.thumb_func
+default_handler:
+    ldr r0, =fail_vector_message
+    b test_failed
+
+.thumb_func
+puts:
+    ldr r2, =UART0_DR
+
+3:
+    ldrb r1, [r0]
+    cmp r1, 0
+    beq 4f
+    str r1, [r2]
+    adds r0, 1
+    b 3b
+
+4:
+    bx lr
+
+.section .rodata, "a", %progbits
+start_message:
+    .asciz "PICO TCG BKPT START\n"
+ok_message:
+    .asciz "PICO TCG BKPT HARDFAULT OK\n"
+fail_return_message:
+    .asciz "PICO TCG BKPT FAIL: RETURNED\n"
+fail_exception_message:
+    .asciz "PICO TCG BKPT FAIL: IPSR\n"
+fail_vector_message:
+    .asciz "PICO TCG BKPT FAIL: VECTOR\n"
diff --git a/tests/tcg/arm/system/rp2040-bkpt-hardfault.ref b/tests/tcg/arm/system/rp2040-bkpt-hardfault.ref
new file mode 100644
index 0000000000..0f023cf1e7
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-bkpt-hardfault.ref
@@ -0,0 +1,2 @@
+PICO TCG BKPT START
+PICO TCG BKPT HARDFAULT OK
diff --git a/tests/tcg/arm/system/rp2040-check-exit.sh b/tests/tcg/arm/system/rp2040-check-exit.sh
new file mode 100755
index 0000000000..0622b21219
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-check-exit.sh
@@ -0,0 +1,14 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -u
+
+expected=$1
+shift
+
+"$@"
+status=$?
+if test "$status" -ne "$expected"; then
+    echo "unexpected exit status: got $status, expected $expected" >&2
+    exit 1
+fi
diff --git a/tests/tcg/arm/system/rp2040-exit.S b/tests/tcg/arm/system/rp2040-exit.S
new file mode 100644
index 0000000000..ad6d428bd7
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-exit.S
@@ -0,0 +1,55 @@
+/*
+ * Raspberry Pi Pico host-exit behavior tests
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+.syntax unified
+.cpu cortex-m0plus
+.thumb
+
+#ifndef EXIT_MODE
+#error EXIT_MODE must select semihosting or Pico SDK exit
+#endif
+
+#define EXIT_MODE_SEMIHOST      0
+#define EXIT_MODE_PICO_SDK      1
+#define SRAM_END                0x20042000
+#define SYS_EXIT_EXTENDED       0x20
+#define ADP_STOPPED_APPLICATION_EXIT 0x20026
+#define TEST_EXIT_STATUS        23
+
+.section .vectors, "a", %progbits
+vector_table:
+    .word SRAM_END
+    .word reset_handler + 1
+    .word hardfault_handler + 1
+    .word hardfault_handler + 1
+
+.section .text, "ax", %progbits
+.thumb_func
+.global reset_handler
+reset_handler:
+#if EXIT_MODE == EXIT_MODE_SEMIHOST
+    movs r0, SYS_EXIT_EXTENDED
+    ldr r1, =semihost_exit_block
+    bkpt 0xab
+#elif EXIT_MODE == EXIT_MODE_PICO_SDK
+    movs r0, TEST_EXIT_STATUS
+    bkpt 0
+#else
+#error Unsupported EXIT_MODE
+#endif
+
+1:
+    b 1b
+
+.thumb_func
+hardfault_handler:
+    b hardfault_handler
+
+.section .rodata, "a", %progbits
+.align 2
+semihost_exit_block:
+    .word ADP_STOPPED_APPLICATION_EXIT
+    .word TEST_EXIT_STATUS
-- 
2.55.0


