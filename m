Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83356CD1283
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 17:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqGHE-00059K-HC; Fri, 29 Mar 2024 13:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnaud.minier@telecom-paris.fr>)
 id 1rqGHC-00058G-Ou; Fri, 29 Mar 2024 13:44:26 -0400
Received: from zproxy3.enst.fr ([137.194.2.222])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnaud.minier@telecom-paris.fr>)
 id 1rqGH9-0007Nz-Vx; Fri, 29 Mar 2024 13:44:26 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 3BA57A07D5;
 Fri, 29 Mar 2024 18:44:19 +0100 (CET)
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id gX1bFzpFf5np; Fri, 29 Mar 2024 18:44:18 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 17D24A07D0;
 Fri, 29 Mar 2024 18:44:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy3.enst.fr 17D24A07D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1711734258;
 bh=j/fvyDgEPAwJ2hNLMixXkRa0+AUrZUdDf6NrN22Ss8w=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=0+/1xUst82+on4THM9aHaIzW3tvr5FyIJqJZ6yrqQ2NSo7u+r/TfJNNhevWUy7DV0
 tiY3i5rYt+W3N/+Ak94ShWqCYbQLVoHySXoEUIPDuo7FwN5KByGJ0hGvSZvpDNlibf
 WFTAUN69HgPWxhvsUvFYQGUCmbdGe0fLJM0fSOj0=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id gqhN7s88Kwbb; Fri, 29 Mar 2024 18:44:17 +0100 (CET)
Received: from AM-Inspiron-3585.. (unknown [78.209.135.136])
 by zproxy3.enst.fr (Postfix) with ESMTPSA id BA862A07C4;
 Fri, 29 Mar 2024 18:44:16 +0100 (CET)
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
Subject: [PATCH v3 1/5] hw/char: Implement STM32L4x5 USART skeleton
Date: Fri, 29 Mar 2024 18:43:58 +0100
Message-Id: <20240329174402.60382-2-arnaud.minier@telecom-paris.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329174402.60382-1-arnaud.minier@telecom-paris.fr>
References: <20240329174402.60382-1-arnaud.minier@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.222;
 envelope-from=arnaud.minier@telecom-paris.fr; helo=zproxy3.enst.fr
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

Add the basic infrastructure (register read/write, type...)
to implement the STM32L4x5 USART.

Also create different types for the USART, UART and LPUART
of the STM32L4x5 to deduplicate code and enable the
implementation of different behaviors depending on the type.

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                       |   1 +
 hw/char/Kconfig                   |   3 +
 hw/char/meson.build               |   1 +
 hw/char/stm32l4x5_usart.c         | 396 ++++++++++++++++++++++++++++++
 hw/char/trace-events              |   4 +
 include/hw/char/stm32l4x5_usart.h |  66 +++++
 6 files changed, 471 insertions(+)
 create mode 100644 hw/char/stm32l4x5_usart.c
 create mode 100644 include/hw/char/stm32l4x5_usart.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a07af6b9d4..fa7212b9b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1128,6 +1128,7 @@ M: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/stm32l4x5_soc.c
+F: hw/char/stm32l4x5_usart.c
 F: hw/misc/stm32l4x5_exti.c
 F: hw/misc/stm32l4x5_syscfg.c
 F: hw/misc/stm32l4x5_rcc.c
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 6b6cf2fc1d..4fd74ea878 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -41,6 +41,9 @@ config VIRTIO_SERIAL
 config STM32F2XX_USART
     bool
=20
+config STM32L4X5_USART
+    bool
+
 config CMSDK_APB_UART
     bool
