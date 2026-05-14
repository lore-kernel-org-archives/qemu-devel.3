Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E476CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 16:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNYqK-0008O2-99; Thu, 14 May 2026 12:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wNYqI-0008Na-5V
 for qemu-devel@nongnu.org; Thu, 14 May 2026 12:23:22 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wNYqG-0000ug-7K
 for qemu-devel@nongnu.org; Thu, 14 May 2026 12:23:21 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-824c9da9928so4051591b3a.3
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 09:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778775798; x=1779380598; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pDfb7sOTumjiPEmcDKdiNCS35ueBIZztJTgF/csApTA=;
 b=S70R9Mpk4g4FxAdoVhUbEmXpToZy81LbBV0scGsoe9tvwBh5X6T5y7XIrCOg9+ZbzJ
 q44UOCsUnwpOvGwjdkoSW/mp7wh3JKj+RnEDhGMLqN9Ks3KNuQ/HxxypVQPuc0AGvAm0
 xHlG1rBdyYxw4rsZyl3wzqzJQIKygmBElnD4rjwp/jVBmgWu037njcj9j/R6iGGCnjat
 fF4sEFfAdSVzdNSuoIavJQ7/dqEuH3M0XbjcfkIsqtrGpJFHIQ/vtHnBWlmIZDh8g5eE
 eYV4ImCvCW/ugNnczjplYZziKPWth1T1A1568RBw8Jd6KBEM90+nmRntPU9kvrNTDNcS
 K10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778775798; x=1779380598;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pDfb7sOTumjiPEmcDKdiNCS35ueBIZztJTgF/csApTA=;
 b=jCV+GUSLLdnqzz38fEPhUFlPQxCz6VQm8a5qFBUDImuLcVcMAuOXQjlRNOxD4x/c4J
 rwIQUaO4M2zBRhTF6ut8QJkhShGsOKQrQ+R031MHTGplmSSxHswzl6gngAKMTQt8MUK+
 pwjL+QF38z9IPwtZsKeV+r+jyO/Q72+A6X7kfEpq2BJWo0in/hpFyOVisu8wlJ9B42Ab
 ruDPuSFVVw38dtPzCG2KB4hdUDOv1ioh27dwxqwi7+si/cWSSrmA/qeZ0TJ1EakGHs+6
 iT6OQFbMOSdzh7+hEY2yEloWXCpoXN60LDSn2aWqa2bOy2D8mtpg10GF0WN81DtJQXn5
 TRig==
X-Gm-Message-State: AOJu0YzDbKiCi4sR+qE4mzBLufChANnfXc5MIDFiRqFxTKSB2MyZx1bB
 7gXyh7RY5moc9NhRRtXX/pTUZgv9BJHhdFrJoOm4+Hmox8SeelFqMOFctr7qwddlx+I=
X-Gm-Gg: Acq92OHfMng9DvfhTGC83lXdXM0znxRmwkLuhWZqkzvAurOvXgHjuQ57enV7EJcRv7s
 kUYg0atzmvgUk48bBtfoaKgXIi/qjFuiA5kFRXTB8HNact+RLcXJJzQPmfgGH0cZJSFWaTqozSQ
 AK2meudDjfPoLtSOtOOKnM3uh+ZjcgVXWRUoooaz1DTzMRjOb8R4PKNwymEZFmoWGo4ZI694R46
 39uQ8oghF2EGQNfnu52uLvV43Ifge/Se8qB95X5dw2V9i0TmjvXevQtZjXUtJdcfn0LNMYo4F89
 w/KzElZk0tpFg6ytyNgPvXulchrx70GyMoG+x6tK9r4uqWmGo5Xqc3OyUyFP7AJyLTTzDQYawaG
 rksYt5fLCVLfLDr8Hgru7comFrfdgmYLHNDiardOmd9fcppeI3EQcY2oSYu2XEKhkIiru1uZ3rk
 ptF7IRZoRqUrzydxO5ec8wBXA8vsb+FVqHOyXh
X-Received: by 2002:a05:6a00:1c90:b0:838:af72:fb44 with SMTP id
 d2e1a72fcca58-83f33bae7cbmr280755b3a.2.1778775798254; 
 Thu, 14 May 2026 09:23:18 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19f7ccc7sm4024648b3a.58.2026.05.14.09.23.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 09:23:17 -0700 (PDT)
