Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C6AC369B8
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 21:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4nUR-0005Jl-2p; Tue, 15 Apr 2025 17:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4nUO-0005Ek-Nc
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:06:40 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4nTs-0006tt-DL
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:06:40 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2264aefc45dso90159505ad.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 14:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744751165; x=1745355965; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EhQyQqeOIvCMMa/vQ2WKAdEbYASCrhppVGpr2D6WCR4=;
 b=gsO9czRJ+57mJMp7P2gOs5xBhLyg5GFyG8suUdcFiFu2uhUtLLMh4cC5u1tjs7TbYA
 xAmfSrNaPWk4dUzUGP/KBCYNG5oCHxtkhCGieUgw3y09etpxirYthsqN1e48yhLCUwm9
 0MKcb2uQbTFJlu3D1Ll6G0+7pHEOXbO0y5qYBBaxATrBfRd1hzl2E/E8+eTe2JADhbfm
 Li9EZ20kuAb78Mimp8ECXmtvFxz7J0FeIMeFZITAA0oCOqIY4GeE4XFoS0RUj9w75TaR
 42Ppkxuqgum9wIyNrlQVYp2luFSFOCbT8pXGNIKpDDy0pOY/SYi+bRVdR5OAoWEBbwIC
 ozMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744751165; x=1745355965;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EhQyQqeOIvCMMa/vQ2WKAdEbYASCrhppVGpr2D6WCR4=;
 b=mpvMRWmC7mSJKYbzv6dCoC1xoGqnSqj/O1BgA5WymeJ8rzChS5KuVmZcO6Y3PRqSaA
 djeXapH4ArI5ch06Fy4GHQNo+llJrzNe4UtlKCfsxfewp/MuavoEPIMaiFAqHEeZFdDv
 Ao77HXcr7XeEZOWem1zhXdsfo8iasSWw2MucFXBcK+xq4CXhS20egnfUl+FlLBlGVEES
 gAo9gcDjmVaXTaoVm+oRjmWgVfU6A/h7+N20mQmffDg71UkprrB2cVypQKDEiHzqRAuA
 NiYoArUFn2yVQH4vvBaGyG0jen9KLOfoa/a87XAtvScKD3lfAAA9BBdPzwomIPzaO19c
 d7IQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpveelUezjSEARnP1soyFlpuRF5DycSO2afryIoY2/blqPk6yNdASEUcRdOK+ITkh+UiY/cGcRGGCE@nongnu.org
X-Gm-Message-State: AOJu0YzltVInFn/VpBHN5JhFOcarsfUIx864UdY2dfEXHjxMJR8ZVWCv
 F1rMW6Ic798mjdfaDuZaW8JvIz4cCgDmI5qyWnXjmU/0nnnVTmd4l9+XTAxvWt4=
X-Gm-Gg: ASbGncvFUOO5XFKN3/FPukQ5XObgYsrNnixoNltXqhngHWIti0Rx+6VMlb9y/qP+guy
 FgwJ4RFRovEoobm2AF61NTeKFOn2Vg6XauNPemz0mRLUkQCHLhMnAw8f7/tJu1A8u2kMitDBzR2
 6vZDW5ESrGgU19a5hRYcm5RezQMK+LLf7q2dcaf58udvJoRue6+WC2JnXvnjNhZal4UxQFcFGox
 GDU7QkjacSWRGFTAiEwXNayYXNPDg1gIz+GjXs6+A3YCoBDcaB4QWSj6O5RDHbw3gpVkTPh9LQz
 JVWeeK1MbT/VDzxOF6OjZRlMVKSesK9htm/BwQp2GsUlBFrHrnjqmQ==
X-Google-Smtp-Source: AGHT+IGvIzrRW0nEP3GXc3o4zBdoRVdrLnu3h+yQq/6ohHf6QSm6CCLJCsJ3zywuFkdTPegTKa0MSQ==
X-Received: by 2002:a17:902:ebc8:b0:223:377f:9795 with SMTP id
 d9443c01a7336-22c316d681amr11890445ad.0.1744751165174; 
 Tue, 15 Apr 2025 14:06:05 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7b8ea6csm122956415ad.97.2025.04.15.14.06.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 14:06:04 -0700 (PDT)
