Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C202BC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 09:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti98J-0005QC-Po; Wed, 12 Feb 2025 04:34:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ti98H-0005Ou-Gi
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 04:34:13 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ti98F-0002RZ-B2
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 04:34:13 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ab7c07e8b9bso538490466b.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 01:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739352849; x=1739957649; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NVwxXSehIagIhjvE3ICr7Wpe/rPfG8nSs7sIZtt5SVA=;
 b=tgj5FhehFpNzNI6XLg7ZTWksT2+LT/JE8WyCOFJPfzl8FJhkuksUXA1jZpMqWripPE
 MhzTjCNRk+fD0+8ADkxlhOF/Y+lOlNUEamVL4UfQGcvG1fYha4qvT4EXHWlgYNMczJOH
 VGWzOTszJ2vU2ZD7MrKg3pllaxhzqzivgkulTBPifQdSEgsoVOjOXvvlQUIudN6ZE793
 8+zp8kXEuuwdV1eV1D3GIVjtvu8VXDxFRLWm3jj9YjvilGisxt9lwd8yZfueCvn7tvTH
 TvgihbEorjcYlIdVg6pdBw+/V5aIhsIez3+FE9v3dmfSW07VC28BVy3sZ/ehBvYUMuzV
 f7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739352849; x=1739957649;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NVwxXSehIagIhjvE3ICr7Wpe/rPfG8nSs7sIZtt5SVA=;
 b=DQHx6O3xYZU8G+lHVA7lNH09+Ardte7OCqzYsS3Ibgzq077GRFt3AaxARf8qXklsnz
 aKEBlOk4dp8RQpB6o51+R3WIF57M9nOS8DLEhZnEWPqg93nzn1D1lY8iHJM3v4RYFgK9
 jpxLDa+IWlWiTR5XEXvDwDM1eyHiy40dYjQpml1xKvtTi+EIkPyB+1d2yhhw3HTb7HEZ
 hn6QTxE2I6d2AV1BwPp8EiIPVYdFbOCmMED9IfSKTwZYbsVbfE0MEAKFzQ4elEfvQ7Om
 Qp/iBausp10fuEnryu446nxHuhh8tKJDiqX5W6K8XLO5qAnacIsNZN7q0sYWfqUx7Qmo
 j0tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSpUN61SiPILBS1J9u5J2lLBIYxThBMp9ksxDG9mp/gbL2gIa1+kCG3jMNMjoCh3MYLSZi0XMneN8Y@nongnu.org
X-Gm-Message-State: AOJu0YxfgwWvHSSQyO9JLbGibq0Uzo98aPId24LW6I5TH0dnZq4VwmoL
 jX3p6y/nGMUhvmMzcfdsSOocsBSOoDmvJ5YB3RomfgkNuAdInB6e5YcOZkR+tc4=
X-Gm-Gg: ASbGncvB3cL3WIDKyZgBWTIhenEGctvjxnPcEhVZnfvFSW1nnf11cYHwtOjR/6FXg/E
 DwowYC95S01K2hMtPvAOFSFhZQUdn+vElIbB7BheUBlEyLptjYCVKHfxlCoMQFApUyD1ENK4JeJ
 ayQQJn/8phHTmkxWuir9Lrw0v23zLGMMa1BV3FRE7yHxGlf+qllxKb5juo06zsbXJHclnamPGG/
 rYM/6se+FLZH5lm7ozEoqZJyZ378Smy6KYucJBa4MElmruDz2p+UkHROGnp9Q658l54rviBiXCu
 EjBFIXb4zhhXkZja2eAY9fQYyIQcjZ3c/AZbYMvWBQs6sTZiZIughwetIyU=
X-Google-Smtp-Source: AGHT+IFn9gdWXXdb2YkfecRYntvPBiwQd4gS3zanB7mGKJa2RBYC74x8O8iHsbNbCSKaykxXGvjm7A==
X-Received: by 2002:a17:907:97c5:b0:ab7:d4b0:9254 with SMTP id
 a640c23a62f3a-ab7f33f5f77mr194580066b.26.1739352849425; 
 Wed, 12 Feb 2025 01:34:09 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5de4ef37eb4sm9159891a12.7.2025.02.12.01.34.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 01:34:08 -0800 (PST)
