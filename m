Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812BDC52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 10:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scMeH-0002tb-Om; Fri, 09 Aug 2024 06:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1scMeF-0002rZ-Dd; Fri, 09 Aug 2024 06:15:03 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1scMeD-0005y7-50; Fri, 09 Aug 2024 06:15:03 -0400
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
 by Atcsqr.andestech.com with ESMTPS id 479AEkKI033473
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Aug 2024 18:14:46 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from ethan84-VirtualBox (10.0.12.12) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 9 Aug 2024
 18:14:46 +0800
Date: Fri, 9 Aug 2024 18:14:45 +0800
To: Alistair Francis <alistair23@gmail.com>
CC: <qemu-devel@nongnu.org>, <richard.henderson@linaro.org>,
 <pbonzini@redhat.com>, <peterx@redhat.com>, <david@redhat.com>,
 <philmd@linaro.org>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>,
 <bmeng.cn@gmail.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, <zhiwei_liu@linux.alibaba.com>,
 <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v8 8/8] hw/riscv/virt: Add IOPMP support
Message-ID: <ZrXsFaBndB0zTONi@ethan84-VirtualBox>
References: <20240715095702.1222213-1-ethan84@andestech.com>
 <20240715101434.1249621-1-ethan84@andestech.com>
 <CAKmqyKPgqNaT1A0+pk6srrtPQqs6=SUX_etg55hU3rxPbuFVsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKPgqNaT1A0+pk6srrtPQqs6=SUX_etg55hU3rxPbuFVsA@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Originating-IP: [10.0.12.12]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 479AEkKI033473
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

On Thu, Aug 08, 2024 at 02:01:13PM +1000, Alistair Francis wrote:
> 
> On Mon, Jul 15, 2024 at 8:15 PM Ethan Chen via <qemu-devel@nongnu.org> wrote:
> >
> > - Add 'iopmp=on' option to enable IOPMP. It adds an iopmp device virt machine
> >   to protect all regions of system memory, and configures RRID of CPU.
> >
> > Signed-off-by: Ethan Chen <ethan84@andestech.com>
> > ---
> >  docs/system/riscv/virt.rst |  5 +++
> >  hw/riscv/Kconfig           |  1 +
> >  hw/riscv/virt.c            | 63 ++++++++++++++++++++++++++++++++++++++
> >  include/hw/riscv/virt.h    |  5 ++-
> >  4 files changed, 73 insertions(+), 1 deletion(-)
> >
> > diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> > index 9a06f95a34..9fd006ccc2 100644
> > --- a/docs/system/riscv/virt.rst
> > +++ b/docs/system/riscv/virt.rst
> > @@ -116,6 +116,11 @@ The following machine-specific options are supported:
> >    having AIA IMSIC (i.e. "aia=aplic-imsic" selected). When not specified,
> >    the default number of per-HART VS-level AIA IMSIC pages is 0.
> >
> > +- iopmp=[on|off]
> > +
> > +  When this option is "on", an IOPMP device is added to machine. IOPMP checks
> > +  memory transcations in system memory. This option is assumed to be "off".
> 
> We probably should have a a little more here. You don't even mention
> that this is the rapid-k model.

I'll provide more details.

> 
> It might be worth adding a `model` field, to make it easier to add
> other models in the future. Thoughts?
>

I think the IOPMP model should be a device property and not 
configured here.

Thanks,
Ethan Chen