Message-ID: <b760bf2d-2b97-4633-9313-809c3294b498@linaro.org>
Date: Tue, 15 Apr 2025 14:06:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 049/163] tcg: Convert rem to TCGOutOpBinary
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-50-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-50-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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
> For TCI, we're losing type information in the interpreter.
> Introduce a tci-specific opcode to handle the difference.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c                        |  6 ++++--
>   tcg/tci.c                        |  4 ++--
>   tcg/aarch64/tcg-target.c.inc     | 19 ++++++++++------
>   tcg/arm/tcg-target.c.inc         |  4 ++++
>   tcg/i386/tcg-target.c.inc        |  4 ++++
>   tcg/loongarch64/tcg-target.c.inc | 24 +++++++++++++--------
>   tcg/mips/tcg-target.c.inc        | 37 ++++++++++++++++++--------------
>   tcg/ppc/tcg-target.c.inc         | 27 +++++++++++++++--------
>   tcg/riscv/tcg-target.c.inc       | 21 ++++++++++--------
>   tcg/s390x/tcg-target.c.inc       |  4 ++++
>   tcg/sparc64/tcg-target.c.inc     |  4 ++++
>   tcg/tci/tcg-target-opc.h.inc     |  1 +
>   tcg/tci/tcg-target.c.inc         | 17 ++++++++++++---
>   13 files changed, 115 insertions(+), 57 deletions(-)
> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 272c59455b..5e5082b3cd 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1040,6 +1040,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
>       OUTOP(INDEX_op_not, TCGOutOpUnary, outop_not),
>       OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
>       OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
> +    OUTOP(INDEX_op_rem_i32, TCGOutOpBinary, outop_rems),
> +    OUTOP(INDEX_op_rem_i64, TCGOutOpBinary, outop_rems),
>       OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
>       OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
>   };
> @@ -2270,7 +2272,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
>   
>       case INDEX_op_negsetcond_i32:
>           return TCG_TARGET_HAS_negsetcond_i32;
> -    case INDEX_op_rem_i32:
>       case INDEX_op_remu_i32:
>           return TCG_TARGET_HAS_rem_i32;
>       case INDEX_op_rotl_i32:
> @@ -2327,7 +2328,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
>   
>       case INDEX_op_negsetcond_i64:
>           return TCG_TARGET_HAS_negsetcond_i64;
> -    case INDEX_op_rem_i64:
>       case INDEX_op_remu_i64:
>           return TCG_TARGET_HAS_rem_i64;
>       case INDEX_op_rotl_i64:
> @@ -5422,6 +5422,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>       case INDEX_op_nor:
>       case INDEX_op_or:
>       case INDEX_op_orc:
> +    case INDEX_op_rem_i32:
> +    case INDEX_op_rem_i64:
>       case INDEX_op_xor:
>           {
>               const TCGOutOpBinary *out =
> diff --git a/tcg/tci.c b/tcg/tci.c
> index bf97849bfe..65f493c3d4 100644
> --- a/tcg/tci.c
> +++ b/tcg/tci.c
> @@ -586,7 +586,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
>               tci_args_rrr(insn, &r0, &r1, &r2);
>               regs[r0] = (uint32_t)regs[r1] / (uint32_t)regs[r2];
>               break;
> -        case INDEX_op_rem_i32:
> +        case INDEX_op_tci_rems32:
>               tci_args_rrr(insn, &r0, &r1, &r2);
>               regs[r0] = (int32_t)regs[r1] % (int32_t)regs[r2];
>               break;
> @@ -1081,7 +1081,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
>       case INDEX_op_orc:
>       case INDEX_op_sub:
>       case INDEX_op_xor:
> -    case INDEX_op_rem_i32:
>       case INDEX_op_rem_i64:
>       case INDEX_op_remu_i32:
>       case INDEX_op_remu_i64:
> @@ -1101,6 +1100,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
>       case INDEX_op_ctz_i64:
>       case INDEX_op_tci_divs32:
>       case INDEX_op_tci_divu32:
> +    case INDEX_op_tci_rems32:
>           tci_args_rrr(insn, &r0, &r1, &r2);
>           info->fprintf_func(info->stream, "%-12s  %s, %s, %s",
>                              op_name, str_r(r0), str_r(r1), str_r(r2));
> diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
> index 456159cdc6..6e80e18a6a 100644
> --- a/tcg/aarch64/tcg-target.c.inc
> +++ b/tcg/aarch64/tcg-target.c.inc
> @@ -2275,6 +2275,18 @@ static const TCGOutOpBinary outop_orc = {
>       .out_rrr = tgen_orc,
>   };
>   
> +static void tgen_rems(TCGContext *s, TCGType type,
> +                      TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tcg_out_insn(s, 3508, SDIV, type, TCG_REG_TMP0, a1, a2);
> +    tcg_out_insn(s, 3509, MSUB, type, a0, TCG_REG_TMP0, a2, a1);
> +}
> +
> +static const TCGOutOpBinary outop_rems = {
> +    .base.static_constraint = C_O1_I2(r, r, r),
> +    .out_rrr = tgen_rems,
> +};
> +
>   static void tgen_sub(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -2392,11 +2404,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
>           tcg_out_ldst(s, I3312_STRX, a0, a1, a2, 3);
>           break;
>   
> -    case INDEX_op_rem_i64:
> -    case INDEX_op_rem_i32:
> -        tcg_out_insn(s, 3508, SDIV, ext, TCG_REG_TMP0, a1, a2);
> -        tcg_out_insn(s, 3509, MSUB, ext, a0, TCG_REG_TMP0, a2, a1);
> -        break;
>       case INDEX_op_remu_i64:
>       case INDEX_op_remu_i32:
>           tcg_out_insn(s, 3508, UDIV, ext, TCG_REG_TMP0, a1, a2);
> @@ -3078,8 +3085,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_negsetcond_i64:
>           return C_O1_I2(r, r, rC);
>   
> -    case INDEX_op_rem_i32:
> -    case INDEX_op_rem_i64:
>       case INDEX_op_remu_i32:
>       case INDEX_op_remu_i64:
>           return C_O1_I2(r, r, r);
> diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
> index b2c08bba3e..673c8fb7a6 100644
> --- a/tcg/arm/tcg-target.c.inc
> +++ b/tcg/arm/tcg-target.c.inc
> @@ -1955,6 +1955,10 @@ static const TCGOutOpBinary outop_orc = {
>       .base.static_constraint = C_NotImplemented,
>   };
>   
> +static const TCGOutOpBinary outop_rems = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
>   static void tgen_sub(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index 0e6b743fb2..ac0721d71c 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc
> @@ -2736,6 +2736,10 @@ static const TCGOutOpBinary outop_orc = {
>       .base.static_constraint = C_NotImplemented,
>   };
>   
> +static const TCGOutOpBinary outop_rems = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
>   static void tgen_sub(TCGContext *s, TCGType type,
>                         TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index 2f9b0969ee..1049563f80 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -1447,6 +1447,21 @@ static const TCGOutOpBinary outop_orc = {
>       .out_rrr = tgen_orc,
>   };
>   
> +static void tgen_rems(TCGContext *s, TCGType type,
> +                      TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    if (type == TCG_TYPE_I32) {
> +        tcg_out_opc_mod_w(s, a0, a1, a2);
> +    } else {
> +        tcg_out_opc_mod_d(s, a0, a1, a2);
> +    }
> +}
> +
> +static const TCGOutOpBinary outop_rems = {
> +    .base.static_constraint = C_O1_I2(r, r, r),
> +    .out_rrr = tgen_rems,
> +};
> +
>   static void tgen_sub(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -1697,13 +1712,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           }
>           break;
>   
> -    case INDEX_op_rem_i32:
> -        tcg_out_opc_mod_w(s, a0, a1, a2);
> -        break;
> -    case INDEX_op_rem_i64:
> -        tcg_out_opc_mod_d(s, a0, a1, a2);
> -        break;
> -
>       case INDEX_op_remu_i32:
>           tcg_out_opc_mod_wu(s, a0, a1, a2);
>           break;
> @@ -2375,8 +2383,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_setcond_i64:
>           return C_O1_I2(r, rz, rJ);
>   
> -    case INDEX_op_rem_i32:
> -    case INDEX_op_rem_i64:
>       case INDEX_op_remu_i32:
>       case INDEX_op_remu_i64:
>           return C_O1_I2(r, rz, rz);
> diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
> index 280afbf297..37b878ec61 100644
> --- a/tcg/mips/tcg-target.c.inc
> +++ b/tcg/mips/tcg-target.c.inc
> @@ -1866,6 +1866,27 @@ static const TCGOutOpBinary outop_orc = {
>       .base.static_constraint = C_NotImplemented,
>   };
>   
> +static void tgen_rems(TCGContext *s, TCGType type,
> +                      TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    if (use_mips32r6_instructions) {
> +        if (type == TCG_TYPE_I32) {
> +            tcg_out_opc_reg(s, OPC_MOD, a0, a1, a2);
> +        } else {
> +            tcg_out_opc_reg(s, OPC_DMOD, a0, a1, a2);
> +        }
> +    } else {
> +        MIPSInsn insn = type == TCG_TYPE_I32 ? OPC_DIV : OPC_DDIV;
> +        tcg_out_opc_reg(s, insn, 0, a1, a2);
> +        tcg_out_opc_reg(s, OPC_MFHI, a0, 0, 0);
> +    }
> +}
> +
> +static const TCGOutOpBinary outop_rems = {
> +    .base.static_constraint = C_O1_I2(r, r, r),
> +    .out_rrr = tgen_rems,
> +};
> +
>   static void tgen_sub(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -1989,13 +2010,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_ldst(s, i1, a0, a1, a2);
>           break;
>   
> -    case INDEX_op_rem_i32:
> -        if (use_mips32r6_instructions) {
> -            tcg_out_opc_reg(s, OPC_MOD, a0, a1, a2);
> -            break;
> -        }
> -        i1 = OPC_DIV, i2 = OPC_MFHI;
> -        goto do_hilo1;
>       case INDEX_op_remu_i32:
>           if (use_mips32r6_instructions) {
>               tcg_out_opc_reg(s, OPC_MODU, a0, a1, a2);
> @@ -2003,13 +2017,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           }
>           i1 = OPC_DIVU, i2 = OPC_MFHI;
>           goto do_hilo1;
> -    case INDEX_op_rem_i64:
> -        if (use_mips32r6_instructions) {
> -            tcg_out_opc_reg(s, OPC_DMOD, a0, a1, a2);
> -            break;
> -        }
> -        i1 = OPC_DDIV, i2 = OPC_MFHI;
> -        goto do_hilo1;
>       case INDEX_op_remu_i64:
>           if (use_mips32r6_instructions) {
>               tcg_out_opc_reg(s, OPC_DMODU, a0, a1, a2);
> @@ -2275,10 +2282,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_st_i64:
>           return C_O0_I2(rz, r);
>   
> -    case INDEX_op_rem_i32:
>       case INDEX_op_remu_i32:
>       case INDEX_op_setcond_i32:
> -    case INDEX_op_rem_i64:
>       case INDEX_op_remu_i64:
>       case INDEX_op_setcond_i64:
>           return C_O1_I2(r, rz, rz);
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index 8b14d57d1c..c331f0d672 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -3091,6 +3091,24 @@ static const TCGOutOpBinary outop_orc = {
>       .out_rrr = tgen_orc,
>   };
>   
> +static TCGConstraintSetIndex cset_mod(TCGType type, unsigned flags)
> +{
> +    return have_isa_3_00 ? C_O1_I2(r, r, r) : C_NotImplemented;
> +}
> +
> +static void tgen_rems(TCGContext *s, TCGType type,
> +                      TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    uint32_t insn = type == TCG_TYPE_I32 ? MODSW : MODSD;
> +    tcg_out32(s, insn | TAB(a0, a1, a2));
> +}
> +
> +static const TCGOutOpBinary outop_rems = {
> +    .base.static_constraint = C_Dynamic,
> +    .base.dynamic_constraint = cset_mod,
> +    .out_rrr = tgen_rems,
> +};
> +
>   static void tgen_sub(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -3241,10 +3259,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out32(s, CNTPOPD | SAB(args[1], args[0], 0));
>           break;
>   
> -    case INDEX_op_rem_i32:
> -        tcg_out32(s, MODSW | TAB(args[0], args[1], args[2]));
> -        break;
> -
>       case INDEX_op_remu_i32:
>           tcg_out32(s, MODUW | TAB(args[0], args[1], args[2]));
>           break;
> @@ -3341,9 +3355,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           }
>           break;
>   
> -    case INDEX_op_rem_i64:
> -        tcg_out32(s, MODSD | TAB(args[0], args[1], args[2]));
> -        break;
>       case INDEX_op_remu_i64:
>           tcg_out32(s, MODUD | TAB(args[0], args[1], args[2]));
>           break;
> @@ -4202,9 +4213,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_rotr_i64:
>           return C_O1_I2(r, r, ri);
>   
> -    case INDEX_op_rem_i32:
>       case INDEX_op_remu_i32:
> -    case INDEX_op_rem_i64:
>       case INDEX_op_remu_i64:
>           return C_O1_I2(r, r, r);
>   
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index 72910b0f25..b0a98273f1 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -2120,6 +2120,18 @@ static const TCGOutOpBinary outop_orc = {
>       .out_rrr = tgen_orc,
>   };
>   
> +static void tgen_rems(TCGContext *s, TCGType type,
> +                      TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_REMW : OPC_REM;
> +    tcg_out_opc_reg(s, insn, a0, a1, a2);
> +}
> +
> +static const TCGOutOpBinary outop_rems = {
> +    .base.static_constraint = C_O1_I2(r, r, r),
> +    .out_rrr = tgen_rems,
> +};
> +
>   static void tgen_sub(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -2233,13 +2245,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_ldst(s, OPC_SD, a0, a1, a2);
>           break;
>   
> -    case INDEX_op_rem_i32:
> -        tcg_out_opc_reg(s, OPC_REMW, a0, a1, a2);
> -        break;
> -    case INDEX_op_rem_i64:
> -        tcg_out_opc_reg(s, OPC_REM, a0, a1, a2);
> -        break;
> -
>       case INDEX_op_remu_i32:
>           tcg_out_opc_reg(s, OPC_REMUW, a0, a1, a2);
>           break;
> @@ -2748,9 +2753,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_negsetcond_i64:
>           return C_O1_I2(r, r, rI);
>   
> -    case INDEX_op_rem_i32:
>       case INDEX_op_remu_i32:
> -    case INDEX_op_rem_i64:
>       case INDEX_op_remu_i64:
>           return C_O1_I2(r, rz, rz);
>   
> diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
> index 9af626eec2..320268669a 100644
> --- a/tcg/s390x/tcg-target.c.inc
> +++ b/tcg/s390x/tcg-target.c.inc
> @@ -2437,6 +2437,10 @@ static const TCGOutOpBinary outop_orc = {
>       .out_rrr = tgen_orc,
>   };
>   
> +static const TCGOutOpBinary outop_rems = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
>   static void tgen_sub(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
> index a4659653b3..23cca5c664 100644
> --- a/tcg/sparc64/tcg-target.c.inc
> +++ b/tcg/sparc64/tcg-target.c.inc
> @@ -1476,6 +1476,10 @@ static const TCGOutOpBinary outop_orc = {
>       .out_rrr = tgen_orc,
>   };
>   
> +static const TCGOutOpBinary outop_rems = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
>   static void tgen_sub(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> diff --git a/tcg/tci/tcg-target-opc.h.inc b/tcg/tci/tcg-target-opc.h.inc
> index 43c07a269f..2822fbffc8 100644
> --- a/tcg/tci/tcg-target-opc.h.inc
> +++ b/tcg/tci/tcg-target-opc.h.inc
> @@ -4,3 +4,4 @@ DEF(tci_movi, 1, 0, 1, TCG_OPF_NOT_PRESENT)
>   DEF(tci_movl, 1, 0, 1, TCG_OPF_NOT_PRESENT)
>   DEF(tci_divs32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
>   DEF(tci_divu32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
> +DEF(tci_rems32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
> diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
> index 27271c178c..4d9c142a00 100644
> --- a/tcg/tci/tcg-target.c.inc
> +++ b/tcg/tci/tcg-target.c.inc
> @@ -79,8 +79,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_st_i64:
>           return C_O0_I2(r, r);
>   
> -    case INDEX_op_rem_i32:
> -    case INDEX_op_rem_i64:
>       case INDEX_op_remu_i32:
>       case INDEX_op_remu_i64:
>       case INDEX_op_shl_i32:
> @@ -754,6 +752,20 @@ static const TCGOutOpBinary outop_orc = {
>       .out_rrr = tgen_orc,
>   };
>   
> +static void tgen_rems(TCGContext *s, TCGType type,
> +                      TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    TCGOpcode opc = (type == TCG_TYPE_I32
> +                     ? INDEX_op_tci_rems32
> +                     : INDEX_op_rem_i64);
> +    tcg_out_op_rrr(s, opc, a0, a1, a2);
> +}
> +
> +static const TCGOutOpBinary outop_rems = {
> +    .base.static_constraint = C_O1_I2(r, r, r),
> +    .out_rrr = tgen_rems,
> +};
> +
>   static void tgen_sub(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -843,7 +855,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       CASE_32_64(sar)
>       CASE_32_64(rotl)     /* Optional (TCG_TARGET_HAS_rot_*). */
>       CASE_32_64(rotr)     /* Optional (TCG_TARGET_HAS_rot_*). */
> -    CASE_32_64(rem)      /* Optional (TCG_TARGET_HAS_div_*). */
>       CASE_32_64(remu)     /* Optional (TCG_TARGET_HAS_div_*). */
>       CASE_32_64(clz)      /* Optional (TCG_TARGET_HAS_clz_*). */
>       CASE_32_64(ctz)      /* Optional (TCG_TARGET_HAS_ctz_*). */

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


