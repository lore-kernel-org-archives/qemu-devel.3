Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B74C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 12:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Cu1-0001jY-S9; Tue, 22 Apr 2025 08:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u7Ctz-0001j2-PU
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 08:39:03 -0400
Received: from mail-bn7nam10on20602.outbound.protection.outlook.com
 ([2a01:111:f403:2009::602]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u7Ctw-0005r7-DZ
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 08:39:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJirl2I6jKAksaMrXdyHUt7MKSNIJ/TfL0yehB/V4p7XLhxbijC7Q3rCdvpAS55zo6JUHhw2lkSm+s/HHX9yIm5IA6Ai6Y0CDdiLIUPqNiA1EcL0yPwIvPc6PB7qDXJOhyc6yFfnSJ5/0dROgOTfPGPrA3LWBLgP5vOeqxFd5CBNECxqwlY0oB3yjVklwL6Y+1yhusFmjCMB4ZY2IDE9f7E0inYv7kte4HhQzsYuofftaGuPBN3aplDjIYYQsX5kHzkMNh4AroOrJW15YkEvxlfBqnS6hriLMX/4F6vXFH4GLeKV8VOmXX/aR9mb0N8HqzBtzq+Qdldi8LwANEhdMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G16tWDxJZFkaa7JoptapIiAdUfR5cOLObyrY9YjJA8U=;
 b=UsxAMjlJOGe8ukx05lpG3kGYnCyKgy53S5jX78RqPeyLBrMrB2Hl68Ti9j7140Of2Cweqw7N6MTM7Ktmpg9foUR0Lr2JdTH0uvitKlmD/uRY5uS7yfjpc3MLTl1Rm7AHGpEfcbLMgppJQAOrJKD0FyCduOVFpg7KrRlfuQKm7GtRqWAyC8TJR10GpreHAilBBg25K4Z/IGzXYYHtVA/S/Ac7jhuMQ7YP2FFzmO+GnbqrVEmPTcDwCphCq7AvI/1Qjtj81/5ksFgE35PUYNXzO6xPQCCOvZwbANvv7cCdzazCK52gcaTpYOJ5rszkpVioaAuQ1a55RJHVsBCVCHJm2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G16tWDxJZFkaa7JoptapIiAdUfR5cOLObyrY9YjJA8U=;
 b=KVknBudFw7MMVtekmC2OdOE6KD+jltN7llGj15u2MD0xYhGKiElafRZTXfMWMTZrSEvVKoQ09YIQ/9Nafyz257Ek9IFjCcFTYKZ9vZqoHPJ4TA+IjNIghvnrdSkzESEjF7yqTFEBd9epEnK9A0n9qJJP1YaR+xA1rQVm9Urc6W0=
Received: from BN0PR10CA0015.namprd10.prod.outlook.com (2603:10b6:408:143::33)
 by SJ0PR12MB6709.namprd12.prod.outlook.com (2603:10b6:a03:44a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 22 Apr
 2025 12:38:50 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::64) by BN0PR10CA0015.outlook.office365.com
 (2603:10b6:408:143::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Tue,
 22 Apr 2025 12:38:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 22 Apr 2025 12:38:49 +0000
Received: from [10.136.47.77] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Apr
 2025 07:38:45 -0500
Message-ID: <2260b4b3-c5fa-43b9-adf2-1fefaee5dc43@amd.com>
Date: Tue, 22 Apr 2025 18:08:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/18] amd_iommu: Sync shadow page tables on page
 invalidation
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <peterx@redhat.com>, <david@redhat.com>,
 <philmd@linaro.org>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <alex.williamson@redhat.com>, <vasant.hegde@amd.com>,
 <suravee.suthikulpanit@amd.com>, <santosh.shukla@amd.com>,
 <Wei.Huang2@amd.com>, <joao.m.martins@oracle.com>,
 <boris.ostrovsky@oracle.com>
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
 <20250414020253.443831-12-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20250414020253.443831-12-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|SJ0PR12MB6709:EE_
X-MS-Office365-Filtering-Correlation-Id: a26f8487-c65c-4000-81f8-08dd819aa20b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlVEU0Iyc2lCb1ZrRmFJOVNlOURqVkIrcEhPRGVuOTFKeTI1bHBicUt1NU5p?=
 =?utf-8?B?QTdvREx0dzB1ejBoajV2MXdibjczdDN6L3hrdWNqNEkvNHl5KzROVFgvRENt?=
 =?utf-8?B?QlhlKytMek14dHpCbWx4Ri9xQjBiY21zVFkvMG1hNnM1WGxhMkJrRDdmdUpB?=
 =?utf-8?B?RE8zM0ttczliUG9FeVVIU1BoZDVPQ3ZTU0s5dDJSdGs0b2VFVk1HNElzTk9X?=
 =?utf-8?B?UmR2SGl2WEhnN3dTRXJsR3Y5dGVZd0xod2lFL3dBODhRNWd0RVRNQXNpTVlS?=
 =?utf-8?B?ZHBWaGs5Vy9VNm5aMTU1S2NkTDF3QmdHTGYwdFFTdm1BTHk1bm00eWQ2MHlO?=
 =?utf-8?B?RjlIS2tacTNhUFdKMEJ4WnpUWHorU0dtb1hCMXdENmluOC8vbkxGOWRKWlNN?=
 =?utf-8?B?WmpBMkRHS3g2UTRSOEs1MHc5ZzMzM3B0SUF4ajF5YU1XVFJHQlFmQTFSMFZu?=
 =?utf-8?B?MFNNVzk2THZ5a3VweDcxSVU1NlFMbVc3VlpjZk5BaDVDcXBjMkthOXpVV2Vj?=
 =?utf-8?B?d3VEemRseXNWelFMOTQvSmkwY29qMTlUc2VpNUNoUWgxWGN0eGIxWUhJckNp?=
 =?utf-8?B?YWFGMVh5b0JSeVdMVEtzb3RpekRqRm5YWml0QzJySXptNmNyZVMxQUJmMzJJ?=
 =?utf-8?B?OUFGeG1SczJrM0ovWjJwSHRITFRWMTNtWjVDeXVjRlVqTlBNSjhRem1Jajda?=
 =?utf-8?B?MDdFRXl3dDV0N2F1NDZXdU41VUtIUFJhbysvaytNUWt0MldxUE9UcVdoS045?=
 =?utf-8?B?cW95aHB0NUJZL3hWNnFoT3EybW11eFU4Nlh2TUNKbExXWCtvQmNNUHJ3Ykx0?=
 =?utf-8?B?OGtlaWZ3MjBaMWI1RVlEbC9lVjFWeVZvS3NseVlzV2UxQTE0clV1THhkK0Fp?=
 =?utf-8?B?S01iekJwaU9xbHh4bkJpc1dvc0M4NEZydnhjNmcya1dDQm93ekRlajA1THBM?=
 =?utf-8?B?OG9lMTJ4Qm5GQUJjVHUwb2Y4MytwNElZc2xiR3p5YURKRDdzT0F4bWpmdUI4?=
 =?utf-8?B?M1B0TEllN2pteVBxamV3Rjk1VDdTK2dJbWFFQ3JYTUx4Ym95cExPWHJDeWEx?=
 =?utf-8?B?ODc3aC9TRGptZTM5WHVJRHVWWE53Y0dMYWlsdXVBTkEyNzMvQkNZN0d6QjFF?=
 =?utf-8?B?SE13UFpnNm8ycENMbWFmWVROSmVVQ1lzZmN0TEJzYjQwNzAzMG1xSXBHRnpr?=
 =?utf-8?B?RC9DelRGSE44djBBZlJIT3F0YmJmSm0wQU1JajIzbTBSTVZicVYzeDJmRXVu?=
 =?utf-8?B?MkVGQ0liK0RPa3owOVovQkNHeEZlb0l6MGtVVGdzUGVwdzRlK1NWbm1nUlhq?=
 =?utf-8?B?MmJCUldGeHJVV0dpRzVBbzg2TC9SK0FBYVFQK1NJZzUrRnF5VWlrbzA0RjBt?=
 =?utf-8?B?QWN2ZHpHMnVpazh5UC9uVzNQckFBM2F0TTJCQWwwdUhuZDdRRkhKaVo2eTJ3?=
 =?utf-8?B?WXg5YnFUUmF3d3o5aTA2RUd6RkdkOVVaN1NXS1Fxa2pwMUNWT3g2cWJUbjlj?=
 =?utf-8?B?cUxsQitXcVZWWWR3Vk1Dd1A1SFJEZDc5Ui8yTVpiSkxXYWsvS3VIQStGZFl1?=
 =?utf-8?B?Vnl5S1Jqd2pWbDZFYXdEVnF1NFc5Nzcyd1M3YnFQWWlOYkMzdm5lVEJkck5Z?=
 =?utf-8?B?bkx5eHlQVGluTmhNNXMyVWEzQXoyUGYxdEg1T21vL2UwRDJxSFpldlpIU29E?=
 =?utf-8?B?ZXMyQnlWUEg1YmpDejA1YTh6aVZvVzZsM2xocE1qTW8wZjZXdjdtSlNGSkZY?=
 =?utf-8?B?WStNZGxvdDExN1JNOFowN0pGL0pJV1VkbVRqbXd5QjNzS3V0KytxbVFqdWli?=
 =?utf-8?B?VkJrNXoraDhJWW5nbE9NNkYrUHNNK3cxQUtkRGlsRkg3dStaQmwvQlFpcDhQ?=
 =?utf-8?B?R0NmeUlBSGZVRUE2TjBndVd6dkVsaGt4Z1Q0S3ArOTkyK0lDSS9sVzRyWjRW?=
 =?utf-8?B?Q0RoTDBXRlorVHlwWEdRU0dqSEJacWtXV2tvcmRrRWlybjZiYm8zWmJxampE?=
 =?utf-8?B?VEVPOHF1amVxK3JON0hxbzAzL3dqWTNQRlFxTW1IZDhuKzR6dk1vYWNUSlcy?=
 =?utf-8?Q?hztvkm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 12:38:49.9619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a26f8487-c65c-4000-81f8-08dd819aa20b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6709
Received-SPF: permerror client-ip=2a01:111:f403:2009::602;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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



On 4/14/2025 7:32 AM, Alejandro Jimenez wrote:
> When the guest issues an INVALIDATE_IOMMU_PAGES command, decode the
> address and size of the invalidation and sync the guest page table state
> with the host. This requires walking the guest page table and calling
> notifiers registered for address spaces matching the domain ID encoded
> in the command.
> 
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>   hw/i386/amd_iommu.c | 110 ++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 102 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 6789e1e9b688..cf83ac607064 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -97,6 +97,9 @@ typedef enum AMDVIFaultReason {
>   } AMDVIFaultReason;
>   
>   static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte);
> +static void amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as,
> +                                               uint64_t *dte, hwaddr addr,
> +                                               uint64_t size, bool send_unmap);
>   
>   uint64_t amdvi_extended_feature_register(AMDVIState *s)
>   {
> @@ -497,8 +500,7 @@ static gboolean amdvi_iotlb_remove_by_domid(gpointer key, gpointer value,
>    * first zero at bit 51 or larger is a request to invalidate the entire address
>    * space.
>    */
> -static uint64_t __attribute__((unused))
> -amdvi_decode_invalidation_size(hwaddr addr, uint16_t flags)
> +static uint64_t amdvi_decode_invalidation_size(hwaddr addr, uint16_t flags)
>   {
>       uint64_t size = AMDVI_PAGE_SIZE;
>       uint8_t fzbit = 0;
> @@ -515,10 +517,101 @@ amdvi_decode_invalidation_size(hwaddr addr, uint16_t flags)
>       return size;
>   }
>   
> +/*
> + * Synchronize the guest page tables with the shadow page tables kept in the
> + * host for the specified range.
> + * The invalidation command issued by the guest and intercepted by the VMM
> + * does not specify a device, but a domain, since all devices in the same domain
> + * share the same page tables. However, vIOMMU emulation creates separate
> + * address spaces per device, so it is necessary to traverse the list of all of
> + * address spaces (i.e. devices) that have notifiers registered in order to
> + * propagate the changes to the host page tables. This could generate redundant
> + * requests to map/unmap regions when there are several devices in a same domain
> + * but it must be optimized by maintaining an internal representation of the
> + * per-domain address space, and avoid invoking a notifier when the change is
> + * already reflected in the host page tables.
> + *
> + * We cannot return early from this function once a matching domain has been
> + * identified and its page tables synced (based on the fact that all devices in
> + * the same domain share the page tables). The reason is that different devices
> + * (i.e. address spaces) could have different notifiers registered, and by
> + * skipping address spaces that appear later on the amdvi_as_with_notifiers list
> + * their notifiers (which could differ from the ones registered for the first
> + * device/address space) would not be invoked.
> + */
> +static void amdvi_sync_domain(AMDVIState *s, uint16_t domid, uint64_t addr,
> +                              uint16_t flags)
> +{
> +    AMDVIAddressSpace *as;
> +
> +    uint64_t size = amdvi_decode_invalidation_size(addr, flags);
> +
> +    if (size == AMDVI_INV_ALL_PAGES) {
> +        addr = 0;       /* Set start address to 0 and invalidate entire AS */
> +    } else {
> +        addr &= ~(size - 1);
> +    }
> +
> +    /*
> +     * Call notifiers that have registered for each address space matching the
> +     * domain ID, in order to sync the guest pagetable state with the host.
> +     */
> +    QLIST_FOREACH(as, &s->amdvi_as_with_notifiers, next) {
> +
> +        uint64_t dte[4] = { 0 };
> +
> +        /*
> +         * Retrieve the Device Table entry for the devid corresponding to the
> +         * current address space, and verify the DomainID matches i.e. the page
> +         * tables to be synced belong to devices in the domain.
> +         */
> +        if (amdvi_as_to_dte(as, dte)) {
> +            continue;
> +        }
> +
> +        /* Only need to sync the Page Tables for a matching domain */
> +        if (domid != (dte[1] & AMDVI_DEV_DOMID_ID_MASK)) {
> +            continue;
> +        }
> +
> +        /*
> +         * We have determined that there is a valid Device Table Entry for a
> +         * device matching the DomainID in the INV_IOMMU_PAGES command issued by
> +         * the guest. Walk the guest page table to sync shadow page table.
> +         *
> +         * An optimization can be made if only UNMAP notifiers are registered to
> +         * avoid walking the page table and just invalidate the requested range.
> +         */

Hi Alejandro,
I am not able to understand the optimization during "UNMAP only"
notifiers. I am confused because code will call the UNMAP notifier
even if the pte is present (which should be wrong). Could you please
explain why we are unmapping IOVAs with present pte ?

Regards
Sairaj Kodilkar

> +        if (as->notifier_flags & IOMMU_NOTIFIER_MAP) {
> +
> +            /* Sync guest IOMMU mappings with host */
> +            amdvi_sync_shadow_page_table_range(as, &dte[0], addr, size, true);
> +        } else {
> +            /*
> +             * For UNMAP only notifiers, invalidate the requested size. No page
> +             * table walk is required since there is no need to replay mappings.
> +             */
> +            IOMMUTLBEvent event = {
> +                .type = IOMMU_NOTIFIER_UNMAP,
> +                .entry = {
> +                    .target_as = &address_space_memory,
> +                    .iova = addr,
> +                    .translated_addr = 0, /* Irrelevant for unmap case */
> +                    .addr_mask = size - 1,
> +                    .perm = IOMMU_NONE,
> +                },
> +            };
> +            memory_region_notify_iommu(&as->iommu, 0, event);
> +        }
> +    }
> +}
> +
>   /* we don't have devid - we can't remove pages by address */
>   static void amdvi_inval_pages(AMDVIState *s, uint64_t *cmd)
>   {
>       uint16_t domid = cpu_to_le16((uint16_t)extract64(cmd[0], 32, 16));
> +    uint64_t addr = cpu_to_le64(extract64(cmd[1], 12, 52)) << 12;
> +    uint16_t flags = cpu_to_le16((uint16_t)extract64(cmd[1], 0, 3));
>   
>       if (extract64(cmd[0], 20, 12) || extract64(cmd[0], 48, 12) ||
>           extract64(cmd[1], 3, 9)) {
> @@ -528,6 +621,8 @@ static void amdvi_inval_pages(AMDVIState *s, uint64_t *cmd)
>   
>       g_hash_table_foreach_remove(s->iotlb, amdvi_iotlb_remove_by_domid,
>                                   &domid);
> +
> +    amdvi_sync_domain(s, domid, addr, flags);
>       trace_amdvi_pages_inval(domid);
>   }
>   
> @@ -1589,9 +1684,8 @@ static uint64_t large_pte_page_size(uint64_t pte)
>    *  0:  PTE is marked not present, or entry is 0.
>    * >0:  Leaf PTE value resolved from walking Guest IO Page Table.
>    */
> -static uint64_t __attribute__((unused))
> -fetch_pte(AMDVIAddressSpace *as, const hwaddr address, uint64_t dte,
> -          hwaddr *page_size)
> +static uint64_t fetch_pte(AMDVIAddressSpace *as, const hwaddr address,
> +                          uint64_t dte, hwaddr *page_size)
>   {
>       IOMMUAccessFlags perms = amdvi_get_perms(dte);
>   
> @@ -1693,9 +1787,9 @@ fetch_pte(AMDVIAddressSpace *as, const hwaddr address, uint64_t dte,
>    * notifiers to sync the shadow page tables in the host.
>    * Must be called with a valid DTE for DMA remapping i.e. V=1,TV=1
>    */
> -static void __attribute__((unused))
> -amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as, uint64_t *dte,
> -                                   hwaddr addr, uint64_t size, bool send_unmap)
> +static void amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as,
> +                                               uint64_t *dte, hwaddr addr,
> +                                               uint64_t size, bool send_unmap)
>   {
>       IOMMUTLBEvent event;
>   


