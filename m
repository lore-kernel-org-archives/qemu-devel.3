Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0877CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 05:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v75Sf-0005Fd-Ta; Fri, 10 Oct 2025 01:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v75Sd-0005FM-Gu
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 01:14:35 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v75SY-0007dv-Ow
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 01:14:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTdFtMEl8i6RRQp4x9fyKjByQNZsR3iGpLSzu6x6ZYBFj+0jgiq7b661fX1V4TwAG7M3dF5vz8UUPBocZHpGlxaWk2PB2Fds/zSEF1i67DbUsMSvWyzwhxhH6TNUZoipoqfN8cd5KYYeRSHCpNH1hK9emTHpggHy+vT943A0eOfZSkHxwTOhRZ/GpiZUHNxnTgazrUGaXrOcUSxJ7dOfAD99QSMM5qpzQgvAv3x6zjEI1vCi35P/c3nT0Dkhbd24/sSJJ+ix8uf0TmQZxXEn2PX1oZi2z3lQWSr/i+bU/unQY+JdvCjVFyMgDrrYwDgyQvHrPIFpqUD1aiIrUCKi2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I73Bu/2qTsOL3nPDRTt6gfUXEXjTWGy2TQqCkiIXHv0=;
 b=sb4q7kuga6IVkPQnxcMud/hcQRMoN2EhbGRLP0K/Adz7VylmFxjQbieJev0ooe4mDXgzXNKDRzcVVMh6J6AycVW0tK4X7xGYDVLwTNSe6GeBSUqNz591TC3rc8A7yjNLk8RY5MJMAXWZWKZb6efKZ9KFvpLvHxcFK1/rs9IayWv2TlPzIA8gvuu4n4fb4HGIj2mfzpaThDm1uuMmlrQzHMkovpZUHytCV9EjTydB/3rlRCe9rh/sKmn6r6fu22iLUr6Pq/h82+FGPgNA+33Yf8nQ/sxryq88TMC7j/02Y2nRp82sQShuEuFfc5cOD9rF3K+2JGBAz8yFUGFDkfUeNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I73Bu/2qTsOL3nPDRTt6gfUXEXjTWGy2TQqCkiIXHv0=;
 b=eCzqIOzjYBoxNUaxW5pbIh1Lrd7jB71ENrkOv1tytTeryPK1kzj9KkmRTAKme1/afO+YOwpvwP+wmkU5FoEZcHgDQc1/1lnqh2D+pM8k3t9bauvIkFQiMmglEcDP23G/wPZGEq5+/xYTAZntwqOvmTL4N81ZY4Ol3KShSFNCgLY=
