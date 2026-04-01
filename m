Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9761076365
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 04:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7nLl-00039s-C3; Wed, 01 Apr 2026 00:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ikerjosemartinez26@gmail.com>)
 id 1w7nLj-00039J-0B
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 00:38:39 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ikerjosemartinez26@gmail.com>)
 id 1w7nLa-00057V-B3
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 00:38:38 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43b8e8e7432so5243227f8f.1
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 21:38:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775018308; cv=none;
 d=google.com; s=arc-20240605;
 b=FMmABwyzEEtnFpY5dKlDsHNcY2M/iEuz/hrmQC0OWN6i286qfcTam/xE/ztkbuRfBL
 hjMSJllupSduvl5BLzj7KpPQmftPMCL+hEw9H9rtipXShIE0Q2XcDhFS57NhwotySotN
 SkCVCNHIawXIDicRHygRntVLqTzAWiJwOUVu6FXfhBnZRwFL6PgdHbYr5qGJHMtUsSN8
 emM45N8Tu3IvRO9DWqsUsqf2ACDIyzhmEBipWICz7y6alUlCRtous2UoLl7YvMDvjHKQ
 QYqHdufhxkCwaBG4Rh95mDa4s8H0oMhoxtKY/3eDStyoFaBXktkx/fpwCjiY67snAhnx
 MUaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SkSqruN2WlL6LyoVhF695PqbBbysdWCHPCRgqm7khNI=;
 fh=OQJfiuCybGBrVAQIx98d/zwsoIXaRmLLhvxpsqibGDk=;
 b=T9wnOcb5ftPJjNRX131a8g+BYA+6wRnwo2cCuvyTq1Sif8HWqKK8qGUJ2frorwu1Nx
 EIoSML96yo/EdaaJPobStOFMegeuzSBRu0yuf7u0gze6WG678x8NWg0OzM99tVpwLayp
 jH4hYaZoffREjmzF9nznR6q+klmdwwDduzc0LCj33gD72LSZ2cA1AYh8pmuolw8ZbeyI
 HZ2UlhQLuFLGpDUC5sidMFbozznWM9yJxiFroLQHjPi/g94jVlEW6qhP3fx/FeY4j+9N
 65wdgDwPX7amNfhvAEAiFaj7S1WszphW9QDUxb66DCuNciuIS36ud4Y3kt5pSY+oxqbD
 gKKQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775018308; x=1775623108; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SkSqruN2WlL6LyoVhF695PqbBbysdWCHPCRgqm7khNI=;
 b=hwBkiKInQcx8ODPTDdRL5ywQYk981dZDn8Oa4+3d4BGIoJ3Lz+Za/tRi0sAXxGQMAN
 QKe+2xOX5JB1gvQcH9zDPZzjExJaUqJlEm6s1m/CFzMAFb/+l9tZ8c3AfFfckbiRIyH5
 3RrOnU9+KzIduovJ1BRaJsqxDWMFd5fsqxkoo7ZTgc1Zc4JsYS1Q535de4jh1qVSlaoe
 2yotLsSu4UJAcCZxS/fKmuPZdCVEsYLX0VLTRXZ08MTCqhNKENgpUMlBi8GVEGYbU+KZ
 K2EOd6Q447brF3Owv6xhA88P8VHXirf/phM7dZUXEyZsKEzItaPokHirM2W0mUZ+HF0h
 mrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775018308; x=1775623108;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SkSqruN2WlL6LyoVhF695PqbBbysdWCHPCRgqm7khNI=;
 b=rbR8fpA4ffWi2oJ2/u22A5cu4eFj86IYnhff1KukJJi5GMHIrLa+3M2jJECffEO4EU
 pPHh4lOrRTEWi5NyHS0RsM8+3hAX5+h22ano2xkOEC39JyO+WjgzUpsAYOXnmP4OJ+nx
 an1svfwV8NAvfU0eYBqhZTTAykol+AJ+vQRA+5o5l2A7GjIxDm+gGac5lB6GLBirROkF
 9ieEi3/yxnm7amMMZ36YDIZVGDh54tC4Io+f0dbHCr3keJs5ZpMPZMRMBP0l+lhXuMgE
 iHxw0C8JGa0G0t/VhFx9WBu+n14trUw5Zef47dUc66DIF0dpd/pTSZzjpIxlXPugyiu7
 ygCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwKuWdBW9QdKU4B5Va43xldmN5Bxg64m/mpP3sQSRIF8x86eDS7ebh6AQKuJxctuEofvfXyF+En9Cb@nongnu.org
X-Gm-Message-State: AOJu0YzJwSWGYyi4VwmldlafFebmlIXHP54FJdosxjIrsDiWYf7fM3H6
 OEWxJ3nHcPytgGKhL+nhHJ2DhA1Htw1tyU8zg6qPUyFvTKVrpbzwn6FGcEj5B6sZm3gbtC86pMf
 0DijwqNPzdnkaePnQvacOPFwdv5utZuE=
X-Gm-Gg: ATEYQzzBcribRXAIwoCrEO37iPyBe9sDbORb2avX60Li6p+E845g790rSMdTlBgLpm/
 z3EoJi2czlYH7o+WHJZ5m2onQj0ovMuJa3vig5qRI+68ajFtTXd6hbPfLeATeQt/CT9GvG/T5OL
 kmOjGPKtHFFCmDc4nUBeQKHNiKVT/ryU5C1Gaqr0LEZ9xHGlLq8aW2QUHIiNURJh3ojnI4liM0c
 RDfnP+9lpxIEf/fYHQxkFwop5e9xfjqFjYNm2+mAiUlcGSmSqd0d2A852Ocm7RUws3Gbs4Q3xSx
 PnNpSp0=
X-Received: by 2002:a05:6000:60f:b0:43c:fe66:43fb with SMTP id
 ffacd0b85a97d-43d1505560amr3599731f8f.17.1775018307421; Tue, 31 Mar 2026
 21:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <177393172713.10003.9577410064303581086-0@git.sr.ht>
 <177393172713.10003.9577410064303581086-1@git.sr.ht>
 <CAKmqyKP8dU0HdahMbi-XbjtuaPWW4y404GyYE--C1dTiY5dzgQ@mail.gmail.com>
 <4f21306c-e9a4-43cb-a201-4160b234faa0@lowrisc.org>
 <CAKmqyKOQRvDUfzcGSiYUzOw_LskvjoDWAcnNnxaJVc+GrqPJZw@mail.gmail.com>
In-Reply-To: <CAKmqyKOQRvDUfzcGSiYUzOw_LskvjoDWAcnNnxaJVc+GrqPJZw@mail.gmail.com>
From: "ikerjosemartinez26@thinocorp.com" <ikerjosemartinez26@gmail.com>
Date: Tue, 31 Mar 2026 22:38:12 -0500
X-Gm-Features: AQROBzCEwKBDx7VvhLLwix72q0n5u5utx3lbeoHvEtXmNjUB1Qlg6KjC1EPPCbg
Message-ID: <CAMLMkj2njPbd9aYCQ4cWLY22JzOqGbq1-YtfRygF2NSTsoPxRg@mail.gmail.com>
Subject: Re: [PATCH qemu 1/1] Replace opentitan UART device with newer version
 (opentitan 1.0)
To: Alistair Francis <alistair23@gmail.com>
Cc: Lex Bailey <lex.bailey@lowrisc.org>, qemu-devel@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, qemu-maintainers@lowrisc.org
Content-Type: multipart/alternative; boundary="000000000000af09d1064e5ea735"
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=ikerjosemartinez26@gmail.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001, POSSIBLE_GMAIL_PHISHER=3.595,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000af09d1064e5ea735
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Estimado Alistair:

Muchas gracias por su revisi=C3=B3n detallada. Estoy de acuerdo con sus
observaciones y proceder=C3=A9 de la siguiente manera:

En primer lugar, realizar=C3=A9 el renombre del archivo de ibex_uart a ot_u=
art
en un commit separado con su debida justificaci=C3=B3n, para luego incluir =
los
cambios de implementaci=C3=B3n en commits posteriores.

Asimismo, me asegurar=C3=A9 de utilizar las macros de QEMU existentes, como
FIELD_EX32, en lugar de definiciones personalizadas. Tambi=C3=A9n corregir=
=C3=A9 el
uso de los sufijos, los repartos de tipos y la visibilidad de las
definiciones seg=C3=BAn lo sugerido. Respecto a la consistencia de la longi=
tud
del registro, evaluar=C3=A9 la implementaci=C3=B3n de una aserci=C3=B3n est=
=C3=A1tica o en
tiempo de ejecuci=C3=B3n.

Agradezco mucho su tiempo y sus comentarios.

Atentamente,

Jose Martinez


El mar, 31 de mar de 2026, 11:26=E2=80=AFp.m., Alistair Francis <
alistair23@gmail.com> escribi=C3=B3:

