Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8B0C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 01:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we17b-0003TP-TB; Sun, 28 Jun 2026 21:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1we17a-0003Sk-7l
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 21:49:14 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1we17Y-0004hg-BT
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 21:49:14 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-697e96dd8d2so4410824a12.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 18:49:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782697750; cv=none;
 d=google.com; s=arc-20260327;
 b=pDD9EV4ketw0xkBz+Sq34+SqG7VTE3E940yU+1nHAlKAlNMdZkCky92s48uTd1Lujr
 Y1Lco8u11VjUy/vauia5bTiZdgef4EXiAgt0xoLxk59tSWPoS8gsqbSAUmrpjPAUmEmo
 6Fqo9LD/ry+wzd5mFHb/hxtSmMYCWH9G43bEeMaad9iGcP3+XTNnj1gmK3qwFfIQClbs
 BmBkEaa45DqGf6aEVv4EaGgxCvCnZmjB9AbQumUrDNOHaP4q6kRFK0gzOPOUN3ZMivSL
 Z2ubHAUXlQ9c4+uWZw0Pxz4GJFmO1wgHyXh4PGgn//Mh3pfRqzzwznQFS7O5kGLqJaVu
 NfVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jT/vfohVavuQISs7KscSfDIUmHf64xT1apeI1DPbfMI=;
 fh=dpnkV/pAjBVorCRoD/UzBGYv0ERi/IM3low49Gflb5Y=;
 b=joJK0FElzZ3GyRN3QHexmUcYLR/apfJoymKVFQtzphHwiR1gbIgCGK4iTKgTA0bQKj
 iDfVZnPuFGgkHkngiYpLhLQ08QeIl9M7O2phLSdRQLkMlDxVYtDA008/zKxLtEt+zQk0
 RE2g1gp2qN5e9ZRWKRChX421nlHiHQvGPmjRUAnXSIK9k14E65xFUwjY6S3k/ODIO3PA
 mJ+k+PlvDscmv3rXa4ki+SkwqA628+hEDWrDxqOoc3YLjsCkvDqM1gW7NJHJ0J4ZObgJ
 syH6Gpt82HB6FJnkhCqxChzzjvoHD1jS75nOyEfwpNzBtZieEl9J30usYvfbRw+8u/1h
 qrVg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782697750; x=1783302550; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jT/vfohVavuQISs7KscSfDIUmHf64xT1apeI1DPbfMI=;
 b=W4PGMttgLD12nFpDg0FdBhK+6DOLtPiAzRafAxQ/9UEkHWmIk6WkJeS3vBnukJyQCi
 o/90UcDo/EOjcBybFJ64VecBG1Iy2jEEOtt6xNMmzWnJs7ZACFLoaI9BmMjtPR4Uwc3p
 ZmiyS34v5CgKVmhrjAPci5rVJaMp7Y5X7mIrOTdC3fuCgeWociESIc9rqcVEQU5NqI9+
 2yPEiGPzP9SHnj68p5lxydEOHiroEWidSUcx4J6k5uN44KkIZeqmEdQuoMW5R7m1VxPx
 mn/LqdUJ8BfUrHxOuaEtWHiVjdJmvpj7L/Ujwx6oXNeoVF+o6Hv6YmVMUzvTOyoxLZQU
 sGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782697750; x=1783302550;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jT/vfohVavuQISs7KscSfDIUmHf64xT1apeI1DPbfMI=;
 b=bb4WU2yF5XAowWcoZoTF/WDwW3m2aocSZSk6tLKHLyojfzBwdpkbKCBVmivwhZXARh
 CxxUkGMdG0xzd+TSB3gWrQS58kGhXel/rGOuDavr1FAiWGxQ0TgfQ36HgBGjyJDnEGkb
 b9CxD2GMh9VwLVLG/4e0vxFfsbEZ+tRHKaERSPl6LPCRbmcH4IS75iWjY6PzU3e5qwOO
 hNDytucxKjYZFPF2MPi/8QXZj1OdDxyf9yC3eXHB7Mmyj2T/iiYMC/reZ/5jfUkBRkPp
 9zpV12XkUBSIDmsvtXOsIeQQNoYBBb/CtDDghKv7xouW90HQEhaN0peTZQzT9oNW/Jzp
 ha9w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqsmYiqUGK9BaPGwowuAEDZ4eRVaJlIKOmJK+eQc9+o9rpM5KgqTv82HyYJ9Te4U7ypF/yJCyS467a1@nongnu.org
