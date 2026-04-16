Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F081F433CD
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 00:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDAE5-0008Rg-OI; Wed, 15 Apr 2026 20:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDAE3-0008RQ-Sf
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 20:04:55 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDAE1-0005v1-Ss
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 20:04:55 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-35fc0d7c310so2114097a91.1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 17:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776297892; x=1776902692; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dXNuO8b4QLN2kjc/aihzSjn++hkaps0Hdvi3LAgHxXk=;
 b=MQ7gGXtiT4BcuALr/iIdbABsoXJyPi/3VXNmPlVgxynf4Dnn7horX+XMZaWU4LZ81B
 kanzMN6v8TakslhOYhp5ZYed49zkRFGJO9TVqFUAAicmnCRVBCjkhI71dcjrIrGfEakT
 vJMxdRP66To8/cvAGTKUwkk2bt1kmt5pJtuLE7ne6T18xHbpIeFWdMZFsfORdSRMaGqq
 tdtHBDOp2nASKWBWvyffVtReVXmIy6A91mSaMcoKbz6Fy1Xe/tHQsv4fN9R9iYv6y51A
 AUxFSeTnINoqhWJHThqOqPMYHmB3VVf+q6MBpp4aIvynZq2lblNrjvJLYCSQy8ibkc/6
 6qMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776297892; x=1776902692;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dXNuO8b4QLN2kjc/aihzSjn++hkaps0Hdvi3LAgHxXk=;
 b=DE9pxdmWF0touIcJ/pD37OQvIx0GLdWV+LtAvQI11jWyoX0lsgFI8Bxc5w3hJS7hGr
 qMSQ6UyChI5Lvvz0/pC8FEbcVypYmg8u5lNpriaVmvLFkfXZiMLrba9sw5czsgQkz+je
 7AzgGsxj41Z6oq5lV5NwCPBLL+rPMuIgMzwYOAqVZZm4ibm36j4d3fsJRDZ2R3u/rBDG
 mNn08rbR04PvRLcGK3z3DBQ7jSnaqelmQ1V9c0gRSXIlwqou/alMhahRTvHk+imbxikg
 0bBUhnVN9j0kKFZFiSLpZvk6UlQ2zplHo/Eb2WMaUDGmWwBh4DB4SbnqYCmYy77mLwrf
 wvIg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+nP4ilI6LPFx5F+P2sUCF4vKrvLjBxQ2LgNUDGtoVPrIXNXqgNSdTZUhvEg+cCoQbIL4OdXH8Fyuq3@nongnu.org
X-Gm-Message-State: AOJu0YwAsxhtob/wv6+l/8wLB4Vl0o0XOL8CfyEE0Rh6zqsbN/BdCF8Z
 KboDuyHPTiA4k8ClsImhqzKWqsUKHDmqMhHUqfwUcMc43F+gMdBMXk28oEIy4Ayrz+A=
X-Gm-Gg: AeBDiesNyOGBnv4xshWmImfWBnadz3/iErVdwt44MQzAe2WSjQtX6TQ16ZPHy+KDdi3
 8woQTo28tvj2lv/f9wqAXsFWDQpGXYVqmjLy6+dhSyUfK0mytsAuh6IVhbj4q7wu7OLrEwRndwy
 65Lqut+jxbN5e9y5kNu597lhnXBWE2Czb3BhUA+MhKiakTy8tP8vXiLvmSuZrZDs77NsDpKHu2l
 z770SpdIs2yvj8tbGEQU32OCtBGF8w5j0GKLgYL01xMixVom6pdL9EkUO1uA3Id1fGFHbeWYrMv
 ih7ZPgmisLTy0jMYolWDXTgYC3hRIbXeZxKEwOTw1iEYPav5+5P6ju+671qlU0fNkreil6kqQfW
 Oc+YRJ7I0LT2Kq8OoSwNOlQUcDajmH+00CvBv2Ku3z7H4jM4JA2e4Rj/H0gG3qCjM+vbJbD8hT6
 yVk+htR9GZtV/FL9jh3uwQvdxgj5hKl982u/EQD+ww+Y7CLwc5xojCIJJ7KePwXKFaNuYMAtfYw
 CfbOLWWDQLR7FAW9Az+BWXU
X-Received: by 2002:a17:90b:4ac5:b0:359:fdc0:4621 with SMTP id
 98e67ed59e1d1-35e42786883mr26217354a91.11.1776297891704; 
 Wed, 15 Apr 2026 17:04:51 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:31f2:aa94:4389:37f8?
 ([2401:d002:dc0f:2100:31f2:aa94:4389:37f8])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36132d0157bsm194535a91.15.2026.04.15.17.04.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 17:04:51 -0700 (PDT)
