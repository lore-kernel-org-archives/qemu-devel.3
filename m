Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67F3E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 20:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOjPf-000748-8k; Fri, 20 Dec 2024 15:15:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOjPY-0006sT-Od
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 15:15:48 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOjPX-0003Pk-4P
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 15:15:48 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-728eccf836bso2137492b3a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 12:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734725745; x=1735330545; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O03I3NcTnjTa890wll0TJF7OSPLZYRhefMaNEGbGbcc=;
 b=Vit+dnTej5dDiCA7lWhdpJf2+h+/KxxFCqarqyp4wF97OtaZcDW/1KdTFl/GHupMKk
 RBcce+FdWfajGck1KtuKPauW76CCYVeRaA+ExIE0/2e1ssAK4Yk530bnh13Gp1rUVN92
 2ksVPEICAAa7LMNHsT7fXVgm9MXBJYO8BUz7mVwLAdj0Ly2CVw7/upol/ZR0yz83B5kF
 l6c6yWRNKqdYXEp+nX8NllYlIRZgV4Z+NoJG8MP3imxTpgjwWOc/IYfriEfiU6dgIlfw
 PCP4IyBPPD3sj25soXVawbzLUFe4arDtZ73Lh1RyWinRpRaoM55Xj0Fjc4M6HOjKEKlB
 rQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734725745; x=1735330545;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O03I3NcTnjTa890wll0TJF7OSPLZYRhefMaNEGbGbcc=;
 b=RKWKqdDIR/fmUZr+MgVgtlu0p+RCyBOXZ5HN8qHlGh/A4e5cCwlQDeJ9xniOWWB1CP
 xrr01VFOQMcILlgKmYwuD7qiG0wi4gh1XkIXIcdfY7JK8B4ZoOKtoGuqc9BSsLeKxGbZ
 4u69y5BeQ2I/Rq3EQ3++WcbzxOnQOLm8vfA4Y9fjTfWhq8gsu8MwOG9v8y7z3f+CTGbH
 3i0xN23R8FKewG1R2b6l8Pk7q4g9c9ykVqLspOVb/bzCl6zl5yk1H7yd0m6o+ee4l5hg
 351eKOC3uTFGlq38FLpbGaVMGQqTW2eKUz3eOUBPQO/SOIUmxnCFq3OCGoO963hqmFH0
 7NNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzJBMfN0/dF7uftyc62uzB83J4lHuJYw6ucKjT9LYGvCFTU/iiRX5DlNAGzd+pn6AjY4dHeyq9ynVE@nongnu.org
X-Gm-Message-State: AOJu0Yw+wRVu1NSe9xI/ae2Rx4won0NP9ctZMZa8rbxAYNyMT6xx3E8g
 vvT1Q5P+YgVRpGvZ7FKQ4sH1+kEzO6FQZhQOpBmW9NNy34nG11FhQSWhs2DPLk0=
X-Gm-Gg: ASbGncvkFz3T/Wt/P8JwlQtBQlyamsoMOq+l5zNSj6nCGY7u+46WxEsNPOFvufDdYjK
 LfsxIFLYnuxizinHZFgAimo/8Hk7ajlE3uTXVYGlC5avULGBVupphZQ/K+uz2zbnaOnEjPhSL9N
 WSLtxOqhuoKq+5BM4qpJyDlL7ZtIZbxRfActg7EzszF4pqRtZdKwYj6Oci08xyAvClXtbTHK3i9
 9yJ5lV3aqWwpQjAR1OXyZLrFO0fiai7T9YIVok4LPxd46fNUQ14kG+z36w4S608he9r4A==
X-Google-Smtp-Source: AGHT+IHXSK6P6UfSsUqSbSQi8EgZyTkinZsy5/2M3T8upzs0L8Y5VNRxB3PYV4Z4Idtr+NynJKISTg==
X-Received: by 2002:a05:6a00:2181:b0:729:49a:2db0 with SMTP id
 d2e1a72fcca58-72abdebf27cmr5435439b3a.25.1734725745519; 
 Fri, 20 Dec 2024 12:15:45 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842bdfb5759sm2800931a12.51.2024.12.20.12.15.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 12:15:45 -0800 (PST)
