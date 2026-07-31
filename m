Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE93C5516D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 12:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpmV7-0000Pw-GJ; Fri, 31 Jul 2026 08:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wpmV4-0000PX-RE
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:38:07 -0400
Received: from mail-centralusazon11011017.outbound.protection.outlook.com
 ([52.101.62.17] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wpmV2-00017k-UZ
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:38:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBnzDwNem+dq5MdrySZSoHITvscLCb45H7tHx06T/ol1QsTQDkBcxLxUYGsFnGOumr94NmKn83XTctId4sLKweQlhKXlRKbOyGHZVVi4tsy5AblW5nTCUvoaqydzvlbm0N2nDEs6XKZYRkv51hb+6pV+CZOItUD0ldjJoPsGNNfIDfNYwh+kw+CR6/3RS0WupCpYv6jiruUj/I3Vc3qGUAIcsi/q4EkH86BbfOON0br/QeyPt1NZkWJ0N/Xj8ZiqXT6QBsjLVdqnd+/BBhm6h2KU/Yp3iEX+GyYwI2oeaN/rV1P7jOGiTQENE1Z4hwPWBEwnZWRe34qOrr+fjBqCGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mv4BkR3eYoNhJ848I4xQWyV0T0ovNat2qkt2+z8VHXA=;
 b=B5c9rlmZV3G3ueIDG9jltjW5TInkPMnBegIeiTUWbW+OgZfk6/UfhMukF5k8HwyWAy/FRtp0L6iRmysubsuNHTKCgtVUrxHFqVCgtCuhpwIPbBW9lrjSWkHj5+GwrBOh72jmjz6f6DQXCF7tdaY4qJtK2itT9Ta1EqzHksW6WmiTbCWoDi85RS3tI8iqTKzual/iyf+hGg8s5bjac2Q/Luh6NaspMm9v169c5pyi5PN+4H9WGHWwtWUYsFm7Wg2z4j1JhgRoMEN5qc+Cdaqq7ExBvLZLQ9gcc4BoYQGMjLQhcBDmjvFmDptWv5K2CFXR58Hz6u6JWcsKAywEYcZkpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mv4BkR3eYoNhJ848I4xQWyV0T0ovNat2qkt2+z8VHXA=;
 b=B4pa/UU6oWYWuZpZtIGRXVEopoUlNGYweygB7DU4CCloB6XntKt+BVksLn+1rhMUpshOKz0za/I4hVMZdaiF7ZS8bvTR4XPoOt0r/65XoMREFPEw5VDNgZEEqSwWOUuy/BMg8KxKZyRmtSOLu0YBv7W5yLIcbKivbEGzm80RzN0=
Received: from MW4PR04CA0336.namprd04.prod.outlook.com (2603:10b6:303:8a::11)
 by DS0PR12MB8562.namprd12.prod.outlook.com (2603:10b6:8:164::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 12:32:57 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::95) by MW4PR04CA0336.outlook.office365.com
 (2603:10b6:303:8a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 12:32:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 12:32:57 +0000
Received: from [10.85.38.54] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 07:32:53 -0500
Message-ID: <79db539c-a89c-411f-8a34-ab49ca6b4bf2@amd.com>
Date: Fri, 31 Jul 2026 18:02:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, "Igor
 Mammedov" <imammedo@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>,
 <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH 4/8] acpi_build: Use IOMMU pci device to build IOMMU
 device ID
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20260511123937.32743-1-sarunkod@amd.com>
 <20260511123937.32743-5-sarunkod@amd.com>
 <20260731054920-mutt-send-email-mst@kernel.org>
From: Sairaj Kodilkar <sarunkod@amd.com>
Content-Language: en-US
In-Reply-To: <20260731054920-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|DS0PR12MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: e3301f51-c3c5-485a-9c89-08deeeffd9dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|6133799003|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: dRu29zvRgks+VXzm0DhgwL9ekyGAP4Rll7a69YezT/nB3fQyNm0dMcywH0u8Blf3n2laLnU0Pg5rBbOe0QkLeqdiVPwSiX+uKVhwobE+WGbar7AJTZVQ49R4Cfp01uIAwbkH+afFQmbXEj5+XY8JkpqkcxPZvMx4cnl7EPHrW/j6E0hyLLKlC8Z4VXvcVRrVQjgfqCrMIhJNJxg8bGwvI5zD2rkzYaHrBygqbUGs8T9FuhIkCZTMdXJL7Ye6EOWQjkTS+Xr/sbnfSxcV2F3B3y7xE4w8/NU0nCQCudGMd402p79c96Vx0qPmoQ0gatFlZAG3ugfLGtP58/3AlnLfCN4Hh/KE6CzPo3j28O6zAmaHNGjCS461xqQ8l/bYLUVvZxQVBSoK9osXskT2t9IbmWI5KJAqXBozQDJUivZ3US7iDiwEpD20sWo7rOGc/5etfZUIGJH/35MKA907jqrrNy6l2IlnHrg2CeaWH+PqiR2pdP4vt34paCHE6Nr8awmejhpLo3oEvcKKUR7/TpaO+WX09YMQfPzEANR9ZuGw7o7EGlWDEr6a/qvAYkmODGsgYDwtOMQEwVSOemOOfUkjB/enzld2QbP0tQLBC09LzhlgkN+MLNLumhjPfxZ2S3ZJazUCbxwnslEJQCKKih6bQeBq9aYJ6NbAClwYyp4XtdfeEQhtTwH/3KJhQyTjqvgEI2gF5yitHvxDOhmv9aOD1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: h9mscvlUZl1ibuPpWJRz3u+Bpq1kYJLto8cwHfSTlVBlXcLrLxIb3TClXdQkMUUPqzrX2yS0kJ5Ii0HV1u7y8302trtuI+e/xp3C1r3gshir6v2B/Cu50mse4reWpM86bl7h+HeUnY8AIpGxbWeZbe5Lr470IaB4x3f3xnJfrGG/tNoqu9EFlCNaM/MfDLQ4YwYcpVmlV0xXJQaALBYrtLLy0dQkogszJejgxjeG33aVXQSPatgx62IQ0zqD5PVQiULUCsdD0S4OqrABz0yufAO6szr8I5txMX8wBTsS8Z2DKpFMy3XAhVS0lyFlND7eTvqxBtt52aA/MmK+fjQwA7bNgLLqp8WjFHlSAvF6Ntqdri4Amn+5FyvYuZ67Q3hOzFMn/2C0h69fn2SOW8lQ1h83Z+m8V74Yke4vMaKnsat2M+w6kGBpOzioafO8rBqf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 12:32:57.1655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3301f51-c3c5-485a-9c89-08deeeffd9dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8562
Received-SPF: permerror client-ip=52.101.62.17; envelope-from=Sairaj.K@amd.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/31/2026 3:20 PM, Michael S. Tsirkin wrote:
> On Mon, May 11, 2026 at 06:09:33PM +0530, Sairaj Kodilkar wrote:
>> Currently, build_amd_iommu() uses "addr" property to build the device ID for
>> IOMMU device and advertise it throught IVRS. But this property does not encode
>> IOMMU bus. This will be a problem if IOMMU is attached to different bus.
>> Hence use iommu pci device which provides bus, to build the IOMMU device ID.
>>
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> 
> But is this called after firmware has enumerated the pci bus?
> And I guess OS better not change that bus number eh?
> 

Hi Michael

Yes, the ACPI function is called two times -- during qemu initialization
and firmware writes. During first call, bus numbers are 0 and during
second call, IVRS is created with bus number. This second IVRS
overwrites the first one.

Thanks
Sairaj

>> ---
>>  hw/i386/acpi-build.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index e4ad01eec037..718e3f546b18 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -1752,10 +1752,13 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
>>                  const char *oem_table_id)
>>  {
>>      AMDVIState *s = AMD_IOMMU_DEVICE(x86_iommu_get_default());
>> +    PCIDevice *iommu_dev = &(s->pci->dev);
>>      GArray *ivhd_blob = g_array_new(false, true, 1);
>>      AcpiTable table = { .sig = "IVRS", .rev = 1, .oem_id = oem_id,
>>                          .oem_table_id = oem_table_id };
>>      uint64_t feature_report;
>> +    int iommu_bus = pci_bus_num(pci_get_bus(iommu_dev));
>> +    uint16_t iommu_devid = PCI_BUILD_BDF(iommu_bus, iommu_dev->devfn);
>>  
>>      acpi_table_begin(&table, table_data);
>>      /* IVinfo - IO virtualization information common to all
>> @@ -1816,9 +1819,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
>>      /* IVHD length */
>>      build_append_int_noprefix(table_data, ivhd_blob->len + 24, 2);
>>      /* DeviceID */
>> -    build_append_int_noprefix(table_data,
>> -                              object_property_get_int(OBJECT(s->pci), "addr",
>> -                                                      &error_abort), 2);
>> +    build_append_int_noprefix(table_data, iommu_devid, 2);
>>      /* Capability offset */
>>      build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
>>      /* IOMMU base address */
>> @@ -1850,10 +1851,9 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
>>  
>>      /* IVHD length */
>>      build_append_int_noprefix(table_data, ivhd_blob->len + 40, 2);
>> +
>>      /* DeviceID */
>> -    build_append_int_noprefix(table_data,
>> -                              object_property_get_int(OBJECT(s->pci), "addr",
>> -                                                      &error_abort), 2);
>> +    build_append_int_noprefix(table_data, iommu_devid, 2);
>>      /* Capability offset */
>>      build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
>>      /* IOMMU base address */
>> -- 
>> 2.34.1
> 