=20
diff --git a/hw/char/meson.build b/hw/char/meson.build
index 006d20f1e2..e5b13b6958 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -31,6 +31,7 @@ system_ss.add(when: 'CONFIG_RENESAS_SCI', if_true: file=
s('renesas_sci.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_UART', if_true: files('sifive_uart.c'=
))
 system_ss.add(when: 'CONFIG_SH_SCI', if_true: files('sh_serial.c'))
 system_ss.add(when: 'CONFIG_STM32F2XX_USART', if_true: files('stm32f2xx_=
usart.c'))
+system_ss.add(when: 'CONFIG_STM32L4X5_USART', if_true: files('stm32l4x5_=
usart.c'))
 system_ss.add(when: 'CONFIG_MCHP_PFSOC_MMUART', if_true: files('mchp_pfs=
oc_mmuart.c'))
 system_ss.add(when: 'CONFIG_HTIF', if_true: files('riscv_htif.c'))
 system_ss.add(when: 'CONFIG_GOLDFISH_TTY', if_true: files('goldfish_tty.=
c'))
diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
new file mode 100644
index 0000000000..13ce0eb89d
--- /dev/null
+++ b/hw/char/stm32l4x5_usart.c
@@ -0,0 +1,396 @@
+/*
+ * STM32L4X5 USART (Universal Synchronous Asynchronous Receiver Transmit=
ter)
+ *
+ * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2023 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ *
+ * The STM32L4X5 USART is heavily inspired by the stm32f2xx_usart
+ * by Alistair Francis.
+ * The reference used is the STMicroElectronics RM0351 Reference manual
+ * for STM32L4x5 and STM32L4x6 advanced Arm =C2=AE -based 32-bit MCUs.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "chardev/char-fe.h"
+#include "chardev/char-serial.h"
+#include "migration/vmstate.h"
+#include "hw/char/stm32l4x5_usart.h"
+#include "hw/clock.h"
+#include "hw/irq.h"
+#include "hw/qdev-clock.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
+#include "hw/registerfields.h"
+#include "trace.h"
+
+
+REG32(CR1, 0x00)
+    FIELD(CR1, M1, 28, 1)    /* Word length (part 2, see M0) */
+    FIELD(CR1, EOBIE, 27, 1) /* End of Block interrupt enable */
+    FIELD(CR1, RTOIE, 26, 1) /* Receiver timeout interrupt enable */
+    FIELD(CR1, DEAT, 21, 5)  /* Driver Enable assertion time */
+    FIELD(CR1, DEDT, 16, 5)  /* Driver Enable de-assertion time */
+    FIELD(CR1, OVER8, 15, 1) /* Oversampling mode */
+    FIELD(CR1, CMIE, 14, 1)  /* Character match interrupt enable */
+    FIELD(CR1, MME, 13, 1)   /* Mute mode enable */
+    FIELD(CR1, M0, 12, 1)    /* Word length (part 1, see M1) */
+    FIELD(CR1, WAKE, 11, 1)  /* Receiver wakeup method */
+    FIELD(CR1, PCE, 10, 1)   /* Parity control enable */
+    FIELD(CR1, PS, 9, 1)     /* Parity selection */
+    FIELD(CR1, PEIE, 8, 1)   /* PE interrupt enable */
+    FIELD(CR1, TXEIE, 7, 1)  /* TXE interrupt enable */
+    FIELD(CR1, TCIE, 6, 1)   /* Transmission complete interrupt enable *=
/
+    FIELD(CR1, RXNEIE, 5, 1) /* RXNE interrupt enable */
+    FIELD(CR1, IDLEIE, 4, 1) /* IDLE interrupt enable */
+    FIELD(CR1, TE, 3, 1)     /* Transmitter enable */
+    FIELD(CR1, RE, 2, 1)     /* Receiver enable */
+    FIELD(CR1, UESM, 1, 1)   /* USART enable in Stop mode */
+    FIELD(CR1, UE, 0, 1)     /* USART enable */
+REG32(CR2, 0x04)
+    FIELD(CR2, ADD_1, 28, 4)    /* ADD[7:4] */
+    FIELD(CR2, ADD_0, 24, 1)    /* ADD[3:0] */
+    FIELD(CR2, RTOEN, 23, 1)    /* Receiver timeout enable */
+    FIELD(CR2, ABRMOD, 21, 2)   /* Auto baud rate mode */
+    FIELD(CR2, ABREN, 20, 1)    /* Auto baud rate enable */
+    FIELD(CR2, MSBFIRST, 19, 1) /* Most significant bit first */
+    FIELD(CR2, DATAINV, 18, 1)  /* Binary data inversion */
+    FIELD(CR2, TXINV, 17, 1)    /* TX pin active level inversion */
+    FIELD(CR2, RXINV, 16, 1)    /* RX pin active level inversion */
+    FIELD(CR2, SWAP, 15, 1)     /* Swap RX/TX pins */
+    FIELD(CR2, LINEN, 14, 1)    /* LIN mode enable */
+    FIELD(CR2, STOP, 12, 2)     /* STOP bits */
+    FIELD(CR2, CLKEN, 11, 1)    /* Clock enable */
+    FIELD(CR2, CPOL, 10, 1)     /* Clock polarity */
+    FIELD(CR2, CPHA, 9, 1)      /* Clock phase */
+    FIELD(CR2, LBCL, 8, 1)      /* Last bit clock pulse */
+    FIELD(CR2, LBDIE, 6, 1)     /* LIN break detection interrupt enable =
*/
+    FIELD(CR2, LBDL, 5, 1)      /* LIN break detection length */
+    FIELD(CR2, ADDM7, 4, 1)     /* 7-bit Address Detection /
+                                 * 4-bit Address Detection */
+REG32(CR3, 0x08)
+    /* TCBGTIE only on STM32L496xx/4A6xx devices */
+    FIELD(CR3, UCESM, 23, 1)   /* USART Clock Enable in Stop Mode */
+    FIELD(CR3, WUFIE, 22, 1)   /* Wakeup from Stop mode interrupt enable=
 */
+    FIELD(CR3, WUS, 20, 2)     /* Wakeup from Stop mode interrupt flag s=
election */
+    FIELD(CR3, SCARCNT, 17, 3) /* Smartcard auto-retry count */
+    FIELD(CR3, DEP, 15, 1)     /* Driver enable polarity selection */
+    FIELD(CR3, DEM, 14, 1)     /* Driver enable mode */
+    FIELD(CR3, DDRE, 13, 1)    /* DMA Disable on Reception Error */
+    FIELD(CR3, OVRDIS, 12, 1)  /* Overrun Disable */
+    FIELD(CR3, ONEBIT, 11, 1)  /* One sample bit method enable */
+    FIELD(CR3, CTSIE, 10, 1)   /* CTS interrupt enable */
+    FIELD(CR3, CTSE, 9, 1)     /* CTS enable */
+    FIELD(CR3, RTSE, 8, 1)     /* RTS enable */
+    FIELD(CR3, DMAT, 7, 1)     /* DMA enable transmitter */
+    FIELD(CR3, DMAR, 6, 1)     /* DMA enable receiver */
+    FIELD(CR3, SCEN, 5, 1)     /* Smartcard mode enable */
+    FIELD(CR3, NACK, 4, 1)     /* Smartcard NACK enable */
+    FIELD(CR3, HDSEL, 3, 1)    /* Half-duplex selection */
+    FIELD(CR3, IRLP, 2, 1)     /* IrDA low-power */
+    FIELD(CR3, IREN, 1, 1)     /* IrDA mode enable */
+    FIELD(CR3, EIE, 0, 1)      /* Error interrupt enable */
+REG32(BRR, 0x0C)
+    FIELD(BRR, BRR, 0, 16)
+REG32(GTPR, 0x10)
+    FIELD(GTPR, GT, 8, 8)  /* Guard time value */
+    FIELD(GTPR, PSC, 0, 8) /* Prescaler value */
+REG32(RTOR, 0x14)
+    FIELD(RTOR, BLEN, 24, 8) /* Block Length */
+    FIELD(RTOR, RTO, 0, 24)  /* Receiver timeout value */
+REG32(RQR, 0x18)
+    FIELD(RQR, TXFRQ, 4, 1)  /* Transmit data flush request */
+    FIELD(RQR, RXFRQ, 3, 1)  /* Receive data flush request */
+    FIELD(RQR, MMRQ, 2, 1)   /* Mute mode request */
+    FIELD(RQR, SBKRQ, 1, 1)  /* Send break request */
+    FIELD(RQR, ABBRRQ, 0, 1) /* Auto baud rate request */
+REG32(ISR, 0x1C)
+    /* TCBGT only for STM32L475xx/476xx/486xx devices */
+    FIELD(ISR, REACK, 22, 1) /* Receive enable acknowledge flag */
+    FIELD(ISR, TEACK, 21, 1) /* Transmit enable acknowledge flag */
+    FIELD(ISR, WUF, 20, 1)   /* Wakeup from Stop mode flag */
+    FIELD(ISR, RWU, 19, 1)   /* Receiver wakeup from Mute mode */
+    FIELD(ISR, SBKF, 18, 1)  /* Send break flag */
+    FIELD(ISR, CMF, 17, 1)   /* Character match flag */
+    FIELD(ISR, BUSY, 16, 1)  /* Busy flag */
+    FIELD(ISR, ABRF, 15, 1)  /* Auto Baud rate flag */
+    FIELD(ISR, ABRE, 14, 1)  /* Auto Baud rate error */
+    FIELD(ISR, EOBF, 12, 1)  /* End of block flag */
+    FIELD(ISR, RTOF, 11, 1)  /* Receiver timeout */
+    FIELD(ISR, CTS, 10, 1)   /* CTS flag */
+    FIELD(ISR, CTSIF, 9, 1)  /* CTS interrupt flag */
+    FIELD(ISR, LBDF, 8, 1)   /* LIN break detection flag */
+    FIELD(ISR, TXE, 7, 1)    /* Transmit data register empty */
+    FIELD(ISR, TC, 6, 1)     /* Transmission complete */
+    FIELD(ISR, RXNE, 5, 1)   /* Read data register not empty */
+    FIELD(ISR, IDLE, 4, 1)   /* Idle line detected */
+    FIELD(ISR, ORE, 3, 1)    /* Overrun error */
+    FIELD(ISR, NF, 2, 1)     /* START bit Noise detection flag */
+    FIELD(ISR, FE, 1, 1)     /* Framing Error*/
+    FIELD(ISR, PE, 0, 1)     /* Parity Error*/
+REG32(ICR, 0x20)
+    FIELD(ICR, WUCF, 20, 1)   /* Wakeup from Stop mode clear flag */
+    FIELD(ICR, CMCF, 17, 1)   /* Character match clear flag */
+    FIELD(ICR, EOBCF, 12, 1)  /* End of block clear flag */
+    FIELD(ICR, RTOCF, 11, 1)  /* Receiver timeout clear flag */
+    FIELD(ICR, CTSCF, 9, 1)   /* CTS clear flag */
+    FIELD(ICR, LBDCF, 8, 1)   /* LIN break detection clear flag */
+    /* TCBGTCF only on STM32L496xx/4A6xx devices */
+    FIELD(ICR, TCCF, 6, 1)    /* Transmission complete clear flag */
+    FIELD(ICR, IDLECF, 4, 1)  /* Idle line detected clear flag */
+    FIELD(ICR, ORECF, 3, 1)   /* Overrun error clear flag */
+    FIELD(ICR, NCF, 2, 1)     /* Noise detected clear flag */
+    FIELD(ICR, FECF, 1, 1)    /* Framing error clear flag */
+    FIELD(ICR, PECF, 0, 1)    /* Parity error clear flag */
+REG32(RDR, 0x24)
+    FIELD(RDR, RDR, 0, 9)
+REG32(TDR, 0x28)
+    FIELD(TDR, TDR, 0, 9)
+
+static void stm32l4x5_usart_base_reset_hold(Object *obj)
+{
+    Stm32l4x5UsartBaseState *s =3D STM32L4X5_USART_BASE(obj);
+
+    s->cr1 =3D 0x00000000;
+    s->cr2 =3D 0x00000000;
+    s->cr3 =3D 0x00000000;
+    s->brr =3D 0x00000000;
+    s->gtpr =3D 0x00000000;
+    s->rtor =3D 0x00000000;
+    s->isr =3D 0x020000C0;
+    s->rdr =3D 0x00000000;
+    s->tdr =3D 0x00000000;
+}
+
+static uint64_t stm32l4x5_usart_base_read(void *opaque, hwaddr addr,
+                                     unsigned int size)
+{
+    Stm32l4x5UsartBaseState *s =3D opaque;
+    uint64_t retvalue =3D 0;
+
+    switch (addr) {
+    case A_CR1:
+        retvalue =3D s->cr1;
+        break;
+    case A_CR2:
+        retvalue =3D s->cr2;
+        break;
+    case A_CR3:
+        retvalue =3D s->cr3;
+        break;
+    case A_BRR:
+        retvalue =3D FIELD_EX32(s->brr, BRR, BRR);
+        break;
+    case A_GTPR:
+        retvalue =3D s->gtpr;
+        break;
+    case A_RTOR:
+        retvalue =3D s->rtor;
+        break;
+    case A_RQR:
+        /* RQR is a write only register */
+        retvalue =3D 0x00000000;
+        break;
+    case A_ISR:
+        retvalue =3D s->isr;
+        break;
+    case A_ICR:
+        /* ICR is a clear register */
+        retvalue =3D 0x00000000;
+        break;
+    case A_RDR:
+        retvalue =3D FIELD_EX32(s->rdr, RDR, RDR);
+        /* Reset RXNE flag */
+        s->isr &=3D ~R_ISR_RXNE_MASK;
+        break;
+    case A_TDR:
+        retvalue =3D FIELD_EX32(s->tdr, TDR, TDR);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, add=
r);
+        break;
+    }
+
+    trace_stm32l4x5_usart_read(addr, retvalue);
+
+    return retvalue;
+}
+
+static void stm32l4x5_usart_base_write(void *opaque, hwaddr addr,
+                                  uint64_t val64, unsigned int size)
+{
+    Stm32l4x5UsartBaseState *s =3D opaque;
+    const uint32_t value =3D val64;
+
+    trace_stm32l4x5_usart_write(addr, value);
+
+    switch (addr) {
+    case A_CR1:
+        s->cr1 =3D value;
+        return;
+    case A_CR2:
+        s->cr2 =3D value;
+        return;
+    case A_CR3:
+        s->cr3 =3D value;
+        return;
+    case A_BRR:
+        s->brr =3D value;
+        return;
+    case A_GTPR:
+        s->gtpr =3D value;
+        return;
+    case A_RTOR:
+        s->rtor =3D value;
+        return;
+    case A_RQR:
+        return;
+    case A_ISR:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: ISR is read only !\n", __func__);
+        return;
+    case A_ICR:
+        /* Clear the status flags */
+        s->isr &=3D ~value;
+        return;
+    case A_RDR:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: RDR is read only !\n", __func__);
+        return;
+    case A_TDR:
+        s->tdr =3D value;
+        return;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, add=
r);
+    }
+}
+
+static const MemoryRegionOps stm32l4x5_usart_base_ops =3D {
+    .read =3D stm32l4x5_usart_base_read,
+    .write =3D stm32l4x5_usart_base_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .valid =3D {
+        .max_access_size =3D 4,
+        .min_access_size =3D 4,
+        .unaligned =3D false
+    },
+    .impl =3D {
+        .max_access_size =3D 4,
+        .min_access_size =3D 4,
+        .unaligned =3D false
+    },
+};
+
+static Property stm32l4x5_usart_base_properties[] =3D {
+    DEFINE_PROP_CHR("chardev", Stm32l4x5UsartBaseState, chr),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void stm32l4x5_usart_base_init(Object *obj)
+{
+    Stm32l4x5UsartBaseState *s =3D STM32L4X5_USART_BASE(obj);
+
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+
+    memory_region_init_io(&s->mmio, obj, &stm32l4x5_usart_base_ops, s,
+                          TYPE_STM32L4X5_USART_BASE, 0x400);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+
+    s->clk =3D qdev_init_clock_in(DEVICE(s), "clk", NULL, s, 0);
+}
+
+static const VMStateDescription vmstate_stm32l4x5_usart_base =3D {
+    .name =3D TYPE_STM32L4X5_USART_BASE,
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
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
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+
+static void stm32l4x5_usart_base_realize(DeviceState *dev, Error **errp)
+{
+    ERRP_GUARD();
+    Stm32l4x5UsartBaseState *s =3D STM32L4X5_USART_BASE(dev);
+    if (!clock_has_source(s->clk)) {
+        error_setg(errp, "USART clock must be wired up by SoC code");
+        return;
+    }
+}
+
+static void stm32l4x5_usart_base_class_init(ObjectClass *klass, void *da=
ta)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
+
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
+}
+
+static const TypeInfo stm32l4x5_usart_types[] =3D {
+    {
+        .name           =3D TYPE_STM32L4X5_USART_BASE,
+        .parent         =3D TYPE_SYS_BUS_DEVICE,
+        .instance_size  =3D sizeof(Stm32l4x5UsartBaseState),
+        .instance_init  =3D stm32l4x5_usart_base_init,
+        .class_init     =3D stm32l4x5_usart_base_class_init,
+        .abstract       =3D true,
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
+    }
+};
+
+DEFINE_TYPES(stm32l4x5_usart_types)
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 7a398c82a5..689bed9e02 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -106,6 +106,10 @@ cadence_uart_baudrate(unsigned baudrate) "baudrate %=
u"
 sh_serial_read(char *id, unsigned size, uint64_t offs, uint64_t val) " %=
s size %d offs 0x%02" PRIx64 " -> 0x%02" PRIx64
 sh_serial_write(char *id, unsigned size, uint64_t offs, uint64_t val) "%=
s size %d offs 0x%02" PRIx64 " <- 0x%02" PRIx64
=20
+# stm32l4x5_usart.c
+stm32l4x5_usart_read(uint64_t addr, uint32_t data) "USART: Read <0x%" PR=
Ix64 "> -> 0x%" PRIx32 ""
+stm32l4x5_usart_write(uint64_t addr, uint32_t data) "USART: Write <0x%" =
PRIx64 "> <- 0x%" PRIx32 ""
+
 # xen_console.c
 xen_console_connect(unsigned int idx, unsigned int ring_ref, unsigned in=
t port, unsigned int limit) "idx %u ring_ref %u port %u limit %u"
 xen_console_disconnect(unsigned int idx) "idx %u"
diff --git a/include/hw/char/stm32l4x5_usart.h b/include/hw/char/stm32l4x=
5_usart.h
new file mode 100644
index 0000000000..8d38a85a6e
--- /dev/null
+++ b/include/hw/char/stm32l4x5_usart.h
@@ -0,0 +1,66 @@
+/*
+ * STM32L4X5 USART (Universal Synchronous Asynchronous Receiver Transmit=
ter)
+ *
+ * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2023 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ *
+ * The STM32L4X5 USART is heavily inspired by the stm32f2xx_usart
+ * by Alistair Francis.
+ * The reference used is the STMicroElectronics RM0351 Reference manual
+ * for STM32L4x5 and STM32L4x6 advanced Arm =C2=AE -based 32-bit MCUs.
+ */
+
+#ifndef HW_STM32L4X5_USART_H
+#define HW_STM32L4X5_USART_H
+
+#include "hw/sysbus.h"
+#include "chardev/char-fe.h"
+#include "qom/object.h"
+
+#define TYPE_STM32L4X5_USART_BASE "stm32l4x5-usart-base"
+#define TYPE_STM32L4X5_USART "stm32l4x5-usart"
+#define TYPE_STM32L4X5_UART "stm32l4x5-uart"
+#define TYPE_STM32L4X5_LPUART "stm32l4x5-lpuart"
+OBJECT_DECLARE_TYPE(Stm32l4x5UsartBaseState, Stm32l4x5UsartBaseClass,
+                    STM32L4X5_USART_BASE)
+
+typedef enum {
+    STM32L4x5_USART,
+    STM32L4x5_UART,
+    STM32L4x5_LPUART,
+} Stm32l4x5UsartType;
+
+struct Stm32l4x5UsartBaseState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+
+    uint32_t cr1;
+    uint32_t cr2;
+    uint32_t cr3;
+    uint32_t brr;
+    uint32_t gtpr;
+    uint32_t rtor;
+    /* rqr is write-only */
+    uint32_t isr;
+    /* icr is a clear register */
+    uint32_t rdr;
+    uint32_t tdr;
+
+    Clock *clk;
+    CharBackend chr;
+    qemu_irq irq;
+};
+
+struct Stm32l4x5UsartBaseClass {
+    SysBusDeviceClass parent_class;
+
+    Stm32l4x5UsartType type;
+};
+
+#endif /* HW_STM32L4X5_USART_H */
--=20
2.34.1


