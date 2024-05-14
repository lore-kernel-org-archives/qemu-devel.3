Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985F5C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 12:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6r2b-0003da-Ao; Tue, 14 May 2024 08:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1s6r2S-0003bt-Bz
 for qemu-devel@nongnu.org; Tue, 14 May 2024 08:13:49 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1s6r2O-0004Cc-Sr
 for qemu-devel@nongnu.org; Tue, 14 May 2024 08:13:48 -0400
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8Bxc+pyVUNmU6gMAA--.18633S3;
 Tue, 14 May 2024 20:13:38 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxrdxuVUNmeGseAA--.54022S3; 
 Tue, 14 May 2024 20:13:37 +0800 (CST)
Subject: Re: [RFC PATCH] target/loongarch/kvm: Add pmu support
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org, 
 peter.maydell@linaro.org, philmd@linaro.org
References: <20240514094630.988617-1-gaosong@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <ad5607e3-bc95-c0e5-6755-9ee5a6eb39ab@loongson.cn>
Date: Tue, 14 May 2024 20:13:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240514094630.988617-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxrdxuVUNmeGseAA--.54022S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxtF1fXrWxurWxKF15tFykCrX_yoW3JFWxpF
 47AFs0grWUtFZ2ywsxX345Wr1DZr4xGr42q3WfCryxZF4DGr1UZa48twsruF1rC3yrJr4F
 gr4FkasIgF4DtabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8cz
 VUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.127,
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



On 2024/5/14 下午5:46, Song Gao wrote:
> This patch adds PMU support, We just sets some cpucfg6 default value
> to PMU config on kvm mode, and then check the PMU config with kvm ioctl
> KVM_GET_DEVICE_ATTR.
>    e.g
>      '...  -cpu max,pmu=on,pmnum=[1-16]';
>      '...  -cpu max,pmu=on' (default pmnum = 4);
Do we need expose interface pmnum to user?
The default PMU number is 4 on la464/la664, it should equal to real HW.
There is no much meaning with pmnum == 1 although it supports.

