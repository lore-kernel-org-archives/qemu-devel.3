Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49523C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 21:40:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4o0d-0003dK-1F; Tue, 15 Apr 2025 17:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4o0Y-0003bz-SO
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:39:54 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4o0V-0001qa-PJ
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:39:54 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-227b828de00so56535945ad.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 14:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744753190; x=1745357990; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vKJn9+Xb6/+ZRVvfutmjY2tgPLHKMAV17/gMo/CyqT4=;
 b=S75CG3isEOAInWCaT8sxTmzIAUnlnz0NE6JC5zspnwmyCePL45M21YyBvcjWByC+o0
 /z7vbugf4QECWSkBvbGB14uMjEPw/J+raBrJdRxrh/N8ZpUH4XvohzKUikNmM5sDEVQf
 a2tHVMHN/6rBPVt/jaLw8ynEwxBo7d09OMUT8soYmcuwM/rDLY1QXGr2u8SUePCVkWld
 nuDCDiWAgTqzNkG7442bgEM3vtJk0n2OQNhXQO4pHgHCSKcJMB2zVbarhnOzCyrojEYp
 Uoh1e0SKPBr8rpoPljXqJR1CKcuncqInhrooxB2fe0js21+mB2+6Pz0LZiT/nFR12A5S
 R7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744753190; x=1745357990;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vKJn9+Xb6/+ZRVvfutmjY2tgPLHKMAV17/gMo/CyqT4=;
 b=UPXy/LolKN4xp19+xBwwg28vH1uOjE4yF3hUUS6eruvYBr2Zi4v6emecCz2UtbKtxW
 Qhk/hjgdH/amuwRNPxDijTk9ywTObkgg92TAutPH2clVKg8cgn8zCL3fdHyGoPSJa/zR
 pRAZz5veXz5BiBeOSnAFWviJ1waK2OTVNoeNXkZN6+MKNcNhjO4qhc3zoE3rQvPncsls
 9eOOYw1Y8JjKR8fRFDTlcYO4YkWtPBRFlK4qfNbq2Y90LCO5Pi5NOapJ8Oox0WvIN2sm
 MrVv6ILMHNYKLYTCeBPeWyA7yNQPsojyyEYAxTOjswV+eTGwG3UrptPp1XpdXikjLzFH
 9s2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrEuIlAdm3YbXLmr8gh3q3yEQKVFhImDUkIigxzBzvrqV+gemC7Ou+MarEgzuJ1ibryPVxqBiltYbF@nongnu.org
X-Gm-Message-State: AOJu0Yzl+DQFiX15Y1oSpWi1U5KHMFQswCdDMMEb/B9/banrKpO8BKOl
 dYRNuOTaGoSwF2LPZ/fxZfpAqaWj/Fck8JNghy8W4soedw6bdrxH1904GF97QM8=
X-Gm-Gg: ASbGncsTUNrG/i2a5RIQ3v+BuAYlpYgyUT72+RJTUbqhg3+iaLhfkJ+CoRyLgJ6ZVI7
 NeY9mioPaubLIhVWK41bfGMoAEYTgk02jNurNzt0TLTn1mHSFdYIeCXDrlcJK9D3zp2UmI3BvCw
 q+rFbFe1a9RHvE3cbk7z+Q6eweLvK9i4wQ2Z6h5aZbWSHMew6nI4WYJ6O1dPgft4SY0IriAchoS
 wiWIk2olsHxg6zT26NjxucZzdeWtHvO3qzN9eH3HADOq5vYFWApnCAmpGcZ9Xhq4cdVshDOGRPM
 ArwQ2upFhVpqN7bFnBbKGcJSm5jNLOki/6M3xszblOSOs7jQceZzaA==
X-Google-Smtp-Source: AGHT+IGOGu/6hzlo5s8QjrHNa8SElB5jtpwkogd49tr3Vcqs3rgrJGkvW2y7RRUPKSs7RAUeBVD3Bw==
X-Received: by 2002:a17:903:110f:b0:224:c46:d167 with SMTP id
 d9443c01a7336-22c318d224fmr10856665ad.16.1744753189558; 
 Tue, 15 Apr 2025 14:39:49 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33fc4c02sm33495ad.176.2025.04.15.14.39.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 14:39:49 -0700 (PDT)
