Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1328CCF9C7B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 18:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM90Z-0002gi-7F; Thu, 20 Nov 2025 13:03:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <k.semichastnov@syntacore.com>)
 id 1vM90V-0002fq-BD; Thu, 20 Nov 2025 13:03:49 -0500
Received: from m.syntacore.com ([178.249.69.228])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <k.semichastnov@syntacore.com>)
 id 1vM90S-00080o-Fr; Thu, 20 Nov 2025 13:03:47 -0500
Received: from MRN-SC-KSMG-01.corp.syntacore.com (localhost [127.0.0.1])
 by m.syntacore.com (Postfix) with ESMTP id C23681A0004;
 Thu, 20 Nov 2025 18:03:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 m.syntacore.com C23681A0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com; s=m;
 t=1763661820; bh=AyIZJzlb8aUQdqyWUISIrhOVoYxaGPmPJ2HcvJ2j4XE=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=QEidM25jbx3rsip7edqzHQqdNzQcs6I7mOqT6Cr0N5lo14NABOJ6JPeIDJ2KHWJsy
 hWC6d/nhKD0QBm8F4phTWrnM0DTbK0olaviCWNPiRBBCZi4wu6gusKEZ1+6Nww7DIq
 1C+ijeHNkZjMgZCVUFe0xdgt3TFqYekc67xDkfNGHyNoRaI1BgQtiZkCCehQVZ5UfX
 1Qo+Ebg99FzvTTfvGuh/aBZ+2vCmUq7DKLOEv+wdCWevFeDTbei0xBy1HwMyelOm9F
 7Yspqcoqt2mJGC3416WyIHR0PnECPasRI3IkuUYatce5hcmS+t4kHYTR49rGKhTG2I
 w9+y3Zkqk6aRQ==
Received: from S-SC-EXCH-01.corp.syntacore.com (mail.syntacore.com
 [10.76.202.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by m.syntacore.com (Postfix) with ESMTPS;
 Thu, 20 Nov 2025 18:03:39 +0000 (UTC)
Received: from [10.199.147.170] (10.199.147.170) by
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 20 Nov 2025 21:03:31 +0300
Message-ID: <0dd528f1-8785-4cdb-a462-b93f81eeb837@syntacore.com>
Date: Thu, 20 Nov 2025 21:03:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/17] hw/riscv: Trace RAM Sink initial impl
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <alistair.francis@wdc.com>,
 <liwei1518@gmail.com>, <zhiwei_liu@linux.alibaba.com>, <palmer@dabbelt.com>
References: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
 <20251111114656.2285048-3-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Konstantin Semichastnov <k.semichastnov@syntacore.com>
In-Reply-To: <20251111114656.2285048-3-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.199.147.170]
X-ClientProxiedBy: S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) To
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20)
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310,
 bases: 2025/11/20 15:27:00 #27953042
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/11/20 17:24:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
Received-SPF: pass client-ip=178.249.69.228;
 envelope-from=k.semichastnov@syntacore.com; helo=m.syntacore.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 11/11/25 14:46, Daniel Henrique Barboza wrote:
> Following the effort to implement the basic support for Efficient Trace
> (e-trace) in QEMU we'll add a Trace RAM Sink implementation.
> 
> Similar to the Trace Encoder, this is inspired in both the Efficient
> Trace for RISC-V [1] and  RISC-V Trace Control Interface Specification
> [2] specs. It implements a minimal set of features to get started - only
> SMEM will be supported for now.
> 
> We'll implement the RAM sink logic in the next patches, although most of
> the work will be done by the trace encoder.
> 
> [1] https://github.com/riscv-non-isa/riscv-trace-spec/releases/download/v2.0-20250616/riscv-trace-spec-asciidoc.pdf
> [2] https://github.com/riscv-non-isa/tg-nexus-trace/releases/download/1.0_Ratified/RISC-V-Trace-Control-Interface.pdf
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   hw/riscv/meson.build      |   2 +-
>   hw/riscv/trace-events     |   4 +
>   hw/riscv/trace-ram-sink.c | 263 ++++++++++++++++++++++++++++++++++++++
>   hw/riscv/trace-ram-sink.h |  83 ++++++++++++
>   4 files changed, 351 insertions(+), 1 deletion(-)
>   create mode 100644 hw/riscv/trace-ram-sink.c
>   create mode 100644 hw/riscv/trace-ram-sink.h
> 
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index b4a9988a62..2aadbe1e50 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -14,6 +14,6 @@ riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
>   	'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv-iommu-hpm.c'))
>   riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
>   riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c'))
> -riscv_ss.add(when: 'CONFIG_RISCV_TRACE', if_true: files('trace-encoder.c'))
> +riscv_ss.add(when: 'CONFIG_RISCV_TRACE', if_true: files('trace-encoder.c', 'trace-ram-sink.c'))
>   
>   hw_arch += {'riscv': riscv_ss}
> diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
> index 0cbf6ffcb6..14e333fd9e 100644
> --- a/hw/riscv/trace-events
> +++ b/hw/riscv/trace-events
> @@ -28,3 +28,7 @@ riscv_iommu_hpm_evt_write(uint32_t ctr_idx, uint32_t ovf, uint64_t val) "ctr_idx
>   # trace-encoder.c
>   trencoder_read_error(uint64_t addr) "addr 0x%" PRIx64
>   trencoder_write_error(uint64_t addr, uint64_t value) "addr 0x%" PRIx64 " value 0x%" PRIx64
> +
> +# trace-ram-sink.c
> +tr_ramsink_read_error(uint64_t addr) "addr 0x%" PRIx64
> +tr_ramsink_write_error(uint64_t addr, uint64_t value) "addr 0x%" PRIx64 " value 0x%" PRIx64
> diff --git a/hw/riscv/trace-ram-sink.c b/hw/riscv/trace-ram-sink.c
> new file mode 100644
> index 0000000000..e00de80c04
> --- /dev/null
> +++ b/hw/riscv/trace-ram-sink.c
> @@ -0,0 +1,263 @@
> +/*
> + * Emulation of a RISC-V Trace RAM Sink
> + *
> + * Copyright (C) 2025 Ventana Micro Systems Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "trace-ram-sink.h"
> +#include "hw/irq.h"
> +#include "hw/qdev-properties.h"
> +#include "migration/vmstate.h"
> +#include "qemu/bitops.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qapi/error.h"
> +#include "trace.h"
> +#include "system/device_tree.h"
> +#include "hw/sysbus.h"
> +#include "hw/register.h"
> +
> +#define R_TR_RAM_CONTROL_RSVP_BITS (MAKE_64BIT_MASK(32, 32) | \
> +                                    R_TR_RAM_CONTROL_RSVP1_MASK | \
> +                                    R_TR_RAM_CONTROL_RSVP2_MASK | \
> +                                    R_TR_RAM_CONTROL_RSVP3_MASK | \
> +                                    R_TR_RAM_CONTROL_RSVP4_MASK)
> +
> +/* trRamEmpty is the only RO field and reset value */
> +#define R_TR_RAM_CONTROL_RESET R_TR_RAM_CONTROL_EMPTY_MASK
> +#define R_TR_RAM_CONTROL_RO_BITS R_TR_RAM_CONTROL_EMPTY_MASK
> +
> +#define R_TR_RAM_IMPL_RSVP_BITS (MAKE_64BIT_MASK(32, 32) | \
> +                                 R_TR_RAM_IMPL_RSVP1_MASK)
> +
> +#define R_TR_RAM_IMPL_RO_BITS (R_TR_RAM_IMPL_VER_MAJOR_MASK | \
> +                               R_TR_RAM_IMPL_VER_MINOR_MASK | \
> +                               R_TR_RAM_IMPL_COMP_TYPE_MASK | \
> +                               R_TR_RAM_IMPL_HAS_SRAM_MASK | \
> +                               R_TR_RAM_IMPL_HAS_SMEM_MASK)
> +
> +#define R_TR_RAM_IMPL_RESET (BIT(0) | 0x9 << 8)
I suggest to set here trRamHasSMEM bit to 1, because we actually do have 
SMEM supported