> On Wed, Apr 1, 2026 at 1:36=E2=80=AFAM Lex Bailey <lex.bailey@lowrisc.org=
> wrote:
> >
> >
> > On 26/03/2026 02:39, Alistair Francis wrote:
> >
> > On Fri, Mar 20, 2026 at 12:50=E2=80=AFAM ~lexbaileylowrisc
> > <lexbaileylowrisc@git.sr.ht> wrote:
> >
> > You need a commit message, it should describe what you are doing, link
> > to specs and provide details for future readers.
> >
> > From: Lex Bailey <lex.bailey@lowrisc.org>
> >
> > Signed-off-by: Lex Bailey <lex.bailey@lowrisc.org>
> > ---
> >  hw/char/ibex_uart.c          | 569 -------------------------------
> >  hw/char/meson.build          |   2 +-
> >  hw/char/ot_uart.c            | 635 +++++++++++++++++++++++++++++++++++
> >  hw/char/trace-events         |   8 +
> >  hw/riscv/opentitan.c         |   3 +-
> >  include/hw/char/ibex_uart.h  |  73 ----
> >  include/hw/char/ot_uart.h    | 133 ++++++++
> >  include/hw/riscv/opentitan.h |   4 +-
> >  8 files changed, 781 insertions(+), 646 deletions(-)
> >  delete mode 100644 hw/char/ibex_uart.c
> >  create mode 100644 hw/char/ot_uart.c
> >  delete mode 100644 include/hw/char/ibex_uart.h
> >  create mode 100644 include/hw/char/ot_uart.h
> >
> > diff --git a/hw/char/ibex_uart.c b/hw/char/ibex_uart.c
> > deleted file mode 100644
> > index 127d219df3..0000000000
> > --- a/hw/char/ibex_uart.c
> > +++ /dev/null
> >
> > I don't think we should remove the file. If you want to rename it
> > that's fine, but that should be its own commit. So one commit to
> > rename it (with a justification in the commit message) and then more
> > commits to make changes.
> >
> > okay, I will rename it first and then make changes
> >
> > @@ -1,569 +0,0 @@
> > -/*
> > - * QEMU lowRISC Ibex UART device
> > - *
> > - * Copyright (c) 2020 Western Digital
> > - *
> > - * For details check the documentation here:
> > - *    https://docs.opentitan.org/hw/ip/uart/doc/
> > - *
> > - * Permission is hereby granted, free of charge, to any person
> obtaining a copy
> > - * of this software and associated documentation files (the
> "Software"), to deal
> > - * in the Software without restriction, including without limitation
> the rights
> > - * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r
> sell
> > - * copies of the Software, and to permit persons to whom the Software =
is
> > - * furnished to do so, subject to the following conditions:
> > - *
> > - * The above copyright notice and this permission notice shall be
> included in
> > - * all copies or substantial portions of the Software.
> > - *
> > - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> > - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> > - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
> SHALL
> > - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
> OTHER
> > - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> ARISING FROM,
> > - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> DEALINGS IN
> > - * THE SOFTWARE.
> > - */
> > -
> > -#include "qemu/osdep.h"
> > -#include "hw/char/ibex_uart.h"
> > -#include "hw/core/irq.h"
> > -#include "hw/core/qdev-clock.h"
> > -#include "hw/core/qdev-properties.h"
> > -#include "hw/core/qdev-properties-system.h"
> > -#include "hw/core/registerfields.h"
> > -#include "migration/vmstate.h"
> > -#include "qemu/log.h"
> > -#include "qemu/module.h"
> > -
> > -REG32(INTR_STATE, 0x00)
> > -    FIELD(INTR_STATE, TX_WATERMARK, 0, 1)
> > -    FIELD(INTR_STATE, RX_WATERMARK, 1, 1)
> > -    FIELD(INTR_STATE, TX_EMPTY, 2, 1)
> > -    FIELD(INTR_STATE, RX_OVERFLOW, 3, 1)
> > -REG32(INTR_ENABLE, 0x04)
> > -REG32(INTR_TEST, 0x08)
> > -REG32(ALERT_TEST, 0x0C)
> > -REG32(CTRL, 0x10)
> > -    FIELD(CTRL, TX_ENABLE, 0, 1)
> > -    FIELD(CTRL, RX_ENABLE, 1, 1)
> > -    FIELD(CTRL, NF, 2, 1)
> > -    FIELD(CTRL, SLPBK, 4, 1)
> > -    FIELD(CTRL, LLPBK, 5, 1)
> > -    FIELD(CTRL, PARITY_EN, 6, 1)
> > -    FIELD(CTRL, PARITY_ODD, 7, 1)
> > -    FIELD(CTRL, RXBLVL, 8, 2)
> > -    FIELD(CTRL, NCO, 16, 16)
> > -REG32(STATUS, 0x14)
> > -    FIELD(STATUS, TXFULL, 0, 1)
> > -    FIELD(STATUS, RXFULL, 1, 1)
> > -    FIELD(STATUS, TXEMPTY, 2, 1)
> > -    FIELD(STATUS, RXIDLE, 4, 1)
> > -    FIELD(STATUS, RXEMPTY, 5, 1)
> > -REG32(RDATA, 0x18)
> > -REG32(WDATA, 0x1C)
> > -REG32(FIFO_CTRL, 0x20)
> > -    FIELD(FIFO_CTRL, RXRST, 0, 1)
> > -    FIELD(FIFO_CTRL, TXRST, 1, 1)
> > -    FIELD(FIFO_CTRL, RXILVL, 2, 3)
> > -    FIELD(FIFO_CTRL, TXILVL, 5, 2)
> > -REG32(FIFO_STATUS, 0x24)
> > -    FIELD(FIFO_STATUS, TXLVL, 0, 5)
> > -    FIELD(FIFO_STATUS, RXLVL, 16, 5)
> > -REG32(OVRD, 0x28)
> > -REG32(VAL, 0x2C)
> > -REG32(TIMEOUT_CTRL, 0x30)
> > -
> > -static void ibex_uart_update_irqs(IbexUartState *s)
> > -{
> > -    if (s->uart_intr_state & s->uart_intr_enable &
> R_INTR_STATE_TX_WATERMARK_MASK) {
> > -        qemu_set_irq(s->tx_watermark, 1);
> > -    } else {
> > -        qemu_set_irq(s->tx_watermark, 0);
> > -    }
> > -
> > -    if (s->uart_intr_state & s->uart_intr_enable &
> R_INTR_STATE_RX_WATERMARK_MASK) {
> > -        qemu_set_irq(s->rx_watermark, 1);
> > -    } else {
> > -        qemu_set_irq(s->rx_watermark, 0);
> > -    }
> > -
> > -    if (s->uart_intr_state & s->uart_intr_enable &
> R_INTR_STATE_TX_EMPTY_MASK) {
> > -        qemu_set_irq(s->tx_empty, 1);
> > -    } else {
> > -        qemu_set_irq(s->tx_empty, 0);
> > -    }
> > -
> > -    if (s->uart_intr_state & s->uart_intr_enable &
> R_INTR_STATE_RX_OVERFLOW_MASK) {
> > -        qemu_set_irq(s->rx_overflow, 1);
> > -    } else {
> > -        qemu_set_irq(s->rx_overflow, 0);
> > -    }
> > -}
> > -
> > -static int ibex_uart_can_receive(void *opaque)
> > -{
> > -    IbexUartState *s =3D opaque;
> > -
> > -    if ((s->uart_ctrl & R_CTRL_RX_ENABLE_MASK)
> > -           && !(s->uart_status & R_STATUS_RXFULL_MASK)) {
> > -        return 1;
> > -    }
> > -
> > -    return 0;
> > -}
> > -
> > -static void ibex_uart_receive(void *opaque, const uint8_t *buf, int
> size)
> > -{
> > -    IbexUartState *s =3D opaque;
> > -    uint8_t rx_fifo_level =3D (s->uart_fifo_ctrl &
> R_FIFO_CTRL_RXILVL_MASK)
> > -                            >> R_FIFO_CTRL_RXILVL_SHIFT;
> > -
> > -    s->uart_rdata =3D *buf;
> > -
> > -    s->uart_status &=3D ~R_STATUS_RXIDLE_MASK;
> > -    s->uart_status &=3D ~R_STATUS_RXEMPTY_MASK;
> > -    /* The RXFULL is set after receiving a single byte
> > -     * as the FIFO buffers are not yet implemented.
> > -     */
> > -    s->uart_status |=3D R_STATUS_RXFULL_MASK;
> > -    s->rx_level +=3D 1;
> > -
> > -    if (size > rx_fifo_level) {
> > -        s->uart_intr_state |=3D R_INTR_STATE_RX_WATERMARK_MASK;
> > -    }
> > -
> > -    ibex_uart_update_irqs(s);
> > -}
> > -
> > -static gboolean ibex_uart_xmit(void *do_not_use, GIOCondition cond,
> > -                               void *opaque)
> > -{
> > -    IbexUartState *s =3D opaque;
> > -    uint8_t tx_fifo_level =3D (s->uart_fifo_ctrl &
> R_FIFO_CTRL_TXILVL_MASK)
> > -                            >> R_FIFO_CTRL_TXILVL_SHIFT;
> > -    int ret;
> > -
> > -    /* instant drain the fifo when there's no back-end */
> > -    if (!qemu_chr_fe_backend_connected(&s->chr)) {
> > -        s->tx_level =3D 0;
> > -        return G_SOURCE_REMOVE;
> > -    }
> > -
> > -    if (!s->tx_level) {
> > -        s->uart_status &=3D ~R_STATUS_TXFULL_MASK;
> > -        s->uart_status |=3D R_STATUS_TXEMPTY_MASK;
> > -        s->uart_intr_state |=3D R_INTR_STATE_TX_EMPTY_MASK;
> > -        s->uart_intr_state &=3D ~R_INTR_STATE_TX_WATERMARK_MASK;
> > -        ibex_uart_update_irqs(s);
> > -        return G_SOURCE_REMOVE;
> > -    }
> > -
> > -    ret =3D qemu_chr_fe_write(&s->chr, s->tx_fifo, s->tx_level);
> > -
> > -    if (ret >=3D 0) {
> > -        s->tx_level -=3D ret;
> > -        memmove(s->tx_fifo, s->tx_fifo + ret, s->tx_level);
> > -    }
> > -
> > -    if (s->tx_level) {
> > -        guint r =3D qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP=
,
> > -                                        ibex_uart_xmit, s);
> > -        if (!r) {
> > -            s->tx_level =3D 0;
> > -            return G_SOURCE_REMOVE;
> > -        }
> > -    }
> > -
> > -    /* Clear the TX Full bit */
> > -    if (s->tx_level !=3D IBEX_UART_TX_FIFO_SIZE) {
> > -        s->uart_status &=3D ~R_STATUS_TXFULL_MASK;
> > -    }
> > -
> > -    /* Disable the TX_WATERMARK IRQ */
> > -    if (s->tx_level < tx_fifo_level) {
> > -        s->uart_intr_state &=3D ~R_INTR_STATE_TX_WATERMARK_MASK;
> > -    }
> > -
> > -    /* Set TX empty */
> > -    if (s->tx_level =3D=3D 0) {
> > -        s->uart_status |=3D R_STATUS_TXEMPTY_MASK;
> > -        s->uart_intr_state |=3D R_INTR_STATE_TX_EMPTY_MASK;
> > -    }
> > -
> > -    ibex_uart_update_irqs(s);
> > -    return G_SOURCE_REMOVE;
> > -}
> > -
> > -static void uart_write_tx_fifo(IbexUartState *s, const uint8_t *buf,
> > -                               int size)
> > -{
> > -    uint64_t current_time =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> > -    uint8_t tx_fifo_level =3D (s->uart_fifo_ctrl &
> R_FIFO_CTRL_TXILVL_MASK)
> > -                            >> R_FIFO_CTRL_TXILVL_SHIFT;
> > -
> > -    if (size > IBEX_UART_TX_FIFO_SIZE - s->tx_level) {
> > -        size =3D IBEX_UART_TX_FIFO_SIZE - s->tx_level;
> > -        qemu_log_mask(LOG_GUEST_ERROR, "ibex_uart: TX FIFO overflow");
> > -    }
> > -
> > -    memcpy(s->tx_fifo + s->tx_level, buf, size);
> > -    s->tx_level +=3D size;
> > -
> > -    if (s->tx_level > 0) {
> > -        s->uart_status &=3D ~R_STATUS_TXEMPTY_MASK;
> > -    }
> > -
> > -    if (s->tx_level >=3D tx_fifo_level) {
> > -        s->uart_intr_state |=3D R_INTR_STATE_TX_WATERMARK_MASK;
> > -        ibex_uart_update_irqs(s);
> > -    }
> > -
> > -    if (s->tx_level =3D=3D IBEX_UART_TX_FIFO_SIZE) {
> > -        s->uart_status |=3D R_STATUS_TXFULL_MASK;
> > -    }
> > -
> > -    timer_mod(s->fifo_trigger_handle, current_time +
> > -              (s->char_tx_time * 4));
> > -}
> > -
> > -static void ibex_uart_reset(DeviceState *dev)
> > -{
> > -    IbexUartState *s =3D IBEX_UART(dev);
> > -
> > -    s->uart_intr_state =3D 0x00000000;
> > -    s->uart_intr_state =3D 0x00000000;
> > -    s->uart_intr_enable =3D 0x00000000;
> > -    s->uart_ctrl =3D 0x00000000;
> > -    s->uart_status =3D 0x0000003c;
> > -    s->uart_rdata =3D 0x00000000;
> > -    s->uart_fifo_ctrl =3D 0x00000000;
> > -    s->uart_fifo_status =3D 0x00000000;
> > -    s->uart_ovrd =3D 0x00000000;
> > -    s->uart_val =3D 0x00000000;
> > -    s->uart_timeout_ctrl =3D 0x00000000;
> > -
> > -    s->tx_level =3D 0;
> > -    s->rx_level =3D 0;
> > -
> > -    s->char_tx_time =3D (NANOSECONDS_PER_SECOND / 230400) * 10;
> > -
> > -    ibex_uart_update_irqs(s);
> > -}
> > -
> > -static uint64_t ibex_uart_get_baud(IbexUartState *s)
> > -{
> > -    uint64_t baud;
> > -
> > -    baud =3D ((s->uart_ctrl & R_CTRL_NCO_MASK) >> 16);
> > -    baud *=3D clock_get_hz(s->f_clk);
> > -    baud >>=3D 20;
> > -
> > -    return baud;
> > -}
> > -
> > -static uint64_t ibex_uart_read(void *opaque, hwaddr addr,
> > -                                       unsigned int size)
> > -{
> > -    IbexUartState *s =3D opaque;
> > -    uint64_t retvalue =3D 0;
> > -
> > -    switch (addr >> 2) {
> > -    case R_INTR_STATE:
> > -        retvalue =3D s->uart_intr_state;
> > -        break;
> > -    case R_INTR_ENABLE:
> > -        retvalue =3D s->uart_intr_enable;
> > -        break;
> > -    case R_INTR_TEST:
> > -        qemu_log_mask(LOG_GUEST_ERROR,
> > -                      "%s: wdata is write only\n", __func__);
> > -        break;
> > -
> > -    case R_CTRL:
> > -        retvalue =3D s->uart_ctrl;
> > -        break;
> > -    case R_STATUS:
> > -        retvalue =3D s->uart_status;
> > -        break;
> > -
> > -    case R_RDATA:
> > -        retvalue =3D s->uart_rdata;
> > -        if ((s->uart_ctrl & R_CTRL_RX_ENABLE_MASK) && (s->rx_level >
> 0)) {
> > -            qemu_chr_fe_accept_input(&s->chr);
> > -
> > -            s->rx_level -=3D 1;
> > -            s->uart_status &=3D ~R_STATUS_RXFULL_MASK;
> > -            if (s->rx_level =3D=3D 0) {
> > -                s->uart_status |=3D R_STATUS_RXIDLE_MASK;
> > -                s->uart_status |=3D R_STATUS_RXEMPTY_MASK;
> > -            }
> > -        }
> > -        break;
> > -    case R_WDATA:
> > -        qemu_log_mask(LOG_GUEST_ERROR,
> > -                      "%s: wdata is write only\n", __func__);
> > -        break;
> > -
> > -    case R_FIFO_CTRL:
> > -        retvalue =3D s->uart_fifo_ctrl;
> > -        break;
> > -    case R_FIFO_STATUS:
> > -        retvalue =3D s->uart_fifo_status;
> > -
> > -        retvalue |=3D (s->rx_level & 0x1F) << R_FIFO_STATUS_RXLVL_SHIF=
T;
> > -        retvalue |=3D (s->tx_level & 0x1F) << R_FIFO_STATUS_TXLVL_SHIF=
T;
> > -
> > -        qemu_log_mask(LOG_UNIMP,
> > -                      "%s: RX fifos are not supported\n", __func__);
> > -        break;
> > -
> > -    case R_OVRD:
> > -        retvalue =3D s->uart_ovrd;
> > -        qemu_log_mask(LOG_UNIMP,
> > -                      "%s: ovrd is not supported\n", __func__);
> > -        break;
> > -    case R_VAL:
> > -        retvalue =3D s->uart_val;
> > -        qemu_log_mask(LOG_UNIMP,
> > -                      "%s: val is not supported\n", __func__);
> > -        break;
> > -    case R_TIMEOUT_CTRL:
> > -        retvalue =3D s->uart_timeout_ctrl;
> > -        qemu_log_mask(LOG_UNIMP,
> > -                      "%s: timeout_ctrl is not supported\n", __func__)=
;
> > -        break;
> > -    default:
> > -        qemu_log_mask(LOG_GUEST_ERROR,
> > -                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__,
> addr);
> > -        return 0;
> > -    }
> > -
> > -    return retvalue;
> > -}
> > -
> > -static void ibex_uart_write(void *opaque, hwaddr addr,
> > -                                  uint64_t val64, unsigned int size)
> > -{
> > -    IbexUartState *s =3D opaque;
> > -    uint32_t value =3D val64;
> > -
> > -    switch (addr >> 2) {
> > -    case R_INTR_STATE:
> > -        /* Write 1 clear */
> > -        s->uart_intr_state &=3D ~value;
> > -        ibex_uart_update_irqs(s);
> > -        break;
> > -    case R_INTR_ENABLE:
> > -        s->uart_intr_enable =3D value;
> > -        ibex_uart_update_irqs(s);
> > -        break;
> > -    case R_INTR_TEST:
> > -        s->uart_intr_state |=3D value;
> > -        ibex_uart_update_irqs(s);
> > -        break;
> > -
> > -    case R_CTRL:
> > -        s->uart_ctrl =3D value;
> > -
> > -        if (value & R_CTRL_NF_MASK) {
> > -            qemu_log_mask(LOG_UNIMP,
> > -                          "%s: UART_CTRL_NF is not supported\n",
> __func__);
> > -        }
> > -        if (value & R_CTRL_SLPBK_MASK) {
> > -            qemu_log_mask(LOG_UNIMP,
> > -                          "%s: UART_CTRL_SLPBK is not supported\n",
> __func__);
> > -        }
> > -        if (value & R_CTRL_LLPBK_MASK) {
> > -            qemu_log_mask(LOG_UNIMP,
> > -                          "%s: UART_CTRL_LLPBK is not supported\n",
> __func__);
> > -        }
> > -        if (value & R_CTRL_PARITY_EN_MASK) {
> > -            qemu_log_mask(LOG_UNIMP,
> > -                          "%s: UART_CTRL_PARITY_EN is not supported\n"=
,
> > -                          __func__);
> > -        }
> > -        if (value & R_CTRL_PARITY_ODD_MASK) {
> > -            qemu_log_mask(LOG_UNIMP,
> > -                          "%s: UART_CTRL_PARITY_ODD is not supported\n=
",
> > -                          __func__);
> > -        }
> > -        if (value & R_CTRL_RXBLVL_MASK) {
> > -            qemu_log_mask(LOG_UNIMP,
> > -                          "%s: UART_CTRL_RXBLVL is not supported\n",
> __func__);
> > -        }
> > -        if (value & R_CTRL_NCO_MASK) {
> > -            uint64_t baud =3D ibex_uart_get_baud(s);
> > -
> > -            s->char_tx_time =3D (NANOSECONDS_PER_SECOND / baud) * 10;
> > -        }
> > -        break;
> > -    case R_STATUS:
> > -        qemu_log_mask(LOG_GUEST_ERROR,
> > -                      "%s: status is read only\n", __func__);
> > -        break;
> > -
> > -    case R_RDATA:
> > -        qemu_log_mask(LOG_GUEST_ERROR,
> > -                      "%s: rdata is read only\n", __func__);
> > -        break;
> > -    case R_WDATA:
> > -        uart_write_tx_fifo(s, (uint8_t *) &value, 1);
> > -        break;
> > -
> > -    case R_FIFO_CTRL:
> > -        s->uart_fifo_ctrl =3D value;
> > -
> > -        if (value & R_FIFO_CTRL_RXRST_MASK) {
> > -            s->rx_level =3D 0;
> > -            qemu_log_mask(LOG_UNIMP,
> > -                          "%s: RX fifos are not supported\n", __func__=
);
> > -        }
> > -        if (value & R_FIFO_CTRL_TXRST_MASK) {
> > -            s->tx_level =3D 0;
> > -        }
> > -        break;
> > -    case R_FIFO_STATUS:
> > -        qemu_log_mask(LOG_GUEST_ERROR,
> > -                      "%s: fifo_status is read only\n", __func__);
> > -        break;
> > -
> > -    case R_OVRD:
> > -        s->uart_ovrd =3D value;
> > -        qemu_log_mask(LOG_UNIMP,
> > -                      "%s: ovrd is not supported\n", __func__);
> > -        break;
> > -    case R_VAL:
> > -        qemu_log_mask(LOG_GUEST_ERROR,
> > -                      "%s: val is read only\n", __func__);
> > -        break;
> > -    case R_TIMEOUT_CTRL:
> > -        s->uart_timeout_ctrl =3D value;
> > -        qemu_log_mask(LOG_UNIMP,
> > -                      "%s: timeout_ctrl is not supported\n", __func__)=
;
> > -        break;
> > -    default:
> > -        qemu_log_mask(LOG_GUEST_ERROR,
> > -                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__,
> addr);
> > -    }
> > -}
> > -
> > -static void ibex_uart_clk_update(void *opaque, ClockEvent event)
> > -{
> > -    IbexUartState *s =3D opaque;
> > -
> > -    /* recompute uart's speed on clock change */
> > -    uint64_t baud =3D ibex_uart_get_baud(s);
> > -
> > -    s->char_tx_time =3D (NANOSECONDS_PER_SECOND / baud) * 10;
> > -}
> > -
> > -static void fifo_trigger_update(void *opaque)
> > -{
> > -    IbexUartState *s =3D opaque;
> > -
> > -    if (s->uart_ctrl & R_CTRL_TX_ENABLE_MASK) {
> > -        ibex_uart_xmit(NULL, G_IO_OUT, s);
> > -    }
> > -}
> > -
> > -static const MemoryRegionOps ibex_uart_ops =3D {
> > -    .read =3D ibex_uart_read,
> > -    .write =3D ibex_uart_write,
> > -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > -    .impl.min_access_size =3D 4,
> > -    .impl.max_access_size =3D 4,
> > -};
> > -
> > -static int ibex_uart_post_load(void *opaque, int version_id)
> > -{
> > -    IbexUartState *s =3D opaque;
> > -
> > -    ibex_uart_update_irqs(s);
> > -    return 0;
> > -}
> > -
> > -static const VMStateDescription vmstate_ibex_uart =3D {
> > -    .name =3D TYPE_IBEX_UART,
> > -    .version_id =3D 1,
> > -    .minimum_version_id =3D 1,
> > -    .post_load =3D ibex_uart_post_load,
> > -    .fields =3D (const VMStateField[]) {
> > -        VMSTATE_UINT8_ARRAY(tx_fifo, IbexUartState,
> > -                            IBEX_UART_TX_FIFO_SIZE),
> > -        VMSTATE_UINT32(tx_level, IbexUartState),
> > -        VMSTATE_UINT64(char_tx_time, IbexUartState),
> > -        VMSTATE_TIMER_PTR(fifo_trigger_handle, IbexUartState),
> > -        VMSTATE_UINT32(uart_intr_state, IbexUartState),
> > -        VMSTATE_UINT32(uart_intr_enable, IbexUartState),
> > -        VMSTATE_UINT32(uart_ctrl, IbexUartState),
> > -        VMSTATE_UINT32(uart_status, IbexUartState),
> > -        VMSTATE_UINT32(uart_rdata, IbexUartState),
> > -        VMSTATE_UINT32(uart_fifo_ctrl, IbexUartState),
> > -        VMSTATE_UINT32(uart_fifo_status, IbexUartState),
> > -        VMSTATE_UINT32(uart_ovrd, IbexUartState),
> > -        VMSTATE_UINT32(uart_val, IbexUartState),
> > -        VMSTATE_UINT32(uart_timeout_ctrl, IbexUartState),
> > -        VMSTATE_END_OF_LIST()
> > -    }
> > -};
> > -
> > -static const Property ibex_uart_properties[] =3D {
> > -    DEFINE_PROP_CHR("chardev", IbexUartState, chr),
> > -};
> > -
> > -static void ibex_uart_init(Object *obj)
> > -{
> > -    IbexUartState *s =3D IBEX_UART(obj);
> > -
> > -    s->f_clk =3D qdev_init_clock_in(DEVICE(obj), "f_clock",
> > -                                  ibex_uart_clk_update, s, ClockUpdate=
);
> > -    clock_set_hz(s->f_clk, IBEX_UART_CLOCK);
> > -
> > -    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->tx_watermark);
> > -    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->rx_watermark);
> > -    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->tx_empty);
> > -    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->rx_overflow);
> > -
> > -    memory_region_init_io(&s->mmio, obj, &ibex_uart_ops, s,
> > -                          TYPE_IBEX_UART, 0x400);
> > -    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> > -}
> > -
> > -static void ibex_uart_realize(DeviceState *dev, Error **errp)
> > -{
> > -    IbexUartState *s =3D IBEX_UART(dev);
> > -
> > -    s->fifo_trigger_handle =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> > -                                          fifo_trigger_update, s);
> > -
> > -    qemu_chr_fe_set_handlers(&s->chr, ibex_uart_can_receive,
> > -                             ibex_uart_receive, NULL, NULL,
> > -                             s, NULL, true);
> > -}
> > -
> > -static void ibex_uart_class_init(ObjectClass *klass, const void *data)
> > -{
> > -    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > -
> > -    device_class_set_legacy_reset(dc, ibex_uart_reset);
> > -    dc->realize =3D ibex_uart_realize;
> > -    dc->vmsd =3D &vmstate_ibex_uart;
> > -    device_class_set_props(dc, ibex_uart_properties);
> > -    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> > -}
> > -
> > -static const TypeInfo ibex_uart_info =3D {
> > -    .name          =3D TYPE_IBEX_UART,
> > -    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > -    .instance_size =3D sizeof(IbexUartState),
> > -    .instance_init =3D ibex_uart_init,
> > -    .class_init    =3D ibex_uart_class_init,
> > -};
> > -
> > -static void ibex_uart_register_types(void)
> > -{
> > -    type_register_static(&ibex_uart_info);
> > -}
> > -
> > -type_init(ibex_uart_register_types)
> > diff --git a/hw/char/meson.build b/hw/char/meson.build
> > index fc3d7ee506..989ca3d7e0 100644
> > --- a/hw/char/meson.build
> > +++ b/hw/char/meson.build
> > @@ -2,7 +2,7 @@ system_ss.add(when: 'CONFIG_CADENCE', if_true:
> files('cadence_uart.c'))
> >  system_ss.add(when: 'CONFIG_CMSDK_APB_UART', if_true:
> files('cmsdk-apb-uart.c'))
> >  system_ss.add(when: 'CONFIG_ESCC', if_true: files('escc.c'))
> >  system_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_apbuart.c'))
> > -system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_uart.c'))
> > +system_ss.add(when: 'CONFIG_IBEX', if_true: files('ot_uart.c'))
> >  system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_serial.c'))
> >  system_ss.add(when: 'CONFIG_IP_OCTAL_232', if_true:
> files('ipoctal232.c'))
> >  system_ss.add(when: 'CONFIG_ISA_BUS', if_true: files('parallel-isa.c')=
)
> > diff --git a/hw/char/ot_uart.c b/hw/char/ot_uart.c
> > new file mode 100644
> > index 0000000000..757f64ab70
> > --- /dev/null
> > +++ b/hw/char/ot_uart.c
> > @@ -0,0 +1,635 @@
> > +/*
> > + * QEMU OpenTitan UART device
> > + *
> > + * Copyright (c) 2022-2025 Rivos, Inc.
> > + * Copyright (c) 2025 lowRISC contributors.
> > + *
> > + * Author(s):
> > + *  Lo=C3=AFc Lefort <loic@rivosinc.com>
> > + *
> > + * SPDX-License-Identifier: MIT
> > + *
> > + * Based on original ibex_uart implementation:
> > + *  Copyright (c) 2020 Western Digital
> > + *  Alistair Francis <alistair.francis@wdc.com>
> > + *
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/fifo8.h"
> > +#include "qemu/log.h"
> > +#include "qemu/module.h"
> > +#include "qapi/error.h"
> > +#include "chardev/char-fe.h"
> > +#include "hw/core/cpu.h"
> > +#include "hw/core/irq.h"
> > +#include "hw/char/ot_uart.h"
> > +#include "hw/core/qdev-properties-system.h"
> > +#include "hw/core/qdev-properties.h"
> > +#include "hw/core/registerfields.h"
> > +#include "trace.h"
> > +
> > +#define REG_NAME_ENTRY(_reg_) [R_##_reg_] =3D stringify(_reg_)
> >
> > Let's use the existing QEMU macros instead of creating custom ones.
> >
> > Specifically which macro should I be using instead? I can't find any
> that do the same as this one. It is used to populate the array of registe=
r
> names just below, which are used in log/trace messages
>
> Ah sorry. I originally thought this was instead of the REG32 macros,
> hence the comment. Then forgot to come back and delete the comment
> before sending.
>
> >
> > +static const char *REG_NAMES[REGS_COUNT] =3D {
> > +    /* clang-format off */
> > +    REG_NAME_ENTRY(INTR_STATE),
> > +    REG_NAME_ENTRY(INTR_ENABLE),
> > +    REG_NAME_ENTRY(INTR_TEST),
> > +    REG_NAME_ENTRY(ALERT_TEST),
> > +    REG_NAME_ENTRY(CTRL),
> > +    REG_NAME_ENTRY(STATUS),
> > +    REG_NAME_ENTRY(RDATA),
> > +    REG_NAME_ENTRY(WDATA),
> > +    REG_NAME_ENTRY(FIFO_CTRL),
> > +    REG_NAME_ENTRY(FIFO_STATUS),
> > +    REG_NAME_ENTRY(OVRD),
> > +    REG_NAME_ENTRY(VAL),
> > +    REG_NAME_ENTRY(TIMEOUT_CTRL),
> > +    /* clang-format on */
> > +};
> > +#undef REG_NAME_ENTRY
> > +
> > +static uint32_t ot_uart_get_tx_watermark_level(const OtUARTState *s)
> > +{
> > +    uint32_t tx_ilvl =3D (s->regs[R_FIFO_CTRL] & R_FIFO_CTRL_TXILVL_MA=
SK)
> >>
> > +                       R_FIFO_CTRL_TXILVL_SHIFT;
> >
> > You can then use the extract (FIELD_EX32) macros instead of mask and
> shift.
> >
> > +
> > +    return tx_ilvl < 7u ? (1u << tx_ilvl) : 64u;
> >
> > You shouldn't need the `u`s
> >
> > +}
> > +
> > +static uint32_t ot_uart_get_rx_watermark_level(const OtUARTState *s)
> > +{
> > +    uint32_t rx_ilvl =3D (s->regs[R_FIFO_CTRL] & R_FIFO_CTRL_RXILVL_MA=
SK)
> >>
> > +                       R_FIFO_CTRL_RXILVL_SHIFT;
> > +
> > +    return rx_ilvl < 7u ? (1u << rx_ilvl) : 126u;
> > +}
> > +
> > +static void ot_uart_update_irqs(OtUARTState *s)
> > +{
> > +    uint32_t state_masked =3D s->regs[R_INTR_STATE] &
> s->regs[R_INTR_ENABLE];
> > +
> > +    trace_ot_uart_irqs(s->ot_id, s->regs[R_INTR_STATE],
> s->regs[R_INTR_ENABLE],
> > +                       state_masked);
> > +
> > +    for (int index =3D 0; index < OT_UART_IRQ_NUM; index++) {
> > +        bool level =3D (state_masked & (1U << index)) !=3D 0;
> > +        qemu_set_irq(s->irqs[index], level);
> > +    }
> > +}
> > +
> > +static bool ot_uart_is_sys_loopack_enabled(const OtUARTState *s)
> > +{
> > +    return (bool)FIELD_EX32(s->regs[R_CTRL], CTRL, SLPBK);
> >
> > You also should need to cast this
> >
> > +}
> > +
> > +static bool ot_uart_is_tx_enabled(const OtUARTState *s)
> > +{
> > +    return (bool)FIELD_EX32(s->regs[R_CTRL], CTRL, TX);
> > +}
> > +
> > +static bool ot_uart_is_rx_enabled(const OtUARTState *s)
> > +{
> > +    return (bool)FIELD_EX32(s->regs[R_CTRL], CTRL, RX);
> > +}
> > +
> > +static void ot_uart_check_baudrate(const OtUARTState *s)
> > +{
> > +    uint32_t nco =3D FIELD_EX32(s->regs[R_CTRL], CTRL, NCO);
> > +
> > +    unsigned baudrate =3D (unsigned)(((uint64_t)nco * (uint64_t)s->pcl=
k)
> >>
> > +                                   (R_CTRL_NCO_LENGTH + 4));
> > +
> > +    if (baudrate) {
> > +        trace_ot_uart_check_baudrate(s->ot_id, s->pclk, baudrate);
> > +    }
> > +}
> > +
> > +static void ot_uart_reset_rx_fifo(OtUARTState *s)
> > +{
> > +    fifo8_reset(&s->rx_fifo);
> > +    s->regs[R_INTR_STATE] &=3D ~INTR_RX_WATERMARK_MASK;
> > +    s->regs[R_INTR_STATE] &=3D ~INTR_RX_OVERFLOW_MASK;
> > +    if (ot_uart_is_rx_enabled(s) && !ot_uart_is_sys_loopack_enabled(s)=
)
> {
> > +        qemu_chr_fe_accept_input(&s->chr);
> > +    }
> > +}
> > +
> > +static int ot_uart_can_receive(void *opaque)
> > +{
> > +    OtUARTState *s =3D opaque;
> > +
> > +    if (s->regs[R_CTRL] & R_CTRL_RX_MASK) {
> > +        return (int)fifo8_num_free(&s->rx_fifo);
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static void ot_uart_receive(void *opaque, const uint8_t *buf, int size=
)
> > +{
> > +    OtUARTState *s =3D opaque;
> > +    uint32_t rx_watermark_level;
> > +    size_t count =3D MIN(fifo8_num_free(&s->rx_fifo), (size_t)size);
> > +
> > +    if (size && !s->toggle_break) {
> > +        /* no longer breaking, so emulate idle in oversampled VAL
> register */
> > +        s->in_break =3D false;
> > +    }
> > +
> > +    for (int index =3D 0; index < size; index++) {
> > +        fifo8_push(&s->rx_fifo, buf[index]);
> > +    }
> > +
> > +    /* update INTR_STATE */
> > +    if (count !=3D size) {
> > +        s->regs[R_INTR_STATE] |=3D INTR_RX_OVERFLOW_MASK;
> > +    }
> > +    rx_watermark_level =3D ot_uart_get_rx_watermark_level(s);
> > +    if (rx_watermark_level && size >=3D rx_watermark_level) {
> > +        s->regs[R_INTR_STATE] |=3D INTR_RX_WATERMARK_MASK;
> > +    }
> > +
> > +    ot_uart_update_irqs(s);
> > +}
> > +
> > +static void ot_uart_event_handler(void *opaque, QEMUChrEvent event)
> > +{
> > +    OtUARTState *s =3D opaque;
> > +
> > +    if (event =3D=3D CHR_EVENT_BREAK) {
> > +        if (!s->in_break || !s->oversample_break) {
> > +            /* ignore CTRL.RXBLVL as we have no notion of break "time"
> */
> > +            s->regs[R_INTR_STATE] |=3D INTR_RX_BREAK_ERR_MASK;
> > +            ot_uart_update_irqs(s);
> > +            /* emulate break in the oversampled VAL register */
> > +            s->in_break =3D true;
> > +        } else if (s->toggle_break) {
> > +            /* emulate toggling break off in the oversampled VAL
> register */
> > +            s->in_break =3D false;
> > +        }
> > +    }
> > +}
> > +
> > +static uint8_t ot_uart_read_rx_fifo(OtUARTState *s)
> > +{
> > +    uint8_t val;
> > +
> > +    if (!(s->regs[R_CTRL] & R_CTRL_RX_MASK)) {
> > +        return 0;
> > +    }
> > +
> > +    if (fifo8_is_empty(&s->rx_fifo)) {
> > +        return 0;
> > +    }
> > +
> > +    val =3D fifo8_pop(&s->rx_fifo);
> > +
> > +    if (ot_uart_is_rx_enabled(s) && !ot_uart_is_sys_loopack_enabled(s)=
)
> {
> > +        qemu_chr_fe_accept_input(&s->chr);
> > +    }
> > +
> > +    return val;
> > +}
> > +
> > +static void ot_uart_reset_tx_fifo(OtUARTState *s)
> > +{
> > +    fifo8_reset(&s->tx_fifo);
> > +    s->regs[R_INTR_STATE] |=3D INTR_TX_EMPTY_MASK;
> > +    s->regs[R_INTR_STATE] |=3D INTR_TX_DONE_MASK;
> > +    if (s->tx_watermark_level) {
> > +        s->regs[R_INTR_STATE] |=3D INTR_TX_WATERMARK_MASK;
> > +        s->tx_watermark_level =3D 0;
> > +    }
> > +}
> > +
> > +static void ot_uart_xmit(OtUARTState *s)
> > +{
> > +    const uint8_t *buf;
> > +    uint32_t size;
> > +    int ret;
> > +
> > +    if (fifo8_is_empty(&s->tx_fifo)) {
> > +        return;
> > +    }
> > +
> > +    if (ot_uart_is_sys_loopack_enabled(s)) {
> > +        /* system loopback mode, just forward to RX FIFO */
> > +        uint32_t count =3D fifo8_num_used(&s->tx_fifo);
> > +        buf =3D fifo8_pop_bufptr(&s->tx_fifo, count, &size);
> > +        ot_uart_receive(s, buf, (int)size);
> > +        count -=3D size;
> > +        /*
> > +         * there may be more data to send if data wraps around the end
> of TX
> > +         * FIFO
> > +         */
> > +        if (count) {
> > +            buf =3D fifo8_pop_bufptr(&s->tx_fifo, count, &size);
> > +            ot_uart_receive(s, buf, (int)size);
> > +        }
> > +    } else {
> > +        /* instant drain the fifo when there's no back-end */
> > +        if (!qemu_chr_fe_backend_connected(&s->chr)) {
> > +            ot_uart_reset_tx_fifo(s);
> > +            ot_uart_update_irqs(s);
> > +            return;
> > +        }
> > +
> > +        /* get a continuous buffer from the FIFO */
> > +        buf =3D
> > +            fifo8_peek_bufptr(&s->tx_fifo, fifo8_num_used(&s->tx_fifo)=
,
> &size);
> > +        /* send as much as possible */
> > +        ret =3D qemu_chr_fe_write(&s->chr, buf, (int)size);
> > +        /* if some characters where sent, remove them from the FIFO */
> > +        if (ret >=3D 0) {
> > +            fifo8_drop(&s->tx_fifo, ret);
> > +        }
> > +    }
> > +
> > +    /* update INTR_STATE */
> > +    if (fifo8_is_empty(&s->tx_fifo)) {
> > +        s->regs[R_INTR_STATE] |=3D INTR_TX_EMPTY_MASK;
> > +        s->regs[R_INTR_STATE] |=3D INTR_TX_DONE_MASK;
> > +    }
> > +    if (s->tx_watermark_level &&
> > +        fifo8_num_used(&s->tx_fifo) < s->tx_watermark_level) {
> > +        s->regs[R_INTR_STATE] |=3D INTR_TX_WATERMARK_MASK;
> > +        s->tx_watermark_level =3D 0;
> > +    }
> > +
> > +    ot_uart_update_irqs(s);
> > +}
> > +
> > +static gboolean ot_uart_watch_cb(void *do_not_use, GIOCondition cond,
> > +                                 void *opaque)
> > +{
> > +    OtUARTState *s =3D opaque;
> > +    (void)do_not_use;
> > +    (void)cond;
> > +
> > +    s->watch_tag =3D 0;
> > +    ot_uart_xmit(s);
> > +
> > +    return FALSE;
> > +}
> > +
> > +static void uart_write_tx_fifo(OtUARTState *s, uint8_t val)
> > +{
> > +    if (fifo8_is_full(&s->tx_fifo)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "ot_uart: TX FIFO overflow");
> > +        return;
> > +    }
> > +
> > +    fifo8_push(&s->tx_fifo, val);
> > +
> > +    s->tx_watermark_level =3D ot_uart_get_tx_watermark_level(s);
> > +    if (fifo8_num_used(&s->tx_fifo) < s->tx_watermark_level) {
> > +        /*
> > +         * TX watermark interrupt is raised when FIFO depth goes from
> above
> > +         * watermark to below. If we haven't reached watermark, reset
> cached
> > +         * watermark level
> > +         */
> > +        s->tx_watermark_level =3D 0;
> > +    }
> > +
> > +    if (ot_uart_is_tx_enabled(s)) {
> > +        ot_uart_xmit(s);
> > +    }
> > +}
> > +
> > +static void ot_uart_clock_input(void *opaque, int irq, int level)
> > +{
> > +    OtUARTState *s =3D opaque;
> > +
> > +    g_assert(irq =3D=3D 0);
> > +
> > +    s->pclk =3D (unsigned)level;
> > +
> > +    /* TODO: disable UART transfer when PCLK is 0 */
> > +    ot_uart_check_baudrate(s);
> > +}
> > +
> > +static uint64_t ot_uart_read(void *opaque, hwaddr addr, unsigned size)
> > +{
> > +    OtUARTState *s =3D opaque;
> > +    (void)size;
> >
> > Not sure this is required
> >
> > +    uint32_t val32;
> > +
> > +    hwaddr reg =3D R32_OFF(addr);
> > +    switch (reg) {
> > +    case R_INTR_STATE:
> > +    case R_INTR_ENABLE:
> > +    case R_CTRL:
> > +    case R_FIFO_CTRL:
> > +        val32 =3D s->regs[reg];
> > +        break;
> > +    case R_STATUS:
> > +        /* assume that UART always report RXIDLE */
> > +        val32 =3D R_STATUS_RXIDLE_MASK;
> > +        /* report RXEMPTY or RXFULL */
> > +        switch (fifo8_num_used(&s->rx_fifo)) {
> > +        case 0:
> > +            val32 |=3D R_STATUS_RXEMPTY_MASK;
> > +            break;
> > +        case OT_UART_RX_FIFO_SIZE:
> > +            val32 |=3D R_STATUS_RXFULL_MASK;
> > +            break;
> > +        default:
> > +            break;
> > +        }
> > +        /* report TXEMPTY+TXIDLE or TXFULL */
> > +        switch (fifo8_num_used(&s->tx_fifo)) {
> > +        case 0:
> > +            val32 |=3D R_STATUS_TXEMPTY_MASK | R_STATUS_TXIDLE_MASK;
> > +            break;
> > +        case OT_UART_TX_FIFO_SIZE:
> > +            val32 |=3D R_STATUS_TXFULL_MASK;
> > +            break;
> > +        default:
> > +            break;
> > +        }
> > +        if (!ot_uart_is_tx_enabled(s)) {
> > +            val32 |=3D R_STATUS_TXIDLE_MASK;
> > +        }
> > +        if (!ot_uart_is_rx_enabled(s)) {
> > +            val32 |=3D R_STATUS_RXIDLE_MASK;
> > +        }
> > +        break;
> > +    case R_RDATA:
> > +        val32 =3D (uint32_t)ot_uart_read_rx_fifo(s);
> > +        break;
> > +    case R_FIFO_STATUS:
> > +        val32 =3D
> > +            (fifo8_num_used(&s->rx_fifo) & 0xffu) <<
> R_FIFO_STATUS_RXLVL_SHIFT;
> > +        val32 |=3D
> > +            (fifo8_num_used(&s->tx_fifo) & 0xffu) <<
> R_FIFO_STATUS_TXLVL_SHIFT;
> > +        break;
> > +    case R_VAL:
> > +        /*
> > +         * This is not trivially implemented due to the QEMU UART
> > +         * interface. There is no way to reliably sample or oversample
> > +         * given our emulated interface, but some software might poll
> the
> > +         * value of this register to determine break conditions.
> > +         *
> > +         * As such, default to reporting 16 of the last sample receive=
d
> > +         * instead. This defaults to 16 idle high samples (as a stop
> bit is
> > +         * always the last received), except for when the
> `oversample-break`
> > +         * property is set and a break condition is received over UART
> RX,
> > +         * where we then show 16 low samples until the next valid UART
> > +         * transmission is received (or break is toggled off with the
> > +         * `toggle-break` property enabled). This will not be accurate=
,
> but
> > +         * should be sufficient to support basic software flows that
> > +         * essentially use UART break as a strapping mechanism.
> > +         */
> > +        val32 =3D (s->in_break && s->oversample_break) ? 0u : UINT16_M=
AX;
> > +        qemu_log_mask(LOG_UNIMP, "%s: VAL only shows idle%s\n",
> __func__,
> > +                      (s->oversample_break ? "/break" : ""));
> > +        break;
> > +    case R_OVRD:
> > +    case R_TIMEOUT_CTRL:
> > +        val32 =3D s->regs[reg];
> > +        qemu_log_mask(LOG_UNIMP, "%s: %s is not supported\n", __func__=
,
> > +                      REG_NAME(reg));
> > +        break;
> > +    case R_ALERT_TEST:
> > +    case R_INTR_TEST:
> > +    case R_WDATA:
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: W/O register 0x%02x (%s)\n=
",
> > +                      __func__, (uint32_t)addr, REG_NAME(reg));
> > +        val32 =3D 0;
> > +        break;
> > +    default:
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%02x\n",
> __func__,
> > +                      (uint32_t)addr);
> > +        val32 =3D 0;
> > +        break;
> > +    }
> > +
> > +    uint32_t pc =3D current_cpu->cc->get_pc(current_cpu);
> > +    trace_ot_uart_io_read_out(s->ot_id, (uint32_t)addr, REG_NAME(reg),
> val32,
> > +                              pc);
> > +
> > +    return (uint64_t)val32;
> > +}
> > +
> > +static void ot_uart_write(void *opaque, hwaddr addr, uint64_t val64,
> > +                          unsigned size)
> > +{
> > +    OtUARTState *s =3D opaque;
> > +    (void)size;
> > +    uint32_t val32 =3D val64;
> > +
> > +    hwaddr reg =3D R32_OFF(addr);
> > +
> > +    uint32_t pc =3D current_cpu->cc->get_pc(current_cpu);
> > +    trace_ot_uart_io_write(s->ot_id, (uint32_t)addr, REG_NAME(reg),
> val32, pc);
> > +
> > +    switch (reg) {
> > +    case R_INTR_STATE:
> > +        val32 &=3D INTR_MASK;
> > +        s->regs[R_INTR_STATE] &=3D ~val32; /* RW1C */
> > +        ot_uart_update_irqs(s);
> > +        break;
> > +    case R_INTR_ENABLE:
> > +        val32 &=3D INTR_MASK;
> > +        s->regs[R_INTR_ENABLE] =3D val32;
> > +        ot_uart_update_irqs(s);
> > +        break;
> > +    case R_INTR_TEST:
> > +        val32 &=3D INTR_MASK;
> > +        s->regs[R_INTR_STATE] |=3D val32;
> > +        ot_uart_update_irqs(s);
> > +        break;
> > +    case R_ALERT_TEST:
> > +        val32 &=3D R_ALERT_TEST_FATAL_FAULT_MASK;
> > +        s->regs[reg] =3D val32;
> > +        /* This will also set an IRQ once the alert handler is added *=
/
> > +        break;
> > +    case R_CTRL:
> > +        if (val32 & ~CTRL_SUP_MASK) {
> > +            qemu_log_mask(LOG_UNIMP,
> > +                          "%s: UART_CTRL feature not supported:
> 0x%08x\n",
> > +                          __func__, val32 & ~CTRL_SUP_MASK);
> > +        }
> > +        uint32_t prev =3D s->regs[R_CTRL];
> > +        s->regs[R_CTRL] =3D val32 & CTRL_MASK;
> > +        uint32_t change =3D prev ^ s->regs[R_CTRL];
> > +        if (change & R_CTRL_NCO_MASK) {
> > +            ot_uart_check_baudrate(s);
> > +        }
> > +        if ((change & R_CTRL_RX_MASK) && ot_uart_is_rx_enabled(s) &&
> > +            !ot_uart_is_sys_loopack_enabled(s)) {
> > +            qemu_chr_fe_accept_input(&s->chr);
> > +        }
> > +        if ((change & R_CTRL_TX_MASK) && ot_uart_is_tx_enabled(s)) {
> > +            /* try sending pending data from TX FIFO if any */
> > +            ot_uart_xmit(s);
> > +        }
> > +        break;
> > +    case R_WDATA:
> > +        uart_write_tx_fifo(s, (uint8_t)(val32 & R_WDATA_WDATA_MASK));
> > +        break;
> > +    case R_FIFO_CTRL:
> > +        s->regs[R_FIFO_CTRL] =3D
> > +            val32 & (R_FIFO_CTRL_RXILVL_MASK | R_FIFO_CTRL_TXILVL_MASK=
);
> > +        if (val32 & R_FIFO_CTRL_RXRST_MASK) {
> > +            ot_uart_reset_rx_fifo(s);
> > +            ot_uart_update_irqs(s);
> > +        }
> > +        if (val32 & R_FIFO_CTRL_TXRST_MASK) {
> > +            ot_uart_reset_tx_fifo(s);
> > +            ot_uart_update_irqs(s);
> > +        }
> > +        break;
> > +    case R_OVRD:
> > +        if (val32 & R_OVRD_TXEN_MASK) {
> > +            qemu_log_mask(LOG_UNIMP, "%s: OVRD.TXEN is not supported\n=
",
> > +                          __func__);
> > +        }
> > +        s->regs[R_OVRD] =3D val32 & R_OVRD_TXVAL_MASK;
> > +        break;
> > +    case R_TIMEOUT_CTRL:
> > +        s->regs[R_TIMEOUT_CTRL] =3D
> > +            val32 & (R_TIMEOUT_CTRL_EN_MASK | R_TIMEOUT_CTRL_VAL_MASK)=
;
> > +        break;
> > +    case R_STATUS:
> > +    case R_RDATA:
> > +    case R_FIFO_STATUS:
> > +    case R_VAL:
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: R/O register 0x%02x (%s)\n=
",
> > +                      __func__, (uint32_t)addr, REG_NAME(reg));
> > +        break;
> > +    default:
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%02x\n",
> __func__,
> > +                      (uint32_t)addr);
> > +        break;
> > +    }
> > +}
> > +
> > +static const MemoryRegionOps ot_uart_ops =3D {
> > +    .read =3D ot_uart_read,
> > +    .write =3D ot_uart_write,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .impl.min_access_size =3D 4,
> > +    .impl.max_access_size =3D 4,
> > +};
> > +
> > +static const Property ot_uart_properties[] =3D {
> > +    DEFINE_PROP_STRING("ot-id", OtUARTState, ot_id),
> > +    DEFINE_PROP_CHR("chardev", OtUARTState, chr),
> > +    DEFINE_PROP_BOOL("oversample-break", OtUARTState, oversample_break=
,
> false),
> > +    DEFINE_PROP_BOOL("toggle-break", OtUARTState, toggle_break, false)=
,
> > +};
> > +
> > +static int ot_uart_be_change(void *opaque)
> > +{
> > +    OtUARTState *s =3D opaque;
> > +
> > +    qemu_chr_fe_set_handlers(&s->chr, ot_uart_can_receive,
> ot_uart_receive,
> > +                             ot_uart_event_handler, ot_uart_be_change,
> s, NULL,
> > +                             true);
> > +
> > +    if (s->watch_tag > 0) {
> > +        g_source_remove(s->watch_tag);
> > +        /* NOLINTNEXTLINE(clang-analyzer-optin.core.EnumCastOutOfRange=
)
> */
> > +        s->watch_tag =3D qemu_chr_fe_add_watch(&s->chr, G_IO_OUT |
> G_IO_HUP,
> > +                                             ot_uart_watch_cb, s);
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static void ot_uart_reset_enter(Object *obj, ResetType type)
> > +{
> > +    OtUARTClass *c =3D OT_UART_GET_CLASS(obj);
> > +    OtUARTState *s =3D OT_UART(obj);
> > +
> > +    if (c->parent_phases.enter) {
> > +        c->parent_phases.enter(obj, type);
> > +    }
> > +
> > +    memset(&s->regs[0], 0, sizeof(s->regs));
> > +
> > +    s->tx_watermark_level =3D 0;
> > +    for (unsigned index =3D 0; index < ARRAY_SIZE(s->irqs); index++) {
> > +        qemu_set_irq(s->irqs[index], 0);
> > +    }
> > +    ot_uart_reset_tx_fifo(s);
> > +    ot_uart_reset_rx_fifo(s);
> > +
> > +    /*
> > +     * do not reset `s->in_break`, as that tracks whether we are
> currently
> > +     * receiving a break condition over UART RX from some device talki=
ng
> > +     * to OpenTitan, which should survive resets. The QEMU CharDev onl=
y
> > +     * supports transient break events and not the notion of holding t=
he
> > +     * UART in break, so remembering breaks like this is required to
> > +     * support mocking of break conditions in the oversampled `VAL` re=
g.
> > +     */
> > +    if (s->in_break) {
> > +        /* ignore CTRL.RXBLVL as we have no notion of break "time" */
> > +        s->regs[R_INTR_STATE] |=3D INTR_RX_BREAK_ERR_MASK;
> > +    }
> > +
> > +    ot_uart_update_irqs(s);
> > +}
> > +
> > +static void ot_uart_realize(DeviceState *dev, Error **errp)
> > +{
> > +    OtUARTState *s =3D OT_UART(dev);
> > +    (void)errp;
> > +
> > +    g_assert(s->ot_id);
> > +
> > +    qdev_init_gpio_in_named(DEVICE(s), &ot_uart_clock_input,
> "clock-in", 1);
> > +
> > +    fifo8_create(&s->tx_fifo, OT_UART_TX_FIFO_SIZE);
> > +    fifo8_create(&s->rx_fifo, OT_UART_RX_FIFO_SIZE);
> > +
> > +    qemu_chr_fe_set_handlers(&s->chr, ot_uart_can_receive,
> ot_uart_receive,
> > +                             ot_uart_event_handler, ot_uart_be_change,
> s, NULL,
> > +                             true);
> > +}
> > +
> > +static void ot_uart_init(Object *obj)
> > +{
> > +    OtUARTState *s =3D OT_UART(obj);
> > +
> > +    for (unsigned index =3D 0; index < OT_UART_IRQ_NUM; index++) {
> > +        sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irqs[index]);
> > +    }
> > +
> > +    memory_region_init_io(&s->mmio, obj, &ot_uart_ops, s, TYPE_OT_UART=
,
> > +                          REGS_SIZE);
> > +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> > +}
> > +
> > +static void ot_uart_class_init(ObjectClass *klass, const void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    (void)data;
> > +
> > +    dc->realize =3D ot_uart_realize;
> > +    device_class_set_props(dc, ot_uart_properties);
> > +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> > +
> > +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> > +    OtUARTClass *uc =3D OT_UART_CLASS(klass);
> > +    resettable_class_set_parent_phases(rc, &ot_uart_reset_enter, NULL,
> NULL,
> > +                                       &uc->parent_phases);
> > +}
> > +
> > +static const TypeInfo ot_uart_info =3D {
> > +    .name =3D TYPE_OT_UART,
> > +    .parent =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_size =3D sizeof(OtUARTState),
> > +    .instance_init =3D ot_uart_init,
> > +    .class_size =3D sizeof(OtUARTClass),
> > +    .class_init =3D ot_uart_class_init,
> > +};
> > +
> > +static void ot_uart_register_types(void)
> > +{
> > +    type_register_static(&ot_uart_info);
> > +}
> > +
> > +type_init(ot_uart_register_types);
> > diff --git a/hw/char/trace-events b/hw/char/trace-events
> > index a3fcc77287..c859d8af4e 100644
> > --- a/hw/char/trace-events
> > +++ b/hw/char/trace-events
> > @@ -141,3 +141,11 @@ stm32f2xx_usart_receive(char *id, uint8_t chr) " %=
s
> receiving '%c'"
> >  # riscv_htif.c
> >  htif_uart_write_to_host(uint8_t device, uint8_t cmd, uint64_t payload)
> "device: %u cmd: %02u payload: %016" PRIx64
> >  htif_uart_unknown_device_command(uint8_t device, uint8_t cmd, uint64_t
> payload) "device: %u cmd: %02u payload: %016" PRIx64
> > +
> > +# ot_uart.c
> > +ot_uart_check_baudrate(const char *id, unsigned pclk, unsigned baud)
> "%s: @ %u Hz: %u bps"
> > +ot_uart_connect_input_clock(const char *id, const char * srcname) "%s:
> %s"
> > +ot_uart_debug(const char *id, const char *msg) "%s: %s"
> > +ot_uart_io_read_out(const char *id, uint32_t addr, const char *regname=
,
> uint32_t val, uint32_t pc) "%s: addr=3D0x%02x (%s), val=3D0x%x, pc=3D0x%x=
"
> > +ot_uart_io_write(const char *id, uint32_t addr, const char *regname,
> uint32_t val, uint32_t pc) "%s: addr=3D0x%02x (%s), val=3D0x%x, pc=3D0x%x=
"
> > +ot_uart_irqs(const char *id, uint32_t active, uint32_t mask, uint32_t
> eff) "%s: act:0x%08x msk:0x%08x eff:0x%08x"
> > diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
> > index 309125e854..163d3ac3d3 100644
> > --- a/hw/riscv/opentitan.c
> > +++ b/hw/riscv/opentitan.c
> > @@ -132,7 +132,8 @@ static void lowrisc_ibex_soc_init(Object *obj)
> >
> >      object_initialize_child(obj, "plic", &s->plic, TYPE_SIFIVE_PLIC);
> >
> > -    object_initialize_child(obj, "uart", &s->uart, TYPE_IBEX_UART);
> > +    object_initialize_child(obj, "uart", &s->uart, TYPE_OT_UART);
> > +    object_property_set_str(OBJECT(&s->uart), "ot-id", "uart0",
> &error_fatal);
> >
> >      object_initialize_child(obj, "timer", &s->timer, TYPE_IBEX_TIMER);
> >
> > diff --git a/include/hw/char/ibex_uart.h b/include/hw/char/ibex_uart.h
> > deleted file mode 100644
> > index 882796e0c6..0000000000
> > --- a/include/hw/char/ibex_uart.h
> > +++ /dev/null
> > @@ -1,73 +0,0 @@
> > -/*
> > - * QEMU lowRISC Ibex UART device
> > - *
> > - * Copyright (c) 2020 Western Digital
> > - *
> > - * Permission is hereby granted, free of charge, to any person
> obtaining a copy
> > - * of this software and associated documentation files (the
> "Software"), to deal
> > - * in the Software without restriction, including without limitation
> the rights
> > - * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r
> sell
> > - * copies of the Software, and to permit persons to whom the Software =
is
> > - * furnished to do so, subject to the following conditions:
> > - *
> > - * The above copyright notice and this permission notice shall be
> included in
> > - * all copies or substantial portions of the Software.
> > - *
> > - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> > - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> > - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
> SHALL
> > - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
> OTHER
> > - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> ARISING FROM,
> > - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> DEALINGS IN
> > - * THE SOFTWARE.
> > - */
> > -
> > -#ifndef HW_IBEX_UART_H
> > -#define HW_IBEX_UART_H
> > -
> > -#include "hw/core/sysbus.h"
> > -#include "chardev/char-fe.h"
> > -#include "qemu/timer.h"
> > -#include "qom/object.h"
> > -
> > -#define IBEX_UART_TX_FIFO_SIZE 16
> > -#define IBEX_UART_CLOCK 50000000 /* 50MHz clock */
> > -
> > -#define TYPE_IBEX_UART "ibex-uart"
> > -OBJECT_DECLARE_SIMPLE_TYPE(IbexUartState, IBEX_UART)
> > -
> > -struct IbexUartState {
> > -    /* <private> */
> > -    SysBusDevice parent_obj;
> > -
> > -    /* <public> */
> > -    MemoryRegion mmio;
> > -
> > -    uint8_t tx_fifo[IBEX_UART_TX_FIFO_SIZE];
> > -    uint32_t tx_level;
> > -
> > -    uint32_t rx_level;
> > -
> > -    QEMUTimer *fifo_trigger_handle;
> > -    uint64_t char_tx_time;
> > -
> > -    uint32_t uart_intr_state;
> > -    uint32_t uart_intr_enable;
> > -    uint32_t uart_ctrl;
> > -    uint32_t uart_status;
> > -    uint32_t uart_rdata;
> > -    uint32_t uart_fifo_ctrl;
> > -    uint32_t uart_fifo_status;
> > -    uint32_t uart_ovrd;
> > -    uint32_t uart_val;
> > -    uint32_t uart_timeout_ctrl;
> > -
> > -    Clock *f_clk;
> > -
> > -    CharFrontend chr;
> > -    qemu_irq tx_watermark;
> > -    qemu_irq rx_watermark;
> > -    qemu_irq tx_empty;
> > -    qemu_irq rx_overflow;
> > -};
> > -#endif /* HW_IBEX_UART_H */
> > diff --git a/include/hw/char/ot_uart.h b/include/hw/char/ot_uart.h
> > new file mode 100644
> > index 0000000000..45ec3fc7c2
> > --- /dev/null
> > +++ b/include/hw/char/ot_uart.h
> > @@ -0,0 +1,133 @@
> > +/*
> > + * QEMU OpenTitan UART device
> > + *
> > + * Copyright (c) 2022-2025 Rivos, Inc.
> > + *
> > + * Author(s):
> > + *  Lo=C3=AFc Lefort <loic@rivosinc.com>
> > + *
> > + * SPDX-License-Identifier: MIT
> > + *
> > + */
> > +
> > +#ifndef HW_OPENTITAN_OT_UART_H
> > +#define HW_OPENTITAN_OT_UART_H
> > +
> > +#include "qemu/fifo8.h"
> > +#include "chardev/char-fe.h"
> > +#include "hw/core/sysbus.h"
> > +#include "qom/object.h"
> > +#include "hw/core/registerfields.h"
> > +
> > +#define TYPE_OT_UART "ot-uart"
> > +OBJECT_DECLARE_TYPE(OtUARTState, OtUARTClass, OT_UART)
> > +
> > +/* clang-format off */
> > +REG32(INTR_STATE, 0x00u)
> > +    SHARED_FIELD(INTR_TX_WATERMARK, 0u, 1u)
> > +    SHARED_FIELD(INTR_RX_WATERMARK, 1u, 1u)
> > +    SHARED_FIELD(INTR_TX_DONE, 2u, 1u)
> > +    SHARED_FIELD(INTR_RX_OVERFLOW, 3u, 1u)
> > +    SHARED_FIELD(INTR_RX_FRAME_ERR, 4u, 1u)
> > +    SHARED_FIELD(INTR_RX_BREAK_ERR, 5u, 1u)
> > +    SHARED_FIELD(INTR_RX_TIMEOUT, 6u, 1u)
> > +    SHARED_FIELD(INTR_RX_PARITY_ERR, 7u, 1u)
> > +    SHARED_FIELD(INTR_TX_EMPTY, 8u, 1u)
> > +REG32(INTR_ENABLE, 0x04u)
> > +REG32(INTR_TEST, 0x08u)
> > +REG32(ALERT_TEST, 0x0cu)
> > +    FIELD(ALERT_TEST, FATAL_FAULT, 0u, 1u)
> > +REG32(CTRL, 0x10u)
> > +    FIELD(CTRL, TX, 0u, 1u)
> > +    FIELD(CTRL, RX, 1u, 1u)
> > +    FIELD(CTRL, NF, 2u, 1u)
> > +    FIELD(CTRL, SLPBK, 4u, 1u)
> > +    FIELD(CTRL, LLPBK, 5u, 1u)
> > +    FIELD(CTRL, PARITY_EN, 6u, 1u)
> > +    FIELD(CTRL, PARITY_ODD, 7u, 1u)
> > +    FIELD(CTRL, RXBLVL, 8u, 2u)
> > +    FIELD(CTRL, NCO, 16u, 16u)
> > +REG32(STATUS, 0x14u)
> > +    FIELD(STATUS, TXFULL, 0u, 1u)
> > +    FIELD(STATUS, RXFULL, 1u, 1u)
> > +    FIELD(STATUS, TXEMPTY, 2u, 1u)
> > +    FIELD(STATUS, TXIDLE, 3u, 1u)
> > +    FIELD(STATUS, RXIDLE, 4u, 1u)
> > +    FIELD(STATUS, RXEMPTY, 5u, 1u)
> > +REG32(RDATA, 0x18u)
> > +    FIELD(RDATA, RDATA, 0u, 8u)
> > +REG32(WDATA, 0x1cu)
> > +    FIELD(WDATA, WDATA, 0u, 8u)
> > +REG32(FIFO_CTRL, 0x20u)
> > +    FIELD(FIFO_CTRL, RXRST, 0u, 1u)
> > +    FIELD(FIFO_CTRL, TXRST, 1u, 1u)
> > +    FIELD(FIFO_CTRL, RXILVL, 2u, 3u)
> > +    FIELD(FIFO_CTRL, TXILVL, 5u, 3u)
> > +REG32(FIFO_STATUS, 0x24u)
> > +    FIELD(FIFO_STATUS, TXLVL, 0u, 8u)
> > +    FIELD(FIFO_STATUS, RXLVL, 16u, 8u)
> > +REG32(OVRD, 0x28u)
> > +    FIELD(OVRD, TXEN, 0u, 1u)
> > +    FIELD(OVRD, TXVAL, 1u, 1u)
> > +REG32(VAL, 0x2cu)
> > +    FIELD(VAL, RX, 0u, 16u)
> > +REG32(TIMEOUT_CTRL, 0x30u)
> > +    FIELD(TIMEOUT_CTRL, VAL, 0u, 24)
> > +    FIELD(TIMEOUT_CTRL, EN, 31u, 1u)
> > +/* clang-format on */
> >
> > These shouldn't need to be public
> >
> > agreed. They are here because the struct definition below uses
> REGS_COUNT which is computed based on these definitions. I can hard-code
> the length of 13 instead? It looks like other hardware blocks also
> hard-code this, is there some way to at least catch the error if this sto=
ps
> being self-consistent?
>
> Yeah, everyone else just hard codes a length or defines each register
> as a u32/u64.
>
> Good question about an assert. You could do a runtime assert in the
> init() function. The BSD user headers also use `_Static_assert()` [1],
> so that should be an option. I haven't checked that all supported
> compilers support _Static_assert though
>
> 1: https://en.cppreference.com/w/c/language/_Static_assert.html
>
> Alistair
>
> >
> > Alistair
> >
> > +
> > +#define INTR_MASK \
> > +    (INTR_TX_WATERMARK_MASK | INTR_RX_WATERMARK_MASK |
> INTR_TX_DONE_MASK | \
> > +     INTR_RX_OVERFLOW_MASK | INTR_RX_FRAME_ERR_MASK |
> INTR_RX_BREAK_ERR_MASK | \
> > +     INTR_RX_TIMEOUT_MASK | INTR_RX_PARITY_ERR_MASK |
> INTR_TX_EMPTY_MASK)
> > +
> > +#define CTRL_MASK \
> > +    (R_CTRL_TX_MASK | R_CTRL_RX_MASK | R_CTRL_NF_MASK |
> R_CTRL_SLPBK_MASK | \
> > +     R_CTRL_LLPBK_MASK | R_CTRL_PARITY_EN_MASK | R_CTRL_PARITY_ODD_MAS=
K
> | \
> > +     R_CTRL_RXBLVL_MASK | R_CTRL_NCO_MASK)
> > +
> > +#define CTRL_SUP_MASK \
> > +    (R_CTRL_RX_MASK | R_CTRL_TX_MASK | R_CTRL_SLPBK_MASK |
> R_CTRL_NCO_MASK)
> > +
> > +#define OT_UART_NCO_BITS     16u
> > +#define OT_UART_TX_FIFO_SIZE 128u
> > +#define OT_UART_RX_FIFO_SIZE 128u
> > +#define OT_UART_IRQ_NUM      9u
> > +
> > +#define R32_OFF(_r_) ((_r_) / sizeof(uint32_t))
> > +
> > +#define R_LAST_REG (R_TIMEOUT_CTRL)
> > +#define REGS_COUNT (R_LAST_REG + 1u)
> > +#define REGS_SIZE  (REGS_COUNT * sizeof(uint32_t))
> > +#define REG_NAME(_reg_) \
> > +    ((((_reg_) < REGS_COUNT) && REG_NAMES[_reg_]) ? REG_NAMES[_reg_] :
> "?")
> > +
> > +struct OtUARTState {
> > +    SysBusDevice parent_obj;
> > +    MemoryRegion mmio;
> > +    qemu_irq irqs[OT_UART_IRQ_NUM];
> > +
> > +    uint32_t regs[REGS_COUNT];
> > +
> > +    Fifo8 tx_fifo;
> > +    Fifo8 rx_fifo;
> > +    uint32_t tx_watermark_level;
> > +    bool in_break;
> > +    guint watch_tag;
> > +    unsigned pclk; /* Current input clock */
> > +    const char *clock_src_name; /* IRQ name once connected */
> > +
> > +    char *ot_id;
> > +    char *clock_name;
> > +    DeviceState *clock_src;
> > +    CharFrontend chr;
> > +    bool oversample_break; /* Should mock break in the oversampled VAL
> reg? */
> > +    bool toggle_break; /* Are incoming breaks temporary or toggled? */
> > +};
> > +
> > +struct OtUARTClass {
> > +    SysBusDeviceClass parent_class;
> > +    ResettablePhases parent_phases;
> > +};
> > +
> > +#endif /* HW_OPENTITAN_OT_UART_H */
> > diff --git a/include/hw/riscv/opentitan.h b/include/hw/riscv/opentitan.=
h
> > index 5b9016e1d8..f2b4bf3814 100644
> > --- a/include/hw/riscv/opentitan.h
> > +++ b/include/hw/riscv/opentitan.h
> > @@ -21,7 +21,7 @@
> >
> >  #include "hw/riscv/riscv_hart.h"
> >  #include "hw/intc/sifive_plic.h"
> > -#include "hw/char/ibex_uart.h"
> > +#include "hw/char/ot_uart.h"
> >  #include "hw/timer/ibex_timer.h"
> >  #include "hw/ssi/ibex_spi_host.h"
> >  #include "hw/core/boards.h"
> > @@ -43,7 +43,7 @@ struct LowRISCIbexSoCState {
> >      /*< public >*/
> >      RISCVHartArrayState cpus;
> >      SiFivePLICState plic;
> > -    IbexUartState uart;
> > +    OtUARTState uart;
> >      IbexTimerState timer;
> >      IbexSPIHostState spi_host[OPENTITAN_NUM_SPI_HOSTS];
> >
> > --
> > 2.49.1
> >
> > --
> > Lex Bailey (they/them)
> > lowRISC C.I.C. 7 Hills Road, Cambridge, CB2 1GE, UK. Registered in
> England & Wales 09272283 lex.bailey@lowrisc.org
>
>

--000000000000af09d1064e5ea735
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Estimado Alistair:<br><br>Muchas gracias por su revisi=C3=
=B3n detallada. Estoy de acuerdo con sus observaciones y proceder=C3=A9 de =
la siguiente manera:<br><br>En primer lugar, realizar=C3=A9 el renombre del=
 archivo de ibex_uart a ot_uart en un commit separado con su debida justifi=
caci=C3=B3n, para luego incluir los cambios de implementaci=C3=B3n en commi=
ts posteriores.<br><br>Asimismo, me asegurar=C3=A9 de utilizar las macros d=
e QEMU existentes, como FIELD_EX32, en lugar de definiciones personalizadas=
. Tambi=C3=A9n corregir=C3=A9 el uso de los sufijos, los repartos de tipos =
y la visibilidad de las definiciones seg=C3=BAn lo sugerido. Respecto a la =
consistencia de la longitud del registro, evaluar=C3=A9 la implementaci=C3=
=B3n de una aserci=C3=B3n est=C3=A1tica o en tiempo de ejecuci=C3=B3n.<br><=
br>Agradezco mucho su tiempo y sus comentarios.<br><br>Atentamente,<br><br>=
Jose Martinez=C2=A0<br><div><br></div></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">El mar, 31 de m=
ar de 2026, 11:26=E2=80=AFp.m., Alistair Francis &lt;<a href=3D"mailto:alis=
tair23@gmail.com">alistair23@gmail.com</a>&gt; escribi=C3=B3:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">On Wed, Apr 1, 2026 at 1:36=E2=80=AFAM Lex Baile=
y &lt;<a href=3D"mailto:lex.bailey@lowrisc.org" target=3D"_blank" rel=3D"no=
referrer">lex.bailey@lowrisc.org</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt; On 26/03/2026 02:39, Alistair Francis wrote:<br>
&gt;<br>
&gt; On Fri, Mar 20, 2026 at 12:50=E2=80=AFAM ~lexbaileylowrisc<br>
&gt; &lt;<a href=3D"mailto:lexbaileylowrisc@git.sr.ht" target=3D"_blank" re=
l=3D"noreferrer">lexbaileylowrisc@git.sr.ht</a>&gt; wrote:<br>
&gt;<br>
&gt; You need a commit message, it should describe what you are doing, link=
<br>
&gt; to specs and provide details for future readers.<br>
&gt;<br>
&gt; From: Lex Bailey &lt;<a href=3D"mailto:lex.bailey@lowrisc.org" target=
=3D"_blank" rel=3D"noreferrer">lex.bailey@lowrisc.org</a>&gt;<br>
&gt;<br>
&gt; Signed-off-by: Lex Bailey &lt;<a href=3D"mailto:lex.bailey@lowrisc.org=
" target=3D"_blank" rel=3D"noreferrer">lex.bailey@lowrisc.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/char/ibex_uart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 569 ----=
---------------------------<br>
&gt;=C2=A0 hw/char/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A02 +-<br>
&gt;=C2=A0 hw/char/ot_uart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 635=
 +++++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 hw/char/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A08 +<br>
&gt;=C2=A0 hw/riscv/opentitan.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A03 +-<br>
&gt;=C2=A0 include/hw/char/ibex_uart.h=C2=A0 |=C2=A0 73 ----<br>
&gt;=C2=A0 include/hw/char/ot_uart.h=C2=A0 =C2=A0 | 133 ++++++++<br>
&gt;=C2=A0 include/hw/riscv/opentitan.h |=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 8 files changed, 781 insertions(+), 646 deletions(-)<br>
&gt;=C2=A0 delete mode 100644 hw/char/ibex_uart.c<br>
&gt;=C2=A0 create mode 100644 hw/char/ot_uart.c<br>
&gt;=C2=A0 delete mode 100644 include/hw/char/ibex_uart.h<br>
&gt;=C2=A0 create mode 100644 include/hw/char/ot_uart.h<br>
&gt;<br>
&gt; diff --git a/hw/char/ibex_uart.c b/hw/char/ibex_uart.c<br>
&gt; deleted file mode 100644<br>
&gt; index 127d219df3..0000000000<br>
&gt; --- a/hw/char/ibex_uart.c<br>
&gt; +++ /dev/null<br>
&gt;<br>
&gt; I don&#39;t think we should remove the file. If you want to rename it<=
br>
&gt; that&#39;s fine, but that should be its own commit. So one commit to<b=
r>
&gt; rename it (with a justification in the commit message) and then more<b=
r>
&gt; commits to make changes.<br>
&gt;<br>
&gt; okay, I will rename it first and then make changes<br>
&gt;<br>
&gt; @@ -1,569 +0,0 @@<br>
&gt; -/*<br>
&gt; - * QEMU lowRISC Ibex UART device<br>
&gt; - *<br>
&gt; - * Copyright (c) 2020 Western Digital<br>
&gt; - *<br>
&gt; - * For details check the documentation here:<br>
&gt; - *=C2=A0 =C2=A0 <a href=3D"https://docs.opentitan.org/hw/ip/uart/doc/=
" rel=3D"noreferrer noreferrer" target=3D"_blank">https://docs.opentitan.or=
g/hw/ip/uart/doc/</a><br>
&gt; - *<br>
&gt; - * Permission is hereby granted, free of charge, to any person obtain=
ing a copy<br>
&gt; - * of this software and associated documentation files (the &quot;Sof=
tware&quot;), to deal<br>
&gt; - * in the Software without restriction, including without limitation =
the rights<br>
&gt; - * to use, copy, modify, merge, publish, distribute, sublicense, and/=
or sell<br>
&gt; - * copies of the Software, and to permit persons to whom the Software=
 is<br>
&gt; - * furnished to do so, subject to the following conditions:<br>
&gt; - *<br>
&gt; - * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; - * all copies or substantial portions of the Software.<br>
&gt; - *<br>
&gt; - * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT =
SHALL<br>
&gt; - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES =
OR OTHER<br>
&gt; - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, AR=
ISING FROM,<br>
&gt; - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEAL=
INGS IN<br>
&gt; - * THE SOFTWARE.<br>
&gt; - */<br>
&gt; -<br>
&gt; -#include &quot;qemu/osdep.h&quot;<br>
&gt; -#include &quot;hw/char/ibex_uart.h&quot;<br>
&gt; -#include &quot;hw/core/irq.h&quot;<br>
&gt; -#include &quot;hw/core/qdev-clock.h&quot;<br>
&gt; -#include &quot;hw/core/qdev-properties.h&quot;<br>
&gt; -#include &quot;hw/core/qdev-properties-system.h&quot;<br>
&gt; -#include &quot;hw/core/registerfields.h&quot;<br>
&gt; -#include &quot;migration/vmstate.h&quot;<br>
&gt; -#include &quot;qemu/log.h&quot;<br>
&gt; -#include &quot;qemu/module.h&quot;<br>
&gt; -<br>
&gt; -REG32(INTR_STATE, 0x00)<br>
&gt; -=C2=A0 =C2=A0 FIELD(INTR_STATE, TX_WATERMARK, 0, 1)<br>
&gt; -=C2=A0 =C2=A0 FIELD(INTR_STATE, RX_WATERMARK, 1, 1)<br>
&gt; -=C2=A0 =C2=A0 FIELD(INTR_STATE, TX_EMPTY, 2, 1)<br>
&gt; -=C2=A0 =C2=A0 FIELD(INTR_STATE, RX_OVERFLOW, 3, 1)<br>
&gt; -REG32(INTR_ENABLE, 0x04)<br>
&gt; -REG32(INTR_TEST, 0x08)<br>
&gt; -REG32(ALERT_TEST, 0x0C)<br>
&gt; -REG32(CTRL, 0x10)<br>
&gt; -=C2=A0 =C2=A0 FIELD(CTRL, TX_ENABLE, 0, 1)<br>
&gt; -=C2=A0 =C2=A0 FIELD(CTRL, RX_ENABLE, 1, 1)<br>
&gt; -=C2=A0 =C2=A0 FIELD(CTRL, NF, 2, 1)<br>
&gt; -=C2=A0 =C2=A0 FIELD(CTRL, SLPBK, 4, 1)<br>
&gt; -=C2=A0 =C2=A0 FIELD(CTRL, LLPBK, 5, 1)<br>
&gt; -=C2=A0 =C2=A0 FIELD(CTRL, PARITY_EN, 6, 1)<br>
&gt; -=C2=A0 =C2=A0 FIELD(CTRL, PARITY_ODD, 7, 1)<br>
&gt; -=C2=A0 =C2=A0 FIELD(CTRL, RXBLVL, 8, 2)<br>
&gt; -=C2=A0 =C2=A0 FIELD(CTRL, NCO, 16, 16)<br>
&gt; -REG32(STATUS, 0x14)<br>
&gt; -=C2=A0 =C2=A0 FIELD(STATUS, TXFULL, 0, 1)<br>
&gt; -=C2=A0 =C2=A0 FIELD(STATUS, RXFULL, 1, 1)<br>
&gt; -=C2=A0 =C2=A0 FIELD(STATUS, TXEMPTY, 2, 1)<br>
&gt; -=C2=A0 =C2=A0 FIELD(STATUS, RXIDLE, 4, 1)<br>
&gt; -=C2=A0 =C2=A0 FIELD(STATUS, RXEMPTY, 5, 1)<br>
&gt; -REG32(RDATA, 0x18)<br>
&gt; -REG32(WDATA, 0x1C)<br>
&gt; -REG32(FIFO_CTRL, 0x20)<br>
&gt; -=C2=A0 =C2=A0 FIELD(FIFO_CTRL, RXRST, 0, 1)<br>
&gt; -=C2=A0 =C2=A0 FIELD(FIFO_CTRL, TXRST, 1, 1)<br>
&gt; -=C2=A0 =C2=A0 FIELD(FIFO_CTRL, RXILVL, 2, 3)<br>
&gt; -=C2=A0 =C2=A0 FIELD(FIFO_CTRL, TXILVL, 5, 2)<br>
&gt; -REG32(FIFO_STATUS, 0x24)<br>
&gt; -=C2=A0 =C2=A0 FIELD(FIFO_STATUS, TXLVL, 0, 5)<br>
&gt; -=C2=A0 =C2=A0 FIELD(FIFO_STATUS, RXLVL, 16, 5)<br>
&gt; -REG32(OVRD, 0x28)<br>
&gt; -REG32(VAL, 0x2C)<br>
&gt; -REG32(TIMEOUT_CTRL, 0x30)<br>
&gt; -<br>
&gt; -static void ibex_uart_update_irqs(IbexUartState *s)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 if (s-&gt;uart_intr_state &amp; s-&gt;uart_intr_enable =
&amp; R_INTR_STATE_TX_WATERMARK_MASK) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq(s-&gt;tx_watermark, 1);<br>
&gt; -=C2=A0 =C2=A0 } else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq(s-&gt;tx_watermark, 0);<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 if (s-&gt;uart_intr_state &amp; s-&gt;uart_intr_enable =
&amp; R_INTR_STATE_RX_WATERMARK_MASK) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq(s-&gt;rx_watermark, 1);<br>
&gt; -=C2=A0 =C2=A0 } else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq(s-&gt;rx_watermark, 0);<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 if (s-&gt;uart_intr_state &amp; s-&gt;uart_intr_enable =
&amp; R_INTR_STATE_TX_EMPTY_MASK) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq(s-&gt;tx_empty, 1);<br>
&gt; -=C2=A0 =C2=A0 } else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq(s-&gt;tx_empty, 0);<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 if (s-&gt;uart_intr_state &amp; s-&gt;uart_intr_enable =
&amp; R_INTR_STATE_RX_OVERFLOW_MASK) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq(s-&gt;rx_overflow, 1);<br>
&gt; -=C2=A0 =C2=A0 } else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq(s-&gt;rx_overflow, 0);<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -}<br>
&gt; -<br>
&gt; -static int ibex_uart_can_receive(void *opaque)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 IbexUartState *s =3D opaque;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 if ((s-&gt;uart_ctrl &amp; R_CTRL_RX_ENABLE_MASK)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;&amp; !(s-&gt;uart_stat=
us &amp; R_STATUS_RXFULL_MASK)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 return 0;<br>
&gt; -}<br>
&gt; -<br>
&gt; -static void ibex_uart_receive(void *opaque, const uint8_t *buf, int s=
ize)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 IbexUartState *s =3D opaque;<br>
&gt; -=C2=A0 =C2=A0 uint8_t rx_fifo_level =3D (s-&gt;uart_fifo_ctrl &amp; R=
_FIFO_CTRL_RXILVL_MASK)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; R_FIFO_CTRL_RXILVL_SHIFT;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 s-&gt;uart_rdata =3D *buf;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 s-&gt;uart_status &amp;=3D ~R_STATUS_RXIDLE_MASK;<br>
&gt; -=C2=A0 =C2=A0 s-&gt;uart_status &amp;=3D ~R_STATUS_RXEMPTY_MASK;<br>
&gt; -=C2=A0 =C2=A0 /* The RXFULL is set after receiving a single byte<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* as the FIFO buffers are not yet implemented.<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; -=C2=A0 =C2=A0 s-&gt;uart_status |=3D R_STATUS_RXFULL_MASK;<br>
&gt; -=C2=A0 =C2=A0 s-&gt;rx_level +=3D 1;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 if (size &gt; rx_fifo_level) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;uart_intr_state |=3D R_INTR_STATE_R=
X_WATERMARK_MASK;<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 ibex_uart_update_irqs(s);<br>
&gt; -}<br>
&gt; -<br>
&gt; -static gboolean ibex_uart_xmit(void *do_not_use, GIOCondition cond,<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *opaque)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 IbexUartState *s =3D opaque;<br>
&gt; -=C2=A0 =C2=A0 uint8_t tx_fifo_level =3D (s-&gt;uart_fifo_ctrl &amp; R=
_FIFO_CTRL_TXILVL_MASK)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; R_FIFO_CTRL_TXILVL_SHIFT;<br>
&gt; -=C2=A0 =C2=A0 int ret;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 /* instant drain the fifo when there&#39;s no back-end =
*/<br>
&gt; -=C2=A0 =C2=A0 if (!qemu_chr_fe_backend_connected(&amp;s-&gt;chr)) {<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;tx_level =3D 0;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return G_SOURCE_REMOVE;<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 if (!s-&gt;tx_level) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;uart_status &amp;=3D ~R_STATUS_TXFU=
LL_MASK;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;uart_status |=3D R_STATUS_TXEMPTY_M=
ASK;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;uart_intr_state |=3D R_INTR_STATE_T=
X_EMPTY_MASK;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;uart_intr_state &amp;=3D ~R_INTR_ST=
ATE_TX_WATERMARK_MASK;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ibex_uart_update_irqs(s);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return G_SOURCE_REMOVE;<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 ret =3D qemu_chr_fe_write(&amp;s-&gt;chr, s-&gt;tx_fifo=
, s-&gt;tx_level);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 if (ret &gt;=3D 0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;tx_level -=3D ret;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 memmove(s-&gt;tx_fifo, s-&gt;tx_fifo + re=
t, s-&gt;tx_level);<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 if (s-&gt;tx_level) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 guint r =3D qemu_chr_fe_add_watch(&amp;s-=
&gt;chr, G_IO_OUT | G_IO_HUP,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ibex=
_uart_xmit, s);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!r) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;tx_level =3D 0;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return G_SOURCE_REMOVE;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 /* Clear the TX Full bit */<br>
&gt; -=C2=A0 =C2=A0 if (s-&gt;tx_level !=3D IBEX_UART_TX_FIFO_SIZE) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;uart_status &amp;=3D ~R_STATUS_TXFU=
LL_MASK;<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 /* Disable the TX_WATERMARK IRQ */<br>
&gt; -=C2=A0 =C2=A0 if (s-&gt;tx_level &lt; tx_fifo_level) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;uart_intr_state &amp;=3D ~R_INTR_ST=
ATE_TX_WATERMARK_MASK;<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 /* Set TX empty */<br>
&gt; -=C2=A0 =C2=A0 if (s-&gt;tx_level =3D=3D 0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;uart_status |=3D R_STATUS_TXEMPTY_M=
ASK;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;uart_intr_state |=3D R_INTR_STATE_T=
X_EMPTY_MASK;<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 ibex_uart_update_irqs(s);<br>
&gt; -=C2=A0 =C2=A0 return G_SOURCE_REMOVE;<br>
&gt; -}<br>
&gt; -<br>
&gt; -static void uart_write_tx_fifo(IbexUartState *s, const uint8_t *buf,<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int size)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 uint64_t current_time =3D qemu_clock_get_ns(QEMU_CLOCK_=
VIRTUAL);<br>
&gt; -=C2=A0 =C2=A0 uint8_t tx_fifo_level =3D (s-&gt;uart_fifo_ctrl &amp; R=
_FIFO_CTRL_TXILVL_MASK)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; R_FIFO_CTRL_TXILVL_SHIFT;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 if (size &gt; IBEX_UART_TX_FIFO_SIZE - s-&gt;tx_level) =
{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D IBEX_UART_TX_FIFO_SIZE - s-&gt;t=
x_level;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;ibex=
_uart: TX FIFO overflow&quot;);<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 memcpy(s-&gt;tx_fifo + s-&gt;tx_level, buf, size);<br>
&gt; -=C2=A0 =C2=A0 s-&gt;tx_level +=3D size;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 if (s-&gt;tx_level &gt; 0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;uart_status &amp;=3D ~R_STATUS_TXEM=
PTY_MASK;<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 if (s-&gt;tx_level &gt;=3D tx_fifo_level) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;uart_intr_state |=3D R_INTR_STATE_T=
X_WATERMARK_MASK;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ibex_uart_update_irqs(s);<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 if (s-&gt;tx_level =3D=3D IBEX_UART_TX_FIFO_SIZE) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;uart_status |=3D R_STATUS_TXFULL_MA=
SK;<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 timer_mod(s-&gt;fifo_trigger_handle, current_time +<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (s-&gt;char_tx_time =
* 4));<br>
&gt; -}<br>
&gt; -<br>
&gt; -static void ibex_uart_reset(DeviceState *dev)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 IbexUartState *s =3D IBEX_UART(dev);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 s-&gt;uart_intr_state =3D 0x00000000;<br>
&gt; -=C2=A0 =C2=A0 s-&gt;uart_intr_state =3D 0x00000000;<br>
&gt; -=C2=A0 =C2=A0 s-&gt;uart_intr_enable =3D 0x00000000;<br>
&gt; -=C2=A0 =C2=A0 s-&gt;uart_ctrl =3D 0x00000000;<br>
&gt; -=C2=A0 =C2=A0 s-&gt;uart_status =3D 0x0000003c;<br>
&gt; -=C2=A0 =C2=A0 s-&gt;uart_rdata =3D 0x00000000;<br>
&gt; -=C2=A0 =C2=A0 s-&gt;uart_fifo_ctrl =3D 0x00000000;<br>
&gt; -=C2=A0 =C2=A0 s-&gt;uart_fifo_status =3D 0x00000000;<br>
&gt; -=C2=A0 =C2=A0 s-&gt;uart_ovrd =3D 0x00000000;<br>
&gt; -=C2=A0 =C2=A0 s-&gt;uart_val =3D 0x00000000;<br>
&gt; -=C2=A0 =C2=A0 s-&gt;uart_timeout_ctrl =3D 0x00000000;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 s-&gt;tx_level =3D 0;<br>
&gt; -=C2=A0 =C2=A0 s-&gt;rx_level =3D 0;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 s-&gt;char_tx_time =3D (NANOSECONDS_PER_SECOND / 230400=
) * 10;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 ibex_uart_update_irqs(s);<br>
&gt; -}<br>
&gt; -<br>
&gt; -static uint64_t ibex_uart_get_baud(IbexUartState *s)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 uint64_t baud;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 baud =3D ((s-&gt;uart_ctrl &amp; R_CTRL_NCO_MASK) &gt;&=
gt; 16);<br>
&gt; -=C2=A0 =C2=A0 baud *=3D clock_get_hz(s-&gt;f_clk);<br>
&gt; -=C2=A0 =C2=A0 baud &gt;&gt;=3D 20;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 return baud;<br>
&gt; -}<br>
&gt; -<br>
&gt; -static uint64_t ibex_uart_read(void *opaque, hwaddr addr,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsig=
ned int size)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 IbexUartState *s =3D opaque;<br>
&gt; -=C2=A0 =C2=A0 uint64_t retvalue =3D 0;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 switch (addr &gt;&gt; 2) {<br>
&gt; -=C2=A0 =C2=A0 case R_INTR_STATE:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 retvalue =3D s-&gt;uart_intr_state;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; -=C2=A0 =C2=A0 case R_INTR_ENABLE:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 retvalue =3D s-&gt;uart_intr_enable;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; -=C2=A0 =C2=A0 case R_INTR_TEST:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &quot;%s: wdata is write only\n&quot;, __func__);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 case R_CTRL:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 retvalue =3D s-&gt;uart_ctrl;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; -=C2=A0 =C2=A0 case R_STATUS:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 retvalue =3D s-&gt;uart_status;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 case R_RDATA:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 retvalue =3D s-&gt;uart_rdata;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((s-&gt;uart_ctrl &amp; R_CTRL_RX_ENAB=
LE_MASK) &amp;&amp; (s-&gt;rx_level &gt; 0)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_chr_fe_accept_input(&a=
mp;s-&gt;chr);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;rx_level -=3D 1;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;uart_status &amp;=3D =
~R_STATUS_RXFULL_MASK;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;rx_level =3D=3D 0=
) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;uart_st=
atus |=3D R_STATUS_RXIDLE_MASK;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;uart_st=
atus |=3D R_STATUS_RXEMPTY_MASK;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; -=C2=A0 =C2=A0 case R_WDATA:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &quot;%s: wdata is write only\n&quot;, __func__);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 case R_FIFO_CTRL:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 retvalue =3D s-&gt;uart_fifo_ctrl;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; -=C2=A0 =C2=A0 case R_FIFO_STATUS:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 retvalue =3D s-&gt;uart_fifo_status;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 retvalue |=3D (s-&gt;rx_level &amp; 0x1F)=
 &lt;&lt; R_FIFO_STATUS_RXLVL_SHIFT;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 retvalue |=3D (s-&gt;tx_level &amp; 0x1F)=
 &lt;&lt; R_FIFO_STATUS_TXLVL_SHIFT;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &quot;%s: RX fifos are not supported\n&quot;, __func__);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 case R_OVRD:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 retvalue =3D s-&gt;uart_ovrd;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &quot;%s: ovrd is not supported\n&quot;, __func__);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; -=C2=A0 =C2=A0 case R_VAL:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 retvalue =3D s-&gt;uart_val;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &quot;%s: val is not supported\n&quot;, __func__);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; -=C2=A0 =C2=A0 case R_TIMEOUT_CTRL:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 retvalue =3D s-&gt;uart_timeout_ctrl;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &quot;%s: timeout_ctrl is not supported\n&quot;, __func__);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; -=C2=A0 =C2=A0 default:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &quot;%s: Bad offset 0x%&quot;HWADDR_PRIx&quot;\n&quot;, __func__, =
