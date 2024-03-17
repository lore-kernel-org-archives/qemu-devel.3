Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6428EC54E60
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Mar 2024 10:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlnxR-00036L-1b; Sun, 17 Mar 2024 06:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnaud.minier@telecom-paris.fr>)
 id 1rlnx7-0002j0-SY; Sun, 17 Mar 2024 06:41:19 -0400
Received: from zproxy4.enst.fr ([137.194.2.223])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnaud.minier@telecom-paris.fr>)
 id 1rlnx3-0001PG-6W; Sun, 17 Mar 2024 06:41:16 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 958B7205A4;
 Sun, 17 Mar 2024 11:41:10 +0100 (CET)
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id ZyZmxp1mnQN3; Sun, 17 Mar 2024 11:41:09 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id C858B2061D;
 Sun, 17 Mar 2024 11:41:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy4.enst.fr C858B2061D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1710672068;
 bh=5GDvnMu2ewIpK7fNk9UMMPgm5GCnbCl9hPbVOlmLn+A=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=ryd0oXLo5rPZ4Uxto/c1tWLq/Jh8kJZZ6J+J0uvRR2kNH8n4/c0znnSSQJONtJhm9
 0T40wNskuI/yqvuy/+t0rKd3jbpEjKQP8vBq7K/LEMn7essjUpeksh70CdErZvvRuq
 KXd58KwAQY53FF6LfdqaYozhDb33bRvOicTJPytc=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id LYl-nYQxjC9L; Sun, 17 Mar 2024 11:41:08 +0100 (CET)
Received: from AM-Inspiron-3585.. (cust-west-par-46-193-4-103.cust.wifirst.net
 [46.193.4.103])
 by zproxy4.enst.fr (Postfix) with ESMTPSA id CB612205F4;
 Sun, 17 Mar 2024 11:41:07 +0100 (CET)
From: Arnaud Minier <arnaud.minier@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>
Subject: [PATCH 3/7] hw/char/stm32l4x5_usart: Add USART, UART, LPUART types
Date: Sun, 17 Mar 2024 11:39:14 +0100
Message-Id: <20240317103918.44375-4-arnaud.minier@telecom-paris.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240317103918.44375-1-arnaud.minier@telecom-paris.fr>
References: <20240317103918.44375-1-arnaud.minier@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.223;
 envelope-from=arnaud.minier@telecom-paris.fr; helo=zproxy4.enst.fr
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

Create different types for the USART, UART and LPUART of the STM32L4x5
to deduplicate code and enable the implementation of different
behaviors depending on the type.

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 hw/char/stm32l4x5_usart.c         | 113 +++++++++++++++++++-----------
 include/hw/char/stm32l4x5_usart.h |  21 +++++-
 2 files changed, 92 insertions(+), 42 deletions(-)

diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
index b56fee5b3a..f58bd56875 100644
--- a/hw/char/stm32l4x5_usart.c
+++ b/hw/char/stm32l4x5_usart.c
@@ -154,9 +154,9 @@ REG32(RDR, 0x24)
 REG32(TDR, 0x28)
     FIELD(TDR, TDR, 0, 8)
=20
-static void stm32l4x5_usart_reset_hold(Object *obj)
+static void stm32l4x5_usart_base_reset_hold(Object *obj)
 {
-    STM32L4X5UsartState *s =3D STM32L4X5_USART(obj);
+    Stm32l4x5UsartBaseState *s =3D STM32L4X5_USART_BASE(obj);
=20
     s->cr1 =3D 0x00000000;
     s->cr2 =3D 0x00000000;
@@ -170,10 +170,10 @@ static void stm32l4x5_usart_reset_hold(Object *obj)
     s->tdr =3D 0x00000000;
 }
