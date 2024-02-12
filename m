Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16ACC48297
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 16:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZZGw-0001qS-3H; Mon, 12 Feb 2024 11:35:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rZZGs-0001oV-GQ; Mon, 12 Feb 2024 11:35:06 -0500
Received: from zproxy3.enst.fr ([2001:660:330f:2::de])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rZZGp-0005QC-NW; Mon, 12 Feb 2024 11:35:06 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 85CEDA05CA;
 Mon, 12 Feb 2024 17:34:58 +0100 (CET)
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id zL45G7oJ_mLp; Mon, 12 Feb 2024 17:34:58 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 16EB2A05A3;
 Mon, 12 Feb 2024 17:34:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy3.enst.fr 16EB2A05A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1707755698;
 bh=scyeiFfkQka8Kw8QvyJDLFkJvhFstNYunlYlNOr7e6o=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=HbHPrZXoY56kVu0wd5mEh9LIa+DEYGmXF0Z2cpAsVAuaKDJISF5bx6L7x427eHksd
 LL5HTYLuieFrIbhyNcwKUzXOyxug53kX+Av5mvdAKC19FuITJS04BTyDUjZoAk8v5J
 twMb7/lt14gGW+oaik1jldAwZx2Con1fMk9+o9aE=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id gBkBp8hBzfaY; Mon, 12 Feb 2024 17:34:58 +0100 (CET)
Received: from localhost.localdomain (74.0.125.80.rev.sfr.net [80.125.0.74])
 by zproxy3.enst.fr (Postfix) with ESMTPSA id BC342A056F;
 Mon, 12 Feb 2024 17:34:57 +0100 (CET)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
Subject: [PATCH 1/2] hw/arm: Use TYPE_OR_IRQ when connecting STM32L4x5 EXTI
 fan-in IRQs
Date: Mon, 12 Feb 2024 17:31:18 +0100
Message-ID: <20240212163446.227802-2-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212163446.227802-1-ines.varhol@telecom-paris.fr>
References: <20240212163446.227802-1-ines.varhol@telecom-paris.fr>
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

Fixes: 52671f69f7a4 ("[PATCH v8 0/3] Add device STM32L4x5 EXTI")
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 hw/arm/stm32l4x5_soc.c | 69 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 10 deletions(-)

diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
index f470ff74ec..df5bb02315 100644
--- a/hw/arm/stm32l4x5_soc.c
+++ b/hw/arm/stm32l4x5_soc.c
@@ -26,6 +26,7 @@
 #include "qapi/error.h"
 #include "exec/address-spaces.h"
 #include "sysemu/sysemu.h"
+#include "hw/or-irq.h"
 #include "hw/arm/stm32l4x5_soc.h"
 #include "hw/qdev-clock.h"
 #include "hw/misc/unimp.h"
