Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8C2C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 08:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXEt2-0007HZ-5B; Thu, 03 Jul 2025 04:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uXEsv-0007HG-GQ
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 04:01:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uXEst-0000YQ-73
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 04:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751529688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3c3DKauhdLkdsks44u+qLiNGjcmkNrdblfu+4EWIQ+w=;
 b=Mrep1jphf++4AJfkv2mamBPDJX6qsWla63BAORGClbi6xsqjtG4jmH8CVfpeJtZc8+r69y
 pcyFksRy+ktImVr53NjJFZm9a9fazsObDlhn8rJiT8bujfRcBIFsuOSIqJ2tPQeke15rDM
 OUwvSUOWPpe5rXQ1Xq21wJbZ2dYSyUs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-y_k3X7vaOQWQuN48nxd_xA-1; Thu, 03 Jul 2025 04:01:26 -0400
X-MC-Unique: y_k3X7vaOQWQuN48nxd_xA-1
X-Mimecast-MFC-AGG-ID: y_k3X7vaOQWQuN48nxd_xA_1751529685
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3132c8437ffso6265426a91.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 01:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751529685; x=1752134485;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3c3DKauhdLkdsks44u+qLiNGjcmkNrdblfu+4EWIQ+w=;
 b=YL7upWqbl3I5HpihyJvfFNg1XlXlz4xentTLKQLv2o+c8Y9hwUPEa3rfiYXduBjE3N
 ukFGvQx1afhu1jvGd8mqkOiNRyEyidrw48SDYLjJvy968cFvbtV5VZ6dpqBAoFniCuVy
 jAp0RA4lxsob03jh5w5f8XalM9Aez94lv30q2Kva+Hr/lKUo8FJXM40maTqsjGMnHBfk
 qya3jecItkzk3IsGlD88T6LMwNKczzpZW5knm/wwQwpjaK0C2aH9zZlrj2p5uxfUPD71
 wvc84EFoCRJJwP8Daw+IbnLzVkBg8w3Gn8WxDHVNWUXgjz2D5tMXl/YroU3DIayecKxN
 ampA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq69KcGnv5I8CkBVqIkEK8T2ch+Mw7E5KAyiIlRDgANg/AE4WDqyrSatWFMaM5mA0v4FbfMiw+Zlh4@nongnu.org
X-Gm-Message-State: AOJu0YxrcFrj9JsffrFsqfC0KePA9PJO25PL9Yj885H9zoPQXdTfWqNJ
 HhYs45XaTZG9xs54QrblGUb9J6INT4IGPg2EJ0MYvW64UT6ENgjqJNb898xcXnAepMsHEUfW9Wr
 oX9FdF4BI3uQ4ynwcuGE2/lsXUzlW5gKKkI92y6QW//e6CVgnE8AJlDsI
X-Gm-Gg: ASbGncuX2NoLw7CADpq4/87Lvia9npvRR04YhKRrJR8PyvBR44W2FcC5fjmgiW3Gu07
 HkmGgvA/WvuEhGrTUGOASIzI41pQLv80z2SO8PFPp13AUuygM4mz5NOMLWFpQ5R29ICGNamia9D
 XrF6QNYb6dyRcSByD4XO/96K4SH6ahSCBQKXLVnTEubGt1HOT63lcaTfVEBvK9K+FmkSHQAKMbW
 FkxMHR8fnp+cq0GRB7ggrk8fNx//77T8iJXxNwjIQzn/ejXf1GwA3hTxO1+LOVi4DJY69dnGtHS
 9MDbcsOMrEA0mvNDel82gg5nuw==
X-Received: by 2002:a17:90b:3b8c:b0:311:ab20:159a with SMTP id
 98e67ed59e1d1-31a9d6998d2mr2989899a91.29.1751529685239; 
 Thu, 03 Jul 2025 01:01:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7YrvPpxSRerufuTdtM81kkFIqTC7PaP8Syv8hoTMEtXLmmeLCDl5jK5e15E1SONhYOso8JQ==
X-Received: by 2002:a17:90b:3b8c:b0:311:ab20:159a with SMTP id
 98e67ed59e1d1-31a9d6998d2mr2989840a91.29.1751529684756; 
 Thu, 03 Jul 2025 01:01:24 -0700 (PDT)
