Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0290C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0L5-00058U-4C; Mon, 22 Jul 2024 17:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sW0L2-00050J-O2
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:12:57 -0400
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sW0Kx-00067H-5Q
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:12:56 -0400
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7f70a708f54so205889739f.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 14:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721682769; x=1722287569; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dcVf5xUSfMyZzLAwJeFUCVkHH+WQRogq6/+R0xNjMS4=;
 b=H0+qZpcF20XyrQKbZ/qp94RC3YV6/sb6YJCVhxVLinbfI43pK4GOFjX1bdoPDLG9u8
 AKYFpp4RNa9hVH92PlOxb0c/b7CmCj6ZwUSVeivJ1pWXTTj2m0ekOTdOOI6H0pwWT7oM
 RYcA2BRqIXpcGts+HVl5pz1PfcItpQoKmWjeuyxuX2/scu8aM1uxnCxhzR0uXmbVdOMz
 optSoKbFnsIGh9TnwI00JeM87O7FvQW3++tz4cWmKxI4U+rWLRiRfaa0zxFjBNphYFYa
 a1b8vkeEu6h0+LS1QB2/3Kpv2CT53ioGDRyQWnovcIKWOMK6QJCnoHLo6Wbtz9jsoAM6
 qm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721682769; x=1722287569;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dcVf5xUSfMyZzLAwJeFUCVkHH+WQRogq6/+R0xNjMS4=;
 b=I/jD5ZvEHf3s7Ysy+O9TZbjVZ6nTkfmghSqrslqCOQhQj708xxEcsWmA5GXxWjBo5Z
 JLeHkTLpgPxei2Y7eL0Bx7KryBZtaM4NInTPwgVdhxlfB/kz8uAClebGavf0g9cv4Ej+
 KIrcwgI1Iu2OFcY3PVgJUvvWABs4wUYThT1xI5po/PuVs5SZLWtzw7OOax/m0+s8B/qi
 53qUwr0Rbgz6H+VA9pBaEycV35QmLdVjMCc6kj1MPbwtPkyjeu9kQ3TpHndeiCMtTnq+
 rHK3WM7Npjxq5x4OVTzFU/HVXsRwEYzty8CyeuE9BAX3xQoIijHkSlwzGl3U/rdrOsGL
 7UfQ==
X-Gm-Message-State: AOJu0YwySLMsS8CG7yY9Cnn6vXQoI47NkPtgZcyV5vur59ipgqqdCbm7
 VtpFdUms7sb7nYVBQtR8Evv0aP1QyA7yPerwDXOIFgsu9pHa0l2rtO2Nrtd6M5o=
X-Google-Smtp-Source: AGHT+IEvwP1LZ+/PjNCJbRQTXIFGNYOBAQsbou8uZuNYfOZiRJrXzBJd36yY6C+7Jl4F2JTLs4UsDA==
X-Received: by 2002:a05:6e02:1a44:b0:383:8ec6:6d17 with SMTP id
 e9e14a558f8ab-39a0c7fb29emr14677625ab.0.1721682769410; 
 Mon, 22 Jul 2024 14:12:49 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.14])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70cff59cb7dsm6004314b3a.144.2024.07.22.14.12.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 14:12:49 -0700 (PDT)
Message-ID: <daad7f23-92f0-4b8f-b0c6-a1e8510f3702@linaro.org>
Date: Mon, 22 Jul 2024 23:12:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i2c/mpc_i2c.c: Fix mmio region size
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Andrew Randrianasulu <randrianasulu@gmail.com>,
 Amit Singh Tomar <amit.tomar@freescale.com>
References: <20240721225506.B32704E6039@zero.eik.bme.hu>
 <8ab5cfc4-3360-4b2e-9679-8566aea9b890@linaro.org>
 <5ccba9c4-50ec-7d55-4d34-14a925662563@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5ccba9c4-50ec-7d55-4d34-14a925662563@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2f;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd2f.google.com
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

On 22/7/24 12:16, BALATON Zoltan wrote:
> On Mon, 22 Jul 2024, Philippe Mathieu-Daudé wrote:
>> +Amit & Andrew
>>
>> On 22/7/24 00:55, BALATON Zoltan wrote:
>>> The last register of this device is at offset 0x14 occupying 8 bits so
>>> to cover it the mmio region needs to be 0x15 bytes long. Also correct
>>> the name of the field storing this register value to match the
>>> register name.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>>   hw/i2c/mpc_i2c.c | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>>
>>> @@ -329,7 +329,7 @@ static void mpc_i2c_realize(DeviceState *dev, 
>>> Error **errp)
>>>       MPCI2CState  *i2c = MPC_I2C(dev);
>>>       sysbus_init_irq(SYS_BUS_DEVICE(dev), &i2c->irq);
>>>       memory_region_init_io(&i2c->iomem, OBJECT(i2c), &i2c_ops, i2c,
>>> -                          "mpc-i2c", 0x14);
>>> +                          "mpc-i2c", 0x15);
>>
>> Personally I'm not a big fan of non-pow2 regions, so I'd have picked
>> 0x20 or 0x100 where the 2nd i2c controller starts. Amit, what do you
> 
> Coverung unused areas isn't a good idea because that would omit invalid 
> read/write warnings when those are enabled so it's harder to catch 
> unimplemented registers that way. So 0x100 is definitely overkill, 0x20 
> could be acceptable as other regs are also covering some unused area 
> after them but is also unnecessary when we can cover exactly the area 
> where the register is.

Yeah. I'm queuing this patch via hw-misc, thanks.

