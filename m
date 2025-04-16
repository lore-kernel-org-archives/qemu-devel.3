Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6488C369C5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u58bA-0002Nd-NY; Wed, 16 Apr 2025 15:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58az-0002Cn-P8
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:38:54 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58ax-0001D1-22
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:38:53 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22c3407a87aso667855ad.3
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744832329; x=1745437129; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5wPMv6No+gQ6oPJdkPrB6K14xLSmM+wk3RC/kUmr8K4=;
 b=laAeeTIjx4yfVL0x+TPiL1K8Ix5M9vZXOw1npLoFhay1l2uwkQ84LBMENq5cpr9dhT
 Nc7WR//iD6q4A+36ZOwic06s6pbDbt03SkxT6JDPkKzDQnspiFllmYRrN7Z9/UszUgUR
 VHAYfEccwKjEqLUwSg+5y8JK0wMBjgYjt5iKkeEoz+CdkzUmiGA5AX5gaidWkESzvEpW
 A2FYYA+hPaKMqN31x6/AcAzmFmYfqI0yAb+JBMDLleAXDbcKLdm8m6qgshZVxb8xZ4pE
 p0igEr2fVNLN29GYQbDRQMOhp/rM+j4Ak4WfOKqbYjBctC+bILhP4pp2otBtFqVNGVGN
 Xqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744832329; x=1745437129;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5wPMv6No+gQ6oPJdkPrB6K14xLSmM+wk3RC/kUmr8K4=;
 b=bS7FH23Wwf1zr+oZNtl/ilZY8nQV8CJk0CxNqRLFZVEyjXhQB00zKZVxqmWfQe6Po0
 D6UA8vqkzSC/JrjEPYubZqlziJdj0yqRRr6GKw2FqH7uHh0OwgIpTs+hHFtWLO93kuCV
 cca20+EjnOLETHnV4kNMY0BSTa5ETJqO5TNIl5cX4GkGyv92WMzedtyVxA0OzUf9q0UG
 aLtuj+Kvr6RDbL1gElA8+2dfoTwcL/SIKB/wwpAVPqePwjI5TVmeXqBADKytmf8Z7j/E
 39reQ3OAYi0DQo99jsb+uDfXhC9XNB/NCHhXixkUgZyriwDRPDOyckg3+GY9G60CGhsn
 of4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9rTOn6XuFVetUIGaa3jzstaxDoAyAI72cH0mVKE+jS5c7O+5dpIz7OfwLL+ebTCo9TJNO2+9MR4jl@nongnu.org
X-Gm-Message-State: AOJu0YzOpYNEoTZSG6U5qZaEpWIN3Ohz1I9SDF8eE/m+D+CoRBXBAC5+
 YOibojwI0AuXMOOy/I2mSWXpmEbxIgwjZHjB6lSvCC56k5eISr9ga0iqzwDtrLc=
X-Gm-Gg: ASbGncvZc4ltH5rZj8T/oZ+o9BbakZvXArMh+StpwrkLlfEh9Pm0k9LFqEvOBRodyy8
 ckhw4G3Ly1RVgcOdulU6BxKTPUImlX0lYK5tX3t3/xA5valFYiquRy+Lc26KuwP6aZnBc6iU9V7
 Oxt8ImQHDPeZtsLS7HudavftHehlYFTeKJSHz5wKLJbanet1ccQH5G1bBRIuFIiyyxZMppVXJRE
 vV9dygm3qhQ5sT1VA6dOQhh9ib34c8+7YqDu985mGDr/MDeE5DNcKbYjLJBNMaMWYSqb7Um4EJ7
 CiWhMJp4/uhDDvO9JNPzzdUzoygMzYvoyqI+9GGp1y79ARFTkNYzRFrzYsRQpnoC
X-Google-Smtp-Source: AGHT+IGsDAowFvlbKpIDm+NmxQsnmI51dgoJn2zAY2o/rjL4VEeDLbJmgdbxrsiZ8MUdbSolBLqWqw==
X-Received: by 2002:a17:902:fc86:b0:227:e74a:a05a with SMTP id
 d9443c01a7336-22c35986066mr55150465ad.44.1744832328801; 
 Wed, 16 Apr 2025 12:38:48 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33fa79cfsm18248985ad.122.2025.04.16.12.38.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 12:38:48 -0700 (PDT)
Message-ID: <e4fe8e52-8a05-4d25-81be-58aeb31b4aa1@linaro.org>
Date: Wed, 16 Apr 2025 12:38:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 151/163] tcg: Formalize tcg_out_br
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-152-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-152-richard.henderson@linaro.org>
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

