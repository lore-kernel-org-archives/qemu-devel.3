Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB99C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 05:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Skt-0000b5-H0; Wed, 23 Apr 2025 01:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Sko-0000aW-Mg
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 01:34:38 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Skl-0005kj-2i
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 01:34:37 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so44050135e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 22:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745386473; x=1745991273; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H4hJhHJ9eKbWIIrg/y6t1/Q0d0gHbJ3K88IOL8ZTVUs=;
 b=UKLlyiUO5h9lrvy8Aoo7mjaOB1PJbstLr3P4fdV0sPzj21UnUXZhC1oAcasz6N32Eo
 ADxaOwrpphQkFHmUZDPVbQuZaJKNfKfdQX04CYzxczFnvN9nPh7OBWz2dGdOJaM8eQmJ
 MmLgbK/fapFDX+/3qac6sRwZVzb7qzTMmLrRN4k4svh7367YYsfTqNIF0dF7J4U2zvif
 kylgCVwdf1i/+usL06EKfWNszkqvq+etmlcQ1ZaIXliQeB8qxY7zSYcJjAEGZ4X5X+MA
 cy+0QB9yjlZTffx3CgGJ56mkuTW3Dzc36cEmg0uaEQLAl2WCfgIYGpKnFnrvis1FHk85
 ggyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745386473; x=1745991273;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H4hJhHJ9eKbWIIrg/y6t1/Q0d0gHbJ3K88IOL8ZTVUs=;
 b=Cmp9JYArqP0SGVIqyfGUHmFDY6gAItW8yFxeMoYsp2Aud8a4KiRYN+UkZCw0J9yAyO
 srwRWmoksfMR/VwOu15xQ8YV9S6uat7oPObE0yTiIfFwcdEnhek2kUT+30oIgRWCHsvc
 4Wy5hozD+zDM4GtQ8EouU0blu83lJROwpJ+Un3GQ9Gu1s4Q0p2qmnuhRBJizh+2VXXq2
 XMagfDHdgpqH2sPTFPjcmyLYFm9l0gwFxeV7ANpEm1uSRiqYKZW0LhBcMfMLSXstOPUZ
 Dc7T3sf3pvXWrafYSaXTpXvsYYUhAcLMYQ8H7XzYg1fUl4qzImGUMhRtuIxm2iRUTk5Q
 Ybvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq19AHw08t2Ko2gguL7uI+AmNdwHJYSehQpqCVV5cYmIKLoypT3Txj4facFbb/52m0/KtvcBsBrCZP@nongnu.org
X-Gm-Message-State: AOJu0Yz9yROtL1E8Ili3DwHaxUZLeMEmWW9K5e4MAXl9spdvdk28j2Xt
 TtrEq9cMoO0K0hjpJm8m+dfTjIGRZKIseJKJitPzJhND5zc4u6d4y1iTnnUjRRg=
X-Gm-Gg: ASbGncsngGCYtkb/FdWsn96Li0/r5GhhCw+7yn4LEebN1xafzvZ4AlKStbjAeN0Onez
 uGb07MtCJezy4lrn68iL4qAjTkH21ShDQ3k0N66QqS+hs1WPCwqEzWl9KbvSNnHLhy1I9ef3RG7
 1meOB697rHoaiquCrbl905eCF/Pyk3EBv88u1wuah0ihs8PFN0nkODImwYzuXTxQh617wa0ABcN
 boOZySQbIZl8NbWMxnlvJ4sMEp75eftp8WsMq2IqHuYAbvSaKYNPanPFfc7pDs+vT3ssYOKwnJG
 Ukhh6wIGlbV4jNNVfLwGX+g9wbu3jf0pUWZvJnoynlAZqagzzn5g3iEZNph/v/sQclRncHLH1wq
 MDRKw60La
X-Google-Smtp-Source: AGHT+IGQS5VVE1+LsVDe7xaEnOA31BgwfzR+g5d+CQFlI3i1eQPmrIqx52+L3lTvrvuLG48ZKgw5QA==
X-Received: by 2002:a05:600c:5110:b0:43c:fded:9654 with SMTP id
 5b1f17b1804b1-4406aba7088mr149082935e9.19.1745386472981; 
 Tue, 22 Apr 2025 22:34:32 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d3ed88sm12112315e9.35.2025.04.22.22.34.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 22:34:32 -0700 (PDT)
