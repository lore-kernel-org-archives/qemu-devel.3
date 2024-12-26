Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFE4E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:56:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvpK-0008UW-3v; Thu, 26 Dec 2024 16:55:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQvpI-0008UH-6F
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:55:28 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQvpG-0007S1-Cb
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:55:27 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21675fd60feso105141635ad.2
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 13:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735250123; x=1735854923; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cHdQ7A+RbrzPPBpdpwrv/wBXSy5zdlPGnIUg4OR6Js8=;
 b=zzFUrCPONwXNLpGC1NiDe+KrbrNN+Ta3UpfSgTFcSY06DVW20fHBcYR+CaE2Z0zzPv
 VJWylNYMAnCzdOafUmCWUIkR8m+crxSChsF6VjmZN2hr3tzCyXS8ihxBxPCNwBS4UZ30
 3naOZrNDXCPKWFkiLQGXpVqAyIrVKxFebN8zH+Vb2qOUYbjsVfa7NuOLsopuLdwEiOYz
 kDE9/awoN1qmnwbTCUYkFIieo5kblYAIGQsq0qhrt2dQkOzpJ8ETjwv6SFE3ga2iUHX5
 HStuy8wMq2P/czwDwv88uW+50GWERVD7nlQJVWoAavD19qvEzvD/UoEH+ZiorY2Hvwhv
 M8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735250123; x=1735854923;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cHdQ7A+RbrzPPBpdpwrv/wBXSy5zdlPGnIUg4OR6Js8=;
 b=TSHmn30pMQOxUFDQyuZqpR4ACstf8G/dmR8tqRVMqsTmdA4saojaoV/7CRRYZ7j6Gq
 sSXr6JWKUkhgmR/P+i+PkmdhqLiJUNpPlqaxBQ7iun1I/n85C9NCsKf9CbITbPsxiamt
 er6x7XHPLvCP1p2O/QAjtZuPGO7uWaAxnAnC5Ace2Wx8XoF0IW1SaBxx39l/JLedyJpK
 O3AFaEm2ripEFoKqsSL6+N0xHpbxP9pJRxNtIwk8ZoOeHyZMefd5Abr0LnRwgmn0/nMW
 +5dlcYnCzWplG7KQzxQFyg7nCruqceO9dUyR7upXy8vYua+CoZ6ml+D+2VMcllKbPQFE
 mfzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw4gvo2QIROTS9GEXATHfevknk+FnZKzr9dTkLr/+qxLgD3jHHN/FJ4hEF2gQW/x0lyOaPKlbWt5+Z@nongnu.org
X-Gm-Message-State: AOJu0YxxUQn5u6cXi1Eou0aH/jwEGqYX5/FLuUtek8MO14SC6ILJ4+lq
 955ZAGvN9izFn1ZnEvkQfEG2wk99NxGNdMUarE2WMerBpgG6ZoMnQEpd0rI2+jc=
X-Gm-Gg: ASbGnctE38j0ZKjZpJO4DhE/wsiUQ5oxtqC0tuTD8MUPPAlYHkufCacKVRkgsbVnuQm
 vLqwKtqSXOwD/TuLGAxx14tZP5OIhh1W/8vntCHLwfFXbvyDUJd+hkiWlL6gxwjF4UWU5qYvyjS
 RVw+t7sXKCbJfWg3/zWEUK89bhas26ODThXH9YeNdP6QRiQPdGnyQM3i6iECXzYaeXs970YfFCc
 /AK521ZUvkSWyZfEOLYuP9eILLyN5WYCvIVusMclVm3nIfaA9781zWGRg7d4pHT+mZePdJmnAUs
 eYLg72vb4cOzVCUGog1jpGDf2ahO7rEuT9eR3nk=
X-Google-Smtp-Source: AGHT+IGL8lYkkailqb7119r3sonHKCf7gj2R18a2LTOE0qmFvyv42l/79cBQLUV+8L/DDf2VZ95b6A==
X-Received: by 2002:a05:6a00:4644:b0:728:fab1:eda0 with SMTP id
 d2e1a72fcca58-72abdebaae0mr31765373b3a.25.1735250123445; 
 Thu, 26 Dec 2024 13:55:23 -0800 (PST)
Received: from [192.168.125.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbad9sm13804616b3a.103.2024.12.26.13.55.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 13:55:23 -0800 (PST)
Message-ID: <f2360c0b-979a-4473-a7b1-96caa54cff27@linaro.org>
Date: Thu, 26 Dec 2024 13:55:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/23] target/loongarch: Scrutinise TCG bitops
 translation for 32 bit build
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
 <20241226-la32-fixes1-v2-12-0414594f8cb5@flygoat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241226-la32-fixes1-v2-12-0414594f8cb5@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 12/26/24 13:19, Jiaxun Yang wrote:
