Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1580DC5B574
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 08:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wthWY-0004Is-Ev; Tue, 11 Aug 2026 04:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wthWT-0004Ia-F1
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:07:47 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wthWQ-0004VZ-Cr
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:07:45 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxdvA82Hpq7xsAAA--.442S3;
 Tue, 11 Aug 2026 16:07:25 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJAx3c442HpqnVUAAA--.2144S2;
 Tue, 11 Aug 2026 16:07:22 +0800 (CST)
Subject: Re: [PATCH v3 2/4] target/loongarch: Add kvm support dintc
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, lixianglai@loongson.cn, chenhuacai@loongson.cn
References: <20260525084645.3328690-1-gaosong@loongson.cn>
 <20260525084645.3328690-3-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <8b2ce6dc-cc47-4056-a0f7-f8da469b5657@loongson.cn>
Date: Tue, 11 Aug 2026 16:07:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260525084645.3328690-3-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAx3c442HpqnVUAAA--.2144S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3JFWUtFW5XrW7ZF4DJryrAFc_yoW7Zw1xpr
 ZxAFZ09FWUtFZrA3Z3XF9Y9r13Xr4xKw429FyxGrySyF1DWryUXF18KanxJFy5A3s5uFyS
 vF4rCF43uanrJacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.998,
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



On 2026/5/25 下午4:46, Song Gao wrote:
> This patch adds Kvm put/get msgint CSRs and check msgint feature.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/cpu.c     |  5 ++-
>   target/loongarch/cpu.h     |  1 +
>   target/loongarch/kvm/kvm.c | 74 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 77 insertions(+), 3 deletions(-)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 8f277f7696..64f437fcba 100644
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
> @@ -460,6 +457,8 @@ static void loongarch_max_initfn(Object *obj)
>           data = FIELD_DP32(data, CPUCFG3, DBAR_HINTS, 1);
>           cpu->env.cpucfg[3] = data;
>       }
> +    cpu->env.cpucfg[1] = FIELD_DP32(cpu->env.cpucfg[1], CPUCFG1, MSG_INT, 1);
> +    cpu->msgint = ON_OFF_AUTO_AUTO;
>   }
>   
>   #if defined(CONFIG_KVM)
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 096d778928..e6bbcded95 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -301,6 +301,7 @@ enum loongarch_features {
>       LOONGARCH_FEATURE_PV_IPI,
>       LOONGARCH_FEATURE_STEALTIME,
>       LOONGARCH_FEATURE_PTW,
> +    LOONGARCH_FEATURE_MSGINT,
>   };
>   
>   typedef struct  LoongArchBT {
> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> index 4af4ab2ed0..af08f551a0 100644
> --- a/target/loongarch/kvm/kvm.c
> +++ b/target/loongarch/kvm/kvm.c
> @@ -36,6 +36,13 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
>       KVM_CAP_LAST_INFO
>   };
>   
> +static bool kvm_cpu_has_msgint(CPUState *cs)
> +{
> +    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
> +
> +    return FIELD_EX64(cpu->env.cpucfg[1], CPUCFG1, MSG_INT);
> +}
> +
>   static int kvm_get_stealtime(CPUState *cs)
>   {
>       CPULoongArchState *env = cpu_env(cs);
> @@ -359,6 +366,25 @@ static int kvm_loongarch_get_csr(CPUState *cs)
>   
>       ret |= kvm_loongarch_get_pmu(cs);
>   
> +    /*
> +     * CSR register MSGIS getting must be put after CSR register CSR_ESTAT,
> +     * Since register CSR_ESTAT will sync software pending MSGINT status to
> +     * hardware register and modify HW CSR MSGIS registers.
> +     */
> +    if (kvm_cpu_has_msgint(cs)) {
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
> @@ -534,6 +560,20 @@ static int kvm_loongarch_put_csr(CPUState *cs, KvmPutState level)
>   
>       ret |= kvm_loongarch_put_pmu(cs);
>   
> +    if (kvm_cpu_has_msgint(cs)) {
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
> @@ -983,6 +1023,12 @@ static bool kvm_feature_supported(CPUState *cs, enum loongarch_features feature)
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
> @@ -1156,6 +1202,28 @@ static int kvm_cpu_check_pv_features(CPUState *cs, Error **errp)
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
> @@ -1211,6 +1279,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
>           return ret;
>       }
>   
> +    ret = kvm_cpu_check_msgint(cs, &local_err);
> +    if (ret < 0) {
> +        error_report_err(local_err);
> +        return ret;
> +    }
> +
>       return 0;
>   }
>   
> 
With netperf test, linux kernel need disable irqbalance, else there is 
error reporting from kernel avec driver.
    Unexpected IRQ occurs on CPU#0 [vector 21]
It seems it is the problem of linux kernel avec driver.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>


