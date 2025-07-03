Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DA8C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 04:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXBxq-0007gL-FD; Thu, 03 Jul 2025 00:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1uXBxo-0007g9-RG
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 00:54:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1uXBxk-00078t-3i
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 00:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751518458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DeNo4f5gh66b/VFDDtOJaKVnw6n1H/re0cE1EqqF26A=;
 b=JxHcgtjeoevKFtAkDk695mmumsAmB454OL9loknq8DHByXVxRTY0WImeh7raOvV7NZp6Np
 jn5uTGN7uswLYLdF2rrFUPfk+QCv01faJueHJ4gu7slGPMv2cqo2w2aYC1WT6w4UdhtZx5
 8U+JygJ8xKgvzipybD/Xy1ITv1Yc2u4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-tUa_h7fOMwa7aBhvO1EWGg-1; Thu, 03 Jul 2025 00:54:15 -0400
X-MC-Unique: tUa_h7fOMwa7aBhvO1EWGg-1
X-Mimecast-MFC-AGG-ID: tUa_h7fOMwa7aBhvO1EWGg_1751518455
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4f85f31d9so3171085f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 21:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751518454; x=1752123254;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DeNo4f5gh66b/VFDDtOJaKVnw6n1H/re0cE1EqqF26A=;
 b=WQk6UPAvGP61ob6wgeuhQaiq8roFrwsM9yRn2WX3ZmteZtCaUDkm5wLWB0qf3HyaQ6
 dPWewZZVEEGUBq16l2iae3aO3ZLflr+uVHbN1Ymfif8hyhuCq1b0uqHBvVqanMc72H+v
 oLT+EtQ8uQKHUpXWv4DYmcklI+QnQa0TygqLEXpgXm1HoeqWMQQdLuS/0fECCAj/Gdtm
 4nbgNCeqYuxaHjqym4RfEiQeqtnBLFzYJqs9U0m6fH8J6h/mx8uJy8WDCkMDF+wf83od
 KYkk6E6dyYCZ7ykq+18BrwEDzVthhY1hf9WkKWwVUXIv3pWV3/GQlxa1cCPZamDaoF1m
 yD7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/mAvX99fC3mcDo4tEvUHq+yIvTak0o3/83zz/5+KpK4tVc031w4iuiZk9n3NAbNFp46gFPNdFdxh6@nongnu.org
X-Gm-Message-State: AOJu0YwG2/+7Q/jPkI0MGDmocNneGeVsmkmtxxtyvL8C2NWkwAicGhPV
 1SZAXLOSx4WSC583kbpumZnn5hGQvw7U1b4jrmB/FsE6v5ATJLzk07FwjgIUj/0VNnNQBJR8Gop
 Ae4ChNW+gkGNTSGhKx6DhWfqoIGUa975bcKftKqognuXbMFqkvormuhMT
X-Gm-Gg: ASbGncvqWsgKBxdXU94V/+f2iJzXVHZDH6TRGZOzPE4+sSsEyyNJhQ1+BNYNWPB85iR
 rgQduqaZxlcrIcijimaVFIfEBUp/YjR600zIsankF9twp1X62MR7dgrLEdvENBmLW0S5CNqG8Of
 FShG4L82xwKlM5ovCu0GYQfnji+Vf+jCU6cARva3uE41DOwteCYVRooNFbipnCgSEkQf5As8Xtd
 pJgyTpaveOo8YvzuxGVBceWM0RM4uWkZaQ1hh1Cd8i2h1CAZNM5qU76ABjF5rBeqgTpskZbzDBi
 x5uAGMLAumjePzdPi9c0W8r3FiJdsvS5P4HghNSrPda8Y0pCxi5CEmGxSiuQE1XT
X-Received: by 2002:adf:b64d:0:b0:3a1:f564:cd9d with SMTP id
 ffacd0b85a97d-3b32eccbf61mr814359f8f.36.1751518454516; 
 Wed, 02 Jul 2025 21:54:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKasxARqBmvYBQtBriQSAyHhNZyU94P/H6tC4EQAVWSh7Ee744Cd8/vWL0F60/XUsvJTFliQ==
