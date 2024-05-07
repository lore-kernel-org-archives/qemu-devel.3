Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7913AC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 13:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Kwp-0000oS-Vl; Tue, 07 May 2024 09:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=IG/P=MK=kaod.org=clg@ozlabs.org>)
 id 1s4Kwk-0000nV-MJ; Tue, 07 May 2024 09:33:30 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=IG/P=MK=kaod.org=clg@ozlabs.org>)
 id 1s4Kwh-0006yW-Hm; Tue, 07 May 2024 09:33:30 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VYfNx4Mxdz4x2v;
 Tue,  7 May 2024 23:33:21 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VYfNr35F2z4x2g;
 Tue,  7 May 2024 23:33:16 +1000 (AEST)
Message-ID: <484c975e-3b68-4730-93a1-febfb7668fc5@kaod.org>
Date: Tue, 7 May 2024 15:33:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/16] aspeed/intc: Add AST2700 support
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240416091904.935283-1-jamin_lin@aspeedtech.com>
 <20240416091904.935283-12-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240416091904.935283-12-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=IG/P=MK=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Jamin

On 4/16/24 11:18, Jamin Lin wrote:
> AST2700 interrupt controller(INTC) provides hardware interrupt interfaces
> to interrupt of processors PSP, SSP and TSP. In INTC, each interrupt of
> INT 128 to INT136 combines 32 interrupts.
> 
> Introduce a new aspeed_intc class with instance_init and realize handlers.
> 
> So far, this model only supports GICINT128 to GICINT136.
> It creates 9 GICINT or-gates to connect 32 interrupts sources
> from GICINT128 to GICINT136 as IRQ GPIO-OUTPUT pins.
> Then, this model registers IRQ handler with its IRQ GPIO-INPUT pins which
> connect to GICINT or-gates. And creates 9 GICINT IRQ GPIO-OUTPUT pins which
> connect to GIC device with GIC IRQ 128 to 136.
> 
> If one interrupt source from GICINT128 to GICINT136
> set irq, the OR-GATE irq callback function is called and set irq to INTC by
> OR-GATE GPIO-OUTPUT pins. Then, the INTC irq callback function is called and
> set irq to GIC by its GICINT IRQ GPIO-OUTPUT pins. Finally, the GIC irq
> callback function is called and set irq to CPUs and
> CPUs execute Interrupt Service Routine (ISR).

It is difficult to understand what the model does :/

> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/intc/aspeed_intc.c         | 269 ++++++++++++++++++++++++++++++++++
>   hw/intc/meson.build           |   1 +
>   hw/intc/trace-events          |   6 +
>   include/hw/intc/aspeed_intc.h |  35 +++++
>   4 files changed, 311 insertions(+)
>   create mode 100644 hw/intc/aspeed_intc.c
>   create mode 100644 include/hw/intc/aspeed_intc.h
> 
> diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
> new file mode 100644
> index 0000000000..df31900d56
> --- /dev/null
> +++ b/hw/intc/aspeed_intc.c
> @@ -0,0 +1,269 @@
> +/*
> + * ASPEED INTC Controller
> + *
> + * Copyright (C) 2024 ASPEED Technology Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/intc/aspeed_intc.h"
> +#include "hw/irq.h"
> +#include "migration/vmstate.h"
> +#include "qemu/bitops.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "hw/intc/arm_gicv3.h"
> +#include "trace.h"
> +#include "hw/registerfields.h"
> +#include "qapi/error.h"
> +
> +/* INTC Registers */
> +REG32(GICINT128_EN,         0x1000)
> +REG32(GICINT128_STATUS,     0x1004)
> +REG32(GICINT129_EN,         0x1100)
> +REG32(GICINT129_STATUS,     0x1104)
> +REG32(GICINT130_EN,         0x1200)
> +REG32(GICINT130_STATUS,     0x1204)
> +REG32(GICINT131_EN,         0x1300)
> +REG32(GICINT131_STATUS,     0x1304)
> +REG32(GICINT132_EN,         0x1400)
> +REG32(GICINT132_STATUS,     0x1404)
> +REG32(GICINT133_EN,         0x1500)
> +REG32(GICINT133_STATUS,     0x1504)
> +REG32(GICINT134_EN,         0x1600)
> +REG32(GICINT134_STATUS,     0x1604)
> +REG32(GICINT135_EN,         0x1700)
> +REG32(GICINT135_STATUS,     0x1704)
> +REG32(GICINT136_EN,         0x1800)
> +REG32(GICINT136_STATUS,     0x1804)
> +
> +#define GICINT_EN_BASE     R_GICINT128_EN
> +
> +/*
> + * The address of GICINT128 to GICINT136 are from 0x1000 to 0x1804.
> + * Utilize "address & 0x0f00" to get the gicint_out index and
> + * its gic irq.
> + */
> +static void aspeed_intc_update(AspeedINTCState *s, int irq, int level)
> +{
> +    uint32_t gicint_enable_addr = GICINT_EN_BASE + ((0x100 * irq) >> 2);
> +    uint32_t gicint_status_addr = gicint_enable_addr + (0x4 >> 2);
> +
> +    if (s->trigger[irq]) {
> +        if (!level && !s->regs[gicint_status_addr]) {
> +            /* clear irq */
> +            trace_aspeed_intc_update_irq(irq, 0);
> +            qemu_set_irq(s->gicint_out[irq], 0);
> +            s->trigger[irq] = false;
> +        }
> +    } else {
> +        if (s->new_gicint_status[irq]) {
> +            /* set irq */
> +            trace_aspeed_intc_update_irq(irq, 1);
> +            s->regs[gicint_status_addr] = s->new_gicint_status[irq];
> +            s->new_gicint_status[irq] = 0;
> +            qemu_set_irq(s->gicint_out[irq], 1);
> +            s->trigger[irq] = true;
> +        }
> +    }

I will trust you on this as I don't understand.


> +}
> +
> +/*
> + * The value of irq should be 0 to ASPEED_INTC_NR_GICS.
> + * The irq 0 indicates GICINT128, irq 1 indicates GICINT129 and so on.
> + */
> +static void aspeed_intc_set_irq(void *opaque, int irq, int level)
> +{
> +    AspeedINTCState *s = (AspeedINTCState *)opaque;
> +    uint32_t gicint_enable_addr = GICINT_EN_BASE + ((0x100 * irq) >> 2);
> +    uint32_t enable = s->regs[gicint_enable_addr];
> +    int i;
> +
> +    if (irq > ASPEED_INTC_NR_GICS) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid interrupt number: %d\n",
> +                      __func__, irq);
> +        return;
> +    }
> +
> +    trace_aspeed_intc_set_irq(irq, level);
> +
> +    for (i = 0; i < 32; i++) {
> +        if (s->gicint_orgate[irq].levels[i]) {
> +            if (enable & BIT(i)) {
> +                s->new_gicint_status[irq] |= BIT(i);
> +            }
> +        }
> +    }
> +
> +    aspeed_intc_update(s, irq, level);
> +}
> +
> +static uint64_t aspeed_intc_read(void *opaque, hwaddr offset, unsigned int size)
> +{
> +    AspeedINTCState *s = ASPEED_INTC(opaque);
> +    uint32_t addr = offset >> 2;
> +    uint32_t value = 0;
> +
> +    if (addr >= ASPEED_INTC_NR_REGS) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out-of-bounds read at offset 0x%" HWADDR_PRIx "\n",
> +                      __func__, offset);
> +        return 0;
> +    }
> +
> +    switch (addr) {
> +    case R_GICINT128_EN:
> +    case R_GICINT129_EN:
> +    case R_GICINT130_EN:
> +    case R_GICINT131_EN:
> +    case R_GICINT132_EN:
> +    case R_GICINT133_EN:
> +    case R_GICINT134_EN:
> +    case R_GICINT135_EN:
> +    case R_GICINT136_EN:
> +    case R_GICINT128_STATUS:
> +    case R_GICINT129_STATUS:
> +    case R_GICINT130_STATUS:
> +    case R_GICINT131_STATUS:
> +    case R_GICINT132_STATUS:
> +    case R_GICINT133_STATUS:
> +    case R_GICINT134_STATUS:
> +    case R_GICINT135_STATUS:
> +    case R_GICINT136_STATUS:
> +        value = s->regs[addr];
> +        break;
> +    default:
> +        value = s->regs[addr];
> +        break;
> +    }
> +
> +    trace_aspeed_intc_read(offset, size, value);
> +
> +    return value;
> +}
> +
> +static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
> +                                        unsigned size)
> +{
> +    AspeedINTCState *s = ASPEED_INTC(opaque);
> +    uint32_t irq = (offset & 0x0f00) >> 8;
> +    uint32_t addr = offset >> 2;
> +
> +
> +    if (addr >= ASPEED_INTC_NR_REGS) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out-of-bounds write at offset 0x%" HWADDR_PRIx "\n",
> +                      __func__, offset);
> +        return;
> +    }
> +
> +    trace_aspeed_intc_write(offset, size, data);
> +
> +    switch (addr) {
> +    case R_GICINT128_EN:
> +    case R_GICINT129_EN:
> +    case R_GICINT130_EN:
> +    case R_GICINT131_EN:
> +    case R_GICINT132_EN:
> +    case R_GICINT133_EN:
> +    case R_GICINT134_EN:
> +    case R_GICINT135_EN:
> +    case R_GICINT136_EN:
> +        s->regs[addr] = data;
> +        break;
> +    case R_GICINT128_STATUS:
> +    case R_GICINT129_STATUS:
> +    case R_GICINT130_STATUS:
> +    case R_GICINT131_STATUS:
> +    case R_GICINT132_STATUS:
> +    case R_GICINT133_STATUS:
> +    case R_GICINT134_STATUS:
> +    case R_GICINT135_STATUS:
> +    case R_GICINT136_STATUS:
> +        /* clear status */
> +        s->regs[addr] &= ~data;
> +        if (!s->regs[addr]) {
> +            aspeed_intc_update(s, irq, 0);
> +        }
> +        break;
> +    default:
> +        s->regs[addr] = data;
> +        break;
> +    }
> +
> +    return;
> +}
> +
> +static const MemoryRegionOps aspeed_intc_ops = {
> +    .read = aspeed_intc_read,
> +    .write = aspeed_intc_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    }
> +};
> +
> +static void aspeed_intc_instance_init(Object *obj)
> +{
> +    AspeedINTCState *s = ASPEED_INTC(obj);
> +    int i;
> +
> +    for (i = 0; i < ASPEED_INTC_NR_GICS; i++) {
> +        object_initialize_child(obj, "gic-orgate[*]", &s->gicint_orgate[i],
> +                                TYPE_OR_IRQ);
> +        object_property_set_int(OBJECT(&s->gicint_orgate[i]), "num-lines",
> +                                32, &error_abort);
> +    }
> +}
> +
> +static void aspeed_intc_reset(DeviceState *dev)
> +{
> +    AspeedINTCState *s = ASPEED_INTC(dev);
> +    memset(s->regs, 0, sizeof(s->regs));
> +    memset(s->trigger, 0, sizeof(s->trigger));
> +    memset(s->new_gicint_status, 0, sizeof(s->new_gicint_status));
> +}
> +
> +static void aspeed_intc_realize(DeviceState *dev, Error **errp)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    AspeedINTCState *s = ASPEED_INTC(dev);
> +    int i;
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_intc_ops, s,
> +                          TYPE_ASPEED_INTC ".regs", ASPEED_INTC_NR_REGS << 2);
> +
> +    sysbus_init_mmio(sbd, &s->iomem);
> +    qdev_init_gpio_in(dev, aspeed_intc_set_irq, ASPEED_INTC_NR_GICS);
> +
> +    for (i = 0; i < ASPEED_INTC_NR_GICS; i++) {
> +        sysbus_init_irq(sbd, &s->gicint_out[i]);
> +    }

