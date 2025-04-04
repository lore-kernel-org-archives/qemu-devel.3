Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B517DC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 21:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0p2P-0002zL-D3; Fri, 04 Apr 2025 17:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0p2F-0002yE-II
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 17:57:13 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0p24-0002vr-7e
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 17:57:03 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43ed8d32a95so7154095e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 14:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743803818; x=1744408618; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VfE+dg+AkAWffdkBAwoQoff7vgUtnOEd4/K99r62zaw=;
 b=RFC7cJ8jWcuGy0Y3x84lxfUQtbWy0wWdERTtQraQZysRWqbyFYR450UmP40hH9iT0x
 DdSm7tNViiQUK6WLaMcolinzjxvee3uCJRXnzGfqQukV0OWiooNcoVekrDe0g4OV1vA/
 UG9E+Qgwd/N4JwYx6irTD8RargY/mT/lOOwRSKwyCIM+QOE2p8rid6yAXn/k8UgNUzbv
 NPbzOzGzlzf/h4zW+c8IZxkf/3W6XYmwAdCBr2gWi7snal6dY3zo642orlWj2/Ptj5ad
 O9eFg1wCZ6HH7fPcpZorXL231c13dEMeI2H5eg2pAb8r9prmxFiZWs6BoGh5Ld+pAOAS
 V6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743803818; x=1744408618;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VfE+dg+AkAWffdkBAwoQoff7vgUtnOEd4/K99r62zaw=;
 b=hD3oBp9JQ8du5JTAyAB+cMc4C5dZW91BJO3NKW46pBtsZqblOV/EtbNM+ZJ9S9HTG7
 CKjaV2+HBrCnGC0buthq4LLMBYfdYaT4FRkGPxol7xz9bc8TUGkvTdApDv+f+G5uVJdw
 yRTaEZtQX5XJlVqp/dEuC1EEjuZ+opJrcujcuv3MWwaP7SLpvGZOFCq4D7xt+Qbm2Ydb
 uMlTtDjNOZvedjmfE/Q/wEZpgzMLOLu2lHgi2UCtBYnvORrmtq2YMt6i0fBO497FB8G0
 dneB/ppzdRrUqj3bWbMPsgfKDDClsrx0LG87qFq0IyN2wLv6b4tS5c9PWkP2MYjyWsY4
 YVag==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+PuZ1GkXqTzKqpVfeHFdZ7kmijbYyEpqUp/qtMsGYgQFhCqFmso9okpZ9L6kT4gzxIDEhVtqY1+e4@nongnu.org
X-Gm-Message-State: AOJu0Yx4y3T+4P6MVcBwNcHtKoPfF3RpaS/KE+hJvLJJKQ5YHUaNnOLU
 nNxdsB5q5Wil6h0fDmTUkoUNgRN/9JS6mBJZYd799u1p6lRS26BnuFVfe9+PMmk=
X-Gm-Gg: ASbGnctH+Fvv9h3sMt+40xA2lmD4qMnfrTywMEwnInhKdP0pndkawvTN9FTmOXoPRdC
 nM/WUytijERv9WFwQIkEfQJKN5s/yv9tZjrHzSM0BLQWBz5da90t6lqxFKsNr3bVvBUREocalk1
 8NCln4pN/Ko9iNuIvk8N/AMFssvqr3B8DbQi3kXRt0hggVgQkU5AOkDX5hawq3qEEJJHhu4JEbw
 9JEsc55v+z1bkc58zUuL+wNgAdIjXo53zI/kxX/Und2U8IQjRj5OD+gX4qrdVmxRQYPDaDHoWXn
 5T5SqsPBq4kFWd1qmssNn8ZK8kCvQJY+Wt7addM6VLvU8rrqJTiA/xrdJ8m9yPLAJNHEw31YD/R
 OhHDCretMxj4CXym5qL85oPhesW8c
X-Google-Smtp-Source: AGHT+IHRzz8aleNREBILeW2VVjd7d4oSVvpQUowynT4aEV3Z/GDbtNXPLX+wV6cPtbqZuH995Js8Ww==
X-Received: by 2002:a05:600c:3ecb:b0:43d:7588:66a5 with SMTP id
 5b1f17b1804b1-43ecfa06563mr49104265e9.31.1743803818320; 
 Fri, 04 Apr 2025 14:56:58 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1795630sm61461875e9.29.2025.04.04.14.56.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 14:56:57 -0700 (PDT)
