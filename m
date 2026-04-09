Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89EDF31E22
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 15:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAr8e-00076E-OG; Thu, 09 Apr 2026 11:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAr8b-000765-PF
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 11:17:46 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAr8Z-0002cy-2B
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 11:17:45 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-650775f427eso1050129d50.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 08:17:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775747860; cv=none;
 d=google.com; s=arc-20240605;
 b=kJ8mQg2X+dNFgCVy25TQCKoVP6Ipi/3utPV2YsWRjJQyrZ1G/QmVbRBWj2Tb0Y4Rd2
 fxDEkRj+xoILB+zoVshPUcN/WnuiQbLAEN331Zo953K4dPtPJEoYaD+GnhDC/iqL1NUr
 OhfmbiW6O2jO2QQuMhl84MQWjRTEnXm5hjPP/OPIpG91hX9IeMThIHPbF1omLEGpni8i
 2y6lBzkTleohv17IQA1/rSKB1XFQr1jZ059SzjTG1QYMfq77vqJWaQXBX99PBxKM/rYQ
 kzKBx6Bpq5p/0+PAzAwEk9Tvtj7FCP8dEOd4RnqpnEudrKTFcNebbr6vrB2/Tbrivxqw
 MsJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2hWpS+hbfzl39cSuVN5CbMkIXgOHcp0tZP0S2mlTLjs=;
 fh=VUZ7eJox894qpEuQTEFSefKlY4l3x+uBmRGBSaSsOHU=;
 b=JP0mCf83O9XbGtja/XeeIUspYegEarXnvDK5tMbYCqWoBa8yOCexqZzRpio8hM3xkT
 wbg0o+LJFrZM9E6yFoEuHl0NE5IthAeqDTyfKA5aTMkOREFCd33iUbTvp98ZyGKvl/HM
 zPjNbVkXdhpHYZ7yCbomDJIog4s6FL/11zTXO+qpYPoI9UW1+DVmnmIxs+94n1sCpBPh
 lACijQFh6Qlc7pw4u8cHIJg1GlHWBPfbe8UMaX5HlXovseFP30tpOQdNfXDua1zyCPgJ
 8w/u3rvSejByTFgz+yXZ+pSEMrPcP8IJEhAVPYOxeW0WqFIj9YkA8kb1ULnqdvalDVag
 UF+w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775747860; x=1776352660; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2hWpS+hbfzl39cSuVN5CbMkIXgOHcp0tZP0S2mlTLjs=;
 b=LhZwSyR585jn+6+ywSZZGy3y2QVacWXpHftEJGKjawTwvPgqVlK3K6vkyL9q8fGnKv
 HOR6snhup5KmVbsvujoAyBRqkA3ZS2pM0wcKw/0ocv7ONhZmf5CY/tJ+MRLkaNZyh/Ho
 QvQBblGXJUzdktyQmsbattXXZ8kmDEzviCZyf7KppJqGAl8DBDEkfGQe+WGObVNbWYrZ
 TJUsMoAYoHL5ssbbfEhZf+1SmXgK4v3KS/4mApc7tWDoO8JH4/dS0/4Ym5Ym9/omxyWe
 Gc3hchFOVelM+Em1dgv7QTRoPc9J3kt4EBYxZJ+EQTDFbIQ6OMoz7fJN1PdNNl5F+oxD
 k4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775747860; x=1776352660;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2hWpS+hbfzl39cSuVN5CbMkIXgOHcp0tZP0S2mlTLjs=;
 b=jH1CXUX1JzukVJa+Rtw5WxsFsVP9GVFbVxGh54gqwJ7Vj9xKnLKwJ5h0/CcZdaAySq
 UyM5l26u1J1+5QJD5u/XBZ8D/ZrI6Vy2Uz7JZPS0KDcoa5/olUMNHDXIjC3d1zuoGzh2
 wIiah7XURP8iXQCogRnxZsJc8Dz9otbRPbAbaCOEiCUgBRdY2tTpTII0LLWah2DBOn+c
 ndqXE7cdARg6qsu7hygDGefks5CgFgsSLLox0ASd9HeJqxoL0anu2Lywj3FEYJmzJukF
 IVBQEQQhQtHSdjGNUYFusH2+HvmQTfxd+HrFsu6XSH+vWDEKks+wI862bwqt3MGoNo7N
 C3VQ==
