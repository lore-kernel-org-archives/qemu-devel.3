Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA0DC25B7C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 13:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAUkb-0006Gl-24; Fri, 24 May 2024 09:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sAUkZ-0006GI-Hl
 for qemu-devel@nongnu.org; Fri, 24 May 2024 09:14:23 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sAUkX-0004Nm-BG
 for qemu-devel@nongnu.org; Fri, 24 May 2024 09:14:23 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f449f09476so5064225ad.1
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 06:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716556460; x=1717161260; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NLPuL7qkrOjeuWCTTHPdF2PWy5GX1XCGAkZV0Y7Cjjg=;
 b=F7tCyv2XX9k/B+fEBNSgVoctmef4Hi9T7Y68Z36L5Ie8onsPwnMzPjD9z2jI0bJKcX
 jzQxkHqrU5L/p9VHfOvObHTWLKYjJmMCN3rzA++FnmMtnTsH+cRuwbOylv9X4uGtWnc1
 n9iGr9lDzrmVEy1WvE0ZEZtUddENdOzietOYNcpz8V1IOruDfVjcVOgKlCsl1/6XXjpj
 Cd9h/3syzeoYRny2ixI9Fvpf0yFHKUx1YD6LTFHn7CgKhaeUX9+19BPZ5GqbR3/PVdTy
 iWKkf4Vizud6cHRj28XUE3vvMLQUZunUP5B9at24WfLfMd4YzVTQFHFbnLRiwOPZ7gUG
 vkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716556460; x=1717161260;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NLPuL7qkrOjeuWCTTHPdF2PWy5GX1XCGAkZV0Y7Cjjg=;
 b=D5VTc56UJITGcL5j94CKhDTtPHj7QCgNSmCMC8XI1d+qp7q+JJlh0KQ8mMSoqRKkNh
 Q8cZ1TRryRiH641XWlkDa0jaNnRSCjUPVWnk/mIIO6Dw+FDDeIr9CRlQN5RCyNG7AtJu
 dD4B9Z4BO9Az+H+YDvwn6vSKDhwf6z+KPfaN+gxYoKqkbzhAhOnpIyOJFl7gA3Up7AGX
 +8Fw5du3eMC9QbEUUWwt2/m6wiC6xp4JidRFic8+r/0fvwPMekCHjB23Z8MUa7PavKzR
 w15MXHEgDvdQA1uBwOqce2jIWR4luRPUWl+oG6BD0BczqYwtlvmmvThrAVv0hU7C8CEV
 ao0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWA3PNHs2a283k8mbej4WHTBvoC4/gD8UW1AFJSuklGvFGN88LXWXvwiWLBOPZROLI5RhOp2J22pTrzlDKGGYpnlMwhq1s=
X-Gm-Message-State: AOJu0Yy3if0MXft1Gk1LeSzOix9t9RImhws9cOJd3NLWLrDdyyCB6iXb
 G+7Cudw4asW/7pFTX50F4F4BeqlWp0VoSHvfRVm8QisCBVj2mV+O6Pbgv4OP4q0=
X-Google-Smtp-Source: AGHT+IHHZX8BfIJ/McXz+7nEFiH6Efgg8Sf9rUM4NvqzPoeqYoWqtHt4Xe9HuIJl0gz9afNgYD+A1w==
X-Received: by 2002:a17:902:74c6:b0:1f3:89c:d5a0 with SMTP id
 d9443c01a7336-1f339f0c879mr58774535ad.13.1716556459612; 
 Fri, 24 May 2024 06:14:19 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.42.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c79b16bsm13622815ad.75.2024.05.24.06.14.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 06:14:19 -0700 (PDT)
Message-ID: <55810d52-0360-40ad-a8d2-3b6a8aa220ae@ventanamicro.com>
Date: Fri, 24 May 2024 10:14:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] hw/riscv/virt: Add memory hotplugging and
 virtio-md-pci support
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>, Atish Patra <atishp@atishpatra.org>,
 Atish Patra <atishp@rivosinc.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Santosh Mamila <santosh.mamila@catalinasystems.io>,
 Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
 Sivakumar Munnangi <siva.munnangi@catalinasystems.io>
