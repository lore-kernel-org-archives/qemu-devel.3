Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C8BC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5pJI-0004Fb-GD; Fri, 18 Apr 2025 13:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pJG-0004FC-M1
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:15:26 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pJE-0006ZH-Ne
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:15:26 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so20077895e9.3
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744996522; x=1745601322; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AmQGloMfmuIKbyhbOyRU6LC6/R6YmNjdPM8wlqHL1j4=;
 b=BcoRL3SaniNG2iZNvE4okDPe0lLTxg0+rqK4yMV7pvZTJWvvNqkVv2ePQL8939QLyY
 rmLkkH2EqJItN9B/ni0E+31tFoT6fhvVZ07xc4n4H6DRpDTS6wDgRs/MvJxKGWURC8eG
 nD3fFVgMpHIY80hqN1BvOpUTm5IaZvlu6rqbkCmt/NdmwXvXfv3HSILMI+pvzARbpl+0
 cOnsHJPL6YpyRoy8wdeiyqGjIL8aqFgDBar2gQlRfKvjDgldgiTY9B5iNIFw7Xkcb9ru
 ErAItgnksT0GdESFQtwxorNa5gBDEmcyKf/E9xWClu4UU2he3kFFTQ7y/UAWDLHeUyxr
 D32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744996522; x=1745601322;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AmQGloMfmuIKbyhbOyRU6LC6/R6YmNjdPM8wlqHL1j4=;
 b=jinYfxAjRpOhiX2JjWg+xGr239rmW4aitU2HA0kqpIZQQx2EGJNuDsPQzpDQCna37Z
 QKDikkKBZb5arBb45jDC8jiQkrnWmQLv/xUYJudaNydX2MMfKlVVbD5pjQxZs6ABqNml
 Lly8bmC+YGfwmqobrE3A6GUHvlnPh4DRz/gB470OM+5KbEDe1BUsbKY4UT3u+odK4UNH
 Nojr6Syg41TW0WyjV2h/vJ/iKcvOtMgD29WMd2unU+3dYpjtw4KndlyITWsvfC5gmzM/
 cTbgLbcK+9rBIfnvjqoVtZaECEm1sN1jTWYHT2idm5i5Oosa/UMPUeL65Gsn6OcJtSqH
 oKww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYo/JwiNrcEe1/xgVE9kbbsLrzLCDQQY8j+dknlGOhYzpe7/PWrZkAgFZ6VsOD/jyrD8AW/46e37WM@nongnu.org
X-Gm-Message-State: AOJu0YxWY94CLoqGaGt8SBk/MG4zDKUDMbymO8YcDW2Eg0XeSDKd0+SO
 j5SguomGFxZaBOsyPXZo5HyD/EC9kNfbl2aK6M/Wx3h6hDDRJ0kVmPkDUZvhXRc=
X-Gm-Gg: ASbGncvW7FCWXn4jaDHZyMY+1OHNyDVyt45KaZHIkg6blK8cMnD9Y4UbBmv8ELQh+yz
 aL/wl5Witb+zwBs2BgB3LQYg4cAQZrNv7q6eeInqGPTCyBMFs0Ib/ejBnkTzC/RmUmgabeO/mIg
 83dLpH9gHWXe1aZw/fXc/m9T1MS5ULPP19mt5yBwde3UQtJVv7wOyDWEFNYJgUqVZfm9Nlwr4GC
 EsxYYD5mPGuRhLo/750jRN0zxIfFO1KFJxpXTsuJbL/7/ElYSMuoKh+/xoY81ls6NwmReJLM6/e
 RiOf+Vy8bJiyityuLpB6vtzOte0klumgOPUaHShWkpn9PxZ3PRn6fS3jqsOUbYijOfW73x5SSok
 O1Z5jOYn3
X-Google-Smtp-Source: AGHT+IHQ5BZ3iBdqdWf/gIUGph5sQLXLU6c7KD6acFJAomRjbGcfIrd9X7BGeOmvwwWPgDzhzplR9w==
X-Received: by 2002:a05:600c:54ce:b0:43d:fa59:bced with SMTP id
 5b1f17b1804b1-4406d831a7dmr15124235e9.32.1744996521904; 
 Fri, 18 Apr 2025 10:15:21 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5d7ad1sm28952215e9.40.2025.04.18.10.15.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 10:15:21 -0700 (PDT)
