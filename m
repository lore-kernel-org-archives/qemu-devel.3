Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DABDD232F4
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 08:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve7yY-0001lV-4P; Fri, 09 Jan 2026 03:36:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve7yW-0001hJ-5B
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 03:36:04 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve7yT-0003VV-R4
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 03:36:03 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42fb03c3cf2so2109214f8f.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 00:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767947760; x=1768552560; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UDDVR7Ed2sDivgxWz/N806bI5gWDsfEAqRV7R2O2M0g=;
 b=K+NiSG3GXrSraA85Ps2DQeI8MXqouT4wueds1XGvUkeYewX8y4MKmY1B5t4gBWvMNQ
 iXay1zNkEu3klDuaN0KU3Og6P/kcY/av4U4m/gyMjcPrEnzWjpH49GPyBvRUVjWVP5Zv
 2Gp2EQe8rRm4gJfCi409Y88oJ2RSS2mFyYNIFrhz/zVhwRwU3f9rzazKVX5Jh3OLKtxg
 VABfGMDUzcaIzOZNcqTRmQNU+iJaxR+Tn3lfiH40tPrKY/06TOFM+ZJSQ2jm2g2gobWK
 kbAeQI2XybPZXro84Zn8F2NW4Gi06kyIWEifU59xPZOdmkqXniu0YARBp/vvB46yiwy3
 VPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767947760; x=1768552560;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UDDVR7Ed2sDivgxWz/N806bI5gWDsfEAqRV7R2O2M0g=;
 b=RLpm6cr3DJTXnxR+FxtuaXjpnMzlJYQa7x9hWORcvJLWreNPyNN7dSVt/Hz1UhyamB
 uG0Jm1FQH3g95fIt1ryeOAwoAxu8LASjinaI0tHyoXxeVoY22u0NXWm2yMNY8Blo9GO1
 ovwn5UI2XCZVuf33trGKLWKNFGSbxfE2CPzrNcI7XHcLNfOvhchNcp/VCMyrDm0eA8yM
 g+Pp8muEef7oUNNkkvy0P1V7rhHXjKYnr+UoiDSl+Uku/3XiF4yO541lPTbAFFK9RyjK
 l48EJhdLWYA2GKNiD//4R8ZSWHk3sbpPTGwZTDQkCtEqdQxERhOgGzcyliaKslzrV04G
 BJSQ==
X-Gm-Message-State: AOJu0Yx5hlqxH/AFveMRKQYlayE3vDWlRG14RS+oeFupEbKEa1T1GDNG
 IaiW/J9Q0pdCE/1DOsbbPoG965cgI3nt5J77EpmDTbPaUfjnMbwOe6+zGCJ1B5eAmYE=
X-Gm-Gg: AY/fxX6nrnS2gitv3A0aqIBnDOl+HF/ZrdEVSrYMYNecdQGsjdZL+8ybb964odsQ/2h
 TrkAeLYddWbQKdwl3OyrKYPsfGoOQ8R5CTsGSRUaxb9FMyNFeqHN3wFqIo4YHNDvKuFqfs4wDKh
 QAtDXei/OCEaAGTXQI2plJQy9eI2gVQEKIzDt13YGnIeiyqFjTXyCej4/ts4AuHzV2HoO921vqp
 d9XbL/7iyBORlnNo883A/fwIcq8tu/9Ebs5JWI236reTFaFH0zEjL4vof3CSjOWhlP9rnw7MMkB
 0J6zLfiWADx57IRCVHq7XFGTznf2gZfNEbYY3hGLUonblA8O54qwCENm2y6LMDxmxx0WRLLkDS6
 oj/hmu9iLwpz9mexPkfZTAE3g+9vKgIxyzkXt7Z7lqKx4mxb7boI/nY9xYJTU3epYUiNidjIeGP
 e/XCTkzLrsgNhtGlkf38p/fr1aeYBWeE8gPZkzBMRRtKD/6Vs35PsHEg==
