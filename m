Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC07C71155
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 03:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRMY0-0002AT-71; Mon, 16 Jun 2025 22:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uRMXy-00029i-3y; Mon, 16 Jun 2025 22:59:38 -0400
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uRMXv-0003sC-3Z; Mon, 16 Jun 2025 22:59:37 -0400
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-87edd8f4e9fso916555241.0; 
 Mon, 16 Jun 2025 19:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750129173; x=1750733973; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FTfV77CBkRiZGnO300YgD3CjULjl9ryYe74ACUd0PKI=;
 b=fXDmVhe82/AZdjCcf6qF3KDho9hhivXUbWRezIX3k10mVDqmaOMjd211jFmOT0LJ/z
 O2kkkdDMshTwDvhzjwrRKj3V5RGOjwS155JrSHwMY9ST8mbB4Vqi36Nb90zaZA251uCS
 5dJwDGa4rNqkMIlRgiQdWkfJ2fLfLiYD/rtk3vEW+++I6j0F3amXA0mmRt2k/zdihF64
 wpAFKX518cbbWcDbxThUb/ihrTdmx4r2NLbUpK2YUfsQM0VW5kLMxS1TWfW6nuOCkaN4
 ulZj9JytOb/rongo3TZ2YfA6CSsMdCyFoL/B4V+oTcwCIMwB+wVw1DaWsmfx5iRJuAJE
 DUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750129173; x=1750733973;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FTfV77CBkRiZGnO300YgD3CjULjl9ryYe74ACUd0PKI=;
 b=bFtK1GKcOzDQlNIKfhpTbjZhtg8QKX0WPTLftjHlEllnAL9SJfrZVRu6esiF0dPcRt
 /fFfPZCpIXkTYeR7hc4cDgP7ez2923b0mVROBb/B9YakZHxi+Rx8cELkhV94St4cTC/S
 5CwglwlHfEK5E2aKJ/MAqvyhEBgVPcWlbo+z0mOsS64CgRGJ+1oA+zMeLTR5oqYkpfRS
 Ne/LJKEmK15/L5JnpjfMl2agfGochOFS3DLnyOcXN/E8TEZ38okFogwSx9qpaYwGe6ss
 umaA/gZ8REAZlJER2M8X9JiMSGkqeUvR9QtNANxmy/kqCs+UzyDkwaXPJNNH3a+eggzK
 OpHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIQBX5WhEKqK6hiQZwrX9j6tl68sCg5bHLbI/ywFuvIdhfmwS/Vbe8Wq8NL8HbV87kvzpfJg2oey58Cg==@nongnu.org,
 AJvYcCXZgDj2XyjU3qHfmNcDjiyBP6LOv6dIcgKaZ7wBlkd1YC7TtoZR6SZl2AmiSPiRnl3+NxUsM9HgF8D6@nongnu.org
X-Gm-Message-State: AOJu0YzSPnUpnYOZZfIqdURG/4vqYBIrYBWXDx0EQi+dMqZ9mbbFRsPg
 3+W9uM4zlpVSe9dgjJ0k9DJv2AwmztLgvsHsFqxL74eOC2GHhZ+MDckU+9J9hM+uoIY1eDD9B6v
 XXrBl390kh1NMAtsh8C2p5f/qqQTmMdA=
X-Gm-Gg: ASbGncuuLQ+w06UzY3/4MU/0cCrj28IWE3JlhoxL5PuNL8W+JF+i59GvF6EETEG52LO
 cj+T019VICBLctusJO8uSZAB+Vsc6TXskNHbluwqeKTp8l9bVojgHH935cpAXlYCrqKYNCmjxXq
 /POgcvMrJW2N26LPK9Z9EzmDh2aEQsLr/1skkKpqKV0Pn37yOF6mtSfdBDUqVPychTnrGmTxHH2
 w==
X-Google-Smtp-Source: AGHT+IGWviSoAN9WCHmOgZ5TGedxuq4OB/EVcS5qa8wTSOBtlXAmpbtznnwBK6WZ/EMtEt2xE6rBbx9DRM2oOjxllUA=
X-Received: by 2002:a05:6102:5349:b0:4e5:a67d:92a6 with SMTP id
 ada2fe7eead31-4e7f639ec54mr7441702137.14.1750129172933; Mon, 16 Jun 2025
 19:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250425122238.383-1-wangran@bosc.ac.cn>