@@ -48,15 +49,14 @@ static const int exti_irq[NUM_EXTI_IRQ] =3D {
     8,                      /* GPIO[2]                 */
     9,                      /* GPIO[3]                 */
     10,                     /* GPIO[4]                 */
-    23, 23, 23, 23, 23,     /* GPIO[5..9]              */
-    40, 40, 40, 40, 40, 40, /* GPIO[10..15]            */
-    1,                      /* PVD                     */
+    -1, -1, -1, -1, -1,     /* GPIO[5..9] OR gate 23   */
+    -1, -1, -1, -1, -1, -1, /* GPIO[10..15] OR gate 40 */
+    -1,                     /* PVD OR gate 1           */
     67,                     /* OTG_FS_WKUP, Direct     */
     41,                     /* RTC_ALARM               */
     2,                      /* RTC_TAMP_STAMP2/CSS_LSE */
     3,                      /* RTC wakeup timer        */
-    63,                     /* COMP1                   */
-    63,                     /* COMP2                   */
+    -1, -1,                 /* COMP[1..2] OR gate 63   */
     31,                     /* I2C1 wakeup, Direct     */
     33,                     /* I2C2 wakeup, Direct     */
     72,                     /* I2C3 wakeup, Direct     */
@@ -69,13 +69,29 @@ static const int exti_irq[NUM_EXTI_IRQ] =3D {
     65,                     /* LPTIM1, Direct          */
     66,                     /* LPTIM2, Direct          */
     76,                     /* SWPMI1 wakeup, Direct   */
-    1,                      /* PVM1 wakeup             */
-    1,                      /* PVM2 wakeup             */
-    1,                      /* PVM3 wakeup             */
-    1,                      /* PVM4 wakeup             */
+    -1, -1, -1, -1,         /* PVM[1..4] OR gate 1     */
     78                      /* LCD wakeup, Direct      */
 };
=20
+#define NUM_EXTI_OR_GATES 4
+static const int exti_or_gates_out[NUM_EXTI_OR_GATES] =3D {
+    23, 40, 63, 1,
+};
+
+#define NUM_EXTI_SIMPLE_FANIN_IRQ 3
+static const int exti_or_gates_num_lines_in[NUM_EXTI_SIMPLE_FANIN_IRQ] =3D=
 {
+    5, 6, 2,
+};
+
+static const int exti_or_gates_first_line_in[NUM_EXTI_SIMPLE_FANIN_IRQ] =
=3D {
+    5, 10, 21,
+};
+
+#define NUM_EXTI_OR_GATE1_NUM_LINES_IN 5
+static const int exti_or_gate1_lines_in[NUM_EXTI_OR_GATE1_NUM_LINES_IN] =
=3D {
+    16, 35, 36, 37, 38,
+};
+
 static void stm32l4x5_soc_initfn(Object *obj)
 {
     Stm32l4x5SocState *s =3D STM32L4X5_SOC(obj);
@@ -175,8 +191,41 @@ static void stm32l4x5_soc_realize(DeviceState *dev_s=
oc, Error **errp)
         return;
     }
     sysbus_mmio_map(busdev, 0, EXTI_ADDR);
+
+    /* IRQs with fan-in that require an OR gate */
+    for (unsigned i =3D 0; i < NUM_EXTI_OR_GATES; i++) {
+        Object *orgate =3D object_new(TYPE_OR_IRQ);
+        object_property_set_int(orgate, "num-lines",
+            exti_or_gates_num_lines_in[i], &error_fatal);
+        /* Should unref be used? */
+        qdev_realize(DEVICE(orgate), NULL, &error_fatal);
+
+        qdev_connect_gpio_out(DEVICE(orgate), 0,
+            qdev_get_gpio_in(armv7m, exti_or_gates_out[i]));
+
+        /* consecutive inputs for OR gates 23, 40, 63 */
+        if (i < NUM_EXTI_SIMPLE_FANIN_IRQ) {
+            for (unsigned j =3D 0; j < exti_or_gates_num_lines_in[i]; j+=
+) {
+                sysbus_connect_irq(SYS_BUS_DEVICE(&s->exti),
+                    exti_or_gates_first_line_in[i] + j,
+                    qdev_get_gpio_in(DEVICE(orgate), j));
+            }
+        /* non-consecutive inputs for OR gate 1 */
+        } else {
+            for (unsigned j =3D 0; j < NUM_EXTI_OR_GATE1_NUM_LINES_IN; j=
++) {
+                sysbus_connect_irq(SYS_BUS_DEVICE(&s->exti),
+                    exti_or_gate1_lines_in[j],
+                    qdev_get_gpio_in(DEVICE(orgate), j));
+            }
+        }
+    }
+
+    /* IRQs that don't require fan-in */
     for (unsigned i =3D 0; i < NUM_EXTI_IRQ; i++) {
-        sysbus_connect_irq(busdev, i, qdev_get_gpio_in(armv7m, exti_irq[=
i]));
+        if (exti_irq[i] !=3D -1) {
+            sysbus_connect_irq(busdev, i,
+                               qdev_get_gpio_in(armv7m, exti_irq[i]));
+        }
     }
=20
     for (unsigned i =3D 0; i < 16; i++) {
--=20
2.43.0


