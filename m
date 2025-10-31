Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701E3CCFA00
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 08:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEkfj-0004vd-Ed; Fri, 31 Oct 2025 04:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@videogpu.com>)
 id 1vEkfd-0004v3-NS
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 04:39:42 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael@videogpu.com>)
 id 1vEkfO-0004MZ-2n
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 04:39:36 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-592fa38fe60so2518021e87.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 01:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=videogpu-com.20230601.gappssmtp.com; s=20230601; t=1761899959; x=1762504759;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DnQnq+PJ184+VzXCOq2xAY8oda+6zEEjHrekyztDKqQ=;
 b=mFPkpbDQerqd9EBSqjF5L+quiIoF4/aq0WVEwD/KhYf2bTCAWPosTXAn1usGjlLAFO
 +dwDJnw0uJRL2XplRM9uGM/s60obkgsX8HPa/akNhrMepFzhXbjvDWDHN9sVRpbm8Uu9
 sZkn5D0Ky8WiTVWniBZiilIoAFU4AEHJ/gbUsrHRJju2HTbanOsChJWcGRFz+ijH33Vd
 wCq7jpUBKNg0E8apR6s0yWAACui6ul+1sr03Gsg7XoCuLOVzyRTQgwTvHCNbM0zUzkqr
 Y7qc1l0gdwZqVJON1gNamTSI55sZ55yZdwjvQhtuhX96J6MZWhxiERVfGJ9Rpg1jI6fx
 ykEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761899959; x=1762504759;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DnQnq+PJ184+VzXCOq2xAY8oda+6zEEjHrekyztDKqQ=;
 b=sOx9LNUIza+Q+bgqNUEA21W+9h20gyHTZf7Y7TftMTPBF2TWuZtu/1bgE5u+ERSe/n
 wCCrIUdmqj9+C+bM3LRQFLJtZELm2kFxKQSFfBZMpVNMy57ZLrTpVj6qby9FkAsdmMoE
 lkaNqcoX8pdRHe1GbqE0DU1YLfgtzOosOKOSbo2XWlXMljMoS0mn7ILLYbU7vCxOds60
 +8SYIIfShorLHjNmNVLDLfFkz6tvrKF0cwAQCYfdXlEzvNWl15SklVJP2or7t5byBb8A
 twjGRQGhwAvKNW299SXI37LC5eQkzo0erJPz7lN3KIu5ONU3VgxX/+xpJQVk4RTw5GzX
 xYNw==
X-Gm-Message-State: AOJu0YwM2Z+L0arEB9onvVIIULm9a1sM7lG6UOKoJpOqOiPZ8/9LBpMB
 oVRRQUDppjjuLY6hlRHbltc+hXxKDbnvpM5Bxs0SP9onD46ZBlMFvdJ9FGCR0mCaI58FlFg8wJK
 mx+LPrDolb8nStCg+h3S2eKfD/rUGDcOKpCojtgn6Pw==
X-Gm-Gg: ASbGncvwsaXyC2UsmbkMKwOVDO7w3w54h4NGZzizC7aSmWBaa0yQYVLpzaJOF64aiUu
 ePER6mPko8KdGsGZI7VGWYacPLCMAsaUFUeHcpuLQfMNGgXgSBJHGdq4YDSU6T0XtnfglGccZt4
 wvPMv15oNHU24rytSzneQtFLUbdT+05gLVVt55Ahg5HOEIlnWQXm3rlrHkG8pklE1Elp8pbU+BD
 alqPYMDAoChvnBHZx+HnFGWOnRuHxe9P+iNfbtZTQaTXS9YQnNDiVPF6FPt92WzUYQ+MxB7Q4ly
 Ysr99WdIP1/aIBk=
X-Google-Smtp-Source: AGHT+IHmJm205CSuv9MM20BETQH6veKDhmp27ayL/sDejdgeviPXygP2TUm4yn6ayximctdt7O7ALX346FhqMvZ2SOg=
X-Received: by 2002:ac2:4c4b:0:b0:592:fb96:2af8 with SMTP id
 2adb3069b0e04-5941d5663c6mr1196589e87.51.1761899957869; Fri, 31 Oct 2025
 01:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <20251027100938.11822-1-michael@videogpu.com>
 <20251027100938.11822-4-michael@videogpu.com>
 <b6c09324-15d1-4c1a-b941-008c0a4feeb9@ventanamicro.com>
In-Reply-To: <b6c09324-15d1-4c1a-b941-008c0a4feeb9@ventanamicro.com>
From: Michael Levit <michael@videogpu.com>
Date: Fri, 31 Oct 2025 10:39:06 +0200
X-Gm-Features: AWmQ_bkrARV4s_1Y8nu-NQ2OFzALuCKNbD7VqjRGAeeJS4-vR9O139Avo-pGeYI
Message-ID: <CA+KCYkuQY3BqDbR1V+cj4xFPBXy9hhYM6ja_dsk0MLZQD7RtBQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] hw/char: add NEORV32 UART (CTRL/DATA, fifo,
 chardev)
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, philmd@linaro.org, 
 pbonzini@redhat.com, zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, 
 smishash@gmail.com
Content-Type: multipart/alternative; boundary="0000000000001e6c2b0642704d9f"
Received-SPF: none client-ip=2a00:1450:4864:20::12b;
 envelope-from=michael@videogpu.com; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

--0000000000001e6c2b0642704d9f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for review,  Daniel.

I see that CharBackend was renamed to CharFrontend in recent commits, so
the fix would be easy.
I will update the patches based on your notes and resend.

Best Regards,
Michael.

On Thu, Oct 30, 2025 at 2:36=E2=80=AFPM Daniel Henrique Barboza <
dbarboza@ventanamicro.com> wrote:

> Hi,
>
> This patch fails to build (in my env at least):
>
>
>
> /home/danielhb/work/qemu/include/hw/char/neorv32_uart.h:57:5: error:
> unknown type name =E2=80=98CharBackend=E2=80=99; did you mean =E2=80=98Ch=
ardevBackend=E2=80=99?
>     57 |     CharBackend chr;
>        |     ^~~~~~~~~~~
>        |     ChardevBackend
> In file included from /home/danielhb/work/qemu/include/qemu/osdep.h:53,
>                   from ../hw/char/neorv32_uart.c:23:
> /home/danielhb/work/qemu/include/qemu/compiler.h:65:35: error: invalid
> operands to binary - (have =E2=80=98CharFrontend *=E2=80=99 and =E2=80=98=
int *=E2=80=99)
>     65 | #define type_check(t1,t2) ((t1*)0 - (t2*)0)
>        |                                   ^
> /home/danielhb/work/qemu/include/hw/qdev-properties.h:82:15: note: in
> expansion of macro =E2=80=98type_check=E2=80=99
>     82 |             + type_check(_type, typeof_field(_state, _field)),  =
 \
