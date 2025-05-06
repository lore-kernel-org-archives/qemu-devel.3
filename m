Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB04C3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 08:43:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCDtF-000332-G9; Tue, 06 May 2025 04:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uCDtD-00032e-Mg
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:42:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uCDtA-0006Bj-S9
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746520974;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VBFAHntS4UWdCABIPpBynhyDjXD83ntgx9qwo28tG1I=;
 b=VBK6BraGzXRRk79D+AasBz77GnbT9yXRoKO4JbFy+HvLXRuzdLhck3ewzbqLmdP3Z6K4pq
 UO62DoKmtbdWHcEqOQgQ9eIJ5IQ6BGCLdYWNIl7S8QPxdp/i7mXY8lFG72gtDUKbONcfIY
 YjfHHQkJp6z2uiQh/WBfvMv4MWZrev4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-93DAUQIjOiy8FTmNjrXOow-1; Tue, 06 May 2025 04:42:52 -0400
X-MC-Unique: 93DAUQIjOiy8FTmNjrXOow-1
X-Mimecast-MFC-AGG-ID: 93DAUQIjOiy8FTmNjrXOow_1746520971
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43ea256f039so41106785e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 01:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746520970; x=1747125770;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VBFAHntS4UWdCABIPpBynhyDjXD83ntgx9qwo28tG1I=;
 b=I/DklJ8cfis3qaUBQRW4eyqI6xt6IHmxeH+91uddjro/aCBmN3FBFMAEuXgdktECZG
 F/eMFzeo03mRMjRtD9hi5vQiOpriOc0WUkoliaRF9GAfIl/NVIj2FY3WPMh6J1Pn/f4P
 y9t3IZyya5W75UHF1Gn3PQaaAeFetzQjcMqRvcVTT+GlSvysj5UtZA3sxiaDEMPkABUI
 9ocE/zqyHRxQbyo1tTbz4f6kPFFJehXWIW+VeovZteTl11gAoOANkTTsZa1Yvhq31ij+
 eT/mLwRrWwBv5WQahjyFiWphRhn7y93zrF3EZz89QSrayE86iqAvpwg6TPsOpzB7oKQl
 s2Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEqEuOHLqt4C5dHkJtKSNYGeuWk2OctbvBeqIjoni8jkTfpfeZVVaJpHFpwhlRIIhWcmr5GNj6KuOg@nongnu.org
X-Gm-Message-State: AOJu0Yyp1+XqBs5wbt/ytT6XZYPoS565AygTga6St/vlMyYpLd/yJsEt
 YSCK54GdahtXZe1AJKHDFii7FBvp5erkxlLtNstF6EUrXRcHPsGylVu7j5a/E4vCvHdJfuRRrD/
 +24BP4Zz+0fgdSSDIw4R7rU9f35NflkQsB1lqQA+Xfw3paLgtGazC
X-Gm-Gg: ASbGncuImRf07Ys8tQgGQwa+hpLoNDKb+d1C2Ktjy0/qY2TNNtVdR/iGWFFYKUChTrn
 uv5aJ9wae0WP53ntndLUKj2PGvOI7SEp40HoNsuTj6RZ4xaehTZY9aG0Qmxga7Ee5y9qfz8PH8y
 7tZsM1Utg2SiO6P65qBAy9pqf1V0Dj62fZbFX6C7HdeG8Q0SPapuQvetRBgk4PkdqKSLvoPt6RY
 jDFqp1HS9GzYh15gHSBuHrON+d1GAiw05f94M3fSn5uOMAxSsDRjm6jGO9LJJCcWjX0oSR/1lmi
 tdjp4mjvunumioSv1enSiObxos35AzStqwe0VS841dv9bbA6k/HxGidk3Is=
X-Received: by 2002:a05:600c:4e42:b0:43c:ea1a:720c with SMTP id
 5b1f17b1804b1-441c48dc0bdmr83725075e9.18.1746520970711; 
 Tue, 06 May 2025 01:42:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOVj8RMDXNb80pJIK5P1XH+ZhVEPkaD+kk1y2Jt3832e+TMu/mERunkdOnbinLQpo7RTAE9Q==
