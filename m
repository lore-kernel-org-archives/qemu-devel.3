Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59461C369BD
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 21:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4nV2-0005sS-CD; Tue, 15 Apr 2025 17:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4nUX-0005ZA-43
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:06:50 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4nU6-000722-Ho
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:06:48 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-736b350a22cso5187107b3a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 14:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744751181; x=1745355981; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=er5782eusmLIacwJiF+N53fpj6NkKDrt1O5+/70YWTM=;
 b=PJlH/5jm0NKDl7Ze0/RMItbeckiqBOSYMInDuR1QmQAs/h4OuNmrNiBjwJbtSVcODz
 UAvqRMbFjQ4qH/hebs7MymN5+qi506PuGZOed8V5QLuc+AwZLv5XPkerqJcwavnOpj8m
 CiUBJtrfYGUTcSZ3MbL1peYisxrXlOZrib8Wq+3f0py0sP68VqyKbsQH6XP1w20HShqv
 33XTGRoXkKV2gQHfLruRNBgEWmqWORfbeqzUs3BHJCK/drXlbF2SCyZVbC2VHfdjrMnF
 DC/CuEexbAViFWTNTK3lx59aSU98jAYKm1q9boLUyGDc9dcvkr8MIbQJOBRU6TRpODyz
 t06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744751181; x=1745355981;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=er5782eusmLIacwJiF+N53fpj6NkKDrt1O5+/70YWTM=;
 b=XJymHTPeCKOAUsyYERt48JD82+lTimmMaj2N9UjT8CQ3zp9RweDyM51fo2VeMQsXSX
 YRl0DxFPtlpSq+rDoc7Mc/t1fOYL08mbjMoLlOc9ibZcbZplClNfVK9mbH2xPBXuGzGk
 hynnayLU80xoBFGH088jhTcHlg45ddCzxkC+QiUFQbMaL9HnGaLUtfRdC9icQO+4CyL5
 AQyTzyvN6rOo5XS5/Q2l9yMEEjA3/y7uhH1+Q1YYG76WJKNvGpPYC5MtY1l2ZLw0WXn1
 Zy/6W9Cbw3VWGfwmybrE6pPbPTlsGXWAHO9v4DXaMBQy9jZvbSiC6X5Nf2iT3g6Fc+km
 0ZlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzvR4u4eKzvUpvT60U2XbWXkinAimn56Qbsex+wQv7qy3niRaBMTAXtd6zFaSzPz4Ygd9nOqMfTJV/@nongnu.org
X-Gm-Message-State: AOJu0YwQdh9MhQNh2mvE8mMEPKysQ4YYsvbp2qXe4Fwedv4PVSL26bd7
 9XlUrGXZ+rpQ8ZR/1QkbvodHpRT7LVZ1qnleXR2LWJ+iTmn0849x5gyKvdqdx9pzeGqW8dA3dGO
 tuPI=
X-Gm-Gg: ASbGncvxu9H84pp9T50iBpLgYpz5qf0PFpJnkRpqFrxmr1lWzqL8/pmTKrcBMFC1wGV
 4ZCMlLC9ZErxeuTC+LKslZarGTz1cx1zDWdUc7JParAxjPMXwrr+Ana/wTXQTyqtTBCtzDZIAws
 c0xSIkqQqlW2Hvf1lF5B1WK0IPrij4Cmo4ORtcmN02Ml6B7yi1WG2mT89abG2eBPHqGZXyj5+mQ
 H7NU1T9+MoH3LNmNsx4Zm0QyI8I5qNcucs/YCSmNbkEcIBB7/fv7xqS0B0mnSDibaqlbIJ3Y1Dq
 +5JUwm7kmhkt5hueqNGIrSAsn0jOkSj0s5ma4OnQbQ1lUMa6RHq8RA==
X-Google-Smtp-Source: AGHT+IFak60S9H3dso5OnZCfdetkh1jjZxrLa1wXtZuh/pKw6dX+7badjFriNcCH7aDybHb+ZYXxZw==
X-Received: by 2002:a05:6a21:9185:b0:1f5:8a03:ea22 with SMTP id
 adf61e73a8af0-203ae05c6a6mr713476637.33.1744751180902; 
 Tue, 15 Apr 2025 14:06:20 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b02a11d2c1dsm11240321a12.38.2025.04.15.14.06.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 14:06:20 -0700 (PDT)
