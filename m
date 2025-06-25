Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673A4C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 13:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUQJS-0000FH-Ul; Wed, 25 Jun 2025 09:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uUQJM-00009r-2t
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 09:37:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uUQJH-0000KE-U8
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 09:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750858625;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jaApqlhiblKm5r3TKdO6hVIekuhpSl6yTPCgdm7/cSk=;
 b=LxdOlqud+y0onCyEhMYBQ2C9VIzL9J09QUQLo4nlsw7XOImIeWUI2HzgSTeYdiin5KH9z9
 6T3IArzpuD9enJv8O29z1IU7Vtdi31FL4ROiPOLRiwd6kkEeWPHVQGT78O3y6+/9nRn1Zc
 KHmcxs5EK6oHnJvhz/VOjKGYlxNndXc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-i1BhsgHlMGW_WVRmKZ7l2g-1; Wed, 25 Jun 2025 09:37:04 -0400
X-MC-Unique: i1BhsgHlMGW_WVRmKZ7l2g-1
X-Mimecast-MFC-AGG-ID: i1BhsgHlMGW_WVRmKZ7l2g_1750858623
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45334219311so8364615e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 06:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750858623; x=1751463423;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jaApqlhiblKm5r3TKdO6hVIekuhpSl6yTPCgdm7/cSk=;
 b=tRGvM+xzCNH4/e6OOC/Xoq7is4QlZCyrM7APaLgSva+eroI/rPmELoB/iVFPjVY83L
 w2QW31z00ZhvsMGixCHSYnUmNt246XYw5+tiAYqn3/zPCKXdHwFzxm9bHlwGyZLIwKm/
 cS62H9uRoi9zmQNZP6tB7YviGfBGhFHHJuGQbEzknT7K75o0PHrJx339q8ypIqlW+Hat
 J8z0cn25c4H1K91pZuJDUgaytKHcehg7pxfpRmuxNf3mFr4geNKpRwbQt9PSC/AtqaFm
 6a41LlpGKlN/TlYadR7eK85ZLn23BgV5DZfwh8w6jLh0uqqfxQJqzMbA+tk8bu6iJl3n
 GkWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt+Ie6ymh7aIB+WERxl60iiavtCYSQKpT/n6fEMCkXe9WQZDiLVj1SHmJMExWtMWUAL4JwXqKHmYUQ@nongnu.org
X-Gm-Message-State: AOJu0YwGGqHOujxfV1+wg888O8GclAXyPKWV7ylVC/9EeeBop8eI0ynD
 ONNxqBjN8vIiQEWif8mIaPD6Eb2MQEnAk7oYE6dkTqQIDNwNRjHld7rLKIr+TsRQR0yQA+2zkRx
 tpY/BHrWBdjkyUE7egD626EkV7+X1p+75cqNRFZQVuAL3PkFLDB0C8VmV
X-Gm-Gg: ASbGncuQqT/hI+ZEnPsWPuMv3auS0xzj2/C05R6AcSvcZX2CjxI7g+UtNI0K5cazCTf
 j22sTjwTpWTuryFH2qyx254saiOD2W2nL8tw6HnfS0aSRvoUSsVgcVPIHhLxHNfN+iAPSLPrEL+
 S5+47Ept2LaqUqo94Ne1XI62iCA4gLFtGXIN+GQt2QVVBOHozkf9JKPlNzF/Pf72uQA7vFcn/oW
 /dmxtDedeIXoTBg5eLdDqHVoJMG4alo5gzzwqZc+BIIeWUh3BpCtT1ty5GYQgW3nE1HY/t0im1o
 45KthIqKNn1hA2QVXbukHCx5eJEg4CdfNL8pencJ4FFVEvAIe4Gj3iI0UWimOOJaMt8R+w==
X-Received: by 2002:a05:600c:8508:b0:451:dee4:cd08 with SMTP id
 5b1f17b1804b1-45381ae9db8mr27151115e9.23.1750858623057; 
 Wed, 25 Jun 2025 06:37:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpAevyhZsnp1X2UVaim4WOdyZNyUJUXnzjuOSPa84JSIIrAA94+wjYSrD4x4ljFHBfwqYevg==
