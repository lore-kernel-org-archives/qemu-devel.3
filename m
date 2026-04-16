Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECFDF433CD
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 00:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDAMw-0002ch-CM; Wed, 15 Apr 2026 20:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDAMn-0002bo-PV
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 20:13:59 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDAMd-0001bA-0l
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 20:13:49 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-35da9c0c007so6371361a91.2
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 17:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776298424; x=1776903224; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lpkKDjg6Vu6h1LoOrgCu9eIJd19m+jEndX2bVajX6CM=;
 b=tPtL2W6IgriBKR414m8/TW30ceLY9bQ/vefnvNvFKAikAPKk24++LU0AYoXMnt/0Td
 /0Hye99xcvo3dZRI6X/V+LLXKNgE6WV9FQShlhDXbr8+xeUJhFWOkCf8TJvcDimqywM1
 guzuquJ84syLKd2ejUK/++wunVfgSf9gIqrdz8ekNBWunooPhe+kL0rQhp/u/i0DInkY
 ZozpKVMpjHU8FFLrlqVI9bSDgLDtMZ+xQMTXudWFu6Vacfx9vzDGS5QnuYUHLOb6c7H6
 QD9rrsqMWxAgJbWF75GfbeZVzq0q9V3iCcdMw83zneaLuu4XlDUzNrlBZdeGQIZNyoba
 ZIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776298424; x=1776903224;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lpkKDjg6Vu6h1LoOrgCu9eIJd19m+jEndX2bVajX6CM=;
 b=KJf7hDN0g3C8UHikMAE4gL/ArK5tIb9BL6jfOMvMP4mS2qj25HbJjAvTmwSDSw0bHd
 53uYHRR+N6cz7POHWnlsCZfAkxeyl9y7+RuMnhiMb9ZaW6XCvJR9Q5fYzQETq9rr4rzd
 Q96kQSz9DC4xLP68bdc3seXQlopkBxpOTKVSuqFnzuTMWnsPwPEzOlXaOYya9jT62BHR
 GvxuKPSkqQwdQzsUdn/TIEyC6kWanLf7sVjRiME6OM/sIzc4vCVCwMmZDGh/fEUSKeqN
 mSqSmkU4n5lBdCvGsndIt6McvJpISuZo6kl4QKkwtOyJ/s84MmTl95LbyZCrGkSEglZe
 rEOg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Sx7ix4wtvgUO/SK+P0tu6EbohwE2GmSso5TK3wyJR24x77Eurij9CGRA08icJ6ao25VWM/RFxI3DY@nongnu.org
X-Gm-Message-State: AOJu0Ywj7bjs4AbTYPbs7PCPELPKy81kSlxOkKRrlR8b4i46icvDjNS8
 f6gYrdQPKextGGZ732KTIgmSVGdFQk5/MBcmc2SHXiL8s6lf1cWLYp6BE0qayO7d7LI=
X-Gm-Gg: AeBDietMI7TBPiQR5at4aX8Ta9lAX4nyFyS6eXvaWf5fjT6ooMrb+zB4WFClXEsQIPL
 Y5dTm1ozeWuDyyxg5KLm3YUoelolbtxaxiNuDLJoR9GunfBO36uzbiOl2fpS3pPrvWRoX+MpBke
 kAtwE8KDuViCEydO3q18s6/1gRMyS8mYnTx2Ey5V3mhQkiu21HhLU4fPt++bPRmnhsEgxQY9z34
 mw9EuW+N0vI0EabTqdw+oJr8K8BE8jOksA3wl8Y+A/rP0CWyhSDVWXSf8Uab0haXH+560cS8LdZ
 z+gk+J1lCrUDxBMjnmeQqQUmCB5Xrr9bdy++Cpz9c6sbsd9T2nii/9Efisb407+IKwancYLaXDd
 20lCGPmBKN+JNJWXovL/8QhWeCtHdMbQ8ASPyLWVdja8wJ8osrIjMwIqHx2fKuJS+169JIcVxqx
 CZ3XcRQmuvrFFxwiWZEMd370Gy8ANdSKPIWzOMfvYNznuYe8lf4olSu/6G4g5DM0tIfzxrVvt0h
 eEdJSquMZDdZh5ujHooDcXK
X-Received: by 2002:a17:90b:38ca:b0:35d:93ff:2855 with SMTP id
 98e67ed59e1d1-35e42763a73mr24002550a91.8.1776298423935; 
 Wed, 15 Apr 2026 17:13:43 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:31f2:aa94:4389:37f8?
 ([2401:d002:dc0f:2100:31f2:aa94:4389:37f8])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35fd076a563sm2020699a91.3.2026.04.15.17.13.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 17:13:43 -0700 (PDT)
Message-ID: <34374075-e340-4294-ae43-62d1422b5029@linaro.org>
Date: Thu, 16 Apr 2026 10:13:37 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 4/6] target/mips: Convert MSA LD/ST.W (Word Vector)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20260415202027.83008-1-philmd@linaro.org>
 <20260415202027.83008-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260415202027.83008-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 4/16/26 06:20, Philippe Mathieu-Daudé wrote:
> Replace runtime helpers by translation.
> 
> Replace the legacy cpu_ld/st*_data_ra() calls by
> tcg_gen_qemu_ld/st() which allow to respect atomicity.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/msa_helper.h.inc |  1 -
>   target/mips/tcg/msa_helper.c     | 47 --------------------------------
>   target/mips/tcg/msa_translate.c  | 20 ++++++++++----
>   3 files changed, 14 insertions(+), 54 deletions(-)

