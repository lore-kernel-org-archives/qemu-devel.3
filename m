Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA18C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 18:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqymd-0001w3-JW; Sat, 08 Mar 2025 13:20:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqymZ-0001uk-5U
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 13:20:19 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqymX-0005q3-01
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 13:20:18 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso402305e9.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 10:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741458013; x=1742062813; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GaCWPmmWZF61pyG4+vMQcp5KkwiZ3AB8hQSKdoQ401E=;
 b=LLHrADUSDkG/VBAReoU7Q5pEDPYQhg+cA7IrFeVHou38D62mW8+nDhjORPKFea7NGK
 l7V5/le7OXNftj6qK3DTQSzx7LTmLpCzxPBUPTGC5BqxJQpxkBh7G/eSHIWFZzlJdFFB
 JOPjnknTYMkDnPJojlBkUS4ih4EPykjwfk1TA6iNeIpiN2fHCcG9fTKMWsCEyJQacxKi
 AoZRJhjjg8hZWXYPWe8ZquO/QajOU/1zY54wUJV2G2KHK3WgMLjp6jmHS8NfgQaZwliI
 UhPDaxE+DsoOi7G32sSWKWf6dBKUG0FDmgJBascMjlMVMBPf78ihHBhHH/b/DaITLSdY
 sa6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741458013; x=1742062813;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GaCWPmmWZF61pyG4+vMQcp5KkwiZ3AB8hQSKdoQ401E=;
 b=YIxf/zbbfXpabLtOR5jXjM7yVwTNyj7yixdy3ihVPoAJ/Z1rS7mUsInK4T+co2llIr
 S7jnUrGtiM6Qrem0/9SZf/z0XXNHVFILab/fGhd5jOyaVGOvweTRzr0fPJQXdJdh+0I3
 riwCchTc+tDl+/jnWQuxA8MaF+3uUBf6xwZB+TJ1j6auPf3P1SH9KKWSssBlzHu6e+cc
 afZZtZbtKkkqNBLrNNXXP4kJ7IEx6AP3pxI8+5GRGpKFc8KooBQaAwRWubOz3beP09h+
 CnKIgCLyy3G3hmwgVOgtPkecYhCT33woRTyw6/nmRAQ2gCmCCPNJvIVQIHMGyYrKJsMT
 QnBw==
X-Gm-Message-State: AOJu0YxYCZA4iKrD0jEY3Y3Fz2NdtZkXcg1jklxFw4JO+hdYHAzPwtUD
 4M99eiLFeMxg26DBdNpcC+ZGvF9c2RTxWiY9Yz/PRowmkWdjwKcHecW9FBlYa0E=
X-Gm-Gg: ASbGncv3H45BBVZp0tcixdlhrvPYK4ZvcYSA10v1cVoFtra8nJPL7FBG6U0a16MuUn0
 rUHfYyJNZHXHhe4XTld/x8ijD16ZuwxwgUgiwjtPhmA3CYqdU5DcO7Nx5cAyIStPTmhGUvI9b3W
 lwKcn6bh+FEw3oLYF0L+E+7kpcABcy4pzeI/eRlB2nDLn6PQBzaQJ06/e5RSKx/DiGInREkhtmh
 ZmNdzROokwCsj5anqrXHIAXdHDsjA+KoMrU3LkEjoSgohInIsT2FJzk4Jnzd4l7eZ5qGrzWj0W0
 WfP+rrSkj3ch/l5cML7ZkmtBRTvAPyMYMJBrJpsPFCcfZOHW3PGWnAQzcmXVFsYV17spPLyJwii
 cC/wZJTnxHXXb
X-Google-Smtp-Source: AGHT+IEPY9Q16QBMg+fkil/gnGsGwhsasslDD/UGDNjnTbG9huCjsqiNmr4QMbGq5sEMxiv2d7t5oQ==
X-Received: by 2002:a05:600c:1908:b0:43c:ec28:d31b with SMTP id
 5b1f17b1804b1-43cec28d58fmr14895815e9.10.1741458013055; 
 Sat, 08 Mar 2025 10:20:13 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ceafc09d5sm23352155e9.31.2025.03.08.10.20.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Mar 2025 10:20:12 -0800 (PST)
