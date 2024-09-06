Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66662E6FE31
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 16:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smba6-0006Bv-6f; Fri, 06 Sep 2024 12:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smba2-0006BC-OB
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 12:13:02 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smbZz-0002N2-Lx
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 12:13:01 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c3d20eed0bso2211381a12.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 09:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725639176; x=1726243976; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gTOWf+dZ1UqiIb0mHD7wuYYQJQ3YMZAJLlLKZCIUPls=;
 b=FeEE01HmYbRZRGfGyXG+t3a8QN4KWzt9AIDwl+hTRYcj32DpAnJHZd+SuNhd5uDlF/
 knOhE/aJBAz5cvB8ZDiMm5JF9QlGpJWww/yMpoowu6elngXneULuWFJuRrrIPgS+Ckvj
 WQiVMJy/A1CFkiT9pUddox89UGUR6EIUsPRwwaBG2aTkcUrA1hHHrtsNl94AliEJMivA
 DFgVwfh0fRqI861dxaohQYPkzgQUUdFWKmdiSBbWIW1AsR3RfGI0P45IsKLbIoyaYegi
 e/RBwGlcReXRvxYdv+lFDqjLoZjsv+Lc8EHBxJ+En8vIXfB95jy+6lGHfM1sTD8ec1vc
 mH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725639176; x=1726243976;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gTOWf+dZ1UqiIb0mHD7wuYYQJQ3YMZAJLlLKZCIUPls=;
 b=gCCKK8EiqgMCVc84u1qwiGTkfoHfMoSPEbabVAV3D8IbMbwqqW+mCvsCvqCK0/JScW
 feRCwriiVAMAs9eIsDcJ0YTtkGS+VSjo9WpgRiFJ6ZFT9z6fQbY3bpzuYAK5p7WAoQxb
 VwdK6SIkE6nPGmdcqJ/B1t7gQrbyqseZA0G1+ElXVSOReCr60Hoo7kQfID2tzarhsnKf
 YgrCVcDDozNh35ScdL45wRU9Ghe9+Z6sSNnLuRyPjpGjANo+JnMApch3hzpozfxNy58j
 57aHmS98eT/5N0relRGPrOgKIz03ML5OHs8PvF+ah7nOH4zKD3I0C+s9p/npniVrrRLl
 3Fhg==
X-Gm-Message-State: AOJu0YwX/2/ClfAr8X5suMmO9Tda2ECRBJ6CBDWBOvk7ReBPghE73yWM
 +qE7HFFr6WZuqlE2JLbTjoo4/mlujc93JRlIv3oiPmmS5cEfpnyrjJcTujjSpQBAf1qawAnJySn
 CnH1Q59xTePbBpZE11vopWLocY7viC949W+1jog==
X-Google-Smtp-Source: AGHT+IHfjB9Q5+rBFQONMVaT9brOAZa1vBesPH20qowjoRPv5TtIC3ruNl+kQyG6l0CFsuZnehXi7iE6PFNlIAVQ+jM=
X-Received: by 2002:a05:6402:3813:b0:5c0:9fd0:c6e1 with SMTP id
 4fb4d7f45d1cf-5c3dc7930c9mr1890935a12.12.1725639175284; Fri, 06 Sep 2024
 09:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240902061944.526873-1-satur9nine@gmail.com>
In-Reply-To: <20240902061944.526873-1-satur9nine@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Sep 2024 17:12:44 +0100
Message-ID: <CAFEAcA9wP7f_yPYNJmaTDe1bB8cPifErAGpjtsNPKsR0s_65Sg@mail.gmail.com>
Subject: Re: [PATCH] hw/char/stm32l4x5_usart.c: Fix ACK and min access size
To: Jacob Abrams <satur9nine@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 2 Sept 2024 at 14:38, Jacob Abrams <satur9nine@gmail.com> wrote:
>
> These changes allow the official STM32L4xx HAL UART driver to function
> properly with the b-l475e-iot01a machine.
>
> Modifying USART_CR1 TE bit should alter USART_ISR TEACK bit, and
> likewise for RE and REACK bit.
>
> USART registers may be accessed via 16-bit instructions.
>
> Reseting USART_CR1 UE bit should restore ISR to default value.
>
> Fixes: 87b77e6e01ca ("hw/char/stm32l4x5_usart: Enable serial read and write")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2540
> Signed-off-by: Jacob Abrams <satur9nine@gmail.com>