Message-ID: <8f6d18d3-4086-478e-a4e6-2ab66d67eeb5@linaro.org>
Date: Tue, 15 Apr 2025 14:39:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 086/163] tcg: Convert setcond2_i32 to TCGOutOpSetcond2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-87-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-87-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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
>   tcg/mips/tcg-target-con-set.h |  2 +-
>   tcg/tcg.c                     | 19 ++++++++++
>   tcg/arm/tcg-target.c.inc      | 25 ++++++------
>   tcg/i386/tcg-target.c.inc     | 71 +++++++++++++++++------------------
>   tcg/mips/tcg-target.c.inc     | 20 ++++++----
>   tcg/ppc/tcg-target.c.inc      | 25 ++++++------
>   tcg/tci/tcg-target.c.inc      | 24 ++++++++----
>   7 files changed, 110 insertions(+), 76 deletions(-)
> 
> diff --git a/tcg/mips/tcg-target-con-set.h b/tcg/mips/tcg-target-con-set.h
> index 9d0ea73f4f..4e09c9a400 100644
> --- a/tcg/mips/tcg-target-con-set.h
> +++ b/tcg/mips/tcg-target-con-set.h
> @@ -25,7 +25,7 @@ C_O1_I2(r, r, rz)
>   C_O1_I2(r, r, rzW)
>   C_O1_I4(r, r, rz, rz, 0)
>   C_O1_I4(r, r, rz, rz, rz)
> -C_O1_I4(r, rz, rz, rz, rz)
> +C_O1_I4(r, r, r, rz, rz)
>   C_O2_I1(r, r, r)
>   C_O2_I2(r, r, r, r)
>   C_O2_I4(r, r, rz, rz, rN, rN)
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 6fd287cdda..3af32227a3 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1033,6 +1033,12 @@ typedef struct TCGOutOpSetcond {
>                       TCGReg ret, TCGReg a1, tcg_target_long a2);
>   } TCGOutOpSetcond;
>   
> +typedef struct TCGOutOpSetcond2 {
> +    TCGOutOp base;
> +    void (*out)(TCGContext *s, TCGCond cond, TCGReg ret, TCGReg al, TCGReg ah,
> +                TCGArg bl, bool const_bl, TCGArg bh, bool const_bh);
> +} TCGOutOpSetcond2;
> +
>   typedef struct TCGOutOpSubtract {
>       TCGOutOp base;
>       void (*out_rrr)(TCGContext *s, TCGType type,
> @@ -1097,6 +1103,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
>   
>   #if TCG_TARGET_REG_BITS == 32
>       OUTOP(INDEX_op_brcond2_i32, TCGOutOpBrcond2, outop_brcond2),
> +    OUTOP(INDEX_op_setcond2_i32, TCGOutOpSetcond2, outop_setcond2),
>   #endif
>   };
>   
> @@ -5562,8 +5569,20 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>                        new_args[3], const_args[3], label);
>           }
>           break;
> +    case INDEX_op_setcond2_i32:
> +        {
> +            const TCGOutOpSetcond2 *out = &outop_setcond2;
> +            TCGCond cond = new_args[5];
> +
> +            tcg_debug_assert(!const_args[1]);
> +            tcg_debug_assert(!const_args[2]);
> +            out->out(s, cond, new_args[0], new_args[1], new_args[2],
> +                     new_args[3], const_args[3], new_args[4], const_args[4]);
> +        }
> +        break;
>   #else
>       case INDEX_op_brcond2_i32:
> +    case INDEX_op_setcond2_i32:
>           g_assert_not_reached();
>   #endif
>   
> diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
> index 1c42df1092..8cd82b8baf 100644
> --- a/tcg/arm/tcg-target.c.inc
> +++ b/tcg/arm/tcg-target.c.inc
> @@ -2266,13 +2266,25 @@ static const TCGOutOpBrcond2 outop_brcond2 = {
>       .out = tgen_brcond2,
>   };
>   
> +static void tgen_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
> +                          TCGReg al, TCGReg ah,
> +                          TCGArg bl, bool const_bl,
> +                          TCGArg bh, bool const_bh)
> +{
> +    cond = tcg_out_cmp2(s, cond, al, ah, bl, const_bl, bh, const_bh);
> +    finish_setcond(s, cond, ret, false);
> +}
> +
> +static const TCGOutOpSetcond2 outop_setcond2 = {
> +    .base.static_constraint = C_O1_I4(r, r, r, rI, rI),
> +    .out = tgen_setcond2,
> +};
>   
>   static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const TCGArg args[TCG_MAX_OP_ARGS],
>                          const int const_args[TCG_MAX_OP_ARGS])
>   {
>       TCGArg a0, a1, a2, a3, a4, a5;
> -    int c;
>   
>       switch (opc) {
>       case INDEX_op_goto_ptr:
> @@ -2348,14 +2360,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_mov_reg(s, COND_AL, args[0], a0);
>           break;
>   
> -    case INDEX_op_setcond2_i32:
> -        c = tcg_out_cmp2(s, args[5], args[1], args[2], args[3], const_args[3],
> -                         args[4], const_args[4]);
> -        tcg_out_dat_imm(s, tcg_cond_to_arm_cond[c], ARITH_MOV, args[0], 0, 1);
> -        tcg_out_dat_imm(s, tcg_cond_to_arm_cond[tcg_invert_cond(c)],
> -                        ARITH_MOV, args[0], 0, 0);
> -        break;
> -
>       case INDEX_op_qemu_ld_i32:
>           tcg_out_qemu_ld(s, args[0], -1, args[1], args[2], TCG_TYPE_I32);
>           break;
> @@ -2452,9 +2456,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>           return C_O2_I4(r, r, r, r, rIN, rIK);
>       case INDEX_op_sub2_i32:
>           return C_O2_I4(r, r, rI, rI, rIN, rIK);
> -    case INDEX_op_setcond2_i32:
> -        return C_O1_I4(r, r, r, rI, rI);
> -
>       case INDEX_op_qemu_ld_i32:
>           return C_O1_I1(r, q);
>       case INDEX_op_qemu_ld_i64:
> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index b7708c945f..6a42ffaf44 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc
> @@ -1860,47 +1860,53 @@ static const TCGOutOpSetcond outop_negsetcond = {
>       .out_rri = tgen_negsetcondi,
>   };
>   
> -#if TCG_TARGET_REG_BITS == 32
> -static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
> -                             const int *const_args)
> +static void tgen_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
> +                          TCGReg al, TCGReg ah,
> +                          TCGArg bl, bool const_bl,
> +                          TCGArg bh, bool const_bh)
>   {
> -    TCGLabel *label_true, *label_over;
> +    TCGLabel *label_over = gen_new_label();
>   
> -    if (args[0] == args[1] || args[0] == args[2]
> -        || (!const_args[3] && args[0] == args[3])
> -        || (!const_args[4] && args[0] == args[4])) {
> -        /* When the destination overlaps with one of the argument
> -           registers, don't do anything tricky.  */
> -        label_true = gen_new_label();
> -        label_over = gen_new_label();
> +    if (ret == al || ret == ah
> +        || (!const_bl && ret == bl)
> +        || (!const_bh && ret == bh)) {
> +        /*
> +         * When the destination overlaps with one of the argument
> +         * registers, don't do anything tricky.
> +         */
> +        TCGLabel *label_true = gen_new_label();
>   
> -        tcg_out_brcond2(s, args[5], args[1], args[2], args[3], const_args[3],
> -                        args[4], const_args[4], label_true, true);
> +        tcg_out_brcond2(s, cond, al, ah, bl, const_bl,
> +                        bh, const_bh, label_true, true);
>   
> -        tcg_out_movi(s, TCG_TYPE_I32, args[0], 0);
> +        tcg_out_movi(s, TCG_TYPE_I32, ret, 0);
>           tcg_out_jxx(s, JCC_JMP, label_over, 1);
>           tcg_out_label(s, label_true);
>   
> -        tcg_out_movi(s, TCG_TYPE_I32, args[0], 1);
> -        tcg_out_label(s, label_over);
> +        tcg_out_movi(s, TCG_TYPE_I32, ret, 1);
>       } else {
> -        /* When the destination does not overlap one of the arguments,
> -           clear the destination first, jump if cond false, and emit an
> -           increment in the true case.  This results in smaller code.  */
> +        /*
> +         * When the destination does not overlap one of the arguments,
> +         * clear the destination first, jump if cond false, and emit an
> +         * increment in the true case.  This results in smaller code.
> +         */
> +        tcg_out_movi(s, TCG_TYPE_I32, ret, 0);
>   
> -        tcg_out_movi(s, TCG_TYPE_I32, args[0], 0);
> +        tcg_out_brcond2(s, tcg_invert_cond(cond), al, ah, bl, const_bl,
> +                        bh, const_bh, label_over, true);
>   
> -        label_over = gen_new_label();
> -        tcg_out_brcond2(s, tcg_invert_cond(args[5]), args[1], args[2],
> -                        args[3], const_args[3],
> -                        args[4], const_args[4], label_over, true);
> -
> -
> -        tgen_arithi(s, ARITH_ADD, args[0], 1, 0);
> -        tcg_out_label(s, label_over);
> +        tgen_arithi(s, ARITH_ADD, ret, 1, 0);
>       }
> +    tcg_out_label(s, label_over);
>   }
> +
> +#if TCG_TARGET_REG_BITS != 32
> +__attribute__((unused))
>   #endif
> +static const TCGOutOpSetcond2 outop_setcond2 = {
> +    .base.static_constraint = C_O1_I4(r, r, r, ri, ri),
> +    .out = tgen_setcond2,
> +};
>   
>   static void tcg_out_cmov(TCGContext *s, int jcc, int rexw,
>                            TCGReg dest, TCGReg v1)
> @@ -3240,11 +3246,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           }
>           break;
>   
> -#if TCG_TARGET_REG_BITS == 32
> -    case INDEX_op_setcond2_i32:
> -        tcg_out_setcond2(s, args, const_args);
> -        break;
> -#else /* TCG_TARGET_REG_BITS == 64 */
> +#if TCG_TARGET_REG_BITS == 64
>       case INDEX_op_ld32s_i64:
>           tcg_out_modrm_offset(s, OPC_MOVSLQ, a0, a1, a2);
>           break;
> @@ -4012,9 +4014,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>           tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
>           return C_O0_I3(L, L, L);
>   
> -    case INDEX_op_setcond2_i32:
> -        return C_O1_I4(r, r, r, ri, ri);
> -
>       case INDEX_op_ld_vec:
>       case INDEX_op_dupm_vec:
>           return C_O1_I1(x, r);
> diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
> index 9a9b1bb09a..e8ae65bccb 100644
> --- a/tcg/mips/tcg-target.c.inc
> +++ b/tcg/mips/tcg-target.c.inc
> @@ -1067,13 +1067,23 @@ static int tcg_out_setcond2_int(TCGContext *s, TCGCond cond, TCGReg ret,
>       return ret | flags;
>   }
>   
> -static void tcg_out_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
> -                             TCGReg al, TCGReg ah, TCGReg bl, TCGReg bh)
> +static void tgen_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
> +                          TCGReg al, TCGReg ah,
> +                          TCGArg bl, bool const_bl,
> +                          TCGArg bh, bool const_bh)
>   {
>       int tmpflags = tcg_out_setcond2_int(s, cond, ret, al, ah, bl, bh);
>       tcg_out_setcond_end(s, ret, tmpflags);
>   }
>   
> +#if TCG_TARGET_REG_BITS != 32
> +__attribute__((unused))
> +#endif
> +static const TCGOutOpSetcond2 outop_setcond2 = {
> +    .base.static_constraint = C_O1_I4(r, r, r, rz, rz),
> +    .out = tgen_setcond2,
> +};
> +
>   static void tgen_brcond2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
>                            TCGArg bl, bool const_bl,
>                            TCGArg bh, bool const_bh, TCGLabel *l)
> @@ -2306,10 +2316,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           }
>           break;
>   
> -    case INDEX_op_setcond2_i32:
> -        tcg_out_setcond2(s, args[5], a0, a1, a2, args[3], args[4]);
> -        break;
> -
>       case INDEX_op_qemu_ld_i32:
>           tcg_out_qemu_ld(s, a0, 0, a1, a2, TCG_TYPE_I32);
>           break;
> @@ -2404,8 +2410,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_add2_i32:
>       case INDEX_op_sub2_i32:
>           return C_O2_I4(r, r, rz, rz, rN, rN);
> -    case INDEX_op_setcond2_i32:
> -        return C_O1_I4(r, rz, rz, rz, rz);
>   
>       case INDEX_op_qemu_ld_i32:
>           return C_O1_I1(r, r);
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index cde8a55918..4cdbf246d2 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -2274,15 +2274,24 @@ static void tcg_out_cmp2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
>       }
>   }
>   
> -static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
> -                             const int *const_args)
> +static void tgen_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
> +                          TCGReg al, TCGReg ah,
> +                          TCGArg bl, bool const_bl,
> +                          TCGArg bh, bool const_bh)
>   {
> -    tcg_out_cmp2(s, args[5], args[1], args[2], args[3], const_args[3],
> -                 args[4], const_args[4]);
> +    tcg_out_cmp2(s, cond, al, ah, bl, const_bl, bh, const_bh);
>       tcg_out32(s, MFOCRF | RT(TCG_REG_R0) | FXM(0));
> -    tcg_out_rlw(s, RLWINM, args[0], TCG_REG_R0, CR_EQ + 0*4 + 1, 31, 31);
> +    tcg_out_rlw(s, RLWINM, ret, TCG_REG_R0, CR_EQ + 0*4 + 1, 31, 31);
>   }
>   
> +#if TCG_TARGET_REG_BITS != 32
> +__attribute__((unused))
> +#endif
> +static const TCGOutOpSetcond2 outop_setcond2 = {
> +    .base.static_constraint = C_O1_I4(r, r, r, rU, rC),
> +    .out = tgen_setcond2,
> +};
> +
>   static void tgen_brcond2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
>                            TCGArg bl, bool const_bl,
>                            TCGArg bh, bool const_bh, TCGLabel *l)
> @@ -3491,10 +3500,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], false);
>           break;
>   
> -    case INDEX_op_setcond2_i32:
> -        tcg_out_setcond2(s, args, const_args);
> -        break;
> -
>       case INDEX_op_bswap16_i32:
>       case INDEX_op_bswap16_i64:
>           tcg_out_bswap16(s, args[0], args[1], args[2]);
> @@ -4277,8 +4282,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_deposit_i32:
>       case INDEX_op_deposit_i64:
>           return C_O1_I2(r, 0, rZ);
> -    case INDEX_op_setcond2_i32:
> -        return C_O1_I4(r, r, r, rU, rC);
>       case INDEX_op_add2_i64:
>       case INDEX_op_add2_i32:
>           return C_O2_I4(r, r, r, r, rI, rZM);
> diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
> index 0fe365e2d4..88dc7e24e3 100644
> --- a/tcg/tci/tcg-target.c.inc
> +++ b/tcg/tci/tcg-target.c.inc
> @@ -87,9 +87,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_sub2_i64:
>           return C_O2_I4(r, r, r, r, r, r);
>   
> -    case INDEX_op_setcond2_i32:
> -        return C_O1_I4(r, r, r, r, r);
> -
>       case INDEX_op_qemu_ld_i32:
>           return C_O1_I1(r, r);
>       case INDEX_op_qemu_ld_i64:
> @@ -997,6 +994,22 @@ static const TCGOutOpBrcond2 outop_brcond2 = {
>       .out = tgen_brcond2,
>   };
>   
> +static void tgen_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
> +                          TCGReg al, TCGReg ah,
> +                          TCGArg bl, bool const_bl,
> +                          TCGArg bh, bool const_bh)
> +{
> +    tcg_out_op_rrrrrc(s, INDEX_op_setcond2_i32, ret, al, ah, bl, bh, cond);
> +}
> +
> +#if TCG_TARGET_REG_BITS != 32
> +__attribute__((unused))
> +#endif
> +static const TCGOutOpSetcond2 outop_setcond2 = {
> +    .base.static_constraint = C_O1_I4(r, r, r, r, r),
> +    .out = tgen_setcond2,
> +};
> +
>   static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const TCGArg args[TCG_MAX_OP_ARGS],
>                          const int const_args[TCG_MAX_OP_ARGS])
> @@ -1012,11 +1025,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_op_l(s, opc, arg_label(args[0]));
>           break;
>   
> -    case INDEX_op_setcond2_i32:
> -        tcg_out_op_rrrrrc(s, opc, args[0], args[1], args[2],
> -                          args[3], args[4], args[5]);
> -        break;
> -
>       CASE_32_64(ld8u)
>       CASE_32_64(ld8s)
>       CASE_32_64(ld16u)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


