Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D77C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 07:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmqCn-0003Lf-OV; Wed, 20 Mar 2024 03:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmqCl-0003LU-Bp
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:17:43 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmqCi-0000fl-QY
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:17:43 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4146bcff793so2792315e9.3
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 00:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710919058; x=1711523858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LWAYh2T5XYbZ/9cqinlrmi89DO1EQKNUZJ4eIIso0LA=;
 b=u5zCRkY4LocclyzjnRQE22jhHzp0IdJX/aLwiCjdT45ouCAkMy8ImuBVKiarMB9WWz
 ZDVRpIHSwdS+bLcUB1xBCRCuV9AnYFr1c8GXLGgovumU6whjOeiVDnl2kEhqU70oQNYR
 irXl6WtbfZCHlFo2/YTwPQ760J+gb2uWi71NlVN879wlS4bISMw4AOIVxk0DVTTbOj1G
 bd5VFqEcvr6B9z+qNgZ0WrLs4YK/B2T3miAe3QKxXH8/NvYpvVVqaAqAitZCqme2+QDr
 Yogklez2LGhFCJaOqM9c5uhzfDvJBjAYFuNLtyQ3BGEX2NdUfnb7v2DWrCQ7ENoHA8pQ
 JOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710919058; x=1711523858;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LWAYh2T5XYbZ/9cqinlrmi89DO1EQKNUZJ4eIIso0LA=;
 b=epamPJMds5Nr1n9pW/3RhThmkMEhXtzOGBacKFSYI5q8Of/vmm+OrM84w7xxTXFIbT
 BOQIVTT5Y409zllp5On327qwbfirgNMfXLpZBbjxVCQHV3WIdfYi2u4XHON+S81TOlf7
 5Rai2Mwau9dFHMTeUNiIq5ufYNIB2V3Ngg45aJBeEMwma7c/sEzEUm6oDLquwDo9Id/Q
 A/FrF/5O7GAegu4MSS66HTi6M3SP08vUOYetZMDQm37foDp9rzL4XVchycKTrEpXvpEW
 Vn61QNcWAtWjIhBcZLFoqElf9GjsnyvyL0mNTL/PL3nrppxVZjrHvCWmMLKBBc4NLUxz
 g0NQ==
X-Gm-Message-State: AOJu0YzhiSsPjDEUF6Ui/08XK/uI6o+dxVHzQ05MwuOoalaiAzVMbmzD
 r79i2LVN+WMLb/BGKQi7tfhw8aku+7AuoFmyuwBM/7zYeegqiTvOGEjKUFc3NRA=
X-Google-Smtp-Source: AGHT+IHjLNox3iuUTx+z6ll0U/VljQ6wo42JTIb3a5UX36qZY/tcTsvHjArrkgDTqpkconP+jxpfbg==
X-Received: by 2002:a05:600c:524f:b0:414:6c34:a411 with SMTP id
 fc15-20020a05600c524f00b004146c34a411mr517308wmb.24.1710919058152; 
 Wed, 20 Mar 2024 00:17:38 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.156.105])
 by smtp.gmail.com with ESMTPSA id
 jh2-20020a05600ca08200b00413e63bb140sm1220747wmb.41.2024.03.20.00.17.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 00:17:37 -0700 (PDT)
Message-ID: <740bcdb9-4a5e-4510-a0b4-0121608f5ab3@linaro.org>
Date: Wed, 20 Mar 2024 08:17:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Check NULL monitor pointer when injecting MCE
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xiaoyao.li@intel.com,
 alex.bennee@linaro.org
References: <20240320052118.520378-1-tao1.su@linux.intel.com>
 <87le6dwid5.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87le6dwid5.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Hi Tao,

On 20/3/24 07:02, Markus Armbruster wrote:
> Tao Su <tao1.su@linux.intel.com> writes:
> 
>> monitor_puts() doesn't check the monitor pointer, but do_inject_x86_mce()
>> may have a parameter with NULL monitor pointer. Check the monitor pointer
>> before calling monitor_puts().
>>
>> Fixes: bf0c50d4aa85 (monitor: expose monitor_puts to rest of code)
>> Reviwed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Signed-off-by: Tao Su <tao1.su@linux.intel.com>
>> ---
>>   target/i386/helper.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/i386/helper.c b/target/i386/helper.c
>> index 2070dd0dda..a9ff830a17 100644
>> --- a/target/i386/helper.c
>> +++ b/target/i386/helper.c
>> @@ -430,7 +430,8 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
>>           if (need_reset) {
>>               emit_guest_memory_failure(MEMORY_FAILURE_ACTION_RESET, ar,
>>                                         recursive);
>> -            monitor_puts(params->mon, msg);
>> +            if (params->mon)

Missing braces, see QEMU coding style:
https://www.qemu.org/docs/master/devel/style.html#block-structure

>> +                monitor_puts(params->mon, msg);
>>               qemu_log_mask(CPU_LOG_RESET, "%s\n", msg);
>>               qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>>               return;
> 
> Could instead revert the broken part of commit bf0c50d4aa85:
> 
>    -            monitor_puts(params->mon, msg);
>    +            monitor_printf(params->mon, "%s", msg);
>                 qemu_log_mask(CPU_LOG_RESET, "%s\n", msg);
> 
> Then the fact that we send the same message to monitor and log is again
> more obvious.
> 
> Either way:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 
> 


