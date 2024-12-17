Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E193FE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNeTR-0007w7-VG; Tue, 17 Dec 2024 15:47:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeTO-0007tO-94
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:47:18 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeTL-0004fM-OO
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:47:17 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2efe25558ddso4145564a91.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734468433; x=1735073233; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IRi9zZXErzaBzStDajT7S2Pj1D8bsuy/CvSkPEcHUIA=;
 b=kaxUVgls2KoFG5FjAzuF3PRSeFlFjzQzCyqQW7OXZTTSff8amOnM3yjCxAzRE+s1Cr
 21wJy9PhiUr+j7Eps0hmV2TmVlALaL0L0p7cah8T1RQBspsdXCnsM/m2ECfDGsKXeYWk
 TrrvcuN29dAoqLtbSLeazNzn/NVuEEIb+p8MFCTO/ul2Wl/3rzfrEn84y50wRRQj0MlS
 VLcnjeamSffaedSHon0NgW2RQAdEd+jsn7mnejI53IyqUEgRyZtVIo7pIZ70B6JIjJqO
 euPgCzSgESNW7y6MhJjvz/jI+WGFj8NVwq+8fx6vhuGjutzDeQqdK2nojBdKuzABgJ5h
 yFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734468433; x=1735073233;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IRi9zZXErzaBzStDajT7S2Pj1D8bsuy/CvSkPEcHUIA=;
 b=mTeBCAfvCNFmKYDl9+QmtFR/YbGvix0gONpt1DMiuRNRdI+IRahnw6s97eD/wJdYZ3
 QvvdaB0S8vDXrll9iu/V5f8GSeVMoHNFCGjYUV9TWmkKqtcmS9rz71FautbuFccCRXib
 IVE06p67hB5EBlQn4eGyDm8eBjXhITlJXc7QFFf38NCt8Ivz8ODhi8GW1uTkTKpumXNK
 cV4vp1pAUzObEsek5up1UL+2SPkXVZbz7eUCnkSmaGEP2vo56IsUmCGjRlDDXVIClGAY
 dQ7dBU1YjOC32gFD3+2uTBA5vtBwSxoTj+8nrt3S8XfpcG+I2yE7AHfQsJ/ix1g50qmJ
 M0lQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmWaf4RS1yhDZhL7AlJIdjyVLgcUFGIIZc9gc52v5Xv2B4YkTIXCzsyClR8WmMTLG2Euy9j/IBl9iA@nongnu.org
X-Gm-Message-State: AOJu0YwOqJL7Bso+H6LsAckjrW3qvPguX8VasL9oGqzE8crpqwagJquA
 gIi9whDl0cKx5HKcxzxrRLZ58jNxAp4l0+wRWHNCTwdx4JWEs3ADkFZlU9EYED0=
X-Gm-Gg: ASbGncuPoeKCQbFr4PZLnJ3p6ZNkj1czp6amc+WiJUw4bD8DyfVoCXGuX4x11obOSCH
 rdJSqaOk4tdIPKLm0u34DTbw4ZU4T7P18bwVqS3ApzK1a+Dv2kIg0Pl/EaLUxKmVi3JUj150Usf
 cvkCL9K2F17ejHA4rc1b8UX7mQOTvh+Hi09Ull5zorM9Ynrbv7otKaN5hOlaxbe3t7WHuUNVx88
 kYN8YqXpOPUCBJ/Ws76//SVWAm1csMvnAqhxU8GNkg2toJFB0+UZQnd3N465N2szfKESA==
X-Google-Smtp-Source: AGHT+IEh6i0y6hduZsel8lIXI1CgQnL5MwkPgE4w86/XUbsv524it1s9W3VS1VbbGNpa7MoMyHWrLg==
X-Received: by 2002:a17:90a:c2c6:b0:2ee:7698:e565 with SMTP id
 98e67ed59e1d1-2f2e91c4e80mr458662a91.8.1734468433634; 
 Tue, 17 Dec 2024 12:47:13 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2a1e9de2esm7044131a91.18.2024.12.17.12.47.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:47:13 -0800 (PST)
Message-ID: <f746b3a9-42fc-4373-bc69-2448491d21c7@linaro.org>
Date: Tue, 17 Dec 2024 12:47:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 46/46] tcg/optimize: Move fold_cmp_vec, fold_cmpsel_vec
 into alphabetic sort
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-47-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-47-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

On 12/10/24 07:24, Richard Henderson wrote:
> The big comment just above says functions should be sorted.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 60 +++++++++++++++++++++++++-------------------------
>   1 file changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 54082042aa..2c5691e3c9 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1610,6 +1610,36 @@ static bool fold_call(OptContext *ctx, TCGOp *op)
>       return true;
>   }
>   
> +static bool fold_cmp_vec(OptContext *ctx, TCGOp *op)
> +{
> +    /* Canonicalize the comparison to put immediate second. */
> +    if (swap_commutative(NO_DEST, &op->args[1], &op->args[2])) {
> +        op->args[3] = tcg_swap_cond(op->args[3]);
> +    }
> +    return finish_folding(ctx, op);
> +}
> +
> +static bool fold_cmpsel_vec(OptContext *ctx, TCGOp *op)
> +{
> +    /* If true and false values are the same, eliminate the cmp. */
> +    if (args_are_copies(op->args[3], op->args[4])) {
> +        return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[3]);
> +    }
> +
> +    /* Canonicalize the comparison to put immediate second. */
> +    if (swap_commutative(NO_DEST, &op->args[1], &op->args[2])) {
> +        op->args[5] = tcg_swap_cond(op->args[5]);
> +    }
> +    /*
> +     * Canonicalize the "false" input reg to match the destination,
> +     * so that the tcg backend can implement "move if true".
> +     */
> +    if (swap_commutative(op->args[0], &op->args[4], &op->args[3])) {
> +        op->args[5] = tcg_invert_cond(op->args[5]);
> +    }
> +    return finish_folding(ctx, op);
> +}
> +
>   static bool fold_count_zeros(OptContext *ctx, TCGOp *op)
>   {
>       uint64_t z_mask;
> @@ -2499,36 +2529,6 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *op)
>       return tcg_opt_gen_movi(ctx, op, op->args[0], i);
>   }
>   
> -static bool fold_cmp_vec(OptContext *ctx, TCGOp *op)
> -{
> -    /* Canonicalize the comparison to put immediate second. */
> -    if (swap_commutative(NO_DEST, &op->args[1], &op->args[2])) {
> -        op->args[3] = tcg_swap_cond(op->args[3]);
> -    }
> -    return finish_folding(ctx, op);
> -}
> -
> -static bool fold_cmpsel_vec(OptContext *ctx, TCGOp *op)
> -{
> -    /* If true and false values are the same, eliminate the cmp. */
> -    if (args_are_copies(op->args[3], op->args[4])) {
> -        return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[3]);
> -    }
> -
> -    /* Canonicalize the comparison to put immediate second. */
> -    if (swap_commutative(NO_DEST, &op->args[1], &op->args[2])) {
> -        op->args[5] = tcg_swap_cond(op->args[5]);
> -    }
> -    /*
> -     * Canonicalize the "false" input reg to match the destination,
> -     * so that the tcg backend can implement "move if true".
> -     */
> -    if (swap_commutative(op->args[0], &op->args[4], &op->args[3])) {
> -        op->args[5] = tcg_invert_cond(op->args[5]);
> -    }
> -    return finish_folding(ctx, op);
> -}
> -
>   static bool fold_sextract(OptContext *ctx, TCGOp *op)
>   {
>       uint64_t z_mask, s_mask, s_mask_old, a_mask = -1;

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