Received: from [10.72.116.69] ([209.132.188.88])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb2e1b28sm156294035ad.33.2025.07.03.01.01.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 01:01:24 -0700 (PDT)
Message-ID: <bd2ae425-a144-4655-9b9e-f74fd3d82edd@redhat.com>
Date: Thu, 3 Jul 2025 16:01:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] hw/i386: Add the ramfb romfile compatibility
To: Eric Auger <eauger@redhat.com>, qemu-arm@nongnu.org,
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
 <f47d2860-ed26-47c7-9ec0-9fb77d7b7694@redhat.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <f47d2860-ed26-47c7-9ec0-9fb77d7b7694@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Eric,

Thanks for your review.

On 7/3/25 12:54 PM, Eric Auger wrote:
> Hi Shaoqin,
> 
> On 7/3/25 3:28 AM, Shaoqin Huang wrote:
>> Set the "use-legacy-x86-rom" property to false by default, and only set
>> it to true on x86 since only x86 will need it.
>>
>> At the same time, set the "use-legacy-x86-rom" property to true on those
>> historical versioned machine types in order to avoid the memory layout
>> being changed.
> 
> I would improve the commit message by adding Gerd's inputs:
> 
> "
> ramfb is a sysbus device so it can only used for machine types where it
> is explicitly enabled:
> 
>    # git grep machine_class_allow_dynamic_sysbus_dev.*TYPE_RAMFB_DEVICE
>    hw/arm/virt.c:    machine_class_allow_dynamic_sysbus_dev(mc,
> TYPE_RAMFB_DEVICE);
>    hw/i386/microvm.c:    machine_class_allow_dynamic_sysbus_dev(mc,
> TYPE_RAMFB_DEVICE);
>    hw/i386/pc_piix.c:    machine_class_allow_dynamic_sysbus_dev(m,
> TYPE_RAMFB_DEVICE);
>    hw/i386/pc_q35.c:    machine_class_allow_dynamic_sysbus_dev(m,
> TYPE_RAMFB_DEVICE);
>    hw/loongarch/virt.c:    machine_class_allow_dynamic_sysbus_dev(mc,
> TYPE_RAMFB_DEVICE);
>    hw/riscv/virt.c:    machine_class_allow_dynamic_sysbus_dev(mc,
> TYPE_RAMFB_DEVICE);
> 
> So these six are the only machine types we have to worry about.
> 
> The three x86 machine types (pc, q35, microvm) will actually use the rom
> (when booting with seabios).
> 
> For arm/riscv/loongarch virt we want to disable the rom.
> 
> "
> 
> This patch sets ramfb romfile option to false by default, except for x86
> machines types (pc, q35, microvm) which need the rom file when booting
> with seabios and machine types <= 10.0 (handling the case of arm virt,
> for compat reasons).
> 

Ok I will improve the commit message with those content.

>>
>> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> Besides I think it now does what it is supposed to. With the commit
> description improvement:
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks,
Shaoqin