> Use tl variant whenever possible.
> 
> Silent compiler warnings by performing casting for come consts.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   target/loongarch/tcg/insn_trans/trans_bit.c.inc | 34 ++++++++++++++-----------
>   1 file changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/target/loongarch/tcg/insn_trans/trans_bit.c.inc b/target/loongarch/tcg/insn_trans/trans_bit.c.inc
> index ee5fa003ce06a1910f826c3eb96d1d532c32e02c..a40346a670be31a123848e8ea5f7b94f8372976b 100644
> --- a/target/loongarch/tcg/insn_trans/trans_bit.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_bit.c.inc
> @@ -18,13 +18,17 @@ static bool gen_rr(DisasContext *ctx, arg_rr *a,
>   
>   static void gen_bytepick_w(TCGv dest, TCGv src1, TCGv src2, target_long sa)
>   {
> +#ifdef TARGET_LOONGARCH64
>       tcg_gen_concat_tl_i64(dest, src1, src2);
>       tcg_gen_sextract_i64(dest, dest, (32 - sa * 8), 32);
> +#else
> +    tcg_gen_extract2_tl(dest, src1, src2, (32 - sa * 8));

This is the kind of case where using _i32 explicitly emphasizes that the specific size is 
required for correctness.  You've already got the ifdef to protect the code anyway.

>   static void gen_bytepick_d(TCGv dest, TCGv src1, TCGv src2, target_long sa)
>   {
> -    tcg_gen_extract2_i64(dest, src1, src2, (64 - sa * 8));
> +    tcg_gen_extract2_tl(dest, src1, src2, (64 - sa * 8));
>   }
>   
>   static bool gen_bstrins(DisasContext *ctx, arg_rr_ms_ls *a,
> @@ -85,7 +89,7 @@ static void gen_cto_w(TCGv dest, TCGv src1)
>   
>   static void gen_clz_d(TCGv dest, TCGv src1)
>   {
> -    tcg_gen_clzi_i64(dest, src1, TARGET_LONG_BITS);
> +    tcg_gen_clzi_tl(dest, src1, TARGET_LONG_BITS);
>   }
>   
>   static void gen_clo_d(TCGv dest, TCGv src1)
> @@ -107,8 +111,8 @@ static void gen_cto_d(TCGv dest, TCGv src1)
>   
>   static void gen_revb_2w(TCGv dest, TCGv src1)
>   {
> -    tcg_gen_bswap64_i64(dest, src1);
> -    tcg_gen_rotri_i64(dest, dest, 32);
> +    tcg_gen_bswap_tl(dest, src1);
> +    tcg_gen_rotri_tl(dest, dest, 32);
>   }
>   
>   static void gen_revb_2h(TCGv dest, TCGv src1)
> @@ -126,7 +130,7 @@ static void gen_revb_2h(TCGv dest, TCGv src1)
>   
>   static void gen_revb_4h(TCGv dest, TCGv src1)
>   {
> -    TCGv mask = tcg_constant_tl(0x00FF00FF00FF00FFULL);
> +    TCGv mask = tcg_constant_tl((target_ulong)0x00FF00FF00FF00FFULL);
>       TCGv t0 = tcg_temp_new();
>       TCGv t1 = tcg_temp_new();
>   
> @@ -139,22 +143,22 @@ static void gen_revb_4h(TCGv dest, TCGv src1)
>   
>   static void gen_revh_2w(TCGv dest, TCGv src1)
>   {
> -    TCGv_i64 t0 = tcg_temp_new_i64();
> -    TCGv_i64 t1 = tcg_temp_new_i64();
> -    TCGv_i64 mask = tcg_constant_i64(0x0000ffff0000ffffull);
> +    TCGv t0 = tcg_temp_new();
> +    TCGv t1 = tcg_temp_new();
> +    TCGv mask = tcg_constant_tl((target_ulong)0x0000ffff0000ffffull);
>   
> -    tcg_gen_shri_i64(t0, src1, 16);
> -    tcg_gen_and_i64(t1, src1, mask);
> -    tcg_gen_and_i64(t0, t0, mask);
> -    tcg_gen_shli_i64(t1, t1, 16);
> -    tcg_gen_or_i64(dest, t1, t0);
> +    tcg_gen_shri_tl(t0, src1, 16);
> +    tcg_gen_and_tl(t1, src1, mask);
> +    tcg_gen_and_tl(t0, t0, mask);
> +    tcg_gen_shli_tl(t1, t1, 16);
> +    tcg_gen_or_tl(dest, t1, t0);
>   }
>   
>   static void gen_revh_d(TCGv dest, TCGv src1)
>   {
>       TCGv t0 = tcg_temp_new();
>       TCGv t1 = tcg_temp_new();
> -    TCGv mask = tcg_constant_tl(0x0000FFFF0000FFFFULL);
> +    TCGv mask = tcg_constant_tl((target_ulong)0x0000FFFF0000FFFFULL);
>   
>       tcg_gen_shri_tl(t1, src1, 16);
>       tcg_gen_and_tl(t1, t1, mask);

While this allows the code to compile, (1) the functions are unused and (2) they do not 
compute the required results.  For me, the latter is concerning.

I'd suggest moving GEN_FALSE_TRANS out of trans_privileged.c.inc, then

#ifdef TARGET_LOONGARCH64
// all gen_foo_d
TRANS(bytepick_d, 64, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_bytepick_d)
// etc
#else
GEN_FALSE_TRANS(bytepick_d)
// etc
#endif


r~