X-Received: by 2002:a05:600c:4e42:b0:43c:ea1a:720c with SMTP id
 5b1f17b1804b1-441c48dc0bdmr83724685e9.18.1746520970339; 
 Tue, 06 May 2025 01:42:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2af32a0sm209759555e9.23.2025.05.06.01.42.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 01:42:48 -0700 (PDT)
Message-ID: <6708dd99-eda0-4b1f-99e6-46a7cdea36fd@redhat.com>
Date: Tue, 6 May 2025 10:42:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 07/24] hw/pci-host/gpex-acpi: Add native_pci_hotplug arg to
 acpi_dsdt_add_pci_osc
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com
References: <20250428102628.378046-1-eric.auger@redhat.com>
 <20250428102628.378046-8-eric.auger@redhat.com>
 <4bd4aa37-1edf-4660-b415-2b2c3c184e30@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <4bd4aa37-1edf-4660-b415-2b2c3c184e30@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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



On 5/6/25 2:13 AM, Gustavo Romero wrote:
> Hi Eric,
>
> On 4/28/25 07:25, Eric Auger wrote:
>> Add a new argument to acpi_dsdt_add_pci_osc to be able to disable
>> native pci hotplug.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>   hw/pci-host/gpex-acpi.c | 11 ++++++-----
>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
>> index e8b4c64c5f..4016089893 100644
>> --- a/hw/pci-host/gpex-acpi.c
>> +++ b/hw/pci-host/gpex-acpi.c
>> @@ -50,7 +50,7 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev,
>> uint32_t irq,
>>       }
>>   }
>>   -static void acpi_dsdt_add_pci_osc(Aml *dev)
>> +static void acpi_dsdt_add_pci_osc(Aml *dev, bool
>> enable_native_pcie_hotplug)
>>   {
>>       Aml *method, *UUID, *ifctx, *ifctx1, *elsectx, *buf;
>>   @@ -80,8 +80,9 @@ static void acpi_dsdt_add_pci_osc(Aml *dev)
>>        * Allow OS control for all 5 features:
>>        * PCIeHotplug SHPCHotplug PME AER PCIeCapability.
>
> This comment is no longer true for PCIeHotplug, which now can be
> controlled by the platform, and so needs to be updated, although
> it's going to go away in the series.

Sure, replaced by

+     * Allow OS control for SHPCHotplug, PME, AER, PCIeCapability,
+     * and PCIeHotplug depending on enable_native_pcie_hotplug

>  
> Otherwise:
>
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
thanks!

Eric
>
>
> Cheers,
> Gustavo
>
>>        */
>> -    aml_append(ifctx, aml_and(aml_name("CTRL"), aml_int(0x1F),
>> -                              aml_name("CTRL")));
>> +    aml_append(ifctx, aml_and(aml_name("CTRL"),
>> +               aml_int(0x1E | (enable_native_pcie_hotplug ? 0x1 :
>> 0x0)),
>> +               aml_name("CTRL")));
>>         ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
>>       aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x08),
>> @@ -192,7 +193,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct
>> GPEXConfig *cfg)
>>               if (is_cxl) {
>>                   build_cxl_osc_method(dev);
>>               } else {
>> -                acpi_dsdt_add_pci_osc(dev);
>> +                acpi_dsdt_add_pci_osc(dev, true);
>>               }
>>                 aml_append(scope, dev);
>> @@ -267,7 +268,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct
>> GPEXConfig *cfg)
>>       }
>>       aml_append(dev, aml_name_decl("_CRS", rbuf));
>>   -    acpi_dsdt_add_pci_osc(dev);
>> +    acpi_dsdt_add_pci_osc(dev, true);
>>         Aml *dev_res0 = aml_device("%s", "RES0");
>>       aml_append(dev_res0, aml_name_decl("_HID",
>> aml_string("PNP0C02")));
>


