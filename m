Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADA7C5B552
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 10:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKwZU-0003VS-A5; Fri, 30 May 2025 06:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uKwZR-0003Ty-Qa; Fri, 30 May 2025 06:02:37 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uKwZO-000056-Hq; Fri, 30 May 2025 06:02:37 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b7zLS25FRz6GDtT;
 Fri, 30 May 2025 18:02:24 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id AEB86140516;
 Fri, 30 May 2025 18:02:29 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 May
 2025 12:02:29 +0200
Date: Fri, 30 May 2025 11:02:27 +0100
To: Eric Auger <eric.auger@redhat.com>
CC: <eric.auger.pro@gmail.com>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>, <peter.maydell@linaro.org>, <imammedo@redhat.com>,
 <gustavo.romero@linaro.org>, <anisinha@redhat.com>, <mst@redhat.com>,
 <shannon.zhaosl@gmail.com>, <pbonzini@redhat.com>, <philmd@linaro.org>,
 <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 05/25] hw/pci-host/gpex-acpi: Split host bridge OSC
 and DSM generation
Message-ID: <20250530110227.00003341@huawei.com>
In-Reply-To: <20250527074224.1197793-6-eric.auger@redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-6-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, 27 May 2025 09:40:07 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> acpi_dsdt_add_pci_osc() name is confusing as it gives the impression
> it appends the _OSC method but in fact it also appends the _DSM method
> for the host bridge. Let's split the function into two separate ones
> and let them return the method Aml pointer instead. This matches the
> way it is done on x86 (build_q35_osc_method). In a subsequent patch
> we will replace the gpex method by the q35 implementation that will
> become shared between ARM and x86.
> 
> acpi_dsdt_add_host_bridge_methods is a new top helper that generates
> both the _OSC and _DSM methods.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>

Makes complete sense. I've had local equivalent of this on the CXL
tree for a while as without it we don't register the _DSM for the
CXL path (and we should).  However, can you modify it a little to
make that easier for me?  Basically make sure the _DSM is registered
for the CXL path as well.

One other comment inline.


> ---
>  hw/pci-host/gpex-acpi.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> index f34b7cf25e..1aa2d12026 100644
> --- a/hw/pci-host/gpex-acpi.c
> +++ b/hw/pci-host/gpex-acpi.c
> @@ -50,13 +50,10 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
>      }
>  }
>  
> -static void acpi_dsdt_add_pci_osc(Aml *dev, bool enable_native_pcie_hotplug)
> +static Aml *build_host_bridge_osc(bool enable_native_pcie_hotplug)
>  {
> -    Aml *method, *UUID, *ifctx, *ifctx1, *elsectx, *buf;
> +    Aml *method, *UUID, *ifctx, *ifctx1, *elsectx;
>  
> -    /* Declare an _OSC (OS Control Handoff) method */
> -    aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
> -    aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
>      method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
>      aml_append(method,
>          aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
> @@ -103,9 +100,13 @@ static void acpi_dsdt_add_pci_osc(Aml *dev, bool enable_native_pcie_hotplug)
>                                 aml_name("CDW1")));
>      aml_append(elsectx, aml_return(aml_arg(3)));
>      aml_append(method, elsectx);
> -    aml_append(dev, method);
> +    return method;
> +}
>  
> -    method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
> +static Aml *build_host_bridge_dsm(void)
> +{
> +    Aml *method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
> +    Aml *UUID, *ifctx, *ifctx1, *buf;
>  
>      /* PCI Firmware Specification 3.0
>       * 4.6.1. _DSM for PCI Express Slot Information
> @@ -124,7 +125,17 @@ static void acpi_dsdt_add_pci_osc(Aml *dev, bool enable_native_pcie_hotplug)
>      byte_list[0] = 0;
>      buf = aml_buffer(1, byte_list);
>      aml_append(method, aml_return(buf));
> -    aml_append(dev, method);
> +    return method;
> +}
> +
> +static void acpi_dsdt_add_host_bridge_methods(Aml *dev,
> +                                              bool enable_native_pcie_hotplug)
> +{
> +    aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
> +    aml_append(dev, aml_name_decl("CTRL", aml_int(0)));

These two declarations seem to be very much part of the _OSC build though not
within the the method.  I 'think' you get left with them later with no users.
So move them into the osc build here and they will naturally go away when
you move to the generic code.

They end up unused in the DSDT at the end of the series.

I ran a quick GPEX + pxb-pcie test and we do get the odd mix that the OSC for
the GPEX say no native hotplug but the OSC for the PXB allows it.

> +    /* Declare an _OSC (OS Control Handoff) method */
> +    aml_append(dev, build_host_bridge_osc(enable_native_pcie_hotplug));
> +    aml_append(dev, build_host_bridge_dsm());
>  }
>  
>  void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
> @@ -193,7 +204,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>              if (is_cxl) {
>                  build_cxl_osc_method(dev);
>              } else {
> -                acpi_dsdt_add_pci_osc(dev, true);
> +                acpi_dsdt_add_host_bridge_methods(dev, true);

Can you either drop the use of the wrapper for the DSM part here and call
it unconditionally (for cxl and PCIe cases) or add an extra call to
aml_append(dev, build_host_bridge_dsm()) for the is_cxl path?

>              }
>  
>              aml_append(scope, dev);
> @@ -268,7 +279,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>      }
>      aml_append(dev, aml_name_decl("_CRS", rbuf));
>  
> -    acpi_dsdt_add_pci_osc(dev, true);
> +    acpi_dsdt_add_host_bridge_methods(dev, true);
>  
>      Aml *dev_res0 = aml_device("%s", "RES0");
>      aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));


