Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49470CF8848
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 11:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM38q-0003vX-Nn; Thu, 20 Nov 2025 06:48:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vM38o-0003vI-TA
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 06:47:58 -0500
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vM38k-0001Kf-DQ
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 06:47:58 -0500
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3d56d0cb3dbso439083fac.3
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 03:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1763639272; x=1764244072; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AIkVXxyf/Z/fObsx2RfS9UWv6SxbVJnijAfCzH+YkZM=;
 b=cZn4KxBRlOieJLIp2nArNTcFWfXZRfZHcD3EqGqFpeC0QAHt+vEwdYBC/vxGjYPUPY
 bbVtpHMxnK6Pc2cL/nbbG8jvIJF/NMyx3GgkyNwrlZo65tCHq48guIEyLB2HzzJvkClQ
 Y4IlwJgNLEJCF5Bg2OHPJsdDfAx9QDeAUJTnWDUEaHFn8IGH3ReEFE1L30kugDZ70jxa
 kYELsCdryeVa9S+UgPcD0iMdQPYIsoI4+m369wcvyNQnt3GMTp7VDM7CC+Eh9K+m1BfY
 98H3mCSpcad32qAglTKM9/8V54hVQ+Oy29drYZM8aIIx31ZE2bfOO+niE64AhmUwN7jB
 f1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763639272; x=1764244072;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AIkVXxyf/Z/fObsx2RfS9UWv6SxbVJnijAfCzH+YkZM=;
 b=uRsnA8ZV+O/gZZo5noTRmVBDxMstgPXH8+JJV9PWjJRa0qEo5hqRI+7olFnX9J2bYz
 9SXR+Nyk+FpaBisPliCr+z1i2DsKS9cDGhH7NaIOOzBNBiAcyoGK1OdXJtgccDvWKvt0
 YxR2fIvwoj6IImzzCzfMOM7hZmtLpcD9zvAeo+cLKFfZtYUz2MF+5Nj/rtL5g/4Li4/S
 ZV+aTiKB4UlEMmWrgsvU+F2ZLnH7WhZh9TXrz3b/Om+nFdcI+KgqqfWBvHSkW68BFSGP
 IuJbr2JNWcRkx6XnhmewGFg0/0dQxrkJRQoaX3CGO282KUz3PKFzJhdgw0pHdGyH66zC
 7WSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWb53jH3NqrTxnCOElHIzlh5hrrJXA55no3/EkXD0gNNsg3hQicgT7k2Swcz4Q99zibSGC/09JwkZr@nongnu.org
X-Gm-Message-State: AOJu0YxfHPbft3ftF8CH7pmDarCkAgNGSL+0fmsOYHfDCpX1mIXgvsj3
 Zpk6TI9yvsQEvvFAGvG13lJ+y+g/unCiTmHQc0UhzUIbeG7UnNV2fCwFN0hjw7buyVY=
X-Gm-Gg: ASbGncsJOGzu5Jpe/g8l9VhNgANykSQnD2dRti/+EAkWHY3mJH3qoIWUjM0o0yM/PWG
 mbBUjSsZKQ5DrzyOEZaq0OUTjqneVTwC27AKp7SPij2S5tx74nP9u5zXYqwMbsttxPkEXbYyTnc
 05p2O+e5tyVVbU9Z3M5JAKhTzFL8PYghta2yKEayXhOCFuaIIWQBMJGP082JhZrVDn7WN91wvjs
 /6bfmYvRVaXQgnRdl5uAdFAWjnHJh1VxISRGdRHh+3cKv3ALpPDXjl7gr5PzzlnNh5morr5Dqmw
 +ePYb9Csi+idhoA8jCAjTrvIN/qu/h9cLfT0/Jtxq991DMuhW+GxBClpv3XqYn7gw+e+CZ5u07h
 y2EdKf0AqaxD5/9XyVoCkc5C+IK/OG15jpW6DyDjj1m+8i0onjKItqUOxnFHw3QR6VGuHpBUeu4
 xRsW7J9t0VTQ6bGSLDq9LSkbXOcEg=
X-Google-Smtp-Source: AGHT+IEXlA2HUFVYXz/AHmv8DNNrJoYfj0ROpMMd87AakyldtZDu1Zy75Dwjrf2gxG0+IDc6gzMvrw==
X-Received: by 2002:a05:6870:71d1:b0:3ec:371b:3fbe with SMTP id
 586e51a60fabf-3eca49aeccfmr715752fac.17.1763639271973; 
 Thu, 20 Nov 2025 03:47:51 -0800 (PST)
