Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A473EC021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 13:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiDAw-00029C-Fm; Wed, 12 Feb 2025 08:53:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiDAq-0001z9-Ou
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 08:53:10 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiDAn-0004UD-BR
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 08:53:08 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38dcb7122c1so4565764f8f.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 05:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739368382; x=1739973182; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zfbyxcqWj/UiN856rWG2h1KLNYBYxW0dhw/bjjl2hE0=;
 b=aYMeakJWs/OmTBwXGYTQIOS3fnmd2DDTL9fXfNxZpZTHJ3d5qLkv5REWRdHsf14iOV
 p6KvwAeuyCyHzBfauGVUdwSDnAPpYzAl5xGtmxj/B4lpeVoajb5TdwYzE2ZEHgUeFH75
 K2D2HKWl5V2CKqNNsH/FBVBeY/ZXfedFqD7rllAWQGejDGtVi4Q4HdkT4qmLfCnBdsYD
 ocg3iS1zNlqkRqWVJh0xGgMwwPfRakFKDSX//mNtwPqUDrujVHCBg5x5poOpEpRV1zsa
 dPG/iqtLVwT03vQ1vb65gLpCQbDJ01U+SGK3iWcwOix8c9+FNgSZKoiTjN2wvKjcT/rg
 aAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739368382; x=1739973182;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zfbyxcqWj/UiN856rWG2h1KLNYBYxW0dhw/bjjl2hE0=;
 b=f1IZXty/l3QVcrz7YpGqEbHM+furNj+CiCRKizpwVI9ShmHp3/HNtgv6YOLVin8SAz
 xyTQTgWcz7AF1XH8/WDcFad/7KuOt9gJXtxAdDNf6Pv951pv9mNDj+AL7WFsAMui+F8L
 4LLDA9spBOaw35hI0fIVs4z8Dlu4D9bhf2s911bArf+Ip7Uc0HJs/4hh1240priztF5F
 vHHAybaruafR3/LRaj/fBAl2VwDXAraGq0JWcs5BshOqLbzcG28+/wre8SuTWV/GbHIi
 5GzYd4kYAKRTujC61kil6HLQC79/awCqBw0npJ6e3pdbCYFv3hWkc9RpOBdG4fMmF6ba
 Q22A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtF8to8gqC1dJufEAW0Xn/GUrpnw7Sv8K0R3H2JbJiqFTyl+PnI52PxYmc7eOxjtIo2kYejYgOt53s@nongnu.org
X-Gm-Message-State: AOJu0YxNJXqoq3aRMB4sFQiFyU/6F5ecamyx+M7QbyRz71AsIJkzYqDo
 5pig7S1/3dH9fTFvQw2nDvd8d8CgyT6jDSU+1enrJ33IFMqhar48vW5wW1kV/BXWFCESP7eI1FN
 /pWw=
X-Gm-Gg: ASbGnct++GWBOQNNQ2jfnXCWBUeNoeYGaqnBJXlY81S9lfrvHQiPELMjrSVhMcJneXK
 DHXBBSfACpXZZV8zBf/S2eAkHxAuVgYI4i1z5/DzOMfSZg/HvwI4X0di4gG54DYSXWB9MgwQ2MQ
 MIyZv0h21pQQ8aTIb3k5tORYGtjqh/D1E587KlRTVjLTxoJp/DNoEi3U1fAg7W1lloYkjLTOEeQ
 kG3i3EcAGR2Jqev+biAgkm1Ij62M928TgvvIWbUDXC3OsdOfgKWJ5HEQhIV0kWbUsSU0cvyjaQm
 Zen9EI2XId3IZ3ia3sLC0dxtZMSfBXjqpIDznF34/GTZ85nqSmExZUeYcvg=
X-Google-Smtp-Source: AGHT+IG/lfKP5G5CHY8c8pWMzE2yIWajKjW/XutuPwpU8TFbNmxnOtW2rm8Qjh6SBqJv2JE67Z8zcg==
X-Received: by 2002:a05:6000:bd2:b0:38d:dc0d:8f4c with SMTP id
 ffacd0b85a97d-38dea270ec9mr2169095f8f.20.1739368382142; 
 Wed, 12 Feb 2025 05:53:02 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc33939f3sm16776390f8f.17.2025.02.12.05.53.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 05:53:01 -0800 (PST)
Message-ID: <6e707c7f-b94c-47ef-83ab-795605e27963@linaro.org>
Date: Wed, 12 Feb 2025 14:53:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/11] hw/qdev-properties-system: Introduce EndianMode
 QAPI enum
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250212112413.37553-1-philmd@linaro.org>
 <20250212112413.37553-2-philmd@linaro.org>
 <cb828dd8-25f6-47c6-9ac7-cae5b0d0932e@redhat.com>
 <50ba4e4b-4124-46bb-bb84-4758ce9c5e66@linaro.org>
 <3b3baed4-0d79-3a28-40cd-e1835e078863@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3b3baed4-0d79-3a28-40cd-e1835e078863@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 12/2/25 13:56, BALATON Zoltan wrote:
> On Wed, 12 Feb 2025, Philippe Mathieu-Daudé wrote:
>> On 12/2/25 12:37, Thomas Huth wrote:
>>> On 12/02/2025 12.24, Philippe Mathieu-Daudé wrote:
>>>> Introduce the EndianMode type and the DEFINE_PROP_ENDIAN() macros.
>>>> Endianness can be BIG, LITTLE or unspecified (default).
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>   qapi/common.json                    | 16 ++++++++++++++++
>>>>   include/hw/qdev-properties-system.h |  7 +++++++
>>>>   hw/core/qdev-properties-system.c    | 11 +++++++++++
>>>>   3 files changed, 34 insertions(+)
>>>>
>>>> diff --git a/qapi/common.json b/qapi/common.json
>>>> index 6ffc7a37890..217feaaf683 100644
>>>> --- a/qapi/common.json
>>>> +++ b/qapi/common.json
>>>> @@ -212,3 +212,19 @@
>>>>   ##
>>>>   { 'struct': 'HumanReadableText',
>>>>     'data': { 'human-readable-text': 'str' } }
>>>> +
>>>> +##
>>>> +# @EndianMode:
>>>> +#
>>>> +# An enumeration of three options: little, big, and unspecified
>>>> +#
>>>> +# @little: Little endianness
>>>> +#
>>>> +# @big: Big endianness
>>>> +#
>>>> +# @unspecified: Endianness not specified
>>>> +#
>>>> +# Since: 10.0
>>>> +##
>>>> +{ 'enum': 'EndianMode',
>>>> +  'data': [ 'little', 'big', 'unspecified' ] }
>>>
>>> Should 'unspecified' come first? ... so that it gets the value 0, 
>>> i.e. when someone forgets to properly initialize a related variable, 
>>> the chances are higher that it ends up as "unspecified" than as 
>>> "little" ?
>>
>> Hmm but then in this series the dual-endianness regions are defined as:
>>
>> +static const MemoryRegionOps pic_ops[2] = {
>> +    [0 ... 1] = {
> 
> This is already confusing as you'd have to know that 0 and 1 here means 
> ENDIAN_MODE_LITTLE and ENDIAN_MODE_BIG (using those constants here as 
> well might be clearer). It's easy to miss what this does so maybe 
> repeating the definitions for each case would be longer but less 
> confusing and then it does not matter what the values are.
> 
> Or what uses the ops.endianness now should look at the property 
> introduced by this patch to avoid having to propagate it like below and 
> drop the ops.endianness? Or it should move to the memory region and set 
> when the ops are assigned?

I'm not understanding well what you ask, but maybe the answer is in v7 :)

