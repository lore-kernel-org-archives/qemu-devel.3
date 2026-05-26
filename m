Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B47CD5BB4
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 03:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRiwT-00014i-T0; Mon, 25 May 2026 23:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wRiwP-00013f-8o
 for qemu-devel@nongnu.org; Mon, 25 May 2026 23:58:54 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wRiwM-0008G5-RL
 for qemu-devel@nongnu.org; Mon, 25 May 2026 23:58:53 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bcceb394417so1231040766b.0
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 20:58:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779767929; cv=none;
 d=google.com; s=arc-20240605;
 b=F7zuOwfFL+yZAot4IZlTtuO3dCbtp+CSlgXJwSUIxwmvfA6xWaJeBjg5z2c+DpHgQo
 oBz7civakLmUrxRpcq39aBxxxBPWTeZoBXmgo7nFKCAp5OJUCrx1XS/Fh1SDdKCPzCRP
 REUDVxC8YONvsIMjQT5ZmvdqiLdbzMRrihs9b7JTuqhkoGFeilUnLza5psmJjC5QQA5I
 pHoYojkDWhA86Y6/CoDkwv1PHDeMx/e0twuruDwW29Q4+VQiKdR52LcUWkECOLpVrGa/
 yqRfMFdm9z9NreOlgRoT4V5aDa/mEhswXUa4AhMgicnqicXzdtjTDufycproPWTlZ262
 6Oxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=x1LL209bUAmCZZntRVfVwzweRyP48+zW1qnO6AZhCdk=;
 fh=QiWsCvjH9bUbqYQS7S6uR9oDEBN9S/40XxQJ4IibPDI=;
 b=G8DEma5Fx9sqX6e67V/kfbuhG/098zCWle/0eZjMZnIuAZ7mTdD8HBKX54JOB1f5IT
 8XSkFg+5ERn6CozWaBCPML9fLDiHwpSt3yo/1hac9+KNSprXN80/JKXLcT9Ze4xlEJaw
 buLd2ysel0l2CQXu9D8JZTy6kFhjFdCWbzpBoPe8CJRAt86Pu8lhcCa7OmL+we2H3u3E
 q8+cl4BvlJql4R6ekfEi8IksnLepxZiCXurNRgVlGsasf3COuM/lEvJN3zlvDkJ3YAK0
 5S1uV2lb3g4og/esJAZYCLD5jboTika5PotQ7BOCYnv33TGY0E/NAQ45tDfDDwe5af8l
 bk7g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779767929; x=1780372729; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x1LL209bUAmCZZntRVfVwzweRyP48+zW1qnO6AZhCdk=;
 b=Ho3gU/i3WBas/VWInfJpxqFlzgozffI4hcCWPlDRKIUO1k84vy6pwUp/O+ihdut3rR
 xBXlJiLLNfydN9hrOd5fs6demNnperVjxsJm+r59QawsHfRIuIj5udsi+wYQgJKDduSW
 NZh9Nb5QIEAqRWPJQpvP/5EVLsU2uSe1rnLfNGihMQuvjiUUE0xxD5VGIWPuazqupUkx
 yeAtRgeABfKbhEUYvAIS26ks8N0r41JrVarvvnrFjiAgkzFKV86p59eSKykSYh7DyZmw
 BnEVXb2aZ4LP2X4HkjiW4o5fthynwo3f55UJEdMQPgautYJNOElNI4e11dAC5plY31A6
 h9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779767929; x=1780372729;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x1LL209bUAmCZZntRVfVwzweRyP48+zW1qnO6AZhCdk=;
 b=eOOXVWclZFQKXwqD8B6lMMU3HiLpmFmqQ/yFU9hmczSY4rWN5IJ8jPFuzHIO0ZYtSN
 ktrjvHPYNF/H9rCbg/CIeSk41myw5t55BiJjVoF7G5/fGIpT8DFdpOP8EryvcBYDn6Xk
 +lbJ6xnzFF7+tooKe0fLl9dc7f4WnkwwbbMn++p7Esx/hrgqXi4BkO2HH2oFJLvCcKD8
 Gd22kUwnPIp6OEys7/8U9yNEVhRmjRIGJV3LJkVA2q0KdtKSnu4QVymm6aYNftAVsHXs
 8W5NO6ru92r/2nzPgfQWQs0uoCcQYgp5mVYmQ8EvZxhXO93yGd77+XQRTriihvjrxkka
 eb/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/yTglu3WtSLf7a+O0a6Gk0W088Z1aUMuR0lKpL/x9lQf1nVVB1wp4BX9Dqj4HFziEc2qHIWymmDWUJ@nongnu.org
