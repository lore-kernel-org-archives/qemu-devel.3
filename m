Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FCCCE8E99
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 17:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t41QA-0004DX-NJ; Thu, 24 Oct 2024 13:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t41Q5-0004CV-0a
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 13:14:45 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t41Q2-0005Ob-U2
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 13:14:44 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20c803787abso9305935ad.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 10:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729790080; x=1730394880; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tky+sTpkoJN3pdSFdzjbo8/+js9TuxRW/ISLfU9UxEk=;
 b=BXWtF/DuN81jHzqefEUhWuAJxd96vel+32LgAf6U+NvGff7Cm0bm//YyU5m3t5p0R5
 BpO3G3DlnS51sgpM/G6Wtpf9i/oDKIzVWqreK8Izsjoia0+pcHTRVobP3RHvVRF6ToDZ
 YcYD+EGISpyeDqBza/7Q6Zhb8jDK5M+G0kEKaC7O+PJPzt+7eKxNe0wM3D3IombhWb75
 /i/TiYA0gaJP1kQjGoxLrZ0cNK1C7HAele55NE9H4dsi9F20oKiI08LyeP8QtIYfjAIM
 lBYO1XbqCzDs3AaaE6ru4OqF8mlgvY/rUKMmmLDCYUwwrjNkZXXVUO3NFJHzUSsxHEKs
 7KLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729790080; x=1730394880;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tky+sTpkoJN3pdSFdzjbo8/+js9TuxRW/ISLfU9UxEk=;
 b=IMJHrArUrQGIGv3rUi/XE6Q2SLN/jEgkyAvQKqm4Se16g22dxKDIn9xInjsQypz4er
 4TKI84/PfRYfdLc3Lt/mdUJepp2h+OOl8cWRnItQMzsvxo+Goiy0EqZerEqCkR9yU19e
 L4igjYRHvj5aBf2GJGw7JBpRK0vaKAbsW8cok8Sys+TtwnIXoV5/ppJS7RKGwRHTy+pj
 dVPfQ7vjNTsxdty4LMYXxPYR8A/ZcoRjZq0sBVum2l1u8nYjcwiT2gbmFEnyf4HXY9Qe
 ji4/ELA7F+7joDpvZ8RMob0m8Nt4lo6E9RgRu1oXaPLH25q00J3Aeqy8IDZtNcy7WPl9
 aHzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXA/XtmeJyE7A4gM8HrDSgdymqFilYbgYXl62SMCb04eiKSnNRSnLR3Yyi2zsmHOEpvFPYLidNWm/e3@nongnu.org
X-Gm-Message-State: AOJu0Yyv9gLIaqkVL0QsM5RBQ/gj21zl4OtSM7XBU6ntq4BLQwvwSozy
 Pfnuec0ZcN4OaIKGkpIBSIfvpPLAdKBPJ4yeKT9fe8NeHMxo1/ZrIqPp0MWoDVuiCsIPpqAVJ+V
 uSdnMM1B4
X-Google-Smtp-Source: AGHT+IEQ97Nqp92Fw+WrPrzLv+wrAwX97fQ0+jBIr8yrYQgFNa+EUYiksuBNIYdou5IJ1XtyYqyRCA==
X-Received: by 2002:a17:902:cecd:b0:20c:c18f:c39e with SMTP id
 d9443c01a7336-20fb89d6ad7mr43556935ad.21.1729790079887; 
 Thu, 24 Oct 2024 10:14:39 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0f6d10sm74773795ad.279.2024.10.24.10.14.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2024 10:14:39 -0700 (PDT)
Message-ID: <849abe8a-9fae-490f-8fef-b3623ae6408b@linaro.org>
Date: Thu, 24 Oct 2024 10:14:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/i386: fix hang when using slow path for
 ptw_setl
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>
References: <20241023222026.1430014-1-pierrick.bouvier@linaro.org>
 <20241023222026.1430014-2-pierrick.bouvier@linaro.org>
 <66320518-0270-4426-8daf-9be3ae7bfce7@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <66320518-0270-4426-8daf-9be3ae7bfce7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 10/24/24 09:25, Richard Henderson wrote:
> On 10/23/24 23:20, Pierrick Bouvier wrote:
>> When instrumenting memory accesses for plugin, we force memory accesses
>> to use the slow path for mmu. [1]
>> This create a situation where we end up calling ptw_setl_slow.
>>
>> Since this function gets called during a cpu_exec, start_exclusive then
>> hangs. This exclusive section was introduced initially for security
>> reasons [2].
>>
>> I suspect this code path was never triggered, because ptw_setl_slow
>> would always be called transitively from cpu_exec, resulting in a hang.
>>
>> [1] https://gitlab.com/qemu-project/qemu/-/commit/6d03226b42247b68ab2f0b3663e0f624335a4055
>> [2] https://gitlab.com/qemu-project/qemu/-/issues/279
>>
>> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2566
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Oh, wow.  I believe this will be fixed by
> 
> https://lore.kernel.org/qemu-devel/20241023033432.1353830-19-richard.henderson@linaro.org/
> 
> which is in a pending PR.
> 

It might the issue by not triggering the situation we observed.
However, we still have a hidden dead code path where start_exclusive is 
called from cpu_exec, not being related to the plugins.

> 
> r~
> 
> 
>> ---
>>    target/i386/tcg/sysemu/excp_helper.c | 4 ++++
>>    1 file changed, 4 insertions(+)
>>
>> diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
>> index 8fb05b1f531..f30102b5362 100644
>> --- a/target/i386/tcg/sysemu/excp_helper.c
>> +++ b/target/i386/tcg/sysemu/excp_helper.c
>> @@ -108,6 +108,9 @@ static bool ptw_setl_slow(const PTETranslate *in, uint32_t old, uint32_t new)
>>    {
>>        uint32_t cmp;
>>    
>> +    /* We are in cpu_exec, and start_exclusive can't be called directly.*/
>> +    g_assert(current_cpu && current_cpu->running);
>> +    cpu_exec_end(current_cpu);
>>        /* Does x86 really perform a rmw cycle on mmio for ptw? */
>>        start_exclusive();
>>        cmp = cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, 0);
>> @@ -115,6 +118,7 @@ static bool ptw_setl_slow(const PTETranslate *in, uint32_t old, uint32_t new)
>>            cpu_stl_mmuidx_ra(in->env, in->gaddr, new, in->ptw_idx, 0);
>>        }
>>        end_exclusive();
>> +    cpu_exec_start(current_cpu);
>>        return cmp == old;
>>    }
>>    
> 

