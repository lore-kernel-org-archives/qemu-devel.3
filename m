Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4602DC531DC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 09:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seATw-0005vu-53; Wed, 14 Aug 2024 05:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seATt-0005tk-J5
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 05:39:49 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seATr-00060B-59
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 05:39:49 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-66599ca3470so61260277b3.2
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 02:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723628386; x=1724233186; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jo/T00wKfJEE9pRxB2Af/oAoDThPpdv9tyrr/itzqv4=;
 b=dWmLlTz58YPIkqjGQ1aFQ4Fon0eggf3VPK5ZRaClcRon+OVnGTCoAelR19WqSPpchG
 dz7O8AhQcTuam+szywQkbvmOpV2UsvxbPGYba3hyvuNo8zxkLmRgpCMZn1losJ8nc5vp
 Drw/O3Dn2l5g0Q+7Ho7f2+xEfAep9zPH9kfXhGpVF9gD+UlLHM0GPRerTOT35zsTLpT3
 MeSmsN+Vzm/6MNPUEFuTlVmwHhEKcQC6UrbXCWHejWqIiFH/oYtQ0J9UXlB33T8TdnoK
 xXUNK52V+BZmU2NKKfcAMES398RCJTVHRz0yuovep9ngymABG+SuSIeHKxq97qUq38ML
 NNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723628386; x=1724233186;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jo/T00wKfJEE9pRxB2Af/oAoDThPpdv9tyrr/itzqv4=;
 b=OXOBE4B0SFdbznZZvBucixvnhxQra8rgYoSnzjKBeZ51yezgC47s/S6wwLYDct7oZy
 yuXUIiZv7gsIasI7pF9H3ANFY9qDlApnSGEzZNu7bYbYUWNROcnMzAEdeCf0Amu1GHLC
 9d/exy+iomNCBfGbfdx36+/QTv3wTnJyIDsXNwglc53cHswA9xRJLt7EhkD/UpCfcR6a
 ovUinnfMoh6OGpdvxwWY8NGXL76ZQrM9UPs4jCrIKIQsO5um7bYeH0s8MVJulvtZZKjz
 8vhPxr2K4lqGi1rM1Vic5Z94QsgHaWk2/p8UrwXBWRScvaSPfhAut2rrLzbSUBHaptl/
 m5UA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6fTasMUz9vhLxMxusPWxaD4j+uuZ7qFu7t2sbqy8AmdX6kSBrCEoLpVbevpa9mDyx1/QMTInken5Rc0JNi45IOsAQGDI=
X-Gm-Message-State: AOJu0YwPn7YN4Zkq1SsU0NQ6vew/rk2okZfR/rM9Ab7aV31c17VBgkVH
 omEq6GqQ6ZdYNZ02XHa/LjKe+cq5KJxS2SgClCr6XnGZ9cgIJ2zM/ih5k7ltc9k=
X-Google-Smtp-Source: AGHT+IGma+M9HMvCA7hko+0P16e2KFU+Pu02pXoqxM4UAnhZQtu8zU+LEUG2j3w9cvf8j1tW9rnp3w==
X-Received: by 2002:a05:690c:f07:b0:61b:df5:7876 with SMTP id
 00721157ae682-6ac9621acc1mr27102737b3.6.1723628385639; 
 Wed, 14 Aug 2024 02:39:45 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e5ab3054sm6969171b3a.188.2024.08.14.02.39.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Aug 2024 02:39:45 -0700 (PDT)
Message-ID: <2153fef3-ebdb-41de-9908-89b4649c6999@linaro.org>
Date: Wed, 14 Aug 2024 19:39:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/15] tcg/riscv: Implement vector cmp ops
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
 <20240813113436.831-10-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240813113436.831-10-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/13/24 21:34, LIU Zhiwei wrote:
> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> 
> 1.Address immediate value constraints in RISC-V Vector Extension 1.0 for
> comparison instructions.
> 
> 2.Extend comparison results from mask registers to SEW-width elements,
>    following recommendations in The RISC-V SPEC Volume I (Version 20240411).
> 
> This aligns with TCG's cmp_vec behavior by expanding compare results to
> full element width: all 1s for true, all 0s for false.
> 
> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>   tcg/riscv/tcg-target-con-set.h |   2 +
>   tcg/riscv/tcg-target-con-str.h |   1 +
>   tcg/riscv/tcg-target.c.inc     | 188 +++++++++++++++++++++++++++++++++
>   tcg/riscv/tcg-target.opc.h     |   3 +
>   4 files changed, 194 insertions(+)
> 
> diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
> index 8a0de18257..23b391dd07 100644
> --- a/tcg/riscv/tcg-target-con-set.h
> +++ b/tcg/riscv/tcg-target-con-set.h
> @@ -22,5 +22,7 @@ C_N1_I2(r, r, rM)
>   C_O1_I4(r, r, rI, rM, rM)
>   C_O2_I4(r, r, rZ, rZ, rM, rM)
>   C_O0_I2(v, r)
> +C_O0_I2(v, vK)
>   C_O1_I1(v, r)
>   C_O1_I2(v, v, v)
> +C_O1_I2(v, v, vK)
> diff --git a/tcg/riscv/tcg-target-con-str.h b/tcg/riscv/tcg-target-con-str.h
> index b2b3211bcb..0aaad7b753 100644
> --- a/tcg/riscv/tcg-target-con-str.h
> +++ b/tcg/riscv/tcg-target-con-str.h
> @@ -17,6 +17,7 @@ REGS('v', ALL_VECTOR_REGS)
>    */
>   CONST('I', TCG_CT_CONST_S12)
>   CONST('J', TCG_CT_CONST_J12)
> +CONST('K', TCG_CT_CONST_S5)
>   CONST('N', TCG_CT_CONST_N12)
>   CONST('M', TCG_CT_CONST_M12)
>   CONST('Z', TCG_CT_CONST_ZERO)
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index 650b5eff1a..3f1e215e90 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -113,6 +113,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
>   #define TCG_CT_CONST_N12   0x400
>   #define TCG_CT_CONST_M12   0x800
>   #define TCG_CT_CONST_J12  0x1000
> +#define TCG_CT_CONST_S5   0x2000
>   
>   #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
>   #define ALL_VECTOR_REGS    MAKE_64BIT_MASK(33, 31)
> @@ -160,6 +161,13 @@ static bool tcg_target_const_match(int64_t val, int ct,
>       if ((ct & TCG_CT_CONST_J12) && ~val >= -0x800 && ~val <= 0x7ff) {
>           return 1;
>       }
> +    /*
> +     * Sign extended from 5 bits: [-0x10, 0x0f].
> +     * Used for vector-immediate.
> +     */
> +    if ((ct & TCG_CT_CONST_S5) && val >= -0x10 && val <= 0x0f) {
> +        return 1;
> +    }
>       return 0;
>   }
>   
> @@ -289,12 +297,39 @@ typedef enum {
>       OPC_VSE32_V = 0x6027 | V_SUMOP,
>       OPC_VSE64_V = 0x7027 | V_SUMOP,
>   
> +    OPC_VMERGE_VIM = 0x5c000057 | V_OPIVI,
> +    OPC_VMERGE_VVM = 0x5c000057 | V_OPIVV,
> +    OPC_VMNAND_MM = 0x74000057 | V_OPMVV,
> +
>       OPC_VADD_VV = 0x57 | V_OPIVV,
>       OPC_VSUB_VV = 0x8000057 | V_OPIVV,
>       OPC_VAND_VV = 0x24000057 | V_OPIVV,
>       OPC_VOR_VV = 0x28000057 | V_OPIVV,
>       OPC_VXOR_VV = 0x2c000057 | V_OPIVV,
>   
> +    OPC_VMSEQ_VV = 0x60000057 | V_OPIVV,
> +    OPC_VMSEQ_VI = 0x60000057 | V_OPIVI,
> +    OPC_VMSEQ_VX = 0x60000057 | V_OPIVX,
> +    OPC_VMSNE_VV = 0x64000057 | V_OPIVV,
> +    OPC_VMSNE_VI = 0x64000057 | V_OPIVI,
> +    OPC_VMSNE_VX = 0x64000057 | V_OPIVX,
> +
> +    OPC_VMSLTU_VV = 0x68000057 | V_OPIVV,
> +    OPC_VMSLTU_VX = 0x68000057 | V_OPIVX,
> +    OPC_VMSLT_VV = 0x6c000057 | V_OPIVV,
> +    OPC_VMSLT_VX = 0x6c000057 | V_OPIVX,
> +    OPC_VMSLEU_VV = 0x70000057 | V_OPIVV,
> +    OPC_VMSLEU_VX = 0x70000057 | V_OPIVX,
> +    OPC_VMSLE_VV = 0x74000057 | V_OPIVV,
> +    OPC_VMSLE_VX = 0x74000057 | V_OPIVX,
> +
> +    OPC_VMSLEU_VI = 0x70000057 | V_OPIVI,
> +    OPC_VMSLE_VI = 0x74000057 | V_OPIVI,
> +    OPC_VMSGTU_VI = 0x78000057 | V_OPIVI,
> +    OPC_VMSGTU_VX = 0x78000057 | V_OPIVX,
> +    OPC_VMSGT_VI = 0x7c000057 | V_OPIVI,
> +    OPC_VMSGT_VX = 0x7c000057 | V_OPIVX,
> +
>       OPC_VMV_V_V = 0x5e000057 | V_OPIVV,
>       OPC_VMV_V_I = 0x5e000057 | V_OPIVI,
>       OPC_VMV_V_X = 0x5e000057 | V_OPIVX,
> @@ -575,6 +610,15 @@ static void tcg_out_opc_vec_config(TCGContext *s, RISCVInsn opc,
>   #define tcg_out_opc_vi(s, opc, vd, vs2, imm, vm) \
>       tcg_out_opc_reg_vec_i(s, opc, vd, imm, vs2, vm);
>   
> +#define tcg_out_opc_vim_mask(s, opc, vd, vs2, imm) \
> +    tcg_out_opc_reg_vec_i(s, opc, vd, imm, vs2, false);
> +
> +#define tcg_out_opc_vvm_mask(s, opc, vd, vs2, vs1) \
> +    tcg_out_opc_reg_vec(s, opc, vd, vs1, vs2, false);
> +
> +#define tcg_out_opc_mvv(s, opc, vd, vs2, vs1, vm) \
> +    tcg_out_opc_reg_vec(s, opc, vd, vs1, vs2, vm);
> +
>   #define tcg_out_opc_vconfig(s, opc, rd, avl, vtypei) \
>       tcg_out_opc_vec_config(s, opc, rd, avl, vtypei);
>   
> @@ -1037,6 +1081,22 @@ static const struct {
>       [TCG_COND_GTU] = { OPC_BLTU, true  }
>   };
>   
> +static const struct {
> +    RISCVInsn opc;
> +    bool swap;
> +} tcg_cmpcond_to_rvv_vv[] = {
> +    [TCG_COND_EQ] =  { OPC_VMSEQ_VV,  false },
> +    [TCG_COND_NE] =  { OPC_VMSNE_VV,  false },
> +    [TCG_COND_LT] =  { OPC_VMSLT_VV,  false },
> +    [TCG_COND_GE] =  { OPC_VMSLE_VV,  true  },
> +    [TCG_COND_GT] =  { OPC_VMSLT_VV,  true  },
> +    [TCG_COND_LE] =  { OPC_VMSLE_VV,  false },
> +    [TCG_COND_LTU] = { OPC_VMSLTU_VV, false },
> +    [TCG_COND_GEU] = { OPC_VMSLEU_VV, true  },
> +    [TCG_COND_GTU] = { OPC_VMSLTU_VV, true  },
> +    [TCG_COND_LEU] = { OPC_VMSLEU_VV, false }
> +};
> +
>   static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
>                              TCGReg arg2, TCGLabel *l)
>   {
> @@ -1054,6 +1114,79 @@ static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
>       tcg_out_opc_branch(s, op, arg1, arg2, 0);
>   }
>   
> +static const struct {
> +    RISCVInsn op;
> +    bool expand;

invert is probably a better name.
Why are these tables so far apart?

> +static void tcg_out_cmp_vec_vx(TCGContext *s, TCGCond cond, TCGReg arg1,
> +                               tcg_target_long arg2)
> +{
> +    RISCVInsn op;
> +
> +    tcg_debug_assert((unsigned)cond < ARRAY_SIZE(tcg_cmpcond_to_rvv_vx));
> +    op = tcg_cmpcond_to_rvv_vx[cond].op;
> +    tcg_debug_assert(op != 0);
> +
> +    tcg_out_opc_vx(s, op, TCG_REG_V0, arg1, arg2, true);
> +    if (tcg_cmpcond_to_rvv_vx[cond].expand) {
> +        tcg_out_opc_mvv(s, OPC_VMNAND_MM, TCG_REG_V0, TCG_REG_V0,
> +                        TCG_REG_V0, false);
> +    }
> +}

I think you'll be better served by handling the invert during expand, because you can 
always swap the sense of the predicate in the user.

Compare tcg/i386 expand_vec_cmp_noinv.

> +            tcg_gen_mov_vec(v0, tcg_constant_vec_matching(v0, vece, 0));

You don't need to copy to v0; just use the tcg_constant_vec directly as

> +            vec_gen_3(INDEX_op_rvv_merge_vec, type, vece,
> +                      tcgv_vec_arg(v0), tcgv_vec_arg(v0),
> +                      tcgv_i64_arg(tcg_constant_i64(-1)));

the first source operand.

You can swap 0 and -1 if the comparison instruction requires the predicate to be inverted.

r~

