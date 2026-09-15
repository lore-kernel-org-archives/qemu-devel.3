Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBA8C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 13:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Tg2-0005vU-CW; Tue, 15 Sep 2026 09:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6Tfz-0005v2-3v
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 09:58:23 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6Tfx-0000cI-1Z
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 09:58:22 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 956f58d0204a3-66e4ab1ef11so406056d50.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 06:58:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789480699; cv=none;
 d=google.com; s=arc-20260327;
 b=qVBi+orKTXD7mbNsn1+UYmGgIXSVcb4y1BuX3GbsXTINLU6JBZqLo1ZfQZmybkSzMW
 pNGUpA+JVNuDAPluhmwVhVnYEMs+AgZc6RJQNu/2IgbDafZRne9B09GE+znC+DsL0tX8
 ULKssNB2YMwq8CSMnyiJGXqBPIPq5pfV3J9s2qLkibq/aVgP98XmL4AkpHLVNPYKjYC5
 hmeSOt3UJqWyGcyHTvnxjrudYFdSww9InPLs+WwHdUaNASiWqROr/Com7n5+d7TTDS2D
 tEma2Lv4w1ZCqmJORDw5KgjHUvB13aRD35TIWaMXDUBwePKMIL9sJ8O8YDGZK3PSAMos
 Vepw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=94EesMd6jYpKtSehjy5UQciOj94kAT9zE9Wpy7L7EUE=;
 fh=XKoZV3hgm4cLOVC44RsIg0ftjotH4rVwpewUeGAshSk=;
 b=csFZ9dN2TLKASO9Q3z1lUmj135QI50UZyHHnnXe2M6pgyTBZFEfeglnDwacrebfuSv
 erpKC6lor22TNN4vhe+rGpw9BNlJFU8sMZ6HUCmx7RK6y9fk5vExo38h3dvQgyFDqVlk
 Q39OwGX0lsSLEmA4qSlAA0kigLikaBFb9XHHCOntXPieKyiQ00Ewz9BxUjqxx/KYhsVC
 lX0mfO7xOZirQ2pPDTV/+3MLiQsaVCLEY2YmsgzxOG1QlAF1QrSuhzdxq6tG0gwfY/fP
 LuIgCSSGfV7kdJHPLeiBKYw5WjSQnlGDvN8SEQH+3jjDq6Lh6BfqVapmV5AcUUD2GgD4
 yv3Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789480699; x=1790085499; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=94EesMd6jYpKtSehjy5UQciOj94kAT9zE9Wpy7L7EUE=;
 b=LYVTay6HotN9522/2v5xJZBO8ESX++JmWCQr49TgZRasvPlZu3KixEq9e2i4Hy643L
 Ns3bHEx4qsIiccBsIcpRDyHppO64ag48/2QijeQE6jh4UnD7+jj1rYgGTDP51l1mr5S8
 DwGSdJGef1gkAkmEamFMY9ctI0Gm+/xwhc+YMk8D9rP+N3G9eGC6p3tU6+Bxuu2NNQwf
 zc6F1p2cyKZQIjkpicXWtSa3Wi25z9RvKjyXWhC0K2wjzK47MPQNE8U3I/TMaRTodfAV
 zeUQaGyQ/BCYzJhgCJV72pnYT/1nR0nsUa/Ju6TfWoVe8/btAaOOHomFZ7XXqClGuSMb
 MRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789480699; x=1790085499;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=94EesMd6jYpKtSehjy5UQciOj94kAT9zE9Wpy7L7EUE=;
 b=rBJPfIHc9BW9pQmHbd4DrtBSpEXCFCPUft7e+ho3kOyoYSXGBML4lKCZ0BHv0gsah0
 NLA4UNKyeyLWC0o6fxsUw3EOP8NXB4jm3B1qYnPFDyF+H5w2kOyg4gehSHLIXJNWnJmE
 AWVTkWnVh/oLSoJ3U+a6/o4J2fanFFbxO/0InzNQrzdXNi7wvxU9HqCf7Xo3phsJHri3
 5lLtk9jrg0q57Z0wNkgQjbXFxoJoeV3c8A4lVpewQFk8ddT1h2HTcHxv/aP0UySgKwLL
 80jSC2Qc/VKcEuU3dy75VSpAhm7o+nhF+Zl2eHw0d1c0XtP78Our5oYOuL/w3NWIWP1O
 nOkg==