Modulo new temps for store,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/target/mips/tcg/msa_helper.h.inc b/target/mips/tcg/msa_helper.h.inc
> index 86a79bf804c..f0d31ceef29 100644
> --- a/target/mips/tcg/msa_helper.h.inc
> +++ b/target/mips/tcg/msa_helper.h.inc
> @@ -436,6 +436,5 @@ DEF_HELPER_4(msa_ffint_u_df, void, env, i32, i32, i32)
>   #define MSALDST_PROTO(type)                         \
>   DEF_HELPER_3(msa_ld_ ## type, void, env, i32, tl)   \
>   DEF_HELPER_3(msa_st_ ## type, void, env, i32, tl)
> -MSALDST_PROTO(w)
>   MSALDST_PROTO(d)
>   #undef MSALDST_PROTO
> diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
> index 5489d8830dd..c93c0cddebc 100644
> --- a/target/mips/tcg/msa_helper.c
> +++ b/target/mips/tcg/msa_helper.c
> @@ -8212,32 +8212,6 @@ void helper_msa_ffint_u_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
>   /* Element-by-element access macros */
>   #define DF_ELEMENTS(df) (MSA_WRLEN / DF_BITS(df))
>   
> -static inline uint64_t bswap32x2(uint64_t x)
> -{
> -    return ror64(bswap64(x), 32);
> -}
> -
> -void helper_msa_ld_w(CPUMIPSState *env, uint32_t wd,
> -                     target_ulong addr)
> -{
> -    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
> -    uintptr_t ra = GETPC();
> -    uint64_t d0, d1;
> -
> -    /*
> -     * Load 8 bytes at a time.  Use little-endian load, then for
> -     * big-endian target, we must then bswap the two words.
> -     */
> -    d0 = cpu_ldq_le_data_ra(env, addr + 0, ra);
> -    d1 = cpu_ldq_le_data_ra(env, addr + 8, ra);
> -    if (mips_env_is_bigendian(env)) {
> -        d0 = bswap32x2(d0);
> -        d1 = bswap32x2(d1);
> -    }
> -    pwd->d[0] = d0;
> -    pwd->d[1] = d1;
> -}
> -
>   void helper_msa_ld_d(CPUMIPSState *env, uint32_t wd,
>                        target_ulong addr)
>   {
> @@ -8269,27 +8243,6 @@ static inline void ensure_writable_pages(CPUMIPSState *env,
>       }
>   }
>   
> -void helper_msa_st_w(CPUMIPSState *env, uint32_t wd,
> -                     target_ulong addr)
> -{
> -    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
> -    int mmu_idx = mips_env_mmu_index(env);
> -    uintptr_t ra = GETPC();
> -    uint64_t d0, d1;
> -
> -    ensure_writable_pages(env, addr, mmu_idx, ra);
> -
> -    /* Store 8 bytes at a time.  See helper_msa_ld_w. */
> -    d0 = pwd->d[0];
> -    d1 = pwd->d[1];
> -    if (mips_env_is_bigendian(env)) {
> -        d0 = bswap32x2(d0);
> -        d1 = bswap32x2(d1);
> -    }
> -    cpu_stq_le_data_ra(env, addr + 0, d0, ra);
> -    cpu_stq_le_data_ra(env, addr + 8, d1, ra);
> -}
> -
>   void helper_msa_st_d(CPUMIPSState *env, uint32_t wd,
>                        target_ulong addr)
>   {
> diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
> index 111d9eedd11..8486508f5ba 100644
> --- a/target/mips/tcg/msa_translate.c
> +++ b/target/mips/tcg/msa_translate.c
> @@ -770,11 +770,21 @@ static void gen_bswap16x4_i64(TCGv_i64 dst, TCGv_i64 src)
>       tcg_gen_or_i64(dst, t0, t1);        /* dst = badcfebg */
>   }
>   
> +/*
> + * Byte pattern: abcd.efgh -> dcba.hgfe
> + */
> +static void gen_bswap32x2_i64(TCGv_i64 dst, TCGv_i64 src)
> +{
> +    tcg_gen_bswap64_i64(dst, src);
> +    tcg_gen_rotri_i64(dst, dst, 32);
> +}
> +
>   static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
>   {
>       static const MemOp mo_atom_df[4] = {
>           MO_ATOM_NONE,
>           MO_ATOM_SUBALIGN, /* Slightly stronger than required */
> +        MO_ATOM_SUBALIGN, /* Slightly stronger than required */
>       };
>       TCGv_i32 wd;
>       TCGv_i128 t16;
> @@ -795,18 +805,12 @@ static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
>   
>       if (is_load) {
>           switch (a->df) {
> -        case 2:
> -            gen_helper_msa_ld_w(tcg_env, wd, addr);
> -            return true;
>           case 3:
>               gen_helper_msa_ld_d(tcg_env, wd, addr);
>               return true;
>           }
>       } else {
>           switch (a->df) {
> -        case 2:
> -            gen_helper_msa_st_w(tcg_env, wd, addr);
> -            return true;
>           case 3:
>               gen_helper_msa_st_d(tcg_env, wd, addr);
>               return true;
> @@ -830,6 +834,10 @@ static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
>               gen_bswap16x4_i64(d0, d0);
>               gen_bswap16x4_i64(d1, d1);
>               break;
> +        case 2:
> +            gen_bswap32x2_i64(d0, d0);
> +            gen_bswap32x2_i64(d1, d1);
> +            break;
>           }
>       }
>   