Message-ID: <a037d34e-5a1b-41b6-9a81-e93302cc2cc8@linaro.org>
Date: Fri, 20 Dec 2024 12:15:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/51] tcg/optimize: Augment s_mask from z_mask in
 fold_masks_zs
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241220041104.53105-1-richard.henderson@linaro.org>
 <20241220041104.53105-6-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241220041104.53105-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

On 12/19/24 20:10, Richard Henderson wrote:
> Consider the passed s_mask to be a minimum deduced from
> either existing s_mask or from a sign-extension operation.
> We may be able to deduce more from the set of known zeros.
> Remove identical logic from several opcode folders.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index d70127b88d..17b72fe759 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1048,6 +1048,7 @@ static bool fold_const2_commutative(OptContext *ctx, TCGOp *op)
>    * Record "zero" and "sign" masks for the single output of @op.
>    * See TempOptInfo definition of z_mask and s_mask.
>    * If z_mask allows, fold the output to constant zero.
> + * The passed s_mask may be augmented by z_mask.
>    */
>   static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
>                             uint64_t z_mask, uint64_t s_mask)
> @@ -1080,7 +1081,7 @@ static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
>   
>       ti = ts_info(ts);
>       ti->z_mask = z_mask;
> -    ti->s_mask = s_mask;
> +    ti->s_mask = s_mask | smask_from_zmask(z_mask);
>       return true;
>   }
>   
> @@ -1519,8 +1520,8 @@ static bool fold_bswap(OptContext *ctx, TCGOp *op)
>       default:
>           g_assert_not_reached();
>       }
> -    s_mask = smask_from_zmask(z_mask);
>   
> +    s_mask = 0;
>       switch (op->args[2] & (TCG_BSWAP_OZ | TCG_BSWAP_OS)) {
>       case TCG_BSWAP_OZ:
>           break;
> @@ -1534,7 +1535,6 @@ static bool fold_bswap(OptContext *ctx, TCGOp *op)
>       default:
>           /* The high bits are undefined: force all bits above the sign to 1. */
>           z_mask |= sign << 1;
> -        s_mask = 0;
>           break;
>       }
>       ctx->z_mask = z_mask;
> @@ -1605,7 +1605,6 @@ static bool fold_count_zeros(OptContext *ctx, TCGOp *op)
>           g_assert_not_reached();
>       }
>       ctx->z_mask = arg_info(op->args[2])->z_mask | z_mask;
> -    ctx->s_mask = smask_from_zmask(ctx->z_mask);
>       return false;
>   }
>   
> @@ -1625,7 +1624,6 @@ static bool fold_ctpop(OptContext *ctx, TCGOp *op)
>       default:
>           g_assert_not_reached();
>       }
> -    ctx->s_mask = smask_from_zmask(ctx->z_mask);
>       return false;
>   }
>   
> @@ -1746,7 +1744,6 @@ static bool fold_extract(OptContext *ctx, TCGOp *op)
>           return true;
>       }
>       ctx->z_mask = z_mask;
> -    ctx->s_mask = smask_from_zmask(z_mask);
>   
>       return fold_masks(ctx, op);
>   }
> @@ -1851,7 +1848,6 @@ static bool fold_extu(OptContext *ctx, TCGOp *op)
>       }
>   
>       ctx->z_mask = z_mask;
> -    ctx->s_mask = smask_from_zmask(z_mask);
>       if (!type_change && fold_affected_mask(ctx, op, z_mask_old ^ z_mask)) {
>           return true;
>       }
> @@ -2354,7 +2350,6 @@ static bool fold_setcond(OptContext *ctx, TCGOp *op)
>       fold_setcond_tst_pow2(ctx, op, false);
>   
>       ctx->z_mask = 1;
> -    ctx->s_mask = smask_from_zmask(1);
>       return false;
>   }
>   
> @@ -2455,7 +2450,6 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *op)
>       }
>   
>       ctx->z_mask = 1;
> -    ctx->s_mask = smask_from_zmask(1);
>       return false;
>   
>    do_setcond_const:

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


