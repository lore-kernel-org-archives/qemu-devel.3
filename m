Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA189C369C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u58DD-0001rL-2N; Wed, 16 Apr 2025 15:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58DA-0001qx-Mk
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:14:16 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58D8-0005eW-6C
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:14:16 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736b350a22cso6243572b3a.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744830852; x=1745435652; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bK89Zs70miCLW8uY1aed2WVEpBd264qlvlB737SiO8k=;
 b=oUfXmVrwyCvsnBtv1PMFEZcaTyiNR6pdH81l9Lr/XWsnLTjWI/Bv10bUX16ptddcFA
 uqscX5Y0LCY1HRphPA0HGBW2uq3ZWV0jD/8kPlmnbbUt6tfMCwHXQSc62Ah1sk+SbQPB
 PDU+2AxUUxnU3H6i65hsMgpaeAdIO0fp1CwIj5OjC1DnQQ8/D6lB9G2fPohWJDV8UXCA
 T+MkbtUopG4hfvvk5FruNYVeH5uTwV47CDfkMroLxdwOEEj/JbMRnAuK1TXd9WMJtlq7
 NjX1+dyqKsB654D1QBwtqvUEVvhJkllad+HotY4VNwm1bkeyaCuevhUaEPcG4fvqEYh0
 Q9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744830852; x=1745435652;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bK89Zs70miCLW8uY1aed2WVEpBd264qlvlB737SiO8k=;
 b=eR66NdmrjA51r61pC+ri7OTlSt74YIteRp+mpqGnmXXEV9ZBe/Ly4mSZ3BXI7R/KiM
 4Udg6+HDElX3PTLuEQoE7/7NVdJqBPTt3AFaNQFeddoo/MQZf+qqRt9AwDeIathnWfMT
 5bw6cupdW74z4NpmouuWkp15mazjRgOeAvwa3a4fBB/PLh7W6kEhiO0MP1+EYDp0H+yV
 7hKBmct44QSm9+bnRvjZr/nJ0j4dtvRgIzt+hkq3mTNP75bPHDgHtjYsBnusuk3eNOuE
 k4v4xAz2DsXPvArz02hwjgq0TGAVCR83Fy2vW8b9/SJmiRUzFVL0DJuNsGjKXB3t12z0
 1g1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFIXd3+RCZey5MvaNbH0HYQibxq3K4f1j1uxJUdN5/BzzPHv26HORA1Vl0YeOCkEgMecJ73xJuu6dk@nongnu.org
X-Gm-Message-State: AOJu0YxGSE+P2yfDQji8V5/E+QK0BMwQkzn5F7fRfXqB+KRsyzvGwyXk
 GvY+HAZtPtuJkH/a0myov9Xl1EgvQ2eBp2lZTQLlY8QWsQ9Kv4zhYNkxrUFKIC2zpAyOr1jW7lp
 o
X-Gm-Gg: ASbGnct3Zm2YPnCxIEax1fP210wYhXzc0DApGWMFsyejLrBI1FAC9yngGWPVgMtr6Yd
 adagZIqZolP3IkJHkqjHIgq773UGcDOQOSg0hEVa34bqhSATxuzC+KOrQlz49kNQWrj8VQTD7r+
 bWEuL8WoAN6yb9hqMqQtgfXYoe/G4Yeu3R4kFrea9ukP+060uqWkZ9YhUFfjDA64PPJhDBlJgwX
 s8EJUgkB+j6t/3kDsqiWyYR3o0UvdKYsjkE7SUkK5TXQ8Oj9W3TErrQ2dRYxDQDjuoTPyw0yspc
 sta4CBBHR0YNHpHy4cJ9rVDV5adED5PPKmlK55uQl128wTzx0CMVPA==
X-Google-Smtp-Source: AGHT+IHsbaIILHGw0Y1XJp4TCxCscL+wEogNwY7H4eT7dSzWkLYo/ccNfMRgwMS+YDQSi9dLAkhqsw==
X-Received: by 2002:a05:6a20:6706:b0:203:ba30:75ed with SMTP id
 adf61e73a8af0-203ba3077c7mr1499255637.30.1744830852366; 
 Wed, 16 Apr 2025 12:14:12 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0b220ab3cdsm1639138a12.9.2025.04.16.12.14.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 12:14:11 -0700 (PDT)
