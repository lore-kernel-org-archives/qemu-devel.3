Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8F2C61DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2026 06:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0YrU-0002bd-7U; Sun, 30 Aug 2026 02:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0YrO-0002Yy-Rh; Sun, 30 Aug 2026 02:17:43 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0YrK-0005Ht-1V; Sun, 30 Aug 2026 02:17:42 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4hXhjn72s6zBqYc;
 Sun, 30 Aug 2026 08:17:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788070638;
 bh=4xhwuyr+n+QcNUv2R7Y25aXIh4SEgz71s++aYNYTmtQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RsDeLa/U81SaWNUi57FEDeBFwgrcSznNBvaR63L37m83CBs5ktzk+9f4SK4dZyUct
 WCGb2+6EaVD6iitlZPVgT4dE8yFc6PH1MSYwXYcGvErhOr4GFnTXUFECdUZmVbc6CC
 cXhR1tmKSYh4NKu6qp37a25RLew210msdfwkXT0QVJmk+sbL9fvMtp1WTl0LE/41Is
 4ra2SpnUmgGHCB8jDSqVf3VsMgw0aRnvdVzFn0fFe3+dTUK6QwJlrWJwqHlbhdVqkH
 3bSzE2Nu8dr+eLWkiJzj+pkR4tvH+9IqzWMQGA5I84ztWF86Zgk71ybykA/pCu/BJF
 902W9BDvinuTw==
Received: from localhost.localdomain (unknown [10.134.14.34])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hXhjn5YCWz7xSW;
 Sun, 30 Aug 2026 08:17:17 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH RFC v2 20/30] hw/ssi: add RP2040 XIP flash controller
Date: Sun, 30 Aug 2026 08:15:51 +0200
Message-ID: <20260830061601.52136-6-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
References: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.82;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-1.univ-lille.fr
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

Model the XIP windows, cache control registers, SSI interface and external NOR flash commands. Add raw-file persistence, configurable flash UID and focused qtests, and connect IO_QSPI chip-select overrides.

Update the synthetic boot path and existing TCG guests to execute a compiled second-stage boot block. The boot2 source is derived from the Raspberry Pi Pico SDK and therefore retains its BSD-3-Clause license.

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/arm/Kconfig                                |    1 +
 hw/arm/raspi_pico.c                           |  103 +-
 hw/arm/rp2040.c                               |  154 +-
 hw/misc/rp2040_ioqspi.c                       |   31 +
 hw/ssi/Kconfig                                |    3 +
 hw/ssi/meson.build                            |    1 +
 hw/ssi/rp2040_xip.c                           | 1348 +++++++++++++++++
 hw/ssi/trace-events                           |   12 +
 include/hw/arm/rp2040.h                       |    5 +
 include/hw/misc/rp2040_ioqspi.h               |    3 +
 include/hw/ssi/rp2040_xip.h                   |   92 ++
 tests/qtest/meson.build                       |    3 +-
 tests/qtest/rp2040-xip-test.c                 |  293 ++++
 tests/tcg/arm/Makefile.softmmu-target         |    7 +-
 tests/tcg/arm/system/rp2040-boot2-w25q080.S   |  178 +++
 .../system/{rp2040-minimal.ld => rp2040.ld}   |   11 +-
 16 files changed, 2200 insertions(+), 45 deletions(-)
 create mode 100644 hw/ssi/rp2040_xip.c
 create mode 100644 include/hw/ssi/rp2040_xip.h
 create mode 100644 tests/qtest/rp2040-xip-test.c
 create mode 100644 tests/tcg/arm/system/rp2040-boot2-w25q080.S
 rename tests/tcg/arm/system/{rp2040-minimal.ld => rp2040.ld} (72%)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 81cd84b642..dad91b368d 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -394,6 +394,7 @@ config RP2040
     select RP2040_TIMER
     select RP2040_VREG
     select RP2040_WATCHDOG
+    select RP2040_XIP
     select RP2040_XOSC
     select UNIMP
 
diff --git a/hw/arm/raspi_pico.c b/hw/arm/raspi_pico.c
index dd07c58801..2696a24951 100644
--- a/hw/arm/raspi_pico.c
+++ b/hw/arm/raspi_pico.c
@@ -22,19 +22,82 @@
 #define TYPE_RASPI_PICO_MACHINE MACHINE_TYPE_NAME("raspi-pico")
 OBJECT_DECLARE_SIMPLE_TYPE(RaspiPicoMachineState, RASPI_PICO_MACHINE)
 
-#define PICO_FLASH_SIZE (2 * MiB)
-
 struct RaspiPicoMachineState {
     MachineState parent_obj;
 
     RP2040State soc;
-    MemoryRegion flash;
+    char *flash_file;
+    char *flash_uid;
+    uint64_t flash_uid_value;
+    bool flash_uid_set;
     char *rosc_random_seed;
     uint64_t rosc_random_seed_value;
     bool rosc_random_seed_set;
     bool strict_uart_pins;
 };
 
+static char *raspi_pico_get_flash_file(Object *obj, Error **errp)
+{
+    RaspiPicoMachineState *s = RASPI_PICO_MACHINE(obj);
+
+    return g_strdup(s->flash_file ?: "");
+}
+
+static void raspi_pico_set_flash_file(Object *obj, const char *value,
+                                      Error **errp)
+{
+    RaspiPicoMachineState *s = RASPI_PICO_MACHINE(obj);
+
+    g_free(s->flash_file);
+    s->flash_file = g_strdup(value);
+}
+
+static char *raspi_pico_get_flash_uid(Object *obj, Error **errp)
+{
+    RaspiPicoMachineState *s = RASPI_PICO_MACHINE(obj);
+
+    return g_strdup(s->flash_uid ?: "");
+}
+
+static void raspi_pico_set_flash_uid(Object *obj, const char *value,
+                                     Error **errp)
+{
+    RaspiPicoMachineState *s = RASPI_PICO_MACHINE(obj);
+    const char *p;
+    uint64_t uid;
+    int i;
+
+    if (!value || !*value) {
+        g_free(s->flash_uid);
+        s->flash_uid = NULL;
+        s->flash_uid_value = 0;
+        s->flash_uid_set = false;
+        return;
+    }
+
+    p = g_str_has_prefix(value, "0x") || g_str_has_prefix(value, "0X") ?
+        value + 2 : value;
+    if (strlen(p) != 16) {
+        error_setg(errp, "flash-uid must be exactly 16 hexadecimal digits");
+        return;
+    }
+    for (i = 0; i < 16; i++) {
+        if (!g_ascii_isxdigit(p[i])) {
+            error_setg(errp, "invalid flash-uid '%s'", value);
+            return;
+        }
+    }
+    if (qemu_strtou64(p, NULL, 16, &uid) < 0) {
+        error_setg(errp, "invalid flash-uid '%s'", value);
+        return;
+    }
+
+    g_free(s->flash_uid);
+    s->flash_uid = g_strdup(value);
+    s->flash_uid_value = uid;
+    s->flash_uid_set = true;
+}
+
 static char *raspi_pico_get_rosc_random_seed(Object *obj, Error **errp)
 {
     RaspiPicoMachineState *s = RASPI_PICO_MACHINE(obj);
@@ -82,6 +145,14 @@ static void raspi_pico_init(MachineState *machine)
     qdev_prop_set_bit(DEVICE(&s->soc.rosc), "random-seed-set",
                       s->rosc_random_seed_set);
     qdev_prop_set_uint32(DEVICE(&s->soc.sio), "gpio-hi-in", 1u << 1);
+    if (s->flash_file) {
+        qdev_prop_set_string(DEVICE(&s->soc.xip), "flash-file",
+                             s->flash_file);
+    }
+    if (s->flash_uid_set) {
+        qdev_prop_set_uint64(DEVICE(&s->soc.xip), "flash-uid",
+                             s->flash_uid_value);
+    }
     if (machine->firmware) {
         qdev_prop_set_string(DEVICE(&s->soc), "bootrom-file",
                              machine->firmware);
@@ -89,20 +160,21 @@ static void raspi_pico_init(MachineState *machine)
     object_property_set_link(OBJECT(&s->soc), "memory",
                              OBJECT(system_memory), &error_fatal);
 
-    memory_region_init_rom(&s->flash, NULL, "raspi-pico.flash",
-                           PICO_FLASH_SIZE, &error_fatal);
-    memory_region_add_subregion(system_memory, RP2040_XIP_BASE, &s->flash);
-
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
-    armv7m_load_kernel(s->soc.armv7m[0].cpu, machine->kernel_filename,
-                       RP2040_XIP_BASE, PICO_FLASH_SIZE);
+    rp2040_xip_load_image(&s->soc.xip, machine->kernel_filename,
+                          &error_fatal);
+    armv7m_load_kernel(s->soc.armv7m[0].cpu, NULL,
+                       RP2040_XIP_BASE, 2 * MiB);
+    rp2040_xip_set_writable(&s->soc.xip, false);
 }
 
 static void raspi_pico_machine_finalize(Object *obj)
 {
     RaspiPicoMachineState *s = RASPI_PICO_MACHINE(obj);
 
+    g_free(s->flash_file);
+    g_free(s->flash_uid);
     g_free(s->rosc_random_seed);
 }
 
@@ -142,6 +214,19 @@ static void raspi_pico_machine_class_init(ObjectClass *oc, const void *data)
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
 
+    object_class_property_add_str(oc, "flash-file",
+                                  raspi_pico_get_flash_file,
+                                  raspi_pico_set_flash_file);
+    object_class_property_set_description(oc, "flash-file",
+                                          "Load initial XIP flash contents "
+                                          "from a raw host file");
+    object_class_property_add_str(oc, "flash-uid",
+                                  raspi_pico_get_flash_uid,
+                                  raspi_pico_set_flash_uid);
+    object_class_property_set_description(oc, "flash-uid",
+                                          "Set the emulated external flash "
+                                          "64-bit unique ID as 16 hex digits");
+
     object_class_property_add_str(oc, "rosc-random-seed",
                                   raspi_pico_get_rosc_random_seed,
                                   raspi_pico_set_rosc_random_seed);
diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
index 79c7fda151..3a8c8f88af 100644
--- a/hw/arm/rp2040.c
+++ b/hw/arm/rp2040.c
@@ -16,6 +16,7 @@
 #include "hw/core/irq.h"
 #include "hw/misc/unimp.h"
 #include "qemu/datadir.h"
+#include "system/address-spaces.h"
 #include "target/arm/cpu.h"
 #include "target/arm/cpu-qom.h"
 
@@ -29,37 +30,109 @@
 #define RP2040_PROC1          1
 
 /*
- * Minimal synthetic ROM. Core 0 enters the XIP image while core 1 waits for
- * the RP2040 ROM FIFO launch sequence: { 0, 0, 1, VTOR, SP, PC }.
+ * Temporary boot ROM used until a faithful RP2040 boot ROM is requested.  It
+ * uses SIO_CPUID to split core behavior: core 0 copies the 256-byte XIP
+ * second-stage boot code into SRAM and branches to the SRAM copy; core 1 waits
+ * in ROM for the Pico SDK launch FIFO sequence, echoes the received words,
+ * installs VTOR/MSP, then branches to the received entry point.  Real RP2040
+ * mask ROM performs more checks, but boot2 expects to run from SRAM while it
+ * configures XIP.
  */
 static const uint8_t rp2040_bootrom[] = {
-    0x00, 0x20, 0x04, 0x20, 0x41, 0x00, 0x00, 0x00,
-    0x97, 0x00, 0x00, 0x00, 0x97, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0x1f, 0x4c, 0x20, 0x68, 0x00, 0x28, 0x05, 0xd1,
-    0x1e, 0x48, 0x1f, 0x49, 0x01, 0x60, 0x1f, 0x48,
-    0x01, 0x68, 0x08, 0x47, 0x1e, 0x4d, 0x00, 0x26,
-    0x00, 0xf0, 0x1e, 0xf8, 0x03, 0x2e, 0x07, 0xd2,
-    0xb1, 0x00, 0x6a, 0x58, 0x90, 0x42, 0x0c, 0xd0,
-    0x00, 0x26, 0x00, 0xf0, 0x1c, 0xf8, 0xf3, 0xe7,
-    0x03, 0x2e, 0x01, 0xd1, 0x07, 0x46, 0x04, 0xe0,
-    0x04, 0x2e, 0x01, 0xd1, 0x03, 0x46, 0x00, 0xe0,
-    0x05, 0x46, 0x00, 0xf0, 0x10, 0xf8, 0x01, 0x36,
-    0x06, 0x2e, 0xe5, 0xd1, 0x0d, 0x49, 0x0f, 0x60,
-    0x83, 0xf3, 0x08, 0x88, 0x28, 0x47, 0xfe, 0xe7,
-    0x09, 0x4c, 0x20, 0x6d, 0x01, 0x21, 0x08, 0x42,
-    0xfb, 0xd0, 0xa0, 0x6d, 0x70, 0x47, 0x06, 0x4c,
-    0x21, 0x6d, 0x02, 0x22, 0x11, 0x42, 0xfb, 0xd0,
-    0x60, 0x65, 0x70, 0x47, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0xd0, 0x08, 0xed, 0x00, 0xe0,
-    0x00, 0x00, 0x00, 0x10, 0x04, 0x00, 0x00, 0x10,
-    0xb4, 0x00, 0x00, 0x00,
+    0x00, 0x20, 0x04, 0x20, /* initial SP: 0x20042000 */
+    0x41, 0x00, 0x00, 0x00, /* reset handler: 0x00000041 */
+    0xb3, 0x00, 0x00, 0x00, /* NMI handler: 0x000000b3 */
+    0xb3, 0x00, 0x00, 0x00, /* HardFault handler: 0x000000b3 */
+    0xb3, 0x00, 0x00, 0x00, /* reserved */
+    0xb3, 0x00, 0x00, 0x00, /* reserved */
+    0xb3, 0x00, 0x00, 0x00, /* reserved */
+    0x00, 0x00, 0x00, 0x00, /* reserved */
+    0x00, 0x00, 0x00, 0x00, /* reserved */
+    0x00, 0x00, 0x00, 0x00, /* reserved */
+    0x00, 0x00, 0x00, 0x00, /* reserved */
+    0xb3, 0x00, 0x00, 0x00, /* SVC handler: 0x000000b3 */
+    0x00, 0x00, 0x00, 0x00, /* reserved */
+    0x00, 0x00, 0x00, 0x00, /* reserved */
+    0xb3, 0x00, 0x00, 0x00, /* PendSV handler: 0x000000b3 */
+    0xb3, 0x00, 0x00, 0x00, /* SysTick handler: 0x000000b3 */
+    0x26, 0x4c,             /* ldr r4, [pc, #152] ; SIO_BASE */
+    0x20, 0x68,             /* ldr r0, [r4] ; SIO_CPUID */
+    0x00, 0x28,             /* cmp r0, #0 */
+    0x13, 0xd1,             /* bne core1 path */
+    0x25, 0x48,             /* ldr r0, [pc, #148] ; 0x10000000 */
+    0x26, 0x49,             /* ldr r1, [pc, #152] ; 0x20041f00 */
+    0x40, 0x22,             /* movs r2, #64 */
+    0x03, 0x68,             /* ldr r3, [r0] */
+    0x0b, 0x60,             /* str r3, [r1] */
+    0x04, 0x30,             /* adds r0, #4 */
+    0x04, 0x31,             /* adds r1, #4 */
+    0x01, 0x3a,             /* subs r2, #1 */
+    0xf9, 0xd1,             /* bne copy loop */
+    0x23, 0x4b,             /* ldr r3, [pc, #140] ; launch entry */
+    0x9e, 0x46,             /* mov lr, r3 */
+    0x23, 0x48,             /* ldr r0, [pc, #140] ; 0x20041f01 */
+    0x00, 0x47,             /* bx r0 */
+    0x23, 0x48,             /* ldr r0, [pc, #140] ; 0x10000100 */
+    0x23, 0x49,             /* ldr r1, [pc, #140] ; VTOR */
+    0x08, 0x60,             /* str r0, [r1] */
+    0x06, 0xc8,             /* ldm r0!, {r1, r2} */
+    0x81, 0xf3, 0x08, 0x88, /* msr msp, r1 */
+    0x10, 0x47,             /* bx r2 */
+    0x21, 0x4d,             /* ldr r5, [pc, #132] ; sequence */
+    0x00, 0x26,             /* movs r6, #0 */
+    0x00, 0xf0, 0x1e, 0xf8, /* bl fifo_pop */
+    0x03, 0x2e,             /* cmp r6, #3 */
+    0x07, 0xd2,             /* bhs echo */
+    0xb1, 0x00,             /* lsls r1, r6, #2 */
+    0x6a, 0x58,             /* ldr r2, [r5, r1] */
+    0x90, 0x42,             /* cmp r0, r2 */
+    0x0c, 0xd0,             /* beq echo */
+    0x00, 0x26,             /* movs r6, #0 */
+    0x00, 0xf0, 0x1c, 0xf8, /* bl fifo_push */
+    0xf3, 0xe7,             /* b core1 loop */
+    0x03, 0x2e,             /* cmp r6, #3 */
+    0x01, 0xd1,             /* bne maybe SP */
+    0x07, 0x46,             /* mov r7, r0 */
+    0x04, 0xe0,             /* b echo */
+    0x04, 0x2e,             /* cmp r6, #4 */
+    0x01, 0xd1,             /* bne save PC */
+    0x03, 0x46,             /* mov r3, r0 */
+    0x00, 0xe0,             /* b echo */
+    0x05, 0x46,             /* mov r5, r0 */
+    0x00, 0xf0, 0x10, 0xf8, /* bl fifo_push */
+    0x01, 0x36,             /* adds r6, #1 */
+    0x06, 0x2e,             /* cmp r6, #6 */
+    0xe5, 0xd1,             /* bne core1 loop */
+    0x12, 0x49,             /* ldr r1, [pc, #72] ; VTOR */
+    0x0f, 0x60,             /* str r7, [r1] */
+    0x83, 0xf3, 0x08, 0x88, /* msr msp, r3 */
+    0x28, 0x47,             /* bx r5 */
+    0xfe, 0xe7,             /* hang */
+    0x09, 0x4c,             /* ldr r4, [pc, #36] ; SIO_BASE */
+    0x20, 0x6d,             /* ldr r0, [r4, #0x50] */
+    0x01, 0x21,             /* movs r1, #1 */
+    0x08, 0x42,             /* tst r0, r1 */
+    0xfb, 0xd0,             /* beq fifo_pop */
+    0xa0, 0x6d,             /* ldr r0, [r4, #0x58] */
+    0x70, 0x47,             /* bx lr */
+    0x06, 0x4c,             /* ldr r4, [pc, #24] ; SIO_BASE */
+    0x21, 0x6d,             /* ldr r1, [r4, #0x50] */
+    0x02, 0x22,             /* movs r2, #2 */
+    0x11, 0x42,             /* tst r1, r2 */
+    0xfb, 0xd0,             /* beq fifo_push */
+    0x60, 0x65,             /* str r0, [r4, #0x54] */
+    0x70, 0x47,             /* bx lr */
+    0x00, 0x00, 0x00, 0x00, /* core1 sequence[0] */
+    0x00, 0x00, 0x00, 0x00, /* core1 sequence[1] */
+    0x01, 0x00, 0x00, 0x00, /* core1 sequence[2] */
+    0x00, 0x00, 0x00, 0xd0, /* SIO_BASE */
+    0x00, 0x00, 0x00, 0x10, /* boot2 source: 0x10000000 */
+    0x00, 0x1f, 0x04, 0x20, /* boot2 SRAM copy: 0x20041f00 */
+    0x63, 0x00, 0x00, 0x00, /* post-boot2 launch entry: 0x00000063 */
+    0x01, 0x1f, 0x04, 0x20, /* boot2 SRAM entry: 0x20041f01 */
+    0x00, 0x01, 0x00, 0x10, /* application vectors: 0x10000100 */
+    0x08, 0xed, 0x00, 0xe0, /* VTOR: 0xe000ed08 */
+    0xd0, 0x00, 0x00, 0x00, /* core1 sequence table */
 };
 
 static const struct {
@@ -293,6 +366,8 @@ static void rp2040_soc_init(Object *obj)
                                   "chardev");
     }
 
