Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F157CF8848
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 11:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM3Cd-0004dU-NK; Thu, 20 Nov 2025 06:51:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vM3Cc-0004d0-90
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 06:51:54 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vM3Ca-0002EW-48
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 06:51:54 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c75fd8067fso475638a34.2
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 03:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1763639511; x=1764244311; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4M+oichSv/HuVecZkWvfD9clcnZ++q2Q16ttqO2f7es=;
 b=j4E/hopcvbuP/Vo4lJzz1ZV+x04JBTTi+sCyxizECDXM03taRDi0mgL5H3zCzwBWQl
 wW/4anQ5ZJ+Eh6h5L+8qvEYtRqhDz9YuYiBQp09/OGxP+nPgrZEXceQ9WDZS4zmE3317
 uH6nlo9YCH1OJ0tErF6S0JwzBYnA0CsHnNAt9S1vaun3Nsdsq/n61O595iPMQHDwmhdg
 LWc3APIT6irKG2OamknMirKJ4TvuN3/qnDqnoE+t0nJZoEnrz6f0yvsOZ0SgSG/s86IN
 hQST2/ya3cnEf6UiwCqLHJfOnOlaBem+4PGKQk5OPh+U3zOdLEiZ8HhbIO/qaGr0EFWc
 UbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763639511; x=1764244311;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4M+oichSv/HuVecZkWvfD9clcnZ++q2Q16ttqO2f7es=;
 b=K0UaTBtaf6NxpJOhm9s90ixVjVhOIZb9+SpH+oUQGkO5bZZGLpOzZv3WOtQXfgS1R8
 eZgesHoNtIQfzButJPl4X/rndFl47xlg5BqDOti23Rvfk/+qBX+dT0D/M2WYasUjydpZ
 6QNRKdQZ79Egyxfc361XJW8P17OihXCqmiMmPp3QAHiBafkTKjWzMX5g7H4egfml9ih4
 PRq/i6D+IqQ1jLyR8QjAPtN6c4zFIQLDuGEukJ+bxsQVRLzmzJmvb3jntLe8QLZIQVWP
 aKREhIIZZ80e/9H5QD6mlR2etGj82aReepFR2+mS7VYRRNof5L/EVgz+L4mr6hVOjasl
 qTMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYlux71/VEY98wq89hV7ngmzSOkhttU8699PtOwOKXyH1TxmGdNHhzlTPuudYLO4XOiIUEOcd7SMb8@nongnu.org
X-Gm-Message-State: AOJu0YyKKlChaZfYkq49LLfUf/FhsnswhvDvlwtJQD1lYxFRsAJx6NMB
 fmJBv2NKB1az7RIKRBiL9DmIZlA9Xdlq6QT2ijNte/A96NhVCTu/tXawoH3/alFUXHU=
X-Gm-Gg: ASbGncsg41tkSnblQtkLu4e8bmrWYo3YJue9FJN1uoPmvspny6YEURQjNmj1sFdvx9p
 bVK10Ix9RGOs0IdChkyKZ4uozUsRLopjm7k3hehOpdl9QUzf8qd16I1RDyz99F9GIpCsyopLTvF
 HALblp9cWd7uI5jTjWmKXYflEcZDn5AcB3Z+Wyl89mV59tITJymlLF5rE0/8FAI5q3rNji26YdR
 lwTF7zWTOKqgP5a5W5O5M5zQ2gGM6hUjE/H/qk+OOUz7LBaRpd+/1+P6GbtJ9CA7rCXK2ARGaIm
 qmLdnBbwx8BCVIP4PaIE0UqbQcBNt7ou5uEdduFxCp2G20aQf8qRjWnCPe64f2jG6A+/lLkTiLg
 0lrCcancMbz3oTMfiyce1FXu6H6F4a06dagD09/SLuIg0V150rc2KBiPy6wa/dV9OkbPTv3pNeW
 +kI3d/qiCO/fyWTz26W5R3C9+jPzEK9S1j9wMC4w==
X-Google-Smtp-Source: AGHT+IGh+c+I1DCVfv0ULtCxij8sjDjKQl4VEO0jqrM+6B3FNR4wiQdEVFyykPyYIyMUHvxUvSUogQ==
X-Received: by 2002:a05:6830:449e:b0:7c7:e5a:5c68 with SMTP id
 46e09a7af769-7c78d26692cmr1885343a34.16.1763639510762; 
 Thu, 20 Nov 2025 03:51:50 -0800 (PST)
