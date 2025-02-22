Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05F5C021B2
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2025 17:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tltaU-0007vt-Ow; Sat, 22 Feb 2025 12:46:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tltaO-0007vc-NN
 for qemu-devel@nongnu.org; Sat, 22 Feb 2025 12:46:44 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tltaM-0007XF-DE
 for qemu-devel@nongnu.org; Sat, 22 Feb 2025 12:46:44 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2fc0d44a876so5109752a91.3
 for <qemu-devel@nongnu.org>; Sat, 22 Feb 2025 09:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740246400; x=1740851200; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RBBZ4e7u/DsoOakVsg3LsdNon5nbfMGCxT4whwAHCMQ=;
 b=c8SNbi6lqEZ0ft7NG385htlUKfbY+BuutnS6hgMrcjQzBvnXPeO/fIMoQ9lAI5ee73
 tT4nsDT+O6ZbW7sLT+b860VzwEiVWZk7VAe98NvR+PKsUM/pks244EIXtZEvnGfNpawG
 UV/V8GRUgg2ncgJ1AdZ+XY1XxpAGB2w9y8EGCI/e18R8yX2GAv7Os2RDnfwaGot/bZWp
 tw0KYu0Z6CIxdNnxx7clSVRDYig/mfXdqEL1nDKlai87GYA4lsWTD8X+aetRD20aAERX
 u+w+51SUUh7TtqO5qm9vDeKdOrUqAPGlZ0ZMXxT5tCa2jImbEglrE5HPyDK4Pg82GsYJ
 M6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740246400; x=1740851200;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RBBZ4e7u/DsoOakVsg3LsdNon5nbfMGCxT4whwAHCMQ=;
 b=DOZeuw/N3iIHLf1JsLh0CDJ9heqm6srMLRyhnVcd1+i5E3jRMWZDFYFv4tteqkl4v9
 Xw4C9DbSpcsdbMzQRuvu4V7unr5KBaT5OvK4dm+l8k+cPRouviJmloP0Olz8T9YCikNC
 ZZhnBeFw2vYQPgX5yYZbQYPuUG540wGvaum9OaJEa4x57pySx2YsfZDVSl+DU5Jv2kYx
 E11Y4CbFxB/biN1962DlsEor5sOAzmq3OxgKhmScB64DrFSnXkwWXxK6WQy63v0mOd4m
 yEj3vI+blVnwTDQYg3UmMMrkrEe5KuNwb1cqxa5RlJ7x2VQyXOMaeKLtrXfeiSM/qgtH
 6qaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrB8z6MJlifh/Gzmmh51WPrKPk/DliwUGfAShRdDkCGMSVFeGSROM/TJZkiRRpwUoFVn8+hrBKISGf@nongnu.org
X-Gm-Message-State: AOJu0Yx+BDKfhc49FD9VnrjscGn+UEA0wv9EKFp7EazdxbxDEAHAg3pl
 HYtL0ByQnPBdu1qeTtcenIGcRnVDrdIrAwlCq1tTYUECh/uZNCo1mVUxUirTj7M=
X-Gm-Gg: ASbGncuaUeA+rOgq4aJDJGCtTMK3uxu/9zZhSGq5ouWymAbETaWK3rA2ka7TUlA57Gu
 JrjnDTZNSGP2RBbyWKPM8Af+oOTocRm4V2X3XExZ99/dQe0xe2OglbwhGqgM3akT1SaUG0usGEP
 QwPHknS589uemFpxhsyOdn89BkaooTsKq18fQHsM+neiGPQE86SmaIg+bTF0BjYy8EevMR8zP3V
 8UJa2pZ/IM4/M9x0OaMA4on7YwKOMgsONgN0T7JeYD032Y3dHI/kWyap7fy5lK+iVEZ5wZz25Rn
 BVLke0d2Kc9MtnmKb7DIXCb5Az5Bio01yelteUEqkV6lOaABRCtBeFMBMJAOUp8DbWugNuM1YKq
 pIHZdiJU=
X-Google-Smtp-Source: AGHT+IErRI3Xnuc+oYfSLFViMCoRvrAm5oznJai103QPRd8OTF8iJ8ksFVo4qlP1OhiNaHrkVjFLWg==
X-Received: by 2002:a17:90b:1651:b0:2ee:a583:e616 with SMTP id
 98e67ed59e1d1-2fce78abb73mr13664546a91.9.1740246400536; 
 Sat, 22 Feb 2025 09:46:40 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d556fc57sm152964075ad.194.2025.02.22.09.46.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Feb 2025 09:46:40 -0800 (PST)
Message-ID: <9efc1d4b-10a6-4137-beec-03011a353fc6@linaro.org>
Date: Sat, 22 Feb 2025 09:46:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 028/162] tcg: Convert sub to TCGOutOpSubtract
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-29-richard.henderson@linaro.org>
 <8f91a3d1-7259-4783-9743-23ad003734e1@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <8f91a3d1-7259-4783-9743-23ad003734e1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 2/20/25 15:07, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> On 17/2/25 00:07, Richard Henderson wrote:
