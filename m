Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D6DC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 15:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uURyJ-0000Ui-1j; Wed, 25 Jun 2025 11:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uURyB-0000Ta-Qf
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 11:23:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uURy9-0006t9-37
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 11:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750865003;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sgqpt6+LkQyqIfK65io/n4s5hgmJ2bFQ+Ds8DGQQ5HM=;
 b=SuXxt7yyG3viJ8V8INfqCVmYCXB345Czv8uywr0frC6/k+7Xor3Xik+Px9qJI7rt0nzIYT
 ViglTkl9aa79mVxu+ad4fJlHcemtAv4cqpNi5pGu943UUVxijKKss4+eLkgG2PEL/Avf5F
 o46gzo3mq+DLgPw72vDzGCGmERUKRK0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-dIBDYqwTO4iw8sJ-_rJI-Q-1; Wed, 25 Jun 2025 11:23:19 -0400
X-MC-Unique: dIBDYqwTO4iw8sJ-_rJI-Q-1
X-Mimecast-MFC-AGG-ID: dIBDYqwTO4iw8sJ-_rJI-Q_1750864999
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4ff581df3so16039f8f.1
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 08:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750864998; x=1751469798;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sgqpt6+LkQyqIfK65io/n4s5hgmJ2bFQ+Ds8DGQQ5HM=;
 b=ZkBrtqbSIC2OEQx35rVpf61SWxI1u68huYUvXoQNQFiqTx6G4/qqbQa6GOQaIqRYph
 sSsgk6XDaoArIMU2EamAUSdMctIwP9d4FUBlPiG2wN4f+nkQG9GtIc54FoZ2QNjwI/DO
 LU7MEmS7Pa1j7B7jFwrJmyPeMAG/+z/oDLen0mW+bOhEPkCjDGEx3Vx/TEI6X6xpACtt
 /X+7iji1vHCxqv6ENjZ7NQCDHjWsZ38Pm9zcSMrmc28LFrLxsnUCVtjsVoBrFfOTe2DV
 3+Y460Opvt2DaxfLCOUOIqhoHNZAFoorldHRLtJTxd4Gej9C9B1nEwyQCTf3ojIQAqh8
 UgbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCvbEFkW3wGKBZ0aiU2lYCvS1cOvfftkfg2AY14v8PzafBWDO00CSJfFESv6aMmhij6OL4tU5jvW9H@nongnu.org
X-Gm-Message-State: AOJu0YyxVRrwe5Dhq3drE9Kn1/OUw+8LbQYQA4id6ZBXZTHF/3UK1B3E
 kMundkyOR2L6k0491jA2sNqGEQbeoTL2zigIDTHH1nG6LrksHAFtlyzodrZ/10wc8BLqUjqD/72
 ajO1Q3eYUbHKt3Wh6V6RfZgYUsPGxDIQ+uy8MPWli89gN5Yw0B1w+W8Jv
X-Gm-Gg: ASbGncvNeubWe3lwXApWPvJhLNWJ64Y8b6qAcZviVn/ZU1oyRLZnhCTFzSuP5cIn8EN
 pq4UfyYgnNrg8kVEQ+crTJf9ZTuehXDt9A2ULFnhU17uk8kjf8ScTdrEAD2rEc4iFsY/ZGH4LpX
 ZWlVsxpk50X6mZf3nxWlORsrgT8Tm5xA40BemUkjK/J7x0RozQjqTfdx/DLP9fB4wmVTrAl+HvV
 MdVXvBobuMjLyaVtOb+K1t2XpFOKA07gZ6xOFc1AGhClX4+IHuliKSFbZG3ERa+Jf8d6/eSiBzk
 2MDk7CUsNtJ9lto5uvvyCbKaDGgdJhKMs/xIkG2iIWHpOYYKzI7DQ8YP8VOm1gIAw6MQhA==
X-Received: by 2002:a05:6000:2409:b0:3a6:daff:9e5 with SMTP id
 ffacd0b85a97d-3a6e71c5b54mr6453895f8f.7.1750864998389; 
 Wed, 25 Jun 2025 08:23:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFudJUWisH4I6Rr4is72hWB5dIi8bRjcn0xmDxtw/zvGFlgiuKmAO1Jz2lEYIDJjgxSGfL9Lw==
