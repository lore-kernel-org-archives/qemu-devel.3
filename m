Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7A3C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 09:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUNo5-0005Ji-AS; Thu, 18 Jul 2024 05:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sUNnv-00056Z-92
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:52:04 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sUNnq-00026H-WB
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:52:01 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxDeu55Zhmq4kAAA--.2982S3;
 Thu, 18 Jul 2024 17:51:53 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxMMS25ZhmsaZNAA--.6703S3; 
 Thu, 18 Jul 2024 17:51:52 +0800 (CST)
Subject: Re: [PATCH v4 15/18] hw/intc/loongarch_ipi: Add loongarch IPI support
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Xianglai Li <lixianglai@loongson.cn>, Huacai Chen
 <chenhuacai@kernel.org>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240718083842.81199-1-philmd@linaro.org>
 <20240718083842.81199-16-philmd@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <9b9fe347-dec1-b813-8df7-e04cbc72134a@loongson.cn>
Date: Thu, 18 Jul 2024 17:52:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240718083842.81199-16-philmd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8DxMMS25ZhmsaZNAA--.6703S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3GryUKryfJrykGw48Aw47GFX_yoW7XFWxpF
 y7ur4YgF4kJF47JwsxJ3ZxXFnxJrs3ua429FyS9ry8ArsxJ34rXw1kKrZrXFW3t3yDXw1F
 vFsak3WjgF1Ut3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Ek
 sDUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.124,
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

在 2024/7/18 下午4:38, Philippe Mathieu-Daudé 写道:
> From: Bibo Mao <maobibo@loongson.cn>
>
> Loongarch IPI is added here, it inherits from class
> TYPE_LOONGSON_IPI_COMMON, and two interfaces get_iocsr_as() and
> cpu_by_arch_id() are added for Loongarch 3A5000 machine. It can
> be used when ipi is emulated in userspace with KVM mode.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> [PMD: Rebased and simplified]
> Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
> Tested-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   include/hw/intc/loongarch_ipi.h | 25 ++++++++++++
>   hw/intc/loongarch_ipi.c         | 68 +++++++++++++++++++++++++++++++++
>   hw/intc/Kconfig                 |  4 ++
>   hw/intc/meson.build             |  1 +
>   4 files changed, 98 insertions(+)
>   create mode 100644 include/hw/intc/loongarch_ipi.h
>   create mode 100644 hw/intc/loongarch_ipi.c
>
> diff --git a/include/hw/intc/loongarch_ipi.h b/include/hw/intc/loongarch_ipi.h
> new file mode 100644
> index 0000000000..d134c9d0c7
> --- /dev/null
> +++ b/include/hw/intc/loongarch_ipi.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Loongarch ipi interrupt header files
> + *
> + * Copyright (C) 2024 Loongson Technology Corporation Limited
> + */
> +
> +#ifndef HW_LOONGARCH_IPI_H
> +#define HW_LOONGARCH_IPI_H
> +
> +#include "qom/object.h"
> +#include "hw/intc/loongson_ipi_common.h"
> +
> +#define TYPE_LOONGARCH_IPI  "loongarch_ipi"
> +OBJECT_DECLARE_TYPE(LoongarchIPIState, LoongarchIPIClass, LOONGARCH_IPI)
> +
> +struct LoongarchIPIState {
> +    LoongsonIPICommonState parent_obj;
> +};
> +
> +struct LoongarchIPIClass {
> +    LoongsonIPICommonClass parent_class;
> +};
> +
> +#endif
> diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
> new file mode 100644
> index 0000000000..ccbfad07b7
> --- /dev/null
> +++ b/hw/intc/loongarch_ipi.c
> @@ -0,0 +1,68 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Loongarch ipi interrupt support
> + *
> + * Copyright (C) 2024 Loongson Technology Corporation Limited
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/boards.h"
> +#include "hw/intc/loongarch_ipi.h"
> +#include "target/loongarch/cpu.h"
> +
> +static AddressSpace *get_iocsr_as(CPUState *cpu)
> +{
> +    return LOONGARCH_CPU(cpu)->env.address_space_iocsr;
> +}
> +
> +static int archid_cmp(const void *a, const void *b)
> +{
> +   CPUArchId *archid_a = (CPUArchId *)a;
> +   CPUArchId *archid_b = (CPUArchId *)b;
> +
> +   return archid_a->arch_id - archid_b->arch_id;
> +}
> +
> +static CPUArchId *find_cpu_by_archid(MachineState *ms, uint32_t id)
> +{
> +    CPUArchId apic_id, *found_cpu;
> +
> +    apic_id.arch_id = id;
> +    found_cpu = bsearch(&apic_id, ms->possible_cpus->cpus,
> +                        ms->possible_cpus->len,
> +                        sizeof(*ms->possible_cpus->cpus),
> +                        archid_cmp);
> +
> +    return found_cpu;
> +}
> +
> +static CPUState *loongarch_cpu_by_arch_id(int64_t arch_id)
> +{
> +    MachineState *machine = MACHINE(qdev_get_machine());
> +    CPUArchId *archid;
> +
> +    archid = find_cpu_by_archid(machine, arch_id);
> +    if (archid) {
> +        return CPU(archid->cpu);
> +    }
> +
> +    return NULL;
> +}
> +
> +static void loongarch_ipi_class_init(ObjectClass *klass, void *data)
> +{
> +    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_CLASS(klass);
> +
> +    licc->get_iocsr_as = get_iocsr_as;
> +    licc->cpu_by_arch_id = loongarch_cpu_by_arch_id;
> +}
> +
> +static const TypeInfo loongarch_ipi_types[] = {
> +    {
> +        .name               = TYPE_LOONGARCH_IPI,
> +        .parent             = TYPE_LOONGSON_IPI_COMMON,
> +        .class_init         = loongson_ipi_class_init,
loongarch_ipi_class_init.

Thanks.
Song Gao
> +    }
> +};
> +
> +DEFINE_TYPES(loongarch_ipi_types)
> diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
> index a2a0fdca85..dd405bdb5d 100644
> --- a/hw/intc/Kconfig
> +++ b/hw/intc/Kconfig
> @@ -94,6 +94,10 @@ config LOONGSON_IPI
>       bool
>       select LOONGSON_IPI_COMMON
>   
> +config LOONGARCH_IPI
> +    bool
> +    select LOONGSON_IPI_COMMON
> +
>   config LOONGARCH_PCH_PIC
>       bool
>       select UNIMP
> diff --git a/hw/intc/meson.build b/hw/intc/meson.build
> index a09a527207..f4d81eb8e4 100644
> --- a/hw/intc/meson.build
> +++ b/hw/intc/meson.build
> @@ -71,6 +71,7 @@ specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_XIVE'],
>   specific_ss.add(when: 'CONFIG_M68K_IRQC', if_true: files('m68k_irqc.c'))
>   specific_ss.add(when: 'CONFIG_LOONGSON_IPI_COMMON', if_true: files('loongson_ipi_common.c'))
>   specific_ss.add(when: 'CONFIG_LOONGSON_IPI', if_true: files('loongson_ipi.c'))
> +specific_ss.add(when: 'CONFIG_LOONGARCH_IPI', if_true: files('loongarch_ipi.c'))
>   specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_PIC', if_true: files('loongarch_pch_pic.c'))
>   specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_MSI', if_true: files('loongarch_pch_msi.c'))
>   specific_ss.add(when: 'CONFIG_LOONGARCH_EXTIOI', if_true: files('loongarch_extioi.c'))