>      '...  -cpu max,pmu=off' (disable PMU)
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
> 
> This patch adds the 'RFC' heading because it requires
> the kernel to merge into patch[1] first
> 
> [1]: https://lore.kernel.org/all/20240507120140.3119714-1-gaosong@loongson.cn/
> 
> 
>   target/loongarch/cpu.h                |  2 +
>   target/loongarch/cpu.c                | 64 +++++++++++++++++++++++++++
>   target/loongarch/kvm/kvm.c            | 55 ++++++++++++++++++++++-
>   target/loongarch/loongarch-qmp-cmds.c |  2 +-
>   4 files changed, 121 insertions(+), 2 deletions(-)
> 
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 6c41fafb70..d834649106 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -184,6 +184,8 @@ FIELD(CPUCFG6, PMNUM, 4, 4)
>   FIELD(CPUCFG6, PMBITS, 8, 6)
>   FIELD(CPUCFG6, UPM, 14, 1)
>   
> +#define PMNUM_MAX 16
> +
>   /* cpucfg[16] bits */
>   FIELD(CPUCFG16, L1_IUPRE, 0, 1)
>   FIELD(CPUCFG16, L1_IUUNIFY, 1, 1)
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index a0cad53676..c78ee3f0b1 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -8,6 +8,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu/log.h"
>   #include "qemu/qemu-print.h"
> +#include "qemu/error-report.h"
>   #include "qapi/error.h"
>   #include "qemu/module.h"
>   #include "sysemu/qtest.h"
> @@ -19,6 +20,7 @@
>   #include "internals.h"
>   #include "fpu/softfloat-helpers.h"
>   #include "cpu-csr.h"
> +#include "qapi/visitor.h"
>   #ifndef CONFIG_USER_ONLY
>   #include "sysemu/reset.h"
>   #endif
> @@ -421,6 +423,14 @@ static void loongarch_la464_initfn(Object *obj)
>       data = FIELD_DP32(data, CPUCFG5, CC_DIV, 1);
>       env->cpucfg[5] = data;
>   
> +    if (kvm_enabled()) {
> +        data = 0;
> +        data = FIELD_DP32(data, CPUCFG6, PMP, 1);
> +        data = FIELD_DP32(data, CPUCFG6, PMNUM, 3);
> +        data = FIELD_DP32(data, CPUCFG6, PMBITS, 63);
> +        env->cpucfg[6] = data;
> +    }
> +
>       data = 0;
>       data = FIELD_DP32(data, CPUCFG16, L1_IUPRE, 1);
>       data = FIELD_DP32(data, CPUCFG16, L1_DPRE, 1);
> @@ -643,6 +653,48 @@ static void loongarch_set_lasx(Object *obj, bool value, Error **errp)
>       }
>   }
>   
> +static bool loongarch_get_pmu(Object *obj, Error **errp)
> +{
> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
> +
> +    return  !!(FIELD_EX32(cpu->env.cpucfg[6], CPUCFG6, PMP));
> +}
> +
> +static void loongarch_set_pmu(Object *obj, bool value,  Error **errp)
> +{
> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
> +
> +    cpu->env.cpucfg[6] = FIELD_DP32(cpu->env.cpucfg[6], CPUCFG6, PMP, value);
> +}
> +
> +static void loongarch_get_pmnum(Object *obj, Visitor *v,
> +                                const char *name, void *opaque,
> +                                Error **errp)
> +{
> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
> +    uint32_t value = FIELD_EX32(cpu->env.cpucfg[6], CPUCFG6, PMNUM);
> +
> +    visit_type_uint32(v, name, &value, errp);
> +}
> +
> +static void loongarch_set_pmnum(Object *obj, Visitor *v,
> +                                const char *name, void *opaque,
> +                                Error **errp)
> +{
> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
> +    uint32_t *value= opaque;
> +
> +    if (!visit_type_uint32(v, name, value, errp)) {
> +        return;
> +    }
> +    if ((*value <= PMNUM_MAX) && (*value > 0)) {
> +        cpu->env.cpucfg[6] = FIELD_DP32(cpu->env.cpucfg[6], CPUCFG6, PMNUM, *value -1);
> +    } else {
> +        error_report("Performance counter number need be in [1- %d]\n", PMNUM_MAX);
> +        exit(EXIT_FAILURE);
> +    }
> +}
> +
>   void loongarch_cpu_post_init(Object *obj)
>   {
>       LoongArchCPU *cpu = LOONGARCH_CPU(obj);
> @@ -655,6 +707,18 @@ void loongarch_cpu_post_init(Object *obj)
>           object_property_add_bool(obj, "lasx", loongarch_get_lasx,
>                                    loongarch_set_lasx);
>       }
> +
> +    if (kvm_enabled()) {
> +        object_property_add_bool(obj, "pmu", loongarch_get_pmu,
> +                                 loongarch_set_pmu);
> +        if (FIELD_EX32(cpu->env.cpucfg[6], CPUCFG6, PMP)) {
> +            uint32_t value = 4;
> +            object_property_add(obj, "pmnum", "uint32",
> +                                loongarch_get_pmnum,
> +                                loongarch_set_pmnum, NULL,
> +                                (void *)&value);
> +        }
> +    }
>   }
>   
>   static void loongarch_cpu_init(Object *obj)
> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> index bc75552d0f..a9f9020071 100644
> --- a/target/loongarch/kvm/kvm.c
> +++ b/target/loongarch/kvm/kvm.c
> @@ -556,6 +556,53 @@ static int kvm_check_cpucfg2(CPUState *cs)
>       return ret;
>   }
>   
> +static int kvm_check_cpucfg6(CPUState *cs)
> +{
> +    int ret;
> +    uint64_t val;
> +    struct kvm_device_attr attr = {
> +        .group = KVM_LOONGARCH_VCPU_CPUCFG,
> +        .attr = 6,
> +        .addr = (uint64_t)&val,
> +    };
> +    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
> +    CPULoongArchState *env = &cpu->env;
> +
> +    ret = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, &attr);
> +    if (!ret) {
> +        kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, &attr);
> +
> +        if (FIELD_EX32(env->cpucfg[6], CPUCFG6, PMP)) {
> +             /* Check PMP */
> +             if (!FIELD_EX32(val, CPUCFG6, PMP)) {
> +                 error_report("'pmu' feature not supported by KVM on this host"
> +                              " Please disable 'pmu' with "
> +                              "'... -cpu XXX,pmu=off ...'\n");
> +                 exit(EXIT_FAILURE);
> +             }
> +             /* Check PMNUM */
> +             int guest_pmnum = FIELD_EX32(env->cpucfg[6], CPUCFG6, PMNUM);
> +             int host_pmnum = FIELD_EX32(val, CPUCFG6, PMNUM);
> +             if (guest_pmnum > host_pmnum){
> +                 warn_report("The guest pmnum %d larger than KVM support %d\n",
> +                              guest_pmnum, host_pmnum);
It should report error and exit.
When VM migrates to physical machine with smaller pmu number, it should 
fail to migrate.

Regards
Bibo Mao
> +                 env->cpucfg[6] = FIELD_DP32(env->cpucfg[6], CPUCFG6,
> +                                             PMNUM, host_pmnum);
> +             }
> +             /* Check PMBITS */
> +             int guest_pmbits = FIELD_EX32(env->cpucfg[6], CPUCFG6, PMBITS);
> +             int host_pmbits = FIELD_EX32(val, CPUCFG6, PMBITS);
> +             if (guest_pmbits != host_pmbits) {
> +                 warn_report("The host not support PMBITS %d\n", guest_pmbits);
> +                 env->cpucfg[6] = FIELD_DP32(env->cpucfg[6], CPUCFG6,
> +                                             PMBITS, host_pmbits);
> +             }
> +        }
> +    }
> +
> +    return ret;
> +}
> +
>   static int kvm_loongarch_put_cpucfg(CPUState *cs)
>   {
>       int i, ret = 0;
> @@ -568,7 +615,13 @@ static int kvm_loongarch_put_cpucfg(CPUState *cs)
>               if (ret) {
>                   return ret;
>               }
> -	}
> +        }
> +        if (i == 6) {
> +            ret = kvm_check_cpucfg6(cs);
> +            if (ret) {
> +                return ret;
> +            }
> +        }
>           val = env->cpucfg[i];
>           ret = kvm_set_one_reg(cs, KVM_IOC_CPUCFG(i), &val);
>           if (ret < 0) {
> diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
> index 8721a5eb13..d7f2af363b 100644
> --- a/target/loongarch/loongarch-qmp-cmds.c
> +++ b/target/loongarch/loongarch-qmp-cmds.c
> @@ -40,7 +40,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
>   }
>   
>   static const char *cpu_model_advertised_features[] = {
> -    "lsx", "lasx", NULL
> +    "lsx", "lasx", "pmu", "pmnum", NULL
>   };
>   
>   CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
> 


