Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A27CC02181
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2024 07:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spNMN-0006Ed-NJ; Sat, 14 Sep 2024 03:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1spNMK-0006Dj-9y
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 03:38:20 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1spNMI-0001An-1e
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 03:38:19 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxPutkPeVmE88HAA--.18621S3;
 Sat, 14 Sep 2024 15:38:12 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMBxn+RhPeVmOKcGAA--.38233S3;
 Sat, 14 Sep 2024 15:38:11 +0800 (CST)
Subject: Re: [RFC PATCH V2 5/5] hw/loongarch: Add KVM pch msi device support
To: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 kvm@vger.kernel.org
References: <cover.1725969898.git.lixianglai@loongson.cn>
 <8c81313bd4a5c53db5c889f19c9415994a9e007d.1725969898.git.lixianglai@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <3dda64e5-9fa4-82e6-48c7-0897ce4478a0@loongson.cn>
Date: Sat, 14 Sep 2024 15:38:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <8c81313bd4a5c53db5c889f19c9415994a9e007d.1725969898.git.lixianglai@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn+RhPeVmOKcGAA--.38233S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3XFWUAFW5Cr1fuFy5XF1DurX_yoW7Ar13pF
 W3ur1Skr4rJrWxWan3K3yUury5Xan7WryIvF12kryxCr1DZr93WF1vyrsFgFyjk348Gryq
 vFyruFs2ga1DC3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j0
 sjUUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.566,
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

Hi Xianglai,

I do not find any usage about function kvm_irqchip_commit_routes() in 
your patch-set, do I miss something?

Regards
Bibo Mao

