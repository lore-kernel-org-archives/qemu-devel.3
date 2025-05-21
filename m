Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B58EC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 16:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHm3k-0007de-Rs; Wed, 21 May 2025 12:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uHm3j-0007d7-5M
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:12:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uHm3f-00023b-2o
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747843960;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XLF/+N32Jite/7MDBsWdP7VLLcDPcqAq9wogQc5MyqU=;
 b=fe6ctA9zgpbIjpjvdiuZ1xym4KQdAj4GKv1FYRwmTnt3Wpvj9INlATOCaVGBpjJ+TQjpOu
 LsBm5pUb58G9aHV2xZuLWPVxX5lm56VZ6ANiicX7HWrfFQ1Pc8GsADO9Rxv0w4wF6YtRXv
 aVsQtxOjowXcTrujYQFHxx5v/J6RKC0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-vFoYl5q9Pzem65qyS36J5Q-1; Wed, 21 May 2025 12:12:39 -0400
X-MC-Unique: vFoYl5q9Pzem65qyS36J5Q-1
X-Mimecast-MFC-AGG-ID: vFoYl5q9Pzem65qyS36J5Q_1747843958
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43e9b0fd00cso35858995e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 09:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747843958; x=1748448758;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XLF/+N32Jite/7MDBsWdP7VLLcDPcqAq9wogQc5MyqU=;
 b=SoGhk6PlsOaQY8i5OWm7QyS0gU7UyDvBb3cf7uGiZROsDRrHEXFYVGU1rAXK+47M7/
 XVF44ZZeS6HALNhTt16bM8W7unNtxMiGcpqC6bMN24vnC42EfecQczYoZLcjSDqSYJdH
 VnOsyEuoV/Ud2btnP2SsW5fmPwccjHPnTbPS45/He2RXBKl19pTZj+rC0e/1MMTYtXPU
 SmPfT0hC/T2R8Fl7g/zdud9bCK6sc2lidU3HauBld/hW5vKu5a/3gmY03ZKDxZylUhiG
 vjOs4OHpjA6I4bA5Idvjld26YAprI/Z1r9yt/jtMJ4DXRQX+HNyt8rbSsh2/I6CZZxLO
 bTSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMnYpN2kedM4IatnM3DVLuI6hjzAsTy6ss2xtcXeyzWAJ4tSx/X+Ra8quFqqzNqdvHG2o4uLiOCraQ@nongnu.org
X-Gm-Message-State: AOJu0YyG7i83w7pIHmeA8sUlfffkrlHzG4nXaszaGgL02xkheKeH/zkI
 nkvbg+6C+MDYBzXV798gk+RMyMkiiPBWoGIogAcNgmjnY3e5KZFwEfTxTvkjcodJhGDZ74MM/eT
 znTksp5OvlJYKrBtrIyqj6rlIo8X8XdFCgDLNV42d95e/cHnl86pLXfzT
X-Gm-Gg: ASbGnct582dcWgqS85TgGy90KP5zjwg9Ax5RoDuxxSGO7SnKLQQDY0Z6EczsObHZcVn
 XzpGPQRYPvx6DY2N/AZ1128HYtS7zWAJC+avUHDtCKp9wW1kG+cIl21g/2epG+jESM9FRtHbn7f
 2q7Jt8IaqbxWqWYz0wRmryyPkyBuVTm0eBJhLybdcPdcxj7I2CSoXZRb0wQBRnI1ULow9fhcHYw
 DlZZR+QsL/SAo7uHBhFE+2cZl6URg+ABdofRw1SPO8hgH3qBJW3iqNCOCrxnQhOKkHWBFbeNiqQ
 /9DfwogiBz5CN/xBH0Y0UL2ErKlXeCdEV1C4xf1az8Q7VCiruVdA9hzSD8s=
X-Received: by 2002:a05:600c:3507:b0:43c:f509:2bbf with SMTP id
 5b1f17b1804b1-442f8524653mr270263455e9.15.1747843957986; 
 Wed, 21 May 2025 09:12:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEecopBxLwhMgU1y5yiQeRyDBhSBr7iujJ3pTwhu4Fh/q52UEbCzjGYBWi6vTzzbQFSolOBlw==
