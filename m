Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EFBC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGrjt-0003Nx-Kc; Mon, 19 May 2025 00:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uGrji-0003NC-6C
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:04:22 -0400
Received: from mail-co1nam11on2076.outbound.protection.outlook.com
 ([40.107.220.76] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uGrjf-0003gH-4C
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:04:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nF+f9Nb1lY2mXC7strnSQZv6d8W0+aaaO1pHc+YaqGs6M21RiR2Eksb9TTQMke0aFk2IoLEisYb6LeKcf5FGAIp8ub3IiL8M4iGqSPz8N/UmohYaIrwVM6DE2n+Cj5pc3xjG4/W1tr9pEYkXelKwp0v8SSCjDcb6TJeXcQPLUpqqMNer1qIGrmlth9HUB9PzUwRJRtWaemqLvEXnIUA+ih1a9CZXVCm73SZB5/n5FOJNqMmNqJGcJRnihjnANviL64kMFlJ9XSvQdWF7yy1O6Ne+NevNFjvG8Afhfmht8oesTZmulUvlH5GpzdogjjXpvrwAVNu8epltLgxhdv1pQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c59mOHz8iQQS/jCRJpREibcHvSrZra1LsZBKYBIZxZ4=;
 b=FNuL4KIhpNx8wvaWLwo/+t4Ddw9fSOI/5wm/3jal0pTPidGL1NjRUEzQkd1eQQ0M44puhhKdXntQ+NWEa8rwdOpiPkFGSgoebO6yCCUklI51RtZ+XvTFdFB5K4EiA18N8C9L36xA1s6Nos7SDHkUCsNR909Usq2+17EekJF+rw6H9zZ83XgPQKG4iQaDrNFDRtXnmzCKQOplpj9+q0am+ieg2nrBCByn+tKPhonAB0ni0dJmXMoLNG73t/TjSnfWqJWFwUEZGEgCyW/JcMpgMOLK9fDFSXUHH1wjAy1kSrpXJvOcEXJ255YiORZAJcA9xXnsOBGGv2Q8nJHWhn4K+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c59mOHz8iQQS/jCRJpREibcHvSrZra1LsZBKYBIZxZ4=;
 b=WWnJZyjKqRTg8lLFWdVeyHF3B8O8XhOx14NzK5+CcAB/zUdfADlGEJ3QL3cCzJIoQ4PE/toRGt0nRJv1ayBizzArlUCzLlq3JgbQankKxZwc4xtaZRNX4HQk1H4JxS2/C5eDQ1QKsWN6zBTofBzMG21CAKiKKJlU2LgJfUzr2U8=
Received: from BY1P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::8)
 by SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 19 May
 2025 03:59:11 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::de) by BY1P220CA0018.outlook.office365.com
 (2603:10b6:a03:5c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.30 via Frontend Transport; Mon,
 19 May 2025 03:59:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.4 via Frontend Transport; Mon, 19 May 2025 03:59:10 +0000
Received: from [10.85.46.226] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 18 May
 2025 22:59:06 -0500
Message-ID: <c777dba7-5ba9-40f0-a06a-f0e170cd8a36@amd.com>
Date: Mon, 19 May 2025 09:29:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] hw/i386/amd_iommu: Fix device setup failure when
 PT is on.
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>,
 <suravee.suthikulpanit@amd.com>, <alejandro.j.jimenez@oracle.com>,
 <joao.m.martins@oracle.com>, Vasant Hegde <vasant.hegde@amd.com>
