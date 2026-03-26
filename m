Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62ECC109E55D
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 06:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5efJ-0001ry-ST; Thu, 26 Mar 2026 02:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1w5efI-0001rn-1H
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 02:58:00 -0400
Received: from mail-centralusazon11010051.outbound.protection.outlook.com
 ([52.101.61.51] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1w5efG-0005AZ-0W
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 02:57:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sr0Vkh8G2h8VOTWRnNvpGjLThfUo+Pgj4AoDxTorq5XiIcRqwLziJ1cT2tZF2LGDNsmx09I+RStSB53SpAFzZ1r/NfXOn4fFGJWBswoSBuLXph9FVK0+QkbQ1zVE6iMvMybJ6FDXaOroJpGESlaTuKFVGd76g1+HJzrFCOD16jV4IzSGD/YfBTqZCC8UqIHpPztbWdc9j3ySLWwkGLwTO2Tg1HA2hKlYrYMd0luRRL0bij6OCRVt5w16z0fodQdUUWBvFYgoLHp5aesbtEcXvKiJg4eilU2ocDRtzEKK7kWC+SiW2nV37yg9+Cvix9ZEGkffp/jXvKW9ZTbWmaq/sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6gpOqBqCQ8J0CiyAeD2dF2ICcfdBe5vPCceQbLdrP4=;
 b=oKxXKM/UJLLa4WajbTAHwrXuAqSqF3QRlByJEhvtVs+QNK6pHPWvGLF6PzgL0tXnJWRRTNRy/RhqZQ6BueR8OfRK8cVqNEhb4Rd27Zo2NNWwjpj9p9w2jHLO2zm8pCXwMKpib15pAsoqqPqdlX2Hc8mHqMqmEhWBfxjDrYiFq63NCKG5Q47KRIx3kt4LThp8sABIXbC7pskodqXXwI9xZuwYx4hrt2N13+opXM0TQ0lHcNO3LA2YEC5GYjJ+zX8oo6cTfCJ1JhWbSdSPhpQ9Bmh2ZZD6g4eyw3NGYkmio5IdsXEEr99xpNBzPOPurf0DvQ00PFDdLDOovfRb0/xHmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6gpOqBqCQ8J0CiyAeD2dF2ICcfdBe5vPCceQbLdrP4=;
 b=3620s5Hw6MBXdYFkIjcDUkTXerl0gt5pV0i8ewaHMaQue04SguypzkpuWcPtGd8ltbvRGcO7ZiGI//cIWPYW8eHALQlVvrNJM1hN4FDGBp9HPVqL8BomCp9ydFsUXxe0uVn3VimeAlvWdoIRw9T0j4MzkaXAQ/6aCKjOWkZtkOU=
Received: from PH7P220CA0118.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::18)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 06:52:50 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::cd) by PH7P220CA0118.outlook.office365.com
 (2603:10b6:510:32d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 06:52:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 06:52:48 +0000
Received: from [10.143.201.178] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 01:52:45 -0500
Message-ID: <7c01325b-c509-4121-9b16-c73e2e7dc2a0@amd.com>
Date: Thu, 26 Mar 2026 12:22:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <qemu@demindiro.com>, <mst@redhat.com>,
 <clement.mathieu--drif@eviden.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>,
 <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 1/2] amd_iommu: Follow root pointer before page walk and
 use 1-based levels
Content-Language: en-US
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
References: <20260311203943.2309841-1-alejandro.j.jimenez@oracle.com>
 <20260311203943.2309841-2-alejandro.j.jimenez@oracle.com>
 <2756c509-4286-444a-815c-d6266c3e3a91@amd.com>
 <ba2d7018-7dcc-42d7-ba52-395d4e1d0298@oracle.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <ba2d7018-7dcc-42d7-ba52-395d4e1d0298@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|LV3PR12MB9353:EE_
