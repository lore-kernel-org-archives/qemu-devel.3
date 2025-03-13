Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDD9C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 11:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsga8-0008Vg-0J; Thu, 13 Mar 2025 07:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tsga3-0008VM-JI
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 07:18:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tsgZq-0001vZ-7p
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 07:18:27 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxlmntvtJn1eCUAA--.56636S3;
 Thu, 13 Mar 2025 19:18:06 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMAxj8XqvtJn9YJIAA--.8483S3;
 Thu, 13 Mar 2025 19:18:04 +0800 (CST)
Subject: Re: [PATCH 1/3] target/loongarch: Return directly when detect KVM
 disabled features
To: Markus Armbruster <armbru@redhat.com>
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250313091350.3770394-1-maobibo@loongson.cn>
 <20250313091350.3770394-2-maobibo@loongson.cn> <87a59pb50c.fsf@pond.sub.org>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <229f2cf0-7bd0-4b37-5647-bacef1511da3@loongson.cn>
Date: Thu, 13 Mar 2025 19:17:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87a59pb50c.fsf@pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxj8XqvtJn9YJIAA--.8483S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCF45tF1xJFy5Ar1kXr13trc_yoW5WFy7pr
 W7ZF4DtrW5tFWkJ3sFqr9rXr4rX34kGFy7Za9Fya4fAwn8Crn7CrW8KwsFgF98u340ga1F
 qFWrWFn8uF4UA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
 6r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
 CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
 0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
 AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
 Ja73UjIFyTuYvjxU7XTmDUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2025/3/13 下午6:26, Markus Armbruster wrote:
> Suggest something like
> 
>    target/loongarch: Fix error handling of KVM feature checks
> 
> That way, the nature of the patch (it's an error handling bug fix) is
> obvious at a glance.
yeap, will modify title like this.

> 
> Bibo Mao <maobibo@loongson.cn> writes:
> 
>> For some paravirt KVM features, if user forces to enable it however
>> KVM does not support, qemu should fail to run. Here set error message
>> and return directly in function kvm_arch_init_vcpu().
>>
> 
> Please add
> 
>    Fixes: 6edd2a9bec90 (target/loongarch/kvm: Implement LoongArch PMU extension)
>    Fixes: 936c3f4d7916 (target/loongarch: Use auto method with LSX feature)
>    Fixes: 5e360dabedb1 (target/loongarch: Use auto method with LASX feature)
>    Fixes: 620d9bd0022e (target/loongarch: Add paravirt ipi feature detection)
OK, will add these fixes tag.
> 
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   target/loongarch/kvm/kvm.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
>> index 28735c80be..b7f370ba97 100644
>> --- a/target/loongarch/kvm/kvm.c
>> +++ b/target/loongarch/kvm/kvm.c
>     int kvm_arch_init_vcpu(CPUState *cs)
>     {
>         uint64_t val;
>         int ret;
>         Error *local_err = NULL;
> 
>         ret = 0;
> 
> Please drop this assignment, it's useless.
Sure, will do.
> 
>         qemu_add_vm_change_state_handler(kvm_loongarch_vm_stage_change, cs);
> 
>         if (!kvm_get_one_reg(cs, KVM_REG_LOONGARCH_DEBUG_INST, &val)) {
>             brk_insn = val;
>         }
> 
>> @@ -1091,21 +1091,25 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>       ret = kvm_cpu_check_lsx(cs, &local_err);
>>       if (ret < 0) {
>>           error_report_err(local_err);
>> +        return ret;
>>       }
>>   
>>       ret = kvm_cpu_check_lasx(cs, &local_err);
>>       if (ret < 0) {
>>           error_report_err(local_err);
>> +        return ret;
>>       }
>>   
>>       ret = kvm_cpu_check_lbt(cs, &local_err);
>>       if (ret < 0) {
>>           error_report_err(local_err);
>> +        return ret;
>>       }
>>   
>>       ret = kvm_cpu_check_pmu(cs, &local_err);
>>       if (ret < 0) {
>>           error_report_err(local_err);
>> +        return ret;
>>       }
>>   
> 
> Recommend to
> 
>>       ret = kvm_cpu_check_pv_features(cs, &local_err);
>         if (ret < 0) {
>             error_report_err(local_err);
>    +        return ret;
>         }
> 
>    -    return ret;
>         return 0;
>     }
> 
> Why?  Have a look at commit 6edd2a9bec90:
I agree. That is simple and easy to understand, will do like this.

Regards
Bibo Mao
> 
> @@ -793,6 +828,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
>       if (ret < 0) {
>           error_report_err(local_err);
>       }
> +
> +    ret = kvm_cpu_check_pmu(cs, &local_err);
> +    if (ret < 0) {
> +        error_report_err(local_err);
> +    }
> +
>       return ret;
>   }
> 
> The new call broke the previous call's error handling.  Easy mistake to
> make.  Less easy with my version.
> 
> With that
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 
> Thanks!
> 


