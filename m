Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFFFC369C7
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 20:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u59lT-0005Fq-RN; Wed, 16 Apr 2025 16:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u59lN-00058U-GD
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 16:53:42 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u59lL-0001f2-0c
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 16:53:41 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so20690b3a.2
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 13:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744836817; x=1745441617; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rZkwIArGmIvlVDlPFfRD3pdpnqTqGWBb80szR13s4CY=;
 b=Bo15T82eJcV85p2nQwjaOI7+GmtgkRq28N3a1w2QouA7Z66TVkKPEMhw7U3z4tmmmj
 Uoko/xg1qGtsMGyHPK+Y6fSCbja+sUlWchnvl56PCWH6IpgTfBzPKwzclzoYPpzdt6En
 V3MTO1sxgd+zIoPBnZqaY6wFLfRSAViaYkZTNRK0l6uKtx3zGY+t4HGb88BYFrr/ZANM
 kd/YhScJtChOdo38D1yJ4IelnF8TVR+FfTtXM6BV6Skfjbn2U7H4jT6fXJ0J+DypTto6
 WeUgvm4Y9Ncv/oNxGw/mG4kHkMvKXNiUL1PRLkPUeFLuja5HY3q3yar7XjW8CH3UODEw
 Gs2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744836817; x=1745441617;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rZkwIArGmIvlVDlPFfRD3pdpnqTqGWBb80szR13s4CY=;
 b=NxdGaj6qh1ghFPsjGuPlUrjZcO1Z5Gv/sFchJY483eZ2olLA5KhIEaOHinNsKRlmx/
 /WSgdL8YXheKaq0mzo19Z5sKug4VHL2G/otQO5ggMpo/HXAEd2pDx5s61hADzIvt+2jq
 QaAEwtiUIMO+lEoVaZnG8h0PFkvEkZQxYweMLbHXsM/O1EoTy0UzlFmkQtMWRJOguT3r
 ETrjfjeKtUS52NmUk+eOmWGdG5Vn+ytJ4SBEOhBJvAkZ8NrqME2TFjIHlWT3+RBAmHvE
 5p2XVtTSaH8YgAjtQAsxX4gHv8odNW4klQ2bdi+xZFM9qIRvDi6pvMNhZPex+46Y9bsO
 1XVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVShgr9tm+5dSdPGf0JGApbcDp/KmEtbPP3ERWPpoQGPRGl4dTBoMfXh+XG9x2BchZYuj0GoSc2ojxt@nongnu.org
X-Gm-Message-State: AOJu0YwpBRwwf8NcRVsWJD4OfR6WVjhykuv2xZNCPInRz0mmoQrBMRtG
 cZjBAj38GO/OgbIQJhl4PbvE2PNl+wTZ3+DGAr810n43FsSLimD6jYCzA/KzziNd1/k0N/Gqczm
 m
X-Gm-Gg: ASbGncsU12DEnPtETzL7azes9h6MUV2kz9B22kERZiuCANHAhlvse/cgtq8HyJlLfoS
 IpXr7SzFBQqjsjZLGWc2JLAvteHfRVVnkqwkOVrwizggfD3m2IdCvRfNZmbTUVFyNBCK8l600nx
 lCYpww8I061FrHtg/hlsSuKnW/NcNBV2QG9Jcmt9ruyHNf/DaNeNegM3zgq03n90+FIg+9c8NKy
 cZs79tZcK4VLWbGiCrYUhTZjDcKMXRXAsWAIgISDA4GwvHDxZAcmhLTSmdvp6jptnBgN4+ADj99
 ZY6pQhP4f3aTK4cbPOxWl7d/sEzpJurlR/0SXZu14Z8A3kpckb941w==
