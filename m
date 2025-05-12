Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D13C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 06:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEN1Q-0008HY-Tx; Mon, 12 May 2025 02:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uEN1O-0008HO-ST
 for qemu-devel@nongnu.org; Mon, 12 May 2025 02:52:18 -0400
Received: from mail-bn1nam02on2062e.outbound.protection.outlook.com
 ([2a01:111:f403:2407::62e]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uEN1M-0004UQ-O2
 for qemu-devel@nongnu.org; Mon, 12 May 2025 02:52:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JRD5b5wOKpc9nZLZmq3cMewrPPI4uz+6rgk559Edaa/W7XA/nblal8GqPV3QQUq06dH7XtDiwZFGV8WXLqi4Zv96qd8LYR3t6W4rKzsc4f9En6c8mXJsn8vOsrch09Psl7r/INblSQYvJtvqUpVR13B3MbrJ+aLUwFl4HbHAEre6owfUVnWQMe/L6Cp0X3L+CJPv/lNukCLSTkbfiTf1/mG+HENP6V5hg/nTF/+GsukUBzGdGjWVMulZzei+/IFSi4+JVJijfbuid7y9TQcUiLidHakYC3qAMPZvUdt2s1ZrgNr7Qx6In2xsLvTG9St7AGAoFQoV9+mJetSscNEXKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPtwxyc96tASJS00YKuvsqdfEoPlwgkyAoSNpKHUbIo=;
 b=BUIgIJYK1IfIOdY6NKkkD84f6nO7OgY2gz+fhUsKIzgpEVuNqDPojDY7EQQskXnu8JQySOxaUKGOGfplzgUiWuugKc7URq1ISGpXsH6gU3meElHCj9d3k91L9fnVLdyQFT9mB+Co+I9V6zRlhzuxlEOPaA4M0nFqKJJeUIuxHOzCQePPtKVh4Q6+/4MRHp6LH4PQt2T9wlDqYER6gMO1QfEquVqRK8BRD+Kf9+0LGGf6HB+vcr9uXZkwnLsNKaHpEGUHHVVM9/ZDNBJRRhU4dq0rZdbm0/jvsZAUCr1bxkn4Jk3gfvYCpSiNUX/3GP/X5ftiMdrfQiqafxJ2kyYNEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPtwxyc96tASJS00YKuvsqdfEoPlwgkyAoSNpKHUbIo=;
 b=BpUR7hMkGa2AFr7dln52reJ0Zm4oibfvJrCj7yyKa1lWMeqv2d5oPqydd8g6RrP7Itp+qLbpD4y7A3rvI3xEbQv4nscg7h+jHgW8hzkEbbJouwIZapui6QLVXiFD8qLsmv3kRnXResbsFEpqiZTvQ89DGy/Yr0BacHHKg6SL1LI=
Received: from BYAPR06CA0059.namprd06.prod.outlook.com (2603:10b6:a03:14b::36)
 by PH8PR12MB7134.namprd12.prod.outlook.com (2603:10b6:510:22d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Mon, 12 May
 2025 06:52:12 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::d7) by BYAPR06CA0059.outlook.office365.com
 (2603:10b6:a03:14b::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Mon,
 12 May 2025 06:52:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 06:52:12 +0000
Received: from [10.252.206.76] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 01:52:06 -0500
Message-ID: <b5b28ea2-3a53-4d13-813d-da40607d0e0a@amd.com>
Date: Mon, 12 May 2025 12:22:04 +0530
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|PH8PR12MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: a98eba1b-11d1-4074-c696-08dd912185d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ak4vbFYzcHowTTRRaytpTHJmSEtURmoreG1VMXZwVUEyZFdvUXFxbFVYeW5s?=
 =?utf-8?B?eXZDSHVYKzhLSVZuTndqV2M1ZndLOTRablh5WXRXVEMzRlNLS2lLMGtTVEpj?=
 =?utf-8?B?ZEFoNUNzL3JWTmY4Uy8yUHhJUU0xaTdsT0xFKzZFdkVuSWxuaFBBdDdXOWZB?=
 =?utf-8?B?MTNFbm16NWtaMHo2ZVVWSEQzVlpiRkd0S2JhNGVHcmtWWkMwWUtrZEFGTHVx?=
 =?utf-8?B?b0lPZXdrdTFGRDBpVkx6dHlRMUJsdlM5SlQ5a2tsNndHWXR5WFJZdDdNeWxx?=
 =?utf-8?B?TzRjTHc1TGtTSWtKTHl1QVB0NVpHRHZrMkNqMDMrZkpOQTJUL1FKOWV1a1F2?=
 =?utf-8?B?S3RYMm55TDh6RE5SRk5qMmorZW0xYm1keXcxN3grMENwQ1NjTXM5bFJMa2Z6?=
 =?utf-8?B?UFJIMVEraHRxdDJ3aW50UFZPblZaNFVhV1hxRmdTTVNIUjVKcVBpQ1hEa0R1?=
 =?utf-8?B?TEszeDFPSlVOWHM3Mi9IUEFKS01Da3FwcTVOOHlHWFhDeVQ5MGlNdDM4Q3lZ?=
 =?utf-8?B?YjJXTWpuYm9FTmZXdjNQRVM4b2xOQ2E2VGRyMGE2NDRIRDZJYUpYcEpqTjNR?=
 =?utf-8?B?SW5UMU1JSC9hYk5jM2Q3SmFFVCtnY3RrYzJXa3RIdU1UdGpqM2I1bVl3bE5J?=
 =?utf-8?B?eE52UForZVIweFpyUWhRZGxsOVNpSThlWERKMFZiU1p0TlBZUys1cW8yMzRz?=
 =?utf-8?B?amRoNkc1TDJDTXNyOCtTaVUwY3NxQ0gwcU4wdVpqSGhMb1dWdEhuTEZudTNa?=
 =?utf-8?B?NnduS2V3L3IveEVFV1ZwQU92U1hQZGt3b2trbDc1dzJ0Y05EWUcyVkQ0REZV?=
 =?utf-8?B?TkRiVEtnRlhjSm5IM1JYcG9tZFVUNXFzM0Q2UU5FWXUwWi9uSEQzcHlsVjRH?=
 =?utf-8?B?ZUl4QzFYUFhaUklMSUF3QWsydEJkalcrRzRXRVhmRW91TXpwY3VwVlU2alp4?=
 =?utf-8?B?M0pjaHowY3o1VW9pdlhYMUVrd3MwRzdtTDY3UUpVcmw3TndiRCtmZ1RNaXZw?=
 =?utf-8?B?aUN5UFIvK2c5L3FWaVFxajY2RzI2ZjZRWWlpd1FSWjNad0U2UG42Mnl6VkIx?=
 =?utf-8?B?S2Z4UDZwNUl5MGw0TWFNc3RWZG9Wc1M1Q2xGM0V0NmhHUWpROXR1WW5EVWtP?=
 =?utf-8?B?TTJOMmJFYjYrb3FzRXN1NlF6eHUxZXp5WU0xdkY1ZXd0ZStxMDlRQUFtVlNQ?=
 =?utf-8?B?SUY3WEJyV1dzQ1pBMzhRekF2bnZaME5GUjRqeitJZzNlNkZLOFFjYW9wZEo3?=
 =?utf-8?B?QXdEazR2RkpTK3FGL3VUUTYxSTFQSEdhNEVYdXJvK2xxaFFXQ0I0a3pmMHNr?=
 =?utf-8?B?b0lRd0NNVEJUeHhncnJoenAzZFZTcnpYOTVVeDJkZmpMS2kySFpLUFhzd2RB?=
 =?utf-8?B?dlpvV2h3YTBHZVlxZWRuZk4yaUpwRUdTL053R1BmWHNwempUenV0VlBmT1NI?=
 =?utf-8?B?OTluNWIyaWJNemt5MzZtVEpQVmNLUk4rcHZnNnNGQ1BPRVlWajBJWXd2b09x?=
 =?utf-8?B?a1JybHcvOWgyaWVBNk0yVUtWSWxzQU5aWkg0N3J2TG51aWVtZDc2ZUJwRzlv?=
 =?utf-8?B?RmxhenBZZ1lDK2wvVi95YTNXUld2eVhHbkxjRWhrYmR6Tkhoa1Q5NUZwS0l1?=
 =?utf-8?B?OGVnRndHTytzLzQrNVpWQXlGdGtEL2QrVWdFRW0vd2xIdnorWXJCZWF1d2ZD?=
 =?utf-8?B?QzZxOG43Yk5ERkVEUEgzbDlVNXFhTi84OE1RRkZZVjFkejBjempVdUhkL3Ru?=
 =?utf-8?B?OXdZc0VaQUh5bEJ3cDczWThmY2dyQmd4WTJONW5RcWlYbW92YVYvQ0ZrYWZY?=
 =?utf-8?B?cWJGSjBtZkNRa0dtMlFDenErOHRZSnFEYjVwNkZHSU1PaHozblBmd0V6MUE5?=
 =?utf-8?B?SlBXOWU2TUVzRmtQRzFDS0tvRFV3L3didDQ1TDN0NWdGczVmVVI3M2NHSUpV?=
 =?utf-8?B?MXJDYVJSNTMrNHlnbmt6c2gxMFR6VnQwNVhETmtFRkFGQzRST0hYL2lHMERh?=
 =?utf-8?B?Y2ZZT3FVSWFGZVl2UFBOcU43Vit4MUR1Qy9qcExOQXVPQTVzY3A3eE5lMzVt?=
 =?utf-8?Q?EoF7K9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 06:52:12.1222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a98eba1b-11d1-4074-c696-08dd912185d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7134
Received-SPF: permerror client-ip=2a01:111:f403:2407::62e;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
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
>   
>           amdvi_dev_as = iommu_as[devfn];
>   
> @@ -1791,14 +1797,28 @@ static int amdvi_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
>                                              Error **errp)
>   {
>       AMDVIAddressSpace *as = container_of(iommu, AMDVIAddressSpace, iommu);
> +    AMDVIState *s = as->iommu_state;
>   
>       if (new & IOMMU_NOTIFIER_MAP) {
>           error_setg(errp,
> -                   "device %02x.%02x.%x requires iommu notifier which is not "
> -                   "currently supported", as->bus_num, PCI_SLOT(as->devfn),
> -                   PCI_FUNC(as->devfn));
> +                "device %02x.%02x.%x requires iommu notifier which is not "
> +                "currently supported", as->bus_num, PCI_SLOT(as->devfn),
> +                PCI_FUNC(as->devfn));

Redundant whitespace changes, please revert.

Regards
Sairaj Kodilkar


