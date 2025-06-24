Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BDCC77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 15:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU5vV-0002He-Ia; Tue, 24 Jun 2025 11:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uU5vT-0002HK-Nh
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 11:51:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uU5vS-0001M1-1k
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 11:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750780265;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4d6CwVf6CCbFw8g0kZm+MXmPsBgqxA+jVU2RZpVtP6o=;
 b=BUJ2lqMykHnKbNGGXD1HTGd83pOC8hmO7mM772GamIld1Tz+/ggHQKHl/zsSKfDSRC20hv
 MtKVJWqMIeIgLYCtNKp751yT+KD3jlPavZIordsSrUVCv4TpneG9eFKiElbkFmYpV1ATnf
 IiTPln0PRUOEAVGFA7qmbdbDBLGX3eU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-6U1jEuD0MnyswuvbIdox8w-1; Tue, 24 Jun 2025 11:51:04 -0400
X-MC-Unique: 6U1jEuD0MnyswuvbIdox8w-1
X-Mimecast-MFC-AGG-ID: 6U1jEuD0MnyswuvbIdox8w_1750780263
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-453018b4ddeso4757605e9.3
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 08:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750780263; x=1751385063;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4d6CwVf6CCbFw8g0kZm+MXmPsBgqxA+jVU2RZpVtP6o=;
 b=iLw+Z1ZHzp6uZyc0iFbAJufEkpmpM/6FxuZ91qvm2IJNxlEcg+2qhjoRX9lloq/u7M
 o7/0aFW3GyyZsmjZek7oh446jiNuBIuGAYLU9p+yuS5qjIcePMYgKp7XzFNTUCxs5Bdn
 M+B0tmdCcCWRyUssqhBv5H2C+6+nKBhj3T7N/2cjOvbZkZqCkO6jNm4yahcq8IEDh1n1
 DF5LLE9Rp0cBrNwlNecQKQHjM+kOb530FbTVsXN6rXowqjqNOZcb796XvU1dptdmspXK
 vndaobWQGGPHIUsyQA2Xbu8I8kgsgRoyMzfTclIlb7z7FbufZcKv2oZJGEme6yYye49z
 SC9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxOhzPL1JH8eYEwo0zEjVpAuLZsIUX1ogbNze9ERvx8GzqB/qoXTSiWYWweeCYcpouM+sjgkayBZfP@nongnu.org
X-Gm-Message-State: AOJu0YzZ+7Osey3AgKJ06YjXCKm4RM60Ki5HJIdCoizS0+L12z3z6+Si
 g1joSF/VP6FiGexwtDk5+/om+DF6gL3/s07Yu0FmnXa9NwMpdC/h5FSLCeCzbkdodNrS3e1Zq2O
 DNVHD2ry5o7Q8uHIR3VoJ/5Xu4oD8MiqJLPvtv5kse3EkBeNDpAVZRIMc
X-Gm-Gg: ASbGncucUgL8H02obFJkAnphA6/6ArHq+3XHzOcijESAL8MgwwunFrwj+4DfYciCS3E
 AhYwQg3LajklXW6fZWVbmlWhqx7X1519qmQMpTruLTAF2n+RJ+ynQfsNhBUVqnpjEbMpJyM//HM
 of81ifusg0VOTkWlvJOQek6cKueU/qWfIBragi/ILXPvmso8ffbZt91kqKnpFEJ1S830lMAmD83
 +GDhu/gJjOIhU6yuRB3AIpjZQqx5Shbb1/TaWtllXwhMQ5nPAYdfx6eXvkuZZOHjH3eyghz/GuO
 TVM/awwqg7qHyp+ns5YLyuIyXuOsO1RtGxgrJypUz/GQmIQUGm48r1y8LgRcW73MVeRW/g==
X-Received: by 2002:a05:600c:3590:b0:44b:eb56:1d48 with SMTP id
 5b1f17b1804b1-45381536414mr627005e9.4.1750780262911; 
 Tue, 24 Jun 2025 08:51:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgdC9rTaZ4rf5rqF9I0NCo5RvgdT2diWkqeVRQinScjEb+HD6I0QDdDVK64jYjL39hfS2Mpw==
X-Received: by 2002:a05:600c:3590:b0:44b:eb56:1d48 with SMTP id
 5b1f17b1804b1-45381536414mr626615e9.4.1750780262415; 
 Tue, 24 Jun 2025 08:51:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535ead2339sm183308495e9.28.2025.06.24.08.51.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 08:51:01 -0700 (PDT)
Message-ID: <4545479f-749a-45e5-9743-13f7358c2a25@redhat.com>
Date: Tue, 24 Jun 2025 17:51:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/29] hw/arm/virt-acpi-build: Modify the DSDT ACPI
 table to enable ACPI PCI hotplug
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 philmd@linaro.org, alex.bennee@linaro.org
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-18-eric.auger@redhat.com>
 <20250620103538.000021c1@huawei.com> <20250620143822.7ab69038@fedora>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250620143822.7ab69038@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 6/20/25 2:38 PM, Igor Mammedov wrote:
