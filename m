Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E387C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 19:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpu5j-0004iE-7k; Wed, 05 Mar 2025 14:07:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpu5c-0004hU-S3
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 14:07:32 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpu5U-0001bv-CN
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 14:07:32 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso3827484f8f.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 11:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741201642; x=1741806442; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZtdD5y0qJbaboVZ+z+JoOmQrhUsPGBNbUP1wWXiYCx0=;
 b=uTL559KuwknBTF/xGWzgWR40CBcaHtMzYAiVNOmmgAryLJJe/CyDGiGi65nUYInze7
 N6fnft6s9MlB1FYNIOV3AjjzrIJe/dFtd3mWhA8rr7wT9WmUM1tjFL/7K7tuPxJyvVky
 dYnR/bAFNEzaRJN6cGz1fBGbDjq2Uy6mDdaYA3S0r6QoXSstuJFt1JhIMmmaLK5+HKru
 8dZRk8UC0uxDSMkZRjPf0gUYssRGbihdYbaRuPBPV75DYGJri+Ha9TIr6zkpQTsDLmVN
 5WQSAofNoBgMG8WisdFBsSvBJZNwYEcJDop//wqCUunJk8GnstASVWFsDLklfW2ySjyd
 aX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741201642; x=1741806442;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZtdD5y0qJbaboVZ+z+JoOmQrhUsPGBNbUP1wWXiYCx0=;
 b=iU6qlP9gVhWySXM9XOgOOb1KKPwEYGLV3AtUtITpBG3nAkwmW0G0D/xWBpDcq7iU1j
 u/Gf296OSuqEGpEdByGPllqM++2v4xNRnpDZ2Mv+0O9vo2uVNQoe4EfCggqr3LVxiwwG
 cw1ds6rcT921TV4WN6JbluS39OlSkBME7L/nQXMLj/ZcmXoEJ02VG8BqQj6XFgVAwaiU
 g+a3CBEteR2UNTOzH7UQf5/Xaw/sx/NMc6Jyf0jJlE4brHjKNJJ0gUB8jU/jR0YQiNSa
 F83aT13kZqi2fHorow57I8Rodxxu4nWPv+mNdhk8c8QQIhu0cUB5FaYDO/f9O4DkN9TU
 XUMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRG3FKotmL4jdGwh7zK7tyCU05LhddXW1HUMWbu6ABoYnhvmDAYCLhghffpJxKNxJMM1OrHnrZTpEj@nongnu.org
X-Gm-Message-State: AOJu0YwNZyFj6x8L3ye3XoNpX/9Q6hCP38+Fq0jkNbm8XwmgG1tZZAOO
 f82I4YruPTtYV/4qFf5eKho/0YaS//Z1P6ZHJnee32Ot7GzviCyi3krLJhS04mE=
X-Gm-Gg: ASbGnctTnLqqCfB74G8EECe2uXgrVsAnFqEk20HqCLfr2tRxLCNsWjDYSi8CxJqnQSE
 UuPa8u/tIBbpVnhBuGv4qN7wavapILYo23jEny/dqNv1CA1OxEILTA1LtzCpX1N1CRHK/Ltyka3
 jEhZt77cmnjuOwbgnbTa3cRL9eX/hQucfZJn05rBzDERTi3HCM5WC6N6ZG4DMd7ojZwYbLhDWfa
 NuYgpBig8y1I/9ossAswBgSzHmRSyKFbxXGEzW7cZIGGuQAcMF4QfU0O6dHInNMjzFGrpLOk4Zt
 g7wvsmH8gNH1WhcmX8dIQ+Kmo7bH8DiePKUmj+whPC1I1Cpr+JIguucw0s5ZIqxzqQYFTuHdAce
 pCzi5PhdRuSS9
