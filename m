Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E364C282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdea-0003gG-FG; Tue, 04 Mar 2025 20:34:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpde9-0002XH-9F
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:34:17 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpde1-0001sG-RV
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:34:01 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-439ac3216dcso42558335e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741138436; x=1741743236; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9wJKpxSEieUKEFSqNm6iegSrugYLaZFTDaSYIwJxfeY=;
 b=CnrIE1AlVMZsOi7/dTkWC8W+jW+xbBJK7aqigS8F0Y41daY3i9/irRGQmQo5fg9FFV
 Y4Y7PonKHojaQ7oUtFxluaeYL2vnUSq345+kirN4RhXzOHfsAkn6J7w9YFi2vXr0wO8U
 YhFDOYbZE+TnR85q8FiVfuHYb06xreaWqGMSN1STdZGHgYCh0tmUcKO82aeQE9suu/zb
 2bH3SS0D2LkwGEAMzITWmb8XAbVheMB2f5O5TJI882NKvFl7iy/0lw6D3k8+HyNuD74L
 6tBshJOJ91KTKhLJHQssXecg+OTtnvAY1oQkS67dtzjxdeGUWQf7WBs9nq6eTSbyKPDt
 OqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741138436; x=1741743236;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9wJKpxSEieUKEFSqNm6iegSrugYLaZFTDaSYIwJxfeY=;
 b=EKht+5F3yKg79P7qdr7LUwztoJY0RGm7lcW9EaXguDBc91nNnjJ7Ru3urB0p01N77n
 bK4hkvZgcH2Wujv12peeU8/NJWyB8PLdu9vf4Js/+vWKA+WU54DvT82mCNkLiaFfnFqt
 KRg5sDptyt5gGpeRWHBNN5Vz/eUaE/C1aXaoas5jBaGsDCAVoSQQaDY7WrHl8nz0nRsb
 dFSMty8uy71vuFX0u85RXe4W9MFfQtOtj1G4jk/VOlgwyEKpceShXcxUgqlUxNmwjNUk
 +ARbiPJ/3aWxDNpWIAOqkqO1ef/k8WhuGUqdI9I/cNSTdwbHTFf1UlkH52ffz96FkmLv
 Lm3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuAcdU54eP8DQB4/rCLPKa5ccOVqE3UKWxL0rLKvWZsNwrX4uoPfYpZszcnip0FM7cPz5gOZ9sc8C9@nongnu.org
X-Gm-Message-State: AOJu0YyW+gdW2IDAECCzZPXh3BNuGfmZYBy0ZPSDYsiG6h9x2I1n/FTJ
 BRi7DLE4MPrOPeW2GCAEEdGNT0hEyVMUXMUozwQ5i5iXD7mOk3MyKk5TmcF0zQc=
X-Gm-Gg: ASbGncskE0QIqf1iEMcZr337cIT6FLE5Zfl9dOrnV6UVkSP6XmIZOYnPh2QmwNjAs+W
 bLeJHVazh3+vbJ58kNGMAUHUN68F3pTvp6+1ESgKJQ+FyAyPlq7EtjklHtoy9g+aKyvmQ3Wlr6+
 lt9KsxciyXUPBFyV2pGESglu9B3xWgjHDf2QF2JOvA/hiQ22Fe69vOXYvNUSTJTl1RAlVaxH73Q
 BCno1P50CXt2XDt5/TN27yGLRZAlj08AAvoW1ID/guqph4Ac/0t3UbY0HvmoxHvPNGM7sEjOxst
 E9IfGIsUIj00NzebCWkm+5Yy5AyDWAkI1PXTvCsm4mPF18bVmNysynGyThec/PxErOGfLqIGsZX
 wMWxYSluPg2Zn
X-Google-Smtp-Source: AGHT+IF+zTe+zQMKXqLwnnhgE1wblJUPCNU0+KIpcpOvdF1H7gGijcweHgaYa4xja9KZVwzo5ojXbw==
X-Received: by 2002:a05:600c:3ba8:b0:43b:d0fe:b8e5 with SMTP id
 5b1f17b1804b1-43bd29c7a24mr5339045e9.25.1741138435923; 
 Tue, 04 Mar 2025 17:33:55 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd435c88esm1977485e9.36.2025.03.04.17.33.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 17:33:54 -0800 (PST)