addr);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 return retvalue;<br>
&gt; -}<br>
&gt; -<br>
&gt; -static void ibex_uart_write(void *opaque, hwaddr addr,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t val64, unsigned =
int size)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 IbexUartState *s =3D opaque;<br>
&gt; -=C2=A0 =C2=A0 uint32_t value =3D val64;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 switch (addr &gt;&gt; 2) {<br>
&gt; -=C2=A0 =C2=A0 case R_INTR_STATE:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Write 1 clear */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;uart_intr_state &amp;=3D ~value;<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ibex_uart_update_irqs(s);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; -=C2=A0 =C2=A0 case R_INTR_ENABLE:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;uart_intr_enable =3D value;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ibex_uart_update_irqs(s);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; -=C2=A0 =C2=A0 case R_INTR_TEST:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;uart_intr_state |=3D value;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ibex_uart_update_irqs(s);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 case R_CTRL:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;uart_ctrl =3D value;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (value &amp; R_CTRL_NF_MASK) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP,<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &quot;%s: UART_CTRL_NF is not supported\n&quot;, __fu=
nc__);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (value &amp; R_CTRL_SLPBK_MASK) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP,<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &quot;%s: UART_CTRL_SLPBK is not supported\n&quot;, _=
_func__);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (value &amp; R_CTRL_LLPBK_MASK) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP,<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &quot;%s: UART_CTRL_LLPBK is not supported\n&quot;, _=
_func__);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (value &amp; R_CTRL_PARITY_EN_MASK) {<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP,<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &quot;%s: UART_CTRL_PARITY_EN is not supported\n&quot=
;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 __func__);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (value &amp; R_CTRL_PARITY_ODD_MASK) {=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP,<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &quot;%s: UART_CTRL_PARITY_ODD is not supported\n&quo=
t;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 __func__);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (value &amp; R_CTRL_RXBLVL_MASK) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP,<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &quot;%s: UART_CTRL_RXBLVL is not supported\n&quot;, =
__func__);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (value &amp; R_CTRL_NCO_MASK) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t baud =3D ibex_uart=
_get_baud(s);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;char_tx_time =3D (NAN=
OSECONDS_PER_SECOND / baud) * 10;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; -=C2=A0 =C2=A0 case R_STATUS:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &quot;%s: status is read only\n&quot;, __func__);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 case R_RDATA:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &quot;%s: rdata is read only\n&quot;, __func__);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; -=C2=A0 =C2=A0 case R_WDATA:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 uart_write_tx_fifo(s, (uint8_t *) &amp;va=
lue, 1);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 case R_FIFO_CTRL:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;uart_fifo_ctrl =3D value;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (value &amp; R_FIFO_CTRL_RXRST_MASK) {=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;rx_level =3D 0;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP,<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &quot;%s: RX fifos are not supported\n&quot;, __func_=
_);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (value &amp; R_FIFO_CTRL_TXRST_MASK) {=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;tx_level =3D 0;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; -=C2=A0 =C2=A0 case R_FIFO_STATUS:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &quot;%s: fifo_status is read only\n&quot;, __func__);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 case R_OVRD:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;uart_ovrd =3D value;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &quot;%s: ovrd is not supported\n&quot;, __func__);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; -=C2=A0 =C2=A0 case R_VAL:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &quot;%s: val is read only\n&quot;, __func__);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; -=C2=A0 =C2=A0 case R_TIMEOUT_CTRL:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;uart_timeout_ctrl =3D value;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &quot;%s: timeout_ctrl is not supported\n&quot;, __func__);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; -=C2=A0 =C2=A0 default:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &quot;%s: Bad offset 0x%&quot;HWADDR_PRIx&quot;\n&quot;, __func__, =
addr);<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -}<br>
&gt; -<br>
&gt; -static void ibex_uart_clk_update(void *opaque, ClockEvent event)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 IbexUartState *s =3D opaque;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 /* recompute uart&#39;s speed on clock change */<br>
&gt; -=C2=A0 =C2=A0 uint64_t baud =3D ibex_uart_get_baud(s);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 s-&gt;char_tx_time =3D (NANOSECONDS_PER_SECOND / baud) =
* 10;<br>
&gt; -}<br>
&gt; -<br>
&gt; -static void fifo_trigger_update(void *opaque)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 IbexUartState *s =3D opaque;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 if (s-&gt;uart_ctrl &amp; R_CTRL_TX_ENABLE_MASK) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ibex_uart_xmit(NULL, G_IO_OUT, s);<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -}<br>
&gt; -<br>
&gt; -static const MemoryRegionOps ibex_uart_ops =3D {<br>
&gt; -=C2=A0 =C2=A0 .read =3D ibex_uart_read,<br>
&gt; -=C2=A0 =C2=A0 .write =3D ibex_uart_write,<br>
&gt; -=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,<br>
&gt; -=C2=A0 =C2=A0 .impl.min_access_size =3D 4,<br>
&gt; -=C2=A0 =C2=A0 .impl.max_access_size =3D 4,<br>
&gt; -};<br>
&gt; -<br>
&gt; -static int ibex_uart_post_load(void *opaque, int version_id)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 IbexUartState *s =3D opaque;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 ibex_uart_update_irqs(s);<br>
&gt; -=C2=A0 =C2=A0 return 0;<br>
&gt; -}<br>
&gt; -<br>
&gt; -static const VMStateDescription vmstate_ibex_uart =3D {<br>
&gt; -=C2=A0 =C2=A0 .name =3D TYPE_IBEX_UART,<br>
&gt; -=C2=A0 =C2=A0 .version_id =3D 1,<br>
&gt; -=C2=A0 =C2=A0 .minimum_version_id =3D 1,<br>
&gt; -=C2=A0 =C2=A0 .post_load =3D ibex_uart_post_load,<br>
&gt; -=C2=A0 =C2=A0 .fields =3D (const VMStateField[]) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8_ARRAY(tx_fifo, IbexUartStat=
e,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IBEX_UART_TX_FIFO_SIZE),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(tx_level, IbexUartState),<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT64(char_tx_time, IbexUartStat=
e),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_TIMER_PTR(fifo_trigger_handle, Ib=
exUartState),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(uart_intr_state, IbexUartS=
tate),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(uart_intr_enable, IbexUart=
State),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(uart_ctrl, IbexUartState),=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(uart_status, IbexUartState=
),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(uart_rdata, IbexUartState)=
,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(uart_fifo_ctrl, IbexUartSt=
ate),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(uart_fifo_status, IbexUart=
State),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(uart_ovrd, IbexUartState),=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(uart_val, IbexUartState),<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(uart_timeout_ctrl, IbexUar=
tState),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -};<br>
&gt; -<br>
&gt; -static const Property ibex_uart_properties[] =3D {<br>
&gt; -=C2=A0 =C2=A0 DEFINE_PROP_CHR(&quot;chardev&quot;, IbexUartState, chr=
),<br>
&gt; -};<br>
&gt; -<br>
&gt; -static void ibex_uart_init(Object *obj)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 IbexUartState *s =3D IBEX_UART(obj);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 s-&gt;f_clk =3D qdev_init_clock_in(DEVICE(obj), &quot;f=
_clock&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ibex_uart_clk_update, s, =
ClockUpdate);<br>
&gt; -=C2=A0 =C2=A0 clock_set_hz(s-&gt;f_clk, IBEX_UART_CLOCK);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 sysbus_init_irq(SYS_BUS_DEVICE(obj), &amp;s-&gt;tx_wate=
rmark);<br>
&gt; -=C2=A0 =C2=A0 sysbus_init_irq(SYS_BUS_DEVICE(obj), &amp;s-&gt;rx_wate=
rmark);<br>
&gt; -=C2=A0 =C2=A0 sysbus_init_irq(SYS_BUS_DEVICE(obj), &amp;s-&gt;tx_empt=
y);<br>
&gt; -=C2=A0 =C2=A0 sysbus_init_irq(SYS_BUS_DEVICE(obj), &amp;s-&gt;rx_over=
flow);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;mmio, obj, &amp;ibex_u=
art_ops, s,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 TYPE_IBEX_UART, 0x400);<br>
&gt; -=C2=A0 =C2=A0 sysbus_init_mmio(SYS_BUS_DEVICE(obj), &amp;s-&gt;mmio);=
<br>
&gt; -}<br>
&gt; -<br>
&gt; -static void ibex_uart_realize(DeviceState *dev, Error **errp)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 IbexUartState *s =3D IBEX_UART(dev);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 s-&gt;fifo_trigger_handle =3D timer_new_ns(QEMU_CLOCK_V=
IRTUAL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 fifo_trigger_update, s);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 qemu_chr_fe_set_handlers(&amp;s-&gt;chr, ibex_uart_can_=
receive,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ibex_uart_receive, NULL, NULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s, NULL, true);<br>
&gt; -}<br>
&gt; -<br>
&gt; -static void ibex_uart_class_init(ObjectClass *klass, const void *data=
)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 device_class_set_legacy_reset(dc, ibex_uart_reset);<br>
&gt; -=C2=A0 =C2=A0 dc-&gt;realize =3D ibex_uart_realize;<br>
&gt; -=C2=A0 =C2=A0 dc-&gt;vmsd =3D &amp;vmstate_ibex_uart;<br>
&gt; -=C2=A0 =C2=A0 device_class_set_props(dc, ibex_uart_properties);<br>
&gt; -=C2=A0 =C2=A0 set_bit(DEVICE_CATEGORY_INPUT, dc-&gt;categories);<br>
&gt; -}<br>
&gt; -<br>
&gt; -static const TypeInfo ibex_uart_info =3D {<br>
&gt; -=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_IBEX_U=
ART,<br>
&gt; -=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SYS_BUS_DEV=
ICE,<br>
&gt; -=C2=A0 =C2=A0 .instance_size =3D sizeof(IbexUartState),<br>
&gt; -=C2=A0 =C2=A0 .instance_init =3D ibex_uart_init,<br>
&gt; -=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D ibex_uart_class_init,<br>
&gt; -};<br>
&gt; -<br>
&gt; -static void ibex_uart_register_types(void)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 type_register_static(&amp;ibex_uart_info);<br>
&gt; -}<br>
&gt; -<br>
&gt; -type_init(ibex_uart_register_types)<br>
&gt; diff --git a/hw/char/meson.build b/hw/char/meson.build<br>
&gt; index fc3d7ee506..989ca3d7e0 100644<br>
&gt; --- a/hw/char/meson.build<br>
&gt; +++ b/hw/char/meson.build<br>
&gt; @@ -2,7 +2,7 @@ system_ss.add(when: &#39;CONFIG_CADENCE&#39;, if_true:=
 files(&#39;cadence_uart.c&#39;))<br>
&gt;=C2=A0 system_ss.add(when: &#39;CONFIG_CMSDK_APB_UART&#39;, if_true: fi=
les(&#39;cmsdk-apb-uart.c&#39;))<br>
&gt;=C2=A0 system_ss.add(when: &#39;CONFIG_ESCC&#39;, if_true: files(&#39;e=
scc.c&#39;))<br>
&gt;=C2=A0 system_ss.add(when: &#39;CONFIG_GRLIB&#39;, if_true: files(&#39;=
grlib_apbuart.c&#39;))<br>
&gt; -system_ss.add(when: &#39;CONFIG_IBEX&#39;, if_true: files(&#39;ibex_u=
art.c&#39;))<br>
&gt; +system_ss.add(when: &#39;CONFIG_IBEX&#39;, if_true: files(&#39;ot_uar=
t.c&#39;))<br>
&gt;=C2=A0 system_ss.add(when: &#39;CONFIG_IMX&#39;, if_true: files(&#39;im=
x_serial.c&#39;))<br>
&gt;=C2=A0 system_ss.add(when: &#39;CONFIG_IP_OCTAL_232&#39;, if_true: file=
s(&#39;ipoctal232.c&#39;))<br>
&gt;=C2=A0 system_ss.add(when: &#39;CONFIG_ISA_BUS&#39;, if_true: files(&#3=
9;parallel-isa.c&#39;))<br>
&gt; diff --git a/hw/char/ot_uart.c b/hw/char/ot_uart.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..757f64ab70<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/char/ot_uart.c<br>
&gt; @@ -0,0 +1,635 @@<br>
&gt; +/*<br>
&gt; + * QEMU OpenTitan UART device<br>
&gt; + *<br>
&gt; + * Copyright (c) 2022-2025 Rivos, Inc.<br>
&gt; + * Copyright (c) 2025 lowRISC contributors.<br>
&gt; + *<br>
&gt; + * Author(s):<br>
&gt; + *=C2=A0 Lo=C3=AFc Lefort &lt;<a href=3D"mailto:loic@rivosinc.com" ta=
rget=3D"_blank" rel=3D"noreferrer">loic@rivosinc.com</a>&gt;<br>
&gt; + *<br>
&gt; + * SPDX-License-Identifier: MIT<br>
&gt; + *<br>
&gt; + * Based on original ibex_uart implementation:<br>
&gt; + *=C2=A0 Copyright (c) 2020 Western Digital<br>
&gt; + *=C2=A0 Alistair Francis &lt;<a href=3D"mailto:alistair.francis@wdc.=
com" target=3D"_blank" rel=3D"noreferrer">alistair.francis@wdc.com</a>&gt;<=
br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;qemu/fifo8.h&quot;<br>
&gt; +#include &quot;qemu/log.h&quot;<br>
&gt; +#include &quot;qemu/module.h&quot;<br>
&gt; +#include &quot;qapi/error.h&quot;<br>
&gt; +#include &quot;chardev/char-fe.h&quot;<br>
&gt; +#include &quot;hw/core/cpu.h&quot;<br>
&gt; +#include &quot;hw/core/irq.h&quot;<br>
&gt; +#include &quot;hw/char/ot_uart.h&quot;<br>
&gt; +#include &quot;hw/core/qdev-properties-system.h&quot;<br>
&gt; +#include &quot;hw/core/qdev-properties.h&quot;<br>
&gt; +#include &quot;hw/core/registerfields.h&quot;<br>
&gt; +#include &quot;trace.h&quot;<br>
&gt; +<br>
&gt; +#define REG_NAME_ENTRY(_reg_) [R_##_reg_] =3D stringify(_reg_)<br>
&gt;<br>
&gt; Let&#39;s use the existing QEMU macros instead of creating custom ones=
.<br>
&gt;<br>
&gt; Specifically which macro should I be using instead? I can&#39;t find a=
ny that do the same as this one. It is used to populate the array of regist=
er names just below, which are used in log/trace messages<br>
<br>
Ah sorry. I originally thought this was instead of the REG32 macros,<br>
hence the comment. Then forgot to come back and delete the comment<br>
before sending.<br>
<br>
&gt;<br>
&gt; +static const char *REG_NAMES[REGS_COUNT] =3D {<br>
&gt; +=C2=A0 =C2=A0 /* clang-format off */<br>
&gt; +=C2=A0 =C2=A0 REG_NAME_ENTRY(INTR_STATE),<br>
&gt; +=C2=A0 =C2=A0 REG_NAME_ENTRY(INTR_ENABLE),<br>
&gt; +=C2=A0 =C2=A0 REG_NAME_ENTRY(INTR_TEST),<br>
&gt; +=C2=A0 =C2=A0 REG_NAME_ENTRY(ALERT_TEST),<br>
&gt; +=C2=A0 =C2=A0 REG_NAME_ENTRY(CTRL),<br>
&gt; +=C2=A0 =C2=A0 REG_NAME_ENTRY(STATUS),<br>
&gt; +=C2=A0 =C2=A0 REG_NAME_ENTRY(RDATA),<br>
&gt; +=C2=A0 =C2=A0 REG_NAME_ENTRY(WDATA),<br>
&gt; +=C2=A0 =C2=A0 REG_NAME_ENTRY(FIFO_CTRL),<br>
&gt; +=C2=A0 =C2=A0 REG_NAME_ENTRY(FIFO_STATUS),<br>
&gt; +=C2=A0 =C2=A0 REG_NAME_ENTRY(OVRD),<br>
&gt; +=C2=A0 =C2=A0 REG_NAME_ENTRY(VAL),<br>
&gt; +=C2=A0 =C2=A0 REG_NAME_ENTRY(TIMEOUT_CTRL),<br>
&gt; +=C2=A0 =C2=A0 /* clang-format on */<br>
&gt; +};<br>
&gt; +#undef REG_NAME_ENTRY<br>
&gt; +<br>
&gt; +static uint32_t ot_uart_get_tx_watermark_level(const OtUARTState *s)<=
br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint32_t tx_ilvl =3D (s-&gt;regs[R_FIFO_CTRL] &amp; R_F=
IFO_CTRL_TXILVL_MASK) &gt;&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0R_FIFO_CTRL_TXILVL_SHIFT;<br>
&gt;<br>
&gt; You can then use the extract (FIELD_EX32) macros instead of mask and s=
hift.<br>
&gt;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return tx_ilvl &lt; 7u ? (1u &lt;&lt; tx_ilvl) : 64u;<b=
r>
&gt;<br>
&gt; You shouldn&#39;t need the `u`s<br>
&gt;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static uint32_t ot_uart_get_rx_watermark_level(const OtUARTState *s)<=
br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint32_t rx_ilvl =3D (s-&gt;regs[R_FIFO_CTRL] &amp; R_F=
IFO_CTRL_RXILVL_MASK) &gt;&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0R_FIFO_CTRL_RXILVL_SHIFT;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return rx_ilvl &lt; 7u ? (1u &lt;&lt; rx_ilvl) : 126u;<=
br>
&gt; +}<br>
&gt; +<br>
&gt; +static void ot_uart_update_irqs(OtUARTState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint32_t state_masked =3D s-&gt;regs[R_INTR_STATE] &amp=
; s-&gt;regs[R_INTR_ENABLE];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_ot_uart_irqs(s-&gt;ot_id, s-&gt;regs[R_INTR_STATE=
], s-&gt;regs[R_INTR_ENABLE],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0state_masked);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (int index =3D 0; index &lt; OT_UART_IRQ_NUM; index=
++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool level =3D (state_masked &amp; (1U &l=
t;&lt; index)) !=3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq(s-&gt;irqs[index], level);<b=
r>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool ot_uart_is_sys_loopack_enabled(const OtUARTState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return (bool)FIELD_EX32(s-&gt;regs[R_CTRL], CTRL, SLPBK=
);<br>
&gt;<br>
&gt; You also should need to cast this<br>
&gt;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool ot_uart_is_tx_enabled(const OtUARTState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return (bool)FIELD_EX32(s-&gt;regs[R_CTRL], CTRL, TX);<=
br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool ot_uart_is_rx_enabled(const OtUARTState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return (bool)FIELD_EX32(s-&gt;regs[R_CTRL], CTRL, RX);<=
br>
&gt; +}<br>
&gt; +<br>
&gt; +static void ot_uart_check_baudrate(const OtUARTState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint32_t nco =3D FIELD_EX32(s-&gt;regs[R_CTRL], CTRL, N=
CO);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 unsigned baudrate =3D (unsigned)(((uint64_t)nco * (uint=
64_t)s-&gt;pclk) &gt;&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(R_CTRL_NCO_LENGTH =
+ 4));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (baudrate) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_ot_uart_check_baudrate(s-&gt;ot_id,=
 s-&gt;pclk, baudrate);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void ot_uart_reset_rx_fifo(OtUARTState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 fifo8_reset(&amp;s-&gt;rx_fifo);<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[R_INTR_STATE] &amp;=3D ~INTR_RX_WATERMARK_MA=
SK;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[R_INTR_STATE] &amp;=3D ~INTR_RX_OVERFLOW_MAS=
K;<br>
&gt; +=C2=A0 =C2=A0 if (ot_uart_is_rx_enabled(s) &amp;&amp; !ot_uart_is_sys=
_loopack_enabled(s)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_chr_fe_accept_input(&amp;s-&gt;chr);=
<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int ot_uart_can_receive(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 OtUARTState *s =3D opaque;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;regs[R_CTRL] &amp; R_CTRL_RX_MASK) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (int)fifo8_num_free(&amp;s-&gt;rx_=
fifo);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void ot_uart_receive(void *opaque, const uint8_t *buf, int siz=
e)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 OtUARTState *s =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 uint32_t rx_watermark_level;<br>
&gt; +=C2=A0 =C2=A0 size_t count =3D MIN(fifo8_num_free(&amp;s-&gt;rx_fifo)=
, (size_t)size);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (size &amp;&amp; !s-&gt;toggle_break) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* no longer breaking, so emulate idle in=
 oversampled VAL register */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;in_break =3D false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (int index =3D 0; index &lt; size; index++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fifo8_push(&amp;s-&gt;rx_fifo, buf[index]=
);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* update INTR_STATE */<br>
&gt; +=C2=A0 =C2=A0 if (count !=3D size) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[R_INTR_STATE] |=3D INTR_RX_OVE=
RFLOW_MASK;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 rx_watermark_level =3D ot_uart_get_rx_watermark_level(s=
);<br>
&gt; +=C2=A0 =C2=A0 if (rx_watermark_level &amp;&amp; size &gt;=3D rx_water=
mark_level) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[R_INTR_STATE] |=3D INTR_RX_WAT=
ERMARK_MASK;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ot_uart_update_irqs(s);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void ot_uart_event_handler(void *opaque, QEMUChrEvent event)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 OtUARTState *s =3D opaque;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (event =3D=3D CHR_EVENT_BREAK) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!s-&gt;in_break || !s-&gt;oversample_=
break) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ignore CTRL.RXBLVL as we=
 have no notion of break &quot;time&quot; */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[R_INTR_STATE] |=
=3D INTR_RX_BREAK_ERR_MASK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ot_uart_update_irqs(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* emulate break in the ove=
rsampled VAL register */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;in_break =3D true;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (s-&gt;toggle_break) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* emulate toggling break o=
ff in the oversampled VAL register */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;in_break =3D false;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static uint8_t ot_uart_read_rx_fifo(OtUARTState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint8_t val;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!(s-&gt;regs[R_CTRL] &amp; R_CTRL_RX_MASK)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (fifo8_is_empty(&amp;s-&gt;rx_fifo)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 val =3D fifo8_pop(&amp;s-&gt;rx_fifo);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (ot_uart_is_rx_enabled(s) &amp;&amp; !ot_uart_is_sys=
_loopack_enabled(s)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_chr_fe_accept_input(&amp;s-&gt;chr);=
<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return val;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void ot_uart_reset_tx_fifo(OtUARTState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 fifo8_reset(&amp;s-&gt;tx_fifo);<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[R_INTR_STATE] |=3D INTR_TX_EMPTY_MASK;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[R_INTR_STATE] |=3D INTR_TX_DONE_MASK;<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;tx_watermark_level) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[R_INTR_STATE] |=3D INTR_TX_WAT=
ERMARK_MASK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;tx_watermark_level =3D 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void ot_uart_xmit(OtUARTState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 const uint8_t *buf;<br>
&gt; +=C2=A0 =C2=A0 uint32_t size;<br>
&gt; +=C2=A0 =C2=A0 int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (fifo8_is_empty(&amp;s-&gt;tx_fifo)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (ot_uart_is_sys_loopack_enabled(s)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* system loopback mode, just forward to =
RX FIFO */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t count =3D fifo8_num_used(&amp;s-=
&gt;tx_fifo);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 buf =3D fifo8_pop_bufptr(&amp;s-&gt;tx_fi=
fo, count, &amp;size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ot_uart_receive(s, buf, (int)size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 count -=3D size;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* there may be more data to send if=
 data wraps around the end of TX<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* FIFO<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (count) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf =3D fifo8_pop_bufptr(&a=
mp;s-&gt;tx_fifo, count, &amp;size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ot_uart_receive(s, buf, (in=
t)size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* instant drain the fifo when there&#39;=
s no back-end */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!qemu_chr_fe_backend_connected(&amp;s=
-&gt;chr)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ot_uart_reset_tx_fifo(s);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ot_uart_update_irqs(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* get a continuous buffer from the FIFO =
*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 buf =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fifo8_peek_bufptr(&amp;s-&g=
t;tx_fifo, fifo8_num_used(&amp;s-&gt;tx_fifo), &amp;size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* send as much as possible */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D qemu_chr_fe_write(&amp;s-&gt;chr,=
 buf, (int)size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* if some characters where sent, remove =
them from the FIFO */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &gt;=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fifo8_drop(&amp;s-&gt;tx_fi=
fo, ret);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* update INTR_STATE */<br>
&gt; +=C2=A0 =C2=A0 if (fifo8_is_empty(&amp;s-&gt;tx_fifo)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[R_INTR_STATE] |=3D INTR_TX_EMP=
TY_MASK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[R_INTR_STATE] |=3D INTR_TX_DON=
E_MASK;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;tx_watermark_level &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fifo8_num_used(&amp;s-&gt;tx_fifo) &lt; s=
-&gt;tx_watermark_level) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[R_INTR_STATE] |=3D INTR_TX_WAT=
ERMARK_MASK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;tx_watermark_level =3D 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ot_uart_update_irqs(s);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static gboolean ot_uart_watch_cb(void *do_not_use, GIOCondition cond,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 OtUARTState *s =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 (void)do_not_use;<br>
&gt; +=C2=A0 =C2=A0 (void)cond;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;watch_tag =3D 0;<br>
&gt; +=C2=A0 =C2=A0 ot_uart_xmit(s);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return FALSE;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void uart_write_tx_fifo(OtUARTState *s, uint8_t val)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (fifo8_is_full(&amp;s-&gt;tx_fifo)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;ot_u=
art: TX FIFO overflow&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 fifo8_push(&amp;s-&gt;tx_fifo, val);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;tx_watermark_level =3D ot_uart_get_tx_watermark_l=
evel(s);<br>
&gt; +=C2=A0 =C2=A0 if (fifo8_num_used(&amp;s-&gt;tx_fifo) &lt; s-&gt;tx_wa=
termark_level) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* TX watermark interrupt is raised =
when FIFO depth goes from above<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* watermark to below. If we haven&#=
39;t reached watermark, reset cached<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* watermark level<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;tx_watermark_level =3D 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (ot_uart_is_tx_enabled(s)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ot_uart_xmit(s);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void ot_uart_clock_input(void *opaque, int irq, int level)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 OtUARTState *s =3D opaque;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 g_assert(irq =3D=3D 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;pclk =3D (unsigned)level;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* TODO: disable UART transfer when PCLK is 0 */<br>
&gt; +=C2=A0 =C2=A0 ot_uart_check_baudrate(s);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static uint64_t ot_uart_read(void *opaque, hwaddr addr, unsigned size=
)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 OtUARTState *s =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 (void)size;<br>
&gt;<br>
&gt; Not sure this is required<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 uint32_t val32;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 hwaddr reg =3D R32_OFF(addr);<br>
&gt; +=C2=A0 =C2=A0 switch (reg) {<br>
&gt; +=C2=A0 =C2=A0 case R_INTR_STATE:<br>
&gt; +=C2=A0 =C2=A0 case R_INTR_ENABLE:<br>
&gt; +=C2=A0 =C2=A0 case R_CTRL:<br>
&gt; +=C2=A0 =C2=A0 case R_FIFO_CTRL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val32 =3D s-&gt;regs[reg];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case R_STATUS:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* assume that UART always report RXIDLE =
*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val32 =3D R_STATUS_RXIDLE_MASK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* report RXEMPTY or RXFULL */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (fifo8_num_used(&amp;s-&gt;rx_fifo=
)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val32 |=3D R_STATUS_RXEMPTY=
_MASK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case OT_UART_RX_FIFO_SIZE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val32 |=3D R_STATUS_RXFULL_=
MASK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* report TXEMPTY+TXIDLE or TXFULL */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (fifo8_num_used(&amp;s-&gt;tx_fifo=
)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val32 |=3D R_STATUS_TXEMPTY=
_MASK | R_STATUS_TXIDLE_MASK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case OT_UART_TX_FIFO_SIZE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val32 |=3D R_STATUS_TXFULL_=
MASK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ot_uart_is_tx_enabled(s)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val32 |=3D R_STATUS_TXIDLE_=
MASK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ot_uart_is_rx_enabled(s)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val32 |=3D R_STATUS_RXIDLE_=
MASK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case R_RDATA:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val32 =3D (uint32_t)ot_uart_read_rx_fifo(=
s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case R_FIFO_STATUS:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val32 =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (fifo8_num_used(&amp;s-&gt;=
rx_fifo) &amp; 0xffu) &lt;&lt; R_FIFO_STATUS_RXLVL_SHIFT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val32 |=3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (fifo8_num_used(&amp;s-&gt;=
tx_fifo) &amp; 0xffu) &lt;&lt; R_FIFO_STATUS_TXLVL_SHIFT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case R_VAL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* This is not trivially implemented=
 due to the QEMU UART<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* interface. There is no way to rel=
iably sample or oversample<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* given our emulated interface, but=
 some software might poll the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* value of this register to determi=
ne break conditions.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* As such, default to reporting 16 =
of the last sample received<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* instead. This defaults to 16 idle=
 high samples (as a stop bit is<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* always the last received), except=
 for when the `oversample-break`<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* property is set and a break condi=
tion is received over UART RX,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* where we then show 16 low samples=
 until the next valid UART<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* transmission is received (or brea=
k is toggled off with the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* `toggle-break` property enabled).=
 This will not be accurate, but<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* should be sufficient to support b=
asic software flows that<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* essentially use UART break as a s=
trapping mechanism.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val32 =3D (s-&gt;in_break &amp;&amp; s-&g=
t;oversample_break) ? 0u : UINT16_MAX;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &quot;%s: VAL on=
ly shows idle%s\n&quot;, __func__,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 (s-&gt;oversample_break ? &quot;/break&quot; : &quot;&quot;));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case R_OVRD:<br>
&gt; +=C2=A0 =C2=A0 case R_TIMEOUT_CTRL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val32 =3D s-&gt;regs[reg];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &quot;%s: %s is =
not supported\n&quot;, __func__,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 REG_NAME(reg));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case R_ALERT_TEST:<br>
&gt; +=C2=A0 =C2=A0 case R_INTR_TEST:<br>
&gt; +=C2=A0 =C2=A0 case R_WDATA:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: =
W/O register 0x%02x (%s)\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __func__, (uint32_t)addr, REG_NAME(reg));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val32 =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: =
Bad offset 0x%02x\n&quot;, __func__,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 (uint32_t)addr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val32 =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint32_t pc =3D current_cpu-&gt;cc-&gt;get_pc(current_c=
pu);<br>
&gt; +=C2=A0 =C2=A0 trace_ot_uart_io_read_out(s-&gt;ot_id, (uint32_t)addr, =
REG_NAME(reg), val32,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pc);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return (uint64_t)val32;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void ot_uart_write(void *opaque, hwaddr addr, uint64_t val64,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 unsigned size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 OtUARTState *s =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 (void)size;<br>
&gt; +=C2=A0 =C2=A0 uint32_t val32 =3D val64;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 hwaddr reg =3D R32_OFF(addr);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint32_t pc =3D current_cpu-&gt;cc-&gt;get_pc(current_c=
pu);<br>
&gt; +=C2=A0 =C2=A0 trace_ot_uart_io_write(s-&gt;ot_id, (uint32_t)addr, REG=
_NAME(reg), val32, pc);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (reg) {<br>
&gt; +=C2=A0 =C2=A0 case R_INTR_STATE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val32 &amp;=3D INTR_MASK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[R_INTR_STATE] &amp;=3D ~val32;=
 /* RW1C */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ot_uart_update_irqs(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case R_INTR_ENABLE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val32 &amp;=3D INTR_MASK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[R_INTR_ENABLE] =3D val32;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ot_uart_update_irqs(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case R_INTR_TEST:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val32 &amp;=3D INTR_MASK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[R_INTR_STATE] |=3D val32;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ot_uart_update_irqs(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case R_ALERT_TEST:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val32 &amp;=3D R_ALERT_TEST_FATAL_FAULT_M=
ASK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[reg] =3D val32;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* This will also set an IRQ once the ale=
rt handler is added */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case R_CTRL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (val32 &amp; ~CTRL_SUP_MASK) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &quot;%s: UART_CTRL feature not supported: 0x%08x\n&q=
uot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 __func__, val32 &amp; ~CTRL_SUP_MASK);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t prev =3D s-&gt;regs[R_CTRL];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[R_CTRL] =3D val32 &amp; CTRL_M=
ASK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t change =3D prev ^ s-&gt;regs[R_C=
TRL];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (change &amp; R_CTRL_NCO_MASK) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ot_uart_check_baudrate(s);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((change &amp; R_CTRL_RX_MASK) &amp;&a=
mp; ot_uart_is_rx_enabled(s) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !ot_uart_is_sys_loopack_ena=
bled(s)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_chr_fe_accept_input(&a=
mp;s-&gt;chr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((change &amp; R_CTRL_TX_MASK) &amp;&a=
mp; ot_uart_is_tx_enabled(s)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* try sending pending data=
 from TX FIFO if any */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ot_uart_xmit(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case R_WDATA:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uart_write_tx_fifo(s, (uint8_t)(val32 &am=
p; R_WDATA_WDATA_MASK));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case R_FIFO_CTRL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[R_FIFO_CTRL] =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val32 &amp; (R_FIFO_CTRL_RX=
ILVL_MASK | R_FIFO_CTRL_TXILVL_MASK);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (val32 &amp; R_FIFO_CTRL_RXRST_MASK) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ot_uart_reset_rx_fifo(s);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ot_uart_update_irqs(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (val32 &amp; R_FIFO_CTRL_TXRST_MASK) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ot_uart_reset_tx_fifo(s);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ot_uart_update_irqs(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case R_OVRD:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (val32 &amp; R_OVRD_TXEN_MASK) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &q=
uot;%s: OVRD.TXEN is not supported\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 __func__);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[R_OVRD] =3D val32 &amp; R_OVRD=
_TXVAL_MASK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case R_TIMEOUT_CTRL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[R_TIMEOUT_CTRL] =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val32 &amp; (R_TIMEOUT_CTRL=
_EN_MASK | R_TIMEOUT_CTRL_VAL_MASK);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case R_STATUS:<br>
&gt; +=C2=A0 =C2=A0 case R_RDATA:<br>
&gt; +=C2=A0 =C2=A0 case R_FIFO_STATUS:<br>
&gt; +=C2=A0 =C2=A0 case R_VAL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: =
R/O register 0x%02x (%s)\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __func__, (uint32_t)addr, REG_NAME(reg));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: =
Bad offset 0x%02x\n&quot;, __func__,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 (uint32_t)addr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const MemoryRegionOps ot_uart_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 .read =3D ot_uart_read,<br>
&gt; +=C2=A0 =C2=A0 .write =3D ot_uart_write,<br>
&gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_LITTLE_ENDIAN,<br>
&gt; +=C2=A0 =C2=A0 .impl.min_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 .impl.max_access_size =3D 4,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const Property ot_uart_properties[] =3D {<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_STRING(&quot;ot-id&quot;, OtUARTState, ot_i=
d),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_CHR(&quot;chardev&quot;, OtUARTState, chr),=
<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_BOOL(&quot;oversample-break&quot;, OtUARTSt=
ate, oversample_break, false),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_BOOL(&quot;toggle-break&quot;, OtUARTState,=
 toggle_break, false),<br>
&gt; +};<br>
&gt; +<br>
&gt; +static int ot_uart_be_change(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 OtUARTState *s =3D opaque;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_chr_fe_set_handlers(&amp;s-&gt;chr, ot_uart_can_re=
ceive, ot_uart_receive,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ot_uart_event_handler, ot_uart_be_change=
, s, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0true);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;watch_tag &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_source_remove(s-&gt;watch_tag);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* NOLINTNEXTLINE(clang-analyzer-optin.co=
re.EnumCastOutOfRange) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;watch_tag =3D qemu_chr_fe_add_watch=
(&amp;s-&gt;chr, G_IO_OUT | G_IO_HUP,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0ot_uart_watch_cb, s);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void ot_uart_reset_enter(Object *obj, ResetType type)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 OtUARTClass *c =3D OT_UART_GET_CLASS(obj);<br>
&gt; +=C2=A0 =C2=A0 OtUARTState *s =3D OT_UART(obj);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (c-&gt;parent_phases.enter) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;parent_phases.enter(obj, type);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memset(&amp;s-&gt;regs[0], 0, sizeof(s-&gt;regs));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;tx_watermark_level =3D 0;<br>
&gt; +=C2=A0 =C2=A0 for (unsigned index =3D 0; index &lt; ARRAY_SIZE(s-&gt;=
irqs); index++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq(s-&gt;irqs[index], 0);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 ot_uart_reset_tx_fifo(s);<br>
&gt; +=C2=A0 =C2=A0 ot_uart_reset_rx_fifo(s);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* do not reset `s-&gt;in_break`, as that tracks w=
hether we are currently<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* receiving a break condition over UART RX from s=
ome device talking<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* to OpenTitan, which should survive resets. The =
QEMU CharDev only<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* supports transient break events and not the not=
ion of holding the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* UART in break, so remembering breaks like this =
is required to<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* support mocking of break conditions in the over=
sampled `VAL` reg.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;in_break) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ignore CTRL.RXBLVL as we have no notio=
n of break &quot;time&quot; */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[R_INTR_STATE] |=3D INTR_RX_BRE=
AK_ERR_MASK;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ot_uart_update_irqs(s);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void ot_uart_realize(DeviceState *dev, Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 OtUARTState *s =3D OT_UART(dev);<br>
&gt; +=C2=A0 =C2=A0 (void)errp;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 g_assert(s-&gt;ot_id);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qdev_init_gpio_in_named(DEVICE(s), &amp;ot_uart_clock_i=
nput, &quot;clock-in&quot;, 1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 fifo8_create(&amp;s-&gt;tx_fifo, OT_UART_TX_FIFO_SIZE);=
<br>
&gt; +=C2=A0 =C2=A0 fifo8_create(&amp;s-&gt;rx_fifo, OT_UART_RX_FIFO_SIZE);=
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_chr_fe_set_handlers(&amp;s-&gt;chr, ot_uart_can_re=
ceive, ot_uart_receive,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ot_uart_event_handler, ot_uart_be_change=
, s, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0true);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void ot_uart_init(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 OtUARTState *s =3D OT_UART(obj);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (unsigned index =3D 0; index &lt; OT_UART_IRQ_NUM; =
index++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_init_irq(SYS_BUS_DEVICE(obj), &amp=
;s-&gt;irqs[index]);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;mmio, obj, &amp;ot_uar=
t_ops, s, TYPE_OT_UART,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 REGS_SIZE);<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_mmio(SYS_BUS_DEVICE(obj), &amp;s-&gt;mmio);=
<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void ot_uart_class_init(ObjectClass *klass, const void *data)<=
br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
&gt; +=C2=A0 =C2=A0 (void)data;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;realize =3D ot_uart_realize;<br>
&gt; +=C2=A0 =C2=A0 device_class_set_props(dc, ot_uart_properties);<br>
&gt; +=C2=A0 =C2=A0 set_bit(DEVICE_CATEGORY_INPUT, dc-&gt;categories);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ResettableClass *rc =3D RESETTABLE_CLASS(klass);<br>
&gt; +=C2=A0 =C2=A0 OtUARTClass *uc =3D OT_UART_CLASS(klass);<br>
&gt; +=C2=A0 =C2=A0 resettable_class_set_parent_phases(rc, &amp;ot_uart_res=
et_enter, NULL, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;=
uc-&gt;parent_phases);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const TypeInfo ot_uart_info =3D {<br>
&gt; +=C2=A0 =C2=A0 .name =3D TYPE_OT_UART,<br>
&gt; +=C2=A0 =C2=A0 .parent =3D TYPE_SYS_BUS_DEVICE,<br>
&gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(OtUARTState),<br>
&gt; +=C2=A0 =C2=A0 .instance_init =3D ot_uart_init,<br>
&gt; +=C2=A0 =C2=A0 .class_size =3D sizeof(OtUARTClass),<br>
&gt; +=C2=A0 =C2=A0 .class_init =3D ot_uart_class_init,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void ot_uart_register_types(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;ot_uart_info);<br>
&gt; +}<br>
&gt; +<br>
&gt; +type_init(ot_uart_register_types);<br>
&gt; diff --git a/hw/char/trace-events b/hw/char/trace-events<br>
&gt; index a3fcc77287..c859d8af4e 100644<br>
&gt; --- a/hw/char/trace-events<br>
&gt; +++ b/hw/char/trace-events<br>
&gt; @@ -141,3 +141,11 @@ stm32f2xx_usart_receive(char *id, uint8_t chr) &q=
uot; %s receiving &#39;%c&#39;&quot;<br>
&gt;=C2=A0 # riscv_htif.c<br>
&gt;=C2=A0 htif_uart_write_to_host(uint8_t device, uint8_t cmd, uint64_t pa=
yload) &quot;device: %u cmd: %02u payload: %016&quot; PRIx64<br>
&gt;=C2=A0 htif_uart_unknown_device_command(uint8_t device, uint8_t cmd, ui=
nt64_t payload) &quot;device: %u cmd: %02u payload: %016&quot; PRIx64<br>
&gt; +<br>
&gt; +# ot_uart.c<br>
&gt; +ot_uart_check_baudrate(const char *id, unsigned pclk, unsigned baud) =
&quot;%s: @ %u Hz: %u bps&quot;<br>
&gt; +ot_uart_connect_input_clock(const char *id, const char * srcname) &qu=
ot;%s: %s&quot;<br>
&gt; +ot_uart_debug(const char *id, const char *msg) &quot;%s: %s&quot;<br>
&gt; +ot_uart_io_read_out(const char *id, uint32_t addr, const char *regnam=
e, uint32_t val, uint32_t pc) &quot;%s: addr=3D0x%02x (%s), val=3D0x%x, pc=
=3D0x%x&quot;<br>
&gt; +ot_uart_io_write(const char *id, uint32_t addr, const char *regname, =
uint32_t val, uint32_t pc) &quot;%s: addr=3D0x%02x (%s), val=3D0x%x, pc=3D0=
x%x&quot;<br>
&gt; +ot_uart_irqs(const char *id, uint32_t active, uint32_t mask, uint32_t=
 eff) &quot;%s: act:0x%08x msk:0x%08x eff:0x%08x&quot;<br>
&gt; diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c<br>
&gt; index 309125e854..163d3ac3d3 100644<br>
&gt; --- a/hw/riscv/opentitan.c<br>
&gt; +++ b/hw/riscv/opentitan.c<br>
&gt; @@ -132,7 +132,8 @@ static void lowrisc_ibex_soc_init(Object *obj)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 object_initialize_child(obj, &quot;plic&quot;, &am=
p;s-&gt;plic, TYPE_SIFIVE_PLIC);<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 object_initialize_child(obj, &quot;uart&quot;, &amp;s-&=
gt;uart, TYPE_IBEX_UART);<br>
&gt; +=C2=A0 =C2=A0 object_initialize_child(obj, &quot;uart&quot;, &amp;s-&=
gt;uart, TYPE_OT_UART);<br>
&gt; +=C2=A0 =C2=A0 object_property_set_str(OBJECT(&amp;s-&gt;uart), &quot;=
ot-id&quot;, &quot;uart0&quot;, &amp;error_fatal);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 object_initialize_child(obj, &quot;timer&quot;, &a=
mp;s-&gt;timer, TYPE_IBEX_TIMER);<br>
&gt;<br>
&gt; diff --git a/include/hw/char/ibex_uart.h b/include/hw/char/ibex_uart.h=
<br>
&gt; deleted file mode 100644<br>
&gt; index 882796e0c6..0000000000<br>
&gt; --- a/include/hw/char/ibex_uart.h<br>
&gt; +++ /dev/null<br>
&gt; @@ -1,73 +0,0 @@<br>
&gt; -/*<br>
&gt; - * QEMU lowRISC Ibex UART device<br>
&gt; - *<br>
&gt; - * Copyright (c) 2020 Western Digital<br>
&gt; - *<br>
&gt; - * Permission is hereby granted, free of charge, to any person obtain=
ing a copy<br>
&gt; - * of this software and associated documentation files (the &quot;Sof=
tware&quot;), to deal<br>
&gt; - * in the Software without restriction, including without limitation =
the rights<br>
&gt; - * to use, copy, modify, merge, publish, distribute, sublicense, and/=
or sell<br>
&gt; - * copies of the Software, and to permit persons to whom the Software=
 is<br>
&gt; - * furnished to do so, subject to the following conditions:<br>
&gt; - *<br>
&gt; - * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; - * all copies or substantial portions of the Software.<br>
&gt; - *<br>
&gt; - * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT =
SHALL<br>
&gt; - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES =
OR OTHER<br>
&gt; - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, AR=
ISING FROM,<br>
&gt; - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEAL=
INGS IN<br>
&gt; - * THE SOFTWARE.<br>
&gt; - */<br>
&gt; -<br>
&gt; -#ifndef HW_IBEX_UART_H<br>
&gt; -#define HW_IBEX_UART_H<br>
&gt; -<br>
&gt; -#include &quot;hw/core/sysbus.h&quot;<br>
&gt; -#include &quot;chardev/char-fe.h&quot;<br>
&gt; -#include &quot;qemu/timer.h&quot;<br>
&gt; -#include &quot;qom/object.h&quot;<br>
&gt; -<br>
&gt; -#define IBEX_UART_TX_FIFO_SIZE 16<br>
&gt; -#define IBEX_UART_CLOCK 50000000 /* 50MHz clock */<br>
&gt; -<br>
&gt; -#define TYPE_IBEX_UART &quot;ibex-uart&quot;<br>
&gt; -OBJECT_DECLARE_SIMPLE_TYPE(IbexUartState, IBEX_UART)<br>
&gt; -<br>
&gt; -struct IbexUartState {<br>
&gt; -=C2=A0 =C2=A0 /* &lt;private&gt; */<br>
&gt; -=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 /* &lt;public&gt; */<br>
&gt; -=C2=A0 =C2=A0 MemoryRegion mmio;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 uint8_t tx_fifo[IBEX_UART_TX_FIFO_SIZE];<br>
&gt; -=C2=A0 =C2=A0 uint32_t tx_level;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 uint32_t rx_level;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 QEMUTimer *fifo_trigger_handle;<br>
&gt; -=C2=A0 =C2=A0 uint64_t char_tx_time;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 uint32_t uart_intr_state;<br>
&gt; -=C2=A0 =C2=A0 uint32_t uart_intr_enable;<br>
&gt; -=C2=A0 =C2=A0 uint32_t uart_ctrl;<br>
&gt; -=C2=A0 =C2=A0 uint32_t uart_status;<br>
&gt; -=C2=A0 =C2=A0 uint32_t uart_rdata;<br>
&gt; -=C2=A0 =C2=A0 uint32_t uart_fifo_ctrl;<br>
&gt; -=C2=A0 =C2=A0 uint32_t uart_fifo_status;<br>
&gt; -=C2=A0 =C2=A0 uint32_t uart_ovrd;<br>
&gt; -=C2=A0 =C2=A0 uint32_t uart_val;<br>
&gt; -=C2=A0 =C2=A0 uint32_t uart_timeout_ctrl;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 Clock *f_clk;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 CharFrontend chr;<br>
&gt; -=C2=A0 =C2=A0 qemu_irq tx_watermark;<br>
&gt; -=C2=A0 =C2=A0 qemu_irq rx_watermark;<br>
&gt; -=C2=A0 =C2=A0 qemu_irq tx_empty;<br>
&gt; -=C2=A0 =C2=A0 qemu_irq rx_overflow;<br>
&gt; -};<br>
&gt; -#endif /* HW_IBEX_UART_H */<br>
&gt; diff --git a/include/hw/char/ot_uart.h b/include/hw/char/ot_uart.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..45ec3fc7c2<br>
&gt; --- /dev/null<br>
&gt; +++ b/include/hw/char/ot_uart.h<br>
&gt; @@ -0,0 +1,133 @@<br>
&gt; +/*<br>
&gt; + * QEMU OpenTitan UART device<br>
&gt; + *<br>
&gt; + * Copyright (c) 2022-2025 Rivos, Inc.<br>
&gt; + *<br>
&gt; + * Author(s):<br>
&gt; + *=C2=A0 Lo=C3=AFc Lefort &lt;<a href=3D"mailto:loic@rivosinc.com" ta=
rget=3D"_blank" rel=3D"noreferrer">loic@rivosinc.com</a>&gt;<br>
&gt; + *<br>
&gt; + * SPDX-License-Identifier: MIT<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef HW_OPENTITAN_OT_UART_H<br>
&gt; +#define HW_OPENTITAN_OT_UART_H<br>
&gt; +<br>
&gt; +#include &quot;qemu/fifo8.h&quot;<br>
&gt; +#include &quot;chardev/char-fe.h&quot;<br>
&gt; +#include &quot;hw/core/sysbus.h&quot;<br>
&gt; +#include &quot;qom/object.h&quot;<br>
&gt; +#include &quot;hw/core/registerfields.h&quot;<br>
&gt; +<br>
&gt; +#define TYPE_OT_UART &quot;ot-uart&quot;<br>
&gt; +OBJECT_DECLARE_TYPE(OtUARTState, OtUARTClass, OT_UART)<br>
&gt; +<br>
&gt; +/* clang-format off */<br>
&gt; +REG32(INTR_STATE, 0x00u)<br>
&gt; +=C2=A0 =C2=A0 SHARED_FIELD(INTR_TX_WATERMARK, 0u, 1u)<br>
&gt; +=C2=A0 =C2=A0 SHARED_FIELD(INTR_RX_WATERMARK, 1u, 1u)<br>
&gt; +=C2=A0 =C2=A0 SHARED_FIELD(INTR_TX_DONE, 2u, 1u)<br>
&gt; +=C2=A0 =C2=A0 SHARED_FIELD(INTR_RX_OVERFLOW, 3u, 1u)<br>
&gt; +=C2=A0 =C2=A0 SHARED_FIELD(INTR_RX_FRAME_ERR, 4u, 1u)<br>
&gt; +=C2=A0 =C2=A0 SHARED_FIELD(INTR_RX_BREAK_ERR, 5u, 1u)<br>
&gt; +=C2=A0 =C2=A0 SHARED_FIELD(INTR_RX_TIMEOUT, 6u, 1u)<br>
&gt; +=C2=A0 =C2=A0 SHARED_FIELD(INTR_RX_PARITY_ERR, 7u, 1u)<br>
&gt; +=C2=A0 =C2=A0 SHARED_FIELD(INTR_TX_EMPTY, 8u, 1u)<br>
&gt; +REG32(INTR_ENABLE, 0x04u)<br>
&gt; +REG32(INTR_TEST, 0x08u)<br>
&gt; +REG32(ALERT_TEST, 0x0cu)<br>
&gt; +=C2=A0 =C2=A0 FIELD(ALERT_TEST, FATAL_FAULT, 0u, 1u)<br>
&gt; +REG32(CTRL, 0x10u)<br>
&gt; +=C2=A0 =C2=A0 FIELD(CTRL, TX, 0u, 1u)<br>
&gt; +=C2=A0 =C2=A0 FIELD(CTRL, RX, 1u, 1u)<br>
&gt; +=C2=A0 =C2=A0 FIELD(CTRL, NF, 2u, 1u)<br>
&gt; +=C2=A0 =C2=A0 FIELD(CTRL, SLPBK, 4u, 1u)<br>
&gt; +=C2=A0 =C2=A0 FIELD(CTRL, LLPBK, 5u, 1u)<br>
&gt; +=C2=A0 =C2=A0 FIELD(CTRL, PARITY_EN, 6u, 1u)<br>
&gt; +=C2=A0 =C2=A0 FIELD(CTRL, PARITY_ODD, 7u, 1u)<br>
&gt; +=C2=A0 =C2=A0 FIELD(CTRL, RXBLVL, 8u, 2u)<br>
&gt; +=C2=A0 =C2=A0 FIELD(CTRL, NCO, 16u, 16u)<br>
&gt; +REG32(STATUS, 0x14u)<br>
&gt; +=C2=A0 =C2=A0 FIELD(STATUS, TXFULL, 0u, 1u)<br>
&gt; +=C2=A0 =C2=A0 FIELD(STATUS, RXFULL, 1u, 1u)<br>
&gt; +=C2=A0 =C2=A0 FIELD(STATUS, TXEMPTY, 2u, 1u)<br>
&gt; +=C2=A0 =C2=A0 FIELD(STATUS, TXIDLE, 3u, 1u)<br>
&gt; +=C2=A0 =C2=A0 FIELD(STATUS, RXIDLE, 4u, 1u)<br>
&gt; +=C2=A0 =C2=A0 FIELD(STATUS, RXEMPTY, 5u, 1u)<br>
&gt; +REG32(RDATA, 0x18u)<br>
&gt; +=C2=A0 =C2=A0 FIELD(RDATA, RDATA, 0u, 8u)<br>
&gt; +REG32(WDATA, 0x1cu)<br>
&gt; +=C2=A0 =C2=A0 FIELD(WDATA, WDATA, 0u, 8u)<br>
&gt; +REG32(FIFO_CTRL, 0x20u)<br>
&gt; +=C2=A0 =C2=A0 FIELD(FIFO_CTRL, RXRST, 0u, 1u)<br>
&gt; +=C2=A0 =C2=A0 FIELD(FIFO_CTRL, TXRST, 1u, 1u)<br>
&gt; +=C2=A0 =C2=A0 FIELD(FIFO_CTRL, RXILVL, 2u, 3u)<br>
&gt; +=C2=A0 =C2=A0 FIELD(FIFO_CTRL, TXILVL, 5u, 3u)<br>
&gt; +REG32(FIFO_STATUS, 0x24u)<br>
&gt; +=C2=A0 =C2=A0 FIELD(FIFO_STATUS, TXLVL, 0u, 8u)<br>
&gt; +=C2=A0 =C2=A0 FIELD(FIFO_STATUS, RXLVL, 16u, 8u)<br>
&gt; +REG32(OVRD, 0x28u)<br>
&gt; +=C2=A0 =C2=A0 FIELD(OVRD, TXEN, 0u, 1u)<br>
&gt; +=C2=A0 =C2=A0 FIELD(OVRD, TXVAL, 1u, 1u)<br>
&gt; +REG32(VAL, 0x2cu)<br>
&gt; +=C2=A0 =C2=A0 FIELD(VAL, RX, 0u, 16u)<br>
&gt; +REG32(TIMEOUT_CTRL, 0x30u)<br>
&gt; +=C2=A0 =C2=A0 FIELD(TIMEOUT_CTRL, VAL, 0u, 24)<br>
&gt; +=C2=A0 =C2=A0 FIELD(TIMEOUT_CTRL, EN, 31u, 1u)<br>
&gt; +/* clang-format on */<br>
&gt;<br>
&gt; These shouldn&#39;t need to be public<br>
&gt;<br>
&gt; agreed. They are here because the struct definition below uses REGS_CO=
UNT which is computed based on these definitions. I can hard-code the lengt=
h of 13 instead? It looks like other hardware blocks also hard-code this, i=
s there some way to at least catch the error if this stops being self-consi=
stent?<br>
<br>
Yeah, everyone else just hard codes a length or defines each register<br>
as a u32/u64.<br>
<br>
Good question about an assert. You could do a runtime assert in the<br>
init() function. The BSD user headers also use `_Static_assert()` [1],<br>
so that should be an option. I haven&#39;t checked that all supported<br>
compilers support _Static_assert though<br>
<br>
1: <a href=3D"https://en.cppreference.com/w/c/language/_Static_assert.html"=
 rel=3D"noreferrer noreferrer" target=3D"_blank">https://en.cppreference.co=
m/w/c/language/_Static_assert.html</a><br>
<br>
Alistair<br>
<br>
&gt;<br>
&gt; Alistair<br>
&gt;<br>
&gt; +<br>
&gt; +#define INTR_MASK \<br>
&gt; +=C2=A0 =C2=A0 (INTR_TX_WATERMARK_MASK | INTR_RX_WATERMARK_MASK | INTR=
_TX_DONE_MASK | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0INTR_RX_OVERFLOW_MASK | INTR_RX_FRAME_ERR_MASK | =
INTR_RX_BREAK_ERR_MASK | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0INTR_RX_TIMEOUT_MASK | INTR_RX_PARITY_ERR_MASK | =
INTR_TX_EMPTY_MASK)<br>
&gt; +<br>
&gt; +#define CTRL_MASK \<br>
&gt; +=C2=A0 =C2=A0 (R_CTRL_TX_MASK | R_CTRL_RX_MASK | R_CTRL_NF_MASK | R_C=
TRL_SLPBK_MASK | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0R_CTRL_LLPBK_MASK | R_CTRL_PARITY_EN_MASK | R_CTR=
L_PARITY_ODD_MASK | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0R_CTRL_RXBLVL_MASK | R_CTRL_NCO_MASK)<br>
&gt; +<br>
&gt; +#define CTRL_SUP_MASK \<br>
&gt; +=C2=A0 =C2=A0 (R_CTRL_RX_MASK | R_CTRL_TX_MASK | R_CTRL_SLPBK_MASK | =
R_CTRL_NCO_MASK)<br>
&gt; +<br>
&gt; +#define OT_UART_NCO_BITS=C2=A0 =C2=A0 =C2=A016u<br>
&gt; +#define OT_UART_TX_FIFO_SIZE 128u<br>
&gt; +#define OT_UART_RX_FIFO_SIZE 128u<br>
&gt; +#define OT_UART_IRQ_NUM=C2=A0 =C2=A0 =C2=A0 9u<br>
&gt; +<br>
&gt; +#define R32_OFF(_r_) ((_r_) / sizeof(uint32_t))<br>
&gt; +<br>
&gt; +#define R_LAST_REG (R_TIMEOUT_CTRL)<br>
&gt; +#define REGS_COUNT (R_LAST_REG + 1u)<br>
&gt; +#define REGS_SIZE=C2=A0 (REGS_COUNT * sizeof(uint32_t))<br>
&gt; +#define REG_NAME(_reg_) \<br>
&gt; +=C2=A0 =C2=A0 ((((_reg_) &lt; REGS_COUNT) &amp;&amp; REG_NAMES[_reg_]=
) ? REG_NAMES[_reg_] : &quot;?&quot;)<br>
&gt; +<br>
&gt; +struct OtUARTState {<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion mmio;<br>
&gt; +=C2=A0 =C2=A0 qemu_irq irqs[OT_UART_IRQ_NUM];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint32_t regs[REGS_COUNT];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 Fifo8 tx_fifo;<br>
&gt; +=C2=A0 =C2=A0 Fifo8 rx_fifo;<br>
&gt; +=C2=A0 =C2=A0 uint32_t tx_watermark_level;<br>
&gt; +=C2=A0 =C2=A0 bool in_break;<br>
&gt; +=C2=A0 =C2=A0 guint watch_tag;<br>
&gt; +=C2=A0 =C2=A0 unsigned pclk; /* Current input clock */<br>
&gt; +=C2=A0 =C2=A0 const char *clock_src_name; /* IRQ name once connected =
*/<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 char *ot_id;<br>
&gt; +=C2=A0 =C2=A0 char *clock_name;<br>
&gt; +=C2=A0 =C2=A0 DeviceState *clock_src;<br>
&gt; +=C2=A0 =C2=A0 CharFrontend chr;<br>
&gt; +=C2=A0 =C2=A0 bool oversample_break; /* Should mock break in the over=
sampled VAL reg? */<br>
&gt; +=C2=A0 =C2=A0 bool toggle_break; /* Are incoming breaks temporary or =
toggled? */<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct OtUARTClass {<br>
&gt; +=C2=A0 =C2=A0 SysBusDeviceClass parent_class;<br>
&gt; +=C2=A0 =C2=A0 ResettablePhases parent_phases;<br>
&gt; +};<br>
&gt; +<br>
&gt; +#endif /* HW_OPENTITAN_OT_UART_H */<br>
&gt; diff --git a/include/hw/riscv/opentitan.h b/include/hw/riscv/opentitan=
.h<br>
&gt; index 5b9016e1d8..f2b4bf3814 100644<br>
&gt; --- a/include/hw/riscv/opentitan.h<br>
&gt; +++ b/include/hw/riscv/opentitan.h<br>
&gt; @@ -21,7 +21,7 @@<br>
&gt;<br>
&gt;=C2=A0 #include &quot;hw/riscv/riscv_hart.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/intc/sifive_plic.h&quot;<br>
&gt; -#include &quot;hw/char/ibex_uart.h&quot;<br>
&gt; +#include &quot;hw/char/ot_uart.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/timer/ibex_timer.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/ssi/ibex_spi_host.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/core/boards.h&quot;<br>
&gt; @@ -43,7 +43,7 @@ struct LowRISCIbexSoCState {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 RISCVHartArrayState cpus;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 SiFivePLICState plic;<br>
&gt; -=C2=A0 =C2=A0 IbexUartState uart;<br>
&gt; +=C2=A0 =C2=A0 OtUARTState uart;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 IbexTimerState timer;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 IbexSPIHostState spi_host[OPENTITAN_NUM_SPI_HOSTS]=
;<br>
&gt;<br>
&gt; --<br>
&gt; 2.49.1<br>
&gt;<br>
&gt; --<br>
&gt; Lex Bailey (they/them)<br>
&gt; lowRISC C.I.C. 7 Hills Road, Cambridge, CB2 1GE, UK. Registered in Eng=
land &amp; Wales 09272283 <a href=3D"mailto:lex.bailey@lowrisc.org" target=
=3D"_blank" rel=3D"noreferrer">lex.bailey@lowrisc.org</a><br>
<br>
</blockquote></div>

--000000000000af09d1064e5ea735--