Message-ID: <1cf807b0-10a4-4db9-a0bf-7f34c55343fc@linaro.org>
Date: Wed, 16 Apr 2025 12:14:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 135/163] tcg/arm: Implement add/sub carry opcodes
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-136-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-136-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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
>   tcg/arm/tcg-target-con-set.h |   2 +
>   tcg/arm/tcg-target.c.inc     | 165 +++++++++++++++++++++++++++++++++--
>   2 files changed, 159 insertions(+), 8 deletions(-)
> 
> diff --git a/tcg/arm/tcg-target-con-set.h b/tcg/arm/tcg-target-con-set.h
> index f46a8444fb..a44625ba63 100644
> --- a/tcg/arm/tcg-target-con-set.h
> +++ b/tcg/arm/tcg-target-con-set.h
> @@ -31,6 +31,8 @@ C_O1_I2(r, r, rIK)
>   C_O1_I2(r, r, rIN)
>   C_O1_I2(r, r, ri)
>   C_O1_I2(r, rI, r)
> +C_O1_I2(r, rI, rIK)
> +C_O1_I2(r, rI, rIN)
>   C_O1_I2(r, rZ, rZ)
>   C_O1_I2(w, 0, w)
>   C_O1_I2(w, w, w)
> diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
> index aa0397520d..c464c54ffd 100644
> --- a/tcg/arm/tcg-target.c.inc
> +++ b/tcg/arm/tcg-target.c.inc
> @@ -178,6 +178,8 @@ typedef enum {
>       INSN_DMB_ISH   = 0xf57ff05b,
>       INSN_DMB_MCR   = 0xee070fba,
>   
> +    INSN_MSRI_CPSR = 0x0360f000,
> +
>       /* Architected nop introduced in v6k.  */
>       /* ??? This is an MSR (imm) 0,0,0 insn.  Anyone know if this
>          also Just So Happened to do nothing on pre-v6k so that we
> @@ -1826,21 +1828,74 @@ static const TCGOutOpBinary outop_add = {
>       .out_rri = tgen_addi,
>   };
>   
> +static void tgen_addco(TCGContext *s, TCGType type,
> +                       TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tcg_out_dat_reg(s, COND_AL, ARITH_ADD | TO_CPSR,
> +                    a0, a1, a2, SHIFT_IMM_LSL(0));
> +}
> +
> +static void tgen_addco_imm(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    tcg_out_dat_IN(s, COND_AL, ARITH_ADD | TO_CPSR, ARITH_SUB | TO_CPSR,
> +                   a0, a1, a2);
> +}
> +
>   static const TCGOutOpBinary outop_addco = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_O1_I2(r, r, rIN),
> +    .out_rrr = tgen_addco,
> +    .out_rri = tgen_addco_imm,
>   };
>   
> +static void tgen_addci(TCGContext *s, TCGType type,
> +                       TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tcg_out_dat_reg(s, COND_AL, ARITH_ADC, a0, a1, a2, SHIFT_IMM_LSL(0));
> +}
> +
> +static void tgen_addci_imm(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    tcg_out_dat_IK(s, COND_AL, ARITH_ADC, ARITH_SBC, a0, a1, a2);
> +}
> +
>   static const TCGOutOpAddSubCarry outop_addci = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_O1_I2(r, r, rIK),
> +    .out_rrr = tgen_addci,
> +    .out_rri = tgen_addci_imm,
>   };
>   
> +static void tgen_addcio(TCGContext *s, TCGType type,
> +                        TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tcg_out_dat_reg(s, COND_AL, ARITH_ADC | TO_CPSR,
> +                    a0, a1, a2, SHIFT_IMM_LSL(0));
> +}
> +
> +static void tgen_addcio_imm(TCGContext *s, TCGType type,
> +                            TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    tcg_out_dat_IK(s, COND_AL, ARITH_ADC | TO_CPSR, ARITH_SBC | TO_CPSR,
> +                   a0, a1, a2);
> +}
> +
>   static const TCGOutOpBinary outop_addcio = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_O1_I2(r, r, rIK),
> +    .out_rrr = tgen_addcio,
> +    .out_rri = tgen_addcio_imm,
>   };
>   
> +/* Set C to @c; NZVQ all set to 0. */
> +static void tcg_out_movi_apsr_c(TCGContext *s, bool c)
> +{
> +    int imm12 = encode_imm_nofail(c << 29);
> +    tcg_out32(s, (COND_AL << 28) | INSN_MSRI_CPSR | 0x80000 | imm12);
> +}
> +
>   static void tcg_out_set_carry(TCGContext *s)
>   {
> -    g_assert_not_reached();
> +    tcg_out_movi_apsr_c(s, 1);
>   }
>   
>   static void tgen_and(TCGContext *s, TCGType type,
> @@ -2152,21 +2207,115 @@ static const TCGOutOpSubtract outop_sub = {
>       .out_rir = tgen_subfi,
>   };
>   
> +static void tgen_subbo_rrr(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tcg_out_dat_reg(s, COND_AL, ARITH_SUB | TO_CPSR,
> +                    a0, a1, a2, SHIFT_IMM_LSL(0));
> +}
> +
> +static void tgen_subbo_rri(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    tcg_out_dat_IN(s, COND_AL, ARITH_SUB | TO_CPSR, ARITH_ADD | TO_CPSR,
> +                   a0, a1, a2);
> +}
> +
> +static void tgen_subbo_rir(TCGContext *s, TCGType type,
> +                           TCGReg a0, tcg_target_long a1, TCGReg a2)
> +{
> +    tcg_out_dat_imm(s, COND_AL, ARITH_RSB | TO_CPSR,
> +                    a0, a2, encode_imm_nofail(a1));
> +}
> +
> +static void tgen_subbo_rii(TCGContext *s, TCGType type,
> +                           TCGReg a0, tcg_target_long a1, tcg_target_long a2)
> +{
> +    tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, a2);
> +    tgen_subbo_rir(s, TCG_TYPE_I32, a0, a1, TCG_REG_TMP);
> +}
> +
>   static const TCGOutOpAddSubCarry outop_subbo = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_O1_I2(r, rI, rIN),
> +    .out_rrr = tgen_subbo_rrr,
> +    .out_rri = tgen_subbo_rri,
> +    .out_rir = tgen_subbo_rir,
> +    .out_rii = tgen_subbo_rii,
>   };
>   
> +static void tgen_subbi_rrr(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tcg_out_dat_reg(s, COND_AL, ARITH_SBC,
> +                    a0, a1, a2, SHIFT_IMM_LSL(0));
> +}
> +
> +static void tgen_subbi_rri(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    tcg_out_dat_IK(s, COND_AL, ARITH_SBC, ARITH_ADC, a0, a1, a2);
> +}
> +
> +static void tgen_subbi_rir(TCGContext *s, TCGType type,
> +                           TCGReg a0, tcg_target_long a1, TCGReg a2)
> +{
> +    tcg_out_dat_imm(s, COND_AL, ARITH_RSC, a0, a2, encode_imm_nofail(a1));
> +}
> +
> +static void tgen_subbi_rii(TCGContext *s, TCGType type,
> +                           TCGReg a0, tcg_target_long a1, tcg_target_long a2)
> +{
> +    tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, a2);
> +    tgen_subbi_rir(s, TCG_TYPE_I32, a0, a1, TCG_REG_TMP);
> +}
> +
>   static const TCGOutOpAddSubCarry outop_subbi = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_O1_I2(r, rI, rIK),
> +    .out_rrr = tgen_subbi_rrr,
> +    .out_rri = tgen_subbi_rri,
> +    .out_rir = tgen_subbi_rir,
> +    .out_rii = tgen_subbi_rii,
>   };
>   
> +static void tgen_subbio_rrr(TCGContext *s, TCGType type,
> +                            TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tcg_out_dat_reg(s, COND_AL, ARITH_SBC | TO_CPSR,
> +                    a0, a1, a2, SHIFT_IMM_LSL(0));
> +}
> +
> +static void tgen_subbio_rri(TCGContext *s, TCGType type,
> +                            TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    tcg_out_dat_IK(s, COND_AL, ARITH_SBC | TO_CPSR, ARITH_ADC | TO_CPSR,
> +                   a0, a1, a2);
> +}
> +
> +static void tgen_subbio_rir(TCGContext *s, TCGType type,
> +                            TCGReg a0, tcg_target_long a1, TCGReg a2)
> +{
> +    tcg_out_dat_imm(s, COND_AL, ARITH_RSC | TO_CPSR,
> +                    a0, a2, encode_imm_nofail(a1));
> +}
> +
> +static void tgen_subbio_rii(TCGContext *s, TCGType type,
> +                            TCGReg a0, tcg_target_long a1, tcg_target_long a2)
> +{
> +    tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, a2);
> +    tgen_subbio_rir(s, TCG_TYPE_I32, a0, a1, TCG_REG_TMP);
> +}
> +
>   static const TCGOutOpAddSubCarry outop_subbio = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_O1_I2(r, rI, rIK),
> +    .out_rrr = tgen_subbio_rrr,
> +    .out_rri = tgen_subbio_rri,
> +    .out_rir = tgen_subbio_rir,
> +    .out_rii = tgen_subbio_rii,
>   };
>   
>   static void tcg_out_set_borrow(TCGContext *s)
>   {
> -    g_assert_not_reached();
> +    tcg_out_movi_apsr_c(s, 0);  /* borrow = !carry */
>   }
>   
>   static void tgen_xor(TCGContext *s, TCGType type,

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


