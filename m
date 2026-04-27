Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF0EFF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHHbd-0005pL-QV; Mon, 27 Apr 2026 04:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wHHbb-0005oz-5N; Mon, 27 Apr 2026 04:46:15 -0400
Received: from mail.aspeedtech.com ([211.20.114.72]
 helo=twmbx01.aspeedtech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wHHbY-0001C8-D2; Mon, 27 Apr 2026 04:46:14 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 27 Apr
 2026 16:40:55 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 27 Apr 2026 16:40:55 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <longzl2@lenovo.com>,
 <yunlin.tang@aspeedtech.com>, <steven_lee@aspeedtech.com>
Subject: [RFC PATCH v1 1/1] hw/arm: aspeed: Add PoC integration for Caliptra
 Root of Trust
Date: Mon, 27 Apr 2026 16:40:54 +0800
Message-ID: <20260427084055.2246089-2-steven_lee@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427084055.2246089-1-steven_lee@aspeedtech.com>
References: <20260427084055.2246089-1-steven_lee@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=steven_lee@aspeedtech.com; helo=twmbx01.aspeedtech.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Reply-to:  Steven Lee <steven_lee@aspeedtech.com>
From:  Steven Lee via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The ASPEED AST2700fc SoC integrates the Caliptra Root of Trust
(Caliptra 1.2 core). Moving forward, we expect more SoCs to adopt
Caliptra cores (e.g., Caliptra 2.x). Currently, QEMU does not have
a native Caliptra emulator.

The official `caliptra-sw` project provides a fully functional
emulator with C-bindings. As a Proof of Concept, this RFC integrates
the external `caliptra-sw` C-binding model into QEMU to enable booting
the AST2700fc machine.

This RFC does not propose merging the current PoC design as-is.
Instead, it is intended to explore possible approaches for adding
Caliptra support in QEMU and to gather early feedback from the
community on architecture and integration strategy.

In this PoC, the `caliptra-sw` emulator is used as a reference model
to enable early bring-up and validation of the AST2700fc secure boot
flow, rather than as a final implementation choice. The integration is
based on the `caliptra-1.2` branch of the official repository:
https://github.com/chipsalliance/caliptra-sw/tree/caliptra-1.2

To avoid making normal ASPEED/AArch64 builds depend on a local external
checkout, the c-binding backend is compiled only when the PoC detects
the generated `caliptra-sw` c-binding header and static library in the
expected sibling source tree.  A mergeable version would need an
explicit configure option and a proper dependency integration.

For context, the actual hardware boot flow on the AST2700fc relies on a
dedicated RISC-V core (bootmcu) to orchestrate the secure boot:

  1. bootmcu executes its ROM code.
  2. bootmcu releases the Caliptra core from reset.
  3. Caliptra requests its FMC and Runtime (RT) firmware.
  4. bootmcu loads the Caliptra FMC/RT images into Caliptra's mailbox.
  5. Caliptra ROM verifies the signature of the Caliptra FMC/RT images.
  6. Caliptra boots into its FMC and RT environments.
  7. bootmcu requests Caliptra RT to verify the bootmcu's own FMC.
  8. bootmcu executes its FMC.
  9. bootmcu requests Caliptra to verify the BMC (Cortex-A35) firmware.
 10. BMC (Cortex-A35) firmware begins execution.

Since QEMU currently lacks a `bootmcu` model and the associated mailbox
interactions with Caliptra, this PoC simplifies the boot flow by using
a background thread and the `caliptra_model_boot_default` C-binding to
simulate steps 1 through 6.

To approximate the hardware behavior where the Cortex-A35 CPUs remain
in reset until secure boot is completed, this PoC uses
`vm_stop_force_state()` as a temporary approximation.

This approach is intentionally simplified and not intended to reflect
the final QEMU design. In particular, the use of a background thread
and global VM control APIs may not align with QEMU device model
expectations, and alternative approaches are encouraged.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
---
 MAINTAINERS                          |   2 +
 docs/system/arm/aspeed.rst           |  20 +++
 include/hw/arm/aspeed_caliptra_emu.h |  17 ++
 hw/arm/aspeed_ast27x0-fc.c           |  60 +++++++
 hw/arm/aspeed_caliptra_emu.c         | 259 +++++++++++++++++++++++++++
 hw/arm/meson.build                   |  31 +++-
 6 files changed, 388 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/arm/aspeed_caliptra_emu.h
 create mode 100644 hw/arm/aspeed_caliptra_emu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ad215eced8..376959dfd2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1254,6 +1254,8 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/*/*aspeed*
 F: include/hw/*/*aspeed*
+F: hw/arm/aspeed_caliptra_emu.c
+F: include/hw/arm/aspeed_caliptra_emu.h
 F: hw/net/ftgmac100.c
 F: include/hw/net/ftgmac100.h
 F: docs/system/arm/aspeed.rst
diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index d0054a7dbb..656924262b 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -423,6 +423,26 @@ Steps to boot the AST2700fc machine:
        -snapshot \
        -S -nographic
 
+The ``ast2700fc`` machine can also boot a Caliptra emulator through the
+``caliptra-sw`` c-binding before starting the Cortex-A35 processors.  The ROM
+and firmware bundle are configured with the ``caliptra-rom`` and
+``caliptra-firmware`` machine properties.
+
+This RFC PoC backend is built only when a local ``../caliptra-sw`` checkout
+contains the generated c-binding header and static library.
+
+For example, to run Caliptra firmware from ``caliptra-sw``:
+
+.. code-block:: bash
+
+  $ qemu-system-aarch64 \
+       -M ast2700fc,caliptra-rom=images/caliptra-rom-with-log.bin,caliptra-firmware=images/caliptra-fw.bundle \
+       ...
+
+QEMU boots the c-binding model to the Caliptra runtime-ready boot status before
+starting the Cortex-A35 CPUs.  If these properties are omitted, no Caliptra
+backend is launched.
+
 After launching QEMU, serial devices will be automatically redirected.
 Example output:
 
diff --git a/include/hw/arm/aspeed_caliptra_emu.h b/include/hw/arm/aspeed_caliptra_emu.h
new file mode 100644
index 0000000000..136e327d11
--- /dev/null
+++ b/include/hw/arm/aspeed_caliptra_emu.h
@@ -0,0 +1,17 @@
+/*
+ * ASPEED Caliptra emulator backend
+ *
+ * Copyright (C) 2026 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef ASPEED_CALIPTRA_EMU_H
+#define ASPEED_CALIPTRA_EMU_H
+
+#include "chardev/char.h"
+
+void aspeed_caliptra_emu_start(Chardev *console, const char *rom_path,
+                               const char *firmware_path);
+
+#endif /* ASPEED_CALIPTRA_EMU_H */
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 5eb6680da9..84aedef815 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -22,6 +22,7 @@
 #include "hw/arm/boot.h"
 #include "hw/block/flash.h"
 #include "hw/arm/aspeed_coprocessor.h"
+#include "hw/arm/aspeed_caliptra_emu.h"
 #include "hw/arm/machines-qom.h"
 
 #define TYPE_AST2700FC MACHINE_TYPE_NAME("ast2700fc")
@@ -34,6 +35,9 @@ static struct arm_boot_info ast2700fc_board_info = {
 struct Ast2700FCState {
     MachineState parent_obj;
 
+    char *caliptra_rom;
+    char *caliptra_firmware;
+
     MemoryRegion ca35_memory;
     MemoryRegion ca35_dram;
     MemoryRegion ca35_boot_rom;
@@ -198,9 +202,53 @@ static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)
 
 static void ast2700fc_init(MachineState *machine)
 {
+    Ast2700FCState *s = AST2700FC(machine);
+
     ast2700fc_ca35_init(machine, &error_abort);
     ast2700fc_ssp_init(machine, &error_abort);
     ast2700fc_tsp_init(machine, &error_abort);
+    aspeed_caliptra_emu_start(serial_hd(0), s->caliptra_rom,
+                              s->caliptra_firmware);
+}
+
+static char *ast2700fc_get_caliptra_rom(Object *obj, Error **errp)
+{
+    Ast2700FCState *s = AST2700FC(obj);
+
+    return g_strdup(s->caliptra_rom ? s->caliptra_rom : "");
+}
+
+static void ast2700fc_set_caliptra_rom(Object *obj, const char *value,
+                                       Error **errp)
+{
+    Ast2700FCState *s = AST2700FC(obj);
+
+    g_free(s->caliptra_rom);
+    s->caliptra_rom = g_strdup(value);
+}
+
+static char *ast2700fc_get_caliptra_firmware(Object *obj, Error **errp)
+{
+    Ast2700FCState *s = AST2700FC(obj);
+
+    return g_strdup(s->caliptra_firmware ? s->caliptra_firmware : "");
+}
+
+static void ast2700fc_set_caliptra_firmware(Object *obj, const char *value,
+                                            Error **errp)
+{
+    Ast2700FCState *s = AST2700FC(obj);
+
+    g_free(s->caliptra_firmware);
+    s->caliptra_firmware = g_strdup(value);
+}
+
+static void ast2700fc_instance_finalize(Object *obj)
+{
+    Ast2700FCState *s = AST2700FC(obj);
+
+    g_free(s->caliptra_rom);
+    g_free(s->caliptra_firmware);
 }
 
 static void ast2700fc_class_init(ObjectClass *oc, const void *data)
@@ -212,6 +260,17 @@ static void ast2700fc_class_init(ObjectClass *oc, const void *data)
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->min_cpus = mc->max_cpus = mc->default_cpus = 6;
+
+    object_class_property_add_str(oc, "caliptra-rom",
+                                  ast2700fc_get_caliptra_rom,
+                                  ast2700fc_set_caliptra_rom);
+    object_class_property_set_description(oc, "caliptra-rom",
+        "Caliptra ROM image used by the c-binding emulator backend");
+    object_class_property_add_str(oc, "caliptra-firmware",
+                                  ast2700fc_get_caliptra_firmware,
+                                  ast2700fc_set_caliptra_firmware);
+    object_class_property_set_description(oc, "caliptra-firmware",
+        "Caliptra firmware bundle used by the c-binding emulator backend");
 }
 
 static const TypeInfo ast2700fc_types[] = {
@@ -220,6 +279,7 @@ static const TypeInfo ast2700fc_types[] = {
         .parent         = TYPE_MACHINE,
         .class_init     = ast2700fc_class_init,
         .instance_size  = sizeof(Ast2700FCState),
+        .instance_finalize = ast2700fc_instance_finalize,
         .interfaces     = aarch64_machine_interfaces,
     },
 };
diff --git a/hw/arm/aspeed_caliptra_emu.c b/hw/arm/aspeed_caliptra_emu.c
new file mode 100644
index 0000000000..c5dfbc786f
--- /dev/null
+++ b/hw/arm/aspeed_caliptra_emu.c
@@ -0,0 +1,259 @@
+/*
+ * ASPEED Caliptra emulator backend
+ *
+ * Copyright (C) 2026 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "chardev/char.h"
+#include "hw/arm/aspeed_caliptra_emu.h"
+#include "qemu/error-report.h"
+
+#ifdef CONFIG_ASPEED_CALIPTRA_CBINDING
+#include "qemu/main-loop.h"
+#include "qemu/thread.h"
+#include "system/runstate.h"
+
+#include "caliptra_model.h"
+#endif
+
+#define CALIPTRA_EMU_PREFIX "[caliptra] "
+
+#ifdef CONFIG_ASPEED_CALIPTRA_CBINDING
+#define CALIPTRA_RUNTIME_READY_BOOT_STATUS 0x600
+
+typedef struct AspeedCaliptraEmuState {
+    QemuThread thread;
+    VMChangeStateEntry *vmstate;
+    struct caliptra_model *model;
+    Chardev *console;
+    char *rom_path;
+    char *firmware_path;
+    char *error;
+    bool at_start_of_line;
+    bool waiting_for_runtime;
+    bool startup_pause_done;
+} AspeedCaliptraEmuState;
+
+static void caliptra_emu_write(AspeedCaliptraEmuState *s,
+                               const uint8_t *buf, size_t len)
+{
+    g_autofree uint8_t *out = NULL;
+    size_t prefix_len = strlen(CALIPTRA_EMU_PREFIX);
+    size_t extra = 0;
+    size_t i;
+    size_t out_pos = 0;
+
+    if (!s->console || len == 0) {
+        return;
+    }
+
+    for (i = 0; i < len; i++) {
+        if (s->at_start_of_line || (i > 0 && buf[i - 1] == '\n')) {
+            extra += prefix_len;
+        }
+    }
+
+    out = g_malloc(len + extra);
+    for (i = 0; i < len; i++) {
+        if (s->at_start_of_line) {
+            memcpy(out + out_pos, CALIPTRA_EMU_PREFIX, prefix_len);
+            out_pos += prefix_len;
+            s->at_start_of_line = false;
+        }
+
+        out[out_pos++] = buf[i];
+        if (buf[i] == '\n') {
+            s->at_start_of_line = true;
+        }
+    }
+
+    qemu_chr_write_all(s->console, out, out_pos);
+}
+
+static void caliptra_emu_note(AspeedCaliptraEmuState *s, const char *msg)
+{
+    if (!s->at_start_of_line) {
+        static const uint8_t newline = '\n';
+        qemu_chr_write_all(s->console, &newline, 1);
+        s->at_start_of_line = true;
+    }
+    caliptra_emu_write(s, (const uint8_t *)msg, strlen(msg));
+}
+
+static bool caliptra_emu_read_file(const char *path, const char *name,
+                                   gchar **contents, gsize *len, char **error)
+{
+    g_autoptr(GError) err = NULL;
+
+    if (!g_file_get_contents(path, contents, len, &err)) {
+        *error = g_strdup_printf("Failed to read Caliptra %s image '%s': %s",
+                                 name, path, err->message);
+        return false;
+    }
+
+    return true;
+}
+
+static void caliptra_emu_release_vm(AspeedCaliptraEmuState *s,
+                                    const char *reason)
+{
+    if (!s->waiting_for_runtime) {
+        return;
+    }
+
+    s->waiting_for_runtime = false;
+    caliptra_emu_note(s, reason);
+    if (s->startup_pause_done) {
+        vm_start();
+    }
+}
+
+static void caliptra_emu_vm_state_change(void *opaque, bool running,
+                                         RunState state)
+{
+    AspeedCaliptraEmuState *s = opaque;
+
+    if (!running || !s->waiting_for_runtime || s->startup_pause_done) {
+        return;
+    }
+
+    s->startup_pause_done = true;
+    /*
+     * FIXME: RFC ONLY - Using vm_stop_force_state is a hack.
+     * We need advice on the proper way to hold main CPUs in reset
+     * until the Caliptra thread finishes booting.
+     */
+    vm_stop_force_state(RUN_STATE_PAUSED);
+}
+
+static void caliptra_emu_boot_done_bh(void *opaque)
+{
+    AspeedCaliptraEmuState *s = opaque;
+
+    if (s->error) {
+        error_report("%s", s->error);
+        caliptra_emu_release_vm(s,
+                                "runtime boot failed, releasing CA35\n");
+    } else {
+        caliptra_emu_release_vm(s, "runtime ready, releasing CA35\n");
+    }
+
+    qemu_del_vm_change_state_handler(s->vmstate);
+    if (s->model) {
+        caliptra_model_destroy(s->model);
+    }
+    g_free(s->rom_path);
+    g_free(s->firmware_path);
+    g_free(s->error);
+    g_free(s);
+}
+
+static void *caliptra_emu_thread(void *opaque)
+{
+    AspeedCaliptraEmuState *s = opaque;
+    g_autofree gchar *rom = NULL;
+    g_autofree gchar *firmware = NULL;
+    gsize rom_len = 0;
+    gsize firmware_len = 0;
+    static const uint8_t empty;
+    struct caliptra_model_init_params params;
+    int rc;
+
+    if (!caliptra_emu_read_file(s->rom_path, "ROM", &rom, &rom_len,
+                                &s->error) ||
+        !caliptra_emu_read_file(s->firmware_path, "firmware", &firmware,
+                                &firmware_len, &s->error)) {
+        goto out;
+    }
+
+    params = (struct caliptra_model_init_params) {
+        .rom = {
+            .data = (const uint8_t *)rom,
+            .len = rom_len,
+        },
+        .dccm = {
+            .data = &empty,
+            .len = 0,
+        },
+        .iccm = {
+            .data = &empty,
+            .len = 0,
+        },
+        .security_state = CALIPTRA_SEC_STATE_DBG_UNLOCKED_UNPROVISIONED,
+    };
+
+    rc = caliptra_model_init_default(params, &s->model);
+    if (rc != CALIPTRA_MODEL_STATUS_OK) {
+        s->error = g_strdup_printf(
+            "Failed to initialize Caliptra c-binding model: %d", rc);
+        goto out;
+    }
+
+    rc = caliptra_model_boot_default(s->model,
+        (struct caliptra_buffer) {
+            .data = (const uint8_t *)firmware,
+            .len = firmware_len,
+        },
+        CALIPTRA_RUNTIME_READY_BOOT_STATUS);
+    if (rc != CALIPTRA_MODEL_STATUS_OK) {
+        s->error = g_strdup_printf("Failed to boot Caliptra runtime: %d", rc);
+        goto out;
+    }
+
+out:
+    aio_bh_schedule_oneshot(qemu_get_aio_context(), caliptra_emu_boot_done_bh,
+                            s);
+    return NULL;
+}
+
+void aspeed_caliptra_emu_start(Chardev *console, const char *rom_path,
+                               const char *firmware_path)
+{
+    AspeedCaliptraEmuState *s;
+
+    if (!rom_path && !firmware_path) {
+        return;
+    }
+
+    if (!rom_path || !rom_path[0] || !firmware_path || !firmware_path[0]) {
+        error_report("Both caliptra-rom and caliptra-firmware must be set");
+        return;
+    }
+
+    if (!console) {
+        error_report("Caliptra emulator backend is set "
+                     "but serial0 is unavailable");
+        return;
+    }
+
+    s = g_new0(AspeedCaliptraEmuState, 1);
+    s->console = console;
+    s->rom_path = g_strdup(rom_path);
+    s->firmware_path = g_strdup(firmware_path);
+    s->at_start_of_line = true;
+    s->waiting_for_runtime = true;
+
+    s->vmstate = qemu_add_vm_change_state_handler(caliptra_emu_vm_state_change,
+                                                  s);
+    caliptra_emu_note(s, "starting c-binding model thread\n");
+    caliptra_emu_note(s, "waiting for runtime ready before starting CA35\n");
+
+    qemu_thread_create(&s->thread, "caliptra-emu", caliptra_emu_thread, s,
+                       QEMU_THREAD_DETACHED);
+}
+#else
+void aspeed_caliptra_emu_start(Chardev *console, const char *rom_path,
+                               const char *firmware_path)
+{
+    (void)console;
+
+    if (!rom_path && !firmware_path) {
+        return;
+    }
+
+    error_report("Caliptra c-binding backend was not compiled in");
+}
+#endif
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index b187b946f0..e37df51a48 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -1,5 +1,33 @@
 arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
