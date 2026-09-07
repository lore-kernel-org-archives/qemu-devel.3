Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B5DC79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 05:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3RqX-0004t8-AE; Mon, 07 Sep 2026 01:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3RqV-0004ss-Mp; Mon, 07 Sep 2026 01:24:43 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3RqS-0007t5-Ts; Mon, 07 Sep 2026 01:24:43 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4hdb983YfYz7vHR;
 Mon,  7 Sep 2026 07:24:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788758668;
 bh=pa7SnlgbHc7Rzu0XQlZrAN6YVeTHnFI7QAXnViIed9w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nxHCfQl4GuQRSe5n3c9VvPQzmbg2Stvx+ID41ubk7LsrKpmsyE9GqQbGv2vrbxXfR
 NReZMbbGnk9Mij0hjWJlYsP5FzNsdhzHYVGFXEpJnRPGhKmFIMBV2DMUmw1oKDHGLp
 F6gmhLPElaec5sYTAeK/8NPkRwfNae+QWel9qOy+JvCPjBiYf0iriTpzP1+t/falFi
 qYGhimC44REQJW24eyGbUlFRqUuDNDXJC6jdfPgjtWdfCHyg2iDBSqOAamK+R6KIH7
 n3Yx15QfIiOY3eIjWPE8up5LezIPxFyAI6Xgf+kUQpvIVp4Wqxf94jv0SOSusLsc4B
 Jh9uxNIaelWAQ==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hdb980xF4z7xqf;
 Mon,  7 Sep 2026 07:24:28 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 Gilles Grimaud <gilles.grimaud@univ-lille.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v3 20/36] hw/char: integrate RP2040 UART pinmux
Date: Mon,  7 Sep 2026 07:24:08 +0200
Message-ID: <20260907052426.24849-4-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907052426.24849-1-gilles.grimaud@univ-lille.fr>
References: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
 <20260907052426.24849-1-gilles.grimaud@univ-lille.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.106;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-2.univ-lille.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/arm/raspi_pico.c                |  33 +++++++
 hw/arm/rp2040.c                    |  58 +++++++++++-
 hw/char/pl011.c                    |  86 +++++++++++++++++-
 include/hw/arm/rp2040.h            |   5 ++
 include/hw/char/pl011.h            |   6 ++
 tests/qtest/meson.build            |   1 +
 tests/qtest/rp2040-uart-test.c     | 139 +++++++++++++++++++++++++++++
 tests/tcg/arm/system/rp2040-mpu.S  |   5 ++
 tests/tcg/arm/system/rp2040-uart.S |   5 ++
 9 files changed, 333 insertions(+), 5 deletions(-)
 create mode 100644 tests/qtest/rp2040-uart-test.c

diff --git a/hw/arm/raspi_pico.c b/hw/arm/raspi_pico.c
index 1c01a27e89..e361a0dbc9 100644
--- a/hw/arm/raspi_pico.c
+++ b/hw/arm/raspi_pico.c
@@ -30,6 +30,7 @@ struct RaspiPicoMachineState {
     MemoryRegion flash;
     uint64_t rosc_random_seed;
     bool rosc_random_seed_set;
+    bool strict_uart_pins;
 };
 
 static void raspi_pico_get_rosc_random_seed(Object *obj, Visitor *v,
@@ -65,6 +66,8 @@ static void raspi_pico_init(MachineState *machine)
     object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_RP2040);
     qdev_prop_set_chr(DEVICE(&s->soc), "serial0", serial_hd(0));
     qdev_prop_set_chr(DEVICE(&s->soc), "serial1", serial_hd(1));
+    qdev_prop_set_bit(DEVICE(&s->soc), "strict-uart-pins",
+                      s->strict_uart_pins);
     qdev_prop_set_uint64(DEVICE(&s->soc.rosc), "random-seed",
                          s->rosc_random_seed);
     qdev_prop_set_bit(DEVICE(&s->soc.rosc), "random-seed-set",
@@ -86,6 +89,28 @@ static void raspi_pico_init(MachineState *machine)
                        RP2040_XIP_BASE, PICO_FLASH_SIZE);
 }
 