X-Google-Smtp-Source: AGHT+IExWRh+7pBcCjdSJI1XmTl5Z+KWLEroJb17r849cyZhEVAiJppBWJ9KkDe1QJlOJnPPdXfqfg==
X-Received: by 2002:a05:6000:2dc2:b0:42b:3246:1681 with SMTP id
 ffacd0b85a97d-432c36340ccmr10644500f8f.18.1767947760101; 
 Fri, 09 Jan 2026 00:36:00 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df9c5sm21774761f8f.22.2026.01.09.00.35.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 00:35:59 -0800 (PST)
Message-ID: <39a8c5bd-b6ae-4da6-8ce0-22dcc6775db2@linaro.org>
Date: Fri, 9 Jan 2026 09:35:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] system: Convert qemu_arch_available() to TargetInfo API
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20260108163601.18676-1-philmd@linaro.org>
 <87ikdc825w.fsf@draig.linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87ikdc825w.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 8/1/26 18:06, Alex Bennée wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Get the base arch_mask from the current SysEmuTarget,
>> making qemu_arch_available() target-agnostic.
>>
>> We don't need the per-target QEMU_ARCH definition anymore,
>> remove it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> v3: Return directly within switch
>> v2: Prefer switch over array (pbo)
>> ---
>>   meson.build        |  2 --
>>   system/arch_init.c | 30 -----------------------
>>   target-info.c      | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>>   system/meson.build |  1 -
>>   4 files changed, 60 insertions(+), 33 deletions(-)
>>   delete mode 100644 system/arch_init.c
>>
>> diff --git a/meson.build b/meson.build
>> index 734c801cc77..435dc6e3c8e 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -3419,8 +3419,6 @@ foreach target : target_dirs
>>         config_target_data.set(k, v)
>>       endif
>>     endforeach
>> -  config_target_data.set('QEMU_ARCH',
>> -                         'QEMU_ARCH_' + config_target['TARGET_BASE_ARCH'].to_upper())
>>     config_target_h += {target: configure_file(output: target + '-config-target.h',
>>                                                  configuration: config_target_data)}
>>   
>> diff --git a/system/arch_init.c b/system/arch_init.c
>> deleted file mode 100644
>> index e85736884c9..00000000000
>> --- a/system/arch_init.c
>> +++ /dev/null
>> @@ -1,30 +0,0 @@
>> -/*
>> - * QEMU System Emulator
>> - *
>> - * Copyright (c) 2003-2008 Fabrice Bellard
>> - *
>> - * Permission is hereby granted, free of charge, to any person obtaining a copy
>> - * of this software and associated documentation files (the "Software"), to deal
>> - * in the Software without restriction, including without limitation the rights
>> - * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>> - * copies of the Software, and to permit persons to whom the Software is
>> - * furnished to do so, subject to the following conditions:
>> - *
>> - * The above copyright notice and this permission notice shall be included in
>> - * all copies or substantial portions of the Software.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
>> - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>> - * THE SOFTWARE.
>> - */
>> -#include "qemu/osdep.h"
>> -#include "system/arch_init.h"
>> -
>> -bool qemu_arch_available(unsigned qemu_arch_mask)
>> -{
>> -    return qemu_arch_mask & QEMU_ARCH;
>> -}
>> diff --git a/target-info.c b/target-info.c
>> index 24696ff4111..774fdcd2c46 100644
>> --- a/target-info.c
>> +++ b/target-info.c
>> @@ -11,6 +11,7 @@
>>   #include "qemu/target-info-qapi.h"
>>   #include "qemu/target-info-impl.h"
>>   #include "qapi/error.h"
>> +#include "system/arch_init.h"
>>   
>>   const char *target_name(void)
>>   {
>> @@ -33,6 +34,65 @@ SysEmuTarget target_arch(void)
>>       return arch;
>>   }
>>
> 
> This looks fine to me but I note the API takes a mask which implies you
> could potentially pass multiple arches in the mask. Not an issue now but
> we should probably add a kdoc to the declaration to make it clear you
> can only test one arch at a time for now.

There is no change in this API, your description is what is intended:
compile qemu-options once and display (-help) the relevant options for
the current (read in the future, "selected") target architecture.

If we want to add a @docstring to qemu_arch_available() this can be
done in parallel of this patch.

