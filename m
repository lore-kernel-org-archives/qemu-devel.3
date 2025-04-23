Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C8FC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 16:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7crw-0002uP-N6; Wed, 23 Apr 2025 12:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7cru-0002sc-3e
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 12:22:38 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7crs-0002dp-6t
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 12:22:37 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-227c7e57da2so302475ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 09:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745425354; x=1746030154; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QWz7FicHLovvg8L4dw0wM0UH8WWQl8JZyYHsKTsJBsA=;
 b=rCaAq0ZGvvdAqmnRR+xbVpLA8cBWxI4Um82TGhsx+OTxXwyYKa9u4t80L+OTsZQak9
 huTD/DYYBcpEoRgOkQiiFAKqL3V+mcd7smUJr8Z9nyKLWMTf4a0gbHWwAF4BAf4gj1UC
 AG4yZy3AzD9cqm6IzQ/r/uf7WcZr0baGuKFNC+9jiQF7OZdDU6fx5+5dFZMnwBoRImPP
 oYxwvOV/2MNEItFNEj0byvemLoampWBXgDxtrLjFHOCOThFlF63GMhUjkgGX/Ug9MuZb
 Q+v2YgdJY0l5zNKCrNO8Abbc3vlh0YKpinQgIsIOAOKm3IUhsyOaC3OmjvJ2THCHrxlG
 wNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745425354; x=1746030154;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QWz7FicHLovvg8L4dw0wM0UH8WWQl8JZyYHsKTsJBsA=;
 b=p5wGw+NrkJ8B+9PyaiUQ/W5aAj2fqikzd0Couo1bOStdUUmLZqJzsn7MHZWkhGREwy
 vgInvwHrG5GmJTi/KF1XVqE7y3iaV0heg7rEAG/q53KS02HeDy4rA7kuqDjhRn0FphI4
 68hgN4i6UYylkDKP0CY41ISZY3eiF4Dq7ioiB+FMd2nESTZQ1fvin4caQYfyU0bENz67
 H759mUFHCTU0uvKoASx3XaLQSrZPlVZFsiDdqbxVrlYkeXuKZUPQF/A4K0N+9BqLKGxC
 7fTHbDtGysr0RT0ZSP7D7F7SFzU5jgshtNZAN25/FLR9bP9a6KCJsmkCCJnjg1j2cQDq
 Cvrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZzYhsMd29NhgLOfFYneqcldMCtjJsQBtsSoECsijiYx0tcu2uSfTVhXCzdCAzMuk2M9m3scUpMaIU@nongnu.org
X-Gm-Message-State: AOJu0YxuHjLyO9fYUG1IaxRhWJGQIEQixaF8rAC3jWn6Ls/YVHzaw+Cv
 5cI1wS+RSytPjswcHFBt1E7Kjugc5TKbi/AhbxZT0JaLBLtb1433n8m5eZFrUzM=
X-Gm-Gg: ASbGncuk/Lh8ET8wuePuOTaxkiL9OOiActeEv7tGtiVUGneXPFDo3TBDlIM12j6FpXA
 obs6nGi3LuG31YmfJ3SFTMjywZRnvCZHIk6WlW6fKkesI+Zb0najeeF9CDh54QiLBbs57Gs7PXc
 IXz/jZXJOHct5K+e2P/cfaCc7BnIlTP00Ds8Mg5lTXtSTkXOT3610q1zJLMcZ4+gJoAZW77rSL8
 fNSgXqa99dzgcGOzmjDE23NEMRdEzY7t7NZUvO6+uUYOZ3ejKChIqfLNWnN/mcaj6x1KsTrNt4e
 KGznDczvFx9QJMx97UMSQKxtu4W6thD09nl+Nzl8owbn7vKUcIEV+Q==
X-Google-Smtp-Source: AGHT+IFLDgqeQ2V0dKHTmNluw2ifaePhw44dWNsjp7B6P2Hh+TpQAaWnFNlwrqd2yyN66GTsiZNLgQ==
X-Received: by 2002:a17:90b:5103:b0:2ff:62f3:5b19 with SMTP id
 98e67ed59e1d1-3087bb530e4mr30787081a91.13.1745425354595; 
 Wed, 23 Apr 2025 09:22:34 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309e0cceeadsm1820134a91.36.2025.04.23.09.22.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 09:22:34 -0700 (PDT)
Message-ID: <6a5700fc-25a4-4f53-a3a6-b579de46b03c@linaro.org>
Date: Wed, 23 Apr 2025 09:22:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 105/147] exec/cpu-all: remove tswap include
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-106-richard.henderson@linaro.org>
 <86ba7919-db11-45cd-8bdd-ede8f25f92d2@linaro.org>
 <f3ce25db-36dd-41fb-be98-45db9716634d@linaro.org>
 <e18e1ad1-badb-400c-b9a6-04749c7c324a@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <e18e1ad1-badb-400c-b9a6-04749c7c324a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 4/23/25 09:17, Philippe Mathieu-Daudé wrote:
> On 23/4/25 18:09, Pierrick Bouvier wrote:
>> On 4/23/25 03:27, Philippe Mathieu-Daudé wrote:
>>> On 22/4/25 21:27, Richard Henderson wrote:
>>>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>
>>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>> Message-ID: <20250325045915.994760-7-pierrick.bouvier@linaro.org>
>>>> ---
>>>>     include/exec/cpu-all.h               | 1 -
>>>>     target/ppc/mmu-hash64.h              | 2 ++
>>>>     target/i386/tcg/system/excp_helper.c | 1 +
>>>>     target/i386/xsave_helper.c           | 1 +
>>>>     target/riscv/vector_helper.c         | 1 +
>>>>     5 files changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
>>>> index 957c86886e..bfa039ab76 100644
>>>> --- a/include/exec/cpu-all.h
>>>> +++ b/include/exec/cpu-all.h
>>>> @@ -21,7 +21,6 @@
>>>>     #include "exec/cpu-common.h"
>>>>     #include "exec/cpu-interrupt.h"
>>>> -#include "exec/tswap.h"
>>>>     #include "hw/core/cpu.h"
>>>>     #include "exec/cpu-defs.h"
>>>>     #include "exec/target_page.h"
>>>> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
>>>> index ae8d4b37ae..b8fb12a970 100644
>>>> --- a/target/ppc/mmu-hash64.h
>>>> +++ b/target/ppc/mmu-hash64.h
>>>> @@ -1,6 +1,8 @@
>>>>     #ifndef MMU_HASH64_H
>>>>     #define MMU_HASH64_H
>>>> +#include "exec/tswap.h"
>>>
>>> This header doesn't use "exec/tswap.h". Maybe you want this
>>> reviewed patch instead:
>>>
>>> https://lore.kernel.org/qemu-devel/20241211230357.97036-6-
>>> philmd@linaro.org/
>>>
>>>> +
>>>>     #ifndef CONFIG_USER_ONLY
>>>>     #ifdef TARGET_PPC64
>>>
>>
>> See: [PATCH 002/147] exec/tswap: implement {ld,st}.*_p as functions
>> instead of macros.
>> It removes macro definitions from cpu-all.h, and implement those as
>> proper functions in exec/tswap.h.
>>
>> ppc/mmu-hash64.h uses ld*_p, which are defined in exec/tswap.h, so it's
>> the correct place for this include.
> 
> Ah I missed that, OK then.
> 
> 

No worries, it's a bit confusing with all the variants we have, and I 
had to reproduce the compile error to find what was the rationale, so it 
makes sense you missed it.