+    object_initialize_child(obj, "xip", &s->xip, TYPE_RP2040_XIP);
+
     object_initialize_child(obj, "clocks", &s->clocks, TYPE_RP2040_CLOCKS);
     object_initialize_child(obj, "iobank0", &s->iobank0,
                             TYPE_RP2040_IOBANK0);
@@ -439,6 +514,21 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->xip), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->xip), 0, RP2040_XIP_BASE);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->xip), 1, RP2040_XIP_CTRL_BASE);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->xip), 2, RP2040_XIP_SSI_BASE);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->xip), 3, RP2040_XIP_AUX_BASE);
+    memory_region_add_subregion(get_system_memory(), RP2040_XIP_NOALLOC_BASE,
+                                &s->xip.xip_noalloc);
+    memory_region_add_subregion(get_system_memory(), RP2040_XIP_NOCACHE_BASE,
+                                &s->xip.xip_nocache);
+    memory_region_add_subregion(get_system_memory(),
+                                RP2040_XIP_NOCACHE_NOALLOC_BASE,
+                                &s->xip.xip_nocache_noalloc);
+
     for (i = 0; i < ARRAY_SIZE(rp2040_unimplemented); i++) {
         create_unimplemented_device(rp2040_unimplemented[i].name,
                                     rp2040_unimplemented[i].base,
@@ -541,6 +631,12 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sio), 1,
                        s->cpu_irq[RP2040_PROC1][RP2040_SIO_IRQ_PROC1]);
 
+    object_property_set_link(OBJECT(&s->ioqspi), "xip", OBJECT(&s->xip),
+                             &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->ioqspi), errp)) {
         return;
     }
diff --git a/hw/misc/rp2040_ioqspi.c b/hw/misc/rp2040_ioqspi.c
index eafd5e9eef..8356b7aea0 100644
--- a/hw/misc/rp2040_ioqspi.c
+++ b/hw/misc/rp2040_ioqspi.c
@@ -5,8 +5,10 @@
  */
 
 #include "qemu/osdep.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/misc/rp2040_nyi.h"
 #include "hw/misc/rp2040_ioqspi.h"
+#include "hw/ssi/rp2040_xip.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
@@ -24,6 +26,10 @@
 
 #define IOQSPI_CTRL_RESET       0x1f
 #define IOQSPI_CTRL_RW_MASK     0x33333f
+#define IOQSPI_CTRL_OUTOVER_MASK 0x300
+#define IOQSPI_CTRL_OUTOVER_LOW  0x200
+#define IOQSPI_CTRL_OUTOVER_HIGH 0x300
+#define IOQSPI_SS_INDEX          1
 #define IOQSPI_INTR_EDGE_MASK   0x00cccccc
 #define IOQSPI_IRQ_MASK         0x00ffffff
 
@@ -68,6 +74,22 @@ static uint32_t rp2040_ioqspi_ints(uint32_t intr, uint32_t inte,
     return (intr & inte) | intf;
 }
 
