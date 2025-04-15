Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D11C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 22:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4oOj-0004O3-2Z; Tue, 15 Apr 2025 18:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4oOg-0004Jy-F6
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 18:04:51 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4oOX-0000jc-7h
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 18:04:50 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso7560042b3a.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 15:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744754680; x=1745359480; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2thCv64WWt7Asg8pQJEfmJpxH6K1EskiK7GnXosfeUU=;
 b=eX2A7ot57EtJW3RhaD903IF/eKSQ7ANQdq0e3Nq0ojzcX9u9dFye+H8j0EpC2ETgwX
 ySYXmxhLdrqBBgDCL3o9Ahsg/XwfMSf9KKGWy64FT0zJBM2+ZWytC9ugXH6oJ4vDmjzL
 uTAqSZB0+1m5dls4yUn1jsejOWWrSoCU/SyeWVHfD1Xh1RDa12jRXRVXKj+FqMZCpBif
 6pmrdpSofRgGdC70rZHGoqAJdJ8YorG9mrT0tjQFz2kSvRAhH1jDluwKCJUGGRsMpuf+
 kL/GClnrvXWHYBBTeRe/gV3S1swOFf/DSLIrrVCWfFiBYqvPW9mZ5wK/y5WEqYYSAzO2
 oNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744754680; x=1745359480;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2thCv64WWt7Asg8pQJEfmJpxH6K1EskiK7GnXosfeUU=;
 b=FBVLppVjM10TjOdG3aJip6qI622INhcYaZFZVIlhAY0Wp0eCldpA+AlVOYwHnCvmvj
 gCWKEIbc48FIM0ise9XIbLk3jupmsElAm9xHSkQbUf5pE6MLGNkD+1EQVSN8Z5+4Pybu
 gG0sofk6mvQOr1L36ckhqcM5jkKRATI7xJ56BN3yQrdgDw0OQNtBT7Usz7pDRWHS0hsy
 y6IK35z6VtppYaoNBlYglnucvlb//dN5rfDo7BGoomi7Goufi8pPsPzbZClhiHgeA2lJ
 h8q3JZSPLttY+fBlEMq6IGnPF+dwfXYAoZWFXpy1lFtGgnjElYoMVUVRhsmcODvzWI1y
 787A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXe9dOih/ooBOh3XNSkM5irMdEx/zJx3iEX2KqXLRUD/sLwSQwAyiP1EotkSdvUQtFHDffGuBiNJ76X@nongnu.org
X-Gm-Message-State: AOJu0Yykm3MP/pvbJvqTxVdLb7VFiQSO+ja2APeIZ9Y+lO4JkApawDsg
 /GbTwn3qRRW/y76r21bWcu/yvV8wQvUgyKx3UKJgqipzKI8dM6Rz4w6FzpwlWZQ=
X-Gm-Gg: ASbGncuprtrsH8DuL1rsz6MEPHEYO8J4w0eA8lNwtamKw3eQDgargDxJlqTqKTo1nal
 V6VCBdD9jkURvz/Fn2FGAYa+DG5m5abZzRQSS4m+WGTEoSub5+ludZysU7FXsdP+HTo8U5ST1eg
 HbSZQo5LFiwu9DL2Ehg+wIB9OKL8/oT6dhT4qQB5LJLb9c/AKfQHjos8hublPGHE+pnpcy2q7UR
 LWWQagLkpb3C9M7aYnu8nShakr5taJJ+wFuEKL2XMD00e20v9ImrA21W93mnbD6rri5GwzYd66p
 zk00uQX6HeLSZA2ZgpT6YSDmurmAUtcsjT0kKO8ck4yWb3Ru8imBNw==
X-Google-Smtp-Source: AGHT+IF3U/rcc2p3koCcLwgKCaDWfeeSA1VzvZU5oO5fQGQLx3S6q275+QqNraDH3yVN2mh9UBM6cw==
X-Received: by 2002:a05:6a21:1584:b0:1f5:902e:1e8c with SMTP id
 adf61e73a8af0-203ae07eebbmr882778637.42.1744754679660; 
 Tue, 15 Apr 2025 15:04:39 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f0f28sm9444343b3a.97.2025.04.15.15.04.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 15:04:39 -0700 (PDT)
