Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794C3C54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 16:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siygT-0005T8-9b; Tue, 27 Aug 2024 12:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tjeznach@rivosinc.com>)
 id 1siygR-0005Ry-6D
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 12:04:39 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tjeznach@rivosinc.com>)
 id 1siygL-0006cE-QT
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 12:04:38 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2d3c08541cdso4451751a91.2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 09:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724774672; x=1725379472;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=saY2dVL9rlYraAvnnOykcsQJaktQMb59DP3AJlzSg+A=;
 b=0F5yDMQ2ID9cxkW6lkSerNEv3GcynSK5JAmeLqKLm+2VQN5lkvBHmSwndEzLvVaSLE
 ro6+T6Vqi2KidTS0g8yZL3wClWHoYI8ViB6e0R8tT/Jkno4WMzNnsNFFWMcazEQki9I/
 B9JJhuXLs6WSkBZ39ym4HtFDzjc9PUgc/OOv1Dc52H74bSHE98fRqG+e+V+pwWxp14BE
 xltqOUTP07KxGftLk6iyNOVH96wwAemqzMjDd72pWo4sGgJIrqNdo7tV7L2tP3taMGsw
 cn7jOXYx/0atON2BqDe37OZ7IwifM8bnSBfuKMVNlShUJswUFUpq+qHmCebV2Q+ueh9w
 zt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724774672; x=1725379472;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=saY2dVL9rlYraAvnnOykcsQJaktQMb59DP3AJlzSg+A=;
 b=jjAFrIs0cohloiJAszpaLkB9YjiCW2CDcGkEJEYjFTkXF+NO18wsacQdqLcWS7ui2l
 BGovZ6nUpf0Ycngj2Rbktj7fzF/l+FIP5GN7hsmnRJM5nL8auEBaK6NxVAI/0TLNk8Mi
 hnFJW2U3qeOJ0DUuMIRombALFKXJjn7TcD0ucMIXBN125A5kaLfp9kldpDJ7JBTYbPYG
 K62Bix8KwABWFLDZCLHMg+gUKsmKpJGg0KGA+YJ4wzWLC8YMqjW6RaDQTqd/wR3qwIeE
 vxn31qB2VEHA1YFcWKRO5j6N9xYY8zUJqk9jw1RkfLutbmbUBeQsS0kgEUdxmysQkkzr
 X2Ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRsbHrodp6GbzeL/YhWao7aKbDSOuIkwpPHXL+YdWfpc94spmooLkr0EfP3sY31jfkfz+BxkbThgcC@nongnu.org
X-Gm-Message-State: AOJu0Yye2n7miEGJpGEZ8/oEKVsrBDcVy4wykumjE/gs+2xwH0EZZzqg
 MxP7rktuEKEu7TQFTYiEfELEohyHotagXdNKuBvYyKX9quGGuaC9tOHdV9AhFTz8OolgDaxef2w
 hYKHK6s3G7q58rq0+7pjgGRYRz/09rS7b7ENZ1A==
X-Google-Smtp-Source: AGHT+IFb7/giLWTPhWBi3K/IWKXW+NTD0KyjqGfBWIG8lsO3JTD5ZD+nnnQxcC1ssQP1VrIpgPmW1INE4GxOcCFJflA=
X-Received: by 2002:a17:90a:4cc7:b0:2cd:2992:e8dc with SMTP id
 98e67ed59e1d1-2d646bd1741mr14905615a91.5.1724774671478; Tue, 27 Aug 2024
 09:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240624201825.1054980-1-dbarboza@ventanamicro.com>
 <20240624201825.1054980-4-dbarboza@ventanamicro.com>
 <a1be0779-cbb5-42d2-8ced-7567c66f2bd0@sifive.com>
In-Reply-To: <a1be0779-cbb5-42d2-8ced-7567c66f2bd0@sifive.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Tue, 27 Aug 2024 09:04:20 -0700
Message-ID: <CAH2o1u7sRg8EQkdw1DKBVt2nse1Sc=hxn-V+uZDpDG9+HRKXOQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/14] hw/riscv: add RISC-V IOMMU base emulation
To: Jason Chien <jason.chien@sifive.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 alistair.francis@wdc.com, bmeng@tinylab.org, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, ajones@ventanamicro.com, 
 frank.chang@sifive.com, Sebastien Boeuf <seb@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=tjeznach@rivosinc.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Jul 4, 2024 at 7:20=E2=80=AFAM Jason Chien <jason.chien@sifive.com>=
 wrote:
>
> Hi Danial,
>
> On 2024/6/25 =E4=B8=8A=E5=8D=88 04:18, Daniel Henrique Barboza wrote:
> > From: Tomasz Jeznach <tjeznach@rivosinc.com>
> >
> > The RISC-V IOMMU specification is now ratified as-per the RISC-V
> > international process. The latest frozen specifcation can be found at:
> >
> > https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/ris=
cv-iommu.pdf
> >
> > Add the foundation of the device emulation for RISC-V IOMMU, which
> > includes an IOMMU that has no capabilities but MSI interrupt support an=
d
> > fault queue interfaces. We'll add more features incrementally in the
> > next patches.
> >
> > Co-developed-by: Sebastien Boeuf <seb@rivosinc.com>
> > Signed-off-by: Sebastien Boeuf <seb@rivosinc.com>
> > Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> > Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > ---
> >   hw/riscv/Kconfig            |    4 +
> >   hw/riscv/meson.build        |    1 +
> >   hw/riscv/riscv-iommu-bits.h |    2 +
> >   hw/riscv/riscv-iommu.c      | 1641 ++++++++++++++++++++++++++++++++++=
+
> >   hw/riscv/riscv-iommu.h      |  142 +++
> >   hw/riscv/trace-events       |   11 +
> >   hw/riscv/trace.h            |    1 +
> >   include/hw/riscv/iommu.h    |   36 +
> >   meson.build                 |    1 +
> >   9 files changed, 1839 insertions(+)
> >   create mode 100644 hw/riscv/riscv-iommu.c
> >   create mode 100644 hw/riscv/riscv-iommu.h
> >   create mode 100644 hw/riscv/trace-events
> >   create mode 100644 hw/riscv/trace.h
> >   create mode 100644 include/hw/riscv/iommu.h
> >
> > diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> > index a2030e3a6f..f69d6e3c8e 100644
> > --- a/hw/riscv/Kconfig
> > +++ b/hw/riscv/Kconfig
> > @@ -1,3 +1,6 @@
> > +config RISCV_IOMMU
> > +    bool
> > +
> >   config RISCV_NUMA
> >       bool
> >
> > @@ -47,6 +50,7 @@ config RISCV_VIRT
> >       select SERIAL
> >       select RISCV_ACLINT
> >       select RISCV_APLIC
> > +    select RISCV_IOMMU
> >       select RISCV_IMSIC
> >       select SIFIVE_PLIC
> >       select SIFIVE_TEST
> > diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> > index f872674093..cbc99c6e8e 100644
> > --- a/hw/riscv/meson.build
> > +++ b/hw/riscv/meson.build
> > @@ -10,5 +10,6 @@ riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files(=
'sifive_u.c'))
> >   riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
> >   riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchi=
p_pfsoc.c'))
> >   riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c')=
)
> > +riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu.c=
'))
> >
> >   hw_arch +=3D {'riscv': riscv_ss}
> > diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> > index f29b916acb..8a1af73685 100644
> > --- a/hw/riscv/riscv-iommu-bits.h
> > +++ b/hw/riscv/riscv-iommu-bits.h
> > @@ -82,6 +82,7 @@ struct riscv_iommu_pq_record {
> >
> >   /* 5.4 Features control register (32bits) */
> >   #define RISCV_IOMMU_REG_FCTL            0x0008
> > +#define RISCV_IOMMU_FCTL_BE             BIT(0)
> >   #define RISCV_IOMMU_FCTL_WSI            BIT(1)
> >
> >   /* 5.5 Device-directory-table pointer (64bits) */
> > @@ -311,6 +312,7 @@ enum riscv_iommu_fq_causes {
> >
> >   /* Translation attributes fields */
> >   #define RISCV_IOMMU_PC_TA_V             BIT_ULL(0)
> > +#define RISCV_IOMMU_PC_TA_RESERVED      GENMASK_ULL(63, 32)
> >
> >   /* First stage context fields */
> >   #define RISCV_IOMMU_PC_FSC_PPN          GENMASK_ULL(43, 0)
> > diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> > new file mode 100644
> > index 0000000000..37d7d1e657
> > --- /dev/null
> > +++ b/hw/riscv/riscv-iommu.c
> > @@ -0,0 +1,1641 @@
> > +/*
> > + * QEMU emulation of an RISC-V IOMMU
> > + *
> > + * Copyright (C) 2021-2023, Rivos Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation; either version 2 of the License.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License a=
long
> > + * with this program; if not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qom/object.h"
> > +#include "hw/pci/pci_bus.h"
> > +#include "hw/pci/pci_device.h"
> > +#include "hw/qdev-properties.h"
> > +#include "hw/riscv/riscv_hart.h"
> > +#include "migration/vmstate.h"
> > +#include "qapi/error.h"
> > +#include "qemu/timer.h"
> > +
> > +#include "cpu_bits.h"
> > +#include "riscv-iommu.h"
> > +#include "riscv-iommu-bits.h"
> > +#include "trace.h"
> > +
> > +#define LIMIT_CACHE_CTX               (1U << 7)
> > +#define LIMIT_CACHE_IOT               (1U << 20)
> > +
> > +/* Physical page number coversions */
> > +#define PPN_PHYS(ppn)                 ((ppn) << TARGET_PAGE_BITS)
> > +#define PPN_DOWN(phy)                 ((phy) >> TARGET_PAGE_BITS)
> > +
> > +typedef struct RISCVIOMMUContext RISCVIOMMUContext;
> > +typedef struct RISCVIOMMUEntry RISCVIOMMUEntry;
> > +
> > +/* Device assigned I/O address space */
> > +struct RISCVIOMMUSpace {
> > +    IOMMUMemoryRegion iova_mr;  /* IOVA memory region for attached dev=
ice */
> > +    AddressSpace iova_as;       /* IOVA address space for attached dev=
ice */
> > +    RISCVIOMMUState *iommu;     /* Managing IOMMU device state */
> > +    uint32_t devid;             /* Requester identifier, AKA device_id=
 */
> > +    bool notifier;              /* IOMMU unmap notifier enabled */
> > +    QLIST_ENTRY(RISCVIOMMUSpace) list;
> > +};
> > +
> > +/* Device translation context state. */
> > +struct RISCVIOMMUContext {
> > +    uint64_t devid:24;          /* Requester Id, AKA device_id */
> > +    uint64_t process_id:20;     /* Process ID. PASID for PCIe */
> > +    uint64_t __rfu:20;          /* reserved */
> > +    uint64_t tc;                /* Translation Control */
> > +    uint64_t ta;                /* Translation Attributes */
> > +    uint64_t msi_addr_mask;     /* MSI filtering - address mask */
> > +    uint64_t msi_addr_pattern;  /* MSI filtering - address pattern */
> > +    uint64_t msiptp;            /* MSI redirection page table pointer =
*/
> > +};
> > +
> > +/* IOMMU index for transactions without process_id specified. */
> > +#define RISCV_IOMMU_NOPROCID 0
> > +
> > +static void riscv_iommu_notify(RISCVIOMMUState *s, int vec)
> > +{
> > +    const uint32_t fctl =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_F=
CTL);
> > +    uint32_t ipsr, ivec;
> > +
> > +    if (fctl & RISCV_IOMMU_FCTL_WSI || !s->notify) {
> For WSI, we can assert INTx by invoking pci_set_irq().
> > +        return;
> > +    }
> > +
> > +    ipsr =3D riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_IPSR, (1 << vec)=
, 0);
> > +    ivec =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_IVEC);
> > +
> > +    if (!(ipsr & (1 << vec))) {
> > +        s->notify(s, (ivec >> (vec * 4)) & 0x0F);
> > +    }
> > +}
> > +
> > +static void riscv_iommu_fault(RISCVIOMMUState *s,
> > +                              struct riscv_iommu_fq_record *ev)
> > +{
> > +    uint32_t ctrl =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQCSR);
> > +    uint32_t head =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQH) & =
s->fq_mask;
> > +    uint32_t tail =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQT) & =
s->fq_mask;
> > +    uint32_t next =3D (tail + 1) & s->fq_mask;
> > +    uint32_t devid =3D get_field(ev->hdr, RISCV_IOMMU_FQ_HDR_DID);
> > +
> > +    trace_riscv_iommu_flt(s->parent_obj.id, PCI_BUS_NUM(devid), PCI_SL=
OT(devid),
> > +                          PCI_FUNC(devid), ev->hdr, ev->iotval);
> > +
> > +    if (!(ctrl & RISCV_IOMMU_FQCSR_FQON) ||
> > +        !!(ctrl & (RISCV_IOMMU_FQCSR_FQOF | RISCV_IOMMU_FQCSR_FQMF))) =
{
> > +        return;
> > +    }
> > +
> > +    if (head =3D=3D next) {
> > +        riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_FQCSR,
> > +                              RISCV_IOMMU_FQCSR_FQOF, 0);
> > +    } else {
> > +        dma_addr_t addr =3D s->fq_addr + tail * sizeof(*ev);
> > +        if (dma_memory_write(s->target_as, addr, ev, sizeof(*ev),
> > +                             MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {
> > +            riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_FQCSR,
> > +                                  RISCV_IOMMU_FQCSR_FQMF, 0);
> > +        } else {
> > +            riscv_iommu_reg_set32(s, RISCV_IOMMU_REG_FQT, next);
> > +        }
> > +    }
> > +
> > +    if (ctrl & RISCV_IOMMU_FQCSR_FIE) {
> > +        riscv_iommu_notify(s, RISCV_IOMMU_INTR_FQ);
> > +    }
> > +}
> > +
> > +static void riscv_iommu_pri(RISCVIOMMUState *s,
> > +    struct riscv_iommu_pq_record *pr)
> > +{
> > +    uint32_t ctrl =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_PQCSR);
> > +    uint32_t head =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_PQH) & =
s->pq_mask;
> > +    uint32_t tail =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_PQT) & =
s->pq_mask;
> > +    uint32_t next =3D (tail + 1) & s->pq_mask;
> > +    uint32_t devid =3D get_field(pr->hdr, RISCV_IOMMU_PREQ_HDR_DID);
> > +
> > +    trace_riscv_iommu_pri(s->parent_obj.id, PCI_BUS_NUM(devid), PCI_SL=
OT(devid),
> > +                          PCI_FUNC(devid), pr->payload);
> > +
> > +    if (!(ctrl & RISCV_IOMMU_PQCSR_PQON) ||
> > +        !!(ctrl & (RISCV_IOMMU_PQCSR_PQOF | RISCV_IOMMU_PQCSR_PQMF))) =
{
> > +        return;
> > +    }
> > +
> > +    if (head =3D=3D next) {
> > +        riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_PQCSR,
> > +                              RISCV_IOMMU_PQCSR_PQOF, 0);
> > +    } else {
> > +        dma_addr_t addr =3D s->pq_addr + tail * sizeof(*pr);
> > +        if (dma_memory_write(s->target_as, addr, pr, sizeof(*pr),
> > +                             MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {
> > +            riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_PQCSR,
> > +                                  RISCV_IOMMU_PQCSR_PQMF, 0);
> > +        } else {
> > +            riscv_iommu_reg_set32(s, RISCV_IOMMU_REG_PQT, next);
> > +        }
> > +    }
> > +
> > +    if (ctrl & RISCV_IOMMU_PQCSR_PIE) {
> > +        riscv_iommu_notify(s, RISCV_IOMMU_INTR_PQ);
> > +    }
> > +}
> > +
> > +/* Portable implementation of pext_u64, bit-mask extraction. */
> > +static uint64_t _pext_u64(uint64_t val, uint64_t ext)
> > +{
> > +    uint64_t ret =3D 0;
> > +    uint64_t rot =3D 1;
> > +
> > +    while (ext) {
> > +        if (ext & 1) {
> > +            if (val & 1) {
> > +                ret |=3D rot;
> > +            }
> > +            rot <<=3D 1;
> > +        }
> > +        val >>=3D 1;
> > +        ext >>=3D 1;
> > +    }
> > +
> > +    return ret;
> > +}
> > +
> > +/* Check if GPA matches MSI/MRIF pattern. */
> > +static bool riscv_iommu_msi_check(RISCVIOMMUState *s, RISCVIOMMUContex=
t *ctx,
> > +    dma_addr_t gpa)
> > +{
>
> If IOMMU does not support MSI, that is, s->enable_msi is false, we can
> return false.
>
> > +    if (get_field(ctx->msiptp, RISCV_IOMMU_DC_MSIPTP_MODE) !=3D
> > +        RISCV_IOMMU_DC_MSIPTP_MODE_FLAT) {
> > +        return false; /* Invalid MSI/MRIF mode */
> > +    }
> > +
> > +    if ((PPN_DOWN(gpa) ^ ctx->msi_addr_pattern) & ~ctx->msi_addr_mask)=
 {
> > +        return false; /* GPA not in MSI range defined by AIA IMSIC rul=
es. */
> > +    }
> > +
> > +    return true;
> > +}
> > +
> > +/* RISCV IOMMU Address Translation Lookup - Page Table Walk */
> > +static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext=
 *ctx,
