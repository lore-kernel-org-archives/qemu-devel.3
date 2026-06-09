Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B6FCD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 10:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWu3d-0007lf-FQ; Tue, 09 Jun 2026 06:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWu3Z-0007l7-Gk
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 06:51:41 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWu3X-0000lG-Hh
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 06:51:40 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-66077e90382so5038376d50.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 03:51:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781002298; cv=none;
 d=google.com; s=arc-20240605;
 b=ZKbmxKOk4nx3jCcbOjrvsVabNhn1TyGO4vneVdHnoQI2/bpxsr9qTN/xbAHmzhrIG/
 lg5nsFLt+nK67pv7r7OZOyKOzJy3pMFn3y0GpR4Dn8NpPmMdZz8XRQefYD6SmSJOROrb
 d/K3se5S6hFL6ycVrzq/iwEcpaQw74k7+1IMHOrL6k9OMXBGUKI1N1Nk89HTs/9uLVqo
 nf4B+Jd+MKB5IpbS+O/rYaWLj+sUvT20FRjw74JuvR3rCtaE1TociHElu87hRb0Q67xi
 ldmd/VHJkmbpwkJvDILeCPikXUlteXrvwvCq2TLKJz9aOGO8pR4sTcaU8OkT8Wnf28S4
 70mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WiZyWl3UNuvsRsJvmXehW74+HCKdcWPr+4Zi9gv4GnY=;
 fh=imtBV1wbGXv0x57jvAdO+i2hmYlhvp1isA/zYisvMms=;
 b=gCVihv0s4IYRH0gwbqLIthAXKZ28RdynsCHw2E7UT6WnFi2ADo8xHwsSSRfONEehyI
 KhX5TolH1uZa7Zd8w2m9hz7pHsnzAheABGBjSMpQ3Pel/YospARAauHGdhi+G0/9toJ9
 Qs7Syxj/E3trfiMF7s/E7hVzeejyIJ0xxdenWC5iHQrQt9zMgfcAoW0lK68vSRSpFXJ0
 6/xHXN7yo6CtOGdit/pqMpWgJjnhg5+EZBkUxOiQWwMmuAvwB3Yo+oOOAbj77PXvmNS2
 t6wUqwJZ6UVPWLtIX9hIiARGZHy/G/r2YE+dHBKj9w+RwwK9xq3LZ+GVVP+wzv7o1M0i
 PF/A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781002298; x=1781607098; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WiZyWl3UNuvsRsJvmXehW74+HCKdcWPr+4Zi9gv4GnY=;
 b=o2wyeBta9FmVc/GiSkd1C3LuXW32mV7k7OOP5M1WYiq208GF14VVEBxNFvT4dEPuwE
 AanVo/0ph3pjBaImQ8MeRUm2HXxnzRv+DnumsRdas0S1sxquVNpTn5KjkyC0lHI/HrT6
 dez62M59p/uQghsyB+8rGbEEn940wbFdUn1dPVVs8GzWLp3Ig0llX6CflepAe9PQ32rU
 5NM8SHIHqK0L15CdUvVG1QHvtEYzSNkRXEnWMm3moFUP3PbE2Eq9bL1xSuWl7h5Yo4Cn
 s6OL2RLPw1wvFys5ZcrYf0jG7IvfZiFMXms9DlLDbiGlLr4T39mFbKPUYaBNO94DO+Xq
 9vog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781002298; x=1781607098;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WiZyWl3UNuvsRsJvmXehW74+HCKdcWPr+4Zi9gv4GnY=;
 b=Tyz5o7Guu70UW+M32zWW3sOqlIagugpY4xQ3nv8UangkYuOK+l1rZccYhc6HOuBvh6
 KVoJkoCiwZcKlf5mO3/PV34hhyyIRkJJ5zlDBoJ9Pdu+CymgFXBbcmEntpGygXpfwttF
 zf8OWz/u73K+J0+RdV6c1YSYTxus25XHEhzT/yZRFKPPPrdzY9zdd8YhtToueGV4cf23
 dUJnGmBeBMqhQwhyn2+w1qnqplfCobmJhLFaLQl95W2kd9/rAM3CGdZV2yE2ZY11p88k
 RB/O6aPYxV3hfHGzcqdubQqGLVQ7XEsNOhpcVcNqUP44trNzbo3ddI/L4J8wIkSYCfl+
 nQxQ==
