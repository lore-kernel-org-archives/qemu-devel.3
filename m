Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92CEC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 05:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMLb9-0000id-4j; Wed, 26 Jun 2024 01:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1sMLb7-0000iJ-Ef; Wed, 26 Jun 2024 01:53:37 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1sMLb4-00068o-5Q; Wed, 26 Jun 2024 01:53:37 -0400
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
 by Atcsqr.andestech.com with ESMTP id 45Q5r7Ec062174;
 Wed, 26 Jun 2024 13:53:07 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from ethan84-VirtualBox (10.0.12.12) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Wed, 26 Jun 2024
 13:53:08 +0800
Date: Wed, 26 Jun 2024 13:53:02 +0800
To: Alistair Francis <alistair23@gmail.com>
CC: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <palmer@dabbelt.com>,
 <alistair.francis@wdc.com>, <bmeng.cn@gmail.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v7 2/2] hw/riscv/virt: Add IOPMP support
Message-ID: <ZnustMxe+9eToclp@ethan84-VirtualBox>
References: <20240612031706.2927602-1-ethan84@andestech.com>
 <20240612031706.2927602-3-ethan84@andestech.com>
 <CAKmqyKM+dSQfGAUcU9w+hHA1SVA-OSLhsfYHh7rV1uutaeppfw@mail.gmail.com>
 <ZnjQCkiR2ikr1Rng@ethan84-VirtualBox>
 <CAKmqyKMzg0rHj0RfpcGB3Mecy4tVvMQWDhgM8u3=GaRn46q2vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKMzg0rHj0RfpcGB3Mecy4tVvMQWDhgM8u3=GaRn46q2vg@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Originating-IP: [10.0.12.12]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 45Q5r7Ec062174
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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
Reply-to:  Ethan Chen <ethan84@andestech.com>
From:  Ethan Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jun 26, 2024 at 11:22:46AM +1000, Alistair Francis wrote:
> 
> On Mon, Jun 24, 2024 at 11:47 AM Ethan Chen <ethan84@andestech.com> wrote:
> >
> > Hi Alistair,
> >
> > IOPMP can applies all device. In this patch series, PCI devices on the bridge
> > can connect to IOPMP by pci_setup_iommu(), but other devices need change their
> > memory access address space from system memory to IOPMP by themself.
> 
> We should be really clear about that then. The documentation and the
> flag `iopmp=[on|off]` implies that either the IOPMP is on or off.
> 
> For example, what happens in the future if we extend support to apply
> to all devices? That will be a breaking change for anyone currently
> using `iopmp=on`.
> 
> Maybe we should have use something like `iopmp=[pci|off]` instead, and
> then be really clear in the docs what is and isn't going through the
> IOPMP.
> 
> Alistair

Hi Alistair,

According to Zhiwei's suggestion in this patch series, we will remove
iopmp_setup_pci because it will be exclusive with IOMMU integration.

We are looking for an interface to make device memory access to be
checked by IOPMP. After iopmp_setup_pci is removed, all devices need
to change memory access target to iommu memory region in IOPMP
themselves in current method. Therefore, by default, all devices won't
go through the IOPMP even if iopmp=on.

Another method is to replace the memory region of protected device
in the system memory by iommu memory region in IOPMP (similar to
MPC in arm/mps2-tz) when iopmp=on. With this method, all devices are
going through the IOPMP by default when iopmp=on.

Which method is more suitable for the RISC-V virt machine?

Thanks,
Ethan