> > +    IOMMUTLBEntry *iotlb)
> > +{
> > +    /* Early check for MSI address match when IOVA =3D=3D GPA */
> > +    if (iotlb->perm & IOMMU_WO &&
> > +        riscv_iommu_msi_check(s, ctx, iotlb->iova)) {
> > +        iotlb->target_as =3D &s->trap_as;
> > +        iotlb->translated_addr =3D iotlb->iova;
> > +        iotlb->addr_mask =3D ~TARGET_PAGE_MASK;
> > +        return 0;
> > +    }
>  From spec 2.3, step 17 and step 18 state that the MSI address
> translation is always done after the first stage translation is done.
> > +
> > +    /* Exit early for pass-through mode. */
> > +    iotlb->translated_addr =3D iotlb->iova;
> > +    iotlb->addr_mask =3D ~TARGET_PAGE_MASK;
> > +    /* Allow R/W in pass-through mode */
> > +    iotlb->perm =3D IOMMU_RW;
> > +    return 0;
> > +}
> > +
> > +static void riscv_iommu_report_fault(RISCVIOMMUState *s,
> > +                                     RISCVIOMMUContext *ctx,
> > +                                     uint32_t fault_type, uint32_t cau=
se,
> > +                                     bool pv,
> > +                                     uint64_t iotval, uint64_t iotval2=
)
> > +{
> > +    struct riscv_iommu_fq_record ev =3D { 0 };
> > +
> > +    if (ctx->tc & RISCV_IOMMU_DC_TC_DTF) {
> > +        switch (cause) {
> > +        case RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED:
> > +        case RISCV_IOMMU_FQ_CAUSE_DDT_LOAD_FAULT:
> > +        case RISCV_IOMMU_FQ_CAUSE_DDT_INVALID:
> > +        case RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED:
> > +        case RISCV_IOMMU_FQ_CAUSE_DDT_CORRUPTED:
> > +        case RISCV_IOMMU_FQ_CAUSE_INTERNAL_DP_ERROR:
> > +        case RISCV_IOMMU_FQ_CAUSE_MSI_WR_FAULT:
> > +            break;
> > +        default:
> > +            /* DTF prevents reporting a fault for this given cause */
> > +            return;
> > +        }
> > +    }
> > +
> > +    ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_CAUSE, cause);
> > +    ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_TTYPE, fault_type)=
;
> > +    ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_DID, ctx->devid);
> > +    ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_PV, true);
> > +
> > +    if (pv) {
> > +        ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_PID, ctx->proc=
ess_id);
> > +    }
> > +
> > +    ev.iotval =3D iotval;
> > +    ev.iotval2 =3D iotval2;
> > +
> > +    riscv_iommu_fault(s, &ev);
> > +}
> > +
> > +/* Redirect MSI write for given GPA. */
> > +static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
> > +    RISCVIOMMUContext *ctx, uint64_t gpa, uint64_t data,
> > +    unsigned size, MemTxAttrs attrs)
> > +{
> > +    MemTxResult res;
> > +    dma_addr_t addr;
> > +    uint64_t intn;
> > +    uint32_t n190;
> > +    uint64_t pte[2];
> > +    int fault_type =3D RISCV_IOMMU_FQ_TTYPE_UADDR_WR;
> > +    int cause;
> > +
> > +    if (!riscv_iommu_msi_check(s, ctx, gpa)) {
> I think we have invoked riscv_iommu_msi_check() before writing to
> s->trap_as. Do we need this check?

As we have no control how/when devices will use translated address
space this check was added to detect incorrect use of returned address
space for IOVA translation and cases where device context MSI
configuration changed between translation and actual MSI generation.
Agree it looks as redundant check, but might help others to catch MSI
related problems.

Thanks,
- Tomasz


> > +        res =3D MEMTX_ACCESS_ERROR;
> > +        cause =3D RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;
> > +        goto err;
> > +    }
> > +
> > +    /* Interrupt File Number */
> > +    intn =3D _pext_u64(PPN_DOWN(gpa), ctx->msi_addr_mask);
> > +    if (intn >=3D 256) {
> > +        /* Interrupt file number out of range */
> > +        res =3D MEMTX_ACCESS_ERROR;
> > +        cause =3D RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;
> > +        goto err;
> > +    }
> > +
> > +    /* fetch MSI PTE */
> > +    addr =3D PPN_PHYS(get_field(ctx->msiptp, RISCV_IOMMU_DC_MSIPTP_PPN=
));
> > +    addr =3D addr | (intn * sizeof(pte));
> > +    res =3D dma_memory_read(s->target_as, addr, &pte, sizeof(pte),
> > +            MEMTXATTRS_UNSPECIFIED);
> > +    if (res !=3D MEMTX_OK) {
> > +        if (res =3D=3D MEMTX_DECODE_ERROR) {
> > +            cause =3D RISCV_IOMMU_FQ_CAUSE_MSI_PT_CORRUPTED;
> > +        } else {
> > +            cause =3D RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;
> > +        }
> > +        goto err;
> > +    }
> > +
> > +    le64_to_cpus(&pte[0]);
> > +    le64_to_cpus(&pte[1]);
> > +
> > +    if (!(pte[0] & RISCV_IOMMU_MSI_PTE_V) || (pte[0] & RISCV_IOMMU_MSI=
_PTE_C)) {
> > +        /*
> > +         * The spec mentions that: "If msipte.C =3D=3D 1, then further
> > +         * processing to interpret the PTE is implementation
> > +         * defined.". We'll abort with cause =3D 262 for this
> > +         * case too.
> > +         */
> > +        res =3D MEMTX_ACCESS_ERROR;
> > +        cause =3D RISCV_IOMMU_FQ_CAUSE_MSI_INVALID;
> > +        goto err;
> > +    }
> > +
> > +    switch (get_field(pte[0], RISCV_IOMMU_MSI_PTE_M)) {
> > +    case RISCV_IOMMU_MSI_PTE_M_BASIC:
> > +        /* MSI Pass-through mode */
> > +        addr =3D PPN_PHYS(get_field(pte[0], RISCV_IOMMU_MSI_PTE_PPN));
> > +        addr =3D addr | (gpa & TARGET_PAGE_MASK);
> > +
> > +        trace_riscv_iommu_msi(s->parent_obj.id, PCI_BUS_NUM(ctx->devid=
),
> > +                              PCI_SLOT(ctx->devid), PCI_FUNC(ctx->devi=
d),
> > +                              gpa, addr);
> > +
> > +        res =3D dma_memory_write(s->target_as, addr, &data, size, attr=
s);
> > +        if (res !=3D MEMTX_OK) {
> > +            cause =3D RISCV_IOMMU_FQ_CAUSE_MSI_WR_FAULT;
> > +            goto err;
> > +        }
> > +
> > +        return MEMTX_OK;
> > +    case RISCV_IOMMU_MSI_PTE_M_MRIF:
> > +        /* MRIF mode, continue. */
> > +        break;
> > +    default:
> > +        res =3D MEMTX_ACCESS_ERROR;
> > +        cause =3D RISCV_IOMMU_FQ_CAUSE_MSI_MISCONFIGURED;
> > +        goto err;
> > +    }
> > +
> > +    /*
> > +     * Report an error for interrupt identities exceeding the maximum =
allowed
> > +     * for an IMSIC interrupt file (2047) or destination address is no=
t 32-bit
> > +     * aligned. See IOMMU Specification, Chapter 2.3. MSI page tables.
> > +     */
> > +    if ((data > 2047) || (gpa & 3)) {
> > +        res =3D MEMTX_ACCESS_ERROR;
> > +        cause =3D RISCV_IOMMU_FQ_CAUSE_MSI_MISCONFIGURED;
> > +        goto err;
> > +    }
> > +
> > +    /* MSI MRIF mode, non atomic pending bit update */
> > +
> > +    /* MRIF pending bit address */
> > +    addr =3D get_field(pte[0], RISCV_IOMMU_MSI_PTE_MRIF_ADDR) << 9;
> > +    addr =3D addr | ((data & 0x7c0) >> 3);
> > +
> > +    trace_riscv_iommu_msi(s->parent_obj.id, PCI_BUS_NUM(ctx->devid),
> > +                          PCI_SLOT(ctx->devid), PCI_FUNC(ctx->devid),
> > +                          gpa, addr);
> > +
> > +    /* MRIF pending bit mask */
> > +    data =3D 1ULL << (data & 0x03f);
> > +    res =3D dma_memory_read(s->target_as, addr, &intn, sizeof(intn), a=
ttrs);
> > +    if (res !=3D MEMTX_OK) {
> > +        cause =3D RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;
> > +        goto err;
> > +    }
> > +
> > +    intn =3D intn | data;
> > +    res =3D dma_memory_write(s->target_as, addr, &intn, sizeof(intn), =
attrs);
> > +    if (res !=3D MEMTX_OK) {
> > +        cause =3D RISCV_IOMMU_FQ_CAUSE_MSI_WR_FAULT;
> > +        goto err;
> > +    }
> > +
> > +    /* Get MRIF enable bits */
> > +    addr =3D addr + sizeof(intn);
> > +    res =3D dma_memory_read(s->target_as, addr, &intn, sizeof(intn), a=
ttrs);
> > +    if (res !=3D MEMTX_OK) {
> > +        cause =3D RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;
> > +        goto err;
> > +    }
> > +
> > +    if (!(intn & data)) {
> > +        /* notification disabled, MRIF update completed. */
> > +        return MEMTX_OK;
> > +    }
> > +
> > +    /* Send notification message */
> > +    addr =3D PPN_PHYS(get_field(pte[1], RISCV_IOMMU_MSI_MRIF_NPPN));
> > +    n190 =3D get_field(pte[1], RISCV_IOMMU_MSI_MRIF_NID) |
> > +          (get_field(pte[1], RISCV_IOMMU_MSI_MRIF_NID_MSB) << 10);
> > +
> > +    res =3D dma_memory_write(s->target_as, addr, &n190, sizeof(n190), =
attrs);
> > +    if (res !=3D MEMTX_OK) {
> > +        cause =3D RISCV_IOMMU_FQ_CAUSE_MSI_WR_FAULT;
> > +        goto err;
> > +    }
> > +
> > +    return MEMTX_OK;
> > +
> > +err:
> > +    riscv_iommu_report_fault(s, ctx, fault_type, cause,
> > +                             !!ctx->process_id, 0, 0);
> > +    return res;
> > +}
> > +
> > +/*
> > + * Check device context configuration as described by the
> > + * riscv-iommu spec section "Device-context configuration
> > + * checks".
> > + */
> > +static bool riscv_iommu_validate_device_ctx(RISCVIOMMUState *s,
> > +                                            RISCVIOMMUContext *ctx)
> > +{
> > +    uint32_t msi_mode;
> > +
> > +    if (!(ctx->tc & RISCV_IOMMU_DC_TC_EN_PRI) &&
> > +        ctx->tc & RISCV_IOMMU_DC_TC_PRPR) {
> > +        return false;
> > +    }
> > +
> > +    if (!(s->cap & RISCV_IOMMU_CAP_T2GPA) &&
> > +        ctx->tc & RISCV_IOMMU_DC_TC_T2GPA) {
> > +        return false;
> > +    }
> > +
> > +    if (s->cap & RISCV_IOMMU_CAP_MSI_FLAT) {
> > +        msi_mode =3D get_field(ctx->msiptp, RISCV_IOMMU_DC_MSIPTP_MODE=
);
> > +
> > +        if (msi_mode !=3D RISCV_IOMMU_DC_MSIPTP_MODE_OFF &&
> > +            msi_mode !=3D RISCV_IOMMU_DC_MSIPTP_MODE_FLAT) {
> > +            return false;
> > +        }
> > +    }
> > +
> > +    /*
> > +     * CAP_END is always zero (only one endianess). FCTL_BE is
> > +     * always zero (little-endian accesses). Thus TC_SBE must
> > +     * always be LE, i.e. zero.
> > +     */
> > +    if (ctx->tc & RISCV_IOMMU_DC_TC_SBE) {
> > +        return false;
> > +    }
> > +
> > +    return true;
> > +}
> > +
> > +/*
> > + * Validate process context (PC) according to section
> > + * "Process-context configuration checks".
> > + */
> > +static bool riscv_iommu_validate_process_ctx(RISCVIOMMUState *s,
> > +                                             RISCVIOMMUContext *ctx)
> > +{
> > +    if (get_field(ctx->ta, RISCV_IOMMU_PC_TA_RESERVED)) {
> > +        return false;
> > +    }
> > +
> > +    /* FSC and svNN checks to be added when adding s/g-stage support *=
/
> > +    return true;
> > +}
> > +
> > +/*
> > + * RISC-V IOMMU Device Context Loopkup - Device Directory Tree Walk
> > + *
> > + * @s         : IOMMU Device State
> > + * @ctx       : Device Translation Context with devid and pasid set.
> > + * @return    : success or fault code.
> > + */
> > +static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext=
 *ctx)
