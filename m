Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2861CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 15:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utTAK-0000cN-Lr; Tue, 02 Sep 2025 11:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utTA6-0000b6-P4
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 11:43:12 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utTA2-0006qg-Kv
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 11:43:08 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3cbb3ff70a0so3487091f8f.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 08:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756827782; x=1757432582; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SZEk4ilO5qotE2GtoIspKZt9DlOJZImaOJXhEQ91E5M=;
 b=LjgcICBn4yKOhmlu6xaUUg4agjmVPQfyfBmR57yqTT3z8EI9inrucqCid9fNC1TjZl
 9mclHo5VupzAXBEHMx6tWwTJfPQbyYQWkJtLxoK5n9Et0jXI7lSHZWrKFWw9TOyXt0wu
 /LtDUs9FizHojc3NzZEqQ2/46eG0bcbktR6LKnLtYv9orrYcf6UfK18JOiqfK7Sfp0IU
 Bu305jgzolHUXiSfglMT6lI2bObnkyw6ievEaLc6bU+t34jrOv3EcDKEJWYKOERk7eAp
 CJkRxahKHpholuHsrmclys9RpTJaG62H6Xr5+wDucPLIcU4IfZgmXBgNAAgkOlvcvINq
 E8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756827782; x=1757432582;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SZEk4ilO5qotE2GtoIspKZt9DlOJZImaOJXhEQ91E5M=;
 b=MvQAOlRtkN6FycX4xcF+DJ445LSlhL4853hg4nzSMZOEbq5S0qo5EoRJZoTB1hWq7k
 ZdaVrLScujbRrwWnsOEVSoOl2U9Xnxny2KXqPafXi0jYifSGZRoybAmUOej4Jv5aMaHM
 gfruZ1hM+pRoVckm+v8BzkTcCZogvd9fN+8K6RGXtwE1Nsr6ZXXfEnBLte3ZWefc0O+a
 xzfYHhPgcCybyi96xdWqR0DTbTuFAbzOfcSPUFyE05mRhx59Tr9tpeEJkgwyCTfg0smS
 LtHAI75u810fkKVqX78zi0p0k9ScSBQSDdKGHvnX+Xz0Y4DxJnyqaHACoZuYlsbzUtRx
 ZHbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbp6T6HlfuOtP1coPW24h6M5bfOkRJe25RtQHy+S4caGzoYRsFnwrMqLjeEUSAd67sWOv6H3YJWGg8@nongnu.org
X-Gm-Message-State: AOJu0YxmMkY+RDbpJ6ckwUQWzbIZyF/fyx9lJdZ0XZJeUx1BFimAJNC1
 Xa7FAKmdZYp5Kpx1gqt6Ttfvgim5ffVWTrFPbSK4l3C4bQKU9hss6TBkEexxvNftJiY=
X-Gm-Gg: ASbGncuYRXJAVMCK1+kMm/c+V6vga8wpCK1XQWX2PsLqesr1V/iUYN788x+bzyWWQYq
 +8qHmMUAoyj8n6Vs3mDZ2zitLoXRO8P4KIdVCYTv3J4n8YaUIF3Q/16oEj2CHwMHY84oTbcvLnH
 iATmevmm2VscGxnj+HrpNS4bt0WTYcMUD3ADaYTkcXIUgYgbzYtGG3PVeH3bE/s7jodtCjwMvxD
 UNvof1AOqmVGR4Vp8lMPMU3hfDmeKgqcFooIaKpekcJkveC8ZkZz78g7fcY+kkJ5eIolUe4qmKT
 udzIpWA3k3yfgs6KD16CPsT6/mk4prsMgHIoKSGtYXQ9Uzn92OgQ4+W4g16qGrynlvZMqq2Cqbv
 4mZd3CyBnRM1AMVzEalGaiVHVjYdF4pq/nHMHOt7k9bdMZ13HxDk1JolsyXisWgJWp0NxOufQqP
 Ur3lzO5W+s0lI=
X-Google-Smtp-Source: AGHT+IEam3PC4AtHPgcfDNJ+IT5Ceqp+qSQYGaWo339w/39IsP7DZe9C9LEFSdGWdkVZskajE/TEtw==
X-Received: by 2002:a05:6000:3103:b0:3d8:22c4:1baa with SMTP id
 ffacd0b85a97d-3d822c425b2mr3625656f8f.37.1756827782177; 
 Tue, 02 Sep 2025 08:43:02 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33add504sm19883538f8f.30.2025.09.02.08.43.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 08:43:01 -0700 (PDT)
Message-ID: <11808e86-cee0-48bf-8fbd-de13a9a25ed0@linaro.org>
Date: Tue, 2 Sep 2025 17:43:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] hw/sd/sdcard: Fix size check for backing block
 image
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>
References: <cover.1756706188.git.jan.kiszka@siemens.com>
 <86217712232abd5152e7dfa98111f57b9b78d83b.1756706188.git.jan.kiszka@siemens.com>
 <6289fe04-82be-4a34-9fed-b0cc08e3b8f0@linaro.org>
 <a9fdf524-0ca1-45db-be39-7bfccc468f0f@siemens.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a9fdf524-0ca1-45db-be39-7bfccc468f0f@siemens.com>
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

On 2/9/25 17:34, Jan Kiszka wrote:
> On 02.09.25 17:06, Philippe Mathieu-Daudé wrote:
>> On 1/9/25 07:56, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> The power-of-2 rule applies to the user data area, not the complete
>>> block image. The latter can be concatenation of boot partition images
>>> and the user data.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>    hw/sd/sd.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>> index 8c290595f0..16aee210b4 100644
>>> --- a/hw/sd/sd.c
>>> +++ b/hw/sd/sd.c
>>> @@ -2789,7 +2789,7 @@ static void sd_realize(DeviceState *dev, Error
>>> **errp)
>>>                return;
>>>            }
>>>    -        blk_size = blk_getlength(sd->blk);
>>> +        blk_size = blk_getlength(sd->blk) - sd->boot_part_size * 2;
>>>            if (blk_size > 0 && !is_power_of_2(blk_size)) {
>>>                int64_t blk_size_aligned = pow2ceil(blk_size);
>>>                char *blk_size_str;
>>
>> This seems to break the tests/functional/arm/test_aspeed_rainier.py
>> test due to mmc-p10bmc-20240617.qcow2 size:
>>
>> Command: /builds/qemu-project/qemu/build/qemu-system-arm -display none -
>> vga none -chardev socket,id=mon,fd=5 -mon chardev=mon,mode=control -
>> machine rainier-bmc -chardev socket,id=console,fd=10 -serial
>> chardev:console -drive file=/builds/qemu-project/qemu/functional-cache/
>> download/
>> d523fb478d2b84d5adc5658d08502bc64b1486955683814f89c6137518acd90b,if=sd,id=sd2,index=2 -net nic -net user -snapshot
>> Output: qemu-system-arm: Invalid SD card size: 16 GiB
>> SD card size has to be a power of 2, e.g. 16 GiB.
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/11217561316
>>
> 
> Hmm, then the test was always wrong as well. I suspect the aspeed is
> enabling boot partitions by default, and the image was created to pass
> the wrong alignment check. Where / by whom is the image maintained?

Cédric Le Goater (Cc'ed).

The test comes from:
https://lore.kernel.org/qemu-devel/4d1777d6-0195-4ecb-a85f-09964268533d@kaod.org/

Maybe also relevant to your suspicion:
https://lore.kernel.org/qemu-devel/e401d119-402e-0edd-c2bf-28950ba48ccb@kaod.org/

