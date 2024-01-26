Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C367AC47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 19:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTS0p-0002Sn-0B; Fri, 26 Jan 2024 14:37:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rTS0m-0002Qu-KZ; Fri, 26 Jan 2024 14:37:12 -0500
Received: from zproxy1.enst.fr ([2001:660:330f:2::dc])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rTS0k-0003ak-9z; Fri, 26 Jan 2024 14:37:12 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id 263B2C0D84;
 Fri, 26 Jan 2024 20:37:05 +0100 (CET)
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id G8AiXwxqoewB; Fri, 26 Jan 2024 20:37:04 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id ADA6AC0DEB;
 Fri, 26 Jan 2024 20:37:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy1.enst.fr ADA6AC0DEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1706297824;
 bh=hL9TaZ4ibiwR+WC8tu4kAPe9gkBsSjiDSq5hSzb1jHg=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=Xe65gfqwSGQ2180Nlali1HCAoJ4lOfozezS5TvTM+HdBPWrOgIh62vxhuWsDFf9b5
 CQw2ty43tqEN4Z0gK0hjZVm5Fm8xdzD7f1hIf5HgjYA18ym5Rp1tnh4w1H04O3YNDH
 cAjARPSot+azUfET6b99jLfAwMWYc/vjOE6t38XM=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id mXthl3Y1vUHZ; Fri, 26 Jan 2024 20:37:04 +0100 (CET)
Received: from localhost.localdomain (74.0.125.80.rev.sfr.net [80.125.0.74])
 by zproxy1.enst.fr (Postfix) with ESMTPSA id 5E5AFC0DDF;
 Fri, 26 Jan 2024 20:37:04 +0100 (CET)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Samuel Tardieu <sam@rfc1149.net>, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
Subject: [PATCH 2/3] hw/arm : Connect DM163 to STM32L4x5
Date: Fri, 26 Jan 2024 20:31:02 +0100
Message-ID: <20240126193657.792005-3-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126193657.792005-1-ines.varhol@telecom-paris.fr>
References: <20240126193657.792005-1-ines.varhol@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:660:330f:2::dc;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy1.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 hw/arm/Kconfig                 |  1 +
 hw/arm/stm32l4x5_soc.c         | 55 +++++++++++++++++++++++++++++++++-
 include/hw/arm/stm32l4x5_soc.h |  3 ++
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3e49b913f8..818aa2f1a2 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -463,6 +463,7 @@ config STM32L4X5_SOC
     select STM32L4X5_SYSCFG
     select STM32L4X5_RCC
     select STM32L4X5_GPIO
+    select DM163
=20
 config XLNX_ZYNQMP_ARM
     bool
diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
index 478c6ba056..8663546901 100644
--- a/hw/arm/stm32l4x5_soc.c
+++ b/hw/arm/stm32l4x5_soc.c
@@ -26,7 +26,9 @@
 #include "qapi/error.h"
 #include "exec/address-spaces.h"
 #include "sysemu/sysemu.h"
+#include "hw/core/split-irq.h"
 #include "hw/arm/stm32l4x5_soc.h"
+#include "hw/display/dm163.h"
 #include "hw/qdev-clock.h"
 #include "hw/misc/unimp.h"
=20
@@ -78,6 +80,31 @@ static const int exti_irq[NUM_EXTI_IRQ] =3D {
 #define RCC_BASE_ADDRESS 0x40021000
 #define RCC_IRQ 5
=20
+/*
+ * There are actually 14 input pins in the DM163 device.
+ * Here the DM163 input pin EN isn't connected to the STM32L4x5
+ * GPIOs as the IM120417002 colors shield doesn't actually use
+ * this pin to drive the RGB matrix.
+ */
+#define NUM_DM163_INPUTS 13
+
+static const int dm163_input[NUM_DM163_INPUTS] =3D {
+    1 * 16 + 2,  /* ROW0  PB2       */
+    0 * 16 + 15, /* ROW1  PA15      */
+    0 * 16 + 2,  /* ROW2  PA2       */
+    0 * 16 + 7,  /* ROW3  PA7       */
+    0 * 16 + 6,  /* ROW4  PA6       */
+    0 * 16 + 5,  /* ROW5  PA5       */
+    1 * 16 + 0,  /* ROW6  PB0       */
+    0 * 16 + 3,  /* ROW7  PA3       */
+    0 * 16 + 4,  /* SIN (SDA) PA4   */
+    1 * 16 + 1,  /* DCK (SCK) PB1   */
+    2 * 16 + 3,  /* RST_B (RST) PC3 */
+    2 * 16 + 4,  /* LAT_B (LAT) PC4 */
+    2 * 16 + 5,  /* SELBK (SB)  PC5 */
+};
+
+
 static const uint32_t gpio_addr[] =3D {
     0x48000000,
     0x48000400,
@@ -116,6 +143,8 @@ static void stm32l4x5_soc_initfn(Object *obj)
         g_autofree char *name =3D g_strdup_printf("gpio%c", 'a' + i);
         object_initialize_child(obj, name, &s->gpio[i], TYPE_STM32L4X5_G=
PIO);
     }
+
+    object_initialize_child(obj, "dm163", &s->dm163, TYPE_DM163);
 }
