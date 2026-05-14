Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C64CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 12:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNV4w-0002oQ-Bw; Thu, 14 May 2026 08:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNV4r-0002nv-G0
 for qemu-devel@nongnu.org; Thu, 14 May 2026 08:22:09 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNV4o-0001ZU-Ai
 for qemu-devel@nongnu.org; Thu, 14 May 2026 08:22:08 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-65c21049dafso8305416d50.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 05:22:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778761325; cv=none;
 d=google.com; s=arc-20240605;
 b=TiI5L9SzREouOyHlZKSm0mc3B02+YvlMT1u6K12UoQZeoZHt94BzZTb/+UhyC29YFo
 rsNPWtwFvNsr/LdD0SChtIIw5D03X9G56WHGnQvy/st7a5u3dEZAsDk8IDazwrqO/Jif
 xeX9Ou72S14kmcpYBMQenKva4C96BjOE5LRzcj1aKMMAdqX9q/LZxr35ZoLY1drwvwRm
 pjC5NbKk18qpvUig+6PuSSd9bUJ7P57W1PhnfXvLhPYbfzLIIzBoOKrSEwyMMy7S2cVi
 5EZ7J0zomVQVc6UqRA+bwPHRNJRf4bVRs/2jZOOT1ZFK56yaXViFN8O+gMBMV8rmuVe1
 XptA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wh6ai9g47WzAI8+eG5IjwxJnfYvKEL9mm3nlod2ZRQU=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=et/gbAtCBWKn6pA/RNGS6b/KDeF615hbO5UeMf+eAw6XC5CbQooJZs1giCryO4X5Z6
 W6vCdIXdvH3y3WMEJo5/HnFB+HnX2t7ETGLpvZzvxc91Qbt6EJnAqZqYddiGU+mOZDK4
 bmMQr3MgNpkjG+ETYzyyG+iSMg7ujOrVMALNc0vV2m24sxnxMk1XxyBg4+mHXLbikLyJ
 zKpjp+Bo0P6dabxaAJPnSr/IR89jW+BJnV9VmwJGxsRqVI0yLtBFjvBLipNSIlbyO5MW
 KwbNAhD4Wj0Vy+7U36tNWUfai0Jc4f9F6J//uO/fOBJDRdDndX/D5TyQHRzAufs8YbqQ
 G9QA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778761325; x=1779366125; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wh6ai9g47WzAI8+eG5IjwxJnfYvKEL9mm3nlod2ZRQU=;
 b=L6eCAYvB/w1A1vMUgR6EIsnOM731mAtEd6Z6UXVQQQbTO5C/lxsgfp+7fcSuTMfU9j
 C/X9nf8oAUjXxzhM5pfotUs43LHoDuEcxK5DbbCzPJF2br15hwcQHoTuubSboPLEKNk/
 YXvh80ybJnz7mjnjoXAx/F6rXx0UJ3edGVetj7bG4OCtGH/AJlioV2KMFEw9k1xQkm4U
 XUFT9YiJAWHzNQTJPPvfbIa9RGyscMVii8yTwn+DpJYlKEey57UY4kX0pTb0ORVWYaEV
 r4xJXbiqjeBOKEPe1Uy7uMdlepb7+jXCWS57uCTXkSrcqzP05JcpmKHslE1ka9FSpBNi
 C8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778761325; x=1779366125;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wh6ai9g47WzAI8+eG5IjwxJnfYvKEL9mm3nlod2ZRQU=;
 b=TK9lAnP0yal9xZDfCGj+A80B41J5SQCCihV26POu0fQr87ydI2Stk2x/qGltmqpGJ/
 fyi97x7yeF3+U0Sk7vvXwh98Bp/i0HsBZsy/c+4RF0X5AP/u1PozUhly+pw9DefDE3UI
 4IHwp5k2iSaMJBha93bknnCIgzxQwn85EvdgwNG+GRTBob6GQzHjRGyr3LwK0zfrj0XV
 N+rv3HpyNLjAQhZKD9PGrP/hZexKGq5vTjhZvAoEXnQ37YISvLssrgH5Q4N37fffna6A
 YNVaJuKXSwIpqpUoY3tWn2GwBkhb3O2LyX48Wz/5jaFcyVGSqJNFirXzp/bE/PUyLiak
 qP7w==
X-Gm-Message-State: AOJu0Yyj8y6v5prRuFKtcS8S6d2GPzQxaCWoF6WK81YxQNdoQ2AkNwOm
 pO/+AB5WigGvR3zeOLVGTC35gmsuAKdEZMvcqfeQNyZFHBHYVBg0aGWfkskMa0gA+vsanQFh8GL
 dXnoIDtEA1TRCei9hdR8FQXoii9DReyIKWBA6pck2Zw==