+static bool raspi_pico_get_strict_uart_pins(Object *obj, Error **errp)
+{
+    RaspiPicoMachineState *s = RASPI_PICO_MACHINE(obj);
+
+    return s->strict_uart_pins;
+}
+
+static void raspi_pico_set_strict_uart_pins(Object *obj, bool value,
+                                            Error **errp)
+{
+    RaspiPicoMachineState *s = RASPI_PICO_MACHINE(obj);
+
+    s->strict_uart_pins = value;
+}
+
+static void raspi_pico_machine_initfn(Object *obj)
+{
+    RaspiPicoMachineState *s = RASPI_PICO_MACHINE(obj);
+
+    s->strict_uart_pins = true;
+}
+
 static void raspi_pico_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -107,12 +132,20 @@ static void raspi_pico_machine_class_init(ObjectClass *oc, const void *data)
                                           "Use a deterministic seed for the "
                                           "ROSC RANDOMBIT stream; if unset, "
                                           "QEMU guest entropy is used");
+    object_class_property_add_bool(oc, "strict-uart-pins",
+                                   raspi_pico_get_strict_uart_pins,
+                                   raspi_pico_set_strict_uart_pins);
+    object_class_property_set_description(oc, "strict-uart-pins",
+                                          "Require the RP2040 IO_BANK0 "
+                                          "UART pinmux before UART0 or UART1 "
+                                          "reaches its host serial backend");
 }
 
 static const TypeInfo raspi_pico_machine_info = {
     .name = TYPE_RASPI_PICO_MACHINE,
     .parent = TYPE_MACHINE,
     .instance_size = sizeof(RaspiPicoMachineState),
+    .instance_init = raspi_pico_machine_initfn,
     .class_init = raspi_pico_machine_class_init,
 };
 
diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
index aa1407b4dd..b503a4213c 100644
--- a/hw/arm/rp2040.c
+++ b/hw/arm/rp2040.c
@@ -50,8 +50,6 @@ static const struct {
     hwaddr size;
 } rp2040_unimplemented[] = {
     { "rp2040.busctrl",  0x40030000, 0x4000 },
-    { "rp2040.uart0_aliases", 0x40035000, 0x3000 },
-    { "rp2040.uart1_aliases", 0x40039000, 0x3000 },
     { "rp2040.spi0",     0x4003c000, 0x4000 },
     { "rp2040.spi1",     0x40040000, 0x4000 },
     { "rp2040.i2c0",     0x40044000, 0x4000 },
@@ -102,11 +100,54 @@ static void rp2040_set_irq(void *opaque, int irq, int level)
     rp2040_update_nmi(s);
 }
 
+static void rp2040_update_uart_pins(RP2040State *s)
+{
+    pl011_set_tx_connected(&s->uart[0],
+                           !s->strict_uart_pins ||
+                           s->uart0_tx_pin_enabled);
+    pl011_set_rx_connected(&s->uart[0],
+                           !s->strict_uart_pins ||
+                           s->uart0_rx_pin_enabled);
+    pl011_set_tx_connected(&s->uart[1],
+                           !s->strict_uart_pins ||
+                           s->uart1_tx_pin_enabled);
+    pl011_set_rx_connected(&s->uart[1],
+                           !s->strict_uart_pins ||
+                           s->uart1_rx_pin_enabled);
+}
+
+static void rp2040_set_uart_pin(void *opaque, int pin, int level)
+{
+    RP2040State *s = opaque;
+
+    switch (pin) {
+    case 0:
+        s->uart0_tx_pin_enabled = level;
+        break;
+    case 1:
+        s->uart0_rx_pin_enabled = level;
+        break;
+    case 2:
+        s->uart1_tx_pin_enabled = level;
+        break;
+    case 3:
+        s->uart1_rx_pin_enabled = level;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    rp2040_update_uart_pins(s);
+}
+
 static void rp2040_soc_init(Object *obj)
 {
     RP2040State *s = RP2040(obj);
     int i;
 
+    qdev_init_gpio_in_named(DEVICE(obj), rp2040_set_uart_pin,
+                            "uart-pin", 4);
+
     for (i = 0; i < RP2040_NUM_CORES; i++) {
         g_autofree char *name = g_strdup_printf("proc%d", i);
 
@@ -329,6 +370,14 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->iobank0), 0, RP2040_IOBANK0_BASE);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->iobank0), 0,
                        s->irq[RP2040_IO_IRQ_BANK0]);
