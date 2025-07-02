Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A54C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 09:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWtSw-0006qV-23; Wed, 02 Jul 2025 05:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1uWtSu-0006qL-NZ
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 05:09:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1uWtSq-0006Xo-IU
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 05:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751447350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RFoF1A6PGun0NC2K4cjirkZpnv/f5D6F/qRWHcOv57w=;
 b=JxtHdMzaObvtRRuZTCrUY7TXG9X/kWdKA1QaA7LZo5P3dAEVG7+xXGPIJu1rG4nbBv/d2K
 xJI42rAFs7Lb2HgcefFwa50YljxMtgtjKuoDW8ZLa9hGHpBPJPf/WA9zexJbaMiTx4RKuY
 QTagOW1Mx39sfVtGfDZ3DkMVMSfGRFI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-3drwJ1K8PgGNhSky4evR7g-1; Wed, 02 Jul 2025 05:09:09 -0400
X-MC-Unique: 3drwJ1K8PgGNhSky4evR7g-1
X-Mimecast-MFC-AGG-ID: 3drwJ1K8PgGNhSky4evR7g_1751447348
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a578958000so1656676f8f.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 02:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751447348; x=1752052148;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RFoF1A6PGun0NC2K4cjirkZpnv/f5D6F/qRWHcOv57w=;
 b=jWoqpcxKerW5kPzE7FSsBU89HJJF4FrW24xsyQ5PcvPBctFIYWjOxkxVIPKEWA5k3c
 H3S2e/KNbKBOgtk3+5f0J879vlYsQBH7Md3aKOn6GlM3zvGEvfHb5oSiW0NBLnvS1Ukf
 YhcNigRwWKXYkziikn8ouyD2XZMkpdV2mj4HYKTXg7Y/Lae5xECp1JrmsvyuDhsQGaUW
 l9nN70+AwNhdwyN3Li6rzY+qV4mHMbNWBGBEvC70X1QiQCRuvY2H387cs3blV7QeDsYW
 K6qHdxup3TEAQG3PYTi2KeNVrOE6wJkx5DsEFSDQZU1s98j5RGSAXf3yPXHg7YlK7fAh
 Aj4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0BiHCT5rxg2BaNLG2sra9ANTRsmfFgsitF1XQmPOAZ8KX+D+8xVdXBgVSTS+Q6noPdCruYVosh6bo@nongnu.org
X-Gm-Message-State: AOJu0YzRbxAApvz2q3JBjqctiV5W2hsTBwqwmFctNfCwofaLqzQYMGXw
 dBhlHkK6Zq88Ma+0/JGC6MzJb6kHL0C6IGi2jNcD92s/KLcK+WBByiv214AtBzNUlAVtjNdXFGC
 8ngTRu1my4Zc08djLQ2qhGq+s+OyMCMjm2HjiByGzZH+9AQzGEQSDDzg1
X-Gm-Gg: ASbGncvIPvt9cCPgpL3CxaA4HU+OgEOtFBCW3O79HB7K6+O9XxNW3ZLahphqnXI5pUH
 Wh9hkF+UvRW8P6m/Aw0LEB5rrvA5N+Ay/7K9M/+o61JIg+0NggulMLmHZRDXZY1XHkLOv7oBryz
 LjikqwGNP7KhbSM6xHEk08YeKKkJzuX2ZHhCD1bNSq1pvsoZj+rZaRLcFpudYJxpwKMggZs6zXU
 ZVG2XVKKcciDTvY4h0lELrbxzhJynSIQUscRrrUv8LVXf1w537QP76FjMCfqLvSTFy7acD6Fofm
 lL9I/aw77/VLhmshRsmLWdJXuO6kFFaipMLvUqwnoHXOMATt4qdTnrpgvhV6r6GZ
X-Received: by 2002:a05:6000:2481:b0:3a5:276b:1ec0 with SMTP id
 ffacd0b85a97d-3b201f79431mr1338377f8f.45.1751447347648; 
 Wed, 02 Jul 2025 02:09:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKspJ/FGsXUfdV84EE7zxqlLFFaIJD1H+GqjJMOPWLSuDQVCAyI6CFaoVWcfmYzoHpr4wGTA==
X-Received: by 2002:a05:6000:2481:b0:3a5:276b:1ec0 with SMTP id
 ffacd0b85a97d-3b201f79431mr1338332f8f.45.1751447347114; 
 Wed, 02 Jul 2025 02:09:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5963csm15527288f8f.79.2025.07.02.02.09.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 02:09:06 -0700 (PDT)
