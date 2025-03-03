Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068EDC282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 10:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp3Pj-0000lz-W6; Mon, 03 Mar 2025 05:52:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp3PY-0000l9-L5
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 05:52:40 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp3PL-0001Un-G7
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 05:52:25 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso28864205e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 02:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740999141; x=1741603941; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WV8i2n1dINUi3naKDRxscUGWR2GsvMFaJaNzsmC0+fc=;
 b=F2WpxomGhcDDEZUX9H/IGhY9lFwsfw2dNyfSpuRzSss6AqLnG+lF8IaYgXgKgGQqmc
 lM7xowYoY8FLCpW9XdG+0epXsi8Xv2YQg363CcpLJps5FAtz420YOaKP9OkfYSad3M25
 ukevAX0hoMr3/IXozCSIreGphnhokbX/4GUlu675DxLoBfimqwzT0+j+L/aKPrhOuvQU
 JCWUTgfSrMNXiO3HhC+Ihk3Ilw8bjvsbSVe16NR429iQkqi0hxCO0akFyeXu+pgQSAAn
 xzQP4QI8Wv5HBgxqEqKlkSJ7AZ8JBwUTATaCgzaPfDqDEW/eDP87DSFV93EMNOdIs4NN
 jIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740999141; x=1741603941;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WV8i2n1dINUi3naKDRxscUGWR2GsvMFaJaNzsmC0+fc=;
 b=VZF0BlP2D7a2flXC6iryBssOKtJPY+0pnqBsgpH0iRBdTRHIvPyl/EgO9tcJPNQuON
 8mbrCuFnakPoFIPQFugDN8QvkG1f4g6j2Fok+Z8QvO1SvVHFC/p1Z3jDwAzSL7tfjE8g
 CDDP5nVnoDa0LJidwwpht1dQW0BKoX1gdFGJ5OeK9w7iUO3p8xIjiGYK4Oxxdat2GyiA
 CkXR0SiC3UwQw4GKbGvt0H08+pjwOJv/6oJhikkAxAG7ayVNClmVJzzrKxnCoktfA4ve
 caZhn+cCetZjtWrTkgdqssI5zQQ4I6TWo4Huq1R4hTRqXonFtAKA46/zPpiw2n09t8gT
 LoBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMyfFL2DmnCFi5Os5CfJM/3J97dSXNCSNJqFLxjpxBdzwnvQkdlk/CSQKEC6f9djw6+j/Akc2UWpMG@nongnu.org
X-Gm-Message-State: AOJu0YwGcAsKteb3dV3DsueIv+W5EiTyTOdQTkf+QjqtIq4EwP74Hm9K
 AkgkUWOkMr6+gR7SL257dw89oWgMtgE1yBhepQ51RsP2ZfYZmW4xERJHaCQsZkNyKqdprFV7WZl
 InzcPmg==
X-Gm-Gg: ASbGncvI1u1h1Ca2N8Rhh1KKiP/5aZ5qEQ26Gku40VzSVzkzXj2wzkedDiyZxIPZcnv
 ktvLentA1AuaBkkQjzjwNcWh1CrFujby0kM3qYYJESbC5yi8I31WaCSqnFQU53K8G7sqL6c6qRW
 nCHTGDPPWbEs7zEOnPeevF5A3YJNwv/YXLFU3kH3JOtcYgwKHUQShPjXKQdGmkomcjFdxIMXIDa
 Z+w49E4y/sH6OrrQ0CCQncuaDasC6xJPkVy6pARjZG52i2Ed/8v+aJNwKAQ/8HXvBRhxT+eY+6h
 oAHMAKL3T5feBGCUUB6isLdqyPXy3o9V7ySWtDSjp3W/ahCQC62w5gKmNBzinPkJkDkYiYSLCZX
 hrmGRuHT3uckt
X-Google-Smtp-Source: AGHT+IHKY6ajHv9wgXclo927FismvpXJbL5KmUSry9XhpYggyJnc4fKbZHIXNpgFYiA3354yE3/GZw==
X-Received: by 2002:a05:600c:474a:b0:439:8c80:6afd with SMTP id
 5b1f17b1804b1-43ba6773c5emr83970975e9.26.1740999141527; 
 Mon, 03 Mar 2025 02:52:21 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47b7d12sm14366111f8f.58.2025.03.03.02.52.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 02:52:20 -0800 (PST)
