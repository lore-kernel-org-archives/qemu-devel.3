Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B746AC7115C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 15:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSHBW-0001xs-A5; Thu, 19 Jun 2025 11:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1uSHBV-0001xj-7U
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 11:28:13 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1uSHBO-00049T-UW
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 11:28:13 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-73972a54919so665671b3a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 08:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1750346883; x=1750951683; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=luOWSFgzP/rKccc7s4K9TLiyXYoWyKmChcndNKlURKc=;
 b=ibXa6TRasB+DQJ0ypJInEiuTWJtMzF46i6jWAwrRepoxA3aFxUCkN7mb+zs0Rvms9R
 hy7GBYV1yUiNKrJ+KIJS8HOLYmHjDU3HGSsqjUpmvFvCscIVSkXBXs4lIS8LWj6bArvP
 EAc8eKwVpjrkiVKRnpoWROj1zyFxi64IlNHDK8qNUrJ1K8ncjbyeCDulru6Cn+wfHfqn
 gD0518VEHK5ajQ/IQ5ar9FsucTatEneb0LVysFBfrr35jREdrSi+WQ4XxNjF1w+ESn7R
 xobJOCQ2YiknO1TtDRgZRgV9kLQJCDnOZOO4avE5FwatYNXetn0PVfjd8pFNcFLCCsJw
 6PDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750346883; x=1750951683;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=luOWSFgzP/rKccc7s4K9TLiyXYoWyKmChcndNKlURKc=;
 b=PwNtCT5sjIYZkQ1PyZwyFmZQHCQUmKygH682M/VDY7/G9Bfw4lz8+V6GbcEcKDlRwO
 I48vgnba8UemUbGSx3zQ6co9xEJ+yw9g6K7Je5sppYwk5Qcg8vfkhAF1njPRoSuDRMEW
 clAFLmPiDE+Nocj6cJJKNoDuBIowNXx8dYNI8UVT3mMkMJ1gpcLRs+S+mXzJie2bWJHo
 bxuD6OoPx29XeW7ESDZxLpwA2yKyEKr/Vzi9zFRiNEpeqyidKUOpj8FunbGSXPNZUW6A
 xqA7zQ0EvZtP0cGLYURDfjPF8KNyvHTa4DknnV5KM0dJYI14FXFaxwNDPAqLfn/SF42l
 Z+lQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHGy7lzWryJb/g6iLlN29NCca+R2uU8PUs0sbv8l4Bz4MlVzyBjS4ys9skgmfOtZfOC8dDg4V2hMf0@nongnu.org
X-Gm-Message-State: AOJu0Yyy60PieRG5bNGyPSXn55A9g4zEag8qI+kXo62orpW7TymL3Ia1
 g5WpXrvq1Ai5yOcEnquUWtVRAGxq4PXjc0/zhd8J6zNhdhGrD47gcAj/mt5yy73xNxo=
X-Gm-Gg: ASbGnctgtv9dh3Wpz3gM2b+zRCQs7NCJpYXCUeYOlymoKt/taVjoC6zWtVCCqg7+mwv
 gs/n6KPs51jOVIRyQdCShEhAnGyQM6uesXpqif/rECV9iEeBGiMawkzlcBfHnYN7wlAD/18mJSn
 wiTWJtuUshfIOlCmlNcTDKa4zZIVDwwOBPsdUiBfWkyHW9mydiH94ZYEcUcxLtX2f7NdSkQoCWG
 x0ghF4wjk7gsrhJCizRL23BGsBUH2Z1E+NNQkoJCewSpAzG3us14XL4X2NRiJ82o7nirkmlIYFp
 Gsu1ir4lYo//pNFNE4KLK01NTL1mfYJ1yIH98LQ01kbIIOiODa6BPpiPww9RgmjXEQ/QRQ==
X-Google-Smtp-Source: AGHT+IF9oYXXshN3eBZ947NClFg9EzZik2AZgCUwk+ajmuz5HHa2UBuAW1wWbOfQsB7E+JbEBsdF+A==
X-Received: by 2002:a05:6a20:9f43:b0:1f5:6f61:a0ac with SMTP id
 adf61e73a8af0-21fbd5591d4mr28267821637.5.1750346883209; 
 Thu, 19 Jun 2025 08:28:03 -0700 (PDT)
Received: from sunil-laptop ([103.97.166.196])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a465c40sm148684b3a.17.2025.06.19.08.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 08:28:02 -0700 (PDT)
Date: Thu, 19 Jun 2025 20:57:54 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: liu.xuemei1@zte.com.cn
Cc: pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, bjorn@rivosinc.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/riscv/virt: Add acpi ged and powerdown support
Message-ID: <aFQseigG0Wbqx1CC@sunil-laptop>
References: <202506191556260735QxWC8sxRwFURYEvlD24y@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202506191556260735QxWC8sxRwFURYEvlD24y@zte.com.cn>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x42d.google.com
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

Hi Xuemei Liu,

Thank you for the patch!

