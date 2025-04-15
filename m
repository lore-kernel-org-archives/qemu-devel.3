Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14B1C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 21:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4nS4-0001kW-Nw; Tue, 15 Apr 2025 17:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4nS3-0001ju-M3
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:04:15 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4nRz-0005iQ-GV
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:04:15 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2295d78b45cso85859365ad.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 14:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744751048; x=1745355848; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6jAGWa/a2aI37pdWU8MWCBolvWmDIQaCLn22WzFdz/Y=;
 b=KUM3XXGIdsBOuPoiyKGz2Ny6BLqn9E80yyxR/tgnACf5LCuJMAGhwOxtMBru8syBHZ
 ZMoppXACkv40eeb8WKnIdT9uvgW5B/APJHFpOdKWKwSf3tyewSArvsfu+zpMLH6dZDyt
 aO2DUTR0XHGJNHsUE9MY+1lokOnps0MelIOrRCUuIlmc5WmyvlRA2bm1vu3/+SUqlZNG
 YRPP5xgoeHLwesQHq23X+hpR+tKagDszz0rH4mfQ97t8Zya9XW8aHhLebDLcg6K6edXZ
 Tkg6OPcthcXr3gIYbaPFvBoH5vmjKu5oglzc8JD+EMy6eyThwdRUrMd6IXjUwE8ZgZ+g
 VZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744751048; x=1745355848;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6jAGWa/a2aI37pdWU8MWCBolvWmDIQaCLn22WzFdz/Y=;
 b=mua8+dZ7iHT+rWf6eQG8sRMtpcTKxYG4bjR+l6HBvWq3wzhHWh1S0myUYrGkwJfBRK
 EbJWuctfHtai69kW2oQZ9zugTMIlkU4Vnf7PgVfMFm2c+RX6Q6oOVLPLh5ukp0BVFn7n
 w6dyE2C6dDJzh3qLzTYXlB8MJssp2J2q/vmfXwAO2DTf9QMPymROZl3ElfqdjRyj9kDN
 9/usoI8XvfbkcD2Q/ql80OyO8GMSxFkPgi5WgTRx+ZVVWqBA+wOd+CPRLWfYaZE4o6KC
 zFZvxGbkpz3KmxUnCx5fgmFOuN3CUs5tsuAI3CxxpPR8/Pj08DD+r0X4CynG/j9g3JDg
 GpJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFFZtgiL19izFrGf7RxIieEhtvS6HXqJeOp/pWVe0n+neCBsenM3zNWg+S4dcXGqh+T7aQLDGT4yML@nongnu.org
X-Gm-Message-State: AOJu0YzoD9hFnXBzQXScLYkj3w0THqbEELizj7WTxZ1ZJUcWKfYLuwX5
 pK8o0TRciRWy+LKGMME7Srqhnz4RPe97Ec4zJspjvGuPuDpcI3K3j/aEMcPNuz5MK/2aH74JeKg
 Knts=
X-Gm-Gg: ASbGncsjPxcYDrGk0dPwtaO6nGAoZFo3aGCqeDn6DMhCzDDX7DYcNY5e6MHKp924p+S
 sGAuFMe8/0AzyHfc2rFpitB61ZHp4tpt70beFgGF/pfV0z6VgclOjIdmMtSg9oqXc3TBhoBykOj
 NHKJWWMKZWMCE2bilL/N5BM/RKeZjVQozPF5mDThzcXbMoxMGYT2NGbL+lvv2ceWM49TvSkFe5s
 MG/v8p012slJNV4Q7pOZDUKVJZXn/FTUdZ2SLLGfcSKHftFJPpMuZaZcHaJ7hNySjq+/90XyjAV
 pxF6luzgd9Vn9vWdHpVKQQ9F9zMgrworhkLoy7h3F/2jYhxCqstThDhu63p5i2Au
X-Google-Smtp-Source: AGHT+IFi8MIAFOwZz2uDeJdXn0LGbC4UqvvcoYCcw4hZ0ngmRx43cK8z6VefRObhXf7pQV5RwYNRjA==
X-Received: by 2002:a17:903:40ce:b0:21f:85ee:f2df with SMTP id
 d9443c01a7336-22c318cd61amr10328915ad.15.1744751048302; 
 Tue, 15 Apr 2025 14:04:08 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7b8c6b3sm122801225ad.77.2025.04.15.14.04.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 14:04:07 -0700 (PDT)