References: <20240521105635.795211-1-bjorn@kernel.org>
 <20240521105635.795211-2-bjorn@kernel.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240521105635.795211-2-bjorn@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
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



On 5/21/24 07:56, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> Virtio-based memory devices (virtio-mem/virtio-pmem) allows for
> dynamic resizing of virtual machine memory, and requires proper
> hotplugging (add/remove) support to work.
> 
> Add device memory support for RISC-V "virt" machine, and enable
> virtio-md-pci with the corresponding missing hotplugging callbacks.
> 
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---
>   hw/riscv/Kconfig       |  2 +
>   hw/riscv/virt.c        | 83 +++++++++++++++++++++++++++++++++++++++++-
>   hw/virtio/virtio-mem.c |  5 ++-
>   3 files changed, 87 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index a2030e3a6ff0..08f82dbb681a 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -56,6 +56,8 @@ config RISCV_VIRT
>       select PLATFORM_BUS
>       select ACPI
>       select ACPI_PCI
> +    select VIRTIO_MEM_SUPPORTED
> +    select VIRTIO_PMEM_SUPPORTED
>   
>   config SHAKTI_C
>       bool
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 4fdb66052587..443902f919d2 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -53,6 +53,8 @@
>   #include "hw/pci-host/gpex.h"
>   #include "hw/display/ramfb.h"
>   #include "hw/acpi/aml-build.h"
> +#include "hw/mem/memory-device.h"
> +#include "hw/virtio/virtio-mem-pci.h"
>   #include "qapi/qapi-visit-common.h"
>   #include "hw/virtio/virtio-iommu.h"
>   
> @@ -1407,6 +1409,7 @@ static void virt_machine_init(MachineState *machine)
>       DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
>       int i, base_hartid, hart_count;
>       int socket_count = riscv_socket_count(machine);
> +    hwaddr device_memory_base, device_memory_size;
>   
>       /* Check socket count limit */
>       if (VIRT_SOCKETS_MAX < socket_count) {
> @@ -1420,6 +1423,12 @@ static void virt_machine_init(MachineState *machine)
>           exit(1);
>       }
>   
> +    if (machine->ram_slots > ACPI_MAX_RAM_SLOTS) {
> +        error_report("unsupported amount of memory slots: %"PRIu64,
> +                     machine->ram_slots);
> +        exit(EXIT_FAILURE);
> +    }
> +
>       /* Initialize sockets */
>       mmio_irqchip = virtio_irqchip = pcie_irqchip = NULL;
>       for (i = 0; i < socket_count; i++) {
> @@ -1553,6 +1562,37 @@ static void virt_machine_init(MachineState *machine)
>       memory_region_add_subregion(system_memory, memmap[VIRT_MROM].base,
>                                   mask_rom);
>   
> +    /* device memory */
> +    device_memory_base = ROUND_UP(s->memmap[VIRT_DRAM].base + machine->ram_size,
> +                                  GiB);
> +    device_memory_size = machine->maxram_size - machine->ram_size;
> +    if (device_memory_size > 0) {
> +        /*
> +         * Each DIMM is aligned based on the backend's alignment value.
> +         * Assume max 1G hugepage alignment per slot.
> +         */
> +        device_memory_size += machine->ram_slots * GiB;

We don't need to align to 1GiB. This calc can use 2MiB instead (or 4MiB if we're
running 32 bits).

> +
> +        if (riscv_is_32bit(&s->soc[0])) {
> +            hwaddr memtop = device_memory_base + ROUND_UP(device_memory_size,
> +                                                          GiB);

Same here - alignment is 2/4 MiB.

> +
> +            if (memtop > UINT32_MAX) {
> +                error_report("memory exceeds 32-bit limit by %lu bytes",
> +                             memtop - UINT32_MAX);
> +                exit(EXIT_FAILURE);
> +            }
> +        }
> +
> +        if (device_memory_base + device_memory_size < device_memory_size) {
> +            error_report("unsupported amount of device memory");
> +            exit(EXIT_FAILURE);
> +        }

Took another look and found this a bit strange. These are all unsigned vars, so
if (unsigned a + unsigned b < unsigned b) will always be 'false'. The compiler is
probably cropping this out.

The calc we need to do is to ensure that the extra ram_slots * alignment will fit into
the VIRT_DRAM block, i.e. maxram_size + (ram_slots * alignment) < memmap[VIRT_DRAM].size.


TBH I'm starting to have second thoughts about letting users hotplug whatever they want.
It seems cleaner to just force the 2/4 Mb alignment in pre_plug() and be done with it,
no need to allocate ram_slots * alignment and doing all these extra checks.

As I sent in an earlier email, users must already comply to the alignment of the host
memory when plugging pc-dimms, so I'm not sure our value/proposition with all this
extra code is worth it - the alignment will most likely be forced by the host memory
backend, so might as well force ourselves in pre_plug().


Thanks,


Daniel


> +
> +        machine_memory_devices_init(machine, device_memory_base,
> +                                    device_memory_size);
> +    }
> +
>       /*
>        * Init fw_cfg. Must be done before riscv_load_fdt, otherwise the
>        * device tree cannot be altered and we get FDT_ERR_NOSPACE.
> @@ -1712,12 +1752,21 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>   
>       if (device_is_dynamic_sysbus(mc, dev) ||
> -        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
> +        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI) ||
> +        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>           return HOTPLUG_HANDLER(machine);
>       }
>       return NULL;
>   }
>   
> +static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
> +                                            DeviceState *dev, Error **errp)
> +{
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
> +        virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
> +    }
> +}
> +
>   static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>                                           DeviceState *dev, Error **errp)
>   {
> @@ -1735,6 +1784,35 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>       if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
>           create_fdt_virtio_iommu(s, pci_get_bdf(PCI_DEVICE(dev)));
>       }
> +
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
> +        virtio_md_pci_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
> +    }
> +}
> +
> +static void virt_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
> +                                                  DeviceState *dev,
> +                                                  Error **errp)
> +{
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
> +        virtio_md_pci_unplug_request(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev),
> +                                     errp);
> +    } else {
> +        error_setg(errp,
> +                   "device unplug request for unsupported device type: %s",
> +                   object_get_typename(OBJECT(dev)));
> +    }
> +}
> +
> +static void virt_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
> +                                          DeviceState *dev, Error **errp)
> +{
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
> +        virtio_md_pci_unplug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
> +    } else {
> +        error_setg(errp, "virt: device unplug for unsupported device"
> +                   " type: %s", object_get_typename(OBJECT(dev)));
> +    }
>   }
>   
>   static void virt_machine_class_init(ObjectClass *oc, void *data)
> @@ -1757,7 +1835,10 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>       assert(!mc->get_hotplug_handler);
>       mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
>   
> +    hc->pre_plug = virt_machine_device_pre_plug_cb;
>       hc->plug = virt_machine_device_plug_cb;
> +    hc->unplug_request = virt_machine_device_unplug_request_cb;
> +    hc->unplug = virt_machine_device_unplug_cb;
>   
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
>   #ifdef CONFIG_TPM
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index ffd119ebacb7..6636e5e1089c 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -51,7 +51,8 @@ static uint32_t virtio_mem_default_thp_size(void)
>   {
>       uint32_t default_thp_size = VIRTIO_MEM_MIN_BLOCK_SIZE;
>   
> -#if defined(__x86_64__) || defined(__arm__) || defined(__powerpc64__)
> +#if defined(__x86_64__) || defined(__arm__) || defined(__powerpc64__) \
> +    || defined(__riscv__)
>       default_thp_size = 2 * MiB;
>   #elif defined(__aarch64__)
>       if (qemu_real_host_page_size() == 4 * KiB) {
> @@ -161,7 +162,7 @@ static bool virtio_mem_has_shared_zeropage(RAMBlock *rb)
>    * necessary (as the section size can change). But it's more likely that the
>    * section size will rather get smaller and not bigger over time.
>    */
> -#if defined(TARGET_X86_64) || defined(TARGET_I386)
> +#if defined(TARGET_X86_64) || defined(TARGET_I386)  || defined(TARGET_RISCV)
>   #define VIRTIO_MEM_USABLE_EXTENT (2 * (128 * MiB))
>   #elif defined(TARGET_ARM)
>   #define VIRTIO_MEM_USABLE_EXTENT (2 * (512 * MiB))

