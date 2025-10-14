Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D533ACCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 09:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8b5G-00035G-Ic; Tue, 14 Oct 2025 05:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v8b59-00030H-ST
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:12:37 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v8b56-0001BF-H5
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:12:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4FyyvCSl5SqD2QlgxNkGHKJlA/YQfKSBoAEa18iqTiKvqy7IPqd3ohgy1JhRaM40bv7R8gfhhg10MughXYQweyK11/PaA0VAFZFuWoANt9W1p+t2VOyRXKC9N4sq31+EJoro3ly2LMpiLfkoVihy2z8H7GM9iquJIK3NsnoKnJov0pIIRvTJChlFhRB76M9/QOAT5yXniSBwcZCkeCINQZRB8Z2HznRp7/3J1h132yb/hJbLYaPagksqAZI9Gfm00KUvpZ6zik1NAFJxqk7+iUcfTBlQppdneF6AG5Pj3I4N5CBRCbAytH8c4eHEl4QJHBBScl+vfYt6ExRsWdOWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYFajU3K+k0yB0OspNxco1hURagvByaty8BCgUnaMQw=;
 b=D9QL2x2SoT3E+62OxqImUmx38/G7e06iM4TnSq5fNzwu0vtLlO/1kvsmiKXQd2WVsMn6iGwi3DC5EpYVoU1Iyo3qIyqjwYiKBVqz3w3+2alCJj54Oz+YgbUz1n+iygXip1UAr5HGN4wjHAzJ5jmGM79AJTGV34LQuglW1tXoFMm2pH0VI+Gzr33t6WrUth5WN7wz250/zlww5nrlZymSkPBZgDlaF9kfD46T+oSC2cdU82hDxgi/Z3tlIHX0cMN7eDPhWxtIGNZsjAGfdUOqHSWsDxzkldwJMlfQXVrLkA192aoTA/LHVrAFOUrxZ33pmQHtxGvJPct4R86lfS/BJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYFajU3K+k0yB0OspNxco1hURagvByaty8BCgUnaMQw=;
 b=nV5ouQc5DWcerBxhvhb3cYICoTiblGgX6diY3EAXb1kfbG3dF5R1OY5neMVcFYRUAOQ0CBgglasPT9rYNgc0GzoPcSQMuhXX/quBrItWG1agw+geoeEh3R8DV8C+x2Uy8FQJx7mg9KoQM4dSYDWy+aKMkIswwQC2DCQN2Dvvppg=