Message-ID: <c53dcc16-0c6c-4c78-abfd-e5afe37ede43@linaro.org>
Date: Tue, 15 Apr 2025 14:06:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 050/163] tcg: Merge INDEX_op_rem_{i32,i64}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-51-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-51-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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
> Rename to INDEX_op_rems to emphasize signed inputs,
> and mirroring INDEX_op_remu_*.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    |  3 +--
>   tcg/optimize.c           | 12 +++++++-----
>   tcg/tcg-op.c             |  8 ++++----
>   tcg/tcg.c                |  6 ++----
>   tcg/tci.c                |  4 ++--
>   docs/devel/tcg-ops.rst   |  2 +-
>   tcg/tci/tcg-target.c.inc |  2 +-
>   7 files changed, 18 insertions(+), 19 deletions(-)
> 
> diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
> index 61e5e185cc..040f4da835 100644
> --- a/include/tcg/tcg-opc.h
> +++ b/include/tcg/tcg-opc.h
> @@ -56,6 +56,7 @@ DEF(nor, 1, 2, 0, TCG_OPF_INT)
>   DEF(not, 1, 1, 0, TCG_OPF_INT)
>   DEF(or, 1, 2, 0, TCG_OPF_INT)
>   DEF(orc, 1, 2, 0, TCG_OPF_INT)
> +DEF(rems, 1, 2, 0, TCG_OPF_INT)
>   DEF(sub, 1, 2, 0, TCG_OPF_INT)
>   DEF(xor, 1, 2, 0, TCG_OPF_INT)
>   
> @@ -72,7 +73,6 @@ DEF(st8_i32, 0, 2, 1, 0)
>   DEF(st16_i32, 0, 2, 1, 0)
>   DEF(st_i32, 0, 2, 1, 0)
>   /* arith */
> -DEF(rem_i32, 1, 2, 0, 0)
>   DEF(remu_i32, 1, 2, 0, 0)
>   /* shifts/rotates */
>   DEF(shl_i32, 1, 2, 0, 0)
> @@ -116,7 +116,6 @@ DEF(st16_i64, 0, 2, 1, 0)
>   DEF(st32_i64, 0, 2, 1, 0)
>   DEF(st_i64, 0, 2, 1, 0)
>   /* arith */
> -DEF(rem_i64, 1, 2, 0, 0)
>   DEF(remu_i64, 1, 2, 0, 0)
>   /* shifts/rotates */
>   DEF(shl_i64, 1, 2, 0, 0)
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 77386eacb7..55663ff4c3 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -557,12 +557,14 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
>           }
>           return (uint64_t)x / ((uint64_t)y ? : 1);
>   
> -    case INDEX_op_rem_i32:
> -        return (int32_t)x % ((int32_t)y ? : 1);
> +    case INDEX_op_rems:
> +        if (type == TCG_TYPE_I32) {
> +            return (int32_t)x % ((int32_t)y ? : 1);
> +        }
> +        return (int64_t)x % ((int64_t)y ? : 1);
> +
>       case INDEX_op_remu_i32:
>           return (uint32_t)x % ((uint32_t)y ? : 1);
> -    case INDEX_op_rem_i64:
> -        return (int64_t)x % ((int64_t)y ? : 1);
>       case INDEX_op_remu_i64:
>           return (uint64_t)x % ((uint64_t)y ? : 1);
>   
> @@ -3009,7 +3011,7 @@ void tcg_optimize(TCGContext *s)
>           case INDEX_op_qemu_st_i128:
>               done = fold_qemu_st(&ctx, op);
>               break;
> -        CASE_OP_32_64(rem):
> +        case INDEX_op_rems:
>           CASE_OP_32_64(remu):
>               done = fold_remainder(&ctx, op);
>               break;
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 7ed92157de..6da8b30547 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -615,8 +615,8 @@ void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
>   
>   void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
>   {
> -    if (TCG_TARGET_HAS_rem_i32) {
> -        tcg_gen_op3_i32(INDEX_op_rem_i32, ret, arg1, arg2);
> +    if (tcg_op_supported(INDEX_op_rems, TCG_TYPE_I32, 0)) {
> +        tcg_gen_op3_i32(INDEX_op_rems, ret, arg1, arg2);
>       } else if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I32, 0)) {
>           TCGv_i32 t0 = tcg_temp_ebb_new_i32();
>           tcg_gen_op3_i32(INDEX_op_divs, t0, arg1, arg2);
> @@ -1983,8 +1983,8 @@ void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
>   
>   void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
>   {
> -    if (TCG_TARGET_HAS_rem_i64) {
> -        tcg_gen_op3_i64(INDEX_op_rem_i64, ret, arg1, arg2);
> +    if (tcg_op_supported(INDEX_op_rems, TCG_TYPE_I64, 0)) {
> +        tcg_gen_op3_i64(INDEX_op_rems, ret, arg1, arg2);
>       } else if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I64, 0)) {
>           TCGv_i64 t0 = tcg_temp_ebb_new_i64();
>           tcg_gen_op3_i64(INDEX_op_divs, t0, arg1, arg2);
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 5e5082b3cd..9ec10168a8 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1040,8 +1040,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
>       OUTOP(INDEX_op_not, TCGOutOpUnary, outop_not),
>       OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
>       OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
> -    OUTOP(INDEX_op_rem_i32, TCGOutOpBinary, outop_rems),
> -    OUTOP(INDEX_op_rem_i64, TCGOutOpBinary, outop_rems),
> +    OUTOP(INDEX_op_rems, TCGOutOpBinary, outop_rems),
>       OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
>       OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
>   };
> @@ -5422,8 +5421,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>       case INDEX_op_nor:
>       case INDEX_op_or:
>       case INDEX_op_orc:
> -    case INDEX_op_rem_i32:
> -    case INDEX_op_rem_i64:
> +    case INDEX_op_rems:
>       case INDEX_op_xor:
>           {
>               const TCGOutOpBinary *out =
> diff --git a/tcg/tci.c b/tcg/tci.c
> index 65f493c3d4..6ca033f3be 100644
> --- a/tcg/tci.c
> +++ b/tcg/tci.c
> @@ -728,7 +728,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
>               tci_args_rrr(insn, &r0, &r1, &r2);
>               regs[r0] = (uint64_t)regs[r1] / (uint64_t)regs[r2];
>               break;
> -        case INDEX_op_rem_i64:
> +        case INDEX_op_rems:
>               tci_args_rrr(insn, &r0, &r1, &r2);
>               regs[r0] = (int64_t)regs[r1] % (int64_t)regs[r2];
>               break;
> @@ -1079,9 +1079,9 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
>       case INDEX_op_nor:
>       case INDEX_op_or:
>       case INDEX_op_orc:
> +    case INDEX_op_rems:
>       case INDEX_op_sub:
>       case INDEX_op_xor:
> -    case INDEX_op_rem_i64:
>       case INDEX_op_remu_i32:
>       case INDEX_op_remu_i64:
>       case INDEX_op_shl_i32:
> diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
> index 8f3b5e91b2..1f4160a585 100644
> --- a/docs/devel/tcg-ops.rst
> +++ b/docs/devel/tcg-ops.rst
> @@ -287,7 +287,7 @@ Arithmetic
>        - | *t0* = *t1* / *t2* (unsigned)
>          | Undefined behavior if division by zero.
>   
> -   * - rem_i32/i64 *t0*, *t1*, *t2*
> +   * - rems *t0*, *t1*, *t2*
>   
>        - | *t0* = *t1* % *t2* (signed)
>          | Undefined behavior if division by zero or overflow.
> diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
> index 4d9c142a00..2b05da7d06 100644
> --- a/tcg/tci/tcg-target.c.inc
> +++ b/tcg/tci/tcg-target.c.inc
> @@ -757,7 +757,7 @@ static void tgen_rems(TCGContext *s, TCGType type,
>   {
>       TCGOpcode opc = (type == TCG_TYPE_I32
>                        ? INDEX_op_tci_rems32
> -                     : INDEX_op_rem_i64);
> +                     : INDEX_op_rems);
>       tcg_out_op_rrr(s, opc, a0, a1, a2);
>   }
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


