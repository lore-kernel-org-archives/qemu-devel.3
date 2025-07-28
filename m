Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BB7C87FC9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 11:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugLvG-0000y6-KY; Mon, 28 Jul 2025 07:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugLb6-00033T-Pf
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 07:00:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugLb2-0000M7-Me
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 07:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753700442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3RO9ZuKlR9PSlnMCRal4aJr6ci+hSdLHP5xLcdcgCuY=;
 b=i+LR0nEZvelwpqNzJ68KKoXqNORyv+HrU8S1aSu6GAZvG2U+OQRa5lr4PPyDp2DwUGQbJ5
 8YFgnXE/9X3ccVmTwXBImv1aYqx4VP7xiWQAqSAT6pcIAxSsrdLbMWRbjp5Ub0RSjopBHY
 T24hb1FpK5mrYC+G2P5She8M9qCx8Zg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-lS_q5Zy3NGa_Sl8PeHGGlg-1; Mon, 28 Jul 2025 07:00:39 -0400
X-MC-Unique: lS_q5Zy3NGa_Sl8PeHGGlg-1
X-Mimecast-MFC-AGG-ID: lS_q5Zy3NGa_Sl8PeHGGlg_1753700439
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a6d1394b07so2519086f8f.3
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 04:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753700439; x=1754305239;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3RO9ZuKlR9PSlnMCRal4aJr6ci+hSdLHP5xLcdcgCuY=;
 b=AnOA7kBz8xREWlh2SqsIEQ7gUJccZkg+rmLw84haBFomWzAzP1wxTU1JddSe/uF1mZ
 WmoVNgk1acmrILOZMC/jSG8clcybSBPIx7IFMvz5gGhXq0zwI78lddQvDM/jxfQAbIXy
 x/Z0rRGmv5hemR7Q9dGHb0e/6e7q/fVOnm8bgJT2QcSJ18sdkfTVEBeAUjU5Aj3gvG6R
 h7ZKlF3OS3RpKGfWYyCqaRcgesf31BxAjUsPB+99wQjWc+w7yMdJjL9h3frlYl+uaZ+E
 yEkILeVlRK9TBrp44hW+ZxMNqbQQ6snIv6D2sxAPVfK/lbGk18yINf4rOAI80x/2tdUa
 lfPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX70M4mInwWDJikqYaDNZozOnUqCA4LUnjlNsfT6e3qycFb4xPiWLZ8yBjobNsYPPK5fhgT10x2YLYw@nongnu.org
X-Gm-Message-State: AOJu0Yw2amECjHMYq1Yq9PGa5AKrk2n7cADq5b/W4E8BqwrBygrI0CIa
 olkRskcmEINVEKyofu3bz66aAKNOFAtAktNV5gqSd/FEmWKu6/+gTXdzQ92+SkQCGLZ1RJMSB7n
 MyOHrWRw7ZRxj0UYM5ENY6HD6pPKLK8WhgL6INDBTr9zFVeUcttcsOpDZ
X-Gm-Gg: ASbGncvW2tIoIB6dbNRh12AQYxSFn2zuhLPuM8ADHYL8mP91UYyEU9fpmXN87eNHjHC
 rJJXuOTxMw3vDAHpVjS137jENAWsZy1Ek6lJx999NROPkFdWxVf0F3f4GB4XyKMlSmTp3GImMUf
 DcM7Cki7jLSwX/68SyqikbCi7f/i+i8smM0bNmbhIQHxfDqBuYuaXukAeBrn6bIAU82teYb8XN3
 fSg9gBN5a+/ztlcdyKZnJymWapY+eWHe63E2zk0+bLl/gODGyibGdLY+UbLNvMTk5zJcrHH9Zdm
 T9QeYwynucUVkTJYNueP776uTPpoAGyTFA23fZTw6wRis1YrKwTSiTrry8AiqQ7mc134Byptv1L
 5Tw==
X-Received: by 2002:a05:6000:248a:b0:3b7:8737:7f1d with SMTP id
 ffacd0b85a97d-3b787378026mr2659205f8f.46.1753700438455; 
 Mon, 28 Jul 2025 04:00:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQrmMSiX/NrdXaB2+of9aA0SsTlsEPrQwgYK3iQPmrx/UsjAMuRSkMvDnimmbklSHIg3DEsw==
X-Received: by 2002:a05:6000:248a:b0:3b7:8737:7f1d with SMTP id
 ffacd0b85a97d-3b787378026mr2659176f8f.46.1753700437915; 
 Mon, 28 Jul 2025 04:00:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b778f04009sm8613403f8f.38.2025.07.28.04.00.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 04:00:37 -0700 (PDT)
