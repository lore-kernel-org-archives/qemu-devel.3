Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC8BCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNrw-0003FV-Ps; Sat, 30 Aug 2025 11:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usBtu-0005fY-Ai
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 23:05:10 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usBtr-0000t7-TV
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 23:05:10 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-327f87275d4so1043964a91.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 20:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756523105; x=1757127905; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ukwoa5IccIQRUQm4QP0hSlkeC5H/N2q8r0mqAtwgM8w=;
 b=rBHB4jfQNBlCTjbGu3pr0F7eCKyoFGB5Me9t3cperBlAPiqGUk6A89cDM/lGo5xTCz
 /x21WzKI9DADcx7wHsAUgjpcMyUCLkcMW6v0kuoE1kuD95KFc1GJl1mHHSwn81Ns77Fr
 1VtObUehSfewHt4iz1N5klPVnSpsVQzUHYnrzE67Uid4S26xukCfCKgn5SXPtQZsudG4
 s8vwvvMYrKzVEJUp2Mn4sAnS9cw9Q10nBT7O2xb5GmTpDlW5s5nOqfhtLcgAXoKqwaWZ
 R4n/os3D3Lk6BDEnEyM7V73/x0s0BhFnMYo50r6gLiKtpjZNb4HN84l93KZjGh8XP+gN
 Y2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756523105; x=1757127905;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ukwoa5IccIQRUQm4QP0hSlkeC5H/N2q8r0mqAtwgM8w=;
 b=nxJ6bD58RxB8S/z4BlEZX8pexv/YubdLnh4cOs4DeaiTmmzd33ixHTk9HBc/830UDY
 O4m3Ii7S45T/fQi3L0prdUlx0GkHvmt0wa3/Ihqisi4I53jJ8g+OxUy5K2ELrBcgTjsP
 nlOEW/byIvkXEdU5T21jhGl8MlJ61yjftAHXzZ2WUCKyNHpxg6ciZAXpnSZKDwZM3wmJ
 8jgDmNp/8WlEa+wtz3Z9rpGJd2BUSrYuoKL2Tv3l5AwU4ALp9EesIJxLXkuko0s8g6Nx
 rgXsytrnG3xyCZnmvPwMTcOw35N9taIZ2+MFATm1r7mALM14ei49BRgZs2A0smFDQba0
 KDUg==
X-Gm-Message-State: AOJu0YxOGWVbM9QNIhogTHutOa6E4CaNi8fPZoBl5/0wtgng7LUK9jSI
 rtE68CrxgNEAr8Vr2QpX5kaDF6ZczzrlgZnP0bcQlYL3WjrhgHrZVHzvFbZ4SV52vpM=
X-Gm-Gg: ASbGnctMmLAzNsvBrGHNKs0IAzxv3n0RLWmAvbs0dG67mi3tJ+N+2gpyBQ158vRag3w
 2S1/3fXuFjnIiSU2oY74AQX7sIAd50+QMdRpcdWe23Yl4DXYsu6z9P9z+EWRogy1H/k0wNj6Dcg
 XzgvM9YfF8/0q/qzJCb8WUe6uQ6lU676jMRiLYynXeZNwtsPH6VxPS2e1OoWfwoWeXymaRgxKUT
 VX2+gqPOuawnQY1AtNvmppPmb4vQFW4tYMCWh1qFoRQd5fHe47zE9oRxRiWYVQ0N2icwfJ+m2yB
 LIrLqXNDPBfTLnEJK/EW0cP/dA5QkZWOD0Gn8VW+F3FtuMSGGSWgKyM1MP9ppScwcft6JCAXL0A
 rwRRkrFRHhM1ofCExSRuh2KylbQy9KKhKQEdJIbwjfO+3Xi6ClWE1jOdfYp6J2BQjUi0u2tTeL3
 FkcaxQ
X-Google-Smtp-Source: AGHT+IEzfp7qlunCOvR6feN2SYtSLTG6mmqrVdH3YBk8Aegq3LeCr/LBWVCYFtkfgQJGcrS6b2BAcQ==
X-Received: by 2002:a17:90b:2252:b0:327:edde:609e with SMTP id
 98e67ed59e1d1-3281543caffmr1430482a91.12.1756523105311; 
 Fri, 29 Aug 2025 20:05:05 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-12.dyn.ip.vocus.au.
 [122.150.204.12]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77231f40553sm2745121b3a.43.2025.08.29.20.05.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 20:05:04 -0700 (PDT)
Message-ID: <32f69f26-ff0e-4615-9711-d30f41f67f8e@linaro.org>
Date: Sat, 30 Aug 2025 13:04:44 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/18] cpus: properly kick CPUs out of inner execution loop
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, imammedo@redhat.com
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829153115.1590048-10-pbonzini@redhat.com>
 <743782b5-1e3b-4b63-afe2-4ad1da333bde@linaro.org>
 <CABgObfYG=Aaz2ujr4xeuKgUqM35tF_2nS-W+v6bjYQJ4xMsvRg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CABgObfYG=Aaz2ujr4xeuKgUqM35tF_2nS-W+v6bjYQJ4xMsvRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 8/30/25 09:05, Paolo Bonzini wrote:
> On Fri, Aug 29, 2025 at 11:57 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 8/30/25 01:31, Paolo Bonzini wrote:
>>> @@ -624,8 +624,7 @@ static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
>>>        }
>>>
>>>        cs->exception_index = EXCP_YIELD;
>>> -    qatomic_set(&cs->exit_request, true);
>>> -    cpu_loop_exit(cs);
>>> +    cpu_exit(cs);
>>>
>>>        return H_SUCCESS;
>>>    }
>>
>> cpu_loop_exit does a longjmp; cpu_exit does not.
>>
>> This may be a bug fix, but it's hard to tell.
>> If it is a bug fix, it should be separated.
> 
> The longjmp is overkill but works. Not doing the longjmp also works
> because gen_sc() finishes the TB and then you go all the way (check
> interrupt_request -> check exit_request -> write exception_index ->
> cpu_exec_end) out of tcg_cpu_exec().

Ok.

> 
> I like cpu_loop_exit() to signify that I am in the middle of the TB.

Agreed.  I suspect we over-use longjmp and could perhaps do better at simply returning up 
the call-stack.


> That said, I'm always conflicted between renaming badly-named
> functions and keeping historical names. qemu_wait_io_event() is also
> horrible.

...

> 
>>> +++ b/system/cpu-timers.c
>>> @@ -246,14 +246,14 @@ void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
>>>
>>>       if (qemu_in_vcpu_thread()) {
>>>           /*
>>> -         * A CPU is currently running; kick it back out to the
>>> +         * A CPU is currently running; kick it back out of the
>>>            * tcg_cpu_exec() loop so it will recalculate its
>>>            * icount deadline immediately.
>>>            */
>>> -        qemu_cpu_kick(current_cpu);
>>> +        cpu_exit(current_cpu);
>>
>> where the comment still says kick and we're replacing kick with exit.
>>
>> I guess the root of this problem is that "kick" isn't a precise term, we ought to name it
>> something else, and we should paint the bike shed green.
> 
> Yes, I agree. "send it out of" can work too in this case, I'll chanbge it.

I was actually talking about renaming qemu_cpu_kick.
But per above, that's hard.  :-)

I guess just updating the comment is fine for now.


r~

