Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64453CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDd3H-00015Y-PV; Tue, 28 Oct 2025 02:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1vDd2u-00011D-LK
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:19:05 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1vDd2q-0007oD-OB
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:19:04 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Axz79KYABpPnYbAA--.57376S3;
 Tue, 28 Oct 2025 14:18:50 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJDxQ+RHYABpXqUUAQ--.19617S3;
 Tue, 28 Oct 2025 14:18:49 +0800 (CST)
Subject: Re: [RFC PATCH] target/loongarch: Add kvm support dintc
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20251015072745.3921106-1-gaosong@loongson.cn>
 <d57bf88e-a537-7b12-844b-b67acaeb316d@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <d12624c6-e364-e6d5-8486-4c13a0746f33@loongson.cn>
Date: Tue, 28 Oct 2025 14:18:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d57bf88e-a537-7b12-844b-b67acaeb316d@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJDxQ+RHYABpXqUUAQ--.19617S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jr4kArW3Jr13KFWrCF13Jrc_yoW3Wr1kpr
 n5JFWUGFy5Grn7Jw17try5XryUXr18J3WUXr18XFyUAr4UGr1jqr10grn0gF1UAw48Jr1r
 AF1UZrsxur17JrbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU24SoDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.221,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

在 2025/10/21 上午10:02, Bibo Mao 写道:
>
>
> On 2025/10/15 下午3:27, Song Gao wrote:
>> This patch adds set/get msgint CSRs and check msgint feature.
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>> RFC: this patch need update linux-headers and
>> the linux kernel kvm support avec(not merged).
>>
>>   linux-headers/asm-loongarch/kvm.h |  1 +
>>   target/loongarch/cpu.h            |  1 +
>>   target/loongarch/kvm/kvm.c        | 59 ++++++++++++++++++++++++++++++-
>>   3 files changed, 60 insertions(+), 1 deletion(-)
>>
>> diff --git a/linux-headers/asm-loongarch/kvm.h 
>> b/linux-headers/asm-loongarch/kvm.h
>> index 5f354f5c68..20e69561bf 100644
>> --- a/linux-headers/asm-loongarch/kvm.h
>> +++ b/linux-headers/asm-loongarch/kvm.h
>> @@ -103,6 +103,7 @@ struct kvm_fpu {
>>   #define  KVM_LOONGARCH_VM_FEAT_PMU        5
>>   #define  KVM_LOONGARCH_VM_FEAT_PV_IPI        6
>>   #define  KVM_LOONGARCH_VM_FEAT_PV_STEALTIME    7
>> +#define  KVM_LOONGARCH_VM_FEAT_MSGINT           8
>>     /* Device Control API on vcpu fd */
>>   #define KVM_LOONGARCH_VCPU_CPUCFG    0
>> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
>> index b8e3b46c3a..e714b4252e 100644
>> --- a/target/loongarch/cpu.h
>> +++ b/target/loongarch/cpu.h
>> @@ -278,6 +278,7 @@ enum loongarch_features {
>>       LOONGARCH_FEATURE_PMU,
>>       LOONGARCH_FEATURE_PV_IPI,
>>       LOONGARCH_FEATURE_STEALTIME,
>> +    LOONGARCH_FEATURE_MSGINT,
>>   };
>>     typedef struct  LoongArchBT {
>> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
>> index 4e4f4e79f6..7c48787d97 100644
>> --- a/target/loongarch/kvm/kvm.c
>> +++ b/target/loongarch/kvm/kvm.c
>> @@ -316,6 +316,18 @@ static int kvm_loongarch_get_csr(CPUState *cs)
>>       ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(3)),
>>                              &env->CSR_DMW[3]);
>>   +    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(0)),
>> +                           &env->CSR_MSGIS[0]);
>> +
>> +    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(1)),
>> +                           &env->CSR_MSGIS[1]);
>> +
>> +    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(2)),
>> +                           &env->CSR_MSGIS[2]);
>> +
>> +    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(3)),
>> +                           &env->CSR_MSGIS[3]);
>> +
> It will better if there will msgint feature checking such as 
> msgint_needed().
>
> static bool msgint_needed(void *opaque)
> {
>     LoongArchCPU *cpu = opaque;
>
>     return FIELD_EX64(cpu->env.cpucfg[1], CPUCFG1, MSG_INT);
> }
I wll add check on v2.
>
>>       ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TVAL),
>>                              &env->CSR_TVAL);
>>   @@ -488,6 +500,19 @@ static int kvm_loongarch_put_csr(CPUState *cs, 
>> KvmPutState level)
>>         ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(3)),
>>                              &env->CSR_DMW[3]);
>> +
>> +    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(0)),
>> +                           &env->CSR_MSGIS[0]);
>> +
>> +    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(1)),
>> +                           &env->CSR_MSGIS[1]);
>> +
>> +    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(2)),
>> +                           &env->CSR_MSGIS[2]);
>> +
>> +    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(3)),
>> +                           &env->CSR_MSGIS[3]);
>> +
> Ditto
>>       /*
>>        * timer cfg must be put at last since it is used to enable
>>        * guest timer
>> @@ -930,7 +955,11 @@ static bool kvm_feature_supported(CPUState *cs, 
>> enum loongarch_features feature)
>>           attr.attr = KVM_LOONGARCH_VM_FEAT_PV_STEALTIME;
>>           ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
>>           return (ret == 0);
>> -
>> +    case LOONGARCH_FEATURE_MSGINT:
>> +        attr.group = KVM_LOONGARCH_VM_FEAT_CTRL;
>> +        attr.attr = KVM_LOONGARCH_VM_FEAT_MSGINT;
>> +        ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
>> +        return (ret == 0);
> Space line needed here :)
>
Got it .
>>       default:
>>           return false;
>>       }
>> @@ -1074,6 +1103,28 @@ static int kvm_cpu_check_pv_features(CPUState 
>> *cs, Error **errp)
>>       return 0;
>>   }
>>   +static int kvm_cpu_check_msgint(CPUState *cs, Error **errp)
>> +{
>> +    CPULoongArchState *env = cpu_env(cs);
>> +    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
>> +    bool kvm_supported;
>> +
>> +    kvm_supported = kvm_feature_supported(cs, 
>> LOONGARCH_FEATURE_MSGINT);
>> +    env->cpucfg[1] = FIELD_DP32(env->cpucfg[1], CPUCFG1, MSG_INT, 0);
>> +    if (cpu->msgint == ON_OFF_AUTO_ON) {
>> +        if (kvm_supported) {
>> +            env->cpucfg[1] = FIELD_DP32(env->cpucfg[1], CPUCFG1, 
>> MSG_INT, 1);
>> +        } else {
>> +            error_setg(errp, "'msgint' feature not supported by KVM 
>> on this host");
>> +            return -ENOTSUP;
>> +        }
>> +    } else if ((cpu->msgint == ON_OFF_AUTO_AUTO) && kvm_supported) {
> When is its value set with ON_OFF_AUTO_AUTO in KVM mode? It seems that 
> all is ON_OFF_AUTO_OFF by default in KVM mode.
>
it set when use max cpu,  and I miss some code on this patch.

--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -385,10 +385,8 @@ static void loongarch_max_initfn(Object *obj)
      /* '-cpu max' for TCG: we use cpu la464. */
      loongarch_la464_initfn(obj);

-    if (tcg_enabled()) {
-        cpu->env.cpucfg[1] = FIELD_DP32(cpu->env.cpucfg[1], CPUCFG1, 
MSG_INT, 1);
-        cpu->msgint = ON_OFF_AUTO_AUTO;
-    }
+    cpu->env.cpucfg[1] = FIELD_DP32(cpu->env.cpucfg[1], CPUCFG1, 
MSG_INT, 1);
+    cpu->msgint = ON_OFF_AUTO_AUTO;
  }

Thanks.
Song Gao

> Regards
> Bibo Mao
>> +        env->cpucfg[1] = FIELD_DP32(env->cpucfg[1], CPUCFG1, 
>> MSG_INT, 1);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
>>   {
>>       return 0;
>> @@ -1123,6 +1174,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>           return ret;
>>       }
>>   +    ret = kvm_cpu_check_msgint(cs, &local_err);
>> +    if (ret < 0) {
>> +        error_report_err(local_err);
>> +        return ret;
>> +    }
>> +
>>       return 0;
>>   }
>>
>> base-commit: 3bf5c57a11827d9fa706524d57ee3e5af68a429e
>>
>


