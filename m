Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FAC2FED2F9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 10:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0cym-0002pY-1e; Thu, 12 Mar 2026 06:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0cyj-0002oU-99
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 06:09:17 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0cyh-0002or-9M
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 06:09:16 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439cb5af25bso862152f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 03:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773310153; x=1773914953; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B+K0I9JQpvSsWfwMN5Wwpc4BJ9j/WPXcxBGnkjFOL84=;
 b=Y8fEUw59g3DeM4Rmy4ymjsO4J4peZrxQWp/IDbOKaAaWxnm5BYhzbrnnzh1E0jgS+T
 iCxKETEXjEcna6o7KidvZAXZ7nObxI/HxvSNdW9NW8lbk5wRO0IIoPzZBAQuxuZ25hoW
 u348S3JFS+l3/MDarm3pjWCyGcxQQPQaglAFn+yitRQWAF7jUiJFQtV+5JcJdFK+3qSa
 khwCvL3HDkXqHA0D+zEPzNCSvkpmp5muore29mLa2CGEGDnMMqZL5yXuTSPsuyaQkHEu
 D18l0jAwYx5ZbOipKiAI9MHQPttFGva4Cjjf95FCIINKmqLMl+bgvvdClVeTPkML5V6C
 1JDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773310153; x=1773914953;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B+K0I9JQpvSsWfwMN5Wwpc4BJ9j/WPXcxBGnkjFOL84=;
 b=lDBxm4RKNpEdWgIOvbOJt/+L8gyiIZ8BDtK1Jt6Qyh8EOEkiitqFKzT0u+d9wfh773
 0drxJLqnzD1tSGltH800tLrwTa+nExaWGLlUWYt7nF6Zmc4Eq40E3cxvRz+zAOvurKgf
 F/+v1f1hKVvrxmZDpY2WT847OXRJ5qBy3pUD1wcGSaZRScesj2V+AL57DTDEVxchU+z/
 R1nXR+rTuT1xete3elz6q02+sQxPNS7+d5AVGbC5lbFSnICMkCwJ29kMqFqJrIV75/Er
 iEUVZDGYFPXIChQPBFEE5c82o81XbR4wliNvLN5BgIcfHMKHaGI4Lziw2odtL7z68Qn1
 AGhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa/uo2CdqKlfnoKV02LGwqBtrPSoGAIiS3JgrfJVr41tBT0MbeYOwmoNq6q5h5glp9JcL0hpFLazSq@nongnu.org
X-Gm-Message-State: AOJu0YwoP36PnTh9ISPpEHSCq7j59dS8xzu0flMcqx8T7H5G4tfKzCWx
 9f5Fj/EV1caJGu53k6eTBQZOIGWZZwHxjHY51/HQxIqDBjzq7WveGQwzYRuKs5yOS7E=
X-Gm-Gg: ATEYQzw9rs3Br+w4i5vIU1dLNudliBfERyzYek+7HtAooib0qKZJAqmlg/UOFC81nZ9
 9ZsCSYkosgmmh787MsF5aQa50cYNDuYpVal42/1UAYT/OJGc7R4tDA0H5Zxo/vlprio45sb394h
 VIhZWfYqJ9ElpCaxKX2dpn07hf7h9wfcwBJpwhBsX6ybcTbGJ4Dnx0WzdNCArsSIfrHkgfAUk/b
 fGE3R9xAE+gkPJoFwHjVbQhuOrAOfrC3JP+DFQNz0wo8Brno8qvnANiOwxcs1QVRg2wZOgauJvi
 nnk2++HEFhZRLwCsdbB2CiwKesx7AUk3AwOW/UefE1Wzi0XSGmm7q/WoF5t2lnAEsmrRG7eeKQG
 EcoJ5AvgcfSc5F+aDIDUPnmZWdu9o13AM0uuTdeuY/MDImjn4oRHqdXg3id9B9OORMU54p/PUKl
 bhykU+kfy5p99AFu8DH7Yas3f54kDa4S61DEmP9rTfHBdMJ22MwuFWPo+fTwkssl8syw==
X-Received: by 2002:a05:6000:1a8c:b0:439:eec5:e058 with SMTP id
 ffacd0b85a97d-439f843c54dmr10978600f8f.58.1773310153532; 
 Thu, 12 Mar 2026 03:09:13 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe19b936sm8343317f8f.5.2026.03.12.03.09.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 03:09:11 -0700 (PDT)
