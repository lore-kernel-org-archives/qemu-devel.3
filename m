Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66609C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUR0M-0004vQ-W9; Wed, 25 Jun 2025 10:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uUR0I-0004Xs-83
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:21:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uUR0F-0005Ag-Ud
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750861289;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uLeoRO3qY2bDTFoaD7t9coh7zMYmVZ6hL7duH5Mrtmc=;
 b=P8bIh+TTbANvcHult5uJH+6d+/0xJTuOIUnTf6ivrnDZEka98NCJoQVqEvlpxh9YxvmCiI
 v7CD3p/SpKqVWCn0FSHoWs1RccYcy+mb2DY7oRGKnFHn2cgnWrC6A3Ug1tIwmHIFKS4jHW
 QseteB4T4Sxe7p58BmCztgvhcZc4DXo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-56R3XdiNMruE7hxBZuuk6Q-1; Wed, 25 Jun 2025 10:21:27 -0400
X-MC-Unique: 56R3XdiNMruE7hxBZuuk6Q-1
X-Mimecast-MFC-AGG-ID: 56R3XdiNMruE7hxBZuuk6Q_1750861286
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45334219311so8651185e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 07:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750861286; x=1751466086;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uLeoRO3qY2bDTFoaD7t9coh7zMYmVZ6hL7duH5Mrtmc=;
 b=Ki6haWjm+6Ir+lttTrU+YaCnLfAZBg9G0WcXXh86gHORW8bE4zYJ446g0z6kAHVvc2
 KUuFKaKVjdjPFlphgsnq1j0MJ+K6rZyEIQOdbMKjglw3sBCsj1gXWtAzkHcZQCVZQjRD
 Thy6uMtI9n1hINRhk8b3Ob3H7MAmLwKNb+Bw9t/oN7EAuDJrGt+ha0pMosxDPQrO4ETB
 7HUpCzltxNi+EhWCKAYm8Az5VXfx7kZK/jrPYHxPErAnRE/Pz/pVdSrI8dg4KrX5Jbta
 XFyHlfWhEoAtm0tInUkOv+JZIg3/4dlOBj7ojQgE9cJkgUAfJHlqC2OcWG984d2nUCcz
 /c6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU91Cz/J8XcKl+LnE5+NaslxFMlaua+UYQQU3AN5ZG7zRHJKxU5NKzIFSyJM2QorN1XjyPiMhKFGwmP@nongnu.org
X-Gm-Message-State: AOJu0Yw9P5M2iHU01XBSzhlo2NxuuyiuXnNpDEHCylxiZf292QSyxV9X
 +St/ggdpLvJTiozGpi1sS0yWNIcv92fB/iLUPgTQCvdrEcZIMrLjy7U3m/kX3pcmQA12uwc9izm
 etI2JUgtYdUgYvHIimMGvT97dY3X8y/FoHGjuHJfP9NYmQhMGNxIgchK2
X-Gm-Gg: ASbGncu2D6CCsr+ZJQ+Yrr/6GEPaAJFOl5yGq5qca1bTu5/3UxPGwspeW/e4rv/DhZH
 Mm71ACwzPieFCnRjNErvKSTbOhB7LQvWlGQCxLCesGFHsCqnghU7LjV+PruIxRiGQnyHKO5mhst
 bJpuTFUoD6DhBw0p7nv6F3KZrwwkAVfi5sI6uJKVNzrjprsKX3q4itDyTN7t3qVTlbF2j//U81N
 pu3JDOLiISPelxSnsSXrC2W/R/Isd2GOuqBAFgy+xDbv/IQysdv5vcWYlgnTG7CyorL/LD1zYCi
 LL0/51KHFA45snPQCSQjKZ5RRemwEluY8jHYE/UKTmvAN5W1z9dvR0PiWISJZopxzTfc2w==
X-Received: by 2002:a05:600d:15a:10b0:442:e9eb:cb9e with SMTP id
 5b1f17b1804b1-4538331236cmr14520825e9.26.1750861286125; 
 Wed, 25 Jun 2025 07:21:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEp9CKYTiWxbdtqhdvf++XOESOkJi0KZqi/p61WGu4snCk3bITdu7PTB/RdduV8RZnAreDX3Q==