Message-ID: <41ca6fb6-98ae-4d87-9964-f028b2b3f6b0@redhat.com>
Date: Mon, 28 Jul 2025 13:00:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 3/3] hw/i386: Add the ramfb romfile compatibility
To: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org, Shaoqin Huang <shahuang@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu
 <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eric Auger <eric.auger@redhat.com>
References: <20250718194349.65771-1-kraxel@redhat.com>
 <20250718194349.65771-4-kraxel@redhat.com>
 <b10a9b6b-927e-4c25-aebb-9317fe43b9ad@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <b10a9b6b-927e-4c25-aebb-9317fe43b9ad@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/28/25 12:51, Thomas Huth wrote:
> On 18/07/2025 21.43, Gerd Hoffmann wrote:
>> From: Shaoqin Huang <shahuang@redhat.com>
>>
>> ramfb is a sysbus device so it can only used for machine types where it
>> is explicitly enabled:
>>
>>    # git grep machine_class_allow_dynamic_sysbus_dev.*TYPE_RAMFB_DEVICE
>>    hw/arm/virt.c:    machine_class_allow_dynamic_sysbus_dev(mc,
>>           TYPE_RAMFB_DEVICE);
>>    hw/i386/microvm.c:    machine_class_allow_dynamic_sysbus_dev(mc,
>>           TYPE_RAMFB_DEVICE);
>>    hw/i386/pc_piix.c:    machine_class_allow_dynamic_sysbus_dev(m,
>>           TYPE_RAMFB_DEVICE);
>>    hw/i386/pc_q35.c:    machine_class_allow_dynamic_sysbus_dev(m,
>>           TYPE_RAMFB_DEVICE);
>>    hw/loongarch/virt.c:    machine_class_allow_dynamic_sysbus_dev(mc,
>>           TYPE_RAMFB_DEVICE);
>>    hw/riscv/virt.c:    machine_class_allow_dynamic_sysbus_dev(mc,
>>           TYPE_RAMFB_DEVICE);
>>
>> So these six are the only machine types we have to worry about.
>>
>> The three x86 machine types (pc, q35, microvm) will actually use the rom
>> (when booting with seabios).
>>
>> For arm/riscv/loongarch virt we want to disable the rom.
>>
>> This patch sets ramfb romfile option to false by default, except for x86
>> machines types (pc, q35, microvm) which need the rom file when booting
>> with seabios and machine types <= 10.0 (handling the case of arm virt,
>> for compat reasons).
>>
>> At the same time, set the "use-legacy-x86-rom" property to true on those
>> historical versioned machine types in order to avoid the memory layout
>> being changed.
>>
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
>> Message-ID: <20250717100941.2230408-4-shahuang@redhat.com>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>   hw/core/machine.c             |  2 ++
>>   hw/display/ramfb-standalone.c |  2 +-
>>   hw/i386/microvm.c             |  3 +++
>>   hw/i386/pc_piix.c             | 10 ++++++++++
>>   hw/i386/pc_q35.c              |  3 +++
>>   hw/vfio/pci.c                 |  2 +-
>>   6 files changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index e869821b2246..a7043e2a3425 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -39,6 +39,8 @@
>>   GlobalProperty hw_compat_10_0[] = {
>>       { "scsi-hd", "dpofua", "off" },
>> +    { "ramfb", "use-legacy-x86-rom", "true"},
>> +    { "vfio-pci", "use-legacy-x86-rom", "true" },
>>   };
>>   const size_t hw_compat_10_0_len = G_N_ELEMENTS(hw_compat_10_0);
>> diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
>> index 82d8c69f8903..72b2071aed01 100644
>> --- a/hw/display/ramfb-standalone.c
>> +++ b/hw/display/ramfb-standalone.c
>> @@ -64,7 +64,7 @@ static const VMStateDescription ramfb_dev_vmstate = {
>>   static const Property ramfb_properties[] = {
>>       DEFINE_PROP_BOOL("x-migrate", RAMFBStandaloneState, migrate,  true),
>>       DEFINE_PROP_BOOL("use-legacy-x86-rom", RAMFBStandaloneState,
>> -                     use_legacy_x86_rom, true),
>> +                     use_legacy_x86_rom, false),
>>   };
>>   static void ramfb_class_initfn(ObjectClass *klass, const void *data)
>> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
>> index e0daf0d4fc30..d90b69a16200 100644
>> --- a/hw/i386/microvm.c
>> +++ b/hw/i386/microvm.c
>> @@ -49,6 +49,7 @@
>>   #include "hw/acpi/generic_event_device.h"
>>   #include "hw/pci-host/gpex.h"
>>   #include "hw/usb/xhci.h"
>> +#include "hw/vfio/types.h"
>>   #include "elf.h"
>>   #include "kvm/kvm_i386.h"
>> @@ -633,6 +634,8 @@ GlobalProperty microvm_properties[] = {
>>        * so reserving io space is not going to work.  Turn it off.
>>        */
>>       { "pcie-root-port", "io-reserve", "0" },
>> +    { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
>> +    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
>>   };
>>   static void microvm_class_init(ObjectClass *oc, const void *data)
>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> index a3285fbc6450..ad5caff3a5d2 100644
>> --- a/hw/i386/pc_piix.c
>> +++ b/hw/i386/pc_piix.c
>> @@ -49,6 +49,7 @@
>>   #include "hw/i2c/smbus_eeprom.h"
>>   #include "system/memory.h"
>>   #include "hw/acpi/acpi.h"
>> +#include "hw/vfio/types.h"
>>   #include "qapi/error.h"
>>   #include "qemu/error-report.h"
>>   #include "system/xen.h"
>> @@ -77,6 +78,13 @@ static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
>>   static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
>>   #endif
>> +static GlobalProperty pc_piix_compat_defaults[] = {
>> +    { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
>> +    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
>> +};
>> +static const size_t pc_piix_compat_defaults_len =
>> +    G_N_ELEMENTS(pc_piix_compat_defaults);
>> +
>>   /*
>>    * Return the global irq number corresponding to a given device irq
>>    * pin. We could also use the bus number to have a more precise mapping.
>> @@ -492,6 +500,8 @@ static void pc_i440fx_machine_options(MachineClass *m)
>>                                      pc_set_south_bridge);
>>       object_class_property_set_description(oc, "x-south-bridge",
>>                                        "Use a different south bridge than PIIX3");
>> +    compat_props_add(m->compat_props,
>> +                     pc_piix_compat_defaults, pc_piix_compat_defaults_len);
>>   }
>>   static void pc_i440fx_machine_10_1_options(MachineClass *m)
>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>> index cf871cfdad86..9b9519fa02d5 100644
>> --- a/hw/i386/pc_q35.c
>> +++ b/hw/i386/pc_q35.c
>> @@ -45,6 +45,7 @@
>>   #include "hw/i386/pc.h"
>>   #include "hw/i386/amd_iommu.h"
>>   #include "hw/i386/intel_iommu.h"
>> +#include "hw/vfio/types.h"
>>   #include "hw/virtio/virtio-iommu.h"
>>   #include "hw/display/ramfb.h"
>>   #include "hw/ide/pci.h"
>> @@ -67,6 +68,8 @@
>>   static GlobalProperty pc_q35_compat_defaults[] = {
>>       { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "39" },
>> +    { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
>> +    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
>>   };
>>   static const size_t pc_q35_compat_defaults_len =
>>       G_N_ELEMENTS(pc_q35_compat_defaults);
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 0b969b3359db..174499ecec65 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3810,7 +3810,7 @@ static const TypeInfo vfio_pci_dev_info = {
>>   static const Property vfio_pci_dev_nohotplug_properties[] = {
>>       DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
>>       DEFINE_PROP_BOOL("use-legacy-x86-rom", VFIOPCIDevice,
>> -                     use_legacy_x86_rom, true),
>> +                     use_legacy_x86_rom, false),
>>       DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, ramfb_migrate,
>>                               ON_OFF_AUTO_AUTO),
>>   };
> 
>   Hi guys,
> 
> there is something fishy going on now:
> 
> $ ./qemu-system-x86_64 -M q35 -device vfio-pci
> Unexpected error in object_property_find_err() at ../../home/thuth/devel/qemu/qom/object.c:1345:
> qemu-system-x86_64: -device vfio-pci: can't apply global vfio-pci.use-legacy-x86-rom=true: Property 'vfio-pci.use-legacy-x86-rom' not found
> Aborted (core dumped)
> 
> Could you please have a look?

Fix here :

  https://lore.kernel.org/qemu-devel/20250723062714.1245826-1-clg@redhat.com/

I am planning to send it with the next vfio PR. People are on vacations
last week and I still need a few Acks.

Thanks,

C.




