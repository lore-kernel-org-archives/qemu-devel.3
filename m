Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB95C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 22:06:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0pA4-0005Ym-Pr; Fri, 04 Apr 2025 18:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0p9z-0005Xe-Uv
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 18:05:12 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0p9y-0004BG-31
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 18:05:11 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so24878295e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 15:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743804307; x=1744409107; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jYPWtbIr2RreJIoQ2FNXV/aZn9R26gEtjM1ig+1/RT0=;
 b=uiAKU8VEoGkedU+1dUIxcuPyJjHzE6Vy/K8+0eG4bvaL2VhdLmQ7rDBdutF4jCUL5v
 2LzsfIGtpgZv8CLpGzrumQgYSrThpFodZPa/5qkzFYzas9fmBtGWg21ZLq04KJKtGvbN
 Fi5WMkz1b5SrjFrsz/LKIrgcgJsU3VBjZK0BtoWEWw/UjsCIoF3oLxTi4xdp2+zccEAj
 jyE2JnsFQ2WhflUid2SR13ZjCjoLap0BIswakenI3PElNUwyUgdSyJERRol6DG+BW9s+
 nAfKzoMu4ZrF14gNk7ZoyYlxOzugA/4F9ilgs0R5/No/WhUCRq797CCgj1+H0K+KRwbQ
 47DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743804307; x=1744409107;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jYPWtbIr2RreJIoQ2FNXV/aZn9R26gEtjM1ig+1/RT0=;
 b=HHuodGst5Qfc9dwZsBgkyNdjdy3hZUjxtxbIuhDxC4PhbiPjx/TBaSqpN7t0uAERDC
 UQHSAUdradUr6WqL2U8zfLoRsIzyzgvvHfOw7OXVq+Kt+KGnYImhiPbvj/er9sbkg7OT
 2U8YxzqLz7ikihfyzIbzMukZ/s9KTVX3y5GnGOwxR2Yh5q6bEXhMP5FJX/gFgPWErIo2
 uzkoTkaiLrbWIcA6eldrkfr5ZFU8eEMwVNDWE3syJsxm424hBmlEz3xBavxMYs6yNEPH
 WnuE6FUrADNWI6AsR2+mhZk9PN2w8NtzCa9AT7oB40iHs/8SmE9/x2oRpEZdAujArefx
 dwNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0E1C1+O1PpSLXsxDJgTaEuo9XhV66aSqDwvwIeyoKryBa2MRYYt50LydU7U7bxGnLilE7jUr5naob@nongnu.org
X-Gm-Message-State: AOJu0Yw0dkqLDJu//NOlbwCW0ShrgOs8nwUftzzDu5NppUzCAvjBBoKC
 lJ3G/Id11YQy7oh3xJ4xUywKYhK3mbMdlgv36qOTKSVRx8x8RUqHYpbB57+4DqYtME4I/pmstuh
 k
X-Gm-Gg: ASbGnct5oRmjZ2t+P/UnC0kg/jusyxzTCYMI8PDAQqjVBRv2rpY9GiW1LLID98B9Wbv
 26NY+N6xm3wR+uZAvNBQmLIuxDoLe0V5c9Fx1muN6OebaOI70gqeFgdIAQaAxu3XhZAdsnEybdu
 +RWrezdXsy3sUBJKBNGQEQgSemO02JeNTq4MRZWoFQgWvpqtCSIvbwGLCz4nx1nusedryeSUSpv
 W8ajiNX3sefJx4n3adYyqUiQuhjJillhjeu3pxqjgMOxGHpg4x+76oFk20K5kKBnZcvfsyXPKaG
 d6+S4g8KeqyyKvQW2nOdmvevJ2yL4zTtRdVwk6NtrTsnUG2+BXpP7Soa+BBp0OlhO6xxSY5ahky
 Iq+1bnNrl336xH2xYcw==
X-Google-Smtp-Source: AGHT+IEEmOvyBOYeBtUOILmkYcuAO2PF7HY6FoLFE2IvA7YsVWcKKLbRInLlzKQsehyFDwTF2s/ofQ==
X-Received: by 2002:a05:6000:2489:b0:39a:c6c4:f87b with SMTP id
 ffacd0b85a97d-39c2e5f4ff3mr7771519f8f.5.1743804306969; 
 Fri, 04 Apr 2025 15:05:06 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec36699e0sm56565995e9.35.2025.04.04.15.05.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 15:05:06 -0700 (PDT)
