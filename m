Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE2CD41C24
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 09:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tB9tf-0001wu-8T; Wed, 13 Nov 2024 04:42:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tB9tc-0001wg-Uu
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 04:42:45 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tB9ta-0004xZ-SS
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 04:42:44 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3807dd08cfcso6263394f8f.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 01:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731490960; x=1732095760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iC9QkPVr0ZWNnSa2gv6F7n/Q2OUb1HchEs9i+BCTiIs=;
 b=V7tCUl93kGSDGJV0wzPD6L99ZPCwh9EzIv0metAisVhsTozXb3QU6zyuhZW48CXixZ
 G+40AL+q8iou0XWOfjdiTp7HxQrelXdVybDaGJXVD6VaxPaQSUK6VsEXJQzijkM3rreQ
 qhP21lHP1wi/ClrXxqO6aYt8Hpgl4fAmYWfAJQJXh3QuLC5v+vhlY4FgNGyx2AbxoT/s
 pvq+S5nD5sTjI+oq/F6lbM3KlF6zP1xKvlw3cy4NzLvYmdqtz0NAKhtsJYOvm6Gvy6br
 Ao2ONcZM7muSCH/JWTS6jLit6zgwMXENVjY8465C3HPg+fS9z98TQLgdSfoIrsTzaHkS
 IQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731490960; x=1732095760;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iC9QkPVr0ZWNnSa2gv6F7n/Q2OUb1HchEs9i+BCTiIs=;
 b=HCVdcAgqlne2mv6qV+Gurzat1thTU8LcpidtMjwUAdrv2jo8tZyDAv5zNP0GS/MPwo
 f8T0m+wYuIOnZ+dRg21yqHUWfn2zEpDQLM3AWvhNYPh9EdiIbpRkfPyfBM7zJrTRN65f
 94UeluJbU/UYsY2E8Ccn8cHWb/D0FUn6aZF9/Gpc/bLmdUfTlVTBn74XrwGCz8tY1pqR
 S6VRGTt8rBqPsxhzJmRS03U+Ij/RkvNUL2L92Yj0KFHEzC17gR/F5aczgVdq4jeQXCpn
 s5a7l4omey7hK5BzezLXbdmSDfbxbFXq9rmbGrO66pcWlUDCFScnYsxe0GzOmuUw/TYP
 iMPg==
X-Gm-Message-State: AOJu0Yw5VI2g3Vs/VIsIKTdplxioXuNGgPDWidyTK3HGW0wdaty7blUP
 rRT0DggJvzASxleC64IjfB93n4/vudDT+2SPHoIAOleo2o97CMUHlJNrVRSfRCU=
X-Google-Smtp-Source: AGHT+IGHNE6oaQocaWHO2GcSZ7A/ngla0LN2rfk/mRToQklLXqzp3sn3PdN9HcijqGYlEHHokeQ/Uw==
X-Received: by 2002:a05:6000:2d84:b0:381:f443:21d9 with SMTP id
 ffacd0b85a97d-381f44324b8mr13886947f8f.56.1731490960150; 
 Wed, 13 Nov 2024 01:42:40 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9f8827sm18246816f8f.72.2024.11.13.01.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 01:42:39 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9CE145F796;
 Wed, 13 Nov 2024 09:42:38 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Juan Pablo Ruiz <jpruiz84@gmail.com>
Cc: qemu-devel@nongnu.org,  alex.williamson@redhat.com,  Juan Pablo Ruiz
 <juanpablo.ruiz@unikie.com>
Subject: Re: [PATCH 1/1] vfio/platform: Add mmio-base property to define
 start address for MMIO mapping
