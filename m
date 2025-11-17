Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2C0CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 10:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKw3K-0003aA-Pg; Mon, 17 Nov 2025 05:01:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vKw3D-0003XF-R3
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 05:01:40 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vKw3B-0000vj-Go
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 05:01:35 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-bd1b0e2c1eeso453846a12.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 02:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1763373691; x=1763978491; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VPiNNMmkodgonWLCasO6R7aTZ1ZSIQj0aJyqx1YRVfA=;
 b=Wlj16sX8sQOf1kcudc97WHadmMIZHiq4Pw2gjWYEFCde5QzeQBWNcHqF0/80TxA+fA
 95PMVMhLen13uUDK4OxQtPXdOmG/jCy/KuFdBl1yd9bg52wVaHuTELj0LUPGWXKG4UTq
 1zWMzhDVM2auGyGyKwhZV9Wn2+VoqKzbxmaQphYXBMIqFGrSCAcpevCMhffh2TO60uX/
 ip71VjublOvz7ldpuQfBmz6kieMkBvqoYHZdFMBFGx5aaDrLcivszkcki0pBP3Vqy3kP
 7Nesxj9cTJ/NNBL8eHaurOIUcsWIu+SXFqB+xB6fUBZ9JTf3Ogjx5z5uanWS7qHT+IHG
 FATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763373691; x=1763978491;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VPiNNMmkodgonWLCasO6R7aTZ1ZSIQj0aJyqx1YRVfA=;
 b=glvm30kDs0Ca/uvFnFE+F8owxTUHs8DtseHbBX9qTDDojImBHe1rr12JuPA74nwxbX
 JzhrRXM0ssXFMhe+9q8z+RlFJhCqdfJKSj7Vwqa25YX6VnjyIvYlr1T/dkZkxd3fjKMO
 O2FDP2T6UDIFPekW3ZtnK7IfIhr028fi0QLsGZaf3R7165x5ary4utXGXoCisAedT5qS
 ecYV9/RrijRe5klWU0o4+hRWKfmjCbFw9Mg+zR56IFfMaVshKbkrsJUUaSoGT06mm3pE
 /GGZsrZR3YnOg3MzTOF6IK45fhk3GAQif/PY2lQnyJWPnDUS7UULQDnqOJdotSibY55k
 AHpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgGoXra0tdIMC8oFWvQRaoMGN0DbmeEMhYirfctAbWqM9cftJOsaqyWDezpUs+EsMQpqK6JXvDOsdT@nongnu.org
X-Gm-Message-State: AOJu0YzUFus3ftQ2XGL03p79spmykNVvGXGYbsolJpHQeyLmz22aRa2w
 O4vY/a0sqTYYnUEVQA+sdMr18VLf8fwXLkgpA7fp/S29eXNgYuJRFJKbA2HWEtkQ+z0=
X-Gm-Gg: ASbGncvSPMh/o3WZ7mwNHlfmLU7IN+jxCkLDJMxJwdoLYbeWdeiRb3pp+ejwg6tU5Ea
 lxCu20OxRBMtRPlpn3Q5H2TDPh5iwHIiTIljiGY3llK9xIRTLaS5j6kqGhMeOdiubnPiFquz5Ci
 E++nxrgR2gMpYdhEfvh6juBU6NTAX/3lQ8QTTDooVpDOa+uPwSThTK60j9G3wdKr+fhKkqGYRyG
 +B8I2+C0yAvM4fsi138p9AfUeQEkD0PZQY6dUIJO9xCCXur2fixzq+kc5sbAWaMDJ6LJtc3IVQc
 RhHO/j4Zph4G0kXv9ZcTG1tYko7Rx2dRS6GTpwqCjYH6V3HPxCMryZlc497zjCMcK/HnoAtaqix
 6BdML15hgK4rVFcmBptrtgfyijf35/FwWkB/YtOHRw6JP0LryO8TEbm7JQbaIh0MnTD9ExwMjS6
 yikGpHhhyGcGJMlhY=
