Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBC9D277C3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 22:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veLCl-0006oT-Kg; Fri, 09 Jan 2026 17:43:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veLCd-0006hN-RB
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 17:43:33 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veLCa-0005bm-9G
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 17:43:31 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a3e89aa5d0so34867085ad.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 14:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767998606; x=1768603406; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QgcAJ+qnpfiNHYOPwftLKpD6TBE4OI/x2uj4Ua3GlIo=;
 b=dfuz860vlM8PzTom5FmbZ2pao9HlnHQ6SuGC5ferPXrmvHf23HDaBTF4A7jJF2bTnf
 HBebMLSIEvnFOkz66j73bstKqm0XUqnHgyuFeuRI0sJ0DE5AWXvdOgcCuBDhvN1PzKfU
 tf/pzDo4bNAO/pKvLtjt7boSweE+UbYeUDYPTDz+JYndp4Pd33biuJtmUPHAwfbqo9pd
 wtnivkOmKS6axOw+D8qzjOiuqWxT9jDXITBGiA07gQb8K5njM3u3j1LzvFzl5zIJZkkI
 tsU/0hOveWoTCLvCIwNaE8LRc83AEal3zb3X8Qk4widB4H9WnGhUBNwusBiLU0WD41iB
 DDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767998606; x=1768603406;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QgcAJ+qnpfiNHYOPwftLKpD6TBE4OI/x2uj4Ua3GlIo=;
 b=NyEpp9q8CBizBSdd+317GQKlr2E+Ca67tHi9+L4Mh//qiztXqPPc6u+b1ekoFbp7Pj
 cHI5cp0yOxgoSBxaemL6j1P22MlXgKr0TKL1MSur9pKkRkpHYaOKxYP1NMs73FXdDc2E
 OIb5VeajhbLzdglGcwkxz3YBnxC2GL55bLhZFO+MU6v8XDGDbiBBuW4pEfBOykWxAFbD
 79ZCWlUWZdXlH80bcbrKEVPG3qdhdfuEbRx2gNxdyJjB0wMWccUZBmP2HQubLT2zG/eb
 2uCZGmy7tp9qXCS1ixUG+J+KcJzG8eTfs/ix3VenuK/4Hv1sB2hLH5MoDAb9Z0unjblx
 vDew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmUgc8z3Y5aXcwBKuoHLODSv2C1oN1bIGV/WB5uu4snRlhRs6+OmtWdNwWzgysRonhPbsqBYitvSqb@nongnu.org
X-Gm-Message-State: AOJu0Yzrq+ACZLg3r2iCx8BtxkEkZn4ZoQsY1dgb1Q7wqEpKZtGlEW+S
 whq5nFTBONMEzDYM1/7QIxSN8u5DezjicVXiHFTUnIYTD9pPqrT4tF+rlGvHdKgsuNw=
X-Gm-Gg: AY/fxX536fCG8S4S04mJV1k3gxwrWtMrAMopcThaUM4Kf76lCKtcBDcqDZ53xPLcyiW
 1PUd+nkYvv2CltYF1N9kP/Gkw48v1X7taj4Ikuu+ET8yienrVByS7zWCRjrfX9aQwwKwy5lZC/a
 Z24rv3DqTO7mkJceG6j1zCgkrc1HoXmthBYEEvJlrWgoZR2SQk8XTTOHOJYVk/L5L8FOTE9cpk2
 5J2bjTy3aM8Wng+oxgBYaIuNIvbPno9klk6NFGI41FYGUyWtROAdDuFFPIbGCBCvQnYq0GNLRBS
 x6JQZ/2F7ILXd5321LDcBfOAoEhIfxGvVoXDQ5trqTsclubf5SPh4943VCEEqmYE2FwMRZmWEfX
 lpw80O6gXprbHzHr8Xx39W255192XJ9KBLPU6sH+kevTKY/vA4lUN2PAiK8qOwKEUEdXFGd9Bat
 mx8q7JccpkI1mkKkD3IE7iX1WjJQ==
X-Google-Smtp-Source: AGHT+IGTedsDxltNKy5D7q1gCxwLj/ciRSH0+fA/01pfKE+74yaGQ2J/egxuowihaILBv17sx78Ayg==
X-Received: by 2002:a17:902:f652:b0:2a0:7fa0:7b5c with SMTP id
 d9443c01a7336-2a3ee4b8e3amr118348215ad.55.1767998606268; 
 Fri, 09 Jan 2026 14:43:26 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c48e8dsm115771035ad.37.2026.01.09.14.43.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 14:43:25 -0800 (PST)
