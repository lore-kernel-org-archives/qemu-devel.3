Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C253C021B8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzVC-0005ds-13; Tue, 25 Feb 2025 13:17:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tmzV1-0005au-Au
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:17:46 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tmzUy-0004Bq-Nr
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:17:42 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43984e9cc90so417735e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740507458; x=1741112258; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IuJO9SkFTk9tMMBk/59Flydos/EMivpe/dqEWMjRbpA=;
 b=Wk7Lt/jw8+jzbYe+2FI4QXRFuEg2EtSgD1Pb1lNpXsWa+7ud59QSQBqe4cxIIIIExl
 6ieYZ+aarBNXDpfYGGCqjK+mwMnVgy4MuDYjm3rqFgiILiBo2xi5KxH4SHJ4wdUL3De/
 XvuiZjwKNSjXbdO5OhLoHhZDz60gKesi+/oibN4yZTIDW/s2vc3eoDi/254s1yqT59je
 MV+gvXR6f9NWbdeWUA6BfQmWSA+XdPvWIerQrYiD3Tryz9G15Q2LRCdqJfrYui676hlX
 wXArcRAJzLGrbssIDWkg6LxoBJDFHgaBBqtDIfMBWQ379L2RXMl1SCX/kLHNGSj40SS+
 YE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740507458; x=1741112258;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IuJO9SkFTk9tMMBk/59Flydos/EMivpe/dqEWMjRbpA=;
 b=AYagBrtAEFXGnbBHDWxz0Mbr+SCdb8K5a5X0SCnBvoQFk7KxTry/h0XupfkTFT/o7r
 WGPVikwtS3ACfcLq7Vns3vOGKRjMyATnBunqA4Cr0QofgvQqRUcr4zIBhPI8kbhtGOOO
 +TmiiV89osT1dAjEEq3fypMHWgszY827HseyRSRvzYBmc/mrolmrLtq/c02AXqdKvCzU
 8ALQK0gF235Uud6kYXuC+kuWXl0eqbhoV+23dYyrDzZpZ7Gcu8FQ+/DTsWqfxqbhNH1V
 8lbJkL39slE9LkzlYiKFBP0yoSox9WYQuRTeTrCGHFKs5FxBU3Y+M7ysmL1FpPE6eJZ+
 XhfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHsP2+Awxco+dcqcPGJqT8zoHKZxFZNUbXCfj8QylqXAWYmwH9FjalNAbevbp1UVdTQ2SUncn8SJJV@nongnu.org
X-Gm-Message-State: AOJu0YxV0eG/fSCb2p4Vai071VpodVIpuHYBmHGOEoRuOJmQapWEpBKn
 snx7R8AFSDsjU97DcUA9DCu4YQEVjqbxze93XtjM1izq60XwgzIde11ZStVEAi4=
X-Gm-Gg: ASbGnctX/Ty6u0y9qH4WJNrKuiL4JWFmRPrRFxp2AJmdqEeBb2Vz9D5XPFFug6KpGlK
 bQUaHc9m20oucaFHJc4GE5tzTHoONPrF45MgegkjoiEwlROQunoEFHPmBOkqavXZQrbUJCqV6y9
 zQ8mCBM62t98cqawV9lNZv8/zSdHuuLvxfFWGwqVvoTqBZnVFKSHiJXNsg5uge+U35mYpE7whW8
 mLvXDPOtmR0fQcP/7mCKywdWQGHsCFhGvMXodyaf04mrrSrhSHz//ytTmfuZ1XzlNKgOIM6f0LL
 qBZ6x8YRkw71hMoP7NSTvjmKRJTUr8Fe7HX5rs5G80i3hvc+02YH/ITFvDeJqPji4cydtA==
X-Google-Smtp-Source: AGHT+IGSt14empNkMJ108GrDf4qqjC/MmT9uWLS2ZVrr3sDmE24NVEOsgEE3vOXb/VStlgOJceHxoQ==
X-Received: by 2002:a05:600c:5127:b0:439:9737:675b with SMTP id
 5b1f17b1804b1-439ae2eae86mr148840475e9.7.1740507458565; 
 Tue, 25 Feb 2025 10:17:38 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab155eb6csm36279815e9.31.2025.02.25.10.17.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 10:17:37 -0800 (PST)
