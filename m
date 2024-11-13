Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84D7D41C1E
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 09:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tB9O7-0006F6-6o; Wed, 13 Nov 2024 04:10:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jpruiz84@gmail.com>)
 id 1tB9Nz-0006Ef-Rq
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 04:10:04 -0500
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jpruiz84@gmail.com>)
 id 1tB9Nx-0001Ea-IM
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 04:10:03 -0500
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-85019a60523so2377027241.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 01:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731489000; x=1732093800; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p1COyPSdnkPLZJIB0Ti8GsPzSQ5wWmOJkVkEXrkbiRM=;
 b=fpJimMKjy6EYCxa9JB1TBKbvkuzGcrf37UWKQMoX3uPlVqBLALVGpq7nJiSRx4ZNqL
 Q1emb1Ji7wqGy4dV9TJC6vf/KqeOVX+DHQVvvNDy5rq13JPwOhZC1d0prR7iQXNqrM7t
 3QBBXX+t9tP+juKB+yWSfLW0Umpt/ubvk9sYervXb91AVCYeq9zvR+eQzKcFs12vwD3J
 q9xdduXVY/nl8vMh/ctBAqMklnZezhM1B2vTJhCErDwms0nZYexhhzh8cvmHKwkaKiLq
 K0U4+KBZsrfQkzUu9srhC137bnCk6j9KpsTLRzNFIdUEHs9Wqy/c5EGdFglT6O0n8BwX
 dBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731489000; x=1732093800;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p1COyPSdnkPLZJIB0Ti8GsPzSQ5wWmOJkVkEXrkbiRM=;
 b=KAvyNo259eI9fxNUnQgdequElJc08DxBGnCo7fbMKw3eGndBQBRRTrCCTu2RJ45//v
 EZTPeZ9PIK1662yg43dvWNlymZ+9q0dOyYs3uJrsQ26r4ViAikwIcMZf11zkKLNs4v9u
 7y5VG3zdLgdrPQLF4LVhrN7NLE1Rof/FeTAUEaDyOGBk8iIHHEHjvFuJvMOu/VMBrhU/
 eKab9LTe6uYkxpAUwpaKvncdW91J5x0VsSnc6Lqpli8cwaHGwzr3gLM9ZOt5S+2G8pEJ
 I0qwKl7fGl7W7dM32TbUXXVzkuwfhJQ7K9dFSAJsUVYeQvVUrMkOkpdwTEWpuqxxBRKM
 gLDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV64Z+hXhHXVUcM61kk0Tvic6LRdTcUmRlojByd2W+0DqH3fsmbpFh6Bl5y6MMMeLZHf3XgaNdn/ISq@nongnu.org
X-Gm-Message-State: AOJu0YwYT9CqIgrv6BpcmeEQAgkETAId/iD2/VsO85Uu8M5t4zZ0ei2G
 +53dbcvZmA6AHnPmOY9ikzc4b0zL6CyKwellXne/PFKLZFkkawGbv+SeiQ1IwDsoXg4peSPQaap
 vSmfIMXB2EQSNOOqpR1ZXR8S1BT8=
X-Google-Smtp-Source: AGHT+IFq2FG7h27L9Wxkxq2DFd4Xx8YP96ANPxr2UXnZe1NSrYSvbiNs67TlqV41R1hz7bE+dXsxSe8WK6i+81H6iQY=
X-Received: by 2002:a05:6102:5f78:b0:4ad:4c67:48ec with SMTP id
 ada2fe7eead31-4ad4c674998mr725643137.14.1731489000245; Wed, 13 Nov 2024
 01:10:00 -0800 (PST)
MIME-Version: 1.0
References: <20241112220212.2237-1-juanpablo.ruiz@unikie.com>
 <20241112164326.562406a9.alex.williamson@redhat.com>
 <7d31a829-52b2-4ae0-9406-c5ffecd764d0@redhat.com>
