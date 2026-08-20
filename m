Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9E4C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 02:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwsqG-0001xi-Ch; Wed, 19 Aug 2026 22:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwspw-0001rL-2G
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:49:00 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwspt-0000Qm-GX
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:48:59 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6689f36ae56so2769206d50.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 19:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787194136; x=1787798936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nFHiIEmOcu4TOMWGnoK+gf1EPtClTsY0iv6DpQyk0PM=;
 b=j7EwnP3EE9SkQXinnqmxu/JlQFZYtbMWerQ3dFsFd4HTW9ePvPF37zRknJ0V1RQJl4
 HUvhN7g1GF/jMHEdAMgDzHOTtGphhNpofi4Nu5gT+m/RP8Gt/6nO9cLzUUhKoi5bCZVf
 Z2J5db78i3d+RMU2hANy/MBDoXOC/Njz+LI8B5tsBhykQ6Zpqi9x+LXzY6gwiLdELZz0
 W5gLk0ejTi3c7Ar6uOpM5GfSXCzbY9xdAd/8TH8VoNTLiFudXAhn0KyTCBX1QlkkruoM
 zIDc3aXYYSb5eO8/FYIoJSIeeoRETGqFcP6bt6k/+1FnKN9Nj3xqaN2yM0dN8R4Py7FV
 NInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787194136; x=1787798936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nFHiIEmOcu4TOMWGnoK+gf1EPtClTsY0iv6DpQyk0PM=;
 b=PigMbsJmqzbzbH7G+7jDZvwpazgycD/7MCNDov/GM4XnBeastlXXpFvFSaSyoG1EHP
 GB6AzD+2mOqsusU6cW0y9EPjSIzJW0zy1AhF8IkgsKV6D7XI/CTf9SbIDx5bAQ/RH0HR
 yZdM57HDv0Hwaaj5DUwcypr/BSiKDQmRf+gtNkn5YdAhFxaAGMb8DUXcFKbgiIM/j4d7
 mV9q+ECSI/i0Qshr+TDBwJB3smP6lsw7dRmfTPQISpYQdoviSNtRQnUKMMvBtvvWX0om
 YijB0zMbIxvqpmCbI1w5lJQN4sRl3A8ZUzgPHO4ojpt5MYWbjlPs32n3HEMX/nJdaGI0
 diTw==
X-Gm-Message-State: AFuF++lTEy2HfMl/UbKx+LUV8tsHI9NITFqHjF9kT7hwrqljJ4o+5WHC
 9L7a/RgTF2qsr+hBPEvQPVcaj/+yPzrZmVgcQ3+lAIt9mFzogppLuBapivIbIQ==
X-Gm-Gg: AR+sD13P8YKw0kOnSf14MTY0iHh5+cXTvx+fFXyiNCH2G1p3ZBdfywA0pm6xKNKm159
 rKmuzBUVQibtxi/ExdBXrVK8c2cK6PCnKaVWwFBhsWa39RZmXG70mpd0hPup5JuF6H4hKPW0Dby
 5lnGra1YdeMSs7vN/ef+qVJgXON5ZBJNDC4JgRvQHHiFAA/69UGdxcJ1/kCY4ZdGWvZwpu/zCUo
 4PJCWGK38h9N3JY2QS+0O6gHTf1bwgjZlJ6U7q6Ad15ONb0vJXPzIx9JRWdkpeDpiMh6DfpGYki
 AhFG7pI2q7ESd+IydnkG1rKp5CgCWKuAa6ae+XrEe1tIk8YLccnUzFfLXOQOXTtC5RoYIw7l6RU
 xzUhEfATzP1PuKvTsFgPaox/JkTYUeQbWxd7mff3uGMqvq0k8bvtHvMlWLM1/nRT4/jwqYFFkGd
 3AEIDmX2bzdRMnjQd3VZidJmiIRgjiehmFZDeIN2UjJLlo/tNyHU5IfpZEV3QC3UDOwZxRIg0pr
 qMQdFIb4Pn80Sxskfuzh+elOMIZbQzC07bKYB4aSVS5bMmbOb5cBQE40zxAneri
X-Received: by 2002:a53:d048:0:10b0:667:dc6d:736b with SMTP id
 956f58d0204a3-66ccb70e227mr2695592d50.32.1787194136346; 
 Wed, 19 Aug 2026 19:48:56 -0700 (PDT)
