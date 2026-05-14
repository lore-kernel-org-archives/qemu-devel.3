Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D70CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 12:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNUn1-00077N-7Z; Thu, 14 May 2026 08:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNUmc-0006yn-KU
 for qemu-devel@nongnu.org; Thu, 14 May 2026 08:03:26 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNUmb-0001Uf-3H
 for qemu-devel@nongnu.org; Thu, 14 May 2026 08:03:18 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-65c52bb5dd7so8829216d50.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 05:03:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778760196; cv=none;
 d=google.com; s=arc-20240605;
 b=ToKd4z4U+w2QnH6hyLZYv479sVYAUKEWoeNe3mCgv7YZ4yuJbB+orUcTcYWD0+N01G
 rd8iRFFthX57wt/pkQNYKIA6fxaLU5fztwP/HSvfAs0gEVISxIkO5l0m/WsevtuITDEc
 E490ccqJvkjD/D389OFPkd1flO7HLvvaUbmTfajr8wW+IYFuKyLrJj7L0a9zY0r4lZRd
 eNjRqkXn1oBxuBwXlB8z1uG6VbqeCgsq8ijJACvdenOW5CgrvyQ+c8EkgV56HzzpDrT/
 T22I+yiDhtpkeeX6xAdzDKcnpoQUFb0encPTqsa8xjmPYBTBqmLxqsLpcgGQPHohu44o
 iy2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RtH1GVy43aR/pNASorrIVQckpf8j5btmuAqwGqnuXaQ=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=jyM64sdJ4Fx8EXGNIxZpL17pf126xtSjYyxu5jzPpRlbRdpuR6SeJiNnhf6PWEUjGy
 AiAcGwW+ZyL05SBqMYk0nT6CjRMv1S54XOg4k1WMSaW2pu7aC72do8+eYVuBKPPBdDQO
 dF7W1gsA/ueFZG193uyNwBzuJrNesnTdk1xR/m7ct+vufw3TpehjjpvVdzzwL3Lu1C/G
 5hF0mZSEYF53+HGc69yWBV+rujH0+quWktySy/NNDh96ZnaBotdFe9jjgApLCov4IX4H
 TjQ+r30ydlV1q0a8Jgi5OFQXE7w69L8KYvRfIW8vVIk3bg+sdNlcPm0Jgtz/fHIzBvMi
 kX+Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778760196; x=1779364996; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RtH1GVy43aR/pNASorrIVQckpf8j5btmuAqwGqnuXaQ=;
 b=KVBdRWavc+z+hO6gH4OvBvEDh9x/JHVzPr6ZJGCuufRcavNimIDWoM5UhMja2X6DJS
 p9WLEAYjE8vhhtbi0fz18jr29brZNyLIzpJe5e2TTiLMh/CxP5Ep9FyXSZ4N59dbFs8x
 TFBpKdntoSsgBkBrRJtc6gyj+0F2VLuLDBb7OAjh+6bHWvW/Xx0LXiBJ+TOGcQI9J9i5
 vRf9GwVKtuVnp0ZoIYYYXijUknLQR/oiaW07GRBTt3Fz6bGVuTDi6rEWMhloim26SPRf
 KQIzvyNadqD07EdYTi+/lASd0dMBjHQmSb4JcRd0bQ30Hs/Uu6Pl4C9p8lQft9tdvl6T
 RfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778760196; x=1779364996;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RtH1GVy43aR/pNASorrIVQckpf8j5btmuAqwGqnuXaQ=;
 b=jh8aKuXAwW3fyvvjP9grobYUjeYk/dHI17r16PUSHPku5TbWEUkJH+UyLgXHx+0ygh
 u0Sm9CNh28jgZo2Q7JB3mYzXeDhhmPrOZDPZjxweC1jJvaVI2/YiZO/Tp8vxuxO3inVZ
 5tIMc2vUtFS1sgQSuIxZBoMOm0GfHpL3O1puUWYcKaFciYEqpk6ZW8ZDImOtKBHqo7Xu
 2OloiTbDhB4qeQNg4I+dUXvDWEhyZAtph0J881IPVS2ANEkZthbFE0y7ysEkoRsmvxYT
 1+MQDaZb2avv3sSdQn+SsbDVWV2sVwoHM5x84cyKx4h9M+votB7Zll/wCy+DVQ4anGa2
 9Dqw==