Message-ID: <d0a210fa-e88b-49f2-a038-5d089ec0ae12@linaro.org>
Date: Thu, 12 Mar 2026 11:09:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/xtensa/cpu: Move initialization of memory region
 to realize function
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260311202503.107026-1-thuth@redhat.com>
 <87y0jxzdrk.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87y0jxzdrk.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 12/3/26 08:51, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> From: Thomas Huth <thuth@redhat.com>
>>
>> When introspecting the xtensa CPUs from the command line, QEMU currently
>> crashes:
>>
>>   $ ./qemu-system-xtensa -device dc233c-xtensa-cpu,help
>>   qemu-system-xtensa: ../../devel/qemu/system/physmem.c:1401:
>>    register_multipage: Assertion `num_pages' failed.
>>   Aborted (core dumped)
>>
>> Move the initialization of the memory regions to the realize function
>> to fix this problem.
>>
>> Reported-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> Looking a bit closer at the code leading to the assertion failure:
> TARGET_PAGE_BITS (macro expanding to target_page.bits) is still zero.
> Hmm.  Is this a regression?  If yes, could there be more invalid uses of
> TARGET_PAGE_BITS we haven't discovered, yet?  I guess they'd also be
> relatively safe, as TARGET_PAGE_BITS becomes valid before things get
> spicy, i.e. before the guest runs.
> 
> I tested v10.2.0, and it also crashes, but the assertion differs:
> 
>      qemu-system-xtensa: ../system/physmem.c:1337: phys_section_add: Assertion `map->sections_nb < TARGET_PAGE_SIZE' failed.
> 
> So, if it's a regression, it's not a recent one.
> 
> Another interesting detail is how TARGET_PAGE_BITS is defined:
> 
>      #ifdef TARGET_PAGE_BITS_VARY
>      [...]
>      # ifdef CONFIG_DEBUG_TCG
>      #  define TARGET_PAGE_BITS   ({ assert(target_page.decided); \
>                                      target_page.bits; })
> 
> Here, we assert it's valid.
> 
>      [...]
>      # else
>      #  define TARGET_PAGE_BITS   target_page.bits
> 
> Here, we just trust it.  I guess because the assertion above is
> too expensive.
> 
>      [...]
>      #else
> 
> And here it seems to be pulled from elsewhere.  The possible elsewheres
> seem to be target/$target/cpu-param.h, which #define it as an integer
> literal.
> 
>      [...]
>      #endif
> 
> Cc'ing Richard, who has worked in the TARGET_PAGE_BITS area.  Just fyi,
> Richard, I'm not asking you for further input.

Correct analysis, I'll have a look.

> 
>> ---
>>   target/xtensa/cpu.c | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
>> index 86ec899a67c..eebf40559bc 100644
>> --- a/target/xtensa/cpu.c
>> +++ b/target/xtensa/cpu.c
>> @@ -244,6 +244,14 @@ static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
>>       Error *local_err = NULL;
>>   
>>   #ifndef CONFIG_USER_ONLY
>> +    CPUXtensaState *env = &XTENSA_CPU(dev)->env;
>> +
>> +    env->address_space_er = g_malloc(sizeof(*env->address_space_er));
>> +    env->system_er = g_malloc(sizeof(*env->system_er));
>> +    memory_region_init_io(env->system_er, OBJECT(dev), NULL, env, "er",
>> +                          UINT64_C(0x100000000));
>> +    address_space_init(env->address_space_er, env->system_er, "ER");
>> +
>>       xtensa_irq_init(&XTENSA_CPU(dev)->env);
>>   #endif
>>   
>> @@ -269,12 +277,6 @@ static void xtensa_cpu_initfn(Object *obj)
>>       env->config = xcc->config;
>>   
>>   #ifndef CONFIG_USER_ONLY
>> -    env->address_space_er = g_malloc(sizeof(*env->address_space_er));
>> -    env->system_er = g_malloc(sizeof(*env->system_er));
>> -    memory_region_init_io(env->system_er, obj, NULL, env, "er",
>> -                          UINT64_C(0x100000000));
>> -    address_space_init(env->address_space_er, env->system_er, "ER");
>> -
>>       cpu->clock = qdev_init_clock_in(DEVICE(obj), "clk-in", NULL, cpu, 0);
>>       clock_set_hz(cpu->clock, env->config->clock_freq_khz * 1000);
>>   #endif
> 
> Fixes the crash for all xtensa CPUs.
> 
> Tested-by: Markus Armbruster <armbru@redhat.com>
> 
> 


