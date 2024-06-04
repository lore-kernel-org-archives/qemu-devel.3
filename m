Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879B3C27C53
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEORQ-0002yf-A6; Tue, 04 Jun 2024 03:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=OW7X=NG=kaod.org=clg@ozlabs.org>)
 id 1sEORN-0002xs-Vz; Tue, 04 Jun 2024 03:18:42 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=OW7X=NG=kaod.org=clg@ozlabs.org>)
 id 1sEORK-0005YF-Kp; Tue, 04 Jun 2024 03:18:41 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VthlY0LbLz4x11;
 Tue,  4 Jun 2024 17:18:33 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VthlR4k9Kz4wcv;
 Tue,  4 Jun 2024 17:18:07 +1000 (AEST)
Message-ID: <b1dd5b6c-c698-448d-814b-5606ac9bbb8f@kaod.org>
Date: Tue, 4 Jun 2024 09:18:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/17] aspeed/intc: Add AST2700 support
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
References: <20240604054438.3424349-1-jamin_lin@aspeedtech.com>
 <20240604054438.3424349-13-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240604054438.3424349-13-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=OW7X=NG=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 6/4/24 07:44, Jamin Lin wrote:
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
> 
> Block diagram of GICINT132:
> 
>              GICINT132
>    ETH1    +-----------+
> +-------->+0         3|
>    ETH2    |          4|
> +-------->+1         5|
>    ETH3    |          6|
> +-------->+2        19|                          INTC                          GIC
>    UART0   |         20|            +--------------------------+
> +-------->+7        21|            |                          |            +--------------+
>    UART1   |         22|            |orgate0 +----> output_pin0+----------->+GIC128        |
> +-------->+8        23|            |                          |            |              |
>    UART2   |         24|            |orgate1 +----> output_pin1+----------->+GIC129        |
> +-------->+9        25|            |                          |            |              |
>    UART3   |         26|            |orgate2 +----> output_pin2+----------->+GIC130        |
> +--------->10       27|            |                          |            |              |
>    UART5   |         28|            |orgate3 +----> output_pin3+----------->+GIC131        |
> +-------->+11       29|            |                          |            |              |
>    UART6   |           +----------->+orgate4 +----> output_pin4+----------->+GIC132        |
> +-------->+12       30|            |                          |            |              |
>    UART7   |         31|            |orgate5 +----> output_pin5+----------->+GIC133        |
> +-------->+13         |            |                          |            |              |
>    UART8   |  OR[0:31] |            |orgate6 +----> output_pin6+----------->+GIC134        |
> ---------->14         |            |                          |            |              |
>    UART9   |           |            |orgate7 +----> output_pin7+----------->+GIC135        |
> --------->+15         |            |                          |            |              |
>    UART10  |           |            |orgate8 +----> output_pin8+----------->+GIC136        |
> --------->+16         |            |                          |            +--------------+
>    UART11  |           |            +--------------------------+
> +-------->+17         |
>    UART12  |           |
> +--------->18         |
>            |           |
>            |           |
>            |           |
>            +-----------+
> 
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/intc/aspeed_intc.c         | 360 ++++++++++++++++++++++++++++++++++
>   hw/intc/meson.build           |   1 +
>   hw/intc/trace-events          |  13 ++
>   include/hw/intc/aspeed_intc.h |  44 +++++
>   4 files changed, 418 insertions(+)
>   create mode 100644 hw/intc/aspeed_intc.c
>   create mode 100644 include/hw/intc/aspeed_intc.h
> 
> diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
> new file mode 100644
> index 0000000000..e232361791
> --- /dev/null
> +++ b/hw/intc/aspeed_intc.c
> @@ -0,0 +1,360 @@
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
> +#include "qemu/log.h"
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
> +#define GICINT_STATUS_BASE     R_GICINT128_STATUS
> +
> +static void aspeed_intc_update(AspeedINTCState *s, int irq, int level)
> +{
> +    AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
> +
> +    if (irq >= aic->num_ints) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid interrupt number: %d\n",
> +                      __func__, irq);
> +        return;
> +    }
> +
> +    trace_aspeed_intc_update_irq(irq, level);
> +    qemu_set_irq(s->output_pins[irq], level);
> +}
> +
> +/*
> + * The address of GICINT128 to GICINT136 are from 0x1000 to 0x1804.
> + * Utilize "address & 0x0f00" to get the irq and irq output pin index
> + * The value of irq should be 0 to num_ints.
> + * The irq 0 indicates GICINT128, irq 1 indicates GICINT129 and so on.
> + */
> +static void aspeed_intc_set_irq(void *opaque, int irq, int level)
> +{
> +    AspeedINTCState *s = (AspeedINTCState *)opaque;
> +    AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
> +    uint32_t status_addr = GICINT_STATUS_BASE + ((0x100 * irq) >> 2);
> +    uint32_t select = 0;
> +    uint32_t enable;
> +    int i;
> +
> +    if (irq >= aic->num_ints) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid interrupt number: %d\n",
> +                      __func__, irq);
> +        return;
> +    }
> +
> +    trace_aspeed_intc_set_irq(irq, level);
> +    enable = s->enable[irq];
> +
> +    if (!level) {
> +        return;
> +    }
> +
> +    for (i = 0; i < aic->num_lines; i++) {
> +        if (s->orgates[irq].levels[i]) {
> +            if (enable & BIT(i)) {
> +                select |= BIT(i);
> +            }
> +        }
> +    }
> +
> +    if (!select) {
> +        return;
> +    }
> +
> +    trace_aspeed_intc_select(select);
> +
> +    if (s->mask[irq] || s->regs[status_addr]) {
> +        /*
> +         * a. mask is not 0 means in ISR mode
> +         * sources interrupt routine are executing.
> +         * b. status register value is not 0 means previous
> +         * source interrupt does not be executed, yet.
> +         *
> +         * save source interrupt to pending variable.
> +         */
> +        s->pending[irq] |= select;
> +        trace_aspeed_intc_pending_irq(irq, s->pending[irq]);
> +    } else {
> +        /*
> +         * notify firmware which source interrupt are coming
> +         * by setting status register
> +         */
> +        s->regs[status_addr] = select;
> +        trace_aspeed_intc_trigger_irq(irq, s->regs[status_addr]);
> +        aspeed_intc_update(s, irq, 1);
> +    }
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
> +    value = s->regs[addr];
> +    trace_aspeed_intc_read(offset, size, value);
> +
> +    return value;
> +}
> +
> +static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
> +                                        unsigned size)
> +{
> +    AspeedINTCState *s = ASPEED_INTC(opaque);
> +    AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
> +    uint32_t addr = offset >> 2;
> +    uint32_t old_enable;
> +    uint32_t change;
> +    uint32_t irq;
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
> +        irq = (offset & 0x0f00) >> 8;
> +
> +        if (irq >= aic->num_ints) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid interrupt number: %d\n",
> +                          __func__, irq);
> +            return;
> +        }
> +
> +        /*
> +         * These registers are used for enable sources interrupt and
> +         * mask and unmask source interrupt while executing source ISR.
> +         */
> +
> +        /* disable all source interrupt */
> +        if (!data && !s->enable[irq]) {
> +            s->regs[addr] = data;
> +            return;
> +        }
> +
> +        old_enable = s->enable[irq];
> +        s->enable[irq] |= data;
> +
> +        /* enable new source interrupt */
> +        if (old_enable != s->enable[irq]) {
> +            trace_aspeed_intc_enable(s->enable[irq]);
> +            s->regs[addr] = data;
> +            return;
> +        }
> +
> +        /* mask and unmask source interrupt */
> +        change = s->regs[addr] ^ data;
> +        if (change & data) {
> +            s->mask[irq] &= ~change;
> +            trace_aspeed_intc_unmask(change, s->mask[irq]);
> +        } else {
> +            s->mask[irq] |= change;
> +            trace_aspeed_intc_mask(change, s->mask[irq]);
> +        }
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
> +        irq = (offset & 0x0f00) >> 8;
> +
> +        if (irq >= aic->num_ints) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid interrupt number: %d\n",
> +                          __func__, irq);
> +            return;
> +        }
> +
> +        /* clear status */
> +        s->regs[addr] &= ~data;
> +
> +        /*
> +         * These status registers are used for notify sources ISR are executed.
> +         * If one source ISR is executed, it will clear one bit.
> +         * If it clear all bits, it means to initialize this register status
> +         * rather than sources ISR are executed.
> +         */
> +        if (data == 0xffffffff) {
> +            return;
> +        }
> +
> +        /* All source ISR execution are done */
> +        if (!s->regs[addr]) {
> +            trace_aspeed_intc_all_isr_done(irq);
> +            if (s->pending[irq]) {
> +                /*
> +                 * handle pending source interrupt
> +                 * notify firmware which source interrupt are pending
> +                 * by setting status register
> +                 */
> +                s->regs[addr] = s->pending[irq];
> +                s->pending[irq] = 0;
> +                trace_aspeed_intc_trigger_irq(irq, s->regs[addr]);
> +                aspeed_intc_update(s, irq, 1);
> +            } else {
> +                /* clear irq */
> +                trace_aspeed_intc_clear_irq(irq, 0);
> +                aspeed_intc_update(s, irq, 0);
> +            }
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
> +    AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
> +    int i;
> +
> +    assert(aic->num_ints <= ASPEED_INTC_NR_INTS);
> +    for (i = 0; i < aic->num_ints; i++) {
> +        object_initialize_child(obj, "intc-orgates[*]", &s->orgates[i],
> +                                TYPE_OR_IRQ);
> +        object_property_set_int(OBJECT(&s->orgates[i]), "num-lines",
> +                                aic->num_lines, &error_abort);
> +    }
> +}
> +
> +static void aspeed_intc_reset(DeviceState *dev)
> +{
> +    AspeedINTCState *s = ASPEED_INTC(dev);
> +
> +    memset(s->regs, 0, sizeof(s->regs));
> +    memset(s->enable, 0, sizeof(s->enable));
> +    memset(s->mask, 0, sizeof(s->mask));
> +    memset(s->pending, 0, sizeof(s->pending));
> +}
> +
> +static void aspeed_intc_realize(DeviceState *dev, Error **errp)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    AspeedINTCState *s = ASPEED_INTC(dev);
> +    AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
> +    int i;
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_intc_ops, s,
> +                          TYPE_ASPEED_INTC ".regs", ASPEED_INTC_NR_REGS << 2);
> +
> +    sysbus_init_mmio(sbd, &s->iomem);
> +    qdev_init_gpio_in(dev, aspeed_intc_set_irq, aic->num_ints);
> +
> +    for (i = 0; i < aic->num_ints; i++) {
> +        if (!qdev_realize(DEVICE(&s->orgates[i]), NULL, errp)) {
> +            return;
> +        }
> +        sysbus_init_irq(sbd, &s->output_pins[i]);
> +    }
> +}
> +
> +static void aspeed_intc_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->desc = "ASPEED INTC Controller";
> +    dc->realize = aspeed_intc_realize;
> +    dc->reset = aspeed_intc_reset;
> +    dc->vmsd = NULL;
> +}
> +
> +static const TypeInfo aspeed_intc_info = {
> +    .name = TYPE_ASPEED_INTC,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_init = aspeed_intc_instance_init,
> +    .instance_size = sizeof(AspeedINTCState),
> +    .class_init = aspeed_intc_class_init,
> +    .abstract = true,
> +};
> +
> +static void aspeed_2700_intc_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    AspeedINTCClass *aic = ASPEED_INTC_CLASS(klass);
> +
> +    dc->desc = "ASPEED 2700 INTC Controller";
> +    aic->num_lines = 32;
> +    aic->num_ints = 9;
> +}
> +
> +static const TypeInfo aspeed_2700_intc_info = {
> +    .name = TYPE_ASPEED_2700_INTC,
> +    .parent = TYPE_ASPEED_INTC,
> +    .class_init = aspeed_2700_intc_class_init,
> +};
> +
> +static void aspeed_intc_register_types(void)
> +{
> +    type_register_static(&aspeed_intc_info);
> +    type_register_static(&aspeed_2700_intc_info);
> +}
> +
> +type_init(aspeed_intc_register_types);
> diff --git a/hw/intc/meson.build b/hw/intc/meson.build
> index 0d1b7d0a43..afd1aa51ee 100644
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
> index b815cea129..3dcf147198 100644
> --- a/hw/intc/trace-events
> +++ b/hw/intc/trace-events
> @@ -79,6 +79,19 @@ aspeed_vic_update_fiq(int flags) "Raising FIQ: %d"
>   aspeed_vic_update_irq(int flags) "Raising IRQ: %d"
>   aspeed_vic_read(uint64_t offset, unsigned size, uint32_t value) "From 0x%" PRIx64 " of size %u: 0x%" PRIx32
>   aspeed_vic_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
> +# aspeed_intc.c
> +aspeed_intc_read(uint64_t offset, unsigned size, uint32_t value) "From 0x%" PRIx64 " of size %u: 0x%" PRIx32
> +aspeed_intc_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
> +aspeed_intc_set_irq(int irq, int level) "Set IRQ %d: %d"
> +aspeed_intc_clear_irq(int irq, int level) "Clear IRQ %d: %d"
> +aspeed_intc_update_irq(int irq, int level) "Update IRQ: %d: %d"
> +aspeed_intc_pending_irq(int irq, uint32_t value) "Pending IRQ: %d: 0x%x"
> +aspeed_intc_trigger_irq(int irq, uint32_t value) "Trigger IRQ: %d: 0x%x"
> +aspeed_intc_all_isr_done(int irq) "All source ISR execution are done: %d"
> +aspeed_intc_enable(uint32_t value) "Enable: 0x%x"
> +aspeed_intc_select(uint32_t value) "Select: 0x%x"
> +aspeed_intc_mask(uint32_t change, uint32_t value) "Mask: 0x%x: 0x%x"
> +aspeed_intc_unmask(uint32_t change, uint32_t value) "UnMask: 0x%x: 0x%x"
>   
>   # arm_gic.c
>   gic_enable_irq(int irq) "irq %d enabled"
> diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h
> new file mode 100644
> index 0000000000..18cb43476c
> --- /dev/null
> +++ b/include/hw/intc/aspeed_intc.h
> @@ -0,0 +1,44 @@
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
> +#define TYPE_ASPEED_2700_INTC TYPE_ASPEED_INTC "-ast2700"
> +OBJECT_DECLARE_TYPE(AspeedINTCState, AspeedINTCClass, ASPEED_INTC)
> +
> +#define ASPEED_INTC_NR_REGS (0x2000 >> 2)
> +#define ASPEED_INTC_NR_INTS 9
> +
> +struct AspeedINTCState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/
> +    MemoryRegion iomem;
> +    uint32_t regs[ASPEED_INTC_NR_REGS];
> +    OrIRQState orgates[ASPEED_INTC_NR_INTS];
> +    qemu_irq output_pins[ASPEED_INTC_NR_INTS];
> +
> +    uint32_t enable[ASPEED_INTC_NR_INTS];
> +    uint32_t mask[ASPEED_INTC_NR_INTS];
> +    uint32_t pending[ASPEED_INTC_NR_INTS];
> +};
> +
> +struct AspeedINTCClass {
> +    SysBusDeviceClass parent_class;
> +
> +    uint32_t num_lines;
> +    uint32_t num_ints;
> +};
> +
> +#endif /* ASPEED_INTC_H */