+
+# RFC ONLY: this local-tree probe is for PoC discussion.  A mergeable version
+# needs an explicit configure option and a proper dependency integration.
+caliptra_cbinding_root = meson.project_source_root() / '..' / 'caliptra-sw'
+caliptra_cbinding_inc = caliptra_cbinding_root / 'hw-model/c-binding/out'
+caliptra_cbinding_header = caliptra_cbinding_inc / 'caliptra_model.h'
+caliptra_cbinding_incdir = include_directories(
+  '../../../caliptra-sw/hw-model/c-binding/out')
+caliptra_cbinding_lib = caliptra_cbinding_root / 'target' / 'debug'
+caliptra_cbinding_lib_name = 'libcaliptra_hw_model_c_binding.a'
+caliptra_cbinding_lib = caliptra_cbinding_lib / caliptra_cbinding_lib_name
+caliptra_cbinding_dep = []
+caliptra_cbinding_found = fs.exists(caliptra_cbinding_header)
+if caliptra_cbinding_found
+  caliptra_cbinding_found = fs.exists(caliptra_cbinding_lib)
+endif
+if caliptra_cbinding_found
+  caliptra_cbinding_dep = declare_dependency(
+    compile_args: ['-DCONFIG_ASPEED_CALIPTRA_CBINDING'],
+    include_directories: caliptra_cbinding_incdir,
+    link_args: [
+      caliptra_cbinding_lib,
+      '-lstdc++',
+      '-ldl',
+      '-lrt',
+      '-lm',
+    ])
+endif
 arm_common_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
 arm_common_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
 arm_common_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic_boards.c'))
@@ -72,10 +100,11 @@ arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files(
   'aspeed_ast1700.c',
   'aspeed_ast27x0.c',
   'aspeed_ast27x0_evb.c',
+  'aspeed_caliptra_emu.c',
   'aspeed_ast27x0-fc.c',
   'aspeed_ast27x0-ssp.c',
   'aspeed_ast27x0-tsp.c',
-  'aspeed_coprocessor_common.c'))
+  'aspeed_coprocessor_common.c') + [caliptra_cbinding_dep])
 arm_common_ss.add(when: 'CONFIG_MPS2', if_true: files('mps2.c'))
 arm_common_ss.add(when: 'CONFIG_MPS2', if_true: files('mps2-tz.c'))
 arm_common_ss.add(when: 'CONFIG_MSF2', if_true: files('msf2-soc.c'))
-- 
2.43.0


