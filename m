Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE12BC61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 09:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPHJr-0000lr-7N; Wed, 11 Jun 2025 05:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uPHJd-0000ke-98
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 05:00:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uPHJb-0006Pe-7z
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 05:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749632410;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+MHfoli/1u5+jXUbahISFH6LvKqHhzM56wbkbSnXS2s=;
 b=LqtbPLwal19vqfvnsr16h1umxqpIJVp8RLWZPdpf3rjvAIHRytIJR5KYthtYykJsq922cg
 EQmpNyIJCCxkDZCLoKHaz9XVzAkU+f1rZiUgoae+hjOIVis2bQWugyFgLzKEAeT/3KNxYp
 fcHLERQtBOKqH5PNOszZp3LndfpetmQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-94SBpK3zMiOzGOl4Jihq0A-1; Wed, 11 Jun 2025 05:00:06 -0400
X-MC-Unique: 94SBpK3zMiOzGOl4Jihq0A-1
X-Mimecast-MFC-AGG-ID: 94SBpK3zMiOzGOl4Jihq0A_1749632405
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a54a8a0122so1357568f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 02:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749632405; x=1750237205;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+MHfoli/1u5+jXUbahISFH6LvKqHhzM56wbkbSnXS2s=;
 b=bPdld1QcFbNwqwpb/B4lw4DEgCTlHH5IGibZl32D9gf/zVLyIld6xqDvUeGoPMHoSb
 b1cXgUAjybUycqAkfu9U6H/uNYNnKmNHI0HLo9v8P1FS5QeBB30KbL4WT5ITUksN1cxv
 2clr0jFQYH7Ki4PR8w8RHjNP1IHgpsC5P9+XG3ebzAzbnSmeVe7AC44uaTMMYsKKgiDy
 hd9awTQScLdTIQHM1TtRw5YSdcljXvXe/Mp6XzWiE0TaTYluc42AnfUlucGpxRD7CVOh
 bvBUCEdSlCu+C+AiG/WJbGLVxENXrNMChFNUNYBFD/QxtG7CdF0Z6b3yImTjnTdrRnpj
 iUeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6JthycPZFiqG+jM5tN/j5WBxA1wniGzlgw0+DEvZROl50NJiVCNx9OvfBfsXIWbuxV7Hdi5377LWd@nongnu.org
X-Gm-Message-State: AOJu0YzmOXS1kOlgmv7mu0dpV50/Fbu85O5O4HkLKbN4x7JJSa1qAmnF
 zXY5fDYf9NXGR5Q85kZDhQFuKYvO5Bv+oY6A5ou11ssTnfuLmJjWnZ1DxFrm5XzNXfCzg+u3TsL
 3NyIsQx1+sh7707XRTWvmQGKSobymoj0oZSKkB5MeeiYnMrV+M6qHQl5j
X-Gm-Gg: ASbGncsPUgs36HQZ/RM6nmjypQW6XpVGbL+CGdXqlEr7AqcJF0t2yAjvktFzCCvHzzR
 7THSyxZdSfqC2BjOUgBqVgHMn/wl9Q3Tn4udkz9YFsvH7GeBTM093kwec5iqCaIoyNwfqvEanrO
 MZPnFZEx9+i9BJNL5cxkXIT+/gJnD+UG6rQGjPb9Gn1Z3n9kPkA65pa5gHSGpHo7uX4P6htDrD2
 GtGAFKQgRrX+36y0eq2SlW1omt8tvrM8Q1yB9eSdMGz2W71PKmqYYAZvreY+FFvbxnRrpc9TNoP
 qk3olal1DNj+6LDc5C8o9bBs9h5xzb0SpH0Vvw8XNUdqvUeOE0k2aqLtXMStMg+ZA4fb/w==
X-Received: by 2002:a05:6000:2210:b0:3a4:f55a:4ae2 with SMTP id
 ffacd0b85a97d-3a558ae65d0mr1796262f8f.50.1749632405471; 
 Wed, 11 Jun 2025 02:00:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNxUikALfyeeUuRHhuogt1vJpftckSkBEuxx/D+s4T3k0gxvomnDeQdlC23YEXGMABhpUd4g==
X-Received: by 2002:a05:6000:2210:b0:3a4:f55a:4ae2 with SMTP id
 ffacd0b85a97d-3a558ae65d0mr1796204f8f.50.1749632404984; 
 Wed, 11 Jun 2025 02:00:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244df34sm14860062f8f.71.2025.06.11.02.00.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 02:00:04 -0700 (PDT)
Message-ID: <72c84565-3879-4c08-a73c-15bc5543ee2b@redhat.com>
Date: Wed, 11 Jun 2025 11:00:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/25] hw/pci-host/gpex-acpi: Propagate hotplug type
 info from virt machine downto gpex
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-7-eric.auger@redhat.com>
 <20250527143301.77f5bfd1@imammedo.users.ipa.redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250527143301.77f5bfd1@imammedo.users.ipa.redhat.com>
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

On 5/27/25 2:33 PM, Igor Mammedov wrote:
> On Tue, 27 May 2025 09:40:08 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> Propagate the type of pci hotplug mode downto the gpex
>> acpi code. In case machine acpi_pcihp is unset we configure
>> pci native hotplug on pci0. For expander bridges we keep
>> legacy pci native hotplug, as done on x86 q35.
> this is not needed if done as suggested in 2/25
So since the property would be applied to the GED device we will still
need a patch that retrieves the GED setting and propagate it to the GPEX
device.

Thanks

Eric
>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>  include/hw/pci-host/gpex.h | 1 +
>>  hw/arm/virt-acpi-build.c   | 1 +
>>  hw/pci-host/gpex-acpi.c    | 3 ++-
>>  3 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
>> index 84471533af..feaf827474 100644
>> --- a/include/hw/pci-host/gpex.h
>> +++ b/include/hw/pci-host/gpex.h
>> @@ -45,6 +45,7 @@ struct GPEXConfig {
>>      MemMapEntry pio;
>>      int         irq;
>>      PCIBus      *bus;
>> +    bool        pci_native_hotplug;
>>  };
>>  
>>  typedef struct GPEXIrq GPEXIrq;
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 7e8e0f0298..be5e00a56e 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -129,6 +129,7 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
>>          .ecam   = memmap[ecam_id],
>>          .irq    = irq,
>>          .bus    = vms->bus,
>> +        .pci_native_hotplug = !vms->acpi_pcihp,
>>      };
>>  
>>      if (vms->highmem_mmio) {
>> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
>> index 1aa2d12026..f1ab30f3d5 100644
>> --- a/hw/pci-host/gpex-acpi.c
>> +++ b/hw/pci-host/gpex-acpi.c
>> @@ -204,6 +204,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>>              if (is_cxl) {
>>                  build_cxl_osc_method(dev);
>>              } else {
>> +                /* pxb bridges do not have ACPI PCI Hot-plug enabled */
>>                  acpi_dsdt_add_host_bridge_methods(dev, true);
>>              }
>>  
>> @@ -279,7 +280,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>>      }
>>      aml_append(dev, aml_name_decl("_CRS", rbuf));
>>  
>> -    acpi_dsdt_add_host_bridge_methods(dev, true);
>> +    acpi_dsdt_add_host_bridge_methods(dev, cfg->pci_native_hotplug);
>>  
>>      Aml *dev_res0 = aml_device("%s", "RES0");
>>      aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));
>