References: <20250516100535.4980-1-sarunkod@amd.com>
 <20250516100535.4980-2-sarunkod@amd.com>
 <68cedad7-3f97-4040-9262-1039ddc6bb07@linaro.org>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <68cedad7-3f97-4040-9262-1039ddc6bb07@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|SA1PR12MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: 53126bab-3c4f-49d6-677c-08dd968982eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzZobXZnMUtDQ0UxbytWbzk1TW9UcGFZaFFiUFJOblp2UlBNUlRjZTdsdlJn?=
 =?utf-8?B?VzBqaFd3aUg1dmhJNk9NYnY4U25JeXRYanl5K01jNEZGMG1uY0EycWV2VFFE?=
 =?utf-8?B?ZitrbkdWOXY5Mm9MdlBUUzJoODlJaDgxWFlyNmNZOThzMW9aRnFBSDNlT0tO?=
 =?utf-8?B?L0l3OHg5MVJMK3NhRGs1MlRQQ2ZpMk1mdlI2SXZZTEFVT3JRR1VLbTJyVG03?=
 =?utf-8?B?Y3NWSGNXMjlmbXo1L1Z1L08ybFQvT3hRMWN6TXVndklRV2JBTUkxMUFsSTUz?=
 =?utf-8?B?RDVCTTJmWU51MU8yZFNCQ2NOT1gzRWJINmlsdlc4Z3VobHVVTVljclgzZXlW?=
 =?utf-8?B?L0xEZjZObG9HR0luNnQxc0tyaXFIdlgzbDNZMVlOdWFLbzNmMGg5bWdZanJI?=
 =?utf-8?B?cU9hclUyWTFnZmZUYmlGRkVOTlYxTGV2bjlXNUpTYlVIc1dnamNraWNXOHFN?=
 =?utf-8?B?ZHRDa0l4azROYTJ4Ti9NOWlCVDVvdXduZzF5S3NFVDNtYWFzTi90czVMdEdQ?=
 =?utf-8?B?b21ieFBMbjF1SXdkYWE0NXp6cCtCWjhqU1o5Q2gvMXQ0bld0YjZhV2RMQk0z?=
 =?utf-8?B?ZENxZzJhd3RXeDh3SC91NmVMSTAzSy9EV3NRWEJxZmhMNzFkT2NhbjBvWG5W?=
 =?utf-8?B?bVB3VC9oTFVKUzNvMlRwd0ZXTXRGUGpzajIzRHpUOTIxSXRqSC8ra28rUWNM?=
 =?utf-8?B?YVVIR0V1K1VWOTQ1cFBaeEJnSCtNd1BxMW5HNC91WDBpdEJRUDdFbmVXdVhw?=
 =?utf-8?B?bjFlbjYxamk0V0ZqaEtlOW43YWFIYXZqRnJKRm1vQzUwMUtEZHRXUDJXSU9U?=
 =?utf-8?B?TDNNM1BUTHNVZjlwMUtiTXc3TFlrdW1PODZjeXE5bkVmU1JBdW5SK216LzZo?=
 =?utf-8?B?cjZaOUkzYWdzMWlIOHRiOW43d0J5OGZVSUJRSm1vRnBldWZLM3o4YlZZaXRY?=
 =?utf-8?B?RXc1eVBUS2JJbUcrV3FTNnBET0I4eThGcTNTaGswME9QYVVSbXVlbTAwYU1i?=
 =?utf-8?B?UVZydjlWcXJJaUdodkIxRjJnSGRhNlRvbDNtZWs1aW1pekN3MFp1cXdpdjdJ?=
 =?utf-8?B?VHdtVEFBZXBkNldEV05mVGQvdmQ0bFVWMEhHd1U1WWJ6RU92NElaYUIzZG9m?=
 =?utf-8?B?TWpmbXNEWXhIazZMc2ZVNmsrcjI0S2ZWakQ5eEk3dmdtYlBFWGNEMGlvL3BL?=
 =?utf-8?B?dmpUR1ArMjA0UmFMVVBrZ2F2aEtPS01sOU1DcmJBeThDWklPdVFsOStCa0RI?=
 =?utf-8?B?ckZVNk1tcFlvZ0lQejE2M3kwZmlpeWgxSlg1YytIakJSdTl1aEVYbjhrdDhj?=
 =?utf-8?B?YkNweTh1ZUpKMHVNZHQyR0ZaUlNMWlVNeDN4NmFDU2REekp6Q2hrdXowSVhw?=
 =?utf-8?B?aG03cGNGL0ovYjBGVjR2SnZ2UXc2dWVoRkVVWHNuQjl1V2ZaZGVhR0hJNHhv?=
 =?utf-8?B?OFY4Sk4xSVM0amJCSFdHWlFSVERuVU5iODZqMGN5eS8wODJWZjBESjRrOU5u?=
 =?utf-8?B?Z2pKL2wzMHFEdGhxblBhM09HNDhsNG9Cb2tjSEFvYUtOdmkrMW9XUE0zeWFY?=
 =?utf-8?B?a0tOWTR0Q1ZLR0xzU3JuY3JXaVdnVlRqajhJdmJ1RjlYQ21IVUc3K1pXZzlG?=
 =?utf-8?B?ckRxdlNnT0ZtSTI3UmMwSWJLOU1XWHdlNmoxREwzSDkzSy83ZWlWQ3F0dDVM?=
 =?utf-8?B?MUF2WFZvalNrREtwamJ5enNZa3FlL3FkTHdoZHppMXpzV1Vua0dJUXU2Ujgz?=
 =?utf-8?B?TXVyaHhYL1d3bjZyU2d2N1R4YlVwRnN1OVpPY0QyVFFIM05ONTNlZDh1Zy8y?=
 =?utf-8?B?cHVHcG96d0Nua2pKbFpENGVJb2J2SkMwSnk2SlhlWng2cDhLbG9wa1QrZkE5?=
 =?utf-8?B?R1lvbjB5NndlYVJCWS95UzhNeisxamc2VlNLNS84OEhmOWdmZVhNU2tEMnRr?=
 =?utf-8?B?M09iNFFrbmdWQzd1bi9EenlFbWl1dUdFd1JTNUhPRUNDcUdObTZFTHRnTzdB?=
 =?utf-8?B?d2NCbFhvaWRWL0ZOZXFjWnNibC9iMFhpaUxVWTBXSWhxM1Fza1duenl6RURZ?=
 =?utf-8?B?SStvaHpIZXdFQUZXcEo0Tm9EeUpjeTZCdEJRZz09?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 03:59:10.6185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53126bab-3c4f-49d6-677c-08dd968982eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7272
