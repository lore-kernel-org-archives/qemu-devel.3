Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9D1F433D0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 01:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDBd3-00055D-Rh; Wed, 15 Apr 2026 21:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDBd2-00054s-Td
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 21:34:48 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDBd0-0002aQ-RW
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 21:34:48 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b9c3e2cf3c0so1158863166b.1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 18:34:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776303284; cv=none;
 d=google.com; s=arc-20240605;
 b=ASIAxxQR3u2uCHIasFluRMLDb2WK17M9zxhK15itTutY5gCCH8WB6HAsUx7xC99VPz
 YKeAo7Lj+qvbpygoQXiTI3kxvYr+ZqgLIDqNb+B9lUvhjTO1WXtLyam9nDw61d5sfPfb
 aKSusq2F0tUB0KVDqka5z/aVGEZLgpqsrNY2Fi0g2hpxWDTOTZcmAK+0zGA6ETAZDNbe
 ncoGSfkBYfuKS1yY8hxmusZXMabkUHJsCWU7af4dR3Al7N410zralueKGCl2+kAMt4Ge
 qYFXci396OOkr675pm/DxEQ8vrCHnkiN+aBzcDeRLHA69WS4Lwd2DVvvS2mHaPI76sn+
 iYhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=anf+PjzMI2NJTCKi7FyIklPBAPTlkoJDBalNMbji6vc=;
 fh=n68pCuwK3YUIoNMU9tmMZ+HLOf+YNmUcMPV0KCOCLXY=;
 b=W4N1Bt+V1l583XCL52n/SxKPuX8E3EI3nzooMlwGD6Lj1bXCMThRq+2c1Fa+h8wSIw
 MtX/lWxbSOTp1CISV87uXaF3UOOIx5rmiAZ4q10flOT9PTy7c60oYDRJ3trI0dt0EiHY
 BTMP2FuOaYT6nPAxwqfJqLnD9yKQx3w+4I0a4kfdfcXL+eoNeZGJAZgUs2KmN/ohsHcG
 R1+4eZB01FGfeV27L9IbDkpKh4lknRrsCPRL3RRMg9QrLe/cnaYj/6K1vXXRoIC8EhpA
 Bww5pbjgiw5B3fDCW+4tNrvZNSQ22ZfFJPfUXdHdXhDF3/sLdWX5Q70nLPDQjbmguwx0
 YOQw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776303284; x=1776908084; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=anf+PjzMI2NJTCKi7FyIklPBAPTlkoJDBalNMbji6vc=;
 b=dv1pEwMHFLj9oABsPZ//JFiFHyunfhzpVhvxdF+8c9zSj6HW0MBAeEUDk2vH2Qo2xR
 4mqF9MKwLlbBDuYeKYJt+WYi+hLqd272PTPS5N/Zv4VKOnCEDKQd28CCYIpZiHlRGy+8
 ltno396i2Njx045lzPoFHSzdsAMxrfyKHmeLz1h0XqRfACkOQ81CEKdFw6QnB0l4dXqt
 q716alakTVdEt3prsfqrmBsPSM12Edoep9KQTvIMSywcCS8mirFVzOOzIosvHYDgemJl
 Acb99LgPdl5+80Q4LkvIMydT1OC9Zd26rf0c32PU0b1MYzk4vHjs6y0jyWcuZVX/vpTZ
 1u6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776303284; x=1776908084;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=anf+PjzMI2NJTCKi7FyIklPBAPTlkoJDBalNMbji6vc=;
 b=kSJYIzD02o3PV3k35QvTrdGeKnKvr9xVSGNkgQ5kZts5mhg7LzgWO7NRkZIOPMSZdn
 OaywLfAK3Ux2/kMwirZimyd6xENOeB6Z6LsX9G9rLyt2AHebbilv17IwOmVxZhsv/7JA
 XPf6xJ7CMh1SRrKy9wckBD4WrDyrjzCSp8YvjflgvaXk5RuAXWx4uF9fPpBDz67CaeCe
 6jdozWBnT8hDy56WS6bqAbkM8P3QKVXgLjDwzbRCB2tRL92pFoZcgPSJHBy2dACrMBs5
 IazKysbTIdyEHS6Q78bi9dP4frZ4R0aLfEKVSfsO1wk7Ni1fbFIvdL+7LOF31PoVBu8c
 Lnfw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8sid8x4es80eIYEI9SGS3lDo3zuyRvXDY4pdH55qgaVo2rscttN3F9zUea0ot8ZtFRdbcH4nxWo6v7@nongnu.org
X-Gm-Message-State: AOJu0Yx2SAHSg65AlrBywqswoG0rhOjaCy/0xuV4sb7YfkZ2n9N1/zmH
 p+xVMdXRrYlc6U3I35VKeSaT0VWWPtL2yTc8VbCte25WjKQGUsAncreVLimxtt85+07BR5kbG+w
 pPl+YA6sfD1UrxWAdxcJXtYcBfa1Q97o=
X-Gm-Gg: AeBDietItSYuBdjeWG9kubrCXOJfLYbBtyb21bPLqGu6lLgczUy9Yl3kC/nZsyio2js
 YASzAi0WEoqA7Rnj3uqaasVs/deMuJnW788/5vtej1YA/1qk1f1cl4QyejwjNYzSguJjn+DNX0s
 zGWVqWQEx5jd8ubu6hm0luSFB+SN+c4H0mJn4JiNfq5vz25A4GO9y8bxmmi3WTUXmr/SUO6baWj
 7TTzLhX7cOVtW8KKOol/um2W0FJM9tec+o782mfriRceV8+3JgkQATdLplDHauzy+tiZQL+0ZhY
 Qxj3svVEnd4i863ADpdAncofGgYhBlut9d6grc/nbVWL0Rpk
X-Received: by 2002:a17:907:1c24:b0:b9d:30b1:66ff with SMTP id
 a640c23a62f3a-b9d728229dcmr1528616566b.43.1776303283823; Wed, 15 Apr 2026
 18:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <177618728515.4917.14466194789826252277-0@git.sr.ht>
 <177618728515.4917.14466194789826252277-5@git.sr.ht>
In-Reply-To: <177618728515.4917.14466194789826252277-5@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Apr 2026 11:34:17 +1000
X-Gm-Features: AQROBzDy2J9QmMMnhMawZB4n8rsCAPBdKM-_6uxyUJQ9ZsCuyFOud2NNBvSJKaA
Message-ID: <CAKmqyKMLzuWzw=P0fnUX0emmox5eofE_bbCPCZw2y21mDi1CSw@mail.gmail.com>
Subject: Re: [PATCH qemu v3 05/10] ot_uart: gather similar behaviours togeter
 in register read and write
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

On Wed, Apr 15, 2026 at 3:24=E2=80=AFAM ~lexbaileylowrisc
<lexbaileylowrisc@git.sr.ht> wrote:
>
> From: Lex Bailey <lex.bailey@lowrisc.org>
>
> the register read and write functions are each a large switch statement w=
ith
> many similar behaviours in, this is mostly for enabling the use of specif=
ic
> register names inside of log messages. this commit adds a lookup table fo=
r
> register names and uses that instead, allowing much of the code in the re=
gister
> read and write functions to be deduplicated.
>
> the write function was also missing a switch case for R_ALERT_TEST, so I =
added
> that in this commit since it has a very simple implementation for now
>
> Signed-off-by: Lex Bailey <lex.bailey@lowrisc.org>
> ---
>  hw/char/ot_uart.c | 106 +++++++++++++++++++++++-----------------------
>  1 file changed, 53 insertions(+), 53 deletions(-)
>
> diff --git a/hw/char/ot_uart.c b/hw/char/ot_uart.c
> index f621fd3eae..2247db7110 100644
> --- a/hw/char/ot_uart.c
> +++ b/hw/char/ot_uart.c
> @@ -99,9 +99,6 @@ REG32(TIMEOUT_CTRL, 0x30)
>       R_CTRL_LLPBK_MASK | R_CTRL_PARITY_EN_MASK | R_CTRL_PARITY_ODD_MASK =
| \
>       R_CTRL_RXBLVL_MASK | R_CTRL_NCO_MASK)
>
> -#define CTRL_SUP_MASK \
> -    (R_CTRL_RX_MASK | R_CTRL_TX_MASK | R_CTRL_SLPBK_MASK | R_CTRL_NCO_MA=
SK)

