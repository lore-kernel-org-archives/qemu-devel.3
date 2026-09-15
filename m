Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABC6C88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Vbh-0008Mk-Fq; Tue, 15 Sep 2026 12:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6VbY-0008Gv-DE
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:56 -0400
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6VbU-0003UY-Ng
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:55 -0400
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c264788fd58so553776666b.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789488101; x=1790092901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TozMh1lROKr3/XUiFmSCqeeEpIoOvvzxaVYz8p46u1A=;
 b=f9U5BQhFcnpEuJuX9FytIhHh8SeVLJ2/7fVRk7lIz6cwTyYZgYQLWvlIQTDq3hEeOv
 rVWsYP0TMrw9nn4DTBcZj2nntAYBBdfEGax/PDvSGEbDNk/yR11yv0kfEafbVK9rF/XY
 LdDnPLgVt+WIpSChwgF+XTkamAo0mmCM15lofvC9JmA+Zl4Exfsxo8hWVrl/jnSeBZ/T
 xfONpta+0u/HQW+NhEe+/8dZm/r2WqGO+ls9SBh0vcXVaSG8tLgABhOXTTFXrdLrJw11
 x/WfW1KOrTbG4zQth63bFggvGLwyokB9NdkaV15T8VSgbUs/3XYd7nDGM59exM1VVwis
 BChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789488101; x=1790092901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TozMh1lROKr3/XUiFmSCqeeEpIoOvvzxaVYz8p46u1A=;
 b=y4PJ/GKXzGjFO/5XEqEQtDYB2YGLBikoHQKvhTWz1TUxlbVzSIH7OAEFEbgJWcs6Nq
 c220vozVzCJLqSmkQPoLs1NVc9RuTECrTSDqXEAO79LIg7EKFwFB9s+mntkX6LQHHjVA
 nX2/F93PiLSlmB9TkkhdSHOp2y5P/HulumtcrZ49zCnSWH3vkUMZCSjucW0Hhqx6UGXi
 7iC2JS2DENqEryvQC2EXmRNdxeEV27LTTU2w/B5VbLXdV27sMbWxkWy40lOcpnay81FM
 QzjMgLDjOW+VGxbAa/TXOZVOyG7n/foLJRzujnEUqb4dJS9vC7DdizMXsHkXEg1TXzVY
 0+wA==
X-Gm-Message-State: AFuF++mbrOpKgrg7MXeixKay9fZw0/JXyy2+r9Vva4FRCg3ObSqgZWeN
 XJRanOQpkd/KKLMNxKmroNl/KWIU4Fsxt5N7yIgUU/Fc7YWQiB/pynMSqkfqdA==
X-Gm-Gg: AYBFou3PRD5OxDzNEGY80rLo6HPbqdMdOPLyIvBfJw+HsYK0AHdXpB796NMnxTiNm4S
 CuJpzFGppXeJyEgTFEJnVL+pRTzHbUE5nz2L/RAJ5iFLLCNO7vyyEH4J/LoW+Yln4wxrGK8l9Ju
 j/jHsm9U8izLTj7pMIbirSi5JbdEMzK1k7DUBfukpMlOy8zi3+gA3Ceb2+BcVNjeJ7o//7bmvm5
 1GoRe5RTlyR9l9QkFwkeTW2c8ga/W1U/Ld/i4Nn0BbhxZSJjXXwfFYav1l31Zv9LML6bx1K+8Km
 fdJqbaj3DuAV/7sq70oIYYNog3RLKbFSQI+5kAu6DGvOZF2XmoCcN+cy+/1lzM9WNJ80eKlGC0G
 K4CeiBBCzlqQBjnuWuAl/O6Chxgr4ACQRAR63vkr9r0nl4hOXkO1swmQuSZtAobQn2djgBl8yyv
 5smP1yVwsNdNmVVWqFjVBFNF/f3FVqf1oZSK17gGpqFsXKDJtULOiktZ5ysavJTNT3MGU0wNnJv
 fRc2Ca+zThb47DRpmHmt6wZVNDNbDziyripUqUD8sDzRw==
