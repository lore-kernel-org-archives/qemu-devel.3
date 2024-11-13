Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A107D41C18
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 08:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tB91g-0001pE-90; Wed, 13 Nov 2024 03:47:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jpruiz84@gmail.com>)
 id 1tB91e-0001oo-EY
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 03:46:58 -0500
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jpruiz84@gmail.com>)
 id 1tB91b-00078X-RQ
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 03:46:58 -0500
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-50d3365c29cso420270e0c.0
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 00:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731487615; x=1732092415; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+IfjdgLpI8ScmfQxUlbtZcJaLTqvmUsnpEoMOVrYTc4=;
 b=hLUpN34itehNv2jg1YZszFsOJi2ol8JK4lScXQB055113v1PHpsb7ubGMm7UL7vwQg
 yyt2CeBp1NV3VM4Wzc4yPLgC94SAUBMz2ME5xbjBOube8b/7M3k34Zupv02QKKcPT0rK
 LzFpBq/5cXkodYdAyrRbCt+ZljwIM7ZHteEaCiPaZ9WYDDAhojtqtbMJwLct3CozT3Ar
 ibb/W068Hbziyi5p8/uD+rlZO846wsDHSBNOK/zDbfFHynm3dsM11mm32AikCWT0fwKc
 uyLdd2K1aaf5H8lgMQ211f38UzvcMbYsurae/tubrRQ0GsoUCMZ0+UH2heJIyr0o9chT
 qIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731487615; x=1732092415;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+IfjdgLpI8ScmfQxUlbtZcJaLTqvmUsnpEoMOVrYTc4=;
 b=qNJfOZ8MXMHBZ784y8Tpx5FOt1D6JaW2J9JcL6N8QyqKg4oF63UjTetUPxUgD+CpPT
 zBd+l9WltNwMjSOj0Rzf5dZ/UdtJA9+PNhgOmrYDN+RSSWrlAgNT4JDdbLjMw6Mf7iUh
 Zcufx2B6sVQAB2kbM4OZ1E2vgJO46O8TqSfNsKSgZiwrs6FKKaFZcKj0OsuK3NQgzZPc
 Sy9+fPxOMvi4yCt6PkZNKGjaqQY2Jq8WlwPy8CSoXIM20NsNToADiC48fk9P7OjRBCCL
 +MPXGCt0WJ0qi19qOyPJwZx7zA1voIus3p42Wx08tQKDoHBCsZ30MO7qIB1xnLEVWzW2
 UulQ==
X-Gm-Message-State: AOJu0Yx4osAj2lriHPFOZyFc4eUkRkfyqmrph03itICjRrxfPxoophZu
 gSwHE7KNT98JKBpcHA2e+hIOmirHql9hWIWm39dhJSBzpT6X7gN1Zx1/F5AcqIYRZzbbNB+tobN
 PE0wcfZdWduYO7Psl5rratjfC7IMVm3El
X-Google-Smtp-Source: AGHT+IF/MBfXKEzGIcrN+CGSmLjtZtKMI1fgLgHV5j6Acym+0jrCajkDA3f+TlE8PiB289ZoGhgwNQAfrfYt/mENfDY=
X-Received: by 2002:a05:6122:3c4f:b0:50d:4b8d:6750 with SMTP id
 71dfb90a1353d-51402523fdcmr13345127e0c.1.1731487614507; Wed, 13 Nov 2024
 00:46:54 -0800 (PST)
MIME-Version: 1.0
References: <20241112220212.2237-1-juanpablo.ruiz@unikie.com>
 <20241112164326.562406a9.alex.williamson@redhat.com>
In-Reply-To: <20241112164326.562406a9.alex.williamson@redhat.com>
From: Juan Pablo Ruiz <jpruiz84@gmail.com>
Date: Wed, 13 Nov 2024 10:46:42 +0200
Message-ID: <CAAuDais8P9Hf9XSMhXp=aNctT+ix5mjkwNMfQ5Kcv4oMSJysbQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] vfio/platform: Add mmio-base property to define start
 address for MMIO mapping
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Pablo Ruiz <juanpablo.ruiz@unikie.com>, 
 Auger Eric <eric.auger@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: multipart/mixed; boundary="00000000000032b3b60626c76086"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=jpruiz84@gmail.com; helo=mail-vk1-xa2e.google.com
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

