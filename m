Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABAC3C28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 14:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trHWA-0002lP-US; Sun, 09 Mar 2025 10:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trHW9-0002kE-2V
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 10:20:37 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trHW6-0002bM-GF
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 10:20:36 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso4664645e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 07:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741530032; x=1742134832; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3D+54oeVa7Fu6Truwxl080HVFieDV+B30R54rKr/+W4=;
 b=a9Yz3cy4yZ902pGjaiITV2icFnbS/CMgzU9q9eVnCfueyqXypGN8L2jJfCQ9vTSjOT
 U9YH6lm8iQ1cRxwRoUFhBNmj521rikksggwSam/VeR8DZs7yps/2uAONv7qnRCaCBSu2
 6S3upfjbVOkuyRZ4UbBQjlEVDBJThoDOMWYqfblv3YsMbblcKJisNdTyTFtyqV1M7qgE
 ebuq8JRNNbjHaERoOCXfmR03hdCwgD74d924kJrR2JvfOh4Q9zNwG4BXAVYSv6wtuqzu
 YnO5M0H+mr9oPuH7QDBp17ZO1DHHLuTU2EXo4Ybdt+ydKMOQjPjn8aOf9FbU0mDyMoQm
 yd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741530032; x=1742134832;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3D+54oeVa7Fu6Truwxl080HVFieDV+B30R54rKr/+W4=;
 b=XT2+DLPxZRL293hhhO27tvshd38dqxXrvNrpRXb7ikKby1DcHWw/4co+nWEZ8Fw+Ra
 bsI55JdKk5rZbgjO2Q7V8MwZnIeW+fbLec87jCFIu13ByCrpCHRL+Vx/oonw731ATkEf
 MBVe8S36crzkg2iDZuUMBV45+lM6d5B7YDLwwBIdvSaAkyXzhtrQwMJkMWcUjbJUOtfD
 7Ki64HcIWTiKr734L9MNCtUMExT2ktCFzjuN0mAqYJG9FBLzyqu3zNwHMDTt6k+YRkva
 UM/xYxaHGhn5LAPZ20KYzP9HUXjf3LGIumAlMIYLjSPKYtNmM3e8IqpzbF6/XahNRz2s
 0YYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3GcaT96MZm/rcbLuGy8tI2hznmuAI2ZAi6+jYOw7dCJiShOKO21RbbfeqbTmf62CKro8QbArKOXAk@nongnu.org
X-Gm-Message-State: AOJu0Yx2OPsEA/qbJYJWTa2rn/+Z/YJNLbQwde/UfdhuVodb8iVAAtNj
 hWyicdJlJL280nsKyfmrymr0b24eroOF4eIk2u4nFMEir9QNaU97Cr8QF2vYaBA=
X-Gm-Gg: ASbGncuUlWpicX0KIt2JeOzObDaO1sm+VSPddOMzgz3B6Y/jBA/sQAbJkVIb8/khali
 hm1KO0Oa7uQJ4mUHhKaIwSqi53gWRpsfqwydoD3nZsngBS6NcHZRdt/MMcir7gNtaP2Oycmx5Du
 SONkMr7a2K3umkdgpaLfHsyHAmbzvAl4Y+puEAkOOORWS0LlVAW5QaIk1afbdGufv40CLuOhQvr
 r1fy5xjEpbfp0fYkPFetd6FxIKuEQoUXldh/k1aM7IZcMcRmzRkYMlYv96xiKSYv60z69+88gwF
 bHqe/N3BNRXk5kmvN0XqSiUDEgEHVYSPvywkIYQzr37kmQj1/kqiJuLfpk95j9RD9Iiuj+1Onst
 4zDxG9DWfPhn1
X-Google-Smtp-Source: AGHT+IHRYdM3B+PIG/TzHNAJg8acZVklC4NUJKMtLVlFaGPbuZjAzBfla4VCtls/IuxkbP1o+yeb8A==
X-Received: by 2002:a05:6000:1fab:b0:390:f476:81c3 with SMTP id
 ffacd0b85a97d-39132d51364mr5599054f8f.20.1741530032141; 
 Sun, 09 Mar 2025 07:20:32 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cf1b36d14sm22790515e9.37.2025.03.09.07.20.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 07:20:31 -0700 (PDT)
