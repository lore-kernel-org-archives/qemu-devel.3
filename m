Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0077CCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 08:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8aHr-0002bv-9W; Tue, 14 Oct 2025 04:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v8aHp-0002ao-8w
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 04:21:37 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v8aHm-0003TH-5i
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 04:21:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZYd7+qCRIiBxVwYik4hUhT98nS8lO+QoAwIvOVmzVx4j5kOIrHUB4d/FXYf/Gqd+UalObqrDJH2xkmf9CKml9vWOSuwW1yF8ohpYcRBTu5eQJW0Y0l3gUUGBAnrmNYK+9bmyzVaxbQ/0JRnXqT/KhWOFLEWMusORYe31KSVy7ojOj32EZwT/2ZCujfqvws7F3eTZmZ6uQRzFOVjRU2dnJ3RXAZ66l9D3bHe7tg17N9YhI9imYtB6bY1C0hhRFdFTazM786CUFG/rpTC05UoYZOIz+uAsJ6v7Pzqe8u8sIUqmcOlYNtpa1l71vbMX4ZD+djUWAMM0roimtCUh+Q5ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vP37/nUYcyy1M+YtbvGQfOHF5oDI7jgYkMiUSJRJF1Q=;
 b=Jt4xKoRK8Ig+9+hNl9FXUA0FDYVdsf7KR3YljF9fyxPlWdvCZ38RIjhCzxf6Xy4Q2JbRAFWWH1HDwSwjKyzctiCHXs5wKgw3D99qsKyEsG16On+ATyBPyuwqsNqkxkD3WC6LUmdmEKIBV/Ktqu+bTVlAYGlXvZB73evYnZEAWwF0FXiePPguT2JqUfyYIMjsyKMlLODPxezquA61HmFjSumi+abcWxkPJiBWsjIRV4Qii3OiSgOjQ6ACceCGYefCUogwVj/8oN2T6nfHPJ4cZP/uP2HIyargz3eq6CMsid1ncHMezPVo6UpdFLUGR9aYpMbkUpQOaIW37sSxnz5Usw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vP37/nUYcyy1M+YtbvGQfOHF5oDI7jgYkMiUSJRJF1Q=;
 b=SvPQzhNAH6dWkQ/79IIuguYC6b/NT++9MPnrcBwyddh4MSgl1hd3ChI9Dwj5DR7S/TqYjQLw19LbEPud38D78/gPBPCfoBvwlj0I9nEZEAx1dHO2ERI86Wdhk1qCWrRq9EfakXTHiyBQYJIw2BuKdCRbU+Ya4egutQOYX1ZPX9g=
Received: from SN7P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::25)
 by DM6PR12MB4315.namprd12.prod.outlook.com (2603:10b6:5:223::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 08:21:24 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:123:cafe::81) by SN7P220CA0020.outlook.office365.com
 (2603:10b6:806:123::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.9 via Frontend Transport; Tue,
 14 Oct 2025 08:21:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Tue, 14 Oct 2025 08:21:23 +0000
Received: from [172.31.35.81] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 01:21:20 -0700
Message-ID: <f124a1ff-d8d3-4aac-a1f4-d7be727654e9@amd.com>
Date: Tue, 14 Oct 2025 13:51:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] amd_iommu: Support 64 bit address for IOTLB lookup
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, <alejandro.j.jimenez@oracle.com>,
 <pbonzini@redhat.com>, <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
 <marcel.apfelbaum@gmail.com>, <eduardo@habkost.net>, <aik@amd.com>
References: <20251013050046.393-1-sarunkod@amd.com>
 <20251013050046.393-3-sarunkod@amd.com>
 <20251013041617-mutt-send-email-mst@kernel.org>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20251013041617-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|DM6PR12MB4315:EE_
