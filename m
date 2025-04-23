Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AEAC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 16:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7cnD-0001BY-Un; Wed, 23 Apr 2025 12:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7cnB-0001B8-UA
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 12:17:45 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7cn9-00026e-Oc
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 12:17:45 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso73295e9.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 09:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745425061; x=1746029861; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k3RnWfoSGPb/dYt2u5wUiUrr41UcOxYQens0St821/I=;
 b=JY0feUTOaw5U0w8CaX+H6rAeZRnpLCW42i3ObrTg+Eok7K3wOo0s8QXwwQmYeLC5Cz
 lSLnjz6awOBzdZpQxGx03QbsW0xgj3VZ6vlpRjnN2PMjdr/yUPWHO2LzhRwZnEOj0SAr
 OWj+PFQ3/QzO+b2TeVRpDo5BnnEp/C6M997shsF8xoQ6kK/aiFdsJQoaYRA0RFJipwhm
 x8ekQbIy3vJHJ4S6UeyqlOKb02kcwfglPSZQomsIZZBB2mD3/SEyBeJorUw1vf+du8AD
 SjJgCY6WrkIXuL456dvzCP99Z9a6x1l3lLK8zlpBbynN8FQ0gTXdP195pwE8gQHgID5f
 cmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745425061; x=1746029861;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k3RnWfoSGPb/dYt2u5wUiUrr41UcOxYQens0St821/I=;
 b=l3HWC+oYUYj5qnKHZHNKu2JFNHnqOGveDLQuHNjnBUyqO9Ks3vPvcmFsvvDS928nee
 tNk9Z8m4KrA8+ILIwlb9Wpe06Vb56zRIRjI6CL0LnK07dtZ37XPYa4wZP8YyotflSUQH
 PUz1D+7TnZJpx3Munw0VB4Lo6dAbNDaRSlLYl7kyA/hYxnpzN7v8rvmTf0pBzA+B8JqH
 LQjFsN+1er3igls4WL+ozwfqzfG4OMn/h9U17b4Lv9Eofxuuf6R5sA/QPs8b3BSC8qrp
 Nb6HTUU+hex1WYW1nsh4obS9nT5EMf4Jd04LfnUyHqEHBGcn2fwmiFYumqxFbIVS2qsp
 3BFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXicg9LoDTHZSymuhnrMqIf1rq/EIJBaOq71dZ4iZtjdDw3mVoTGcptVqWK+uDhaz24z2IWNieYd8q/@nongnu.org
X-Gm-Message-State: AOJu0Yxcn29yx2Rew1SURe8BB7u/nZHr42vw5x2Jrsz+YxK8kQUV6GuH
 t7du3bZzheZJuAZqi3bYKxYtrPzDTiMVAYYlYhyU1sTH9YwE7SR7XrnzCoJXGMQ=
X-Gm-Gg: ASbGncvw6m0rWojcy3KznK01IJG336Uzr5QdZ/4aVaFleL6/aag7p76ejuqxd/hAYrk
 m9KSQpXnpKaZeNUjQpElF+WPyem+/xT5F+8K6vVcFBPbMP95Z9E2G8l6q06bJRjf6J+Lx0tCgfM
 KS+of5J4WhFD9u0pjQBgirErx1Nk9IgsGd/91vA5rm0hH71BB9JV/0/FSWhBS0bt2QbxlrfvkZP
 T9aSHrEFGa6YkskpOuaW5YeYSuq2shukTXZs+YDDsxyPDwsElSzBMINXWnSmRvW2V7wZitctPiq
 ko+fUbbZDFlmoTxHIwtfQ41bz7gwxgQ+rPnwAD6+axvM7BoSfewxMyBXCRY5NBmG4+gjqtf702Q
 0FHgcUvpr
X-Google-Smtp-Source: AGHT+IH7m34g0H+81WGe3eVlX3VhwBhqa8NcD4uUf8JoKqy0+BVkVLG/857yq8uZlG50g6qv5aztsQ==
X-Received: by 2002:a05:600c:1990:b0:43d:4e9:27ff with SMTP id
 5b1f17b1804b1-4406ab679famr159789785e9.7.1745425060825; 
 Wed, 23 Apr 2025 09:17:40 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d3e5f3sm30457585e9.32.2025.04.23.09.17.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 09:17:40 -0700 (PDT)
Message-ID: <e18e1ad1-badb-400c-b9a6-04749c7c324a@linaro.org>
Date: Wed, 23 Apr 2025 18:17:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 105/147] exec/cpu-all: remove tswap include
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-106-richard.henderson@linaro.org>
 <86ba7919-db11-45cd-8bdd-ede8f25f92d2@linaro.org>
 <f3ce25db-36dd-41fb-be98-45db9716634d@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f3ce25db-36dd-41fb-be98-45db9716634d@linaro.org>
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

On 23/4/25 18:09, Pierrick Bouvier wrote:
> On 4/23/25 03:27, Philippe Mathieu-Daudé wrote:
>> On 22/4/25 21:27, Richard Henderson wrote:
>>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> Message-ID: <20250325045915.994760-7-pierrick.bouvier@linaro.org>
>>> ---
>>>    include/exec/cpu-all.h               | 1 -
>>>    target/ppc/mmu-hash64.h              | 2 ++
>>>    target/i386/tcg/system/excp_helper.c | 1 +
>>>    target/i386/xsave_helper.c           | 1 +
>>>    target/riscv/vector_helper.c         | 1 +
>>>    5 files changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
>>> index 957c86886e..bfa039ab76 100644
>>> --- a/include/exec/cpu-all.h
>>> +++ b/include/exec/cpu-all.h
>>> @@ -21,7 +21,6 @@
>>>    #include "exec/cpu-common.h"
>>>    #include "exec/cpu-interrupt.h"
>>> -#include "exec/tswap.h"
>>>    #include "hw/core/cpu.h"
>>>    #include "exec/cpu-defs.h"
>>>    #include "exec/target_page.h"
>>> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
>>> index ae8d4b37ae..b8fb12a970 100644
>>> --- a/target/ppc/mmu-hash64.h
>>> +++ b/target/ppc/mmu-hash64.h
>>> @@ -1,6 +1,8 @@
>>>    #ifndef MMU_HASH64_H
>>>    #define MMU_HASH64_H
>>> +#include "exec/tswap.h"
>>
>> This header doesn't use "exec/tswap.h". Maybe you want this
>> reviewed patch instead:
>>
>> https://lore.kernel.org/qemu-devel/20241211230357.97036-6- 
>> philmd@linaro.org/
>>
>>> +
>>>    #ifndef CONFIG_USER_ONLY
>>>    #ifdef TARGET_PPC64
>>
> 
> See: [PATCH 002/147] exec/tswap: implement {ld,st}.*_p as functions 
> instead of macros.
> It removes macro definitions from cpu-all.h, and implement those as 
> proper functions in exec/tswap.h.
> 
> ppc/mmu-hash64.h uses ld*_p, which are defined in exec/tswap.h, so it's 
> the correct place for this include.

Ah I missed that, OK then.