X-Gm-Message-State: AOJu0YwO52T9wk2Q/vXpo/bN5iweTqi+HmQ1Dp2oaXbQ/lhWUxPmBozW
 0T0dHo/YatrRzB9FdV6jmrYCVvbEEntfXAsH6AiDfOjl9+7HtZvhH6XZfT42kl0cNjVmSM0Ml22
 R3QOqYd8YTe0Of+1W5X840kn16ftlN1o=
X-Gm-Gg: AfdE7cnheNxsZH2P4e9u1HXyjQwK9vyheIOe7OGpgjQWuUXnXCjz3QbrK3TBcHYmU7R
 CHn2+SiIyKuJZEn+KtgozM4kXJYRvrnhN9inaNAru8ykXITHQTtyqy7CwuHMKqnGCTVhAYJM5Zw
 MUE30/miKrn1qojU1nLYtZ7tSAJkaA6ZMqfGvp0JsC7dPo4/bytpaY3+lCG+0UG8ij1H1Cn7EKr
 idNILmUFH/a2gzjpKYFD3IaV51KUiv1Ex2Q+1lZxMaJlLjclDEZCKKFZPM/oaNcVrzSchU2sWDc
 /X93eM8KleK8FrDWAcc0ef7YTs0=
X-Received: by 2002:a05:6402:5519:b0:698:3b7c:3b32 with SMTP id
 4fb4d7f45d1cf-6983b7c3ed1mr2877600a12.20.1782697750383; Sun, 28 Jun 2026
 18:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260616190147.1286316-1-visitorckw@gmail.com>
 <20260616190147.1286316-5-visitorckw@gmail.com>
In-Reply-To: <20260616190147.1286316-5-visitorckw@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Jun 2026 11:48:43 +1000
X-Gm-Features: AVVi8Ce5ivvEkjNMNmU8jLVRjUD7_UPvYNGXRjnCB2_1VPMoQ3c0CwS-zyH-GMA
Message-ID: <CAKmqyKNFFY=RVoU6puR-R2jMXUh58bFD=EbD32COvVWJaeuC2w@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] hw/riscv: Add Milk-V Duo board support
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, alistair.francis@wdc.com,
 farosas@suse.de, lvivier@redhat.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu.zevorn@gmail.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, 
 marscheng@google.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jun 17, 2026 at 5:04=E2=80=AFAM Kuan-Wei Chiu <visitorckw@gmail.com=