Message-ID: <33b01373-6046-4b96-9407-66966c5b7f36@linaro.org>
Date: Sun, 9 Mar 2025 15:20:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/14] hw/sd/sdhci: Introduce SDHCIClass stub
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Guenter Roeck <linux@roeck-us.net>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org
References: <20250308213640.13138-1-philmd@linaro.org>
 <20250308213640.13138-4-philmd@linaro.org>
 <1839f9de-2370-50bd-7003-ade92707f137@eik.bme.hu>
 <142807a2-9536-4483-80ab-5f24793c841f@linaro.org>
 <670a5a3c-3476-5b8d-775a-ebff83acc33d@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <670a5a3c-3476-5b8d-775a-ebff83acc33d@eik.bme.hu>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/3/25 01:08, BALATON Zoltan wrote:
> On Sun, 9 Mar 2025, Philippe Mathieu-Daudé wrote:
>> On 8/3/25 23:34, BALATON Zoltan wrote:
>>> On Sat, 8 Mar 2025, Philippe Mathieu-Daudé wrote:
>>>> TYPE_SYSBUS_SDHCI is a bit odd because it uses an union
>>>> to work with both SysBus / PCI parent. As this is not a
>>>> normal use, introduce SDHCIClass in its own commit.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>> include/hw/sd/sdhci.h | 9 +++++++++
>>>> hw/sd/sdhci.c         | 1 +
>>>> 2 files changed, 10 insertions(+)
>>>>
>>>> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
>>>> index 48247e9a20f..c4b20db3877 100644
>>>> --- a/include/hw/sd/sdhci.h
>>>> +++ b/include/hw/sd/sdhci.h
>>>> @@ -107,6 +107,13 @@ struct SDHCIState {
>>>> };
>>>> typedef struct SDHCIState SDHCIState;
>>>>
>>>> +typedef struct SDHCIClass {
>>>> +    union {
>>>> +        PCIDeviceClass pci_parent_class;
>>>> +        SysBusDeviceClass sbd_parent_class;
>>>> +    };
>>>> +} SDHCIClass;
>>>> +
>>>> /*
>>>>  * Controller does not provide transfer-complete interrupt when not
>>>>  * busy.
>>>> @@ -123,6 +130,8 @@ DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,
>>>> #define TYPE_SYSBUS_SDHCI "generic-sdhci"
>>>> DECLARE_INSTANCE_CHECKER(SDHCIState, SYSBUS_SDHCI,
>>>>                          TYPE_SYSBUS_SDHCI)
>>>> +DECLARE_CLASS_CHECKERS(SDHCIClass, SYSBUS_SDHCI,
>>>> +                       TYPE_SYSBUS_SDHCI)
>>>
>>> Are these two together just OBJECT_DECLARE_TYPE? Then the above 
>>> typedefs are also not needed just the struct definitions.
>>
>> I'd like to but it isn't possible because the same object state/class is
>> used by distinct types (PCI & SysBus).
>>
>> The following (expected to be correct) change ...:
>> -- >8 --
>> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
>> index 966a1751f50..341b130995b 100644
>> --- a/include/hw/sd/sdhci.h
>> +++ b/include/hw/sd/sdhci.h
>> @@ -155,10 +155,6 @@ typedef struct SDHCIClass {
>> #define TYPE_PCI_SDHCI "sdhci-pci"
>> -DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,
>> -                         TYPE_PCI_SDHCI)
>> +OBJECT_DECLARE_TYPE(SDHCIState, SDHCIClass, PCI_SDHCI)
> 
> It would be same as the original patch if you omit this one and only use 
> OBJECT_DECLARE_TYPE below.

Indeed that works. Kind of a kludge. Not worth than what we have, so
I'll take it.

> You didn't add CLASS_CHECKER to the PCI 
> version in the original patch either. But I see now it's more complex 
> and so maybe it's not so easy.

Yeah, I'll postpone the QOM parentship cleanup for later.

> 
>> #define TYPE_SYSBUS_SDHCI "generic-sdhci"
>> -DECLARE_INSTANCE_CHECKER(SDHCIState, SYSBUS_SDHCI,
>> -                         TYPE_SYSBUS_SDHCI)
>> -DECLARE_CLASS_CHECKERS(SDHCIClass, SYSBUS_SDHCI,
>> -                       TYPE_SYSBUS_SDHCI)
>> +OBJECT_DECLARE_TYPE(SDHCIState, SDHCIClass, SYSBUS_SDHCI)
>> ---
> 
> [...]
> 
>> Meanwhile the current legacy macros seems good enough for soft freeze ;)
> 
> Good enough for me. I was also happy with my way simpler solution. This 
> is much more clean up already.
> 
> Regards,
> BALATON Zoltan


