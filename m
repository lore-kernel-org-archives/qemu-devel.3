Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C98109B495
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 04:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7n8j-0005h8-Mo; Wed, 01 Apr 2026 00:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w7n8g-0005bK-Iv
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 00:25:10 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w7n8a-0003Tb-LB
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 00:25:09 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-66d24c6963bso1525857a12.1
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 21:25:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775017503; cv=none;
 d=google.com; s=arc-20240605;
 b=AXqkMA33bLCLxIfi5MdPgt/onzgMyyrQCaKdGrEQwP4aBZwzm23ls335MQI3VsWih8
 5NALlQ/jDOyk5w65QuIdsEoif+Cnx2SjWnlZae46id9UJBZBC7jWakQvQ3iCE2ZLBLeg
 GqnlG2aQjGQmTCO0yFDXCmo1L/1yNslSHR0C+D7a/YB9MF+o6zHAO8E/oQeYRoPSojkF
 r4CsL004fXvuE0f4NsbrmTz/4QYLjuLDBBQ5OKqZXzvPp6vmBN0H3huPdCo2XPhuKc9/
 8WtR/3FrBEsm1YN1AoKmCJZ3IhhAur1sgUB1W5ZARwFCrHPJsvsV8rvN3vexmoPwg5Vi
 afQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hZFy0aFoATD/8lkFQjm4L0o4gdkQgvUL6nLyIb6Mn0o=;
 fh=egRaiDTqNSt5KWhX45WeDD24Xw7veSIcJj7HCLxH6G8=;
 b=bnuNsOh2UoI+xrRQKiG/DUJc64Ar4hzhK5GsHhbOF/B4TWIVO/TIOPSkma2+xw+hcg
 lBpP0ndJ84OHThQvrZSymrfSloTNmwDp94HObhMYUY7d1EefByvNMgXabxglW1wy3XUD
 l3NVpoiuqqPhV4ASde+p7NZaF76ElqaT0VM3Qjto2FIDlAvAHbvCDZIwVXSeAnt3tcu4
 7GflBXa1jjA5b9YPQYlWbSE/Bl26VYGzPmau236Ha62KjdgEk15UkqORwsfZ4xxOaa3e
 GrVoziz67rzOx1pqcR9y1ihnBJZ2kbe5UBLzECxZ2leYYu4qfz2c3MZZ/jr8mTVpZfuA
 hvng==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775017503; x=1775622303; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hZFy0aFoATD/8lkFQjm4L0o4gdkQgvUL6nLyIb6Mn0o=;
 b=qSFPq80z3k1oJcTdkyQN8eXOwAuyPkpcBDX6fl1AfUR2QPohwW1rFHACUIJx0RcynJ
 OtMzbr8jKhEdXmssSVlbU813KKuRsAApn67GlYmmGaymOF4fAeSIWepSmQ+4ITxQNExq
 Mhly8b1B+9y4tQuNOM4QZMnSalDi92hC0V2AOPNSlX17aGvl/I7O2eQz3XjLg9byIvv7
 dN7LOvRasKMOjLNvMQZXLwRiHA4f8AsZUgc0035eo49bqAKBgPIc0laUnvE/l/ef0GVj
 cuanASaPuHx8bcPBrCqmHVLctli7niToCDYnaXCNCIDeCskKcUByW++ayo1fVcBG1S5u
 Ay6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775017503; x=1775622303;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hZFy0aFoATD/8lkFQjm4L0o4gdkQgvUL6nLyIb6Mn0o=;
 b=Ipmdxb3GUaJqF9NBMufmLaf2hO9w3OxFJeSI7S5r/p3FreOr5UqPs7oVc2LncnQ0Yt
 qkOEpPS5+BDQos8LnMPEzfLd9VRk+AoH5YYK7wTmgxWcwpdb2k4kExTUgQHxpsald9sk
 pcfzfGIRCHWBeKXfe6FGkmocanqJZZFkCtq+4ni98qNoxF0A2TYCMpto4F/VXh/xSwAq
 FkizK7IvbRSBwrOYJNhBc2TyxI9j8+TRPBrN92MZhqbUAFKyIi53xnUdPWARIHer1UzI
 AAjPDfgbIoF5BeTq1DzGuD8lMZADS0hHzgIiOAaJOkwvCyOANXe4tq9fKQJgY2f/O3CK
 t3NA==
X-Gm-Message-State: AOJu0YwrWHfPu/Yr/5nkSQmYR+ENollfcSObqUJpISfaZKz5ixFqF9+t
 IpPOAKyJMKkkHRGfLvIofy9Zm5tWB7GHOFCwGbJySsC6STRIKAJTVI/U3DTbJQf6cqnDnPBieQv
 h+LSPdd7NFPDEogW9bt8w5kUIHKWWzXg=
X-Gm-Gg: ATEYQzwO2uZsmOQMidnde3X9VQhsuY5VWox+ylNShwt2WdG1pbN0OazbVgjFYgtSrwP
 eduyjx+v3if4sRdV2MPjPwfVCRWB4WIBVk29u9EgsFLelML5CMlkrdnHQpAtgNVji5p6jJpqEkD
 ePPtFNM7sSGNrUJgOReMqXWsILL8bWfIjLz/Z3WmBWZkTgxHcRbka1ZUyjNZfwn5yLLKnNIqL1P
 gcon2DhUZbveSA49aexGj2clA+JaDeAy8D9iBQbW6WYrptISFIOBdlCbQBJR8Qw4A052lDR9cri
 hbKm5dQCzqLIeui33e8qMsDpoWRwtETiGWEqqLL2O+2qzFV2
X-Received: by 2002:a17:907:6ea8:b0:b98:4156:8787 with SMTP id
 a640c23a62f3a-b9c13cd1da8mr141660566b.49.1775017502352; Tue, 31 Mar 2026
 21:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <177393172713.10003.9577410064303581086-0@git.sr.ht>
 <177393172713.10003.9577410064303581086-1@git.sr.ht>
 <CAKmqyKP8dU0HdahMbi-XbjtuaPWW4y404GyYE--C1dTiY5dzgQ@mail.gmail.com>
 <4f21306c-e9a4-43cb-a201-4160b234faa0@lowrisc.org>
In-Reply-To: <4f21306c-e9a4-43cb-a201-4160b234faa0@lowrisc.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 1 Apr 2026 14:24:35 +1000
X-Gm-Features: AQROBzCs05sBd18WG5_TZOhj_iQU6jethwv_RLSRzuSlLrs3vnU20Yl7PVRjTxU
Message-ID: <CAKmqyKOQRvDUfzcGSiYUzOw_LskvjoDWAcnNnxaJVc+GrqPJZw@mail.gmail.com>
Subject: Re: [PATCH qemu 1/1] Replace opentitan UART device with newer version
 (opentitan 1.0)