+    qdev_connect_gpio_out_named(DEVICE(&s->iobank0), "uart0-pin", 0,
+                                qdev_get_gpio_in_named(dev, "uart-pin", 0));
+    qdev_connect_gpio_out_named(DEVICE(&s->iobank0), "uart0-pin", 1,
+                                qdev_get_gpio_in_named(dev, "uart-pin", 1));
+    qdev_connect_gpio_out_named(DEVICE(&s->iobank0), "uart1-pin", 0,
+                                qdev_get_gpio_in_named(dev, "uart-pin", 2));
+    qdev_connect_gpio_out_named(DEVICE(&s->iobank0), "uart1-pin", 1,
+                                qdev_get_gpio_in_named(dev, "uart-pin", 3));
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->ioqspi), errp)) {
         return;
@@ -383,17 +432,20 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, uart_base[i]);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 1,
+                        uart_base[i] + 0x1000);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
                            s->irq[uart_irq[i]]);
     }
-
     rp2040_update_nmi(s);
+    rp2040_update_uart_pins(s);
 }
 
 static const Property rp2040_soc_properties[] = {
     DEFINE_PROP_LINK("memory", RP2040State, board_memory, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_STRING("bootrom-file", RP2040State, bootrom_file),
+    DEFINE_PROP_BOOL("strict-uart-pins", RP2040State, strict_uart_pins, true),
 };
 
 static void rp2040_soc_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 7e982e54bb..828c314100 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -101,6 +101,12 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
 /* Fractional Baud Rate Divider, UARTFBRD */
 #define FBRD_MASK 0x3f
 
+/* RP2040 APB atomic register aliases. */
+#define PL011_ATOMIC_ALIAS_MASK 0x3000
+#define PL011_ATOMIC_XOR        0x1000
+#define PL011_ATOMIC_SET        0x2000
+#define PL011_ATOMIC_CLR        0x3000
+
 static const unsigned char pl011_id_arm[8] =
   { 0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1 };
 static const unsigned char pl011_id_luminary[8] =
@@ -173,6 +179,21 @@ static void pl011_update_dreq(PL011State *s)
                  (s->dmacr & DMACR_RXDMAE) && s->read_count > 0);
 }
 
+static uint32_t pl011_apply_atomic_alias(uint32_t old, uint32_t value,
+                                         hwaddr alias)
+{
+    switch (alias) {
+    case PL011_ATOMIC_XOR:
+        return old ^ value;
+    case PL011_ATOMIC_SET:
+        return old | value;
+    case PL011_ATOMIC_CLR:
+        return old & ~value;
+    default:
+        return value;
+    }
+}
+
 static inline void pl011_reset_rx_fifo(PL011State *s)
 {
     s->read_count = 0;
@@ -271,7 +292,13 @@ static void pl011_write_txdata(PL011State *s, uint8_t data)
      * XXX this blocks entire thread. Rewrite to use
      * qemu_chr_fe_write and background I/O callbacks
      */
-    qemu_chr_fe_write_all(&s->chr, &data, 1);
+    if (s->tx_connected) {
+        qemu_chr_fe_write_all(&s->chr, &data, 1);
+    } else if (!s->logged_disconnected_tx) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "PL011 data written while TX pin is disconnected\n");
+        s->logged_disconnected_tx = true;
+    }
     pl011_loopback_tx(s, data);
     s->int_level |= INT_TX;
     pl011_update(s);
@@ -542,6 +569,10 @@ static int pl011_can_receive(void *opaque)
      * UART continuously enabled regardless of the enable bits.
      */
 
+    if (!s->rx_connected) {
+        return 0;
+    }
+
     trace_pl011_can_receive(s->lcr, s->read_count, fifo_depth, fifo_available);
     return fifo_available;
 }
