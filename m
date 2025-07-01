Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5D1C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 09:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWXHI-0001N0-P4; Tue, 01 Jul 2025 05:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uWXHF-0001MA-Ft
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 05:27:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uWXHB-0000xJ-EK
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 05:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751362059;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kxdm+rVFS0UrnkJ5BCZrJx8tPFVIpspNyPDUVBvVyZ4=;
 b=gWwMEXt4PZRFNzbyX6hz7+L4//UmhWsYccl4UIpZVahfQ71X9Oed36OyPn4zhozr4ByiiM
 KujGOr3nV6Oi2d8cea1JQdzDzivYCccMrLBDW2k6pG7GMc+GbhZQex35q/Z/njOScHO3dZ
 p9w95La4RZ7/d9dnuNBs19QZMgW2tZA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-WCLftgPJMP2VsCjYhuvJWg-1; Tue, 01 Jul 2025 05:27:38 -0400
X-MC-Unique: WCLftgPJMP2VsCjYhuvJWg-1
X-Mimecast-MFC-AGG-ID: WCLftgPJMP2VsCjYhuvJWg_1751362057
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4539b44e7b1so15195415e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 02:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751362057; x=1751966857;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kxdm+rVFS0UrnkJ5BCZrJx8tPFVIpspNyPDUVBvVyZ4=;
 b=ujXl8t0yaMJWQ6esRg5TqlG+QGM9E12md5CB8rf8XSIafmq9Z5lAWhWFBUf7yh4Tmh
 csJTPt22s3k9IBh/Z1qHzhAvKPPZDfhSKapt5G7DiJEhkHyYH8lne5OfwWjT1ghskYlM
 /zKrf69wb1tkCZXaSVOZoRZzkJdoVrtMle6MTh/0zCIW/g+OOVw1gxTZvjXYBaxRQwpd
 ps37nJKLGUM9zvzwuw9vXiTgAzhfzVsVbsouuAqtJcxXCAHgG+8HebJjdjMs8ivh5oM9
 q5rnTH6Zh9KqOhoHo7HFNSanq0Vn45wy1WIOjE7mtUZ0OOJZ8vKandeP2i77yo1u21sA
 ZGDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4J6XBUS3wGLsYazK2HFWgE5tfcU5QEQeqR63H3CJjX6Y09mHHtdSUN7L7rkujMPKm/d+0gwPwNAiy@nongnu.org
X-Gm-Message-State: AOJu0YzeJpDNVZF3JE2NmKJBZcewjO0d/iiXLOabNmTmpnb29bC5MGGE
 98Z/G9VhGDrZB39EFYfPArgLdLl3PFH5hQc/d7JdG6BrLKiCwDTU6efiRcJlsSvKt6GAVKhO8NA
 3muEXheg1/V/475AfYQ3NE9DhUWmIiI6R7DXFykAmG523SBxz4AudZkiG
X-Gm-Gg: ASbGncvpf6BChJqqQ7pQmkHG27NySjZHkqQCrVijAIdn/c7loKiuVUW3UqSkaNkRPLE
 5LTUb6W/c2jrRz1204YWmE8WvqOlzQjJXVS9aMjlDoc0FfF82aFHVGwHWwHloB4t7SGOWFg7Qf1
 y27pqv0EuCwcmirwruqL4erQQY+0EyuVQxQlN2WJ27fow1wq86D8WODlRRH4ES3aHEcPens/svO
 3wfytSvSK42xggfvPEy4F44F9otFTO7QbGU2Gr8/R4V5VRtqRSDQHz+a1+EIfGuuXmlrN3O315J
 t/3AdX0teBC2PNJm/WNmQqBPB6bApKEqA8Z5vb+iWYFOkB2Vq8q7IUB56wTIJvz/g5iFWg==
X-Received: by 2002:a05:6000:65a:b0:3a4:dfaa:df8d with SMTP id
 ffacd0b85a97d-3a8f587414emr14393432f8f.9.1751362056526; 
 Tue, 01 Jul 2025 02:27:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKRIrVhUYJLjlUjyw4WBtqaUaOHgrM6XhkQxJrl0Wn4qIXq5NJ96NSB8ZmFGEpgsn5GKgAsg==
