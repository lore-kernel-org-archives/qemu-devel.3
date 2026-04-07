Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A6A10F9968
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYY8-0002PX-FH; Wed, 08 Apr 2026 15:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wAY7Y-0007lw-HZ; Wed, 08 Apr 2026 14:59:25 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wAQmk-00035t-8n; Wed, 08 Apr 2026 07:09:29 -0400
DKIM-Signature: a=rsa-sha256; bh=/Zna+JATdyWeJjMwRk+2e7Vw5Q4F0U1k4BLu0T0n7tA=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1775646440; v=1;
 b=Po/JfeTkprfyID71oPOEZIf8hPrgZ2/jpBIylYfa4/epPgaNexiLSv5fdLaoi4KyyhTGMoc9
 Ffel0QsDS7GGBj1WfCq/ZcUl5V8iSaU/afv1uUPw9Nb/VDgIm8A1UYczfFAZwnmIuX7tLG8D5LT
 5rRGhr7vrDS+w+PXh7IrYuWbSd5SHUsFSE8ByQp4tHFsQo4YUnKRkCg2X75UxncGqxpMPGGfnUr
 p2k3K6DuAEyOBGSqDYu9I9HmPPf3W0uKt/esC1WDsDnyJiSH8UTnNLPzNyztczVyghwY+ZvEAAf
 btxkrC3um3mwbY6S2yqP0EuuwtZE9LOCu/jMw2IiHS4BQ==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 91DE9207F6;
 Wed, 08 Apr 2026 11:07:20 +0000 (UTC)
From: ~lexbaileylowrisc <lexbaileylowrisc@git.sr.ht>
Date: Tue, 07 Apr 2026 10:43:43 +0100
Subject: [PATCH qemu v2 2/7] ot_uart: move to new reset API
Message-ID: <177564643888.23414.7922925369077631439-2@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <177564643888.23414.7922925369077631439-0@git.sr.ht>
To: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org,
 Amit Kumar-Hermosillo <amitkh@google.com>, nabihestefan@google.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~lexbaileylowrisc <lex.bailey@lowrisc.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Lex Bailey <lex.bailey@lowrisc.org>

switch from legacy_reset to new ResettableClass for OpenTitan UART device

Signed-off-by: Lex Bailey <lex.bailey@lowrisc.org>
---
 hw/char/ot_uart.c         | 16 +++++++++++++---
 include/hw/char/ot_uart.h |  8 +++++++-
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/hw/char/ot_uart.c b/hw/char/ot_uart.c
index b3eb619641..2cf0d73cf5 100644
--- a/hw/char/ot_uart.c
+++ b/hw/char/ot_uart.c
@@ -227,9 +227,14 @@ static void uart_write_tx_fifo(OtUARTState *s, const uin=
t8_t *buf,
               (s->char_tx_time * 4));
 }
=20
-static void ot_uart_reset(DeviceState *dev)
+static void ot_uart_reset_enter(Object *obj, ResetType type)
 {
-    OtUARTState *s =3D OT_UART(dev);
+    OtUARTClass *c =3D OT_UART_GET_CLASS(obj);
+    OtUARTState *s =3D OT_UART(obj);
+
+    if (c->parent_phases.enter) {
+        c->parent_phases.enter(obj, type);
+    }
=20
     s->uart_intr_state =3D 0x00000000;
     s->uart_intr_state =3D 0x00000000;
@@ -545,11 +550,15 @@ static void ot_uart_class_init(ObjectClass *klass, cons=
t void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
-    device_class_set_legacy_reset(dc, ot_uart_reset);
     dc->realize =3D ot_uart_realize;
     dc->vmsd =3D &vmstate_ot_uart;
     device_class_set_props(dc, ot_uart_properties);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
+    OtUARTClass *uc =3D OT_UART_CLASS(klass);
+    resettable_class_set_parent_phases(rc, &ot_uart_reset_enter, NULL, NULL,
+                                       &uc->parent_phases);
 }
=20
 static const TypeInfo ot_uart_info =3D {
@@ -557,6 +566,7 @@ static const TypeInfo ot_uart_info =3D {
     .parent        =3D TYPE_SYS_BUS_DEVICE,
     .instance_size =3D sizeof(OtUARTState),
     .instance_init =3D ot_uart_init,
+    .class_size    =3D sizeof(OtUARTClass),
     .class_init    =3D ot_uart_class_init,
 };
=20
diff --git a/include/hw/char/ot_uart.h b/include/hw/char/ot_uart.h
index 517324b65d..fee2128f90 100644
--- a/include/hw/char/ot_uart.h
+++ b/include/hw/char/ot_uart.h
@@ -34,7 +34,7 @@
 #define OT_UART_CLOCK 50000000 /* 50MHz clock */
=20
 #define TYPE_OT_UART "ot-uart"
-OBJECT_DECLARE_SIMPLE_TYPE(OtUARTState, OT_UART)
+OBJECT_DECLARE_TYPE(OtUARTState, OtUARTClass, OT_UART)
=20
 struct OtUARTState {
     /* <private> */
@@ -70,4 +70,10 @@ struct OtUARTState {
     qemu_irq tx_empty;
     qemu_irq rx_overflow;
 };
+
+struct OtUARTClass {
+    SysBusDeviceClass parent_class;
+    ResettablePhases parent_phases;
+};
+
 #endif /* HW_OT_UART_H */
--=20
2.49.1