X-Received: by 2002:adf:b64d:0:b0:3a1:f564:cd9d with SMTP id
 ffacd0b85a97d-3b32eccbf61mr814341f8f.36.1751518453995; 
 Wed, 02 Jul 2025 21:54:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fada5sm17865523f8f.32.2025.07.02.21.54.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 21:54:13 -0700 (PDT)
Message-ID: <f47d2860-ed26-47c7-9ec0-9fb77d7b7694@redhat.com>
Date: Thu, 3 Jul 2025 06:54:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] hw/i386: Add the ramfb romfile compatibility
Content-Language: en-US
To: Shaoqin Huang <shahuang@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
References: <20250703012836.2177297-1-shahuang@redhat.com>
 <20250703012836.2177297-3-shahuang@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20250703012836.2177297-3-shahuang@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Shaoqin,

On 7/3/25 3:28 AM, Shaoqin Huang wrote:
> Set the "use-legacy-x86-rom" property to false by default, and only set
> it to true on x86 since only x86 will need it.
> 
> At the same time, set the "use-legacy-x86-rom" property to true on those
> historical versioned machine types in order to avoid the memory layout
> being changed.

I would improve the commit message by adding Gerd's inputs:

"
ramfb is a sysbus device so it can only used for machine types where it
is explicitly enabled:

  # git grep machine_class_allow_dynamic_sysbus_dev.*TYPE_RAMFB_DEVICE
  hw/arm/virt.c:    machine_class_allow_dynamic_sysbus_dev(mc,
TYPE_RAMFB_DEVICE);
  hw/i386/microvm.c:    machine_class_allow_dynamic_sysbus_dev(mc,
TYPE_RAMFB_DEVICE);
  hw/i386/pc_piix.c:    machine_class_allow_dynamic_sysbus_dev(m,
TYPE_RAMFB_DEVICE);
  hw/i386/pc_q35.c:    machine_class_allow_dynamic_sysbus_dev(m,
TYPE_RAMFB_DEVICE);
  hw/loongarch/virt.c:    machine_class_allow_dynamic_sysbus_dev(mc,
TYPE_RAMFB_DEVICE);
  hw/riscv/virt.c:    machine_class_allow_dynamic_sysbus_dev(mc,
TYPE_RAMFB_DEVICE);

So these six are the only machine types we have to worry about.

The three x86 machine types (pc, q35, microvm) will actually use the rom
(when booting with seabios).

For arm/riscv/loongarch virt we want to disable the rom.

"

This patch sets ramfb romfile option to false by default, except for x86
machines types (pc, q35, microvm) which need the rom file when booting
with seabios and machine types <= 10.0 (handling the case of arm virt,
for compat reasons).

> 
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
Besides I think it now does what it is supposed to. With the commit
description improvement:

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/core/machine.c             |  2 ++
>  hw/display/ramfb-standalone.c |  2 +-
>  hw/i386/microvm.c             |  3 +++
>  hw/i386/pc_piix.c             | 10 ++++++++++
>  hw/i386/pc_q35.c              |  3 +++
>  hw/vfio/pci.c                 |  2 +-
>  6 files changed, 20 insertions(+), 2 deletions(-)
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
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index e0daf0d4fc..6666db9e4f 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -49,6 +49,7 @@
>  #include "hw/acpi/generic_event_device.h"
>  #include "hw/pci-host/gpex.h"
>  #include "hw/usb/xhci.h"
> +#include "hw/vfio/pci.h"
>  
>  #include "elf.h"
>  #include "kvm/kvm_i386.h"
> @@ -633,6 +634,8 @@ GlobalProperty microvm_properties[] = {
>       * so reserving io space is not going to work.  Turn it off.
>       */
>      { "pcie-root-port", "io-reserve", "0" },
> +    { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
> +    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
>  };
>  
>  static void microvm_class_init(ObjectClass *oc, const void *data)
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