X-Google-Smtp-Source: AGHT+IGHaYuYM/YGAapmeU8WKp7HS7LhyQyTyQx98v7uK28gWeoo8W2CaC7we/keU7e0VrRkkfiTkA==
X-Received: by 2002:a05:6a20:d709:b0:1fd:f48b:f397 with SMTP id
 adf61e73a8af0-203b3edec50mr4282798637.23.1744836817317; 
 Wed, 16 Apr 2025 13:53:37 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f0f72sm10873907b3a.89.2025.04.16.13.53.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 13:53:36 -0700 (PDT)
Message-ID: <1bab255b-e668-4287-a6b2-2b8eb0030664@linaro.org>
Date: Wed, 16 Apr 2025 13:53:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 157/163] tcg: Merge INDEX_op_st*_{i32,i64}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-158-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-158-richard.henderson@linaro.org>
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

On 4/15/25 12:25, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    | 15 ++++----------
>   tcg/optimize.c           | 28 +++++++------------------
>   tcg/tcg-op.c             | 14 ++++++-------
>   tcg/tcg.c                | 45 +++++++++++++---------------------------
>   tcg/tci.c                | 36 +++++++++-----------------------
>   tcg/tci/tcg-target.c.inc | 20 +++++++-----------
>   6 files changed, 50 insertions(+), 108 deletions(-)
> 
> diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
> index 6e8fcefaef..a22433d8b5 100644
> --- a/include/tcg/tcg-opc.h
> +++ b/include/tcg/tcg-opc.h
> @@ -86,6 +86,10 @@ DEF(setcond, 1, 2, 1, TCG_OPF_INT)
>   DEF(sextract, 1, 1, 2, TCG_OPF_INT)
>   DEF(shl, 1, 2, 0, TCG_OPF_INT)
>   DEF(shr, 1, 2, 0, TCG_OPF_INT)
> +DEF(st8, 0, 2, 1, TCG_OPF_INT)
> +DEF(st16, 0, 2, 1, TCG_OPF_INT)
> +DEF(st32, 0, 2, 1, TCG_OPF_INT)
> +DEF(st, 0, 2, 1, TCG_OPF_INT)
>   DEF(sub, 1, 2, 0, TCG_OPF_INT)
>   DEF(xor, 1, 2, 0, TCG_OPF_INT)
>   
> @@ -99,20 +103,9 @@ DEF(subb1o, 1, 2, 0, TCG_OPF_INT | TCG_OPF_CARRY_OUT)
>   DEF(subbi, 1, 2, 0, TCG_OPF_INT | TCG_OPF_CARRY_IN)
>   DEF(subbio, 1, 2, 0, TCG_OPF_INT | TCG_OPF_CARRY_IN | TCG_OPF_CARRY_OUT)
>   
> -/* load/store */
> -DEF(st8_i32, 0, 2, 1, 0)
> -DEF(st16_i32, 0, 2, 1, 0)
> -DEF(st_i32, 0, 2, 1, 0)
> -
>   DEF(brcond2_i32, 0, 4, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
>   DEF(setcond2_i32, 1, 4, 1, 0)
>   
> -/* load/store */
> -DEF(st8_i64, 0, 2, 1, 0)
> -DEF(st16_i64, 0, 2, 1, 0)
> -DEF(st32_i64, 0, 2, 1, 0)
> -DEF(st_i64, 0, 2, 1, 0)
> -
>   /* size changing ops */
>   DEF(ext_i32_i64, 1, 1, 0, 0)
>   DEF(extu_i32_i64, 1, 1, 0, 0)
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 1da23755e3..cbc519624a 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -30,14 +30,6 @@
>   #include "tcg-internal.h"
>   #include "tcg-has.h"
>   
> -#define CASE_OP_32_64(x)                        \
> -        glue(glue(case INDEX_op_, x), _i32):    \
> -        glue(glue(case INDEX_op_, x), _i64)
> -
> -#define CASE_OP_32_64_VEC(x)                    \
> -        glue(glue(case INDEX_op_, x), _i32):    \
> -        glue(glue(case INDEX_op_, x), _i64):    \
> -        glue(glue(case INDEX_op_, x), _vec)
>   
>   typedef struct MemCopyInfo {
>       IntervalTreeNode itree;
> @@ -2926,19 +2918,16 @@ static bool fold_tcg_st(OptContext *ctx, TCGOp *op)
>       }
>   
>       switch (op->opc) {
> -    CASE_OP_32_64(st8):
> +    case INDEX_op_st8:
>           lm1 = 0;
>           break;
> -    CASE_OP_32_64(st16):
> +    case INDEX_op_st16:
>           lm1 = 1;
>           break;
> -    case INDEX_op_st32_i64:
> -    case INDEX_op_st_i32:
> +    case INDEX_op_st32:
>           lm1 = 3;
>           break;
> -    case INDEX_op_st_i64:
> -        lm1 = 7;
> -        break;
> +    case INDEX_op_st:
>       case INDEX_op_st_vec:
>           lm1 = tcg_type_size(ctx->type) - 1;
>           break;
> @@ -3126,13 +3115,12 @@ void tcg_optimize(TCGContext *s)
>           case INDEX_op_ld_vec:
>               done = fold_tcg_ld_memcopy(&ctx, op);
>               break;
> -        CASE_OP_32_64(st8):
> -        CASE_OP_32_64(st16):
> -        case INDEX_op_st32_i64:
> +        case INDEX_op_st8:
> +        case INDEX_op_st16:
> +        case INDEX_op_st32:
>               done = fold_tcg_st(&ctx, op);
>               break;
> -        case INDEX_op_st_i32:
> -        case INDEX_op_st_i64:
> +        case INDEX_op_st:
>           case INDEX_op_st_vec:
>               done = fold_tcg_st_memcopy(&ctx, op);
>               break;
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 680f752cf9..dfa5c38728 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -1404,17 +1404,17 @@ void tcg_gen_ld_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
>   
>   void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
>   {
> -    tcg_gen_ldst_op_i32(INDEX_op_st8_i32, arg1, arg2, offset);
> +    tcg_gen_ldst_op_i32(INDEX_op_st8, arg1, arg2, offset);
>   }
>   
>   void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
>   {
> -    tcg_gen_ldst_op_i32(INDEX_op_st16_i32, arg1, arg2, offset);
> +    tcg_gen_ldst_op_i32(INDEX_op_st16, arg1, arg2, offset);
>   }
>   
>   void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
>   {
> -    tcg_gen_ldst_op_i32(INDEX_op_st_i32, arg1, arg2, offset);
> +    tcg_gen_ldst_op_i32(INDEX_op_st, arg1, arg2, offset);
>   }
>   
>   
> @@ -1540,7 +1540,7 @@ void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
>   void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
>   {
>       if (TCG_TARGET_REG_BITS == 64) {
> -        tcg_gen_ldst_op_i64(INDEX_op_st8_i64, arg1, arg2, offset);
> +        tcg_gen_ldst_op_i64(INDEX_op_st8, arg1, arg2, offset);
>       } else {
>           tcg_gen_st8_i32(TCGV_LOW(arg1), arg2, offset);
>       }
> @@ -1549,7 +1549,7 @@ void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
>   void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
>   {
>       if (TCG_TARGET_REG_BITS == 64) {
> -        tcg_gen_ldst_op_i64(INDEX_op_st16_i64, arg1, arg2, offset);
> +        tcg_gen_ldst_op_i64(INDEX_op_st16, arg1, arg2, offset);
>       } else {
>           tcg_gen_st16_i32(TCGV_LOW(arg1), arg2, offset);
>       }
> @@ -1558,7 +1558,7 @@ void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
>   void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
>   {
>       if (TCG_TARGET_REG_BITS == 64) {
> -        tcg_gen_ldst_op_i64(INDEX_op_st32_i64, arg1, arg2, offset);
> +        tcg_gen_ldst_op_i64(INDEX_op_st32, arg1, arg2, offset);
>       } else {
>           tcg_gen_st_i32(TCGV_LOW(arg1), arg2, offset);
>       }
> @@ -1567,7 +1567,7 @@ void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
>   void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
>   {
>       if (TCG_TARGET_REG_BITS == 64) {
> -        tcg_gen_ldst_op_i64(INDEX_op_st_i64, arg1, arg2, offset);
> +        tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
>       } else if (HOST_BIG_ENDIAN) {
>           tcg_gen_st_i32(TCGV_HIGH(arg1), arg2, offset);
>           tcg_gen_st_i32(TCGV_LOW(arg1), arg2, offset + 4);
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index d6b501254a..9f98361157 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1219,12 +1219,9 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
>       OUTOP(INDEX_op_sextract, TCGOutOpExtract, outop_sextract),
>       OUTOP(INDEX_op_shl, TCGOutOpBinary, outop_shl),
>       OUTOP(INDEX_op_shr, TCGOutOpBinary, outop_shr),
> -    OUTOP(INDEX_op_st_i32, TCGOutOpStore, outop_st),
> -    OUTOP(INDEX_op_st_i64, TCGOutOpStore, outop_st),
> -    OUTOP(INDEX_op_st8_i32, TCGOutOpStore, outop_st8),
> -    OUTOP(INDEX_op_st8_i64, TCGOutOpStore, outop_st8),
> -    OUTOP(INDEX_op_st16_i32, TCGOutOpStore, outop_st16),
> -    OUTOP(INDEX_op_st16_i64, TCGOutOpStore, outop_st16),
> +    OUTOP(INDEX_op_st, TCGOutOpStore, outop_st),
> +    OUTOP(INDEX_op_st8, TCGOutOpStore, outop_st8),
> +    OUTOP(INDEX_op_st16, TCGOutOpStore, outop_st16),
>       OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
>       OUTOP(INDEX_op_subbi, TCGOutOpAddSubCarry, outop_subbi),
>       OUTOP(INDEX_op_subbio, TCGOutOpAddSubCarry, outop_subbio),
> @@ -1246,7 +1243,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
>       OUTOP(INDEX_op_extrh_i64_i32, TCGOutOpUnary, outop_extrh_i64_i32),
>       OUTOP(INDEX_op_ld32u, TCGOutOpLoad, outop_ld32u),
>       OUTOP(INDEX_op_ld32s, TCGOutOpLoad, outop_ld32s),
> -    OUTOP(INDEX_op_st32_i64, TCGOutOpStore, outop_st),
> +    OUTOP(INDEX_op_st32, TCGOutOpStore, outop_st),
>   #endif
>   };
>   
> @@ -2464,24 +2461,19 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_or:
>       case INDEX_op_setcond:
>       case INDEX_op_sextract:
> +    case INDEX_op_st8:
> +    case INDEX_op_st16:
> +    case INDEX_op_st:
>       case INDEX_op_xor:
>           return has_type;
>   
> -    case INDEX_op_st8_i32:
> -    case INDEX_op_st16_i32:
> -    case INDEX_op_st_i32:
> -        return true;
> -
>       case INDEX_op_brcond2_i32:
>       case INDEX_op_setcond2_i32:
>           return TCG_TARGET_REG_BITS == 32;
>   
>       case INDEX_op_ld32u:
>       case INDEX_op_ld32s:
> -    case INDEX_op_st8_i64:
> -    case INDEX_op_st16_i64:
> -    case INDEX_op_st32_i64:
> -    case INDEX_op_st_i64:
> +    case INDEX_op_st32:
>       case INDEX_op_ext_i32_i64:
>       case INDEX_op_extu_i32_i64:
>       case INDEX_op_extrl_i64_i32:
> @@ -4492,10 +4484,7 @@ liveness_pass_2(TCGContext *s)
>                   arg_ts->state = 0;
>   
>                   if (NEED_SYNC_ARG(0)) {
> -                    TCGOpcode sopc = (arg_ts->type == TCG_TYPE_I32
> -                                      ? INDEX_op_st_i32
> -                                      : INDEX_op_st_i64);
> -                    TCGOp *sop = tcg_op_insert_after(s, op, sopc, 3);
> +                    TCGOp *sop = tcg_op_insert_after(s, op, INDEX_op_st, 3);
>                       TCGTemp *out_ts = dir_ts;
>   
>                       if (IS_DEAD_ARG(0)) {
> @@ -4529,10 +4518,7 @@ liveness_pass_2(TCGContext *s)
>   
>                   /* Sync outputs upon their last write.  */
>                   if (NEED_SYNC_ARG(i)) {
> -                    TCGOpcode sopc = (arg_ts->type == TCG_TYPE_I32
> -                                      ? INDEX_op_st_i32
> -                                      : INDEX_op_st_i64);
> -                    TCGOp *sop = tcg_op_insert_after(s, op, sopc, 3);
> +                    TCGOp *sop = tcg_op_insert_after(s, op, INDEX_op_st, 3);
>   
>                       TCGOP_TYPE(sop) = arg_ts->type;
>                       sop->args[0] = temp_arg(dir_ts);
> @@ -5792,16 +5778,13 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>           }
>           break;
>   
> -    case INDEX_op_st32_i64:
> +    case INDEX_op_st32:
>           /* Use tcg_op_st w/ I32. */
>           type = TCG_TYPE_I32;
>           /* fall through */
> -    case INDEX_op_st_i32:
> -    case INDEX_op_st_i64:
> -    case INDEX_op_st8_i32:
> -    case INDEX_op_st8_i64:
> -    case INDEX_op_st16_i32:
> -    case INDEX_op_st16_i64:
> +    case INDEX_op_st:
> +    case INDEX_op_st8:
> +    case INDEX_op_st16:
>           {
>               const TCGOutOpStore *out =
>                   container_of(all_outop[op->opc], TCGOutOpStore, base);
> diff --git a/tcg/tci.c b/tcg/tci.c
> index 890ccbe85b..b08288e7d3 100644
> --- a/tcg/tci.c
> +++ b/tcg/tci.c
> @@ -325,18 +325,6 @@ static void tci_qemu_st(CPUArchState *env, uint64_t taddr, uint64_t val,
>       }
>   }
>   
> -#if TCG_TARGET_REG_BITS == 64
> -# define CASE_32_64(x) \
> -        case glue(glue(INDEX_op_, x), _i64): \
> -        case glue(glue(INDEX_op_, x), _i32):
> -# define CASE_64(x) \
> -        case glue(glue(INDEX_op_, x), _i64):
> -#else
> -# define CASE_32_64(x) \
> -        case glue(glue(INDEX_op_, x), _i32):
> -# define CASE_64(x)
> -#endif
> -
>   /* Interpret pseudo code in tb. */
>   /*
>    * Disable CFI checks.
> @@ -491,21 +479,20 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
>               ptr = (void *)(regs[r1] + ofs);
>               regs[r0] = *(tcg_target_ulong *)ptr;
>               break;
> -        CASE_32_64(st8)
> +        case INDEX_op_st8:
>               tci_args_rrs(insn, &r0, &r1, &ofs);
>               ptr = (void *)(regs[r1] + ofs);
>               *(uint8_t *)ptr = regs[r0];
>               break;
> -        CASE_32_64(st16)
> +        case INDEX_op_st16:
>               tci_args_rrs(insn, &r0, &r1, &ofs);
>               ptr = (void *)(regs[r1] + ofs);
>               *(uint16_t *)ptr = regs[r0];
>               break;
> -        case INDEX_op_st_i32:
> -        CASE_64(st32)
> +        case INDEX_op_st:
>               tci_args_rrs(insn, &r0, &r1, &ofs);
>               ptr = (void *)(regs[r1] + ofs);
> -            *(uint32_t *)ptr = regs[r0];
> +            *(tcg_target_ulong *)ptr = regs[r0];
>               break;
>   
>               /* Arithmetic operations (mixed 32/64 bit). */
> @@ -725,10 +712,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
>               ptr = (void *)(regs[r1] + ofs);
>               regs[r0] = *(int32_t *)ptr;
>               break;
> -        case INDEX_op_st_i64:
> +        case INDEX_op_st32:
>               tci_args_rrs(insn, &r0, &r1, &ofs);
>               ptr = (void *)(regs[r1] + ofs);
> -            *(uint64_t *)ptr = regs[r0];
> +            *(uint32_t *)ptr = regs[r0];
>               break;
>   
>               /* Arithmetic operations (64 bit). */
> @@ -975,13 +962,10 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
>       case INDEX_op_ld16s:
>       case INDEX_op_ld32u:
>       case INDEX_op_ld:
> -    case INDEX_op_st8_i32:
> -    case INDEX_op_st8_i64:
> -    case INDEX_op_st16_i32:
> -    case INDEX_op_st16_i64:
> -    case INDEX_op_st32_i64:
> -    case INDEX_op_st_i32:
> -    case INDEX_op_st_i64:
> +    case INDEX_op_st8:
> +    case INDEX_op_st16:
> +    case INDEX_op_st32:
> +    case INDEX_op_st:
>           tci_args_rrs(insn, &r0, &r1, &s2);
>           info->fprintf_func(info->stream, "%-12s  %s, %s, %d",
>                              op_name, str_r(r0), str_r(r1), s2);
> diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
> index be9270a861..1fb7575061 100644
> --- a/tcg/tci/tcg-target.c.inc
> +++ b/tcg/tci/tcg-target.c.inc
> @@ -1173,7 +1173,7 @@ static const TCGOutOpLoad outop_ld32s = {
>   static void tgen_st8(TCGContext *s, TCGType type, TCGReg data,
>                        TCGReg base, ptrdiff_t offset)
>   {
> -    tcg_out_ldst(s, INDEX_op_st8_i32, data, base, offset);
> +    tcg_out_ldst(s, INDEX_op_st8, data, base, offset);
>   }
>   
>   static const TCGOutOpStore outop_st8 = {
> @@ -1184,7 +1184,7 @@ static const TCGOutOpStore outop_st8 = {
>   static void tgen_st16(TCGContext *s, TCGType type, TCGReg data,
>                         TCGReg base, ptrdiff_t offset)
>   {
> -    tcg_out_ldst(s, INDEX_op_st16_i32, data, base, offset);
> +    tcg_out_ldst(s, INDEX_op_st16, data, base, offset);
>   }
>   
>   static const TCGOutOpStore outop_st16 = {
> @@ -1232,18 +1232,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>   static void tcg_out_st(TCGContext *s, TCGType type, TCGReg val, TCGReg base,
>                          intptr_t offset)
>   {
> -    switch (type) {
> -    case TCG_TYPE_I32:
> -        tcg_out_ldst(s, INDEX_op_st_i32, val, base, offset);
> -        break;
> -#if TCG_TARGET_REG_BITS == 64
> -    case TCG_TYPE_I64:
> -        tcg_out_ldst(s, INDEX_op_st_i64, val, base, offset);
> -        break;
> -#endif
> -    default:
> -        g_assert_not_reached();
> +    TCGOpcode op = INDEX_op_st;
> +
> +    if (TCG_TARGET_REG_BITS == 64 && type == TCG_TYPE_I32) {
> +        op = INDEX_op_st32;
>       }
> +    tcg_out_ldst(s, op, val, base, offset);
>   }
>   
>   static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