Message-ID: <a69127c0-cdff-4e1c-aeee-7f4f916be283@linaro.org>
Date: Thu, 16 Apr 2026 10:04:44 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 1/6] target/mips: Expand TRANS_DF_iv() macro for
 MSA Load/Store
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20260415202027.83008-1-philmd@linaro.org>
 <20260415202027.83008-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260415202027.83008-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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
> In order to ease the conversion of MSA Load/Store runtime
> helpers to translated code, expand the TRANS_DF_iv() macro.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/msa_translate.c | 59 ++++++++++++++++++++++++++-------
>   1 file changed, 47 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
> index 82b149922fa..2e1a769e032 100644
> --- a/target/mips/tcg/msa_translate.c
> +++ b/target/mips/tcg/msa_translate.c
> @@ -164,7 +164,6 @@ static inline bool check_msa_enabled(DisasContext *ctx)
>       return true;
>   }
>   
> -typedef void gen_helper_piv(TCGv_ptr, TCGv_i32, TCGv);
>   typedef void gen_helper_pii(TCGv_ptr, TCGv_i32, TCGv_i32);
>   typedef void gen_helper_piii(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32);
>   typedef void gen_helper_piiii(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32);
> @@ -175,9 +174,6 @@ typedef void gen_helper_piiii(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32);
>       }; \
>       TRANS(NAME, trans_func, NAME##_tab[a->df])
>   
> -#define TRANS_DF_iv(NAME, trans_func, gen_func) \
> -    TRANS_DF_x(iv, NAME, trans_func, gen_func)
> -
>   #define TRANS_DF_ii(NAME, trans_func, gen_func) \
>       TRANS_DF_x(ii, NAME, trans_func, gen_func)
>   
> @@ -758,25 +754,64 @@ TRANS(FTINT_U,  trans_msa_2rf, gen_helper_msa_ftint_u_df);
>   TRANS(FFINT_S,  trans_msa_2rf, gen_helper_msa_ffint_s_df);
>   TRANS(FFINT_U,  trans_msa_2rf, gen_helper_msa_ffint_u_df);
>   
> -static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a,
> -                           gen_helper_piv *gen_msa_ldst)
> +static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
>   {
> -    TCGv taddr;
> +    TCGv_i32 wd;
> +    TCGv_va addr;
>   
>       if (!check_msa_enabled(ctx)) {
>           return true;
>       }
>   
> -    taddr = tcg_temp_new();
> +    addr = tcgv_va_temp_new();
> +    gen_base_offset_addr(ctx, addr, a->ws, a->sa << a->df);
>   
> -    gen_base_offset_addr(ctx, taddr, a->ws, a->sa << a->df);
> -    gen_msa_ldst(tcg_env, tcg_constant_i32(a->wd), taddr);
> +    wd = tcg_constant_i32(a->wd);
> +
> +    if (is_load) {
> +        switch (a->df) {
> +        case 0:
> +            gen_helper_msa_ld_b(tcg_env, wd, addr);
> +            return true;
> +        case 1:
> +            gen_helper_msa_ld_h(tcg_env, wd, addr);
> +            return true;
> +        case 2:
> +            gen_helper_msa_ld_w(tcg_env, wd, addr);
> +            return true;
> +        case 3:
> +            gen_helper_msa_ld_d(tcg_env, wd, addr);
> +            return true;
> +        }
> +    } else {
> +        switch (a->df) {
> +        case 0:
> +            gen_helper_msa_st_b(tcg_env, wd, addr);
> +            return true;
> +        case 1:
> +            gen_helper_msa_st_h(tcg_env, wd, addr);
> +            return true;
> +        case 2:
> +            gen_helper_msa_st_w(tcg_env, wd, addr);
> +            return true;
> +        case 3:
> +            gen_helper_msa_st_d(tcg_env, wd, addr);
> +            return true;
> +        }
> +    }
>   
>       return true;
>   }
>   
> -TRANS_DF_iv(LD, trans_msa_ldst, gen_helper_msa_ld);
> -TRANS_DF_iv(ST, trans_msa_ldst, gen_helper_msa_st);
> +static bool trans_LD(DisasContext *ctx, arg_msa_i *a)
> +{
> +    return trans_msa_ldst(ctx, a, true);
> +}
> +
> +static bool trans_ST(DisasContext *ctx, arg_msa_i *a)
> +{
> +    return trans_msa_ldst(ctx, a, false);
> +}
>   
>   static bool trans_LSA(DisasContext *ctx, arg_r *a)
>   {


