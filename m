Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5C1C71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 08:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSXTm-0003Y3-9I; Fri, 20 Jun 2025 04:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uSXTj-0003X8-V4; Fri, 20 Jun 2025 04:52:07 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uSXTi-0002uL-91; Fri, 20 Jun 2025 04:52:07 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bNrh41ctrz6L66H;
 Fri, 20 Jun 2025 16:47:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 3344E140446;
 Fri, 20 Jun 2025 16:52:02 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 20 Jun
 2025 10:52:01 +0200
Date: Fri, 20 Jun 2025 09:52:00 +0100
To: Eric Auger <eric.auger@redhat.com>
CC: <eric.auger.pro@gmail.com>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>, <peter.maydell@linaro.org>, <imammedo@redhat.com>,
 <gustavo.romero@linaro.org>, <anisinha@redhat.com>, <mst@redhat.com>,
 <shannon.zhaosl@gmail.com>, <pbonzini@redhat.com>, <philmd@linaro.org>,
 <alex.bennee@linaro.org>
Subject: Re: [PATCH v3 07/29] hw/pci-host/gpex-acpi: retrieve and use GED
 acpi_pcihp setting
Message-ID: <20250620095200.00002e72@huawei.com>
In-Reply-To: <20250616094903.885753-8-eric.auger@redhat.com>
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-8-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 16 Jun 2025 11:46:36 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> retrieve the acpi_pcihp option value from the ged. In
> case acpi_pcihp is unset we configure pci native hotplug on
> pci0. For expander bridges we keep legacy pci native hotplug,
> as done on x86 q35.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
One minor thing inline

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> 
> ---
> 
> v2 -> v3:
> - don'use the virt arm machine option anymore.
> ---
>  include/hw/pci-host/gpex.h | 1 +
>  hw/arm/virt-acpi-build.c   | 5 +++++
>  hw/pci-host/gpex-acpi.c    | 3 ++-
>  3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
> index 84471533af..feaf827474 100644
> --- a/include/hw/pci-host/gpex.h
> +++ b/include/hw/pci-host/gpex.h
> @@ -45,6 +45,7 @@ struct GPEXConfig {
>      MemMapEntry pio;
>      int         irq;
>      PCIBus      *bus;
> +    bool        pci_native_hotplug;
>  };
>  
>  typedef struct GPEXIrq GPEXIrq;
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 7e8e0f0298..d7547c8d3b 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -123,12 +123,17 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
>                                uint32_t irq, VirtMachineState *vms)
>  {
>      int ecam_id = VIRT_ECAM_ID(vms->highmem_ecam);
> +    AcpiGedState *acpi_ged_state = ACPI_GED(vms->acpi_dev);
> +    AcpiPciHpState *pcihp_state = &acpi_ged_state->pcihp_state;
> +

Trivial, but why 2 blank lines? One seems enough here.

> +
>      struct GPEXConfig cfg = {
>          .mmio32 = memmap[VIRT_PCIE_MMIO],
>          .pio    = memmap[VIRT_PCIE_PIO],
>          .ecam   = memmap[ecam_id],
>          .irq    = irq,
>          .bus    = vms->bus,
> +        .pci_native_hotplug = !pcihp_state->use_acpi_hotplug_bridge,
>      };
>  
>      if (vms->highmem_mmio) {
> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> index 80fc2bf032..44737a8d81 100644
> --- a/hw/pci-host/gpex-acpi.c
> +++ b/hw/pci-host/gpex-acpi.c
> @@ -203,6 +203,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>              if (is_cxl) {
>                  build_cxl_osc_method(dev);
>              } else {
> +                /* pxb bridges do not have ACPI PCI Hot-plug enabled */
>                  acpi_dsdt_add_host_bridge_methods(dev, true);
>              }
>  
> @@ -278,7 +279,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>      }
>      aml_append(dev, aml_name_decl("_CRS", rbuf));
>  
> -    acpi_dsdt_add_host_bridge_methods(dev, true);
> +    acpi_dsdt_add_host_bridge_methods(dev, cfg->pci_native_hotplug);
>  
>      Aml *dev_res0 = aml_device("%s", "RES0");
>      aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));