Message-ID: <a11bfca2-5ffc-49b4-94fa-e5d466bc56bf@linaro.org>
Date: Wed, 5 Mar 2025 02:33:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/11] system: Extract target-specific globals to
 their own compilation unit
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250305005225.95051-1-philmd@linaro.org>
 <20250305005225.95051-2-philmd@linaro.org>
 <539de40b-de27-4781-bcb0-46986fc2f28f@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <539de40b-de27-4781-bcb0-46986fc2f28f@linaro.org>
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

On 5/3/25 02:20, Pierrick Bouvier wrote:
> On 3/4/25 16:52, Philippe Mathieu-Daudé wrote:
>> We shouldn't use target specific globals for machine properties.
>> These ones could be desugarized, as explained in [*]. While
>> certainly doable, not trivial nor my priority for now. Just move
>> them to a different file to clarify they are *globals*, like the
>> generic globals residing in system/globals.c.
>>
> 
> Maybe those could be set globally to the default:
> int graphic_width = 800;
> int graphic_height = 600;
> int graphic_depth = 32;
> 
> And override them for sparc and m68k in qemu_init_arch_modules function, 
> using qemu_arch_name().
> This way, no need to have a new file to hold them.

This is not what Paolo explained ...

> 
>> [*] https://lore.kernel.org/qemu-devel/e514d6db-781d-4afe- 
>> b057-9046c70044dc@redhat.com/

... here ^, but maybe I misunderstood him.

Doing the '-g' CLI change is not my priority, and I welcome
any developer willing to help :) Here I'm just trying to make
sense of that arch_init.c file.

>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   system/arch_init.c      | 14 --------------
>>   system/globals-target.c | 24 ++++++++++++++++++++++++
>>   system/meson.build      |  1 +
>>   3 files changed, 25 insertions(+), 14 deletions(-)
>>   create mode 100644 system/globals-target.c
>>
>> diff --git a/system/arch_init.c b/system/arch_init.c
>> index d2c32f84887..ea0842b7410 100644
>> --- a/system/arch_init.c
>> +++ b/system/arch_init.c
>> @@ -25,20 +25,6 @@
>>   #include "qemu/module.h"
>>   #include "system/arch_init.h"
>> -#ifdef TARGET_SPARC
>> -int graphic_width = 1024;
>> -int graphic_height = 768;
>> -int graphic_depth = 8;
>> -#elif defined(TARGET_M68K)
>> -int graphic_width = 800;
>> -int graphic_height = 600;
>> -int graphic_depth = 8;
>> -#else
>> -int graphic_width = 800;
>> -int graphic_height = 600;
>> -int graphic_depth = 32;
>> -#endif
>> -
>>   const uint32_t arch_type = QEMU_ARCH;
>>   void qemu_init_arch_modules(void)
>> diff --git a/system/globals-target.c b/system/globals-target.c
>> new file mode 100644
>> index 00000000000..989720591e7
>> --- /dev/null
>> +++ b/system/globals-target.c
>> @@ -0,0 +1,24 @@
>> +/*
>> + * Global variables that should not exist (target specific)
>> + *
>> + * Copyright (c) 2003-2008 Fabrice Bellard
>> + *
>> + * SPDX-License-Identifier: MIT
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "system/system.h"
>> +
>> +#ifdef TARGET_SPARC
>> +int graphic_width = 1024;
>> +int graphic_height = 768;
>> +int graphic_depth = 8;
>> +#elif defined(TARGET_M68K)
>> +int graphic_width = 800;
>> +int graphic_height = 600;
>> +int graphic_depth = 8;
>> +#else
>> +int graphic_width = 800;
>> +int graphic_height = 600;
>> +int graphic_depth = 32;
>> +#endif
>> diff --git a/system/meson.build b/system/meson.build
>> index 4952f4b2c7d..181195410fb 100644
>> --- a/system/meson.build
>> +++ b/system/meson.build
>> @@ -1,6 +1,7 @@
>>   specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
>>     'arch_init.c',
>>     'ioport.c',
>> +  'globals-target.c',
>>     'memory.c',
>>     'physmem.c',
>>     'watchpoint.c',
> 


