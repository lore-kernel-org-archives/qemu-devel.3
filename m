Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BC9C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 21:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4nQb-0000jh-GU; Tue, 15 Apr 2025 17:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4nQN-0000eL-P5
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:02:36 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4nQK-00058z-4T
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:02:31 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22c33ac23edso190065ad.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 14:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744750945; x=1745355745; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3fMyeOUeU9Z5qPjaBEw/+4StNsXmx42HGJXsjaIvct4=;
 b=aBYUdi3oETwUJhKO38N/SbVcob6QlSRjMnzI6EK+Xh5XrK5wPR3tcXS6IY8ohaNpZl
 DtJJn1PA2SkY3WxxvRqWWt+1AnkV22/rv15EUpZM0iSrLaYaKAf+33EiVTGEl/IgGGrW
 NseXyT8dby2hOQlq5BgExsi3DFkzstUtbCRmkHs63OxvHA1ujRLM+PZ2+Kn9D8hZHhN+
 Zk9yidZXy6slXST3pxZ9zlnsuv1LZKBYF4RT7UAtuwpEWrw1qEZItpVuWoc8yH2Nc37F
 dRvp0CMERzTP734cOLMSqCTqaRPvEcSPpp5LEVrJIyUZeEhPT+lkRi0ZeJHw0ayFiAgL
 P7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744750945; x=1745355745;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3fMyeOUeU9Z5qPjaBEw/+4StNsXmx42HGJXsjaIvct4=;
 b=AOwmlVw9/i3g8k73H1f6eV2q39pX24tO23Aex9myZK8+VebmjHkiKKWZ9a9EI8eS63
 zeVVJZmVMTLHGI/iz7B6D/O1SMOm7GoGSK6RiCuZVXuYUKn1wWjfq+NPtH/Q/qUjh0BY
 IRHsYlHQNNRE4eaFrZkM6vAG9nxV1O9rWhyHUD4RCpIR9DJnTLoQCq9OMUT7eGwtOpZX
 uyP9qCmYqhfcxHRkASn3Clz3HA+ANeA7c2LH3L3Sg8edCqru02iTt7K9qnYPZJDKiL56
 igf7/bWQVsmVgBOJClIIrhKHoxCE3G22MpOhCqDpjyZiisvZUQ/sqa0Upw/fNwZRNida
 Y5LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWva6qH0WLIGSP7nI+xXntnuqN/md704KKduZOgCfCPP4I3VsYsVgRdZ6wgRo8pcSlq+sWxMdEbH8kH@nongnu.org
X-Gm-Message-State: AOJu0YzEGiRJffJNbCEEJDZ89FS4FbJFXPPr2JiaCMSQYgAGY5EZ2alx
 Noad2VwSOR0YJ2K4HjzPYGuSG9GTVBTElhz3+chkwFqt7nlRAabHeksQqE2fidOlfj/8BAYlv4o
 eBOk=
X-Gm-Gg: ASbGncv0uWlY0JdN7ylT1BANuWrSeigXSkK39tEXtZgq5ynWsd3UtGls4j4aBSHS8pA
 eEeqPDnS6FCeKPD9Ns+8GNStcxdvUFcsIruokQrhF+GfSYh2hNga4dsA9qWWEdC47TuAcN6j9Fj
 WBuptnAtBhtLk1+ZM6TJB8UeZc2lqmsKJWTm+7ublA5TpROHb1Ooy49BBwBaSYzjmIp/jW3/wPH
 k4pK7NxL0IRPngmF00IjInvwYwc0PRhVslS4Zpimw/hbzh8r7rV16V1yX/SJGDev3V/AUqSkKfY
 OBzxigQbcRqchPUqBCLvLx5Dk8iZGDx8KBEbNDj4DoRXiSHh3i7kxA==
X-Google-Smtp-Source: AGHT+IEThpAXqbApskevpw24z/8/dGY98QGydIggYE7//z2GZEMdfdFOMznMBEuMLRBnpYQM7PRIRg==
X-Received: by 2002:a17:902:ea04:b0:224:1294:1d26 with SMTP id
 d9443c01a7336-22c318b9ad4mr9063575ad.13.1744750944677; 
 Tue, 15 Apr 2025 14:02:24 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7b8ea6csm122925155ad.97.2025.04.15.14.02.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 14:02:24 -0700 (PDT)
