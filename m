Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FCBCD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWvld-0004qz-0d; Tue, 09 Jun 2026 08:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1wWvlb-0004qh-9R; Tue, 09 Jun 2026 08:41:15 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1wWvlZ-0003Kl-K2; Tue, 09 Jun 2026 08:41:15 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 53E44601DC;
 Tue,  9 Jun 2026 12:41:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134841F00893;
 Tue,  9 Jun 2026 12:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781008872;
 bh=gdFWwupeABirGKtuLIonyynWxBena413bVbMEmUpeEw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=WT2uIx6V2GcUVquXQsi9TnlnRv1Nu+DOvmC13BPM2UA+MEK8OjtoBnJAwuKRSBtdL
 SN/rT4xpsWjwcdsXBBGpQ7Bh9FCrmd4KF3g9s+vh6UBcxlu1y+GOrAZgKi25hzjD0n
 2M6kdlG91leaGIvQufE9JxKHprFL8vCpCICymdRFz8NQZyHcrocxnbxUKoLx5RD6W7
 dscxFM5/me7reqsmLPRt/Xs7G//eLRqBJiClHVG8dPVV8kEHjT/ARZv05iGgsm4X7G
 hjCgkVaKeEgRf4JmUal3Kj1IPX12YOV8UbcUPaxQ1kJFdmvYrcqrKb4m0TyzIJHikE
 RmzCnCqkPNMLQ==
Date: Tue, 9 Jun 2026 13:41:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 sunilvl@ventanamicro.com, jonathan.cameron@huawei.com, fan.ni@samsung.com,
 guoren@kernel.org, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/4] hw/riscv/virt: Add CXL support to the RISC-V virt
 machine
Message-ID: <20260609134101.1dd53f93@jic23-huawei>
In-Reply-To: <20260602074127.63819-2-cp0613@linux.alibaba.com>
References: <20260602074127.63819-1-cp0613@linux.alibaba.com>
 <20260602074127.63819-2-cp0613@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=jic23@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue,  2 Jun 2026 15:41:24 +0800
Chen Pei <cp0613@linux.alibaba.com> wrote:

> Enable CXL support on the RISC-V virt machine following the same
> approach used by the ARM virt machine:
> - Add PXB and ACPI_CXL Kconfig selections
> - Add CXLState and PCIBus pointer to RISCVVirtState
> - Register CXL machine properties via cxl_machine_init()
> - Create CXL host register region above the PCIe high MMIO region
> - Call cxl_hook_up_pxb_registers() and cxl_fmws_link_targets() at
>   machine_done time
> - Map Fixed Memory Windows above the CXL host register region
> - Add ACPI0017 device in DSDT and build CEDT table in virt-acpi-build.c
> 
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
Just really minor stuff inline. Been a while since we added an architecture
but all looks fine to me.

Reviewed-by: Jonathan Cameron <jic23@kernel.org>

> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index ce64eaaef7..899f632de7 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -55,6 +55,8 @@
>  #include "hw/pci/pci.h"
>  #include "hw/pci-host/gpex.h"
>  #include "hw/display/ramfb.h"
> +#include "hw/cxl/cxl.h"
> +#include "hw/cxl/cxl_host.h"
>  #include "hw/acpi/aml-build.h"
>  #include "qapi/qapi-visit-common.h"
>  #include "hw/virtio/virtio-iommu.h"
> @@ -1259,9 +1261,27 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
>      }
>  
>      GPEX_HOST(dev)->gpex_cfg.bus = PCI_HOST_BRIDGE(dev)->bus;
> +    s->bus = PCI_HOST_BRIDGE(dev)->bus;
>      return dev;
>  }

>  static FWCfgState *create_fw_cfg(const MachineState *ms, hwaddr base)
>  {
>      FWCfgState *fw_cfg;
> @@ -1426,6 +1446,15 @@ static void virt_machine_done(Notifier *notifier, void *data)
>                                       machine_done);
>      MachineState *machine = MACHINE(s);
>      hwaddr start_addr = s->memmap[VIRT_DRAM].base;
> +
> +    if (s->bus) {

There is a guard against !s->bus inside the function so you should be
able to do this unconditionally.

> +        cxl_hook_up_pxb_registers(s->bus, &s->cxl_devices_state,
> +                                  &error_fatal);
> +    }
> +
> +    if (s->cxl_devices_state.is_enabled) {
> +        cxl_fmws_link_targets(&error_fatal);
> +    }
>      hwaddr firmware_end_addr;
>      vaddr kernel_start_addr;
>      const char *firmware_name = riscv_default_firmware_name(&s->soc[0]);
> @@ -1663,6 +1692,17 @@ static void virt_machine_init(MachineState *machine)
>              ROUND_UP(virt_high_pcie_memmap.base, virt_high_pcie_memmap.size);
>      }
>  
> +    create_cxl_host_reg_region(s);
> +
> +    if (s->cxl_devices_state.is_enabled) {
> +        hwaddr cxl_base = virt_high_pcie_memmap.base +
> +                          virt_high_pcie_memmap.size;
> +        cxl_base += memory_region_size(&s->cxl_devices_state.host_mr);
> +        cxl_base = ROUND_UP(cxl_base, 256 * MiB);
> +        cxl_fmws_set_memmap(cxl_base, UINT64_MAX);
> +        cxl_fmws_update_mmio();
> +    }
> +
>      /* register system main memory (actual RAM) */
>      memory_region_add_subregion(system_memory, s->memmap[VIRT_DRAM].base,
>                                  machine->ram);
> @@ -1769,6 +1809,8 @@ static void virt_machine_instance_init(Object *obj)
>      s->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
>      s->acpi = ON_OFF_AUTO_AUTO;
>      s->iommu_sys = ON_OFF_AUTO_AUTO;
> +
> +    cxl_machine_init(obj, &s->cxl_devices_state);
>  }
>  
>  static char *virt_get_aia_guests(Object *obj, Error **errp)
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 18a2a323a3..c3201588bb 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -24,6 +24,7 @@
>  #include "hw/core/sysbus.h"
>  #include "hw/block/flash.h"
>  #include "hw/intc/riscv_imsic.h"
> +#include "hw/cxl/cxl.h"
>  
>  #define VIRT_CPUS_MAX_BITS             9
>  #define VIRT_CPUS_MAX                  (1 << VIRT_CPUS_MAX_BITS)
> @@ -64,6 +65,8 @@ struct RISCVVirtState {
>      struct GPEXHost *gpex_host;
>      OnOffAuto iommu_sys;
>      uint16_t pci_iommu_bdf;
> +    CXLState cxl_devices_state;
> +    PCIBus *bus;

That's a very vague bit of naming.  I'd make it explicit what PCIBus this is.

>  };
>  
>  enum {


