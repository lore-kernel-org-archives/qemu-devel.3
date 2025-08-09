Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BF8C87FCF
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 23:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uksoQ-0007DV-DW; Sat, 09 Aug 2025 19:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uksoB-0007CS-SE
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 19:17:05 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uksoA-0002oq-12
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 19:17:03 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4b0619a353dso25064241cf.3
 for <qemu-devel@nongnu.org>; Sat, 09 Aug 2025 16:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754781420; x=1755386220; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7PACCWhhqfiRGdYyqWmDSy3Drgy8yZiHJvw2YlzwVuk=;
 b=bGY0+DjEhx0fXZ2RPN3cKAkxLlkGhEOeN7GehEWm1n8HJuA5YcuNQyNm0NRe3gwNUm
 lLt251/iu78vBhAagZ67R2LTSqbfApTCxVdgcG6KmLJDT7Ze7N/MgReCt/C2Lcn4AtR9
 WxsyEVnjn48hGHtMF4P5A8t90TrAcF5IiYMHX7vmTdbi27AaCQgGywHsYLrBzFxNN3bP
 wVsscv1y2O8pRFJxe8ubzd+Z4MqYdSzp/tae4heNPrNzcqJmumlMhQaSLFkjj0hE8AsH
 oq6T5rcVdjZPb7JJpdMZzUyp55jy7cPxwXrUfpPTbnZgYALU29jAWCBLhP3Lt19shIep
 EIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754781420; x=1755386220;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7PACCWhhqfiRGdYyqWmDSy3Drgy8yZiHJvw2YlzwVuk=;
 b=oiti6Lb7IUT4HZ3q64Bgsc76ET1oHQkGPBx61LpV2OfjtmgRQVQikBCnAEi5pBtSvB
 ksTHGjGXSZJHZ9Mm2yEL4z1I1rHD22Zq+V7jcjqlK2HyGNkXJAMqAj5w1o6SRf6LGeYO
 JKRV/g65c0w/3TFsofhSV1kDgts+OgThFuyF0HwPMXNt9j5HMoniALYskN7zC9lkH4wv
 RaCfj3ebgph8/7olQm5wQbiU0qsFcVermG4dI1LReuuPRFWaJqvn/7gtKfMiiGXLiBhA
 7mS6gsD+I+z85U1nkE3sYMM8q5W4l7puYyZUtOO3airn2JukkFvlsGX7e7uHxQkFeTWC
 WCTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJaGreTVD9hQFbM6kKeIW9d8Cuzqa04o3zHxiMy9fX/4qqAqi3F/IAL0oXIPvaLqVobZ14tnwPc08K@nongnu.org
X-Gm-Message-State: AOJu0Yx7XgSFF2GGTxPHQXuJ3FU6bHs8c5sOt6EwKvngwDd5ySs/Fmd1
 Wx+0LF+NI3oY4n90LGgrIsqcpZHSlaBL2sJ4BZ0/0Xh2ABjufCjfk3KpANl5Y2ESn/4=
X-Gm-Gg: ASbGncsYfIhguvMANuBTLZ89jmew2DL6OL+Xknm40qEnaV73nrF5LYcKtPX31mLsBfT
 OW5azatLVvrxX4Lkxeg9d7O26EHkkkk76BwjO8Iynb9ekS8jL3mSIt0eiM+kus2AinlpjrFbh1H
 6JbGtrjRMQ8dyfe21esKMPsaZzSs2mpAViPcvvb0vih8QYIWSH1XOJdhwkml0lA/pf31jPzRjUE
 kuq4uoMNIFAHGvliDK4nPAaSeYm8khDUdrQ6bjnlofrH7bVm0MLzVBMXhgzOaqwY22ROK52o3bW
 TmkPcjz9LcsID6ol1xj0zgsxa5IQVKAL4xuW/1PlNoexj0tU3ba/8UXepARsaMqU1A+3k4rT5ed
 4RrY/XO0wId1L+KnLx2R/mJQl8rJdEGM+aAlXf1Z8FRMX+focT00O7nbvlaodttK6t0Cd5t5bBl
 XVJpoZeU7BR68dmHGK
