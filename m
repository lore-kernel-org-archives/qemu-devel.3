Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64B7CD343B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 06:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKsYh-0000yj-4U; Thu, 07 May 2026 02:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wKsYa-0000xj-WD
 for qemu-devel@nongnu.org; Thu, 07 May 2026 02:50:01 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wKsYW-00066J-0r
 for qemu-devel@nongnu.org; Thu, 07 May 2026 02:50:00 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Cx3sD7NPxp7mMHAA--.218S3;
 Thu, 07 May 2026 14:45:16 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCxHOH5NPxpxxx8AA--.39515S3;
 Thu, 07 May 2026 14:45:13 +0800 (CST)
Subject: Re: [PATCH 3/4] target/loongarch: Add kvm support dintc
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, lixianglai@loongson.cn, chenhuacai@loongson.cn
References: <20260427070029.1059386-1-gaosong@loongson.cn>
 <20260427070029.1059386-4-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <931bd5c5-6445-7bfe-acc3-04111edb3259@loongson.cn>
Date: Thu, 7 May 2026 14:42:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260427070029.1059386-4-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxHOH5NPxpxxx8AA--.39515S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3JFWUtFW3WF4fKr1UAF15ZFc_yoW7WrWfpr
 srAFZ0gFWUtFZrA3Z3XF9Y9r13Xr4xKw429FyxGry2yF1DWrWUXF18KanxJFy5C3s5uFWS
 vF4rAanxuanrJacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CP
 fJUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.736,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2026/4/27 下午3:00, Song Gao wrote:
> This patch adds Kvm put/get msgint CSRs and check msgint feature.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/cpu.c     |  5 ++-
>   target/loongarch/cpu.h     |  1 +
>   target/loongarch/kvm/kvm.c | 69 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 72 insertions(+), 3 deletions(-)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index e22568c84a..fe60c9b92b 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -443,9 +443,6 @@ static void loongarch_max_initfn(Object *obj)
>   
>       cpu->ptw = ON_OFF_AUTO_AUTO;
>       if (tcg_enabled()) {
> -        cpu->env.cpucfg[1] = FIELD_DP32(cpu->env.cpucfg[1], CPUCFG1, MSG_INT, 1);
> -        cpu->msgint = ON_OFF_AUTO_AUTO;
> -
>           uint32_t data = cpu->env.cpucfg[2];
>           data = FIELD_DP32(data, CPUCFG2, HPTW, 1);
>           /* Enable LA v1.1 instructions */
> @@ -456,6 +453,8 @@ static void loongarch_max_initfn(Object *obj)
>           data = FIELD_DP32(data, CPUCFG2, SCQ, 1);
>           cpu->env.cpucfg[2] = data;
>       }
> +    cpu->env.cpucfg[1] = FIELD_DP32(cpu->env.cpucfg[1], CPUCFG1, MSG_INT, 1);
> +    cpu->msgint = ON_OFF_AUTO_AUTO;
>   }
>   
>   #if defined(CONFIG_KVM)
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 4d333806ed..edd840fbed 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -302,6 +302,7 @@ enum loongarch_features {
>       LOONGARCH_FEATURE_PV_IPI,
>       LOONGARCH_FEATURE_STEALTIME,
>       LOONGARCH_FEATURE_PTW,
> +    LOONGARCH_FEATURE_MSGINT,
>   };
>   
>   typedef struct  LoongArchBT {
> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> index 9d844c4905..e32e5f1274 100644
> --- a/target/loongarch/kvm/kvm.c
> +++ b/target/loongarch/kvm/kvm.c
> @@ -35,6 +35,13 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
>       KVM_CAP_LAST_INFO
>   };
>   
> +static bool msgint_needed(CPUState *cs)
rename it as kvm_cpu_has_msgint()?

> +{
> +    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
> +
> +    return FIELD_EX64(cpu->env.cpucfg[1], CPUCFG1, MSG_INT);
> +}
> +
>   static int kvm_get_stealtime(CPUState *cs)
>   {
>       CPULoongArchState *env = cpu_env(cs);
> @@ -358,6 +365,20 @@ static int kvm_loongarch_get_csr(CPUState *cs)
>   
>       ret |= kvm_loongarch_get_pmu(cs);
>   
> +    if (msgint_needed(cs)) {
> +        ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(0)),
> +                               &env->CSR_MSGIS[0]);
> +
> +        ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(1)),
> +                               &env->CSR_MSGIS[1]);
> +
> +        ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(2)),
> +                               &env->CSR_MSGIS[2]);
> +
> +        ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(3)),
> +                               &env->CSR_MSGIS[3]);
> +    }
> +
>       ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TVAL),
>                              &env->CSR_TVAL);
>   
> @@ -533,6 +554,20 @@ static int kvm_loongarch_put_csr(CPUState *cs, KvmPutState level)
>   
>       ret |= kvm_loongarch_put_pmu(cs);
>   
> +    if (msgint_needed(cs)) {
> +        ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(0)),
> +                               &env->CSR_MSGIS[0]);
> +
> +        ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(1)),
> +                               &env->CSR_MSGIS[1]);
> +
> +        ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(2)),
> +                               &env->CSR_MSGIS[2]);
> +
> +        ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(3)),
> +                               &env->CSR_MSGIS[3]);
> +    }
> +
>       /*
>        * timer cfg must be put at last since it is used to enable
>        * guest timer
> @@ -982,6 +1017,12 @@ static bool kvm_feature_supported(CPUState *cs, enum loongarch_features feature)
>           ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
>           return (ret == 0);
>   
> +    case LOONGARCH_FEATURE_MSGINT:
> +        attr.group = KVM_LOONGARCH_VM_FEAT_CTRL;
> +        attr.attr = KVM_LOONGARCH_VM_FEAT_MSGINT;
> +        ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
> +        return (ret == 0);
> +
>       default:
>           return false;
>       }
> @@ -1155,6 +1196,28 @@ static int kvm_cpu_check_pv_features(CPUState *cs, Error **errp)
>       return 0;
>   }
>   
> +static int kvm_cpu_check_msgint(CPUState *cs, Error **errp)
> +{
> +    CPULoongArchState *env = cpu_env(cs);
> +    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
> +    bool kvm_supported;
> +
> +    kvm_supported = kvm_feature_supported(cs, LOONGARCH_FEATURE_MSGINT);
> +    env->cpucfg[1] = FIELD_DP32(env->cpucfg[1], CPUCFG1, MSG_INT, 0);
> +    if (cpu->msgint == ON_OFF_AUTO_ON) {
> +        if (kvm_supported) {
> +            env->cpucfg[1] = FIELD_DP32(env->cpucfg[1], CPUCFG1, MSG_INT, 1);
> +        } else {
> +            error_setg(errp, "'msgint' feature not supported by KVM on this host");
> +            return -ENOTSUP;
> +        }
> +    } else if ((cpu->msgint == ON_OFF_AUTO_AUTO) && kvm_supported) {
> +        env->cpucfg[1] = FIELD_DP32(env->cpucfg[1], CPUCFG1, MSG_INT, 1);
> +    }
> +
> +    return 0;
> +}
> +
>   int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
>   {
>       return 0;
> @@ -1210,6 +1273,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
>           return ret;
>       }
>   
> +    ret = kvm_cpu_check_msgint(cs, &local_err);
> +    if (ret < 0) {
if (ret) rather than (ret < 0)

Regards
Bibo Mao
> +        error_report_err(local_err);
> +        return ret;
> +    }
> +
>       return 0;
>   }
>   
> 


