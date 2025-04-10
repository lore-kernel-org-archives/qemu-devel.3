Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11348C369A2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 17:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2vbB-0001jr-CR; Thu, 10 Apr 2025 13:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2vb2-0001jP-Bq
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 13:21:49 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2vb0-0004PW-Ly
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 13:21:48 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39ac8e7688aso635729f8f.2
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 10:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744305704; x=1744910504; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=45Plt0keEdtLa19C4fiN743epUba4MJashV7mycFNTA=;
 b=q3rkQADlz7YcYQ40PPMl5tmtmUk2x37ECuJaXO1FArDxI5TaJBQoSHbuO1AEwrriPS
 aiPu94JwMRYoY/5QEPTzq6VsnL8niaGixtsHhkGB5PZ0Vrh6OJNpvxmz4YmQhyIKx/KU
 I7wXbGdPIlXCoQuU4J3v7c3HqVRtbvWQAakVSQmMF0vrfYEY8iSdQ7L749uPWA0Xtktn
 R+h6HQQNSXqPMdVg8ViGoQCNM/PiqioYsJiDUnN1rEgJLc6MK7J7f7FzFlTYZh33v+s1
 ac0CmUnkfVf8jQ0ZhYKVRKVDdxJky8EfXdCo1CR1wtJR2jJ0r/iigNq/NIvDS3iqo7e3
 lSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744305704; x=1744910504;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=45Plt0keEdtLa19C4fiN743epUba4MJashV7mycFNTA=;
 b=lPySGniwniLjPcVUHmumrl1jWMkQZ6j/YQl3viPw12Q0DKiQleV+S3hv8eMKtWWdBS
 qGEkfHwHX5vEGLxnikwvu0+0f6InBODjeFP/kUpcNuYaUsHuqafSgVKZFbFihivnP/S5
 l/jxAFf32JwM3ex8CiGTnEiDcQBhQ/+VT2c3yP8SahbtCchTLoZBUhUiUZod289Y6lHS
 9Jq7jWkd177yDCRz6CmhXHTQVxwZ9bMt+VpWrdvLZpDOnJTvzVGK3wnrfjjFKrhyAfTD
 9g7E14gyk3B//uhmE887ITRV+4c8ZptSxsrEsMyb6mJ8CdIWyGsnHa6d4ygtLuWswRb0
 Yw6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw6M0BnYbT3l6tWol97d3VOzlu0NDtnknxkDp9kKO8UWy1NehdJZ5A+6/dJnHxbZr0DTShWIYA7omr@nongnu.org
X-Gm-Message-State: AOJu0YzljuX7d39+sZ5dginNyuUQTzwWNs94FDzzbF18NjpSLfwdkyF0
 tqp+c1++Fov+0Xsgiz8zI3Is+J3yoSKPcY3awEpHW/AqhIF+/8nNi6NhJF7hWkg=
X-Gm-Gg: ASbGncsPcECnPhrMQnbR31/XO+GhFbXnH/imH49vjCJCROkq3aXeE+xlssRuN0gYIxD
 mQ5lde6ivjYhbhNpm5KL3H6pwRISuwV4+tCLJXVLEhpt0uq/ssf+b2DjEf8O5/4BYhLEBYtUcSS
 gpomE7fFe5H8LyT5ZUWZ/YVAQ6F7GlKdkGUMqSgwkkAJXCMwpqwZWXjO4ZOvrJ0FojcTkFTy7em
 ljq1ZCEBwJHnS8Up8PuBtikcAoVjyH36KRZzfyxLaYIxfJYrq4PTGP0Db7C5wKhhnn80WK3n0eK
 qUFoYcZSZVdy2gnCcRfznZzUZ09O1Y2lWkwPmwUMXIG1ipMYMuY6pl1iTxkl+oFgUR3O9NNMxo6
 MS4UeyxdIUUuoDA==
X-Google-Smtp-Source: AGHT+IF/Om7H6kLIvzN4liCDI9EMmTNj8chagzo4JbmytLP1HgA5dJsCP3e6N0MtXj7tS03zCItvag==
X-Received: by 2002:a05:6000:1867:b0:39c:142c:e889 with SMTP id
 ffacd0b85a97d-39d8f47331cmr3588664f8f.27.1744305704428; 
 Thu, 10 Apr 2025 10:21:44 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233c49f7sm57204005e9.17.2025.04.10.10.21.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 10:21:43 -0700 (PDT)