X-MS-Office365-Filtering-Correlation-Id: dfb0be9c-b995-4348-46ad-08de0afaa9cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXlWOGdqdGR5MlRUZ0dZUDJuSVcyVFB6Y1JWV2lScmJhVElnbFp2STFTcWNL?=
 =?utf-8?B?UzFxKzZidXdFVkV5MHZjK3NwRzVTZU9BU0c0QVpWdmVsa2VYSnA4M3BkTS9B?=
 =?utf-8?B?NGxFMEU5WEZoOEtMa1ZIR1p5TG5STkNFUjZmTUlqa2JabzBGWDVNYXJDYXFM?=
 =?utf-8?B?c2JGUUlkNEs3TmpkWFd6cEhJQnNnckJzL2dLSWYrU3JZRWt0b3JqemFYYVh6?=
 =?utf-8?B?bVArbkVvVFhuSEY3Ulo4YTR3cGRhTlY0TForVXRwK1RQbWViSWVTQ2pvUld6?=
 =?utf-8?B?NnpVM212SkNIMHNBM1ZkRzFpSHZGY0lrT2tpM1p4TTEzYjQ1YVRFMVU3czZx?=
 =?utf-8?B?cFQ2dlIxQU5kTVIxaHIxdnd0K0xlU2pmbCtFNEVCUDZWay9LTXRkN0FrVUhW?=
 =?utf-8?B?anRlYTRHckxqVFlzSTBPVEdhQm1MYzdnd25CVEo4TGNvRkV1QVZ5REFLK1hF?=
 =?utf-8?B?THJMZEhKT1VOTE1TVWR6U2lndjQxdWo5NkFUbnRQYmE3UmhFWTVZeGQxeU8x?=
 =?utf-8?B?MzhYZEUwRjE3TEdLdjlJSk1PUXlCeUVseEhBZ05IbklPQzlUaFhGTHF6OTl3?=
 =?utf-8?B?TjVuVUNwZVd5UnFza0U5NEhFSSt4WmlvUG41QTF6c2ppM3k2VkRsSEtsM0JT?=
 =?utf-8?B?R1N4S25jVjVSV080bHlLMlRNSHY4RFdKZTBWZ0ptdk1ybzlRcFJxck9QZUNZ?=
 =?utf-8?B?cU1FUFFoV29sdTlGVFFRY3ZvMEoxbXdkVDcyckdRa1h2KzMrdi9tWnBia1pU?=
 =?utf-8?B?V1ljMjRxQ1MzbkZhaDhrQmEvUmZNNW95TE9uQWg2STV2K2V0c0dqZlNFSlFr?=
 =?utf-8?B?cno4V1ZPcGI2OWI1VnJMaDUyY1J5TDV5cHk1ODkrbHdNOXpjMGF0STcxcE1a?=
 =?utf-8?B?TWhHcUp2MmV0NHN2NGZLeHZhcnp2RWNPQkQ0Znh5RGFBcUVKa2FOWHFVM3ZL?=
 =?utf-8?B?SnpZdnFRdHJnTmZxSG44TGVnajl1RUcvVFRING5hWW5BYjZSUmh3b2JtTVRi?=
 =?utf-8?B?cTVlbkxyUHIvUTgvaDNZbERzTnZVb0x6UVBZYXBmNVhYRnppNVFyV3M5L1BI?=
 =?utf-8?B?VWtDRG9wQnIrZEMvZWFicFB0emROdjRza2xPUUM2SUdieUxHZi9ubGtRMkUy?=
 =?utf-8?B?bTZnK0lkbGpscVg2UUpFNXhXUjZjVUVrNUtLWXE2VHpQMFBaQ243NTA5Qmcy?=
 =?utf-8?B?aXN1ckdBMDJuTVBtdlNuTmE2RHlEV1hodXhiVHQxaDRySXZGajBFK3A5ckVG?=
 =?utf-8?B?UkdBc0h5dVMxdXRaaElveEZodzRzMVdHditqRlhKTDRiVmFxM0ZvOWxIejNW?=
 =?utf-8?B?Wi93OE9nVG9hQ2szYWlvU3ZleFV5ZnBvTWZMZE1WekhiTisxMndNZDBjN2Zj?=
 =?utf-8?B?WHJ5QmlKQmwrVi92YUpvTjFIYUhKdi9LMDFoL2F2Q0dwcExmdUcxZ0JmQ3B2?=
 =?utf-8?B?UytIMTFBYzFRc0tXK05uT1ZLcmhPYmFzVjNkdUltNzd6UFhORkNtWHkzTTVy?=
 =?utf-8?B?TWFIMjNYcCt3cHJPc0VmeE9iMW5tbXBNUkxOOERFQytuMXN2dVc2UkVzMnBq?=
 =?utf-8?B?Z1NQLzVOclFZU2FvUnQzencyRmkvYUM4eXlaNWh5anhxajRVWGhidXJwNmlS?=
 =?utf-8?B?V29Fc2g3QlRGZExXejcvSlc0WmY3Q0MzcllZeEN6aklJUStDcjRWRXhGbExQ?=
 =?utf-8?B?RnBNZGdXNmYvQURleWM4NWo4RURZdWJMMVlsaTQwZ3JpWU80dlkvRjltczRZ?=
 =?utf-8?B?T2tvSVFVckcxd3N1bW1lZnpiZDNVWGNJWDFPeTJLNWR3cnozcllWRGg4UWly?=
 =?utf-8?B?eEVMa08zZGdBSk1VY2xZZTdPWVVyU1RycDlFVm9BankrclN6YzAvcWkzMi9O?=
 =?utf-8?B?blVCTDl4RklEVUNpUzRyY1BMYWxVcUQrV01SY1EyOTVjcVlXNExNdC95d1dh?=
 =?utf-8?B?QjVLcnlkbytSMHd1ZHREOCsxWGE2UFZyUjlqaVBOTVJtNnlIOXhucnV0dzg2?=
 =?utf-8?B?Q0pRNm9VWXJES05lUnk5d2tyc2lPbFU2S2hIdEk4ZGlGN0pnS3R4cFM2Qkls?=
 =?utf-8?B?N3pUMnFWZ2h2TDRENGg3NVd2YjFNSnprRlRBTUhNTm96M0ROZ3BJVGRuZXBs?=
 =?utf-8?Q?lr+E=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 08:21:23.9446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb0be9c-b995-4348-46ad-08de0afaa9cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4315
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
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
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>
> I am wondering whether we need to limit how much host memory
> can the shadow take. Because with so many bits, the sky is the limit ...
> OTOH it's not directly caused by this patch, but it's something
> we should think about maybe.

I don't think I fully understand this. Do you mean the host memory
taken by the pages used to build shadow page table ?

>
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
>
> Pls change struct and typedef names to match qemu coding style.


