Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5CDC79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3WUJ-00085z-Nz; Mon, 07 Sep 2026 06:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3WUH-00083r-F6; Mon, 07 Sep 2026 06:22:05 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3WUF-00026k-Ez; Mon, 07 Sep 2026 06:22:05 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4hdjlt4BJ9z83Yc;
 Mon,  7 Sep 2026 12:21:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788776490;
 bh=8jgUyOJWeE4yIYKvLmnqvK4Juj9Um97Fa/tpeKxGvuo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ymdG1kwb9GSxgGFUiSlThog6vJi4wfxIjrYmiMTmluyPEd92UE3+SWGQ7m5GcqKkY
 PGbHV0Jt6tk275++9mcIL5soEpDSGwxvQBrXQ6Xuy9Bs25Ob2uKzgtduCw4SeZR4Hn
 v/DSkuDMhR5vxFpS24q4p0Oz9xqlbZuTj7Ia9HxZy8xiHXPF/SrMFtWrsfKsIboSDs
 +yU29u/UsBupUKMvtxnhK91jKetSPvzYjgovMPQjxlaLuVL92EB+FFjVKhQFmNdJZ5
 ORfJ5evkwF4WyLuowDRlbOUKNvjeB5ZQWuTRSwPPP9shmUHpcRcZa94kOiFjB88I0r
 kKI2ZU2SLunyw==
Received: from localhost.localdomain (unknown [134.206.232.123])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hdjlt2VTnz7wpD;
 Mon,  7 Sep 2026 12:21:30 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 Gilles Grimaud <gilles.grimaud@univ-lille.fr>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 35/36] hw/arm: route RP2040 banked interrupts per core
Date: Mon,  7 Sep 2026 12:21:27 +0200
Message-ID: <20260907102128.55676-5-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907102128.55676-1-gilles.grimaud@univ-lille.fr>
References: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
 <20260907102128.55676-1-gilles.grimaud@univ-lille.fr>
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

IO_BANK0, IO_QSPI and SIO expose interrupt state separately for each
processor. Preserve that distinction in the SoC instead of feeding the
banked outputs through the shared interrupt path.

Add the missing IO_QSPI outputs and exercise both processor interrupt lines
in qtest. Keep all banked sources behind the per-core SYSCFG NMI routing.

Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/arm/rp2040.c                  | 42 ++++++++++++++++++++++++++------
 hw/misc/rp2040_ioqspi.c          | 18 ++++++++++++++
 include/hw/arm/rp2040.h          |  3 ++-
 include/hw/misc/rp2040_ioqspi.h  |  2 ++
 tests/qtest/rp2040-ioqspi-test.c | 22 +++++++++++++++++
 5 files changed, 79 insertions(+), 8 deletions(-)

diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
index 572fff0c7d..b093ad32f1 100644
--- a/hw/arm/rp2040.c
+++ b/hw/arm/rp2040.c
@@ -34,6 +34,7 @@
 #define RP2040_DMA_IRQ_0  11
 #define RP2040_DMA_IRQ_1  12
 #define RP2040_IO_IRQ_BANK0 13
+#define RP2040_IO_IRQ_QSPI 14
 #define RP2040_SIO_IRQ_PROC0 15
 #define RP2040_SIO_IRQ_PROC1 16
 
@@ -1474,8 +1475,8 @@ static void rp2040_update_nmi(RP2040State *s)
             bool route_to_nmi = nmi_mask & BIT(irq);
 
             qemu_set_irq(s->cpu_irq[core][irq],
-                         s->irq_level[irq] && !route_to_nmi);
-            nmi_level |= s->irq_level[irq] && route_to_nmi;
+                         s->irq_level[core][irq] && !route_to_nmi);
+            nmi_level |= s->irq_level[core][irq] && route_to_nmi;
         }
         qemu_set_irq(s->nmi_irq[core], nmi_level);
     }
@@ -1491,7 +1492,26 @@ static void rp2040_set_irq(void *opaque, int irq, int level)
     RP2040State *s = opaque;
 
     assert(irq >= 0 && irq < RP2040_NUM_IRQS);
-    s->irq_level[irq] = level;
+    s->irq_level[0][irq] = level;
+    s->irq_level[1][irq] = level;
+    rp2040_update_nmi(s);
+}
+
+static void rp2040_set_core0_irq(void *opaque, int irq, int level)
+{
+    RP2040State *s = opaque;
+
+    assert(irq >= 0 && irq < RP2040_NUM_IRQS);
+    s->irq_level[0][irq] = level;
+    rp2040_update_nmi(s);
+}
+
+static void rp2040_set_core1_irq(void *opaque, int irq, int level)
+{
+    RP2040State *s = opaque;
+
+    assert(irq >= 0 && irq < RP2040_NUM_IRQS);
+    s->irq_level[1][irq] = level;
     rp2040_update_nmi(s);
 }
 
