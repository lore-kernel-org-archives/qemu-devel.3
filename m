Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878D0C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdjr-0005Ee-P8; Tue, 04 Mar 2025 20:40:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdjm-0005E8-L8
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:39:54 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdji-00035y-CA
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:39:52 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-390effd3e85so4777570f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741138788; x=1741743588; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VkFwTM4hSwEvvvdJI0VEsY/oubZVoQ3JfxJUPYeblbw=;
 b=cRVM8IhX0hNwOSxsZfAcGIHRf2fcqtvVwztG1WPWtfVISP5inysZ/fgvxxA21C+CoZ
 +DExXVMK1Ka9Rh1E+nWEkUJewL2UkFw5r7GVm1IW2DNh2TVWV+2OrwhY6fMqgFQg1R7m
 97bq06knMasIseLuENvzpT79fiJiqufV83YJZfTSBDIQE2KblGCAbfo5eiVNUZ0JmrXO
 Wn3Tj/OwZpOQO1cgCc87yx0IXsuQH4oXCuDFU0SXRNCXmRtsh9CuenPyNnwLO+i0wOzE
 EVOLEs95gYcb+2YwFIMuofwFKIRJVb3MNGdhvLeh2UBozysxOP+fYSAkLp9NDWzGb19d
 fWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741138788; x=1741743588;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VkFwTM4hSwEvvvdJI0VEsY/oubZVoQ3JfxJUPYeblbw=;
 b=EozLFkG3UzZPl4bx8IkSM3nYW/A7SwyTN0Lqf4VBXnsC5DuASKcCb2v5RBlfat2UF9
 xquYp72hQNbI36bQW8D/AhzDVzo+9YfsxjWQcfrfDgTSQS8yNGZUuu/CuXSfwQyvtKWX
 cEBoVckRp4212vtLQbK/JYGhSjj8A7AflJN1rDVD76+rcafbotUAcItys3ePlLfP1961
 cD/Rxjhc64FOhcxttNpw04/0rhhDLvREiec8HH50KKQAjaLsT7u1sKzqhRNXSp5f8JFb
 ok9tP15KcTWw8raYcqSYi85BxfTf3PrA1IiIvIsJx9AiSkB9KzRZ+WsurXnKYkmwdFjH
 c3pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQm3h5s6jxQ+d3M3jR/JzxCk8oMVynRoQumKc4z9h0tlDZgwyiUQJ4MykxHZfsbhZaM5tUQ9Zs1Pa1@nongnu.org
X-Gm-Message-State: AOJu0YygCIfhfe3g1cfs9kJmYWOkqbkDMMuslNz5p+3j7YdUNS+Vg0QS
 zoIJEKyBqbL3Wrxc77s/1xcq31GFIPHQYUBplJfKCLxKe+FUAnQj2+anTHPLlSA=
X-Gm-Gg: ASbGncuQZpBY9Du3YRuCmmR9PJVXYZjFnUi4GnRk73h0kOz32aAsYYIXiKRpH3nGlNP
 GyOQbqhPUa9QoAHEBziTU9OvQBIiRvesvXzJ163yLDpQ4HWo1A0wsGk1ouv8feM7GtvFO1Bs958
 Lb2OQl/QqFm+3eNHnu+aaGy1PQVixAYim5cuWAdF8B3lcMHoWtj9QFh5frWum1/R8hW8shWD4ln
 liBiDg98DklhwxQwZn2iTj5KuwFMngtSA8OP75ExGOhJHd13g6mGRkQJGtCFW+MnYN+G5PePC2x
 gGupXrtGHSKsqaPUMK7SE5G6FwCAm5zQBIfZmTywQUpvTVnAybSxzJ1RnoUOfVciofwWKBgRiye
 IWEe767SWIIki
X-Google-Smtp-Source: AGHT+IE5KaJutOXLFANtBO9e16SM2/H9pz/qarwRVNc90qi6wWdgnmtxqzW2jMngDpWK6xndNfViLQ==
X-Received: by 2002:a05:6000:1786:b0:391:1213:9479 with SMTP id
 ffacd0b85a97d-3911f7bf998mr650224f8f.51.1741138787835; 
 Tue, 04 Mar 2025 17:39:47 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4795978sm18955948f8f.3.2025.03.04.17.39.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 17:39:47 -0800 (PST)