X-Received: by 2002:a05:600d:15a:10b0:442:e9eb:cb9e with SMTP id
 5b1f17b1804b1-4538331236cmr14520665e9.26.1750861285654; 
 Wed, 25 Jun 2025 07:21:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538235600csm21581305e9.20.2025.06.25.07.21.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 07:21:24 -0700 (PDT)
Message-ID: <8e82a2d3-514b-4d3f-9c62-26062d243135@redhat.com>
Date: Wed, 25 Jun 2025 16:21:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/29] hw/acpi/ged: Prepare the device to react to PCI
 hotplug events
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-21-eric.auger@redhat.com>
 <20250620145714.0923f6c0@fedora>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250620145714.0923f6c0@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/20/25 2:57 PM, Igor Mammedov wrote:
> On Mon, 16 Jun 2025 11:46:49 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> QEMU will notify the OS about PCI hotplug/hotunplug events through
>> GED interrupts. Let the GED device handle a new PCI hotplug event.
>> On its occurrence it calls the \\_SB.PCI0.PCNT method with the BLCK
>> mutex held.
>>
>> The GED device uses a dedicated MMIO region that will be mapped
>> by the machine code.
>
>> At this point the GED still does not support PCI device hotplug in
>> its TYPE_HOTPLUG_HANDLER implementation. This will come in a
>> subsequent patch.
> looks out of order, perhaps it should be before this patch
done, swapped both patches.

