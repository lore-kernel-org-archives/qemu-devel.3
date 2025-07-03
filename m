Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE750C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXJWP-0005IF-Ld; Thu, 03 Jul 2025 08:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uXJWH-00052y-U0
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:58:30 -0400
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uXJWE-0002U6-AC
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:58:29 -0400
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7d20f799fe9so877599585a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 05:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1751547505; x=1752152305; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xGquS0T4BCAiIfRnjxxF1He+NeXz+guZa8prtYgPR6Y=;
 b=Cja2Zs4yfJTtawf54UULvvrjQ1iZl2DVBLE+LUxvRsSn3puQ10QTZCh8125eTX1J8H
 q+wlEjVHwFbACA6dbwgCigvRDAZBk0etse37vYvfuDwxH8SoLoS7qxcPcYHanTyepkic
 db5oMuXTVQXDv9Vgcd5XB6Qv+0wolB+Y7q7xnckQKqHcKUmzBd7fOioS/LXcjWz4Vcf3
 FKszk06lc6SlTdlPElX/26Q3dwYDiFmfK0Uj09OqivRNPVEpy7xP1SzIKijlU3QpgrE0
 Z5ZmUvoUFC/HkCUFWtIwbQDEVTmgSqWd5Icr28/9KBqXgjFjbwr5Yx0oK5KpUcqIz44b
 wdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751547505; x=1752152305;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xGquS0T4BCAiIfRnjxxF1He+NeXz+guZa8prtYgPR6Y=;
 b=GNOd3REo1717iCsFvpC6jLjiKadCXyGPgGk21gH6Q9elu6tDQATnYHPVIe9zTSZqyP
 lxCdygBvs+3GsaFbK+v1U0WvzxI8mmgHVOr4eJvaRh0eLy4MxWAPTMyyZhFCQXRVhL7O
 Nx6KGRnWwygV76R3d+RXwoUc8W8p/P88q2TeU9dCM153G9JXy4uRHqZzuT7xu/J0SSIj
 MnM+qanR9A7eaB873ihjysJxt2Y4VG9HugPMuU1nMhVSy/0jjvemQK51CArIGzriKuo/
 wBRkVtdSdCd8sn7m6JrBqiLvqitEpxoLhpltCKLgVRUfMPR/NhovEN2+tkI/ZkgYLsoq
 v+OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU1Ryj1JwNDgPBWIs8xe7DYxlzXhBl3yJkeL/H6fyWH6guOxR1QLMR7z6s63BjxmhNT31OTzZP46+N@nongnu.org
X-Gm-Message-State: AOJu0Yxtx9PcdkBYHoOv4rNIYO0USmoZM1ChFB/2DrX9QvxxpNQl6xcK
 1PtN3sh/qcI0SOIg2vgnXBpUVIenkfLJoTOzh15ouql8Jtrvy/KM3zdfy5piCaXTif7VwMXuj4F
 kYOgf
X-Gm-Gg: ASbGncs7KcmTyGH2VI2Pbgye8JFrgJAwd486MZPUUG/iVlftJjRGh/cc9dRM0bejLrW
 QtvblQi3mM7mAoqkFzgzWXLaq0LkG6encXejUANZOAzXmaba+PQseaau85oiUzXN1cEUyYuODXf
 xRDwgffDhbQgzzb4putd7UjXpSTWAAZMZVH4/oQkp1ZRNM8q1cRgvM7DZjcQx13xEZ7rDqiyUOF
 8QbqqqzEVnPtydlVVxSc/fpNG2NBGXtu64oVY7w3cf8wulwwa6GrukED5MuVnYRMCZ/Y452Bvuj
 r0IlWa5yqXERdk5qvqglW3mmEea/HqNGIXxxdHvNyRcXKjrdPs6y6I3ISwX/IbU6sPcEJqCfiGy
 uSw==
