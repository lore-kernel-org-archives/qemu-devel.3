Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B8FC87FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 06:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujuJH-0007Ul-F2; Thu, 07 Aug 2025 02:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ujuJ0-0007Or-2D; Thu, 07 Aug 2025 02:40:53 -0400
Received: from mail-mw2nam10on2061f.outbound.protection.outlook.com
 ([2a01:111:f403:2412::61f]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ujuIh-0005Cs-Gw; Thu, 07 Aug 2025 02:40:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoxxEz57EeDHA7Zhus2H9Em2WG4B1rkev3aCUsCqgL0n7KpYO612bRC8dfm7pKNOvLXXm6vviLPVbDdfYWPI27OXoPqFwnrIc6ZCcVUH4HZH3wruPmy/XNT5ZnW3Fh/RKrUYyPL5gNMOwjIJCw8xyiX2KKtHWHRzXLw6hDB/eGKM7vHEzH4p9g0ScvFdjeJgSavC2yMQG6lQq+QZ3B5z4+C52rfgSJB43p2K2gSHIBL4SDqnwcdiJudAxooh88AEddXd5uji080icN8Lewi6G9R36I/LhXbHf3eJIvebiaeeXNYkzkhxeCw8his225Bhm2m+4Yjnsr5s4UCerBSwhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spVgkhJfjOZKhEpyl9yX32ayOhlRTRlGM/geoufNSN8=;
 b=Jyb5LrnwXdvyvOmhjKmQDo9+2n99dWMAZuYIgG6rpmz6NVg8tV6YOFMC2FwuG18mqyFuZSNJqYfIe45XITnwBlKFzACmcp5pKld/5OEZti0D9l50NBF703QdhBLSGeGHIbBZQhoj38gxy7qaigvK8y9mGqDsp62xxgUY9HawE7CDwq9sbWoHEO1zqhK+vH+x7Nc05kcgRELHITUTSt9HIub+O5lqbMYxnsDiOJQbp1/RH3aVe9Yd30d1gFWQnHP5yZdK9lkgFdupP7IGOjX77ZcB6vXQgTMxR3my7BtlXD3Xwurkv/XWsRCcsPUKafx3pFbS57pS1q3oYgKogBwWvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=tls.msk.ru smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spVgkhJfjOZKhEpyl9yX32ayOhlRTRlGM/geoufNSN8=;
 b=zgH7OA9vxTMcgiLhPhPRSyktMMbLrexOksip18qS8sAtosvdfiKiHIqTcqzK3v3GswY6VGhxsI3nOJu5dqsr64jNQs+I5cC/ot2fGF6D8/XpLZ/v3Dxw6WKXXITuso1lZlKvvv6beFlMat6kQOgFmO58LhFGHnjaRvRZPlvAwxk=
Received: from SJ0PR03CA0245.namprd03.prod.outlook.com (2603:10b6:a03:3a0::10)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.17; Thu, 7 Aug
 2025 06:40:17 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0::4) by SJ0PR03CA0245.outlook.office365.com
 (2603:10b6:a03:3a0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.15 via Frontend Transport; Thu,
 7 Aug 2025 06:40:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Thu, 7 Aug 2025 06:40:15 +0000
Received: from [10.85.32.210] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Aug
 2025 01:40:12 -0500
Message-ID: <4cfda863-1c2d-4ecd-a81c-1cac8c26244d@amd.com>
Date: Thu, 7 Aug 2025 12:10:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] hw/i386/amd_iommu: Cleanups and fixes
To: Michael Tokarev <mjt@tls.msk.ru>, <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <richard.henderson@linaro.org>,
 <alejandro.j.jimenez@oracle.com>, <vasant.hegde@amd.com>,
 <philmd@linaro.org>, <Suravee.Suthikulpanit@amd.com>, qemu-stable
 <qemu-stable@nongnu.org>
