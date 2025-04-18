Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF3DC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5pF3-0002DM-PD; Fri, 18 Apr 2025 13:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pF2-0002D8-93
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:11:04 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pEz-00062X-LF
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:11:03 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4394a823036so11959875e9.0
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744996260; x=1745601060; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1dGwaFlioGoS20gLoykQV3O9s/ERT8QyE9dDCej8APY=;
 b=Uw0UvPcQeXBxcGPu2C1Xl378uolYkfdRXqZm1n9ZSIqIfnkybH9gwa7+1UmsvfY6/A
 xkwOYWZBM0BHeTnBF+aa2EZlajLCgFWlBzp0Zff3Zdf1c25OAtrh4MKZXJpOdEUBOfUD
 CYjuZ+H3czrn65zFw1rjvvNM3oubTO1VNGNg3tMOKaPD4fPTe4CavtD/p4IB+3Q+QeT1
 D4y320B2unJdHnKhKtBpAkBfdd6OVJFq/9+2TVwOBAars09PNz6E/eLng+6I+AcCUIqv
 aoLS1Xs9otIDVkN2wszIgAoH5KpPUQRsuFOBUPGa8L+6gCpk+S5xtKJ3vfsxlKazN4Qw
 nVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744996260; x=1745601060;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1dGwaFlioGoS20gLoykQV3O9s/ERT8QyE9dDCej8APY=;
 b=A+G7TdPDbdioh81pksw7ZlSOvEfM6VHqvWLnDypkan+zsJJET1ZhRDt9nO93QW6G/A
 l5mYOIQBcrhZ85dtFwE2ckGb29xZ3dbM/F5FvZM9ZUC+Ai5VGej0H1P2Q7GPZ0m5f8oe
 1o7F1WLXXJbEJHnuDDSGFKo38injc/5RUy/u24d7OMrwZms990wyln4UM1KgViaeM/S6
 b6/9jW2fvKi8lreQCR53PInrODpf//9lnFZoe0+poI4q9aw7ofSFC513/11QO0ecpd3R
 oE4LW64XJLwb1AVvz2KLRUy5/rVttlzJEroJYFBi2yXX5Xo2Nt3y+4oOXckpKGO0NoWe
 Lpzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWphZ52Yp88pePMXHHe9vxzBKSNj0mWQwg2BxLCsSaawLWFxxh1eLNIVnnaz3oOnTq2B7NtnfEKIopA@nongnu.org
X-Gm-Message-State: AOJu0YyiDz1H7uGWNqnMbEcSXOku0y5DOOm0AZzTYzfAUcntrYXYA8tX
 YmGS5Ac0wRja7j4bB6H3W5YZqsshJ1vSuLSddMdalVJfYWM5FE8F5PspRY+5xks=
X-Gm-Gg: ASbGncuqRChjJCb47QWvZ10bMBbsRt85ZOtQPZhGwTF7bDN0WAV+pW3w+WBwcuH7Yk4
 0TUQzTsxcoSPF/qPvJ2ZoWlsm/k1CRHZ/xSopUOQpgdvFMVEr2myg48LgKkVXn1oQ4cjGeqUUF5
 QbuagSKWeasYLXT7rbKCl/3sAL4PaTeuRc/m9yjHs2X447dcBRTfVZTTh9imUjrekOZIjEbeOC+
 ZseMYaYhJ85VSKaZayWacmxJ9/QhNpdYOz634bjvkaa2f+sjoT4vxdW3u2wskzWAHgs7XTDR3cA
 GqZGOnyNCDv1HRewTgmkIh1u2jbmYtVF5v73sslH9syuu9BfrfUzHgTklKGUts9rChQXSDNEe0j
 XWcJACCAQbmcL3hvd63c=
X-Google-Smtp-Source: AGHT+IG79RvT12lzv1/Y5SpRLW/SCmDubX2h86rq2caUuYyidAkpAs8oPRTSnRE8pIZwJrsGWBdr6A==
X-Received: by 2002:a05:600c:154a:b0:43c:eec7:eab7 with SMTP id
 5b1f17b1804b1-4406ab9858amr27455455e9.11.1744996259839; 
 Fri, 18 Apr 2025 10:10:59 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5accc2sm29302285e9.14.2025.04.18.10.10.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 10:10:59 -0700 (PDT)
Message-ID: <d9a95e4f-2baa-4cf4-837b-a8fc9a41bfaf@linaro.org>
Date: Fri, 18 Apr 2025 19:10:58 +0200
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
 <11f622cc-e57f-423c-91ae-6301bb3f055a@linaro.org>
 <be5d6d8f-b0df-4295-a2d3-16b5caef1eb0@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <be5d6d8f-b0df-4295-a2d3-16b5caef1eb0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 18/4/25 19:07, Pierrick Bouvier wrote:
