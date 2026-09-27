Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF7E606A330
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRX51-0007K9-Dc; Thu, 12 Nov 2026 10:51:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1xRWKj-0005hX-Fp; Thu, 12 Nov 2026 10:03:30 -0500
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1xRWKb-0004Od-6b; Thu, 12 Nov 2026 10:03:23 -0500
DKIM-Signature: a=rsa-sha256; bh=p4IDh++u1IHDGi4mN9UnqfLBDP9tCK96z1YOsWsrgbU=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1794495790; v=1;
 b=moBKQQe8+knR7JkOuPqL2p/PejITV2lSMU1TAMBz06NNgr7Xsxgw41uGtfVWS1r/u5/PX/f2
 nvzCWyqXqX8A/pqHgpmaG32wOk6fAnEqjkM5Qd2RuKeRR7dOuGH7BR55ltvTpYpIDQZFS0JDPDz
 hlu5i5GGZ+ZFcpIypcymr1SxQHsfnflVNmUNA6yrZNDMQy3eryLkR2jRdKwrhLXhDoV/2DlroIy
 yjaZ6Z/XOEBwSfDvqPnua4XYiKTkfBIJYyaOjoZPxbYf7NLs70l5LJ6I7cZlTrk1FNE9EjeSMG/
 LXlvDI+davvcDEt4aQ/+IGrN5CpyILIOym5MmpOfYvJbw==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 4349B22F0D;
 Thu, 12 Nov 2026 15:03:10 +0000 (UTC)
From: ~mohammadodeh <mohammadodeh@git.sr.ht>
Date: Sun, 27 Sep 2026 10:09:50 +0300
Subject: [PATCH qemu 2/3] hw/ssi: Add STM32L4x5 QuadSPI controller
Message-ID: <179449578952.8382.2790865629085512841-2@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <179449578952.8382.2790865629085512841-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Samuel Tardieu <sam@rfc1149.net>, Alistair Francis <alistair@alistair23.me>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 Jan Kiszka <jan.kiszka@web.de>, Bin Meng <bin.meng@processmission.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 12 Nov 2026 10:51:09 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: ~mohammadodeh <Mohammad.Odeh@exalt.ps>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mohammad Odeh <mohammad.odeh@exalt.ps>

Model the STM32L4x5 QuadSPI controller indirect read and write modes.
Wire its clock, interrupt, and SSI bus into the STM32L4x5 SoC.

Automatic polling, memory-mapped mode, and DMA are not implemented.

Signed-off-by: Mohammad Odeh <zephyr@exalt.ps>
---
 MAINTAINERS                        |   1 +
 hw/arm/Kconfig                     |   1 +
 hw/arm/stm32l4x5_soc.c             |  17 +
 hw/ssi/Kconfig                     |   4 +
 hw/ssi/meson.build                 |   1 +
 hw/ssi/stm32l4x5_quadspi.c         | 680 +++++++++++++++++++++++++++++
 include/hw/arm/stm32l4x5_soc.h     |   2 +
 include/hw/ssi/stm32l4x5_quadspi.h |  51 +++
 8 files changed, 757 insertions(+)
 create mode 100644 hw/ssi/stm32l4x5_quadspi.c
 create mode 100644 include/hw/ssi/stm32l4x5_quadspi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index fa0c6d0c9b..7a820703f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1119,6 +1119,7 @@ F: hw/misc/stm32l4x5_exti.c
 F: hw/misc/stm32l4x5_syscfg.c
 F: hw/misc/stm32l4x5_rcc.c
 F: hw/gpio/stm32l4x5_gpio.c
