Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECF2C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 18:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txsFs-0000Lh-4p; Thu, 27 Mar 2025 14:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txsFc-0000F2-Az
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 14:46:58 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txsFZ-0006Jv-09
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 14:46:47 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3fea67e64caso828888b6e.2
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 11:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743101203; x=1743706003; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r/zFF7bClTdlxqtzG/brFtc2KvOw2AHXThgmz+3NElA=;
 b=C+s4fr8NPy4Oc5/CJMU9SgbqwVCJkqRhfILylWUKwnWv8qr8FzFAZDHHnb17f0l699
 UXcb61uFOGwnVSpxEL4fhkzZykX2SvPeOzDGv2Gq12bkqlCzslrkroxUn02ckolAioE+
 nfT+zehHFmWgCSPGn8tXrAW/qrs/x5lSt2tcgWec13HAIefthV+kn1ZIV2OWKlSzQ89I
 DR0n+I4r+6wUMun1LYCqpvxBWQ7LZL/8EqvkuMD0sP022UHWYctp4/HJmEk2VLwFvpFn
 2Oif+KHODleuD4xDgB+R2lMc/VGyVjvd4tHE7LKfTIHSnZ0JIiegjejWKWziDDKmhHE4
 sehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743101203; x=1743706003;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r/zFF7bClTdlxqtzG/brFtc2KvOw2AHXThgmz+3NElA=;
 b=vf54Tl8t7gaTh1/uXH93OtRowOmmNNjmRB5krnzfeDPXnznAoBE8TPkE4g0s3x2X/2
 qojPc88gYIX3Utb4kPxJLHwnYb990BG18oIiuL37nceydZU80s1GtP08ympLl/ZnyOHU
 pDwkbqxUWUHyxRy9libkBFNIXbWC+iTU06i6zNyDXZipyBgMwjfLwe6zuSZXzl+kAEOP
 q4tRabyXd0YrfIPcmtwdxnB59dSpbF60VQDbE2j3WIxYiygUmabBjQCeGm5D8IkcC1yN
 ocmut/ghXYs3bqWs3knFL/Ay7cMzAu7VaiW8KTrnvr+M0UKFgfSAO9qBIPVwM8PZ0Lak
 vDOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt7g+eOkPMqXi9CNubVbPst15VsUZkK47hicXxzfVkafem7aT1//II0xKWKhJK0pxh7ejt7E83UVMK@nongnu.org
X-Gm-Message-State: AOJu0YzBtkDcdhZt8RZEfKKkBz3w15mCNqgRqXjhmUPPsmf8d7u7mgzX
 ih4yEIcSPBevetVePJSwrHiKudxDl8+wYFiVNOWBGolQ0GKsKmnymTU4Oq05bxU=
X-Gm-Gg: ASbGncv7X/c68lFDYnpFRLQ0uViX3TWislcHoy0G0HRdVJLMrhVIz9PWJA9kz6nO+wq
 FMQmFOhcKCO2sVjORGWb5qogO4GhNITcEWtkvb2dcZOcsHgmYFGzOXhfR/bNnaOM19QyuSxjU1/
 2y6GDM4O9eZdIGj++N53c7Dyplbrcj0yrtP68+wmKyT3pYG5B7SgWcMu0dED3tHGvL7r4DO9Hcz
 85yyHJEpyDGbE7ZWOv63M1EWeWMGdQMcjnBnajl+LGbKsiJFfVzQg32JAacj1pk1y7MhwmkIQ2o
 urYSFUzgC69HAtwXXHbRu8jfEsAI7s7quv2Rn6cqS/8HWw59gpD1XXzW4cge2d3+Bb16Az3Oz19
 um2LTenGYul6RV/Ml6tQZ+w==
X-Google-Smtp-Source: AGHT+IEa8uaPFgluQ1qrae/j4kTItFEfRojWIEsu+Tl2kXtk88k1kmCNhK5Ter4hskENM5vEF3G4sA==
X-Received: by 2002:a05:6808:1486:b0:3f3:e9d5:7790 with SMTP id
 5614622812f47-3fefa4dd565mr2437070b6e.6.1743101202719; 
 Thu, 27 Mar 2025 11:46:42 -0700 (PDT)
