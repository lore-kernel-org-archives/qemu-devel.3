Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B974C369C7
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 20:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u59dS-0001oz-DU; Wed, 16 Apr 2025 16:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u59dP-0001oj-Re
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 16:45:27 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u59dN-0000DF-1E
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 16:45:27 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so16483b3a.2
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 13:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744836323; x=1745441123; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RoEnR5mAgMaVmgi0V/TES8ypm/iYkTJ4t9fl9mDJDA4=;
 b=GRBwISYrXhyg4fA/OGUOKrustM8z50cbEiE74e7ommUyBo4laOilVXktMh9Axa1lYz
 8SmzGxUhfliih9C8yB6jVR+lR+kXAFmprFa1ZOO88Dy9ewLsYPwemhLqQ9l4MYZWxMF7
 MaDgicZLJPB/ZJsuUOLtxYKB58WO2jbgWOdkpiSPEASdMlSNo6xnxYnsapHNc3L5Gdhw
 GN4IicV7+pKwX/k/jeRdSpUPH9umGNHGf4Nqahja9Uyd6OMIsc8YB/Nan3adNoP5mDMZ
 AdnemxbJz5kXTb5oPjYqcQtgwCfuRqMub+4FHkdpPvg/nO6lilx+48gNyxLSqNVl205M
 4Y6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744836323; x=1745441123;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RoEnR5mAgMaVmgi0V/TES8ypm/iYkTJ4t9fl9mDJDA4=;
 b=pElhHb13W2SqTYneVVpp2QYwTPG0qtDSIc9i7WqeSHgD/rh18Xp1py6tTLst4vQj+d
 cj09FeTypuN+8aoWcBCtV/XURoQfS9kvLe95WRgjPuI1+BQjRsAXj2po/fDAFqQ8vO/W
 aW6e504RuxUszLV3t1m788SUuxN5ReSFvKnx2hBiEj+wRM0n+O6unDFcoRpTViW9g97c
 1GfPEBlsdtS605GGzL8YIbzZgW+Y9LduRfcB87T8F8nXqadn2LkV2kTtLvT1clerIVB9
 5d9jb4SEhp2h0zYOIESp7EGMMrjJqyxnVSRyvc4vpxl+LB758UE7nZ3QxTEy7Mvj1nKa
 erhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH6dwnV6q/RiwvtJfd1AbxMI2sWFlJEvxWA59hfahdTq33+uLbSyFsBrbgLiaWDxX7KvBDa9RPQH35@nongnu.org
X-Gm-Message-State: AOJu0YzrP8NLXjoFQcf0FnJORdPIS/57DX1uvTLi5yhd5/+06HKTLTc4
 pqchMCXV5MX704HT4M5nX3TrDEUC00o6LO9tILmOkZbCtVC4V085PykZFUUnzH0=
X-Gm-Gg: ASbGncun8qkZsO8ut4KYv4f+huUmFle7vFdmZmYfdlGRAkKyu17pPVjJmLYeVJsQnt2
 b4HtT2KvK0P6uMmoB60x7uFbjfMBxKWL8P90n9rqYWWR2bc5KfnH+VVb+/UZIAMa1yVF9ssod06
 HXHMU5ytGRkxntrQRuBDySNpwoZhAyCkOVdnflzw6A8joRTFltMOoIi/4TqZjqOBai5r4wuejGW
 xnLyF64MZlbmYWyr4SkiFssrEzf8PvUk9tveJifDSdPCnUB2aItJpj7v1/vQcz2OOY0PYCmjvn5
 mXXNaetGehS8gOGoI6zPFXFj4eRmpJLEEe9B0smtfhDXxxweHMgj8KcDGMGlXFtP
X-Google-Smtp-Source: AGHT+IFLoItpbmzOR3Rcc6JkR4ScRXfY56c0EPkpsaXWe96Xv1knHvhfh8jouKKqScesdNrf/6tT9w==
X-Received: by 2002:a05:6a00:139f:b0:725:96f2:9e63 with SMTP id
 d2e1a72fcca58-73c267eccc9mr4917240b3a.24.1744836322946; 
 Wed, 16 Apr 2025 13:45:22 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f1293sm11243033b3a.99.2025.04.16.13.45.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 13:45:22 -0700 (PDT)
Message-ID: <35e94847-aa9a-49be-a9f4-6dae3000cb2c@linaro.org>
Date: Wed, 16 Apr 2025 13:45:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 152/163] tcg: Formalize tcg_out_goto_ptr
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-153-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-153-richard.henderson@linaro.org>
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

