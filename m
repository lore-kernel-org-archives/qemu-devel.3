Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1DBC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Vbd-0008JT-26; Tue, 15 Sep 2026 12:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6VbV-0008Cz-1a
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:55 -0400
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6VbT-0003Tu-23
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:52 -0400
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c29703cb796so577315666b.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789488100; x=1790092900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=njMZgtKOcfOkDZU0dZIjVX7Nek8P5EbfO9WaLdMtUVA=;
 b=WD1sk+SKEDkEqZEmnhbpkYcUak0elpfk4GXHGy5vJcPCIMNHl6qLXOe0mi/yV22fmx
 27p40RfkBVfx4KOKIL7THFZFvvRD0UAq92DRiZs7qI6uWfm+yw7L+kavDt2uCoPEwj4m
 w9hfSvXlSW3rnmPPHGYz+f4D3B0p2/ma/rH0Z1SEz3pELdPv8z4blOVlbJ98B1acWz00
 CvbHBDD5XjVVQY/d5ol0umyOh+g3npcXwFytnEfX2rU6Q2hVTT1ob34XWP7duaaMh7fl
 1Mx349uFyenK0B1NzMFydKLwHxoSPXTANaHE1PiafQmzk7afh5Z/4QjPZRXjDxdMCYHB
 8Uug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789488100; x=1790092900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=njMZgtKOcfOkDZU0dZIjVX7Nek8P5EbfO9WaLdMtUVA=;
 b=U3M6pYgVG4ml4qhz9TPcACmEdG294xJ4wPmQCt/s0mOx5eKuoWf6c8kIIn18TzMMWg
 XnRnqlo6qbgO6QAmYycxcRhvEaed0NJ7br1hqAo8AICqotz5XCVHlbylzve/c7OCNXk7
 fyLs2YTTYfpsPOoZYSkVrxuhNcss15yMOPT5NVnqN6YhGOz487DIuOZV5yUKnaONG878
 DbJMC0hiSLL+5ofLb4k/A41YSx3wvEk/RNWysftp9wL7kbFrnKyY8EtsAaMkP91NRXWz
 ThE4vY80u4sOlfUG6SUBsUFRPxq+unGJlGaOKxHtmb5DuLPjgSeXXEZ9hj59IVYBlMUU
 Vj2A==
X-Gm-Message-State: AFuF++n7GS5Bn6v/T+qCqbzwwHmmjJwSFFzDJmji21Fg/3so44fNuFJb
 Jm9RJkoGFhbB+cYlP1XqTTNWMmmhw8RmoLfKZWx6IrD1YkjNsJmSD9resgNsSA==
X-Gm-Gg: AYBFou3A2fLFrUX1tZadRIFAZswvUIZpbeCMddfflr34gG1iU6WzfUg3C31ZMMXYYQf
 oUx0ylP6q6SMni704GmiJGi6i5TAN1e+0KyB+cIEO59wAjx0g99BrxLGUhR8DPc9DJfloRWqpGJ
 nnGSX02eB1e+zd/V4fzQyRXSP/o6ORbIYFcBbFGbC6ofsxtM/LUNWPKcBQNYQLWMghT35dJLA00
 KZLZ1jRNRW0QatJdE1Y1sg2QVt6is+0quNT8rFWs2XjCFNGGgo6K4o6k4iKZYAAz2Y6JK1QLBUf
 uTZxV6FTjLMx+02xCeGA6gGeMKjo7qqINlyljrk/p919Sy0ZwGa4Ay2zXcD0ORLPWnMeDUJtayh
 0+DzurR/jKaMiPez+0eINqN5Z6/4DmlrTKV5j9r5Zym+TGaUA3AuG5yEm0BuP+0ICWKOqt8bPPC
 5wHKDzKGUQJiwwH9M52FNxk2+/r/AbNBvr5fDtvSDCX4bJQwrIBJ/GuL0j/jG/lHVZrFC1gQOCM
 DHQs1VZe8nIX2vvdey1AA1FfWkDNLpo8RGzhYuXWWwyuw==
