Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B27CC54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 12:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKcQF-0006wE-6B; Thu, 29 May 2025 08:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uKcQD-0006vi-G1
 for qemu-devel@nongnu.org; Thu, 29 May 2025 08:31:45 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uKcQA-0006z8-Qh
 for qemu-devel@nongnu.org; Thu, 29 May 2025 08:31:45 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso5371495e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 05:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1748521901; x=1749126701; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sdMCRkZJ14d7JDtYzX+jGxLo05g5/Mqwv1+UJpJUbj4=;
 b=JOE4DX7cg+eqN7KWOyenp/cQcLEtzc/yHKpt5eVN1p8d1KSEFvvV4cS+rrCT3kN8sC
 yZY2SDrY4wx1Rq6L86dEEkJzIfoC7xPajoF/kfirTSnEIhR4dahIxRBkgi/8Lp6F6O8h
 4lUPhYmWy4j2Ioxb/lIHKXcevsAPvt/s1KVh/UYpi+9kTcfXF5auWa6bC3FzwD6dsEmd
 gXE6PL6eVskS67tgenVeVRmwKuZ3oTUBiP2fNs7tz14CZLnri7HsRYZJUsEJR0mZCOze
 AA+kX8tVY3N95MgqhbXYRs2t8vl4ndjkVbf26Dy0k5l15liCZH3dvn5Ze9IX9pMWWeHk
 KH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748521901; x=1749126701;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sdMCRkZJ14d7JDtYzX+jGxLo05g5/Mqwv1+UJpJUbj4=;
 b=VpBQ/61iXxcRlHd6Y5qrZyQlmYppUSuAxcQ3anBCUzz+0FfgmXxz45IRrQ9cY0Ln0c
 a5pQbmCrVrf4IWztjeiCQTF6Y1+s+JS8uxQNmgq2gHT8xTeuRMEcO1vn4EGuLofBfeek
 6ReBfzchvPwSZ6XBbQbUXic1Ic+BEmGVFk/rbpVv6vpAqoTvorrpj6BtLEY04BEFE3qT
 hCF9DWSUiuHne+OWNcu/lpCAHCnhBqSMC7eYdw/AAtVtbSnRjxy7j1TM9JrhazT1O4xq
 rimMRGaGyJ6cJTqECHDEYXX42thLGEbX5bRll/+H/B0Lp1KyefeiMp/iVdZ8bxcjv4Wc
 Vx+A==
X-Gm-Message-State: AOJu0Yx+457orZIpM6pJcSwzs8MfWbtc57t4xDCCxOsW/v/ojsJLdDp9
 8ExqxQTax9/+W3EehqPzCBSFdPxWpB0F5/NIIX+u8Fmldx1hA3pKBCmIu4zPRFWVOvQ=
X-Gm-Gg: ASbGncsn3M36EpR1TQLnRNndJ8zke6kE60FY2JVOh1Yt6HaAWaRP5eulH+UguJqqUe4
 UETKhnnEGUSzimjqBF89TsnzfPYDwoNwJKFis+sS2XwM0IspXUOc87JtqCSA/42klOeQOR1SCPR
 Hyq1Hglz/22jr3MoPPzgbiaSAfMUp/eyDkVrYRHDZMuNqelRrYsetUTB9wgj0zBs2O+SBzPabUz
 PKVmWDI5icJVr+yvawS7BqX+50EqHGTMa7qJefjUwkiSBfZVthKMfbTtf7C9Y98giy3r6m+DC+G
 yXDtwQU04Qc9oqENv1qWe/4QASJc9t96oWgnHcc=
X-Google-Smtp-Source: AGHT+IEXzmlts1LsP2xTvM/T6epuHDAK664NQ/UhGb3L2LaQHe5bv9DFZBfdr7qhtIoYTfsWz+XXRg==
X-Received: by 2002:a05:600c:3b9c:b0:43c:ec4c:25b1 with SMTP id
 5b1f17b1804b1-450d054da8amr18618995e9.23.1748521900714; 
 Thu, 29 May 2025 05:31:40 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::ce80])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450cfbf42c1sm19327445e9.3.2025.05.29.05.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 05:31:40 -0700 (PDT)
Date: Thu, 29 May 2025 14:31:38 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, 
 Fei Wu <wu.fei9@sanechips.com.cn>