>        |               ^~~~~~~~~~
> /home/danielhb/work/qemu/include/hw/qdev-properties-system.h:41:5: note:
> in expansion of macro =E2=80=98DEFINE_PROP=E2=80=99
>     41 |     DEFINE_PROP(_n, _s, _f, qdev_prop_chr, CharFrontend)
>        |     ^~~~~~~~~~~
> ../hw/char/neorv32_uart.c:41:5: note: in expansion of macro
> =E2=80=98DEFINE_PROP_CHR=E2=80=99
>     41 |     DEFINE_PROP_CHR("chardev", Neorv32UARTState, chr),
>        |     ^~~~~~~~~~~~~~~
> ../hw/char/neorv32_uart.c: In function =E2=80=98neorv32_uart_read=E2=80=
=99:
> ../hw/char/neorv32_uart.c:121:42: error: passing argument 1 of
> =E2=80=98qemu_chr_fe_accept_input=E2=80=99 from incompatible pointer type
> [-Wincompatible-pointer-types]
>    121 |                 qemu_chr_fe_accept_input(&s->chr);
>        |                                          ^~~~~~~
>        |                                          |
>        |                                          int *
> In file included from ../hw/char/neorv32_uart.c:28:
> /home/danielhb/work/qemu/include/chardev/char-fe.h:131:45: note: expected
> =E2=80=98CharFrontend *=E2=80=99 but argument is of type =E2=80=98int *=
=E2=80=99
>    131 | void qemu_chr_fe_accept_input(CharFrontend *c);
>        |                               ~~~~~~~~~~~~~~^
> ../hw/char/neorv32_uart.c: In function =E2=80=98neorv32_uart_write=E2=80=
=99:
> ../hw/char/neorv32_uart.c:156:31: error: passing argument 1 of
> =E2=80=98qemu_chr_fe_write=E2=80=99 from incompatible pointer type
> [-Wincompatible-pointer-types]
>    156 |             qemu_chr_fe_write(&s->chr, &ch, 1);
>        |                               ^~~~~~~
>        |                               |
>        |                               int *
> /home/danielhb/work/qemu/include/chardev/char-fe.h:232:37: note: expected
> =E2=80=98CharFrontend *=E2=80=99 but argument is of type =E2=80=98int *=
=E2=80=99
>    232 | int qemu_chr_fe_write(CharFrontend *c, const uint8_t *buf, int
> len);
>        |                       ~~~~~~~~~~~~~~^
> ../hw/char/neorv32_uart.c: In function =E2=80=98neorv32_uart_be_change=E2=
=80=99:
> ../hw/char/neorv32_uart.c:216:30: error: passing argument 1 of
> =E2=80=98qemu_chr_fe_set_handlers=E2=80=99 from incompatible pointer type
> [-Wincompatible-pointer-types]
>    216 |     qemu_chr_fe_set_handlers(&s->chr, neorv32_uart_can_rx,
> neorv32_uart_rx,
>        |                              ^~~~~~~
>        |                              |
>        |                              int *
> /home/danielhb/work/qemu/include/chardev/char-fe.h:108:45: note: expected
> =E2=80=98CharFrontend *=E2=80=99 but argument is of type =E2=80=98int *=
=E2=80=99
>    108 | void qemu_chr_fe_set_handlers(CharFrontend *c,
>        |                               ~~~~~~~~~~~~~~^
> ../hw/char/neorv32_uart.c: In function =E2=80=98neorv32_uart_realize=E2=
=80=99:
> ../hw/char/neorv32_uart.c:227:30: error: passing argument 1 of
> =E2=80=98qemu_chr_fe_set_handlers=E2=80=99 from incompatible pointer type
> [-Wincompatible-pointer-types]
>    227 |     qemu_chr_fe_set_handlers(&s->chr, neorv32_uart_can_rx,
> neorv32_uart_rx,
>        |                              ^~~~~~~
>        |                              |
>        |                              int *
> /home/danielhb/work/qemu/include/chardev/char-fe.h:108:45: note: expected
> =E2=80=98CharFrontend *=E2=80=99 but argument is of type =E2=80=98int *=
=E2=80=99
>    108 | void qemu_chr_fe_set_handlers(CharFrontend *c,
>        |                               ~~~~~~~~~~~~~~^
> [1730/3024] Compiling C object libsystem.a.p/hw_core_sysbus-fdt.c.o
> ninja: build stopped: subcommand failed.
>
>
> Thanks,
>
> Daniel
>
> On 10/27/25 7:09 AM, Michael Levit wrote:
> > From: Michael <michael@videogpu.com>
> >
> > Add NEORV32 UART device: CTRL/DATA registers, RX FIFO, TX to chardev.
> > Includes Kconfig/meson and public header.
> >
> > Signed-off-by: Michael Levit <michael@videogpu.com>
> >
> > diff --git a/hw/char/Kconfig b/hw/char/Kconfig
> > index 020c0a84bb..1fd39c2b30 100644
> > --- a/hw/char/Kconfig
> > +++ b/hw/char/Kconfig
> > @@ -95,3 +95,6 @@ config IP_OCTAL_232
> >       bool
> >       default y
> >       depends on IPACK
> > +
> > +config NEORV32_UART
> > +    bool
> >
> > diff --git a/hw/char/meson.build b/hw/char/meson.build
> > index a9e1dc26c0..2f5bf827a7 100644
> > --- a/hw/char/meson.build
> > +++ b/hw/char/meson.build
> > @@ -31,6 +31,7 @@ system_ss.add(when: 'CONFIG_OMAP', if_true:
> files('omap_uart.c'))
> >   system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_aux.c'))
> >   system_ss.add(when: 'CONFIG_RENESAS_SCI', if_true:
> files('renesas_sci.c'))
> >   system_ss.add(when: 'CONFIG_SIFIVE_UART', if_true:
> files('sifive_uart.c'))
> > +system_ss.add(when: 'CONFIG_NEORV32_UART', if_true:
> files('neorv32_uart.c'))
> >   system_ss.add(when: 'CONFIG_SH_SCI', if_true: files('sh_serial.c'))
> >   system_ss.add(when: 'CONFIG_STM32F2XX_USART', if_true:
> files('stm32f2xx_usart.c'))
> >   system_ss.add(when: 'CONFIG_STM32L4X5_USART', if_true:
> files('stm32l4x5_usart.c'))
> >
> > diff --git a/hw/char/neorv32_uart.c b/hw/char/neorv32_uart.c
> > new file mode 100644
> > index 0000000000..b54ab54d6a
> > --- /dev/null
> > +++ b/hw/char/neorv32_uart.c
> > @@ -0,0 +1,311 @@
> > +/*
> > + * Neorv32-specific UART.
> > + *
> > + * Copyright (c) 2025 Michael Levit
> > + *
> > + * Author:
> > + *   Michael Levit <michael@videogpu.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> it
> > + * under the terms and conditions of the GNU General Public License,
> > + * version 2 or later, as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope it will be useful, but
> WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> License for
> > + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> along with
> > + * this program.  If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "qemu/log.h"
> > +#include "migration/vmstate.h"
> > +#include "chardev/char.h"
> > +#include "chardev/char-fe.h"
> > +#include "hw/irq.h"
> > +#include "hw/char/neorv32_uart.h"
> > +#include "hw/qdev-properties-system.h"
> > +
> > +typedef volatile struct __attribute__((packed,aligned(4))) {
> > +  uint32_t CTRL;  /**< offset 0: control register
> (#NEORV32_UART_CTRL_enum) */
> > +  uint32_t DATA;  /**< offset 4: data register
> (#NEORV32_UART_DATA_enum) */
> > +} neorv32_uart_t;
> > +
> > +#define NEORV32_UART_IO_REGION_SIZE  (32)
> > +
> > +static Property neorv32_uart_properties[] =3D {
> > +    DEFINE_PROP_CHR("chardev", Neorv32UARTState, chr),
> > +};
> > +
> > +enum {
> > +    NEORV32_UART_CTRL =3D 0,  /**< offset 0: control register */
> > +    NEORV32_UART_DATA =3D 4  /**< offset 4: data register  */
> > +};
> > +
> > +/** UART control register bits */
> > +enum NEORV32_UART_CTRL_enum {
> > +  UART_CTRL_EN            =3D  0, /**< UART control register(0)  (r/w)=
:
> UART global enable */
> > +  UART_CTRL_SIM_MODE      =3D  1, /**< UART control register(1)  (r/w)=
:
> Simulation output override enable */
> > +  UART_CTRL_HWFC_EN       =3D  2, /**< UART control register(2)  (r/w)=
:
> Enable RTS/CTS hardware flow-control */
> > +  UART_CTRL_PRSC_LSB      =3D  3, /**< UART control register(3)  (r/w)=
:
> clock prescaler select, bit 0 (LSB) */
> > +  UART_CTRL_PRSC_MSB      =3D  5, /**< UART control register(5)  (r/w)=
:
> clock prescaler select, bit 2 (MSB) */
> > +  UART_CTRL_BAUD_LSB      =3D  6, /**< UART control register(6)  (r/w)=
:
> BAUD rate divisor, bit 0 (LSB) */
> > +  UART_CTRL_BAUD_MSB      =3D 15, /**< UART control register(15) (r/w)=
:
> BAUD rate divisor, bit 9 (MSB) */
> > +  UART_CTRL_RX_NEMPTY     =3D 16, /**< UART control register(16) (r/-)=
:
> RX FIFO not empty */
> > +  UART_CTRL_RX_FULL       =3D 17, /**< UART control register(17) (r/-)=
:
> RX FIFO full */
> > +  UART_CTRL_TX_EMPTY      =3D 18, /**< UART control register(18) (r/-)=
:
> TX FIFO empty */
> > +  UART_CTRL_TX_NFULL      =3D 19, /**< UART control register(19) (r/-)=
:
> TX FIFO not full */
> > +  UART_CTRL_IRQ_RX_NEMPTY =3D 20, /**< UART control register(20) (r/w)=
:
> Fire IRQ if RX FIFO not empty */
> > +  UART_CTRL_IRQ_RX_FULL   =3D 21, /**< UART control register(21) (r/w)=
:
> Fire IRQ if RX FIFO full */
> > +  UART_CTRL_IRQ_TX_EMPTY  =3D 22, /**< UART control register(22) (r/w)=
:
> Fire IRQ if TX FIFO empty */
> > +  UART_CTRL_IRQ_TX_NFULL  =3D 23, /**< UART control register(23) (r/w)=
:
> Fire IRQ if TX FIFO not full */
> > +
> > +  UART_CTRL_RX_OVER       =3D 30, /**< UART control register(30) (r/-)=
:
> RX FIFO overflow */
> > +  UART_CTRL_TX_BUSY       =3D 31  /**< UART control register(31) (r/-)=
:
> Transmitter busy or TX FIFO not empty */
> > +};
> > +
> > +/**  bits */
> > +enum NEORV32_UART_DATA_enum {
> > +  UART_DATA_RTX_LSB          =3D  0, /**< (r/w): UART rx/tx data, LSB =
*/
> > +  UART_DATA_RTX_MSB          =3D  7, /**< (r/w): UART rx/tx data, MSB =
*/
> > +
> > +  UART_DATA_RX_FIFO_SIZE_LSB =3D  8, /**< (r/-): log2(RX FIFO size), L=
SB
> */
> > +  UART_DATA_RX_FIFO_SIZE_MSB =3D 11, /**< (r/-): log2(RX FIFO size), M=
SB
> */
> > +
> > +  UART_DATA_TX_FIFO_SIZE_LSB =3D 12, /**< (r/-): log2(RX FIFO size), L=
SB
> */
> > +  UART_DATA_TX_FIFO_SIZE_MSB =3D 15, /**< (r/-): log2(RX FIFO size), M=
SB
> */
> > +};
> > +/**@}*/
> > +
> > +static void neorv32_uart_update_irq(Neorv32UARTState *s)
> > +{
> > +    int cond =3D 0;
> > +    if ((s->ie & NEORV32_UART_IE_TXWM) ||
> > +        ((s->ie & NEORV32_UART_IE_RXWM) && s->rx_fifo_len)) {
> > +        cond =3D 1;
> > +    }
> > +    if (cond) {
> > +        qemu_irq_raise(s->irq);
> > +    } else {
> > +        qemu_irq_lower(s->irq);
> > +    }
> > +}
> > +
> > +static uint64_t
> > +neorv32_uart_read(void *opaque, hwaddr addr, unsigned int size)
> > +{
> > +    Neorv32UARTState *s =3D opaque;
> > +    unsigned char r;
> > +
> > +    switch (addr) {
> > +        case NEORV32_UART_CTRL:
> > +                     if (s->rx_fifo_len) {
> > +                             s->CTRL |=3D (1 << UART_CTRL_RX_NEMPTY); =
/*
> set data available */
> > +                     } else {
> > +                             s->CTRL &=3D ~(1 << UART_CTRL_RX_NEMPTY);=
 /*
> clear data available */
> > +                     }
> > +                     //TODO: assuming here TX is always avalable, fix
> it.
> > +                     s->CTRL |=3D (1 << UART_CTRL_TX_NFULL); /* set TX
> not full */
> > +
> > +             return s->CTRL;
> > +
> > +        case NEORV32_UART_DATA:
> > +            if (s->rx_fifo_len) {
> > +                r =3D s->rx_fifo[0];
> > +                memmove(s->rx_fifo, s->rx_fifo + 1, s->rx_fifo_len - 1=
);
> > +                s->rx_fifo_len--;
> > +                qemu_chr_fe_accept_input(&s->chr);
> > +                s->DATA =3D r;
> > +
> > +                neorv32_uart_update_irq(s); /* TODO: check if need to
> call */
> > +                return r;
> > +            }
> > +        }
> > +
> > +
> > +
> > +    qemu_log_mask(LOG_GUEST_ERROR, "%s: bad read: addr=3D0x%x\n",
> > +                  __func__, (int)addr);
> > +    return 0;
> > +}
> > +
> > +
> > +
> > +static void
> > +neorv32_uart_write(void *opaque, hwaddr addr,
> > +                  uint64_t val64, unsigned int size)
> > +{
> > +
> > +    Neorv32UARTState *s =3D opaque;
> > +    uint32_t value =3D val64;
> > +    unsigned char ch =3D value;
> > +
> > +    /* TODO: check if need to update data and control bits */
> > +    switch (addr) {
> > +        case NEORV32_UART_CTRL:
> > +            s->CTRL =3D value;
> > +            /* TODO: check if need to call, depending on IRQ flags */
> > +            /* neorv32_uart_update_irq(s); */
> > +            return;
> > +        case NEORV32_UART_DATA:
> > +            s->DATA =3D value;
> > +            qemu_chr_fe_write(&s->chr, &ch, 1);
> > +            /* neorv32_uart_update_irq(s); TODO: check if need to call
> */
> > +            return;
> > +        }
> > +
> > +    qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write: addr=3D0x%x v=3D0x%=
x\n",
> > +                  __func__, (int)addr, (int)value);
> > +}
> > +
> > +static const MemoryRegionOps neorv32_uart_ops =3D {
> > +    .read  =3D neorv32_uart_read,
> > +    .write =3D neorv32_uart_write,
> > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 4
> > +    }
> > +};
> > +
> > +static void neorv32_uart_init(Object *obj)
> > +{
> > +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> > +    Neorv32UARTState *s =3D NEORV32_UART(obj);
> > +
> > +    memory_region_init_io(&s->mmio, OBJECT(s), &neorv32_uart_ops, s,
> > +                          TYPE_NEORV32_UART,
> NEORV32_UART_IO_REGION_SIZE);
> > +    sysbus_init_mmio(sbd, &s->mmio);
> > +    sysbus_init_irq(sbd, &s->irq);
> > +}
> > +
> > +
> > +static void neorv32_uart_rx(void *opaque, const uint8_t *buf, int size=
)
> > +{
> > +    Neorv32UARTState *s =3D opaque;
> > +
> > +    /* Got a byte.  */
> > +    if (s->rx_fifo_len >=3D sizeof(s->rx_fifo)) {
> > +        printf("WARNING: UART dropped char.\n");
> > +        return;
> > +    }
> > +    s->rx_fifo[s->rx_fifo_len++] =3D *buf;
> > +
> > +    neorv32_uart_update_irq(s);
> > +}
> > +
> > +static int neorv32_uart_can_rx(void *opaque)
> > +{
> > +    Neorv32UARTState *s =3D opaque;
> > +
> > +    return s->rx_fifo_len < sizeof(s->rx_fifo);
> > +}
> > +
> > +static void neorv32_uart_event(void *opaque, QEMUChrEvent event)
> > +{
> > +}
> > +
> > +static int  neorv32_uart_be_change(void *opaque)
> > +{
> > +    Neorv32UARTState *s =3D opaque;
> > +
> > +    qemu_chr_fe_set_handlers(&s->chr, neorv32_uart_can_rx,
> neorv32_uart_rx,
> > +                             neorv32_uart_event,
> neorv32_uart_be_change, s,
> > +                             NULL, true);
> > +
> > +    return 0;
> > +}
> > +
> > +static void neorv32_uart_realize(DeviceState *dev, Error **errp)
> > +{
> > +    Neorv32UARTState *s =3D NEORV32_UART(dev);
> > +
> > +    qemu_chr_fe_set_handlers(&s->chr, neorv32_uart_can_rx,
> neorv32_uart_rx,
> > +                            neorv32_uart_event, neorv32_uart_be_change=
,
> s,
> > +                             NULL, true);
> > +
> > +}
> > +
> > +static const VMStateDescription vmstate_neorv32_uart =3D {
> > +    .name =3D TYPE_NEORV32_UART,
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_UINT8_ARRAY(rx_fifo,
> > +                            Neorv32UARTState,
> > +                            NEORV32_UART_RX_FIFO_SIZE),
> > +        VMSTATE_UINT8(rx_fifo_len, Neorv32UARTState),
> > +        VMSTATE_UINT32(ie, Neorv32UARTState),
> > +        VMSTATE_END_OF_LIST()
> > +    },
> > +};
> > +
> > +static void neorv32_uart_reset_enter(Object *obj, ResetType type)
> > +{
> > +    Neorv32UARTState *s =3D NEORV32_UART(obj);
> > +    s->rx_fifo_len =3D 0;
> > +    s->ie =3D 0;
> > +}
> > +
> > +static void neorv32_uart_reset_hold(Object *obj, ResetType type)
> > +{
> > +    Neorv32UARTState *s =3D NEORV32_UART(obj);
> > +    qemu_irq_lower(s->irq);
> > +}
> > +
> > +static void neorv32_uart_class_init(ObjectClass *oc,const void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> > +    ResettableClass *rc =3D RESETTABLE_CLASS(oc);
> > +
> > +    dc->realize =3D neorv32_uart_realize;
> > +    dc->vmsd =3D &vmstate_neorv32_uart;
> > +    rc->phases.enter =3D neorv32_uart_reset_enter;
> > +    rc->phases.hold  =3D neorv32_uart_reset_hold;
> > +    device_class_set_props(dc, neorv32_uart_properties);
> > +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> > +}
> > +
> > +static const TypeInfo neorv32_uart_info =3D {
> > +    .name          =3D TYPE_NEORV32_UART,
> > +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_size =3D sizeof(Neorv32UARTState),
> > +    .instance_init =3D neorv32_uart_init,
> > +    .class_init    =3D neorv32_uart_class_init,
> > +};
> > +
> > +static void neorv32_uart_register_types(void)
> > +{
> > +    type_register_static(&neorv32_uart_info);
> > +}
> > +
> > +type_init(neorv32_uart_register_types)
> > +/*
> > + * Create UART device.
> > + */
> > +Neorv32UARTState *neorv32_uart_create(MemoryRegion *address_space,
> > +                                      hwaddr base,
> > +                                      Chardev *chr)
> > +{
> > +    DeviceState *dev;
> > +    SysBusDevice *s;
> > +    bool succed=3D false;
> > +
> > +    dev =3D qdev_new("riscv.neorv32.uart");
> > +
> > +    qdev_prop_set_chr(dev, "chardev", chr);
> > +    s =3D SYS_BUS_DEVICE(dev);
> > +    succed =3D sysbus_realize_and_unref(s, &error_fatal);
> > +
> > +    if (succed) {
> > +        memory_region_add_subregion(address_space, base,
> > +                                    sysbus_mmio_get_region(s, 0));
> > +        return NEORV32_UART(dev);
> > +    } else {
> > +        return NULL;
> > +    }
> > +} //neorv32_uart_create
> >
> > diff --git a/include/hw/char/neorv32_uart.h
> b/include/hw/char/neorv32_uart.h
> > new file mode 100644
> > index 0000000000..3651d4741f
> > --- /dev/null
> > +++ b/include/hw/char/neorv32_uart.h
> > @@ -0,0 +1,68 @@
> > +/*
> > + * Neorv32-specific UART.
> > + *
> > + * Copyright (c) 2025 Michael Levit
> > + *
> > + * Author:
> > + *   Michael Levit <michael@videogpu.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> it
> > + * under the terms and conditions of the GNU General Public License,
> > + * version 2 or later, as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope it will be useful, but
> WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> License for
> > + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> along with
> > + * this program.  If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#ifndef HW_NEORV32_UART_H
> > +#define HW_NEORV32_UART_H
> > +
> > +#include "chardev/char-fe.h"
> > +#include "hw/qdev-properties.h"
> > +#include "hw/sysbus.h"
> > +#include "qom/object.h"
> > +
> > +#define TYPE_NEORV32_UART "riscv.neorv32.uart"
> > +OBJECT_DECLARE_SIMPLE_TYPE(Neorv32UARTState, NEORV32_UART)
> > +
> > +#define QEMU_UART_DATA_RX_FIFO_SIZE_LSB  8 /**256 < UART data
> register(8)  (r/-): log2(RX FIFO size), LSB */
> > +#define QEMU_UART_DATA_RX_FIFO_SIZE_MSB  11 /** 2048 < UART data
> register(11) (r/-): log2(RX FIFO size), MSB */
> > +
> > +#define NEORV32_UART_RX_FIFO_SIZE  32 //in HW it is  2048 + 256 =3D _M=
SB
> + _LSB
> > +
> > +enum {
> > +     NEORV32_UART_IE_TXWM       =3D 1, /* Transmit watermark interrupt
> enable */
> > +     NEORV32_UART_IE_RXWM       =3D 2  /* Receive watermark interrupt
> enable */
> > +};
> > +
> > +enum {
> > +     NEORV32_UART_IP_TXWM       =3D 1, /* Transmit watermark interrupt
> pending */
> > +     NEORV32_UART_IP_RXWM       =3D 2  /* Receive watermark interrupt
> pending */
> > +};
> > +
> > +
> > +
> > +struct Neorv32UARTState {
> > +    /*< private >*/
> > +    SysBusDevice parent_obj;
> > +
> > +    /*< public >*/
> > +    qemu_irq irq;
> > +    MemoryRegion mmio;
> > +    CharBackend chr;
> > +    uint8_t rx_fifo[NEORV32_UART_RX_FIFO_SIZE];
> > +    uint8_t rx_fifo_len;
> > +    uint32_t ie; //interrupt enable
> > +    uint32_t CTRL;
> > +    uint32_t DATA;
> > +};
> > +
> > +Neorv32UARTState *neorv32_uart_create(MemoryRegion *address_space,
> hwaddr base,
> > +    Chardev *chr);
> > +
> > +#endif //HW_NEORV32_UART_H
>
>

