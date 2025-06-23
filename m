Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3BAC7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 10:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTet2-0002HW-HK; Mon, 23 Jun 2025 06:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uTesz-0002Ex-FF
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:58:49 -0400
Received: from mail-bn8nam04on2047.outbound.protection.outlook.com
 ([40.107.100.47] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uTesm-0004ua-Gw
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:58:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+o9ivuWcZk3vRYfvwLRtu9GPnyOyl6CvkBM3PpHG6ukq2PF/qTWB2F0yWftL0pSuJMVpvCziUyMzjpjQK4s3mLUS/DWsx50MPwLqSKo9xU8ImuEVtsMSE7aeYzBNYmagXNvgapWWicW7Othr42963UXm7rwFVC0jffOGlLrmRZnbkBCSDoQxGFT4X7GInVMYvTgRZdfSEk7Oz1EyH4RZgCwy5wPP8RICIejU4PL0TTzgGsupyXXrBBbrcx8gz2xbojcYHZK/kXzgb9y4Pt0w5HhK3a7HqOPl/Iej7mCiNbqKKXkzN098WiofPFJVtlgQ++GZfpV7OCMI6mLpZX9oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWqUWOfcuXHMTn13C9ZX7q1qbVAWmqS9l7FpaY4mA40=;
 b=tJDsYpfJw0IUtri0ARRyqfiNFfuFmP/TgmpMNIloQl0rgtE55Si8qXRL4ogJPYHWMRtnu30g6yeDLjoMLjER8LGPcdplzvicWqCn/9dbk0LGvnWDuwEzjfwwxGr86rFEdzFXhyTbZuHPSN8rr0lwyCbPlvb/v7pyDCta+aMRBrlOGJdPjtJR0cflgOTAW+FpCpc/cK05IGBeBnuSJNzifpc003mStfzXdlcjG4gHHqKVlhuAPqqZu9tMXFVamL2HISGMn4zGe3k9vWbFPN3w384UHWRoYYi1nBTyNXxIBTC4OjI1BEapPShEwUwkRuMwVteAMYwXgQMJ6gHVh7L1LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWqUWOfcuXHMTn13C9ZX7q1qbVAWmqS9l7FpaY4mA40=;
 b=FMi4xVy8odVwm9rArIGl1mW51tJ+gpVTJ41ij3m9rOPhWSP8maUh6GG1YTfZtTAE+IwnPlrEPWpO6698ZckdcUtQFK/AcmSUv3lqSbDpAaztwTpf+OKFIbw5zcdCozvaSS80ZDNy0qd/7ccWC3hJluMfezggCCGR/9aouTiwrrU=
Received: from DS7PR06CA0052.namprd06.prod.outlook.com (2603:10b6:8:54::30) by
 DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.28; Mon, 23 Jun 2025 10:53:29 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::b2) by DS7PR06CA0052.outlook.office365.com
 (2603:10b6:8:54::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.29 via Frontend Transport; Mon,
 23 Jun 2025 10:53:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 10:53:28 +0000
Received: from [10.85.43.79] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 05:53:23 -0500
Message-ID: <82dd98e4-aba0-4413-ac4d-c64cb2d25c7d@amd.com>
Date: Mon, 23 Jun 2025 16:23:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/20] amd_iommu: Add basic structure to support IOMMU
 notifier updates
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
 <20250502021605.1795985-10-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20250502021605.1795985-10-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DM6PR12MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: e59a379d-727f-428a-8f0d-08ddb2442fe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NU5UOWYrTlJBcEszczQzRUxlUVZGTlRTSzYzd3VXWXhvL2ZQL3lmUU9jRjRu?=
 =?utf-8?B?aU9kRmlobU1EMTl6QWFwbERHeGxBaEVQbTFtdVp0Qm42a0s4OGE3ZUx3MkFU?=
 =?utf-8?B?WjFKL2dsYmovL3IvbnM1aDJ6a1hXbkxZUitKMjAxNDZjNU54NGFWNmZxMk5o?=
 =?utf-8?B?dzBQNUFzdFhZM2xyTG5JalpFN3ZlcFk0RDVQMWgvckhkcTdBMTUycHJya1lt?=
 =?utf-8?B?RGhOZjBQM1U2N3dZTVdobGErRXcvRE12UHdEcEtUSmRxZi95K2VQQzNUVW9T?=
 =?utf-8?B?ekFLWWluREZEd2VjbkE5OElKY2tmN2RYekJDd0Rzb0xZQkFsQk1IeEJ1VVZG?=
 =?utf-8?B?OWFhWXRRY1U2Wk96REo0NjA1UElmKzVXUU1xMTU4S0NPMU0waHRWRFF1a0lK?=
 =?utf-8?B?dE80NjliS0RvNzloYVpNNHlvRHNVN0RzYXI4b1JSOEs0SE0wOWIvNHNFK3pq?=
 =?utf-8?B?NHdWRGlBcFRoQmVPKzVaOTN2ZTVBYXVwWFhFMWV6aG83RmZydVd1anVuTTRi?=
 =?utf-8?B?WjdCV3kvc2FOcVdqbTJsYXEyRmd3eTZJamVmWG4zOUQwS2Rsblc1NWEwVUND?=
 =?utf-8?B?VjQ4Zk5ybXVOU21ic1lSSTJYSnNlK3JzOGVpMDI4SjIyRUZRZ0NRaDFWMjFO?=
 =?utf-8?B?ZE1pQ0lLTE81c2FOdkR1VnhOLzkyWXFwc1ZLS2NJMEIydy9ZNXJtczVDZ2R0?=
 =?utf-8?B?bUZtN0FGKzliZ0wwV21IT2RBQ1VEUThZTGI2ZGQxVlU1MU5lRVI3SjhjdXBl?=
 =?utf-8?B?OW1WbE4xSkxjc3R4T1BSZGdSNndxNjU1b3JyVEN3YWxNMGsySC9PVXoxRys0?=
 =?utf-8?B?MmZzbW9DSXhrZHd4QU1FdmdVV3BBbTh5aVlyUnhBbFRWdnFtYzBLVjBDYkdE?=
 =?utf-8?B?UndXYzBzdUJxMGNYdjhjV1ZUTUxGTTNnbzVpdHZGWUgwbE1lMDBmaXRpZWkr?=
 =?utf-8?B?SkIxd1JBZnFaV2VMdHFneHk3ZUQ5YkFORm5UWVo1aXpFQmpYRWsxWDNyMndI?=
 =?utf-8?B?dm9ESWpMalJHZ21WVGpnSXJUMTNZZGlUUTZsczdpcjlFamV6bFRwQUU3R2JN?=
 =?utf-8?B?UTROV29rY0haeDFwTGN2WVJBekdCSjdpRFNITTRYQjVtODR5SFB0dEkxQmRT?=
 =?utf-8?B?YmRjWTU5NDlUV3BoenlOTDlTdytxQ2Q2aWp0bHk2Z2pHRWRwMS9BK1lxT0Ux?=
 =?utf-8?B?elN5ZjAvcm5QeEhxNyt6SVFkVEhPbzZWUVgvRUZDOGEyVU5SQUVDYkhDZ2tk?=
 =?utf-8?B?bjJzWkRqMHZnaG4rdC9yNEtXd0wrS2ZEaWJKSHlmRjYzTkJwSVNuYTAxZFFn?=
 =?utf-8?B?T0JjYjV4d0M1T3FDbTZmT24yWHd1QXJMOG5IMk5uRXhFQ0d2UExPL1FpL1lP?=
 =?utf-8?B?MWkxaWJGYU9KRXJwbDVDWEI2enJVb3VSYktTaW5xSDJLTitMMWVTL2xZcTJW?=
 =?utf-8?B?OXg2ZUhhLzVyVyttTTBQU3lYcnhJV2JxNmlNWTdQU1pJWmRnNmVRK3dLS3hq?=
 =?utf-8?B?YlhzTUpCcUJST2FMTWJJQmdBR09GcUpOdGFMR2lUNGdLT0xyOVZzNGFaMWZq?=
 =?utf-8?B?ZVdhbzVpVGN3U3Y5QVFRUENqWWpvaTZteXBVQmNFZlBEK1pFSU5jdEFvMm5L?=
 =?utf-8?B?WEhFdTdBcUZzV0V4TFZtTzlzUVpPMFZUYk5yNXROL3lsV2Z0S093UThtaWhE?=
 =?utf-8?B?b0NkRk54SnZOdEpjUGRraGkzMzlMYkUzYzBEaG9Vc1RWZ1N3dkl6aFJvMGtB?=
 =?utf-8?B?L01YZmNCekJZb0krblJGN09sdTV6T3FUbHNKRmNKUDMrQTUzSDhDYVpqS2x6?=
 =?utf-8?B?S0lRLzJHUEhxcGhQeGYwUllNcTBnNndieFliSWJlOHlSN3ZReGIwQkQ4cTFy?=
 =?utf-8?B?MHJ2MklqZElIM29hVU00L3dyVm1PY1F1VFlkSVhTOGRsR2x3aGMzTS8zUXAw?=
 =?utf-8?B?SXNyM2xpUVZBWWxubm82d0lzTCtiM1FmY2I4T01wVk85Wk96emE3SXp0UFhG?=
 =?utf-8?B?QWJvajBMbUxKbUZGSjIyODZ5NmszSGJQeU5kMXVocTlTS0kyQnRpY0oyOCtp?=
 =?utf-8?Q?z20vMT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 10:53:28.6688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e59a379d-727f-428a-8f0d-08ddb2442fe5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370
