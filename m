Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515B7C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 13:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJupI-0002CK-19; Tue, 27 May 2025 09:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJupE-0002AA-Oz
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:58:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJupC-0005bI-CH
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748354316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9RfskbJ/6t5P19T9joHCP9S1OtUd5AIqA1Wk+AehjMc=;
 b=KEKeeyRTAlIRvxCNKvH0mK5WtUQA9gkt1wsBAejhXQ3QXzDIARaX8dJbtC1khwmhuU/Sxx
 XsZgM470A3iIj0PSs5mmf6m4Ip2bDvUm61d7rHd4/lWOMImppqV+42iMHROFM/KxpxsLHX
 ZnTYTAdIWLfY9PT2qeg0yevkod9zf2E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-FGD5KqbWO4O-AN6QN0nz_Q-1; Tue, 27 May 2025 09:58:34 -0400
X-MC-Unique: FGD5KqbWO4O-AN6QN0nz_Q-1
X-Mimecast-MFC-AGG-ID: FGD5KqbWO4O-AN6QN0nz_Q_1748354314
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-445135eb689so21335605e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 06:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748354313; x=1748959113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9RfskbJ/6t5P19T9joHCP9S1OtUd5AIqA1Wk+AehjMc=;
 b=TPgltqnb2QtpxuXviB2lGJpiFkqN6l+FFZGbL3i1GidpO1iIyZApAsQxgLzFT9Q/eF
 mHtcxqmLssBa7URRgdz4zCYUOljAsczVWvwHx01mFWoVrRFxdJHBkHympHcn17vjIhN9
 KN75q7t32e9MOEKe0FZ0n+8P6mNh/odrTE/cmWATbmzmhkDG9VY4z5y9xckOvICtnflG
 QdqChVJY7Pkv7mf3pfYbBh9NJrV6+EoUp/H89qyrYHF613jA3VtOsk5o2+0BQoIP95F8
 guCGxO0SP2YZS4UDDimFUVXb3RTtR6hvGMrhpmo5KlcShoOOn+0ILvcrqApkqRETh4in
 01pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCKLAUbDbQZFoXfjN3IRkGyfOiOenUZs7AtteQckvHtHP+24sLXyRs1LWJY8sulXDMYuBZzdTMS1Iv@nongnu.org
X-Gm-Message-State: AOJu0YwhySJg08VXHnOh6qCP3hjH70QrGBg6jeQJoqWHWrvuCOd+0cTN
 Cw5K8vFDCdkTiBE4BEtwZkCei207K05h2H0XXRDI6wwEv7epfGFi26KYstCkInyr/V0hxCTKxSb
 8fsGE8gzA1vbmRvn3nVbRG/dofmENHHJ0A8xteWKxuGyXXyTM7DsHsWD0
X-Gm-Gg: ASbGncsE+iw694t1Kul9zSvseAzrYj37f1mWer+fSHE+3lcdsPayjZd6SK5YNKAVDkn
 b2ZM4ZHU3coSWGXwnovKIgPPBrP0iw+nVXb5c3Jozil1T4WMJqq8lKFCUSBNOulpM6aWsGPzU1X
 mo1iAxqZLjofY4dkdj/ps6mIKrPSeYjpbE+FD4B3S0PWiXB5zTmTFSQQ9hqih692D12lG0bmGBW
 mkgqoLDVCchOCXvmz/zLSypfWjscCRdMZkovaAC6D+002dR69T3uKjgU512qPWFZ3DffNjzjdtx
 oGmfryb75sknYIcgUc0Az1SD+mzl50/B
X-Received: by 2002:a05:600c:1e02:b0:43c:e6d1:efe7 with SMTP id
 5b1f17b1804b1-44d5c54c831mr98070425e9.26.1748354313489; 
 Tue, 27 May 2025 06:58:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHoddMybVR5A1MN+0jCN8xXuRzWEeGMbXw6FN64CVgkAoeYsbB7gzdNkGd4oUZy85Ydh+U5g==
X-Received: by 2002:a05:600c:1e02:b0:43c:e6d1:efe7 with SMTP id
 5b1f17b1804b1-44d5c54c831mr98070225e9.26.1748354313100; 
 Tue, 27 May 2025 06:58:33 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f7bae847sm264883555e9.36.2025.05.27.06.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 06:58:32 -0700 (PDT)
Date: Tue, 27 May 2025 15:58:31 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v2 15/25] hw/i386/acpi-build: Introduce and use
 acpi_get_pci_host
