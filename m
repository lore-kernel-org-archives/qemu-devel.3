Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5BBCC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 04:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugF2M-0001pf-5x; Mon, 28 Jul 2025 00:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1ugF2A-0001mj-NO
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 00:00:18 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1ugF27-00061B-65
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 00:00:18 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxmnHG9YZofiszAQ--.37141S3;
 Mon, 28 Jul 2025 12:00:07 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCxM+TD9YZoSGwpAA--.14244S3;
 Mon, 28 Jul 2025 12:00:06 +0800 (CST)
Subject: Re: [PATCH] hw/intc/loongarch_ipi: Fix start fail with smp cpu < smp
 maxcpus on KVM
To: Song Gao <gaosong@loongson.cn>, lixianglai@loongson.cn
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250725081213.3867592-1-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <04542368-762b-a86b-8d76-333fec0e0aa9@loongson.cn>
Date: Mon, 28 Jul 2025 11:58:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250725081213.3867592-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxM+TD9YZoSGwpAA--.14244S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WFyUCF1xKr13Jw4fAry7Arc_yoW5JFyUpr
 y5uF1Uur48Ary09asIqayUGa4UWw1IqF13uay3KFWxAFsxZw4FgFWDXFZYkry3Jw17AFWr
 XF42qa4Iva42yrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5
 WrAUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.134,
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



On 2025/7/25 下午4:12, Song Gao wrote:
> QEMU start failed when smp cpu < smp maxcpus , because qemu send a NULL
> cpu to KVM, this patch adds a check for kvm_ipi_access_regs() to fix it.
> 
> run with '-smp 1,maxcpus=4,sockets=4,cores=1,threads=1'
> 
> we got:
> Unexpected error in kvm_device_access() at ../accel/kvm/kvm-all.c:3477:
> qemu-system-loongarch64: KVM_SET_DEVICE_ATTR failed: Group 1073741825 attr 0x0000000000010000: Invalid argument
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/intc/loongarch_ipi_kvm.c | 27 ++++++++++++++++-----------
>   1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/intc/loongarch_ipi_kvm.c b/hw/intc/loongarch_ipi_kvm.c
> index 4cb3acc921..dd4c367abf 100644
> --- a/hw/intc/loongarch_ipi_kvm.c
> +++ b/hw/intc/loongarch_ipi_kvm.c
> @@ -23,36 +23,41 @@ static void kvm_ipi_access_regs(void *opaque, bool write)
>       LoongarchIPIState *lis = LOONGARCH_IPI(opaque);
>       IPICore *core;
>       uint64_t attr;
> -    int cpu, fd = lis->dev_fd;
> +    int i, cpu_index, fd = lis->dev_fd;
>   
>       if (fd == 0) {
>           return;
>       }
>   
> -    for (cpu = 0; cpu < ipi->num_cpu; cpu++) {
> -        core = &ipi->cpu[cpu];
> -        attr = (cpu << 16) | CORE_STATUS_OFF;
> +    for (i = 0; i < ipi->num_cpu; i++) {
> +        core = &ipi->cpu[i];
> +        if (core->cpu == NULL) {
> +            continue;
> +        }
> +        cpu_index = i;
> +
> +        attr = (cpu_index << 16) | CORE_STATUS_OFF;
>           kvm_ipi_access_reg(fd, attr, &core->status, write);
>   
> -        attr = (cpu << 16) | CORE_EN_OFF;
> +        attr = (cpu_index << 16) | CORE_EN_OFF;
>           kvm_ipi_access_reg(fd, attr, &core->en, write);
>   
> -        attr = (cpu << 16) | CORE_SET_OFF;
> +        attr = (cpu_index << 16) | CORE_SET_OFF;
>           kvm_ipi_access_reg(fd, attr, &core->set, write);
>   
> -        attr = (cpu << 16) | CORE_CLEAR_OFF;
> +        attr = (cpu_index << 16) | CORE_CLEAR_OFF;
>           kvm_ipi_access_reg(fd, attr, &core->clear, write);
>   
> -        attr = (cpu << 16) | CORE_BUF_20;
> +        attr = (cpu_index << 16) | CORE_BUF_20;
>           kvm_ipi_access_reg(fd, attr, &core->buf[0], write);
>   
> -        attr = (cpu << 16) | CORE_BUF_28;
> +        attr = (cpu_index << 16) | CORE_BUF_28;
>           kvm_ipi_access_reg(fd, attr, &core->buf[2], write);
>   
> -        attr = (cpu << 16) | CORE_BUF_30;
> +        attr = (cpu_index << 16) | CORE_BUF_30;
>           kvm_ipi_access_reg(fd, attr, &core->buf[4], write);
>   
> -        attr = (cpu << 16) | CORE_BUF_38;
> +        attr = (cpu_index << 16) | CORE_BUF_38;
>           kvm_ipi_access_reg(fd, attr, &core->buf[6], write);
>       }
>   }
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


