Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D105C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 17:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpsDJ-0002a3-Sx; Wed, 05 Mar 2025 12:07:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpsDH-0002Zh-O5
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 12:07:20 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpsDF-0000Vr-T3
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 12:07:19 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3911748893aso1672852f8f.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 09:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741194436; x=1741799236; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=emal6xfxY/XSycwWClQL8p38IOzHHNwRXz5owTQozGA=;
 b=gIupEx7b+nWBhQ/qUuMo+4zOO6uG16GoOQlPdhj9ShsTbuDrmcu+F5MPZKGLMwT5he
 +vVlkQ2+Jd1HuvLN1JidiltMp/nQmiEh5wpqkNUDiencc8gAnOHXpNN/y37hPAq9vxQn
 ooG41Mv5wlrXK6+PKJr87accmW0jzaU7B6SqZ+sn5r2mxZoFu4WqsguyUTj5Tfuoqepy
 yoL6B1BB7HLl7/9CwQBxWb3eUs8fsV/Ipk3AYEhKbcvQWGYCxu9PeRf2CGNpydipl8y/
 7ofhVxLQg7G0vVQ0+AlcdqyVb8Mb0KnVF1sAYVQLS2u9dIKUnmPnDkHZAhJxDgpQ6My4
 UASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741194436; x=1741799236;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=emal6xfxY/XSycwWClQL8p38IOzHHNwRXz5owTQozGA=;
 b=vRXUqHIYpT7oq9qrj69M1xVKQJY+58Dy612U3P7fhwQlqIsfrsy3+CdigaVzRz531T
 67Nl2AASlPeHq/C8yls4VS8MfWOTupW0UYeYP8r45LXvJqyr1NDCqzLkOcv5Sm+nOF7x
 dTVaP2Tv8NHhLEaC9Cqnaovdd59yFuZcewxBpZ91lh2ffdpE54oO0Z7aP1mcRUlIOgaj
 +Ze+vtTzkberYA/1C0UiGyngqhKpP1ujRsdcXhIwGjPYRIi8E8KqtL+JvvtZcvymHJ7T
 tAqY7cDn9vaYGUePoo7J+o2/vhmBtLuqF0OF4MR+szQn5I7m26ZlJ5e32Aj+UsfFJopE
 s+zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGMCoZKoxjEVpR3/CbR2uei0xN8LJBNsAzCYrBjoIMB3qBEh16ohv6+KYzLsapUXwGzymAt3XPun3b@nongnu.org
X-Gm-Message-State: AOJu0YxS0Fh/vW0YGJYms0u5Dwbven2hlJ1pC9M7psV70zrGkD2zI73D
 z9l1JPB4SesBI1HVMaA4T1ofRLB91ztW6f86/+X1AsBBwZlSBzKeIoIddWgLTeQ=
X-Gm-Gg: ASbGncscWVqaZs7zVe6BY2v4kAd/pKYQgudJVvx893Xqud1cy3VFlQgphh6M/saTJY0
 +pSxiIXwsMdm5FHIKvE6Jfi5/3iSySP/9Huui11j76bM3xMrSTU/EQMhDZmuDYkwItCFP4kyX9X
 6pIJ5eZZqixgL2nG3GOKY02DQnTaX31WD2lFcOQA2AUy3uXXYMhyqcRVOUO4zMWIJAiRtsGaGZ0
 ixiLe/YBH3YllwqLRNcvzCXRjDqDmYqQkYWD+TUvROP2lwb/FcFBJd2oR8S47FQiRXoMREVNkSw
 g3nb5XWcx3YzL0u7inJM8xLaqmTf76xxgoxeijca/pf7Yu+QcFFsGhtq5ah1YnfYke6/jitb3n3
 4wLk+OO1qsnIc
X-Google-Smtp-Source: AGHT+IEyRFAUZ5UgpoWtBVfDrhdbPLN8Q9AcJ3bzcRZBKkycR1khAtNFbmj5GPYtQoKJj1LQIxWEFA==
X-Received: by 2002:a05:6000:1562:b0:38d:e6f4:5a88 with SMTP id
 ffacd0b85a97d-3911f749c86mr3153177f8f.12.1741194435860; 
 Wed, 05 Mar 2025 09:07:15 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912933c050sm174175f8f.100.2025.03.05.09.07.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 09:07:15 -0800 (PST)
