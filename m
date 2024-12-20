Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77351E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 20:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOjS7-0000jC-7D; Fri, 20 Dec 2024 15:18:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOjS4-0000ig-MX
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 15:18:24 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOjS2-0006iM-VB
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 15:18:24 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ee76befe58so2087310a91.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 12:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734725901; x=1735330701; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V0yaJC9uBh8OWq4OQ3FShRSsZi6Ksuf64WfcUhs/MUw=;
 b=VbTJx6d1OavQQc0U2/JY2/+1iKbZzHsF37xLqCMB+8Xg8s8DpnASdbLoGamq7jqr1i
 Pc+SzSxdWyDxlT687cToPb8k72aSM3wiaMhzYHi2KlyZPKk1o9GqfRnp/ZbiKwLRTzgS
 5XIz0KxJTrtJhJXxflAVeStmiPudlCHnVwnohyl4JE7lS9A+kzMmJY30mCDASaMUHWnk
 Ttb8RHrjPZ7itJAjt0H+ukn7rEos8VgoDkAFSF2pr4oq5GuXP9/XSk/SyDja7kX599CJ
 3BbG6vns3rznh2tcigZoKGlZrQJ/FQwNGSKj6TlWwDVSVScjA58XSVIUWHruXvUSVmGh
 xaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734725901; x=1735330701;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V0yaJC9uBh8OWq4OQ3FShRSsZi6Ksuf64WfcUhs/MUw=;
 b=BTVGy8UskDq0LndpeN9v100zUxGYGgbu7c8kt9uMWJ+ZPaTBVSPoSpxTZ2EeAsf2bo
 1H+pa+y9e1q0GnDZKcsdqI6ij6Yv55mCSrNq57eePuVF44TdLVDXr/VtOPDh8ETFSzqi
 V7qf+v97UCrBC71BMpbxi6FQnicpAntoHIKyaQ8cpakyXOI4G4QCSJcO9t5wIhN1gwPq
 avti43K5yH8ZeEdP6rhIKQWe+FPKK0VeX6mIynG1xq8lcJuc9b9A2NHeCtlC8zaOewFB
 KS9rV02Tm+jDFfjuaY+HS7Pe8iyeUvRM6zH2mbWtuZAGvOQsMWXgpJC7nyFINhS0ZlGP
 KqAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOkRZ/UPJGcyA2bQku5u+ZMhd88EE9TM1IQH14K4LGqlERmkjagkXtap3n009z/jbhoQ5B7lPGMEk2@nongnu.org
X-Gm-Message-State: AOJu0YzPHn/a/fQ75TcYfg0lddLRfebbYnWjeH2jpzIICy2/9T2vrKaw
 uFb9QSTxUszOOBlWlkpoLElS+1NVwRZHi9Yz4FQjBxbVUit86Kx0bMjK8uzGPajY6Dk2zaxIbjQ
 U
X-Gm-Gg: ASbGncs6CbLMAmT7lvzW5mQaWuQS+RTrSvpUCZFE5XQyp2iuqkYSrcq3EopgPbGpDBQ
 6VoJURagzSNAOrFnIWwD+utNJ9pesxqfKbh+fgeiJbAi+ZsE7NQcOILykxBgxY91vYlijN091b2
 6z2fbuvdK1j/f3c7aMyvnbYRd114g8/SUAbAh5SZEXkh3qop0HyM5KEyfPBFXDdB0bHwDPzkHdZ
 yVUCxrIDzoWwG4q0tpoflqrNKhVCKnDZkV0pFs6+c406aGrx0hOpTO1PPdVr7TMAxnbmg==
X-Google-Smtp-Source: AGHT+IFxJOxwbUBa3QVW1tFH7iVn1ZsFrdhAGmuTko9f/BxV4nDJfgHlRhZLlsPFWEhLb2q6btBi2g==
X-Received: by 2002:a17:90a:c88e:b0:2ee:8427:4b02 with SMTP id
 98e67ed59e1d1-2f452ee630emr6097468a91.28.1734725901538; 
 Fri, 20 Dec 2024 12:18:21 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f44779990csm3756937a91.6.2024.12.20.12.18.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 12:18:21 -0800 (PST)
Message-ID: <9874054a-a3b0-4333-ad65-c0f7c41c974f@linaro.org>
Date: Fri, 20 Dec 2024 12:18:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/51] tcg/optimize: Use fold_masks_zs in fold_qemu_ld
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241220041104.53105-1-richard.henderson@linaro.org>
 <20241220041104.53105-30-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241220041104.53105-30-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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
> Avoid the use of the OptContext slots.
> 
> Be careful not to call fold_masks_zs when the memory operation
> is wide enough to require multiple outputs, so split into two
> functions: fold_qemu_ld_1reg and fold_qemu_ld_2reg.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 28 ++++++++++++++++++++++------
>   1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index da9c8c4669..b01929fccf 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -2127,24 +2127,33 @@ static bool fold_orc(OptContext *ctx, TCGOp *op)
>       return fold_masks_s(ctx, op, s_mask);
>   }
>   
> -static bool fold_qemu_ld(OptContext *ctx, TCGOp *op)
> +static bool fold_qemu_ld_1reg(OptContext *ctx, TCGOp *op)
>   {
>       const TCGOpDef *def = &tcg_op_defs[op->opc];
>       MemOpIdx oi = op->args[def->nb_oargs + def->nb_iargs];
>       MemOp mop = get_memop(oi);
>       int width = 8 * memop_size(mop);
> +    uint64_t z_mask = -1, s_mask = 0;
>   
>       if (width < 64) {
> -        ctx->s_mask = MAKE_64BIT_MASK(width, 64 - width);
> +        s_mask = MAKE_64BIT_MASK(width, 64 - width);
>           if (!(mop & MO_SIGN)) {
> -            ctx->z_mask = MAKE_64BIT_MASK(0, width);
> -            ctx->s_mask <<= 1;
> +            z_mask = MAKE_64BIT_MASK(0, width);
> +            s_mask <<= 1;
>           }
>       }
>   
>       /* Opcodes that touch guest memory stop the mb optimization.  */
>       ctx->prev_mb = NULL;
> -    return false;
> +
> +    return fold_masks_zs(ctx, op, z_mask, s_mask);
> +}
> +
> +static bool fold_qemu_ld_2reg(OptContext *ctx, TCGOp *op)
> +{
> +    /* Opcodes that touch guest memory stop the mb optimization.  */
> +    ctx->prev_mb = NULL;
> +    return finish_folding(ctx, op);
>   }
>   
>   static bool fold_qemu_st(OptContext *ctx, TCGOp *op)
> @@ -3033,11 +3042,18 @@ void tcg_optimize(TCGContext *s)
>               break;
>           case INDEX_op_qemu_ld_a32_i32:
>           case INDEX_op_qemu_ld_a64_i32:
> +            done = fold_qemu_ld_1reg(&ctx, op);
> +            break;
>           case INDEX_op_qemu_ld_a32_i64:
>           case INDEX_op_qemu_ld_a64_i64:
> +            if (TCG_TARGET_REG_BITS == 64) {
> +                done = fold_qemu_ld_1reg(&ctx, op);
> +                break;
> +            }
> +            QEMU_FALLTHROUGH;
>           case INDEX_op_qemu_ld_a32_i128:
>           case INDEX_op_qemu_ld_a64_i128:
> -            done = fold_qemu_ld(&ctx, op);
> +            done = fold_qemu_ld_2reg(&ctx, op);
>               break;
>           case INDEX_op_qemu_st8_a32_i32:
>           case INDEX_op_qemu_st8_a64_i32:

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