+static void rp2040_ioqspi_update_ss(RP2040IoQspiState *s)
+{
+    uint32_t outover;
+
+    if (!s->xip) {
+        return;
+    }
+
+    outover = s->ctrl[IOQSPI_SS_INDEX] & IOQSPI_CTRL_OUTOVER_MASK;
+    if (outover == IOQSPI_CTRL_OUTOVER_LOW) {
+        rp2040_xip_qspi_cs(s->xip, false);
+    } else if (outover == IOQSPI_CTRL_OUTOVER_HIGH) {
+        rp2040_xip_qspi_cs(s->xip, true);
+    }
+}
+
 static uint64_t rp2040_ioqspi_read(void *opaque, hwaddr addr, unsigned size)
 {
     RP2040IoQspiState *s = opaque;
@@ -139,6 +161,9 @@ static void rp2040_ioqspi_write(void *opaque, hwaddr addr,
         s->ctrl[index] =
             rp2040_ioqspi_apply_alias(s->ctrl[index], value, alias) &
             IOQSPI_CTRL_RW_MASK;
+        if (index == IOQSPI_SS_INDEX) {
+            rp2040_ioqspi_update_ss(s);
+        }
     } else {
         switch (offset) {
         case IOQSPI_INTR:
@@ -187,6 +212,11 @@ static void rp2040_ioqspi_write(void *opaque, hwaddr addr,
     }
 }
 
+static const Property rp2040_ioqspi_properties[] = {
+    DEFINE_PROP_LINK("xip", RP2040IoQspiState, xip, TYPE_RP2040_XIP,
+                     RP2040XipState *),
+};
+
 static const MemoryRegionOps rp2040_ioqspi_ops = {
     .read = rp2040_ioqspi_read,
     .write = rp2040_ioqspi_write,
@@ -245,6 +275,7 @@ static void rp2040_ioqspi_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_legacy_reset(dc, rp2040_ioqspi_reset);
+    device_class_set_props(dc, rp2040_ioqspi_properties);
     dc->vmsd = &rp2040_ioqspi_vmstate;
 }
 
diff --git a/hw/ssi/Kconfig b/hw/ssi/Kconfig
index 1bd56463c1..c8d0787dee 100644
--- a/hw/ssi/Kconfig
+++ b/hw/ssi/Kconfig
@@ -9,6 +9,9 @@ config SIFIVE_SPI
 config SSI
     bool
 
+config RP2040_XIP
+    bool
+
 config XILINX_SPI
     bool
     select SSI
diff --git a/hw/ssi/meson.build b/hw/ssi/meson.build
index 6afb1ea200..dc93ed5def 100644
--- a/hw/ssi/meson.build
+++ b/hw/ssi/meson.build
@@ -13,3 +13,4 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_spi.c'))
 system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_spi_host.c'))
 system_ss.add(when: 'CONFIG_BCM2835_SPI', if_true: files('bcm2835_spi.c'))
 system_ss.add(when: 'CONFIG_PNV_SPI', if_true: files('pnv_spi.c'))
+system_ss.add(when: 'CONFIG_RP2040_XIP', if_true: files('rp2040_xip.c'))
diff --git a/hw/ssi/rp2040_xip.c b/hw/ssi/rp2040_xip.c
new file mode 100644
index 0000000000..d517df41ff
--- /dev/null
+++ b/hw/ssi/rp2040_xip.c
@@ -0,0 +1,1348 @@
+/*
+ * RP2040 XIP/SSI flash controller emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "elf.h"
+#include "exec/memattrs.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/loader.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "hw/ssi/rp2040_xip.h"
+#include "qemu/log.h"
+#include "system/address-spaces.h"
+#include "trace.h"
+
+#define RP2040_XIP_CTRL_EN           0x1
+#define RP2040_XIP_CTRL_ERR_BADWRITE 0x2
+#define RP2040_XIP_STAT_FLUSH_READY  0x1
+#define RP2040_XIP_STAT_FIFO_EMPTY   0x2
+#define RP2040_XIP_STAT_FIFO_FULL    0x4
+#define RP2040_XIP_FLASH_BASE        0x10000000
+#define RP2040_XIP_CTRL              0x00
+#define RP2040_XIP_FLUSH             0x04
+#define RP2040_XIP_STAT              0x08
+#define RP2040_XIP_CTR_HIT           0x0c
+#define RP2040_XIP_CTR_ACC           0x10
+#define RP2040_XIP_STREAM_ADDR       0x14
+#define RP2040_XIP_STREAM_CTR        0x18
+#define RP2040_XIP_STREAM_FIFO       0x1c
+#define RP2040_XIP_STREAM_CTR_MASK   0x003fffff
+
+#define RP2040_SSI_CTRLR0     0x00
+#define RP2040_SSI_CTRLR1     0x04
+#define RP2040_SSI_SSIENR     0x08
+#define RP2040_SSI_SER        0x10
+#define RP2040_SSI_BAUDR      0x14
+#define RP2040_SSI_TXFTLR     0x18
+#define RP2040_SSI_RXFTLR     0x1c
+#define RP2040_SSI_TXFLR      0x20
+#define RP2040_SSI_RXFLR      0x24
+#define RP2040_SSI_SR         0x28
+#define RP2040_SSI_IMR        0x2c
+#define RP2040_SSI_ISR        0x30
+#define RP2040_SSI_RISR       0x34
+#define RP2040_SSI_TXOICR     0x38
+#define RP2040_SSI_RXOICR     0x3c
+#define RP2040_SSI_RXUICR     0x40
+#define RP2040_SSI_MSTICR     0x44
+#define RP2040_SSI_ICR        0x48
+#define RP2040_SSI_DMACR      0x4c
+#define RP2040_SSI_DMATDLR    0x50
+#define RP2040_SSI_DMARDLR    0x54
+#define RP2040_SSI_IDR        0x58
+#define RP2040_SSI_VERSION_ID 0x5c
+#define RP2040_SSI_DR0        0x60
+#define RP2040_SSI_DR_END     0xec
+#define RP2040_SSI_RX_SAMPLE_DLY 0xf0
+#define RP2040_SSI_SPI_CTRLR0 0xf4
+
+#define RP2040_SSI_SR_BUSY 0x01
+#define RP2040_SSI_SR_TFNF 0x02
+#define RP2040_SSI_SR_TFE  0x04
+#define RP2040_SSI_SR_RFNE 0x08
+#define RP2040_SSI_SR_RFF  0x10
+
+#define FLASH_CMD_READ         0x03
+#define FLASH_CMD_WRITE_STATUS 0x01
+#define FLASH_CMD_PAGE_PROGRAM 0x02
+#define FLASH_CMD_READ_STATUS  0x05
+#define FLASH_CMD_READ_STATUS2 0x35
+#define FLASH_CMD_WRITE_ENABLE 0x06
+#define FLASH_CMD_READ_UNIQUE_ID 0x4b
+#define FLASH_CMD_SECTOR_ERASE 0x20
+#define FLASH_CMD_QUAD_IO_READ 0xeb
+#define FLASH_CMD_CONTINUATION_READ 0xa0
+
+#define RP2040_SSI_DMACR_TDMAE BIT(1)
+#define RP2040_SSI_DMACR_RDMAE BIT(0)
+
+#define FLASH_UNIQUE_ID_SIZE 8
+#define FLASH_UNIQUE_ID_DUMMY_BYTES 4
+#define FLASH_UID_DEFAULT 0x3eb8a7493fcc0608ull
+
+#define FLASH_STATUS_WIP 0x01
+#define FLASH_STATUS_WEL 0x02
+#define FLASH_PAGE_SIZE  256
+#define FLASH_SECTOR_SIZE 4096
+
+#define ATOMIC_ALIAS_MASK 0x3000
+#define ATOMIC_XOR        0x1000
+#define ATOMIC_SET        0x2000
+#define ATOMIC_CLR        0x3000
+
+#define RP2040_BOOT2_SIZE 256
+#define RP2040_BOOT2_CRC_SIZE 252
+#define RP2040_BOOT2_CRC_INIT 0xffffffff
+#define RP2040_BOOT2_CRC_POLY 0x04c11db7
+#define RP2040_SRAM_BASE 0x20000000
+#define RP2040_SRAM_END  0x20042000
+
+static uint32_t rp2040_xip_apply_alias(uint32_t old, uint32_t value,
+                                       hwaddr alias)
+{
+    switch (alias) {
+    case ATOMIC_XOR:
+        return old ^ value;
+    case ATOMIC_SET:
+        return old | value;
+    case ATOMIC_CLR:
+        return old & ~value;
+    default:
+        return value;
+    }
+}
+
+static void rp2040_xip_rx_clear(RP2040XipState *s)
+{
+    s->rx_len = 0;
+    s->rx_pos = 0;
+}
+
+static void rp2040_xip_rx_push(RP2040XipState *s, uint8_t value)
+{
+    if (s->rx_len == ARRAY_SIZE(s->rx) && s->rx_pos > 0) {
+        memmove(s->rx, s->rx + s->rx_pos, s->rx_len - s->rx_pos);
+        s->rx_len -= s->rx_pos;
+        s->rx_pos = 0;
+    }
+
+    if (s->rx_len < ARRAY_SIZE(s->rx)) {
+        s->rx[s->rx_len++] = value;
+        qemu_irq_pulse(s->dreq_rx);
+    }
+}
+
+static bool rp2040_xip_rx_compact(RP2040XipState *s)
+{
+    if (s->rx_len == s->rx_pos) {
+        rp2040_xip_rx_clear(s);
+        return true;
+    }
+    if (s->rx_pos > 0) {
+        memmove(s->rx, s->rx + s->rx_pos, s->rx_len - s->rx_pos);
+        s->rx_len -= s->rx_pos;
+        s->rx_pos = 0;
+        return true;
+    }
+    return false;
+}
+
+static bool rp2040_xip_flash_word(RP2040XipState *s, uint32_t addr,
+                                  uint32_t *value)
+{
+    if (s->flash_size < sizeof(uint32_t) ||
+        addr > s->flash_size - sizeof(uint32_t)) {
+        *value = 0xffffffff;
+        return false;
+    }
+
+    *value = ldl_le_p(s->storage + addr);
+    return true;
+}
+
+static void rp2040_xip_rx_push_ssi_word(RP2040XipState *s, uint32_t value)
+{
+    if (ARRAY_SIZE(s->rx) - (s->rx_len - s->rx_pos) < sizeof(uint32_t)) {
+        rp2040_xip_rx_compact(s);
+    }
+    if (ARRAY_SIZE(s->rx) - s->rx_len < sizeof(uint32_t)) {
+        return;
+    }
+
+    /*
+     * Non-XIP 32-bit SSI reads deliver the serial flash byte stream in the
+     * opposite byte order expected by the RP2040 system bus; SDK users enable
+     * DMA BSWAP when copying words from SSI_DR0.
+     */
+    s->rx[s->rx_len++] = extract32(value, 24, 8);
+    s->rx[s->rx_len++] = extract32(value, 16, 8);
+    s->rx[s->rx_len++] = extract32(value, 8, 8);
+    s->rx[s->rx_len++] = extract32(value, 0, 8);
+    qemu_irq_pulse(s->dreq_rx);
+}
+
+static void rp2040_xip_ssi_bulk_fill(RP2040XipState *s)
+{
+    while (s->ssi_bulk_remaining > 0 &&
+           ARRAY_SIZE(s->rx) - (s->rx_len - s->rx_pos) >=
+           sizeof(uint32_t)) {
+        uint32_t value;
+
+        rp2040_xip_rx_compact(s);
+        rp2040_xip_flash_word(s, s->ssi_bulk_addr, &value);
+        rp2040_xip_rx_push_ssi_word(s, value);
+        s->ssi_bulk_addr += sizeof(uint32_t);
+        s->ssi_bulk_remaining--;
+    }
+}
+
+static void rp2040_xip_ssi_bulk_start(RP2040XipState *s, uint32_t addr,
+                                      uint32_t words)
+{
+    rp2040_xip_rx_clear(s);
+    s->ssi_bulk_addr = addr;
+    s->ssi_bulk_remaining = words;
+    rp2040_xip_ssi_bulk_fill(s);
+}
+
+static void rp2040_xip_update_stream_dreq(RP2040XipState *s)
+{
+    qemu_set_irq(s->dreq_stream, s->stream_fifo_len > s->stream_fifo_pos);
+}
+
+static void rp2040_xip_stream_clear(RP2040XipState *s)
+{
+    s->stream_fifo_len = 0;
+    s->stream_fifo_pos = 0;
+    rp2040_xip_update_stream_dreq(s);
+}
+
+static uint32_t rp2040_xip_stream_word(RP2040XipState *s)
+{
+    uint32_t off;
+
+    if (s->flash_size < sizeof(uint32_t)) {
+        return 0xffffffff;
+    }
+    if (s->stream_addr < RP2040_XIP_FLASH_BASE ||
+        s->stream_addr - RP2040_XIP_FLASH_BASE >
+        s->flash_size - sizeof(uint32_t)) {
+        return 0xffffffff;
+    }
+
+    off = s->stream_addr - RP2040_XIP_FLASH_BASE;
+    return ldl_le_p(s->storage + off);
+}
+
+static void rp2040_xip_stream_fill(RP2040XipState *s)
+{
+    if (s->stream_fifo_pos == s->stream_fifo_len) {
+        s->stream_fifo_pos = 0;
+        s->stream_fifo_len = 0;
+    }
+
+    while (s->stream_ctr > 0 &&
+           s->stream_fifo_len < ARRAY_SIZE(s->stream_fifo)) {
+        s->stream_fifo[s->stream_fifo_len++] = rp2040_xip_stream_word(s);
+        s->stream_addr += 4;
+        s->stream_ctr--;
+    }
+
+    rp2040_xip_update_stream_dreq(s);
+}
+
+static uint32_t rp2040_xip_stream_pop(RP2040XipState *s)
+{
+    uint32_t value = 0;
+
+    rp2040_xip_stream_fill(s);
+    if (s->stream_fifo_pos < s->stream_fifo_len) {
+        value = s->stream_fifo[s->stream_fifo_pos++];
+    }
+    rp2040_xip_stream_fill(s);
+    return value;
+}
+
+static uint32_t rp2040_xip_stat(RP2040XipState *s)
+{
+    uint32_t stat = RP2040_XIP_STAT_FLUSH_READY;
+
+    rp2040_xip_stream_fill(s);
+    if (s->stream_fifo_pos == s->stream_fifo_len) {
+        stat |= RP2040_XIP_STAT_FIFO_EMPTY;
+    }
+    if (s->stream_fifo_len - s->stream_fifo_pos ==
+        ARRAY_SIZE(s->stream_fifo)) {
+        stat |= RP2040_XIP_STAT_FIFO_FULL;
+    }
+
+    return stat;
+}
+
+static uint8_t rp2040_xip_status(RP2040XipState *s)
+{
+    uint8_t status = 0;
+
+    if (s->busy) {
+        status |= FLASH_STATUS_WIP;
+    }
+    if (s->write_enable) {
+        status |= FLASH_STATUS_WEL;
+    }
+
+    return status;
+}
+
+static uint32_t rp2040_xip_tx_addr(RP2040XipState *s)
+{
+    return (uint32_t)s->tx[1] << 16 | s->tx[2] << 8 | s->tx[3];
+}
+
+static uint32_t rp2040_xip_quad_io_addr(RP2040XipState *s)
+{
+    return (uint32_t)s->tx[1] << 16 | s->tx[2] << 8 | s->tx[3];
+}
+
+static uint8_t rp2040_xip_flash_uid_byte(RP2040XipState *s, unsigned index)
+{
+    return extract64(s->flash_uid, (FLASH_UNIQUE_ID_SIZE - 1 - index) * 8, 8);
+}
+
+static void rp2040_xip_finish_busy(RP2040XipState *s)
+{
+    s->busy = false;
+}
+
+static void rp2040_xip_reset_tx(RP2040XipState *s)
+{
+    s->tx_len = 0;
+    s->tx_unsupported_logged = false;
+    s->ssi_bulk_remaining = 0;
+}
+
+static bool rp2040_xip_writeback(RP2040XipState *s, Error **errp)
+{
+    g_autoptr(GError) gerr = NULL;
+
+    if (!s->flash_file || !*s->flash_file) {
+        return true;
+    }
+
+    if (!g_file_set_contents(s->flash_file, (const char *)s->storage,
+                             s->flash_size, &gerr)) {
+        error_setg(errp, "could not write flash file '%s': %s",
+                   s->flash_file, gerr->message);
+        return false;
+    }
+
+    return true;
+}
+
+static void rp2040_xip_writeback_or_warn(RP2040XipState *s)
+{
+    Error *local_err = NULL;
+
+    if (!rp2040_xip_writeback(s, &local_err)) {
+        warn_report_err(local_err);
+    }
+}
+
+static uint32_t rp2040_xip_boot2_crc(const uint8_t *data)
+{
+    uint32_t crc = RP2040_BOOT2_CRC_INIT;
+    int i;
+    int bit;
+
+    for (i = 0; i < RP2040_BOOT2_CRC_SIZE; i++) {
+        crc ^= (uint32_t)data[i] << 24;
+        for (bit = 0; bit < 8; bit++) {
+            if (crc & BIT(31)) {
+                crc = (crc << 1) ^ RP2040_BOOT2_CRC_POLY;
+            } else {
+                crc <<= 1;
+            }
+        }
+    }
+
+    return crc;
+}
+
+static bool rp2040_xip_boot2_empty(const uint8_t *data)
+{
+    int i;
+
+    for (i = 0; i < RP2040_BOOT2_SIZE; i++) {
+        if (data[i] != 0xff) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
+static bool rp2040_xip_boot2_looks_like_vector_table(const uint8_t *data)
+{
+    uint32_t initial_sp = ldl_le_p(data);
+    uint32_t reset = ldl_le_p(data + 4);
+
+    return initial_sp >= RP2040_SRAM_BASE &&
+           initial_sp <= RP2040_SRAM_END &&
+           reset >= RP2040_XIP_FLASH_BASE &&
+           reset < RP2040_XIP_FLASH_BASE + MiB &&
+           (reset & 1);
+}
+
+static bool rp2040_xip_fixup_boot2(RP2040XipState *s, const char *filename,
+                                   Error **errp)
+{
+    uint32_t crc;
+
+    if (s->flash_size < RP2040_BOOT2_SIZE) {
+        error_setg(errp, "flash is too small for an RP2040 boot2 block");
+        return false;
+    }
+
+    if (rp2040_xip_boot2_empty(s->storage)) {
+        error_setg(errp, "image '%s' does not contain RP2040 boot2 at "
+                   "0x%08x", filename, RP2040_XIP_FLASH_BASE);
+        return false;
+    }
+
+    if (rp2040_xip_boot2_looks_like_vector_table(s->storage)) {
+        error_setg(errp, "image '%s' starts with an application vector table, "
+                   "not RP2040 boot2; use a Pico SDK UF2 or an ELF with "
+                   "boot2 linked at 0x%08x", filename, RP2040_XIP_FLASH_BASE);
+        return false;
+    }
+
+    crc = rp2040_xip_boot2_crc(s->storage);
+    stl_le_p(s->storage + RP2040_BOOT2_CRC_SIZE, crc);
+
+    return true;
+}
+
+static void rp2040_xip_program(RP2040XipState *s)
+{
+    uint32_t addr;
+    uint32_t page_end;
+    unsigned data_len;
+    unsigned i;
+
+    trace_rp2040_xip_program(s->tx_len >= 4 ? rp2040_xip_tx_addr(s) : 0,
+                             s->tx_len > 4 ? s->tx_len - 4 : 0,
+                             s->write_enable);
+
+    if (!s->write_enable) {
+        return;
+    }
+
+    s->write_enable = false;
+
+    if (s->tx_len <= 4) {
+        return;
+    }
+
+    addr = rp2040_xip_tx_addr(s);
+    if (addr >= s->flash_size) {
+        return;
+    }
+
+    page_end = ROUND_UP(addr + 1, FLASH_PAGE_SIZE);
+    data_len = MIN(s->tx_len - 4, page_end - addr);
+    data_len = MIN(data_len, s->flash_size - addr);
+
+    for (i = 0; i < data_len; i++) {
+        s->storage[addr + i] &= s->tx[4 + i];
+    }
+
+    rp2040_xip_writeback_or_warn(s);
+    s->busy = true;
+}
+
+static void rp2040_xip_erase(RP2040XipState *s)
+{
+    uint32_t addr;
+    uint32_t base;
+
+    trace_rp2040_xip_erase(s->tx_len >= 4 ? rp2040_xip_tx_addr(s) : 0,
+                           s->write_enable);
+
+    if (!s->write_enable) {
+        return;
+    }
+
+    s->write_enable = false;
+
+    if (s->tx_len < 4) {
+        return;
+    }
+
+    addr = rp2040_xip_tx_addr(s);
+    base = QEMU_ALIGN_DOWN(addr, FLASH_SECTOR_SIZE);
+    if (base >= s->flash_size) {
+        return;
+    }
+
+    memset(&s->storage[base], 0xff, MIN(FLASH_SECTOR_SIZE,
+                                       s->flash_size - base));
+    rp2040_xip_writeback_or_warn(s);
+    s->busy = true;
+}
+
+static void rp2040_xip_finish_command(RP2040XipState *s)
+{
+    if (s->tx_len == 0) {
+        return;
+    }
+
+    trace_rp2040_xip_finish_command(s->tx[0], s->tx_len);
+
+    switch (s->tx[0]) {
+    case FLASH_CMD_WRITE_STATUS:
+        s->write_enable = false;
+        break;
+    case FLASH_CMD_PAGE_PROGRAM:
+        rp2040_xip_program(s);
+        break;
+    case FLASH_CMD_SECTOR_ERASE:
+        rp2040_xip_erase(s);
+        break;
+    default:
+        break;
+    }
+
+    rp2040_xip_reset_tx(s);
+}
+
+static void rp2040_xip_dr_write(RP2040XipState *s, uint8_t value)
+{
+    uint32_t addr;
+
+    if (s->tx_len < ARRAY_SIZE(s->tx)) {
+        s->tx[s->tx_len++] = value;
+    }
+
+    switch (s->tx[0]) {
+    case FLASH_CMD_WRITE_STATUS:
+        s->write_enable = false;
+        rp2040_xip_rx_push(s, 0);
+        break;
+    case FLASH_CMD_PAGE_PROGRAM:
+    case FLASH_CMD_SECTOR_ERASE:
+        rp2040_xip_rx_push(s, 0);
+        break;
+    case FLASH_CMD_WRITE_ENABLE:
+        s->write_enable = true;
+        rp2040_xip_rx_push(s, 0);
+        rp2040_xip_reset_tx(s);
+        break;
+    case FLASH_CMD_READ_STATUS:
+        rp2040_xip_rx_push(s, rp2040_xip_status(s));
+        rp2040_xip_finish_busy(s);
+        rp2040_xip_reset_tx(s);
+        break;
+    case FLASH_CMD_READ_STATUS2:
+        rp2040_xip_rx_push(s, 0);
+        rp2040_xip_finish_busy(s);
+        rp2040_xip_reset_tx(s);
+        break;
+    case FLASH_CMD_READ_UNIQUE_ID:
+        if (s->tx_len <= 1 + FLASH_UNIQUE_ID_DUMMY_BYTES) {
+            rp2040_xip_rx_push(s, 0);
+        } else {
+            unsigned index = s->tx_len - 2 - FLASH_UNIQUE_ID_DUMMY_BYTES;
+
+            rp2040_xip_rx_push(s, index < FLASH_UNIQUE_ID_SIZE ?
+                               rp2040_xip_flash_uid_byte(s, index) : 0);
+        }
+        break;
+    case FLASH_CMD_READ:
+        if (s->tx_len <= 4) {
+            rp2040_xip_rx_push(s, 0);
+        } else {
+            addr = rp2040_xip_tx_addr(s) + s->tx_len - 5;
+            rp2040_xip_rx_push(s, addr < s->flash_size ?
+                               s->storage[addr] : 0xff);
+        }
+        break;
+    case FLASH_CMD_QUAD_IO_READ:
+        /*
+         * Minimal 0xeb fast-read support for the RP2040 mask ROM path.
+         * The ROM clocks opcode, 24-bit address and mode/dummy bytes before
+         * consuming data. We do not model bus width or wait-cycle timing here.
+         */
+        if (s->tx_len <= 5) {
+            rp2040_xip_rx_push(s, 0);
+        } else {
+            addr = rp2040_xip_quad_io_addr(s) + s->tx_len - 6;
+            rp2040_xip_rx_push(s, addr < s->flash_size ?
+                               s->storage[addr] : 0xff);
+        }
+        break;
+    case 0x00:
+        rp2040_xip_rx_push(s, 0);
+        break;
+    default:
+        /*
+         * The RP2040 boot ROM performs small full-duplex SSI transactions
+         * while probing the flash path. Even for commands we do not model yet,
+         * a transmitted byte clocks one receive byte back from the bus.
+         */
+        if (!s->tx_unsupported_logged) {
+            g_autofree char *detail = g_strdup_printf("opcode 0x%02x",
+                                                      s->tx[0]);
+
+            rp2040_log_nyi("xip.ssi", "flash command", detail);
+            s->tx_unsupported_logged = true;
+        }
+        rp2040_xip_rx_push(s, 0);
+        break;
+    }
+}
+
+MemTxResult rp2040_xip_read_data(RP2040XipState *s, hwaddr addr,
+                                 uint64_t *data, unsigned size)
+{
+    uint64_t value = 0;
+    unsigned i;
+
+    if (s->busy || addr + size > s->flash_size) {
+        return MEMTX_ERROR;
+    }
+
+    for (i = 0; i < size; i++) {
+        hwaddr cur = addr + i;
+        uint8_t byte = s->storage[cur];
+
+        value |= (uint64_t)byte << (i * 8);
+    }
+    *data = value;
+    return MEMTX_OK;
+}
+
+static MemTxResult rp2040_xip_read(void *opaque, hwaddr addr, uint64_t *data,
+                                   unsigned size, MemTxAttrs attrs)
+{
+    return rp2040_xip_read_data(opaque, addr, data, size);
+}
+
+static MemTxResult rp2040_xip_alias_read(void *opaque, hwaddr addr,
+                                         uint64_t *data, unsigned size,
+                                         MemTxAttrs attrs)
+{
+    return rp2040_xip_read_data(opaque, addr, data, size);
+}
+
+static MemTxResult rp2040_xip_write(void *opaque, hwaddr addr, uint64_t data,
+                                    unsigned size, MemTxAttrs attrs)
+{
+    RP2040XipState *s = opaque;
+    unsigned i;
+
+    if (!s->xip_writable) {
+        return MEMTX_ERROR;
+    }
+    if (addr + size > s->flash_size) {
+        return MEMTX_ERROR;
+    }
+
+    for (i = 0; i < size; i++) {
+        s->storage[addr + i] = extract64(data, i * 8, 8);
+    }
+    return MEMTX_OK;
+}
+
+static uint64_t rp2040_xip_ctrl_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040XipState *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    uint64_t value;
+
+    switch (offset) {
+    case RP2040_XIP_CTRL:
+        value = s->xip_ctrl;
+        break;
+    case RP2040_XIP_FLUSH:
+    case RP2040_XIP_CTR_HIT:
+    case RP2040_XIP_CTR_ACC:
+        value = 0;
+        break;
+    case RP2040_XIP_STAT:
+        value = rp2040_xip_stat(s);
+        break;
+    case RP2040_XIP_STREAM_ADDR:
+        value = s->stream_addr;
+        break;
+    case RP2040_XIP_STREAM_CTR:
+        value = s->stream_ctr;
+        break;
+    case RP2040_XIP_STREAM_FIFO:
+        value = rp2040_xip_stream_pop(s);
+        break;
+    default:
+        value = 0;
+        qemu_log_mask(LOG_UNIMP, "rp2040.xip.ctrl: unimplemented read  "
+                      "(size %d, addr 0x%08" HWADDR_PRIx
+                      ", offset 0x%04" HWADDR_PRIx
+                      ") -> 0x%0*" PRIx64 "\n",
+                      size, RP2040_XIP_CTRL_BASE + addr, offset,
+                      size << 1, value);
+        break;
+    }
+
+    return value;
+}
+
+static void rp2040_xip_ctrl_write(void *opaque, hwaddr addr, uint64_t value,
+                                  unsigned size)
+{
+    RP2040XipState *s = opaque;
+    hwaddr alias = addr & ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    uint32_t new_value;
+
+    switch (offset) {
+    case RP2040_XIP_CTRL:
+        new_value = rp2040_xip_apply_alias(s->xip_ctrl, value, alias);
+        s->xip_ctrl = new_value & (RP2040_XIP_CTRL_EN |
+                                   RP2040_XIP_CTRL_ERR_BADWRITE);
+        break;
+    case RP2040_XIP_FLUSH:
+        rp2040_xip_stream_clear(s);
+        break;
+    case RP2040_XIP_CTR_HIT:
+    case RP2040_XIP_CTR_ACC:
+        break;
+    case RP2040_XIP_STREAM_ADDR:
+        s->stream_addr = value & ~3u;
+        break;
+    case RP2040_XIP_STREAM_CTR:
+        s->stream_ctr = value & RP2040_XIP_STREAM_CTR_MASK;
+        if (s->stream_ctr == 0) {
+            rp2040_xip_stream_clear(s);
+        } else {
+            rp2040_xip_stream_fill(s);
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "rp2040.xip.ctrl: unimplemented write "
+                      "(size %d, addr 0x%08" HWADDR_PRIx
+                      ", offset 0x%04" HWADDR_PRIx
+                      ", value 0x%0*" PRIx64 ")\n",
+                      size, RP2040_XIP_CTRL_BASE + addr, offset,
+                      size << 1, value);
+        break;
+    }
+}
+
+static uint64_t rp2040_xip_aux_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return rp2040_xip_stream_pop(opaque);
+}
+
+static void rp2040_xip_aux_write(void *opaque, hwaddr addr,
+                                 uint64_t value, unsigned size)
+{
+    rp2040_log_nyi("xip.aux", "write",
+                   "XIP auxiliary stream FIFO is read-only");
+}
+
+static uint64_t rp2040_xip_ssi_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040XipState *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    uint8_t value;
+    uint32_t risr = s->rx_len > s->rx_pos ? 0 : 1;
+    uint64_t ret;
+
+    if (offset >= RP2040_SSI_DR0 && offset <= RP2040_SSI_DR_END) {
+        unsigned i;
+
+        if (s->tx_len > 0 && s->ssi_bulk_remaining == 0) {
+            if (s->rx_pos < s->rx_len) {
+                value = s->rx[s->rx_pos++];
+            } else {
+                value = 0;
+            }
+            if (s->rx_pos == s->rx_len) {
+                rp2040_xip_rx_clear(s);
+            }
+            return value;
+        }
+
+        ret = 0;
+        for (i = 0; i < size; i++) {
+            if (s->rx_pos == s->rx_len) {
+                rp2040_xip_rx_clear(s);
+                rp2040_xip_ssi_bulk_fill(s);
+            }
+            if (s->rx_pos < s->rx_len) {
+                value = s->rx[s->rx_pos++];
+            } else {
+                value = 0;
+            }
+            ret |= (uint64_t)value << (i * 8);
+        }
+        if (s->rx_pos == s->rx_len) {
+            rp2040_xip_rx_clear(s);
+            rp2040_xip_ssi_bulk_fill(s);
+        }
+        return ret;
+    }
+
+    switch (offset) {
+    case RP2040_SSI_CTRLR0:
+        ret = s->ctrlr0;
+        break;
+    case RP2040_SSI_CTRLR1:
+        ret = s->ctrlr1;
+        break;
+    case RP2040_SSI_SSIENR:
+        ret = s->ssienr;
+        break;
+    case RP2040_SSI_SER:
+        ret = s->ser;
+        break;
+    case RP2040_SSI_BAUDR:
+        ret = s->baudr;
+        break;
+    case RP2040_SSI_TXFTLR:
+        ret = s->txftlr;
+        break;
+    case RP2040_SSI_RXFTLR:
+        ret = s->rxftlr;
+        break;
+    case RP2040_SSI_TXFLR:
+        ret = 0;
+        break;
+    case RP2040_SSI_RXFLR:
+        ret = s->rx_len - s->rx_pos;
+        break;
+    case RP2040_SSI_SR:
+        ret = RP2040_SSI_SR_TFE | RP2040_SSI_SR_TFNF |
+              (s->busy ? RP2040_SSI_SR_BUSY : 0) |
+              (s->rx_len > s->rx_pos ? RP2040_SSI_SR_RFNE : 0) |
+              (s->rx_len - s->rx_pos == ARRAY_SIZE(s->rx) ?
+               RP2040_SSI_SR_RFF : 0);
+        break;
+    case RP2040_SSI_IMR:
+        ret = s->imr;
+        break;
+    case RP2040_SSI_ISR:
+    case RP2040_SSI_RISR:
+        ret = risr;
+        break;
+    case RP2040_SSI_TXOICR:
+    case RP2040_SSI_RXOICR:
+    case RP2040_SSI_RXUICR:
+    case RP2040_SSI_MSTICR:
+    case RP2040_SSI_ICR:
+        ret = 0;
+        break;
+    case RP2040_SSI_DMACR:
+        ret = s->dmacr;
+        break;
+    case RP2040_SSI_DMATDLR:
+        ret = s->dmatdlr;
+        break;
+    case RP2040_SSI_DMARDLR:
+        ret = s->dmardlr;
+        break;
+    case RP2040_SSI_IDR:
+        ret = 0;
+        break;
+    case RP2040_SSI_VERSION_ID:
+        ret = 0x3430312a;
+        break;
+    case RP2040_SSI_RX_SAMPLE_DLY:
+        ret = s->rx_sample_dly;
+        break;
+    case RP2040_SSI_SPI_CTRLR0:
+        ret = s->spi_ctrlr0;
+        break;
+    default:
+        ret = 0;
+        qemu_log_mask(LOG_UNIMP, "rp2040.xip.ssi: unimplemented read  "
+                      "(size %d, addr 0x%08" HWADDR_PRIx
+                      ", offset 0x%04" HWADDR_PRIx
+                      ") -> 0x%0*" PRIx64 "\n",
+                      size, RP2040_XIP_SSI_BASE + addr, offset,
+                      size << 1, ret);
+        break;
+    }
+
+    return ret;
+}
+
+static void rp2040_xip_ssi_write(void *opaque, hwaddr addr, uint64_t value,
+                                 unsigned size)
+{
+    RP2040XipState *s = opaque;
+    hwaddr alias = addr & ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    uint32_t old_ssienr = s->ssienr;
+    uint32_t old_ser = s->ser;
+    uint32_t new_value;
+
+    if (offset >= RP2040_SSI_DR0 && offset <= RP2040_SSI_DR_END) {
+        if (s->tx_len < 8 || (s->tx_len & 0x3f) == 0) {
+            trace_rp2040_xip_dr_write(value, size, s->tx_len, s->ctrlr0,
+                                      s->ctrlr1, s->spi_ctrlr0);
+        }
+        if (size == 4 && (value & 0xff) == FLASH_CMD_CONTINUATION_READ) {
+            rp2040_xip_ssi_bulk_start(s, value >> 8, s->ctrlr1 + 1);
+            return;
+        }
+        rp2040_xip_dr_write(s, value & 0xff);
+        return;
+    }
+
+    switch (offset) {
+    case RP2040_SSI_CTRLR0:
+        s->ctrlr0 = rp2040_xip_apply_alias(s->ctrlr0, value, alias);
+        trace_rp2040_xip_ctrlr0(s->ctrlr0);
+        break;
+    case RP2040_SSI_CTRLR1:
+        s->ctrlr1 = rp2040_xip_apply_alias(s->ctrlr1, value, alias);
+        trace_rp2040_xip_ctrlr1(s->ctrlr1);
+        break;
+    case RP2040_SSI_SSIENR:
+        new_value = rp2040_xip_apply_alias(s->ssienr, value, alias);
+        s->ssienr = new_value & 1;
+        trace_rp2040_xip_ssienr(old_ssienr, s->ssienr, s->tx_len);
+        if ((old_ssienr & 1) && !s->ssienr) {
+            rp2040_xip_finish_command(s);
+        }
+        if (!s->ssienr) {
+            rp2040_xip_rx_clear(s);
+            rp2040_xip_reset_tx(s);
+        }
+        break;
+    case RP2040_SSI_SER:
+        new_value = rp2040_xip_apply_alias(s->ser, value, alias);
+        s->ser = new_value & 1;
+        trace_rp2040_xip_ser(old_ser, s->ser, s->tx_len);
+        if ((old_ser & 1) && !s->ser) {
+            rp2040_xip_finish_command(s);
+        }
+        break;
+    case RP2040_SSI_BAUDR:
+        new_value = rp2040_xip_apply_alias(s->baudr, value, alias);
+        s->baudr = new_value & 0xffff;
+        break;
+    case RP2040_SSI_TXFTLR:
+        new_value = rp2040_xip_apply_alias(s->txftlr, value, alias);
+        s->txftlr = new_value & 0xff;
+        break;
+    case RP2040_SSI_RXFTLR:
+        new_value = rp2040_xip_apply_alias(s->rxftlr, value, alias);
+        s->rxftlr = new_value & 0xff;
+        break;
+    case RP2040_SSI_IMR:
+        new_value = rp2040_xip_apply_alias(s->imr, value, alias);
+        s->imr = new_value & 0x3f;
+        break;
+    case RP2040_SSI_DMACR:
+        new_value = rp2040_xip_apply_alias(s->dmacr, value, alias);
+        s->dmacr = new_value & (RP2040_SSI_DMACR_TDMAE |
+                                RP2040_SSI_DMACR_RDMAE);
+        break;
+    case RP2040_SSI_DMATDLR:
+        s->dmatdlr = rp2040_xip_apply_alias(s->dmatdlr, value, alias) & 0xff;
+        break;
+    case RP2040_SSI_DMARDLR:
+        s->dmardlr = rp2040_xip_apply_alias(s->dmardlr, value, alias) & 0xff;
+        break;
+    case RP2040_SSI_RX_SAMPLE_DLY:
+        s->rx_sample_dly = rp2040_xip_apply_alias(s->rx_sample_dly, value,
+                                                  alias) & 0xff;
+        break;
+    case RP2040_SSI_SPI_CTRLR0:
+        s->spi_ctrlr0 = rp2040_xip_apply_alias(s->spi_ctrlr0, value, alias);
+        trace_rp2040_xip_spi_ctrlr0(s->spi_ctrlr0);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "rp2040.xip.ssi: unimplemented write "
+                      "(size %d, addr 0x%08" HWADDR_PRIx
+                      ", offset 0x%04" HWADDR_PRIx
+                      ", value 0x%0*" PRIx64 ")\n",
+                      size, RP2040_XIP_SSI_BASE + addr, offset,
+                      size << 1, value);
+        break;
+    }
+}
+
+static const MemoryRegionOps rp2040_xip_ops = {
+    .read_with_attrs = rp2040_xip_read,
+    .write_with_attrs = rp2040_xip_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+        .unaligned = true,
+    },
+};
+
+static const MemoryRegionOps rp2040_xip_alias_ops = {
+    .read_with_attrs = rp2040_xip_alias_read,
+    .write_with_attrs = rp2040_xip_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+        .unaligned = true,
+    },
+};
+
+static const MemoryRegionOps rp2040_xip_ctrl_ops = {
+    .read = rp2040_xip_ctrl_read,
+    .write = rp2040_xip_ctrl_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static const MemoryRegionOps rp2040_xip_ssi_ops = {
+    .read = rp2040_xip_ssi_read,
+    .write = rp2040_xip_ssi_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+        .unaligned = true,
+    },
+};
+
+static const MemoryRegionOps rp2040_xip_aux_ops = {
+    .read = rp2040_xip_aux_read,
+    .write = rp2040_xip_aux_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+void rp2040_xip_set_writable(RP2040XipState *s, bool writable)
+{
+    s->xip_writable = writable;
+}
+
+void rp2040_xip_qspi_cs(RP2040XipState *s, bool high)
+{
+    if (s->qspi_cs_high == high) {
+        return;
+    }
+
+    trace_rp2040_xip_qspi_cs(high, s->tx_len);
+    s->qspi_cs_high = high;
+
+    if (high) {
+        rp2040_xip_finish_command(s);
+    } else {
+        rp2040_xip_rx_clear(s);
+        rp2040_xip_reset_tx(s);
+    }
+}
+
+static bool rp2040_xip_load_elf(RP2040XipState *s, const char *filename,
+                                Error **errp)
+{
+    g_autofree gchar *contents = NULL;
+    gsize len;
+    const Elf32_Ehdr *ehdr;
+    const Elf32_Phdr *phdr;
+    int i;
+
+    if (!g_file_get_contents(filename, &contents, &len, NULL)) {
+        error_setg(errp, "could not load flash image '%s'", filename);
+        return true;
+    }
+
+    if (len < sizeof(*ehdr)) {
+        return false;
+    }
+
+    ehdr = (const Elf32_Ehdr *)contents;
+    if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG) != 0) {
+        return false;
+    }
+    if (ehdr->e_ident[EI_CLASS] != ELFCLASS32 ||
+        ehdr->e_ident[EI_DATA] != ELFDATA2LSB ||
+        le16_to_cpu(ehdr->e_machine) != EM_ARM) {
+        error_setg(errp, "unsupported flash ELF image '%s'", filename);
+        return true;
+    }
+    if (le32_to_cpu(ehdr->e_phoff) > len ||
+        le16_to_cpu(ehdr->e_phentsize) != sizeof(*phdr) ||
+        le16_to_cpu(ehdr->e_phnum) >
+        (len - le32_to_cpu(ehdr->e_phoff)) / sizeof(*phdr)) {
+        error_setg(errp, "invalid flash ELF image '%s'", filename);
+        return true;
+    }
+
+    phdr = (const Elf32_Phdr *)(contents + le32_to_cpu(ehdr->e_phoff));
+    for (i = 0; i < le16_to_cpu(ehdr->e_phnum); i++) {
+        uint32_t paddr = le32_to_cpu(phdr[i].p_paddr);
+        uint32_t filesz = le32_to_cpu(phdr[i].p_filesz);
+        uint32_t memsz = le32_to_cpu(phdr[i].p_memsz);
+        uint32_t off = le32_to_cpu(phdr[i].p_offset);
+        uint32_t xip_off;
+
+        if (le32_to_cpu(phdr[i].p_type) != PT_LOAD) {
+            continue;
+        }
+
+        if (filesz == 0) {
+            continue;
+        }
+
+        if (paddr < RP2040_XIP_FLASH_BASE ||
+            paddr - RP2040_XIP_FLASH_BASE > s->flash_size ||
+            filesz > memsz ||
+            filesz > s->flash_size - (paddr - RP2040_XIP_FLASH_BASE) ||
+            off > len ||
+            filesz > len - off) {
+            error_setg(errp, "flash ELF segment is outside XIP storage");
+            return true;
+        }
+
+        xip_off = paddr - RP2040_XIP_FLASH_BASE;
+        memcpy(s->storage + xip_off, contents + off, filesz);
+    }
+
+    return true;
+}
+
+void rp2040_xip_load_image(RP2040XipState *s, const char *filename,
+                           Error **errp)
+{
+    Error *local_err = NULL;
+    ssize_t image_size;
+
+    if (!filename) {
+        return;
+    }
+
+    if (rp2040_xip_load_elf(s, filename, &local_err)) {
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+        if (!rp2040_xip_fixup_boot2(s, filename, errp)) {
+            return;
+        }
+        rp2040_xip_writeback(s, errp);
+        return;
+    }
+
+    image_size = load_image_size(filename, s->storage, s->flash_size);
+    if (image_size < 0) {
+        error_setg(errp, "could not load flash image '%s'", filename);
+        return;
+    }
+    if (!rp2040_xip_fixup_boot2(s, filename, errp)) {
+        return;
+    }
+    rp2040_xip_writeback(s, errp);
+}
+
+bool rp2040_xip_flash_range_erase(RP2040XipState *s, uint32_t flash_offs,
+                                  uint32_t count, uint32_t block_size,
+                                  uint8_t block_cmd, Error **errp)
+{
+    if (!QEMU_IS_ALIGNED(flash_offs, FLASH_SECTOR_SIZE) ||
+        !QEMU_IS_ALIGNED(count, FLASH_SECTOR_SIZE)) {
+        error_setg(errp, "flash erase range is not sector-aligned");
+        return false;
+    }
+    if (flash_offs > s->flash_size || count > s->flash_size - flash_offs) {
+        error_setg(errp, "flash erase range is outside XIP storage");
+        return false;
+    }
+    if (block_size && block_size != 64 * KiB) {
+        g_autofree char *detail = g_strdup_printf("block size %" PRIu32,
+                                                  block_size);
+
+        rp2040_log_nyi("bootrom", "flash_range_erase block size", detail);
+    }
+    if (block_cmd != 0x20 && block_cmd != 0xd8) {
+        g_autofree char *detail = g_strdup_printf("erase command 0x%02x",
+                                                  block_cmd);
+
+        rp2040_log_nyi("bootrom", "flash_range_erase command", detail);
+    }
+
+    memset(s->storage + flash_offs, 0xff, count);
+    return rp2040_xip_writeback(s, errp);
+}
+
+bool rp2040_xip_flash_range_program(RP2040XipState *s, uint32_t flash_offs,
+                                    uint32_t data_addr, uint32_t count,
+                                    Error **errp)
+{
+    g_autofree uint8_t *buf = NULL;
+    uint32_t i;
+
+    if (!QEMU_IS_ALIGNED(flash_offs, FLASH_PAGE_SIZE) ||
+        !QEMU_IS_ALIGNED(count, FLASH_PAGE_SIZE)) {
+        error_setg(errp, "flash program range is not page-aligned");
+        return false;
+    }
+    if (flash_offs > s->flash_size || count > s->flash_size - flash_offs) {
+        error_setg(errp, "flash program range is outside XIP storage");
+        return false;
+    }
+
+    buf = g_malloc(count);
+    if (address_space_read(&address_space_memory, data_addr,
+                           MEMTXATTRS_UNSPECIFIED, buf, count) != MEMTX_OK) {
+        error_setg(errp, "could not read flash program buffer at 0x%08" PRIx32,
+                   data_addr);
+        return false;
+    }
+
+    for (i = 0; i < count; i++) {
+        s->storage[flash_offs + i] &= buf[i];
+    }
+
+    return rp2040_xip_writeback(s, errp);
+}
+
+static void rp2040_xip_realize(DeviceState *dev, Error **errp)
+{
+    RP2040XipState *s = RP2040_XIP(dev);
+    g_autofree gchar *contents = NULL;
+    gsize contents_len = 0;
+
+    if (s->flash_size == 0) {
+        error_setg(errp, "flash-size must be non-zero");
+        return;
+    }
+
+    s->xip_writable = true;
+    s->storage = g_malloc0(s->flash_size);
+    memset(s->storage, 0xff, s->flash_size);
+
+    if (s->flash_file) {
+        if (!g_file_get_contents(s->flash_file, &contents, &contents_len,
+                                 NULL)) {
+            error_setg(errp, "could not load flash file '%s'",
+                       s->flash_file);
+            return;
+        }
+        if (contents_len > s->flash_size) {
+            error_setg(errp, "flash file '%s' is %" G_GSIZE_FORMAT
+                       " bytes, larger than %" G_GSIZE_FORMAT
+                       " byte Pico flash",
+                       s->flash_file, contents_len, (gsize)s->flash_size);
+            return;
+        }
+        memcpy(s->storage, contents, contents_len);
+    }
+
+    memory_region_init_io(&s->xip, OBJECT(dev), &rp2040_xip_ops, s,
+                          "rp2040.xip", s->flash_size);
+    memory_region_init_io(&s->xip_noalloc, OBJECT(dev),
+                          &rp2040_xip_alias_ops, s, "rp2040.xip.noalloc",
+                          s->flash_size);
+    memory_region_init_io(&s->xip_nocache, OBJECT(dev),
+                          &rp2040_xip_alias_ops, s, "rp2040.xip.nocache",
+                          s->flash_size);
+    memory_region_init_io(&s->xip_nocache_noalloc, OBJECT(dev),
+                          &rp2040_xip_alias_ops, s,
+                          "rp2040.xip.nocache-noalloc", s->flash_size);
+    memory_region_init_io(&s->ctrl, OBJECT(dev), &rp2040_xip_ctrl_ops, s,
+                          "rp2040.xip.ctrl", RP2040_XIP_CTRL_SIZE);
+    memory_region_init_io(&s->ssi, OBJECT(dev), &rp2040_xip_ssi_ops, s,
+                          "rp2040.xip.ssi", RP2040_XIP_SSI_SIZE);
+    memory_region_init_io(&s->aux, OBJECT(dev), &rp2040_xip_aux_ops, s,
+                          "rp2040.xip.aux", RP2040_XIP_AUX_SIZE);
+
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->xip);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->ctrl);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->ssi);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->aux);
+}
+
+static void rp2040_xip_reset(DeviceState *dev)
+{
+    RP2040XipState *s = RP2040_XIP(dev);
+
+    s->xip_ctrl = RP2040_XIP_CTRL_EN | RP2040_XIP_CTRL_ERR_BADWRITE;
+    s->ctrlr0 = 0;
+    s->ctrlr1 = 0;
+    s->ssienr = 0;
+    s->ser = 0;
+    s->baudr = 0;
+    s->txftlr = 0;
+    s->rxftlr = 0;
+    s->imr = 0;
+    s->dmacr = 0;
+    s->dmatdlr = 0;
+    s->dmardlr = 4;
+    s->rx_sample_dly = 0;
+    s->spi_ctrlr0 = 0;
+    s->write_enable = false;
+    s->busy = false;
+    s->qspi_cs_high = true;
+    s->stream_addr = 0;
+    s->stream_ctr = 0;
+    rp2040_xip_stream_clear(s);
+    rp2040_xip_reset_tx(s);
+    rp2040_xip_rx_clear(s);
+}
+
+static void rp2040_xip_finalize(Object *obj)
+{
+    RP2040XipState *s = RP2040_XIP(obj);
+
+    g_free(s->flash_file);
+    g_free(s->storage);
+}
+
+static void rp2040_xip_init(Object *obj)
+{
+    RP2040XipState *s = RP2040_XIP(obj);
+
+    qdev_init_gpio_out_named(DEVICE(obj), &s->dreq_rx, "dreq-rx", 1);
+    qdev_init_gpio_out_named(DEVICE(obj), &s->dreq_stream, "dreq-stream", 1);
+}
+
+static const Property rp2040_xip_properties[] = {
+    DEFINE_PROP_UINT32("flash-size", RP2040XipState, flash_size, 2 * MiB),
+    DEFINE_PROP_STRING("flash-file", RP2040XipState, flash_file),
+    DEFINE_PROP_UINT64("flash-uid", RP2040XipState, flash_uid,
+                       FLASH_UID_DEFAULT),
+};
+
+static void rp2040_xip_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = rp2040_xip_realize;
+    device_class_set_legacy_reset(dc, rp2040_xip_reset);
+    device_class_set_props(dc, rp2040_xip_properties);
+}
+
+static const TypeInfo rp2040_xip_info = {
+    .name          = TYPE_RP2040_XIP,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040XipState),
+    .instance_init = rp2040_xip_init,
+    .instance_finalize = rp2040_xip_finalize,
+    .class_init    = rp2040_xip_class_init,
+};
+
+static void rp2040_xip_register_types(void)
+{
+    type_register_static(&rp2040_xip_info);
+}
+type_init(rp2040_xip_register_types)
diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
index b9d8648297..e94dfc1d7b 100644
--- a/hw/ssi/trace-events
+++ b/hw/ssi/trace-events
@@ -32,6 +32,18 @@ ibex_spi_host_transfer(uint32_t tx_data, uint32_t rx_data) "tx_data: 0x%" PRIx32
 ibex_spi_host_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size %u: 0x%" PRIx64
 ibex_spi_host_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size %u:"
 
