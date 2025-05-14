Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9407DC3ABDD
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 16:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFFGB-0003ev-QG; Wed, 14 May 2025 12:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uFFFl-0002jQ-TQ
 for qemu-devel@nongnu.org; Wed, 14 May 2025 12:46:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uFFFj-0004ne-4W
 for qemu-devel@nongnu.org; Wed, 14 May 2025 12:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747241200;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8893/NzsFk9tQOeGxihb/t7h/4NJ94lUWPU/ys1E+Tw=;
 b=GUpPd3/8KCib7O8BPDRKqBD6n6u+iqALiu19LqQYtJuHBu6a+ZycWxGI/lsNWjAQZRfd1n
 73zyKvi1lCRl0Apuret65IxVunHJ6H+uQrE0kmGJH1Co25eqbF2AA2fFV0YINDhOvw5oAJ
 8hta0Md0jfUxqpFh3wlC99rM2dpc4Is=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-jgg4T4tmOiOfTzNVwchZIg-1; Wed, 14 May 2025 12:46:38 -0400
X-MC-Unique: jgg4T4tmOiOfTzNVwchZIg-1
X-Mimecast-MFC-AGG-ID: jgg4T4tmOiOfTzNVwchZIg_1747241197
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d0830c3f7so164865e9.2
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 09:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747241197; x=1747845997;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8893/NzsFk9tQOeGxihb/t7h/4NJ94lUWPU/ys1E+Tw=;
 b=CLCMSvPUeqqnBAhaO/bynk18kQsmf/MHOJy2hUB6BnHN6IXcVFQOSdgkUwwmb3YmTT
 0P3OcHRZeyUXMfZvmB2M396yvbr56NH8naLYJQ8mFczc0eCnZ58MEj8iwMuijgV0XaW9
 ZvH148VRO4/SkivLBbFzSh1CXBILivMShItf+XzgVCyhYfmpI1/UaHzy1GdXzIjPIzv8
 5Tt3gIXKk7VO6d90mZVTu0psRGqXeIN/UPl1QamORVYvqQgK377s6E8PK/EQXA0Yb2Gy
 NJVcItK3kPk4h+UIP/0r79k4inE+isGjcpCRy1nzeTcu9FlJmtY1Kg0fWHMVPBqSyAhp
 Bu0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKznRNr6cpopA/XZTKqW1uKKBKASAeJ3YQHjU3MdCuCtSHqpOM466SDWl2yX453zrxJo9LGRQOHFos@nongnu.org
X-Gm-Message-State: AOJu0YwixF6cDr5P14Dof8VUJD9dgTSanBl2zdnE2uZDb9N8C4lrk1SU
 JsZiVjkJeDtnz8eCzkkCkqeZcbO4KYHnMKKom26+VsEGWdHV7uQ5MCJQAKgpE9NAKjfiID9sO+d
 TtiutlFwV8GvygZzC1nwiIJwYycDbMQo+R4XYmnDK5GT0UJuSgvx5
X-Gm-Gg: ASbGncsRQERqHXsFjG9d5y0rsVIDPE9jPCtNugbY4g484QnrMPv/XYAa3xG+itVbK9z
 Ym3gvmC4HHrb8MbTMOSiY2ykYJdxLg+RjmWyXeMfqlrlaIZD3nM2i007NAJ9Ez11hFkPQsQoWwi
 2n4TPAgLSx1FTqwJQEsJxKYamJF04CDqiat8uI5B0D6lNwH426WIC+/tsgazZtu9NTz3vlFzMGj
 5yVyTJXOoJWmke2qgKZqFBWle94ze0+mbBCXGH6o6gXS3jsTioUtU5hip0q6qBJdJO8z1FWSKYM
 Qtzj7BeQI3QwjPbY7if6XRokD4npeJOcv6fx3S9mMLhl5WkjvbT8fdq8u7Q=
X-Received: by 2002:a05:600c:a42:b0:442:f4d4:522 with SMTP id
 5b1f17b1804b1-442f4d44013mr25334715e9.5.1747241197411; 
 Wed, 14 May 2025 09:46:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWc0PnlzGGAXDCMutmbWm1oVGz/SJ7Lq9RCmcafOOAm8glpB8TsX/lHYSUYY1qBjgcYNvKcA==
X-Received: by 2002:a05:600c:a42:b0:442:f4d4:522 with SMTP id
 5b1f17b1804b1-442f4d44013mr25334515e9.5.1747241196939; 
 Wed, 14 May 2025 09:46:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f3380498sm38676575e9.11.2025.05.14.09.46.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 09:46:35 -0700 (PDT)
