Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AD6CD6E56
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsRo-0007LE-Fu; Sun, 31 May 2026 22:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wTsRm-0007KY-SS; Sun, 31 May 2026 22:32:10 -0400
Received: from mail.aspeedtech.com ([211.20.114.72]
 helo=twmbx01.aspeedtech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wTsRk-0004V7-Un; Sun, 31 May 2026 22:32:10 -0400
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
Subject: [PATCH 3/6] hw/misc: Add external Caliptra mailbox peer
Date: Mon, 1 Jun 2026 10:31:44 +0800
Message-ID: <20260601023149.2309299-4-steven_lee@aspeedtech.com>
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

Add a cptra-mbox-peer-extern backend that forwards mailbox execute requests to a chardev peer using a small framed protocol.

Run the blocking chardev transaction from the thread pool and report completion back through the mailbox peer interface. Block migration while this external backend is realized because the peer state lives outside QEMU.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
---
 MAINTAINERS                      |   1 +
 hw/misc/cptra_mbox_peer_extern.c | 318 +++++++++++++++++++++++++++++++
 hw/misc/meson.build              |   1 +
 3 files changed, 320 insertions(+)
 create mode 100644 hw/misc/cptra_mbox_peer_extern.c

diff --git a/MAINTAINERS b/MAINTAINERS
index cd5c4831e2..a0e11d4a0e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1270,6 +1270,7 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/*/*aspeed*
 F: include/hw/*/*aspeed*
+F: hw/misc/cptra_mbox_peer_extern.c
 F: hw/net/ftgmac100.c
 F: include/hw/net/ftgmac100.h
 F: docs/system/arm/aspeed.rst
diff --git a/hw/misc/cptra_mbox_peer_extern.c b/hw/misc/cptra_mbox_peer_extern.c
new file mode 100644
index 0000000000..f8d5886880
--- /dev/null
+++ b/hw/misc/cptra_mbox_peer_extern.c
@@ -0,0 +1,318 @@
+/*
+ * Caliptra mailbox external peer (backend).
+ *
+ * Copyright (C) 2026 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "block/thread-pool.h"
+#include "chardev/char-fe.h"
+#include "hw/misc/aspeed_cptra_mbox.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/qdev-properties-system.h"
+#include "migration/blocker.h"
+#include "qapi/error.h"
+#include "qemu/bswap.h"
+#include "qemu/error-report.h"
+
+#define CPTRA_MBOX_PROTO_MAGIC      0x4D424F58u   /* "MBOX" */
+#define CPTRA_MBOX_PROTO_VERSION    1u
+#define CPTRA_MBOX_CMD_EXECUTE      1u
+#define CPTRA_MBOX_CMD_RESPONSE     2u
+#define CPTRA_MBOX_PROTO_MAX_PAYLOAD (8 + CPTRA_MBOX0_SRAM_SIZE)
+
+typedef struct QEMU_PACKED CptraMboxProtoHdr {
+    uint32_t magic;
+    uint16_t version;
+    uint16_t command;
+    uint32_t payload_len;
+} CptraMboxProtoHdr;
+
+OBJECT_DECLARE_SIMPLE_TYPE(CptraMboxPeerExtern, CPTRA_MBOX_PEER_EXTERN)
+
+struct CptraMboxPeerExtern {
+    CptraMboxPeer parent;
+
+    CharFrontend chr;
+    Error *migration_blocker;
+};
+
+typedef struct CptraMboxExternReq {
+    CptraMboxPeerExtern *p;
+
+    uint32_t cmd;
+    uint32_t dlen;
+    uint8_t *req_data;
+    size_t req_len;
+
+    uint32_t rsp_status;
+    uint32_t rsp_dlen;
+    uint8_t *rsp_data;
+    size_t rsp_len;
+
+    char *error;
+} CptraMboxExternReq;
+
+static size_t cptra_padded_len(uint32_t dlen)
+{
+    return (size_t)((dlen + 3) / 4) * 4;
+}
+
+static int G_GNUC_PRINTF(2, 3)
+cptra_req_fail(CptraMboxExternReq *req, const char *fmt, ...)
+{
+    va_list ap;
+
+    va_start(ap, fmt);
+    g_free(req->error);
+    req->error = g_strdup_vprintf(fmt, ap);
+    va_end(ap);
+
+    return -1;
+}
+
+static int cptra_write_all(CptraMboxExternReq *req, const void *buf, size_t len)
+{
+    int ret;
+
+    if (len > INT_MAX) {
+        return cptra_req_fail(req, "write too large: %zu", len);
+    }
+    ret = qemu_chr_fe_write_all(&req->p->chr, buf, len);
+    if (ret < 0 || (size_t)ret != len) {
+        return cptra_req_fail(req, "backend write failed");
+    }
+    return 0;
+}
+
+static int cptra_read_all(CptraMboxExternReq *req, void *buf, size_t len)
+{
+    int ret;
+
+    if (len > INT_MAX) {
+        return cptra_req_fail(req, "read too large: %zu", len);
+    }
+    ret = qemu_chr_fe_read_all(&req->p->chr, buf, len);
+    if (ret < 0 || (size_t)ret != len) {
+        return cptra_req_fail(req, "backend read failed");
+    }
+    return 0;
+}
+
+/*
+ * Wire protocol (magic 0x4D424F58 "MBOX"):
+ *
+ *   Header (12 bytes, little-endian):
+ *     u32 magic       = 0x4D424F58
+ *     u16 version     = 1
+ *     u16 command
+ *     u32 payload_len
+ *
+ *   MBOX_EXECUTE (1)  QEMU -> backend
+ *     payload: u32 cmd, u32 dlen, u8 sram[ROUND_UP(dlen, 4)]
+ *
+ *   MBOX_RESPONSE (2) backend -> QEMU
+ *     payload: u32 status, u32 dlen, u8 sram[ROUND_UP(dlen, 4)]
+ */
+static int cptra_extern_worker(gpointer data)
+{
+    CptraMboxExternReq *req = data;
+    CptraMboxProtoHdr hdr;
+    size_t tx_payload_len = 8 + req->req_len;
+    g_autofree uint8_t *payload = NULL;
+    size_t rsp_data_len;
+
+    if (!qemu_chr_fe_backend_open(&req->p->chr)) {
+        return cptra_req_fail(req, "backend is not connected");
+    }
+
+    payload = g_malloc0(tx_payload_len);
+    stl_le_p(payload, req->cmd);
+    stl_le_p(payload + 4, req->dlen);
+    if (req->req_len) {
+        memcpy(payload + 8, req->req_data, req->req_len);
+    }
+
+    hdr.magic = cpu_to_le32(CPTRA_MBOX_PROTO_MAGIC);
+    hdr.version = cpu_to_le16(CPTRA_MBOX_PROTO_VERSION);
+    hdr.command = cpu_to_le16(CPTRA_MBOX_CMD_EXECUTE);
+    hdr.payload_len = cpu_to_le32(tx_payload_len);
+
+    if (cptra_write_all(req, &hdr, sizeof(hdr)) < 0 ||
+        cptra_write_all(req, payload, tx_payload_len) < 0) {
+        return -1;
+    }
+
+    if (cptra_read_all(req, &hdr, sizeof(hdr)) < 0) {
+        return -1;
+    }
+
+    hdr.magic = le32_to_cpu(hdr.magic);
+    hdr.version = le16_to_cpu(hdr.version);
+    hdr.command = le16_to_cpu(hdr.command);
+    hdr.payload_len = le32_to_cpu(hdr.payload_len);
+
+    if (hdr.magic != CPTRA_MBOX_PROTO_MAGIC) {
+        return cptra_req_fail(req, "bad response magic 0x%08x", hdr.magic);
+    }
+    if (hdr.version != CPTRA_MBOX_PROTO_VERSION) {
+        return cptra_req_fail(req, "bad response version %u", hdr.version);
+    }
+    if (hdr.command != CPTRA_MBOX_CMD_RESPONSE) {
+        return cptra_req_fail(req, "unexpected response command %u",
+                              hdr.command);
+    }
+    if (hdr.payload_len < 8 || hdr.payload_len > CPTRA_MBOX_PROTO_MAX_PAYLOAD) {
+        return cptra_req_fail(req, "invalid response payload length %u",
+                              hdr.payload_len);
+    }
+
+    g_free(payload);
+    payload = g_malloc(hdr.payload_len);
+    if (cptra_read_all(req, payload, hdr.payload_len) < 0) {
+        return -1;
+    }
+
+    req->rsp_status = ldl_le_p(payload);
+    req->rsp_dlen = ldl_le_p(payload + 4);
+    if (req->rsp_dlen > CPTRA_MBOX0_SRAM_SIZE) {
+        return cptra_req_fail(req, "response DLEN 0x%x exceeds SRAM",
+                              req->rsp_dlen);
+    }
+
+    rsp_data_len = cptra_padded_len(req->rsp_dlen);
+    if (8 + rsp_data_len > hdr.payload_len) {
+        return cptra_req_fail(req, "short response payload for DLEN 0x%x",
+                              req->rsp_dlen);
+    }
+
+    if (rsp_data_len) {
+        req->rsp_data = g_malloc0(rsp_data_len);
+        memcpy(req->rsp_data, payload + 8, rsp_data_len);
+        req->rsp_len = rsp_data_len;
+    }
+
+    return 0;
+}
+
+static void cptra_extern_req_free(CptraMboxExternReq *req)
+{
+    g_free(req->req_data);
+    g_free(req->rsp_data);
+    g_free(req->error);
+    g_free(req);
+}
+
+static void cptra_extern_complete(void *opaque, int ret)
+{
+    CptraMboxExternReq *req = opaque;
+    CptraMboxPeerExtern *p = req->p;
+    CptraMboxIf *intf = p->parent.intf;
+    CptraMboxIfClass *ic = intf ? CPTRA_MBOX_IF_GET_CLASS(intf) : NULL;
+
+    if (req->error) {
+        error_report("cptra-mbox-peer-extern: %s", req->error);
+    }
+
+    if (ic) {
+        if (ret == 0) {
+            ic->complete(intf, req->rsp_status, req->rsp_dlen,
+                         req->rsp_data, req->rsp_len);
+        } else {
+            ic->complete(intf, CPTRA_MBOX0_STATUS_CMD_FAILURE, 0, NULL, 0);
+        }
+    }
+
+    cptra_extern_req_free(req);
+    object_unref(OBJECT(p));
+}
+
+static void cptra_extern_handle_execute(CptraMboxPeer *peer, uint32_t cmd,
+                                        uint32_t dlen, const uint8_t *data,
+                                        uint32_t len)
+{
+    CptraMboxPeerExtern *p = CPTRA_MBOX_PEER_EXTERN(peer);
+    CptraMboxIf *intf = peer->intf;
+    CptraMboxExternReq *req;
+
+    if (!qemu_chr_fe_backend_connected(&p->chr) ||
+        !qemu_chr_fe_backend_open(&p->chr)) {
+        if (intf) {
+            CPTRA_MBOX_IF_GET_CLASS(intf)->complete(
+                intf, CPTRA_MBOX0_STATUS_CMD_FAILURE, 0, NULL, 0);
+        }
+        return;
+    }
+
+    req = g_new0(CptraMboxExternReq, 1);
+    req->p = p;
+    req->cmd = cmd;
+    req->dlen = dlen;
+    if (len) {
+        req->req_data = g_memdup2(data, len);
+        req->req_len = len;
+    }
+
+    object_ref(OBJECT(p));
+    thread_pool_submit_aio(cptra_extern_worker, req,
+                           cptra_extern_complete, req);
+}
+
+static void cptra_extern_realize(DeviceState *dev, Error **errp)
+{
+    CptraMboxPeerExtern *p = CPTRA_MBOX_PEER_EXTERN(dev);
+
+    if (!qemu_chr_fe_backend_connected(&p->chr)) {
+        error_setg(errp, "cptra-mbox-peer-extern requires a chardev attribute");
+        return;
+    }
+
+    qemu_chr_fe_set_open(&p->chr, true);
+    error_setg(&p->migration_blocker,
+               "Migration disabled: cptra-mbox-peer-extern chardev backend "
+               "state is external");
+    if (migrate_add_blocker(&p->migration_blocker, errp) < 0) {
+        return;
+    }
+}
+
+static void cptra_extern_finalize(Object *obj)
+{
+    CptraMboxPeerExtern *p = CPTRA_MBOX_PEER_EXTERN(obj);
+
+    migrate_del_blocker(&p->migration_blocker);
+    qemu_chr_fe_deinit(&p->chr, false);
+}
+
+static const Property cptra_extern_props[] = {
+    DEFINE_PROP_CHR("chardev", CptraMboxPeerExtern, chr),
+};
+
+static void cptra_extern_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    CptraMboxPeerClass *pc = CPTRA_MBOX_PEER_CLASS(oc);
+
+    dc->desc = "Caliptra mailbox external (chardev) peer";
+    dc->realize = cptra_extern_realize;
+    dc->hotpluggable = false;
+    device_class_set_props(dc, cptra_extern_props);
+    pc->handle_execute = cptra_extern_handle_execute;
+}
+
+static const TypeInfo cptra_extern_type = {
+    .name              = TYPE_CPTRA_MBOX_PEER_EXTERN,
+    .parent            = TYPE_CPTRA_MBOX_PEER,
+    .instance_size     = sizeof(CptraMboxPeerExtern),
+    .instance_finalize = cptra_extern_finalize,
+    .class_init        = cptra_extern_class_init,
+};
+
+static void cptra_extern_register_types(void)
+{
+    type_register_static(&cptra_extern_type);
+}
+
+type_init(cptra_extern_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index d23045c4b5..9d545e8fb7 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -136,6 +136,7 @@ system_ss.add(when: 'CONFIG_PVPANIC_MMIO', if_true: files('pvpanic-mmio.c'))
 system_ss.add(when: 'CONFIG_AUX', if_true: files('auxbus.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_cptra_mbox.c',
+  'cptra_mbox_peer_extern.c',
   'aspeed_hace.c',
   'aspeed_lpc.c',
   'aspeed_ltpi.c',
-- 
2.43.0


