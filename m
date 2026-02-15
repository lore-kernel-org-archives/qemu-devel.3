Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801DDEF585D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 02:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrRTn-0005tV-5K; Sat, 14 Feb 2026 21:03:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vrRTm-0005tF-1T
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 21:03:22 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vrRTk-0008O5-B1
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 21:03:21 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso16036845e9.1
 for <qemu-devel@nongnu.org>; Sat, 14 Feb 2026 18:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771120998; x=1771725798; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J72i9L6gdQo4+5iUFi/LV2Mp2d+/Aja3q3m2brQdJwI=;
 b=wYiRiZhRjcFTOa3lSDlSPS3Xvq8AIvuFMpai9itkTDVetD6nBOmwAt4WWIRqBSO9yl
 Hljey1oFcbAdRBtCINLPKKcF602i+vmLIFJr0+i8Mxrk853EC/QboI4rJCTtYrnXR/D2
 7PXRYg0buW1nUcPcA/tuwxMr9SOgc5b/sqf6p3khFYSl31tppZzX244/WmnhLNS4HVWm
 dpPoJEnTjwB+pNwzBgaSY49QG8vou7nDIhTnIhxRfkiC06oq+KYgWjaOnQEZbKklIGuo
 vEG/NHY56jVgIx97X+G3PqAS65uCPAScfYRPyyGYI93KbMl+NZqjJC+hRdP8dunOF8+E
 6ZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771120998; x=1771725798;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J72i9L6gdQo4+5iUFi/LV2Mp2d+/Aja3q3m2brQdJwI=;
 b=wDq8t/89O8klyK/RocxVQWIDQ+NQxHXCM/0zf+BFb4M3i3Waul32GS4qgAeh5S9tZ6
 2N6bIID+492xzItUZ7br+E1uPxsq5JozboX6khBKK7Nh7WFi+SL9bkQRmZZx3mKyWVx/
 Q3iaB3sW9otNA0jX46jjRdDC4e0C6CD/7SZZGPBtNPoejRu32fJO3pkRBeLv3w4Hx+aI
 fXmsowUw9V7FWwigCylKp+BQXCqPmLabOQ3rEbQVxX/tFE17PJW9cJMuMAJkoMo3ZhCt
 dMgU1pMLhSXFKJBe8KLjJNV6C40BvlqSPuqLanO1UPPo1HGr+AJq6Nib8H3v1ZHjVmTJ
 aODA==
X-Gm-Message-State: AOJu0YwRkCjJoXOZVZBWhl5EWqI2fr0pNAwhdUsPwHPa40RjMzHkdQ7Z
 kc+T/5+AX2nzNzUX+kp801OndTQgYB3XtqO5rvv/U2GmKL9L12EKXrgZy7pBXV4b4rs=
X-Gm-Gg: AZuq6aKSMjmvZqsvu2WfR5Q5ncRbh7/cCvvqY3jBhjD4Z2LMe+UTK9GYA0YLb76Flya
 GgoA8h3Hslhc598nboLEhqf+rEMrbYoD5+IcDi1T+Uq5SvgCCDuu44vtEfNtBYxjoWsZHwc3oTa
 XWfdI/CQOorSB8ebznK7DMrZ/XvYdDf8DUP3r/Gy1SOwOt8OKdCw8mXP006jsk3eQg4gPgoRIRc
 DwuXiqyiVk/JWHUVVWIanKH8uV79rtQ/ZBoELIsSGf2bTvZLsWT7aLnDA8vL6B98PD9hak4XDxm
 gw7slOV6fvfO7URu9vWtkaDO7IJ/WutK9S6y2keODt8/sYrH1oNr+pIUnXuctzBymO3d0pUowTN
 CZxIX7/mpOcpxKydXQcTBjQEhjnE0Vwy5Md11p8CR4O3VcIuuS+fkeVYaTemdHvhXDZL4aiv3x0
 ym4k0c4C6cCxyWe1iZtVeGBJ5Wu1kYxvnUZrZS2SVvWjO+ZQ/xsnrN2sFQcjZMIN0cFQ==
X-Received: by 2002:a05:600c:8b26:b0:480:6ab1:ed0d with SMTP id
 5b1f17b1804b1-48373a1acb0mr106754065e9.9.1771120998503; 
 Sat, 14 Feb 2026 18:03:18 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796abc85csm16319613f8f.22.2026.02.14.18.03.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Feb 2026 18:03:17 -0800 (PST)
Message-ID: <e1acd88a-677a-46bc-94b9-f35adac53599@linaro.org>
Date: Sun, 15 Feb 2026 03:03:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] system/globals: Build as common code
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260214021240.58657-1-philmd@linaro.org>
 <20260214021240.58657-9-philmd@linaro.org>
 <6c85073c-e70c-3cb2-d2ad-57c5177dab88@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6c85073c-e70c-3cb2-d2ad-57c5177dab88@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 14/2/26 12:53, BALATON Zoltan wrote:
> On Sat, 14 Feb 2026, Philippe Mathieu-Daudé wrote:
>> Now than all targets have the graphic dimension variables
> 
> Typo: ^^^^ that
> 
>> initialized the same way, we can move them to the common
>> file unit, having them built once. Remove the now empty
>> globals-target.c file.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> system/globals-target.c | 14 --------------
>> system/globals.c        |  3 +++
>> system/meson.build      |  4 ----
>> 3 files changed, 3 insertions(+), 18 deletions(-)
>> delete mode 100644 system/globals-target.c
>>
>> diff --git a/system/globals-target.c b/system/globals-target.c
>> deleted file mode 100644
>> index ffa6c308b59..00000000000
>> --- a/system/globals-target.c
>> +++ /dev/null
>> @@ -1,14 +0,0 @@
>> -/*
>> - * Global variables that should not exist (target specific)
>> - *
>> - * Copyright (c) 2003-2008 Fabrice Bellard
>> - *
>> - * SPDX-License-Identifier: MIT
>> - */
>> -
>> -#include "qemu/osdep.h"
>> -#include "system/system.h"
>> -
>> -int graphic_width;
>> -int graphic_height;
>> -int graphic_depth;
>> diff --git a/system/globals.c b/system/globals.c
>> index c33f6ed3902..34fd3ce9c72 100644
>> --- a/system/globals.c
>> +++ b/system/globals.c
>> @@ -49,6 +49,9 @@ bool enable_cpu_pm;
>> int autostart = 1;
>> int vga_interface_type = VGA_NONE;
>> bool vga_interface_created;
>> +int graphic_width;
>> +int graphic_height;
>> +int graphic_depth;
> 
> Where do other machines get their default values from now?

These are the same globals... If you use -g WxH[xD] they will
be initialized from 0 -> W, 0 -> H, 0 -> D; then machine_init
code will notice the globals aren't 0 anymore.

> This used to 
> have #else 800x600x32 which is the default resolution when not 
> specifying a -g option and some machines may depend on that. Where that 
> default is
> established now?
> 
> Regards,
> BALATON Zoltan
> 
>> Chardev *parallel_hds[MAX_PARALLEL_PORTS];
>> QEMUOptionRom option_rom[MAX_OPTION_ROMS];
>> int nb_option_roms;
>> diff --git a/system/meson.build b/system/meson.build
>> index d91703d3dcc..579e8353d53 100644
>> --- a/system/meson.build
>> +++ b/system/meson.build
>> @@ -1,7 +1,3 @@
>> -specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
>> -  'globals-target.c',
>> -)])
>> -
>> system_ss.add(files(
>>   'vl.c',
>> ), sdl, libpmem, libdaxctl)
>>


