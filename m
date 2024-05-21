Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED26C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 10:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9N6o-0006mC-Nd; Tue, 21 May 2024 06:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s9N6o-0006lt-01
 for qemu-devel@nongnu.org; Tue, 21 May 2024 06:52:42 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s9N6j-0007VV-F4
 for qemu-devel@nongnu.org; Tue, 21 May 2024 06:52:41 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56e1bbdb362so6723055a12.1
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 03:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1716288754; x=1716893554; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hXn0pKAoJr6AbY03oJK9cmWl2e+1cKAehKSsZgDfkGE=;
 b=Cnv5OEaazLzef6XZHYrt265Nr1NSXbQ6bgi9cWeETeNvlB/Z1HlbcjE7IWS39Gj7Hi
 USwwSqn4/9HhtWKJh8NeEy6Es+fiajNRFsq5Cw7l49gXblmxLKtBPvaiQhgbjJSEUNUX
 5nf5QejZ4pPvvzCRjNRan1O3Qt4RayuPdFRtyd5t5NXn+ON6ovCSEruXyEVXTH6pM8xd
 KQR7fAD60Ix+VQZmOgG1M7j5Ix/WYl2CSgVR7a8skfigZmnwEaluNHO6sUM2vgfdoueS
 9F2zZLWg7owk6N+9MoRLJ5pCWBRLfAUU10BHQM4qIEGmr4nl0BwPZaC0QWPyjh3vIc/4
 9T5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716288754; x=1716893554;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hXn0pKAoJr6AbY03oJK9cmWl2e+1cKAehKSsZgDfkGE=;
 b=eFSLOWT8daAf/bVrQRtKESxmxZOPwcNRIsRyLpNgQahqPIlQxsF6lTT/U05TFHCZCJ
 kH61JHfLdXxCleR7P6xY9EaQ4OnFLdH0ivwmZQDu9QoGkdFlRpDXI1UXkwRfgItG/Fnd
 ZwGcjFMT4hU4LYJ7T8a2diFZRXQybykGnbttK0rz62xB9VX5SKmypqeiPzhceI2NfiYN
 ZkDHUiWUVGJ/i/K2be4jhsLfQj4aVRKfgiZcIFRocGbOEqavGLTTGZKxVScW3ATb/Ob6
 AWp74/1oJNn/x98kldV/0RRYLhNGomzjqGuItDkGnkfLTQJdsCAkIFkXRcIE1DGZXu0F
 cVEQ==
X-Gm-Message-State: AOJu0YyTpjlnR0MbAU9hgP+kACEuAmQpgRX3RLd6GorVlBiE91jS7WPn
 hGQV9xM0oGaoOQULRj7JqoEBRlqcQ9m1PCQuMmxpA3yvTeZogR9+1VnqVL9hVQQTF92Du4drd5r
 4KYXn8qlq/P4UGys03v+ianXMb+uU2kCaGDvkUA==
X-Google-Smtp-Source: AGHT+IE7B0W0CxdKc3JB4cEe2rq1Q9342VBmgYAMUJmKHbIVUIoNAABncBDga3ZoD2IgLjUCgLHz/4Rx+IcM4CaKwk4=
X-Received: by 2002:a50:aade:0:b0:572:9b21:e0c9 with SMTP id
 4fb4d7f45d1cf-5734d5cf9damr33662646a12.14.1716288754049; Tue, 21 May 2024
 03:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
 <20240307160319.675044-4-dbarboza@ventanamicro.com>
 <CANzO1D35eYan8axod37tAg88r=qg4Jt0CVTvO+0AiwRLbbV64A@mail.gmail.com>
 <09dc2e36-741d-44de-aac8-4ed2495eaeb1@ventanamicro.com>
 <abd1e74a-8d74-4ef9-b917-ce1a3c8e6af9@ventanamicro.com>
 <CAE_xrPhNhxWGT1_MvUJ9Jecz5obRc5tpdk9u_BW57uqC_G1uBA@mail.gmail.com>
 <4de35d60-d605-47e6-87fe-0ed7c1793069@ventanamicro.com>
In-Reply-To: <4de35d60-d605-47e6-87fe-0ed7c1793069@ventanamicro.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Tue, 21 May 2024 18:52:22 +0800
Message-ID: <CAE_xrPgME8jCaEuW-yDK-3kzLu66MCMfppt3dpRO5jQOGH9heg@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] hw/riscv: add RISC-V IOMMU base emulation
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com, tjeznach@rivosinc.com, 
 Sebastien Boeuf <seb@rivosinc.com>, Sunil V L <sunilvl@ventanamicro.com>
Content-Type: multipart/alternative; boundary="0000000000008495510618f49d4d"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=frank.chang@sifive.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--0000000000008495510618f49d4d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Tue, May 21, 2024 at 12:17=E2=80=AFAM Daniel Henrique Barboza <
dbarboza@ventanamicro.com> wrote:

> Hi Frank,
>
> On 5/16/24 04:13, Frank Chang wrote:
> > On Mon, May 13, 2024 at 8:37=E2=80=AFPM Daniel Henrique Barboza <
> dbarboza@ventanamicro.com <mailto:dbarboza@ventanamicro.com>> wrote:
> >
> >     Hi Frank,
> >
> >
> >     On 5/8/24 08:15, Daniel Henrique Barboza wrote:
> >      > Hi Frank,
> >      >
> >      > I'll reply with that I've done so far. Still missing some stuff:
> >      >
> >      > On 5/2/24 08:37, Frank Chang wrote:
> >      >> Hi Daniel,
> >      >>
> >      >> Daniel Henrique Barboza <dbarboza@ventanamicro.com <mailto:
> dbarboza@ventanamicro.com>> =E6=96=BC 2024=E5=B9=B43=E6=9C=888=E6=97=A5 =
=E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8812:04=E5=AF=AB=E9=81=93=EF=BC=9A
> >      >>>
> >      >>> From: Tomasz Jeznach <tjeznach@rivosinc.com <mailto:
> tjeznach@rivosinc.com>>
> >      >>>
> >      >>> The RISC-V IOMMU specification is now ratified as-per the RISC=
-V
> >      >>> international process. The latest frozen specifcation can be
> found
> >      >>> at:
> >      >>>
> >      >>>
> https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv=
-iommu.pdf
> <
> https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv=
-iommu.pdf
> >
> >      >>>
> >      >>> Add the foundation of the device emulation for RISC-V IOMMU,
> which
> >      >>> includes an IOMMU that has no capabilities but MSI interrupt
> support and
> >      >>> fault queue interfaces. We'll add add more features
> incrementally in the
> >      >>> next patches.
> >      >>>
> >      >>> Co-developed-by: Sebastien Boeuf <seb@rivosinc.com <mailto:
> seb@rivosinc.com>>
> >      >>> Signed-off-by: Sebastien Boeuf <seb@rivosinc.com <mailto:
> seb@rivosinc.com>>
> >      >>> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com <mailto:
> tjeznach@rivosinc.com>>
> >      >>> Signed-off-by: Daniel Henrique Barboza <
> dbarboza@ventanamicro.com <mailto:dbarboza@ventanamicro.com>>
> >      >>> ---
> >      >>>   hw/riscv/Kconfig         |    4 +
> >
> >     (...)
> >
> >      >>> +
> >      >>> +    s->iommus.le_next =3D NULL;
> >      >>> +    s->iommus.le_prev =3D NULL;
> >      >>> +    QLIST_INIT(&s->spaces);
> >      >>> +    qemu_cond_init(&s->core_cond);
> >      >>> +    qemu_mutex_init(&s->core_lock);
> >      >>> +    qemu_spin_init(&s->regs_lock);
> >      >>> +    qemu_thread_create(&s->core_proc, "riscv-iommu-core",
> >      >>> +        riscv_iommu_core_proc, s, QEMU_THREAD_JOINABLE);
> >      >>
> >      >> In our experience, using QEMU thread increases the latency of
> command
> >      >> queue processing,
> >      >> which leads to the potential IOMMU fence timeout in the Linux
> driver
> >      >> when using IOMMU with KVM,
> >      >> e.g. booting the guest Linux.
> >      >>
> >      >> Is it possible to remove the thread from the IOMMU just like
> ARM, AMD,
> >      >> and Intel IOMMU models?
> >      >
> >      > Interesting. We've been using this emulation internally in
> Ventana, with
> >      > KVM and VFIO, and didn't experience this issue. Drew is on CC an=
d
> can talk
> >      > more about it.
> >      >
> >      > That said, I don't mind this change, assuming it's feasible to
> make it for this
> >      > first version.  I'll need to check it how other IOMMUs are doing
> it.
> >
> >
> >     I removed the threading and it seems to be working fine without it.
> I'll commit this
> >     change for v3.
> >
> >      >
> >      >
> >      >
> >      >>
> >      >>> +}
> >      >>> +
> >      >
> >      > (...)
> >      >
> >      >>> +
> >      >>> +static AddressSpace *riscv_iommu_find_as(PCIBus *bus, void
> *opaque, int devfn)
> >      >>> +{
> >      >>> +    RISCVIOMMUState *s =3D (RISCVIOMMUState *) opaque;
> >      >>> +    PCIDevice *pdev =3D pci_find_device(bus, pci_bus_num(bus)=
,
> devfn);
> >      >>> +    AddressSpace *as =3D NULL;
> >      >>> +
> >      >>> +    if (pdev && pci_is_iommu(pdev)) {
> >      >>> +        return s->target_as;
> >      >>> +    }
> >      >>> +
> >      >>> +    /* Find first registered IOMMU device */
> >      >>> +    while (s->iommus.le_prev) {
> >      >>> +        s =3D *(s->iommus.le_prev);
> >      >>> +    }
> >      >>> +
> >      >>> +    /* Find first matching IOMMU */
> >      >>> +    while (s !=3D NULL && as =3D=3D NULL) {
> >      >>> +        as =3D riscv_iommu_space(s,
> PCI_BUILD_BDF(pci_bus_num(bus), devfn));
> >      >>
> >      >> For pci_bus_num(),
> >      >> riscv_iommu_find_as() can be called at the very early stage
> >      >> where software has no chance to enumerate the bus numbers.
> >
> >     I investigated and this doesn't seem to be a problem. This function
> is called at the
> >     last step of the realize() steps of both riscv_iommu_pci_realize()
> and
> >     riscv_iommu_sys_realize(), and by that time the pci_bus_num() is
> already assigned.
> >     Other iommus use pci_bus_num() into their own get_address_space()
> callbacks like
> >     this too.
> >
> >
> > Hi Daniel,
> >
> > IIUC, pci_bus_num() by default is assigned to pcibus_num():
> >
> > static int pcibus_num(PCIBus *bus)
> > {
> >      if (pci_bus_is_root(bus)) {
> >          return 0; /* pci host bridge */
> >      }
> >      return bus->parent_dev->config[PCI_SECONDARY_BUS];
> > }
> >
> > If the bus is not the root bus, it tries to read the bus' parent device=
's
> > secondary bus number (PCI_SECONDARY_BUS) field in the PCI configuration
> space.
> > This field should be programmable by the SW during PCIe enumeration.
> > But I don't think SW has a chance to be executed before
> riscv_iommu_sys_realize() is called,
> > since it's pretty early before CPU's execution unless RISC-V IOMMU is
> hot-plugged.
> > Even if RISC-V IOMMU is hot-plugged, I think riscv_iommu_sys_realize()
> is still called
> > before SW aware of the existence of IOMMU on the PCI topology tree.
> >
> > Do you think this matches your observation?
>
> It does. You have a good point on how the pcibus_num() can vary if SW
> wants to
> change the PCI_SECONDARY_BUS and the IOMMU isn't in a root bus. Note that
> this
> will not happen with the existing riscv-iommu-pci device as it is now,
> since it
> has code to prevent the device to be attached to non-pci root buses, but
> there's
> no restrictions in the riscv-iommu-sys device.
>

Thanks for the explanation.

Do you know where this limitation is from?
Is it in this patchset or it's somewhere else in the Linux RISC-V IOMMU
driver?

BTW, for the case like DesignWare PCIe host controller [1],
we cannot connect RISC-V IOMMU to the root bus ("pcie") [2]
because it already has a child bus ("dw-pcie") connecting to it [3].

If we try to connect RISC-V IOMMU to the root bus ("pcie"),
it can't be discovered by Linux PCIe driver as a PCIe Downstream Port
normally leads to a Link with only Device 0 on it.

PCIe spec 6.0, section 7.3.1 stats:
"Downstream Ports that do not have ARI Forwarding enabled must associate
only Device 0 with the device attached to the Logical Bus representing the
Link
from the Port."

The PCI slot scan is early returned in the Linux PCIe driver [4][5].

Do you think it's possible to remove this limitation?

[1] https://github.com/qemu/qemu/blob/master/hw/pci-host/designware.c
[2] https://github.com/qemu/qemu/blob/master/hw/pci-host/designware.c#L695
[3] https://github.com/qemu/qemu/blob/master/hw/pci-host/designware.c#L409
[4] https://github.com/torvalds/linux/blob/master/drivers/pci/probe.c#L2674
[5] https://github.com/torvalds/linux/blob/master/drivers/pci/probe.c#L2652

Regards,
Frank Chang

>
> And speaking on riscv-iommu-bus, the current device we have in this serie=
s
> is too
> bare bones, without an actual use case for it (e.g. code to add it in the
> 'virt'
> machine), but it's getting in the way nevertheless.
>
> I'll remove the riscv-iommu-sys device from v3 and re-introduce it in a
> later
> revision or as a follow up series. Sunil has a handful of patches that ad=
d
> the
> riscv-iommu-sys device in the 'virt' machine and the proper ACPI support
> for it [1],
> and I intend to use them as a base. We'll then need some minor adjustment=
s
> in the
> existing code to make it fully functional like we're doing with
> riscv-iommu-pci.
>
>
> Thanks,
>
> Daniel
>
>
> [1] https://github.com/vlsunil/qemu/commits/acpi_rimt_poc_v1/
> >
> > Regards,
> > Frank Chang
> >
> >
> >
> >     Thanks,
> >
> >
> >     Daniel
> >
> >
> >      >
> >      > I'll see how other IOMMUs are handling their iommu_find_as()
> >      >
> >      >
> >      > Thanks,
> >      >
> >      >
> >      > Daniel
> >      >
> >      >
> >      >>
> >      >>
> >      >>
> >      >>
> >      >>> +        s =3D s->iommus.le_next;
> >      >>> +    }
> >      >>> +
> >      >>> +    return as ? as : &address_space_memory;
> >      >>> +}
> >      >>> +
> >      >>> +static const PCIIOMMUOps riscv_iommu_ops =3D {
> >      >>> +    .get_address_space =3D riscv_iommu_find_as,
> >      >>> +};
> >      >>> +
> >      >>> +void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu,
> PCIBus *bus,
> >      >>> +        Error **errp)
> >      >>> +{
> >      >>> +    if (bus->iommu_ops &&
> >      >>> +        bus->iommu_ops->get_address_space =3D=3D
> riscv_iommu_find_as) {
> >      >>> +        /* Allow multiple IOMMUs on the same PCIe bus, link
> known devices */
> >      >>> +        RISCVIOMMUState *last =3D (RISCVIOMMUState
> *)bus->iommu_opaque;
> >      >>> +        QLIST_INSERT_AFTER(last, iommu, iommus);
> >      >>> +    } else if (bus->iommu_ops =3D=3D NULL) {
> >      >>> +        pci_setup_iommu(bus, &riscv_iommu_ops, iommu);
> >      >>> +    } else {
> >      >>> +        error_setg(errp, "can't register secondary IOMMU for
> PCI bus #%d",
> >      >>> +            pci_bus_num(bus));
> >      >>> +    }
> >      >>> +}
> >      >>> +
> >      >>> +static int riscv_iommu_memory_region_index(IOMMUMemoryRegion
> *iommu_mr,
> >      >>> +    MemTxAttrs attrs)
> >      >>> +{
> >      >>> +    return attrs.unspecified ? RISCV_IOMMU_NOPASID :
> (int)attrs.pasid;
> >      >>> +}
> >      >>> +
> >      >>> +static int
> riscv_iommu_memory_region_index_len(IOMMUMemoryRegion *iommu_mr)
> >      >>> +{
> >      >>> +    RISCVIOMMUSpace *as =3D container_of(iommu_mr,
> RISCVIOMMUSpace, iova_mr);
> >      >>> +    return 1 << as->iommu->pasid_bits;
> >      >>> +}
> >      >>> +
> >      >>> +static void riscv_iommu_memory_region_init(ObjectClass *klass=
,
> void *data)
> >      >>> +{
> >      >>> +    IOMMUMemoryRegionClass *imrc =3D
> IOMMU_MEMORY_REGION_CLASS(klass);
> >      >>> +
> >      >>> +    imrc->translate =3D riscv_iommu_memory_region_translate;
> >      >>> +    imrc->notify_flag_changed =3D
> riscv_iommu_memory_region_notify;
> >      >>> +    imrc->attrs_to_index =3D riscv_iommu_memory_region_index;
> >      >>> +    imrc->num_indexes =3D riscv_iommu_memory_region_index_len=
;
> >      >>> +}
> >      >>> +
> >      >>> +static const TypeInfo riscv_iommu_memory_region_info =3D {
> >      >>> +    .parent =3D TYPE_IOMMU_MEMORY_REGION,
> >      >>> +    .name =3D TYPE_RISCV_IOMMU_MEMORY_REGION,
> >      >>> +    .class_init =3D riscv_iommu_memory_region_init,
> >      >>> +};
> >      >>> +
> >      >>> +static void riscv_iommu_register_mr_types(void)
> >      >>> +{
> >      >>> +    type_register_static(&riscv_iommu_memory_region_info);
> >      >>> +    type_register_static(&riscv_iommu_info);
> >      >>> +}
> >      >>> +
> >      >>> +type_init(riscv_iommu_register_mr_types);
> >      >>> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> >      >>> new file mode 100644
> >      >>> index 0000000000..6f740de690
> >      >>> --- /dev/null
> >      >>> +++ b/hw/riscv/riscv-iommu.h
> >      >>> @@ -0,0 +1,141 @@
> >      >>> +/*
> >      >>> + * QEMU emulation of an RISC-V IOMMU (Ziommu)
> >      >>> + *
> >      >>> + * Copyright (C) 2022-2023 Rivos Inc.
> >      >>> + *
> >      >>> + * This program is free software; you can redistribute it
> and/or modify
> >      >>> + * it under the terms of the GNU General Public License as
> published by
> >      >>> + * the Free Software Foundation; either version 2 of the
> License.
> >      >>> + *
> >      >>> + * This program is distributed in the hope that it will be
> useful,
> >      >>> + * but WITHOUT ANY WARRANTY; without even the implied warrant=
y
> of
> >      >>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> the
> >      >>> + * GNU General Public License for more details.
> >      >>> + *
> >      >>> + * You should have received a copy of the GNU General Public
> License along
> >      >>> + * with this program; if not, see <
> http://www.gnu.org/licenses/ <http://www.gnu.org/licenses/>>.
> >      >>> + */
> >      >>> +
> >      >>> +#ifndef HW_RISCV_IOMMU_STATE_H
> >      >>> +#define HW_RISCV_IOMMU_STATE_H
> >      >>> +
> >      >>> +#include "qemu/osdep.h"
> >      >>> +#include "qom/object.h"
> >      >>> +
> >      >>> +#include "hw/riscv/iommu.h"
> >      >>> +
> >      >>> +struct RISCVIOMMUState {
> >      >>> +    /*< private >*/
> >      >>> +    DeviceState parent_obj;
> >      >>> +
> >      >>> +    /*< public >*/
> >      >>> +    uint32_t version;     /* Reported interface version numbe=
r
> */
> >      >>> +    uint32_t pasid_bits;  /* process identifier width */
> >      >>> +    uint32_t bus;         /* PCI bus mapping for non-root
> endpoints */
> >      >>> +
> >      >>> +    uint64_t cap;         /* IOMMU supported capabilities */
> >      >>> +    uint64_t fctl;        /* IOMMU enabled features */
> >      >>> +
> >      >>> +    bool enable_off;      /* Enable out-of-reset OFF mode (DM=
A
> disabled) */
> >      >>> +    bool enable_msi;      /* Enable MSI remapping */
> >      >>> +
> >      >>> +    /* IOMMU Internal State */
> >      >>> +    uint64_t ddtp;        /* Validated Device Directory Tree
> Root Pointer */
> >      >>> +
> >      >>> +    dma_addr_t cq_addr;   /* Command queue base physical
> address */
> >      >>> +    dma_addr_t fq_addr;   /* Fault/event queue base physical
> address */
> >      >>> +    dma_addr_t pq_addr;   /* Page request queue base physical
> address */
> >      >>> +
> >      >>> +    uint32_t cq_mask;     /* Command queue index bit mask */
> >      >>> +    uint32_t fq_mask;     /* Fault/event queue index bit mask
> */
> >      >>> +    uint32_t pq_mask;     /* Page request queue index bit mas=
k
> */
> >      >>> +
> >      >>> +    /* interrupt notifier */
> >      >>> +    void (*notify)(RISCVIOMMUState *iommu, unsigned vector);
> >      >>> +
> >      >>> +    /* IOMMU State Machine */
> >      >>> +    QemuThread core_proc; /* Background processing thread */
> >      >>> +    QemuMutex core_lock;  /* Global IOMMU lock, used for
> cache/regs updates */
> >      >>> +    QemuCond core_cond;   /* Background processing wake up
> signal */
> >      >>> +    unsigned core_exec;   /* Processing thread execution
> actions */
> >      >>> +
> >      >>> +    /* IOMMU target address space */
> >      >>> +    AddressSpace *target_as;
> >      >>> +    MemoryRegion *target_mr;
> >      >>> +
> >      >>> +    /* MSI / MRIF access trap */
> >      >>> +    AddressSpace trap_as;
> >      >>> +    MemoryRegion trap_mr;
> >      >>> +
> >      >>> +    GHashTable *ctx_cache;          /* Device translation
> Context Cache */
> >      >>> +
> >      >>> +    /* MMIO Hardware Interface */
> >      >>> +    MemoryRegion regs_mr;
> >      >>> +    QemuSpin regs_lock;
> >      >>> +    uint8_t *regs_rw;  /* register state (user write) */
> >      >>> +    uint8_t *regs_wc;  /* write-1-to-clear mask */
> >      >>> +    uint8_t *regs_ro;  /* read-only mask */
> >      >>> +
> >      >>> +    QLIST_ENTRY(RISCVIOMMUState) iommus;
> >      >>> +    QLIST_HEAD(, RISCVIOMMUSpace) spaces;
> >      >>> +};
> >      >>> +
> >      >>> +void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu,
> PCIBus *bus,
> >      >>> +         Error **errp);
> >      >>> +
> >      >>> +/* private helpers */
> >      >>> +
> >      >>> +/* Register helper functions */
> >      >>> +static inline uint32_t riscv_iommu_reg_mod32(RISCVIOMMUState
> *s,
> >      >>> +    unsigned idx, uint32_t set, uint32_t clr)
> >      >>> +{
> >      >>> +    uint32_t val;
> >      >>> +    qemu_spin_lock(&s->regs_lock);
> >      >>> +    val =3D ldl_le_p(s->regs_rw + idx);
> >      >>> +    stl_le_p(s->regs_rw + idx, (val & ~clr) | set);
> >      >>> +    qemu_spin_unlock(&s->regs_lock);
> >      >>> +    return val;
> >      >>> +}
> >      >>> +
> >      >>> +static inline void riscv_iommu_reg_set32(RISCVIOMMUState *s,
> >      >>> +    unsigned idx, uint32_t set)
> >      >>> +{
> >      >>> +    qemu_spin_lock(&s->regs_lock);
> >      >>> +    stl_le_p(s->regs_rw + idx, set);
> >      >>> +    qemu_spin_unlock(&s->regs_lock);
> >      >>> +}
> >      >>> +
> >      >>> +static inline uint32_t riscv_iommu_reg_get32(RISCVIOMMUState
> *s,
> >      >>> +    unsigned idx)
> >      >>> +{
> >      >>> +    return ldl_le_p(s->regs_rw + idx);
> >      >>> +}
> >      >>> +
> >      >>> +static inline uint64_t riscv_iommu_reg_mod64(RISCVIOMMUState
> *s,
> >      >>> +    unsigned idx, uint64_t set, uint64_t clr)
> >      >>> +{
> >      >>> +    uint64_t val;
> >      >>> +    qemu_spin_lock(&s->regs_lock);
> >      >>> +    val =3D ldq_le_p(s->regs_rw + idx);
> >      >>> +    stq_le_p(s->regs_rw + idx, (val & ~clr) | set);
> >      >>> +    qemu_spin_unlock(&s->regs_lock);
> >      >>> +    return val;
> >      >>> +}
> >      >>> +
> >      >>> +static inline void riscv_iommu_reg_set64(RISCVIOMMUState *s,
> >      >>> +    unsigned idx, uint64_t set)
> >      >>> +{
> >      >>> +    qemu_spin_lock(&s->regs_lock);
> >      >>> +    stq_le_p(s->regs_rw + idx, set);
> >      >>> +    qemu_spin_unlock(&s->regs_lock);
> >      >>> +}
> >      >>> +
> >      >>> +static inline uint64_t riscv_iommu_reg_get64(RISCVIOMMUState
> *s,
> >      >>> +    unsigned idx)
> >      >>> +{
> >      >>> +    return ldq_le_p(s->regs_rw + idx);
> >      >>> +}
> >      >>> +
> >      >>> +
> >      >>> +
> >      >>> +#endif
> >      >>> diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
> >      >>> new file mode 100644
> >      >>> index 0000000000..42a97caffa
> >      >>> --- /dev/null
> >      >>> +++ b/hw/riscv/trace-events
> >      >>> @@ -0,0 +1,11 @@
> >      >>> +# See documentation at docs/devel/tracing.rst
> >      >>> +
> >      >>> +# riscv-iommu.c
> >      >>> +riscv_iommu_new(const char *id, unsigned b, unsigned d,
> unsigned f) "%s: device attached %04x:%02x.%d"
> >      >>> +riscv_iommu_flt(const char *id, unsigned b, unsigned d,
> unsigned f, uint64_t reason, uint64_t iova) "%s: fault %04x:%02x.%u reaso=
n:
> 0x%"PRIx64" iova: 0x%"PRIx64
> >      >>> +riscv_iommu_pri(const char *id, unsigned b, unsigned d,
> unsigned f, uint64_t iova) "%s: page request %04x:%02x.%u iova: 0x%"PRIx6=
4
> >      >>> +riscv_iommu_dma(const char *id, unsigned b, unsigned d,
> unsigned f, unsigned pasid, const char *dir, uint64_t iova, uint64_t phys=
)
> "%s: translate %04x:%02x.%u #%u %s 0x%"PRIx64" -> 0x%"PRIx64
> >      >>> +riscv_iommu_msi(const char *id, unsigned b, unsigned d,
> unsigned f, uint64_t iova, uint64_t phys) "%s: translate %04x:%02x.%u MSI
> 0x%"PRIx64" -> 0x%"PRIx64
> >      >>> +riscv_iommu_cmd(const char *id, uint64_t l, uint64_t u) "%s:
> command 0x%"PRIx64" 0x%"PRIx64
> >      >>> +riscv_iommu_notifier_add(const char *id) "%s: dev-iotlb
> notifier added"
> >      >>> +riscv_iommu_notifier_del(const char *id) "%s: dev-iotlb
> notifier removed"
> >      >>> diff --git a/hw/riscv/trace.h b/hw/riscv/trace.h
> >      >>> new file mode 100644
> >      >>> index 0000000000..b88504b750
> >      >>> --- /dev/null
> >      >>> +++ b/hw/riscv/trace.h
> >      >>> @@ -0,0 +1,2 @@
> >      >>> +#include "trace/trace-hw_riscv.h"
> >      >>> +
> >      >>> diff --git a/include/hw/riscv/iommu.h b/include/hw/riscv/iommu=
.h
> >      >>> new file mode 100644
> >      >>> index 0000000000..403b365893
> >      >>> --- /dev/null
> >      >>> +++ b/include/hw/riscv/iommu.h
> >      >>> @@ -0,0 +1,36 @@
> >      >>> +/*
> >      >>> + * QEMU emulation of an RISC-V IOMMU (Ziommu)
> >      >>> + *
> >      >>> + * Copyright (C) 2022-2023 Rivos Inc.
> >      >>> + *
> >      >>> + * This program is free software; you can redistribute it
> and/or modify
> >      >>> + * it under the terms of the GNU General Public License as
> published by
> >      >>> + * the Free Software Foundation; either version 2 of the
> License.
> >      >>> + *
> >      >>> + * This program is distributed in the hope that it will be
> useful,
> >      >>> + * but WITHOUT ANY WARRANTY; without even the implied warrant=
y
> of
> >      >>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> the
> >      >>> + * GNU General Public License for more details.
> >      >>> + *
> >      >>> + * You should have received a copy of the GNU General Public
> License along
> >      >>> + * with this program; if not, see <
> http://www.gnu.org/licenses/ <http://www.gnu.org/licenses/>>.
> >      >>> + */
> >      >>> +
> >      >>> +#ifndef HW_RISCV_IOMMU_H
> >      >>> +#define HW_RISCV_IOMMU_H
> >      >>> +
> >      >>> +#include "qemu/osdep.h"
> >      >>> +#include "qom/object.h"
> >      >>> +
> >      >>> +#define TYPE_RISCV_IOMMU "riscv-iommu"
> >      >>> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUState, RISCV_IOMMU)
> >      >>> +typedef struct RISCVIOMMUState RISCVIOMMUState;
> >      >>> +
> >      >>> +#define TYPE_RISCV_IOMMU_MEMORY_REGION "riscv-iommu-mr"
> >      >>> +typedef struct RISCVIOMMUSpace RISCVIOMMUSpace;
> >      >>> +
> >      >>> +#define TYPE_RISCV_IOMMU_PCI "riscv-iommu-pci"
> >      >>> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStatePci, RISCV_IOMMU_PC=
I)
> >      >>> +typedef struct RISCVIOMMUStatePci RISCVIOMMUStatePci;
> >      >>> +
> >      >>> +#endif
> >      >>> diff --git a/meson.build b/meson.build
> >      >>> index c59ca496f2..75e56f3282 100644
> >      >>> --- a/meson.build
> >      >>> +++ b/meson.build
> >      >>> @@ -3361,6 +3361,7 @@ if have_system
> >      >>>       'hw/rdma',
> >      >>>       'hw/rdma/vmw',
> >      >>>       'hw/rtc',
> >      >>> +    'hw/riscv',
> >      >>>       'hw/s390x',
> >      >>>       'hw/scsi',
> >      >>>       'hw/sd',
> >      >>> --
> >      >>> 2.43.2
> >      >>>
> >      >>>
> >
>

