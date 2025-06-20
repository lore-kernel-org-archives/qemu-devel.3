Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E983C7115D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 11:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSZuB-0006uo-Mz; Fri, 20 Jun 2025 07:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSZu5-0006uD-CA
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 07:27:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSZu3-0008Oy-Ch
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 07:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750418846;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GKUErb7mGYcwpPGy7qjvEewo6keTbXuBg4VySCaSGGU=;
 b=iS2O8OhI6L5WRjjkhRLNNgxJCqnDjB15GLMZrQ19T5+a6Lk6Le4GzKs3H072JYYpMsc1kC
 tIx/cwG8wHmzoRq7UczAWqgEz8xLKgfFxz8LXpWYXvBX/cJYICpzn1M8xUFCwoI0+W0nWx
 1xGzJpItz+Pyuf3YmBIjiLvP84ROEk4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-0AXhCvp_P_q6uQiqIL5hTA-1; Fri, 20 Jun 2025 07:27:25 -0400
X-MC-Unique: 0AXhCvp_P_q6uQiqIL5hTA-1
X-Mimecast-MFC-AGG-ID: 0AXhCvp_P_q6uQiqIL5hTA_1750418844
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4f6ff23ccso1002169f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 04:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750418844; x=1751023644;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GKUErb7mGYcwpPGy7qjvEewo6keTbXuBg4VySCaSGGU=;
 b=GXhAmt93FiyY6dD2UH2VhSpAI1lv8cDDfOGh8AO4MQrRC74Djf1/Vmei8qbL6AGytG
 w8qWLDdKY1EBOiREGjpPprTe6o7c15skrC2gwA2xvP6z872nEzPh02vBOKv1UVB7OMM2
 MzJWMuF0jcShMAdopPZE/I5lyOlEDT2Qyrc8qn5nokGKXVbpMcu5o109AHv4rn3rVmqZ
 I2xDkoQHYr7pxLJuubov6tAo5xpQrMyrFO6swE5SbyOTICB0JI2k1IwtaAAdb32YtYyL
 JNuf1B4+bGb8E4qGSm7XKsoGBe6ivKrTFHEcVXdLpcovI4CuqeFDxR7z4qR19HSXttOm
 02JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRjjTaFCaVcmYI3IJiHs2+gzDvuOife7m8BCKcBxJd5q14sAIS3uLOYvzuQy9qf2V+DSo4u9ujRX6f@nongnu.org
X-Gm-Message-State: AOJu0Yx23ZxsnEiKNqfjW07oNPQ6yEZ4A1gBTx3WGoNraNiuCn9Jc63K
 GAy0OJH2nunz+uJJgP3uyObHp7mZsB+sfTBQt1rSD/LDIpwsqqHjml9by83wM5+JiB+jnEMTv5a
 f9UhFwFCrM9tLwxcH9ZU19zWxPnwTBpcVr8XYfZxbcNKPloV+JsBydERh
X-Gm-Gg: ASbGncuVfNJjlccuDiX2uL9NaRXohWMvHk7Tt/wx4mrnYxhIzJxfv7vKA+Y8f3bT/+A
 PlYRhpdlEqoz03nn/2ozEjCCQzHrFELs8QoeI6I0IEOlNxs4q+fjYd+p/qnoF9Ruoc/3reXqofg
 MaCsXcbBYZ9UzTvyLzHYgsjlY8jYxJAscVdhPQohaqEhrWoMFStsabqjgcNap5+QKs1uoiX40Np
 wQAuKPsd47va2K9cRTkmswc41tYCxfdiOooKfGSaoUusdlIUgbiaHNlTddX4OLuMW1Gu80+GEKM
 tX7ogZJpUnHsoTZ2vdOoLganMGkWx01zu/0nN2RtdmzzSNgqNbVUSldbyZuqt933O8kupA==
