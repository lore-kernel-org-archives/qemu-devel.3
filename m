Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6575AE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNeTG-0007OY-G0; Tue, 17 Dec 2024 15:47:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeTC-0007G1-IO
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:47:08 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeTA-0004e8-Og
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:47:06 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ee397a82f6so5012210a91.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734468423; x=1735073223; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/jC6Ft/S87O0X4R0NrhfEvHSmXav6JhyKkZxFTahtww=;
 b=imWIuEjpW96rjHKm5y0+P0vUnEH2hMzANPx56a9uY3vTfisEFbD1VoQ5BhHYcablKW
 AR7l88MuNiUl/tm37tsaI7VSTmbMeUVYFtCoeOlrHlkHvIZiM3jNZPu59XBB1eCG7I9M
 hEgDBhlPprMyQEcLTyK4yH0EruAQuiIuFneZiy4CZHAWZleKcLw1UjQTp2kP3zexX448
 s/o1yqLMIsFIoBVY5YzgxJ2a8Y8khHa4CMyo2nmYuCwl8ru9nWOMnHsj6bRAPA58CkNV
 C/w5IkrY/IDJc70atCy86QHyIJlPQZHE5XmhPVsZaqo84D0OF1w1L2qDSroUwyvlc9R4
 u0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734468423; x=1735073223;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/jC6Ft/S87O0X4R0NrhfEvHSmXav6JhyKkZxFTahtww=;
 b=gCueDKE8jYejHCllH+tFxTEIz+PX9ik+raJ8s61ECPvHGHfb10FyT5cqX9XI+N5UKd
 R1YbBhoFksUkeXuAi4aDbiCe8CR3ooHRDsVuzUC0RLyjjfi+Qb7Fvc2FtxhX4igcOBNP
 /lOU12s1IoA91HSc4rnWPcm/1PnOhrbMJEgWV7x4tDSGO5RBmb7WOasdmpxQwqK2ev4k
 Kk7frWQLTaPunYojIHeWSjYzU1yKPQNvfr0ss+Dk54JO/9qKHJiLjd8kJ0gjwMEVg/+5
 Bxy0v+7SrKD21nYVymn3z4IgRMV7fbnFnVw2M3irtS+yz4FvMdWIL7LFELy+0KrBU9y5
 WTLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3+ZotzMLT9SRlsj7NVGiGLoYikmVxTUaxm7M4nM71aiydyqnGqmdvdSGYTGWthQcJzx+/UPTutyph@nongnu.org
X-Gm-Message-State: AOJu0Yz1HrgDCD8g5x2c9OouJuBFZ2Tzs/wg348bKGo3lEqEh/y1+CuL
 YEmOM5v3aRYclxFlTTSK89kGaEZRJsO5TQVDkglcJK+WsD1BGw41o9fki3snnCQ=
X-Gm-Gg: ASbGncsjg2/fDHW0Z7PGFgupCzDhiowCV5KBwIxg0Trj1e/VJwK/d3/vuKe2rt/7txY
 YPGXB/haQY8fVorp73X97nZ+BpUBv4qZQOr7iOFuLnjL6hvFNcgVyO04u/cVTSXUR2VxP9eT+35
 qeuNSl1d9ISMiGmH/B8U0IK3iUGTFfxPr0TDf3OBFAbrIXD5r2vTxYNpLZlYZjkv0r/g0zz4qaT
 77ugHNqnD7SU2p5yuHNcEiex2LXGZgmNgzc9x7LXCopHE2xR+jeEYEti+svdSCP2Aynmg==
X-Google-Smtp-Source: AGHT+IEmCjaMiJCPqFDJR28gmS3ESdsjFkOtVdNs5H2Ar2Pb/oGP+fEoZYktmbZEbrjuoAqmLRLMqQ==
X-Received: by 2002:a17:90b:53c8:b0:2ee:b0f1:ba17 with SMTP id
 98e67ed59e1d1-2f2e93733f2mr412311a91.37.1734468423122; 
 Tue, 17 Dec 2024 12:47:03 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2d50adc92sm2928846a91.30.2024.12.17.12.47.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:47:02 -0800 (PST)
Message-ID: <90139a0b-ac48-4e24-b54a-7a03c98afc33@linaro.org>
Date: Tue, 17 Dec 2024 12:47:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 45/46] tcg/optimize: Move fold_bitsel_vec into alphabetic
 sort
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-46-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-46-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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
> Add forward declarations as needed.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 114 +++++++++++++++++++++++++------------------------
>   1 file changed, 59 insertions(+), 55 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index eb6e93809e..54082042aa 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1191,6 +1191,10 @@ static bool fold_xx_to_x(OptContext *ctx, TCGOp *op)
>    *   3) those that produce information about the result value.
>    */
>   
> +static bool fold_or(OptContext *ctx, TCGOp *op);
> +static bool fold_orc(OptContext *ctx, TCGOp *op);
> +static bool fold_xor(OptContext *ctx, TCGOp *op);
> +
>   static bool fold_add(OptContext *ctx, TCGOp *op)
>   {
>       if (fold_const2_commutative(ctx, op) ||
> @@ -1347,6 +1351,61 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
>       return fold_masks_zsa(ctx, op, z_mask, s_mask, a_mask);
>   }
>   
> +static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)
> +{
> +    /* If true and false values are the same, eliminate the cmp. */
> +    if (args_are_copies(op->args[2], op->args[3])) {
> +        return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[2]);
> +    }
> +
> +    if (arg_is_const(op->args[2]) && arg_is_const(op->args[3])) {
> +        uint64_t tv = arg_info(op->args[2])->val;
> +        uint64_t fv = arg_info(op->args[3])->val;
> +
> +        if (tv == -1 && fv == 0) {
> +            return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
> +        }
> +        if (tv == 0 && fv == -1) {
> +            if (TCG_TARGET_HAS_not_vec) {
> +                op->opc = INDEX_op_not_vec;
> +                return fold_not(ctx, op);
> +            } else {
> +                op->opc = INDEX_op_xor_vec;
> +                op->args[2] = arg_new_constant(ctx, -1);
> +                return fold_xor(ctx, op);
> +            }
> +        }
> +    }
> +    if (arg_is_const(op->args[2])) {
> +        uint64_t tv = arg_info(op->args[2])->val;
> +        if (tv == -1) {
> +            op->opc = INDEX_op_or_vec;
> +            op->args[2] = op->args[3];
> +            return fold_or(ctx, op);
> +        }
> +        if (tv == 0 && TCG_TARGET_HAS_andc_vec) {
> +            op->opc = INDEX_op_andc_vec;
> +            op->args[2] = op->args[1];
> +            op->args[1] = op->args[3];
> +            return fold_andc(ctx, op);
> +        }
> +    }
> +    if (arg_is_const(op->args[3])) {
> +        uint64_t fv = arg_info(op->args[3])->val;
> +        if (fv == 0) {
> +            op->opc = INDEX_op_and_vec;
> +            return fold_and(ctx, op);
> +        }
> +        if (fv == -1 && TCG_TARGET_HAS_orc_vec) {
> +            op->opc = INDEX_op_orc_vec;
> +            op->args[2] = op->args[1];
> +            op->args[1] = op->args[3];
> +            return fold_orc(ctx, op);
> +        }
> +    }
> +    return finish_folding(ctx, op);
> +}
> +
>   static bool fold_brcond(OptContext *ctx, TCGOp *op)
>   {
>       int i = do_constant_folding_cond1(ctx, op, NO_DEST, &op->args[0],
> @@ -2758,61 +2817,6 @@ static bool fold_xor(OptContext *ctx, TCGOp *op)
>       return fold_masks_zs(ctx, op, z_mask, s_mask);
>   }
>   
> -static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)
> -{
> -    /* If true and false values are the same, eliminate the cmp. */
> -    if (args_are_copies(op->args[2], op->args[3])) {
> -        return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[2]);
> -    }
> -
> -    if (arg_is_const(op->args[2]) && arg_is_const(op->args[3])) {
> -        uint64_t tv = arg_info(op->args[2])->val;
> -        uint64_t fv = arg_info(op->args[3])->val;
> -
> -        if (tv == -1 && fv == 0) {
> -            return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
> -        }
> -        if (tv == 0 && fv == -1) {
> -            if (TCG_TARGET_HAS_not_vec) {
> -                op->opc = INDEX_op_not_vec;
> -                return fold_not(ctx, op);
> -            } else {
> -                op->opc = INDEX_op_xor_vec;
> -                op->args[2] = arg_new_constant(ctx, -1);
> -                return fold_xor(ctx, op);
> -            }
> -        }
> -    }
> -    if (arg_is_const(op->args[2])) {
> -        uint64_t tv = arg_info(op->args[2])->val;
> -        if (tv == -1) {
> -            op->opc = INDEX_op_or_vec;
> -            op->args[2] = op->args[3];
> -            return fold_or(ctx, op);
> -        }
> -        if (tv == 0 && TCG_TARGET_HAS_andc_vec) {
> -            op->opc = INDEX_op_andc_vec;
> -            op->args[2] = op->args[1];
> -            op->args[1] = op->args[3];
> -            return fold_andc(ctx, op);
> -        }
> -    }
> -    if (arg_is_const(op->args[3])) {
> -        uint64_t fv = arg_info(op->args[3])->val;
> -        if (fv == 0) {
> -            op->opc = INDEX_op_and_vec;
> -            return fold_and(ctx, op);
> -        }
> -        if (fv == -1 && TCG_TARGET_HAS_orc_vec) {
> -            op->opc = INDEX_op_orc_vec;
> -            op->args[2] = op->args[1];
> -            op->args[1] = op->args[3];
> -            return fold_orc(ctx, op);
> -        }
> -    }
> -    return finish_folding(ctx, op);
> -}
> -
>   /* Propagate constants and copies, fold constant expressions. */
>   void tcg_optimize(TCGContext *s)
>   {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