--00000000000032b3b60626c76086
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 1:43=E2=80=AFAM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Tue, 12 Nov 2024 22:02:12 +0000
> Juan Pablo Ruiz <jpruiz84@gmail.com> wrote:
>
> > Some platform devices have large MMIO regions (e.g., GPU reserved memor=
y). For
> > certain devices, it's preferable to have a 1:1 address translation in t=
he VM to
> > avoid modifying driver source code.
>
> Why do we need 1:1 mappings?  Shouldn't the device tree describe where
> the device lives in the VM address space and the driver should adapt
> rather than use hard coded addresses?
>

For certain devices, especially those with large MMIO regions like GPU rese=
rved
memory, it's important to have 1:1 address translations to avoid extensive
modifications to the driver source code. In platforms like the NVIDIA Jetso=
n,
some drivers have not integrated the dma-ranges property from the device tr=
ee
to set DMA address translations. This means the drivers expect devices at f=
ixed
physical addresses. Using 1:1 mappings allows us to passthrough these devic=
es
without altering the drivers, facilitating scalability and ease of deployme=
nt.


> How does a user know which devices need fixed base addresses and what
> those addresses should be?
>

This is primarily only used to passthrough CMA regions that are required fo=
r DMA
opperatinos. For devices that do not require a specific address, users
can omit the
mmio-base parameter, and the platform bus will assign addresses automatical=
ly.
We can improve the documentation to help users determine when and how
to specify `mmio-base`.

> > This patch:
>
> ... should be split into at least 3 patches.
>

You're right; the patch should be split into separate commits for clarity:

- Patch 1: Increase the platform bus size.
- Patch 2: Change the `mmio_size` property from 32 to 64 bits.
- Patch 3: Add the `mmio-base` property.

> >
> > 1. Increases the VFIO platform bus size from 32MB to 130GB.
>
> That's a very strange and specific size.

The bus size increase to 130GB (actually 127GB or 130048MB) aligns the
platform bus's MMIO region with the VIRT_MEM region starting at
`0x2000000000`. This alignment is necessary to accommodate devices
with large MMIO requirements and to maintain a contiguous address space.


