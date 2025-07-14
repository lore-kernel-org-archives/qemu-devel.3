Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B417EC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 09:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubFLK-0002c1-BQ; Mon, 14 Jul 2025 05:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ubF4O-0002fQ-89
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:02:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ubF4K-0006NQ-QT
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752483710;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nFaq1jnbhSYzVZrfM5m9ezXDiNopu52/2FuXqVCFQlc=;
 b=Br4vYS3atsbnIbLWSAt1qPJgTCSxU9+r/aFZqgvB+QL/l93Tp3aj/ccv8ZSzOYwSvtvrDw
 RGhpZpXjdKUtoAh5vDxeq9YcEH/i9rhLpfMNmU18A/v3yrgUd6esqIfcF7uqPoWpaOosUt
 h4TQmKFxP6/NXzUHF78Oscp7oIEqiGs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-q7e2w7STMr22YV7NE4luWw-1; Mon, 14 Jul 2025 05:01:49 -0400
X-MC-Unique: q7e2w7STMr22YV7NE4luWw-1
X-Mimecast-MFC-AGG-ID: q7e2w7STMr22YV7NE4luWw_1752483708
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3b20f50da27so2426249f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 02:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752483708; x=1753088508;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nFaq1jnbhSYzVZrfM5m9ezXDiNopu52/2FuXqVCFQlc=;
 b=SQEBcWYJ7HIV2pcAv9z6acN9EzQ1FWxl6OGtGYdqfvImv8zGv98TWk2R+Ii/EQf4+E
 o+DdtalqcUQRJwa9T4/WouqsM9kMz0U/SE7nlBSMZ0JtPqHMd20wNYw0Ih+BJwaAMJm0
 ut9jsyVEi/WlLtxIbzLaIrig7semCvWhpjh314qhyS5sc8YNGDmQRrf1KHRW1zwDTqFN
 ke2Vkjna+MMvPjlb4mmDgEv7zYAfvQh0TgczYVCagTibWGunQyFZXSCyjHSDVlJS18nT
 yShzGBvtYOw+dPpaR5NMzHLOhH13IkQ+RvPoeKXTEn1dLpXMV9dIY67NRJUJvNm4wSSn
 7scw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXwuGWuVpFdbqNkgk/om1RtJWNRoLa1j6NI30MqlA5E8zycAIxqll7YV+5K7SwMpoAto+BVy5HSXN6@nongnu.org
X-Gm-Message-State: AOJu0YxsKnJc6prGNSdCN5LCx8RczQid2XoYTKK4Cw1JIGHY1hYqhV/D
 SUJZN0ep9/AQIHVhh6ntrlhf/gBdvfBx1SPi16CYXSXJFOQ7zpShZcD0eg1dOGXP3xjxu5H6WHc
 hL1LW7ZxN/XNVFDOUAd/N2sGxDxuIrdwqJMlmbOUfOH1ZlEBsZK/UQ+yy
X-Gm-Gg: ASbGnctt5xrdsjn6Bv4l3i7wHFKktF9NVHyY3Araz57LvKqE97gw65KO/d99w8vH6Xy
 0Yr3n93+yQO9TQ2D3ZhwmDslp37w1UZqHsHzykBDtk3nHpxSRxcYS6db6GnesvWcT+3K7SuckVE
 zhEXOWqKoIGhRDBGH7nyBbf7A4TL8dXnKa4O4wU4F/vPQ2ktqfak3aRBzM7VzlVw07p3l2wM/K7
 GjJjyj8InXdE1oY8OE3Ven0jbmWC90ip2G9ehy6/hhLoTUsVD7DgxHL1KOuE/+DDGKvF+46Z57v
 vI0ii3Bq0ev2d7ukGqrse5DbrzHNwsAmOkolQ9DRdWQqDzKafq9EXCn8HOqcKN5SIdUV+Vbt24S
 0KcK2XMvNiHY=
X-Received: by 2002:a05:6000:3c3:b0:3a4:f70e:bc25 with SMTP id
 ffacd0b85a97d-3b5f1e96113mr8073631f8f.27.1752483707949; 
 Mon, 14 Jul 2025 02:01:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjad1HidgGeo/GOxqn+CcbErkd7GdeTpjZRrUNAOU9TzBAEBee7SOfYOon8YuAmcPnzz1Mvw==
X-Received: by 2002:a05:6000:3c3:b0:3a4:f70e:bc25 with SMTP id
 ffacd0b85a97d-3b5f1e96113mr8073602f8f.27.1752483707394; 
 Mon, 14 Jul 2025 02:01:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc3a54sm12013884f8f.39.2025.07.14.02.01.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 02:01:46 -0700 (PDT)