--0000000000008495510618f49d4d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Daniel,</div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Tue, May 21, 2024 at 12:17=E2=80=AFAM Da=
niel Henrique Barboza &lt;<a href=3D"mailto:dbarboza@ventanamicro.com" targ=
et=3D"_blank">dbarboza@ventanamicro.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">Hi Frank,<br>
<br>
On 5/16/24 04:13, Frank Chang wrote:<br>
&gt; On Mon, May 13, 2024 at 8:37=E2=80=AFPM Daniel Henrique Barboza &lt;<a=
 href=3D"mailto:dbarboza@ventanamicro.com" target=3D"_blank">dbarboza@venta=
namicro.com</a> &lt;mailto:<a href=3D"mailto:dbarboza@ventanamicro.com" tar=
get=3D"_blank">dbarboza@ventanamicro.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi Frank,<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 5/8/24 08:15, Daniel Henrique Barboza wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Hi Frank,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; I&#39;ll reply with that I&#39;ve done so far=
. Still missing some stuff:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On 5/2/24 08:37, Frank Chang wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; Hi Daniel,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; Daniel Henrique Barboza &lt;<a href=3D"ma=
ilto:dbarboza@ventanamicro.com" target=3D"_blank">dbarboza@ventanamicro.com=
</a> &lt;mailto:<a href=3D"mailto:dbarboza@ventanamicro.com" target=3D"_bla=
nk">dbarboza@ventanamicro.com</a>&gt;&gt; =E6=96=BC 2024=E5=B9=B43=E6=9C=88=
8=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8812:04=E5=AF=AB=E9=81=93=EF=
=BC=9A<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; From: Tomasz Jeznach &lt;<a href=3D"m=
ailto:tjeznach@rivosinc.com" target=3D"_blank">tjeznach@rivosinc.com</a> &l=
t;mailto:<a href=3D"mailto:tjeznach@rivosinc.com" target=3D"_blank">tjeznac=
h@rivosinc.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; The RISC-V IOMMU specification is now=
 ratified as-per the RISC-V<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; international process. The latest fro=