X-Gm-Message-State: AOJu0Yz3/X06f2eazagTBOnXGnzWXTuW8dzMqswbPiEhpYBwyFZ+prdp
 eXzsO1pe3EbaDck5e0sHl943pEEqq6Z1ZF2qSylLOpTPFifYG5HrNf9DkvX46OsDzBMs/8J2XjP
 Ry40VuI5uvEfB0BhwwN4lcP91JqobW720CFNPz1zGcw==
X-Gm-Gg: AeBDieu0qk5HWtQsTRoHmu8RVv6lOfTxhukhxXxQ73MFgKmhcXv+sCmRBOQlLBPRVCU
 ZVQ5Mmx+kmyUNGU2EzhGSLKL7HTMxRoewROGmHZVwSt3hjj1k9fNrUwBG1tfOT3htyjvYGngRl1
 nls7iWwy3r5WFocizvkiiETC4M87kldiiHSiGF+NPBh+mwkTEi00Eqp90IHbboxu7fR5l/qIAIs
 dAZWopr9HLlFJvwBffqnk//FKLI25PE89yDPgx0lWlKnnAduV+2ESYyMsrlABN2hbQ/NdnJTItD
 5u7vqo1/Ad5cMFybcXdhAMbz7uUs42B4PX5gBDs29MkaENp2NkyB0vbhWqAbt6MwBSo=
X-Received: by 2002:a05:690e:1488:b0:650:497f:7167 with SMTP id
 956f58d0204a3-650497f78e8mr24954019d50.48.1775747860107; Thu, 09 Apr 2026
 08:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260306121511.1781020-1-kchiu@axiado.com>
 <20260306121511.1781020-2-kchiu@axiado.com>
In-Reply-To: <20260306121511.1781020-2-kchiu@axiado.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Apr 2026 16:17:28 +0100
X-Gm-Features: AQROBzB2a7_DW9Urk4GdXOr54T-XifjSdAP3vtWwYRih-5O3NCh-5hT9AqCanTw
Message-ID: <CAFEAcA_LCnsubbLH6mQDXHJF4e+ejVzFpy55=7W1jAh_gEXL2g@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] hw/arm: Add Axiado SoC AX3000
To: Kuan-Jui Chiu <kchiu@axiado.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 6 Mar 2026 at 12:21, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>
> This patch adds new model for Axiado SoC AX3000 which supports
>     4 Cortex-A53 ARM64 CPUs
>     Arm Generic Interrupt Controller v3
>     4 Cadence UARTs
>     1 SDHCI controller with PHY
>
> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>

Hi; thanks for this patch; my review comments are below. I have
some comments about structure but nothing too major I think.

> ---
>  hw/arm/Kconfig              |   8 +
>  hw/arm/axiado-soc.c         | 287 ++++++++++++++++++++++++++++++++++++
>  hw/arm/meson.build          |   2 +
>  include/hw/arm/axiado-soc.h | 152 +++++++++++++++++++
>  4 files changed, 449 insertions(+)
>  create mode 100644 hw/arm/axiado-soc.c
>  create mode 100644 include/hw/arm/axiado-soc.h
>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index c66c452737..a91b81b298 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -699,3 +699,11 @@ config ARMSSE
>      select UNIMP
>      select SSE_COUNTER
>      select SSE_TIMER
> +
> +config AXIADO_SOC
> +    bool
> +    default y
> +    depends on ARM
> +    select ARM_GIC
> +    select CADENCE # UART
> +    select SDHCI
> diff --git a/hw/arm/axiado-soc.c b/hw/arm/axiado-soc.c
> new file mode 100644
> index 0000000000..e23410c147
> --- /dev/null
> +++ b/hw/arm/axiado-soc.c
> @@ -0,0 +1,287 @@
> +/*
> + * Axiado SoC AX3000
> + *
> + * Author: Kuan-Jui Chiu <kchiu@axiado.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 or
> + * (at your option) version 3 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.

If you run scripts/checkpatch.pl on your patches, it should
warn you that we prefer to use SPDX identifiers rather than
the traditional GPL license boilerplate.


> + */

Is there a data sheet for this SoC? The top level comment is
a good place to put the URL for it.

Without a datasheet, it's trickier to review.

