Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD03C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7t94-0006ON-Mj; Thu, 24 Apr 2025 05:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7t92-0006O3-VW
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:45:25 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7t91-0002TA-9P
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:45:24 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43d04ea9d9aso3139655e9.3
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 02:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745487921; x=1746092721; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YzpELu0s5GVees9f/wR8bk5mSi5nRLFcy/Gxi3CKgi8=;
 b=l8fg/SFEP1F4dBprATsTv/vf3a0EyIf3WRDyZOXWPAg5tatM4oMumkMDrbJfaL77DT
 g/Y/dNpopOWUivFjeJkrDP76gpHu94nbTzk+lSFjPrlFgVrrc6KSjI8sFTkqwi6gGQXW
 sv/h9m48UXVyYHryyn+VriXSRLgSLw375ybJsjBDf2/3Eh5i42KZE8l9YAaj4aku+E0Q
 q/BS+L4WhwRuaEnP0grMsn8nsbUbj45yQDI+dpPp/f5OBvOVyNe/gfYDs2Qi4z+g7S66
 o/AdG1SqI9wAr5K5S3jsP6e72YCLQ2UqM1SwJL3dXfH8wkCBdx+dP3aOWUyavIFTy5V9
 qfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745487921; x=1746092721;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YzpELu0s5GVees9f/wR8bk5mSi5nRLFcy/Gxi3CKgi8=;
 b=VomnPGSsrKVuYU4Wq+WhZSLwnJk5poTpFvFwKfqVcOkqBdECv1+bgK1Vc6XJGSRa+i
 SVacBEt5nwUXIcFfhhFcPcPeApoA3+jvu7HjbdlUHCvgB0EeqWAZXHz3r4pzvhzmNkgf
 Gdw/N86eCDLsFyxYJrdeuWgC3xem5BUiy2rmShW069j5ML/5/zXvCqJG2K8aSI+hRYQ7
 lrcrDSz3kZm19xRvT1glCQWC6a/l9OlwC7VUr6IXVtI/2YkM481VyXcNin0wwkPgJj3+
 oqK2cDoUhMzPUBmqjZsMkxF3ACHN0cQetDmktWMh73pcld8rUOy7JPsQd36jxslmTdB7
 IuvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWASz1vuAik/gdQoUz5lD76tfTQP9tbLzP66AXeG/LaFvPXy9NA0sKrwdZ5EP2d7dgLAT7HlNN2ui33@nongnu.org
X-Gm-Message-State: AOJu0Yyis9FvGnZDmBRXjCd4kmHAziz/CfuuieLIXh+S1Nbk50b9EYy7
 +Yu/2IVULpdYfokopATuiiu8z/GXP9gd5B1d5jzu+P9FBmEaYH/OjPDxVH1tkAI=
X-Gm-Gg: ASbGncu2IOdM8VsFhlbHtj9+taXSty6GHshSauQTBdsCpz7TYaA/LHgf8rv73bCgqZv
 qutKzEiRNFH23EjqLSkMlNYbaxjefDk4upmhcsEDWdqYcBYZs1bSiz4g6O8eZxQn8/H21fJtNAe
 VFNgrk/Cuzk9iFEaOdSFdgdcg6Nfegr86clftTOpCbB16Batms8Cg0ZpHgFUV28jysqXr2VrEGD
 os+HZUvZxkx6097/MGBDyYH8WHe1xGXkCyssWOIghgqc+nU7KVOtWmpsk1va7S/Ng1cIE637RVW
 lP2yHhlw8bZp3+ex93omcb+F6UWuHvvHY0zhWXeBeleMSw++cD2U+F4vJb8qSmImeYrsD+LB4vo
 vvB1CW0Hurf+YGA==
X-Google-Smtp-Source: AGHT+IGan+37u5SADb6soRFj9z37vpM1/o8/D2GcotlylOvkSNWuO9WjyQhuG64MnjHbsQrzL3se2A==
X-Received: by 2002:a05:600c:1f0c:b0:43d:fa5d:9315 with SMTP id
 5b1f17b1804b1-4409bdaafb1mr16343925e9.33.1745487920708; 
 Thu, 24 Apr 2025 02:45:20 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2a2f3csm14089455e9.11.2025.04.24.02.45.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 02:45:19 -0700 (PDT)
Message-ID: <2838b73d-6d03-4846-b953-5b1318a62844@linaro.org>
Date: Thu, 24 Apr 2025 11:45:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] include/exec: Move tb_invalidate_phys_range to
 translation-block.h
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250424011918.599958-1-richard.henderson@linaro.org>
 <20250424011918.599958-15-richard.henderson@linaro.org>
 <d48bfcaa-5d98-41cf-9ab0-829ba5f8bdd7@linaro.org>
 <35f49ccb-05fc-4143-9af1-c4a43e83d293@linaro.org>
 <52a40a95-97cb-47fd-8cf7-05dbfbde2601@linaro.org>
Content-Language: en-US
In-Reply-To: <52a40a95-97cb-47fd-8cf7-05dbfbde2601@linaro.org>
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

On 24/4/25 09:48, Philippe Mathieu-Daudé wrote:
> On 24/4/25 09:36, Philippe Mathieu-Daudé wrote:
>> On 24/4/25 09:33, Philippe Mathieu-Daudé wrote:
>>> On 24/4/25 03:19, Richard Henderson wrote:
>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>> ---
>>>>   include/exec/exec-all.h          | 4 ----
>>>>   include/exec/translation-block.h | 4 ++++
>>>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
>>>> index 24383b6aba..90986152df 100644
>>>> --- a/include/exec/exec-all.h
>>>> +++ b/include/exec/exec-all.h
>>>> @@ -120,10 +120,6 @@ int probe_access_full_mmu(CPUArchState *env, 
>>>> vaddr addr, int size,
>>>>   #endif /* !CONFIG_USER_ONLY */
>>>>   #endif /* CONFIG_TCG */
>>>> -/* TranslationBlock invalidate API */
>>>> -void tb_invalidate_phys_range(CPUState *cpu, tb_page_addr_t start,
>>>> -                              tb_page_addr_t last);
>>>> -
>>>>   #if !defined(CONFIG_USER_ONLY)
>>>
>>> We don't need to include "exec/translation-block.h" anymore, please 
>>> remove it.
>>
>> To squash:
>>
>> -- >8 --
>> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
>> index 90986152df3..4c5ad98c6a9 100644
>> --- a/include/exec/exec-all.h
>> +++ b/include/exec/exec-all.h
>> @@ -22,4 +22,6 @@
>>
>> +#include "exec/hwaddr.h"
>> +#include "exec/memattrs.h"
>>   #include "exec/mmu-access-type.h"
>> -#include "exec/translation-block.h"
>> +#include "exec/vaddr.h"
>>
>> ---
>>
> 
> and because "exec/translation-block.h" includes "exec/cpu-common.h":
> 
> -- >8 --
> diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
> index b2b9881bdfb..3b76b8b17c1 100644
> --- a/accel/stubs/tcg-stub.c
> +++ b/accel/stubs/tcg-stub.c
> @@ -13,4 +13,3 @@
>   #include "qemu/osdep.h"
> -#include "exec/tb-flush.h"
> -#include "exec/exec-all.h"
> +#include "exec/cpu-common.h"
> 
> ---

FYI I'll repost this patch updated as v2.

