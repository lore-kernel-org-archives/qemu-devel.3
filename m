Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CD9CD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWyIx-0007UM-OV; Tue, 09 Jun 2026 11:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWyIv-0007Ti-7J
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:23:49 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWyIs-0000sy-BO
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:23:47 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bf84a2b2077so233575266b.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 08:23:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781018624; cv=none;
 d=google.com; s=arc-20240605;
 b=J4S2OuPhN+O3jPp7BcMAvX7DHnIX6SGsI0pzqhxoEStdyrhYiEkDBbRRKD5JHBaAza
 Vx4+48tzPwGZjvo0//nM9Z/DmlC3Mic0Cb1w2iSxXC4ha97v//8lJTNSZ0o7feylUJ+O
 kfd6eUHCJQKjzUrU3J6rYpZvhsAUJa17+RU+y/hGOtM5kAEkRqpPqYJJhCjRnlf1on5g
 mfdYQEhHDx8BH8SNqVisq9sOlbjgFGR4cTxN94Guw5GNXxndRz8dlPNx2WXnGYcpAnVA
 9eBbVtUN2+Ws44T/BDZTmDE/zZIiQswKZYm+fxCpSZHtmiTiG+r+TSxOm71bNVrSlFKQ
 sf+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aAwC71p9JDl6vtgucmiZ0oUjX0xWUxt4RshNS2NtFY4=;
 fh=imtBV1wbGXv0x57jvAdO+i2hmYlhvp1isA/zYisvMms=;
 b=Nbn+DwHVFW2ZEJg8yuh6pD1FJcRZfb5TF+w3r4o0Oh2FSXtl6SBtxZSzDEFUxmWEVG
 mz6DsEW8mLWq7LhfHe3iVr0AUdUDSks5v1XUUyxskQ5m15wC/IEfSv7/qvANyES6kCEg
 zOqF3hMdca//o76TDcXmqIplCPw+3yfDO5l0RkNA10ogWFxw0WbGW+8ihfjVVNbqaYoc
 zKO5DkN1mgAr7Ymzdfbf6upx9FhA0TQ+0l5YtF3gdeyZ04XoqAS708K2iK3PmG83CWXG
 VWbcPb6ZbU4hkeW13nHs6B4DNAEW5L5rtZIkCM7XAHbTOSnRLm7uG+q6bGm5dJ5dUBWO
 udkQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781018624; x=1781623424; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aAwC71p9JDl6vtgucmiZ0oUjX0xWUxt4RshNS2NtFY4=;
 b=l2yAYdihHbdCqpHA+3uin9/G1HGqe0Y/7o7ddBxx0XtsOAHt07KCLitRjNCrqGjuQe
 T4rZV9lDIoMU/pG5VoNquGObHh1A85lUq7OE0dBrG+CUyfQoafHCekT4v9W3yBKzWzqv
 fqenVdn3YXJ4pGai46nTmNy9WLKXdmamMBqL8qluAUXrNQGXOSZrKwtVwNi7fTSXHTR/
 iJdOneDd5HX7Yqj6HCgyejQq0onC6tRaa6xhDc3q52FCQ3kM/N6knJ0VIvQ0M3igHom5
 fWux6JIZvwqkUEUldTuxjledsjEexgUUtKNk0ml+o8ClPofnVX7JYUFetf13Qa+DjqGx
 3+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781018624; x=1781623424;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aAwC71p9JDl6vtgucmiZ0oUjX0xWUxt4RshNS2NtFY4=;
 b=CpcRw+W6TWYHLohZ4Xnf5Ldg7dCWG/6+ma69oPywK65WBUY1f5n4NmQQt5jLCa4lb/
 7jSdJsN32VNZYGMVFtNnilv3DNu+L+gSMv2kYT7Nhk+7H1sxrQL1SmSuDWB14oHpg0Tc
 h+HihPrRavFHujhjCkYGCcQD54Wlt3dMHpAaO3cCG3Kv77EdwmaSUU306d0IStQn9cYW
 nsymSRmY2IDSHUt86ompcXLDUBaO21LCBJ5OATVE58EaqbIj81tY5cxP3dZsTgZFXYkI
 VJUPItGoGQr/iQ5GWc04KxQ/jUE02SDSW8O5TeBFi3+Kdx0M8OoXjd2e89uHB58Ilnqk
 kQfw==
X-Gm-Message-State: AOJu0Yy3fBZxiEsxYDM2/Kzyy79OlPH8eB/t4L0lrxC7aG8M1/k1BApu
 xfYzNUEqGog273lkvn5HeAHviwM9SPx2HoQYqHQyUSEY3qmcNaBW320pXgdi1N+stSmC/vtrpiX
 vA/kjjvN+gBp9Uh+q5QM2qJrRcDCEz8r7uHYPTduR2A==
