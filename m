Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADB3C369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u58Ds-0002xR-6c; Wed, 16 Apr 2025 15:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58Dm-0002pp-2v
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:14:54 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58Dj-0005hw-QC
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:14:53 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22438c356c8so404105ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744830890; x=1745435690; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9s+F9l2Urj1rdMxCv2StG+ffazsDzTQx4496C7TO9jc=;
 b=J1v4tsz3XvK7yMMQshM0/g9N/+h+gMgS3ALFt0K3AX/Kbh3MOPUcp/wHXjsNJk9PnX
 97B/TRYkyydBjDKIwCK3w0+zLwG7VwE8De0zYNDk8jReovmSUuLdxFVG0YZGKdIyWk/y
 NJ9nmFYtzj/ojVRryN+YrcTK20W/CqoPm3VnQpLdxWmkT2lmILy5efaNbZBZu8WSUHjz
 cyrirXJ85By4tuOQYS7CUldIbMpVYPhSbhtPi9AJpq0skyGXyxbBq3L6FrwAmzUPnk4X
 +TuePhhvQDsArz7N5GQVYOIAiyPDpHkl7pEH0MxjfD38v4sBsxGSw29Xzfk8B0kHFlER
 JMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744830890; x=1745435690;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9s+F9l2Urj1rdMxCv2StG+ffazsDzTQx4496C7TO9jc=;
 b=BAPk421lzR1nekpLua2Bni3Di5LSlDnBLzawjAoSOLsuxdnxI26D5TQ4+6dFMWf6hk
 L5ry+O3PyjvJmMHCj8NRJZtGTVu9cHbK50HB4xS4uHNqoybgf4FZ6Tg+rtm5UGI91H6F
 RH9/MNSWUoeGzRO0Zj0NtPeEp4bGyqLo/u+Yzz/hMIlflre5xYPY8XpZBvxO9LvUlyQD
 7EGdFU03puibHXcBdZ56FTnFjObQ9dcWCJC/XSNlIbz9GiK03qhFqDLXco9C41FKYJO8
 dAY1M/2zIIt12bARx/IADkFaaEsR+mk/7MU0b+Xkk1H7yW9NpwBiO53Mc58wXZVz+yNP
 +RFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5w/BcFuuqaxd0nXQZywiLOc+ZBVxVH4S1rZhYm0sc1KZHHcnWL+/KPunx2mSO2LoJqOnxG+nm5H4k@nongnu.org
X-Gm-Message-State: AOJu0YzL1kKxRhpuJdr7kLBmnjUYb8KidA6wSfr09Nfks0yNcdmK+oMX
 xFENIC097fw28v0YXlauBz0AHwfbrejkOvH4G2biuw3PIqnJjXaGU0QP32JfabA=
X-Gm-Gg: ASbGncstBO643VavtBi18QUpYh2CSFe7PS8AOv7wzanIy7ujFVVznuARIeSIzS1ZgUq
 o3ieAT+0qhCvmNyMtNL5cm9ipvzOYMRQULhVSlz22mWMPnFmjkZYhNGQtjSCOI5yRN9ED9ADJdT
 kx0jhbEYH+BHHfPfgOFye+T89KyzZzG0yIarAVLpIJSRqpk1IBdw5Yf+Y2OrZq2OZENUmhi/UrI
 y4mXmemQsJknz7dQ5/BeftBlp+l/JrUsH324Iy7qlnm14iNwg/+RGhP7lfUK3HxmLzF/kZ0Eeq/
 gcfjuGMK37hFcSTKycOAiAQwa45SIhJYq3YVUZHozs0qWkXDVgGWLw==
X-Google-Smtp-Source: AGHT+IHQwiopyWkne/CvSUIKt+wfaDLVZ20i/njE4RqOlIpaTh3/Qlo4vKvQxpcJsn+u8CiuXWem9Q==
X-Received: by 2002:a17:902:e5c3:b0:21f:8453:7484 with SMTP id
 d9443c01a7336-22c359176e9mr39226535ad.30.1744830889895; 
 Wed, 16 Apr 2025 12:14:49 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33fc4bbasm18062555ad.172.2025.04.16.12.14.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 12:14:49 -0700 (PDT)
