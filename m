Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB3CE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:21:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNe3Q-000719-9p; Tue, 17 Dec 2024 15:20:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNe3M-0006zJ-PW
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:20:25 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNe3L-0000WL-5j
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:20:24 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-725ed193c9eso4931354b3a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734466820; x=1735071620; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hGyixLQjYKjel2arhdacgKE/uEsn91EPEXBEXQGY9Ak=;
 b=uHO/SOZ4cdmC039vd6JLWzuBM19TW2Kx3GRqh6wpvhceGYdhiwdr4ZcP1Qohfv4tTJ
 bPSAI9A14AFRUjYAYMxW0MLWOVUl0LRvjwhCMbuMmFTCHeODj3dXdYLq5yeh/C3itrtH
 OM1N47dWXysP0fD65cJ04fRmThP2OdoAiK5yg6z0RJTteNbXxyVqTpzGBIhHN9pIVw/S
 b3UeTMAfZn9dqwhFFx7fXM35cPCALoGwQdd1y5b5p5pUjDgnc/laXwAFLie2Het54m0D
 J9tG8U4U06uzQu5y/McjvTsrGiaC0BE1YXJ7BYQ8QYOtBft49T12I6eZD/kzVpHALyqz
 1cUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734466820; x=1735071620;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hGyixLQjYKjel2arhdacgKE/uEsn91EPEXBEXQGY9Ak=;
 b=VswPlQDKKzBEZqiKVdk99UMQOhZAB+vHaMLwEsEsp+AHNAuYwD8aT+QhgirOY/BEg/
 FjTV+ibQdyg5ZPLjb11B8Mtq/rJHq2K03XBFvFpPJfz5FbCCjExKXUiBVY1i/bb8vba4
 Eyl6/qUKZW0iuvveSlTTGF04oJqbfwXHXA2D5bNxw6kGhs3Vi+PPFVwSQ8ATKWpJaZt7
 6cYFASJ8O/hkOWRR9P4dHEYkvVZqva7KpYw7twX488UYiEstGW9y512crZIOuvUW1VYO
 ET8NLPMXDnl2TLUEckvAGk/MwdzHu3G1RvYHYMqUUlG5/S/+3bkSL8uXXAOw3cM+DLF8
 /5Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmOwf8NEGOaV3xULNeIThFBI4V4VjMmJG+1km1Nd6ftGRZYYfOCR6HM/N+tSpkPC7x5aaRHL1sUWeF@nongnu.org
X-Gm-Message-State: AOJu0YwP7w7jeOdrxwrbDro9jnymrE47ati1xusjMucyW9AVro+N/VHu
 mHpskZXaMbhTy1SqHxz7uQdRRap50jYgyvPTi/6DSxicFUe0icChcrae6gKGyeQJPFcPT4T6vrC
 kyLeIHQ==
X-Gm-Gg: ASbGncvD1MzEY55IXP/l7X+KEaeLdMiakoFRjwSgrJc1JvW2Mi95+xzT5urB9c1kuMn
 PHEAaARo+Q/bpQayLdo7JC640ettYpjvnJMVIOh1++Ly5BJIRaJFjWKaGr2SP6CeBOegKfYk59a
 hK+akv4F+0FM/rmFDtfKzEoFjqYGyR8aElBRyM2wAnmg5em82qk5YOXj0pCyFrBlMPIT7bnCjZz
 OnrU1OHabw0Gndf3jGGqojrqYSf5peP7fk03rGuLaxbyTSaVfoETMjnufJfvMBuC/D7nw==
X-Google-Smtp-Source: AGHT+IFlB0A/zaah0K0nOeZnfyg+fFGuxQ5KsOOEOjaqWHajFKia3bb7gcjKq1e0UpiCM8ptA+VZ3Q==
X-Received: by 2002:a05:6a00:35c3:b0:725:a78c:6c31 with SMTP id
 d2e1a72fcca58-72a8d01d987mr537163b3a.3.1734466820550; 
 Tue, 17 Dec 2024 12:20:20 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918bcdb8dsm7082089b3a.179.2024.12.17.12.20.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:20:20 -0800 (PST)
Message-ID: <df53d1cf-3608-4e86-8378-1def16e91821@linaro.org>
Date: Tue, 17 Dec 2024 12:20:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/46] tcg/optimize: Use fold_and and fold_masks_z in
 fold_deposit
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-12-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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
> When we fold to and, use fold_and, which sets s_mask
> and a_mask more intelligently than we do for the
> rest of deposit.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 424ed7674d..4d5fa04199 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1620,6 +1620,7 @@ static bool fold_ctpop(OptContext *ctx, TCGOp *op)
>   static bool fold_deposit(OptContext *ctx, TCGOp *op)
>   {
>       TCGOpcode and_opc;
> +    uint64_t z_mask;
>   
>       if (arg_is_const(op->args[1]) && arg_is_const(op->args[2])) {
>           uint64_t t1 = arg_info(op->args[1])->val;
> @@ -1647,8 +1648,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
>           op->opc = and_opc;
>           op->args[1] = op->args[2];
>           op->args[2] = arg_new_constant(ctx, mask);
> -        ctx->z_mask = mask & arg_info(op->args[1])->z_mask;
> -        return false;
> +        return fold_and(ctx, op);
>       }
>   
>       /* Inserting zero into a value. */
> @@ -1657,14 +1657,12 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
>   
>           op->opc = and_opc;
>           op->args[2] = arg_new_constant(ctx, mask);
> -        ctx->z_mask = mask & arg_info(op->args[1])->z_mask;
> -        return false;
> +        return fold_and(ctx, op);
>       }
>   
> -    ctx->z_mask = deposit64(arg_info(op->args[1])->z_mask,
> -                            op->args[3], op->args[4],
> -                            arg_info(op->args[2])->z_mask);
> -    return false;
> +    z_mask = deposit64(arg_info(op->args[1])->z_mask, op->args[3], op->args[4],
> +                       arg_info(op->args[2])->z_mask);
> +    return fold_masks_z(ctx, op, z_mask);
>   }
>   
>   static bool fold_divide(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


