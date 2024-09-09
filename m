Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36969ECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniNV-0007ob-Ha; Mon, 09 Sep 2024 13:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sniNS-0007e7-RP
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:40:38 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sniNQ-0007Lj-S5
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:40:38 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a8b155b5e9eso431579066b.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725903635; x=1726508435; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DTZmSJkjzWTMN8gRZ6fQbLBJT5JJBIC3Z4x5mb+Kw9g=;
 b=JuqgdM3FYTuLFRcLt5wSC77xzF+h1F+MyWOONpcbyyGmE9zYxgkaNl0xZ82Y04PidR
 qvbTg7Kb2kjI036PeN/WY0q431YAr75tM9VHV5GkT5M6F4HE+cJ4miXHYtXKoaRzF9Ex
 dAMCpWHvIp9drYOd05s9rX6lkhYNH6/QzPV7YrMMyMKipQT42VE3tCO8dKA4OfZHMiFc
 3RIrRuRtRPKtUgmxBLv/VsekqDAstcrve6z7G+uQ3HV6ZS3IRkWfxzjuUlLGxO8RK9TK
 VbuQHTpAQSVYeUMUI6pIrSQKhkDj5Y740ZKY81kDUzV/fdqVnXezp+wnI1Hy6gSnUa3Z
 ov9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725903635; x=1726508435;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DTZmSJkjzWTMN8gRZ6fQbLBJT5JJBIC3Z4x5mb+Kw9g=;
 b=vZgE/GoAeclnbRHH4bSyD3QC3lm52QzPLksV7oSXaDiPM0iYtAif4HtB6RDEF/8RDf
 K9+LJv9VK33inX4m4zGvT4vqoP+VvVmFF2UgpGNC3SoEApwljdqzA7QZX9RR9S2aMSAJ
 M10A56eRG7Vm/KDkNonQtt/1KzOx+BpF+kuVTUY13nA5nxYkWDhZtS3IYmT9lOS1qi2l
 9Xo6QZXZQg6uqAeREBV7sAJIMDTFYfYzt6aFjdzwNeSE/fO0qeeXYsOwSvJABRoTNItW
 1zS5gudTM3aQSsjVPZU+X/KDJ1z3IOou6C6lrc/Y9zo7b6BD6zZHEcbSDWmjJ/E2WNx6
 0E4Q==
X-Gm-Message-State: AOJu0YxjKDaqMJa9Y7wv0jjy77dnKZ9WyL7mHURM+dGurwkPXpONn7Vk
 ZjyKAXH8zR3exNn6WwCnGKwv42lq8t+fptWY6wHhXQSgSaYTaFxVMWbZnjPOh1I=
X-Google-Smtp-Source: AGHT+IEXytohDILIY0y5GRKHIbt5BMTDJfIvyWXFcFla9d+sDgp+X3hXfK+Y//QdgPj0ZdEWl7OIOg==
X-Received: by 2002:a17:907:7e8e:b0:a8d:345e:a0ba with SMTP id
 a640c23a62f3a-a8d345ea209mr535908766b.15.1725903634956; 
 Mon, 09 Sep 2024 10:40:34 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cebcb2sm366448166b.153.2024.09.09.10.40.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 10:40:34 -0700 (PDT)
Message-ID: <667c28a5-3c00-4de2-b37e-566dc7ffca14@linaro.org>
Date: Mon, 9 Sep 2024 19:40:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/char/stm32l4x5_usart.c: Fix ACK and min access size
To: Peter Maydell <peter.maydell@linaro.org>,
 Jacob Abrams <satur9nine@gmail.com>
Cc: qemu-devel@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>
References: <20240902061944.526873-1-satur9nine@gmail.com>
 <CAFEAcA9wP7f_yPYNJmaTDe1bB8cPifErAGpjtsNPKsR0s_65Sg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9wP7f_yPYNJmaTDe1bB8cPifErAGpjtsNPKsR0s_65Sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

Hi,

