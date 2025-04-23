Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35199C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 17:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7e8e-0000XA-M1; Wed, 23 Apr 2025 13:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7e8b-0000Sn-Vu
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 13:43:58 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7e8Z-0003Zs-GL
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 13:43:57 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so44981b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 10:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745430233; x=1746035033; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vF9PkYrUkbGN6hTwmeVkzsOC/UQMrYuVEq/9ZDnNCis=;
 b=gTlpGajtZ6kp0VtQuOAqcyRiCOYtrF8GR3ZxM4GK4IN74xf59MFluoiqJBqjJDsVuu
 py6GJ3cd7SawIbUOBc+jDUe1ZsgUyCjA7qvWLVqH9TwjrwNkbOX5W0s7lVN5EC6h1J6N
 oQjXZbkaVHqMFzwdyg38bpitVVppzsQlga8Xs2lNJuKNgL252KYc2QVsq6LVANLKAfIv
 4eNk9tOwOHUJScIsYhspMA3IUxCyfiGfGMF9zXCeJpWgG5sED71m9RooXq7yJEsW+xMQ
 GBWMVPHNL7zUx1bL03y8zs9Exgm7J6ItU4c6Xl1NK9GVNMQmSMShrw0pksQTQh/lfar/
 33Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745430233; x=1746035033;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vF9PkYrUkbGN6hTwmeVkzsOC/UQMrYuVEq/9ZDnNCis=;
 b=kepr4d3WqNBIkYtivi1meIqCSYrzFcZo/XSjdlCPJNgwpNexvgbfEzSSXdyYH59GWV
 GQyE7lagVzII4VaIffqTQbDR/+zEE/faiKnON2qoonf8lFJyRX86XzovOgWWE+WukcSo
 F8eo9CMN2SDTlNDdrEYa7FnTWmXNFW2Hu6LmRsP07OlsqPK4a4sLLpiWhmt9Lzw3HBfC
 VMuVR5MfdJb85i+GiUpgTsqRihjbyjHO2Xh3H6NLLSujVw9q0yVIf3iCGPzAgAY8xHnC
 96esai5fZPs98PADA9KZxWJKKbI/6CI5P60n0rp6NugoFnpdaYXK7jzTdMZtcEH5I0+o
 3SgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/K/NGmU0GMPcxHMS6jLTGtVJv3VmmCEBgiEO2qNVSRMoJXKbcl7X/BCvmJ/qBIByzODOdyKVauxEt@nongnu.org
X-Gm-Message-State: AOJu0YxIzPWY3FH5sufoz85AYaQqonkKzSCAPUA0TJoYuleG1mIJkA5b
 Wziz2/fPlo0Zg+486tpUYWrG4M+33YDI2kX9J8Ono1FmaS2R+enUpRg7RrHHtIg=
X-Gm-Gg: ASbGncsHSc8SiFISsX+KWXeFgWeJLy5aFFnw4/zdCN8ovAPbfZUtWUAS2N89DiKFEZ1
 jK8h3VcYEO+E/krjvlLMV1MMVxT+COEZijGMdtpYXuGy4OcbAZond2cC9AATuITZjegDBF6/a4u
 /SvkFFt7rlKVnDFcVYwxTElZoaaeTWfTYYqxAIhM9tsgrso0s8naZ+5RR7fQfq5N3pOw6R0aS+C
 HpUysxAhNZjWfRThVsauJdSioNsYNQbg5/tgDCHkATMF1MsAn/9xCbleJXSxQ21uDvSAymmCPxN
 mxT+7C0Y9oBkr0lZ2PjbLlIPobJQtNG6bpPzN4NgbOG1gIKKFypKoA==
X-Google-Smtp-Source: AGHT+IF3POn97JLqwt1xQnf/IgfnhlTH3ROgM+w8RuOeKsLwMDIClQTu2M+Hnmi42XKnsqYHqW5kOw==
X-Received: by 2002:a05:6a00:3923:b0:736:d297:164 with SMTP id
 d2e1a72fcca58-73dc14115acmr28257887b3a.1.1745430232830; 
 Wed, 23 Apr 2025 10:43:52 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbf8c06bfsm10846211b3a.9.2025.04.23.10.43.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 10:43:52 -0700 (PDT)