Received-SPF: permerror client-ip=40.107.220.76;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/16/2025 8:13 PM, Philippe Mathieu-Daudé wrote:
> On 16/5/25 12:05, Sairaj Kodilkar wrote:
>> Commit c1f46999ef506 ("amd_iommu: Add support for pass though mode")
>> introduces the support for "pt" flag by enabling nodma memory when
>> "pt=off". This allowed VFIO devices to successfully register notifiers
>> by using nodma region.
>>
>> But, This also broke things when guest is booted with the iommu=nopt
>> because, devices bypass the IOMMU and use untranslated addresses 
>> (IOVA) to
>> perform DMA reads/writes to the nodma memory region, ultimately 
>> resulting in
>> a failure to setup the devices in the guest.
>>
>> Fix the above issue by always enabling the amdvi_dev_as->iommu memory 
>> region.
>> But this will once again cause VFIO devices to fail while registering the
>> notifiers with AMD IOMMU memory region.
>>
>> Fixes: c1f46999ef506 ("amd_iommu: Add support for pass though mode")
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>   hw/i386/amd_iommu.c | 12 ++----------
>>   1 file changed, 2 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 5f9b95279997..df8ba5d39ada 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -1426,7 +1426,6 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus 
>> *bus, void *opaque, int devfn)
>>       AMDVIState *s = opaque;
>>       AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
>>       int bus_num = pci_bus_num(bus);
>> -    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
>>       iommu_as = s->address_spaces[bus_num];
>> @@ -1486,15 +1485,8 @@ static AddressSpace 
>> *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>>                                               AMDVI_INT_ADDR_FIRST,
>>                                               &amdvi_dev_as->iommu_ir, 
>> 1);
>> -        if (!x86_iommu->pt_supported) {
>> -            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, 
>> false);
>> -            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as- 
>> >iommu),
>> -                                      true);
>> -        } else {
>> -            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as- 
>> >iommu),
>> -                                      false);
>> -            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, true);
>> -        }
>> +        memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
> 
> I have no clue about this device but wonder what is the usefulness of
> iommu_nodma now, isn't it dead code?
> 

Hi Philippe,

Indeed the iommu_nodma is dead. The reason I did not remove the
iommu_nodma region completely is that, Alejandro's DMA remapping patches
[1] uses this region to dynamically switch the address space.

[1] 
https://lore.kernel.org/qemu-devel/20250502021605.1795985-1-alejandro.j.jimenez@oracle.com/

Thanks
Sairaj

>> +        memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as- 
>> >iommu), true);
>>       }
>>       return &iommu_as[devfn]->as;
>>   }
> 