Message-ID: <dec256c0-d0a5-49d7-b5ce-a025eaf27f8c@redhat.com>
Date: Wed, 2 Jul 2025 11:08:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] hw/i386: Add the ramfb romfile compatibility
Content-Language: en-US
To: Shaoqin Huang <shahuang@redhat.com>, qemu-arm@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
References: <20250702085616.2172722-1-shahuang@redhat.com>
 <20250702085616.2172722-3-shahuang@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20250702085616.2172722-3-shahuang@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 7/2/25 10:56 AM, Shaoqin Huang wrote:
> Set the "use-legacy-x86-rom" property to false by default, and only set
> it to true on x86 since only x86 will need it.
> 
> At the same time, set the "use-legacy-x86-rom" property to true on those
> historical versioned machine types in order to avoid the memory layout
> being changed.
> 
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>  hw/core/machine.c             |  2 ++
>  hw/display/ramfb-standalone.c |  2 +-
>  hw/i386/pc_piix.c             | 10 ++++++++++
>  hw/i386/pc_q35.c              |  3 +++
If I understood correctly, Gerd said we needed to set the prop to "true"
on microvm too? I don't see that change.

Eric
>  hw/vfio/pci.c                 |  2 +-
>  5 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index e869821b22..a7043e2a34 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -39,6 +39,8 @@
>  
>  GlobalProperty hw_compat_10_0[] = {
>      { "scsi-hd", "dpofua", "off" },
> +    { "ramfb", "use-legacy-x86-rom", "true"},
> +    { "vfio-pci", "use-legacy-x86-rom", "true" },
>  };
>  const size_t hw_compat_10_0_len = G_N_ELEMENTS(hw_compat_10_0);
>  
> diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
> index 725aef9896..b20a7c57b3 100644
> --- a/hw/display/ramfb-standalone.c
> +++ b/hw/display/ramfb-standalone.c
> @@ -63,7 +63,7 @@ static const VMStateDescription ramfb_dev_vmstate = {
>  
>  static const Property ramfb_properties[] = {
>      DEFINE_PROP_BOOL("x-migrate", RAMFBStandaloneState, migrate,  true),
> -    DEFINE_PROP_BOOL("use-legacy-x86-rom", RAMFBStandaloneState, use_legacy_x86_rom, true),
> +    DEFINE_PROP_BOOL("use-legacy-x86-rom", RAMFBStandaloneState, use_legacy_x86_rom, false),
>  };
>  
>  static void ramfb_class_initfn(ObjectClass *klass, const void *data)
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index ea7572e783..8ec8d8ae6d 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -49,6 +49,7 @@
>  #include "hw/i2c/smbus_eeprom.h"
>  #include "system/memory.h"
>  #include "hw/acpi/acpi.h"
> +#include "hw/vfio/pci.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "system/xen.h"
> @@ -77,6 +78,13 @@ static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
>  static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
>  #endif
>  
> +static GlobalProperty pc_piix_compat_defaults[] = {
> +    { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
> +    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
> +};
> +static const size_t pc_piix_compat_defaults_len =
> +    G_N_ELEMENTS(pc_piix_compat_defaults);
> +
>  /*
>   * Return the global irq number corresponding to a given device irq
>   * pin. We could also use the bus number to have a more precise mapping.
> @@ -482,6 +490,8 @@ static void pc_i440fx_machine_options(MachineClass *m)
>                                     pc_set_south_bridge);
>      object_class_property_set_description(oc, "x-south-bridge",
>                                       "Use a different south bridge than PIIX3");
> +    compat_props_add(m->compat_props,
> +                     pc_piix_compat_defaults, pc_piix_compat_defaults_len);
>  }
>  
>  static void pc_i440fx_machine_10_1_options(MachineClass *m)
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 33211b1876..0096eef6f4 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -45,6 +45,7 @@
>  #include "hw/i386/pc.h"
>  #include "hw/i386/amd_iommu.h"
>  #include "hw/i386/intel_iommu.h"
> +#include "hw/vfio/pci.h"
>  #include "hw/virtio/virtio-iommu.h"
>  #include "hw/display/ramfb.h"
>  #include "hw/ide/pci.h"
> @@ -67,6 +68,8 @@
>  
>  static GlobalProperty pc_q35_compat_defaults[] = {
>      { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "39" },
> +    { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
> +    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
>  };
>  static const size_t pc_q35_compat_defaults_len =
>      G_N_ELEMENTS(pc_q35_compat_defaults);
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index f4fa8a5610..604b337389 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3710,7 +3710,7 @@ static const TypeInfo vfio_pci_dev_info = {
>  
>  static const Property vfio_pci_dev_nohotplug_properties[] = {
>      DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
> -    DEFINE_PROP_BOOL("use-legacy-x86-rom", VFIOPCIDevice, use_legacy_x86_rom, true),
> +    DEFINE_PROP_BOOL("use-legacy-x86-rom", VFIOPCIDevice, use_legacy_x86_rom, false),
>      DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, ramfb_migrate,
>                              ON_OFF_AUTO_AUTO),
>  };