Thanks for this patch. I have one question below, and one
minor nit.

> ---
>  hw/char/stm32l4x5_usart.c          | 29 +++++++++++++++++++---
>  tests/qtest/stm32l4x5_usart-test.c | 39 +++++++++++++++++++++++++++++-
>  2 files changed, 64 insertions(+), 4 deletions(-)
>
> diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
> index fc5dcac0c4..859fc6236a 100644
> --- a/hw/char/stm32l4x5_usart.c
> +++ b/hw/char/stm32l4x5_usart.c
> @@ -154,6 +154,28 @@ REG32(RDR, 0x24)
>  REG32(TDR, 0x28)
>      FIELD(TDR, TDR, 0, 9)
>
> +#define ISR_RESET_VALUE (0x020000C0)
> +
> +static void stm32l4x5_update_isr(Stm32l4x5UsartBaseState *s)
> +{
> +    if (!(s->cr1 & R_CR1_UE_MASK)) {
> +        s->isr = ISR_RESET_VALUE;
> +        return;
> +    }
> +
> +    if (s->cr1 & R_CR1_TE_MASK) {
> +        s->isr |= R_ISR_TEACK_MASK;
> +    } else {
> +        s->isr &= ~R_ISR_TEACK_MASK;
> +    }
> +
> +    if (s->cr1 & R_CR1_RE_MASK) {
> +        s->isr |= R_ISR_REACK_MASK;
> +    } else {
> +        s->isr &= ~R_ISR_REACK_MASK;
> +    }
> +}

Should we be doing these things based on the value of
the CR1 bits (as this code does), or instead do them
when the bit changes from 0 to 1 (or 1 to 0)?
The wording in the datasheet seems unclear to me; my
impression is that hardware designers often like to
do these things on transitions rather than level based,
but of course you can design h/w both ways...

I guess it could be tested on real hardware:
 * write CR1.TE = 1
 * wait for ISR.TEACK = 1
 * write ISR.TEACK = 0
 * write CR1.TE = 1 (i.e. write again to the register
   without changing its value)
 * does ISR.TEACK go to 1 again, or does it stay 0?

