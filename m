Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770DAECD99C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo5Va-0006tW-Fk; Thu, 05 Feb 2026 14:59:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5VX-0006pd-3D
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:19 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5VS-00038U-F5
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:16 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa9so1111669f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 11:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770321553; x=1770926353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ixQk1sle3klw7RV4vbO5KDu3SkmSly8hO0cVOcN5dSQ=;
 b=RK2B80mY5G5DknpuUDoFdzPDJTFVUqCgT+AAaBaATozHEQm9lzF4rtveQKH5mBAHsY
 waDthAwyGVe38GW+oUHBKhVeLzGbkt51SuuHkJGF8ov2iSnzMR1y8QFFPADlpBIEg/UO
 +uexuNNYfjeIuMtYk6BUICiH7Kk2N5jgPp70JH/lw8m4TKfhiY41HcCnuFeAmgxarOlq
 /XGeJIRg+uzq2gdcSjABb6bYTLdrP/4RiQi28ubds2T6ERmzCzu1OeAY3/nzF2datWVW
 yHIdFDEJ/iDwTp5y6u6ebJ7Gv+kHqrsoOpyTfBQAgsAqAOxeUvEhvBigjGHl4vanuJ5r
 BqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770321553; x=1770926353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ixQk1sle3klw7RV4vbO5KDu3SkmSly8hO0cVOcN5dSQ=;
 b=XguwUjt6MKGCuHgIC9H+8iRvnzb2bViZ3F00fnbZjQm6Cno+DibngXzcsJRjzNF5Bw
 3lxFaZdwT0Fx2cvoaX8CUHZaf0U44jH9jNMPMAYGUVjvkYDtIJHni9UZmlII+oNH0Rm+
 fZvz5SDHoUOmF1SVuCCZM3JEPCrCpO8i+hunBf+7nYzKw7FONt+aqubUf61T9AUpBSX3
 Jsds8mn9SZ6x0JplwejSk7JRhEICVhesw6psMh8H15hkvvSyeiOMqyCn6lYZBNuFGvEK
 /AcwkU6TR9ylwYQPBG363jwkeB1dZxK1RoJQbNGa7i6IPImWZnuPe225D+aYYbt6p8OZ
 5a/Q==
X-Gm-Message-State: AOJu0YwnEQA0YxRORqCAupQskrYZ8uWShHMnXu5sli34xYaLFhrPuiGZ
 naOIjKB+rBx4SElmM265rxinu/ximvKy9UygKgezG6GzAwp4wudGkJPeQrYG0+rl6ok=
X-Gm-Gg: AZuq6aIZwZijbozUBop0RRPu7EBygmxyhvweTQirmqfcDuGVWrL62CxhGyGSi7BW1+O
 SiqDpRgGnzSrlz2+Szi17USUKtLfPspUESkd7pQYpQcpRubUvrA3fuv3am275zywqynwOemJ9Bk
 /UXe6KatguWyNMvFqoJsFRMRRcPB4Z42hFppvyH8hChIdDO30L+xt+5RI+N2RMU0OS8VBz4FSqB
 my27fveBIy3sIWX4uhGU+ZLQg7o/szYf1NNl1UvApdv+TYJzIgT64fAVJ57tnQFc7yF9Pc+TJmI
 rRbtqi56D5rL9IVM13OaZLSwo+XNX0Td+I5Ulozv7eFFeb5Ya6Sm9nE2S/OfCWyAht0FrXbHakM
 oOfU1MooHnUEdy59n1rOi7/yz+SsTtZz3B/6Ks9qtIM5UDhnaDyFGfA5Ix/6qNDJh6PiVhm4zc9
 TCDM8URH0viBUthNnsF1Q=
X-Received: by 2002:a05:6000:402a:b0:430:f742:fbc7 with SMTP id
 ffacd0b85a97d-43629378247mr672697f8f.14.1770321552220; 
 Thu, 05 Feb 2026 11:59:12 -0800 (PST)
