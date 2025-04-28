Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCA8C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 06:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9IMP-00037T-Dr; Mon, 28 Apr 2025 02:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9IMJ-00035R-Dn
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 02:52:59 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9IMD-0000fr-VA
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 02:52:52 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39c1efbefc6so2918821f8f.1
 for <qemu-devel@nongnu.org>; Sun, 27 Apr 2025 23:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745823163; x=1746427963; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BcRj/KRQgpQ9aFi94VKwsvlya3Myk96SNKfZMgrUaB4=;
 b=mHkphirevY0hQr2P5pqXE3tU1mnhD3BQHrUQVVU6Rc1+ZGfKuOdTyCOKSrxn/qQw0q
 RIYZ0vMm0v2jUCCray/5OAr3Xig5UmQRBRsxjP1dTHZs5Gx/3VMrSEBI7A4qllrH/Ih5
 mVyoLYG2cStpeittKCOXWnc4Cjw13BvY4zW8qEdWn3kM9VcnUeMEEjRNd6HQQ+vAjtxE
 gmTUNMZfdmh4jPlxmt+91bamI/iWc92jJ2zea4Jl/PfrWc8d7BfxjbAPL9dOWU6tbjgC
 lEJ2X0QSsCWYIq6xeOLg54x0Q87QrF1Ws0tUHyYmFgWcqUEycnUNJ0Nch27KEjdzKtAa
 JG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745823163; x=1746427963;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BcRj/KRQgpQ9aFi94VKwsvlya3Myk96SNKfZMgrUaB4=;
 b=YtaGWNhlb5/wsiuXiLtT/7Vz+MtCeuP3o3SgTCO6mLqSMieXvFW26zleZcxNR20j0/
 P3p4nz66vcY6pNNtrk2007PS9KDZyom4ZQYbxOx9ShsdtJobIi9rYZxXUL5PrsC6/FpH
 OO8saMnpzPb07kSkL/SLYqZKQibgw7k4CbOZCwq70HeS6/m6UPMah9v11/9g+ZJd6IPV
 uj9b6w2rwwcbjaSfx+vwkUSyIMzA8kpxTWJcct/758HdZCFCXq2QNmU2uHqDhXXPSgk8
 UaT8sQpKcAS0rJWi7pXRsKC70EDK4mC/WrT8A90pJqQu/5sbf45JAQhisgWx/nLh7LtM
 6sWg==
X-Gm-Message-State: AOJu0YzeJETw5bVIfclt4YM0cqQ1tLNyvcZk9s1Qqd3THAusovmYtXGb
 NwNrIG8tfcSudD1eNw4quv1jaXpRxJcZUBSqS8w6SfL5snX5Pxhn1/3ad/7Q38g=
X-Gm-Gg: ASbGncspU2LUP79fVB/hp/OM1PUYHuepNy3R+KAVXmpQ2r+pGru0fcnUY3oMLUs1zg3
 MLnZtEzph/dl0PCZBMcHCVGFFofcIFd7lFuwWcdP1Oo+yYtNTqFk1Dsq+mQMHkF6StnpKvSy7ou
 1k250YKKPPntO4ZQmqlbpGVRk/jsZCDMHuQQsOYEqQhCbm57quwFmdKxjcbYzUBeX+CCikbAwRI
 zAEQ9qUg5KVx0Wl/Gx7R5RRgj+p6yAA8RM+4X/wAYx+tUzLNzhg+BUdGeIz8DS/WfL009dhvbDZ
 yZUh9Ct2u8M9g+T+t/9nIeVp5Hgn9q0sO7ishsuVJVRRVSQodW+MiXH4EUPt6DX+GSDwTu3XTJo
 JWD7TR36XKsSHRg==
X-Google-Smtp-Source: AGHT+IEY2oqwHxvpy2DTizRaymIV4XWrj5O9aX0jkJwLClINcwn0ffVMmrfwK8w3b3kYrDmf5/hL5Q==
X-Received: by 2002:a05:6000:1aca:b0:39c:1f10:ba54 with SMTP id
 ffacd0b85a97d-3a074e3c4a6mr7938143f8f.35.1745823163478; 
 Sun, 27 Apr 2025 23:52:43 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8c7a4sm10501215f8f.14.2025.04.27.23.52.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Apr 2025 23:52:42 -0700 (PDT)
Message-ID: <c4479348-00b2-4604-adad-e8d8911c75a6@linaro.org>
Date: Mon, 28 Apr 2025 08:52:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 08/21] hw/arm: Add DEFINE_MACHINE_[ARM_]AARCH64()
 macros
To: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Anton Johansson <anjo@rev.ng>
References: <20250424222112.36194-1-philmd@linaro.org>
 <20250424222112.36194-9-philmd@linaro.org>
 <1332b395-1e3e-2be7-83f2-15f2d89b0449@eik.bme.hu>
 <51f3a96b-9c7a-4242-a822-145d68e068d9@linaro.org>
 <f84a52af-aecf-5235-7971-689580ffb71f@eik.bme.hu>
 <29f67d66-9eef-493a-9d96-99240ca25a14@linaro.org>
 <75b7e110-9293-32b2-64c8-26eabaace8b7@eik.bme.hu>
 <033d94c7-ac74-4a44-87ae-aeac964afd10@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <033d94c7-ac74-4a44-87ae-aeac964afd10@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 25/4/25 22:36, Pierrick Bouvier wrote:
> On 4/25/25 13:29, BALATON Zoltan wrote:
>> On Fri, 25 Apr 2025, Pierrick Bouvier wrote:
>>> On 4/25/25 02:43, BALATON Zoltan wrote:
>>>> On Thu, 24 Apr 2025, Pierrick Bouvier wrote:
>>>>> On 4/24/25 17:16, BALATON Zoltan wrote:
>>>>>> On Fri, 25 Apr 2025, Philippe Mathieu-Daudé wrote:
>>>>>>> A machine defined with the DEFINE_MACHINE_ARM_AARCH64() macro
>>>>>>> will be available on qemu-system-arm and qemu-system-aarch64
>>>>>>> binaries.
>>>>>>>
>>>>>>> One defined with DEFINE_MACHINE_AARCH64() will only be available
>>>>>>> in the qemu-system-aarch64 binary.
>>>>>>>
>>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>>> ---
>>>>>>> include/hw/arm/machines-qom.h | 13 +++++++++++++
>>>>>>> target/arm/machine.c          | 12 ++++++++++++
>>>>>>> 2 files changed, 25 insertions(+)
>>>>>>>
>>>>>>> diff --git a/include/hw/arm/machines-qom.h
>>>>>>> b/include/hw/arm/machines-qom.h
>>>>>>> index a17225f5f92..6277ee986d9 100644
>>>>>>> --- a/include/hw/arm/machines-qom.h
>>>>>>> +++ b/include/hw/arm/machines-qom.h
>>>>>>> @@ -9,10 +9,23 @@
>>>>>>> #ifndef HW_ARM_MACHINES_QOM_H
>>>>>>> #define HW_ARM_MACHINES_QOM_H
>>>>>>>
>>>>>>> +#include "hw/boards.h"
>>>>>>> +
>>>>>>> #define TYPE_TARGET_ARM_MACHINE \
>>>>>>>            "target-info-arm-machine"
>>>>>>>
>>>>>>> #define TYPE_TARGET_AARCH64_MACHINE \
>>>>>>>            "target-info-aarch64-machine"
>>>>>>>
>>>>>>> +extern InterfaceInfo arm_aarch64_machine_interfaces[];
>>>>>>> +extern InterfaceInfo aarch64_machine_interfaces[];
>>>>>>> +
>>>>>>> +#define DEFINE_MACHINE_ARM_AARCH64(namestr, machine_initfn) \
>>>>>>> +        DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, \
>>>>>>> +                                       
>>>>>>> arm_aarch64_machine_interfaces)
>>>>>>> +
>>>>>>> +#define DEFINE_MACHINE_AARCH64(namestr, machine_initfn) \
>>>>>>> +        DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, \
>>>>>>> +                                       aarch64_machine_interfaces)
>>>>>>> +
>>>>>>> #endif
>>>>>>> diff --git a/target/arm/machine.c b/target/arm/machine.c
>>>>>>> index 978249fb71b..193c7a9cff0 100644
>>>>>>> --- a/target/arm/machine.c
>>>>>>> +++ b/target/arm/machine.c
>>>>>>> @@ -8,6 +8,7 @@
>>>>>>> #include "cpu-features.h"
>>>>>>> #include "migration/cpu.h"
>>>>>>> #include "target/arm/gtimer.h"
>>>>>>> +#include "hw/arm/machines-qom.h"
>>>>>>>
>>>>>>> static bool vfp_needed(void *opaque)
>>>>>>> {
>>>>>>> @@ -1111,3 +1112,14 @@ const VMStateDescription vmstate_arm_cpu = {
>>>>>>>            NULL
>>>>>>>        }
>>>>>>> };
>>>>>>> +
>>>>>>> +InterfaceInfo arm_aarch64_machine_interfaces[] = {
>>>>>>> +    { TYPE_TARGET_ARM_MACHINE },
>>>>>>> +    { TYPE_TARGET_AARCH64_MACHINE },
>>>>>>> +    { }
>>>>>>> +};
>>>>>>> +
>>>>>>> +InterfaceInfo aarch64_machine_interfaces[] = {
>>>>>>> +    { TYPE_TARGET_AARCH64_MACHINE },
>>>>>>> +    { }
>>>>>>> +};
>>>>>>
>>>>>> Why do you need these? If you define 
>>>>>> DEFINE_MACHINE_WITH_INTERFACES as
>>>>>> OBJECT_DEFINE_TYPE_WITH_INTERFACES then you can write:
>>>>>>
>>>>>
>>>>> This was requested in v4 by Richard to remove anonymous array 
>>>>> duplication
>>>>> in
>>>>> .data.
>>>>>
>>>>>> DEFINE_MACHINE_WITH_INTERFACES(name, initfn, 
>>>>>> { TYPE_TARGET_ARM_MACHINE },
>>>>>>         { TYPE_TARGET_AARCH64_MACHINE }, { })
>>>>>>
>>>>>> and no more macros needed. Ideally those places that are now blown up
>>>>>> should use DEFINE_MACHINE too. Maybe they don't yet because the 
>>>>>> parent
>>>>>> type  is hardcoded so we should really have
>>>>>>
>>>>>
>>>>> Not sure what you mean by "no more macros needed".
>>>>
>>>> No other specialised macros needed for each machine type other than
>>>> DEFINE_MACHINE_WITH_INTERFACES or DEFINE_MACHINE_EXTENDED. So I 
>>>> suggested
>>>> to keep DEFINE_MACHINE by making it more general so it can cover the 
>>>> new
>>>> uses instead of bringing back the boiler plate and losing the clarity
>>>> hinding these behind the macros.
>>>>
>>>
>>> This is exactly what we have in this series.
>>> Patch 7 introduces DEFINE_MACHINE_WITH_INTERFACES.
>>> I guess Philippe chose a new name to avoid modifying all existing
>>> DEFINE_MACHINE, and I think it's understandable, as we want those 
>>> changes to
>>> impact hw/arm only first. That said, it would be very easy to 
>>> refactor/modify
>>> later, so it's not a big deal.
>>>
>>> This patch introduces DEFINE_MACHINE_ARM_AARCH64 and 
>>> DEFINE_MACHINE_AARCH64.
>>>
>>> Is the problem with those specialized DEFINE_MACHINE_{ARM, AARCH64}
>>> definition?
>>> If yes, and if you prefer an explicit 
>>> DEFINE_MACHINE_WITH_INTERFACES(...,
>>> arm_aarch64_machine_interfaces), I'm sure Philippe would be open to 
>>> make such
>>> a change to satisfy reviews.
>>>
>>> Let's just try to decide something, and move on.
>>>
>>>>> arm_aarch64_machine_interfaces or aarch64_machine_interfaces are 
>>>>> arrays
>>>>> (defined only once), which are passed as a parameter to
>>>>> DEFINE_MACHINE_WITH_INTERFACES, or manually set with ".interfaces =".
>>>>
>>>> Look at how OBJECT_DEFINE_TYPE_WITH_INTERFACES is defined.
>>>>
>>>
>>> This macro is not used for any machine definition so far, and 
>>> DEFINE_MACHINE
>>> is the "standard" macro used, at least the one most commonly used in the
>>> codebase. So it makes sense to simply expand the latter.
>>
>> I was referring to that as an example how a 
>> DEFINE_MACHINE_WITH_INTERFACES
>> should work not suggesting to use OBJECT_DEFINE_TYPE_WITH_INTERFACES.
>>
>>>>>> DEFINE_MACHINE_EXTENDED(name, parent, initfn, interfaces...)
>>>>>>
>>>>>> and remove more bolier plate that way?
>>>>>>
>>>>>
>>>>> Could you can share a concrete example of what you expect, with the 
>>>>> new
>>>>> macros to add, and how to use them for a given board?
>>>>
>>>> I tried to do that in this message you replied to.
>>>>
>>>
>>> If you refer to "DEFINE_MACHINE_EXTENDED(name, parent, initfn,
>>> interfaces...)", this is almost exactly what patch 7 is introducing with
>>> DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, ifaces).
>>
>> The difference is that OBJECT_DEFINE_TYPE_WITH_INTERFACES takes a list of
>> interfaces and defines the array itself and you pass the array which is
>> limiting as you then need to define a lot of arrays to pass to your macro
>> instead of only passing the elements and let it define tha array.
>>
>> I just want to see instead of
>>
>> static const TypeInfo machine_types[] = {
>> ...lots of boiler plate code here
>> };
>>
>> something like
>>
>> DEFINE_MACHINE_EXTENDED(machine1, TYPE_WHATEVER_MACHINE, {INTERFACE1}, 
>> {INTERFACE2}, {})
>> DEFINE_MACHINE_EXTENDED(machine2, TYPE_OTHER_MACHINE, {INTERFACE1}, 
>> {INTERFACE3}, {})
>> DEFINE_MACHINE_EXTENDED(machine3, TYPE_THIRD_MACHINE, {INTERFACE1}, {})
>>
> 
> Ok, I understand better.
> 
> It was my point as well on v4, that introducing those symbols is less 
> readable and less scalable, for a negligible benefit in terms of code 
> size, which was the primary concern.
> We can always reconsider this later, especially when adding another 
> architecture to single binary, it's not a problem and something set in 
> stone.
> 
> Would you be ok if we proceed with the current version, knowing those 
> limitations, for now?

If Zoltan disagrees, we need Richard to agree to go back on v4.

Keep in mind that what we are trying to achieve is quite more complex
than code style or .rodata savings, besides we eventually want to have
dynamic machines & DSL.

