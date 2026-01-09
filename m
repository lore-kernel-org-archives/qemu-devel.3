Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA688D277C1
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 22:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veL09-0002wk-6E; Fri, 09 Jan 2026 17:30:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1veL07-0002wP-MQ
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 17:30:35 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1veL06-0000xu-3B
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 17:30:35 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-81345800791so2515918b3a.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 14:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767997833; x=1768602633; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sW332LLE7l+2cMlX/GQFJAG8A+GZO9XErWOYwgaJiXo=;
 b=w+GCcthNvOq45araeHJGBuFkhdp/Ox6lwXQxDRGgYONSaYhC1R1XJOHNgRuWrFPHNE
 2OqsR0g1SzJodJEqI1foMZpsg8MZ79+pO+xgSQkj/nispwMgNc9M3eHF8+jNxNS6R/RU
 Ij1nzC2EciSModsV8+FzYA2vA6fSlBSybwQEjFVZuxEcqg+yUH9gzjp9/+pKTgqxpviD
 1Rho+I8bObImv8jwAUM11vBRtBSgwhcjcJ1kW8wizZP7VHq58gWbyDgFzzCjufNWVZ0N
 qYty0kEm5PIKCTtN7vtYD1N0UFabJxWaFJ3fLx6+w92Zr/oRRTj9D+qGRBzTg4eup/Vl
 egbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767997833; x=1768602633;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sW332LLE7l+2cMlX/GQFJAG8A+GZO9XErWOYwgaJiXo=;
 b=Rnu+VAvpNI+UC0/H3wIqINvhlDDUsMj6h1gXILAUMF/sivZciC9qcXGwzZ6pqa1/WL
 V43ZRVjwRw95DKKqUNQFQ/Ey0EMOjiblhVndiQiHUTdm02J6mF+WioAHipoy5K7XHdb1
 81Mh13tBQsI1OyYAirnjs479qi09gammgfuM9S2jm5ObAfrPkEdM6RrA99Bl2UdYMwf7
 TJ7lf1XXIhf7BqFInklnpKDXinH6l9nh1zv439cBOjut2Ywixu8Jpj90iz8gMAROyANt
 nf8GpkINbQHIuD4eJdTqotpODhzbZszntvXPDpoQ2/UwQPxTvurTtgDQrMknkBqV8KC0
 8hSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJBmV3dbPm802B2Z1+fXFJpPndyLU9CPsEWKaq8OZ9juFvnycSFqBH1mKIG4Ykv2urmIS1nssuo7Vb@nongnu.org
X-Gm-Message-State: AOJu0YzbQqE/l7D3BC0uvA7DqjEBkcQ0vijD1NZ/f+XZ99kXHIch9DfO
 Bftg+rrTHpyMmnASevebJQDxujqhDihBm0He0Tj+i/cwrCjAryXyHis8Kj2trRGRYOM=
X-Gm-Gg: AY/fxX7b7mT6D1aQ+2d6g4w7mflIcKNXMAZgslfZgrxsvVj0+HFkZ9K9Q9KCC4H6HLM
 sb9Dq6MASgUl2hfcAEyoTIebFQC5OEIKL/LpagqFN+MCnWWROGiEjId6tXOs4uyLnmT2uKcMqjo
 nJ0yS6uXv/3BaBzvh1ORJjFxBPHSGxFKlaxpuiUGuf4ON3TxXF0vVtijxwgyNvOQzBdbbwkGGCJ
 DsbLGv+cnp6bcc6rTvAEp7iuy4S7AqpVgczcC944D06xfFJ67fMWnTHxwGK/T9sQSZG2hWpVvPR
 XmQfEtdVrN4eqxNSbpKiCr/cOdMPgW685ZZXfUI4BNtdC9d+KmihJL4LGUggeFiFDN4rqvuIGkX
 V5s/VLqKfOE+v+yKbvbC8nw149mg90ufKZyn/nH0s4CWUX0efxIWb2dENNpVv+BscLf9zTeNAFr
 btNV9nnc8pQpDw4qNgMKhdnDFem6RfLENqJMVY86t05vXnou92GOnC2Bp8U+GxKM4R764=
