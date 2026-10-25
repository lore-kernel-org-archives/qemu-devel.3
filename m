Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6000606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 17:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL23Y-0000IC-04; Sun, 25 Oct 2026 13:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL23H-0008Ul-7H; Sun, 25 Oct 2026 13:30:41 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL23E-0007FB-Hk; Sun, 25 Oct 2026 13:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=78FRnUwB9+C4qUiF0wBSl35UQHC2gQKvrX/NTrxUsxE=; b=oCNr7MxHDwWVUaU9cFYuWaCKdU
 tbIKam/JvWYpB69+w6CN5AP/DWMnOXxoPrH8ecY+uE5c+9hHQGoaNmj3Ti2prO9xLHYQlvfOVSxVZ
 jn5vJs/HJPPuGmHouhb/EE2bveb7oNsGikRegnyGglFGJky4xlkRPC7BogGCsyOZyNELOu71KXidm
 D4Lt06ySsO1MLCc6ASlQqhXmKUIyIhS9ndqATUXmlIz5gHY9QGrbrowSSkyhoh5eW2CdJBwImkyiH
 T1Tx1zMRIHz/K87iYsA+9IkQeqhQneDV1VgdYgs56WSmtRaL0Yasfst4YxHIGOsZIfQeDZWhogXOB
 pLeVkk5A==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1xL1gR-00098J-0b; Sun, 25 Oct 2026 18:06:59 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vw-000OzG-1q; Sun, 25 Oct 2026 17:56:08 +0100
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Date: Sun, 25 Oct 2026 17:55:36 +0100
Subject: [PATCH v2 20/31] hw/gpio: add Renesas RX GPIO and MPC
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-umar-rx-series-v2-20-9e846577cad0@sayyadumar.com>
References: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
In-Reply-To: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947366; l=13229;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=9FuzzBHItqSzUdK7K6jGDJ62UVLgxomOG0Twz7rKY9Y=;
 b=dImCAkjNh8jUPukKcxB+jn314tFpw+GOgrDIlI6W1BBpgALI7MQQkqo5EpabeQtYFIA9plre4
 TWG++OFctPzCY/EV37dMCWDbEHVi613U+ivyhCb3cr1UciX7LAV7AKd
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

Add the RX I/O ports (GPIO) with the Multi-Function Pin Controller,
covering sections 20 (I/O Ports) and 22 (MPC) of the RX65N hardware
manual.

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
 MAINTAINERS                            |   2 +
 configs/devices/rx-softmmu/default.mak |   1 +
 hw/gpio/Kconfig                        |   3 +
 hw/gpio/meson.build                    |   1 +
 hw/gpio/renesas_rx_gpio.c              | 256 +++++++++++++++++++++++++++++++++
 include/hw/gpio/renesas_rx_gpio.h      |  64 +++++++++
 6 files changed, 327 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 260d70797b..dec31dbc0b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3081,9 +3081,11 @@ F: include/hw/timer/renesas_*.h
 Renesas RX peripherals
 R: Yoshinori Sato <yoshinori.sato@nifty.com>
 S: Orphan
+F: hw/gpio/renesas_rx_gpio.c
 F: hw/intc/rx_icu.c
 F: hw/rx/
 F: hw/timer/renesas_mtu3.c
+F: include/hw/gpio/renesas_rx_gpio.h
 F: include/hw/intc/rx_icu.h
 F: include/hw/rx/
 F: include/hw/timer/renesas_mtu3.h
diff --git a/configs/devices/rx-softmmu/default.mak b/configs/devices/rx-softmmu/default.mak
index d99f506125..df789e00cd 100644
--- a/configs/devices/rx-softmmu/default.mak
+++ b/configs/devices/rx-softmmu/default.mak
@@ -3,3 +3,4 @@
 # Boards are selected by default, uncomment to keep out of the build.
 # CONFIG_RX_GDBSIM=n
 CONFIG_RENESAS_MTU3=y
+CONFIG_RENESAS_RX_GPIO=y
diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index ea0fb72b40..03ce504ad4 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -36,3 +36,6 @@ config CADENCE_GPIO
 
 config ALLWINNER_GPIO
     bool
