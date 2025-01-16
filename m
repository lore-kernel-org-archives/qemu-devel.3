Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20E4C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 15:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSFZ-0000c5-1P; Thu, 16 Jan 2025 10:57:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYSFX-0000b8-Bp
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:57:39 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYSFV-0008Ek-Sq
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:57:39 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-436637e8c8dso10426885e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 07:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043056; x=1737647856; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sgywbnAY+FtfIBUT6SqmzPvm0ofX88tcaLBV3njidT0=;
 b=v1IW2nENYKYHsayFsHqXRu5iYnTDTKotyndnLKa7UQ0e5+6YA1OV+ps5oQO1n3SoMf
 8hjui1XL+kSpBAdyn2QhPwaiIgwSzzZYSlnDOWtdvz2Zs3IZqTQhqRgtRywTgL6UOvDj
 sQ9ksgylA2b+aNyWvuu6J8QhhLNMed8o+o+CrS3SDJw04TYV8F9jIivI9gvYmLzhkDpC
 t4fQa0zmyqwkMV9FnO7lyTTWlU3xF96ukdLMroM0EpsB32LDMPG0/fc6MFw8xDm5lAeL
 SPYbOipVc4lM1x9IYZW5YNDwLoYiDaTpoKfcAdVTq+V/QjPadOL/V4gLb2zYL/7bsUuG
 1Lmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043056; x=1737647856;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sgywbnAY+FtfIBUT6SqmzPvm0ofX88tcaLBV3njidT0=;
 b=CLogLK9dpZ1W97pDFzHDnoSdKq9wI5dwXJ4ZtyAMnQnUaClXy20lL9UMUEh3aU7Kk3
 urBZr5g85fzWSfhpajAK+FqKhNVJSfV6H81R38pc+gBfWEC+EWLSY6GxC5HBHk2//A9D
 0SzcYXlXIBQl+GhGzL2zAZ2aN1u9weUBcfSLB9AYxkPn75mp77uK260osMqUQmBKTRgR
 snZyKmVP0+vPn/E0TJJVa8J3GciTYkDt6OIPrZNVjo+rD27deeYyHaNH+haXOuDN4o+S
 sBMTVGoH8Go8xkJxEGG/Bsuy2J/D7yUsrhASxRLVI3bVb0ILJd9FgDyiBS6V97nDkYk6
 1OIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBNSwputNp2C1xfe1G61G6Gcy/gID0BNSl3PQyW2dy3onsqQvELLdUMw5lKJGoJny4bQPKj0lSjyZJ@nongnu.org
X-Gm-Message-State: AOJu0YwlwFlzTSdJEHULMKltB3vLy9mKSadJ3xFSDbwVaKVdkEO49CqF
 BGV308jDg6E6Vh8QBUU05sjW5TMUQoR3yShBh3Jw/OI10PzRO7um6oQSdRulZiY=
X-Gm-Gg: ASbGncsSSY+/YW10JAT8GY3RZNbSaPobj8xUeAE54zwjpDoHRHOlHy/qsF3NQ/wtNtn
 MnYhq3y82TU5P0BNf/xljzynITn4ZQV32qwKoPT2CmsTImvFcWQzFDx/+q1CQ0Ojf9Dk+KKIYNC
 g6ZqdPtJENAGuYkdPCeiZ8X3NliCjvDLsdp3vL8H+9/4974SdYzCZK+3q/jae9bm7cE41i15WN2
 2Fo13Qa5v20FzAae/CCny0Q4dGbzik0X2hr/Mrok/Eaxxl+d4kw5iVOBqI4kY20xsyvYIcLM+EH
 YgZEYr7u8RXJIldfYtdceFJv
X-Google-Smtp-Source: AGHT+IHtGmVUo9l1YzT0QHd8IhOxBxBtUhmdNblKGJmwXL0MgVx2PjDEheVajabPHRhz95EK24V/lA==
X-Received: by 2002:a5d:47c4:0:b0:385:f16d:48b4 with SMTP id
 ffacd0b85a97d-38a8733046dmr33267171f8f.40.1737043055965; 
 Thu, 16 Jan 2025 07:57:35 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf327decbsm190957f8f.90.2025.01.16.07.57.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 07:57:35 -0800 (PST)
Message-ID: <c6c34207-a59f-43f0-92d8-1af3b101e0c5@linaro.org>
Date: Thu, 16 Jan 2025 16:57:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] hw/acpi: Add vmclock device
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Cornelia Huck <cohuck@redhat.com>,
 Peter Hilber <quic_philber@quicinc.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>, paul <paul@xen.org>
References: <20250116140315.2455143-1-dwmw2@infradead.org>
 <20250116140315.2455143-4-dwmw2@infradead.org>
 <56e3ad5c-758b-4799-86a4-bb503aa34cea@linaro.org>
 <b5850fa317e89e4e0de1bfe478a7d2cfd9422c37.camel@infradead.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b5850fa317e89e4e0de1bfe478a7d2cfd9422c37.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 16/1/25 16:32, David Woodhouse wrote:
> On Thu, 2025-01-16 at 16:15 +0100, Philippe Mathieu-Daudé wrote:
>>
>>> --- a/hw/acpi/Kconfig
>>> +++ b/hw/acpi/Kconfig
>>> @@ -60,6 +60,11 @@ config ACPI_VMGENID
>>>         default y
>>>         depends on PC
>>>     
>>> +config ACPI_VMCLOCK
>>> +    bool
>>> +    default y
>>> +    depends on PC
>>
>> This doesn't look right (apparently the kernel side also build on ARM).
> 
> I don't think it's strictly wrong; there are no circumstances in which
> PC is set not I386 && ACPI, or vice versa? I was just going from the
> existing setup for VMGENID, which I think could also theoretically
> exist on Arm too?

Unfortunately PC (and MALTA) are bad examples, beeing ones of the
oldest QEMU machines. Their code is spaghetti.

ACPI_VMGENID seems over-restricted. IIUC it should be:

     select ACPI
     select FW_CFG

The idea is to keep the smallest dependency, i.e. if someone wants
to build a binary with only microvm machine and use vmclock in it,
it shouldn't have to build the PC machines.

>> I'm only seeing e820_add_entry (I386) and ACPI API called. So:
>>
>>       depends on I386 && ACPI

Actually the Kconfig should be:

     select ACPI
     depends on I386

>> If later we want ARM support we'll have to rework the e820_add_entry()
>> call.
> 
> Sure, that certainly makes it easier to add Arm later, and I really do
> intend to do so. I've done it in my tree. Thanks.


