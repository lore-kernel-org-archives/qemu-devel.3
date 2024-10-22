Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4187CD2C547
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 12:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3E82-0002L6-Rh; Tue, 22 Oct 2024 08:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1t3E7t-0002G2-Ib
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 08:36:41 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1t3E7q-0001BL-9g
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 08:36:40 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxLOJPnBdnwzIFAA--.12290S3;
 Tue, 22 Oct 2024 20:36:32 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMBx_uBPnBdnLc8HAA--.45889S3;
 Tue, 22 Oct 2024 20:36:31 +0800 (CST)
Subject: Re: [PATCH v2] target/loongarch: Add steal time support on migration
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20240930064040.753929-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <b21e4ae3-3e91-6f15-197e-38eacd77cee2@loongson.cn>
Date: Tue, 22 Oct 2024 20:37:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240930064040.753929-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMBx_uBPnBdnLc8HAA--.45889S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWw4Utr48CrW3tr17AFyUCFX_yoWrZr48pr
 ZrCFn0grW8KrZ3A3WxX34DWFn8uw1xGr429Fy3Kr9akF4DXwsF9F10ywsFgF4rA34UGw4I
 qF1Sk345ua1jv3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqW
 UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.475, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

ÔÚ 2024/9/30 ÏÂÎç2:40, Bibo Mao Ð´µÀ:
> With pv steal time supported, VM machine needs get physical address
> of each vcpu and notify new host during migration. Here two
> functions kvm_get_stealtime/kvm_set_stealtime, and guest steal time
> physical address is only updated on KVM_PUT_FULL_STATE stage.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
> v1 ... v2:
>    1. Call function kvm_set_stealtime() at kvm_arch_put_registers()
>       rather than new added cpu_post_load() interface
>
> ---
>   target/loongarch/cpu.h     |  3 ++
>   target/loongarch/kvm/kvm.c | 65 ++++++++++++++++++++++++++++++++++++++
>   target/loongarch/machine.c |  6 ++--
>   3 files changed, 72 insertions(+), 2 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 6c41fafb70..c99b72ae16 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -346,6 +346,9 @@ typedef struct CPUArchState {
>       uint64_t CSR_DBG;
>       uint64_t CSR_DERA;
>       uint64_t CSR_DSAVE;
> +    struct {
> +        uint64_t guest_addr;
> +    } stealtime;
>   
>   #ifdef CONFIG_TCG
>       float_status fp_status;
> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> index 4786cd5efa..27d4a2783b 100644
> --- a/target/loongarch/kvm/kvm.c
> +++ b/target/loongarch/kvm/kvm.c
> @@ -33,6 +33,55 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
>       KVM_CAP_LAST_INFO
>   };
>   
> +static int kvm_get_stealtime(CPUState *cs)
> +{
> +    CPULoongArchState *env = cpu_env(cs);
> +    int err;
> +    struct kvm_device_attr attr = {
> +        .group = KVM_LOONGARCH_VCPU_PVTIME_CTRL,
> +        .attr = KVM_LOONGARCH_VCPU_PVTIME_GPA,
> +        .addr = (uint64_t)&env->stealtime.guest_addr,
> +    };
> +
> +    err = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, attr);
> +    if (err) {
> +        return 0;
> +    }
> +
> +    err = kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, attr);
> +    if (err) {
> +        error_report("PVTIME: KVM_GET_DEVICE_ATTR: %s", strerror(errno));
> +        return err;
> +    }
> +
> +    return 0;
> +}
> +
> +static int kvm_set_stealtime(CPUState *cs)
> +{
> +    CPULoongArchState *env = cpu_env(cs);
> +    int err;
> +    struct kvm_device_attr attr = {
> +        .group = KVM_LOONGARCH_VCPU_PVTIME_CTRL,
> +        .attr = KVM_LOONGARCH_VCPU_PVTIME_GPA,
> +        .addr = (uint64_t)&env->stealtime.guest_addr,
> +    };
> +
> +    err = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, attr);
> +    if (err) {
> +        return 0;
> +    }
> +
> +    err = kvm_vcpu_ioctl(cs, KVM_SET_DEVICE_ATTR, attr);
> +    if (err) {
> +        error_report("PVTIME: KVM_SET_DEVICE_ATTR %s with gpa "TARGET_FMT_lx,
> +                      strerror(errno), env->stealtime.guest_addr);
> +        return err;
> +    }
> +
> +    return 0;
> +}
> +
>   static int kvm_loongarch_get_regs_core(CPUState *cs)
>   {
>       int ret = 0;
> @@ -612,6 +661,11 @@ int kvm_arch_get_registers(CPUState *cs)
>           return ret;
>       }
>   
> +    ret = kvm_get_stealtime(cs);
> +    if (ret) {
> +        return ret;
> +    }
> +
>       ret = kvm_loongarch_get_mpstate(cs);
>       return ret;
>   }
> @@ -640,6 +694,17 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>           return ret;
>       }
>   
> +    if (level >= KVM_PUT_FULL_STATE) {
> +        /*
> +         * only KVM_PUT_FULL_STATE is required, kvm kernel will clear
> +         * guest_addr for KVM_PUT_RESET_STATE
> +         */
> +        ret = kvm_set_stealtime(cs);
> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +
>       ret = kvm_loongarch_put_mpstate(cs);
>       return ret;
>   }
> diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
> index 08a7fa5370..0b6f4f5551 100644
> --- a/target/loongarch/machine.c
> +++ b/target/loongarch/machine.c
> @@ -145,8 +145,8 @@ static const VMStateDescription vmstate_tlb = {
>   /* LoongArch CPU state */
>   const VMStateDescription vmstate_loongarch_cpu = {
>       .name = "cpu",
> -    .version_id = 2,
> -    .minimum_version_id = 2,
> +    .version_id = 3,
> +    .minimum_version_id = 3,
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINTTL_ARRAY(env.gpr, LoongArchCPU, 32),
>           VMSTATE_UINTTL(env.pc, LoongArchCPU),
> @@ -209,6 +209,8 @@ const VMStateDescription vmstate_loongarch_cpu = {
>           VMSTATE_UINT64(env.CSR_DSAVE, LoongArchCPU),
>   
>           VMSTATE_UINT64(kvm_state_counter, LoongArchCPU),
> +        /* PV steal time */
> +        VMSTATE_UINT64(env.stealtime.guest_addr, LoongArchCPU),
>   
>           VMSTATE_END_OF_LIST()
>       },
>
> base-commit: 3b14a767eaca3df5534a162851f04787b363670e