Received: from BL1PR13CA0176.namprd13.prod.outlook.com (2603:10b6:208:2bd::31)
 by IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 05:14:15 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:208:2bd:cafe::fc) by BL1PR13CA0176.outlook.office365.com
 (2603:10b6:208:2bd::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.6 via Frontend Transport; Fri,
 10 Oct 2025 05:14:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 05:14:15 +0000
Received: from [172.31.35.81] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 22:14:11 -0700
Message-ID: <87a149a9-e506-411e-a8be-07a283bc2c57@amd.com>
Date: Fri, 10 Oct 2025 10:44:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/i386/amd_iommu: Support 64 bit address for IOTLB
 lookup
Content-Language: en-US
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <philmd@linaro.org>, <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>, 
 <marcel.apfelbaum@gmail.com>, <eduardo@habkost.net>,
 <santosh.shukla@amd.com>, <aik@amd.com>
References: <20251008164324.21553-1-sarunkod@amd.com>
 <20251008164324.21553-3-sarunkod@amd.com>
 <91118d9e-eba8-47da-8eea-e535685e4a01@oracle.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <91118d9e-eba8-47da-8eea-e535685e4a01@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f637eaf-f454-4f67-d351-08de07bbdb4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cG1CblovaWNvV21ybytrc2ZPbFluVGFmUm1HOG0rU01yS29pOWkyNHV6cGJs?=
 =?utf-8?B?Ri9GV0U4ell5N1FwWmxRV240NjdJZjRvRW5Fd0ZuVUwyYUhVd29lYXZJeGgr?=
 =?utf-8?B?MUExUC9SV1krUWJuVzBlcEM0RlUzNS9RZ3I5OWoxOVlZNTlCMElPcFh5bkp4?=
 =?utf-8?B?NTFyWUVQMk1ITWt5ZUhqVFNYaUxQSXcwczdpL2M1eGJweTJqZ1RwMGc0dnZX?=
 =?utf-8?B?MitEVkdZemZ3MHA1L1ZPZGk4V1NLdGs0NloyMTZHWlNZYkpIbUUzOXZkWUkw?=
 =?utf-8?B?NUtpdXNoa0RTbDJMMGpZMjhJNk5DcVlhTm5tQzJBdEZ5bUt4YzlkT1Z5Vms4?=
 =?utf-8?B?VndlTW9RdTlpeFBzRXp1WHY3VWhYRGswdGQ2TVhlN1E0eDRwZ1dPZTRDQkgy?=
 =?utf-8?B?MmplRXZvYms3S0NVVmc5aHhwZFlKa09ET0dwbWVHQS9ha1h5djdiWHU3citV?=
 =?utf-8?B?aUlzN21SWDFaUkp0Z3hOZi9VbWl5TGRuNk96RVM1b3M1WFlVanVLRUw3Tlps?=
 =?utf-8?B?cUNndXF3dkhJTkdrMDlGRGJSNTZrS01MdmJrVzJQVlhoaTVkaDdVVDRZQTdQ?=
 =?utf-8?B?TnFzUVR5VEFtQVp4Sys3VFUzeDFoZW5KMXB1dkhFVzJVY0FBTmh2c0RGMzZE?=
 =?utf-8?B?Y0h1Ukk0ZHRKeFZUSkJCN3NtZG5jVkt4aHJaMnpUUjJoWkJBQjQvdWFDcFdF?=
 =?utf-8?B?RWphTHlQVVhxUnV3OWVvWXBUTDh3TzVpVVg2Umk5bFl1VjlRMzBkTlVPRXRD?=
 =?utf-8?B?WFJmbzg0Y1ZtWlh0RTQ3UDA0RmwyQnUrRzY4cWI3YzlGM2RTSDNVU1FWZlNM?=
 =?utf-8?B?dkJWQVd2VDhvcEhhODJDWWdUZG9FU29VUjRmTzh0dnVKci9FVzZ6T2ZXamtZ?=
 =?utf-8?B?UG1RTHVlNlFKNjM0YnU4eVI5RkFzcnRIYlQ2d1pCbUNnV3FleXF0TmR5N0oy?=
 =?utf-8?B?c2JJd2lXRUpLSkx3eTQ3SnN0VzVUS0h1a3A3bUpBTmprMWpjUFBHYlhHNUJH?=
 =?utf-8?B?aVNObHFPcWJyNEpyUHgzN216RWxCK1VwMzUrTWtobm5RWk9naDd1TmYwV1Vt?=
 =?utf-8?B?eXl5Sk4yZHN2UEp0UDlCQ1pCbW1jZlVNYS9jUTBZZmVYTitXcm5Pb0h4MVV6?=
 =?utf-8?B?S0hBSnpvcStlMDE0MDY2TGRkaUhZcGhzU0xFQ1NRSnNQTytXeFJlQXY1YmRh?=
 =?utf-8?B?ejRtdGQ4eUVmcFlSN2w2MnZoWEtlaFhqSGFMTVJ0RkJGT09BdmdtZCthc0gy?=
 =?utf-8?B?Z1NkaHVUQUZPRXVPOGNKZlkxdnVTWW1ycW5xSGNHcHpiMWhvdWpUbTZjbkhp?=
 =?utf-8?B?WHNFZ0hYNXB6ZTlCNVVpdTRycWlwbDZKOFdZQjNNVUhWQ0dwL00zdGIySFZD?=
 =?utf-8?B?WWdiRHlxZitORXBUeUEvQXZDdmYrenZKdEZxT0Z2ZVJiZXVJWktZdWlxTnFF?=
 =?utf-8?B?L0ZuZFpHRHdtVk5zTXJOLzBOMGN1MGRucjhHRTFhcWc5SnZIQWJ3d3kwdXZJ?=
 =?utf-8?B?SEtoM2ZSZjFTNCs3bnNoS3cxWWZtcVY0R0NJYXUwVzJ2T09uM01HVnZyeVVn?=
 =?utf-8?B?QzlNT2lFM0FBR2FwOWNPc0M3ckx1U21JekxaVm8ya0N2SktERHpyRWVPaWpp?=
 =?utf-8?B?MlVIcGQ3WnY4TktvVk4xUkNxRGdFUWVIVndXaEpsbEplN0FjNFdFQjdLdGcy?=
 =?utf-8?B?M0pKeWN0WU5oKzZCajcxKy90WEVVTktGQ1RaMm1GNWNMeklJem92ZWxkNHFs?=
 =?utf-8?B?ZjAzOHlvREdYL1hJR2FWS0duWEF6K1g1cXByb2F2ZHhpTCtlVnVUQ3JjSUEr?=
 =?utf-8?B?NTRHRkh5TC9QdSs2dm5tek5xL1NoQk5jR0pHVURMWkVHY25kVHFjd3Z0RFFo?=
 =?utf-8?B?bStsNzJ1L0NHV2RlbnpBL0FHOGswa3NkQ3lWRUxBblg5dHBERUd6WW9hQjI1?=
 =?utf-8?B?dUJPczRuN1VMb05qaTdlYnNtZDZsa0lCaHkvMHBRNnBoVCsvcXBVeXNGb01o?=
 =?utf-8?B?R1h3NWVWWDdPd2NKbU5zQlp3SExnb3JQSVRuSld0MkJjdlVkMjJzUmtsb1BK?=
 =?utf-8?B?K01PeDZ4OFVEVjNwY20zcUlHRThTUVUvYi9UcmlEbExnajF5c1M3dEZhRU0w?=
 =?utf-8?Q?gkJA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 05:14:15.2226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f637eaf-f454-4f67-d351-08de07bbdb4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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



On 10/10/2025 6:52 AM, Alejandro Jimenez wrote:
Hi Alejandro,
> Hi Sairaj,
>
> On 10/8/25 12:43 PM, Sairaj Kodilkar wrote:
>> Physical AMD IOMMU supports upto 64 bits of DMA address. When device 
>> tries
>
> s/upto/up to/ and "a device"
>
>> to read or write from the given DMA address, IOMMU translates the 
>> address
>
> "a given DMA address"
>
>> using page table assigned to that device. Since IOMMU uses per device 
>> page
>> tables, the emulated IOMMU should use the cache tag of 68 bits
>> (64 bit address - 12 bit page alignment + 16 device ID).
>>
>> Current emulated AMD IOMMU uses GLib hash table to create software iotlb
>> and uses 64 bit key to store the IOVA and deviceID, which limits the 
>> IOVA
>> to 60 bits. This cause failure while setting up the device when guest is
>> booted with "iommu.forcedac=1".
>>
>> To solve this problem, define `struct amdvi_iotlb_key` which uses 64 bit
>> IOVA and 16 bit devid as key to store and lookup IOTLB entry.
>>
>
> I wouldn't necessarily mention and quote the structure name since that 
> is an implementation detail and it might change in the future.
>
> Also, the current implementation also combines a 64-bit IOVA 
> (technically a 52bit gfn) with a 16-bit devid, the real change in this 
> patch is in how those same values are being shifted to construct a 
> hash key that avoids truncation as much as possible. So I'd reword the 
> commit message to highlight that.
>

I will update the commit message to highlight this.

>> Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> ---
>>   hw/i386/amd_iommu.c | 51 ++++++++++++++++++++++++++++-----------------
>>   hw/i386/amd_iommu.h |  5 +++--
>>   2 files changed, 35 insertions(+), 21 deletions(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 0a4b4d46d885..5106d9cc4036 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -106,6 +106,11 @@ typedef struct amdvi_as_key {
>>       int devfn;
>>   } amdvi_as_key;
>>   +typedef struct amdvi_iotlb_key {
>> +    uint64_t gfn;
>> +    uint16_t devid;
>> +} amdvi_iotlb_key;
>> +
>>   uint64_t amdvi_extended_feature_register(AMDVIState *s)
>>   {
>>       uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
>> @@ -377,16 +382,6 @@ static void amdvi_log_pagetab_error(AMDVIState 
>> *s, uint16_t devid,
>>                PCI_STATUS_SIG_TARGET_ABORT);
>>   }
>>   -static gboolean amdvi_uint64_equal(gconstpointer v1, gconstpointer 
>> v2)
>> -{
>> -    return *((const uint64_t *)v1) == *((const uint64_t *)v2);
>> -}
>> -
>> -static guint amdvi_uint64_hash(gconstpointer v)
>> -{
>> -    return (guint)*(const uint64_t *)v;
>> -}
>> -
>>   static gboolean amdvi_as_equal(gconstpointer v1, gconstpointer v2)
>>   {
>>       const struct amdvi_as_key *key1 = v1;
>> @@ -423,11 +418,27 @@ static AMDVIAddressSpace 
>> *amdvi_get_as_by_devid(AMDVIState *s, uint16_t devid)
>>                                amdvi_find_as_by_devid, &devid);
>>   }
>>   +static gboolean amdvi_iotlb_equal(gconstpointer v1, gconstpointer v2)
>> +{
>> +    const amdvi_iotlb_key *key1 = v1;
>> +    const amdvi_iotlb_key *key2 = v2;
>> +
>> +    return key1->devid == key2->devid && key1->gfn == key2->gfn;
>> +}
>> +
>> +static guint amdvi_iotlb_hash(gconstpointer v)
>> +{
>> +    const amdvi_iotlb_key *key = v;
>> +    /* Use GPA and DEVID to find the bucket */
>> +    return (guint)(key->gfn << AMDVI_PAGE_SHIFT_4K |
>> +                   (key->devid & ~AMDVI_PAGE_MASK_4K));
>> +}
>> +
>> +
>>   static AMDVIIOTLBEntry *amdvi_iotlb_lookup(AMDVIState *s, hwaddr addr,
>>                                              uint64_t devid)
>>   {
>> -    uint64_t key = (addr >> AMDVI_PAGE_SHIFT_4K) |
>> -                   ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
>> +    amdvi_iotlb_key key = {devid, AMDVI_GET_IOTLB_GFN(addr)};
>
> This line initializes the key fields with the opposite of the intended 
> values. Please use this initialization style instead to prevent these 
> types of errors, plus it makes the definitions more readable:

Good catch. This was something from my older prototype where fields were 
reversed.
Will update it.

>
> -    amdvi_iotlb_key key = {devid, AMDVI_GET_IOTLB_GFN(addr)};
> +    amdvi_iotlb_key key = {
> +        .gfn = AMDVI_GET_IOTLB_GFN(addr),
> +        .devid = devid,
> +    };
>
>
>>       return g_hash_table_lookup(s->iotlb, &key);
>>   }
>>   @@ -449,8 +460,7 @@ static gboolean 
>> amdvi_iotlb_remove_by_devid(gpointer key, gpointer value,
>>   static void amdvi_iotlb_remove_page(AMDVIState *s, hwaddr addr,
>>                                       uint64_t devid)
>>   {
>> -    uint64_t key = (addr >> AMDVI_PAGE_SHIFT_4K) |
>> -                   ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
>> +    amdvi_iotlb_key key = {devid, AMDVI_GET_IOTLB_GFN(addr)};
>
> Same as above, key fields are initialized in incorrect order. Same 
> easy fix by using designated initializers.
>
>>       g_hash_table_remove(s->iotlb, &key);
>>   }
>>   @@ -461,8 +471,10 @@ static void amdvi_update_iotlb(AMDVIState *s, 
>> uint16_t devid,
>>       /* don't cache erroneous translations */
>>       if (to_cache.perm != IOMMU_NONE) {
>>           AMDVIIOTLBEntry *entry = g_new(AMDVIIOTLBEntry, 1);
>> -        uint64_t *key = g_new(uint64_t, 1);
>> -        uint64_t gfn = gpa >> AMDVI_PAGE_SHIFT_4K;
>> +        amdvi_iotlb_key *key = g_new(amdvi_iotlb_key, 1);
>> +
>> +        key->gfn = AMDVI_GET_IOTLB_GFN(gpa);
>> +        key->devid = devid;
>>             trace_amdvi_cache_update(domid, PCI_BUS_NUM(devid), 
>> PCI_SLOT(devid),
>>                   PCI_FUNC(devid), gpa, to_cache.translated_addr);
>> @@ -475,7 +487,8 @@ static void amdvi_update_iotlb(AMDVIState *s, 
>> uint16_t devid,
>>           entry->perms = to_cache.perm;
>>           entry->translated_addr = to_cache.translated_addr;
>>           entry->page_mask = to_cache.addr_mask;
>> -        *key = gfn | ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
>> +        entry->devid = devid;
>> +
>>           g_hash_table_replace(s->iotlb, key, entry);
>>       }
>>   }
>> @@ -2529,8 +2542,8 @@ static void amdvi_sysbus_realize(DeviceState 
>> *dev, Error **errp)
>>           }
>>       }
>>   -    s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
>> -                                     amdvi_uint64_equal, g_free, 
>> g_free);
>> +    s->iotlb = g_hash_table_new_full(amdvi_iotlb_hash,
>> +                                     amdvi_iotlb_equal, g_free, 
>> g_free);
>>         s->address_spaces = g_hash_table_new_full(amdvi_as_hash,
>>                                        amdvi_as_equal, g_free, g_free);
>> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
>> index 38471b95d153..8089f9472ac4 100644
>> --- a/hw/i386/amd_iommu.h
>> +++ b/hw/i386/amd_iommu.h
>> @@ -220,8 +220,9 @@
>>   #define PAGE_SIZE_PTE_COUNT(pgsz)       (1ULL << ((ctz64(pgsz) - 
>> 12) % 9))
>>     /* IOTLB */
>> -#define AMDVI_IOTLB_MAX_SIZE 1024
>> -#define AMDVI_DEVID_SHIFT    36
>> +#define AMDVI_IOTLB_MAX_SIZE        1024
>> +#define AMDVI_IOTLB_DEVID_SHIFT     48
>
> Remove AMDVI_IOTLB_DEVID_SHIFT since it is not currently used (I 
> assume it is a left over from earlier prototype)...

Right

Thanks
Sairaj