To: Lex Bailey <lex.bailey@lowrisc.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, qemu-maintainers@lowrisc.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Apr 1, 2026 at 1:36=E2=80=AFAM Lex Bailey <lex.bailey@lowrisc.org> =
wrote:
>
>
> On 26/03/2026 02:39, Alistair Francis wrote:
>
> On Fri, Mar 20, 2026 at 12:50=E2=80=AFAM ~lexbaileylowrisc
> <lexbaileylowrisc@git.sr.ht> wrote:
>
> You need a commit message, it should describe what you are doing, link
> to specs and provide details for future readers.
>
> From: Lex Bailey <lex.bailey@lowrisc.org>
>
> Signed-off-by: Lex Bailey <lex.bailey@lowrisc.org>
> ---
>  hw/char/ibex_uart.c          | 569 -------------------------------
>  hw/char/meson.build          |   2 +-
>  hw/char/ot_uart.c            | 635 +++++++++++++++++++++++++++++++++++
>  hw/char/trace-events         |   8 +
>  hw/riscv/opentitan.c         |   3 +-
>  include/hw/char/ibex_uart.h  |  73 ----
>  include/hw/char/ot_uart.h    | 133 ++++++++
>  include/hw/riscv/opentitan.h |   4 +-
>  8 files changed, 781 insertions(+), 646 deletions(-)
>  delete mode 100644 hw/char/ibex_uart.c
>  create mode 100644 hw/char/ot_uart.c
>  delete mode 100644 include/hw/char/ibex_uart.h
>  create mode 100644 include/hw/char/ot_uart.h
>
> diff --git a/hw/char/ibex_uart.c b/hw/char/ibex_uart.c
> deleted file mode 100644
> index 127d219df3..0000000000
> --- a/hw/char/ibex_uart.c
> +++ /dev/null
>
> I don't think we should remove the file. If you want to rename it
> that's fine, but that should be its own commit. So one commit to
> rename it (with a justification in the commit message) and then more
> commits to make changes.
>
> okay, I will rename it first and then make changes
>
> @@ -1,569 +0,0 @@
> -/*
> - * QEMU lowRISC Ibex UART device
> - *
> - * Copyright (c) 2020 Western Digital
> - *
> - * For details check the documentation here:
> - *    https://docs.opentitan.org/hw/ip/uart/doc/
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> - * of this software and associated documentation files (the "Software"),=
 to deal
> - * in the Software without restriction, including without limitation the=
 rights
> - * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> - * copies of the Software, and to permit persons to whom the Software is
> - * furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be includ=
ed in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> - * THE SOFTWARE.
> - */
> -
> -#include "qemu/osdep.h"
> -#include "hw/char/ibex_uart.h"
> -#include "hw/core/irq.h"
> -#include "hw/core/qdev-clock.h"
> -#include "hw/core/qdev-properties.h"
> -#include "hw/core/qdev-properties-system.h"
> -#include "hw/core/registerfields.h"
> -#include "migration/vmstate.h"
> -#include "qemu/log.h"
> -#include "qemu/module.h"
> -
> -REG32(INTR_STATE, 0x00)
> -    FIELD(INTR_STATE, TX_WATERMARK, 0, 1)
> -    FIELD(INTR_STATE, RX_WATERMARK, 1, 1)
> -    FIELD(INTR_STATE, TX_EMPTY, 2, 1)
> -    FIELD(INTR_STATE, RX_OVERFLOW, 3, 1)
> -REG32(INTR_ENABLE, 0x04)
> -REG32(INTR_TEST, 0x08)
> -REG32(ALERT_TEST, 0x0C)
> -REG32(CTRL, 0x10)
> -    FIELD(CTRL, TX_ENABLE, 0, 1)
> -    FIELD(CTRL, RX_ENABLE, 1, 1)
> -    FIELD(CTRL, NF, 2, 1)
> -    FIELD(CTRL, SLPBK, 4, 1)
> -    FIELD(CTRL, LLPBK, 5, 1)
> -    FIELD(CTRL, PARITY_EN, 6, 1)
> -    FIELD(CTRL, PARITY_ODD, 7, 1)
> -    FIELD(CTRL, RXBLVL, 8, 2)
> -    FIELD(CTRL, NCO, 16, 16)
> -REG32(STATUS, 0x14)
> -    FIELD(STATUS, TXFULL, 0, 1)
> -    FIELD(STATUS, RXFULL, 1, 1)
> -    FIELD(STATUS, TXEMPTY, 2, 1)
> -    FIELD(STATUS, RXIDLE, 4, 1)
> -    FIELD(STATUS, RXEMPTY, 5, 1)
> -REG32(RDATA, 0x18)
> -REG32(WDATA, 0x1C)
> -REG32(FIFO_CTRL, 0x20)
> -    FIELD(FIFO_CTRL, RXRST, 0, 1)
> -    FIELD(FIFO_CTRL, TXRST, 1, 1)
> -    FIELD(FIFO_CTRL, RXILVL, 2, 3)
> -    FIELD(FIFO_CTRL, TXILVL, 5, 2)
> -REG32(FIFO_STATUS, 0x24)
> -    FIELD(FIFO_STATUS, TXLVL, 0, 5)
> -    FIELD(FIFO_STATUS, RXLVL, 16, 5)
> -REG32(OVRD, 0x28)
> -REG32(VAL, 0x2C)
> -REG32(TIMEOUT_CTRL, 0x30)
> -
> -static void ibex_uart_update_irqs(IbexUartState *s)
> -{
> -    if (s->uart_intr_state & s->uart_intr_enable & R_INTR_STATE_TX_WATER=
MARK_MASK) {
> -        qemu_set_irq(s->tx_watermark, 1);
> -    } else {
> -        qemu_set_irq(s->tx_watermark, 0);
> -    }
> -
> -    if (s->uart_intr_state & s->uart_intr_enable & R_INTR_STATE_RX_WATER=
MARK_MASK) {
> -        qemu_set_irq(s->rx_watermark, 1);
> -    } else {
> -        qemu_set_irq(s->rx_watermark, 0);
> -    }
> -
> -    if (s->uart_intr_state & s->uart_intr_enable & R_INTR_STATE_TX_EMPTY=
_MASK) {
> -        qemu_set_irq(s->tx_empty, 1);
> -    } else {
> -        qemu_set_irq(s->tx_empty, 0);
> -    }
> -
> -    if (s->uart_intr_state & s->uart_intr_enable & R_INTR_STATE_RX_OVERF=
LOW_MASK) {
> -        qemu_set_irq(s->rx_overflow, 1);
> -    } else {
> -        qemu_set_irq(s->rx_overflow, 0);
> -    }
> -}
> -
> -static int ibex_uart_can_receive(void *opaque)
> -{
> -    IbexUartState *s =3D opaque;
> -
> -    if ((s->uart_ctrl & R_CTRL_RX_ENABLE_MASK)
> -           && !(s->uart_status & R_STATUS_RXFULL_MASK)) {
> -        return 1;
> -    }
> -
> -    return 0;
> -}
> -
> -static void ibex_uart_receive(void *opaque, const uint8_t *buf, int size=
)
> -{
> -    IbexUartState *s =3D opaque;
> -    uint8_t rx_fifo_level =3D (s->uart_fifo_ctrl & R_FIFO_CTRL_RXILVL_MA=
SK)
> -                            >> R_FIFO_CTRL_RXILVL_SHIFT;
> -
> -    s->uart_rdata =3D *buf;
> -
> -    s->uart_status &=3D ~R_STATUS_RXIDLE_MASK;
> -    s->uart_status &=3D ~R_STATUS_RXEMPTY_MASK;
> -    /* The RXFULL is set after receiving a single byte
> -     * as the FIFO buffers are not yet implemented.
> -     */
> -    s->uart_status |=3D R_STATUS_RXFULL_MASK;
> -    s->rx_level +=3D 1;
> -
> -    if (size > rx_fifo_level) {
> -        s->uart_intr_state |=3D R_INTR_STATE_RX_WATERMARK_MASK;
> -    }
> -
> -    ibex_uart_update_irqs(s);
> -}
> -
> -static gboolean ibex_uart_xmit(void *do_not_use, GIOCondition cond,
> -                               void *opaque)
> -{
> -    IbexUartState *s =3D opaque;
> -    uint8_t tx_fifo_level =3D (s->uart_fifo_ctrl & R_FIFO_CTRL_TXILVL_MA=
SK)
> -                            >> R_FIFO_CTRL_TXILVL_SHIFT;
> -    int ret;
> -
> -    /* instant drain the fifo when there's no back-end */
> -    if (!qemu_chr_fe_backend_connected(&s->chr)) {
> -        s->tx_level =3D 0;
> -        return G_SOURCE_REMOVE;
> -    }
> -
> -    if (!s->tx_level) {
> -        s->uart_status &=3D ~R_STATUS_TXFULL_MASK;
> -        s->uart_status |=3D R_STATUS_TXEMPTY_MASK;
> -        s->uart_intr_state |=3D R_INTR_STATE_TX_EMPTY_MASK;
> -        s->uart_intr_state &=3D ~R_INTR_STATE_TX_WATERMARK_MASK;
> -        ibex_uart_update_irqs(s);
> -        return G_SOURCE_REMOVE;
> -    }
> -
> -    ret =3D qemu_chr_fe_write(&s->chr, s->tx_fifo, s->tx_level);
> -
> -    if (ret >=3D 0) {
> -        s->tx_level -=3D ret;
> -        memmove(s->tx_fifo, s->tx_fifo + ret, s->tx_level);
> -    }
> -
> -    if (s->tx_level) {
> -        guint r =3D qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
> -                                        ibex_uart_xmit, s);
> -        if (!r) {
> -            s->tx_level =3D 0;
> -            return G_SOURCE_REMOVE;
> -        }
> -    }
> -
> -    /* Clear the TX Full bit */
> -    if (s->tx_level !=3D IBEX_UART_TX_FIFO_SIZE) {
> -        s->uart_status &=3D ~R_STATUS_TXFULL_MASK;
> -    }
> -
> -    /* Disable the TX_WATERMARK IRQ */
> -    if (s->tx_level < tx_fifo_level) {
> -        s->uart_intr_state &=3D ~R_INTR_STATE_TX_WATERMARK_MASK;
> -    }
> -
> -    /* Set TX empty */
> -    if (s->tx_level =3D=3D 0) {
> -        s->uart_status |=3D R_STATUS_TXEMPTY_MASK;
> -        s->uart_intr_state |=3D R_INTR_STATE_TX_EMPTY_MASK;
> -    }
> -
> -    ibex_uart_update_irqs(s);
> -    return G_SOURCE_REMOVE;
> -}
> -
> -static void uart_write_tx_fifo(IbexUartState *s, const uint8_t *buf,
> -                               int size)
> -{
> -    uint64_t current_time =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -    uint8_t tx_fifo_level =3D (s->uart_fifo_ctrl & R_FIFO_CTRL_TXILVL_MA=
SK)
> -                            >> R_FIFO_CTRL_TXILVL_SHIFT;
> -
> -    if (size > IBEX_UART_TX_FIFO_SIZE - s->tx_level) {
> -        size =3D IBEX_UART_TX_FIFO_SIZE - s->tx_level;
> -        qemu_log_mask(LOG_GUEST_ERROR, "ibex_uart: TX FIFO overflow");
> -    }
> -
> -    memcpy(s->tx_fifo + s->tx_level, buf, size);
> -    s->tx_level +=3D size;
> -
> -    if (s->tx_level > 0) {
> -        s->uart_status &=3D ~R_STATUS_TXEMPTY_MASK;
> -    }
> -
> -    if (s->tx_level >=3D tx_fifo_level) {
> -        s->uart_intr_state |=3D R_INTR_STATE_TX_WATERMARK_MASK;
> -        ibex_uart_update_irqs(s);
> -    }
> -
> -    if (s->tx_level =3D=3D IBEX_UART_TX_FIFO_SIZE) {
> -        s->uart_status |=3D R_STATUS_TXFULL_MASK;
> -    }
> -
> -    timer_mod(s->fifo_trigger_handle, current_time +
> -              (s->char_tx_time * 4));
> -}
> -
> -static void ibex_uart_reset(DeviceState *dev)
> -{
> -    IbexUartState *s =3D IBEX_UART(dev);
> -
> -    s->uart_intr_state =3D 0x00000000;
> -    s->uart_intr_state =3D 0x00000000;
> -    s->uart_intr_enable =3D 0x00000000;
> -    s->uart_ctrl =3D 0x00000000;
> -    s->uart_status =3D 0x0000003c;
> -    s->uart_rdata =3D 0x00000000;
> -    s->uart_fifo_ctrl =3D 0x00000000;
> -    s->uart_fifo_status =3D 0x00000000;
> -    s->uart_ovrd =3D 0x00000000;
> -    s->uart_val =3D 0x00000000;
> -    s->uart_timeout_ctrl =3D 0x00000000;
> -
> -    s->tx_level =3D 0;
> -    s->rx_level =3D 0;
> -
> -    s->char_tx_time =3D (NANOSECONDS_PER_SECOND / 230400) * 10;
> -
> -    ibex_uart_update_irqs(s);
> -}
> -
> -static uint64_t ibex_uart_get_baud(IbexUartState *s)
> -{
> -    uint64_t baud;
> -
> -    baud =3D ((s->uart_ctrl & R_CTRL_NCO_MASK) >> 16);
> -    baud *=3D clock_get_hz(s->f_clk);
> -    baud >>=3D 20;
> -
> -    return baud;
> -}
> -
> -static uint64_t ibex_uart_read(void *opaque, hwaddr addr,
> -                                       unsigned int size)
> -{
> -    IbexUartState *s =3D opaque;
> -    uint64_t retvalue =3D 0;
> -
> -    switch (addr >> 2) {
> -    case R_INTR_STATE:
> -        retvalue =3D s->uart_intr_state;
> -        break;
> -    case R_INTR_ENABLE:
> -        retvalue =3D s->uart_intr_enable;
> -        break;
> -    case R_INTR_TEST:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: wdata is write only\n", __func__);
> -        break;
> -
> -    case R_CTRL:
> -        retvalue =3D s->uart_ctrl;
> -        break;
> -    case R_STATUS:
> -        retvalue =3D s->uart_status;
> -        break;
> -
> -    case R_RDATA:
> -        retvalue =3D s->uart_rdata;
> -        if ((s->uart_ctrl & R_CTRL_RX_ENABLE_MASK) && (s->rx_level > 0))=
 {
> -            qemu_chr_fe_accept_input(&s->chr);
> -
> -            s->rx_level -=3D 1;
> -            s->uart_status &=3D ~R_STATUS_RXFULL_MASK;
> -            if (s->rx_level =3D=3D 0) {
> -                s->uart_status |=3D R_STATUS_RXIDLE_MASK;
> -                s->uart_status |=3D R_STATUS_RXEMPTY_MASK;
> -            }
> -        }
> -        break;
> -    case R_WDATA:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: wdata is write only\n", __func__);
> -        break;
> -
> -    case R_FIFO_CTRL:
> -        retvalue =3D s->uart_fifo_ctrl;
> -        break;
> -    case R_FIFO_STATUS:
> -        retvalue =3D s->uart_fifo_status;
> -
> -        retvalue |=3D (s->rx_level & 0x1F) << R_FIFO_STATUS_RXLVL_SHIFT;
> -        retvalue |=3D (s->tx_level & 0x1F) << R_FIFO_STATUS_TXLVL_SHIFT;
> -
> -        qemu_log_mask(LOG_UNIMP,
> -                      "%s: RX fifos are not supported\n", __func__);
> -        break;
> -
> -    case R_OVRD:
> -        retvalue =3D s->uart_ovrd;
> -        qemu_log_mask(LOG_UNIMP,
> -                      "%s: ovrd is not supported\n", __func__);
> -        break;
> -    case R_VAL:
> -        retvalue =3D s->uart_val;
> -        qemu_log_mask(LOG_UNIMP,
> -                      "%s: val is not supported\n", __func__);
> -        break;
> -    case R_TIMEOUT_CTRL:
> -        retvalue =3D s->uart_timeout_ctrl;
> -        qemu_log_mask(LOG_UNIMP,
> -                      "%s: timeout_ctrl is not supported\n", __func__);
> -        break;
> -    default:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, add=
r);
> -        return 0;
> -    }
> -
> -    return retvalue;
> -}
> -
> -static void ibex_uart_write(void *opaque, hwaddr addr,
> -                                  uint64_t val64, unsigned int size)
> -{
> -    IbexUartState *s =3D opaque;
> -    uint32_t value =3D val64;
> -
> -    switch (addr >> 2) {
> -    case R_INTR_STATE:
> -        /* Write 1 clear */
> -        s->uart_intr_state &=3D ~value;
> -        ibex_uart_update_irqs(s);
> -        break;
> -    case R_INTR_ENABLE:
> -        s->uart_intr_enable =3D value;
> -        ibex_uart_update_irqs(s);
> -        break;
> -    case R_INTR_TEST:
> -        s->uart_intr_state |=3D value;
> -        ibex_uart_update_irqs(s);
> -        break;
> -
> -    case R_CTRL:
> -        s->uart_ctrl =3D value;
> -
> -        if (value & R_CTRL_NF_MASK) {
> -            qemu_log_mask(LOG_UNIMP,
> -                          "%s: UART_CTRL_NF is not supported\n", __func_=
_);
> -        }
> -        if (value & R_CTRL_SLPBK_MASK) {
> -            qemu_log_mask(LOG_UNIMP,
> -                          "%s: UART_CTRL_SLPBK is not supported\n", __fu=
nc__);
> -        }
> -        if (value & R_CTRL_LLPBK_MASK) {
> -            qemu_log_mask(LOG_UNIMP,
> -                          "%s: UART_CTRL_LLPBK is not supported\n", __fu=
nc__);
> -        }
> -        if (value & R_CTRL_PARITY_EN_MASK) {
> -            qemu_log_mask(LOG_UNIMP,
> -                          "%s: UART_CTRL_PARITY_EN is not supported\n",
> -                          __func__);
> -        }
> -        if (value & R_CTRL_PARITY_ODD_MASK) {
> -            qemu_log_mask(LOG_UNIMP,
> -                          "%s: UART_CTRL_PARITY_ODD is not supported\n",
> -                          __func__);
> -        }
> -        if (value & R_CTRL_RXBLVL_MASK) {
> -            qemu_log_mask(LOG_UNIMP,
> -                          "%s: UART_CTRL_RXBLVL is not supported\n", __f=
unc__);
> -        }
> -        if (value & R_CTRL_NCO_MASK) {
> -            uint64_t baud =3D ibex_uart_get_baud(s);
> -
> -            s->char_tx_time =3D (NANOSECONDS_PER_SECOND / baud) * 10;
> -        }
> -        break;
> -    case R_STATUS:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: status is read only\n", __func__);
> -        break;
> -
> -    case R_RDATA:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: rdata is read only\n", __func__);
> -        break;
> -    case R_WDATA:
> -        uart_write_tx_fifo(s, (uint8_t *) &value, 1);
> -        break;
> -
> -    case R_FIFO_CTRL:
> -        s->uart_fifo_ctrl =3D value;
> -
> -        if (value & R_FIFO_CTRL_RXRST_MASK) {
> -            s->rx_level =3D 0;
> -            qemu_log_mask(LOG_UNIMP,
> -                          "%s: RX fifos are not supported\n", __func__);
> -        }
> -        if (value & R_FIFO_CTRL_TXRST_MASK) {
> -            s->tx_level =3D 0;
> -        }
> -        break;
> -    case R_FIFO_STATUS:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: fifo_status is read only\n", __func__);
> -        break;
> -
> -    case R_OVRD:
> -        s->uart_ovrd =3D value;
> -        qemu_log_mask(LOG_UNIMP,
> -                      "%s: ovrd is not supported\n", __func__);
> -        break;
> -    case R_VAL:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: val is read only\n", __func__);
> -        break;
> -    case R_TIMEOUT_CTRL:
> -        s->uart_timeout_ctrl =3D value;
> -        qemu_log_mask(LOG_UNIMP,
> -                      "%s: timeout_ctrl is not supported\n", __func__);
> -        break;
> -    default:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, add=
r);
> -    }
> -}
> -
> -static void ibex_uart_clk_update(void *opaque, ClockEvent event)
> -{
> -    IbexUartState *s =3D opaque;
> -
> -    /* recompute uart's speed on clock change */
> -    uint64_t baud =3D ibex_uart_get_baud(s);
> -
> -    s->char_tx_time =3D (NANOSECONDS_PER_SECOND / baud) * 10;
> -}
> -
> -static void fifo_trigger_update(void *opaque)
> -{
> -    IbexUartState *s =3D opaque;
> -
> -    if (s->uart_ctrl & R_CTRL_TX_ENABLE_MASK) {
> -        ibex_uart_xmit(NULL, G_IO_OUT, s);
> -    }
> -}
> -
> -static const MemoryRegionOps ibex_uart_ops =3D {
> -    .read =3D ibex_uart_read,
> -    .write =3D ibex_uart_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> -    .impl.min_access_size =3D 4,
> -    .impl.max_access_size =3D 4,
> -};
> -
> -static int ibex_uart_post_load(void *opaque, int version_id)
> -{
> -    IbexUartState *s =3D opaque;
> -
> -    ibex_uart_update_irqs(s);
> -    return 0;
> -}
> -
> -static const VMStateDescription vmstate_ibex_uart =3D {
> -    .name =3D TYPE_IBEX_UART,
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> -    .post_load =3D ibex_uart_post_load,
> -    .fields =3D (const VMStateField[]) {
> -        VMSTATE_UINT8_ARRAY(tx_fifo, IbexUartState,
> -                            IBEX_UART_TX_FIFO_SIZE),
> -        VMSTATE_UINT32(tx_level, IbexUartState),
> -        VMSTATE_UINT64(char_tx_time, IbexUartState),
> -        VMSTATE_TIMER_PTR(fifo_trigger_handle, IbexUartState),
> -        VMSTATE_UINT32(uart_intr_state, IbexUartState),
> -        VMSTATE_UINT32(uart_intr_enable, IbexUartState),
> -        VMSTATE_UINT32(uart_ctrl, IbexUartState),
> -        VMSTATE_UINT32(uart_status, IbexUartState),
> -        VMSTATE_UINT32(uart_rdata, IbexUartState),
> -        VMSTATE_UINT32(uart_fifo_ctrl, IbexUartState),
> -        VMSTATE_UINT32(uart_fifo_status, IbexUartState),
> -        VMSTATE_UINT32(uart_ovrd, IbexUartState),
> -        VMSTATE_UINT32(uart_val, IbexUartState),
> -        VMSTATE_UINT32(uart_timeout_ctrl, IbexUartState),
> -        VMSTATE_END_OF_LIST()
> -    }
> -};
> -
> -static const Property ibex_uart_properties[] =3D {
> -    DEFINE_PROP_CHR("chardev", IbexUartState, chr),
> -};
> -
> -static void ibex_uart_init(Object *obj)
> -{
> -    IbexUartState *s =3D IBEX_UART(obj);
> -
> -    s->f_clk =3D qdev_init_clock_in(DEVICE(obj), "f_clock",
> -                                  ibex_uart_clk_update, s, ClockUpdate);
> -    clock_set_hz(s->f_clk, IBEX_UART_CLOCK);
> -
> -    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->tx_watermark);
> -    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->rx_watermark);
> -    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->tx_empty);
> -    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->rx_overflow);
> -
> -    memory_region_init_io(&s->mmio, obj, &ibex_uart_ops, s,
> -                          TYPE_IBEX_UART, 0x400);
> -    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> -}
> -
> -static void ibex_uart_realize(DeviceState *dev, Error **errp)
> -{
> -    IbexUartState *s =3D IBEX_UART(dev);
> -
> -    s->fifo_trigger_handle =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> -                                          fifo_trigger_update, s);
> -
> -    qemu_chr_fe_set_handlers(&s->chr, ibex_uart_can_receive,
> -                             ibex_uart_receive, NULL, NULL,
> -                             s, NULL, true);
> -}
> -
> -static void ibex_uart_class_init(ObjectClass *klass, const void *data)
> -{
> -    DeviceClass *dc =3D DEVICE_CLASS(klass);
> -
> -    device_class_set_legacy_reset(dc, ibex_uart_reset);
> -    dc->realize =3D ibex_uart_realize;
> -    dc->vmsd =3D &vmstate_ibex_uart;
> -    device_class_set_props(dc, ibex_uart_properties);
> -    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> -}
> -
> -static const TypeInfo ibex_uart_info =3D {
> -    .name          =3D TYPE_IBEX_UART,
> -    .parent        =3D TYPE_SYS_BUS_DEVICE,
> -    .instance_size =3D sizeof(IbexUartState),
> -    .instance_init =3D ibex_uart_init,
> -    .class_init    =3D ibex_uart_class_init,
> -};
> -
> -static void ibex_uart_register_types(void)
> -{
> -    type_register_static(&ibex_uart_info);
> -}
> -
> -type_init(ibex_uart_register_types)
> diff --git a/hw/char/meson.build b/hw/char/meson.build
> index fc3d7ee506..989ca3d7e0 100644
> --- a/hw/char/meson.build
> +++ b/hw/char/meson.build
> @@ -2,7 +2,7 @@ system_ss.add(when: 'CONFIG_CADENCE', if_true: files('cad=
ence_uart.c'))
>  system_ss.add(when: 'CONFIG_CMSDK_APB_UART', if_true: files('cmsdk-apb-u=
art.c'))
>  system_ss.add(when: 'CONFIG_ESCC', if_true: files('escc.c'))
>  system_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_apbuart.c'))
> -system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_uart.c'))
> +system_ss.add(when: 'CONFIG_IBEX', if_true: files('ot_uart.c'))
>  system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_serial.c'))
>  system_ss.add(when: 'CONFIG_IP_OCTAL_232', if_true: files('ipoctal232.c'=
))
>  system_ss.add(when: 'CONFIG_ISA_BUS', if_true: files('parallel-isa.c'))
> diff --git a/hw/char/ot_uart.c b/hw/char/ot_uart.c
> new file mode 100644
> index 0000000000..757f64ab70
> --- /dev/null
> +++ b/hw/char/ot_uart.c
> @@ -0,0 +1,635 @@
> +/*
> + * QEMU OpenTitan UART device
> + *
> + * Copyright (c) 2022-2025 Rivos, Inc.
> + * Copyright (c) 2025 lowRISC contributors.
> + *
> + * Author(s):
> + *  Lo=C3=AFc Lefort <loic@rivosinc.com>
> + *
> + * SPDX-License-Identifier: MIT
> + *
> + * Based on original ibex_uart implementation:
> + *  Copyright (c) 2020 Western Digital
> + *  Alistair Francis <alistair.francis@wdc.com>
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/fifo8.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qapi/error.h"
> +#include "chardev/char-fe.h"
> +#include "hw/core/cpu.h"
> +#include "hw/core/irq.h"
> +#include "hw/char/ot_uart.h"
> +#include "hw/core/qdev-properties-system.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/core/registerfields.h"
> +#include "trace.h"
> +
> +#define REG_NAME_ENTRY(_reg_) [R_##_reg_] =3D stringify(_reg_)
>
> Let's use the existing QEMU macros instead of creating custom ones.
>
> Specifically which macro should I be using instead? I can't find any that=
 do the same as this one. It is used to populate the array of register name=
s just below, which are used in log/trace messages

Ah sorry. I originally thought this was instead of the REG32 macros,
hence the comment. Then forgot to come back and delete the comment
before sending.

>
> +static const char *REG_NAMES[REGS_COUNT] =3D {
> +    /* clang-format off */
> +    REG_NAME_ENTRY(INTR_STATE),
> +    REG_NAME_ENTRY(INTR_ENABLE),
> +    REG_NAME_ENTRY(INTR_TEST),
> +    REG_NAME_ENTRY(ALERT_TEST),
> +    REG_NAME_ENTRY(CTRL),
> +    REG_NAME_ENTRY(STATUS),
> +    REG_NAME_ENTRY(RDATA),
> +    REG_NAME_ENTRY(WDATA),
> +    REG_NAME_ENTRY(FIFO_CTRL),
> +    REG_NAME_ENTRY(FIFO_STATUS),
> +    REG_NAME_ENTRY(OVRD),
> +    REG_NAME_ENTRY(VAL),
> +    REG_NAME_ENTRY(TIMEOUT_CTRL),
> +    /* clang-format on */
> +};
> +#undef REG_NAME_ENTRY
> +
> +static uint32_t ot_uart_get_tx_watermark_level(const OtUARTState *s)
> +{
> +    uint32_t tx_ilvl =3D (s->regs[R_FIFO_CTRL] & R_FIFO_CTRL_TXILVL_MASK=
) >>
> +                       R_FIFO_CTRL_TXILVL_SHIFT;
>
> You can then use the extract (FIELD_EX32) macros instead of mask and shif=
t.
>
> +
> +    return tx_ilvl < 7u ? (1u << tx_ilvl) : 64u;
>
> You shouldn't need the `u`s
>
> +}
> +
> +static uint32_t ot_uart_get_rx_watermark_level(const OtUARTState *s)
> +{
> +    uint32_t rx_ilvl =3D (s->regs[R_FIFO_CTRL] & R_FIFO_CTRL_RXILVL_MASK=
) >>
> +                       R_FIFO_CTRL_RXILVL_SHIFT;
> +
> +    return rx_ilvl < 7u ? (1u << rx_ilvl) : 126u;
> +}
> +
> +static void ot_uart_update_irqs(OtUARTState *s)
> +{
> +    uint32_t state_masked =3D s->regs[R_INTR_STATE] & s->regs[R_INTR_ENA=
BLE];
> +
> +    trace_ot_uart_irqs(s->ot_id, s->regs[R_INTR_STATE], s->regs[R_INTR_E=
NABLE],
> +                       state_masked);
> +
> +    for (int index =3D 0; index < OT_UART_IRQ_NUM; index++) {
> +        bool level =3D (state_masked & (1U << index)) !=3D 0;
> +        qemu_set_irq(s->irqs[index], level);
> +    }
> +}
> +
> +static bool ot_uart_is_sys_loopack_enabled(const OtUARTState *s)
> +{
> +    return (bool)FIELD_EX32(s->regs[R_CTRL], CTRL, SLPBK);
>
> You also should need to cast this
>
> +}
> +
> +static bool ot_uart_is_tx_enabled(const OtUARTState *s)
> +{
> +    return (bool)FIELD_EX32(s->regs[R_CTRL], CTRL, TX);
> +}
> +
> +static bool ot_uart_is_rx_enabled(const OtUARTState *s)
> +{
> +    return (bool)FIELD_EX32(s->regs[R_CTRL], CTRL, RX);
> +}
> +
> +static void ot_uart_check_baudrate(const OtUARTState *s)
> +{
> +    uint32_t nco =3D FIELD_EX32(s->regs[R_CTRL], CTRL, NCO);
> +
> +    unsigned baudrate =3D (unsigned)(((uint64_t)nco * (uint64_t)s->pclk)=
 >>
> +                                   (R_CTRL_NCO_LENGTH + 4));
> +
> +    if (baudrate) {
> +        trace_ot_uart_check_baudrate(s->ot_id, s->pclk, baudrate);
> +    }
> +}
> +
> +static void ot_uart_reset_rx_fifo(OtUARTState *s)
> +{
> +    fifo8_reset(&s->rx_fifo);
> +    s->regs[R_INTR_STATE] &=3D ~INTR_RX_WATERMARK_MASK;
> +    s->regs[R_INTR_STATE] &=3D ~INTR_RX_OVERFLOW_MASK;
> +    if (ot_uart_is_rx_enabled(s) && !ot_uart_is_sys_loopack_enabled(s)) =
{
> +        qemu_chr_fe_accept_input(&s->chr);
> +    }
> +}
> +
> +static int ot_uart_can_receive(void *opaque)
> +{
> +    OtUARTState *s =3D opaque;
> +
> +    if (s->regs[R_CTRL] & R_CTRL_RX_MASK) {
> +        return (int)fifo8_num_free(&s->rx_fifo);
> +    }
> +
> +    return 0;
> +}
> +
> +static void ot_uart_receive(void *opaque, const uint8_t *buf, int size)
> +{
> +    OtUARTState *s =3D opaque;
> +    uint32_t rx_watermark_level;
> +    size_t count =3D MIN(fifo8_num_free(&s->rx_fifo), (size_t)size);
> +
> +    if (size && !s->toggle_break) {
> +        /* no longer breaking, so emulate idle in oversampled VAL regist=
er */
> +        s->in_break =3D false;
> +    }
> +
> +    for (int index =3D 0; index < size; index++) {
> +        fifo8_push(&s->rx_fifo, buf[index]);
> +    }
> +
> +    /* update INTR_STATE */
> +    if (count !=3D size) {
> +        s->regs[R_INTR_STATE] |=3D INTR_RX_OVERFLOW_MASK;
> +    }
> +    rx_watermark_level =3D ot_uart_get_rx_watermark_level(s);
> +    if (rx_watermark_level && size >=3D rx_watermark_level) {
> +        s->regs[R_INTR_STATE] |=3D INTR_RX_WATERMARK_MASK;
> +    }
> +
> +    ot_uart_update_irqs(s);
> +}
> +
> +static void ot_uart_event_handler(void *opaque, QEMUChrEvent event)
> +{
> +    OtUARTState *s =3D opaque;
> +
> +    if (event =3D=3D CHR_EVENT_BREAK) {
> +        if (!s->in_break || !s->oversample_break) {
> +            /* ignore CTRL.RXBLVL as we have no notion of break "time" *=
/
> +            s->regs[R_INTR_STATE] |=3D INTR_RX_BREAK_ERR_MASK;
> +            ot_uart_update_irqs(s);
> +            /* emulate break in the oversampled VAL register */
> +            s->in_break =3D true;
> +        } else if (s->toggle_break) {
> +            /* emulate toggling break off in the oversampled VAL registe=
r */
> +            s->in_break =3D false;
> +        }
> +    }
> +}
> +
> +static uint8_t ot_uart_read_rx_fifo(OtUARTState *s)
> +{
> +    uint8_t val;
> +
> +    if (!(s->regs[R_CTRL] & R_CTRL_RX_MASK)) {
> +        return 0;
> +    }
> +
> +    if (fifo8_is_empty(&s->rx_fifo)) {
> +        return 0;
> +    }
> +
> +    val =3D fifo8_pop(&s->rx_fifo);
> +
> +    if (ot_uart_is_rx_enabled(s) && !ot_uart_is_sys_loopack_enabled(s)) =
{
> +        qemu_chr_fe_accept_input(&s->chr);
> +    }
> +
> +    return val;
> +}
> +
> +static void ot_uart_reset_tx_fifo(OtUARTState *s)
> +{
> +    fifo8_reset(&s->tx_fifo);
> +    s->regs[R_INTR_STATE] |=3D INTR_TX_EMPTY_MASK;
> +    s->regs[R_INTR_STATE] |=3D INTR_TX_DONE_MASK;
> +    if (s->tx_watermark_level) {
> +        s->regs[R_INTR_STATE] |=3D INTR_TX_WATERMARK_MASK;
> +        s->tx_watermark_level =3D 0;
> +    }
> +}
> +
> +static void ot_uart_xmit(OtUARTState *s)
> +{
> +    const uint8_t *buf;
> +    uint32_t size;
> +    int ret;
> +
> +    if (fifo8_is_empty(&s->tx_fifo)) {
> +        return;
> +    }
> +
> +    if (ot_uart_is_sys_loopack_enabled(s)) {
> +        /* system loopback mode, just forward to RX FIFO */
> +        uint32_t count =3D fifo8_num_used(&s->tx_fifo);
> +        buf =3D fifo8_pop_bufptr(&s->tx_fifo, count, &size);
> +        ot_uart_receive(s, buf, (int)size);
> +        count -=3D size;
> +        /*
> +         * there may be more data to send if data wraps around the end o=
f TX
> +         * FIFO
> +         */
> +        if (count) {
> +            buf =3D fifo8_pop_bufptr(&s->tx_fifo, count, &size);
> +            ot_uart_receive(s, buf, (int)size);
> +        }
> +    } else {
> +        /* instant drain the fifo when there's no back-end */
> +        if (!qemu_chr_fe_backend_connected(&s->chr)) {
> +            ot_uart_reset_tx_fifo(s);
> +            ot_uart_update_irqs(s);
> +            return;
> +        }
> +
> +        /* get a continuous buffer from the FIFO */
> +        buf =3D
> +            fifo8_peek_bufptr(&s->tx_fifo, fifo8_num_used(&s->tx_fifo), =
&size);
> +        /* send as much as possible */
> +        ret =3D qemu_chr_fe_write(&s->chr, buf, (int)size);
> +        /* if some characters where sent, remove them from the FIFO */
> +        if (ret >=3D 0) {
> +            fifo8_drop(&s->tx_fifo, ret);
> +        }
> +    }
> +
> +    /* update INTR_STATE */
> +    if (fifo8_is_empty(&s->tx_fifo)) {
> +        s->regs[R_INTR_STATE] |=3D INTR_TX_EMPTY_MASK;
> +        s->regs[R_INTR_STATE] |=3D INTR_TX_DONE_MASK;
> +    }
> +    if (s->tx_watermark_level &&
> +        fifo8_num_used(&s->tx_fifo) < s->tx_watermark_level) {
> +        s->regs[R_INTR_STATE] |=3D INTR_TX_WATERMARK_MASK;
> +        s->tx_watermark_level =3D 0;
> +    }
> +
> +    ot_uart_update_irqs(s);
> +}
> +
> +static gboolean ot_uart_watch_cb(void *do_not_use, GIOCondition cond,
> +                                 void *opaque)
> +{
> +    OtUARTState *s =3D opaque;
> +    (void)do_not_use;
> +    (void)cond;
> +
> +    s->watch_tag =3D 0;
> +    ot_uart_xmit(s);
> +
> +    return FALSE;
> +}
> +
> +static void uart_write_tx_fifo(OtUARTState *s, uint8_t val)
> +{
> +    if (fifo8_is_full(&s->tx_fifo)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "ot_uart: TX FIFO overflow");
> +        return;
> +    }
> +
> +    fifo8_push(&s->tx_fifo, val);
> +
> +    s->tx_watermark_level =3D ot_uart_get_tx_watermark_level(s);
> +    if (fifo8_num_used(&s->tx_fifo) < s->tx_watermark_level) {
> +        /*
> +         * TX watermark interrupt is raised when FIFO depth goes from ab=
ove
> +         * watermark to below. If we haven't reached watermark, reset ca=
ched
> +         * watermark level
> +         */
> +        s->tx_watermark_level =3D 0;
> +    }
> +
> +    if (ot_uart_is_tx_enabled(s)) {
> +        ot_uart_xmit(s);
> +    }
> +}
> +
> +static void ot_uart_clock_input(void *opaque, int irq, int level)
> +{
> +    OtUARTState *s =3D opaque;
> +
> +    g_assert(irq =3D=3D 0);
> +
> +    s->pclk =3D (unsigned)level;
> +
> +    /* TODO: disable UART transfer when PCLK is 0 */
> +    ot_uart_check_baudrate(s);
> +}
> +
> +static uint64_t ot_uart_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    OtUARTState *s =3D opaque;
> +    (void)size;
>
> Not sure this is required
>
> +    uint32_t val32;
> +
> +    hwaddr reg =3D R32_OFF(addr);
> +    switch (reg) {
> +    case R_INTR_STATE:
> +    case R_INTR_ENABLE:
> +    case R_CTRL:
> +    case R_FIFO_CTRL:
> +        val32 =3D s->regs[reg];
> +        break;
> +    case R_STATUS:
> +        /* assume that UART always report RXIDLE */
> +        val32 =3D R_STATUS_RXIDLE_MASK;
> +        /* report RXEMPTY or RXFULL */
> +        switch (fifo8_num_used(&s->rx_fifo)) {
> +        case 0:
> +            val32 |=3D R_STATUS_RXEMPTY_MASK;
> +            break;
> +        case OT_UART_RX_FIFO_SIZE:
> +            val32 |=3D R_STATUS_RXFULL_MASK;
> +            break;
> +        default:
> +            break;
> +        }
> +        /* report TXEMPTY+TXIDLE or TXFULL */
> +        switch (fifo8_num_used(&s->tx_fifo)) {
> +        case 0:
> +            val32 |=3D R_STATUS_TXEMPTY_MASK | R_STATUS_TXIDLE_MASK;
> +            break;
> +        case OT_UART_TX_FIFO_SIZE:
> +            val32 |=3D R_STATUS_TXFULL_MASK;
> +            break;
> +        default:
> +            break;
> +        }
> +        if (!ot_uart_is_tx_enabled(s)) {
> +            val32 |=3D R_STATUS_TXIDLE_MASK;
> +        }
> +        if (!ot_uart_is_rx_enabled(s)) {
> +            val32 |=3D R_STATUS_RXIDLE_MASK;
> +        }
> +        break;
> +    case R_RDATA:
> +        val32 =3D (uint32_t)ot_uart_read_rx_fifo(s);
> +        break;
> +    case R_FIFO_STATUS:
> +        val32 =3D
> +            (fifo8_num_used(&s->rx_fifo) & 0xffu) << R_FIFO_STATUS_RXLVL=
_SHIFT;
> +        val32 |=3D
> +            (fifo8_num_used(&s->tx_fifo) & 0xffu) << R_FIFO_STATUS_TXLVL=
_SHIFT;
> +        break;
> +    case R_VAL:
> +        /*
> +         * This is not trivially implemented due to the QEMU UART
> +         * interface. There is no way to reliably sample or oversample
> +         * given our emulated interface, but some software might poll th=
e
> +         * value of this register to determine break conditions.
> +         *
> +         * As such, default to reporting 16 of the last sample received
> +         * instead. This defaults to 16 idle high samples (as a stop bit=
 is
> +         * always the last received), except for when the `oversample-br=
eak`
> +         * property is set and a break condition is received over UART R=
X,
> +         * where we then show 16 low samples until the next valid UART
> +         * transmission is received (or break is toggled off with the
> +         * `toggle-break` property enabled). This will not be accurate, =
but
> +         * should be sufficient to support basic software flows that
> +         * essentially use UART break as a strapping mechanism.
> +         */
> +        val32 =3D (s->in_break && s->oversample_break) ? 0u : UINT16_MAX=
;
> +        qemu_log_mask(LOG_UNIMP, "%s: VAL only shows idle%s\n", __func__=
,
> +                      (s->oversample_break ? "/break" : ""));
> +        break;
> +    case R_OVRD:
> +    case R_TIMEOUT_CTRL:
> +        val32 =3D s->regs[reg];
> +        qemu_log_mask(LOG_UNIMP, "%s: %s is not supported\n", __func__,
> +                      REG_NAME(reg));
> +        break;
> +    case R_ALERT_TEST:
> +    case R_INTR_TEST:
> +    case R_WDATA:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: W/O register 0x%02x (%s)\n",
> +                      __func__, (uint32_t)addr, REG_NAME(reg));
> +        val32 =3D 0;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%02x\n", __func=
__,
> +                      (uint32_t)addr);
> +        val32 =3D 0;
> +        break;
> +    }
> +
> +    uint32_t pc =3D current_cpu->cc->get_pc(current_cpu);
> +    trace_ot_uart_io_read_out(s->ot_id, (uint32_t)addr, REG_NAME(reg), v=
al32,
> +                              pc);
> +
> +    return (uint64_t)val32;
> +}
> +
> +static void ot_uart_write(void *opaque, hwaddr addr, uint64_t val64,
> +                          unsigned size)
> +{
> +    OtUARTState *s =3D opaque;
> +    (void)size;
> +    uint32_t val32 =3D val64;
> +
> +    hwaddr reg =3D R32_OFF(addr);
> +
> +    uint32_t pc =3D current_cpu->cc->get_pc(current_cpu);
> +    trace_ot_uart_io_write(s->ot_id, (uint32_t)addr, REG_NAME(reg), val3=
2, pc);
> +
> +    switch (reg) {
> +    case R_INTR_STATE:
> +        val32 &=3D INTR_MASK;
> +        s->regs[R_INTR_STATE] &=3D ~val32; /* RW1C */
> +        ot_uart_update_irqs(s);
> +        break;
> +    case R_INTR_ENABLE:
> +        val32 &=3D INTR_MASK;
> +        s->regs[R_INTR_ENABLE] =3D val32;
> +        ot_uart_update_irqs(s);
> +        break;
> +    case R_INTR_TEST:
> +        val32 &=3D INTR_MASK;
> +        s->regs[R_INTR_STATE] |=3D val32;
> +        ot_uart_update_irqs(s);
> +        break;
> +    case R_ALERT_TEST:
> +        val32 &=3D R_ALERT_TEST_FATAL_FAULT_MASK;
> +        s->regs[reg] =3D val32;
> +        /* This will also set an IRQ once the alert handler is added */
> +        break;
> +    case R_CTRL:
> +        if (val32 & ~CTRL_SUP_MASK) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "%s: UART_CTRL feature not supported: 0x%08x\n=
",
> +                          __func__, val32 & ~CTRL_SUP_MASK);
> +        }
> +        uint32_t prev =3D s->regs[R_CTRL];
> +        s->regs[R_CTRL] =3D val32 & CTRL_MASK;
> +        uint32_t change =3D prev ^ s->regs[R_CTRL];
> +        if (change & R_CTRL_NCO_MASK) {
> +            ot_uart_check_baudrate(s);
> +        }
> +        if ((change & R_CTRL_RX_MASK) && ot_uart_is_rx_enabled(s) &&
> +            !ot_uart_is_sys_loopack_enabled(s)) {
> +            qemu_chr_fe_accept_input(&s->chr);
> +        }
> +        if ((change & R_CTRL_TX_MASK) && ot_uart_is_tx_enabled(s)) {
> +            /* try sending pending data from TX FIFO if any */
> +            ot_uart_xmit(s);
> +        }
> +        break;
> +    case R_WDATA:
> +        uart_write_tx_fifo(s, (uint8_t)(val32 & R_WDATA_WDATA_MASK));
> +        break;
> +    case R_FIFO_CTRL:
> +        s->regs[R_FIFO_CTRL] =3D
> +            val32 & (R_FIFO_CTRL_RXILVL_MASK | R_FIFO_CTRL_TXILVL_MASK);
> +        if (val32 & R_FIFO_CTRL_RXRST_MASK) {
> +            ot_uart_reset_rx_fifo(s);
> +            ot_uart_update_irqs(s);
> +        }
> +        if (val32 & R_FIFO_CTRL_TXRST_MASK) {
> +            ot_uart_reset_tx_fifo(s);
> +            ot_uart_update_irqs(s);
> +        }
> +        break;
> +    case R_OVRD:
> +        if (val32 & R_OVRD_TXEN_MASK) {
> +            qemu_log_mask(LOG_UNIMP, "%s: OVRD.TXEN is not supported\n",
> +                          __func__);
> +        }
> +        s->regs[R_OVRD] =3D val32 & R_OVRD_TXVAL_MASK;
> +        break;
> +    case R_TIMEOUT_CTRL:
> +        s->regs[R_TIMEOUT_CTRL] =3D
> +            val32 & (R_TIMEOUT_CTRL_EN_MASK | R_TIMEOUT_CTRL_VAL_MASK);
> +        break;
> +    case R_STATUS:
> +    case R_RDATA:
> +    case R_FIFO_STATUS:
> +    case R_VAL:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: R/O register 0x%02x (%s)\n",
> +                      __func__, (uint32_t)addr, REG_NAME(reg));
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%02x\n", __func=
__,
> +                      (uint32_t)addr);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps ot_uart_ops =3D {
> +    .read =3D ot_uart_read,
> +    .write =3D ot_uart_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .impl.min_access_size =3D 4,
> +    .impl.max_access_size =3D 4,
> +};
> +
> +static const Property ot_uart_properties[] =3D {
> +    DEFINE_PROP_STRING("ot-id", OtUARTState, ot_id),
> +    DEFINE_PROP_CHR("chardev", OtUARTState, chr),
> +    DEFINE_PROP_BOOL("oversample-break", OtUARTState, oversample_break, =
false),
> +    DEFINE_PROP_BOOL("toggle-break", OtUARTState, toggle_break, false),
> +};
> +
> +static int ot_uart_be_change(void *opaque)
> +{
> +    OtUARTState *s =3D opaque;
> +
> +    qemu_chr_fe_set_handlers(&s->chr, ot_uart_can_receive, ot_uart_recei=
ve,
> +                             ot_uart_event_handler, ot_uart_be_change, s=
, NULL,
> +                             true);
> +
> +    if (s->watch_tag > 0) {
> +        g_source_remove(s->watch_tag);
> +        /* NOLINTNEXTLINE(clang-analyzer-optin.core.EnumCastOutOfRange) =
*/
> +        s->watch_tag =3D qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_=
HUP,
> +                                             ot_uart_watch_cb, s);
> +    }
> +
> +    return 0;
> +}
> +
> +static void ot_uart_reset_enter(Object *obj, ResetType type)
> +{
> +    OtUARTClass *c =3D OT_UART_GET_CLASS(obj);
> +    OtUARTState *s =3D OT_UART(obj);
> +
> +    if (c->parent_phases.enter) {
> +        c->parent_phases.enter(obj, type);
> +    }
> +
> +    memset(&s->regs[0], 0, sizeof(s->regs));
> +
> +    s->tx_watermark_level =3D 0;
> +    for (unsigned index =3D 0; index < ARRAY_SIZE(s->irqs); index++) {
> +        qemu_set_irq(s->irqs[index], 0);
> +    }
> +    ot_uart_reset_tx_fifo(s);
> +    ot_uart_reset_rx_fifo(s);
> +
> +    /*
> +     * do not reset `s->in_break`, as that tracks whether we are current=
ly
> +     * receiving a break condition over UART RX from some device talking
> +     * to OpenTitan, which should survive resets. The QEMU CharDev only
> +     * supports transient break events and not the notion of holding the
> +     * UART in break, so remembering breaks like this is required to
> +     * support mocking of break conditions in the oversampled `VAL` reg.
> +     */
> +    if (s->in_break) {
> +        /* ignore CTRL.RXBLVL as we have no notion of break "time" */
> +        s->regs[R_INTR_STATE] |=3D INTR_RX_BREAK_ERR_MASK;
> +    }
> +
> +    ot_uart_update_irqs(s);
> +}
> +
> +static void ot_uart_realize(DeviceState *dev, Error **errp)
> +{
> +    OtUARTState *s =3D OT_UART(dev);
> +    (void)errp;
> +
> +    g_assert(s->ot_id);
> +
> +    qdev_init_gpio_in_named(DEVICE(s), &ot_uart_clock_input, "clock-in",=
 1);
> +
> +    fifo8_create(&s->tx_fifo, OT_UART_TX_FIFO_SIZE);
> +    fifo8_create(&s->rx_fifo, OT_UART_RX_FIFO_SIZE);
> +
> +    qemu_chr_fe_set_handlers(&s->chr, ot_uart_can_receive, ot_uart_recei=
ve,
> +                             ot_uart_event_handler, ot_uart_be_change, s=
, NULL,
> +                             true);
> +}
> +
> +static void ot_uart_init(Object *obj)
> +{
> +    OtUARTState *s =3D OT_UART(obj);
> +
> +    for (unsigned index =3D 0; index < OT_UART_IRQ_NUM; index++) {
> +        sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irqs[index]);
> +    }
> +
> +    memory_region_init_io(&s->mmio, obj, &ot_uart_ops, s, TYPE_OT_UART,
> +                          REGS_SIZE);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +}
> +
> +static void ot_uart_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    (void)data;
> +
> +    dc->realize =3D ot_uart_realize;
> +    device_class_set_props(dc, ot_uart_properties);
> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> +
> +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> +    OtUARTClass *uc =3D OT_UART_CLASS(klass);
> +    resettable_class_set_parent_phases(rc, &ot_uart_reset_enter, NULL, N=
ULL,
> +                                       &uc->parent_phases);
> +}
> +
> +static const TypeInfo ot_uart_info =3D {
> +    .name =3D TYPE_OT_UART,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(OtUARTState),
> +    .instance_init =3D ot_uart_init,
> +    .class_size =3D sizeof(OtUARTClass),
> +    .class_init =3D ot_uart_class_init,
> +};
> +
> +static void ot_uart_register_types(void)
> +{
> +    type_register_static(&ot_uart_info);
> +}
> +
> +type_init(ot_uart_register_types);
> diff --git a/hw/char/trace-events b/hw/char/trace-events
> index a3fcc77287..c859d8af4e 100644
> --- a/hw/char/trace-events
> +++ b/hw/char/trace-events
> @@ -141,3 +141,11 @@ stm32f2xx_usart_receive(char *id, uint8_t chr) " %s =
receiving '%c'"
>  # riscv_htif.c
>  htif_uart_write_to_host(uint8_t device, uint8_t cmd, uint64_t payload) "=
device: %u cmd: %02u payload: %016" PRIx64
>  htif_uart_unknown_device_command(uint8_t device, uint8_t cmd, uint64_t p=
ayload) "device: %u cmd: %02u payload: %016" PRIx64
> +
> +# ot_uart.c
> +ot_uart_check_baudrate(const char *id, unsigned pclk, unsigned baud) "%s=
: @ %u Hz: %u bps"
> +ot_uart_connect_input_clock(const char *id, const char * srcname) "%s: %=
s"
> +ot_uart_debug(const char *id, const char *msg) "%s: %s"
> +ot_uart_io_read_out(const char *id, uint32_t addr, const char *regname, =
uint32_t val, uint32_t pc) "%s: addr=3D0x%02x (%s), val=3D0x%x, pc=3D0x%x"
> +ot_uart_io_write(const char *id, uint32_t addr, const char *regname, uin=
t32_t val, uint32_t pc) "%s: addr=3D0x%02x (%s), val=3D0x%x, pc=3D0x%x"
> +ot_uart_irqs(const char *id, uint32_t active, uint32_t mask, uint32_t ef=
f) "%s: act:0x%08x msk:0x%08x eff:0x%08x"
> diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
> index 309125e854..163d3ac3d3 100644
> --- a/hw/riscv/opentitan.c
> +++ b/hw/riscv/opentitan.c
> @@ -132,7 +132,8 @@ static void lowrisc_ibex_soc_init(Object *obj)
>
>      object_initialize_child(obj, "plic", &s->plic, TYPE_SIFIVE_PLIC);
>
> -    object_initialize_child(obj, "uart", &s->uart, TYPE_IBEX_UART);
> +    object_initialize_child(obj, "uart", &s->uart, TYPE_OT_UART);
> +    object_property_set_str(OBJECT(&s->uart), "ot-id", "uart0", &error_f=
atal);
>
>      object_initialize_child(obj, "timer", &s->timer, TYPE_IBEX_TIMER);
>
> diff --git a/include/hw/char/ibex_uart.h b/include/hw/char/ibex_uart.h
> deleted file mode 100644
> index 882796e0c6..0000000000
> --- a/include/hw/char/ibex_uart.h
> +++ /dev/null
> @@ -1,73 +0,0 @@
> -/*
> - * QEMU lowRISC Ibex UART device
> - *
> - * Copyright (c) 2020 Western Digital
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> - * of this software and associated documentation files (the "Software"),=
 to deal
> - * in the Software without restriction, including without limitation the=
 rights
> - * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> - * copies of the Software, and to permit persons to whom the Software is
> - * furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be includ=
ed in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> - * THE SOFTWARE.
> - */
> -
> -#ifndef HW_IBEX_UART_H
> -#define HW_IBEX_UART_H
> -
> -#include "hw/core/sysbus.h"
> -#include "chardev/char-fe.h"
> -#include "qemu/timer.h"
> -#include "qom/object.h"
> -
> -#define IBEX_UART_TX_FIFO_SIZE 16
> -#define IBEX_UART_CLOCK 50000000 /* 50MHz clock */
> -
> -#define TYPE_IBEX_UART "ibex-uart"
> -OBJECT_DECLARE_SIMPLE_TYPE(IbexUartState, IBEX_UART)
> -
> -struct IbexUartState {
> -    /* <private> */
> -    SysBusDevice parent_obj;
> -
> -    /* <public> */
> -    MemoryRegion mmio;
> -
> -    uint8_t tx_fifo[IBEX_UART_TX_FIFO_SIZE];
> -    uint32_t tx_level;
> -
> -    uint32_t rx_level;
> -
> -    QEMUTimer *fifo_trigger_handle;
> -    uint64_t char_tx_time;
> -
> -    uint32_t uart_intr_state;
> -    uint32_t uart_intr_enable;
> -    uint32_t uart_ctrl;
> -    uint32_t uart_status;
> -    uint32_t uart_rdata;
> -    uint32_t uart_fifo_ctrl;
> -    uint32_t uart_fifo_status;
> -    uint32_t uart_ovrd;
> -    uint32_t uart_val;
> -    uint32_t uart_timeout_ctrl;
> -
> -    Clock *f_clk;
> -
> -    CharFrontend chr;
> -    qemu_irq tx_watermark;
> -    qemu_irq rx_watermark;
> -    qemu_irq tx_empty;
> -    qemu_irq rx_overflow;
> -};
> -#endif /* HW_IBEX_UART_H */
> diff --git a/include/hw/char/ot_uart.h b/include/hw/char/ot_uart.h
> new file mode 100644
> index 0000000000..45ec3fc7c2
> --- /dev/null
> +++ b/include/hw/char/ot_uart.h
> @@ -0,0 +1,133 @@
> +/*
> + * QEMU OpenTitan UART device
> + *
> + * Copyright (c) 2022-2025 Rivos, Inc.
> + *
> + * Author(s):
> + *  Lo=C3=AFc Lefort <loic@rivosinc.com>
> + *
> + * SPDX-License-Identifier: MIT
> + *
> + */
> +
> +#ifndef HW_OPENTITAN_OT_UART_H
> +#define HW_OPENTITAN_OT_UART_H
> +
> +#include "qemu/fifo8.h"
> +#include "chardev/char-fe.h"
> +#include "hw/core/sysbus.h"
> +#include "qom/object.h"
> +#include "hw/core/registerfields.h"
> +
> +#define TYPE_OT_UART "ot-uart"
> +OBJECT_DECLARE_TYPE(OtUARTState, OtUARTClass, OT_UART)
> +
> +/* clang-format off */
> +REG32(INTR_STATE, 0x00u)
> +    SHARED_FIELD(INTR_TX_WATERMARK, 0u, 1u)
> +    SHARED_FIELD(INTR_RX_WATERMARK, 1u, 1u)
> +    SHARED_FIELD(INTR_TX_DONE, 2u, 1u)
> +    SHARED_FIELD(INTR_RX_OVERFLOW, 3u, 1u)
> +    SHARED_FIELD(INTR_RX_FRAME_ERR, 4u, 1u)
> +    SHARED_FIELD(INTR_RX_BREAK_ERR, 5u, 1u)
> +    SHARED_FIELD(INTR_RX_TIMEOUT, 6u, 1u)
> +    SHARED_FIELD(INTR_RX_PARITY_ERR, 7u, 1u)
> +    SHARED_FIELD(INTR_TX_EMPTY, 8u, 1u)
> +REG32(INTR_ENABLE, 0x04u)
> +REG32(INTR_TEST, 0x08u)
> +REG32(ALERT_TEST, 0x0cu)
> +    FIELD(ALERT_TEST, FATAL_FAULT, 0u, 1u)
> +REG32(CTRL, 0x10u)
> +    FIELD(CTRL, TX, 0u, 1u)
> +    FIELD(CTRL, RX, 1u, 1u)
> +    FIELD(CTRL, NF, 2u, 1u)
> +    FIELD(CTRL, SLPBK, 4u, 1u)
> +    FIELD(CTRL, LLPBK, 5u, 1u)
> +    FIELD(CTRL, PARITY_EN, 6u, 1u)
> +    FIELD(CTRL, PARITY_ODD, 7u, 1u)
> +    FIELD(CTRL, RXBLVL, 8u, 2u)
> +    FIELD(CTRL, NCO, 16u, 16u)
> +REG32(STATUS, 0x14u)
> +    FIELD(STATUS, TXFULL, 0u, 1u)
> +    FIELD(STATUS, RXFULL, 1u, 1u)
> +    FIELD(STATUS, TXEMPTY, 2u, 1u)
> +    FIELD(STATUS, TXIDLE, 3u, 1u)
> +    FIELD(STATUS, RXIDLE, 4u, 1u)
> +    FIELD(STATUS, RXEMPTY, 5u, 1u)
> +REG32(RDATA, 0x18u)
> +    FIELD(RDATA, RDATA, 0u, 8u)
> +REG32(WDATA, 0x1cu)
> +    FIELD(WDATA, WDATA, 0u, 8u)
> +REG32(FIFO_CTRL, 0x20u)
> +    FIELD(FIFO_CTRL, RXRST, 0u, 1u)
> +    FIELD(FIFO_CTRL, TXRST, 1u, 1u)
> +    FIELD(FIFO_CTRL, RXILVL, 2u, 3u)
> +    FIELD(FIFO_CTRL, TXILVL, 5u, 3u)
> +REG32(FIFO_STATUS, 0x24u)
> +    FIELD(FIFO_STATUS, TXLVL, 0u, 8u)
> +    FIELD(FIFO_STATUS, RXLVL, 16u, 8u)
> +REG32(OVRD, 0x28u)
> +    FIELD(OVRD, TXEN, 0u, 1u)
> +    FIELD(OVRD, TXVAL, 1u, 1u)
> +REG32(VAL, 0x2cu)
> +    FIELD(VAL, RX, 0u, 16u)
> +REG32(TIMEOUT_CTRL, 0x30u)
> +    FIELD(TIMEOUT_CTRL, VAL, 0u, 24)
> +    FIELD(TIMEOUT_CTRL, EN, 31u, 1u)
> +/* clang-format on */
>
> These shouldn't need to be public
>
> agreed. They are here because the struct definition below uses REGS_COUNT=
 which is computed based on these definitions. I can hard-code the length o=
