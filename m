Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D7AC5B543
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 03:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKTVv-0005rw-Bj; Wed, 28 May 2025 23:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uKTVs-0005rj-HW; Wed, 28 May 2025 23:01:00 -0400
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uKTVo-00007e-NM; Wed, 28 May 2025 23:01:00 -0400
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-4e5995828d1so282117137.0; 
 Wed, 28 May 2025 20:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748487652; x=1749092452; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D4zm5xNq3bF0Y+ZZZAMTuN2wiMYLAYyDg7Mjhgq7xUY=;
 b=PhnZOZ0fXUmpgGUQDQTQX8JhbQUL4oAs2gFyD2k3XPcKdVCLYUHwXpFu8AkKy6v7+5
 KbG5avDcPnADU9ShxxU7CxpLopWIDsFeEqQV6obcK/Quee/jzz+fVbbak9fGS2oM6gr+
 w6NOEMAEyTVt4SoYCapk69IvMFEQCZ+E0hUQy6S+K8ROX/80cMnf9zNF4N7LhOD2/fSu
 wwgFVxFLgzGyQTizOucQrBIWBtUFEkJWKi06FMQDgT6MzT2a0OCEq54xKUwQYql5WoT2
 WWDjToKnCbWNxursHv5BLxoC92bDDSbRJTCXeOXWsFr/GLfbiWGJdaFBvVwwmQjeTAtS
 beFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748487652; x=1749092452;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D4zm5xNq3bF0Y+ZZZAMTuN2wiMYLAYyDg7Mjhgq7xUY=;
 b=bzNd985K6ukDz3s7Dw00h3x2qyW32NuMWJacEz59qMCCGhumJOw9gzW+4RyFHgMHb8
 k4QB3uLsqIEkylcHpKQuMePlgKzUqVS2B3S0M9wiyhSgO3aCvhmE8GTygAJA480EyeVp
 aPiR9NUDVRzbwve71pqXAk3a5hVkMNGa+5ab8eRlXCUtuQUc4cjje6OtlQg1pZkKRQlA
 lGo8Cw3Na1vDpNBhENApJNfQqLU572vS/vDeJ9f+7Vka8RwcWe7zVOUiQ4YHmY2D6U2D
 xr/QscsaHwBj++uHKQeZikQoxdWKzHdX6se74iAl6opeotD7ZeK9eLVCGEdIGrWYEyVi
 jK+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtDxcDE7YcoGknIPoEe44LmBAQ2jK9xoiSQMenIfqHsXmJ7k+LpiCgCwkw6S5JojXkisIPUtQ0mkqN@nongnu.org
X-Gm-Message-State: AOJu0YzGf1PCyFWGiCAqlrImdmzOKTpfi1C+gvewkJX3KRdoBApqc3Pd
 hP+4/o1zHyzcesLbOxZWhpsEm3cl1yMcEc8+FZh6rOyDvJHqRX82EVzzkHH43HyWzRpmXSaxomH
 ri3Bqmy3h7hiM8S8pyF7aVdH1A8Y8T/I=
X-Gm-Gg: ASbGncsj/s2C9rGZSU1Kc5DSkvUcSLGzkf0ASTtV9yk97ekeq/r4K1kkPovROiNeh3Q
 UCw1qXCIZ2k1NRqztcQ8zq/R1f2dtfcbY4m6tDOgEIKzMjpdSvvZnBm7QUBSLxtNsYD9bI2J4T2
 eaU4jcI4mXAvXZ07maIBKT3dO8c03nr/dTs5vw1EbJhQYS848XWBffAzKZsrmqAqQ=
X-Google-Smtp-Source: AGHT+IGVWBHGGCe8kLJ+uZNTgWIQ+UyjA2VShRWEj4VwJvHaP/bUhsn9GdFr6aZKaN47GzuUaqojP1DkHhmPRhE8zCw=
X-Received: by 2002:a05:6102:1607:b0:4e2:82c3:661c with SMTP id
 ada2fe7eead31-4e686c7050cmr397240137.11.1748487652276; Wed, 28 May 2025
 20:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250312093735.1517740-1-ethan84@andestech.com>
 <20250312093735.1517740-9-ethan84@andestech.com>
 <CAKmqyKMwfjYbYeCNHdVcCcfEUQZyE12isetwmky0V9WbPjabJw@mail.gmail.com>
 <aDaplfE9HeBhfrk1@ethan84-VirtualBox>
