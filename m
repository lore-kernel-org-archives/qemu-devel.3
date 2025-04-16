Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3BFC369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u581Q-0007EU-3s; Wed, 16 Apr 2025 15:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u581O-0007EE-0O
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:02:06 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u581L-0003ps-6W
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:02:05 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b0b2d0b2843so542375a12.2
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744830122; x=1745434922; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/4Z+t+IyP52W2EYQ3dMXKVwxE1ds4cfteOChAmTsl3s=;
 b=UJT64PVZDhvYmPOmHdyEqa7k5kWAp7iJz9aI7gGtieysTFpmcn7iuEe8HZBL79gbI9
 21wFTHxQpnYkRLUkwqQP4P7SHxDr20q5t5txYaNk02W+Iya/EGNlx84hn6hkTUR7ky7q
 92IO0pcYfFB7SBGSmefzOIGyP1quJlQoHzCJHEkUyC4WETAo/EVY5DFeCDNGCXVDe8gE
 +apMzSlLr5cpCIdkaxEMjUwGPMT4D4fHxIJsTc+1mP4npgjkHK9UAGmB99XLewlzYbXk
 Z0dGJum1Fr+xJNbpluxolnIUKTweT9MDCAYJ5FGwXNKgMsnas6RTNg8mCjkgYsVO5q0T
 6lAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744830122; x=1745434922;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/4Z+t+IyP52W2EYQ3dMXKVwxE1ds4cfteOChAmTsl3s=;
 b=t9YC/yOUK6Na7glB09qfuVYNMqS4Q/0Cw/d4w2nysA5CXNjFji6NsGg9prXpBu085B
 r7IO1e2PYWuNKxAz6EY8nIZ30YnqCqOO3j3YZYzKkTegjZqRcYrprmaXmheeeoYyMjnn
 pch0PolhiCrqArHg3SwnF1xNvrrXrdqi4ANdAYfUFxePOmbsFKYkSbrGXMN00qzgQVMZ
 iJ+C8b3DXr/sccIzErdL4CQ7GdfwOZgQInl9DvMt+m+xN7gDOnAgLYnqIfjl7xM7KWOK
 UxF4pJR++Z8F42ZXfxgJe6Ac2j4kpIxxH/CjkiqnaTFMWYthx3R2w2zjPVlQQWo2dWKD
 StBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFD1Ek5DAAEnzqiGcotr6bG4JVDlub5EKgI1ByyVMbnyzdLD+rpmp1i8lovvRrfczsYVm07qy3AhB/@nongnu.org
X-Gm-Message-State: AOJu0Yw6tOkvQyskIYQzNaVnQDP/9e+bmh0silIVq8NtP3eUusodB28X
 7XOOPB7CMBAoFm9c40BAFV0wEzquSSjIh/d6yhRQuzwVH0b0+GYCf4bsoW3lE9Y=
X-Gm-Gg: ASbGncvN/CjOiTrTVLEu6tk5CAcyasij27scHP8XQX7FbUSRGLNFiU/LXgMlnoI2+nM
 /IOIRdLDZhZ+ZoNbNoYyOfy12JUp2z64DrqPazqRdUb4egPCBUMj2ct/e4HHwGpScqytD8qQZRZ
 06A4D9iHWKFMosXRKO3PNFhyP9tDNa1/ubCHpiR36OZ4LyF6oi1cHP/YrDz4ZmaDUmv+8EPfIZV
 nIjeM9StAWF0CpKA0GC3sue/13+WlmFgP6biSppYadCQ+7zbsVxcW948Asi+Vi+poeKspbEDzPh
 yXjEctWqrW/vyduv1Sv4DUYIxRxWRdPJaCNmwnYlqa7PGcnWGiqiFQ==
X-Google-Smtp-Source: AGHT+IG1xw3tI6MiGblKAlUquy8fJr/xxIj/+QhKm+d5e2OlCZ4iHedWNhlEh+Y9faKoKfLgX4Brww==
X-Received: by 2002:a17:90b:1b11:b0:2fe:68a5:d84b with SMTP id
 98e67ed59e1d1-30863d1de4bmr4425508a91.1.1744830121570; 
 Wed, 16 Apr 2025 12:02:01 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3086122acb5sm1982198a91.37.2025.04.16.12.02.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 12:02:01 -0700 (PDT)
Message-ID: <ee3c7d6f-5029-402c-915c-81b5be226af2@linaro.org>
Date: Wed, 16 Apr 2025 12:02:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 115/163] tcg/optimize: Handle add/sub with carry opcodes
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-116-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-116-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
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