Message-ID: <68ac2807-93f6-469f-a78b-c17a994d4142@linaro.org>
Date: Wed, 12 Feb 2025 10:34:08 +0100
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
Content-Language: en-US
In-Reply-To: <03446903-2100-4981-831e-7ee4741ffead@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

On 12/2/25 10:19, Philippe Mathieu-Daudé wrote:
> On 12/2/25 09:27, Thomas Huth wrote:
>> On 10/02/2025 21.41, Philippe Mathieu-Daudé wrote:
>>> Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair
>>> of DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
>>> Add the "little-endian" property to select the device
>>> endianness, defaulting to little endian.
>>> Set the proper endianness for each machine using the device.
>>>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Message-Id: <20250206131052.30207-5-philmd@linaro.org>
>>> ---
>>>   hw/microblaze/petalogix_ml605_mmu.c      |  1 +
>>>   hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 +
>>>   hw/ppc/virtex_ml507.c                    |  1 +
>>>   hw/timer/xilinx_timer.c                  | 35 +++++++++++++++---------
>>>   4 files changed, 25 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/ 
>>> petalogix_ml605_mmu.c
>>> index cf3b9574db3..bbda70aa93b 100644
>>> --- a/hw/microblaze/petalogix_ml605_mmu.c
>>> +++ b/hw/microblaze/petalogix_ml605_mmu.c
>>> @@ -127,6 +127,7 @@ petalogix_ml605_init(MachineState *machine)
>>>       /* 2 timers at irq 2 @ 100 Mhz.  */
>>>       dev = qdev_new("xlnx.xps-timer");
>>> +    qdev_prop_set_bit(dev, "little-endian", true);
>>>       qdev_prop_set_uint32(dev, "one-timer-only", 0);
>>>       qdev_prop_set_uint32(dev, "clock-frequency", 100 * 1000000);
>>>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>>> diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/ 
>>> microblaze/ petalogix_s3adsp1800_mmu.c
>>> index fbf52ba8f2f..9d4316b4036 100644
>>> --- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
>>> +++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
>>> @@ -114,6 +114,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
>>>       /* 2 timers at irq 2 @ 62 Mhz.  */
>>>       dev = qdev_new("xlnx.xps-timer");
>>> +    qdev_prop_set_bit(dev, "little-endian", !TARGET_BIG_ENDIAN);
>>>       qdev_prop_set_uint32(dev, "one-timer-only", 0);
>>>       qdev_prop_set_uint32(dev, "clock-frequency", 62 * 1000000);
>>>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>>> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
>>> index 23238119273..f87c221d076 100644
>>> --- a/hw/ppc/virtex_ml507.c
>>> +++ b/hw/ppc/virtex_ml507.c
>>> @@ -230,6 +230,7 @@ static void virtex_init(MachineState *machine)
>>>       /* 2 timers at irq 2 @ 62 Mhz.  */
>>>       dev = qdev_new("xlnx.xps-timer");
>>> +    qdev_prop_set_bit(dev, "little-endian", false);
>>>       qdev_prop_set_uint32(dev, "one-timer-only", 0);
>>>       qdev_prop_set_uint32(dev, "clock-frequency", 62 * 1000000);
>>>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>>
>>   Hi,
>>
>> with this patch applied, the ppc_virtex_ml507 functional test is now 
>> failing for me ... could you please double-check whether "make check- 
>> functional-ppc" still works for you?
> 
> Thanks, not this patch problem, but patch #2 misses:
> 
> -- >8 --
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index 23238119273..723f62c904b 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -219,2 +219,3 @@ static void virtex_init(MachineState *machine)
>       dev = qdev_new("xlnx.xps-intc");
> +    qdev_prop_set_bit(dev, "little-endian", false);

It looks to me like another "default value problem", where using
a tri-state with default=unset would have catched.

"disas/dis-asm.h" defines:

enum bfd_endian { BFD_ENDIAN_BIG, BFD_ENDIAN_LITTLE, BFD_ENDIAN_UNKNOWN };

Maybe endianness is common enough than we can add a QAPI enum,
in machine-common.json or even common.json?

Then I'd use qdev_prop_set_enum() here.

>       qdev_prop_set_uint32(dev, "kind-of-intr", 0);
> ---
> 
> Why is my CI green?


