Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77DAC3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 21:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9sAu-0000UA-2w; Tue, 29 Apr 2025 17:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9sAZ-0000L5-M2
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 17:07:11 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9sAW-0003zN-Qi
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 17:07:11 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736c062b1f5so5602884b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 14:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745960825; x=1746565625; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J0R7aQy+3GY23ZMFehDXTfzL4PuUym9QxuFfe3VQUYA=;
 b=F0WO2x/uPF5ERNLWJVAwilfmz2Uc/GF7a3iKCY1zKZptxXeYKXSQ/NJQnetlvQ/4r/
 mRfJtB7kw+N44Vg2dQ9CF+dFJ6BL8u4Tl0fIIJHxFZTAxqUMT+Z0QhELLRFwvKbBamYa
 Bj95fXBwN5JctNXeqG3YmbdYwAbktfLzkRiF2FZJ6OKpSDyH6HjLvQ+P9cv5kPG2m5En
 iRugD9pvivDWk5vgEqfFfRy9mz9R5v+HB9jmrkSCFcCY+SytST4r1AHF6+npH5ZSg9jI
 kqw/yoOtD+EyB7nJaAJM41sMm6kU9cdkoNZnX1nPkZ0YbQHp+SE31rkG93FSIZ2Ok/8h
 FXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745960825; x=1746565625;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J0R7aQy+3GY23ZMFehDXTfzL4PuUym9QxuFfe3VQUYA=;
 b=lA4awQRBiZUdT4HNtuvzfhxdSxTo04A2uPOdV3WCQWyrH+0vd4H9wp05YOVdOyblbh
 X+GXFZe94VAXbBL5Ap+ue7XzfL8rkXG4m0fqLFLG12NVBwr2qOa5gAipfFRYX4UDc2aB
 iPQNnMBK8l4eHwn5GYlc+/oSmVWLdkZjrWOR0CqMAFKWZ7V/6W5exrZw1jEhOQMWPDFY
 rv0CcyWgrn9VSjcjuMFufbelbGV5AMvH3/rSKSxLOtcXSJ7tONxwgF+oAAWeb6QkPXUn
 JUinMize+lXWk9N37zIfuOGAjUnt3YPsjhD/ylu5Ndlx7/R+3+zqRJkkzE9G2VhGhgWD
 6LkA==
X-Gm-Message-State: AOJu0Yzo7gO9RqGYCp0gg2ILwrT599tO7qg3IteyfIXtH5XyHEKQdNdz
 bnqvjhS/T21SdJWjWEVZsbRHRU59+ukAgDVfnVJRZ4GJqvZWSU4Tg80oJevN4NI=
X-Gm-Gg: ASbGnct3XKxRfJiuWLb+E0SFvKFeQNk42eMDg5kghbVYAwRIM68wMadEK7OXKw1WpHa
 geY6HHw3Fpn7idYLGJ1GwxJLr+MTmvh/uMhA8Yng+ww7sO47uEIOKRe62i/IXZjgQU+0T935fDF
 NYGHlbjw4esRnODtJ7hA5hHs4jlbJyoWJn2AxMPmJ3DlCbdcS6opLDwzOC86bdks1NKNEzDxTFB
 4nKBwo+NMi4AYu+e3h6yBMJxeKHnpxYK0bN2xv/j0/xHq9wT1LquxAkXmkiV5s+3w6xBob1TGKI
 FrYT+TOXS7SC7i9QbRSDtIU5lTrLK2j9CZ1/1iH9SqLnMyF3ci0Jyg==
X-Google-Smtp-Source: AGHT+IH32wV8hOys1/FlSKA99ZrcKLdxQ/jVjCKspBhTfIoQlbisbUoYD7FByxZw5MrxgeqxouXjtA==
X-Received: by 2002:a05:6a00:10ce:b0:739:56c2:b661 with SMTP id
 d2e1a72fcca58-740389b795bmr898455b3a.12.1745960824759; 
 Tue, 29 Apr 2025 14:07:04 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74039a5c36bsm146946b3a.132.2025.04.29.14.07.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 14:07:04 -0700 (PDT)
Message-ID: <6e628189-f497-4d95-a6ac-c3cc726be2ad@linaro.org>
Date: Tue, 29 Apr 2025 14:07:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] target/arm/cpu: get endianness from cpu state
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, richard.henderson@linaro.org
References: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
 <20250429050010.971128-10-pierrick.bouvier@linaro.org>
 <bwdflzaiqdpq33uzowvrgjbha3wye6k74puwur755pq27z67eu@mnc2ze4it5cl>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <bwdflzaiqdpq33uzowvrgjbha3wye6k74puwur755pq27z67eu@mnc2ze4it5cl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/29/25 5:26 AM, Anton Johansson wrote:
> On 29/04/25, Pierrick Bouvier wrote:
>> Remove TARGET_BIG_ENDIAN dependency.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   target/arm/cpu.c | 22 +++++++++++-----------
>>   1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index e7a15ade8b4..85e886944f6 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -67,6 +67,15 @@ static void arm_cpu_set_pc(CPUState *cs, vaddr value)
>>       }
>>   }
>>   
>> +static bool arm_cpu_is_big_endian(CPUState *cs)
>> +{
>> +    ARMCPU *cpu = ARM_CPU(cs);
>> +    CPUARMState *env = &cpu->env;
>> +
>> +    cpu_synchronize_state(cs);
>> +    return arm_cpu_data_is_big_endian(env);
>> +}
>> +
>>   static vaddr arm_cpu_get_pc(CPUState *cs)
>>   {
>>       ARMCPU *cpu = ARM_CPU(cs);
>> @@ -1130,15 +1139,6 @@ static void arm_cpu_kvm_set_irq(void *opaque, int irq, int level)
>>   #endif
>>   }
>>   
>> -static bool arm_cpu_virtio_is_big_endian(CPUState *cs)
>> -{
>> -    ARMCPU *cpu = ARM_CPU(cs);
>> -    CPUARMState *env = &cpu->env;
>> -
>> -    cpu_synchronize_state(cs);
>> -    return arm_cpu_data_is_big_endian(env);
>> -}
>> -
>>   #ifdef CONFIG_TCG
>>   bool arm_cpu_exec_halt(CPUState *cs)
>>   {
>> @@ -1203,7 +1203,7 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
>>   
>>       info->endian = BFD_ENDIAN_LITTLE;
>>       if (bswap_code(sctlr_b)) {
>> -        info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
>> +        info->endian = arm_cpu_is_big_endian(cpu) ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
>>       }
> 
> I'm not the most familiar with arm but as far as I can tell these are
> not equivalent. My understanding is that arm_cpu_is_big_endian() models
> data endianness, and TARGET_BIG_ENDIAN instruction endianness.
> 
> Also, for user mode where this branch is relevant, bswap_code() still
> depends on TARGET_BIG_ENDIAN anyway and the above branch would reduce to
> (on arm32)
> 
>    if (TARGET_BIG_ENDIAN ^ sctlr_b) {
>        info->endian = sctlr_b ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
>    }
> 
> giving the opposite result to the original code.
> 

Ooops, that's a good point, I missed it was calling 
arm_cpu_data_is_big_endian under the hoods.

I'll stick to target_big_endian().

Thanks,
Pierrick

