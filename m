Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4322CC25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 09:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGyGt-0005Wp-71; Tue, 11 Jun 2024 05:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGyGs-0005WZ-9c
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 05:58:30 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGyGq-0004Rb-Dy
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 05:58:30 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57a44c2ce80so1014195a12.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 02:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718099906; x=1718704706; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fug3CNGR0hwsVQeqGJVFCLG2o/34TQDQqZop558/eo4=;
 b=nxTOsQEpVqNKitBgDbyom+h+CPhlfpRh2Wl/PBYAE1Q6LmmX6J1nczN0PoJmgIA0Ie
 Mqcg0lryhMuZOA5O3Hba0goJCqWYG11gJJgGRF4isG9pCNeXcGMCeBR4MFqQ958YVOB9
 Jq+zusrtMX4R5feU6d6Up24iOkvRdcPP4jWZmZyIaUqDQBeap7DuV5waMe+Py1pn0TCU
 HTFnlRxRyACtyXyfWMO6A9bh0AwJsfq9MUxcsEeSZZN/VtNWCw4wkJiU5alqeow4hmid
 zjZ5KA8R65SR2h5p8N9wD4QGWLRzpJypkEmSGGx05L4kHo0eiPWyL4vZqoY96SRAE0si
 2jgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718099906; x=1718704706;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fug3CNGR0hwsVQeqGJVFCLG2o/34TQDQqZop558/eo4=;
 b=cY5ce9JxI5OFZHRuPtkz3dxgTDQpjRtYkGjP+huG2egawm123aMY2f+ojZBuKA2RLB
 svKSzieT5ZqNKIr0bbJrWjaqBmZ0ftyS37FqvcPoHFVS/V9MfgqnMkKvmermKcS1LsI+
 ZVwM/FsiUA+/s5IsU3QU5gFPO7pAkIlRmYIW92kVtYDcS0n1GK5yL0wM8d8SaQzIG7bY
 0Cf6kY9uNxaaBsSKLliVnzXlwB1LH5aUFWWTdUR3anQCuW95h3asG3sxYqsTHNfwMKSb
 4RKAkiRdyzfRwXglZzcV3cmnfYK9bAgdS+7FkXXaauNU9+cZFxZYRBE3kg+DhiC84489
 8Dsw==
X-Gm-Message-State: AOJu0YwdAM0NSkVMaYK2JH03IlvwsY7S+CY/KzJM91SgYEov/SkEpnl3
 PcMczuW9/ZWxxRrBsnCB5HidsXQMvuP+dQW26a9kyLSx1Mf2cfgNKmuOzj3X/nU=
X-Google-Smtp-Source: AGHT+IGtVWp/ThJM3ppgHPo6Ni/Y+4AjgM00FCYjZrP7RhrGAeDzHhjqsoDT2MiNBYIiU7Cq82qj+Q==
X-Received: by 2002:a50:d6d6:0:b0:57c:70b0:d540 with SMTP id
 4fb4d7f45d1cf-57c70b0d97bmr6033968a12.1.1718099906112; 
 Tue, 11 Jun 2024 02:58:26 -0700 (PDT)
Received: from [192.168.69.100] (rsa59-h02-176-184-32-6.dsl.sta.abo.bbox.fr.
 [176.184.32.6]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57c8053b4fdsm3800601a12.58.2024.06.11.02.58.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jun 2024 02:58:25 -0700 (PDT)
Message-ID: <2cfbd01f-c5c3-44d7-b222-82ce378273d5@linaro.org>
Date: Tue, 11 Jun 2024 11:58:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] accel/tcg: Make TCGCPUOps::cpu_exec_halt mandatory
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20240603160933.1141717-1-peter.maydell@linaro.org>
 <20240603160933.1141717-4-peter.maydell@linaro.org>
 <5b10d49a-8da2-491f-8b8c-26556482957d@linaro.org>
 <CAFEAcA_1JyzM9WiBsQ-3YxNmH3i1usnU3iAc7QR-G2m89f-GbQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_1JyzM9WiBsQ-3YxNmH3i1usnU3iAc7QR-G2m89f-GbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

