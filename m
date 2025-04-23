Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD7CC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 06:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Tbb-0002io-6u; Wed, 23 Apr 2025 02:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u7TbR-0002ZU-LN
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 02:29:02 -0400
Received: from mail-dm6nam10on2060f.outbound.protection.outlook.com
 ([2a01:111:f403:2413::60f]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u7TbN-0003Jt-1c
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 02:29:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbkaEJlcLCdfKSBMF6p6B/N9oF//3Upb6tzZwCdV6fPPd2CdckioGjfDYsAB3STbBQjZnUltyTsOdMaKkJOfWuTTMFuf3sGq5g61RON7fksYGzZdkIVXR2nXnyCwWzvCddvh0FE7vcqIR1nsffBEFJgFJ+Hf0NXhoLxdTWYzvIh8LQNyc0DJCINHEG5NHbjUZRbic5+aVcaXB6wG4F+mbaCUrgw65UKuHKeSKDOCF+bpTRG92Y9E7tkv/GQ69b0XfhPCiQ17i70vSJEcMNQvbCdyF6Op3n7zAfqwk9S55J8VKRZt1+49vTJ52cBfqOsHckyqMTguBrpO21nkBRZQkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7g28WOcp9BzXmdwnFTlbTtoAg3k4qco95Gu6JWWGdQ=;
 b=CsaOeccYNhMJsGZd312G0awoc3df6NxeoiPeT2cn2x37PvgFDBJT8BIyEbO31EHbTGHGrEBor+DuQT5BOfBgVbXM3lQrh8s1b94cspivFFGM4KP/E+ez6+oBHAdJeALDvLmP3920XqP/Nzc/ox3OJ6wgDtW3+qt7PcfP8BPiVMc+7Axve09Sq0evXEry2IzWLxkIH8EgwUDm3fywPoapfQiGOQGauPe+4CyZjPhgrOuDklpF7r482coQbtbBnHyNVX2Oh3a762zrjkZ0UO+NNmgvWkBzSVjrt2+uyLl6I36IabpH7HujiwcP/6fcSDEbxPkZjEyNwFnaJy89lop+sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=eviden.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7g28WOcp9BzXmdwnFTlbTtoAg3k4qco95Gu6JWWGdQ=;
 b=WCxwv9evoibQxYL1iQdPN+h/1XApAygVE8vrD7uHU2UluSOPDb2V025nfy64o5TYibbkDuwBkyoWdZyzGVngdiIYAvTgXN7D/XhqEE+NCkD6h+dWGAywoPKj6qpf2NZ0QjQp5zvE/MUXpnzGD0CDmA+XzS+KUcYRqZLNr/bhwlc=
Received: from MN2PR08CA0021.namprd08.prod.outlook.com (2603:10b6:208:239::26)
 by CH3PR12MB9193.namprd12.prod.outlook.com (2603:10b6:610:195::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Wed, 23 Apr
 2025 06:28:46 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::da) by MN2PR08CA0021.outlook.office365.com
 (2603:10b6:208:239::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Wed,
 23 Apr 2025 06:28:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 06:28:46 +0000
Received: from [10.85.41.53] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 01:28:40 -0500
Message-ID: <c8e4d4b3-7546-4dd4-b76f-6a9ea04f2257@amd.com>
Date: Wed, 23 Apr 2025 11:58:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/18] amd_iommu: Add helpers to walk AMD v1 Page Table
 format
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>, "Alejandro
 Jimenez" <alejandro.j.jimenez@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "peterx@redhat.com"
 <peterx@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "santosh.shukla@amd.com" <santosh.shukla@amd.com>, "Wei.Huang2@amd.com"
 <Wei.Huang2@amd.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "boris.ostrovsky@oracle.com"
 <boris.ostrovsky@oracle.com>
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
 <20250414020253.443831-10-alejandro.j.jimenez@oracle.com>
 <32609749-864c-4fe2-8c00-8dd8e0ab2efc@eviden.com>
 <4162f7d1-a4e3-47b7-8288-d8e320ed18b3@oracle.com>
 <b1dbf15a-b2a1-43e0-bfc8-6b4ca3d18e66@eviden.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <b1dbf15a-b2a1-43e0-bfc8-6b4ca3d18e66@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|CH3PR12MB9193:EE_
X-MS-Office365-Filtering-Correlation-Id: df15eca7-24b0-43be-3902-08dd82301a03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eG5yYllPZEltOE9CRDJ2dEhMelZxSU1nYWptZXEzWGo3WlZjTzlKbHR6UnZZ?=
 =?utf-8?B?RGxmbmNGS0diZ0VwWVZRcXA0bFE1ekFvS0lMTnRPaUtEQk9Td3ptMWY2UTJR?=
 =?utf-8?B?cnQxdUUzaHZneitSdWtBRml6SmxwRVVKbGxrVXlTbWpTbWU5MmluN0tQZkR5?=
 =?utf-8?B?TjZGV1U3Zzd0aEIwUitQVExsbWlFUnRsVVY2V2hxMGNEbjUzRjFRbVpFMVlQ?=
 =?utf-8?B?SkMxdzlTNGFWTjhPK0NoakJYTkhPUFkvcnlCVWlNYUVsNU85Q1drKzBtMVFO?=
 =?utf-8?B?b1g4N05TOWZaSXZ3TXd1VmkzM2thYVV2ZTRvaDFSMlYzbW1UVDh5cWJkWDNz?=
 =?utf-8?B?MGZHczZXQTExTW5TemxYMWhzZ0FmNTZyVjE4TWR0Q2hNRmZDNTNUODNLdDdQ?=
 =?utf-8?B?dDlpbjdoMnFpV21NREQvUXI3ckJzZ3pOMHpTQ1hCaFpGWCt3L2ZzSXR3M1BS?=
 =?utf-8?B?MEdOZkdmYUFHUHZuYmRML2dmL0xpL2VSLzRrYm5yMno4VCthVDZoV1E0Ujgv?=
 =?utf-8?B?cjFzZ1c0UVU4eTVpT1lDYnM4Wm1aRmNpSk16b0Q1RFdaelo4YTJLQXBZUUgw?=
 =?utf-8?B?M0xMY09lZ3d6ZWJBbnNuZ1V6RW1QUTRXNTBpTnhoUjhCcnlZOFVwdU5KUmxC?=
 =?utf-8?B?TjZPM1Y5aXlXbnNrSzN5YlVxYkI5d2wzVm95S29IT29CbVZFMXczeTZuUExM?=
 =?utf-8?B?QWxOZllOYytVWUdwWiswR3llaVQzc0dXSFRWVUJjK0hCa2l3bzlKSkdFUHRq?=
 =?utf-8?B?WDBsamNPU1g1ckEvZml0c0ZKc1NkdWNMVDU5M2N3MUVQK0ZRS0pxR0w1Um1z?=
 =?utf-8?B?N2kzYjM3bUlhbnM4MXlMcVdWb25SZUVtaDlXOEZpL3A4K2FVekJuM0RPZkpx?=
 =?utf-8?B?K1FYa29CZnlDbmJhdXZLVFgxS0VacUF5c2crbUNUTHN0M0hTN0xWanErczEv?=
 =?utf-8?B?UmNqRG81dHhaSXNtMnJGN2hZSlkzTkttN1N1YlFEVTlQSW5VZGxaWjBvK3Bi?=
 =?utf-8?B?RmlPeUkzZ3VtNjN1dmFXcUpEUGtNbHB2UTBsSDUzYVNXSmtXZi8zVDhnZElm?=
 =?utf-8?B?OUg1c2ZkcmpNV2kzWGtuZThobTRmQzVCQmxaYjc3MW9qVTBaSXJ2SkZHb2JS?=
 =?utf-8?B?MmtPVWhPUitpOExSNmV2REFYcGlubUlxejdpbnV3NUF1ZFNUcnY1RHJ4ckNy?=
 =?utf-8?B?aG5UR0RuQnpnMk5MZGJkM3VIOG9CUWhxOHdTNENqdVAzMWVtZ21tWUhnZC8y?=
 =?utf-8?B?TzBZWjlicTh1bmEvT2lhWEZ6WUxuODdpUkEyRjJPeSs4bDNNQUgwRkRQOFJD?=
 =?utf-8?B?T3NHYlVncmlWSVVVSnAzd1ZxNUY1bXhOY1B3TDZPd1A4SERMRmtpMGsveDdq?=
 =?utf-8?B?bHVkd2NjOURKWDlQdlBWRXlZc000OXlpc2dJdkxsenRmWVpYTWJDelpLamcv?=
 =?utf-8?B?cXc3VlhPdW5xdGQ4all6UEJxeTY5U0g5ZnBXM1RWU0grTmpxckp5OXJQRXRn?=
 =?utf-8?B?cFdDaHZzSGE1dUNCK291Y2NUK0hvdzRBL2lxL1ZYTmZ2Z21tUUNxeGVqeDZO?=
 =?utf-8?B?NUsvS3pYRnRZZGd1TCsycmd4cWJVQTAwMEZDTTNBYkU0Smt5T09XVlpOa29Q?=
 =?utf-8?B?N1FUS255T3owTmgyZjFIMEppT3FvTGtrZll6Z2daMlhmMWVYdEdXY3pLbVdk?=
 =?utf-8?B?TXpLWXMwNmIzMDZPVE1DK2NFMFNGZTJqQm5tYmlMenBTemdQSUFTeEZxM3hS?=
 =?utf-8?B?YVN6N1Ryemt3YzltVXA0Rnladml4SGNrcDVhYXk2Q04vTFY0Zis5WXlzNDMz?=
 =?utf-8?B?N0pDZlV0TVVzekdhWm1PRzVpRTRlNnNvWG9wR0dweHRyN3NKbjFUaHQyVEJq?=
 =?utf-8?B?Skt2dU9pYW1BN0VBbVRqSEtOa3d4Nk40THZuK0lSMUJ5blBFRkhPbmhEWHRI?=
 =?utf-8?B?MjRTSWdQd1loaFJVYVltQ1ViVi8wNEt3cHZ0N3gwaDYrdEU4MUVCVjhzc2x2?=
 =?utf-8?B?Ym9lcEg1OFE2b0ROeVh5R3ZVUzFaZmtuaEwxczhTbER6NkM5QUttOXBPTWc3?=
 =?utf-8?Q?NdUH9A?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 06:28:46.2482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df15eca7-24b0-43be-3902-08dd82301a03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9193
Received-SPF: permerror client-ip=2a01:111:f403:2413::60f;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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



On 4/18/2025 11:00 AM, CLEMENT MATHIEU--DRIF wrote:
> 
> 
> On 17/04/2025 5:27 pm, Alejandro Jimenez wrote:
>> Caution: External email. Do not open attachments or click links, unless
>> this email comes from a known sender and you know the content is safe.
>>
>>
>> On 4/17/25 8:40 AM, CLEMENT MATHIEU--DRIF wrote:
>>>
>>>
>>> On 14/04/2025 4:02 am, Alejandro Jimenez wrote:
>>>> Caution: External email. Do not open attachments or click links,
>>>> unless this email comes from a known sender and you know the content
>>>> is safe.
>>>>
>>>>
>>>> The current amdvi_page_walk() is designed to be called by the replay()
>>>> method. Rather than drastically altering it, introduce helpers to fetch
>>>> guest PTEs that will be used by a page walker implementation.
>>>>
>>>> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>>>> ---
>>>>     hw/i386/amd_iommu.c | 125 ++++++++++++++++++++++++++++++++++++++++
>>>> ++++
>>>>     hw/i386/amd_iommu.h |  42 +++++++++++++++
>>>>     2 files changed, 167 insertions(+)
>>>>
>>>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>>>> index 0af873b66a31..d089fdc28ef1 100644
>>>> --- a/hw/i386/amd_iommu.c
>>>> +++ b/hw/i386/amd_iommu.c
>>>> @@ -1563,6 +1563,131 @@ static const MemoryRegionOps amdvi_ir_ops = {
>>>>         }
>>>>     };
>>>>
>>>> +/*
>>>> + * For a PTE encoding a large page, return the page size it encodes
>>>> as described
>>>> + * by the AMD IOMMU Specification Table 14: Example Page Size
>>>> Encodings.
>>>> + * No need to adjust the value of the PTE to point to the first PTE
>>>> in the large
>>>> + * page since the encoding guarantees all "base" PTEs in the large
>>>> page are the
>>>> + * same.
>>>> + */
>>>> +static uint64_t large_pte_page_size(uint64_t pte)
>>>> +{
>>>> +    assert(PTE_NEXT_LEVEL(pte) == 7);
>>>> +
>>>> +    /* Determine size of the large/contiguous page encoded in the
>>>> PTE */
>>>> +    return PTE_LARGE_PAGE_SIZE(pte);
>>>> +}
>>>> +
>>>> +/*
>>>> + * Helper function to fetch a PTE using AMD v1 pgtable format.
>>>> + * Returns:
>>>> + * -2:  The Page Table Root could not be read from DTE, or IOVA is
>>>> larger than
>>>> + *      supported by current page table level encodedin DTE[Mode].
>>>> + * -1:  PTE could not be read from guest memory during a page table
>>>> walk.
>>>> + *      This means that the DTE has valid data, and one of the lower
>>>> level
>>>> + *      entries in the Page Table could not be read.
>>>> + *  0:  PTE is marked not present, or entry is 0.
>>>> + * >0:  Leaf PTE value resolved from walking Guest IO Page Table.
>>>> + */
>>>
>>> This seems to be a bit error prone as any statement like "if (pte < 0)"
>>> might be completely removed by the compiler during optimization phases.
>>
>> Yes, caller(s) of fetch_pte() must cast to uint64_t in any comparison to
>> check for error values. Like it is the case in many of the patches, I am
>> following the examples from the VTD implementations where they do the
>> same thing in vtd_iova_to_slpte() to validate the return of vtd_get_pte().
> 
> Yes, I know :)
> 
> Note that VT-d only has 1 potential error code (-1) which seems easier
> to handle at call site.
> 
>>
>> When using fetch_pte() again in patch [17/18] I considered adding a
>> helper to check if fetch_pte() returned a valid PTE, but seemed
>> unnecessary given that there are only two errors to be checked.
>>
>> Another choice was to make fetch_pte() return an int so the error check
>> could be done simply via (pte < 0), since bit 63 is either Reserved
>> (DTE) or Ignored (PDE/PTE), but that seemed more prone to confusion
>> since you'd expect a PTE to be a 64-bit long value. Though I am aware
>> the way error return/checking is implemented essentially relies on that
>> behavior.
>>
>>> If you want to reuse such "high" values, defines could help.
>>
>> Sorry, I don't follow. Do you mean using defines as in still returning a
>> uint64_t but giving -1 and -2 special definitions? That might make the
>> code a somewhat more readable when checking the error values, but still
>> requires casting to uint64_t on the check, and doesn't solve the problem
>> of a careless caller using (pte < 0) to check for errors...
> 
> Yes, I think that it would be more readable.
> When using defines, the caller no longer needs to be aware of the fact
> that the value has been casted from a negative number, which reduces the
> risk of writing things like (pte < 0).
> 
> I prefer the out parameter solution but let's see what other reviews say.
> 

