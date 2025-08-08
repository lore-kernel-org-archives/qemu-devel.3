Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BB2C87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 16:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukPqo-0007ME-76; Fri, 08 Aug 2025 12:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukPqm-0007LT-QC
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:21:48 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukPqk-0002O7-Dz
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:21:48 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-458b49c98a7so14995935e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 09:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754670104; x=1755274904; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Cs8df2p86OvlxQZ2S9dzYx+Uni6kev+PammcoKtfQAY=;
 b=rSVagjpnxDRKbDZW0BGxSqVYXCLuztEtYxYPqSRdgSAf/IB7PmZS3efxQXmO8NttR9
 HFLggYzlA4HNrGrFowdLIemu2R5laOvYGBmTITYgkKDu2cWxTpudzhN7G293CElNMRwu
 AGwYdVrep8JJ2ULAKqEuF19SHQ/Ty1KXusOuM4HvYjBWPXpbBjh9hpT6pmxVpMs79lxa
 vlhOxTwejgj59//GzGHGUg0VMqUpyx/GlF/wqiQFjNDkXeAlEfEljwjp62myc+Gh85FY
 1I/MRXg0Ot8PpzKRQEz/NOvCJhtdvrsWDlwx4fCYp9fd1nUM+QZDYt0VQWoe/FG7zZi3
 YHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754670104; x=1755274904;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cs8df2p86OvlxQZ2S9dzYx+Uni6kev+PammcoKtfQAY=;
 b=sdB1zgXWmlxXn6hvcfYjwNJrZaSSfcKOVVjlLL821YxiSZJfJfnHwjzs1AvouD7Wa4
 ydHigR1F83ggLZ/Yre2vSfkCFxS6UdRnDMAQg0YOuZXgxZ0PC2/nqArhWi6xKfX/DLTz
 zSnf0L8GCS0LYPKquuJXyG8WjP0kn/hXFcr1G/tl3fJ9hD3ztxKP5re6czqKXcWt0NFF
 v/wxvvEm5iFQyCQ4vqMwL2/Sz0F5vzmAWwNz1b6QvlwXGNeu3bzTxLHM8m2cttSMq4/G
 NQoQo6Fdca5dil7ycMUjjpqgVz46wWlPDo6igJu1m50LwRK0omYBkn3eaZhZyjJeGhK0
 iRhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT2EtVyx/JyOKaE/DAe3iRZNV0PRtbI1SfGMjwYmahsSyDu+M5G3tPLaBUecH8nW+KbegewyGvvNMY@nongnu.org
X-Gm-Message-State: AOJu0YwjpROLOL2xcA3dCL5rw4J76WIzAjtXN+gcMAcgnqg6j2oboq1d
 GHQj9xARvFv3Ddr6CuNBa0tZ2nBugz6ko5RJRv3Q7Qt/z4V7QRLzvMaRW1VmgzQpgV8=
X-Gm-Gg: ASbGncsA60CFf3wqy0DQptuO+aYv2BSrNRrFE+nB2XsOm3+DRXqPQSDcJi5F7Kc27V8
 uc4A2rPGnDq+TJfK9nYhqY00CFIS+sZjICqgTZWpWAxHvuFpbNYLtTyXeQRnBFvf1eCDiG/Db6b
 9zpFaR4gK2jqRrmXATaaqmtml/h3PinicEYj8+tpbQT55OkXz//f/yBMgAOyhf/4gAhDYZmphfe
 Uq85LQhl5tbPIc8HofF1cU1b0wskisU0tUBlr31H4Tvr2U+cywt3WtZj9a4qXFz2wSz+Z8ReBYR
 dl5FxOHD8dhTPpTqiMhXnIiQdOZP/6hdKM3CreYhG+jLAsqoGTCf4F+Qwa4ZU+1N21eyMar+7O6
 wY9w9/fJBsHzGy5eLi+p085wDEDtzWkO3OnWKqP9QLbHSqyr7zWUVh0d7odm0vEe+K1a8aLQ9si
 Z8
X-Google-Smtp-Source: AGHT+IHYoL0TwSGrNG2BaUucVDolA2oftIeWMNrZxLBNreEAebhTGhY59GLASRyFm9qDxWai8EVabg==
X-Received: by 2002:a05:600c:3502:b0:456:8eb:a35c with SMTP id
 5b1f17b1804b1-459f4fbadd1mr37246005e9.31.1754670104174; 
 Fri, 08 Aug 2025 09:21:44 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459dc7e1ddesm223819315e9.27.2025.08.08.09.21.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 09:21:43 -0700 (PDT)
Message-ID: <5b85433f-d5a1-4865-81ec-d2686ff11432@linaro.org>
Date: Fri, 8 Aug 2025 18:21:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/14] hw/misc: Add RISC-V CPC device implementation
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
 <20250717093833.402237-10-djordje.todorovic@htecgroup.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250717093833.402237-10-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 17/7/25 11:38, Djordje Todorovic wrote:
> Add RISC-V implementation of the Cluster Power Controller (CPC) device.
> It is based on the existing MIPS CPC implementations but adapted for
> RISC-V systems.
> 
> The CPC device manages power control for CPU clusters in RISC-V
> systems.
> 
> This is needed for the MIPS BOSTON AIA board.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>   hw/misc/Kconfig             |   5 +
>   hw/misc/meson.build         |   1 +
>   hw/misc/riscv_cpc.c         | 239 ++++++++++++++++++++++++++++++++++++
>   include/hw/misc/riscv_cpc.h |  73 +++++++++++
>   4 files changed, 318 insertions(+)
>   create mode 100644 hw/misc/riscv_cpc.c
>   create mode 100644 include/hw/misc/riscv_cpc.h


> diff --git a/hw/misc/riscv_cpc.c b/hw/misc/riscv_cpc.c
> new file mode 100644
> index 0000000000..424562d7be
> --- /dev/null
> +++ b/hw/misc/riscv_cpc.c
> @@ -0,0 +1,239 @@
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
> + * SPDX-License-Identifier: LGPL-2.1-or-later
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
> +#include "hw/resettable.h"
> +
> +static inline uint64_t cpc_vp_run_mask(RISCVCPCState *cpc)
> +{
> +    if (cpc->num_vp == 64) {
> +        return 0xffffffffffffffff;
> +    }
> +    return (1ULL << cpc->num_vp) - 1;

   return MAKE_64BIT_MASK(0, cpc->num_vp);

> +}
> +
> +static void riscv_cpu_reset_async_work(CPUState *cs, run_on_cpu_data data)
> +{
> +    RISCVCPCState *cpc = (RISCVCPCState *) data.host_ptr;
> +    int i;
> +
> +    cpu_reset(cs);
> +    cs->halted = 0;
> +
> +    /* Find this CPU's index in the CPC's CPU array */
> +    for (i = 0; i < cpc->num_vp; i++) {
> +        if (cpc->cpus[i] == cs) {
> +            cpc->vp_running |= 1ULL << i;

   |= BIT_ULL(i);

> +            break;
> +        }
> +    }
> +}
> +
> +static void cpc_run_vp(RISCVCPCState *cpc, uint64_t vp_run)

Please rename as 'vps_mask' or 'vps_run_mask'.

> +{
> +    int i;

Rename as 'vp'?

> +
> +    for (i = 0; i < cpc->num_vp; i++) {
> +        CPUState *cs = cpc->cpus[i];
> +        uint64_t mask = 1ULL << i;
> +        if (mask & vp_run & ~cpc->vp_running) {

Double masking is not easy to review. Clearer as (IMHO):

   if (!extract64(vps_run_mask, vp, 1)) {
       continue;
   }

   if (extract64(cpc->vp_running, vp, 1)) {
       continue;
   }

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
> +    int i;
> +
> +    for (i = 0; i < cpc->num_vp; i++) {
> +        CPUState *cs = cpc->cpus[i];
> +        uint64_t mask = 1ULL << i;
> +        if (mask & vp_stop & cpc->vp_running) {

Ditto.

> +            cpu_interrupt(cs, CPU_INTERRUPT_HALT);
> +            cpc->vp_running &= ~mask;
> +        }
> +    }
> +}


> +static void riscv_cpc_realize(DeviceState *dev, Error **errp)
> +{
> +    RISCVCPCState *s = RISCV_CPC(dev);
> +
> +    if (s->vp_start_running > cpc_vp_run_mask(s)) {

        if (s->vp_start_running & ~cpc_vp_run_mask(s)) {

> +        error_setg(errp,
> +                   "incorrect vp_start_running 0x%" PRIx64 " for num_vp = %d",
> +                   s->vp_running, s->num_vp);
> +        return;
> +    }
> +}
> +
> +static void riscv_cpc_reset_hold(Object *obj, ResetType type)
> +{
> +    RISCVCPCState *s = RISCV_CPC(obj);
> +
> +    /* Reflect the fact that all VPs are halted on reset */
> +    s->vp_running = 0;
> +
> +    /* Put selected VPs into run state */
> +    cpc_run_vp(s, s->vp_start_running);
> +}
> +
> +static const VMStateDescription vmstate_riscv_cpc = {
> +    .name = "xmips-cpc",
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

Use 'mask' in property name.

> +};


> +typedef struct RISCVCPCState {
> +    SysBusDevice parent_obj;
> +
> +    uint32_t cluster_id;
> +    uint32_t num_vp;
> +    uint32_t num_hart;
> +    uint32_t num_core;
> +    uint64_t vp_start_running; /* VPs running from restart */
Please add _mask suffix. Use plural?
> +
> +    MemoryRegion mr;
> +    uint64_t vp_running; /* Indicates which VPs are in the run state */

Please add _mask suffix. Use plural? 'vps_running_mask'
or 'running_vps_mask'?

> +
> +    /* Array of CPUs managed by this CPC */
> +    CPUState **cpus;
> +} RISCVCPCState;
> +
> +#endif /* RISCV_CPC_H */


