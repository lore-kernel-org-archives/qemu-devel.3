Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486A8C369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u58It-0000Ok-FA; Wed, 16 Apr 2025 15:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58Ir-0000OI-Kx
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:20:09 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58Ip-0006qS-0e
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:20:09 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2279915e06eso455415ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744831205; x=1745436005; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6SrKIOQA8XFfqzY2/u0NlUiiMCi5klyDxI8s5majmfo=;
 b=PFklnttkuMdR0kU9pc/t2dFVqbtw/wQOZCyH6S4GmYX5T/OfjkjDcf/fsQ0zRkFNca
 C1+Dqt5iudarnHR4QOyUqzEBA8tH/U6HBX0T2gSAdRpkI//CpfGB8/LHducbUGW1wr4N
 kxvuusPBiYTq/nr179vnNp/Kz/JJxeLxl9bE1Z1gH1RB2mHqh18eu2pGECRTFXhUzXMq
 o7CLdb47m02aqQ2H7JvhKLMVWMx1kjJqVo2AbHq64PuXL05r1iy65TUgTCzTZZcVXVfq
 g7955wmyGpBlS8fo5gW1mWoaeYBJsUtG9je21hxD+PtZ4UhTG5dVFyijrML1Goh58X3f
 BOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744831205; x=1745436005;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6SrKIOQA8XFfqzY2/u0NlUiiMCi5klyDxI8s5majmfo=;
 b=ERPJhpbj1n0rqs8VZ+6A5dB+QVmFLbJMqIF5bxuOgg96kIU4bPLfS3XCFrv6//US7F
 BvWvPQb3OsxK05iYWe58KuLSfMTbf6L+xZdJfDaPsFC6t6ErG++0Gmrktxnu9cXrMKLj
 9VNdf8HYh9zZhY3Tx9joW1c4Q5/BBN8ujcAXh4X6H1gDIHNn6r0GyoBIaitS7ZIk54hE
 V5XNTeM8GSHF+Nc63HzbizeTNybNMAZA4t640ZB57Jp3VmXy9y3Yg8BorsUqv3Izvdm8
 s7d/4ckiMi0FvV1/tuC34+nunXxCM3ep1F0R++sGxysUXJGnrsb7LL3Gh3RkEfUhnkVD
 umEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBCHlFgmT3yRxv2tRtVLEa3Im9C1YgQ5e5MtNMr7Vn7xw2bjsetp5K7yw5nW0kNs6CFIsE0jV/U5tU@nongnu.org
X-Gm-Message-State: AOJu0YzKXr8uAPQEraWqUJ4/cFNyrIEiXfOZJr7GuFwxZAGm7gsRLX/r
 kWM+mBxSS6YkY31edBfS+d1oKZJ0tZ2PHrL+63PD8f2zEP7Vw4/qSY2NlcOCyGHnNqx5dhFh+lw
 F
X-Gm-Gg: ASbGnctVPoMl+gxIs3QG+yiaoLLH9xrOHnfxRmyy4vLtsb/zqlPZrwyDr7AESD+5mH6
 Pr3MToleyHjK8CSPSYFD3CcQC6LStwMs2SPs1LpQB9orplQFAmt9uAKmD5Cp8NWfNApxDAMYcRW
 zedaBctiTnRbP9i3QZXeT7atU5CYTOVRJbCcOfeCZdETu6ddcqx1AUK0MsyEEB6LF3J3TIv31do
 mozsP++drWWo2PwDEBVmEMSU2oYtToV6rTh0RMiBQOK4A+n2x6S+4UvcyaFLF1Hs2wEUicYlLnB
 hsiU9fXYjRO3CDG+xtoraF7z1bSkt71NHAPSUX61SY9ySB/YBPxU6Q==
