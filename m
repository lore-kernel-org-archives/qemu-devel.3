Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B080C369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u589T-0006xj-TA; Wed, 16 Apr 2025 15:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u589Q-0006jl-Gj
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:10:24 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u589N-0005GH-U6
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:10:24 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2243803b776so629265ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744830620; x=1745435420; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZJxbHQQpGZ6yRl7pBvWQUJIO9oOvqRREXYDUKOEWiwo=;
 b=zpqOv151l0XxpExG8ykhfhv6vfekU356WxDtJaiu72ppi/UBPgZBm5KyKWj4j/Isoa
 ciagmWpIntqjzkyaaAPmSd4sBKmAMF+AYFEunOILqpTVXoJYE/zL75/MicxEm+zzfny4
 6C+3Fsix63EeG1Wv/duA67sGkU8/C9ie6TfWOPbTjREiL4RaYhi2gKaJGphDA7Ctk7fj
 xWKOForvjljrPHz6p9neHg5Vh7xJNIF2JR3Wu3jYaqRXfd0EmiJbVhHy8qj5aeK7Kqqq
 RO/G19Pv36g+TSRpZfnNaAM0b2z1h01SAOYYAz3Skvi69l8ydAenkuD/y41DXbw3Ve+K
 Elxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744830620; x=1745435420;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZJxbHQQpGZ6yRl7pBvWQUJIO9oOvqRREXYDUKOEWiwo=;
 b=b6h9ev6ZK91NiiyFRRq+Lc0Ahra2VnDn4ofvHphSXWpchAmFSzb34e1BbNPeWQIvzQ
 5jyrFrbOs8+FbY07Gj4ZNcgCfb2dK6xaHsXcwYurTZlyRHpMqANGiqQsvrWKf8vVPUm5
 WwQZ2SrKfClrsUkG7LvKLQUVQAhUoPx5Mi89dwSMqOvRU+ZiGfuyweaJCkJr9ovHMyTq
 Tz4pSU/ea738B8AWTBiYumZJi3qQxSGae/h8Ovu4Mb8H+GUTtSIQSOrNRNh1GamTYA75
 yz6t/NemPy8IuSP4gmBC2G2Tn+WdBaanCxS5K0hPwgefVf8BkiHzBWzwaLUkXP8imvUv
 DN3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsDAk39tkc741yo0qOCHxIK8ewDJymYeTkrqY0ePsS1wDrDRhAujd0+/hFBI8otzLT2lh8j2849vjH@nongnu.org
X-Gm-Message-State: AOJu0Yxlxz8qKydJFE9pgTmaM0mi0BC8QIvrtAuCIKBhqw/x9/9cVCON
 RptVm1xTfccV+NBqS5XmindHZUeYz0n6WJ/uKRejBGxt3wUX+RR2f7ciZh9Nl7M=
X-Gm-Gg: ASbGncu7HzHt/BcsPICIu3UutT//Fkc8Rk5r/EoEM0te43XcjohLR4PrWnGtn/PtJHF
 SXWDLKBNy8AO6lRyzR4ElO7sStr7ZW4WqZ26OmQG3y3SD2qWXEcHvrOkdPNYTiSLyX0YuES8UYf
 7YNq5de2P9bjuYVdb9wEudS1yTaC6K/beWZldtyOG6k5NehqHFWQe6/bNIW+yBE/8T6x4gg/nsD
 cBevnVPSe9yuWcX0MKXrHArG4lGwNDxK3x2H0mdq4WUpr4PmrngBgo7EsIJ9QZUYXUvZSeYxbm/
 AzOVJrPljFMQwVg0DSH6qGaV5ULq/2nRS6BR/UP9cXD6ONRNqiSl2w==
X-Google-Smtp-Source: AGHT+IErtJFzsF2E0C94EuC+tmDtOyKqrAgeS1avS5EfEmIP8UhDLGM7iUTdbsxjZqsUWI1zD/x5aQ==
X-Received: by 2002:a17:903:41cd:b0:220:d078:eb33 with SMTP id
 d9443c01a7336-22c3596f812mr40934985ad.36.1744830619809; 
 Wed, 16 Apr 2025 12:10:19 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33fac055sm17991315ad.107.2025.04.16.12.10.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 12:10:19 -0700 (PDT)
