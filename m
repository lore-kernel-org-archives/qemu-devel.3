Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADC0C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4gR-000593-B0; Mon, 19 Feb 2024 09:31:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc4gQ-00058i-8m
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:31:50 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc4gO-0003SE-5o
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:31:50 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412698ac6f9so3495825e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 06:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708353106; x=1708957906; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wb7GI7NapM+t0rzPIi4HiIJwL6bw4e6Ou5xFgI57zK8=;
 b=UyWSFc8Rnmk2n/uQGj6ztMb0mI8PHU0pE0F7sIZrHr8k4g4o/mayBqgHZk1f+a8Wy/
 xnbd09AZNVtjKz1wO8S4wk147yY4d1TaetYdmazEDoqHYzBi8qMIqlZj0aJgwWfgeFy7
 vC9O0Q85605bAdJq5unvQtMPJUd/o4cLvkjXl1F5k1N/3GaULc9wEQMv/PSO16Jdpdz4
 FyyKvbFt0+S+Xiq6fJSYavZVwSGLE30+eyVEg386bUT+tT07DOZzsduvRRESW9weIwzk
 JQdv4z8eqspWcT1JemDYIXUejVrygdssx4JBIvK3duTROEx8J/N7Xvl7AoJ/RI3lag9X
 J9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708353106; x=1708957906;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wb7GI7NapM+t0rzPIi4HiIJwL6bw4e6Ou5xFgI57zK8=;
 b=OtWNiFu3AsylhLpkVeQAom/Q8PN1yIMZcAfAL/YZhjDTQn3/cs6QcxroKxr3GHYuSF
 n7qP0iDQQAbLb8G50Hi/43wKw56Qz/Z4LOe+7HqT6e/wlINa9SFRi7J6/JrzsTxasb3A
 ZVJKk2hLgfKYw8mmP4dLTlHViILo+xFiKhSbqMUEsDsBdUGS1ltgd0LDtyFo7teoS2rI
 64F6sZ4YkRQ9Fwj32Pep2mM8G01XqqEt2TpxDq2YUnqH13g3yXgtcoalAZN1WAuu/M0y
 CZ6hGZGCw19e8rGlUkhQoTohyb12/2bRUVOAxamTWK2ZeGs60VZuZ2kV9BrsMO8MFAI2
 g82Q==
X-Gm-Message-State: AOJu0YyOU2tFIp8nIJwoLOV8q4RlwjU4k40mX4b4vON4cxJSEZ4AB29O
 EdeRWaDqQOkCOfNgrsjeJfuUWopRqQqqaLETbP+uYdseZExTtnLTrK8hHCi0Syo=
X-Google-Smtp-Source: AGHT+IEJij6OkrmaTcUiB0FPMJtScEVyycN9s58HnC17X+QmJAiY9+0gpQ/VrUMlLyv2ajv97HLtnw==
X-Received: by 2002:a05:600c:4f91:b0:412:5f08:b508 with SMTP id
 n17-20020a05600c4f9100b004125f08b508mr4564677wmq.9.1708353106502; 
 Mon, 19 Feb 2024 06:31:46 -0800 (PST)
Received: from [192.168.69.100] ([176.176.181.220])
 by smtp.gmail.com with ESMTPSA id
 z19-20020a7bc7d3000000b00411e1574f7fsm11372225wmk.44.2024.02.19.06.31.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 06:31:46 -0800 (PST)
Message-ID: <8f17b07b-5032-4782-a83f-7cf1dd760168@linaro.org>
Date: Mon, 19 Feb 2024 15:31:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] hw/arm: Inline sysbus_create_simple(PL110 / PL111)
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20240216153517.49422-1-philmd@linaro.org>
 <20240216153517.49422-2-philmd@linaro.org>
 <bcfd3f9d-04e3-79c9-c15f-c3c8d7669bdb@eik.bme.hu>
 <2f8ec2e2-c4c7-48c3-9c3d-3e20bc3d6b9b@linaro.org>
 <b40fd79f-4d41-4e04-90c1-6f4b2fde811d@linaro.org>
 <00e2b898-3c5f-d19c-fddc-e657306e071f@eik.bme.hu>
 <2b9ea923-c4f9-4ee4-8ed2-ba9f62c15579@linaro.org>
 <6b5758d6-f464-2461-f9dd-71d2e15b610a@eik.bme.hu>
 <bc5929e4-1782-4719-8231-fe04a9719c40@ilande.co.uk>
 <8115d26c-458a-74d0-6c85-bc03b2f99011@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8115d26c-458a-74d0-6c85-bc03b2f99011@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 19/2/24 14:57, BALATON Zoltan wrote:
> On Mon, 19 Feb 2024, Mark Cave-Ayland wrote:
>> On 19/02/2024 12:00, BALATON Zoltan wrote:
>>> On Mon, 19 Feb 2024, Philippe Mathieu-Daudé wrote:
>>>> On 19/2/24 12:27, BALATON Zoltan wrote:
>>>>> On Mon, 19 Feb 2024, Philippe Mathieu-Daudé wrote:
>>>>>> On 16/2/24 20:54, Philippe Mathieu-Daudé wrote:
>>>>>>> On 16/2/24 18:14, BALATON Zoltan wrote:
>>>>>>>> On Fri, 16 Feb 2024, Philippe Mathieu-Daudé wrote:
>>>>>>>>> We want to set another qdev property (a link) for the pl110
>>>>>>>>> and pl111 devices, we can not use sysbus_create_simple() which
>>>>>>>>> only passes sysbus base address and IRQs as arguments. Inline
>>>>>>>>> it so we can set the link property in the next commit.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>>>>> ---
>>>>>>>>> hw/arm/realview.c    |  5 ++++-
>>>>>>>>> hw/arm/versatilepb.c |  6 +++++-
>>>>>>>>> hw/arm/vexpress.c    | 10 ++++++++--
>>>>>>>>> 3 files changed, 17 insertions(+), 4 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/hw/arm/realview.c b/hw/arm/realview.c
>>>>>>>>> index 9058f5b414..77300e92e5 100644
>>>>>>>>> --- a/hw/arm/realview.c
>>>>>>>>> +++ b/hw/arm/realview.c
>>>>>>>>> @@ -238,7 +238,10 @@ static void realview_init(MachineState 
>>>>>>>>> *machine,
>>>>>>>>>     sysbus_create_simple("pl061", 0x10014000, pic[7]);
>>>>>>>>>     gpio2 = sysbus_create_simple("pl061", 0x10015000, pic[8]);
>>>>>>>>>
>>>>>>>>> -    sysbus_create_simple("pl111", 0x10020000, pic[23]);
>>>>>>>>> +    dev = qdev_new("pl111");
>>>>>>>>> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>>>>>>>>> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x10020000);
>>>>>>>>> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[23]);
>>>>>>>>
>>>>>>>> Not directly related to this patch but this blows up 1 line into 
>>>>>>>> 4 just to allow setting a property. Maybe just to keep some 
>>>>>>>> simplicity we'd rather need either a sysbus_realize_simple 
>>>>>>>> function that takes a sysbus device instead of the name and does 
>>>>>>>> not create the device itself or some way to pass properties to 
>>>>>>>> sysbus create simple (but the latter may not be easy to do in a 
>>>>>>>> generic way so not sure about that). What do you think?
>>>>>>>
>>>>>>> Unfortunately sysbus doesn't scale in heterogeneous setup.
>>>>>>
>>>>>> Regarding the HW modelling API complexity you are pointing at, we'd
>>>>>> like to move from the current imperative programming paradigm to a
>>>>>> declarative one, likely DSL driven. Meanwhile it is being 
>>>>>> investigated
>>>>>> (as part of "Dynamic Machine"), I'm trying to get the HW APIs right
>>>>>
>>>>> I'm aware of that activity but we're currently still using board 
>>>>> code to construct machines and probably will continue to do so for 
>>>>> a while. Also because likely not all current machines will be 
>>>>> converted to new declarative way so having a convenient API for 
>>>>> that is still useful.
>>>>>
>>>>> (As for the language to describe the devices of a machine and their 
>>>>> connections declaratively the device tree does just that but dts is 
>>>>> not a very user friendly descrtiption language so I haven't brought 
>>>>> that up as a possibility. But you may still could get some clues by 
>>>>> looking at the problems it had to solve to at least get a 
>>>>> requirements for the machine description language.)
>>>>>
>>>>>> for heterogeneous emulation. Current price to pay is a verbose
>>>>>> imperative QDev API, hoping we'll get later a trivial declarative one
>>>>>> (like this single sysbus_create_simple call), where we shouldn't 
>>>>>> worry
>>>>>> about the order of low level calls, whether to use link or not, etc.
>>>>>
>>>>> Having a detailed low level API does not prevent a more convenient 
>>>>> for current use higher level API on top so keeping that around for 
>>>>> current machines would allow you to chnage the low level API 
>>>>> without having to change all the board codes because you's only 
>>>>> need to update the simple high level API.
>>>>
>>>> So what is your suggestion here, add a new complex helper to keep
>>>> a one-line style?
>>>>
>>>> DeviceState *sysbus_create_simple_dma_link(const char *typename,
>>>>                                           hwaddr baseaddr,
>>>>                                           const char *linkname,
>>>>                                           Object *linkobj,
>>>>                                           qemu_irq irq);
>>>
>>> I think just having sysbus_realize_simple that does the same as 
>>> sysbus_create_simple minus creating the device would be enough 
>>> because then the cases where you need to set properties could still 
>>> use it after qdev_new or init and property_set but hide the realize 
>>> and connecting the device behind this single call.
>>
>> I can't say I'm a fan of sysbus_create_simple() because its use of 
>> varargs to populate qdev properties is based upon the assumptions that 
>> the properties defined with device_class_set_props() are stored in a 
>> list. I can see there could be potential in future to store properties 
>> in other structures such as a hash, and keeping this API would prevent 
>> this change. FWIW my personal preference would be to remove this API 
>> completely.
>>
>>>> I wonder why this is that important since you never modified
>>>> any of the files changed by this series:
>>>
>>> For new people trying to contribute to QEMU QDev is overwhelming so 
>>> having some way to need less of it to do simple things would help 
>>> them to get started.
>>
>> It depends what how you define "simple": for QEMU developers most 
>> people search for similar examples in the codebase and copy/paste 
>> them. I'd much rather have a slightly longer, but consistent API for 
>> setting properties rather than coming up with many special case 
>> wrappers that need to be maintained just to keep the line count down 
>> for "simplicity".
> 
> It's not just about keeping the line count down, although that helps 
> with readablility, it's simpler to see what the code does if one has to 
> go through less QDev and QOM details, and new people are unfamiliar with 
> those so when they see the five lines creating the single device they 
> won't get what it does while a sysbus_create_simple call is very self 
> explaining. Maybe sysbus_create_simple is not the best API and not one 
> we can keep but by point is that as long as we have board code and it's 
> the main way to create machines that developers have to work with then 
> we should have some simple API to do that and don't leave them with only 
> low level QOM and QDev calls that are not high level enough to creare a 
> machine conveniently. If the direction is to eventually don't need any 
> code to create a machine then don't spend much time on designing that 
> API but at least keep what we have as long as it's possible. Removing 
> the device creation from sysbus_create_simple is not a big change but 
> allows board code to keep using it for now instead of ending up an 
> unreadable low level calls that makes it harder to see at a glance what 
> a board consists of.
> 
>> I think that Phil's approach here is the best one for now, 
>> particularly given that it allows us to take another step towards 
>> heterogeneous machines. As the work in this area matures it might be 
>> that we can consider other approaches, but that's not a decision that 
>> can be made right now and so shouldn't be a reason to block this change.
> 
> I did not say this patch should not be accepred or anything like that. 
> Just if there's a way with not too much work to make this simpler (as in 
> more readable and understandable for people not familiar with low levels 
> of QEMU) then I think that's worth trying and keeping at least most of 
> the functions of sysbus_create_simple as sysbus_realize_simple is not 
> much work to do but avoids blowing up the board code with a lot of low 
> level QOM stuff that I'd rather keep out of there unless it could be 
> made less overwhelming and verbose. Also keeping a higher level API for 
> board code would help this refactoring because if the low level calls 
> are not all over the board code then they would need to change less as 
> the changes could be done within the higher level API implementation.
> 
> But at the end this is just my opinion and Philippe is free to do what 
> he wants. I ust shared this view point in case he can take it into 
> account but if not then it's not the end of the world.

Thanks for being open to experiments. I'm not trying to attack you here,
but to not ignore any community concerns as yours. While you have a deep
knowledge of QEMU internals you also try to keep it simple for new devs,
and we really want to keep the project attractive enough to new people.

I hope a declarative HW modelling language will simplify the current
situation, so developers would focus on HW modelling rather than C
implementations and their bugs. Users would focus on the (simple) DSL
and not the C API. To get there we need to start somewhere...

