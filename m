Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756EC606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 17:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL26U-0004cY-S2; Sun, 25 Oct 2026 13:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL24c-0001h9-6x; Sun, 25 Oct 2026 13:32:01 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL24Z-0007Ls-4t; Sun, 25 Oct 2026 13:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=uqFwFmgzdz790pM+M7VRARjuKVI6qQzPpJoPyoyD720=; b=JYkWLQVVZNBk2w/0o6K5DUIL5Z
 vHA5u/9VPx0Si38+FshJj62acZGoJLw4Q7CuZVB4aH/24G0D+GvOA+l8G/LxQI7NgIDC+FG9pq3ar
 cv1iBwPPudNKkEhq9pBevrZxTZlD9lVqdRPFKc4G9JRXxWojpzxniy4AxCxCt/V7kLhRDNc/qPRy6
 ptVtBFjaYH0gOwol5Dm3th5OVR62HXF+eDa5BfEX1nksi6vii7KFL8GIxNr3T1UXzv21TzCs3WrD4
 y/6mnSGWfF+QA3k579CEpKMYMHO8GqCYuGFIHV91K6FZ3XneGrPDSekGDbhJaIqkodehBd8Kk4hdO
 jBU8wa3g==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1xL1gP-00097w-37; Sun, 25 Oct 2026 18:06:57 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vw-000OzG-2j; Sun, 25 Oct 2026 17:56:08 +0100
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Date: Sun, 25 Oct 2026 17:55:40 +0100
Subject: [PATCH v2 24/31] hw/ssi: add Renesas RX RSPI
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261025-umar-rx-series-v2-24-9e846577cad0@sayyadumar.com>
References: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
In-Reply-To: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947366; l=14253;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=7N2OK7Dpugy8l7JJdPHVj7xOOC8cQE1s4hngssMJ2+Q=;
 b=IizNYkoNZagPQGa3TfKYu9ylig9Mjgmc+YGCETF4cpcLHQJq+cLZYZLhf/iFyHd8k+raKh/kq
 mez9UPuFNE9AJpl1Tb3v4Qzbkc60CSEcaNsBU00N08O2zV5tVw50N7J
X-Developer-Key: i=contact@sayyadumar.com; a=ed25519;
 pk=CsAjTLRCB7+pnzmj8902JER4gL8CTzNQFxlMZTl4wDk=
X-Virus-Scanned: Clear (ClamAV 1.4.6/28164/Sun Oct 25 07:24:12 2026)
Received-SPF: pass client-ip=85.10.213.182;
 envelope-from=contact@sayyadumar.com; helo=www675.your-server.de
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the RX Serial Peripheral Interface, Section 30 of the RX65N
hardware manual.

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
 MAINTAINERS                            |   2 +
 configs/devices/rx-softmmu/default.mak |   1 +
 hw/ssi/Kconfig                         |   4 +
 hw/ssi/meson.build                     |   1 +
 hw/ssi/renesas_rspi.c                  | 319 +++++++++++++++++++++++++++++++++
 include/hw/ssi/renesas_rspi.h          |  61 +++++++
 6 files changed, 388 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f552c69cc..bd2de8abd5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3087,6 +3087,7 @@ F: hw/dma/renesas_rx_dtc.c
 F: hw/gpio/renesas_rx_gpio.c
 F: hw/intc/rx_icu.c
 F: hw/rx/
+F: hw/ssi/renesas_rspi.c
 F: hw/timer/renesas_mtu3.c
 F: include/hw/adc/renesas_s12ad.h
 F: include/hw/dma/renesas_rx_*.h
@@ -3094,6 +3095,7 @@ F: include/hw/dma/renesas_rx_dtc.h
 F: include/hw/gpio/renesas_rx_gpio.h
 F: include/hw/intc/rx_icu.h
 F: include/hw/rx/
+F: include/hw/ssi/renesas_rspi.h
 F: include/hw/timer/renesas_mtu3.h
 
 CAN bus subsystem and hardware
