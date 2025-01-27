Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBB8C0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 13:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcP6z-0003x4-Ph; Mon, 27 Jan 2025 08:25:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcP6t-0003tt-Id
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 08:25:04 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcP6q-0003NQ-TX
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 08:25:02 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so51230975e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 05:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737984298; x=1738589098; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5qTsGCmojjQlTGMlYmRmdnLGk7/G1BDYcBk4kes4cwE=;
 b=sY3/PAKBNWjPftQAOUuTCK5oUu7hnVMTeNlwwv5avnc3NEW3c5knLj0XyUT9oQf4qL
 X4ZH1hkpvpX92kKsPoAp7aCueYc2xsrYy9MPqjXQ2HjZq9dhz3RwATRdQc8qsMS4lhvm
 d9+ycxs0eisRUMY+POqkfxPlzZzEd4oNVl9cO/Grt5S+wg1CBrr3HptEA5XbHKemZtZT
 DriG23MOZ/ZZOvOdQd4Ak1JxxatA4SesmmzhtT/0TR5tfytFjPTmab9ahVc7qqDRAeDw
 Fr9YkR6NYSA53wfSKooRH88XNC4lE0jVjX+EBTkAXEykVf+6ECbORB2WINTnacf9/5iU
 6VUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737984298; x=1738589098;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5qTsGCmojjQlTGMlYmRmdnLGk7/G1BDYcBk4kes4cwE=;
 b=muRhOIXsO5Gt7T/T/JmCLzAvgWRsK/zhNdY2AoJHN8m1akPK9W02HbMPG9r5NiGnOO
 afE/rtQLMXpU8Nx9lty8D9Jeo8E4LAfOJveDgF6ep/BLykBSU08d/rvmmqXrerthLV1D
 W92E7RlUjH5v8OMMFzm06XQ5TA0esfKoHy7N00O8Kvm3/94i0SyoRZrG7WKxV135wxu+
 AJH7Aht1yzJerBuianky3by2thWk/sQikyI/1IYov0uK+2h9e5LGRvESLLxDZbuCWN7I
 XuSQE+1el4LMLwfd7oIHNWqrEw/V+wefNtrwxUp8g4nKg/vP485XAZObHCHfFuJGZ6Hf
 CRxA==
X-Gm-Message-State: AOJu0YwGelteHc9MwDf/WpBy5tJ/VQBkMIB/buYITgNdTuDb9QjpPR24
 udO+BCtwUDZR/JGKNzOSktOg6rtzQUrRKq3QxSMjQ70kF7reyYTLS9HGNW12yMuRNaLau9/7aDA
 1MTM=
X-Gm-Gg: ASbGnct9gkta/eajgym879CL4j4h5N03FL110fKn8VrMbyMavkyueKukhdwGYaeDnai
 cn8/nhg9Gymh+lpkDYlQUuWzaRfKGrSgYW05hNzeRH9Cmn2c5pU5Z8aKOYF3ghLBW44kXW8CRSE
 o5ppxYFq1DcSg+CKneGvu2SodX6WbSAjFPubtx9fLzhOMIcaBFMAykQfg1lsF/XIUXB8Lc2hdbr
 l0UZJxyiFcig6xXOPpM5jWZ7gTWKuviD/BKtvRgVCc+1YEuGLxHqsdDAyYC1BmXDH8DG7RCwlH3
 LHLiipIOEWO07I55WAZ/zK3f1HKLKnapFVrZTRZZ9T01W+QG
X-Google-Smtp-Source: AGHT+IHJNU5VAufO6qtCRogV0c4sWqr6Af2or8m+7vsFmVhP2UlGcSb3+gf154qusK7AZFJdYB8FFg==
X-Received: by 2002:a05:600c:ccc:b0:434:e9ee:c3d with SMTP id
 5b1f17b1804b1-4389141c1e5mr313425315e9.20.1737984298542; 
 Mon, 27 Jan 2025 05:24:58 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17d6d7sm11253555f8f.31.2025.01.27.05.24.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 05:24:57 -0800 (PST)
Message-ID: <f3567791-13f0-4696-81fe-19f4111705e7@linaro.org>
Date: Mon, 27 Jan 2025 14:24:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: drop qemu_cpu_is_self() in
 tlb_flush_by_mmuidx[_async_work]
To: Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com
References: <20250123094511.156324-1-imammedo@redhat.com>
 <87frl9ls4g.fsf@draig.linaro.org>
 <20250123122343.6af8a6e1@imammedo.users.ipa.redhat.com>
 <87y0z1k9yg.fsf@draig.linaro.org>
 <20250123143846.586282b2@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250123143846.586282b2@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

+Peter

