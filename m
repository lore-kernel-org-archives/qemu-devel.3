Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7F3C369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WCE-0007bZ-Bd; Wed, 23 Apr 2025 05:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7WC5-0007aZ-2V
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:15:01 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7WC2-0005Np-Rf
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:15:00 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3912d2c89ecso5122928f8f.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745399696; x=1746004496; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qD+Hk2O+UTLEkOtMhFkCbVQrFG5eQW5OZ78ETJvPimw=;
 b=KVat75T6G2jre3yylnYo4nCKPu3Y4iPXNTwKfTM3MC46DknsILbq0MyXw3y6ITzefy
 mDcDyMxIvNGJ3SqbcYMvDrgBXjxwdJwJeYrTgMSJYBaLLugR15Rqc74ZguDfAFHT/ZpV
 DOCyv3J8XtDums8Ah+/c//AiDb/8XRqOlRbRGRT4pdzmGemoz1hlphp2RQZRMf9x/+lr
 PjJsmcINNTVqD4ALbAfVst8NpN8J7zYtgmYJiGdHRgug0ZhvNcnRZuq3qWX5C+bJn9hR
 OosROCxRaUwYDwXsqP0s+TDAK7UqvkmSQvGCpsS/u9HreylL3pfNBVXOPEFG4KDP2KHG
 +2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745399696; x=1746004496;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qD+Hk2O+UTLEkOtMhFkCbVQrFG5eQW5OZ78ETJvPimw=;
 b=Pe4dDW8/AiaagvkCezIR9hwvfRuFK7Vu5Icxd7yLfsAmL7cNHTTE+zgb5t7oQPHZQv
 sRDZeU5FrbFlRr/nXux9iBaxNhyWrOPyHl2yfK4cQaw0xpUNbuI9yWr/CSav3J9lbbaN
 Z7lgRgWaNBVy6tn0GecEWcFq9N99w2OZXigPoK5qaj1YIiUhUZkzVZpAT1DUmwacLCqF
 Ldu5dUcBuqo+NE+Kk3MzIOouUvrAwe/SEI6reoduXrfkUcJoXjamO/iOCjRWdIIVM/1V
 ZdYAjYzMFpHPHj5YbPMjicADsd+EYJFoabwYvVD2v5Rwf+yavyXyugyam7PnxfVWMPJ2
 e73A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSpEm9nS8snt8ObZt4GCTo2kTkxPW4v7Kz6khYa7SHtDcfNgKBZO6Romo/vyShfatIPPPTwDMBYoSG@nongnu.org
X-Gm-Message-State: AOJu0YzUS8F4TaSKWpA+Fr1K6ZowwmA3KcqsOnon4Jjjmu61jEDykPWO
 RwLgmTqWIidC0v03+HpLLVjDtQCUTR4iEGT5xYom+Kto9eDYSiHsgH5ZEZoIAqk=
X-Gm-Gg: ASbGncvAHwhfmSTX9c8wohLwwqVnkelw6GAh3aR1ISPAPnya73q/F0am0xIdDki4zV3
 eNXEw+LlPgGPQUMu2mcdE7ZBCIWvGRwDyyBh4SEVrjHjMGXmm2u+3ARD6nl1HPH2HS5+mZEhiMW
 EpvwE9j163PtqkBMVSvQZ5/uhUyiMfm2b0oopDbPSYlDCo/HVwRu8nPCH3S4wOcDv0wBWCngFkg
 V7cZrPP1IyqdLXzgDFconahh5dJ1oVMApFotNNH9HG9EwYPbvM7tZRkIEBK9q9DUk7hUEd4modP
 noBJmcbxx8Gq8J9+ez8ufxjFaVFxt/K36XFaE3ro/e+gu2wJf5bn8f40IqK1fghIxJsP0DQv3Am
 VseUf3icr
X-Google-Smtp-Source: AGHT+IEt4CiH9B3eR9wvXxhpTaBfapDcXQXIFXb8qTLE8QOsmyqWJ4m408ZK254sy5vbE1G0wWFDtg==
X-Received: by 2002:a5d:47ab:0:b0:39c:142a:ed6c with SMTP id
 ffacd0b85a97d-39efbad3df4mr15924691f8f.40.1745399696450; 
 Wed, 23 Apr 2025 02:14:56 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4a4c8fsm17720944f8f.89.2025.04.23.02.14.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 02:14:55 -0700 (PDT)
Message-ID: <9d811c1d-7431-4348-9252-37c412593556@linaro.org>
Date: Wed, 23 Apr 2025 11:14:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 14/19] qemu/target_info: Add %target_arch field to
 TargetInfo
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Markus Armbruster <armbru@redhat.com>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-15-philmd@linaro.org>
 <cc5114fe-c17d-4e02-96f2-135ee1c7fa09@linaro.org>
 <a8a701b4-9da5-45d1-88e2-6a708b425146@linaro.org>
 <5c3cebf7-665d-4c07-97d8-cf913e78c3f0@linaro.org>
 <65ae1a3d-0376-4b66-8354-227303d8b90c@linaro.org>
 <7c1d7d7b-f58d-40f6-9a1b-c80231681b89@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7c1d7d7b-f58d-40f6-9a1b-c80231681b89@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 23/4/25 08:24, Pierrick Bouvier wrote:
> On 4/22/25 22:34, Philippe Mathieu-Daudé wrote:
>> On 22/4/25 20:30, Pierrick Bouvier wrote:
>>> On 4/22/25 11:24, Philippe Mathieu-Daudé wrote:
>>>> On 22/4/25 20:20, Pierrick Bouvier wrote:
>>>>> On 4/22/25 07:54, Philippe Mathieu-Daudé wrote:
>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>> ---
>>>>>>     include/qemu/target-info-impl.h   | 4 ++++
>>>>>>     configs/targets/aarch64-softmmu.c | 1 +
>>>>>>     configs/targets/arm-softmmu.c     | 1 +
>>>>>>     target-info-stub.c                | 1 +
>>>>>>     4 files changed, 7 insertions(+)
>>>>>>
>>>>>> diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-
>>>>>> info-impl.h
>>>>>> index 4ef54c5136a..e5cd169b49a 100644
>>>>>> --- a/include/qemu/target-info-impl.h
>>>>>> +++ b/include/qemu/target-info-impl.h
>>>>>> @@ -10,12 +10,16 @@
>>>>>>     #define QEMU_TARGET_INFO_IMPL_H
>>>>>>     #include "qemu/target-info.h"
>>>>>> +#include "qapi/qapi-types-machine.h"
>>>>>>     typedef struct TargetInfo {
>>>>>>         /* runtime equivalent of TARGET_NAME definition */
>>>>>>         const char *const target_name;
>>>>>> +    /* related to TARGET_ARCH definition */
>>>>>> +    SysEmuTarget target_arch;
>>>>>> +
>>>>>>         /* QOM typename machines for this binary must implement */
>>>>>>         const char *const machine_typename;
>>>>>> diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/
>>>>>> aarch64-softmmu.c
>>>>>> index 375e6fa0b7b..ff89401ea34 100644
>>>>>> --- a/configs/targets/aarch64-softmmu.c
>>>>>> +++ b/configs/targets/aarch64-softmmu.c
>>>>>> @@ -13,6 +13,7 @@
>>>>>>     static const TargetInfo target_info_aarch64_system = {
>>>>>>         .target_name = "aarch64",
>>>>>> +    .target_arch = SYS_EMU_TARGET_AARCH64,
>>>>>>         .machine_typename = TYPE_TARGET_AARCH64_MACHINE,
>>>>>>     };
>>>>>> diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm-
>>>>>> softmmu.c
>>>>>> index d4acdae64f3..22ec9e4faa3 100644
>>>>>> --- a/configs/targets/arm-softmmu.c
>>>>>> +++ b/configs/targets/arm-softmmu.c
>>>>>> @@ -13,6 +13,7 @@
>>>>>>     static const TargetInfo target_info_arm_system = {
>>>>>>         .target_name = "arm",
>>>>>> +    .target_arch = SYS_EMU_TARGET_ARM,
>>>>>>         .machine_typename = TYPE_TARGET_ARM_MACHINE,
>>>>>>     };
>>>>>> diff --git a/target-info-stub.c b/target-info-stub.c
>>>>>> index 218e5898e7f..e573f5c1975 100644
>>>>>> --- a/target-info-stub.c
>>>>>> +++ b/target-info-stub.c
>>>>>> @@ -12,6 +12,7 @@
>>>>>>     static const TargetInfo target_info_stub = {
>>>>>>         .target_name = TARGET_NAME,
>>>>>> +    .target_arch = -1,
>>>>>
>>>>> I think we should have a full ifdef ladder here, to handle all
>>>>> architectures. Setting -1 is not a safe default.
>>>>
>>>> TargetInfo definition is internal to "qemu/target-info-impl.h",
>>>> otherwise its type is forward-declared as opaque.
>>>>
>>>
>>> Fine, but we need to be able to access to target_arch(), which returns
>>> the enum value, without having to deal with -1 situation, which is not a
>>> proper enum value.
>>>
>>> switch (target_arch()) {
>>> case SYS_EMU_TARGET_ARM:
>>> case SYS_EMU_TARGET_AARCH64:
>>> ...
>>> default:
>>>       break;
>>> }
>>
>> I didn't mentioned that because in
>> https://lore.kernel.org/qemu-devel/3242cee6-7485-4958- 
>> a198-38d0fc68e8cd@linaro.org/
>> you said:
>>
>>     At this point, I would like to focus on having a first version of
>>     TargetInfo API, and not reviewing any other changes, as things may
>>     be modified, and they would need to be reviewed again. It's hard
>>     to follow the same abstraction done multiple times in multiple 
>> series.
>>
>> What is your "full ifdef ladder" suggestion to avoid -1?
> 
> #ifdef TARGET_AARCH64
> # define TARGET_ARCH SYS_EMU_TARGET_AARCH64
> #elif TARGET_ARCH_ALPHA
> # define TARGET_ARCH SYS_EMU_TARGET_ALPHA
> ...
> #else
> #error Target architecture can't be detected

I'm sorry but I don't understand what we gain doing that.

> #endif
> 
> static const TargetInfo target_info_stub = {
>       ...
>       .target_arch = TARGET_ARCH;
>       ...
> }
> 
> One important stuff is to make sure we treat correctly bitness variants 
> of a given arch: TARGET_AARCH64 should be tested *before* TARGET_ARM, 
> and same for other base architectures.

Thankfully we don't check for TARGET_ARM, so we don't have to
implement a confusing target_arm() helper for the single-binary effort.

When we get to heterogeneous emulation, I expect system ARM/Aarch64 to
be merged as a single Aarch64 target (32-bit ARM being a CPU state), so
the target_aarch64() should still be enough.

> Besides that, it's straightforward, and we can easily integrate that in 
> this series.


