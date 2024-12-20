Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D3FE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 20:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOjNN-0005cb-NY; Fri, 20 Dec 2024 15:13:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOjNM-0005Ye-Bq
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 15:13:32 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOjNK-0002d0-FY
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 15:13:32 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so31464075ad.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 12:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734725608; x=1735330408; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6aejyeDMQjA9dIyaLbpr9u4alAu4C0PMsPGJ6+vNgCw=;
 b=awtuxH87s9vwqY6HWapCYaC8GMu0zRIfZPI2JCQePRGBEWUyO71uDy5E5WDTrO+gwZ
 QKT8qUDarywv3MMrXfT0c1W03XVuLwJK76PUyJs4JikUUfh9R1EGFaw78riKfQcIgk3b
 QKuKXbjK2Y5oBTXmq8Cw1ixA/mQQdcYiLDQAmFWbXxJgdSXsTeY8Ak+i2xYCphhuXymB
 POiL8nT747DqyzVEeobKlSHs5xQkB4/EC4R3TT18fQ30Y+vwBwdiHnR97Iu7r13/198G
 CdnAIwzrOIXm9ooLScyFKlzCSm9aVnohfC7aE7ZOIiaJuOHHn0tk10cplZJQBc3I7+61
 nXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734725608; x=1735330408;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6aejyeDMQjA9dIyaLbpr9u4alAu4C0PMsPGJ6+vNgCw=;
 b=e1xlyjbV9zVI9mHa8Dpk6Fyj+y0+GsBHKkvSlj4gpufGk8PPtHBBBX7vzX4ZOKDESF
 pZGxmvDFBuJ6mSJVvHV/ub6vARoTIzi3ha58HZSAJ3jLIl8mOeNGA+aZgCfs+Ev3Op9b
 d3OSj1cWg/hE7F/XOkzoM8z+0UB+hSz213F64SaqfB3Oq7+6YMm0d+hESlarvZMUV5EK
 uz5k1xz3/7y9sr5HtMq/Voyf/rnNrw/JIQ5U7zZDYZLHbraJIzA9grdj1XoH+lJadwKR
 mGaDFd/GlaRnBtNjXl5LUf34iPUPdK8xhIQD9e2oh1YCzI5l7QwVc32ILxa9gMElcEbn
 jb5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcnCY/LWKitvB/jNqNoYnflufo09oyZ18kUlWB6+mLQ2WmvW9aBnwqD3zNc/Q0YiW+FqhaJXcXY0ic@nongnu.org
X-Gm-Message-State: AOJu0YzcBlO6tjObUefPNx3PRLzIEiGFCVdjfDC1gJs+ciSMtaTYLK94
 Wdcw+Pm1P2ZmlWJ4FbC1/nndpT6FyALFgFOVL+5iSD6I8KNVXCIbLANZ39ieROAgZWc9dDQIkXJ
 E
X-Gm-Gg: ASbGncu34CI6FI5nd1KVybIhfRhwmIXN1ybLuI7UYviNH/aCc01bbWqD3PHaYd/pPzC
 4OuN78VvtQWh6uJ8Cqe76z188ngb+tsrn4QyuCJ4RCO2KA85p5rD5zkok8Hh4VD1F5MvV6nS/Oa
 XLojgTmvo/t2IBveuToX3OnQCz62+NJxKS7JIbKa97rNmZ+E1Cwjdkpcqpd9b5pRc5Tmael9VMh
 MYyJyww/P+E0aGFuXfG44VSLAXqo8+Vx+jFJhogymK8QX7RYfChGcUZIZIpwxpmkJ1UjQ==
X-Google-Smtp-Source: AGHT+IExr5hzGUy7eLab8wVcgv4Jz2RYgEx3FD8ToqTk36Ht6FK9WNbal1ktlTk/CK39ak4+iJNqRw==
X-Received: by 2002:a17:902:e746:b0:215:a303:24e9 with SMTP id
 d9443c01a7336-219e6ca6c2fmr56591695ad.3.1734725608566; 
 Fri, 20 Dec 2024 12:13:28 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9d9481sm32856875ad.135.2024.12.20.12.13.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 12:13:28 -0800 (PST)
Message-ID: <67f4c06a-42ab-4461-b587-c610669b4b6a@linaro.org>
Date: Fri, 20 Dec 2024 12:13:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/51] tcg/optimize: Split out fold_affected_mask
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241220041104.53105-1-richard.henderson@linaro.org>
 <20241220041104.53105-3-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241220041104.53105-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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
