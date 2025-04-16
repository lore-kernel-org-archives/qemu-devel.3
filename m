Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAA2C369C7
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u58ZH-0007o7-BP; Wed, 16 Apr 2025 15:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58Z9-0007m5-Sw
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:37:00 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58Z6-0000tb-Ck
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:36:58 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-736c277331eso1175382b3a.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744832214; x=1745437014; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=crYcDHOkkAnewy+c4yXJC5tIB7bJUCxHeFrLINWOUyM=;
 b=ZheZeutLjWwLMNSi6cLme6f0aMX6jky3BQQBTuMb3EnJFs6N68Qpns5HF00cAW7c2K
 oQA2FM/xfP7ZKor9FTkwfi+YUX9fWMgY2pDrfdAmFflz+DkXlVxqgoWXIONvzBT7Mg1G
 +Bwr1i83LN/VULXH1q08ZnbqfiYJB+sByYB0hHrbdPcTjNa9U49u0TAgBuyleDpD1d0g
 URO6W3t2Xd7oY9g/7Z++DcA/mRwJQWQcWZy3+1gUzLlbA7tv82r2ity6HCCewrEEXO8o
 20ALpul0KloxrH3ufgiQR/j+JzfpzJrQ+qvsj2UemlEIYzZ9FhC15W161xgvNj3payOz
 T/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744832214; x=1745437014;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=crYcDHOkkAnewy+c4yXJC5tIB7bJUCxHeFrLINWOUyM=;
 b=YQsxi1pzCaheB2f/ChvE7M0bJ7lrjI8q9A0tWJhareGUaxmlNI8wAt1qNZ96JpcY28
 TTiRNdY8Lxa71nedV4cwkcU3MnfVPqae7DLVjTrV9HB8y63R7oMWghWPCNZUhXz6MQws
 Il66glx6/NKn3Zen9SpzIhKkadm6iNTxsLqaF8X44ZVBV7gBkCMvIEMQkO2iLt5Rddxy
 VO65PP2JDbuToVLtXqCfo4J4vYWORso8LC7/OPKEOVLmxTNIqIRCd/T+KXai1rDFx318
 tybBYzqw8HNBabXLtd9ypRHC17ocR2vtAqXPaPVslZ7ngXYRyulMRskSY2Z2wQXB6GAP
 5Y0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW79w6k8Rcd9o76ZOQZXL2EUnj/YKBh87F7rfHvGaE2zmVHvMzhxSeHrocOO+DlWGUgtz5wZxPOPlqO@nongnu.org
X-Gm-Message-State: AOJu0Ywr98lmmigRJBvVrEOkGaetesuwJNAwNmMjw7uT1vRZS8BnJf5c
 dfR+G8jnFL9FNwKGK+eq2+HME6cig9My+dJjnazUX3OP9xYnvx2nKnta3QXknBM=
X-Gm-Gg: ASbGncvC48bY7nO6htO+gr1N1WImAEtlR4eDFW+eThXj0nJB4LR7NMSqJGORDwkmLj6
 6X1JMji2JQ1BKIbhW7TvXGRs6IUzmNkEQgTwoFTXmb/220pRwzHRSi/rjTbKBdGi+BLwKk2ucZF
 AmjZ3WRHC2Rp66vWDNqr5CJ/83OcDOR3+QB9PwvPhDZKjdR1AMF5IhW2pj47qesQEHfvd1tsZsK
 ylHA7H8gGKzwr7vrcIFbsTTAEijJhkYW9HzbMtsOl0qXGrOgNHk+C3lRQbo5Oi9H2HMwA4Wjtd/
 Vt5uMQxMVSoJ5sG4qchraLPYzyR0OAdO3QIcvy5Aspr2c55yBbcHfA==
X-Google-Smtp-Source: AGHT+IENNBRCAtCwK9Vwqa3gwj0643FoYbKSjXM5fwD4NNZc8w73k1kBaxPMZ/jSxZhqjBkIVFRM7Q==
X-Received: by 2002:a05:6a21:2d09:b0:1f3:237b:5997 with SMTP id
 adf61e73a8af0-203be06a36cmr66995637.14.1744832213784; 
 Wed, 16 Apr 2025 12:36:53 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f8345sm11124726b3a.105.2025.04.16.12.36.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 12:36:53 -0700 (PDT)
