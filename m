Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FA6C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 15:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdX89-0002Pi-OE; Fri, 23 Feb 2024 10:06:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdX1D-0004Tf-Gg
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 09:59:19 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdX19-000789-RD
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 09:59:18 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-563b7b3e3ecso1167348a12.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 06:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708700354; x=1709305154; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YhchQYK3xHNaMo+pI6y4G3x/L4qt4KFgd4CPdCCxneo=;
 b=dK2KRFdBLHo5vuGIVaBi9vijbfPNjO/GrFBffUEqjuQHxj75rtfGtrGWPWStlzcO+e
 s/mTvyImMset+71UiOpO0a/UGkOan0PwUFvtiNfyzoyFCe9DClt4cH5FZj57ULeLVJbr
 ISMvok6XRxi8zbYXVUp5xeO0JhzgH3fMVChrhTYUbLMlCgtFxMXSIaPHFujwkx4a7d/4
 INbXksuejfuOMgvV2uE8ieRT/N+u+qW58ZDzCrgOevi+QZt8XAth2mz9RGKVMlIqnXVW
 Fuy59xwBzT9s2Q1XAXeGrESDHR2/EPLl47VsHmk1sv27gOOLu39pz7BSXMIkAs9hfNba
 Ughw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708700354; x=1709305154;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YhchQYK3xHNaMo+pI6y4G3x/L4qt4KFgd4CPdCCxneo=;
 b=aeOTBblMuG+62GowHvEJen/7NEVPyUcjOK+651VNUy6wKtuNZZxP7V3ZTVcv4+5nZQ
 ImcBM8T33k4zpjUlKNO6904ElSgpEe6k0asame7xinMX4LY+t+AI5ZyrMSnrVAJNHsOB
 JXgLWildYiIJ+wR3q3I+aXkcwHRCgcjhT7i/E9SUsHTwNJvQj6MOCPcSQbDCOBazN3Dj
 +pRyWq3R/H9uTT5hx78IrfsRClSSL0+qJ7Wx74CojXVu2M/hlnfA07wuYDPPGl9RbwBe
 xbPWWr3elEHRRmx2fZe3gJ+8a1uZ+rnVRsBE99IEcsGVoyY8T0TxKJiFcsgmriUUNUXx
 HqtA==
X-Gm-Message-State: AOJu0Yzxj/XZIAfmOZLY8qE+TlArZWQ5/BclCpguK0IGBzQwhWbtBtzy
 JOfIfGeiIZet7oBnvYw7fExnBERpnkahkNXKaAWSkwIc/ruAF/4NWc7NHHQ7bgXT9vWBi+FaybO
 Ces8I7JJXALdjCuh8fsv6GXGwECvv+A1qLQi2CYz9LajE/LTc
X-Google-Smtp-Source: AGHT+IHt2OdYGgf5/dzBNwVZGuXgPykrx82wvAuewiT96fZ52vJPNNfNSoDtKjdBSCJZOo6mJ1TYhXFJo92jb60l29s=
X-Received: by 2002:aa7:d297:0:b0:563:ccd1:26bd with SMTP id
 w23-20020aa7d297000000b00563ccd126bdmr54907edq.2.1708700353897; Fri, 23 Feb
 2024 06:59:13 -0800 (PST)
MIME-Version: 1.0
References: <20240219200908.49551-1-arnaud.minier@telecom-paris.fr>
 <20240219200908.49551-7-arnaud.minier@telecom-paris.fr>
In-Reply-To: <20240219200908.49551-7-arnaud.minier@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 14:59:03 +0000
Message-ID: <CAFEAcA_B=soMv78uDsDv-F5-0XQWDXfUr-i0iTUJHr0=VHmvkA@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] Add write protections to CR register
To: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, qemu-arm@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 19 Feb 2024 at 20:16, Arnaud Minier
<arnaud.minier@telecom-paris.fr> wrote:
>
> Add write protections for the fields in the CR register.
> PLL configuration write protections (among others) have not
> been handled yet. This is planned in a future patch set.

