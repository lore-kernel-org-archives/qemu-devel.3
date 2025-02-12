Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83ECBC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 11:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiBBn-0000pN-Eu; Wed, 12 Feb 2025 06:45:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiBBf-0000op-Tk
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:45:55 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiBBa-0002Pe-43
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:45:48 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38f1e8efe82so434169f8f.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 03:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739360744; x=1739965544; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WOgIeJ4typNleVJOfAL+PFD25x4DDV/I/m2IXd1sD7g=;
 b=bXsaQAEtb+VHgOXDL/P4Bs2PodWxCU4LCFJFG8FPsDRfvWF+MMS+PoJbNUYQ41XJOX
 IwLpTSDNsHJ/9iKb+kcNdDCQ0MLc8JLhuU30lTlnvxLsE/FCOBczinLwawTHUZtVsbb3
 KiPM5oDbo8jl0PLsLScouXyWYNLL3fvFEPaPh26oPYp2G2g82s3ciA/36Ms4EfHqSg+/
 pRddQyLyvS+BgIXOtzTagzQ7Kq5LJPzXb8aKXCSH49S2dBYULuzga47NwhCNMoxmUJKb
 /CfnP9s5XAcN0Q5e/1ps7CXVEeZFsItoNhflM2SMO5nmcbaJv8IyU80QLm9AGV+2tvnM
 c4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739360744; x=1739965544;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WOgIeJ4typNleVJOfAL+PFD25x4DDV/I/m2IXd1sD7g=;
 b=kmM+1VzD9/Q5as6TkE/Eg7iPEQoHmx0p0F9RaLWU/HQCCNlOR2TtrYeTwQjVv/+Yty
 jIbB7KgDwfZl8QTrbxPGggWDAGYImuG7oXtdDOMlZSnoXm+hhWhlw+F8lvseJuC6pmFl
 oSra+XXc+MrcfWWhZGsT46gTVv2aXJkqEGCSgPk8CTu0vx7O+ESxcAb4y3+FLiePCiXb
 eJIE50s53UrUf6tvSDML+Oke9xlqEmAtUlia/oZ6OE/yOP11SFAntkMJd6vjC0SK8ZRk
 a1eRs4BNMWuXI7sGRG5SPfy7LyJ0iwhEzSCTuSaK04CHru+Gbr6bBSP6VdzJLTQd+TCm
 H5hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoLVxn6ALQVm/5XNKmjxTkTHqbr+mW2HTgE8zbfYYsY7FKxtuj6jNgfYa/YoZABJ/AARNBXAw9xMSb@nongnu.org
X-Gm-Message-State: AOJu0YxCOzg+bNDSydxz0oV80iGuYvc/9oW9MfrVDonzv2KA4QwfjQMt
 G8nzFfllC6s3nOQjmMA8zpSjpip3Wg5LJkZQmGBNRRvGX0B8EILaQwOZ0dwaD0IgZEwqrWuQA2Y
 WBgA=
X-Gm-Gg: ASbGncvS7Fmnxc0+BbU3uoYo/PL0a2SfpIfC+kHtK9yAuvyKpDj0Lt5aLMnjrbUfHfS
 1K4k3EQebPpCt8btl+dHt5zry3w/eBzHeKQN88zg60tS8DZrEqK8rTjurVv9lAYbDT20/L308lH
 f71yz6Na9m2Zhe2nJQFgkmC0QrByyopJMpUKmvyt3qrgj+h3RcntUNqgShbJafgqvHZxPYq2Wbt
 uLbUoRetWXQETt34YS8zAsu1PELytCRZ7OR2hS0fZwb/a1oWqkMSSGBlaPOaNk6/G9NTmf/Wxs5
 tee5+xx0iPvVV9qdbQmQ/shdN3fdWlvRVzNbUJg5CFfg0ZQMTt+p2Q2mqYc=
X-Google-Smtp-Source: AGHT+IGeg6ng+ZzTb9D6s4V52znZAv3VHJeewjDufiBvjgqASxK4ZoXtxPJqgN+UAwL2mWVSy87X4Q==
X-Received: by 2002:a5d:588c:0:b0:38a:2b39:9205 with SMTP id
 ffacd0b85a97d-38dea2878bfmr2762742f8f.33.1739360744121; 
 Wed, 12 Feb 2025 03:45:44 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dcd34a39esm14199540f8f.30.2025.02.12.03.45.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 03:45:43 -0800 (PST)