On 4/15/25 12:25, Richard Henderson wrote:
> Split these functions out from tcg_out_op.
> Call it directly from tcg_gen_code.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c                        |  4 ++++
>   tcg/aarch64/tcg-target.c.inc     |  6 +-----
>   tcg/arm/tcg-target.c.inc         |  8 +++++---
>   tcg/i386/tcg-target.c.inc        |  8 +++++---
>   tcg/loongarch64/tcg-target.c.inc | 12 ++++++------
>   tcg/mips/tcg-target.c.inc        | 10 +++++-----
>   tcg/ppc/tcg-target.c.inc         | 26 ++++++++++++--------------
>   tcg/riscv/tcg-target.c.inc       | 11 ++++++-----
>   tcg/s390x/tcg-target.c.inc       |  9 +++++----
>   tcg/sparc64/tcg-target.c.inc     | 10 ++++++----
>   tcg/tci/tcg-target.c.inc         |  9 +++++----
>   11 files changed, 60 insertions(+), 53 deletions(-)
> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 4ffd4d203b..f19f3b6a8a 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -134,6 +134,7 @@ static bool tcg_out_xchg(TCGContext *s, TCGType type, TCGReg r1, TCGReg r2);
>   static void tcg_out_exit_tb(TCGContext *s, uintptr_t arg);
>   static void tcg_out_goto_tb(TCGContext *s, int which);
>   static void tcg_out_mb(TCGContext *s, unsigned bar);
> +static void tcg_out_br(TCGContext *s, TCGLabel *l);
>   static void tcg_out_set_carry(TCGContext *s);
>   static void tcg_out_set_borrow(TCGContext *s);
>   static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
> @@ -6895,6 +6896,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
>           case INDEX_op_goto_tb:
>               tcg_out_goto_tb(s, op->args[0]);
>               break;
> +        case INDEX_op_br:
> +            tcg_out_br(s, arg_label(op->args[0]));
> +            break;
>           case INDEX_op_mb:
>               tcg_out_mb(s, op->args[0]);
>               break;
> diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
> index d2babd9bab..fceb6e2796 100644
> --- a/tcg/aarch64/tcg-target.c.inc
> +++ b/tcg/aarch64/tcg-target.c.inc
> @@ -1407,7 +1407,7 @@ static void tcg_out_call(TCGContext *s, const tcg_insn_unit *target,
>       tcg_out_call_int(s, target);
>   }
>   
> -static inline void tcg_out_goto_label(TCGContext *s, TCGLabel *l)
> +static void tcg_out_br(TCGContext *s, TCGLabel *l)
>   {
>       if (!l->has_value) {
>           tcg_out_reloc(s, s->code_ptr, R_AARCH64_JUMP26, l, 0);
> @@ -2779,10 +2779,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
>           tcg_out_insn(s, 3207, BR, a0);
>           break;
>   
> -    case INDEX_op_br:
> -        tcg_out_goto_label(s, arg_label(a0));
> -        break;
> -
>       case INDEX_op_ld8u_i32:
>       case INDEX_op_ld8u_i64:
>           tcg_out_ldst(s, I3312_LDRB, a0, a1, a2, 0);
> diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
> index 131901dabc..327b01d377 100644
> --- a/tcg/arm/tcg-target.c.inc
> +++ b/tcg/arm/tcg-target.c.inc
> @@ -1203,6 +1203,11 @@ static void tcg_out_goto_label(TCGContext *s, ARMCond cond, TCGLabel *l)
>       }
>   }
>   
> +static void tcg_out_br(TCGContext *s, TCGLabel *l)
> +{
> +    tcg_out_goto_label(s, COND_AL, l);
> +}
> +
>   static void tcg_out_mb(TCGContext *s, unsigned a0)
>   {
>       if (use_armv7_instructions) {
> @@ -2522,9 +2527,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       case INDEX_op_goto_ptr:
>           tcg_out_b_reg(s, COND_AL, args[0]);
>           break;
> -    case INDEX_op_br:
> -        tcg_out_goto_label(s, COND_AL, arg_label(args[0]));
> -        break;
>   
>       case INDEX_op_ld8u_i32:
>           tcg_out_ld8u(s, COND_AL, args[0], args[1], args[2]);
> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index bf84f9f455..f89982378b 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc
> @@ -1546,6 +1546,11 @@ static void tcg_out_jxx(TCGContext *s, int opc, TCGLabel *l, bool small)
>       }
>   }
>   
> +static void tcg_out_br(TCGContext *s, TCGLabel *l)
> +{
> +    tcg_out_jxx(s, JCC_JMP, l, 0);
> +}
> +
>   static int tcg_out_cmp(TCGContext *s, TCGCond cond, TCGArg arg1,
>                          TCGArg arg2, int const_arg2, int rexw)
>   {
> @@ -3436,9 +3441,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           /* jmp to the given host address (could be epilogue) */
>           tcg_out_modrm(s, OPC_GRP5, EXT5_JMPN_Ev, a0);
>           break;
> -    case INDEX_op_br:
> -        tcg_out_jxx(s, JCC_JMP, arg_label(a0), 0);
> -        break;
>       OP_32_64(ld8u):
>           /* Note that we can ignore REXW for the zero-extend to 64-bit.  */
>           tcg_out_modrm_offset(s, OPC_MOVZBL, a0, a1, a2);
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index b9b05b8c25..78d1542153 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -744,6 +744,12 @@ static const TCGOutOpMovcond outop_movcond = {
>    * Branch helpers
>    */
>   
> +static void tcg_out_br(TCGContext *s, TCGLabel *l)
> +{
> +    tcg_out_reloc(s, s->code_ptr, R_LOONGARCH_BR_SD10K16, l, 0);
> +    tcg_out_opc_b(s, 0);
> +}
> +
>   static const struct {
>       LoongArchInsn op;
>       bool swap;
> @@ -1909,12 +1915,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_opc_jirl(s, TCG_REG_ZERO, a0, 0);
>           break;
>   
> -    case INDEX_op_br:
> -        tcg_out_reloc(s, s->code_ptr, R_LOONGARCH_BR_SD10K16, arg_label(a0),
> -                      0);
> -        tcg_out_opc_b(s, 0);
> -        break;
> -
>       case INDEX_op_ld8s_i32:
>       case INDEX_op_ld8s_i64:
>           tcg_out_ldst(s, OPC_LD_B, a0, a1, a2);
> diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
> index b0da661561..f4d6ee10b9 100644
> --- a/tcg/mips/tcg-target.c.inc
> +++ b/tcg/mips/tcg-target.c.inc
> @@ -921,6 +921,11 @@ static const TCGOutOpBrcond outop_brcond = {
>       .out_rr = tgen_brcond,
>   };
>   
> +void tcg_out_br(TCGContext *s, TCGLabel *l)
> +{
> +    tgen_brcond(s, TCG_TYPE_I32, TCG_COND_EQ, TCG_REG_ZERO, TCG_REG_ZERO, l);
> +}
> +
>   static int tcg_out_setcond2_int(TCGContext *s, TCGCond cond, TCGReg ret,
>                                   TCGReg al, TCGReg ah, TCGReg bl, TCGReg bh)
>   {
> @@ -2281,11 +2286,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>               tcg_out_nop(s);
>           }
>           break;
> -    case INDEX_op_br:
> -        tgen_brcond(s, TCG_TYPE_I32, TCG_COND_EQ,
> -                    TCG_REG_ZERO, TCG_REG_ZERO, arg_label(a0));
> -        break;
> -
>       case INDEX_op_ld8u_i32:
>       case INDEX_op_ld8u_i64:
>           i1 = OPC_LBU;
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index ae18c84ae6..d88ec8d690 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -1990,6 +1990,18 @@ static const TCGOutOpSetcond outop_negsetcond = {
>       .out_rri = tgen_negsetcondi,
>   };
>   
> +void tcg_out_br(TCGContext *s, TCGLabel *l)
> +{
> +    uint32_t insn = B;
> +
> +    if (l->has_value) {
> +        insn |= reloc_pc24_val(tcg_splitwx_to_rx(s->code_ptr), l->u.value_ptr);
> +    } else {
> +        tcg_out_reloc(s, s->code_ptr, R_PPC_REL24, l, 0);
> +    }
> +    tcg_out32(s, insn);
> +}
> +
>   static void tcg_out_bc(TCGContext *s, TCGCond cond, int bd)
>   {
>       tcg_out32(s, tcg_to_bc[cond] | bd);
> @@ -3669,20 +3681,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out32(s, ADDI | TAI(TCG_REG_R3, 0, 0));
>           tcg_out32(s, BCCTR | BO_ALWAYS);
>           break;
> -    case INDEX_op_br:
> -        {
> -            TCGLabel *l = arg_label(args[0]);
> -            uint32_t insn = B;
> -
> -            if (l->has_value) {
> -                insn |= reloc_pc24_val(tcg_splitwx_to_rx(s->code_ptr),
> -                                       l->u.value_ptr);
> -            } else {
> -                tcg_out_reloc(s, s->code_ptr, R_PPC_REL24, l, 0);
> -            }
> -            tcg_out32(s, insn);
> -        }
> -        break;
>       case INDEX_op_ld8u_i32:
>       case INDEX_op_ld8u_i64:
>           tcg_out_mem_long(s, LBZ, LBZX, args[0], args[1], args[2]);
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index df271752b7..5d8d8213cb 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -1107,6 +1107,12 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
>       tcg_out_dup_vec(s, type, vece, dst, TCG_REG_TMP0);
>   }
>   
> +static void tcg_out_br(TCGContext *s, TCGLabel *l)
> +{
> +    tcg_out_reloc(s, s->code_ptr, R_RISCV_JAL, l, 0);
> +    tcg_out_opc_jump(s, OPC_JAL, TCG_REG_ZERO, 0);
> +}
> +
>   static const struct {
>       RISCVInsn op;
>       bool swap;
> @@ -2533,11 +2539,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_opc_imm(s, OPC_JALR, TCG_REG_ZERO, a0, 0);
>           break;
>   
> -    case INDEX_op_br:
> -        tcg_out_reloc(s, s->code_ptr, R_RISCV_JAL, arg_label(a0), 0);
> -        tcg_out_opc_jump(s, OPC_JAL, TCG_REG_ZERO, 0);
> -        break;
> -
>       case INDEX_op_ld8u_i32:
>       case INDEX_op_ld8u_i64:
>           tcg_out_ldst(s, OPC_LBU, a0, a1, a2);
> diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
> index 020d8ba73f..cdc61de4f8 100644
> --- a/tcg/s390x/tcg-target.c.inc
> +++ b/tcg/s390x/tcg-target.c.inc
> @@ -1689,6 +1689,11 @@ static void tgen_branch(TCGContext *s, int cc, TCGLabel *l)
>       }
>   }
>   
> +static void tcg_out_br(TCGContext *s, TCGLabel *l)
> +{
> +    tgen_branch(s, S390_CC_ALWAYS, l);
> +}
> +
>   static void tgen_compare_branch(TCGContext *s, S390Opcode opc, int cc,
>                                   TCGReg r1, TCGReg r2, TCGLabel *l)
>   {
> @@ -3075,10 +3080,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_st(s, TCG_TYPE_I32, args[0], args[1], args[2]);
>           break;
>   
> -    case INDEX_op_br:
> -        tgen_branch(s, S390_CC_ALWAYS, arg_label(args[0]));
> -        break;
> -
>       case INDEX_op_qemu_ld_i32:
>           tcg_out_qemu_ld(s, args[0], args[1], args[2], TCG_TYPE_I32);
>           break;
> diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
> index 56b68fe841..e4073b7732 100644
> --- a/tcg/sparc64/tcg-target.c.inc
> +++ b/tcg/sparc64/tcg-target.c.inc
> @@ -641,6 +641,12 @@ static void tcg_out_bpcc(TCGContext *s, int scond, int flags, TCGLabel *l)
>       tcg_out_bpcc0(s, scond, flags, off19);
>   }
>   
> +static void tcg_out_br(TCGContext *s, TCGLabel *l)
> +{
> +    tcg_out_bpcc(s, COND_A, BPCC_PT, l);
> +    tcg_out_nop(s);
> +}
> +
>   static void tcg_out_cmp(TCGContext *s, TCGCond cond,
>                           TCGReg c1, int32_t c2, int c2const)
>   {
> @@ -1961,10 +1967,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_arithi(s, TCG_REG_G0, a0, 0, JMPL);
>           tcg_out_mov_delay(s, TCG_REG_TB, a0);
>           break;
> -    case INDEX_op_br:
> -        tcg_out_bpcc(s, COND_A, BPCC_PT, arg_label(a0));
> -        tcg_out_nop(s);
> -        break;
>   
>   #define OP_32_64(x)                             \
>           glue(glue(case INDEX_op_, x), _i32):    \
> diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
> index 64d4ac07cd..55a1a74fb6 100644
> --- a/tcg/tci/tcg-target.c.inc
> +++ b/tcg/tci/tcg-target.c.inc
> @@ -1136,6 +1136,11 @@ static void tcg_out_mb(TCGContext *s, unsigned a0)
>       tcg_out_op_v(s, INDEX_op_mb);
>   }
>   
> +static void tcg_out_br(TCGContext *s, TCGLabel *l)
> +{
> +    tcg_out_op_l(s, INDEX_op_br, l);
> +}
> +
>   static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const TCGArg args[TCG_MAX_OP_ARGS],
>                          const int const_args[TCG_MAX_OP_ARGS])
> @@ -1145,10 +1150,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_op_r(s, opc, args[0]);
>           break;
>   
> -    case INDEX_op_br:
> -        tcg_out_op_l(s, opc, arg_label(args[0]));
> -        break;
> -
>       CASE_32_64(ld8u)
>       CASE_32_64(ld8s)
>       CASE_32_64(ld16u)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


