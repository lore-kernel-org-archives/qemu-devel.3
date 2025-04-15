Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E00C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 21:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4nTv-0004Ns-04; Tue, 15 Apr 2025 17:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4nTY-0004Aj-JO
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:05:53 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4nT6-0006UX-CF
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:05:46 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3018e2d042bso4256910a91.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 14:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744751118; x=1745355918; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=isTi3XlvWi4HqIh+xJdiPR03aOaQt3WV41+l6CA7o6g=;
 b=IR+XYGf8/blzy0rgmBb2BoLWfhxUKMlL0FdToJIlRCabBwN7ShRHKIW4apcOx9nE0j
 nHpXd7UxUonqdG9D7TJUZtmXzS6042t3RD95+dq0czvWU1V10ueNzZVlemCgP4yNREIs
 17UaVypkW8ks6jYRuUfko54GM4d+AUwXWP4kjtIj3BOPuaCZ7fcK0OWUiGLs3fo/+n6z
 dXBPhUd6xjRqvB33zPoabpsnhBmi14rpBNQFjOGrln5yscDXgBKo3F7iJwiXu+EuldiK
 xMY1T+WeRR87Et4uGxUNqs7K8TaMy4rDbTOzoxk/Qq6o/m7Wu6gwQm0+wi8DLnIPHmoc
 nOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744751118; x=1745355918;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=isTi3XlvWi4HqIh+xJdiPR03aOaQt3WV41+l6CA7o6g=;
 b=pW5SBHnzZafJ09UWnMzk4R1l/1HH2i3+Ok0zaHixOHcpRzc5HlxDTFQAZ2H+t/fJb5
 VamepTj0+B9wfUnhmWMp8TgQkZrP0sgPNtNXt9qCEcs1g74uQ+NSZNAuk8lHxum80tbj
 djnE1OR8OUDrYSaFM4tp8/XWL/zTPRCQfikmfMOVclyK5ICOYm9bil7z1mR9L+PDxFhh
 UsnfQnT4UBMVd+DcAQHoyI4M1b5l5oLY/JkD0SmgiABy83wynVJUj9YK4wFSJFcs4w1P
 pFADGYiLQo+jbfIUn/908lkgk18L0kD6pH1UzpXwkS+uTJWyjYo0FREHBmlNuzJeJZ4T
 n1+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqLqNZqwqwlSBEb27LNAswbxOi/gTjyVDxb3QiiU8hz7xfWndBHwapB90dJvPdJrgjeQlJBBCZDDef@nongnu.org
X-Gm-Message-State: AOJu0YwM6nXbJgiNXaGXiBqUnMr0pTsaYvJuQjF67BauWVAzORaAtm/G
 FvDnm9kjMHOW5CgCecHcEjneXStq2LRnpEC6GxIyqD78V+32cdp+Pq1I21rSg8Q=
X-Gm-Gg: ASbGncuA29OkhY39ISTDCue4EDwjFLZN1xwCCZgGfKL8hgJ9NAUjRdUROYqjCPrHCiR
 O/N14vZ6PCUeQwkVCQ7bGJzMItYogSSpEfqTTo4F8iFJzBPULGYRz2ya3x1iE1CQGGnJ1Rav8Dt
 2ViVfykBVqUS8HgB/aqQuV7Wf9NeLxf+2aT7sNet+R1tiCx70F0oUVgEpv4FC3mUg3Xn0Yjzfki
 YfvaSPhsuoqg7Gyc6RkbsWCTJr5wmtt3TAOYrhIkC8qhoJhXlbmHpnxTGs0CYVMQZL9bUkFF551
 6OElyqmmMcNoG6FxpDLc0VOQLkV/30QPI+cwjPslsi42Ub7BNGzCpw==
