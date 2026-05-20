Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD5BCD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlX9-0005z5-O5; Wed, 20 May 2026 14:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPlWt-0005qg-97
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:20:28 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPlWr-0008Tx-DL
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:20:26 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-651b4d09141so5116094d50.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:20:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779301224; cv=none;
 d=google.com; s=arc-20240605;
 b=R1/lcN6aHJbLMNhcsiawDuWRkY2p/6XImztxq9PxOLzNDX4mQBa9BoFqNtAhVC2PmB
 nPCAIwziqbeQaNOYvatwpH6/P2PaV6c4+KHDiu42gWH6/oCqaOLThdCeqlys8GHWDgjH
 V609LsqiNy2fJaQpos7kONPOMBMEA85PdDUP0LSK9i2QTejhxL9AsVMB9Iyo5QQjLktI
 bLOvuq2hhbD87NXhNVVbnp9soYV6s5YAH6+2GWwSpy47bVEy2L2DukoC7f47GOYDGOD0
 iU1+PmUt01xQJlRoa8kqJNCTfPm0qAAbCvy/x1Xl7xjfot8a+XjtF4bgOvVB37dwYHk2
 pz2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=M6TCNz7Z02UK3RyghCSIVPYnEiC/l/Hc+ekVBWL18UU=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=Rx3G9QRuk73zE8ou9lzIce3ZkWno9N4KhQuxMlBNp3frW7VHrZebB7oKif8J6SWMMk
 ywydEdoNGfABDYXP+6OjNZvAqy+wLl30jlp5IXJoxPRdvBmRLUIf77peIGrCZDgzWDwz
 ifYGCQ2c4Drs31GIpbNnzCtAOtbCXZmgXXSKScB7np4u9lLJ+LTFrey46qka3+6aMHia
 X30COcJIeblfaBy1C7UlUEhP2vFGeMVsbgL26AdRA/49XJZNDDKxfhyD/ERYBGF5eaFy
 4qSR82y0e6lM9UsZD3Vqr+d3Iqbgqe//nwEh82rrAuaEPQecO6hf+pHWBD1nKb7Aoy+O
 KaxA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301224; x=1779906024; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M6TCNz7Z02UK3RyghCSIVPYnEiC/l/Hc+ekVBWL18UU=;
 b=ZSMwu3ZlSDobnDAMwYFKvqS7EXZxbKw4t+JiQ+IZKT7xq+MoCd/73Fx7De4vPYx66e
 eDBZo7VhsxMhRWYM0vv8+aw0RqCIkCXF3py4vG4D5lNI8Xjaa1GAxOgtTCKOw3ALw6kx
 /Pb9nJArtH1RWVKmjh+3MwUycqoGNbvXB1h6O+JsEjU8ToZDUenb+AHxt2YiY+9b6Orw
 gfb0a2w6qsdpWRM3hwoMmJKrORgJTnNRju9ktmRnWC8PLtzZuoJdrRoVAldKMZ38nRck
 L4MJOZwE0ezIggckpeCAZpbX7irXIN5k7WFYU7001SDqJWaFqDq+Gn1WM+AGaOjllxwH
 bCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301224; x=1779906024;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M6TCNz7Z02UK3RyghCSIVPYnEiC/l/Hc+ekVBWL18UU=;
 b=XcvKs3RemPqT6e+B2kh8gxbQOS9g+8YF4Ae8lQdPL+/+GR4jMmWHnBvHaEij9KJjog
 bot+XgzvjC2gaUO5ODeXwUQXQN6v0ahqM6qZPmIpC3Qxay1qmVyT7SE7b4R80d1janif
 Uzql4ANxsGmhurQD/EOFAybWJOz3Yt++0kf6zZwiWpb2X0FSW6Zonk3+TDfp9L6Z3piO
 XRCea64UkASaRXy8sSRrmI84FHneaU8bIhv8x0PHNYx+JcEkN9cyhU2LqQmxxMFCvgud
 X8Oe2jScucuz0aFIiVDQhmXQYiEyCy6IQup3PhYKLOdcN/P9jbkIIXqPDBWpxlHGlfGh
 WoTA==
X-Gm-Message-State: AOJu0YwIaC1fi8H932+s1qEnW9XuwJGtRcfJ8TGZEjd4dlKSObWLi9Hg
 tzz1K9OtkfStsJdMVMtqdmle47jkIVws01xEtlZsw7UY5X69Iciv6g1brsERJ14B+rF/tQLan0m
 nMrP9a2jJ3e37J/VfY8gXKyg53vwxX6i2L1h5cc09oA==