X-Received: by 2002:a05:600c:3507:b0:43c:f509:2bbf with SMTP id
 5b1f17b1804b1-442f8524653mr270263045e9.15.1747843957574; 
 Wed, 21 May 2025 09:12:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442eb85a3b1sm189915935e9.0.2025.05.21.09.12.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 09:12:35 -0700 (PDT)
Message-ID: <ed823ddc-6faa-42dc-bae5-c765d21c3cca@redhat.com>
Date: Wed, 21 May 2025 18:12:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/22] hw/pci-host/gpex-acpi: Use
 build_pci_host_bridge_osc_method
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org
References: <20250514170431.2786231-1-eric.auger@redhat.com>
 <20250514170431.2786231-9-eric.auger@redhat.com>
 <e1ec0e15-ad26-456b-a8d7-16f683290651@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <e1ec0e15-ad26-456b-a8d7-16f683290651@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Gustavo,

On 5/20/25 4:09 PM, Gustavo Romero wrote:
> Hi Eric,
>
> On 5/14/25 14:00, Eric Auger wrote:
>> gpex build_host_bridge_osc() and x86 originated
>> build_pci_host_bridge_osc_method() are mostly identical.
>>
>> In GPEX, SUPP is set to CDW2 but is not further used. CTRL
>> is same as Local0.
>>
>> So let gpex code reuse build_pci_host_bridge_osc_method()
>> and remove build_host_bridge_osc().
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> The DSDT diff  is given below:
>> diff --git a/dsdt.dsl_before b/dsdt.dsl_after_osc_change
>> index 3224a56..fa7558e 100644
>> --- a/dsdt.dsl_before
>> +++ b/dsdt.dsl_after_osc_change
>> @@ -5,13 +5,13 @@
>>    *
>>    * Disassembling to symbolic ASL+ operators
>>    *
>> - * Disassembly of dsdt.dat, Mon Apr  7 05:33:06 2025
>> + * Disassembly of dsdt.dat, Mon Apr  7 05:37:20 2025
>>    *
>>    * Original Table Header:
>>    *     Signature        "DSDT"
>> - *     Length           0x00001A4F (6735)
>> + *     Length           0x00001A35 (6709)
>>    *     Revision         0x02
>> - *     Checksum         0xBF
>> + *     Checksum         0xDD
>>    *     OEM ID           "BOCHS "
>>    *     OEM Table ID     "BXPC    "
>>    *     OEM Revision     0x00000001 (1)
>> @@ -1849,27 +1849,26 @@ DefinitionBlock ("", "DSDT", 2, "BOCHS ",
>> "BXPC    ", 0x00000001)
>>                   {
>>                       CreateDWordField (Arg3, 0x04, CDW2)
>>                       CreateDWordField (Arg3, 0x08, CDW3)
>> -                    SUPP = CDW2 /* \_SB_.PCI0._OSC.CDW2 */
>> -                    CTRL = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
>> -                    CTRL &= 0x1F
>> +                    Local0 = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
>> +                    Local0 &= 0x1F
>>                       If ((Arg1 != One))
>>                       {
>>                           CDW1 |= 0x08
>>                       }
>>
>> -                    If ((CDW3 != CTRL))
>> +                    If ((CDW3 != Local0))
>>                       {
>>                           CDW1 |= 0x10
>>                       }
>>
>> -                    CDW3 = CTRL /* \_SB_.PCI0.CTRL */
>> -                    Return (Arg3)
>> +                    CDW3 = Local0
>>                   }
>>                   Else
>>                   {
>>                       CDW1 |= 0x04
>> -                    Return (Arg3)
>>                   }
>> +
>> +                Return (Arg3)
>>               }
>>
>>               Method (_DSM, 4, NotSerialized)  // _DSM:
>> Device-Specific Method
>
> The problem I face with diffs in the commit body is that tools like
> b4, which are
> based on git am, get very confused on how to handle it. I'm surprised
> nobody ever
> complained about it. I'm wondering if there is any catch on it,
> because I have to
> edit commits like this manually, removing the diff, to make it finally
> apply to
> the series. Anyways, do you mind at least removing the valid diff
> header, like:
>
>> diff --git a/dsdt.dsl_before b/dsdt.dsl_after_osc_change
>> index 3224a56..fa7558e 100644
>> --- a/dsdt.dsl_before
>> +++ b/dsdt.dsl_after_osc_change
>
> from the commit message so it doesn't confuse b4?
Thank you for reporting the issue. in tests/qtest/bios-tables-test.c it
is written at the top that we shall put the diffs in disasembled ACPI
content in the commit msg. I will look for previously landed patches and
see whether the current layout can be fixed.