X-Gm-Message-State: AFuF++molDnsDsRXa+FYn4VuhipOFQq3LVWCRikDjz9u0FOVhgT/7F6L
 xyzPR24k6tmB4BlYpnWROOjOP6AwoHMXxKOgnZbzpDOfYvqEwwGSrrMu5lmfAGIuKoOIKKJLXVT
 qzyNmFWTyutVECtcSlkX4P3OgS6VAo1fGJazxGsBj3w==
X-Gm-Gg: AYBFou1JV0JiJYHf0Jt6E9Y2lnvKjkctBJfSxSYv9vAP7UQGJIqkuOjmvkJYTgDIHPV
 wbNOlSOqI8jyEuneMB6b5Huo/GFEwajM6MhFH/YXNZq9js4Kr51it1/BOlJjHe0EhRyjE9DwKh6
 UwH2e0Ob25L9JTQp/93oRwUNtDXlYD70u/LMXO0b/2H8LqYaauLQI6v14ZLkkKvexG5ITCq9hne
 wFKJQNH0urqdGR4hVtIIS4igcNJrRf3ziMwfCEya1glO9f/6KU3jP3shHF8usCHJcN1EqFU+cc/
 GSNWye7dP2oP2l8vCRmayFIfm9mDERGgeXJEEoAGYLXDJBDCvnHnSpmiLB2CHokkehl71P+lrhW
 1AhwGrqC1EQpRWlc2uECL0xzRLgoncjsTxwR0ACAX
X-Received: by 2002:a05:690e:1208:b0:671:2d6e:b7ec with SMTP id
 956f58d0204a3-6715c93e52cmr509086d50.0.1789480699113; Tue, 15 Sep 2026
 06:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260817011008.652105-1-satur9nine@gmail.com>
In-Reply-To: <20260817011008.652105-1-satur9nine@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Sep 2026 14:58:07 +0100
X-Gm-Features: AcwNN1WES0KvMKRr4YmcZnU7fYZ4bFw3J1Iq_dTZbkDkZZY7qKYSkobnCUdOkQo
Message-ID: <CAFEAcA_sQiXSEnJu-WDq-bZBpxRPt5dqJb4t4bCum+xvPKp21g@mail.gmail.com>
Subject: Re: [PATCH] hw/char/stm32l4x5_usart.c: Support writes smaller than
 32-bit
To: Jacob Whitaker Abrams <jwhitakera@gmail.com>
Cc: qemu-devel@nongnu.org, Jacob Whitaker Abrams <satur9nine@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 17 Aug 2026 at 06:03, Jacob Whitaker Abrams
<jwhitakera@gmail.com> wrote:
>
> Official STM32CubeL4 drivers use and require support for 16-bit writes to
> UART registers for proper function.