Message-ID: <20250527155831.45fcd421@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250527074224.1197793-16-eric.auger@redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-16-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 27 May 2025 09:40:17 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> pcihp acpi_set_pci_info() generic code currently uses
> acpi_get_i386_pci_host() to retrieve the pci host bridge.
> 
> Let's rename acpi_get_i386_pci_host into acpi_get_pci_host and
> move it in pci generic code.
> 
> The helper is augmented with the support of ARM GPEX.
> 
> Also instead of using the machine child property to retrieve
> the PCI host bridge, we search for the actual object type using
> object_resolve_type_unambiguous().
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
> 
> ---
> 
> v1 -> v2
> - described the fact we changed the implementation of
>   acpi_get_pci_host() in the commit msg.
> ---
>  include/hw/acpi/pci.h |  2 ++
>  hw/acpi/pci.c         | 20 ++++++++++++++++++++
>  hw/acpi/pcihp.c       |  3 ++-
>  hw/i386/acpi-build.c  | 24 ++++--------------------
>  4 files changed, 28 insertions(+), 21 deletions(-)
> 
> diff --git a/include/hw/acpi/pci.h b/include/hw/acpi/pci.h
> index 4dca22c0e2..310cbd02db 100644
> --- a/include/hw/acpi/pci.h
> +++ b/include/hw/acpi/pci.h
> @@ -41,4 +41,6 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope);
>  
>  void build_srat_generic_affinity_structures(GArray *table_data);
>  
> +Object *acpi_get_pci_host(void);
> +
>  #endif
> diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
> index d511a85029..4191886ebe 100644
> --- a/hw/acpi/pci.c
> +++ b/hw/acpi/pci.c
> @@ -26,6 +26,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
>  #include "qom/object_interfaces.h"
> +#include "qom/object.h"
>  #include "qapi/error.h"
>  #include "hw/boards.h"
>  #include "hw/acpi/aml-build.h"
> @@ -33,6 +34,9 @@
>  #include "hw/pci/pci_bridge.h"
>  #include "hw/pci/pci_device.h"
>  #include "hw/pci/pcie_host.h"
> +#include "hw/pci-host/i440fx.h"
> +#include "hw/pci-host/q35.h"
> +#include "hw/pci-host/gpex.h"
>  
>  /*
>   * PCI Firmware Specification, Revision 3.0
> @@ -301,3 +305,19 @@ void build_srat_generic_affinity_structures(GArray *table_data)
>      object_child_foreach_recursive(object_get_root(), build_acpi_generic_port,
>                                     table_data);
>  }
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

while it will work, it's getting ridiculous.
(it's not likely to affect performance but if it can be helped,
I'd rather avoid searching)

Can we just reuse host bridge bus in stored in  pcihp state?
aka we do pass root_bus to acpi_pcihp_init() and then there is
AcpiPciHpState::root

then there are other places that call acpi_get_i386_pci_host()
to get root bus, can't we just get it from machine state that
callers get and pass it down as an argument? 


> +}
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index 942669ea89..d800371ddc 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -36,6 +36,7 @@
>  #include "hw/pci-bridge/xio3130_downstream.h"
>  #include "hw/i386/acpi-build.h"
>  #include "hw/acpi/acpi.h"
> +#include "hw/acpi/pci.h"
>  #include "hw/pci/pci_bus.h"
>  #include "migration/vmstate.h"
>  #include "qapi/error.h"
> @@ -102,7 +103,7 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque)
>  static void acpi_set_pci_info(bool has_bridge_hotplug)
>  {
>      static bool bsel_is_set;
> -    Object *host = acpi_get_i386_pci_host();
> +    Object *host = acpi_get_pci_host();
>      PCIBus *bus;
>      BSELInfo info = { .bsel_alloc = ACPI_PCIHP_BSEL_DEFAULT,
>                        .has_bridge_hotplug = has_bridge_hotplug };
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index fe8bc62c03..6feb99e9eb 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -269,27 +269,11 @@ static void acpi_get_misc_info(AcpiMiscInfo *info)
>  #endif
>  }
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
>  static void acpi_get_pci_holes(Range *hole, Range *hole64)
>  {
>      Object *pci_host;
>  
> -    pci_host = acpi_get_i386_pci_host();
> +    pci_host = acpi_get_pci_host();
>  
>      if (!pci_host) {
>          return;
> @@ -1245,7 +1229,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>  
>      sb_scope = aml_scope("\\_SB");
>      {
> -        Object *pci_host = acpi_get_i386_pci_host();
> +        Object *pci_host = acpi_get_pci_host();
>  
>          if (pci_host) {
>              PCIBus *pbus = PCI_HOST_BRIDGE(pci_host)->bus;
> @@ -1306,7 +1290,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>      if (pm->pcihp_bridge_en || pm->pcihp_root_en) {
>          bool has_pcnt;
>  
> -        Object *pci_host = acpi_get_i386_pci_host();
> +        Object *pci_host = acpi_get_pci_host();
>          PCIBus *b = PCI_HOST_BRIDGE(pci_host)->bus;
>  
>          scope = aml_scope("\\_SB.PCI0");
> @@ -1946,7 +1930,7 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
>      Object *pci_host;
>      QObject *o;
>  
> -    pci_host = acpi_get_i386_pci_host();
> +    pci_host = acpi_get_pci_host();
>      if (!pci_host) {
>          return false;
>      }


