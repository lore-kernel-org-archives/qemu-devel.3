Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83130CA9ED0
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 02:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGSWE-0003ai-RT; Mon, 12 Oct 2026 22:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1xGSWB-0003aK-HX
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 22:45:31 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1xGSW9-0000A6-0V
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 22:45:30 -0400
Received: from loongson.cn (unknown [10.20.42.166])
 by gateway (Coremail) with SMTP id _____8AxHNJEm81q2DMVAA--.61735S3;
 Tue, 13 Oct 2026 10:45:24 +0800 (CST)
Received: from [10.20.42.166] (unknown [10.20.42.166])
 by front1 (Coremail) with SMTP id qMiowJDxRs1Cm81qOqorAA--.13632S2;
 Tue, 13 Oct 2026 10:45:23 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Add paravirt preempt feature
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <17746591750@163.com>
Cc: qemu-devel@nongnu.org
References: <20260921020333.570784-1-maobibo@loongson.cn>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <3f756668-efc7-3d9b-6445-563949dcd6c7@loongson.cn>
Date: Tue, 13 Oct 2026 10:43:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260921020333.570784-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJDxRs1Cm81qOqorAA--.13632S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxAF48GryUXry5Gr4xXF47trc_yoWrXr43pF
 W7ZFZakFW7G392kanxJ3Z8urn8GF4xCr4xXa43Ar1rAF4DGF4UZr1Ikr93KF1kX348XFWS
 vFn5Zr4Duan3J3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1QVy3UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.591,
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

Hi Bibo Mao:
> Paravirt preempt feature is OnOffAuto type, it is disabled by default,
> also the feature detection is added to check whether it is supported
> on KVM host.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu.h     |  2 ++
>   target/loongarch/kvm/kvm.c | 39 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 41 insertions(+)
>
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index c592f69885..c6dad2417c 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -302,6 +302,7 @@ enum loongarch_features {
>       LOONGARCH_FEATURE_STEALTIME,
>       LOONGARCH_FEATURE_PTW,
>       LOONGARCH_FEATURE_MSGINT,
> +    LOONGARCH_FEATURE_PV_PREEMPT,
>   };
>   
>   typedef struct  LoongArchBT {
> @@ -464,6 +465,7 @@ struct ArchCPU {
>       OnOffAuto msgint;
>       OnOffAuto kvm_pv_ipi;
>       OnOffAuto kvm_steal_time;
> +    OnOffAuto kvm_pv_preempt;
>       int32_t socket_id;  /* socket-id of this CPU */
>       int32_t core_id;    /* core-id of this CPU */
>       int32_t thread_id;  /* thread-id of this CPU */
> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> index 941142305e..7ca95181a1 100644
> --- a/target/loongarch/kvm/kvm.c
> +++ b/target/loongarch/kvm/kvm.c
> @@ -1039,6 +1039,12 @@ static bool kvm_feature_supported(CPUState *cs, enum loongarch_features feature)
>           ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
>           return (ret == 0);
>   
> +    case LOONGARCH_FEATURE_PV_PREEMPT:
> +        attr.group = KVM_LOONGARCH_VM_FEAT_CTRL;
> +        attr.attr = KVM_LOONGARCH_VM_FEAT_PV_PREEMPT,
> +        ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
> +        return (ret == 0);
> +
>       default:
>           return false;
>       }
> @@ -1203,6 +1209,21 @@ static int kvm_cpu_check_pv_features(CPUState *cs, Error **errp)
>           env->pv_features |= BIT(KVM_FEATURE_STEAL_TIME);
>       }
>   
> +    kvm_supported = kvm_feature_supported(cs, LOONGARCH_FEATURE_PV_PREEMPT);
> +    if (cpu->kvm_pv_preempt == ON_OFF_AUTO_ON) {
> +        if (!kvm_supported) {
> +            error_setg(errp, "'pv preempt' feature not supported by KVM host");
> +            return -ENOTSUP;
> +        }
> +    } else if (cpu->kvm_pv_preempt != ON_OFF_AUTO_AUTO) {
> +        kvm_supported = false;
> +    }
> +
> +    /* Feature preempt_hint depends on steal_time */
> +    if (kvm_supported && (cpu->kvm_pv_preempt == ON_OFF_AUTO_ON)) {
> +        env->pv_features |= BIT(KVM_FEATURE_PREEMPT);
> +     }
> +
>       if (object_dynamic_cast(OBJECT(ms), TYPE_LOONGARCH_VIRT_MACHINE)) {
>           LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
>   
> @@ -1412,6 +1433,18 @@ static void kvm_steal_time_set(Object *obj, bool value, Error **errp)
>       cpu->kvm_steal_time = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>   }
>   
> +static bool kvm_pv_preempt_get(Object *obj, Error **errp)
> +{
> +    return LOONGARCH_CPU(obj)->kvm_pv_preempt != ON_OFF_AUTO_OFF;
> +}
> +
> +static void kvm_pv_preempt_set(Object *obj, bool value, Error **errp)
> +{
> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
> +
> +    cpu->kvm_pv_preempt = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
> +}
> +
>   void kvm_loongarch_cpu_post_init(LoongArchCPU *cpu)
>   {
>       cpu->lbt = ON_OFF_AUTO_AUTO;
> @@ -1437,6 +1470,12 @@ void kvm_loongarch_cpu_post_init(LoongArchCPU *cpu)
>                                kvm_steal_time_set);
>       object_property_set_description(OBJECT(cpu), "kvm-steal-time",
>                                       "Set off to disable KVM steal time.");
> +
> +    cpu->kvm_pv_preempt = ON_OFF_AUTO_OFF;
> +    object_property_add_bool(OBJECT(cpu), "kvm-pv-preempt", kvm_pv_preempt_get,
> +                             kvm_pv_preempt_set);
> +    object_property_set_description(OBJECT(cpu), "kvm-pv-preempt",
> +                                    "Set off to disable KVM paravirt preempt.");
>   }
>   
>   int kvm_arch_destroy_vcpu(CPUState *cs)
>
> base-commit: c1c18d1e640b64292859ce9f30f3c344edfb0294
Reviewed-by:  Xianglai Li <lixianglai@loongson.cn>