Message-ID: <ff6c9a3b-a1dd-4f86-b3f6-80c787a6fea4@linaro.org>
Date: Mon, 3 Mar 2025 11:52:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 036/162] tcg: Convert muluh to TCGOutOpBinary
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-37-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-37-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 17/2/25 00:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/aarch64/tcg-target-has.h     |  2 --
>   tcg/arm/tcg-target-has.h         |  1 -
>   tcg/i386/tcg-target-has.h        |  2 --
>   tcg/loongarch64/tcg-target-has.h |  2 --
>   tcg/mips/tcg-target-has.h        |  2 --
>   tcg/ppc/tcg-target-has.h         |  2 --
>   tcg/riscv/tcg-target-has.h       |  2 --
>   tcg/s390x/tcg-target-has.h       |  2 --
>   tcg/sparc64/tcg-target-has.h     |  2 --
>   tcg/tcg-has.h                    |  1 -
>   tcg/tci/tcg-target-has.h         |  2 --
>   tcg/tcg-op.c                     |  7 +++---
>   tcg/tcg.c                        | 16 ++++++--------
>   tcg/aarch64/tcg-target.c.inc     | 21 ++++++++++++++----
>   tcg/arm/tcg-target.c.inc         |  4 ++++
>   tcg/i386/tcg-target.c.inc        |  4 ++++
>   tcg/loongarch64/tcg-target.c.inc | 24 +++++++++++++--------
>   tcg/mips/tcg-target.c.inc        | 37 ++++++++++++++++++--------------
>   tcg/ppc/tcg-target.c.inc         | 20 ++++++++++-------
>   tcg/riscv/tcg-target.c.inc       | 24 +++++++++++++++------
>   tcg/s390x/tcg-target.c.inc       |  4 ++++
>   tcg/sparc64/tcg-target.c.inc     | 23 +++++++++++++++-----
>   tcg/tci/tcg-target.c.inc         |  4 ++++
>   23 files changed, 126 insertions(+), 82 deletions(-)


> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index ec64a235d0..2741048353 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1022,6 +1022,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
>       OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
>       OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
>       OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
> +    OUTOP(INDEX_op_muluh_i32, TCGOutOpBinary, outop_muluh),
> +    OUTOP(INDEX_op_muluh_i64, TCGOutOpBinary, outop_muluh),
>       OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
>       OUTOP(INDEX_op_neg, TCGOutOpUnary, outop_neg),
>       OUTOP(INDEX_op_nor, TCGOutOpBinary, outop_nor),
> @@ -2280,8 +2282,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
>           return TCG_TARGET_HAS_mulu2_i32;
>       case INDEX_op_muls2_i32:
>           return TCG_TARGET_HAS_muls2_i32;
> -    case INDEX_op_muluh_i32:
> -        return TCG_TARGET_HAS_muluh_i32;
>       case INDEX_op_mulsh_i32:
>           return TCG_TARGET_HAS_mulsh_i32;
>       case INDEX_op_bswap16_i32:
> @@ -2362,8 +2362,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
>           return TCG_TARGET_HAS_mulu2_i64;
>       case INDEX_op_muls2_i64:
>           return TCG_TARGET_HAS_muls2_i64;
> -    case INDEX_op_muluh_i64:
> -        return TCG_TARGET_HAS_muluh_i64;
>       case INDEX_op_mulsh_i64:
>           return TCG_TARGET_HAS_mulsh_i64;
>   
> @@ -3876,7 +3874,6 @@ liveness_pass_1(TCGContext *s)
>       QTAILQ_FOREACH_REVERSE_SAFE(op, &s->ops, link, op_prev) {
>           int nb_iargs, nb_oargs;
>           TCGOpcode opc_new, opc_new2;
> -        bool have_opc_new2;
>           TCGLifeData arg_life = 0;
>           TCGTemp *ts;
>           TCGOpcode opc = op->opc;
> @@ -4036,22 +4033,18 @@ liveness_pass_1(TCGContext *s)
>           case INDEX_op_mulu2_i32:
>               opc_new = INDEX_op_mul;
>               opc_new2 = INDEX_op_muluh_i32;
> -            have_opc_new2 = TCG_TARGET_HAS_muluh_i32;

Maybe cleaner to use 'have_opc_new2 = true', checking for
have_opc_new2 && tcg_op_supported(), then remove have_opc_new2
in 2 commits in "Convert mulsh to TCGOutOpBinary"; otherwise
maybe mention that this commit is tied to mulsh conversion?

>               goto do_mul2;
>           case INDEX_op_muls2_i32:
>               opc_new = INDEX_op_mul;
>               opc_new2 = INDEX_op_mulsh_i32;
> -            have_opc_new2 = TCG_TARGET_HAS_mulsh_i32;
>               goto do_mul2;
>           case INDEX_op_mulu2_i64:
>               opc_new = INDEX_op_mul;
>               opc_new2 = INDEX_op_muluh_i64;
> -            have_opc_new2 = TCG_TARGET_HAS_muluh_i64;
>               goto do_mul2;
>           case INDEX_op_muls2_i64:
>               opc_new = INDEX_op_mul;
>               opc_new2 = INDEX_op_mulsh_i64;
> -            have_opc_new2 = TCG_TARGET_HAS_mulsh_i64;
>               goto do_mul2;
>           do_mul2:
>               nb_iargs = 2;
> @@ -4065,7 +4058,8 @@ liveness_pass_1(TCGContext *s)
>                   op->opc = opc = opc_new;
>                   op->args[1] = op->args[2];
>                   op->args[2] = op->args[3];
> -            } else if (arg_temp(op->args[0])->state == TS_DEAD && have_opc_new2) {
> +            } else if (arg_temp(op->args[0])->state == TS_DEAD &&
> +                       tcg_op_supported(opc_new2, TCGOP_TYPE(op), 0)) {
>                   /* The low part of the operation is dead; generate the high. */
>                   op->opc = opc = opc_new2;
>                   op->args[0] = op->args[1];


> diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
> index 95c2645226..ad62d877c7 100644
> --- a/tcg/mips/tcg-target.c.inc
> +++ b/tcg/mips/tcg-target.c.inc
> @@ -1743,6 +1743,27 @@ static const TCGOutOpBinary outop_mul = {
>       .out_rrr = tgen_mul,
>   };
>   
> +static void tgen_muluh(TCGContext *s, TCGType type,
> +                       TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    if (use_mips32r6_instructions) {

Similarly for style:

            insn = type == TCG_TYPE_I32 ? OPC_MUHU : OPC_DMUHU;

> +        if (type == TCG_TYPE_I32) {
> +            tcg_out_opc_reg(s, OPC_MUHU, a0, a1, a2);
> +        } else {
> +            tcg_out_opc_reg(s, OPC_DMUHU, a0, a1, a2);
> +        }
> +    } else {
> +        MIPSInsn insn = type == TCG_TYPE_I32 ? OPC_MULTU : OPC_DMULTU;
> +        tcg_out_opc_reg(s, insn, 0, a1, a2);
> +        tcg_out_opc_reg(s, OPC_MFHI, a0, 0, 0);
> +    }
> +}


> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index ff685037d7..65246cc450 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -2021,6 +2021,23 @@ static const TCGOutOpBinary outop_mul = {
>       .out_rrr = tgen_mul,
>   };
>   
> +static TCGConstraintSetIndex cset_mulh(TCGType type, unsigned flags)
> +{
> +    return type == TCG_TYPE_I32 ? C_NotImplemented : C_O1_I2(r, r, r);
> +}
> +


> @@ -2379,11 +2396,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_opc_reg(s, OPC_MULH, a0, a1, a2);
>           break;
>   
> -    case INDEX_op_muluh_i32:
> -    case INDEX_op_muluh_i64:
> -        tcg_out_opc_reg(s, OPC_MULHU, a0, a1, a2);
> -        break;
> -
>       case INDEX_op_mb:
>           tcg_out_mb(s, a0);
>           break;

Please mention we remove the unreachable mulsh_i32 leftover from
commit aeb6326ec5e ("tcg/riscv: Require TCG_TARGET_REG_BITS == 64").

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


