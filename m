Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DBCF36BA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 03:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB2A1-0004gd-Tp; Thu, 09 Apr 2026 23:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB2A0-0004eq-E0
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 23:03:56 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB29y-0007m0-Mz
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 23:03:56 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6701c19e7b3so2647905a12.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 20:03:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775790233; cv=none;
 d=google.com; s=arc-20240605;
 b=BcI6z5JxlfP9kQqmZIOa1GXT3prntiC1g4KQ8r6shumxpuAp+dQOb9iK33Psa33Q4U
 9MQ9gWhJVZ6B5XQYX1AES6VMDrRVheBhtb5dfQM0E+D+cNJPoSsVBEuQRh4MOXRgw8JD
 Of0CAaHQaH2UKHP/vZm9ELhlThWcFpssNyVffM7tSMdXq+eaV8UKy5DvSVy9uCVB1oqs
 2yS7uiBWmCqwgO8kkTUtFplRykoMSDf9A63UaGavDJLpfHTVhomimoEi+Ddmau5zbuOZ
 B8VBGHpmYU8E47Iyr2je7EF00p8E9KO9H+fS5wFyITnEd2kyVNIWS1Eyj94ZrUQz4/7a
 AiGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FNUQ7ttPA14wG3ubBhEPotEDqCiMqDAECL/dDjGkjIA=;
 fh=zlHjzNvSCS6GFUJBw8mfTWF7TqG/+Iz8CK6dtZ6QekA=;
 b=cttaUX1CtUC/udMlqzY+60lMfN6FIWithhiEvaxHNOE4lXNGSojQOStRZqLtQaB9MK
 ecWtXJdPeZXbhbf8TJQjjSH06YW9jAviI1Wf/yYo4RqLcdXPmCjoLn+tkCWWL1/6gbBY
 0K3xC721J/M7SCShH2TSqljpxs4uJeVYfpDmrNK7WCXlUDXrFmdjIejPS3mPiylEhnCU
 zRNvYraX0maeNroX4KA+YSXCuavCufYB+oOnqmF+b4fnWGa8HBLrnRhRp9ndIsm/u7hV
 lVhfzum8YkPEa0PeYKpzM9j89CAWn2vzWJD2qAAWHIoXzzupmdKqjqRhZC+jib4K7GkQ
 XPjA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775790233; x=1776395033; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FNUQ7ttPA14wG3ubBhEPotEDqCiMqDAECL/dDjGkjIA=;
 b=pjm6RHFi1V4KAtsM8B0lKqFB5bIKNcthJsq8aCuPGVPjSmCt4Cy32jYwWJj+AavbZ1
 8q4TaQ/Jg4sITFDueJsSHsD3mw8bfVuKw0RQad+1PTtnbNvuZ6XvHUahWzErNjTCdb9t
 eM8Jj7bZX8BF6iI9F2sN0s4zzTwX1KxjTneYI8cALyBK7m1QO4x6/loV9pZEBoPwgSp3
 rfPjih9+U8H8JP948HEUeA1+wKVDYM/74tEkR0zSWg2dJ2F7VokczlGf/ASGGJIJd5U7
 dmDGVqAiF+OCCvldqzEDJ/9xuThnH9AJSpJKDmUhbnc56mNCGMXJE42spyKPWRxvGPAe
 +aXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775790233; x=1776395033;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FNUQ7ttPA14wG3ubBhEPotEDqCiMqDAECL/dDjGkjIA=;
 b=GIgKPdPgSYrJmol9sSlPRtNHfYsI9jn9jluIpvrzTG6l4o/tCXONqapslOKDPNM6fH
 hqqHwkWWIRmC/OvBjhD6wzo27oyH/T3mBn6PVLngUWjoBpm77u383XP+/SaeSe1oEt5c
 o0vflFm1CFiKFxWEMBVq2KLr7axGiE3mdS125oFIrXOqs8wKMygFAxOBe0PYA+2dipYm
 dp1bla9D44ACFL28gLH4pgDTifVCQv7zkqy7O/xvXE6gCMtjxf1KqZf42MpjVgatDeEx
 z3tn3ZiiwSVpmNyavkZUYO5qSeAy1ihE/Nj5SvVNxlNQyguWRru//4vJd7Vi8WZYHBre
 pQ5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHsofMP43GBqDphvj1zQ7O/aqNlUKQejqmLKX1fHQynE+cgVIiH+BLsUcJs3htqMzCpY1hngix75Tw@nongnu.org