Message-ID: <1746a714-d6da-434e-b631-cd35f0bd9041@linaro.org>
Date: Wed, 12 Feb 2025 12:45:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 04/32] hw/timer/xilinx_timer: Make device endianness
 configurable
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
 <20250210204204.54407-5-philmd@linaro.org>
 <678561c5-4d06-494a-b12c-6013b07f3b05@redhat.com>
 <03446903-2100-4981-831e-7ee4741ffead@linaro.org>
 <1a4dc9cf-69bb-4a9e-bd07-e50070fcf9a9@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1a4dc9cf-69bb-4a9e-bd07-e50070fcf9a9@redhat.com>
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

On 12/2/25 11:24, Thomas Huth wrote:
> On 12/02/2025 10.19, Philippe Mathieu-Daudé wrote:
>> On 12/2/25 09:27, Thomas Huth wrote:
>>> On 10/02/2025 21.41, Philippe Mathieu-Daudé wrote:
>>>> Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair
>>>> of DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
>>>> Add the "little-endian" property to select the device
>>>> endianness, defaulting to little endian.
>>>> Set the proper endianness for each machine using the device.
>>>>
>>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> Message-Id: <20250206131052.30207-5-philmd@linaro.org>
>>>> ---
>>>>   hw/microblaze/petalogix_ml605_mmu.c      |  1 +
>>>>   hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 +
>>>>   hw/ppc/virtex_ml507.c                    |  1 +
>>>>   hw/timer/xilinx_timer.c                  | 35 ++++++++++++++ 
>>>> +---------
>>>>   4 files changed, 25 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/ 
>>>> petalogix_ml605_mmu.c
>>>> index cf3b9574db3..bbda70aa93b 100644
>>>> --- a/hw/microblaze/petalogix_ml605_mmu.c
>>>> +++ b/hw/microblaze/petalogix_ml605_mmu.c
>>>> @@ -127,6 +127,7 @@ petalogix_ml605_init(MachineState *machine)
>>>>       /* 2 timers at irq 2 @ 100 Mhz.  */
>>>>       dev = qdev_new("xlnx.xps-timer");
>>>> +    qdev_prop_set_bit(dev, "little-endian", true);
>>>>       qdev_prop_set_uint32(dev, "one-timer-only", 0);
>>>>       qdev_prop_set_uint32(dev, "clock-frequency", 100 * 1000000);
>>>>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>>>> diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/ 
>>>> microblaze/ petalogix_s3adsp1800_mmu.c
>>>> index fbf52ba8f2f..9d4316b4036 100644
>>>> --- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
>>>> +++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
>>>> @@ -114,6 +114,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
>>>>       /* 2 timers at irq 2 @ 62 Mhz.  */
>>>>       dev = qdev_new("xlnx.xps-timer");
>>>> +    qdev_prop_set_bit(dev, "little-endian", !TARGET_BIG_ENDIAN);
>>>>       qdev_prop_set_uint32(dev, "one-timer-only", 0);
>>>>       qdev_prop_set_uint32(dev, "clock-frequency", 62 * 1000000);
>>>>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>>>> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
>>>> index 23238119273..f87c221d076 100644
>>>> --- a/hw/ppc/virtex_ml507.c
>>>> +++ b/hw/ppc/virtex_ml507.c
>>>> @@ -230,6 +230,7 @@ static void virtex_init(MachineState *machine)
>>>>       /* 2 timers at irq 2 @ 62 Mhz.  */
>>>>       dev = qdev_new("xlnx.xps-timer");
>>>> +    qdev_prop_set_bit(dev, "little-endian", false);
>>>>       qdev_prop_set_uint32(dev, "one-timer-only", 0);
>>>>       qdev_prop_set_uint32(dev, "clock-frequency", 62 * 1000000);
>>>>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>>>
>>>   Hi,
>>>
>>> with this patch applied, the ppc_virtex_ml507 functional test is now 
>>> failing for me ... could you please double-check whether "make check- 
>>> functional-ppc" still works for you?
>>
>> Thanks, not this patch problem, but patch #2 misses:
>>
>> -- >8 --
>> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
>> index 23238119273..723f62c904b 100644
>> --- a/hw/ppc/virtex_ml507.c
>> +++ b/hw/ppc/virtex_ml507.c
>> @@ -219,2 +219,3 @@ static void virtex_init(MachineState *machine)
>>       dev = qdev_new("xlnx.xps-intc");
>> +    qdev_prop_set_bit(dev, "little-endian", false);
>>       qdev_prop_set_uint32(dev, "kind-of-intr", 0);
>> ---
>>
>> Why is my CI green?
> 
> Looking at https://gitlab.com/philmd/qemu/-/pipelines/1664238124 it 
> seems like you did not start the functional test jobs?

Doh, while doing my PR process I forgot even using push-ci-now these
need to be triggered manually :S

> 
>   Thomas
> 


