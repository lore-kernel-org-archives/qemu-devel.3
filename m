Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6B5C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 14:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5mNi-0000QB-94; Fri, 18 Apr 2025 10:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5mNd-0000Nd-He
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 10:07:45 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5mNS-0005vm-Cr
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 10:07:45 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so19511375e9.1
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 07:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744985242; x=1745590042; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dUAAlN+AIyed3MsiOoEdnW37V/sG2gLRcCL2jczGD2w=;
 b=MQJ6QBrZ1FDN2EKglXuF++wwZ7lvwc/XoOz7nhxLTjA+enOOc2AhZgu6CKF5ZZRYtP
 csdaKeHQV7WircuVCzec7mfEcRK30kNAiH4D9cKfexIRh+GU2ArZoS+inlzHyfdC3LDq
 mmhISm3rCC91jwTvrO12yacJXP8BG7lO34l86a1VjrPx5kwVXn2fhzT9pHyB8hgWCYKt
 vH6ejkvKXc2cJerj0ugYf3Ou2pX5E6Syc4OJuyTiObluJK3IsY6ifqk5SAyFWcejflON
 WOQBKA6mf+DAMqGmjwjIml0kABG7hgLy+VHUpsiJkH8jMs8xpDWIuLmNsiEP+eyS/TV5
 Hjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744985242; x=1745590042;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dUAAlN+AIyed3MsiOoEdnW37V/sG2gLRcCL2jczGD2w=;
 b=bvRCNCHNJ15xb0p9Er7hQYqi0us/TmKg9DTl/TpWXkxTiqOJgPMnw8UHg+So0QR942
 77rvQE3vYpBIGxZhyoiEZt1NV0ZuDOcyyBKs8ZesCPp5wkHnIRdyAx/sE50R2PG+KNkx
 LFDTw3FFpIZEfDaI/2svs06cEElj9dOK16xyBu3RdISO1dQ895G1pJU3iSb7r5GBcUGP
 9VurND7fkd3uIzAcJeVg1vwUjA0Hs7IdklpB1Jo6g5poAcCMI+CZAKHIeTSRYdob/Euy
 +S6lP0ygjbuJqPjhzepFcYdpTCovnvRWduVh1ZAlTodbF/77lMzRzE8jpJQbidTXbFCc
 9CxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBydMtOYCgrmZlaY3tDON6fJgcg21+8YvLCxE7Uc1D+QRFtz/r+9hpSL+XGUP17ZhIxzJB0rFIQbGF@nongnu.org
X-Gm-Message-State: AOJu0YxsP/wwiFAn7d8vVoGa8NAHZjKjG7ge5W0nAgwZhU5F3X2RVxOJ
 5Go2b6Pags972h48y/FYG4uD3mdprvvMTphPswvr0HeWFrh9rk3lMgUoOM+CVlg6wBYN2eFED+x
 u
X-Gm-Gg: ASbGncsEymmVHb93oaH4ue5eQp5n1wvCX3cgjjophxmIjuuUY4OdwEq0rzvbLAu7SQq
 lRYzmzfe0kbJfxixU/APnf4QEI7gI1fChlVNcFmJGG4MO7J2k+TRJLS1PvK+4B+9Snu5aTLgLIi
 MWkKoa8t1ZURLe2edd1NZLdXsSdbu9KZHw+VLHSj9WdICj1dGlCqRX4Vke7Hu6YA7n+2ua3nr7m
 n6pxNOcQU74VWi9fyBjVbZBdfzDeoEUhq7b9xZzXvSSON6Vl9uYIx2aFcBTQ+scYy9BVl1gbRWv
 RQnz6fqX10yRZ8qAQRd9M+pm3UtK3VBuAfkICWS+3IL8XaInfriDIAZwMhkzjQuInXYdosYd4/O
 tjSaTg8Wk
X-Google-Smtp-Source: AGHT+IFn3lnxeoqCgnFWU9hwPH7iTGJgR1zZTdNnlsgah3X+MuPtnl2OCqWY5FQPfARON9S98Qqxfg==
X-Received: by 2002:a05:600c:3154:b0:43c:f513:9585 with SMTP id
 5b1f17b1804b1-4406ab9432fmr28794155e9.13.1744985242347; 
 Fri, 18 Apr 2025 07:07:22 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4332c1sm2817239f8f.27.2025.04.18.07.07.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 07:07:21 -0700 (PDT)