X-Gm-Message-State: AOJu0YzW1Jer3vAdCDlYDplLToCEHPkWCVK7S1O334BaWBlRwnJvXhfI
 OeHdpZoUb8RA8/DEmbtoOlRF86vgw2lSII6lzundC5PufIKGi9VsPg0C54eLaQrsaCTjCKFqwUz
 OS0l3Hy5g0+I2uDrGeXK0bw5PnyB8jV8nICPXVWT1tw==
X-Gm-Gg: Acq92OEdm3iKaW84k3BLlEC+0hiasWC8WlIxZpk6goZxmyM+Wi/D5bP6jkKQw+E0WAB
 7d99S3G5iffXA3/Q/aN5tCJwhPzfQTfAoJSuTY/lRxaagXszZ12TKCLKOH5DZiOeCt+1Hln2QIj
 q9U9/ki2Jm43BGY3ENbYppArgFCKQ82U6oq93F4c+f6k4KE4av45o71u5qzTjiL2D4/YDlB6Hug
 TMxWLDvwB6kJFPF6Vlzh3IKitxU5HCh9cpLCQbS6szOImmDwrT72eIIf1ED2xCvG8w2sGWMVSmy
 iBaFuC098cZpAUFHqaOiMh0giuoCMwZBH+cFNKk3S0IL0mtOevzHK9qZWVP7o8ErKFg=
X-Received: by 2002:a53:b7c7:0:b0:653:8ef:935 with SMTP id
 956f58d0204a3-65df63797ffmr5537135d50.54.1778760195503; 
 Thu, 14 May 2026 05:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260507234413.643512-1-richard.henderson@linaro.org>
 <20260507234413.643512-37-richard.henderson@linaro.org>
In-Reply-To: <20260507234413.643512-37-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 May 2026 13:03:04 +0100
X-Gm-Features: AVHnY4La00HUOeJrVDzSW57f5rcAy-KA9jUPIhnXBN9dc0OlK1F_4jkM00OdCUs
Message-ID: <CAFEAcA8UpR-Q9oypm8v3CgwDK80+kXFcMkH9JCmUdc4=14HPCA@mail.gmail.com>
Subject: Re: [PATCH v4 36/60] target/arm: Implement LUTI2, LUTI4 for AdvSIMD
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Fri, 8 May 2026 at 00:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-defs.h   |  5 ++++
>  target/arm/tcg/translate-a64.c | 38 +++++++++++++++++++++++++
>  target/arm/tcg/vec_helper.c    | 52 ++++++++++++++++++++++++++++++++++
>  target/arm/tcg/a64.decode      |  6 ++++
>  4 files changed, 101 insertions(+)

> diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
> index 3231bb2100..f0dc11bc8a 100644
> --- a/target/arm/tcg/vec_helper.c
> +++ b/target/arm/tcg/vec_helper.c
> @@ -3345,3 +3345,55 @@ DO_SME2_LUT(4,4,h, 2)
>  DO_SME2_LUT(4,4,s, 4)
>
>  #undef DO_SME2_LUT
> +
> +void HELPER(gvec_luti2_b)(void *vd, void *vn, void *vm, uint32_t desc)
> +{
> +    unsigned part = simd_data(desc);
> +    unsigned vl = simd_oprsz(desc);
> +    unsigned elements = vl / 8;

Isn't simd_oprsz() the size in bytes? The pseudocode for
these ASIMD insns calculates the element count using sizes
in bytes, with "elements = 128 / esize" (esize being 8 or 16),
but I think for us we want "vl" for the _b insns and "vl / 2"
for the "_h" ones.

> +    unsigned ibase = elements * part;
> +    ARMVectorReg scratch;
> +
> +    do_lut_b(&scratch, vm, vn, elements, ibase, 0, 2, 8, 1);
> +    memcpy(vd, &scratch, vl);
> +    clear_tail(vd, vl, simd_maxsz(desc));

> +void HELPER(gvec_luti4_h)(void *vd, void *vn, void *vm, uint32_t desc)
> +{
> +    unsigned part = simd_data(desc);
> +    unsigned vl = simd_oprsz(desc);
> +    unsigned elements = vl / 16;
> +    unsigned ibase = elements * part;
> +    ARMVectorReg scratch;
> +
> +    do_lut_h(&scratch, vm, vn, elements, ibase, 0, 2, 16, 1);

LUTI4 has 4-bit indexes, so we should be passing "4" as the
isize to do_lut_h(), not "2".

> +    memcpy(vd, &scratch, vl);
> +    clear_tail(vd, vl, simd_maxsz(desc));
> +}

thanks
-- PMM