Message-ID: <ed3f2bd6-2628-4d58-b426-c41ec587759a@linaro.org>
Date: Fri, 4 Apr 2025 23:56:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 27/39] system/hvf: Expose hvf_enabled() to
 common code
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20250403235821.9909-1-philmd@linaro.org>
 <20250403235821.9909-28-philmd@linaro.org>
 <0e88a1ae-f9a3-4a06-9977-e5ce9b1b626e@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0e88a1ae-f9a3-4a06-9977-e5ce9b1b626e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

+Paolo

On 4/4/25 20:23, Pierrick Bouvier wrote:
> On 4/3/25 16:58, Philippe Mathieu-Daudé wrote:
>> Currently hvf_enabled() is restricted to target-specific code.
>> By defining CONFIG_HVF_IS_POSSIBLE we allow its use anywhere.
>>
> 
> Instead, we can simply make hvf_enabled present for common and target 
> specific code, and link correct implementation, based on what we build.
> 
> I don't think *_IS_POSSIBLE was a good idea to start with.

IIUC the point of *_IS_POSSIBLE is to elide code, which we
aren't interested anymore for host-related configs, so we
can also remove CONFIG_KVM_IS_POSSIBLE and CONFIG_XEN_IS_POSSIBLE.
Is that correct?

> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   MAINTAINERS             |  1 +
>>   include/system/hvf.h    | 14 +++++++++-----
>>   accel/stubs/hvf-stub.c  | 12 ++++++++++++
>>   accel/stubs/meson.build |  1 +
>>   4 files changed, 23 insertions(+), 5 deletions(-)
>>   create mode 100644 accel/stubs/hvf-stub.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index c7083ab1d93..00ef33be0e2 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -525,6 +525,7 @@ R: Phil Dennis-Jordan <phil@philjordan.eu>
>>   W: https://wiki.qemu.org/Features/HVF
>>   S: Maintained
>>   F: accel/hvf/
>> +F: accel/stubs/hvf-stub.c
>>   F: include/system/hvf.h
>>   F: include/system/hvf_int.h
>> diff --git a/include/system/hvf.h b/include/system/hvf.h
>> index d50049e1a1a..7b45a2e1988 100644
>> --- a/include/system/hvf.h
>> +++ b/include/system/hvf.h
>> @@ -19,15 +19,19 @@
>>   #include "qom/object.h"
>>   #ifdef COMPILING_PER_TARGET
>> +# ifdef CONFIG_HVF
>> +#  define CONFIG_HVF_IS_POSSIBLE
>> +# endif /* !CONFIG_HVF */
>> +#else
>> +# define CONFIG_HVF_IS_POSSIBLE
>> +#endif /* COMPILING_PER_TARGET */
>> -#ifdef CONFIG_HVF
>> +#ifdef CONFIG_HVF_IS_POSSIBLE
>>   extern bool hvf_allowed;
>>   #define hvf_enabled() (hvf_allowed)
>> -#else /* !CONFIG_HVF */
>> +#else /* !CONFIG_HVF_IS_POSSIBLE */
>>   #define hvf_enabled() 0
>> -#endif /* !CONFIG_HVF */
>> -
>> -#endif /* COMPILING_PER_TARGET */
>> +#endif /* !CONFIG_HVF_IS_POSSIBLE */
>>   #define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
>> diff --git a/accel/stubs/hvf-stub.c b/accel/stubs/hvf-stub.c
>> new file mode 100644
>> index 00000000000..42eadc5ca92
>> --- /dev/null
>> +++ b/accel/stubs/hvf-stub.c
>> @@ -0,0 +1,12 @@
>> +/*
>> + * HVF stubs for QEMU
>> + *
>> + *  Copyright (c) Linaro
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "system/hvf.h"
>> +
>> +bool hvf_allowed;
>> diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
>> index 91a2d219258..8ca1a4529e2 100644
>> --- a/accel/stubs/meson.build
>> +++ b/accel/stubs/meson.build
>> @@ -2,5 +2,6 @@ system_stubs_ss = ss.source_set()
>>   system_stubs_ss.add(when: 'CONFIG_XEN', if_false: files('xen-stub.c'))
>>   system_stubs_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
>>   system_stubs_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
>> +system_stubs_ss.add(when: 'CONFIG_HVF', if_false: files('hvf-stub.c'))
>>   specific_ss.add_all(when: ['CONFIG_SYSTEM_ONLY'], if_true: 
>> system_stubs_ss)
> 