X-Google-Smtp-Source: AGHT+IGqnSY6zM+bLz1bJfjIszifUxwGOv3pvpJOeR8wiqpK3YlGJo03LK64KYdhm0dPYD/FQqzLjQ==
X-Received: by 2002:a05:7022:412:b0:119:fac9:ce12 with SMTP id
 a92af1059eb24-11b40fca515mr4799050c88.13.1763373691395; 
 Mon, 17 Nov 2025 02:01:31 -0800 (PST)
Received: from [192.168.68.110] ([191.202.237.26])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11b06088625sm47429458c88.8.2025.11.17.02.01.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 02:01:30 -0800 (PST)
Message-ID: <7765a558-a7b4-4228-8d43-2e67d2266b18@ventanamicro.com>
Date: Mon, 17 Nov 2025 07:01:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 RESEND 1/2] hw/riscv/virt: Add acpi ged and powerdown
 support
To: liu.xuemei1@zte.com.cn, imammedo@redhat.com, alistair.francis@wdc.com,
 sunilvl@ventanamicro.com, anisinha@redhat.com
Cc: pbonzini@redhat.com, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, mst@redhat.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20251113093022673gxIvC2wmdHDBY2Sq0_AUm@zte.com.cn>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251113093022673gxIvC2wmdHDBY2Sq0_AUm@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52c.google.com
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



