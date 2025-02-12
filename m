Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D72C0219E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 09:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti9TK-0003KF-Hg; Wed, 12 Feb 2025 04:55:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ti9TG-0003Jn-Kd
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 04:55:55 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ti9TD-000883-DS
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 04:55:53 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4395560cc13so15716375e9.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 01:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739354149; x=1739958949; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FWTCE0WK/+egeqss2g3f/1+zdR8N0yBBKf5XenaL1AA=;
 b=ouQRb7S5o6ykeg8XYsn0MdQ6+5rDpoGr1oD7ZlwbZdkvMnwid1vj/Gga3QW+UsFDIe
 T01VN3rmj61qfgIF5xT63wNmYO2uRY3x0O87jDxSO6N4BrFoepcCA3SoxYFK8nUJ2ZCo
 ofGdsvEKUCdT5D8xhF/rvrGxT5LS7uY5uDcXjsNNDA54wo25+/PLMJ5w88JNsklg8YVF
 6LKPSo14Lrq4/6/dHH4A66X6+0Drnscn0V1wpSZ8+1fXtt3wLKVg3m6kljCq1ta69QHG
 p2BTMm/kLphDz16MznEwLHXhCQTSRFC7j1kNlv1BwhjVIHN+Bk1ig+xM319tdNSF3TW+
 +6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739354149; x=1739958949;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FWTCE0WK/+egeqss2g3f/1+zdR8N0yBBKf5XenaL1AA=;
 b=VvKiHwH26JaV3Qx6JcS4JocJNG7r3lMSGCN0wb7O8QOz6+xpnK4yV8fFh4jy0pkIhJ
 RRJxOKcnXTiFZNkoZnTdPJ6rO+uTPEfcqW/gm4WkDTkR3HD6qs/KDZU47eH1NteGKzI8
 lMDmMwXBn8ghOUKZKY3D83zH4CeaB97A9uVAiTnzchdjVxCGT2SB1iqQoK8yh97NvBW2
 qHwscI7TqzJ3CaPNAA09q3X641UfHL/Y+teWWAjy+sFwsTuMB6Ra9cjhWCmW6cMAkv4v
 Kxpay0HuHmmfpDPVnAvpleZImASGvCr4eKfHvlpU8LRnwnRU8j8hVkzOfSxFTdZMFFO1
 g57A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcbYz1tVJuylJxVaVPjDxPV/hG1WOsHF1tVv+zKA76Ga2Eh7Pm+Y5LzgRa1pLU5WRf/D+cf7Y12kIS@nongnu.org
X-Gm-Message-State: AOJu0YyGHKHAMiSv++v6ow8KZsfqgPayFEK+bGgbZDZIdv7i+CdSxFhs
 6XTqY3I9/qIFD97pWfIIXflygjIdG0b/PQH1/s2LbpmYtZpl9Pw7e0oyCyx1NUM=
X-Gm-Gg: ASbGnctLGfhOGaK34NuaNl5hTzE5p5T7rjO7CR5Aurn+ycGkPiCV/cwZ4DVXpo2yCQf
 tRPiJMIqVEb9bkUr5GivI5XfrNVn1m4Zjc0OHhjx7mgYp6Da0rBeKub8ETS0vClFWCPGxJU0AM+
 ve7bov7vw+qoUnymm4qxIhlwDuDIaLBIkQj4erkoWrAJKKQG/AVGANCQlQvXVlxHiwo+ipG6KZI
 icPyUp05AmESks6yn1kKt7Jdwv9GEggkpZkfJpJY9L/WWnMDDQW2F/MBbKxFzQBX4KQ8EbZfw7+
 740TGJVXAi+QvdGJiGq4BYaO8NlB/wuDoxrVQ8BZrB9aDJTE8YXeY1+oI9A=
X-Google-Smtp-Source: AGHT+IEVkBZVBewOpy72Ob7fbPNntLsVTtwQGGf4oHAP618zc0ERMfD34/GEq+rzW8h7OhASudXzvg==
X-Received: by 2002:a05:6000:4027:b0:38d:d4b5:84d6 with SMTP id
 ffacd0b85a97d-38dea25b016mr2059408f8f.3.1739354149191; 
 Wed, 12 Feb 2025 01:55:49 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a058930sm14717995e9.17.2025.02.12.01.55.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 01:55:48 -0800 (PST)
Message-ID: <4071305a-7c91-47d0-b2dc-6478761c67a1@linaro.org>
Date: Wed, 12 Feb 2025 10:55:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 04/32] hw/timer/xilinx_timer: Make device endianness
 configurable
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
 <20250210204204.54407-5-philmd@linaro.org>
 <678561c5-4d06-494a-b12c-6013b07f3b05@redhat.com>
 <03446903-2100-4981-831e-7ee4741ffead@linaro.org>
 <68ac2807-93f6-469f-a78b-c17a994d4142@linaro.org>
Content-Language: en-US
In-Reply-To: <68ac2807-93f6-469f-a78b-c17a994d4142@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 12/2/25 10:34, Philippe Mathieu-Daudé wrote:
> On 12/2/25 10:19, Philippe Mathieu-Daudé wrote:
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
> 
> It looks to me like another "default value problem", where using
> a tri-state with default=unset would have catched.
> 
> "disas/dis-asm.h" defines:
> 
> enum bfd_endian { BFD_ENDIAN_BIG, BFD_ENDIAN_LITTLE, BFD_ENDIAN_UNKNOWN };
> 
> Maybe endianness is common enough than we can add a QAPI enum,
> in machine-common.json or even common.json?
> 
> Then I'd use qdev_prop_set_enum() here.

I'll post a series doing that.


