Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8B1C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 21:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4nXL-0000rG-8L; Tue, 15 Apr 2025 17:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4nXA-0000cA-17
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:09:35 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4nX6-00008r-OZ
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:09:31 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-224019ad9edso80435385ad.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 14:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744751367; x=1745356167; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x7oTmitL3mo2GDcVf1oeDzxuSAqx3LnZ3URRWp4u1KU=;
 b=reOw5JhD5m2AO4lygRhHjiJ72z6eZEoSp34YhbIm6JYK5kKq4oUB5kH+MAyhPbV4Iy
 gLhp5pPGuobOenjs/23xPYb37ookT/wBSO4huvJrib1BrxE/kmTZJ/4QnlEJ1ojMcyfa
 O+vgtN6W1TiGYeky5mK5sf69/3DB27ThSVZhcjwgk0rbMnXywsBtDGVZtQekKd0AKIxL
 2ivqA6/i2Ge1IqFf6IVj97P8F75mV8CB3nUL+kje29Op22Yu/+z7jpI0vz+r5MEPteQu
 NXZAI7pf4jzzWBFqSA2p4QZ9J+Zgc8C5ePsY/hMz45R5falsMKX8Nx7/1Tj39VJp8nF/
 HJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744751367; x=1745356167;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x7oTmitL3mo2GDcVf1oeDzxuSAqx3LnZ3URRWp4u1KU=;
 b=HiDTqBv7BIwbmpC11CkFlbQvJjqh4MiKYCuWn1HwjGbbUZBvPwrMswf4nx8uXm6Uy2
 E8E0nolaSV1117l1jQqfS80KQhoKjiBV1rfCeOiVTB+EoK/synioVhxdKWEeDfJlZyaT
 NowD5xaiKnFq0hfGvpQ5qNna/5LF6wfiAih/Vyisk7fhpoQueq8Nj+FnXIvKYEy9aQSW
 tvCejm3GD9KZVI2JK1zt/SPbgUdLnuMgd3kCrzM0OTKKZY9zXWthrfCa5ChC1JDQDqkv
 FfB7LsMvfLBUV+uGIEB1jTWI5n/UqZAfLOQEe4/xZ0yB1PV+HkglPimrhNL+hAwKhF6V
 0RbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIWhNdpJFGzrKLKVG4XXRGk2FyFd348FJV7S6OJjsemTqCeCtDSRf0duGzpu1O+KjUmGSvGnOmOqCu@nongnu.org
X-Gm-Message-State: AOJu0YxOR9h3HZKnA14Q1Ah2+mR1cICF8V0ascvhIRCBxsc7WASeCpI5
 30ucd9M77J8nZQIo4lDIo418rqh+vimLON0+Zc3fYu84ZZSLILquyBnCZnPqPkc=
X-Gm-Gg: ASbGnctU4jhdXESsyIIzlNbqPixv/wIrNsegIBbJynY+tYf/5CS73ABTf6t6xggY048
 FvwvEOWVFD4Q2s8tozPjqSUGOihz3kQARC5VUWd8XFrDT5Ef3jctxhmNG4fwu9gQIwdtn2Lte1y
 PWFhAE+00z4S9QH9TKkOCkBNDs6g5WWhVdRHRS3Bwv7fhbf7RHMFl6T2gXXlAmQ+ASwwpMnf3ZA
 jLQ7gFegy/TT9a+ToNJl8SXmxxuFU6nDloejnboCxo/BB0MbdcnDuW+TrHs2rd1fVAInJEq0iaf
 V7BEJTzBmHxr2W/zJc5DMoT2ZWslWxi8FF0o8S97qcSUbq7gFFwhruz0rzpXM943
X-Google-Smtp-Source: AGHT+IFCmvjW61FKIW3QsHVivlTNOZFRiyOc7ksvk9AiUxA1Bhw6qN3Dj6/TkAkb7pGZ1MMUQJf8rA==
X-Received: by 2002:a17:902:f691:b0:224:1935:d9a3 with SMTP id
 d9443c01a7336-22c318cd6ecmr10548135ad.21.1744751367070; 
 Tue, 15 Apr 2025 14:09:27 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c95c99sm121992295ad.139.2025.04.15.14.09.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 14:09:26 -0700 (PDT)