Message-ID: <9844deec-cd50-4ff4-9bd5-5356c5e72150@linaro.org>
Date: Sat, 5 Apr 2025 00:05:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 35/39] hw/arm/virt: Replace TARGET_AARCH64 ->
 target_long_bits()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20250403235821.9909-1-philmd@linaro.org>
 <20250403235821.9909-36-philmd@linaro.org>
 <bd789a1e-b72d-4a9d-8730-e35cd3b2ffd7@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <bd789a1e-b72d-4a9d-8730-e35cd3b2ffd7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 4/4/25 20:28, Pierrick Bouvier wrote:
> On 4/3/25 16:58, Philippe Mathieu-Daudé wrote:
>> Replace the target-specific TARGET_AARCH64 definition
>> by a call to the generic target_long_bits() helper.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/arm/virt.c | 32 ++++++++++++++++----------------
>>   1 file changed, 16 insertions(+), 16 deletions(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index e241e71e1c3..a020f1bd581 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -3133,25 +3133,25 @@ static void 
>> virt_machine_class_init(ObjectClass *oc, void *data)
>>   #ifdef CONFIG_TCG
>>       machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex- 
>> a7"));
>>       machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex- 
>> a15"));
>> -#ifdef TARGET_AARCH64
>> -    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex- 
>> a35"));
>> -    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex- 
>> a55"));
>> -    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex- 
>> a72"));
>> -    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex- 
>> a76"));
>> -    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex- 
>> a710"));
>> -    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("a64fx"));
>> -    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("neoverse- 
>> n1"));
>> -    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("neoverse- 
>> v1"));
>> -    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("neoverse- 
>> n2"));
>> -#endif /* TARGET_AARCH64 */
>> +    if (target_long_bits() == 64) {
> 
> I would prefer if we introduce a true target_aarch64() function, and 
> probably the same for other architectures when it will be needed.
> 
> If we start using target_long_bits(), we might enable something in 
> common code that we are not supposed to do. And it will be much harder 
> to find it later when we debug heterogenenous emulation.

I get your point. Maybe we can register valid aa64 CPUs regardless,
and filter for registered QOM CPUs? OTOH your suggestion of
TARGET_AARCH64 -> target_aarch64() could be easier to review.
I''ll give it a try.

> 
>> +        machine_class_add_valid_cpu_type(mc, 
>> ARM_CPU_TYPE_NAME("cortex-a35"));
>> +        machine_class_add_valid_cpu_type(mc, 
>> ARM_CPU_TYPE_NAME("cortex-a55"));
>> +        machine_class_add_valid_cpu_type(mc, 
>> ARM_CPU_TYPE_NAME("cortex-a72"));
>> +        machine_class_add_valid_cpu_type(mc, 
>> ARM_CPU_TYPE_NAME("cortex-a76"));
>> +        machine_class_add_valid_cpu_type(mc, 
>> ARM_CPU_TYPE_NAME("cortex-a710"));
>> +        machine_class_add_valid_cpu_type(mc, 
>> ARM_CPU_TYPE_NAME("a64fx"));
>> +        machine_class_add_valid_cpu_type(mc, 
>> ARM_CPU_TYPE_NAME("neoverse-n1"));
>> +        machine_class_add_valid_cpu_type(mc, 
>> ARM_CPU_TYPE_NAME("neoverse-v1"));
>> +        machine_class_add_valid_cpu_type(mc, 
>> ARM_CPU_TYPE_NAME("neoverse-n2"));
>> +    }
>>   #endif /* CONFIG_TCG */
>> -#ifdef TARGET_AARCH64
>> -    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex- 
>> a53"));
>> -    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex- 
>> a57"));
>> +    if (target_long_bits() == 64) {
>> +        machine_class_add_valid_cpu_type(mc, 
>> ARM_CPU_TYPE_NAME("cortex-a53"));
>> +        machine_class_add_valid_cpu_type(mc, 
>> ARM_CPU_TYPE_NAME("cortex-a57"));
>>   #if defined(CONFIG_KVM) || defined(CONFIG_HVF)
>> -    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("host"));
>> +        machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("host"));
>>   #endif /* CONFIG_KVM || CONFIG_HVF */
>> -#endif /* TARGET_AARCH64 */
>> +    }
>>       machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("max"));
>>       mc->init = machvirt_init;
> 