f 13 instead? It looks like other hardware blocks also hard-code this, is t=
here some way to at least catch the error if this stops being self-consiste=
nt?

Yeah, everyone else just hard codes a length or defines each register
as a u32/u64.

Good question about an assert. You could do a runtime assert in the
init() function. The BSD user headers also use `_Static_assert()` [1],
so that should be an option. I haven't checked that all supported
compilers support _Static_assert though

1: https://en.cppreference.com/w/c/language/_Static_assert.html

Alistair

>
> Alistair
>
> +
> +#define INTR_MASK \
> +    (INTR_TX_WATERMARK_MASK | INTR_RX_WATERMARK_MASK | INTR_TX_DONE_MASK=
 | \
> +     INTR_RX_OVERFLOW_MASK | INTR_RX_FRAME_ERR_MASK | INTR_RX_BREAK_ERR_=
MASK | \
> +     INTR_RX_TIMEOUT_MASK | INTR_RX_PARITY_ERR_MASK | INTR_TX_EMPTY_MASK=
)
> +
> +#define CTRL_MASK \
> +    (R_CTRL_TX_MASK | R_CTRL_RX_MASK | R_CTRL_NF_MASK | R_CTRL_SLPBK_MAS=
K | \
> +     R_CTRL_LLPBK_MASK | R_CTRL_PARITY_EN_MASK | R_CTRL_PARITY_ODD_MASK =
| \
> +     R_CTRL_RXBLVL_MASK | R_CTRL_NCO_MASK)
> +
> +#define CTRL_SUP_MASK \
> +    (R_CTRL_RX_MASK | R_CTRL_TX_MASK | R_CTRL_SLPBK_MASK | R_CTRL_NCO_MA=
SK)
> +
> +#define OT_UART_NCO_BITS     16u
> +#define OT_UART_TX_FIFO_SIZE 128u
> +#define OT_UART_RX_FIFO_SIZE 128u
> +#define OT_UART_IRQ_NUM      9u
> +
> +#define R32_OFF(_r_) ((_r_) / sizeof(uint32_t))
> +
> +#define R_LAST_REG (R_TIMEOUT_CTRL)
> +#define REGS_COUNT (R_LAST_REG + 1u)
> +#define REGS_SIZE  (REGS_COUNT * sizeof(uint32_t))
> +#define REG_NAME(_reg_) \
> +    ((((_reg_) < REGS_COUNT) && REG_NAMES[_reg_]) ? REG_NAMES[_reg_] : "=
?")
> +
> +struct OtUARTState {
> +    SysBusDevice parent_obj;
> +    MemoryRegion mmio;
> +    qemu_irq irqs[OT_UART_IRQ_NUM];
> +
> +    uint32_t regs[REGS_COUNT];
> +
> +    Fifo8 tx_fifo;
> +    Fifo8 rx_fifo;
> +    uint32_t tx_watermark_level;
> +    bool in_break;
> +    guint watch_tag;
> +    unsigned pclk; /* Current input clock */
> +    const char *clock_src_name; /* IRQ name once connected */
> +
> +    char *ot_id;
> +    char *clock_name;
> +    DeviceState *clock_src;
> +    CharFrontend chr;
> +    bool oversample_break; /* Should mock break in the oversampled VAL r=
eg? */
> +    bool toggle_break; /* Are incoming breaks temporary or toggled? */
> +};
> +
> +struct OtUARTClass {
> +    SysBusDeviceClass parent_class;
> +    ResettablePhases parent_phases;
> +};
> +
> +#endif /* HW_OPENTITAN_OT_UART_H */
> diff --git a/include/hw/riscv/opentitan.h b/include/hw/riscv/opentitan.h
> index 5b9016e1d8..f2b4bf3814 100644
> --- a/include/hw/riscv/opentitan.h
> +++ b/include/hw/riscv/opentitan.h
> @@ -21,7 +21,7 @@
>
>  #include "hw/riscv/riscv_hart.h"
>  #include "hw/intc/sifive_plic.h"
> -#include "hw/char/ibex_uart.h"
> +#include "hw/char/ot_uart.h"
>  #include "hw/timer/ibex_timer.h"
>  #include "hw/ssi/ibex_spi_host.h"
>  #include "hw/core/boards.h"
> @@ -43,7 +43,7 @@ struct LowRISCIbexSoCState {
>      /*< public >*/
>      RISCVHartArrayState cpus;
>      SiFivePLICState plic;
> -    IbexUartState uart;
> +    OtUARTState uart;
>      IbexTimerState timer;
>      IbexSPIHostState spi_host[OPENTITAN_NUM_SPI_HOSTS];
>
> --
> 2.49.1
>
> --
> Lex Bailey (they/them)
> lowRISC C.I.C. 7 Hills Road, Cambridge, CB2 1GE, UK. Registered in Englan=
d & Wales 09272283 lex.bailey@lowrisc.org