+F: hw/ssi/stm32l4x5_quadspi.c
 F: include/hw/*/stm32l4x5_*.h
 F: tests/qtest/stm32l4x5*
=20
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index e9f796f718..94a01c412b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -398,6 +398,7 @@ config STM32L4X5_SOC
     select STM32L4X5_RCC
     select STM32L4X5_GPIO
     select STM32L4X5_USART
+    select STM32L4X5_QUADSPI
=20
 config XLNX_ZYNQMP_ARM
     bool
diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
index 39b8cdf97d..d91d18e88b 100644
--- a/hw/arm/stm32l4x5_soc.c
+++ b/hw/arm/stm32l4x5_soc.c
@@ -81,6 +81,9 @@ static const int exti_irq[NUM_EXTI_IRQ] =3D {
 #define RCC_BASE_ADDRESS 0x40021000
 #define RCC_IRQ 5
=20
+#define QUADSPI_BASE_ADDRESS 0xa0001000
+#define QUADSPI_IRQ 71
+
 #define EXTI_USART1_IRQ 26
 #define EXTI_UART4_IRQ 29
 #define EXTI_LPUART1_IRQ 31
@@ -144,6 +147,8 @@ static void stm32l4x5_soc_initfn(Object *obj)
     }
     object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_STM32L4X5_SYSCFG=
);
     object_initialize_child(obj, "rcc", &s->rcc, TYPE_STM32L4X5_RCC);
+    object_initialize_child(obj, "quadspi", &s->quadspi,
+                            TYPE_STM32L4X5_QUADSPI);
=20
     for (unsigned i =3D 0; i < NUM_GPIOS; i++) {
         g_autofree char *name =3D g_strdup_printf("gpio%c", 'a' + i);
@@ -313,6 +318,18 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, =
Error **errp)
     sysbus_mmio_map(busdev, 0, RCC_BASE_ADDRESS);
     sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, RCC_IRQ));
=20
+    /* QuadSPI controller */
+    dev =3D DEVICE(&s->quadspi);
+    qdev_connect_clock_in(dev, "clk",
+        qdev_get_clock_out(DEVICE(&s->rcc), "qspi-out"));
+    busdev =3D SYS_BUS_DEVICE(dev);
+    if (!sysbus_realize(busdev, errp)) {
+        return;
+    }
+    sysbus_mmio_map(busdev, 0, QUADSPI_BASE_ADDRESS);
+    sysbus_connect_irq(busdev, 0,
+                       qdev_get_gpio_in(armv7m, QUADSPI_IRQ));
+
     /* USART devices */
     for (int i =3D 0; i < STM_NUM_USARTS; i++) {
         g_autofree char *name =3D g_strdup_printf("usart%d-out", i + 1);
diff --git a/hw/ssi/Kconfig b/hw/ssi/Kconfig
index d477d20e9b..1b79da6d90 100644
--- a/hw/ssi/Kconfig
+++ b/hw/ssi/Kconfig
@@ -21,6 +21,10 @@ config STM32F2XX_SPI
     bool
     select SSI
=20
+config STM32L4X5_QUADSPI
+    bool
+    select SSI
+
 config BCM2835_SPI
     bool
     select SSI
diff --git a/hw/ssi/meson.build b/hw/ssi/meson.build
index f334e48e2f..ce9511b5df 100644
--- a/hw/ssi/meson.build
+++ b/hw/ssi/meson.build
@@ -6,6 +6,7 @@ system_ss.add(when: 'CONFIG_PL022', if_true: files('pl022.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_SPI', if_true: files('sifive_spi.c'))
 system_ss.add(when: 'CONFIG_SSI', if_true: files('ssi.c'))
 system_ss.add(when: 'CONFIG_STM32F2XX_SPI', if_true: files('stm32f2xx_spi.c'=
))
+system_ss.add(when: 'CONFIG_STM32L4X5_QUADSPI', if_true: files('stm32l4x5_qu=
adspi.c'))
 system_ss.add(when: 'CONFIG_XILINX_SPI', if_true: files('xilinx_spi.c'))
 system_ss.add(when: 'CONFIG_XILINX_SPIPS', if_true: files('xilinx_spips.c'))
 system_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal-ospi.c=
'))
diff --git a/hw/ssi/stm32l4x5_quadspi.c b/hw/ssi/stm32l4x5_quadspi.c
new file mode 100644
index 0000000000..cb3e7eb665
--- /dev/null
+++ b/hw/ssi/stm32l4x5_quadspi.c
@@ -0,0 +1,680 @@
+/*
+ * STM32L4x5 QuadSPI controller
+ *
+ * Copyright (c) 2026 EXALT Technologies
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+/*
+ * The reference used is the STMicroelectronics RM0351 reference manual for
+ * STM32L47xxx, STM32L48xxx, STM32L49xxx and STM32L4Axxx MCUs.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/core/qdev-clock.h"
+#include "hw/core/irq.h"
+#include "hw/ssi/stm32l4x5_quadspi.h"
+#include "migration/vmstate.h"
+
+#define QUADSPI_MMIO_SIZE 0x400
+#define QUADSPI_FIFO_SIZE 16
+
+#define QUADSPI_CR    0x00
+#define QUADSPI_DCR   0x04
+#define QUADSPI_SR    0x08
+#define QUADSPI_FCR   0x0c
+#define QUADSPI_DLR   0x10
+#define QUADSPI_CCR   0x14
+#define QUADSPI_AR    0x18
+#define QUADSPI_ABR   0x1c
+#define QUADSPI_DR    0x20
+#define QUADSPI_PSMKR 0x24
+#define QUADSPI_PSMAR 0x28
+#define QUADSPI_PIR   0x2c
+#define QUADSPI_LPTR  0x30
+
+#define CR_EN       BIT(0)
+#define CR_ABORT    BIT(1)
+#define CR_DFM      BIT(6)
+#define CR_FTHRES_SHIFT 8
+#define CR_FTHRES   MAKE_64BIT_MASK(8, 4)
+#define CR_TEIE     BIT(16)
+#define CR_TCIE     BIT(17)
+#define CR_FTIE     BIT(18)
+#define CR_SMIE     BIT(19)
+#define CR_TOIE     BIT(20)
+
+#define SR_TEF      BIT(0)
+#define SR_TCF      BIT(1)
+#define SR_FTF      BIT(2)
+#define SR_SMF      BIT(3)
+#define SR_TOF      BIT(4)
+#define SR_BUSY     BIT(5)
+#define SR_FLEVEL   MAKE_64BIT_MASK(8, 5)
+#define SR_FLEVEL_SHIFT 8
+
+#define CCR_INSTRUCTION MAKE_64BIT_MASK(0, 8)
+#define CCR_IMODE       MAKE_64BIT_MASK(8, 2)
+#define CCR_ADMODE      MAKE_64BIT_MASK(10, 2)
+#define CCR_ADSIZE      MAKE_64BIT_MASK(12, 2)
+#define CCR_ABMODE      MAKE_64BIT_MASK(14, 2)
+#define CCR_ABSIZE      MAKE_64BIT_MASK(16, 2)
+#define CCR_DCYC        MAKE_64BIT_MASK(18, 5)
+#define CCR_DMODE       MAKE_64BIT_MASK(24, 2)
+#define CCR_FMODE       MAKE_64BIT_MASK(26, 2)
+#define CCR_SIOO        BIT(28)
+#define CCR_DDRM        BIT(31)
+
+#define CCR_IMODE_SHIFT 8
+#define CCR_ADMODE_SHIFT 10
+#define CCR_ADSIZE_SHIFT 12
+#define CCR_ABMODE_SHIFT 14
+#define CCR_ABSIZE_SHIFT 16
+#define CCR_DCYC_SHIFT 18
+#define CCR_DMODE_SHIFT 24
+#define CCR_FMODE_SHIFT 26
+
+enum QuadSpiFunctionalMode {
+    QUADSPI_INDIRECT_WRITE,
+    QUADSPI_INDIRECT_READ,
+    QUADSPI_AUTO_POLLING,
+    QUADSPI_MEMORY_MAPPED,
+};
+
+static unsigned int stm32l4x5_quadspi_mode_width(uint32_t mode)
+{
+    static const unsigned int widths[] =3D { 0, 1, 2, 4 };
+
+    return widths[mode & 3];
+}
+
+static unsigned int stm32l4x5_quadspi_fmode(Stm32l4x5QuadSpiState *s)
+{
+    return (s->ccr & CCR_FMODE) >> CCR_FMODE_SHIFT;
+}
+
+static void stm32l4x5_quadspi_update_irq(Stm32l4x5QuadSpiState *s)
+{
+    bool level =3D ((s->sr & SR_TEF) && (s->cr & CR_TEIE)) ||
+                 ((s->sr & SR_TCF) && (s->cr & CR_TCIE)) ||
+                 ((s->sr & SR_FTF) && (s->cr & CR_FTIE)) ||
+                 ((s->sr & SR_SMF) && (s->cr & CR_SMIE)) ||
+                 ((s->sr & SR_TOF) && (s->cr & CR_TOIE));
+
+    qemu_set_irq(s->irq, level);
+}
+
+static void stm32l4x5_quadspi_update_fifo(Stm32l4x5QuadSpiState *s)
+{
+    unsigned int level =3D fifo8_num_used(&s->fifo);
+    unsigned int threshold =3D ((s->cr & CR_FTHRES) >> CR_FTHRES_SHIFT) + 1;
+    unsigned int mode =3D stm32l4x5_quadspi_fmode(s);
+
+    s->sr &=3D ~(SR_FLEVEL | SR_FTF | SR_BUSY);
+    s->sr |=3D level << SR_FLEVEL_SHIFT;
+    if (s->transaction_active ||
+        (mode =3D=3D QUADSPI_INDIRECT_READ && level)) {
+        s->sr |=3D SR_BUSY;
+    }
+    if (s->cr & CR_EN) {
+        if (mode =3D=3D QUADSPI_INDIRECT_READ &&
+            (level >=3D threshold ||
+             (!s->remaining && !s->indefinite && level))) {
+            s->sr |=3D SR_FTF;
+        } else if (mode =3D=3D QUADSPI_INDIRECT_WRITE &&
+                   fifo8_num_free(&s->fifo) >=3D threshold) {
+            s->sr |=3D SR_FTF;
+        }
+    }
+    stm32l4x5_quadspi_update_irq(s);
+}
+
+static void stm32l4x5_quadspi_select(Stm32l4x5QuadSpiState *s)
+{
+    if (!s->transaction_active) {
+        qemu_set_irq(s->cs, 0);
+        s->transaction_active =3D true;
+        s->sr |=3D SR_BUSY;
+    }
+}
+
+static void stm32l4x5_quadspi_deselect(Stm32l4x5QuadSpiState *s)
+{
+    if (s->transaction_active) {
+        qemu_set_irq(s->cs, 1);
+        s->transaction_active =3D false;
+    }
+    s->remaining =3D 0;
+    s->indefinite =3D false;
+    s->write_pending =3D false;
+}
+
+static void stm32l4x5_quadspi_transfer_value(Stm32l4x5QuadSpiState *s,
+                                              uint32_t value,
+                                              unsigned int count)
+{
+    for (int i =3D count - 1; i >=3D 0; i--) {
+        ssi_transfer(s->ssi, extract32(value, i * 8, 8));
+    }
+}
+
+static void stm32l4x5_quadspi_send_prefix(Stm32l4x5QuadSpiState *s)
+{
+    unsigned int imode =3D (s->ccr & CCR_IMODE) >> CCR_IMODE_SHIFT;
+    unsigned int admode =3D (s->ccr & CCR_ADMODE) >> CCR_ADMODE_SHIFT;
+    unsigned int abmode =3D (s->ccr & CCR_ABMODE) >> CCR_ABMODE_SHIFT;
+    unsigned int dmode =3D (s->ccr & CCR_DMODE) >> CCR_DMODE_SHIFT;
+    unsigned int dummy_cycles =3D (s->ccr & CCR_DCYC) >> CCR_DCYC_SHIFT;
+    unsigned int dummy_width;
+    unsigned int dummy_bytes;
+
+    stm32l4x5_quadspi_select(s);
+
+    if (imode) {
+        ssi_transfer(s->ssi, s->ccr & CCR_INSTRUCTION);
+    }
+    if (admode) {
+        unsigned int address_bytes =3D
+            ((s->ccr & CCR_ADSIZE) >> CCR_ADSIZE_SHIFT) + 1;
+
+        stm32l4x5_quadspi_transfer_value(s, s->ar, address_bytes);
+    }
+    if (abmode) {
+        unsigned int alternate_bytes =3D
+            ((s->ccr & CCR_ABSIZE) >> CCR_ABSIZE_SHIFT) + 1;
+
+        stm32l4x5_quadspi_transfer_value(s, s->abr, alternate_bytes);
+    }
+
+    dummy_width =3D stm32l4x5_quadspi_mode_width(admode ? admode : dmode);
+    dummy_bytes =3D DIV_ROUND_UP(dummy_cycles * dummy_width, 8);
+    for (unsigned int i =3D 0; i < dummy_bytes; i++) {
+        ssi_transfer(s->ssi, 0);
+    }
+}
+
+static void stm32l4x5_quadspi_complete(Stm32l4x5QuadSpiState *s)
+{
+    stm32l4x5_quadspi_deselect(s);
+    s->rx_stalled =3D false;
+    if (stm32l4x5_quadspi_fmode(s) =3D=3D QUADSPI_INDIRECT_WRITE) {
+        fifo8_reset(&s->fifo);
+    }
+    s->sr |=3D SR_TCF;
+    stm32l4x5_quadspi_update_fifo(s);
+}
+
+static bool stm32l4x5_quadspi_prepare_data(Stm32l4x5QuadSpiState *s)
+{
+    unsigned int fsize =3D extract32(s->dcr, 16, 5);
+    uint64_t flash_size =3D 1ULL << (fsize + 1);
+    uint64_t address =3D (s->ccr & CCR_ADMODE) ? s->ar : 0;
+    bool has_data =3D s->ccr & CCR_DMODE;
+
+    fifo8_reset(&s->fifo);
+    s->rx_stalled =3D false;
+    s->write_pending =3D false;
+    s->indefinite =3D has_data && s->dlr =3D=3D UINT32_MAX && fsize =3D=3D 3=
1;
+    s->remaining =3D has_data ? (uint64_t)s->dlr + 1 : 0;
+    s->sr &=3D ~SR_TCF;
+    if ((s->ccr & CCR_ADMODE) &&
+        (address >=3D flash_size ||
+         (has_data && s->dlr !=3D UINT32_MAX &&
+          s->remaining > flash_size - address))) {
+        s->remaining =3D 0;
+        s->indefinite =3D false;
+        s->sr |=3D SR_TEF;
+        stm32l4x5_quadspi_update_fifo(s);
+        return false;
+    }
+    if (has_data && s->dlr =3D=3D UINT32_MAX) {
+        s->remaining =3D s->indefinite ? 0 : flash_size - address;
+    }
+    stm32l4x5_quadspi_update_fifo(s);
+    return true;
+}
+
+static bool stm32l4x5_quadspi_indirect(Stm32l4x5QuadSpiState *s)
+{
+    if (stm32l4x5_quadspi_fmode(s) >=3D QUADSPI_AUTO_POLLING ||
+        (s->ccr & (CCR_SIOO | CCR_DDRM)) || (s->cr & CR_DFM)) {
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: polling, mapped, SIOO, DDR, or dual flash mode\n",
+                      TYPE_STM32L4X5_QUADSPI);
+        return false;
+    }
+    return true;
+}
+
+static void stm32l4x5_quadspi_fill_fifo(Stm32l4x5QuadSpiState *s)
+{
+    if (!(s->cr & CR_EN) || !s->transaction_active) {
+        return;
+    }
+    /* After a full FIFO, reception resumes when FLEVEL is at most 11. */
+    if (s->rx_stalled && fifo8_num_used(&s->fifo) > 11) {
+        return;
+    }
+    s->rx_stalled =3D false;
+    while ((s->remaining || s->indefinite) && !fifo8_is_full(&s->fifo)) {
+        fifo8_push(&s->fifo, ssi_transfer(s->ssi, 0));
+        if (!s->indefinite) {
+            s->remaining--;
+        }
+    }
+    if (!s->remaining && !s->indefinite) {
+        stm32l4x5_quadspi_complete(s);
+    } else {
+        s->rx_stalled =3D true;
+        stm32l4x5_quadspi_update_fifo(s);
+    }
+}
+
+static void stm32l4x5_quadspi_start_read(Stm32l4x5QuadSpiState *s)
+{
+    if (!stm32l4x5_quadspi_prepare_data(s)) {
+        return;
+    }
+    stm32l4x5_quadspi_send_prefix(s);
+    stm32l4x5_quadspi_fill_fifo(s);
+}
+
+static void stm32l4x5_quadspi_execute_command(Stm32l4x5QuadSpiState *s)
+{
+    if (!stm32l4x5_quadspi_prepare_data(s)) {
+        return;
+    }
+    stm32l4x5_quadspi_send_prefix(s);
+    stm32l4x5_quadspi_complete(s);
+}
+
+static uint64_t stm32l4x5_quadspi_read_register(void *opaque, hwaddr addr,
+                                       unsigned int size)
+{
+    Stm32l4x5QuadSpiState *s =3D opaque;
+    uint32_t value =3D 0;
+
+    switch (addr) {
+    case QUADSPI_CR:
+        return s->cr;
+    case QUADSPI_DCR:
+        return s->dcr;
+    case QUADSPI_SR:
+        return s->sr;
+    case QUADSPI_FCR:
+        return 0;
+    case QUADSPI_DLR:
+        return s->dlr;
+    case QUADSPI_CCR:
+        return s->ccr;
+    case QUADSPI_AR:
+        return s->ar;
+    case QUADSPI_ABR:
+        return s->abr;
+    case QUADSPI_DR:
+        if (!(s->cr & CR_EN) ||
+            stm32l4x5_quadspi_fmode(s) !=3D QUADSPI_INDIRECT_READ) {
+            return 0;
+        }
+        for (unsigned int i =3D 0; i < size && !fifo8_is_empty(&s->fifo); i+=
+) {
+            value |=3D (uint32_t)fifo8_pop(&s->fifo) << (i * 8);
+        }
+        s->dr =3D value;
+        stm32l4x5_quadspi_fill_fifo(s);
+        stm32l4x5_quadspi_update_fifo(s);
+        return value;
+    case QUADSPI_PSMKR:
+        return s->psmkr;
+    case QUADSPI_PSMAR:
+        return s->psmar;
+    case QUADSPI_PIR:
+        return s->pir;
+    case QUADSPI_LPTR:
+        return s->lptr;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad read offset 0x%" HWADDR_PRIx "\n",
+                      TYPE_STM32L4X5_QUADSPI, addr);
+        return 0;
+    }
+}
+
+static void stm32l4x5_quadspi_write_data(Stm32l4x5QuadSpiState *s,
+                                          uint32_t value,
+                                          unsigned int size)
+{
+    if (!(s->cr & CR_EN) ||
+        stm32l4x5_quadspi_fmode(s) !=3D QUADSPI_INDIRECT_WRITE ||
+        (!s->write_pending && !s->remaining && !s->indefinite)) {
+        return;
+    }
+    if (s->write_pending) {
+        if (!stm32l4x5_quadspi_indirect(s) ||
+            !stm32l4x5_quadspi_prepare_data(s)) {
+            s->write_pending =3D false;
+            return;
+        }
+    }
+    if (fifo8_num_free(&s->fifo) < size) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write to full FIFO\n",
+                      TYPE_STM32L4X5_QUADSPI);
+        return;
+    }
+    for (unsigned int i =3D 0; i < size; i++) {
+        fifo8_push(&s->fifo, extract32(value, i * 8, 8));
+    }
+    s->dr =3D value;
+    if (!s->transaction_active) {
+        stm32l4x5_quadspi_send_prefix(s);
+    }
+
+    while ((s->remaining || s->indefinite) && !fifo8_is_empty(&s->fifo)) {
+        ssi_transfer(s->ssi, fifo8_pop(&s->fifo));
+        if (!s->indefinite) {
+            s->remaining--;
+        }
+    }
+
+    if (!s->remaining && !s->indefinite) {
+        stm32l4x5_quadspi_complete(s);
+    } else {
+        stm32l4x5_quadspi_update_fifo(s);
+    }
+}
+
+static void stm32l4x5_quadspi_abort(Stm32l4x5QuadSpiState *s)
+{
+    stm32l4x5_quadspi_deselect(s);
+    fifo8_reset(&s->fifo);
+    s->rx_stalled =3D false;
+    s->cr &=3D ~CR_ABORT;
+    s->sr |=3D SR_TCF;
+    stm32l4x5_quadspi_update_fifo(s);
+}
+
+static void stm32l4x5_quadspi_write_register(void *opaque, hwaddr addr,
+                                    uint64_t value, unsigned int size)
+{
+    Stm32l4x5QuadSpiState *s =3D opaque;
+
+    switch (addr) {
+    case QUADSPI_CR:
+        if (s->sr & SR_BUSY) {
+            uint32_t mutable =3D CR_EN | CR_ABORT | CR_TEIE | CR_TCIE |
+                               CR_FTIE | CR_SMIE | CR_TOIE;
+            value =3D (s->cr & ~mutable) | (value & mutable);
+        }
+        s->cr =3D value;
+        if (s->cr & CR_ABORT) {
+            stm32l4x5_quadspi_abort(s);
+        } else {
+            if (!(s->cr & CR_EN)) {
+                /* Disabling is not a reset or a transfer-complete event. */
+                stm32l4x5_quadspi_deselect(s);
+                fifo8_reset(&s->fifo);
+                s->rx_stalled =3D false;
+            }
+            stm32l4x5_quadspi_update_fifo(s);
+        }
+        return;
+    case QUADSPI_DCR:
+        s->dcr =3D value;
+        return;
+    case QUADSPI_SR:
+        return;
+    case QUADSPI_FCR:
+        s->sr &=3D ~(value & (SR_TEF | SR_TCF | SR_SMF | SR_TOF));
+        stm32l4x5_quadspi_update_irq(s);
+        return;
+    case QUADSPI_DLR:
+        s->dlr =3D value;
+        return;
+    case QUADSPI_CCR:
+        s->ccr =3D value;
+        s->write_pending =3D false;
+        if (!(s->cr & CR_EN) || !stm32l4x5_quadspi_indirect(s)) {
+            return;
+        }
+        if (((s->ccr & CCR_DMODE) =3D=3D 0) &&
+            ((s->ccr & CCR_ADMODE) =3D=3D 0) &&
+            ((s->ccr & CCR_IMODE) !=3D 0)) {
+            stm32l4x5_quadspi_execute_command(s);
+        } else if ((s->ccr & CCR_DMODE) &&
+                   stm32l4x5_quadspi_fmode(s) =3D=3D QUADSPI_INDIRECT_WRITE)=
 {
+            s->write_pending =3D true;
+            stm32l4x5_quadspi_update_fifo(s);
+        } else if ((s->ccr & CCR_DMODE) &&
+                   !(s->ccr & CCR_ADMODE) &&
+                   stm32l4x5_quadspi_fmode(s) =3D=3D QUADSPI_INDIRECT_READ) {
+            stm32l4x5_quadspi_start_read(s);
+        }
+        return;
+    case QUADSPI_AR:
+        s->ar =3D value;
+        if (!(s->cr & CR_EN) || !stm32l4x5_quadspi_indirect(s)) {
+            return;
+        }
+        if ((s->ccr & CCR_DMODE) && (s->ccr & CCR_ADMODE) &&
+            stm32l4x5_quadspi_fmode(s) =3D=3D QUADSPI_INDIRECT_READ) {
+            stm32l4x5_quadspi_start_read(s);
+        } else if (((s->ccr & CCR_DMODE) =3D=3D 0) &&
+                   ((s->ccr & CCR_ADMODE) !=3D 0)) {
+            stm32l4x5_quadspi_execute_command(s);
+        }
+        return;
+    case QUADSPI_ABR:
+        s->abr =3D value;
+        return;
+    case QUADSPI_DR:
+        stm32l4x5_quadspi_write_data(s, value, size);
+        return;
+    case QUADSPI_PSMKR:
+        s->psmkr =3D value;
+        return;
+    case QUADSPI_PSMAR:
+        s->psmar =3D value;
+        return;
+    case QUADSPI_PIR:
+        s->pir =3D value;
+        return;
+    case QUADSPI_LPTR:
+        s->lptr =3D value;
+        return;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad write offset 0x%" HWADDR_PRIx "\n",
+                      TYPE_STM32L4X5_QUADSPI, addr);
+    }
+}
+
+static uint64_t stm32l4x5_quadspi_read(void *opaque, hwaddr addr,
+                                      unsigned int size)
+{
+    uint64_t value;
+
+    if ((addr & ~3ULL) =3D=3D QUADSPI_DR) {
+        /* DR access size determines the number of FIFO bytes consumed. */
+        return stm32l4x5_quadspi_read_register(opaque, addr, size);
+    }
+    value =3D stm32l4x5_quadspi_read_register(opaque, addr & ~3ULL, 4);
+    return extract32(value, (addr & 3) * 8, size * 8);
+}
+
+static void stm32l4x5_quadspi_write(void *opaque, hwaddr addr,
+                                  uint64_t value, unsigned int size)
+{
+    Stm32l4x5QuadSpiState *s =3D opaque;
+    unsigned int shift =3D (addr & 3) * 8;
+    hwaddr reg =3D addr & ~3ULL;
+
+    if ((s->sr & SR_BUSY) && reg !=3D QUADSPI_CR &&
+        reg !=3D QUADSPI_FCR && reg !=3D QUADSPI_SR && reg !=3D QUADSPI_DR) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: configuration write while busy\n",
+                      TYPE_STM32L4X5_QUADSPI);
+        return;
+    }
+    if (reg =3D=3D QUADSPI_FCR) {
+        value <<=3D shift;
+    } else if (reg !=3D QUADSPI_DR && size !=3D 4) {
+        uint32_t mask =3D MAKE_64BIT_MASK(shift, size * 8);
+        uint32_t old =3D stm32l4x5_quadspi_read_register(s, reg, 4);
+
+        value =3D (old & ~mask) | ((value << shift) & mask);
+    }
+    stm32l4x5_quadspi_write_register(s, reg, value, size);
+}
+
+static bool stm32l4x5_quadspi_accepts(void *opaque, hwaddr addr,
+                                   unsigned int size, bool is_write,
+                                   MemTxAttrs attrs)
+{
+    return (size =3D=3D 1 || size =3D=3D 2 || size =3D=3D 4) &&
+           ((addr & ~3ULL) !=3D QUADSPI_DR || addr =3D=3D QUADSPI_DR);
+}
+
+static const MemoryRegionOps stm32l4x5_quadspi_ops =3D {
+    .read =3D stm32l4x5_quadspi_read,
+    .write =3D stm32l4x5_quadspi_write,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size =3D 1,
+    .impl.max_access_size =3D 4,
+    .valid.min_access_size =3D 1,
+    .valid.max_access_size =3D 4,
+    .valid.unaligned =3D false,
+    .valid.accepts =3D stm32l4x5_quadspi_accepts,
+};
+
+static void stm32l4x5_quadspi_hold_reset(Object *obj, ResetType type)
+{
+    Stm32l4x5QuadSpiState *s =3D STM32L4X5_QUADSPI(obj);
+
+    s->cr =3D 0;
+    s->dcr =3D 0;
+    s->sr =3D 0;
+    s->dlr =3D 0;
+    s->ccr =3D 0;
+    s->ar =3D 0;
+    s->abr =3D 0;
+    s->dr =3D 0;
+    s->psmkr =3D 0;
+    s->psmar =3D 0;
+    s->pir =3D 0;
+    s->lptr =3D 0;
+    s->remaining =3D 0;
+    s->transaction_active =3D false;
+    s->rx_stalled =3D false;
+    s->indefinite =3D false;
+    s->write_pending =3D false;
+    fifo8_reset(&s->fifo);
+    qemu_set_irq(s->cs, 1);
+    qemu_irq_lower(s->irq);
+}
+
+static void stm32l4x5_quadspi_init(Object *obj)
+{
+    Stm32l4x5QuadSpiState *s =3D STM32L4X5_QUADSPI(obj);
+    DeviceState *dev =3D DEVICE(obj);
+
+    fifo8_create(&s->fifo, QUADSPI_FIFO_SIZE);
+    memory_region_init_io(&s->mmio, obj, &stm32l4x5_quadspi_ops, s,
+                          TYPE_STM32L4X5_QUADSPI, QUADSPI_MMIO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+    qdev_init_gpio_out_named(dev, &s->cs, "cs", 1);
+    s->ssi =3D ssi_create_bus(dev, "ssi");
+    s->clk =3D qdev_init_clock_in(dev, "clk", NULL, s, 0);
+}
+
+static void stm32l4x5_quadspi_finalize(Object *obj)
+{
+    Stm32l4x5QuadSpiState *s =3D STM32L4X5_QUADSPI(obj);
+
+    fifo8_destroy(&s->fifo);
+}
+
+static void stm32l4x5_quadspi_realize(DeviceState *dev, Error **errp)
+{
+    Stm32l4x5QuadSpiState *s =3D STM32L4X5_QUADSPI(dev);
+
+    if (!clock_has_source(s->clk)) {
+        error_setg(errp, "%s: clk input must be connected",
+                   TYPE_STM32L4X5_QUADSPI);
+    }
+}
+
+static int stm32l4x5_quadspi_post_load(void *opaque, int version_id)
+{
+    Stm32l4x5QuadSpiState *s =3D opaque;
+
+    if (s->fifo.head >=3D QUADSPI_FIFO_SIZE ||
+        fifo8_num_used(&s->fifo) > QUADSPI_FIFO_SIZE) {
+        return -EINVAL;
+    }
+    if ((s->transaction_active && !(s->cr & CR_EN)) ||
+        (s->indefinite && s->remaining)) {
+        return -EINVAL;
+    }
+    qemu_set_irq(s->cs, !s->transaction_active);
+    stm32l4x5_quadspi_update_fifo(s);
+    return 0;
+}
+
+static const VMStateDescription vmstate_stm32l4x5_quadspi =3D {
+    .name =3D TYPE_STM32L4X5_QUADSPI,
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .post_load =3D stm32l4x5_quadspi_post_load,
+    .fields =3D (const VMStateField[]) {
+        VMSTATE_UINT32(cr, Stm32l4x5QuadSpiState),
+        VMSTATE_UINT32(dcr, Stm32l4x5QuadSpiState),
+        VMSTATE_UINT32(sr, Stm32l4x5QuadSpiState),
+        VMSTATE_UINT32(dlr, Stm32l4x5QuadSpiState),
+        VMSTATE_UINT32(ccr, Stm32l4x5QuadSpiState),
+        VMSTATE_UINT32(ar, Stm32l4x5QuadSpiState),
+        VMSTATE_UINT32(abr, Stm32l4x5QuadSpiState),
+        VMSTATE_UINT32(dr, Stm32l4x5QuadSpiState),
+        VMSTATE_UINT32(psmkr, Stm32l4x5QuadSpiState),
+        VMSTATE_UINT32(psmar, Stm32l4x5QuadSpiState),
+        VMSTATE_UINT32(pir, Stm32l4x5QuadSpiState),
+        VMSTATE_UINT32(lptr, Stm32l4x5QuadSpiState),
+        VMSTATE_UINT64(remaining, Stm32l4x5QuadSpiState),
+        VMSTATE_BOOL(transaction_active, Stm32l4x5QuadSpiState),
+        VMSTATE_FIFO8(fifo, Stm32l4x5QuadSpiState),
+        VMSTATE_BOOL(rx_stalled, Stm32l4x5QuadSpiState),
+        VMSTATE_BOOL(indefinite, Stm32l4x5QuadSpiState),
+        VMSTATE_BOOL(write_pending, Stm32l4x5QuadSpiState),
+        VMSTATE_CLOCK(clk, Stm32l4x5QuadSpiState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void stm32l4x5_quadspi_class_init(ObjectClass *klass, const void *dat=
a)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
+
+    dc->realize =3D stm32l4x5_quadspi_realize;
+    dc->vmsd =3D &vmstate_stm32l4x5_quadspi;
+    rc->phases.hold =3D stm32l4x5_quadspi_hold_reset;
+}
+
+static const TypeInfo stm32l4x5_quadspi_info =3D {
+    .name =3D TYPE_STM32L4X5_QUADSPI,
+    .parent =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(Stm32l4x5QuadSpiState),
+    .instance_init =3D stm32l4x5_quadspi_init,
+    .instance_finalize =3D stm32l4x5_quadspi_finalize,
+    .class_init =3D stm32l4x5_quadspi_class_init,
+};
+
+static void stm32l4x5_quadspi_register_types(void)
+{
+    type_register_static(&stm32l4x5_quadspi_info);
+}
+
+type_init(stm32l4x5_quadspi_register_types)
diff --git a/include/hw/arm/stm32l4x5_soc.h b/include/hw/arm/stm32l4x5_soc.h
index 9c3d662bca..5b5e817ee7 100644
--- a/include/hw/arm/stm32l4x5_soc.h
+++ b/include/hw/arm/stm32l4x5_soc.h
@@ -32,6 +32,7 @@
 #include "hw/misc/stm32l4x5_rcc.h"
 #include "hw/gpio/stm32l4x5_gpio.h"
 #include "hw/char/stm32l4x5_usart.h"
+#include "hw/ssi/stm32l4x5_quadspi.h"
 #include "qom/object.h"
=20
 #define TYPE_STM32L4X5_SOC "stm32l4x5-soc"
@@ -56,6 +57,7 @@ struct Stm32l4x5SocState {
     Stm32l4x5RccState rcc;
     Stm32l4x5GpioState gpio[NUM_GPIOS];
     Stm32l4x5UsartBaseState usart[STM_NUM_USARTS];
+    Stm32l4x5QuadSpiState quadspi;
     Stm32l4x5UsartBaseState uart[STM_NUM_UARTS];
     Stm32l4x5UsartBaseState lpuart;
=20
diff --git a/include/hw/ssi/stm32l4x5_quadspi.h b/include/hw/ssi/stm32l4x5_qu=
adspi.h
new file mode 100644
index 0000000000..e9882dd996
--- /dev/null
+++ b/include/hw/ssi/stm32l4x5_quadspi.h
@@ -0,0 +1,51 @@
+/*
+ * STM32L4x5 QuadSPI controller
+ *
+ * Copyright (c) 2026 EXALT Technologies
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_STM32L4X5_QUADSPI_H
+#define HW_STM32L4X5_QUADSPI_H
+
+#include "hw/core/clock.h"
+#include "hw/core/sysbus.h"
+#include "hw/ssi/ssi.h"
+#include "qemu/fifo8.h"
+#include "qom/object.h"
+
+#define TYPE_STM32L4X5_QUADSPI "stm32l4x5-quadspi"
+OBJECT_DECLARE_SIMPLE_TYPE(Stm32l4x5QuadSpiState, STM32L4X5_QUADSPI)
+
+struct Stm32l4x5QuadSpiState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    Clock *clk;
+    qemu_irq irq;
+    qemu_irq cs;
+    SSIBus *ssi;
+
+    uint32_t cr;
+    uint32_t dcr;
+    uint32_t sr;
+    uint32_t dlr;
+    uint32_t ccr;
+    uint32_t ar;
+    uint32_t abr;
+    uint32_t dr;
+    uint32_t psmkr;
+    uint32_t psmar;
+    uint32_t pir;
+    uint32_t lptr;
+
+    Fifo8 fifo;
+    uint64_t remaining;
+    bool transaction_active;
+    bool rx_stalled;
+    bool indefinite;
+    bool write_pending;
+};
+
+#endif /* HW_STM32L4X5_QUADSPI_H */
--=20
2.49.1