Message-ID: <437ada57-d647-4006-a255-06254e5efa64@linaro.org>
Date: Thu, 14 May 2026 09:23:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] fpu: Reorganize partsN(muladd)
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260507160959.449170-1-richard.henderson@linaro.org>
 <20260507160959.449170-2-richard.henderson@linaro.org>
 <CAFEAcA-Pa=CPs7Jp=pzo13b5zpLT=4N_F84=SPryeBFQMHFE0A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA-Pa=CPs7Jp=pzo13b5zpLT=4N_F84=SPryeBFQMHFE0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 5/14/26 05:21, Peter Maydell wrote:
> On Thu, 7 May 2026 at 17:10, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Check the likely case of normal product and normal or
>> zero addend first; shift NaN and infinity detection down;
>> end with zero product + addend.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   fpu/softfloat-parts.c.inc | 155 +++++++++++++++++---------------------
>>   1 file changed, 70 insertions(+), 85 deletions(-)
>>
>> diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
>> index 3a9c2748cd..3d2606c07c 100644
>> --- a/fpu/softfloat-parts.c.inc
>> +++ b/fpu/softfloat-parts.c.inc
>> @@ -681,11 +681,47 @@ static FloatPartsN *partsN(muladd)(FloatPartsN *a, FloatPartsN *b,
>>                                      FloatPartsN *c,
>>                                      int flags, float_status *s)
>>   {
>> -    int ab_mask, abc_mask;
>> -    FloatPartsW p_widen, c_widen;
>> +    int ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
>> +    int c_mask = float_cmask(c->cls);
>> +    int abc_mask = ab_mask | c_mask;
>> +    bool c_sign = c->sign ^ !!(flags & float_muladd_negate_c);
>> +    bool p_sign = a->sign ^ b->sign ^ !!(flags & float_muladd_negate_product);
>>
>> -    ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
>> -    abc_mask = float_cmask(c->cls) | ab_mask;
>> +    /*
>> +     * The "likely" case is A and B normal, so that the product is normal,
>> +     * and C normal or zero so that the result is normal.
>> +     */
>> +    int likely_mask = ab_mask | (c_mask & ~float_cmask_zero);
>> +    if (likely(cmask_is_only_normals(likely_mask))) {
>> +        record_denormals_used(abc_mask, s);
>> +
>> +        /* Perform the multiplication step. */
>> +        FloatPartsW p_widen = { .sign = p_sign, .exp = a->exp + b->exp + 1 };
>> +        fracN(mulw)(&p_widen, a, b);
>> +        if (!(p_widen.frac_hi & DECOMPOSED_IMPLICIT_BIT)) {
>> +            fracW(add)(&p_widen, &p_widen, &p_widen);
>> +            p_widen.exp -= 1;
>> +        }
>> +
>> +        /* Perform the addition step. */
>> +        if (!(c_mask & float_cmask_zero)) {
>> +            /* Zero-extend C to less significant bits. */
>> +            FloatPartsW c_widen = { .sign = c_sign, .exp = c->exp };
>> +            fracN(widen)(&c_widen, c);
>> +
>> +            if (p_sign == c_sign) {
>> +                partsW(add_normal)(&p_widen, &c_widen);
>> +            } else if (!partsW(sub_normal)(&p_widen, &c_widen)) {
>> +                goto return_sub_zero;
>> +            }
>> +        }
>> +
>> +        /* Narrow with sticky bit, for proper rounding later. */
>> +        fracN(truncjam)(a, &p_widen);
>> +        a->sign = p_widen.sign;
>> +        a->exp = p_widen.exp;
>> +        return a;
>> +    }
>>
>>       /*
>>        * It is implementation-defined whether the cases of (0,inf,qnan)
>> @@ -698,97 +734,46 @@ static FloatPartsN *partsN(muladd)(FloatPartsN *a, FloatPartsN *b,
>>           return a;
>>       }
>>
>> -    if (flags & float_muladd_negate_c) {
>> -        c->sign ^= 1;
>> +    if (unlikely(ab_mask == float_cmask_infzero)) {
>> +        /* Inf * Zero == NaN */
>> +        float_raise(float_flag_invalid | float_flag_invalid_imz, s);
>> +        goto d_nan;
>>       }
>>
>> -    /* Compute the sign of the product into A. */
>> -    a->sign ^= b->sign;
>> -    if (flags & float_muladd_negate_product) {
>> -        a->sign ^= 1;
>> -    }
>> -
>> -    if (unlikely(!cmask_is_only_normals(ab_mask))) {
>> -        if (unlikely(ab_mask == float_cmask_infzero)) {
>> -            float_raise(float_flag_invalid | float_flag_invalid_imz, s);
>> +    if (unlikely(ab_mask & float_cmask_inf)) {
>> +        if ((c_mask & float_cmask_inf) && p_sign != c_sign) {
>> +            /* Inf - Inf == NaN */
>> +            float_raise(float_flag_invalid | float_flag_invalid_isi, s);
>>               goto d_nan;
>>           }
>> -
>> -        if (ab_mask & float_cmask_inf) {
>> -            if (c->cls == float_class_inf && a->sign != c->sign) {
>> -                float_raise(float_flag_invalid | float_flag_invalid_isi, s);
>> -                goto d_nan;
>> -            }
>> -            goto return_inf;
>> -        }
>> -
>> -        g_assert(ab_mask & float_cmask_zero);
>> -        if (is_anynorm(c->cls)) {
>> -            *a = *c;
>> -            goto finish_sign;
>> -        }
>> -        if (c->cls == float_class_zero) {
>> -            if (flags & float_muladd_suppress_add_product_zero) {
>> -                a->sign = c->sign;
>> -            } else if (a->sign != c->sign) {
>> -                goto return_sub_zero;
>> -            }
>> -            goto return_zero;
>> -        }
>> -        g_assert(c->cls == float_class_inf);
>> +        /* Inf + C == Inf */
>> +        record_denormals_used(abc_mask, s);
>> +        a->sign = p_sign;
>> +        a->cls = float_class_inf;
>> +        return a;
>>       }
>> -
>> -    if (unlikely(c->cls == float_class_inf)) {
>> -        a->sign = c->sign;
>> -        goto return_inf;
>> -    }
>> -
>> -    /* Perform the multiplication step. */
>> -    p_widen.sign = a->sign;
>> -    p_widen.exp = a->exp + b->exp + 1;
>> -    fracN(mulw)(&p_widen, a, b);
>> -    if (!(p_widen.frac_hi & DECOMPOSED_IMPLICIT_BIT)) {
>> -        fracW(add)(&p_widen, &p_widen, &p_widen);
>> -        p_widen.exp -= 1;
>> -    }
>> -
>> -    /* Perform the addition step. */
>> -    if (c->cls != float_class_zero) {
>> -        /* Zero-extend C to less significant bits. */
>> -        fracN(widen)(&c_widen, c);
>> -        c_widen.exp = c->exp;
>> -
>> -        if (a->sign == c->sign) {
>> -            partsW(add_normal)(&p_widen, &c_widen);
>> -        } else if (!partsW(sub_normal)(&p_widen, &c_widen)) {
>> -            goto return_sub_zero;
>> -        }
>> -    }
>> -
>> -    /* Narrow with sticky bit, for proper rounding later. */
>> -    fracN(truncjam)(a, &p_widen);
>> -    a->sign = p_widen.sign;
>> -    a->exp = p_widen.exp;
>> -
>> - finish_sign:
>> -    /*
>> -     * All result types except for "return the default NaN
>> -     * because this is an Invalid Operation" go through here;
>> -     * this matches the set of cases where we consumed a
>> -     * denormal input.
>> -     */
>>       record_denormals_used(abc_mask, s);
>> -    return a;
>> +
>> +    /* Only remaining case is zero product. */
>> +    assert(ab_mask & float_cmask_zero);
> 
> The patch is a bit awkward to read, but looking at the
> code when the patch is applied, don't we trip this assert for
> the "normal * normal + Inf" case ? The rearranged function
> checks for:
>   * A, B normal, C normal or zero
>   * any of A,B,C are a NaN
>   * A, B are Inf and 0 in some order
>   * A or B are Inf
> 
> and (normal, normal, inf) gets past all those.

You're right.  At some point in the past week I fixed this.
My current sources have

     /* Only remaining case is zero product or inf addend. */
     assert((ab_mask & float_cmask_zero) | (c_mask & float_cmask_inf));

Re-reading now obliges me to go back and fix the grammar.


r~

