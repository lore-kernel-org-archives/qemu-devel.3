Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473EDC021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 23:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlFdt-0007Fp-8Q; Thu, 20 Feb 2025 18:07:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlFdr-0007FO-NF
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 18:07:39 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlFdp-0001Pf-FB
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 18:07:39 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4399ee18a57so9288515e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 15:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740092856; x=1740697656; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r3qv3CKweXgrngDWBpFnI9e7raxkXKf3lCNstXdfurA=;
 b=n16eRCgwQFOirc0FAPPb+dt8T8xBd7tYbEUY9MwUVpsVqUUmIjPZ0rGXnhsSg41w/z
 u+A8g+WyPHGGZM9IwxnWxsB5A7UT2727ulrUxwzPGl4LKf0eDf/RykHUyhh3XyHPMQQe
 SweJEZubMg86mx0nZ5j1SdE30sDcy+4yoXi11IarvU5IrhGDl//JRVyYWVQHcKkcbP6l
 4CRarvZCZ9jlLjGZ8IqavcmFfXLOkN2CNH7FyB+lc7G5v2SM3hNqSTP4gMLWL7ng9cHA
 LtFZ4nGgO20GM3eYCM/Bw4WGhX9z81xLy/v5eJnekO3AB2Y35e9HfPTcPExTdJsc4EsQ
 E7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740092856; x=1740697656;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r3qv3CKweXgrngDWBpFnI9e7raxkXKf3lCNstXdfurA=;
 b=nY9J/DgL/iz0PTe1k/7+MRZyVdApn7Kb6jHroaOyIrErHQlyw9FiIYH3r/DHftd8rV
 NUYKYm9cPXCjKC6i/RigrwdosgLSiJZJC+PYwbbJje2E2w8gV10qevk8FdKRYym1iBBA
 /xrGitPW5rgtxg+sJfeameorncXlA8/07kYbl5BF61X4/CFUsiAYINhxAYq4WdNg7AzV
 0kQKSMFTW89fgnxHMplRAAfuPZfUepmohRK7OySvpiBUa2iIeWu44n2XD4wW6Koc63CG
 gSG2Xz/1L5Uph9lGi6BnLIXveP5EQBkOFDbT+WunOLCaM63ZrS/Vpq3mmXiB3zcAB7zP
 QtxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1sPIS20ZqA7leioNyqbHAfdL5fjO796fjr8JpTGj5JWyKqXQe0+aFU8RiqNRDgr6Hsr7LemYZevyb@nongnu.org
X-Gm-Message-State: AOJu0YzKbk+FVRExBZ+x6nFms5AJpwPCu9cp2NB1qfu+l21xlYU1SJMH
 9WuQ4fCBPuqvxRB9yfNIrqJJqsnTNizs00LS2V3nxhnG5cb5+2Nbk5pDOZPjUyiGy7eral7mqEp
 uNX0=
X-Gm-Gg: ASbGncsoll4EWOzaJLx9IwQFWNAyZ+T7tuA+X/AkwtAIjuRmcf5nYy85BluUUObLv48
 4PqFHi/PPROrZMVjVJ4OSqSlmMLABa/Z5LNibxQ2RsPN6PFZ4uf6KijobnqDymedVw5Ko3sGqTw
 5l9hS7W7wZK51fn6ON3j0h3IclQTNQ4D4SSdzHQ9tPawiB5V9Sf4RKQoe4dxdrt3dmhLJ0PmXgj
 52bpcM4SBBrEotMz0IyvLwQZUt/T/EgcFQILbpqHBFx65JpngFaG/aiWITE9yXjkbzHrcxyUff8
 x1mO1Zhd4SLnINBZV+Ud/GSpW9weiC3AA1bZPxII1t1vTPXRkOBE/vw9rdc=
X-Google-Smtp-Source: AGHT+IH9myU7rAbSMTd4DgxmQviP3R26lQ1xDqBfAvzab/5TmVkz3LXtZHsSIaldCFoPbLIAMAbWWQ==
X-Received: by 2002:a05:600c:4f02:b0:439:4c1e:d810 with SMTP id
 5b1f17b1804b1-439ae2ed58amr7335365e9.9.1740092855682; 
 Thu, 20 Feb 2025 15:07:35 -0800 (PST)
Received: from [192.168.69.157] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b43d4sm21448353f8f.4.2025.02.20.15.07.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 15:07:35 -0800 (PST)
Message-ID: <8f91a3d1-7259-4783-9743-23ad003734e1@linaro.org>
Date: Fri, 21 Feb 2025 00:07:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 028/162] tcg: Convert sub to TCGOutOpSubtract
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-29-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-29-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Hi Richard,