X-Google-Smtp-Source: AGHT+IHHJwbufNUkhQ056Mncv2l4llDbD3DqwXpqzjtbRJQiaPbMz1RBxKWlIyTzImWCHzx6QPQ8Yw==
X-Received: by 2002:a17:90b:51c2:b0:305:5f25:fcf8 with SMTP id
 98e67ed59e1d1-3085ee95be3mr882473a91.5.1744751118399; 
 Tue, 15 Apr 2025 14:05:18 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-308613661efsm38890a91.46.2025.04.15.14.05.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 14:05:18 -0700 (PDT)
Message-ID: <0cee7116-6c16-4026-b2bb-f5bcc76529c4@linaro.org>
Date: Tue, 15 Apr 2025 14:05:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 046/163] tcg: Merge INDEX_op_div2_{i32,i64}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-47-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-47-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

On 4/15/25 12:23, Richard Henderson wrote:
> Rename to INDEX_op_divs2 to emphasize signed inputs,
> and mirroring INDEX_op_divu2_*.  Document the opcode.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h  |  3 +--
>   tcg/tcg-op.c           | 16 ++++++++--------
>   tcg/tcg.c              |  6 ++----
>   docs/devel/tcg-ops.rst |  9 +++++++++
>   4 files changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
> index 243f002a61..36dfbf80ad 100644
> --- a/include/tcg/tcg-opc.h
> +++ b/include/tcg/tcg-opc.h
> @@ -43,6 +43,7 @@ DEF(add, 1, 2, 0, TCG_OPF_INT)
>   DEF(and, 1, 2, 0, TCG_OPF_INT)
>   DEF(andc, 1, 2, 0, TCG_OPF_INT)
>   DEF(divs, 1, 2, 0, TCG_OPF_INT)
> +DEF(divs2, 2, 3, 0, TCG_OPF_INT)
>   DEF(divu, 1, 2, 0, TCG_OPF_INT)
>   DEF(eqv, 1, 2, 0, TCG_OPF_INT)
>   DEF(mul, 1, 2, 0, TCG_OPF_INT)
> @@ -72,7 +73,6 @@ DEF(st_i32, 0, 2, 1, 0)
>   /* arith */
>   DEF(rem_i32, 1, 2, 0, 0)
>   DEF(remu_i32, 1, 2, 0, 0)
> -DEF(div2_i32, 2, 3, 0, 0)
>   DEF(divu2_i32, 2, 3, 0, 0)
>   /* shifts/rotates */
>   DEF(shl_i32, 1, 2, 0, 0)
> @@ -118,7 +118,6 @@ DEF(st_i64, 0, 2, 1, 0)
>   /* arith */
>   DEF(rem_i64, 1, 2, 0, 0)
>   DEF(remu_i64, 1, 2, 0, 0)
> -DEF(div2_i64, 2, 3, 0, 0)
>   DEF(divu2_i64, 2, 3, 0, 0)
>   /* shifts/rotates */
>   DEF(shl_i64, 1, 2, 0, 0)
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index f326c452a4..f95beb8b5d 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -603,10 +603,10 @@ void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
>   {
>       if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I32, 0)) {
>           tcg_gen_op3_i32(INDEX_op_divs, ret, arg1, arg2);
> -    } else if (TCG_TARGET_HAS_div2_i32) {
> +    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I32, 0)) {
>           TCGv_i32 t0 = tcg_temp_ebb_new_i32();
>           tcg_gen_sari_i32(t0, arg1, 31);
> -        tcg_gen_op5_i32(INDEX_op_div2_i32, ret, t0, arg1, t0, arg2);
> +        tcg_gen_op5_i32(INDEX_op_divs2, ret, t0, arg1, t0, arg2);
>           tcg_temp_free_i32(t0);
>       } else {
>           gen_helper_div_i32(ret, arg1, arg2);
> @@ -623,10 +623,10 @@ void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
>           tcg_gen_mul_i32(t0, t0, arg2);
>           tcg_gen_sub_i32(ret, arg1, t0);
>           tcg_temp_free_i32(t0);
> -    } else if (TCG_TARGET_HAS_div2_i32) {
> +    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I32, 0)) {
>           TCGv_i32 t0 = tcg_temp_ebb_new_i32();
>           tcg_gen_sari_i32(t0, arg1, 31);
> -        tcg_gen_op5_i32(INDEX_op_div2_i32, t0, ret, arg1, t0, arg2);
> +        tcg_gen_op5_i32(INDEX_op_divs2, t0, ret, arg1, t0, arg2);
>           tcg_temp_free_i32(t0);
>       } else {
>           gen_helper_rem_i32(ret, arg1, arg2);
> @@ -1971,10 +1971,10 @@ void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
>   {
>       if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I64, 0)) {
>           tcg_gen_op3_i64(INDEX_op_divs, ret, arg1, arg2);
> -    } else if (TCG_TARGET_HAS_div2_i64) {
> +    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I64, 0)) {
>           TCGv_i64 t0 = tcg_temp_ebb_new_i64();
>           tcg_gen_sari_i64(t0, arg1, 63);
> -        tcg_gen_op5_i64(INDEX_op_div2_i64, ret, t0, arg1, t0, arg2);
> +        tcg_gen_op5_i64(INDEX_op_divs2, ret, t0, arg1, t0, arg2);
>           tcg_temp_free_i64(t0);
>       } else {
>           gen_helper_div_i64(ret, arg1, arg2);
> @@ -1991,10 +1991,10 @@ void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
>           tcg_gen_mul_i64(t0, t0, arg2);
>           tcg_gen_sub_i64(ret, arg1, t0);
>           tcg_temp_free_i64(t0);
> -    } else if (TCG_TARGET_HAS_div2_i64) {
> +    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I64, 0)) {
>           TCGv_i64 t0 = tcg_temp_ebb_new_i64();
>           tcg_gen_sari_i64(t0, arg1, 63);
> -        tcg_gen_op5_i64(INDEX_op_div2_i64, t0, ret, arg1, t0, arg2);
> +        tcg_gen_op5_i64(INDEX_op_divs2, t0, ret, arg1, t0, arg2);
>           tcg_temp_free_i64(t0);
>       } else {
>           gen_helper_rem_i64(ret, arg1, arg2);
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 563a29e579..f6192142ba 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1028,8 +1028,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
>       OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
>       OUTOP(INDEX_op_divs, TCGOutOpBinary, outop_divs),
>       OUTOP(INDEX_op_divu, TCGOutOpBinary, outop_divu),
> -    OUTOP(INDEX_op_div2_i32, TCGOutOpDivRem, outop_divs2),
> -    OUTOP(INDEX_op_div2_i64, TCGOutOpDivRem, outop_divs2),
> +    OUTOP(INDEX_op_divs2, TCGOutOpDivRem, outop_divs2),
>       OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
>       OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
>       OUTOP(INDEX_op_mulsh, TCGOutOpBinary, outop_mulsh),
> @@ -5470,8 +5469,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>           }
>           break;
>   
> -    case INDEX_op_div2_i32:
> -    case INDEX_op_div2_i64:
> +    case INDEX_op_divs2:
>           {
>               const TCGOutOpDivRem *out =
>                   container_of(all_outop[op->opc], TCGOutOpDivRem, base);
> diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
> index 41985be012..62af390854 100644
> --- a/docs/devel/tcg-ops.rst
> +++ b/docs/devel/tcg-ops.rst
> @@ -297,6 +297,15 @@ Arithmetic
>        - | *t0* = *t1* % *t2* (unsigned)
>          | Undefined behavior if division by zero.
>   
> +   * - divs2 *q*, *r*, *nl*, *nh*, *d*
> +
> +     - | *q* = *nh:nl* / *d* (signed)
> +       | *r* = *nh:nl* % *d*
> +       | Undefined behaviour if division by zero, or the double-word
> +         numerator divided by the single-word divisor does not fit
> +         within the single-word quotient.  The code generator will
> +         pass *nh* as a simple sign-extension of *nl*, so the only
> +         overflow should be *INT_MIN* / -1.
>   
>   Logical
>   -------

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