X-Received: by 2002:a05:6000:2dc7:b0:39f:175b:a68d with SMTP id
 ffacd0b85a97d-3a6d12bb555mr2046716f8f.11.1750418843708; 
 Fri, 20 Jun 2025 04:27:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3s+trTv/yN4bfSZxltaFpyJDP+ti0s5oTX83pMk1LFruMvOEKCH5I2nKiTkoBMyCD3uiOjg==
X-Received: by 2002:a05:6000:2dc7:b0:39f:175b:a68d with SMTP id
 ffacd0b85a97d-3a6d12bb555mr2046695f8f.11.1750418843275; 
 Fri, 20 Jun 2025 04:27:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535ead2a5fsm56255485e9.34.2025.06.20.04.27.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Jun 2025 04:27:22 -0700 (PDT)
Message-ID: <15cea52b-3cd7-4f59-9073-5a0d0cfd19d9@redhat.com>
Date: Fri, 20 Jun 2025 13:27:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/29] hw/acpi/ged: Add a
 acpi-pci-hotplug-with-bridge-support property
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 philmd@linaro.org, alex.bennee@linaro.org
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-3-eric.auger@redhat.com>
 <20250620095308.00000d16@huawei.com> <20250620130941.6c0e6ff8@fedora>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250620130941.6c0e6ff8@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

Hi Jonathan, Igor,

On 6/20/25 1:09 PM, Igor Mammedov wrote:
> On Fri, 20 Jun 2025 09:53:08 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
>
>> On Mon, 16 Jun 2025 11:46:31 +0200
>> Eric Auger <eric.auger@redhat.com> wrote:
>>
>>> A new boolean property is introduced. This will be used to turn
>>> ACPI PCI hotplug support. By default it is unset.
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>  
>> I wonder a bit if it makes sense to do this so early rather than just
>> before it is first used in the series?  Doesn't really matter though.
>> Just meant I read on a bit before giving an RB on this.
> Just before would be better, but it doesn't really matter.
> I guess Eric can rearrange that if there would be need to respin.
Yes I can definitively rearrange the order.

Thank you for the review

Eric
>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>>
>>> ---
>>>  include/hw/acpi/generic_event_device.h | 2 ++
>>>  hw/acpi/generic_event_device.c         | 2 ++
>>>  2 files changed, 4 insertions(+)
>>>
>>> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
>>> index d2dac87b4a..f5ffa67a39 100644
>>> --- a/include/hw/acpi/generic_event_device.h
>>> +++ b/include/hw/acpi/generic_event_device.h
>>> @@ -63,6 +63,7 @@
>>>  #include "hw/acpi/memory_hotplug.h"
>>>  #include "hw/acpi/ghes.h"
>>>  #include "hw/acpi/cpu.h"
>>> +#include "hw/acpi/pcihp.h"
>>>  #include "qom/object.h"
>>>  
>>>  #define ACPI_POWER_BUTTON_DEVICE "PWRB"
>>> @@ -114,6 +115,7 @@ struct AcpiGedState {
>>>      MemoryRegion container_memhp;
>>>      CPUHotplugState cpuhp_state;
>>>      MemoryRegion container_cpuhp;
>>> +    AcpiPciHpState pcihp_state;
>>>      GEDState ged_state;
>>>      uint32_t ged_event_bitmap;
>>>      qemu_irq irq;
>>> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
>>> index 7a62f8d5bc..7831db412b 100644
>>> --- a/hw/acpi/generic_event_device.c
>>> +++ b/hw/acpi/generic_event_device.c
>>> @@ -318,6 +318,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>>>  
>>>  static const Property acpi_ged_properties[] = {
>>>      DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
>>> +    DEFINE_PROP_BOOL(ACPI_PM_PROP_ACPI_PCIHP_BRIDGE, AcpiGedState,
>>> +                     pcihp_state.use_acpi_hotplug_bridge, 0),
>>>  };
>>>  
>>>  static const VMStateDescription vmstate_memhp_state = {  