References: <20250801060507.3382-1-sarunkod@amd.com>
 <703d1159-7bdc-47b7-be08-64d7b000e45b@tls.msk.ru>
 <d29ccd29-d4c6-41fa-8158-93f9a21ab3ba@amd.com>
 <7b278bc0-4752-48fa-b8fa-8a76515069f6@tls.msk.ru>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <7b278bc0-4752-48fa-b8fa-8a76515069f6@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 25420c4c-e299-4ca8-41e3-08ddd57d44d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QkNNRWFEcndSaEZ2Nk1UakhwRFVRWlY1MGxLL0N2YjZoRmowc1F1NUMyVmVS?=
 =?utf-8?B?azVSMW9rbjhHY2d1TTR6ckJFREU4N2RubjNLTDVya21vWFlDZHJaMHVSdE5o?=
 =?utf-8?B?VlI0RTd4Q2k5U1BKQUFQNWM2ZUYxRVNQS0g3L1Zuay9kV2FRcStxSCtMVUZ6?=
 =?utf-8?B?dlBNL09ERDNCREg4dTh0b1EzcjZxMEdsKzBVM2pZdmlmSFVKbFV3WSszd3Q4?=
 =?utf-8?B?cHRTYUZzYVl3R3BESXVrRlFySElsd2ZoZGx5ZVpHZkUyT094bE9hTnd0S1BR?=
 =?utf-8?B?QzRJcjFTbEZDV0FNU3FUQ3hseldicm1NcnoxcDVkV3UrdmgzSHdKMjcwN2wy?=
 =?utf-8?B?Y3hVenBHN1ZDYU5IZTZyZEROaXlmMVhiR1JwZWJycGZSajk0YTdGTDBmNFpU?=
 =?utf-8?B?ZUNSN1kvRm1yMVVpeHZ1MGMvRTFQNzdnNWZHcWxTcXgveHYxVVk1dmg0cmdw?=
 =?utf-8?B?T01SRTBXdTVrNGYrTVhJY3FjZ3hlU1V2RXFoWFhVYkp3OFIwVDlZZmNONGJo?=
 =?utf-8?B?NDZ5aXRLSEs4OTRmU3NGWGZwWHZsczJ3VUpOWEpPTHVXT25pTjhkVXZwamJ4?=
 =?utf-8?B?MmJobHp2bjVsNEF4THdqYnA0bytXWi8rSmtCUnhsSlRnTnZiVkNxY1czSlFT?=
 =?utf-8?B?TGg0VVdhYjJ2bmtUd2FGaCtxNDR2am5xK3B1WllrUWYwNUVLUVB3cnhleWZT?=
 =?utf-8?B?cmYzVFFrNFF6NUlWUjZPNnZ1WFdLS0JvUEFkLy82WkczaWdleWZkYkZSL2hJ?=
 =?utf-8?B?MENCYWVqOExUK0Q5dlhnSEVMejRVSGpCYndzNjVaRkdBaXFiUFVzVTBVS0JB?=
 =?utf-8?B?NS9BL3BrQVE2cnRTZm9YU1I4Yy94Ulpac04vbjRzbkpsWVk2V2QxU2I1Y3Zq?=
 =?utf-8?B?U01wQlVwNmFuR01oMGg4RnhobWZITWJCSHFTNitHOUVNY3ZiYy9HZ3laQ2FB?=
 =?utf-8?B?VWJ2NWsySC9ST2MxWjUrU0lkZXBBbWh6QjZ6eHlweTRFQ21DUTcydXlvUmQ3?=
 =?utf-8?B?QmlFbTdIc0g2QVpWanplSGg1M0ZJc0VSZU9ISVBXVjFtUjJqRmFOVHNxWFJF?=
 =?utf-8?B?NEZSNnR3VmpCK2tlckFtM245U0RKVnBZRGRDalJCMDlodHJoQjVKLzZ2MGpJ?=
 =?utf-8?B?V1loMEhKakM0Z1gzNHJBTXhvUVdJZU1oMmZ0anlYNTd6b3pUd1pqQXVkSEFY?=
 =?utf-8?B?cmxIUkpEYyt6eFN2TzU3cy9RVzlyYnhzanhVN043S2xBQXVMNG9tRWNZV3dq?=
 =?utf-8?B?ak1XVHJEMVdxQ2ZGdGJsWGRyK0NjWkZsS2xWNytHamEvZzJrRGtLRDVpWEM3?=
 =?utf-8?B?c1JRTUphbC9mNm8xM2psVTFlOFpyaE03bE5xc24yMFVCTk5FNGpDMFhvbDdx?=
 =?utf-8?B?UTU3dmhYWjNDR2p5WDF1ZEZsVU1YOWw3cFJ5OEtMejFDZTBZM3Q0K2lnRDV6?=
 =?utf-8?B?VkN2RUZYcVBnVEoxdFlJeTR5Q0IzTHlzK1ppL1JCa3FYSnJTOTYzeFduZ04v?=
 =?utf-8?B?amhvUnFzeDg5UjR2Tk9PYXp5VEIrbDc5eCthdEl3Mnp5VHdZOGVVQzJFeFAv?=
 =?utf-8?B?VW03QUM3S3g2SGx2MTJTYlhMYkZEcTROa21IeVBiUnJRRE94cTIvRGUxOEta?=
 =?utf-8?B?ZUF5SlREdVU4M3Y5WERQajZYNk80V09vcnBlVnkremg1SS9mTE4xVUM2ckg4?=
 =?utf-8?B?WkVGWEVpUGlMVVN1QWJDNnR5aXRUa1huTWhsTUNoYW9TZ3hrSXJDUE9XTVRV?=
 =?utf-8?B?ejJ5TlVuMU00eGxrTkttMFBkNmdBZGZMRjAzOVptMGxITUxPelVKZEZzbzVo?=
 =?utf-8?B?eTRkY1RQeVlOMEJGZkx3NmVOcGJyckF6R2ZESnZqdExkZDRyYytENWJISjZr?=
 =?utf-8?B?R3lYMVdXTTJoc1FwVG1LWUo1TTdEVEd1Z3hPT1c0MTlwcFltdSs4L0Y1N25a?=
 =?utf-8?B?amN5RjR4M3FHbkJNMDNRM3NsU2NCWDZZY1dkbWlBZFJFcVh3b3BzZUhhUWlk?=
 =?utf-8?B?ZkRmdTVRc0xMVjY2R3NLU3pSaldXcXRGRFBwckE5dkl4QmErUEM5WHNybkNi?=
 =?utf-8?Q?JyPTy2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 06:40:15.7793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25420c4c-e299-4ca8-41e3-08ddd57d44d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451
