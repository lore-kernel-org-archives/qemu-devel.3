Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA88C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 16:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZZ1h-0005sV-2l; Thu, 01 Aug 2024 12:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZZ1f-0005rz-8p
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 12:51:39 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZZ1c-0000q9-Uy
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 12:51:38 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3685b3dbcdcso4002180f8f.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 09:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722531095; x=1723135895; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hfYXU/9f3xWlX2Xhivq7cPfsuP9qqDgAw2oGd7GPKMU=;
 b=Vt0OwETR3gDRmChm+KsSzmoQMbTR/InrlO9ugx8jpSf4lFMr4ro4Hk/6vvoO/9OJUw
 PrYZFeSO10F6zQiDfEXMDIf7YC6znZvQdAxRIUAvtuIBXKViRtPMCrusJUD/yWVcUqxW
 zYqyvGxKPVFFzj1mMOhuE6KYo9MRSxSlFDBNjWjZiSo42Ee3PG618jYYMcE3pfbQwSnJ
 Ruu2YbinZcA/7fNcVlPDp2aoKikxwndmDtzPNt0Y9f13hKFRaA6lc9OQR8aZLm1rm9dR
 yJXmf76PblJVjJcFRojbOzl7yzHc7ZusbmoP0p58tvpz1Vb91vh47Z4n82iR1G2Kg+3m
 YV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722531095; x=1723135895;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hfYXU/9f3xWlX2Xhivq7cPfsuP9qqDgAw2oGd7GPKMU=;
 b=piAD32zEyH2121f5Wfrk9l7xQwkJxJGX7N7FPxo05YcjmvwCWycv8mJTWzus5/93kq
 j+91yqQzRaDqVvwTrW4xAoOsiWM34PGTYtGMEwaXk9Xeq7CUX/AfPnEX8he2pidLVgzl
 uVvy8JsgpgWw89Eo0VwXa1IDt0iQcYgMJHtyFE4aBgko2RKPzYIdAB/QDmxfvlXRpDhv
 siwFK1gwRbRBdp6DRu82soXCmBb2IQyTjZQPuB2bwMQSEY9wh+Nxd3CtG4Cid7rcxb8G
 ToAln4qgH7mCgs1FLDz0GIgk1HkmQ/VV0Q+M8vM6S6n4+6CKlUbtfrUbpor3rkCYcY0f
 5Jxg==
X-Gm-Message-State: AOJu0YykYnKtHV66mX+bgA0qTy+nT9ZxBhJ91Ag42Rrq8rMkRTpSfGO9
 Hp5yrLOnnQIyBVUd+Mvs5yHtXT9MfBYKCgmwRdu7s1CkUPnkwvr/crad+aO/tD86wYSq0nMo9hb
 OKTA=
X-Google-Smtp-Source: AGHT+IFhrU3/HncR6s9Rz3h6npk9Um1FlZRJWsdEf9crSdSMeAIxy+s3Jfmkid6qSuOMXniaxpYJ3Q==
X-Received: by 2002:a5d:5918:0:b0:367:97fd:1d75 with SMTP id
 ffacd0b85a97d-36bbc12bd31mr332152f8f.27.1722531094834; 
 Thu, 01 Aug 2024 09:51:34 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.94])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd0597ddsm16268f8f.77.2024.08.01.09.51.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 09:51:34 -0700 (PDT)
Message-ID: <b2e586da-9975-4814-8783-b26e2653ee70@linaro.org>
Date: Thu, 1 Aug 2024 18:51:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 2/2] hw/pci-host/gt64120: Set PCI base address
 register write mask
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
References: <20240801145630.52680-1-philmd@linaro.org>
 <20240801145630.52680-3-philmd@linaro.org>
 <20240801105917-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240801105917-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 1/8/24 17:02, Michael S. Tsirkin wrote:
> On Thu, Aug 01, 2024 at 04:56:30PM +0200, Philippe Mathieu-Daudé wrote:
>> When booting Linux we see:
>>
>>    PCI host bridge to bus 0000:00
>>    pci_bus 0000:00: root bus resource [mem 0x10000000-0x17ffffff]
>>    pci_bus 0000:00: root bus resource [io  0x1000-0x1fffff]
>>    pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
>>    pci 0000:00:00.0: [11ab:4620] type 00 class 0x060000
>>    pci 0000:00:00.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
>>    pci 0000:00:00.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
>>    pci 0000:00:00.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
>>    pci 0000:00:00.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
>>    pci 0000:00:00.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
>>
>> This is due to missing base address register write mask.
>> Add it to get:
>>
>>    PCI host bridge to bus 0000:00
>>    pci_bus 0000:00: root bus resource [mem 0x10000000-0x17ffffff]
>>    pci_bus 0000:00: root bus resource [io  0x1000-0x1fffff]
>>    pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
>>    pci 0000:00:00.0: [11ab:4620] type 00 class 0x060000
>>    pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00000fff pref]
>>    pci 0000:00:00.0: reg 0x14: [mem 0x01000000-0x01000fff pref]
>>    pci 0000:00:00.0: reg 0x18: [mem 0x1c000000-0x1c000fff]
>>    pci 0000:00:00.0: reg 0x1c: [mem 0x1f000000-0x1f000fff]
>>    pci 0000:00:00.0: reg 0x20: [mem 0x1be00000-0x1be00fff]
>>    pci 0000:00:00.0: reg 0x24: [io  0x14000000-0x14000007]
>>
>> Mention the datasheet referenced. Remove the "Malta assumptions ahead"
>> comment since the reset values from the datasheet are used.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/pci-host/gt64120.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
>> index b68d647753..344baf55db 100644
>> --- a/hw/pci-host/gt64120.c
>> +++ b/hw/pci-host/gt64120.c
>> @@ -1224,6 +1224,13 @@ static void gt64120_pci_reset_hold(Object *obj, ResetType type)
>>                    PCI_STATUS_FAST_BACK | PCI_STATUS_DEVSEL_MEDIUM);
>>       pci_config_set_prog_interface(d->config, 0);
>>   
>> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_0, 0xfffff009);
>> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_1, 0xfffff009);
>> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_2, 0xfffff009);
>> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_3, 0xfffff009);
>> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_4, 0xfffff009);
>> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_5, 0xfffff001);
>> +
>>       pci_set_long(d->config + PCI_BASE_ADDRESS_0, 0x00000008);
>>       pci_set_long(d->config + PCI_BASE_ADDRESS_1, 0x01000008);
>>       pci_set_long(d->config + PCI_BASE_ADDRESS_2, 0x1c000000);
> 
> 
> if you are tweaking wmask, I think migration will fail.
> So you have to make this depend on machine property, and
> put in compat machinery.

Fortunately we don't need because this device is only meant to
be used by MIPS machines which aren't versioned.