In-Reply-To: <aDaplfE9HeBhfrk1@ethan84-VirtualBox>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 29 May 2025 13:00:25 +1000
X-Gm-Features: AX0GCFt2763qLYSTOOrRZaNGNh-P-dDAz01KGl1XxlFnikeRk9TWiSenqrHCykU
Message-ID: <CAKmqyKMCeeVxk3XDmB_+=f7eRN_EyB6G0FoUr6_G-PP_Lg8CHA@mail.gmail.com>
Subject: Re: [PATCH v11 8/8] hw/riscv/virt: Add IOPMP support
To: Ethan Chen <ethan84@andestech.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, peterx@redhat.com, 
 david@redhat.com, philmd@linaro.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, May 28, 2025 at 4:13=E2=80=AFPM Ethan Chen <ethan84@andestech.com> =
wrote:
>
> On Thu, May 22, 2025 at 11:24:28AM +1000, Alistair Francis wrote:
> > [EXTERNAL MAIL]
> >
> > On Wed, Mar 12, 2025 at 7:43=E2=80=AFPM Ethan Chen via <qemu-devel@nong=
nu.org> wrote:
> > >
> > > - Add 'iopmp=3Don' option to enable IOPMP. It adds iopmp devices virt=
 machine
> > >   to protect all regions of system memory.
> > >
> > > Signed-off-by: Ethan Chen <ethan84@andestech.com>
> > > ---
> > >  docs/specs/index.rst       |  1 +
> > >  docs/specs/riscv-iopmp.rst | 60 ++++++++++++++++++++++++++++++
> > >  docs/system/riscv/virt.rst |  9 +++++
> > >  hw/riscv/Kconfig           |  1 +
> > >  hw/riscv/virt.c            | 75 ++++++++++++++++++++++++++++++++++++=
++
> > >  include/hw/riscv/virt.h    |  3 ++
> > >  6 files changed, 149 insertions(+)
> > >  create mode 100644 docs/specs/riscv-iopmp.rst
> > >
> > > diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> > > index f19d73c9f6..0871c17b8f 100644
> > > --- a/docs/specs/index.rst
> > > +++ b/docs/specs/index.rst
> > > @@ -39,3 +39,4 @@ guest hardware that is specific to QEMU.
> > >     riscv-iommu
> > >     riscv-aia
> > >     aspeed-intc
> > > +   riscv-iopmp
> > > diff --git a/docs/specs/riscv-iopmp.rst b/docs/specs/riscv-iopmp.rst
> > > new file mode 100644
> > > index 0000000000..36a395e552
> > > --- /dev/null
> > > +++ b/docs/specs/riscv-iopmp.rst
> > > @@ -0,0 +1,60 @@
> > > +.. _riscv-iopmp:
> > > +
> > > +RISC-V IOPMP support for RISC-V machines
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +IOPMP support is based on `IOPMP specification version 0.7`_. The de=
vice is
> > > +available on the RISC-V virt machine but is disabled by default. To =
enable
> > > +iopmp device, use the 'iopmp' machine option
> > > +
> > > +.. code-block:: bash
> > > +
> > > +  $ qemu-system-riscv64 -M virt,iopmp=3Don
> > > +
> > > +On the virt board, the number of IOPMP device is fixed at 1, and its=
 protect
> > > +region is fixed to 0x0~0xFFFFFFFF.
> > > +
> > > +To configure IOPMP device, modify gloal driver property
> > > +
> > > +.. code-block:: bash
> > > +
> > > +  -global driver=3Driscv_iopmp, property=3D<property>, value=3D<valu=
e>
> > > +
> > > +Below are the IOPMP device properties and their default values:
> > > +
> > > +- mdcfg_fmt: 1 (Options: 0/1/2)
> > > +- srcmd_fmt: 0 (Options: 0/1/2)
> > > +- tor_en: true (Options: true/false)
> > > +- sps_en: false (Options: true/false)
> > > +- prient_prog: true (Options: true/false)
> > > +- rrid_transl_en: false (Options: true/false)
> > > +- rrid_transl_prog: false (Options: true/false)
> > > +- chk_x: true (Options: true/false)
> > > +- no_x: false (Options: true/false)
> > > +- no_w: false (Options: true/false)
> > > +- stall_en: false (Options: true/false)
> > > +- peis: true (Options: true/false)
> > > +- pees: true (Options: true/false)
> > > +- mfr_en: true (Options: true/false)
> > > +- md_entry_num: 5 (IMP: Valid only for mdcfg_fmt 1/2)
> > > +- md_num: 8 (Range: 0-63)
> > > +- rrid_num: 16 (Range: srcmd_fmt =E2=89=A0 2: 0-65535, srcmd_fmt =3D=
 2: 0-32)