In-Reply-To: <20241112220212.2237-1-juanpablo.ruiz@unikie.com> (Juan Pablo
 Ruiz's message of "Tue, 12 Nov 2024 22:02:12 +0000")
References: <20241112220212.2237-1-juanpablo.ruiz@unikie.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 13 Nov 2024 09:42:38 +0000
Message-ID: <87ttcbtqpd.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Juan Pablo Ruiz <jpruiz84@gmail.com> writes:

> Some platform devices have large MMIO regions (e.g., GPU reserved memory)=
. For
> certain devices, it's preferable to have a 1:1 address translation in the=
 VM to
> avoid modifying driver source code.
>
> This patch:
>
> 1. Increases the VFIO platform bus size from 32MB to 130GB.
> 2. Changes the mmio_size property from 32 to 64 bits.
> 3. Adds an mmio-base property to define the starting MMIO address for map=
ping
>    the VFIO device.

Could these be split patches?

>
> Signed-off-by: Juan Pablo Ruiz juanpablo.ruiz@unikie.com
> ---
>  hw/arm/virt.c                   |  6 +++---
>  hw/core/platform-bus.c          | 28 ++++++++++++++++++++++++++--
>  hw/vfio/platform.c              |  1 +
>  include/hw/platform-bus.h       |  2 +-
>  include/hw/vfio/vfio-platform.h |  1 +
>  5 files changed, 32 insertions(+), 6 deletions(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 1a381e9a2b..9fc8f4425a 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -183,13 +183,13 @@ static const MemMapEntry base_memmap[] =3D {
>      [VIRT_SECURE_GPIO] =3D        { 0x090b0000, 0x00001000 },
>      [VIRT_MMIO] =3D               { 0x0a000000, 0x00000200 },
>      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that s=
ize */
> -    [VIRT_PLATFORM_BUS] =3D       { 0x0c000000, 0x02000000 },
> +    [VIRT_PLATFORM_BUS] =3D       { 0x60000000, 0x1FC0000000 },
> // 130048MB

*If* this is accepted you should move its definition so its in order.

>      [VIRT_SECURE_MEM] =3D         { 0x0e000000, 0x01000000 },
>      [VIRT_PCIE_MMIO] =3D          { 0x10000000, 0x2eff0000 },
>      [VIRT_PCIE_PIO] =3D           { 0x3eff0000, 0x00010000 },
>      [VIRT_PCIE_ECAM] =3D          { 0x3f000000, 0x01000000 },
>      /* Actual RAM size depends on initial RAM and device memory settings=
 */
> -    [VIRT_MEM] =3D                { GiB, LEGACY_RAMLIMIT_BYTES },
> +    [VIRT_MEM] =3D                { 0x2000000000, LEGACY_RAMLIMIT_BYTES

Please use multiples of GiB for clarity. However this now reduces the
memory a highmem=3Doff armv7 virt machine can use.

> },

>  };
>=20=20
>  /*
> @@ -1625,7 +1625,7 @@ static void create_platform_bus(VirtMachineState *v=
ms)
>      dev =3D qdev_new(TYPE_PLATFORM_BUS_DEVICE);
>      dev->id =3D g_strdup(TYPE_PLATFORM_BUS_DEVICE);
>      qdev_prop_set_uint32(dev, "num_irqs", PLATFORM_BUS_NUM_IRQS);
> -    qdev_prop_set_uint32(dev, "mmio_size", vms->memmap[VIRT_PLATFORM_BUS=
].size);
> +    qdev_prop_set_uint64(dev, "mmio_size", vms->memmap[VIRT_PLATFORM_BUS=
].size);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>      vms->platform_bus_dev =3D dev;
>=20=20
> diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
> index dc58bf505a..f545fab6e5 100644
> --- a/hw/core/platform-bus.c
> +++ b/hw/core/platform-bus.c
> @@ -22,6 +22,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/platform-bus.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/vfio/vfio-platform.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "qemu/module.h"
> @@ -130,11 +131,29 @@ static void platform_bus_map_mmio(PlatformBusDevice=
 *pbus, SysBusDevice *sbdev,
>                                    int n)
>  {
>      MemoryRegion *sbdev_mr =3D sysbus_mmio_get_region(sbdev, n);
> +    VFIOPlatformDevice *vdev =3D VFIO_PLATFORM_DEVICE(sbdev);
>      uint64_t size =3D memory_region_size(sbdev_mr);
>      uint64_t alignment =3D (1ULL << (63 - clz64(size + size - 1)));
>      uint64_t off;
> +    uint64_t mmio_base_off;
>      bool found_region =3D false;
>=20=20
> +    if (vdev->mmio_base) {
> +        if(vdev->mmio_base < pbus->mmio.addr ||=20
> +           vdev->mmio_base >=3D pbus->mmio.addr + pbus->mmio_size){
> +            error_report("Platform Bus: MMIO base 0x%"PRIx64
> +                " outside platform bus region [0x%"PRIx64",0x%"PRIx64"]",
> +                vdev->mmio_base,
> +                pbus->mmio.addr,
> +                pbus->mmio.addr + pbus->mmio_size);
> +            exit(1);
> +        }
> +=20=20=20=20=20=20=20=20
> +        mmio_base_off =3D vdev->mmio_base - pbus->mmio.addr;
> +    } else {
> +        mmio_base_off =3D 0;
> +    }
> +=20=20=20=20
>      if (memory_region_is_mapped(sbdev_mr)) {
>          /* Region is already mapped, nothing to do */
>          return;
> @@ -144,7 +163,7 @@ static void platform_bus_map_mmio(PlatformBusDevice *=
pbus, SysBusDevice *sbdev,
>       * Look for empty space in the MMIO space that is naturally aligned =
with
>       * the target device's memory region
>       */
> -    for (off =3D 0; off < pbus->mmio_size; off +=3D alignment) {
> +    for (off =3D mmio_base_off; off < pbus->mmio_size; off +=3D alignmen=
t) {
>          MemoryRegion *mr =3D memory_region_find(&pbus->mmio, off, size).=
mr;
>          if (!mr) {
>              found_region =3D true;
> @@ -154,6 +173,11 @@ static void platform_bus_map_mmio(PlatformBusDevice =
*pbus, SysBusDevice *sbdev,
>          }
>      }
>=20=20
> +    if (vdev->mmio_base && vdev->mmio_base !=3D off + pbus->mmio.addr) {
> +        warn_report("Platform Bus: Not able to map in mmio base: 0x%"PRI=
x64,=20
> +            vdev->mmio_base);
> +    }
> +
>      if (!found_region) {
>          error_report("Platform Bus: Can not fit MMIO region of size %"PR=
Ix64,
>                       size);
> @@ -206,7 +230,7 @@ static void platform_bus_realize(DeviceState *dev, Er=
ror **errp)
>=20=20
>  static Property platform_bus_properties[] =3D {
>      DEFINE_PROP_UINT32("num_irqs", PlatformBusDevice, num_irqs, 0),
> -    DEFINE_PROP_UINT32("mmio_size", PlatformBusDevice, mmio_size, 0),
> +    DEFINE_PROP_UINT64("mmio_size", PlatformBusDevice, mmio_size, 0),
>      DEFINE_PROP_END_OF_LIST()
>  };
>=20=20
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index a85c199c76..cfac564093 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -640,6 +640,7 @@ static Property vfio_platform_dev_properties[] =3D {
>      DEFINE_PROP_LINK("iommufd", VFIOPlatformDevice, vbasedev.iommufd,
>                       TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
>  #endif
> +    DEFINE_PROP_UINT64("mmio-base", VFIOPlatformDevice, mmio_base, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>=20=20
> diff --git a/include/hw/platform-bus.h b/include/hw/platform-bus.h
> index 44f30c5353..4e9913a5d7 100644
> --- a/include/hw/platform-bus.h
> +++ b/include/hw/platform-bus.h
> @@ -34,7 +34,7 @@ struct PlatformBusDevice {
>      SysBusDevice parent_obj;
>=20=20
>      /*< public >*/
> -    uint32_t mmio_size;
> +    uint64_t mmio_size;
>      MemoryRegion mmio;
>=20=20
>      uint32_t num_irqs;
> diff --git a/include/hw/vfio/vfio-platform.h b/include/hw/vfio/vfio-platf=
orm.h
> index c414c3dffc..90575b5852 100644
> --- a/include/hw/vfio/vfio-platform.h
> +++ b/include/hw/vfio/vfio-platform.h
> @@ -59,6 +59,7 @@ struct VFIOPlatformDevice {
>      uint32_t mmap_timeout; /* delay to re-enable mmaps after interrupt */
>      QEMUTimer *mmap_timer; /* allows fast-path resume after IRQ hit */
>      QemuMutex intp_mutex; /* protect the intp_list IRQ state */
> +    uint64_t mmio_base; /* base address to start looking for mmio */
>      bool irqfd_allowed; /* debug option to force irqfd on/off */
>  };
>  typedef struct VFIOPlatformDevice VFIOPlatformDevice;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

