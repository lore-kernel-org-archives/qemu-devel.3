Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E7DC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 21:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4oIR-0002Da-PX; Tue, 15 Apr 2025 17:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4oIN-00023d-GH
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:58:20 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4oIE-0006nN-Ik
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:58:19 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-afc857702d1so5335356a12.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 14:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744754289; x=1745359089; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZbZut2bwfJXgEi5XIomcl/gMtgIwDjzovOishqQsy+g=;
 b=TJcajvUFYw4dHrtVlFmS7in7IFN8+F2gSznUBMJ5YD4nHXe54cpsPWi1Pf+bDKTb+E
 KYBrX3gdq7Tz0PBRn34Gb8IsqApfTTy1m2pGIqmrTS3t6dGhrZVW8B11Q7hmBcgs0Odq
 6BrXbRNs6VK3vjZzLMi/72ubvr0QjPNFvIXbgEhz7nthfVFe+8J8xBOzrq+EafKl1jYc
 XEkI6ltU0jpkiUeUsTF9YIssuAdm30yZ3vhmZvuYFLDAJ3VdWs0lkgdRvCT448XkK98x
 ZVAY5BhpGV9j27mq1sKKd3uYWis6AHqlVrwSfx422cJHIxc4RDspuhvRAycoPDRVqHxV
 Uulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744754289; x=1745359089;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZbZut2bwfJXgEi5XIomcl/gMtgIwDjzovOishqQsy+g=;
 b=VpIg8Et1DB+7VlEvAu/4liDyJg+zFbmsACkELXSZlljNU6pwUlzVWfgPwisEmeTp7y
 qMuZLDUcZZVbgEkHhReLPA/Pf27F5KQbUVhRgTN7rI8s5o3gs979lybTfcRDG6epzyou
 7DHb51/lL395GN9Q+O+9Y1AxLJNTSRQMzXF+xjpGtMtfKsMKeglSIIs97KIy9btWp5k5
 3uncoesMVChU+LN7pzB7fC7MgMILPeX7PM1XfJ42RRDDjdYot6CkUN5bgQvXwU9qXMwX
 8pHYGT47BGIf/EkX/GwiroHX7JMlbAs28veDl74Z/K7QS+fPDaKltZwRtykf3ikWPqL7
 +1yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXG9umX6tUi9dxcQzH2OHH3WvXkoEKiLqR2Nc8Ect6Oz2BfyVKjwbDx/CHpLsN5K0JKQmEw05jOfxIT@nongnu.org
X-Gm-Message-State: AOJu0Yyf9NNESBZPYUbuhW6R3OAjsAOsi6VWGO/3b+7aAm+MR1gtlkCW
 1DJ9MpEkj1xstG/Rm1bZ3JQomm0B70qsMQE339oBUaha+p9r50axPu5WLrIIUoQ=
X-Gm-Gg: ASbGncumV2IZz2rXmk59gXu5rqtpQWrCo4qref+YsKc/DdfO5afCPyIIjig164lXU2e
 F2T6g9Sq2F6tnKyBeClYPy0vD8xG2OtV5Sy9yOFtXX/DOXg6+0CCdIy+6+HqutPmWv+HG7NloFz
 owbBab65duv135V2GeGSZgxGyMpH0MTZv81ZGRQvgq8Bo29lABIfU0j+GBPO9zsgH0vCyqeTuJG
 76SlzAcojG1dUFmTSyQl2KIWrW7pZBdecCBoCuR7KsITLmO5wTdV9Kc+1UmSJCIGmH5wO13L4Vm
 8Wwv4POGr6/GSgcBKAcjJUxHd04tjw/78oA9UQDUKNSycHsNid1ClA==
X-Google-Smtp-Source: AGHT+IHOjYG+QeM8NUBQZN82jQV+UifaT/891E1UZ1nrgDtUzBNT9nTzIeQv+NPPAUc37p0MdRYnlA==
X-Received: by 2002:a17:90b:3908:b0:2ea:712d:9a82 with SMTP id
 98e67ed59e1d1-3085ef52acamr1049634a91.29.1744754288832; 
 Tue, 15 Apr 2025 14:58:08 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30861211f49sm93918a91.23.2025.04.15.14.58.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 14:58:08 -0700 (PDT)