Message-ID: <f6a4f37a-44bc-46a6-b893-e8138532ed34@linaro.org>
Date: Wed, 16 Apr 2025 12:14:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 137/163] tcg/ppc: Implement add/sub carry opcodes
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-138-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-138-richard.henderson@linaro.org>
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
>   tcg/ppc/tcg-target-con-set.h |   3 +
>   tcg/ppc/tcg-target-con-str.h |   1 +
>   tcg/ppc/tcg-target.c.inc     | 167 ++++++++++++++++++++++++++++++-----
>   3 files changed, 150 insertions(+), 21 deletions(-)
> 
> diff --git a/tcg/ppc/tcg-target-con-set.h b/tcg/ppc/tcg-target-con-set.h
> index 14cd217287..9ea26c40ae 100644
> --- a/tcg/ppc/tcg-target-con-set.h
> +++ b/tcg/ppc/tcg-target-con-set.h
> @@ -29,7 +29,10 @@ C_O1_I2(r, r, rC)
>   C_O1_I2(r, r, rI)
>   C_O1_I2(r, r, rT)
>   C_O1_I2(r, r, rU)
> +C_O1_I2(r, r, rZM)
>   C_O1_I2(r, r, rZW)
> +C_O1_I2(r, rI, rN)
> +C_O1_I2(r, rZM, rZM)
>   C_O1_I2(v, v, v)
>   C_O1_I3(v, v, v, v)
>   C_O1_I4(v, v, v, vZM, v)
> diff --git a/tcg/ppc/tcg-target-con-str.h b/tcg/ppc/tcg-target-con-str.h
> index 16b687216e..faf92da47f 100644
> --- a/tcg/ppc/tcg-target-con-str.h
> +++ b/tcg/ppc/tcg-target-con-str.h
> @@ -19,6 +19,7 @@ REGS('v', ALL_VECTOR_REGS)
>   CONST('C', TCG_CT_CONST_CMP)
>   CONST('I', TCG_CT_CONST_S16)
>   CONST('M', TCG_CT_CONST_MONE)
> +CONST('N', TCG_CT_CONST_N16)
>   CONST('T', TCG_CT_CONST_S32)
>   CONST('U', TCG_CT_CONST_U32)
>   CONST('W', TCG_CT_CONST_WSZ)
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index 5b04655f3b..0b151db0e4 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -89,14 +89,15 @@
>   /* Shorthand for size of a register.  */
>   #define SZR  (TCG_TARGET_REG_BITS / 8)
>   
> -#define TCG_CT_CONST_S16  0x100
> -#define TCG_CT_CONST_U16  0x200
> -#define TCG_CT_CONST_S32  0x400
> -#define TCG_CT_CONST_U32  0x800
> -#define TCG_CT_CONST_ZERO 0x1000
> -#define TCG_CT_CONST_MONE 0x2000
> -#define TCG_CT_CONST_WSZ  0x4000
> -#define TCG_CT_CONST_CMP  0x8000
> +#define TCG_CT_CONST_S16     0x00100
> +#define TCG_CT_CONST_U16     0x00200
> +#define TCG_CT_CONST_N16     0x00400
> +#define TCG_CT_CONST_S32     0x00800
> +#define TCG_CT_CONST_U32     0x01000
> +#define TCG_CT_CONST_ZERO    0x02000
> +#define TCG_CT_CONST_MONE    0x04000
> +#define TCG_CT_CONST_WSZ     0x08000
> +#define TCG_CT_CONST_CMP     0x10000
>   
>   #define ALL_GENERAL_REGS  0xffffffffu
>   #define ALL_VECTOR_REGS   0xffffffff00000000ull
> @@ -342,6 +343,9 @@ static bool tcg_target_const_match(int64_t sval, int ct,
>       if ((ct & TCG_CT_CONST_U16) && uval == (uint16_t)uval) {
>           return 1;
>       }
> +    if ((ct & TCG_CT_CONST_N16) && -sval == (int16_t)-sval) {
> +        return 1;
> +    }
>       if ((ct & TCG_CT_CONST_S32) && sval == (int32_t)sval) {
>           return 1;
>       }
> @@ -2863,21 +2867,69 @@ static const TCGOutOpBinary outop_add = {
>       .out_rri = tgen_addi,
>   };
>   
> +static void tgen_addco_rrr(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tcg_out32(s, ADDC | TAB(a0, a1, a2));
> +}
> +
> +static void tgen_addco_rri(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    tcg_out32(s, ADDIC | TAI(a0, a1, a2));
> +}
> +
> +static TCGConstraintSetIndex cset_addco(TCGType type, unsigned flags)
> +{
> +    /*
> +     * Note that the CA bit is defined based on the word size of the
> +     * environment.  So in 64-bit mode it's always carry-out of bit 63.
> +     * The fallback code using deposit works just as well for TCG_TYPE_I32.
> +     */
> +    return type == TCG_TYPE_REG ? C_O1_I2(r, r, rI) : C_NotImplemented;
> +}
> +
>   static const TCGOutOpBinary outop_addco = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_Dynamic,
> +    .base.dynamic_constraint = cset_addco,
> +    .out_rrr = tgen_addco_rrr,
> +    .out_rri = tgen_addco_rri,
> +};
> +
> +static void tgen_addcio_rrr(TCGContext *s, TCGType type,
> +                            TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tcg_out32(s, ADDE | TAB(a0, a1, a2));
> +}
> +
> +static void tgen_addcio_rri(TCGContext *s, TCGType type,
> +                            TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    tcg_out32(s, (a2 ? ADDME : ADDZE) | RT(a0) | RA(a1));
> +}
> +
> +static TCGConstraintSetIndex cset_addcio(TCGType type, unsigned flags)
> +{
> +    return type == TCG_TYPE_REG ? C_O1_I2(r, r, rZM) : C_NotImplemented;
> +}
> +
> +static const TCGOutOpBinary outop_addcio = {
> +    .base.static_constraint = C_Dynamic,
> +    .base.dynamic_constraint = cset_addcio,
> +    .out_rrr = tgen_addcio_rrr,
> +    .out_rri = tgen_addcio_rri,
>   };
>   
>   static const TCGOutOpAddSubCarry outop_addci = {
> -    .base.static_constraint = C_NotImplemented,
> -};
> -
> -static const TCGOutOpBinary outop_addcio = {
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
> +    tcg_out32(s, SUBFC | TAB(TCG_REG_R0, TCG_REG_R0, TCG_REG_R0));
>   }
>   
>   static void tgen_and(TCGContext *s, TCGType type,
> @@ -3284,21 +3336,94 @@ static const TCGOutOpSubtract outop_sub = {
>       .out_rir = tgen_subfi,
>   };
>   
> +static void tgen_subbo_rrr(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tcg_out32(s, SUBFC | TAB(a0, a2, a1));
> +}
> +
> +static void tgen_subbo_rri(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    if (a2 == 0) {
> +        tcg_out_movi(s, type, TCG_REG_R0, 0);
> +        tgen_subbo_rrr(s, type, a0, a1, TCG_REG_R0);
> +    } else {
> +        tgen_addco_rri(s, type, a0, a1, -a2);
> +    }
> +}
> +
> +/* The underlying insn for subfi is subfic. */
> +#define tgen_subbo_rir  tgen_subfi
> +
> +static void tgen_subbo_rii(TCGContext *s, TCGType type,
> +                           TCGReg a0, tcg_target_long a1, tcg_target_long a2)
> +{
> +    tcg_out_movi(s, type, TCG_REG_R0, a2);
> +    tgen_subbo_rir(s, type, a0, a1, TCG_REG_R0);
> +}
> +
> +static TCGConstraintSetIndex cset_subbo(TCGType type, unsigned flags)
> +{
> +    /* Recall that the CA bit is defined based on the host word size. */
> +    return type == TCG_TYPE_REG ? C_O1_I2(r, rI, rN) : C_NotImplemented;
> +}
> +
>   static const TCGOutOpAddSubCarry outop_subbo = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_Dynamic,
> +    .base.dynamic_constraint = cset_subbo,
> +    .out_rrr = tgen_subbo_rrr,
> +    .out_rri = tgen_subbo_rri,
> +    .out_rir = tgen_subbo_rir,
> +    .out_rii = tgen_subbo_rii,
>   };
>   
> -static const TCGOutOpAddSubCarry outop_subbi = {
> -    .base.static_constraint = C_NotImplemented,
> -};
> +static void tgen_subbio_rrr(TCGContext *s, TCGType type,
> +                            TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tcg_out32(s, SUBFE | TAB(a0, a2, a1));
> +}
> +
> +static void tgen_subbio_rri(TCGContext *s, TCGType type,
> +                            TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    tgen_addcio_rri(s, type, a0, a1, ~a2);
> +}
> +
> +static void tgen_subbio_rir(TCGContext *s, TCGType type,
> +                            TCGReg a0, tcg_target_long a1, TCGReg a2)
> +{
> +    tcg_debug_assert(a1 == 0 || a1 == -1);
> +    tcg_out32(s, (a1 ? SUBFME : SUBFZE) | RT(a0) | RA(a2));
> +}
> +
> +static void tgen_subbio_rii(TCGContext *s, TCGType type,
> +                            TCGReg a0, tcg_target_long a1, tcg_target_long a2)
> +{
> +    tcg_out_movi(s, type, TCG_REG_R0, a2);
> +    tgen_subbio_rir(s, type, a0, a1, TCG_REG_R0);
> +}
> +
> +static TCGConstraintSetIndex cset_subbio(TCGType type, unsigned flags)
> +{
> +    return type == TCG_TYPE_REG ? C_O1_I2(r, rZM, rZM) : C_NotImplemented;
> +}
>   
>   static const TCGOutOpAddSubCarry outop_subbio = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_Dynamic,
> +    .base.dynamic_constraint = cset_subbio,
> +    .out_rrr = tgen_subbio_rrr,
> +    .out_rri = tgen_subbio_rri,
> +    .out_rir = tgen_subbio_rir,
> +    .out_rii = tgen_subbio_rii,
>   };
>   
> +#define outop_subbi  outop_subbio
> +
>   static void tcg_out_set_borrow(TCGContext *s)
>   {
> -    g_assert_not_reached();
> +    /* borrow = !carry */
> +    tcg_out32(s, ADDIC | TAI(TCG_REG_R0, TCG_REG_R0, 0));
>   }
>   
>   static void tgen_xor(TCGContext *s, TCGType type,

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


