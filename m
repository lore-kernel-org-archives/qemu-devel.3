Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71765CD1283
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 17:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqGIL-0007ar-2F; Fri, 29 Mar 2024 13:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnaud.minier@telecom-paris.fr>)
 id 1rqGII-0007aH-TO; Fri, 29 Mar 2024 13:45:34 -0400
Received: from zproxy4.enst.fr ([137.194.2.223])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnaud.minier@telecom-paris.fr>)
 id 1rqGIH-0007rY-1Z; Fri, 29 Mar 2024 13:45:34 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id CF42C207CB;
 Fri, 29 Mar 2024 18:45:30 +0100 (CET)
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id vtGv8H6CP1av; Fri, 29 Mar 2024 18:45:29 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 85C06207DE;
 Fri, 29 Mar 2024 18:45:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy4.enst.fr 85C06207DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1711734329;
 bh=VHBafg/gnuufeOsZilZdutHluX7p++PX8OqXqO4Hjt4=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=kmpbs3yG1/5KLA9Lv0rmA3JHNPXYRfENOG5OcRNO4+enH1rqIwmkriF9t6VKFxvFX
 SJASVa1VqqoCHeLZRmGQiQYkri1fsqgQy6eeHVBGy2AVpkmkmpBRMuxmuB196ollTf
 04aZoN0EyMpOp94ItzF1tRE6ORbf3AHSvCgfbvwE=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id KPhMYghEQoKA; Fri, 29 Mar 2024 18:45:29 +0100 (CET)
Received: from AM-Inspiron-3585.. (unknown [78.209.135.136])
 by zproxy4.enst.fr (Postfix) with ESMTPSA id BD467207A9;
 Fri, 29 Mar 2024 18:45:27 +0100 (CET)
From: Arnaud Minier <arnaud.minier@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Laurent Vivier <lvivier@redhat.com>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 3/5] hw/char/stm32l4x5_usart: Add options for serial
 parameters setting
Date: Fri, 29 Mar 2024 18:44:00 +0100
Message-Id: <20240329174402.60382-4-arnaud.minier@telecom-paris.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329174402.60382-1-arnaud.minier@telecom-paris.fr>
References: <20240329174402.60382-1-arnaud.minier@telecom-paris.fr>
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

Add a function to change the settings of the
serial connection.

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/stm32l4x5_usart.c | 98 +++++++++++++++++++++++++++++++++++++++
 hw/char/trace-events      |  1 +
 2 files changed, 99 insertions(+)

diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
index b948a89c13..0f5ab7e0cb 100644
--- a/hw/char/stm32l4x5_usart.c
+++ b/hw/char/stm32l4x5_usart.c
@@ -268,6 +268,92 @@ static void usart_cancel_transmit(Stm32l4x5UsartBase=
State *s)
     }
 }