> > > +- entry_num: 48 (Range: 0-IMP. For mdcfg_fmt =3D 1,
> > > +  it is fixed as md_num * (md_entry_num + 1).
> > > +  Entry registers must not overlap with other registers.)
> > > +- prio_entry: 65535 (Range: 0-IMP. If prio_entry > entry_num,
> > > +  it will be set to entry_num.)
> > > +- rrid_transl: 0x0 (Range: 0-65535)
> > > +- entry_offset: 0x4000 (IMP: Entry registers must not overlap
> > > +  with other registers.)
> > > +- err_rdata: 0x0 (uint32. Specifies the value used in responses to
> > > +  read transactions when errors are suppressed)
> > > +- msi_en: false (Options: true/false)
> > > +- msidata: 12 (Range: 1-1023)
> > > +- stall_violation_en: true (Options: true/false)
> > > +- err_msiaddr: 0x24000000 (lower-part 32-bit address)
> > > +- err_msiaddrh: 0x0 (higher-part 32-bit address)
> > > +- msi_rrid: 0 (Range: 0-65535. Specifies the rrid used by the IOPMP =
to send
> > > +  the MSI.)
> >
> > I'm not sure this is clear to a user, what are people supposed to do
> > with all these values?
> >
> > Alistair
>
> These parameters are defined by the IOPMP specification and are intended
> for hardware designers. By adjusting these values, designers can modify
> the mapping model between IOPMP tables and rules, configure support for
> specific features, control the response to rule violations, and optimize
> trade-offs such as gate count and latency to meet their design
> objectives.

I think we should say that then

Alistair

>
> QEMU supports user-defined configuration of these parameters to accuratel=
y
> replicate the behavior of the target hardware.
>
> Ethan Chen
>
> >
> > > +
> > > +.. _IOPMP specification version 0.7: https://github.com/riscv-non-is=
a/iopmp-spec/releases/download/v0.7/iopmp-v0.7.pdf
> > > diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> > > index 60850970ce..77c8d386d5 100644
> > > --- a/docs/system/riscv/virt.rst
> > > +++ b/docs/system/riscv/virt.rst
> > > @@ -146,6 +146,15 @@ The following machine-specific options are suppo=
rted:
> > >
> > >    Enables the riscv-iommu-sys platform device. Defaults to 'off'.
> > >
> > > +- iopmp=3D[on|off]
> > > +
> > > +  When this option is "on", IOPMP devices are added to machine. IOPM=
P checks
> > > +  memory transcations in system memory. This option is assumed to be=
 "off". To
