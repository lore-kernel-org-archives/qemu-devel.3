Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6719CCF8573
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 10:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swHA0-0003tp-EM; Thu, 03 Oct 2024 04:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1swH9m-0003sT-26
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 04:25:57 -0400
Received: from zproxy3.enst.fr ([2001:660:330f:2::de])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1swH9I-00059V-2k
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 04:25:49 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 0039CA0835;
 Thu,  3 Oct 2024 10:11:13 +0200 (CEST)
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id t65Z8H-bmKti; Thu,  3 Oct 2024 10:11:13 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 61FD4A0817;
 Thu,  3 Oct 2024 10:11:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy3.enst.fr 61FD4A0817
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1727943073;
 bh=bvCArfBxkPutYzyakD7t3ZBavD+tFjEHb8BCFcBKAmc=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=M+JyCmTMF878Q6rSgZUvzn4W5492/zmXDxsucy5e3B6DhAmX/2vGE7AX/B7l9rBBe
 kuKoM9wVZb4WoswhJL8dX66CSxWTQ5mUW/tFiKO2DP6v0kvLA84z2kseuPwS3okgUB
 qeHbecjlvLW4hXEo42b4y6pSMTNWjd2SXJ5lWOvg=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id zU-J1kxmMKz7; Thu,  3 Oct 2024 10:11:13 +0200 (CEST)
Received: from inesv-Inspiron-3501.enst.fr (unknown
 [IPv6:2a04:8ec0:0:124::190c])
 by zproxy3.enst.fr (Postfix) with ESMTPSA id 03272A0677;
 Thu,  3 Oct 2024 10:11:12 +0200 (CEST)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc@lmichel.fr>,
 qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Samuel Tardieu <sam@rfc1149.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Damien Hedde <damien.hedde@dahe.fr>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PING PATCH v5 1/3] hw/misc: Create STM32L4x5 SYSCFG clock
Date: Thu,  3 Oct 2024 10:10:04 +0200
Message-ID: <20241003081105.40836-2-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003081105.40836-1-ines.varhol@telecom-paris.fr>
References: <20241003081105.40836-1-ines.varhol@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:660:330f:2::de;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy3.enst.fr
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

This commit creates a clock in STM32L4x5 SYSCFG and wires it up to the
corresponding clock from STM32L4x5 RCC.

Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Reviewed-by: Luc Michel <luc@lmichel.fr>
---
 include/hw/misc/stm32l4x5_syscfg.h |  1 +
 hw/arm/stm32l4x5_soc.c             |  2 ++
 hw/misc/stm32l4x5_syscfg.c         | 19 +++++++++++++++++--
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/hw/misc/stm32l4x5_syscfg.h b/include/hw/misc/stm32l4=
x5_syscfg.h
index 23bb564150..c450df2b9e 100644
--- a/include/hw/misc/stm32l4x5_syscfg.h
+++ b/include/hw/misc/stm32l4x5_syscfg.h
@@ -48,6 +48,7 @@ struct Stm32l4x5SyscfgState {
     uint32_t swpr2;
=20
     qemu_irq gpio_out[GPIO_NUM_PINS];
+    Clock *clk;
 };
=20
 #endif
diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
index fac83d349c..16e3505dcb 100644
--- a/hw/arm/stm32l4x5_soc.c
+++ b/hw/arm/stm32l4x5_soc.c
@@ -236,6 +236,8 @@ static void stm32l4x5_soc_realize(DeviceState *dev_so=
c, Error **errp)
=20
     /* System configuration controller */
     busdev =3D SYS_BUS_DEVICE(&s->syscfg);
+    qdev_connect_clock_in(DEVICE(&s->syscfg), "clk",
+        qdev_get_clock_out(DEVICE(&(s->rcc)), "syscfg-out"));
     if (!sysbus_realize(busdev, errp)) {
         return;
     }
diff --git a/hw/misc/stm32l4x5_syscfg.c b/hw/misc/stm32l4x5_syscfg.c
index a5a1ce2680..a947a9e036 100644
--- a/hw/misc/stm32l4x5_syscfg.c
+++ b/hw/misc/stm32l4x5_syscfg.c
@@ -26,6 +26,9 @@
 #include "trace.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
+#include "hw/clock.h"
+#include "hw/qdev-clock.h"
+#include "qapi/error.h"
 #include "hw/misc/stm32l4x5_syscfg.h"
 #include "hw/gpio/stm32l4x5_gpio.h"
=20
@@ -225,12 +228,22 @@ static void stm32l4x5_syscfg_init(Object *obj)
     qdev_init_gpio_in(DEVICE(obj), stm32l4x5_syscfg_set_irq,
                       GPIO_NUM_PINS * NUM_GPIOS);
     qdev_init_gpio_out(DEVICE(obj), s->gpio_out, GPIO_NUM_PINS);
+    s->clk =3D qdev_init_clock_in(DEVICE(s), "clk", NULL, s, 0);
+}
+
+static void stm32l4x5_syscfg_realize(DeviceState *dev, Error **errp)
+{
+    Stm32l4x5SyscfgState *s =3D STM32L4X5_SYSCFG(dev);
+    if (!clock_has_source(s->clk)) {
+        error_setg(errp, "SYSCFG: clk input must be connected");
+        return;
+    }
 }
=20
 static const VMStateDescription vmstate_stm32l4x5_syscfg =3D {
     .name =3D TYPE_STM32L4X5_SYSCFG,
-    .version_id =3D 1,
-    .minimum_version_id =3D 1,
+    .version_id =3D 2,
+    .minimum_version_id =3D 2,
     .fields =3D (VMStateField[]) {
         VMSTATE_UINT32(memrmp, Stm32l4x5SyscfgState),
         VMSTATE_UINT32(cfgr1, Stm32l4x5SyscfgState),
@@ -241,6 +254,7 @@ static const VMStateDescription vmstate_stm32l4x5_sys=
cfg =3D {
         VMSTATE_UINT32(swpr, Stm32l4x5SyscfgState),
         VMSTATE_UINT32(skr, Stm32l4x5SyscfgState),
         VMSTATE_UINT32(swpr2, Stm32l4x5SyscfgState),
+        VMSTATE_CLOCK(clk, Stm32l4x5SyscfgState),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -251,6 +265,7 @@ static void stm32l4x5_syscfg_class_init(ObjectClass *=
klass, void *data)
     ResettableClass *rc =3D RESETTABLE_CLASS(klass);
=20
     dc->vmsd =3D &vmstate_stm32l4x5_syscfg;
+    dc->realize =3D stm32l4x5_syscfg_realize;
     rc->phases.hold =3D stm32l4x5_syscfg_hold_reset;
 }
=20
--=20
2.45.2


