Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD5DC61DB9
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2026 06:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0YsI-0003e1-Ab; Sun, 30 Aug 2026 02:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0YsG-0003Z5-4G; Sun, 30 Aug 2026 02:18:36 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0YsD-0005Na-GV; Sun, 30 Aug 2026 02:18:35 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4hXhjq4Zpzz835H;
 Sun, 30 Aug 2026 08:17:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788070639;
 bh=2jNIm2DZsw+/80O3hSGisl0rPQJu2OjNuzFE/l70qI0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qPySLHTE+K2+T1yxxY1YF8HaskOVJa/wY8nTUm/B//BnQbZcdtOty8c9Kxb4WQN5V
 4MyssybP/fVRg9MQi1LFbtmyuFnxgseP15C/a80CCXM7t0NXBKOQKePK3wRv4QGwQh
 1UuNdOzjeb84nJ3aipslapQEbbvOOzQ7tiwMZg/gK105y+MKKeXxZLLYIrA+H/opO6
 vLJpvygvNbPD+TuorBzRMSUalE8XAYi6ChYiqVjJFlmD+V/qTky6DUHO1ccLcrM/Oq
 pbPcDAA2NHn/m/NlMiv4V8DALWEzhzngKBDxb07l0SiN3tCscRLmCEyaEJpIJ+DgKw
 dKJ7rjH6GHnjg==
Received: from localhost.localdomain (unknown [10.134.14.34])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hXhjq33M6z7swM;
 Sun, 30 Aug 2026 08:17:19 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH RFC v2 29/30] hw/arm: add optional Pico SDK exit handling
Date: Sun, 30 Aug 2026 08:16:00 +0200
Message-ID: <20260830061601.52136-15-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
References: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
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

From: gilles grimaud <gilles.grimaud@univ-lille.fr>

Add an opt-in raspi-pico machine property that converts the Pico SDK's BKPT #0 exit convention into a QEMU guest shutdown. Keep the default architectural BKPT-to-HardFault behavior unchanged and chain non-BKPT faults to the application handler.

Cover the default HardFault path, explicit semihosting exit, and the optional Pico SDK exit path with compiled check-tcg guests.

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/arm/raspi_pico.c                           |  23 ++++
 hw/arm/rp2040.c                               | 117 ++++++++++++++++++
 include/hw/arm/rp2040.h                       |   7 ++
 tests/tcg/arm/Makefile.softmmu-target         |  50 ++++++++
 tests/tcg/arm/system/rp2040-bkpt-hardfault.S  |  94 ++++++++++++++
 .../tcg/arm/system/rp2040-bkpt-hardfault.ref  |   2 +
 tests/tcg/arm/system/rp2040-exit.S            |  55 ++++++++
 7 files changed, 348 insertions(+)
 create mode 100644 tests/tcg/arm/system/rp2040-bkpt-hardfault.S
 create mode 100644 tests/tcg/arm/system/rp2040-bkpt-hardfault.ref
 create mode 100644 tests/tcg/arm/system/rp2040-exit.S

diff --git a/hw/arm/raspi_pico.c b/hw/arm/raspi_pico.c
index 2696a24951..2f87ee1a2d 100644
--- a/hw/arm/raspi_pico.c
+++ b/hw/arm/raspi_pico.c
@@ -34,6 +34,7 @@ struct RaspiPicoMachineState {
     uint64_t rosc_random_seed_value;
     bool rosc_random_seed_set;
     bool strict_uart_pins;
+    bool pico_sdk_exit;
 };
 
 static char *raspi_pico_get_flash_file(Object *obj, Error **errp)
@@ -164,6 +165,7 @@ static void raspi_pico_init(MachineState *machine)
 
     rp2040_xip_load_image(&s->soc.xip, machine->kernel_filename,
                           &error_fatal);
+    rp2040_set_pico_sdk_exit(&s->soc, s->pico_sdk_exit, &error_fatal);
     armv7m_load_kernel(s->soc.armv7m[0].cpu, NULL,
                        RP2040_XIP_BASE, 2 * MiB);
     rp2040_xip_set_writable(&s->soc.xip, false);