Received: from BLAPR05CA0036.namprd05.prod.outlook.com (2603:10b6:208:335::17)
 by SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 09:12:23 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:208:335:cafe::82) by BLAPR05CA0036.outlook.office365.com
 (2603:10b6:208:335::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.9 via Frontend Transport; Tue,
 14 Oct 2025 09:12:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.0 via Frontend Transport; Tue, 14 Oct 2025 09:12:23 +0000
Received: from [172.31.35.81] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 02:12:19 -0700
Message-ID: <17411c21-eaf2-41e2-b2e1-2102ec745637@amd.com>
Date: Tue, 14 Oct 2025 14:42:12 +0530
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
 <e4c5d25c-572c-45fe-8e64-b6f141c0f82e@amd.com>
 <20251014050512-mutt-send-email-mst@kernel.org>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20251014050512-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|SJ1PR12MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d64fb2-4edb-4383-0d0d-08de0b01c979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDhwYzZlU2Viay9uc0xyNXVydXBCM1hoaDIrUi8vUEhSS2k1ME1SQ1pOQUl6?=
 =?utf-8?B?dVpHODVlaGFBWEdVeERDeUh2Q0FrWU9aN2pDS1dObWR1V2U0Q2M0TGE5T1RT?=
 =?utf-8?B?ZVZ2dWpwOWdXejRsdXlxeDQvOURHb2pGV3dZbk1mMi9qeFZrQ0hETUNNdzlM?=
 =?utf-8?B?cHFOMW1hNHRaK3M3QWJ0ZGdFcHRvYW1vbmpkLy8zRGFUbmpyNDd0YnF3OTdn?=
 =?utf-8?B?bFk2R1FwRFBlMHhPMHZ0N1BjMHJMTmY3WXhoSHNmQnNKT3lLV0ZTYmJ6cm9l?=
 =?utf-8?B?Sk1JWE1RN0NNY25JUEJqT3lSeDlxVHJYZVZOeU5VYzg1VFFRaTlEZDR4cHlC?=
 =?utf-8?B?cFdlVUpxSVQ3S1cwOUZCZHNlelBkTFNMRjFUK0dtTFM4OEdLTUFoeThKTCtv?=
 =?utf-8?B?eFUzVncrSTRlalhGbVhscmREZ3ZSb2Z1ZEdUR3lsRUtlSHhIbXZranU5dkJv?=
 =?utf-8?B?bFROZ3VLTHVtZlZsZklEbWNSMnBLTGt0RUhjc1RRUnM1Umd3eHRpQmlwR2g3?=
 =?utf-8?B?ekVxTjFUMGNFWXVRbnlkSlpHNFFNR28zT1BIVHh1YmNuUGFmWUQrWjFWaTVE?=
 =?utf-8?B?enRoTFFNeWJaK2MvcFcxdkQ1RE9jU1BwdkVMSW9PcEFQZzNkS3dyVkIvVlEw?=
 =?utf-8?B?ekJvRXhuS244MWg3N0lUbEhCUFZ1bXVHbmNHam1GOVRvZ3Q5cFBGSStVN2FM?=
 =?utf-8?B?dUVIaE5GOTRKUGRzeUNoRDRvRWtGbklYYmppYk8zTWUyZ2ZTekEray9ZYkxI?=
 =?utf-8?B?eEM0N3kwTUoydnZDUE9SeTFaWDA3dWN2allXV3BCZjduY2tOVWUxUU1GS3J1?=
 =?utf-8?B?QmJ6d25RRjNZaHNKK3RiSElkVzZhNlRUMGRCMy9RR3BXWWdWMEVHYWZBVlk1?=
 =?utf-8?B?YUhLZ2RaczhLeGpFUjFtbHpQZHVYdXh0SzZnaTBMVUtDNmlYTVJqVGxIRklz?=
 =?utf-8?B?QmVONjI4dU51SFJrM2FQaUJ1TUxITjlEUTZMMGZzT1dFYVJTVk5pWDFCYnEz?=
 =?utf-8?B?MmFNUHhWTUZEa2ZFc0cwdnRsQUtWblBIRnRucy9DYTY0Uitpd29aaEc2MDBu?=
 =?utf-8?B?SE9jZkRINHUvNFdMZjFlY3FBb0VNekMvaUxZRi9oYTE2eDRoZWdmc1ZDUGU5?=
 =?utf-8?B?aFB2WTIvL2M3N09sRXdwVTRuejZ3OEJaYUpMYkk4bkcwRk9nSFFOSkxvZE1u?=
 =?utf-8?B?ekRESFlvWklibElvUkV5Q3c0WG84TjN0LzRiV3pxVzRaa0d1YmZWMEdYZTd4?=
 =?utf-8?B?a3J3cTU0UElFRWo3MUxCdFB1d0RnejN1V2h6Szd2ckl2MkpLQlJseStKazZt?=
 =?utf-8?B?K0hWdHV1TXF6Nk8xMjc5b2s0Q0ZpenFjWDVIWnhaaUY1K3NWdElSTEh2Vmwx?=
 =?utf-8?B?dHZTWVBRYlgrcGZ0Yjl3Sm5jQ1dFNE5RTWpUa3o2T09kQi9rQTJoUlZwS0JM?=
 =?utf-8?B?UWlhN3M2c29SMmZwa0ZFMjNrSE1FenZod3E0MWRuQ0tHNkZ4UmxRUDgyTjlv?=
 =?utf-8?B?RjZ4dW1Oc1F3VDRkelNFQmJ6OGt5bm5PS1liNUFlS05OUkhoMndWTHZoZDBt?=
 =?utf-8?B?SVNxcEZMaWRUTnVnQ1NPaEtYR1UyTHB4c3ZmVkhreVZmcDA3MXNxdUNJbE1X?=
 =?utf-8?B?OU16NDQzL2FvQXIyVlhMVithQ0FOb1NCWW5ZaVpXRlBFNkZnNHZqcHd4dHpD?=
 =?utf-8?B?Z0xndFFQRHpHb0NwUzJNNGNNVklTVks1V2xWZkVHam10VzZTdUxVS0VsSGhM?=
 =?utf-8?B?eUN5Vml6cDlGRCswbnpTNWlwcCtucUpLbkpqQTZLUHJ1T200d1FVYXJBZGN6?=
 =?utf-8?B?M0t6dVh6czB3bUJKZ3BWTFZ4RkJyWE1kUTZSSG9Pa2ZBL091clpKeS9kZXRF?=
 =?utf-8?B?SGYxY3hLc21PMUxmc0wwcXZOdEpaN1UvaHl0MC9YbzRJSkNnM2tZaUhvbjQ0?=
 =?utf-8?B?UUJ6OVFWaGRySUljbzNzRkE4ZkdGV2tMZDlJMXlmZkdKVEVHVWkraEllQXp2?=
 =?utf-8?B?ZHNOL2EwZ2lPb3poK0UwVy90bWdHM3hONGdmMGlrRk9WZ3RYaURocVZ3R2pv?=
 =?utf-8?B?dzRTZDZwTWxDaGxZNjNFYklQcVpaMDkwSGJiVWFGcEoxWUdITVFVbGNXRTVa?=
 =?utf-8?Q?VSSE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 09:12:23.5789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d64fb2-4edb-4383-0d0d-08de0b01c979
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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



On 10/14/2025 2:35 PM, Michael S. Tsirkin wrote:
> On Tue, Oct 14, 2025 at 02:34:28PM +0530, Sairaj Kodilkar wrote:
>>
>> On 10/13/2025 1:49 PM, Michael S. Tsirkin wrote:
>>> On Mon, Oct 13, 2025 at 10:30:46AM +0530, Sairaj Kodilkar wrote:
>>>> Physical AMD IOMMU supports up to 64 bits of DMA address. When device tries
>>>> to read or write from a given DMA address, IOMMU translates the address
>>>> using page table assigned to that device. Since IOMMU uses per device page
>>>> tables, the emulated IOMMU should use the cache tag of 68 bits
>>>> (64 bit address - 12 bit page alignment + 16 bit device ID).
>>>>
>>>> Current emulated AMD IOMMU uses GLib hash table to create software iotlb
>>>> and uses 64 bit key to store the IOVA and deviceID, which limits the IOVA
>>>> to 60 bits. This causes failure while setting up the device when guest is
>>>> booted with "iommu.forcedac=1".
>>>>
>>>> To solve this problem, Use 64 bit IOVA and 16 bit devid as key to store
>>>> entries in IOTLB; Use upper 52 bits of IOVA (GFN) and lower 12 bits of
>>>> the device ID to construct the 64 bit hash key in order avoid the
>>>> truncation as much as possible (reducing hash collisions).
>>>>
>>>> Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
>>>> Signed-off-by: Sairaj Kodilkar<sarunkod@amd.com>
>>> I am wondering whether we need to limit how much host memory
>>> can the shadow take. Because with so many bits, the sky is the limit ...
>>> OTOH it's not directly caused by this patch, but it's something
>>> we should think about maybe.
>> I don't think I fully understand this. Do you mean the host memory
>> taken by the pages used to build shadow page table ?
> the memory used by the hash table.

Right now it defines macro 'AMDVI_IOTLB_MAX_SIZE'. If iotlb hash
size is greater than that, code resets the hash table.

Techinically, right way is to implement a policy such as LRU, which
we can work on in future patches.

Thanks
Sairaj

>>> Something more to improve:
>>>
>>>
>>>> ---
>>>>    hw/i386/amd_iommu.c | 57 ++++++++++++++++++++++++++++++---------------
>>>>    hw/i386/amd_iommu.h |  4 ++--
>>>>    2 files changed, 40 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>>>> index b194e3294dd7..a218d147e53d 100644
>>>> --- a/hw/i386/amd_iommu.c
>>>> +++ b/hw/i386/amd_iommu.c
>>>> @@ -106,6 +106,11 @@ typedef struct amdvi_as_key {
>>>>        uint8_t devfn;
>>>>    } amdvi_as_key;
>>>> +typedef struct amdvi_iotlb_key {
>>>> +    uint64_t gfn;
>>>> +    uint16_t devid;
>>>> +} amdvi_iotlb_key;
>>>> +
>>> Pls change struct and typedef names to match qemu coding style.
>> Thanks
>> Sairaj


