Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B6EC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 16:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZZ1z-00065r-65; Thu, 01 Aug 2024 12:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZZ1w-00064c-8H
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 12:51:56 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZZ1t-0000su-Cm
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 12:51:55 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-428035c0bb2so13743115e9.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 09:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722531111; x=1723135911; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fiyAA99o6BBsuJwiHEPgeXOgq2sEvsUPG2YrT4GL3wE=;
 b=PeqnXP0j402t1YDBuOMk6wHtU6b1G0Q/tk6Fa2VtNbMpjHScu9tTh2oFS8LBti2lyR
 evDnIWYDbPayx8p3WaDY292YLf+Wx5bMdYJX3Ws57GqxC5i+Z55DW3QEMe1QrTLAls99
 TsoUsy+iETCeqfX4BgI44EalAxJ2hTHLaqgc2mUyLse8cqA3BZ3INzFZKuGvkBdBlHFZ
 cKWJV+TaYAilSOGU0o16YKJJefE55LiFRqIdDopo3V5EwpEIb4s9ClqzI4G+9q7439el
 6DxKqiuJYst6c1yi+SOUvjbKkgzZBfUCX3yabp7sj4xkb1hkAIIzPg4fI3uurk90NxrO
 EOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722531111; x=1723135911;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fiyAA99o6BBsuJwiHEPgeXOgq2sEvsUPG2YrT4GL3wE=;
 b=SIDrJauBaKDW30sqy2Tx7IK8SnDk36mgVqd+pd3qytQ/94ohWa6/gJsuSdc5GhOBye
 x+9N+5O9Hmx6cOUF4hCozmou2pUOkTiA57Az+AH8u+9MbjEuVaTqic0HA6H7UNlVQxLG
 UlJ/O7jI3YZKnw1buuAX9vJN7gLd+8y+S2bSc+hQOyXZL4GibnFGnoYtvvQspkp/uRhn
 W7tf6f4iPouSjgCJLdSWgCv3J420zJahrM6jEKPa0sDc1H1gDW7Kl3yMgw5YWCxFUwuL
 vja7tv+Sx2qG/qNhu7nEGwyTlHQcjmb5rn/uopbzhlNT3li3r9dwTZoYoeepjrufd7oZ
 /6qw==
X-Gm-Message-State: AOJu0Yz9T3RLkqurr947v79HLTv1DaCMb6/6TGlnkjcnjsugtzuj7tsK
 RE1DZ9dFebPCdv9mZ1miOsT3A3w6ny8BrQL+lhGcOF1se6OM9/w2x2YS+eb2dEY=
X-Google-Smtp-Source: AGHT+IGC67z5iLUmukMN2JxfEeo82ESEvCt7uv3zCnzgkwD4v4+jIxd8zne8Ip+QCpIymimw9LOyrw==
X-Received: by 2002:a05:6000:2a88:b0:36b:bb99:d7ce with SMTP id
 ffacd0b85a97d-36bbb99e185mr1215824f8f.9.1722531111427; 
 Thu, 01 Aug 2024 09:51:51 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.94])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e6d6b8e4sm3025045e9.3.2024.08.01.09.51.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 09:51:50 -0700 (PDT)
Message-ID: <03f213d3-c083-4b4a-a65a-bff6eddc4ca4@linaro.org>
Date: Thu, 1 Aug 2024 18:51:49 +0200
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
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

I'll mention that in the description.