In-Reply-To: <7d31a829-52b2-4ae0-9406-c5ffecd764d0@redhat.com>
From: Juan Pablo Ruiz <jpruiz84@gmail.com>
Date: Wed, 13 Nov 2024 11:09:49 +0200
Message-ID: <CAAuDaisAq=cBxb52FfQYTqc=u9CwVtC7jiwGu-rGpxJvceW=2g@mail.gmail.com>
Subject: Re: [PATCH 1/1] vfio/platform: Add mmio-base property to define start
 address for MMIO mapping
To: eric.auger@redhat.com
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, 
 Juan Pablo Ruiz <juanpablo.ruiz@unikie.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=jpruiz84@gmail.com; helo=mail-ua1-x933.google.com
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

On Wed, Nov 13, 2024 at 10:57=E2=80=AFAM Eric Auger <eric.auger@redhat.com>=
 wrote:
>
> Hi Juan Pablo,
>
> On 11/13/24 00:43, Alex Williamson wrote:
> > On Tue, 12 Nov 2024 22:02:12 +0000
> > Juan Pablo Ruiz <jpruiz84@gmail.com> wrote:
> >
> >> Some platform devices have large MMIO regions (e.g., GPU reserved memo=
ry). For
> >> certain devices, it's preferable to have a 1:1 address translation in =
the VM to
> >> avoid modifying driver source code.
> > Why do we need 1:1 mappings?  Shouldn't the device tree describe where
> > the device lives in the VM address space and the driver should adapt
> > rather than use hard coded addresses?
> >
> > How does a user know which devices need fixed base addresses and what
> > those addresses should be?
> >
> >> This patch:
> > ... should be split into at least 3 patches.
> >
> >> 1. Increases the VFIO platform bus size from 32MB to 130GB.
> > That's a very strange and specific size.
> >
> >> 2. Changes the mmio_size property from 32 to 64 bits.
> >> 3. Adds an mmio-base property to define the starting MMIO address for =
mapping
> >>    the VFIO device.
> >>
> >> Signed-off-by: Juan Pablo Ruiz juanpablo.ruiz@unikie.com
> >> ---
> >>  hw/arm/virt.c                   |  6 +++---
> >>  hw/core/platform-bus.c          | 28 ++++++++++++++++++++++++++--
> >>  hw/vfio/platform.c              |  1 +
> >>  include/hw/platform-bus.h       |  2 +-
> >>  include/hw/vfio/vfio-platform.h |  1 +
> >>  5 files changed, 32 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> >> index 1a381e9a2b..9fc8f4425a 100644
> >> --- a/hw/arm/virt.c
> >> +++ b/hw/arm/virt.c
> >> @@ -183,13 +183,13 @@ static const MemMapEntry base_memmap[] =3D {
> >>      [VIRT_SECURE_GPIO] =3D        { 0x090b0000, 0x00001000 },
> >>      [VIRT_MMIO] =3D               { 0x0a000000, 0x00000200 },
> >>      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of tha=
t size */
> >> -    [VIRT_PLATFORM_BUS] =3D       { 0x0c000000, 0x02000000 },
> >> +    [VIRT_PLATFORM_BUS] =3D       { 0x60000000, 0x1FC0000000 },      =
    // 130048MB
> >>      [VIRT_SECURE_MEM] =3D         { 0x0e000000, 0x01000000 },
> >>      [VIRT_PCIE_MMIO] =3D          { 0x10000000, 0x2eff0000 },
> >>      [VIRT_PCIE_PIO] =3D           { 0x3eff0000, 0x00010000 },
> >>      [VIRT_PCIE_ECAM] =3D          { 0x3f000000, 0x01000000 },
> >>      /* Actual RAM size depends on initial RAM and device memory setti=
ngs */
> >> -    [VIRT_MEM] =3D                { GiB, LEGACY_RAMLIMIT_BYTES },
> >> +    [VIRT_MEM] =3D                { 0x2000000000, LEGACY_RAMLIMIT_BYT=
ES },
> This won't be accepted. We had this discussion in the past with Peter
> (added in cc) and it is not possible to change the inital RAM layout
> like that.
>
> Thanks
>
> Eric

Thanks Eric, I will use another approach. I will try with the new SMMUv3 ne=
sted
translation support for DMA operations of passthrough platform GPUs.

Juan Pablo

> >>  };
> >>
> >>  /*
> >> @@ -1625,7 +1625,7 @@ static void create_platform_bus(VirtMachineState=
 *vms)
> >>      dev =3D qdev_new(TYPE_PLATFORM_BUS_DEVICE);
> >>      dev->id =3D g_strdup(TYPE_PLATFORM_BUS_DEVICE);
> >>      qdev_prop_set_uint32(dev, "num_irqs", PLATFORM_BUS_NUM_IRQS);
> >> -    qdev_prop_set_uint32(dev, "mmio_size", vms->memmap[VIRT_PLATFORM_=
BUS].size);
> >> +    qdev_prop_set_uint64(dev, "mmio_size", vms->memmap[VIRT_PLATFORM_=
BUS].size);
> >>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> >>      vms->platform_bus_dev =3D dev;
> >>
> >> diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
> >> index dc58bf505a..f545fab6e5 100644
> >> --- a/hw/core/platform-bus.c
> >> +++ b/hw/core/platform-bus.c
> >> @@ -22,6 +22,7 @@
> >>  #include "qemu/osdep.h"
> >>  #include "hw/platform-bus.h"
> >>  #include "hw/qdev-properties.h"
> >> +#include "hw/vfio/vfio-platform.h"
> >>  #include "qapi/error.h"
> >>  #include "qemu/error-report.h"
> >>  #include "qemu/module.h"
> >> @@ -130,11 +131,29 @@ static void platform_bus_map_mmio(PlatformBusDev=
ice *pbus, SysBusDevice *sbdev,
> >>                                    int n)
> >>  {
> >>      MemoryRegion *sbdev_mr =3D sysbus_mmio_get_region(sbdev, n);
> >> +    VFIOPlatformDevice *vdev =3D VFIO_PLATFORM_DEVICE(sbdev);
> > How do you know it's a vfio-platform device?  This completely breaks
> > device abstraction.  Thanks,
> >
> > Alex
> >
> >>      uint64_t size =3D memory_region_size(sbdev_mr);
> >>      uint64_t alignment =3D (1ULL << (63 - clz64(size + size - 1)));
> >>      uint64_t off;
> >> +    uint64_t mmio_base_off;
> >>      bool found_region =3D false;
> >>
> >> +    if (vdev->mmio_base) {
> >> +        if(vdev->mmio_base < pbus->mmio.addr ||
> >> +           vdev->mmio_base >=3D pbus->mmio.addr + pbus->mmio_size){
> >> +            error_report("Platform Bus: MMIO base 0x%"PRIx64
> >> +                " outside platform bus region [0x%"PRIx64",0x%"PRIx64=
"]",
> >> +                vdev->mmio_base,
> >> +                pbus->mmio.addr,
> >> +                pbus->mmio.addr + pbus->mmio_size);
> >> +            exit(1);
> >> +        }
> >> +
> >> +        mmio_base_off =3D vdev->mmio_base - pbus->mmio.addr;
> >> +    } else {
> >> +        mmio_base_off =3D 0;
> >> +    }
> >> +
> >>      if (memory_region_is_mapped(sbdev_mr)) {
> >>          /* Region is already mapped, nothing to do */
> >>          return;
> >> @@ -144,7 +163,7 @@ static void platform_bus_map_mmio(PlatformBusDevic=
e *pbus, SysBusDevice *sbdev,
> >>       * Look for empty space in the MMIO space that is naturally align=
ed with
> >>       * the target device's memory region
> >>       */
> >> -    for (off =3D 0; off < pbus->mmio_size; off +=3D alignment) {
> >> +    for (off =3D mmio_base_off; off < pbus->mmio_size; off +=3D align=
ment) {
> >>          MemoryRegion *mr =3D memory_region_find(&pbus->mmio, off, siz=
e).mr;
> >>          if (!mr) {
> >>              found_region =3D true;
> >> @@ -154,6 +173,11 @@ static void platform_bus_map_mmio(PlatformBusDevi=
ce *pbus, SysBusDevice *sbdev,
> >>          }
> >>      }
> >>
> >> +    if (vdev->mmio_base && vdev->mmio_base !=3D off + pbus->mmio.addr=
) {
> >> +        warn_report("Platform Bus: Not able to map in mmio base: 0x%"=
PRIx64,
> >> +            vdev->mmio_base);
> >> +    }
> >> +
> >>      if (!found_region) {
> >>          error_report("Platform Bus: Can not fit MMIO region of size %=
"PRIx64,
> >>                       size);
> >> @@ -206,7 +230,7 @@ static void platform_bus_realize(DeviceState *dev,=
 Error **errp)
> >>
> >>  static Property platform_bus_properties[] =3D {
> >>      DEFINE_PROP_UINT32("num_irqs", PlatformBusDevice, num_irqs, 0),
> >> -    DEFINE_PROP_UINT32("mmio_size", PlatformBusDevice, mmio_size, 0),
> >> +    DEFINE_PROP_UINT64("mmio_size", PlatformBusDevice, mmio_size, 0),
> >>      DEFINE_PROP_END_OF_LIST()
> >>  };
> >>
> >> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> >> index a85c199c76..cfac564093 100644
> >> --- a/hw/vfio/platform.c
> >> +++ b/hw/vfio/platform.c
> >> @@ -640,6 +640,7 @@ static Property vfio_platform_dev_properties[] =3D=
 {
> >>      DEFINE_PROP_LINK("iommufd", VFIOPlatformDevice, vbasedev.iommufd,
> >>                       TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
> >>  #endif
> >> +    DEFINE_PROP_UINT64("mmio-base", VFIOPlatformDevice, mmio_base, 0)=
,
> >>      DEFINE_PROP_END_OF_LIST(),
> >>  };
> >>
> >> diff --git a/include/hw/platform-bus.h b/include/hw/platform-bus.h
> >> index 44f30c5353..4e9913a5d7 100644
> >> --- a/include/hw/platform-bus.h
> >> +++ b/include/hw/platform-bus.h
> >> @@ -34,7 +34,7 @@ struct PlatformBusDevice {
> >>      SysBusDevice parent_obj;
> >>
> >>      /*< public >*/
> >> -    uint32_t mmio_size;
> >> +    uint64_t mmio_size;
> >>      MemoryRegion mmio;
> >>
> >>      uint32_t num_irqs;
> >> diff --git a/include/hw/vfio/vfio-platform.h b/include/hw/vfio/vfio-pl=
atform.h
> >> index c414c3dffc..90575b5852 100644
> >> --- a/include/hw/vfio/vfio-platform.h
> >> +++ b/include/hw/vfio/vfio-platform.h
> >> @@ -59,6 +59,7 @@ struct VFIOPlatformDevice {
> >>      uint32_t mmap_timeout; /* delay to re-enable mmaps after interrup=
t */
> >>      QEMUTimer *mmap_timer; /* allows fast-path resume after IRQ hit *=
/
> >>      QemuMutex intp_mutex; /* protect the intp_list IRQ state */
> >> +    uint64_t mmio_base; /* base address to start looking for mmio */
> >>      bool irqfd_allowed; /* debug option to force irqfd on/off */
> >>  };
> >>  typedef struct VFIOPlatformDevice VFIOPlatformDevice;
>