Message-ID: <b7f9bd89-e1a1-45bb-bbc0-c44f495ae82f@redhat.com>
Date: Wed, 14 May 2025 18:46:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 18/24] hw/acpi/ged: Prepare the device to react to PCI
 hotplug events
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com
References: <20250428102628.378046-1-eric.auger@redhat.com>
 <20250428102628.378046-19-eric.auger@redhat.com>
 <e68728e0-c478-475c-8cab-f64907afbcfb@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <e68728e0-c478-475c-8cab-f64907afbcfb@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Gustavo,

On 5/14/25 6:20 PM, Gustavo Romero wrote:
> Hi Eric,
>
> On 4/28/25 07:25, Eric Auger wrote:
>> QEMU will notify the OS about PCI hotplug/hotunplug events through
>> GED interrupts. Let the GED device handle a new PCI hotplug event.
>> On its occurence it calls the \\_SB.PCI0.PCNT method with the BLCK
>
> nit: occurrence -^
>
>
>> mutex held.
>>
>> The GED device uses a dedicated MMIO region that will be mapped
>> by the machine code.
>>
>> At this point the GED still does not support PCI device hotplug in
>> its TYPE_HOTPLUG_HANDLER implementation. This will come in a
>> subsequent patch
>
> nit: period missing ^
>
>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>   include/hw/acpi/generic_event_device.h |  5 +++++
>>   include/hw/acpi/pcihp.h                |  2 ++
>>   hw/acpi/generic_event_device.c         | 14 ++++++++++++++
>>   3 files changed, 21 insertions(+)
>>
>> diff --git a/include/hw/acpi/generic_event_device.h
>> b/include/hw/acpi/generic_event_device.h
>> index d2dac87b4a..28be6c0582 100644
>> --- a/include/hw/acpi/generic_event_device.h
>> +++ b/include/hw/acpi/generic_event_device.h
>> @@ -63,6 +63,7 @@
>>   #include "hw/acpi/memory_hotplug.h"
>>   #include "hw/acpi/ghes.h"
>>   #include "hw/acpi/cpu.h"
>> +#include "hw/acpi/pcihp.h"
>>   #include "qom/object.h"
>>     #define ACPI_POWER_BUTTON_DEVICE "PWRB"
>> @@ -101,6 +102,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>>   #define ACPI_GED_PWR_DOWN_EVT      0x2
>>   #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
>>   #define ACPI_GED_CPU_HOTPLUG_EVT    0x8
>> +#define ACPI_GED_PCI_HOTPLUG_EVT    0x10
>>     typedef struct GEDState {
>>       MemoryRegion evt;
>> @@ -114,6 +116,9 @@ struct AcpiGedState {
>>       MemoryRegion container_memhp;
>>       CPUHotplugState cpuhp_state;
>>       MemoryRegion container_cpuhp;
>> +    AcpiPciHpState pcihp_state;
>> +    MemoryRegion container_pcihp;
>> +
>>       GEDState ged_state;
>>       uint32_t ged_event_bitmap;
>>       qemu_irq irq;
>> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
>> index 451ef74284..abb6e14549 100644
>> --- a/include/hw/acpi/pcihp.h
>> +++ b/include/hw/acpi/pcihp.h
>> @@ -38,6 +38,8 @@
>>   #define ACPI_PCIHP_SEJ_BASE 0x8
>>   #define ACPI_PCIHP_BNMR_BASE 0x10
>>   +#define ACPI_PCI_HOTPLUG_REG_LEN 0x14
>
> This is wrong, no? It should be 0x18, i.e. 24 bytes or 6 registers of
> 4 bytes.
yes this is wrong. you are totally right. I am about to send a new
version where this is fixed, sorry. I noticed that when testing the acpi
index modality which did not work with the RFC series.

Now I am using ACPI_PCIHP_SIZE.

Cheers

Eric
>
> I think it's better to move the defines in pcihp.c into pcihp.h and
> use them to define ACPI_PCI_HOTPLUG_REG_LEN so the values are
> consistent, like:
>
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index 82b8ea2811..3ab8b9de94 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -44,14 +44,6 @@
>  #include "qobject/qnum.h"
>  #include "trace.h"
>  
> -#define ACPI_PCIHP_SIZE 0x0018
> -#define PCI_UP_BASE 0x0000
> -#define PCI_DOWN_BASE 0x0004
> -#define PCI_EJ_BASE 0x0008
> -#define PCI_RMV_BASE 0x000c
> -#define PCI_SEL_BASE 0x0010
> -#define PCI_AIDX_BASE 0x0014
> -
>  typedef struct AcpiPciHpFind {
>      int bsel;
>      PCIBus *bus;
> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> index abb6e14549..6b79adcaef 100644
> --- a/include/hw/acpi/pcihp.h
> +++ b/include/hw/acpi/pcihp.h
> @@ -38,7 +38,15 @@
>  #define ACPI_PCIHP_SEJ_BASE 0x8
>  #define ACPI_PCIHP_BNMR_BASE 0x10
>  
> -#define ACPI_PCI_HOTPLUG_REG_LEN 0x14
> +#define ACPI_PCIHP_SIZE 0x0018
> +#define PCI_UP_BASE 0x0000
> +#define PCI_DOWN_BASE 0x0004
> +#define PCI_EJ_BASE 0x0008
> +#define PCI_RMV_BASE 0x000c
> +#define PCI_SEL_BASE 0x0010
> +#define PCI_AIDX_BASE 0x0014
> +
> +#define ACPI_PCI_HOTPLUG_REG_LEN ACPI_PCIHP_SIZE
>  
>  typedef struct AcpiPciHpPciStatus {
>      uint32_t up;
>
>
> or even use only one of them (ACPI_PCI_HOTPLUG_REG_LEN,
> ACPI_PCIHP_SIZE, or
> another new name that would fit better in both contexts).
>
>
> Cheers,
> Gustavo
>
>> +
>>   typedef struct AcpiPciHpPciStatus {
>>       uint32_t up;
>>       uint32_t down;
>> diff --git a/hw/acpi/generic_event_device.c
>> b/hw/acpi/generic_event_device.c
>> index 7b2d582fff..0fd8baba97 100644
>> --- a/hw/acpi/generic_event_device.c
>> +++ b/hw/acpi/generic_event_device.c
>> @@ -26,6 +26,7 @@ static const uint32_t ged_supported_events[] = {
>>       ACPI_GED_PWR_DOWN_EVT,
>>       ACPI_GED_NVDIMM_HOTPLUG_EVT,
>>       ACPI_GED_CPU_HOTPLUG_EVT,
>> +    ACPI_GED_PCI_HOTPLUG_EVT,
>>   };
>>     /*
>> @@ -121,6 +122,12 @@ void build_ged_aml(Aml *table, const char *name,
>> HotplugHandler *hotplug_dev,
>>                              aml_notify(aml_name("\\_SB.NVDR"),
>>                                         aml_int(0x80)));
>>                   break;
>> +            case ACPI_GED_PCI_HOTPLUG_EVT:
>> +                aml_append(if_ctx,
>> +                           aml_acquire(aml_name("\\_SB.PCI0.BLCK"),
>> 0xFFFF));
>> +                aml_append(if_ctx, aml_call0("\\_SB.PCI0.PCNT"));
>> +                aml_append(if_ctx,
>> aml_release(aml_name("\\_SB.PCI0.BLCK")));
>> +                break;
>>               default:
>>                   /*
>>                    * Please make sure all the events in
>> ged_supported_events[]
>> @@ -299,6 +306,8 @@ static void acpi_ged_send_event(AcpiDeviceIf
>> *adev, AcpiEventStatusBits ev)
>>           sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
>>       } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
>>           sel = ACPI_GED_CPU_HOTPLUG_EVT;
>> +    } else if (ev & ACPI_PCI_HOTPLUG_STATUS) {
>> +        sel = ACPI_GED_PCI_HOTPLUG_EVT;
>>       } else {
>>           /* Unknown event. Return without generating interrupt. */
>>           warn_report("GED: Unsupported event %d. No irq injected", ev);
>> @@ -428,6 +437,11 @@ static void acpi_ged_realize(DeviceState *dev,
>> Error **errp)
>>               cpu_hotplug_hw_init(&s->container_cpuhp, OBJECT(dev),
>>                                   &s->cpuhp_state, 0);
>>               break;
>> +        case ACPI_GED_PCI_HOTPLUG_EVT:
>> +            memory_region_init(&s->container_pcihp, OBJECT(dev),
>> +                                "pcihp container",
>> +                                ACPI_PCI_HOTPLUG_REG_LEN);
>> +            sysbus_init_mmio(sbd, &s->container_pcihp);
>>           }
>>           ged_events--;
>>       }
>


