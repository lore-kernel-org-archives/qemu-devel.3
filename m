Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2846CF6491
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2024 20:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sudyF-0006Li-K4; Sat, 28 Sep 2024 16:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sudyD-0006LA-NX
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 16:23:13 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sudyA-0000zp-HC
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 16:23:13 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c8784e3bc8so3691363a12.1
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2024 13:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727554988; x=1728159788; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ErINfRwU7abRrDv6lIadg6A/xzlkJPuubFoKdd566xM=;
 b=M57BBb44n4fJraqaHs595YMXe8Rh2hKwcLkAe2ouJfP8WVsVzWVWVAqxOjV7y91oES
 qIBoQAnabVCHBavcvnps74oYYVR5TgOV+opw8Xq1dBMmPZCUleWS1Emrq1aIlTGZDb7y
 1qz4i7G63VkAgNQHspHBmSRlQKfYo71MqFoq1dBwU5s/AxKuSUeNOD403Xzot4cSuXQD
 nZ6p5GDjcts6fV8Xesh1SJjJdKCvGYMWEfPaUopivEgXzlHXMd1oHAnoHZp8JUcC4TEi
 iauSDVJF5yyEz63zBJRBDXULuaH4KAMrl8y7O8ZzOhNfnyAWys24CbMn00OzzB3t14H2
 my0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727554988; x=1728159788;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ErINfRwU7abRrDv6lIadg6A/xzlkJPuubFoKdd566xM=;
 b=OSiGcTqDp/dFUhlKJWPsTYg/SuD0v5xXLp/W+8wWtewaLorUoioQxol6aPPYtE29Al
 eEK2CK0jyVcyuTS64O2+OonizYNltUew6AW+LIalN9W88pa6Va3w9phG4JSgZo+wf7/Y
 t2Y6LTw5R5RlCBw5DuQU/2bk1KBDl9BHWJmvIBvw4I9nrIXdADFXCE1oPjXuG9gPY0fK
 cLfw28osi/ve5kngE/IP5+y2yz3uqN6p5IRTK4wHBtdcKtoBU+xyMAP0GWWcrcqPeaJ7
 x/hrYcQYXmNZpvPXhWW1EMWiPjWOk8rbu1WCXtSeFEs5ltLUIz6M0KiooRj6JkncBjzo
 GbBg==
X-Gm-Message-State: AOJu0Yyouxv+itOhggckiGd6rF/13okfjnO6dREv8EYOl+VQ6CxB5jk2
 DMWAd2opgTDyP2f5rrx4z4/EefkTGkkMXtmcI+K/GF5+Ujy828Rl4zNJPOaIi1A5i3vMjMEJyFD
 DDm/3FX1qFKLAblibHEylYmQExWwRoYOUbTXUqw==
X-Google-Smtp-Source: AGHT+IHiQkKPlBPzVFD4YzSaWXM0sUYEkEpsGmO5kLRDVTwQkI6GW0XxQB/smrSVXVFtkHjBND/78lnVzABY467HyGs=
X-Received: by 2002:a17:907:7b9e:b0:a8d:4f8e:f669 with SMTP id
 a640c23a62f3a-a93c48f1e46mr759794266b.2.1727554987570; Sat, 28 Sep 2024
 13:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
 <20240924221751.2688389-17-alistair.francis@wdc.com>
In-Reply-To: <20240924221751.2688389-17-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 28 Sep 2024 21:22:55 +0100
Message-ID: <CAFEAcA8rdFYACFKdJga72WA4ET9NFRwrOifdbTYDBxY6G6uOXA@mail.gmail.com>
Subject: Re: [PULL v2 16/47] hw/riscv: add RISC-V IOMMU base emulation
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Tomasz Jeznach <tjeznach@rivosinc.com>, 
 Sebastien Boeuf <seb@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Tue, 24 Sept 2024 at 23:19, Alistair Francis <alistair23@gmail.com> wrote:
>
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> The RISC-V IOMMU specification is now ratified as-per the RISC-V
> international process. The latest frozen specifcation can be found at:
>
> https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv-iommu.pdf
>
> Add the foundation of the device emulation for RISC-V IOMMU. It includes
> support for s-stage (sv32, sv39, sv48, sv57 caps) and g-stage (sv32x4,
> sv39x4, sv48x4, sv57x4 caps).
>
> Other capabilities like ATS and DBG support will be added incrementally
> in the next patches.
>
> Co-developed-by: Sebastien Boeuf <seb@rivosinc.com>
> Signed-off-by: Sebastien Boeuf <seb@rivosinc.com>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Message-ID: <20240903201633.93182-4-dbarboza@ventanamicro.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  meson.build                 |    1 +
>  hw/riscv/riscv-iommu-bits.h |   18 +
>  hw/riscv/riscv-iommu.h      |  145 +++
>  hw/riscv/trace.h            |    1 +
>  include/hw/riscv/iommu.h    |   36 +
>  hw/riscv/riscv-iommu.c      | 2050 +++++++++++++++++++++++++++++++++++
>  hw/riscv/Kconfig            |    4 +
>  hw/riscv/meson.build        |    1 +
>  hw/riscv/trace-events       |   14 +
>  9 files changed, 2270 insertions(+)

Aside: patches this massive are really difficult to work with.
I just wanted to comment on a couple of things in here and
it's super painful. This is why we recommend breaking things
down a bit more...

