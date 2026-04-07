Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82862CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 16:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITse-00028Q-Az; Thu, 30 Apr 2026 12:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wITrH-0007Vu-BP; Thu, 30 Apr 2026 12:03:24 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wITr9-00078N-FN; Thu, 30 Apr 2026 12:03:19 -0400
DKIM-Signature: a=rsa-sha256; bh=Eb4E4n4zzzhOAaaGQsl9QPIPVsuIUn1rdNE7TxwA3Ns=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1777564992; v=1;
 b=Fa5oQedaRrs7htcamNd4pMa33Zr55MxcCLno49ApWcoLskawForC7G3QPH0S001GY+CrjXhS
 5AeiGfDIV1qPML6LUIoBxGJ6asL+KsmrZo2wRQokS6viF3b1BlIDK/5J5iSLndpJdz+i04CXKkf
 zQbwHBJhMR6gseL+zd8meWqU9yLpNYQGbD3cgW14tgoCiELlydNOkVx5PStLzYs85AGkZYuZvEs
 w6sV7S4LmSKrm19TLsjE8yCcC7kofEbrjDSfXC/DDXSoGt+UHImQ+wBRW8yAJFocc2qxa8CpcD0
 zam+0gZYSaVcJsPAv0nXyvJA6h6hc/aKXyVsJVoyodtXQ==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id EA5A020C13;
 Thu, 30 Apr 2026 16:03:11 +0000 (UTC)
From: ~lexbaileylowrisc <lexbaileylowrisc@git.sr.ht>
Date: Tue, 07 Apr 2026 10:43:43 +0100
Subject: [PATCH qemu v4 2/9] ot_uart: move to new reset API
Message-ID: <177756498815.8917.12449488721849651971-2@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <177756498815.8917.12449488721849651971-0@git.sr.ht>
To: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org,
 Amit Kumar-Hermosillo <amitkh@google.com>,
 nabihestefan <nabihestefan@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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
index b3eb619641..9478af40f9 100644
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
@@ -544,12 +549,16 @@ static void ot_uart_realize(DeviceState *dev, Error **e=
rrp)
 static void ot_uart_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
+    OtUARTClass *uc =3D OT_UART_CLASS(klass);
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
=20
-    device_class_set_legacy_reset(dc, ot_uart_reset);
     dc->realize =3D ot_uart_realize;
     dc->vmsd =3D &vmstate_ot_uart;
     device_class_set_props(dc, ot_uart_properties);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+
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


