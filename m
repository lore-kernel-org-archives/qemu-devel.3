Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A887C27C75
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 09:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI3MQ-0006q9-Cr; Fri, 14 Jun 2024 05:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sI3MO-0006pk-JK
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 05:36:40 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sI3ML-0007xO-Hg
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 05:36:40 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Dx2OkeD2xmYtkGAA--.14962S3;
 Fri, 14 Jun 2024 17:36:32 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxWcYeD2xmHQwgAA--.13152S3; 
 Fri, 14 Jun 2024 17:36:30 +0800 (CST)
Subject: Re: [PATCH v3] target/loongarch/kvm: Add software breakpoint support
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20240607035016.2975799-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <9b1f2238-dc57-6c8b-1630-61615c58ea8b@loongson.cn>
Date: Fri, 14 Jun 2024 17:35:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240607035016.2975799-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxWcYeD2xmHQwgAA--.13152S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWr1fCFWrKF47JFy7Kr4fCrX_yoWruw1fpF
 W3ZFn5Gr48t39rJw1fJa4qvFsxArs7WwnrXFyfKrySkw4DtrnxZr1kK39rAFWfu34jgFyF
 vF1SgF129F4DtrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CP
 fJUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.395, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

ÔÚ 2024/6/7 ÉÏÎç11:50, Bibo Mao Ð´µÀ:
> With KVM virtualization, debug exception is injected to guest kernel
> rather than host for normal break intruction. Here hypercall
> instruction with special code is used for sw breakpoint usage,
> and detailed instruction comes from kvm kernel with user API
> KVM_REG_LOONGARCH_DEBUG_INST.
>
> Now only software breakpoint is supported, and it is allowed to
> insert/remove software breakpoint. We can debug guest kernel with gdb
> method after kernel is loaded, hardware breakpoint will be added in later.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
Reviewed-by: Song Gao <gaosong@loongson.cn>
Tested-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> v2 ... v3:
>    1. Refresh patch based on the latest version, succeed in compile and
> run since kvm uapi header files is updated.
> v1 ... v2:
>    1. Enable TARGET_KVM_HAVE_GUEST_DEBUG on loongarch64 platform
> ---
>   configs/targets/loongarch64-softmmu.mak |  1 +
>   target/loongarch/kvm/kvm.c              | 76 +++++++++++++++++++++++++
>   2 files changed, 77 insertions(+)
>
> diff --git a/configs/targets/loongarch64-softmmu.mak b/configs/targets/loongarch64-softmmu.mak
> index 84beb19b90..65b65e0c34 100644
> --- a/configs/targets/loongarch64-softmmu.mak
> +++ b/configs/targets/loongarch64-softmmu.mak
> @@ -1,5 +1,6 @@
>   TARGET_ARCH=loongarch64
>   TARGET_BASE_ARCH=loongarch
> +TARGET_KVM_HAVE_GUEST_DEBUG=y
>   TARGET_SUPPORTS_MTTCG=y
>   TARGET_XML_FILES= gdb-xml/loongarch-base32.xml gdb-xml/loongarch-base64.xml gdb-xml/loongarch-fpu.xml
>   # all boards require libfdt
> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> index 8e6e27c8bf..e1be6a6959 100644
> --- a/target/loongarch/kvm/kvm.c
> +++ b/target/loongarch/kvm/kvm.c
> @@ -28,6 +28,7 @@
>   #include "trace.h"
>   
>   static bool cap_has_mp_state;
> +static unsigned int brk_insn;
>   const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
>       KVM_CAP_LAST_INFO
>   };
> @@ -664,7 +665,14 @@ static void kvm_loongarch_vm_stage_change(void *opaque, bool running,
>   
>   int kvm_arch_init_vcpu(CPUState *cs)
>   {
> +    uint64_t val;
> +
>       qemu_add_vm_change_state_handler(kvm_loongarch_vm_stage_change, cs);
> +
> +    if (!kvm_get_one_reg(cs, KVM_REG_LOONGARCH_DEBUG_INST, &val)) {
> +        brk_insn = val;
> +    }
> +
>       return 0;
>   }
>   
> @@ -739,6 +747,67 @@ bool kvm_arch_stop_on_emulation_error(CPUState *cs)
>       return true;
>   }
>   
> +void kvm_arch_update_guest_debug(CPUState *cpu, struct kvm_guest_debug *dbg)
> +{
> +    if (kvm_sw_breakpoints_active(cpu)) {
> +        dbg->control |= KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP;
> +    }
> +}
> +
> +int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
> +{
> +    if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 0) ||
> +        cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&brk_insn, 4, 1)) {
> +        error_report("%s failed", __func__);
> +        return -EINVAL;
> +    }
> +    return 0;
> +}
> +
> +int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
> +{
> +    static uint32_t brk;
> +
> +    if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&brk, 4, 0) ||
> +        brk != brk_insn ||
> +        cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 1)) {
> +        error_report("%s failed", __func__);
> +        return -EINVAL;
> +    }
> +    return 0;
> +}
> +
> +int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
> +{
> +    return -ENOSYS;
> +}
> +
> +int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
> +{
> +    return -ENOSYS;
> +}
> +
> +void kvm_arch_remove_all_hw_breakpoints(void)
> +{
> +}
> +
> +static bool kvm_loongarch_handle_debug(CPUState *cs, struct kvm_run *run)
> +{
> +    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
> +    CPULoongArchState *env = &cpu->env;
> +
> +    kvm_cpu_synchronize_state(cs);
> +    if (cs->singlestep_enabled) {
> +        return true;
> +    }
> +
> +    if (kvm_find_sw_breakpoint(cs, env->pc)) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
>   int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>   {
>       int ret = 0;
> @@ -757,6 +826,13 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>                            run->iocsr_io.len,
>                            run->iocsr_io.is_write);
>           break;
> +
> +    case KVM_EXIT_DEBUG:
> +        if (kvm_loongarch_handle_debug(cs, run)) {
> +            ret = EXCP_DEBUG;
> +        }
> +        break;
> +
>       default:
>           ret = -1;
>           warn_report("KVM: unknown exit reason %d", run->exit_reason);
>
> base-commit: dec9742cbc59415a8b83e382e7ae36395394e4bd