@@ -1671,6 +1691,10 @@ static void rp2040_soc_init(Object *obj)
     object_initialize_child(obj, "xosc", &s->xosc, TYPE_RP2040_XOSC);
 
     s->irq = qemu_allocate_irqs(rp2040_set_irq, s, RP2040_NUM_IRQS);
+    s->core_irq[0] = qemu_allocate_irqs(rp2040_set_core0_irq, s,
+                                        RP2040_NUM_IRQS);
+    s->core_irq[1] = qemu_allocate_irqs(rp2040_set_core1_irq, s,
+                                        RP2040_NUM_IRQS);
 
     s->sysclk = clock_new(obj, "sysclk");
 }
@@ -1882,7 +1906,7 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sio), 0, RP2040_SIO_BASE);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sio), 0,
-                       s->irq[RP2040_SIO_IRQ_PROC0]);
+                       s->core_irq[0][RP2040_SIO_IRQ_PROC0]);
 
     for (i = 0; i < RP2040_NUM_CORES; i++) {
         g_autofree char *memory_name =
@@ -1938,9 +1962,9 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->iobank0), 0, RP2040_IOBANK0_BASE);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->iobank0), 0,
-                       s->irq[RP2040_IO_IRQ_BANK0]);
+                       s->core_irq[0][RP2040_IO_IRQ_BANK0]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->iobank0), 1,
-                       s->cpu_irq[RP2040_PROC1][RP2040_IO_IRQ_BANK0]);
+                       s->core_irq[1][RP2040_IO_IRQ_BANK0]);
     qdev_connect_gpio_out_named(DEVICE(&s->iobank0), "uart0-pin", 0,
                                 qdev_get_gpio_in_named(dev, "uart-pin", 0));
     qdev_connect_gpio_out_named(DEVICE(&s->iobank0), "uart0-pin", 1,
@@ -1950,7 +1974,7 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
     qdev_connect_gpio_out_named(DEVICE(&s->iobank0), "uart1-pin", 1,
                                 qdev_get_gpio_in_named(dev, "uart-pin", 3));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sio), 1,
-                       s->cpu_irq[RP2040_PROC1][RP2040_SIO_IRQ_PROC1]);
+                       s->core_irq[1][RP2040_SIO_IRQ_PROC1]);
 
     object_property_set_link(OBJECT(&s->ioqspi), "xip", OBJECT(&s->xip),
                              &err);