> On Fri, 20 Jun 2025 10:35:38 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
>
>> On Mon, 16 Jun 2025 11:46:46 +0200
>> Eric Auger <eric.auger@redhat.com> wrote:
>>
>>> Modify the DSDT ACPI table to enable ACPI PCI hotplug.
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>
>>> ---
>>> v2 -> v3:
>>> - use ACPI_PCIHP_SIZE instead of 0x1000 (Igor)
>>> - use cihp_state->use_acpi_hotplug_bridge  
>> pcihp_state
>>
>> Takes a bit of searching to find the various bits of the
>> same support on x86 but this seems to match up.
>> Exactly when things are built does vary but not I think
>> in a way that matters.  e.g. I think on x86 the
>> EDSM stuff is built whether or not we have pcihp enabled
>> whereas here you've made it conditional on using acpi
>> hp.  Perhaps a tiny bit more description on that would be
>> useful if you do a v4?
> edsm should be built regardless of pcihp
> (well intention was there, whether I messed it up or not I don't know)
>
> idea is that non hotplug ports can have a static acpi-index,
> so it doesn't depend on pcihp.

OK I can make it unconditional. The drawback is that it will oblige to
rebuild reference blobs again with native pci hotplug.

Eric
>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>>
>>
>>> ---
>>>  include/hw/acpi/pcihp.h  |  2 ++
>>>  include/hw/arm/virt.h    |  1 +
>>>  hw/arm/virt-acpi-build.c | 22 ++++++++++++++++++++++
>>>  hw/arm/virt.c            |  2 ++
>>>  hw/arm/Kconfig           |  2 ++
>>>  5 files changed, 29 insertions(+)
>>>
>>> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
>>> index 5506a58862..9ff548650b 100644
>>> --- a/include/hw/acpi/pcihp.h
>>> +++ b/include/hw/acpi/pcihp.h
>>> @@ -38,6 +38,8 @@
>>>  #define ACPI_PCIHP_SEJ_BASE 0x8
>>>  #define ACPI_PCIHP_BNMR_BASE 0x10
>>>  
>>> +#define ACPI_PCIHP_SIZE 0x0018
>>> +
>>>  typedef struct AcpiPciHpPciStatus {
>>>      uint32_t up;
>>>      uint32_t down;
>>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
>>> index 9a1b0f53d2..0ed2e6b732 100644
>>> --- a/include/hw/arm/virt.h
>>> +++ b/include/hw/arm/virt.h
>>> @@ -79,6 +79,7 @@ enum {
>>>      VIRT_ACPI_GED,
>>>      VIRT_NVDIMM_ACPI,
>>>      VIRT_PVTIME,
>>> +    VIRT_ACPI_PCIHP,
>>>      VIRT_LOWMEMMAP_LAST,
>>>  };
>>>  
>>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>>> index d7547c8d3b..a2e58288f8 100644
>>> --- a/hw/arm/virt-acpi-build.c
>>> +++ b/hw/arm/virt-acpi-build.c
>>> @@ -34,6 +34,7 @@
>>>  #include "hw/core/cpu.h"
>>>  #include "hw/acpi/acpi-defs.h"
>>>  #include "hw/acpi/acpi.h"
>>> +#include "hw/acpi/pcihp.h"
>>>  #include "hw/nvram/fw_cfg_acpi.h"
>>>  #include "hw/acpi/bios-linker-loader.h"
>>>  #include "hw/acpi/aml-build.h"
>>> @@ -809,6 +810,8 @@ static void
>>>  build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>>  {
>>>      VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>>> +    AcpiGedState *acpi_ged_state = ACPI_GED(vms->acpi_dev);
>>> +    AcpiPciHpState *pcihp_state = &acpi_ged_state->pcihp_state;
>>>      Aml *scope, *dsdt;
>>>      MachineState *ms = MACHINE(vms);
>>>      const MemMapEntry *memmap = vms->memmap;
>>> @@ -868,6 +871,25 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>>  
>>>      aml_append(dsdt, scope);
>>>  
>>> +    if (pcihp_state->use_acpi_hotplug_bridge) {
>>> +        Aml *pci0_scope = aml_scope("\\_SB.PCI0");
>>> +
>>> +        aml_append(pci0_scope, aml_pci_edsm());
>>> +        build_acpi_pci_hotplug(dsdt, AML_SYSTEM_MEMORY,
>>> +                               memmap[VIRT_ACPI_PCIHP].base);
>>> +        build_append_pcihp_resources(pci0_scope,
>>> +                                     memmap[VIRT_ACPI_PCIHP].base,
>>> +                                     memmap[VIRT_ACPI_PCIHP].size);
>>> +
>>> +        /* Scan all PCI buses. Generate tables to support hotplug. */
>>> +        build_append_pci_bus_devices(pci0_scope, vms->bus);
>>> +        if (object_property_find(OBJECT(vms->bus), ACPI_PCIHP_PROP_BSEL)) {
>>> +            build_append_pcihp_slots(pci0_scope, vms->bus);
>>> +        }
>>> +        build_append_notification_callback(pci0_scope, vms->bus);
>>> +        aml_append(dsdt, pci0_scope);
>>> +    }
>>> +
>>>      /* copy AML table into ACPI tables blob */
>>>      g_array_append_vals(table_data, dsdt->buf->data, dsdt->buf->len);
>>>    