+
+config RENESAS_RX_GPIO
+    bool
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index 8ede5e88ae..afd61f7684 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -21,3 +21,4 @@ system_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'))
 system_ss.add(when: 'CONFIG_PCF8574', if_true: files('pcf8574.c'))
 system_ss.add(when: 'CONFIG_CADENCE_GPIO', if_true: files('cadence_gpio.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_GPIO', if_true: files('allwinner-gpio.c'))
+system_ss.add(when: 'CONFIG_RENESAS_RX_GPIO', if_true: files('renesas_rx_gpio.c'))
diff --git a/hw/gpio/renesas_rx_gpio.c b/hw/gpio/renesas_rx_gpio.c
new file mode 100644
index 0000000000..3a40d88948
--- /dev/null
+++ b/hw/gpio/renesas_rx_gpio.c
@@ -0,0 +1,256 @@
+/*
+ * Renesas RX I/O Ports (GPIO) and Multi-Function Pin Controller (MPC)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), sections 20 (I/O Ports) and 22 (MPC)
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ *
+ * Each 8-bit I/O port exposes a direction register (PDR), an output data
+ * register (PODR) and an input data register (PIDR). Output pins drive the
+ * corresponding "gpio-out" line (used by board LEDs); input pins read back the
+ * level driven on the "gpio-in" line (used by board switches). The MPC PFS
+ * registers select alternate pin functions and behave as plain storage.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/gpio/renesas_rx_gpio.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
+#include "migration/vmstate.h"
+
+/* Per-port register offsets within the I/O port block (index = port number). */
+#define R_PDR   0x000   /* 1 byte per port */
+#define R_PODR  0x020
+#define R_PIDR  0x040
+#define R_PMR   0x060
+#define R_ODR   0x080   /* 2 bytes per port */
+#define R_PCR   0x0C0
+#define R_DSCR  0x0E0
+#define R_END   0x100
+
+/* MPC write-protect register, relative to the MPC block base (0x0008C100). */
+#define R_PWPR  0x01F   /* 0x0008C11F */
+
+/* Compute the input-data value seen for a port. */
+static uint8_t port_pidr(RenesasRxGpioState *s, unsigned p)
+{
+    uint8_t value;
+
+    /* Output pins read back their output latch; input pins read the pin. */
+    value = (s->podr[p] & s->pdr[p]) | (s->input[p] & ~s->pdr[p]);
+    return value;
+}
+
+/* Drive the per-pin output lines for a port from PDR/PODR. */
+static void port_update_out(RenesasRxGpioState *s, unsigned p)
+{
+    for (unsigned b = 0; b < 8; b++) {
+        int level = 0;
+        if (s->pdr[p] & (1 << b)) {                 /* output pin */
+            level = (s->podr[p] >> b) & 1;
+        }
+        qemu_set_irq(s->out[p * 8 + b], level);
+    }
+}
+
+static uint64_t gpio_port_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RenesasRxGpioState *s = opaque;
+    unsigned p = offset & 0x1f;
+
+    switch (offset & ~0x1f) {
+    case R_PDR:
+        return s->pdr[p];
+    case R_PODR:
+        return s->podr[p];
+    case R_PIDR:
+        return port_pidr(s, p);
+    case R_PMR:
+        return s->pmr[p];
+    case R_PCR:
+        return s->pcr[p];
+    case R_DSCR:
+        return s->dscr[p];
+    default:
+        if (offset >= R_ODR && offset < R_PCR) {
+            return s->odr[offset - R_ODR];
+        }
+        qemu_log_mask(LOG_UNIMP, "renesas-rx-gpio: read unimplemented 0x%"
+                      HWADDR_PRIx "\n", offset);
+        return 0;
+    }
+}
+
+static void gpio_port_write(void *opaque, hwaddr offset, uint64_t value,
+                            unsigned size)
+{
+    RenesasRxGpioState *s = opaque;
+    unsigned p = offset & 0x1f;
+
+    switch (offset & ~0x1f) {
+    case R_PDR:
+        s->pdr[p] = value;
+        port_update_out(s, p);
+        break;
+    case R_PODR:
+        s->podr[p] = value;
+        port_update_out(s, p);
+        break;
+    case R_PMR:
+        s->pmr[p] = value;
+        break;
+    case R_PCR:
+        s->pcr[p] = value;
+        break;
+    case R_DSCR:
+        s->dscr[p] = value;
+        break;
+    case R_PIDR:
+        /* Input data register is read-only. */
+        break;
+    default:
+        if (offset >= R_ODR && offset < R_PCR) {
+            s->odr[offset - R_ODR] = value;
+        } else {
+            qemu_log_mask(LOG_UNIMP, "renesas-rx-gpio: write unimplemented 0x%"
+                          HWADDR_PRIx "\n", offset);
+        }
+        break;
+    }
+}
+
+static const MemoryRegionOps gpio_port_ops = {
+    .read = gpio_port_read,
+    .write = gpio_port_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = { .min_access_size = 1, .max_access_size = 1 },
+    .valid = { .min_access_size = 1, .max_access_size = 1 },
+};
+
+static uint64_t gpio_mpc_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RenesasRxGpioState *s = opaque;
+    uint64_t val = 0;
+
+    for (unsigned i = 0; i < size && offset + i < RX_GPIO_MPC_SIZE; i++) {
+        val |= (uint64_t)s->mpc[offset + i] << (8 * i);
+    }
+    return val;
+}
+
+static void gpio_mpc_write(void *opaque, hwaddr offset, uint64_t value,
+                           unsigned size)
+{
+    RenesasRxGpioState *s = opaque;
+
+    /*
+     * PFS registers are locked unless PWPR.PFSWE is set (and PWPR.B0WI clear).
+     * Storing the PFS selection is otherwise sufficient: QEMU peripherals are
+     * wired unconditionally, so pin muxing has no functional effect here.
+     */
+    for (unsigned i = 0; i < size && offset + i < RX_GPIO_MPC_SIZE; i++) {
+        s->mpc[offset + i] = (value >> (8 * i)) & 0xff;
+    }
+}
+
+static const MemoryRegionOps gpio_mpc_ops = {
+    .read = gpio_mpc_read,
+    .write = gpio_mpc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = { .min_access_size = 1, .max_access_size = 1 },
+    .valid = { .min_access_size = 1, .max_access_size = 1 },
+};
+
+/* External input line handler: pin = port * 8 + bit. */
+static void gpio_set_input(void *opaque, int pin, int level)
+{
+    RenesasRxGpioState *s = opaque;
+    unsigned p = pin / 8, b = pin % 8;
+
+    if (level) {
+        s->input[p] |= (1 << b);
+    } else {
+        s->input[p] &= ~(1 << b);
+    }
+}
+
+static void rx_gpio_reset(DeviceState *dev)
+{
+    RenesasRxGpioState *s = RENESAS_RX_GPIO(dev);
+
+    memset(s->pdr, 0, sizeof(s->pdr));
+    memset(s->podr, 0, sizeof(s->podr));
+    memset(s->pmr, 0, sizeof(s->pmr));
+    memset(s->odr, 0, sizeof(s->odr));
+    memset(s->pcr, 0, sizeof(s->pcr));
+    memset(s->dscr, 0, sizeof(s->dscr));
+    memset(s->mpc, 0, sizeof(s->mpc));
+    /* PWPR resets with B0WI set (PFS write disabled). */
+    s->mpc[R_PWPR] = 0x80;
+
+    for (unsigned p = 0; p < RX_GPIO_NR_PORTS; p++) {
+        port_update_out(s, p);
+    }
+}
+
+static void rx_gpio_init(Object *obj)
+{
+    RenesasRxGpioState *s = RENESAS_RX_GPIO(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->port_mr, obj, &gpio_port_ops, s,
+                          "renesas-rx-gpio.port", RX_GPIO_PORT_SIZE);
+    memory_region_init_io(&s->mpc_mr, obj, &gpio_mpc_ops, s,
+                          "renesas-rx-gpio.mpc", RX_GPIO_MPC_SIZE);
+    sysbus_init_mmio(sbd, &s->port_mr);
+    sysbus_init_mmio(sbd, &s->mpc_mr);
+
+    qdev_init_gpio_out_named(DEVICE(obj), s->out, "gpio-out", RX_GPIO_NR_PINS);
+    qdev_init_gpio_in_named(DEVICE(obj), gpio_set_input, "gpio-in",
+                            RX_GPIO_NR_PINS);
+}
+
+static const VMStateDescription vmstate_rx_gpio = {
+    .name = "renesas-rx-gpio",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(pdr, RenesasRxGpioState, RX_GPIO_NR_PORTS),
+        VMSTATE_UINT8_ARRAY(podr, RenesasRxGpioState, RX_GPIO_NR_PORTS),
+        VMSTATE_UINT8_ARRAY(pmr, RenesasRxGpioState, RX_GPIO_NR_PORTS),
+        VMSTATE_UINT8_ARRAY(odr, RenesasRxGpioState, RX_GPIO_NR_PORTS * 2),
+        VMSTATE_UINT8_ARRAY(pcr, RenesasRxGpioState, RX_GPIO_NR_PORTS),
+        VMSTATE_UINT8_ARRAY(dscr, RenesasRxGpioState, RX_GPIO_NR_PORTS),
+        VMSTATE_UINT8_ARRAY(input, RenesasRxGpioState, RX_GPIO_NR_PORTS),
+        VMSTATE_UINT8_ARRAY(mpc, RenesasRxGpioState, RX_GPIO_MPC_SIZE),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rx_gpio_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_rx_gpio;
+    device_class_set_legacy_reset(dc, rx_gpio_reset);
+}
+
+static const TypeInfo rx_gpio_info = {
+    .name = TYPE_RENESAS_RX_GPIO,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RenesasRxGpioState),
+    .instance_init = rx_gpio_init,
+    .class_init = rx_gpio_class_init,
+};
+
+static void rx_gpio_register_types(void)
+{
+    type_register_static(&rx_gpio_info);
+}
+
+type_init(rx_gpio_register_types)
diff --git a/include/hw/gpio/renesas_rx_gpio.h b/include/hw/gpio/renesas_rx_gpio.h
new file mode 100644
index 0000000000..24784d7d1a
--- /dev/null
+++ b/include/hw/gpio/renesas_rx_gpio.h
@@ -0,0 +1,64 @@
+/*
+ * Renesas RX I/O Ports (GPIO) and Multi-Function Pin Controller (MPC)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), sections 20 (I/O Ports) and 22 (MPC)
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef HW_GPIO_RENESAS_RX_GPIO_H
+#define HW_GPIO_RENESAS_RX_GPIO_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RENESAS_RX_GPIO "renesas-rx-gpio"
+typedef struct RenesasRxGpioState RenesasRxGpioState;
+DECLARE_INSTANCE_CHECKER(RenesasRxGpioState, RENESAS_RX_GPIO,
+                         TYPE_RENESAS_RX_GPIO)
+
+/* Number of 8-bit ports modelled (PORT0..PORT1F register indices). */
+#define RX_GPIO_NR_PORTS    0x20
+#define RX_GPIO_NR_PINS     (RX_GPIO_NR_PORTS * 8)
+
+/* MMIO regions. */
+enum {
+    RX_GPIO_MMIO_PORT = 0,  /* I/O port register block (0x0008C000) */
+    RX_GPIO_MMIO_MPC,       /* MPC pin-function block   (0x0008C100) */
+    RX_GPIO_NR_MMIO,
+};
+
+#define RX_GPIO_PORT_SIZE   0x100
+#define RX_GPIO_MPC_SIZE    0x200
+
+struct RenesasRxGpioState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion port_mr;
+    MemoryRegion mpc_mr;
+
+    /* Per-port registers. */
+    uint8_t pdr[RX_GPIO_NR_PORTS];      /* direction: 1 = output         */
+    uint8_t podr[RX_GPIO_NR_PORTS];     /* output data                   */
+    uint8_t pmr[RX_GPIO_NR_PORTS];      /* mode: 1 = peripheral          */
+    uint8_t odr[RX_GPIO_NR_PORTS * 2];  /* open-drain control (2/port)   */
+    uint8_t pcr[RX_GPIO_NR_PORTS];      /* pull-up control               */
+    uint8_t dscr[RX_GPIO_NR_PORTS];     /* drive capacity                */
+
+    /* External input level driven onto each port by board wiring. */
+    uint8_t input[RX_GPIO_NR_PORTS];
+
+    /* MPC PFS storage and write-protect register. */
+    uint8_t mpc[RX_GPIO_MPC_SIZE];
+
+    /* Output lines, one per pin (port * 8 + bit). */
+    qemu_irq out[RX_GPIO_NR_PINS];
+};
+
+#endif /* HW_GPIO_RENESAS_RX_GPIO_H */

-- 
2.53.0


