Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FA9F36BA3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 03:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB28o-000444-Ib; Thu, 09 Apr 2026 23:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB28m-00043M-AU
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 23:02:40 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB28j-0007EW-Dx
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 23:02:40 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso303310266b.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 20:02:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775790156; cv=none;
 d=google.com; s=arc-20240605;
 b=NF2ZT4pUrss2WaaCmrpoYiaVPojNyckm9d/nOoadWFAu9S3n8ga7OmakfrdL5qkrD0
 cho0kRyvn8BN3pbXLHR56KvGGRSYvOOzs4wfQ1AiGABVEF3gR/xOhWx3C0QZOXl0Ox3r
 9DpNNra04IiKwxuoXYm59oRRnPB5+wmqyiFkgylDLP85AO1s5Iu65ReqWLmRhpEiSSQQ
 CrTFoPO1kZi6amqo4SdYXBDw4pwEu04Z+h+5cAzIuxQpJKsql+l31gQKtcKW93ju34Ea
 dNs7OeefsBjBw5nbNNo6WimxAcO/XKJ5QteLWtNnOgCAF0qnSSD7RzhNryzh/5K/VxPS
 h4dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ToBpNTsy8LQOEgY8+uv6QTPSril3IfYYkFbZ2WaPU78=;
 fh=ERTM5XTiHyFBA9zeoTdaB1nbCf1LrfIqZBj8ZlakxMA=;
 b=TYWud4qhxFD7h+xfC17PzVtyoujoKmPTZvpCz94MsOVn9M/eKTY+yY3SSnB6CGAHy8
 vJhP3QLQhinxYuFWI6HRglhYCmD73RL3vsul3DQubvVDXC1ZLU7FL2QGsxK7lVEIWuZs
 8is2wTMX54ey0aqA83OYby8RIswq127RC7znMQ76vydlEZgsQBdX0MdHy+ZbYVAlHmal
 3I/dM9Gssk42s5E5pYdWa+IndU2ci6egX9x8GOg7H6hdgO9+uNeNeyJ5rK/GcDXF2Q0N
 oD09LOdt0/hf/Mg2QVmLoEAQmuyvHFFPS7xsC8wojcKygp7kJFqxUgaOO63FVbxpswJw
 L7PA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775790156; x=1776394956; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ToBpNTsy8LQOEgY8+uv6QTPSril3IfYYkFbZ2WaPU78=;
 b=g1wWrQ8vyapAnd0uekqHRFFeoQsMySOwUg9+tcc1soi4X2Bs40wzJvL8T7pNS3si0J
 RVkIOog30JzWqKJ13VrKKgVEOfZEWM4VPlBzCsquqc3oWWRkk4zzZIGEA08VREZK8Oby
 2io4RHtOMkuDeXB+0lkErXDCXrR9OToHXLueH9K1bZ6rPgPPZSqkNrkwGix7WWaYx7yz
 EPLZg8q+yt3/pLaAXW+XfePwu/UGzHuxEzNhG5rgiw/xhhjWNeh7WczuJnGOlWzURGah
 Uc4s92gzAqUB7bJvFv+HkN2xWdCVI9ISmws21WhUAkK4fCT8hWdzkJdoLJJmeuXYOKWW
 SVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775790156; x=1776394956;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ToBpNTsy8LQOEgY8+uv6QTPSril3IfYYkFbZ2WaPU78=;
 b=m4kpp16uL/zt/IwrqHMf34HLKlfiE+FEWLUcB6l++oYmIRa0r021Ko1LM8FGi6XDzI
 Xe4xMCL32trNu2yaPchxw6I3px7d2hTAd+ifhbuHmcC+l4H9S0/wHwCQi3uvLvq9YFNH
 2BaJR9sLVsm/7cx9ntwzt/COeLCHqqv85kjepUqxfgR2LRlCbYcaZ3gEocnNZ/O2FtJQ
 AJmwy1be8YC+gSwwQ/EKOWAwYwP3ZbOMYHR9Jm4UKjnurv+zlfqV49ZlWfGOqclvruUZ
 HW0H6xPLQqTJfbMPvJoANAMEHbiB45AXth/jM46+HtsKJVbtIgHu+Yp1RH2dXIwRDy11
 hIaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpirdrEFBL9sK1beU6vRNT4JYLoD21ckrlcn4HPMjMK9xpJWwo2g1IZPvxMYBlLghZnGfDyxhUP7Ay@nongnu.org
X-Gm-Message-State: AOJu0Yxu0IaSBrqVjseBCaOYIqDdUAPaOfq9mlSvxV6RZrBbjzV7jpD9
 hAE2JSxUtZe/9B0+SmojYE/Ut+U2O8CM1RcBw0ks4/uigg8ZnWMFpB4RpFi94lu+nVUmvt3LwUF
 5+Va1xLPx495XUiuCkAEIt42O2j+bQaU=
