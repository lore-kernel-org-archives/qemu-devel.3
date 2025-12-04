Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDD0D1D868
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 05:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR22f-0005tv-NF; Thu, 04 Dec 2025 00:38:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apatel@ventanamicro.com>)
 id 1vR22a-0005t5-9n
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 00:38:09 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apatel@ventanamicro.com>)
 id 1vR22X-0005WC-Ve
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 00:38:08 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5957db5bdedso592008e87.2
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 21:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1764826683; x=1765431483; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TENGsAuzFQj0J9MlW6A17jxyYqLF1csPJGDikk7elEw=;
 b=T83tM2V1ai2YfTnScDSoBGzHmB6DbHHlc/o+zAS2kGyO1YXdYEnPhWGGf7glqRXJxx
 5AQB8pSwv3AEMi3Qnyr4//QZrK9/1qMu21K8KzoRD6oWu0TQE/XJQxgwMFPB1W8M5fgY
 13Y/S4RVFdfsZD5pzMcFFSKKaIyoz0um5S/J3habHytjH44Ui2BfNktuaG8cZ7wLNKD5
 j6Itf8eSAxuG8zFmCFHJ//XF8gO7koP9Gwj30koja0/wtiYbMI+rJ/SZPN8NpURfpq2E
 H+AgY6Rv9fz0Ryhxa3ow/0C923CBcy/K44EBaZpgH8EA7mxmChY/dzOInQDds1zPQqP3
 YCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764826683; x=1765431483;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TENGsAuzFQj0J9MlW6A17jxyYqLF1csPJGDikk7elEw=;
 b=iUyxGiNqoNBXBtOSOaUi9Oxcd+iRAGN3gyF6JZwwowBdKnYOlzkHORZF22YoIN2lmB
 mJbIxgqFgZvg2Ud+maKNAR43U762Y3qnfe4pIxXfpCV4ujCu4fLBAKLBRYbgu+iQJq7T
 /ay0vler5woakzdmTxY8XGXpewWfyR8rmdza5OqHucIvFVU5Idx1sJRpjT1ioNk964YK
 A8KdKnGdACsd45pqkMoxv3GrZf/SapqraGTHi0XiokNFEXpXk6/lGA4AkVnEYN+1mUxl
 cCfbA8tvTPbuXL1z2buxkxOuzn66ITNMdhWV8wHsDxaPva8dXpmPfMjAXe+QcrqdqgWH
 FmWA==
X-Gm-Message-State: AOJu0YyWw1PouA5X/VbvICQy/4Nr7faIy1pTg14Xpka2HtHvQi5G7xr9
 mzs3neEMzRtwN4ZfE/FgnqkzbeJh1f9abXOuzGDSrxw5zKbHpXa1/JubBRjxE/nBKFi2XmBZS9x
 Krmr0pJs6UktKC1SjiSNbQdXDAMr31WBUAtye1rOHuA==
X-Gm-Gg: ASbGnctWb2ad6NW+ZrHTtYO1pEApY6bekEChGjJ0/RN5YQA1b/TlVgsooD20B2PJOSb
 qxKTGKk4lkzB9/8PDU+TOsowIbJDxXNykXKpmtsOCge0yd3VyQKrISfvvwkGsMiVvd+3cP9MDoz
 /MYdTAopECswIaFcr5tzQWp22XzJwCrxs37CkQUDwt7l8KKYTlXI0PbeOWQDruwK94scupLOlvX
 LxsV3XVuOp23rNZXcce0DID+oeC6Re6xX1SBU6Gq+5T4CDqFNDJlZ3YCbldpHc7MTBCyrk=
X-Google-Smtp-Source: AGHT+IEaUljsOdQ+iM0nMQyiZCVjJIodGfUjV70wVK6LVltoA9qfLiekdKRmHbtkH/IfIJRL21F0R2MMp9Z+5lCbtWM=
X-Received: by 2002:a05:6512:1092:b0:594:522b:c6a4 with SMTP id
 2adb3069b0e04-597d3fa656cmr2078819e87.23.1764826683220; Wed, 03 Dec 2025
 21:38:03 -0800 (PST)
MIME-Version: 1.0
References: <20251111182944.2895892-1-dbarboza@ventanamicro.com>
 <20251111182944.2895892-4-dbarboza@ventanamicro.com>