Received: from [192.168.68.110] ([177.188.133.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c78d3e3b5esm894212a34.15.2025.11.20.03.51.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 03:51:49 -0800 (PST)
Message-ID: <92645282-ddfd-4b50-89fa-e6d1d546cde2@ventanamicro.com>
Date: Thu, 20 Nov 2025 08:51:43 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] hw/riscv: implement CBQRI bandwidth controller
To: Drew Fustini <fustini@kernel.org>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Nicolas Pitre <npitre@baylibre.com>, =?UTF-8?Q?Kornel_Dul=C4=99ba?=
 <mindal@semihalf.com>, Atish Kumar Patra <atishp@rivosinc.com>,
 Atish Patra <atish.patra@linux.dev>, Vasudevan Srinivasan
 <vasu@rivosinc.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?=
 <rkrcmar@ventanamicro.com>, yunhui cui <cuiyunhui@bytedance.com>,
 Chen Pei <cp0613@linux.alibaba.com>, guo.wenjia23@zte.com.cn,
 liu.qingtao2@zte.com.cn
References: <20251119-riscv-ssqosid-cbqri-v1-0-3392fc760e48@kernel.org>
 <20251119-riscv-ssqosid-cbqri-v1-4-3392fc760e48@kernel.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251119-riscv-ssqosid-cbqri-v1-4-3392fc760e48@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32c.google.com
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



On 11/19/25 9:42 PM, Drew Fustini wrote:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> Implement a bandwidth controller according to the Capacity and Bandwidth
> QoS Register Interface (CBQRI) which supports these capabilities:
> 
>    - Number of access types: 2 (code and data)
>    - Usage monitoring operations: CONFIG_EVENT, READ_COUNTER
>    - Event IDs supported: None, Total read/write byte count, Total
>                           read byte count, Total write byte count
>    - Bandwidth allocation operations: CONFIG_LIMIT, READ_LIMIT
> 
> Link: https://github.com/riscv-non-isa/riscv-cbqri/blob/main/riscv-cbqri.pdf
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> [fustini: add fields introduced in the ratified spec: rpfx and p]
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
>   MAINTAINERS                |   1 +
>   hw/riscv/cbqri_bandwidth.c | 613 +++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 614 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 48cca4ac8702..16500c4e8a83 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -362,6 +362,7 @@ M: Nicolas Pitre <npitre@baylibre.com>
>   M: Drew Fustini <fustini@kernel.org>
>   L: qemu-riscv@nongnu.org
>   S: Supported
> +F: hw/riscv/cbqri_bandwidth.c
>   F: hw/riscv/cbqri_capacity.c
>   F: include/hw/riscv/cbqri.h
>   
> diff --git a/hw/riscv/cbqri_bandwidth.c b/hw/riscv/cbqri_bandwidth.c
> new file mode 100644
> index 000000000000..40357a3219d8
> --- /dev/null
> +++ b/hw/riscv/cbqri_bandwidth.c
> @@ -0,0 +1,613 @@
> +/*
> + * RISC-V Capacity and Bandwidth QoS Register Interface
> + * URL: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
> + *
> + * Copyright (c) 2023 BayLibre SAS
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This file contains the Bandwidth-controller QoS Register Interface.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/sysbus.h"
> +#include "target/riscv/cpu.h"
> +#include "hw/riscv/cbqri.h"
> +

[...]

> +static void riscv_cbqri_bc_write(void *opaque, hwaddr addr,
> +                                 uint64_t value, unsigned size)
> +{
> +    RiscvCbqriBandwidthState *bc = opaque;
> +
> +    assert((addr % 8) == 0);
> +    assert(size == 8);

Same comment I made on patch 3: both callbacks are asserting if size == 8. This can be
avoided by setting the minimal access size in riscv_cbqri_bc_ops to 8.


Thanks,

Daniel

> +
> +    switch (addr) {
> +    case A_BC_CAPABILITIES:
> +        /* read-only register */
> +        break;
> +    case A_BC_MON_CTL:
> +        riscv_cbqri_bc_write_mon_ctl(bc, value);
> +        break;
> +    case A_BC_MON_CTR_VAL:
> +        /* read-only register */
> +        break;
> +    case A_BC_ALLOC_CTL:
> +        riscv_cbqri_bc_write_alloc_ctl(bc, value);
> +        break;
> +    case A_BC_BW_ALLOC:
> +        riscv_cbqri_bc_write_bw_alloc(bc, value);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: out of bounds (addr=0x%x)",
> +                      __func__, (uint32_t)addr);
> +    }
> +}
> +
> +static uint64_t riscv_cbqri_bc_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    RiscvCbqriBandwidthState *bc = opaque;
> +    uint64_t value = 0;
> +
> +    assert((addr % 8) == 0);
> +    assert(size == 8);
> +
> +    switch (addr) {
> +    case A_BC_CAPABILITIES:
> +        value = FIELD_DP64(value, BC_CAPABILITIES, VER_MAJOR,
> +                           RISCV_CBQRI_VERSION_MAJOR);
> +        value = FIELD_DP64(value, BC_CAPABILITIES, VER_MINOR,
> +                           RISCV_CBQRI_VERSION_MINOR);
> +        value = FIELD_DP64(value, BC_CAPABILITIES, RPFX,
> +                           bc->rpfx);
> +        value = FIELD_DP64(value, BC_CAPABILITIES, P,
> +                           bc->p);
> +        value = FIELD_DP64(value, BC_CAPABILITIES, NBWBLKS,
> +                           bc->nbwblks);
> +        value = FIELD_DP64(value, BC_CAPABILITIES, MRBWB,
> +                           bc->mrbwb);
> +        break;
> +    case A_BC_MON_CTL:
> +        value = bc->bc_mon_ctl;
> +        break;
> +    case A_BC_MON_CTR_VAL:
> +        value = bc->bc_mon_ctr_val;
> +        break;
> +    case A_BC_ALLOC_CTL:
> +        value = bc->bc_alloc_ctl;
> +        break;
> +    case A_BC_BW_ALLOC:
> +        BandwidthAllocation *bc_bw_alloc = &bc->bw_allocations[0];
> +        value = FIELD_DP64(value, BC_BW_ALLOC, Rbwb, bc_bw_alloc->Rbwb);
> +        value = FIELD_DP64(value, BC_BW_ALLOC, Mweight, bc_bw_alloc->Mweight);
> +        value = FIELD_DP64(value, BC_BW_ALLOC, sharedAT, bc_bw_alloc->sharedAT);
> +        value = FIELD_DP64(value, BC_BW_ALLOC, useShared,
> +                           bc_bw_alloc->useShared);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: out of bounds (addr=0x%x)",
> +                      __func__, (uint32_t)addr);
> +    }
> +
> +    return value;
> +}
> +
> +static const MemoryRegionOps riscv_cbqri_bc_ops = {
> +    .read = riscv_cbqri_bc_read,
> +    .write = riscv_cbqri_bc_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 8,
> +    .impl.min_access_size = 8,
> +    .impl.max_access_size = 8,
> +};
> +
> +static void riscv_cbqri_bc_realize(DeviceState *dev, Error **errp)
> +{
> +    RiscvCbqriBandwidthState *bc = RISCV_CBQRI_BC(dev);
> +
> +    if (!bc->mmio_base) {
> +        error_setg(errp, "mmio_base property not set");
> +        return;
> +    }
> +
> +    assert(bc->mon_counters == NULL);
> +    bc->mon_counters = g_new0(MonitorCounter, bc->nb_mcids);
> +
> +    assert(bc->bw_allocations == NULL);
> +    BandwidthAllocation *bw_alloc_end = get_bw_alloc(bc, bc->nb_rcids, 0);
> +    unsigned int bw_alloc_size = bw_alloc_end - bc->bw_allocations;
> +    bc->bw_allocations = g_new0(BandwidthAllocation, bw_alloc_size);
> +
> +    memory_region_init_io(&bc->mmio, OBJECT(dev), &riscv_cbqri_bc_ops,
> +                          bc, TYPE_RISCV_CBQRI_BC".mmio", 4 * 1024);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &bc->mmio);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, bc->mmio_base);
> +}
> +
> +static void riscv_cbqri_bc_reset(DeviceState *dev)
> +{
> +    RiscvCbqriBandwidthState *bc = RISCV_CBQRI_BC(dev);
> +
> +    bc->bc_mon_ctl = 0;
> +    bc->bc_alloc_ctl = 0;
> +}
> +
> +static Property riscv_cbqri_bc_properties[] = {
> +    DEFINE_PROP_UINT64("mmio_base", RiscvCbqriBandwidthState, mmio_base, 0),
> +    DEFINE_PROP_STRING("target", RiscvCbqriBandwidthState, target),
> +
> +    DEFINE_PROP_UINT16("max_mcids", RiscvCbqriBandwidthState, nb_mcids, 256),
> +    DEFINE_PROP_UINT16("max_rcids", RiscvCbqriBandwidthState, nb_rcids, 64),
> +    DEFINE_PROP_UINT16("nbwblks", RiscvCbqriBandwidthState, nbwblks, 1024),
> +    DEFINE_PROP_UINT16("mrbwb", RiscvCbqriBandwidthState, mrbwb, 819),
> +
> +    DEFINE_PROP_BOOL("rpfx", RiscvCbqriBandwidthState, rpfx, true),
> +    DEFINE_PROP_UINT8("p", RiscvCbqriBandwidthState, p, 4),
> +
> +    DEFINE_PROP_BOOL("at_data", RiscvCbqriBandwidthState,
> +                     supports_at_data, true),
> +    DEFINE_PROP_BOOL("at_code", RiscvCbqriBandwidthState,
> +                     supports_at_code, true),
> +
> +    DEFINE_PROP_BOOL("alloc_op_config_limit", RiscvCbqriBandwidthState,
> +                     supports_alloc_op_config_limit, true),
> +    DEFINE_PROP_BOOL("alloc_op_read_limit", RiscvCbqriBandwidthState,
> +                     supports_alloc_op_read_limit, true),
> +
> +    DEFINE_PROP_BOOL("mon_op_config_event", RiscvCbqriBandwidthState,
> +                     supports_mon_op_config_event, true),
> +    DEFINE_PROP_BOOL("mon_op_read_counter", RiscvCbqriBandwidthState,
> +                     supports_mon_op_read_counter, true),
> +
> +    DEFINE_PROP_BOOL("mon_evt_id_none", RiscvCbqriBandwidthState,
> +                     supports_mon_evt_id_none, true),
> +    DEFINE_PROP_BOOL("mon_evt_id_rdwr_count", RiscvCbqriBandwidthState,
> +                     supports_mon_evt_id_rdwr_count, true),
> +    DEFINE_PROP_BOOL("mon_evt_id_rdonly_count", RiscvCbqriBandwidthState,
> +                     supports_mon_evt_id_rdonly_count, true),
> +    DEFINE_PROP_BOOL("mon_evt_id_wronly_count", RiscvCbqriBandwidthState,
> +                     supports_mon_evt_id_wronly_count, true),
> +};
> +
> +static void riscv_cbqri_bc_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    dc->realize = riscv_cbqri_bc_realize;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    dc->desc = "RISC-V CBQRI Bandwidth Controller";
> +    device_class_set_props(dc, riscv_cbqri_bc_properties);
> +    dc->legacy_reset = riscv_cbqri_bc_reset;
> +    dc->user_creatable = true;
> +}
> +
> +static const TypeInfo riscv_cbqri_bc_info = {
> +    .name          = TYPE_RISCV_CBQRI_BC,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(RiscvCbqriBandwidthState),
> +    .class_init    = riscv_cbqri_bc_class_init,
> +};
> +
> +static void riscv_cbqri_bc_register_types(void)
> +{
> +    type_register_static(&riscv_cbqri_bc_info);
> +}
> +
> +DeviceState *riscv_cbqri_bc_create(hwaddr addr,
> +                                   const RiscvCbqriBandwidthCaps *caps,
> +                                   const char *target_name)
> +{
> +    DeviceState *dev = qdev_new(TYPE_RISCV_CBQRI_BC);
> +
> +    qdev_prop_set_uint64(dev, "mmio_base", addr);
> +    qdev_prop_set_string(dev, "target", target_name);
> +    qdev_prop_set_uint16(dev, "max_mcids", caps->nb_mcids);
> +    qdev_prop_set_uint16(dev, "max_rcids", caps->nb_rcids);
> +    qdev_prop_set_uint16(dev, "nbwblks", caps->nbwblks);
> +    qdev_prop_set_bit(dev, "rpfx", caps->rpfx);
> +    qdev_prop_set_uint8(dev, "p", caps->p);
> +
> +    qdev_prop_set_bit(dev, "at_data",
> +                      caps->supports_at_data);
> +    qdev_prop_set_bit(dev, "at_code",
> +                      caps->supports_at_code);
> +    qdev_prop_set_bit(dev, "alloc_op_config_limit",
> +                      caps->supports_alloc_op_config_limit);
> +    qdev_prop_set_bit(dev, "alloc_op_read_limit",
> +                      caps->supports_alloc_op_read_limit);
> +    qdev_prop_set_bit(dev, "mon_op_config_event",
> +                      caps->supports_mon_op_config_event);
> +    qdev_prop_set_bit(dev, "mon_op_read_counter",
> +                      caps->supports_mon_op_read_counter);
> +    qdev_prop_set_bit(dev, "mon_evt_id_none",
> +                      caps->supports_mon_evt_id_none);
> +    qdev_prop_set_bit(dev, "mon_evt_id_rdwr_count",
> +                      caps->supports_mon_evt_id_rdwr_count);
> +    qdev_prop_set_bit(dev, "mon_evt_id_rdonly_count",
> +                      caps->supports_mon_evt_id_rdonly_count);
> +    qdev_prop_set_bit(dev, "mon_evt_id_wronly_count",
> +                      caps->supports_mon_evt_id_wronly_count);
> +
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    return dev;
> +}
> +
> +type_init(riscv_cbqri_bc_register_types)
> 