Received: from [192.168.68.110] ([177.188.133.235])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ec9c2d0e96sm1021227fac.2.2025.11.20.03.47.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 03:47:50 -0800 (PST)
Message-ID: <ea794b78-2b7e-44eb-96e2-342f6a338090@ventanamicro.com>
Date: Thu, 20 Nov 2025 08:47:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] hw/riscv: implement CBQRI capacity controller
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
 <20251119-riscv-ssqosid-cbqri-v1-3-3392fc760e48@kernel.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251119-riscv-ssqosid-cbqri-v1-3-3392fc760e48@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Implement a capacity controller according to the Capacity and Bandwidth
> QoS Register Interface (CBQRI) which supports these capabilities:
> 
>    - Number of access types: 2 (code and data)
>    - Usage monitoring operations: CONFIG_EVENT, READ_COUNTER
>    - Event IDs supported: None, Occupancy
>    - Capacity allocation ops: CONFIG_LIMIT, READ_LIMIT, FLUSH_RCID
> 
> Link: https://github.com/riscv-non-isa/riscv-cbqri/blob/main/riscv-cbqri.pdf
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> [fustini: add fields introduced in the ratified spec: cunits, rpfx, p]
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
>   MAINTAINERS               |   1 +
>   hw/riscv/cbqri_capacity.c | 634 ++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 635 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7afe80f1b17c..48cca4ac8702 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -362,6 +362,7 @@ M: Nicolas Pitre <npitre@baylibre.com>
>   M: Drew Fustini <fustini@kernel.org>
>   L: qemu-riscv@nongnu.org
>   S: Supported
> +F: hw/riscv/cbqri_capacity.c
>   F: include/hw/riscv/cbqri.h
>   
>   RENESAS RX CPUs
> diff --git a/hw/riscv/cbqri_capacity.c b/hw/riscv/cbqri_capacity.c
> new file mode 100644
> index 000000000000..e70f831878ac
> --- /dev/null
> +++ b/hw/riscv/cbqri_capacity.c
> @@ -0,0 +1,634 @@
> +/*
> + * RISC-V Capacity and Bandwidth QoS Register Interface
> + * URL: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
> + *
> + * Copyright (c) 2023 BayLibre SAS
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This file contains the Capacity-controller QoS Register Interface.
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
> +#include "qemu/bitmap.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/sysbus.h"
> +#include "target/riscv/cpu.h"
> +#include "hw/riscv/cbqri.h"
> +

[ ...]

> +
> +static void riscv_cbqri_cc_write(void *opaque, hwaddr addr,
> +                                 uint64_t value, unsigned size)
> +{
> +    RiscvCbqriCapacityState *cc = opaque;
> +
> +    assert((addr % 8) == 0);
> +    assert(size == 8);

So here and in the read callback (riscv_cbqri_cc_read) you're doing asserts for
size == 8, while your memoryops has:

static const MemoryRegionOps riscv_cbqri_cc_ops = {
     .read = riscv_cbqri_cc_read,
     .write = riscv_cbqri_cc_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid.min_access_size = 4,  <==========
     .valid.max_access_size = 8,
     .impl.min_access_size = 8,
     .impl.max_access_size = 8,
};


You can get rid of assert(size == 8) in both callbacks by setting
min_access_size = 8.


Code LGTM otherwise. Thanks,


Daniel


> +
> +    switch (addr) {
> +    case A_CC_CAPABILITIES:
> +        /* read-only register */
> +        break;
> +    case A_CC_MON_CTL:
> +        riscv_cbqri_cc_write_mon_ctl(cc, value);
> +        break;
> +    case A_CC_ALLOC_CTL:
> +        riscv_cbqri_cc_write_alloc_ctl(cc, value);
> +        break;
> +    case A_CC_MON_CTR_VAL:
> +        /* read-only register */
> +        break;
> +    case A_CC_BLOCK_MASK:
> +        if (cc->ncblks == 0) {
> +            break;
> +        }
> +        /* fallthrough */
> +    default:
> +        uint32_t blkmask_slot = (addr - A_CC_BLOCK_MASK) / 8;
> +        if (blkmask_slot >= (cc->ncblks + 63) / 64) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: out of bounds (addr=0x%x)",
> +                          __func__, (uint32_t)addr);
> +            break;
> +        }
> +        cc->alloc_blockmasks[blkmask_slot] = value;
> +    }
> +}
> +
> +static uint64_t riscv_cbqri_cc_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    RiscvCbqriCapacityState *cc = opaque;
> +    uint64_t value = 0;
> +
> +    assert((addr % 8) == 0);
> +    assert(size == 8);
> +
> +    switch (addr) {
> +    case A_CC_CAPABILITIES:
> +        value = FIELD_DP64(value, CC_CAPABILITIES, VER_MAJOR,
> +                           RISCV_CBQRI_VERSION_MAJOR);
> +        value = FIELD_DP64(value, CC_CAPABILITIES, VER_MINOR,
> +                           RISCV_CBQRI_VERSION_MINOR);
> +        value = FIELD_DP64(value, CC_CAPABILITIES, NCBLKS,
> +                           cc->ncblks);
> +        value = FIELD_DP64(value, CC_CAPABILITIES, FRCID,
> +                           cc->supports_alloc_op_flush_rcid);
> +        value = FIELD_DP64(value, CC_CAPABILITIES, CUNITS,
> +                           cc->cunits);
> +        value = FIELD_DP64(value, CC_CAPABILITIES, RPFX,
> +                           cc->rpfx);
> +        value = FIELD_DP64(value, CC_CAPABILITIES, P,
> +                           cc->p);
> +
> +        break;
> +    case A_CC_MON_CTL:
> +        value = cc->cc_mon_ctl;
> +        break;
> +    case A_CC_ALLOC_CTL:
> +        value = cc->cc_alloc_ctl;
> +        break;
> +    case A_CC_MON_CTR_VAL:
> +        value = cc->cc_mon_ctr_val;
> +        break;
> +    case A_CC_BLOCK_MASK:
> +        if (cc->ncblks == 0) {
> +            break;
> +        }
> +        /* fallthrough */
> +    default:
> +        unsigned int blkmask_slot = (addr - A_CC_BLOCK_MASK) / 8;
> +        if (blkmask_slot >= (cc->ncblks + 63) / 64) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: out of bounds (addr=0x%x)",
> +                          __func__, (uint32_t)addr);
> +            break;
> +        }
> +        value = cc->alloc_blockmasks[blkmask_slot];
> +    }
> +
> +    return value;
> +}
> +
> +static const MemoryRegionOps riscv_cbqri_cc_ops = {
> +    .read = riscv_cbqri_cc_read,
> +    .write = riscv_cbqri_cc_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 8,
> +    .impl.min_access_size = 8,
> +    .impl.max_access_size = 8,
> +};
> +
> +static void riscv_cbqri_cc_realize(DeviceState *dev, Error **errp)
> +{
> +    RiscvCbqriCapacityState *cc = RISCV_CBQRI_CC(dev);
> +
> +    if (!cc->mmio_base) {
> +        error_setg(errp, "mmio_base property not set");
> +        return;
> +    }
> +
> +    assert(cc->mon_counters == NULL);
> +    cc->mon_counters = g_new0(MonitorCounter, cc->nb_mcids);
> +
> +    assert(cc->alloc_blockmasks == NULL);
> +    uint64_t *end = get_blockmask_location(cc, cc->nb_rcids, 0);
> +    unsigned int blockmasks_size = end - cc->alloc_blockmasks;
> +    cc->alloc_blockmasks = g_new0(uint64_t, blockmasks_size);
> +
> +    memory_region_init_io(&cc->mmio, OBJECT(dev), &riscv_cbqri_cc_ops,
> +                          cc, TYPE_RISCV_CBQRI_CC".mmio", 4 * 1024);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &cc->mmio);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, cc->mmio_base);
> +}
> +
> +static void riscv_cbqri_cc_reset(DeviceState *dev)
> +{
> +    RiscvCbqriCapacityState *cc = RISCV_CBQRI_CC(dev);
> +
> +    cc->cc_mon_ctl = 0;
> +    cc->cc_alloc_ctl = 0;
> +
> +    /* assign all capacity only to rcid0 */
> +    for (unsigned int rcid = 0; rcid < cc->nb_rcids; rcid++) {
> +        bool any_at = false;
> +
> +        if (cc->supports_at_data) {
> +            alloc_blockmask_init(cc, rcid, CC_AT_DATA,
> +                                 rcid == 0, NULL);
> +            any_at = true;
> +        }
> +        if (cc->supports_at_code) {
> +            alloc_blockmask_init(cc, rcid, CC_AT_CODE,
> +                                 rcid == 0, NULL);
> +            any_at = true;
> +        }
> +        if (!any_at) {
> +            alloc_blockmask_init(cc, rcid, 0,
> +                                 rcid == 0, NULL);
> +        }
> +    }
> +}
> +
> +static Property riscv_cbqri_cc_properties[] = {
> +    DEFINE_PROP_UINT64("mmio_base", RiscvCbqriCapacityState, mmio_base, 0),
> +    DEFINE_PROP_STRING("target", RiscvCbqriCapacityState, target),
> +
> +    DEFINE_PROP_UINT16("max_mcids", RiscvCbqriCapacityState, nb_mcids, 256),
> +    DEFINE_PROP_UINT16("max_rcids", RiscvCbqriCapacityState, nb_rcids, 64),
> +    DEFINE_PROP_UINT16("ncblks", RiscvCbqriCapacityState, ncblks, 16),
> +
> +    DEFINE_PROP_BOOL("cunits", RiscvCbqriCapacityState, cunits, true),
> +    DEFINE_PROP_BOOL("rpfx", RiscvCbqriCapacityState, rpfx, true),
> +    DEFINE_PROP_UINT8("p", RiscvCbqriCapacityState, p, 4),
> +
> +    DEFINE_PROP_BOOL("at_data", RiscvCbqriCapacityState,
> +                     supports_at_data, true),
> +    DEFINE_PROP_BOOL("at_code", RiscvCbqriCapacityState,
> +                     supports_at_code, true),
> +
> +    DEFINE_PROP_BOOL("alloc_op_config_limit", RiscvCbqriCapacityState,
> +                     supports_alloc_op_config_limit, true),
> +    DEFINE_PROP_BOOL("alloc_op_read_limit", RiscvCbqriCapacityState,
> +                     supports_alloc_op_read_limit, true),
> +    DEFINE_PROP_BOOL("alloc_op_flush_rcid", RiscvCbqriCapacityState,
> +                     supports_alloc_op_flush_rcid, true),
> +
> +    DEFINE_PROP_BOOL("mon_op_config_event", RiscvCbqriCapacityState,
> +                     supports_mon_op_config_event, true),
> +    DEFINE_PROP_BOOL("mon_op_read_counter", RiscvCbqriCapacityState,
> +                     supports_mon_op_read_counter, true),
> +
> +    DEFINE_PROP_BOOL("mon_evt_id_none", RiscvCbqriCapacityState,
> +                     supports_mon_evt_id_none, true),
> +    DEFINE_PROP_BOOL("mon_evt_id_occupancy", RiscvCbqriCapacityState,
> +                     supports_mon_evt_id_occupancy, true),
> +};
> +
> +static void riscv_cbqri_cc_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    dc->realize = riscv_cbqri_cc_realize;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    dc->desc = "RISC-V CBQRI Capacity Controller";
> +    device_class_set_props(dc, riscv_cbqri_cc_properties);
> +    dc->legacy_reset = riscv_cbqri_cc_reset;
> +    dc->user_creatable = true;
> +}
> +
> +static const TypeInfo riscv_cbqri_cc_info = {
> +    .name          = TYPE_RISCV_CBQRI_CC,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(RiscvCbqriCapacityState),
> +    .class_init    = riscv_cbqri_cc_class_init,
> +};
> +
> +static void riscv_cbqri_cc_register_types(void)
> +{
> +    type_register_static(&riscv_cbqri_cc_info);
> +}
> +
> +DeviceState *riscv_cbqri_cc_create(hwaddr addr,
> +                                   const RiscvCbqriCapacityCaps *caps,
> +                                   const char *target_name)
> +{
> +    DeviceState *dev = qdev_new(TYPE_RISCV_CBQRI_CC);
> +
> +    qdev_prop_set_uint64(dev, "mmio_base", addr);
> +    qdev_prop_set_string(dev, "target", target_name);
> +    qdev_prop_set_uint16(dev, "max_mcids", caps->nb_mcids);
> +    qdev_prop_set_uint16(dev, "max_rcids", caps->nb_rcids);
> +    qdev_prop_set_uint16(dev, "ncblks", caps->ncblks);
> +    qdev_prop_set_bit(dev, "cunits", caps->cunits);
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
> +    qdev_prop_set_bit(dev, "alloc_op_flush_rcid",
> +                      caps->supports_alloc_op_flush_rcid);
> +    qdev_prop_set_bit(dev, "mon_op_config_event",
> +                      caps->supports_mon_op_config_event);
> +    qdev_prop_set_bit(dev, "mon_op_read_counter",
> +                      caps->supports_mon_op_read_counter);
> +    qdev_prop_set_bit(dev, "mon_evt_id_none",
> +                      caps->supports_mon_evt_id_none);
> +    qdev_prop_set_bit(dev, "mon_evt_id_occupancy",
> +                      caps->supports_mon_evt_id_occupancy);
> +
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    return dev;
> +}
> +
> +type_init(riscv_cbqri_cc_register_types)
> 