X-Gm-Gg: AeBDietlfyjqwrwcLYRtsaBuYZNgIKdoyCMFqmhEMDQvtkDEntO/0gP1AnYdmhgg0LP
 evd4btaAJSYnVcn7n1Wefqq6TWlgUjLEpuxeILbTmNN/kqm7DjMg81syxweuil1BDdO4Ks76acd
 M5G9yYEeOF/v5iko+CdpcvJ+Qs1DC6BKoGmQvbGW2KbCZuu73udNntWlvMkVp4POJ3g4a76+jwx
 FKwMm4Rr5kcA5WfllxNoQg9y5VrG05h7BnhdU7xFrmsebB/haJnRQURZ/xOGxvM9QtUHs1hZgmo
 aSwHWaFsIKyXHzDyOiadefaztMWSzQ6w0h0p7A==
X-Received: by 2002:a17:907:d1b:b0:b9d:424c:bb0a with SMTP id
 a640c23a62f3a-b9d76dce539mr47487066b.22.1775790155343; Thu, 09 Apr 2026
 20:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <177564643888.23414.7922925369077631439-0@git.sr.ht>
 <177564643888.23414.7922925369077631439-3@git.sr.ht>
In-Reply-To: <177564643888.23414.7922925369077631439-3@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Apr 2026 13:02:08 +1000
X-Gm-Features: AQROBzDbvh03L_9ZwSzO2eChENxjRkBEhiKd4gnzsweAlIKxDqV9KacmRrLkJdo
Message-ID: <CAKmqyKNAx3JuYOvANDOTHD+DdHOZEpdWiSCEw1zu8OBC3_0wKg@mail.gmail.com>
Subject: Re: [PATCH qemu v2 3/7] ot_uart: update register defs, switch to
 Fifo8 for tx/rx buffers
To: "~lexbaileylowrisc" <lex.bailey@lowrisc.org>
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org, 
 Amit Kumar-Hermosillo <amitkh@google.com>, nabihestefan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62b.google.com
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

On Thu, Apr 9, 2026 at 5:52=E2=80=AFAM ~lexbaileylowrisc
<lexbaileylowrisc@git.sr.ht> wrote:
>
> From: Lex Bailey <lex.bailey@lowrisc.org>
>
> The register definitions for the UART device need to be updated to match
> the documentation at https://opentitan.org/book/hw/ip/uart/doc/registers.=
html
>
> This commit does that, and also switches to using Fifo8 for managing the
> transmit and receive buffers.
>
> Signed-off-by: Lex Bailey <lex.bailey@lowrisc.org>
> ---
>  hw/char/ot_uart.c         | 332 ++++++++++++++++++++++----------------
>  include/hw/char/ot_uart.h |  18 +--
>  2 files changed, 196 insertions(+), 154 deletions(-)
>
> diff --git a/hw/char/ot_uart.c b/hw/char/ot_uart.c
> index 2cf0d73cf5..3bf3295b1b 100644
> --- a/hw/char/ot_uart.c
> +++ b/hw/char/ot_uart.c
> @@ -27,6 +27,7 @@
>
>  #include "qemu/osdep.h"
>  #include "hw/char/ot_uart.h"
> +#include "qemu/fifo8.h"
>  #include "hw/core/irq.h"
>  #include "hw/core/qdev-clock.h"
>  #include "hw/core/qdev-properties.h"
> @@ -36,17 +37,24 @@
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>
> +/* clang-format off */

Let's remove these