On 11/12/25 10:30 PM, liu.xuemei1@zte.com.cn wrote:
> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
> 
> This adds powerdown support by implementing the ACPI GED.
> 
> Co-authored-by: Björn Töpel <bjorn@rivosinc.com>
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/riscv/Kconfig                            |  1 +
>   hw/riscv/virt-acpi-build.c                  | 10 ++++++
>   hw/riscv/virt.c                             | 35 +++++++++++++++++++++
>   include/hw/riscv/virt.h                     |  4 +++
>   tests/qtest/bios-tables-test-allowed-diff.h |  1 +
>   5 files changed, 51 insertions(+)
> 
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index fc9c35bd98..f89a6e3672 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -68,6 +68,7 @@ config RISCV_VIRT
>       select PLATFORM_BUS
>       select ACPI
>       select ACPI_PCI
> +    select ACPI_HW_REDUCED
> 
>   config SHAKTI_C
>       bool
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index f1406cb683..64fd8aa426 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -27,6 +27,7 @@
>   #include "hw/acpi/acpi-defs.h"
>   #include "hw/acpi/acpi.h"
>   #include "hw/acpi/aml-build.h"
> +#include "hw/acpi/generic_event_device.h"
>   #include "hw/acpi/pci.h"
>   #include "hw/acpi/utils.h"
>   #include "hw/intc/riscv_aclint.h"
> @@ -498,6 +499,15 @@ static void build_dsdt(GArray *table_data,
>           acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURCES * 2);
>       }
> 
> +    if (s->acpi_ged) {
> +        build_ged_aml(scope, "\\_SB."GED_DEVICE,
> +                      HOTPLUG_HANDLER(s->acpi_ged),
> +                      ACPI_GED_IRQ, AML_SYSTEM_MEMORY,
> +                      s->memmap[VIRT_ACPI_GED].base);
> +    }
> +
> +    acpi_dsdt_add_power_button(scope);
> +
>       aml_append(dsdt, scope);
> 
>       /* copy AML table into ACPI tables blob and patch header there */
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 17909206c7..a853184105 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -51,10 +51,12 @@
>   #include "system/kvm.h"
>   #include "system/tpm.h"
>   #include "system/qtest.h"
> +#include "system/runstate.h"
>   #include "hw/pci/pci.h"
>   #include "hw/pci-host/gpex.h"
>   #include "hw/display/ramfb.h"
>   #include "hw/acpi/aml-build.h"
> +#include "hw/acpi/generic_event_device.h"
>   #include "qapi/qapi-visit-common.h"
>   #include "hw/virtio/virtio-iommu.h"
>   #include "hw/uefi/var-service-api.h"
> @@ -95,6 +97,7 @@ static const MemMapEntry virt_memmap[] = {
>       [VIRT_UART0] =        { 0x10000000,         0x100 },
>       [VIRT_VIRTIO] =       { 0x10001000,        0x1000 },
>       [VIRT_FW_CFG] =       { 0x10100000,          0x18 },
> +    [VIRT_ACPI_GED] =     { 0x10101000, ACPI_GED_EVT_SEL_LEN },
>       [VIRT_FLASH] =        { 0x20000000,     0x4000000 },
>       [VIRT_IMSIC_M] =      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
>       [VIRT_IMSIC_S] =      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
> @@ -1270,6 +1273,22 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
>       return dev;
>   }
> 
> +static DeviceState *create_acpi_ged(RISCVVirtState *s, DeviceState *irqchip)
> +{
> +    DeviceState *dev;
> +    uint32_t event = ACPI_GED_PWR_DOWN_EVT;
> +
> +    dev = qdev_new(TYPE_ACPI_GED);
> +    qdev_prop_set_uint32(dev, "ged-event", event);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, s->memmap[VIRT_ACPI_GED].base);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
> +                       qdev_get_gpio_in(irqchip, ACPI_GED_IRQ));
> +
> +    return dev;
> +}
> +
>   static FWCfgState *create_fw_cfg(const MachineState *ms, hwaddr base)
>   {
>       FWCfgState *fw_cfg;
> @@ -1428,6 +1447,14 @@ static void virt_build_smbios(RISCVVirtState *s)
>       }
>   }
> 
> +static void virt_powerdown_req(Notifier *notifier, void *opaque)
> +{
> +    RISCVVirtState *s;
> +
> +    s = container_of(notifier, RISCVVirtState, powerdown_notifier);
> +    acpi_send_event(s->acpi_ged, ACPI_POWER_DOWN_STATUS);
> +}
> +
>   static void virt_machine_done(Notifier *notifier, void *data)
>   {
>       RISCVVirtState *s = container_of(notifier, RISCVVirtState,
> @@ -1701,6 +1728,11 @@ static void virt_machine_init(MachineState *machine)
> 
>       create_platform_bus(s, mmio_irqchip);
> 
> +    /* acpi ged */
> +    if (virt_is_acpi_enabled(s)) {
> +        s->acpi_ged = create_acpi_ged(s, mmio_irqchip);
> +    }
> +
>       serial_mm_init(system_memory, s->memmap[VIRT_UART0].base,
>           0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
>           serial_hd(0), DEVICE_LITTLE_ENDIAN);
> @@ -1742,6 +1774,9 @@ static void virt_machine_init(MachineState *machine)
>           sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu_sys), &error_fatal);
>       }
> 
> +    s->powerdown_notifier.notify = virt_powerdown_req;
> +    qemu_register_powerdown_notifier(&s->powerdown_notifier);
> +
>       s->machine_done.notify = virt_machine_done;
>       qemu_add_machine_init_done_notifier(&s->machine_done);
>   }
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 7b4c2c8b7d..9422b45d0c 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -47,6 +47,8 @@ struct RISCVVirtState {
> 
>       /*< public >*/
>       Notifier machine_done;
> +    Notifier powerdown_notifier;
> +    DeviceState *acpi_ged;
>       DeviceState *platform_bus_dev;
>       RISCVHartArrayState soc[VIRT_SOCKETS_MAX];
>       DeviceState *irqchip[VIRT_SOCKETS_MAX];
> @@ -88,9 +90,11 @@ enum {
>       VIRT_PLATFORM_BUS,
>       VIRT_PCIE_ECAM,
>       VIRT_IOMMU_SYS,
> +    VIRT_ACPI_GED,
>   };
> 
>   enum {
> +    ACPI_GED_IRQ = 9,
>       UART0_IRQ = 10,
>       RTC_IRQ = 11,
>       VIRTIO_IRQ = 1, /* 1 to 8 */
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..8e85fcdee9 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,2 @@
>   /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/riscv64/virt/DSDT",