Message-ID: <0edf086b-18f1-4c75-a794-1c957b20bf19@linaro.org>
Date: Thu, 10 Apr 2025 19:21:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-8.0 09/10] hw/virtio: Extract
 vhost_user_ram_slots_max() to vhost-user-target.c
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Hanna Reitz <hreitz@redhat.com>
References: <20221212230517.28872-1-philmd@linaro.org>
 <20221212230517.28872-10-philmd@linaro.org>
 <84b2bcf7-9df7-43e2-83d8-cae9d34ca541@linaro.org>
 <d4ecd6c2-73db-4c28-828c-bfa84ca90084@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d4ecd6c2-73db-4c28-828c-bfa84ca90084@linaro.org>
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

On 10/4/25 16:36, Pierrick Bouvier wrote:
> On 4/10/25 05:14, Philippe Mathieu-Daudé wrote:
>> Hi Pierrick,
>>
>> On 13/12/22 00:05, Philippe Mathieu-Daudé wrote:
>>> The current definition of VHOST_USER_MAX_RAM_SLOTS is
>>> target specific. By converting this definition to a runtime
>>> vhost_user_ram_slots_max() helper declared in a target
>>> specific unit, we can have the rest of vhost-user.c target
>>> independent.
>>>
>>> To avoid variable length array or using the heap to store
>>> arrays of vhost_user_ram_slots_max() elements, we simply
>>> declare an array of the biggest VHOST_USER_MAX_RAM_SLOTS,
>>> and each target uses up to vhost_user_ram_slots_max()
>>> elements of it. Ensure arrays are big enough by adding an
>>> assertion in vhost_user_init().
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> RFC: Should I add VHOST_USER_MAX_RAM_SLOTS to vhost-user.h
>>>        or create an internal header for it?
>>> ---
>>>    hw/virtio/meson.build          |  1 +
>>>    hw/virtio/vhost-user-target.c  | 29 +++++++++++++++++++++++++++++
>>>    hw/virtio/vhost-user.c         | 26 +++++---------------------
>>>    include/hw/virtio/vhost-user.h |  7 +++++++
>>>    4 files changed, 42 insertions(+), 21 deletions(-)
>>>    create mode 100644 hw/virtio/vhost-user-target.c
>>>
>>> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
>>> index eb7ee8ea92..bf7e35fa8a 100644
>>> --- a/hw/virtio/meson.build
>>> +++ b/hw/virtio/meson.build
>>> @@ -11,6 +11,7 @@ if have_vhost
>>>      specific_virtio_ss.add(files('vhost.c', 'vhost-backend.c', 
>>> 'vhost-iova-tree.c'))
>>>      if have_vhost_user
>>>        specific_virtio_ss.add(files('vhost-user.c'))
>>> +    specific_virtio_ss.add(files('vhost-user-target.c'))
>>>      endif
>>>      if have_vhost_vdpa
>>>        specific_virtio_ss.add(files('vhost-vdpa.c', 'vhost-shadow- 
>>> virtqueue.c'))
>>> diff --git a/hw/virtio/vhost-user-target.c b/hw/virtio/vhost-user- 
>>> target.c
>>> new file mode 100644
>>> index 0000000000..6a0d0f53d0
>>> --- /dev/null
>>> +++ b/hw/virtio/vhost-user-target.c
>>> @@ -0,0 +1,29 @@
>>> +/*
>>> + * vhost-user target-specific helpers
>>> + *
>>> + * Copyright (c) 2013 Virtual Open Systems Sarl.
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "hw/virtio/vhost-user.h"
>>> +
>>> +#if defined(TARGET_X86) || defined(TARGET_X86_64) || \
>>> +    defined(TARGET_ARM) || defined(TARGET_ARM_64)
>>> +#include "hw/acpi/acpi.h"
>>> +#elif defined(TARGET_PPC) || defined(TARGET_PPC64)
>>> +#include "hw/ppc/spapr.h"
>>> +#endif
>>> +
>>> +unsigned int vhost_user_ram_slots_max(void)
>>> +{
>>> +#if defined(TARGET_X86) || defined(TARGET_X86_64) || \
>>> +    defined(TARGET_ARM) || defined(TARGET_ARM_64)
>>> +    return ACPI_MAX_RAM_SLOTS;
>>> +#elif defined(TARGET_PPC) || defined(TARGET_PPC64)
>>> +    return SPAPR_MAX_RAM_SLOTS;
>>> +#else
>>> +    return 512;
>>
>> Should vhost_user_ram_slots_max be another TargetInfo field?
>>
> 
> I don't think so, it would be better to transform the existing function 
> in something like:
> 
> switch (target_current()) {
> case TARGET_X86:
> case TARGET_ARM:
> case TARGET_X86_64:
> case TARGET_ARM_64:
>      return ACPI_MAX_RAM_SLOTS;
> case TARGET PPC:
> case TARGET PPC64:
>      return SPAPR_MAX_RAM_SLOTS;
> default:
>      return 512;
> }

Clever, I like it, thanks!

