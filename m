Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C600DCD98CF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 04:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYyys-0005aQ-M8; Mon, 15 Jun 2026 00:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wYyyp-0005a4-FG
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 00:31:23 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wYyyn-0006uU-79
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 00:31:23 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6913160c9ddso5236393a12.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 21:31:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781497880; cv=none;
 d=google.com; s=arc-20240605;
 b=BO/Gev25ehPD8q8ZM5YJy562huIW0RZZb3IjzSLvi4iZaqhiXXZb3Q+Ap0V+XUzkoz
 W0G00FtVngI3TkRKRiqizeF4vtph8TnmqUdjNveqcxTbZjuwuCVbrVIfLq0STkdg7a0H
 eTj3ctZefDQnafQLDm0IeBfro59PS3qt4JFy4zalWNTCMQQivLiQOMYR98T63FX+B2G4
 IHf4InimgH3ZmQ0lsWW/6EeVY8+f9C0L9P2VaQN1jB92VmS33ZYQRlJFOkksbVud7T10
 3Ma6SgwdDAdiAeuzYl8c6ZRDNklFfZaMNMd2/CuUlzczy1CL0+Y2llIWivyzdwOpvCHg
 cNsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+4DMmayQr9KfoeZjYGv3OM+0l3ICJ+TvFC4wg/QUu6M=;
 fh=8GfJ89V7ao1EKR9kVMmw/vE2YQ5ZxcrNvyeNZvBhfmo=;
 b=Ka0pqsl2FYibdh7unl0filqthihcjIgaVrW+NET1+ZTSL+iK9RMrB/y57JE/kaDnxx
 Bh6wsDYAWRr9ho6CVVeh9Rkv79kD9dH5fipyfLfEZQ6UWJHYgjxeuGyqJxpZRQaa9btj
 l7uyY5SDXCTFDRMTohUl610+AKnZEV9MnGfKrvT960NsGrqFt5obAVLm7oo6dSKSW66k
 b6dljcNYMwnqZqddxJ+Oj9pFUxRM/U+UAKoh3SkRWuvo/nAp14WZL40JkMKNZsap+b75
 6tvol2wc5esGOPHp3hhOoEHh+PekEDhxaWbJoL3ihozS3M5BZkWoUcq5VHICoDCq0KY7
 MLhw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781497880; x=1782102680; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+4DMmayQr9KfoeZjYGv3OM+0l3ICJ+TvFC4wg/QUu6M=;
 b=I+B3zeyH3WJAmku7X7jhq4Vx3EgDfvgcqn4gk9JlWv1tfgLzHTEOX1ptY+3KmV8BCs
 Eg9+Rx4x/CjuvtBFwurKNdC8gTrTvqRaPZxlUm0VjQPGGzDQYPCIyhvv5h6KA7bL6RMy
 0io9o8gC8e8r25Hb9TEVjP9hMuYZlJ7eIgaREz6huIFIaOvG/dF9QSXB/8sAmcGoGlTf
 35iFMCOl19PUH8Q5M/5Nx7V5R1NEQFuriv1T1IY+NU0nimSs6s4j7xRHqF8eCu/nyLRA
 GHTnUSYZfAW4Oy5KgdYwxIBw6ulVjMmpJFpeoNUxzuRYaeVomqfGqAM9orNxdVrHzMSn
 jHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781497880; x=1782102680;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+4DMmayQr9KfoeZjYGv3OM+0l3ICJ+TvFC4wg/QUu6M=;
 b=o5fYLYFDuxS5scqeX+ZDqy1xquGO15pJ/USfntroueEBE8YKEQ/XLYCS/016YO+QJ7
 /ZMGxsMhzEI4SkCRAJY7xpF30Mm1t5OG4Rs4LB7q9ct6Vs1tO7xjFy+7oHkk/zeHLWJw
 wu66cxF8inHhEnl/fmcYlarox3vxSF4GPSaTtUJhHfv3c49eTa1bTEawYLLMDw7d1QsH
 5YCpr39D5VXuV4c+UHW4qUqM3y8W7PUQVnjP0B23HHqX9zy8UYfdLtd3QgNoCoqGdho1
 50YCYgJkAxnTJN8UOMfc64VftKq55PG4UsahHFHooIkzhQRIw7lBmJaAZLbBE6DjB+WG
 S01w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xIU/PR/bDRRphP+Zm4anXk/9TDBt5gio6/Hr2KL6OsSLsu40EwdTV/zkmhH1A8ey+pRgrIl2JwFd8@nongnu.org
