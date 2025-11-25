Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDBCD0E6C4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 11:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNr9w-00025d-JA; Tue, 25 Nov 2025 06:24:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vNr9u-00023i-An
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 06:24:34 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vNr9r-0005bp-TY
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 06:24:33 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2955623e6faso63067065ad.1
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 03:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1764069870; x=1764674670; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OlJU5560DCLx/I0dP0FAI6d4yobFRnrr8Vxh7F9JD7c=;
 b=fCdo4fGu1r5MeC2Bc8s4oK/ZpBuAqL4Si4psjUOFF9MiG5QWM93K3PueWX0Ze0X4k/
 DT2MYev585mySFkpvGID+fkZ/T7BpoOdzY6PEhsLN7uUJohS4mWYjeoYRJeCk6IYCCuM
 FSeSL71nTBfVSwcyztxmw38RcJtXcZA910yLfi2N0OcTZSSP6kxoKHDFLSvMNDuZd8qG
 A+LfQWOntjCTr8sOZ5ALMfXcBvzaC2UgPbX5FAiXCofgNKrZU4eAqdfCmmronjjdNOqC
 aqvEW2A2MV5PKaSjn9GU8Pj06MwaWilcZj09WG5cikdXxUK9xd9sqt6uokqcyozA9CAt
 eqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764069870; x=1764674670;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OlJU5560DCLx/I0dP0FAI6d4yobFRnrr8Vxh7F9JD7c=;
 b=T60+0Mxjt6ypN14J7R/dHdfPe523m0nJN6Qh0x4cByOPrx3i/Z9i1dEUOR6O6PPumQ
 GdTgrZoE2o/wqkPOpZLPuLDtA98ChFa7gmDyVqEcg+Y1XpF7tXupnJyz9DPhzK5agiMS
 A4+SZWeGijfdaaoOOcB3qS542+GPr3e8MrypJYUJj3O39Q4Zf6kYWJjvfJDDZ235OSCx
 jLE5NBICnzuZKY6oswdilCpiErNKW+5tq5sFfV0oBLapnVJDaMXgwQL6t0N65HVmcNPd
 ncl6O01Hybi+QN81Qyb5Ec02wo3sxytU4vT14X1GaCn1P8/VNLppU6ECmpohOnitTN2O
 eNtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzq4ik7RM8V9dfrd9NukUzAVhQVQtNgvCcnHmpcAuw0+kdM/u4gTI6KcFZ0veQTilQOpXMsHWRRkdX@nongnu.org
X-Gm-Message-State: AOJu0YzfNWf6sbxTWbmdn1p06Y0IJ2kCWUIOh7dw82OgJGK2odx0uo5y
 a52w+MCIiYDXh+9lBg7kikqJHhjhD5UXHdgDqA1k9xGqd+p6eYkz8wk05NslPK3xJ5A=
X-Gm-Gg: ASbGnctVasJB7HTfxq0rDrdc9xjc2uCKdifiuh1CG9qlwQm6nF0SBVOMsQIk5LTgtVh
 Hlf7fBRiqHePCeppQOncWDSfeDA2LADu38dUBWTKyQFZg/P3a6Y6JEwDWVo12rMp3szv5aDHSKH
 XRmL4EQ3cviY5l9omi6mtkuR3w0JBPTSQI4tJAOxz7dUw12T+Vcoe5954WVxfukJoBL1Xg8gtsN
 6JjM47B1kZOgJnlpCES02exXeLO9G5agWFMIKmwKX/2+PBRsAqesM1vY/1ZIlNdCtxOfFcsrIhi
 TFUu8emlv7FUg1UwO7vvVFrhmqnS4TF4EStUjyGS8vTWfaLE84HRPIiIQTwZFjdpYwCh94hLLwa
 fr4V/nhQVAqV9QwgFXH9XKy2ZmE5+nllV3GQwoCQqfYu66L4uzWzIG9jmwinttihN+P5VBVb8Qe
 6xJsYBrqMBpYbxjygwuFyzYR3AyA==
