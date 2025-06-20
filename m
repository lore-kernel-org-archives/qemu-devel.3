Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643C0C77B7C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 10:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSYh7-0000Ca-FT; Fri, 20 Jun 2025 06:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uSYgx-0000By-GN
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 06:09:52 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uSYgu-0004RY-A6
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 06:09:50 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso1277722b3a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 03:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1750414186; x=1751018986; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oWBp/OGJYqx5HmPUJTe5WgI0HIKdAlDn6T3n3KIXWgI=;
 b=QCuSLjmbQx8d3D0G8fZZ+uLqBrsJUf/2VRgJu9I9ogMjXu3ToBXuhx/+yn1dZlQZlE
 Tg6K00lZmQFe2KEZXCJP2owTwe5AHaZuSlY5KcSHJA5Wlw8u1p3WmbkFQWdwgooVgwQ+
 TB+wLGXOACwGId2d/uXv1tVrzbWnQO/2X5Oi8DawWeEnrLtPwPhYYrr8Rjy3Ylzw4Z42
 L3t+D9+3mqJFxnlrS6NJVaZi4iVyT8fgjcDExfeA4U6Ja+Ah6MAcCiRIpeIOqQ8dwUJF
 dHHbg50+HNDrPLmq8rfc20+dggla7iuHhukurRLEQtpzq0bPpNbUSiTfHruec5WtXjIt
 sBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750414186; x=1751018986;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oWBp/OGJYqx5HmPUJTe5WgI0HIKdAlDn6T3n3KIXWgI=;
 b=JNB/7X48GkeXn6CYRvAb6StZznYEVZJKox2nhjfdRD4SXroFTwkqlG6JuUlrAvfk/6
 xN2BPQbIMljg/F7FMH8Xfq2ktf9GiYJ8F8VjsPQAaPYCb5oSVXwjw0ol/xuWF/OH2QtR
 Y7roHEjZm1XREHoCbmKs+Bc51rtiz55YlqPdMjo2qOJKWWReKwdLT1SUoD7OY+0k6OEz
 xWib4iocFPmFXtHXsURNgfG1bkfeaeaVJUXMfmpnZB45QZzV4th76jsjofGzGHAZGqP1
 ZGPtC+hS7iAfarW2+wL9WOjycthBLO/EWrIZUPMn+AbOv97Mh1gGpa5Re6C473duTllH
 DA8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE3nOLq0xCq+stHxcX12GhNZPmA0d++sPpMpdfvnuw+txTeSsderMWfWdBqNnqHfTkJvMxYD7Fahz1@nongnu.org
X-Gm-Message-State: AOJu0Yz3zpt9SKp38nGOlf/+BXKSkjkZ2z/b2tYr0rPQTCRjigzsvxsg
 falXyx4fX11l/jw2Xn2iVEzFd19foP2C3faS4s2RUHEnHKbdsS++f5lSK85BNz7VDT4=
X-Gm-Gg: ASbGncvZkbz3t7x2LYsFhJ7SesAZAYt4Bqjl/Kzfgi27xNE2R2/2QS+ku2iIAH1lpqP
 YxYQO0D2xvkOXggL90GTltk9wSkI9CkNHwirCkJOFRyoVoVm4V5TSYcZ+OKwmw85Soi6AJ9kv2X
 wN82FeuHp6qE1XgPXzito9iLGUnkcbDWpIXYzHeXWr9Ecp7c309ZIElSEdJTp7IatvARFdgKx7p
 t1OSify4atdKl9/4g3NsuGHbXht1qhf746iFIid+EqY7fon8WctM2APkzTvNVFYIV0UusUhaiC0
 5JTh+HcbDcm+v9yhDoYfNAfugxHXqao7s/HXJ8baVfOwpZDk/BqJ/7nr92waNt3Q4XerwQgyPkP
 d
X-Google-Smtp-Source: AGHT+IEGcNnr1FJYEWiEYD0ShVmA+eTsf60kXTo2lHA4NIZ3kHzqVX/ehLwiIDMZTNJRA+Vj/okCYw==
X-Received: by 2002:a05:6a00:3e10:b0:740:afda:a742 with SMTP id
 d2e1a72fcca58-7490d2843b6mr3264339b3a.0.1750414186482; 
 Fri, 20 Jun 2025 03:09:46 -0700 (PDT)