X-Received: by 2002:a17:907:dab:b0:c26:1648:a065 with SMTP id
 a640c23a62f3a-c29b87267demr527431266b.32.1789488099490; 
 Tue, 15 Sep 2026 09:01:39 -0700 (PDT)
Received: from thinkpad-t470s.. (83-131-196-251.adsl.net.t-com.hr.
 [83.131.196.251]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-c29ddd86344sm3235866b.0.2026.09.15.09.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:01:39 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 peter.maydell@linaro.org, francisco.iglesias@amd.com,
 edgar.iglesias@gmail.com, berrange@redhat.com, eugene@nuvacore.ai,
 Ruslan_Ruslichenko@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v2 16/20] hw/core: Add Remote Port GPIO/Interrupt bridge
Date: Tue, 15 Sep 2026 18:00:40 +0200
Message-ID: <20260915160044.345788-17-ruslichenko.r@gmail.com>
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

This patch adds the `remote-port-gpio` device, which enables
GPIO levels exchange between QEMU and the remote peer.

It maps QEMU's `qemu_irq` lines (GPIOs) to Remote Port `RP_CMD_interrupt`
packets, enabling the synchronization of interrupt lines and logic signals
across the simulation.

This is essential for wiring up interrupt controllers or discrete logic
signals (reset lines, enable pins).

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/remote-port-gpio.c         | 187 +++++++++++++++++++++++++++++
 hw/core/trace-events               |   4 +
 include/hw/core/remote-port-gpio.h |  34 ++++++
 3 files changed, 225 insertions(+)
 create mode 100644 hw/core/remote-port-gpio.c
 create mode 100644 include/hw/core/remote-port-gpio.h