X-Google-Smtp-Source: AGHT+IFwhot1T7rMl75XIBbnDSWGkfccZ6XihTiBA62QixTqvNebQLXfavHJuTgCU0YypFAycn5TNg==
X-Received: by 2002:a05:6a00:f9a:b0:819:9daf:a40e with SMTP id
 d2e1a72fcca58-81b7f6df1c1mr9071769b3a.46.1767997832471; 
 Fri, 09 Jan 2026 14:30:32 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819c52fd904sm11230981b3a.33.2026.01.09.14.30.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 14:30:32 -0800 (PST)
Message-ID: <0e158c01-3150-43f3-a78a-d77e8b07bc9f@linaro.org>
Date: Fri, 9 Jan 2026 14:30:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/29] accel/tcg/translate-all.c: detect addr_type
 dynamically
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-16-pierrick.bouvier@linaro.org>
 <7fcbddf8-46be-449f-ac20-1caba498be32@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <7fcbddf8-46be-449f-ac20-1caba498be32@linaro.org>
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

On 1/9/26 2:13 PM, Richard Henderson wrote:
> On 1/9/26 16:31, Pierrick Bouvier wrote:
>> With TARGET_ADDRESS_BITS mechanism, it's now possible to specify which
>> variant every source file is written for. Compared to before, it means
>> that addr_type will now vary per tb translation, where it was constant
>> for a given target previously.
>>
>> Instead of introducing a new parameter to translator_loop(), we simply
>> add this information in TCGTBCPUState, which is returned by
>> get_tb_cpu_state() during the translation, and passed down to
>> tb_gen_code().
>>
>> To avoid modifying all target with this new field, we simply define a
>> default value that is equivalent to current state: use
>> target_long_bits(). With this, we can progressively convert new
>> architectures.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    include/accel/tcg/tb-cpu-state.h | 12 ++++++++++++
>>    accel/tcg/translate-all.c        | 15 ++++++++++++++-
>>    2 files changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/accel/tcg/tb-cpu-state.h b/include/accel/tcg/tb-cpu-state.h
>> index 8f912900ca6..b77c4dd5100 100644
>> --- a/include/accel/tcg/tb-cpu-state.h
>> +++ b/include/accel/tcg/tb-cpu-state.h
>> @@ -8,11 +8,23 @@
>>    
>>    #include "exec/vaddr.h"
>>    
>> +/*
>> + * Default value 0 means to refer to target_long_bits(). It allows to stay
>> + * compatible with architectures that don't yet have varying definition of TCGv
>> + * depending on execution mode.
>> + */
>> +typedef enum TCGvType {
>> +    TCGV_TYPE_TARGET_LONG = 0,
>> +    TCGV_TYPE_I32,
>> +    TCGV_TYPE_I64,
>> +} TCGvType;
>> +
>>    typedef struct TCGTBCPUState {
>>        vaddr pc;
>>        uint32_t flags;
>>        uint32_t cflags;
>>        uint64_t cs_base;
>> +    TCGvType tcgv_type;
>>    } TCGTBCPUState;
> 
> No need for this.  This state is already present in flags, in a target-specific manner.
> If you actually needed this information, you'd want a new target hook.  However...
> 
>> @@ -316,7 +329,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s)
>>        }
>>    
>>        tcg_ctx->gen_tb = tb;
>> -    tcg_ctx->addr_type = target_long_bits() == 32 ? TCG_TYPE_I32 : TCG_TYPE_I64;
>> +    tcg_ctx->addr_type = tcgv_type_to_tcg_type(s.tcgv_type);
> 
> I did mention in our discussion that it would be best to set this in translator_loop()
> instead, via a new parameter.
> 

I went through this, and noticed that crossing layers was not really 
better than having it there. TCGTBCPUState looked like the best place 
for it.
Now if you really prefer having a translator_loop parameter, I don't 
mind. It will just need a patch for all existing arch.

> This makes it trivial for target/arm/tcg/translate.c to simply tell us that TCG_TYPE_I32
> is correct, for target/arm/tcg/translate-a64.c to specify TCG_TYPE_I64, and for all other
> users to use TCG_TYPE_TL.
>
> 
> r~


