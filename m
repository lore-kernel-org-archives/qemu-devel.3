Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E84C36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 20:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u04Tm-0003iz-E1; Wed, 02 Apr 2025 16:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u04Tk-0003fN-QN
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 16:14:28 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u04Ti-000262-P2
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 16:14:28 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso930075e9.2
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 13:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743624864; x=1744229664; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yC+mNmtcpqdQdPqKkwgfAIKQoD1oxndOetvKGzyvIOo=;
 b=UnKZo7tr0cS7HiSFc1JTKtnL2fh5D6yXzY5a/gNf1rMls4FnProLzy1GWqyXVx70Mg
 6fjDENMz5/CELvO4GUelxyqmkw22yM8TaAUy1QOe1lKU0Nl/ikSnH6sCtTj9/1buTJXb
 sKaVTaXIu4ccT74vEruxm+Xci6wRbuR3ymBAf84anNyGi76nvDxWXHvzohtG1PWtMufU
 SzMaFtVmTZA0jYDTmnvpfPkwAMaqu9jRlBXlYG4os+ueKwJ+UcFCp22TS4rMwcZ6mhOm
 9/MOCu8+CIqeELmRV7JYLLKFQRAa+c/DbuE+su55la3nYT5mqQvpigGb54ggZDjTrjQW
 HT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743624864; x=1744229664;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yC+mNmtcpqdQdPqKkwgfAIKQoD1oxndOetvKGzyvIOo=;
 b=jV3E5gPA0wud0thwj6jyQYxpsR6mO7baB9GueTvncQBp8XhPp6aQ/vHlKIvZoE1KbB
 bzHIR8jOg0MHi1u9PS6FnrYA/IcvZaBNKXAYc/W7Iqb1saKJojm0dncYweI3cXYoSliZ
 Bd+JEaawatjqzQILfkMj8yWncQDtBMnkgrTjB4JoOPCWfsrhHeFkTzjMhICqsKPjPPf8
 FkQtI6miboT890D7kMDaTw/tFsUM8LWCgTHzU+TX1rcqL2DToUjS7c6k02lATpz00IJ3
 5aICBc3JO/7VIzzeY7HN4tle+5nHkXlmeUvo/vW8+AeqOpC8jH9mUB0Tqkedis7cyI66
 fAtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPyahiVp36/liblV+PPHYJVH9iHnnWQ3m9tf+Z+vfDx9TvHLFBC7ZudPQmZACLpbKOCtCC9S8XIh4U@nongnu.org
X-Gm-Message-State: AOJu0YzgoptKs3Sqggpcl3GXpubAwCOCEp5AezdRBzcCuQF4vidYlah+
 lXeyZM3uo4cftwSwRkFwPeotfdPP+l1BBt4tFtOfSQse6Jmn/R0eIdX1/zThePA=
X-Gm-Gg: ASbGncvkv/QpVt3q202JX+qphjFTQ3Uz2FZyPv2S20mAo1QuZO55oDTkA1WMW91IBHh
 HkbchzRAJNWVoFcV3vxTk6GmpYyV1dycT7mdAGi4y/yb42JjCfBhBm8wMX4FFqPknA1zJrxfKIh
 yg3YgxEtZ6b2WIBxokv6pLAvYfW9R181cXYFhU0uaFfQFeOlcXYoYrYwozUIbYPNH0/0fsxILrV
 MvCFihRwZ2qhKlbASoNL2m3/GrO7zWqPCc80U9ve0vfHj15AD9gjA/3Tu7gBL+l/HVF9u0jLju2
 5UCAxKU6C262Uuh5O9nhkXrvlla6j5xFuMcghcWNPxuHlrruRf0TwoQEFbpkLdI43PKYmZoYQcC
 DNvPz8o1ATial