X-Gm-Message-State: AOJu0YzvBv68csRoanVsbrGct7x3vm7NS0M1B4WSGQGMbg5lMIq5OKV4
 R7jkCATd/IN2cDdAA0YY8yjd1V15vYcNyeDV7cPrEm6hl41ZlkTZQQwpyx8MgoYLXkGQfcaJIbR
 jfzbnapsfy4n1vilW15oCx3Zp7LAQ18A=
X-Gm-Gg: Acq92OGNe5PLVYSRBMoeNhml81AK9aj+ezpuCl4AQCz9FVJHkDv/p8p8kZX1KrZbTbQ
 7Vf9H2NUAV1fZym8XL2wELBhXM1GvbmcR9oqN7e5kBEnNWvJCF5laYXiRRKR2HU6YHpziUKhRUT
 8bC2MJTKbihQP1mJyyDy0V12QrysbiCOUV92Xax5hDAIcLPH+KyCxMLOROQimNxuNJQWZ+1jx0y
 Bxl0Zplb15EQSZKG0Khf/3qYic78IosycKbPFHnxNK3GNiC3AxncDnxqydK8NYbhnoYkK41FggI
 8KueBFyizo1PFZctvVdEKS1DbE3G+LjenQIqnA==
X-Received: by 2002:a05:6402:4346:b0:68c:342f:239e with SMTP id
 4fb4d7f45d1cf-693c6a16924mr3273464a12.7.1781497879477; Sun, 14 Jun 2026
 21:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260603065859.592063-1-joel@jms.id.au>
 <20260603065859.592063-4-joel@jms.id.au>