Message-ID: <ec6d2dcd-d758-4ea2-ac69-a211d369529e@linaro.org>
Date: Tue, 15 Apr 2025 15:04:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 109/163] tcg/mips: Drop support for add2/sub2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-110-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-110-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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
>   tcg/mips/tcg-target-con-set.h |  1 -
>   tcg/mips/tcg-target-con-str.h |  1 -
>   tcg/mips/tcg-target-has.h     |  7 ++--
>   tcg/mips/tcg-target.c.inc     | 67 +----------------------------------
>   4 files changed, 3 insertions(+), 73 deletions(-)
> 
> diff --git a/tcg/mips/tcg-target-con-set.h b/tcg/mips/tcg-target-con-set.h
> index 4e09c9a400..5304691dc1 100644
> --- a/tcg/mips/tcg-target-con-set.h
> +++ b/tcg/mips/tcg-target-con-set.h
> @@ -28,4 +28,3 @@ C_O1_I4(r, r, rz, rz, rz)
>   C_O1_I4(r, r, r, rz, rz)
>   C_O2_I1(r, r, r)
>   C_O2_I2(r, r, r, r)
> -C_O2_I4(r, r, rz, rz, rN, rN)
> diff --git a/tcg/mips/tcg-target-con-str.h b/tcg/mips/tcg-target-con-str.h
> index dfe2b156df..db2b225e4a 100644
> --- a/tcg/mips/tcg-target-con-str.h
> +++ b/tcg/mips/tcg-target-con-str.h
> @@ -17,5 +17,4 @@ REGS('r', ALL_GENERAL_REGS)
>   CONST('I', TCG_CT_CONST_U16)
>   CONST('J', TCG_CT_CONST_S16)
>   CONST('K', TCG_CT_CONST_P2M1)
> -CONST('N', TCG_CT_CONST_N16)
>   CONST('W', TCG_CT_CONST_WSZ)
> diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
> index 9f6fa194b9..9d86906bf3 100644
> --- a/tcg/mips/tcg-target-has.h
> +++ b/tcg/mips/tcg-target-has.h
> @@ -39,18 +39,15 @@ extern bool use_mips32r2_instructions;
>   #endif
>   
>   /* optional instructions */
> -
> -#if TCG_TARGET_REG_BITS == 64
>   #define TCG_TARGET_HAS_add2_i32         0
>   #define TCG_TARGET_HAS_sub2_i32         0
> +
> +#if TCG_TARGET_REG_BITS == 64
>   #define TCG_TARGET_HAS_extr_i64_i32     1
>   #define TCG_TARGET_HAS_add2_i64         0
>   #define TCG_TARGET_HAS_sub2_i64         0
>   #define TCG_TARGET_HAS_ext32s_i64       1
>   #define TCG_TARGET_HAS_ext32u_i64       1
> -#else
> -#define TCG_TARGET_HAS_add2_i32         1
> -#define TCG_TARGET_HAS_sub2_i32         1
>   #endif
>   
>   /* optional instructions detected at runtime */
> diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
> index 7fae1c51e9..e69781b871 100644
> --- a/tcg/mips/tcg-target.c.inc
> +++ b/tcg/mips/tcg-target.c.inc
> @@ -187,8 +187,7 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
>   #define TCG_CT_CONST_U16  0x100    /* Unsigned 16-bit: 0 - 0xffff.  */
>   #define TCG_CT_CONST_S16  0x200    /* Signed 16-bit: -32768 - 32767 */
>   #define TCG_CT_CONST_P2M1 0x400    /* Power of 2 minus 1.  */
> -#define TCG_CT_CONST_N16  0x800    /* "Negatable" 16-bit: -32767 - 32767 */
> -#define TCG_CT_CONST_WSZ  0x1000   /* word size */
> +#define TCG_CT_CONST_WSZ  0x800    /* word size */
>   
>   #define ALL_GENERAL_REGS  0xffffffffu
>   
> @@ -207,8 +206,6 @@ static bool tcg_target_const_match(int64_t val, int ct,
>           return 1;
>       } else if ((ct & TCG_CT_CONST_S16) && val == (int16_t)val) {
>           return 1;
> -    } else if ((ct & TCG_CT_CONST_N16) && val >= -32767 && val <= 32767) {
> -        return 1;
>       } else if ((ct & TCG_CT_CONST_P2M1)
>                  && use_mips32r2_instructions && is_p2m1(val)) {
>           return 1;
> @@ -765,55 +762,6 @@ static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
>       return false;
>   }
>   
> -static void tcg_out_addsub2(TCGContext *s, TCGReg rl, TCGReg rh, TCGReg al,
> -                            TCGReg ah, TCGArg bl, TCGArg bh, bool cbl,
> -                            bool cbh, bool is_sub)
> -{
> -    TCGReg th = TCG_TMP1;
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
> -        tcg_out_opc_reg(s, (is_sub ? OPC_SUBU : OPC_ADDU), th, ah, bh);
> -    } else if (bh != 0 || ah == rl) {
> -        tcg_out_opc_imm(s, OPC_ADDIU, th, ah, (is_sub ? -bh : bh));
> -    } else {
> -        th = ah;
> -    }
> -
> -    /* Note that tcg optimization should eliminate the bl == 0 case.  */
> -    if (is_sub) {
> -        if (cbl) {
> -            tcg_out_opc_imm(s, OPC_SLTIU, TCG_TMP0, al, bl);
> -            tcg_out_opc_imm(s, OPC_ADDIU, rl, al, -bl);
> -        } else {
> -            tcg_out_opc_reg(s, OPC_SLTU, TCG_TMP0, al, bl);
> -            tcg_out_opc_reg(s, OPC_SUBU, rl, al, bl);
> -        }
> -        tcg_out_opc_reg(s, OPC_SUBU, rh, th, TCG_TMP0);
> -    } else {
> -        if (cbl) {
> -            tcg_out_opc_imm(s, OPC_ADDIU, rl, al, bl);
> -            tcg_out_opc_imm(s, OPC_SLTIU, TCG_TMP0, rl, bl);
> -        } else if (rl == al && rl == bl) {
> -            tcg_out_opc_sa(s, OPC_SRL, TCG_TMP0, al, TCG_TARGET_REG_BITS - 1);
> -            tcg_out_opc_reg(s, OPC_ADDU, rl, al, bl);
> -        } else {
> -            tcg_out_opc_reg(s, OPC_ADDU, rl, al, bl);
> -            tcg_out_opc_reg(s, OPC_SLTU, TCG_TMP0, rl, (rl == bl ? al : bl));
> -        }
> -        tcg_out_opc_reg(s, OPC_ADDU, rh, th, TCG_TMP0);
> -    }
> -}
> -
>   #define SETCOND_INV    TCG_TARGET_NB_REGS
>   #define SETCOND_NEZ    (SETCOND_INV << 1)
>   #define SETCOND_FLAGS  (SETCOND_INV | SETCOND_NEZ)
> @@ -2370,15 +2318,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           }
>           break;
>   
> -    case INDEX_op_add2_i32:
> -        tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
> -                        const_args[4], const_args[5], false);
> -        break;
> -    case INDEX_op_sub2_i32:
> -        tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
> -                        const_args[4], const_args[5], true);
> -        break;
> -
>       case INDEX_op_mb:
>           tcg_out_mb(s, a0);
>           break;
> @@ -2420,10 +2359,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_st_i64:
>           return C_O0_I2(rz, r);
>   
> -    case INDEX_op_add2_i32:
> -    case INDEX_op_sub2_i32:
> -        return C_O2_I4(r, r, rz, rz, rN, rN);
> -
>       case INDEX_op_qemu_ld_i32:
>           return C_O1_I1(r, r);
>       case INDEX_op_qemu_st_i32:

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


