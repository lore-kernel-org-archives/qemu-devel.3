Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A9DC8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 18:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWInh-0003gT-TH; Mon, 30 Jun 2025 14:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uWIna-0003bf-UY
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 14:00:11 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uWInZ-00022R-56
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 14:00:10 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-4a44b0ed780so30806891cf.3
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 11:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1751306406; x=1751911206; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O7ds3I4aoRLHEdl9jABLtND/y5tcojlrVeTOWejznx4=;
 b=HxF6n+fcSxyb3gxt3lxLwn0rSK7atd+Kdi7ONShqHsxSUCok5a2CzVVPQxI3zNdFjN
 yix1f6lzEfR1U9vC5yKRb2+IMJUsuIlGcVjbmOWjVLZSoKnO1kQW3J14zWjsu7H62V7O
 z6DPOUqYz+ptzAHdtz/OvqHroN+9TGa4+0TUvb5eqfiJVexDsWx2nIYPaxeUfz33piMn
 gdacOs9V1uU++MrwRazqdfV2pwcw/tMkUV2QWhrAV4bvboGyavRiLiy6PtzhE605GHb+
 AP/pZcwcFLbIM1kMzUiN5SXeTRanPrzVa3hxhKRUWRsmBZZCeiOi2gimBd4JL+iAtxvf
 IXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751306406; x=1751911206;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O7ds3I4aoRLHEdl9jABLtND/y5tcojlrVeTOWejznx4=;
 b=hgNOH/GXc6/JNMtbeFnlU8y+40OlDc+rqsakHJuK48oCuP9N0gyEPYDvNO8ROu7d14
 oBZCM/0B/13R4ADIM2MlmOETA9LGibda8lFUg7Aw+BA24J8Fbog5DaQOFwfu1RuuQ79P
 5isDQJVDd2MI4inZJm/P6Do75a+ZJcz4kWT6TAs0bbDDe6n3fyV0+X/JsR8NJSk0sWTm
 4ZohmgjI5C8qEMXxfQ0CKWOvazaDiiermfW74h7rsA6qiIaGXG6IFj/RY8AViaD/mthY
 R63uQ+RhUb7LYB4ULEF/PCx4aWRaLpjBFrckmKbS+w1cU7RU0FBe1IgVUcxQ7Z5Zoq+H
 dDzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI1ojZ8mY2fLyc/0ZKCFidlnCn+htFb0SW8OpvRm6+Lt9iWz07gqat94Ew6p+4oefn994JoWWVZ/gA@nongnu.org
X-Gm-Message-State: AOJu0YyXyvumC6PyFWUyNyPfYtDXvVg2SmvmKK24AALBOFrpbbxz5SPT
 kxNEWYHF/embczsTNWita7zoypDLxhPXIXb20dBMYL2V5IMjML0VFQtSKJse0iZW1kU=
X-Gm-Gg: ASbGnct8fXSwsHgN/5XMpErssEMKaJAAofSjTc0YEWm3VPd+bh/+ufYqaeAPnERvgoy
 LqsvZSOrdB3UOuijkioshb3Ma6KmJben8VTJCL5lTEMGX9+RtQDFmaXheEnP6+oOFoNZYCN+bEq
 trU3kiYFQ7QBnetv/n0cfJgSK696ZjySgPqXch6wBC56GimtxSc0EOEJYtFfDfajJDd+31jW10B
 hBzOJyi+lDDMWy89da2h0AEejfhEEuxpkvVY80VIg+t4+gI/28XcjgwpwSLbGF2IM7AyXjGtRdR
 qx+58kYV8uFz60XhRxGp3bvm+OU4iBh75rYJKFTvTIaAYNIgki0hwsf7dQNVpeEAtxNFw8Ucnpg
 =
X-Google-Smtp-Source: AGHT+IF/KjZ3Y/azjzkEtAqRfmenDDqrP9xH+XRP6B7/I+v2pfzUcnbDe15RNpb+2vCivuqLzBGE1Q==
X-Received: by 2002:a05:622a:4c0b:b0:476:875e:516d with SMTP id
 d75a77b69052e-4a7fcaeed61mr235166081cf.36.1751306406244; 
 Mon, 30 Jun 2025 11:00:06 -0700 (PDT)
