Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99236CD3436
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 03:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK6ke-000402-G5; Mon, 04 May 2026 23:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wK6kb-0003zB-6P; Mon, 04 May 2026 23:47:13 -0400
Received: from mail.aspeedtech.com ([211.20.114.72]
 helo=twmbx01.aspeedtech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wK6kX-00029X-NW; Mon, 04 May 2026 23:47:12 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 5 May
 2026 11:46:55 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 5 May 2026 11:46:55 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:All patches
 CC here" <qemu-devel@nongnu.org>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <longzl2@lenovo.com>,
 <yunlin.tang@aspeedtech.com>, <steven_lee@aspeedtech.com>
Subject: [RFC PATCH v2 1/1] hw/arm: aspeed: PoC integration for Caliptra Root
 of Trust
Date: Tue, 5 May 2026 11:46:54 +0800
Message-ID: <20260505034654.815746-2-steven_lee@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505034654.815746-1-steven_lee@aspeedtech.com>
References: <20260505034654.815746-1-steven_lee@aspeedtech.com>
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

ast27x0 integrates a Caliptra Root of Trust core, but QEMU does not
currently have an agreed model for ASPEED Caliptra emulation.

This patch adds an ASPEED-specific sysbus device that exposes the
Caliptra mailbox/SOC-IFC MMIO window and forwards guest register
accesses to an external `caliptra-server` backend over a Unix socket.
This allows evaluation of the QEMU/Caliptra integration shape without
pulling the upstream `caliptra-sw` hw-model into the QEMU build.

The reference `caliptra-server` implementation used in this RFC is
available at:
  https://github.com/stevenlee7189/caliptra-server

The device provides a 128 KiB MMIO window at 0x14c60000, matching the
ast27x0 bootmcu Caliptra mailbox node, and maps it onto the backend APB
register space.

https://github.com/AspeedTech-BMC/zephyr/blob/v00.03.07/dts/riscv/aspeed/ast27xx.dtsi#L310-L312

On the real ast27x0, Caliptra bring-up and secure-boot
orchestration are handled by bootmcu; CA35 is not involved in that path.
This patch uses the CA35-visible Caliptra MMIO window as an initial
integration point to validate the socket-backed external backend
approach, not to model the final boot architecture.

This is an RFC PoC only. It assumes the backend is already running,
does not implement boot/reset handshaking or migration support, and
uses a minimal wire protocol designed to be replaced with a
standardized IPC scheme.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
---
 MAINTAINERS                          |   2 +
 docs/system/arm/aspeed.rst           |  35 +++
 include/hw/arm/aspeed_caliptra_emu.h |  29 +++
 hw/arm/aspeed_ast27x0-fc.c           |  55 +++++
 hw/arm/aspeed_caliptra_emu.c         | 338 +++++++++++++++++++++++++++
 hw/arm/meson.build                   |   1 +
 6 files changed, 460 insertions(+)
 create mode 100644 include/hw/arm/aspeed_caliptra_emu.h
 create mode 100644 hw/arm/aspeed_caliptra_emu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index afa178c5cc..eb01ab4c11 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1263,6 +1263,8 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/*/*aspeed*
 F: include/hw/*/*aspeed*
+F: hw/arm/aspeed_caliptra_emu.c
+F: include/hw/arm/aspeed_caliptra_emu.h
 F: hw/net/ftgmac100.c
 F: include/hw/net/ftgmac100.h
 F: docs/system/arm/aspeed.rst
diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index d0054a7dbb..e0f511f098 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -423,6 +423,41 @@ Steps to boot the AST2700fc machine:
        -snapshot \
        -S -nographic
 
+The ``ast2700fc`` machine can also forward CA35 accesses to the on-die
+Caliptra Root-of-Trust core to an external Caliptra backend over a Unix
+socket.  The backend (``caliptra-server``) is launched independently with
+the Caliptra ROM and firmware bundle, boots the Caliptra emulated model
+to runtime-ready, then listens on a Unix socket.  QEMU connects to that
+socket from the device's ``realize()`` and forwards every CA35 read/write
+in the Caliptra MMIO window as an APB transaction on the socket.
+
+The socket path is configured with the ``caliptra-socket`` machine
+property.  If the property is not set, no Caliptra backend is attached
+and the Caliptra MMIO window is left unmapped.
+
+For example, to run Caliptra firmware from ``caliptra-sw``:
+
+.. code-block:: bash
+
+  # Terminal 1: start caliptra-server with the ROM/firmware images.
+  # It boots the model to runtime-ready before opening the socket.
+  $ caliptra-server \
+       --socket /tmp/caliptra.sock \
+       --rom    images/caliptra-rom-with-log.bin \
+       --firmware images/caliptra-fw.bundle
+
+  # Terminal 2: launch QEMU; the CA35 starts running immediately.
+  $ qemu-system-aarch64 \
+       -M ast2700fc,caliptra-socket=/tmp/caliptra.sock \
+       ...
+
+There is no boot handshake between QEMU and the backend: by the time the
+device's ``realize()`` runs, ``caliptra-server`` is already at
+runtime-ready, so the CA35 is not held in reset.  The wire protocol
+between QEMU and the backend is APB-level: ``APB_READ`` / ``APB_WRITE``
+requests from QEMU are answered by ``APB_RDATA`` / ``APB_WACK`` from the
+backend.  This protocol is RFC-stage and may change.
+
 After launching QEMU, serial devices will be automatically redirected.
 Example output:
 
diff --git a/include/hw/arm/aspeed_caliptra_emu.h b/include/hw/arm/aspeed_caliptra_emu.h
new file mode 100644
index 0000000000..a4b70bbe18
--- /dev/null
+++ b/include/hw/arm/aspeed_caliptra_emu.h
@@ -0,0 +1,29 @@
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
+#define TYPE_ASPEED_CALIPTRA_EMU "aspeed-caliptra-emu"
+
+/*
+ * RFC/PoC integration hook only.
+ *
+ * This address is used by the current QEMU experiment to attach the
+ * external Caliptra backend to the AST2700fc machine. It must not be
+ * interpreted as the final functional interface used by real hardware:
+ * early Caliptra interaction is bootmcu-owned, and CA35 does not use
+ * this path for functional access to the Caliptra core.
+ *
+ * The 128 KiB region covers:
+ *   +0x00000  mailbox CSR   (caliptra APB 0x30020000)
+ *   +0x10000  SOC IFC       (caliptra APB 0x30030000)
+ */
+#define ASPEED_CALIPTRA_MMIO_BASE 0x14c60000ULL
+
+#endif /* ASPEED_CALIPTRA_EMU_H */
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 5eb6680da9..ac452a5a2a 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -22,6 +22,8 @@
 #include "hw/arm/boot.h"
 #include "hw/block/flash.h"
 #include "hw/arm/aspeed_coprocessor.h"
+#include "hw/arm/aspeed_caliptra_emu.h"
+#include "hw/core/sysbus.h"
 #include "hw/arm/machines-qom.h"
 
 #define TYPE_AST2700FC MACHINE_TYPE_NAME("ast2700fc")
@@ -34,6 +36,8 @@ static struct arm_boot_info ast2700fc_board_info = {
 struct Ast2700FCState {
     MachineState parent_obj;
 
+    char *caliptra_socket;
+
     MemoryRegion ca35_memory;
     MemoryRegion ca35_dram;
     MemoryRegion ca35_boot_rom;
@@ -198,9 +202,51 @@ static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)
 
 static void ast2700fc_init(MachineState *machine)
 {
+    Ast2700FCState *s = AST2700FC(machine);
+
     ast2700fc_ca35_init(machine, &error_abort);
     ast2700fc_ssp_init(machine, &error_abort);
     ast2700fc_tsp_init(machine, &error_abort);
+
+    if (s->caliptra_socket) {
+        SysBusDevice *sbd;
+        DeviceState *dev = qdev_new(TYPE_ASPEED_CALIPTRA_EMU);
+
+        qdev_prop_set_string(dev, "socket-path", s->caliptra_socket);
+        sbd = SYS_BUS_DEVICE(dev);
+        sysbus_realize_and_unref(sbd, &error_abort);
+        /*
+         * Map the Caliptra APB MMIO region into the CA35 address space.
+         * 0x14000000..0x14FFFFFF.
+         */
+        memory_region_add_subregion_overlap(&s->ca35_memory,
+                                            ASPEED_CALIPTRA_MMIO_BASE,
+                                            sysbus_mmio_get_region(sbd, 0),
+                                            1);
+    }
+}
+
+static char *ast2700fc_get_caliptra_socket(Object *obj, Error **errp)
+{
+    Ast2700FCState *s = AST2700FC(obj);
+
+    return g_strdup(s->caliptra_socket ? s->caliptra_socket : "");
+}
+
+static void ast2700fc_set_caliptra_socket(Object *obj, const char *value,
+                                          Error **errp)
+{
+    Ast2700FCState *s = AST2700FC(obj);
+
+    g_free(s->caliptra_socket);
+    s->caliptra_socket = g_strdup(value);
+}
+
+static void ast2700fc_instance_finalize(Object *obj)
+{
+    Ast2700FCState *s = AST2700FC(obj);
+
+    g_free(s->caliptra_socket);
 }
 
 static void ast2700fc_class_init(ObjectClass *oc, const void *data)
@@ -212,6 +258,14 @@ static void ast2700fc_class_init(ObjectClass *oc, const void *data)
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->min_cpus = mc->max_cpus = mc->default_cpus = 6;
+
+    object_class_property_add_str(oc, "caliptra-socket",
+                                  ast2700fc_get_caliptra_socket,
+                                  ast2700fc_set_caliptra_socket);
+    object_class_property_set_description(oc, "caliptra-socket",
+        "Unix socket path for the external Caliptra backend (caliptra-server). "
+        "caliptra-server is launched independently with the ROM/firmware images "
+        "and must be listening before QEMU is started.");
 }
 
 static const TypeInfo ast2700fc_types[] = {
@@ -220,6 +274,7 @@ static const TypeInfo ast2700fc_types[] = {
         .parent         = TYPE_MACHINE,
         .class_init     = ast2700fc_class_init,
         .instance_size  = sizeof(Ast2700FCState),
+        .instance_finalize = ast2700fc_instance_finalize,
         .interfaces     = aarch64_machine_interfaces,
     },
 };
diff --git a/hw/arm/aspeed_caliptra_emu.c b/hw/arm/aspeed_caliptra_emu.c
new file mode 100644
index 0000000000..e91ca6e83d
--- /dev/null
+++ b/hw/arm/aspeed_caliptra_emu.c
@@ -0,0 +1,338 @@
+/*
+ * ASPEED Caliptra external backend (PoC)
+ *
+ * Forwards CA35 MMIO accesses on the Caliptra APB window to an external
+ * caliptra-server process over a Unix socket.  caliptra-server is expected
+ * to be started independently with the Caliptra ROM and firmware bundle
+ * and to be listening on socket-path before QEMU is launched.
+ *
+ * Copyright (C) 2026 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/arm/aspeed_caliptra_emu.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/sysbus.h"
+#include "io/channel.h"
+#include "io/channel-socket.h"
+#include "qapi/error.h"
+#include "qemu/bswap.h"
+#include "qemu/error-report.h"
+#include "qemu/main-loop.h"
+#include "qemu/units.h"
+#include "system/memory.h"
+
+/*
+ * Wire protocol (little-endian).  Symmetric with caliptra-server.
+ *
+ *   Header (12 bytes):
+ *     u32 magic        -- 0x43505452 ("CPTR")
+ *     u16 version      -- 1
+ *     u16 command
+ *     u32 payload_len
+ *
+ *   Commands (after the connection is established):
+ *     APB_READ   QEMU -> server   {u32 apb_addr}
+ *     APB_RDATA  server -> QEMU   {u32 data}
+ *     APB_WRITE  QEMU -> server   {u32 apb_addr, u32 data}
+ *     APB_WACK   server -> QEMU   {} (empty payload)
+ *
+ * There is no boot handshake: caliptra-server boots its emulated model to
+ * runtime-ready before listen()/accept(), and QEMU just connects and starts
+ * forwarding APB traffic.
+ */
+#define CALIPTRA_SOCKET_MAGIC          0x43505452
+#define CALIPTRA_SOCKET_VERSION        1
+#define CALIPTRA_SOCKET_CMD_APB_READ   3
+#define CALIPTRA_SOCKET_CMD_APB_RDATA  4
+#define CALIPTRA_SOCKET_CMD_APB_WRITE  5
+#define CALIPTRA_SOCKET_CMD_APB_WACK   6
+#define CALIPTRA_SOCKET_MAX_PAYLOAD    (4 * MiB)
+
+/*
+ * Base address of the Caliptra APB register space as seen by caliptra-hw-model.
+ * Mailbox CSR starts at 0x30020000; SOC IFC starts at 0x30030000.
+ * Total mapped size: 0x20000 (128 KiB).
+ *
+ * MMIO offset from ASPEED_CALIPTRA_MMIO_BASE in the CA35 address space is
+ * mapped 1:1 to APB address CALIPTRA_APB_BASE + offset.
+ */
+#define CALIPTRA_APB_BASE  0x30020000
+#define CALIPTRA_MMIO_SIZE 0x20000
+
+typedef struct QEMU_PACKED CaliptraSocketHeader {
+    uint32_t magic;
+    uint16_t version;
+    uint16_t command;
+    uint32_t payload_len;
+} CaliptraSocketHeader;
+
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedCaliptraEmuState, ASPEED_CALIPTRA_EMU)
+
+struct AspeedCaliptraEmuState {
+    SysBusDevice parent_obj;
+    char *socket_path;
+    QIOChannelSocket *sioc;
+    QemuMutex ioc_mutex;
+    MemoryRegion mmio;
+};
+
+static bool caliptra_socket_write_msg(QIOChannel *ioc, uint16_t command,
+                                      const uint8_t *payload, size_t len,
+                                      Error **errp)
+{
+    CaliptraSocketHeader hdr = {
+        .magic = cpu_to_le32(CALIPTRA_SOCKET_MAGIC),
+        .version = cpu_to_le16(CALIPTRA_SOCKET_VERSION),
+        .command = cpu_to_le16(command),
+        .payload_len = cpu_to_le32(len),
+    };
+
+    if (qio_channel_write_all(ioc, (const char *)&hdr, sizeof(hdr), errp) < 0) {
+        return false;
+    }
+    if (len &&
+        qio_channel_write_all(ioc, (const char *)payload, len, errp) < 0) {
+        return false;
+    }
+    return true;
+}
+
+static bool caliptra_socket_read_header(QIOChannel *ioc, uint16_t command,
+                                        CaliptraSocketHeader *hdr,
+                                        Error **errp)
+{
+    if (qio_channel_read_all(ioc, (char *)hdr, sizeof(*hdr), errp) < 0) {
+        return false;
+    }
+
+    hdr->magic = le32_to_cpu(hdr->magic);
+    hdr->version = le16_to_cpu(hdr->version);
+    hdr->command = le16_to_cpu(hdr->command);
+    hdr->payload_len = le32_to_cpu(hdr->payload_len);
+
+    if (hdr->magic != CALIPTRA_SOCKET_MAGIC) {
+        error_setg(errp, "Invalid Caliptra socket magic 0x%08x", hdr->magic);
+        return false;
+    }
+    if (hdr->version != CALIPTRA_SOCKET_VERSION) {
+        error_setg(errp, "Unsupported Caliptra socket version %u",
+                   hdr->version);
+        return false;
+    }
+    if (hdr->command != command) {
+        error_setg(errp, "Unexpected Caliptra socket command %u (expected %u)",
+                   hdr->command, command);
+        return false;
+    }
+    if (hdr->payload_len > CALIPTRA_SOCKET_MAX_PAYLOAD) {
+        error_setg(errp, "Caliptra socket response too large: %u bytes",
+                   hdr->payload_len);
+        return false;
+    }
+    return true;
+}
+
+static bool caliptra_apb_send_recv(AspeedCaliptraEmuState *s,
+                                   uint16_t req_cmd, uint16_t rsp_cmd,
+                                   const uint8_t *req_payload, size_t req_len,
+                                   uint8_t *rsp_buf, size_t rsp_len,
+                                   Error **errp)
+{
+    CaliptraSocketHeader hdr;
+    QIOChannel *ioc;
+
+    if (!s->sioc) {
+        error_setg(errp, "Caliptra APB access with no backend connection");
+        return false;
+    }
+    ioc = QIO_CHANNEL(s->sioc);
+
+    if (!caliptra_socket_write_msg(ioc, req_cmd, req_payload, req_len, errp)) {
+        return false;
+    }
+    if (!caliptra_socket_read_header(ioc, rsp_cmd, &hdr, errp)) {
+        return false;
+    }
+
+    if (rsp_len) {
+        if (hdr.payload_len < rsp_len) {
+            error_setg(errp,
+                       "Caliptra short response for cmd %u: got %u, expected %zu",
+                       rsp_cmd, hdr.payload_len, rsp_len);
+            return false;
+        }
+        if (qio_channel_read_all(ioc, (char *)rsp_buf, rsp_len, errp) < 0) {
+            return false;
+        }
+        /* Discard any trailing bytes. */
+        if (hdr.payload_len > rsp_len) {
+            g_autofree uint8_t *extra = g_malloc(hdr.payload_len - rsp_len);
+            if (qio_channel_read_all(ioc, (char *)extra,
+                                     hdr.payload_len - rsp_len, errp) < 0) {
+                return false;
+            }
+        }
+    } else if (hdr.payload_len) {
+        g_autofree uint8_t *extra = g_malloc(hdr.payload_len);
+        if (qio_channel_read_all(ioc, (char *)extra,
+                                 hdr.payload_len, errp) < 0) {
+            return false;
+        }
+    }
+    return true;
+}
+
+static uint64_t caliptra_mmio_read(void *opaque, hwaddr offset, unsigned size)
+{
+    AspeedCaliptraEmuState *s = opaque;
+    uint8_t req[4], rsp[4] = {};
+    Error *err = NULL;
+
+    stl_le_p(req, CALIPTRA_APB_BASE + (uint32_t)offset);
+
+    /*
+     * Release the BQL before blocking on the socket so the QEMU event loop
+     * stays responsive while caliptra-server processes the request.
+     */
+    bql_unlock();
+    qemu_mutex_lock(&s->ioc_mutex);
+    caliptra_apb_send_recv(s,
+                           CALIPTRA_SOCKET_CMD_APB_READ,
+                           CALIPTRA_SOCKET_CMD_APB_RDATA,
+                           req, sizeof(req),
+                           rsp, sizeof(rsp), &err);
+    qemu_mutex_unlock(&s->ioc_mutex);
+    bql_lock();
+
+    if (err) {
+        error_report("caliptra APB read 0x%08" PRIx32 ": %s",
+                     CALIPTRA_APB_BASE + (uint32_t)offset,
+                     error_get_pretty(err));
+        error_free(err);
+        return 0xdeadbeef;
+    }
+    return ldl_le_p(rsp);
+}
+
+static void caliptra_mmio_write(void *opaque, hwaddr offset,
+                                uint64_t value, unsigned size)
+{
+    AspeedCaliptraEmuState *s = opaque;
+    uint8_t req[8];
+    Error *err = NULL;
+
+    stl_le_p(req + 0, CALIPTRA_APB_BASE + (uint32_t)offset);
+    stl_le_p(req + 4, (uint32_t)value);
+
+    bql_unlock();
+    qemu_mutex_lock(&s->ioc_mutex);
+    caliptra_apb_send_recv(s,
+                           CALIPTRA_SOCKET_CMD_APB_WRITE,
+                           CALIPTRA_SOCKET_CMD_APB_WACK,
+                           req, sizeof(req),
+                           NULL, 0, &err);
+    qemu_mutex_unlock(&s->ioc_mutex);
+    bql_lock();
+
+    if (err) {
+        error_report("caliptra APB write 0x%08" PRIx32 " = 0x%08" PRIx32 ": %s",
+                     CALIPTRA_APB_BASE + (uint32_t)offset, (uint32_t)value,
+                     error_get_pretty(err));
+        error_free(err);
+    }
+}
+
+static const MemoryRegionOps caliptra_mmio_ops = {
+    .read  = caliptra_mmio_read,
+    .write = caliptra_mmio_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void aspeed_caliptra_emu_realize(DeviceState *dev, Error **errp)
+{
+    AspeedCaliptraEmuState *s = ASPEED_CALIPTRA_EMU(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    SocketAddress addr;
+    QIOChannelSocket *sioc;
+
+    if (!s->socket_path || !s->socket_path[0]) {
+        error_setg(errp, "caliptra-emu: socket-path must be set");
+        return;
+    }
+
+    memory_region_init_io(&s->mmio, OBJECT(s), &caliptra_mmio_ops, s,
+                          "caliptra-apb", CALIPTRA_MMIO_SIZE);
+    sysbus_init_mmio(sbd, &s->mmio);
+
+    /*
+     * Connect to caliptra-server synchronously.  The server is expected to be
+     * already listening with the Caliptra ROM/firmware booted to runtime-ready.
+     */
+    memset(&addr, 0, sizeof(addr));
+    addr.type = SOCKET_ADDRESS_TYPE_UNIX;
+    addr.u.q_unix.path = s->socket_path;
+
+    sioc = qio_channel_socket_new();
+    if (qio_channel_socket_connect_sync(sioc, &addr, errp) < 0) {
+        object_unref(OBJECT(sioc));
+        return;
+    }
+    if (!qio_channel_set_blocking(QIO_CHANNEL(sioc), true, errp)) {
+        object_unref(OBJECT(sioc));
+        return;
+    }
+    s->sioc = sioc;
+}
+
+static void aspeed_caliptra_emu_instance_init(Object *obj)
+{
+    AspeedCaliptraEmuState *s = ASPEED_CALIPTRA_EMU(obj);
+
+    qemu_mutex_init(&s->ioc_mutex);
+}
+
+static void aspeed_caliptra_emu_finalize(Object *obj)
+{
+    AspeedCaliptraEmuState *s = ASPEED_CALIPTRA_EMU(obj);
+
+    if (s->sioc) {
+        object_unref(OBJECT(s->sioc));
+    }
+    qemu_mutex_destroy(&s->ioc_mutex);
+}
+
+static const Property aspeed_caliptra_emu_props[] = {
+    DEFINE_PROP_STRING("socket-path", AspeedCaliptraEmuState, socket_path),
+};
+
+static void aspeed_caliptra_emu_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = aspeed_caliptra_emu_realize;
+    dc->desc    = "ASPEED Caliptra external backend (PoC)";
+    device_class_set_props(dc, aspeed_caliptra_emu_props);
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static const TypeInfo aspeed_caliptra_emu_type_info = {
+    .name              = TYPE_ASPEED_CALIPTRA_EMU,
+    .parent            = TYPE_SYS_BUS_DEVICE,
+    .instance_size     = sizeof(AspeedCaliptraEmuState),
+    .instance_init     = aspeed_caliptra_emu_instance_init,
+    .instance_finalize = aspeed_caliptra_emu_finalize,
+    .class_init        = aspeed_caliptra_emu_class_init,
+};
+
+static void aspeed_caliptra_emu_register_type(void)
+{
+    type_register_static(&aspeed_caliptra_emu_type_info);
+}
+type_init(aspeed_caliptra_emu_register_type)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 84b8ec5fb5..25e2b58284 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -72,6 +72,7 @@ arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files(
   'aspeed_ast1700.c',
   'aspeed_ast27x0.c',
   'aspeed_ast27x0_evb.c',
+  'aspeed_caliptra_emu.c',
   'aspeed_ast27x0-fc.c',
   'aspeed_ast27x0-ssp.c',
   'aspeed_ast27x0-tsp.c',
-- 
2.43.0