Received: from skippy.localdomain (99-61-67-1.lightspeed.austtx.sbcglobal.net.
 [99.61.67.1]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66ccafd03basm1986454d50.1.2026.08.19.19.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 19:48:55 -0700 (PDT)
From: Kyle Fox <kylefoxaustin.github@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kyle Fox <kylefoxaustin.github@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:MCIMX95-19X19-EVK...)
Subject: [PATCH 06/16] hw/i2c: add i.MX LPI2C
Date: Wed, 19 Aug 2026 21:48:24 -0500
Message-Id: <20260820024834.3286721-7-kylefoxaustin.github@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
References: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=kylefoxaustin.github@gmail.com; helo=mail-yx1-xb12b.google.com
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

The i.MX Low-Power I2C master. Models the polled master transfer path
(MCR/MSR, the MTDR command FIFO and the MRDR receive FIFO) that the
System Manager firmware uses to bring up the PMIC and IO expander. No
interrupts are modelled (MIER reads back 0). Slave devices attach on the
QEMU I2C bus.

Signed-off-by: Kyle Fox <kylefoxaustin.github@gmail.com>
---
 hw/i2c/Kconfig      |   4 +
 hw/i2c/imx_lpi2c.c  | 296 ++++++++++++++++++++++++++++++++++++++++++++
 hw/i2c/meson.build  |   1 +
 hw/i2c/trace-events |   4 +
 4 files changed, 305 insertions(+)
 create mode 100644 hw/i2c/imx_lpi2c.c

diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
index 0766130b596..ee31513529f 100644
--- a/hw/i2c/Kconfig
+++ b/hw/i2c/Kconfig
@@ -54,3 +54,7 @@ config PMBUS
 config BCM2835_I2C
     bool
     select I2C