You added this in patch 3, it should just never be added instead of
added and removed

Alistair

> -
>  #define OT_UART_NCO_BITS     16
>  #define OT_UART_TX_FIFO_SIZE 128
>  #define OT_UART_RX_FIFO_SIZE 128
> @@ -112,6 +109,26 @@ REG32(TIMEOUT_CTRL, 0x30)
>  #define R_LAST_REG (R_TIMEOUT_CTRL)
>  #define REGS_COUNT (R_LAST_REG + 1u)
>  #define REGS_SIZE  (REGS_COUNT * sizeof(uint32_t))
> +#define REG_NAME(_reg_) \
> +    ((((_reg_) < REGS_COUNT) && REG_NAMES[_reg_]) ? REG_NAMES[_reg_] : "=
?")
> +
> +#define REG_NAME_ENTRY(_reg_) [R_##_reg_] =3D stringify(_reg_)
> +static const char *REG_NAMES[REGS_COUNT] =3D {
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
> +};
> +#undef REG_NAME_ENTRY
>
>  static void ot_uart_update_irqs(OtUARTState *s)
>  {
> @@ -304,23 +321,14 @@ static uint64_t ot_uart_read(void *opaque, hwaddr a=
ddr, unsigned int size)
>      OtUARTState *s =3D opaque;
>      uint64_t retvalue =3D 0;
>
> -    switch (addr >> 2) {
> +    hwaddr reg =3D R32_OFF(addr);
> +    switch (reg) {
>      case R_INTR_STATE:
> -        retvalue =3D s->regs[R_INTR_STATE];
> -        break;
>      case R_INTR_ENABLE:
> -        retvalue =3D s->regs[R_INTR_ENABLE];
> -        break;
> -    case R_INTR_TEST:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: wdata is write only\n", __func__);
> -        break;
> -
>      case R_CTRL:
> -        retvalue =3D s->regs[R_CTRL];
> -        break;
> +    case R_FIFO_CTRL:
>      case R_STATUS:
> -        retvalue =3D s->regs[R_STATUS];
> +        retvalue =3D s->regs[reg];
>          break;
>
>      case R_RDATA:
> @@ -336,14 +344,7 @@ static uint64_t ot_uart_read(void *opaque, hwaddr ad=
dr, unsigned int size)
>              }
>          }
>          break;
> -    case R_WDATA:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: wdata is write only\n", __func__);
> -        break;
>
> -    case R_FIFO_CTRL:
> -        retvalue =3D s->regs[R_FIFO_CTRL];
> -        break;
>      case R_FIFO_STATUS:
>          retvalue =3D s->regs[R_FIFO_STATUS];
>
> @@ -354,21 +355,21 @@ static uint64_t ot_uart_read(void *opaque, hwaddr a=
ddr, unsigned int size)
>                        "%s: RX fifos are not supported\n", __func__);
>          break;
>
> -    case R_OVRD:
> -        retvalue =3D s->regs[R_OVRD];
> -        qemu_log_mask(LOG_UNIMP,
> -                      "%s: ovrd is not supported\n", __func__);
> -        break;
>      case R_VAL:
> -        retvalue =3D s->regs[R_VAL];
> -        qemu_log_mask(LOG_UNIMP,
> -                      "%s: val is not supported\n", __func__);
> -        break;
> +    case R_OVRD:
>      case R_TIMEOUT_CTRL:
> -        retvalue =3D s->regs[R_TIMEOUT_CTRL];
> +        retvalue =3D s->regs[reg];
>          qemu_log_mask(LOG_UNIMP,
> -                      "%s: timeout_ctrl is not supported\n", __func__);
> +                      "%s: %s is not supported\n", __func__, REG_NAME(re=
g));
> +        break;
> +
> +    case R_ALERT_TEST:
> +    case R_INTR_TEST:
> +    case R_WDATA:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: %s is write only\n", __func__, REG_NAME(reg))=
;
>          break;
> +
>      default:
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, add=
r);
> @@ -384,7 +385,9 @@ static void ot_uart_write(void *opaque, hwaddr addr, =
uint64_t val64,
>      OtUARTState *s =3D opaque;
>      uint32_t value =3D val64;
>
> -    switch (addr >> 2) {
> +    hwaddr reg =3D R32_OFF(addr);
> +
> +    switch (reg) {
>      case R_INTR_STATE:
>          /* Write 1 clear */
>          value &=3D INTR_MASK;
> @@ -401,7 +404,11 @@ static void ot_uart_write(void *opaque, hwaddr addr,=
 uint64_t val64,
>          s->regs[R_INTR_STATE] |=3D value;
>          ot_uart_update_irqs(s);
>          break;
> -
> +    case R_ALERT_TEST:
> +        value &=3D R_ALERT_TEST_FATAL_FAULT_MASK;
> +        s->regs[reg] =3D value;
> +        /* This will also set an IRQ once the alert handler is added */
> +        break;
>      case R_CTRL:
>          s->regs[R_CTRL] =3D value;
>
> @@ -437,15 +444,6 @@ static void ot_uart_write(void *opaque, hwaddr addr,=
 uint64_t val64,
>              s->char_tx_time =3D (NANOSECONDS_PER_SECOND / baud) * 10;
>          }
>          break;
> -    case R_STATUS:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: status is read only\n", __func__);
> -        break;
> -
> -    case R_RDATA:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: rdata is read only\n", __func__);
> -        break;
>      case R_WDATA:
>          uart_write_tx_fifo(s, value);
>          break;
> @@ -462,10 +460,6 @@ static void ot_uart_write(void *opaque, hwaddr addr,=
 uint64_t val64,
>              s->tx_level =3D 0;
>          }
>          break;
> -    case R_FIFO_STATUS:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: fifo_status is read only\n", __func__);
> -        break;
>      case R_OVRD:
>          if (value & R_OVRD_TXEN_MASK) {
>              qemu_log_mask(LOG_UNIMP, "%s: OVRD.TXEN is not supported\n",
> @@ -473,16 +467,22 @@ static void ot_uart_write(void *opaque, hwaddr addr=
, uint64_t val64,
>          }
>          s->regs[R_OVRD] =3D value & R_OVRD_TXVAL_MASK;
>          break;
> -    case R_VAL:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: val is read only\n", __func__);
> -        break;
> +
>      case R_TIMEOUT_CTRL:
>          s->regs[R_TIMEOUT_CTRL] =3D
>              value & (R_TIMEOUT_CTRL_EN_MASK | R_TIMEOUT_CTRL_VAL_MASK);
>          qemu_log_mask(LOG_UNIMP,
>                        "%s: timeout_ctrl is not supported\n", __func__);
>          break;
> +
> +    case R_STATUS:
> +    case R_RDATA:
> +    case R_FIFO_STATUS:
> +    case R_VAL:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: %s is read only\n", __func__, REG_NAME(reg));
> +        break;
> +
>      default:
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, add=
r);
> --
> 2.49.1
>
>