X-Google-Smtp-Source: AGHT+IF1tyIvWQEqaytTr5lfDw/2LBx0D9zKv+y66JO+KxkKQu3LvLpROEqwZDmuqF5abWXX9hh0uQ==
X-Received: by 2002:a5d:5846:0:b0:391:2353:8a57 with SMTP id
 ffacd0b85a97d-39123538ab5mr2765932f8f.34.1741201641745; 
 Wed, 05 Mar 2025 11:07:21 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4293250sm25706645e9.16.2025.03.05.11.07.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 11:07:21 -0800 (PST)
Message-ID: <1b76a7fc-e79b-4f32-9657-b87fb7761c95@linaro.org>
Date: Wed, 5 Mar 2025 20:07:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] hw/arm/raspi: Replace TARGET_AARCH64 by
 legacy_binary_is_64bit()
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250305161248.54901-1-philmd@linaro.org>
 <20250305161248.54901-3-philmd@linaro.org>
 <91882e5b-bd0f-4f84-9c03-c40b5e3d3e3f@redhat.com>
 <9d7283b7-9d05-4dc0-8e80-3c565376a812@kaod.org>
 <0561d400-6e0b-40e0-a616-bd0d9fd4feec@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0561d400-6e0b-40e0-a616-bd0d9fd4feec@redhat.com>
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