zen specifcation can be found<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; at:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; <a href=3D"https://github.com/riscv-n=
on-isa/riscv-iommu/releases/download/v1.0/riscv-iommu.pdf" rel=3D"noreferre=
r" target=3D"_blank">https://github.com/riscv-non-isa/riscv-iommu/releases/=
download/v1.0/riscv-iommu.pdf</a> &lt;<a href=3D"https://github.com/riscv-n=
on-isa/riscv-iommu/releases/download/v1.0/riscv-iommu.pdf" rel=3D"noreferre=
r" target=3D"_blank">https://github.com/riscv-non-isa/riscv-iommu/releases/=
download/v1.0/riscv-iommu.pdf</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; Add the foundation of the device emul=
ation for RISC-V IOMMU, which<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; includes an IOMMU that has no capabil=
ities but MSI interrupt support and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; fault queue interfaces. We&#39;ll add=
 add more features incrementally in the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; next patches.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; Co-developed-by: Sebastien Boeuf &lt;=
<a href=3D"mailto:seb@rivosinc.com" target=3D"_blank">seb@rivosinc.com</a> =
&lt;mailto:<a href=3D"mailto:seb@rivosinc.com" target=3D"_blank">seb@rivosi=
nc.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; Signed-off-by: Sebastien Boeuf &lt;<a=
 href=3D"mailto:seb@rivosinc.com" target=3D"_blank">seb@rivosinc.com</a> &l=