In-Reply-To: <20250425122238.383-1-wangran@bosc.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 17 Jun 2025 12:59:06 +1000
X-Gm-Features: AX0GCFtx11xz5pGOWBNoQMRXpWZ1-ne-o2qjos5e2xuP1Atkb3-MbzKg6nLRrJc
Message-ID: <CAKmqyKPvx4zfXgdKqQrXix_57aoF87vJg2BWc6it700B7jt6yw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] hw/riscv: Initial support for BOSC's Xiangshan
 Kunminghu FPGA prototype
To: Ran Wang <wangran@bosc.ac.cn>
Cc: 3543977024@qq.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92a.google.com
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

On Fri, Apr 25, 2025 at 10:22=E2=80=AFPM Ran Wang <wangran@bosc.ac.cn> wrot=
e:
>
> From: Huang Borong <3543977024@qq.com>
>
> This implementation provides emulation for the Xiangshan Kunminghu
> FPGA prototype platform, including support for UART, CLINT, IMSIC,
> and APLIC devices. More details can be found at
> https://github.com/OpenXiangShan/XiangShan
>
> Signed-off-by: qinshaoqing <qinshaoqing@bosc.ac.cn>
> Signed-off-by: Yang Wang <wangyang@bosc.ac.cn>
> Signed-off-by: Yu Hu <huyu@bosc.ac.cn>
> Signed-off-by: Ran Wang <wangran@bosc.ac.cn>
> Signed-off-by: Borong Huang <3543977024@qq.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  MAINTAINERS                                 |   7 +
>  configs/devices/riscv64-softmmu/default.mak |   1 +
>  docs/system/riscv/xiangshan-kunminghu.rst   |  39 ++++
>  docs/system/target-riscv.rst                |   1 +
>  hw/riscv/Kconfig                            |   9 +
>  hw/riscv/meson.build                        |   1 +
>  hw/riscv/xiangshan_kmh.c                    | 220 ++++++++++++++++++++
>  include/hw/riscv/xiangshan_kmh.h            |  78 +++++++
>  8 files changed, 356 insertions(+)
>  create mode 100644 docs/system/riscv/xiangshan-kunminghu.rst
>  create mode 100644 hw/riscv/xiangshan_kmh.c
>  create mode 100644 include/hw/riscv/xiangshan_kmh.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8978adf999..a9258bd610 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1667,6 +1667,13 @@ S: Maintained
>  F: hw/riscv/microblaze-v-generic.c
>  F: docs/system/riscv/microblaze-v-generic.rst
>
> +Xiangshan Kunminghu
> +M: Ran Wang <wangran@bosc.ac.cn>
> +S: Maintained
> +F: docs/system/riscv/xiangshan-kunminghu.rst
> +F: hw/riscv/xiangshan_kmh.c
> +F: include/hw/riscv/xiangshan_kmh.h
> +
>  RX Machines
>  -----------
>  rx-gdbsim
> diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/device=
s/riscv64-softmmu/default.mak
> index 39ed3a0061..e485bbd1a3 100644
> --- a/configs/devices/riscv64-softmmu/default.mak
> +++ b/configs/devices/riscv64-softmmu/default.mak
> @@ -11,3 +11,4 @@
>  # CONFIG_RISCV_VIRT=3Dn
>  # CONFIG_MICROCHIP_PFSOC=3Dn
>  # CONFIG_SHAKTI_C=3Dn
> +# CONFIG_XIANGSHAN_KUNMINGHU=3Dn
> diff --git a/docs/system/riscv/xiangshan-kunminghu.rst b/docs/system/risc=
v/xiangshan-kunminghu.rst
> new file mode 100644
> index 0000000000..46e7ceeda0
> --- /dev/null
> +++ b/docs/system/riscv/xiangshan-kunminghu.rst
> @@ -0,0 +1,39 @@
> +BOSC Xiangshan Kunminghu FPGA prototype platform (``xiangshan-kunminghu`=
`)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +The ``xiangshan-kunminghu`` machine is compatible with our FPGA prototyp=
e
> +platform.
> +
> +XiangShan is an open-source high-performance RISC-V processor project.
> +The third generation processor is called Kunminghu. Kunminghu is a 64-bi=
t
> +RV64GCBSUHV processor core. More information can be found in our Github
> +repository:
> +https://github.com/OpenXiangShan/XiangShan
> +
> +Supported devices
> +-----------------
> +The ``xiangshan-kunminghu`` machine supports the following devices:
> +
> +* Up to 16 xiangshan-kunminghu cores
> +* Core Local Interruptor (CLINT)
> +* Incoming MSI Controller (IMSIC)
> +* Advanced Platform-Level Interrupt Controller (APLIC)
> +* 1 UART
> +
> +Boot options
> +------------
> +The ``xiangshan-kunminghu`` machine can start using the standard ``-bios=
``
> +functionality for loading the boot image. You need to compile and link
> +the firmware, kernel, and Device Tree (FDT) into a single binary file,
> +such as ``fw_payload.bin``.
> +
> +Running
> +-------
> +Below is an example command line for running the ``xiangshan-kunminghu``
> +machine:
> +
> +.. code-block:: bash
> +
> +   $ qemu-system-riscv64 -machine xiangshan-kunminghu \
> +      -smp 16 -m 16G \
> +      -bios path/to/opensbi/platform/generic/firmware/fw_payload.bin \
> +      -nographic
> diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
> index 95457af130..89b2cb732c 100644
> --- a/docs/system/target-riscv.rst
> +++ b/docs/system/target-riscv.rst
> @@ -71,6 +71,7 @@ undocumented; you can get a complete list by running
>     riscv/shakti-c
>     riscv/sifive_u
>     riscv/virt
> +   riscv/xiangshan-kunminghu
>
>  RISC-V CPU firmware
>  -------------------
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index e6a0ac1fa1..fc9c35bd98 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -119,3 +119,12 @@ config SPIKE
>      select HTIF
>      select RISCV_ACLINT
>      select SIFIVE_PLIC
> +
> +config XIANGSHAN_KUNMINGHU
> +    bool
> +    default y
> +    depends on RISCV64
> +    select RISCV_ACLINT
> +    select RISCV_APLIC
> +    select RISCV_IMSIC
> +    select SERIAL_MM
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index c22f3a7216..2a8d5b136c 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -13,5 +13,6 @@ riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-=
acpi-build.c'))
>  riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
>         'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv=
-iommu-hpm.c'))
>  riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-g=
eneric.c'))
> +riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangsh=
an_kmh.c'))
>
>  hw_arch +=3D {'riscv': riscv_ss}
> diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
> new file mode 100644
> index 0000000000..f7ae879d13
> --- /dev/null
> +++ b/hw/riscv/xiangshan_kmh.c
> @@ -0,0 +1,220 @@
> +/*
> + * QEMU RISC-V Board Compatible with the Xiangshan Kunminghu
> + * FPGA prototype platform
> + *
> + * Copyright (c) 2025 Beijing Institute of Open Source Chip (BOSC)
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Provides a board compatible with the Xiangshan Kunminghu
> + * FPGA prototype platform:
> + *
> + * 0) UART (16550A)
> + * 1) CLINT (Core-Local Interruptor)
> + * 2) IMSIC (Incoming MSI Controller)
> + * 3) APLIC (Advanced Platform-Level Interrupt Controller)
> + *
> + * More information can be found in our Github repository:
> + * https://github.com/OpenXiangShan/XiangShan
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "exec/address-spaces.h"

This should be

#include "system/address-spaces.h"

But even with that change I see a few errors with this patch

FAILED: libqemu-riscv64-softmmu.a.p/hw_riscv_xiangshan_kmh.c.o
...
../hw/riscv/xiangshan_kmh.c:154:19: error: initialization of =E2=80=98void
(*)(ObjectClass *, const void *)=E2=80=99 from incompatible pointer type =
=E2=80=98void
(*)(ObjectClass *,
void *)=E2=80=99 [-Wincompatible-pointer-types]
 154 |     .class_init =3D xiangshan_kmh_soc_class_init,
     |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
../hw/riscv/xiangshan_kmh.c:154:19: note: (near initialization for
=E2=80=98xiangshan_kmh_soc_info.class_init=E2=80=99)
../hw/riscv/xiangshan_kmh.c:134:13: note:
=E2=80=98xiangshan_kmh_soc_class_init=E2=80=99 declared here
 134 | static void xiangshan_kmh_soc_class_init(ObjectClass *klass, void *d=
ata)
     |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
../hw/riscv/xiangshan_kmh.c:213:19: error: initialization of =E2=80=98void
(*)(ObjectClass *, const void *)=E2=80=99 from incompatible pointer type =
=E2=80=98void
(*)(ObjectClass *,
void *)=E2=80=99 [-Wincompatible-pointer-types]
 213 |     .class_init =3D xiangshan_kmh_machine_class_init,
     |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../hw/riscv/xiangshan_kmh.c:213:19: note: (near initialization for
=E2=80=98xiangshan_kmh_machine_info.class_init=E2=80=99)
../hw/riscv/xiangshan_kmh.c:192:13: note:
=E2=80=98xiangshan_kmh_machine_class_init=E2=80=99 declared here
 192 | static void xiangshan_kmh_machine_class_init(ObjectClass
*klass, void *data)
     |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Alistair

> +#include "hw/boards.h"
> +#include "hw/char/serial-mm.h"
> +#include "hw/intc/riscv_aclint.h"
> +#include "hw/intc/riscv_aplic.h"
> +#include "hw/intc/riscv_imsic.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/riscv/boot.h"
> +#include "hw/riscv/xiangshan_kmh.h"
> +#include "hw/riscv/riscv_hart.h"
> +#include "system/system.h"
> +
> +static const MemMapEntry xiangshan_kmh_memmap[] =3D {
> +    [XIANGSHAN_KMH_ROM] =3D          {     0x1000,        0xF000 },
> +    [XIANGSHAN_KMH_UART0] =3D        { 0x310B0000,       0x10000 },
> +    [XIANGSHAN_KMH_CLINT] =3D        { 0x38000000,       0x10000 },
> +    [XIANGSHAN_KMH_APLIC_M] =3D      { 0x31100000,        0x4000 },
> +    [XIANGSHAN_KMH_APLIC_S] =3D      { 0x31120000,        0x4000 },
> +    [XIANGSHAN_KMH_IMSIC_M] =3D      { 0x3A800000,       0x10000 },
> +    [XIANGSHAN_KMH_IMSIC_S] =3D      { 0x3B000000,       0x80000 },
> +    [XIANGSHAN_KMH_DRAM] =3D         { 0x80000000,           0x0 },
> +};
> +
> +static DeviceState *xiangshan_kmh_create_aia(uint32_t num_harts)
> +{
> +    int i;
> +    const MemMapEntry *memmap =3D xiangshan_kmh_memmap;
> +    hwaddr addr =3D 0;
> +    DeviceState *aplic_m =3D NULL;
> +
> +    /* M-level IMSICs */
> +    addr =3D memmap[XIANGSHAN_KMH_IMSIC_M].base;
> +    for (i =3D 0; i < num_harts; i++) {
> +        riscv_imsic_create(addr + i * IMSIC_HART_SIZE(0), i, true,
> +                           1, XIANGSHAN_KMH_IMSIC_NUM_IDS);
> +    }
> +
> +    /* S-level IMSICs */
> +    addr =3D memmap[XIANGSHAN_KMH_IMSIC_S].base;
> +    for (i =3D 0; i < num_harts; i++) {
> +        riscv_imsic_create(addr +
> +                           i * IMSIC_HART_SIZE(XIANGSHAN_KMH_IMSIC_GUEST=
_BITS),
> +                           i, false, 1 + XIANGSHAN_KMH_IMSIC_GUEST_BITS,
> +                           XIANGSHAN_KMH_IMSIC_NUM_IDS);
> +    }
> +
> +    /* M-level APLIC */
> +    aplic_m =3D riscv_aplic_create(memmap[XIANGSHAN_KMH_APLIC_M].base,
> +                                 memmap[XIANGSHAN_KMH_APLIC_M].size,
> +                                 0, 0, XIANGSHAN_KMH_APLIC_NUM_SOURCES,
> +                                 1, true, true, NULL);
> +
> +    /* S-level APLIC */
> +    riscv_aplic_create(memmap[XIANGSHAN_KMH_APLIC_S].base,
> +                       memmap[XIANGSHAN_KMH_APLIC_S].size,
> +                       0, 0, XIANGSHAN_KMH_APLIC_NUM_SOURCES,
> +                       1, true, false, aplic_m);
> +
> +    return aplic_m;
> +}
> +
> +static void xiangshan_kmh_soc_realize(DeviceState *dev, Error **errp)
> +{
> +    MachineState *ms =3D MACHINE(qdev_get_machine());
> +    XiangshanKmhSoCState *s =3D XIANGSHAN_KMH_SOC(dev);
> +    const MemMapEntry *memmap =3D xiangshan_kmh_memmap;
> +    MemoryRegion *system_memory =3D get_system_memory();
> +    uint32_t num_harts =3D ms->smp.cpus;
> +
> +    qdev_prop_set_uint32(DEVICE(&s->cpus), "num-harts", num_harts);
> +    qdev_prop_set_uint32(DEVICE(&s->cpus), "hartid-base", 0);
> +    qdev_prop_set_string(DEVICE(&s->cpus), "cpu-type",
> +                         TYPE_RISCV_CPU_XIANGSHAN_KMH);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_fatal);
> +
> +    /* AIA */
> +    s->irqchip =3D xiangshan_kmh_create_aia(num_harts);
> +
> +    /* UART */
> +    serial_mm_init(system_memory, memmap[XIANGSHAN_KMH_UART0].base, 2,
> +                   qdev_get_gpio_in(s->irqchip, XIANGSHAN_KMH_UART0_IRQ)=
,
> +                   115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
> +
> +    /* CLINT */
> +    riscv_aclint_swi_create(memmap[XIANGSHAN_KMH_CLINT].base,
> +                            0, num_harts, false);
> +    riscv_aclint_mtimer_create(memmap[XIANGSHAN_KMH_CLINT].base +
> +                               RISCV_ACLINT_SWI_SIZE,
> +                               RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
> +                               0, num_harts, RISCV_ACLINT_DEFAULT_MTIMEC=
MP,
> +                               RISCV_ACLINT_DEFAULT_MTIME,
> +                               XIANGSHAN_KMH_CLINT_TIMEBASE_FREQ, true);
> +
> +    /* ROM */
> +    memory_region_init_rom(&s->rom, OBJECT(dev), "xiangshan.kunminghu.ro=
m",
> +                           memmap[XIANGSHAN_KMH_ROM].size, &error_fatal)=
;
> +    memory_region_add_subregion(system_memory,
> +                                memmap[XIANGSHAN_KMH_ROM].base, &s->rom)=
;
> +}
> +
> +static void xiangshan_kmh_soc_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->realize =3D xiangshan_kmh_soc_realize;
> +    dc->user_creatable =3D false;
> +}
> +
> +static void xiangshan_kmh_soc_instance_init(Object *obj)
> +{
> +    XiangshanKmhSoCState *s =3D XIANGSHAN_KMH_SOC(obj);
> +
> +    object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY=
);
> +}
> +
> +static const TypeInfo xiangshan_kmh_soc_info =3D {
> +    .name =3D TYPE_XIANGSHAN_KMH_SOC,
> +    .parent =3D TYPE_DEVICE,
> +    .instance_size =3D sizeof(XiangshanKmhSoCState),
> +    .instance_init =3D xiangshan_kmh_soc_instance_init,
> +    .class_init =3D xiangshan_kmh_soc_class_init,
> +};
> +
> +static void xiangshan_kmh_soc_register_types(void)
> +{
> +    type_register_static(&xiangshan_kmh_soc_info);
> +}
> +type_init(xiangshan_kmh_soc_register_types)
> +
> +static void xiangshan_kmh_machine_init(MachineState *machine)
> +{
> +    XiangshanKmhState *s =3D XIANGSHAN_KMH_MACHINE(machine);
> +    const MemMapEntry *memmap =3D xiangshan_kmh_memmap;
> +    MemoryRegion *system_memory =3D get_system_memory();
> +    hwaddr start_addr =3D memmap[XIANGSHAN_KMH_DRAM].base;
> +
> +    /* Initialize SoC */
> +    object_initialize_child(OBJECT(machine), "soc", &s->soc,
> +                            TYPE_XIANGSHAN_KMH_SOC);
> +    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
> +
> +    /* Register RAM */
> +    memory_region_add_subregion(system_memory,
> +                                memmap[XIANGSHAN_KMH_DRAM].base,
> +                                machine->ram);
> +
> +    /* ROM reset vector */
> +    riscv_setup_rom_reset_vec(machine, &s->soc.cpus,
> +                              start_addr,
> +                              memmap[XIANGSHAN_KMH_ROM].base,
> +                              memmap[XIANGSHAN_KMH_ROM].size, 0, 0);
> +    if (machine->firmware) {
> +        riscv_load_firmware(machine->firmware, &start_addr, NULL);
> +    }
> +
> +    /* Note: dtb has been integrated into firmware(OpenSBI) when compili=
ng */
> +}
> +
> +static void xiangshan_kmh_machine_class_init(ObjectClass *klass, void *d=
ata)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(klass);
> +    static const char *const valid_cpu_types[] =3D {
> +        TYPE_RISCV_CPU_XIANGSHAN_KMH,
> +        NULL
> +    };
> +
> +    mc->desc =3D "RISC-V Board compatible with the Xiangshan " \
> +               "Kunminghu FPGA prototype platform";
> +    mc->init =3D xiangshan_kmh_machine_init;
> +    mc->max_cpus =3D XIANGSHAN_KMH_MAX_CPUS;
> +    mc->default_cpu_type =3D TYPE_RISCV_CPU_XIANGSHAN_KMH;
> +    mc->valid_cpu_types =3D valid_cpu_types;
> +    mc->default_ram_id =3D "xiangshan.kunminghu.ram";
> +}
> +
> +static const TypeInfo xiangshan_kmh_machine_info =3D {
> +    .name =3D TYPE_XIANGSHAN_KMH_MACHINE,
> +    .parent =3D TYPE_MACHINE,
> +    .instance_size =3D sizeof(XiangshanKmhState),
> +    .class_init =3D xiangshan_kmh_machine_class_init,
> +};
> +
> +static void xiangshan_kmh_machine_register_types(void)
> +{
> +    type_register_static(&xiangshan_kmh_machine_info);
> +}
> +type_init(xiangshan_kmh_machine_register_types)
> diff --git a/include/hw/riscv/xiangshan_kmh.h b/include/hw/riscv/xiangsha=
n_kmh.h
> new file mode 100644
> index 0000000000..952473fbb6
> --- /dev/null
> +++ b/include/hw/riscv/xiangshan_kmh.h
> @@ -0,0 +1,78 @@
> +/*
> + * QEMU RISC-V Board Compatible with the Xiangshan Kunminghu
> + * FPGA prototype platform
> + *
> + * Copyright (c) 2025 Beijing Institute of Open Source Chip (BOSC)
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_XIANGSHAN_KMH_H
> +#define HW_XIANGSHAN_KMH_H
> +
> +#include "hw/boards.h"
> +#include "hw/riscv/riscv_hart.h"
> +
> +#define XIANGSHAN_KMH_MAX_CPUS 16
> +
> +typedef struct XiangshanKmhSoCState {
> +    /*< private >*/
> +    DeviceState parent_obj;
> +
> +    /*< public >*/
> +    RISCVHartArrayState cpus;
> +    DeviceState *irqchip;
> +    MemoryRegion rom;
> +} XiangshanKmhSoCState;
> +
> +#define TYPE_XIANGSHAN_KMH_SOC "xiangshan.kunminghu.soc"
> +DECLARE_INSTANCE_CHECKER(XiangshanKmhSoCState, XIANGSHAN_KMH_SOC,
> +                         TYPE_XIANGSHAN_KMH_SOC)
> +
> +typedef struct XiangshanKmhState {
> +    /*< private >*/
> +    MachineState parent_obj;
> +
> +    /*< public >*/
> +    XiangshanKmhSoCState soc;
> +} XiangshanKmhState;
> +
> +#define TYPE_XIANGSHAN_KMH_MACHINE MACHINE_TYPE_NAME("xiangshan-kunmingh=
u")
> +DECLARE_INSTANCE_CHECKER(XiangshanKmhState, XIANGSHAN_KMH_MACHINE,
> +                         TYPE_XIANGSHAN_KMH_MACHINE)
> +
> +enum {
> +    XIANGSHAN_KMH_ROM,
> +    XIANGSHAN_KMH_UART0,
> +    XIANGSHAN_KMH_CLINT,
> +    XIANGSHAN_KMH_APLIC_M,
> +    XIANGSHAN_KMH_APLIC_S,
> +    XIANGSHAN_KMH_IMSIC_M,
> +    XIANGSHAN_KMH_IMSIC_S,
> +    XIANGSHAN_KMH_DRAM,
> +};
> +
> +enum {
> +    XIANGSHAN_KMH_UART0_IRQ =3D 10,
> +};
> +
> +/* Indicating Timebase-freq (1MHZ) */
> +#define XIANGSHAN_KMH_CLINT_TIMEBASE_FREQ 1000000
> +
> +#define XIANGSHAN_KMH_IMSIC_NUM_IDS 255
> +#define XIANGSHAN_KMH_IMSIC_NUM_GUESTS 7
> +#define XIANGSHAN_KMH_IMSIC_GUEST_BITS 3
> +
> +#define XIANGSHAN_KMH_APLIC_NUM_SOURCES 96
> +
> +#endif
> --
> 2.34.1
>

