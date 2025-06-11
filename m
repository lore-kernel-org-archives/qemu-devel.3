Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA0CC61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 03:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPCQ9-0003wj-WF; Tue, 10 Jun 2025 23:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uPCQ6-0003wR-3r
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 23:46:34 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uPCQ3-0005EX-6K
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 23:46:33 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxPOIK_EhojlsTAQ--.6572S3;
 Wed, 11 Jun 2025 11:46:18 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMDx_MQI_EhoVWkVAQ--.62873S3;
 Wed, 11 Jun 2025 11:46:18 +0800 (CST)
Subject: Re: [PATCH 10/10] target/loongarch: cpu do interrupt support msg
 interrupt.
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250609104833.839811-1-gaosong@loongson.cn>
 <20250609104833.839811-11-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <9e70f82e-af27-7468-29f0-34f2b72e5df2@loongson.cn>
Date: Wed, 11 Jun 2025 11:44:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250609104833.839811-11-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDx_MQI_EhoVWkVAQ--.62873S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWFWDAr48trWfCw17Jry3ZFc_yoWrZw4rpa
 yxCFZ0kr45KrZrA3ZxJ3Z8GrnxZr1fKws29wnxC342kFWUXr1UWrWkt3ZrWF9rC34rurWx
 ZF1SyryUu3W3JFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU70PfDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.653,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 2025/6/9 下午6:48, Song Gao wrote:
> we use CSR_ESTAT and CSR_ECFG bit 15 for msg interrupt.
> and loongarch_cpu_do_interrupt support msg interrupts.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/cpu-csr.h |  3 ++-
>   target/loongarch/cpu.c     | 35 ++++++++++++++++++++++++++++++-----
>   2 files changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
> index 83f6cb081a..5a00cf3366 100644
> --- a/target/loongarch/cpu-csr.h
> +++ b/target/loongarch/cpu-csr.h
> @@ -35,11 +35,12 @@ FIELD(CSR_MISC, DWPL, 16, 3)
>   
>   #define LOONGARCH_CSR_ECFG           0x4 /* Exception config */
>   FIELD(CSR_ECFG, LIE, 0, 13)
> +FIELD(CSR_ECFG, MSGINT, 14, 1)      /* used for msg */
how about only modify LIE such as FIELD(CSR_ECFG, LIE, 0, 15)?

>   FIELD(CSR_ECFG, VS, 16, 3)
>   
>   #define LOONGARCH_CSR_ESTAT          0x5 /* Exception status */
>   FIELD(CSR_ESTAT, IS, 0, 13)
> -FIELD(CSR_ESTAT, MSGINT, 14, 1)
> +FIELD(CSR_ESTAT, MSGINT, 14, 1)    /* used for msg */
ditto, how about modify IS such as FIELD(CSR_ESTAT, IS, 0, 15)?

Regards
Bibo Mao
>   FIELD(CSR_ESTAT, ECODE, 16, 6)
>   FIELD(CSR_ESTAT, ESUBCODE, 22, 9)
>   
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 207d11266f..b92463101e 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -117,6 +117,13 @@ static vaddr loongarch_cpu_get_pc(CPUState *cs)
>   #ifndef CONFIG_USER_ONLY
>   #include "hw/loongarch/virt.h"
>   
> +static uint32_t loongarch_cpu_has_interrupt(CPULoongArchState *env)
> +{
> +    uint32_t ret = 0;
> +    ret = FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS);
> +    ret |= FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, MSGINT);
> +    return ret;
> +}
>   void loongarch_cpu_set_irq(void *opaque, int irq, int level)
>   {
>       LoongArchCPU *cpu = opaque;
> @@ -134,21 +141,20 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
>                   env->CSR_MSGIR = FIELD_DP64(env->CSR_MSGIR, CSR_MSGIR, INTNUM, i);
>                   env->CSR_MSGIR = FIELD_DP64(env->CSR_MSGIR, CSR_MSGIR, ACTIVE, 0);
>                   env->CSR_ESTAT = FIELD_DP64(env->CSR_ESTAT, CSR_ESTAT, MSGINT, 1);
> -                cpu_interrupt(cs, CPU_INTERRUPT_HARD);
> +                env->CSR_ECFG = FIELD_DP64(env->CSR_ECFG, CSR_ECFG, MSGINT, 1);
>                   clear_bit(i, &(env->CSR_MSGIS[i / 64]));
>               }
>           }
>       } else {
>          env->CSR_ESTAT = FIELD_DP64(env->CSR_ESTAT, CSR_ESTAT, MSGINT, 0);
> -       env->CSR_MSGIR = FIELD_DP64(env->CSR_MSGIR, CSR_MSGIR, ACTIVE, 1);
> -       return;
> +       env->CSR_ECFG = FIELD_DP64(env->CSR_ECFG, CSR_ECFG, MSGINT, 0);
>       }
>   
>       if (kvm_enabled()) {
>           kvm_loongarch_set_interrupt(cpu, irq, level);
>       } else if (tcg_enabled()) {
>           env->CSR_ESTAT = deposit64(env->CSR_ESTAT, irq, 1, level != 0);
> -        if (FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS)) {
> +        if (loongarch_cpu_has_interrupt(env)) {
>               cpu_interrupt(cs, CPU_INTERRUPT_HARD);
>           } else {
>               cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> @@ -166,12 +172,24 @@ static inline bool cpu_loongarch_hw_interrupts_enabled(CPULoongArchState *env)
>       return ret;
>   }
>   
> +static inline bool cpu_loongarch_hw_interrupt_msg_pending(CPULoongArchState *env)
> +{
> +    bool pending_msg = 0;
> +    bool status_msg = 0;
> +
> +    pending_msg = FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, MSGINT);
> +    status_msg = FIELD_EX64(env->CSR_ECFG, CSR_ECFG, MSGINT);
> +
> +    return (pending_msg & status_msg) != 0;
> +}
>   /* Check if there is pending and not masked out interrupt */
>   static inline bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
>   {
>       uint32_t pending;
>       uint32_t status;
> -
> +    if (cpu_loongarch_hw_interrupt_msg_pending(env)) {
> +        return true;
> +    }
>       pending = FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS);
>       status  = FIELD_EX64(env->CSR_ECFG, CSR_ECFG, LIE);
>   
> @@ -285,6 +303,13 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
>           uint32_t vector = 0;
>           uint32_t pending = FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS);
>           pending &= FIELD_EX64(env->CSR_ECFG, CSR_ECFG, LIE);
> +        if (cpu_loongarch_hw_interrupt_msg_pending(env)) {
> +            env->CSR_ESTAT = FIELD_DP64(env->CSR_ESTAT, CSR_ESTAT, MSGINT, 0);
> +            env->CSR_ECFG = FIELD_DP64(env->CSR_ECFG, CSR_ECFG, MSGINT, 0);
> +            set_pc(env, env->CSR_EENTRY + \
> +                   (EXCCODE_EXTERNAL_INT + INT_AVEC) * vec_size);
> +            return;
> +        }
>   
>           /* Find the highest-priority interrupt. */
>           vector = 31 - clz32(pending);
> 