> +
> +static RegisterAccessInfo tr_ramsink_regs_info[] = {
> +    {   .name = "TR_RAM_CONTROL", .addr = A_TR_RAM_CONTROL,
> +        .rsvd = R_TR_RAM_CONTROL_RSVP_BITS,
> +        .reset = R_TR_RAM_CONTROL_RESET,
> +        .ro = R_TR_RAM_CONTROL_RO_BITS,
> +    },
> +    {   .name = "TR_RAM_IMPL", .addr = A_TR_RAM_IMPL,
> +        .rsvd = R_TR_RAM_IMPL_RSVP_BITS,
> +        .reset = R_TR_RAM_IMPL_RESET,
> +        .ro = R_TR_RAM_IMPL_RO_BITS,
> +    },
> +    {   .name = "TR_RAM_START_LOW", .addr = A_TR_RAM_START_LOW,
> +    },
> +    {   .name = "TR_RAM_START_HIGH", .addr = A_TR_RAM_START_HIGH,
> +    },
> +    {   .name = "TR_RAM_LIMIT_LOW", .addr = A_TR_RAM_LIMIT_LOW,
> +    },
> +    {   .name = "TR_RAM_LIMIT_HIGH", .addr = A_TR_RAM_LIMIT_HIGH,
> +    },
> +    {   .name = "TR_RAM_WP_LOW", .addr = A_TR_RAM_WP_LOW,
> +    },
> +    {   .name = "TR_RAM_WP_HIGH", .addr = A_TR_RAM_WP_HIGH,
> +    },
> +};
> +
> +static uint64_t tr_ramsink_regread(void *opaque, hwaddr addr, unsigned size)
> +{
> +    TraceRamSink *tram = TRACE_RAM_SINK(opaque);
> +    RegisterInfo *r = &tram->regs_info[addr / 4];
> +
> +    if (!r->data) {
> +        trace_tr_ramsink_read_error(addr);
> +        return 0;
> +    }
> +
> +    return register_read(r, ~0, NULL, false);
> +}
> +
> +static void tr_ramsink_regwrite(void *opaque, hwaddr addr,
> +                            uint64_t value, unsigned size)
> +{
> +    TraceRamSink *tram = TRACE_RAM_SINK(opaque);
> +    RegisterInfo *r = &tram->regs_info[addr / 4];
> +
> +    if (!r->data) {
> +        trace_tr_ramsink_write_error(addr, value);
> +        return;
> +    }
> +
> +    register_write(r, value, ~0, NULL, false);
> +}
> +
> +static const MemoryRegionOps tr_ramsink_regops = {
> +    .read = tr_ramsink_regread,
> +    .write = tr_ramsink_regwrite,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static uint64_t tr_ramsink_msgread(void *opaque, hwaddr addr, unsigned size)
> +{
> +    TraceRamSink *tram = TRACE_RAM_SINK(opaque);
> +
> +    switch (size) {
> +    case 1:
> +        return tram->msgs[addr];
> +    case 2:
> +        return (uint16_t)tram->msgs[addr];
> +    case 4:
> +        return (uint32_t)tram->msgs[addr];
> +    default:
> +        g_assert_not_reached();
> +    }
Here we will always return single byte, because tram->msgs has
type (uint8_t *)

So, I suggest to call here little endian load helper
to avoid manually handling size and byte order:

ldn_le_p(tram->msgs + addr, size)

> +}
> +
> +static void tr_ramsink_msgwrite(void *opaque, hwaddr addr,
> +                                uint64_t value, unsigned size)
> +{
> +    TraceRamSink *tram = TRACE_RAM_SINK(opaque);
> +
> +    switch (size) {
> +    case 1:
> +        tram->msgs[addr] = value;
> +        break;
> +    case 2:
> +        tram->msgs[addr] = extract16(value, 0, 8);
> +        tram->msgs[addr + 1] = extract16(value, 8, 8);
> +        break;
> +    case 4:
> +        tram->msgs[addr] = extract32(value, 0, 8);
> +        tram->msgs[addr + 1] = extract32(value, 8, 8);
> +        tram->msgs[addr + 2] = extract32(value, 16, 8);
> +        tram->msgs[addr + 3] = extract32(value, 24, 8);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
Here also we can use little endian store helper to avoid
handling write size and byte order:

stn_le_p(tram->msgs + addr, size, value)

> +}
> +
> +static const MemoryRegionOps tr_ramsink_smemops = {
> +    .read = tr_ramsink_msgread,
> +    .write = tr_ramsink_msgwrite,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static void tr_ramsink_setup_regs(TraceRamSink *tram)
> +{
> +    hwaddr ramlimit = tram->smemaddr + tram->smemsize;
> +
> +    ARRAY_FIELD_DP32(tram->regs, TR_RAM_START_LOW, ADDR,
> +                     extract64(tram->smemaddr, 2, 30));
> +    ARRAY_FIELD_DP32(tram->regs, TR_RAM_START_HIGH, ADDR,
> +                     extract64(tram->smemaddr, 32, 32));
> +
> +    ARRAY_FIELD_DP32(tram->regs, TR_RAM_WP_LOW, ADDR,
> +                     extract64(tram->smemaddr, 2, 30));
> +    ARRAY_FIELD_DP32(tram->regs, TR_RAM_WP_HIGH, ADDR,
> +                     extract64(tram->smemaddr, 32, 32));
> +
> +    ARRAY_FIELD_DP32(tram->regs, TR_RAM_LIMIT_LOW, ADDR,
> +                     extract64(ramlimit, 2, 30));
> +    ARRAY_FIELD_DP32(tram->regs, TR_RAM_LIMIT_HIGH, ADDR,
> +                     extract64(ramlimit, 32, 32));
> +}
> +
> +static void tr_ramsink_reset(DeviceState *dev)
> +{
> +    TraceRamSink *tram = TRACE_RAM_SINK(dev);
> +
> +    for (int i = 0; i < ARRAY_SIZE(tram->regs_info); i++) {
> +        register_reset(&tram->regs_info[i]);
> +    }
> +
> +    tr_ramsink_setup_regs(tram);
> +}
> +
> +static void tr_ramsink_realize(DeviceState *dev, Error **errp)
> +{
> +    TraceRamSink *tram = TRACE_RAM_SINK(dev);
> +
> +    memory_region_init_io(&tram->reg_mem, OBJECT(dev),
> +                          &tr_ramsink_regops, tram,
> +                          "trace-ram-sink-regs",
> +                          tram->reg_mem_size);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(tram), &tram->reg_mem);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(tram), 0, tram->baseaddr);
> +
> +    g_assert(tram->smemsize > 0);
> +    tram->msgs = g_malloc0(tram->smemsize);
> +
> +    memory_region_init_io(&tram->smem, OBJECT(dev),
> +                          &tr_ramsink_smemops, tram,
> +                          "trace-ram-sink-smem",
> +                          tram->smemsize);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &tram->smem);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, tram->smemaddr);
> +
> +    /* RegisterInfo init taken from hw/dma/xlnx-zdma.c */
> +    for (int i = 0; i < ARRAY_SIZE(tr_ramsink_regs_info); i++) {
> +        uint32_t reg_idx = tr_ramsink_regs_info[i].addr / 4;
> +        RegisterInfo *r = &tram->regs_info[reg_idx];
> +
> +        *r = (RegisterInfo) {
> +            .data = (uint8_t *)&tram->regs[reg_idx],
> +            .data_size = sizeof(uint32_t),
> +            .access = &tr_ramsink_regs_info[i],
> +            .opaque = tram,
> +        };
> +    }
> +}
> +
> +static const Property tr_ramsink_props[] = {
> +    DEFINE_PROP_UINT64("baseaddr", TraceRamSink, baseaddr, 0),
> +    DEFINE_PROP_UINT64("smemaddr", TraceRamSink, smemaddr, 0),
> +    DEFINE_PROP_UINT32("smemsize", TraceRamSink, smemsize, 0),
> +    DEFINE_PROP_UINT32("reg-mem-size", TraceRamSink,
> +                       reg_mem_size, TR_DEV_REGMAP_SIZE),
> +};
> +
> +static const VMStateDescription vmstate_tr_ramsink = {
> +    .name = TYPE_TRACE_RAM_SINK,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(regs, TraceRamSink, TRACE_R_MAX),
> +        VMSTATE_END_OF_LIST(),
> +    }
> +};
> +
> +static void tr_ramsink_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    device_class_set_legacy_reset(dc, tr_ramsink_reset);
> +    device_class_set_props(dc, tr_ramsink_props);
> +    dc->realize = tr_ramsink_realize;
> +    dc->vmsd = &vmstate_tr_ramsink;
> +}
> +
> +static const TypeInfo tr_ramsink_info = {
> +    .name          = TYPE_TRACE_RAM_SINK,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(TraceRamSink),
> +    .class_init    = tr_ramsink_class_init,
> +};
> +
> +static void tr_ramsink_register_types(void)
> +{
> +    type_register_static(&tr_ramsink_info);
> +}
> +
> +type_init(tr_ramsink_register_types)
> diff --git a/hw/riscv/trace-ram-sink.h b/hw/riscv/trace-ram-sink.h
> new file mode 100644
> index 0000000000..cd55145669
> --- /dev/null
> +++ b/hw/riscv/trace-ram-sink.h
> @@ -0,0 +1,83 @@
> +/*
> + * Emulation of a RISC-V Trace RAM Sink
> + *
> + * Copyright (C) 2025 Ventana Micro Systems Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef RISCV_TRACE_RAM_SINK_H
> +#define RISCV_TRACE_RAM_SINK_H
> +
> +#include "hw/register.h"
> +#include "hw/sysbus.h"
> +#include "system/dma.h"
> +#include "qom/object.h"
> +
> +#define TRACE_R_MAX (0xFFF / 4)
> +#define TR_DEV_REGMAP_SIZE 0x1000
> +
> +/*
> + * The Trace Encoder will read/write those regs so put their
> + * declaration in this header.
> + */
> +REG32(TR_RAM_CONTROL, 0x0)
> +    FIELD(TR_RAM_CONTROL, ACTIVE, 0, 1)
> +    FIELD(TR_RAM_CONTROL, ENABLE, 1, 1)
> +    FIELD(TR_RAM_CONTROL, EMPTY, 3, 1)
> +    FIELD(TR_RAM_CONTROL, MODE, 4, 1)
> +    FIELD(TR_RAM_CONTROL, STOP_ON_WRAP, 8, 1)
> +    FIELD(TR_RAM_CONTROL, MEM_FORMAT, 9, 2)
> +    /* reserved bits */
> +    FIELD(TR_RAM_CONTROL, RSVP1, 2, 1)
> +    FIELD(TR_RAM_CONTROL, RSVP2, 5, 2)
RSVP2 should be 3 bits long, as it occupies bits [7:5]