@@ -549,6 +580,9 @@ static int pl011_can_receive(void *opaque)
 static void pl011_receive(void *opaque, const uint8_t *buf, int size)
 {
     trace_pl011_receive(size);
+    if (!PL011(opaque)->rx_connected) {
+        return;
+    }
     /*
      * In loopback mode, the RX input signal is internally disconnected
      * from the entire receiving logics; thus, all inputs are ignored,
@@ -565,11 +599,45 @@ static void pl011_receive(void *opaque, const uint8_t *buf, int size)
 
 static void pl011_event(void *opaque, QEMUChrEvent event)
 {
-    if (event == CHR_EVENT_BREAK && !pl011_loopback_enabled(opaque)) {
+    PL011State *s = opaque;
+
+    if (event == CHR_EVENT_BREAK && s->rx_connected &&
+        !pl011_loopback_enabled(opaque)) {
         pl011_fifo_rx_put(opaque, DR_BE);
     }
 }
 
+void pl011_set_tx_connected(PL011State *s, bool connected)
+{
+    s->tx_connected = connected;
+    if (connected) {
+        s->logged_disconnected_tx = false;
+    }
+}
+
+void pl011_set_rx_connected(PL011State *s, bool connected)
+{
+    s->rx_connected = connected;
+    qemu_chr_fe_accept_input(&s->chr);
+}
+
+static uint64_t pl011_atomic_alias_read(void *opaque, hwaddr offset,
+                                        unsigned size)
+{
+    return pl011_read(opaque, offset & 0xfff, size);
+}
+
+static void pl011_atomic_alias_write(void *opaque, hwaddr offset,
+                                     uint64_t value, unsigned size)
+{
+    hwaddr alias = (offset + PL011_ATOMIC_XOR) & PL011_ATOMIC_ALIAS_MASK;
+    hwaddr reg = offset & 0xfff;
+    uint32_t old = pl011_read(opaque, reg, size);
+    uint32_t new = pl011_apply_atomic_alias(old, value, alias);
+
+    pl011_write(opaque, reg, new, size);
+}
+
 static void pl011_clock_update(void *opaque, ClockEvent event)
 {
     PL011State *s = PL011(opaque);
@@ -585,6 +653,14 @@ static const MemoryRegionOps pl011_ops = {
     .impl.max_access_size = 4,
 };
 
+static const MemoryRegionOps pl011_atomic_alias_ops = {
+    .read = pl011_atomic_alias_read,
+    .write = pl011_atomic_alias_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+};
+
 static bool pl011_clock_needed(void *opaque)
 {
     PL011State *s = PL011(opaque);
@@ -673,8 +749,14 @@ static void pl011_init(Object *obj)
     PL011State *s = PL011(obj);
     int i;
 
+    s->tx_connected = true;
+    s->rx_connected = true;
     memory_region_init_io(&s->iomem, OBJECT(s), &pl011_ops, s, "pl011", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
+    memory_region_init_io(&s->atomic_alias_iomem, OBJECT(s),
+                          &pl011_atomic_alias_ops, s,
+                          "pl011-atomic-alias", 0x3000);
+    sysbus_init_mmio(sbd, &s->atomic_alias_iomem);
     for (i = 0; i < ARRAY_SIZE(s->irq); i++) {
         sysbus_init_irq(sbd, &s->irq[i]);
     }
diff --git a/include/hw/arm/rp2040.h b/include/hw/arm/rp2040.h
index fdfcf28f3b..6beb4cafff 100644
--- a/include/hw/arm/rp2040.h
+++ b/include/hw/arm/rp2040.h
@@ -77,6 +77,11 @@ struct RP2040State {
     qemu_irq cpu_irq[RP2040_NUM_CORES][RP2040_NUM_IRQS];
     qemu_irq nmi_irq[RP2040_NUM_CORES];
     bool irq_level[RP2040_NUM_IRQS];
+    bool strict_uart_pins;
+    bool uart0_tx_pin_enabled;
+    bool uart0_rx_pin_enabled;
+    bool uart1_tx_pin_enabled;
+    bool uart1_rx_pin_enabled;
 
     Clock *sysclk;
 };
diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
index c7b5a3a2b3..20c0b5694b 100644
--- a/include/hw/char/pl011.h
+++ b/include/hw/char/pl011.h
@@ -32,6 +32,7 @@ struct PL011State {
     SysBusDevice parent_obj;
 
     MemoryRegion iomem;
+    MemoryRegion atomic_alias_iomem;
     uint32_t flags;
     uint32_t lcr;
     uint32_t rsr;
@@ -53,7 +54,10 @@ struct PL011State {
     qemu_irq dreq_rx;
     Clock *clk;
     bool migrate_clk;
+    bool tx_connected;
+    bool rx_connected;
     bool logged_disabled_uart;
+    bool logged_disconnected_tx;
     const unsigned char *id;
     /*
      * Since some users embed this struct directly, we must
@@ -63,5 +67,7 @@ struct PL011State {
 };
 
 DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr);
+void pl011_set_tx_connected(PL011State *s, bool connected);
+void pl011_set_rx_connected(PL011State *s, bool connected);
 
 #endif
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 8009ec7f8d..dee90c57c8 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -272,6 +272,7 @@ qtests_arm = \
     'rp2040-resets-test',
     'rp2040-rosc-test',
     'rp2040-tbman-test',
+    'rp2040-uart-test',
     'rp2040-vreg-test',
     'rp2040-watchdog-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4x5 : []) + \
diff --git a/tests/qtest/rp2040-uart-test.c b/tests/qtest/rp2040-uart-test.c
new file mode 100644
index 0000000000..05d2f3c763
--- /dev/null
+++ b/tests/qtest/rp2040-uart-test.c
@@ -0,0 +1,139 @@
+/*
+ * QTest testcase for the RP2040 UART pinmux integration.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "hw/misc/rp2040.h"
+
+#define IOBANK0_BASE  0x40014000
+#define GPIO_CTRL(n)  (0x004 + (n) * 8)
+#define GPIO_FUNC_UART 2
+
+#define UART0_BASE 0x40034000
+#define UART1_BASE 0x40038000
+#define UART_DR     0x000
+#define UART_FR     0x018
+#define UART_CR     0x030
+#define UART_FR_RXFE 0x10
+
+static char *new_output_path(void)
+{
+    int fd;
+    char *path = NULL;
+
+    fd = g_file_open_tmp("rp2040-uart-XXXXXX", &path, NULL);
+    g_assert_cmpint(fd, >=, 0);
+    close(fd);
+    return path;
+}
+
+static void assert_file_contents(const char *path, const char *expected)
+{
+    g_autofree char *contents = NULL;
+    gsize length;
+
+    g_assert_true(g_file_get_contents(path, &contents, &length, NULL));
+    g_assert_cmpuint(length, ==, strlen(expected));
+    g_assert_cmpmem(contents, length, expected, strlen(expected));
+}
+
+static void test_uart0_pinmux(void)
+{
+    g_autofree char *path = new_output_path();
+    QTestState *qts = qtest_initf("-machine raspi-pico "
+                                  "-chardev file,id=uart0,path=%s "
+                                  "-serial chardev:uart0", path);
+
+    qtest_writel(qts, UART0_BASE + UART_DR, 'X');
+    qtest_writel(qts, IOBANK0_BASE + GPIO_CTRL(0), GPIO_FUNC_UART);
+    qtest_writel(qts, UART0_BASE + UART_DR, '0');
+    qtest_quit(qts);
+
+    assert_file_contents(path, "0");
+    unlink(path);
+}
+
+static void test_uart1_pinmux(void)
+{
+    g_autofree char *path = new_output_path();
+    QTestState *qts = qtest_initf("-machine raspi-pico -serial null "
+                                  "-chardev file,id=uart1,path=%s "
+                                  "-serial chardev:uart1", path);
+
+    qtest_writel(qts, UART1_BASE + UART_DR, 'X');
+    qtest_writel(qts, IOBANK0_BASE + GPIO_CTRL(4), GPIO_FUNC_UART);
+    qtest_writel(qts, UART1_BASE + UART_DR, '1');
+    qtest_quit(qts);
+
+    assert_file_contents(path, "1");
+    unlink(path);
+}
+
+static void test_non_strict_uart_pins(void)
+{
+    g_autofree char *path = new_output_path();
+    QTestState *qts = qtest_initf("-machine raspi-pico,strict-uart-pins=off "
+                                  "-chardev file,id=uart0,path=%s "
+                                  "-serial chardev:uart0", path);
+
+    qtest_writel(qts, UART0_BASE + UART_DR, 'L');
+    qtest_quit(qts);
+
+    assert_file_contents(path, "L");
+    unlink(path);
+}
+
+static void test_uart0_rx_pinmux(void)
+{
+    int sock_fd;
+    int retries;
+    QTestState *qts = qtest_init_with_serial("-machine raspi-pico",
+                                             &sock_fd);
+
+    qtest_writel(qts, IOBANK0_BASE + GPIO_CTRL(1), GPIO_FUNC_UART);
+    g_assert_cmpint(send(sock_fd, "R", 1, 0), ==, 1);
+    for (retries = 0; retries < 1000; retries++) {
+        if (!(qtest_readl(qts, UART0_BASE + UART_FR) & UART_FR_RXFE)) {
+            break;
+        }
+        g_usleep(1000);
+    }
+    g_assert_cmpint(retries, <, 1000);
+    g_assert_cmphex(qtest_readl(qts, UART0_BASE + UART_DR), ==, 'R');
+
+    close(sock_fd);
+    qtest_quit(qts);
+}
+
+static void test_atomic_aliases(void)
+{
+    QTestState *qts = qtest_init("-machine raspi-pico");
+    uint32_t reset = qtest_readl(qts, UART0_BASE + UART_CR);
+
+    qtest_writel(qts, UART0_BASE + RP2040_ATOMIC_CLR + UART_CR, 0x100);
+    g_assert_cmphex(qtest_readl(qts, UART0_BASE + UART_CR), ==,
+                    reset & ~0x100);
+    qtest_writel(qts, UART0_BASE + RP2040_ATOMIC_SET + UART_CR, 0x100);
+    g_assert_cmphex(qtest_readl(qts, UART0_BASE + UART_CR), ==, reset);
+    qtest_writel(qts, UART0_BASE + RP2040_ATOMIC_XOR + UART_CR, 0x200);
+    g_assert_cmphex(qtest_readl(qts, UART0_BASE + UART_CR), ==,
+                    reset ^ 0x200);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/rp2040-uart/uart0-pinmux", test_uart0_pinmux);
+    qtest_add_func("/rp2040-uart/uart1-pinmux", test_uart1_pinmux);
+    qtest_add_func("/rp2040-uart/non-strict", test_non_strict_uart_pins);
+    qtest_add_func("/rp2040-uart/uart0-rx-pinmux", test_uart0_rx_pinmux);
+    qtest_add_func("/rp2040-uart/atomic-aliases", test_atomic_aliases);
+
+    return g_test_run();
+}
diff --git a/tests/tcg/arm/system/rp2040-mpu.S b/tests/tcg/arm/system/rp2040-mpu.S
index 5cc98f3d0e..60fa1292e6 100644
--- a/tests/tcg/arm/system/rp2040-mpu.S
+++ b/tests/tcg/arm/system/rp2040-mpu.S
@@ -13,6 +13,8 @@
 #define TEST_ADDRESS 0x20001000
 #define TEST_VALUE 0x12345678
 #define UART0_DR 0x40034000
+#define GPIO0_CTRL 0x40014004
+#define GPIO_FUNC_UART 2
 #define MPU_TYPE 0xe000ed90
 #define MPU_CTRL 0xe000ed94
 #define MPU_RNR 0xe000ed98
@@ -42,6 +44,9 @@ vector_table:
 .thumb_func
 .global reset_handler
 reset_handler:
+    ldr r0, =GPIO0_CTRL
+    movs r1, GPIO_FUNC_UART
+    str r1, [r0]
     ldr r0, =start_message
     bl puts
 
diff --git a/tests/tcg/arm/system/rp2040-uart.S b/tests/tcg/arm/system/rp2040-uart.S
index bdb58cc7f2..6058699200 100644
--- a/tests/tcg/arm/system/rp2040-uart.S
+++ b/tests/tcg/arm/system/rp2040-uart.S
@@ -11,6 +11,8 @@
 
 #define SRAM_END 0x20042000
 #define UART0_DR 0x40034000
+#define GPIO0_CTRL 0x40014004
+#define GPIO_FUNC_UART 2
 #define SYS_EXIT 0x18
 #define ADP_STOPPED_APPLICATION_EXIT 0x20026
 
@@ -25,6 +27,9 @@ vector_table:
 .thumb_func
 .global reset_handler
 reset_handler:
+    ldr r0, =GPIO0_CTRL
+    movs r1, GPIO_FUNC_UART
+    str r1, [r0]
     ldr r0, =UART0_DR
     ldr r1, =message
 
-- 
2.55.0