Message-ID: <dcf13faa-31e8-4ae1-9d89-1990310d207d@linaro.org>
Date: Fri, 18 Apr 2025 16:07:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 04/11] hw/arm: Register TYPE_TARGET_ARM/AARCH64_CPU
 QOM interfaces
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250418005059.4436-1-philmd@linaro.org>
 <20250418005059.4436-5-philmd@linaro.org>
 <ac98a60e-fa76-4460-a9fa-6f95dd35814d@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ac98a60e-fa76-4460-a9fa-6f95dd35814d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 18/4/25 05:07, Pierrick Bouvier wrote:
> On 4/17/25 17:50, Philippe Mathieu-Daudé wrote:
>> Define the TYPE_TARGET_ARM_MACHINE and TYPE_TARGET_AARCH64_MACHINE
>> QOM interface names to allow machines to implement them.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   meson.build                    |  1 +
>>   include/hw/boards.h            |  1 +
>>   include/qemu/target_info-qom.h | 18 ++++++++++++++++++
>>   target_info-qom.c              | 24 ++++++++++++++++++++++++
>>   4 files changed, 44 insertions(+)
>>   create mode 100644 include/qemu/target_info-qom.h
>>   create mode 100644 target_info-qom.c
>>
>> diff --git a/meson.build b/meson.build
>> index 49a050a28a3..168b07b5887 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -3808,6 +3808,7 @@ common_ss.add(pagevary)
>>   specific_ss.add(files('page-target.c', 'page-vary-target.c'))
>>   common_ss.add(files('target_info.c'))
>> +system_ss.add(files('target_info-qom.c'))
>>   specific_ss.add(files('target_info-stub.c'))
>>   subdir('backends')
>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>> index 02f43ac5d4d..b1bbf3c34d4 100644
>> --- a/include/hw/boards.h
>> +++ b/include/hw/boards.h
>> @@ -7,6 +7,7 @@
>>   #include "system/hostmem.h"
>>   #include "system/blockdev.h"
>>   #include "qapi/qapi-types-machine.h"
>> +#include "qemu/target_info-qom.h"
>>   #include "qemu/module.h"
>>   #include "qom/object.h"
>>   #include "hw/core/cpu.h"
>> diff --git a/include/qemu/target_info-qom.h b/include/qemu/ 
>> target_info-qom.h
>> new file mode 100644
>> index 00000000000..7eb9b6bd254
>> --- /dev/null
>> +++ b/include/qemu/target_info-qom.h
>> @@ -0,0 +1,18 @@
>> +/*
>> + * QEMU binary/target API (QOM types)
>> + *
>> + *  Copyright (c) Linaro
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef QEMU_TARGET_INFO_QOM_H
>> +#define QEMU_TARGET_INFO_QOM_H
>> +
>> +#define TYPE_TARGET_ARM_MACHINE \
>> +        "target-info-arm-machine"
>> +
>> +#define TYPE_TARGET_AARCH64_MACHINE \
>> +        "target-info-aarch64-machine"
>> +
>> +#endif
>> diff --git a/target_info-qom.c b/target_info-qom.c
>> new file mode 100644
>> index 00000000000..d3fee57361b
>> --- /dev/null
>> +++ b/target_info-qom.c
>> @@ -0,0 +1,24 @@
>> +/*
>> + * QEMU binary/target API (QOM types)
>> + *
>> + *  Copyright (c) Linaro
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/target_info-qom.h"
>> +#include "qom/object.h"
>> +
>> +static const TypeInfo target_info_types[] = {
>> +    {
>> +        .name           = TYPE_TARGET_ARM_MACHINE,
>> +        .parent         = TYPE_INTERFACE,
>> +    },
>> +    {
>> +        .name           = TYPE_TARGET_AARCH64_MACHINE,
>> +        .parent         = TYPE_INTERFACE,
>> +    },
>> +};
>> +
>> +DEFINE_TYPES(target_info_types)
> 
> Ideally, this should be in target/arm, as this type will only be used by 
> boards in hw/arm, and by the target_info specialization.

Not the way QOM works, interfaces must be registered, which is
why I use this centralized file. Otherwise we get:

$ qemu-system-sh4 -M help
qemu-system-sh4: -M help: missing interface 'target-info-arm-machine' 
for object 'machine'


