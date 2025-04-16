Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBBCC369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 18:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u57wS-0008Gp-I8; Wed, 16 Apr 2025 14:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u57wH-0008Fn-P7
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 14:56:51 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u57w2-0002zL-ED
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 14:56:37 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso9048855b3a.2
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 11:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744829792; x=1745434592; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yXq5mWPgfbAyts7U0R/OZkXLH/R5z/bE+mf8XPHfnrw=;
 b=ZE6tlBk/TdU1eJuKdqAzzWnUvpvz2xGPvu1/UfTVEZHTbPzRjAcwUSZOz4LlUUuJuc
 gLg1NaBycRzKlpOSdj5EfLU0n0e9fFT4KIT53JHfAyX2BBBkRUpC7M/RWPlhSKxmCHhP
 fYwiotKXQyNEQAKQlkrN04rK7VXIXg7Kj84aiN6yxosjE+Hf/AYzuEMqAE4eQ1RdUz38
 sIAxGCTib7zGevh/KVao40irAn+n95Tvj9QKq1V3lq4npKxxlVVJVS5j0kjHNBMX+w6G
 bWdfCDJMnRo4wMowZ3P6XAfLMqsO0aVkZxCg3Eg1OisVq4CRniDZ7x9wuAhTClTiNzqr
 9OXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744829792; x=1745434592;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yXq5mWPgfbAyts7U0R/OZkXLH/R5z/bE+mf8XPHfnrw=;
 b=AabetgNmx60v0Ch5KrLCyqTL5oHQgMVcN2eknYkqpLkpkQxyD4YbaBoqOlrcWLWMNi
 HLxFEsITufHSc05kAdpO6r+mgxi+aPqQYbXaBmJFmOSTlMnbJ7ygBybFW4mSMDZLpaBY
 eKa4CnOrYGBfTlNo3pUu3VJJmGy/Kgp/88V0D44g1CQ/yk2m2ExY3t0sY2WCuCr4RftX
 44qR71POuwUiMloOKxiJ9D1QZ96lfmx7SUFLxJxAX0G/3ESW/mAwiU3nqVmKEHCss3M3
 BNK1ED+ldR0PkZ33jAmTqJbVwfmjYcd8H89+2gHkMbq1B8mD1eWz4A0giiTsPtyEffsl
 vpEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7oFxEVZbyb0tWfwXZfJYi7gqAfYekW+yl7u4CeI9ElxzqHFfAE4fq1c86WDORrEcjgzv00QvtKRUw@nongnu.org
X-Gm-Message-State: AOJu0Yys/LAGL8+99TR13ud572AIQOZoXOel2lh3vQ9g8eBeLUJXL7XF
 WrvwI0CkGOp+YskhdGnAhgBbxCc/CygxzztRqgiZtVoI4/BlQThLA1cr4UkT3nk=
X-Gm-Gg: ASbGncvxie8DRF6/oDOFkMFn/+J98zbjRcIGvjeuRaLkVG3o0lDq3ilcMnUpYtlc1Cl
 zMofhlZX3jbWJSpr/54VDl8DVyQRJJCy4jsvlXfn7hXlOmV2RXRSoUY9ZdPFYKxsXoJwJLgftm3
 SC3aIDfgaLbyLcWbffk+Yjc3bRS/dBsFxQoWrv1b3UbZTNU4ATvwPOknMlQpo5kwYcDrfb5zXLb
 RmTixJifTr/H2lG9Tvvct/DZ79rZWEz9FQc8dIk4m5aDkSatxMTD3c5Q3wFORceRULZDYva1R72
 qMtyXlPB26Ce+XtvtSEQUs66fHY0u4kanD+5w03mC5Bujddc018Ffg==
X-Google-Smtp-Source: AGHT+IHFucQg9Ax5YWxYO3Lqa+i32RK2HkFKg79a+/vx7NqT8WecB2OcpOYE5T4yAzr33UB15F0sVA==
X-Received: by 2002:a05:6a00:390f:b0:730:8a5b:6e61 with SMTP id
 d2e1a72fcca58-73c266b4473mr3657921b3a.2.1744829792482; 
 Wed, 16 Apr 2025 11:56:32 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd219bf3dsm11162839b3a.16.2025.04.16.11.56.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 11:56:32 -0700 (PDT)