> 
> Eric
>> ---
>>   hw/core/machine.c             |  2 ++
>>   hw/display/ramfb-standalone.c |  2 +-
>>   hw/i386/microvm.c             |  3 +++
>>   hw/i386/pc_piix.c             | 10 ++++++++++
>>   hw/i386/pc_q35.c              |  3 +++
>>   hw/vfio/pci.c                 |  2 +-
>>   6 files changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index e869821b22..a7043e2a34 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -39,6 +39,8 @@
>>   
>>   GlobalProperty hw_compat_10_0[] = {
>>       { "scsi-hd", "dpofua", "off" },
>> +    { "ramfb", "use-legacy-x86-rom", "true"},
>> +    { "vfio-pci", "use-legacy-x86-rom", "true" },
>>   };
>>   const size_t hw_compat_10_0_len = G_N_ELEMENTS(hw_compat_10_0);
>>   
>> diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
>> index 725aef9896..b20a7c57b3 100644
>> --- a/hw/display/ramfb-standalone.c
>> +++ b/hw/display/ramfb-standalone.c
>> @@ -63,7 +63,7 @@ static const VMStateDescription ramfb_dev_vmstate = {
>>   
>>   static const Property ramfb_properties[] = {
>>       DEFINE_PROP_BOOL("x-migrate", RAMFBStandaloneState, migrate,  true),
>> -    DEFINE_PROP_BOOL("use-legacy-x86-rom", RAMFBStandaloneState, use_legacy_x86_rom, true),
>> +    DEFINE_PROP_BOOL("use-legacy-x86-rom", RAMFBStandaloneState, use_legacy_x86_rom, false),
>>   };
>>   
>>   static void ramfb_class_initfn(ObjectClass *klass, const void *data)
>> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
>> index e0daf0d4fc..6666db9e4f 100644
>> --- a/hw/i386/microvm.c
>> +++ b/hw/i386/microvm.c
>> @@ -49,6 +49,7 @@
>>   #include "hw/acpi/generic_event_device.h"
>>   #include "hw/pci-host/gpex.h"
>>   #include "hw/usb/xhci.h"
>> +#include "hw/vfio/pci.h"
>>   
>>   #include "elf.h"
>>   #include "kvm/kvm_i386.h"
>> @@ -633,6 +634,8 @@ GlobalProperty microvm_properties[] = {
>>        * so reserving io space is not going to work.  Turn it off.
>>        */
>>       { "pcie-root-port", "io-reserve", "0" },
>> +    { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
>> +    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
>>   };
>>   
>>   static void microvm_class_init(ObjectClass *oc, const void *data)
>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> index ea7572e783..8ec8d8ae6d 100644
>> --- a/hw/i386/pc_piix.c
>> +++ b/hw/i386/pc_piix.c
>> @@ -49,6 +49,7 @@
>>   #include "hw/i2c/smbus_eeprom.h"
>>   #include "system/memory.h"
>>   #include "hw/acpi/acpi.h"
>> +#include "hw/vfio/pci.h"
>>   #include "qapi/error.h"
>>   #include "qemu/error-report.h"
>>   #include "system/xen.h"
>> @@ -77,6 +78,13 @@ static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
>>   static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
>>   #endif
>>   
>> +static GlobalProperty pc_piix_compat_defaults[] = {
>> +    { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
>> +    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
>> +};
>> +static const size_t pc_piix_compat_defaults_len =
>> +    G_N_ELEMENTS(pc_piix_compat_defaults);
>> +
>>   /*
>>    * Return the global irq number corresponding to a given device irq
>>    * pin. We could also use the bus number to have a more precise mapping.
>> @@ -482,6 +490,8 @@ static void pc_i440fx_machine_options(MachineClass *m)
>>                                      pc_set_south_bridge);
>>       object_class_property_set_description(oc, "x-south-bridge",
>>                                        "Use a different south bridge than PIIX3");
>> +    compat_props_add(m->compat_props,
>> +                     pc_piix_compat_defaults, pc_piix_compat_defaults_len);
>>   }
>>   
>>   static void pc_i440fx_machine_10_1_options(MachineClass *m)
>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>> index 33211b1876..0096eef6f4 100644
>> --- a/hw/i386/pc_q35.c
>> +++ b/hw/i386/pc_q35.c
>> @@ -45,6 +45,7 @@
>>   #include "hw/i386/pc.h"
>>   #include "hw/i386/amd_iommu.h"
>>   #include "hw/i386/intel_iommu.h"
>> +#include "hw/vfio/pci.h"
>>   #include "hw/virtio/virtio-iommu.h"
>>   #include "hw/display/ramfb.h"
>>   #include "hw/ide/pci.h"
>> @@ -67,6 +68,8 @@
>>   
>>   static GlobalProperty pc_q35_compat_defaults[] = {
>>       { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "39" },
>> +    { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
>> +    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
>>   };
>>   static const size_t pc_q35_compat_defaults_len =
>>       G_N_ELEMENTS(pc_q35_compat_defaults);
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index f4fa8a5610..604b337389 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3710,7 +3710,7 @@ static const TypeInfo vfio_pci_dev_info = {
>>   
>>   static const Property vfio_pci_dev_nohotplug_properties[] = {
>>       DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
>> -    DEFINE_PROP_BOOL("use-legacy-x86-rom", VFIOPCIDevice, use_legacy_x86_rom, true),
>> +    DEFINE_PROP_BOOL("use-legacy-x86-rom", VFIOPCIDevice, use_legacy_x86_rom, false),
>>       DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, ramfb_migrate,
>>                               ON_OFF_AUTO_AUTO),
>>   };
> 

-- 
Shaoqin