Message-ID: <21f85e1d-938e-40e8-b33d-95f8cb4a13a7@linaro.org>
Date: Tue, 25 Feb 2025 19:17:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 004/162] tcg: Convert add to TCGOutOpBinary
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 17/2/25 00:07, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/sparc64/tcg-target-con-set.h |   1 +
>   tcg/tcg.c                        |  40 ++++++++++-
>   tcg/aarch64/tcg-target.c.inc     |  51 +++++++-------
>   tcg/arm/tcg-target.c.inc         |  43 ++++++++----
>   tcg/i386/tcg-target.c.inc        |  56 +++++++++-------
>   tcg/loongarch64/tcg-target.c.inc |  38 +++++------
>   tcg/mips/tcg-target.c.inc        |  31 ++++++---
>   tcg/ppc/tcg-target.c.inc         |  47 +++++++------
>   tcg/riscv/tcg-target.c.inc       |  39 ++++++-----
>   tcg/s390x/tcg-target.c.inc       | 110 +++++++++++++++----------------
>   tcg/sparc64/tcg-target.c.inc     |  25 +++++--
>   tcg/tci/tcg-target.c.inc         |  15 ++++-
>   12 files changed, 301 insertions(+), 195 deletions(-)


> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index a0f050ff9c..08106b6e4c 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc


> +static const TCGOutOpBinary outop_add = {
> +    .base.static_constraint = C_O1_I2(r, r, rJ),

So now 32-bit uses 'T' constraint (TCG_CT_CONST_S32) and we get the
signed32 cast, OK.

> +    .out_rrr = tgen_add,
> +    .out_rri = tcg_out_addi,
> +};


> @@ -2281,11 +2284,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_rotr_i64:
>           return C_O1_I2(r, r, ri);
>   
> -    case INDEX_op_add_i32:
> -        return C_O1_I2(r, r, ri);
> -    case INDEX_op_add_i64:
> -        return C_O1_I2(r, r, rJ);
> -
>       case INDEX_op_and_i32:
>       case INDEX_op_and_i64:
>       case INDEX_op_nor_i32:

> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index 11dcfe66f3..6b27238499 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -2902,6 +2902,26 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
>       flush_idcache_range(jmp_rx, jmp_rw, 4);
>   }
>   
> +
> +static void tgen_add(TCGContext *s, TCGType type,
> +                     TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tcg_out32(s, ADD | TAB(a0, a1, a2));
> +}
> +
> +static void tgen_addi(TCGContext *s, TCGType type,
> +                      TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    tcg_out_mem_long(s, ADDI, ADD, a0, a1, a2);
> +}
> +
> +static const TCGOutOpBinary outop_add = {
> +    .base.static_constraint = C_O1_I2(r, r, rT),

Similarly, 32-bit uses 'T' constraint (TCG_CT_CONST_S32) and we get the
signed32 cast, OK.

> +    .out_rrr = tgen_add,
> +    .out_rri = tgen_addi,
> +};
> +
> +
>   static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const TCGArg args[TCG_MAX_OP_ARGS],
>                          const int const_args[TCG_MAX_OP_ARGS])
> @@ -2971,15 +2991,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_mem_long(s, STD, STDX, args[0], args[1], args[2]);
>           break;
>   
> -    case INDEX_op_add_i32:
> -        a0 = args[0], a1 = args[1], a2 = args[2];
> -        if (const_args[2]) {
> -        do_addi_32:
> -            tcg_out_mem_long(s, ADDI, ADD, a0, a1, (int32_t)a2);
> -        } else {
> -            tcg_out32(s, ADD | TAB(a0, a1, a2));
> -        }
> -        break;
>       case INDEX_op_sub_i32:
>           a0 = args[0], a1 = args[1], a2 = args[2];
>           if (const_args[1]) {
> @@ -2989,8 +3000,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                   tcg_out32(s, SUBFIC | TAI(a0, a2, a1));
>               }
>           } else if (const_args[2]) {
> -            a2 = -a2;
> -            goto do_addi_32;
> +            tgen_addi(s, type, a0, a1, (int32_t)-a2);

So do we really need the (int32_t) cast here?

>           } else {
>               tcg_out32(s, SUBF | TAB(a0, a2, a1));
>           }

> diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
> index cb5e8d554d..f43d95b025 100644
> --- a/tcg/sparc64/tcg-target.c.inc
> +++ b/tcg/sparc64/tcg-target.c.inc


> +static const TCGOutOpBinary outop_add = {
> +    .base.static_constraint = C_O1_I2(r, r, rJ),

Don't we need

        .base.static_constraint = C_O1_I2(r, rz, rJ),

since commit 1bbcae5adaa ("tcg/sparc64: Use 'z' constraint")?

> +    .out_rrr = tgen_add,
> +    .out_rri = tgen_addi,
> +};


