Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062DEC7115C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 13:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUQJ1-0008Vd-Nv; Wed, 25 Jun 2025 09:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uUQIo-0008Tx-Tu
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 09:36:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uUQIi-0000Cm-Hs
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 09:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750858590;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PMZJJFewBzjS4sZACakgZFb5UPa9fqCPQkRci89iPsg=;
 b=ATRcnfxy7RyebwAIkDd/i/rEoY4LlpIzYkULwxoPASmGip/Gi1ihMSzMky3eOn+KtXtwuR
 lejk4jtPknnqWgSdMyuvjeBJf/8kvPdngpWWO4xOvhT4FbnpA+ryH7vEs0dQxaP2HAzKoY
 /0odEF1DsQoKSMbUZEPRi9vpbGsl0pU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-I3KyF_G_NiKDp7jMh9dXAA-1; Wed, 25 Jun 2025 09:36:29 -0400
X-MC-Unique: I3KyF_G_NiKDp7jMh9dXAA-1
X-Mimecast-MFC-AGG-ID: I3KyF_G_NiKDp7jMh9dXAA_1750858588
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a6d1394b07so870139f8f.3
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 06:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750858587; x=1751463387;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PMZJJFewBzjS4sZACakgZFb5UPa9fqCPQkRci89iPsg=;
 b=WdWVJfFNVH/e1+sFtm3RyxyvJlZTBjaUt60bHcnkdj3Jfc1EqPt4+/TCuHuqDDxKtZ
 R7MtLG7aLpSJnPFRAGyT6qnq35Ls8FOb04s3QsHY3PUv1MSkwSMarVEOpUI8eZ6giA7l
 zjeC2QnH2j9eM/fBcNNihWbtnrBH7PfwZhsTO5EccZezGy7R9VhoI4mdR5B2O4bYi84K
 HhnFH9ZJ1RvP17bP9jIxCL9vbAuguI+LbsBmcbFCWXfLpIPsOWd48Rejyz6Bi8tnHkvQ
 HQbGi9A5UIqWpLNGbGc0aGyT5DZ1AYN0T0ZJJrsercs7+OZUKHVjB+LJ8l6ODjYBkdpr
 SOwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN27GmecP2jscVFwr7zPjLc5P60wCZVwzfvDqFPdF7NXWs2uI2WRTagXTvgbAzaZFMYeUDkTbhQCJR@nongnu.org
X-Gm-Message-State: AOJu0YyrdGHLiE9DqlaXeUGEIUzw4EOxo8grS3AbpJzUGWeGcviVuAcb
 ftHQWFTVbRZGG5h0oLlxauozz8AH3KVPa28FUhGP/vQcGv/Qx3n8/EeLCe21v4B5O4hNuJuEVwv
 WDKeLt+x+PamVpI+A32ZvWA+fbS9BVwKfnDTpjga1Ifj8cgoE2/S1z8BEeGV4CoKt
X-Gm-Gg: ASbGncuIDU9dQ1XfFYDjY842DoVZWolL0ob5BZ3z1xvI98D0nYvPsvWZH/nXT0XJ9um
 mTzCfQ/wLF/BLfo90qtWSrM9zpzLHNYfCiZ1q542aZgjFFP/GvyAyAM6WvgTdJLHSmxnO4FLjHY
 21fUj9VDBu6YcP43+3+FMZZjVCblN2r0qTxe9gFfb5PVWTOBoN/ajBzPF3Tx2BrSVMb6qlydKOo
 csfi6hWwW4BK6TXoANHS0WGxwec1RbGxb05kha1he9saWL0xVrO0owpTaiMo0EVTbPwEU8ILVpy
 VKxzdQ0wquK2sI6Dj+3ndsiFgZxD5MkHQriN/8A5oTS5eyn68MYrNZVfJMor/zdd03wELA==
X-Received: by 2002:a05:600c:8b2a:b0:43c:ed61:2c26 with SMTP id
 5b1f17b1804b1-45381b0f38fmr34328245e9.17.1750858586853; 
 Wed, 25 Jun 2025 06:36:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3EexqTQK3I72TlBjeIsO4GRe3IMZcznQleE/PNQb9uJ+uu6gNiSgT4L65YfkdZt4rq4hWQA==
X-Received: by 2002:a05:600c:8b2a:b0:43c:ed61:2c26 with SMTP id
 5b1f17b1804b1-45381b0f38fmr34327885e9.17.1750858586334; 
 Wed, 25 Jun 2025 06:36:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823b6c21sm20479955e9.29.2025.06.25.06.36.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 06:36:25 -0700 (PDT)
Message-ID: <8112ac0c-7fc6-4135-9024-830e83a1e1db@redhat.com>
Date: Wed, 25 Jun 2025 15:36:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 25/29] hw/arm/virt: Let virt support pci hotplug/unplug
 GED event
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, imammedo@redhat.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com,
 pbonzini@redhat.com, philmd@linaro.org, alex.bennee@linaro.org
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-26-eric.auger@redhat.com>
 <20250620111745.00004018@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250620111745.00004018@huawei.com>
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
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Hi Jonathan,

On 6/20/25 12:17 PM, Jonathan Cameron wrote:
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
> I'm very much in favor of this change but maybe break them out to
> a separate patch - perhaps even one that can run ahead of the rest
> of this series?

I split it in a separate patch.

Thanks!

Eric
>
> Mind you if this is going to land shortly perhaps not worth the bother.
>
> Either way
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>
>
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
>> +        int pcihp_region_index;
>> +
>> +        pcihp_region_index = sysbus_mmio_map_name(sbdev, ACPI_PCIHP_REGION_NAME,
>> +                                                  vms->memmap[VIRT_ACPI_PCIHP].base);
>> +        assert(pcihp_region_index >= 0);
>> +    }
>>      sysbus_connect_irq(sbdev, 0, qdev_get_gpio_in(vms->gic, irq));
>>  
>>      return dev;


