Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32E6D1D478
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 19:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdvJA-0004a9-9K; Thu, 08 Jan 2026 14:04:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdvJ3-0004ZB-NO
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 14:04:27 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdvIz-00025u-Mt
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 14:04:23 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7bab7c997eeso2695182b3a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 11:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767899060; x=1768503860; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IJAd3A7sc1bs3tGkitGFBFkL6F3glP55XDyOfLrD+rQ=;
 b=nFkDgxBwwFkDPJC3X6NUmsgT4iKkXEjpR2lP5u3vNbn/DjCo8jTgUAtFs7v+xJUMTm
 XLcoUgo+TBuOwRJhUia/ytLSu3W9OHmzuGas1cGQhyYfU1t6cP1ZnhmhSyyKF10aFMJn
 6hlVavfjZv4h1eTNEQ8IuLMNZvHtrM6MO0TslWtFgC2SjK86DoAJsS91+ay+u1v8ILWF
 WqO3OKa/OMQoiYXBb831fYM7qSdltAcTVIX18ed77wH7HT5s8sJQWYuZQz4pfR7zNP0Z
 G3PfIGzh8QfV9GrRiJuKmmTGNnPevrDsQVGvk0W8vbRJh8hOpYNvNFzS51OtdCKhL9FH
 tZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767899060; x=1768503860;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IJAd3A7sc1bs3tGkitGFBFkL6F3glP55XDyOfLrD+rQ=;
 b=s7n4bHFvFDrC6qxqngt7surITYlkxoV+hk8vC2+gHqp4Qsh94zJ8pH/II6ix9K9T09
 Abj6Azh/Rge3gbigizj6McIyHxZ8ah7Q3639ePyv9/eRo3NToMlRQiddIeAJ8fTF5grZ
 jH2xDkPwgO1N33ISPfwAtYAk+ngGtD7OUlVAaTcoSz83FD5Cr08wyxQgTNdy4rOiFK7k
 l03X14kQAHJJisOa4R0Nn+Oukqao/CELKv7h01Yejk+pYCAUsFb2emHZYPdQRuofuvIj
 vnPgx3CaCNQF1A4BWN/Jq+4KSJFuJGZkd7JkJE8MowrlMZWdGEnlaJlAQs6gHxvD1rVI
 f5iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaQien/9GKpj2XsfRt9HRJCU6TC2ISqltkkdbmeZMqffQi3r5YkfCR8TJV5PvTJVpZrtTeLZLHpy1Q@nongnu.org
X-Gm-Message-State: AOJu0YynAQ5I4It0uSTHIc5uCqfgsEItAUTDbBbax+sE34rWTBbT2TeA
 Nv6UOHtdqSLFNXKTNH3Af6EnKSsqK0x/hkscGC/ZyblfCTdlF3CLgPcM/3VgDOD9gtw=
X-Gm-Gg: AY/fxX7BBl9K+04Hjr+JNBvr6q3HxSj4gZu5OlNTX/BtqKNvPDZDygv+BLCx2IFpO4E
 O0pvarAidY77mmizLqsjYG0RiNKN2Yp1P+zYxEM3iW0g9/ycy3ftJ3nqfEb4SOv5RucQRRYeWAz
 fzmuaBEGmssfcGf3p8ic4+9Ikumg/53py25fdlaQOW4ZJeSHN/P5N/o40ACzxOL6xA94EHWGTuo
 +9zI/Q1xzqrQztcii8sm12o6I+RIfth9ympQrgl/NomzrXYyeIj8zjT7pLhwXLyrfjcjIj2c2RS
 Z2T/pvVtK0Yh17LVQT0Wabs7/6PsgP0mZIYigzWdjlOejNv2FRMGztK6cPIckvxyE6iR3511JY7
 tT5q/WI7AImP7nYDcnU7MIb070TDg51uCeh6g/G2xZLuDktqRQxV58dkRzhvyl1gm+jUHPVRQI+
 jRPLbpUlxYV1YgXmvoRccxKc2KVMlKjqUWlzsMXL1SH7D4k1DxGcf2sdFU/CrYEyJRqzk=
X-Google-Smtp-Source: AGHT+IEbaFFnJe5pNBtv7W5I684Wl8LSwqHvyfimH+5nY+MZYVQphpvuPABlyMzPiTjCCsD0ydvtZQ==
X-Received: by 2002:a17:90b:3bcf:b0:340:54a1:d6fe with SMTP id
 98e67ed59e1d1-34f68b67f8bmr6795558a91.15.1767899059730; 
 Thu, 08 Jan 2026 11:04:19 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cb5352268sm8426568a12.0.2026.01.08.11.04.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 11:04:19 -0800 (PST)