X-Received: by 2002:a05:6000:2409:b0:3a6:daff:9e5 with SMTP id
 ffacd0b85a97d-3a6e71c5b54mr6453857f8f.7.1750864997815; 
 Wed, 25 Jun 2025 08:23:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45382363f7fsm23617965e9.27.2025.06.25.08.23.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 08:23:17 -0700 (PDT)
Message-ID: <13edf868-707a-4caa-9b83-8b7ac103ff0a@redhat.com>
Date: Wed, 25 Jun 2025 17:23:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/29] hw/arm/virt-acpi-build: Modify the DSDT ACPI
 table to enable ACPI PCI hotplug
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 philmd@linaro.org, alex.bennee@linaro.org
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-18-eric.auger@redhat.com>
 <20250620103538.000021c1@huawei.com> <20250620143822.7ab69038@fedora>
 <20250620171351.00004cb0@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250620171351.00004cb0@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Igor, Jonathan,

On 6/20/25 6:13 PM, Jonathan Cameron wrote:
> On Fri, 20 Jun 2025 14:38:22 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
>
>> On Fri, 20 Jun 2025 10:35:38 +0100
>> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
>>
>>> On Mon, 16 Jun 2025 11:46:46 +0200
>>> Eric Auger <eric.auger@redhat.com> wrote:
>>>   
>>>> Modify the DSDT ACPI table to enable ACPI PCI hotplug.
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>
>>>> ---
>>>> v2 -> v3:
>>>> - use ACPI_PCIHP_SIZE instead of 0x1000 (Igor)
>>>> - use cihp_state->use_acpi_hotplug_bridge    
>>> pcihp_state
>>>
>>> Takes a bit of searching to find the various bits of the
>>> same support on x86 but this seems to match up.
>>> Exactly when things are built does vary but not I think
>>> in a way that matters.  e.g. I think on x86 the
>>> EDSM stuff is built whether or not we have pcihp enabled
>>> whereas here you've made it conditional on using acpi
>>> hp.  Perhaps a tiny bit more description on that would be
>>> useful if you do a v4?  
>> edsm should be built regardless of pcihp
>> (well intention was there, whether I messed it up or not I don't know)
>>
>> idea is that non hotplug ports can have a static acpi-index,
>> so it doesn't depend on pcihp.
> That makes sense - so here should that edsm feature be enabled whether
> or not we have pcihp_state->use_acpi_hotplug_bridge == true
>
> i.e. is it really a separate thing from the rest of this series?

Further studying this comment,

EDSM is invoked by code generated in aml_pci_static_endpoint_dsm() whcih
itself is invoked by build_append_pci_bus_devices()

So to me it means that if we generate edsm unconditionally we also need
to call the following block unconditionnally

+    aml_append(pci0_scope, build_pci_bridge_edsm());
+    build_append_pci_bus_devices(pci0_scope, vms->bus);
+    if (object_property_find(OBJECT(vms->bus), ACPI_PCIHP_PROP_BSEL)) {
+        build_append_pcihp_slots(pci0_scope, vms->bus);
+    }

which seems to be done that way in hw/i386/acpi-build.c/build_dsdt()

Igor, if I recall correctly you said that addition changes related to
"S%.02X" could change the guest ABI. And in that case this wouldn't be
guarded by any new option/compat. So that's annoying.

By the way I tested static acpi-index on ARM with resulting code and it
does not not seem to work - maybe I try with a wrong topology though
(pcie root port + virtio-net acpi-index)-. I have not checked on x86 yet.

So I wonder if it makes sense to do that refinement now. Maybe we can
check try to improve that afterwards?

What do you think?

Eric



>
> Thanks,
>
> J
>>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>>>
>>>   
>>>> ---
>>>>  include/hw/acpi/pcihp.h  |  2 ++
>>>>  include/hw/arm/virt.h    |  1 +
>>>>  hw/arm/virt-acpi-build.c | 22 ++++++++++++++++++++++
>>>>  hw/arm/virt.c            |  2 ++
>>>>  hw/arm/Kconfig           |  2 ++
>>>>  5 files changed, 29 insertions(+)
>>>>
>>>> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
>>>> index 5506a58862..9ff548650b 100644
>>>> --- a/include/hw/acpi/pcihp.h
>>>> +++ b/include/hw/acpi/pcihp.h
>>>> @@ -38,6 +38,8 @@
>>>>  #define ACPI_PCIHP_SEJ_BASE 0x8
>>>>  #define ACPI_PCIHP_BNMR_BASE 0x10
>>>>  
>>>> +#define ACPI_PCIHP_SIZE 0x0018
>>>> +
>>>>  typedef struct AcpiPciHpPciStatus {
>>>>      uint32_t up;
>>>>      uint32_t down;
>>>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
>>>> index 9a1b0f53d2..0ed2e6b732 100644
>>>> --- a/include/hw/arm/virt.h
>>>> +++ b/include/hw/arm/virt.h
>>>> @@ -79,6 +79,7 @@ enum {
>>>>      VIRT_ACPI_GED,
>>>>      VIRT_NVDIMM_ACPI,
>>>>      VIRT_PVTIME,
>>>> +    VIRT_ACPI_PCIHP,
>>>>      VIRT_LOWMEMMAP_LAST,
>>>>  };
>>>>  
>>>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>>>> index d7547c8d3b..a2e58288f8 100644
>>>> --- a/hw/arm/virt-acpi-build.c
>>>> +++ b/hw/arm/virt-acpi-build.c
>>>> @@ -34,6 +34,7 @@
>>>>  #include "hw/core/cpu.h"
>>>>  #include "hw/acpi/acpi-defs.h"
>>>>  #include "hw/acpi/acpi.h"
>>>> +#include "hw/acpi/pcihp.h"
>>>>  #include "hw/nvram/fw_cfg_acpi.h"
>>>>  #include "hw/acpi/bios-linker-loader.h"
>>>>  #include "hw/acpi/aml-build.h"
>>>> @@ -809,6 +810,8 @@ static void
>>>>  build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>>>  {
>>>>      VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>>>> +    AcpiGedState *acpi_ged_state = ACPI_GED(vms->acpi_dev);
>>>> +    AcpiPciHpState *pcihp_state = &acpi_ged_state->pcihp_state;
>>>>      Aml *scope, *dsdt;
>>>>      MachineState *ms = MACHINE(vms);
>>>>      const MemMapEntry *memmap = vms->memmap;
>>>> @@ -868,6 +871,25 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>>>  
>>>>      aml_append(dsdt, scope);
>>>>  
>>>> +    if (pcihp_state->use_acpi_hotplug_bridge) {
>>>> +        Aml *pci0_scope = aml_scope("\\_SB.PCI0");
>>>> +
>>>> +        aml_append(pci0_scope, aml_pci_edsm());
>>>> +        build_acpi_pci_hotplug(dsdt, AML_SYSTEM_MEMORY,
>>>> +                               memmap[VIRT_ACPI_PCIHP].base);
>>>> +        build_append_pcihp_resources(pci0_scope,
>>>> +                                     memmap[VIRT_ACPI_PCIHP].base,
>>>> +                                     memmap[VIRT_ACPI_PCIHP].size);
>>>> +
>>>> +        /* Scan all PCI buses. Generate tables to support hotplug. */
>>>> +        build_append_pci_bus_devices(pci0_scope, vms->bus);
>>>> +        if (object_property_find(OBJECT(vms->bus), ACPI_PCIHP_PROP_BSEL)) {
>>>> +            build_append_pcihp_slots(pci0_scope, vms->bus);
>>>> +        }
>>>> +        build_append_notification_callback(pci0_scope, vms->bus);
>>>> +        aml_append(dsdt, pci0_scope);
>>>> +    }
>>>> +
>>>>      /* copy AML table into ACPI tables blob */
>>>>      g_array_append_vals(table_data, dsdt->buf->data, dsdt->buf->len);
>>>>      
>>>   
>>