On Thu, Jun 19, 2025 at 03:56:26PM +0800, liu.xuemei1@zte.com.cn wrote:
> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
> 
> This adds powerdown support by implementing the ACPI GED.
> 
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
> Co-authored-by: Björn Töpel <bjorn@rivosinc.com>
> ---
>  hw/riscv/Kconfig           |  1 +
>  hw/riscv/virt-acpi-build.c | 12 ++++++++++++
>  hw/riscv/virt.c            | 32 ++++++++++++++++++++++++++++++++
>  include/hw/riscv/virt.h    |  4 ++++
>  4 files changed, 49 insertions(+)
> 
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index e6a0ac1fa1..16837e0e8f 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -68,6 +68,7 @@ config RISCV_VIRT
>      select PLATFORM_BUS
>      select ACPI
>      select ACPI_PCI
> +    select ACPI_HW_REDUCED
> 
>  config SHAKTI_C
>      bool
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 8b5683dbde..89365c40b4 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -29,6 +29,7 @@
>  #include "hw/acpi/aml-build.h"
>  #include "hw/acpi/pci.h"
>  #include "hw/acpi/utils.h"
> +#include "hw/acpi/generic_event_device.h"
>
NIT: Could you include this after aml-build.h to keep it sorted?

>  #include "hw/intc/riscv_aclint.h"
>  #include "hw/nvram/fw_cfg_acpi.h"
>  #include "hw/pci-host/gpex.h"
> @@ -224,6 +225,16 @@ static void acpi_dsdt_add_iommu_sys(Aml *scope, const MemMapEntry *iommu_memmap,
>      aml_append(scope, dev);
>  }
> 
> +static void acpi_dsdt_add_ged(Aml *scope, RISCVVirtState *s)
> +{
> +    build_ged_aml(scope, "\\_SB."GED_DEVICE,
> +                  HOTPLUG_HANDLER(s->acpi_ged),
> +                  ACPI_GED_IRQ, AML_SYSTEM_MEMORY,
> +                  s->memmap[VIRT_ACPI_GED].base);
> +
> +    acpi_dsdt_add_power_button(scope);
>
Instead of this wrapper function to create both ged and power button,
please call them directly below where you are calling
acpi_dsdt_add_ged(). It will help in future to add some other eventing
mechanism to the power button.

> +}
> +
>  /*
>   * Serial Port Console Redirection Table (SPCR)
>   * Rev: 1.10
> @@ -497,6 +508,7 @@ static void build_dsdt(GArray *table_data,
>                               VIRTIO_COUNT);
>          acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURCES * 2);
>      }
> +    acpi_dsdt_add_ged(scope, s);
> 
This should be conditional - only if s->acpi_ged is set.

>      aml_append(dsdt, scope);
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index cf280a92e5..aaa33b9740 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -51,10 +51,12 @@
>  #include "system/kvm.h"
>  #include "system/tpm.h"
>  #include "system/qtest.h"
> +#include "system/runstate.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci-host/gpex.h"
>  #include "hw/display/ramfb.h"
>  #include "hw/acpi/aml-build.h"
> +#include "hw/acpi/generic_event_device.h"
>  #include "qapi/qapi-visit-common.h"
>  #include "hw/virtio/virtio-iommu.h"
>  #include "hw/uefi/var-service-api.h"
> @@ -95,6 +97,7 @@ static const MemMapEntry virt_memmap[] = {
>      [VIRT_UART0] =        { 0x10000000,         0x100 },
>      [VIRT_VIRTIO] =       { 0x10001000,        0x1000 },
>      [VIRT_FW_CFG] =       { 0x10100000,          0x18 },
> +    [VIRT_ACPI_GED] =     { 0x10200000, ACPI_GED_EVT_SEL_LEN },
Do we need to align the base address at 1MB? It can create a larger hole
unnecessarily.

>      [VIRT_FLASH] =        { 0x20000000,     0x4000000 },
>      [VIRT_IMSIC_M] =      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
>      [VIRT_IMSIC_S] =      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
> @@ -1272,6 +1275,21 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
>      return dev;
>  }
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
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(irqchip, ACPI_GED_IRQ));
> +
> +    return dev;
> +}
> +
>  static FWCfgState *create_fw_cfg(const MachineState *ms, hwaddr base)
>  {
>      FWCfgState *fw_cfg;
> @@ -1430,6 +1448,14 @@ static void virt_build_smbios(RISCVVirtState *s)
>      }
>  }
> 
> +static void virt_powerdown_req(Notifier *notifier, void *opaque)
> +{
> +    RISCVVirtState *s;
> +
> +    s = container_of(notifier, RISCVVirtState, powerdown_notifier);
> +    acpi_send_event(s->acpi_ged, ACPI_POWER_DOWN_STATUS);
Check for s->acpi_ged here. 

> +}
> +
>  static void virt_machine_done(Notifier *notifier, void *data)
>  {
>      RISCVVirtState *s = container_of(notifier, RISCVVirtState,
> @@ -1703,6 +1729,9 @@ static void virt_machine_init(MachineState *machine)
> 
>      create_platform_bus(s, mmio_irqchip);
> 
> +    /* acpi ged */
> +    s->acpi_ged = create_acpi_ged(s, mmio_irqchip);
> +
>
I think we should create GED only if ACPI is enabled.

Thanks!
Sunil