diff --git a/configs/devices/rx-softmmu/default.mak b/configs/devices/rx-softmmu/default.mak
index 59f124f0d3..269b035b9d 100644
--- a/configs/devices/rx-softmmu/default.mak
+++ b/configs/devices/rx-softmmu/default.mak
@@ -7,3 +7,4 @@ CONFIG_RENESAS_RX_GPIO=y
 CONFIG_RENESAS_RX_DMAC=y
 CONFIG_RENESAS_RX_DTC=y
 CONFIG_RENESAS_S12AD=y
+CONFIG_RENESAS_RSPI=y
diff --git a/hw/ssi/Kconfig b/hw/ssi/Kconfig
index 1bd56463c1..8f400eda82 100644
--- a/hw/ssi/Kconfig
+++ b/hw/ssi/Kconfig
@@ -32,3 +32,7 @@ config PNV_SPI
 config ALLWINNER_A10_SPI
     bool
     select SSI
+
+config RENESAS_RSPI
+    bool
+    select SSI
diff --git a/hw/ssi/meson.build b/hw/ssi/meson.build
index 6afb1ea200..ccb93f7a32 100644
--- a/hw/ssi/meson.build
+++ b/hw/ssi/meson.build
@@ -13,3 +13,4 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_spi.c'))
 system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_spi_host.c'))
 system_ss.add(when: 'CONFIG_BCM2835_SPI', if_true: files('bcm2835_spi.c'))
 system_ss.add(when: 'CONFIG_PNV_SPI', if_true: files('pnv_spi.c'))