X-Gm-Gg: Acq92OGNncNBmxJznpjBOhilSPDqfBn/gZNvYX++ffWCjxeP7ISxgih2QwabOTZZua6
 ClPInTg2QeXa9o9a432jM+LwgSkIDHeQtCW043bPoIsddSmGKYjHDTm2ciuUBRsYB17kQxP/D6H
 g5owfvBzAkEtMLkrIbbUzVU1FmJHGouCPy86tCirB0tgqmCRH02yg//hGEY7na54Tbgu2zXlfq2
 sNHpBiOvIXi9Nm0muXGJpXGNItMjkP+0csAYTzAFU8lYbwUAkJjFOQf7JoqnzQSqdWX9vpyGDAY
 kt4eyUbNGaUWa+M9KEnvLNNhe24rmK3ozbrlz/UrDB8wsVC50T7891o3LNwY6HtFPFOBQegs5LW
 QVg==
X-Received: by 2002:a53:d041:0:20b0:65c:67fa:b424 with SMTP id
 956f58d0204a3-65df61fba56mr6043114d50.3.1778761324809; Thu, 14 May 2026
 05:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260507160959.449170-1-richard.henderson@linaro.org>
 <20260507160959.449170-2-richard.henderson@linaro.org>
In-Reply-To: <20260507160959.449170-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 May 2026 13:21:53 +0100
X-Gm-Features: AVHnY4LJgNeSknIas9QaRSMt5iaMUQ2jijz97jpqzG0M3jRvNNp1WwD9V90L5mo
Message-ID: <CAFEAcA-Pa=CPs7Jp=pzo13b5zpLT=4N_F84=SPryeBFQMHFE0A@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] fpu: Reorganize partsN(muladd)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Thu, 7 May 2026 at 17:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Check the likely case of normal product and normal or
> zero addend first; shift NaN and infinity detection down;
> end with zero product + addend.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  fpu/softfloat-parts.c.inc | 155 +++++++++++++++++---------------------
>  1 file changed, 70 insertions(+), 85 deletions(-)
>
> diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
> index 3a9c2748cd..3d2606c07c 100644
> --- a/fpu/softfloat-parts.c.inc
> +++ b/fpu/softfloat-parts.c.inc
> @@ -681,11 +681,47 @@ static FloatPartsN *partsN(muladd)(FloatPartsN *a, FloatPartsN *b,
>                                     FloatPartsN *c,
>                                     int flags, float_status *s)
>  {
> -    int ab_mask, abc_mask;
> -    FloatPartsW p_widen, c_widen;
> +    int ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
> +    int c_mask = float_cmask(c->cls);
> +    int abc_mask = ab_mask | c_mask;
> +    bool c_sign = c->sign ^ !!(flags & float_muladd_negate_c);
> +    bool p_sign = a->sign ^ b->sign ^ !!(flags & float_muladd_negate_product);
>
> -    ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
> -    abc_mask = float_cmask(c->cls) | ab_mask;
> +    /*
> +     * The "likely" case is A and B normal, so that the product is normal,
> +     * and C normal or zero so that the result is normal.
> +     */
> +    int likely_mask = ab_mask | (c_mask & ~float_cmask_zero);
> +    if (likely(cmask_is_only_normals(likely_mask))) {
> +        record_denormals_used(abc_mask, s);
> +
> +        /* Perform the multiplication step. */
> +        FloatPartsW p_widen = { .sign = p_sign, .exp = a->exp + b->exp + 1 };
> +        fracN(mulw)(&p_widen, a, b);
> +        if (!(p_widen.frac_hi & DECOMPOSED_IMPLICIT_BIT)) {
> +            fracW(add)(&p_widen, &p_widen, &p_widen);
> +            p_widen.exp -= 1;
> +        }
> +
> +        /* Perform the addition step. */
> +        if (!(c_mask & float_cmask_zero)) {
> +            /* Zero-extend C to less significant bits. */
> +            FloatPartsW c_widen = { .sign = c_sign, .exp = c->exp };
> +            fracN(widen)(&c_widen, c);
> +
> +            if (p_sign == c_sign) {
> +                partsW(add_normal)(&p_widen, &c_widen);
> +            } else if (!partsW(sub_normal)(&p_widen, &c_widen)) {
> +                goto return_sub_zero;
> +            }
> +        }
> +
> +        /* Narrow with sticky bit, for proper rounding later. */
> +        fracN(truncjam)(a, &p_widen);
> +        a->sign = p_widen.sign;
> +        a->exp = p_widen.exp;
> +        return a;
> +    }
>
>      /*
>       * It is implementation-defined whether the cases of (0,inf,qnan)
> @@ -698,97 +734,46 @@ static FloatPartsN *partsN(muladd)(FloatPartsN *a, FloatPartsN *b,
>          return a;
>      }
>
> -    if (flags & float_muladd_negate_c) {
> -        c->sign ^= 1;
> +    if (unlikely(ab_mask == float_cmask_infzero)) {
> +        /* Inf * Zero == NaN */
> +        float_raise(float_flag_invalid | float_flag_invalid_imz, s);
> +        goto d_nan;
>      }
>
> -    /* Compute the sign of the product into A. */
> -    a->sign ^= b->sign;
> -    if (flags & float_muladd_negate_product) {
> -        a->sign ^= 1;
> -    }
> -
> -    if (unlikely(!cmask_is_only_normals(ab_mask))) {
> -        if (unlikely(ab_mask == float_cmask_infzero)) {
> -            float_raise(float_flag_invalid | float_flag_invalid_imz, s);
> +    if (unlikely(ab_mask & float_cmask_inf)) {
> +        if ((c_mask & float_cmask_inf) && p_sign != c_sign) {
> +            /* Inf - Inf == NaN */
> +            float_raise(float_flag_invalid | float_flag_invalid_isi, s);
>              goto d_nan;
>          }
> -
> -        if (ab_mask & float_cmask_inf) {
> -            if (c->cls == float_class_inf && a->sign != c->sign) {
> -                float_raise(float_flag_invalid | float_flag_invalid_isi, s);
> -                goto d_nan;
> -            }
> -            goto return_inf;
> -        }
> -
> -        g_assert(ab_mask & float_cmask_zero);
> -        if (is_anynorm(c->cls)) {
> -            *a = *c;
> -            goto finish_sign;
> -        }
> -        if (c->cls == float_class_zero) {
> -            if (flags & float_muladd_suppress_add_product_zero) {
> -                a->sign = c->sign;
> -            } else if (a->sign != c->sign) {
> -                goto return_sub_zero;
> -            }
> -            goto return_zero;
> -        }
> -        g_assert(c->cls == float_class_inf);
> +        /* Inf + C == Inf */
> +        record_denormals_used(abc_mask, s);
> +        a->sign = p_sign;
> +        a->cls = float_class_inf;
> +        return a;
>      }
> -
> -    if (unlikely(c->cls == float_class_inf)) {
> -        a->sign = c->sign;
> -        goto return_inf;
> -    }
> -
> -    /* Perform the multiplication step. */
> -    p_widen.sign = a->sign;
> -    p_widen.exp = a->exp + b->exp + 1;
> -    fracN(mulw)(&p_widen, a, b);
> -    if (!(p_widen.frac_hi & DECOMPOSED_IMPLICIT_BIT)) {
> -        fracW(add)(&p_widen, &p_widen, &p_widen);
> -        p_widen.exp -= 1;
> -    }
> -
> -    /* Perform the addition step. */
> -    if (c->cls != float_class_zero) {
> -        /* Zero-extend C to less significant bits. */
> -        fracN(widen)(&c_widen, c);
> -        c_widen.exp = c->exp;
> -
> -        if (a->sign == c->sign) {
> -            partsW(add_normal)(&p_widen, &c_widen);
> -        } else if (!partsW(sub_normal)(&p_widen, &c_widen)) {
> -            goto return_sub_zero;
> -        }
> -    }
> -
> -    /* Narrow with sticky bit, for proper rounding later. */
> -    fracN(truncjam)(a, &p_widen);
> -    a->sign = p_widen.sign;
> -    a->exp = p_widen.exp;
> -
> - finish_sign:
> -    /*
> -     * All result types except for "return the default NaN
> -     * because this is an Invalid Operation" go through here;
> -     * this matches the set of cases where we consumed a
> -     * denormal input.
> -     */
>      record_denormals_used(abc_mask, s);
> -    return a;
> +
> +    /* Only remaining case is zero product. */
> +    assert(ab_mask & float_cmask_zero);

The patch is a bit awkward to read, but looking at the
code when the patch is applied, don't we trip this assert for
the "normal * normal + Inf" case ? The rearranged function
checks for:
 * A, B normal, C normal or zero
 * any of A,B,C are a NaN
 * A, B are Inf and 0 in some order
 * A or B are Inf

and (normal, normal, inf) gets past all those.

thnaks
-- PMM