Message-ID: <8c241991-c18b-4b52-8d88-eb5efb56e2a7@linaro.org>
Date: Wed, 16 Apr 2025 12:36:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 147/163] tcg/tci: Implement add/sub carry opcodes
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-148-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-148-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tci.c                    | 54 ++++++++++++++++++++++++++++
>   tcg/tci/tcg-target-opc.h.inc |  1 +
>   tcg/tci/tcg-target.c.inc     | 69 +++++++++++++++++++++++++++++++-----
>   3 files changed, 116 insertions(+), 8 deletions(-)
> 
> diff --git a/tcg/tci.c b/tcg/tci.c
> index dc916eb112..d65ff2b8f1 100644
> --- a/tcg/tci.c
> +++ b/tcg/tci.c
> @@ -361,6 +361,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
>       tcg_target_ulong regs[TCG_TARGET_NB_REGS];
>       uint64_t stack[(TCG_STATIC_CALL_ARGS_SIZE + TCG_STATIC_FRAME_SIZE)
>                      / sizeof(uint64_t)];
> +    bool carry = false;
>   
>       regs[TCG_AREG0] = (tcg_target_ulong)env;
>       regs[TCG_REG_CALL_STACK] = (uintptr_t)stack;
> @@ -471,6 +472,9 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
>               tci_args_rl(insn, tb_ptr, &r0, &ptr);
>               regs[r0] = *(tcg_target_ulong *)ptr;
>               break;
> +        case INDEX_op_tci_setcarry:
> +            carry = true;
> +            break;
>   
>               /* Load/store operations (32 bit). */
>   
> @@ -575,6 +579,46 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
>               tci_args_rr(insn, &r0, &r1);
>               regs[r0] = ctpop_tr(regs[r1]);
>               break;
> +        case INDEX_op_addco:
> +            tci_args_rrr(insn, &r0, &r1, &r2);
> +            t1 = regs[r1] + regs[r2];
> +            carry = t1 < regs[r1];
> +            regs[r0] = t1;
> +            break;
> +        case INDEX_op_addci:
> +            tci_args_rrr(insn, &r0, &r1, &r2);
> +            regs[r0] = regs[r1] + regs[r2] + carry;
> +            break;
> +        case INDEX_op_addcio:
> +            tci_args_rrr(insn, &r0, &r1, &r2);
> +            if (carry) {
> +                t1 = regs[r1] + regs[r2] + 1;
> +                carry = t1 <= regs[r1];
> +            } else {
> +                t1 = regs[r1] + regs[r2];
> +                carry = t1 < regs[r1];
> +            }
> +            regs[r0] = t1;
> +            break;
> +        case INDEX_op_subbo:
> +            tci_args_rrr(insn, &r0, &r1, &r2);
> +            carry = regs[r1] < regs[r2];
> +            regs[r0] = regs[r1] - regs[r2];
> +            break;
> +        case INDEX_op_subbi:
> +            tci_args_rrr(insn, &r0, &r1, &r2);
> +            regs[r0] = regs[r1] - regs[r2] - carry;
> +            break;
> +        case INDEX_op_subbio:
> +            tci_args_rrr(insn, &r0, &r1, &r2);
> +            if (carry) {
> +                carry = regs[r1] <= regs[r2];
> +                regs[r0] = regs[r1] - regs[r2] - 1;
> +            } else {
> +                carry = regs[r1] < regs[r2];
> +                regs[r0] = regs[r1] - regs[r2];
> +            }
> +            break;
>           case INDEX_op_muls2:
>               tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
>   #if TCG_TARGET_REG_BITS == 32
> @@ -968,6 +1012,10 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
>                              op_name, str_r(r0), ptr);
>           break;
>   
> +    case INDEX_op_tci_setcarry:
> +        info->fprintf_func(info->stream, "%-12s", op_name);
> +        break;
> +
>       case INDEX_op_ld8u_i32:
>       case INDEX_op_ld8u_i64:
>       case INDEX_op_ld8s_i32:
> @@ -1007,6 +1055,9 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
>           break;
>   
>       case INDEX_op_add:
> +    case INDEX_op_addci:
> +    case INDEX_op_addcio:
> +    case INDEX_op_addco:
>       case INDEX_op_and:
>       case INDEX_op_andc:
>       case INDEX_op_clz:
> @@ -1027,6 +1078,9 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
>       case INDEX_op_shl:
>       case INDEX_op_shr:
>       case INDEX_op_sub:
> +    case INDEX_op_subbi:
> +    case INDEX_op_subbio:
> +    case INDEX_op_subbo:
>       case INDEX_op_xor:
>       case INDEX_op_tci_ctz32:
>       case INDEX_op_tci_clz32:
> diff --git a/tcg/tci/tcg-target-opc.h.inc b/tcg/tci/tcg-target-opc.h.inc
> index 672d9b7323..4eb32ed736 100644
> --- a/tcg/tci/tcg-target-opc.h.inc
> +++ b/tcg/tci/tcg-target-opc.h.inc
> @@ -2,6 +2,7 @@
>   /* These opcodes for use between the tci generator and interpreter. */
>   DEF(tci_movi, 1, 0, 1, TCG_OPF_NOT_PRESENT)
>   DEF(tci_movl, 1, 0, 1, TCG_OPF_NOT_PRESENT)
> +DEF(tci_setcarry, 0, 0, 0, TCG_OPF_NOT_PRESENT)
>   DEF(tci_clz32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
>   DEF(tci_ctz32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
>   DEF(tci_divs32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
> diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
> index bba96d7a19..947aa1aada 100644
> --- a/tcg/tci/tcg-target.c.inc
> +++ b/tcg/tci/tcg-target.c.inc
> @@ -573,21 +573,50 @@ static const TCGOutOpBinary outop_add = {
>       .out_rrr = tgen_add,
>   };
>   
> +static TCGConstraintSetIndex cset_addsubcarry(TCGType type, unsigned flags)
> +{
> +    return type == TCG_TYPE_REG ? C_O1_I2(r, r, r) : C_NotImplemented;
> +}
> +
> +static void tgen_addco(TCGContext *s, TCGType type,
> +                       TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tcg_out_op_rrr(s, INDEX_op_addco, a0, a1, a2);
> +}
> +
>   static const TCGOutOpBinary outop_addco = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_Dynamic,
> +    .base.dynamic_constraint = cset_addsubcarry,
> +    .out_rrr = tgen_addco,
>   };
>   
> +static void tgen_addci(TCGContext *s, TCGType type,
> +                       TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tcg_out_op_rrr(s, INDEX_op_addci, a0, a1, a2);
> +}
> +
>   static const TCGOutOpAddSubCarry outop_addci = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_Dynamic,
> +    .base.dynamic_constraint = cset_addsubcarry,
> +    .out_rrr = tgen_addci,
>   };
>   
> +static void tgen_addcio(TCGContext *s, TCGType type,
> +                        TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tcg_out_op_rrr(s, INDEX_op_addcio, a0, a1, a2);
> +}
> +
>   static const TCGOutOpBinary outop_addcio = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_Dynamic,
> +    .base.dynamic_constraint = cset_addsubcarry,
> +    .out_rrr = tgen_addcio,
>   };
>   
>   static void tcg_out_set_carry(TCGContext *s)
>   {
> -    g_assert_not_reached();
> +    tcg_out_op_v(s, INDEX_op_tci_setcarry);
>   }
>   
>   static void tgen_and(TCGContext *s, TCGType type,
> @@ -910,21 +939,45 @@ static const TCGOutOpSubtract outop_sub = {
>       .out_rrr = tgen_sub,
>   };
>   
> +static void tgen_subbo(TCGContext *s, TCGType type,
> +                       TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tcg_out_op_rrr(s, INDEX_op_subbo, a0, a1, a2);
> +}
> +
>   static const TCGOutOpAddSubCarry outop_subbo = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_Dynamic,
> +    .base.dynamic_constraint = cset_addsubcarry,
> +    .out_rrr = tgen_subbo,
>   };
>   
> +static void tgen_subbi(TCGContext *s, TCGType type,
> +                       TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tcg_out_op_rrr(s, INDEX_op_subbi, a0, a1, a2);
> +}
> +
>   static const TCGOutOpAddSubCarry outop_subbi = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_Dynamic,
> +    .base.dynamic_constraint = cset_addsubcarry,
> +    .out_rrr = tgen_subbi,
>   };
>   
> +static void tgen_subbio(TCGContext *s, TCGType type,
> +                        TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    tcg_out_op_rrr(s, INDEX_op_subbio, a0, a1, a2);
> +}
> +
>   static const TCGOutOpAddSubCarry outop_subbio = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_Dynamic,
> +    .base.dynamic_constraint = cset_addsubcarry,
> +    .out_rrr = tgen_subbio,
>   };
>   
>   static void tcg_out_set_borrow(TCGContext *s)
>   {
> -    g_assert_not_reached();
> +    tcg_out_op_v(s, INDEX_op_tci_setcarry);  /* borrow == carry */
>   }
>   
>   static void tgen_xor(TCGContext *s, TCGType type,

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