X-Received: by 2002:a17:907:3e0b:b0:c25:c954:faf2 with SMTP id
 a640c23a62f3a-c29b863b0c4mr562937266b.21.1789488101148; 
 Tue, 15 Sep 2026 09:01:41 -0700 (PDT)
Received: from thinkpad-t470s.. (83-131-196-251.adsl.net.t-com.hr.
 [83.131.196.251]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-c29ddd86344sm3235866b.0.2026.09.15.09.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:01:40 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 peter.maydell@linaro.org, francisco.iglesias@amd.com,
 edgar.iglesias@gmail.com, berrange@redhat.com, eugene@nuvacore.ai,
 Ruslan_Ruslichenko@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v2 17/20] hw/core: Add Remote Port Stream device
Date: Tue, 15 Sep 2026 18:00:41 +0200
Message-ID: <20260915160044.345788-18-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915160044.345788-1-ruslichenko.r@gmail.com>
References: <20260915160044.345788-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:34::10;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Introduce the 'remote-port-stream' device to bridge QEMU StreamSink
interfaces with the Remote Port protocol.

The patch implements the logic to translate local stream push
operations into Remote Port bus-access packets and vice-versa.
This enables bi-directional data streaming between QEMU and
external simulators.

Preserved existing MIT license for hw/core/remote-port-stream.c.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/remote-port-stream.c | 246 +++++++++++++++++++++++++++++++++++
 hw/core/trace-events         |   4 +
 2 files changed, 250 insertions(+)
 create mode 100644 hw/core/remote-port-stream.c