Message-ID: <6c62151d-8030-4568-b29b-b6793408b55d@linaro.org>
Date: Wed, 5 Mar 2025 18:07:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] hw/arm/aspeed: Replace TARGET_AARCH64 by
 legacy_binary_is_64bit()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250305161248.54901-1-philmd@linaro.org>
 <20250305161248.54901-4-philmd@linaro.org>
 <3eef4f0d-b931-473d-8e69-4b8c46b6485a@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3eef4f0d-b931-473d-8e69-4b8c46b6485a@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 5/3/25 17:33, Cédric Le Goater wrote:
> On 3/5/25 17:12, Philippe Mathieu-Daudé wrote:
>> For legacy ARM binaries, legacy_binary_is_64bit() is
>> equivalent of the compile time TARGET_AARCH64 definition.
>>
>> Use it as TypeInfo::registerable() callback to dynamically
>> add Aarch64 specific types in qemu-system-aarch64 binary,
>> removing the need of TARGET_AARCH64 #ifdef'ry.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/arm/aspeed.c | 8 ++------
>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>> index 98bf071139b..3f18a4501e0 100644
>> --- a/hw/arm/aspeed.c
>> +++ b/hw/arm/aspeed.c
>> @@ -28,6 +28,7 @@
>>   #include "hw/loader.h"
>>   #include "qemu/error-report.h"
>>   #include "qemu/units.h"
>> +#include "qemu/legacy_binary_info.h"
>>   #include "hw/qdev-clock.h"
>>   #include "system/system.h"
>> @@ -179,11 +180,9 @@ struct AspeedMachineState {
>>   #define AST2600_EVB_HW_STRAP1 0x000000C0
>>   #define AST2600_EVB_HW_STRAP2 0x00000003
>> -#ifdef TARGET_AARCH64
>>   /* AST2700 evb hardware value */
>>   #define AST2700_EVB_HW_STRAP1 0x000000C0
>>   #define AST2700_EVB_HW_STRAP2 0x00000003
>> -#endif
>>   /* Rainier hardware value: (QEMU prototype) */
>>   #define RAINIER_BMC_HW_STRAP1 (0x00422016 | 
>> SCU_AST2600_HW_STRAP_BOOT_SRC_EMMC)
>> @@ -1661,7 +1660,6 @@ static void 
>> aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass *oc,
>>       aspeed_machine_class_init_cpus_defaults(mc);
>>   }
>> -#ifdef TARGET_AARCH64
>>   static void ast2700_evb_i2c_init(AspeedMachineState *bmc)
>>   {
>>       AspeedSoCState *soc = bmc->soc;
>> @@ -1690,7 +1688,6 @@ static void 
>> aspeed_machine_ast2700_evb_class_init(ObjectClass *oc, void *data)
>>       mc->default_ram_size = 1 * GiB;
>>       aspeed_machine_class_init_cpus_defaults(mc);
>>   }
>> -#endif
>>   static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
>>                                                        void *data)
>> @@ -1813,12 +1810,11 @@ static const TypeInfo aspeed_machine_types[] = {
>>           .name           = MACHINE_TYPE_NAME("ast1030-evb"),
>>           .parent         = TYPE_ASPEED_MACHINE,
>>           .class_init     = 
>> aspeed_minibmc_machine_ast1030_evb_class_init,
>> -#ifdef TARGET_AARCH64
>>       }, {
>>           .name          = MACHINE_TYPE_NAME("ast2700-evb"),
>>           .parent        = TYPE_ASPEED_MACHINE,
>> +        .registerable   = legacy_binary_is_64bit,
> 
> where is this routine implemented ?

Based-on series mentioned in cover:
https://lore.kernel.org/qemu-devel/20250305153929.43687-6-philmd@linaro.org/