This is a breach of the datasheet (assuming I have the right one:
RM0351 "STM32L47xxx, STM32L48xxx, STM32L49xxx and STM32L4Axxx
advanced Arm=C2=AE-based 32-bit MCUs"), which is pretty clear:
"The peripheral registers have to be accessed by words (32 bits)".

Still, if the official drivers are doing it then presumably the
hardware actually does allow smaller accesses.

Do the drivers do small accesses to the top parts of registers,
or do they always use 4-aligned addresses but just sometimes
do smaller width accesses ? If only the latter is needed, we
can make the code simpler (reads return the full register value
and the QEMU core code chops off the unneeded high parts, writes
are "write as if zero-extended").

> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2540
> Signed-off-by: Jacob Whitaker Abrams <satur9nine@gmail.com>
> ---
>  hw/char/stm32l4x5_usart.c          | 93 +++++++++++++++++++++++-------
>  tests/qtest/stm32l4x5_usart-test.c | 50 +++++++++++++++-
>  2 files changed, 120 insertions(+), 23 deletions(-)
>
> diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
> index dd1b099195..88c4a3b5a7 100644
> --- a/hw/char/stm32l4x5_usart.c
> +++ b/hw/char/stm32l4x5_usart.c
> @@ -154,8 +154,15 @@ REG32(RDR, 0x24)
>  REG32(TDR, 0x28)
>      FIELD(TDR, TDR, 0, 9)
>
> +#define ISR_RESET_VALUE (0x020000C0)
> +
>  static void stm32l4x5_update_isr(Stm32l4x5UsartBaseState *s)
>  {
> +    if (!(s->cr1 & R_CR1_UE_MASK)) {
> +        s->isr =3D ISR_RESET_VALUE;
> +        return;
> +    }

This seems to be an unrelated change to adding 16-bit access handling ?

> +
>      if (s->cr1 & R_CR1_TE_MASK) {
>          s->isr |=3D R_ISR_TEACK_MASK;
>      } else {
> @@ -404,9 +411,11 @@ static uint64_t stm32l4x5_usart_base_read(void *opaq=
ue, hwaddr addr,
>                                       unsigned int size)
>  {
>      Stm32l4x5UsartBaseState *s =3D opaque;
> +    hwaddr base =3D addr & ~0x3ULL;
> +    unsigned int offset =3D addr & 0x3;
>      uint64_t retvalue =3D 0;
>
> -    switch (addr) {
> +    switch (base) {
>      case A_CR1:
>          retvalue =3D s->cr1;
>          break;
> @@ -451,6 +460,13 @@ static uint64_t stm32l4x5_usart_base_read(void *opaq=
ue, hwaddr addr,
>          break;
>      }
>
> +    /* Adjust for partial access */
> +    if (size =3D=3D 1) {
> +        retvalue =3D (retvalue >> (offset * 8)) & 0xFF;
> +    } else if (size =3D=3D 2) {
> +        retvalue =3D (retvalue >> (offset * 8)) & 0xFFFF;
> +    }

You can avoid the if():

   retvalue =3D extract32(retvalue, offset * 8, size * 8);


> +
>      trace_stm32l4x5_usart_read(addr, retvalue);
>
>      return retvalue;
> @@ -460,55 +476,88 @@ static void stm32l4x5_usart_base_write(void *opaque=
, hwaddr addr,
>                                    uint64_t val64, unsigned int size)
>  {
>      Stm32l4x5UsartBaseState *s =3D opaque;
> -    const uint32_t value =3D val64;
> +    hwaddr base =3D addr & ~0x3ULL;
> +    unsigned int offset =3D addr & 0x3;
> +    uint32_t value =3D (uint32_t)val64;
> +
> +    /* Build mask for partial access */
> +    uint32_t mask;
> +    if (size =3D=3D 4) {
> +        mask =3D 0xFFFFFFFF;
> +    } else if (size =3D=3D 2) {
> +        mask =3D 0xFFFF << (offset * 8);
> +    } else if (size =3D=3D 1) {
> +        mask =3D 0xFF << (offset * 8);
> +    } else {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Unsupported access size %u\n=
", __func__, size);
> +        return;
> +    }
> +    value =3D (value << (offset * 8)) & mask;
>
>      trace_stm32l4x5_usart_write(addr, value);
>
> -    switch (addr) {
> -    case A_CR1:
> -        s->cr1 =3D value;
> +    switch (base) {
> +    case A_CR1: {
> +        uint32_t old =3D s->cr1;
> +        s->cr1 =3D (old & ~mask) | value;

If you write these as
  s->cr1 =3D deposit32(s->cr1, value, offset * 8, size * 8);

then you don't need to calculate a mask or shift-and-mask
the value by hand.

thanks
-- PMM

