Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430F9C71134
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 12:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPKCu-0004BT-BG; Wed, 11 Jun 2025 08:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uPKCj-0004A2-Ph
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:05:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uPKCc-0005Ja-VX
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749643507;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZTOi8eNcnBD9S4r3sPmmoIhTe+QERnirZ7HtVLzvHGM=;
 b=HINyahOXl0bJiKt3vxY9l34GyHkFmvY0UbVEu/1/RizkvRNdkN6BZoVNBYnk9tkarH5zCf
 OuYJSoQ8AdC7AebF4+93enzYMGtCrWAnyU9KcL3l2QoA4XL8caZNBPKu161QlmPCtYW5W9
 n5NhY9OgWXEUD/MEkOlvfb0Jj7obFEk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-tUR_7hk2PDed30adCeFgnQ-1; Wed, 11 Jun 2025 08:05:05 -0400
X-MC-Unique: tUR_7hk2PDed30adCeFgnQ-1
X-Mimecast-MFC-AGG-ID: tUR_7hk2PDed30adCeFgnQ_1749643504
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-451d5600a54so49903605e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 05:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749643504; x=1750248304;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZTOi8eNcnBD9S4r3sPmmoIhTe+QERnirZ7HtVLzvHGM=;
 b=bq7Wj8UWezqyJAhiEMtWHbeqSqu6vUmihG4il065lqCj0V5Rm3ekDnlo5MSWMLgodb
 nmpc1trz1ILRlqokBB8+/d0mz7MpyMVmTrs+v54RAt+x/U+5Oc6f1wODmS7FSKq39b4S
 VzmaurK3KlQekXDNQfCQZXbAOXrp+L3EmzdhIAbgybyd9SlTUqIH0nONr0ZSgbBXUQfU
 qM4tBXxyG6S/IfK3ssfWxfrm/Rn/lW9OVi5aUbMeSsdQiitYkfoMTK4QhZDD2d+hK3YZ
 PoKjOy+Z/vSoyYBNt2LAyUe4EWfjeBLiDMbOSfIkj2PBn9DCulQKGkezr3U4TZA5gueU
 eOSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXodjUu0gh4Z2Gb19J/5Kfw2yAVAaJb07EkCZ6yoLSBmlm9alhJAWaidRxViI6Cez3AmGBnoOCG2yLC@nongnu.org
X-Gm-Message-State: AOJu0YzHBDaO+vsondsmUm7wf3AK5IwslvzH5ku4zrZw9d/wDTSoHqLs
 v7i9z+AbANptBKl7hbwycSdkWEYl6JpyGpYMkZH3Pm6O/PR24wKl4ouMuzRuyMn7SKiTbYtCNO6
 cwdDlDqp89ThaFmayQgDipyABTU2mwvvRZm5BQs2wJ0HlpjjQ3MKt4Zrk
X-Gm-Gg: ASbGnctqC2izZRu1EJeoi1VKbz4qVPjqtUo/KDv+mrRhagkRGqKdFS6Tf5c6Fd2YZSk
 3o99nOWNx5jCkTOZ+y07SQLhfdt9/BqoEklEKr6eofXbN8JaFmn+1mKMSzbcpajvnttga5zpytV
 Hh/ARmoQ2DGroI2WJXa3iYPVBMk5jWYVZBLK+/L3Bcv//9MU17smaZThO/kgfIU7zuXwzclYKtF
 99PleKiDJDEKs8NypDK74YTW4b4RDpZZZz9uMsVTugUPoGVdLZiU5LRwBTmQySHyWC2N/n9x30v
 VkVG7twMM2S/XdK3NnMfWDPUNHEzSEn2KvO2wZa6pGSgh1QJmMplNMZVjm5e0TUURbCkeg==
X-Received: by 2002:a05:600c:3d13:b0:450:ddb7:ee4d with SMTP id
 5b1f17b1804b1-453248cb4c2mr25727735e9.24.1749643504203; 
 Wed, 11 Jun 2025 05:05:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk+kCbT/QHiqWq2EZRPVw9vTyApQ4hSO/FQ1+cakznEUg6vRAEv7qIvE7v9ow3oZpHQBx8+Q==
X-Received: by 2002:a05:600c:3d13:b0:450:ddb7:ee4d with SMTP id
 5b1f17b1804b1-453248cb4c2mr25726945e9.24.1749643503404; 
 Wed, 11 Jun 2025 05:05:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244f0cbsm14987328f8f.81.2025.06.11.05.05.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 05:05:02 -0700 (PDT)