In-Reply-To: <20251111182944.2895892-4-dbarboza@ventanamicro.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 4 Dec 2025 11:07:51 +0530
X-Gm-Features: AWmQ_bm8zDPy9Hm587cei3bCECclSN7QzvjQ4E5CXuoyv61Ggd5H7nogpEfvqQI
Message-ID: <CAK9=C2V32O_toANCx5MDSoSYMtA7W0tRTrhE1djXA1etTuKVuQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] hw/riscv: experimental server platform reference
 machine
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, 
 Fei Wu <wu.fei9@sanechips.com.cn>, Sunil V L <sunilvl@ventanamicro.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=apatel@ventanamicro.com; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Nov 12, 2025 at 12:02=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> From: Fei Wu <wu.fei9@sanechips.com.cn>
>
> The RISC-V Server Platform specification [1] defines a standardized set
> of hardware and software capabilities, that portable system software,
> such as OS and hypervisors can rely on being present in a RISC-V server
> platform.
>
> We do not have all the required extensions in QEMU: we're missing
> 'sdext'. In theory we shouldn't go ahead with this work, but the
> emulation as is now is proving to be useful for development and testing
> of other parts of the SW stack (firmware, kernel) and we would like to
> make it broadly available to everyone. We're contributing it as
> 'experimental', hopefully making it clear that the board does NOT
> complies 100% with [1].
>
> The main features included in this emulation are:
>
>  - Based on riscv virt machine type
>  - A new memory map as close as virt machine as possible
>  - A new virt CPU type rvsp-ref-cpu for server platform compliance
>  - AIA
>  - PCIe AHCI
>  - PCIe NIC
>  - No virtio device
>  - No fw_cfg device
>  - No ACPI table provided
>  - Only minimal device tree nodes
>
> [1] https://github.com/riscv-non-isa/riscv-server-platform
>
> Signed-off-by: Fei Wu <fei2.wu@intel.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  configs/devices/riscv64-softmmu/default.mak |    1 +
>  hw/riscv/Kconfig                            |   14 +
>  hw/riscv/meson.build                        |    1 +
>  hw/riscv/server_platform_ref.c              | 1276 +++++++++++++++++++
>  4 files changed, 1292 insertions(+)
>  create mode 100644 hw/riscv/server_platform_ref.c
>
> diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/device=
s/riscv64-softmmu/default.mak
> index e485bbd1a3..e6075a7113 100644
> --- a/configs/devices/riscv64-softmmu/default.mak
> +++ b/configs/devices/riscv64-softmmu/default.mak
> @@ -9,6 +9,7 @@
>  # CONFIG_SIFIVE_E=3Dn
>  # CONFIG_SIFIVE_U=3Dn
>  # CONFIG_RISCV_VIRT=3Dn
> +# CONFIG_SERVER_PLATFORM_REF=3Dn
>  # CONFIG_MICROCHIP_PFSOC=3Dn
>  # CONFIG_SHAKTI_C=3Dn
>  # CONFIG_XIANGSHAN_KUNMINGHU=3Dn
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index fc9c35bd98..6a5085c7a5 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -69,6 +69,20 @@ config RISCV_VIRT
>      select ACPI
>      select ACPI_PCI
>
> +config SERVER_PLATFORM_REF

s/SERVER_PLATFORM_REF/RISCV_SERVER_PLATFORM/

