Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20E4C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 12:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaCwk-0000A2-55; Fri, 11 Jul 2025 08:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uaCwe-000050-Q6
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 08:33:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uaCwY-0005Jm-SH
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 08:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752237206;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hbN2BdsccbwZLre1Ycit6b6TGOo3YENoILN0xCnAjBk=;
 b=YSrS/jYTRGRuXm9pDE2ZaLrFHP5Mk7++R8J+i72bSFv8cez97xGS/aUUW2w89pU+W7YUjI
 yBs00uPjbOb7Oooc72u/PRvWT0KWFXuKDpsUKc18TS/k39Y7nu3Up95/47PK2Jmq1YtpW5
 7/WRGKjlJmcMcgkdGo8Zo+kyD9X1YRE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-nm_7A1HeOh2C3RSt2Cnu5g-1; Fri, 11 Jul 2025 08:33:25 -0400
X-MC-Unique: nm_7A1HeOh2C3RSt2Cnu5g-1
X-Mimecast-MFC-AGG-ID: nm_7A1HeOh2C3RSt2Cnu5g_1752237204
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a58939191eso1076891f8f.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 05:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752237204; x=1752842004;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hbN2BdsccbwZLre1Ycit6b6TGOo3YENoILN0xCnAjBk=;
 b=co28J3vryevDjky7DZwRvXRZNVrl/HJumW/3+Fhj7TEkAT5tJ9/E59M4kg57mANB8C
 OPlv/XI7dPc5r+0mvyxht7o7wjlOCtqShneBtIT19LdvnZWqE558gGFOIY5aFc9ff0Z/
 XCfZXyq2vGaDgd8ibkOPUYPS8z8nU0EZdSJ7ttEAc2MBl6am4lCjlQHNhnTlsy5ALrdl
 iI24ZSVRjUzpiZOkbRQTU7yLxuodTftCv+3vmx+PN58jRwk6GXUGIxx3auH6Y6OK+4UR
 W6CfPr/vn1tF0rWLWIes75lbBRz7yohkcYpRjrvHAPb7lXi6lTwUOcGyHEvXK61q9ivI
 /qGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUagDLrj0IANYEMWvNeyFepmTGl+/A9hqW5a8diRVvkihNjWkdqe31KLMN1f/iWFtXZ9RBKkTe8gWaz@nongnu.org
X-Gm-Message-State: AOJu0YzTlmO9AoPE2mMn8SBY9ykf6QoZlq2h6qQevZycULKHiRRHFSKi
 2i9PBZDX+9lAauUA+MjY/xpvtQOkV1RN21JDr0tiL97vHRIgdID3WSVYhbEmeW6lqi/dIwKkBPq
 KJVdpha8FMcYv+Bm+lQdwYzBWRV1V+fbzFpPVFHqxmOmj83u6RqJBONF6
X-Gm-Gg: ASbGncsJFt88NPvSZjzzSchh60O3EVXskfsV3A8Ai4GgeZzxvo0MENJH2T84gxVtav2
 dm7dpHdNF139mzo1R0gLd5mtyG87iz99Xho25qj5pUALijNnGfjyL9gZ4A5KoFQuVmKQvu+AkVl
 BgR5ckQy9KzcK0oOmuGgB0gPJBytfbx8oebc/BHCkJkKxX5dW0YEdEiR+H2jsgAqbXg2O8QqHQR
 65ykhwkTOq9beBd0aOTgLpVzwbg5ceVQFkpTLe/pVFlpw7VHtydvMZ0Kv909sWAKDTGYG3NN1nN
 jiFrygf3heych4DZFoJi/Zpgp2vYh0+fgknxCbF1POl6e+MiS0zfZLdqUb4T3RF/B0ZVZtnSkIP
 9utZao9WPeSQ=
X-Received: by 2002:adf:9d8e:0:b0:3a4:dfc2:bb60 with SMTP id
 ffacd0b85a97d-3b5f189df70mr2833162f8f.26.1752237204146; 
 Fri, 11 Jul 2025 05:33:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKJYB7bbf61nne4kkkypi4BEqL8QMQSDG0VUizzJlfUq/jgqQKJORSTEyVeneI/gu9d50qjg==
