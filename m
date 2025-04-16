Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB6CC369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 18:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u57xY-00011E-Er; Wed, 16 Apr 2025 14:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u57xW-0000vQ-2v
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 14:58:06 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u57xT-0003Cx-Vi
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 14:58:05 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-223fd89d036so248615ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 11:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744829882; x=1745434682; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RCi8mD+1W7DIBlz8v9d2PM/Kq6IvEPrdRM8TvsdNEjc=;
 b=PgVfyVk+Q1MTzHxekVN1743NyXV8NbqM/DN2NMGqNKpTrXXEbcF0wcsCM7S/t87wMu
 jXtBEr0Qnq88dFwK30i7CDR7tJHhFzYDZI82M7cC7OPpAEPlcLnfqC45Qtw35m9Ki0HE
 UB7eZkpDIPPzSPKPz1YCtmNTYqE20pqDzIVYWuEB+A558O3DO5XYaHhHIuL8Nmwhbx4x
 RKXD4JrV4X+AZ8S7OC2IC2skorfq8P5Ks66ibvvCHcZn5zseHcx2+Ratli2Ut4dInu7j
 PajOW2NAKrHKlDsXdPz25UIA62gkQEqolGFwVABabUtpsIDAfJU0YTWD2XVNsjWF4SGb
 5ocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744829882; x=1745434682;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RCi8mD+1W7DIBlz8v9d2PM/Kq6IvEPrdRM8TvsdNEjc=;
 b=t1bSI9UxD35LoRHFjs0QjAzdIMgfLkrYYg6G45Qa168bSA7aBT5rrzDVkw+T4dzgFb
 2t/3zfHzDXjv7VOgMih3g1GVBKooj1OjN6mmo31pPkbOsNUUI4g4kcF05FWjvsWuuRXB
 XDPFWC0+1tf39thUiJjcL/gMDBwLBN83R8dUCSiRoisubEMBY8H8FKSJ/6ndQwfc55Ci
 oTfPFqDqqZ911W5H3T9LZ4oSEHjyUVJPBNBRsr+K4N64+9gWbgQuNutJvwN0yKwTg03X
 9Xx0u2g8131MW71fi10VQNyNs4NP/hVGXG5TwVYWbmtRwQSIITV4eJLLOTKhm9x29C84
 q60g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb8Cb/aYO2ftmBh8IFAwDY17WLBRyCBlVAB/AD6huJXmLrJ0RShEqK9tAhsDE+Enninp2+AhCdA4Js@nongnu.org
X-Gm-Message-State: AOJu0YzE2tXWWD+XlmtuqdUcqlyHzTEXOfrb99viapj1bWBSDVMRv2wl
 wHmyXCS+CcZlaltFJ8JATqCKmhtqmbLlhBBu5nKULk9DwHg4rIGS4XncaFNwP3I=
X-Gm-Gg: ASbGncv7YHnl0iKXgZ2IcW++3gkIlvEkFccImUekcduPMH/6XX9dv4XUGFI/4nxJLj/
 vCasRynzT/hCeH6FbrRl6vRMamuG6shef8BB6UR7YHOQWfyKHBT5T0qDGcvsAreHQj1ZKfLChZT
 6XbkiiuiFrtUxq816hVG9oDCBm10JI2YGHyD+EyEa/8kgiHooUiLv+oVhMlUo8FLJLXqw7ZE6PA
 yZvZT/0lHBq78TN+oYrJkp7cNME0nliysNEo8M1hcfxl6FY20Exin1jdT5UYBlyqsBl0iw2ZQbJ
 ZNrmetcE5lvUieIknfLrQ6hqiuxng8HMkPdJmslJW40uVuwNdmWfOw==
X-Google-Smtp-Source: AGHT+IGaVbocphgt7EgJTcsWDBnCKtL6vFVj7VcIwf6Rj54+oQMOuCWsOv4yILpNJmewwEw9QUT0Zw==
X-Received: by 2002:a17:903:2f83:b0:22c:33b2:e410 with SMTP id
 d9443c01a7336-22c358c6110mr43972415ad.2.1744829882392; 
 Wed, 16 Apr 2025 11:58:02 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33ef0f2bsm18098825ad.27.2025.04.16.11.58.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 11:58:02 -0700 (PDT)