On 2024/9/10 下午8:18, Xianglai Li wrote:
> Added pch_msi interrupt controller handling
> during kernel emulation of irq chip.
> 
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: Bibo Mao <maobibo@loongson.cn>
> Cc: Xianglai Li <lixianglai@loongson.cn>
> 
>   hw/intc/loongarch_pch_msi.c | 42 +++++++++++++++++++++++++++----------
>   hw/loongarch/virt.c         | 26 +++++++++++++----------
>   target/loongarch/kvm/kvm.c  |  1 -
>   3 files changed, 46 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/intc/loongarch_pch_msi.c b/hw/intc/loongarch_pch_msi.c
> index ecf3ed0267..bab6f852f8 100644
> --- a/hw/intc/loongarch_pch_msi.c
> +++ b/hw/intc/loongarch_pch_msi.c
> @@ -2,7 +2,7 @@
>   /*
>    * QEMU Loongson 7A1000 msi interrupt controller.
>    *
> - * Copyright (C) 2021 Loongson Technology Corporation Limited
> + * Copyright (C) 2024 Loongson Technology Corporation Limited
>    */
>   
>   #include "qemu/osdep.h"
> @@ -14,6 +14,8 @@
>   #include "hw/misc/unimp.h"
>   #include "migration/vmstate.h"
>   #include "trace.h"
> +#include "sysemu/kvm.h"
> +#include "hw/loongarch/virt.h"
>   
>   static uint64_t loongarch_msi_mem_read(void *opaque, hwaddr addr, unsigned size)
>   {
> @@ -26,14 +28,24 @@ static void loongarch_msi_mem_write(void *opaque, hwaddr addr,
>       LoongArchPCHMSI *s = (LoongArchPCHMSI *)opaque;
>       int irq_num;
>   
> -    /*
> -     * vector number is irq number from upper extioi intc
> -     * need subtract irq base to get msi vector offset
> -     */
> -    irq_num = (val & 0xff) - s->irq_base;
> -    trace_loongarch_msi_set_irq(irq_num);
> -    assert(irq_num < s->irq_num);
> -    qemu_set_irq(s->pch_msi_irq[irq_num], 1);
> +    MSIMessage msg = {
> +        .address = addr,
> +        .data = val,
> +    };
> +
> +    if (kvm_enabled() && kvm_irqchip_in_kernel()) {
> +        kvm_irqchip_send_msi(kvm_state, msg);
> +    } else {
> +        /*
> +         * vector number is irq number from upper extioi intc
> +         * need subtract irq base to get msi vector offset
> +         */
> +        irq_num = (val & 0xff) - s->irq_base;
> +        trace_loongarch_msi_set_irq(irq_num);
> +        assert(irq_num < s->irq_num);
> +
> +        qemu_set_irq(s->pch_msi_irq[irq_num], 1);
> +    }
>   }
>   
>   static const MemoryRegionOps loongarch_pch_msi_ops = {
> @@ -45,8 +57,16 @@ static const MemoryRegionOps loongarch_pch_msi_ops = {
>   static void pch_msi_irq_handler(void *opaque, int irq, int level)
>   {
>       LoongArchPCHMSI *s = LOONGARCH_PCH_MSI(opaque);
> -
> -    qemu_set_irq(s->pch_msi_irq[irq], level);
> +    MSIMessage msg = {
> +        .address = 0,
> +        .data = irq,
> +    };
> +
> +    if (kvm_enabled() && kvm_irqchip_in_kernel()) {
> +        kvm_irqchip_send_msi(kvm_state, msg);
> +    } else {
> +        qemu_set_irq(s->pch_msi_irq[irq], level);
> +    }
>   }
>   
>   static void loongarch_pch_msi_realize(DeviceState *dev, Error **errp)
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index db0c08899b..b42cf7e5af 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -887,24 +887,28 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
>           for (i = 0; i < num; i++) {
>               qdev_connect_gpio_out(DEVICE(d), i, qdev_get_gpio_in(extioi, i));
>           }
> +    }
>   
> -        /* Add PCH PIC node */
> -        fdt_add_pch_pic_node(lvms, &eiointc_phandle, &pch_pic_phandle);
> +    /* Add PCH PIC node */
> +    fdt_add_pch_pic_node(lvms, &eiointc_phandle, &pch_pic_phandle);
>   
> -        pch_msi = qdev_new(TYPE_LOONGARCH_PCH_MSI);
> -        start   =  num;
> -        num = EXTIOI_IRQS - start;
> -        qdev_prop_set_uint32(pch_msi, "msi_irq_base", start);
> -        qdev_prop_set_uint32(pch_msi, "msi_irq_num", num);
> -        d = SYS_BUS_DEVICE(pch_msi);
> -        sysbus_realize_and_unref(d, &error_fatal);
> -        sysbus_mmio_map(d, 0, VIRT_PCH_MSI_ADDR_LOW);
> +    pch_msi = qdev_new(TYPE_LOONGARCH_PCH_MSI);
> +    num = VIRT_PCH_PIC_IRQ_NUM;
> +    start   =  num;
> +    num = EXTIOI_IRQS - start;
> +    qdev_prop_set_uint32(pch_msi, "msi_irq_base", start);
> +    qdev_prop_set_uint32(pch_msi, "msi_irq_num", num);
> +    d = SYS_BUS_DEVICE(pch_msi);
> +    sysbus_realize_and_unref(d, &error_fatal);
> +
> +    if (!(kvm_enabled() && kvm_irqchip_in_kernel())) {
> +        /* Connect pch_msi irqs to extioi */
>           for (i = 0; i < num; i++) {
> -            /* Connect pch_msi irqs to extioi */
>               qdev_connect_gpio_out(DEVICE(d), i,
>                                     qdev_get_gpio_in(extioi, i + start));
>           }
>       }
> +    sysbus_mmio_map(d, 0, VIRT_PCH_MSI_ADDR_LOW);
>   
>       /* Add PCH MSI node */
>       fdt_add_pch_msi_node(lvms, &eiointc_phandle, &pch_msi_phandle);
> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> index c07dcfd85f..e1be6a6959 100644
> --- a/target/loongarch/kvm/kvm.c
> +++ b/target/loongarch/kvm/kvm.c
> @@ -719,7 +719,6 @@ int kvm_arch_get_default_type(MachineState *ms)
>   
>   int kvm_arch_init(MachineState *ms, KVMState *s)
>   {
> -    s->kernel_irqchip_allowed = false;
>       cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
>       return 0;
>   }
> 