> > > +  enable the CPU to perform transactions with a specified RRID, use =
the CPU
> > > +  option "-cpu <cpu>,iopmp=3Dtrue,iopmp_rrid=3D<rrid>"
> > > +
> > > +  See :ref:`riscv-iopmp` for configurations of IOPMP
> > > +
> > >  Running Linux kernel
> > >  --------------------
> > >
> > > diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> > > index e6a0ac1fa1..637438af2c 100644
> > > --- a/hw/riscv/Kconfig
> > > +++ b/hw/riscv/Kconfig
> > > @@ -68,6 +68,7 @@ config RISCV_VIRT
> > >      select PLATFORM_BUS
> > >      select ACPI
> > >      select ACPI_PCI
> > > +    select RISCV_IOPMP
> > >
> > >  config SHAKTI_C
> > >      bool
> > > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > > index dae46f4733..0d62e7786c 100644
> > > --- a/hw/riscv/virt.c
> > > +++ b/hw/riscv/virt.c
> > > @@ -57,6 +57,8 @@
> > >  #include "hw/acpi/aml-build.h"
> > >  #include "qapi/qapi-visit-common.h"
> > >  #include "hw/virtio/virtio-iommu.h"
> > > +#include "hw/misc/riscv_iopmp.h"
> > > +#include "hw/misc/riscv_iopmp_dispatcher.h"
> > >
> > >  /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated b=
y QEMU. */
> > >  static bool virt_use_kvm_aia_aplic_imsic(RISCVVirtAIAType aia_type)
> > > @@ -94,6 +96,7 @@ static const MemMapEntry virt_memmap[] =3D {
> > >      [VIRT_UART0] =3D        { 0x10000000,         0x100 },
> > >      [VIRT_VIRTIO] =3D       { 0x10001000,        0x1000 },
> > >      [VIRT_FW_CFG] =3D       { 0x10100000,          0x18 },
> > > +    [VIRT_IOPMP] =3D        { 0x10200000,      0x100000 },
> > >      [VIRT_FLASH] =3D        { 0x20000000,     0x4000000 },
> > >      [VIRT_IMSIC_M] =3D      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
> > >      [VIRT_IMSIC_S] =3D      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
> > > @@ -102,6 +105,11 @@ static const MemMapEntry virt_memmap[] =3D {
> > >      [VIRT_DRAM] =3D         { 0x80000000,           0x0 },
> > >  };
> > >
> > > +static const MemMapEntry iopmp_protect_memmap[] =3D {
> > > +    /* IOPMP protect all regions by default */
> > > +    {0x0, 0xFFFFFFFF},
> > > +};
> > > +
> > >  /* PCIe high mmio is fixed for RV32 */
> > >  #define VIRT32_HIGH_PCIE_MMIO_BASE  0x300000000ULL
> > >  #define VIRT32_HIGH_PCIE_MMIO_SIZE  (4 * GiB)
> > > @@ -1118,6 +1126,24 @@ static void create_fdt_iommu(RISCVVirtState *s=
, uint16_t bdf)
> > >                             bdf + 1, iommu_phandle, bdf + 1, 0xffff -=
 bdf);