+system_ss.add(when: 'CONFIG_RENESAS_RSPI', if_true: files('renesas_rspi.c'))
diff --git a/hw/ssi/renesas_rspi.c b/hw/ssi/renesas_rspi.c
new file mode 100644
index 0000000000..ad5d8ca278
--- /dev/null
+++ b/hw/ssi/renesas_rspi.c
@@ -0,0 +1,319 @@
+/*
+ * Renesas RX65N Serial Peripheral Interface (RSPI)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), Section 30
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/core/irq.h"
+#include "hw/core/registerfields.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/ssi/renesas_rspi.h"
+#include "migration/vmstate.h"
+
+/*
+ * Register offsets from device base.
+ * Reference: RX65N Group Hardware Manual Table 30.1
+ */
+REG8(SPCR,   0x00)
+  FIELD(SPCR, SPMS,   0, 1)   /* SPI mode: 0=4-wire, 1=3-wire */
+  FIELD(SPCR, TXONLY, 1, 1)   /* transmit-only mode */
+  FIELD(SPCR, MODFEN, 2, 1)   /* mode fault detect enable */
+  FIELD(SPCR, MSTR,   3, 1)   /* master/slave: 1=master */
+  FIELD(SPCR, SPEIE,  4, 1)   /* error interrupt enable */
+  FIELD(SPCR, SPTIE,  5, 1)   /* transmit interrupt enable */
+  FIELD(SPCR, SPE,    6, 1)   /* SPI function enable */
+  FIELD(SPCR, SPRIE,  7, 1)   /* receive interrupt enable */
+
+REG8(SSLP,   0x01)   /* SSL polarity */
+REG8(SPPCR,  0x02)   /* pin control */
+
+REG8(SPSR,   0x03)
+  FIELD(SPSR, OVRF,   0, 1)   /* overrun flag */
+  FIELD(SPSR, IDLNF,  1, 1)   /* idle flag */
+  FIELD(SPSR, MODF,   2, 1)   /* mode fault flag */
+  FIELD(SPSR, PERF,   3, 1)   /* parity error flag */
+  FIELD(SPSR, UDRF,   4, 1)   /* underrun flag */
+  FIELD(SPSR, SPTEF,  5, 1)   /* transmit buffer empty */
+  FIELD(SPSR, SPRFF,  6, 1)   /* receive FIFO full (not implemented here) */
+  FIELD(SPSR, SPRF,   7, 1)   /* receive buffer full */
+
+REG32(SPDR,  0x04)   /* data register (also 16-bit and 8-bit access) */
+REG8(SPSCR,  0x08)   /* sequence control */
+REG8(SPSSR,  0x09)   /* sequence status */
+REG8(SPBR,   0x0A)   /* bit rate */
+REG8(SPDCR,  0x0B)
+  FIELD(SPDCR, SPFC,  0, 2)   /* frames per access */
+  FIELD(SPDCR, SPRDTD, 4, 1)   /* receive/transmit data select */
+  FIELD(SPDCR, SPLW,  5, 1)   /* access width (1=long word) */
+  FIELD(SPDCR, SPBYT, 6, 1)   /* byte access */
+
+REG8(SPCKD,  0x0C)   /* clock delay */
+REG8(SSLND,  0x0D)   /* SSL negate delay */
+REG8(SPND,   0x0E)   /* next-access delay */
+REG8(SPCR2,  0x0F)   /* control 2 */
+/* SPCMD0–SPCMD7 at offsets 0x10–0x1E (16-bit each) */
+#define A_SPCMD_BASE 0x10
+#define A_SPCMD_END  0x1E
+REG8(SPDCR2, 0x20)   /* data control 2 */
+
+static void rspi_do_transfer(RX65NRSPIState *s)
+{
+    uint32_t rx;
+
+    /* Only transfer in master mode with SPI enabled */
+    if (!FIELD_EX8(s->spcr, SPCR, MSTR) ||
+        !FIELD_EX8(s->spcr, SPCR, SPE)) {
+        return;
+    }
+
+    rx = ssi_transfer(s->ssi, s->spdr);
+    s->spdr = rx;
+
+    /* Mark receive buffer full, transmit buffer empty */
+    s->spsr = FIELD_DP8(s->spsr, SPSR, SPRF,  1);
+    s->spsr = FIELD_DP8(s->spsr, SPSR, SPTEF, 1);
+
+    /* Fire receive interrupt */
+    if (FIELD_EX8(s->spcr, SPCR, SPRIE)) {
+        qemu_irq_pulse(s->irq[RSPI_IRQ_SPRI]);
+    }
+}
+
+static uint64_t rspi_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RX65NRSPIState *s = opaque;
+    uint64_t ret;
+
+    if (addr >= A_SPCMD_BASE && addr <= A_SPCMD_END) {
+        int idx = (addr - A_SPCMD_BASE) / 2;
+        return s->spcmd[idx];
+    }
+
+    switch (addr) {
+    case A_SPCR:
+        return s->spcr;
+    case A_SSLP:
+        return s->sslp;
+    case A_SPPCR:
+        return s->sppcr;
+    case A_SPSR:
+        ret = s->spsr;
+        /* Reading SPSR clears SPRF and OVRF */
+        s->spsr = FIELD_DP8(s->spsr, SPSR, SPRF, 0);
+        s->spsr = FIELD_DP8(s->spsr, SPSR, OVRF, 0);
+        return ret;
+    case A_SPDR:
+        s->spsr = FIELD_DP8(s->spsr, SPSR, SPRF, 0);
+        /* Raise transmit interrupt now that the buffer is free again */
+        if (FIELD_EX8(s->spcr, SPCR, SPTIE)) {
+            qemu_irq_pulse(s->irq[RSPI_IRQ_SPTI]);
+        }
+        return s->spdr;
+    case A_SPSCR:
+        return s->spscr;
+    case A_SPSSR:
+        return s->spssr;
+    case A_SPBR:
+        return s->spbr;
+    case A_SPDCR:
+        return s->spdcr;
+    case A_SPCKD:
+        return s->spckd;
+    case A_SSLND:
+        return s->sslnd;
+    case A_SPND:
+        return s->spnd;
+    case A_SPCR2:
+        return s->spcr2;
+    case A_SPDCR2:
+        return s->spdcr2;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "renesas_rspi: read 0x%" HWADDR_PRIX " not implemented\n",
+                      addr);
+        return UINT64_MAX;
+    }
+}
+
+static void rspi_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    RX65NRSPIState *s = opaque;
+
+    if (addr >= A_SPCMD_BASE && addr <= A_SPCMD_END) {
+        int idx = (addr - A_SPCMD_BASE) / 2;
+        s->spcmd[idx] = val;
+        return;
+    }
+
+    switch (addr) {
+    case A_SPCR:
+        s->spcr = val;
+        /* Raise SPTI when SPE+SPTIE are both set (buffer initially empty) */
+        if (FIELD_EX8(s->spcr, SPCR, SPE) &&
+            FIELD_EX8(s->spcr, SPCR, SPTIE) &&
+            FIELD_EX8(s->spsr, SPSR, SPTEF)) {
+            qemu_irq_pulse(s->irq[RSPI_IRQ_SPTI]);
+        }
+        break;
+    case A_SSLP:
+        s->sslp   = val;
+        break;
+    case A_SPPCR:
+        s->sppcr  = val;
+        break;
+    case A_SPSR:
+        /* W0C for error/status bits */
+        s->spsr &= val | 0xe0;  /* keep SPTEF, SPRFF, SPRF read-only */
+        break;
+    case A_SPDR:
+        s->spdr = val;
+        s->spsr = FIELD_DP8(s->spsr, SPSR, SPTEF, 0);
+        rspi_do_transfer(s);
+        break;
+    case A_SPSCR:
+        s->spscr  = val;
+        break;
+    case A_SPBR:
+        s->spbr   = val;
+        break;
+    case A_SPDCR:
+        s->spdcr  = val;
+        break;
+    case A_SPCKD:
+        s->spckd  = val;
+        break;
+    case A_SSLND:
+        s->sslnd  = val;
+        break;
+    case A_SPND:
+        s->spnd   = val;
+        break;
+    case A_SPCR2:
+        s->spcr2  = val;
+        break;
+    case A_SPDCR2:
+        s->spdcr2 = val;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas_rspi: write 0x%" HWADDR_PRIX
+                      " not implemented\n",
+                      addr);
+        break;
+    }
+}
+
+static const MemoryRegionOps rspi_ops = {
+    .read  = rspi_read,
+    .write = rspi_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static void rspi_reset(DeviceState *dev)
+{
+    RX65NRSPIState *s = RENESAS_RSPI(dev);
+    int i;
+
+    s->spcr   = 0x00;
+    s->sslp   = 0x00;
+    s->sppcr  = 0x00;
+    s->spsr   = 0x20;  /* SPTEF=1: transmit buffer initially empty */
+    s->spdr   = 0x00000000;
+    s->spscr  = 0x00;
+    s->spssr  = 0x00;
+    s->spbr   = 0xff;
+    s->spdcr  = 0x20;  /* SPLW=1: long-word access default */
+    s->spckd  = 0x00;
+    s->sslnd  = 0x00;
+    s->spnd   = 0x00;
+    s->spcr2  = 0x00;
+    s->spdcr2 = 0x00;
+    for (i = 0; i < 8; i++) {
+        s->spcmd[i] = 0x0700; /* default: 8-bit, CPOL=0, CPHA=0 */
+    }
+}
+
+static void rspi_init(Object *obj)
+{
+    SysBusDevice *d = SYS_BUS_DEVICE(obj);
+    RX65NRSPIState *s = RENESAS_RSPI(obj);
+    int i;
+
+    /* 0x24 bytes covers SPCR through SPDCR2 */
+    memory_region_init_io(&s->memory, obj, &rspi_ops, s,
+                          "renesas-rspi", 0x24);
+    sysbus_init_mmio(d, &s->memory);
+
+    for (i = 0; i < RSPI_NR_IRQ; i++) {
+        sysbus_init_irq(d, &s->irq[i]);
+    }
+
+    s->ssi = ssi_create_bus(DEVICE(obj), "ssi");
+}
+
+static const VMStateDescription vmstate_rspi = {
+    .name = "renesas-rspi",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8(spcr,   RX65NRSPIState),
+        VMSTATE_UINT8(sslp,   RX65NRSPIState),
+        VMSTATE_UINT8(sppcr,  RX65NRSPIState),
+        VMSTATE_UINT8(spsr,   RX65NRSPIState),
+        VMSTATE_UINT32(spdr,  RX65NRSPIState),
+        VMSTATE_UINT8(spscr,  RX65NRSPIState),
+        VMSTATE_UINT8(spssr,  RX65NRSPIState),
+        VMSTATE_UINT8(spbr,   RX65NRSPIState),
+        VMSTATE_UINT8(spdcr,  RX65NRSPIState),
+        VMSTATE_UINT8(spckd,  RX65NRSPIState),
+        VMSTATE_UINT8(sslnd,  RX65NRSPIState),
+        VMSTATE_UINT8(spnd,   RX65NRSPIState),
+        VMSTATE_UINT8(spcr2,  RX65NRSPIState),
+        VMSTATE_UINT16_ARRAY(spcmd, RX65NRSPIState, 8),
+        VMSTATE_UINT8(spdcr2, RX65NRSPIState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const Property rspi_properties[] = {
+    DEFINE_PROP_UINT64("input-freq", RX65NRSPIState, input_freq, 0),
+};
+
+static void rspi_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_rspi;
+    device_class_set_legacy_reset(dc, rspi_reset);
+    device_class_set_props(dc, rspi_properties);
+}
+
+static const TypeInfo rspi_info = {
+    .name          = TYPE_RENESAS_RSPI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RX65NRSPIState),
+    .instance_init = rspi_init,
+    .class_init    = rspi_class_init,
+};
+
+static void rspi_register_types(void)
+{
+    type_register_static(&rspi_info);
+}
+
+type_init(rspi_register_types)
diff --git a/include/hw/ssi/renesas_rspi.h b/include/hw/ssi/renesas_rspi.h
new file mode 100644
index 0000000000..b6f5bf8b0b
--- /dev/null
+++ b/include/hw/ssi/renesas_rspi.h
@@ -0,0 +1,61 @@
+/*
+ * Renesas RX65N Serial Peripheral Interface (RSPI)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), Section 30
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_SSI_RENESAS_RSPI_H
+#define HW_SSI_RENESAS_RSPI_H
+
+#include "hw/core/sysbus.h"
+#include "hw/ssi/ssi.h"
+#include "qom/object.h"
+
+#define TYPE_RENESAS_RSPI "renesas-rspi"
+typedef struct RX65NRSPIState RX65NRSPIState;
+DECLARE_INSTANCE_CHECKER(RX65NRSPIState, RENESAS_RSPI, TYPE_RENESAS_RSPI)
+
+enum {
+    RSPI_IRQ_SPEI = 0,  /* error */
+    RSPI_IRQ_SPRI = 1,  /* receive buffer full */
+    RSPI_IRQ_SPTI = 2,  /* transmit buffer empty */
+    RSPI_IRQ_SPII = 3,  /* idle */
+    RSPI_NR_IRQ   = 4,
+};
+
+struct RX65NRSPIState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion memory;
+    uint64_t input_freq;
+    SSIBus *ssi;
+
+    /* Registers */
+    uint8_t  spcr;    /* Control */
+    uint8_t  sslp;    /* SSL polarity */
+    uint8_t  sppcr;   /* Pin control */
+    uint8_t  spsr;    /* Status */
+    /* Data is double-buffered in hardware; this model uses one buffer. */
+    uint32_t spdr;
+    uint8_t  spscr;   /* Sequence control */
+    uint8_t  spssr;   /* Sequence status */
+    uint8_t  spbr;    /* Bit rate */
+    uint8_t  spdcr;   /* Data control */
+    uint8_t  spckd;   /* Clock delay */
+    uint8_t  sslnd;   /* SSL negate delay */
+    uint8_t  spnd;    /* Next-access delay */
+    uint8_t  spcr2;   /* Control 2 */
+    uint16_t spcmd[8]; /* Command registers 0–7 */
+    uint8_t  spdcr2;  /* Data control 2 */
+
+    qemu_irq irq[RSPI_NR_IRQ];
+};
+
+#endif /* HW_SSI_RENESAS_RSPI_H */

-- 
2.53.0