Message-ID: <6d0116df-da76-4fe5-89b3-c44cdae5ab60@linaro.org>
Date: Tue, 15 Apr 2025 14:09:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 057/163] tcg: Convert sar to TCGOutOpBinary
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-58-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-58-richard.henderson@linaro.org>
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c                        |  6 ++-
>   tcg/aarch64/tcg-target.c.inc     | 37 ++++++++---------
>   tcg/arm/tcg-target.c.inc         | 26 ++++++++----
>   tcg/i386/tcg-target.c.inc        | 46 ++++++++++++---------
>   tcg/loongarch64/tcg-target.c.inc | 43 ++++++++++++--------
>   tcg/mips/tcg-target.c.inc        | 36 +++++++++++------
>   tcg/ppc/tcg-target.c.inc         | 40 +++++++++++--------
>   tcg/riscv/tcg-target.c.inc       | 38 ++++++++++--------
>   tcg/s390x/tcg-target.c.inc       | 68 ++++++++++++++------------------
>   tcg/sparc64/tcg-target.c.inc     | 37 +++++++++--------
>   tcg/tci/tcg-target.c.inc         | 17 +++++++-
>   11 files changed, 230 insertions(+), 164 deletions(-)
> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index b470665fa5..b5d7aeea83 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1042,6 +1042,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
>       OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
>       OUTOP(INDEX_op_rems, TCGOutOpBinary, outop_rems),
>       OUTOP(INDEX_op_remu, TCGOutOpBinary, outop_remu),
> +    OUTOP(INDEX_op_sar_i32, TCGOutOpBinary, outop_sar),
> +    OUTOP(INDEX_op_sar_i64, TCGOutOpBinary, outop_sar),
>       OUTOP(INDEX_op_shl, TCGOutOpBinary, outop_shl),
>       OUTOP(INDEX_op_shr, TCGOutOpBinary, outop_shr),
>       OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
> @@ -2264,7 +2266,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_st8_i32:
>       case INDEX_op_st16_i32:
>       case INDEX_op_st_i32:
> -    case INDEX_op_sar_i32:
>       case INDEX_op_extract_i32:
>       case INDEX_op_sextract_i32:
>       case INDEX_op_deposit_i32:
> @@ -2314,7 +2315,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_st16_i64:
>       case INDEX_op_st32_i64:
>       case INDEX_op_st_i64:
> -    case INDEX_op_sar_i64:
>       case INDEX_op_ext_i32_i64:
>       case INDEX_op_extu_i32_i64:
>       case INDEX_op_extract_i64:
> @@ -5418,6 +5418,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>       case INDEX_op_orc:
>       case INDEX_op_rems:
>       case INDEX_op_remu:
> +    case INDEX_op_sar_i32:
> +    case INDEX_op_sar_i64:
>       case INDEX_op_shl:
>       case INDEX_op_shr:
>       case INDEX_op_xor:
> diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
> index 87b97e852a..90bdbf8387 100644
> --- a/tcg/aarch64/tcg-target.c.inc
> +++ b/tcg/aarch64/tcg-target.c.inc
> @@ -1347,13 +1347,6 @@ static inline void tcg_out_extr(TCGContext *s, TCGType ext, TCGReg rd,
>       tcg_out_insn(s, 3403, EXTR, ext, rd, rn, rm, a);
>   }
>   
> -static inline void tcg_out_sar(TCGContext *s, TCGType ext,
> -                               TCGReg rd, TCGReg rn, unsigned int m)
> -{
> -    int max = ext ? 63 : 31;
> -    tcg_out_sbfm(s, ext, rd, rn, m & max, max);
> -}
> -
>   static inline void tcg_out_rotr(TCGContext *s, TCGType ext,
>                                   TCGReg rd, TCGReg rn, unsigned int m)
>   {
> @@ -2284,6 +2277,25 @@ static const TCGOutOpBinary outop_remu = {
>       .out_rrr = tgen_remu,
>   };
>   
> +static void tgen_sar(TCGContext *s, TCGType type,
> +                     TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tcg_out_insn(s, 3508, ASRV, type, a0, a1, a2);
> +}
> +
> +static void tgen_sari(TCGContext *s, TCGType type,
> +                      TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    int max = type == TCG_TYPE_I32 ? 31 : 63;
> +    tcg_out_sbfm(s, type, a0, a1, a2 & max, max);
> +}
> +
> +static const TCGOutOpBinary outop_sar = {
> +    .base.static_constraint = C_O1_I2(r, r, ri),
> +    .out_rrr = tgen_sar,
> +    .out_rri = tgen_sari,
> +};
> +
>   static void tgen_shl(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -2439,15 +2451,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
>           tcg_out_ldst(s, I3312_STRX, a0, a1, a2, 3);
>           break;
>   
> -    case INDEX_op_sar_i64:
> -    case INDEX_op_sar_i32:
> -        if (c2) {
> -            tcg_out_sar(s, ext, a0, a1, a2);
> -        } else {
> -            tcg_out_insn(s, 3508, ASRV, ext, a0, a1, a2);
> -        }
> -        break;
> -
>       case INDEX_op_rotr_i64:
>       case INDEX_op_rotr_i32:
>           if (c2) {
> @@ -3096,10 +3099,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_negsetcond_i64:
>           return C_O1_I2(r, r, rC);
>   
> -    case INDEX_op_sar_i32:
>       case INDEX_op_rotl_i32:
>       case INDEX_op_rotr_i32:
> -    case INDEX_op_sar_i64:
>       case INDEX_op_rotl_i64:
>       case INDEX_op_rotr_i64:
>           return C_O1_I2(r, r, ri);
> diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
> index 247aefd0a1..058677650b 100644
> --- a/tcg/arm/tcg-target.c.inc
> +++ b/tcg/arm/tcg-target.c.inc
> @@ -1963,6 +1963,25 @@ static const TCGOutOpBinary outop_remu = {
>       .base.static_constraint = C_NotImplemented,
>   };
>   
> +static void tgen_sar(TCGContext *s, TCGType type,
> +                     TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tcg_out_dat_reg(s, COND_AL, ARITH_MOV, a0, 0, a1, SHIFT_REG_ASR(a2));
> +}
> +
> +static void tgen_sari(TCGContext *s, TCGType type,
> +                      TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    tcg_out_dat_reg(s, COND_AL, ARITH_MOV, a0, 0, a1,
> +                    SHIFT_IMM_ASR(a2 & 0x1f));
> +}
> +
> +static const TCGOutOpBinary outop_sar = {
> +    .base.static_constraint = C_O1_I2(r, r, ri),
> +    .out_rrr = tgen_sar,
> +    .out_rri = tgen_sari,
> +};
> +
>   static void tgen_shl(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -2152,15 +2171,9 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       case INDEX_op_muls2_i32:
>           tcg_out_smull32(s, COND_AL, args[0], args[1], args[2], args[3]);
>           break;
> -    case INDEX_op_sar_i32:
> -        c = const_args[2] ? (args[2] & 0x1f) ? SHIFT_IMM_ASR(args[2] & 0x1f) :
> -                SHIFT_IMM_LSL(0) : SHIFT_REG_ASR(args[2]);
> -        goto gen_shift32;
>       case INDEX_op_rotr_i32:
>           c = const_args[2] ? (args[2] & 0x1f) ? SHIFT_IMM_ROR(args[2] & 0x1f) :
>                   SHIFT_IMM_LSL(0) : SHIFT_REG_ROR(args[2]);
> -        /* Fall through.  */
> -    gen_shift32:
>           tcg_out_dat_reg(s, COND_AL, ARITH_MOV, args[0], 0, args[1], c);
>           break;
>   
> @@ -2329,7 +2342,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_muls2_i32:
>           return C_O2_I2(r, r, r, r);
>   
> -    case INDEX_op_sar_i32:
>       case INDEX_op_rotl_i32:
>       case INDEX_op_rotr_i32:
>           return C_O1_I2(r, r, ri);
> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index 93d94e7881..1e81455461 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc
> @@ -2749,6 +2749,33 @@ static TCGConstraintSetIndex cset_shift(TCGType type, unsigned flags)
>       return have_bmi2 ? C_O1_I2(r, r, ri) : C_O1_I2(r, 0, ci);
>   }
>   
> +static void tgen_sar(TCGContext *s, TCGType type,
> +                     TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
> +    if (have_bmi2) {
> +        tcg_out_vex_modrm(s, OPC_SARX + rexw, a0, a2, a1);
> +    } else {
> +        tcg_out_modrm(s, OPC_SHIFT_cl + rexw, SHIFT_SAR, a0);
> +    }
> +}
> +
> +static void tgen_sari(TCGContext *s, TCGType type,
> +                      TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
> +
> +    tcg_out_mov(s, type, a0, a1);
> +    tcg_out_shifti(s, SHIFT_SAR + rexw, a0, a2);
> +}
> +
> +static const TCGOutOpBinary outop_sar = {
> +    .base.static_constraint = C_Dynamic,
> +    .base.dynamic_constraint = cset_shift,
> +    .out_rrr = tgen_sar,
> +    .out_rri = tgen_sari,
> +};
> +
>   static void tgen_shl(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -2874,7 +2901,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const int const_args[TCG_MAX_OP_ARGS])
>   {
>       TCGArg a0, a1, a2;
> -    int c, const_a2, vexop, rexw;
> +    int c, const_a2, rexw;
>   
>   #if TCG_TARGET_REG_BITS == 64
>   # define OP_32_64(x) \
> @@ -2949,25 +2976,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           }
>           break;
>   
> -    OP_32_64(sar):
> -        c = SHIFT_SAR;
> -        vexop = OPC_SARX;
> -        goto gen_shift_maybe_vex;
>       OP_32_64(rotl):
>           c = SHIFT_ROL;
>           goto gen_shift;
>       OP_32_64(rotr):
>           c = SHIFT_ROR;
>           goto gen_shift;
> -    gen_shift_maybe_vex:
> -        if (have_bmi2) {
> -            if (!const_a2) {
> -                tcg_out_vex_modrm(s, vexop + rexw, a0, a2, a1);
> -                break;
> -            }
> -            tcg_out_mov(s, rexw ? TCG_TYPE_I64 : TCG_TYPE_I32, a0, a1);
> -        }
> -        /* FALLTHRU */
>       gen_shift:
>           if (const_a2) {
>               tcg_out_shifti(s, c + rexw, a0, a2);
> @@ -3810,10 +3824,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_st_i64:
>           return C_O0_I2(re, r);
>   
> -    case INDEX_op_sar_i32:
> -    case INDEX_op_sar_i64:
> -        return have_bmi2 ? C_O1_I2(r, r, ri) : C_O1_I2(r, 0, ci);
> -
>       case INDEX_op_rotl_i32:
>       case INDEX_op_rotl_i64:
>       case INDEX_op_rotr_i32:
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index 9465b12ce0..45d31c76b5 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -1477,6 +1477,32 @@ static const TCGOutOpBinary outop_remu = {
>       .out_rrr = tgen_remu,
>   };
>   
> +static void tgen_sar(TCGContext *s, TCGType type,
> +                     TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    if (type == TCG_TYPE_I32) {
> +        tcg_out_opc_sra_w(s, a0, a1, a2);
> +    } else {
> +        tcg_out_opc_sra_d(s, a0, a1, a2);
> +    }
> +}
> +
> +static void tgen_sari(TCGContext *s, TCGType type,
> +                      TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    if (type == TCG_TYPE_I32) {
> +        tcg_out_opc_srai_w(s, a0, a1, a2 & 0x1f);
> +    } else {
> +        tcg_out_opc_srai_d(s, a0, a1, a2 & 0x3f);
> +    }
> +}
> +
> +static const TCGOutOpBinary outop_sar = {
> +    .base.static_constraint = C_O1_I2(r, r, ri),
> +    .out_rrr = tgen_sar,
> +    .out_rri = tgen_sari,
> +};
> +
>   static void tgen_shl(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -1700,21 +1726,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_clzctz(s, OPC_CTZ_D, a0, a1, a2, c2, false);
>           break;
>   
> -    case INDEX_op_sar_i32:
> -        if (c2) {
> -            tcg_out_opc_srai_w(s, a0, a1, a2 & 0x1f);
> -        } else {
> -            tcg_out_opc_sra_w(s, a0, a1, a2);
> -        }
> -        break;
> -    case INDEX_op_sar_i64:
> -        if (c2) {
> -            tcg_out_opc_srai_d(s, a0, a1, a2 & 0x3f);
> -        } else {
> -            tcg_out_opc_sra_d(s, a0, a1, a2);
> -        }
> -        break;
> -
>       case INDEX_op_rotl_i32:
>           /* transform into equivalent rotr/rotri */
>           if (c2) {
> @@ -2385,8 +2396,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_qemu_ld_i64:
>           return C_O1_I1(r, r);
>   
> -    case INDEX_op_sar_i32:
> -    case INDEX_op_sar_i64:
>       case INDEX_op_rotl_i32:
>       case INDEX_op_rotl_i64:
>       case INDEX_op_rotr_i32:
> diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
> index 03b4248ea9..16c3d59c19 100644
> --- a/tcg/mips/tcg-target.c.inc
> +++ b/tcg/mips/tcg-target.c.inc
> @@ -1908,6 +1908,29 @@ static const TCGOutOpBinary outop_remu = {
>       .out_rrr = tgen_remu,
>   };
>   
> +static void tgen_sar(TCGContext *s, TCGType type,
> +                     TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    MIPSInsn insn = type == TCG_TYPE_I32 ? OPC_SRAV : OPC_DSRAV;
> +    tcg_out_opc_reg(s, insn, a0, a1, a2);
> +}
> +
> +static void tgen_sari(TCGContext *s, TCGType type,
> +                      TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    if (type == TCG_TYPE_I32) {
> +        tcg_out_opc_sa(s, OPC_SRA, a0, a1, a2);
> +    } else {
> +        tcg_out_dsra(s, a0, a1, a2);
> +    }
> +}
> +
> +static const TCGOutOpBinary outop_sar = {
> +    .base.static_constraint = C_O1_I2(r, r, ri),
> +    .out_rrr = tgen_sar,
> +    .out_rri = tgen_sari,
> +};
> +
>   static void tgen_shl(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -2111,12 +2134,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_dsra(s, a0, a1, 32);
>           break;
>   
> -    case INDEX_op_sar_i32:
> -        i1 = OPC_SRAV, i2 = OPC_SRA;
> -        goto do_shift;
>       case INDEX_op_rotr_i32:
>           i1 = OPC_ROTRV, i2 = OPC_ROTR;
> -    do_shift:
>           if (c2) {
>               tcg_out_opc_sa(s, i2, a0, a1, a2);
>               break;
> @@ -2132,13 +2151,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>               tcg_out_opc_reg(s, OPC_ROTRV, a0, TCG_TMP0, a1);
>           }
>           break;
> -    case INDEX_op_sar_i64:
> -        if (c2) {
> -            tcg_out_dsra(s, a0, a1, a2);
> -            break;
> -        }
> -        i1 = OPC_DSRAV;
> -        goto do_shiftv;
>       case INDEX_op_rotr_i64:
>           if (c2) {
>               tcg_out_opc_sa64(s, OPC_DROTR, OPC_DROTR32, a0, a1, a2);
> @@ -2319,10 +2331,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_muls2_i64:
>       case INDEX_op_mulu2_i64:
>           return C_O2_I2(r, r, r, r);
> -    case INDEX_op_sar_i32:
>       case INDEX_op_rotr_i32:
>       case INDEX_op_rotl_i32:
> -    case INDEX_op_sar_i64:
>       case INDEX_op_rotr_i64:
>       case INDEX_op_rotl_i64:
>           return C_O1_I2(r, r, ri);
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index 2012734bb3..24e8f675bb 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -3122,6 +3122,30 @@ static const TCGOutOpBinary outop_remu = {
>       .out_rrr = tgen_remu,
>   };
>   
> +static void tgen_sar(TCGContext *s, TCGType type,
> +                     TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    uint32_t insn = type == TCG_TYPE_I32 ? SRAW : SRAD;
> +    tcg_out32(s, insn | SAB(a1, a0, a2));
> +}
> +
> +static void tgen_sari(TCGContext *s, TCGType type,
> +                      TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    /* Limit immediate shift count lest we create an illegal insn.  */
> +    if (type == TCG_TYPE_I32) {
> +        tcg_out_sari32(s, a0, a1, a2 & 31);
> +    } else {
> +        tcg_out_sari64(s, a0, a1, a2 & 63);
> +    }
> +}
> +
> +static const TCGOutOpBinary outop_sar = {
> +    .base.static_constraint = C_O1_I2(r, r, ri),
> +    .out_rrr = tgen_sar,
> +    .out_rri = tgen_sari,
> +};
> +
>   static void tgen_shl(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -3320,13 +3344,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out32(s, CNTPOPD | SAB(args[1], args[0], 0));
>           break;
>   
> -    case INDEX_op_sar_i32:
> -        if (const_args[2]) {
> -            tcg_out_sari32(s, args[0], args[1], args[2]);
> -        } else {
> -            tcg_out32(s, SRAW | SAB(args[1], args[0], args[2]));
> -        }
> -        break;
>       case INDEX_op_rotl_i32:
>           if (const_args[2]) {
>               tcg_out_rlw(s, RLWINM, args[0], args[1], args[2], 0, 31);
> @@ -3357,13 +3374,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_brcond2(s, args, const_args);
>           break;
>   
> -    case INDEX_op_sar_i64:
> -        if (const_args[2]) {
> -            tcg_out_sari64(s, args[0], args[1], args[2]);
> -        } else {
> -            tcg_out32(s, SRAD | SAB(args[1], args[0], args[2]));
> -        }
> -        break;
>       case INDEX_op_rotl_i64:
>           if (const_args[2]) {
>               tcg_out_rld(s, RLDICL, args[0], args[1], args[2], 0);
> @@ -4222,10 +4232,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_st_i64:
>           return C_O0_I2(r, r);
>   
> -    case INDEX_op_sar_i32:
>       case INDEX_op_rotl_i32:
>       case INDEX_op_rotr_i32:
> -    case INDEX_op_sar_i64:
>       case INDEX_op_rotl_i64:
>       case INDEX_op_rotr_i64:
>           return C_O1_I2(r, r, ri);
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index 8020cc0b3f..8cab07a392 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -2144,6 +2144,27 @@ static const TCGOutOpBinary outop_remu = {
>       .out_rrr = tgen_remu,
>   };
>   
> +static void tgen_sar(TCGContext *s, TCGType type,
> +                     TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_SRAW : OPC_SRA;
> +    tcg_out_opc_reg(s, insn, a0, a1, a2);
> +}
> +
> +static void tgen_sari(TCGContext *s, TCGType type,
> +                      TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_SRAIW : OPC_SRAI;
> +    unsigned mask = type == TCG_TYPE_I32 ? 31 : 63;
> +    tcg_out_opc_imm(s, insn, a0, a1, a2 & mask);
> +}
> +
> +static const TCGOutOpBinary outop_sar = {
> +    .base.static_constraint = C_O1_I2(r, r, ri),
> +    .out_rrr = tgen_sar,
> +    .out_rri = tgen_sari,
> +};
> +
>   static void tgen_shl(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -2299,21 +2320,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_ldst(s, OPC_SD, a0, a1, a2);
>           break;
>   
> -    case INDEX_op_sar_i32:
> -        if (c2) {
> -            tcg_out_opc_imm(s, OPC_SRAIW, a0, a1, a2 & 0x1f);
> -        } else {
> -            tcg_out_opc_reg(s, OPC_SRAW, a0, a1, a2);
> -        }
> -        break;
> -    case INDEX_op_sar_i64:
> -        if (c2) {
> -            tcg_out_opc_imm(s, OPC_SRAI, a0, a1, a2 & 0x3f);
> -        } else {
> -            tcg_out_opc_reg(s, OPC_SRA, a0, a1, a2);
> -        }
> -        break;
> -
>       case INDEX_op_rotl_i32:
>           if (c2) {
>               tcg_out_opc_imm(s, OPC_RORIW, a0, a1, -a2 & 0x1f);
> @@ -2770,10 +2776,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_negsetcond_i64:
>           return C_O1_I2(r, r, rI);
>   
> -    case INDEX_op_sar_i32:
>       case INDEX_op_rotl_i32:
>       case INDEX_op_rotr_i32:
> -    case INDEX_op_sar_i64:
>       case INDEX_op_rotl_i64:
>       case INDEX_op_rotr_i64:
>           return C_O1_I2(r, r, ri);
> diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
> index 0417bbef50..1cf4920276 100644
> --- a/tcg/s390x/tcg-target.c.inc
> +++ b/tcg/s390x/tcg-target.c.inc
> @@ -2445,6 +2445,36 @@ static const TCGOutOpBinary outop_remu = {
>       .base.static_constraint = C_NotImplemented,
>   };
>   
> +static void tgen_sar_int(TCGContext *s, TCGType type, TCGReg dst,
> +                         TCGReg src, TCGReg v, tcg_target_long i)
> +{
> +    if (type != TCG_TYPE_I32) {
> +        tcg_out_sh64(s, RSY_SRAG, dst, src, v, i);
> +    } else if (dst == src) {
> +        tcg_out_sh32(s, RS_SRA, dst, v, i);
> +    } else {
> +        tcg_out_sh64(s, RSY_SRAK, dst, src, v, i);
> +    }
> +}
> +
> +static void tgen_sar(TCGContext *s, TCGType type,
> +                     TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tgen_sar_int(s, type, a0, a1, a2, 0);
> +}
> +
> +static void tgen_sari(TCGContext *s, TCGType type,
> +                      TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    tgen_sar_int(s, type, a0, a1, TCG_REG_NONE, a2);
> +}
> +
> +static const TCGOutOpBinary outop_sar = {
> +    .base.static_constraint = C_O1_I2(r, r, ri),
> +    .out_rrr = tgen_sar,
> +    .out_rri = tgen_sari,
> +};
> +
>   static void tgen_shl_int(TCGContext *s, TCGType type, TCGReg dst,
>                            TCGReg src, TCGReg v, tcg_target_long i)
>   {
> @@ -2586,7 +2616,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const TCGArg args[TCG_MAX_OP_ARGS],
>                          const int const_args[TCG_MAX_OP_ARGS])
>   {
> -    S390Opcode op, op2;
>       TCGArg a0, a1, a2;
>   
>       switch (opc) {
> @@ -2634,28 +2663,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_st(s, TCG_TYPE_I32, args[0], args[1], args[2]);
>           break;
>   
> -    do_shift32:
> -        a0 = args[0], a1 = args[1], a2 = (int32_t)args[2];
> -        if (a0 == a1) {
> -            if (const_args[2]) {
> -                tcg_out_sh32(s, op, a0, TCG_REG_NONE, a2);
> -            } else {
> -                tcg_out_sh32(s, op, a0, a2, 0);
> -            }
> -        } else {
> -            /* Using tcg_out_sh64 here for the format; it is a 32-bit shift.  */
> -            if (const_args[2]) {
> -                tcg_out_sh64(s, op2, a0, a1, TCG_REG_NONE, a2);
> -            } else {
> -                tcg_out_sh64(s, op2, a0, a1, a2, 0);
> -            }
> -        }
> -        break;
> -    case INDEX_op_sar_i32:
> -        op = RS_SRA;
> -        op2 = RSY_SRAK;
> -        goto do_shift32;
> -
>       case INDEX_op_rotl_i32:
>           /* ??? Using tcg_out_sh64 here for the format; it is a 32-bit rol.  */
>           if (const_args[2]) {
> @@ -2799,17 +2806,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_insn(s, RRFa, MGRK, args[1], args[2], args[3]);
>           break;
>   
> -    do_shift64:
> -        if (const_args[2]) {
> -            tcg_out_sh64(s, op, args[0], args[1], TCG_REG_NONE, args[2]);
> -        } else {
> -            tcg_out_sh64(s, op, args[0], args[1], args[2], 0);
> -        }
> -        break;
> -    case INDEX_op_sar_i64:
> -        op = RSY_SRAG;
> -        goto do_shift64;
> -
>       case INDEX_op_rotl_i64:
>           if (const_args[2]) {
>               tcg_out_sh64(s, RSY_RLLG, args[0], args[1],
> @@ -3394,7 +3390,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_st_i64:
>           return C_O0_I2(r, r);
>   
> -    case INDEX_op_sar_i64:
>       case INDEX_op_rotl_i32:
>       case INDEX_op_rotl_i64:
>       case INDEX_op_rotr_i32:
> @@ -3409,9 +3404,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_clz_i64:
>           return C_O1_I2(r, r, rI);
>   
> -    case INDEX_op_sar_i32:
> -        return C_O1_I2(r, r, ri);
> -
>       case INDEX_op_brcond_i32:
>           return C_O0_I2(r, ri);
>       case INDEX_op_brcond_i64:
> diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
> index f679fa04ea..42d81c1e6c 100644
> --- a/tcg/sparc64/tcg-target.c.inc
> +++ b/tcg/sparc64/tcg-target.c.inc
> @@ -1484,6 +1484,27 @@ static const TCGOutOpBinary outop_remu = {
>       .base.static_constraint = C_NotImplemented,
>   };
>   
> +static void tgen_sar(TCGContext *s, TCGType type,
> +                     TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    uint32_t insn = type == TCG_TYPE_I32 ? SHIFT_SRA : SHIFT_SRAX;
> +    tcg_out_arith(s, a0, a1, a2, insn);
> +}
> +
> +static void tgen_sari(TCGContext *s, TCGType type,
> +                      TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    uint32_t insn = type == TCG_TYPE_I32 ? SHIFT_SRA : SHIFT_SRAX;
> +    uint32_t mask = type == TCG_TYPE_I32 ? 31 : 63;
> +    tcg_out_arithi(s, a0, a1, a2 & mask, insn);
> +}
> +
> +static const TCGOutOpBinary outop_sar = {
> +    .base.static_constraint = C_O1_I2(r, r, rJ),
> +    .out_rrr = tgen_sar,
> +    .out_rri = tgen_sari,
> +};
> +
>   static void tgen_shl(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -1629,13 +1650,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       case INDEX_op_st32_i64:
>           tcg_out_ldst(s, a0, a1, a2, STW);
>           break;
> -    do_shift32:
> -        /* Limit immediate shift count lest we create an illegal insn.  */
> -        tcg_out_arithc(s, a0, a1, a2 & 31, c2, c);
> -        break;
> -    case INDEX_op_sar_i32:
> -        c = SHIFT_SRA;
> -        goto do_shift32;
>   
>       case INDEX_op_brcond_i32:
>           tcg_out_brcond_i32(s, a2, a0, a1, const_args[1], arg_label(args[3]));
> @@ -1693,13 +1707,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       case INDEX_op_st_i64:
>           tcg_out_ldst(s, a0, a1, a2, STX);
>           break;
> -    do_shift64:
> -        /* Limit immediate shift count lest we create an illegal insn.  */
> -        tcg_out_arithc(s, a0, a1, a2 & 63, c2, c);
> -        break;
> -    case INDEX_op_sar_i64:
> -        c = SHIFT_SRAX;
> -        goto do_shift64;
>   
>       case INDEX_op_brcond_i64:
>           tcg_out_brcond_i64(s, a2, a0, a1, const_args[1], arg_label(args[3]));
> @@ -1783,8 +1790,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_qemu_st_i64:
>           return C_O0_I2(rz, r);
>   
> -    case INDEX_op_sar_i32:
> -    case INDEX_op_sar_i64:
>       case INDEX_op_setcond_i32:
>       case INDEX_op_setcond_i64:
>       case INDEX_op_negsetcond_i32:
> diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
> index c0dbe873f1..f50a2d6574 100644
> --- a/tcg/tci/tcg-target.c.inc
> +++ b/tcg/tci/tcg-target.c.inc
> @@ -79,8 +79,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_st_i64:
>           return C_O0_I2(r, r);
>   
> -    case INDEX_op_sar_i32:
> -    case INDEX_op_sar_i64:
>       case INDEX_op_rotl_i32:
>       case INDEX_op_rotl_i64:
>       case INDEX_op_rotr_i32:
> @@ -774,6 +772,21 @@ static const TCGOutOpBinary outop_remu = {
>       .out_rrr = tgen_remu,
>   };
>   
> +static void tgen_sar(TCGContext *s, TCGType type,
> +                     TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    if (type < TCG_TYPE_REG) {
> +        tcg_out_ext32s(s, TCG_REG_TMP, a1);
> +        a1 = TCG_REG_TMP;
> +    }
> +    tcg_out_op_rrr(s, glue(INDEX_op_sar_i,TCG_TARGET_REG_BITS), a0, a1, a2);
> +}
> +
> +static const TCGOutOpBinary outop_sar = {
> +    .base.static_constraint = C_O1_I2(r, r, r),
> +    .out_rrr = tgen_sar,
> +};
> +
>   static void tgen_shl(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