> +
>  static void stm32l4x5_update_irq(Stm32l4x5UsartBaseState *s)
>  {
>      if (((s->isr & R_ISR_WUF_MASK) && (s->cr3 & R_CR3_WUFIE_MASK))        ||
> @@ -367,7 +389,7 @@ static void stm32l4x5_usart_base_reset_hold(Object *obj, ResetType type)
>      s->brr = 0x00000000;
>      s->gtpr = 0x00000000;
>      s->rtor = 0x00000000;
> -    s->isr = 0x020000C0;
> +    s->isr = ISR_RESET_VALUE;
>      s->rdr = 0x00000000;
>      s->tdr = 0x00000000;
>
> @@ -456,6 +478,7 @@ static void stm32l4x5_usart_base_write(void *opaque, hwaddr addr,
>      case A_CR1:
>          s->cr1 = value;
>          stm32l4x5_update_params(s);
> +        stm32l4x5_update_isr(s);
>          stm32l4x5_update_irq(s);
>          return;
>      case A_CR2:
> @@ -508,12 +531,12 @@ static const MemoryRegionOps stm32l4x5_usart_base_ops = {
>      .endianness = DEVICE_NATIVE_ENDIAN,
>      .valid = {
>          .max_access_size = 4,
> -        .min_access_size = 4,
> +        .min_access_size = 2,
>          .unaligned = false
>      },
>      .impl = {
>          .max_access_size = 4,
> -        .min_access_size = 4,
> +        .min_access_size = 2,
>          .unaligned = false
>      },

The effect of these is that a 16-bit write not aligned
to a (4-aligned) register offset will generate a GUEST_ERROR
logged message, and a 16-bit write aligned to a 4-aligned
register offset will write the value zero-extended to 32 bits.
That seems reasonable to me.

>  };
> diff --git a/tests/qtest/stm32l4x5_usart-test.c b/tests/qtest/stm32l4x5_usart-test.c
> index 8902518233..ef886074c0 100644
> --- a/tests/qtest/stm32l4x5_usart-test.c
> +++ b/tests/qtest/stm32l4x5_usart-test.c
> @@ -36,6 +36,8 @@ REG32(GTPR, 0x10)
>  REG32(RTOR, 0x14)
>  REG32(RQR, 0x18)
>  REG32(ISR, 0x1C)
> +    FIELD(ISR, REACK, 22, 1)
> +    FIELD(ISR, TEACK, 21, 1)
>      FIELD(ISR, TXE, 7, 1)
>      FIELD(ISR, RXNE, 5, 1)
>      FIELD(ISR, ORE, 3, 1)
> @@ -191,7 +193,7 @@ static void init_uart(QTestState *qts)
>
>      /* Enable the transmitter, the receiver and the USART. */
>      qtest_writel(qts, (USART1_BASE_ADDR + A_CR1),
> -        R_CR1_UE_MASK | R_CR1_RE_MASK | R_CR1_TE_MASK);
> +        cr1 | R_CR1_UE_MASK | R_CR1_RE_MASK | R_CR1_TE_MASK);
>  }
>
>  static void test_write_read(void)
> @@ -202,6 +204,11 @@ static void test_write_read(void)
>      qtest_writel(qts, USART1_BASE_ADDR + A_TDR, 0xFFFFFFFF);
>      const uint32_t tdr = qtest_readl(qts, USART1_BASE_ADDR + A_TDR);
>      g_assert_cmpuint(tdr, ==, 0x000001FF);
> +
> +    /* Official STM HAL uses uint16_t for TDR */
> +    qtest_writew(qts, USART1_BASE_ADDR + A_TDR, 0xFFFF);
> +    const uint16_t tdr16 = qtest_readw(qts, USART1_BASE_ADDR + A_TDR);
> +    g_assert_cmpuint(tdr16, ==, 0x000001FF);
>  }
>
>  static void test_receive_char(void)
> @@ -296,6 +303,35 @@ static void test_send_str(void)
>      qtest_quit(qts);
>  }
>
> +static void test_ack(void)
> +{
> +    uint32_t cr1;
> +    uint32_t isr;
> +    QTestState *qts = qtest_init("-M b-l475e-iot01a");
> +
> +    init_uart(qts);
> +
> +    cr1 = qtest_readl(qts, (USART1_BASE_ADDR + A_CR1));
> +
> +    /* Disable the transmitter and receiver. */
> +    qtest_writel(qts, (USART1_BASE_ADDR + A_CR1),
> +        cr1 & ~(R_CR1_RE_MASK | R_CR1_TE_MASK));
> +
> +    /* Test ISR ACK for transmitter and receiver disabled */
> +    isr = qtest_readl(qts, (USART1_BASE_ADDR + A_ISR));
> +    g_assert_false(isr & R_ISR_TEACK_MASK);
> +    g_assert_false(isr & R_ISR_REACK_MASK);
> +
> +    /* Enable the transmitter and receiver. */
> +    qtest_writel(qts, (USART1_BASE_ADDR + A_CR1),
> +        cr1 | (R_CR1_RE_MASK | R_CR1_TE_MASK));
> +
> +    /* Test ISR ACK for transmitter and receiver disabled */
> +    isr = qtest_readl(qts, (USART1_BASE_ADDR + A_ISR));
> +    g_assert_true(isr & R_ISR_TEACK_MASK);
> +    g_assert_true(isr & R_ISR_REACK_MASK);

This is missing a
       qtest_quit(qts);
at the end of the function. Without it, on non-Linux
hosts the QEMU process-under-tests will not be properly
killed. We were also missing one at the end of
test_write_read() in this file, which we just fixed
this week in commit d1e8bea9c9c186.

> +}
> +
>  int main(int argc, char **argv)
>  {
>      int ret;
> @@ -308,6 +344,7 @@ int main(int argc, char **argv)
>      qtest_add_func("stm32l4x5/usart/send_char", test_send_char);
>      qtest_add_func("stm32l4x5/usart/receive_str", test_receive_str);
>      qtest_add_func("stm32l4x5/usart/send_str", test_send_str);
> +    qtest_add_func("stm32l4x5/usart/ack", test_ack);
>      ret = g_test_run();
>
>      return ret;
> --
> 2.43.0

thanks
-- PMM