Message-ID: <c3c6a8cb-64b6-425e-8179-bfe8fa087af2@linaro.org>
Date: Sat, 10 Jan 2026 09:43:19 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/29] accel/tcg/translate-all.c: detect addr_type
 dynamically
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-16-pierrick.bouvier@linaro.org>
 <7fcbddf8-46be-449f-ac20-1caba498be32@linaro.org>
 <0e158c01-3150-43f3-a78a-d77e8b07bc9f@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <0e158c01-3150-43f3-a78a-d77e8b07bc9f@linaro.org>
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

On 1/10/26 09:30, Pierrick Bouvier wrote:
> On 1/9/26 2:13 PM, Richard Henderson wrote:
>> On 1/9/26 16:31, Pierrick Bouvier wrote:
>>> With TARGET_ADDRESS_BITS mechanism, it's now possible to specify which
>>> variant every source file is written for. Compared to before, it means
>>> that addr_type will now vary per tb translation, where it was constant
>>> for a given target previously.
>>>
>>> Instead of introducing a new parameter to translator_loop(), we simply
>>> add this information in TCGTBCPUState, which is returned by
>>> get_tb_cpu_state() during the translation, and passed down to
>>> tb_gen_code().
>>>
>>> To avoid modifying all target with this new field, we simply define a
>>> default value that is equivalent to current state: use
>>> target_long_bits(). With this, we can progressively convert new
>>> architectures.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    include/accel/tcg/tb-cpu-state.h | 12 ++++++++++++
>>>    accel/tcg/translate-all.c        | 15 ++++++++++++++-
>>>    2 files changed, 26 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/accel/tcg/tb-cpu-state.h b/include/accel/tcg/tb-cpu-state.h
>>> index 8f912900ca6..b77c4dd5100 100644
>>> --- a/include/accel/tcg/tb-cpu-state.h
>>> +++ b/include/accel/tcg/tb-cpu-state.h
>>> @@ -8,11 +8,23 @@
>>>    #include "exec/vaddr.h"
>>> +/*
>>> + * Default value 0 means to refer to target_long_bits(). It allows to stay
>>> + * compatible with architectures that don't yet have varying definition of TCGv
>>> + * depending on execution mode.
>>> + */
>>> +typedef enum TCGvType {
>>> +    TCGV_TYPE_TARGET_LONG = 0,
>>> +    TCGV_TYPE_I32,
>>> +    TCGV_TYPE_I64,
>>> +} TCGvType;
>>> +
>>>    typedef struct TCGTBCPUState {
>>>        vaddr pc;
>>>        uint32_t flags;
>>>        uint32_t cflags;
>>>        uint64_t cs_base;
>>> +    TCGvType tcgv_type;
>>>    } TCGTBCPUState;
>>
>> No need for this.  This state is already present in flags, in a target-specific manner.
>> If you actually needed this information, you'd want a new target hook.  However...
>>
>>> @@ -316,7 +329,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s)
>>>        }
>>>        tcg_ctx->gen_tb = tb;
>>> -    tcg_ctx->addr_type = target_long_bits() == 32 ? TCG_TYPE_I32 : TCG_TYPE_I64;
>>> +    tcg_ctx->addr_type = tcgv_type_to_tcg_type(s.tcgv_type);
>>
>> I did mention in our discussion that it would be best to set this in translator_loop()
>> instead, via a new parameter.
>>
> 
> I went through this, and noticed that crossing layers was not really better than having it 
> there. TCGTBCPUState looked like the best place for it.

It really isn't.  TCGTBCPUState is used for TB hashtable lookup.
You've added something to the type that is unrelated.


r~


> Now if you really prefer having a translator_loop parameter, I don't mind. It will just 
> need a patch for all existing arch.
> 
>> This makes it trivial for target/arm/tcg/translate.c to simply tell us that TCG_TYPE_I32
>> is correct, for target/arm/tcg/translate-a64.c to specify TCG_TYPE_I64, and for all other
>> users to use TCG_TYPE_TL.
>>
>>
>> r~
> 