=20
 static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
@@ -124,9 +153,10 @@ static void stm32l4x5_soc_realize(DeviceState *dev_s=
oc, Error **errp)
     Stm32l4x5SocState *s =3D STM32L4X5_SOC(dev_soc);
     const Stm32l4x5SocClass *sc =3D STM32L4X5_SOC_GET_CLASS(dev_soc);
     MemoryRegion *system_memory =3D get_system_memory();
-    DeviceState *armv7m, *dev;
+    DeviceState *armv7m, *dev, *gpio_output_fork;
     SysBusDevice *busdev;
     uint32_t pin_index;
+    int gpio, pin;
=20
     if (!memory_region_init_rom(&s->flash, OBJECT(dev_soc), "flash",
                                 sc->flash_size, errp)) {
@@ -166,6 +196,12 @@ static void stm32l4x5_soc_realize(DeviceState *dev_s=
oc, Error **errp)
         return;
     }
=20
+    /* DM163 */
+    dev =3D DEVICE(&s->dm163);
+    if (!qdev_realize(dev, NULL, errp)) {
+        return;
+    }
+
     /* GPIOs */
     for (unsigned i =3D 0; i < NUM_GPIOS; i++) {
         g_autofree char *name =3D g_strdup_printf("%c", 'A' + i);
@@ -204,6 +240,23 @@ static void stm32l4x5_soc_realize(DeviceState *dev_s=
oc, Error **errp)
         }
     }
=20
+    for (unsigned i =3D 0; i < NUM_DM163_INPUTS; i++) {
+        gpio_output_fork =3D qdev_new(TYPE_SPLIT_IRQ);
+        qdev_prop_set_uint32(gpio_output_fork, "num-lines", 2);
+        qdev_realize_and_unref(gpio_output_fork, NULL, &error_fatal);
+
+        qdev_connect_gpio_out(gpio_output_fork, 0,
+                              qdev_get_gpio_in(DEVICE(&s->syscfg),
+                                               dm163_input[i]));
+        qdev_connect_gpio_out(gpio_output_fork, 1,
+                              qdev_get_gpio_in(DEVICE(&s->dm163),
+                                               i));
+        gpio =3D dm163_input[i] / 16;
+        pin =3D dm163_input[i] % 16;
+        qdev_connect_gpio_out(DEVICE(&s->gpio[gpio]), pin,
+                              qdev_get_gpio_in(DEVICE(gpio_output_fork),=
 0));
+    }
+
     /* EXTI device */
     busdev =3D SYS_BUS_DEVICE(&s->exti);
     if (!sysbus_realize(busdev, errp)) {
diff --git a/include/hw/arm/stm32l4x5_soc.h b/include/hw/arm/stm32l4x5_so=
c.h
index cb4da08629..60b31d430e 100644
--- a/include/hw/arm/stm32l4x5_soc.h
+++ b/include/hw/arm/stm32l4x5_soc.h
@@ -30,6 +30,7 @@
 #include "hw/misc/stm32l4x5_exti.h"
 #include "hw/misc/stm32l4x5_rcc.h"
 #include "hw/gpio/stm32l4x5_gpio.h"
+#include "hw/display/dm163.h"
 #include "qom/object.h"
=20
 #define TYPE_STM32L4X5_SOC "stm32l4x5-soc"
@@ -48,6 +49,8 @@ struct Stm32l4x5SocState {
     Stm32l4x5RccState rcc;
     Stm32l4x5GpioState gpio[NUM_GPIOS];
=20
+    DM163State dm163;
+
     MemoryRegion sram1;
     MemoryRegion sram2;
     MemoryRegion flash;
--=20
2.43.0