Message-ID: <1f6492f8-a7dc-4f45-a4bf-dee71c2cc2d3@linaro.org>
Date: Wed, 16 Apr 2025 11:56:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 114/163] tcg: Add TCGOutOp structures for add/sub carry
 opcodes
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-115-richard.henderson@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-115-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c                        | 61 +++++++++++++++++++++++++++-----
>   tcg/aarch64/tcg-target.c.inc     | 34 ++++++++++++++++++
>   tcg/arm/tcg-target.c.inc         | 34 ++++++++++++++++++
>   tcg/i386/tcg-target.c.inc        | 34 ++++++++++++++++++
>   tcg/loongarch64/tcg-target.c.inc | 34 ++++++++++++++++++
>   tcg/mips/tcg-target.c.inc        | 34 ++++++++++++++++++
>   tcg/ppc/tcg-target.c.inc         | 34 ++++++++++++++++++
>   tcg/riscv/tcg-target.c.inc       | 34 ++++++++++++++++++
>   tcg/s390x/tcg-target.c.inc       | 34 ++++++++++++++++++
>   tcg/sparc64/tcg-target.c.inc     | 34 ++++++++++++++++++
>   tcg/tci/tcg-target.c.inc         | 34 ++++++++++++++++++
>   11 files changed, 393 insertions(+), 8 deletions(-)
> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index c6a49f5648..1db9796964 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -133,6 +133,8 @@ static void tcg_out_addi_ptr(TCGContext *s, TCGReg, TCGReg, tcg_target_long);
>   static bool tcg_out_xchg(TCGContext *s, TCGType type, TCGReg r1, TCGReg r2);
>   static void tcg_out_exit_tb(TCGContext *s, uintptr_t arg);
>   static void tcg_out_goto_tb(TCGContext *s, int which);
> +static void tcg_out_set_carry(TCGContext *s);
> +static void tcg_out_set_borrow(TCGContext *s);
>   static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const TCGArg args[TCG_MAX_OP_ARGS],
>                          const int const_args[TCG_MAX_OP_ARGS]);
> @@ -978,6 +980,18 @@ typedef struct TCGOutOp {
>       TCGConstraintSetIndex (*dynamic_constraint)(TCGType type, unsigned flags);
>   } TCGOutOp;
>   
> +typedef struct TCGOutOpAddSubCarry {
> +    TCGOutOp base;
> +    void (*out_rrr)(TCGContext *s, TCGType type,
> +                    TCGReg a0, TCGReg a1, TCGReg a2);
> +    void (*out_rri)(TCGContext *s, TCGType type,
> +                    TCGReg a0, TCGReg a1, tcg_target_long a2);
> +    void (*out_rir)(TCGContext *s, TCGType type,
> +                    TCGReg a0, tcg_target_long a1, TCGReg a2);
> +    void (*out_rii)(TCGContext *s, TCGType type,
> +                    TCGReg a0, tcg_target_long a1, tcg_target_long a2);
> +} TCGOutOpAddSubCarry;
> +
>   typedef struct TCGOutOpBinary {
>       TCGOutOp base;
>       void (*out_rrr)(TCGContext *s, TCGType type,
> @@ -1131,6 +1145,11 @@ static const TCGOutOpUnary outop_extrl_i64_i32 = {
>   /* Register allocation descriptions for every TCGOpcode. */
>   static const TCGOutOp * const all_outop[NB_OPS] = {
>       OUTOP(INDEX_op_add, TCGOutOpBinary, outop_add),
> +    OUTOP(INDEX_op_addci, TCGOutOpAddSubCarry, outop_addci),
> +    OUTOP(INDEX_op_addcio, TCGOutOpBinary, outop_addcio),
> +    OUTOP(INDEX_op_addco, TCGOutOpBinary, outop_addco),
> +    /* addc1o is implemented with set_carry + addcio */
> +    OUTOP(INDEX_op_addc1o, TCGOutOpBinary, outop_addcio),
>       OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
>       OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
>       OUTOP(INDEX_op_brcond, TCGOutOpBrcond, outop_brcond),
> @@ -1170,6 +1189,11 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
>       OUTOP(INDEX_op_shl, TCGOutOpBinary, outop_shl),
>       OUTOP(INDEX_op_shr, TCGOutOpBinary, outop_shr),
>       OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
> +    OUTOP(INDEX_op_subbi, TCGOutOpAddSubCarry, outop_subbi),
> +    OUTOP(INDEX_op_subbio, TCGOutOpAddSubCarry, outop_subbio),
> +    OUTOP(INDEX_op_subbo, TCGOutOpAddSubCarry, outop_subbo),
> +    /* subb1o is implemented with set_borrow + subbio */
> +    OUTOP(INDEX_op_subb1o, TCGOutOpAddSubCarry, outop_subbio),
>       OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
>   
>   #if TCG_TARGET_REG_BITS == 32
> @@ -5564,7 +5588,12 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>       /* emit instruction */
>       TCGType type = TCGOP_TYPE(op);
>       switch (op->opc) {
> +    case INDEX_op_addc1o:
> +        tcg_out_set_carry(s);
> +        /* fall through */
>       case INDEX_op_add:
> +    case INDEX_op_addcio:
> +    case INDEX_op_addco:
>       case INDEX_op_and:
>       case INDEX_op_andc:
>       case INDEX_op_clz:
> @@ -5603,8 +5632,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>   
>       case INDEX_op_sub:
>           {
> -            const TCGOutOpSubtract *out =
> -                container_of(all_outop[op->opc], TCGOutOpSubtract, base);
> +            const TCGOutOpSubtract *out = &outop_sub;
>   
>               /*
>                * Constants should never appear in the second source operand.
> @@ -5619,15 +5647,32 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>           }
>           break;
>   
> -    case INDEX_op_addco:
> -    case INDEX_op_subbo:
> +    case INDEX_op_subb1o:
> +        tcg_out_set_borrow(s);
> +        /* fall through */
>       case INDEX_op_addci:
>       case INDEX_op_subbi:
> -    case INDEX_op_addcio:
>       case INDEX_op_subbio:
> -    case INDEX_op_addc1o:
> -    case INDEX_op_subb1o:
> -        g_assert_not_reached();
> +    case INDEX_op_subbo:
> +        {
> +            const TCGOutOpAddSubCarry *out =
> +                container_of(all_outop[op->opc], TCGOutOpAddSubCarry, base);
> +
> +            if (const_args[2]) {
> +                if (const_args[1]) {
> +                    out->out_rii(s, type, new_args[0],
> +                                 new_args[1], new_args[2]);
> +                } else {
> +                    out->out_rri(s, type, new_args[0],
> +                                 new_args[1], new_args[2]);
> +                }
> +            } else if (const_args[1]) {
> +                out->out_rir(s, type, new_args[0], new_args[1], new_args[2]);
> +            } else {
> +                out->out_rrr(s, type, new_args[0], new_args[1], new_args[2]);
> +            }
> +        }
> +        break;
>   
>       case INDEX_op_bswap64:
>       case INDEX_op_ext_i32_i64:
> diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
> index bece494c55..87f8c98ed7 100644
> --- a/tcg/aarch64/tcg-target.c.inc
> +++ b/tcg/aarch64/tcg-target.c.inc
> @@ -2078,6 +2078,23 @@ static const TCGOutOpBinary outop_add = {
>       .out_rri = tgen_addi,
>   };
>   
> +static const TCGOutOpBinary outop_addco = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpAddSubCarry outop_addci = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpBinary outop_addcio = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static void tcg_out_set_carry(TCGContext *s)
> +{
> +    g_assert_not_reached();
> +}
> +
>   static void tgen_and(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -2421,6 +2438,23 @@ static const TCGOutOpSubtract outop_sub = {
>       .out_rrr = tgen_sub,
>   };
>   
> +static const TCGOutOpAddSubCarry outop_subbo = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpAddSubCarry outop_subbi = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpAddSubCarry outop_subbio = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static void tcg_out_set_borrow(TCGContext *s)
> +{
> +    g_assert_not_reached();
> +}
> +
>   static void tgen_xor(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
> index f366424af5..aa0397520d 100644
> --- a/tcg/arm/tcg-target.c.inc
> +++ b/tcg/arm/tcg-target.c.inc
> @@ -1826,6 +1826,23 @@ static const TCGOutOpBinary outop_add = {
>       .out_rri = tgen_addi,
>   };
>   
> +static const TCGOutOpBinary outop_addco = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpAddSubCarry outop_addci = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpBinary outop_addcio = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static void tcg_out_set_carry(TCGContext *s)
> +{
> +    g_assert_not_reached();
> +}
> +
>   static void tgen_and(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -2135,6 +2152,23 @@ static const TCGOutOpSubtract outop_sub = {
>       .out_rir = tgen_subfi,
>   };
>   
> +static const TCGOutOpAddSubCarry outop_subbo = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpAddSubCarry outop_subbi = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpAddSubCarry outop_subbio = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static void tcg_out_set_borrow(TCGContext *s)
> +{
> +    g_assert_not_reached();
> +}
> +
>   static void tgen_xor(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index 2b2ad9ca95..04e31cae12 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc
> @@ -2629,6 +2629,23 @@ static const TCGOutOpBinary outop_add = {
>       .out_rri = tgen_addi,
>   };
>   
> +static const TCGOutOpBinary outop_addco = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpAddSubCarry outop_addci = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpBinary outop_addcio = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static void tcg_out_set_carry(TCGContext *s)
> +{
> +    g_assert_not_reached();
> +}
> +
>   static void tgen_and(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -3054,6 +3071,23 @@ static const TCGOutOpSubtract outop_sub = {
>       .out_rrr = tgen_sub,
>   };
>   
> +static const TCGOutOpAddSubCarry outop_subbo = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpAddSubCarry outop_subbi = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpAddSubCarry outop_subbio = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static void tcg_out_set_borrow(TCGContext *s)
> +{
> +    g_assert_not_reached();
> +}
> +
>   static void tgen_xor(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index 735dcc117a..937f19fe6b 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -1326,6 +1326,23 @@ static const TCGOutOpBinary outop_add = {
>       .out_rri = tcg_out_addi,
>   };
>   
> +static const TCGOutOpBinary outop_addco = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpAddSubCarry outop_addci = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpBinary outop_addcio = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static void tcg_out_set_carry(TCGContext *s)
> +{
> +    g_assert_not_reached();
> +}
> +
>   static void tgen_and(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -1715,6 +1732,23 @@ static const TCGOutOpSubtract outop_sub = {
>       .out_rrr = tgen_sub,
>   };
>   
> +static const TCGOutOpAddSubCarry outop_subbo = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpAddSubCarry outop_subbi = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpAddSubCarry outop_subbio = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static void tcg_out_set_borrow(TCGContext *s)
> +{
> +    g_assert_not_reached();
> +}
> +
>   static void tgen_xor(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
> index e69781b871..0c268cef42 100644
> --- a/tcg/mips/tcg-target.c.inc
> +++ b/tcg/mips/tcg-target.c.inc
> @@ -1593,6 +1593,23 @@ static const TCGOutOpBinary outop_add = {
>       .out_rri = tgen_addi,
>   };
>   
> +static const TCGOutOpBinary outop_addco = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpAddSubCarry outop_addci = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpBinary outop_addcio = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static void tcg_out_set_carry(TCGContext *s)
> +{
> +    g_assert_not_reached();
> +}
> +
>   static void tgen_and(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -2044,6 +2061,23 @@ static const TCGOutOpSubtract outop_sub = {
>       .out_rrr = tgen_sub,
>   };
>   
> +static const TCGOutOpAddSubCarry outop_subbo = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpAddSubCarry outop_subbi = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpAddSubCarry outop_subbio = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static void tcg_out_set_borrow(TCGContext *s)
> +{
> +    g_assert_not_reached();
> +}
> +
>   static void tgen_xor(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index a964239aab..5b04655f3b 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -2863,6 +2863,23 @@ static const TCGOutOpBinary outop_add = {
>       .out_rri = tgen_addi,
>   };
>   
> +static const TCGOutOpBinary outop_addco = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpAddSubCarry outop_addci = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpBinary outop_addcio = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static void tcg_out_set_carry(TCGContext *s)
> +{
> +    g_assert_not_reached();
> +}
> +
>   static void tgen_and(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -3267,6 +3284,23 @@ static const TCGOutOpSubtract outop_sub = {
>       .out_rir = tgen_subfi,
>   };
>   
> +static const TCGOutOpAddSubCarry outop_subbo = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpAddSubCarry outop_subbi = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpAddSubCarry outop_subbio = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static void tcg_out_set_borrow(TCGContext *s)
> +{
> +    g_assert_not_reached();
> +}
> +
>   static void tgen_xor(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index dce46dcba6..707ebb8f6d 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -1947,6 +1947,23 @@ static const TCGOutOpBinary outop_add = {
>       .out_rri = tgen_addi,
>   };
>   
> +static const TCGOutOpBinary outop_addco = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpAddSubCarry outop_addci = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpBinary outop_addcio = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static void tcg_out_set_carry(TCGContext *s)
> +{
> +    g_assert_not_reached();
> +}
> +
>   static void tgen_and(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -2333,6 +2350,23 @@ static const TCGOutOpSubtract outop_sub = {
>       .out_rrr = tgen_sub,
>   };
>   
> +static const TCGOutOpAddSubCarry outop_subbo = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpAddSubCarry outop_subbi = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpAddSubCarry outop_subbio = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static void tcg_out_set_borrow(TCGContext *s)
> +{
> +    g_assert_not_reached();
> +}
> +
>   static void tgen_xor(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
> index ff06834e6e..a30afb455e 100644
> --- a/tcg/s390x/tcg-target.c.inc
> +++ b/tcg/s390x/tcg-target.c.inc
> @@ -2248,6 +2248,23 @@ static const TCGOutOpBinary outop_add = {
>       .out_rri = tgen_addi,
>   };
>   
> +static const TCGOutOpBinary outop_addco = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpAddSubCarry outop_addci = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpBinary outop_addcio = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static void tcg_out_set_carry(TCGContext *s)
> +{
> +    g_assert_not_reached();
> +}
> +
>   static void tgen_and(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -2766,6 +2783,23 @@ static const TCGOutOpSubtract outop_sub = {
>       .out_rrr = tgen_sub,
>   };
>   
> +static const TCGOutOpAddSubCarry outop_subbo = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpAddSubCarry outop_subbi = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpAddSubCarry outop_subbio = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static void tcg_out_set_borrow(TCGContext *s)
> +{
> +    g_assert_not_reached();
> +}
> +
>   static void tgen_xor(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
> index 4c7d916302..12f0dbd23d 100644
> --- a/tcg/sparc64/tcg-target.c.inc
> +++ b/tcg/sparc64/tcg-target.c.inc
> @@ -1381,6 +1381,23 @@ static const TCGOutOpBinary outop_add = {
>       .out_rri = tgen_addi,
>   };
>   
> +static const TCGOutOpBinary outop_addco = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpAddSubCarry outop_addci = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpBinary outop_addcio = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static void tcg_out_set_carry(TCGContext *s)
> +{
> +    g_assert_not_reached();
> +}
> +
>   static void tgen_and(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -1717,6 +1734,23 @@ static const TCGOutOpSubtract outop_sub = {
>       .out_rrr = tgen_sub,
>   };
>   
> +static const TCGOutOpAddSubCarry outop_subbo = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpAddSubCarry outop_subbi = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpAddSubCarry outop_subbio = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static void tcg_out_set_borrow(TCGContext *s)
> +{
> +    g_assert_not_reached();
> +}
> +
>   static void tgen_xor(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
> index 9a5ca9c778..bba96d7a19 100644
> --- a/tcg/tci/tcg-target.c.inc
> +++ b/tcg/tci/tcg-target.c.inc
> @@ -573,6 +573,23 @@ static const TCGOutOpBinary outop_add = {
>       .out_rrr = tgen_add,
>   };
>   
> +static const TCGOutOpBinary outop_addco = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpAddSubCarry outop_addci = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpBinary outop_addcio = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static void tcg_out_set_carry(TCGContext *s)
> +{
> +    g_assert_not_reached();
> +}
> +
>   static void tgen_and(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -893,6 +910,23 @@ static const TCGOutOpSubtract outop_sub = {
>       .out_rrr = tgen_sub,
>   };
>   
> +static const TCGOutOpAddSubCarry outop_subbo = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpAddSubCarry outop_subbi = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static const TCGOutOpAddSubCarry outop_subbio = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +static void tcg_out_set_borrow(TCGContext *s)
> +{
> +    g_assert_not_reached();
> +}
> +
>   static void tgen_xor(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