X-Received: by 2002:a05:6000:65a:b0:3a4:dfaa:df8d with SMTP id
 ffacd0b85a97d-3a8f587414emr14393404f8f.9.1751362056079; 
 Tue, 01 Jul 2025 02:27:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e598d2sm12622240f8f.76.2025.07.01.02.27.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 02:27:35 -0700 (PDT)
Message-ID: <cbfc1237-fd08-4c68-a327-fd83a4de00dd@redhat.com>
Date: Tue, 1 Jul 2025 11:27:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 25/32] hw/acpi/ged: Prepare the device to react to PCI
 hotplug events
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, imammedo@redhat.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com,
 pbonzini@redhat.com, philmd@linaro.org, alex.bennee@linaro.org
References: <20250627095620.3300028-1-eric.auger@redhat.com>
 <20250627095620.3300028-26-eric.auger@redhat.com>
 <20250630134957.00006326@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250630134957.00006326@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Jonathan,

On 6/30/25 2:49 PM, Jonathan Cameron wrote:
> On Fri, 27 Jun 2025 11:55:14 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> QEMU will notify the OS about PCI hotplug/hotunplug events through
>> GED interrupts. Let the GED device handle a new PCI hotplug event.
>> On its occurrence it calls the \\_SB.PCI0.PCNT method with the BLCK
>> mutex held.
>>
>> The GED device uses a dedicated MMIO region that will be mapped
>> by the machine code.
>>
>> At this point the GED still does not support PCI device hotplug in
>> its TYPE_HOTPLUG_HANDLER implementation. This will come in a
>> subsequent patch.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Maybe call out why you aren't following the advice in the
> docs for device_class_set_legacy_reset() to use the resettable API. 
Good point. I think I shall migrate to the new API.
>
> One other question inline about setting of the event bitmap in
> ged_realize rather than create_acpi_ged() in virt.c
>
> There is not obviously right answer to where that should be but
> what you have here seems inconsistent with existing code s
> a comment may makes sense if you leave it as it stands.
>
>> ---
>> v3 -> v4:
>> - add qbus_set_hotplug_handler
>> - root bus is not passed in acpi_pcihp_init arg
>>
>> v2 -> v3:
>> - pcihp_init and reset are put in ged code instead of machine code
>>   (Igor)
>> - Add ACPI_GED_PCI_HOTPLUG_EVT event depending on use_acpi_hotplug_bridge
>>   (Igor)
>>
>> v1 -> v2:
>> - Introduce ACPI_PCIHP_REGION_NAME
>> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
>> index 92b931758f..fc84bfb34e 100644
>> --- a/hw/acpi/generic_event_device.c
>> +++ b/hw/acpi/generic_event_device.c
>> @@ -427,9 +437,13 @@ static void acpi_ged_realize(DeviceState *dev, Error **errp)
>>  {
>>      SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>>      AcpiGedState *s = ACPI_GED(dev);
>> +    AcpiPciHpState *pcihp_state = &s->pcihp_state;
>>      uint32_t ged_events;
>>      int i;
>>  
>> +    if (pcihp_state->use_acpi_hotplug_bridge) {
>> +        s->ged_event_bitmap |= ACPI_GED_PCI_HOTPLUG_EVT;
>> +    }
> Maybe a comment on why this belongs insider the GED code rather
> than being provided in the event_bitmap from virt.c or similar
> as is done for all the over elements of ged_event_bitmap.
>
> Particularly as you get the acpi_pcihp property in create_acpi_ged()
> in patch 29.
Actually Igor suggested to put this setting in the realize()
https://lore.kernel.org/all/20250620150648.09dab163@fedora/
instead of in create_acpi_ged(), as it was done in v3 So I followed his
guidance Eric
>
>
>>      ged_events = ctpop32(s->ged_event_bitmap);
>>  
>