> > +{
> > +    const uint64_t ddtp =3D s->ddtp;
> > +    unsigned mode =3D get_field(ddtp, RISCV_IOMMU_DDTP_MODE);
> > +    dma_addr_t addr =3D PPN_PHYS(get_field(ddtp, RISCV_IOMMU_DDTP_PPN)=
);
> > +    struct riscv_iommu_dc dc;
> > +    /* Device Context format: 0: extended (64 bytes) | 1: base (32 byt=
es) */
> > +    const int dc_fmt =3D !s->enable_msi;
> > +    const size_t dc_len =3D sizeof(dc) >> dc_fmt;
> > +    unsigned depth;
> > +    uint64_t de;
> > +
> > +    switch (mode) {
> > +    case RISCV_IOMMU_DDTP_MODE_OFF:
> > +        return RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED;
> > +
> > +    case RISCV_IOMMU_DDTP_MODE_BARE:
> > +        /* mock up pass-through translation context */
> > +        ctx->tc =3D RISCV_IOMMU_DC_TC_V;
> > +        ctx->ta =3D 0;
> > +        ctx->msiptp =3D 0;
> > +        return 0;
> > +
> > +    case RISCV_IOMMU_DDTP_MODE_1LVL:
> > +        depth =3D 0;
> > +        break;
> > +
> > +    case RISCV_IOMMU_DDTP_MODE_2LVL:
> > +        depth =3D 1;
> > +        break;
> > +
> > +    case RISCV_IOMMU_DDTP_MODE_3LVL:
> > +        depth =3D 2;
> > +        break;
> > +
> > +    default:
> > +        return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> > +    }
> > +
> > +    /*
> > +     * Check supported device id width (in bits).
> > +     * See IOMMU Specification, Chapter 6. Software guidelines.
> > +     * - if extended device-context format is used:
> > +     *   1LVL: 6, 2LVL: 15, 3LVL: 24
> > +     * - if base device-context format is used:
> > +     *   1LVL: 7, 2LVL: 16, 3LVL: 24
> > +     */
> > +    if (ctx->devid >=3D (1 << (depth * 9 + 6 + (dc_fmt && depth !=3D 2=
)))) {
> > +        return RISCV_IOMMU_FQ_CAUSE_TTYPE_BLOCKED;
> > +    }
> > +
> > +    /* Device directory tree walk */
> > +    for (; depth-- > 0; ) {
> > +        /*
> > +         * Select device id index bits based on device directory tree =
level
> > +         * and device context format.
> > +         * See IOMMU Specification, Chapter 2. Data Structures.
> > +         * - if extended device-context format is used:
> > +         *   device index: [23:15][14:6][5:0]
> > +         * - if base device-context format is used:
> > +         *   device index: [23:16][15:7][6:0]
> > +         */
> > +        const int split =3D depth * 9 + 6 + dc_fmt;
> > +        addr |=3D ((ctx->devid >> split) << 3) & ~TARGET_PAGE_MASK;
> > +        if (dma_memory_read(s->target_as, addr, &de, sizeof(de),
> > +                            MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {
> > +            return RISCV_IOMMU_FQ_CAUSE_DDT_LOAD_FAULT;
> > +        }
> > +        le64_to_cpus(&de);
> > +        if (!(de & RISCV_IOMMU_DDTE_VALID)) {
> > +            /* invalid directory entry */
> > +            return RISCV_IOMMU_FQ_CAUSE_DDT_INVALID;
> > +        }
> > +        if (de & ~(RISCV_IOMMU_DDTE_PPN | RISCV_IOMMU_DDTE_VALID)) {
> > +            /* reserved bits set */
> > +            return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> > +        }
> > +        addr =3D PPN_PHYS(get_field(de, RISCV_IOMMU_DDTE_PPN));
> > +    }
> > +
> > +    /* index into device context entry page */
> > +    addr |=3D (ctx->devid * dc_len) & ~TARGET_PAGE_MASK;
> > +
> > +    memset(&dc, 0, sizeof(dc));
> > +    if (dma_memory_read(s->target_as, addr, &dc, dc_len,
> > +                        MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {
> > +        return RISCV_IOMMU_FQ_CAUSE_DDT_LOAD_FAULT;
> > +    }
> > +
> > +    /* Set translation context. */
> > +    ctx->tc =3D le64_to_cpu(dc.tc);
> > +    ctx->ta =3D le64_to_cpu(dc.ta);
> > +    ctx->msiptp =3D le64_to_cpu(dc.msiptp);
> > +    ctx->msi_addr_mask =3D le64_to_cpu(dc.msi_addr_mask);
> > +    ctx->msi_addr_pattern =3D le64_to_cpu(dc.msi_addr_pattern);
> > +
> > +    if (!(ctx->tc & RISCV_IOMMU_DC_TC_V)) {
> > +        return RISCV_IOMMU_FQ_CAUSE_DDT_INVALID;
> > +    }
> > +
> > +    if (!riscv_iommu_validate_device_ctx(s, ctx)) {
> > +        return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> > +    }
> > +
> > +    if (!(ctx->tc & RISCV_IOMMU_DC_TC_PDTV)) {
> > +        if (ctx->process_id !=3D RISCV_IOMMU_NOPROCID) {
> > +            /* PASID is disabled */
> > +            return RISCV_IOMMU_FQ_CAUSE_TTYPE_BLOCKED;
> > +        }
> > +        return 0;
> > +    }
> > +
> > +    /* FSC.TC.PDTV enabled */
> > +    if (mode > RISCV_IOMMU_DC_FSC_PDTP_MODE_PD20) {
> > +        /* Invalid PDTP.MODE */
> > +        return RISCV_IOMMU_FQ_CAUSE_PDT_MISCONFIGURED;
> > +    }
> > +
> > +    for (depth =3D mode - RISCV_IOMMU_DC_FSC_PDTP_MODE_PD8; depth-- > =
0; ) {
> > +        /*
> > +         * Select process id index bits based on process directory tre=
e
> > +         * level. See IOMMU Specification, 2.2. Process-Directory-Tabl=
e.
> > +         */
> > +        const int split =3D depth * 9 + 8;
> > +        addr |=3D ((ctx->process_id >> split) << 3) & ~TARGET_PAGE_MAS=
K;
> > +        if (dma_memory_read(s->target_as, addr, &de, sizeof(de),
> > +                            MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {
> > +            return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
> > +        }
> > +        le64_to_cpus(&de);
> > +        if (!(de & RISCV_IOMMU_PC_TA_V)) {
> > +            return RISCV_IOMMU_FQ_CAUSE_PDT_INVALID;
> > +        }
> > +        addr =3D PPN_PHYS(get_field(de, RISCV_IOMMU_PC_FSC_PPN));
> > +    }
> > +
> > +    /* Leaf entry in PDT */
> > +    addr |=3D (ctx->process_id << 4) & ~TARGET_PAGE_MASK;
> > +    if (dma_memory_read(s->target_as, addr, &dc.ta, sizeof(uint64_t) *=
 2,
> > +                        MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {
> > +        return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
> > +    }
> > +
> > +    /* Use TA from process directory entry. */
> > +    ctx->ta =3D le64_to_cpu(dc.ta);
> > +
> > +    if (!(ctx->ta & RISCV_IOMMU_PC_TA_V)) {
> > +        return RISCV_IOMMU_FQ_CAUSE_PDT_INVALID;
> > +    }
> > +
> > +    if (!riscv_iommu_validate_process_ctx(s, ctx)) {
> > +        return RISCV_IOMMU_FQ_CAUSE_PDT_MISCONFIGURED;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +/* Translation Context cache support */
> > +static gboolean __ctx_equal(gconstpointer v1, gconstpointer v2)
> > +{
> > +    RISCVIOMMUContext *c1 =3D (RISCVIOMMUContext *) v1;
> > +    RISCVIOMMUContext *c2 =3D (RISCVIOMMUContext *) v2;
> > +    return c1->devid =3D=3D c2->devid &&
> > +           c1->process_id =3D=3D c2->process_id;
> > +}
> > +
> > +static guint __ctx_hash(gconstpointer v)
> > +{
> > +    RISCVIOMMUContext *ctx =3D (RISCVIOMMUContext *) v;
> > +    /*
> > +     * Generate simple hash of (process_id, devid)
> > +     * assuming 24-bit wide devid.
> > +     */
> > +    return (guint)(ctx->devid) + ((guint)(ctx->process_id) << 24);
> > +}
> > +
> > +static void __ctx_inval_devid_procid(gpointer key, gpointer value,
> > +                                     gpointer data)
> > +{
> > +    RISCVIOMMUContext *ctx =3D (RISCVIOMMUContext *) value;
> > +    RISCVIOMMUContext *arg =3D (RISCVIOMMUContext *) data;
> > +    if (ctx->tc & RISCV_IOMMU_DC_TC_V &&
> > +        ctx->devid =3D=3D arg->devid &&
> > +        ctx->process_id =3D=3D arg->process_id) {
> > +        ctx->tc &=3D ~RISCV_IOMMU_DC_TC_V;
> > +    }
> > +}
> > +
> > +static void __ctx_inval_devid(gpointer key, gpointer value, gpointer d=
ata)
> > +{
> > +    RISCVIOMMUContext *ctx =3D (RISCVIOMMUContext *) value;
> > +    RISCVIOMMUContext *arg =3D (RISCVIOMMUContext *) data;
> > +    if (ctx->tc & RISCV_IOMMU_DC_TC_V &&
> > +        ctx->devid =3D=3D arg->devid) {
> > +        ctx->tc &=3D ~RISCV_IOMMU_DC_TC_V;
> > +    }
> > +}
> > +
> > +static void __ctx_inval_all(gpointer key, gpointer value, gpointer dat=
a)
> > +{
> > +    RISCVIOMMUContext *ctx =3D (RISCVIOMMUContext *) value;
> > +    if (ctx->tc & RISCV_IOMMU_DC_TC_V) {
> > +        ctx->tc &=3D ~RISCV_IOMMU_DC_TC_V;
> > +    }
> > +}
> > +
> > +static void riscv_iommu_ctx_inval(RISCVIOMMUState *s, GHFunc func,
> > +                                  uint32_t devid, uint32_t process_id)
> > +{
> > +    GHashTable *ctx_cache;
> > +    RISCVIOMMUContext key =3D {
> > +        .devid =3D devid,
> > +        .process_id =3D process_id,
> > +    };
> > +    ctx_cache =3D g_hash_table_ref(s->ctx_cache);
> > +    qemu_mutex_lock(&s->ctx_lock);
> > +    g_hash_table_foreach(ctx_cache, func, &key);
> > +    qemu_mutex_unlock(&s->ctx_lock);
> > +    g_hash_table_unref(ctx_cache);
> > +}
> > +
> > +/* Find or allocate translation context for a given {device_id, proces=
s_id} */
> > +static RISCVIOMMUContext *riscv_iommu_ctx(RISCVIOMMUState *s,
> > +                                          unsigned devid, unsigned pro=
cess_id,
> > +                                          void **ref)
> > +{
> > +    GHashTable *ctx_cache;
> > +    RISCVIOMMUContext *ctx;
> > +    RISCVIOMMUContext key =3D {
> > +        .devid =3D devid,
> > +        .process_id =3D process_id,
> > +    };
> > +
> > +    ctx_cache =3D g_hash_table_ref(s->ctx_cache);
> > +    qemu_mutex_lock(&s->ctx_lock);
> > +    ctx =3D g_hash_table_lookup(ctx_cache, &key);
> > +    qemu_mutex_unlock(&s->ctx_lock);
> > +
> > +    if (ctx && (ctx->tc & RISCV_IOMMU_DC_TC_V)) {
> > +        *ref =3D ctx_cache;
> > +        return ctx;
> > +    }
> > +
> > +    ctx =3D g_new0(RISCVIOMMUContext, 1);
> > +    ctx->devid =3D devid;
> > +    ctx->process_id =3D process_id;
> > +
> > +    int fault =3D riscv_iommu_ctx_fetch(s, ctx);
> > +    if (!fault) {
> > +        qemu_mutex_lock(&s->ctx_lock);
> > +        if (g_hash_table_size(ctx_cache) >=3D LIMIT_CACHE_CTX) {
> > +            g_hash_table_unref(ctx_cache);
> > +            ctx_cache =3D g_hash_table_new_full(__ctx_hash, __ctx_equa=
l,
> > +                                              g_free, NULL);
> > +            g_hash_table_ref(ctx_cache);
> > +            g_hash_table_unref(qatomic_xchg(&s->ctx_cache, ctx_cache))=
;
> > +        }
> > +        g_hash_table_add(ctx_cache, ctx);
> > +        qemu_mutex_unlock(&s->ctx_lock);
> > +        *ref =3D ctx_cache;
> > +        return ctx;
> > +    }
> > +
> > +    g_hash_table_unref(ctx_cache);
> > +    *ref =3D NULL;
> > +
> > +    riscv_iommu_report_fault(s, ctx, RISCV_IOMMU_FQ_TTYPE_UADDR_RD,
> > +                             fault, !!process_id, 0, 0);
> > +
> > +    g_free(ctx);
> > +    return NULL;
> > +}
> > +
> > +static void riscv_iommu_ctx_put(RISCVIOMMUState *s, void *ref)
> > +{
> > +    if (ref) {
> > +        g_hash_table_unref((GHashTable *)ref);
> > +    }
> > +}
> > +
> > +/* Find or allocate address space for a given device */
> > +static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t de=
vid)
> > +{
> > +    RISCVIOMMUSpace *as;
> > +
> > +    /* FIXME: PCIe bus remapping for attached endpoints. */
> > +    devid |=3D s->bus << 8;
> > +
> > +    qemu_mutex_lock(&s->core_lock);
> > +    QLIST_FOREACH(as, &s->spaces, list) {
> > +        if (as->devid =3D=3D devid) {
> > +            break;
> > +        }
> > +    }
> > +    qemu_mutex_unlock(&s->core_lock);
> > +
> > +    if (as =3D=3D NULL) {
> > +        char name[64];
> > +        as =3D g_new0(RISCVIOMMUSpace, 1);
> > +
> > +        as->iommu =3D s;
> > +        as->devid =3D devid;
> > +
> > +        snprintf(name, sizeof(name), "riscv-iommu-%04x:%02x.%d-iova",
> > +            PCI_BUS_NUM(as->devid), PCI_SLOT(as->devid), PCI_FUNC(as->=
devid));
> > +
> > +        /* IOVA address space, untranslated addresses */
> > +        memory_region_init_iommu(&as->iova_mr, sizeof(as->iova_mr),
> > +            TYPE_RISCV_IOMMU_MEMORY_REGION,
> > +            OBJECT(as), "riscv_iommu", UINT64_MAX);
> > +        address_space_init(&as->iova_as, MEMORY_REGION(&as->iova_mr), =
name);
> > +
> > +        qemu_mutex_lock(&s->core_lock);
> > +        QLIST_INSERT_HEAD(&s->spaces, as, list);
> > +        qemu_mutex_unlock(&s->core_lock);
> > +
> > +        trace_riscv_iommu_new(s->parent_obj.id, PCI_BUS_NUM(as->devid)=
,
> > +                PCI_SLOT(as->devid), PCI_FUNC(as->devid));
> > +    }
> > +    return &as->iova_as;
> > +}
> > +
> > +static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext=
 *ctx,
> > +    IOMMUTLBEntry *iotlb)
> > +{
> > +    bool enable_pasid;
> > +    bool enable_pri;
> > +    int fault;
> > +
> > +    /*
> > +     * TC[32] is reserved for custom extensions, used here to temporar=
ily
> > +     * enable automatic page-request generation for ATS queries.
> > +     */
> > +    enable_pri =3D (iotlb->perm =3D=3D IOMMU_NONE) && (ctx->tc & BIT_U=
LL(32));
> > +    enable_pasid =3D (ctx->tc & RISCV_IOMMU_DC_TC_PDTV);
> > +
> > +    /* Translate using device directory / page table information. */
> > +    fault =3D riscv_iommu_spa_fetch(s, ctx, iotlb);
> > +
> > +    if (enable_pri && fault) {
> > +        struct riscv_iommu_pq_record pr =3D {0};
> > +        if (enable_pasid) {
> > +            pr.hdr =3D set_field(RISCV_IOMMU_PREQ_HDR_PV,
> > +                               RISCV_IOMMU_PREQ_HDR_PID, ctx->process_=
id);
> > +        }
> > +        pr.hdr =3D set_field(pr.hdr, RISCV_IOMMU_PREQ_HDR_DID, ctx->de=
vid);
> > +        pr.payload =3D (iotlb->iova & TARGET_PAGE_MASK) |
> > +                     RISCV_IOMMU_PREQ_PAYLOAD_M;
> > +        riscv_iommu_pri(s, &pr);
> > +        return fault;
> > +    }
> > +
> > +    if (fault) {
> > +        unsigned ttype;
> > +
> > +        if (iotlb->perm & IOMMU_RW) {
> > +            ttype =3D RISCV_IOMMU_FQ_TTYPE_UADDR_WR;
> > +        } else {
> > +            ttype =3D RISCV_IOMMU_FQ_TTYPE_UADDR_RD;
> > +        }
> > +
> > +        riscv_iommu_report_fault(s, ctx, ttype, fault, enable_pasid,
> > +                                 iotlb->iova, iotlb->translated_addr);
> > +        return fault;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +/* IOMMU Command Interface */
> > +static MemTxResult riscv_iommu_iofence(RISCVIOMMUState *s, bool notify=
,
> > +    uint64_t addr, uint32_t data)
> > +{
> > +    /*
> > +     * ATS processing in this implementation of the IOMMU is synchrono=
us,
> > +     * no need to wait for completions here.
> > +     */
> > +    if (!notify) {
> > +        return MEMTX_OK;
> > +    }
> > +
> > +    return dma_memory_write(s->target_as, addr, &data, sizeof(data),
> > +        MEMTXATTRS_UNSPECIFIED);
> > +}
> > +
> > +static void riscv_iommu_process_ddtp(RISCVIOMMUState *s)
> > +{
> > +    uint64_t old_ddtp =3D s->ddtp;
> > +    uint64_t new_ddtp =3D riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_DDT=
P);
> > +    unsigned new_mode =3D get_field(new_ddtp, RISCV_IOMMU_DDTP_MODE);
> > +    unsigned old_mode =3D get_field(old_ddtp, RISCV_IOMMU_DDTP_MODE);
> > +    bool ok =3D false;
> > +
> > +    /*
> > +     * Check for allowed DDTP.MODE transitions:
> > +     * {OFF, BARE}        -> {OFF, BARE, 1LVL, 2LVL, 3LVL}
> > +     * {1LVL, 2LVL, 3LVL} -> {OFF, BARE}
> > +     */
> > +    if (new_mode =3D=3D old_mode ||
> > +        new_mode =3D=3D RISCV_IOMMU_DDTP_MODE_OFF ||
> > +        new_mode =3D=3D RISCV_IOMMU_DDTP_MODE_BARE) {
> > +        ok =3D true;
> > +    } else if (new_mode =3D=3D RISCV_IOMMU_DDTP_MODE_1LVL ||
> > +               new_mode =3D=3D RISCV_IOMMU_DDTP_MODE_2LVL ||
> > +               new_mode =3D=3D RISCV_IOMMU_DDTP_MODE_3LVL) {
> > +        ok =3D old_mode =3D=3D RISCV_IOMMU_DDTP_MODE_OFF ||
> > +             old_mode =3D=3D RISCV_IOMMU_DDTP_MODE_BARE;
> > +    }
> > +
> > +    if (ok) {
> > +        /* clear reserved and busy bits, report back sanitized version=
 */
> > +        new_ddtp =3D set_field(new_ddtp & RISCV_IOMMU_DDTP_PPN,
> > +                             RISCV_IOMMU_DDTP_MODE, new_mode);
> > +    } else {
> > +        new_ddtp =3D old_ddtp;
> > +    }
> > +    s->ddtp =3D new_ddtp;
> > +
> > +    riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_DDTP, new_ddtp);
> > +}
> > +
> > +/* Command function and opcode field. */
> > +#define RISCV_IOMMU_CMD(func, op) (((func) << 7) | (op))
> > +
> > +static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
> > +{
> > +    struct riscv_iommu_command cmd;
> > +    MemTxResult res;
> > +    dma_addr_t addr;
> > +    uint32_t tail, head, ctrl;
> > +    uint64_t cmd_opcode;
> > +    GHFunc func;
> > +
> > +    ctrl =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQCSR);
> > +    tail =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQT) & s->cq_mas=
k;
> > +    head =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQH) & s->cq_mas=
k;
> > +
> > +    /* Check for pending error or queue processing disabled */
> > +    if (!(ctrl & RISCV_IOMMU_CQCSR_CQON) ||
> > +        !!(ctrl & (RISCV_IOMMU_CQCSR_CMD_ILL | RISCV_IOMMU_CQCSR_CQMF)=
)) {
> > +        return;
> > +    }
> > +
> > +    while (tail !=3D head) {
> > +        addr =3D s->cq_addr  + head * sizeof(cmd);
> > +        res =3D dma_memory_read(s->target_as, addr, &cmd, sizeof(cmd),
> > +                              MEMTXATTRS_UNSPECIFIED);
> > +
> > +        if (res !=3D MEMTX_OK) {
> > +            riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_CQCSR,
> > +                                  RISCV_IOMMU_CQCSR_CQMF, 0);
> > +            goto fault;
> > +        }
> > +
> > +        trace_riscv_iommu_cmd(s->parent_obj.id, cmd.dword0, cmd.dword1=
);
> > +
> > +        cmd_opcode =3D get_field(cmd.dword0,
> > +                               RISCV_IOMMU_CMD_OPCODE | RISCV_IOMMU_CM=
D_FUNC);
> > +
> > +        switch (cmd_opcode) {
> > +        case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOFENCE_FUNC_C,
> > +                             RISCV_IOMMU_CMD_IOFENCE_OPCODE):
> > +            res =3D riscv_iommu_iofence(s,
> > +                cmd.dword0 & RISCV_IOMMU_CMD_IOFENCE_AV, cmd.dword1,
> > +                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOFENCE_DATA));
> > +
> > +            if (res !=3D MEMTX_OK) {
> > +                riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_CQCSR,
> > +                                      RISCV_IOMMU_CQCSR_CQMF, 0);
> > +                goto fault;
> > +            }
> > +            break;
> > +
> > +        case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA,
> > +                             RISCV_IOMMU_CMD_IOTINVAL_OPCODE):
> > +            if (cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV) {
> > +                /* illegal command arguments IOTINVAL.GVMA & PSCV =3D=
=3D 1 */
> > +                goto cmd_ill;
> > +            }
> > +            /* translation cache not implemented yet */
> > +            break;
> > +
> > +        case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA,
> > +                             RISCV_IOMMU_CMD_IOTINVAL_OPCODE):
> > +            /* translation cache not implemented yet */
> > +            break;
> > +
> > +        case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_DDT,
> > +                             RISCV_IOMMU_CMD_IODIR_OPCODE):
> > +            if (!(cmd.dword0 & RISCV_IOMMU_CMD_IODIR_DV)) {
> > +                /* invalidate all device context cache mappings */
> > +                func =3D __ctx_inval_all;
> > +            } else {
> > +                /* invalidate all device context matching DID */
> > +                func =3D __ctx_inval_devid;
> > +            }
> > +            riscv_iommu_ctx_inval(s, func,
> > +                get_field(cmd.dword0, RISCV_IOMMU_CMD_IODIR_DID), 0);
> > +            break;
> > +
> > +        case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_PDT,
> > +                             RISCV_IOMMU_CMD_IODIR_OPCODE):
> > +            if (!(cmd.dword0 & RISCV_IOMMU_CMD_IODIR_DV)) {
> > +                /* illegal command arguments IODIR_PDT & DV =3D=3D 0 *=
/
> > +                goto cmd_ill;
> > +            } else {
> > +                func =3D __ctx_inval_devid_procid;
> > +            }
> > +            riscv_iommu_ctx_inval(s, func,
> > +                get_field(cmd.dword0, RISCV_IOMMU_CMD_IODIR_DID),
> > +                get_field(cmd.dword0, RISCV_IOMMU_CMD_IODIR_PID));
> > +            break;
> > +
> > +        default:
> > +        cmd_ill:
> > +            /* Invalid instruction, do not advance instruction index. =
*/
> > +            riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_CQCSR,
> > +                RISCV_IOMMU_CQCSR_CMD_ILL, 0);
> > +            goto fault;
> > +        }
> > +
> > +        /* Advance and update head pointer after command completes. */
> > +        head =3D (head + 1) & s->cq_mask;
> > +        riscv_iommu_reg_set32(s, RISCV_IOMMU_REG_CQH, head);
> > +    }
> > +    return;
> > +
> > +fault:
> > +    if (ctrl & RISCV_IOMMU_CQCSR_CIE) {
> > +        riscv_iommu_notify(s, RISCV_IOMMU_INTR_CQ);
> > +    }
> > +}
> > +
> > +static void riscv_iommu_process_cq_control(RISCVIOMMUState *s)
> > +{
> > +    uint64_t base;
> > +    uint32_t ctrl_set =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQC=
SR);
> > +    uint32_t ctrl_clr;
> > +    bool enable =3D !!(ctrl_set & RISCV_IOMMU_CQCSR_CQEN);
> > +    bool active =3D !!(ctrl_set & RISCV_IOMMU_CQCSR_CQON);
> > +
> > +    if (enable && !active) {
> > +        base =3D riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_CQB);
> > +        s->cq_mask =3D (2ULL << get_field(base, RISCV_IOMMU_CQB_LOG2SZ=
)) - 1;
> > +        s->cq_addr =3D PPN_PHYS(get_field(base, RISCV_IOMMU_CQB_PPN));
> > +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_CQT], ~s->cq_mask);
> > +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_CQH], 0);
> > +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_CQT], 0);
> > +        ctrl_set =3D RISCV_IOMMU_CQCSR_CQON;
> > +        ctrl_clr =3D RISCV_IOMMU_CQCSR_BUSY | RISCV_IOMMU_CQCSR_CQMF |
> > +                   RISCV_IOMMU_CQCSR_CMD_ILL | RISCV_IOMMU_CQCSR_CMD_T=
O |
> > +                   RISCV_IOMMU_CQCSR_FENCE_W_IP;
> > +    } else if (!enable && active) {
> > +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_CQT], ~0);
> > +        ctrl_set =3D 0;
> > +        ctrl_clr =3D RISCV_IOMMU_CQCSR_BUSY | RISCV_IOMMU_CQCSR_CQON;
> > +    } else {
> > +        ctrl_set =3D 0;
> > +        ctrl_clr =3D RISCV_IOMMU_CQCSR_BUSY;
> > +    }
> > +
> > +    riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_CQCSR, ctrl_set, ctrl_clr=
);
> > +}
> > +
> > +static void riscv_iommu_process_fq_control(RISCVIOMMUState *s)
> > +{
> > +    uint64_t base;
> > +    uint32_t ctrl_set =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQC=
SR);
> > +    uint32_t ctrl_clr;
> > +    bool enable =3D !!(ctrl_set & RISCV_IOMMU_FQCSR_FQEN);
> > +    bool active =3D !!(ctrl_set & RISCV_IOMMU_FQCSR_FQON);
> > +
> > +    if (enable && !active) {
> > +        base =3D riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_FQB);
> > +        s->fq_mask =3D (2ULL << get_field(base, RISCV_IOMMU_FQB_LOG2SZ=
)) - 1;
> > +        s->fq_addr =3D PPN_PHYS(get_field(base, RISCV_IOMMU_FQB_PPN));
> > +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_FQH], ~s->fq_mask);
> > +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_FQH], 0);
> > +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_FQT], 0);
> > +        ctrl_set =3D RISCV_IOMMU_FQCSR_FQON;
> > +        ctrl_clr =3D RISCV_IOMMU_FQCSR_BUSY | RISCV_IOMMU_FQCSR_FQMF |
> > +            RISCV_IOMMU_FQCSR_FQOF;
> > +    } else if (!enable && active) {
> > +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_FQH], ~0);
> > +        ctrl_set =3D 0;
> > +        ctrl_clr =3D RISCV_IOMMU_FQCSR_BUSY | RISCV_IOMMU_FQCSR_FQON;
> > +    } else {
> > +        ctrl_set =3D 0;
> > +        ctrl_clr =3D RISCV_IOMMU_FQCSR_BUSY;
> > +    }
> > +
> > +    riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_FQCSR, ctrl_set, ctrl_clr=
);
> > +}
> > +
> > +static void riscv_iommu_process_pq_control(RISCVIOMMUState *s)
> > +{
> > +    uint64_t base;
> > +    uint32_t ctrl_set =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_PQC=
SR);
> > +    uint32_t ctrl_clr;
> > +    bool enable =3D !!(ctrl_set & RISCV_IOMMU_PQCSR_PQEN);
> > +    bool active =3D !!(ctrl_set & RISCV_IOMMU_PQCSR_PQON);
> > +
> > +    if (enable && !active) {
> > +        base =3D riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_PQB);
> > +        s->pq_mask =3D (2ULL << get_field(base, RISCV_IOMMU_PQB_LOG2SZ=
)) - 1;
> > +        s->pq_addr =3D PPN_PHYS(get_field(base, RISCV_IOMMU_PQB_PPN));
> > +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_PQH], ~s->pq_mask);
> > +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_PQH], 0);
> > +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_PQT], 0);
> > +        ctrl_set =3D RISCV_IOMMU_PQCSR_PQON;
> > +        ctrl_clr =3D RISCV_IOMMU_PQCSR_BUSY | RISCV_IOMMU_PQCSR_PQMF |
> > +            RISCV_IOMMU_PQCSR_PQOF;
> > +    } else if (!enable && active) {
> > +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_PQH], ~0);
> > +        ctrl_set =3D 0;
> > +        ctrl_clr =3D RISCV_IOMMU_PQCSR_BUSY | RISCV_IOMMU_PQCSR_PQON;
> > +    } else {
> > +        ctrl_set =3D 0;
> > +        ctrl_clr =3D RISCV_IOMMU_PQCSR_BUSY;
> > +    }
> > +
> > +    riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_PQCSR, ctrl_set, ctrl_clr=
);
> > +}
> > +
> > +typedef void riscv_iommu_process_fn(RISCVIOMMUState *s);
> > +
> > +static void riscv_iommu_update_ipsr(RISCVIOMMUState *s, uint64_t data)
> > +{
> > +    uint32_t cqcsr, fqcsr, pqcsr;
> > +    uint32_t ipsr_set =3D 0;
> > +    uint32_t ipsr_clr =3D 0;
> > +
> > +    if (data & RISCV_IOMMU_IPSR_CIP) {
> > +        cqcsr =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQCSR);
> > +
> > +        if (cqcsr & RISCV_IOMMU_CQCSR_CIE &&
> > +            (cqcsr & RISCV_IOMMU_CQCSR_FENCE_W_IP ||
> > +             cqcsr & RISCV_IOMMU_CQCSR_CMD_ILL ||
> > +             cqcsr & RISCV_IOMMU_CQCSR_CMD_TO ||
> > +             cqcsr & RISCV_IOMMU_CQCSR_CQMF)) {
> > +            ipsr_set |=3D RISCV_IOMMU_IPSR_CIP;
> > +        } else {
> > +            ipsr_clr |=3D RISCV_IOMMU_IPSR_CIP;
> > +        }
> > +    } else {
> > +        ipsr_clr |=3D RISCV_IOMMU_IPSR_CIP;
> > +    }
> > +
> > +    if (data & RISCV_IOMMU_IPSR_FIP) {
> > +        fqcsr =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQCSR);
> > +
> > +        if (fqcsr & RISCV_IOMMU_FQCSR_FIE &&
> > +            (fqcsr & RISCV_IOMMU_FQCSR_FQOF ||
> > +             fqcsr & RISCV_IOMMU_FQCSR_FQMF)) {
> > +            ipsr_set |=3D RISCV_IOMMU_IPSR_FIP;
> > +        } else {
> > +            ipsr_clr |=3D RISCV_IOMMU_IPSR_FIP;
> > +        }
> > +    } else {
> > +        ipsr_clr |=3D RISCV_IOMMU_IPSR_FIP;
> > +    }
> > +
> > +    if (data & RISCV_IOMMU_IPSR_PIP) {
> > +        pqcsr =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_PQCSR);
> > +
> > +        if (pqcsr & RISCV_IOMMU_PQCSR_PIE &&
> > +            (pqcsr & RISCV_IOMMU_PQCSR_PQOF ||
> > +             pqcsr & RISCV_IOMMU_PQCSR_PQMF)) {
> > +            ipsr_set |=3D RISCV_IOMMU_IPSR_PIP;
> > +        } else {
> > +            ipsr_clr |=3D RISCV_IOMMU_IPSR_PIP;
> > +        }
> > +    } else {
> > +        ipsr_clr |=3D RISCV_IOMMU_IPSR_PIP;
> > +    }
> > +
> > +    riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_IPSR, ipsr_set, ipsr_clr)=
;
> If the pending bit is cleared, we can deassert the WSI.
> > +}
> > +
> > +static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
> > +    uint64_t data, unsigned size, MemTxAttrs attrs)
> > +{
> > +    riscv_iommu_process_fn *process_fn =3D NULL;
> > +    RISCVIOMMUState *s =3D opaque;
> > +    uint32_t regb =3D addr & ~3;
> > +    uint32_t busy =3D 0;
> > +    uint64_t val =3D 0;
> > +
> > +    if ((addr & (size - 1)) !=3D 0) {
> > +        /* Unsupported MMIO alignment or access size */
> > +        return MEMTX_ERROR;
> > +    }
> > +
> > +    if (addr + size > RISCV_IOMMU_REG_MSI_CONFIG) {
> > +        /* Unsupported MMIO access location. */
> > +        return MEMTX_ACCESS_ERROR;
> > +    }
> > +
> > +    /* Track actionable MMIO write. */
> > +    switch (regb) {
> > +    case RISCV_IOMMU_REG_DDTP:
> > +    case RISCV_IOMMU_REG_DDTP + 4:
> > +        process_fn =3D riscv_iommu_process_ddtp;
> > +        regb =3D RISCV_IOMMU_REG_DDTP;
> > +        busy =3D RISCV_IOMMU_DDTP_BUSY;
> > +        break;
> > +
> > +    case RISCV_IOMMU_REG_CQT:
> > +        process_fn =3D riscv_iommu_process_cq_tail;
> > +        break;
> > +
> > +    case RISCV_IOMMU_REG_CQCSR:
> > +        process_fn =3D riscv_iommu_process_cq_control;
> > +        busy =3D RISCV_IOMMU_CQCSR_BUSY;
> > +        break;
> > +
> > +    case RISCV_IOMMU_REG_FQCSR:
> > +        process_fn =3D riscv_iommu_process_fq_control;
> > +        busy =3D RISCV_IOMMU_FQCSR_BUSY;
> > +        break;
> > +
> > +    case RISCV_IOMMU_REG_PQCSR:
> > +        process_fn =3D riscv_iommu_process_pq_control;
> > +        busy =3D RISCV_IOMMU_PQCSR_BUSY;
> > +        break;
> > +
> > +    case RISCV_IOMMU_REG_IPSR:
> > +        /*
> > +         * IPSR has special procedures to update. Execute it
> > +         * and exit.
> > +         */
> > +        if (size =3D=3D 4) {
> > +            uint32_t ro =3D ldl_le_p(&s->regs_ro[addr]);
> > +            uint32_t wc =3D ldl_le_p(&s->regs_wc[addr]);
> > +            uint32_t rw =3D ldl_le_p(&s->regs_rw[addr]);
> > +            stl_le_p(&val, ((rw & ro) | (data & ~ro)) & ~(data & wc));
> > +        } else if (size =3D=3D 8) {
> > +            uint64_t ro =3D ldq_le_p(&s->regs_ro[addr]);
> > +            uint64_t wc =3D ldq_le_p(&s->regs_wc[addr]);
> > +            uint64_t rw =3D ldq_le_p(&s->regs_rw[addr]);
> > +            stq_le_p(&val, ((rw & ro) | (data & ~ro)) & ~(data & wc));
> > +        }
> > +
> > +        riscv_iommu_update_ipsr(s, val);
> > +
> > +        return MEMTX_OK;
> > +
> > +    default:
> > +        break;
> > +    }
> > +
> > +    /*
> > +     * Registers update might be not synchronized with core logic.
> > +     * If system software updates register when relevant BUSY bit
> > +     * is set IOMMU behavior of additional writes to the register
> > +     * is UNSPECIFIED.
> > +     */
> > +    qemu_spin_lock(&s->regs_lock);
> > +    if (size =3D=3D 1) {
> > +        uint8_t ro =3D s->regs_ro[addr];
> > +        uint8_t wc =3D s->regs_wc[addr];
> > +        uint8_t rw =3D s->regs_rw[addr];
> > +        s->regs_rw[addr] =3D ((rw & ro) | (data & ~ro)) & ~(data & wc)=
;
> > +    } else if (size =3D=3D 2) {
> > +        uint16_t ro =3D lduw_le_p(&s->regs_ro[addr]);
> > +        uint16_t wc =3D lduw_le_p(&s->regs_wc[addr]);
> > +        uint16_t rw =3D lduw_le_p(&s->regs_rw[addr]);
> > +        stw_le_p(&s->regs_rw[addr], ((rw & ro) | (data & ~ro)) & ~(dat=
a & wc));
> > +    } else if (size =3D=3D 4) {
> > +        uint32_t ro =3D ldl_le_p(&s->regs_ro[addr]);
> > +        uint32_t wc =3D ldl_le_p(&s->regs_wc[addr]);
> > +        uint32_t rw =3D ldl_le_p(&s->regs_rw[addr]);
> > +        stl_le_p(&s->regs_rw[addr], ((rw & ro) | (data & ~ro)) & ~(dat=
a & wc));
> > +    } else if (size =3D=3D 8) {
> > +        uint64_t ro =3D ldq_le_p(&s->regs_ro[addr]);
> > +        uint64_t wc =3D ldq_le_p(&s->regs_wc[addr]);
> > +        uint64_t rw =3D ldq_le_p(&s->regs_rw[addr]);
> > +        stq_le_p(&s->regs_rw[addr], ((rw & ro) | (data & ~ro)) & ~(dat=
a & wc));
> > +    }
> > +
> > +    /* Busy flag update, MSB 4-byte register. */
> > +    if (busy) {
> > +        uint32_t rw =3D ldl_le_p(&s->regs_rw[regb]);
> > +        stl_le_p(&s->regs_rw[regb], rw | busy);
> > +    }
> > +    qemu_spin_unlock(&s->regs_lock);
> > +
> > +    if (process_fn) {
> > +        qemu_mutex_lock(&s->core_lock);
> > +        process_fn(s);
> > +        qemu_mutex_unlock(&s->core_lock);
> > +    }
> > +
> > +    return MEMTX_OK;
> > +}
> > +
> > +static MemTxResult riscv_iommu_mmio_read(void *opaque, hwaddr addr,
> > +    uint64_t *data, unsigned size, MemTxAttrs attrs)
> > +{
> > +    RISCVIOMMUState *s =3D opaque;
> > +    uint64_t val =3D -1;
> > +    uint8_t *ptr;
> > +
> > +    if ((addr & (size - 1)) !=3D 0) {
> > +        /* Unsupported MMIO alignment. */
> > +        return MEMTX_ERROR;
> > +    }
> > +
> > +    if (addr + size > RISCV_IOMMU_REG_MSI_CONFIG) {
> > +        return MEMTX_ACCESS_ERROR;
> > +    }
> > +
> > +    ptr =3D &s->regs_rw[addr];
> > +
> > +    if (size =3D=3D 1) {
> > +        val =3D (uint64_t)*ptr;
> > +    } else if (size =3D=3D 2) {
> > +        val =3D lduw_le_p(ptr);
> > +    } else if (size =3D=3D 4) {
> > +        val =3D ldl_le_p(ptr);
> > +    } else if (size =3D=3D 8) {
> > +        val =3D ldq_le_p(ptr);
> > +    } else {
> > +        return MEMTX_ERROR;
> > +    }
> > +
> > +    *data =3D val;
> > +
> > +    return MEMTX_OK;
> > +}
> > +
> > +static const MemoryRegionOps riscv_iommu_mmio_ops =3D {
> > +    .read_with_attrs =3D riscv_iommu_mmio_read,
> > +    .write_with_attrs =3D riscv_iommu_mmio_write,
> > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > +    .impl =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 8,
> > +        .unaligned =3D false,
> > +    },
> > +    .valid =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 8,
> > +    }
> > +};
> > +
> > +/*
> > + * Translations matching MSI pattern check are redirected to "riscv-io=
mmu-trap"
> > + * memory region as untranslated address, for additional MSI/MRIF inte=
rception
> > + * by IOMMU interrupt remapping implementation.
> > + * Note: Device emulation code generating an MSI is expected to provid=
e a valid
> > + * memory transaction attributes with requested_id set.
> > + */
> > +static MemTxResult riscv_iommu_trap_write(void *opaque, hwaddr addr,
> > +    uint64_t data, unsigned size, MemTxAttrs attrs)
> > +{
> > +    RISCVIOMMUState* s =3D (RISCVIOMMUState *)opaque;
> > +    RISCVIOMMUContext *ctx;
> > +    MemTxResult res;
> > +    void *ref;
> > +    uint32_t devid =3D attrs.requester_id;
> > +
> > +    if (attrs.unspecified) {
> > +        return MEMTX_ACCESS_ERROR;
> > +    }
> > +
> > +    /* FIXME: PCIe bus remapping for attached endpoints. */
> > +    devid |=3D s->bus << 8;
> > +
> > +    ctx =3D riscv_iommu_ctx(s, devid, 0, &ref);
> > +    if (ctx =3D=3D NULL) {
> > +        res =3D MEMTX_ACCESS_ERROR;
> > +    } else {
> > +        res =3D riscv_iommu_msi_write(s, ctx, addr, data, size, attrs)=
;
> > +    }
> > +    riscv_iommu_ctx_put(s, ref);
> > +    return res;
> > +}
> > +
> > +static MemTxResult riscv_iommu_trap_read(void *opaque, hwaddr addr,
> > +    uint64_t *data, unsigned size, MemTxAttrs attrs)
> > +{
> > +    return MEMTX_ACCESS_ERROR;
> > +}
> > +
> > +static const MemoryRegionOps riscv_iommu_trap_ops =3D {
> > +    .read_with_attrs =3D riscv_iommu_trap_read,
> > +    .write_with_attrs =3D riscv_iommu_trap_write,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .impl =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 8,
> > +        .unaligned =3D true,
> > +    },
> > +    .valid =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 8,
> > +    }
> > +};
> > +
> > +static void riscv_iommu_realize(DeviceState *dev, Error **errp)
> > +{
> > +    RISCVIOMMUState *s =3D RISCV_IOMMU(dev);
> > +
> > +    s->cap =3D s->version & RISCV_IOMMU_CAP_VERSION;
> > +    if (s->enable_msi) {
> > +        s->cap |=3D RISCV_IOMMU_CAP_MSI_FLAT | RISCV_IOMMU_CAP_MSI_MRI=
F;
> > +    }
> > +    /* Report QEMU target physical address space limits */
> > +    s->cap =3D set_field(s->cap, RISCV_IOMMU_CAP_PAS,
> > +                       TARGET_PHYS_ADDR_SPACE_BITS);
> > +
> > +    /* TODO: method to report supported PASID bits */
> > +    s->pasid_bits =3D 8; /* restricted to size of MemTxAttrs.pasid */
> > +    s->cap |=3D RISCV_IOMMU_CAP_PD8;
> > +
> > +    /* Out-of-reset translation mode: OFF (DMA disabled) BARE (passthr=
ough) */
> > +    s->ddtp =3D set_field(0, RISCV_IOMMU_DDTP_MODE, s->enable_off ?
> > +                        RISCV_IOMMU_DDTP_MODE_OFF : RISCV_IOMMU_DDTP_M=
ODE_BARE);
> > +
> > +    /* register storage */
> > +    s->regs_rw =3D g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
> > +    s->regs_ro =3D g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
> > +    s->regs_wc =3D g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
> > +
> > +     /* Mark all registers read-only */
> > +    memset(s->regs_ro, 0xff, RISCV_IOMMU_REG_SIZE);
> > +
> > +    /*
> > +     * Register complete MMIO space, including MSI/PBA registers.
> > +     * Note, PCIDevice implementation will add overlapping MR for MSI/=
PBA,
> > +     * managed directly by the PCIDevice implementation.
> > +     */
> > +    memory_region_init_io(&s->regs_mr, OBJECT(dev), &riscv_iommu_mmio_=
ops, s,
> > +        "riscv-iommu-regs", RISCV_IOMMU_REG_SIZE);
> > +
> > +    /* Set power-on register state */
> > +    stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_CAP], s->cap);
> > +    stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_FCTL], 0);
> > +    stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_FCTL],
> > +             ~(RISCV_IOMMU_FCTL_BE | RISCV_IOMMU_FCTL_WSI));
> > +    stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_DDTP],
> > +        ~(RISCV_IOMMU_DDTP_PPN | RISCV_IOMMU_DDTP_MODE));
> > +    stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_CQB],
> > +        ~(RISCV_IOMMU_CQB_LOG2SZ | RISCV_IOMMU_CQB_PPN));
> > +    stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_FQB],
> > +        ~(RISCV_IOMMU_FQB_LOG2SZ | RISCV_IOMMU_FQB_PPN));
> > +    stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_PQB],
> > +        ~(RISCV_IOMMU_PQB_LOG2SZ | RISCV_IOMMU_PQB_PPN));
> > +    stl_le_p(&s->regs_wc[RISCV_IOMMU_REG_CQCSR], RISCV_IOMMU_CQCSR_CQM=
F |
> > +        RISCV_IOMMU_CQCSR_CMD_TO | RISCV_IOMMU_CQCSR_CMD_ILL);
> > +    stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_CQCSR], RISCV_IOMMU_CQCSR_CQO=
N |
> > +        RISCV_IOMMU_CQCSR_BUSY);
> > +    stl_le_p(&s->regs_wc[RISCV_IOMMU_REG_FQCSR], RISCV_IOMMU_FQCSR_FQM=
F |
> > +        RISCV_IOMMU_FQCSR_FQOF);
> > +    stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_FQCSR], RISCV_IOMMU_FQCSR_FQO=
N |
> > +        RISCV_IOMMU_FQCSR_BUSY);
> > +    stl_le_p(&s->regs_wc[RISCV_IOMMU_REG_PQCSR], RISCV_IOMMU_PQCSR_PQM=
F |
> > +        RISCV_IOMMU_PQCSR_PQOF);
> > +    stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_PQCSR], RISCV_IOMMU_PQCSR_PQO=
N |
> > +        RISCV_IOMMU_PQCSR_BUSY);
> > +    stl_le_p(&s->regs_wc[RISCV_IOMMU_REG_IPSR], ~0);
> > +    stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_IVEC], 0);
> > +    stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_DDTP], s->ddtp);
> > +
> > +    /* Memory region for downstream access, if specified. */
> > +    if (s->target_mr) {
> > +        s->target_as =3D g_new0(AddressSpace, 1);
> > +        address_space_init(s->target_as, s->target_mr,
> > +            "riscv-iommu-downstream");
> > +    } else {
> > +        /* Fallback to global system memory. */
> > +        s->target_as =3D &address_space_memory;
> > +    }
> > +
> > +    /* Memory region for untranslated MRIF/MSI writes */
> > +    memory_region_init_io(&s->trap_mr, OBJECT(dev), &riscv_iommu_trap_=
ops, s,
> > +            "riscv-iommu-trap", ~0ULL);
> > +    address_space_init(&s->trap_as, &s->trap_mr, "riscv-iommu-trap-as"=
);
> > +
> > +    /* Device translation context cache */
> > +    s->ctx_cache =3D g_hash_table_new_full(__ctx_hash, __ctx_equal,
> > +                                         g_free, NULL);
> > +    qemu_mutex_init(&s->ctx_lock);
> > +
> > +    s->iommus.le_next =3D NULL;
> > +    s->iommus.le_prev =3D NULL;
> > +    QLIST_INIT(&s->spaces);
> > +    qemu_mutex_init(&s->core_lock);
> > +    qemu_spin_init(&s->regs_lock);
> > +}
> > +
> > +static void riscv_iommu_unrealize(DeviceState *dev)
> > +{
> > +    RISCVIOMMUState *s =3D RISCV_IOMMU(dev);
> > +
> > +    qemu_mutex_destroy(&s->core_lock);
> > +    g_hash_table_unref(s->ctx_cache);
> > +}
> > +
> > +static Property riscv_iommu_properties[] =3D {
> > +    DEFINE_PROP_UINT32("version", RISCVIOMMUState, version,
> > +        RISCV_IOMMU_SPEC_DOT_VER),
> > +    DEFINE_PROP_UINT32("bus", RISCVIOMMUState, bus, 0x0),
> > +    DEFINE_PROP_BOOL("intremap", RISCVIOMMUState, enable_msi, TRUE),
> > +    DEFINE_PROP_BOOL("off", RISCVIOMMUState, enable_off, TRUE),
> > +    DEFINE_PROP_LINK("downstream-mr", RISCVIOMMUState, target_mr,
> > +        TYPE_MEMORY_REGION, MemoryRegion *),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void riscv_iommu_class_init(ObjectClass *klass, void* data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    /* internal device for riscv-iommu-{pci/sys}, not user-creatable *=
/
> > +    dc->user_creatable =3D false;
> > +    dc->realize =3D riscv_iommu_realize;
> > +    dc->unrealize =3D riscv_iommu_unrealize;
> > +    device_class_set_props(dc, riscv_iommu_properties);
> > +}
> > +
> > +static const TypeInfo riscv_iommu_info =3D {
> > +    .name =3D TYPE_RISCV_IOMMU,
> > +    .parent =3D TYPE_DEVICE,
> > +    .instance_size =3D sizeof(RISCVIOMMUState),
> > +    .class_init =3D riscv_iommu_class_init,
> > +};
> > +
> > +static const char *IOMMU_FLAG_STR[] =3D {
> > +    "NA",
> > +    "RO",
> > +    "WR",
> > +    "RW",
> > +};
> > +
> > +/* RISC-V IOMMU Memory Region - Address Translation Space */
> > +static IOMMUTLBEntry riscv_iommu_memory_region_translate(
> > +    IOMMUMemoryRegion *iommu_mr, hwaddr addr,
> > +    IOMMUAccessFlags flag, int iommu_idx)
> > +{
> > +    RISCVIOMMUSpace *as =3D container_of(iommu_mr, RISCVIOMMUSpace, io=
va_mr);
> > +    RISCVIOMMUContext *ctx;
> > +    void *ref;
> > +    IOMMUTLBEntry iotlb =3D {
> > +        .iova =3D addr,
> > +        .target_as =3D as->iommu->target_as,
> > +        .addr_mask =3D ~0ULL,
> > +        .perm =3D flag,
> > +    };
> > +
> > +    ctx =3D riscv_iommu_ctx(as->iommu, as->devid, iommu_idx, &ref);
> > +    if (ctx =3D=3D NULL) {
> > +        /* Translation disabled or invalid. */
> > +        iotlb.addr_mask =3D 0;
> > +        iotlb.perm =3D IOMMU_NONE;
> > +    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb)) {
> > +        /* Translation disabled or fault reported. */
> > +        iotlb.addr_mask =3D 0;
> > +        iotlb.perm =3D IOMMU_NONE;
> > +    }
> > +
> > +    /* Trace all dma translations with original access flags. */
> > +    trace_riscv_iommu_dma(as->iommu->parent_obj.id, PCI_BUS_NUM(as->de=
vid),
> > +                          PCI_SLOT(as->devid), PCI_FUNC(as->devid), io=
mmu_idx,
> > +                          IOMMU_FLAG_STR[flag & IOMMU_RW], iotlb.iova,
> > +                          iotlb.translated_addr);
> > +
> > +    riscv_iommu_ctx_put(as->iommu, ref);
> > +
> > +    return iotlb;
> > +}
> > +
> > +static int riscv_iommu_memory_region_notify(
> > +    IOMMUMemoryRegion *iommu_mr, IOMMUNotifierFlag old,
> > +    IOMMUNotifierFlag new, Error **errp)
> > +{
> > +    RISCVIOMMUSpace *as =3D container_of(iommu_mr, RISCVIOMMUSpace, io=
va_mr);
> > +
> > +    if (old =3D=3D IOMMU_NOTIFIER_NONE) {
> > +        as->notifier =3D true;
> > +        trace_riscv_iommu_notifier_add(iommu_mr->parent_obj.name);
> > +    } else if (new =3D=3D IOMMU_NOTIFIER_NONE) {
> > +        as->notifier =3D false;
> > +        trace_riscv_iommu_notifier_del(iommu_mr->parent_obj.name);
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static inline bool pci_is_iommu(PCIDevice *pdev)
> > +{
> > +    return pci_get_word(pdev->config + PCI_CLASS_DEVICE) =3D=3D 0x0806=
;
> > +}
> > +
> > +static AddressSpace *riscv_iommu_find_as(PCIBus *bus, void *opaque, in=
t devfn)
> > +{
> > +    RISCVIOMMUState *s =3D (RISCVIOMMUState *) opaque;
> > +    PCIDevice *pdev =3D pci_find_device(bus, pci_bus_num(bus), devfn);
> > +    AddressSpace *as =3D NULL;
> > +
> > +    if (pdev && pci_is_iommu(pdev)) {
> > +        return s->target_as;
> > +    }
> > +
> > +    /* Find first registered IOMMU device */
> > +    while (s->iommus.le_prev) {
> > +        s =3D *(s->iommus.le_prev);
> > +    }
> > +
> > +    /* Find first matching IOMMU */
> > +    while (s !=3D NULL && as =3D=3D NULL) {
> > +        as =3D riscv_iommu_space(s, PCI_BUILD_BDF(pci_bus_num(bus), de=
vfn));
> > +        s =3D s->iommus.le_next;
> > +    }
> > +
> > +    return as ? as : &address_space_memory;
> > +}
> > +
> > +static const PCIIOMMUOps riscv_iommu_ops =3D {
> > +    .get_address_space =3D riscv_iommu_find_as,
> > +};
> > +
> > +void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
> > +        Error **errp)
> > +{
> > +    if (bus->iommu_ops &&
> > +        bus->iommu_ops->get_address_space =3D=3D riscv_iommu_find_as) =
{
> > +        /* Allow multiple IOMMUs on the same PCIe bus, link known devi=
ces */
> > +        RISCVIOMMUState *last =3D (RISCVIOMMUState *)bus->iommu_opaque=
;
> > +        QLIST_INSERT_AFTER(last, iommu, iommus);
> > +    } else if (!bus->iommu_ops && !bus->iommu_opaque) {
> > +        pci_setup_iommu(bus, &riscv_iommu_ops, iommu);
> > +    } else {
> > +        error_setg(errp, "can't register secondary IOMMU for PCI bus #=
%d",
> > +            pci_bus_num(bus));
> > +    }
> > +}
> > +
> > +static int riscv_iommu_memory_region_index(IOMMUMemoryRegion *iommu_mr=
,
> > +    MemTxAttrs attrs)
> > +{
> > +    return attrs.unspecified ? RISCV_IOMMU_NOPROCID : (int)attrs.pasid=
;
> > +}
> > +
> > +static int riscv_iommu_memory_region_index_len(IOMMUMemoryRegion *iomm=
u_mr)
> > +{
> > +    RISCVIOMMUSpace *as =3D container_of(iommu_mr, RISCVIOMMUSpace, io=
va_mr);
> > +    return 1 << as->iommu->pasid_bits;
> > +}
> > +
> > +static void riscv_iommu_memory_region_init(ObjectClass *klass, void *d=
ata)
> > +{
> > +    IOMMUMemoryRegionClass *imrc =3D IOMMU_MEMORY_REGION_CLASS(klass);
> > +
> > +    imrc->translate =3D riscv_iommu_memory_region_translate;
> > +    imrc->notify_flag_changed =3D riscv_iommu_memory_region_notify;
> > +    imrc->attrs_to_index =3D riscv_iommu_memory_region_index;
> > +    imrc->num_indexes =3D riscv_iommu_memory_region_index_len;
> > +}
> > +
> > +static const TypeInfo riscv_iommu_memory_region_info =3D {
> > +    .parent =3D TYPE_IOMMU_MEMORY_REGION,
> > +    .name =3D TYPE_RISCV_IOMMU_MEMORY_REGION,
> > +    .class_init =3D riscv_iommu_memory_region_init,
> > +};
> > +
> > +static void riscv_iommu_register_mr_types(void)
> > +{
> > +    type_register_static(&riscv_iommu_memory_region_info);
> > +    type_register_static(&riscv_iommu_info);
> > +}
> > +
> > +type_init(riscv_iommu_register_mr_types);
> > diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> > new file mode 100644
> > index 0000000000..05375ea7dc
> > --- /dev/null
> > +++ b/hw/riscv/riscv-iommu.h
> > @@ -0,0 +1,142 @@
> > +/*
> > + * QEMU emulation of an RISC-V IOMMU
> > + *
> > + * Copyright (C) 2022-2023 Rivos Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation; either version 2 of the License.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License a=
long
> > + * with this program; if not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#ifndef HW_RISCV_IOMMU_STATE_H
> > +#define HW_RISCV_IOMMU_STATE_H
> > +
> > +#include "qemu/osdep.h"
> > +#include "qom/object.h"
> > +
> > +#include "hw/riscv/iommu.h"
> > +
> > +struct RISCVIOMMUState {
> > +    /*< private >*/
> > +    DeviceState parent_obj;
> > +
> > +    /*< public >*/
> > +    uint32_t version;     /* Reported interface version number */
> > +    uint32_t pasid_bits;  /* process identifier width */
> Do you mind renaming pasid_bits to something like pid_bits to remain
> consistency?
> > +    uint32_t bus;         /* PCI bus mapping for non-root endpoints */
> > +
> > +    uint64_t cap;         /* IOMMU supported capabilities */
> > +    uint64_t fctl;        /* IOMMU enabled features */
> > +
> > +    bool enable_off;      /* Enable out-of-reset OFF mode (DMA disable=
d) */
> > +    bool enable_msi;      /* Enable MSI remapping */
> > +
> > +    /* IOMMU Internal State */
> > +    uint64_t ddtp;        /* Validated Device Directory Tree Root Poin=
ter */
> > +
> > +    dma_addr_t cq_addr;   /* Command queue base physical address */
> > +    dma_addr_t fq_addr;   /* Fault/event queue base physical address *=
/
> > +    dma_addr_t pq_addr;   /* Page request queue base physical address =
*/
> > +
> > +    uint32_t cq_mask;     /* Command queue index bit mask */
> > +    uint32_t fq_mask;     /* Fault/event queue index bit mask */
> > +    uint32_t pq_mask;     /* Page request queue index bit mask */
> > +
> > +    /* interrupt notifier */
> > +    void (*notify)(RISCVIOMMUState *iommu, unsigned vector);
> > +
> > +    /* IOMMU State Machine */
> > +    QemuThread core_proc; /* Background processing thread */
> > +    QemuMutex core_lock;  /* Global IOMMU lock, used for cache/regs up=
dates */
> > +    QemuCond core_cond;   /* Background processing wake up signal */
> > +    unsigned core_exec;   /* Processing thread execution actions */
> > +
> > +    /* IOMMU target address space */
> > +    AddressSpace *target_as;
> > +    MemoryRegion *target_mr;
> > +
> > +    /* MSI / MRIF access trap */
> > +    AddressSpace trap_as;
> > +    MemoryRegion trap_mr;
> > +
> > +    GHashTable *ctx_cache;          /* Device translation Context Cach=
e */
> > +    QemuMutex ctx_lock;      /* Device translation Cache update lock *=
/
> > +
> > +    /* MMIO Hardware Interface */
> > +    MemoryRegion regs_mr;
> > +    QemuSpin regs_lock;
> > +    uint8_t *regs_rw;  /* register state (user write) */
> > +    uint8_t *regs_wc;  /* write-1-to-clear mask */
> > +    uint8_t *regs_ro;  /* read-only mask */
> > +
> > +    QLIST_ENTRY(RISCVIOMMUState) iommus;
> > +    QLIST_HEAD(, RISCVIOMMUSpace) spaces;
> > +};
> > +
> > +void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
> > +         Error **errp);
> > +
> > +/* private helpers */
> > +
> > +/* Register helper functions */
> > +static inline uint32_t riscv_iommu_reg_mod32(RISCVIOMMUState *s,
> > +    unsigned idx, uint32_t set, uint32_t clr)
> > +{
> > +    uint32_t val;
> > +    qemu_spin_lock(&s->regs_lock);
> > +    val =3D ldl_le_p(s->regs_rw + idx);
> > +    stl_le_p(s->regs_rw + idx, (val & ~clr) | set);
> > +    qemu_spin_unlock(&s->regs_lock);
> > +    return val;
> > +}
> > +
> > +static inline void riscv_iommu_reg_set32(RISCVIOMMUState *s,
> > +    unsigned idx, uint32_t set)
> > +{
> > +    qemu_spin_lock(&s->regs_lock);
> > +    stl_le_p(s->regs_rw + idx, set);
> > +    qemu_spin_unlock(&s->regs_lock);
> > +}
> > +
> > +static inline uint32_t riscv_iommu_reg_get32(RISCVIOMMUState *s,
> > +    unsigned idx)
> > +{
> > +    return ldl_le_p(s->regs_rw + idx);
> > +}
> > +
> > +static inline uint64_t riscv_iommu_reg_mod64(RISCVIOMMUState *s,
> > +    unsigned idx, uint64_t set, uint64_t clr)
> > +{
> > +    uint64_t val;
> > +    qemu_spin_lock(&s->regs_lock);
> > +    val =3D ldq_le_p(s->regs_rw + idx);
> > +    stq_le_p(s->regs_rw + idx, (val & ~clr) | set);
> > +    qemu_spin_unlock(&s->regs_lock);
> > +    return val;
> > +}
> > +
> > +static inline void riscv_iommu_reg_set64(RISCVIOMMUState *s,
> > +    unsigned idx, uint64_t set)
> > +{
> > +    qemu_spin_lock(&s->regs_lock);
> > +    stq_le_p(s->regs_rw + idx, set);
> > +    qemu_spin_unlock(&s->regs_lock);
> > +}
> > +
> > +static inline uint64_t riscv_iommu_reg_get64(RISCVIOMMUState *s,
> > +    unsigned idx)
> > +{
> > +    return ldq_le_p(s->regs_rw + idx);
> > +}
> > +
> > +
> > +
> > +#endif
> > diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
> > new file mode 100644
> > index 0000000000..42a97caffa
> > --- /dev/null
> > +++ b/hw/riscv/trace-events
> > @@ -0,0 +1,11 @@
> > +# See documentation at docs/devel/tracing.rst
> > +
> > +# riscv-iommu.c
> > +riscv_iommu_new(const char *id, unsigned b, unsigned d, unsigned f) "%=
s: device attached %04x:%02x.%d"
> > +riscv_iommu_flt(const char *id, unsigned b, unsigned d, unsigned f, ui=
nt64_t reason, uint64_t iova) "%s: fault %04x:%02x.%u reason: 0x%"PRIx64" i=
ova: 0x%"PRIx64
> > +riscv_iommu_pri(const char *id, unsigned b, unsigned d, unsigned f, ui=
nt64_t iova) "%s: page request %04x:%02x.%u iova: 0x%"PRIx64
> > +riscv_iommu_dma(const char *id, unsigned b, unsigned d, unsigned f, un=
signed pasid, const char *dir, uint64_t iova, uint64_t phys) "%s: translate=
 %04x:%02x.%u #%u %s 0x%"PRIx64" -> 0x%"PRIx64
