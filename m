Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326F6C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 11:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ufi-00054W-TP; Thu, 24 Apr 2025 07:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7uff-000543-MP
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 07:23:13 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7ufd-0004Or-Mg
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 07:23:11 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so8646585e9.2
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 04:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745493788; x=1746098588; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fqGa3bUTGo8SGSuM2fStYDeV97EXAvl6QmUg/Q181kQ=;
 b=lJddkqZXz7agykPexsxlnVWobusmFHAjg8zl3mobC9bhj0zybv3vU9wQE94AAbenmX
 hzoaosOa2m0rXilNV72nYxaF2yP2CbkJoEHjV7RcMeTG1KICkD8HsL2iaPcz9HMK71qN
 YTQZXXLP8eH5gTeb3cyeuWzV2/C3zV/AFHGoqBdu092OiOmG3wgGGthkja/6q4ckfjeg
 US47GLx8TKr/6K4QyY6FEOL2f22srv0f4lwhJF0r7rCRrZdJUig8hr4EVdGGBqyvDG+f
 o6Z8bG9OGYe5Lt+nWtI2KPTLMyfpr+DvalmZUv5STjFQDks8D8LgQ6zqfrMQPxCxkmyV
 j36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745493788; x=1746098588;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fqGa3bUTGo8SGSuM2fStYDeV97EXAvl6QmUg/Q181kQ=;
 b=ka76DDeetwMcZgQsB44JuU7ZwiUCCZ+iXWhfdKJy2xHpZ53nwz5J/Jr9mx1CLDvBSl
 x3AIAAo2RjalxnQfEb1ejTHoELQheXg8SV4IIP/nsI5wP6PI3CUM4jHyooOJs0Wu/Osp
 XmX0fEy02R/gts3M/TYTZX+CW2C55xOyWFdO9kc0OYWcVbJgjr9UF13iB5i1S73kfw2X
 ix+hnlkxjf6yL0RgyN2bIQ1OkGv9a+hkz5eaH8EqNHBThIcP2rv1CBQM0/YerA1G+Xcd
 wA6sMPWRtKnMtRWZKaUiovDqdKEQ8WD3GOC757S7veDHdzn9CrIjdFQeJwL4aFuPN868
 ePVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVGeIcxfIXOKLci5UKjr3VRnsdsRDTB8SNXBWRTwK0peac6YgiIuGFkPFji/ffmjBqNoaMZK87rz0w@nongnu.org
X-Gm-Message-State: AOJu0YyZf6sSZ+38lPQYASGnohWTU1r+aK3h6/yrpDwmwvdd3OiOYloF
 9U34/+dZ/zM6t7xUkR5ZBVYFWmkUHFVp5GKPz7er4uYWiEaE0fPLzCpwzGjHxak=
X-Gm-Gg: ASbGncshjx2SJ968QkBG8aI8ZA7zWKl/VZWcpdAIaVi3YQ23KH/GN6HhEcgFxRTgvmM
 NmvLPsj85GJcs1pF8eveNalp4xvhLfMVcVVifUj5L83mTNi/DBiacNqUuO+hyl2+zVxylSwzH/A
 /vvXC+3eL5liPMdjZ4Eu+9Vdw7Cq8Bz2rNI3SKSCgHoP8FbXw6456w+P7hLa5H/5ngjWQRjH8XR
 3jSj3H4f6RPcoGpHxKBq/F/JL/B5uwaHcHZ6PhMejaP6hI1aLF+macZ4bHUoPya25YVW5riT3+H
 Ig/UdplbtrxgtEu/mRyH6Ue+JxHWqSykjRW9SSuCfUszRb3hmDvsc0koGQx5H5NQ5v/kaIfyAdw
 EE4AjnfyX8oTckQ==
X-Google-Smtp-Source: AGHT+IGejGY3q8yn8HBX1bSPBsfDYwEb/Vjy3U1k+mwwnoHK1B3PwipDndiPtqJpzhkoFPzdW08Iuw==
X-Received: by 2002:a05:600c:5489:b0:43c:ea1a:720c with SMTP id
 5b1f17b1804b1-4409bd2f1c5mr19971825e9.18.1745493787810; 
 Thu, 24 Apr 2025 04:23:07 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d4a815bsm1765502f8f.8.2025.04.24.04.23.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 04:23:07 -0700 (PDT)
Message-ID: <36df6d73-951f-45e0-b8cc-c79c675d1636@linaro.org>
Date: Thu, 24 Apr 2025 13:23:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/13] accel/tcg: Include 'accel/tcg/getpc.h' in
 'exec/helper-proto'
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250424094653.35932-1-philmd@linaro.org>
 <20250424094653.35932-10-philmd@linaro.org>
 <d05a791e-c520-44c7-8bd6-c1159a759710@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d05a791e-c520-44c7-8bd6-c1159a759710@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 24/4/25 12:21, Mark Cave-Ayland wrote:
> On 24/04/2025 10:46, Philippe Mathieu-Daudé wrote:
> 
>> Most files including "exec/helper-proto.h" call GETPC().
>> Include it there (in the common part) instead of the
>> unspecific "exec/exec-all.h" header.
> 
> Aha!
> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/exec/exec-all.h            | 1 -
>>   include/exec/helper-proto-common.h | 2 ++
>>   accel/tcg/translate-all.c          | 1 +
>>   3 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
>> index 4c5ad98c6a9..816274bf905 100644
>> --- a/include/exec/exec-all.h
>> +++ b/include/exec/exec-all.h
>> @@ -26,7 +26,6 @@
>>   #include "exec/vaddr.h"
>>   #if defined(CONFIG_TCG)
>> -#include "accel/tcg/getpc.h"
>>   /**
>>    * probe_access:
>> diff --git a/include/exec/helper-proto-common.h b/include/exec/helper- 
>> proto-common.h
>> index 16782ef46c8..76e6c25becb 100644
>> --- a/include/exec/helper-proto-common.h
>> +++ b/include/exec/helper-proto-common.h
>> @@ -13,4 +13,6 @@
>>   #include "exec/helper-proto.h.inc"
>>   #undef  HELPER_H
>> +#include "accel/tcg/getpc.h"
>> +
>>   #endif /* HELPER_PROTO_COMMON_H */
>> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
>> index 38819a507b2..0408e2522a8 100644
>> --- a/accel/tcg/translate-all.c
>> +++ b/accel/tcg/translate-all.c
>> @@ -61,6 +61,7 @@
>>   #include "system/tcg.h"
>>   #include "qapi/error.h"
>>   #include "accel/tcg/cpu-ops.h"
>> +#include "accel/tcg/getpc.h"
>>   #include "tb-jmp-cache.h"
>>   #include "tb-hash.h"
>>   #include "tb-context.h"
> 
> Moving accel/tcg/getpc.h to a more commonly used TCG header seems like 
> the right idea, but then shouldn't that mean the direct includes from 
> targets added in the previous commits can now be removed?

$ git grep -l exec/helper-proto $(git grep -l accel/tcg/getpc.h)
accel/tcg/tcg-runtime.c
target/avr/helper.c

OK, I'll remove it from these 2 files.