t;mailto:<a href=3D"mailto:seb@rivosinc.com" target=3D"_blank">seb@rivosinc=
.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; Signed-off-by: Tomasz Jeznach &lt;<a =
href=3D"mailto:tjeznach@rivosinc.com" target=3D"_blank">tjeznach@rivosinc.c=
om</a> &lt;mailto:<a href=3D"mailto:tjeznach@rivosinc.com" target=3D"_blank=
">tjeznach@rivosinc.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; Signed-off-by: Daniel Henrique Barboz=
a &lt;<a href=3D"mailto:dbarboza@ventanamicro.com" target=3D"_blank">dbarbo=
za@ventanamicro.com</a> &lt;mailto:<a href=3D"mailto:dbarboza@ventanamicro.=
com" target=3D"_blank">dbarboza@ventanamicro.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; =C2=A0 hw/riscv/Kconfig=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 4 +<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0(...)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 s-&gt;iommus.le_n=
ext =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 s-&gt;iommus.le_p=
rev =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 QLIST_INIT(&amp;s=
-&gt;spaces);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 qemu_cond_init(&a=
mp;s-&gt;core_cond);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 qemu_mutex_init(&=
amp;s-&gt;core_lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 qemu_spin_init(&a=
mp;s-&gt;regs_lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 qemu_thread_creat=
e(&amp;s-&gt;core_proc, &quot;riscv-iommu-core&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 riscv_iommu_core_proc, s, QEMU_THREAD_JOINABLE);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; In our experience, using QEMU thread incr=
eases the latency of command<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; queue processing,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; which leads to the potential IOMMU fence =
timeout in the Linux driver<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; when using IOMMU with KVM,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; e.g. booting the guest Linux.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; Is it possible to remove the thread from =
the IOMMU just like ARM, AMD,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; and Intel IOMMU models?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Interesting. We&#39;ve been using this emulat=
ion internally in Ventana, with<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; KVM and VFIO, and didn&#39;t experience this =
issue. Drew is on CC and can talk<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; more about it.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; That said, I don&#39;t mind this change, assu=
ming it&#39;s feasible to make it for this<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; first version.=C2=A0 I&#39;ll need to check i=
t how other IOMMUs are doing it.<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I removed the threading and it seems to be working =
fine without it. I&#39;ll commit this<br>
&gt;=C2=A0 =C2=A0 =C2=A0change for v3.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (...)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +static AddressSpace *riscv_iommu_fin=
d_as(PCIBus *bus, void *opaque, int devfn)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 RISCVIOMMUState *=
s =3D (RISCVIOMMUState *) opaque;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 PCIDevice *pdev =
=3D pci_find_device(bus, pci_bus_num(bus), devfn);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 AddressSpace *as =
=3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 if (pdev &amp;&am=
p; pci_is_iommu(pdev)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return s-&gt;target_as;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 /* Find first reg=
istered IOMMU device */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 while (s-&gt;iomm=
us.le_prev) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 s =3D *(s-&gt;iommus.le_prev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 /* Find first mat=
ching IOMMU */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 while (s !=3D NUL=
L &amp;&amp; as =3D=3D NULL) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 as =3D riscv_iommu_space(s, PCI_BUILD_BDF(pci_bus_num(bus), devfn));=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; For pci_bus_num(),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; riscv_iommu_find_as() can be called at th=
e very early stage<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; where software has no chance to enumerate=
 the bus numbers.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I investigated and this doesn&#39;t seem to be a pr=
oblem. This function is called at the<br>
&gt;=C2=A0 =C2=A0 =C2=A0last step of the realize() steps of both riscv_iomm=
u_pci_realize() and<br>
&gt;=C2=A0 =C2=A0 =C2=A0riscv_iommu_sys_realize(), and by that time the pci=
_bus_num() is already assigned.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Other iommus use pci_bus_num() into their own get_a=
ddress_space() callbacks like<br>
&gt;=C2=A0 =C2=A0 =C2=A0this too.<br>
&gt; <br>
&gt; <br>
&gt; Hi Daniel,<br>
&gt; <br>
&gt; IIUC, pci_bus_num() by default is assigned to pcibus_num():<br>
&gt; <br>
&gt; static int pcibus_num(PCIBus *bus)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (pci_bus_is_root(bus)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0; /* pci host bridge */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return bus-&gt;parent_dev-&gt;config[PCI_SECONDARY=
_BUS];<br>
&gt; }<br>
&gt; <br>
&gt; If the bus is not the root bus, it tries to read the bus&#39; parent d=
evice&#39;s<br>
&gt; secondary bus number (PCI_SECONDARY_BUS) field in the PCI configuratio=
n space.<br>
&gt; This field should be programmable by the SW during PCIe enumeration.<b=
r>
&gt; But I don&#39;t think SW has a chance to be executed before riscv_iomm=
u_sys_realize() is called,<br>
&gt; since it&#39;s pretty early before CPU&#39;s execution unless RISC-V I=
OMMU is hot-plugged.<br>
&gt; Even if RISC-V IOMMU is hot-plugged, I think riscv_iommu_sys_realize()=
 is still called<br>
&gt; before SW aware of the existence of IOMMU on the PCI topology tree.<br=
>
&gt; <br>
&gt; Do you think this matches your observation?<br>
<br>
It does. You have a good point on how the pcibus_num() can vary if SW wants=
 to<br>
change the PCI_SECONDARY_BUS and the IOMMU isn&#39;t in a root bus. Note th=
at this<br>
will not happen with the existing riscv-iommu-pci device as it is now, sinc=
e it<br>
has code to prevent the device to be attached to non-pci root buses, but th=
ere&#39;s<br>
no restrictions in the riscv-iommu-sys device.<br></blockquote><div><br></d=
iv><div>Thanks for the explanation.<br></div><div><br></div><div>Do you kno=
w where this limitation is from?</div><div>Is it in this patchset or it&#39=
;s somewhere else in the Linux RISC-V IOMMU driver?</div><div><br></div><di=
v>BTW, for the case like DesignWare PCIe host controller [1],</div><div>we =
cannot connect RISC-V IOMMU to the root bus (&quot;pcie&quot;) [2]</div><di=
v>because it already has a child bus (&quot;dw-pcie&quot;) connecting to it=
 [3].</div><div><br></div><div>If we try to connect RISC-V IOMMU to the roo=
t bus (&quot;pcie&quot;),</div><div>it can&#39;t be discovered by Linux PCI=
e driver as a PCIe Downstream Port</div><div>normally leads to a Link with =
only Device 0 on it.</div><div><br></div><div>PCIe spec 6.0, section 7.3.1 =
stats:</div><div>&quot;Downstream Ports that do not have ARI
Forwarding enabled must associate</div><div>only Device 0 with the device a=
ttached to the Logical Bus representing the Link</div><div>from
the Port.&quot;</div><div><br></div><div>The PCI slot scan is early returne=
d in the Linux PCIe driver [4][5].</div><div><br></div><div>Do you think it=
&#39;s possible to remove this limitation?</div><div><br></div><div>[1]=C2=
=A0<a href=3D"https://github.com/qemu/qemu/blob/master/hw/pci-host/designwa=
re.c" target=3D"_blank">https://github.com/qemu/qemu/blob/master/hw/pci-hos=
t/designware.c</a><br></div><div>[2]=C2=A0<a href=3D"https://github.com/qem=
u/qemu/blob/master/hw/pci-host/designware.c#L695">https://github.com/qemu/q=
emu/blob/master/hw/pci-host/designware.c#L695</a></div><div>[3]=C2=A0<a hre=
f=3D"https://github.com/qemu/qemu/blob/master/hw/pci-host/designware.c#L409=
">https://github.com/qemu/qemu/blob/master/hw/pci-host/designware.c#L409</a=
></div><div>[4]=C2=A0<a href=3D"https://github.com/torvalds/linux/blob/mast=
er/drivers/pci/probe.c#L2674">https://github.com/torvalds/linux/blob/master=
/drivers/pci/probe.c#L2674</a></div><div>[5]=C2=A0<a href=3D"https://github=
.com/torvalds/linux/blob/master/drivers/pci/probe.c#L2652">https://github.c=
om/torvalds/linux/blob/master/drivers/pci/probe.c#L2652</a></div><div><br><=
/div><div>Regards,</div><div>Frank Chang</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
<br>
And speaking on riscv-iommu-bus, the current device we have in this series =
is too<br>
bare bones, without an actual use case for it (e.g. code to add it in the &=
#39;virt&#39;<br>
machine), but it&#39;s getting in the way nevertheless.<br>
<br>
I&#39;ll remove the riscv-iommu-sys device from v3 and re-introduce it in a=
 later<br>
revision or as a follow up series. Sunil has a handful of patches that add =
the<br>
riscv-iommu-sys device in the &#39;virt&#39; machine and the proper ACPI su=
pport for it [1],<br>
and I intend to use them as a base. We&#39;ll then need some minor adjustme=
nts in the<br>
existing code to make it fully functional like we&#39;re doing with riscv-i=
ommu-pci.<br>
<br>
<br>
Thanks,<br>
<br>
Daniel<br>
<br>
<br>
[1] <a href=3D"https://github.com/vlsunil/qemu/commits/acpi_rimt_poc_v1/" r=
el=3D"noreferrer" target=3D"_blank">https://github.com/vlsunil/qemu/commits=
/acpi_rimt_poc_v1/</a><br>
&gt; <br>
&gt; Regards,<br>
&gt; Frank Chang<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Thanks,<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Daniel<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; I&#39;ll see how other IOMMUs are handling th=
eir iommu_find_as()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Thanks,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Daniel<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 s =3D s-&gt;iommus.le_next;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 return as ? as : =
&amp;address_space_memory;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +static const PCIIOMMUOps riscv_iommu=
_ops =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 .get_address_spac=
e =3D riscv_iommu_find_as,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +void riscv_iommu_pci_setup_iommu(RIS=
CVIOMMUState *iommu, PCIBus *bus,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 if (bus-&gt;iommu=
_ops &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 bus-&gt;iommu_ops-&gt;get_address_space =3D=3D riscv_iommu_find_as) =
{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* Allow multiple IOMMUs on the same PCIe bus, link known devices */=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 RISCVIOMMUState *last =3D (RISCVIOMMUState *)bus-&gt;iommu_opaque;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 QLIST_INSERT_AFTER(last, iommu, iommus);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 } else if (bus-&g=
t;iommu_ops =3D=3D NULL) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 pci_setup_iommu(bus, &amp;riscv_iommu_ops, iommu);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 error_setg(errp, &quot;can&#39;t register secondary IOMMU for PCI bu=
s #%d&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_bus_num(bus));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +static int riscv_iommu_memory_region=
_index(IOMMUMemoryRegion *iommu_mr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 MemTxAttrs attrs)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 return attrs.unsp=
ecified ? RISCV_IOMMU_NOPASID : (int)attrs.pasid;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +static int riscv_iommu_memory_region=
_index_len(IOMMUMemoryRegion *iommu_mr)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 RISCVIOMMUSpace *=
as =3D container_of(iommu_mr, RISCVIOMMUSpace, iova_mr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 return 1 &lt;&lt;=
 as-&gt;iommu-&gt;pasid_bits;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +static void riscv_iommu_memory_regio=
n_init(ObjectClass *klass, void *data)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 IOMMUMemoryRegion=
Class *imrc =3D IOMMU_MEMORY_REGION_CLASS(klass);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 imrc-&gt;translat=
e =3D riscv_iommu_memory_region_translate;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 imrc-&gt;notify_f=
lag_changed =3D riscv_iommu_memory_region_notify;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 imrc-&gt;attrs_to=
_index =3D riscv_iommu_memory_region_index;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 imrc-&gt;num_inde=
xes =3D riscv_iommu_memory_region_index_len;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +static const TypeInfo riscv_iommu_me=
mory_region_info =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 .parent =3D TYPE_=
IOMMU_MEMORY_REGION,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 .name =3D TYPE_RI=
SCV_IOMMU_MEMORY_REGION,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 .class_init =3D r=
iscv_iommu_memory_region_init,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +static void riscv_iommu_register_mr_=
types(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 type_register_sta=
tic(&amp;riscv_iommu_memory_region_info);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 type_register_sta=
tic(&amp;riscv_iommu_info);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +type_init(riscv_iommu_register_mr_ty=
pes);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; diff --git a/hw/riscv/riscv-iommu.h b=
/hw/riscv/riscv-iommu.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; new file mode 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; index 0000000000..6f740de690<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; --- /dev/null<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +++ b/hw/riscv/riscv-iommu.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; @@ -0,0 +1,141 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + * QEMU emulation of an RISC-V IOMMU=
 (Ziommu)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + * Copyright (C) 2022-2023 Rivos Inc=
.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + * This program is free software; yo=
u can redistribute it and/or modify<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + * it under the terms of the GNU Gen=
eral Public License as published by<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + * the Free Software Foundation; eit=
her version 2 of the License.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + * This program is distributed in th=
e hope that it will be useful,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + * but WITHOUT ANY WARRANTY; without=
 even the implied warranty of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + * MERCHANTABILITY or FITNESS FOR A =
PARTICULAR PURPOSE.=C2=A0 See the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + * GNU General Public License for mo=
re details.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + * You should have received a copy o=
f the GNU General Public License along<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + * with this program; if not, see &l=
t;<a href=3D"http://www.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_bl=
ank">http://www.gnu.org/licenses/</a> &lt;<a href=3D"http://www.gnu.org/lic=
enses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.org/licenses/</=
a>&gt;&gt;.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +#ifndef HW_RISCV_IOMMU_STATE_H<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +#define HW_RISCV_IOMMU_STATE_H<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +#include &quot;qemu/osdep.h&quot;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +#include &quot;qom/object.h&quot;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +#include &quot;hw/riscv/iommu.h&quot=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +struct RISCVIOMMUState {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 /*&lt; private &g=
t;*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 DeviceState paren=
t_obj;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 /*&lt; public &gt=
;*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint32_t version;=
=C2=A0=C2=A0=C2=A0=C2=A0 /* Reported interface version number */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint32_t pasid_bi=
ts;=C2=A0 /* process identifier width */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint32_t bus;=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* PCI bus mapping for non-ro=
ot endpoints */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint64_t cap;=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* IOMMU supported capabiliti=
es */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint64_t fctl;=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* IOMMU enabled features */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 bool enable_off;=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Enable out-of-reset OFF mode (DMA disable=
d) */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 bool enable_msi;=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Enable MSI remapping */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 /* IOMMU Internal=
 State */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint64_t ddtp;=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Validated Device Directory Tree =
Root Pointer */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 dma_addr_t cq_add=
r;=C2=A0=C2=A0 /* Command queue base physical address */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 dma_addr_t fq_add=
r;=C2=A0=C2=A0 /* Fault/event queue base physical address */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 dma_addr_t pq_add=
r;=C2=A0=C2=A0 /* Page request queue base physical address */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint32_t cq_mask;=
=C2=A0=C2=A0=C2=A0=C2=A0 /* Command queue index bit mask */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint32_t fq_mask;=
=C2=A0=C2=A0=C2=A0=C2=A0 /* Fault/event queue index bit mask */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint32_t pq_mask;=
=C2=A0=C2=A0=C2=A0=C2=A0 /* Page request queue index bit mask */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 /* interrupt noti=
fier */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 void (*notify)(RI=
SCVIOMMUState *iommu, unsigned vector);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 /* IOMMU State Ma=
chine */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 QemuThread core_p=
roc; /* Background processing thread */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 QemuMutex core_lo=
ck;=C2=A0 /* Global IOMMU lock, used for cache/regs updates */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 QemuCond core_con=
d;=C2=A0=C2=A0 /* Background processing wake up signal */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 unsigned core_exe=
c;=C2=A0=C2=A0 /* Processing thread execution actions */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 /* IOMMU target a=
ddress space */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 AddressSpace *tar=
get_as;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 MemoryRegion *tar=
get_mr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 /* MSI / MRIF acc=
ess trap */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 AddressSpace trap=
_as;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 MemoryRegion trap=
_mr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 GHashTable *ctx_c=
ache;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Device trans=
lation Context Cache */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 /* MMIO Hardware =
Interface */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 MemoryRegion regs=
_mr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 QemuSpin regs_loc=
k;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint8_t *regs_rw;=
=C2=A0 /* register state (user write) */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint8_t *regs_wc;=
=C2=A0 /* write-1-to-clear mask */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint8_t *regs_ro;=
=C2=A0 /* read-only mask */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 QLIST_ENTRY(RISCV=
IOMMUState) iommus;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 QLIST_HEAD(, RISC=
VIOMMUSpace) spaces;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +void riscv_iommu_pci_setup_iommu(RIS=
CVIOMMUState *iommu, PCIBus *bus,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 Error **errp);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +/* private helpers */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +/* Register helper functions */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +static inline uint32_t riscv_iommu_r=
eg_mod32(RISCVIOMMUState *s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 unsigned idx, uin=
t32_t set, uint32_t clr)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint32_t val;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 qemu_spin_lock(&a=
mp;s-&gt;regs_lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 val =3D ldl_le_p(=
s-&gt;regs_rw + idx);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 stl_le_p(s-&gt;re=
gs_rw + idx, (val &amp; ~clr) | set);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 qemu_spin_unlock(=
&amp;s-&gt;regs_lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 return val;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +static inline void riscv_iommu_reg_s=
et32(RISCVIOMMUState *s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 unsigned idx, uin=
t32_t set)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 qemu_spin_lock(&a=
mp;s-&gt;regs_lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 stl_le_p(s-&gt;re=
gs_rw + idx, set);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 qemu_spin_unlock(=
&amp;s-&gt;regs_lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +static inline uint32_t riscv_iommu_r=
eg_get32(RISCVIOMMUState *s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 unsigned idx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 return ldl_le_p(s=
-&gt;regs_rw + idx);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +static inline uint64_t riscv_iommu_r=
eg_mod64(RISCVIOMMUState *s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 unsigned idx, uin=
t64_t set, uint64_t clr)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint64_t val;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 qemu_spin_lock(&a=
mp;s-&gt;regs_lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 val =3D ldq_le_p(=
s-&gt;regs_rw + idx);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 stq_le_p(s-&gt;re=
gs_rw + idx, (val &amp; ~clr) | set);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 qemu_spin_unlock(=
&amp;s-&gt;regs_lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 return val;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +static inline void riscv_iommu_reg_s=
et64(RISCVIOMMUState *s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 unsigned idx, uin=
t64_t set)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 qemu_spin_lock(&a=
mp;s-&gt;regs_lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 stq_le_p(s-&gt;re=
gs_rw + idx, set);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 qemu_spin_unlock(=
&amp;s-&gt;regs_lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +static inline uint64_t riscv_iommu_r=
eg_get64(RISCVIOMMUState *s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 unsigned idx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 return ldq_le_p(s=
-&gt;regs_rw + idx);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; diff --git a/hw/riscv/trace-events b/=
hw/riscv/trace-events<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; new file mode 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; index 0000000000..42a97caffa<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; --- /dev/null<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +++ b/hw/riscv/trace-events<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; @@ -0,0 +1,11 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +# See documentation at docs/devel/tr=
acing.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +# riscv-iommu.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +riscv_iommu_new(const char *id, unsi=
gned b, unsigned d, unsigned f) &quot;%s: device attached %04x:%02x.%d&quot=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +riscv_iommu_flt(const char *id, unsi=
gned b, unsigned d, unsigned f, uint64_t reason, uint64_t iova) &quot;%s: f=
ault %04x:%02x.%u reason: 0x%&quot;PRIx64&quot; iova: 0x%&quot;PRIx64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +riscv_iommu_pri(const char *id, unsi=
gned b, unsigned d, unsigned f, uint64_t iova) &quot;%s: page request %04x:=
%02x.%u iova: 0x%&quot;PRIx64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +riscv_iommu_dma(const char *id, unsi=
gned b, unsigned d, unsigned f, unsigned pasid, const char *dir, uint64_t i=
ova, uint64_t phys) &quot;%s: translate %04x:%02x.%u #%u %s 0x%&quot;PRIx64=
&quot; -&gt; 0x%&quot;PRIx64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +riscv_iommu_msi(const char *id, unsi=
gned b, unsigned d, unsigned f, uint64_t iova, uint64_t phys) &quot;%s: tra=
nslate %04x:%02x.%u MSI 0x%&quot;PRIx64&quot; -&gt; 0x%&quot;PRIx64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +riscv_iommu_cmd(const char *id, uint=
64_t l, uint64_t u) &quot;%s: command 0x%&quot;PRIx64&quot; 0x%&quot;PRIx64=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +riscv_iommu_notifier_add(const char =
*id) &quot;%s: dev-iotlb notifier added&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +riscv_iommu_notifier_del(const char =
*id) &quot;%s: dev-iotlb notifier removed&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; diff --git a/hw/riscv/trace.h b/hw/ri=
scv/trace.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; new file mode 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; index 0000000000..b88504b750<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; --- /dev/null<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +++ b/hw/riscv/trace.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; @@ -0,0 +1,2 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +#include &quot;trace/trace-hw_riscv.=
h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; diff --git a/include/hw/riscv/iommu.h=
 b/include/hw/riscv/iommu.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; new file mode 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; index 0000000000..403b365893<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; --- /dev/null<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +++ b/include/hw/riscv/iommu.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; @@ -0,0 +1,36 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + * QEMU emulation of an RISC-V IOMMU=
 (Ziommu)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + * Copyright (C) 2022-2023 Rivos Inc=
.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + * This program is free software; yo=
u can redistribute it and/or modify<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + * it under the terms of the GNU Gen=
eral Public License as published by<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + * the Free Software Foundation; eit=
her version 2 of the License.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + * This program is distributed in th=
e hope that it will be useful,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + * but WITHOUT ANY WARRANTY; without=
 even the implied warranty of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + * MERCHANTABILITY or FITNESS FOR A =
PARTICULAR PURPOSE.=C2=A0 See the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + * GNU General Public License for mo=
re details.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + * You should have received a copy o=
f the GNU General Public License along<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + * with this program; if not, see &l=
t;<a href=3D"http://www.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_bl=
ank">http://www.gnu.org/licenses/</a> &lt;<a href=3D"http://www.gnu.org/lic=
enses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.org/licenses/</=
a>&gt;&gt;.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; + */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +#ifndef HW_RISCV_IOMMU_H<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +#define HW_RISCV_IOMMU_H<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +#include &quot;qemu/osdep.h&quot;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +#include &quot;qom/object.h&quot;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +#define TYPE_RISCV_IOMMU &quot;riscv=
-iommu&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMM=
UState, RISCV_IOMMU)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +typedef struct RISCVIOMMUState RISCV=
IOMMUState;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +#define TYPE_RISCV_IOMMU_MEMORY_REGI=
ON &quot;riscv-iommu-mr&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +typedef struct RISCVIOMMUSpace RISCV=
IOMMUSpace;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +#define TYPE_RISCV_IOMMU_PCI &quot;r=
iscv-iommu-pci&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMM=
UStatePci, RISCV_IOMMU_PCI)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +typedef struct RISCVIOMMUStatePci RI=
SCVIOMMUStatePci;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; diff --git a/meson.build b/meson.buil=
d<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; index c59ca496f2..75e56f3282 100644<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; --- a/meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +++ b/meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; @@ -3361,6 +3361,7 @@ if have_system<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &#39;h=
w/rdma&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &#39;h=
w/rdma/vmw&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &#39;h=
w/rtc&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 &#39;hw/riscv&#39=
;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &#39;h=
w/s390x&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &#39;h=
w/scsi&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &#39;h=
w/sd&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; --<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; 2.43.2<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;<br>
&gt; <br>
</blockquote></div></div>

--0000000000008495510618f49d4d--