Message-ID: <6bc545d9-334a-4b53-899d-87ab9e0dedae@linaro.org>
Date: Wed, 16 Apr 2025 12:10:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 133/163] tcg/aarch64: Implement add/sub carry opcodes
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-134-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-134-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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
>   tcg/aarch64/tcg-target-con-set.h |   2 +
>   tcg/aarch64/tcg-target.c.inc     | 152 +++++++++++++++++++++++++++++--
>   2 files changed, 146 insertions(+), 8 deletions(-)
> 
> diff --git a/tcg/aarch64/tcg-target-con-set.h b/tcg/aarch64/tcg-target-con-set.h
> index 2eda499cd3..02a0be66fd 100644
> --- a/tcg/aarch64/tcg-target-con-set.h
> +++ b/tcg/aarch64/tcg-target-con-set.h
> @@ -24,6 +24,8 @@ C_O1_I2(r, r, rAL)
>   C_O1_I2(r, r, rC)
>   C_O1_I2(r, r, ri)
>   C_O1_I2(r, r, rL)
> +C_O1_I2(r, rZ, rA)
> +C_O1_I2(r, rz, rMZ)
>   C_O1_I2(r, rz, rz)
>   C_O1_I2(r, rZ, rZ)
>   C_O1_I2(w, 0, w)
> diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
> index 87f8c98ed7..9dc6bf3e3d 100644
> --- a/tcg/aarch64/tcg-target.c.inc
> +++ b/tcg/aarch64/tcg-target.c.inc
> @@ -508,7 +508,9 @@ typedef enum {
>   
>       /* Add/subtract with carry instructions.  */
>       I3503_ADC       = 0x1a000000,
> +    I3503_ADCS      = 0x3a000000,
>       I3503_SBC       = 0x5a000000,
> +    I3503_SBCS      = 0x7a000000,
>   
>       /* Conditional select instructions.  */
>       I3506_CSEL      = 0x1a800000,
> @@ -2078,21 +2080,81 @@ static const TCGOutOpBinary outop_add = {
>       .out_rri = tgen_addi,
>   };
>   
> +static void tgen_addco(TCGContext *s, TCGType type,
> +                       TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tcg_out_insn(s, 3502, ADDS, type, a0, a1, a2);
> +}
> +
> +static void tgen_addco_imm(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    if (a2 >= 0) {
> +        tcg_out_insn(s, 3401, ADDSI, type, a0, a1, a2);
> +    } else {
> +        tcg_out_insn(s, 3401, SUBSI, type, a0, a1, -a2);
> +    }
> +}
> +
>   static const TCGOutOpBinary outop_addco = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_O1_I2(r, r, rA),
> +    .out_rrr = tgen_addco,
> +    .out_rri = tgen_addco_imm,
>   };
>   
> +static void tgen_addci_rrr(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tcg_out_insn(s, 3503, ADC, type, a0, a1, a2);
> +}
> +
> +static void tgen_addci_rri(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    /*
> +     * Note that the only two constants we support are 0 and -1, and
> +     * that SBC = rn + ~rm + c, so adc -1 is sbc 0, and vice-versa.
> +     */
> +    if (a2) {
> +        tcg_out_insn(s, 3503, SBC, type, a0, a1, TCG_REG_XZR);
> +    } else {
> +        tcg_out_insn(s, 3503, ADC, type, a0, a1, TCG_REG_XZR);
> +    }
> +}
> +
>   static const TCGOutOpAddSubCarry outop_addci = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_O1_I2(r, rz, rMZ),
> +    .out_rrr = tgen_addci_rrr,
> +    .out_rri = tgen_addci_rri,
>   };
>   
> +static void tgen_addcio(TCGContext *s, TCGType type,
> +                        TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tcg_out_insn(s, 3503, ADCS, type, a0, a1, a2);
> +}
> +
> +static void tgen_addcio_imm(TCGContext *s, TCGType type,
> +                            TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    /* Use SBCS w/0 for ADCS w/-1 -- see above. */
> +    if (a2) {
> +        tcg_out_insn(s, 3503, SBCS, type, a0, a1, TCG_REG_XZR);
> +    } else {
> +        tcg_out_insn(s, 3503, ADCS, type, a0, a1, TCG_REG_XZR);
> +    }
> +}
> +
>   static const TCGOutOpBinary outop_addcio = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_O1_I2(r, rz, rMZ),
> +    .out_rrr = tgen_addcio,
> +    .out_rri = tgen_addcio_imm,
>   };
>   
>   static void tcg_out_set_carry(TCGContext *s)
>   {
> -    g_assert_not_reached();
> +    tcg_out_insn(s, 3502, SUBS, TCG_TYPE_I32,
> +                 TCG_REG_XZR, TCG_REG_XZR, TCG_REG_XZR);
>   }
>   
>   static void tgen_and(TCGContext *s, TCGType type,
> @@ -2438,21 +2500,95 @@ static const TCGOutOpSubtract outop_sub = {
>       .out_rrr = tgen_sub,
>   };
>   
> +static void tgen_subbo_rrr(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tcg_out_insn(s, 3502, SUBS, type, a0, a1, a2);
> +}
> +
> +static void tgen_subbo_rri(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    if (a2 >= 0) {
> +        tcg_out_insn(s, 3401, SUBSI, type, a0, a1, a2);
> +    } else {
> +        tcg_out_insn(s, 3401, ADDSI, type, a0, a1, -a2);
> +    }
> +}
> +
> +static void tgen_subbo_rir(TCGContext *s, TCGType type,
> +                           TCGReg a0, tcg_target_long a1, TCGReg a2)
> +{
> +    tgen_subbo_rrr(s, type, a0, TCG_REG_XZR, a2);
> +}
> +
> +static void tgen_subbo_rii(TCGContext *s, TCGType type,
> +                           TCGReg a0, tcg_target_long a1, tcg_target_long a2)
> +{
> +    if (a2 == 0) {
> +        tgen_subbo_rrr(s, type, a0, TCG_REG_XZR, TCG_REG_XZR);
> +        return;
> +    }
> +
> +    /*
> +     * We want to allow a1 to be zero for the benefit of negation via
> +     * subtraction.  However, that leaves open the possibility of
> +     * adding 0 +/- const, and the immediate add/sub instructions
> +     * encode XSP not XZR.  Since we have 0 - non-zero, borrow is
> +     * always set.
> +     */
> +    tcg_out_movi(s, type, a0, -a2);
> +    tcg_out_set_borrow(s);
> +}
> +
>   static const TCGOutOpAddSubCarry outop_subbo = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_O1_I2(r, rZ, rA),
> +    .out_rrr = tgen_subbo_rrr,
> +    .out_rri = tgen_subbo_rri,
> +    .out_rir = tgen_subbo_rir,
> +    .out_rii = tgen_subbo_rii,
>   };
>   
> +static void tgen_subbi_rrr(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tcg_out_insn(s, 3503, SBC, type, a0, a1, a2);
> +}
> +
> +static void tgen_subbi_rri(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    tgen_addci_rri(s, type, a0, a1, ~a2);
> +}
> +
>   static const TCGOutOpAddSubCarry outop_subbi = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_O1_I2(r, rz, rMZ),
> +    .out_rrr = tgen_subbi_rrr,
> +    .out_rri = tgen_subbi_rri,
>   };
>   
> +static void tgen_subbio_rrr(TCGContext *s, TCGType type,
> +                            TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tcg_out_insn(s, 3503, SBCS, type, a0, a1, a2);
> +}
> +
> +static void tgen_subbio_rri(TCGContext *s, TCGType type,
> +                            TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    tgen_addcio_imm(s, type, a0, a1, ~a2);
> +}
> +
>   static const TCGOutOpAddSubCarry outop_subbio = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_O1_I2(r, rz, rMZ),
> +    .out_rrr = tgen_subbio_rrr,
> +    .out_rri = tgen_subbio_rri,
>   };
>   
>   static void tcg_out_set_borrow(TCGContext *s)
>   {
> -    g_assert_not_reached();
> +    tcg_out_insn(s, 3502, ADDS, TCG_TYPE_I32,
> +                 TCG_REG_XZR, TCG_REG_XZR, TCG_REG_XZR);
>   }
>   
>   static void tgen_xor(TCGContext *s, TCGType type,

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