Message-ID: <48e0cbeb-3346-4911-8457-925b0a60ff96@linaro.org>
Date: Sat, 8 Mar 2025 19:20:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/sd/sdhci: Set reset value of interrupt registers
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>
References: <20250210160329.DDA7F4E600E@zero.eik.bme.hu>
 <918e9ae0-fb22-43c7-a2cf-376aaee0e98b@linaro.org>
 <ad0e4bde-40dd-db32-b8d9-46c27c257aa3@eik.bme.hu>
 <0f3814d3-7c27-fd50-2ad3-b4d5344d9fc1@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0f3814d3-7c27-fd50-2ad3-b4d5344d9fc1@eik.bme.hu>
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

On 6/3/25 19:23, BALATON Zoltan wrote:
> On Mon, 3 Mar 2025, BALATON Zoltan wrote:
>> On Mon, 3 Mar 2025, Philippe Mathieu-Daudé wrote:
>>> Hi Zoltan,
>>>
>>> On 10/2/25 17:03, BALATON Zoltan wrote:
>>>> The interrupt enable registers are not reset to 0 on Freescale eSDHC
>>>> but some bits are enabled on reset. At least some U-Boot versions seem
>>>> to expect this and not initialise these registers before expecting
>>>> interrupts. Use existing vendor property for Freescale eSDHC and set
>>>> the reset value of the interrupt registers to match Freescale
>>>> documentation.
>>>>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> ---
>>>> v2: Restrict to e500. Adding a reset method in a subclass does not
>>>> work because the common reset function is called directly on register
>>>> write from the guest but there's already provision for vendor specific
>>>> behaviour which can be used to restrict this to Freescale SoCs.
>>>>
>>>>   hw/ppc/e500.c         | 1 +
>>>>   hw/sd/sdhci.c         | 4 ++++
>>>>   include/hw/sd/sdhci.h | 1 +
>>>>   3 files changed, 6 insertions(+)
>>>>
>>>> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
>>>> index 26933e0457..560eb42a12 100644
>>>> --- a/hw/ppc/e500.c
>>>> +++ b/hw/ppc/e500.c
>>>> @@ -1044,6 +1044,7 @@ void ppce500_init(MachineState *machine)
>>>>           dev = qdev_new(TYPE_SYSBUS_SDHCI);
>>>>           qdev_prop_set_uint8(dev, "sd-spec-version", 2);
>>>>           qdev_prop_set_uint8(dev, "endianness", DEVICE_BIG_ENDIAN);
>>>> +        qdev_prop_set_uint8(dev, "vendor", SDHCI_VENDOR_FSL);
>>>>           s = SYS_BUS_DEVICE(dev);
>>>>           sysbus_realize_and_unref(s, &error_fatal);
>>>>           sysbus_connect_irq(s, 0, qdev_get_gpio_in(mpicdev, 
>>>> MPC85XX_ESDHC_IRQ));
>>>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>>>> index 99dd4a4e95..afa3c6d448 100644
>>>> --- a/hw/sd/sdhci.c
>>>> +++ b/hw/sd/sdhci.c
>>>> @@ -307,6 +307,10 @@ static void sdhci_reset(SDHCIState *s)
>>>>       s->data_count = 0;
>>>>       s->stopped_state = sdhc_not_stopped;
>>>>       s->pending_insert_state = false;
>>>> +    if (s->vendor == SDHCI_VENDOR_FSL) {
>>>> +        s->norintstsen = 0x013f;
>>>> +        s->errintstsen = 0x117f;
>>>
>>> I'd rather do like capareg, and add:
>>>
>>>  DEFINE_PROP_UINT16("norintstsen", _state, norintstsen, 0),
>>>  ...
>>
>> I don't see what you mean. capareg does not seem to be set via a 
>> property.
>>
>>> Then SoC code sets it:
>>>
>>>  qdev_prop_set_uint16(dev, "norintstsen", 0x013f);
>>>  ...
>>>
>>> WDYT?
>>
>> I think it may be overkill to add properties for this if there are no 
>> other vendor or variant that needs this. Also properties are for 
>> something the user may want to set as those can be changed with QEMU 
>> command line and these reset values aren't something the user should 
>> change so I think this patch is the simplest solution now.
> 
> This patch wasn't in the pull request but I haven't seen an answer to 
> this message either so was it missed or do you have furhter comments? 
> Bernhard has a comment about naming of SDHCI_VENDOR_FSL but I think the 
> already existing IMX name is what's wrong not the one added in this 
> patch but I don't think that's really that confusing to worth further 
> effort. We still have time as this can be considered a fix but I'd like 
> this to not get forgotten so I bring it up again.

I'll post a v3 with what I had in mind.

