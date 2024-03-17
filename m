Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C064C54E67
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Mar 2024 10:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlnxT-0003Ar-2n; Sun, 17 Mar 2024 06:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnaud.minier@telecom-paris.fr>)
 id 1rlnxA-0002qF-GR; Sun, 17 Mar 2024 06:41:23 -0400
Received: from zproxy4.enst.fr ([2001:660:330f:2::df])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnaud.minier@telecom-paris.fr>)
 id 1rlnx7-0001PO-HY; Sun, 17 Mar 2024 06:41:19 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 42FA42061D;
 Sun, 17 Mar 2024 11:41:11 +0100 (CET)
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id ldRA11B_8oXQ; Sun, 17 Mar 2024 11:41:10 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 6B29C205F4;
 Sun, 17 Mar 2024 11:41:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy4.enst.fr 6B29C205F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1710672070;
 bh=1M07QmUdcjDgX6E7/IQG4GlxgxJ8TiHLTW/QmWMAN0I=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=rMuEp7/zJypxhWjhhPpaylgBOM4EkQ1raNGGnNelJA8fOy2hN82UsG///qf4X1pTF
 WUAu7jc4DuyNzy7DfYIUUy6ROpYdGlwbbg1XUpJQVjkTnccE08HrD8YxsPtHBZfoBI
 EdfITSwIbVYCzIH+JAzlGRjb5s3ubF1Yr5KjI+no=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id yWCRL7Ps1xFw; Sun, 17 Mar 2024 11:41:10 +0100 (CET)
Received: from AM-Inspiron-3585.. (cust-west-par-46-193-4-103.cust.wifirst.net
 [46.193.4.103])
 by zproxy4.enst.fr (Postfix) with ESMTPSA id 036B9205A4;
 Sun, 17 Mar 2024 11:41:09 +0100 (CET)
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
Subject: [PATCH 4/7] hw/char/stm32l4x5_usart: Enable serial read and write
Date: Sun, 17 Mar 2024 11:39:15 +0100
Message-Id: <20240317103918.44375-5-arnaud.minier@telecom-paris.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240317103918.44375-1-arnaud.minier@telecom-paris.fr>
References: <20240317103918.44375-1-arnaud.minier@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:660:330f:2::df;
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

Implement the ability to read and write characters to the
usart using the serial port.

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 hw/char/stm32l4x5_usart.c | 105 +++++++++++++++++++++++++++++++++++++-
 hw/char/trace-events      |   1 +
 2 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
index f58bd56875..958d05a56d 100644
--- a/hw/char/stm32l4x5_usart.c
+++ b/hw/char/stm32l4x5_usart.c
@@ -154,6 +154,71 @@ REG32(RDR, 0x24)
 REG32(TDR, 0x28)
     FIELD(TDR, TDR, 0, 8)
=20
+static int stm32l4x5_usart_base_can_receive(void *opaque)
+{
+    Stm32l4x5UsartBaseState *s =3D opaque;
+
+    if (!(s->isr & R_ISR_RXNE_MASK)) {
+        return 1;
+    }
+
+    return 0;
+}
+
+static void stm32l4x5_update_irq(Stm32l4x5UsartBaseState *s)
+{
+    if (((s->isr & R_ISR_WUF_MASK) && (s->cr3 & R_CR3_WUFIE_MASK))      =
  ||
+        ((s->isr & R_ISR_CMF_MASK) && (s->cr1 & R_CR1_CMIE_MASK))       =
  ||
+        ((s->isr & R_ISR_ABRF_MASK) && (s->cr1 & R_CR1_RXNEIE_MASK))    =
  ||
+        ((s->isr & R_ISR_EOBF_MASK) && (s->cr1 & R_CR1_EOBIE_MASK))     =
  ||
+        ((s->isr & R_ISR_RTOF_MASK) && (s->cr1 & R_CR1_RTOIE_MASK))     =
  ||
+        ((s->isr & R_ISR_CTSIF_MASK) && (s->cr3 & R_CR3_CTSIE_MASK))    =
  ||
+        ((s->isr & R_ISR_LBDF_MASK) && (s->cr2 & R_CR2_LBDIE_MASK))     =
  ||
+        ((s->isr & R_ISR_TXE_MASK) && (s->cr1 & R_CR1_TXEIE_MASK))      =
  ||
+        ((s->isr & R_ISR_TC_MASK) && (s->cr1 & R_CR1_TCIE_MASK))        =
  ||
+        ((s->isr & R_ISR_RXNE_MASK) && (s->cr1 & R_CR1_RXNEIE_MASK))    =
  ||
+        ((s->isr & R_ISR_IDLE_MASK) && (s->cr1 & R_CR1_IDLEIE_MASK))    =
  ||
+        ((s->isr & R_ISR_ORE_MASK) &&
+            ((s->cr1 & R_CR1_RXNEIE_MASK) || (s->cr3 & R_CR3_EIE_MASK)))=
  ||
+        /* TODO: Handle NF ? */
+        ((s->isr & R_ISR_FE_MASK) && (s->cr3 & R_CR3_EIE_MASK))         =
  ||
+        ((s->isr & R_ISR_PE_MASK) && (s->cr1 & R_CR1_PEIE_MASK))) {
+        qemu_irq_raise(s->irq);
+        trace_stm32l4x5_usart_irq_raised(s->isr);
+    } else {
+        qemu_irq_lower(s->irq);
+        trace_stm32l4x5_usart_irq_lowered();
+    }
+}
+
+static void stm32l4x5_usart_base_receive(void *opaque, const uint8_t *bu=
f, int size)
+{
+    Stm32l4x5UsartBaseState *s =3D opaque;
+
+    if (!((s->cr1 & R_CR1_UE_MASK) && (s->cr1 & R_CR1_RE_MASK))) {
+        /* USART not enabled - drop the chars */
+        trace_stm32l4x5_usart_error("Dropping the chars\n");
+        return;
+    }
+
+    /* Check if overrun detection is enabled and if there is an overrun =
*/
+    if (!(s->cr3 & R_CR3_OVRDIS_MASK) && (s->isr & R_ISR_RXNE_MASK)) {
+        /*
+         * A character has been received while
+         * the previous has not been read =3D Overrun.
+         */
+        s->isr |=3D R_ISR_ORE_MASK;
+        trace_stm32l4x5_usart_overrun_detected(s->rdr, *buf);
+    } else {
+        /* No overrun */
+        s->rdr =3D *buf;
+        s->isr |=3D R_ISR_RXNE_MASK;
+        trace_stm32l4x5_usart_rx(s->rdr);
+    }
+
+    stm32l4x5_update_irq(s);
+}
+
 static void stm32l4x5_usart_base_reset_hold(Object *obj)
 {
     Stm32l4x5UsartBaseState *s =3D STM32L4X5_USART_BASE(obj);
@@ -168,6 +233,21 @@ static void stm32l4x5_usart_base_reset_hold(Object *=
obj)
     s->isr =3D 0x020000C0 | R_ISR_TXE_MASK;
     s->rdr =3D 0x00000000;
     s->tdr =3D 0x00000000;
+
+    stm32l4x5_update_irq(s);
+}
+
+static void usart_update_rqr(Stm32l4x5UsartBaseState *s, uint32_t value)
+{
+    /* TXFRQ */
+    /* Reset RXNE flag */
+    if (value & R_RQR_RXFRQ_MASK) {
+        s->isr &=3D ~R_ISR_RXNE_MASK;
+    }
+    /* MMRQ */
+    /* SBKRQ */
+    /* ABRRQ */
+    stm32l4x5_update_irq(s);
 }