Cheers

Eric
>
>
>> ---
>>   hw/pci-host/gpex-acpi.c | 60 +++--------------------------------------
>>   1 file changed, 4 insertions(+), 56 deletions(-)
>>
>> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
>> index f1ab30f3d5..98c9868c3f 100644
>> --- a/hw/pci-host/gpex-acpi.c
>> +++ b/hw/pci-host/gpex-acpi.c
>> @@ -50,60 +50,7 @@ static void acpi_dsdt_add_pci_route_table(Aml
>> *dev, uint32_t irq,
>>       }
>>   }
>>   -static Aml *build_host_bridge_osc(bool enable_native_pcie_hotplug)
>> -{
>> -    Aml *method, *UUID, *ifctx, *ifctx1, *elsectx;
>> -
>> -    method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
>> -    aml_append(method,
>> -        aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
>> -
>> -    /* PCI Firmware Specification 3.0
>> -     * 4.5.1. _OSC Interface for PCI Host Bridge Devices
>> -     * The _OSC interface for a PCI/PCI-X/PCI Express hierarchy is
>> -     * identified by the Universal Unique IDentifier (UUID)
>> -     * 33DB4D5B-1FF7-401C-9657-7441C03DD766
>> -     */
>> -    UUID = aml_touuid("33DB4D5B-1FF7-401C-9657-7441C03DD766");
>> -    ifctx = aml_if(aml_equal(aml_arg(0), UUID));
>> -    aml_append(ifctx,
>> -        aml_create_dword_field(aml_arg(3), aml_int(4), "CDW2"));
>> -    aml_append(ifctx,
>> -        aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
>> -    aml_append(ifctx, aml_store(aml_name("CDW2"), aml_name("SUPP")));
>> -    aml_append(ifctx, aml_store(aml_name("CDW3"), aml_name("CTRL")));
>> -
>> -    /*
>> -     * Allow OS control for SHPCHotplug, PME, AER, PCIeCapability,
>> -     * and PCIeHotplug depending on enable_native_pcie_hotplug
>> -     */
>> -    aml_append(ifctx, aml_and(aml_name("CTRL"),
>> -               aml_int(0x1E | (enable_native_pcie_hotplug ? 0x1 :
>> 0x0)),
>> -               aml_name("CTRL")));
>> -
>> -    ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
>> -    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x08),
>> -                              aml_name("CDW1")));
>> -    aml_append(ifctx, ifctx1);
>> -
>> -    ifctx1 = aml_if(aml_lnot(aml_equal(aml_name("CDW3"),
>> aml_name("CTRL"))));
>> -    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x10),
>> -                              aml_name("CDW1")));
>> -    aml_append(ifctx, ifctx1);
>> -
>> -    aml_append(ifctx, aml_store(aml_name("CTRL"), aml_name("CDW3")));
>> -    aml_append(ifctx, aml_return(aml_arg(3)));
>> -    aml_append(method, ifctx);
>> -
>> -    elsectx = aml_else();
>> -    aml_append(elsectx, aml_or(aml_name("CDW1"), aml_int(4),
>> -                               aml_name("CDW1")));
>> -    aml_append(elsectx, aml_return(aml_arg(3)));
>> -    aml_append(method, elsectx);
>> -    return method;
>> -}
>> -
>> -static Aml *build_host_bridge_dsm(void)
>> +static Aml *build_pci_host_bridge_dsm_method(void)
>>   {
>>       Aml *method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
>>       Aml *UUID, *ifctx, *ifctx1, *buf;
>> @@ -134,8 +81,9 @@ static void acpi_dsdt_add_host_bridge_methods(Aml
>> *dev,
>>       aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
>>       aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
>>       /* Declare an _OSC (OS Control Handoff) method */
>> -    aml_append(dev, build_host_bridge_osc(enable_native_pcie_hotplug));
>> -    aml_append(dev, build_host_bridge_dsm());
>> +    aml_append(dev,
>> +              
>> build_pci_host_bridge_osc_method(enable_native_pcie_hotplug));
>> +    aml_append(dev, build_pci_host_bridge_dsm_method());
>>   }
>>     void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>
> Otherwise:
>
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
>
>
> Cheers,
> Gustavo
>


