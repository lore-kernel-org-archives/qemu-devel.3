Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D896E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNeLO-0005ab-GY; Tue, 17 Dec 2024 15:39:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeLM-0005a8-Qz
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:39:00 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeLL-0003Ev-3P
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:39:00 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-725ef0397aeso5161519b3a.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734467937; x=1735072737; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3XH1OWEWp+nKRAtFzBFtmEI9B4jRKLKqvpoWilU/o8c=;
 b=TW8LhIXNIoozjD1IlHlAolyuPvJ2tehVmD76FCijpN38rkfMY6LX2VpUYmjb0KjGmc
 OaTKFGKyVlSvBBhr60S+cB+unN61Zk6SlLlSMqYy+0IIIjOsyNb1k0tZzjdoslO4o5D9
 rMOmDkk07hFuLiJn5ofnmWOhFBbViPcCsOhCnFClL8sFpXvM68aH6Gv6aKKdrsf0lIVn
 mTUWubXRI0cgjQD/gVwP0mYGa14XgQcCQinni+p5+l3K1LAo32ct+5E+AV6647nTOo6h
 z6EIL5qKFZjbsbInPd4aohXjDDucuXpkygElSRtDqyas11nbImdeKzH/PeJS4OVxDdAy
 D+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734467937; x=1735072737;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3XH1OWEWp+nKRAtFzBFtmEI9B4jRKLKqvpoWilU/o8c=;
 b=nM4KMfIiwhI3bYHPhgRG3nWw4mYlzIZXNXnmxQjahxHYUB7TsXgHyJ4PtE+A24u7TW
 kIfQ0yQxNdNP+Y0dQEcBRAe0O27zuoe12e8Lq2vAkKtVGL2MzEP75cpTdW68v5syVBos
 vMeXJxySwljetUe+yuaNM2c/L0JEgmd8t361NtGve3iPEuDZob8hZPAp9Q5zRphKhsvG
 VwfRV3Wox6+Rl7S4JmbU/+eBZ2cTa3Zw7YKdKc81Vq4s8tgGMyMKHPM50CpHc/MMcWfd
 MM7+tTbUauAnCeUF5X4MkJND+Z46YpnN3Fdu0VfBlGMYacs+5T1prJZUCGqxZ6fhIu3z
 Rakw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVC+5qRO/VE66H7jY2AZitqAZne9fTmngQIixcbcxJQp7sLudVR9mnHpPekz37v6lAuE/QOIsBHmjFE@nongnu.org
X-Gm-Message-State: AOJu0YyXtUbvNfYG7XC7aJo29SB+itXiMztDegngW9Xh0J1lC46iuuq0
 bEvAVs3pWxsy70zWvd6hFusEoR3kxICfEfaSdpYcXBLzlwU2vfa3DHnDlk/Y/hk=
X-Gm-Gg: ASbGncs55pHWu01TD6cj6qBsz3R7A+BjNRfTldYhiIPJkeCWLh4mxwtDWz3VQ+iWXYH
 0OMSbZgUiJhyqFovMg/vwcE0WO7g2bTtJpeK6C0U9BrTY89/m4GixL1h8RUYJg7choDgvt0+Kj1
 S5u5ZNbZM/t47tAoaJc14mWp+998usBdEg3CbDX00JQ6+zq6+SkzABOd9zV1Nvt+GXgMsjAVfR5
 0yQzxI2kuN8VoQRmlH/KBE7QR+Ar7KZUzsXODtNOtTM/7Obk48cabYK2FZhKF1JeMryBg==
X-Google-Smtp-Source: AGHT+IFN8DpaRdQG/0dYAEpEW5Iod7swGCF80GvDrXjrvsDpZhwpixvjqvxDr/C9veygMjMAza4i7A==
X-Received: by 2002:a17:90b:4d0e:b0:2ee:741c:e9f4 with SMTP id
 98e67ed59e1d1-2f2e91efb96mr392569a91.11.1734467937014; 
 Tue, 17 Dec 2024 12:38:57 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142daeb5asm10534038a91.12.2024.12.17.12.38.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:38:56 -0800 (PST)
Message-ID: <9af9d748-8582-4069-a284-e23cf6a0ed1b@linaro.org>
Date: Tue, 17 Dec 2024 12:38:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/46] tcg/optimize: Distinguish simplification in
 fold_setcond_zmask
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-31-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-31-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 12/10/24 07:23, Richard Henderson wrote:
> Change return from bool to int; distinguish between
> complete folding, simplification, and no change.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 22 ++++++++++++++--------
>   1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index eac5ef5eec..7b1d437c27 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -2137,7 +2137,8 @@ static bool fold_remainder(OptContext *ctx, TCGOp *op)
>       return finish_folding(ctx, op);
>   }
>   
> -static bool fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
> +/* Return 1 if finished, -1 if simplified, 0 if unchanged. */
> +static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
>   {
>       uint64_t a_zmask, b_val;
>       TCGCond cond;
> @@ -2232,11 +2233,10 @@ static bool fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
>                   op->opc = xor_opc;
>                   op->args[2] = arg_new_constant(ctx, 1);
>               }
> -            return false;
> +            return -1;
>           }
>       }
> -
> -    return false;
> +    return 0;
>   }
>   
>   static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
> @@ -2341,10 +2341,13 @@ static bool fold_setcond(OptContext *ctx, TCGOp *op)
>           return tcg_opt_gen_movi(ctx, op, op->args[0], i);
>       }
>   
> -    if (fold_setcond_zmask(ctx, op, false)) {
> +    i = fold_setcond_zmask(ctx, op, false);
> +    if (i > 0) {
>           return true;
>       }
> -    fold_setcond_tst_pow2(ctx, op, false);
> +    if (i == 0) {
> +        fold_setcond_tst_pow2(ctx, op, false);
> +    }
>   
>       ctx->z_mask = 1;
>       ctx->s_mask = smask_from_zmask(1);
> @@ -2359,10 +2362,13 @@ static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
>           return tcg_opt_gen_movi(ctx, op, op->args[0], -i);
>       }
>   
> -    if (fold_setcond_zmask(ctx, op, true)) {
> +    i = fold_setcond_zmask(ctx, op, true);
> +    if (i > 0) {
>           return true;
>       }
> -    fold_setcond_tst_pow2(ctx, op, true);
> +    if (i == 0) {
> +        fold_setcond_tst_pow2(ctx, op, true);
> +    }
>   
>       /* Value is {0,-1} so all bits are repetitions of the sign. */
>       ctx->s_mask = -1;

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