X-Google-Smtp-Source: AGHT+IFsRAGtOLcXuaKfj4zoOC8lMC94oTgqbz2C3/avdtxxkmYWpjP/v1hh3LD97kXq6cAqRWMxaw==
X-Received: by 2002:a05:600c:3d0a:b0:43c:f597:d584 with SMTP id
 5b1f17b1804b1-43ec1532085mr1127305e9.29.1743624864321; 
 Wed, 02 Apr 2025 13:14:24 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43eb5fc57e9sm31209765e9.3.2025.04.02.13.14.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 13:14:23 -0700 (PDT)
Message-ID: <f239d840-19e9-4493-b4a0-1530a9b49713@linaro.org>
Date: Wed, 2 Apr 2025 22:14:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/42] include/exec: Split out cpu-mmu-index.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-7-richard.henderson@linaro.org>
 <7fbd71b6-8642-4374-a573-c9cc693e381c@linaro.org>
 <d6a62a7c-b857-45bf-b7f4-5a8863ce5b6c@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d6a62a7c-b857-45bf-b7f4-5a8863ce5b6c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 2/4/25 20:33, Richard Henderson wrote:
> On 4/2/25 04:26, Philippe Mathieu-Daudé wrote:
>> Hi Richard,
>>
>> On 18/3/25 22:31, Richard Henderson wrote:
>>> The implementation of cpu_mmu_index was split between cpu-common.h
>>> and cpu-all.h, depending on CONFIG_USER_ONLY.  We already have the
>>> plumbing common to user and system mode.  Using MMU_USER_IDX
>>> requires the cpu.h for a specific target, and so is restricted to
>>> when we're compiling per-target.
>>>
>>> Include the new header only where needed.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   include/exec/cpu-all.h        |  6 ------
>>>   include/exec/cpu-common.h     | 20 ------------------
>>>   include/exec/cpu-mmu-index.h  | 39 +++++++++++++++++++++++++++++++++++
>>>   include/exec/cpu_ldst.h       |  1 +
>>>   semihosting/uaccess.c         |  1 +
>>>   target/arm/gdbstub64.c        |  3 +++
>>>   target/hppa/mem_helper.c      |  1 +
>>>   target/i386/tcg/translate.c   |  1 +
>>>   target/loongarch/cpu_helper.c |  1 +
>>>   target/microblaze/helper.c    |  1 +
>>>   target/microblaze/mmu.c       |  1 +
>>>   target/openrisc/translate.c   |  1 +
>>>   target/sparc/cpu.c            |  1 +
>>>   target/sparc/mmu_helper.c     |  1 +
>>>   target/tricore/helper.c       |  1 +
>>>   target/xtensa/mmu_helper.c    |  1 +
>>>   16 files changed, 54 insertions(+), 26 deletions(-)
>>>   create mode 100644 include/exec/cpu-mmu-index.h
>>
>>
>>> diff --git a/include/exec/cpu-mmu-index.h b/include/exec/cpu-mmu-index.h
>>> new file mode 100644
>>> index 0000000000..b46e622048
>>> --- /dev/null
>>> +++ b/include/exec/cpu-mmu-index.h
>>> @@ -0,0 +1,39 @@
>>> +/*
>>> + * cpu_mmu_index()
>>> + *
>>> + *  Copyright (c) 2003 Fabrice Bellard
>>> + *
>>> + * SPDX-License-Identifier: LGPL-2.1+
>>> + */
>>> +
>>> +#ifndef EXEC_CPU_MMU_INDEX_H
>>> +#define EXEC_CPU_MMU_INDEX_H
>>> +
>>> +#include "hw/core/cpu.h"
>>> +#include "tcg/debug-assert.h"
>>> +#ifdef COMPILING_PER_TARGET
>>> +#include "cpu.h"
>>
>> IIUC we only need "cpu.h" on user emulation. Maybe use:
>>
>>    #if defined(COMPILING_PER_TARGET) && defined(CONFIG_USER_ONLY)
> 
> Can't.
> 
>>> +#ifdef COMPILING_PER_TARGET
>>> +# ifdef CONFIG_USER_ONLY
> 
> It would have to be this nesting, for the poisoning.

Fine then, so we avoid including the huge "cpu.h" when not necessary.