Received: from thinkpad-t470s.. ([93.140.16.93])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-436297450b4sm514079f8f.34.2026.02.05.11.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 11:59:11 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 francisco.iglesias@amd.com, Ruslan_Ruslichenko@epam.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH 19/29] hw/core: Add Remote Port memory slave device
Date: Thu,  5 Feb 2026 20:58:14 +0100
Message-ID: <20260205195824.2610192-20-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Introduce the 'remote-port-memory-slave' device to allow remote
peers to initiate memory transactions within QEMU.

The patch implements the logic to receive Remote Port bus access
commands, execute them within the QEMU Address Space, and return
the appropriate response.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/remote-port-memory-slave.c         | 263 +++++++++++++++++++++
 hw/core/trace-events                       |   4 +
 include/hw/core/remote-port-memory-slave.h |  34 +++
 3 files changed, 301 insertions(+)
 create mode 100644 hw/core/remote-port-memory-slave.c
 create mode 100644 include/hw/core/remote-port-memory-slave.h

diff --git a/hw/core/remote-port-memory-slave.c b/hw/core/remote-port-memory-slave.c
new file mode 100644
index 0000000000..bb23325469
--- /dev/null
+++ b/hw/core/remote-port-memory-slave.c
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * QEMU remote port memory slave. Read and write transactions
+ * recieved from the remote port are translated into an address space.
+ *
+ * Copyright (c) 2013 Xilinx Inc
+ * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
+ * Written by Peter Crosthwaite <peter.crosthwaite@xilinx.com>
+ *
+ * This code is licensed under the GNU GPL.
+ */
+
+#include "qemu/osdep.h"
+#include "system/system.h"
+#include "system/dma.h"
+#include "qemu/log.h"
+#include "qapi/qmp/qerror.h"
+#include "qapi/error.h"
+#include "hw/core/sysbus.h"
+#include "migration/vmstate.h"
+#include "hw/core/qdev-properties.h"
+#include "qemu/error-report.h"
+#include "trace.h"
+#include "qemu/cutils.h"
+
+#include "hw/core/remote-port-proto.h"
+#include "hw/core/remote-port-memory-slave.h"
+
+#ifndef REMOTE_PORT_ERR_DEBUG
+#define REMOTE_PORT_DEBUG_LEVEL 0
+#else
+#define REMOTE_PORT_DEBUG_LEVEL 1
+#endif
+
+#define DB_PRINT_L(level, ...) do { \
+    if (REMOTE_PORT_DEBUG_LEVEL > level) { \
+        fprintf(stderr,  ": %s: ", __func__); \
+        fprintf(stderr, ## __VA_ARGS__); \
+    } \
+} while (0)
+
+/* Slow path dealing with odd stuff like byte-enables.  */
+static MemTxResult process_data_slow(RemotePortMemorySlave *s,
+                                     AddressSpace *as,
+                                     struct rp_pkt *pkt,
+                                     DMADirection dir,
+                                     uint8_t *data, uint8_t *byte_en)
+{
+    unsigned int i;
+    unsigned int byte_en_len = pkt->busaccess_ext_base.byte_enable_len;
+    unsigned int sw = pkt->busaccess.stream_width;
+    MemTxResult ret = MEMTX_OK;
+
+    assert(sw);
+
+    for (i = 0; i < pkt->busaccess.len; i++) {
+        if (byte_en && !byte_en[i % byte_en_len]) {
+            continue;
+        }
+
+        ret = dma_memory_rw(as, pkt->busaccess.addr + i % sw,
+                                 data + i, 1, dir, s->attr);
+
+        if (ret != MEMTX_OK) {
+            break;
+        }
+    }
+
+    return ret;
+}
+
+static AddressSpace *get_as_for_phys_busaccess(RemotePortMemorySlave *s,
+                                               struct rp_pkt *pkt)
+{
+    if (s->ats_cache) {
+        IOMMUTLBEntry *iotlb =
+            rp_ats_cache_lookup_translation(s->ats_cache,
+                                            pkt->busaccess.addr,
+                                            pkt->busaccess.len);
+        if (iotlb) {
+            /* Return the matching address space found. */
+            return iotlb->target_as;
+        }
+    }
+    /* Emit a warning on errors since this really should not happen. */
+    warn_report("Physical address error detected (range address: 0x%"
+                HWADDR_PRIx ", len: 0x%" PRIx32 " contains untranslated "
+                "addresses)", pkt->busaccess.addr, pkt->busaccess.len);
+    return NULL;
+}
+
+static void rp_cmd_rw(RemotePortMemorySlave *s, struct rp_pkt *pkt,
+                      DMADirection dir)
+{
+    size_t pktlen = sizeof(struct rp_pkt_busaccess_ext_base);
+    struct rp_encode_busaccess_in in = {0};
+    size_t enclen;
+    int64_t delay;
+    uint8_t *data = NULL;
+    uint8_t *byte_en;
+    MemTxResult ret;
+    AddressSpace *as;
+
+    byte_en = rp_busaccess_byte_en_ptr(s->peer, &pkt->busaccess_ext_base);
+
+    if (dir == DMA_DIRECTION_TO_DEVICE) {
+        pktlen += pkt->busaccess.len;
+    } else {
+        data = rp_busaccess_rx_dataptr(s->peer, &pkt->busaccess_ext_base);
+    }
+
+    assert(pkt->busaccess.width == 0);
+    assert(!(pkt->hdr.flags & RP_PKT_FLAGS_response));
+
+    rp_dpkt_alloc(&s->rsp, pktlen);
+    if (dir == DMA_DIRECTION_TO_DEVICE) {
+        data = rp_busaccess_tx_dataptr(s->peer,
+                                       &s->rsp.pkt->busaccess_ext_base);
+    }
+    if (dir == DMA_DIRECTION_FROM_DEVICE && REMOTE_PORT_DEBUG_LEVEL > 0) {
+        DB_PRINT_L(0, "address: %" PRIx64 "\n", pkt->busaccess.addr);
+        qemu_hexdump(stderr, ": write: ",
+                     (const char *) data, pkt->busaccess.len);
+    }
+    trace_remote_port_memory_slave_rx_busaccess(rp_cmd_to_string(pkt->hdr.cmd),
+        pkt->hdr.id, pkt->hdr.flags, pkt->hdr.dev, pkt->busaccess.addr,
+        pkt->busaccess.len, pkt->busaccess.attributes);
+
+    s->attr.secure = !!(pkt->busaccess.attributes & RP_BUS_ATTR_SECURE);
+    s->attr.requester_id = pkt->busaccess.master_id;
+
+    if (pkt->busaccess.attributes & RP_BUS_ATTR_PHYS_ADDR) {
+        as = get_as_for_phys_busaccess(s, pkt);
+    } else {
+        as = &s->as;
+    }
+    if (as) {
+        if (byte_en || pkt->busaccess.stream_width != pkt->busaccess.len) {
+            ret = process_data_slow(s, as, pkt, dir, data, byte_en);
+        } else {
+            ret = dma_memory_rw(as, pkt->busaccess.addr, data,
+                                 pkt->busaccess.len, dir, s->attr);
+        }
+    } else {
+        ret = MEMTX_ERROR;
+    }
+
+    if (dir == DMA_DIRECTION_TO_DEVICE && REMOTE_PORT_DEBUG_LEVEL > 0) {
+        DB_PRINT_L(0, "address: %" PRIx64 "\n", pkt->busaccess.addr);
+        qemu_hexdump(stderr, ": read: ",
+                     (const char *) data, pkt->busaccess.len);
+    }
+    /*
+     * delay here could be set to the annotated cost of doing issuing
+     * these accesses. QEMU doesn't support this kind of annotations
+     * at the moment. So we just clear the delay.
+     */
+    delay = 0;
+
+    rp_encode_busaccess_in_rsp_init(&in, pkt);
+    in.clk = pkt->busaccess.timestamp + delay;
+
+    switch (ret) {
+    case MEMTX_ERROR:
+        in.attr |= RP_RESP_BUS_GENERIC_ERROR << RP_BUS_RESP_SHIFT;
+        break;
+    case MEMTX_DECODE_ERROR:
+        in.attr |= RP_RESP_ADDR_ERROR << RP_BUS_RESP_SHIFT;
+        break;
+    default:
+        /* MEMTX_OK maps to RP_RESP_OK. */
+        break;
+    }
+
+    enclen = rp_encode_busaccess(s->peer, &s->rsp.pkt->busaccess_ext_base,
+                                 &in);
+    assert(enclen <= pktlen);
+
+    trace_remote_port_memory_slave_tx_busaccess(rp_cmd_to_string(in.cmd),
+        in.id, in.flags, in.dev, in.addr, in.size, in.attr);
+
+    rp_write(s->rp, (void *)s->rsp.pkt, enclen);
+}
+
+static void rp_memory_slave_realize(DeviceState *dev, Error **errp)
+{
+    RemotePortMemorySlave *s = REMOTE_PORT_MEMORY_SLAVE(dev);
+
+    s->peer = rp_get_peer(s->rp);
+    address_space_init(&s->as, s->mr ? s->mr : get_system_memory(), "dma");
+}
+
+static void rp_memory_slave_write(RemotePortDevice *s, struct rp_pkt *pkt)
+{
+    return rp_cmd_rw(REMOTE_PORT_MEMORY_SLAVE(s), pkt,
+                     DMA_DIRECTION_FROM_DEVICE);
+}
+
+static void rp_memory_slave_read(RemotePortDevice *s, struct rp_pkt *pkt)
+{
+    return rp_cmd_rw(REMOTE_PORT_MEMORY_SLAVE(s), pkt,
+                     DMA_DIRECTION_TO_DEVICE);
+}
+
+static void rp_prop_allow_set_link(const Object *obj, const char *name,
+                                   Object *val, Error **errp)
+{
+}
+
+static void rp_memory_slave_init(Object *obj)
+{
+    RemotePortMemorySlave *rpms = REMOTE_PORT_MEMORY_SLAVE(obj);
+
+    object_property_add_link(obj, "rp-adaptor0", "remote-port",
+                             (Object **)&rpms->rp,
+                             rp_prop_allow_set_link,
+                             OBJ_PROP_LINK_STRONG);
+    object_property_add_link(obj, "mr", TYPE_MEMORY_REGION,
+                             (Object **)&rpms->mr,
+                             qdev_prop_allow_set_link_before_realize,
+                             OBJ_PROP_LINK_STRONG);
+    object_property_add_link(obj, "rp-ats-cache", TYPE_REMOTE_PORT_ATS_CACHE,
+                             (Object **)&rpms->ats_cache,
+                             qdev_prop_allow_set_link_before_realize,
+                             OBJ_PROP_LINK_STRONG);
+}
+
+static void rp_memory_slave_unrealize(DeviceState *dev)
+{
+    RemotePortMemorySlave *s = REMOTE_PORT_MEMORY_SLAVE(dev);
+
+    address_space_destroy(&s->as);
+}
+
+static void rp_memory_slave_class_init(ObjectClass *oc, const void *data)
+{
+    RemotePortDeviceClass *rpdc = REMOTE_PORT_DEVICE_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    rpdc->ops[RP_CMD_write] = rp_memory_slave_write;
+    rpdc->ops[RP_CMD_read] = rp_memory_slave_read;
+    dc->realize = rp_memory_slave_realize;
+    dc->unrealize = rp_memory_slave_unrealize;
+}
+
+static const TypeInfo rp_info = {
+    .name          = TYPE_REMOTE_PORT_MEMORY_SLAVE,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(RemotePortMemorySlave),
+    .instance_init = rp_memory_slave_init,
+    .class_init    = rp_memory_slave_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+        { TYPE_REMOTE_PORT_DEVICE },
+        { },
+    },
+};
+
+static void rp_register_types(void)
+{
+    type_register_static(&rp_info);
+}
+
+type_init(rp_register_types)
diff --git a/hw/core/trace-events b/hw/core/trace-events
index 6332002d65..ee77916010 100644
--- a/hw/core/trace-events
+++ b/hw/core/trace-events
@@ -36,3 +36,7 @@ cpu_reset(int cpu_index) "%d"
 # remote-port-memory-master.c
 remote_port_memory_master_tx_busaccess(const char *cmd, uint32_t id, uint32_t flags, uint32_t dev, uint64_t addr, uint32_t len, uint64_t attr) "cmd=%s, id=0x%"PRIx32", flags=0x%"PRIx32", dev=0x%"PRIx32", addr=0x%"PRIx64", len=0x%"PRIx32", attr=0x%"PRIx64
 remote_port_memory_master_rx_busaccess(const char *cmd, uint32_t id, uint32_t flags, uint32_t dev, uint64_t addr, uint32_t len, uint64_t attr) "cmd=%s, id=0x%"PRIx32", flags=0x%"PRIx32", dev=0x%"PRIx32", addr=0x%"PRIx64", len=0x%"PRIx32", attr=0x%"PRIx64
