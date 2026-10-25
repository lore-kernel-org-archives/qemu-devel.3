Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B927606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 17:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL26i-0005oM-0X; Sun, 25 Oct 2026 13:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL25P-0002bH-M9; Sun, 25 Oct 2026 13:32:52 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL25L-0007Oj-Su; Sun, 25 Oct 2026 13:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=gF3fDDCXN8rsqRLVN04kF7pF7zJ2peXD0f+Px5hxD7g=; b=RpBTinx1IDy6t4MPLqLr8R+gAv
 zGhnxAgHcGg0Ebk0nPZDtK/icZ3Skt5uvwB67dvQIOQ7AYWIBtD4vNZ95wLzTUiAkBF6yNIvc8ufr
 Xs6QOYoVonHIVLwRLCZzjv8W2f3DtYkEpptNhoM0H99xuBkihcpqcO5tJDr6XRK+g9Of4X1ZbjsZG
 AA0j7PzkDB/5k6fXrNx7j8c8IhNDFn3PpOEM1MQgNWlrlr5iao3WsgwC9KoYLoryf8GifxUUXTVU5
 hn10jrFM0OI4iAf1n150sN/ZApTdKQcu2V/jv1l5zmwF8xtC+hpzm69HAoDmmq1OuhqQvbgnPiGeN
 gJa8BBGg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1xL1gO-00097D-0B; Sun, 25 Oct 2026 18:06:56 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vw-000OzG-24; Sun, 25 Oct 2026 17:56:08 +0100
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Date: Sun, 25 Oct 2026 17:55:37 +0100
Subject: [PATCH v2 21/31] hw/dma: add Renesas RX DMAC
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-umar-rx-series-v2-21-9e846577cad0@sayyadumar.com>
References: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
In-Reply-To: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947366; l=14236;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=i22RZ8oGxUuQdHlIs6YrhuIMRrQ+g6rnLga2VsmCCmY=;
 b=sirS5b6Is02W8PHg/ZKm/iKpjPqtqwk0YR2oSmw4Q2TihL7Tyd8pBs4tLQR2cIDzU/rDIzyYR
 7FHkM3+Rii0Au9dTC/O9owFXuDWqmbrxH3BHK8J3f9f8nHcdYIkgZwI
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

Add the RX DMA Controller, section 17 (DMAC) of the RX65N hardware
manual.

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
 MAINTAINERS                            |   2 +
 configs/devices/rx-softmmu/default.mak |   1 +
 hw/dma/Kconfig                         |   5 +-
 hw/dma/meson.build                     |   1 +
 hw/dma/renesas_rx_dmac.c               | 317 +++++++++++++++++++++++++++++++++
 include/hw/dma/renesas_rx_dmac.h       |  57 ++++++
 6 files changed, 382 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index dec31dbc0b..d36aa0afa1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3081,10 +3081,12 @@ F: include/hw/timer/renesas_*.h
 Renesas RX peripherals
 R: Yoshinori Sato <yoshinori.sato@nifty.com>
 S: Orphan
+F: hw/dma/renesas_rx_*.c
 F: hw/gpio/renesas_rx_gpio.c
 F: hw/intc/rx_icu.c
 F: hw/rx/
 F: hw/timer/renesas_mtu3.c
+F: include/hw/dma/renesas_rx_*.h
 F: include/hw/gpio/renesas_rx_gpio.h
 F: include/hw/intc/rx_icu.h
 F: include/hw/rx/
diff --git a/configs/devices/rx-softmmu/default.mak b/configs/devices/rx-softmmu/default.mak
index df789e00cd..f14a65dac7 100644
--- a/configs/devices/rx-softmmu/default.mak
+++ b/configs/devices/rx-softmmu/default.mak
@@ -4,3 +4,4 @@
 # CONFIG_RX_GDBSIM=n
 CONFIG_RENESAS_MTU3=y
 CONFIG_RENESAS_RX_GPIO=y
+CONFIG_RENESAS_RX_DMAC=y
diff --git a/hw/dma/Kconfig b/hw/dma/Kconfig
index 0a23e7d7b8..2c95b8696d 100644
--- a/hw/dma/Kconfig
+++ b/hw/dma/Kconfig
@@ -32,4 +32,7 @@ config XLNX_CSU_DMA
     select REGISTER
 
 config K230_GSDMA
