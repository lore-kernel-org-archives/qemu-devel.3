Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2955DC43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 06:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfX29-0002RM-9H; Fri, 03 Jul 2026 02:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wfX27-0002Qs-E9
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 02:05:51 -0400
Received: from out-178.mta0.migadu.com ([91.218.175.178])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wfX24-0008NY-Hy
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 02:05:51 -0400
Message-ID: <765a77d3-2c35-4ecc-b2bb-8fde8e35d87b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1783058742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JnX1eYhaLszCP85R44D+K5SRZITNtWQj11I+ASV+RFY=;
 b=I/Xd9IRB0B2f2unFecRQ4SpJXUDZce25Yl+EvlObSoC+fVDnePjrzWRPuiKndiLGblTEt+
 wTBiKMmcSqWMcoeWm/vlG8ay+hgsvk6qnMb3LCpoui/+uV4tAmLAXCZZjrwO1petnZOh4l
 vSl8kwaP9i/jol6XCDGkU4RY4gcA8v8=
Date: Fri, 3 Jul 2026 14:05:36 +0800
MIME-Version: 1.0
Cc: cui.tao@linux.dev, Song Gao <gaosong@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH] target/loongarch/kvm: set pv features per vCPU in
 kvm_arch_init_vcpu
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org
References: <20260625015317.678762-1-cui.tao@linux.dev>
 <39029c52-b386-f5b3-4cfb-e912121d224d@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <39029c52-b386-f5b3-4cfb-e912121d224d@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.178; envelope-from=cui.tao@linux.dev;
 helo=out-178.mta0.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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



在 2026/6/25 11:14, Bibo Mao 写道:
> 
> 
> On 2026/6/25 上午9:53, Tao Cui wrote:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> kvm_set_pv_features() programs the KVM_FEATURE cpucfg attribute, which is a
>> per-vCPU setting. It was called from kvm_arch_put_registers() under a
>> function-local static guard, so it ran only once for the whole VM and only
>> the first vCPU actually got its pv features pushed to KVM.
>>
>> Move the call to kvm_arch_init_vcpu(), which runs once per vCPU, right
>> after the pv features are computed, and drop the static guard.
>>
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>> ---
>>   target/loongarch/kvm/kvm.c | 15 ++++++---------
>>   1 file changed, 6 insertions(+), 9 deletions(-)
>>
>> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
>> index d6539c12ac..985812c828 100644
>> --- a/target/loongarch/kvm/kvm.c
>> +++ b/target/loongarch/kvm/kvm.c
>> @@ -816,7 +816,6 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
>>   int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
>>   {
>>       int ret;
>> -    static int once;
>>         ret = kvm_loongarch_put_regs_core(cs);
>>       if (ret) {
>> @@ -843,14 +842,6 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
>>           return ret;
>>       }
>>   -    if (!once) {
>> -        ret = kvm_set_pv_features(cs);
>> -        if (ret) {
>> -            return ret;
>> -        }
>> -        once = 1;
>> -    }
>> -
>>       if (level >= KVM_PUT_FULL_STATE) {
>>           /*
>>            * only KVM_PUT_FULL_STATE is required, kvm kernel will clear
>> @@ -1209,6 +1200,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>           return ret;
>>       }
>>   +    /* pv_features is a per-vCPU attribute; set it here, once per vCPU. */
>> +    ret = kvm_set_pv_features(cs);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
> I prefer the old method. The pv_features is one vCPU state instead, and it will be added in vCPU VMState if migration is supported on different host kernel version.
> 
> Here is host feature detection, not vCPU state setting.

Thanks, that makes sense. init_vcpu() is the host-detection path; the
per-vCPU write belongs in kvm_arch_put_registers(). I'll keep it there,
drop the VM-global static guard, and push per-vCPU under
level >= KVM_PUT_FULL_STATE, the same gate kvm_set_stealtime() already
uses just below.

For migration across kernel versions, I'll add env->pv_features as a
sub-section of vmstate_loongarch_cpu (leaving version 4 untouched) so
the value travels with the vCPU.

Thanks,
Tao

> 
> Regards
> Bibo Mao
>> +
>>       ret = kvm_cpu_check_ptw(cs, &local_err);
>>       if (ret < 0) {
>>           error_report_err(local_err);
>>
> 


