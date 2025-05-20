Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C84C54E90
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 20:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHT8X-0002re-SQ; Tue, 20 May 2025 16:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uHT8W-0002pP-BM
 for qemu-devel@nongnu.org; Tue, 20 May 2025 16:00:28 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uHT8Q-0007pD-CJ
 for qemu-devel@nongnu.org; Tue, 20 May 2025 16:00:28 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2321c38a948so34484935ad.2
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 13:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747771217; x=1748376017; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GuujTtlKxG0Vdawkfcvu+aUrsLj2lJNKbbFDPjMIYSY=;
 b=HYo8B01n2sZD1MuRIDKyfIo1W7R2ZMQtGVIdZPVaKh4FynqejtaJUE7rrfsmaGKonU
 +hEumGz7zlA7ILpH319TvPJ+HdmsuiwxNBrUylj5SsOwqTvQVhLB//+xB4bK3qWx3Wqf
 44zhFrKKE+zzt1ZY43Hjvm6RUuuS5NKSwSDI+39Oocac8AGM+5P9eEwQfGVsO18ZzZvy
 HrSiZ0rHFwppXEiNHnpVkTVJ7cdMK0xQS7z5IrTU3CysqKqdzEfRd1R2uMoDickFktLA
 fh0E9zF53a1AR3uHThT6fvY7Cx4dwMJwoEf2jwLZwHAo3h8AJjl3wG8uwN4rr9eRyNKS
 lt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747771217; x=1748376017;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GuujTtlKxG0Vdawkfcvu+aUrsLj2lJNKbbFDPjMIYSY=;
 b=H7aKGujapP38m2lphm28pYXkeyFbROXz/cRGtBh7BHwayRbndJlsCpGrKoJQ26MCQE
 9DThS/8B/B/5WnhLDqHCuLR8++KRIzLSmwr6P0vlWlM1eZ0bxH33CQMUCzbkrQf+50GD
 Tu2Gv8MVL1ERm/q4ZD1Ne+P+Z3tCq3NAfKqBUmqeWRq5XmABz89+S+qAfch5QQEdoEFm
 Rwb+c9DxgNmLq2Pkl6fyDeqaEhSsnuRUVsBzfjO52oEMtU1uj7HxEF6LFlPPrTeTrewO
 s4KHGlywVVueb1pbZXfhSdxje3Uu2fgoWNehFwu9GhY59c+z0gLUfFUuGLwXAVuzCDzY
 utGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVvPfi1NtLnowQrblEAdHev/EDbGylXac9uXaVS51JtIvDWNUoW6tHGuU2VU8azvGuZjpM8zdII0M6@nongnu.org
X-Gm-Message-State: AOJu0YyYyKEwuhHvKORC+yt5oPgnW4CKkf+6THDjR3HNi8XwQX0k6C+Q
 tbKbNbQnuV0YrnVpICCAB2taA8n/qEoMy390LS2QjC6S8Rkcx44bkKnbCiJGyGeHaUI=
X-Gm-Gg: ASbGncvXoq3lIJQbDsLN6eVDsQoQ7yYYAQjHIc53DPPIUPoHCLjorzJKkDj9x/fhYaW
 gQUu59F6KeYF9J5RLBtH9ttVcuHAvaEj2Tr0Zb1kdPn1Id6w/tjqn7MCq+eJsyP2Z4B5uJx6jFg
 4KYi0IbOXDYV/sTVlhW3dQCi88wv8q77tyqea/yf5GhLiP8aEgvsJW+hydwdxYyrVlz1uRfkxFp
 vO/84pR7/0j8pNMwLILjX+4YxijdiCQJE5UE3Xm4JBid0UkZrWHtnS+uIR8ZHSL3/4Yntd+zy/8
 074oi03H/jF5SDWu6LBiUUftSnyjfNzOW/wF0PngVdN3zXRfstihPdSeovBN1HOyVDdNT0kuwk0
 ygU+8A9N3IOcOUyMHMFazTvNScvz6PQ==
X-Google-Smtp-Source: AGHT+IGzqC0k8AxpmtuO8c9/97gS9sRlZDWsr0SGPhUElNPFsIWbTfGric44UFyXtx4yKEkSxw7CiA==
X-Received: by 2002:a17:902:fc46:b0:231:bf74:e1df with SMTP id
 d9443c01a7336-231de3515demr238550995ad.7.1747771216649; 
 Tue, 20 May 2025 13:00:16 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b401:d47f:6989:b93e:2caa:f174?
 ([2804:7f0:b401:d47f:6989:b93e:2caa:f174])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4ebaef0sm80368435ad.203.2025.05.20.13.00.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 13:00:16 -0700 (PDT)
Message-ID: <9b996b3a-cc60-499e-a8a6-028f16156180@linaro.org>
Date: Tue, 20 May 2025 17:00:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/22] hw/i386/acpi-build: Introduce and use
 acpi_get_pci_host
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org
References: <20250514170431.2786231-1-eric.auger@redhat.com>
 <20250514170431.2786231-14-eric.auger@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250514170431.2786231-14-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x632.google.com
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

Hi Eric,