X-Google-Smtp-Source: AGHT+IHmKE9PT36s1zgHFJWwuRW21I9HvVChLbUlLGx3rynDqKwYQGUWMDgBaNtIHOX6UfrcZo5R5Q==
X-Received: by 2002:a17:903:11cc:b0:295:223b:cdee with SMTP id
 d9443c01a7336-29baaf9a98dmr29597255ad.14.1764069869679; 
 Tue, 25 Nov 2025 03:24:29 -0800 (PST)
Received: from [192.168.68.110] ([179.133.97.212])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b106094sm167281625ad.10.2025.11.25.03.24.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 03:24:29 -0800 (PST)
Message-ID: <ef829d73-f39c-421a-8ebd-ef5422a7fedc@ventanamicro.com>
Date: Tue, 25 Nov 2025 08:24:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] hw/riscv: experimental server platform reference
 machine
To: Chao Liu <chao.liu.riscv@isrc.iscas.ac.cn>
Cc: alistair.francis@wdc.com, liwei1518@gmail.com, palmer@dabbelt.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, wu.fei9@sanechips.com.cn,
 zhiwei_liu@linux.alibaba.com, xiaofan@iscas.ac.cn, wangjingwei@iscas.ac.cn,
 Andrew Jones <ajones@ventanamicro.com>
References: <20251111182944.2895892-4-dbarboza@ventanamicro.com>
 <b1d0bc43-96cd-4919-b5c5-d004e422e902@isrc.iscas.ac.cn>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <b1d0bc43-96cd-4919-b5c5-d004e422e902@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
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



