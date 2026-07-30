Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3F1C5516D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 21:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpY6j-00086O-9R; Thu, 30 Jul 2026 17:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agraf@csgraf.de>)
 id 1wpY6b-0007uB-Cp; Thu, 30 Jul 2026 17:15:56 -0400
Received: from mail.csgraf.de ([85.25.223.15] helo=zulu616.server4you.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agraf@csgraf.de>)
 id 1wpY6Y-000620-Qg; Thu, 30 Jul 2026 17:15:52 -0400
Received: from [192.168.106.196]
 (dynamic-077-007-119-149.77.7.pool.telefonica.de [77.7.119.149])
 by csgraf.de (Postfix) with ESMTPSA id 64F0860804CE;
 Thu, 30 Jul 2026 23:15:28 +0200 (CEST)
Message-ID: <1e9f7c9f-8f03-4bc3-a04a-480ce16fe4ff@csgraf.de>
Date: Thu, 30 Jul 2026 23:15:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/19] hvf: Simplify post reset/init/loadvm hooks
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 qemu-arm <qemu-arm@nongnu.org>, Frank Yang <lfy@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Collingbourne <pcc@google.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20210519202253.76782-1-agraf@csgraf.de>
 <20210519202253.76782-13-agraf@csgraf.de>
 <d4dba8be-4982-4125-b447-cdb2de1ad060@oss.qualcomm.com>
Content-Language: en-US
From: Alexander Graf <agraf@csgraf.de>
In-Reply-To: <d4dba8be-4982-4125-b447-cdb2de1ad060@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=85.25.223.15; envelope-from=agraf@csgraf.de;
 helo=zulu616.server4you.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hey Philippe,

On 30.07.26 18:00, Philippe Mathieu-Daudé wrote:
> Hi Alex,
>
> (old patch committed as bac969ef30e8a8b73acbeb6d68abff6f68b2056c)
>
> On 19/5/21 22:22, Alexander Graf wrote:
>> The hooks we have that call us after reset, init and loadvm really all
>> just want to say "The reference of all register state is in the QEMU
>> vcpu struct, please push it".
>>
>> We already have a working pushing mechanism though called 
>> cpu->vcpu_dirty,
>> so we can just reuse that for all of the above, syncing state 
>> properly the
>> next time we actually execute a vCPU.
>>
>> This fixes PSCI resets on ARM, as they modify CPU state even after the
>> post init call has completed, but before we execute the vCPU again.
>>
>> To also make the scheme work for x86, we have to make sure we don't
>> move stale eflags into our env when the vcpu state is dirty.
>>
>> Signed-off-by: Alexander Graf <agraf@csgraf.de>
>> Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
>> Tested-by: Roman Bolshakov <r.bolshakov@yadro.com>
>> ---
>>   accel/hvf/hvf-accel-ops.c | 27 +++++++--------------------
>>   target/i386/hvf/x86hvf.c  |  5 ++++-
>>   2 files changed, 11 insertions(+), 21 deletions(-)
>>
>> diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
>> index ded918c443..d1691be989 100644
>> --- a/accel/hvf/hvf-accel-ops.c
>> +++ b/accel/hvf/hvf-accel-ops.c
>> @@ -205,39 +205,26 @@ static void hvf_cpu_synchronize_state(CPUState 
>> *cpu)
>>       }
>>   }
>>   -static void do_hvf_cpu_synchronize_post_reset(CPUState *cpu,
>> -                                              run_on_cpu_data arg)
>> +static void do_hvf_cpu_synchronize_set_dirty(CPUState *cpu,
>> +                                             run_on_cpu_data arg)
>>   {
>> -    hvf_put_registers(cpu);
>> -    cpu->vcpu_dirty = false;
>> +    /* QEMU state is the reference, push it to HVF now and on next 
>> entry */
>> +    cpu->vcpu_dirty = true;
>>   }
>>     static void hvf_cpu_synchronize_post_reset(CPUState *cpu)
>>   {
>> -    run_on_cpu(cpu, do_hvf_cpu_synchronize_post_reset, 
>> RUN_ON_CPU_NULL);
>> -}
>> -
>> -static void do_hvf_cpu_synchronize_post_init(CPUState *cpu,
>> -                                             run_on_cpu_data arg)
>> -{
>> -    hvf_put_registers(cpu);
>> -    cpu->vcpu_dirty = false;
>> +    run_on_cpu(cpu, do_hvf_cpu_synchronize_set_dirty, RUN_ON_CPU_NULL);
>>   }
>>     static void hvf_cpu_synchronize_post_init(CPUState *cpu)
>>   {
>> -    run_on_cpu(cpu, do_hvf_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
>
> Since we are not calling hvf_put_registers() anymore, any reason to keep
> using run_on_cpu()? I think it is safe to update the field out of the
> vCPU thread context, it will be consumed by the thread during the next
> inner loop run, no need to schedule to the vCPU work queue. But I'm out
> of my confort zone here so might be wrong.


Your reasoning makes sense. But there could be dragons lurking 
somewhere, like broken "info registers" views, HVF depending on specific 
register contents for paused CPUs, etc.

I don't see a way to reason about this except to empirically try.


Alex