Message-ID: <f2cfbc5c-9e7b-4ed9-8b17-80d4ec139914@redhat.com>
Date: Mon, 14 Jul 2025 11:01:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 34/36] tests/qtest/bios-tables-test: Add aarch64 ACPI
 PCI hotplug test
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, Jonathan.Cameron@huawei.com,
 gustavo.romero@linaro.org, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com, pbonzini@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
References: <20250708142437.1344644-1-eric.auger@redhat.com>
 <20250708142437.1344644-35-eric.auger@redhat.com>
 <20250711154701.0f394671@fedora>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250711154701.0f394671@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi Igor,

On 7/11/25 3:47 PM, Igor Mammedov wrote:
> On Tue,  8 Jul 2025 16:23:16 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> From: Gustavo Romero <gustavo.romero@linaro.org>
>>
>> Add 2 new tests:
>> - test_acpi_aarch64_virt_acpi_pci_hotplug tests the acpi pci hotplug
>>   using -global acpi-ged.acpi-pci-hotplug-with-bridge-support=on
>> - test_acpi_aarch64_virt_pcie_root_port_hpoff tests static-acpi index
>>   on a root port with disabled hotplug
> tests a bit simple, I wonder if we could reuse related x86 variants
> for that (as those test a bit more corner cases with a more complicated
> topology).
> It's not a blocker and doing this of cause can be done on top.

Sure I will work on that on top of this series.

Thanks

Eric
>  
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>>
>> ---
>> v3 -> v4:
>> - add -device pci-testdev for the first test case
>> - fix the chassis
>> - add a test for static acpi-index
>> ---
>>  tests/qtest/bios-tables-test.c | 52 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 52 insertions(+)
>>
>> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
>> index 357bcefd37..1074b8d67a 100644
>> --- a/tests/qtest/bios-tables-test.c
>> +++ b/tests/qtest/bios-tables-test.c
>> @@ -1643,6 +1643,54 @@ static void test_acpi_aarch64_virt_tcg_memhp(void)
>>  
>>  }
>>  
>> +static void test_acpi_aarch64_virt_acpi_pci_hotplug(void)
>> +{
>> +    test_data data = {
>> +        .machine = "virt",
>> +        .arch = "aarch64",
>> +        .tcg_only = true,
>> +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
>> +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
>> +        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
>> +        .ram_start = 0x40000000ULL,
>> +        .scan_len = 256ULL * MiB,
>> +        .variant = ".acpipcihp",
>> +    };
>> +
>> +   /* Use ACPI PCI Hotplug */
>> +   test_acpi_one(" -global acpi-ged.acpi-pci-hotplug-with-bridge-support=on"
>> +                 " -cpu cortex-a57"
>> +                 " -device pcie-root-port,id=pcie.1,bus=pcie.0,chassis=0,slot=1,addr=7.0"
>> +                 " -device pci-testdev,bus=pcie.1",
>> +                 &data);
>> +
>> +    free_test_data(&data);
>> +}
>> +
>> +static void test_acpi_aarch64_virt_pcie_root_port_hpoff(void)
>> +{
>> +    test_data data = {
>> +        .machine = "virt",
>> +        .arch = "aarch64",
>> +        .tcg_only = true,
>> +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
>> +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
>> +        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
>> +        .ram_start = 0x40000000ULL,
>> +        .scan_len = 256ULL * MiB,
>> +        .variant = ".hpoffacpiindex",
>> +    };
>> +
>> +   /* turn hotplug off on the pcie-root-port and use static acpi-index*/
>> +   test_acpi_one(" -device pcie-root-port,id=pcie.1,chassis=0,"
>> +                                          "slot=1,hotplug=off,addr=7.0"
>> +                 " -device pci-testdev,bus=pcie.1,acpi-index=12"
>> +                 " -cpu cortex-a57",
>> +                 &data);
>> +
>> +    free_test_data(&data);
>> +}
>> +
>>  static void test_acpi_microvm_prepare(test_data *data)
>>  {
>>      data->machine = "microvm";
>> @@ -2602,6 +2650,10 @@ int main(int argc, char *argv[])
>>              qtest_add_func("acpi/virt/numamem",
>>                             test_acpi_aarch64_virt_tcg_numamem);
>>              qtest_add_func("acpi/virt/memhp", test_acpi_aarch64_virt_tcg_memhp);
>> +            qtest_add_func("acpi/virt/acpipcihp",
>> +                           test_acpi_aarch64_virt_acpi_pci_hotplug);
>> +            qtest_add_func("acpi/virt/hpoffacpiindex",
>> +                          test_acpi_aarch64_virt_pcie_root_port_hpoff);
>>              qtest_add_func("acpi/virt/pxb", test_acpi_aarch64_virt_tcg_pxb);
>>              qtest_add_func("acpi/virt/oem-fields",
>>                             test_acpi_aarch64_virt_oem_fields);