> > +riscv_iommu_msi(const char *id, unsigned b, unsigned d, unsigned f, ui=
nt64_t iova, uint64_t phys) "%s: translate %04x:%02x.%u MSI 0x%"PRIx64" -> =
0x%"PRIx64
> > +riscv_iommu_cmd(const char *id, uint64_t l, uint64_t u) "%s: command 0=
x%"PRIx64" 0x%"PRIx64
> > +riscv_iommu_notifier_add(const char *id) "%s: dev-iotlb notifier added=
"
> > +riscv_iommu_notifier_del(const char *id) "%s: dev-iotlb notifier remov=
ed"
> > diff --git a/hw/riscv/trace.h b/hw/riscv/trace.h
> > new file mode 100644
> > index 0000000000..8c0e3ca1f3
> > --- /dev/null
> > +++ b/hw/riscv/trace.h
> > @@ -0,0 +1 @@
> > +#include "trace/trace-hw_riscv.h"
> > diff --git a/include/hw/riscv/iommu.h b/include/hw/riscv/iommu.h
> > new file mode 100644
> > index 0000000000..070ee69973
> > --- /dev/null
> > +++ b/include/hw/riscv/iommu.h
> > @@ -0,0 +1,36 @@
> > +/*
> > + * QEMU emulation of an RISC-V IOMMU
> > + *
> > + * Copyright (C) 2022-2023 Rivos Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation; either version 2 of the License.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License a=
long
> > + * with this program; if not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#ifndef HW_RISCV_IOMMU_H
> > +#define HW_RISCV_IOMMU_H
> > +
> > +#include "qemu/osdep.h"
> > +#include "qom/object.h"
> > +
> > +#define TYPE_RISCV_IOMMU "riscv-iommu"
> > +OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUState, RISCV_IOMMU)
> > +typedef struct RISCVIOMMUState RISCVIOMMUState;
> > +
> > +#define TYPE_RISCV_IOMMU_MEMORY_REGION "riscv-iommu-mr"
> > +typedef struct RISCVIOMMUSpace RISCVIOMMUSpace;
> > +
> > +#define TYPE_RISCV_IOMMU_PCI "riscv-iommu-pci"
> > +OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStatePci, RISCV_IOMMU_PCI)
> > +typedef struct RISCVIOMMUStatePci RISCVIOMMUStatePci;
> > +
> > +#endif
> > diff --git a/meson.build b/meson.build
> > index 97e00d6f59..b8f717ba42 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -3353,6 +3353,7 @@ if have_system
> >       'hw/pci-host',
> >       'hw/ppc',
> >       'hw/rtc',
> > +    'hw/riscv',
> >       'hw/s390x',
> >       'hw/scsi',
> >       'hw/sd',

