Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F9EC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 21:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4oG6-0006DM-1Y; Tue, 15 Apr 2025 17:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4oFy-00069h-7A
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:55:50 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4oFw-0005qa-0Y
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:55:49 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-736c062b1f5so5157553b3a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 14:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744754146; x=1745358946; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eZk2ubs71Lu9sIjSc5l1OHkKQ3m6OoLHLQjmwNOGnQc=;
 b=UuHgjzKhyxfynTv1tLHW6KroHBTe5Ma5Xq1UAoowE3qGXxou/i+NsccTefLNPsHdIC
 uky1v3IgDKdCbwRCpPIlVWG0MAfZcyH2mR85vZTCDtKlfrZXiDMnDJ5z8O0PF9h22v3g
 wU2KD+3c1pGCPV8mk1RmpwsTu1XdDPUB2eg61mTPhe27tPVkAQQPzMlIf2Cr0axWkSrh
 OSf6ykMmQGetKCvxFBMCT4JSj7rZrtIyswxOye4rJUH5ujdV0RjHW9ZFrquRYBGaJPr8
 H66Ty3ZsGgfVnvrv0DT4tn4se2NXfl8Mv/rrq0Hhid/WPNm5ZzJtDOOctNbKHeyFtqGL
 RYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744754146; x=1745358946;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eZk2ubs71Lu9sIjSc5l1OHkKQ3m6OoLHLQjmwNOGnQc=;
 b=a1IRCS5AtnM2Y72HpYSH7cEQU91GxV11q4smWQTUoWbIaredeZOOyjQAIloL43/GtJ
 NnqAiaGxz+7kN0foXxYkHHs9oobawGMCYygl530FVMmql5QyFl/tdN0lQOQfqv6C1D1O
 irCjWuMN/PZxqzjei6f4yegLhMTbzy4g5aUwoZIk+wn5RUVYzbKV9dVBvEDejrGcgz49
 WS6b3BOJO/4sk3g5dRtZj1zZ8PzeeNASsX7tq0iic5wOeog1+Ko6HnU+56NNhE7GlzS0
 LniONXsSwVbEiS/CcjbirKtN4tuU3n9bCgSpzstoERciu8qNzFm56GlKssZ7MyIGn/CQ
 HbOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs8taeFnxAGWVveTnHQFNAOq/d2Ejul2jpGeUJApuwT+dxOK/t6nsh9YuYe3AAU2mSkN6sQsp73FCJ@nongnu.org
X-Gm-Message-State: AOJu0YysZdil8LBS0m9QlQ4SScQvSiTH0GCrGjOL/zoMpKF0GQ0MhNN0
 Ox/DOx7lrftf2ebgkH5VJNd7we7K44Mu6QRoAP55XoBDK+2EQO7RlsJtufXHeQBk1kpQsxJDHgV
 oCJQ=
X-Gm-Gg: ASbGncuy0GMwdxodkzZHMdLbNjhBkdTJHhHXevlk8tHEdS/TaTNgVyAjW9KezXnCtkG
 ADAwB0ZpHYqorRXU/R6j01bZdTo+bn93XM2vQ2kUujGEfw9dE4rNX8wpidaivEqY/voUBSbWvI4
 7wILVrzdu6T4y4dtdC0aM98U7d4LC1qSW8rdHYqnp8Z6GPhkpt/XopMSshl0Ovl/OBWMBxORVC8
 X1VT/FDm/B0o5k3X0VLo3KT4WCCna1Pvc9itFN/4WG5Cnlkjry48mTH+n7E6ISECI+CP7GI2j10
 BUYvLR6K2CBC60sxOnCoX0ObBFytAyygAuF5ziLOdl8jCN99dNvxsQ==
X-Google-Smtp-Source: AGHT+IFnIlG2c0J7wkOh8S92UFoBVWM7qs/NUoEtsRbqNXf/e3fEFFMp+wZFYjly+x6GeJN1IACJ6g==
X-Received: by 2002:a17:90b:57e7:b0:305:2d68:8d55 with SMTP id
 98e67ed59e1d1-3085eef0eefmr1222655a91.8.1744754146340; 
 Tue, 15 Apr 2025 14:55:46 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-308613cb07esm84716a91.44.2025.04.15.14.55.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 14:55:45 -0700 (PDT)
