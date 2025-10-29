Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFE3CCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 03:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDxFW-0007sx-CF; Tue, 28 Oct 2025 23:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1vDxFT-0007ru-7y
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 23:53:23 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1vDxFN-00080h-2C
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 23:53:22 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxP9OjjwFpqeAbAA--.59098S3;
 Wed, 29 Oct 2025 11:53:07 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJDxrcGgjwFp_gwYAQ--.61919S3;
 Wed, 29 Oct 2025 11:53:06 +0800 (CST)
Subject: Re: [PATCH v2 2/2] target/loongarch: Add PTW feature support in KVM
 mode
To: Bibo Mao <maobibo@loongson.cn>, "Michael S . Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20251027024347.3315592-1-maobibo@loongson.cn>
 <20251027024347.3315592-3-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <91a72c0a-4e4d-08f8-623c-50dbb1c98f26@loongson.cn>
Date: Wed, 29 Oct 2025 11:53:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20251027024347.3315592-3-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJDxrcGgjwFp_gwYAQ--.61919S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAF48uw1kCw45ZFyDGF4Utrc_yoWrXFWrpr
 W7AFs09rWUtrZxA3ZxXas09r45Jr4xGrW2va43Cry8AFn8WFyUXFykKFsIqF98A34rXFyI
 vF4rZFs8ua17twbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzZ2-UUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-3.159, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

ÔÚ 2025/10/27 ÉÏÎç10:43, Bibo Mao Ð´µÀ:
> Implement Hardware page table walker(PTW for short) feature in KVM mode.
> Use OnOffAuto type variable ptw to check the PTW feature. If the PTW
> feature is not supported on KVM host, there is error reported with ptw=on
> option.
>
> By default PTW feature is disabled on la464 CPU type, and auto detected
> on max CPU type.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu.c     |  6 +++---
>   target/loongarch/cpu.h     |  1 +
>   target/loongarch/kvm/kvm.c | 35 +++++++++++++++++++++++++++++++++++
>   3 files changed, 39 insertions(+), 3 deletions(-)
>
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index e80a92fb2e..d74c3c3766 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -236,7 +236,7 @@ static void loongarch_set_ptw(Object *obj, bool value, Error **errp)
>       cpu->ptw = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>   
>       if (kvm_enabled()) {
> -        /* PTW feature is only support in TCG mode now */
> +        /* kvm feature detection in function kvm_arch_init_vcpu */
>           return;
>       }
>   
> @@ -406,14 +406,14 @@ static void loongarch_la132_initfn(Object *obj)
>   static void loongarch_max_initfn(Object *obj)
>   {
>       LoongArchCPU *cpu = LOONGARCH_CPU(obj);
> -    /* '-cpu max' for TCG: we use cpu la464. */
> +    /* '-cpu max': use it for max supported CPU features */
>       loongarch_la464_initfn(obj);
>   
> +    cpu->ptw = ON_OFF_AUTO_AUTO;
>       if (tcg_enabled()) {
>           cpu->env.cpucfg[1] = FIELD_DP32(cpu->env.cpucfg[1], CPUCFG1, MSG_INT, 1);
>           cpu->msgint = ON_OFF_AUTO_AUTO;
>           cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, HPTW, 1);
> -        cpu->ptw = ON_OFF_AUTO_AUTO;
>       }
>   }
>   
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index b1d6799222..1a14469b3b 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -279,6 +279,7 @@ enum loongarch_features {
>       LOONGARCH_FEATURE_PMU,
>       LOONGARCH_FEATURE_PV_IPI,
>       LOONGARCH_FEATURE_STEALTIME,
> +    LOONGARCH_FEATURE_PTW,
>   };
>   
>   typedef struct  LoongArchBT {
> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> index 4e4f4e79f6..26e40c9bdc 100644
> --- a/target/loongarch/kvm/kvm.c
> +++ b/target/loongarch/kvm/kvm.c
> @@ -931,6 +931,12 @@ static bool kvm_feature_supported(CPUState *cs, enum loongarch_features feature)
>           ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
>           return (ret == 0);
>   
> +    case LOONGARCH_FEATURE_PTW:
> +        attr.group = KVM_LOONGARCH_VM_FEAT_CTRL;
> +        attr.attr = KVM_LOONGARCH_VM_FEAT_PTW;
> +        ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
> +        return (ret == 0);
> +
>       default:
>           return false;
>       }
> @@ -1029,6 +1035,29 @@ static int kvm_cpu_check_pmu(CPUState *cs, Error **errp)
>       return 0;
>   }
>   
> +static int kvm_cpu_check_ptw(CPUState *cs, Error **errp)
> +{
> +    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
> +    CPULoongArchState *env = cpu_env(cs);
> +    bool kvm_supported;
> +
> +    kvm_supported = kvm_feature_supported(cs, LOONGARCH_FEATURE_PTW);
> +    if (cpu->ptw == ON_OFF_AUTO_ON) {
> +        if (!kvm_supported) {
> +            error_setg(errp, "'ptw' feature not supported by KVM on the host");
> +            return -ENOTSUP;
> +        }
> +    } else if (cpu->ptw != ON_OFF_AUTO_AUTO) {
> +        /* disable pmu if ON_OFF_AUTO_OFF is set */
it shoud be 'disable ptw'.

Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> +        kvm_supported = false;
> +    }
> +
> +    if (kvm_supported) {
> +        env->cpucfg[2] = FIELD_DP32(env->cpucfg[2], CPUCFG2, HPTW, 1);
> +    }
> +    return 0;
> +}
> +
>   static int kvm_cpu_check_pv_features(CPUState *cs, Error **errp)
>   {
>       MachineState *ms = MACHINE(qdev_get_machine());
> @@ -1123,6 +1152,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
>           return ret;
>       }
>   
> +    ret = kvm_cpu_check_ptw(cs, &local_err);
> +    if (ret < 0) {
> +        error_report_err(local_err);
> +        return ret;
> +    }
> +
>       return 0;
>   }
>   


