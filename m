Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57524C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 16:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s95hr-0002rt-AY; Mon, 20 May 2024 12:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s95hp-0002rX-0I
 for qemu-devel@nongnu.org; Mon, 20 May 2024 12:17:45 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s95hi-0002mv-O0
 for qemu-devel@nongnu.org; Mon, 20 May 2024 12:17:44 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1ec486198b6so73377135ad.1
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 09:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716221855; x=1716826655; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I2kJ0ykvtYy7EMn0w9S50Efms1bmaSxhKd6iYKNb5bg=;
 b=fyMov4n3AQp+ZJBGrFFXA54m7yr+vbPzKbvvdPx4txZQh+CYJ8wlABhdXbk+u5w4pd
 qx2dQl45XzOrGja1IxgwafAMo1iNdMmV+a6Yvq1jGTaD0/gVQsatbPNNpFZp1xl7cqkA
 au3uXVDtE2imr7lUT+fHHnasN4fhhKYgF8ndTDFoeiHgJ5SIjidwYWY35wQiPP/+mTmv
 iBmlCFPl/EvtYF5CKTYo7IIqxMZQMG8esAftZtcyh59v+M176YaN8mV040OYTjji7Lsw
 VuXBXfjURUB/2YerTGyWQTs8J5Pxp9haEVyZCPfgrCbO9DiXCGNVSOs4uTcvykyx4L+C
 qYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716221855; x=1716826655;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I2kJ0ykvtYy7EMn0w9S50Efms1bmaSxhKd6iYKNb5bg=;
 b=VKUorTNj4ayHZk1Q1cjmTOHqFWw6ZWP22f1Qc/GGY683UEK7tUEzkonqqYzuTANWfM
 sIoTkgHOzptJsHRkItNg3Mkw8nu36krQq94dt71x/yWoOnSZjaAimPToV78rQoKkqVgm
 XgJlDzPbEjKxSw9uD4vkzyPHNKplfGSBf4tn2rOCQzwdK0r9NoapeiSgjLius8CMBNxU
 StEtuBIt/5yE6nkpjWO5x/VBwZlqSR2jGeVC45HttEL99Z8goFXlOraktccpLr+jiCEo
 Ns67xAwq9I1KsAV+yLdPT9EGPox+2J1fjE20uAFnhJ44DT5kj0SfkpQXJQTdlbPKiCFA
 HgHQ==
X-Gm-Message-State: AOJu0Ywbt0/JDqgCIuoR3dVxxDlYFVr9UVFXBdWS1moUJgOIsbSa2V+k
 vKJafiojnM47YyJjr1AXr5OmWJejPIPJYBMJZr4w3tBCkxFkdWTztGGaViwWy9w=
X-Google-Smtp-Source: AGHT+IFNaelhRs1NSxb+5TlXRLOaGV1OPMiDJeRwySFKX61DW9Q7UUrM0GkDOEw8S/912x7/meA8Ng==
X-Received: by 2002:a05:6a00:4fcf:b0:6ed:de70:5ef8 with SMTP id
 d2e1a72fcca58-6f4e029898fmr33145191b3a.6.1716221855127; 
 Mon, 20 May 2024 09:17:35 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.42.57])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f668d1c3aasm11570101b3a.22.2024.05.20.09.17.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 May 2024 09:17:34 -0700 (PDT)
Message-ID: <4de35d60-d605-47e6-87fe-0ed7c1793069@ventanamicro.com>
Date: Mon, 20 May 2024 13:17:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] hw/riscv: add RISC-V IOMMU base emulation
To: Frank Chang <frank.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, ajones@ventanamicro.com, tjeznach@rivosinc.com,
 Sebastien Boeuf <seb@rivosinc.com>, Sunil V L <sunilvl@ventanamicro.com>
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
 <20240307160319.675044-4-dbarboza@ventanamicro.com>
 <CANzO1D35eYan8axod37tAg88r=qg4Jt0CVTvO+0AiwRLbbV64A@mail.gmail.com>
 <09dc2e36-741d-44de-aac8-4ed2495eaeb1@ventanamicro.com>
 <abd1e74a-8d74-4ef9-b917-ce1a3c8e6af9@ventanamicro.com>
 <CAE_xrPhNhxWGT1_MvUJ9Jecz5obRc5tpdk9u_BW57uqC_G1uBA@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAE_xrPhNhxWGT1_MvUJ9Jecz5obRc5tpdk9u_BW57uqC_G1uBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62c.google.com
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

