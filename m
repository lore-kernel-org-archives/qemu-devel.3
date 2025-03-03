Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35337C282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 20:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpCAY-00038b-PK; Mon, 03 Mar 2025 15:13:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpCAT-00038E-5L
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 15:13:37 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpCAK-0005DF-Qw
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 15:13:36 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22398e09e39so33556135ad.3
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 12:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741032804; x=1741637604; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l3GbTY3/BwOMk24TaUfbVu+j5nCE2gkgHvi7ap7PvLI=;
 b=FmO8IGgsdrfaGG30kF4xjaN415xEK5F2658jbQ2zpsMJinuPAIUUCL2uLR2+a7B9er
 y+KVp+4egCSxVglwJhm50Snbr+qkZWLnMez2yGI+4VHPw2xZoWx6KITNdfZUhUKBWS1F
 AAcopFTZWT9SejFCfp5Xs+lT3OapkFlMm+k4NqWCYlaqkR5NOmbSnEzgAIFvsEO6ZHaB
 0fkD8bCJMfJKHPj371AUZAt4OHxsOHyKAFclmbE6HB6sHqP2vgTxMKMsErrgLMQ1tEQB
 V+tNNVQCq5Lalj1WUG/dAGemtlAgftUSNaMLxv1YbZe2c7LjJQD9KILtxXXrhBSDvchM
 hB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741032804; x=1741637604;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l3GbTY3/BwOMk24TaUfbVu+j5nCE2gkgHvi7ap7PvLI=;
 b=R1BghC6vQuf+vvXgTcBwZoSe8OFBg6hPF04XMxLq4IoquZPP5ISbECP2f1h24vTfd9
 Wc1PA9F8vscj9vTl49maq9wQLNDN65ftMqBmV9lLHvNmn8+6LF6+R5WwDzLVXWmAETyU
 SFxuvb/fDQ/hB2r+Wq7HlPncko2UyuAr390U0wBuamFyEpezL+V927urY+AuVUxNN+Mh
 Lxg1DfgFZA36ZI0CLrW5UUDJBsdjuqjV3vCufbOO7gIzXxEJ43OIX4kYgVaV0YnazsfY
 PrpU1rwdgMxxPBYoLYksjm26BfxPP3BCKCSYq2Y4BvSpXUftquf+wCzADVhLXKK4H5yY
 Nprg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI4A8eGDEYvAH08lxynVjmuXJKrLuAkmRNTqroRIcrS7l1FaSpvHG3cgMbOzJ0RGutuNH7z/5fQXLQ@nongnu.org
X-Gm-Message-State: AOJu0YzEVEZv0LPcMvP1eNwegz4mENHL2yz91en7CYwN0oDLzpj0qr0E
 R032EmOd5XJj+RZW6cwpLPYvlygtbWkFDF1NkI7sklqIx+xrvd1o6jfQ9tXJeJztPZ+lBS25Fbc
 1
X-Gm-Gg: ASbGncskrT9EhPcEFGEyIimdD4CUqrQOBE/GqFzdPkKilSGhSmEJcUbQrmgFTMdj8ko
 h/ghLfu0KIKJo+ayWQNxArlx6sci7QiYxuFDerd7FkW534HFaGNQ+1twhjzdZnlsAhJTK3acfs1
 10hXKTEwKli5GEu3ydsIoMb62Xi5DJuZBdDkC8maMprO8ljT+xU70jEd+3+483+j0wmofTUHl38
 Btu9q4Yi5AvqfCY9ceutcWs3On/PDNFPRGN4rt+SK8wswPfGQKP6qnA0MQljjyg0LRxvBSaxgLZ
 LxdRKa+jb5RgWviMmwJKGtjjOvlzKzUdJD4SuTMKltUuDhVK2Fk7G1XteSbQ8XE6Guy62Qt9htk
 cjS4Q7Y3a
X-Google-Smtp-Source: AGHT+IFdbK8OURrfI+ZpHyOpX5SeprGT1YSnx9sZVWXaSS3giOXjBluDz/bmyPdHOqKFhU1LFE/6dw==
X-Received: by 2002:a17:902:e844:b0:223:432b:593d with SMTP id
 d9443c01a7336-2236924e182mr222907745ad.42.1741032804454; 
 Mon, 03 Mar 2025 12:13:24 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501fd2d1sm82168015ad.103.2025.03.03.12.13.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 12:13:23 -0800 (PST)
Message-ID: <5cd6ee6a-122a-484b-b02c-1e577f571090@linaro.org>
Date: Mon, 3 Mar 2025 12:13:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 036/162] tcg: Convert muluh to TCGOutOpBinary
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-37-richard.henderson@linaro.org>
 <ff6c9a3b-a1dd-4f86-b3f6-80c787a6fea4@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ff6c9a3b-a1dd-4f86-b3f6-80c787a6fea4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 3/3/25 02:52, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> On 17/2/25 00:08, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/aarch64/tcg-target-has.h     |  2 --
