Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DABC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 08:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUjfl-0006rW-LU; Tue, 30 Jan 2024 03:40:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUjfi-0006r4-PF
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:40:48 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUjfg-0005mI-II
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:40:46 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5100cb238bcso6589944e87.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 00:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706604042; x=1707208842; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UVwQ1AxwJ7v+NCtNJHcopHDA7BcQ4ikDKsu0pSi6STQ=;
 b=ZFiF5k5jeUYDsK+fow1aWQxl0VTRF2BNCeYFzLdS4tui8wA0/Nng35Mx8KRjDrR1qQ
 afSdEv3k2hHoQopRUMvaW++juYGjuS1zB8Ao/NbyYipypoL82v0AdTxqa5FVxUgZuv6x
 WIEDMps7Wviaczr7193y6hzHdc9fWyn4A5CGoIDXNKYOB/DTXUdLRpYVx7pkh9yzrRWN
 gFnlf8F0ix8hwBe3MdI6XRY5GQdC3cqbJmK3QogECxbvJmtVKQ4CrW9ND8nsJlvTvzy+
 2U59+NKwlgV4bh4fkBQLb3a2CuBVJgct8ADNdWQYgzrwaU43jfHIrdzAu34p1C0c2qWQ
 9eGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706604042; x=1707208842;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UVwQ1AxwJ7v+NCtNJHcopHDA7BcQ4ikDKsu0pSi6STQ=;
 b=SDJk9EHY5O+aByKFeiy/nXTpqrmxj3q/MxeJFtK+5Yp5YiiOjT8P/oc2zF6wt3pfpk
 KZCRw1AILHHHMb12WvP/2uAPvVYjmXyJNlihHVtmI+NJW1fBrdw4Kvp2Djdj5H7LqiYP
 UVZTPIhdBY6fhPsWCXfahaDi+mL+mcFcWajVPh0OmZ8Xw+sjlWlOWsirEOVvGfty+6K+
 uZZ0V+GVyTG8YH4DvBG9rS9rIlWUaQJbHt1l8tKhizhQ4lKWRqfG4NfaXank8gYcz28N
 Ep27QiQzyIvvaArJ3nho4dfF4637J6EhI9J8L9ViN6vkt2cC8DVf4tKmsAqis2dgNAtE
 3N5Q==
X-Gm-Message-State: AOJu0YwvAgSyHFgEKGMjf8JHslhBVWkYiz56khKnumua2/yl4ieQljl+
 7KYrdnI6z2SbptxuFlgNIGmV6yQKKid/tohYFMtDkNwFmyuoYNePv/SmPMQbYrtipP8n3xipUqe
 d
X-Google-Smtp-Source: AGHT+IFi57PH5SEjx5dXvjuocNeWUrFyQjBsiAGO3GCUNpABUF+EyYltXk3k2UraTl3o+inpkmJkEw==
X-Received: by 2002:ac2:58d5:0:b0:510:cab:e772 with SMTP id
 u21-20020ac258d5000000b005100cabe772mr4686451lfo.13.1706604042032; 
 Tue, 30 Jan 2024 00:40:42 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 g7-20020a05600c4ec700b0040e5945307esm12422035wmq.40.2024.01.30.00.40.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 00:40:41 -0800 (PST)
Message-ID: <d26582c2-88e4-4813-bef6-0c12faca34b5@linaro.org>
Date: Tue, 30 Jan 2024 09:40:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/22] target/sparc: Inline FNEG, FABS
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20231103173841.33651-1-richard.henderson@linaro.org>
 <20231103173841.33651-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231103173841.33651-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
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

Hi Richard,

On 3/11/23 18:38, Richard Henderson wrote:
> These are simple bit manipulation insns.
> Begin using i128 for float128.
> Implement FMOVq with do_qq.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/helper.h     |  6 ----
>   target/sparc/fop_helper.c | 34 ---------------------
>   target/sparc/translate.c  | 62 +++++++++++++++++++--------------------
>   3 files changed, 30 insertions(+), 72 deletions(-)