@@ -193,6 +195,21 @@ static void raspi_pico_set_strict_uart_pins(Object *obj, bool value,
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
@@ -241,6 +258,12 @@ static void raspi_pico_machine_class_init(ObjectClass *oc, const void *data)
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
index 6c06570586..fc61088d82 100644
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
@@ -76,6 +77,8 @@
 #define RP2040_BOOTROM_FLOAT_STUBS_OFFSET 0x0600
 #define RP2040_BOOTROM_DOUBLE_STUBS_OFFSET 0x0b00
 #define RP2040_BOOTROM_FP_STUB_SIZE 36
+#define RP2040_APP_HARDFAULT_VECTOR_OFFSET 0x10c
+#define RP2040_PICO_SDK_EXIT_ORIGINAL_HANDLER_OFFSET 0x38
 
 #define RP2040_SYNTHETIC_ROM_DBG_CMD  0x00
 #define RP2040_SYNTHETIC_ROM_DBG_ARG0 0x04
@@ -87,6 +90,7 @@
 #define RP2040_SYNTHETIC_ROM_DBG_RESULT2 0x1c
 #define RP2040_SYNTHETIC_ROM_DBG_RESULT3 0x20
 #define RP2040_SYNTHETIC_ROM_DBG_FLASH_COUNT0 0x40
+#define RP2040_SYNTHETIC_ROM_DBG_CMD_EXIT 0x54495845 /* "EXIT" */
 
 #define RP2040_SYNTHETIC_FP_CMD_MASK   0xffffff00
 #define RP2040_SYNTHETIC_FP_CMD_FLOAT  0x80000000
@@ -475,6 +479,17 @@ static const uint8_t rp2040_bootrom_nyi_stub[] = {
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
@@ -1316,6 +1331,12 @@ static void rp2040_synthetic_rom_dbg_write(void *opaque, hwaddr addr,
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
@@ -1421,6 +1442,55 @@ static const MemoryRegionOps rp2040_synthetic_rom_dbg_ops = {
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
 static void rp2040_update_nmi(RP2040State *s)
 {
     uint32_t nmi_mask = rp2040_syscfg_get_proc0_nmi_mask(&s->syscfg);
@@ -1729,6 +1799,15 @@ static bool rp2040_init_memory(RP2040State *s, Error **errp)
     memory_region_add_subregion(s->board_memory,
                                 RP2040_SYNTHETIC_ROM_DBG_BASE,
                                 &s->synthetic_rom_dbg);
+    if (!memory_region_init_rom(&s->pico_sdk_exit_trampoline, OBJECT(s),
+                                "rp2040.pico-sdk-exit-trampoline",
+                                RP2040_PICO_SDK_EXIT_TRAMPOLINE_SIZE, errp)) {
+        return false;
+    }
+    memory_region_add_subregion(s->board_memory,
+                                RP2040_PICO_SDK_EXIT_TRAMPOLINE_BASE,
+                                &s->pico_sdk_exit_trampoline);
+    memory_region_set_enabled(&s->pico_sdk_exit_trampoline, false);
 
     s->mempowerdown_ready = true;
 
@@ -1778,6 +1857,13 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->xip), 1, RP2040_XIP_CTRL_BASE);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->xip), 2, RP2040_XIP_SSI_BASE);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->xip), 3, RP2040_XIP_AUX_BASE);
+    /* A page-sized overlay avoids QEMU's slower subpage dispatch path. */
+    memory_region_init_io(&s->pico_sdk_exit_page, OBJECT(dev),
+                          &rp2040_pico_sdk_exit_page_ops, s,
+                          "rp2040.pico-sdk-exit-page", 4 * KiB);
+    memory_region_add_subregion_overlap(
+        s->board_memory, RP2040_XIP_BASE, &s->pico_sdk_exit_page, 1);
+    memory_region_set_enabled(&s->pico_sdk_exit_page, false);
     memory_region_add_subregion(get_system_memory(), RP2040_XIP_NOALLOC_BASE,
                                 &s->xip.xip_noalloc);
     memory_region_add_subregion(get_system_memory(), RP2040_XIP_NOCACHE_BASE,
@@ -2001,6 +2087,37 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
     rp2040_update_uart_pins(s);
 }
 
