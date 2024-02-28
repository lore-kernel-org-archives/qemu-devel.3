Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D5AC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 12:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIdx-00049p-UH; Wed, 28 Feb 2024 07:02:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rfIdr-00044D-9D; Wed, 28 Feb 2024 07:02:32 -0500
Received: from zproxy3.enst.fr ([2001:660:330f:2::de])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rfIdm-0002zA-5z; Wed, 28 Feb 2024 07:02:29 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id B8E3DA06F8;
 Wed, 28 Feb 2024 13:02:24 +0100 (CET)
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id NIJOEiI5OQzm; Wed, 28 Feb 2024 13:02:24 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 27EF1A06FC;
 Wed, 28 Feb 2024 13:02:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy3.enst.fr 27EF1A06FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1709121744;
 bh=9yCAa2IaqsNHr0V/8Z3CfJJGrYjFNpZ6MWKqMGjZhOM=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=CZEIIK1i7w0EjKTZOvUOGuHlxs8/CQbMAxdqupwDbYPp5Jg1UncsAHg2ENVs5tY2F
 r5oOntPVDmUT0UMpFwzrlGtEzkzyY3ira726W1p+MaqH/o0H7kV3Po0kC5/cWHpyj+
 vWF2JCkH2gDIeJxpFLBvsmBTvG0s+T8IRxUeVVQc=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id dAfXj_0nUQa5; Wed, 28 Feb 2024 13:02:24 +0100 (CET)
Received: from localhost.localdomain (74.0.125.80.rev.sfr.net [80.125.0.74])
 by zproxy3.enst.fr (Postfix) with ESMTPSA id CAA61A06DF;
 Wed, 28 Feb 2024 13:02:23 +0100 (CET)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Samuel Tardieu <sam@rfc1149.net>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 4/5] hw/arm : Connect DM163 to B-L475E-IOT01A
Date: Wed, 28 Feb 2024 13:01:07 +0100
Message-ID: <20240228120215.277717-5-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228120215.277717-1-ines.varhol@telecom-paris.fr>
References: <20240228120215.277717-1-ines.varhol@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:660:330f:2::de;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy3.enst.fr
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
 hw/arm/b-l475e-iot01a.c | 59 +++++++++++++++++++++++++++++++++++++++--
 hw/arm/Kconfig          |  1 +
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
index 2b570b3e09..6f0bf68ca6 100644
--- a/hw/arm/b-l475e-iot01a.c
+++ b/hw/arm/b-l475e-iot01a.c
@@ -27,10 +27,37 @@
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
-#include "hw/arm/stm32l4x5_soc.h"
 #include "hw/arm/boot.h"
+#include "hw/core/split-irq.h"
+#include "hw/arm/stm32l4x5_soc.h"
+#include "hw/gpio/stm32l4x5_gpio.h"
+#include "hw/display/dm163.h"
+
+/* B-L475E-IOT01A implementation is inspired from netduinoplus2 and ardu=
ino */
=20
-/* B-L475E-IOT01A implementation is derived from netduinoplus2 */
+/*
+ * There are actually 14 input pins in the DM163 device.
+ * Here the DM163 input pin EN isn't connected to the STM32L4x5
+ * GPIOs as the IM120417002 colors shield doesn't actually use
+ * this pin to drive the RGB matrix.
+ */
+#define NUM_DM163_INPUTS 13
+
+static const int dm163_input[NUM_DM163_INPUTS] =3D {
+    1 * GPIO_NUM_PINS + 2,  /* ROW0  PB2       */
+    0 * GPIO_NUM_PINS + 15, /* ROW1  PA15      */
+    0 * GPIO_NUM_PINS + 2,  /* ROW2  PA2       */
+    0 * GPIO_NUM_PINS + 7,  /* ROW3  PA7       */
+    0 * GPIO_NUM_PINS + 6,  /* ROW4  PA6       */
+    0 * GPIO_NUM_PINS + 5,  /* ROW5  PA5       */
+    1 * GPIO_NUM_PINS + 0,  /* ROW6  PB0       */
+    0 * GPIO_NUM_PINS + 3,  /* ROW7  PA3       */
+    0 * GPIO_NUM_PINS + 4,  /* SIN (SDA) PA4   */
+    1 * GPIO_NUM_PINS + 1,  /* DCK (SCK) PB1   */
+    2 * GPIO_NUM_PINS + 3,  /* RST_B (RST) PC3 */
+    2 * GPIO_NUM_PINS + 4,  /* LAT_B (LAT) PC4 */
+    2 * GPIO_NUM_PINS + 5,  /* SELBK (SB)  PC5 */
+};
=20
 #define TYPE_B_L475E_IOT01A MACHINE_TYPE_NAME("b-l475e-iot01a")
 OBJECT_DECLARE_SIMPLE_TYPE(Bl475eMachineState, B_L475E_IOT01A)
@@ -39,12 +66,16 @@ typedef struct Bl475eMachineState {
     MachineState parent_obj;
=20
     Stm32l4x5SocState soc;
+    SplitIRQ gpio_splitters[NUM_DM163_INPUTS];
+    DM163State dm163;
 } Bl475eMachineState;
=20
 static void bl475e_init(MachineState *machine)
 {
     Bl475eMachineState *s =3D B_L475E_IOT01A(machine);
     const Stm32l4x5SocClass *sc;
+    DeviceState *dev, *gpio_out_splitter;
+    int gpio, pin;
=20
     object_initialize_child(OBJECT(machine), "soc", &s->soc,
                             TYPE_STM32L4X5XG_SOC);
@@ -53,6 +84,30 @@ static void bl475e_init(MachineState *machine)
     sc =3D STM32L4X5_SOC_GET_CLASS(&s->soc);
     armv7m_load_kernel(ARM_CPU(first_cpu),
         machine->kernel_filename, 0, sc->flash_size);
+
+    if (object_class_by_name("dm163")) {
+        object_initialize_child(OBJECT(machine), "dm163",
+                                &s->dm163, TYPE_DM163);
+        dev =3D DEVICE(&s->dm163);
+        qdev_realize(dev, NULL, &error_abort);
+
+        for (unsigned i =3D 0; i < NUM_DM163_INPUTS; i++) {
+            object_initialize_child(OBJECT(machine), "gpio-out-splitters=
[*]",
+                                    &s->gpio_splitters[i], TYPE_SPLIT_IR=
Q);
+            gpio_out_splitter =3D DEVICE(&s->gpio_splitters[i]);
+            qdev_prop_set_uint32(gpio_out_splitter, "num-lines", 2);
+            qdev_realize(gpio_out_splitter, NULL, &error_fatal);
+
+            qdev_connect_gpio_out(gpio_out_splitter, 0,
+                qdev_get_gpio_in(DEVICE(&s->soc), dm163_input[i]));
+            qdev_connect_gpio_out(gpio_out_splitter, 1,
+                qdev_get_gpio_in(dev, i));
+            gpio =3D dm163_input[i] / GPIO_NUM_PINS;
+            pin =3D dm163_input[i] % GPIO_NUM_PINS;
+            qdev_connect_gpio_out(DEVICE(&s->soc.gpio[gpio]), pin,
+                qdev_get_gpio_in(DEVICE(gpio_out_splitter), 0));
+        }
+    }
 }
=20
 static void bl475e_machine_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 5776dbb19f..6c05bac99b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -458,6 +458,7 @@ config B_L475E_IOT01A
     default y
     depends on TCG && ARM
     select STM32L4X5_SOC
+    imply DM163
=20
 config STM32L4X5_SOC
     bool
--=20
2.43.2


