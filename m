Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60567CCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 09:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8axu-0000Nf-Tb; Tue, 14 Oct 2025 05:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v8axn-0000KG-2e
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:05:00 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v8axe-0008WM-Nn
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:04:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AodnHXU6C0E0PEHmetCwp2MEDpbfsQhvWUIfDGcmJy6d/INVPlwUibiY3gJUCl2+pmcum5DM8j7UvIacZ3akMepeP5Dsspgr6dEqpblphutm6WSO8DnIlLRMF8pFcaKTtesg4QKcS9qPP3ymNZhI4/xgmwlf5UMZSe7lpdhb4zfgArpF5vWJ2maKIPHJmE5NxJ3Mq42AYKY9+NjulPkeQzLi+RfzCJk5nTuzgp49tDyMZ6yUaz3uZdUTCQNfHrLoNe86UXVJVGLG/8cVOLpSwBVqnrnP1LSDot2Nbb21qCSGRKs7ie36pNcluvAvc42nq1ZbpIUC40gWzgz6kFk06g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLU++UwMgI1C93S8TyqNe9P0L7cO0k09VXj2RVelyxY=;
 b=KA0A6Gx+SbA/JE3wDOITpVcJaFADeQfNZu3tIK5mvwk4zHj/UX+KAlQweu02MhKFxR/tRhjsUzF7TiZFP46Thhsfeyxm0DZSgGmmZ4VG9cXlgZtTILWAJJduqrTEAQx2vSb9TZJG+pTaJwZ+i7rza+QmpPw082Ye3AGdHomCCcZ4zUzzPcjoLTuK8gj/iAReErQTYLp9EWMTSMS0+tlBEewof6V/UI0WB2Tcb7OM/fbYKmyCNCg+XIYp1CB/Is03vNcFf5LzQBACm7Vshwi0K0JdHsBfXbocO/LlBivBxNlKouDuwK15tEFhtuiVWvY8+Zz0Ozrgfd6haD1s8bIgvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLU++UwMgI1C93S8TyqNe9P0L7cO0k09VXj2RVelyxY=;
 b=T+vnasyjKNYceollhayqzsX+GLmDerjTShKys2OyNum2dhjNpxqKyyhoBHBf7FSQrU7fyB/UiOEr0pQ3T6e4JmX5EvH9tGAwF35xD+zFDKjCG4ZlTql6qHmpm/j03zIoMPl0cWfdizTH7vZsOgnmr4Dd3ZNPi9XKGAEGnutPzAk=
