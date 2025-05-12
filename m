Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BEBC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 06:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEMvL-0007I9-Pz; Mon, 12 May 2025 02:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uEMvK-0007I0-Ny
 for qemu-devel@nongnu.org; Mon, 12 May 2025 02:46:02 -0400
Received: from mail-dm6nam10on2062f.outbound.protection.outlook.com
 ([2a01:111:f403:2413::62f]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uEMvH-0003yt-V6
 for qemu-devel@nongnu.org; Mon, 12 May 2025 02:46:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CSUqEJ8WsTF/LtcznSPBQrL8UXFRpM+T7y3BEZg2EJQxZx77RWxHhXF5fEWA42uiGxWhCbIadSl8udQFPyOXFqsVmJ7J5pRgFyR80gnuoQrYoSQPP/AFCLSRgR7QQo8HqiJtDpTSY/Rd0/XbMBBwk5dJL8j0BEqDuTmcImxa7smvMo6OCweqJczsLWM68GgEBgrB/YA/WIefgGAdMtLMYDq7j9Oes4UY8fB+/37ruTW+au1c2tIeN4MPhLnBpSv4qdTHQeWbgrVcmER8cGqyFUrwRvpvVKuAoMK9iRJ6MuiehjBcPIlj/gL56UmwatQq09C9oBgnKdrMLWgtLcrjvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7W+zGOtD4BXPUyB4cxVxpCumcr6fstN/hdqLxJgxBk=;
 b=OM18QbOBEHfyObcJoa1xtyMOOGf7L3vAYVl5yCXJGV7PoYZ2SuRtieA5nJ0bqAUOdgkawCXfE0VPX6Nzb8lEiDwaokSkCErJSkxKbzEzsgPYoU93ghwmhgDHFV6YGCHB8isn8qv75aKmdCoPJhoTVnmg1vvRwD9wa8lS1GtQDafaodXB8eLxFzvz8jKWxX1KpImxGgIr5uOFhqVMqBsA648v6CQrhyFMhAanicc92PLW0HOW85oHXVkuOBDT2BIB5RVpBWyAaKfKSHsA08zFk55Gt2EXIFVZ4+dq8Jw4uwtljyNGkD01QNYEXrfNBUZ61aJ79GYqpnLE8SKGlaKbyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7W+zGOtD4BXPUyB4cxVxpCumcr6fstN/hdqLxJgxBk=;
 b=nQHf/0BR6LOuvliph7u3WbwSprLexbPw7vMaZCgtafHPGI/N9IrU7UJ6mQTUofB3mr3u4bwtO3E0wdEj1v6kHxt94Mth/luRwyRhT4Gjm95boTBNkKEeQylniIM9kqHryXVfvAx+3horw0rpy+qsrm7PxmTZb2/ElhTapSDWDh0=
Received: from MN2PR11CA0021.namprd11.prod.outlook.com (2603:10b6:208:23b::26)
 by DM4PR12MB5723.namprd12.prod.outlook.com (2603:10b6:8:5e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.29; Mon, 12 May 2025 06:45:54 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:208:23b:cafe::4) by MN2PR11CA0021.outlook.office365.com
 (2603:10b6:208:23b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.21 via Frontend Transport; Mon,
 12 May 2025 06:45:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 06:45:54 +0000
Received: from [10.252.206.76] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 01:45:49 -0500
Message-ID: <89aa3b2f-092f-43a4-a96c-5755cf06efb9@amd.com>
Date: Mon, 12 May 2025 12:15:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/20] amd_iommu: Add helper function to extract the DTE
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <peterx@redhat.com>, <david@redhat.com>,
 <philmd@linaro.org>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <alex.williamson@redhat.com>, <vasant.hegde@amd.com>,
 <suravee.suthikulpanit@amd.com>, <santosh.shukla@amd.com>,
 <Wei.Huang2@amd.com>, <clement.mathieu--drif@eviden.com>,
 <ethan.milon@eviden.com>, <joao.m.martins@oracle.com>,
 <boris.ostrovsky@oracle.com>
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
 <20250502021605.1795985-6-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20250502021605.1795985-6-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|DM4PR12MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: 08cb4f58-1061-430c-3e40-08dd9120a4c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2pmYmJ5MTJjMFh6MkMwZ0p4a0pEZ0FYdHBzMVVmNHpvT3B2UTdabUdpc01p?=
 =?utf-8?B?eDg1Yms4cXNDYTQyR2s0TEdGNFlIVUIwTHY1a0NGVmx1T1hiMDQrdk9QZHBP?=
 =?utf-8?B?MmY4dTBEN01FbjNsMGtWYlpoUXJqMzVzbERJYXg5dCtRWHJ1NkpaR3JmQWRi?=
 =?utf-8?B?N2Q0eloxVUdPOWs0RXJ0RXdpOEdGa0hnYWthdVRDT29hUzNCa1FOZFpORDl4?=
 =?utf-8?B?clQvT0hiR29xSkpjeUQxQlEzVnZXQ2tseENCTG55aG5SN0s5YStGVHlydzJx?=
 =?utf-8?B?NlBIeEdCb3hXNUFkeUpUUjh4ZjdNTXRsMVBuZHRsWm5aUDkxdVJqbUZPTDNv?=
 =?utf-8?B?MjBtQklqcWJHamo5QzZwN1FZeklpL0R6dFltSXhhWVFHaWpPYktDRjZNRGpa?=
 =?utf-8?B?VnR6TC9BK256N1U4REV2ajlOUkFNWVFKKzNWd3RBU3pDeld5Y1dIWVcrZkYv?=
 =?utf-8?B?cUFYZmd1MWZCU0VQNG1JQS9tVEVNZkRCblQyRk9QWHRjR2RnNUVSbzZydUdm?=
 =?utf-8?B?clFtcGNUR1JjUDBBbmZtdSsxZEVmQkpFUlRydm13UTIxdHZxZ3VNZlc1ZS80?=
 =?utf-8?B?VElaekx2K3Zmd3lVUFlRSzVvanp0UHZEUnpKODJPUGJUYjJHd213bVhWQ0Y5?=
 =?utf-8?B?UVN5NVI1ZFBDV2lnKzZhaG5nNFNxbkhjWkJIWDlWQ29mcGhxTmo1T2lOcjFz?=
 =?utf-8?B?UG1kU1ZkMURkWDJjQ1d5akNwUStsQk1VdjhXWldsSEl0alFIRTcrRVhnZk41?=
 =?utf-8?B?eVhaU0FNdVNqTjNMdXRYWEp4TXFEa2tyUXN3aGhVODZrR3BGc0s3TXU0QVpX?=
 =?utf-8?B?UlpNK2FQR1NqaXFCejRHMHpzUFFqVElPMTFjZjFsNFJEM2FWWU9ZUHR2OWV5?=
 =?utf-8?B?TTMzUkxJUERsWFJUTEkzZXR6V1pxUllaaVFqS0Fvanh0WFN5dUVrQzdmaWt5?=
 =?utf-8?B?Q1krbHNNOFZPcmxrQzZOcHFaTzd2dFQvMjZQTjNNeXRTVWszQitIMHlxZlNk?=
 =?utf-8?B?aFVqbXJjUmY2QVJIS1AyYmlOMWRzT1ErM0FQM1A4bHcwNHRvaDRyeDJ5ZExo?=
 =?utf-8?B?VDNFV3BEV25GSnA1cXBDTU8wclVrb3VLS3lOMlFRZ1EwRkNxcTlIMXB2TlNY?=
 =?utf-8?B?Z3pETmkzSk9RWVBrd3hkM3RRQjFldU9xUmZUaDlqQmlLc3NVVzFoM2JSbFdS?=
 =?utf-8?B?dUUvWUFYRUlRZzJxTXNxclErVUV5dkQwUXQwZHpQcEVLWEVteWtyT0draFRS?=
 =?utf-8?B?KzUzQUp6dEdJQzVBVHNYSEoyTHZUWERyT1Jhc2w0RnlwWXdLbmxlUFNPZU05?=
 =?utf-8?B?YWNRUytNTDNlQXpFdVlNcW8xZDJoN1EwVk9KVXhudEtrSldOV2IvNWVvM2ZN?=
 =?utf-8?B?QTBJdUw0SnM2c0k1N09PdGVFbGNtYW9Jc3hRcUtuTXdoMVNBS3ZjNElCV0lR?=
 =?utf-8?B?VjJkSFdUQnBOYmlJeW1ray84OWlHNWtCY2NLVEs1U1pwdSs4L2pEQm1aTkl3?=
 =?utf-8?B?bHRyRFNMMHZLL3RiUEgwNG1ObGtyM1I4dnhweEcwTTVSbTI2a1dQL0NxUXhz?=
 =?utf-8?B?amErR2RNVmluZVdna3dOLzk2eG9hMnhCdVliM1hkSFdmb0VFZEloWExWSVQ2?=
 =?utf-8?B?eVRXdG0rQnlTM1c5UWFoS25aODRBdmNYS1pIbEwxQjY5TXZ6M1grUGJ0dHYr?=
 =?utf-8?B?L1lwYzRJYXJsWVZJenBpNzVHaUYvZ0ZBb3krS0M2S1J4VjNkaXg3bUtBbHJq?=
 =?utf-8?B?dHZwNjhaTzg5S3U1SnZJeXhEYnVITEdZWmY0T1JqWFlScmwxVHZ4OE1WUkpI?=
 =?utf-8?B?MWd6UlBITFd2ZEt2WnUwQXRwUmRtNmlrNnQwalRIdVZnOW03c0h0NE1nUTFs?=
 =?utf-8?B?UnBGbXhSNzkzb1pKS2FxQkRtNXFUaDNVY1BaNWNrdDBySXpPbmpzSjNWNWVl?=
 =?utf-8?B?QnJ1RU9LeXB2YUJPTWdlYkVvWEZzTjhxYkFITmozd1ppLzl2V1QyMlJNbzBY?=
 =?utf-8?B?UURXUi80bjUvVXlVRVFrMk1CeUxjaUNEa3FPV2hCTFBJbW5aaVlyUzZFOWYw?=
 =?utf-8?Q?fG2RU+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 06:45:54.5697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08cb4f58-1061-430c-3e40-08dd9120a4c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5723
Received-SPF: permerror client-ip=2a01:111:f403:2413::62f;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
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



On 5/2/2025 7:45 AM, Alejandro Jimenez wrote:
> Extracting the DTE from a given AMDVIAddressSpace pointer structure is a
> common operation required for syncing the shadow page tables. Implement a
> helper to do it and check for common error conditions.
> 
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>   hw/i386/amd_iommu.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 40 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index dff6f04c8651..5322a614f5d6 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -77,6 +77,18 @@ typedef struct AMDVIIOTLBEntry {
>       uint64_t page_mask;         /* physical page size  */
>   } AMDVIIOTLBEntry;
>   
> +/*
> + * These 'fault' reasons have an overloaded meaning since they are not only
> + * intended for describing reasons that generate an IO_PAGE_FAULT as per the AMD
> + * IOMMU specification, but are also used to signal internal errors in the
> + * emulation code.
> + */
> +typedef enum AMDVIFaultReason {
> +    AMDVI_FR_DTE_RTR_ERR = 1,   /* Failure to retrieve DTE */
> +    AMDVI_FR_DTE_V,             /* DTE[V] = 0 */
> +    AMDVI_FR_DTE_TV,            /* DTE[TV] = 0 */
> +} AMDVIFaultReason;
> +
>   uint64_t amdvi_extended_feature_register(AMDVIState *s)
>   {
>       uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
> @@ -492,6 +504,28 @@ static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
>       return pte;
>   }
>   
> +static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte)
> +{
> +    uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
> +    AMDVIState *s = as->iommu_state;
> +
> +    if (!amdvi_get_dte(s, devid, dte)) {
> +        /* Unable to retrieve DTE for devid */
> +        return -AMDVI_FR_DTE_RTR_ERR;
> +    }
> +
> +    if (!(dte[0] & AMDVI_DEV_VALID)) {
> +        /* DTE[V] not set, address is passed untranslated for devid */
> +        return -AMDVI_FR_DTE_V;
> +    }
> +
> +    if (!(dte[0] & AMDVI_DEV_TRANSLATION_VALID)) {
> +        /* DTE[TV] not set, host page table not valid for devid */
> +        return -AMDVI_FR_DTE_TV;
> +    }
> +    return 0;
> +}
> +
>   /* log error without aborting since linux seems to be using reserved bits */
>   static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
>   {
> @@ -1024,6 +1058,7 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
>       uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
>       AMDVIIOTLBEntry *iotlb_entry = amdvi_iotlb_lookup(s, addr, devid);
>       uint64_t entry[4];
> +    int dte_ret;
>   
>       if (iotlb_entry) {
>           trace_amdvi_iotlb_hit(PCI_BUS_NUM(devid), PCI_SLOT(devid),
> @@ -1035,13 +1070,13 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
>           return;
>       }
>   
> -    if (!amdvi_get_dte(s, devid, entry)) {
> -        return;
> -    }
> +    dte_ret = amdvi_as_to_dte(as, entry);
>   
> -    /* devices with V = 0 are not translated */
> -    if (!(entry[0] & AMDVI_DEV_VALID)) {
> +    if (dte_ret == -AMDVI_FR_DTE_V) {
> +        /* DTE[V]=0, address is passed untranslated */
>           goto out;
> +    } else if (dte_ret == -AMDVI_FR_DTE_TV) {
> +        return;
>       }
>  

Hi Alejandro,

You missed to handle -AMDVI_FR_DTE_RTR_ERR.

Regards
Sairaj Kodilkar

>       amdvi_page_walk(as, entry, ret,