>
> > 2. Changes the mmio_size property from 32 to 64 bits.
> > 3. Adds an mmio-base property to define the starting MMIO address for m=
apping
> >    the VFIO device.
> >
> > Signed-off-by: Juan Pablo Ruiz juanpablo.ruiz@unikie.com
> > ---
> >  hw/arm/virt.c                   |  6 +++---
> >  hw/core/platform-bus.c          | 28 ++++++++++++++++++++++++++--
> >  hw/vfio/platform.c              |  1 +
> >  include/hw/platform-bus.h       |  2 +-
> >  include/hw/vfio/vfio-platform.h |  1 +
> >  5 files changed, 32 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 1a381e9a2b..9fc8f4425a 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -183,13 +183,13 @@ static const MemMapEntry base_memmap[] =3D {
> >      [VIRT_SECURE_GPIO] =3D        { 0x090b0000, 0x00001000 },
> >      [VIRT_MMIO] =3D               { 0x0a000000, 0x00000200 },
> >      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that=
 size */
> > -    [VIRT_PLATFORM_BUS] =3D       { 0x0c000000, 0x02000000 },
> > +    [VIRT_PLATFORM_BUS] =3D       { 0x60000000, 0x1FC0000000 },       =
   // 130048MB
> >      [VIRT_SECURE_MEM] =3D         { 0x0e000000, 0x01000000 },
> >      [VIRT_PCIE_MMIO] =3D          { 0x10000000, 0x2eff0000 },
> >      [VIRT_PCIE_PIO] =3D           { 0x3eff0000, 0x00010000 },
> >      [VIRT_PCIE_ECAM] =3D          { 0x3f000000, 0x01000000 },
> >      /* Actual RAM size depends on initial RAM and device memory settin=
gs */
> > -    [VIRT_MEM] =3D                { GiB, LEGACY_RAMLIMIT_BYTES },
> > +    [VIRT_MEM] =3D                { 0x2000000000, LEGACY_RAMLIMIT_BYTE=
S },
> >  };
> >
> >  /*
> > @@ -1625,7 +1625,7 @@ static void create_platform_bus(VirtMachineState =
*vms)
> >      dev =3D qdev_new(TYPE_PLATFORM_BUS_DEVICE);
> >      dev->id =3D g_strdup(TYPE_PLATFORM_BUS_DEVICE);
> >      qdev_prop_set_uint32(dev, "num_irqs", PLATFORM_BUS_NUM_IRQS);
> > -    qdev_prop_set_uint32(dev, "mmio_size", vms->memmap[VIRT_PLATFORM_B=
US].size);
> > +    qdev_prop_set_uint64(dev, "mmio_size", vms->memmap[VIRT_PLATFORM_B=
US].size);
> >      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> >      vms->platform_bus_dev =3D dev;
> >
> > diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
> > index dc58bf505a..f545fab6e5 100644
> > --- a/hw/core/platform-bus.c
> > +++ b/hw/core/platform-bus.c
> > @@ -22,6 +22,7 @@
> >  #include "qemu/osdep.h"
> >  #include "hw/platform-bus.h"
> >  #include "hw/qdev-properties.h"
> > +#include "hw/vfio/vfio-platform.h"
> >  #include "qapi/error.h"
> >  #include "qemu/error-report.h"
> >  #include "qemu/module.h"
> > @@ -130,11 +131,29 @@ static void platform_bus_map_mmio(PlatformBusDevi=
ce *pbus, SysBusDevice *sbdev,
> >                                    int n)
> >  {
> >      MemoryRegion *sbdev_mr =3D sysbus_mmio_get_region(sbdev, n);
> > +    VFIOPlatformDevice *vdev =3D VFIO_PLATFORM_DEVICE(sbdev);
>
> How do you know it's a vfio-platform device?  This completely breaks
> device abstraction.  Thanks,
>
> Alex
>
> >      uint64_t size =3D memory_region_size(sbdev_mr);
> >      uint64_t alignment =3D (1ULL << (63 - clz64(size + size - 1)));
> >      uint64_t off;
> > +    uint64_t mmio_base_off;
> >      bool found_region =3D false;
> >
> > +    if (vdev->mmio_base) {
> > +        if(vdev->mmio_base < pbus->mmio.addr ||
> > +           vdev->mmio_base >=3D pbus->mmio.addr + pbus->mmio_size){
> > +            error_report("Platform Bus: MMIO base 0x%"PRIx64
> > +                " outside platform bus region [0x%"PRIx64",0x%"PRIx64"=
]",
> > +                vdev->mmio_base,
> > +                pbus->mmio.addr,
> > +                pbus->mmio.addr + pbus->mmio_size);
> > +            exit(1);
> > +        }
> > +
> > +        mmio_base_off =3D vdev->mmio_base - pbus->mmio.addr;
> > +    } else {
> > +        mmio_base_off =3D 0;
> > +    }
> > +
> >      if (memory_region_is_mapped(sbdev_mr)) {
> >          /* Region is already mapped, nothing to do */
> >          return;
> > @@ -144,7 +163,7 @@ static void platform_bus_map_mmio(PlatformBusDevice=
 *pbus, SysBusDevice *sbdev,
> >       * Look for empty space in the MMIO space that is naturally aligne=
d with
> >       * the target device's memory region
> >       */
> > -    for (off =3D 0; off < pbus->mmio_size; off +=3D alignment) {
> > +    for (off =3D mmio_base_off; off < pbus->mmio_size; off +=3D alignm=
ent) {
> >          MemoryRegion *mr =3D memory_region_find(&pbus->mmio, off, size=
).mr;
> >          if (!mr) {
> >              found_region =3D true;
> > @@ -154,6 +173,11 @@ static void platform_bus_map_mmio(PlatformBusDevic=
e *pbus, SysBusDevice *sbdev,
> >          }
> >      }
> >
> > +    if (vdev->mmio_base && vdev->mmio_base !=3D off + pbus->mmio.addr)=
 {
> > +        warn_report("Platform Bus: Not able to map in mmio base: 0x%"P=
RIx64,
> > +            vdev->mmio_base);
> > +    }
> > +
> >      if (!found_region) {
> >          error_report("Platform Bus: Can not fit MMIO region of size %"=
PRIx64,
> >                       size);
> > @@ -206,7 +230,7 @@ static void platform_bus_realize(DeviceState *dev, =
Error **errp)
> >
> >  static Property platform_bus_properties[] =3D {
> >      DEFINE_PROP_UINT32("num_irqs", PlatformBusDevice, num_irqs, 0),
> > -    DEFINE_PROP_UINT32("mmio_size", PlatformBusDevice, mmio_size, 0),
> > +    DEFINE_PROP_UINT64("mmio_size", PlatformBusDevice, mmio_size, 0),
> >      DEFINE_PROP_END_OF_LIST()
> >  };
> >
> > diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> > index a85c199c76..cfac564093 100644
> > --- a/hw/vfio/platform.c
> > +++ b/hw/vfio/platform.c
> > @@ -640,6 +640,7 @@ static Property vfio_platform_dev_properties[] =3D =
{
> >      DEFINE_PROP_LINK("iommufd", VFIOPlatformDevice, vbasedev.iommufd,
> >                       TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
> >  #endif
> > +    DEFINE_PROP_UINT64("mmio-base", VFIOPlatformDevice, mmio_base, 0),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >
> > diff --git a/include/hw/platform-bus.h b/include/hw/platform-bus.h
> > index 44f30c5353..4e9913a5d7 100644
> > --- a/include/hw/platform-bus.h
> > +++ b/include/hw/platform-bus.h
> > @@ -34,7 +34,7 @@ struct PlatformBusDevice {
> >      SysBusDevice parent_obj;
> >
> >      /*< public >*/
> > -    uint32_t mmio_size;
> > +    uint64_t mmio_size;
> >      MemoryRegion mmio;
> >
> >      uint32_t num_irqs;
> > diff --git a/include/hw/vfio/vfio-platform.h b/include/hw/vfio/vfio-pla=
tform.h
> > index c414c3dffc..90575b5852 100644
> > --- a/include/hw/vfio/vfio-platform.h
> > +++ b/include/hw/vfio/vfio-platform.h
> > @@ -59,6 +59,7 @@ struct VFIOPlatformDevice {
> >      uint32_t mmap_timeout; /* delay to re-enable mmaps after interrupt=
 */
> >      QEMUTimer *mmap_timer; /* allows fast-path resume after IRQ hit */
> >      QemuMutex intp_mutex; /* protect the intp_list IRQ state */
> > +    uint64_t mmio_base; /* base address to start looking for mmio */
> >      bool irqfd_allowed; /* debug option to force irqfd on/off */
> >  };
> >  typedef struct VFIOPlatformDevice VFIOPlatformDevice;
>

Juan Pablo Ruiz Rosero




On Wed, Nov 13, 2024 at 1:43=E2=80=AFAM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Tue, 12 Nov 2024 22:02:12 +0000
> Juan Pablo Ruiz <jpruiz84@gmail.com> wrote:
>
> > Some platform devices have large MMIO regions (e.g., GPU reserved memor=
y). For
> > certain devices, it's preferable to have a 1:1 address translation in t=
he VM to
> > avoid modifying driver source code.
>
> Why do we need 1:1 mappings?  Shouldn't the device tree describe where
> the device lives in the VM address space and the driver should adapt
> rather than use hard coded addresses?
>
> How does a user know which devices need fixed base addresses and what
> those addresses should be?
>
> > This patch:
>
> ... should be split into at least 3 patches.
>
> >
> > 1. Increases the VFIO platform bus size from 32MB to 130GB.
>
> That's a very strange and specific size.
>
> > 2. Changes the mmio_size property from 32 to 64 bits.
> > 3. Adds an mmio-base property to define the starting MMIO address for m=
apping
> >    the VFIO device.
> >
> > Signed-off-by: Juan Pablo Ruiz juanpablo.ruiz@unikie.com
> > ---
> >  hw/arm/virt.c                   |  6 +++---
> >  hw/core/platform-bus.c          | 28 ++++++++++++++++++++++++++--
> >  hw/vfio/platform.c              |  1 +
> >  include/hw/platform-bus.h       |  2 +-
> >  include/hw/vfio/vfio-platform.h |  1 +
> >  5 files changed, 32 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 1a381e9a2b..9fc8f4425a 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -183,13 +183,13 @@ static const MemMapEntry base_memmap[] =3D {
> >      [VIRT_SECURE_GPIO] =3D        { 0x090b0000, 0x00001000 },
> >      [VIRT_MMIO] =3D               { 0x0a000000, 0x00000200 },
> >      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that=
 size */
> > -    [VIRT_PLATFORM_BUS] =3D       { 0x0c000000, 0x02000000 },
> > +    [VIRT_PLATFORM_BUS] =3D       { 0x60000000, 0x1FC0000000 },       =
   // 130048MB
> >      [VIRT_SECURE_MEM] =3D         { 0x0e000000, 0x01000000 },
> >      [VIRT_PCIE_MMIO] =3D          { 0x10000000, 0x2eff0000 },
> >      [VIRT_PCIE_PIO] =3D           { 0x3eff0000, 0x00010000 },
> >      [VIRT_PCIE_ECAM] =3D          { 0x3f000000, 0x01000000 },
> >      /* Actual RAM size depends on initial RAM and device memory settin=
gs */
> > -    [VIRT_MEM] =3D                { GiB, LEGACY_RAMLIMIT_BYTES },
> > +    [VIRT_MEM] =3D                { 0x2000000000, LEGACY_RAMLIMIT_BYTE=
S },
> >  };
> >
> >  /*
> > @@ -1625,7 +1625,7 @@ static void create_platform_bus(VirtMachineState =
*vms)
> >      dev =3D qdev_new(TYPE_PLATFORM_BUS_DEVICE);
> >      dev->id =3D g_strdup(TYPE_PLATFORM_BUS_DEVICE);
> >      qdev_prop_set_uint32(dev, "num_irqs", PLATFORM_BUS_NUM_IRQS);
> > -    qdev_prop_set_uint32(dev, "mmio_size", vms->memmap[VIRT_PLATFORM_B=
US].size);
> > +    qdev_prop_set_uint64(dev, "mmio_size", vms->memmap[VIRT_PLATFORM_B=
US].size);
> >      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> >      vms->platform_bus_dev =3D dev;
> >
> > diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
> > index dc58bf505a..f545fab6e5 100644
> > --- a/hw/core/platform-bus.c
> > +++ b/hw/core/platform-bus.c
> > @@ -22,6 +22,7 @@
> >  #include "qemu/osdep.h"
> >  #include "hw/platform-bus.h"
> >  #include "hw/qdev-properties.h"
> > +#include "hw/vfio/vfio-platform.h"
> >  #include "qapi/error.h"
> >  #include "qemu/error-report.h"
> >  #include "qemu/module.h"
> > @@ -130,11 +131,29 @@ static void platform_bus_map_mmio(PlatformBusDevi=
ce *pbus, SysBusDevice *sbdev,
> >                                    int n)
> >  {
> >      MemoryRegion *sbdev_mr =3D sysbus_mmio_get_region(sbdev, n);
> > +    VFIOPlatformDevice *vdev =3D VFIO_PLATFORM_DEVICE(sbdev);
>
> How do you know it's a vfio-platform device?  This completely breaks
> device abstraction.  Thanks,

Regarding your concern about breaking device abstraction by directly
casting `sbdev`
to `VFIOPlatformDevice`, I realize this is not ideal. I'll look into
alternative approaches.

Thanks for your comments

Juan Pablo
>
> Alex
>
> >      uint64_t size =3D memory_region_size(sbdev_mr);
> >      uint64_t alignment =3D (1ULL << (63 - clz64(size + size - 1)));
> >      uint64_t off;
> > +    uint64_t mmio_base_off;
> >      bool found_region =3D false;
> >
> > +    if (vdev->mmio_base) {
> > +        if(vdev->mmio_base < pbus->mmio.addr ||
> > +           vdev->mmio_base >=3D pbus->mmio.addr + pbus->mmio_size){
> > +            error_report("Platform Bus: MMIO base 0x%"PRIx64
> > +                " outside platform bus region [0x%"PRIx64",0x%"PRIx64"=
]",
> > +                vdev->mmio_base,
> > +                pbus->mmio.addr,
> > +                pbus->mmio.addr + pbus->mmio_size);
> > +            exit(1);
> > +        }
> > +
> > +        mmio_base_off =3D vdev->mmio_base - pbus->mmio.addr;
> > +    } else {
> > +        mmio_base_off =3D 0;
> > +    }
> > +
> >      if (memory_region_is_mapped(sbdev_mr)) {
> >          /* Region is already mapped, nothing to do */
> >          return;
> > @@ -144,7 +163,7 @@ static void platform_bus_map_mmio(PlatformBusDevice=
 *pbus, SysBusDevice *sbdev,
> >       * Look for empty space in the MMIO space that is naturally aligne=
d with
> >       * the target device's memory region
> >       */
> > -    for (off =3D 0; off < pbus->mmio_size; off +=3D alignment) {
> > +    for (off =3D mmio_base_off; off < pbus->mmio_size; off +=3D alignm=
ent) {
> >          MemoryRegion *mr =3D memory_region_find(&pbus->mmio, off, size=
).mr;
> >          if (!mr) {
> >              found_region =3D true;
> > @@ -154,6 +173,11 @@ static void platform_bus_map_mmio(PlatformBusDevic=
e *pbus, SysBusDevice *sbdev,
> >          }
> >      }
> >
> > +    if (vdev->mmio_base && vdev->mmio_base !=3D off + pbus->mmio.addr)=
 {
> > +        warn_report("Platform Bus: Not able to map in mmio base: 0x%"P=
RIx64,
> > +            vdev->mmio_base);
> > +    }
> > +
> >      if (!found_region) {
> >          error_report("Platform Bus: Can not fit MMIO region of size %"=
PRIx64,
> >                       size);
> > @@ -206,7 +230,7 @@ static void platform_bus_realize(DeviceState *dev, =
Error **errp)
> >
> >  static Property platform_bus_properties[] =3D {
> >      DEFINE_PROP_UINT32("num_irqs", PlatformBusDevice, num_irqs, 0),
> > -    DEFINE_PROP_UINT32("mmio_size", PlatformBusDevice, mmio_size, 0),
> > +    DEFINE_PROP_UINT64("mmio_size", PlatformBusDevice, mmio_size, 0),
> >      DEFINE_PROP_END_OF_LIST()
> >  };
> >
> > diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> > index a85c199c76..cfac564093 100644
> > --- a/hw/vfio/platform.c
> > +++ b/hw/vfio/platform.c
> > @@ -640,6 +640,7 @@ static Property vfio_platform_dev_properties[] =3D =
{
> >      DEFINE_PROP_LINK("iommufd", VFIOPlatformDevice, vbasedev.iommufd,
> >                       TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
> >  #endif
> > +    DEFINE_PROP_UINT64("mmio-base", VFIOPlatformDevice, mmio_base, 0),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >
> > diff --git a/include/hw/platform-bus.h b/include/hw/platform-bus.h
> > index 44f30c5353..4e9913a5d7 100644
> > --- a/include/hw/platform-bus.h
> > +++ b/include/hw/platform-bus.h
> > @@ -34,7 +34,7 @@ struct PlatformBusDevice {
> >      SysBusDevice parent_obj;
> >
> >      /*< public >*/
> > -    uint32_t mmio_size;
> > +    uint64_t mmio_size;
> >      MemoryRegion mmio;
> >
> >      uint32_t num_irqs;
> > diff --git a/include/hw/vfio/vfio-platform.h b/include/hw/vfio/vfio-pla=
tform.h
> > index c414c3dffc..90575b5852 100644
> > --- a/include/hw/vfio/vfio-platform.h
> > +++ b/include/hw/vfio/vfio-platform.h
> > @@ -59,6 +59,7 @@ struct VFIOPlatformDevice {
> >      uint32_t mmap_timeout; /* delay to re-enable mmaps after interrupt=
 */
> >      QEMUTimer *mmap_timer; /* allows fast-path resume after IRQ hit */
> >      QemuMutex intp_mutex; /* protect the intp_list IRQ state */
> > +    uint64_t mmio_base; /* base address to start looking for mmio */
> >      bool irqfd_allowed; /* debug option to force irqfd on/off */
> >  };
> >  typedef struct VFIOPlatformDevice VFIOPlatformDevice;
>

--00000000000032b3b60626c76086
Content-Type: image/png; name="image.png"
Content-Disposition: attachment; filename="image.png"
Content-Transfer-Encoding: base64
Content-ID: <f_m3fmdksw0>
X-Attachment-Id: f_m3fmdksw0

iVBORw0KGgoAAAANSUhEUgAAAJEAAAAVCAYAAABG+QztAAAElUlEQVR4nO2ZfUyUdQDHP3cHKHbc
XYmSbxQwlTRfmFLHFHnJkDdrwzeKS5mIL/MVGucQsPKFAJVCEi1TS5mpc6iHgDpnJW/W8mVmZeWg
bCJjbgFh4Bl3HXl5lOAOH8/W9vv8c7vn99nv+zy7757f73nOyWwBgUACTv/1CQj+/4gSCSTj8BK1
139Gbkoa20rPc82owkc7neSc9cz1UyPr4VzG+i85sDWfnUcquXSljpuugxkT+iqvr1nJtOGPPVCu
8KR5HTi2RG1fsW5qNNltOj6uKiGqby17l8SwaEot5jPFzPOW92CyWxxLCSOxYiL6DQcpDB+BsqGc
zQtfIzbwLAXVBhJ9FD3LFZ40z4oDS2TmRtHbvHtexSuGjcwYrrQc8yNh81sUD01g3Tun0eUH09vu
+WSo/FMoyU0ltJ/1IpQvkrp5BYbR6WRtOUN87gSc7c4VnjTPhgNL1Epl6ac095nMlEClrQruoYSN
k1NyvJQLt4PRKq5xQBeA7vPn2FW9nzhP692k9TyZLwSxtnkepRWbCNG4ELws7Z4UeT8P+snb+fqn
qxjpKJGduc7Ck+bZfgPHlaj9Fy7/2IJ8oDderp2Oy/vj7aXCXH2ZH26CVjOIGQW7+SIwkiVz8hh7
LJmRLo2cStWx9tuxrDmdaSlQ97un36pPc+62Ez4jfenVk1w34UnyNLYhx5XI3MSvTWZkbmqUpu8p
iAhh1ZVwdpRvxUOlRGZqorHJBBo5Mk0wmXvXcnZSBnGrx7Nv3PvEFzQStbOM5NH3WfBuVpOV/gkN
mimsTxxz52LszVUKT5Knse2LHs0jvtlEe7vJ8tGOqRul16gV7LHsa7Txkfi7/MHgBcV8EOeJors5
TXUULdax8RsPZhVuI96zi026HbnCk+45rkQyNY+rZZYbQxMtimdYeqKepX8NGClrbsEsV6NRd/7h
FQyJnkf0wENsrxvFzIRJPNHdKmZupDz9ZeYUNhOUc5IPZw3m7kz25gpPmtcJx5VIMQTfoUpMhhpq
W8HfzXrc1EBNbTOyIb4M6/xqx3SdoiUL+ahNy+RnL7JhTgaTy7MJVP27Sa1czJtJTM4VRqUf5WDS
GPo8SK7wpHmdcOBy5sqEyBBU+yo5UdHCzIg7O33zjVOcOGti0OwIxt7d4Ru5vGU2ifudiD90mPd8
jxATsAjdIn+q9sxg0N3i36amMJ6p+jM8lXQYwxsTUN9zt7I3V3jSPBsOLJEM95hUlucGk6NPIdwn
m6i+Nexd/iZlLmEUJAVZ3zWYaa5YTezKKp5OOcmmSHfLY/pcdmyvRDt9AbP9R1K2YgQullW5/ugy
oueXoFl4kJLsUNy7XO7szRWeNM+GYzfWvceTUWygT0o6eq0HOqMKL+10Co5nkmB962m6XsTiuFyu
BmygYnUASuuF9H8pj93J5whbFUuaXzk5k9ow5O/iu9ZbkB/Bk/n/jHJ+PptLlXqGKezLtff8hHcf
z4rDn84UA0LRF1ah72ZcPmAae342djHixsSsC/ye9fd3NfOPtzH/IeUK7+F4HYh/8QWSESUSSEaU
SCAZUSKBZESJBJL5E6cqGgzxpNf4AAAAAElFTkSuQmCC
--00000000000032b3b60626c76086--

