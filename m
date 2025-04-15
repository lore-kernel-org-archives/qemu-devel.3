Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E89FC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 22:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4oQD-0005bE-F1; Tue, 15 Apr 2025 18:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4oPc-0005Ka-RP
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 18:05:54 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4oPP-0001Dl-GN
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 18:05:44 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so83153855ad.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 15:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744754716; x=1745359516; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KyaLOUwf2wILrxdve4Ko09ZyUkwcDk+Hm67E+7VBZas=;
 b=xzhRaH/z/hchpYcy9GJqTRmmLNILwEVO7f2S59LuJXG3+qjvrdjYaNVEzsxeaSIRly
 MxnA2l7gRfvZY7/rjUF65Vcvk16p/DIzu/g4f+mzC/oD3gZ2zrPVHQ+QT0xlRcm8dbdl
 36iL5wWqmYyqvycOsOX0et00JUMsML3o0m6QGFe/WaF/nOLXwUNfd76fpq9iKjbARgao
 WwyJV0jpSQbk+uLImLXTR2aqg7Y3teEl78IPbC7FjQXhLEgtmQAgCk5w9NMPGLapLgDx
 bPMfoy7uPjONArAuwg2OjeH5yqFsQdE2USHZXXt6hlgqXsem+NV9Llhzc8pz9GsyMoIL
 EtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744754716; x=1745359516;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KyaLOUwf2wILrxdve4Ko09ZyUkwcDk+Hm67E+7VBZas=;
 b=Uo1dKA3/dqyMIgEcuy8ezcNMk2rRuuUhOgzIH2bm3PKiH9wb+eAZFNLabR0xYJ+UY/
 yxFI2BuZDAAKhSgNDpTY2cSwM/cAYRmC4tcrAEosJoFjgcpCbZwqmj5CBsXO6+ptzxcq
 d5/St9SYP6m6rV/FKBoDZD2wZ/gIn+h0fMI5vYjQzdmOglVTF8mzOEhtuFqxb7gvsd5n
 wL0Cixqv0wBIQbOHaADrpxNrjyfPgscUft+7NP9QdPEWElEnUKQIKGiXM1JPB8GuQHnz
 wnbpS4ngkd158BIrnv4AXFp6q+LtCD9ItEuT2eDO1YDXLpcm/k200sY0hzugmy9OsR38
 zC4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU59JSUJ0WDIWanwDZ4XdsUW+Mkdzpi7Yf7nZN1gVXOXP0/5VIIUZJNVAOxLIw94daRzOeJHK2gYnIE@nongnu.org
X-Gm-Message-State: AOJu0YxJ3FMG9k69pOyeuQxdtdoBAmJarCOl5680xuAJGeitCUUKPQv4
 VeAytg76bvFg7p1PGWcIV9gY2hKkYsY1KVqwMTeeNGPhI0GBDSW5/oGIlz12TT7df+9Cr+8b9bn
 fnYY=
X-Gm-Gg: ASbGncvzcZ4sVu6Ijqkjkv6vcPaAjENUm5sOKj9N806P6/mrS6VWVmAYbAbP9MlC4Wo
 YW0GfnpwwRdiKbFKemF8eIdQbof2idzvlmSpqiav6JakPsucKtHe1LHOXRgjYCrvuak9sr+/Mf7
 uq/i61t6Fj8b2eyjM/qaskXNhIHaHBRjG1UaKac/c7ApMW+FZuNO74W2Vkb622bnZ1PLL9X+k5b
 PI+r4WCTE2J7CpWo8YVKgO3HgqmtaK/IINZTf78WpCeSvFVcW35yWFvqpnb/s1u6FmgrsrH6zyY
 EraQ574C8WBvQUAIjkhz21+LbZcgkxxPE+pctAihnt0HeRHZJecbtq1Ya77uXD2r