> 
> >
> > Thanks,
> > Ethan
> >
> > On Fri, Jun 21, 2024 at 03:54:15PM +1000, Alistair Francis wrote:
> > > On Wed, Jun 12, 2024 at 1:25 PM Ethan Chen via <qemu-devel@nongnu.org> wrote:
> > > >
> > > > If a requestor device is connected to the IOPMP device, its memory access will
> > > > be checked by the IOPMP rule.
> > > >
> > > > - Add 'iopmp=on' option to add an iopmp device and make the Generic PCI Express
> > > >   Bridge connect to IOPMP.
> > >
> > > I have only had a chance to have a quick look at this series and the spec.
> > >
> > > But the IOPMP spec applies to all devices right, but this series seems
> > > to only work with PCI. Am I missing something?
> > >
> > > Alistair
> > >
> > > >
> > > > Signed-off-by: Ethan Chen <ethan84@andestech.com>
> > > > ---
> > > >  docs/system/riscv/virt.rst |  6 ++++
> > > >  hw/riscv/Kconfig           |  1 +
> > > >  hw/riscv/virt.c            | 57 ++++++++++++++++++++++++++++++++++++--
> > > >  include/hw/riscv/virt.h    |  5 +++-
> > > >  4 files changed, 66 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> > > > index 9a06f95a34..3b2576f905 100644
> > > > --- a/docs/system/riscv/virt.rst
> > > > +++ b/docs/system/riscv/virt.rst
> > > > @@ -116,6 +116,12 @@ The following machine-specific options are supported:
> > > >    having AIA IMSIC (i.e. "aia=aplic-imsic" selected). When not specified,
> > > >    the default number of per-HART VS-level AIA IMSIC pages is 0.
> > > >
> > > > +- iopmp=[on|off]
> > > > +
> > > > +  When this option is "on", an IOPMP device is added to machine. It checks dma
> > > > +  operations from the generic PCIe host bridge. This option is assumed to be
> > > > +  "off".
> > > > +
> > > >  Running Linux kernel
> > > >  --------------------
> > > >
> > > > diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> > > > index a2030e3a6f..0b45a5ade2 100644
> > > > --- a/hw/riscv/Kconfig
> > > > +++ b/hw/riscv/Kconfig
> > > > @@ -56,6 +56,7 @@ config RISCV_VIRT
> > > >      select PLATFORM_BUS
> > > >      select ACPI
> > > >      select ACPI_PCI
> > > > +    select RISCV_IOPMP
> > > >
> > > >  config SHAKTI_C
> > > >      bool
> > > > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > > > index 4fdb660525..53a1b71c71 100644
> > > > --- a/hw/riscv/virt.c
> > > > +++ b/hw/riscv/virt.c
> > > > @@ -55,6 +55,7 @@
> > > >  #include "hw/acpi/aml-build.h"
> > > >  #include "qapi/qapi-visit-common.h"
> > > >  #include "hw/virtio/virtio-iommu.h"
> > > > +#include "hw/misc/riscv_iopmp.h"
> > > >
> > > >  /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QEMU. */
> > > >  static bool virt_use_kvm_aia(RISCVVirtState *s)
> > > > @@ -82,6 +83,7 @@ static const MemMapEntry virt_memmap[] = {
> > > >      [VIRT_UART0] =        { 0x10000000,         0x100 },
> > > >      [VIRT_VIRTIO] =       { 0x10001000,        0x1000 },
> > > >      [VIRT_FW_CFG] =       { 0x10100000,          0x18 },
> > > > +    [VIRT_IOPMP] =        { 0x10200000,      0x100000 },
> > > >      [VIRT_FLASH] =        { 0x20000000,     0x4000000 },
> > > >      [VIRT_IMSIC_M] =      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
> > > >      [VIRT_IMSIC_S] =      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
> > > > @@ -1006,6 +1008,24 @@ static void create_fdt_virtio_iommu(RISCVVirtState *s, uint16_t bdf)
> > > >                             bdf + 1, iommu_phandle, bdf + 1, 0xffff - bdf);
> > > >  }
> > > >
> > > > +static void create_fdt_iopmp(RISCVVirtState *s, const MemMapEntry *memmap,
> > > > +                             uint32_t irq_mmio_phandle) {
> > > > +    g_autofree char *name = NULL;
> > > > +    MachineState *ms = MACHINE(s);
> > > > +
> > > > +    name = g_strdup_printf("/soc/iopmp@%lx", (long)memmap[VIRT_IOPMP].base);
> > > > +    qemu_fdt_add_subnode(ms->fdt, name);
> > > > +    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "riscv_iopmp");
> > > > +    qemu_fdt_setprop_cells(ms->fdt, name, "reg", 0x0, memmap[VIRT_IOPMP].base,
> > > > +        0x0, memmap[VIRT_IOPMP].size);
> > > > +    qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent", irq_mmio_phandle);
> > > > +    if (s->aia_type == VIRT_AIA_TYPE_NONE) {
> > > > +        qemu_fdt_setprop_cell(ms->fdt, name, "interrupts", IOPMP_IRQ);
> > > > +    } else {
> > > > +        qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", IOPMP_IRQ, 0x4);
> > > > +    }
> > > > +}
> > > > +
> > > >  static void finalize_fdt(RISCVVirtState *s)
> > > >  {
> > > >      uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
> > > > @@ -1024,6 +1044,10 @@ static void finalize_fdt(RISCVVirtState *s)
> > > >      create_fdt_uart(s, virt_memmap, irq_mmio_phandle);
> > > >
> > > >      create_fdt_rtc(s, virt_memmap, irq_mmio_phandle);
> > > > +
> > > > +    if (s->have_iopmp) {
> > > > +        create_fdt_iopmp(s, virt_memmap, irq_mmio_phandle);
> > > > +    }
> > > >  }
> > > >
> > > >  static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
> > > > @@ -1404,7 +1428,7 @@ static void virt_machine_init(MachineState *machine)
> > > >      RISCVVirtState *s = RISCV_VIRT_MACHINE(machine);
> > > >      MemoryRegion *system_memory = get_system_memory();
> > > >      MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
> > > > -    DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
> > > > +    DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip, *gpex_dev;
> > > >      int i, base_hartid, hart_count;
> > > >      int socket_count = riscv_socket_count(machine);
> > > >
> > > > @@ -1570,7 +1594,7 @@ static void virt_machine_init(MachineState *machine)
> > > >              qdev_get_gpio_in(virtio_irqchip, VIRTIO_IRQ + i));
> > > >      }
> > > >
> > > > -    gpex_pcie_init(system_memory, pcie_irqchip, s);
> > > > +    gpex_dev = gpex_pcie_init(system_memory, pcie_irqchip, s);
> > > >
> > > >      create_platform_bus(s, mmio_irqchip);
> > > >
> > > > @@ -1581,6 +1605,14 @@ static void virt_machine_init(MachineState *machine)
> > > >      sysbus_create_simple("goldfish_rtc", memmap[VIRT_RTC].base,
> > > >          qdev_get_gpio_in(mmio_irqchip, RTC_IRQ));
> > > >
> > > > +    if (s->have_iopmp) {
> > > > +        DeviceState *iopmp_dev = sysbus_create_simple(TYPE_IOPMP,
> > > > +            memmap[VIRT_IOPMP].base,
> > > > +            qdev_get_gpio_in(DEVICE(mmio_irqchip), IOPMP_IRQ));
> > > > +
> > > > +        iopmp_setup_pci(iopmp_dev, PCI_HOST_BRIDGE(gpex_dev)->bus);
> > > > +    }
> > > > +
> > > >      for (i = 0; i < ARRAY_SIZE(s->flash); i++) {
> > > >          /* Map legacy -drive if=pflash to machine properties */
> > > >          pflash_cfi01_legacy_drive(s->flash[i],
> > > > @@ -1684,6 +1716,21 @@ static void virt_set_aclint(Object *obj, bool value, Error **errp)
> > > >      s->have_aclint = value;
> > > >  }
> > > >
> > > > +static bool virt_get_iopmp(Object *obj, Error **errp)
> > > > +{
> > > > +    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
> > > > +
> > > > +    return s->have_iopmp;
> > > > +}
> > > > +
> > > > +static void virt_set_iopmp(Object *obj, bool value, Error **errp)
> > > > +{
> > > > +    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
> > > > +
> > > > +    s->have_iopmp = value;
> > > > +}
> > > > +
> > > > +
> > > >  bool virt_is_acpi_enabled(RISCVVirtState *s)
> > > >  {
> > > >      return s->acpi != ON_OFF_AUTO_OFF;
> > > > @@ -1794,6 +1841,12 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
> > > >                                NULL, NULL);
> > > >      object_class_property_set_description(oc, "acpi",
> > > >                                            "Enable ACPI");
> > > > +
> > > > +    object_class_property_add_bool(oc, "iopmp", virt_get_iopmp,
> > > > +                                   virt_set_iopmp);
> > > > +    object_class_property_set_description(oc, "iopmp",
> > > > +                                          "Set on/off to enable/disable "
> > > > +                                          "iopmp device");
> > > >  }
> > > >
> > > >  static const TypeInfo virt_machine_typeinfo = {
> > > > diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> > > > index 3db839160f..81460e29c4 100644
> > > > --- a/include/hw/riscv/virt.h
> > > > +++ b/include/hw/riscv/virt.h
> > > > @@ -55,6 +55,7 @@ struct RISCVVirtState {
> > > >
> > > >      int fdt_size;
> > > >      bool have_aclint;
> > > > +    bool have_iopmp;
> > > >      RISCVVirtAIAType aia_type;
> > > >      int aia_guests;
> > > >      char *oem_id;
> > > > @@ -84,12 +85,14 @@ enum {
> > > >      VIRT_PCIE_MMIO,
> > > >      VIRT_PCIE_PIO,
> > > >      VIRT_PLATFORM_BUS,
> > > > -    VIRT_PCIE_ECAM
> > > > +    VIRT_PCIE_ECAM,
> > > > +    VIRT_IOPMP,
> > > >  };
> > > >
> > > >  enum {
> > > >      UART0_IRQ = 10,
> > > >      RTC_IRQ = 11,
> > > > +    IOPMP_IRQ = 12,
> > > >      VIRTIO_IRQ = 1, /* 1 to 8 */
> > > >      VIRTIO_COUNT = 8,
> > > >      PCIE_IRQ = 0x20, /* 32 to 35 */
> > > > --
> > > > 2.34.1
> > > >
> > > >