> On 4/18/25 10:04, Philippe Mathieu-Daudé wrote:
>> On 18/4/25 18:30, Pierrick Bouvier wrote:
>>> On 4/18/25 07:07, Philippe Mathieu-Daudé wrote:
>>>> On 18/4/25 05:07, Pierrick Bouvier wrote:
>>>>> On 4/17/25 17:50, Philippe Mathieu-Daudé wrote:
>>>>>> Define the TYPE_TARGET_ARM_MACHINE and TYPE_TARGET_AARCH64_MACHINE
>>>>>> QOM interface names to allow machines to implement them.
>>>>>>
>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>> ---
>>>>>>     meson.build                    |  1 +
>>>>>>     include/hw/boards.h            |  1 +
>>>>>>     include/qemu/target_info-qom.h | 18 ++++++++++++++++++
>>>>>>     target_info-qom.c              | 24 ++++++++++++++++++++++++
>>>>>>     4 files changed, 44 insertions(+)
>>>>>>     create mode 100644 include/qemu/target_info-qom.h
>>>>>>     create mode 100644 target_info-qom.c
>>>>>>
>>>>>> diff --git a/meson.build b/meson.build
>>>>>> index 49a050a28a3..168b07b5887 100644
>>>>>> --- a/meson.build
>>>>>> +++ b/meson.build
>>>>>> @@ -3808,6 +3808,7 @@ common_ss.add(pagevary)
>>>>>>     specific_ss.add(files('page-target.c', 'page-vary-target.c'))
>>>>>>     common_ss.add(files('target_info.c'))
>>>>>> +system_ss.add(files('target_info-qom.c'))
>>>>>>     specific_ss.add(files('target_info-stub.c'))
>>>>>>     subdir('backends')
>>>>>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>>>>>> index 02f43ac5d4d..b1bbf3c34d4 100644
>>>>>> --- a/include/hw/boards.h
>>>>>> +++ b/include/hw/boards.h
>>>>>> @@ -7,6 +7,7 @@
>>>>>>     #include "system/hostmem.h"
>>>>>>     #include "system/blockdev.h"
>>>>>>     #include "qapi/qapi-types-machine.h"
>>>>>> +#include "qemu/target_info-qom.h"
>>>>>>     #include "qemu/module.h"
>>>>>>     #include "qom/object.h"
>>>>>>     #include "hw/core/cpu.h"
>>>>>> diff --git a/include/qemu/target_info-qom.h b/include/qemu/
>>>>>> target_info-qom.h
>>>>>> new file mode 100644
>>>>>> index 00000000000..7eb9b6bd254
>>>>>> --- /dev/null
>>>>>> +++ b/include/qemu/target_info-qom.h
>>>>>> @@ -0,0 +1,18 @@
>>>>>> +/*
>>>>>> + * QEMU binary/target API (QOM types)
>>>>>> + *
>>>>>> + *  Copyright (c) Linaro
>>>>>> + *
>>>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>>>> + */
>>>>>> +
>>>>>> +#ifndef QEMU_TARGET_INFO_QOM_H
>>>>>> +#define QEMU_TARGET_INFO_QOM_H
>>>>>> +
>>>>>> +#define TYPE_TARGET_ARM_MACHINE \
>>>>>> +        "target-info-arm-machine"
>>>>>> +
>>>>>> +#define TYPE_TARGET_AARCH64_MACHINE \
>>>>>> +        "target-info-aarch64-machine"
>>>>>> +
>>>>>> +#endif
>>>>>> diff --git a/target_info-qom.c b/target_info-qom.c
>>>>>> new file mode 100644
>>>>>> index 00000000000..d3fee57361b
>>>>>> --- /dev/null
>>>>>> +++ b/target_info-qom.c
>>>>>> @@ -0,0 +1,24 @@
>>>>>> +/*
>>>>>> + * QEMU binary/target API (QOM types)
>>>>>> + *
>>>>>> + *  Copyright (c) Linaro
>>>>>> + *
>>>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>>>> + */
>>>>>> +
>>>>>> +#include "qemu/osdep.h"
>>>>>> +#include "qemu/target_info-qom.h"
>>>>>> +#include "qom/object.h"
>>>>>> +
>>>>>> +static const TypeInfo target_info_types[] = {
>>>>>> +    {
>>>>>> +        .name           = TYPE_TARGET_ARM_MACHINE,
>>>>>> +        .parent         = TYPE_INTERFACE,
>>>>>> +    },
>>>>>> +    {
>>>>>> +        .name           = TYPE_TARGET_AARCH64_MACHINE,
>>>>>> +        .parent         = TYPE_INTERFACE,
>>>>>> +    },
>>>>>> +};
>>>>>> +
>>>>>> +DEFINE_TYPES(target_info_types)
>>>>>
>>>>> Ideally, this should be in target/arm, as this type will only be 
>>>>> used by
>>>>> boards in hw/arm, and by the target_info specialization.
>>>>
>>>> Not the way QOM works, interfaces must be registered, which is
>>>> why I use this centralized file. Otherwise we get:
>>>>
>>>> $ qemu-system-sh4 -M help
>>>> qemu-system-sh4: -M help: missing interface 'target-info-arm-machine'
>>>> for object 'machine'
>>>>
>>>
>>> If I'm correct, types can be registered anywhere, since they rely on
>>> static initializer, but in qemu-system-sh4, hw/arm or target/arm is not
>>> linked, so it fails.
>>> I guess this is the null board that is creating this situation, since
>>> it's included by all binaries.
>>
>> Correct.
>>
>>> I see two solutions while still moving those types in target/arm:
>>> - include this type file in libcommon, so it's always linked.
>>> - introduce a new TYPE_TARGET_ALL_MACHINE, and always include it in list
>>> of machines. But I think it's not so good as it would require to deal
>>> with a list of types when we want to access a machine.
>>>
>>> So I would just move the file and link it inconditonnally in all 
>>> binaries.
>>
>> Which file? target_info-qom.c is already in system_ss[].
> 
> Move existing target_info-qom in in target/arm/target_info_types.c, and 
> add it to system_ss, instead of arm_ss or arm_common_ss, so it's always 
> linked.

That should work, but what is the benefit over having a single file
where all definitions are concentrated?


