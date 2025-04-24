Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88791C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 20:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u82tP-0004vK-P5; Thu, 24 Apr 2025 16:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u82tM-0004ul-Uy
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:09:53 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u82tL-0003dU-6G
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:09:52 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39c13fa05ebso982818f8f.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 13:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745525389; x=1746130189; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8+rQlfvyCtBXX1W6IWD6rC8OR4JopBwGxSZONYKSWOQ=;
 b=vDEofP9749Z4IZ7Zt969NCkmzqeOTccvTJvE0/d5ntv2WspRlyB8mAPAOzlQ6WCa42
 1OHDD1mdd8LiecsIRO22s/oEXsQz5TfFVZSqkl4IvVIhTAMq2PtPqQFtITQO4IyzUeWf
 gLtfaGMoL52zh6UU1XEDmoPdjYpOYcC7GkEdyLe7+Se8oQInRU7KeQC3oVmdVoM723mf
 WD9F3QZYE2jORVMaYDiIY/ENJmVChsMnWATxyPFofvkNoaKxNt1n9GH2/EzgTikRjksE
 PKLss0R1NEiyOPveIyBEX/fyC4HV4yy2cYUZ+T7Kp0No/7P58xIJRy5NQc98T6QxzWcZ
 TXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745525389; x=1746130189;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8+rQlfvyCtBXX1W6IWD6rC8OR4JopBwGxSZONYKSWOQ=;
 b=HcEOSUQD8P23Toil1h6v9M6gjVCE3H5Ksw98pYI4HRdEHWuLa9FvAKLvtXpHD0uWgg
 p4UHdgP2y8nXnjUJ+TvwsRxe6TPU7Jz+aOn11+o4MrHFgxG21hwGbtqQRCEJKK99CjQx
 XrfpF/GawefoDxEa85WM1QPPEk/42zEdawxjVuatpP93pr+K8ZrQVVIIXMhSE31eOXEB
 oLo76Z14+06F45A/wElvaV5YKtYni9baywOLl94o3BtvwhdhdKR/EpLJ+xD+5BjmS4rf
 AW4qUuFQCsL64AubnszgUF/xZh0lehFQq46sNkaSaSbVXK5ZYm+XWlOZizlZUgcYz1/A
 lB/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpZyBlOfYsstdBltnRzHUZZwcEnoD/O6tzOqER1nlgm2uwvRy6pNj6EXmzNulhiNYQMWTvbamKWppG@nongnu.org
X-Gm-Message-State: AOJu0YxAW695Mb3mY5xuiVlTUcycaz3V9q8fxE/50nD530ATYZHj3F9A
 GtPAgdvXHW07w4gWQPfZiIKAp85VEbTUL66pqMKN3GPCXwAzYH+hCFEaoY2RFyg=
X-Gm-Gg: ASbGnct8SiBQkosi7u+iiz+NPJmMnHBb+BuysCLwAhIjxrpKZXIzDgz2OdF3m9ONFjf
 MpeqHiaeCid7xEnl/haMcS+l5xPXHPUFjv52ldqH+/BZin/x26JBaM4kbSaKxrCuJflEXVNxd0Q
 0FLOjqcjTSg7IX7zelk9c7GIltYJVk63Fek+wBah/koVbaiHha4N9BjAeCY/6xTKP8OIopZLn9a
 zjk22jATc+3NsLT5FK51vWs2q6g5d+5/7btQtPv4xJ1ZVWmOHS5hQb91vdBXAncR9Nv/b5ny9Yw
 C2ytYVgX6eBv9Szl2YSNH2myk6LuKZ5ohIRvdL+kHepttZzmUOYMQyVoH/t3MwNyNT4EmqwTf65
 yDIYoohno
X-Google-Smtp-Source: AGHT+IGqVn8fF/JkTOfyXjK88uCjfmmOJA3NCp7N5SLeHhIFsn/XXOknKQDr/kalzO25vYp4un6bHQ==
X-Received: by 2002:a5d:5846:0:b0:391:4674:b10f with SMTP id
 ffacd0b85a97d-3a072b6072dmr528074f8f.36.1745525389091; 
 Thu, 24 Apr 2025 13:09:49 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073cc199fsm260510f8f.55.2025.04.24.13.09.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 13:09:48 -0700 (PDT)
Message-ID: <8f01607b-289b-4187-b383-f79972aca7ce@linaro.org>
Date: Thu, 24 Apr 2025 22:09:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/13] accel/tcg: Include 'accel/tcg/getpc.h' in
 'exec/helper-proto'
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250424094653.35932-1-philmd@linaro.org>
 <20250424094653.35932-10-philmd@linaro.org>
 <d05a791e-c520-44c7-8bd6-c1159a759710@nutanix.com>
 <36df6d73-951f-45e0-b8cc-c79c675d1636@linaro.org>
Content-Language: en-US
In-Reply-To: <36df6d73-951f-45e0-b8cc-c79c675d1636@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 24/4/25 13:23, Philippe Mathieu-Daudé wrote:
> On 24/4/25 12:21, Mark Cave-Ayland wrote:
>> On 24/04/2025 10:46, Philippe Mathieu-Daudé wrote:
>>
>>> Most files including "exec/helper-proto.h" call GETPC().
>>> Include it there (in the common part) instead of the
>>> unspecific "exec/exec-all.h" header.
>>
>> Aha!
>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   include/exec/exec-all.h            | 1 -
>>>   include/exec/helper-proto-common.h | 2 ++
>>>   accel/tcg/translate-all.c          | 1 +
>>>   3 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
>>> index 4c5ad98c6a9..816274bf905 100644
>>> --- a/include/exec/exec-all.h
>>> +++ b/include/exec/exec-all.h
>>> @@ -26,7 +26,6 @@
>>>   #include "exec/vaddr.h"
>>>   #if defined(CONFIG_TCG)
>>> -#include "accel/tcg/getpc.h"
>>>   /**
>>>    * probe_access:
>>> diff --git a/include/exec/helper-proto-common.h b/include/exec/ 
>>> helper- proto-common.h
>>> index 16782ef46c8..76e6c25becb 100644
>>> --- a/include/exec/helper-proto-common.h
>>> +++ b/include/exec/helper-proto-common.h
>>> @@ -13,4 +13,6 @@
>>>   #include "exec/helper-proto.h.inc"
>>>   #undef  HELPER_H
>>> +#include "accel/tcg/getpc.h"
>>> +
>>>   #endif /* HELPER_PROTO_COMMON_H */
>>> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
>>> index 38819a507b2..0408e2522a8 100644
>>> --- a/accel/tcg/translate-all.c
>>> +++ b/accel/tcg/translate-all.c
>>> @@ -61,6 +61,7 @@
>>>   #include "system/tcg.h"
>>>   #include "qapi/error.h"
>>>   #include "accel/tcg/cpu-ops.h"
>>> +#include "accel/tcg/getpc.h"
>>>   #include "tb-jmp-cache.h"
>>>   #include "tb-hash.h"
>>>   #include "tb-context.h"
>>
>> Moving accel/tcg/getpc.h to a more commonly used TCG header seems like 
>> the right idea, but then shouldn't that mean the direct includes from 
>> targets added in the previous commits can now be removed?

The files from the previous patch don't include "exec/helper-proto*.h".

> $ git grep -l exec/helper-proto $(git grep -l accel/tcg/getpc.h)
> accel/tcg/tcg-runtime.c
> target/avr/helper.c
> 
> OK, I'll remove it from these 2 files.


