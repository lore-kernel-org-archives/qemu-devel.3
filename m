Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFD1C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 20:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rziwq-0004Dc-4Y; Wed, 24 Apr 2024 16:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rziwJ-0003so-CW; Wed, 24 Apr 2024 16:10:00 -0400
Received: from zproxy3.enst.fr ([2001:660:330f:2::de])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rziw7-00011C-Pb; Wed, 24 Apr 2024 16:09:54 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 6CEECA07AD;
 Wed, 24 Apr 2024 22:09:41 +0200 (CEST)
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id s9r4KhlXXhMS; Wed, 24 Apr 2024 22:09:41 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id CB632A077C;
 Wed, 24 Apr 2024 22:09:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy3.enst.fr CB632A077C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1713989380;
 bh=5CFKEPqz+1ZcgxhABmTozLTGT1xbD7H5nOrjny7q8kM=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=U0pMAy7sOTbFUx+iUB1uVr2TQ1bZWnUdMQvK1MxqFSzpV3GJzFACLJGZ62uYS9WEM
 Z0WZQWwOTKTm6bHoweHpjpv+M8uoM+mn9iv+UxwvOzqfula212qQVw/Bn2YLAnJbp8
 xGtiOnhkultqu0n7vAv6NDzehzX1sMV+KSoqy8H0=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id F_ag3Zp957gh; Wed, 24 Apr 2024 22:09:40 +0200 (CEST)
Received: from inesv-Inspiron-3501.. (unknown
 [IPv6:2a02:1808:204:e56c:df60:5720:79e:c1dd])
 by zproxy3.enst.fr (Postfix) with ESMTPSA id CC53FA0790;
 Wed, 24 Apr 2024 22:09:39 +0200 (CEST)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Samuel Tardieu <sam@rfc1149.net>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v6 4/5] hw/arm : Connect DM163 to B-L475E-IOT01A
Date: Wed, 24 Apr 2024 22:06:54 +0200
Message-ID: <20240424200929.240921-5-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240424200929.240921-1-ines.varhol@telecom-paris.fr>
References: <20240424200929.240921-1-ines.varhol@telecom-paris.fr>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
---
 hw/arm/b-l475e-iot01a.c | 59 +++++++++++++++++++++++++++++++++++++++--
 hw/arm/Kconfig          |  1 +
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
index 970c637ce6..5002a40f06 100644
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
+static const unsigned dm163_input[NUM_DM163_INPUTS] =3D {
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
+    unsigned gpio, pin;
=20
     object_initialize_child(OBJECT(machine), "soc", &s->soc,
                             TYPE_STM32L4X5XG_SOC);
@@ -53,6 +84,30 @@ static void bl475e_init(MachineState *machine)
     sc =3D STM32L4X5_SOC_GET_CLASS(&s->soc);
     armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename, 0,
                        sc->flash_size);
+
+    if (object_class_by_name(TYPE_DM163)) {
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
index 893a7bff66..8431384402 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -468,6 +468,7 @@ config B_L475E_IOT01A
     default y
     depends on TCG && ARM
     select STM32L4X5_SOC
+    imply DM163
=20
 config STM32L4X5_SOC
     bool
--=20
2.43.2