Subject: Re: [PATCH v3 3/4] hw/riscv: Add server platform reference machine
Message-ID: <20250529-f556ccdcd6a7ea100bd80d1a@orel>
References: <20250528200129.1548259-1-dbarboza@ventanamicro.com>
 <20250528200129.1548259-4-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528200129.1548259-4-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x332.google.com
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

On Wed, May 28, 2025 at 05:01:28PM -0300, Daniel Henrique Barboza wrote:
> From: Fei Wu <wu.fei9@sanechips.com.cn>
> 
> The RISC-V Server Platform specification[1] defines a standardized set
> of hardware and software capabilities, that portable system software,
> such as OS and hypervisors can rely on being present in a RISC-V server
> platform.
> 
> A corresponding Qemu RISC-V server platform reference (rvsp-ref for
> short) machine type is added to provide a environment for firmware/OS
> development and testing. The main features included in rvsp-ref are:
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

The server platform spec requires BRS-I (see FIRM_010). BRS-I requires
ACPI, and even some specific ACPI tables, e.g. PPTT (see Chapter 6 of
the BRS spec). However, I think the idea is we're suppose to generate
a DT here and then leave it to edk2 to generate ACPI tables from that
DT.

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
> diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/devices/riscv64-softmmu/default.mak
> index 39ed3a0061..0c4893b708 100644
> --- a/configs/devices/riscv64-softmmu/default.mak
> +++ b/configs/devices/riscv64-softmmu/default.mak
> @@ -9,5 +9,6 @@
>  # CONFIG_SIFIVE_E=n
>  # CONFIG_SIFIVE_U=n
>  # CONFIG_RISCV_VIRT=n
> +# CONFIG_SERVER_PLATFORM_REF=n
>  # CONFIG_MICROCHIP_PFSOC=n
>  # CONFIG_SHAKTI_C=n
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index e6a0ac1fa1..f626774c52 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -69,6 +69,20 @@ config RISCV_VIRT
>      select ACPI
>      select ACPI_PCI
>  
> +config SERVER_PLATFORM_REF
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

We shouldn't need ACLINT.

> +    select RISCV_APLIC
> +    select RISCV_IMSIC
> +
>  config SHAKTI_C
>      bool
>      default y
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index c22f3a7216..7a663fac64 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -4,6 +4,7 @@ riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
>  riscv_ss.add(files('riscv_hart.c'))
>  riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
>  riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
> +riscv_ss.add(when: 'CONFIG_SERVER_PLATFORM_REF', if_true: files('server_platform_ref.c'))
>  riscv_ss.add(when: 'CONFIG_SHAKTI_C', if_true: files('shakti_c.c'))
>  riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
>  riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
> diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
> new file mode 100644
> index 0000000000..5102286103
> --- /dev/null
> +++ b/hw/riscv/server_platform_ref.c
> @@ -0,0 +1,1276 @@

Missing SPDX

> +/*
> + * QEMU RISC-V Server Platform (RVSP) Reference Board
> + *
> + * Copyright (c) 2024 Intel, Inc.
> + * Copyright (c) 2025 Ventana Micro Systems Inc.
> + *
> + * This board is compliant RISC-V Server platform specification and leveraging
> + * a lot of riscv virt code.

This board provides a reference implementation of the RISC-V Server
Platform specification. 

> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.

Can be dropped, since we want SPDX instead.

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
> +#define RVSP_IRQCHIP_MAX_GUESTS ((1U << RVSP_IRQCHIP_MAX_GUESTS_BITS) - 1U)
> +
> +#define FDT_PCI_ADDR_CELLS    3
> +#define FDT_PCI_INT_CELLS     1
> +#define FDT_APLIC_INT_CELLS   2
> +#define FDT_IMSIC_INT_CELLS   0
> +#define FDT_MAX_INT_CELLS     2
> +#define FDT_MAX_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
> +                                 1 + FDT_MAX_INT_CELLS)
> +#define FDT_APLIC_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
> +                                 1 + FDT_APLIC_INT_CELLS)
> +
> +#define NUM_SATA_PORTS  6
> +
> +#define SYSCON_RESET     0x1
> +#define SYSCON_POWEROFF  0x2

nit: should align all the above defines

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

This can be hard coded to 5, as required by the server-soc spec.

Thanks,
drew