> +
> +#include "qemu/osdep.h"
> +#include "system/address-spaces.h"
> +#include "hw/arm/bsa.h"
> +#include "hw/arm/axiado-soc.h"
> +#include "system/system.h"
> +#include "qobject/qlist.h"
> +#include "qom/object.h"
> +
> +static uint64_t sdhci_phy_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    uint32_t val = 0x00;
> +
> +    switch (offset) {
> +    case REG_ID:
> +        val = 0x3dff6870;
> +        break;
> +    case REG_STATUS:
> +        // Make DLL_RDY | CAL_DONE
> +        val =  (1u << 0) | (1u << 6);
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    return val;
> +}
> +
> +static void sdhci_phy_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
> +{
> +    /* TBD */
> +}
> +
> +static const MemoryRegionOps sdhci_phy_ops = {
> +    .read = sdhci_phy_read,
> +    .write = sdhci_phy_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};

Please put models of sub-devices of the SoC into their own
source files in the appropriate subdirectory of the hw/ directory.

> +
> +static uint64_t timer_ctrl_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    return 0x0;
> +}
> +
> +static void timer_ctrl_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
> +{
> +    /* TBD */
> +}
> +
> +static const MemoryRegionOps timer_ctrl_ops = {
> +    .read = timer_ctrl_read,
> +    .write = timer_ctrl_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};

If you can get by with absolutely no implementation of a device,
consider using TYPE_UNIMPLEMENTED_DEVICE (from hw/misc/unimp.c),
which will give you a "reads as zero, writes ignored" block which
also logs when the guest touches it. (You can either create the
device directly, or use the create_unimplemented_device() helper
function.)