On 23/1/25 14:38, Igor Mammedov wrote:
> On Thu, 23 Jan 2025 12:09:59 +0000
> Alex Bennée <alex.bennee@linaro.org> wrote:
> 
>> Igor Mammedov <imammedo@redhat.com> writes:
>>
>>> On Thu, 23 Jan 2025 10:52:15 +0000
>>> Alex Bennée <alex.bennee@linaro.org> wrote:
>>>   
>>>> Igor Mammedov <imammedo@redhat.com> writes:
>>>>    
>>>>> QEMU will crash with following debug enabled
>>>>>    # define DEBUG_TLB_GATE 1
>>>>>    # define DEBUG_TLB_LOG_GATE 1
>>>>> due to [1] introduced assert and as it happenstlb_flush_by_mmuidx[_async_work]
>>>>> functions are called not only from vcpu thread but also from reset handler
>>>>> that is called from main thread at cpu realize time when vcpu is already
>>>>> created
>>>>>    x86_cpu_new -> ... ->
>>>>>        x86_cpu_realizefn -> cpu_reset -> ... ->
>>>>>            tcg_cpu_reset_hold
>>>>>
>>>>> drop assert to fix crash.
>>>>
>>>> Hmm the assert is there for a good reason because we do not want to be
>>>> flushing another CPUs state. However the assert itself:
>>>>
>>>>    g_assert(!(cpu)->created || qemu_cpu_is_self(cpu));
>>>>
>>>> was trying to account for pre-initialised vCPUs. What has changed?
>>>>
>>>> cpu_thread_signal_created(cpu) is called just before we start running
>>>> the main loop in mttcg_cpu_thread_fn. So any other thread messing with
>>>> the CPUs TLB can potentially mess things up.
>>>
>>> it reproduces on current master, so yes it likely has changed over time.
>>> I've just stumbled on it when attempting to get rid of cpu->created
>>> usage.
>>
>> Why the drive to get rid of cpu->created?
> 
> During review of Philippe's cpu cleanups,
> I've noticed that  cpu->created is mostly used for signaling
> main loop thread we've started vcpu thread with a couple of
> odd cases in tcg and kvm.
>    - 1st silently bit-rotted being behind ifdefs
>    - 2nd is work around CPU being prematurely visible to others

2nd is:

commit 56adee407fc564da19e49cfe18e20e3da92320be
Author: Peter Xu <peterx@redhat.com>
Date:   Fri Feb 17 00:18:32 2023 +0800

     kvm: dirty-ring: Fix race with vcpu creation

     It's possible that we want to reap a dirty ring on a vcpu that is 
during
     creation, because the vcpu is put onto list (CPU_FOREACH visible) 
before
     initialization of the structures.  In this case:

     qemu_init_vcpu
         x86_cpu_realizefn
             cpu_exec_realizefn
                 cpu_list_add      <---- can be probed by CPU_FOREACH
             qemu_init_vcpu
                 cpus_accel->create_vcpu_thread(cpu);
                     kvm_init_vcpu
                         map kvm_dirty_gfns  <--- kvm_dirty_gfns valid

     Don't try to reap dirty ring on vcpus during creation or it'll crash.

Looking at cpu_list_add() in cpu_exec_realizefn():

hw/core/cpu-common.c-190-    /* Wait until cpu initialization complete 
before exposing cpu. */
hw/core/cpu-common.c:191:    cpu_list_add(cpu);

IMO the problem is with cpu_list_add(), we shouldn't expose the vCPU
until it is realized.

cpu_list_add() seems to be doing 2 things, auto-assign CPU index if
UNASSIGNED_CPU_INDEX, then insert to global cpus_queue.

IIRC cpu_list_add() is called early because various cpu init code
expects cpu->index to be assigned.

Maybe we could extract the 'safely assign an unique cpu index' part
(guarding by qemu_cpu_list_lock), having cpu_list_add() just add to
the global queue. I'll give it a try...

> 
>> I guess we could assert:
>>
>>    g_assert(!current_cpu || qemu_cpu_is_self(cpu);
>>
>> as current_cpu should only be set as we go into the main thread. However
>> there is a sketchy setting of current_cpu in cpu_exec() that I'm not
>> sure should be there. Also do_run_on_cpu() messes with current_cpu in a
>> way I don't fully understand either.
> 
> I'd rather not rely on that, even if it works it would be subject to
> to the same kind of breakage.
> 
> How about instead of workaround check we would have 2 variants
> of tlb_flush_by_mmuidx[_async_work], one that have self check
> and other for usage externally (i.e. from reset handler).
> That won't have to rely on sketchy globals (which becomes more
> sketchy in context of Philippes's multi accel work),
> and it would clearly document what can be used externally.
> 
>>
>>>
>>>   
>>>>> 1)
>>>>> Fixes: f0aff0f124028 ("cputlb: add assert_cpu_is_self checks")
>>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>>>> ---
>>>>>   accel/tcg/cputlb.c | 4 ----
>>>>>   1 file changed, 4 deletions(-)
>>>>>
>>>>> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
>>>>> index b26c0e088f..2da803103c 100644
>>>>> --- a/accel/tcg/cputlb.c
>>>>> +++ b/accel/tcg/cputlb.c
>>>>> @@ -381,8 +381,6 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
>>>>>       uint16_t all_dirty, work, to_clean;
>>>>>       int64_t now = get_clock_realtime();
>>>>>   
>>>>> -    assert_cpu_is_self(cpu);
>>>>> -
>>>>>       tlb_debug("mmu_idx:0x%04" PRIx16 "\n", asked);
>>>>>   
>>>>>       qemu_spin_lock(&cpu->neg.tlb.c.lock);
>>>>> @@ -419,8 +417,6 @@ void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
>>>>>   {
>>>>>       tlb_debug("mmu_idx: 0x%" PRIx16 "\n", idxmap);
>>>>>   
>>>>> -    assert_cpu_is_self(cpu);
>>>>> -
>>>>>       tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(idxmap));
>>>>>   }
>>>>    
>>
> 
> 


