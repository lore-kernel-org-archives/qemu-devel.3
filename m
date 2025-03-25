Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB393C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 08:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twzuP-0001pd-Qx; Tue, 25 Mar 2025 04:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1twzuN-0001oT-2F
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 04:45:15 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1twzuG-0008Kv-Gx
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 04:45:14 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxmnEDbeJnNGelAA--.15291S3;
 Tue, 25 Mar 2025 16:44:52 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMBxn8XobOJniRZfAA--.19861S3;
 Tue, 25 Mar 2025 16:44:49 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Fix the cpu unplug resource leak
To: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
References: <20250324123328.518076-1-lixianglai@loongson.cn>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <a25fb6a6-630a-18a5-61a0-335bbcea1c3f@loongson.cn>
Date: Tue, 25 Mar 2025 16:43:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250324123328.518076-1-lixianglai@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn8XobOJniRZfAA--.19861S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7trWkWrWxGF4kJrW7uw1Dtwc_yoW8tr45pF
 9rAw1DKr48GrZFy3WkJas0vrnrZrWxWr4IqFWftrWrCw4DX3s5ZFW8K3sFyF98A348Wa1F
 qF1Fkr1j9a1UZabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.591,
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



On 2025/3/24 下午8:33, Xianglai Li wrote:
> When the cpu is created, qemu_add_vm_change_state_handler
> is called in the kvm_arch_init_vcpu function to create
> the VMChangeStateEntry resource.
> 
> However, the resource is not released when the cpu is destroyed.
> This results in a qemu process segment error when the virtual
> machine restarts after the cpu is unplugged.
> 
> This patch solves the problem by adding the corresponding resource
> release process to the kvm_arch_destroy_vcpu function.
> 
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> ---
> Cc: Bibo Mao <maobibo@loongson.cn>
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: Xianglai Li <lixianglai@loongson.cn>
> 
>   target/loongarch/cpu.h     | 1 +
>   target/loongarch/kvm/kvm.c | 7 ++++++-
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index eae874c67b..254e4fbdcd 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -426,6 +426,7 @@ struct ArchCPU {
>       const char *dtb_compatible;
>       /* used by KVM_REG_LOONGARCH_COUNTER ioctl to access guest time counters */
>       uint64_t kvm_state_counter;
> +    VMChangeStateEntry *vmsentry;
>   };
>   
>   /**
> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> index 7f63e7c8fe..f0e3cfef03 100644
> --- a/target/loongarch/kvm/kvm.c
> +++ b/target/loongarch/kvm/kvm.c
> @@ -1080,8 +1080,10 @@ int kvm_arch_init_vcpu(CPUState *cs)
>       uint64_t val;
>       int ret;
>       Error *local_err = NULL;
> +    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
>   
> -    qemu_add_vm_change_state_handler(kvm_loongarch_vm_stage_change, cs);
> +    cpu->vmsentry = qemu_add_vm_change_state_handler(
> +                    kvm_loongarch_vm_stage_change, cs);
>   
>       if (!kvm_get_one_reg(cs, KVM_REG_LOONGARCH_DEBUG_INST, &val)) {
>           brk_insn = val;
> @@ -1197,6 +1199,9 @@ void kvm_loongarch_cpu_post_init(LoongArchCPU *cpu)
>   
>   int kvm_arch_destroy_vcpu(CPUState *cs)
>   {
> +    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
> +
> +    qemu_del_vm_change_state_handler(cpu->vmsentry);
>       return 0;
>   }
>   
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