> Alistair
> 
> > +
> >  Running Linux kernel
> >  --------------------
> >
> > diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> > index a2030e3a6f..0b45a5ade2 100644
> > --- a/hw/riscv/Kconfig
> > +++ b/hw/riscv/Kconfig
> > @@ -56,6 +56,7 @@ config RISCV_VIRT
> >      select PLATFORM_BUS
> >      select ACPI
> >      select ACPI_PCI
> > +    select RISCV_IOPMP
> >
> >  config SHAKTI_C
> >      bool
> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > index bc0893e087..5a03c03c4a 100644
> > --- a/hw/riscv/virt.c
> > +++ b/hw/riscv/virt.c
> > @@ -55,6 +55,7 @@
> >  #include "hw/acpi/aml-build.h"
> >  #include "qapi/qapi-visit-common.h"
> >  #include "hw/virtio/virtio-iommu.h"
> > +#include "hw/misc/riscv_iopmp.h"
> >
> >  /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QEMU. */
> >  static bool virt_use_kvm_aia(RISCVVirtState *s)
> > @@ -82,6 +83,7 @@ static const MemMapEntry virt_memmap[] = {
> >      [VIRT_UART0] =        { 0x10000000,         0x100 },
> >      [VIRT_VIRTIO] =       { 0x10001000,        0x1000 },
> >      [VIRT_FW_CFG] =       { 0x10100000,          0x18 },
> > +    [VIRT_IOPMP] =        { 0x10200000,      0x100000 },
> >      [VIRT_FLASH] =        { 0x20000000,     0x4000000 },
> >      [VIRT_IMSIC_M] =      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
> >      [VIRT_IMSIC_S] =      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
> > @@ -90,6 +92,11 @@ static const MemMapEntry virt_memmap[] = {
> >      [VIRT_DRAM] =         { 0x80000000,           0x0 },
> >  };
> >
> > +static const MemMapEntry iopmp_protect_memmap[] = {
> > +    /* IOPMP protect all regions by default */
> > +    {0, 0xFFFFFFFF},
> > +};
> > +
> >  /* PCIe high mmio is fixed for RV32 */
> >  #define VIRT32_HIGH_PCIE_MMIO_BASE  0x300000000ULL
> >  #define VIRT32_HIGH_PCIE_MMIO_SIZE  (4 * GiB)
> > @@ -1024,6 +1031,24 @@ static void create_fdt_virtio_iommu(RISCVVirtState *s, uint16_t bdf)
> >                             bdf + 1, iommu_phandle, bdf + 1, 0xffff - bdf);
> >  }
> >
> > +static void create_fdt_iopmp(RISCVVirtState *s, const MemMapEntry *memmap,
> > +                             uint32_t irq_mmio_phandle) {
> > +    g_autofree char *name = NULL;
> > +    MachineState *ms = MACHINE(s);
> > +
> > +    name = g_strdup_printf("/soc/iopmp@%lx", (long)memmap[VIRT_IOPMP].base);
> > +    qemu_fdt_add_subnode(ms->fdt, name);
> > +    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "riscv_iopmp");
> > +    qemu_fdt_setprop_cells(ms->fdt, name, "reg", 0x0, memmap[VIRT_IOPMP].base,
> > +        0x0, memmap[VIRT_IOPMP].size);
> > +    qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent", irq_mmio_phandle);
> > +    if (s->aia_type == VIRT_AIA_TYPE_NONE) {
> > +        qemu_fdt_setprop_cell(ms->fdt, name, "interrupts", IOPMP_IRQ);
> > +    } else {
> > +        qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", IOPMP_IRQ, 0x4);
> > +    }
> > +}
> > +
> >  static void finalize_fdt(RISCVVirtState *s)
> >  {
> >      uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
> > @@ -1042,6 +1067,10 @@ static void finalize_fdt(RISCVVirtState *s)
> >      create_fdt_uart(s, virt_memmap, irq_mmio_phandle);
> >
> >      create_fdt_rtc(s, virt_memmap, irq_mmio_phandle);
> > +
> > +    if (s->have_iopmp) {
> > +        create_fdt_iopmp(s, virt_memmap, irq_mmio_phandle);
> > +    }
> >  }
> >
> >  static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
> > @@ -1425,6 +1454,7 @@ static void virt_machine_init(MachineState *machine)
> >      DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
> >      int i, base_hartid, hart_count;
> >      int socket_count = riscv_socket_count(machine);
> > +    int cpu, socket;
> >
> >      /* Check socket count limit */
> >      if (VIRT_SOCKETS_MAX < socket_count) {
> > @@ -1606,6 +1636,19 @@ static void virt_machine_init(MachineState *machine)
> >      }
> >      virt_flash_map(s, system_memory);
> >
> > +    if (s->have_iopmp) {
> > +        DeviceState *iopmp_dev = sysbus_create_simple(TYPE_IOPMP,
> > +            memmap[VIRT_IOPMP].base,
> > +            qdev_get_gpio_in(DEVICE(mmio_irqchip), IOPMP_IRQ));
> > +
> > +        for (socket = 0; socket < socket_count; socket++) {
> > +            for (cpu = s->soc[socket].num_harts - 1; cpu >= 0; cpu--) {
> > +                iopmp_setup_cpu(&s->soc[socket].harts[cpu], 0);
> > +            }
> > +        }
> > +        iopmp_setup_system_memory(iopmp_dev, iopmp_protect_memmap, 1);
> > +    }
> > +
> >      /* load/create device tree */
> >      if (machine->dtb) {
> >          machine->fdt = load_device_tree(machine->dtb, &s->fdt_size);
> > @@ -1702,6 +1745,20 @@ static void virt_set_aclint(Object *obj, bool value, Error **errp)
> >      s->have_aclint = value;
> >  }
> >
> > +static bool virt_get_iopmp(Object *obj, Error **errp)
> > +{
> > +    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
> > +
> > +    return s->have_iopmp;
> > +}
> > +
> > +static void virt_set_iopmp(Object *obj, bool value, Error **errp)
> > +{
> > +    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
> > +
> > +    s->have_iopmp = value;
> > +}
> > +
> >  bool virt_is_acpi_enabled(RISCVVirtState *s)
> >  {
> >      return s->acpi != ON_OFF_AUTO_OFF;
> > @@ -1814,6 +1871,12 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
> >                                NULL, NULL);
> >      object_class_property_set_description(oc, "acpi",
> >                                            "Enable ACPI");
> > +
> > +    object_class_property_add_bool(oc, "iopmp", virt_get_iopmp,
> > +                                   virt_set_iopmp);
> > +    object_class_property_set_description(oc, "iopmp",
> > +                                          "Set on/off to enable/disable "
> > +                                          "iopmp device");
> >  }
> >
> >  static const TypeInfo virt_machine_typeinfo = {
> > diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> > index c0dc41ff9a..009b4ebea7 100644
> > --- a/include/hw/riscv/virt.h
> > +++ b/include/hw/riscv/virt.h
> > @@ -55,6 +55,7 @@ struct RISCVVirtState {
> >
> >      int fdt_size;
> >      bool have_aclint;
> > +    bool have_iopmp;
> >      RISCVVirtAIAType aia_type;
> >      int aia_guests;
> >      char *oem_id;
> > @@ -84,12 +85,14 @@ enum {
> >      VIRT_PCIE_MMIO,
> >      VIRT_PCIE_PIO,
> >      VIRT_PLATFORM_BUS,
> > -    VIRT_PCIE_ECAM
> > +    VIRT_PCIE_ECAM,
> > +    VIRT_IOPMP,
> >  };
> >
> >  enum {
> >      UART0_IRQ = 10,
> >      RTC_IRQ = 11,
> > +    IOPMP_IRQ = 12,
> >      VIRTIO_IRQ = 1, /* 1 to 8 */
> >      VIRTIO_COUNT = 8,
> >      PCIE_IRQ = 0x20, /* 32 to 35 */
> > --
> > 2.34.1
> >
> >

