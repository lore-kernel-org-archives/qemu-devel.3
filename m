Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B7BCD5BB4
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 04:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRjBE-0003e6-PU; Tue, 26 May 2026 00:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wRjBC-0003dH-TB
 for qemu-devel@nongnu.org; Tue, 26 May 2026 00:14:10 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wRjBA-0006Ya-9I
 for qemu-devel@nongnu.org; Tue, 26 May 2026 00:14:10 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bd56d108454so1830136466b.2
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 21:14:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779768846; cv=none;
 d=google.com; s=arc-20240605;
 b=Vusrw9dhNDUDDSJBbyFUnWKm9bis2xHh5iS0cVMBHEVkOGKYXQgh7jLLkhqQTfmrhx
 IxAq3AlJu97/GRG75xOytjc95hy1Cfo0YKqeugWLaSuelXRlfyWqsy25KjXz44cs39gN
 LVhGBQzsgWUVQ53F8mFH4XjREMueNsk//QYetM58A5D1o6DJDuWRpHkXo2IKamOo688P
 VpgOJyuZxMHEonCpwbxHDV+Zf6sbegytUbaSErTOl0WXfTPFeGVgnTgeX8ddEt0cHWpX
 8EWaOoIjvXPnf0oOkbjP7LP9H78v4lv44JxbhfbtBaDeqjzJQO7xiSCxAkFeP3rWx4/m
 Rgpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Jm4cF+ExQ+CB7DRiBDseRtNTIFjbJgZ956XjkqygQlY=;
 fh=Z5J8e1wXZTFt5rQ+kCS4QgV6wPLGneq0xoXcbU8Vu50=;
 b=IZS8rDWuJmi6ZCa/eS2TeV5cHQUy6TE9QulkF0YFxgyTvN75S4loSG3R6uEAd5hTRf
 f0X9zU4qLzHb5cuvcCctJ1saryLeFbX82hfUHmo24QkYM6eCWG7WQ1oU7ZycjauoC49W
 S+s6tBzHTMcfYkzlFraa1/K4Sz83EZQcUIC3hdfZz9ErjU0jbr4VU3Ldyl/hC9UvD0qU
 F3JHvxLASpx8gcVjgXCGneU3/UCZ8IyVmjDm18cT0xKnpmBS1Hupwhenb311JlKNs1Da
 nCX8xbQodu4FGf2wK84d1YWOjbd9+revZpti1jul/OYgRkPvYKBVbWdLKmWiWNXfmuZ9
 eMpQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779768846; x=1780373646; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jm4cF+ExQ+CB7DRiBDseRtNTIFjbJgZ956XjkqygQlY=;
 b=r//91e+Qf0g2UuTZc6YRcgSodpbPtmtqtRAajFh8cAYg8ZxFAfDLK2ED6Qoi5Bxje5
 Y768QJyp1ob7FL5Nc5o5zDpOtHdFrymqLYLSwmNbaXtEaDcim1EHgXKv/Oqsh7QeGhGH
 iAdA8TS08uIf4/sQVtwXavitCG3+WSitPnD3Yjvj21vwNu/g1Kye52PsTMNWMRshIXfB
 nc2cdXtPWqqjmX4NpCjifTmHhjNcF6SZ0iyrXQx5oDWBmxBtBjQAknPXDHXTSRZ2ByUw
 /6dOlZcCWTLCDNvGr5WPp5dCBaw6d5hG5gcKGvtka1HYoK/xzMA7+jxbJ5Vo1W7rzL1k
 AwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779768846; x=1780373646;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jm4cF+ExQ+CB7DRiBDseRtNTIFjbJgZ956XjkqygQlY=;
 b=r4FbbNS2EUK+2qV3M1Aailt5peslS1w7efhIP5cBJne7Epe2FOWNAa+e4zpSW7kL9m
 bnVUpXDaFYDiclS7fEqxZNOYNFD2n2wfJ8jA/ovJ17TjtnHQOvs4+rkL4804Q9BvSv0/
 BR0Y00rF4zfLP+9aWGsmXUCZ7mgEiHK1tgiG1kUlnSU8/iQjMW7ycVK7e8epK1yBWLkl
 ucZtCVMGPr5FeazayzMXtJj5NtO9MpVgczPylE7Aj5xX74ZF+YT29OfH6v2jxUCZSuRM
 mjUbiMGq/zMjvheHH0p5ZQMGIF/dCYmu7PNLWmJtVsyh5hCQ3hBuQv1fyyuzCAZuD+ga
 lqmg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Yx2choxr9jdqe9aboHpk4XhDDZZGWQq3SnoRIbe/HUkXF2WCT8d4iz6Lv364xfytrsEA0vMoMeHDY@nongnu.org