On 11/6/24 10:36, Peter Maydell wrote:
> On Tue, 11 Jun 2024 at 09:25, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Hi Peter,
>>
>> On 3/6/24 18:09, Peter Maydell wrote:
>>> Now that all targets set TCGCPUOps::cpu_exec_halt, we can make it
>>> mandatory and remove the fallback handling that calls cpu_has_work.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>    include/hw/core/tcg-cpu-ops.h | 9 ++++++---
>>>    accel/tcg/cpu-exec.c          | 7 +------
>>>    2 files changed, 7 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
>>> index 099de3375e3..34318cf0e60 100644
>>> --- a/include/hw/core/tcg-cpu-ops.h
>>> +++ b/include/hw/core/tcg-cpu-ops.h
>>> @@ -122,10 +122,13 @@ struct TCGCPUOps {
>>>         * to do when the CPU is in the halted state.
>>>         *
>>>         * Return true to indicate that the CPU should now leave halt, false
>>> -     * if it should remain in the halted state.
>>> +     * if it should remain in the halted state. (This should generally
>>> +     * be the same value that cpu_has_work() would return.)
>>>         *
>>> -     * If this method is not provided, the default is to do nothing, and
>>> -     * to leave halt if cpu_has_work() returns true.
>>> +     * This method must be provided. If the target does not need to
>>> +     * do anything special for halt, the same function used for its
>>> +     * CPUClass::has_work method can be used here, as they have the
>>> +     * same function signature.
>>>         */
>>>        bool (*cpu_exec_halt)(CPUState *cpu);
>>>        /**
>>> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>>> index 6711b58e0b2..8be4d2a1330 100644
>>> --- a/accel/tcg/cpu-exec.c
>>> +++ b/accel/tcg/cpu-exec.c
>>> @@ -682,13 +682,8 @@ static inline bool cpu_handle_halt(CPUState *cpu)
>>>    #ifndef CONFIG_USER_ONLY
>>>        if (cpu->halted) {
>>>            const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
>>> -        bool leave_halt;
>>> +        bool leave_halt = tcg_ops->cpu_exec_halt(cpu);
>>>
>>> -        if (tcg_ops->cpu_exec_halt) {
>>> -            leave_halt = tcg_ops->cpu_exec_halt(cpu);
>>> -        } else {
>>> -            leave_halt = cpu_has_work(cpu);
>>> -        }
>>>            if (!leave_halt) {
>>>                return true;
>>>            }
>>
>> Could we assert the handler is assigned in tcg_exec_realizefn()?
> 
> Yeah, we could. I thought about an assert that it was set up,
> but couldn't identify a place to do that.
> 
>> If you agree I could squash these 3 lines:
>>
>> -- >8 --
>> --- a/accel/tcg/cpu-exec.c
>> +++ b/accel/tcg/cpu-exec.c
>> @@ -1077,6 +1077,10 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
>>        static bool tcg_target_initialized;
>>
>>        if (!tcg_target_initialized) {
>> +        /* Check mandatory TCGCPUOps handlers */
>> +        assert(cpu->cc->tcg_ops->initialize);
>> +        assert(cpu->cc->tcg_ops->cpu_exec_halt);
>> +
>>            cpu->cc->tcg_ops->initialize();
> 
> I don't think we need to assert initialize if we're about to call
> it anyway -- the call will crash if it's NULL in an easy to diagnose way.

Pro of assert: obvious error message on stderr.

Con of crash: we need to use a debugger to figure out the NULL deref.

Anyway, series queued without the "assert(initialize)" squashed,

Thanks!

>>            tcg_target_initialized = true;
>>        }
>> ---
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> thanks
> -- PMM