--0000000000001e6c2b0642704d9f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks for review,=C2=A0 Daniel.<br></div><div><br></=
div><div>I see that CharBackend was renamed to CharFrontend in recent commi=
ts, so the fix would be easy.<br></div><div>I will update the patches based=
 on your notes and resend.<br><br></div><div>Best Regards,<br></div><div>Mi=
chael.<br></div></div><br><div class=3D"gmail_quote gmail_quote_container">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 30, 2025 at 2:36=E2=80=AF=
PM Daniel Henrique Barboza &lt;<a href=3D"mailto:dbarboza@ventanamicro.com"=
>dbarboza@ventanamicro.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">Hi,<br>
<br>
This patch fails to build (in my env at least):<br>
<br>
<br>
<br>
/home/danielhb/work/qemu/include/hw/char/neorv32_uart.h:57:5: error: unknow=
n type name =E2=80=98CharBackend=E2=80=99; did you mean =E2=80=98ChardevBac=
kend=E2=80=99?<br>
=C2=A0 =C2=A0 57 |=C2=A0 =C2=A0 =C2=A0CharBackend chr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0ChardevBackend<br>
In file included from /home/danielhb/work/qemu/include/qemu/osdep.h:53,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from ../hw/c=
har/neorv32_uart.c:23:<br>
/home/danielhb/work/qemu/include/qemu/compiler.h:65:35: error: invalid oper=
ands to binary - (have =E2=80=98CharFrontend *=E2=80=99 and =E2=80=98int *=
=E2=80=99)<br>
=C2=A0 =C2=A0 65 | #define type_check(t1,t2) ((t1*)0 - (t2*)0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0^<br>
/home/danielhb/work/qemu/include/hw/qdev-properties.h:82:15: note: in expan=
sion of macro =E2=80=98type_check=E2=80=99<br>
=C2=A0 =C2=A0 82 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ type_ch=
eck(_type, typeof_field(_state, _field)),=C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0^~~~~~~~~~<br>
/home/danielhb/work/qemu/include/hw/qdev-properties-system.h:41:5: note: in=
 expansion of macro =E2=80=98DEFINE_PROP=E2=80=99<br>