=20
+static void stm32l4x5_update_params(Stm32l4x5UsartBaseState *s)
+{
+    int speed, parity, data_bits, stop_bits;
+    uint32_t value, usart_div;
+    QEMUSerialSetParams ssp;
+
+    /* Select the parity type */
+    if (s->cr1 & R_CR1_PCE_MASK) {
+        if (s->cr1 & R_CR1_PS_MASK) {
+            parity =3D 'O';
+        } else {
+            parity =3D 'E';
+        }
+    } else {
+        parity =3D 'N';
+    }
+
+    /* Select the number of stop bits */
+    switch (FIELD_EX32(s->cr2, CR2, STOP)) {
+    case 0:
+        stop_bits =3D 1;
+        break;
+    case 2:
+        stop_bits =3D 2;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+            "UNIMPLEMENTED: fractionnal stop bits; CR2[13:12] =3D %u",
+            FIELD_EX32(s->cr2, CR2, STOP));
+        return;
+    }
+
+    /* Select the length of the word */
+    switch ((FIELD_EX32(s->cr1, CR1, M1) << 1) | FIELD_EX32(s->cr1, CR1,=
 M0)) {
+    case 0:
+        data_bits =3D 8;
+        break;
+    case 1:
+        data_bits =3D 9;
+        break;
+    case 2:
+        data_bits =3D 7;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "UNDEFINED: invalid word length, CR1.M =3D 0b11");
+        return;
+    }
+
+    /* Select the baud rate */
+    value =3D FIELD_EX32(s->brr, BRR, BRR);
+    if (value < 16) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "UNDEFINED: BRR less than 16: %u", value);
+        return;
+    }
+
+    if (FIELD_EX32(s->cr1, CR1, OVER8) =3D=3D 0) {
+        /*
+         * Oversampling by 16
+         * BRR =3D USARTDIV
+         */
+        usart_div =3D value;
+    } else {
+        /*
+         * Oversampling by 8
+         * - BRR[2:0] =3D USARTDIV[3:0] shifted 1 bit to the right.
+         * - BRR[3] must be kept cleared.
+         * - BRR[15:4] =3D USARTDIV[15:4]
+         * - The frequency is multiplied by 2
+         */
+        usart_div =3D ((value & 0xFFF0) | ((value & 0x0007) << 1)) / 2;
+    }
+
+    speed =3D clock_get_hz(s->clk) / usart_div;
+
+    ssp.speed     =3D speed;
+    ssp.parity    =3D parity;
+    ssp.data_bits =3D data_bits;
+    ssp.stop_bits =3D stop_bits;
+
+    qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_PARAMS, &ssp);
+
+    trace_stm32l4x5_usart_update_params(speed, parity, data_bits, stop_b=
its);
+}
+
 static void stm32l4x5_usart_base_reset_hold(Object *obj)
 {
     Stm32l4x5UsartBaseState *s =3D STM32L4X5_USART_BASE(obj);
@@ -366,16 +452,19 @@ static void stm32l4x5_usart_base_write(void *opaque=
, hwaddr addr,
     switch (addr) {
     case A_CR1:
         s->cr1 =3D value;
+        stm32l4x5_update_params(s);
         stm32l4x5_update_irq(s);
         return;
     case A_CR2:
         s->cr2 =3D value;
+        stm32l4x5_update_params(s);
         return;
     case A_CR3:
         s->cr3 =3D value;
         return;
     case A_BRR:
         s->brr =3D value;
+        stm32l4x5_update_params(s);
         return;
     case A_GTPR:
         s->gtpr =3D value;
@@ -444,10 +533,19 @@ static void stm32l4x5_usart_base_init(Object *obj)
     s->clk =3D qdev_init_clock_in(DEVICE(s), "clk", NULL, s, 0);
 }
=20
+static int stm32l4x5_usart_base_post_load(void *opaque, int version_id)
+{
+    Stm32l4x5UsartBaseState *s =3D (Stm32l4x5UsartBaseState *)opaque;
+
+    stm32l4x5_update_params(s);
+    return 0;
+}
+
 static const VMStateDescription vmstate_stm32l4x5_usart_base =3D {
     .name =3D TYPE_STM32L4X5_USART_BASE,
     .version_id =3D 1,
     .minimum_version_id =3D 1,
+    .post_load =3D stm32l4x5_usart_base_post_load,
     .fields =3D (VMStateField[]) {
         VMSTATE_UINT32(cr1, Stm32l4x5UsartBaseState),
         VMSTATE_UINT32(cr2, Stm32l4x5UsartBaseState),
diff --git a/hw/char/trace-events b/hw/char/trace-events
index f22f0ee2bc..8875758076 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -116,6 +116,7 @@ stm32l4x5_usart_irq_raised(uint32_t reg) "USART: IRQ =
raised: 0x%08"PRIx32
 stm32l4x5_usart_irq_lowered(void) "USART: IRQ lowered"
 stm32l4x5_usart_overrun_detected(uint8_t current, uint8_t received) "USA=
RT: Overrun detected, RDR=3D'0x%x', received 0x%x"
 stm32l4x5_usart_receiver_not_enabled(uint8_t ue_bit, uint8_t re_bit) "US=
ART: Receiver not enabled, UE=3D0x%x, RE=3D0x%x"
+stm32l4x5_usart_update_params(int speed, uint8_t parity, int data, int s=
top) "USART: speed: %d, parity: %c, data bits: %d, stop bits: %d"
=20
 # xen_console.c
 xen_console_connect(unsigned int idx, unsigned int ring_ref, unsigned in=
t port, unsigned int limit) "idx %u ring_ref %u port %u limit %u"
--=20
2.34.1