diff --git a/hw/core/remote-port-stream.c b/hw/core/remote-port-stream.c
new file mode 100644
index 0000000000..c2896a55e7
--- /dev/null
+++ b/hw/core/remote-port-stream.c
@@ -0,0 +1,246 @@
+/*
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright (c) 2013 Xilinx Inc
+ * Copyright (c) 2013 Peter Crosthwaite <peter.crosthwaite@xilinx.com>
+ * Copyright (c) 2013 Edgar E. Iglesias <edgar.iglesias@xilinx.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/sysbus.h"
+#include "qemu/log.h"
+
+#include "qemu/bitops.h"
+#include "qapi/qmp/qerror.h"
+#include "hw/core/stream.h"
+#include "qapi/error.h"
+#include "migration/vmstate.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/remote-port.h"
+#include "trace.h"
+
+#define TYPE_REMOTE_PORT_STREAM "remote-port-stream"
+
+#define REMOTE_PORT_STREAM(obj) \
+     OBJECT_CHECK(RemotePortStream, (obj), TYPE_REMOTE_PORT_STREAM)
+
+typedef struct RemotePortStream RemotePortStream;
+
+struct RemotePortStream {
+    DeviceState parent_obj;
+
+    RemotePort *rp;
+    uint32_t rp_dev;
+    uint16_t stream_width;
+
+    StreamSink *tx_dev;
+
+    StreamCanPushNotifyFn notify;
+    void *notify_opaque;
+
+    uint8_t *buf;
+    struct rp_pkt pkt;
+
+    bool rsp_pending;
+    uint32_t current_id;
+};
+
+static void rp_stream_notify(void *opaque)
+{
+    RemotePortStream *s = REMOTE_PORT_STREAM(opaque);
+
+    /* FIXME: This is completely bogus.  */
+    if (s->buf && stream_can_push(s->tx_dev, rp_stream_notify, s)) {
+        RemotePortDynPkt rsp;
+        struct rp_encode_busaccess_in in = {0};
+        size_t pktlen = sizeof(struct rp_pkt_busaccess_ext_base);
+        size_t enclen;
+        int64_t delay = 0; /* FIXME - Implement */
+
+        size_t ret = stream_push(s->tx_dev, s->buf, 4, 0);
+        assert(ret == 4);
+        s->buf = NULL;
+
+        memset(&rsp, 0, sizeof(rsp));
+        rp_dpkt_alloc(&rsp, pktlen);
+        rp_encode_busaccess_in_rsp_init(&in, &s->pkt);
+        in.clk = s->pkt.busaccess.timestamp + delay;
+        enclen = rp_encode_busaccess(rp_get_peer(s->rp),
+                                     &rsp.pkt->busaccess_ext_base,
+                                     &in);
+        assert(enclen <= pktlen);
+        trace_remote_port_stream_tx_busaccess(rp_cmd_to_string(in.cmd),
+            in.id, in.flags, in.dev, in.addr, in.size, in.attr);
+
+        rp_write(s->rp, (void *)rsp.pkt, pktlen);
+    }
+}
+
+static void rp_stream_write(RemotePortDevice *obj, struct rp_pkt *pkt)
+{
+    RemotePortStream *s = REMOTE_PORT_STREAM(obj);
+
+    trace_remote_port_stream_rx_busaccess(rp_cmd_to_string(pkt->hdr.cmd),
+        pkt->hdr.id, pkt->hdr.flags, pkt->hdr.dev, pkt->busaccess.addr,
+        pkt->busaccess.len, pkt->busaccess.attributes);
+
+    assert(pkt->busaccess.width == 0);
+    assert(pkt->busaccess.stream_width == pkt->busaccess.len);
+    assert(pkt->busaccess.addr == 0);
+
+    if (pkt->hdr.flags & RP_PKT_FLAGS_response) {
+        /* FXIME - probably need to do syncs and stuff */
+        assert(s->rsp_pending);
+        s->rsp_pending = false;
+        if (s->notify) {
+            StreamCanPushNotifyFn notify = s->notify;
+            s->notify = NULL;
+            notify(s->notify_opaque);
+        }
+    } else {
+        assert(!s->buf);
+        s->buf = g_memdup2(pkt + 1, 4);
+        s->pkt = *pkt;
+        rp_stream_notify(s);
+    }
+}
+
+static bool rp_stream_stream_can_push(StreamSink *obj,
+                                            StreamCanPushNotifyFn notify,
+                                            void *notify_opaque)
+{
+    RemotePortStream *s = REMOTE_PORT_STREAM(obj);
+
+    if (s->rsp_pending) {
+        s->notify = notify;
+        s->notify_opaque = notify_opaque;
+        return false;
+    }
+    return true;
+}
+
+static size_t rp_stream_stream_push(StreamSink *obj, uint8_t *buf,
+                                    size_t len, bool eop)
+{
+    RemotePortStream *s = REMOTE_PORT_STREAM(obj);
+    RemotePortDynPkt rsp;
+    struct rp_pkt_busaccess_ext_base pkt;
+    struct rp_encode_busaccess_in in = {0};
+    uint64_t rp_attr = eop ? RP_BUS_ATTR_EOP : 0;
+    int64_t clk;
+    int enclen;
+
+    clk = rp_normalized_vmclk(s->rp);
+
+    in.cmd = RP_CMD_write;
+    in.id = rp_new_id(s->rp);
+    in.dev = s->rp_dev;
+    in.clk = clk;
+    in.attr = rp_attr;
+    in.size = len;
+    in.stream_width = s->stream_width;
+    enclen = rp_encode_busaccess(rp_get_peer(s->rp), &pkt, &in);
+
+    trace_remote_port_stream_tx_busaccess(rp_cmd_to_string(in.cmd),
+        in.id, in.flags, in.dev, in.addr, in.size, in.attr);
+
+    rp_rsp_mutex_lock(s->rp);
+    rp_write(s->rp, (void *) &pkt, enclen);
+    rp_write(s->rp, buf, len);
+    rsp = rp_wait_resp(s->rp);
+    assert(rsp.pkt->hdr.id == be32_to_cpu(pkt.hdr.id));
+
+    trace_remote_port_stream_rx_busaccess(
+        rp_cmd_to_string(rsp.pkt->hdr.cmd), rsp.pkt->hdr.id,
+        rsp.pkt->hdr.flags, rsp.pkt->hdr.dev, rsp.pkt->busaccess.addr,
+        rsp.pkt->busaccess.len, rsp.pkt->busaccess.attributes);
+
+    rp_dpkt_invalidate(&rsp);
+    rp_rsp_mutex_unlock(s->rp);
+    rp_restart_sync_timer(s->rp);
+    return len;
+}
+
+static void rp_stream_realize(DeviceState *dev, Error **errp)
+{
+    RemotePortStream *s = REMOTE_PORT_STREAM(dev);
+    RemotePortDevice *rpd = REMOTE_PORT_DEVICE(dev);
+
+    rp_register_dev(s->rp, rpd, s->rp_dev);
+}
+
+static void rp_prop_allow_set_link(const Object *obj, const char *name,
+                                   Object *val, Error **errp)
+{
+}
+
+static void rp_stream_init(Object *obj)
+{
+    RemotePortStream *s = REMOTE_PORT_STREAM(obj);
+
+    object_property_add_link(obj, "axistream-connected", TYPE_STREAM_SINK,
+                             (Object **)&s->tx_dev,
+                             qdev_prop_allow_set_link_before_realize,
+                             OBJ_PROP_LINK_STRONG);
+    object_property_add_link(obj, "rp-adaptor0", "remote-port",
+                             (Object **)&s->rp,
+                             rp_prop_allow_set_link,
+                             OBJ_PROP_LINK_STRONG);
+}
+
+static Property rp_properties[] = {
+    DEFINE_PROP_UINT32("rp-chan0", RemotePortStream, rp_dev, 0),
+    DEFINE_PROP_UINT16("stream-width", RemotePortStream, stream_width, 4),
+};
+
+static void rp_stream_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    StreamSinkClass *ssc = STREAM_SINK_CLASS(oc);
+    RemotePortDeviceClass *rpdc = REMOTE_PORT_DEVICE_CLASS(oc);
+
+    ssc->push = rp_stream_stream_push;
+    ssc->can_push = rp_stream_stream_can_push;
+    device_class_set_props_n(dc, rp_properties, ARRAY_SIZE(rp_properties));
+    rpdc->ops[RP_CMD_write] = rp_stream_write;
+
+    dc->realize = rp_stream_realize;
+}
+
+static const TypeInfo rp_stream_info = {
+    .name          = TYPE_REMOTE_PORT_STREAM,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(RemotePortStream),
+    .class_init    = rp_stream_class_init,
+    .instance_init = rp_stream_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_STREAM_SINK },
+        { TYPE_REMOTE_PORT_DEVICE },
+        { },
+    }
+};
+
+static void rp_stream_register_types(void)
+{
+    type_register_static(&rp_stream_info);
+}
+
+type_init(rp_stream_register_types)
diff --git a/hw/core/trace-events b/hw/core/trace-events
index cbf8de6da3..b5f8fafc60 100644
--- a/hw/core/trace-events
+++ b/hw/core/trace-events
@@ -50,3 +50,7 @@ remote_port_memory_slave_rx_busaccess(const char *cmd, uint32_t id, uint32_t fla
 # remote-port-memory-gpio.c
 remote_port_gpio_tx_interrupt(uint32_t id, uint32_t flags, uint32_t dev, uint64_t vector, uint32_t irq, uint32_t val) "id=0x%"PRIx32", flags=0x%"PRIx32", dev=0x%"PRIx32", vector=0x%"PRIx64", irq=0x%"PRIx32", level=0x%"PRIx32
 remote_port_gpio_rx_interrupt(uint32_t id, uint32_t flags, uint32_t dev, uint64_t vector, uint32_t irq, uint32_t val) "id=0x%"PRIx32", flags=0x%"PRIx32", dev=0x%"PRIx32", vector=0x%"PRIx64", irq=0x%"PRIx32", level=0x%"PRIx32
+
+# remote-port-stream.c
+remote_port_stream_tx_busaccess(const char *cmd, uint32_t id, uint32_t flags, uint32_t dev, uint64_t addr, uint32_t len,  uint64_t attr) "cmd=%s, id=0x%"PRIx32", flags=0x%"PRIx32", dev=0x%"PRIx32", addr=0x%"PRIx64", len=0x%"PRIx32", attr=0x%"PRIx64
+remote_port_stream_rx_busaccess(const char *cmd, uint32_t id, uint32_t flags, uint32_t dev, uint64_t addr, uint32_t len,  uint64_t attr) "cmd=%s, id=0x%"PRIx32", flags=0x%"PRIx32", dev=0x%"PRIx32", addr=0x%"PRIx64", len=0x%"PRIx32", attr=0x%"PRIx64
-- 
2.43.0