=20
-static uint64_t stm32l4x5_usart_read(void *opaque, hwaddr addr,
-                                       unsigned int size)
+static uint64_t stm32l4x5_usart_base_read(void *opaque, hwaddr addr,
+                                     unsigned int size)
 {
-    STM32L4X5UsartState *s =3D opaque;
+    Stm32l4x5UsartBaseState *s =3D opaque;
     uint64_t retvalue =3D 0;
=20
     switch (addr) {
@@ -225,10 +225,10 @@ static uint64_t stm32l4x5_usart_read(void *opaque, =
hwaddr addr,
     return retvalue;
 }
=20
-static void stm32l4x5_usart_write(void *opaque, hwaddr addr,
+static void stm32l4x5_usart_base_write(void *opaque, hwaddr addr,
                                   uint64_t val64, unsigned int size)
 {
-    STM32L4X5UsartState *s =3D opaque;
+    Stm32l4x5UsartBaseState *s =3D opaque;
     const uint32_t value =3D val64;
     uint8_t ch;
=20
@@ -276,9 +276,9 @@ static void stm32l4x5_usart_write(void *opaque, hwadd=
r addr,
     }
 }
=20
-static const MemoryRegionOps stm32l4x5_usart_ops =3D {
-    .read =3D stm32l4x5_usart_read,
-    .write =3D stm32l4x5_usart_write,
+static const MemoryRegionOps stm32l4x5_usart_base_ops =3D {
+    .read =3D stm32l4x5_usart_base_read,
+    .write =3D stm32l4x5_usart_base_write,
     .endianness =3D DEVICE_NATIVE_ENDIAN,
     .valid =3D {
         .max_access_size =3D 4,
@@ -292,72 +292,105 @@ static const MemoryRegionOps stm32l4x5_usart_ops =3D=
 {
     },
 };
=20
-static Property stm32l4x5_usart_properties[] =3D {
-    DEFINE_PROP_CHR("chardev", STM32L4X5UsartState, chr),
+static Property stm32l4x5_usart_base_properties[] =3D {
+    DEFINE_PROP_CHR("chardev", Stm32l4x5UsartBaseState, chr),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
-static void stm32l4x5_usart_init(Object *obj)
+static void stm32l4x5_usart_base_init(Object *obj)
 {
-    STM32L4X5UsartState *s =3D STM32L4X5_USART(obj);
+    Stm32l4x5UsartBaseState *s =3D STM32L4X5_USART_BASE(obj);
=20
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
=20
-    memory_region_init_io(&s->mmio, obj, &stm32l4x5_usart_ops, s,
-                          TYPE_STM32L4X5_USART, 0x400);
+    memory_region_init_io(&s->mmio, obj, &stm32l4x5_usart_base_ops, s,
+                          TYPE_STM32L4X5_USART_BASE, 0x400);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
=20
     s->clk =3D qdev_init_clock_in(DEVICE(s), "clk", NULL, s, 0);
 }
=20
-static const VMStateDescription vmstate_stm32l4x5_usart =3D {
-    .name =3D TYPE_STM32L4X5_USART,
+static const VMStateDescription vmstate_stm32l4x5_usart_base =3D {
+    .name =3D TYPE_STM32L4X5_USART_BASE,
     .version_id =3D 1,
     .minimum_version_id =3D 1,
     .fields =3D (VMStateField[]) {
-        VMSTATE_UINT32(cr1, STM32L4X5UsartState),
-        VMSTATE_UINT32(cr2, STM32L4X5UsartState),
-        VMSTATE_UINT32(cr3, STM32L4X5UsartState),
-        VMSTATE_UINT32(brr, STM32L4X5UsartState),
-        VMSTATE_UINT32(gtpr, STM32L4X5UsartState),
-        VMSTATE_UINT32(rtor, STM32L4X5UsartState),
-        VMSTATE_UINT32(isr, STM32L4X5UsartState),
-        VMSTATE_UINT32(rdr, STM32L4X5UsartState),
-        VMSTATE_UINT32(tdr, STM32L4X5UsartState),
-        VMSTATE_CLOCK(clk, STM32L4X5UsartState),
+        VMSTATE_UINT32(cr1, Stm32l4x5UsartBaseState),
+        VMSTATE_UINT32(cr2, Stm32l4x5UsartBaseState),
+        VMSTATE_UINT32(cr3, Stm32l4x5UsartBaseState),
+        VMSTATE_UINT32(brr, Stm32l4x5UsartBaseState),
+        VMSTATE_UINT32(gtpr, Stm32l4x5UsartBaseState),
+        VMSTATE_UINT32(rtor, Stm32l4x5UsartBaseState),
+        VMSTATE_UINT32(isr, Stm32l4x5UsartBaseState),
+        VMSTATE_UINT32(rdr, Stm32l4x5UsartBaseState),
+        VMSTATE_UINT32(tdr, Stm32l4x5UsartBaseState),
+        VMSTATE_CLOCK(clk, Stm32l4x5UsartBaseState),
         VMSTATE_END_OF_LIST()
     }
 };
=20
=20
-static void stm32l4x5_usart_realize(DeviceState *dev, Error **errp)
+static void stm32l4x5_usart_base_realize(DeviceState *dev, Error **errp)
 {
     ERRP_GUARD();
-    STM32L4X5UsartState *s =3D STM32L4X5_USART(dev);
+    Stm32l4x5UsartBaseState *s =3D STM32L4X5_USART_BASE(dev);
     if (!clock_has_source(s->clk)) {
         error_setg(errp, "USART clock must be wired up by SoC code");
         return;
     }
 }
=20
-static void stm32l4x5_usart_class_init(ObjectClass *klass, void *data)
+static void stm32l4x5_usart_base_class_init(ObjectClass *klass, void *da=
ta)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     ResettableClass *rc =3D RESETTABLE_CLASS(klass);
=20
-    rc->phases.hold =3D stm32l4x5_usart_reset_hold;
-    device_class_set_props(dc, stm32l4x5_usart_properties);
-    dc->realize =3D stm32l4x5_usart_realize;
-    dc->vmsd =3D &vmstate_stm32l4x5_usart;
+    rc->phases.hold =3D stm32l4x5_usart_base_reset_hold;
+    device_class_set_props(dc, stm32l4x5_usart_base_properties);
+    dc->realize =3D stm32l4x5_usart_base_realize;
+    dc->vmsd =3D &vmstate_stm32l4x5_usart_base;
+}
+
+static void stm32l4x5_usart_class_init(ObjectClass *oc, void *data)
+{
+    Stm32l4x5UsartBaseClass *subc =3D STM32L4X5_USART_BASE_CLASS(oc);
+
+    subc->type =3D STM32L4x5_USART;
+}
+
+static void stm32l4x5_uart_class_init(ObjectClass *oc, void *data)
+{
+    Stm32l4x5UsartBaseClass *subc =3D STM32L4X5_USART_BASE_CLASS(oc);
+
+    subc->type =3D STM32L4x5_UART;
+}
+
+static void stm32l4x5_lpuart_class_init(ObjectClass *oc, void *data)
+{
+    Stm32l4x5UsartBaseClass *subc =3D STM32L4X5_USART_BASE_CLASS(oc);
+
+    subc->type =3D STM32L4x5_LPUART;
 }
=20
 static const TypeInfo stm32l4x5_usart_types[] =3D {
     {
-        .name          =3D TYPE_STM32L4X5_USART,
-        .parent        =3D TYPE_SYS_BUS_DEVICE,
-        .instance_size =3D sizeof(STM32L4X5UsartState),
-        .instance_init =3D stm32l4x5_usart_init,
-        .class_init    =3D stm32l4x5_usart_class_init,
+        .name           =3D TYPE_STM32L4X5_USART_BASE,
+        .parent         =3D TYPE_SYS_BUS_DEVICE,
+        .instance_size  =3D sizeof(Stm32l4x5UsartBaseState),
+        .instance_init  =3D stm32l4x5_usart_base_init,
+        .class_init     =3D stm32l4x5_usart_base_class_init,
+    }, {
+        .name           =3D TYPE_STM32L4X5_USART,
+        .parent         =3D TYPE_STM32L4X5_USART_BASE,
+        .class_init     =3D stm32l4x5_usart_class_init,
+    }, {
+        .name           =3D TYPE_STM32L4X5_UART,
+        .parent         =3D TYPE_STM32L4X5_USART_BASE,
+        .class_init     =3D stm32l4x5_uart_class_init,
+    }, {
+        .name           =3D TYPE_STM32L4X5_LPUART,
+        .parent         =3D TYPE_STM32L4X5_USART_BASE,
+        .class_init     =3D stm32l4x5_lpuart_class_init,
     }
 };
=20
diff --git a/include/hw/char/stm32l4x5_usart.h b/include/hw/char/stm32l4x=
5_usart.h
index 8ec1b7afed..8d38a85a6e 100644
--- a/include/hw/char/stm32l4x5_usart.h
+++ b/include/hw/char/stm32l4x5_usart.h
@@ -22,10 +22,20 @@
 #include "chardev/char-fe.h"
 #include "qom/object.h"
=20
+#define TYPE_STM32L4X5_USART_BASE "stm32l4x5-usart-base"
 #define TYPE_STM32L4X5_USART "stm32l4x5-usart"
-OBJECT_DECLARE_SIMPLE_TYPE(STM32L4X5UsartState, STM32L4X5_USART)
+#define TYPE_STM32L4X5_UART "stm32l4x5-uart"
+#define TYPE_STM32L4X5_LPUART "stm32l4x5-lpuart"
+OBJECT_DECLARE_TYPE(Stm32l4x5UsartBaseState, Stm32l4x5UsartBaseClass,
+                    STM32L4X5_USART_BASE)
=20
-struct STM32L4X5UsartState {
+typedef enum {
+    STM32L4x5_USART,
+    STM32L4x5_UART,
+    STM32L4x5_LPUART,
+} Stm32l4x5UsartType;
+
+struct Stm32l4x5UsartBaseState {
     SysBusDevice parent_obj;
=20
     MemoryRegion mmio;
@@ -46,4 +56,11 @@ struct STM32L4X5UsartState {
     CharBackend chr;
     qemu_irq irq;
 };
+
+struct Stm32l4x5UsartBaseClass {
+    SysBusDeviceClass parent_class;
+
+    Stm32l4x5UsartType type;
+};
+
 #endif /* HW_STM32L4X5_USART_H */
--=20
2.34.1