X-Received: by 2002:a05:600c:8508:b0:451:dee4:cd08 with SMTP id
 5b1f17b1804b1-45381ae9db8mr27150645e9.23.1750858622439; 
 Wed, 25 Jun 2025 06:37:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8063a5dsm4806861f8f.35.2025.06.25.06.37.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 06:37:01 -0700 (PDT)
Message-ID: <f90d8aa1-74bc-46e1-b4a6-9a4f54854d86@redhat.com>
Date: Wed, 25 Jun 2025 15:37:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 25/29] hw/arm/virt: Let virt support pci hotplug/unplug
 GED event
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-26-eric.auger@redhat.com>
 <20250620150648.09dab163@fedora>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250620150648.09dab163@fedora>
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

Hi Igor,

On 6/20/25 3:06 PM, Igor Mammedov wrote:
> On Mon, 16 Jun 2025 11:46:54 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> Set up the IO registers used to communicate between QEMU
>> and ACPI.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>> v2 -> v3:
>> - remove acpi_ged_state->pcihp_state.use_acpi_hotplug_bridge = true;
>> - use sysbus_mmio_map_name for all regs (Igor)
>> - create_pcie left at its original place
>>
>> v1 -> v2:
>> - use ACPI_PCIHP_REGION_NAME
>> ---
>>  include/hw/acpi/generic_event_device.h |  1 +
>>  hw/arm/virt.c                          | 19 +++++++++++++++++--
>>  2 files changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
>> index ec8e1abe0a..8f5d903146 100644
>> --- a/include/hw/acpi/generic_event_device.h
>> +++ b/include/hw/acpi/generic_event_device.h
>> @@ -111,6 +111,7 @@ typedef struct GEDState {
>>  } GEDState;
>>  
>>  #define ACPI_PCIHP_REGION_NAME "pcihp container"
>> +#define ACPI_MEMHP_REGION_NAME "memhp container"
>>  
>>  struct AcpiGedState {
>>      SysBusDevice parent_obj;
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 41be8f6dbb..8c882e0794 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -684,6 +684,8 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
>>      DeviceState *dev;
>>      MachineState *ms = MACHINE(vms);
>>      SysBusDevice *sbdev;
>> +    AcpiGedState *acpi_ged_state;
>> +    AcpiPciHpState *pcihp_state;
>>      int irq = vms->irqmap[VIRT_ACPI_GED];
>>      uint32_t event = ACPI_GED_PWR_DOWN_EVT;
>>  
>> @@ -696,13 +698,26 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
>>      }
>>  
>>      dev = qdev_new(TYPE_ACPI_GED);
>> +    acpi_ged_state = ACPI_GED(dev);
>> +    pcihp_state = &acpi_ged_state->pcihp_state;
>> +    if (pcihp_state->use_acpi_hotplug_bridge) {
>> +        event |= ACPI_GED_PCI_HOTPLUG_EVT;
>> +    }
> Doesn't it belong to ged_realize()?
moved there
>
>>      qdev_prop_set_uint32(dev, "ged-event", event);
>>      object_property_set_link(OBJECT(dev), "bus", OBJECT(vms->bus), &error_abort);
>>      sbdev = SYS_BUS_DEVICE(dev);
>>      sysbus_realize_and_unref(sbdev, &error_fatal);
>>  
>> -    sysbus_mmio_map(sbdev, 0, vms->memmap[VIRT_ACPI_GED].base);
>> -    sysbus_mmio_map(sbdev, 1, vms->memmap[VIRT_PCDIMM_ACPI].base);
>> +    sysbus_mmio_map_name(sbdev, TYPE_ACPI_GED, vms->memmap[VIRT_ACPI_GED].base);
>> +    sysbus_mmio_map_name(sbdev, ACPI_MEMHP_REGION_NAME,
>> +                         vms->memmap[VIRT_PCDIMM_ACPI].base);
>> +    if (pcihp_state->use_acpi_hotplug_bridge) {
> like elsewhere, use property accessor
yup

Thanks!

Eric
>
>> +        int pcihp_region_index;
>> +
>> +        pcihp_region_index = sysbus_mmio_map_name(sbdev, ACPI_PCIHP_REGION_NAME,
>> +                                                  vms->memmap[VIRT_ACPI_PCIHP].base);
>> +        assert(pcihp_region_index >= 0);
>> +    }
>>      sysbus_connect_irq(sbdev, 0, qdev_get_gpio_in(vms->gic, irq));
>>  
>>      return dev;