Message-ID: <c1ea33dd-9ab9-4088-aa52-310606947077@linaro.org>
Date: Fri, 18 Apr 2025 19:15:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 02/11] qemu: Convert target_name() to TargetInfo API
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250418005059.4436-1-philmd@linaro.org>
 <20250418005059.4436-3-philmd@linaro.org>
 <cff3276a-0a17-406d-a7d2-0c932d1fb1f4@linaro.org>
 <3fc281a5-3a6b-47d6-bead-3a93f331a258@linaro.org>
 <f488e95f-14df-4cdd-88e0-4160e83acec3@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f488e95f-14df-4cdd-88e0-4160e83acec3@linaro.org>
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

On 18/4/25 18:23, Pierrick Bouvier wrote:
> On 4/18/25 07:02, Philippe Mathieu-Daudé wrote:
>> On 18/4/25 05:01, Pierrick Bouvier wrote:
>>> On 4/17/25 17:50, Philippe Mathieu-Daudé wrote:
>>>> Have target_name() be a target-agnostic method, dispatching
>>>> to a per-target TargetInfo singleton structure.
>>>> By default a stub singleton is used. No logical change
>>>> expected.
>>>>
>>>> Inspired-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> ---
>>>>    meson.build                     |  3 +++
>>>>    include/hw/core/cpu.h           |  2 --
>>>>    include/qemu/target_info-impl.h | 23 +++++++++++++++++++++++
>>>>    include/qemu/target_info.h      | 19 +++++++++++++++++++
>>>>    cpu-target.c                    |  5 -----
>>>>    hw/core/machine-qmp-cmds.c      |  1 +
>>>>    plugins/loader.c                |  2 +-
>>>>    system/vl.c                     |  2 +-
>>>>    target_info-stub.c              | 19 +++++++++++++++++++
>>>>    target_info.c                   | 16 ++++++++++++++++
>>>>    10 files changed, 83 insertions(+), 9 deletions(-)
>>>>    create mode 100644 include/qemu/target_info-impl.h
>>>>    create mode 100644 include/qemu/target_info.h
>>>>    create mode 100644 target_info-stub.c
>>>>    create mode 100644 target_info.c
>>
>>
>>>> diff --git a/target_info-stub.c b/target_info-stub.c
>>>> new file mode 100644
>>>> index 00000000000..1e44bb6f6fb
>>>> --- /dev/null
>>>> +++ b/target_info-stub.c
>>>> @@ -0,0 +1,19 @@
>>>> +/*
>>>> + * QEMU target info stubs
>>>> + *
>>>> + *  Copyright (c) Linaro
>>>> + *
>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>> + */
>>>> +
>>>> +#include "qemu/osdep.h"
>>>> +#include "qemu/target_info-impl.h"
>>>> +
>>>> +static const TargetInfo target_info_stub = {
>>>> +    .name = TARGET_NAME,
>>>> +};
>>>> +
>>>> +const TargetInfo *target_info(void)
>>>> +{
>>>> +    return &target_info_stub;
>>>> +}
>>>> diff --git a/target_info.c b/target_info.c
>>>> new file mode 100644
>>>> index 00000000000..877a6a15014
>>>> --- /dev/null
>>>> +++ b/target_info.c
>>>> @@ -0,0 +1,16 @@
>>>> +/*
>>>> + * QEMU binary/target helpers
>>>> + *
>>>> + *  Copyright (c) Linaro
>>>> + *
>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>> + */
>>>> +
>>>> +#include "qemu/osdep.h"
>>>> +#include "qemu/target_info-impl.h"
>>>> +#include "qemu/target_info.h"
>>>> +
>>>> +const char *target_name(void)
>>>> +{
>>>> +    return target_info()->name;
>>>> +}
>>>
>>> What is the benefit to have two different files (common and specific)?
>>> target_name() can be inline in the same header, returning the matching
>>> field in existing target_info, which does not need any specialization
>>> per target.
>>
>> common interface exposed target-agnostic, dispatching to target-specific
>> implementation (providing a stub we'll remove once all targets 
>> converted).
>>
>> What would you suggest?
> 
> To remove target_info.c and target_info-impl.h, and implement 
> target_name() as a static inline in target_info.h.
> 
> This way, target_info.h can still be included from common code, the 
> structure is directly accessed, and we have a single header where we can 
> add new sugar functions and associated fields later.

OK. As I'm about to post a good-enough v3, I'll not implement this
now, but will consider for v4.