X-Gm-Message-State: AOJu0Yy9uPEdw8nrlpbNGrK+jQpRsrYWZPjVbNGeALsYTrhIj7fJMiL9
 sEAvYmwofqhlxYj59KXO0suvkkdsQuJUJ+/MuIF1nRgsrgDcjV5psRyTLHpIoUFK7JMWpSUojiR
 yaIcyB+XxugjUl2WgzBEkcS2YGWAL9mw=
X-Gm-Gg: Acq92OFzkE5v1vMgi2sVdxyHQDSX7k3ZdPKfgrBKZNEhln3EprkzO1ZdMZ3RhKaCu1v
 qEZ6cZwTlEX8mefNXpoHFninbu1RdDvzBg2HgCuENkAsmC5NJ4ON6fH3TaNm5pQdahdSbPhyjTE
 QeIQUha16oT9HnPLRoVUheYDvuGLK+bj7A9rJJO6LfRFzbGA+tKrnm3y9y/QvRIjq/EBDZLo1r9
 C+LWatYXgRGG1lFJHKq9glFZRXErD+o5c4eYY+Jf7mzuEHehMJ0zNHq96kdo+5RVDJelQ+o4LxY
 GhbyiTELKMamFfxigXEjpHx0b3Dbld8TohSLcf5pALmWoyLc
X-Received: by 2002:a17:907:7290:b0:bd2:4aa6:1a9d with SMTP id
 a640c23a62f3a-bdd2360237fmr1053015766b.16.1779768846290; Mon, 25 May 2026
 21:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <177756498815.8917.12449488721849651971-0@git.sr.ht>
 <177756498815.8917.12449488721849651971-6@git.sr.ht>
In-Reply-To: <177756498815.8917.12449488721849651971-6@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 May 2026 14:13:39 +1000
X-Gm-Features: AVHnY4JKRZz-AmAFAWFHWvzL-_H8fq6RJbvzCZXPhbnkD4-r_hbEQhp0u0urYgY
Message-ID: <CAKmqyKM7XCgAghGtMrPnd=NFweWNuiwR8E2Y-VnA7axa+gky8w@mail.gmail.com>
Subject: Re: [PATCH qemu v4 6/9] ot_uart: implement RX fifo and loopback
To: "~lexbaileylowrisc" <lex.bailey@lowrisc.org>
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org, 
 Amit Kumar-Hermosillo <amitkh@google.com>,
 nabihestefan <nabihestefan@google.com>
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