In-Reply-To: <20260603065859.592063-4-joel@jms.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jun 2026 14:30:52 +1000
X-Gm-Features: AVVi8Cf81jokxKRfX6ZMsLIQxikLzYJ38ZfEKuLXEaI0TSy4yEHndCJl1RcGJyE
Message-ID: <CAKmqyKNFDhVfCWa=PG_e943n899SUEw7tdp-aEgNADd4F_5RDQ@mail.gmail.com>
Subject: Re: [PATCH v8 03/12] hw/riscv/virt: Move AIA initialisation to helper
 file
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Nutty Liu <nutty.liu@hotmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x529.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jun 3, 2026 at 5:03=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrote:
>
> The AIA init will be used by any server class riscv machine. Separate it
> out in order to share code with such systems.
>
> The virt machine keeps machine specific #defines such as
> VIRT_IRQCHIP_NUM_MSIS, VIRT_IRQCHIP_NUM_PRIO_BITS.
>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/aia.h             | 26 +++++++++++
>  include/hw/riscv/virt.h    |  1 -
>  hw/riscv/aia.c             | 89 ++++++++++++++++++++++++++++++++++++++
>  hw/riscv/virt-acpi-build.c |  2 +
>  hw/riscv/virt.c            | 87 +++++--------------------------------
>  hw/riscv/meson.build       |  2 +-
>  6 files changed, 129 insertions(+), 78 deletions(-)
>  create mode 100644 hw/riscv/aia.h
>  create mode 100644 hw/riscv/aia.c
>
> diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
> new file mode 100644
> index 000000000000..dbb833340276
> --- /dev/null
> +++ b/hw/riscv/aia.h
> @@ -0,0 +1,26 @@
> +/*
> + * QEMU RISC-V Advanced Interrupt Architecture (AIA)
> + *
> + * Copyright (C) 2019 Western Digital Corporation or its affiliates.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_RISCV_AIA_H
> +#define HW_RISCV_AIA_H
> +
> +#include "exec/hwaddr.h"
> +
> +#define VIRT_IRQCHIP_NUM_SOURCES 96
> +
> +uint32_t imsic_num_bits(uint32_t count);
> +
> +DeviceState *riscv_create_aia(bool msimode, int aia_guests,
> +                             const MemMapEntry *aplic_m,
> +                             const MemMapEntry *aplic_s,
> +                             const MemMapEntry *imsic_m,
> +                             const MemMapEntry *imsic_s,
> +                             int socket, int base_hartid, int hart_count=
,
> +                             uint32_t num_msis, uint32_t num_prio_bits);
> +
> +#endif
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 18a2a323a344..ad858deb76ad 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -135,7 +135,6 @@ enum {
>  bool virt_is_acpi_enabled(RISCVVirtState *s);
>  bool virt_is_iommu_sys_enabled(RISCVVirtState *s);
>  void virt_acpi_setup(RISCVVirtState *vms);
> -uint32_t imsic_num_bits(uint32_t count);
>
>  /*
>   * The virt machine physical address space used by some of the devices
> diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
> new file mode 100644
> index 000000000000..c724612a50a5
> --- /dev/null
> +++ b/hw/riscv/aia.c
> @@ -0,0 +1,89 @@
> +/*
> + * QEMU RISC-V Advanced Interrupt Architecture (AIA)
> + *
> + * Copyright (C) 2019 Western Digital Corporation or its affiliates.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "system/kvm.h"
> +#include "hw/intc/riscv_aplic.h"
> +#include "hw/intc/riscv_imsic.h"
> +
> +#include "aia.h"
> +
> +uint32_t imsic_num_bits(uint32_t count)
> +{
> +    uint32_t ret =3D 0;
> +
> +    while (BIT(ret) < count) {
> +        ret++;
> +    }
> +
> +    return ret;
> +}
> +
> +DeviceState *riscv_create_aia(bool msimode, int aia_guests,
> +                             const MemMapEntry *aplic_m,
> +                             const MemMapEntry *aplic_s,
> +                             const MemMapEntry *imsic_m,
> +                             const MemMapEntry *imsic_s,
> +                             int socket, int base_hartid, int hart_count=
,
> +                             uint32_t num_msis, uint32_t num_prio_bits)
> +{
> +    int i;
> +    hwaddr addr =3D 0;
> +    uint32_t guest_bits;
> +    DeviceState *aplic_s_dev =3D NULL;
> +    DeviceState *aplic_m_dev =3D NULL;
> +
> +    if (msimode) {
> +        if (!kvm_enabled()) {
> +            /* Per-socket M-level IMSICs */
> +            addr =3D imsic_m->base + socket * (1U << IMSIC_MMIO_GROUP_MI=
N_SHIFT);
> +            for (i =3D 0; i < hart_count; i++) {
> +                riscv_imsic_create(addr + i * IMSIC_HART_SIZE(0),
> +                                   base_hartid + i, true, 1,
> +                                   num_msis);
> +            }
> +        }
> +
> +        /* Per-socket S-level IMSICs */
> +        guest_bits =3D imsic_num_bits(aia_guests + 1);
> +        addr =3D imsic_s->base + socket * (1U << IMSIC_MMIO_GROUP_MIN_SH=
IFT);
> +        for (i =3D 0; i < hart_count; i++) {
> +            riscv_imsic_create(addr + i * IMSIC_HART_SIZE(guest_bits),
> +                               base_hartid + i, false, 1 + aia_guests,
> +                               num_msis);
> +        }
> +    }
> +
> +    if (!kvm_enabled()) {
> +        /* Per-socket M-level APLIC */
> +        aplic_m_dev =3D riscv_aplic_create(aplic_m->base +
> +                                     socket * aplic_m->size,
> +                                     aplic_m->size,
> +                                     (msimode) ? 0 : base_hartid,
> +                                     (msimode) ? 0 : hart_count,
> +                                     VIRT_IRQCHIP_NUM_SOURCES,
> +                                     num_prio_bits,
> +                                     msimode, true, NULL);
> +    }
> +
> +    /* Per-socket S-level APLIC */
> +    aplic_s_dev =3D riscv_aplic_create(aplic_s->base +
> +                                 socket * aplic_s->size,
> +                                 aplic_s->size,
> +                                 (msimode) ? 0 : base_hartid,
> +                                 (msimode) ? 0 : hart_count,
> +                                 VIRT_IRQCHIP_NUM_SOURCES,
> +                                 num_prio_bits,
> +                                 msimode, false, aplic_m_dev);
> +
> +    if (kvm_enabled() && msimode) {
> +        riscv_aplic_set_kvm_msicfgaddr(RISCV_APLIC(aplic_s_dev), addr);
> +    }
> +
> +    return kvm_enabled() ? aplic_s_dev : aplic_m_dev;
> +}
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 413d47d70ef1..e3da87492408 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -42,6 +42,8 @@
>  #include "system/kvm.h"
>  #include "system/reset.h"
>
> +#include "aia.h"
> +
>  #define ACPI_BUILD_TABLE_SIZE             0x20000
>  #define ACPI_BUILD_INTC_ID(socket, index) ((socket << 24) | (index))
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index febf49d5f149..614220a0ce66 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -60,6 +60,8 @@
>  #include "hw/virtio/virtio-iommu.h"
>  #include "hw/uefi/var-service-api.h"
>
> +#include "aia.h"
> +
>  /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QE=
MU. */
>  static bool virt_use_kvm_aia_aplic_imsic(RISCVVirtAIAType aia_type)
>  {
> @@ -510,17 +512,6 @@ static void create_fdt_socket_plic(RISCVVirtState *s=
,
>      }
>  }
>
> -uint32_t imsic_num_bits(uint32_t count)
> -{
> -    uint32_t ret =3D 0;
> -
> -    while (BIT(ret) < count) {
> -        ret++;
> -    }
> -
> -    return ret;
> -}
> -
>  static void create_fdt_one_imsic(RISCVVirtState *s, hwaddr base_addr,
>                                   uint32_t *intc_phandles, uint32_t msi_p=
handle,
>                                   bool m_mode, uint32_t imsic_guest_bits)
> @@ -1294,68 +1285,6 @@ static DeviceState *virt_create_plic(const MemMapE=
ntry *memmap, int socket,
>               memmap[VIRT_PLIC].size);
>  }
>
> -static DeviceState *virt_create_aia(RISCVVirtAIAType aia_type, int aia_g=
uests,
> -                                    const MemMapEntry *memmap, int socke=
t,
> -                                    int base_hartid, int hart_count)
> -{
> -    int i;
> -    hwaddr addr =3D 0;
> -    uint32_t guest_bits;
> -    DeviceState *aplic_s =3D NULL;
> -    DeviceState *aplic_m =3D NULL;
> -    bool msimode =3D aia_type =3D=3D VIRT_AIA_TYPE_APLIC_IMSIC;
> -
> -    if (msimode) {
> -        if (!kvm_enabled()) {
> -            /* Per-socket M-level IMSICs */
> -            addr =3D memmap[VIRT_IMSIC_M].base +
> -                   socket * VIRT_IMSIC_GROUP_MAX_SIZE;
> -            for (i =3D 0; i < hart_count; i++) {
> -                riscv_imsic_create(addr + i * IMSIC_HART_SIZE(0),
> -                                   base_hartid + i, true, 1,
> -                                   VIRT_IRQCHIP_NUM_MSIS);
> -            }
> -        }
> -
> -        /* Per-socket S-level IMSICs */
> -        guest_bits =3D imsic_num_bits(aia_guests + 1);
> -        addr =3D memmap[VIRT_IMSIC_S].base + socket * VIRT_IMSIC_GROUP_M=
AX_SIZE;
> -        for (i =3D 0; i < hart_count; i++) {
> -            riscv_imsic_create(addr + i * IMSIC_HART_SIZE(guest_bits),
> -                               base_hartid + i, false, 1 + aia_guests,
> -                               VIRT_IRQCHIP_NUM_MSIS);
> -        }
> -    }
> -
> -    if (!kvm_enabled()) {
> -        /* Per-socket M-level APLIC */
> -        aplic_m =3D riscv_aplic_create(memmap[VIRT_APLIC_M].base +
> -                                     socket * memmap[VIRT_APLIC_M].size,
> -                                     memmap[VIRT_APLIC_M].size,
> -                                     (msimode) ? 0 : base_hartid,
> -                                     (msimode) ? 0 : hart_count,
> -                                     VIRT_IRQCHIP_NUM_SOURCES,
> -                                     VIRT_IRQCHIP_NUM_PRIO_BITS,
> -                                     msimode, true, NULL);
> -    }
> -
> -    /* Per-socket S-level APLIC */
> -    aplic_s =3D riscv_aplic_create(memmap[VIRT_APLIC_S].base +
> -                                 socket * memmap[VIRT_APLIC_S].size,
> -                                 memmap[VIRT_APLIC_S].size,
> -                                 (msimode) ? 0 : base_hartid,
> -                                 (msimode) ? 0 : hart_count,
> -                                 VIRT_IRQCHIP_NUM_SOURCES,
> -                                 VIRT_IRQCHIP_NUM_PRIO_BITS,
> -                                 msimode, false, aplic_m);
> -
> -    if (kvm_enabled() && msimode) {
> -        riscv_aplic_set_kvm_msicfgaddr(RISCV_APLIC(aplic_s), addr);
> -    }
> -
> -    return kvm_enabled() ? aplic_s : aplic_m;
> -}
> -
>  static void create_platform_bus(RISCVVirtState *s, DeviceState *irqchip)
>  {
>      DeviceState *dev;
> @@ -1618,9 +1547,15 @@ static void virt_machine_init(MachineState *machin=
e)
>              s->irqchip[i] =3D virt_create_plic(s->memmap, i,
>                                               base_hartid, hart_count);
>          } else {
> -            s->irqchip[i] =3D virt_create_aia(s->aia_type, s->aia_guests=
,
> -                                            s->memmap, i, base_hartid,
> -                                            hart_count);
> +            s->irqchip[i] =3D riscv_create_aia(s->aia_type =3D=3D VIRT_A=
IA_TYPE_APLIC_IMSIC,
> +                                             s->aia_guests,
> +                                             &s->memmap[VIRT_APLIC_M],
> +                                             &s->memmap[VIRT_APLIC_S],
> +                                             &s->memmap[VIRT_IMSIC_M],
> +                                             &s->memmap[VIRT_IMSIC_S],
> +                                             i, base_hartid, hart_count,
> +                                             VIRT_IRQCHIP_NUM_MSIS,
> +                                             VIRT_IRQCHIP_NUM_PRIO_BITS)=
;
>          }
>
>          /* Try to use different IRQCHIP instance based device type */
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index 533472e22aef..e53c180d0d10 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -1,5 +1,5 @@
>  riscv_ss =3D ss.source_set()
> -riscv_ss.add(files('boot.c'))
> +riscv_ss.add(files('boot.c', 'aia.c'))
>  riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
>  riscv_ss.add(files('riscv_hart.c'))
>  riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
> --
> 2.47.3
>
>