+void rp2040_set_pico_sdk_exit(RP2040State *s, bool enabled, Error **errp)
+{
+    uint8_t *trampoline;
+    uint32_t original_handler;
+
+    memory_region_set_enabled(&s->pico_sdk_exit_page, false);
+    memory_region_set_enabled(&s->pico_sdk_exit_trampoline, false);
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
+    memory_region_set_enabled(&s->pico_sdk_exit_trampoline, true);
+    memory_region_set_enabled(&s->pico_sdk_exit_page, true);
+}
+
 static const Property rp2040_soc_properties[] = {
     DEFINE_PROP_LINK("memory", RP2040State, board_memory, TYPE_MEMORY_REGION,
                      MemoryRegion *),
diff --git a/include/hw/arm/rp2040.h b/include/hw/arm/rp2040.h
index 29269c913b..2e65e76893 100644
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
@@ -96,6 +98,8 @@ struct RP2040State {
     MemoryRegion usbctrl_dpram_poweroff;
     MemoryRegion usbctrl_regs;
     MemoryRegion synthetic_rom_dbg;
+    MemoryRegion pico_sdk_exit_trampoline;
+    MemoryRegion pico_sdk_exit_page;
     uint32_t usbctrl_reg[0x100 / sizeof(uint32_t)];
     char *bootrom_file;
 
@@ -113,8 +117,11 @@ struct RP2040State {
     uint32_t synthetic_rom_dbg_result[4];
     uint32_t synthetic_rom_flash_helper_count[
         RP2040_SYNTHETIC_ROM_FLASH_HELPER_COUNT];
+    uint32_t pico_sdk_exit_original_handler;
 
     Clock *sysclk;
 };
 
+void rp2040_set_pico_sdk_exit(RP2040State *s, bool enabled, Error **errp);
+
 #endif
diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefile.softmmu-target
index 2f5878c1fa..19355ee2c4 100644
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ b/tests/tcg/arm/Makefile.softmmu-target
@@ -152,6 +152,56 @@ run-rp2040-bootrom-float run-rp2040-flash-lockout: run-%: %
 
 RP2040_TESTS+=rp2040-bootrom-float rp2040-flash-lockout
 
+rp2040-bkpt-hardfault: rp2040-bkpt-hardfault.S \
+		rp2040-boot2-w25q080.S rp2040.ld
+	$(CC) -mcpu=cortex-m0plus -mthumb -mfloat-abi=soft \
+		-Wl,--build-id=none -x assembler-with-cpp \
+		$(ARM_SRC)/rp2040-boot2-w25q080.S $< \
+		-o $@ -nostdlib -static \
+		-T $(ARM_SRC)/rp2040.ld
+
+run-rp2040-bkpt-hardfault: QEMU_OPTS=-M raspi-pico,strict-uart-pins=off \
+	-serial chardev:output \
+	-semihosting-config enable=on,target=native -kernel
+run-rp2040-bkpt-hardfault: rp2040-bkpt-hardfault
+	$(call run-test, $<, \
+	  $(QEMU) -monitor none -display none \
+		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
+		  $(QEMU_OPTS) $<)
+	$(call diff-out,$<,$(ARM_SRC)/rp2040-bkpt-hardfault.ref)
+
+RP2040_TESTS+=rp2040-bkpt-hardfault
+
+rp2040-semihost-exit: rp2040-exit.S \
+		rp2040-boot2-w25q080.S rp2040.ld
+	$(CC) -mcpu=cortex-m0plus -mthumb -mfloat-abi=soft \
+		-DEXIT_MODE=0 -Wl,--build-id=none -x assembler-with-cpp \
+		$(ARM_SRC)/rp2040-boot2-w25q080.S $< \
+		-o $@ -nostdlib -static \
+		-T $(ARM_SRC)/rp2040.ld
+
+run-rp2040-semihost-exit: rp2040-semihost-exit
+	@$(QEMU) -M raspi-pico -monitor none -display none -serial none \
+		-semihosting-config enable=on$(COMMA)target=native \
+		-kernel $<; rc=$$?; test $$rc -eq 23
+
+RP2040_TESTS+=rp2040-semihost-exit
+
+rp2040-pico-sdk-exit: rp2040-exit.S \
+		rp2040-boot2-w25q080.S rp2040.ld
+	$(CC) -mcpu=cortex-m0plus -mthumb -mfloat-abi=soft \
+		-DEXIT_MODE=1 -Wl,--build-id=none -x assembler-with-cpp \
+		$(ARM_SRC)/rp2040-boot2-w25q080.S $< \
+		-o $@ -nostdlib -static \
+		-T $(ARM_SRC)/rp2040.ld
+
+run-rp2040-pico-sdk-exit: rp2040-pico-sdk-exit
+	@$(QEMU) -M raspi-pico$(COMMA)pico-sdk-exit=on \
+		-monitor none -display none -serial none -kernel $<; \
+		rc=$$?; test $$rc -eq 23
+
+RP2040_TESTS+=rp2040-pico-sdk-exit
+
 ARM_TESTS+=$(RP2040_TESTS) $(RP2040_FLASH_TESTS) $(RP2040_DMA_TESTS)
 
 # These objects provide the basic boot code and helper functions for all tests
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