Why aren't the orgates realized here ?

> +}
> +
> +static void aspeed_intc_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = aspeed_intc_realize;
> +    dc->reset = aspeed_intc_reset;
> +    dc->desc = "ASPEED INTC Controller";
> +    dc->vmsd = NULL;
> +}
> +
> +static const TypeInfo aspeed_intc_info = {
> +    .name = TYPE_ASPEED_INTC,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_init = aspeed_intc_instance_init,
> +    .instance_size = sizeof(AspeedINTCState),
> +    .class_init = aspeed_intc_class_init,
> +};
> +
> +static void aspeed_intc_register_types(void)
> +{
> +    type_register_static(&aspeed_intc_info);
> +}
> +
> +type_init(aspeed_intc_register_types);
> diff --git a/hw/intc/meson.build b/hw/intc/meson.build
> index ed355941d1..f5c574f584 100644
> --- a/hw/intc/meson.build
> +++ b/hw/intc/meson.build
> @@ -14,6 +14,7 @@ system_ss.add(when: 'CONFIG_ARM_GICV3_TCG', if_true: files(
>   ))
>   system_ss.add(when: 'CONFIG_ALLWINNER_A10_PIC', if_true: files('allwinner-a10-pic.c'))
>   system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_vic.c'))
> +system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_intc.c'))
>   system_ss.add(when: 'CONFIG_ETRAXFS', if_true: files('etraxfs_pic.c'))
>   system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_gic.c', 'exynos4210_combiner.c'))
>   system_ss.add(when: 'CONFIG_GOLDFISH_PIC', if_true: files('goldfish_pic.c'))
> diff --git a/hw/intc/trace-events b/hw/intc/trace-events
> index 1ef29d0256..30b9dd2a96 100644
> --- a/hw/intc/trace-events
> +++ b/hw/intc/trace-events
> @@ -79,6 +79,12 @@ aspeed_vic_update_fiq(int flags) "Raising FIQ: %d"
>   aspeed_vic_update_irq(int flags) "Raising IRQ: %d"
>   aspeed_vic_read(uint64_t offset, unsigned size, uint32_t value) "From 0x%" PRIx64 " of size %u: 0x%" PRIx32
>   aspeed_vic_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
> +# aspeed_intc.c
> +aspeed_intc_read(uint64_t offset, unsigned size, uint32_t value) "From 0x%" PRIx64 " of size %u: 0x%" PRIx32
> +aspeed_intc_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
> +aspeed_intc_set_irq(int irq, int level) "Set IRQ %d: %d"
> +aspeed_intc_update_irq(int irq, int level) "Update IRQ: %d: %d"
> +aspeed_intc_debug(uint32_t offset, uint32_t value) "Debug 0x%x: 0x%x"
>   
>   # arm_gic.c
>   gic_enable_irq(int irq) "irq %d enabled"
> diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h
> new file mode 100644
> index 0000000000..0d2fbbda8f
> --- /dev/null
> +++ b/include/hw/intc/aspeed_intc.h
> @@ -0,0 +1,35 @@
> +/*
> + * ASPEED INTC Controller
> + *
> + * Copyright (C) 2024 ASPEED Technology Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef ASPEED_INTC_H
> +#define ASPEED_INTC_H
> +
> +#include "hw/sysbus.h"
> +#include "qom/object.h"
> +#include "hw/or-irq.h"
> +
> +#define TYPE_ASPEED_INTC "aspeed.intc"
> +OBJECT_DECLARE_SIMPLE_TYPE(AspeedINTCState, ASPEED_INTC)
> +
> +#define ASPEED_INTC_NR_REGS (0x2000 >> 2)
> +#define ASPEED_INTC_NR_GICS 9
> +
> +struct AspeedINTCState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +    DeviceState *gic;
> +
> +    /*< public >*/
> +    MemoryRegion iomem;
> +    uint32_t regs[ASPEED_INTC_NR_REGS];
> +    OrIRQState gicint_orgate[ASPEED_INTC_NR_GICS];
> +    qemu_irq gicint_out[ASPEED_INTC_NR_GICS];
> +    bool trigger[ASPEED_INTC_NR_GICS];
> +    uint32_t new_gicint_status[ASPEED_INTC_NR_GICS];

I don't think the gicint prefix is useful in the names. I am struggling to
catch what new_gicint_status and trigger really do.


Thanks,

C.




> +};
> +
> +#endif /* ASPEED_INTC_H */


