Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6860C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 19:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Q21-0008H9-V9; Tue, 07 May 2024 14:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1s4Q1w-0008Bt-HT; Tue, 07 May 2024 14:59:12 -0400
Received: from zproxy1.enst.fr ([2001:660:330f:2::dc])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1s4Q1t-0006A4-MQ; Tue, 07 May 2024 14:59:12 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id 85E3DC0D3F;
 Tue,  7 May 2024 20:59:04 +0200 (CEST)
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id VAau2JE9SW-Y; Tue,  7 May 2024 20:59:04 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id 1587DC0D05;
 Tue,  7 May 2024 20:59:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy1.enst.fr 1587DC0D05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1715108344;
 bh=8WY7FPCMeDaVAjElScVdMsk4+TnEkPYI0LCuWMFgYlQ=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=A5AN8RcijYSZOx1gB9XgmWHmwrWQXXsyyUATsDF3R2Ld6hRUzE8wdpIhhzrpUsS3T
 yLGP3ZeJXRiVCXhsliOoto/0IK1bsaW+Al/3N33pCkqPVp4i//Bn4MwjJFxVZvGr2C
 lVwZqDV7+B997BajUwz0/+MmD46C05Y+bk9i3vX0=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id RriOPoC-sk-q; Tue,  7 May 2024 20:59:04 +0200 (CEST)
Received: from inesv-Inspiron-3501.enst.fr (unknown
 [IPv6:2a04:8ec0:0:124::190c])
 by zproxy1.enst.fr (Postfix) with ESMTPSA id 2B4FBC0D2E;
 Tue,  7 May 2024 20:59:03 +0200 (CEST)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/4] hw/misc: Create STM32L4x5 SYSCFG clock
Date: Tue,  7 May 2024 20:55:38 +0200
Message-ID: <20240507185854.34572-2-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240507185854.34572-1-ines.varhol@telecom-paris.fr>
References: <20240507185854.34572-1-ines.varhol@telecom-paris.fr>
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

This commit creates a clock in STM32L4x5 SYSCFG and wires it up to the
corresponding clock from STM32L4x5 RCC.
A read-only QOM property allowing to read the clock frequency is added
(it will be used in a QTest).

Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---

Hello,

Several people noticed that replicating the code in the
different devices is a bad idea (cf cover letter).
One proposition is to directly add the clock property
in `qdev_init_clock_in()`.
Would that be acceptable and are there other alternatives
(allowing to the clock frequency from a Qtest)?

Best regards,

In=C3=A8s Varhol

 include/hw/misc/stm32l4x5_syscfg.h |  1 +
 hw/arm/stm32l4x5_soc.c             |  2 ++
 hw/misc/stm32l4x5_syscfg.c         | 30 ++++++++++++++++++++++++++++--
 3 files changed, 31 insertions(+), 2 deletions(-)

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
index 38f7a2d5d9..fb2afa6cfe 100644
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
index a5a1ce2680..7e6125383e 100644
--- a/hw/misc/stm32l4x5_syscfg.c
+++ b/hw/misc/stm32l4x5_syscfg.c
@@ -26,6 +26,10 @@
 #include "trace.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
+#include "hw/clock.h"
+#include "hw/qdev-clock.h"
+#include "qapi/visitor.h"
+#include "qapi/error.h"
 #include "hw/misc/stm32l4x5_syscfg.h"
 #include "hw/gpio/stm32l4x5_gpio.h"
=20
@@ -202,6 +206,14 @@ static void stm32l4x5_syscfg_write(void *opaque, hwa=
ddr addr,
     }
 }
=20
+static void clock_freq_get(Object *obj, Visitor *v,
+    const char *name, void *opaque, Error **errp)
+{
+    Stm32l4x5SyscfgState *s =3D STM32L4X5_SYSCFG(obj);
+    uint32_t clock_freq_hz =3D clock_get_hz(s->clk);
+    visit_type_uint32(v, name, &clock_freq_hz, errp);
+}
+
 static const MemoryRegionOps stm32l4x5_syscfg_ops =3D {
     .read =3D stm32l4x5_syscfg_read,
     .write =3D stm32l4x5_syscfg_write,
@@ -225,12 +237,24 @@ static void stm32l4x5_syscfg_init(Object *obj)
     qdev_init_gpio_in(DEVICE(obj), stm32l4x5_syscfg_set_irq,
                       GPIO_NUM_PINS * NUM_GPIOS);
     qdev_init_gpio_out(DEVICE(obj), s->gpio_out, GPIO_NUM_PINS);
+    s->clk =3D qdev_init_clock_in(DEVICE(s), "clk", NULL, s, 0);
+    object_property_add(obj, "clock-freq-hz", "uint32", clock_freq_get, =
NULL,
+                        NULL, NULL);
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
@@ -241,6 +265,7 @@ static const VMStateDescription vmstate_stm32l4x5_sys=
cfg =3D {
         VMSTATE_UINT32(swpr, Stm32l4x5SyscfgState),
         VMSTATE_UINT32(skr, Stm32l4x5SyscfgState),
         VMSTATE_UINT32(swpr2, Stm32l4x5SyscfgState),
+        VMSTATE_CLOCK(clk, Stm32l4x5SyscfgState),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -251,6 +276,7 @@ static void stm32l4x5_syscfg_class_init(ObjectClass *=
klass, void *data)
     ResettableClass *rc =3D RESETTABLE_CLASS(klass);
=20
     dc->vmsd =3D &vmstate_stm32l4x5_syscfg;
+    dc->realize =3D stm32l4x5_syscfg_realize;
     rc->phases.hold =3D stm32l4x5_syscfg_hold_reset;
 }
=20
--=20
2.43.2


