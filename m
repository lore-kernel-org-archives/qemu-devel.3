Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8940DC369CA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5p8u-0006VV-VJ; Fri, 18 Apr 2025 13:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5p8t-0006VL-NB
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:04:43 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5p8r-00058U-NE
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:04:43 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39c13fa05ebso1367893f8f.0
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744995880; x=1745600680; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NARtdtuew+2PXiCJtQc7ZhvHLBNpKTH8kvSBlgIZVbk=;
 b=Nz3miOJeG6b9TSsS7tpeqmx2Be+1c9/hRUj4V5dMAxM+FkvCqEac1LW6eKG7I2J9ak
 7szPjX+PKtUYeDaN1jZI0lvBVs6pNCMSS09TltCPpOV0bK7AnmozBsXLzIKHuOU0AJbm
 63Ycb5eGlfbptv44olurS1Nd4FsmmlgdlvCEBNs74B5jUXZ+ZOAG/3hgCMZDScgkj5Cb
 DBjlMBXKqn9E+KHIzXyLoMpTaBPgcxJRFPPe5excM/Jshle9p6k5w08UwYK3h0gt1AJg
 t4tk4acizVeyaVfOVYzJf9kQaY4yubItytAelHxk7YvFZWzW8t9WYftNz4SFTieHbZEm
 gh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744995880; x=1745600680;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NARtdtuew+2PXiCJtQc7ZhvHLBNpKTH8kvSBlgIZVbk=;
 b=Cz3H3Cj1X9JebipH3exn+F4ypeRezsk8mP7OUAhKyFfgl2uLDcE+7FWSWI9irO7zEt
 m1fL66sw0Tw1Xs8bQFWW3/5Ra6rw6NQMwXbnWE8rt95Y57ce32hsFxBSs95OssBb/rlA
 XCzb7zx9xpcK0e4rys/WhFleLvcRgIn61/YirtniptekZ5mXUAOiZhTyLy/s+oDD+9F1
 86xgfwJbJwmRTNoeUJ4pv6gUCB6NUGILGy+U11+RL5E2PJial/KOo+LKOIsRVQSfAvd+
 uqvPLJzN9oHxLMDdk1ejkqo2TB01CpuAtDmsC+MxkKs4OdOA9raS+FzdN35809vbnO5u
 Xb0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgh50FjyvaL7Xy+L5+RLzjX8Km3JH5VD8lDEzUXDIKvsR2FS5XwzopZBCl7e3tx2s773wT9PZW0Zcd@nongnu.org
X-Gm-Message-State: AOJu0YwuqBhoAgkGr0FF9YT6VaMybsJwDK/kUp37H/q5GAaK3HVDiZ2Q
 TOq8TWUAIoVdqJPjJV7CXb2o7E/HGDAVpmdv86gO5t/Ns69bh8z5V9tilNy8RLRlrFwd4PuM6Xe
 k
X-Gm-Gg: ASbGncu+eB2TYM/BfRD/N+27L8X4uV8WKkdCJ5aHxxAU5QZHSodvHyt3/iLYmHrwdJ3
 GMxH6bO8KOwVkshBgxkQlrtodRFgMYbK8NqxHnNV+SAgRlFcYX06qYylDRHzT+cqjtNBXnNuzLi
 tSonMlUE+nUi0t3SE9RG++OqxWV7ey42lXfQ2ttq6thcMrzBW7kTFAe3s1aZ/L0/WDeIgh9vdwH
 IDfVk7yfeET99nkNgDa7LqxA5bezlhHJcCDOE+k/PxYubtmB/BOzhV9evcF/UQPESsYscH7hlZm
 oSm5XsUZJHzBUq+Nlf4ETzNEkWa0QhNnWchHXlVZ9P1Nmly1p80jVZulmaE8hKV6VZxIPHj3E15
 RCl3xxWwySHfIddxTvfA=
X-Google-Smtp-Source: AGHT+IETevU/P1JUNqmiNnZ0R5bfcgdlQ7Bk34Uv7C7f6CM6CRWrCbE4qNz0bKn1R5TppUJilRoCJw==
X-Received: by 2002:a5d:6d8b:0:b0:39e:e588:6721 with SMTP id
 ffacd0b85a97d-39efba2e9a5mr2813466f8f.3.1744995879786; 
 Fri, 18 Apr 2025 10:04:39 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5bbd7fsm28570965e9.21.2025.04.18.10.04.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 10:04:39 -0700 (PDT)
Message-ID: <11f622cc-e57f-423c-91ae-6301bb3f055a@linaro.org>
Date: Fri, 18 Apr 2025 19:04:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 04/11] hw/arm: Register TYPE_TARGET_ARM/AARCH64_CPU
 QOM interfaces
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250418005059.4436-1-philmd@linaro.org>
 <20250418005059.4436-5-philmd@linaro.org>
 <ac98a60e-fa76-4460-a9fa-6f95dd35814d@linaro.org>
 <dcf13faa-31e8-4ae1-9d89-1990310d207d@linaro.org>
 <dc052898-e075-4e1e-ae45-e3e47f41caae@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <dc052898-e075-4e1e-ae45-e3e47f41caae@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 18/4/25 18:30, Pierrick Bouvier wrote:
> On 4/18/25 07:07, Philippe Mathieu-Daudé wrote:
>> On 18/4/25 05:07, Pierrick Bouvier wrote:
>>> On 4/17/25 17:50, Philippe Mathieu-Daudé wrote:
>>>> Define the TYPE_TARGET_ARM_MACHINE and TYPE_TARGET_AARCH64_MACHINE
>>>> QOM interface names to allow machines to implement them.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>    meson.build                    |  1 +
>>>>    include/hw/boards.h            |  1 +
>>>>    include/qemu/target_info-qom.h | 18 ++++++++++++++++++
>>>>    target_info-qom.c              | 24 ++++++++++++++++++++++++
>>>>    4 files changed, 44 insertions(+)
>>>>    create mode 100644 include/qemu/target_info-qom.h
>>>>    create mode 100644 target_info-qom.c
>>>>
>>>> diff --git a/meson.build b/meson.build
>>>> index 49a050a28a3..168b07b5887 100644
>>>> --- a/meson.build
>>>> +++ b/meson.build
>>>> @@ -3808,6 +3808,7 @@ common_ss.add(pagevary)
>>>>    specific_ss.add(files('page-target.c', 'page-vary-target.c'))
>>>>    common_ss.add(files('target_info.c'))
>>>> +system_ss.add(files('target_info-qom.c'))
>>>>    specific_ss.add(files('target_info-stub.c'))
>>>>    subdir('backends')
>>>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>>>> index 02f43ac5d4d..b1bbf3c34d4 100644
>>>> --- a/include/hw/boards.h
>>>> +++ b/include/hw/boards.h
>>>> @@ -7,6 +7,7 @@
>>>>    #include "system/hostmem.h"
>>>>    #include "system/blockdev.h"
>>>>    #include "qapi/qapi-types-machine.h"
>>>> +#include "qemu/target_info-qom.h"
>>>>    #include "qemu/module.h"
>>>>    #include "qom/object.h"
>>>>    #include "hw/core/cpu.h"
>>>> diff --git a/include/qemu/target_info-qom.h b/include/qemu/
>>>> target_info-qom.h
>>>> new file mode 100644
>>>> index 00000000000..7eb9b6bd254
>>>> --- /dev/null
>>>> +++ b/include/qemu/target_info-qom.h
>>>> @@ -0,0 +1,18 @@
>>>> +/*
>>>> + * QEMU binary/target API (QOM types)
>>>> + *
>>>> + *  Copyright (c) Linaro
>>>> + *
>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>> + */
>>>> +
>>>> +#ifndef QEMU_TARGET_INFO_QOM_H
>>>> +#define QEMU_TARGET_INFO_QOM_H
>>>> +
>>>> +#define TYPE_TARGET_ARM_MACHINE \
>>>> +        "target-info-arm-machine"
>>>> +
>>>> +#define TYPE_TARGET_AARCH64_MACHINE \
>>>> +        "target-info-aarch64-machine"
>>>> +
>>>> +#endif
>>>> diff --git a/target_info-qom.c b/target_info-qom.c
>>>> new file mode 100644
>>>> index 00000000000..d3fee57361b
>>>> --- /dev/null
>>>> +++ b/target_info-qom.c
>>>> @@ -0,0 +1,24 @@
>>>> +/*
>>>> + * QEMU binary/target API (QOM types)
>>>> + *
>>>> + *  Copyright (c) Linaro
>>>> + *
>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>> + */
>>>> +
>>>> +#include "qemu/osdep.h"
>>>> +#include "qemu/target_info-qom.h"
>>>> +#include "qom/object.h"
>>>> +
>>>> +static const TypeInfo target_info_types[] = {
>>>> +    {
>>>> +        .name           = TYPE_TARGET_ARM_MACHINE,
>>>> +        .parent         = TYPE_INTERFACE,
>>>> +    },
>>>> +    {
>>>> +        .name           = TYPE_TARGET_AARCH64_MACHINE,
>>>> +        .parent         = TYPE_INTERFACE,
>>>> +    },
>>>> +};
>>>> +
>>>> +DEFINE_TYPES(target_info_types)
>>>
>>> Ideally, this should be in target/arm, as this type will only be used by
>>> boards in hw/arm, and by the target_info specialization.
>>
>> Not the way QOM works, interfaces must be registered, which is
>> why I use this centralized file. Otherwise we get:
>>
>> $ qemu-system-sh4 -M help
>> qemu-system-sh4: -M help: missing interface 'target-info-arm-machine'
>> for object 'machine'
>>
> 
> If I'm correct, types can be registered anywhere, since they rely on 
> static initializer, but in qemu-system-sh4, hw/arm or target/arm is not 
> linked, so it fails.
> I guess this is the null board that is creating this situation, since 
> it's included by all binaries.

Correct.

> I see two solutions while still moving those types in target/arm:
> - include this type file in libcommon, so it's always linked.
> - introduce a new TYPE_TARGET_ALL_MACHINE, and always include it in list 
> of machines. But I think it's not so good as it would require to deal 
> with a list of types when we want to access a machine.
> 
> So I would just move the file and link it inconditonnally in all binaries.

Which file? target_info-qom.c is already in system_ss[].