Received-SPF: permerror client-ip=40.107.100.47;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
> Add the minimal data structures required to maintain a list of address
> spaces (i.e. devices) with registered notifiers, and to update the type of
> events that require notifications.
> Note that the ability to register for MAP notifications is not available.
> It will be unblocked by following changes that enable the synchronization of
> guest I/O page tables with host IOMMU state, at which point an amd-iommu
> device property will be introduced to control this capability.
> 
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>   hw/i386/amd_iommu.c | 26 +++++++++++++++++++++++---
>   hw/i386/amd_iommu.h |  3 +++
>   2 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 6a2ba878dfa7..2f69459ab68d 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -66,6 +66,11 @@ struct AMDVIAddressSpace {
>       MemoryRegion iommu_nodma;   /* Alias of shared nodma memory region  */
>       MemoryRegion iommu_ir;      /* Device's interrupt remapping region  */
>       AddressSpace as;            /* device's corresponding address space */
> +
> +    /* DMA address translation support */
> +    IOMMUNotifierFlag notifier_flags;
> +    /* entry in list of Address spaces with registered notifiers */
> +    QLIST_ENTRY(AMDVIAddressSpace) next;
>   };
>   
>   /* AMDVI cache entry */
> @@ -1711,6 +1716,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>           iommu_as[devfn]->bus_num = (uint8_t)bus_num;
>           iommu_as[devfn]->devfn = (uint8_t)devfn;
>           iommu_as[devfn]->iommu_state = s;
> +        iommu_as[devfn]->notifier_flags = IOMMU_NONE;

Hey
Use IOMMU_NOTIFIER_NONE instead of IOMMU_NONE. Though both are same, the 
clang compiler complains about it and fails to compile (GCC works ok).

Thanks
Sairaj Kodilkar