X-Google-Smtp-Source: AGHT+IF9dkmx9+z2ExyuML08Nn1N1zpmD1b3qGlonbpac3+HFD1SZv7c4vHjM7z31xndZ219TYbVFg==
X-Received: by 2002:ac8:584c:0:b0:4ab:41a2:b980 with SMTP id
 d75a77b69052e-4b0aedd7480mr112878781cf.33.1754781419509; 
 Sat, 09 Aug 2025 16:16:59 -0700 (PDT)
Received: from [10.153.194.227] ([172.58.166.125])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b093596ff5sm50699181cf.30.2025.08.09.16.16.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Aug 2025 16:16:59 -0700 (PDT)
Message-ID: <23517f70-dd7b-487f-9fb2-75356779fe72@linaro.org>
Date: Sun, 10 Aug 2025 09:16:47 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] accel/tcg: introduce tcg_kick_vcpu_thread
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, peterx@redhat.com
References: <20250808185905.62776-1-pbonzini@redhat.com>
 <20250808185905.62776-5-pbonzini@redhat.com>
 <6a3b97ad-63c4-4b29-98e6-fba98eba33c4@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <6a3b97ad-63c4-4b29-98e6-fba98eba33c4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/9/25 07:15, Philippe Mathieu-Daudé wrote:
> On 8/8/25 20:59, Paolo Bonzini wrote:
>> qemu_cpu_kick() does not always have to set cpu->exit_request,
>> though it does for now.  Introduce a function tcg_kick_vcpu_thread()
>> which can be changed in the future to not set cpu->exit_request,
>> and reserve cpu_exit() for when *all accelerators* need to set
>> that flag.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   docs/devel/tcg-icount.rst       |  2 +-
>>   accel/tcg/tcg-accel-ops-mttcg.h |  3 ---
>>   include/exec/cpu-common.h       |  1 +
>>   accel/tcg/cpu-exec.c            | 17 ++++++++++++++++-
>>   accel/tcg/tcg-accel-ops-mttcg.c |  5 -----
>>   accel/tcg/tcg-accel-ops-rr.c    |  2 +-
>>   accel/tcg/tcg-accel-ops.c       |  2 +-
>>   bsd-user/main.c                 |  2 +-
>>   linux-user/main.c               |  2 +-
>>   9 files changed, 22 insertions(+), 14 deletions(-)
>>
>> diff --git a/docs/devel/tcg-icount.rst b/docs/devel/tcg-icount.rst
>> index 7df883446a7..a1dcd79e0fd 100644
>> --- a/docs/devel/tcg-icount.rst
>> +++ b/docs/devel/tcg-icount.rst
>> @@ -37,7 +37,7 @@ translator starts by allocating a budget of instructions to be
>>   executed. The budget of instructions is limited by how long it will be
>>   until the next timer will expire. We store this budget as part of a
>>   vCPU icount_decr field which shared with the machinery for handling
>> -cpu_exit(). The whole field is checked at the start of every
>> +qemu_cpu_kick(). The whole field is checked at the start of every
>>   translated block and will cause a return to the outer loop to deal
>>   with whatever caused the exit.
>> diff --git a/accel/tcg/tcg-accel-ops-mttcg.h b/accel/tcg/tcg-accel-ops-mttcg.h
>> index 8ffa7a9a9fe..5c145cc8595 100644
>> --- a/accel/tcg/tcg-accel-ops-mttcg.h
>> +++ b/accel/tcg/tcg-accel-ops-mttcg.h
>> @@ -10,9 +10,6 @@
>>   #ifndef TCG_ACCEL_OPS_MTTCG_H
>>   #define TCG_ACCEL_OPS_MTTCG_H
>> -/* kick MTTCG vCPU thread */
>> -void mttcg_kick_vcpu_thread(CPUState *cpu);
>> -
>>   /* start an mttcg vCPU thread */
>>   void mttcg_start_vcpu_thread(CPUState *cpu);
>> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
>> index 9b658a3f48f..e843b09cc99 100644
>> --- a/include/exec/cpu-common.h
>> +++ b/include/exec/cpu-common.h
>> @@ -226,6 +226,7 @@ G_NORETURN void cpu_loop_exit(CPUState *cpu);
>>   G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
>>   /* accel/tcg/cpu-exec.c */
>> +void tcg_kick_vcpu_thread(CPUState *cpu);
> 
> "exec/cpu-common.h" is not the place, maybe "accel/tcg/cpu-ops.h"?

Agreed.  At some point we should split the non-system qemu_cpu_kick() etc out of 
{linux,bsd}-user to common-user, or something.


r~