+
+config IMX_LPI2C
+    bool
+    select I2C
diff --git a/hw/i2c/imx_lpi2c.c b/hw/i2c/imx_lpi2c.c
new file mode 100644
index 00000000000..96180c02c8f
--- /dev/null
+++ b/hw/i2c/imx_lpi2c.c
@@ -0,0 +1,296 @@
+/*
+ * NXP i.MX LPI2C master controller
+ *
+ * Copyright (c) 2026, Kyle Fox
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Models the master side of the i.MX LPI2C used by the System Manager
+ * firmware to talk to the board PMIC / IO-expander. Only the polled
+ * blocking-transfer path the SM driver uses is modelled:
+ *
+ *   - MTDR is a command FIFO: the agent writes START (with address),
+ *     TX-data, RX-data (count) and STOP commands.
+ *   - Each command is executed synchronously against the QEMU I2C bus
+ *     (i2c_start_transfer / i2c_send / i2c_recv / i2c_end_transfer).
+ *   - MSR exposes the status flags the driver polls: TDF (tx ready,
+ *     always set since we drain the FIFO immediately), RDF (rx data
+ *     available), SDF (stop detected), NDF (NACK), MBF/BBF (busy).
+ *   - MRDR pops received bytes (RXEMPTY when the rx FIFO is empty).
+ *
+ * No interrupts, DMA, slave mode, clocking or timing are modelled.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/core/sysbus.h"
+#include "hw/i2c/i2c.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+#define TYPE_IMX_LPI2C "imx.lpi2c"
+OBJECT_DECLARE_SIMPLE_TYPE(IMXLPI2CState, IMX_LPI2C)
+
+#define IMX_LPI2C_REG_SIZE      0x10000
+
+/* Register offsets. */
+#define LPI2C_VERID             0x00
+#define LPI2C_PARAM             0x04
+#define LPI2C_MCR               0x10
+#define LPI2C_MSR               0x14
+#define LPI2C_MIER              0x18
+#define LPI2C_MCFGR1            0x24
+#define LPI2C_MFSR              0x5C
+#define LPI2C_MTDR              0x60
+#define LPI2C_MRDR              0x70
+
+/* MCR bits. */
+#define MCR_MEN                 (1u << 0)
+#define MCR_RST                 (1u << 1)
+#define MCR_RTF                 (1u << 8)   /* reset tx FIFO (self-clearing) */
+#define MCR_RRF                 (1u << 9)   /* reset rx FIFO (self-clearing) */
+
+/* MSR bits. */
+#define MSR_TDF                 (1u << 0)
+#define MSR_RDF                 (1u << 1)
+#define MSR_EPF                 (1u << 8)
+#define MSR_SDF                 (1u << 9)
+#define MSR_NDF                 (1u << 10)
+#define MSR_MBF                 (1u << 24)
+#define MSR_BBF                 (1u << 25)
+/* Write-1-to-clear status bits. */
+#define MSR_W1C                 (MSR_EPF | MSR_SDF | MSR_NDF | (0xfu << 11))
+
+/* MTDR command field [10:8]. */
+#define MTDR_CMD_TXDATA         0x0
+#define MTDR_CMD_RXDATA         0x1
+#define MTDR_CMD_STOP           0x2
+#define MTDR_CMD_START          0x4
+
+/* MRDR bits. */
+#define MRDR_RXEMPTY            (1u << 14)
+
+#define RXFIFO_LEN              256
+
+struct IMXLPI2CState {
+    SysBusDevice    parent_obj;
+
+    MemoryRegion    iomem;
+    I2CBus         *bus;
+
+    uint32_t        mcr;
+    uint32_t        msr;       /* sticky status bits (SDF/NDF/MBF/BBF/...) */
+    uint32_t        mcfgr1;
+
+    uint8_t         rxfifo[RXFIFO_LEN];
+    uint32_t        rx_head;
+    uint32_t        rx_count;
+};
+
+static void imx_lpi2c_rx_push(IMXLPI2CState *s, uint8_t b)
+{
+    if (s->rx_count < RXFIFO_LEN) {
+        unsigned tail = (s->rx_head + s->rx_count) % RXFIFO_LEN;
+        s->rxfifo[tail] = b;
+        s->rx_count++;
+    }
+}
+
+static void imx_lpi2c_do_command(IMXLPI2CState *s, uint32_t val)
+{
+    uint32_t cmd = (val >> 8) & 0x7;
+    uint8_t data = val & 0xff;
+
+    switch (cmd) {
+    case MTDR_CMD_START: {
+        /* DATA = (addr << 1) | rw. */
+        uint8_t addr = data >> 1;
+        bool recv = data & 1;
+        trace_imx_lpi2c_start(addr, recv);
+        if (i2c_start_transfer(s->bus, addr, recv) != 0) {
+            s->msr |= MSR_NDF;     /* no slave acked the address */
+        } else {
+            s->msr |= MSR_MBF | MSR_BBF;
+        }
+        break;
+    }
+    case MTDR_CMD_TXDATA:
+        trace_imx_lpi2c_send(data);
+        if (i2c_send(s->bus, data) != 0) {
+            s->msr |= MSR_NDF;
+        }
+        break;
+    case MTDR_CMD_RXDATA: {
+        /* Receive (DATA + 1) bytes. */
+        unsigned n = (unsigned)data + 1;
+        for (unsigned i = 0; i < n; i++) {
+            uint8_t b = i2c_recv(s->bus);
+            trace_imx_lpi2c_recv(b);
+            imx_lpi2c_rx_push(s, b);
+        }
+        break;
+    }
+    case MTDR_CMD_STOP:
+        trace_imx_lpi2c_stop();
+        i2c_end_transfer(s->bus);
+        s->msr |= MSR_SDF | MSR_EPF;
+        s->msr &= ~(MSR_MBF | MSR_BBF);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: unhandled MTDR cmd %u\n", __func__, cmd);
+        break;
+    }
+}
+
+static uint64_t imx_lpi2c_read(void *opaque, hwaddr offset, unsigned size)
+{
+    IMXLPI2CState *s = opaque;
+
+    switch (offset) {
+    case LPI2C_VERID:
+        return 0x01000003;     /* plausible LPI2C version */
+    case LPI2C_PARAM:
+        return 0x00000303;     /* 8-deep tx/rx FIFOs (not load-bearing) */
+    case LPI2C_MCR:
+        return s->mcr;
+    case LPI2C_MSR: {
+        /*
+         * TDF is always ready (we drain the tx command immediately);
+         * RDF reflects the rx FIFO.
+         */
+        uint32_t v = s->msr | MSR_TDF;
+        if (s->rx_count) {
+            v |= MSR_RDF;
+        }
+        return v;
+    }
+    case LPI2C_MIER:
+        return 0;
+    case LPI2C_MCFGR1:
+        return s->mcfgr1;
+    case LPI2C_MFSR:
+        /* rx FIFO count in [22:16]; tx always empty. */
+        return (s->rx_count & 0x7f) << 16;
+    case LPI2C_MRDR:
+        if (s->rx_count == 0) {
+            return MRDR_RXEMPTY;
+        } else {
+            uint8_t b = s->rxfifo[s->rx_head];
+            s->rx_head = (s->rx_head + 1) % RXFIFO_LEN;
+            s->rx_count--;
+            return b;
+        }
+    default:
+        return 0;
+    }
+}
+
+static void imx_lpi2c_write(void *opaque, hwaddr offset,
+                            uint64_t value, unsigned size)
+{
+    IMXLPI2CState *s = opaque;
+
+    switch (offset) {
+    case LPI2C_MCR:
+        if (value & MCR_RRF) {
+            s->rx_head = s->rx_count = 0;
+        }
+        /* RST / RTF / RRF are momentary; don't persist them. */
+        s->mcr = value & ~(MCR_RST | MCR_RTF | MCR_RRF);
+        break;
+    case LPI2C_MSR:
+        /* Write-1-to-clear the status flags. */
+        s->msr &= ~((uint32_t)value & MSR_W1C);
+        break;
+    case LPI2C_MIER:
+    case LPI2C_MCFGR1:
+        if (offset == LPI2C_MCFGR1) {
+            s->mcfgr1 = value;
+        }
+        break;
+    case LPI2C_MTDR:
+        if (s->mcr & MCR_MEN) {
+            imx_lpi2c_do_command(s, value);
+        }
+        break;
+    default:
+        break;
+    }
+}
+
+static const MemoryRegionOps imx_lpi2c_ops = {
+    .read = imx_lpi2c_read,
+    .write = imx_lpi2c_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void imx_lpi2c_reset_hold(Object *obj, ResetType type)
+{
+    IMXLPI2CState *s = IMX_LPI2C(obj);
+
+    s->mcr = 0;
+    s->msr = 0;
+    s->mcfgr1 = 0;
+    s->rx_head = s->rx_count = 0;
+}
+
+static void imx_lpi2c_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    IMXLPI2CState *s = IMX_LPI2C(obj);
+
+    memory_region_init_io(&s->iomem, obj, &imx_lpi2c_ops, s,
+                          TYPE_IMX_LPI2C, IMX_LPI2C_REG_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+    s->bus = i2c_init_bus(DEVICE(obj), "i2c");
+}
+
+static const VMStateDescription vmstate_imx_lpi2c = {
+    .name = TYPE_IMX_LPI2C,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(mcr, IMXLPI2CState),
+        VMSTATE_UINT32(msr, IMXLPI2CState),
+        VMSTATE_UINT32(mcfgr1, IMXLPI2CState),
+        VMSTATE_UINT8_ARRAY(rxfifo, IMXLPI2CState, RXFIFO_LEN),
+        VMSTATE_UINT32(rx_head, IMXLPI2CState),
+        VMSTATE_UINT32(rx_count, IMXLPI2CState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void imx_lpi2c_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->vmsd = &vmstate_imx_lpi2c;
+    rc->phases.hold = imx_lpi2c_reset_hold;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->desc = "NXP i.MX LPI2C master";
+}
+
+static const TypeInfo imx_lpi2c_info = {
+    .name           = TYPE_IMX_LPI2C,
+    .parent         = TYPE_SYS_BUS_DEVICE,
+    .instance_size  = sizeof(IMXLPI2CState),
+    .instance_init  = imx_lpi2c_init,
+    .class_init     = imx_lpi2c_class_init,
+};
+
+static void imx_lpi2c_register_types(void)
+{
+    type_register_static(&imx_lpi2c_info);
+}
+
+type_init(imx_lpi2c_register_types)
diff --git a/hw/i2c/meson.build b/hw/i2c/meson.build
index 88aea35662d..ad6738f820e 100644
--- a/hw/i2c/meson.build
+++ b/hw/i2c/meson.build
@@ -19,4 +19,5 @@ i2c_ss.add(when: 'CONFIG_PPC4XX', if_true: files('ppc4xx_i2c.c'))
 i2c_ss.add(when: 'CONFIG_PCA954X', if_true: files('i2c_mux_pca954x.c'))
 i2c_ss.add(when: 'CONFIG_PMBUS', if_true: files('pmbus_device.c'))
 i2c_ss.add(when: 'CONFIG_BCM2835_I2C', if_true: files('bcm2835_i2c.c'))
+i2c_ss.add(when: 'CONFIG_IMX_LPI2C', if_true: files('imx_lpi2c.c'))
 system_ss.add_all(when: 'CONFIG_I2C', if_true: i2c_ss)
diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
index 1ad0e95c0e6..88078e1c590 100644
--- a/hw/i2c/trace-events
+++ b/hw/i2c/trace-events
@@ -61,3 +61,7 @@ pca954x_read_data(uint8_t value) "PCA954X read data: 0x%02x"
 
 imx_i2c_read(const char *id, const char *reg, uint64_t ofs, uint64_t value) "%s:[%s (0x%" PRIx64 ")] -> 0x%02" PRIx64
 imx_i2c_write(const char *id, const char *reg, uint64_t ofs, uint64_t value) "%s:[%s (0x%" PRIx64 ")] <- 0x%02" PRIx64
+imx_lpi2c_start(uint8_t addr, int recv) "start addr 0x%02x recv %d"
+imx_lpi2c_send(uint8_t data) "tx 0x%02x"
+imx_lpi2c_recv(uint8_t data) "rx 0x%02x"
+imx_lpi2c_stop(void) "stop"
-- 
2.34.1