X-Gm-Message-State: AOJu0Yw/xv5yM7BkzS76tiMR4bsyiFpzHC8KVo9d2afA+IqMGHtqMlk6
 6tSsOM9XsMJiBsqCLqeEokr++stB+7C6KEjOLD6SNp54i0WP5J5CIrb/aobOgFbtpsH7wumDuMp
 iq0hVHE5pyXv2zfyTA5pabOXtu+/HrRI=
X-Gm-Gg: Acq92OHkc/Ix+oWK99VtCSenBuBYMEBJCX1QsrRz3PrIa4QFfj31uzml/fdg/6v62xZ
 lgfGTg+oboh04GoLplx4hH/Jja3x9lqiM890RLOASsDV7qeFBH5TLMM2HHieh7eUY6S83XBzj53
 AEGbNeYizus6JAIMMZe3S2qCV14r2JBMunVmPssbJF4eECaTTdaYszOSmSwWSA1TsW+kV5e0x11
 nFi844+easvkmiwIa4ZaRMW21YUEQhkoQ/yGzFrTRoO5yH118J0UCloF3FtRBD1hDiuSSrv+fjg
 Al38+Y+I/JFV/+RVL/rrVHbqPSQiu6Lh2Rh88aLj+7+lTxtkAFgkXO4rG64=
X-Received: by 2002:a17:907:2674:b0:bd8:61ff:f916 with SMTP id
 a640c23a62f3a-bdd2aee6c2dmr707689566b.44.1779767928464; Mon, 25 May 2026
 20:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <177756498815.8917.12449488721849651971-0@git.sr.ht>
 <177756498815.8917.12449488721849651971-3@git.sr.ht>
In-Reply-To: <177756498815.8917.12449488721849651971-3@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 May 2026 13:58:21 +1000
X-Gm-Features: AVHnY4JJeCvwPMU6781PTtpGpTJmgca-Nb6j4snGQYvDqrMYqRlLUqwXIDS94ZM
Message-ID: <CAKmqyKPvR7pkKz15_f_Nw7Nrf9e=+kVvJwdF61qtGK3pK-NCGg@mail.gmail.com>
Subject: Re: [PATCH qemu v4 3/9] ot_uart: update register defs, switch to
 Fifo8 for tx/rx buffers
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
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x632.google.com
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
> The register definitions for the UART device need to be updated to match
> the documentation at https://opentitan.org/book/hw/ip/uart/doc/registers.=
html
>
> This commit does that, and also switches to using Fifo8 for managing the
> transmit and receive buffers.
>
> Signed-off-by: Lex Bailey <lex.bailey@lowrisc.org>
> ---
>  hw/char/ot_uart.c         | 338 ++++++++++++++++++++++----------------
>  include/hw/char/ot_uart.h |  18 +-
>  2 files changed, 201 insertions(+), 155 deletions(-)
>
> diff --git a/hw/char/ot_uart.c b/hw/char/ot_uart.c
> index 9478af40f9..3fe7c5efe5 100644
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
> @@ -37,16 +38,22 @@
>  #include "qemu/module.h"
>
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
> @@ -58,43 +65,74 @@ REG32(STATUS, 0x14)
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
> @@ -105,122 +143,133 @@ static int ot_uart_can_receive(void *opaque)
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
>      uint64_t current_time =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
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
> +    fifo8_push(&s->tx_fifo, val);
>
> -    if (s->tx_level > 0) {
> -        s->uart_status &=3D ~R_STATUS_TXEMPTY_MASK;
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

Don't we need to update the interrupts at this point?

Alistair