> @@ -1239,13 +1235,13 @@ static void gen_op_fmovs(TCGv_i32 dst, TCGv_i32 src)
>   static void gen_op_fnegs(TCGv_i32 dst, TCGv_i32 src)
>   {
>       gen_op_clear_ieee_excp_and_FTT();
> -    gen_helper_fnegs(dst, src);
> +    tcg_gen_xori_i32(dst, src, 1u << 31);
>   }
>   
>   static void gen_op_fabss(TCGv_i32 dst, TCGv_i32 src)
>   {
>       gen_op_clear_ieee_excp_and_FTT();
> -    gen_helper_fabss(dst, src);
> +    tcg_gen_andi_i32(dst, src, ~(1u << 31));
>   }
>   
>   static void gen_op_fmovd(TCGv_i64 dst, TCGv_i64 src)
> @@ -1257,13 +1253,33 @@ static void gen_op_fmovd(TCGv_i64 dst, TCGv_i64 src)
>   static void gen_op_fnegd(TCGv_i64 dst, TCGv_i64 src)
>   {
>       gen_op_clear_ieee_excp_and_FTT();
> -    gen_helper_fnegd(dst, src);
> +    tcg_gen_xori_i64(dst, src, 1ull << 63);
>   }
>   
>   static void gen_op_fabsd(TCGv_i64 dst, TCGv_i64 src)
>   {
>       gen_op_clear_ieee_excp_and_FTT();
> -    gen_helper_fabsd(dst, src);
> +    tcg_gen_andi_i64(dst, src, ~(1ull << 63));
> +}
> +
> +static void gen_op_fnegq(TCGv_i128 dst, TCGv_i128 src)
> +{
> +    TCGv_i64 l = tcg_temp_new_i64();
> +    TCGv_i64 h = tcg_temp_new_i64();
> +
> +    tcg_gen_extr_i128_i64(l, h, src);
> +    tcg_gen_xori_i64(h, h, 1ull << 63);
> +    tcg_gen_concat_i64_i128(dst, l, h);
> +}
> +
> +static void gen_op_fabsq(TCGv_i128 dst, TCGv_i128 src)
> +{
> +    TCGv_i64 l = tcg_temp_new_i64();
> +    TCGv_i64 h = tcg_temp_new_i64();
> +
> +    tcg_gen_extr_i128_i64(l, h, src);
> +    tcg_gen_andi_i64(h, h, ~(1ull << 63));
> +    tcg_gen_concat_i64_i128(dst, l, h);
>   }

Why not extract these as generic TCG FPU helpers?