On 4/15/25 12:25, Richard Henderson wrote:
> Split these functions out from tcg_out_op.
> Define outop_goto_ptr generically.
> Call tcg_out_goto_ptr from tcg_reg_alloc_op.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c                        | 12 ++++++++++++
>   tcg/aarch64/tcg-target.c.inc     | 12 +++++-------
>   tcg/arm/tcg-target.c.inc         | 12 +++++-------
>   tcg/i386/tcg-target.c.inc        | 13 ++++++-------
>   tcg/loongarch64/tcg-target.c.inc | 12 +++++-------
>   tcg/mips/tcg-target.c.inc        | 22 ++++++++++------------
>   tcg/ppc/tcg-target.c.inc         | 15 +++++++--------
>   tcg/riscv/tcg-target.c.inc       | 12 +++++-------
>   tcg/s390x/tcg-target.c.inc       | 15 +++++----------
>   tcg/sparc64/tcg-target.c.inc     | 14 ++++++--------
>   tcg/tci/tcg-target.c.inc         | 12 +++++-------
>   11 files changed, 71 insertions(+), 80 deletions(-)
> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index f19f3b6a8a..05604d122a 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -133,6 +133,7 @@ static void tcg_out_addi_ptr(TCGContext *s, TCGReg, TCGReg, tcg_target_long);
>   static bool tcg_out_xchg(TCGContext *s, TCGType type, TCGReg r1, TCGReg r2);
>   static void tcg_out_exit_tb(TCGContext *s, uintptr_t arg);
>   static void tcg_out_goto_tb(TCGContext *s, int which);
> +static void tcg_out_goto_ptr(TCGContext *s, TCGReg dest);
>   static void tcg_out_mb(TCGContext *s, unsigned bar);
>   static void tcg_out_br(TCGContext *s, TCGLabel *l);
>   static void tcg_out_set_carry(TCGContext *s);
> @@ -1137,6 +1138,10 @@ static const TCGOutOpUnary outop_extrl_i64_i32 = {
>   };
>   #endif
>   
> +static const TCGOutOp outop_goto_ptr = {
> +    .static_constraint = C_O0_I1(r),
> +};
> +
>   /*
>    * Register V as the TCGOutOp for O.
>    * This verifies that V is of type T, otherwise give a nice compiler error.
> @@ -1198,6 +1203,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
>       OUTOP(INDEX_op_subb1o, TCGOutOpAddSubCarry, outop_subbio),
>       OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
>   
> +    [INDEX_op_goto_ptr] = &outop_goto_ptr,
> +
>   #if TCG_TARGET_REG_BITS == 32
>       OUTOP(INDEX_op_brcond2_i32, TCGOutOpBrcond2, outop_brcond2),
>       OUTOP(INDEX_op_setcond2_i32, TCGOutOpSetcond2, outop_setcond2),
> @@ -5818,6 +5825,11 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>           g_assert_not_reached();
>   #endif
>   
> +    case INDEX_op_goto_ptr:
> +        tcg_debug_assert(!const_args[0]);
> +        tcg_out_goto_ptr(s, new_args[0]);
> +        break;
> +
>       default:
>           if (def->flags & TCG_OPF_VECTOR) {
>               tcg_out_vec_op(s, op->opc, type - TCG_TYPE_V64,
> diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
> index fceb6e2796..2678e1f176 100644
> --- a/tcg/aarch64/tcg-target.c.inc
> +++ b/tcg/aarch64/tcg-target.c.inc
> @@ -1986,6 +1986,11 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
>       tcg_out_bti(s, BTI_J);
>   }
>   
> +static void tcg_out_goto_ptr(TCGContext *s, TCGReg a0)
> +{
> +    tcg_out_insn(s, 3207, BR, a0);
> +}
> +
>   void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
>                                 uintptr_t jmp_rx, uintptr_t jmp_rw)
>   {
> @@ -2775,10 +2780,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
>       TCGArg a2 = args[2];
>   
>       switch (opc) {
> -    case INDEX_op_goto_ptr:
> -        tcg_out_insn(s, 3207, BR, a0);
> -        break;
> -
>       case INDEX_op_ld8u_i32:
>       case INDEX_op_ld8u_i64:
>           tcg_out_ldst(s, I3312_LDRB, a0, a1, a2, 0);
> @@ -3293,9 +3294,6 @@ static TCGConstraintSetIndex
>   tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>   {
>       switch (op) {
> -    case INDEX_op_goto_ptr:
> -        return C_O0_I1(r);
> -
>       case INDEX_op_ld8u_i32:
>       case INDEX_op_ld8s_i32:
>       case INDEX_op_ld16u_i32:
> diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
> index 327b01d377..64be0a7e6d 100644
> --- a/tcg/arm/tcg-target.c.inc
> +++ b/tcg/arm/tcg-target.c.inc
> @@ -1795,6 +1795,11 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
>       set_jmp_reset_offset(s, which);
>   }
>   
> +static void tcg_out_goto_ptr(TCGContext *s, TCGReg a0)
> +{
> +    tcg_out_b_reg(s, COND_AL, a0);
> +}
> +
>   void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
>                                 uintptr_t jmp_rx, uintptr_t jmp_rw)
>   {
> @@ -2524,10 +2529,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const int const_args[TCG_MAX_OP_ARGS])
>   {
>       switch (opc) {
> -    case INDEX_op_goto_ptr:
> -        tcg_out_b_reg(s, COND_AL, args[0]);
> -        break;
> -
>       case INDEX_op_ld8u_i32:
>           tcg_out_ld8u(s, COND_AL, args[0], args[1], args[2]);
>           break;
> @@ -2579,9 +2580,6 @@ static TCGConstraintSetIndex
>   tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>   {
>       switch (op) {
> -    case INDEX_op_goto_ptr:
> -        return C_O0_I1(r);
> -
>       case INDEX_op_ld8u_i32:
>       case INDEX_op_ld8s_i32:
>       case INDEX_op_ld16u_i32:
> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index f89982378b..5ea4a44264 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc
> @@ -2593,6 +2593,12 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
>       set_jmp_reset_offset(s, which);
>   }
>   
> +static void tcg_out_goto_ptr(TCGContext *s, TCGReg a0)
> +{
> +    /* Jump to the given host address (could be epilogue) */
> +    tcg_out_modrm(s, OPC_GRP5, EXT5_JMPN_Ev, a0);
> +}
> +
>   void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
>                                 uintptr_t jmp_rx, uintptr_t jmp_rw)
>   {
> @@ -3437,10 +3443,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
>   
>       switch (opc) {
> -    case INDEX_op_goto_ptr:
> -        /* jmp to the given host address (could be epilogue) */
> -        tcg_out_modrm(s, OPC_GRP5, EXT5_JMPN_Ev, a0);
> -        break;
>       OP_32_64(ld8u):
>           /* Note that we can ignore REXW for the zero-extend to 64-bit.  */
>           tcg_out_modrm_offset(s, OPC_MOVZBL, a0, a1, a2);
> @@ -4093,9 +4095,6 @@ static TCGConstraintSetIndex
>   tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>   {
>       switch (op) {
> -    case INDEX_op_goto_ptr:
> -        return C_O0_I1(r);
> -
>       case INDEX_op_ld8u_i32:
>       case INDEX_op_ld8u_i64:
>       case INDEX_op_ld8s_i32:
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index 78d1542153..1bdce25cf4 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -1295,6 +1295,11 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
>       set_jmp_reset_offset(s, which);
>   }
>   
> +static void tcg_out_goto_ptr(TCGContext *s, TCGReg a0)
> +{
> +    tcg_out_opc_jirl(s, TCG_REG_ZERO, a0, 0);
> +}
> +
>   void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
>                                 uintptr_t jmp_rx, uintptr_t jmp_rw)
>   {
> @@ -1911,10 +1916,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       TCGArg a3 = args[3];
>   
>       switch (opc) {
> -    case INDEX_op_goto_ptr:
> -        tcg_out_opc_jirl(s, TCG_REG_ZERO, a0, 0);
> -        break;
> -
>       case INDEX_op_ld8s_i32:
>       case INDEX_op_ld8s_i64:
>           tcg_out_ldst(s, OPC_LD_B, a0, a1, a2);
> @@ -2485,9 +2486,6 @@ static TCGConstraintSetIndex
>   tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>   {
>       switch (op) {
> -    case INDEX_op_goto_ptr:
> -        return C_O0_I1(r);
> -
>       case INDEX_op_st8_i32:
>       case INDEX_op_st8_i64:
>       case INDEX_op_st16_i32:
> diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
> index f4d6ee10b9..9455a0a17b 100644
> --- a/tcg/mips/tcg-target.c.inc
> +++ b/tcg/mips/tcg-target.c.inc
> @@ -1571,6 +1571,16 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
>       }
>   }
>   
> +static void tcg_out_goto_ptr(TCGContext *s, TCGReg a0)
> +{
> +    tcg_out_opc_reg(s, OPC_JR, 0, a0, 0);
> +    if (TCG_TARGET_REG_BITS == 64) {
> +        tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_TB, a0);
> +    } else {
> +        tcg_out_nop(s);
> +    }
> +}
> +
>   void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
>                                 uintptr_t jmp_rx, uintptr_t jmp_rw)
>   {
> @@ -2277,15 +2287,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       a2 = args[2];
>   
>       switch (opc) {
> -    case INDEX_op_goto_ptr:
> -        /* jmp to the given host address (could be epilogue) */
> -        tcg_out_opc_reg(s, OPC_JR, 0, a0, 0);
> -        if (TCG_TARGET_REG_BITS == 64) {
> -            tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_TB, a0);
> -        } else {
> -            tcg_out_nop(s);
> -        }
> -        break;
>       case INDEX_op_ld8u_i32:
>       case INDEX_op_ld8u_i64:
>           i1 = OPC_LBU;
> @@ -2364,9 +2365,6 @@ static TCGConstraintSetIndex
>   tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>   {
>       switch (op) {
> -    case INDEX_op_goto_ptr:
> -        return C_O0_I1(r);
> -
>       case INDEX_op_ld8u_i32:
>       case INDEX_op_ld8s_i32:
>       case INDEX_op_ld16u_i32:
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index d88ec8d690..a2a5b1e570 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -2843,6 +2843,13 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
>       set_jmp_reset_offset(s, which);
>   }
>   
> +static void tcg_out_goto_ptr(TCGContext *s, TCGReg a0)
> +{
> +    tcg_out32(s, MTSPR | RS(a0) | CTR);
> +    tcg_out32(s, ADDI | TAI(TCG_REG_R3, 0, 0));
> +    tcg_out32(s, BCCTR | BO_ALWAYS);
> +}
> +
>   void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
>                                 uintptr_t jmp_rx, uintptr_t jmp_rw)
>   {
> @@ -3676,11 +3683,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const int const_args[TCG_MAX_OP_ARGS])
>   {
>       switch (opc) {
> -    case INDEX_op_goto_ptr:
> -        tcg_out32(s, MTSPR | RS(args[0]) | CTR);
> -        tcg_out32(s, ADDI | TAI(TCG_REG_R3, 0, 0));
> -        tcg_out32(s, BCCTR | BO_ALWAYS);
> -        break;
>       case INDEX_op_ld8u_i32:
>       case INDEX_op_ld8u_i64:
>           tcg_out_mem_long(s, LBZ, LBZX, args[0], args[1], args[2]);
> @@ -4371,9 +4373,6 @@ static TCGConstraintSetIndex
>   tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>   {
>       switch (op) {
> -    case INDEX_op_goto_ptr:
> -        return C_O0_I1(r);
> -
>       case INDEX_op_ld8u_i32:
>       case INDEX_op_ld8s_i32:
>       case INDEX_op_ld16u_i32:
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index 5d8d8213cb..c1bfd93569 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -1915,6 +1915,11 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
>       set_jmp_reset_offset(s, which);
>   }
>   
> +static void tcg_out_goto_ptr(TCGContext *s, TCGReg a0)
> +{
> +    tcg_out_opc_imm(s, OPC_JALR, TCG_REG_ZERO, a0, 0);
> +}
> +
>   void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
>                                 uintptr_t jmp_rx, uintptr_t jmp_rw)
>   {
> @@ -2535,10 +2540,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       TCGArg a2 = args[2];
>   
>       switch (opc) {
> -    case INDEX_op_goto_ptr:
> -        tcg_out_opc_imm(s, OPC_JALR, TCG_REG_ZERO, a0, 0);
> -        break;
> -
>       case INDEX_op_ld8u_i32:
>       case INDEX_op_ld8u_i64:
>           tcg_out_ldst(s, OPC_LBU, a0, a1, a2);
> @@ -2824,9 +2825,6 @@ static TCGConstraintSetIndex
>   tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>   {
>       switch (op) {
> -    case INDEX_op_goto_ptr:
> -        return C_O0_I1(r);
> -
>       case INDEX_op_ld8u_i32:
>       case INDEX_op_ld8s_i32:
>       case INDEX_op_ld16u_i32:
> diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
> index cdc61de4f8..2b2e00c609 100644
> --- a/tcg/s390x/tcg-target.c.inc
> +++ b/tcg/s390x/tcg-target.c.inc
> @@ -2213,6 +2213,11 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
>       set_jmp_reset_offset(s, which);
>   }
>   
> +static void tcg_out_goto_ptr(TCGContext *s, TCGReg a0)
> +{
> +    tcg_out_insn(s, RR, BCR, S390_CC_ALWAYS, a0);
> +}
> +
>   void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
>                                 uintptr_t jmp_rx, uintptr_t jmp_rw)
>   {
> @@ -3033,14 +3038,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const TCGArg args[TCG_MAX_OP_ARGS],
>                          const int const_args[TCG_MAX_OP_ARGS])
>   {
> -    TCGArg a0;
> -
>       switch (opc) {
> -    case INDEX_op_goto_ptr:
> -        a0 = args[0];
> -        tcg_out_insn(s, RR, BCR, S390_CC_ALWAYS, a0);
> -        break;
> -
>       OP_32_64(ld8u):
>           /* ??? LLC (RXY format) is only present with the extended-immediate
>              facility, whereas LLGC is always present.  */
> @@ -3567,9 +3565,6 @@ static TCGConstraintSetIndex
>   tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>   {
>       switch (op) {
> -    case INDEX_op_goto_ptr:
> -        return C_O0_I1(r);
> -
>       case INDEX_op_ld8u_i32:
>       case INDEX_op_ld8u_i64:
>       case INDEX_op_ld8s_i32:
> diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
> index e4073b7732..bb83279e2c 100644
> --- a/tcg/sparc64/tcg-target.c.inc
> +++ b/tcg/sparc64/tcg-target.c.inc
> @@ -1300,6 +1300,12 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
>       }
>   }
>   
> +static void tcg_out_goto_ptr(TCGContext *s, TCGReg a0)
> +{
> +    tcg_out_arithi(s, TCG_REG_G0, a0, 0, JMPL);
> +    tcg_out_mov_delay(s, TCG_REG_TB, a0);
> +}
> +
>   void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
>                                 uintptr_t jmp_rx, uintptr_t jmp_rw)
>   {
> @@ -1963,11 +1969,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       a2 = args[2];
>   
>       switch (opc) {
> -    case INDEX_op_goto_ptr:
> -        tcg_out_arithi(s, TCG_REG_G0, a0, 0, JMPL);
> -        tcg_out_mov_delay(s, TCG_REG_TB, a0);
> -        break;
> -
>   #define OP_32_64(x)                             \
>           glue(glue(case INDEX_op_, x), _i32):    \
>           glue(glue(case INDEX_op_, x), _i64)
> @@ -2034,9 +2035,6 @@ static TCGConstraintSetIndex
>   tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>   {
>       switch (op) {
> -    case INDEX_op_goto_ptr:
> -        return C_O0_I1(r);
> -
>       case INDEX_op_ld8u_i32:
>       case INDEX_op_ld8u_i64:
>       case INDEX_op_ld8s_i32:
> diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
> index 55a1a74fb6..d9cd62ed3d 100644
> --- a/tcg/tci/tcg-target.c.inc
> +++ b/tcg/tci/tcg-target.c.inc
> @@ -40,9 +40,6 @@ static TCGConstraintSetIndex
>   tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>   {
>       switch (op) {
> -    case INDEX_op_goto_ptr:
> -        return C_O0_I1(r);
> -
>       case INDEX_op_ld8u_i32:
>       case INDEX_op_ld8s_i32:
>       case INDEX_op_ld16u_i32:
> @@ -534,6 +531,11 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
>       set_jmp_reset_offset(s, which);
>   }
>   
> +static void tcg_out_goto_ptr(TCGContext *s, TCGReg a0)
> +{
> +    tcg_out_op_r(s, INDEX_op_goto_ptr, a0);
> +}
> +
>   void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
>                                 uintptr_t jmp_rx, uintptr_t jmp_rw)
>   {
> @@ -1146,10 +1148,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const int const_args[TCG_MAX_OP_ARGS])
>   {
>       switch (opc) {
> -    case INDEX_op_goto_ptr:
> -        tcg_out_op_r(s, opc, args[0]);
> -        break;
> -
>       CASE_32_64(ld8u)
>       CASE_32_64(ld8s)
>       CASE_32_64(ld16u)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