> There are only a few logical operations which can compute
> an "affected" mask.  Split out handling of this optimization
> to a separate function, only to be called when applicable.
> 
> Remove the a_mask field from OptContext, as the mask is
> no longer stored anywhere.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 42 +++++++++++++++++++++++++++---------------
>   1 file changed, 27 insertions(+), 15 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 453e8c43bd..6757fe0036 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -64,7 +64,6 @@ typedef struct OptContext {
>       QSIMPLEQ_HEAD(, MemCopyInfo) mem_free;
>   
>       /* In flight values from optimization. */
> -    uint64_t a_mask;  /* mask bit is 0 iff value identical to first input */
>       uint64_t z_mask;  /* mask bit is 0 iff value bit is 0 */
>       uint64_t s_mask;  /* mask of clrsb(value) bits */
>       TCGType type;
> @@ -1047,7 +1046,6 @@ static bool fold_const2_commutative(OptContext *ctx, TCGOp *op)
>   
>   static bool fold_masks(OptContext *ctx, TCGOp *op)
>   {
> -    uint64_t a_mask = ctx->a_mask;
>       uint64_t z_mask = ctx->z_mask;
>       uint64_t s_mask = ctx->s_mask;
>   
> @@ -1059,7 +1057,6 @@ static bool fold_masks(OptContext *ctx, TCGOp *op)
>        * type changing opcodes.
>        */
>       if (ctx->type == TCG_TYPE_I32) {
> -        a_mask = (int32_t)a_mask;
>           z_mask = (int32_t)z_mask;
>           s_mask |= MAKE_64BIT_MASK(32, 32);
>           ctx->z_mask = z_mask;
> @@ -1069,6 +1066,19 @@ static bool fold_masks(OptContext *ctx, TCGOp *op)
>       if (z_mask == 0) {
>           return tcg_opt_gen_movi(ctx, op, op->args[0], 0);
>       }
> +    return false;
> +}
> +
> +/*
> + * An "affected" mask bit is 0 if and only if the result is identical
> + * to the first input.  Thus if the entire mask is 0, the operation
> + * is equivalent to a copy.
> + */
> +static bool fold_affected_mask(OptContext *ctx, TCGOp *op, uint64_t a_mask)
> +{
> +    if (ctx->type == TCG_TYPE_I32) {
> +        a_mask = (uint32_t)a_mask;
> +    }
>       if (a_mask == 0) {
>           return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
>       }
> @@ -1305,8 +1315,9 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
>        * Known-zeros does not imply known-ones.  Therefore unless
>        * arg2 is constant, we can't infer affected bits from it.
>        */
> -    if (arg_is_const(op->args[2])) {
> -        ctx->a_mask = z1 & ~z2;
> +    if (arg_is_const(op->args[2]) &&
> +        fold_affected_mask(ctx, op, z1 & ~z2)) {
> +        return true;
>       }
>   
>       return fold_masks(ctx, op);
> @@ -1331,7 +1342,9 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
>        */
>       if (arg_is_const(op->args[2])) {
>           uint64_t z2 = ~arg_info(op->args[2])->z_mask;
> -        ctx->a_mask = z1 & ~z2;
> +        if (fold_affected_mask(ctx, op, z1 & ~z2)) {
> +            return true;
> +        }
>           z1 &= z2;
>       }
>       ctx->z_mask = z1;
> @@ -1709,8 +1722,8 @@ static bool fold_extract(OptContext *ctx, TCGOp *op)
>   
>       z_mask_old = arg_info(op->args[1])->z_mask;
>       z_mask = extract64(z_mask_old, pos, len);
> -    if (pos == 0) {
> -        ctx->a_mask = z_mask_old ^ z_mask;
> +    if (pos == 0 && fold_affected_mask(ctx, op, z_mask_old ^ z_mask)) {
> +        return true;
>       }
>       ctx->z_mask = z_mask;
>       ctx->s_mask = smask_from_zmask(z_mask);
> @@ -1777,8 +1790,8 @@ static bool fold_exts(OptContext *ctx, TCGOp *op)
>   
>       ctx->z_mask = z_mask;
>       ctx->s_mask = s_mask;
> -    if (!type_change) {
> -        ctx->a_mask = s_mask & ~s_mask_old;
> +    if (!type_change && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
> +        return true;
>       }
>   
>       return fold_masks(ctx, op);
> @@ -1819,8 +1832,8 @@ static bool fold_extu(OptContext *ctx, TCGOp *op)
>   
>       ctx->z_mask = z_mask;
>       ctx->s_mask = smask_from_zmask(z_mask);
> -    if (!type_change) {
> -        ctx->a_mask = z_mask_old ^ z_mask;
> +    if (!type_change && fold_affected_mask(ctx, op, z_mask_old ^ z_mask)) {
> +        return true;
>       }
>       return fold_masks(ctx, op);
>   }
> @@ -2482,8 +2495,8 @@ static bool fold_sextract(OptContext *ctx, TCGOp *op)
>       s_mask |= MAKE_64BIT_MASK(len, 64 - len);
>       ctx->s_mask = s_mask;
>   
> -    if (pos == 0) {
> -        ctx->a_mask = s_mask & ~s_mask_old;
> +    if (pos == 0 && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
> +        return true;
>       }
>   
>       return fold_masks(ctx, op);
> @@ -2843,7 +2856,6 @@ void tcg_optimize(TCGContext *s)
>           }
>   
>           /* Assume all bits affected, no bits known zero, no sign reps. */
> -        ctx.a_mask = -1;
>           ctx.z_mask = -1;
>           ctx.s_mask = 0;
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