Message-ID: <65ae1a3d-0376-4b66-8354-227303d8b90c@linaro.org>
Date: Wed, 23 Apr 2025 07:34:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 14/19] qemu/target_info: Add %target_arch field to
 TargetInfo
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-15-philmd@linaro.org>
 <cc5114fe-c17d-4e02-96f2-135ee1c7fa09@linaro.org>
 <a8a701b4-9da5-45d1-88e2-6a708b425146@linaro.org>
 <5c3cebf7-665d-4c07-97d8-cf913e78c3f0@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5c3cebf7-665d-4c07-97d8-cf913e78c3f0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 22/4/25 20:30, Pierrick Bouvier wrote:
> On 4/22/25 11:24, Philippe Mathieu-Daudé wrote:
>> On 22/4/25 20:20, Pierrick Bouvier wrote:
>>> On 4/22/25 07:54, Philippe Mathieu-Daudé wrote:
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>    include/qemu/target-info-impl.h   | 4 ++++
>>>>    configs/targets/aarch64-softmmu.c | 1 +
>>>>    configs/targets/arm-softmmu.c     | 1 +
>>>>    target-info-stub.c                | 1 +
>>>>    4 files changed, 7 insertions(+)
>>>>
>>>> diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-
>>>> info-impl.h
>>>> index 4ef54c5136a..e5cd169b49a 100644
>>>> --- a/include/qemu/target-info-impl.h
>>>> +++ b/include/qemu/target-info-impl.h
>>>> @@ -10,12 +10,16 @@
>>>>    #define QEMU_TARGET_INFO_IMPL_H
>>>>    #include "qemu/target-info.h"
>>>> +#include "qapi/qapi-types-machine.h"
>>>>    typedef struct TargetInfo {
>>>>        /* runtime equivalent of TARGET_NAME definition */
>>>>        const char *const target_name;
>>>> +    /* related to TARGET_ARCH definition */
>>>> +    SysEmuTarget target_arch;
>>>> +
>>>>        /* QOM typename machines for this binary must implement */
>>>>        const char *const machine_typename;
>>>> diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/
>>>> aarch64-softmmu.c
>>>> index 375e6fa0b7b..ff89401ea34 100644
>>>> --- a/configs/targets/aarch64-softmmu.c
>>>> +++ b/configs/targets/aarch64-softmmu.c
>>>> @@ -13,6 +13,7 @@
>>>>    static const TargetInfo target_info_aarch64_system = {
>>>>        .target_name = "aarch64",
>>>> +    .target_arch = SYS_EMU_TARGET_AARCH64,
>>>>        .machine_typename = TYPE_TARGET_AARCH64_MACHINE,
>>>>    };
>>>> diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm-
>>>> softmmu.c
>>>> index d4acdae64f3..22ec9e4faa3 100644
>>>> --- a/configs/targets/arm-softmmu.c
>>>> +++ b/configs/targets/arm-softmmu.c
>>>> @@ -13,6 +13,7 @@
>>>>    static const TargetInfo target_info_arm_system = {
>>>>        .target_name = "arm",
>>>> +    .target_arch = SYS_EMU_TARGET_ARM,
>>>>        .machine_typename = TYPE_TARGET_ARM_MACHINE,
>>>>    };
>>>> diff --git a/target-info-stub.c b/target-info-stub.c
>>>> index 218e5898e7f..e573f5c1975 100644
>>>> --- a/target-info-stub.c
>>>> +++ b/target-info-stub.c
>>>> @@ -12,6 +12,7 @@
>>>>    static const TargetInfo target_info_stub = {
>>>>        .target_name = TARGET_NAME,
>>>> +    .target_arch = -1,
>>>
>>> I think we should have a full ifdef ladder here, to handle all
>>> architectures. Setting -1 is not a safe default.
>>
>> TargetInfo definition is internal to "qemu/target-info-impl.h",
>> otherwise its type is forward-declared as opaque.
>>
> 
> Fine, but we need to be able to access to target_arch(), which returns 
> the enum value, without having to deal with -1 situation, which is not a 
> proper enum value.
> 
> switch (target_arch()) {
> case SYS_EMU_TARGET_ARM:
> case SYS_EMU_TARGET_AARCH64:
> ...
> default:
>      break;
> }

I didn't mentioned that because in
https://lore.kernel.org/qemu-devel/3242cee6-7485-4958-a198-38d0fc68e8cd@linaro.org/
you said:

   At this point, I would like to focus on having a first version of
   TargetInfo API, and not reviewing any other changes, as things may
   be modified, and they would need to be reviewed again. It's hard
   to follow the same abstraction done multiple times in multiple series.

What is your "full ifdef ladder" suggestion to avoid -1?

