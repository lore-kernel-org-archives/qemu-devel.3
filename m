Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DD9C8302F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 12:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWDDL-0005PY-Cr; Mon, 30 Jun 2025 08:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uWDDH-0005Ox-M1
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 08:02:21 -0400
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uWDDD-00016q-6o
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 08:02:19 -0400
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7d219896edeso455857685a.1
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 05:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1751284931; x=1751889731; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b+DBRh6JK+kx311tyUS7tRFkgo28Os9TD0GxkM/2pt4=;
 b=dngln4iN8Ezn5y9rK/DGSF+cjkvVMosiGBFkbFUHIsBPP15td9G4o077M4oXoO+9QB
 eNU8Lz0wVJxxKAkfk+ys5TKA9unaCJCI3bfRphSMKepkz7mNHLi5WMdcwvWOdu0utpdH
 BAnCQ5QJUgkmK40s+sQPO8HBLMkRSfEOTZI9FGMBUExgSmnXalFQvcwBOosqVE0sNF1Z
 mYklRMb1gCe6GZn+e6v4xExnPLRADthaAx4C0FY3hvu7EylUr77GvClkcOMAk2IF/5w2
 pz0G4CyeipXD90MltNqDMh4RCisxGj69LAsqbMmEns4VtKJU/MiLqVZKlQ7kGDURo9d3
 dJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751284931; x=1751889731;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b+DBRh6JK+kx311tyUS7tRFkgo28Os9TD0GxkM/2pt4=;
 b=OpqWK+K7ey75CUj4xCFXI4brfFfnc5C21wIEUFEWZ5PL+yU7+MT6CKDYvxlQw11vin
 zdAV+spI6inghDXMUYtT5BYDI5nAmdoj1p2S7Nw7wk8YtO7ltZ1Jg+dTsDCozo9Lnd7N
 TKcOaMUoGdL2a2ucrIe1zXZ/2d52xfuROyjsqhIwByhF3LFrsH/7VHlBBK7UemfbF860
 RqEj8K+sEjAItJAxtllK4B3s0CaAbjdVTRy/Fj6Ob1zbJSDRvGoWrlrhR335DUnH2v7t
 X+G3bNPPGqfZHxS5w65JHZwvzOHP5gsV3j9tgPcc5pWaFUNKXVr/AS9cEuIwqxcjXd8+
 3mbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaB1r5EzVVNrBZDupFzuROUuvpoWmwF/7JUUUNXYh2A2qD8EOCySxZa4GvbTju9sO5Okprk/RXBGIp@nongnu.org
X-Gm-Message-State: AOJu0YxSiAAmrKl/4nm6gsL4SG5Jn7k55A3deR8g7ZW/OUQJJ8663AuF
 97GzccUdEK+leYyIOoSf8deQHYy8sRydnUeQ0FtNIt++dxwVYtjH9eU6Uzh9dYy8Il4=
X-Gm-Gg: ASbGnctxVovTzU7raUsIb8DWM/PFCGZXVyeDxrym/IzM33JQVgE4dHLZq0FSpGkpQ5q
 9O0xe/CHggwzXdq1jySGbhsPahAA2SvhPYRxfatHuaBRlLhP7n4n4h7X/pHO0+S3VjaiM11ddg7
 ETVfJ+plRkCi0poHhMYjOtXyrZf2r+WKUgSQIdvzPmQKZCxQEIooHqLsBfO5fqzZW9nFqcALe6r
 p+vntAgP3t1d7On5HvycHLR0+YdjUOfT7xJHSMySSLIFHNAX27IMvbgBBAYNA+q4B632iDGBcNy
 WFWw/fsK34rE3Ef3NrJIoextXV65vL4/JZfTCw3zImCx9KnDsEvvJKH6XlNFms23L5zQAoLQuZ5
 oQqXluFtfOQ==
X-Google-Smtp-Source: AGHT+IHRBGd2d8l8SmYCnJQMIh91DsEKS9mUw9xIZmljU1u0ALT/swrq70HK4GGfYRv0Y/IWEsLzkQ==
X-Received: by 2002:ac8:57cb:0:b0:494:b3eb:a4b9 with SMTP id
 d75a77b69052e-4a7fcb0881bmr187346591cf.51.1751284930477; 
 Mon, 30 Jun 2025 05:02:10 -0700 (PDT)
Received: from [192.168.68.110] ([179.93.20.232])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a7fc55c671sm57527281cf.51.2025.06.30.05.02.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 05:02:09 -0700 (PDT)
Message-ID: <63174cf9-dbaf-4cea-9ad7-ee27333aa3ca@ventanamicro.com>
Date: Mon, 30 Jun 2025 09:02:05 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/11] hw/misc: Add support for MIPS Boston-aia board
 model
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>
References: <20250625141732.59084-1-djordje.todorovic@htecgroup.com>
 <20250625141732.59084-9-djordje.todorovic@htecgroup.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250625141732.59084-9-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qk1-x735.google.com
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



On 6/25/25 11:18 AM, Djordje Todorovic wrote:
> The board model supports up to 64 harts with MIPS CPS, MIPS GCR,
> MIPS CPC, AIA plic, and AIA clint devices. The model can create
> boot code, if there is no -bios parameter. We can specify -smp x,
> cores=y,thread=z.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---

Splitting the patch in 2 parts is the right thing to do but you forgot to
change the subject and commit msg for this pre-patch :D

What we want here is a brief description of the riscv_cmgcr and riscv_cpc
devices you're adding.


>   hw/misc/Kconfig               |   5 +
>   hw/misc/meson.build           |   1 +
>   hw/misc/riscv_cmgcr.c         | 206 +++++++++++++++++++++++++++++++
>   hw/misc/riscv_cpc.c           | 225 ++++++++++++++++++++++++++++++++++
>   include/hw/misc/riscv_cmgcr.h |  77 ++++++++++++
>   include/hw/misc/riscv_cpc.h   |  69 +++++++++++
>   6 files changed, 583 insertions(+)
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
> index 0000000000..2954e3b406
> --- /dev/null
> +++ b/hw/misc/riscv_cmgcr.c
> @@ -0,0 +1,206 @@
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
> +        return 0;

We don't need this 'return 0' - we'll do a return 0 at the end.

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
> +            if (addr == RISCV_CLCB_OFS + c * 0x100 + h * 8) {

I see this 0x100 value used around this patch. I assume this is some form of offset.
If you could add a macro describing it as such it will be easier to follow the code.
Especially for someone that is not acquainted with how the device/spec works.


Other than that the code LGTM. Thanks,

Daniel


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
> index 0000000000..0d89de95f2
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
> +        if (offset == CPC_CL_BASE_OFS + CPC_VP_RUN_OFS + c * 0x100) {
> +            cpc_run_vp(s, (data << cpu_index) & cpc_vp_run_mask(s));
> +            return;
> +        }
> +        if (offset == CPC_CL_BASE_OFS + CPC_VP_STOP_OFS + c * 0x100) {
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
> +        if (offset == CPC_CL_BASE_OFS + CPC_STAT_CONF_OFS + c * 0x100) {
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
> index 0000000000..c2c07fa0a6
> --- /dev/null
> +++ b/include/hw/misc/riscv_cmgcr.h
> @@ -0,0 +1,77 @@
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
> index 0000000000..36d20c8f20
> --- /dev/null
> +++ b/include/hw/misc/riscv_cpc.h
> @@ -0,0 +1,69 @@
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