>>   tcg/arm/tcg-target-has.h         |  1 -
>>   tcg/i386/tcg-target-has.h        |  2 --
>>   tcg/loongarch64/tcg-target-has.h |  2 --
>>   tcg/mips/tcg-target-has.h        |  2 --
>>   tcg/ppc/tcg-target-has.h         |  2 --
>>   tcg/riscv/tcg-target-has.h       |  2 --
>>   tcg/s390x/tcg-target-has.h       |  2 --
>>   tcg/sparc64/tcg-target-has.h     |  2 --
>>   tcg/tcg-has.h                    |  1 -
>>   tcg/tci/tcg-target-has.h         |  2 --
>>   tcg/tcg-op.c                     |  7 +++---
>>   tcg/tcg.c                        | 16 ++++++--------
>>   tcg/aarch64/tcg-target.c.inc     | 21 ++++++++++++++----
>>   tcg/arm/tcg-target.c.inc         |  4 ++++
>>   tcg/i386/tcg-target.c.inc        |  4 ++++
>>   tcg/loongarch64/tcg-target.c.inc | 24 +++++++++++++--------
>>   tcg/mips/tcg-target.c.inc        | 37 ++++++++++++++++++--------------
>>   tcg/ppc/tcg-target.c.inc         | 20 ++++++++++-------
>>   tcg/riscv/tcg-target.c.inc       | 24 +++++++++++++++------
>>   tcg/s390x/tcg-target.c.inc       |  4 ++++
>>   tcg/sparc64/tcg-target.c.inc     | 23 +++++++++++++++-----
>>   tcg/tci/tcg-target.c.inc         |  4 ++++
>>   23 files changed, 126 insertions(+), 82 deletions(-)
> 
> 
>> diff --git a/tcg/tcg.c b/tcg/tcg.c
>> index ec64a235d0..2741048353 100644
>> --- a/tcg/tcg.c
>> +++ b/tcg/tcg.c
>> @@ -1022,6 +1022,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
>>       OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
>>       OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
>>       OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
>> +    OUTOP(INDEX_op_muluh_i32, TCGOutOpBinary, outop_muluh),
>> +    OUTOP(INDEX_op_muluh_i64, TCGOutOpBinary, outop_muluh),
>>       OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
>>       OUTOP(INDEX_op_neg, TCGOutOpUnary, outop_neg),
>>       OUTOP(INDEX_op_nor, TCGOutOpBinary, outop_nor),
>> @@ -2280,8 +2282,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
>>           return TCG_TARGET_HAS_mulu2_i32;
>>       case INDEX_op_muls2_i32:
>>           return TCG_TARGET_HAS_muls2_i32;
>> -    case INDEX_op_muluh_i32:
>> -        return TCG_TARGET_HAS_muluh_i32;
>>       case INDEX_op_mulsh_i32:
>>           return TCG_TARGET_HAS_mulsh_i32;
>>       case INDEX_op_bswap16_i32:
>> @@ -2362,8 +2362,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
>>           return TCG_TARGET_HAS_mulu2_i64;
>>       case INDEX_op_muls2_i64:
>>           return TCG_TARGET_HAS_muls2_i64;
>> -    case INDEX_op_muluh_i64:
>> -        return TCG_TARGET_HAS_muluh_i64;
>>       case INDEX_op_mulsh_i64:
>>           return TCG_TARGET_HAS_mulsh_i64;
>> @@ -3876,7 +3874,6 @@ liveness_pass_1(TCGContext *s)
>>       QTAILQ_FOREACH_REVERSE_SAFE(op, &s->ops, link, op_prev) {
>>           int nb_iargs, nb_oargs;
>>           TCGOpcode opc_new, opc_new2;
>> -        bool have_opc_new2;
>>           TCGLifeData arg_life = 0;
>>           TCGTemp *ts;
>>           TCGOpcode opc = op->opc;
>> @@ -4036,22 +4033,18 @@ liveness_pass_1(TCGContext *s)
>>           case INDEX_op_mulu2_i32:
>>               opc_new = INDEX_op_mul;
>>               opc_new2 = INDEX_op_muluh_i32;
>> -            have_opc_new2 = TCG_TARGET_HAS_muluh_i32;
> 
> Maybe cleaner to use 'have_opc_new2 = true', checking for
> have_opc_new2 && tcg_op_supported(), then remove have_opc_new2
> in 2 commits in "Convert mulsh to TCGOutOpBinary"; otherwise
> maybe mention that this commit is tied to mulsh conversion?

No.  It would be have_opc_new2 = tcg_op_supported(...).

>> @@ -4065,7 +4058,8 @@ liveness_pass_1(TCGContext *s)
>>                   op->opc = opc = opc_new;
>>                   op->args[1] = op->args[2];
>>                   op->args[2] = op->args[3];
>> -            } else if (arg_temp(op->args[0])->state == TS_DEAD && have_opc_new2) {
>> +            } else if (arg_temp(op->args[0])->state == TS_DEAD &&
>> +                       tcg_op_supported(opc_new2, TCGOP_TYPE(op), 0)) {
>>                   /* The low part of the operation is dead; generate the high. */
>>                   op->opc = opc = opc_new2;
>>                   op->args[0] = op->args[1];

I think it's cleaner to go ahead and make this change now,
since it works with both muluh and mulsh.

>> +++ b/tcg/mips/tcg-target.c.inc
>> @@ -1743,6 +1743,27 @@ static const TCGOutOpBinary outop_mul = {
>>       .out_rrr = tgen_mul,
>>   };
>> +static void tgen_muluh(TCGContext *s, TCGType type,
>> +                       TCGReg a0, TCGReg a1, TCGReg a2)
>> +{
>> +    if (use_mips32r6_instructions) {
> 
> Similarly for style:
> 
>             insn = type == TCG_TYPE_I32 ? OPC_MUHU : OPC_DMUHU;

Ok.

>> @@ -2379,11 +2396,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>>           tcg_out_opc_reg(s, OPC_MULH, a0, a1, a2);
>>           break;
>> -    case INDEX_op_muluh_i32:
>> -    case INDEX_op_muluh_i64:
>> -        tcg_out_opc_reg(s, OPC_MULHU, a0, a1, a2);
>> -        break;
>> -
>>       case INDEX_op_mb:
>>           tcg_out_mb(s, a0);
>>           break;
> 
> Please mention we remove the unreachable mulsh_i32 leftover from
> commit aeb6326ec5e ("tcg/riscv: Require TCG_TARGET_REG_BITS == 64").

Ok.

r~

> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