+
+# remote-port-memory-slave.c
+remote_port_memory_slave_tx_busaccess(const char *cmd, uint32_t id, uint32_t flags, uint32_t dev, uint64_t addr, uint32_t len, uint64_t attr) "cmd=%s, id=0x%"PRIx32", flags=0x%"PRIx32", dev=0x%"PRIx32", addr=0x%"PRIx64", len=0x%"PRIx32", attr=0x%"PRIx64
+remote_port_memory_slave_rx_busaccess(const char *cmd, uint32_t id, uint32_t flags, uint32_t dev, uint64_t addr, uint32_t len, uint64_t attr) "cmd=%s, id=0x%"PRIx32", flags=0x%"PRIx32", dev=0x%"PRIx32", addr=0x%"PRIx64", len=0x%"PRIx32", attr=0x%"PRIx64
diff --git a/include/hw/core/remote-port-memory-slave.h b/include/hw/core/remote-port-memory-slave.h
new file mode 100644
index 0000000000..d88e806ed6
--- /dev/null
+++ b/include/hw/core/remote-port-memory-slave.h
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * QEMU remote port memory slave. Read and write transactions
+ * recieved from the remote port are translated into an address space.
+ *
+ * Copyright (c) 2013 Xilinx Inc
+ * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
+ * Written by Peter Crosthwaite <peter.crosthwaite@xilinx.com>
+ *
+ * This code is licensed under the GNU GPL.
+ */
+#ifndef REMOTE_PORT_MEMORY_SLAVE_H
+#define REMOTE_PORT_MEMORY_SLAVE_H
+
+#include "hw/core/remote-port-ats.h"
+
+#define TYPE_REMOTE_PORT_MEMORY_SLAVE "remote-port-memory-slave"
+#define REMOTE_PORT_MEMORY_SLAVE(obj) \
+        OBJECT_CHECK(RemotePortMemorySlave, (obj), \
+                     TYPE_REMOTE_PORT_MEMORY_SLAVE)
+
+typedef struct RemotePortMemorySlave {
+    /* private */
+    SysBusDevice parent;
+    /* public */
+    struct RemotePort *rp;
+    struct rp_peer_state *peer;
+    MemoryRegion *mr;
+    AddressSpace as;
+    MemTxAttrs attr;
+    RemotePortDynPkt rsp;
+    RemotePortATSCache *ats_cache;
+} RemotePortMemorySlave;
+#endif
-- 
2.43.0