>> Create a special subclass for sub, because two backends can
>> support "subtract from immediate".  Drop all backend support
>> for an immediate as the second operand, as we transform sub
>> to add during optimize.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/mips/tcg-target-con-set.h    |  1 -
>>   tcg/ppc/tcg-target-con-set.h     |  3 +-
>>   tcg/riscv/tcg-target-con-set.h   |  1 -
>>   tcg/riscv/tcg-target-con-str.h   |  1 -
>>   tcg/tcg.c                        | 26 ++++++++++++++--
>>   tcg/aarch64/tcg-target.c.inc     | 24 +++++++--------
>>   tcg/arm/tcg-target.c.inc         | 29 +++++++++++-------
>>   tcg/i386/tcg-target.c.inc        | 23 +++++++-------
>>   tcg/loongarch64/tcg-target.c.inc | 32 +++++++++-----------
>>   tcg/mips/tcg-target.c.inc        | 31 ++++++++-----------
>>   tcg/ppc/tcg-target.c.inc         | 52 +++++++++++---------------------
>>   tcg/riscv/tcg-target.c.inc       | 45 +++++++++------------------
>>   tcg/s390x/tcg-target.c.inc       | 41 +++++++++++--------------
>>   tcg/sparc64/tcg-target.c.inc     | 16 +++++++---
>>   tcg/tci/tcg-target.c.inc         | 14 +++++++--
>>   15 files changed, 165 insertions(+), 174 deletions(-)
> 
> 
>> diff --git a/tcg/tcg.c b/tcg/tcg.c
>> index b740609c03..ca91a80efc 100644
>> --- a/tcg/tcg.c
>> +++ b/tcg/tcg.c
>> @@ -986,6 +986,14 @@ typedef struct TCGOutOpBinary {
>>                       TCGReg a0, TCGReg a1, tcg_target_long a2);
>>   } TCGOutOpBinary;
>> +typedef struct TCGOutOpSubtract {
>> +    TCGOutOp base;
>> +    void (*out_rrr)(TCGContext *s, TCGType type,
>> +                    TCGReg a0, TCGReg a1, TCGReg a2);
>> +    void (*out_rir)(TCGContext *s, TCGType type,
>> +                    TCGReg a0, tcg_target_long a1, TCGReg a2);
>> +} TCGOutOpSubtract;
>> +
>>   #include "tcg-target.c.inc"
>>   #ifndef CONFIG_TCG_INTERPRETER
>> @@ -1012,6 +1020,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
>>       OUTOP(INDEX_op_nor, TCGOutOpBinary, outop_nor),
>>       OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
>>       OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
>> +    OUTOP(INDEX_op_sub_i32, TCGOutOpSubtract, outop_sub),
>> +    OUTOP(INDEX_op_sub_i64, TCGOutOpSubtract, outop_sub),
>>       OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
>>   };
>> @@ -2231,7 +2241,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
>>       case INDEX_op_st8_i32:
>>       case INDEX_op_st16_i32:
>>       case INDEX_op_st_i32:
>> -    case INDEX_op_sub_i32:
>>       case INDEX_op_neg_i32:
>>       case INDEX_op_mul_i32:
>>       case INDEX_op_shl_i32:
>> @@ -2301,7 +2310,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
>>       case INDEX_op_st16_i64:
>>       case INDEX_op_st32_i64:
>>       case INDEX_op_st_i64:
>> -    case INDEX_op_sub_i64:
>>       case INDEX_op_neg_i64:
>>       case INDEX_op_mul_i64:
>>       case INDEX_op_shl_i64:
>> @@ -5442,6 +5450,20 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>>           }
>>           break;
>> +    case INDEX_op_sub_i32:
>> +    case INDEX_op_sub_i64:
>> +        {
>> +            const TCGOutOpSubtract *out = &outop_sub;
>> +
>> +            tcg_debug_assert(!const_args[2]);
>> +            if (const_args[1]) {
>> +                out->out_rir(s, type, new_args[0], new_args[1], new_args[2]);
>> +            } else {
>> +                out->out_rrr(s, type, new_args[0], new_args[1], new_args[2]);
>> +            }
>> +        }
>> +        break;
>> +
>>       default:
>>           if (def->flags & TCG_OPF_VECTOR) {
>>               tcg_out_vec_op(s, op->opc, type - TCG_TYPE_V64,
>> diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
>> index 30cad937b7..dfe67c1261 100644
>> --- a/tcg/aarch64/tcg-target.c.inc
>> +++ b/tcg/aarch64/tcg-target.c.inc
>> @@ -2205,6 +2205,17 @@ static const TCGOutOpBinary outop_orc = {
>>       .out_rrr = tgen_orc,
>>   };
>> +static void tgen_sub(TCGContext *s, TCGType type,
>> +                     TCGReg a0, TCGReg a1, TCGReg a2)
>> +{
>> +    tcg_out_insn(s, 3502, SUB, type, a0, a1, a2);
>> +}
>> +
>> +static const TCGOutOpSubtract outop_sub = {
>> +    .base.static_constraint = C_O1_I2(r, r, r),
>> +    .out_rrr = tgen_sub,
>> +};
>> +
>>   static void tgen_xor(TCGContext *s, TCGType type,
>>                        TCGReg a0, TCGReg a1, TCGReg a2)
>>   {
>> @@ -2290,15 +2301,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
>>           tcg_out_ldst(s, I3312_STRX, a0, a1, a2, 3);
>>           break;
>> -    case INDEX_op_sub_i32:
>> -    case INDEX_op_sub_i64:
>> -        if (c2) {
>> -            tgen_addi(s, ext, a0, a1, -a2);
> 
> I'm a bit lost with this change here, and following patch #4
> (ADD conversion).
> 
> Since tgen_addi() effectively handles both add/sub, why not
> name it tgen_addsubi() like the old tcg_out_addsubi() name?

Since 1551004eeb4 (tcg: Canonicalize subi to addi during opcode generation), we should 
never see "sub x, y, constant".  That's what I was trying to say up in the patch 
description with "Drop all backend support for an immediate as the second operand".


r~