X-Gm-Message-State: AOJu0Yz8rWo9OhoT3KS8lKXeCLRwlI81u4UBh1YGYMPvtz9ZAphizNDU
 +106yUCvz09nT8XA+bHmfZ2P1i4P5UqolRC6Ns14XjyUfQbXgBWOiAkrVea8iVJa2ikvt2b9sH9
 0+0pMKlPqcDegjs6Lmx0tULJN99W2fwQ=
X-Gm-Gg: AeBDiev5OWeMT4liU/fcjwLaICzmJQi18ps8cqoqqIPh0wkmiR1lAtDJ9dcSS4/u3UW
 qXtyGrFjlZ2T/DRvtxELxBPIBSESypEEH44evrQLBuwtRBywniUL63LYY5/kxmxGeW1V4QDesPA
 V8UhA0f+cGiC+NPzgCxSLNz05a9aUxHgJNo8s1nbkM9afQ+eNB/V4O5EPrfJkkL2atNV6syHc7Z
 WJLAbpTeWxu+q/p+5yCmX4JlK8ImtGzd5altc0x0BftSTscMYQ1dc5Ke77HDROMckqxFgJDj5fH
 c8D63oBjMLLaXB0Pk4YuZwsQd/hesiqcbeNthw==
X-Received: by 2002:a17:907:c99f:b0:b98:286a:e2c2 with SMTP id
 a640c23a62f3a-b9d72682908mr56161166b.38.1775790233011; Thu, 09 Apr 2026
 20:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <177564643888.23414.7922925369077631439-0@git.sr.ht>
 <177564643888.23414.7922925369077631439-4@git.sr.ht>
In-Reply-To: <177564643888.23414.7922925369077631439-4@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Apr 2026 13:03:26 +1000
X-Gm-Features: AQROBzCrdqCFnBECR58Dh0MQhuf3Hzq0yLMkiV0cvfGTYSj_imUqNxnpLI3Jeg0
Message-ID: <CAKmqyKMp7R6QAxseL1kdq98aSVLNOfy1FR5qU7k2=pomc+RZmA@mail.gmail.com>
Subject: Re: [PATCH qemu v2 4/7] ot_uart: replace individual IRQ fields with
 array, add missing IRQs
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
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52c.google.com
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

On Thu, Apr 9, 2026 at 5:37=E2=80=AFAM ~lexbaileylowrisc
<lexbaileylowrisc@git.sr.ht> wrote:
>
> From: Lex Bailey <lex.bailey@lowrisc.org>
>
> There are 9 interrupts in the OpenTitan UART device.
> These are documented here:
> https://opentitan.org/book/hw/ip/uart/doc/theory_of_operation.html#interr=
upts
>
> This commit removes the individually named interrupts (of which there was=
 only four)