X-Google-Smtp-Source: AGHT+IGSn/O7P0//5vLzsuHnyM9eLPbNiosvj5oG53CgEW4yvkijkAz74QjH9l7wnZTHLGYagva01Q==
X-Received: by 2002:a17:903:1103:b0:223:619e:71da with SMTP id
 d9443c01a7336-22c31ac4762mr10738635ad.49.1744754715983; 
 Tue, 15 Apr 2025 15:05:15 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33f1d086sm324415ad.78.2025.04.15.15.05.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 15:05:15 -0700 (PDT)
Message-ID: <7c11ff66-18cb-4760-96e1-3be43e7e8567@linaro.org>
Date: Tue, 15 Apr 2025 15:05:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 110/163] tcg/riscv: Drop support for add2/sub2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-111-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-111-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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
> We now produce exactly the same code via generic expansion.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/riscv/tcg-target-con-set.h |  1 -
>   tcg/riscv/tcg-target-has.h     |  6 +--
>   tcg/riscv/tcg-target.c.inc     | 86 +---------------------------------
>   3 files changed, 3 insertions(+), 90 deletions(-)
> 
> diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
> index 5ff2c2db60..0fc26d3f98 100644
> --- a/tcg/riscv/tcg-target-con-set.h
> +++ b/tcg/riscv/tcg-target-con-set.h
> @@ -18,7 +18,6 @@ C_O1_I2(r, r, ri)
>   C_O1_I2(r, r, rI)
>   C_N1_I2(r, r, rM)
>   C_O1_I4(r, r, rI, rM, rM)
> -C_O2_I4(r, r, rz, rz, rM, rM)
>   C_O0_I2(v, r)
>   C_O1_I1(v, r)
>   C_O1_I1(v, v)
> diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
> index b2814f8ef9..c95dc1921e 100644
> --- a/tcg/riscv/tcg-target-has.h
> +++ b/tcg/riscv/tcg-target-has.h
> @@ -10,13 +10,11 @@
>   #include "host/cpuinfo.h"
>   
>   /* optional instructions */
> -#define TCG_TARGET_HAS_add2_i32         1
> -#define TCG_TARGET_HAS_sub2_i32         1
>   #define TCG_TARGET_HAS_qemu_st8_i32     0
>   
>   #define TCG_TARGET_HAS_extr_i64_i32     1
> -#define TCG_TARGET_HAS_add2_i64         1
> -#define TCG_TARGET_HAS_sub2_i64         1
> +#define TCG_TARGET_HAS_add2_i64         0
> +#define TCG_TARGET_HAS_sub2_i64         0
>   
>   #define TCG_TARGET_HAS_qemu_ldst_i128   0
>   
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index d74ac7587a..dce46dcba6 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -401,7 +401,7 @@ static bool tcg_target_const_match(int64_t val, int ct,
>       }
>       /*
>        * Sign extended from 12 bits, +/- matching: [-0x7ff, 0x7ff].
> -     * Used by addsub2 and movcond, which may need the negative value,
> +     * Used by movcond, which may need the negative value,
>        * and requires the modified constant to be representable.
>        */
>       if ((ct & TCG_CT_CONST_M12) && val >= -0x7ff && val <= 0x7ff) {
> @@ -1073,67 +1073,6 @@ static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
>       return false;
>   }
>   
> -static void tcg_out_addsub2(TCGContext *s,
> -                            TCGReg rl, TCGReg rh,
> -                            TCGReg al, TCGReg ah,
> -                            TCGArg bl, TCGArg bh,
> -                            bool cbl, bool cbh, bool is_sub, bool is32bit)
> -{
> -    const RISCVInsn opc_add = is32bit ? OPC_ADDW : OPC_ADD;
> -    const RISCVInsn opc_addi = is32bit ? OPC_ADDIW : OPC_ADDI;
> -    const RISCVInsn opc_sub = is32bit ? OPC_SUBW : OPC_SUB;
> -    TCGReg th = TCG_REG_TMP1;
> -
> -    /* If we have a negative constant such that negating it would
> -       make the high part zero, we can (usually) eliminate one insn.  */
> -    if (cbl && cbh && bh == -1 && bl != 0) {
> -        bl = -bl;
> -        bh = 0;
> -        is_sub = !is_sub;
> -    }
> -
> -    /* By operating on the high part first, we get to use the final
> -       carry operation to move back from the temporary.  */
> -    if (!cbh) {
> -        tcg_out_opc_reg(s, (is_sub ? opc_sub : opc_add), th, ah, bh);
> -    } else if (bh != 0 || ah == rl) {
> -        tcg_out_opc_imm(s, opc_addi, th, ah, (is_sub ? -bh : bh));
> -    } else {
> -        th = ah;
> -    }
> -
> -    /* Note that tcg optimization should eliminate the bl == 0 case.  */
> -    if (is_sub) {
> -        if (cbl) {
> -            tcg_out_opc_imm(s, OPC_SLTIU, TCG_REG_TMP0, al, bl);
> -            tcg_out_opc_imm(s, opc_addi, rl, al, -bl);
> -        } else {
> -            tcg_out_opc_reg(s, OPC_SLTU, TCG_REG_TMP0, al, bl);
> -            tcg_out_opc_reg(s, opc_sub, rl, al, bl);
> -        }
> -        tcg_out_opc_reg(s, opc_sub, rh, th, TCG_REG_TMP0);
> -    } else {
> -        if (cbl) {
> -            tcg_out_opc_imm(s, opc_addi, rl, al, bl);
> -            tcg_out_opc_imm(s, OPC_SLTIU, TCG_REG_TMP0, rl, bl);
> -        } else if (al == bl) {
> -            /*
> -             * If the input regs overlap, this is a simple doubling
> -             * and carry-out is the input msb.  This special case is
> -             * required when the output reg overlaps the input,
> -             * but we might as well use it always.
> -             */
> -            tcg_out_opc_imm(s, OPC_SLTI, TCG_REG_TMP0, al, 0);
> -            tcg_out_opc_reg(s, opc_add, rl, al, al);
> -        } else {
> -            tcg_out_opc_reg(s, opc_add, rl, al, bl);
> -            tcg_out_opc_reg(s, OPC_SLTU, TCG_REG_TMP0,
> -                            rl, (rl == bl ? al : bl));
> -        }
> -        tcg_out_opc_reg(s, opc_add, rh, th, TCG_REG_TMP0);
> -    }
> -}
> -
>   static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
>                                      TCGReg dst, TCGReg src)
>   {
> @@ -2608,23 +2547,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_ldst(s, OPC_SD, a0, a1, a2);
>           break;
>   
> -    case INDEX_op_add2_i32:
> -        tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
> -                        const_args[4], const_args[5], false, true);
> -        break;
> -    case INDEX_op_add2_i64:
> -        tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
> -                        const_args[4], const_args[5], false, false);
> -        break;
> -    case INDEX_op_sub2_i32:
> -        tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
> -                        const_args[4], const_args[5], true, true);
> -        break;
> -    case INDEX_op_sub2_i64:
> -        tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
> -                        const_args[4], const_args[5], true, false);
> -        break;
> -
>       case INDEX_op_qemu_ld_i32:
>           tcg_out_qemu_ld(s, a0, a1, a2, TCG_TYPE_I32);
>           break;
> @@ -2897,12 +2819,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_st_i64:
>           return C_O0_I2(rz, r);
>   
> -    case INDEX_op_add2_i32:
> -    case INDEX_op_add2_i64:
> -    case INDEX_op_sub2_i32:
> -    case INDEX_op_sub2_i64:
> -        return C_O2_I4(r, r, rz, rz, rM, rM);
> -
>       case INDEX_op_qemu_ld_i32:
>       case INDEX_op_qemu_ld_i64:
>           return C_O1_I1(r, r);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