$ git grep -wE 'float...?_(chs|abs)' target/
target/arm/tcg/helper-a64.c:214:    a = float16_chs(a);
target/arm/tcg/helper-a64.c:229:    a = float32_chs(a);
target/arm/tcg/helper-a64.c:244:    a = float64_chs(a);
target/arm/tcg/helper-a64.c:259:    a = float16_chs(a);
target/arm/tcg/helper-a64.c:274:    a = float32_chs(a);
target/arm/tcg/helper-a64.c:289:    a = float64_chs(a);
target/arm/tcg/helper-a64.c:632:    float16 f0 = float16_abs(a);
target/arm/tcg/helper-a64.c:633:    float16 f1 = float16_abs(b);
target/arm/tcg/helper-a64.c:642:    float16 f0 = float16_abs(a);
target/arm/tcg/helper-a64.c:643:    float16 f1 = float16_abs(b);
target/arm/tcg/mve_helper.c:2840:    return float16_abs(float16_sub(a, 
b, s));
target/arm/tcg/mve_helper.c:2845:    return float32_abs(float32_sub(a, 
b, s));
target/arm/tcg/mve_helper.c:2854:    return 
float16_maxnum(float16_abs(a), float16_abs(b), s);
target/arm/tcg/mve_helper.c:2859:    return 
float32_maxnum(float32_abs(a), float32_abs(b), s);
target/arm/tcg/mve_helper.c:2864:    return 
float16_minnum(float16_abs(a), float16_abs(b), s);
target/arm/tcg/mve_helper.c:2869:    return 
float32_minnum(float32_abs(a), float32_abs(b), s);
target/arm/tcg/neon_helper.c:1513:    float32 f0 = 
float32_abs(make_float32(a));
target/arm/tcg/neon_helper.c:1514:    float32 f1 = 
float32_abs(make_float32(b));
target/arm/tcg/neon_helper.c:1521:    float32 f0 = 
float32_abs(make_float32(a));
target/arm/tcg/neon_helper.c:1522:    float32 f1 = 
float32_abs(make_float32(b));
target/arm/tcg/neon_helper.c:1529:    float64 f0 = 
float64_abs(make_float64(a));
target/arm/tcg/neon_helper.c:1530:    float64 f1 = 
float64_abs(make_float64(b));
target/arm/tcg/neon_helper.c:1537:    float64 f0 = 
float64_abs(make_float64(a));
target/arm/tcg/neon_helper.c:1538:    float64 f1 = 
float64_abs(make_float64(b));
target/arm/tcg/sve_helper.c:4227:DO_REDUCE(sve_fmaxv_h, float16, H1_2, 
max, float16_chs(float16_infinity))
target/arm/tcg/sve_helper.c:4228:DO_REDUCE(sve_fmaxv_s, float32, H1_4, 
max, float32_chs(float32_infinity))
target/arm/tcg/sve_helper.c:4229:DO_REDUCE(sve_fmaxv_d, float64, H1_8, 
max, float64_chs(float64_infinity))
target/arm/tcg/sve_helper.c:4345:    return float16_abs(float16_sub(a, 
b, s));
target/arm/tcg/sve_helper.c:4350:    return float32_abs(float32_sub(a, 
b, s));
target/arm/tcg/sve_helper.c:4355:    return float64_abs(float64_sub(a, 
b, s));
target/arm/tcg/sve_helper.c:4997:            mm = float16_abs(mm);
target/arm/tcg/sve_helper.c:5019:            mm = float32_abs(mm);
target/arm/tcg/sve_helper.c:5045:            mm = float64_abs(mm);
target/arm/tcg/sve_helper.c:5062:    float16 neg_real = 
float16_chs(neg_imag);
target/arm/tcg/sve_helper.c:5094:    float32 neg_real = 
float32_chs(neg_imag);
target/arm/tcg/sve_helper.c:5126:    float64 neg_real = 
float64_chs(neg_imag);
target/arm/tcg/vec_helper.c:996:    return -float16_le(float16_abs(op2), 
float16_abs(op1), stat);
target/arm/tcg/vec_helper.c:1001:    return 
-float32_le(float32_abs(op2), float32_abs(op1), stat);
target/arm/tcg/vec_helper.c:1006:    return 
-float16_lt(float16_abs(op2), float16_abs(op1), stat);
target/arm/tcg/vec_helper.c:1011:    return 
-float32_lt(float32_abs(op2), float32_abs(op1), stat);
target/arm/tcg/vec_helper.c:1124:    return float16_abs(float16_sub(op1, 
op2, stat));
target/arm/tcg/vec_helper.c:1129:    return float32_abs(float32_sub(op1, 
op2, stat));
target/arm/tcg/vec_helper.c:1304:    return 
float16_muladd(float16_chs(op1), op2, dest, 0, stat);
target/arm/tcg/vec_helper.c:1310:    return 
float32_muladd(float32_chs(op1), op2, dest, 0, stat);
target/arm/vfp_helper.c:286:    return float16_chs(a);
target/arm/vfp_helper.c:291:    return float32_chs(a);
target/arm/vfp_helper.c:296:    return float64_chs(a);
target/arm/vfp_helper.c:301:    return float16_abs(a);
target/arm/vfp_helper.c:306:    return float32_abs(a);
target/arm/vfp_helper.c:311:    return float64_abs(a);
target/arm/vfp_helper.c:688:    } else if (float16_abs(f16) < (1 << 8)) {
target/arm/vfp_helper.c:738:    } else if (float32_abs(f32) < (1ULL << 
21)) {
target/arm/vfp_helper.c:1133:    if (value == float64_chs(float64_zero)) {
target/i386/tcg/fpu_helper.c:591:    ST0 = floatx80_chs(ST0);
target/i386/tcg/fpu_helper.c:596:    ST0 = floatx80_abs(ST0);
target/i386/tcg/fpu_helper.c:781:        tmp = floatx80_chs(tmp);
target/i386/tcg/fpu_helper.c:1739:        ST0 = 
floatx80_div(floatx80_chs(floatx80_one), floatx80_zero,
target/i386/tcg/fpu_helper.c:2104:            ST1 = floatx80_chs(ST1);
target/i386/tcg/fpu_helper.c:2119:            ST1 = floatx80_chs(ST0);
target/i386/tcg/fpu_helper.c:2135:            ST1 = floatx80_chs(ST1);
target/i386/tcg/fpu_helper.c:2140:            ST1 = 
floatx80_chs(floatx80_zero);
target/i386/tcg/fpu_helper.c:2276: 
floatx80_chs(floatx80_zero) :
target/i386/tcg/fpu_helper.c:2285: 
floatx80_chs(floatx80_infinity) :
target/m68k/fpu_helper.c:212:    res->d = 
floatx80_round(floatx80_abs(val->d), &env->fp_status);
target/m68k/fpu_helper.c:218:    res->d = 
floatx80_round(floatx80_abs(val->d), &env->fp_status);
target/m68k/fpu_helper.c:225:    res->d = 
floatx80_round(floatx80_abs(val->d), &env->fp_status);
target/m68k/fpu_helper.c:231:    res->d = 
floatx80_round(floatx80_chs(val->d), &env->fp_status);
target/m68k/fpu_helper.c:237:    res->d = 
floatx80_round(floatx80_chs(val->d), &env->fp_status);
target/m68k/fpu_helper.c:244:    res->d = 
floatx80_round(floatx80_chs(val->d), &env->fp_status);
target/m68k/fpu_helper.c:557:        quotient = 
floatx80_to_int32(floatx80_abs(fp_quot.d), &env->fp_status);
target/m68k/softfloat.c:2714:            fp0 = floatx80_abs(a); /* Y = 
|X| */
target/m68k/softfloat.c:2734:        fp0 = floatx80_abs(a); /* Y = |X| */
target/mips/tcg/fpu_helper.c:977:   return float64_abs(fdt0);
target/mips/tcg/fpu_helper.c:982:    return float32_abs(fst0);
target/mips/tcg/fpu_helper.c:990:    wt0 = float32_abs(fdt0 & 0XFFFFFFFF);
target/mips/tcg/fpu_helper.c:991:    wth0 = float32_abs(fdt0 >> 32);
target/mips/tcg/fpu_helper.c:997:   return float64_chs(fdt0);
target/mips/tcg/fpu_helper.c:1002:    return float32_chs(fst0);
target/mips/tcg/fpu_helper.c:1010:    wt0 = float32_chs(fdt0 & 0XFFFFFFFF);
target/mips/tcg/fpu_helper.c:1011:    wth0 = float32_chs(fdt0 >> 32);
target/mips/tcg/fpu_helper.c:1365:    fdt2 = 
float64_chs(float64_sub(fdt2, float64_one,
target/mips/tcg/fpu_helper.c:1374:    fst2 = 
float32_chs(float32_sub(fst2, float32_one,
target/mips/tcg/fpu_helper.c:1389:    fstl2 = 
float32_chs(float32_sub(fstl2, float32_one,
target/mips/tcg/fpu_helper.c:1391:    fsth2 = 
float32_chs(float32_sub(fsth2, float32_one,
target/mips/tcg/fpu_helper.c:1401:    fdt2 = 
float64_chs(float64_div(fdt2, FLOAT_TWO64,
target/mips/tcg/fpu_helper.c:1411:    fst2 = 
float32_chs(float32_div(fst2, FLOAT_TWO32,
target/mips/tcg/fpu_helper.c:1428:    fstl2 = 
float32_chs(float32_div(fstl2, FLOAT_TWO32,
target/mips/tcg/fpu_helper.c:1430:    fsth2 = 
float32_chs(float32_div(fsth2, FLOAT_TWO32,
target/mips/tcg/fpu_helper.c:1633:    fst0 = float64_chs(fst0);
target/mips/tcg/fpu_helper.c:1644:    fst0 = float32_chs(fst0);
target/mips/tcg/fpu_helper.c:1662:    fstl0 = float32_chs(fstl0);
target/mips/tcg/fpu_helper.c:1665:    fsth0 = float32_chs(fsth0);
target/mips/tcg/fpu_helper.c:1676:    fst0 = float64_chs(fst0);
target/mips/tcg/fpu_helper.c:1687:    fst0 = float32_chs(fst0);
target/mips/tcg/fpu_helper.c:1705:    fstl0 = float32_chs(fstl0);
target/mips/tcg/fpu_helper.c:1708:    fsth0 = float32_chs(fsth0);
target/mips/tcg/fpu_helper.c:1781:    fdt0 = float64_abs(fdt0); 
                         \
target/mips/tcg/fpu_helper.c:1782:    fdt1 = float64_abs(fdt1); 
                         \
target/mips/tcg/fpu_helper.c:1860:    fst0 = float32_abs(fst0); 
                         \
target/mips/tcg/fpu_helper.c:1861:    fst1 = float32_abs(fst1); 
                         \
target/mips/tcg/fpu_helper.c:1950:    fst0 = float32_abs(fdt0 & 
0XFFFFFFFF);                      \
target/mips/tcg/fpu_helper.c:1951:    fsth0 = float32_abs(fdt0 >> 32); 
                          \
target/mips/tcg/fpu_helper.c:1952:    fst1 = float32_abs(fdt1 & 
0XFFFFFFFF);                      \
target/mips/tcg/fpu_helper.c:1953:    fsth1 = float32_abs(fdt1 >> 32); 
                          \
target/ppc/fpu_helper.c:44:        return float32_chs(a);
target/ppc/int_helper.c:694:            float32 bneg = 
float32_chs(b->f32[i]);
target/s390x/tcg/vec_fpu_helper.c:922:                a = float32_abs(a);
target/s390x/tcg/vec_fpu_helper.c:923:                b = float32_abs(b);
target/s390x/tcg/vec_fpu_helper.c:984:                a = float64_abs(a);
target/s390x/tcg/vec_fpu_helper.c:985:                b = float64_abs(b);
target/s390x/tcg/vec_fpu_helper.c:1042:            a = float128_abs(a);
target/s390x/tcg/vec_fpu_helper.c:1043:            b = float128_abs(b);
target/sparc/fop_helper.c:119:    return float32_chs(src);
target/sparc/fop_helper.c:125:    return float64_chs(src);
target/sparc/fop_helper.c:130:    QT0 = float128_chs(QT1);
target/sparc/fop_helper.c:234:    return float32_abs(src);
target/sparc/fop_helper.c:240:    return float64_abs(src);
target/sparc/fop_helper.c:245:    QT0 = float128_abs(QT1);
target/xtensa/fpu_helper.c:126:    return float64_abs(v);
target/xtensa/fpu_helper.c:131:    return float32_abs(v);
target/xtensa/fpu_helper.c:136:    return float64_chs(v);
target/xtensa/fpu_helper.c:141:    return float32_chs(v);