>  create mode 100644 hw/riscv/riscv-iommu.h
>  create mode 100644 hw/riscv/trace.h
>  create mode 100644 include/hw/riscv/iommu.h
>  create mode 100644 hw/riscv/riscv-iommu.c
>  create mode 100644 hw/riscv/trace-events
>
> diff --git a/meson.build b/meson.build
> index 10464466ff..71de8a5cd1 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3439,6 +3439,7 @@ if have_system
>      'hw/pci-host',
>      'hw/ppc',
>      'hw/rtc',
> +    'hw/riscv',
>      'hw/s390x',
>      'hw/scsi',
>      'hw/sd',
> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> index c46d7d18ab..b1c477f5c3 100644
> --- a/hw/riscv/riscv-iommu-bits.h
> +++ b/hw/riscv/riscv-iommu-bits.h
> @@ -69,6 +69,14 @@ struct riscv_iommu_pq_record {
>  /* 5.3 IOMMU Capabilities (64bits) */
>  #define RISCV_IOMMU_REG_CAP             0x0000
>  #define RISCV_IOMMU_CAP_VERSION         GENMASK_ULL(7, 0)
> +#define RISCV_IOMMU_CAP_SV32            BIT_ULL(8)
> +#define RISCV_IOMMU_CAP_SV39            BIT_ULL(9)
> +#define RISCV_IOMMU_CAP_SV48            BIT_ULL(10)
> +#define RISCV_IOMMU_CAP_SV57            BIT_ULL(11)
> +#define RISCV_IOMMU_CAP_SV32X4          BIT_ULL(16)
> +#define RISCV_IOMMU_CAP_SV39X4          BIT_ULL(17)
> +#define RISCV_IOMMU_CAP_SV48X4          BIT_ULL(18)
> +#define RISCV_IOMMU_CAP_SV57X4          BIT_ULL(19)
>  #define RISCV_IOMMU_CAP_MSI_FLAT        BIT_ULL(22)
>  #define RISCV_IOMMU_CAP_MSI_MRIF        BIT_ULL(23)
>  #define RISCV_IOMMU_CAP_T2GPA           BIT_ULL(26)
> @@ -80,7 +88,9 @@ struct riscv_iommu_pq_record {
>
>  /* 5.4 Features control register (32bits) */
>  #define RISCV_IOMMU_REG_FCTL            0x0008
> +#define RISCV_IOMMU_FCTL_BE             BIT(0)
>  #define RISCV_IOMMU_FCTL_WSI            BIT(1)
> +#define RISCV_IOMMU_FCTL_GXL            BIT(2)
>
>  /* 5.5 Device-directory-table pointer (64bits) */
>  #define RISCV_IOMMU_REG_DDTP            0x0010
> @@ -175,6 +185,10 @@ enum {
>
>  /* 5.27 Interrupt cause to vector (64bits) */
>  #define RISCV_IOMMU_REG_ICVEC           0x02F8
> +#define RISCV_IOMMU_ICVEC_CIV           GENMASK_ULL(3, 0)
> +#define RISCV_IOMMU_ICVEC_FIV           GENMASK_ULL(7, 4)
> +#define RISCV_IOMMU_ICVEC_PMIV          GENMASK_ULL(11, 8)
> +#define RISCV_IOMMU_ICVEC_PIV           GENMASK_ULL(15, 12)
>
>  /* 5.28 MSI Configuration table (32 * 64bits) */
>  #define RISCV_IOMMU_REG_MSI_CONFIG      0x0300
> @@ -203,6 +217,8 @@ struct riscv_iommu_dc {
>  #define RISCV_IOMMU_DC_TC_DTF           BIT_ULL(4)
>  #define RISCV_IOMMU_DC_TC_PDTV          BIT_ULL(5)
>  #define RISCV_IOMMU_DC_TC_PRPR          BIT_ULL(6)
> +#define RISCV_IOMMU_DC_TC_GADE          BIT_ULL(7)
> +#define RISCV_IOMMU_DC_TC_SADE          BIT_ULL(8)
>  #define RISCV_IOMMU_DC_TC_DPE           BIT_ULL(9)
>  #define RISCV_IOMMU_DC_TC_SBE           BIT_ULL(10)
>  #define RISCV_IOMMU_DC_TC_SXL           BIT_ULL(11)
> @@ -309,9 +325,11 @@ enum riscv_iommu_fq_causes {
>
>  /* Translation attributes fields */
>  #define RISCV_IOMMU_PC_TA_V             BIT_ULL(0)
> +#define RISCV_IOMMU_PC_TA_RESERVED      GENMASK_ULL(63, 32)
>
>  /* First stage context fields */
>  #define RISCV_IOMMU_PC_FSC_PPN          GENMASK_ULL(43, 0)
> +#define RISCV_IOMMU_PC_FSC_RESERVED     GENMASK_ULL(59, 44)
>
>  enum riscv_iommu_fq_ttypes {
>      RISCV_IOMMU_FQ_TTYPE_NONE = 0,
> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> new file mode 100644
> index 0000000000..95b4ce8d50
> --- /dev/null
> +++ b/hw/riscv/riscv-iommu.h
> @@ -0,0 +1,145 @@
> +/*
> + * QEMU emulation of an RISC-V IOMMU
> + *
> + * Copyright (C) 2022-2023 Rivos Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License.
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
> +#ifndef HW_RISCV_IOMMU_STATE_H
> +#define HW_RISCV_IOMMU_STATE_H
> +
> +#include "qemu/osdep.h"
> +#include "qom/object.h"
> +
> +#include "hw/riscv/iommu.h"
> +
> +struct RISCVIOMMUState {
> +    /*< private >*/
> +    DeviceState parent_obj;
> +
> +    /*< public >*/
> +    uint32_t version;     /* Reported interface version number */
> +    uint32_t pid_bits;    /* process identifier width */
> +    uint32_t bus;         /* PCI bus mapping for non-root endpoints */
> +
> +    uint64_t cap;         /* IOMMU supported capabilities */
> +    uint64_t fctl;        /* IOMMU enabled features */
> +    uint64_t icvec_avail_vectors;  /* Available interrupt vectors in ICVEC */
> +
> +    bool enable_off;      /* Enable out-of-reset OFF mode (DMA disabled) */
> +    bool enable_msi;      /* Enable MSI remapping */
> +    bool enable_s_stage;  /* Enable S/VS-Stage translation */
> +    bool enable_g_stage;  /* Enable G-Stage translation */
> +
> +    /* IOMMU Internal State */
> +    uint64_t ddtp;        /* Validated Device Directory Tree Root Pointer */
> +
> +    dma_addr_t cq_addr;   /* Command queue base physical address */
> +    dma_addr_t fq_addr;   /* Fault/event queue base physical address */
> +    dma_addr_t pq_addr;   /* Page request queue base physical address */
> +
> +    uint32_t cq_mask;     /* Command queue index bit mask */
> +    uint32_t fq_mask;     /* Fault/event queue index bit mask */
> +    uint32_t pq_mask;     /* Page request queue index bit mask */
> +
> +    /* interrupt notifier */
> +    void (*notify)(RISCVIOMMUState *iommu, unsigned vector);
> +
> +    /* IOMMU State Machine */
> +    QemuThread core_proc; /* Background processing thread */
> +    QemuMutex core_lock;  /* Global IOMMU lock, used for cache/regs updates */
> +    QemuCond core_cond;   /* Background processing wake up signal */
> +    unsigned core_exec;   /* Processing thread execution actions */
> +
> +    /* IOMMU target address space */
> +    AddressSpace *target_as;
> +    MemoryRegion *target_mr;
> +
> +    /* MSI / MRIF access trap */
> +    AddressSpace trap_as;
> +    MemoryRegion trap_mr;
> +
> +    GHashTable *ctx_cache;          /* Device translation Context Cache */
> +    QemuMutex ctx_lock;      /* Device translation Cache update lock */
> +
> +    /* MMIO Hardware Interface */
> +    MemoryRegion regs_mr;
> +    QemuSpin regs_lock;
> +    uint8_t *regs_rw;  /* register state (user write) */
> +    uint8_t *regs_wc;  /* write-1-to-clear mask */
> +    uint8_t *regs_ro;  /* read-only mask */
> +
> +    QLIST_ENTRY(RISCVIOMMUState) iommus;
> +    QLIST_HEAD(, RISCVIOMMUSpace) spaces;
> +};
> +
> +void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
> +         Error **errp);
> +
> +/* private helpers */
> +
> +/* Register helper functions */
> +static inline uint32_t riscv_iommu_reg_mod32(RISCVIOMMUState *s,
> +    unsigned idx, uint32_t set, uint32_t clr)
> +{
> +    uint32_t val;
> +    qemu_spin_lock(&s->regs_lock);
> +    val = ldl_le_p(s->regs_rw + idx);
> +    stl_le_p(s->regs_rw + idx, (val & ~clr) | set);
> +    qemu_spin_unlock(&s->regs_lock);
> +    return val;
> +}

This looks very weird. Nobody else's IOMMU implementation
grabs a spinlock while it is accessing guest register data.
Why is riscv special? Why a spinlock? (We use spinlocks
only very very sparingly in general.)


> --- /dev/null
> +++ b/include/hw/riscv/iommu.h
> @@ -0,0 +1,36 @@
> +/*
> + * QEMU emulation of an RISC-V IOMMU
> + *
> + * Copyright (C) 2022-2023 Rivos Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License.
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
> +#ifndef HW_RISCV_IOMMU_H
> +#define HW_RISCV_IOMMU_H
> +
> +#include "qemu/osdep.h"

Header files should never include osdep.h. .c files always do.

> +#include "qom/object.h"
> +
> +#define TYPE_RISCV_IOMMU "riscv-iommu"
> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUState, RISCV_IOMMU)
> +typedef struct RISCVIOMMUState RISCVIOMMUState;
> +
> +#define TYPE_RISCV_IOMMU_MEMORY_REGION "riscv-iommu-mr"
> +typedef struct RISCVIOMMUSpace RISCVIOMMUSpace;
> +
> +#define TYPE_RISCV_IOMMU_PCI "riscv-iommu-pci"
> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStatePci, RISCV_IOMMU_PCI)
> +typedef struct RISCVIOMMUStatePci RISCVIOMMUStatePci;
> +
> +#endif

> --- /dev/null
> +++ b/hw/riscv/riscv-iommu.c
> @@ -0,0 +1,2050 @@
> +/*
> + * QEMU emulation of an RISC-V IOMMU
> + *
> + * Copyright (C) 2021-2023, Rivos Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License.

This text makes no sense. Is it trying to say "version 2 only",
or "either version 2 or any later version"? This needs to
be fixed before we can take this code -- it needs to use the
standard text for whatever license you intend (which ideally
should be gpl-2-or-later).

> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */




> +/*
> + * RISCV IOMMU Address Translation Lookup - Page Table Walk
> + *
> + * Note: Code is based on get_physical_address() from target/riscv/cpu_helper.c
> + * Both implementation can be merged into single helper function in future.
> + * Keeping them separate for now, as error reporting and flow specifics are
> + * sufficiently different for separate implementation.
> + *
> + * @s        : IOMMU Device State
> + * @ctx      : Translation context for device id and process address space id.
> + * @iotlb    : translation data: physical address and access mode.
> + * @return   : success or fault cause code.
> + */
> +static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
> +    IOMMUTLBEntry *iotlb)
> +{
> +    dma_addr_t addr, base;
> +    uint64_t satp, gatp, pte;
> +    bool en_s, en_g;
> +    struct {
> +        unsigned char step;
> +        unsigned char levels;
> +        unsigned char ptidxbits;
> +        unsigned char ptesize;
> +    } sc[2];
> +    /* Translation stage phase */
> +    enum {
> +        S_STAGE = 0,
> +        G_STAGE = 1,
> +    } pass;
> +
> +    satp = get_field(ctx->satp, RISCV_IOMMU_ATP_MODE_FIELD);
> +    gatp = get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
> +
> +    en_s = satp != RISCV_IOMMU_DC_FSC_MODE_BARE;
> +    en_g = gatp != RISCV_IOMMU_DC_IOHGATP_MODE_BARE;
> +
> +    /*
> +     * Early check for MSI address match when IOVA == GPA. This check
> +     * is required to ensure MSI translation is applied in case
> +     * first-stage translation is set to BARE mode. In this case IOVA
> +     * provided is a valid GPA. Running translation through page walk
> +     * second stage translation will incorrectly try to translate GPA
> +     * to host physical page, likely hitting IOPF.
> +     */
> +    if ((iotlb->perm & IOMMU_WO) &&
> +        riscv_iommu_msi_check(s, ctx, iotlb->iova)) {
> +        iotlb->target_as = &s->trap_as;
> +        iotlb->translated_addr = iotlb->iova;
> +        iotlb->addr_mask = ~TARGET_PAGE_MASK;
> +        return 0;
> +    }
> +
> +    /* Exit early for pass-through mode. */
> +    if (!(en_s || en_g)) {
> +        iotlb->translated_addr = iotlb->iova;
> +        iotlb->addr_mask = ~TARGET_PAGE_MASK;
> +        /* Allow R/W in pass-through mode */
> +        iotlb->perm = IOMMU_RW;
> +        return 0;
> +    }
> +
> +    /* S/G translation parameters. */
> +    for (pass = 0; pass < 2; pass++) {
> +        uint32_t sv_mode;
> +
> +        sc[pass].step = 0;
> +        if (pass ? (s->fctl & RISCV_IOMMU_FCTL_GXL) :
> +            (ctx->tc & RISCV_IOMMU_DC_TC_SXL)) {
> +            /* 32bit mode for GXL/SXL == 1 */
> +            switch (pass ? gatp : satp) {
> +            case RISCV_IOMMU_DC_IOHGATP_MODE_BARE:
> +                sc[pass].levels    = 0;
> +                sc[pass].ptidxbits = 0;
> +                sc[pass].ptesize   = 0;
> +                break;
> +            case RISCV_IOMMU_DC_IOHGATP_MODE_SV32X4:
> +                sv_mode = pass ? RISCV_IOMMU_CAP_SV32X4 : RISCV_IOMMU_CAP_SV32;
> +                if (!(s->cap & sv_mode)) {
> +                    return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> +                }
> +                sc[pass].levels    = 2;
> +                sc[pass].ptidxbits = 10;
> +                sc[pass].ptesize   = 4;
> +                break;
> +            default:
> +                return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> +            }
> +        } else {
> +            /* 64bit mode for GXL/SXL == 0 */
> +            switch (pass ? gatp : satp) {
> +            case RISCV_IOMMU_DC_IOHGATP_MODE_BARE:
> +                sc[pass].levels    = 0;
> +                sc[pass].ptidxbits = 0;
> +                sc[pass].ptesize   = 0;
> +                break;
> +            case RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4:
> +                sv_mode = pass ? RISCV_IOMMU_CAP_SV39X4 : RISCV_IOMMU_CAP_SV39;
> +                if (!(s->cap & sv_mode)) {
> +                    return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> +                }
> +                sc[pass].levels    = 3;
> +                sc[pass].ptidxbits = 9;
> +                sc[pass].ptesize   = 8;
> +                break;
> +            case RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4:
> +                sv_mode = pass ? RISCV_IOMMU_CAP_SV48X4 : RISCV_IOMMU_CAP_SV48;
> +                if (!(s->cap & sv_mode)) {
> +                    return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> +                }
> +                sc[pass].levels    = 4;
> +                sc[pass].ptidxbits = 9;
> +                sc[pass].ptesize   = 8;
> +                break;
> +            case RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4:
> +                sv_mode = pass ? RISCV_IOMMU_CAP_SV57X4 : RISCV_IOMMU_CAP_SV57;
> +                if (!(s->cap & sv_mode)) {
> +                    return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> +                }
> +                sc[pass].levels    = 5;
> +                sc[pass].ptidxbits = 9;
> +                sc[pass].ptesize   = 8;
> +                break;
> +            default:
> +                return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> +            }
> +        }
> +    };
> +
> +    /* S/G stages translation tables root pointers */
> +    gatp = PPN_PHYS(get_field(ctx->gatp, RISCV_IOMMU_ATP_PPN_FIELD));
> +    satp = PPN_PHYS(get_field(ctx->satp, RISCV_IOMMU_ATP_PPN_FIELD));
> +    addr = (en_s && en_g) ? satp : iotlb->iova;
> +    base = en_g ? gatp : satp;
> +    pass = en_g ? G_STAGE : S_STAGE;
> +
> +    do {
> +        const unsigned widened = (pass && !sc[pass].step) ? 2 : 0;
> +        const unsigned va_bits = widened + sc[pass].ptidxbits;
> +        const unsigned va_skip = TARGET_PAGE_BITS + sc[pass].ptidxbits *
> +                                 (sc[pass].levels - 1 - sc[pass].step);
> +        const unsigned idx = (addr >> va_skip) & ((1 << va_bits) - 1);
> +        const dma_addr_t pte_addr = base + idx * sc[pass].ptesize;
> +        const bool ade =
> +            ctx->tc & (pass ? RISCV_IOMMU_DC_TC_GADE : RISCV_IOMMU_DC_TC_SADE);
> +
> +        /* Address range check before first level lookup */
> +        if (!sc[pass].step) {
> +            const uint64_t va_mask = (1ULL << (va_skip + va_bits)) - 1;
> +            if ((addr & va_mask) != addr) {
> +                return RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED;
> +            }
> +        }
> +
> +        /* Read page table entry */
> +        if (dma_memory_read(s->target_as, pte_addr, &pte,
> +                sc[pass].ptesize, MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
> +            return (iotlb->perm & IOMMU_WO) ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT
> +                                            : RISCV_IOMMU_FQ_CAUSE_RD_FAULT;
> +        }
> +
> +        if (sc[pass].ptesize == 4) {
> +            pte = (uint64_t) le32_to_cpu(*((uint32_t *)&pte));
> +        } else {
> +            pte = le64_to_cpu(pte);
> +        }

I think this would be clearer to read if you did
   if (sc[pass].ptesize == 4) {
       uint32_t pte32 = 0;
       r = ldl_le_dma(s->target_as, pte_addr, &pte32, MEMTX_ATTRS_UNSPECIFIED);
       pte = pte32;
   } else {
       r = ldq_le_dma(s->target_as, pte_addr, &pte, MEMTX_ATTRS_UNSPECIFIED);
   }
   if (r != MEMTX_OK) {
       ...
   }

rather than loading 4 or 8 bytes into a host uint64_t as a pile-of-bytes
and doing a complicated expression to get the right answer afterwards.


> +/* Translation Context cache support */
> +static gboolean __ctx_equal(gconstpointer v1, gconstpointer v2)

Don't use double-underscore prefixes, please -- those are
reserved for the system (i.e. not user code like QEMU).

> +{
> +    RISCVIOMMUContext *c1 = (RISCVIOMMUContext *) v1;
> +    RISCVIOMMUContext *c2 = (RISCVIOMMUContext *) v2;
> +    return c1->devid == c2->devid &&
> +           c1->process_id == c2->process_id;
> +}
> +
> +static MemTxResult riscv_iommu_mmio_read(void *opaque, hwaddr addr,
> +    uint64_t *data, unsigned size, MemTxAttrs attrs)
> +{
> +    RISCVIOMMUState *s = opaque;
> +    uint64_t val = -1;
> +    uint8_t *ptr;
> +
> +    if ((addr & (size - 1)) != 0) {
> +        /* Unsupported MMIO alignment. */
> +        return MEMTX_ERROR;
> +    }
> +
> +    if (addr + size > RISCV_IOMMU_REG_MSI_CONFIG) {
> +        return MEMTX_ACCESS_ERROR;
> +    }
> +
> +    ptr = &s->regs_rw[addr];
> +
> +    if (size == 1) {
> +        val = (uint64_t)*ptr;

This looks very fishy. If we're reading 1 byte then cast
the pointer to uint64_t* and read 8 possibly-misaligned bytes ??

If you want to read one byte, then the way that parallels
the other cases in this if() ladder is
          val = ldub_p(ptr);

> +    } else if (size == 2) {
> +        val = lduw_le_p(ptr);
> +    } else if (size == 4) {
> +        val = ldl_le_p(ptr);
> +    } else if (size == 8) {
> +        val = ldq_le_p(ptr);
> +    } else {
> +        return MEMTX_ERROR;
> +    }

...but you can replace the whole if ladder with
       val = ldn_le_p(ptr, size);

(There's a corresponding stn_le_p() if you need it.)

> +
> +    *data = val;
> +
> +    return MEMTX_OK;
> +}
> +
> +static const MemoryRegionOps riscv_iommu_mmio_ops = {
> +    .read_with_attrs = riscv_iommu_mmio_read,
> +    .write_with_attrs = riscv_iommu_mmio_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 8,

But you've set your impl here to say that it can
only handle 4 and 8 byte accesses. So why is the read
function trying to handle 1 and 2 byte accesses?

> +        .unaligned = false,
> +    },
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 8,
> +    }
> +};
> +

-- PMM