Received-SPF: permerror client-ip=2a01:111:f403:2412::61f;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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



On 8/6/2025 12:28 PM, Michael Tokarev wrote:
> On 04.08.2025 14:06, Sairaj Kodilkar wrote:
> ...
>>>> Sairaj Kodilkar (6):
>>>>    hw/i386/amd_iommu: Fix MMIO register write tracing
>>>>    hw/i386/amd_iommu: Remove unused and wrongly set ats_enabled field
>>>>    hw/i386/amd_iommu: Move IOAPIC memory region initialization to 
>>>> the end
>>>>    hw/i386/amd_iommu: Fix amdvi_write*()
>>>>    hw/i386/amd_iommu: Support MMIO writes to the status register
>>>>    hw/i386/amd_iommu: Fix event log generation
>>>>
>>>>   hw/i386/amd_iommu.c | 102 +++++++++++++++++++++++++++++++++ 
>>>> +----------
>>>>   hw/i386/amd_iommu.h |   2 +-
>>>>   2 files changed, 80 insertions(+), 24 deletions(-)
>>>
>>> Hi!
>>>
>>> Is there anything there worth to pick up for qemu 10.0.x stable series?
>>> (the "Move IOAPIC memory init" does not apply to 10.0 already).
>>
>> Hi MJT,
>>
>> I will backport the patch manually and send it to qemu stable mailing 
>> list
> 
> Hi!
> 
> There's no need to back-port it, -- there's just minor context fix
> required, here:
> 
> +++ b/hw/i386/amd_iommu.c
> @@ -1693,19 +1693,16 @@ static void amdvi_sysbus_realize(DeviceState 
> *dev, Error **errp)
> ...
> 
>       s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
>                                        amdvi_uint64_equal, g_free, g_free);
> 
> -    /* Pseudo address space under root PCI bus. */
> -    x86ms->ioapic_as = amdvi_host_dma_iommu(bus, s, 
> AMDVI_IOAPIC_SB_DEVID);
> -
>       /* set up MMIO */
>       memory_region_init_io(&s->mr_mmio, OBJECT(s), &mmio_mem_ops, s,
>                             "amdvi-mmio", AMDVI_MMIO_SIZE);
> 
> the "s->iotlb = g_hash_table_new_full" part were added by commit
> f864a3235ea1d1 "hw/i386/amd_iommu: Isolate AMDVI-PCI from amd-iommu
> device to allow full control over the PCI device creation".  It should
> be okay to just remove the 3 marked lines from here (to be moved to
> the right place).
> 
> My question was not about back-porting this commit, but more about
> the set of commits which needs to be picked up for the stable series.
> 
> I picked up this commit.  Please let me know if there are other changes
> needed to be picked up.
> 

Hi MJT

I think this one is sufficient.

Thanks
Sairaj