> 
>> +bool qemu_arch_available(unsigned qemu_arch_mask)
>> +{
>> +    switch (target_arch()) {
>> +    case SYS_EMU_TARGET_ALPHA:
>> +        return qemu_arch_mask & QEMU_ARCH_ALPHA;
>> +    case SYS_EMU_TARGET_ARM:
>> +    case SYS_EMU_TARGET_AARCH64:
>> +        return qemu_arch_mask & QEMU_ARCH_ARM;
>> +    case SYS_EMU_TARGET_I386:
>> +    case SYS_EMU_TARGET_X86_64:
>> +        return qemu_arch_mask & QEMU_ARCH_I386;
>> +    case SYS_EMU_TARGET_M68K:
>> +        return qemu_arch_mask & QEMU_ARCH_M68K;
>> +    case SYS_EMU_TARGET_MICROBLAZE:
>> +    case SYS_EMU_TARGET_MICROBLAZEEL:
>> +        return qemu_arch_mask & QEMU_ARCH_MICROBLAZE;
>> +    case SYS_EMU_TARGET_MIPS:
>> +    case SYS_EMU_TARGET_MIPSEL:
>> +    case SYS_EMU_TARGET_MIPS64:
>> +    case SYS_EMU_TARGET_MIPS64EL:
>> +        return qemu_arch_mask & QEMU_ARCH_MIPS;
>> +    case SYS_EMU_TARGET_PPC:
>> +    case SYS_EMU_TARGET_PPC64:
>> +        return qemu_arch_mask & QEMU_ARCH_PPC;
>> +    case SYS_EMU_TARGET_S390X:
>> +        return qemu_arch_mask & QEMU_ARCH_S390X;
>> +    case SYS_EMU_TARGET_SH4:
>> +    case SYS_EMU_TARGET_SH4EB:
>> +        return qemu_arch_mask & QEMU_ARCH_SH4;
>> +    case SYS_EMU_TARGET_SPARC:
>> +    case SYS_EMU_TARGET_SPARC64:
>> +        return qemu_arch_mask & QEMU_ARCH_SPARC;
>> +    case SYS_EMU_TARGET_XTENSA:
>> +    case SYS_EMU_TARGET_XTENSAEB:
>> +        return qemu_arch_mask & QEMU_ARCH_XTENSA;
>> +    case SYS_EMU_TARGET_OR1K:
>> +        return qemu_arch_mask & QEMU_ARCH_OPENRISC;
>> +    case SYS_EMU_TARGET_TRICORE:
>> +        return qemu_arch_mask & QEMU_ARCH_TRICORE;
>> +    case SYS_EMU_TARGET_HPPA:
>> +        return qemu_arch_mask & QEMU_ARCH_HPPA;
>> +    case SYS_EMU_TARGET_RISCV32:
>> +    case SYS_EMU_TARGET_RISCV64:
>> +        return qemu_arch_mask & QEMU_ARCH_RISCV;
>> +    case SYS_EMU_TARGET_RX:
>> +        return qemu_arch_mask & QEMU_ARCH_RX;
>> +    case SYS_EMU_TARGET_AVR:
>> +        return qemu_arch_mask & QEMU_ARCH_AVR;
>> +    /*
>> +    case SYS_EMU_TARGET_HEXAGON:
>> +        return qemu_arch_mask & QEMU_ARCH_HEXAGON;
>> +    */
>> +    case SYS_EMU_TARGET_LOONGARCH64:
>> +        return qemu_arch_mask & QEMU_ARCH_LOONGARCH;
>> +    default:
>> +        g_assert_not_reached();
>> +    };
>> +}
>> +
>>   const char *target_cpu_type(void)
>>   {
>>       return target_info()->cpu_type;
>> diff --git a/system/meson.build b/system/meson.build
>> index 4b69ef0f5fb..66e16db55ce 100644
>> --- a/system/meson.build
>> +++ b/system/meson.build
>> @@ -1,5 +1,4 @@
>>   specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
>> -  'arch_init.c',
>>     'globals-target.c',
>>   )])
> 
> Otherwise:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Thanks!