+# rp2040_xip.c
+rp2040_xip_finish_command(uint8_t cmd, unsigned tx_len) "cmd 0x%02x tx_len %u"
+rp2040_xip_program(uint32_t addr, unsigned len, bool write_enable) "addr 0x%06x len %u wel %u"
+rp2040_xip_erase(uint32_t addr, bool write_enable) "addr 0x%06x wel %u"
+rp2040_xip_dr_write(uint64_t value, unsigned size, unsigned tx_len, uint32_t ctrlr0, uint32_t ctrlr1, uint32_t spi_ctrlr0) "value 0x%" PRIx64 " size %u tx_len %u ctrlr0 0x%08x ctrlr1 0x%08x spi_ctrlr0 0x%08x"
+rp2040_xip_ctrlr0(uint32_t value) "value 0x%08x"
+rp2040_xip_ctrlr1(uint32_t value) "value 0x%08x"
+rp2040_xip_spi_ctrlr0(uint32_t value) "value 0x%08x"
+rp2040_xip_qspi_cs(bool high, unsigned tx_len) "high %u tx_len %u"
+rp2040_xip_ssienr(uint32_t old_value, uint32_t new_value, unsigned tx_len) "old 0x%x new 0x%x tx_len %u"
+rp2040_xip_ser(uint32_t old_value, uint32_t new_value, unsigned tx_len) "old 0x%x new 0x%x tx_len %u"
+
 #pnv_spi.c
 pnv_spi_read(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 0x%" PRIx64
 pnv_spi_write(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 0x%" PRIx64
diff --git a/include/hw/arm/rp2040.h b/include/hw/arm/rp2040.h
index 16e5ca8846..cb108bd5f1 100644
--- a/include/hw/arm/rp2040.h
+++ b/include/hw/arm/rp2040.h
@@ -29,6 +29,7 @@
 #include "hw/misc/rp2040_vreg.h"
 #include "hw/misc/rp2040_watchdog.h"
 #include "hw/misc/rp2040_xosc.h"
+#include "hw/ssi/rp2040_xip.h"
 #include "qom/object.h"
 
 #define TYPE_RP2040 "rp2040"
@@ -37,6 +38,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(RP2040State, RP2040)
 #define RP2040_ROM_BASE       0x00000000
 #define RP2040_ROM_SIZE       (16 * KiB)
 #define RP2040_XIP_BASE       0x10000000
+#define RP2040_XIP_NOALLOC_BASE 0x11000000
+#define RP2040_XIP_NOCACHE_BASE 0x12000000
+#define RP2040_XIP_NOCACHE_NOALLOC_BASE 0x13000000
 #define RP2040_SRAM_BASE      0x20000000
 #define RP2040_SRAM_BANK_SIZE (64 * KiB)
 #define RP2040_SRAM4_BASE     0x20040000
@@ -69,6 +73,7 @@ struct RP2040State {
     RP2040VregState vreg;
     RP2040WatchdogState watchdog;
     RP2040XoscState xosc;
+    RP2040XipState xip;
 
     MemoryRegion *board_memory;
     MemoryRegion cpu_memory[RP2040_NUM_CORES];
diff --git a/include/hw/misc/rp2040_ioqspi.h b/include/hw/misc/rp2040_ioqspi.h
index e671d2a1b5..eae63588e6 100644
--- a/include/hw/misc/rp2040_ioqspi.h
+++ b/include/hw/misc/rp2040_ioqspi.h
@@ -13,6 +13,8 @@
 #define TYPE_RP2040_IOQSPI "rp2040-ioqspi"
 OBJECT_DECLARE_SIMPLE_TYPE(RP2040IoQspiState, RP2040_IOQSPI)
 
+typedef struct RP2040XipState RP2040XipState;
+
 #define RP2040_IOQSPI_BASE 0x40018000
 #define RP2040_IOQSPI_SIZE 0x4000
 
@@ -28,6 +30,7 @@ struct RP2040IoQspiState {
     uint32_t proc1_intf;
     uint32_t dormant_wake_inte;
     uint32_t dormant_wake_intf;
+    RP2040XipState *xip;
 };
 
 #endif
diff --git a/include/hw/ssi/rp2040_xip.h b/include/hw/ssi/rp2040_xip.h
new file mode 100644
index 0000000000..53d91f88e9
--- /dev/null
+++ b/include/hw/ssi/rp2040_xip.h
@@ -0,0 +1,92 @@
+/*
+ * RP2040 XIP/SSI flash controller emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_SSI_RP2040_XIP_H
+#define HW_SSI_RP2040_XIP_H
+
+#include "hw/core/sysbus.h"
+#include "hw/core/irq.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_XIP "rp2040-xip"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040XipState, RP2040_XIP)
+
+#define RP2040_XIP_CTRL_BASE 0x14000000
+#define RP2040_XIP_SSI_BASE  0x18000000
+#define RP2040_XIP_AUX_BASE  0x50400000
+#define RP2040_XIP_CTRL_SIZE 0x4000
+#define RP2040_XIP_SSI_SIZE  0x4000
+#define RP2040_XIP_AUX_SIZE  0x4000
+#define RP2040_XIP_STREAM_FIFO_DEPTH 4
+
+struct RP2040XipState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion xip;
+    MemoryRegion xip_noalloc;
+    MemoryRegion xip_nocache;
+    MemoryRegion xip_nocache_noalloc;
+    MemoryRegion ctrl;
+    MemoryRegion ssi;
+    MemoryRegion aux;
+    qemu_irq dreq_rx;
+    qemu_irq dreq_stream;
+
+    uint32_t flash_size;
+    char *flash_file;
+    uint64_t flash_uid;
+    uint8_t *storage;
+    bool xip_writable;
+
+    uint32_t xip_ctrl;
+
+    uint32_t ctrlr0;
+    uint32_t ctrlr1;
+    uint32_t ssienr;
+    uint32_t ser;
+    uint32_t baudr;
+    uint32_t txftlr;
+    uint32_t rxftlr;
+    uint32_t imr;
+    uint32_t dmacr;
+    uint32_t dmatdlr;
+    uint32_t dmardlr;
+    uint32_t rx_sample_dly;
+    uint32_t spi_ctrlr0;
+
+    bool write_enable;
+    bool busy;
+    bool qspi_cs_high;
+    uint8_t tx[260];
+    unsigned tx_len;
+    bool tx_unsupported_logged;
+    uint8_t rx[16];
+    unsigned rx_len;
+    unsigned rx_pos;
+    uint32_t ssi_bulk_addr;
+    uint32_t ssi_bulk_remaining;
+
+    uint32_t stream_addr;
+    uint32_t stream_ctr;
+    uint32_t stream_fifo[RP2040_XIP_STREAM_FIFO_DEPTH];
+    unsigned stream_fifo_len;
+    unsigned stream_fifo_pos;
+};
+
+void rp2040_xip_set_writable(RP2040XipState *s, bool writable);
+MemTxResult rp2040_xip_read_data(RP2040XipState *s, hwaddr addr,
+                                 uint64_t *data, unsigned size);
+void rp2040_xip_load_image(RP2040XipState *s, const char *filename,
+                           Error **errp);
+void rp2040_xip_qspi_cs(RP2040XipState *s, bool high);
+bool rp2040_xip_flash_range_erase(RP2040XipState *s, uint32_t flash_offs,
+                                  uint32_t count, uint32_t block_size,
+                                  uint8_t block_cmd, Error **errp);
+bool rp2040_xip_flash_range_program(RP2040XipState *s, uint32_t flash_offs,
+                                    uint32_t data_addr, uint32_t count,
+                                    Error **errp);
+
+#endif
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index f0ffa84dd1..9bc7540aee 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -268,7 +268,8 @@ qtests_arm = \
                                                        'rp2040-timer-test',
                                                        'rp2040-uart-test',
                                                        'rp2040-vreg-test',
-                                                       'rp2040-watchdog-test'] : []) + \
+                                                       'rp2040-watchdog-test',
+                                                       'rp2040-xip-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4x5 : []) + \
   (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['aspeed_fsi-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CAN_FLEXCAN') ? ['flexcan-test'] : []) + \
diff --git a/tests/qtest/rp2040-xip-test.c b/tests/qtest/rp2040-xip-test.c
new file mode 100644
index 0000000000..8e5b719332
--- /dev/null
+++ b/tests/qtest/rp2040-xip-test.c
@@ -0,0 +1,293 @@
+/*
+ * QTest testcase for the RP2040 XIP/SSI block.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/bitops.h"
+#include "qemu/bswap.h"
+
+#define XIP_BASE     0x10000000
+#define XIP_NOCACHE_NOALLOC_BASE 0x13000000
+#define XIP_CTRL_BASE 0x14000000
+#define XIP_STAT     0x08
+#define XIP_STREAM_ADDR 0x14
+#define XIP_STREAM_CTR  0x18
+#define XIP_STREAM_FIFO 0x1c
+#define XIP_SSI_BASE 0x18000000
+#define SSI_CTRLR1   0x04
+#define SSI_SSIENR   0x08
+#define SSI_DR0      0x60
+#define SSI_SER      0x10
+
+#define IOQSPI_BASE    0x40018000
+#define IOQSPI_SS_CTRL 0x0c
+#define IOQSPI_OUT_LOW  0x200
+#define IOQSPI_OUT_HIGH 0x300
+
+#define XIP_STAT_FIFO_FULL  BIT(2)
+#define XIP_STAT_FIFO_EMPTY BIT(1)
+#define XIP_STAT_FLUSH_READY BIT(0)
+
+static QTestState *rp2040_start(const char *machine_args)
+{
+    if (machine_args) {
+        return qtest_initf("-machine raspi-pico,%s", machine_args);
+    }
+    return qtest_init("-machine raspi-pico");
+}
+
+static void read_flash_uid(QTestState *qts, uint8_t *uid)
+{
+    int i;
+
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, 0x4b);
+    qtest_readl(qts, XIP_SSI_BASE + SSI_DR0);
+    for (i = 0; i < 4; i++) {
+        qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, 0);
+        qtest_readl(qts, XIP_SSI_BASE + SSI_DR0);
+    }
+    for (i = 0; i < 8; i++) {
+        qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, 0);
+        uid[i] = qtest_readl(qts, XIP_SSI_BASE + SSI_DR0);
+    }
+}
+
+static void program_flash_bytes(QTestState *qts, uint32_t off,
+                                const uint8_t *buf, size_t len)
+{
+    size_t i;
+
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, 0x06);
+
+    qtest_writel(qts, XIP_SSI_BASE + SSI_SER, 1);
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, 0x02);
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, extract32(off, 16, 8));
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, extract32(off, 8, 8));
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, extract32(off, 0, 8));
+    for (i = 0; i < len; i++) {
+        qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, buf[i]);
+    }
+    qtest_writel(qts, XIP_SSI_BASE + SSI_SER, 0);
+
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, 0x05);
+    qtest_readl(qts, XIP_SSI_BASE + SSI_DR0);
+}
+
+static void program_flash_bytes_without_wel(QTestState *qts, uint32_t off,
+                                            const uint8_t *buf, size_t len)
+{
+    size_t i;
+
+    qtest_writel(qts, XIP_SSI_BASE + SSI_SER, 1);
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, 0x02);
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, extract32(off, 16, 8));
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, extract32(off, 8, 8));
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, extract32(off, 0, 8));
+    for (i = 0; i < len; i++) {
+        qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, buf[i]);
+    }
+    qtest_writel(qts, XIP_SSI_BASE + SSI_SER, 0);
+}
+
+static void erase_flash_sector(QTestState *qts, uint32_t off)
+{
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, 0x06);
+    qtest_writel(qts, XIP_SSI_BASE + SSI_SER, 1);
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, 0x20);
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, extract32(off, 16, 8));
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, extract32(off, 8, 8));
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, extract32(off, 0, 8));
+    qtest_writel(qts, XIP_SSI_BASE + SSI_SER, 0);
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, 0x05);
+    qtest_readl(qts, XIP_SSI_BASE + SSI_DR0);
+}
+
+static void test_flash_uid_default(void)
+{
+    static const uint8_t expected[] = {
+        0x3e, 0xb8, 0xa7, 0x49, 0x3f, 0xcc, 0x06, 0x08,
+    };
+    QTestState *qts = rp2040_start(NULL);
+    uint8_t uid[8];
+
+    read_flash_uid(qts, uid);
+    g_assert_cmpmem(uid, sizeof(uid), expected, sizeof(expected));
+
+    qtest_quit(qts);
+}
+
+static void test_flash_uid_machine_option(void)
+{
+    static const uint8_t expected[] = {
+        0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
+    };
+    QTestState *qts = rp2040_start("flash-uid=0011223344556677");
+    uint8_t uid[8];
+
+    read_flash_uid(qts, uid);
+    g_assert_cmpmem(uid, sizeof(uid), expected, sizeof(expected));
+
+    qtest_quit(qts);
+}
+
+static void test_flash_program_erase(void)
+{
+    static const uint8_t first[] = { 0x0f, 0x55, 0xaa, 0xf0 };
+    static const uint8_t second[] = { 0xf0, 0xaa, 0x55, 0x0f };
+    static const uint8_t combined[] = { 0x00, 0x00, 0x00, 0x00 };
+    static const uint8_t erased[] = { 0xff, 0xff, 0xff, 0xff };
+    uint8_t actual[sizeof(first)];
+    QTestState *qts = rp2040_start(NULL);
+
+    program_flash_bytes_without_wel(qts, 0x1000, first, sizeof(first));
+    qtest_memread(qts, XIP_BASE + 0x1000, actual, sizeof(actual));
+    g_assert_cmpmem(actual, sizeof(actual), erased, sizeof(erased));
+
+    program_flash_bytes(qts, 0x1000, first, sizeof(first));
+    program_flash_bytes(qts, 0x1000, second, sizeof(second));
+    qtest_memread(qts, XIP_BASE + 0x1000, actual, sizeof(actual));
+    g_assert_cmpmem(actual, sizeof(actual), combined, sizeof(combined));
+
+    erase_flash_sector(qts, 0x1000);
+    qtest_memread(qts, XIP_BASE + 0x1000, actual, sizeof(actual));
+    g_assert_cmpmem(actual, sizeof(actual), erased, sizeof(erased));
+
+    qtest_quit(qts);
+}
+
+static void test_flash_persistence(void)
+{
+    static const uint8_t expected[] = { 0x12, 0x34, 0x56, 0x78 };
+    g_autoptr(GError) error = NULL;
+    g_autofree char *path = NULL;
+    g_autofree char *machine_args = NULL;
+    uint8_t initial[4096];
+    uint8_t actual[sizeof(expected)];
+    QTestState *qts;
+    int fd;
+
+    memset(initial, 0xff, sizeof(initial));
+    fd = g_file_open_tmp("qemu-rp2040-flash-XXXXXX", &path, &error);
+    g_assert_no_error(error);
+    g_assert_cmpint(fd, >=, 0);
+    close(fd);
+    g_assert_true(g_file_set_contents(path, (const char *)initial,
+                                      sizeof(initial), &error));
+    g_assert_no_error(error);
+
+    machine_args = g_strdup_printf("flash-file=%s", path);
+    qts = rp2040_start(machine_args);
+    program_flash_bytes(qts, 0x800, expected, sizeof(expected));
+    qtest_quit(qts);
+
+    qts = rp2040_start(machine_args);
+    qtest_memread(qts, XIP_BASE + 0x800, actual, sizeof(actual));
+    g_assert_cmpmem(actual, sizeof(actual), expected, sizeof(expected));
+    qtest_quit(qts);
+
+    unlink(path);
+}
+
+static void test_ioqspi_chip_select(void)
+{
+    static const uint8_t expected[] = { 0x5a, 0xa5 };
+    uint8_t actual[sizeof(expected)];
+    QTestState *qts = rp2040_start(NULL);
+    size_t i;
+
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, 0x06);
+    qtest_writel(qts, IOQSPI_BASE + IOQSPI_SS_CTRL, IOQSPI_OUT_LOW);
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, 0x02);
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, 0x00);
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, 0x20);
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, 0x00);
+    for (i = 0; i < ARRAY_SIZE(expected); i++) {
+        qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, expected[i]);
+    }
+    qtest_writel(qts, IOQSPI_BASE + IOQSPI_SS_CTRL, IOQSPI_OUT_HIGH);
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, 0x05);
+    qtest_readl(qts, XIP_SSI_BASE + SSI_DR0);
+
+    qtest_memread(qts, XIP_BASE + 0x2000, actual, sizeof(actual));
+    g_assert_cmpmem(actual, sizeof(actual), expected, sizeof(expected));
+    qtest_quit(qts);
+}
+
+static void test_stream_fifo(void)
+{
+    static const uint32_t expected[] = {
+        0x03020100, 0x07060504, 0x0b0a0908, 0x0f0e0d0c,
+        0x13121110, 0x17161514,
+    };
+    QTestState *qts = rp2040_start(NULL);
+    size_t i;
+
+    program_flash_bytes(qts, 0, (const uint8_t *)expected, sizeof(expected));
+
+    qtest_writel(qts, XIP_CTRL_BASE + XIP_STREAM_ADDR, XIP_BASE);
+    qtest_writel(qts, XIP_CTRL_BASE + XIP_STREAM_CTR, ARRAY_SIZE(expected));
+
+    g_assert_cmphex(qtest_readl(qts, XIP_CTRL_BASE + XIP_STAT) &
+                    (XIP_STAT_FLUSH_READY | XIP_STAT_FIFO_FULL), ==,
+                    XIP_STAT_FLUSH_READY | XIP_STAT_FIFO_FULL);
+    for (i = 0; i < ARRAY_SIZE(expected); i++) {
+        g_assert_cmphex(qtest_readl(qts,
+                                   XIP_CTRL_BASE + XIP_STREAM_FIFO), ==,
+                        expected[i]);
+    }
+    g_assert_cmphex(qtest_readl(qts, XIP_CTRL_BASE + XIP_STREAM_CTR), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, XIP_CTRL_BASE + XIP_STAT) &
+                    XIP_STAT_FIFO_EMPTY, ==, XIP_STAT_FIFO_EMPTY);
+
+    qtest_quit(qts);
+}
+
+static void test_ssi_bulk_read(void)
+{
+    static const uint32_t expected[] = {
+        0x03020100, 0x07060504, 0x0b0a0908, 0x0f0e0d0c,
+        0x13121110, 0x17161514,
+    };
+    QTestState *qts = rp2040_start(NULL);
+    size_t i;
+
+    program_flash_bytes(qts, 0, (const uint8_t *)expected, sizeof(expected));
+    g_assert_cmphex(qtest_readl(qts, XIP_NOCACHE_NOALLOC_BASE), ==,
+                    expected[0]);
+
+    qtest_writel(qts, XIP_SSI_BASE + SSI_SSIENR, 0);
+    qtest_writel(qts, XIP_SSI_BASE + SSI_CTRLR1, ARRAY_SIZE(expected) - 1);
+    qtest_writel(qts, XIP_SSI_BASE + SSI_SSIENR, 1);
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, 0xa0);
+
+    for (i = 0; i < ARRAY_SIZE(expected); i++) {
+        g_assert_cmphex(bswap32(qtest_readl(qts,
+                                           XIP_SSI_BASE + SSI_DR0)), ==,
+                        expected[i]);
+    }
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/rp2040-xip/flash-uid-default",
+                   test_flash_uid_default);
+    qtest_add_func("/rp2040-xip/flash-uid-machine-option",
+                   test_flash_uid_machine_option);
+    qtest_add_func("/rp2040-xip/flash-program-erase",
+                   test_flash_program_erase);
+    qtest_add_func("/rp2040-xip/flash-persistence",
+                   test_flash_persistence);
+    qtest_add_func("/rp2040-xip/ioqspi-chip-select",
+                   test_ioqspi_chip_select);
+    qtest_add_func("/rp2040-xip/stream-fifo", test_stream_fifo);
+    qtest_add_func("/rp2040-xip/ssi-bulk-read", test_ssi_bulk_read);
+
+    return g_test_run();
+}
diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefile.softmmu-target
index f3efe619d1..a07264fd89 100644
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ b/tests/tcg/arm/Makefile.softmmu-target
@@ -24,11 +24,12 @@ RP2040_TESTS=rp2040-boot rp2040-uart rp2040-mpu \
 	rp2040-sio-fifo rp2040-sio-divider rp2040-psm-proc1 \
 	rp2040-core1-launch rp2040-timer
 
-$(RP2040_TESTS): %: %.S rp2040-minimal.ld
+$(RP2040_TESTS): %: %.S rp2040-boot2-w25q080.S rp2040.ld
 	$(CC) -mcpu=cortex-m0plus -mthumb -mfloat-abi=soft \
 		-Wl,--build-id=none -x assembler-with-cpp \
-		$< -o $@ -nostdlib -static \
-		-T $(ARM_SRC)/rp2040-minimal.ld
+		$(ARM_SRC)/rp2040-boot2-w25q080.S $< \
+		-o $@ -nostdlib -static \
+		-T $(ARM_SRC)/rp2040.ld
 
 run-rp2040-boot: QEMU_OPTS=-M raspi-pico \
 	-semihosting-config enable=on,target=native -kernel
diff --git a/tests/tcg/arm/system/rp2040-boot2-w25q080.S b/tests/tcg/arm/system/rp2040-boot2-w25q080.S
new file mode 100644
index 0000000000..d128b98421
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-boot2-w25q080.S
@@ -0,0 +1,178 @@
+/*
+ * RP2040 second-stage boot code for the Winbond W25Q080.
+ *
+ * Derived from boot2_w25q080.S in the Raspberry Pi Pico SDK.
+ * Copyright (c) 2019-2021 Raspberry Pi (Trading) Ltd.
+ *
+ * SPDX-License-Identifier: BSD-3-Clause
+ */
+
+.syntax unified
+.cpu cortex-m0plus
+.thumb
+
+#define PADS_QSPI_BASE          0x40020000
+#define XIP_SSI_BASE            0x18000000
+#define XIP_BASE                0x10000000
+#define VTOR                    0xe000ed08
+
+#define PADS_QSPI_SCLK          0x04
+#define PADS_QSPI_SD0           0x08
+#define PADS_QSPI_SD1           0x0c
+#define PADS_QSPI_SD2           0x10
+#define PADS_QSPI_SD3           0x14
+#define PADS_QSPI_SCHMITT       0x02
+#define PADS_QSPI_SCLK_8MA_FAST 0x21
+
+#define SSI_CTRLR0              0x00
+#define SSI_CTRLR1              0x04
+#define SSI_SSIENR              0x08
+#define SSI_BAUDR               0x14
+#define SSI_SR                  0x28
+#define SSI_DR0                 0x60
+#define SSI_RX_SAMPLE_DLY       0xf0
+#define SSI_SPI_CTRLR0          0xf4
+
+#define SSI_SR_BUSY             0x01
+#define SSI_SR_TFE              0x04
+
+#define CTRL0_SPI_TXRX          0x00070000
+#define CTRLR0_ENTER_XIP        0x005f0300
+#define SPI_CTRLR0_ENTER_XIP    0x00002221
+#define SPI_CTRLR0_XIP          0xa0002022
+
+#define CMD_WRITE_STATUS        0x01
+#define CMD_READ_STATUS         0x05
+#define CMD_WRITE_ENABLE        0x06
+#define CMD_READ_STATUS2        0x35
+#define CMD_QUAD_IO_READ        0xeb
+#define STATUS2_QUAD_ENABLE     0x02
+#define MODE_CONTINUOUS_READ    0xa0
+
+.section .boot2, "ax", %progbits
+.global boot2
+.type boot2, %function
+.thumb_func
+boot2:
+    push {lr}
+
+    ldr r3, =PADS_QSPI_BASE
+    movs r0, PADS_QSPI_SCLK_8MA_FAST
+    str r0, [r3, PADS_QSPI_SCLK]
+    ldr r0, [r3, PADS_QSPI_SD0]
+    movs r1, PADS_QSPI_SCHMITT
+    bics r0, r1
+    str r0, [r3, PADS_QSPI_SD0]
+    str r0, [r3, PADS_QSPI_SD1]
+    str r0, [r3, PADS_QSPI_SD2]
+    str r0, [r3, PADS_QSPI_SD3]
+
+    ldr r3, =XIP_SSI_BASE
+    movs r1, 0
+    str r1, [r3, SSI_SSIENR]
+    movs r1, 2
+    str r1, [r3, SSI_BAUDR]
+    movs r1, 1
+    movs r2, SSI_RX_SAMPLE_DLY
+    str r1, [r3, r2]
+
+    ldr r1, =CTRL0_SPI_TXRX
+    str r1, [r3, SSI_CTRLR0]
+    movs r1, 1
+    str r1, [r3, SSI_SSIENR]
+
+    movs r0, CMD_READ_STATUS2
+    bl read_flash_sreg
+    movs r2, STATUS2_QUAD_ENABLE
+    cmp r0, r2
+    beq skip_status_programming
+
+    movs r1, CMD_WRITE_ENABLE
+    str r1, [r3, SSI_DR0]
+    bl wait_ssi_ready
+    ldr r1, [r3, SSI_DR0]
+
+    movs r1, CMD_WRITE_STATUS
+    str r1, [r3, SSI_DR0]
+    movs r0, 0
+    str r0, [r3, SSI_DR0]
+    str r2, [r3, SSI_DR0]
+    bl wait_ssi_ready
+    ldr r1, [r3, SSI_DR0]
+    ldr r1, [r3, SSI_DR0]
+    ldr r1, [r3, SSI_DR0]
+
+1:
+    movs r0, CMD_READ_STATUS
+    bl read_flash_sreg
+    movs r1, 1
+    tst r0, r1
+    bne 1b
+
+skip_status_programming:
+    movs r1, 0
+    str r1, [r3, SSI_SSIENR]
+
+    ldr r1, =CTRLR0_ENTER_XIP
+    str r1, [r3, SSI_CTRLR0]
+    movs r1, 0
+    str r1, [r3, SSI_CTRLR1]
+    ldr r1, =SPI_CTRLR0_ENTER_XIP
+    ldr r0, =(XIP_SSI_BASE + SSI_SPI_CTRLR0)
+    str r1, [r0]
+    movs r1, 1
+    str r1, [r3, SSI_SSIENR]
+    movs r1, CMD_QUAD_IO_READ
+    str r1, [r3, SSI_DR0]
+    movs r1, MODE_CONTINUOUS_READ
+    str r1, [r3, SSI_DR0]
+    bl wait_ssi_ready
+
+    movs r1, 0
+    str r1, [r3, SSI_SSIENR]
+    ldr r1, =SPI_CTRLR0_XIP
+    ldr r0, =(XIP_SSI_BASE + SSI_SPI_CTRLR0)
+    str r1, [r0]
+    movs r1, 1
+    str r1, [r3, SSI_SSIENR]
+
+    pop {r0}
+    cmp r0, 0
+    beq vector_into_flash
+    bx r0
+
+vector_into_flash:
+    ldr r0, =(XIP_BASE + 0x100)
+    ldr r1, =VTOR
+    str r0, [r1]
+    ldmia r0, {r0, r1}
+    msr msp, r0
+    bx r1
+
+wait_ssi_ready:
+    push {r0, r1, lr}
+2:
+    ldr r1, [r3, SSI_SR]
+    movs r0, SSI_SR_TFE
+    tst r1, r0
+    beq 2b
+    movs r0, SSI_SR_BUSY
+    tst r1, r0
+    bne 2b
+    pop {r0, r1, pc}
+
+read_flash_sreg:
+    push {r1, lr}
+    str r0, [r3, SSI_DR0]
+    str r0, [r3, SSI_DR0]
+    bl wait_ssi_ready
+    ldr r0, [r3, SSI_DR0]
+    ldr r0, [r3, SSI_DR0]
+    pop {r1, pc}
+
+.align 2
+.ltorg
+
+    .space 252 - (. - boot2), 0
+    .word 0
+.size boot2, . - boot2
diff --git a/tests/tcg/arm/system/rp2040-minimal.ld b/tests/tcg/arm/system/rp2040.ld
similarity index 72%
rename from tests/tcg/arm/system/rp2040-minimal.ld
rename to tests/tcg/arm/system/rp2040.ld
index ebfbac8cf2..9d902bf2b9 100644
--- a/tests/tcg/arm/system/rp2040-minimal.ld
+++ b/tests/tcg/arm/system/rp2040.ld
@@ -1,5 +1,3 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-
 ENTRY(reset_handler)
 
 MEMORY
@@ -10,7 +8,14 @@ MEMORY
 
 SECTIONS
 {
-    .vectors ORIGIN(FLASH) :
+    .boot2 ORIGIN(FLASH) :
+    {
+        KEEP(*(.boot2))
+    } > FLASH
+
+    ASSERT(SIZEOF(.boot2) == 256, "RP2040 boot2 must be exactly 256 bytes")
+
+    .vectors ORIGIN(FLASH) + 0x100 :
     {
         KEEP(*(.vectors))
     } > FLASH
-- 
2.55.0


