Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED095CD4F4C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 02:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snU6s-0003IC-M0; Sun, 08 Sep 2024 22:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1snU6n-0003HL-2A
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 22:26:29 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1snU6k-0002aF-Ql
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 22:26:28 -0400
Received: from loongson.cn (unknown [10.20.42.17])
 by gateway (Coremail) with SMTP id _____8AxrurOXN5mZ2gCAA--.6189S3;
 Mon, 09 Sep 2024 10:26:22 +0800 (CST)
Received: from [10.20.42.17] (unknown [10.20.42.17])
 by front1 (Coremail) with SMTP id qMiowMDxcNbJXN5mQwkCAA--.11012S3;
 Mon, 09 Sep 2024 10:26:19 +0800 (CST)
Subject: Re: [PATCH] target/loongarch/kvm: Add vCPU reset function
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20240822022827.2273534-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <85f99133-f688-4765-9e4b-d610cc1ad2bd@loongson.cn>
Date: Mon, 9 Sep 2024 10:26:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240822022827.2273534-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxcNbJXN5mQwkCAA--.11012S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJryUAryDXw1kJF17JF1rXwc_yoW8ur47pF
 W7uFn8KF4rJrZrJas7Z398ur1DZr43GrsFvaySq3ykCrs8try8XF1kt39FgFn8A3y8WFyS
 qr1fCw1jvFWxX3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
 wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
 WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7pnQ
 UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-3.046, SPF_HELO_NONE=0.001,
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



ÔÚ 2024/8/22 ÉÏÎç10:28, Bibo Mao Ð´µÀ:
> KVM provides interface KVM_REG_LOONGARCH_VCPU_RESET to reset vCPU,
> it can be used to clear internal state about kvm kernel. vCPU reset
> function is added here for kvm mode.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu.c               | 2 +-
>   target/loongarch/kvm/kvm.c           | 5 ++++-
>   target/loongarch/kvm/kvm_loongarch.h | 2 +-
>   3 files changed, 6 insertions(+), 3 deletions(-)
> 
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks
Song Gao
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 5e85b9dbef..6a5f856bd6 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -563,7 +563,7 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
>       memset(env->tlb, 0, sizeof(env->tlb));
>   #endif
>       if (kvm_enabled()) {
> -        kvm_arch_reset_vcpu(env);
> +        kvm_arch_reset_vcpu(cs);
>       }
>   #endif
>   
> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> index e1be6a6959..4786cd5efa 100644
> --- a/target/loongarch/kvm/kvm.c
> +++ b/target/loongarch/kvm/kvm.c
> @@ -476,9 +476,12 @@ static int kvm_loongarch_put_regs_fp(CPUState *cs)
>       return ret;
>   }
>   
> -void kvm_arch_reset_vcpu(CPULoongArchState *env)
> +void kvm_arch_reset_vcpu(CPUState *cs)
>   {
> +    CPULoongArchState *env = cpu_env(cs);
> +
>       env->mp_state = KVM_MP_STATE_RUNNABLE;
> +    kvm_set_one_reg(cs, KVM_REG_LOONGARCH_VCPU_RESET, 0);
>   }
>   
>   static int kvm_loongarch_get_mpstate(CPUState *cs)
> diff --git a/target/loongarch/kvm/kvm_loongarch.h b/target/loongarch/kvm/kvm_loongarch.h
> index d945b6bb82..1051a341ec 100644
> --- a/target/loongarch/kvm/kvm_loongarch.h
> +++ b/target/loongarch/kvm/kvm_loongarch.h
> @@ -11,6 +11,6 @@
>   #define QEMU_KVM_LOONGARCH_H
>   
>   int  kvm_loongarch_set_interrupt(LoongArchCPU *cpu, int irq, int level);
> -void kvm_arch_reset_vcpu(CPULoongArchState *env);
> +void kvm_arch_reset_vcpu(CPUState *cs);
>   
>   #endif
> 