@@ -1962,6 +1986,10 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ioqspi), 0, RP2040_IOQSPI_BASE);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->ioqspi), 0,
+                       s->core_irq[0][RP2040_IO_IRQ_QSPI]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->ioqspi), 1,
+                       s->core_irq[1][RP2040_IO_IRQ_QSPI]);
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->rosc), errp)) {
         return;
diff --git a/hw/misc/rp2040_ioqspi.c b/hw/misc/rp2040_ioqspi.c
index d8fd98934c..59ff24e32b 100644
--- a/hw/misc/rp2040_ioqspi.c
+++ b/hw/misc/rp2040_ioqspi.c
@@ -54,6 +54,16 @@ static uint32_t rp2040_ioqspi_ints(uint32_t intr, uint32_t inte,
     return (intr & inte) | intf;
 }
 
+static void rp2040_ioqspi_update_irq(RP2040IoQspiState *s)
+{
+    qemu_set_irq(s->proc0_irq,
+                 rp2040_ioqspi_ints(s->intr, s->proc0_inte,
+                                    s->proc0_intf) != 0);
+    qemu_set_irq(s->proc1_irq,
+                 rp2040_ioqspi_ints(s->intr, s->proc1_inte,
+                                    s->proc1_intf) != 0);
+}
+
 static void rp2040_ioqspi_update_ss(RP2040IoQspiState *s)
 {
     uint32_t outover;
@@ -148,26 +158,31 @@ static void rp2040_ioqspi_write(void *opaque, hwaddr addr,
         switch (offset) {
         case IOQSPI_INTR:
             s->intr &= ~(value & IOQSPI_INTR_EDGE_MASK);
+            rp2040_ioqspi_update_irq(s);
             break;
         case IOQSPI_PROC0_INTE:
             s->proc0_inte =
                 rp2040_atomic_update(s->proc0_inte, value, alias) &
                 IOQSPI_IRQ_MASK;
+            rp2040_ioqspi_update_irq(s);
             break;
         case IOQSPI_PROC0_INTF:
             s->proc0_intf =
                 rp2040_atomic_update(s->proc0_intf, value, alias) &
                 IOQSPI_IRQ_MASK;
+            rp2040_ioqspi_update_irq(s);
             break;
         case IOQSPI_PROC1_INTE:
             s->proc1_inte =
                 rp2040_atomic_update(s->proc1_inte, value, alias) &
                 IOQSPI_IRQ_MASK;
+            rp2040_ioqspi_update_irq(s);
             break;
         case IOQSPI_PROC1_INTF:
             s->proc1_intf =
                 rp2040_atomic_update(s->proc1_intf, value, alias) &
                 IOQSPI_IRQ_MASK;
+            rp2040_ioqspi_update_irq(s);
             break;
         case IOQSPI_DORMANT_INTE:
             s->dormant_wake_inte =
@@ -222,6 +237,7 @@ static void rp2040_ioqspi_reset(DeviceState *dev)
     s->proc1_intf = 0;
     s->dormant_wake_inte = 0;
     s->dormant_wake_intf = 0;
+    rp2040_ioqspi_update_irq(s);
 }
 
 static void rp2040_ioqspi_init(Object *obj)
@@ -231,6 +247,8 @@ static void rp2040_ioqspi_init(Object *obj)
     memory_region_init_io(&s->iomem, obj, &rp2040_ioqspi_ops, s,
                           "rp2040.ioqspi", RP2040_IOQSPI_SIZE);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->proc0_irq);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->proc1_irq);
 }
 
 static const VMStateDescription rp2040_ioqspi_vmstate = {
diff --git a/include/hw/arm/rp2040.h b/include/hw/arm/rp2040.h
index 498d36dd5c..2d9a0abc88 100644
--- a/include/hw/arm/rp2040.h
+++ b/include/hw/arm/rp2040.h
@@ -103,9 +103,10 @@ struct RP2040State {
     char *bootrom_file;
 
     qemu_irq *irq;
+    qemu_irq *core_irq[RP2040_NUM_CORES];
     qemu_irq cpu_irq[RP2040_NUM_CORES][RP2040_NUM_IRQS];
     qemu_irq nmi_irq[RP2040_NUM_CORES];
-    bool irq_level[RP2040_NUM_IRQS];
+    bool irq_level[RP2040_NUM_CORES][RP2040_NUM_IRQS];
     bool strict_uart_pins;
     bool uart0_tx_pin_enabled;
     bool uart0_rx_pin_enabled;
diff --git a/include/hw/misc/rp2040_ioqspi.h b/include/hw/misc/rp2040_ioqspi.h
index eae63588e6..0ab8acfbf0 100644
--- a/include/hw/misc/rp2040_ioqspi.h
+++ b/include/hw/misc/rp2040_ioqspi.h
@@ -30,6 +30,8 @@ struct RP2040IoQspiState {
     uint32_t proc1_intf;
     uint32_t dormant_wake_inte;
     uint32_t dormant_wake_intf;
+    qemu_irq proc0_irq;
+    qemu_irq proc1_irq;
     RP2040XipState *xip;
 };
 
diff --git a/tests/qtest/rp2040-ioqspi-test.c b/tests/qtest/rp2040-ioqspi-test.c
index 4f94b5f3a2..31dd85686f 100644
--- a/tests/qtest/rp2040-ioqspi-test.c
+++ b/tests/qtest/rp2040-ioqspi-test.c
@@ -15,6 +15,8 @@
 #define IOQSPI_PROC0_INTE       0x34
 #define IOQSPI_PROC0_INTF       0x38
 #define IOQSPI_PROC0_INTS       0x3c
+#define IOQSPI_PROC1_INTF       0x44
+#define IOQSPI_PROC1_INTS       0x48
 
 #define IOQSPI_CTRL_RESET       0x1f
 #define IOQSPI_SD1_CTRL_SET     0x201c
@@ -58,11 +60,31 @@ static void test_ioqspi_interrupt_force_status(void)
 {
     QTestState *qts = rp2040_start();
 
+    qtest_irq_intercept_in(qts, "/machine/soc/proc0");
+    g_assert_false(qtest_get_irq(qts, 14));
+
     qtest_writel(qts, IOQSPI_BASE + IOQSPI_PROC0_INTE, BIT(1));
     qtest_writel(qts, IOQSPI_BASE + IOQSPI_PROC0_INTF, BIT(2));
 
     g_assert_cmphex(qtest_readl(qts, IOQSPI_BASE + IOQSPI_PROC0_INTS), ==,
                     BIT(2));
+    g_assert_true(qtest_get_irq(qts, 14));
+    qtest_writel(qts, IOQSPI_BASE + IOQSPI_PROC0_INTF + 0x3000, BIT(2));
+    g_assert_false(qtest_get_irq(qts, 14));
+
+    qtest_quit(qts);
+    qts = rp2040_start();
+
+    qtest_irq_intercept_in(qts, "/machine/soc/proc1");
+    g_assert_false(qtest_get_irq(qts, 14));
+
+    qtest_writel(qts, IOQSPI_BASE + IOQSPI_PROC1_INTF, BIT(3));
+    g_assert_cmphex(qtest_readl(qts, IOQSPI_BASE + IOQSPI_PROC1_INTS), ==,
+                    BIT(3));
+    g_assert_true(qtest_get_irq(qts, 14));
+
+    qtest_writel(qts, IOQSPI_BASE + IOQSPI_PROC1_INTF + 0x3000, BIT(3));
+    g_assert_false(qtest_get_irq(qts, 14));
 
     qtest_quit(qts);
 }
-- 
2.55.0


