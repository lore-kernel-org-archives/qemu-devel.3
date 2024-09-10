Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639B1ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 06:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snuMf-0005Bg-Tu; Tue, 10 Sep 2024 02:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snuMc-0005Aw-Vu
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 02:28:35 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snuMa-0004Zt-TH
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 02:28:34 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c3c30e663fso378201a12.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 23:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725949711; x=1726554511; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=30bytGc3xBkYijjd782eeygkoN5FfoOKtF5zx6GBKfI=;
 b=NcwlDajWsJ48ug6FVbPWPaCctRWTTvggmhWhYuwghnMJUaeUIMj5/BtiOWYa3JJrBw
 Ep8qKNqpdPqGnZot5Ols4k1cwrEECmvCjDiB86SOLUSW5neR+PwHXCDOAiY5T2fipXnJ
 IzFk7UvUc4IvywslYGLlbPc+BJSz+BEuWi4ynRvFzLgiSMevJhMyIPZrUD5ditMSoqXv
 HBvzefqpS62UBvuinAF6izTeLmyltbWFF+D2z+sb7RYQQu66lYoJWtNbnafK/1yvKv+B
 zl232f6f5Z+AvOkkk9+tj5JyY7ImS2CYiQD6mjKufumNdslolpZl02eClxLxBEW8R0vS
 mrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725949711; x=1726554511;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=30bytGc3xBkYijjd782eeygkoN5FfoOKtF5zx6GBKfI=;
 b=JLRBFtVWZgcZXcF+FXFw7Gphq6lpbDI8mlJ3XuUlDvN8BaL2zeE01SH1ru0TiLZl55
 sFX/c/cXNh+awRBq6rpgZcFiL2NKSrW8pLSLNUnhWwXTkbW+6uZt3mgNV2HmVAI2jBP4
 jn88Aju2bH4Bu4guQsrqvAjXpFbE8H8OKwOkVlfHzYEdLgiSTdfUtuUBNZ0QcRTG7BEx
 8DomLNDbqFxPYlCKw3xQ6VjUmWTi9DJNXkMQpytRPahGD9cvhriA136NPye4ElJwJEvN
 +yNJ9pUyVFIakue36hQprj0vplTbGjgvSt5NqnBySE+J0injcJyl97YiBcdouMieP52E
 cW2Q==
X-Gm-Message-State: AOJu0Yz4nfQ5A6eagPX+pEaScmWXJ3bqngbpfyatvZutXT0pReVVceIx
 Pfb6j5UWusZB+IYCa6SuEbtL1Rc3piVHjeiZUcOFPLPq+MhR8VCNv3NCYHDiEbM=
X-Google-Smtp-Source: AGHT+IGX9V9GBzbcamR4sH1wPLEvYXGkSJvAHA7zzCoVUYktn2t2p7rKw0QFmh7BxZppS2Gxocotkw==
X-Received: by 2002:a05:6402:5cd:b0:5c2:439e:d6d6 with SMTP id
 4fb4d7f45d1cf-5c3dc78a1d6mr8893758a12.11.1725949710873; 
 Mon, 09 Sep 2024 23:28:30 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.217.32])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd51f84sm3785348a12.41.2024.09.09.23.28.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 23:28:30 -0700 (PDT)
Message-ID: <e5ceb882-fc42-4ef8-97c5-d3d7bbe2bb69@linaro.org>
Date: Tue, 10 Sep 2024 08:28:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/char/stm32l4x5_usart.c: Fix ACK and min access size
To: Jacob Abrams <satur9nine@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>
References: <20240902061944.526873-1-satur9nine@gmail.com>
 <CAFEAcA9wP7f_yPYNJmaTDe1bB8cPifErAGpjtsNPKsR0s_65Sg@mail.gmail.com>
 <667c28a5-3c00-4de2-b37e-566dc7ffca14@linaro.org>
 <adb2d9d0-5088-4df8-a1aa-4572af92d877@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <adb2d9d0-5088-4df8-a1aa-4572af92d877@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

Hi Jacob,