=20
 static uint64_t stm32l4x5_usart_base_read(void *opaque, hwaddr addr,
@@ -209,7 +289,8 @@ static uint64_t stm32l4x5_usart_base_read(void *opaqu=
e, hwaddr addr,
     case A_RDR:
         retvalue =3D FIELD_EX32(s->rdr, RDR, RDR);
         /* Reset RXNE flag */
-        s->isr &=3D ~USART_ISR_RXNE;
+        s->isr &=3D ~R_ISR_RXNE_MASK;
+        stm32l4x5_update_irq(s);
         break;
     case A_TDR:
         retvalue =3D FIELD_EX32(s->tdr, TDR, TDR);
@@ -237,6 +318,7 @@ static void stm32l4x5_usart_base_write(void *opaque, =
hwaddr addr,
     switch (addr) {
     case A_CR1:
         s->cr1 =3D value;
+        stm32l4x5_update_irq(s);
         return;
     case A_CR2:
         s->cr2 =3D value;
@@ -254,6 +336,7 @@ static void stm32l4x5_usart_base_write(void *opaque, =
hwaddr addr,
         s->rtor =3D value;
         return;
     case A_RQR:
+        usart_update_rqr(s, value);
         return;
     case A_ISR:
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -262,6 +345,7 @@ static void stm32l4x5_usart_base_write(void *opaque, =
hwaddr addr,
     case A_ICR:
         /* Clear the status flags */
         s->isr &=3D ~value;
+        stm32l4x5_update_irq(s);
         return;
     case A_RDR:
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -269,6 +353,21 @@ static void stm32l4x5_usart_base_write(void *opaque,=
 hwaddr addr,
         return;
     case A_TDR:
         s->tdr =3D value;
+        ch =3D value & R_TDR_TDR_MASK;
+        /*
+         * XXX this blocks entire thread. Rewrite to use
+         * qemu_chr_fe_write and background I/O callbacks
+         */
+        qemu_chr_fe_write_all(&s->chr, &ch, 1);
+        /*
+         * XXX I/O are currently synchronous, making it impossible for
+         * software to observe transient states where TXE or TC aren't
+         * set. Unlike TXE however, which is read-only, software may
+         * clear TC by writing 0 to the ISR register, so set it again
+         * on each write.
+         */
+        s->isr |=3D R_ISR_TC_MASK;
+        stm32l4x5_update_irq(s);
         return;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -338,6 +437,10 @@ static void stm32l4x5_usart_base_realize(DeviceState=
 *dev, Error **errp)
         error_setg(errp, "USART clock must be wired up by SoC code");
         return;
     }
+
+    qemu_chr_fe_set_handlers(&s->chr, stm32l4x5_usart_base_can_receive,
+                             stm32l4x5_usart_base_receive, NULL, NULL,
+                             s, NULL, true);
 }
=20
 static void stm32l4x5_usart_base_class_init(ObjectClass *klass, void *da=
ta)
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 9f5fda0eb8..0cda3dfed0 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -114,6 +114,7 @@ stm32l4x5_usart_rx(uint8_t c) "USART: got character 0=
x%x from backend"
 stm32l4x5_usart_tx(uint8_t c) "USART: character 0x%x sent to backend"
 stm32l4x5_usart_irq_raised(uint32_t reg) "USART: IRQ raised: 0x%08"PRIx3=
2
 stm32l4x5_usart_irq_lowered(void) "USART: IRQ lowered"
+stm32l4x5_usart_overrun_detected(uint8_t current, uint8_t received) "USA=
RT: Overrun detected, RDR=3D'0x%x', received 0x%x"
 stm32l4x5_usart_error(const char* error) "USART Error: %s"
=20
 # xen_console.c
--=20
2.34.1


