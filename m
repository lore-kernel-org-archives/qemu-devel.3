Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF6FD743D0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 20:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDrEO-0000tt-Pw; Wed, 20 Nov 2024 15:23:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tDrEN-0000tG-SL
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 15:23:20 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tDrEM-0001L6-7d
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 15:23:19 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3e5fee32e76so125795b6e.1
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 12:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732134196; x=1732738996; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PJVpnL/GBM2xfRHobrnDpYnXLaUtAZZQEvafp4O8CKY=;
 b=Rjm+zc3kbr7w8aON7BC9X1ENYeCFSCFm7J0QWPR/pH3qucQnKDfkmF0WAETkVMrtDl
 Hqa/pby8jj6h/SJsvbGIao0BbTzK+Z5J8i+2V60CPr5uxCSndksC9PmmsWUMEbjfy/8f
 yUinA/RKmU8YGZ5vPCbJR/Mg/wDCQJufTGxlnE2aSQ86aMgv9+fv7V1FXG0YuViV/bqC
 tgrIwVS2BDAFs2svDumt8Irkd0REnG7SavK+NhemN45WI4HWAHrynq1rmA1zxvqLjKwY
 ACHx6W6PqHJxg1qmQ6GZzPT72f8UZLbH3oElxDhyTgGIqgIZlNQ9gEvq2Pbo/y3aIXWe
 KGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732134196; x=1732738996;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PJVpnL/GBM2xfRHobrnDpYnXLaUtAZZQEvafp4O8CKY=;
 b=LtURt5nl3rhm0dDXZSWnKOkY7/jVMJVS+9YglxIWFwZNdNub0owBY7yReLoYx/9NNn
 yc3Aah7E+dyJrLMJfHx2jZ4Mv1ubredlCosCpV1RDHNer2sw7YoYIhOmZM/2cbUiKMTF
 NGPx8qTHAR0PaA3a1MsC1peRvOJXO4oBuH/LdqvDa26cR7dEm7P/GgVzcdRgNJK4VwAx
 EgT4tDHkIJu5X4JkTQWujiwGcQeXQQwyy3gS4nUspy0fasT+7x+SWce+nEAI5Z7m+IkO
 LMMZMl2CpBZlzqWly+QRsAfBOXCTrLLG/u9I+3aZpa7vvNFwi9nxvF5FUjqHc07VJ66s
 FNbg==
X-Gm-Message-State: AOJu0Yy6zfeY05x2gzTSYv44Is0wAw5LRDUF/lpiGJ7Yuufy292U7Mv7
 X4BRqldSFwMapiuXPN8g/4DA3/21z9h8kWK6GkqHDL1vjfB1D1W+3bO+C5PviHoRSpXrQ5HMSAD
 UCGMT9g==
X-Gm-Gg: ASbGncuBPsxBRWh23gAammQ0GnRdWP2Hgl76f/DCQM9rP2DdUx48u7aFvpKcb+NemDb
 1Y03lILpATurZptTrwp0/DteFPFYiGACejHmm66WAlcTCPMe5BuZFQtSdXmg9EIyLZ0iF2Ph7nV
 tXoM7nmWRSiBTyroLg0QUUGyBrmE9dDeg11WgRv2WJgEYDR+i6Gshi7VmROPKkSDHLABQ0N+9Zy
 CXLVNO8iFiTlJTnqqFZm48GqpDU3lh6rTKKL/cW68VwwNAVCqcsdlrq9ysvSljlzw==
X-Google-Smtp-Source: AGHT+IGGxsX4ZbZeNAGpQnvOpHA7ATa1IzYJFU3ZdhXI4CIByIcg/7fjJVYxM7vvoRaIwZael+mPUw==
X-Received: by 2002:a05:6808:bd6:b0:3e3:c061:da13 with SMTP id
 5614622812f47-3e7eb7a733bmr4014708b6e.26.1732134196015; 
 Wed, 20 Nov 2024 12:23:16 -0800 (PST)
Received: from [10.25.2.133] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e7ed3fafc8sm409777b6e.16.2024.11.20.12.23.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2024 12:23:15 -0800 (PST)
Message-ID: <29aaad6a-97da-4765-950b-cf28bf168459@linaro.org>
Date: Wed, 20 Nov 2024 14:23:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/strace: show TID instead of PID
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20241024-strace-v1-1-56c4161431cd@gmx.net>
 <10610014-c6d6-4d39-9df1-f66a0900c754@linaro.org>
 <8b333c03-2794-40d8-a698-b983c5466d1e@linaro.org>
Content-Language: en-US
In-Reply-To: <8b333c03-2794-40d8-a698-b983c5466d1e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

On 11/11/24 09:02, Richard Henderson wrote:
> On 11/11/24 06:59, Richard Henderson wrote:
>> On 10/23/24 16:47, J. Neuschäfer wrote:
>>> This aligns with strace, and is very useful when tracing multi-threaded
>>> programs. The result is the same in single-threaded programs.
>>
>> See also "-D log.%d -d tid -strace" which will split the output into per-tid files.
>>
>>>
>>> gettid() requires the _GNU_SOURCE feature test macro, so it might be
>>> unavailable in rare cases. I don't expect it to be a problem though,
>>> because it's implemented by both glibc and musl.
>>>
>>> Signed-off-by: J. Neuschäfer <j.neuschaefer@gmx.net>
>>> ---
>>>   linux-user/strace.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/linux-user/strace.c b/linux-user/strace.c
>>> index 
>>> c3eb3a2706a93fdcaf693b3413b13921a3c97e8e..93e8c73de8a4a307e6e0df5555bee4c769e41e64 100644
>>> --- a/linux-user/strace.c
>>> +++ b/linux-user/strace.c
>>> @@ -4337,7 +4337,7 @@ print_syscall(CPUArchState *cpu_env, int num,
>>>       if (!f) {
>>>           return;
>>>       }
>>> -    fprintf(f, "%d ", getpid());
>>> +    fprintf(f, "%d ", gettid());
>>
>> Probably better as qemu_get_thread_id(), but otherwise
> 
> Or, without the syscall,
> 
>    get_task_state(env_cpu(env))->ts_tid

Queued with this change.


r~