On 17/2/25 00:07, Richard Henderson wrote:
> Create a special subclass for sub, because two backends can
> support "subtract from immediate".  Drop all backend support
> for an immediate as the second operand, as we transform sub
> to add during optimize.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/mips/tcg-target-con-set.h    |  1 -
>   tcg/ppc/tcg-target-con-set.h     |  3 +-
>   tcg/riscv/tcg-target-con-set.h   |  1 -
>   tcg/riscv/tcg-target-con-str.h   |  1 -
>   tcg/tcg.c                        | 26 ++++++++++++++--
>   tcg/aarch64/tcg-target.c.inc     | 24 +++++++--------
>   tcg/arm/tcg-target.c.inc         | 29 +++++++++++-------
>   tcg/i386/tcg-target.c.inc        | 23 +++++++-------
>   tcg/loongarch64/tcg-target.c.inc | 32 +++++++++-----------
>   tcg/mips/tcg-target.c.inc        | 31 ++++++++-----------
>   tcg/ppc/tcg-target.c.inc         | 52 +++++++++++---------------------
>   tcg/riscv/tcg-target.c.inc       | 45 +++++++++------------------
>   tcg/s390x/tcg-target.c.inc       | 41 +++++++++++--------------
>   tcg/sparc64/tcg-target.c.inc     | 16 +++++++---
>   tcg/tci/tcg-target.c.inc         | 14 +++++++--
>   15 files changed, 165 insertions(+), 174 deletions(-)


> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index b740609c03..ca91a80efc 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -986,6 +986,14 @@ typedef struct TCGOutOpBinary {
>                       TCGReg a0, TCGReg a1, tcg_target_long a2);
>   } TCGOutOpBinary;
>   
> +typedef struct TCGOutOpSubtract {
> +    TCGOutOp base;
> +    void (*out_rrr)(TCGContext *s, TCGType type,
> +                    TCGReg a0, TCGReg a1, TCGReg a2);
> +    void (*out_rir)(TCGContext *s, TCGType type,
> +                    TCGReg a0, tcg_target_long a1, TCGReg a2);
> +} TCGOutOpSubtract;
> +
>   #include "tcg-target.c.inc"
>   
>   #ifndef CONFIG_TCG_INTERPRETER
> @@ -1012,6 +1020,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
>       OUTOP(INDEX_op_nor, TCGOutOpBinary, outop_nor),
>       OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
>       OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
> +    OUTOP(INDEX_op_sub_i32, TCGOutOpSubtract, outop_sub),
> +    OUTOP(INDEX_op_sub_i64, TCGOutOpSubtract, outop_sub),
>       OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
>   };
>   
> @@ -2231,7 +2241,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_st8_i32:
>       case INDEX_op_st16_i32:
>       case INDEX_op_st_i32:
> -    case INDEX_op_sub_i32:
>       case INDEX_op_neg_i32:
>       case INDEX_op_mul_i32:
>       case INDEX_op_shl_i32:
> @@ -2301,7 +2310,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_st16_i64:
>       case INDEX_op_st32_i64:
>       case INDEX_op_st_i64:
> -    case INDEX_op_sub_i64:
>       case INDEX_op_neg_i64:
>       case INDEX_op_mul_i64:
>       case INDEX_op_shl_i64:
> @@ -5442,6 +5450,20 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>           }
>           break;
>   
> +    case INDEX_op_sub_i32:
> +    case INDEX_op_sub_i64:
> +        {
> +            const TCGOutOpSubtract *out = &outop_sub;
> +
> +            tcg_debug_assert(!const_args[2]);
> +            if (const_args[1]) {
> +                out->out_rir(s, type, new_args[0], new_args[1], new_args[2]);
> +            } else {
> +                out->out_rrr(s, type, new_args[0], new_args[1], new_args[2]);
> +            }
> +        }
> +        break;
> +
>       default:
>           if (def->flags & TCG_OPF_VECTOR) {
>               tcg_out_vec_op(s, op->opc, type - TCG_TYPE_V64,
> diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
> index 30cad937b7..dfe67c1261 100644
> --- a/tcg/aarch64/tcg-target.c.inc
> +++ b/tcg/aarch64/tcg-target.c.inc
> @@ -2205,6 +2205,17 @@ static const TCGOutOpBinary outop_orc = {
>       .out_rrr = tgen_orc,
>   };
>   
> +static void tgen_sub(TCGContext *s, TCGType type,
> +                     TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tcg_out_insn(s, 3502, SUB, type, a0, a1, a2);
> +}
> +
> +static const TCGOutOpSubtract outop_sub = {
> +    .base.static_constraint = C_O1_I2(r, r, r),
> +    .out_rrr = tgen_sub,
> +};
> +
>   static void tgen_xor(TCGContext *s, TCGType type,
>                        TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -2290,15 +2301,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
>           tcg_out_ldst(s, I3312_STRX, a0, a1, a2, 3);
>           break;
>   
> -    case INDEX_op_sub_i32:
> -    case INDEX_op_sub_i64:
> -        if (c2) {
> -            tgen_addi(s, ext, a0, a1, -a2);

I'm a bit lost with this change here, and following patch #4
(ADD conversion).

Since tgen_addi() effectively handles both add/sub, why not
name it tgen_addsubi() like the old tcg_out_addsubi() name?

(Maybe reorder to have that SUB conv patch after ADD conv?)

> -        } else {
> -            tcg_out_insn(s, 3502, SUB, ext, a0, a1, a2);
> -        }
> -        break;
> -
>       case INDEX_op_neg_i64:
>       case INDEX_op_neg_i32:
>           tcg_out_insn(s, 3502, SUB, ext, a0, TCG_REG_XZR, a1);
> @@ -3014,10 +3016,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_st_i64:
>           return C_O0_I2(rz, r);
>   
> -    case INDEX_op_sub_i32:
> -    case INDEX_op_sub_i64:
> -        return C_O1_I2(r, r, rA);
> -
>       case INDEX_op_setcond_i32:
>       case INDEX_op_setcond_i64:
>       case INDEX_op_negsetcond_i32:


