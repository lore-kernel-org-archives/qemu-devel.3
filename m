Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB760C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 21:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4oHv-0001Yd-5H; Tue, 15 Apr 2025 17:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4oHq-0001XR-8V
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:57:46 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4oHM-0006Ls-Kp
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:57:45 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-736c062b1f5so5158897b3a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 14:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744754235; x=1745359035; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4IyDkwkEPNbA+IoPhWFfbvsXetIpNVunofZ/diqJhww=;
 b=smf1RclL5gaAkvOJxWhb65fiT+4bZk/5AMkKV28dyQJDak+P8TmmbSta/vHu0lINEM
 y0p9akQ9g1l0Q7t7Um3+L2XG4eZ5NxLa0Ps+sZoicHVVsgPgHfq4OrRsjW/GiqgwS+wp
 DO2issW1shpQvffWyaZu8PxmTs0k/8U8w2dg8sNTrGGKnwbt1I117ywIn8ND6EzT8PMl
 3grkHYpxREztsk+8BxOLRWBgHtg52Rt17WgI6iSzQf/+kf9amRHUexhdDCjK9HINqo3L
 UiyRrGqr/snm7/caxjZi+UqG6NXqmP9mY4GYyRdcwFn5aK14vYmAY+7uv46yYWOzPxj1
 vR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744754235; x=1745359035;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4IyDkwkEPNbA+IoPhWFfbvsXetIpNVunofZ/diqJhww=;
 b=goz0rTQpuJL1KT8dmOcJQSfIYcnZUDq+3Q86wJ9GIs1dF8goGkhaEyTEN5vYXrA89E
 QUZjYNb2yx4G86L6aVpjGguwGqDjGl4edrU/VItUzJuzwBufERSw0q/mlIp7OUB9kb8H
 fGvpvLsOSrd4e/r0Y11dtUg8LYWHrLXzXFdRBuulzp6/BKzHuPAKhyYMD4e37oVWazcr
 dG9tQ852E+Onjwd6R8mUP8pV62CZLpWrJrQXpPp0xt7TPcXExHQnzIWRtIDBII7t6cwh
 UxQ9tFDO0gFnG8R8MH0+J/oMq7x+XauWyDkooWARKoyBoQciZ+KS59um0Qau5WvYZekC
 1obQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu5HN1YlHt1AfQPimZadPomWok+BetFOC1iwM0fkJLHOPMzlwSOgvsJ1/i3F6nfspMWDu5HmyGT6Op@nongnu.org
X-Gm-Message-State: AOJu0Yx1iS/plB4pEnBH0fbQtVv2xTHVxc4d8tjIqOBb+y04c052bvRs
 L7/7j92v6O6jNriJvOrVJLG+FQf+MlRazWtrqytknoKAzrAADKIgwxx/F/ePl6g=
X-Gm-Gg: ASbGncvCxLGm/rzT9+GH9hdDxPZjxEXQF/Y6W9l/EOYPK6ankjKQ1EabwLjAq0HbNKT
 Mt/pHrpYsARxXOgwDt93ma+xDCK9RzzVo0KwQGtbXDGER3mGHGVFs2u59RLVhFNUjYdq3p4rY8L
 nzuKgHSRNtlVq4OxyHAvfFqkVJby2fUrDETIzpq8+jk36AP8Z1jo1Jav/SZv6UKAvrBDRLQ51UU
 9AIEHjC5PHTxDxeKGXkFRKpoLtcjrBQfc8FOAYXOkKGc0jK0yC4gSHC6mkE497ANrgqF6a5exH+
 w0CcRp2leekar12LDDoJUsLwiT2KNYZsa8xKDB9lMEaG7g4rdUpb3A==
X-Google-Smtp-Source: AGHT+IEiF83koEVtbAkKCLUxdHbXgzxWfUheh9YpuHjmG+RkYN2DEFtQQO3X3OFY7wQeV3XvBGZZrg==
X-Received: by 2002:a05:6a00:2184:b0:728:e2cc:bfd6 with SMTP id
 d2e1a72fcca58-73c1fb25c31mr1536383b3a.18.1744754234636; 
 Tue, 15 Apr 2025 14:57:14 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd21c5e8dsm9313298b3a.59.2025.04.15.14.57.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 14:57:14 -0700 (PDT)