Received: from CH0PR03CA0192.namprd03.prod.outlook.com (2603:10b6:610:e4::17)
 by DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Tue, 14 Oct
 2025 09:04:40 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::4a) by CH0PR03CA0192.outlook.office365.com
 (2603:10b6:610:e4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Tue,
 14 Oct 2025 09:04:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Tue, 14 Oct 2025 09:04:40 +0000
Received: from [172.31.35.81] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 02:04:36 -0700
Message-ID: <e4c5d25c-572c-45fe-8e64-b6f141c0f82e@amd.com>
Date: Tue, 14 Oct 2025 14:34:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sairaj Kodilkar <sarunkod@amd.com>
Subject: Re: [PATCH v2 2/2] amd_iommu: Support 64 bit address for IOTLB lookup
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, <alejandro.j.jimenez@oracle.com>,
 <pbonzini@redhat.com>, <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
 <marcel.apfelbaum@gmail.com>, <eduardo@habkost.net>, <aik@amd.com>
References: <20251013050046.393-1-sarunkod@amd.com>
 <20251013050046.393-3-sarunkod@amd.com>
 <20251013041617-mutt-send-email-mst@kernel.org>
Content-Language: en-US
In-Reply-To: <20251013041617-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|DM6PR12MB4169:EE_
X-MS-Office365-Filtering-Correlation-Id: 75da3cb1-e3e8-481e-390b-08de0b00b583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VW0zRmhRT0ZqMHhZY09rNkVLaHhCMURZblRpU3RGNjlXajBsY3g1U2YxMlZD?=
 =?utf-8?B?cEcvc2JINlY5RVMrM2pEUTBSOHJ2a2xMOHlVcSt5WC83aWduejlHYlozQzh1?=
 =?utf-8?B?OWdQUTdTVkRrMGRvSE5wOTFqejdacXp2OFRkTzhoVjBZa3BmOWU0bzcvU2JO?=
 =?utf-8?B?Rndvd1FPb2J0RjhPdWFHd0pzeEdVOUErQnBrZzNDTmgvR2pMK3p6UWp2cC9O?=
 =?utf-8?B?V1dlSVNoN0dzanJoL1ZuYm1RTy9QR0R6VWRTWmFRYXZlVkc3TE5LUDJ6SVU0?=
 =?utf-8?B?cDFoeFQ4N3FMZWJCNzVyOVo2azRTUFVGUitmV3Rxd3RlYWdwbmJCZWtkT290?=
 =?utf-8?B?NXNpT0ViNnYrSXpkMWFpaFlZREUySVZYcFVsM3NvZmJFcTJ0cDRBeFhGZlpn?=
 =?utf-8?B?dkJaSFd1cHFxaVhvTkxkc0pnUlpOR0FOR1gwV3JMbEZjdGVDeUR5aDJpQjhs?=
 =?utf-8?B?K0ZxWC9lQlBHSElReGYxN1IvakJCS3l6MG0rbDlmVUZwZS9JR2F6RytVU2tN?=
 =?utf-8?B?YmgvRkhlQzJGMlhpeFhXMC9zYjNKVk14d1NSRjJWN1FKTXhSY1B5ci8ycGpE?=
 =?utf-8?B?Nlo3TzV4MFFsdkpzUTRZS2lLOFBzc20yMHZ1TmcxUmZJUm5MNit4M1ludW5W?=
 =?utf-8?B?WmdlaEFFTG5oNkR3bHZZZWFZSExuNGxBZW5mTGtHMWZKTUNOTUtWaUR6eU5I?=
 =?utf-8?B?eS9waFdoNWsvd2FHNHZqbUIxY0IzZ2I2OWJQQ0FIRitGM2xQQy9vMWRFM3g3?=
 =?utf-8?B?bTBXNUhQViszRG5STFhqZk5jTlJOcmdhWld0RFpDdGtmclJoNFVXTmZYaFVF?=
 =?utf-8?B?S0VpWUFxZ3BTb2s5YjdvY2R2QlN1RkRIcXE2NlpJQ1BKWmRQNVpXNUxURmdy?=
 =?utf-8?B?R1NucFV3QVVEY3pmNmlEbUZ0K2QxS1pCd3I0M0k0dlpzM3NPeFliK0JSOHZF?=
 =?utf-8?B?SlZxbUJ6dVVTWldpM3dkeDF4aTBBVkN2RmhnakJZcm54Znk0Q1RGWVNseHN6?=
 =?utf-8?B?anVnUEZoQ213dk1VQmU5VTFUTERHcGhya0VuNmdVQXI0KzIyUFRYdDE4OG1N?=
 =?utf-8?B?L0drKzY5ZWpqbWp3R1lhM0tDM3JOZUxITUs0czlVck93cVFTQ3gzUGszekZJ?=
 =?utf-8?B?bzhaR0JIdzRmYzJXTjQvM2hzMGtQVFVydWNYQ2JPNVJqYUkyQ1RXM0Jjdkpa?=
 =?utf-8?B?MXN0MnF5Q1I2ZVZxMWI2UVd4TC82UlB0K0pqWld6OW80L3BESkM2YU56Vm1m?=
 =?utf-8?B?WjI4Z3pncUZwZnRBY0VINUFEZ25OSW9BM0E0eWlxTldOdjVONFRtU3FhQzlZ?=
 =?utf-8?B?SFNKdTZWZHhHYXB3bS9BdVRGUUc3d2g2V3NicmdKN0hZTmFhbnEzcFFHdk90?=
 =?utf-8?B?TDhUMmh2UEEvMUo3Njg5UmY0TGRrbWg5dGRZb0ZZSGdERnZxRmwzOGtVQVVw?=
 =?utf-8?B?bDNlSE5FaE1ObW05OG9hL3hHNHAxaDI2QUpoNDF5UEx5YmtFS1IxWXBna0Zu?=
 =?utf-8?B?MFcxUHJ0RmdVOFlBbWxqMDFVSWhkeG9tVjZ0T1FzZzlBcGFubloxVUhmcUdG?=
 =?utf-8?B?eExCamUyNDVIWnlPMWFxTkZCcU1nbE15elpIM1QrTU9CdnN3V1FOTjZ4SkxK?=
 =?utf-8?B?VU5hNzlQQ2syeHROemErUldoNUhGSTFrT3B3dlBHRk5MdGFnSkJWZ3c0NEFC?=
 =?utf-8?B?SUcveGd2RUJ3YWJ3SDhHLzFsczliTmpPNW9VQ21ZY0NIcVdtQ0tmMzUwajN2?=
 =?utf-8?B?ZXFpN1dzcFFvTVh6NXlTS0EzbDBxZ0Nnck9FRXBmdkh2bTdpQytNeXF0ZlV6?=
 =?utf-8?B?MGFsc3hFclQvVEZDUW1oa2g1MUphVUY5a04yb0ZIVzY2ZDZjMGFZbk5wU2Nx?=
 =?utf-8?B?MG5oZGpETEdqQ21ZTVdNNTk1eEpNTUYzT2FISTZCcEpXc09RRmJYaTRETFNk?=
 =?utf-8?B?dWkwVUtWMWZxK2c1K0xrM0ZxaGpqb3FqdGttK25yaWNZakl6TXdhcEs4aHVm?=
 =?utf-8?B?NWRPUDE1WllKQ0NNbmhwMi9wSUduM29vRVR4QURWd0NDUXlGRlhGRjdZRTR5?=
 =?utf-8?B?RmdXRk5mV2dEOGR1WXNvRUxPMWFhc2Z6eExMbjh0eTlSRlQ5WTZVQXhGaklR?=
 =?utf-8?Q?xpDE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 09:04:40.5488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75da3cb1-e3e8-481e-390b-08de0b00b583
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 10/13/2025 1:49 PM, Michael S. Tsirkin wrote:
> On Mon, Oct 13, 2025 at 10:30:46AM +0530, Sairaj Kodilkar wrote:
>> Physical AMD IOMMU supports up to 64 bits of DMA address. When device tries
>> to read or write from a given DMA address, IOMMU translates the address
>> using page table assigned to that device. Since IOMMU uses per device page
>> tables, the emulated IOMMU should use the cache tag of 68 bits
>> (64 bit address - 12 bit page alignment + 16 bit device ID).
>>
>> Current emulated AMD IOMMU uses GLib hash table to create software iotlb
>> and uses 64 bit key to store the IOVA and deviceID, which limits the IOVA
>> to 60 bits. This causes failure while setting up the device when guest is
>> booted with "iommu.forcedac=1".
>>
>> To solve this problem, Use 64 bit IOVA and 16 bit devid as key to store
>> entries in IOTLB; Use upper 52 bits of IOVA (GFN) and lower 12 bits of
>> the device ID to construct the 64 bit hash key in order avoid the
>> truncation as much as possible (reducing hash collisions).
>>
>> Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
>> Signed-off-by: Sairaj Kodilkar<sarunkod@amd.com>
> I am wondering whether we need to limit how much host memory
> can the shadow take. Because with so many bits, the sky is the limit ...
> OTOH it's not directly caused by this patch, but it's something
> we should think about maybe.

I don't think I fully understand this. Do you mean the host memory
taken by the pages used to build shadow page table ?


> Something more to improve:
>
>
>> ---
>>   hw/i386/amd_iommu.c | 57 ++++++++++++++++++++++++++++++---------------
>>   hw/i386/amd_iommu.h |  4 ++--
>>   2 files changed, 40 insertions(+), 21 deletions(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index b194e3294dd7..a218d147e53d 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -106,6 +106,11 @@ typedef struct amdvi_as_key {
>>       uint8_t devfn;
>>   } amdvi_as_key;
>>   
>> +typedef struct amdvi_iotlb_key {
>> +    uint64_t gfn;
>> +    uint16_t devid;
>> +} amdvi_iotlb_key;
>> +
> Pls change struct and typedef names to match qemu coding style.
Thanks
Sairaj