X-Gm-Message-State: AOJu0YwSlHKoffoqPFRUsQHKhiSz27AiyDGPeQdxfLH2AoASy73tjzE6
 34VB30E8RrCJoUvFiuKTxZobbT4kM4iuRht6/P9XFeWqltCWOeyAz0OrjCEay64OE4rdUwj/b5p
 qfU0yA4NZBuWy6lJvuQ8pHejc5xyZrQ/CHyoXRuVEFg==
X-Gm-Gg: Acq92OGLRBzi34aETzsHcy2/D+KppZQEnpHQqPMeR3vpzjB5KyICkOqpJ+yiLb1ASAd
 OmrifCPsGDkwzBNS8noQLQ4cD+UGwQS4ILuqnzBAKivLYHp381aefJC5iTmLq0Y8ZRvEcFkFoYc
 I9PzrM3SbuoXNYmFSmAYPNqo/8aY8nwdITi+rti1l6Os0YgjmW5xZMqWF5k01dz8+4IZvPIyhN7
 ARij/xONtKtQUjR7gQEdr4NxAdSiEFtNSS6AJoufujso5A18Aj4QQJcSpYjLgbZ8dJsr91MCs7o
 gZDf1D1Qn2YT8XJGpWbvCFW5IN+OHfYkr9Qq1aXj0PbttuvQO5ylqlOCS5zahJTKyZ0ihOa8pFe
 6pQbGJhWVoU8c
X-Received: by 2002:a05:690e:400d:b0:65e:4b1d:c694 with SMTP id
 956f58d0204a3-6614f7fa798mr1629260d50.45.1781002298059; Tue, 09 Jun 2026
 03:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-4-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 11:51:26 +0100
X-Gm-Features: AVVi8Cd2bDzh1nnNMTkt48l5Y8fzUkghxDoyBBUzWP8cZiHjqmAZRgzGwB60FQM
Message-ID: <CAFEAcA9D3x7hD=RmhddTmuHWvd+cpp027A18k+OQY3sPiQrW_g@mail.gmail.com>
Subject: Re: [PATCH v9 03/45] target/arm: Use FloatParts64 in f16_dotadd
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
>  target/arm/tcg/sme_helper.c | 96 ++++++++++++++++---------------------
>  1 file changed, 40 insertions(+), 56 deletions(-)



> @@ -1240,48 +1238,49 @@ static float32 f16_dotadd(float32 sum, uint32_t e=
1, uint32_t e2,
>      float16 h2c =3D e2 >> 16;
>      float32 t32;
>
> +    FloatParts64 p1r =3D float16_unpack_canonical(h1r, s_f16);
> +    FloatParts64 p1c =3D float16_unpack_canonical(h1c, s_f16);
> +    FloatParts64 p2r =3D float16_unpack_canonical(h2r, s_f16);
> +    FloatParts64 p2c =3D float16_unpack_canonical(h2c, s_f16);
> +
> +    int all_mask =3D (float_cmask(p1r.cls) | float_cmask(p1c.cls) |
> +                    float_cmask(p1r.cls) | float_cmask(p1c.cls));

This looks like a cut-and-paste error : we don't take account
of p2r.cls and p2c.cls, so if those inputs are NaNs we won't
handle them correctly. This should fix it:

--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1244,7 +1244,7 @@ static float32 f16_dotadd(float32 sum, uint32_t
e1, uint32_t e2,
     FloatParts64 p2c =3D float16_unpack_canonical(h2c, s_f16);

     int all_mask =3D (float_cmask(p1r.cls) | float_cmask(p1c.cls) |
-                    float_cmask(p1r.cls) | float_cmask(p1c.cls));
+                    float_cmask(p2r.cls) | float_cmask(p2c.cls));

     /* C.f. FPProcessNaNs4 */
     if (unlikely(all_mask & float_cmask_anynan)) {


thanks
-- PMM