Hi Frank,

On 5/16/24 04:13, Frank Chang wrote:
> On Mon, May 13, 2024 at 8:37 PM Daniel Henrique Barboza <dbarboza@ventanamicro.com <mailto:dbarboza@ventanamicro.com>> wrote:
> 
>     Hi Frank,
> 
> 
>     On 5/8/24 08:15, Daniel Henrique Barboza wrote:
>      > Hi Frank,
>      >
>      > I'll reply with that I've done so far. Still missing some stuff:
>      >
>      > On 5/2/24 08:37, Frank Chang wrote:
>      >> Hi Daniel,
>      >>
>      >> Daniel Henrique Barboza <dbarboza@ventanamicro.com <mailto:dbarboza@ventanamicro.com>> 於 2024年3月8日 週五 上午12:04寫道：
>      >>>
>      >>> From: Tomasz Jeznach <tjeznach@rivosinc.com <mailto:tjeznach@rivosinc.com>>
>      >>>
>      >>> The RISC-V IOMMU specification is now ratified as-per the RISC-V
>      >>> international process. The latest frozen specifcation can be found
>      >>> at:
>      >>>
>      >>> https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv-iommu.pdf <https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv-iommu.pdf>
>      >>>
>      >>> Add the foundation of the device emulation for RISC-V IOMMU, which
>      >>> includes an IOMMU that has no capabilities but MSI interrupt support and
>      >>> fault queue interfaces. We'll add add more features incrementally in the
>      >>> next patches.
>      >>>
>      >>> Co-developed-by: Sebastien Boeuf <seb@rivosinc.com <mailto:seb@rivosinc.com>>
>      >>> Signed-off-by: Sebastien Boeuf <seb@rivosinc.com <mailto:seb@rivosinc.com>>
>      >>> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com <mailto:tjeznach@rivosinc.com>>
>      >>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com <mailto:dbarboza@ventanamicro.com>>
>      >>> ---
>      >>>   hw/riscv/Kconfig         |    4 +
> 
>     (...)
> 
>      >>> +
>      >>> +    s->iommus.le_next = NULL;
>      >>> +    s->iommus.le_prev = NULL;
>      >>> +    QLIST_INIT(&s->spaces);
>      >>> +    qemu_cond_init(&s->core_cond);
>      >>> +    qemu_mutex_init(&s->core_lock);
>      >>> +    qemu_spin_init(&s->regs_lock);
>      >>> +    qemu_thread_create(&s->core_proc, "riscv-iommu-core",
>      >>> +        riscv_iommu_core_proc, s, QEMU_THREAD_JOINABLE);
>      >>
>      >> In our experience, using QEMU thread increases the latency of command
>      >> queue processing,
>      >> which leads to the potential IOMMU fence timeout in the Linux driver
>      >> when using IOMMU with KVM,
>      >> e.g. booting the guest Linux.
>      >>
>      >> Is it possible to remove the thread from the IOMMU just like ARM, AMD,
>      >> and Intel IOMMU models?
>      >
>      > Interesting. We've been using this emulation internally in Ventana, with
>      > KVM and VFIO, and didn't experience this issue. Drew is on CC and can talk
>      > more about it.
>      >
>      > That said, I don't mind this change, assuming it's feasible to make it for this
>      > first version.  I'll need to check it how other IOMMUs are doing it.
> 
> 
>     I removed the threading and it seems to be working fine without it. I'll commit this
>     change for v3.
> 
>      >
>      >
>      >
>      >>
>      >>> +}
>      >>> +
>      >
>      > (...)
>      >
>      >>> +
>      >>> +static AddressSpace *riscv_iommu_find_as(PCIBus *bus, void *opaque, int devfn)
>      >>> +{
>      >>> +    RISCVIOMMUState *s = (RISCVIOMMUState *) opaque;
>      >>> +    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
>      >>> +    AddressSpace *as = NULL;
>      >>> +
>      >>> +    if (pdev && pci_is_iommu(pdev)) {
>      >>> +        return s->target_as;
>      >>> +    }
>      >>> +
>      >>> +    /* Find first registered IOMMU device */
>      >>> +    while (s->iommus.le_prev) {
>      >>> +        s = *(s->iommus.le_prev);
>      >>> +    }
>      >>> +
>      >>> +    /* Find first matching IOMMU */
>      >>> +    while (s != NULL && as == NULL) {
>      >>> +        as = riscv_iommu_space(s, PCI_BUILD_BDF(pci_bus_num(bus), devfn));
>      >>
>      >> For pci_bus_num(),
>      >> riscv_iommu_find_as() can be called at the very early stage
>      >> where software has no chance to enumerate the bus numbers.
> 
>     I investigated and this doesn't seem to be a problem. This function is called at the
>     last step of the realize() steps of both riscv_iommu_pci_realize() and
>     riscv_iommu_sys_realize(), and by that time the pci_bus_num() is already assigned.
>     Other iommus use pci_bus_num() into their own get_address_space() callbacks like
>     this too.
> 
> 
> Hi Daniel,
> 
> IIUC, pci_bus_num() by default is assigned to pcibus_num():
> 
> static int pcibus_num(PCIBus *bus)
> {
>      if (pci_bus_is_root(bus)) {
>          return 0; /* pci host bridge */
>      }
>      return bus->parent_dev->config[PCI_SECONDARY_BUS];
> }
> 
> If the bus is not the root bus, it tries to read the bus' parent device's
> secondary bus number (PCI_SECONDARY_BUS) field in the PCI configuration space.
> This field should be programmable by the SW during PCIe enumeration.
> But I don't think SW has a chance to be executed before riscv_iommu_sys_realize() is called,
> since it's pretty early before CPU's execution unless RISC-V IOMMU is hot-plugged.
> Even if RISC-V IOMMU is hot-plugged, I think riscv_iommu_sys_realize() is still called
> before SW aware of the existence of IOMMU on the PCI topology tree.
> 
> Do you think this matches your observation?

It does. You have a good point on how the pcibus_num() can vary if SW wants to
change the PCI_SECONDARY_BUS and the IOMMU isn't in a root bus. Note that this
will not happen with the existing riscv-iommu-pci device as it is now, since it
has code to prevent the device to be attached to non-pci root buses, but there's
no restrictions in the riscv-iommu-sys device.

And speaking on riscv-iommu-bus, the current device we have in this series is too
bare bones, without an actual use case for it (e.g. code to add it in the 'virt'
machine), but it's getting in the way nevertheless.

I'll remove the riscv-iommu-sys device from v3 and re-introduce it in a later
revision or as a follow up series. Sunil has a handful of patches that add the
riscv-iommu-sys device in the 'virt' machine and the proper ACPI support for it [1],
and I intend to use them as a base. We'll then need some minor adjustments in the
existing code to make it fully functional like we're doing with riscv-iommu-pci.


Thanks,

Daniel


[1] https://github.com/vlsunil/qemu/commits/acpi_rimt_poc_v1/
> 
> Regards,
> Frank Chang
> 
> 
> 
>     Thanks,
> 
> 
>     Daniel
> 
> 
>      >
>      > I'll see how other IOMMUs are handling their iommu_find_as()
>      >
>      >
>      > Thanks,
>      >
>      >
>      > Daniel
>      >
>      >
>      >>
>      >>
>      >>
>      >>
>      >>> +        s = s->iommus.le_next;
>      >>> +    }
>      >>> +
>      >>> +    return as ? as : &address_space_memory;
>      >>> +}
>      >>> +
>      >>> +static const PCIIOMMUOps riscv_iommu_ops = {
>      >>> +    .get_address_space = riscv_iommu_find_as,
>      >>> +};
>      >>> +
>      >>> +void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
>      >>> +        Error **errp)
>      >>> +{
>      >>> +    if (bus->iommu_ops &&
>      >>> +        bus->iommu_ops->get_address_space == riscv_iommu_find_as) {
>      >>> +        /* Allow multiple IOMMUs on the same PCIe bus, link known devices */
>      >>> +        RISCVIOMMUState *last = (RISCVIOMMUState *)bus->iommu_opaque;
>      >>> +        QLIST_INSERT_AFTER(last, iommu, iommus);
>      >>> +    } else if (bus->iommu_ops == NULL) {
>      >>> +        pci_setup_iommu(bus, &riscv_iommu_ops, iommu);
>      >>> +    } else {
>      >>> +        error_setg(errp, "can't register secondary IOMMU for PCI bus #%d",
>      >>> +            pci_bus_num(bus));
>      >>> +    }
>      >>> +}
>      >>> +
>      >>> +static int riscv_iommu_memory_region_index(IOMMUMemoryRegion *iommu_mr,
>      >>> +    MemTxAttrs attrs)
>      >>> +{
>      >>> +    return attrs.unspecified ? RISCV_IOMMU_NOPASID : (int)attrs.pasid;
>      >>> +}
>      >>> +
>      >>> +static int riscv_iommu_memory_region_index_len(IOMMUMemoryRegion *iommu_mr)
>      >>> +{
>      >>> +    RISCVIOMMUSpace *as = container_of(iommu_mr, RISCVIOMMUSpace, iova_mr);
>      >>> +    return 1 << as->iommu->pasid_bits;
>      >>> +}
>      >>> +
>      >>> +static void riscv_iommu_memory_region_init(ObjectClass *klass, void *data)
>      >>> +{
>      >>> +    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
>      >>> +
>      >>> +    imrc->translate = riscv_iommu_memory_region_translate;
>      >>> +    imrc->notify_flag_changed = riscv_iommu_memory_region_notify;
>      >>> +    imrc->attrs_to_index = riscv_iommu_memory_region_index;
>      >>> +    imrc->num_indexes = riscv_iommu_memory_region_index_len;
>      >>> +}
>      >>> +
>      >>> +static const TypeInfo riscv_iommu_memory_region_info = {
>      >>> +    .parent = TYPE_IOMMU_MEMORY_REGION,
>      >>> +    .name = TYPE_RISCV_IOMMU_MEMORY_REGION,
>      >>> +    .class_init = riscv_iommu_memory_region_init,
>      >>> +};
>      >>> +
>      >>> +static void riscv_iommu_register_mr_types(void)
>      >>> +{
>      >>> +    type_register_static(&riscv_iommu_memory_region_info);
>      >>> +    type_register_static(&riscv_iommu_info);
>      >>> +}
>      >>> +
>      >>> +type_init(riscv_iommu_register_mr_types);
>      >>> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
>      >>> new file mode 100644
>      >>> index 0000000000..6f740de690
>      >>> --- /dev/null
>      >>> +++ b/hw/riscv/riscv-iommu.h
>      >>> @@ -0,0 +1,141 @@
>      >>> +/*
>      >>> + * QEMU emulation of an RISC-V IOMMU (Ziommu)
>      >>> + *
>      >>> + * Copyright (C) 2022-2023 Rivos Inc.
>      >>> + *
>      >>> + * This program is free software; you can redistribute it and/or modify
>      >>> + * it under the terms of the GNU General Public License as published by
>      >>> + * the Free Software Foundation; either version 2 of the License.
>      >>> + *
>      >>> + * This program is distributed in the hope that it will be useful,
>      >>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>      >>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>      >>> + * GNU General Public License for more details.
>      >>> + *
>      >>> + * You should have received a copy of the GNU General Public License along
>      >>> + * with this program; if not, see <http://www.gnu.org/licenses/ <http://www.gnu.org/licenses/>>.
>      >>> + */
>      >>> +
>      >>> +#ifndef HW_RISCV_IOMMU_STATE_H
>      >>> +#define HW_RISCV_IOMMU_STATE_H
>      >>> +
>      >>> +#include "qemu/osdep.h"
>      >>> +#include "qom/object.h"
>      >>> +
>      >>> +#include "hw/riscv/iommu.h"
>      >>> +
>      >>> +struct RISCVIOMMUState {
>      >>> +    /*< private >*/
>      >>> +    DeviceState parent_obj;
>      >>> +
>      >>> +    /*< public >*/
>      >>> +    uint32_t version;     /* Reported interface version number */
>      >>> +    uint32_t pasid_bits;  /* process identifier width */
>      >>> +    uint32_t bus;         /* PCI bus mapping for non-root endpoints */
>      >>> +
>      >>> +    uint64_t cap;         /* IOMMU supported capabilities */
>      >>> +    uint64_t fctl;        /* IOMMU enabled features */
>      >>> +
>      >>> +    bool enable_off;      /* Enable out-of-reset OFF mode (DMA disabled) */
>      >>> +    bool enable_msi;      /* Enable MSI remapping */
>      >>> +
>      >>> +    /* IOMMU Internal State */
>      >>> +    uint64_t ddtp;        /* Validated Device Directory Tree Root Pointer */
>      >>> +
>      >>> +    dma_addr_t cq_addr;   /* Command queue base physical address */
>      >>> +    dma_addr_t fq_addr;   /* Fault/event queue base physical address */
>      >>> +    dma_addr_t pq_addr;   /* Page request queue base physical address */
>      >>> +
>      >>> +    uint32_t cq_mask;     /* Command queue index bit mask */
>      >>> +    uint32_t fq_mask;     /* Fault/event queue index bit mask */
>      >>> +    uint32_t pq_mask;     /* Page request queue index bit mask */
>      >>> +
>      >>> +    /* interrupt notifier */
>      >>> +    void (*notify)(RISCVIOMMUState *iommu, unsigned vector);
>      >>> +
>      >>> +    /* IOMMU State Machine */
>      >>> +    QemuThread core_proc; /* Background processing thread */
>      >>> +    QemuMutex core_lock;  /* Global IOMMU lock, used for cache/regs updates */
>      >>> +    QemuCond core_cond;   /* Background processing wake up signal */
>      >>> +    unsigned core_exec;   /* Processing thread execution actions */
>      >>> +
>      >>> +    /* IOMMU target address space */
>      >>> +    AddressSpace *target_as;
>      >>> +    MemoryRegion *target_mr;
>      >>> +
>      >>> +    /* MSI / MRIF access trap */
>      >>> +    AddressSpace trap_as;
>      >>> +    MemoryRegion trap_mr;
>      >>> +
>      >>> +    GHashTable *ctx_cache;          /* Device translation Context Cache */
>      >>> +
>      >>> +    /* MMIO Hardware Interface */
>      >>> +    MemoryRegion regs_mr;
>      >>> +    QemuSpin regs_lock;
>      >>> +    uint8_t *regs_rw;  /* register state (user write) */
>      >>> +    uint8_t *regs_wc;  /* write-1-to-clear mask */
>      >>> +    uint8_t *regs_ro;  /* read-only mask */
>      >>> +
>      >>> +    QLIST_ENTRY(RISCVIOMMUState) iommus;
>      >>> +    QLIST_HEAD(, RISCVIOMMUSpace) spaces;
>      >>> +};
>      >>> +
>      >>> +void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
>      >>> +         Error **errp);
>      >>> +
>      >>> +/* private helpers */
>      >>> +
>      >>> +/* Register helper functions */
>      >>> +static inline uint32_t riscv_iommu_reg_mod32(RISCVIOMMUState *s,
>      >>> +    unsigned idx, uint32_t set, uint32_t clr)
>      >>> +{
>      >>> +    uint32_t val;
>      >>> +    qemu_spin_lock(&s->regs_lock);
>      >>> +    val = ldl_le_p(s->regs_rw + idx);
>      >>> +    stl_le_p(s->regs_rw + idx, (val & ~clr) | set);
>      >>> +    qemu_spin_unlock(&s->regs_lock);
>      >>> +    return val;
>      >>> +}
>      >>> +
>      >>> +static inline void riscv_iommu_reg_set32(RISCVIOMMUState *s,
>      >>> +    unsigned idx, uint32_t set)
>      >>> +{
>      >>> +    qemu_spin_lock(&s->regs_lock);
>      >>> +    stl_le_p(s->regs_rw + idx, set);
>      >>> +    qemu_spin_unlock(&s->regs_lock);
>      >>> +}
>      >>> +
>      >>> +static inline uint32_t riscv_iommu_reg_get32(RISCVIOMMUState *s,
>      >>> +    unsigned idx)
>      >>> +{
>      >>> +    return ldl_le_p(s->regs_rw + idx);
>      >>> +}
>      >>> +
>      >>> +static inline uint64_t riscv_iommu_reg_mod64(RISCVIOMMUState *s,
>      >>> +    unsigned idx, uint64_t set, uint64_t clr)
>      >>> +{
>      >>> +    uint64_t val;
>      >>> +    qemu_spin_lock(&s->regs_lock);
>      >>> +    val = ldq_le_p(s->regs_rw + idx);
>      >>> +    stq_le_p(s->regs_rw + idx, (val & ~clr) | set);
>      >>> +    qemu_spin_unlock(&s->regs_lock);
>      >>> +    return val;
>      >>> +}
>      >>> +
>      >>> +static inline void riscv_iommu_reg_set64(RISCVIOMMUState *s,
>      >>> +    unsigned idx, uint64_t set)
>      >>> +{
>      >>> +    qemu_spin_lock(&s->regs_lock);
>      >>> +    stq_le_p(s->regs_rw + idx, set);
>      >>> +    qemu_spin_unlock(&s->regs_lock);
>      >>> +}
>      >>> +
>      >>> +static inline uint64_t riscv_iommu_reg_get64(RISCVIOMMUState *s,
>      >>> +    unsigned idx)
>      >>> +{
>      >>> +    return ldq_le_p(s->regs_rw + idx);
>      >>> +}
>      >>> +
>      >>> +
>      >>> +
>      >>> +#endif
>      >>> diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
>      >>> new file mode 100644
>      >>> index 0000000000..42a97caffa
>      >>> --- /dev/null
>      >>> +++ b/hw/riscv/trace-events
>      >>> @@ -0,0 +1,11 @@
>      >>> +# See documentation at docs/devel/tracing.rst
>      >>> +
>      >>> +# riscv-iommu.c
>      >>> +riscv_iommu_new(const char *id, unsigned b, unsigned d, unsigned f) "%s: device attached %04x:%02x.%d"
>      >>> +riscv_iommu_flt(const char *id, unsigned b, unsigned d, unsigned f, uint64_t reason, uint64_t iova) "%s: fault %04x:%02x.%u reason: 0x%"PRIx64" iova: 0x%"PRIx64
>      >>> +riscv_iommu_pri(const char *id, unsigned b, unsigned d, unsigned f, uint64_t iova) "%s: page request %04x:%02x.%u iova: 0x%"PRIx64
>      >>> +riscv_iommu_dma(const char *id, unsigned b, unsigned d, unsigned f, unsigned pasid, const char *dir, uint64_t iova, uint64_t phys) "%s: translate %04x:%02x.%u #%u %s 0x%"PRIx64" -> 0x%"PRIx64
>      >>> +riscv_iommu_msi(const char *id, unsigned b, unsigned d, unsigned f, uint64_t iova, uint64_t phys) "%s: translate %04x:%02x.%u MSI 0x%"PRIx64" -> 0x%"PRIx64
>      >>> +riscv_iommu_cmd(const char *id, uint64_t l, uint64_t u) "%s: command 0x%"PRIx64" 0x%"PRIx64
>      >>> +riscv_iommu_notifier_add(const char *id) "%s: dev-iotlb notifier added"
>      >>> +riscv_iommu_notifier_del(const char *id) "%s: dev-iotlb notifier removed"
>      >>> diff --git a/hw/riscv/trace.h b/hw/riscv/trace.h
>      >>> new file mode 100644
>      >>> index 0000000000..b88504b750
>      >>> --- /dev/null
>      >>> +++ b/hw/riscv/trace.h
>      >>> @@ -0,0 +1,2 @@
>      >>> +#include "trace/trace-hw_riscv.h"
>      >>> +
>      >>> diff --git a/include/hw/riscv/iommu.h b/include/hw/riscv/iommu.h
>      >>> new file mode 100644
>      >>> index 0000000000..403b365893
>      >>> --- /dev/null
>      >>> +++ b/include/hw/riscv/iommu.h
>      >>> @@ -0,0 +1,36 @@
>      >>> +/*
>      >>> + * QEMU emulation of an RISC-V IOMMU (Ziommu)
>      >>> + *
>      >>> + * Copyright (C) 2022-2023 Rivos Inc.
>      >>> + *
>      >>> + * This program is free software; you can redistribute it and/or modify
>      >>> + * it under the terms of the GNU General Public License as published by
>      >>> + * the Free Software Foundation; either version 2 of the License.
>      >>> + *
>      >>> + * This program is distributed in the hope that it will be useful,
>      >>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>      >>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>      >>> + * GNU General Public License for more details.
>      >>> + *
>      >>> + * You should have received a copy of the GNU General Public License along
>      >>> + * with this program; if not, see <http://www.gnu.org/licenses/ <http://www.gnu.org/licenses/>>.
>      >>> + */
>      >>> +
>      >>> +#ifndef HW_RISCV_IOMMU_H
>      >>> +#define HW_RISCV_IOMMU_H
>      >>> +
>      >>> +#include "qemu/osdep.h"
>      >>> +#include "qom/object.h"
>      >>> +
>      >>> +#define TYPE_RISCV_IOMMU "riscv-iommu"
>      >>> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUState, RISCV_IOMMU)
>      >>> +typedef struct RISCVIOMMUState RISCVIOMMUState;
>      >>> +
>      >>> +#define TYPE_RISCV_IOMMU_MEMORY_REGION "riscv-iommu-mr"
>      >>> +typedef struct RISCVIOMMUSpace RISCVIOMMUSpace;
>      >>> +
>      >>> +#define TYPE_RISCV_IOMMU_PCI "riscv-iommu-pci"
>      >>> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStatePci, RISCV_IOMMU_PCI)
>      >>> +typedef struct RISCVIOMMUStatePci RISCVIOMMUStatePci;
>      >>> +
>      >>> +#endif
>      >>> diff --git a/meson.build b/meson.build
>      >>> index c59ca496f2..75e56f3282 100644
>      >>> --- a/meson.build
>      >>> +++ b/meson.build
>      >>> @@ -3361,6 +3361,7 @@ if have_system
>      >>>       'hw/rdma',
>      >>>       'hw/rdma/vmw',
>      >>>       'hw/rtc',
>      >>> +    'hw/riscv',
>      >>>       'hw/s390x',
>      >>>       'hw/scsi',
>      >>>       'hw/sd',
>      >>> --
>      >>> 2.43.2
>      >>>
>      >>>
> 