On 5/3/25 19:35, Thomas Huth wrote:
> On 05/03/2025 19.12, Cédric Le Goater wrote:
>> On 3/5/25 18:40, Thomas Huth wrote:
>>> On 05/03/2025 17.12, Philippe Mathieu-Daudé wrote:
>>>> For legacy ARM binaries, legacy_binary_is_64bit() is
>>>> equivalent of the compile time TARGET_AARCH64 definition.
>>>>
>>>> Use it as TypeInfo::registerable() callback to dynamically
>>>> add Aarch64 specific types in qemu-system-aarch64 binary,
>>>> removing the need of TARGET_AARCH64 #ifdef'ry.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>   hw/arm/bcm2836.c | 6 ++----
>>>>   hw/arm/raspi.c   | 7 +++----
>>>>   2 files changed, 5 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
>>>> index 95e16806fa1..88a32e5fc20 100644
>>>> --- a/hw/arm/bcm2836.c
>>>> +++ b/hw/arm/bcm2836.c
>>>> @@ -12,6 +12,7 @@
>>>>   #include "qemu/osdep.h"
>>>>   #include "qapi/error.h"
>>>>   #include "qemu/module.h"
>>>> +#include "qemu/legacy_binary_info.h"
>>>>   #include "hw/arm/bcm2836.h"
>>>>   #include "hw/arm/raspi_platform.h"
>>>>   #include "hw/sysbus.h"
>>>> @@ -195,7 +196,6 @@ static void bcm2836_class_init(ObjectClass *oc, 
>>>> void *data)
>>>>       dc->realize = bcm2836_realize;
>>>>   };
>>>> -#ifdef TARGET_AARCH64
>>>>   static void bcm2837_class_init(ObjectClass *oc, void *data)
>>>>   {
>>>>       DeviceClass *dc = DEVICE_CLASS(oc);
>>>> @@ -208,7 +208,6 @@ static void bcm2837_class_init(ObjectClass *oc, 
>>>> void *data)
>>>>       bc->clusterid = 0x0;
>>>>       dc->realize = bcm2836_realize;
>>>>   };
>>>> -#endif
>>>>   static const TypeInfo bcm283x_types[] = {
>>>>       {
>>>> @@ -219,12 +218,11 @@ static const TypeInfo bcm283x_types[] = {
>>>>           .name           = TYPE_BCM2836,
>>>>           .parent         = TYPE_BCM283X,
>>>>           .class_init     = bcm2836_class_init,
>>>> -#ifdef TARGET_AARCH64
>>>>       }, {
>>>>           .name           = TYPE_BCM2837,
>>>>           .parent         = TYPE_BCM283X,
>>>> +        .registerable   = legacy_binary_is_64bit,
>>>>           .class_init     = bcm2837_class_init,
>>>> -#endif
>>>>       }, {
>>>>           .name           = TYPE_BCM283X,
>>>>           .parent         = TYPE_BCM283X_BASE,
>>>> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
>>>> index dce35ca11aa..f7e647a9cbf 100644
>>>> --- a/hw/arm/raspi.c
>>>> +++ b/hw/arm/raspi.c
>>>> @@ -15,6 +15,7 @@
>>>>   #include "qemu/osdep.h"
>>>>   #include "qemu/units.h"
>>>>   #include "qemu/cutils.h"
>>>> +#include "qemu/legacy_binary_info.h"
>>>>   #include "qapi/error.h"
>>>>   #include "hw/arm/boot.h"
>>>>   #include "hw/arm/bcm2836.h"
>>>> @@ -367,7 +368,6 @@ static void 
>>>> raspi2b_machine_class_init(ObjectClass *oc, void *data)
>>>>       raspi_machine_class_init(mc, rmc->board_rev);
>>>>   };
>>>> -#ifdef TARGET_AARCH64
>>>>   static void raspi3ap_machine_class_init(ObjectClass *oc, void *data)
>>>>   {
>>>>       MachineClass *mc = MACHINE_CLASS(oc);
>>>> @@ -387,7 +387,6 @@ static void 
>>>> raspi3b_machine_class_init(ObjectClass *oc, void *data)
>>>>       rmc->board_rev = 0xa02082;
>>>>       raspi_machine_class_init(mc, rmc->board_rev);
>>>>   };
>>>> -#endif /* TARGET_AARCH64 */
>>>>   static const TypeInfo raspi_machine_types[] = {
>>>>       {
>>>> @@ -402,16 +401,16 @@ static const TypeInfo raspi_machine_types[] = {
>>>>           .name           = MACHINE_TYPE_NAME("raspi2b"),
>>>>           .parent         = TYPE_RASPI_MACHINE,
>>>>           .class_init     = raspi2b_machine_class_init,
>>>> -#ifdef TARGET_AARCH64
>>>>       }, {
>>>>           .name           = MACHINE_TYPE_NAME("raspi3ap"),
>>>>           .parent         = TYPE_RASPI_MACHINE,
>>>> +        .registerable   = legacy_binary_is_64bit,
>>>>           .class_init     = raspi3ap_machine_class_init,
>>>>       }, {
>>>>           .name           = MACHINE_TYPE_NAME("raspi3b"),
>>>>           .parent         = TYPE_RASPI_MACHINE,
>>>> +        .registerable   = legacy_binary_is_64bit,
>>>>           .class_init     = raspi3b_machine_class_init,
>>>> -#endif
>>>>       }, {
>>>>           .name           = TYPE_RASPI_MACHINE,
>>>>           .parent         = TYPE_RASPI_BASE_MACHINE,
>>>
>>> Uh, this (together with patch 1) looks very cumbersome. Why don't you 
>>> simply split the array into two, one for 32-bit and one for 64-bit, 
>>> and then use a simply "if (legacy_binary_is_64bit())" in the 
>>> type_init function instead?
>>
>> Sounds like a good idea.
>>
>> So we would have DEFINE_TYPES() and DEFINE_TYPES64() macros ?
> 
> Either that - or simply use type_init() directly here for the time being.

As Pierrick noted on private chat, my approach doesn't scale, I should
use smth in the lines of:

     }, {
         .name           = MACHINE_TYPE_NAME("raspi2b"),
         .parent         = TYPE_RASPI_MACHINE,
         .registerable   = qemu_binary_has_target_arm,
         .class_init     = raspi2b_machine_class_init,
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3ap"),
         .parent         = TYPE_RASPI_MACHINE,
         .registerable   = qemu_binary_has_target_aarch64,
         .class_init     = raspi3ap_machine_class_init,
     }, {

Having:

bool qemu_binary_has_target_arm(void)
{
     return qemu_arch_available(QEMU_ARCH_ARM);
}

Now back to Thomas suggestion, we could define 2 TypeInfo arrays,
but I foresee lot of code churn when devices has to be made
available on different setup combinations; so with that in mind
the QOM registerable() callback appears a bit more future proof.