> > >  }
> > >
> > > +static void create_fdt_iopmp(RISCVVirtState *s, const MemMapEntry *m=
emmap,
> > > +                             uint32_t irq_mmio_phandle) {
> > > +    g_autofree char *name =3D NULL;
> > > +    MachineState *ms =3D MACHINE(s);
> > > +
> > > +    name =3D g_strdup_printf("/soc/iopmp@%lx", (long)memmap[VIRT_IOP=
MP].base);
> > > +    qemu_fdt_add_subnode(ms->fdt, name);
> > > +    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "riscv_iopm=
p");
> > > +    qemu_fdt_setprop_cells(ms->fdt, name, "reg", 0x0, memmap[VIRT_IO=
PMP].base,
> > > +        0x0, memmap[VIRT_IOPMP].size);
> > > +    qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent", irq_mmi=
o_phandle);
> > > +    if (s->aia_type =3D=3D VIRT_AIA_TYPE_NONE) {
> > > +        qemu_fdt_setprop_cell(ms->fdt, name, "interrupts", IOPMP_IRQ=
);
> > > +    } else {
> > > +        qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", IOPMP_IR=
Q, 0x4);
> > > +    }
> > > +}
> > > +
> > >  static void finalize_fdt(RISCVVirtState *s)
> > >  {
> > >      uint32_t phandle =3D 1, irq_mmio_phandle =3D 1, msi_pcie_phandle=
 =3D 1;
> > > @@ -1142,6 +1168,10 @@ static void finalize_fdt(RISCVVirtState *s)
> > >      create_fdt_uart(s, virt_memmap, irq_mmio_phandle);
> > >
> > >      create_fdt_rtc(s, virt_memmap, irq_mmio_phandle);
> > > +
> > > +    if (s->have_iopmp) {
> > > +        create_fdt_iopmp(s, virt_memmap, irq_mmio_phandle);
> > > +    }
> > >  }
> > >
> > >  static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
> > > @@ -1532,6 +1562,8 @@ static void virt_machine_init(MachineState *mac=
hine)
> > >      DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
> > >      int i, base_hartid, hart_count;
> > >      int socket_count =3D riscv_socket_count(machine);
> > > +    DeviceState *iopmp_dev, *iopmp_disp_dev;
> > > +    StreamSink *iopmp_ss, *iopmp_disp_ss;
> > >
> > >      /* Check socket count limit */
> > >      if (VIRT_SOCKETS_MAX < socket_count) {
> > > @@ -1713,6 +1745,29 @@ static void virt_machine_init(MachineState *ma=
chine)
> > >      }
> > >      virt_flash_map(s, system_memory);
> > >
> > > +    if (s->have_iopmp) {
> > > +        iopmp_dev =3D iopmp_create(memmap[VIRT_IOPMP].base,
> > > +            qdev_get_gpio_in(DEVICE(mmio_irqchip), IOPMP_IRQ));
> > > +
> > > +        iopmp_setup_system_memory(iopmp_dev, &iopmp_protect_memmap[0=
], 1, 0);
> > > +
> > > +        iopmp_disp_dev =3D qdev_new(TYPE_RISCV_IOPMP_DISP);
> > > +        qdev_prop_set_uint32(DEVICE(iopmp_disp_dev), "target-num", 1=
);
> > > +        qdev_prop_set_uint32(DEVICE(iopmp_disp_dev), "stage-num", 1)=
;
> > > +        qdev_realize(DEVICE(iopmp_disp_dev), NULL, &error_fatal);
> > > +
> > > +        /* Add memmap inforamtion to dispatcher */
> > > +        iopmp_ss =3D (StreamSink *)&(RISCV_IOPMP(iopmp_dev)->txn_inf=
o_sink);
> > > +        iopmp_dispatcher_add_target(DEVICE(iopmp_disp_dev), iopmp_ss=
,
> > > +                                    iopmp_protect_memmap[0].base,
> > > +                                    iopmp_protect_memmap[0].size,
> > > +                                    0, 0);
> > > +
> > > +        iopmp_disp_ss =3D
> > > +            (StreamSink *)&(RISCV_IOPMP_DISP(iopmp_disp_dev)->txn_in=
fo_sink);
> > > +        iopmp_setup_sink(iopmp_dev, iopmp_disp_ss);
> > > +    }
> > > +
> > >      /* load/create device tree */
> > >      if (machine->dtb) {
> > >          machine->fdt =3D load_device_tree(machine->dtb, &s->fdt_size=
);
> > > @@ -1848,6 +1903,20 @@ static void virt_set_iommu_sys(Object *obj, Vi=
sitor *v, const char *name,
> > >      visit_type_OnOffAuto(v, name, &s->iommu_sys, errp);
> > >  }
> > >
> > > +static bool virt_get_iopmp(Object *obj, Error **errp)
> > > +{
> > > +    RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
> > > +
> > > +    return s->have_iopmp;
> > > +}
> > > +
> > > +static void virt_set_iopmp(Object *obj, bool value, Error **errp)
> > > +{
> > > +    RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
> > > +
> > > +    s->have_iopmp =3D value;
> > > +}
> > > +
> > >  bool virt_is_acpi_enabled(RISCVVirtState *s)
> > >  {
> > >      return s->acpi !=3D ON_OFF_AUTO_OFF;
> > > @@ -1975,6 +2044,12 @@ static void virt_machine_class_init(ObjectClas=
s *oc, void *data)
> > >                                NULL, NULL);
> > >      object_class_property_set_description(oc, "iommu-sys",
> > >                                            "Enable IOMMU platform dev=
ice");
> > > +
> > > +    object_class_property_add_bool(oc, "iopmp", virt_get_iopmp,
> > > +                                   virt_set_iopmp);
> > > +    object_class_property_set_description(oc, "iopmp",
> > > +                                          "Set on/off to enable/disa=
ble "
> > > +                                          "iopmp device");
> > >  }
> > >
> > >  static const TypeInfo virt_machine_typeinfo =3D {
> > > diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> > > index 48a14bea2e..cf1e5bd872 100644
> > > --- a/include/hw/riscv/virt.h
> > > +++ b/include/hw/riscv/virt.h
> > > @@ -55,6 +55,7 @@ struct RISCVVirtState {
> > >
> > >      int fdt_size;
> > >      bool have_aclint;
> > > +    bool have_iopmp;
> > >      RISCVVirtAIAType aia_type;
> > >      int aia_guests;
> > >      char *oem_id;
> > > @@ -87,11 +88,13 @@ enum {
> > >      VIRT_PLATFORM_BUS,
> > >      VIRT_PCIE_ECAM,
> > >      VIRT_IOMMU_SYS,
> > > +    VIRT_IOPMP,
> > >  };
> > >
> > >  enum {
> > >      UART0_IRQ =3D 10,
> > >      RTC_IRQ =3D 11,
> > > +    IOPMP_IRQ =3D 12,
> > >      VIRTIO_IRQ =3D 1, /* 1 to 8 */
> > >      VIRTIO_COUNT =3D 8,
> > >      PCIE_IRQ =3D 0x20, /* 32 to 35 */
> > > --
> > > 2.34.1
> > >
> > >