On 10/9/24 06:34, Jacob Abrams wrote:
> On 9/9/24 10:40, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> (Cc'ing Arnaud & Inès who are listed as maintainers)
>>
>> On 6/9/24 18:12, Peter Maydell wrote:
>>> On Mon, 2 Sept 2024 at 14:38, Jacob Abrams <satur9nine@gmail.com> wrote:
>>>>
>>>> These changes allow the official STM32L4xx HAL UART driver to function
>>>> properly with the b-l475e-iot01a machine.
>>>>
>>>> Modifying USART_CR1 TE bit should alter USART_ISR TEACK bit, and
>>>> likewise for RE and REACK bit.
>>>>
>>>> USART registers may be accessed via 16-bit instructions.
>>>>
>>>> Reseting USART_CR1 UE bit should restore ISR to default value.
>>>>
>>>> Fixes: 87b77e6e01ca ("hw/char/stm32l4x5_usart: Enable serial read and write")
>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2540
>>>> Signed-off-by: Jacob Abrams <satur9nine@gmail.com>
>>>
>>> Thanks for this patch. I have one question below, and one
>>> minor nit.
>>>
>>>> ---
>>>>    hw/char/stm32l4x5_usart.c          | 29 +++++++++++++++++++---
>>>>    tests/qtest/stm32l4x5_usart-test.c | 39 +++++++++++++++++++++++++++++-
>>>>    2 files changed, 64 insertions(+), 4 deletions(-)
>>
>>
>>>>    static void stm32l4x5_update_irq(Stm32l4x5UsartBaseState *s)
>>>>    {
>>>>        if (((s->isr & R_ISR_WUF_MASK) && (s->cr3 & R_CR3_WUFIE_MASK))        ||
>>>> @@ -367,7 +389,7 @@ static void stm32l4x5_usart_base_reset_hold(Object *obj, ResetType type)
>>>>        s->brr = 0x00000000;
>>>>        s->gtpr = 0x00000000;
>>>>        s->rtor = 0x00000000;
>>>> -    s->isr = 0x020000C0;
>>>> +    s->isr = ISR_RESET_VALUE;
>>>>        s->rdr = 0x00000000;
>>>>        s->tdr = 0x00000000;
>>>>
>>>> @@ -456,6 +478,7 @@ static void stm32l4x5_usart_base_write(void *opaque, hwaddr addr,
>>>>        case A_CR1:
>>>>            s->cr1 = value;
>>>>            stm32l4x5_update_params(s);
>>>> +        stm32l4x5_update_isr(s);
>>>>            stm32l4x5_update_irq(s);
>>>>            return;
>>>>        case A_CR2:
>>>> @@ -508,12 +531,12 @@ static const MemoryRegionOps stm32l4x5_usart_base_ops = {
>>>>        .endianness = DEVICE_NATIVE_ENDIAN,
>>>>        .valid = {
>>>>            .max_access_size = 4,
>>>> -        .min_access_size = 4,
>>>> +        .min_access_size = 2,
>>>>            .unaligned = false
>>>>        },
>>>>        .impl = {
>>>>            .max_access_size = 4,
>>>> -        .min_access_size = 4,
>>>> +        .min_access_size = 2,
>>>>            .unaligned = false
>>>>        },
>>>
>>> The effect of these is that a 16-bit write not aligned
>>> to a (4-aligned) register offset will generate a GUEST_ERROR
>>> logged message, and a 16-bit write aligned to a 4-aligned
>>> register offset will write the value zero-extended to 32 bits.
>>> That seems reasonable to me.
>>
>> Peter, are you describing the .valid.min_access_size 4 -> 2 change
>> or the .impl.min_access_size one?
>>
>> My understanding of the implementation is a 32-bit one:
>>
>>    REG32(CR1, 0x00)
>>
>>    struct Stm32l4x5UsartBaseState {
>>        ...
>>        uint32_t cr1;
>>
>>    static void stm32l4x5_usart_base_write(void *opaque, hwaddr addr,
>>                                    uint64_t val64, unsigned int size)
>>    {
>>        ...
>>        switch (addr) {
>>        case A_CR1:
>>            s->cr1 = value;
>>
>> Am I missing something?
>>
>> Now, back to .valid.min_access_size, per the section "40.8 USART
>> registers" of the reference manual:
>>
>>    The peripheral registers have to be accessed by words (32 bits).
>>
>> So I don't get the "USART registers may be accessed via 16-bit
>> instructions." part of this patch.
>>
>> Jacob, for clarity, can you split this patch in 3 distinct parts
>> (TE bit, UE bit, unaligned access) so this discussion doesn't delay
>> the part which are OK?
>>
>> Thanks,
>>
>> Phil.
> 
> Hmm it does appear to be a documentation error in RM0351 section 40.8.
> 
> I have an STM32L476 board (chip is nearly identical to the STM32L475 minus the display module) which is functioning with the USART driver code provided by STM in their examples that uses 16-bit access for several of the USART registers, see:
> 
> https://github.com/STMicroelectronics/cmsis_device_l4/blob/a2530753e86dd326a75467d28feb92e2ba7d0df2/Include/stm32l475xx.h#L950

OK, we need to mention that in a comment around, something like:

   /*
    * While the reference manual states "the peripheral registers
    * have to be accessed by words (32 bits)", code -- like the
    * STM32CubeL4 CMSIS Device MCU Component -- ran on real
    * hardware shows some registers can be accessed by 16 bits.
    */
   .valid.min_access_size = 2,

> I have a contact at STM through my work that I can mention this to just to double check.

Thanks, that is great.

> Ultimately my goal is to get an STM32CubeL4 example such as UART_Printf running as-is in Qemu and it was only while attempting to run such a project in Qemu that I ran into this problem, see:
> 
> https://github.com/STMicroelectronics/STM32CubeL4/tree/master/Projects/STM32L476G-EVAL/Examples/UART/UART_Printf

It would be nice to add a test using this file in our functional
test suite, see for example tests/functional/test_avr_mega2560.py.

> 
> This project works on my HW dev board just fine.
> 
> Of course if you still desire I don't mind splitting this change into 3 parts.

Well, you clearly list 3 steps in the commit description.
Besides, the discussions whether .imp.min_access_size = 2
is valid still stands.

Regards,

Phil.