> +    FIELD(TR_RAM_CONTROL, RSVP3, 11, 1)
> +    FIELD(TR_RAM_CONTROL, RSVP4, 15, 16)
Here is the same typo: RSVP4 should be 17 bits long, as it occupies
bits [31:15]

> +
> +REG32(TR_RAM_IMPL, 0x4)
> +    FIELD(TR_RAM_IMPL, VER_MAJOR, 0, 4)
> +    FIELD(TR_RAM_IMPL, VER_MINOR, 4, 4)
> +    FIELD(TR_RAM_IMPL, COMP_TYPE, 8, 4)
> +    FIELD(TR_RAM_IMPL, HAS_SRAM, 12, 1)
> +    FIELD(TR_RAM_IMPL, HAS_SMEM, 13, 1)
> +    /* reserved bits */
> +    FIELD(TR_RAM_IMPL, RSVP1, 14, 18)
> +
> +REG32(TR_RAM_START_LOW, 0x010)
> +    FIELD(TR_RAM_START_LOW, ADDR, 2, 30)
> +REG32(TR_RAM_START_HIGH, 0x014)
> +    FIELD(TR_RAM_START_HIGH, ADDR, 0, 32)
> +
> +REG32(TR_RAM_LIMIT_LOW, 0x018)
> +    FIELD(TR_RAM_LIMIT_LOW, ADDR, 2, 30)
> +REG32(TR_RAM_LIMIT_HIGH, 0x01C)
> +    FIELD(TR_RAM_LIMIT_HIGH, ADDR, 0, 32)
> +
> +REG32(TR_RAM_WP_LOW, 0x020)
> +    FIELD(TR_RAM_WP_LOW, WRAP, 0, 1)
> +    FIELD(TR_RAM_WP_LOW, ADDR, 2, 30)
> +REG32(TR_RAM_WP_HIGH, 0x024)
> +    FIELD(TR_RAM_WP_HIGH, ADDR, 0, 32)
> +
> +struct TraceRamSink {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion reg_mem;
> +    uint32_t reg_mem_size;
> +
> +    hwaddr baseaddr;
> +    uint32_t regs[TRACE_R_MAX];
> +    RegisterInfo regs_info[TRACE_R_MAX];
> +
> +    hwaddr smemaddr;
> +    MemoryRegion smem;
> +    uint32_t smemsize;
> +    uint8_t *msgs;
> +};
> +
> +#define TYPE_TRACE_RAM_SINK "trace-ram-sink"
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(TraceRamSink, TRACE_RAM_SINK)
> +
> +#endif


