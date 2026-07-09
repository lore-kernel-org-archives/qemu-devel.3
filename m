Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB90C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 09:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whkkH-0001Yu-Ue; Thu, 09 Jul 2026 05:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1whkkG-0001Ym-26
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 05:08:36 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1whkkD-0004wU-58
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 05:08:35 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxZeoKZU9qhMoBAA--.6120S3;
 Thu, 09 Jul 2026 17:08:27 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJBxb8cHZU9qMLAGAA--.13813S2;
 Thu, 09 Jul 2026 17:08:25 +0800 (CST)
Subject: Re: [PATCH] hw/intc/loongarch_dintc: Fix OOB access in DINT MMIO
 write handler
To: Song Gao <gaosong@loongson.cn>, thuth@redhat.com, qemu-devel@nongnu.org
Cc: berrange@redhat.com, lixianglai@loongson.cn
References: <20260701065454.1976188-1-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <2b0109e5-6495-8295-564b-fb057fbce108@loongson.cn>
Date: Thu, 9 Jul 2026 17:08:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260701065454.1976188-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxb8cHZU9qMLAGAA--.13813S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr4kZFW7Xw43ZrWkWF4DAwc_yoW8ZFyxpF
 WxCrn0g3yUtrsrta97Ka4ruF13Wrs3WFy2ganxKFyIyrZxXr1UXrsYgwnxJF97Cw45WrWj
 vry3GFn09Fy7XFbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07Ui
 iSdUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.97,
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



On 2026/7/1 下午2:54, Song Gao wrote:
> Validate guest-controlled cpu_num before using it to index the cpu[] array
> or pass to async_run_on_cpu(). Without this check, a malicious guest can
> trigger a NULL pointer dereference in async_run_on_cpu() and an
> out-of-bounds array access in qemu_set_irq(), causing host crash.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3616
> Fixes: 0d148eaf5a3e ("hw/loongarch: Implement dintc set irq")
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/intc/loongarch_dintc.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/hw/intc/loongarch_dintc.c b/hw/intc/loongarch_dintc.c
> index c877a8003b..e40292887c 100644
> --- a/hw/intc/loongarch_dintc.c
> +++ b/hw/intc/loongarch_dintc.c
> @@ -19,6 +19,7 @@
>   #include "target/loongarch/cpu.h"
>   #include "qemu/error-report.h"
>   #include "system/hw_accel.h"
> +#include "qemu/log.h"
>   
>   /* msg addr field */
>   FIELD(MSG_ADDR, IRQ_NUM, 4, 8)
> @@ -52,7 +53,19 @@ static void loongarch_dintc_mem_write(void *opaque, hwaddr addr,
>       CPUState *cs;
>   
>       cpu_num = FIELD_EX64(msg_addr, MSG_ADDR, CPU_NUM);
> +
> +    /* Validate cpu_num against the configured number of CPUs */
> +    if (cpu_num >= s->num_cpu) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "loongarch-dintc: invalid cpu number%d\n", cpu_num);
> +        return;
> +    }
Here cpu_num decoded from MSG_ADDR is physical CPU ID, I think that it 
is not meaningful to compare it with s->num_cpu.

>       cs = cpu_by_arch_id(cpu_num);
This is ok to use cpu_by_arch_id now, in later when CPU hotplug is 
support with dintc, there should be self CPU search logic like ipi irqchip.

Regards
Bibo Mao
> +    if (!cs) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "loongarch-dintc: no CPU for arch_id %d\n", cpu_num);
> +        return;
> +    }
>       irq_num = FIELD_EX64(msg_addr, MSG_ADDR, IRQ_NUM);
>   
>       async_run_on_cpu(cs, do_set_vcpu_dintc_irq,
> 