Received: from [192.168.68.110] ([191.255.35.152])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a664e97sm1665724b3a.136.2025.06.20.03.09.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Jun 2025 03:09:46 -0700 (PDT)
Message-ID: <d6c88522-6255-4413-a360-61256828cbe8@ventanamicro.com>
Date: Fri, 20 Jun 2025 07:09:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/riscv/virt: Add acpi ged and powerdown support
To: liu.xuemei1@zte.com.cn, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 sunilvl@ventanamicro.com, bjorn@rivosinc.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <202506201130099861lTkD839Hh6oko8Jo2W2H@zte.com.cn>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <202506201130099861lTkD839Hh6oko8Jo2W2H@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x436.google.com
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

Hi,

Seems like this patch doesn't build:

FAILED: libqemu-riscv64-softmmu.a.p/hw_riscv_virt.c.o
(...)
../hw/riscv/virt.c
../hw/riscv/virt.c: In function ‘virt_machine_init’:
../hw/riscv/virt.c:1732:9: error: too few arguments to function ‘virt_is_acpi_enabled’; expected 1, have 0
  1732 |     if (virt_is_acpi_enabled()) {
       |         ^~~~~~~~~~~~~~~~~~~~
In file included from ../hw/riscv/virt.c:37:
/home/danielhb/work/qemu/include/hw/riscv/virt.h:139:6: note: declared here
   139 | bool virt_is_acpi_enabled(RISCVVirtState *s);
       |      ^~~~~~~~~~~~~~~~~~~~
[2211/3002] Compiling C object libqemu-riscv64-softmmu.a.p/hw_riscv_virt-acpi-build.c.o
ninja: build stopped: subcommand failed.


This diff fixes it:

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index a4eba9c1bd..5bb1504498 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1729,7 +1729,7 @@ static void virt_machine_init(MachineState *machine)
      create_platform_bus(s, mmio_irqchip);
  
      /* acpi ged */
-    if (virt_is_acpi_enabled()) {
+    if (virt_is_acpi_enabled(s)) {
          s->acpi_ged = create_acpi_ged(s, mmio_irqchip);
      }
  

After fixing the build, we'll have a failure in 'make check-qtest':


148/336 qemu:qtest+qtest-riscv64 / qtest-riscv64/bios-tables-test           ERROR           18.20s   killed by signal 6 SIGABRT


This failure happens because you're changing the default bios table without
updating the test. To update it, assuming you're building QEMU in the default
'build' dir:

$ ninja -C build && make -j check-qtest
$ cd build && sh tests/data/acpi/rebuild-expected-aml.sh && cd ..

And then "$ ninja -C build && make -j check-qtest" to confirm that the test is
fixed. Don't forget to add the changes in /tests/data/acpi/riscv64/virt/RHCT
in this patch.


Thanks,

Daniel




On 6/20/25 12:30 AM, liu.xuemei1@zte.com.cn wrote:
> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
> 
> This adds powerdown support by implementing the ACPI GED.
> 
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
> Co-authored-by: Björn Töpel <bjorn@rivosinc.com>
> 
> ---
> Changes in v2:
> - Unwrappered acpi_dsdt_add_ged function
> - Modified base address of VIRT_ACPI_GED
> - Added conditions for function calls
> - Adjusted code formatting
> 
>   hw/riscv/Kconfig           |  1 +
>   hw/riscv/virt-acpi-build.c | 10 ++++++++++
>   hw/riscv/virt.c            | 35 +++++++++++++++++++++++++++++++++++
>   include/hw/riscv/virt.h    |  4 ++++
>   4 files changed, 50 insertions(+)
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
> index cf280a92e5..3e95a49c64 100644
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
> +    if (virt_is_acpi_enabled()) {
> +        s->acpi_ged = create_acpi_ged(s, mmio_irqchip);
> +    }
> +
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


