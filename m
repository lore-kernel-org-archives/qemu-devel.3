Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2021C61DCB
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 19:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0Oe3-0007ju-E1; Sat, 29 Aug 2026 15:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x0Ody-0007je-Vl
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 15:23:11 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x0Odt-00087R-0W
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 15:23:10 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-38dfe910e9dso2469200a91.3
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2026 12:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788031383; x=1788636183; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=O/+aHiglLItLYmkC4SgyaZmYZWxQkxu1p8SUtb4kmdo=;
 b=wHEuxoBaA6pY/0yVE7ng24NuJr9jIlpfFHhe+3ZYV2YlOGnRVcWWWuMDRbRizp1XMG
 sE/9Ap6U8eNaMQ+yYd7jvRFhGlkm+AFxsPGUt8BQOkyrcJCxtCPnYrVze54By5c+fBp/
 jvnf5eDJDq2OB5gbBBxr3pz8K1PZJWIM9CFmAb4QvT2/6lsZOyBDTgLXOecf1qNTwd7e
 7EFcUlLSzmEujPQIk3QymKqJbmwSsxJJYPMcfnwHbeAq78b0zB/xxg6sF9FxRN8iph7F
 UuSkBrITf5BHiZPVU3RHN4Dp7hGpK0xgOCxfJ8cQZ95jsgkxf1Avm/vT5C7J0eDGKWu3
 eCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788031383; x=1788636183;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O/+aHiglLItLYmkC4SgyaZmYZWxQkxu1p8SUtb4kmdo=;
 b=DJoF9Ok4tLv387bC9jsLqpS5h+ibrKvotEcy0GwLlViZF91eGMsHzUCRxtv+oA9/ZT
 BMpiLSPNOv3NbFUA1X90HwECvKNQZzQi3iWYhBydBiTcBxOk6Q/8wVNuIPo8SimpwEDm
 +6HCSMgR3K2Y0z83b/AY16HPz28PRXjqX9KVghJr1XmgLjDDokbdBPwfWwDMSK4IwyvB
 h/TRqZtqNkbJZG3lNbaFhiMiJA645rUoKa9+Vx9Uqd+PvWqnQ57KT3ArwV7CUxSLnbyI
 Un2bx+aBVLB+a9WSj4FqJY4abSdzmzixGalyGSxpl/vWY7/pzkRtQwWQl4lORy1tl6mX
 ALxg==
X-Gm-Message-State: AFuF++l86OOrv6j8djHxaF9bOAzFNbAVxzydLPPDzWT5A5aR1UE+Wzwc
 hfqgmXb+16+bejSLZKontve/StDznNrnYDqLYHwAWkm4sLpjZOVLQMfn7d+Dnkbj6aI=
X-Gm-Gg: AYBFou3mYq0WG87P6un1QR8KbidzCmP+e44qg1e7kQcQ+yIFsk8G6fpwYmp4vmDzQSy
 NK5EokfnLVPfWUt+fl7eek7ziapPIsVNh6snVbbP2rSlCHmkHKR7mEmaJ4yP/skhM8zY28rWHkX
 e6T8uzM0eOeWomIWEICc0eN9EqhQNtE0aTbozokS1MPRNcNQLnteEBN4FrkyW4kqmYUNDnAR1+q
 tZFJzDXy3rQDAMNncsinW9wAXwkOFeEJehpuS74hhLZGJEauxHJgnx9jX6Qam9dlW3QqeNc41LQ
 96B4rhrC5qpyqbIkxoNnRZsL1q+3OUsTQlxm0tTaSC3h+wmWBZjzk7ZKoxaWTCNFG78SFpEx0EV
 +geQJKyWZdVZObhXnSHASXHCzg8WaZTX6NZOPXcVSZ20Ma5siLaWVlpPA6xO2KaKCDrj86+E/Gl
 bzGDXv6Cy0+JusMyKmRTXbKbPsWWqzDMtE+q83RhzJwV8cd+epi96kEwEWQoScO2zqDQFMRfvh9
 TwzKfjeYxXoCO3vnRWs3TDfgnEq80Y=
X-Received: by 2002:a17:90b:1806:b0:398:9be8:ea68 with SMTP id
 98e67ed59e1d1-3989be8eaafmr10227933a91.21.1788031382958; 
 Sat, 29 Aug 2026 12:23:02 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396d6d29de3sm2393845a91.2.2026.08.29.12.23.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2026 12:23:02 -0700 (PDT)
Message-ID: <4a484210-2093-402e-a1f5-91bbd39c5061@linaro.org>
Date: Sat, 29 Aug 2026 12:23:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/16] tcg/optimize: Handle INDEX_op_lea
To: Matt Turner <mattst88@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20260828224451.1564072-1-richard.henderson@linaro.org>
 <20260828224451.1564072-5-richard.henderson@linaro.org>
 <CAEdQ38Hc=wk70pFuCC5ELC75sYFbn0d7LZgS=rBput9xXSu97w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAEdQ38Hc=wk70pFuCC5ELC75sYFbn0d7LZgS=rBput9xXSu97w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/29/26 12:13, Matt Turner wrote:
> On Fri, Aug 28, 2026 at 6:44 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/optimize.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 65 insertions(+)
>>
>> diff --git a/tcg/optimize.c b/tcg/optimize.c
>> index d291c844ca8..83f95e26643 100644
>> --- a/tcg/optimize.c
>> +++ b/tcg/optimize.c
>> @@ -2101,6 +2101,68 @@ static bool fold_extu(OptContext *ctx, TCGOp *op)
>>       return fold_masks_zo(ctx, op, z_mask, o_mask);
>>   }
>>
>> +static bool fold_shift(OptContext *ctx, TCGOp *op);
>> +static bool fold_lea(OptContext *ctx, TCGOp *op)
>> +{
>> +    TCGArg sh = op->args[3];
>> +    TCGArg imm = op->args[4];
>> +    int var_mask = 0;
>> +
>> +    if (arg_is_const(op->args[1])) {
>> +        imm += arg_const_val(op->args[1]);
>> +    } else {
>> +        var_mask |= 1;
>> +    }
>> +    if (arg_is_const(op->args[2])) {
>> +        imm += arg_const_val(op->args[2]) << sh;
>> +    } else {
>> +        var_mask |= 2;
>> +    }
>> +
>> +    switch (var_mask) {
>> +    case 0:
>> +        return tcg_opt_gen_movi(ctx, op, op->args[0], imm);
>> +
>> +    case 1:
>> +        if (imm == 0) {
>> +            return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
>> +        }
>> +        op->opc = INDEX_op_add;
>> +        op->args[2] = arg_new_constant(ctx, imm);
>> +        break;
>> +
>> +    case 2:
>> +        if (sh == 0) {
>> +            if (imm == 0) {
>> +                return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[2]);
>> +            }
>> +            op->opc = INDEX_op_add;
>> +            op->args[1] = op->args[2];
>> +            op->args[2] = arg_new_constant(ctx, imm);
> 
> If we use `fold_add` here, will that handle optimizing add dst, x, -x
> into mov dst, 0?

Only if x is constant, which isn't the case here -- we've just checked 
for that in fact.

> It looks to me like `fold_shift` and `fold_add` propagate {z,o,s}_mask
> information, but `fold_lea` doesn't. I think that might prevent
> folding a downstream operation?

fold_shift does, fold_add does not.  Though I suppose we could go ahead 
and use it for completeness, just in case we do something there in future.


r~