Message-ID: <8cb52de1-15e4-40f7-9cd2-325219ca1e9b@linaro.org>
Date: Wed, 5 Mar 2025 02:39:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/11] system: Introduce QemuArchBit enum
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>
References: <20250305005225.95051-1-philmd@linaro.org>
 <20250305005225.95051-4-philmd@linaro.org>
 <1951b0b1-ccea-429e-9e72-e8df7a7a8599@linaro.org>
 <4229013f-8601-4e8a-912a-d641bdf8a105@linaro.org>
 <e04862f6-6341-44cf-92b1-fac656fca3c7@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e04862f6-6341-44cf-92b1-fac656fca3c7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 5/3/25 02:36, Pierrick Bouvier wrote:
> On 3/4/25 17:31, Philippe Mathieu-Daudé wrote:
>> On 5/3/25 02:23, Pierrick Bouvier wrote:
>>> On 3/4/25 16:52, Philippe Mathieu-Daudé wrote:
>>>> Declare QEMU_ARCH_BIT_$target as QemuArchBit enum.
>>>> Use them to declare QEMU_ARCH_$target bitmasks.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>    meson.build                |  4 +--
>>>>    include/system/arch_init.h | 65 ++++++++++++++++++++++++ 
>>>> +-------------
>>>>    system/arch_init.c         |  2 +-
>>>>    3 files changed, 46 insertions(+), 25 deletions(-)
>>>>
>>>> diff --git a/meson.build b/meson.build
>>>> index 0a2c61d2bfa..1ab02a5d48d 100644
>>>> --- a/meson.build
>>>> +++ b/meson.build
>>>> @@ -3357,8 +3357,8 @@ foreach target : target_dirs
>>>>          config_target_data.set(k, v)
>>>>        endif
>>>>      endforeach
>>>> -  config_target_data.set('QEMU_ARCH',
>>>> -                         'QEMU_ARCH_' +
>>>> config_target['TARGET_BASE_ARCH'].to_upper())
>>>> +  config_target_data.set('QEMU_ARCH_BIT',
>>>> +                         'QEMU_ARCH_BIT_' +
>>>> config_target['TARGET_BASE_ARCH'].to_upper())
>>>>      config_target_h += {target: configure_file(output: target + '-
>>>> config-target.h',
>>>>                                                   configuration:
>>>> config_target_data)}
>>>> diff --git a/include/system/arch_init.h b/include/system/arch_init.h
>>>> index d8b77440487..06e5527ec88 100644
>>>> --- a/include/system/arch_init.h
>>>> +++ b/include/system/arch_init.h
>>>> @@ -1,29 +1,50 @@
>>>>    #ifndef QEMU_ARCH_INIT_H
>>>>    #define QEMU_ARCH_INIT_H
>>>> +#include "qemu/bitops.h"
>>>> -enum {
>>>> -    QEMU_ARCH_ALL = -1,
>>>> -    QEMU_ARCH_ALPHA = (1 << 0),
>>>> -    QEMU_ARCH_ARM = (1 << 1),
>>>> -    QEMU_ARCH_I386 = (1 << 3),
>>>> -    QEMU_ARCH_M68K = (1 << 4),
>>>> -    QEMU_ARCH_MICROBLAZE = (1 << 6),
>>>> -    QEMU_ARCH_MIPS = (1 << 7),
>>>> -    QEMU_ARCH_PPC = (1 << 8),
>>>> -    QEMU_ARCH_S390X = (1 << 9),
>>>> -    QEMU_ARCH_SH4 = (1 << 10),
>>>> -    QEMU_ARCH_SPARC = (1 << 11),
>>>> -    QEMU_ARCH_XTENSA = (1 << 12),
>>>> -    QEMU_ARCH_OPENRISC = (1 << 13),
>>>> -    QEMU_ARCH_TRICORE = (1 << 16),
>>>> -    QEMU_ARCH_HPPA = (1 << 18),
>>>> -    QEMU_ARCH_RISCV = (1 << 19),
>>>> -    QEMU_ARCH_RX = (1 << 20),
>>>> -    QEMU_ARCH_AVR = (1 << 21),
>>>> -    QEMU_ARCH_HEXAGON = (1 << 22),
>>>> -    QEMU_ARCH_LOONGARCH = (1 << 23),
>>>> -};
>>>> +typedef enum QemuArchBit {
>>>> +    QEMU_ARCH_BIT_ALPHA         = 0,
>>>> +    QEMU_ARCH_BIT_ARM           = 1,
>>>> +    QEMU_ARCH_BIT_I386          = 3,
>>>> +    QEMU_ARCH_BIT_M68K          = 4,
>>>> +    QEMU_ARCH_BIT_MICROBLAZE    = 6,
>>>> +    QEMU_ARCH_BIT_MIPS          = 7,
>>>> +    QEMU_ARCH_BIT_PPC           = 8,
>>>> +    QEMU_ARCH_BIT_S390X         = 9,
>>>> +    QEMU_ARCH_BIT_SH4           = 10,
>>>> +    QEMU_ARCH_BIT_SPARC         = 11,
>>>> +    QEMU_ARCH_BIT_XTENSA        = 12,
>>>> +    QEMU_ARCH_BIT_OPENRISC      = 13,
>>>> +    QEMU_ARCH_BIT_TRICORE       = 16,
>>>> +    QEMU_ARCH_BIT_HPPA          = 18,
>>>> +    QEMU_ARCH_BIT_RISCV         = 19,
>>>> +    QEMU_ARCH_BIT_RX            = 20,
>>>> +    QEMU_ARCH_BIT_AVR           = 21,
>>>> +    QEMU_ARCH_BIT_HEXAGON       = 22,
>>>> +    QEMU_ARCH_BIT_LOONGARCH     = 23,
>>>> +} QemuArchBit;
>>>> +
>>>> +#define QEMU_ARCH_ALPHA         BIT(QEMU_ARCH_BIT_ALPHA)
>>>> +#define QEMU_ARCH_ARM           BIT(QEMU_ARCH_BIT_ARM)
>>>> +#define QEMU_ARCH_I386          BIT(QEMU_ARCH_BIT_I386)
>>>> +#define QEMU_ARCH_M68K          BIT(QEMU_ARCH_BIT_M68K)
>>>> +#define QEMU_ARCH_MICROBLAZE    BIT(QEMU_ARCH_BIT_MICROBLAZE)
>>>> +#define QEMU_ARCH_MIPS          BIT(QEMU_ARCH_BIT_MIPS)
>>>> +#define QEMU_ARCH_PPC           BIT(QEMU_ARCH_BIT_PPC)
>>>> +#define QEMU_ARCH_S390X         BIT(QEMU_ARCH_BIT_S390X)
>>>> +#define QEMU_ARCH_SH4           BIT(QEMU_ARCH_BIT_SH4)
>>>> +#define QEMU_ARCH_SPARC         BIT(QEMU_ARCH_BIT_SPARC)
>>>> +#define QEMU_ARCH_XTENSA        BIT(QEMU_ARCH_BIT_XTENSA)
>>>> +#define QEMU_ARCH_OPENRISC      BIT(QEMU_ARCH_BIT_OPENRISC)
>>>> +#define QEMU_ARCH_TRICORE       BIT(QEMU_ARCH_BIT_TRICORE)
>>>> +#define QEMU_ARCH_HPPA          BIT(QEMU_ARCH_BIT_HPPA)
>>>> +#define QEMU_ARCH_RISCV         BIT(QEMU_ARCH_BIT_RISCV)
>>>> +#define QEMU_ARCH_RX            BIT(QEMU_ARCH_BIT_RX)
>>>> +#define QEMU_ARCH_AVR           BIT(QEMU_ARCH_BIT_AVR)
>>>> +#define QEMU_ARCH_HEXAGON       BIT(QEMU_ARCH_BIT_HEXAGON)
>>>> +#define QEMU_ARCH_LOONGARCH     BIT(QEMU_ARCH_BIT_LOONGARCH)
>>>> +#define QEMU_ARCH_ALL           -1
>>>>    extern const uint32_t arch_type;
>>>
>>> What are we gaining by having a "bit" oriented enum, vs simple values
>>> that can be compared too?
>>
>> I'm not sure what you are asking here, these definitions are heavily
>> used in qemu-options.hx, and I don't plan to change them anytime soon.
>>
>> For the single binary I'll try to keep the command line interface with
>> no change. For heterogeneous binary I plan to start with no CLI so I'm
>> not really considering them.
>>
> 
> My bad, I thought we were introducing something new here.
> Yes, let's stick to a minimal change.
> 
>>> As well, it would make sense to add subvariants (aarch64, x86_64, little
>>> and big endian variants for some arch), so all of them are present and
>>> can be queried easily.
>>
>> IIUC what you are referring, this is planned for another interface, but
>> not this series which is focused on introducing qemu_arch_name() and
>> removing TARGET_NAME. While you don't see any improvement in duplicated
>> target files as of this series, some reduction should happen in the next
>> step which remove TARGET_BIG_ENDIAN uses in hw/.
>>
> 
> Yes, sounds good. It's just a bit hard to track the changes between the 
> cleanup of existing files, and introducing a new API to query this 
> information at run time.

OK, in the next version I'll try to better explain where this series is
going in the patch description.