(Cc'ing Arnaud & Inès who are listed as maintainers)

On 6/9/24 18:12, Peter Maydell wrote:
> On Mon, 2 Sept 2024 at 14:38, Jacob Abrams <satur9nine@gmail.com> wrote:
>>
>> These changes allow the official STM32L4xx HAL UART driver to function
>> properly with the b-l475e-iot01a machine.
>>
>> Modifying USART_CR1 TE bit should alter USART_ISR TEACK bit, and
>> likewise for RE and REACK bit.
>>
>> USART registers may be accessed via 16-bit instructions.
>>
>> Reseting USART_CR1 UE bit should restore ISR to default value.
>>
>> Fixes: 87b77e6e01ca ("hw/char/stm32l4x5_usart: Enable serial read and write")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2540
>> Signed-off-by: Jacob Abrams <satur9nine@gmail.com>
> 
> Thanks for this patch. I have one question below, and one
> minor nit.
> 
>> ---
>>   hw/char/stm32l4x5_usart.c          | 29 +++++++++++++++++++---
>>   tests/qtest/stm32l4x5_usart-test.c | 39 +++++++++++++++++++++++++++++-
>>   2 files changed, 64 insertions(+), 4 deletions(-)


>>   static void stm32l4x5_update_irq(Stm32l4x5UsartBaseState *s)
>>   {
>>       if (((s->isr & R_ISR_WUF_MASK) && (s->cr3 & R_CR3_WUFIE_MASK))        ||
>> @@ -367,7 +389,7 @@ static void stm32l4x5_usart_base_reset_hold(Object *obj, ResetType type)
>>       s->brr = 0x00000000;
>>       s->gtpr = 0x00000000;
>>       s->rtor = 0x00000000;
>> -    s->isr = 0x020000C0;
>> +    s->isr = ISR_RESET_VALUE;
>>       s->rdr = 0x00000000;
>>       s->tdr = 0x00000000;
>>
>> @@ -456,6 +478,7 @@ static void stm32l4x5_usart_base_write(void *opaque, hwaddr addr,
>>       case A_CR1:
>>           s->cr1 = value;
>>           stm32l4x5_update_params(s);
>> +        stm32l4x5_update_isr(s);
>>           stm32l4x5_update_irq(s);
>>           return;
>>       case A_CR2:
>> @@ -508,12 +531,12 @@ static const MemoryRegionOps stm32l4x5_usart_base_ops = {
>>       .endianness = DEVICE_NATIVE_ENDIAN,
>>       .valid = {
>>           .max_access_size = 4,
>> -        .min_access_size = 4,
>> +        .min_access_size = 2,
>>           .unaligned = false
>>       },
>>       .impl = {
>>           .max_access_size = 4,
>> -        .min_access_size = 4,
>> +        .min_access_size = 2,
>>           .unaligned = false
>>       },
> 
> The effect of these is that a 16-bit write not aligned
> to a (4-aligned) register offset will generate a GUEST_ERROR
> logged message, and a 16-bit write aligned to a 4-aligned
> register offset will write the value zero-extended to 32 bits.
> That seems reasonable to me.

Peter, are you describing the .valid.min_access_size 4 -> 2 change
or the .impl.min_access_size one?

My understanding of the implementation is a 32-bit one:

   REG32(CR1, 0x00)

   struct Stm32l4x5UsartBaseState {
       ...
       uint32_t cr1;

   static void stm32l4x5_usart_base_write(void *opaque, hwaddr addr,
                                   uint64_t val64, unsigned int size)
   {
       ...
       switch (addr) {
       case A_CR1:
           s->cr1 = value;

Am I missing something?

Now, back to .valid.min_access_size, per the section "40.8 USART
registers" of the reference manual:

   The peripheral registers have to be accessed by words (32 bits).

So I don't get the "USART registers may be accessed via 16-bit
instructions." part of this patch.

Jacob, for clarity, can you split this patch in 3 distinct parts
(TE bit, UE bit, unaligned access) so this discussion doesn't delay
the part which are OK?

Thanks,

Phil.