Message-ID: <bc4fdea5-4e19-420e-a5a0-779ec5fbb6a2@redhat.com>
Date: Wed, 11 Jun 2025 14:05:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/25] hw/pci-host/gpex-acpi: Add native_pci_hotplug
 arg to acpi_dsdt_add_pci_osc
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, imammedo@redhat.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com,
 pbonzini@redhat.com, philmd@linaro.org, alex.bennee@linaro.org
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-5-eric.auger@redhat.com>
 <20250530102711.000034eb@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250530102711.000034eb@huawei.com>
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

On 5/30/25 11:27 AM, Jonathan Cameron wrote:
> On Tue, 27 May 2025 09:40:06 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> Add a new argument to acpi_dsdt_add_pci_osc to be able to disable
>> native pci hotplug.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
> Hi Eric,
>
> Makes me wonder what we should do for CXL - I was expecting
> a very similar change.  Currently seems like those always
> allow native hotplug (__build_cxl_osc_method()) on x86 and
> arm64 (patches on list).
>
> Maybe that has only been working because the kernel is reading
> the PCI _OSC first. Or it's always been doing native hotplug
> an no one noticed.  A quick look at logs shows the kernel
> first gets told no, then yes as it queries the two different
> _OSC types. 
>
> Looks like I should fix that _OSC then it should be carried
> over to this as well (or if you don't mind adding a trivial
> patch to replicate this  patch for the CXL _OSC, even better!)

If you don't mind I would prefer we carry out cxl changes separately as
it may also require some test blob changes and I am not much
knowledgable on CXL yet. I would prefer stabilizing this series before
extending it.

But sure if it is relevant we can then mimic that change on cxl path.

Eric
>
> Other than that, this patch looks fine to me though I do wonder
> if we could unify this with build_q35_osc_method()?
> I'm not the best at reading AML generation code but whilst
> they are written quite differently they seem to be functionally
> very similar, more so after this patch.
>
>> ---
>>
>> rfc -> v1:
>> - updated the "Allow OS control for all 5 features" comment
>> ---
>>  hw/pci-host/gpex-acpi.c | 15 ++++++++-------
>>  1 file changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
>> index 0aba47c71c..f34b7cf25e 100644
>> --- a/hw/pci-host/gpex-acpi.c
>> +++ b/hw/pci-host/gpex-acpi.c
>> @@ -50,7 +50,7 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
>>      }
>>  }
>>  
>> -static void acpi_dsdt_add_pci_osc(Aml *dev)
>> +static void acpi_dsdt_add_pci_osc(Aml *dev, bool enable_native_pcie_hotplug)
>>  {
>>      Aml *method, *UUID, *ifctx, *ifctx1, *elsectx, *buf;
>>  
>> @@ -77,11 +77,12 @@ static void acpi_dsdt_add_pci_osc(Aml *dev)
>>      aml_append(ifctx, aml_store(aml_name("CDW3"), aml_name("CTRL")));
>>  
>>      /*
>> -     * Allow OS control for all 5 features:
>> -     * PCIeHotplug SHPCHotplug PME AER PCIeCapability.
>> +     * Allow OS control for SHPCHotplug, PME, AER, PCIeCapability,
>> +     * and PCIeHotplug depending on enable_native_pcie_hotplug
>>       */
>> -    aml_append(ifctx, aml_and(aml_name("CTRL"), aml_int(0x1F),
>> -                              aml_name("CTRL")));
>> +    aml_append(ifctx, aml_and(aml_name("CTRL"),
>> +               aml_int(0x1E | (enable_native_pcie_hotplug ? 0x1 : 0x0)),
>> +               aml_name("CTRL")));
>>  
>>      ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
>>      aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x08),
>> @@ -192,7 +193,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>>              if (is_cxl) {
>>                  build_cxl_osc_method(dev);
> This was the path I was expecting to change as well.
>
>>              } else {
>> -                acpi_dsdt_add_pci_osc(dev);
>> +                acpi_dsdt_add_pci_osc(dev, true);
>>              }
>>  
>>              aml_append(scope, dev);
>> @@ -267,7 +268,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>>      }
>>      aml_append(dev, aml_name_decl("_CRS", rbuf));
>>  
>> -    acpi_dsdt_add_pci_osc(dev);
>> +    acpi_dsdt_add_pci_osc(dev, true);
>>  
>>      Aml *dev_res0 = aml_device("%s", "RES0");
>>      aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));