X-Google-Smtp-Source: AGHT+IG+w2+5kLreqVa/pKpE8Vh93NSeZoNbeqTrSevwCFVwDJJfJhi62GWG1Ru41L9CuoWFzXfDLQ==
X-Received: by 2002:a17:902:da83:b0:226:4764:1963 with SMTP id
 d9443c01a7336-22c35983d1emr40532295ad.51.1744831205356; 
 Wed, 16 Apr 2025 12:20:05 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33fcd143sm18100125ad.197.2025.04.16.12.20.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 12:20:04 -0700 (PDT)
Message-ID: <8c890c22-fd87-45bf-ae71-2fd2c57284f9@linaro.org>
Date: Wed, 16 Apr 2025 12:20:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 145/163] tcg/sparc64: Implement add/sub carry opcodes
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-146-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-146-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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
>   tcg/sparc64/tcg-target-con-set.h |   3 +
>   tcg/sparc64/tcg-target.c.inc     | 244 ++++++++++++++++++++++++++++++-
>   2 files changed, 239 insertions(+), 8 deletions(-)
> 
> diff --git a/tcg/sparc64/tcg-target-con-set.h b/tcg/sparc64/tcg-target-con-set.h
> index 8cec396173..37cb190450 100644
> --- a/tcg/sparc64/tcg-target-con-set.h
> +++ b/tcg/sparc64/tcg-target-con-set.h
> @@ -15,6 +15,9 @@ C_O0_I2(r, rJ)
>   C_O1_I1(r, r)
>   C_O1_I2(r, r, r)
>   C_O1_I2(r, r, rJ)
> +C_O1_I2(r, r, rZ)
> +C_O1_I2(r, rZ, rJ)
> +C_O1_I2(r, rZ, rZ)
>   C_O1_I4(r, r, rJ, rI, 0)
>   C_O2_I2(r, r, r, r)
>   C_O2_I4(r, r, rz, rz, rJ, rJ)
> diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
> index 350a7f6332..93bb88b05f 100644
> --- a/tcg/sparc64/tcg-target.c.inc
> +++ b/tcg/sparc64/tcg-target.c.inc
> @@ -199,7 +199,9 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
>   #define ARITH_SUB  (INSN_OP(2) | INSN_OP3(0x04))
>   #define ARITH_SUBCC (INSN_OP(2) | INSN_OP3(0x14))
>   #define ARITH_ADDC (INSN_OP(2) | INSN_OP3(0x08))
> +#define ARITH_ADDCCC (INSN_OP(2) | INSN_OP3(0x18))
>   #define ARITH_SUBC (INSN_OP(2) | INSN_OP3(0x0c))
> +#define ARITH_SUBCCC (INSN_OP(2) | INSN_OP3(0x1c))
>   #define ARITH_UMUL (INSN_OP(2) | INSN_OP3(0x0a))
>   #define ARITH_SMUL (INSN_OP(2) | INSN_OP3(0x0b))
>   #define ARITH_UDIV (INSN_OP(2) | INSN_OP3(0x0e))
> @@ -211,6 +213,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
>   #define ARITH_MOVR (INSN_OP(2) | INSN_OP3(0x2f))
>   
>   #define ARITH_ADDXC (INSN_OP(2) | INSN_OP3(0x36) | INSN_OPF(0x11))
> +#define ARITH_ADDXCCC (INSN_OP(2) | INSN_OP3(0x36) | INSN_OPF(0x13))
>   #define ARITH_UMULXHI (INSN_OP(2) | INSN_OP3(0x36) | INSN_OPF(0x16))
>   
>   #define SHIFT_SLL  (INSN_OP(2) | INSN_OP3(0x25))
> @@ -223,6 +226,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
>   
>   #define RDY        (INSN_OP(2) | INSN_OP3(0x28) | INSN_RS1(0))
>   #define WRY        (INSN_OP(2) | INSN_OP3(0x30) | INSN_RD(0))
> +#define WRCCR      (INSN_OP(2) | INSN_OP3(0x30) | INSN_RD(2))
>   #define JMPL       (INSN_OP(2) | INSN_OP3(0x38))
>   #define RETURN     (INSN_OP(2) | INSN_OP3(0x39))
>   #define SAVE       (INSN_OP(2) | INSN_OP3(0x3c))
> @@ -1382,21 +1386,150 @@ static const TCGOutOpBinary outop_add = {
>       .out_rri = tgen_addi,
>   };
>   
> +static void tgen_addco_rrr(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tcg_out_arith(s, a0, a1, a2, ARITH_ADDCC);
> +}
> +
> +static void tgen_addco_rri(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    tcg_out_arithi(s, a0, a1, a2, ARITH_ADDCC);
> +}
> +
>   static const TCGOutOpBinary outop_addco = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_O1_I2(r, r, rJ),
> +    .out_rrr = tgen_addco_rrr,
> +    .out_rri = tgen_addco_rri,
>   };
>   
> +static void tgen_addci_rrr(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    if (type == TCG_TYPE_I32) {
> +        tcg_out_arith(s, a0, a1, a2, ARITH_ADDC);
> +    } else if (use_vis3_instructions) {
> +        tcg_out_arith(s, a0, a1, a2, ARITH_ADDXC);
> +    } else {
> +        tcg_out_arith(s, TCG_REG_T1, a1, a2, ARITH_ADD);  /* for CC */
> +        tcg_out_arithi(s, a0, TCG_REG_T1, 1, ARITH_ADD);  /* for CS */
> +        /* Select the correct result based on actual carry value. */
> +        tcg_out_movcc(s, COND_CC, MOVCC_XCC, a0, TCG_REG_T1, false);
> +    }
> +}
> +
> +static void tgen_addci_rri(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    if (type == TCG_TYPE_I32) {
> +        tcg_out_arithi(s, a0, a1, a2, ARITH_ADDC);
> +    } else if (use_vis3_instructions) {
> +        tcg_debug_assert(a2 == 0);
> +        tcg_out_arith(s, a0, a1, TCG_REG_G0, ARITH_ADDXC);
> +    } else if (a2 != 0) {
> +        tcg_out_arithi(s, TCG_REG_T1, a1, a2, ARITH_ADD); /* for CC */
> +        tcg_out_arithi(s, a0, TCG_REG_T1, 1, ARITH_ADD);  /* for CS */
> +        tcg_out_movcc(s, COND_CC, MOVCC_XCC, a0, TCG_REG_T1, false);
> +    } else if (a0 == a1) {
> +        tcg_out_arithi(s, TCG_REG_T1, a1, 1, ARITH_ADD);
> +        tcg_out_movcc(s, COND_CS, MOVCC_XCC, a0, TCG_REG_T1, false);
> +    } else {
> +        tcg_out_arithi(s, a0, a1, 1, ARITH_ADD);
> +	tcg_out_movcc(s, COND_CC, MOVCC_XCC, a0, a1, false);
> +    }
> +}
> +
> +static void tgen_addci_rir(TCGContext *s, TCGType type,
> +                           TCGReg a0, tcg_target_long a1, TCGReg a2)
> +{
> +    tgen_addci_rri(s, type, a0, a2, a1);
> +}
> +
> +static void tgen_addci_rii(TCGContext *s, TCGType type,
> +                           TCGReg a0, tcg_target_long a1, tcg_target_long a2)
> +{
> +    tgen_addci_rri(s, type, a0, TCG_REG_G0, a2);
> +}
> +
> +static TCGConstraintSetIndex cset_addci(TCGType type, unsigned flags)
> +{
> +    if (use_vis3_instructions && type == TCG_TYPE_I64) {
> +        /* Note that ADDXC doesn't accept immediates.  */
> +        return C_O1_I2(r, rZ, rZ);
> +    }
> +    return C_O1_I2(r, rZ, rJ);
> +}
> +
>   static const TCGOutOpAddSubCarry outop_addci = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_Dynamic,
> +    .base.dynamic_constraint = cset_addci,
> +    .out_rrr = tgen_addci_rrr,
> +    .out_rri = tgen_addci_rri,
> +    .out_rir = tgen_addci_rir,
> +    .out_rii = tgen_addci_rii,
>   };
>   
> +/* Copy %xcc.c to %icc.c */
> +static void tcg_out_dup_xcc_c(TCGContext *s)
> +{
> +    if (use_vis3_instructions) {
> +        tcg_out_arith(s, TCG_REG_T1, TCG_REG_G0, TCG_REG_G0, ARITH_ADDXC);
> +    } else {
> +        tcg_out_movi_s13(s, TCG_REG_T1, 0);
> +        tcg_out_movcc(s, COND_CS, MOVCC_XCC, TCG_REG_T1, 1, true);
> +    }
> +    /* Write carry-in into %icc via {0,1} + -1. */
> +    tcg_out_arithi(s, TCG_REG_G0, TCG_REG_T1, -1, ARITH_ADDCC);
> +}
> +
> +static void tgen_addcio_rrr(TCGContext *s, TCGType type,
> +                            TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    if (type != TCG_TYPE_I32) {
> +        if (use_vis3_instructions) {
> +            tcg_out_arith(s, a0, a1, a2, ARITH_ADDXCCC);
> +            return;
> +        }
> +        tcg_out_dup_xcc_c(s);
> +    }
> +    tcg_out_arith(s, a0, a1, a2, ARITH_ADDCCC);
> +}
> +
> +static void tgen_addcio_rri(TCGContext *s, TCGType type,
> +                            TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    if (type != TCG_TYPE_I32) {
> +        if (use_vis3_instructions) {
> +            tcg_debug_assert(a2 == 0);
> +            tcg_out_arith(s, a0, a1, TCG_REG_G0, ARITH_ADDXCCC);
> +            return;
> +        }
> +        tcg_out_dup_xcc_c(s);
> +    }
> +    tcg_out_arithi(s, a0, a1, a2, ARITH_ADDCCC);
> +}
> +
> +static TCGConstraintSetIndex cset_addcio(TCGType type, unsigned flags)
> +{
> +    if (use_vis3_instructions && type == TCG_TYPE_I64) {
> +        /* Note that ADDXC doesn't accept immediates.  */
> +        return C_O1_I2(r, r, rZ);
> +    }
> +    return C_O1_I2(r, r, rJ);
> +}
> +
>   static const TCGOutOpBinary outop_addcio = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_Dynamic,
> +    .base.dynamic_constraint = cset_addcio,
> +    .out_rrr = tgen_addcio_rrr,
> +    .out_rri = tgen_addcio_rri,
>   };
>   
>   static void tcg_out_set_carry(TCGContext *s)
>   {
> -    g_assert_not_reached();
> +    /* 0x11 -> xcc = nzvC, icc = nzvC */
> +    tcg_out_arithi(s, 0, TCG_REG_G0, 0x11, WRCCR);
>   }
>   
>   static void tgen_and(TCGContext *s, TCGType type,
> @@ -1735,21 +1868,116 @@ static const TCGOutOpSubtract outop_sub = {
>       .out_rrr = tgen_sub,
>   };
>   
> +static void tgen_subbo_rrr(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tcg_out_arith(s, a0, a1, a2, ARITH_SUBCC);
> +}
> +
> +static void tgen_subbo_rri(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    tcg_out_arithi(s, a0, a1, a2, ARITH_SUBCC);
> +}
> +
>   static const TCGOutOpAddSubCarry outop_subbo = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_O1_I2(r, r, rJ),
> +    .out_rrr = tgen_subbo_rrr,
> +    .out_rri = tgen_subbo_rri,
>   };
>   
> +static void tgen_subbi_rrr(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    if (type == TCG_TYPE_I32) {
> +        tcg_out_arith(s, a0, a1, a2, ARITH_ADDC);
> +    } else {
> +        tcg_out_arith(s, TCG_REG_T1, a1, a2, ARITH_SUB);  /* for CC */
> +        tcg_out_arithi(s, a0, TCG_REG_T1, 1, ARITH_SUB);  /* for CS */
> +        /* Select the correct result based on actual borrow value. */
> +        tcg_out_movcc(s, COND_CC, MOVCC_XCC, a0, TCG_REG_T1, false);
> +    }
> +}
> +
> +static void tgen_subbi_rri(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    if (type == TCG_TYPE_I32) {
> +        tcg_out_arithi(s, a0, a1, a2, ARITH_ADDC);
> +    } else if (a2 != 0) {
> +        tcg_out_arithi(s, TCG_REG_T1, a1, a2, ARITH_SUB);  /* for CC */
> +        tcg_out_arithi(s, a0, TCG_REG_T1, 1, ARITH_SUB);   /* for CS */
> +        tcg_out_movcc(s, COND_CC, MOVCC_XCC, a0, TCG_REG_T1, false);
> +    } else if (a0 == a1) {
> +        tcg_out_arithi(s, TCG_REG_T1, a1, 1, ARITH_SUB);
> +        tcg_out_movcc(s, COND_CS, MOVCC_XCC, a0, TCG_REG_T1, false);
> +    } else {
> +        tcg_out_arithi(s, a0, a1, 1, ARITH_SUB);
> +        tcg_out_movcc(s, COND_CC, MOVCC_XCC, a0, a1, false);
> +    }
> +}
> +
> +static void tgen_subbi_rir(TCGContext *s, TCGType type,
> +                           TCGReg a0, tcg_target_long a1, TCGReg a2)
> +{
> +    tgen_subbi_rrr(s, type, a0, TCG_REG_G0, a2);
> +}
> +
> +static void tgen_subbi_rii(TCGContext *s, TCGType type,
> +                           TCGReg a0, tcg_target_long a1, tcg_target_long a2)
> +{
> +    tgen_subbi_rri(s, type, a0, TCG_REG_G0, a2);
> +}
> +
>   static const TCGOutOpAddSubCarry outop_subbi = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_O1_I2(r, rZ, rJ),
> +    .out_rrr = tgen_subbi_rrr,
> +    .out_rri = tgen_subbi_rri,
> +    .out_rir = tgen_subbi_rir,
> +    .out_rii = tgen_subbi_rii,
>   };
>   
> +static void tgen_subbio_rrr(TCGContext *s, TCGType type,
> +                            TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    if (type != TCG_TYPE_I32) {
> +        tcg_out_dup_xcc_c(s);
> +    }
> +    tcg_out_arith(s, a0, a1, a2, ARITH_SUBCCC);
> +}
> +
> +static void tgen_subbio_rri(TCGContext *s, TCGType type,
> +                            TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    if (type != TCG_TYPE_I32) {
> +        tcg_out_dup_xcc_c(s);
> +    }
> +    tcg_out_arithi(s, a0, a1, a2, ARITH_SUBCCC);
> +}
> +
> +static void tgen_subbio_rir(TCGContext *s, TCGType type,
> +                            TCGReg a0, tcg_target_long a1, TCGReg a2)
> +{
> +    tgen_subbio_rrr(s, type, a0, TCG_REG_G0, a2);
> +}
> +
> +static void tgen_subbio_rii(TCGContext *s, TCGType type,
> +                            TCGReg a0, tcg_target_long a1, tcg_target_long a2)
> +{
> +    tgen_subbio_rri(s, type, a0, TCG_REG_G0, a2);
> +}
> +
>   static const TCGOutOpAddSubCarry outop_subbio = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_O1_I2(r, rZ, rJ),
> +    .out_rrr = tgen_subbio_rrr,
> +    .out_rri = tgen_subbio_rri,
> +    .out_rir = tgen_subbio_rir,
> +    .out_rii = tgen_subbio_rii,
>   };
>   
>   static void tcg_out_set_borrow(TCGContext *s)
>   {
> -    g_assert_not_reached();
> +    tcg_out_set_carry(s);  /* borrow == carry */
>   }
>   
>   static void tgen_xor(TCGContext *s, TCGType type,

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