Message-ID: <fc5f88db-0bc3-4b9d-9853-c0ac37a31b05@linaro.org>
Date: Tue, 15 Apr 2025 14:55:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 097/163] tcg: Convert ext_i32_i64 to TCGOutOpUnary
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-98-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-98-richard.henderson@linaro.org>
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
>   tcg/tcg.c                        | 22 +++++++++++++++++++---
>   tcg/aarch64/tcg-target.c.inc     |  2 --
>   tcg/i386/tcg-target.c.inc        |  2 --
>   tcg/loongarch64/tcg-target.c.inc |  2 --
>   tcg/mips/tcg-target.c.inc        |  2 --
>   tcg/ppc/tcg-target.c.inc         |  2 --
>   tcg/riscv/tcg-target.c.inc       |  2 --
>   tcg/s390x/tcg-target.c.inc       |  2 --
>   tcg/sparc64/tcg-target.c.inc     |  2 --
>   tcg/tci/tcg-target.c.inc         |  2 --
>   10 files changed, 19 insertions(+), 21 deletions(-)
> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index e688cd12b7..35f192e483 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1068,6 +1068,23 @@ QEMU_BUILD_BUG_ON((int)(offsetof(CPUNegativeOffsetState, tlb.f[0]) -
>                     < MIN_TLB_MASK_TABLE_OFS);
>   #endif
>   
> +#if TCG_TARGET_REG_BITS == 64
> +/*
> + * We require these functions for slow-path function calls.
> + * Adapt them generically for opcode output.
> + */
> +
> +static void tgen_exts_i32_i64(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
> +{
> +    tcg_out_exts_i32_i64(s, a0, a1);
> +}
> +
> +static const TCGOutOpUnary outop_exts_i32_i64 = {
> +    .base.static_constraint = C_O1_I1(r, r),
> +    .out_rr = tgen_exts_i32_i64,
> +};
> +#endif
> +
>   /*
>    * Register V as the TCGOutOp for O.
>    * This verifies that V is of type T, otherwise give a nice compiler error.
> @@ -1122,6 +1139,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
>       OUTOP(INDEX_op_setcond2_i32, TCGOutOpSetcond2, outop_setcond2),
>   #else
>       OUTOP(INDEX_op_bswap64, TCGOutOpUnary, outop_bswap64),
> +    OUTOP(INDEX_op_ext_i32_i64, TCGOutOpUnary, outop_exts_i32_i64),
>   #endif
>   };
>   
> @@ -5409,9 +5427,6 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>       /* emit instruction */
>       TCGType type = TCGOP_TYPE(op);
>       switch (op->opc) {
> -    case INDEX_op_ext_i32_i64:
> -        tcg_out_exts_i32_i64(s, new_args[0], new_args[1]);
> -        break;
>       case INDEX_op_extu_i32_i64:
>           tcg_out_extu_i32_i64(s, new_args[0], new_args[1]);
>           break;
> @@ -5474,6 +5489,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>           break;
>   
>       case INDEX_op_bswap64:
> +    case INDEX_op_ext_i32_i64:
>           assert(TCG_TARGET_REG_BITS == 64);
>           /* fall through */
>       case INDEX_op_ctpop:
> diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
> index 00400f6ea7..68f7a1cec2 100644
> --- a/tcg/aarch64/tcg-target.c.inc
> +++ b/tcg/aarch64/tcg-target.c.inc
> @@ -2710,7 +2710,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
>       case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>       case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
>       case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
> -    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
>       case INDEX_op_extu_i32_i64:
>       case INDEX_op_extrl_i64_i32:
>       default:
> @@ -3177,7 +3176,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_ld32u_i64:
>       case INDEX_op_ld32s_i64:
>       case INDEX_op_ld_i64:
> -    case INDEX_op_ext_i32_i64:
>       case INDEX_op_extu_i32_i64:
>           return C_O1_I1(r, r);
>   
> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index 6a5414ab3a..14b912beb7 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc
> @@ -3413,7 +3413,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>       case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
>       case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
> -    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
>       case INDEX_op_extu_i32_i64:
>       case INDEX_op_extrl_i64_i32:
>       default:
> @@ -4001,7 +4000,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_extrh_i64_i32:
>           return C_O1_I1(r, 0);
>   
> -    case INDEX_op_ext_i32_i64:
>       case INDEX_op_extu_i32_i64:
>       case INDEX_op_extrl_i64_i32:
>           return C_O1_I1(r, r);
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index c88db7a0e2..e2dbd08e12 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -1931,7 +1931,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>       case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
>       case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
> -    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
>       case INDEX_op_extu_i32_i64:
>       case INDEX_op_extrl_i64_i32:
>       default:
> @@ -2462,7 +2461,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_extu_i32_i64:
>       case INDEX_op_extrl_i64_i32:
>       case INDEX_op_extrh_i64_i32:
> -    case INDEX_op_ext_i32_i64:
>       case INDEX_op_ld8s_i32:
>       case INDEX_op_ld8s_i64:
>       case INDEX_op_ld8u_i32:
> diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
> index 56c58bf82d..e992a468eb 100644
> --- a/tcg/mips/tcg-target.c.inc
> +++ b/tcg/mips/tcg-target.c.inc
> @@ -2364,7 +2364,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>       case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
>       case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
> -    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
>       case INDEX_op_extu_i32_i64:
>       case INDEX_op_extrl_i64_i32:
>       default:
> @@ -2391,7 +2390,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_ld32s_i64:
>       case INDEX_op_ld32u_i64:
>       case INDEX_op_ld_i64:
> -    case INDEX_op_ext_i32_i64:
>       case INDEX_op_extu_i32_i64:
>       case INDEX_op_extrl_i64_i32:
>       case INDEX_op_extrh_i64_i32:
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index 3d1ffa9130..fea767573c 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -3640,7 +3640,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       case INDEX_op_call:      /* Always emitted via tcg_out_call.  */
>       case INDEX_op_exit_tb:   /* Always emitted via tcg_out_exit_tb.  */
>       case INDEX_op_goto_tb:   /* Always emitted via tcg_out_goto_tb.  */
> -    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
>       case INDEX_op_extu_i32_i64:
>       case INDEX_op_extrl_i64_i32:
>       default:
> @@ -4270,7 +4269,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_ld32u_i64:
>       case INDEX_op_ld32s_i64:
>       case INDEX_op_ld_i64:
> -    case INDEX_op_ext_i32_i64:
>       case INDEX_op_extu_i32_i64:
>           return C_O1_I1(r, r);
>   
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index dc2b487844..e5fe15c338 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -2630,7 +2630,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>       case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
>       case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
> -    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
>       case INDEX_op_extu_i32_i64:
>       case INDEX_op_extrl_i64_i32:
>       default:
> @@ -2877,7 +2876,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_extu_i32_i64:
>       case INDEX_op_extrl_i64_i32:
>       case INDEX_op_extrh_i64_i32:
> -    case INDEX_op_ext_i32_i64:
>           return C_O1_I1(r, r);
>   
>       case INDEX_op_st8_i32:
> diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
> index ab178bebc8..5c5a38c2c8 100644
> --- a/tcg/s390x/tcg-target.c.inc
> +++ b/tcg/s390x/tcg-target.c.inc
> @@ -2997,7 +2997,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>       case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
>       case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
> -    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
>       case INDEX_op_extu_i32_i64:
>       case INDEX_op_extrl_i64_i32:
>       default:
> @@ -3471,7 +3470,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_st_i64:
>           return C_O0_I2(r, r);
>   
> -    case INDEX_op_ext_i32_i64:
>       case INDEX_op_extu_i32_i64:
>           return C_O1_I1(r, r);
>   
> diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
> index 0f2bec21e9..e93ef8e7f2 100644
> --- a/tcg/sparc64/tcg-target.c.inc
> +++ b/tcg/sparc64/tcg-target.c.inc
> @@ -1883,7 +1883,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>       case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
>       case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
> -    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
>       case INDEX_op_extu_i32_i64:
>       default:
>           g_assert_not_reached();
> @@ -1909,7 +1908,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_ld32u_i64:
>       case INDEX_op_ld32s_i64:
>       case INDEX_op_ld_i64:
> -    case INDEX_op_ext_i32_i64:
>       case INDEX_op_extu_i32_i64:
>       case INDEX_op_qemu_ld_i32:
>       case INDEX_op_qemu_ld_i64:
> diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
> index 9ba108ef8d..ecff90404f 100644
> --- a/tcg/tci/tcg-target.c.inc
> +++ b/tcg/tci/tcg-target.c.inc
> @@ -55,7 +55,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_ld32u_i64:
>       case INDEX_op_ld32s_i64:
>       case INDEX_op_ld_i64:
> -    case INDEX_op_ext_i32_i64:
>       case INDEX_op_extu_i32_i64:
>           return C_O1_I1(r, r);
>   
> @@ -1109,7 +1108,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>       case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
>       case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
> -    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
>       case INDEX_op_extu_i32_i64:
>       case INDEX_op_extrl_i64_i32:
>       default:

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