-    bool
\ No newline at end of file
+    bool
+
+config RENESAS_RX_DMAC
+    bool
diff --git a/hw/dma/meson.build b/hw/dma/meson.build
index 45db5e7357..1fb06fb13d 100644
--- a/hw/dma/meson.build
+++ b/hw/dma/meson.build
@@ -13,3 +13,4 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_dma.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_PDMA', if_true: files('sifive_pdma.c'))
 system_ss.add(when: 'CONFIG_XLNX_CSU_DMA', if_true: files('xlnx_csu_dma.c'))
 system_ss.add(when: 'CONFIG_K230_GSDMA', if_true: files('k230_gsdma.c'))
+system_ss.add(when: 'CONFIG_RENESAS_RX_DMAC', if_true: files('renesas_rx_dmac.c'))
diff --git a/hw/dma/renesas_rx_dmac.c b/hw/dma/renesas_rx_dmac.c
new file mode 100644
index 0000000000..11e44e104c
--- /dev/null
+++ b/hw/dma/renesas_rx_dmac.c
@@ -0,0 +1,317 @@
+/*
+ * Renesas RX DMA Controller (DMAC)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), section 17 (DMAC)
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ *
+ * Models the eight DMAC channels. Hardware (peripheral-triggered) activation is
+ * not modelled; software-requested transfers (DMREQ.SWREQ) are performed
+ * synchronously, which covers memory-to-memory use and driver self-tests. The
+ * source/destination address increment modes and 8/16/32-bit transfer unit are
+ * honoured.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/dma/renesas_rx_dmac.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "system/address-spaces.h"
+
+/* Per-channel register offsets. */
+#define R_DMSAR     0x00    /* 32-bit */
+#define R_DMDAR     0x04    /* 32-bit */
+#define R_DMCRA     0x08    /* 32-bit */
+#define R_DMCRB     0x0C    /* 16-bit */
+#define R_DMTMD     0x10    /* 16-bit */
+#define R_DMINT     0x13    /* 8-bit  */
+#define R_DMAMD     0x14    /* 16-bit */
+#define R_DMOFR     0x18    /* 32-bit */
+#define R_DMCNT     0x1C    /* 8-bit  */
+#define R_DMREQ     0x1D    /* 8-bit  */
+#define R_DMSTS     0x1E    /* 8-bit  */
+
+/* Common registers. */
+#define R_DMAST     0x200   /* 8-bit  */
+
+/* DMTMD: SZ field (bits 9:8) = transfer unit. */
+#define DMTMD_SZ(v)     (((v) >> 8) & 3)
+/* DMAMD: SM (bits 9:8) source mode, DM (bits 13:12) destination mode. */
+#define DMAMD_SM(v)     (((v) >> 8) & 3)
+#define DMAMD_DM(v)     (((v) >> 12) & 3)
+#define ADDR_MODE_FIXED 0
+#define ADDR_MODE_OFF   1   /* offset addition (not modelled, treated fixed) */
+#define ADDR_MODE_INC   2
+#define ADDR_MODE_DEC   3
+
+#define DMCNT_DTE       (1u << 0)   /* transfer enable */
+#define DMREQ_SWREQ     (1u << 0)   /* software request */
+#define DMREQ_CLRS      (1u << 4)
+#define DMSTS_ACT       (1u << 7)
+#define DMSTS_DTIF      (1u << 1)   /* transfer-end interrupt flag */
+
+static unsigned dmac_unit_bytes(uint16_t dmtmd)
+{
+    switch (DMTMD_SZ(dmtmd)) {
+    case 0:
+        return 1;
+    case 1:
+        return 2;
+    default: return 4;
+    }
+}
+
+static void dmac_step_addr(uint32_t *addr, unsigned mode, unsigned bytes)
+{
+    if (mode == ADDR_MODE_INC) {
+        *addr += bytes;
+    } else if (mode == ADDR_MODE_DEC) {
+        *addr -= bytes;
+    }
+}
+
+/* Perform a software-requested transfer on a channel. */
+static void dmac_do_transfer(RenesasRxDmacState *s, int n)
+{
+    RxDmacChannel *c = &s->ch[n];
+    unsigned bytes = dmac_unit_bytes(c->dmtmd);
+    unsigned smode = DMAMD_SM(c->dmamd);
+    unsigned dmode = DMAMD_DM(c->dmamd);
+    uint16_t count = c->dmcra & 0xffff;
+    uint8_t buf[4];
+
+    if (!(s->dmast & 1) || !(c->dmcnt & DMCNT_DTE)) {
+        return;
+    }
+
+    /* A zero count means 65536 transfers on hardware; clamp it for QEMU. */
+    if (count == 0) {
+        count = 1;
+    }
+
+    while (count--) {
+        address_space_read(s->as, c->dmsar, MEMTXATTRS_UNSPECIFIED, buf, bytes);
+        address_space_write(s->as, c->dmdar, MEMTXATTRS_UNSPECIFIED,
+                            buf, bytes);
+        dmac_step_addr(&c->dmsar, smode, bytes);
+        dmac_step_addr(&c->dmdar, dmode, bytes);
+    }
+
+    /* Transfer complete: clear enable, flag status, raise interrupt. */
+    c->dmcra &= 0xffff0000;
+    c->dmcnt &= ~DMCNT_DTE;
+    c->dmsts = (c->dmsts & ~DMSTS_ACT) | DMSTS_DTIF;
+    if (c->dmint & 1) {
+        qemu_irq_pulse(s->irq[n]);
+    }
+}
+
+static uint64_t dmac_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RenesasRxDmacState *s = opaque;
+    RxDmacChannel *c;
+    unsigned reg;
+
+    if (offset == R_DMAST) {
+        return s->dmast;
+    }
+    if (offset >= RX_DMAC_NR_CH * RX_DMAC_CH_SIZE) {
+        return 0;
+    }
+
+    c = &s->ch[offset / RX_DMAC_CH_SIZE];
+    reg = offset % RX_DMAC_CH_SIZE;
+    switch (reg) {
+    case R_DMSAR:
+        return c->dmsar;
+    case R_DMDAR:
+        return c->dmdar;
+    case R_DMCRA:
+        return c->dmcra;
+    case R_DMCRB:
+        return c->dmcrb;
+    case R_DMTMD:
+        return c->dmtmd;
+    case R_DMINT:
+        return c->dmint;
+    case R_DMAMD:
+        return c->dmamd;
+    case R_DMOFR:
+        return c->dmofr;
+    case R_DMCNT:
+        return c->dmcnt;
+    case R_DMREQ:
+        return c->dmreq;
+    case R_DMSTS:
+        return c->dmsts;
+    default:      return 0;
+    }
+}
+
+static void dmac_write(void *opaque, hwaddr offset, uint64_t value,
+                       unsigned size)
+{
+    RenesasRxDmacState *s = opaque;
+    RxDmacChannel *c;
+    unsigned reg, n;
+
+    if (offset == R_DMAST) {
+        s->dmast = value;
+        return;
+    }
+    if (offset >= RX_DMAC_NR_CH * RX_DMAC_CH_SIZE) {
+        qemu_log_mask(LOG_UNIMP, "renesas-rx-dmac: write unimplemented 0x%"
+                      HWADDR_PRIx "\n", offset);
+        return;
+    }
+
+    n = offset / RX_DMAC_CH_SIZE;
+    c = &s->ch[n];
+    reg = offset % RX_DMAC_CH_SIZE;
+    switch (reg) {
+    case R_DMSAR:
+        c->dmsar = value;
+        break;
+    case R_DMDAR:
+        c->dmdar = value;
+        break;
+    case R_DMCRA:
+        c->dmcra = value;
+        break;
+    case R_DMCRB:
+        c->dmcrb = value;
+        break;
+    case R_DMTMD:
+        c->dmtmd = value;
+        break;
+    case R_DMINT:
+        c->dmint = value;
+        break;
+    case R_DMAMD:
+        c->dmamd = value;
+        break;
+    case R_DMOFR:
+        c->dmofr = value;
+        break;
+    case R_DMCNT:
+        c->dmcnt = value;
+        break;
+    case R_DMREQ:
+        c->dmreq = value;
+        if (value & DMREQ_SWREQ) {
+            dmac_do_transfer(s, n);
+            c->dmreq &= ~DMREQ_SWREQ;
+        }
+        break;
+    case R_DMSTS:
+        /* DTIF/ACT are status flags cleared by writing the register. */
+        c->dmsts = value;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas-rx-dmac: write unimplemented 0x%"
+                      HWADDR_PRIx "\n", offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps dmac_ops = {
+    .read = dmac_read,
+    .write = dmac_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = { .min_access_size = 1, .max_access_size = 4 },
+    .valid = { .min_access_size = 1, .max_access_size = 4 },
+};
+
+static void rx_dmac_reset(DeviceState *dev)
+{
+    RenesasRxDmacState *s = RENESAS_RX_DMAC(dev);
+
+    memset(s->ch, 0, sizeof(s->ch));
+    s->dmast = 0;
+}
+
+static void rx_dmac_realize(DeviceState *dev, Error **errp)
+{
+    RenesasRxDmacState *s = RENESAS_RX_DMAC(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    if (s->dma_mr == NULL) {
+        s->dma_mr = get_system_memory();
+    }
+    s->as = g_new0(AddressSpace, 1);
+    address_space_init(s->as, s->dma_mr, "renesas-rx-dmac");
+
+    memory_region_init_io(&s->mr, OBJECT(s), &dmac_ops, s,
+                          "renesas-rx-dmac", RX_DMAC_REGS_SIZE);
+    sysbus_init_mmio(sbd, &s->mr);
+    for (int i = 0; i < RX_DMAC_NR_CH; i++) {
+        sysbus_init_irq(sbd, &s->irq[i]);
+    }
+}
+
+static const Property rx_dmac_properties[] = {
+    DEFINE_PROP_LINK("dma-memory", RenesasRxDmacState, dma_mr,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
+};
+
+static const VMStateDescription vmstate_rx_dmac_ch = {
+    .name = "renesas-rx-dmac-channel",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(dmsar, RxDmacChannel),
+        VMSTATE_UINT32(dmdar, RxDmacChannel),
+        VMSTATE_UINT32(dmcra, RxDmacChannel),
+        VMSTATE_UINT16(dmcrb, RxDmacChannel),
+        VMSTATE_UINT16(dmtmd, RxDmacChannel),
+        VMSTATE_UINT8(dmint, RxDmacChannel),
+        VMSTATE_UINT16(dmamd, RxDmacChannel),
+        VMSTATE_UINT32(dmofr, RxDmacChannel),
+        VMSTATE_UINT8(dmcnt, RxDmacChannel),
+        VMSTATE_UINT8(dmreq, RxDmacChannel),
+        VMSTATE_UINT8(dmsts, RxDmacChannel),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_rx_dmac = {
+    .name = "renesas-rx-dmac",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT_ARRAY(ch, RenesasRxDmacState, RX_DMAC_NR_CH, 1,
+                             vmstate_rx_dmac_ch, RxDmacChannel),
+        VMSTATE_UINT8(dmast, RenesasRxDmacState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rx_dmac_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = rx_dmac_realize;
+    dc->vmsd = &vmstate_rx_dmac;
+    device_class_set_props(dc, rx_dmac_properties);
+    device_class_set_legacy_reset(dc, rx_dmac_reset);
+}
+
+static const TypeInfo rx_dmac_info = {
+    .name = TYPE_RENESAS_RX_DMAC,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RenesasRxDmacState),
+    .class_init = rx_dmac_class_init,
+};
+
+static void rx_dmac_register_types(void)
+{
+    type_register_static(&rx_dmac_info);
+}
+
+type_init(rx_dmac_register_types)
diff --git a/include/hw/dma/renesas_rx_dmac.h b/include/hw/dma/renesas_rx_dmac.h
new file mode 100644
index 0000000000..47242a31b6
--- /dev/null
+++ b/include/hw/dma/renesas_rx_dmac.h
@@ -0,0 +1,57 @@
+/*
+ * Renesas RX DMA Controller (DMAC) and Data Transfer Controller (DTC)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), sections 17 (DMAC) and 18 (DTC)
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef HW_DMA_RENESAS_RX_DMAC_H
+#define HW_DMA_RENESAS_RX_DMAC_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RENESAS_RX_DMAC "renesas-rx-dmac"
+typedef struct RenesasRxDmacState RenesasRxDmacState;
+DECLARE_INSTANCE_CHECKER(RenesasRxDmacState, RENESAS_RX_DMAC,
+                         TYPE_RENESAS_RX_DMAC)
+
+#define RX_DMAC_NR_CH       8
+#define RX_DMAC_CH_SIZE     0x40        /* per-channel register spacing  */
+#define RX_DMAC_REGS_SIZE   0x300       /* channels + common registers   */
+
+typedef struct RxDmacChannel {
+    uint32_t dmsar;     /* source address                       */
+    uint32_t dmdar;     /* destination address                  */
+    uint32_t dmcra;     /* transfer count (A: lower, B: upper)  */
+    uint16_t dmcrb;     /* block transfer count                 */
+    uint16_t dmtmd;     /* transfer mode                        */
+    uint8_t  dmint;     /* interrupt setting                    */
+    uint16_t dmamd;     /* address mode                         */
+    uint32_t dmofr;     /* offset                               */
+    uint8_t  dmcnt;     /* transfer enable                      */
+    uint8_t  dmreq;     /* software/refresh request             */
+    uint8_t  dmsts;     /* status                               */
+} RxDmacChannel;
+
+struct RenesasRxDmacState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion mr;
+    AddressSpace *as;
+    MemoryRegion *dma_mr;
+
+    RxDmacChannel ch[RX_DMAC_NR_CH];
+    uint8_t dmast;      /* module activation                    */
+
+    qemu_irq irq[RX_DMAC_NR_CH];
+};
+
+#endif /* HW_DMA_RENESAS_RX_DMAC_H */

-- 
2.53.0