X-Google-Smtp-Source: AGHT+IFIEmQqJq8tjkAKrKpdZD/wt5zhQSQkS2kMez5CuDctdzC0A4yUNenbOr9othmamODYd7CgnA==
X-Received: by 2002:ad4:5cc5:0:b0:6e8:fe16:4d44 with SMTP id
 6a1803df08f44-702bcc679bfmr58836926d6.31.1751547504642; 
 Thu, 03 Jul 2025 05:58:24 -0700 (PDT)
Received: from [192.168.68.110] ([189.110.107.157])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd773245d8sm116897106d6.123.2025.07.03.05.58.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 05:58:24 -0700 (PDT)
Message-ID: <09d9cb9b-ee96-40f2-8aeb-b2a87d51c060@ventanamicro.com>
Date: Thu, 3 Jul 2025 09:58:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/11] hw/misc: Add RISC-V CMGCR and CPC device
 implementations
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>
References: <20250703104925.112688-1-djordje.todorovic@htecgroup.com>
 <20250703104925.112688-9-djordje.todorovic@htecgroup.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250703104925.112688-9-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qk1-x729.google.com
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



On 7/3/25 7:49 AM, Djordje Todorovic wrote:
> Add RISC-V implementations of the Coherent Manager Global Control
> Register (CMGCR) and Cluster Power Controller (CPC) devices. These
> are based on the existing MIPS CMGCR and CPC implementations but
> adapted for RISC-V systems.
> 
> The CMGCR device provides global system control for multi-core
> configurations, while the CPC device manages power control for
> CPU clusters in RISC-V systems.
> 
> This is needed for the MIPS BOSTON AIA board.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/misc/Kconfig               |   5 +
>   hw/misc/meson.build           |   1 +
>   hw/misc/riscv_cmgcr.c         | 205 +++++++++++++++++++++++++++++++
>   hw/misc/riscv_cpc.c           | 225 ++++++++++++++++++++++++++++++++++
>   include/hw/misc/riscv_cmgcr.h |  78 ++++++++++++
>   include/hw/misc/riscv_cpc.h   |  70 +++++++++++
>   6 files changed, 584 insertions(+)
>   create mode 100644 hw/misc/riscv_cmgcr.c
>   create mode 100644 hw/misc/riscv_cpc.c
>   create mode 100644 include/hw/misc/riscv_cmgcr.h
>   create mode 100644 include/hw/misc/riscv_cpc.h
> 
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index ec0fa5aa9f..65a89637ed 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -108,6 +108,11 @@ config STM32L4X5_RCC
>   config MIPS_ITU
>       bool
>   
> +config MIPS_BOSTON_AIA
> +    bool
> +    default n
> +    depends on RISCV64
> +
>   config MPS2_FPGAIO
>       bool
>       select LED
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 6d47de482c..05b1c0f3cc 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -152,6 +152,7 @@ specific_ss.add(when: 'CONFIG_MAC_VIA', if_true: files('mac_via.c'))
>   
>   specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_cmgcr.c', 'mips_cpc.c'))
>   specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
> +specific_ss.add(when: 'CONFIG_MIPS_BOSTON_AIA', if_true: files('riscv_cmgcr.c', 'riscv_cpc.c'))
>   
>   system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
>   
> diff --git a/hw/misc/riscv_cmgcr.c b/hw/misc/riscv_cmgcr.c
> new file mode 100644
> index 0000000000..cfc58d8bc2
> --- /dev/null
> +++ b/hw/misc/riscv_cmgcr.c
> @@ -0,0 +1,205 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
> + * Authors: Sanjay Lal <sanjayl@kymasys.com>
> + *
> + * Copyright (C) 2015 Imagination Technologies
> + *
> + * Copyright (C) 2025 MIPS
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "hw/sysbus.h"
> +#include "migration/vmstate.h"
> +#include "hw/misc/riscv_cmgcr.h"
> +#include "hw/misc/riscv_cpc.h"
> +#include "hw/qdev-properties.h"
> +
> +#include "cpu.h"
> +
> +#define CM_RESET_VEC 0x1FC00000
> +
> +static inline bool is_cpc_connected(RISCVGCRState *s)
> +{
> +    return s->cpc_mr != NULL;
> +}
> +
> +static inline void update_cpc_base(RISCVGCRState *gcr, uint64_t val)
> +{
> +    if (is_cpc_connected(gcr)) {
> +        gcr->cpc_base = val & GCR_CPC_BASE_MSK;
> +        memory_region_transaction_begin();
> +        memory_region_set_address(gcr->cpc_mr,
> +                                  gcr->cpc_base & GCR_CPC_BASE_CPCBASE_MSK);
> +        memory_region_set_enabled(gcr->cpc_mr,
> +                                  gcr->cpc_base & GCR_CPC_BASE_CPCEN_MSK);
> +        memory_region_transaction_commit();
> +    }
> +}
> +
> +static inline void update_gcr_base(RISCVGCRState *gcr, uint64_t val)
> +{
> +    gcr->gcr_base = val & GCR_BASE_GCRBASE_MSK;
> +    memory_region_set_address(&gcr->iomem, gcr->gcr_base);
> +
> +    /* For boston-aia, cpc_base is set to gcr_base + 0x8001 to enable
> +       cpc automatically. */
> +    update_cpc_base(gcr, val + 0x8001);
> +}
> +
> +/* Read GCR registers */
> +static uint64_t gcr_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    RISCVGCRState *gcr = (RISCVGCRState *) opaque;
> +
> +    switch (addr) {
> +    /* Global Control Block Register */
> +    case GCR_CONFIG_OFS:
> +        /* Set PCORES to 0 */
> +        return 0;
> +    case GCR_BASE_OFS:
> +        return gcr->gcr_base;
> +    case GCR_REV_OFS:
> +        return gcr->gcr_rev;
> +    case GCR_CPC_STATUS_OFS:
> +        return is_cpc_connected(gcr);
> +    case GCR_L2_CONFIG_OFS:
> +        /* L2 BYPASS */
> +        return GCR_L2_CONFIG_BYPASS_MSK;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "Read %d bytes at GCR offset 0x%" HWADDR_PRIx
> +                      "\n", size, addr);
> +    }
> +    return 0;
> +}
> +
> +static inline target_ulong get_exception_base(RISCVGCRVPState *vps)
> +{
> +    return vps->reset_base & GCR_CL_RESET_BASE_RESETBASE_MSK;
> +}
> +
> +/* Write GCR registers */
> +static void gcr_write(void *opaque, hwaddr addr, uint64_t data, unsigned size)
> +{
> +    RISCVGCRState *gcr = (RISCVGCRState *)opaque;
> +    RISCVGCRVPState *current_vps;
> +    int cpu_index, c, h;
> +
> +    for (c = 0; c < gcr->num_core; c++) {
> +        for (h = 0; h < gcr->num_hart; h++) {
> +            if (addr == RISCV_CLCB_OFS + c * RISCV_CORE_REG_STRIDE + h * 8) {
> +                cpu_index = c * gcr->num_hart + h;
> +                current_vps = &gcr->vps[cpu_index];
> +                current_vps->reset_base = data & GCR_CL_RESET_BASE_MSK;
> +                cpu_set_exception_base(cpu_index + gcr->cluster_id *
> +                                       gcr->num_core * gcr->num_hart,
> +                                       get_exception_base(current_vps));
> +                return;
> +            }
> +        }
> +    }
> +
> +    switch (addr) {
> +    case GCR_BASE_OFS:
> +        update_gcr_base(gcr, data);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "Write %d bytes at GCR offset 0x%" HWADDR_PRIx
> +                      " 0x%" PRIx64 "\n", size, addr, data);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps gcr_ops = {
> +    .read = gcr_read,
> +    .write = gcr_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .impl = {
> +        .max_access_size = 8,
> +    },
> +};
> +
> +static void riscv_gcr_init(Object *obj)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +    RISCVGCRState *s = RISCV_GCR(obj);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &gcr_ops, s,
> +                          "riscv-gcr", GCR_ADDRSPACE_SZ);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +}
> +
> +static void riscv_gcr_reset(DeviceState *dev)
> +{
> +    RISCVGCRState *s = RISCV_GCR(dev);
> +    int i;
> +
> +    /* Update cpc_base to gcr_base + 0x8001 to enable cpc automatically. */
> +    update_cpc_base(s, s->gcr_base + 0x8001);
> +
> +    for (i = 0; i < s->num_vps; i++) {
> +        s->vps[i].reset_base = CM_RESET_VEC & GCR_CL_RESET_BASE_MSK;
> +        cpu_set_exception_base(i, get_exception_base(&s->vps[i]));
> +    }
> +}
> +
> +static const VMStateDescription vmstate_riscv_gcr = {
> +    .name = "riscv-gcr",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT64(cpc_base, RISCVGCRState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static const Property riscv_gcr_properties[] = {
> +    DEFINE_PROP_UINT32("cluster-id", RISCVGCRState, cluster_id, 0),
> +    DEFINE_PROP_UINT32("num-vp", RISCVGCRState, num_vps, 1),
> +    DEFINE_PROP_UINT32("num-hart", RISCVGCRState, num_hart, 1),
> +    DEFINE_PROP_UINT32("num-core", RISCVGCRState, num_core, 1),
> +    DEFINE_PROP_INT32("gcr-rev", RISCVGCRState, gcr_rev, 0xa00),
> +    DEFINE_PROP_UINT64("gcr-base", RISCVGCRState, gcr_base, GCR_BASE_ADDR),
> +    DEFINE_PROP_LINK("cpc", RISCVGCRState, cpc_mr, TYPE_MEMORY_REGION,
> +                     MemoryRegion *),
> +};
> +
> +static void riscv_gcr_realize(DeviceState *dev, Error **errp)
> +{
> +    RISCVGCRState *s = RISCV_GCR(dev);
> +
> +    /* Create local set of registers for each VP */
> +    s->vps = g_new(RISCVGCRVPState, s->num_vps);
> +}
> +
> +static void riscv_gcr_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    device_class_set_props(dc, riscv_gcr_properties);
> +    dc->vmsd = &vmstate_riscv_gcr;
> +    device_class_set_legacy_reset(dc, riscv_gcr_reset);
> +    dc->realize = riscv_gcr_realize;
> +}
> +
> +static const TypeInfo riscv_gcr_info = {
> +    .name          = TYPE_RISCV_GCR,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(RISCVGCRState),
> +    .instance_init = riscv_gcr_init,
> +    .class_init    = riscv_gcr_class_init,
> +};
> +
> +static void riscv_gcr_register_types(void)
> +{
> +    type_register_static(&riscv_gcr_info);
> +}
> +
> +type_init(riscv_gcr_register_types)
> diff --git a/hw/misc/riscv_cpc.c b/hw/misc/riscv_cpc.c
> new file mode 100644
> index 0000000000..004f0e8062
> --- /dev/null
> +++ b/hw/misc/riscv_cpc.c
> @@ -0,0 +1,225 @@
> +/*
> + * Cluster Power Controller emulation
> + *
> + * Copyright (c) 2016 Imagination Technologies
> + *
> + * Copyright (c) 2025 MIPS
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "cpu.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qemu/timer.h"
> +#include "hw/sysbus.h"
> +#include "migration/vmstate.h"
> +
> +#include "hw/misc/riscv_cpc.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/intc/riscv_aclint.h"
> +
> +static inline uint64_t cpc_vp_run_mask(RISCVCPCState *cpc)
> +{
> +    if (cpc->num_vp == 64) {
> +        return 0xffffffffffffffff;
> +    }
> +    return (1ULL << cpc->num_vp) - 1;
> +}
> +
> +static void riscv_cpu_reset_async_work(CPUState *cs, run_on_cpu_data data)
> +{
> +    RISCVCPCState *cpc = (RISCVCPCState *) data.host_ptr;
> +
> +    cpu_reset(cs);
> +    cs->halted = 0;
> +    cpc->vp_running |= 1ULL << cs->cpu_index;
> +}
> +
> +static void cpc_run_vp(RISCVCPCState *cpc, uint64_t vp_run)
> +{
> +    CPUState *cs = first_cpu;
> +
> +    CPU_FOREACH(cs) {
> +        uint64_t i = 1ULL << cs->cpu_index;
> +        if (i & vp_run & ~cpc->vp_running) {
> +            /*
> +             * To avoid racing with a CPU we are just kicking off.
> +             * We do the final bit of preparation for the work in
> +             * the target CPUs context.
> +             */
> +            async_safe_run_on_cpu(cs, riscv_cpu_reset_async_work,
> +                                  RUN_ON_CPU_HOST_PTR(cpc));
> +        }
> +    }
> +}
> +
> +static void cpc_stop_vp(RISCVCPCState *cpc, uint64_t vp_stop)
> +{
> +    CPUState *cs = first_cpu;
> +
> +    CPU_FOREACH(cs) {
> +        uint64_t i = 1ULL << cs->cpu_index;
> +        if (i & vp_stop & cpc->vp_running) {
> +            cpu_interrupt(cs, CPU_INTERRUPT_HALT);
> +            cpc->vp_running &= ~i;
> +        }
> +    }
> +}
> +
> +static void cpc_write(void *opaque, hwaddr offset, uint64_t data,
> +                      unsigned size)
> +{
> +    RISCVCPCState *s = opaque;
> +    int cpu_index, c;
> +
> +    for (c = 0; c < s->num_core; c++) {
> +        cpu_index = c * s->num_hart +
> +                    s->cluster_id * s->num_core * s->num_hart;
> +        if (offset == CPC_CL_BASE_OFS + CPC_VP_RUN_OFS + c * CPC_CORE_REG_STRIDE) {
> +            cpc_run_vp(s, (data << cpu_index) & cpc_vp_run_mask(s));
> +            return;
> +        }
> +        if (offset == CPC_CL_BASE_OFS + CPC_VP_STOP_OFS + c * CPC_CORE_REG_STRIDE) {
> +            cpc_stop_vp(s, (data << cpu_index) & cpc_vp_run_mask(s));
> +            return;
> +        }
> +    }
> +
> +    switch (offset) {
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: Bad offset 0x%x\n",  __func__, (int)offset);
> +        break;
> +    }
> +
> +    return;
> +}
> +
> +static uint64_t cpc_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    RISCVCPCState *s = opaque;
> +    int c;
> +
> +    for (c = 0; c < s->num_core; c++) {
> +        if (offset == CPC_CL_BASE_OFS + CPC_STAT_CONF_OFS + c * CPC_CORE_REG_STRIDE) {
> +            /* Return the state as U6. */
> +            return CPC_Cx_STAT_CONF_SEQ_STATE_U6;
> +        }
> +    }
> +
> +    switch (offset) {
> +    case CPC_CM_STAT_CONF_OFS:
> +        return CPC_Cx_STAT_CONF_SEQ_STATE_U5;
> +    case CPC_MTIME_REG_OFS:
> +        return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> +                        RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ,
> +                        NANOSECONDS_PER_SECOND);
> +        return 0;
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: Bad offset 0x%x\n",  __func__, (int)offset);
> +        return 0;
> +    }
> +}
> +
> +static const MemoryRegionOps cpc_ops = {
> +    .read = cpc_read,
> +    .write = cpc_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .impl = {
> +        .max_access_size = 8,
> +    },
> +};
> +
> +static void riscv_cpc_init(Object *obj)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +    RISCVCPCState *s = RISCV_CPC(obj);
> +
> +    memory_region_init_io(&s->mr, OBJECT(s), &cpc_ops, s, "riscv-cpc",
> +                          CPC_ADDRSPACE_SZ);
> +    sysbus_init_mmio(sbd, &s->mr);
> +}
> +
> +static void riscv_cpc_realize(DeviceState *dev, Error **errp)
> +{
> +    RISCVCPCState *s = RISCV_CPC(dev);
> +
> +    if (s->vp_start_running > cpc_vp_run_mask(s)) {
> +        error_setg(errp,
> +                   "incorrect vp_start_running 0x%" PRIx64 " for num_vp = %d",
> +                   s->vp_running, s->num_vp);
> +        return;
> +    }
> +}
> +
> +static void riscv_cpc_reset(DeviceState *dev)
> +{
> +    RISCVCPCState *s = RISCV_CPC(dev);
> +
> +    /* Reflect the fact that all VPs are halted on reset */
> +    s->vp_running = 0;
> +
> +    /* Put selected VPs into run state */
> +    cpc_run_vp(s, s->vp_start_running);
> +}
> +
> +static const VMStateDescription vmstate_riscv_cpc = {
> +    .name = "riscv-cpc",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT64(vp_running, RISCVCPCState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static const Property riscv_cpc_properties[] = {
> +    DEFINE_PROP_UINT32("cluster-id", RISCVCPCState, cluster_id, 0x0),
> +    DEFINE_PROP_UINT32("num-vp", RISCVCPCState, num_vp, 0x1),
> +    DEFINE_PROP_UINT32("num-hart", RISCVCPCState, num_hart, 0x1),
> +    DEFINE_PROP_UINT32("num-core", RISCVCPCState, num_core, 0x1),
> +    DEFINE_PROP_UINT64("vp-start-running", RISCVCPCState, vp_start_running, 0x1),
> +};
> +
> +static void riscv_cpc_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = riscv_cpc_realize;
> +    device_class_set_legacy_reset(dc, riscv_cpc_reset);
> +    dc->vmsd = &vmstate_riscv_cpc;
> +    device_class_set_props(dc, riscv_cpc_properties);
> +}
> +
> +static const TypeInfo riscv_cpc_info = {
> +    .name          = TYPE_RISCV_CPC,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(RISCVCPCState),
> +    .instance_init = riscv_cpc_init,
> +    .class_init    = riscv_cpc_class_init,
> +};
> +
> +static void riscv_cpc_register_types(void)
> +{
> +    type_register_static(&riscv_cpc_info);
> +}
> +
> +type_init(riscv_cpc_register_types)
> diff --git a/include/hw/misc/riscv_cmgcr.h b/include/hw/misc/riscv_cmgcr.h
> new file mode 100644
> index 0000000000..9ce2ef34f3
> --- /dev/null
> +++ b/include/hw/misc/riscv_cmgcr.h
> @@ -0,0 +1,78 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2015 Imagination Technologies
> + *
> + * Copyright (C) 2025 MIPS
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + */
> +
> +#ifndef RISCV_CMGCR_H
> +#define RISCV_CMGCR_H
> +
> +#include "hw/sysbus.h"
> +#include "qom/object.h"
> +
> +#define TYPE_RISCV_GCR "riscv-gcr"
> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVGCRState, RISCV_GCR)
> +
> +#define GCR_BASE_ADDR           0x1fb80000ULL
> +#define GCR_ADDRSPACE_SZ        0x8000
> +
> +/* Offsets to register blocks */
> +#define RISCV_GCB_OFS        0x0000 /* Global Control Block */
> +#define RISCV_CLCB_OFS       0x2000 /* Core Control Block */
> +#define RISCV_CORE_REG_STRIDE 0x100 /* Stride between core-specific registers */
> +
> +/* Global Control Block Register Map */
> +#define GCR_CONFIG_OFS      0x0000
> +#define GCR_BASE_OFS        0x0008
> +#define GCR_REV_OFS         0x0030
> +#define GCR_CPC_STATUS_OFS  0x00F0
> +#define GCR_L2_CONFIG_OFS   0x0130
> +
> +/* GCR_L2_CONFIG register fields */
> +#define GCR_L2_CONFIG_BYPASS_SHF    20
> +#define GCR_L2_CONFIG_BYPASS_MSK    ((0x1ULL) << GCR_L2_CONFIG_BYPASS_SHF)
> +
> +/* GCR_BASE register fields */
> +#define GCR_BASE_GCRBASE_MSK     0xffffffff8000ULL
> +
> +/* GCR_CPC_BASE register fields */
> +#define GCR_CPC_BASE_CPCEN_MSK   1
> +#define GCR_CPC_BASE_CPCBASE_MSK 0xFFFFFFFF8000ULL
> +#define GCR_CPC_BASE_MSK (GCR_CPC_BASE_CPCEN_MSK | GCR_CPC_BASE_CPCBASE_MSK)
> +
> +/* GCR_CL_RESETBASE_OFS register fields */
> +#define GCR_CL_RESET_BASE_RESETBASE_MSK 0xFFFFFFFFFFFFF000U
> +#define GCR_CL_RESET_BASE_MSK GCR_CL_RESET_BASE_RESETBASE_MSK
> +
> +typedef struct RISCVGCRVPState RISCVGCRVPState;
> +struct RISCVGCRVPState {
> +    uint64_t reset_base;
> +};
> +
> +typedef struct RISCVGCRState RISCVGCRState;
> +struct RISCVGCRState {
> +    SysBusDevice parent_obj;
> +
> +    int32_t gcr_rev;
> +    uint32_t cluster_id;
> +    uint32_t num_vps;
> +    uint32_t num_hart;
> +    uint32_t num_core;
> +    hwaddr gcr_base;
> +    MemoryRegion iomem;
> +    MemoryRegion *cpc_mr;
> +
> +    uint64_t cpc_base;
> +
> +    /* VP Local/Other Registers */
> +    RISCVGCRVPState *vps;
> +};
> +
> +#endif /* RISCV_CMGCR_H */
> diff --git a/include/hw/misc/riscv_cpc.h b/include/hw/misc/riscv_cpc.h
> new file mode 100644
> index 0000000000..1946c3507a
> --- /dev/null
> +++ b/include/hw/misc/riscv_cpc.h
> @@ -0,0 +1,70 @@
> +/*
> + * Cluster Power Controller emulation
> + *
> + * Copyright (c) 2016 Imagination Technologies
> + *
> + * Copyright (c) 2025 MIPS
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + */
> +
> +#ifndef RISCV_CPC_H
> +#define RISCV_CPC_H
> +
> +#include "hw/sysbus.h"
> +#include "qom/object.h"
> +
> +#define CPC_ADDRSPACE_SZ    0x6000
> +
> +/* CPC global register offsets relative to base address */
> +#define CPC_MTIME_REG_OFS   0x50
> +
> +#define CPC_CM_STAT_CONF_OFS   0x1008
> +
> +/* CPC blocks offsets relative to base address */
> +#define CPC_CL_BASE_OFS     0x2000
> +#define CPC_CORE_REG_STRIDE 0x100 /* Stride between core-specific registers */
> +
> +/* CPC register offsets relative to block offsets */
> +#define CPC_STAT_CONF_OFS   0x08
> +#define CPC_VP_STOP_OFS     0x20
> +#define CPC_VP_RUN_OFS      0x28
> +#define CPC_VP_RUNNING_OFS  0x30
> +
> +#define SEQ_STATE_BIT       19
> +#define SEQ_STATE_U5        0x6
> +#define SEQ_STATE_U6        0x7
> +#define CPC_Cx_STAT_CONF_SEQ_STATE_U5      (SEQ_STATE_U5 << SEQ_STATE_BIT)
> +#define CPC_Cx_STAT_CONF_SEQ_STATE_U6      (SEQ_STATE_U6 << SEQ_STATE_BIT)
> +
> +#define TYPE_RISCV_CPC "riscv-cpc"
> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVCPCState, RISCV_CPC)
> +
> +typedef struct RISCVCPCState {
> +    SysBusDevice parent_obj;
> +
> +    uint32_t cluster_id;
> +    uint32_t num_vp;
> +    uint32_t num_hart;
> +    uint32_t num_core;
> +    uint64_t vp_start_running; /* VPs running from restart */
> +
> +    MemoryRegion mr;
> +    uint64_t vp_running; /* Indicates which VPs are in the run state */
> +} RISCVCPCState;
> +
> +#endif /* RISCV_CPC_H */