=C2=A0 =C2=A0 41 |=C2=A0 =C2=A0 =C2=A0DEFINE_PROP(_n, _s, _f, qdev_prop_chr=
, CharFrontend)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~<br>
../hw/char/neorv32_uart.c:41:5: note: in expansion of macro =E2=80=98DEFINE=
_PROP_CHR=E2=80=99<br>
=C2=A0 =C2=A0 41 |=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_CHR(&quot;chardev&quot;, =
Neorv32UARTState, chr),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~<br>
../hw/char/neorv32_uart.c: In function =E2=80=98neorv32_uart_read=E2=80=99:=
<br>
../hw/char/neorv32_uart.c:121:42: error: passing argument 1 of =E2=80=98qem=
u_chr_fe_accept_input=E2=80=99 from incompatible pointer type [-Wincompatib=
le-pointer-types]<br>
=C2=A0 =C2=A0121 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0qemu_chr_fe_accept_input(&amp;s-&gt;chr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int *<br>
In file included from ../hw/char/neorv32_uart.c:28:<br>
/home/danielhb/work/qemu/include/chardev/char-fe.h:131:45: note: expected =
=E2=80=98CharFrontend *=E2=80=99 but argument is of type =E2=80=98int *=E2=
=80=99<br>
=C2=A0 =C2=A0131 | void qemu_chr_fe_accept_input(CharFrontend *c);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~~~~~~~~=
~~~~~^<br>
../hw/char/neorv32_uart.c: In function =E2=80=98neorv32_uart_write=E2=80=99=
:<br>
../hw/char/neorv32_uart.c:156:31: error: passing argument 1 of =E2=80=98qem=
u_chr_fe_write=E2=80=99 from incompatible pointer type [-Wincompatible-poin=
ter-types]<br>
=C2=A0 =C2=A0156 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_chr_=
fe_write(&amp;s-&gt;chr, &amp;ch, 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int *<br>
/home/danielhb/work/qemu/include/chardev/char-fe.h:232:37: note: expected =
=E2=80=98CharFrontend *=E2=80=99 but argument is of type =E2=80=98int *=E2=
=80=99<br>
=C2=A0 =C2=A0232 | int qemu_chr_fe_write(CharFrontend *c, const uint8_t *bu=
f, int len);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~~~~~~~~~~~~~^<br>
../hw/char/neorv32_uart.c: In function =E2=80=98neorv32_uart_be_change=E2=
=80=99:<br>
../hw/char/neorv32_uart.c:216:30: error: passing argument 1 of =E2=80=98qem=
u_chr_fe_set_handlers=E2=80=99 from incompatible pointer type [-Wincompatib=
le-pointer-types]<br>
=C2=A0 =C2=A0216 |=C2=A0 =C2=A0 =C2=A0qemu_chr_fe_set_handlers(&amp;s-&gt;c=
hr, neorv32_uart_can_rx, neorv32_uart_rx,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int *<br>
/home/danielhb/work/qemu/include/chardev/char-fe.h:108:45: note: expected =
=E2=80=98CharFrontend *=E2=80=99 but argument is of type =E2=80=98int *=E2=
=80=99<br>
=C2=A0 =C2=A0108 | void qemu_chr_fe_set_handlers(CharFrontend *c,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~~~~~~~~=
~~~~~^<br>
../hw/char/neorv32_uart.c: In function =E2=80=98neorv32_uart_realize=E2=80=
=99:<br>
../hw/char/neorv32_uart.c:227:30: error: passing argument 1 of =E2=80=98qem=
u_chr_fe_set_handlers=E2=80=99 from incompatible pointer type [-Wincompatib=
le-pointer-types]<br>
=C2=A0 =C2=A0227 |=C2=A0 =C2=A0 =C2=A0qemu_chr_fe_set_handlers(&amp;s-&gt;c=
hr, neorv32_uart_can_rx, neorv32_uart_rx,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int *<br>
/home/danielhb/work/qemu/include/chardev/char-fe.h:108:45: note: expected =
=E2=80=98CharFrontend *=E2=80=99 but argument is of type =E2=80=98int *=E2=
=80=99<br>
=C2=A0 =C2=A0108 | void qemu_chr_fe_set_handlers(CharFrontend *c,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~~~~~~~~=
~~~~~^<br>
[1730/3024] Compiling C object libsystem.a.p/hw_core_sysbus-fdt.c.o<br>
ninja: build stopped: subcommand failed.<br>
<br>
<br>
Thanks,<br>
<br>
Daniel<br>
<br>
On 10/27/25 7:09 AM, Michael Levit wrote:<br>
&gt; From: Michael &lt;<a href=3D"mailto:michael@videogpu.com" target=3D"_b=
lank">michael@videogpu.com</a>&gt;<br>
&gt; <br>
&gt; Add NEORV32 UART device: CTRL/DATA registers, RX FIFO, TX to chardev.<=
br>
&gt; Includes Kconfig/meson and public header.<br>
&gt; <br>
&gt; Signed-off-by: Michael Levit &lt;<a href=3D"mailto:michael@videogpu.co=
m" target=3D"_blank">michael@videogpu.com</a>&gt;<br>
&gt; <br>
&gt; diff --git a/hw/char/Kconfig b/hw/char/Kconfig<br>
&gt; index 020c0a84bb..1fd39c2b30 100644<br>
&gt; --- a/hw/char/Kconfig<br>
&gt; +++ b/hw/char/Kconfig<br>
&gt; @@ -95,3 +95,6 @@ config IP_OCTAL_232<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0default y<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on IPACK<br>
&gt; +<br>
&gt; +config NEORV32_UART<br>
&gt; +=C2=A0 =C2=A0 bool<br>
&gt; <br>
&gt; diff --git a/hw/char/meson.build b/hw/char/meson.build<br>
&gt; index a9e1dc26c0..2f5bf827a7 100644<br>
&gt; --- a/hw/char/meson.build<br>
&gt; +++ b/hw/char/meson.build<br>
&gt; @@ -31,6 +31,7 @@ system_ss.add(when: &#39;CONFIG_OMAP&#39;, if_true: =
files(&#39;omap_uart.c&#39;))<br>
&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_RASPI&#39;, if_true: files=
(&#39;bcm2835_aux.c&#39;))<br>
&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_RENESAS_SCI&#39;, if_true:=
 files(&#39;renesas_sci.c&#39;))<br>
&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_SIFIVE_UART&#39;, if_true:=
 files(&#39;sifive_uart.c&#39;))<br>
&gt; +system_ss.add(when: &#39;CONFIG_NEORV32_UART&#39;, if_true: files(&#3=
9;neorv32_uart.c&#39;))<br>
&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_SH_SCI&#39;, if_true: file=
s(&#39;sh_serial.c&#39;))<br>
&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_STM32F2XX_USART&#39;, if_t=
rue: files(&#39;stm32f2xx_usart.c&#39;))<br>
&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_STM32L4X5_USART&#39;, if_t=
rue: files(&#39;stm32l4x5_usart.c&#39;))<br>
&gt; <br>
&gt; diff --git a/hw/char/neorv32_uart.c b/hw/char/neorv32_uart.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..b54ab54d6a<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/char/neorv32_uart.c<br>
&gt; @@ -0,0 +1,311 @@<br>
&gt; +/*<br>
&gt; + * Neorv32-specific UART.<br>
&gt; + *<br>
&gt; + * Copyright (c) 2025 Michael Levit<br>
&gt; + *<br>
&gt; + * Author:<br>
&gt; + *=C2=A0 =C2=A0Michael Levit &lt;<a href=3D"mailto:michael@videogpu.c=
om" target=3D"_blank">michael@videogpu.com</a>&gt;<br>
&gt; + *<br>
&gt; + * This program is free software; you can redistribute it and/or modi=
fy it<br>
&gt; + * under the terms and conditions of the GNU General Public License,<=
br>
&gt; + * version 2 or later, as published by the Free Software Foundation.<=
br>
&gt; + *<br>
&gt; + * This program is distributed in the hope it will be useful, but WIT=
HOUT<br>
&gt; + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY=
 or<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU General Public=
 License for<br>
&gt; + * more details.<br>
&gt; + *<br>
&gt; + * You should have received a copy of the GNU General Public License =
along with<br>
&gt; + * this program.=C2=A0 If not, see &lt;<a href=3D"http://www.gnu.org/=
licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.org/licenses=
/</a>&gt;.<br>
&gt; + */<br>
&gt; +<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;qapi/error.h&quot;<br>
&gt; +#include &quot;qemu/log.h&quot;<br>
&gt; +#include &quot;migration/vmstate.h&quot;<br>
&gt; +#include &quot;chardev/char.h&quot;<br>
&gt; +#include &quot;chardev/char-fe.h&quot;<br>
&gt; +#include &quot;hw/irq.h&quot;<br>
&gt; +#include &quot;hw/char/neorv32_uart.h&quot;<br>
&gt; +#include &quot;hw/qdev-properties-system.h&quot;<br>
&gt; +<br>
&gt; +typedef volatile struct __attribute__((packed,aligned(4))) {<br>
&gt; +=C2=A0 uint32_t CTRL;=C2=A0 /**&lt; offset 0: control register (#NEOR=
V32_UART_CTRL_enum) */<br>
&gt; +=C2=A0 uint32_t DATA;=C2=A0 /**&lt; offset 4: data register=C2=A0 (#N=
EORV32_UART_DATA_enum) */<br>
&gt; +} neorv32_uart_t;<br>
&gt; +<br>
&gt; +#define NEORV32_UART_IO_REGION_SIZE=C2=A0 (32)<br>
&gt; +<br>
&gt; +static Property neorv32_uart_properties[] =3D {<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_CHR(&quot;chardev&quot;, Neorv32UARTState, =
chr),<br>
&gt; +};<br>
&gt; +<br>
&gt; +enum {<br>
&gt; +=C2=A0 =C2=A0 NEORV32_UART_CTRL =3D 0,=C2=A0 /**&lt; offset 0: contro=
l register */<br>
&gt; +=C2=A0 =C2=A0 NEORV32_UART_DATA =3D 4=C2=A0 /**&lt; offset 4: data re=
gister=C2=A0 */<br>
&gt; +};<br>
&gt; +<br>
&gt; +/** UART control register bits */<br>
&gt; +enum NEORV32_UART_CTRL_enum {<br>
&gt; +=C2=A0 UART_CTRL_EN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=C2=
=A0 0, /**&lt; UART control register(0)=C2=A0 (r/w): UART global enable */<=
br>
&gt; +=C2=A0 UART_CTRL_SIM_MODE=C2=A0 =C2=A0 =C2=A0 =3D=C2=A0 1, /**&lt; UA=
RT control register(1)=C2=A0 (r/w): Simulation output override enable */<br=
>
&gt; +=C2=A0 UART_CTRL_HWFC_EN=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=C2=A0 2, /**&l=
t; UART control register(2)=C2=A0 (r/w): Enable RTS/CTS hardware flow-contr=
ol */<br>
&gt; +=C2=A0 UART_CTRL_PRSC_LSB=C2=A0 =C2=A0 =C2=A0 =3D=C2=A0 3, /**&lt; UA=
RT control register(3)=C2=A0 (r/w): clock prescaler select, bit 0 (LSB) */<=
br>
&gt; +=C2=A0 UART_CTRL_PRSC_MSB=C2=A0 =C2=A0 =C2=A0 =3D=C2=A0 5, /**&lt; UA=
RT control register(5)=C2=A0 (r/w): clock prescaler select, bit 2 (MSB) */<=
br>
&gt; +=C2=A0 UART_CTRL_BAUD_LSB=C2=A0 =C2=A0 =C2=A0 =3D=C2=A0 6, /**&lt; UA=
RT control register(6)=C2=A0 (r/w): BAUD rate divisor, bit 0 (LSB) */<br>
&gt; +=C2=A0 UART_CTRL_BAUD_MSB=C2=A0 =C2=A0 =C2=A0 =3D 15, /**&lt; UART co=
ntrol register(15) (r/w): BAUD rate divisor, bit 9 (MSB) */<br>
&gt; +=C2=A0 UART_CTRL_RX_NEMPTY=C2=A0 =C2=A0 =C2=A0=3D 16, /**&lt; UART co=
ntrol register(16) (r/-): RX FIFO not empty */<br>
&gt; +=C2=A0 UART_CTRL_RX_FULL=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 17, /**&lt; UA=
RT control register(17) (r/-): RX FIFO full */<br>
&gt; +=C2=A0 UART_CTRL_TX_EMPTY=C2=A0 =C2=A0 =C2=A0 =3D 18, /**&lt; UART co=
ntrol register(18) (r/-): TX FIFO empty */<br>
&gt; +=C2=A0 UART_CTRL_TX_NFULL=C2=A0 =C2=A0 =C2=A0 =3D 19, /**&lt; UART co=
ntrol register(19) (r/-): TX FIFO not full */<br>
&gt; +=C2=A0 UART_CTRL_IRQ_RX_NEMPTY =3D 20, /**&lt; UART control register(=
20) (r/w): Fire IRQ if RX FIFO not empty */<br>
&gt; +=C2=A0 UART_CTRL_IRQ_RX_FULL=C2=A0 =C2=A0=3D 21, /**&lt; UART control=
 register(21) (r/w): Fire IRQ if RX FIFO full */<br>
&gt; +=C2=A0 UART_CTRL_IRQ_TX_EMPTY=C2=A0 =3D 22, /**&lt; UART control regi=
ster(22) (r/w): Fire IRQ if TX FIFO empty */<br>
&gt; +=C2=A0 UART_CTRL_IRQ_TX_NFULL=C2=A0 =3D 23, /**&lt; UART control regi=
ster(23) (r/w): Fire IRQ if TX FIFO not full */<br>
&gt; +<br>
&gt; +=C2=A0 UART_CTRL_RX_OVER=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 30, /**&lt; UA=
RT control register(30) (r/-): RX FIFO overflow */<br>
&gt; +=C2=A0 UART_CTRL_TX_BUSY=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 31=C2=A0 /**&l=
t; UART control register(31) (r/-): Transmitter busy or TX FIFO not empty *=
/<br>
&gt; +};<br>
&gt; +<br>
&gt; +/**=C2=A0 bits */<br>
&gt; +enum NEORV32_UART_DATA_enum {<br>
&gt; +=C2=A0 UART_DATA_RTX_LSB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=C2=A0 =
0, /**&lt; (r/w): UART rx/tx data, LSB */<br>
&gt; +=C2=A0 UART_DATA_RTX_MSB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=C2=A0 =
7, /**&lt; (r/w): UART rx/tx data, MSB */<br>
&gt; +<br>
&gt; +=C2=A0 UART_DATA_RX_FIFO_SIZE_LSB =3D=C2=A0 8, /**&lt; (r/-): log2(RX=
 FIFO size), LSB */<br>
&gt; +=C2=A0 UART_DATA_RX_FIFO_SIZE_MSB =3D 11, /**&lt; (r/-): log2(RX FIFO=
 size), MSB */<br>
&gt; +<br>
&gt; +=C2=A0 UART_DATA_TX_FIFO_SIZE_LSB =3D 12, /**&lt; (r/-): log2(RX FIFO=
 size), LSB */<br>
&gt; +=C2=A0 UART_DATA_TX_FIFO_SIZE_MSB =3D 15, /**&lt; (r/-): log2(RX FIFO=
 size), MSB */<br>
&gt; +};<br>
&gt; +/**@}*/<br>
&gt; +<br>
&gt; +static void neorv32_uart_update_irq(Neorv32UARTState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int cond =3D 0;<br>
&gt; +=C2=A0 =C2=A0 if ((s-&gt;ie &amp; NEORV32_UART_IE_TXWM) ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ((s-&gt;ie &amp; NEORV32_UART_IE_RXWM) &a=
mp;&amp; s-&gt;rx_fifo_len)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cond =3D 1;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (cond) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_irq_raise(s-&gt;irq);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_irq_lower(s-&gt;irq);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static uint64_t<br>
&gt; +neorv32_uart_read(void *opaque, hwaddr addr, unsigned int size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 Neorv32UARTState *s =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 unsigned char r;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (addr) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case NEORV32_UART_CTRL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (s-&gt;rx_fifo_len) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;CTRL |=3D (1 &lt;&lt; UART_CTRL_RX=
_NEMPTY); /* set data available */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;CTRL &amp;=3D ~(1 &lt;&lt; UART_CT=
RL_RX_NEMPTY); /* clear data available */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0//TODO: assuming here TX is always avalable, fix it.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0s-&gt;CTRL |=3D (1 &lt;&lt; UART_CTRL_TX_NFULL); /* set TX not full =
*/<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;CTRL;<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case NEORV32_UART_DATA:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;rx_fifo_len) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D s-&gt;r=
x_fifo[0];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memmove(s-&gt=
;rx_fifo, s-&gt;rx_fifo + 1, s-&gt;rx_fifo_len - 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;rx_fifo=
_len--;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_chr_fe_a=
ccept_input(&amp;s-&gt;chr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;DATA =
=3D r;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 neorv32_uart_=
update_irq(s); /* TODO: check if need to call */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: bad read: addr=
=3D0x%x\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func=
__, (int)addr);<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +<br>
&gt; +static void<br>
&gt; +neorv32_uart_write(void *opaque, hwaddr addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64=
_t val64, unsigned int size)<br>
&gt; +{<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 Neorv32UARTState *s =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 uint32_t value =3D val64;<br>
&gt; +=C2=A0 =C2=A0 unsigned char ch =3D value;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* TODO: check if need to update data and control bits =
*/<br>
&gt; +=C2=A0 =C2=A0 switch (addr) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case NEORV32_UART_CTRL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;CTRL =3D value;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TODO: check if need to c=
all, depending on IRQ flags */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* neorv32_uart_update_irq(=
s); */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case NEORV32_UART_DATA:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;DATA =3D value;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_chr_fe_write(&amp;s-&g=
t;chr, &amp;ch, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* neorv32_uart_update_irq(=
s); TODO: check if need to call */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: bad write: add=
r=3D0x%x v=3D0x%x\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func=
__, (int)addr, (int)value);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const MemoryRegionOps neorv32_uart_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 .read=C2=A0 =3D neorv32_uart_read,<br>
&gt; +=C2=A0 =C2=A0 .write =3D neorv32_uart_write,<br>
&gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,<br>
&gt; +=C2=A0 =C2=A0 .valid =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 4<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void neorv32_uart_init(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);<br>
&gt; +=C2=A0 =C2=A0 Neorv32UARTState *s =3D NEORV32_UART(obj);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;mmio, OBJECT(s), &amp;=
neorv32_uart_ops, s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 TYPE_NEORV32_UART, NEORV32_UART_IO_REGION_SIZE);<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_mmio(sbd, &amp;s-&gt;mmio);<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_irq(sbd, &amp;s-&gt;irq);<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +static void neorv32_uart_rx(void *opaque, const uint8_t *buf, int siz=
e)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 Neorv32UARTState *s =3D opaque;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Got a byte.=C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;rx_fifo_len &gt;=3D sizeof(s-&gt;rx_fifo)) {<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;WARNING: UART dropped char.\=
n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 s-&gt;rx_fifo[s-&gt;rx_fifo_len++] =3D *buf;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 neorv32_uart_update_irq(s);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int neorv32_uart_can_rx(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 Neorv32UARTState *s =3D opaque;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return s-&gt;rx_fifo_len &lt; sizeof(s-&gt;rx_fifo);<br=
>
&gt; +}<br>
&gt; +<br>
&gt; +static void neorv32_uart_event(void *opaque, QEMUChrEvent event)<br>
&gt; +{<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int=C2=A0 neorv32_uart_be_change(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 Neorv32UARTState *s =3D opaque;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_chr_fe_set_handlers(&amp;s-&gt;chr, neorv32_uart_c=
an_rx, neorv32_uart_rx,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0neorv32_uart_event, neorv32_uart_be_chan=
ge, s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, true);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void neorv32_uart_realize(DeviceState *dev, Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 Neorv32UARTState *s =3D NEORV32_UART(dev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_chr_fe_set_handlers(&amp;s-&gt;chr, neorv32_uart_c=
an_rx, neorv32_uart_rx,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 neorv32_uart_event, neorv32_uart_be_change, s,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, true);<br>
&gt; +<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const VMStateDescription vmstate_neorv32_uart =3D {<br>
&gt; +=C2=A0 =C2=A0 .name =3D TYPE_NEORV32_UART,<br>
&gt; +=C2=A0 =C2=A0 .version_id =3D 1,<br>
&gt; +=C2=A0 =C2=A0 .minimum_version_id =3D 1,<br>
&gt; +=C2=A0 =C2=A0 .fields =3D (VMStateField[]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8_ARRAY(rx_fifo,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Neorv32UARTState,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NEORV32_UART_RX_FIFO_SIZE),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8(rx_fifo_len, Neorv32UARTSta=
te),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(ie, Neorv32UARTState),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void neorv32_uart_reset_enter(Object *obj, ResetType type)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 Neorv32UARTState *s =3D NEORV32_UART(obj);<br>
&gt; +=C2=A0 =C2=A0 s-&gt;rx_fifo_len =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;ie =3D 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void neorv32_uart_reset_hold(Object *obj, ResetType type)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 Neorv32UARTState *s =3D NEORV32_UART(obj);<br>
&gt; +=C2=A0 =C2=A0 qemu_irq_lower(s-&gt;irq);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void neorv32_uart_class_init(ObjectClass *oc,const void *data)=
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(oc);<br>
&gt; +=C2=A0 =C2=A0 ResettableClass *rc =3D RESETTABLE_CLASS(oc);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;realize =3D neorv32_uart_realize;<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;vmsd =3D &amp;vmstate_neorv32_uart;<br>
&gt; +=C2=A0 =C2=A0 rc-&gt;phases.enter =3D neorv32_uart_reset_enter;<br>
&gt; +=C2=A0 =C2=A0 rc-&gt;phases.hold=C2=A0 =3D neorv32_uart_reset_hold;<b=
r>
&gt; +=C2=A0 =C2=A0 device_class_set_props(dc, neorv32_uart_properties);<br=
>
&gt; +=C2=A0 =C2=A0 set_bit(DEVICE_CATEGORY_INPUT, dc-&gt;categories);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const TypeInfo neorv32_uart_info =3D {<br>
&gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_NEORV3=
2_UART,<br>
&gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SYS_BUS_DEV=
ICE,<br>
&gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(Neorv32UARTState),<br>
&gt; +=C2=A0 =C2=A0 .instance_init =3D neorv32_uart_init,<br>
&gt; +=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D neorv32_uart_class_init,<b=
r>
&gt; +};<br>
&gt; +<br>
&gt; +static void neorv32_uart_register_types(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;neorv32_uart_info);<br>
&gt; +}<br>
&gt; +<br>
&gt; +type_init(neorv32_uart_register_types)<br>
&gt; +/*<br>
&gt; + * Create UART device.<br>
&gt; + */<br>
&gt; +Neorv32UARTState *neorv32_uart_create(MemoryRegion *address_space,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hwaddr base=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Chardev *ch=
r)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceState *dev;<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice *s;<br>
&gt; +=C2=A0 =C2=A0 bool succed=3D false;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dev =3D qdev_new(&quot;riscv.neorv32.uart&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_chr(dev, &quot;chardev&quot;, chr);<br>
&gt; +=C2=A0 =C2=A0 s =3D SYS_BUS_DEVICE(dev);<br>
&gt; +=C2=A0 =C2=A0 succed =3D sysbus_realize_and_unref(s, &amp;error_fatal=
);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (succed) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_add_subregion(address_space=
, base,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_mmio_get_re=
gion(s, 0));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NEORV32_UART(dev);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +} //neorv32_uart_create<br>
&gt; <br>
&gt; diff --git a/include/hw/char/neorv32_uart.h b/include/hw/char/neorv32_=
uart.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..3651d4741f<br>
&gt; --- /dev/null<br>
&gt; +++ b/include/hw/char/neorv32_uart.h<br>
&gt; @@ -0,0 +1,68 @@<br>
&gt; +/*<br>
&gt; + * Neorv32-specific UART.<br>
&gt; + *<br>
&gt; + * Copyright (c) 2025 Michael Levit<br>
&gt; + *<br>
&gt; + * Author:<br>
&gt; + *=C2=A0 =C2=A0Michael Levit &lt;<a href=3D"mailto:michael@videogpu.c=
om" target=3D"_blank">michael@videogpu.com</a>&gt;<br>
&gt; + *<br>
&gt; + * This program is free software; you can redistribute it and/or modi=
fy it<br>
&gt; + * under the terms and conditions of the GNU General Public License,<=
br>
&gt; + * version 2 or later, as published by the Free Software Foundation.<=
br>
&gt; + *<br>
&gt; + * This program is distributed in the hope it will be useful, but WIT=
HOUT<br>
&gt; + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY=
 or<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU General Public=
 License for<br>
&gt; + * more details.<br>
&gt; + *<br>
&gt; + * You should have received a copy of the GNU General Public License =
along with<br>
&gt; + * this program.=C2=A0 If not, see &lt;<a href=3D"http://www.gnu.org/=
licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.org/licenses=
/</a>&gt;.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef HW_NEORV32_UART_H<br>
&gt; +#define HW_NEORV32_UART_H<br>
&gt; +<br>
&gt; +#include &quot;chardev/char-fe.h&quot;<br>
&gt; +#include &quot;hw/qdev-properties.h&quot;<br>
&gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt; +#include &quot;qom/object.h&quot;<br>
&gt; +<br>
&gt; +#define TYPE_NEORV32_UART &quot;riscv.neorv32.uart&quot;<br>
&gt; +OBJECT_DECLARE_SIMPLE_TYPE(Neorv32UARTState, NEORV32_UART)<br>
&gt; +<br>
&gt; +#define QEMU_UART_DATA_RX_FIFO_SIZE_LSB=C2=A0 8 /**256 &lt; UART data=
 register(8)=C2=A0 (r/-): log2(RX FIFO size), LSB */<br>
&gt; +#define QEMU_UART_DATA_RX_FIFO_SIZE_MSB=C2=A0 11 /** 2048 &lt; UART d=
ata register(11) (r/-): log2(RX FIFO size), MSB */<br>
&gt; +<br>
&gt; +#define NEORV32_UART_RX_FIFO_SIZE=C2=A0 32 //in HW it is=C2=A0 2048 +=
 256 =3D _MSB + _LSB<br>
&gt; +<br>
&gt; +enum {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0NEORV32_UART_IE_TXWM=C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D 1, /* Transmit watermark interrupt enable */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0NEORV32_UART_IE_RXWM=C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D 2=C2=A0 /* Receive watermark interrupt enable */<br>
&gt; +};<br>
&gt; +<br>
&gt; +enum {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0NEORV32_UART_IP_TXWM=C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D 1, /* Transmit watermark interrupt pending */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0NEORV32_UART_IP_RXWM=C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D 2=C2=A0 /* Receive watermark interrupt pending */<br>
&gt; +};<br>
&gt; +<br>
&gt; +<br>
&gt; +<br>
&gt; +struct Neorv32UARTState {<br>
&gt; +=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
&gt; +=C2=A0 =C2=A0 qemu_irq irq;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion mmio;<br>
&gt; +=C2=A0 =C2=A0 CharBackend chr;<br>
&gt; +=C2=A0 =C2=A0 uint8_t rx_fifo[NEORV32_UART_RX_FIFO_SIZE];<br>
&gt; +=C2=A0 =C2=A0 uint8_t rx_fifo_len;<br>
&gt; +=C2=A0 =C2=A0 uint32_t ie; //interrupt enable<br>
&gt; +=C2=A0 =C2=A0 uint32_t CTRL;<br>
&gt; +=C2=A0 =C2=A0 uint32_t DATA;<br>
&gt; +};<br>
&gt; +<br>
&gt; +Neorv32UARTState *neorv32_uart_create(MemoryRegion *address_space, hw=
addr base,<br>
&gt; +=C2=A0 =C2=A0 Chardev *chr);<br>
&gt; +<br>
&gt; +#endif //HW_NEORV32_UART_H<br>
<br>
</blockquote></div>

--0000000000001e6c2b0642704d9f--