X-Gm-Gg: Acq92OFlwPjWcreMr6rS1WABKyUkC86kSKFM8DgT1I5hLdbU0nE6M3KSqXQ+ue6OHCc
 KFVbwd8rU5Xqwwqv9A9n8xPGnSfbqDvsHUMo6l7rXrrsSfjcUo1JLQ2W4nXxIiPMNa9b+wXychb
 g7dRG/GLnV3oYg/BIy09g7IKo25xZKgIGsf/ItvhbDQwtpx10SZUcn2rOdckZeLOL/oMMKx94Pu
 zmr7VJXk9n+6PcxtFYUs1p26ed0jcki7JQh+ZB6HLfU8//Vr4zkJO2vDNFcS7YUmJax/j1BuFHr
 kDOraJo9Lp+VDP5I9NQwIKn4IOuQgGWi3EJSQERH7ToRHysrWjXj7Ue5zBFjK2vkZrw=
X-Received: by 2002:a05:690e:1282:b0:651:8abe:ce47 with SMTP id
 956f58d0204a3-65ea81b1aa9mr597991d50.5.1779301223455; Wed, 20 May 2026
 11:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260520171820.848839-1-richard.henderson@linaro.org>
 <20260520171820.848839-30-richard.henderson@linaro.org>
In-Reply-To: <20260520171820.848839-30-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 May 2026 19:20:11 +0100
X-Gm-Features: AVHnY4KkmMHmMhF2QBFUMhBxrOZFF4OlN2dsOs9_ESopZVRG2Ng80RJN6MkJ3Vc
Message-ID: <CAFEAcA9tXNossXoMC=LSa7Aw0CZzsmtkppKqEGqcdSgy-X_GOw@mail.gmail.com>
Subject: Re: [PATCH v5 29/30] fpu: Fix NaN encoding for E4M3 in parts64_uncanon
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Wed, 20 May 2026 at 18:18, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> There is only one NaN fractional encoding for E4M3.  Retain the
> incoming sign, but force the outgoing fraction to the unique value.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  fpu/softfloat.c           |  2 ++
>  fpu/softfloat-parts.c.inc | 29 ++++++++++++++++++++++++-----
>  2 files changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index be6b02d866..2c3bf01213 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -499,6 +499,8 @@ const FloatFmt float8_e4m3_params = {
>
>  /* 110 << frac_shift, with the implicit bit set */
>  #define E4M3_NORMAL_FRAC_MAX  0xe000000000000000ull
> +/* 111 << frac_shift, no implicit bit */
> +#define E4M3_NAN_FRAC         0x7000000000000000ull
>
>  const FloatFmt float8_e5m2_params = {
>      FLOAT_PARAMS(5, 2)
> diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
> index 559e40d196..d6687df982 100644
> --- a/fpu/softfloat-parts.c.inc
> +++ b/fpu/softfloat-parts.c.inc
> @@ -278,11 +278,16 @@ static void partsN(uncanon_e4m3_overflow)(FloatPartsN *p, float_status *s,
>                                            const FloatFmt *fmt, bool saturate)
>  {
>      assert(N == 64);
> +    p->exp = fmt->exp_max;
>      if (saturate) {
> -        p->exp = fmt->exp_max;
>          p->frac_hi = E4M3_NORMAL_FRAC_MAX;
>      } else {
> -        *p = partsN(default_nan)(s);
> +        /*
> +         * The class isn't actually used after this point in uncanon,
> +         * but for clarity while debugging, don't leave it set to normal.
> +         */
> +        p->cls = float_class_qnan;
> +        p->frac_hi = E4M3_NAN_FRAC;
>      }
>  }
>
> @@ -507,10 +512,24 @@ static void partsN(uncanon)(FloatPartsN *p, float_status *s,
>              return;
>          case float_class_qnan:
>          case float_class_snan:
> -            assert(fmt->exp_max_kind != float_expmax_normal);
>              p->exp = fmt->exp_max;
> -            fracN(shr)(p, fmt->frac_shift);
> -            return;
> +            switch (fmt->exp_max_kind) {
> +            case float_expmax_e4m3:
> +                /*
> +                 * There is only one NaN encoding for E4M3, and with a
> +                 * conversion from another format, the input NaN fraction
> +                 * may not apply.
> +                 */
> +                assert(N == 64);
> +                p->frac_hi = E4M3_NAN_FRAC;
> +                /* fall through */
> +            case float_expmax_ieee:
> +                fracN(shr)(p, fmt->frac_shift);
> +                return;
> +            case float_expmax_normal:

We used to assert() that exp_max_kind wasn't "expmax_normal",
but now we don't. What does it mean to have a FloatPartsN that
says it's a NaN when the format says there isn't a NaN
representation ? Either way, the "break" here means we
won't treat it like we do NaNs and we won't treat it
like we do normals either...

> +                break;
> +            }
> +            g_assert_not_reached();
>          default:
>              break;
>          }

thanks
-- PMM