I think having pte as out parameter is the better solution here.
less error prone and readable !

Regards
Sairaj Kodilkar

> Thanks for this patch set :)
> 
>>
>>> Otherwise, pte could be an out parameter.
>>
>> In general, I think we have to accept the caveat that callers of
>> fetch_pte() must have some implementation specific knowledge to know
>> they cannot check for errors using (pte < 0). Maybe with the aid of a
>> strongly worded warning on the function header comment...
>>
>> But if that argument doesn't convince you, and none of the alternatives
>> above seem better, then I am leaning towards using the out parameter
>> approach.
>>
>> Thank you for the feedback.
>> Alejandro
>>
>>>
>>>> +static uint64_t __attribute__((unused))
>>>> +fetch_pte(AMDVIAddressSpace *as, const hwaddr address, uint64_t dte,
>>>> +          hwaddr *page_size)
>>>> +{
>>>> +    IOMMUAccessFlags perms = amdvi_get_perms(dte);
>>>> +
>>>> +    uint8_t level, mode;
>>>> +    uint64_t pte = dte, pte_addr;
>>>> +
>>>> +    *page_size = 0;
>>>> +
>>>> +    if (perms == IOMMU_NONE) {
>>>> +        return (uint64_t)-2;
>>>> +    }
>>>> +
>>>> +    /*
>>>> +     * The Linux kernel driver initializes the default mode to 3,
>>>> corresponding
>>>> +     * to a 39-bit GPA space, where each entry in the pagetable
>>>> translates to a
>>>> +     * 1GB (2^30) page size.
>>>> +     */
>>>> +    level = mode = get_pte_translation_mode(dte);
>>>> +    assert(mode > 0 && mode < 7);
>>>> +
>>>> +    /*
>>>> +     * If IOVA is larger than the max supported by the current
>>>> pgtable level,
>>>> +     * there is nothing to do. This signals that the pagetable level
>>>> should be
>>>> +     * increased, or is an address meant to have special behavior like
>>>> +     * invalidating the entire cache.
>>>> +     */
>>>> +    if (address > PT_LEVEL_MAX_ADDR(mode - 1)) {
>>>> +        /* IOVA too large for the current DTE */
>>>> +        return (uint64_t)-2;
>>>> +    }
>>>> +
>>>> +    do {
>>>> +        level -= 1;
>>>> +
>>>> +        /* Update the page_size */
>>>> +        *page_size = PTE_LEVEL_PAGE_SIZE(level);
>>>> +
>>>> +        /* Permission bits are ANDed at every level, including the
>>>> DTE */
>>>> +        perms &= amdvi_get_perms(pte);
>>>> +        if (perms == IOMMU_NONE) {
>>>> +            return pte;
>>>> +        }
>>>> +
>>>> +        /* Not Present */
>>>> +        if (!IOMMU_PTE_PRESENT(pte)) {
>>>> +            return 0;
>>>> +        }
>>>> +
>>>> +        /* Large or Leaf PTE found */
>>>> +        if (PTE_NEXT_LEVEL(pte) == 7 || PTE_NEXT_LEVEL(pte) == 0) {
>>>> +            /* Leaf PTE found */
>>>> +            break;
>>>> +        }
>>>> +
>>>> +        /*
>>>> +         * Index the pgtable using the IOVA bits corresponding to
>>>> current level
>>>> +         * and walk down to the lower level.
>>>> +         */
>>>> +        pte_addr = NEXT_PTE_ADDR(pte, level, address);
>>>> +        pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as-
>>>>> devfn);
>>>> +
>>>> +        if (pte == (uint64_t)-1) {
>>>> +            /*
>>>> +             * A returned PTE of -1 indicates a failure to read the
>>>> page table
>>>> +             * entry from guest memory.
>>>> +             */
>>>> +            if (level == mode - 1) {
>>>> +                /* Failure to retrieve the Page Table from Root
>>>> Pointer */
>>>> +                *page_size = 0;
>>>> +                return (uint64_t)-2;
>>>> +            } else {
>>>> +                /* Failure to read PTE. Page walk skips a page_size
>>>> chunk */
>>>> +                return pte;
>>>> +            }
>>>> +        }
>>>> +    } while (level > 0);
>>>> +
>>>> +    /*
>>>> +     * Page walk ends when Next Level field on PTE shows that either
>>>> a leaf PTE
>>>> +     * or a series of large PTEs have been reached. In the latter
>>>> case, return
>>>> +     * the pointer to the first PTE of the series.
>>>> +     */
>>>> +    assert(level == 0 || PTE_NEXT_LEVEL(pte) == 0 ||
>>>> PTE_NEXT_LEVEL(pte) == 7);
>>>> +
>>>> +    /*
>>>> +     * In case the range starts in the middle of a contiguous page,
>>>> need to
>>>> +     * return the first PTE
>>>> +     */
>>>> +    if (PTE_NEXT_LEVEL(pte) == 7) {
>>>> +        /* Update page_size with the large PTE page size */
>>>> +        *page_size = large_pte_page_size(pte);
>>>> +    }
>>>> +
>>>> +    return pte;
>>>> +}
>>>> +
>>>>     /*
>>>>      * Toggle between address translation and passthrough modes by
>>>> enabling the
>>>>      * corresponding memory regions.
>>>> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
>>>> index c89e7dc9947d..fc4d2f7a4575 100644
>>>> --- a/hw/i386/amd_iommu.h
>>>> +++ b/hw/i386/amd_iommu.h
>>>> @@ -25,6 +25,8 @@
>>>>     #include "hw/i386/x86-iommu.h"
>>>>     #include "qom/object.h"
>>>>
>>>> +#define GENMASK64(h, l)  (((~0ULL) >> (63 - (h) + (l))) << (l))
>>>> +
>>>>     /* Capability registers */
>>>>     #define AMDVI_CAPAB_BAR_LOW           0x04
>>>>     #define AMDVI_CAPAB_BAR_HIGH          0x08
>>>> @@ -174,6 +176,46 @@
>>>>     #define AMDVI_GATS_MODE                 (2ULL <<  12)
>>>>     #define AMDVI_HATS_MODE                 (2ULL <<  10)
>>>>
>>>> +/* Page Table format */
>>>> +
>>>> +#define AMDVI_PTE_PR                    (1ULL << 0)
>>>> +#define AMDVI_PTE_NEXT_LEVEL_MASK       GENMASK64(11, 9)
>>>> +
>>>> +#define IOMMU_PTE_PRESENT(pte)          ((pte) & AMDVI_PTE_PR)
>>>> +
>>>> +/* Using level=0 for leaf PTE at 4K page size */
>>>> +#define PT_LEVEL_SHIFT(level)           (12 + ((level) * 9))
>>>> +
>>>> +/* Return IOVA bit group used to index the Page Table at specific
>>>> level */
>>>> +#define PT_LEVEL_INDEX(level, iova)     (((iova) >>
>>>> PT_LEVEL_SHIFT(level)) & \
>>>> +                                        GENMASK64(8, 0))
>>>> +
>>>> +/* Return the max address for a specified level i.e. max_oaddr */
>>>> +#define PT_LEVEL_MAX_ADDR(x)    (((x) < 5) ? \
>>>> +                                ((1ULL << PT_LEVEL_SHIFT((x + 1))) -
>>>> 1) : \
>>>> +                                (~(0ULL)))
>>>> +
>>>> +/* Extract the NextLevel field from PTE/PDE */
>>>> +#define PTE_NEXT_LEVEL(pte)     (((pte) & AMDVI_PTE_NEXT_LEVEL_MASK)
>>>>>> 9)
>>>> +
>>>> +/* Take page table level and return default pagetable size for level */
>>>> +#define PTE_LEVEL_PAGE_SIZE(level)      (1ULL <<
>>>> (PT_LEVEL_SHIFT(level)))
>>>> +
>>>> +/*
>>>> + * Return address of lower level page table encoded in PTE and
>>>> specified by
>>>> + * current level and corresponding IOVA bit group at such level.
>>>> + */
>>>> +#define NEXT_PTE_ADDR(pte, level, iova) (((pte) &
>>>> AMDVI_DEV_PT_ROOT_MASK) + \
>>>> +                                        (PT_LEVEL_INDEX(level, iova)
>>>> * 8))
>>>> +
>>>> +/*
>>>> + * Take a PTE value with mode=0x07 and return the page size it encodes.
>>>> + */
>>>> +#define PTE_LARGE_PAGE_SIZE(pte)    (1ULL << (1 + cto64(((pte) |
>>>> 0xfffULL))))
>>>> +
>>>> +/* Return number of PTEs to use for a given page size (expected
>>>> power of 2) */
>>>> +#define PAGE_SIZE_PTE_COUNT(pgsz)       (1ULL << ((ctz64(pgsz) - 12)
>>>> % 9))
>>>> +
>>>>     /* IOTLB */
>>>>     #define AMDVI_IOTLB_MAX_SIZE 1024
>>>>     #define AMDVI_DEVID_SHIFT    36
>>>> -- 
>>>> 2.43.5
>>>>
>>>>
>>