Received: from [192.168.68.110] ([179.93.20.232])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a7fc1061d3sm62996671cf.15.2025.06.30.11.00.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 11:00:05 -0700 (PDT)
Message-ID: <b6375258-7ab6-48b7-8080-1a9cd15f8845@ventanamicro.com>
Date: Mon, 30 Jun 2025 15:00:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/riscv/virt: Add acpi ged and powerdown support
To: liu.xuemei1@zte.com.cn, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 sunilvl@ventanamicro.com, bjorn@rivosinc.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20250621085936463VQd8P_CrqoYtmrc-U5hJ9@zte.com.cn>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250621085936463VQd8P_CrqoYtmrc-U5hJ9@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qt1-x82a.google.com
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



On 6/20/25 9:59 PM, liu.xuemei1@zte.com.cn wrote:
> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
> 
> This adds powerdown support by implementing the ACPI GED.
> 
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
> Co-authored-by: Björn Töpel <bjorn@rivosinc.com>
> 
> ---
> Changes in v3:
> - Added missing param to virt_is_acpi_enabled
> - Fixed failure of bios-tables-test
> 
>   hw/riscv/Kconfig                  |   1 +
>   hw/riscv/virt-acpi-build.c        |  10 +++++++++
>   hw/riscv/virt.c                   |  35 ++++++++++++++++++++++++++++++
>   include/hw/riscv/virt.h           |   4 ++++
>   tests/data/acpi/riscv64/virt/DSDT | Bin 3576 -> 3719 bytes
>   5 files changed, 50 insertions(+)
> 
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index e6a0ac1fa1..16837e0e8f 100644
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
> index 8b5683dbde..163533f9b8 100644
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
> index cf280a92e5..43b4ab0dc1 100644
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
> @@ -1272,6 +1275,22 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
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
> @@ -1430,6 +1449,14 @@ static void virt_build_smbios(RISCVVirtState *s)
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
> @@ -1703,6 +1730,11 @@ static void virt_machine_init(MachineState *machine)
> 
>       create_platform_bus(s, mmio_irqchip);
> 
> +    /* acpi ged */
> +    if (virt_is_acpi_enabled(s)) {
> +        s->acpi_ged = create_acpi_ged(s, mmio_irqchip);
> +    }
> +

Is there a reason to create this ACPI device here at machine_init() instead of
machine_done() time, before virt_acpi_setup()?

     if (virt_is_acpi_enabled(s)) {
> +      s->acpi_ged = create_acpi_ged(s, mmio_irqchip);
         virt_acpi_setup(s);
     }


Thanks,

Daniel


>       serial_mm_init(system_memory, s->memmap[VIRT_UART0].base,
>           0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
>           serial_hd(0), DEVICE_LITTLE_ENDIAN);
> @@ -1744,6 +1776,9 @@ static void virt_machine_init(MachineState *machine)
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
> diff --git a/tests/data/acpi/riscv64/virt/DSDT b/tests/data/acpi/riscv64/virt/DSDT
> index 6a33f5647ddd6de3a0f000f718b58f6fff44f0fd..b167a850026d392eaa6da85562c442945e238208 100644
> GIT binary patch
> delta 170
> zcmew%-7d@J66_Mv&d0#O<T;T`n#t+eM)ixl_0dgE>@j-r!A|k+t}gK$@gANoypGNR
> zo(2Yn#ta<sp+GKB0?2X>3Krz!;_hT)U}ofGU|^_Zh;DEVa&>3mVGs}y;9`kx<OXq_
> zU4vbH6hvg>UBf~+3qYKN1p<?+6S$ZdxR}}k!h@W+8lsydK@5;(0xrA(egOu~2F?)6
> F7y$P$D2D(5
> 
> delta 25
> gcmZpd{UOce66_N4gO`DUsc0gXG?Vk)jp`S90cJM`_y7O^
> 