> and replaces them with an array of 9 interrupts.
>
> Signed-off-by: Lex Bailey <lex.bailey@lowrisc.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/char/ot_uart.c         | 44 +++++++++++++--------------------------
>  include/hw/char/ot_uart.h |  5 +----
>  2 files changed, 15 insertions(+), 34 deletions(-)
>
> diff --git a/hw/char/ot_uart.c b/hw/char/ot_uart.c
> index 3bf3295b1b..923aab12af 100644
> --- a/hw/char/ot_uart.c
> +++ b/hw/char/ot_uart.c
> @@ -107,6 +107,7 @@ REG32(TIMEOUT_CTRL, 0x30)
>  #define OT_UART_NCO_BITS     16
>  #define OT_UART_TX_FIFO_SIZE 128
>  #define OT_UART_RX_FIFO_SIZE 128
> +#define OT_UART_IRQ_NUM      9
>
>  #define R32_OFF(_r_) ((_r_) / sizeof(uint32_t))
>
> @@ -116,31 +117,11 @@ REG32(TIMEOUT_CTRL, 0x30)
>
>  static void ot_uart_update_irqs(OtUARTState *s)
>  {
> -    if (s->regs[R_INTR_STATE] & s->regs[R_INTR_ENABLE]
> -        & INTR_TX_WATERMARK_MASK) {
> -        qemu_set_irq(s->tx_watermark, 1);
> -    } else {
> -        qemu_set_irq(s->tx_watermark, 0);
> -    }
> -
> -    if (s->regs[R_INTR_STATE] & s->regs[R_INTR_ENABLE]
> -        & INTR_RX_WATERMARK_MASK) {
> -        qemu_set_irq(s->rx_watermark, 1);
> -    } else {
> -        qemu_set_irq(s->rx_watermark, 0);
> -    }
> +    uint32_t state_masked =3D s->regs[R_INTR_STATE] & s->regs[R_INTR_ENA=
BLE];
>
> -    if (s->regs[R_INTR_STATE] & s->regs[R_INTR_ENABLE] & INTR_TX_EMPTY_M=
ASK) {
> -        qemu_set_irq(s->tx_empty, 1);
> -    } else {
> -        qemu_set_irq(s->tx_empty, 0);
> -    }
> -
> -    if (s->regs[R_INTR_STATE] & s->regs[R_INTR_ENABLE]
> -        & INTR_RX_OVERFLOW_MASK) {
> -        qemu_set_irq(s->rx_overflow, 1);
> -    } else {
> -        qemu_set_irq(s->rx_overflow, 0);
> +    for (int index =3D 0; index < OT_UART_IRQ_NUM; index++) {
> +        bool level =3D (state_masked & (1U << index)) !=3D 0;
> +        qemu_set_irq(s->irqs[index], level);
>      }
>  }
>
> @@ -291,6 +272,9 @@ static void ot_uart_reset_enter(Object *obj, ResetTyp=
e type)
>      s->regs[R_STATUS] =3D 0x0000003c;
>
>      s->tx_watermark_level =3D 0;
> +    for (unsigned index =3D 0; index < ARRAY_SIZE(s->irqs); index++) {
> +        qemu_set_irq(s->irqs[index], 0);
> +    }
>      ot_uart_reset_tx_fifo(s);
>      ot_uart_reset_rx_fifo(s);
>
> @@ -562,21 +546,21 @@ static void ot_uart_init(Object *obj)
>                                    ot_uart_clk_update, s, ClockUpdate);
>      clock_set_hz(s->f_clk, OT_UART_CLOCK);
>
> -    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->tx_watermark);
> -    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->rx_watermark);
> -    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->tx_empty);
> -    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->rx_overflow);
> +    for (unsigned index =3D 0; index < OT_UART_IRQ_NUM; index++) {
> +        sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irqs[index]);
> +    }
>
>      memory_region_init_io(&s->mmio, obj, &ot_uart_ops, s,
>                            TYPE_OT_UART, 0x400);
>      sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
>
>      /*
> -     * This array has a fixed size in the header. This assertion is used=
 to
> -     * check that it is consistent with the definition in this file. Thi=
s is
> +     * These arrays have fixed sizes in the header. These assertions are=
 used to
> +     * check that they are consistent with the definitions in this file.=
 This is
>       * ostensibly a runtime check, but may be optimised away by the comp=
iler.
>       */
>      assert(REGS_SIZE =3D=3D sizeof(s->regs));
> +    assert(OT_UART_IRQ_NUM * sizeof(qemu_irq) =3D=3D sizeof(s->irqs));
>  }
>
>  static void ot_uart_realize(DeviceState *dev, Error **errp)
> diff --git a/include/hw/char/ot_uart.h b/include/hw/char/ot_uart.h
> index f489612700..a2c5ff8b33 100644
> --- a/include/hw/char/ot_uart.h
> +++ b/include/hw/char/ot_uart.h
> @@ -42,6 +42,7 @@ struct OtUARTState {
>
>      /* <public> */
>      MemoryRegion mmio;
> +    qemu_irq irqs[9];
>
>      uint32_t tx_level;
>
> @@ -59,10 +60,6 @@ struct OtUARTState {
>      Clock *f_clk;
>
>      CharFrontend chr;
> -    qemu_irq tx_watermark;
> -    qemu_irq rx_watermark;
> -    qemu_irq tx_empty;
> -    qemu_irq rx_overflow;
>  };
>
>  struct OtUARTClass {
> --
> 2.49.1
>
>

