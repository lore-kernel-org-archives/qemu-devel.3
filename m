Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C4CC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 06:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd2uz-0006CB-Jg; Thu, 22 Feb 2024 01:50:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rd2uw-00068Q-5O
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 01:50:50 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rd2ui-0001cF-Mn
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 01:50:49 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e4c360f945so658213b3a.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 22:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708584635; x=1709189435;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q91DQD4QPuI7n3k7X8EoVwNwznj0QQxjSxMCGaGv5xA=;
 b=QjO86BTgo8iHvlxYlKGpg/hPrU6U+LJ1F0G2HYWx/fDErC0cIqsWC3yBMrO3qb8ela
 RmqTvzfP1SZ3mDviLuGvoNwjRnJcokl5e3hVmXD1+tQtwJOHaeozUVans2jbj/ySR1cO
 RF5BSS2kKTYjSu4bZFxWliux4PeGhvoFTgFuMLcf5d8lPrnaBXPfUGIucCk2Q9lJDBxJ
 yMXgOKz82Bf7Xbx9lfuZopLAl1qYKHdJeHrwrcEIOKByscTqtt4PzqvevQb/vTEY7wQb
 OA5xyLEt903Zkj/sGXfiQK95UOaTrex4NCNqyxCBA//Q8jgBmRy4O7icZLNisAF9QW8R
 UAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708584635; x=1709189435;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q91DQD4QPuI7n3k7X8EoVwNwznj0QQxjSxMCGaGv5xA=;
 b=FUsUUo1APM6+W8jFaoyLv8/wziFXGcxle9kZOLubudI/2MPP1iugeUBj8HjkqWcNVZ
 WawUhob7Zx6LoKIrWhJ1fNcMyNT4LaCFG0WAtibu8IFdv8FprD6zNipNmHVPNSSh3vCz
 Nlz1XzI59WDKFKUfgbJ1t9BS9jQHAaz7CX89Po5ZgWozQizgeYEgRVieAkXvbLQkqCcQ
 EFOX2h/OjQQanxUR8tGni2znrJvZrO8T6B4AIToomenm9/4IHVV/CpTRYdGHDa/Dc6Uu
 UMbtwGw2FnwSoms3/mRhPpwGvi2QiCFN4mGu/6BUoYSIkc27Dy7pDLAooK7Y6XePzWqi
 r1pA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd5LIVNWBEYbPGW2CSxD2gR7sJ5P7tXWphdjxlYQ+zh9aLENesca+nxOmhxWHnSRQbe956kb06Mxw0WZ5g/i0GcwYyFFc=
X-Gm-Message-State: AOJu0YzJ7Bdb4NDw4m8TZww2r60JrIBp9As4qGUB0dgs2zD+hIwfIhXC
 42AgcE01ZDU7JA453Xc8yq3sq3Wp0FKC5BmB3v22rOqHA3RvWYsg7DT78YuXr+E=
X-Google-Smtp-Source: AGHT+IElNqY9lVn1d2v/qSjsSPd7D8ArTCI7Eb9KlR7nrg557wCFje7UeAo+6L6V0qyDD6aS9P0E6A==
X-Received: by 2002:a05:6a00:9a8:b0:6e4:890a:7af with SMTP id
 u40-20020a056a0009a800b006e4890a07afmr6248550pfg.26.1708584634925; 
 Wed, 21 Feb 2024 22:50:34 -0800 (PST)
Received: from [157.82.203.206] ([157.82.203.206])
 by smtp.gmail.com with ESMTPSA id
 j13-20020a62b60d000000b006ddc7ed6edfsm10063491pff.51.2024.02.21.22.50.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 22:50:34 -0800 (PST)
Message-ID: <18af0bc3-356a-4c81-95d4-be93caa4b58c@daynix.com>
Date: Thu, 22 Feb 2024 15:50:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/15] hw/pci: Determine if rombar is explicitly enabled
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <20240220-reuse-v6-0-2e42a28b0cf2@daynix.com>
 <20240220-reuse-v6-13-2e42a28b0cf2@daynix.com> <871q961bed.fsf@pond.sub.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <871q961bed.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/02/21 17:15, Markus Armbruster wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> vfio determines if rombar is explicitly enabled by inspecting QDict.
>> Inspecting QDict is not nice because QDict is untyped and depends on the
>> details on the external interface. Add an infrastructure to determine if
>> rombar is explicitly enabled to hw/pci.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   include/hw/pci/pci_device.h | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
>> index ca151325085d..c4fdc96ef50d 100644
>> --- a/include/hw/pci/pci_device.h
>> +++ b/include/hw/pci/pci_device.h
>> @@ -205,6 +205,11 @@ static inline uint16_t pci_get_bdf(PCIDevice *dev)
>>       return PCI_BUILD_BDF(pci_bus_num(pci_get_bus(dev)), dev->devfn);
>>   }
>>   
>> +static inline bool pci_rom_bar_explicitly_enabled(PCIDevice *dev)
>> +{
>> +    return dev->rom_bar && dev->rom_bar != -1;
> 
> Compares signed with unsigned: rom_bar is uint32_t, -1 is int.
> 
> If int is at most 32 bits, the comparison converts -1 to
> (uint32_t)0xffffffff.
> 
> If int is wider, it converts dev->rom_bar to int without changing its
> value.  In particular, it converts the default value 0xffffffff (written
> as -1 in the previous patch) to (int)0xffffffff.  Oops.
> 
> Best not to mix signed and unsigned in comparisons.  Easy enough to
> avoid here.
> 
> Still, we don't actually test "rom_bar has not been set".  We test
> "rom_bar has the default value".  Nothing stops a user from passing
> rombar=0xffffffff to -device.  See my review of the next patch.

I followed addr and romsize properties that already use -1 as the 
default value. addr is int32_t, but romsize is uint32_t. I'll change 
romsize and rom_bar to use UINT32_MAX as the default value.

This changes the behavior of 0xffffffff, but that should be fine. Most 
people should only set 0 or 1. Maybe someone types wrongly and sets a 
number like 2 or 12, but nobody types 0xffffffff by mistake.