Message-ID: <924e148d-ab8a-4eff-bdb9-bbe2c5e0063f@linaro.org>
Date: Tue, 15 Apr 2025 14:58:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 100/163] tcg: Convert extrh_i64_i32 to TCGOutOpUnary
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-101-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-101-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
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
> At the same time, make extrh_i64_i32 mandatory.  This closes a hole
> in which move arguments could be cast between TCGv_i32 and TCGv_i64.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op.c                     |  7 +------
>   tcg/tcg.c                        |  5 +++--
>   tcg/aarch64/tcg-target.c.inc     | 10 ++++++++++
>   tcg/i386/tcg-target.c.inc        | 20 +++++++++++++-------
>   tcg/loongarch64/tcg-target.c.inc | 15 ++++++++++-----
>   tcg/mips/tcg-target.c.inc        | 17 ++++++++++++-----
>   tcg/ppc/tcg-target.c.inc         | 12 ++++++++++++
>   tcg/riscv/tcg-target.c.inc       | 15 ++++++++++-----
>   tcg/s390x/tcg-target.c.inc       | 10 ++++++++++
>   tcg/sparc64/tcg-target.c.inc     | 10 ++++++++++
>   tcg/tci/tcg-target.c.inc         | 12 ++++++++++++
>   11 files changed, 103 insertions(+), 30 deletions(-)
> 
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 7ecd1f6c8f..b88f411ece 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -2972,14 +2972,9 @@ void tcg_gen_extrh_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
>   {
>       if (TCG_TARGET_REG_BITS == 32) {
>           tcg_gen_mov_i32(ret, TCGV_HIGH(arg));
> -    } else if (TCG_TARGET_HAS_extr_i64_i32) {
> +    } else {
>           tcg_gen_op2(INDEX_op_extrh_i64_i32, TCG_TYPE_I32,
>                       tcgv_i32_arg(ret), tcgv_i64_arg(arg));
> -    } else {
> -        TCGv_i64 t = tcg_temp_ebb_new_i64();
> -        tcg_gen_shri_i64(t, arg, 32);
> -        tcg_gen_mov_i32(ret, (TCGv_i32)t);
> -        tcg_temp_free_i64(t);
>       }
>   }
>   
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 84083d133d..02344face0 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1162,6 +1162,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
>       OUTOP(INDEX_op_ext_i32_i64, TCGOutOpUnary, outop_exts_i32_i64),
>       OUTOP(INDEX_op_extu_i32_i64, TCGOutOpUnary, outop_extu_i32_i64),
>       OUTOP(INDEX_op_extrl_i64_i32, TCGOutOpUnary, outop_extrl_i64_i32),
> +    OUTOP(INDEX_op_extrh_i64_i32, TCGOutOpUnary, outop_extrh_i64_i32),
>   #endif
>   };
>   
> @@ -2412,13 +2413,12 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_ext_i32_i64:
>       case INDEX_op_extu_i32_i64:
>       case INDEX_op_extrl_i64_i32:
> +    case INDEX_op_extrh_i64_i32:
>       case INDEX_op_deposit_i64:
>           return TCG_TARGET_REG_BITS == 64;
>   
>       case INDEX_op_extract2_i64:
>           return TCG_TARGET_HAS_extract2_i64;
> -    case INDEX_op_extrh_i64_i32:
> -        return TCG_TARGET_HAS_extr_i64_i32;
>       case INDEX_op_add2_i64:
>           return TCG_TARGET_HAS_add2_i64;
>       case INDEX_op_sub2_i64:
> @@ -5507,6 +5507,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>       case INDEX_op_ext_i32_i64:
>       case INDEX_op_extu_i32_i64:
>       case INDEX_op_extrl_i64_i32:
> +    case INDEX_op_extrh_i64_i32:
>           assert(TCG_TARGET_REG_BITS == 64);
>           /* fall through */
>       case INDEX_op_ctpop:
> diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
> index 8abc5f26da..4ea1aebc5e 100644
> --- a/tcg/aarch64/tcg-target.c.inc
> +++ b/tcg/aarch64/tcg-target.c.inc
> @@ -2220,6 +2220,16 @@ static const TCGOutOpBinary outop_eqv = {
>       .out_rrr = tgen_eqv,
>   };
>   
> +static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
> +{
> +    tcg_out_ubfm(s, TCG_TYPE_I64, a0, a1, 32, 63);
> +}
> +
> +static const TCGOutOpUnary outop_extrh_i64_i32 = {
> +    .base.static_constraint = C_O1_I1(r, r),
> +    .out_rr = tgen_extrh_i64_i32,
> +};
> +
>   static void tgen_mul(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index 9bae60d3b6..63c9aae26e 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc
> @@ -2794,6 +2794,18 @@ static const TCGOutOpBinary outop_eqv = {
>       .base.static_constraint = C_NotImplemented,
>   };
>   
> +#if TCG_TARGET_REG_BITS == 64
> +static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
> +{
> +    tcg_out_shifti(s, SHIFT_SHR + P_REXW, a0, 32);
> +}
> +
> +static const TCGOutOpUnary outop_extrh_i64_i32 = {
> +    .base.static_constraint = C_O1_I1(r, 0),
> +    .out_rr = tgen_extrh_i64_i32,
> +};
> +#endif /* TCG_TARGET_REG_BITS == 64 */
> +
>   static void tgen_mul(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -3212,6 +3224,7 @@ static const TCGOutOpExtract outop_sextract = {
>       .out_rr = tgen_sextract,
>   };
>   
> +
>   static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const TCGArg args[TCG_MAX_OP_ARGS],
>                          const int const_args[TCG_MAX_OP_ARGS])
> @@ -3363,10 +3376,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>               tcg_out_st(s, TCG_TYPE_I64, a0, a1, a2);
>           }
>           break;
> -
> -    case INDEX_op_extrh_i64_i32:
> -        tcg_out_shifti(s, SHIFT_SHR + P_REXW, a0, 32);
> -        break;
>   #endif
>   
>       OP_32_64(deposit):
> @@ -3995,9 +4004,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_st_i64:
>           return C_O0_I2(re, r);
>   
> -    case INDEX_op_extrh_i64_i32:
> -        return C_O1_I1(r, 0);
> -
>       case INDEX_op_extract2_i32:
>       case INDEX_op_extract2_i64:
>           return C_O1_I2(r, 0, r);
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index 59457c4323..fdeed82df0 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -1455,6 +1455,16 @@ static const TCGOutOpBinary outop_eqv = {
>       .base.static_constraint = C_NotImplemented,
>   };
>   
> +static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
> +{
> +    tcg_out_opc_srai_d(s, a0, a1, 32);
> +}
> +
> +static const TCGOutOpUnary outop_extrh_i64_i32 = {
> +    .base.static_constraint = C_O1_I1(r, r),
> +    .out_rr = tgen_extrh_i64_i32,
> +};
> +
>   static void tgen_mul(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -1855,10 +1865,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_opc_b(s, 0);
>           break;
>   
> -    case INDEX_op_extrh_i64_i32:
> -        tcg_out_opc_srai_d(s, a0, a1, 32);
> -        break;
> -
>       case INDEX_op_deposit_i32:
>           tcg_out_opc_bstrins_w(s, a0, a2, args[3], args[3] + args[4] - 1);
>           break;
> @@ -2456,7 +2462,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_qemu_st_i128:
>           return C_O0_I3(r, r, r);
>   
> -    case INDEX_op_extrh_i64_i32:
>       case INDEX_op_ld8s_i32:
>       case INDEX_op_ld8s_i64:
>       case INDEX_op_ld8u_i32:
> diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
> index 095eb8f672..ad0482902d 100644
> --- a/tcg/mips/tcg-target.c.inc
> +++ b/tcg/mips/tcg-target.c.inc
> @@ -1793,6 +1793,18 @@ static const TCGOutOpBinary outop_eqv = {
>       .base.static_constraint = C_NotImplemented,
>   };
>   
> +#if TCG_TARGET_REG_BITS == 64
> +static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
> +{
> +    tcg_out_dsra(s, a0, a1, 32);
> +}
> +
> +static const TCGOutOpUnary outop_extrh_i64_i32 = {
> +    .base.static_constraint = C_O1_I1(r, r),
> +    .out_rr = tgen_extrh_i64_i32,
> +};
> +#endif
> +
>   static void tgen_mul(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -2315,10 +2327,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_ldst(s, i1, a0, a1, a2);
>           break;
>   
> -    case INDEX_op_extrh_i64_i32:
> -        tcg_out_dsra(s, a0, a1, 32);
> -        break;
> -
>       case INDEX_op_deposit_i32:
>           tcg_out_opc_bf(s, OPC_INS, a0, a2, args[3] + args[4] - 1, args[3]);
>           break;
> @@ -2388,7 +2396,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_ld32s_i64:
>       case INDEX_op_ld32u_i64:
>       case INDEX_op_ld_i64:
> -    case INDEX_op_extrh_i64_i32:
>           return C_O1_I1(r, r);
>   
>       case INDEX_op_st8_i32:
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index bb03efe055..ba6d7556f7 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -2965,6 +2965,18 @@ static void tgen_eqv(TCGContext *s, TCGType type,
>       tcg_out32(s, EQV | SAB(a1, a0, a2));
>   }
>   
> +#if TCG_TARGET_REG_BITS == 64
> +static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
> +{
> +    tcg_out_shri64(s, a0, a1, 32);
> +}
> +
> +static const TCGOutOpUnary outop_extrh_i64_i32 = {
> +    .base.static_constraint = C_O1_I1(r, r),
> +    .out_rr = tgen_extrh_i64_i32,
> +};
> +#endif
> +
>   static void tgen_divs(TCGContext *s, TCGType type,
>                         TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index 76ad2df410..46b4e1167c 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -2151,6 +2151,16 @@ static const TCGOutOpBinary outop_eqv = {
>       .out_rrr = tgen_eqv,
>   };
>   
> +static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
> +{
> +    tcg_out_opc_imm(s, OPC_SRAI, a0, a1, 32);
> +}
> +
> +static const TCGOutOpUnary outop_extrh_i64_i32 = {
> +    .base.static_constraint = C_O1_I1(r, r),
> +    .out_rr = tgen_extrh_i64_i32,
> +};
> +
>   static void tgen_mul(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -2619,10 +2629,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_qemu_st(s, a0, a1, a2, TCG_TYPE_I64);
>           break;
>   
> -    case INDEX_op_extrh_i64_i32:
> -        tcg_out_opc_imm(s, OPC_SRAI, a0, a1, 32);
> -        break;
> -
>       case INDEX_op_mb:
>           tcg_out_mb(s, a0);
>           break;
> @@ -2871,7 +2877,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_ld32s_i64:
>       case INDEX_op_ld32u_i64:
>       case INDEX_op_ld_i64:
> -    case INDEX_op_extrh_i64_i32:
>           return C_O1_I1(r, r);
>   
>       case INDEX_op_st8_i32:
> diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
> index 1ea041c75f..3b3749efd3 100644
> --- a/tcg/s390x/tcg-target.c.inc
> +++ b/tcg/s390x/tcg-target.c.inc
> @@ -2409,6 +2409,16 @@ static const TCGOutOpBinary outop_eqv = {
>       .out_rrr = tgen_eqv,
>   };
>   
> +static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
> +{
> +    tcg_out_sh64(s, RSY_SRLG, a0, a1, TCG_REG_NONE, 32);
> +}
> +
> +static const TCGOutOpUnary outop_extrh_i64_i32 = {
> +    .base.static_constraint = C_O1_I1(r, r),
> +    .out_rr = tgen_extrh_i64_i32,
> +};
> +
>   static void tgen_mul(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
> index d52907f7e3..c1cce7c196 100644
> --- a/tcg/sparc64/tcg-target.c.inc
> +++ b/tcg/sparc64/tcg-target.c.inc
> @@ -1501,6 +1501,16 @@ static const TCGOutOpBinary outop_eqv = {
>       .base.static_constraint = C_NotImplemented,
>   };
>   
> +static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
> +{
> +    tcg_out_arithi(s, a0, a1, 32, SHIFT_SRLX);
> +}
> +
> +static const TCGOutOpUnary outop_extrh_i64_i32 = {
> +    .base.static_constraint = C_O1_I1(r, r),
> +    .out_rr = tgen_extrh_i64_i32,
> +};
> +
>   static void tgen_mul(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
> index e9b46d5e66..d84d01e098 100644
> --- a/tcg/tci/tcg-target.c.inc
> +++ b/tcg/tci/tcg-target.c.inc
> @@ -670,6 +670,18 @@ static const TCGOutOpBinary outop_eqv = {
>       .out_rrr = tgen_eqv,
>   };
>   
> +#if TCG_TARGET_REG_BITS == 64
> +static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
> +{
> +    tcg_out_extract(s, TCG_TYPE_I64, a0, a1, 32, 32);
> +}
> +
> +static const TCGOutOpUnary outop_extrh_i64_i32 = {
> +    .base.static_constraint = C_O1_I1(r, r),
> +    .out_rr = tgen_extrh_i64_i32,
> +};
> +#endif
> +
>   static void tgen_mul(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