Message-ID: <ef2da07c-0f16-48d6-9fc6-b77085b8059c@linaro.org>
Date: Tue, 15 Apr 2025 14:04:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 042/163] tcg: Merge INDEX_op_div_{i32,i64}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-43-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-43-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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
> Rename to INDEX_op_divs to emphasize signed inputs,
> and mirroring INDEX_op_divu_*.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    |  3 +--
>   tcg/optimize.c           | 12 +++++++-----
>   tcg/tcg-op.c             | 16 ++++++++--------
>   tcg/tcg.c                |  6 ++----
>   tcg/tci.c                |  5 ++---
>   docs/devel/tcg-ops.rst   |  2 +-
>   tcg/tci/tcg-target.c.inc |  2 +-
>   7 files changed, 22 insertions(+), 24 deletions(-)
> 
> diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
> index a9d7938a52..6d4edd0b16 100644
> --- a/include/tcg/tcg-opc.h
> +++ b/include/tcg/tcg-opc.h
> @@ -42,6 +42,7 @@ DEF(mov, 1, 1, 0, TCG_OPF_INT | TCG_OPF_NOT_PRESENT)
>   DEF(add, 1, 2, 0, TCG_OPF_INT)
>   DEF(and, 1, 2, 0, TCG_OPF_INT)
>   DEF(andc, 1, 2, 0, TCG_OPF_INT)
> +DEF(divs, 1, 2, 0, TCG_OPF_INT)
>   DEF(eqv, 1, 2, 0, TCG_OPF_INT)
>   DEF(mul, 1, 2, 0, TCG_OPF_INT)
>   DEF(mulsh, 1, 2, 0, TCG_OPF_INT)
> @@ -68,7 +69,6 @@ DEF(st8_i32, 0, 2, 1, 0)
>   DEF(st16_i32, 0, 2, 1, 0)
>   DEF(st_i32, 0, 2, 1, 0)
>   /* arith */
> -DEF(div_i32, 1, 2, 0, 0)
>   DEF(divu_i32, 1, 2, 0, 0)
>   DEF(rem_i32, 1, 2, 0, 0)
>   DEF(remu_i32, 1, 2, 0, 0)
> @@ -116,7 +116,6 @@ DEF(st16_i64, 0, 2, 1, 0)
>   DEF(st32_i64, 0, 2, 1, 0)
>   DEF(st_i64, 0, 2, 1, 0)
>   /* arith */
> -DEF(div_i64, 1, 2, 0, 0)
>   DEF(divu_i64, 1, 2, 0, 0)
>   DEF(rem_i64, 1, 2, 0, 0)
>   DEF(remu_i64, 1, 2, 0, 0)
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index f8d9a4d90e..127d0f9390 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -544,13 +544,15 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
>           muls64(&l64, &h64, x, y);
>           return h64;
>   
> -    case INDEX_op_div_i32:
> +    case INDEX_op_divs:
>           /* Avoid crashing on divide by zero, otherwise undefined.  */
> -        return (int32_t)x / ((int32_t)y ? : 1);
> +        if (type == TCG_TYPE_I32) {
> +            return (int32_t)x / ((int32_t)y ? : 1);
> +        }
> +        return (int64_t)x / ((int64_t)y ? : 1);
> +
>       case INDEX_op_divu_i32:
>           return (uint32_t)x / ((uint32_t)y ? : 1);
> -    case INDEX_op_div_i64:
> -        return (int64_t)x / ((int64_t)y ? : 1);
>       case INDEX_op_divu_i64:
>           return (uint64_t)x / ((uint64_t)y ? : 1);
>   
> @@ -2893,7 +2895,7 @@ void tcg_optimize(TCGContext *s)
>           CASE_OP_32_64(deposit):
>               done = fold_deposit(&ctx, op);
>               break;
> -        CASE_OP_32_64(div):
> +        case INDEX_op_divs:
>           CASE_OP_32_64(divu):
>               done = fold_divide(&ctx, op);
>               break;
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 69e50f968f..9dba520d40 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -601,8 +601,8 @@ void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
>   
>   void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
>   {
> -    if (tcg_op_supported(INDEX_op_div_i32, TCG_TYPE_I32, 0)) {
> -        tcg_gen_op3_i32(INDEX_op_div_i32, ret, arg1, arg2);
> +    if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I32, 0)) {
> +        tcg_gen_op3_i32(INDEX_op_divs, ret, arg1, arg2);
>       } else if (TCG_TARGET_HAS_div2_i32) {
>           TCGv_i32 t0 = tcg_temp_ebb_new_i32();
>           tcg_gen_sari_i32(t0, arg1, 31);
> @@ -617,9 +617,9 @@ void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
>   {
>       if (TCG_TARGET_HAS_rem_i32) {
>           tcg_gen_op3_i32(INDEX_op_rem_i32, ret, arg1, arg2);
> -    } else if (tcg_op_supported(INDEX_op_div_i32, TCG_TYPE_I32, 0)) {
> +    } else if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I32, 0)) {
>           TCGv_i32 t0 = tcg_temp_ebb_new_i32();
> -        tcg_gen_op3_i32(INDEX_op_div_i32, t0, arg1, arg2);
> +        tcg_gen_op3_i32(INDEX_op_divs, t0, arg1, arg2);
>           tcg_gen_mul_i32(t0, t0, arg2);
>           tcg_gen_sub_i32(ret, arg1, t0);
>           tcg_temp_free_i32(t0);
> @@ -1969,8 +1969,8 @@ void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
>   
>   void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
>   {
> -    if (tcg_op_supported(INDEX_op_div_i64, TCG_TYPE_I64, 0)) {
> -        tcg_gen_op3_i64(INDEX_op_div_i64, ret, arg1, arg2);
> +    if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I64, 0)) {
> +        tcg_gen_op3_i64(INDEX_op_divs, ret, arg1, arg2);
>       } else if (TCG_TARGET_HAS_div2_i64) {
>           TCGv_i64 t0 = tcg_temp_ebb_new_i64();
>           tcg_gen_sari_i64(t0, arg1, 63);
> @@ -1985,9 +1985,9 @@ void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
>   {
>       if (TCG_TARGET_HAS_rem_i64) {
>           tcg_gen_op3_i64(INDEX_op_rem_i64, ret, arg1, arg2);
> -    } else if (tcg_op_supported(INDEX_op_div_i64, TCG_TYPE_I64, 0)) {
> +    } else if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I64, 0)) {
>           TCGv_i64 t0 = tcg_temp_ebb_new_i64();
> -        tcg_gen_op3_i64(INDEX_op_div_i64, t0, arg1, arg2);
> +        tcg_gen_op3_i64(INDEX_op_divs, t0, arg1, arg2);
>           tcg_gen_mul_i64(t0, t0, arg2);
>           tcg_gen_sub_i64(ret, arg1, t0);
>           tcg_temp_free_i64(t0);
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 52a8842cd3..0edac806e7 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1020,8 +1020,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
>       OUTOP(INDEX_op_add, TCGOutOpBinary, outop_add),
>       OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
>       OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
> -    OUTOP(INDEX_op_div_i32, TCGOutOpBinary, outop_divs),
> -    OUTOP(INDEX_op_div_i64, TCGOutOpBinary, outop_divs),
> +    OUTOP(INDEX_op_divs, TCGOutOpBinary, outop_divs),
>       OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
>       OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
>       OUTOP(INDEX_op_mulsh, TCGOutOpBinary, outop_mulsh),
> @@ -5414,8 +5413,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>       case INDEX_op_add:
>       case INDEX_op_and:
>       case INDEX_op_andc:
> -    case INDEX_op_div_i32:
> -    case INDEX_op_div_i64:
> +    case INDEX_op_divs:
>       case INDEX_op_eqv:
>       case INDEX_op_mul:
>       case INDEX_op_mulsh:
> diff --git a/tcg/tci.c b/tcg/tci.c
> index 4ecbb2d335..4b3ca53bc5 100644
> --- a/tcg/tci.c
> +++ b/tcg/tci.c
> @@ -720,7 +720,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
>   
>               /* Arithmetic operations (64 bit). */
>   
> -        case INDEX_op_div_i64:
> +        case INDEX_op_divs:
>               tci_args_rrr(insn, &r0, &r1, &r2);
>               regs[r0] = (int64_t)regs[r1] / (int64_t)regs[r2];
>               break;
> @@ -1071,6 +1071,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
>       case INDEX_op_add:
>       case INDEX_op_and:
>       case INDEX_op_andc:
> +    case INDEX_op_divs:
>       case INDEX_op_eqv:
>       case INDEX_op_mul:
>       case INDEX_op_nand:
> @@ -1079,8 +1080,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
>       case INDEX_op_orc:
>       case INDEX_op_sub:
>       case INDEX_op_xor:
> -    case INDEX_op_div_i32:
> -    case INDEX_op_div_i64:
>       case INDEX_op_rem_i32:
>       case INDEX_op_rem_i64:
>       case INDEX_op_divu_i32:
> diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
> index fe922d1dac..a833b3b7b2 100644
> --- a/docs/devel/tcg-ops.rst
> +++ b/docs/devel/tcg-ops.rst
> @@ -277,7 +277,7 @@ Arithmetic
>   
>        - | *t0* = *t1* * *t2*
>   
> -   * - div_i32/i64 *t0*, *t1*, *t2*
> +   * - divs *t0*, *t1*, *t2*
>   
>        - | *t0* = *t1* / *t2* (signed)
>          | Undefined behavior if division by zero or overflow.
> diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
> index c8e86a3253..4a556e2ce7 100644
> --- a/tcg/tci/tcg-target.c.inc
> +++ b/tcg/tci/tcg-target.c.inc
> @@ -651,7 +651,7 @@ static void tgen_divs(TCGContext *s, TCGType type,
>   {
>       TCGOpcode opc = (type == TCG_TYPE_I32
>                        ? INDEX_op_tci_divs32
> -                     : INDEX_op_div_i64);
> +                     : INDEX_op_divs);
>       tcg_out_op_rrr(s, opc, a0, a1, a2);
>   }
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


