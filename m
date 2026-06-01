Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D365CD6E62
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsRl-0007K2-Mv; Sun, 31 May 2026 22:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wTsRj-0007Ja-Fw; Sun, 31 May 2026 22:32:07 -0400
Received: from mail.aspeedtech.com ([211.20.114.72]
 helo=twmbx01.aspeedtech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wTsRh-0004V7-3O; Sun, 31 May 2026 22:32:07 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 1 Jun
 2026 10:31:50 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 1 Jun 2026 10:31:50 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <longzl2@lenovo.com>,
 <yunlin.tang@aspeedtech.com>, <steven_lee@aspeedtech.com>
Subject: [PATCH 2/6] hw/misc: Add ASPEED Caliptra mailbox frontend
Date: Mon, 1 Jun 2026 10:31:43 +0800
Message-ID: <20260601023149.2309299-3-steven_lee@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601023149.2309299-1-steven_lee@aspeedtech.com>
References: <20260601023149.2309299-1-steven_lee@aspeedtech.com>
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

Add a Caliptra mailbox frontend device with SRAM and CSR regions for the AST1040 MCI mailbox window.

Model the mailbox lock, command registers, execute flow and completion path through a pluggable peer interface so backends can service commands synchronously or asynchronously.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
---
 include/hw/misc/aspeed_cptra_mbox.h | 133 ++++++++++
 hw/misc/aspeed_cptra_mbox.c         | 380 ++++++++++++++++++++++++++++
 hw/misc/meson.build                 |   1 +
 hw/misc/trace-events                |   4 +
 4 files changed, 518 insertions(+)
 create mode 100644 include/hw/misc/aspeed_cptra_mbox.h
 create mode 100644 hw/misc/aspeed_cptra_mbox.c

diff --git a/include/hw/misc/aspeed_cptra_mbox.h b/include/hw/misc/aspeed_cptra_mbox.h
new file mode 100644
index 0000000000..470e91597f
--- /dev/null
+++ b/include/hw/misc/aspeed_cptra_mbox.h
@@ -0,0 +1,133 @@
+/*
+ * ASPEED Caliptra mailbox model (Caliptra 2.x subsystem mode)
+ *
+ * Copyright (C) 2026 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_ASPEED_CPTRA_MBOX_H
+#define HW_MISC_ASPEED_CPTRA_MBOX_H
+
+#include "qom/object.h"
+#include "hw/core/sysbus.h"
+
+typedef struct Error Error;
+
+/* SRAM size: 2 MiB (matches MCU_MAILBOX0_SRAM_SIZE in caliptra-mcu-sw) */
+#define CPTRA_MBOX0_SRAM_SIZE    (2u * 1024u * 1024u)
+#define CPTRA_MBOX0_SRAM_WORDS   (CPTRA_MBOX0_SRAM_SIZE / 4)
+
+/* CSR window: 4 KiB (covers all defined registers) */
+#define CPTRA_MBOX0_CSR_SIZE     0x1000u
+
+/* CSR register offsets (relative to CSR BAR) */
+#define CPTRA_MBOX0_LOCK_OFF            0x000
+#define CPTRA_MBOX0_USER_OFF            0x004
+#define CPTRA_MBOX0_TARGET_USER_OFF     0x008
+#define CPTRA_MBOX0_TARGET_USER_VAL_OFF 0x00C
+#define CPTRA_MBOX0_CMD_OFF             0x010
+#define CPTRA_MBOX0_DLEN_OFF            0x014
+#define CPTRA_MBOX0_EXECUTE_OFF         0x018
+#define CPTRA_MBOX0_TARGET_STATUS_OFF   0x01C
+#define CPTRA_MBOX0_CMD_STATUS_OFF      0x020
+#define CPTRA_MBOX0_HW_STATUS_OFF       0x024
+
+/* CMD_STATUS values */
+#define CPTRA_MBOX0_STATUS_BUSY        0
+#define CPTRA_MBOX0_STATUS_DATA_READY  1
+#define CPTRA_MBOX0_STATUS_COMPLETE    2
+#define CPTRA_MBOX0_STATUS_CMD_FAILURE 3
+
+/* SoC agent ID reported in the USER register when the lock is acquired */
+#define CPTRA_MBOX0_SOC_USER_ID    1u
+
+/*
+ * Caliptra mailbox interface (frontend), implemented as a QOM interface so
+ * that backends can deliver an asynchronous response without depending on the
+ * concrete frontend device type.
+ */
+#define TYPE_CPTRA_MBOX_IF "cptra-mbox-if"
+typedef struct CptraMboxIfClass CptraMboxIfClass;
+DECLARE_CLASS_CHECKERS(CptraMboxIfClass, CPTRA_MBOX_IF, TYPE_CPTRA_MBOX_IF)
+typedef struct CptraMboxIf CptraMboxIf;
+#define CPTRA_MBOX_IF(obj) \
+    INTERFACE_CHECK(CptraMboxIf, (obj), TYPE_CPTRA_MBOX_IF)
+
+struct CptraMboxIfClass {
+    InterfaceClass parent;
+
+    /*
+     * Called by the peer when a command submitted via handle_execute() has
+     * completed. @status is a CPTRA_MBOX0_STATUS_* value; @data/@len carry the
+     * response payload to be written back into the mailbox SRAM (@len bytes,
+     * @dlen is the reported DLEN).
+     */
+    void (*complete)(CptraMboxIf *s, uint32_t status, uint32_t dlen,
+                     const uint8_t *data, uint32_t len);
+};
+
+/*
+ * Caliptra mailbox peer (backend) base class.
+ */
+#define TYPE_CPTRA_MBOX_PEER "cptra-mbox-peer"
+OBJECT_DECLARE_TYPE(CptraMboxPeer, CptraMboxPeerClass, CPTRA_MBOX_PEER)
+
+struct CptraMboxPeer {
+    DeviceState parent;
+
+    /* Set by the frontend when this peer is linked to it. */
+    CptraMboxIf *intf;
+};
+
+struct CptraMboxPeerClass {
+    DeviceClass parent;
+
+    /*
+     * Process a command. @data/@len is a copy of the request payload from the
+     * mailbox SRAM. The peer must eventually report completion by calling the
+     * interface's complete() method (synchronously or asynchronously).
+     */
+    void (*handle_execute)(CptraMboxPeer *p, uint32_t cmd, uint32_t dlen,
+                           const uint8_t *data, uint32_t len);
+
+    /* Optional: notify the peer of a mailbox reset. */
+    void (*handle_reset)(CptraMboxPeer *p);
+};
+
+/* Concrete frontend device type. */
+#define TYPE_ASPEED_CPTRA_MBOX "aspeed-cptra-mbox"
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedCptraMboxState, ASPEED_CPTRA_MBOX)
+
+struct AspeedCptraMboxState {
+    SysBusDevice parent_obj;
+
+    /* Linked backend; NULL means no Caliptra peer is present. */
+    CptraMboxPeer *peer;
+
+    bool locked;
+    bool command_pending;
+    bool release_pending;
+    uint32_t user;
+    uint32_t target_user;
+    uint32_t target_user_valid;
+    uint32_t cmd;
+    uint32_t dlen;
+    uint32_t execute;
+    uint32_t target_status;
+    uint32_t cmd_status;
+    uint32_t hw_status;
+
+    uint32_t sram[CPTRA_MBOX0_SRAM_WORDS];
+
+    MemoryRegion sram_mr;
+    MemoryRegion csr_mr;
+};
+
+bool aspeed_cptra_mbox_set_peer(AspeedCptraMboxState *s, CptraMboxPeer *peer,
+                                Error **errp);
+
+/* Concrete external (chardev) peer type. */
+#define TYPE_CPTRA_MBOX_PEER_EXTERN "cptra-mbox-peer-extern"
+
+#endif /* HW_MISC_ASPEED_CPTRA_MBOX_H */
diff --git a/hw/misc/aspeed_cptra_mbox.c b/hw/misc/aspeed_cptra_mbox.c
new file mode 100644
index 0000000000..8c1faf69df
--- /dev/null
+++ b/hw/misc/aspeed_cptra_mbox.c
@@ -0,0 +1,380 @@
+/*
+ * ASPEED Caliptra mailbox host interface (frontend) and peer base class.
+ *
+ * Copyright (C) 2026 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/aspeed_cptra_mbox.h"
+#include "hw/core/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/log.h"
+#include "system/memory.h"
+#include "trace.h"
+
+static size_t cptra_mbox_padded_len(uint32_t dlen)
+{
+    return (size_t)((dlen + 3) / 4) * 4;
+}
+
+static void cptra_mbox_clear(AspeedCptraMboxState *s)
+{
+    s->locked = false;
+    s->release_pending = false;
+    s->user = 0;
+    s->target_user = 0;
+    s->target_user_valid = 0;
+    s->cmd = 0;
+    s->dlen = 0;
+    s->execute = 0;
+    s->target_status = 0;
+    s->cmd_status = 0;
+    s->hw_status = 0;
+    memset(s->sram, 0, sizeof(s->sram));
+}
+
+static void cptra_mbox_submit(AspeedCptraMboxState *s)
+{
+    CptraMboxPeerClass *pc;
+    g_autofree uint8_t *data = NULL;
+    size_t len;
+
+    if (s->dlen > CPTRA_MBOX0_SRAM_SIZE) {
+        s->cmd_status = CPTRA_MBOX0_STATUS_CMD_FAILURE;
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: DLEN 0x%x exceeds SRAM size\n", __func__, s->dlen);
+        return;
+    }
+
+    if (!s->peer) {
+        /* No Caliptra peer present: the command cannot be serviced. */
+        s->cmd_status = CPTRA_MBOX0_STATUS_CMD_FAILURE;
+        return;
+    }
+
+    len = cptra_mbox_padded_len(s->dlen);
+    if (len) {
+        data = g_malloc(len);
+        for (size_t i = 0; i < len / 4; i++) {
+            stl_le_p(data + i * 4, s->sram[i]);
+        }
+    }
+
+    s->command_pending = true;
+    s->release_pending = false;
+    trace_cptra_mbox_execute(s->cmd, s->dlen);
+
+    pc = CPTRA_MBOX_PEER_GET_CLASS(s->peer);
+    pc->handle_execute(s->peer, s->cmd, s->dlen, data, len);
+}
+
+/* CptraMboxIf::complete - called by the peer when a command finishes. */
+static void cptra_mbox_complete(CptraMboxIf *iface, uint32_t status,
+                                uint32_t dlen, const uint8_t *data,
+                                uint32_t len)
+{
+    AspeedCptraMboxState *s = ASPEED_CPTRA_MBOX(iface);
+
+    s->command_pending = false;
+    trace_cptra_mbox_complete(status, dlen);
+
+    if (s->release_pending) {
+        cptra_mbox_clear(s);
+        return;
+    }
+
+    /*
+     * Report the peer's status verbatim and write back whatever response
+     * payload it returned. The peer signals a transport/command failure with
+     * CPTRA_MBOX0_STATUS_CMD_FAILURE and no data.
+     */
+    s->cmd_status = status;
+    s->dlen = dlen;
+    if (data && len) {
+        size_t words = MIN(len, CPTRA_MBOX0_SRAM_SIZE) / 4;
+
+        for (size_t i = 0; i < words; i++) {
+            s->sram[i] = ldl_le_p(data + i * 4);
+        }
+    }
+}
+
+static uint64_t cptra_mbox_sram_read(void *opaque, hwaddr offset, unsigned size)
+{
+    AspeedCptraMboxState *s = opaque;
+    uint32_t idx = offset / 4;
+
+    if (idx >= CPTRA_MBOX0_SRAM_WORDS) {
+        return 0;
+    }
+    return s->sram[idx];
+}
+
+static void cptra_mbox_sram_write(void *opaque, hwaddr offset,
+                                  uint64_t value, unsigned size)
+{
+    AspeedCptraMboxState *s = opaque;
+    uint32_t idx = offset / 4;
+
+    if (idx < CPTRA_MBOX0_SRAM_WORDS) {
+        s->sram[idx] = (uint32_t)value;
+    }
+}
+
+static const MemoryRegionOps cptra_mbox_sram_ops = {
+    .read = cptra_mbox_sram_read,
+    .write = cptra_mbox_sram_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+};
+
+static uint64_t cptra_mbox_csr_read(void *opaque, hwaddr offset, unsigned size)
+{
+    AspeedCptraMboxState *s = opaque;
+
+    switch (offset) {
+    case CPTRA_MBOX0_LOCK_OFF:
+        if (!s->locked) {
+            s->locked = true;
+            s->user = CPTRA_MBOX0_SOC_USER_ID;
+            return 0;
+        }
+        return 1;
+    case CPTRA_MBOX0_USER_OFF:
+        return s->user;
+    case CPTRA_MBOX0_TARGET_USER_OFF:
+        return s->target_user;
+    case CPTRA_MBOX0_TARGET_USER_VAL_OFF:
+        return s->target_user_valid;
+    case CPTRA_MBOX0_CMD_OFF:
+        return s->cmd;
+    case CPTRA_MBOX0_DLEN_OFF:
+        return s->dlen;
+    case CPTRA_MBOX0_EXECUTE_OFF:
+        return s->execute;
+    case CPTRA_MBOX0_TARGET_STATUS_OFF:
+        return s->target_status;
+    case CPTRA_MBOX0_CMD_STATUS_OFF:
+        return s->cmd_status;
+    case CPTRA_MBOX0_HW_STATUS_OFF:
+        return s->hw_status;
+    default:
+        return 0;
+    }
+}
+
+static void cptra_mbox_csr_write(void *opaque, hwaddr offset,
+                                 uint64_t value, unsigned size)
+{
+    AspeedCptraMboxState *s = opaque;
+    uint32_t val = (uint32_t)value;
+
+    switch (offset) {
+    case CPTRA_MBOX0_LOCK_OFF:
+    case CPTRA_MBOX0_USER_OFF:
+    case CPTRA_MBOX0_HW_STATUS_OFF:
+        break;
+    case CPTRA_MBOX0_TARGET_USER_OFF:
+        s->target_user = val;
+        break;
+    case CPTRA_MBOX0_TARGET_USER_VAL_OFF:
+        s->target_user_valid = val;
+        break;
+    case CPTRA_MBOX0_CMD_OFF:
+        s->cmd = val;
+        break;
+    case CPTRA_MBOX0_DLEN_OFF:
+        if (val > CPTRA_MBOX0_SRAM_SIZE) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: DLEN 0x%x exceeds SRAM size, clamped\n",
+                          __func__, val);
+            val = CPTRA_MBOX0_SRAM_SIZE;
+        }
+        s->dlen = val;
+        break;
+    case CPTRA_MBOX0_EXECUTE_OFF:
+        if (val == 1 && s->execute != 1 && !s->command_pending) {
+            s->execute = 1;
+            s->cmd_status = CPTRA_MBOX0_STATUS_BUSY;
+            cptra_mbox_submit(s);
+        } else if (val == 0 && s->execute != 0) {
+            if (s->command_pending) {
+                s->release_pending = true;
+            } else {
+                cptra_mbox_clear(s);
+            }
+        }
+        break;
+    case CPTRA_MBOX0_TARGET_STATUS_OFF:
+        s->target_status = val;
+        break;
+    case CPTRA_MBOX0_CMD_STATUS_OFF:
+        s->cmd_status = val;
+        break;
+    default:
+        break;
+    }
+}
+
+static const MemoryRegionOps cptra_mbox_csr_ops = {
+    .read = cptra_mbox_csr_read,
+    .write = cptra_mbox_csr_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+};
+
+static void cptra_mbox_reset_hold(Object *obj, ResetType type)
+{
+    AspeedCptraMboxState *s = ASPEED_CPTRA_MBOX(obj);
+
+    if (s->command_pending) {
+        /* Defer the clear until the in-flight command completes. */
+        s->release_pending = true;
+        return;
+    }
+    cptra_mbox_clear(s);
+
+    if (s->peer) {
+        CptraMboxPeerClass *pc = CPTRA_MBOX_PEER_GET_CLASS(s->peer);
+        if (pc->handle_reset) {
+            pc->handle_reset(s->peer);
+        }
+    }
+}
+
+static void cptra_mbox_peer_check(const Object *obj, const char *name,
+                                  Object *val, Error **errp)
+{
+    CptraMboxPeer *peer;
+
+    if (!val) {
+        return;
+    }
+
+    peer = CPTRA_MBOX_PEER(val);
+    if (peer->intf) {
+        error_setg(errp, "Caliptra mailbox peer is already in use");
+    }
+}
+
+bool aspeed_cptra_mbox_set_peer(AspeedCptraMboxState *s, CptraMboxPeer *peer,
+                                Error **errp)
+{
+    CptraMboxPeer *old_peer = s->peer;
+
+    if (old_peer == peer) {
+        if (s->peer) {
+            s->peer->intf = CPTRA_MBOX_IF(s);
+        }
+        return true;
+    }
+    if (!object_property_set_link(OBJECT(s), "peer",
+                                  peer ? OBJECT(peer) : NULL, errp)) {
+        return false;
+    }
+    if (old_peer) {
+        old_peer->intf = NULL;
+    }
+    if (s->peer) {
+        s->peer->intf = CPTRA_MBOX_IF(s);
+    }
+    return true;
+}
+
+static void cptra_mbox_init(Object *obj)
+{
+    AspeedCptraMboxState *s = ASPEED_CPTRA_MBOX(obj);
+
+    object_property_add_link(obj, "peer", TYPE_CPTRA_MBOX_PEER,
+                             (Object **)&s->peer, cptra_mbox_peer_check,
+                             OBJ_PROP_LINK_STRONG);
+}
+
+static void cptra_mbox_realize(DeviceState *dev, Error **errp)
+{
+    AspeedCptraMboxState *s = ASPEED_CPTRA_MBOX(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    if (s->peer) {
+        if (!aspeed_cptra_mbox_set_peer(s, s->peer, errp)) {
+            return;
+        }
+    }
+
+    memory_region_init_io(&s->sram_mr, OBJECT(s), &cptra_mbox_sram_ops, s,
+                          "cptra-mbox.sram", CPTRA_MBOX0_SRAM_SIZE);
+    sysbus_init_mmio(sbd, &s->sram_mr);
+
+    memory_region_init_io(&s->csr_mr, OBJECT(s), &cptra_mbox_csr_ops, s,
+                          "cptra-mbox.csr", CPTRA_MBOX0_CSR_SIZE);
+    sysbus_init_mmio(sbd, &s->csr_mr);
+}
+
+static const VMStateDescription vmstate_cptra_mbox = {
+    .name = TYPE_ASPEED_CPTRA_MBOX,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BOOL(locked, AspeedCptraMboxState),
+        VMSTATE_UINT32(user, AspeedCptraMboxState),
+        VMSTATE_UINT32(target_user, AspeedCptraMboxState),
+        VMSTATE_UINT32(target_user_valid, AspeedCptraMboxState),
+        VMSTATE_UINT32(cmd, AspeedCptraMboxState),
+        VMSTATE_UINT32(dlen, AspeedCptraMboxState),
+        VMSTATE_UINT32(execute, AspeedCptraMboxState),
+        VMSTATE_UINT32(target_status, AspeedCptraMboxState),
+        VMSTATE_UINT32(cmd_status, AspeedCptraMboxState),
+        VMSTATE_UINT32(hw_status, AspeedCptraMboxState),
+        VMSTATE_UINT32_ARRAY(sram, AspeedCptraMboxState,
+                             CPTRA_MBOX0_SRAM_WORDS),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void cptra_mbox_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
+    CptraMboxIfClass *ic = CPTRA_MBOX_IF_CLASS(oc);
+
+    dc->desc = "Caliptra mailbox host interface";
+    dc->realize = cptra_mbox_realize;
+    dc->vmsd = &vmstate_cptra_mbox;
+    rc->phases.hold = cptra_mbox_reset_hold;
+    ic->complete = cptra_mbox_complete;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static const TypeInfo cptra_mbox_types[] = {
+    {
+        .name          = TYPE_CPTRA_MBOX_IF,
+        .parent        = TYPE_INTERFACE,
+        .class_size    = sizeof(CptraMboxIfClass),
+    },
+    {
+        .name          = TYPE_CPTRA_MBOX_PEER,
+        .parent        = TYPE_DEVICE,
+        .instance_size = sizeof(CptraMboxPeer),
+        .class_size    = sizeof(CptraMboxPeerClass),
+        .abstract      = true,
+    },
+    {
+        .name          = TYPE_ASPEED_CPTRA_MBOX,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(AspeedCptraMboxState),
+        .instance_init = cptra_mbox_init,
+        .class_init    = cptra_mbox_class_init,
+        .interfaces    = (const InterfaceInfo[]) {
+            { TYPE_CPTRA_MBOX_IF },
+            { }
+        },
+    },
+};
+
+DEFINE_TYPES(cptra_mbox_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index fa6a961ac9..d23045c4b5 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -135,6 +135,7 @@ system_ss.add(when: 'CONFIG_PVPANIC_PCI', if_true: files('pvpanic-pci.c'))
 system_ss.add(when: 'CONFIG_PVPANIC_MMIO', if_true: files('pvpanic-mmio.c'))
 system_ss.add(when: 'CONFIG_AUX', if_true: files('auxbus.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
+  'aspeed_cptra_mbox.c',
   'aspeed_hace.c',
   'aspeed_lpc.c',
   'aspeed_ltpi.c',
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 82ddbf4d15..9fe2d27fef 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -106,6 +106,10 @@ aspeed_ast2700_scuio_read(uint64_t offset, unsigned size, uint32_t data) "To 0x%
 aspeed_ast1040_scu_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
 aspeed_ast1040_scu_read(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
 
+# aspeed_cptra_mbox.c
+cptra_mbox_execute(uint32_t cmd, uint32_t dlen) "EXECUTE cmd 0x%" PRIx32 " dlen 0x%" PRIx32
+cptra_mbox_complete(uint32_t status, uint32_t dlen) "complete status %u dlen 0x%" PRIx32
+
 # mps2-scc.c
 mps2_scc_read(uint64_t offset, uint64_t data, unsigned size) "MPS2 SCC read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 mps2_scc_write(uint64_t offset, uint64_t data, unsigned size) "MPS2 SCC write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
-- 
2.43.0


