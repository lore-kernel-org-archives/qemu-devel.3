Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27243C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 09:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI2pW-0003NX-HW; Fri, 14 Jun 2024 05:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sI2pU-0003MQ-Eh
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 05:02:40 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sI2pS-0001G5-KT
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 05:02:40 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52c8342af5eso2076938e87.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 02:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718355756; x=1718960556; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IdsCZ7IAnd57S07iovLyr7d2F/cn6ywH3sMHykm+ZsY=;
 b=Y2+F0hpSONDqRX1wx9F86HnRUcoanudHeGmh5TAySHlun1vjBqsOSoeFx4kMs+gFuV
 cwhrfk7ATjGSNNGaf2XGL4N+p78+cVez+LuaHI7RjgaOO2q6SUTTAddLuoEx4nNKkcm4
 wrFoY7NEcppy7tTlNgehBvU3ijseip8drf2RkMZK0xCnJJNeeEKNp4qZ/rTpINVkF/XE
 7QRCPn2IDMqh96czG3upGEy6mWeBrRo8t297fqFTy8QoCzizdj1YUJHhyLFR7JNP43Vh
 QEqzoK6xoSIu1pwxHKsgpirdPGoeuNcfZaqUPIDhnx+oKiMkFZivIph62a3QMqgIvLrh
 Loxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718355756; x=1718960556;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IdsCZ7IAnd57S07iovLyr7d2F/cn6ywH3sMHykm+ZsY=;
 b=NFIxwXUhZnE8E6pPR2rGq8zM+xev4AUhQ2bncAGBbqbzkyShrD9+j3TG7uRE+v9jXt
 D5VZ23Yc6NFHLUtwl1PTqF5lki4YaCcotuZF1OdDq7qM65XRarAu7Om/wHD4tTFHo9vM
 Wg2STyHErEDIOqZ/G3XSwG0V0LR3am8bmP5zVg9RouKYpsjee62++mFtKZ3/DpK2hccn
 la0kHoO4JA2IV0rJDgiQo7Tv4w4+kFyedcYwOa+AB8OcprFDHyCmWDERv+YQyY4JclbA
 hnTQj/+q8PsUuUpQHdM0lA8rclgYlj88App2rPDhKDxy0zslPbJQDlQ/QIV0P5t0nGn5
 3KAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU839D/NKztmUn6h4bnyFLvHCgoeLvcqMUS4rEg9YoIl7F/kAvYCfiMhY4f47vidmBYfCMkIbyqBuuLkkfPkwQz1FOaozo=
X-Gm-Message-State: AOJu0YyvtE5dg8AgiRai0zTNrAovqjFF6XLgaMJUBHQbZdCP9F6lQvd1
 pxVOt4UCI4ODYkXay3SZ8Ssvuu7N8cpIZP6mcKNvOYk/dD0UQKtdloJ2NK4ckq8=
X-Google-Smtp-Source: AGHT+IECovAU6JE59uWAppvg2bYZJoHCsygOPdgP8FIksM5Lh0XEI/vuVw/omnhf7GqcevD4PErgDw==
X-Received: by 2002:ac2:58f0:0:b0:52c:8158:3d7f with SMTP id
 2adb3069b0e04-52ca6e65753mr1117544e87.28.1718355756222; 
 Fri, 14 Jun 2024 02:02:36 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f6320bf2sm52153555e9.31.2024.06.14.02.02.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jun 2024 02:02:35 -0700 (PDT)
Message-ID: <472f46eb-6a3b-4eac-918f-63997989bcfc@linaro.org>
Date: Fri, 14 Jun 2024 11:02:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] target/arm: Factor out code for setting MTE TCF0
 field
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
References: <20240613172103.2987519-1-gustavo.romero@linaro.org>
 <20240613172103.2987519-7-gustavo.romero@linaro.org>
 <20996ca9-9feb-42ee-8850-af265f77f72b@linaro.org>
 <5a93c441-d1a4-6f60-1b35-a313dd9a1b62@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5a93c441-d1a4-6f60-1b35-a313dd9a1b62@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 13/6/24 20:15, Gustavo Romero wrote:
> Hi Phil,
> 
> On 6/13/24 2:35 PM, Philippe Mathieu-Daudé wrote:
>> On 13/6/24 19:21, Gustavo Romero wrote:
>>> Factor out the code used for setting the MTE TCF0 field from the prctl
>>> code into a convenient function. Other subsystems, like gdbstub, need to
>>> set this field as well, so keep it as a separate function to avoid
>>> duplication and ensure consistency in how this field is set across the
>>> board.
>>>
>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>> ---
>>>   linux-user/aarch64/target_prctl.h | 22 ++-----------
>>>   target/arm/mte.h                  | 53 +++++++++++++++++++++++++++++++
>>>   2 files changed, 55 insertions(+), 20 deletions(-)
>>>   create mode 100644 target/arm/mte.h
>>
>>
>>> diff --git a/target/arm/mte.h b/target/arm/mte.h
>>> new file mode 100644
>>> index 0000000000..89712aad70
>>> --- /dev/null
>>> +++ b/target/arm/mte.h
>>> @@ -0,0 +1,53 @@
>>> +/*
>>> + * ARM MemTag convenience functions.
>>> + *
>>> + * Copyright (c) 2024 Linaro, Ltd.
>>> + *
>>> + * This library is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU Lesser General Public
>>> + * License as published by the Free Software Foundation; either
>>> + * version 2.1 of the License, or (at your option) any later version.
>>> + *
>>> + * This library is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>> + * Lesser General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU Lesser General Public
>>> + * License along with this library; if not, see 
>>> <http://www.gnu.org/licenses/>.
>>> + */
>>> +
>>> +#ifndef MTE_H
>>> +#define MTE_H
>>> +
>>> +#ifdef CONFIG_TCG
>>> +#ifdef CONFIG_USER_ONLY
>>> +#include "sys/prctl.h"
>>> +
>>> +static void set_mte_tcf0(CPUArchState *env, abi_long value)
>>
>> Either declare it inlined (otherwise we'll get multiple symbols
>> declared if this header is included multiple times), or
>> preferably only expose the prototype.
>>
>> Also I'd use the 'arm_' prefix.
> 
> Thanks, I forgot to add the inline hint and was really wondering if
> I should add the arm_ prefix.

If you expose the prototype, it can be used elsewhere. Here it
will be used by linux-user code. Althought it will be used by ARM
specific code, from this other subsystem PoV it will be clearer
that this method is ARM specific if the prefix is used. But I'm
being picky and it isn't a requirement.

However the question about why do we want this method inlined remains
(usually all inlined functions need a justification).

>>> +{
>>> +    /*
>>> +     * Write PR_MTE_TCF to SCTLR_EL1[TCF0].
>>> +     *
>>> +     * The kernel has a per-cpu configuration for the sysadmin,
>>> +     * /sys/devices/system/cpu/cpu<N>/mte_tcf_preferred,
>>> +     * which qemu does not implement.
>>> +     *
>>> +     * Because there is no performance difference between the modes, 
>>> and
>>> +     * because SYNC is most useful for debugging MTE errors, choose 
>>> SYNC
>>> +     * as the preferred mode.  With this preference, and the way the 
>>> API
>>> +     * uses only two bits, there is no way for the program to select
>>> +     * ASYMM mode.
>>> +     */
>>> +    unsigned tcf = 0;
>>> +    if (value & PR_MTE_TCF_SYNC) {
>>> +        tcf = 1;
>>> +    } else if (value & PR_MTE_TCF_ASYNC) {
>>> +        tcf = 2;
>>> +    }
>>> +    env->cp15.sctlr_el[1] = deposit64(env->cp15.sctlr_el[1], 38, 2, 
>>> tcf);
>>> +}
>>> +#endif /* CONFIG_USER_ONLY */
>>> +#endif /* CONFIG_TCG */
>>> +
>>> +#endif /* MTE_H */
>>