On 11/23/25 10:56 PM, Chao Liu wrote:
> On Tue, 11 Nov 2025 15:29:42 -0300, Daniel Henrique Barboza wrote:
>> From: Fei Wu <wu.fei9@sanechips.com.cn>
>>
>> The RISC-V Server Platform specification [1] defines a standardized set
>> of hardware and software capabilities, that portable system software,
>> such as OS and hypervisors can rely on being present in a RISC-V server
>> platform.
>>
>> We do not have all the required extensions in QEMU: we're missing
>> 'sdext'. In theory we shouldn't go ahead with this work, but the
>> emulation as is now is proving to be useful for development and testing
>> of other parts of the SW stack (firmware, kernel) and we would like to
>> make it broadly available to everyone. We're contributing it as
>> 'experimental', hopefully making it clear that the board does NOT
>> complies 100% with [1].
>>
>> The main features included in this emulation are:
>>
>> - Based on riscv virt machine type
>> - A new memory map as close as virt machine as possible
>> - A new virt CPU type rvsp-ref-cpu for server platform compliance
>> - AIA
>> - PCIe AHCI
>> - PCIe NIC
>> - No virtio device
>> - No fw_cfg device
>> - No ACPI table provided
>> - Only minimal device tree nodes
>>
>> [1] https://github.com/riscv-non-isa/riscv-server-platform
>>
>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>> configs/devices/riscv64-softmmu/default.mak |    1 +
>> hw/riscv/Kconfig                            |   14 +
>> hw/riscv/meson.build                        |    1 +
>> hw/riscv/server_platform_ref.c              | 1276 +++++++++++++++++++
>> 4 files changed, 1292 insertions(+)
>> create mode 100644 hw/riscv/server_platform_ref.c
>>
>> diff --git a/configs/devices/riscv64-softmmu/default.mak
> b/configs/devices/riscv64-softmmu/default.mak
>> index e485bbd1a3..e6075a7113 100644
>> --- a/configs/devices/riscv64-softmmu/default.mak
>> +++ b/configs/devices/riscv64-softmmu/default.mak
>> @@ -9,6 +9,7 @@
>> # CONFIG_SIFIVE_E=n
>> # CONFIG_SIFIVE_U=n
>> # CONFIG_RISCV_VIRT=n
>> +# CONFIG_SERVER_PLATFORM_REF=n
>> # CONFIG_MICROCHIP_PFSOC=n
>> # CONFIG_SHAKTI_C=n
>> # CONFIG_XIANGSHAN_KUNMINGHU=n
>> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
>> index fc9c35bd98..6a5085c7a5 100644
>> --- a/hw/riscv/Kconfig
>> +++ b/hw/riscv/Kconfig
>> @@ -69,6 +69,20 @@ config RISCV_VIRT
>>      select ACPI
>>      select ACPI_PCI
>>
>> +config SERVER_PLATFORM_REF
>> +    bool
>> +    default y
>> +    depends on RISCV64
>> +    select RISCV_NUMA
>> +    select GOLDFISH_RTC
>> +    select PCI
>> +    select PCI_EXPRESS_GENERIC_BRIDGE
>> +    select PFLASH_CFI01
>> +    select SERIAL
>> +    select RISCV_ACLINT
>> +    select RISCV_APLIC
>> +    select RISCV_IMSIC
>> +
>> config SHAKTI_C
>>      bool
>>      default y
>> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
>> index 2a8d5b136c..0daf77e887 100644
>> --- a/hw/riscv/meson.build
>> +++ b/hw/riscv/meson.build
>> @@ -4,6 +4,7 @@ riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
>> riscv_ss.add(files('riscv_hart.c'))
>> riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
>> riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
>> +riscv_ss.add(when: 'CONFIG_SERVER_PLATFORM_REF', if_true:
> files('server_platform_ref.c'))
>> riscv_ss.add(when: 'CONFIG_SHAKTI_C', if_true: files('shakti_c.c'))
>> riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
>> riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
>> diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
>> new file mode 100644
>> index 0000000000..ef2891a9d7
>> --- /dev/null
>> +++ b/hw/riscv/server_platform_ref.c
>> @@ -0,0 +1,1276 @@
>> +/*
>> + * QEMU RISC-V Server Platform (RVSP) Reference Board
>> + *
>> + * Copyright (c) 2024 Intel, Inc.
>> + * Copyright (c) 2025 Ventana Micro Systems Inc.
>> + *
>> + * This board is compliant RISC-V Server platform specification and leveraging
>> + * a lot of riscv virt code.
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/units.h"
>> +#include "qemu/error-report.h"
>> +#include "qemu/guest-random.h"
>> +#include "qapi/error.h"
>> +#include "qapi/qapi-visit-common.h"
>> +#include "hw/boards.h"
>> +#include "hw/loader.h"
>> +#include "hw/sysbus.h"
>> +#include "hw/qdev-properties.h"
>> +#include "hw/char/serial.h"
>> +#include "hw/block/flash.h"
>> +#include "hw/ide/pci.h"
>> +#include "hw/ide/ahci-pci.h"
>> +#include "hw/pci/pci.h"
>> +#include "hw/pci-host/gpex.h"
>> +#include "hw/core/sysbus-fdt.h"
>> +#include "hw/riscv/riscv_hart.h"
>> +#include "hw/riscv/boot.h"
>> +#include "hw/riscv/numa.h"
>> +#include "hw/intc/riscv_aclint.h"
>> +#include "hw/intc/riscv_aplic.h"
>> +#include "hw/intc/riscv_imsic.h"
>> +#include "chardev/char.h"
>> +#include "hw/char/serial-mm.h"
>> +#include "system/device_tree.h"
>> +#include "system/runstate.h"
>> +#include "system/system.h"
>> +#include "system/tcg.h"
>> +#include "system/qtest.h"
>> +#include "target/riscv/cpu.h"
>> +#include "target/riscv/pmu.h"
>> +#include "net/net.h"
>> +
>> +#define RVSP_CPUS_MAX_BITS             9
>> +#define RVSP_CPUS_MAX                  (1 << RVSP_CPUS_MAX_BITS)
>> +#define RVSP_SOCKETS_MAX_BITS          2
>> +#define RVSP_SOCKETS_MAX               (1 << RVSP_SOCKETS_MAX_BITS)
>> +
>> +#define RVSP_IRQCHIP_NUM_MSIS 255
>> +#define RVSP_IRQCHIP_NUM_SOURCES 96
>> +#define RVSP_IRQCHIP_NUM_PRIO_BITS 3
>> +#define RVSP_IRQCHIP_MAX_GUESTS_BITS 3
>> +#define RVSP_IRQCHIP_MAX_GUESTS ((1U << RVSP_IRQCHIP_MAX_GUESTS_BITS) - 1U)
>> +
>> +#define FDT_PCI_ADDR_CELLS    3
>> +#define FDT_PCI_INT_CELLS     1
>> +#define FDT_APLIC_INT_CELLS   2
>> +#define FDT_IMSIC_INT_CELLS   0
>> +#define FDT_MAX_INT_CELLS     2
>> +#define FDT_MAX_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
>> +                                 1 + FDT_MAX_INT_CELLS)
>> +#define FDT_APLIC_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
>> +                                 1 + FDT_APLIC_INT_CELLS)
>> +
>> +#define NUM_SATA_PORTS  6
>> +
>> +#define SYSCON_RESET     0x1
>> +#define SYSCON_POWEROFF  0x2
>> +
>> +#define TYPE_RVSP_REF_MACHINE MACHINE_TYPE_NAME("rvsp-ref")
>> +OBJECT_DECLARE_SIMPLE_TYPE(RVSPMachineState, RVSP_REF_MACHINE)
>> +
>> +struct RVSPMachineState {
>> +    /*< private >*/
>> +    MachineState parent;
>> +
>> +    /*< public >*/
>> +    Notifier machine_done;
>> +    RISCVHartArrayState soc[RVSP_SOCKETS_MAX];
>> +    DeviceState *irqchip[RVSP_SOCKETS_MAX];
>> +    PFlashCFI01 *flash[2];
>> +
>> +    int fdt_size;
>> +    int aia_guests;
>> +    const MemMapEntry *memmap;
>> +};
>> +
>> +enum {
>> +    RVSP_DEBUG,
>> +    RVSP_MROM,
>> +    RVSP_RESET_SYSCON,
>> +    RVSP_RTC,
>> +    RVSP_ACLINT,
>> +    RVSP_APLIC_M,
>> +    RVSP_APLIC_S,
>> +    RVSP_UART0,
>> +    RVSP_IMSIC_M,
>> +    RVSP_IMSIC_S,
>> +    RVSP_FLASH,
>> +    RVSP_DRAM,
>> +    RVSP_PCIE_MMIO,
>> +    RVSP_PCIE_PIO,
>> +    RVSP_PCIE_ECAM,
>> +    RVSP_PCIE_MMIO_HIGH
>> +};
>> +
>> +enum {
>> +    RVSP_UART0_IRQ = 10,
>> +    RVSP_RTC_IRQ = 11,
>> +    RVSP_PCIE_IRQ = 0x20, /* 32 to 35 */
>> +};
>> +
>> +/*
>> + * The server soc reference machine physical address space used by some of the
>> + * devices namely ACLINT, APLIC and IMSIC depend on number of Sockets, number
>> + * of CPUs, and number of IMSIC guest files.
>> + *
>> + * Various limits defined by RVSP_SOCKETS_MAX_BITS, RVSP_CPUS_MAX_BITS, and
>> + * RVSP_IRQCHIP_MAX_GUESTS_BITS are tuned for maximum utilization of server soc
>> + * reference machine physical address space.
>> + */
>> +
>> +#define RVSP_IMSIC_GROUP_MAX_SIZE      (1U << IMSIC_MMIO_GROUP_MIN_SHIFT)
>> +#if RVSP_IMSIC_GROUP_MAX_SIZE < \
>> +    IMSIC_GROUP_SIZE(RVSP_CPUS_MAX_BITS, RVSP_IRQCHIP_MAX_GUESTS_BITS)
>> +#error "Can't accomodate single IMSIC group in address space"
>> +#endif
>> +
>> +#define RVSP_IMSIC_MAX_SIZE            (RVSP_SOCKETS_MAX * \
>> +                                        RVSP_IMSIC_GROUP_MAX_SIZE)
>> +#if 0x4000000 < RVSP_IMSIC_MAX_SIZE
>> +#error "Can't accomodate all IMSIC groups in address space"
>> +#endif
>> +
>> +static const MemMapEntry rvsp_ref_memmap[] = {
>> +    [RVSP_DEBUG] =          {        0x0,         0x100 },
>> +    [RVSP_MROM] =           {     0x1000,        0xf000 },
>> +    [RVSP_RESET_SYSCON] =   {   0x100000,        0x1000 },
>> +    [RVSP_RTC] =            {   0x101000,        0x1000 },
>> +    [RVSP_ACLINT] =         {  0x2000000,       0x10000 },
>> +    [RVSP_PCIE_PIO] =       {  0x3000000,       0x10000 },
>> +    [RVSP_APLIC_M] =        {  0xc000000, APLIC_SIZE(RVSP_CPUS_MAX) },
>> +    [RVSP_APLIC_S] =        {  0xd000000, APLIC_SIZE(RVSP_CPUS_MAX) },
>> +    [RVSP_UART0] =          { 0x10000000,         0x100 },
>> +    [RVSP_FLASH] =          { 0x20000000,     0x4000000 },
>> +    [RVSP_IMSIC_M] =        { 0x24000000, RVSP_IMSIC_MAX_SIZE },
>> +    [RVSP_IMSIC_S] =        { 0x28000000, RVSP_IMSIC_MAX_SIZE },
>> +    [RVSP_PCIE_ECAM] =      { 0x30000000,    0x10000000 },
>> +    [RVSP_PCIE_MMIO] =      { 0x40000000,    0x40000000 },
>> +    [RVSP_DRAM] =           { 0x80000000, 0xff80000000ull },
>> +    [RVSP_PCIE_MMIO_HIGH] = { 0x10000000000ull, 0x10000000000ull },
> The base address of RVSP_PCIE_MMIO_HIGH exceeds the 39-bit address space, while
> the satp mode of the rvsp-ref-cpu is SV39 (based on the RVA23S64).
> 
> static RISCVCPUProfile RVA23S64 = {
>      .u_parent = &RVA23U64,
>      .s_parent = &RVA22S64,
>      .name = "rva23s64",
>      .misa_ext = RVS,
>      .priv_spec = PRIV_VERSION_1_13_0,
>      .satp_mode = VM_1_10_SV39, /* there */
>      ...
> }
> 
> This will cause an error when EDKII processes the address mapping of PCI MMIO,
> but I am not yet sure whose issue this is.
> 
> I suggest setting the default value of satp_mode for rvsp-ref-cpu to SV48.

So, in the latest spec, section 2.1 RISC-V Harts:

https://github.com/riscv-non-isa/riscv-server-platform/releases/download/v0.9-rc3/riscv-server-platform.pdf

There's a set of "rules" that each hart should or can follow. Rule RVA_010 states:

"The RISC-V application processor harts in the SoC MUST support the RVA23S64 ISA
profile [6]."

The next rule, RVA_020:

"The RISC-V application processor harts in the SoC MUST support the following
extensions:
- Sv48
- Sdtrig [7]
- Sdext [7]
- Zkr
- Ssccfg
- Ssstrict [6]
- Ssaia [8]"


I take it that the wording used, **MUST**, indicates that RVA_020 is mandatory so we should
in fact support sv48. In this case we can change the default to sv48 without problems


Drew, is this a fair interpretation? Thanks,


Daniel


> 
> Thanks,
> Chao
> 