Message-ID: <490d761b-4658-45e7-81bc-b1cfa7bd32f2@linaro.org>
Date: Wed, 16 Apr 2025 11:58:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 120/163] tcg/i386: Implement add/sub carry opcodes
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-121-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-121-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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
>   tcg/i386/tcg-target.c.inc | 86 ++++++++++++++++++++++++++++++++-------
>   1 file changed, 72 insertions(+), 14 deletions(-)
> 
> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index 8e0ccbc722..52d3402f29 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc
> @@ -424,6 +424,7 @@ static bool tcg_target_const_match(int64_t val, int ct,
>   #define OPC_SHLX        (0xf7 | P_EXT38 | P_DATA16)
>   #define OPC_SHRX        (0xf7 | P_EXT38 | P_SIMDF2)
>   #define OPC_SHRD_Ib     (0xac | P_EXT)
> +#define OPC_STC         (0xf9)
>   #define OPC_TESTB	(0x84)
>   #define OPC_TESTL	(0x85)
>   #define OPC_TZCNT       (0xbc | P_EXT | P_SIMDF3)
> @@ -2629,21 +2630,55 @@ static const TCGOutOpBinary outop_add = {
>       .out_rri = tgen_addi,
>   };
>   
> +static void tgen_addco(TCGContext *s, TCGType type,
> +                       TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
> +    tgen_arithr(s, ARITH_ADD + rexw, a0, a2);
> +}
> +
> +static void tgen_addco_imm(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
> +    tgen_arithi(s, ARITH_ADD + rexw, a0, a2, true);
> +}
> +
>   static const TCGOutOpBinary outop_addco = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_O1_I2(r, 0, re),
> +    .out_rrr = tgen_addco,
> +    .out_rri = tgen_addco_imm,
> +};
> +
> +static void tgen_addcio(TCGContext *s, TCGType type,
> +                        TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
> +    tgen_arithr(s, ARITH_ADC + rexw, a0, a2);
> +}
> +
> +static void tgen_addcio_imm(TCGContext *s, TCGType type,
> +                            TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
> +    tgen_arithi(s, ARITH_ADC + rexw, a0, a2, true);
> +}
> +
> +static const TCGOutOpBinary outop_addcio = {
> +    .base.static_constraint = C_O1_I2(r, 0, re),
> +    .out_rrr = tgen_addcio,
> +    .out_rri = tgen_addcio_imm,
>   };
>   
>   static const TCGOutOpAddSubCarry outop_addci = {
> -    .base.static_constraint = C_NotImplemented,
> -};
> -
> -static const TCGOutOpBinary outop_addcio = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_O1_I2(r, 0, re),
> +    .out_rrr = tgen_addcio,
> +    .out_rri = tgen_addcio_imm,
>   };
>   
>   static void tcg_out_set_carry(TCGContext *s)
>   {
> -    g_assert_not_reached();
> +    tcg_out8(s, OPC_STC);
>   }
>   
>   static void tgen_and(TCGContext *s, TCGType type,
> @@ -3060,7 +3095,7 @@ static const TCGOutOpBinary outop_shr = {
>   };
>   
>   static void tgen_sub(TCGContext *s, TCGType type,
> -                      TCGReg a0, TCGReg a1, TCGReg a2)
> +                     TCGReg a0, TCGReg a1, TCGReg a2)
>   {
>       int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
>       tgen_arithr(s, ARITH_SUB + rexw, a0, a2);
> @@ -3071,21 +3106,44 @@ static const TCGOutOpSubtract outop_sub = {
>       .out_rrr = tgen_sub,
>   };
>   
> +static void tgen_subbo_rri(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
> +    tgen_arithi(s, ARITH_SUB + rexw, a0, a2, 1);
> +}
> +
>   static const TCGOutOpAddSubCarry outop_subbo = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_O1_I2(r, 0, re),
> +    .out_rrr = tgen_sub,
> +    .out_rri = tgen_subbo_rri,
>   };
>   
> -static const TCGOutOpAddSubCarry outop_subbi = {
> -    .base.static_constraint = C_NotImplemented,
> -};
> +static void tgen_subbio_rrr(TCGContext *s, TCGType type,
> +                            TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
> +    tgen_arithr(s, ARITH_SBB + rexw, a0, a2);
> +}
> +
> +static void tgen_subbio_rri(TCGContext *s, TCGType type,
> +                            TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
> +    tgen_arithi(s, ARITH_SBB + rexw, a0, a2, 1);
> +}
>   
>   static const TCGOutOpAddSubCarry outop_subbio = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_O1_I2(r, 0, re),
> +    .out_rrr = tgen_subbio_rrr,
> +    .out_rri = tgen_subbio_rri,
>   };
>   
> +#define outop_subbi  outop_subbio
> +
>   static void tcg_out_set_borrow(TCGContext *s)
>   {
> -    g_assert_not_reached();
> +    tcg_out8(s, OPC_STC);
>   }
>   
>   static void tgen_xor(TCGContext *s, TCGType type,

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