>  REG32(INTR_STATE, 0x00)
> -    FIELD(INTR_STATE, TX_WATERMARK, 0, 1)
> -    FIELD(INTR_STATE, RX_WATERMARK, 1, 1)
> -    FIELD(INTR_STATE, TX_EMPTY, 2, 1)
> -    FIELD(INTR_STATE, RX_OVERFLOW, 3, 1)
> +    SHARED_FIELD(INTR_TX_WATERMARK, 0, 1)
> +    SHARED_FIELD(INTR_RX_WATERMARK, 1, 1)
> +    SHARED_FIELD(INTR_TX_DONE, 2, 1)
> +    SHARED_FIELD(INTR_RX_OVERFLOW, 3, 1)
> +    SHARED_FIELD(INTR_RX_FRAME_ERR, 4, 1)
> +    SHARED_FIELD(INTR_RX_BREAK_ERR, 5, 1)
> +    SHARED_FIELD(INTR_RX_TIMEOUT, 6, 1)
> +    SHARED_FIELD(INTR_RX_PARITY_ERR, 7, 1)
> +    SHARED_FIELD(INTR_TX_EMPTY, 8, 1)
>  REG32(INTR_ENABLE, 0x04)
>  REG32(INTR_TEST, 0x08)
>  REG32(ALERT_TEST, 0x0C)
> +    FIELD(ALERT_TEST, FATAL_FAULT, 0, 1)
>  REG32(CTRL, 0x10)
> -    FIELD(CTRL, TX_ENABLE, 0, 1)
> -    FIELD(CTRL, RX_ENABLE, 1, 1)
> +    FIELD(CTRL, TX, 0, 1)
> +    FIELD(CTRL, RX, 1, 1)
>      FIELD(CTRL, NF, 2, 1)
>      FIELD(CTRL, SLPBK, 4, 1)
>      FIELD(CTRL, LLPBK, 5, 1)
> @@ -58,43 +66,78 @@ REG32(STATUS, 0x14)
>      FIELD(STATUS, TXFULL, 0, 1)
>      FIELD(STATUS, RXFULL, 1, 1)
>      FIELD(STATUS, TXEMPTY, 2, 1)
> +    FIELD(STATUS, TXIDLE, 3, 1)
>      FIELD(STATUS, RXIDLE, 4, 1)
>      FIELD(STATUS, RXEMPTY, 5, 1)
>  REG32(RDATA, 0x18)
> +    FIELD(RDATA, RDATA, 0, 8)
>  REG32(WDATA, 0x1C)
> +    FIELD(WDATA, WDATA, 0, 8)
>  REG32(FIFO_CTRL, 0x20)
>      FIELD(FIFO_CTRL, RXRST, 0, 1)
>      FIELD(FIFO_CTRL, TXRST, 1, 1)
>      FIELD(FIFO_CTRL, RXILVL, 2, 3)
> -    FIELD(FIFO_CTRL, TXILVL, 5, 2)
> +    FIELD(FIFO_CTRL, TXILVL, 5, 3)
>  REG32(FIFO_STATUS, 0x24)
> -    FIELD(FIFO_STATUS, TXLVL, 0, 5)
> -    FIELD(FIFO_STATUS, RXLVL, 16, 5)
> +    FIELD(FIFO_STATUS, TXLVL, 0, 8)
> +    FIELD(FIFO_STATUS, RXLVL, 16, 8)
>  REG32(OVRD, 0x28)
> +    FIELD(OVRD, TXEN, 0, 1)
> +    FIELD(OVRD, TXVAL, 1, 1)
>  REG32(VAL, 0x2C)
> +    FIELD(VAL, RX, 0, 16)
>  REG32(TIMEOUT_CTRL, 0x30)
> +    FIELD(TIMEOUT_CTRL, VAL, 0, 24)
> +    FIELD(TIMEOUT_CTRL, EN, 31, 1)
> +/* clang-format on */
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
> +#define OT_UART_NCO_BITS     16
> +#define OT_UART_TX_FIFO_SIZE 128
> +#define OT_UART_RX_FIFO_SIZE 128
> +
> +#define R32_OFF(_r_) ((_r_) / sizeof(uint32_t))
> +
> +#define R_LAST_REG (R_TIMEOUT_CTRL)
> +#define REGS_COUNT (R_LAST_REG + 1u)
> +#define REGS_SIZE  (REGS_COUNT * sizeof(uint32_t))
>
>  static void ot_uart_update_irqs(OtUARTState *s)
>  {
> -    if (s->uart_intr_state & s->uart_intr_enable & R_INTR_STATE_TX_WATER=
MARK_MASK) {
> +    if (s->regs[R_INTR_STATE] & s->regs[R_INTR_ENABLE]
> +        & INTR_TX_WATERMARK_MASK) {
>          qemu_set_irq(s->tx_watermark, 1);
>      } else {
>          qemu_set_irq(s->tx_watermark, 0);
>      }
>
> -    if (s->uart_intr_state & s->uart_intr_enable & R_INTR_STATE_RX_WATER=
MARK_MASK) {
> +    if (s->regs[R_INTR_STATE] & s->regs[R_INTR_ENABLE]
> +        & INTR_RX_WATERMARK_MASK) {
>          qemu_set_irq(s->rx_watermark, 1);
>      } else {
>          qemu_set_irq(s->rx_watermark, 0);
>      }
>
> -    if (s->uart_intr_state & s->uart_intr_enable & R_INTR_STATE_TX_EMPTY=
_MASK) {
> +    if (s->regs[R_INTR_STATE] & s->regs[R_INTR_ENABLE] & INTR_TX_EMPTY_M=
ASK) {
>          qemu_set_irq(s->tx_empty, 1);
>      } else {
>          qemu_set_irq(s->tx_empty, 0);
>      }
>
> -    if (s->uart_intr_state & s->uart_intr_enable & R_INTR_STATE_RX_OVERF=
LOW_MASK) {
> +    if (s->regs[R_INTR_STATE] & s->regs[R_INTR_ENABLE]
> +        & INTR_RX_OVERFLOW_MASK) {
>          qemu_set_irq(s->rx_overflow, 1);
>      } else {
>          qemu_set_irq(s->rx_overflow, 0);
> @@ -105,126 +148,133 @@ static int ot_uart_can_receive(void *opaque)
>  {
>      OtUARTState *s =3D opaque;
>
> -    if ((s->uart_ctrl & R_CTRL_RX_ENABLE_MASK)
> -           && !(s->uart_status & R_STATUS_RXFULL_MASK)) {
> -        return 1;
> +    if (s->regs[R_CTRL] & R_CTRL_RX_MASK) {
> +        return (int)fifo8_num_free(&s->rx_fifo);
>      }
>
>      return 0;
>  }
>
> +static uint32_t ot_uart_get_rx_watermark_level(const OtUARTState *s)
> +{
> +    uint32_t rx_ilvl =3D FIELD_EX32(s->regs[R_FIFO_CTRL], FIFO_CTRL, RXI=
LVL);
> +
> +    return rx_ilvl < 7 ? (1 << rx_ilvl) : 126;
> +}
> +
>  static void ot_uart_receive(void *opaque, const uint8_t *buf, int size)
>  {
>      OtUARTState *s =3D opaque;
> -    uint8_t rx_fifo_level =3D (s->uart_fifo_ctrl & R_FIFO_CTRL_RXILVL_MA=
SK)
> -                            >> R_FIFO_CTRL_RXILVL_SHIFT;
> -
> -    s->uart_rdata =3D *buf;
> +    uint32_t rx_watermark_level;
> +    size_t count =3D MIN(fifo8_num_free(&s->rx_fifo), (size_t)size);
>
> -    s->uart_status &=3D ~R_STATUS_RXIDLE_MASK;
> -    s->uart_status &=3D ~R_STATUS_RXEMPTY_MASK;
> -    /* The RXFULL is set after receiving a single byte
> -     * as the FIFO buffers are not yet implemented.
> -     */
> -    s->uart_status |=3D R_STATUS_RXFULL_MASK;
> -    s->rx_level +=3D 1;
> +    for (int index =3D 0; index < size; index++) {
> +        fifo8_push(&s->rx_fifo, buf[index]);
> +    }
>
> -    if (size > rx_fifo_level) {
> -        s->uart_intr_state |=3D R_INTR_STATE_RX_WATERMARK_MASK;
> +    /* update INTR_STATE */
> +    if (count !=3D size) {
> +        s->regs[R_INTR_STATE] |=3D INTR_RX_OVERFLOW_MASK;
> +    }
> +    rx_watermark_level =3D ot_uart_get_rx_watermark_level(s);
> +    if (rx_watermark_level && size >=3D rx_watermark_level) {
> +        s->regs[R_INTR_STATE] |=3D INTR_RX_WATERMARK_MASK;
>      }
>
>      ot_uart_update_irqs(s);
>  }
>
> -static gboolean ot_uart_xmit(void *do_not_use, GIOCondition cond,
> -                             void *opaque)
> +static void ot_uart_reset_tx_fifo(OtUARTState *s)
>  {
> -    OtUARTState *s =3D opaque;
> -    uint8_t tx_fifo_level =3D (s->uart_fifo_ctrl & R_FIFO_CTRL_TXILVL_MA=
SK)
> -                            >> R_FIFO_CTRL_TXILVL_SHIFT;
> -    int ret;
> -
> -    /* instant drain the fifo when there's no back-end */
> -    if (!qemu_chr_fe_backend_connected(&s->chr)) {
> -        s->tx_level =3D 0;
> -        return G_SOURCE_REMOVE;
> +    fifo8_reset(&s->tx_fifo);
> +    s->regs[R_INTR_STATE] |=3D INTR_TX_EMPTY_MASK;
> +    s->regs[R_INTR_STATE] |=3D INTR_TX_DONE_MASK;
> +    if (s->tx_watermark_level) {
> +        s->regs[R_INTR_STATE] |=3D INTR_TX_WATERMARK_MASK;
> +        s->tx_watermark_level =3D 0;
>      }
> +}
>
> -    if (!s->tx_level) {
> -        s->uart_status &=3D ~R_STATUS_TXFULL_MASK;
> -        s->uart_status |=3D R_STATUS_TXEMPTY_MASK;
> -        s->uart_intr_state |=3D R_INTR_STATE_TX_EMPTY_MASK;
> -        s->uart_intr_state &=3D ~R_INTR_STATE_TX_WATERMARK_MASK;
> -        ot_uart_update_irqs(s);
> -        return G_SOURCE_REMOVE;
> +static void ot_uart_reset_rx_fifo(OtUARTState *s)
> +{
> +    fifo8_reset(&s->rx_fifo);
> +    s->regs[R_INTR_STATE] &=3D ~INTR_RX_WATERMARK_MASK;
> +    s->regs[R_INTR_STATE] &=3D ~INTR_RX_OVERFLOW_MASK;
> +    if (FIELD_EX32(s->regs[R_CTRL], CTRL, RX)) {
> +        qemu_chr_fe_accept_input(&s->chr);
>      }
> +}
>
> -    ret =3D qemu_chr_fe_write(&s->chr, s->tx_fifo, s->tx_level);
> +static uint32_t ot_uart_get_tx_watermark_level(const OtUARTState *s)
> +{
> +    uint32_t tx_ilvl =3D FIELD_EX32(s->regs[R_FIFO_CTRL], FIFO_CTRL, TXI=
LVL);
>
> -    if (ret >=3D 0) {
> -        s->tx_level -=3D ret;
> -        memmove(s->tx_fifo, s->tx_fifo + ret, s->tx_level);
> -    }
> +    return tx_ilvl < 7 ? (1 << tx_ilvl) : 64;
> +}
>
> -    if (s->tx_level) {
> -        guint r =3D qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
> -                                        ot_uart_xmit, s);
> -        if (!r) {
> -            s->tx_level =3D 0;
> -            return G_SOURCE_REMOVE;
> -        }
> +static void ot_uart_xmit(OtUARTState *s)
> +{
> +    const uint8_t *buf;
> +    uint32_t size;
> +    int ret;
> +
> +    if (fifo8_is_empty(&s->tx_fifo)) {
> +        return;
>      }
>
> -    /* Clear the TX Full bit */
> -    if (s->tx_level !=3D OT_UART_TX_FIFO_SIZE) {
> -        s->uart_status &=3D ~R_STATUS_TXFULL_MASK;
> +    /* instant drain the fifo when there's no back-end */
> +    if (!qemu_chr_fe_backend_connected(&s->chr)) {
> +        ot_uart_reset_tx_fifo(s);
> +        ot_uart_update_irqs(s);
> +        return;
>      }
>
> -    /* Disable the TX_WATERMARK IRQ */
> -    if (s->tx_level < tx_fifo_level) {
> -        s->uart_intr_state &=3D ~R_INTR_STATE_TX_WATERMARK_MASK;
> +    /* get a continuous buffer from the FIFO */
> +    buf =3D
> +        fifo8_peek_bufptr(&s->tx_fifo, fifo8_num_used(&s->tx_fifo), &siz=
e);
> +    /* send as much as possible */
> +    ret =3D qemu_chr_fe_write(&s->chr, buf, (int)size);
> +    /* if some characters where sent, remove them from the FIFO */
> +    if (ret >=3D 0) {
> +        fifo8_drop(&s->tx_fifo, ret);
>      }
>
> -    /* Set TX empty */
> -    if (s->tx_level =3D=3D 0) {
> -        s->uart_status |=3D R_STATUS_TXEMPTY_MASK;
> -        s->uart_intr_state |=3D R_INTR_STATE_TX_EMPTY_MASK;
> +    /* update INTR_STATE */
> +    if (fifo8_is_empty(&s->tx_fifo)) {
> +        s->regs[R_INTR_STATE] |=3D INTR_TX_EMPTY_MASK;
> +        s->regs[R_INTR_STATE] |=3D INTR_TX_DONE_MASK;
> +    }
> +    if (s->tx_watermark_level &&
> +        fifo8_num_used(&s->tx_fifo) < s->tx_watermark_level) {
> +        s->regs[R_INTR_STATE] |=3D INTR_TX_WATERMARK_MASK;
> +        s->tx_watermark_level =3D 0;
>      }
>
>      ot_uart_update_irqs(s);
> -    return G_SOURCE_REMOVE;
>  }
>
> -static void uart_write_tx_fifo(OtUARTState *s, const uint8_t *buf,
> -                               int size)
> +static void uart_write_tx_fifo(OtUARTState *s, uint8_t val)
>  {
> -    uint64_t current_time =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -    uint8_t tx_fifo_level =3D (s->uart_fifo_ctrl & R_FIFO_CTRL_TXILVL_MA=
SK)
> -                            >> R_FIFO_CTRL_TXILVL_SHIFT;
> -
> -    if (size > OT_UART_TX_FIFO_SIZE - s->tx_level) {
> -        size =3D OT_UART_TX_FIFO_SIZE - s->tx_level;
> +    if (fifo8_is_full(&s->tx_fifo)) {
>          qemu_log_mask(LOG_GUEST_ERROR, "ot_uart: TX FIFO overflow");
> +        return;
>      }
>
> -    memcpy(s->tx_fifo + s->tx_level, buf, size);
> -    s->tx_level +=3D size;
> -
> -    if (s->tx_level > 0) {
> -        s->uart_status &=3D ~R_STATUS_TXEMPTY_MASK;
> -    }
> +    fifo8_push(&s->tx_fifo, val);
>
> -    if (s->tx_level >=3D tx_fifo_level) {
> -        s->uart_intr_state |=3D R_INTR_STATE_TX_WATERMARK_MASK;
> -        ot_uart_update_irqs(s);
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
>      }
>
> -    if (s->tx_level =3D=3D OT_UART_TX_FIFO_SIZE) {
> -        s->uart_status |=3D R_STATUS_TXFULL_MASK;
> +    if (FIELD_EX32(s->regs[R_CTRL], CTRL, TX)) {
> +        ot_uart_xmit(s);
>      }
> -
> -    timer_mod(s->fifo_trigger_handle, current_time +
> -              (s->char_tx_time * 4));

What about the timer?

Alistair

>  }
>
>  static void ot_uart_reset_enter(Object *obj, ResetType type)
> @@ -236,17 +286,13 @@ static void ot_uart_reset_enter(Object *obj, ResetT=
ype type)
>          c->parent_phases.enter(obj, type);
>      }
>
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
> +    memset(&s->regs[0], 0, sizeof(s->regs));
> +
> +    s->regs[R_STATUS] =3D 0x0000003c;
> +
> +    s->tx_watermark_level =3D 0;
> +    ot_uart_reset_tx_fifo(s);
> +    ot_uart_reset_rx_fifo(s);
>
>      s->tx_level =3D 0;
>      s->rx_level =3D 0;
> @@ -260,7 +306,7 @@ static uint64_t ot_uart_get_baud(OtUARTState *s)
>  {
>      uint64_t baud;
>
> -    baud =3D ((s->uart_ctrl & R_CTRL_NCO_MASK) >> 16);
> +    baud =3D ((s->regs[R_CTRL] & R_CTRL_NCO_MASK) >> 16);
>      baud *=3D clock_get_hz(s->f_clk);
>      baud >>=3D 20;
>
> @@ -274,10 +320,10 @@ static uint64_t ot_uart_read(void *opaque, hwaddr a=
ddr, unsigned int size)
>
>      switch (addr >> 2) {
>      case R_INTR_STATE:
> -        retvalue =3D s->uart_intr_state;
> +        retvalue =3D s->regs[R_INTR_STATE];
>          break;
>      case R_INTR_ENABLE:
> -        retvalue =3D s->uart_intr_enable;
> +        retvalue =3D s->regs[R_INTR_ENABLE];
>          break;
>      case R_INTR_TEST:
>          qemu_log_mask(LOG_GUEST_ERROR,
> @@ -285,22 +331,22 @@ static uint64_t ot_uart_read(void *opaque, hwaddr a=
ddr, unsigned int size)
>          break;
>
>      case R_CTRL:
> -        retvalue =3D s->uart_ctrl;
> +        retvalue =3D s->regs[R_CTRL];
>          break;
>      case R_STATUS:
> -        retvalue =3D s->uart_status;
> +        retvalue =3D s->regs[R_STATUS];
>          break;
>
>      case R_RDATA:
> -        retvalue =3D s->uart_rdata;
> -        if ((s->uart_ctrl & R_CTRL_RX_ENABLE_MASK) && (s->rx_level > 0))=
 {
> +        retvalue =3D s->regs[R_RDATA];
> +        if ((s->regs[R_CTRL] & R_CTRL_RX_MASK) && (s->rx_level > 0)) {
>              qemu_chr_fe_accept_input(&s->chr);
>
>              s->rx_level -=3D 1;
> -            s->uart_status &=3D ~R_STATUS_RXFULL_MASK;
> +            s->regs[R_STATUS] &=3D ~R_STATUS_RXFULL_MASK;
>              if (s->rx_level =3D=3D 0) {
> -                s->uart_status |=3D R_STATUS_RXIDLE_MASK;
> -                s->uart_status |=3D R_STATUS_RXEMPTY_MASK;
> +                s->regs[R_STATUS] |=3D R_STATUS_RXIDLE_MASK;
> +                s->regs[R_STATUS] |=3D R_STATUS_RXEMPTY_MASK;
>              }
>          }
>          break;
> @@ -310,10 +356,10 @@ static uint64_t ot_uart_read(void *opaque, hwaddr a=
ddr, unsigned int size)
>          break;
>
>      case R_FIFO_CTRL:
> -        retvalue =3D s->uart_fifo_ctrl;
> +        retvalue =3D s->regs[R_FIFO_CTRL];
>          break;
>      case R_FIFO_STATUS:
> -        retvalue =3D s->uart_fifo_status;
> +        retvalue =3D s->regs[R_FIFO_STATUS];
>
>          retvalue |=3D (s->rx_level & 0x1F) << R_FIFO_STATUS_RXLVL_SHIFT;
>          retvalue |=3D (s->tx_level & 0x1F) << R_FIFO_STATUS_TXLVL_SHIFT;
> @@ -323,17 +369,17 @@ static uint64_t ot_uart_read(void *opaque, hwaddr a=
ddr, unsigned int size)
>          break;
>
>      case R_OVRD:
> -        retvalue =3D s->uart_ovrd;
> +        retvalue =3D s->regs[R_OVRD];
>          qemu_log_mask(LOG_UNIMP,
>                        "%s: ovrd is not supported\n", __func__);
>          break;
>      case R_VAL:
> -        retvalue =3D s->uart_val;
> +        retvalue =3D s->regs[R_VAL];
>          qemu_log_mask(LOG_UNIMP,
>                        "%s: val is not supported\n", __func__);
>          break;
>      case R_TIMEOUT_CTRL:
> -        retvalue =3D s->uart_timeout_ctrl;
> +        retvalue =3D s->regs[R_TIMEOUT_CTRL];
>          qemu_log_mask(LOG_UNIMP,
>                        "%s: timeout_ctrl is not supported\n", __func__);
>          break;
> @@ -355,20 +401,20 @@ static void ot_uart_write(void *opaque, hwaddr addr=
, uint64_t val64,
>      switch (addr >> 2) {
>      case R_INTR_STATE:
>          /* Write 1 clear */
> -        s->uart_intr_state &=3D ~value;
> +        s->regs[R_INTR_STATE] &=3D ~value;
>          ot_uart_update_irqs(s);
>          break;
>      case R_INTR_ENABLE:
> -        s->uart_intr_enable =3D value;
> +        s->regs[R_INTR_ENABLE] =3D value;
>          ot_uart_update_irqs(s);
>          break;
>      case R_INTR_TEST:
> -        s->uart_intr_state |=3D value;
> +        s->regs[R_INTR_STATE] |=3D value;
>          ot_uart_update_irqs(s);
>          break;
>
>      case R_CTRL:
> -        s->uart_ctrl =3D value;
> +        s->regs[R_CTRL] =3D value;
>
>          if (value & R_CTRL_NF_MASK) {
>              qemu_log_mask(LOG_UNIMP,
> @@ -412,11 +458,11 @@ static void ot_uart_write(void *opaque, hwaddr addr=
, uint64_t val64,
>                        "%s: rdata is read only\n", __func__);
>          break;
>      case R_WDATA:
> -        uart_write_tx_fifo(s, (uint8_t *) &value, 1);
> +        uart_write_tx_fifo(s, value);
>          break;
>
>      case R_FIFO_CTRL:
> -        s->uart_fifo_ctrl =3D value;
> +        s->regs[R_FIFO_CTRL] =3D value;
>
>          if (value & R_FIFO_CTRL_RXRST_MASK) {
>              s->rx_level =3D 0;
> @@ -433,7 +479,7 @@ static void ot_uart_write(void *opaque, hwaddr addr, =
uint64_t val64,
>          break;
>
>      case R_OVRD:
> -        s->uart_ovrd =3D value;
> +        s->regs[R_OVRD] =3D value;
>          qemu_log_mask(LOG_UNIMP,
>                        "%s: ovrd is not supported\n", __func__);
>          break;
> @@ -442,7 +488,7 @@ static void ot_uart_write(void *opaque, hwaddr addr, =
uint64_t val64,
>                        "%s: val is read only\n", __func__);
>          break;
>      case R_TIMEOUT_CTRL:
> -        s->uart_timeout_ctrl =3D value;
> +        s->regs[R_TIMEOUT_CTRL] =3D value;
>          qemu_log_mask(LOG_UNIMP,
>                        "%s: timeout_ctrl is not supported\n", __func__);
>          break;
> @@ -466,8 +512,8 @@ static void fifo_trigger_update(void *opaque)
>  {
>      OtUARTState *s =3D opaque;
>
> -    if (s->uart_ctrl & R_CTRL_TX_ENABLE_MASK) {
> -        ot_uart_xmit(NULL, G_IO_OUT, s);
> +    if (s->regs[R_CTRL] & R_CTRL_TX_MASK) {
> +        ot_uart_xmit(s);
>      }
>  }
>
> @@ -489,25 +535,17 @@ static int ot_uart_post_load(void *opaque, int vers=
ion_id)
>
>  static const VMStateDescription vmstate_ot_uart =3D {
>      .name =3D TYPE_OT_UART,
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> +    .version_id =3D 2,
> +    .minimum_version_id =3D 2,
>      .post_load =3D ot_uart_post_load,
>      .fields =3D (const VMStateField[]) {
> -        VMSTATE_UINT8_ARRAY(tx_fifo, OtUARTState,
> -                            OT_UART_TX_FIFO_SIZE),
> +        VMSTATE_STRUCT(tx_fifo, OtUARTState, 1, vmstate_fifo8, Fifo8),
> +        VMSTATE_STRUCT(rx_fifo, OtUARTState, 1, vmstate_fifo8, Fifo8),
>          VMSTATE_UINT32(tx_level, OtUARTState),
>          VMSTATE_UINT64(char_tx_time, OtUARTState),
>          VMSTATE_TIMER_PTR(fifo_trigger_handle, OtUARTState),
> -        VMSTATE_UINT32(uart_intr_state, OtUARTState),
> -        VMSTATE_UINT32(uart_intr_enable, OtUARTState),
> -        VMSTATE_UINT32(uart_ctrl, OtUARTState),
> -        VMSTATE_UINT32(uart_status, OtUARTState),
> -        VMSTATE_UINT32(uart_rdata, OtUARTState),
> -        VMSTATE_UINT32(uart_fifo_ctrl, OtUARTState),
> -        VMSTATE_UINT32(uart_fifo_status, OtUARTState),
> -        VMSTATE_UINT32(uart_ovrd, OtUARTState),
> -        VMSTATE_UINT32(uart_val, OtUARTState),
> -        VMSTATE_UINT32(uart_timeout_ctrl, OtUARTState),
> +        VMSTATE_ARRAY(regs, OtUARTState, REGS_COUNT, 1, vmstate_info_uin=
t32,
> +                      uint32_t),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> @@ -532,6 +570,13 @@ static void ot_uart_init(Object *obj)
>      memory_region_init_io(&s->mmio, obj, &ot_uart_ops, s,
>                            TYPE_OT_UART, 0x400);
>      sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +
> +    /*
> +     * This array has a fixed size in the header. This assertion is used=
 to
> +     * check that it is consistent with the definition in this file. Thi=
s is
> +     * ostensibly a runtime check, but may be optimised away by the comp=
iler.
> +     */
> +    assert(REGS_SIZE =3D=3D sizeof(s->regs));
>  }
>
>  static void ot_uart_realize(DeviceState *dev, Error **errp)
> @@ -541,6 +586,9 @@ static void ot_uart_realize(DeviceState *dev, Error *=
*errp)
>      s->fifo_trigger_handle =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
>                                            fifo_trigger_update, s);
>
> +    fifo8_create(&s->tx_fifo, OT_UART_TX_FIFO_SIZE);
> +    fifo8_create(&s->rx_fifo, OT_UART_RX_FIFO_SIZE);
> +
>      qemu_chr_fe_set_handlers(&s->chr, ot_uart_can_receive,
>                               ot_uart_receive, NULL, NULL,
>                               s, NULL, true);
> diff --git a/include/hw/char/ot_uart.h b/include/hw/char/ot_uart.h
> index fee2128f90..f489612700 100644
> --- a/include/hw/char/ot_uart.h
> +++ b/include/hw/char/ot_uart.h
> @@ -26,11 +26,11 @@
>  #define HW_OT_UART_H
>
>  #include "hw/core/sysbus.h"
> +#include "qemu/fifo8.h"
>  #include "chardev/char-fe.h"
>  #include "qemu/timer.h"
>  #include "qom/object.h"
>
> -#define OT_UART_TX_FIFO_SIZE 16
>  #define OT_UART_CLOCK 50000000 /* 50MHz clock */
>
>  #define TYPE_OT_UART "ot-uart"
> @@ -43,7 +43,6 @@ struct OtUARTState {
>      /* <public> */
>      MemoryRegion mmio;
>
> -    uint8_t tx_fifo[OT_UART_TX_FIFO_SIZE];
>      uint32_t tx_level;
>
>      uint32_t rx_level;
> @@ -51,16 +50,11 @@ struct OtUARTState {
>      QEMUTimer *fifo_trigger_handle;
>      uint64_t char_tx_time;
>
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
> +    uint32_t regs[13]; /* Length must be updated if regs added or remove=
d */
> +
> +    Fifo8 tx_fifo;
> +    Fifo8 rx_fifo;
> +    uint32_t tx_watermark_level;
>
>      Clock *f_clk;
>
> --
> 2.49.1
>
>

