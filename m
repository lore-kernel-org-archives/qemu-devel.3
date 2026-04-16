Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C18F433D0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 01:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDBhE-0005u3-Qh; Wed, 15 Apr 2026 21:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDBh0-0005tB-S9
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 21:38:56 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDBgv-0003bN-AU
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 21:38:53 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b9c3e2cf3c0so1159279566b.1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 18:38:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776303525; cv=none;
 d=google.com; s=arc-20240605;
 b=HxPK/gW3qpp/U+sHngCm7RWBRuNkr9F6Blh8YKrQ2xKpp2SDz+mf2O6elHsSAknGof
 Caxr23p1GkJs1kBX40ilUJI0HEhb8N6NOLvD37Qf5xfhazr/+Byesf94H2hNSsQUgqq9
 +ih+ddPnDOzgsnAbwKRVNrCQeJQWWAmAjkH71fmUvilxTZ03bRaRlLmxFhUBm+ZMiaxq
 u24WtPblrYlpFBRxxG2l3Kb/WuS1AEMvxRTeqTXVINHwHiqrn9Cv1kWMrqQzGEuuvWbP
 GryZpGrsj+xr4zrxi/1ZNX55vBul8fIQhEfde+Tx1/6BSqY7VlrIn0stBqTLXPhW3Ece
 sWQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2ZfyBiEuHN1Geam6pYSOIf1f/NoDbCSpz/6raqzQG/o=;
 fh=jwgmpw1GXnXWcWGKDA9e7Tre/5P08QaJDagsXORKY7A=;
 b=TNaY8K0sLVT1xkmCKx7XMgW4Ls83bD2XD5kUlu1iXrhpt1OsZElOSsT6DqjHqQBRjs
 OZOyNJILEWsrsgXEP2HrpDnqKwJnign8mwbTY+Z50UAJBIaIAh6zKau1jK7o6iyKRT/w
 vfgpFPIRH9eqrQIvmV88yr62++Aghx5/BL4zWt3O+wxQJXU5GyT8HqOs1V8A+NLAdb+0
 UWGDN8NBzxMU9lnCFaEUE8pnb1xQRNVg1d+56YS0koSI1EVA6XgEf3pYBgWkvWN0Xjq5
 WFYtND1ulvXT/jFOckiuolj/0dNyxxRh/fYkXOWpuqEmrCHK7A7fwqtuhFcA0m+O9uyt
 tK5w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776303525; x=1776908325; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ZfyBiEuHN1Geam6pYSOIf1f/NoDbCSpz/6raqzQG/o=;
 b=lufUoyUkZZGezJXFp04Ice+3Vym1VXtfuZ90ZmXYzMoeZLyp1P+p6tg1gogYgMOzKT
 McLw1xZPCneKF4TEko/T4aaEXygypf0iWz3fkvjmosva5v8oGKkYVJCQy18WCCS5qbMZ
 o2PKHfZkpzTrrdymGtGy95PNQj0ASCjvm71gqTU0il5vCUDVupE31Nzv64MpBzTrSXRT
 aWrqKLd/tFtUZknH/6cVasxy/85un5jATKF1EoaCzYwsOD1XIka2dd3sYYQi7VI10U5/
 iE8GUZs0CXlP9dknJ1Uvf965c6dCfD7NcK8T05NmDwcLNz5bzo03CPwgjEnGiu4nddoX
 THgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776303525; x=1776908325;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2ZfyBiEuHN1Geam6pYSOIf1f/NoDbCSpz/6raqzQG/o=;
 b=F4ZKDVu1DDcQbqw1ZSpWMdgynVHc5kntaoYPoWj4rW6fr/+jCSh39rXP6/mZ/VnNQK
 JRetDqmFszDVbHdGKnvJkfqEAptSFy2QzI6LVLAzdZo5J8BzBV+NDk0yILG8QyyKPGNX
 zqb4ap15iPhwmGRgxWAFdwClVgJOh2HS7lUsqgYCvSpwQQGuE63aRQ6Fowtr22W8j7/o
 jIjyJ4n6Se3ki/uvTnHoHYHer+xYU8InOwhBU11/zIq12DQFcS0FQBl2M7wNNIUzKAlp
 6R3CNRXzkVPUQ9IHGRjkkI6K2mxxhDz4vezcPP6lULWWpgsrRvSprwPuS5oaTs7dobY8
 d4mA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9bnX31KgU2uWMY3fS30O5TMzsgZ5Q7Pr0msbsjyaPH944b4bliMDZaQLm1MUCFqtlAVfeHhcq7sS5U@nongnu.org
X-Gm-Message-State: AOJu0YwuvanTCCgGYNaMFc/PfSOBknlq7PJE0mZn1vPEkgOxBvm1reMR
 00zIGVsytHRNHe643NzkGNJa1axXImtqTtYgutNYQkiGTJyZ0bbg0L7uhtApi+Sm9zp9tQ0xEN6
 BYFrLj2FWB2TCdZ3HvU910o5iLVn8el0=
X-Gm-Gg: AeBDieuVfOmwSWU3gma5sMnlipyFXfN9rkDwkpTlomqiUcS7+MytW1xK1UxjLMJUJIj
 zuKULXyfuZH/xHtYxl3KMQBGly9M3EYwxSlXeODc+k6h6o+2ah12vR8ZOOeMnhvLB3VjrOFAc/B
 zfMPE1bYsaP65/1DxcyMvBdNSWuo7btpNhN9tJw/rMWZA4I2/SOrCtbVnWO+gmYRZrI3A6aSkRg
 ADs9Riy92Z+qG408HPZ0bLqDykambI9ga/yBmsKkzrkoiun0b+4vUZTWheV9M9nRarMgi+EGtot
 +yloSA+mWAwNaASn40TcKyz4drAR3zi3qPBe2g==
X-Received: by 2002:a17:907:981:b0:b9c:9dcb:36e8 with SMTP id
 a640c23a62f3a-b9d7294f263mr1349210366b.53.1776303525165; Wed, 15 Apr 2026
 18:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <177618728515.4917.14466194789826252277-0@git.sr.ht>
 <177618728515.4917.14466194789826252277-6@git.sr.ht>
In-Reply-To: <177618728515.4917.14466194789826252277-6@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Apr 2026 11:38:18 +1000
X-Gm-Features: AQROBzCeam9sJKKPVe4R_UY1tZLeJ_AMTHJx4Q9L5YAIZGbq8WgKDuUozGNYdOA
Message-ID: <CAKmqyKNYx6qe+4P3wQj6_QCa7K8LUrk6k_6JfdDJh+Y_-CJSFQ@mail.gmail.com>
Subject: Re: [PATCH qemu v3 06/10] ot_uart: implement RX fifo and loopback
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
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Apr 15, 2026 at 3:23=E2=80=AFAM ~lexbaileylowrisc
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

Maybe a return here so the rest of the function doesn't have to be in an el=
se

Alistair

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