Message-ID: <28be2419-8e13-4605-bf66-b0b23d90fb42@linaro.org>
Date: Thu, 8 Jan 2026 11:04:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hw/arm/smmu: add memory regions as property for an
 SMMU instance
Content-Language: en-US
To: eric.auger@redhat.com, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Radoslaw Biernacki <rad@semihalf.com>,
 tangtao1634@phytium.com.cn, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>
References: <20251216235731.1793908-1-pierrick.bouvier@linaro.org>
 <a8afadf0-fcec-444a-86d8-a75676f8bd76@linaro.org>
 <023c6dba-e9d0-46c1-8503-c65ec6df2821@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <023c6dba-e9d0-46c1-8503-c65ec6df2821@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 1/8/26 1:20 AM, Eric Auger wrote:
> 
> 
> On 1/5/26 9:05 PM, Philippe Mathieu-Daudé wrote:
>> On 17/12/25 00:57, Pierrick Bouvier wrote:
>>> This will be used to access non-secure and secure memory. Secure support
>>> and Granule Protection Check (for RME) for SMMU need to access secure
>>> memory.
>>>
>>> As well, it allows to remove usage of global address_space_memory,
>>> allowing different SMMU instances to have a specific view of memory.
>>>
>>> User creatable SMMU are handled as well for virt machine,
>>> by setting the memory properties when device is plugged in.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    include/hw/arm/smmu-common.h |  4 ++++
>>>    include/hw/arm/virt.h        |  2 ++
>>>    hw/arm/sbsa-ref.c            | 16 ++++++++++++----
>>>    hw/arm/smmu-common.c         | 25 +++++++++++++++++++++++++
>>>    hw/arm/virt.c                | 13 +++++++++++--
>>>    5 files changed, 54 insertions(+), 6 deletions(-)
>>
>>
>>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>>> index 62a76121841..9a67ce857fe 100644
>>> --- a/hw/arm/smmu-common.c
>>> +++ b/hw/arm/smmu-common.c
>>> @@ -944,6 +944,13 @@ static void smmu_base_realize(DeviceState *dev,
>>> Error **errp)
>>>            return;
>>>        }
>>>    +    g_assert(s->memory);
>>> +    address_space_init(&s->memory_as, s->memory, "smmu-memory-view");
>>> +    if (s->secure_memory) {
>>> +        address_space_init(&s->secure_memory_as, s->secure_memory,
>>> +                           "smmu-secure-memory-view");
>>
>> Else, are we sure the SMMU implementations will behave correctly?
>>
>>> +    }
>>> +
>>>        /*
>>>         * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie
>>> based extra
>>>         * root complexes to be associated with SMMU.
>>> @@ -1008,10 +1015,28 @@ static void smmu_base_class_init(ObjectClass
>>> *klass, const void *data)
>>>        rc->phases.exit = smmu_base_reset_exit;
>>>    }
>>>    +static void smmu_base_instance_init(Object *obj)
>>> +{
>>> +    SMMUState *s = ARM_SMMU(obj);
>>> +
>>> +    object_property_add_link(obj, "memory",
>>> +                             TYPE_MEMORY_REGION,
>>> +                             (Object **)&s->memory,
>>> +                             qdev_prop_allow_set_link_before_realize,
>>> +                             OBJ_PROP_LINK_STRONG);
>>> +
>>> +    object_property_add_link(obj, "secure-memory",
>>> +                             TYPE_MEMORY_REGION,
>>> +                             (Object **)&s->secure_memory,
>>> +                             qdev_prop_allow_set_link_before_realize,
>>> +                             OBJ_PROP_LINK_STRONG);
>>
>> Why can't we use device_class_set_props(&static_properties)
>> in smmu_base_class_init()?
> 
> We have smmu_dev_properties with a DEFINE_PROP_LINK
> Couldn't we add the new links there?
>

After checking, yes, DEFINE_PROP_LINK could be used for definition.

The important bit is that DEFINE_PROP_LINK uses create_link_property 
which uses qdev_prop_allow_set_link_before_realize, and we really need that.

I'll switch to that in next version, thanks.

Pierrick

> Eric
>>
>>> +}
>>> +
>>>    static const TypeInfo smmu_base_info = {
>>>        .name          = TYPE_ARM_SMMU,
>>>        .parent        = TYPE_SYS_BUS_DEVICE,
>>>        .instance_size = sizeof(SMMUState),
>>> +    .instance_init = smmu_base_instance_init,
>>>        .class_data    = NULL,
>>>        .class_size    = sizeof(SMMUBaseClass),
>>>        .class_init    = smmu_base_class_init,
>>
>> Anyhow this is functional and I suppose this can be improved on top, so:
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
> 