> +    bool
> +    default y
> +    depends on RISCV64
> +    select RISCV_NUMA
> +    select GOLDFISH_RTC
> +    select PCI
> +    select PCI_EXPRESS_GENERIC_BRIDGE
> +    select PFLASH_CFI01
> +    select SERIAL
> +    select RISCV_ACLINT
> +    select RISCV_APLIC
> +    select RISCV_IMSIC
> +
>  config SHAKTI_C
>      bool
>      default y
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index 2a8d5b136c..0daf77e887 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -4,6 +4,7 @@ riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('n=
uma.c'))
>  riscv_ss.add(files('riscv_hart.c'))
>  riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
>  riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
> +riscv_ss.add(when: 'CONFIG_SERVER_PLATFORM_REF', if_true: files('server_=
platform_ref.c'))
>  riscv_ss.add(when: 'CONFIG_SHAKTI_C', if_true: files('shakti_c.c'))
>  riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
>  riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
> diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_re=
f.c
> new file mode 100644
> index 0000000000..ef2891a9d7
> --- /dev/null
> +++ b/hw/riscv/server_platform_ref.c
> @@ -0,0 +1,1276 @@
> +/*
> + * QEMU RISC-V Server Platform (RVSP) Reference Board

Instead of "rvsp" name it is better to use a more obvious and
meaningful full name such as "rvserver".

> + *
> + * Copyright (c) 2024 Intel, Inc.
> + * Copyright (c) 2025 Ventana Micro Systems Inc.
> + *
> + * This board is compliant RISC-V Server platform specification and leve=
raging
> + * a lot of riscv virt code.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qemu/error-report.h"
> +#include "qemu/guest-random.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-visit-common.h"
> +#include "hw/boards.h"
> +#include "hw/loader.h"
> +#include "hw/sysbus.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/char/serial.h"
> +#include "hw/block/flash.h"
> +#include "hw/ide/pci.h"
> +#include "hw/ide/ahci-pci.h"
> +#include "hw/pci/pci.h"
> +#include "hw/pci-host/gpex.h"
> +#include "hw/core/sysbus-fdt.h"
> +#include "hw/riscv/riscv_hart.h"
> +#include "hw/riscv/boot.h"
> +#include "hw/riscv/numa.h"
> +#include "hw/intc/riscv_aclint.h"
> +#include "hw/intc/riscv_aplic.h"
> +#include "hw/intc/riscv_imsic.h"
> +#include "chardev/char.h"
> +#include "hw/char/serial-mm.h"
> +#include "system/device_tree.h"
> +#include "system/runstate.h"
> +#include "system/system.h"
> +#include "system/tcg.h"
> +#include "system/qtest.h"
> +#include "target/riscv/cpu.h"
> +#include "target/riscv/pmu.h"
> +#include "net/net.h"
> +
> +#define RVSP_CPUS_MAX_BITS             9
> +#define RVSP_CPUS_MAX                  (1 << RVSP_CPUS_MAX_BITS)
> +#define RVSP_SOCKETS_MAX_BITS          2
> +#define RVSP_SOCKETS_MAX               (1 << RVSP_SOCKETS_MAX_BITS)
> +
> +#define RVSP_IRQCHIP_NUM_MSIS 255
> +#define RVSP_IRQCHIP_NUM_SOURCES 96
> +#define RVSP_IRQCHIP_NUM_PRIO_BITS 3
> +#define RVSP_IRQCHIP_MAX_GUESTS_BITS 3
> +#define RVSP_IRQCHIP_MAX_GUESTS ((1U << RVSP_IRQCHIP_MAX_GUESTS_BITS) - =
1U)
> +
> +#define FDT_PCI_ADDR_CELLS    3
> +#define FDT_PCI_INT_CELLS     1
> +#define FDT_APLIC_INT_CELLS   2
> +#define FDT_IMSIC_INT_CELLS   0
> +#define FDT_MAX_INT_CELLS     2
> +#define FDT_MAX_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + =
\
> +                                 1 + FDT_MAX_INT_CELLS)
> +#define FDT_APLIC_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS =
+ \
> +                                 1 + FDT_APLIC_INT_CELLS)
> +
> +#define NUM_SATA_PORTS  6
> +
> +#define SYSCON_RESET     0x1
> +#define SYSCON_POWEROFF  0x2
> +
> +#define TYPE_RVSP_REF_MACHINE MACHINE_TYPE_NAME("rvsp-ref")
> +OBJECT_DECLARE_SIMPLE_TYPE(RVSPMachineState, RVSP_REF_MACHINE)
> +
> +struct RVSPMachineState {
> +    /*< private >*/
> +    MachineState parent;
> +
> +    /*< public >*/
> +    Notifier machine_done;
> +    RISCVHartArrayState soc[RVSP_SOCKETS_MAX];
> +    DeviceState *irqchip[RVSP_SOCKETS_MAX];
> +    PFlashCFI01 *flash[2];
> +
> +    int fdt_size;
> +    int aia_guests;
> +    const MemMapEntry *memmap;
> +};
> +
> +enum {
> +    RVSP_DEBUG,
> +    RVSP_MROM,
> +    RVSP_RESET_SYSCON,
> +    RVSP_RTC,
> +    RVSP_ACLINT,
> +    RVSP_APLIC_M,
> +    RVSP_APLIC_S,
> +    RVSP_UART0,
> +    RVSP_IMSIC_M,
> +    RVSP_IMSIC_S,
> +    RVSP_FLASH,
> +    RVSP_DRAM,
> +    RVSP_PCIE_MMIO,
> +    RVSP_PCIE_PIO,
> +    RVSP_PCIE_ECAM,
> +    RVSP_PCIE_MMIO_HIGH
> +};
> +
> +enum {
> +    RVSP_UART0_IRQ =3D 10,
> +    RVSP_RTC_IRQ =3D 11,
> +    RVSP_PCIE_IRQ =3D 0x20, /* 32 to 35 */
> +};
> +
> +/*
> + * The server soc reference machine physical address space used by some =
of the
> + * devices namely ACLINT, APLIC and IMSIC depend on number of Sockets, n=
umber
> + * of CPUs, and number of IMSIC guest files.
> + *
> + * Various limits defined by RVSP_SOCKETS_MAX_BITS, RVSP_CPUS_MAX_BITS, =
and
> + * RVSP_IRQCHIP_MAX_GUESTS_BITS are tuned for maximum utilization of ser=
ver soc
> + * reference machine physical address space.
> + */
> +
> +#define RVSP_IMSIC_GROUP_MAX_SIZE      (1U << IMSIC_MMIO_GROUP_MIN_SHIFT=
)
> +#if RVSP_IMSIC_GROUP_MAX_SIZE < \
> +    IMSIC_GROUP_SIZE(RVSP_CPUS_MAX_BITS, RVSP_IRQCHIP_MAX_GUESTS_BITS)
> +#error "Can't accomodate single IMSIC group in address space"
> +#endif
> +
> +#define RVSP_IMSIC_MAX_SIZE            (RVSP_SOCKETS_MAX * \
> +                                        RVSP_IMSIC_GROUP_MAX_SIZE)
> +#if 0x4000000 < RVSP_IMSIC_MAX_SIZE
> +#error "Can't accomodate all IMSIC groups in address space"
> +#endif
> +
> +static const MemMapEntry rvsp_ref_memmap[] =3D {
> +    [RVSP_DEBUG] =3D          {        0x0,         0x100 },
> +    [RVSP_MROM] =3D           {     0x1000,        0xf000 },
> +    [RVSP_RESET_SYSCON] =3D   {   0x100000,        0x1000 },
> +    [RVSP_RTC] =3D            {   0x101000,        0x1000 },
> +    [RVSP_ACLINT] =3D         {  0x2000000,       0x10000 },
> +    [RVSP_PCIE_PIO] =3D       {  0x3000000,       0x10000 },
> +    [RVSP_APLIC_M] =3D        {  0xc000000, APLIC_SIZE(RVSP_CPUS_MAX) },
> +    [RVSP_APLIC_S] =3D        {  0xd000000, APLIC_SIZE(RVSP_CPUS_MAX) },
> +    [RVSP_UART0] =3D          { 0x10000000,         0x100 },
> +    [RVSP_FLASH] =3D          { 0x20000000,     0x4000000 },
> +    [RVSP_IMSIC_M] =3D        { 0x24000000, RVSP_IMSIC_MAX_SIZE },
> +    [RVSP_IMSIC_S] =3D        { 0x28000000, RVSP_IMSIC_MAX_SIZE },
> +    [RVSP_PCIE_ECAM] =3D      { 0x30000000,    0x10000000 },
> +    [RVSP_PCIE_MMIO] =3D      { 0x40000000,    0x40000000 },
> +    [RVSP_DRAM] =3D           { 0x80000000, 0xff80000000ull },
> +    [RVSP_PCIE_MMIO_HIGH] =3D { 0x10000000000ull, 0x10000000000ull },

I think goal should be to have minimal possible MMIO devices in
"rvserver" and wherever required prefer PCIe devices or RPMI
messaging protocol. The "rvserver" must always have an IOMMU
as well. In general, the bar for adding MMIO device in "rvserver"
should be really high.

My suggestion is to drop the RESET_SYSCON and FLASH devices
in-favor of the RPMI system reset service group and RPMI MM service
group. Also, with RPMI support in "rvserver", we can have graceful
shutdown and reboot available using system MSIs. In other words,
"rvserver" should have RPMI shared memory transport emulated by
QEMU using the librpmi project.

For distros friendly boot flow, we can use U-Boot SPL as the bios such
that U-Boot SPL will load FIT image from ESP (EFI system partition)
of some PCIe storage device (as described in the EBBR specification).
The FIT image will contain OpenSBI and the final bootloader where the
final bootloader can be regular U-Boot or EDK2.

In fact, we (Ventana) have an internal PoC based on the above
suggestions which helps us use unmodified Ubuntu RISC-V
distributed by Canonical.

Regards,
Anup