Eric
>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>> v2 -> v3:
>> - pcihp_init and reset are put in ged code instead of machine code
>>   (Igor)
>>
>> v1 -> v2:
>> - Introduce ACPI_PCIHP_REGION_NAME
>> ---
>>  include/hw/acpi/generic_event_device.h |  4 ++++
>>  hw/acpi/generic_event_device.c         | 26 ++++++++++++++++++++++++++
>>  hw/acpi/pcihp.c                        |  1 -
>>  3 files changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
>> index f5ffa67a39..ec8e1abe0a 100644
>> --- a/include/hw/acpi/generic_event_device.h
>> +++ b/include/hw/acpi/generic_event_device.h
>> @@ -102,6 +102,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>>  #define ACPI_GED_PWR_DOWN_EVT      0x2
>>  #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
>>  #define ACPI_GED_CPU_HOTPLUG_EVT    0x8
>> +#define ACPI_GED_PCI_HOTPLUG_EVT    0x10
>>  
>>  typedef struct GEDState {
>>      MemoryRegion evt;
>> @@ -109,6 +110,8 @@ typedef struct GEDState {
>>      uint32_t     sel;
>>  } GEDState;
>>  
>> +#define ACPI_PCIHP_REGION_NAME "pcihp container"
>> +
>>  struct AcpiGedState {
>>      SysBusDevice parent_obj;
>>      MemHotplugState memhp_state;
>> @@ -116,6 +119,7 @@ struct AcpiGedState {
>>      CPUHotplugState cpuhp_state;
>>      MemoryRegion container_cpuhp;
>>      AcpiPciHpState pcihp_state;
>> +    MemoryRegion container_pcihp;
>>      GEDState ged_state;
>>      uint32_t ged_event_bitmap;
>>      qemu_irq irq;
>> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
>> index ef1c1ec51f..b4eefb0106 100644
>> --- a/hw/acpi/generic_event_device.c
>> +++ b/hw/acpi/generic_event_device.c
>> @@ -12,6 +12,7 @@
>>  #include "qemu/osdep.h"
>>  #include "qapi/error.h"
>>  #include "hw/acpi/acpi.h"
>> +#include "hw/acpi/pcihp.h"
>>  #include "hw/acpi/generic_event_device.h"
>>  #include "hw/pci/pci.h"
>>  #include "hw/irq.h"
>> @@ -27,6 +28,7 @@ static const uint32_t ged_supported_events[] = {
>>      ACPI_GED_PWR_DOWN_EVT,
>>      ACPI_GED_NVDIMM_HOTPLUG_EVT,
>>      ACPI_GED_CPU_HOTPLUG_EVT,
>> +    ACPI_GED_PCI_HOTPLUG_EVT,
>>  };
>>  
>>  /*
>> @@ -122,6 +124,12 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
>>                             aml_notify(aml_name("\\_SB.NVDR"),
>>                                        aml_int(0x80)));
>>                  break;
>> +            case ACPI_GED_PCI_HOTPLUG_EVT:
>> +                aml_append(if_ctx,
>> +                           aml_acquire(aml_name("\\_SB.PCI0.BLCK"), 0xFFFF));
>> +                aml_append(if_ctx, aml_call0("\\_SB.PCI0.PCNT"));
>> +                aml_append(if_ctx, aml_release(aml_name("\\_SB.PCI0.BLCK")));
>> +                break;
>>              default:
>>                  /*
>>                   * Please make sure all the events in ged_supported_events[]
>> @@ -300,6 +308,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>>          sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
>>      } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
>>          sel = ACPI_GED_CPU_HOTPLUG_EVT;
>> +    } else if (ev & ACPI_PCI_HOTPLUG_STATUS) {
>> +        sel = ACPI_GED_PCI_HOTPLUG_EVT;
>>      } else {
>>          /* Unknown event. Return without generating interrupt. */
>>          warn_report("GED: Unsupported event %d. No irq injected", ev);
>> @@ -433,6 +443,12 @@ static void acpi_ged_realize(DeviceState *dev, Error **errp)
>>              cpu_hotplug_hw_init(&s->container_cpuhp, OBJECT(dev),
>>                                  &s->cpuhp_state, 0);
>>              break;
>> +        case ACPI_GED_PCI_HOTPLUG_EVT:
>> +            memory_region_init(&s->container_pcihp, OBJECT(dev),
>> +                               ACPI_PCIHP_REGION_NAME, ACPI_PCIHP_SIZE);
>> +            sysbus_init_mmio(sbd, &s->container_pcihp);
>> +            acpi_pcihp_init(OBJECT(s), &s->pcihp_state,
>> +                            s->pcihp_state.root, &s->container_pcihp, 0);
>>          }
>>          ged_events--;
>>      }
>> @@ -474,6 +490,15 @@ static void acpi_ged_initfn(Object *obj)
>>      sysbus_init_mmio(sbd, &ged_st->regs);
>>  }
>>  
>> +static void ged_reset(DeviceState *dev)
>> +{
>> +    AcpiGedState *s = ACPI_GED(dev);
>> +
>> +    if (s->pcihp_state.use_acpi_hotplug_bridge) {
>> +        acpi_pcihp_reset(&s->pcihp_state);
>> +    }
>> +}
>> +
>>  static void acpi_ged_class_init(ObjectClass *class, const void *data)
>>  {
>>      DeviceClass *dc = DEVICE_CLASS(class);
>> @@ -488,6 +513,7 @@ static void acpi_ged_class_init(ObjectClass *class, const void *data)
>>      hc->plug = acpi_ged_device_plug_cb;
>>      hc->unplug_request = acpi_ged_unplug_request_cb;
>>      hc->unplug = acpi_ged_unplug_cb;
>> +    device_class_set_legacy_reset(dc, ged_reset);
>>  
>>      adevc->ospm_status = acpi_ged_ospm_status;
>>      adevc->send_event = acpi_ged_send_event;
>> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
>> index e79a24b821..36492aa0d9 100644
>> --- a/hw/acpi/pcihp.c
>> +++ b/hw/acpi/pcihp.c
>> @@ -43,7 +43,6 @@
>>  #include "qobject/qnum.h"
>>  #include "trace.h"
>>  
>> -#define ACPI_PCIHP_SIZE 0x0018
>>  #define PCI_UP_BASE 0x0000
>>  #define PCI_DOWN_BASE 0x0004
>>  #define PCI_EJ_BASE 0x0008