> wrote:
>
> Add support for the Milk-V Duo development board, which is powered by
> the Sophgo CV1800B SoC.
>
> The implementation includes:
> - Board-level machine initialization with 64mb of default ram.
> - Integration of the CV1800B SoC.
> - Support for loading external FDT, kernel, and initrd images.
> - Proper setup of the reset vector to match the CV1800B's boot flow.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  MAINTAINERS                                 |  11 ++
>  configs/devices/riscv64-softmmu/default.mak |   1 +
>  hw/riscv/Kconfig                            |   6 +
>  hw/riscv/meson.build                        |   1 +
>  hw/riscv/milkv_duo.c                        | 124 ++++++++++++++++++++
>  5 files changed, 143 insertions(+)
>  create mode 100644 hw/riscv/milkv_duo.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93df53d87f..e197dcb5b2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1797,6 +1797,17 @@ F: include/hw/riscv/k230.h
>  F: include/hw/watchdog/k230_wdt.h
>  F: tests/qtest/k230-wdt-test.c
>
> +Milk-V Duo
> +M: Kuan-Wei Chiu <visitorckw@gmail.com>
> +S: Maintained
> +F: hw/char/dw8250.c
> +F: hw/misc/cv1800b_clk.c
> +F: hw/riscv/cv1800b.c
> +F: hw/riscv/milkv_duo.c
> +F: include/hw/char/dw8250.h
> +F: include/hw/misc/cv1800b_clk.h
> +F: include/hw/riscv/cv1800b.h
> +
>  RX Machines
>  -----------
>  rx-gdbsim
> diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/device=
s/riscv64-softmmu/default.mak
> index a8e4d0ab33..2ba91b14d4 100644
> --- a/configs/devices/riscv64-softmmu/default.mak
> +++ b/configs/devices/riscv64-softmmu/default.mak
> @@ -13,3 +13,4 @@
>  # CONFIG_SHAKTI_C=3Dn
>  # CONFIG_XIANGSHAN_KUNMINGHU=3Dn
>  # CONFIG_MIPS_BOSTON_AIA=3Dn
> +# CONFIG_MILKV_DUO=3Dn
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 299baed4a8..42a0e78574 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -157,3 +157,9 @@ config SOPHGO_CV1800B
>      select SIFIVE_PLIC
>      select SOPHGO_CV1800B_CLK
>      select DW8250
> +
> +config MILKV_DUO
> +    bool
> +    depends on RISCV64
> +    default y
> +    select SOPHGO_CV1800B
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index 6c242d77da..8c88f2bc25 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -20,5 +20,6 @@ riscv_ss.add(when: 'CONFIG_MIPS_BOSTON_AIA', if_true: f=
iles('boston-aia.c'))
>  riscv_ss.add(when: 'CONFIG_K230', if_true: files('k230.c'))
>
>  riscv_ss.add(when: 'CONFIG_SOPHGO_CV1800B', if_true: files('cv1800b.c'))
> +riscv_ss.add(when: 'CONFIG_MILKV_DUO', if_true: files('milkv_duo.c'))
>
>  hw_arch +=3D {'riscv': riscv_ss}
> diff --git a/hw/riscv/milkv_duo.c b/hw/riscv/milkv_duo.c
> new file mode 100644
> index 0000000000..8e9a553a57
> --- /dev/null
> +++ b/hw/riscv/milkv_duo.c
> @@ -0,0 +1,124 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Milk-V Duo board
> + *
> + * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qapi/error.h"
> +#include "hw/core/boards.h"
> +#include "hw/riscv/cv1800b.h"
> +#include "hw/riscv/boot.h"
> +#include "target/riscv/cpu-qom.h"
> +#include "system/system.h"
> +#include "system/device_tree.h"
> +#include "qemu/error-report.h"
> +#include "hw/core/loader.h"
> +#include <libfdt.h>
> +#include "hw/riscv/machines-qom.h"
> +
> +struct MilkVDuoState {
> +    MachineState parent_obj;
> +    CV1800BSoCState soc;
> +};
> +
> +#define TYPE_MILK_V_DUO MACHINE_TYPE_NAME("milkv-duo")
> +OBJECT_DECLARE_SIMPLE_TYPE(MilkVDuoState, MILK_V_DUO)
> +
> +static void milkv_duo_init(MachineState *machine)
> +{
> +    MilkVDuoState *s =3D MILK_V_DUO(machine);
> +    MemoryRegion *system_memory =3D get_system_memory();
> +    RISCVBootInfo boot_info;
> +    hwaddr firmware_load_addr, firmware_end_addr;
> +    hwaddr fdt_load_addr =3D 0;
> +    int fdt_size =3D 0;
> +    uint64_t kernel_entry =3D 0;
> +
> +    object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_CV1800=
B_SOC);
> +    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
> +
> +    memory_region_add_subregion(system_memory,
> +                                cv1800b_memmap[CV1800B_DEV_DRAM].base,
> +                                machine->ram);
> +
> +    riscv_boot_info_init(&boot_info, &s->soc.cpus);
> +
> +    firmware_load_addr =3D cv1800b_memmap[CV1800B_DEV_DRAM].base;
> +    firmware_end_addr =3D firmware_load_addr;
> +    if (machine->firmware) {
> +        firmware_end_addr =3D riscv_find_and_load_firmware(machine, mach=
ine->firmware,
> +                                                         &firmware_load_=
addr, NULL);
> +    }
> +
> +    if (machine->dtb) {
> +        machine->fdt =3D load_device_tree(machine->dtb, &fdt_size);
> +        if (!machine->fdt) {
> +            error_report("Failed to load device tree");
> +            exit(1);
> +        }
> +
> +        if (machine->kernel_cmdline && *machine->kernel_cmdline) {
> +            if (fdt_path_offset(machine->fdt, "/chosen") < 0) {
> +                qemu_fdt_add_subnode(machine->fdt, "/chosen");
> +            }
> +            qemu_fdt_setprop_string(machine->fdt, "/chosen", "bootargs",
> +                                    machine->kernel_cmdline);
> +        }
> +    }
> +
> +    if (machine->kernel_filename) {
> +        hwaddr kernel_start_addr =3D riscv_calc_kernel_start_addr(&boot_=
info,
> +                                                                firmware=
_end_addr);
> +        riscv_load_kernel(machine, &boot_info, kernel_start_addr, true, =
NULL);
> +        kernel_entry =3D boot_info.image_low_addr;
> +    }
> +
> +    if (machine->dtb) {
> +        fdt_load_addr =3D riscv_compute_fdt_addr(cv1800b_memmap[CV1800B_=
DEV_DRAM].base,
> +                                               machine->ram_size, machin=
e, &boot_info);
> +        rom_add_blob_fixed_as("fdt", machine->fdt, fdt_size, fdt_load_ad=
dr,
> +                              &address_space_memory);
> +    }
> +
> +    riscv_setup_rom_reset_vec(machine, &s->soc.cpus,
> +                              firmware_load_addr,
> +                              cv1800b_memmap[CV1800B_DEV_ROM].base,
> +                              cv1800b_memmap[CV1800B_DEV_ROM].size,
> +                              kernel_entry,
> +                              fdt_load_addr);
> +}
> +
> +static void milkv_duo_machine_class_init(ObjectClass *oc, const void *da=
ta)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +    static const char *const valid_cpu_types[] =3D {
> +        TYPE_RISCV_CPU_THEAD_C906,
> +        NULL
> +    };
> +
> +    mc->desc =3D "Milk-V Duo Board (CV1800B)";
> +    mc->init =3D milkv_duo_init;
> +    mc->max_cpus =3D 2;
> +    mc->default_cpu_type =3D TYPE_RISCV_CPU_THEAD_C906;
> +    mc->valid_cpu_types =3D valid_cpu_types;
> +    mc->default_ram_size =3D 64 * MiB;
> +    mc->default_ram_id =3D "riscv.milkv_duo.ram";
> +}
> +
> +static const TypeInfo milkv_duo_machine_type_info =3D {
> +    .name =3D TYPE_MILK_V_DUO,
> +    .parent =3D TYPE_MACHINE,
> +    .instance_size =3D sizeof(MilkVDuoState),
> +    .class_init =3D milkv_duo_machine_class_init,
> +    .interfaces =3D riscv64_machine_interfaces,
> +};
> +
> +static void milkv_duo_machine_register_types(void)
> +{
> +    type_register_static(&milkv_duo_machine_type_info);
> +}
> +
> +type_init(milkv_duo_machine_register_types)
> --
> 2.54.0.1136.gdb2ca164c4-goog
>
>