Message-ID: <07580d13-7dd3-4de4-a354-484d2ce34426@linaro.org>
Date: Tue, 15 Apr 2025 14:02:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 041/163] tcg: Convert div to TCGOutOpBinary
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-42-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-42-richard.henderson@linaro.org>
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

On 4/15/25 12:23, Richard Henderson wrote:
> For TCI, we're losing type information in the interpreter.
> Introduce a tci-specific opcode to handle the difference.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op.c                     |  8 +++---
>   tcg/tcg.c                        |  6 +++--
>   tcg/tci.c                        |  3 ++-
>   tcg/aarch64/tcg-target.c.inc     | 17 ++++++++-----
>   tcg/arm/tcg-target.c.inc         | 28 +++++++++++++--------
>   tcg/i386/tcg-target.c.inc        |  4 +++
>   tcg/loongarch64/tcg-target.c.inc | 24 +++++++++++-------
>   tcg/mips/tcg-target.c.inc        | 37 ++++++++++++++++------------
>   tcg/ppc/tcg-target.c.inc         | 21 +++++++++-------
>   tcg/riscv/tcg-target.c.inc       | 21 +++++++++-------
>   tcg/s390x/tcg-target.c.inc       |  4 +++
>   tcg/sparc64/tcg-target.c.inc     | 42 ++++++++++++++++++++++++++------
>   tcg/tci/tcg-target-opc.h.inc     |  1 +
>   tcg/tci/tcg-target.c.inc         | 17 ++++++++++---
>   14 files changed, 156 insertions(+), 77 deletions(-)
> 
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 664c698187..69e50f968f 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -601,7 +601,7 @@ void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
>   
>   void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
>   {
> -    if (TCG_TARGET_HAS_div_i32) {
> +    if (tcg_op_supported(INDEX_op_div_i32, TCG_TYPE_I32, 0)) {
>           tcg_gen_op3_i32(INDEX_op_div_i32, ret, arg1, arg2);
>       } else if (TCG_TARGET_HAS_div2_i32) {
>           TCGv_i32 t0 = tcg_temp_ebb_new_i32();
> @@ -617,7 +617,7 @@ void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
>   {
>       if (TCG_TARGET_HAS_rem_i32) {
>           tcg_gen_op3_i32(INDEX_op_rem_i32, ret, arg1, arg2);
> -    } else if (TCG_TARGET_HAS_div_i32) {
> +    } else if (tcg_op_supported(INDEX_op_div_i32, TCG_TYPE_I32, 0)) {
>           TCGv_i32 t0 = tcg_temp_ebb_new_i32();
>           tcg_gen_op3_i32(INDEX_op_div_i32, t0, arg1, arg2);
>           tcg_gen_mul_i32(t0, t0, arg2);
> @@ -1969,7 +1969,7 @@ void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
>   
>   void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
>   {
> -    if (TCG_TARGET_HAS_div_i64) {
> +    if (tcg_op_supported(INDEX_op_div_i64, TCG_TYPE_I64, 0)) {
>           tcg_gen_op3_i64(INDEX_op_div_i64, ret, arg1, arg2);
>       } else if (TCG_TARGET_HAS_div2_i64) {
>           TCGv_i64 t0 = tcg_temp_ebb_new_i64();
> @@ -1985,7 +1985,7 @@ void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
>   {
>       if (TCG_TARGET_HAS_rem_i64) {
>           tcg_gen_op3_i64(INDEX_op_rem_i64, ret, arg1, arg2);
> -    } else if (TCG_TARGET_HAS_div_i64) {
> +    } else if (tcg_op_supported(INDEX_op_div_i64, TCG_TYPE_I64, 0)) {
>           TCGv_i64 t0 = tcg_temp_ebb_new_i64();
>           tcg_gen_op3_i64(INDEX_op_div_i64, t0, arg1, arg2);
>           tcg_gen_mul_i64(t0, t0, arg2);
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index e6c8fd0911..52a8842cd3 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1020,6 +1020,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
>       OUTOP(INDEX_op_add, TCGOutOpBinary, outop_add),
>       OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
>       OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
> +    OUTOP(INDEX_op_div_i32, TCGOutOpBinary, outop_divs),
> +    OUTOP(INDEX_op_div_i64, TCGOutOpBinary, outop_divs),
>       OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
>       OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
>       OUTOP(INDEX_op_mulsh, TCGOutOpBinary, outop_mulsh),
> @@ -2260,7 +2262,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
>   
>       case INDEX_op_negsetcond_i32:
>           return TCG_TARGET_HAS_negsetcond_i32;
> -    case INDEX_op_div_i32:
>       case INDEX_op_divu_i32:
>           return TCG_TARGET_HAS_div_i32;
>       case INDEX_op_rem_i32:
> @@ -2323,7 +2324,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
>   
>       case INDEX_op_negsetcond_i64:
>           return TCG_TARGET_HAS_negsetcond_i64;
> -    case INDEX_op_div_i64:
>       case INDEX_op_divu_i64:
>           return TCG_TARGET_HAS_div_i64;
>       case INDEX_op_rem_i64:
> @@ -5414,6 +5414,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>       case INDEX_op_add:
>       case INDEX_op_and:
>       case INDEX_op_andc:
> +    case INDEX_op_div_i32:
> +    case INDEX_op_div_i64:
>       case INDEX_op_eqv:
>       case INDEX_op_mul:
>       case INDEX_op_mulsh:
> diff --git a/tcg/tci.c b/tcg/tci.c
> index 61c0ccf21e..4ecbb2d335 100644
> --- a/tcg/tci.c
> +++ b/tcg/tci.c
> @@ -578,7 +578,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
>   
>               /* Arithmetic operations (32 bit). */
>   
> -        case INDEX_op_div_i32:
> +        case INDEX_op_tci_divs32:
>               tci_args_rrr(insn, &r0, &r1, &r2);
>               regs[r0] = (int32_t)regs[r1] / (int32_t)regs[r2];
>               break;
> @@ -1101,6 +1101,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
>       case INDEX_op_clz_i64:
>       case INDEX_op_ctz_i32:
>       case INDEX_op_ctz_i64:
> +    case INDEX_op_tci_divs32:
>           tci_args_rrr(insn, &r0, &r1, &r2);
>           info->fprintf_func(info->stream, "%-12s  %s, %s, %s",
>                              op_name, str_r(r0), str_r(r1), str_r(r2));
> diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
> index 493c504682..52069f1445 100644
> --- a/tcg/aarch64/tcg-target.c.inc
> +++ b/tcg/aarch64/tcg-target.c.inc
> @@ -2157,6 +2157,17 @@ static const TCGOutOpBinary outop_andc = {
>       .out_rrr = tgen_andc,
>   };
>   
> +static void tgen_divs(TCGContext *s, TCGType type,
> +                      TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tcg_out_insn(s, 3508, SDIV, type, a0, a1, a2);
> +}
> +
> +static const TCGOutOpBinary outop_divs = {
> +    .base.static_constraint = C_O1_I2(r, r, r),
> +    .out_rrr = tgen_divs,
> +};
> +
>   static void tgen_eqv(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -2362,10 +2373,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
>           tcg_out_ldst(s, I3312_STRX, a0, a1, a2, 3);
>           break;
>   
> -    case INDEX_op_div_i64:
> -    case INDEX_op_div_i32:
> -        tcg_out_insn(s, 3508, SDIV, ext, a0, a1, a2);
> -        break;
>       case INDEX_op_divu_i64:
>       case INDEX_op_divu_i32:
>           tcg_out_insn(s, 3508, UDIV, ext, a0, a1, a2);
> @@ -3057,8 +3064,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_negsetcond_i64:
>           return C_O1_I2(r, r, rC);
>   
> -    case INDEX_op_div_i32:
> -    case INDEX_op_div_i64:
>       case INDEX_op_divu_i32:
>       case INDEX_op_divu_i64:
>       case INDEX_op_rem_i32:
> diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
> index 1c19004e6e..e07e4c06d9 100644
> --- a/tcg/arm/tcg-target.c.inc
> +++ b/tcg/arm/tcg-target.c.inc
> @@ -937,12 +937,6 @@ static void tcg_out_smull32(TCGContext *s, ARMCond cond, TCGReg rd0,
>                 (rd1 << 16) | (rd0 << 12) | (rm << 8) | rn);
>   }
>   
> -static void tcg_out_sdiv(TCGContext *s, ARMCond cond,
> -                         TCGReg rd, TCGReg rn, TCGReg rm)
> -{
> -    tcg_out32(s, 0x0710f010 | (cond << 28) | (rd << 16) | rn | (rm << 8));
> -}
> -
>   static void tcg_out_udiv(TCGContext *s, ARMCond cond,
>                            TCGReg rd, TCGReg rn, TCGReg rm)
>   {
> @@ -1874,6 +1868,24 @@ static const TCGOutOpBinary outop_andc = {
>       .out_rrr = tgen_andc,
>   };
>   
> +static TCGConstraintSetIndex cset_idiv(TCGType type, unsigned flags)
> +{
> +    return use_idiv_instructions ? C_O1_I2(r, r, r) : C_NotImplemented;
> +}
> +
> +static void tgen_divs(TCGContext *s, TCGType type,
> +                      TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    /* sdiv */
> +    tcg_out32(s, 0x0710f010 | (COND_AL << 28) | (a0 << 16) | a1 | (a2 << 8));
> +}
> +
> +static const TCGOutOpBinary outop_divs = {
> +    .base.static_constraint = C_Dynamic,
> +    .base.dynamic_constraint = cset_idiv,
> +    .out_rrr = tgen_divs,
> +};
> +
>   static const TCGOutOpBinary outop_eqv = {
>       .base.static_constraint = C_NotImplemented,
>   };
> @@ -2218,9 +2230,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           }
>           break;
>   
> -    case INDEX_op_div_i32:
> -        tcg_out_sdiv(s, COND_AL, args[0], args[1], args[2]);
> -        break;
>       case INDEX_op_divu_i32:
>           tcg_out_udiv(s, COND_AL, args[0], args[1], args[2]);
>           break;
> @@ -2268,7 +2277,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_ctz_i32:
>           return C_O1_I2(r, r, rIK);
>   
> -    case INDEX_op_div_i32:
>       case INDEX_op_divu_i32:
>           return C_O1_I2(r, r, r);
>   
> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index d0391157a4..e132dd0c88 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc
> @@ -2633,6 +2633,10 @@ static const TCGOutOpBinary outop_andc = {
>       .out_rrr = tgen_andc,
>   };
>   
> +static const TCGOutOpBinary outop_divs = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
>   static const TCGOutOpBinary outop_eqv = {
>       .base.static_constraint = C_NotImplemented,
>   };
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index 65a93050cc..3970dcabbc 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -1316,6 +1316,21 @@ static const TCGOutOpBinary outop_andc = {
>       .out_rrr = tgen_andc,
>   };
>   
> +static void tgen_divs(TCGContext *s, TCGType type,
> +                      TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    if (type == TCG_TYPE_I32) {
> +        tcg_out_opc_div_w(s, a0, a1, a2);
> +    } else {
> +        tcg_out_opc_div_d(s, a0, a1, a2);
> +    }
> +}
> +
> +static const TCGOutOpBinary outop_divs = {
> +    .base.static_constraint = C_O1_I2(r, r, r),
> +    .out_rrr = tgen_divs,
> +};
> +
>   static const TCGOutOpBinary outop_eqv = {
>       .base.static_constraint = C_NotImplemented,
>   };
> @@ -1659,13 +1674,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           }
>           break;
>   
> -    case INDEX_op_div_i32:
> -        tcg_out_opc_div_w(s, a0, a1, a2);
> -        break;
> -    case INDEX_op_div_i64:
> -        tcg_out_opc_div_d(s, a0, a1, a2);
> -        break;
> -
>       case INDEX_op_divu_i32:
>           tcg_out_opc_div_wu(s, a0, a1, a2);
>           break;
> @@ -2351,8 +2359,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_setcond_i64:
>           return C_O1_I2(r, rz, rJ);
>   
> -    case INDEX_op_div_i32:
> -    case INDEX_op_div_i64:
>       case INDEX_op_divu_i32:
>       case INDEX_op_divu_i64:
>       case INDEX_op_rem_i32:
> diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
> index a1c215c25d..7762d88e6b 100644
> --- a/tcg/mips/tcg-target.c.inc
> +++ b/tcg/mips/tcg-target.c.inc
> @@ -1712,6 +1712,27 @@ static const TCGOutOpBinary outop_andc = {
>       .base.static_constraint = C_NotImplemented,
>   };
>   
> +static void tgen_divs(TCGContext *s, TCGType type,
> +                      TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    if (use_mips32r6_instructions) {
> +        if (type == TCG_TYPE_I32) {
> +            tcg_out_opc_reg(s, OPC_DIV_R6, a0, a1, a2);
> +        } else {
> +            tcg_out_opc_reg(s, OPC_DDIV_R6, a0, a1, a2);
> +        }
> +    } else {
> +        MIPSInsn insn = type == TCG_TYPE_I32 ? OPC_DIV : OPC_DDIV;
> +        tcg_out_opc_reg(s, insn, 0, a1, a2);
> +        tcg_out_opc_reg(s, OPC_MFLO, a0, 0, 0);
> +    }
> +}
> +
> +static const TCGOutOpBinary outop_divs = {
> +    .base.static_constraint = C_O1_I2(r, r, r),
> +    .out_rrr = tgen_divs,
> +};
> +
>   static const TCGOutOpBinary outop_eqv = {
>       .base.static_constraint = C_NotImplemented,
>   };
> @@ -1939,13 +1960,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_ldst(s, i1, a0, a1, a2);
>           break;
>   
> -    case INDEX_op_div_i32:
> -        if (use_mips32r6_instructions) {
> -            tcg_out_opc_reg(s, OPC_DIV_R6, a0, a1, a2);
> -            break;
> -        }
> -        i1 = OPC_DIV, i2 = OPC_MFLO;
> -        goto do_hilo1;
>       case INDEX_op_divu_i32:
>           if (use_mips32r6_instructions) {
>               tcg_out_opc_reg(s, OPC_DIVU_R6, a0, a1, a2);
> @@ -1967,13 +1981,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           }
>           i1 = OPC_DIVU, i2 = OPC_MFHI;
>           goto do_hilo1;
> -    case INDEX_op_div_i64:
> -        if (use_mips32r6_instructions) {
> -            tcg_out_opc_reg(s, OPC_DDIV_R6, a0, a1, a2);
> -            break;
> -        }
> -        i1 = OPC_DDIV, i2 = OPC_MFLO;
> -        goto do_hilo1;
>       case INDEX_op_divu_i64:
>           if (use_mips32r6_instructions) {
>               tcg_out_opc_reg(s, OPC_DDIVU_R6, a0, a1, a2);
> @@ -2253,12 +2260,10 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_st_i64:
>           return C_O0_I2(rz, r);
>   
> -    case INDEX_op_div_i32:
>       case INDEX_op_divu_i32:
>       case INDEX_op_rem_i32:
>       case INDEX_op_remu_i32:
>       case INDEX_op_setcond_i32:
> -    case INDEX_op_div_i64:
>       case INDEX_op_divu_i64:
>       case INDEX_op_rem_i64:
>       case INDEX_op_remu_i64:
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index 7ebadf396a..9fdf8df082 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -2960,6 +2960,18 @@ static void tgen_eqv(TCGContext *s, TCGType type,
>       tcg_out32(s, EQV | SAB(a1, a0, a2));
>   }
>   
> +static void tgen_divs(TCGContext *s, TCGType type,
> +                      TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    uint32_t insn = type == TCG_TYPE_I32 ? DIVW : DIVD;
> +    tcg_out32(s, insn | TAB(a0, a1, a2));
> +}
> +
> +static const TCGOutOpBinary outop_divs = {
> +    .base.static_constraint = C_O1_I2(r, r, r),
> +    .out_rrr = tgen_divs,
> +};
> +
>   static const TCGOutOpBinary outop_eqv = {
>       .base.static_constraint = C_O1_I2(r, r, r),
>       .out_rrr = tgen_eqv,
> @@ -3209,10 +3221,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out32(s, CNTPOPD | SAB(args[1], args[0], 0));
>           break;
>   
> -    case INDEX_op_div_i32:
> -        tcg_out32(s, DIVW | TAB(args[0], args[1], args[2]));
> -        break;
> -
>       case INDEX_op_divu_i32:
>           tcg_out32(s, DIVWU | TAB(args[0], args[1], args[2]));
>           break;
> @@ -3317,9 +3325,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           }
>           break;
>   
> -    case INDEX_op_div_i64:
> -        tcg_out32(s, DIVD | TAB(args[0], args[1], args[2]));
> -        break;
>       case INDEX_op_divu_i64:
>           tcg_out32(s, DIVDU | TAB(args[0], args[1], args[2]));
>           break;
> @@ -4184,11 +4189,9 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_rotr_i64:
>           return C_O1_I2(r, r, ri);
>   
> -    case INDEX_op_div_i32:
>       case INDEX_op_divu_i32:
>       case INDEX_op_rem_i32:
>       case INDEX_op_remu_i32:
> -    case INDEX_op_div_i64:
>       case INDEX_op_divu_i64:
>       case INDEX_op_rem_i64:
>       case INDEX_op_remu_i64:
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index 82f76b8e0c..15925729dc 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -1997,6 +1997,18 @@ static const TCGOutOpBinary outop_andc = {
>       .out_rrr = tgen_andc,
>   };
>   
> +static void tgen_divs(TCGContext *s, TCGType type,
> +                      TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_DIVW : OPC_DIV;
> +    tcg_out_opc_reg(s, insn, a0, a1, a2);
> +}
> +
> +static const TCGOutOpBinary outop_divs = {
> +    .base.static_constraint = C_O1_I2(r, r, r),
> +    .out_rrr = tgen_divs,
> +};
> +
>   static void tgen_eqv(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -2201,13 +2213,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_ldst(s, OPC_SD, a0, a1, a2);
>           break;
>   
> -    case INDEX_op_div_i32:
> -        tcg_out_opc_reg(s, OPC_DIVW, a0, a1, a2);
> -        break;
> -    case INDEX_op_div_i64:
> -        tcg_out_opc_reg(s, OPC_DIV, a0, a1, a2);
> -        break;
> -
>       case INDEX_op_divu_i32:
>           tcg_out_opc_reg(s, OPC_DIVUW, a0, a1, a2);
>           break;
> @@ -2730,11 +2735,9 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_negsetcond_i64:
>           return C_O1_I2(r, r, rI);
>   
> -    case INDEX_op_div_i32:
>       case INDEX_op_divu_i32:
>       case INDEX_op_rem_i32:
>       case INDEX_op_remu_i32:
> -    case INDEX_op_div_i64:
>       case INDEX_op_divu_i64:
>       case INDEX_op_rem_i64:
>       case INDEX_op_remu_i64:
> diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
> index 2685e6ffa1..fd0e717c49 100644
> --- a/tcg/s390x/tcg-target.c.inc
> +++ b/tcg/s390x/tcg-target.c.inc
> @@ -2242,6 +2242,10 @@ static const TCGOutOpBinary outop_andc = {
>       .out_rrr = tgen_andc,
>   };
>   
> +static const TCGOutOpBinary outop_divs = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
>   static void tgen_eqv(TCGContext *s, TCGType type,
>                         TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
> index 95a138ef56..779d0ce882 100644
> --- a/tcg/sparc64/tcg-target.c.inc
> +++ b/tcg/sparc64/tcg-target.c.inc
> @@ -1333,6 +1333,40 @@ static const TCGOutOpBinary outop_andc = {
>       .out_rrr = tgen_andc,
>   };
>   
> +static void tgen_divs_rJ(TCGContext *s, TCGType type,
> +                         TCGReg a0, TCGReg a1, TCGArg a2, bool c2)
> +{
> +    uint32_t insn;
> +
> +    if (type == TCG_TYPE_I32) {
> +        /* Load Y with the sign extension of a1 to 64-bits.  */
> +        tcg_out_arithi(s, TCG_REG_T1, a1, 31, SHIFT_SRA);
> +        tcg_out_sety(s, TCG_REG_T1);
> +        insn = ARITH_SDIV;
> +    } else {
> +        insn = ARITH_SDIVX;
> +    }
> +    tcg_out_arithc(s, a0, a1, a2, c2, insn);
> +}
> +
> +static void tgen_divs(TCGContext *s, TCGType type,
> +                      TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tgen_divs_rJ(s, type, a0, a1, a2, false);
> +}
> +
> +static void tgen_divsi(TCGContext *s, TCGType type,
> +                       TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    tgen_divs_rJ(s, type, a0, a1, a2, true);
> +}
> +
> +static const TCGOutOpBinary outop_divs = {
> +    .base.static_constraint = C_O1_I2(r, r, rJ),
> +    .out_rrr = tgen_divs,
> +    .out_rri = tgen_divsi,
> +};
> +
>   static const TCGOutOpBinary outop_eqv = {
>       .base.static_constraint = C_NotImplemented,
>   };
> @@ -1532,9 +1566,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           c = SHIFT_SRA;
>           goto do_shift32;
>   
> -    case INDEX_op_div_i32:
> -        tcg_out_div32(s, a0, a1, a2, c2, 0);
> -        break;
>       case INDEX_op_divu_i32:
>           tcg_out_div32(s, a0, a1, a2, c2, 1);
>           break;
> @@ -1607,9 +1638,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       case INDEX_op_sar_i64:
>           c = SHIFT_SRAX;
>           goto do_shift64;
> -    case INDEX_op_div_i64:
> -        c = ARITH_SDIVX;
> -        goto gen_arith;
>       case INDEX_op_divu_i64:
>           c = ARITH_UDIVX;
>           goto gen_arith;
> @@ -1700,8 +1728,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_qemu_st_i64:
>           return C_O0_I2(rz, r);
>   
> -    case INDEX_op_div_i32:
> -    case INDEX_op_div_i64:
>       case INDEX_op_divu_i32:
>       case INDEX_op_divu_i64:
>       case INDEX_op_shl_i32:
> diff --git a/tcg/tci/tcg-target-opc.h.inc b/tcg/tci/tcg-target-opc.h.inc
> index ecc8c4e55e..f503374643 100644
> --- a/tcg/tci/tcg-target-opc.h.inc
> +++ b/tcg/tci/tcg-target-opc.h.inc
> @@ -2,3 +2,4 @@
>   /* These opcodes for use between the tci generator and interpreter. */
>   DEF(tci_movi, 1, 0, 1, TCG_OPF_NOT_PRESENT)
>   DEF(tci_movl, 1, 0, 1, TCG_OPF_NOT_PRESENT)
> +DEF(tci_divs32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
> diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
> index 1dcce543ec..c8e86a3253 100644
> --- a/tcg/tci/tcg-target.c.inc
> +++ b/tcg/tci/tcg-target.c.inc
> @@ -79,8 +79,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_st_i64:
>           return C_O0_I2(r, r);
>   
> -    case INDEX_op_div_i32:
> -    case INDEX_op_div_i64:
>       case INDEX_op_divu_i32:
>       case INDEX_op_divu_i64:
>       case INDEX_op_rem_i32:
> @@ -648,6 +646,20 @@ static const TCGOutOpBinary outop_andc = {
>       .out_rrr = tgen_andc,
>   };
>   
> +static void tgen_divs(TCGContext *s, TCGType type,
> +                      TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    TCGOpcode opc = (type == TCG_TYPE_I32
> +                     ? INDEX_op_tci_divs32
> +                     : INDEX_op_div_i64);
> +    tcg_out_op_rrr(s, opc, a0, a1, a2);
> +}
> +
> +static const TCGOutOpBinary outop_divs = {
> +    .base.static_constraint = C_O1_I2(r, r, r),
> +    .out_rrr = tgen_divs,
> +};
> +
>   static void tgen_eqv(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -811,7 +823,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       CASE_32_64(sar)
>       CASE_32_64(rotl)     /* Optional (TCG_TARGET_HAS_rot_*). */
>       CASE_32_64(rotr)     /* Optional (TCG_TARGET_HAS_rot_*). */
> -    CASE_32_64(div)      /* Optional (TCG_TARGET_HAS_div_*). */
>       CASE_32_64(divu)     /* Optional (TCG_TARGET_HAS_div_*). */
>       CASE_32_64(rem)      /* Optional (TCG_TARGET_HAS_div_*). */
>       CASE_32_64(remu)     /* Optional (TCG_TARGET_HAS_div_*). */

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