> +
> +static uint64_t pll_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    switch (offset) {
> +    case CLKRST_CPU_PLL_POSTDIV_OFFSET:
> +        return 0x20891b;
> +    case CLKRST_CPU_PLL_STS_OFFSET:
> +        return 0x01;
> +    default:
> +        return 0x00;
> +    }
> +}
> +
> +static void pll_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
> +{
> +    /* TBD */
> +}
> +
> +static const MemoryRegionOps pll_ops = {
> +    .read = pll_read,
> +    .write = pll_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
> +static void ax3000_init(Object *obj)
> +{
> +    AxiadoSoCState *s = AXIADO_SOC(obj);
> +    AxiadoSoCClass *sc = AXIADO_SOC_GET_CLASS(s);
> +    int i;
> +
> +    for (i = 0; i < sc->num_cpus; i++) {
> +        g_autofree char *name = g_strdup_printf("cpu%d", i);
> +        object_initialize_child(obj, name, &s->cpu[i], ARM_CPU_TYPE_NAME("cortex-a53"));
> +    }
> +
> +    object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
> +
> +    for (i = 0; i < AX3000_NUM_UARTS; i++) {
> +        g_autofree char *name = g_strdup_printf("uart%d", i);
> +        object_initialize_child(obj, name, &s->uart[i], TYPE_CADENCE_UART);
> +    }
> +
> +    object_initialize_child(obj, "sdhci0", &s->sdhci0, TYPE_SYSBUS_SDHCI);
> +}
> +
> +static void ax3000_realize(DeviceState *dev, Error **errp)
> +{
> +    AxiadoSoCState *s = AXIADO_SOC(dev);
> +    AxiadoSoCClass *sc = AXIADO_SOC_GET_CLASS(s);
> +    SysBusDevice *gicsbd = SYS_BUS_DEVICE(&s->gic);
> +    DeviceState *gicdev = DEVICE(&s->gic);
> +    QList *redist_region_count;
> +    int i;
> +
> +    /* CPUs */
> +    for (i = 0; i < sc->num_cpus; i++) {
> +        object_property_set_int(OBJECT(&s->cpu[i]), "cntfrq", 8000000,
> +                                &error_abort);
> +
> +        if (object_property_find(OBJECT(&s->cpu[i]), "has_el3")) {
> +            object_property_set_bool(OBJECT(&s->cpu[i]), "has_el3",
> +                                     false, &error_abort);

Does your SoC really not implement EL3 ?

> +        }
> +
> +        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
> +            return;
> +        }
> +    }
> +
> +    /* GIC */
> +    qdev_prop_set_uint32(gicdev, "num-cpu", sc->num_cpus);
> +    qdev_prop_set_uint32(gicdev, "num-irq",
> +                         AX3000_NUM_IRQS + GIC_INTERNAL);
> +
> +    redist_region_count = qlist_new();
> +    qlist_append_int(redist_region_count, sc->num_cpus);
> +    qdev_prop_set_array(gicdev, "redist-region-count", redist_region_count);
> +
> +    if (!sysbus_realize(gicsbd, errp)) {
> +        return;
> +    }
> +
> +    sysbus_mmio_map(gicsbd, 0, AX3000_GIC_DIST_BASE);
> +    sysbus_mmio_map(gicsbd, 1, AX3000_GIC_REDIST_BASE);
> +
> +    /*
> +     * Wire the outputs from each CPU's generic timer and the GICv3
> +     * maintenance interrupt signal to the appropriate GIC PPI inputs, and
> +     * the GIC's IRQ/FIQ interrupt outputs to the CPU's inputs.
> +     */
> +    for (i = 0; i < sc->num_cpus; i++) {
> +        DeviceState *cpudev = DEVICE(&s->cpu[i]);
> +        int intidbase = AX3000_NUM_IRQS + i * GIC_INTERNAL;
> +        qemu_irq irq;
> +
> +        /*
> +         * Mapping from the output timer irq lines from the CPU to the
> +         * GIC PPI inputs.
> +         */
> +        static const int timer_irqs[] = {
> +            [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
> +            [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
> +            [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
> +            [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ
> +        };
> +
> +        for (int j = 0; j < ARRAY_SIZE(timer_irqs); j++) {
> +            irq = qdev_get_gpio_in(gicdev, intidbase + timer_irqs[j]);
> +            qdev_connect_gpio_out(cpudev, j, irq);
> +        }
> +
> +        irq = qdev_get_gpio_in(gicdev, intidbase + ARCH_GIC_MAINT_IRQ);
> +        qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
> +                                        0, irq);
> +
> +        sysbus_connect_irq(gicsbd, i,
> +                           qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
> +        sysbus_connect_irq(gicsbd, i + sc->num_cpus,
> +                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
> +        sysbus_connect_irq(gicsbd, i + 2 * sc->num_cpus,
> +                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
> +        sysbus_connect_irq(gicsbd, i + 3 * sc->num_cpus,
> +                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
> +    }
> +
> +    /* DRAM */
> +    for (i = 0; i < AX3000_NUM_BANKS; i++) {
> +        struct {
> +            hwaddr addr;
> +            size_t size;
> +            const char *name;
> +        } dram_table[] = {
> +            { AX3000_DRAM0_BASE, AX3000_DRAM0_SIZE, "dram0" },
> +            { AX3000_DRAM1_BASE, AX3000_DRAM1_SIZE, "dram1" }
> +        };
> +
> +        memory_region_init_ram(&s->dram[i], OBJECT(s), dram_table[i].name,
> +                               dram_table[i].size, &error_fatal);
> +        memory_region_add_subregion(get_system_memory(), dram_table[i].addr,
> +                                    &s->dram[i]);
> +    }
> +
> +    /* UARTs */
> +    for (i = 0; i < AX3000_NUM_UARTS; i++) {
> +        struct {
> +            hwaddr addr;
> +            unsigned int irq;
> +        } serial_table[] = {
> +            { AX3000_UART0_BASE, AX3000_UART0_IRQ },
> +            { AX3000_UART1_BASE, AX3000_UART1_IRQ },
> +            { AX3000_UART2_BASE, AX3000_UART2_IRQ },
> +            { AX3000_UART3_BASE, AX3000_UART3_IRQ }
> +        };
> +
> +        qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
> +            return;
> +        }
> +
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, serial_table[i].addr);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
> +                           qdev_get_gpio_in(gicdev, serial_table[i].irq));
> +    }
> +
> +    /* Timer control*/
> +    memory_region_init_io(&s->timer_ctrl, OBJECT(s), &timer_ctrl_ops, s,
> +                          "timer_ctrl", 32);
> +    memory_region_add_subregion(get_system_memory(), AX3000_TIMER_CTRL,
> +                                &s->timer_ctrl);
> +
> +    /* PLL control */
> +    memory_region_init_io(&s->pll_ctrl, OBJECT(s), &pll_ops, s, "pll_ctrl",
> +                          32);
> +    memory_region_add_subregion(get_system_memory(), AX3000_PLL_BASE,
> +                                &s->pll_ctrl);
> +
> +    /* SDHCI */
> +    qdev_prop_set_uint64(DEVICE(&s->sdhci0), "capareg", 0x216737eed0b0);
> +    qdev_prop_set_uint64(DEVICE(&s->sdhci0), "sd-spec-version", 3);
> +
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci0), errp)) {
> +        return;
> +    }
> +
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci0), 0, AX3000_SDHCI0_BASE);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci0), 0,
> +                       qdev_get_gpio_in(gicdev, AX3000_SDHCI0_IRQ));
> +
> +    memory_region_init_io(&s->sdhci_phy, OBJECT(s), &sdhci_phy_ops, s,
> +                           "sdhci_phy", AX3000_SDHCI0_PHY_SIZE);
> +    memory_region_add_subregion(get_system_memory(), AX3000_SDHCI0_PHY_BASE,
> +                                &s->sdhci_phy);
> +}
> +
> +static void ax3000_class_init(ObjectClass *oc, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +    AxiadoSoCClass *sc = AXIADO_SOC_CLASS(oc);
> +
> +    dc->desc = "Axiado SoC AX3000";
> +    dc->realize = ax3000_realize;
> +    sc->num_cpus = AX3000_NUM_CPUS;
> +}
> +
> +static const TypeInfo axiado_soc_types[] = {
> +    {
> +        .name           = TYPE_AXIADO_SOC,
> +        .parent         = TYPE_SYS_BUS_DEVICE,
> +        .instance_size  = sizeof(AxiadoSoCState),
> +        .instance_init  = ax3000_init,
> +        .class_init     = ax3000_class_init,
> +    }
> +};
> +
> +DEFINE_TYPES(axiado_soc_types)
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index 47cdc51d13..c3c96c0a70 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -105,6 +105,8 @@ arm_common_ss.add(when: 'CONFIG_STRONGARM', if_true: files('strongarm.c'))
>  arm_common_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
>  arm_common_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
>  arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
> +arm_common_ss.add(when: ['CONFIG_AXIADO_SOC', 'TARGET_AARCH64'], if_true: files(
> +  'axiado-soc.c'))
>
>  arm_common_ss.add(files('boot.c'))
>
> diff --git a/include/hw/arm/axiado-soc.h b/include/hw/arm/axiado-soc.h
> new file mode 100644
> index 0000000000..2483bdd8c2
> --- /dev/null
> +++ b/include/hw/arm/axiado-soc.h
> @@ -0,0 +1,152 @@
> +/*
> + * Axiado SoC AX3000
> + *
> + * Author: Kuan-Jui Chiu <kchiu@axiado.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 or
> + * (at your option) version 3 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef AXIADO_AX3000_H
> +#define AXIADO_AX3000_H
> +
> +#include "cpu.h"
> +#include "hw/intc/arm_gicv3_common.h"
> +#include "hw/char/cadence_uart.h"
> +#include "hw/sd/sdhci.h"
> +#include "hw/core/sysbus.h"
> +#include "qemu/units.h"
> +
> +#define TYPE_AXIADO_SOC "ax3000"
> +OBJECT_DECLARE_TYPE(AxiadoSoCState, AxiadoSoCClass, AXIADO_SOC)
> +
> +#define AX3000_RAM_START        0x3C000000
> +#define AX3000_RAM_SIZE_MAX     (16 * GiB)
> +
> +#define AX3000_DRAM0_BASE       AX3000_RAM_START
> +#define AX3000_DRAM0_SIZE       (1088 * MiB)
> +#define AX3000_DRAM1_BASE       0x400000000
> +#define AX3000_DRAM1_SIZE       (2 * GiB)
> +
> +#define AX3000_GIC_DIST_BASE    0x80300000
> +#define AX3000_GIC_DIST_SIZE    (64 * KiB)
> +#define AX3000_GIC_REDIST_BASE  0x80380000
> +#define AX3000_GIC_REDIST_SIZE  (512 * KiB)
> +
> +#define AX3000_UART0_BASE       0x80520000
> +#define AX3000_UART0_SIZE       (256)
> +#define AX3000_UART1_BASE       0x805a0000
> +#define AX3000_UART1_SIZE       (256)
> +#define AX3000_UART2_BASE       0x80620000
> +#define AX3000_UART2_SIZE       (256)
> +#define AX3000_UART3_BASE       0x80520800
> +#define AX3000_UART3_SIZE       (256)
> +
> +#define AX3000_SDHCI0_BASE      0x86000000
> +#define AX3000_SDHCI0_PHY_BASE  0x80801C00
> +#define AX3000_SDHCI0_PHY_SIZE  (256)
> +
> +#define AX3000_GPIO0_BASE       0x80500000
> +#define AX3000_GPIO0_SIZE       (1024)
> +#define AX3000_GPIO1_BASE       0x80580000
> +#define AX3000_GPIO1_SIZE       (1024)
> +#define AX3000_GPIO2_BASE       0x80600000
> +#define AX3000_GPIO2_SIZE       (1024)
> +#define AX3000_GPIO3_BASE       0x80680000
> +#define AX3000_GPIO3_SIZE       (1024)
> +#define AX3000_GPIO4_BASE       0x80700000
> +#define AX3000_GPIO4_SIZE       (1024)
> +#define AX3000_GPIO5_BASE       0x80780000
> +#define AX3000_GPIO5_SIZE       (1024)
> +#define AX3000_GPIO6_BASE       0x80800000
> +#define AX3000_GPIO6_SIZE       (1024)
> +#define AX3000_GPIO7_BASE       0x80880000
> +#define AX3000_GPIO7_SIZE       (1024)
> +
> +#define AX3000_TIMER_CTRL        0x8A020000
> +#define AX3000_PLL_BASE          0x80000000
> +#define CLKRST_CPU_PLL_POSTDIV_OFFSET   0x0C
> +#define CLKRST_CPU_PLL_STS_OFFSET       0x14
> +
> +
> +enum Ax3000Configuration {
> +    AX3000_NUM_CPUS     = 4,
> +    AX3000_NUM_IRQS     = 224,
> +    AX3000_NUM_BANKS    = 2,
> +    AX3000_NUM_UARTS    = 4,
> +    AX3000_NUM_GPIOS    = 8,
> +};
> +
> +typedef struct AxiadoSoCState {
> +    SysBusDevice        parent;
> +
> +    ARMCPU              cpu[AX3000_NUM_CPUS];
> +    GICv3State          gic;
> +    MemoryRegion        dram[AX3000_NUM_BANKS];
> +    MemoryRegion        timer_ctrl;
> +    MemoryRegion        pll_ctrl;
> +    CadenceUARTState    uart[AX3000_NUM_UARTS];
> +    SDHCIState          sdhci0;
> +    MemoryRegion        sdhci_phy;
> +} AxiadoSoCState;
> +
> +typedef struct AxiadoSoCClass {
> +    SysBusDeviceClass   parent;
> +
> +    uint32_t            num_cpus;
> +} AxiadoSoCClass;
> +
> +enum Ax3000MemoryRegions {
> +    AX3000_GIC_DIST,
> +    AX3000_GIC_REDIST,
> +    AX3000_DRAM0,
> +    AX3000_DRAM1,
> +    AX3000_UART0,
> +    AX3000_UART1,
> +    AX3000_UART2,
> +    AX3000_UART3,
> +    AX3000_SDHCI0,
> +    AX3000_GPIO0,
> +    AX3000_GPIO1,
> +    AX3000_GPIO2,
> +    AX3000_GPIO3,
> +    AX3000_GPIO4,
> +    AX3000_GPIO5,
> +    AX3000_GPIO6,
> +    AX3000_GPIO7,
> +};
> +
> +enum Ax3000Irqs {
> +    AX3000_UART0_IRQ    = 112,
> +    AX3000_UART1_IRQ    = 113,
> +    AX3000_UART2_IRQ    = 114,
> +    AX3000_UART3_IRQ    = 170,
> +
> +    AX3000_SDHCI0_IRQ    = 123,
> +
> +    AX3000_GPIO0_IRQ    = 183,
> +    AX3000_GPIO1_IRQ    = 184,
> +    AX3000_GPIO2_IRQ    = 185,
> +    AX3000_GPIO3_IRQ    = 186,
> +    AX3000_GPIO4_IRQ    = 187,
> +    AX3000_GPIO5_IRQ    = 188,
> +    AX3000_GPIO6_IRQ    = 189,
> +    AX3000_GPIO7_IRQ    = 190,
> +};
> +
> +enum SDHCI_PHY_REG {
> +    REG_ID        = 0x00,   // ID
> +    REG_STATUS    = 0x50,   // READY/LOCK/CAL_DONE bits

Don't use C++ style // comments, please. checkpatch will warn
about that too, I think.

> +};
> +
> +#endif /* AXIADO_AX3000_H */
> --
> 2.34.1

thanks
-- PMM

