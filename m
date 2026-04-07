Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7D1F9D0EC
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 17:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wChSI-0005v5-Ps; Tue, 14 Apr 2026 13:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wChSB-0005sF-EV; Tue, 14 Apr 2026 13:21:35 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wChS7-0007IP-Qf; Tue, 14 Apr 2026 13:21:34 -0400
DKIM-Signature: a=rsa-sha256; bh=iRYiq58mQ0ADGgQHXRQDEvU7mCJBel/gXy9Lrg7D/Fg=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1776187286; v=1;
 b=N/OzlJonLeLDeNLwSoUvNQ+WZUr0x8gTEE4fjS7RNXUig/pg5EHyF2p1t51zGP5RordXz9eU
 v4DsLLAGFr3iuOow0VFoMR8a7J3wRjgel5e+Jz+da3ZNCvcwePAkqZR7N28zXbafiJbLUkGhUTz
 Nku4wQxUg2NV7k0V137HzCgL1X8r2UzCgz+4qbWkSBeZQYlhWIXCHbGpoc2e3oY9wiDPGM0TNMg
 N0LAIFvXGnhWpaEb4znh+qWgByrauQd1tlNan5nDUQt09WCtDa0A+vtF4E4rYdH50pUmkii09nG
 69vyq7cV1QOBwRCEphyRmIKrCoAxFAbIU5mn7UbBQ5guQ==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 2CECE20A38;
 Tue, 14 Apr 2026 17:21:26 +0000 (UTC)
From: ~lexbaileylowrisc <lexbaileylowrisc@git.sr.ht>
Date: Tue, 07 Apr 2026 14:38:47 +0100
Subject: [PATCH qemu v3 04/10] ot_uart: replace individual IRQ fields with
 array, add missing IRQs
Message-ID: <177618728515.4917.14466194789826252277-4@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <177618728515.4917.14466194789826252277-0@git.sr.ht>
To: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Amit Kumar-Hermosillo <amitkh@google.com>,
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

There are 9 interrupts in the OpenTitan UART device.
These are documented here:
https://opentitan.org/book/hw/ip/uart/doc/theory_of_operation.html#interrupts

This commit removes the individually named interrupts (of which there was onl=
y four)
and replaces them with an array of 9 interrupts.

Signed-off-by: Lex Bailey <lex.bailey@lowrisc.org>
---
 hw/char/ot_uart.c         | 44 +++++++++++++--------------------------
 include/hw/char/ot_uart.h |  5 +----
 2 files changed, 15 insertions(+), 34 deletions(-)

diff --git a/hw/char/ot_uart.c b/hw/char/ot_uart.c
index 08f8f1915e..f621fd3eae 100644
--- a/hw/char/ot_uart.c
+++ b/hw/char/ot_uart.c
@@ -105,6 +105,7 @@ REG32(TIMEOUT_CTRL, 0x30)
 #define OT_UART_NCO_BITS     16
 #define OT_UART_TX_FIFO_SIZE 128
 #define OT_UART_RX_FIFO_SIZE 128
+#define OT_UART_IRQ_NUM      9
=20
 #define R32_OFF(_r_) ((_r_) / sizeof(uint32_t))
=20
@@ -114,31 +115,11 @@ REG32(TIMEOUT_CTRL, 0x30)
=20
 static void ot_uart_update_irqs(OtUARTState *s)
 {
-    if (s->regs[R_INTR_STATE] & s->regs[R_INTR_ENABLE]
-        & INTR_TX_WATERMARK_MASK) {
-        qemu_set_irq(s->tx_watermark, 1);
-    } else {
-        qemu_set_irq(s->tx_watermark, 0);
-    }
-
-    if (s->regs[R_INTR_STATE] & s->regs[R_INTR_ENABLE]
-        & INTR_RX_WATERMARK_MASK) {
-        qemu_set_irq(s->rx_watermark, 1);
-    } else {
-        qemu_set_irq(s->rx_watermark, 0);
-    }
+    uint32_t state_masked =3D s->regs[R_INTR_STATE] & s->regs[R_INTR_ENABLE];
=20
-    if (s->regs[R_INTR_STATE] & s->regs[R_INTR_ENABLE] & INTR_TX_EMPTY_MASK)=
 {
-        qemu_set_irq(s->tx_empty, 1);
-    } else {
-        qemu_set_irq(s->tx_empty, 0);
-    }
-
-    if (s->regs[R_INTR_STATE] & s->regs[R_INTR_ENABLE]
-        & INTR_RX_OVERFLOW_MASK) {
-        qemu_set_irq(s->rx_overflow, 1);
-    } else {
-        qemu_set_irq(s->rx_overflow, 0);
+    for (int index =3D 0; index < OT_UART_IRQ_NUM; index++) {
+        bool level =3D (state_masked & (1U << index)) !=3D 0;
+        qemu_set_irq(s->irqs[index], level);
     }
 }
=20
@@ -293,6 +274,9 @@ static void ot_uart_reset_enter(Object *obj, ResetType ty=
pe)
     s->regs[R_STATUS] =3D 0x0000003c;
=20
     s->tx_watermark_level =3D 0;
+    for (unsigned index =3D 0; index < ARRAY_SIZE(s->irqs); index++) {
+        qemu_set_irq(s->irqs[index], 0);
+    }
     ot_uart_reset_tx_fifo(s);
     ot_uart_reset_rx_fifo(s);
=20
@@ -569,21 +553,21 @@ static void ot_uart_init(Object *obj)
                                   ot_uart_clk_update, s, ClockUpdate);
     clock_set_hz(s->f_clk, OT_UART_CLOCK);
=20
-    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->tx_watermark);
-    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->rx_watermark);
-    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->tx_empty);
-    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->rx_overflow);
+    for (unsigned index =3D 0; index < OT_UART_IRQ_NUM; index++) {
+        sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irqs[index]);
+    }
=20
     memory_region_init_io(&s->mmio, obj, &ot_uart_ops, s, TYPE_OT_UART,
                           REGS_SIZE);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
=20
     /*
-     * This array has a fixed size in the header. This assertion is used to
-     * check that it is consistent with the definition in this file. This is
+     * These arrays have fixed sizes in the header. These assertions are use=
d to
+     * check that they are consistent with the definitions in this file. Thi=
s is
      * ostensibly a runtime check, but may be optimised away by the compiler.
      */
     assert(REGS_SIZE =3D=3D sizeof(s->regs));
+    assert(OT_UART_IRQ_NUM * sizeof(qemu_irq) =3D=3D sizeof(s->irqs));
 }
=20
 static void ot_uart_realize(DeviceState *dev, Error **errp)
diff --git a/include/hw/char/ot_uart.h b/include/hw/char/ot_uart.h
index f489612700..a2c5ff8b33 100644
--- a/include/hw/char/ot_uart.h
+++ b/include/hw/char/ot_uart.h
@@ -42,6 +42,7 @@ struct OtUARTState {
=20
     /* <public> */
     MemoryRegion mmio;
+    qemu_irq irqs[9];
=20
     uint32_t tx_level;
=20
@@ -59,10 +60,6 @@ struct OtUARTState {
     Clock *f_clk;
=20
     CharFrontend chr;
-    qemu_irq tx_watermark;
-    qemu_irq rx_watermark;
-    qemu_irq tx_empty;
-    qemu_irq rx_overflow;
 };
=20
 struct OtUARTClass {
--=20
2.49.1