On Fri, May 1, 2026 at 2:05=E2=80=AFAM ~lexbaileylowrisc
<lexbaileylowrisc@git.sr.ht> wrote:
>
> From: Lex Bailey <lex.bailey@lowrisc.org>
>
> The STATUS register value is now generated on every read instead of being
> tracked in memory since it has such a dynamic value. the receive fifo is =
now
> implemented, and the system loopback mode. (line loopback is not supporte=
d)
>
> Signed-off-by: Lex Bailey <lex.bailey@lowrisc.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/char/ot_uart.c | 160 ++++++++++++++++++++++++++++++++--------------
>  1 file changed, 112 insertions(+), 48 deletions(-)
>
> diff --git a/hw/char/ot_uart.c b/hw/char/ot_uart.c
> index 2247db7110..3511a42fbe 100644
> --- a/hw/char/ot_uart.c
> +++ b/hw/char/ot_uart.c
> @@ -140,6 +140,21 @@ static void ot_uart_update_irqs(OtUARTState *s)
>      }
>  }
>
> +static bool ot_uart_is_sys_loopack_enabled(const OtUARTState *s)
> +{
> +    return FIELD_EX32(s->regs[R_CTRL], CTRL, SLPBK);
> +}
> +
> +static bool ot_uart_is_tx_enabled(const OtUARTState *s)
> +{
> +    return FIELD_EX32(s->regs[R_CTRL], CTRL, TX);
> +}
> +
> +static bool ot_uart_is_rx_enabled(const OtUARTState *s)
> +{
> +    return FIELD_EX32(s->regs[R_CTRL], CTRL, RX);
> +}
> +
>  static int ot_uart_can_receive(void *opaque)
>  {
>      OtUARTState *s =3D opaque;
> @@ -196,7 +211,7 @@ static void ot_uart_reset_rx_fifo(OtUARTState *s)
>      fifo8_reset(&s->rx_fifo);
>      s->regs[R_INTR_STATE] &=3D ~INTR_RX_WATERMARK_MASK;
>      s->regs[R_INTR_STATE] &=3D ~INTR_RX_OVERFLOW_MASK;
> -    if (FIELD_EX32(s->regs[R_CTRL], CTRL, RX)) {
> +    if (ot_uart_is_rx_enabled(s)) {
>          qemu_chr_fe_accept_input(&s->chr);
>      }
>  }
> @@ -218,21 +233,37 @@ static void ot_uart_xmit(OtUARTState *s)
>          return;
>      }
>
> -    /* instant drain the fifo when there's no back-end */
> -    if (!qemu_chr_fe_backend_connected(&s->chr)) {
> -        ot_uart_reset_tx_fifo(s);
> -        ot_uart_update_irqs(s);
> -        return;
> -    }
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
>
> -    /* get a continuous buffer from the FIFO */
> -    buf =3D
> -        fifo8_peek_bufptr(&s->tx_fifo, fifo8_num_used(&s->tx_fifo), &siz=
e);
> -    /* send as much as possible */
> -    ret =3D qemu_chr_fe_write(&s->chr, buf, (int)size);
> -    /* if some characters where sent, remove them from the FIFO */
> -    if (ret >=3D 0) {
> -        fifo8_drop(&s->tx_fifo, ret);
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
>      }
>
>      /* update INTR_STATE */
> @@ -269,7 +300,7 @@ static void uart_write_tx_fifo(OtUARTState *s, uint8_=
t val)
>          s->tx_watermark_level =3D 0;
>      }
>
> -    if (FIELD_EX32(s->regs[R_CTRL], CTRL, TX)) {
> +    if (ot_uart_is_tx_enabled(s)) {
>          ot_uart_xmit(s);
>      }
>
> @@ -288,8 +319,6 @@ static void ot_uart_reset_enter(Object *obj, ResetTyp=
e type)
>
>      memset(&s->regs[0], 0, sizeof(s->regs));
>
> -    s->regs[R_STATUS] =3D 0x0000003c;
> -
>      s->tx_watermark_level =3D 0;
>      for (unsigned index =3D 0; index < ARRAY_SIZE(s->irqs); index++) {
>          qemu_set_irq(s->irqs[index], 0);
> @@ -305,6 +334,27 @@ static void ot_uart_reset_enter(Object *obj, ResetTy=
pe type)
>      ot_uart_update_irqs(s);
>  }
>
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
>  static uint64_t ot_uart_get_baud(OtUARTState *s)
>  {
>      uint64_t baud;
> @@ -327,32 +377,50 @@ static uint64_t ot_uart_read(void *opaque, hwaddr a=
ddr, unsigned int size)
>      case R_INTR_ENABLE:
>      case R_CTRL:
>      case R_FIFO_CTRL:
> -    case R_STATUS:
>          retvalue =3D s->regs[reg];
>          break;
> +    case R_STATUS:
> +        /* assume that UART always report RXIDLE */
> +        retvalue =3D R_STATUS_RXIDLE_MASK;
> +        /* report RXEMPTY or RXFULL */
> +        switch (fifo8_num_used(&s->rx_fifo)) {
> +        case 0:
> +            retvalue |=3D R_STATUS_RXEMPTY_MASK;
> +            break;
> +        case OT_UART_RX_FIFO_SIZE:
> +            retvalue |=3D R_STATUS_RXFULL_MASK;
> +            break;
> +        default:
> +            break;
> +        }
> +        /* report TXEMPTY+TXIDLE or TXFULL */
> +        switch (fifo8_num_used(&s->tx_fifo)) {
> +        case 0:
> +            retvalue |=3D R_STATUS_TXEMPTY_MASK | R_STATUS_TXIDLE_MASK;
> +            break;
> +        case OT_UART_TX_FIFO_SIZE:
> +            retvalue |=3D R_STATUS_TXFULL_MASK;
> +            break;
> +        default:
> +            break;
> +        }
> +        if (!ot_uart_is_tx_enabled(s)) {
> +            retvalue |=3D R_STATUS_TXIDLE_MASK;
> +        }
> +        if (!ot_uart_is_rx_enabled(s)) {
> +            retvalue |=3D R_STATUS_RXIDLE_MASK;
> +        }
> +        break;
>
>      case R_RDATA:
> -        retvalue =3D s->regs[R_RDATA];
> -        if ((s->regs[R_CTRL] & R_CTRL_RX_MASK) && (s->rx_level > 0)) {
> -            qemu_chr_fe_accept_input(&s->chr);
> -
> -            s->rx_level -=3D 1;
> -            s->regs[R_STATUS] &=3D ~R_STATUS_RXFULL_MASK;
> -            if (s->rx_level =3D=3D 0) {
> -                s->regs[R_STATUS] |=3D R_STATUS_RXIDLE_MASK;
> -                s->regs[R_STATUS] |=3D R_STATUS_RXEMPTY_MASK;
> -            }
> -        }
> +        retvalue =3D (uint32_t)ot_uart_read_rx_fifo(s);
>          break;
>
>      case R_FIFO_STATUS:
> -        retvalue =3D s->regs[R_FIFO_STATUS];
> -
> -        retvalue |=3D (s->rx_level & 0x1F) << R_FIFO_STATUS_RXLVL_SHIFT;
> -        retvalue |=3D (s->tx_level & 0x1F) << R_FIFO_STATUS_TXLVL_SHIFT;
> -
> -        qemu_log_mask(LOG_UNIMP,
> -                      "%s: RX fifos are not supported\n", __func__);
> +        retvalue =3D
> +            (fifo8_num_used(&s->rx_fifo) & 0xffu) << R_FIFO_STATUS_RXLVL=
_SHIFT;
> +        retvalue |=3D
> +            (fifo8_num_used(&s->tx_fifo) & 0xffu) << R_FIFO_STATUS_TXLVL=
_SHIFT;
>          break;
>
>      case R_VAL:
> @@ -416,10 +484,6 @@ static void ot_uart_write(void *opaque, hwaddr addr,=
 uint64_t val64,
>              qemu_log_mask(LOG_UNIMP,
>                            "%s: UART_CTRL_NF is not supported\n", __func_=
_);
>          }
> -        if (value & R_CTRL_SLPBK_MASK) {
> -            qemu_log_mask(LOG_UNIMP,
> -                          "%s: UART_CTRL_SLPBK is not supported\n", __fu=
nc__);
> -        }
>          if (value & R_CTRL_LLPBK_MASK) {
>              qemu_log_mask(LOG_UNIMP,
>                            "%s: UART_CTRL_LLPBK is not supported\n", __fu=
nc__);
> @@ -445,19 +509,19 @@ static void ot_uart_write(void *opaque, hwaddr addr=
, uint64_t val64,
>          }
>          break;
>      case R_WDATA:
> -        uart_write_tx_fifo(s, value);
> +        uart_write_tx_fifo(s, (uint8_t)(value & R_WDATA_WDATA_MASK));
>          break;
>
>      case R_FIFO_CTRL:
> -        s->regs[R_FIFO_CTRL] =3D value;
> -
> +        s->regs[R_FIFO_CTRL] =3D
> +            value & (R_FIFO_CTRL_RXILVL_MASK | R_FIFO_CTRL_TXILVL_MASK);
>          if (value & R_FIFO_CTRL_RXRST_MASK) {
> -            s->rx_level =3D 0;
> -            qemu_log_mask(LOG_UNIMP,
> -                          "%s: RX fifos are not supported\n", __func__);
> +            ot_uart_reset_rx_fifo(s);
> +            ot_uart_update_irqs(s);
>          }
>          if (value & R_FIFO_CTRL_TXRST_MASK) {
> -            s->tx_level =3D 0;
> +            ot_uart_reset_tx_fifo(s);
> +            ot_uart_update_irqs(s);
>          }
>          break;
>      case R_OVRD:
> --
> 2.49.1
>
>