Received: from [172.20.102.85] (syn-071-042-197-003.biz.spectrum.com.
 [71.42.197.3]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-602844e59ffsm55321eaf.5.2025.03.27.11.46.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 11:46:42 -0700 (PDT)
Message-ID: <f3accf4d-94a0-4212-aa4d-dac12a784a34@linaro.org>
Date: Thu, 27 Mar 2025 13:46:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] hw/avr: Prepare for TARGET_PAGE_SIZE > 256
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, pierrick.bouvier@linaro.org
References: <20250325224403.4011975-1-richard.henderson@linaro.org>
 <20250325224403.4011975-11-richard.henderson@linaro.org>
 <dee36972-4483-492d-a64f-17c0d0000f59@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <dee36972-4483-492d-a64f-17c0d0000f59@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
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

On 3/27/25 13:24, Philippe Mathieu-Daudé wrote:
> On 25/3/25 23:44, Richard Henderson wrote:
>> If i/o does not cover the entire first page, allocate a portion
>> of ram as an i/o device, so that the entire first page is i/o.
>>
>> While memory_region_init_ram_device_ptr is happy to allocate
>> the RAMBlock, it does not register the ram for migration.
>> Do this by hand.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   hw/avr/atmega.h |  1 +
>>   hw/avr/atmega.c | 39 ++++++++++++++++++++++++++++++++-------
>>   2 files changed, 33 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/avr/atmega.h b/hw/avr/atmega.h
>> index a99ee15c7e..9ac4678231 100644
>> --- a/hw/avr/atmega.h
>> +++ b/hw/avr/atmega.h
>> @@ -41,6 +41,7 @@ struct AtmegaMcuState {
>>       MemoryRegion flash;
>>       MemoryRegion eeprom;
>>       MemoryRegion sram;
>> +    MemoryRegion sram_io;
>>       DeviceState *io;
>>       AVRMaskState pwr[POWER_MAX];
>>       AVRUsartState usart[USART_MAX];
> 
>> @@ -240,11 +239,37 @@ static void atmega_realize(DeviceState *dev, Error **errp)
>>       qdev_realize(DEVICE(&s->cpu), NULL, &error_abort);
>>       cpudev = DEVICE(&s->cpu);
>> -    /* SRAM */
>> -    memory_region_init_ram(&s->sram, OBJECT(dev), "sram", mc->sram_size,
>> -                           &error_abort);
>> -    memory_region_add_subregion(get_system_memory(),
>> -                                OFFSET_DATA + mc->io_size, &s->sram);
>> +    /*
>> +     * SRAM
>> +     *
>> +     * Softmmu is not able mix i/o and ram on the same page.
>> +     * Therefore in all cases, the first page exclusively contains i/o.
>> +     *
>> +     * If the MCU's i/o region matches the page size, then we can simply
>> +     * allocate all ram starting at the second page.  Otherwise, we must
>> +     * allocate some ram as i/o to complete the first page.
>> +     */
>> +    assert(mc->io_size == 0x100 || mc->io_size == 0x200);
>> +    if (mc->io_size >= TARGET_PAGE_SIZE) {
>> +        memory_region_init_ram(&s->sram, OBJECT(dev), "sram", mc->sram_size,
>> +                               &error_abort);
>> +        memory_region_add_subregion(get_system_memory(),
>> +                                    OFFSET_DATA + mc->io_size, &s->sram);
>> +    } else {
>> +        int sram_io_size = TARGET_PAGE_SIZE - mc->io_size;
>> +        void *sram_io_mem = g_malloc0(sram_io_size);
> 
> Please declare sram_io_mem in AtmegaMcuState, after sram_io.

Why?

>> +
>> +        memory_region_init_ram_device_ptr(&s->sram_io, OBJECT(dev), "sram-as-io",
>> +                                          sram_io_size, sram_io_mem);

After this, it's accessible as

     s->sram_io->ram_block->host

It wouldn't be accessed in any other way, surely?


r~

