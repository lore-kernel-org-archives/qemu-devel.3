Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A236ECDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 03:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcahk-0005Vd-TC; Wed, 24 Jun 2026 23:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wcahh-0005VC-8l
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 23:24:37 -0400
Received: from out-183.mta1.migadu.com ([95.215.58.183])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wcahf-0007VC-3I
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 23:24:36 -0400
Message-ID: <5f49b07a-972d-4e4d-87ab-2104b7cf941d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1782357872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dG5loXTzoPGcCxpkptU39Y8ir61DPuSSfYl4enFn5Ro=;
 b=Z+oHBUHFqamFJ0tKgGt6bdrXoeTGK7yseTB8IkjBmf31Qou+suseixshlMdeDQWaqtyw4K
 6urBvG4LyYObMDZVpqaqp4yUBnybQBlKGcHN82TZuxbPaZ1veE2Skh1LS3BJiuJbHWTh/s
 QDna1xrBOf8rJsxbhJ3zlnBEb0GT44Y=
Date: Thu, 25 Jun 2026 11:24:19 +0800
MIME-Version: 1.0
Cc: cui.tao@linux.dev, Song Gao <gaosong@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Qiang Ma <maqianga@uniontech.com>, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 1/4] target/loongarch/kvm: fix uninitialized val and
 unchecked GET in cpucfg2 check
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org
References: <20260625015835.678819-1-cui.tao@linux.dev>
 <20260625015835.678819-2-cui.tao@linux.dev>
 <0cf985f8-f109-bc7b-3353-3432dc017e59@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <0cf985f8-f109-bc7b-3353-3432dc017e59@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.183; envelope-from=cui.tao@linux.dev;
 helo=out-183.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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



在 2026/6/25 10:48, Bibo Mao 写道:
> 
> 
> On 2026/6/25 上午9:58, Tao Cui wrote:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> kvm_check_cpucfg2() discards the return value of KVM_GET_DEVICE_ATTR and
>> then uses the local val (the host cpucfg2 mask) without checking whether
>> the read succeeded. val is also declared without an initializer.
>>
>> If GET fails, env->cpucfg[2] &= val uses an uninitialized value and can
>> silently clear feature bits (FP / LLFTP / LSX / LASX), since bitwise-AND
>> can only turn bits off.
>>
>> Check the GET return value, report the failure with error_report(), and
>> initialize val to 0.
>>
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>> ---
>>   target/loongarch/kvm/kvm.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
>> index d6539c12ac..b7176ce53a 100644
>> --- a/target/loongarch/kvm/kvm.c
>> +++ b/target/loongarch/kvm/kvm.c
>> @@ -725,7 +725,7 @@ static int kvm_loongarch_get_cpucfg(CPUState *cs)
>>   static int kvm_check_cpucfg2(CPUState *cs)
>>   {
>>       int ret;
>> -    uint64_t val;
>> +    uint64_t val = 0;
>>       struct kvm_device_attr attr = {
>>           .group = KVM_LOONGARCH_VCPU_CPUCFG,
>>           .attr = 2,
>> @@ -736,7 +736,11 @@ static int kvm_check_cpucfg2(CPUState *cs)
>>       ret = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, &attr);
>>         if (!ret) {
>> -        kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, &attr);
>> +        ret = kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, &attr);
>> +        if (ret) {
>> +            error_report("CPUCFG2: KVM_GET_DEVICE_ATTR: %s", strerror(errno));
>> +            return ret;
> if it is successful with KVM_HAS_DEVICE_ATTR, however error with KVM_GET_DEVICE_ATTR. There should be mempy_from/to_user problem, maybe VM can continue to run without the following logic and operation. How about something like this?
> -        kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, &attr);
> -        env->cpucfg[2] &= val;
> +        ret = kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, &attr);
> +        if (!ret)
> +            env->cpucfg[2] &= val;
> 
Right, the &= mask is best-effort negotiation, so failing the whole register
sync over it is heavier than needed. I'll rework 1/4 so a GET failure only
skips the mask, using a local variable so the GET error no longer propagates:

    if (!ret) {
        int r = kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, &attr);
        if (r) {
            warn_report("CPUCFG2: KVM_GET_DEVICE_ATTR: %s", strerror(errno));
        } else {
            env->cpucfg[2] &= val;
        }
        ...
    }
    return ret;

The guest then keeps running with the cpucfg2 it already has. val is still
initialized to 0.

Thanks,
Tao
> 
> sentence
> feature and operation env->cpucfg[2] &= val;
>> +        }
>>           env->cpucfg[2] &= val;
>>             if (FIELD_EX32(env->cpucfg[2], CPUCFG2, FP)) {
>>
> 