X-Received: by 2002:adf:9d8e:0:b0:3a4:dfc2:bb60 with SMTP id
 ffacd0b85a97d-3b5f189df70mr2833120f8f.26.1752237203703; 
 Fri, 11 Jul 2025 05:33:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d77asm4436732f8f.58.2025.07.11.05.33.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jul 2025 05:33:22 -0700 (PDT)
Message-ID: <333016ec-f279-433e-8b1b-89647d68cb90@redhat.com>
Date: Fri, 11 Jul 2025 14:33:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 21/36] hw/arm/virt-acpi-build: Let non hotplug ports
 support static acpi-index
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, Jonathan.Cameron@huawei.com,
 gustavo.romero@linaro.org, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com, pbonzini@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
References: <20250708142437.1344644-1-eric.auger@redhat.com>
 <20250708142437.1344644-22-eric.auger@redhat.com>
 <20250711140335.7ba3c87c@fedora>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250711140335.7ba3c87c@fedora>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 7/11/25 2:03 PM, Igor Mammedov wrote:
> On Tue,  8 Jul 2025 16:23:03 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> hw/arm/virt-acpi-build: Let non hotplug ports support static acpi-index
>>
>> Add the requested ACPI bits requested to support static acpi-index
>> for non hotplug ports.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> ---
>>  hw/arm/virt-acpi-build.c | 12 ++++++++++++
>>  hw/arm/Kconfig           |  2 ++
>>  2 files changed, 14 insertions(+)
>>
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index a2f31be9ec..1f936516b3 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -34,6 +34,7 @@
>>  #include "hw/core/cpu.h"
>>  #include "hw/acpi/acpi-defs.h"
>>  #include "hw/acpi/acpi.h"
>> +#include "hw/acpi/pcihp.h"
>>  #include "hw/nvram/fw_cfg_acpi.h"
>>  #include "hw/acpi/bios-linker-loader.h"
>>  #include "hw/acpi/aml-build.h"
>> @@ -883,6 +884,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>      const int *irqmap = vms->irqmap;
>>      AcpiTable table = { .sig = "DSDT", .rev = 2, .oem_id = vms->oem_id,
>>                          .oem_table_id = vms->oem_table_id };
>> +    Aml *pci0_scope;
>>  
>>      acpi_table_begin(&table, table_data);
>>      dsdt = init_aml_allocator();
>> @@ -936,6 +938,16 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>  
>>      aml_append(dsdt, scope);
>>  
>> +    pci0_scope = aml_scope("\\_SB.PCI0");
>> +
>> +    aml_append(pci0_scope, build_pci_bridge_edsm());
>> +    build_append_pci_bus_devices(pci0_scope, vms->bus);
>> +    if (object_property_find(OBJECT(vms->bus), ACPI_PCIHP_PROP_BSEL)) {
>> +        build_append_pcihp_slots(pci0_scope, vms->bus);
>> +    }
> this part seems to be hotplug specific, is it really necessary in this patch?
Well I put this because it does not depend on
ACPI_PM_PROP_ACPI_PCIHP_BRIDGE GED property as opposed to the other
pieces added in [PATCH v6 23/36] hw/arm/virt-acpi-build: Modify the DSDT
ACPI table to enable ACPI PCI hotplug and rather depends on the bus

ACPI_PCIHP_PROP_BSEL property.

The initial comment was to move that code generation outside of the
ACPI_PM_PROP_ACPI_PCIHP_BRIDGE GED check. Thanks Eric
>
>> +
>> +    aml_append(dsdt, pci0_scope);
>> +
>>      /* copy AML table into ACPI tables blob */
>>      g_array_append_vals(table_data, dsdt->buf->data, dsdt->buf->len);
>>  
>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>> index 6ea86534d5..50153331ed 100644
>> --- a/hw/arm/Kconfig
>> +++ b/hw/arm/Kconfig
>> @@ -34,6 +34,8 @@ config ARM_VIRT
>>      select ACPI_HW_REDUCED
>>      select ACPI_APEI
>>      select ACPI_VIOT
>> +    select ACPI_PCIHP
>> +    select ACPI_PCI_BRIDGE
>>      select VIRTIO_MEM_SUPPORTED
>>      select ACPI_CXL
>>      select ACPI_HMAT