Message-ID: <50d8521a-068c-40e0-98a6-7d58dafdbec9@linaro.org>
Date: Tue, 15 Apr 2025 14:57:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 099/163] tcg: Convert extrl_i64_i32 to TCGOutOpUnary
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-100-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-100-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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
> Drop the cast from TCGv_i64 to TCGv_i32 in tcg_gen_extrl_i64_i32
> an emit extrl_i64_i32 unconditionally.  Move that special case
> to tcg_gen_code when we find out if the output is live or dead.
> In this way even hosts that canonicalize truncations can make
> use of a store directly from the 64-bit host register.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op.c                     |  4 +---
>   tcg/tcg.c                        | 35 +++++++++++++++++++++++++++-----
>   tcg/aarch64/tcg-target.c.inc     |  1 -
>   tcg/i386/tcg-target.c.inc        |  4 ----
>   tcg/loongarch64/tcg-target.c.inc |  2 --
>   tcg/mips/tcg-target.c.inc        |  2 --
>   tcg/ppc/tcg-target.c.inc         |  1 -
>   tcg/riscv/tcg-target.c.inc       |  2 --
>   tcg/s390x/tcg-target.c.inc       |  1 -
>   tcg/tci/tcg-target.c.inc         |  1 -
>   10 files changed, 31 insertions(+), 22 deletions(-)
> 
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index d3f3c9d248..7ecd1f6c8f 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -2962,11 +2962,9 @@ void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
>   {
>       if (TCG_TARGET_REG_BITS == 32) {
>           tcg_gen_mov_i32(ret, TCGV_LOW(arg));
> -    } else if (TCG_TARGET_HAS_extr_i64_i32) {
> +    } else {
>           tcg_gen_op2(INDEX_op_extrl_i64_i32, TCG_TYPE_I32,
>                       tcgv_i32_arg(ret), tcgv_i64_arg(arg));
> -    } else {
> -        tcg_gen_mov_i32(ret, (TCGv_i32)arg);
>       }
>   }
>   
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index b6c1efa828..84083d133d 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1093,6 +1093,16 @@ static const TCGOutOpUnary outop_extu_i32_i64 = {
>       .base.static_constraint = C_O1_I1(r, r),
>       .out_rr = tgen_extu_i32_i64,
>   };
> +
> +static void tgen_extrl_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
> +{
> +    tcg_out_extrl_i64_i32(s, a0, a1);
> +}
> +
> +static const TCGOutOpUnary outop_extrl_i64_i32 = {
> +    .base.static_constraint = C_O1_I1(r, r),
> +    .out_rr = TCG_TARGET_HAS_extr_i64_i32 ? tgen_extrl_i64_i32 : NULL,
> +};
>   #endif
>   
>   /*
> @@ -1151,6 +1161,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
>       OUTOP(INDEX_op_bswap64, TCGOutOpUnary, outop_bswap64),
>       OUTOP(INDEX_op_ext_i32_i64, TCGOutOpUnary, outop_exts_i32_i64),
>       OUTOP(INDEX_op_extu_i32_i64, TCGOutOpUnary, outop_extu_i32_i64),
> +    OUTOP(INDEX_op_extrl_i64_i32, TCGOutOpUnary, outop_extrl_i64_i32),
>   #endif
>   };
>   
> @@ -2400,12 +2411,12 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_st_i64:
>       case INDEX_op_ext_i32_i64:
>       case INDEX_op_extu_i32_i64:
> +    case INDEX_op_extrl_i64_i32:
>       case INDEX_op_deposit_i64:
>           return TCG_TARGET_REG_BITS == 64;
>   
>       case INDEX_op_extract2_i64:
>           return TCG_TARGET_HAS_extract2_i64;
> -    case INDEX_op_extrl_i64_i32:
>       case INDEX_op_extrh_i64_i32:
>           return TCG_TARGET_HAS_extr_i64_i32;
>       case INDEX_op_add2_i64:
> @@ -5438,10 +5449,6 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>       /* emit instruction */
>       TCGType type = TCGOP_TYPE(op);
>       switch (op->opc) {
> -    case INDEX_op_extrl_i64_i32:
> -        tcg_out_extrl_i64_i32(s, new_args[0], new_args[1]);
> -        break;
> -
>       case INDEX_op_add:
>       case INDEX_op_and:
>       case INDEX_op_andc:
> @@ -5499,6 +5506,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>       case INDEX_op_bswap64:
>       case INDEX_op_ext_i32_i64:
>       case INDEX_op_extu_i32_i64:
> +    case INDEX_op_extrl_i64_i32:
>           assert(TCG_TARGET_REG_BITS == 64);
>           /* fall through */
>       case INDEX_op_ctpop:
> @@ -6657,6 +6665,22 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
>           TCGOpcode opc = op->opc;
>   
>           switch (opc) {
> +        case INDEX_op_extrl_i64_i32:
> +            assert(TCG_TARGET_REG_BITS == 64);
> +            /*
> +             * If TCG_TYPE_I32 is represented in some canonical form,
> +             * e.g. zero or sign-extended, then emit as a unary op.
> +             * Otherwise we can treat this as a plain move.
> +             * If the output dies, treat this as a plain move, because
> +             * this will be implemented with a store.
> +             */
> +            if (TCG_TARGET_HAS_extr_i64_i32) {
> +                TCGLifeData arg_life = op->life;
> +                if (!IS_DEAD_ARG(0)) {
> +                    goto do_default;
> +                }
> +            }
> +            /* fall through */
>           case INDEX_op_mov:
>           case INDEX_op_mov_vec:
>               tcg_reg_alloc_mov(s, op);
> @@ -6699,6 +6723,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
>               }
>               /* fall through */
>           default:
> +        do_default:
>               /* Sanity check that we've not introduced any unhandled opcodes. */
>               tcg_debug_assert(tcg_op_supported(opc, TCGOP_TYPE(op),
>                                                 TCGOP_FLAGS(op)));
> diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
> index 44314f6a0f..8abc5f26da 100644
> --- a/tcg/aarch64/tcg-target.c.inc
> +++ b/tcg/aarch64/tcg-target.c.inc
> @@ -2710,7 +2710,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
>       case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>       case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
>       case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
> -    case INDEX_op_extrl_i64_i32:
>       default:
>           g_assert_not_reached();
>       }
> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index 8371cfaf5a..9bae60d3b6 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc
> @@ -3413,7 +3413,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>       case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
>       case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
> -    case INDEX_op_extrl_i64_i32:
>       default:
>           g_assert_not_reached();
>       }
> @@ -3999,9 +3998,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_extrh_i64_i32:
>           return C_O1_I1(r, 0);
>   
> -    case INDEX_op_extrl_i64_i32:
> -        return C_O1_I1(r, r);
> -
>       case INDEX_op_extract2_i32:
>       case INDEX_op_extract2_i64:
>           return C_O1_I2(r, 0, r);
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index 3a85b6f4ba..59457c4323 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -1931,7 +1931,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>       case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
>       case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
> -    case INDEX_op_extrl_i64_i32:
>       default:
>           g_assert_not_reached();
>       }
> @@ -2457,7 +2456,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_qemu_st_i128:
>           return C_O0_I3(r, r, r);
>   
> -    case INDEX_op_extrl_i64_i32:
>       case INDEX_op_extrh_i64_i32:
>       case INDEX_op_ld8s_i32:
>       case INDEX_op_ld8s_i64:
> diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
> index b6b7070fbb..095eb8f672 100644
> --- a/tcg/mips/tcg-target.c.inc
> +++ b/tcg/mips/tcg-target.c.inc
> @@ -2364,7 +2364,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>       case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
>       case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
> -    case INDEX_op_extrl_i64_i32:
>       default:
>           g_assert_not_reached();
>       }
> @@ -2389,7 +2388,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_ld32s_i64:
>       case INDEX_op_ld32u_i64:
>       case INDEX_op_ld_i64:
> -    case INDEX_op_extrl_i64_i32:
>       case INDEX_op_extrh_i64_i32:
>           return C_O1_I1(r, r);
>   
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index e1767f1d6c..bb03efe055 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -3640,7 +3640,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       case INDEX_op_call:      /* Always emitted via tcg_out_call.  */
>       case INDEX_op_exit_tb:   /* Always emitted via tcg_out_exit_tb.  */
>       case INDEX_op_goto_tb:   /* Always emitted via tcg_out_goto_tb.  */
> -    case INDEX_op_extrl_i64_i32:
>       default:
>           g_assert_not_reached();
>       }
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index 48d4325097..76ad2df410 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -2630,7 +2630,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>       case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
>       case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
> -    case INDEX_op_extrl_i64_i32:
>       default:
>           g_assert_not_reached();
>       }
> @@ -2872,7 +2871,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_ld32s_i64:
>       case INDEX_op_ld32u_i64:
>       case INDEX_op_ld_i64:
> -    case INDEX_op_extrl_i64_i32:
>       case INDEX_op_extrh_i64_i32:
>           return C_O1_I1(r, r);
>   
> diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
> index d81b8fb8f4..1ea041c75f 100644
> --- a/tcg/s390x/tcg-target.c.inc
> +++ b/tcg/s390x/tcg-target.c.inc
> @@ -2997,7 +2997,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>       case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
>       case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
> -    case INDEX_op_extrl_i64_i32:
>       default:
>           g_assert_not_reached();
>       }
> diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
> index 3cf2913acd..e9b46d5e66 100644
> --- a/tcg/tci/tcg-target.c.inc
> +++ b/tcg/tci/tcg-target.c.inc
> @@ -1107,7 +1107,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>       case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
>       case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
> -    case INDEX_op_extrl_i64_i32:
>       default:
>           g_assert_not_reached();
>       }

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