On 5/14/25 14:01, Eric Auger wrote:
> pcihp acpi_set_pci_info() generic code currently uses
> acpi_get_i386_pci_host() to retrieve the pci host bridge.
> 
> Let's rename acpi_get_i386_pci_host into acpi_get_pci_host and
> move it in pci generic code.
> 
> The helper is augmented with the support of ARM GPEX.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   include/hw/acpi/pci.h |  2 ++
>   hw/acpi/pci.c         | 20 ++++++++++++++++++++
>   hw/acpi/pcihp.c       |  3 ++-
>   hw/i386/acpi-build.c  | 24 ++++--------------------
>   4 files changed, 28 insertions(+), 21 deletions(-)
> 
> diff --git a/include/hw/acpi/pci.h b/include/hw/acpi/pci.h
> index 4dca22c0e2..310cbd02db 100644
> --- a/include/hw/acpi/pci.h
> +++ b/include/hw/acpi/pci.h
> @@ -41,4 +41,6 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope);
>   
>   void build_srat_generic_affinity_structures(GArray *table_data);
>   
> +Object *acpi_get_pci_host(void);
> +
>   #endif
> diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
> index d511a85029..4191886ebe 100644
> --- a/hw/acpi/pci.c
> +++ b/hw/acpi/pci.c
> @@ -26,6 +26,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu/error-report.h"
>   #include "qom/object_interfaces.h"
> +#include "qom/object.h"
>   #include "qapi/error.h"
>   #include "hw/boards.h"
>   #include "hw/acpi/aml-build.h"
> @@ -33,6 +34,9 @@
>   #include "hw/pci/pci_bridge.h"
>   #include "hw/pci/pci_device.h"
>   #include "hw/pci/pcie_host.h"
> +#include "hw/pci-host/i440fx.h"
> +#include "hw/pci-host/q35.h"
> +#include "hw/pci-host/gpex.h"
>   
>   /*
>    * PCI Firmware Specification, Revision 3.0
> @@ -301,3 +305,19 @@ void build_srat_generic_affinity_structures(GArray *table_data)
>       object_child_foreach_recursive(object_get_root(), build_acpi_generic_port,
>                                      table_data);
>   }
> +
> +Object *acpi_get_pci_host(void)
> +{
> +    Object *host;
> +
> +    host = object_resolve_type_unambiguous(TYPE_I440FX_PCI_HOST_BRIDGE, NULL);
> +    if (host) {
> +        return host;
> +    }
> +    host = object_resolve_type_unambiguous(TYPE_Q35_HOST_DEVICE, NULL);
> +    if (host) {
> +        return host;
> +    }
> +    host = object_resolve_type_unambiguous(TYPE_GPEX_HOST, NULL);
> +    return host;
> +}
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index 942669ea89..d800371ddc 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -36,6 +36,7 @@
>   #include "hw/pci-bridge/xio3130_downstream.h"
>   #include "hw/i386/acpi-build.h"
>   #include "hw/acpi/acpi.h"
> +#include "hw/acpi/pci.h"
>   #include "hw/pci/pci_bus.h"
>   #include "migration/vmstate.h"
>   #include "qapi/error.h"
> @@ -102,7 +103,7 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque)
>   static void acpi_set_pci_info(bool has_bridge_hotplug)
>   {
>       static bool bsel_is_set;
> -    Object *host = acpi_get_i386_pci_host();
> +    Object *host = acpi_get_pci_host();
>       PCIBus *bus;
>       BSELInfo info = { .bsel_alloc = ACPI_PCIHP_BSEL_DEFAULT,
>                         .has_bridge_hotplug = has_bridge_hotplug };
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 06b4b8eed4..bcfba2ccb3 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -269,27 +269,11 @@ static void acpi_get_misc_info(AcpiMiscInfo *info)
>   #endif
>   }
>   
> -/*
> - * Because of the PXB hosts we cannot simply query TYPE_PCI_HOST_BRIDGE.
> - * On i386 arch we only have two pci hosts, so we can look only for them.
> - */
> -Object *acpi_get_i386_pci_host(void)
> -{
> -    PCIHostState *host;
> -
> -    host = PCI_HOST_BRIDGE(object_resolve_path("/machine/i440fx", NULL));
> -    if (!host) {
> -        host = PCI_HOST_BRIDGE(object_resolve_path("/machine/q35", NULL));
> -    }
> -
> -    return OBJECT(host);
> -}
> -

It's also possible to add a child prop to the TYPE_GPEX_HOST in create_pcie, like:

@@ -1510,6 +1510,7 @@ static void create_pcie(VirtMachineState *vms)
      MachineClass *mc = MACHINE_GET_CLASS(ms);
  
      dev = qdev_new(TYPE_GPEX_HOST);
+    object_property_add_child(OBJECT(vms), "gpex", OBJECT(dev));

then follow to logic in acpi_get_i386_pci_host via:

PCI_HOST_BRIDGE(object_resolve_path("/machine/gpex", NULL))

but I like better your solution of using the final class types, so:

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

>   static void acpi_get_pci_holes(Range *hole, Range *hole64)
>   {
>       Object *pci_host;
>   
> -    pci_host = acpi_get_i386_pci_host();
> +    pci_host = acpi_get_pci_host();
>   
>       if (!pci_host) {
>           return;
> @@ -1245,7 +1229,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>   
>       sb_scope = aml_scope("\\_SB");
>       {
> -        Object *pci_host = acpi_get_i386_pci_host();
> +        Object *pci_host = acpi_get_pci_host();
>   
>           if (pci_host) {
>               PCIBus *pbus = PCI_HOST_BRIDGE(pci_host)->bus;
> @@ -1306,7 +1290,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>       if (pm->pcihp_bridge_en || pm->pcihp_root_en) {
>           bool has_pcnt;
>   
> -        Object *pci_host = acpi_get_i386_pci_host();
> +        Object *pci_host = acpi_get_pci_host();
>           PCIBus *b = PCI_HOST_BRIDGE(pci_host)->bus;
>   
>           scope = aml_scope("\\_SB.PCI0");
> @@ -1946,7 +1930,7 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
>       Object *pci_host;
>       QObject *o;
>   
> -    pci_host = acpi_get_i386_pci_host();
> +    pci_host = acpi_get_pci_host();
>       if (!pci_host) {
>           return false;
>       }