X-MS-Office365-Filtering-Correlation-Id: 177a32b7-e76d-44f9-8f21-08de8b044ae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|30052699003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: IhqKQPfY3L4dxL44Z/eVeVVS4E1ZClqvoa9BH/OhGvvZC3rbjfktRAfBorVZ+QQFAZpLJjcLZBZ9QIvEGSvltbeoMjqdsRKR0dXWip4tjVz2qF3qn/a0fe/O1awqTkTUXgdjMc83Yp2ZbXp0kqwGLzkKWp6y5BuNqxxgcjNS2tIJts44b4dfUYbGgcTTz6U9gE7/ZO90xR2dJIEb/I003YcDLmtmJcnJLgACXPThr5obH5oyTjK2Y5e3uxcyWLzbpAS1Zh8CRyldpRAcCHD1EnuoK+f4JFteAIkYskruaf4VwhG8x+Ynp7V4jw1bCQRUDLKpbGcNZahgmLwnL61eW+WRcHmrLVFo94dhs9rqVtoTT9EDM0XcOzG1kF3lo2pSqUayYa+lQdsUx2qBg/EAWPUGRi0SgBv0RPC1+HTPg1dAHhHGPEk6nFjpCpkYKHw59exLlK5xn1f5VSSPVpFgNpc14CSfNC2FCIq3nH5q/HXTBjE2T2thBRXeLsIrOdC6KrVUFDpAFC+3ykubqWGmlhFbildo5iuRUtAhtRPrFsLdbiwizI2Je8w0IGme4P1Cc9OCA6zcMhTHsaKmis8iivyBDI3PFDFT6c9G2YOi8XHhvACjS9Jdu3g2yXMl/IQdkpoQyG/lbZMdUF4ttGicUEteM3MS7jqjlbxZO9+t1qdJL4tlXe5PB5SZzPeGYugjTrFp7vl2Jtm5jtD6zwixIrM5JLltlTGP8JWqKkcRrtzhWqyjL+3ArxM9niXnDAFTj4tYdU7O58En04MeXUQ4vw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(30052699003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EP0RR/wmr+s7SVJWYYp5q4qTbWtQMbm+ToGGiQ0kAB6M4oFrLZxP382ygIcbsYY8hW1iwhgQNkYUlVLCm4XkjPjsUm3Y2ZuLR9p10weE4Hy4UMRN+gcr6P47fvpIVzq3l/a8UeVDRStze9wrN1oH5UJat/6Z31DO3AXZ6iDgUe7E29B8EHAKxGNGZsbhV2/zh6dGYhZzeB014aR3sOkn4WcXiKoAdbaiAguiOtuW4RoM8l2Hcs3flcaJa1BzL4rnwQyvHfrDNtfYMZ5M+8ltyxWstI6G5sT9PMwcw/H6nakL1G2teo8ddLF6WtX4MsRia0jxaTGHyqWXIj8U8/bpSWJO60txJeL3z2s9TKWrLCo+ArOReiewzaxiU3XovkFqrwtPmXNNJTbwIT4MAuubIyrI8A3diogILpWlXTRBcrAn59RUmYAjNabtN716ZZFt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 06:52:48.5099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 177a32b7-e76d-44f9-8f21-08de8b044ae7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353
Received-SPF: permerror client-ip=52.101.61.51;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 3/24/2026 7:55 PM, Alejandro Jimenez wrote:
>
> On 3/23/26 7:01 AM, Sairaj Kodilkar wrote:
>>
>> On 3/12/2026 2:09 AM, Alejandro Jimenez wrote:
>>> DTE[Mode] and PTE NextLevel encode page table levels as 1-based values, but
>>> fetch_pte() currently uses a 0-based level counter, making the logic
>>> harder to follow and requiring conversions between DTE mode and level.
>>>
>>> Switch the page table walk logic to use 1-based level accounting in
>>> fetch_pte() and the relevant macro helpers. To further simplify the page
>>> walking loop, split the root page table access from the walk i.e. rework
>>> fetch_pte() to follow the DTE Page Table Root Pointer and retrieve the top
>>> level pagetable entry before entering the loop, then iterate only over the
>>> PDE/PTE entries.
>>>
>>> The reworked algorithm fixes a page walk bug where the page size was
>>> calculated for the next level before checking if the current PTE was already
>>> a leaf/hugepage. That caused hugepage mappings to be reported as 4K pages,
>>> leading to performance degradation and failures in some setups.
>>>
>>> Fixes: a74bb3110a5b ("amd_iommu: Add helpers to walk AMD v1 Page Table
>>> format")
>>> Cc: qemu-stable@nongnu.org
>>> Reported-by: David Hoppenbrouwers <qemu@demindiro.com>
>>> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>>> ---
>>>    hw/i386/amd_iommu.c | 132 ++++++++++++++++++++++++++++++--------------
>>>    hw/i386/amd_iommu.h |  11 ++--
>>>    2 files changed, 97 insertions(+), 46 deletions(-)
>>>
> [...]
>
>> Hi Alejandro,
>>
>> amdvi_sync_shadow_page_table_range() does not check if DTE
>> **valid and translation valid** bit are set. I added this check in
>> my reply to david's patch. Do you think we should include that
>> check as well to ensure that only DTEs with **valid and translation valid**
>> bit are passed to the fetch_pte ?
>>
> Right now the check for DTE[V] and DTE[TV] are implemented in
> amdvi_as_to_dte(), which all callers of
> amdvi_sync_shadow_page_table_range() use to extract the DTE that will be
> passed as its argument. So I think if we were to add a check, an assert
> would be more appropriate.
>
> On the other hand, I am worried about sprinkling assertions around the
> code, and I am actually considering removing the ones the original series
> added to amdvi_sync_shadow_page_table_range(), fetch_pte(), and
> amdvi_notify_iommu(), since any failures in these cases are likely to cause
> immediate symptoms and I don't believe it creates any window for data
> corruption.
>
> With that in mind, to answer your question I would not add any additional
> check on amdvi_sync_shadow_page_table_range(), and would rely on the
> current convention to check when retrieving a DTE via the interface we
> provided for it and all the code already uses i.e. amdvi_as_to_dte().
>
>
> For a follow up cleanup, maybe amdvi_as_to_dte() should be renamed with a
> more suggestive name that clearly indicates that it validates for those
> conditions. But in context, all of its callers rely on the fact that it
> does this verification and its return values also encode it.
>
> While looking into this I noticed a chance for minor cleanup in this flow:
> amdvi_do_translate()
>      amdvi_as_to_dte()
>      amdvi_page_walk()
>
> Where amdvi_page_walk() does an unnecessary check for DTE[TV], that
> amd_vi_as_to_dte() already ensures is set.

Hi Alejandro,
I agree with you about sprinkling assertions, I think some of the assertions
should ideally deliver a events to the guest. But we can have this in later
series

Also for both the patches

Reviewed-by: Sairaj Kodilkar <sarunkod@amd.com>

Thanks
Sairaj

>
> Thank you,
> Alejandro
>
>> Thanks
>> Sairaj Kodilkar
>>