diff --git a/hw/core/remote-port-gpio.c b/hw/core/remote-port-gpio.c
new file mode 100644
index 0000000000..43a40315c5
--- /dev/null
+++ b/hw/core/remote-port-gpio.c
@@ -0,0 +1,187 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2013 Xilinx Inc
+ * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
+ * Written by Peter Crosthwaite <peter.crosthwaite@xilinx.com>
+ *
+ * This code is licensed under the GNU GPL.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/sysbus.h"
+#include "system/system.h"
+#include "system/dma.h"
+#include "qemu/log.h"
+#include "qapi/qmp/qerror.h"
+#include "qapi/error.h"
+#include "migration/vmstate.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/irq.h"
+#include "trace.h"
+
+#include "hw/core/remote-port.h"
+#include "hw/core/remote-port-proto.h"
+#include "hw/core/remote-port-gpio.h"
+
+#define CACHE_INVALID -1
+
+static void rp_gpio_handler(void *opaque, int irq, int level)
+{
+    RemotePortGPIO *s = opaque;
+    struct rp_pkt pkt;
+    size_t len;
+    int64_t clk;
+    uint32_t id = rp_new_id(s->rp);
+    uint32_t flags = s->posted_updates ? RP_PKT_FLAGS_posted : 0;
+
+    /* If we hit the cache, return early.  */
+    if (s->cache[irq] != CACHE_INVALID && s->cache[irq] == level) {
+        return;
+    }
+    /* Update the cache and update the remote peer.  */
+    s->cache[irq] = level;
+
+    clk = rp_normalized_vmclk(s->rp);
+    len = rp_encode_interrupt_f(id, s->rp_dev, &pkt.interrupt, clk,
+                              irq, 0, level, flags);
+
+    trace_remote_port_gpio_tx_interrupt(id, flags, s->rp_dev, 0, irq, level);
+
+    if (s->peer->caps.wire_posted_updates && !s->posted_updates) {
+        rp_rsp_mutex_lock(s->rp);
+    }
+
+    rp_write(s->rp, (void *)&pkt, len);
+
+    /*
+     * If peer supports posted updates it will respect our flag and
+     * not respond.
+     */
+    if (s->peer->caps.wire_posted_updates && !s->posted_updates) {
+        RemotePortRespSlot *rsp_slot;
+        struct rp_pkt_interrupt *intr;
+
+        rsp_slot = rp_dev_wait_resp(s->rp, s->rp_dev, id);
+        assert(rsp_slot->rsp.pkt->hdr.id == id);
+
+        intr = &rsp_slot->rsp.pkt->interrupt;
+        trace_remote_port_gpio_rx_interrupt(intr->hdr.id, intr->hdr.flags,
+            intr->hdr.dev, intr->vector, intr->line, intr->val);
+
+        rp_resp_slot_done(s->rp, rsp_slot);
+        rp_rsp_mutex_unlock(s->rp);
+    }
+}
+
+static void rp_gpio_interrupt(RemotePortDevice *rpdev, struct rp_pkt *pkt)
+{
+    RemotePortGPIO *s = REMOTE_PORT_GPIO(rpdev);
+
+    trace_remote_port_gpio_rx_interrupt(pkt->hdr.id, pkt->hdr.flags,
+        pkt->hdr.dev, pkt->interrupt.vector, pkt->interrupt.line,
+        pkt->interrupt.val);
+
+    qemu_set_irq(s->gpio_out[pkt->interrupt.line], pkt->interrupt.val);
+
+    if (s->peer->caps.wire_posted_updates
+        && !(pkt->hdr.flags & RP_PKT_FLAGS_posted)) {
+        RemotePortDynPkt rsp = {0};
+        size_t len;
+
+        /* Need to reply.  */
+        rp_dpkt_alloc(&rsp, sizeof(struct rp_pkt_interrupt));
+        len = rp_encode_interrupt_f(pkt->hdr.id, pkt->hdr.dev,
+                                    &rsp.pkt->interrupt,
+                                    pkt->interrupt.timestamp,
+                                    pkt->interrupt.line,
+                                    pkt->interrupt.vector,
+                                    pkt->interrupt.val,
+                                    pkt->hdr.flags | RP_PKT_FLAGS_response);
+
+        trace_remote_port_gpio_tx_interrupt(pkt->hdr.id,
+            pkt->hdr.flags | RP_PKT_FLAGS_response, pkt->hdr.dev,
+            pkt->interrupt.vector, pkt->interrupt.line, pkt->interrupt.val);
+
+        rp_write(s->rp, (void *)rsp.pkt, len);
+    }
+}
+
+static void rp_gpio_reset(DeviceState *dev)
+{
+    RemotePortGPIO *s = REMOTE_PORT_GPIO(dev);
+
+    /* Mark as invalid.  */
+    memset(s->cache, CACHE_INVALID, s->num_gpios);
+}
+
+static void rp_gpio_realize(DeviceState *dev, Error **errp)
+{
+    RemotePortGPIO *s = REMOTE_PORT_GPIO(dev);
+    RemotePortDevice *rpd = REMOTE_PORT_DEVICE(dev);
+    unsigned int i;
+
+    rp_register_dev(s->rp, rpd, s->rp_dev);
+
+    s->peer = rp_get_peer(s->rp);
+
+    s->gpio_out = g_new0(qemu_irq, s->num_gpios);
+    qdev_init_gpio_out(dev, s->gpio_out, s->num_gpios);
+    qdev_init_gpio_in(dev, rp_gpio_handler, s->num_gpios);
+
+    for (i = 0; i < s->num_gpios; i++) {
+        sysbus_init_irq(SYS_BUS_DEVICE(s), &s->gpio_out[i]);
+    }
+}
+
+static void rp_prop_allow_set_link(const Object *obj, const char *name,
+                                   Object *val, Error **errp)
+{
+}
+
+static void rp_gpio_init(Object *obj)
+{
+    RemotePortGPIO *rpms = REMOTE_PORT_GPIO(obj);
+
+    object_property_add_link(obj, "rp-adaptor0", "remote-port",
+                             (Object **)&rpms->rp,
+                             rp_prop_allow_set_link,
+                             OBJ_PROP_LINK_STRONG);
+}
+
+static Property rp_properties[] = {
+    DEFINE_PROP_UINT32("rp-chan0", RemotePortGPIO, rp_dev, 0),
+    DEFINE_PROP_UINT32("num-gpios", RemotePortGPIO, num_gpios, 16),
+    DEFINE_PROP_UINT16("cell-offset-irq-num", RemotePortGPIO,
+                       cell_offset_irq_num, 0),
+    DEFINE_PROP_BOOL("posted-updates", RemotePortGPIO, posted_updates, true),
+};
+
+static void rp_gpio_class_init(ObjectClass *oc, const void *data)
+{
+    RemotePortDeviceClass *rpdc = REMOTE_PORT_DEVICE_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    rpdc->ops[RP_CMD_interrupt] = rp_gpio_interrupt;
+    dc->legacy_reset = rp_gpio_reset;
+    dc->realize = rp_gpio_realize;
+    device_class_set_props_n(dc, rp_properties, ARRAY_SIZE(rp_properties));
+}
+
+static const TypeInfo rp_info = {
+    .name          = TYPE_REMOTE_PORT_GPIO,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RemotePortGPIO),
+    .instance_init = rp_gpio_init,
+    .class_init    = rp_gpio_class_init,
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
index 475c8439ba..cbf8de6da3 100644
--- a/hw/core/trace-events
+++ b/hw/core/trace-events
@@ -46,3 +46,7 @@ remote_port_memory_master_rx_busaccess(const char *cmd, uint32_t id, uint32_t fl
 # remote-port-memory-slave.c
 remote_port_memory_slave_tx_busaccess(const char *cmd, uint32_t id, uint32_t flags, uint32_t dev, uint64_t addr, uint32_t len, uint64_t attr) "cmd=%s, id=0x%"PRIx32", flags=0x%"PRIx32", dev=0x%"PRIx32", addr=0x%"PRIx64", len=0x%"PRIx32", attr=0x%"PRIx64
 remote_port_memory_slave_rx_busaccess(const char *cmd, uint32_t id, uint32_t flags, uint32_t dev, uint64_t addr, uint32_t len, uint64_t attr) "cmd=%s, id=0x%"PRIx32", flags=0x%"PRIx32", dev=0x%"PRIx32", addr=0x%"PRIx64", len=0x%"PRIx32", attr=0x%"PRIx64
+
+# remote-port-memory-gpio.c
+remote_port_gpio_tx_interrupt(uint32_t id, uint32_t flags, uint32_t dev, uint64_t vector, uint32_t irq, uint32_t val) "id=0x%"PRIx32", flags=0x%"PRIx32", dev=0x%"PRIx32", vector=0x%"PRIx64", irq=0x%"PRIx32", level=0x%"PRIx32
+remote_port_gpio_rx_interrupt(uint32_t id, uint32_t flags, uint32_t dev, uint64_t vector, uint32_t irq, uint32_t val) "id=0x%"PRIx32", flags=0x%"PRIx32", dev=0x%"PRIx32", vector=0x%"PRIx64", irq=0x%"PRIx32", level=0x%"PRIx32
diff --git a/include/hw/core/remote-port-gpio.h b/include/hw/core/remote-port-gpio.h
new file mode 100644
index 0000000000..0079ebfc73
--- /dev/null
+++ b/include/hw/core/remote-port-gpio.h
@@ -0,0 +1,34 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2013 Xilinx Inc
+ * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
+ * Written by Peter Crosthwaite <peter.crosthwaite@xilinx.com>
+ *
+ * This code is licensed under the GNU GPL.
+ */
+#ifndef REMOTE_PORT_GPIO_H
+#define REMOTE_PORT_GPIO_H
+
+#define TYPE_REMOTE_PORT_GPIO "remote-port-gpio"
+#define REMOTE_PORT_GPIO(obj) \
+        OBJECT_CHECK(RemotePortGPIO, (obj), TYPE_REMOTE_PORT_GPIO)
+
+#define MAX_GPIOS 960
+
+typedef struct RemotePortGPIO {
+    /* private */
+    SysBusDevice parent;
+    /* public */
+
+    int8_t cache[MAX_GPIOS];
+    uint32_t num_gpios;
+    qemu_irq *gpio_out;
+    uint16_t cell_offset_irq_num;
+
+    bool posted_updates;
+    uint32_t rp_dev;
+    struct RemotePort *rp;
+    struct rp_peer_state *peer;
+} RemotePortGPIO;
+#endif
-- 
2.43.0