X-Gm-Gg: Acq92OG+4xj/BApgNa9exMG8n+kB22sITxD45HdOn7STNoTiYmUON3FboW3P1fXX5Eu
 eSbZ480uJCgeyRguVGroyIwlhig56sTj/R81xQShwq0WMRL52iXvqb5YmrnauSwR9eyXK2v/ATe
 xDrX9VLZBmPqLr2SY9wK0MfyBlBh1JvKbnVpzFh1BEF8TMXRXHiXKDg4v43wxEBxm06oZMkTxQw
 /72s9PXzhD6W6JY1AQQM2LScNyRqAzWXg0SWF5Lx+7VGzRoTyIdJ7YCLBFN5F8XZH7dx924t5EI
 lP/uM/9P66nWYJ5Hu4+6o9xijp8gN0zJoOVfL9iBhS0vCQ91wKn5xg5wyTzgmnpiFf5v0eq66Ka
 9xdKsZ9MbmGft
X-Received: by 2002:a17:907:6d11:b0:bdc:8c6b:4842 with SMTP id
 a640c23a62f3a-bf3735f6139mr994072466b.30.1781018624059; Tue, 09 Jun 2026
 08:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-4-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 16:23:31 +0100
X-Gm-Features: AVVi8CeIKB9j4TwtH_mHqsu1mvo5DHcldBXGHtbpfZ6tkqpRXSMR1bp1JU86waU
Message-ID: <CAFEAcA_jORCuOnt4oh_JB7ZdqmZeo2yjYwssoT+-3D8K8P1DEQ@mail.gmail.com>
Subject: Re: [PATCH v9 03/45] target/arm: Use FloatParts64 in f16_dotadd
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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

On Wed, 3 Jun 2026 at 04:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Use softfloat-parts.h so that we can more naturally
> perform the required operations witha single rounding step.
> This happens to also simplify the NaN detection step.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Message-Id: <20260517002550.321291-11-richard.henderson@linaro.org>
> ---

> diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
> index 376fbd48d4..7ef6f5d71b 100644
> --- a/target/arm/tcg/sme_helper.c
> +++ b/target/arm/tcg/sme_helper.c
> @@ -27,6 +27,7 @@
>  #include "accel/tcg/helper-retaddr.h"
>  #include "qemu/int128.h"
>  #include "fpu/softfloat.h"
> +#include "fpu/softfloat-parts.h"
>  #include "vec_internal.h"
>  #include "sve_ldst_internal.h"
>      } else {
> -        float64 e1r =3D float16_to_float64(h1r, true, s_f16);
> -        float64 e1c =3D float16_to_float64(h1c, true, s_f16);
> -        float64 e2r =3D float16_to_float64(h2r, true, s_f16);
> -        float64 e2c =3D float16_to_float64(h2c, true, s_f16);
> -        float64 t64;
> -
>          /*
>           * The ARM pseudocode function FPDot performs both multiplies
> -         * and the add with a single rounding operation.  Emulate this
> -         * by performing the first multiply in round-to-odd, then doing
> -         * the second multiply as fused multiply-add, and rounding to
> -         * float32 all in one step.
> +         * and the add with a single rounding operation.
>           */
> -        t64 =3D float64_mul(e1r, e2r, s_odd);
> -        t64 =3D float64r32_muladd(e1c, e2c, t64, 0, s_std);
> +        FloatParts64 tmp =3D parts64_mul(&p1r, &p2r, s_std);
> +        tmp =3D parts64_muladd(&p1c, &p2c, &tmp, 0, s_std);

This change results in our incorrectly reporting an input-denormal-used
exception when FPCR.AH=3D1 and some of the halfprec inputs are denormal.
(For AH=3D1 we are supposed to set IDC for input-denormal-used only for
single and double precision inputs, not for halfprec. We achieve that by
having vfp_get_fpsr_from_host() mask out the input_denormal_used flag
from FPST_STD_F16.)

I think this worked previously because we did a float_to_float
conversion using the f16 status (float_to_float consumes an
input denormal, which we don't report because we use the f16
status), and any f16 denormal is not a denormal in f64 and
so the 64-bit ops never see an input denormal, so using s_std
wasn't a problem ? (Also, for the operation using s_odd that
is a copy of an fp_status so any exception flags set there
never get copied back to the live version. Presumably we
relied on it never being able to generate an exception?)


I think it might be right to use s_f16 instead of s_std in
these three operations:


@@ -1277,10 +1277,10 @@ static float32 f16_dotadd(float32 sum,
uint32_t e1, uint32_t e2,
          * The ARM pseudocode function FPDot performs both multiplies
          * and the add with a single rounding operation.
          */
-        FloatParts64 tmp =3D parts64_mul(&p1r, &p2r, s_std);
-        tmp =3D parts64_muladd(&p1c, &p2c, &tmp, 0, s_std);
+        FloatParts64 tmp =3D parts64_mul(&p1r, &p2r, s_f16);
+        tmp =3D parts64_muladd(&p1c, &p2c, &tmp, 0, s_f16);

-        t32 =3D float32_round_pack_canonical(&tmp, s_std);
+        t32 =3D float32_round_pack_canonical(&tmp, s_f16);
     }

     /* The final accumulation step is not fused. */

I think it doesn't matter whether we use s_std or s_f16
in the final round-and-pack step, because the only differences
between the F16 and normal fpstatus are to do with input
denormals (separate flush-to-zero control, and different
denormal-consumed reporting), and that happens in the
"unpack" and "do operation" steps; nothing cares in "pack".
I went with s_f16 because we usually do the whole
"unpack; operation; pack" sequence with a single fp status.

thanks
-- PMM

