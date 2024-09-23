Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2623CF9C69
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 12:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssiL6-0002ML-QD; Mon, 23 Sep 2024 08:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1ssiKz-0002J8-Ge
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 08:38:45 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1ssiKw-00069I-Ad
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 08:38:45 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxaelOYfFmuTsNAA--.29524S3;
 Mon, 23 Sep 2024 20:38:38 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front2 (Coremail) with SMTP id qciowMAxKsZKYfFmdpYPAA--.64134S3;
 Mon, 23 Sep 2024 20:38:36 +0800 (CST)
Subject: Re: [PATCH] target/loongarch/kvm: Implement LoongArch PMU extension
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20240918082315.2345034-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <2ba35b34-1d41-a3b3-786b-0dfdf17da361@loongson.cn>
Date: Mon, 23 Sep 2024 20:39:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240918082315.2345034-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qciowMAxKsZKYfFmdpYPAA--.64134S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3GFyxZw1DJFy8ur4fZr4fZwc_yoW7CFyrpr
 43ZFZ8GrW8trZ7Jan3Xas8Wrs8Xr4xGrZFqa4ayryxAFs8XF17Zry8t39IgFs8Aw1rWFWS
 qF1F9Fs8uanrJwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1QV
 y3UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.417, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

ÔÚ 2024/9/18 ÏÂÎç4:23, Bibo Mao Ð´µÀ:
> Implement PMU extension for LoongArch kvm mode. Use OnOffAuto type
> variable pmu to check the PMU feature. If the PMU Feature is not supported
> with KVM host, it reports error if there is pmu=on command line.
>
> If there is no any command line about pmu parameter, it checks whether
> KVM host supports the PMU Feature and set the corresponding value in cpucfg.
>
> This patch is based on lbt patch located at
>    https://lore.kernel.org/qemu-devel/20240904061859.86615-1-maobibo@loongson.cn
>
> Co-developed-by: Song Gao <gaosong@loongson.cn>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu.c                | 19 +++++++++++++
>   target/loongarch/cpu.h                |  2 ++
>   target/loongarch/kvm/kvm.c            | 41 +++++++++++++++++++++++++++
>   target/loongarch/loongarch-qmp-cmds.c |  2 +-
>   4 files changed, 63 insertions(+), 1 deletion(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 29577e6b71..57cc4f314b 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -676,6 +676,18 @@ static void loongarch_set_lbt(Object *obj, bool value, Error **errp)
>       cpu->lbt = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>   }
>   
> +static bool loongarch_get_pmu(Object *obj, Error **errp)
> +{
> +    return LOONGARCH_CPU(obj)->pmu != ON_OFF_AUTO_OFF;
> +}
> +
> +static void loongarch_set_pmu(Object *obj, bool value, Error **errp)
> +{
> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
> +
> +    cpu->pmu = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
> +}
> +
>   void loongarch_cpu_post_init(Object *obj)
>   {
>       LoongArchCPU *cpu = LOONGARCH_CPU(obj);
> @@ -691,6 +703,13 @@ void loongarch_cpu_post_init(Object *obj)
>                                    loongarch_set_lbt);
>           object_property_set_description(obj, "lbt",
>                                      "Set off to disable Binary Tranlation.");
> +
> +        cpu->pmu = ON_OFF_AUTO_AUTO;
> +        object_property_add_bool(obj, "pmu", loongarch_get_pmu,
> +                                 loongarch_set_pmu);
> +        object_property_set_description(obj, "pmu",
> +                                   "Set off to performance monitor unit.");
> +
>       } else {
>           cpu->lbt = ON_OFF_AUTO_OFF;
>       }
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 0d0a5a58a8..95336f9e6f 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -284,6 +284,7 @@ typedef struct LoongArchTLB LoongArchTLB;
>   
>   enum loongarch_features {
>       LOONGARCH_FEATURE_LBT, /* loongson binary translation extension */
> +    LOONGARCH_FEATURE_PMU,
>   };
>   
>   typedef struct  LoongArchBT {
> @@ -399,6 +400,7 @@ struct ArchCPU {
>       QEMUTimer timer;
>       uint32_t  phy_id;
>       OnOffAuto lbt;
> +    OnOffAuto pmu;
>   
>       /* 'compatible' string for this CPU for Linux device trees */
>       const char *dtb_compatible;
> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> index 208d090f21..eff9a89af3 100644
> --- a/target/loongarch/kvm/kvm.c
> +++ b/target/loongarch/kvm/kvm.c
> @@ -748,9 +748,18 @@ static bool kvm_feature_supported(CPUState *cs, enum loongarch_features feature)
>           attr.attr = KVM_LOONGARCH_VM_FEAT_MIPSBT;
>           ret |= kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
>           return (ret == 0);
> +
> +    case LOONGARCH_FEATURE_PMU:
> +        attr.group = KVM_LOONGARCH_VM_FEAT_CTRL;
> +        attr.attr = KVM_LOONGARCH_VM_FEAT_PMU;
> +        ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
> +        return (ret == 0);
> +
>       default:
>           return false;
>       }
> +
> +    return false;
>   }
>   
>   static int kvm_cpu_check_lbt(CPUState *cs, Error **errp)
> @@ -774,6 +783,32 @@ static int kvm_cpu_check_lbt(CPUState *cs, Error **errp)
>       return 0;
>   }
>   
> +static int kvm_cpu_check_pmu(CPUState *cs, Error **errp)
> +{
> +    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
> +    CPULoongArchState *env = cpu_env(cs);
> +    bool kvm_supported;
> +
> +    kvm_supported = kvm_feature_supported(cs, LOONGARCH_FEATURE_PMU);
> +    if (cpu->pmu == ON_OFF_AUTO_ON) {
> +        if (!kvm_supported) {
> +            error_setg(errp, "'pmu' feature not supported by KVM on the host");
> +            return -ENOTSUP;
> +        }
> +    } else if (cpu->pmu != ON_OFF_AUTO_AUTO) {
> +        /* disable pmu if ON_OFF_AUTO_OFF is set */
> +        kvm_supported = false;
> +    }
> +
> +    if (kvm_supported) {
> +        env->cpucfg[6] = FIELD_DP32(env->cpucfg[6], CPUCFG6, PMP, 1);
> +        env->cpucfg[6] = FIELD_DP32(env->cpucfg[6], CPUCFG6, PMNUM, 3);
> +        env->cpucfg[6] = FIELD_DP32(env->cpucfg[6], CPUCFG6, PMBITS, 63);
> +        env->cpucfg[6] = FIELD_DP32(env->cpucfg[6], CPUCFG6, UPM, 1);
> +    }
> +    return 0;
> +}
> +
>   int kvm_arch_init_vcpu(CPUState *cs)
>   {
>       uint64_t val;
> @@ -791,6 +826,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
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
> diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
> index c6f6e1ef85..782fd511fd 100644
> --- a/target/loongarch/loongarch-qmp-cmds.c
> +++ b/target/loongarch/loongarch-qmp-cmds.c
> @@ -40,7 +40,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
>   }
>   
>   static const char *cpu_model_advertised_features[] = {
> -    "lsx", "lasx", "lbt", NULL
> +    "lsx", "lasx", "lbt", "pmu", NULL
>   };
>   
>   CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>
> base-commit: 2b81c046252fbfb375ad30632362fc16e6e22bd5