Message-ID: <1937ddb0-a87d-4a87-ac73-3be72ded0c55@linaro.org>
Date: Wed, 23 Apr 2025 10:43:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 06/19] hw/arm: Filter machine types for
 qemu-system-arm/aarch64 binaries
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-7-philmd@linaro.org>
 <a4a65446-07b7-4048-993a-6d0d7848b163@linaro.org>
 <0d3d3209-4513-4366-a105-6b71aa9caa88@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <0d3d3209-4513-4366-a105-6b71aa9caa88@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

On 4/23/25 09:34, Philippe Mathieu-Daudé wrote:
> On 22/4/25 19:40, Richard Henderson wrote:
>> On 4/22/25 07:54, Philippe Mathieu-Daudé wrote:
>>> Since the qemu-system-aarch64 binary is able to run
>>> all machines indistinctly, simply register the
>>> TYPE_TARGET_AARCH64_MACHINE interface for all
>>> existing machines under the hw/arm/ directory.
>>
>> "indistinctly" is the wrong word.  I'm not quite sure what you're trying
>> to say in order to suggest a replacement.
> 
> I want to express that qemu-system-aarch64 is a superset of
> qemu-system-arm machines.
> 
>>
>>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>>> index 82f42582fa3..ce4d49a9f59 100644
>>> --- a/hw/arm/aspeed.c
>>> +++ b/hw/arm/aspeed.c
>>> @@ -15,6 +15,7 @@
>>>    #include "hw/arm/aspeed.h"
>>>    #include "hw/arm/aspeed_soc.h"
>>>    #include "hw/arm/aspeed_eeprom.h"
>>> +#include "hw/arm/machines-qom.h"
>>>    #include "hw/block/flash.h"
>>>    #include "hw/i2c/i2c_mux_pca954x.h"
>>>    #include "hw/i2c/smbus_eeprom.h"
>>> @@ -1760,91 +1761,199 @@ static const TypeInfo aspeed_machine_types[] = {
>>>            .name          = MACHINE_TYPE_NAME("palmetto-bmc"),
>>>            .parent        = TYPE_ASPEED_MACHINE,
>>>            .class_init    = aspeed_machine_palmetto_class_init,
>>> +        .interfaces     = (InterfaceInfo[]) {
>>> +            { TYPE_TARGET_ARM_MACHINE },
>>> +            { TYPE_TARGET_AARCH64_MACHINE },
>>> +            { },
>>> +        },
>>>        }, {
>>>            .name          = MACHINE_TYPE_NAME("supermicrox11-bmc"),
>>>            .parent        = TYPE_ASPEED_MACHINE,
>>>            .class_init    = aspeed_machine_supermicrox11_bmc_class_init,
>>> +        .interfaces     = (InterfaceInfo[]) {
>>> +            { TYPE_TARGET_ARM_MACHINE },
>>> +            { TYPE_TARGET_AARCH64_MACHINE },
>>> +            { },
>>> +        },
>>
>> Don't replicate these anonymous arrays.
>> You want common
>>
>> extern InterfaceInfo arm_aarch64_machine_interfaces[];
>> extern InterfaceInfo aarch64_machine_interfaces[];
>>
>> to be shared by all.
> 

@Richard:
Is it a concern regarding code maintenance, or potential impact on .data?

IMHO, it's worth repeating here, so it's easy to find all occurrences in 
the codebase.

> "common" was my first approach (not via extern but macro)
> https://lore.kernel.org/qemu-devel/20250403235821.9909-5-philmd@linaro.org/
> but Pierrick said on offlist review we want this array to
> be verbose.
> 
> Pierrick, are you OK with external symbols?
> 

I'm not opposed to it, as long as we make it consistent through all our 
boards, and all architectures, whether they are defined with the full 
struct, or using any macro.
The last thing we want is to have to do multiple greps to find information.

The advantage of explicitly listing this is that it's unambiguous and 
easy to find.

If the Richard's concern is just for code writing, maybe we can add a 
variadic macro to reduce boilerplate to a minimum, so we can have:

.interfaces = TARGET_MACHINE(ARM, AARCH64).
or
DEFINE_MACHINE(..., TARGET_MACHINE(ARM, AARCH64))