Can you make sure you include a suitable prefix (eg
"hw/misc/stm32l4x5_rcc: ") at the front of patch subjects, please?

>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> ---
>  hw/misc/stm32l4x5_rcc.c | 164 ++++++++++++++++++++++++++++------------
>  1 file changed, 114 insertions(+), 50 deletions(-)
>
> diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
> index a3b192e61b..198c6238b6 100644
> --- a/hw/misc/stm32l4x5_rcc.c
> +++ b/hw/misc/stm32l4x5_rcc.c
> @@ -346,9 +346,47 @@ static void rcc_update_irq(Stm32l4x5RccState *s)
>      }
>  }
>
> -static void rcc_update_cr_register(Stm32l4x5RccState *s)
> +static void rcc_update_msi(Stm32l4x5RccState *s, uint32_t previous_value=
)
> +{
> +    uint32_t val;
> +
> +    static const uint32_t msirange[] =3D {
> +        100000, 200000, 400000, 800000, 1000000, 2000000,
> +        4000000, 8000000, 16000000, 24000000, 32000000, 48000000
> +    };
> +    /* MSIRANGE and MSIRGSEL */
> +    val =3D extract32(s->cr, R_CR_MSIRGSEL_SHIFT, R_CR_MSIRGSEL_LENGTH);

registerfields.h provides macros for "extract a named field", so you
can write this
    val =3D FIELD_EX32(s->cr, CR, MSIRGSEL);

> +    if (val) {
> +        /* MSIRGSEL is set, use the MSIRANGE field */
> +        val =3D extract32(s->cr, R_CR_MSIRANGE_SHIFT, R_CR_MSIRANGE_LENG=
TH);

and these as val =3D extract32(s->cr, CR, MSIRANGE)
and so on.

> +    } else {
> +        /* MSIRGSEL is not set, use the MSISRANGE field */
> +        val =3D extract32(s->csr, R_CSR_MSISRANGE_SHIFT, R_CSR_MSISRANGE=
_LENGTH);
> +    }
> +
> +    if (val < ARRAY_SIZE(msirange)) {
> +        clock_update_hz(s->msi_rc, msirange[val]);
> +    } else {
> +        /*
> +         * There is a hardware write protection if the value is out of b=
ound.
> +         * Restore the previous value.
> +         */
> +        s->cr =3D (s->cr & ~R_CSR_MSISRANGE_MASK) |
> +                (previous_value & R_CSR_MSISRANGE_MASK);
> +    }
> +}
> +

> -    /* HSEON and update HSERDY */
> +    /*
> +     * HSEON and update HSERDY.
> +     * HSEON cannot be reset if the HSE oscillator is used directly or
> +     * indirectly as the system clock.
> +     */
>      val =3D extract32(s->cr, R_CR_HSEON_SHIFT, R_CR_HSEON_LENGTH);
> -    s->cr =3D (s->cr & ~R_CR_HSERDY_MASK) |
> -            (val << R_CR_HSERDY_SHIFT);
> -    if (val) {
> -        clock_update_hz(s->hse, s->hse_frequency);
> -        if (s->cier & R_CIER_HSERDYIE_MASK) {
> -            s->cifr |=3D R_CIFR_HSERDYF_MASK;
> +    if (extract32(s->cfgr, R_CFGR_SWS_SHIFT, R_CFGR_SWS_LENGTH) !=3D 0b1=
0 &&
> +        current_pll_src !=3D RCC_CLOCK_MUX_SRC_HSE) {
> +        s->cr =3D (s->cr & ~R_CR_HSERDY_MASK) |
> +                (val << R_CR_HSERDY_SHIFT);
> +        if (val) {
> +            clock_update_hz(s->hse, s->hse_frequency);
> +            if (s->cier & R_CIER_HSERDYIE_MASK) {
> +                s->cifr |=3D R_CIFR_HSERDYF_MASK;
> +            }
> +        } else {
> +            clock_update_hz(s->hse, 0);

As I mentioned earlier, please avoid clock_update_hz() for
clock calculations if possible.

thanks
-- PMM