On 4/15/25 12:24, Richard Henderson wrote:
> Propagate known carry when possible, and simplify the opcodes
> to not require carry-in when known.  The result will be cleaned
> up further by the subsequent liveness analysis pass.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 319 ++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 316 insertions(+), 3 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 5a21f8bfd9..1b3d0b5b5d 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -66,6 +66,7 @@ typedef struct OptContext {
>   
>       /* In flight values from optimization. */
>       TCGType type;
> +    int carry_state;  /* -1 = non-constant, {0,1} = constant carry-in */
>   } OptContext;
>   
>   static inline TempOptInfo *ts_info(TCGTemp *ts)
> @@ -1191,8 +1192,10 @@ static bool fold_xx_to_x(OptContext *ctx, TCGOp *op)
>    *   3) those that produce information about the result value.
>    */
>   
> +static bool fold_addco(OptContext *ctx, TCGOp *op);
>   static bool fold_or(OptContext *ctx, TCGOp *op);
>   static bool fold_orc(OptContext *ctx, TCGOp *op);
> +static bool fold_subbo(OptContext *ctx, TCGOp *op);
>   static bool fold_xor(OptContext *ctx, TCGOp *op);
>   
>   static bool fold_add(OptContext *ctx, TCGOp *op)
> @@ -1214,9 +1217,167 @@ static bool fold_add_vec(OptContext *ctx, TCGOp *op)
>       return finish_folding(ctx, op);
>   }
>   
> -static bool fold_add_carry(OptContext *ctx, TCGOp *op)
> +static void squash_prev_carryout(OptContext *ctx, TCGOp *op)
> +{
> +    TempOptInfo *t2;
> +
> +    op = QTAILQ_PREV(op, link);
> +    switch (op->opc) {
> +    case INDEX_op_addco:
> +        op->opc = INDEX_op_add;
> +        fold_add(ctx, op);
> +        break;
> +    case INDEX_op_addcio:
> +        op->opc = INDEX_op_addci;
> +        break;
> +    case INDEX_op_addc1o:
> +        op->opc = INDEX_op_add;
> +        t2 = arg_info(op->args[2]);
> +        if (ti_is_const(t2)) {
> +            op->args[2] = arg_new_constant(ctx, ti_const_val(t2) + 1);
> +            /* Perform other constant folding, if needed. */
> +            fold_add(ctx, op);
> +        } else {
> +            TCGArg ret = op->args[0];
> +            op = tcg_op_insert_after(ctx->tcg, op, INDEX_op_add, 3);
> +            op->args[0] = ret;
> +            op->args[1] = ret;
> +            op->args[2] = arg_new_constant(ctx, 1);
> +        }
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static bool fold_addci(OptContext *ctx, TCGOp *op)
>   {
>       fold_commutative(ctx, op);
> +
> +    if (ctx->carry_state < 0) {
> +        return finish_folding(ctx, op);
> +    }
> +
> +    squash_prev_carryout(ctx, op);
> +    op->opc = INDEX_op_add;
> +
> +    if (ctx->carry_state > 0) {
> +        TempOptInfo *t2 = arg_info(op->args[2]);
> +
> +        /*
> +         * Propagate the known carry-in into a constant, if possible.
> +         * Otherwise emit a second add +1.
> +         */
> +        if (ti_is_const(t2)) {
> +            op->args[2] = arg_new_constant(ctx, ti_const_val(t2) + 1);
> +        } else {
> +            TCGOp *op2 = tcg_op_insert_before(ctx->tcg, op, INDEX_op_add, 3);
> +
> +            op2->args[0] = op->args[0];
> +            op2->args[1] = op->args[1];
> +            op2->args[2] = op->args[2];
> +            fold_add(ctx, op2);
> +
> +            op->args[1] = op->args[0];
> +            op->args[2] = arg_new_constant(ctx, 1);
> +        }
> +    }
> +
> +    ctx->carry_state = -1;
> +    return fold_add(ctx, op);
> +}
> +
> +static bool fold_addcio(OptContext *ctx, TCGOp *op)
> +{
> +    TempOptInfo *t1, *t2;
> +    int carry_out = -1;
> +    uint64_t sum, max;
> +
> +    fold_commutative(ctx, op);
> +    t1 = arg_info(op->args[1]);
> +    t2 = arg_info(op->args[2]);
> +
> +    /*
> +     * The z_mask value is >= the maximum value that can be represented
> +     * with the known zero bits.  So adding the z_mask values will not
> +     * overflow if and only if the true values cannot overflow.
> +     */
> +    if (!uadd64_overflow(t1->z_mask, t2->z_mask, &sum) &&
> +        !uadd64_overflow(sum, ctx->carry_state != 0, &sum)) {
> +        carry_out = 0;
> +    }
> +
> +    if (ctx->carry_state < 0) {
> +        ctx->carry_state = carry_out;
> +        return finish_folding(ctx, op);
> +    }
> +
> +    squash_prev_carryout(ctx, op);
> +    if (ctx->carry_state == 0) {
> +        goto do_addco;
> +    }
> +
> +    /* Propagate the known carry-in into a constant, if possible. */
> +    max = ctx->type == TCG_TYPE_I32 ? UINT32_MAX : UINT64_MAX;
> +    if (ti_is_const(t2)) {
> +        uint64_t v = ti_const_val(t2) & max;
> +        if (v < max) {
> +            op->args[2] = arg_new_constant(ctx, v + 1);
> +            goto do_addco;
> +        }
> +        /* max + known carry in produces known carry out. */
> +        carry_out = 1;
> +    }
> +    if (ti_is_const(t1)) {
> +        uint64_t v = ti_const_val(t1) & max;
> +        if (v < max) {
> +            op->args[1] = arg_new_constant(ctx, v + 1);
> +            goto do_addco;
> +        }
> +        carry_out = 1;
> +    }
> +
> +    /* Adjust the opcode to remember the known carry-in. */
> +    op->opc = INDEX_op_addc1o;
> +    ctx->carry_state = carry_out;
> +    return finish_folding(ctx, op);
> +
> + do_addco:
> +    op->opc = INDEX_op_addco;
> +    return fold_addco(ctx, op);
> +}
> +
> +static bool fold_addco(OptContext *ctx, TCGOp *op)
> +{
> +    TempOptInfo *t1, *t2;
> +    int carry_out = -1;
> +    uint64_t ign;
> +
> +    fold_commutative(ctx, op);
> +    t1 = arg_info(op->args[1]);
> +    t2 = arg_info(op->args[2]);
> +
> +    if (ti_is_const(t2)) {
> +        uint64_t v2 = ti_const_val(t2);
> +
> +        if (ti_is_const(t1)) {
> +            uint64_t v1 = ti_const_val(t1);
> +            /* Given sign-extension of z_mask for I32, we need not truncate. */
> +            carry_out = uadd64_overflow(v1, v2, &ign);
> +        } else if (v2 == 0) {
> +            carry_out = 0;
> +        }
> +    } else {
> +        /*
> +         * The z_mask value is >= the maximum value that can be represented
> +         * with the known zero bits.  So adding the z_mask values will not
> +         * overflow if and only if the true values cannot overflow.
> +         */
> +        if (!uadd64_overflow(t1->z_mask, t2->z_mask, &ign)) {
> +            carry_out = 0;
> +        }
> +    }
> +    ctx->carry_state = carry_out;
>       return finish_folding(ctx, op);
>   }
>   
> @@ -2637,6 +2798,145 @@ static bool fold_sub2(OptContext *ctx, TCGOp *op)
>       return fold_addsub2(ctx, op, false);
>   }
>   
> +static void squash_prev_borrowout(OptContext *ctx, TCGOp *op)
> +{
> +    TempOptInfo *t2;
> +
> +    op = QTAILQ_PREV(op, link);
> +    switch (op->opc) {
> +    case INDEX_op_subbo:
> +        op->opc = INDEX_op_sub;
> +        fold_sub(ctx, op);
> +        break;
> +    case INDEX_op_subbio:
> +        op->opc = INDEX_op_subbi;
> +        break;
> +    case INDEX_op_subb1o:
> +        t2 = arg_info(op->args[2]);
> +        if (ti_is_const(t2)) {
> +            op->opc = INDEX_op_add;
> +            op->args[2] = arg_new_constant(ctx, -(ti_const_val(t2) + 1));
> +            /* Perform other constant folding, if needed. */
> +            fold_add(ctx, op);
> +        } else {
> +            TCGArg ret = op->args[0];
> +            op->opc = INDEX_op_sub;
> +            op = tcg_op_insert_after(ctx->tcg, op, INDEX_op_add, 3);
> +            op->args[0] = ret;
> +            op->args[1] = ret;
> +            op->args[2] = arg_new_constant(ctx, -1);
> +        }
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static bool fold_subbi(OptContext *ctx, TCGOp *op)
> +{
> +    TempOptInfo *t2;
> +    int borrow_in = ctx->carry_state;
> +
> +    if (borrow_in < 0) {
> +        return finish_folding(ctx, op);
> +    }
> +    ctx->carry_state = -1;
> +
> +    squash_prev_borrowout(ctx, op);
> +    if (borrow_in == 0) {
> +        op->opc = INDEX_op_sub;
> +        return fold_sub(ctx, op);
> +    }
> +
> +    /*
> +     * Propagate the known carry-in into any constant, then negate to
> +     * transform from sub to add.  If there is no constant, emit a
> +     * separate add -1.
> +     */
> +    t2 = arg_info(op->args[2]);
> +    if (ti_is_const(t2)) {
> +        op->args[2] = arg_new_constant(ctx, -(ti_const_val(t2) + 1));
> +    } else {
> +        TCGOp *op2 = tcg_op_insert_before(ctx->tcg, op, INDEX_op_sub, 3);
> +
> +        op2->args[0] = op->args[0];
> +        op2->args[1] = op->args[1];
> +        op2->args[2] = op->args[2];
> +        fold_sub(ctx, op2);
> +
> +        op->args[1] = op->args[0];
> +        op->args[2] = arg_new_constant(ctx, -1);
> +    }
> +    op->opc = INDEX_op_add;
> +    return fold_add(ctx, op);
> +}
> +
> +static bool fold_subbio(OptContext *ctx, TCGOp *op)
> +{
> +    TempOptInfo *t1, *t2;
> +    int borrow_out = -1;
> +
> +    if (ctx->carry_state < 0) {
> +        return finish_folding(ctx, op);
> +    }
> +
> +    squash_prev_borrowout(ctx, op);
> +    if (ctx->carry_state == 0) {
> +        goto do_subbo;
> +    }
> +
> +    t1 = arg_info(op->args[1]);
> +    t2 = arg_info(op->args[2]);
> +
> +    /* Propagate the known borrow-in into a constant, if possible. */
> +    if (ti_is_const(t2)) {
> +        uint64_t max = ctx->type == TCG_TYPE_I32 ? UINT32_MAX : UINT64_MAX;
> +        uint64_t v = ti_const_val(t2) & max;
> +
> +        if (v < max) {
> +            op->args[2] = arg_new_constant(ctx, v + 1);
> +            goto do_subbo;
> +        }
> +        /* subtracting max + 1 produces known borrow out. */
> +        borrow_out = 1;
> +    }
> +    if (ti_is_const(t1)) {
> +        uint64_t v = ti_const_val(t1);
> +        if (v != 0) {
> +            op->args[2] = arg_new_constant(ctx, v - 1);
> +            goto do_subbo;
> +        }
> +    }
> +
> +    /* Adjust the opcode to remember the known carry-in. */
> +    op->opc = INDEX_op_subb1o;
> +    ctx->carry_state = borrow_out;
> +    return finish_folding(ctx, op);
> +
> + do_subbo:
> +    op->opc = INDEX_op_subbo;
> +    return fold_subbo(ctx, op);
> +}
> +
> +static bool fold_subbo(OptContext *ctx, TCGOp *op)
> +{
> +    TempOptInfo *t1 = arg_info(op->args[1]);
> +    TempOptInfo *t2 = arg_info(op->args[2]);
> +    int borrow_out = -1;
> +
> +    if (ti_is_const(t2)) {
> +        uint64_t v2 = ti_const_val(t2);
> +        if (v2 == 0) {
> +            borrow_out = 0;
> +        } else if (ti_is_const(t1)) {
> +            uint64_t v1 = ti_const_val(t1);
> +            borrow_out = v1 < v2;
> +        }
> +    }
> +    ctx->carry_state = borrow_out;
> +    return finish_folding(ctx, op);
> +}
> +
>   static bool fold_tcg_ld(OptContext *ctx, TCGOp *op)
>   {
>       uint64_t z_mask = -1, s_mask = 0;
> @@ -2824,9 +3124,13 @@ void tcg_optimize(TCGContext *s)
>               done = fold_add_vec(&ctx, op);
>               break;
>           case INDEX_op_addci:
> -        case INDEX_op_addco:
> +            done = fold_addci(&ctx, op);
> +            break;
>           case INDEX_op_addcio:
> -            done = fold_add_carry(&ctx, op);
> +            done = fold_addcio(&ctx, op);
> +            break;
> +        case INDEX_op_addco:
> +            done = fold_addco(&ctx, op);
>               break;
>           CASE_OP_32_64(add2):
>               done = fold_add2(&ctx, op);
> @@ -3008,6 +3312,15 @@ void tcg_optimize(TCGContext *s)
>           case INDEX_op_sub:
>               done = fold_sub(&ctx, op);
>               break;
> +        case INDEX_op_subbi:
> +            done = fold_subbi(&ctx, op);
> +            break;
> +        case INDEX_op_subbio:
> +            done = fold_subbio(&ctx, op);
> +            break;
> +        case INDEX_op_subbo:
> +            done = fold_subbo(&ctx, op);
> +            break;
>           case INDEX_op_sub_vec:
>               done = fold_sub_vec(&ctx, op);
>               break;

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


