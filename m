Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2D7C369D3
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 12:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7CeZ-0004AF-F7; Tue, 22 Apr 2025 08:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u7CeV-00049k-I9
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 08:23:04 -0400
Received: from mail-bn8nam11on2085.outbound.protection.outlook.com
 ([40.107.236.85] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u7CeS-0004VB-6V
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 08:23:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1nXiGMmQ5rTDNKWLlOwohuvyv0iK0jEYNxr5deQEY67I3zjOqZyw22jIA5HatP5LT8uNX/Wb27vM9zHOlplvrVu+nRrpcHxwX49edgPX5HpqIYZMUBvTZFkOJeVX6UkH0+VRoE7kKoBZvrF2nuZ/OH9oyge7S1GpGb7m9AZa/OO7e3jXfY0t5wzFzMJgxUm3kY7HzbbFjhsDa0IuShMPNuoODFeNi9mC3cI7ehclYsFOv0qSzxcbQEgMuK1u/FOkZhanSLKByTNtwwMW/vNkRE+lJ4AKLj0yiMwmgUHprr1athMcPyHZwmTF8B4Z1dVT1IL0hObR3fQHyEbOsyr8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHcWWBqmmLDVcsHcOMQ1GwaMgZVevjSrgSmQi9IYhR8=;
 b=NDb4ylZ5HvzqMjIfgHpto9KUToxHce9eNfiNOINl1eJ8cuoZcm/ePh1j65qhCpdYttylhf/5OD46aWKvFQLbosD62H71bTEkdzBdohbxv8qe5BMtdZAmzU0NBmJY2OPcxO8YzSgzinYSiwAh6AZPIfYFOHaf9MnMXsowv/9NkFBtb2Db1aA6QrL08bNS0NPT9um9+af4Cx100Q0qLyEbt6vX9qDTezrio39YgT09X2eZCGXFnZX82Wm1wjTvmK5BMgNfzjqbOqBixdVqtebsBSBg6ybWR7a7+WRJy/SInDQPx42ltnbRsGtnDU0BKDMVZ7q+SKWS2/i20IZjYvCQ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHcWWBqmmLDVcsHcOMQ1GwaMgZVevjSrgSmQi9IYhR8=;
 b=hzknkbGN5nh8QZKRbiSbYrHwVM4UyULQw8RMpTM0xOYD9pHpYV93CvFpEQK9o57Q8FX/2+ZO3LCvzsggYe7kI2B+udrIIriS22rGQV+lYy+P5xjlaNDB6BxDl+Mv6XUMtNdJoqnzb5qU9hcU27vLzPWbPPXIvUV5qDtAtSgfxGU=
Received: from MW4PR04CA0331.namprd04.prod.outlook.com (2603:10b6:303:8a::6)
 by DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Tue, 22 Apr
 2025 12:17:50 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::63) by MW4PR04CA0331.outlook.office365.com
 (2603:10b6:303:8a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Tue,
 22 Apr 2025 12:17:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 22 Apr 2025 12:17:49 +0000
Received: from [10.136.47.77] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Apr
 2025 07:17:43 -0500
Message-ID: <328a5ac5-c025-4fe9-8efa-5f6185aadb40@amd.com>
Date: Tue, 22 Apr 2025 17:47:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/18] amd_iommu: Toggle memory regions based on address
 translation mode
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <peterx@redhat.com>, <david@redhat.com>,
 <philmd@linaro.org>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <alex.williamson@redhat.com>, <vasant.hegde@amd.com>,
 <suravee.suthikulpanit@amd.com>, <santosh.shukla@amd.com>,
 <Wei.Huang2@amd.com>, <joao.m.martins@oracle.com>,
 <boris.ostrovsky@oracle.com>
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
 <20250414020253.443831-6-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20250414020253.443831-6-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|DM4PR12MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a09237-4565-46e7-4cbd-08dd8197b288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXJJUzdZbmxrcHJkaTNTVVc0bVdPNUF2VTVyVG9pdDY5cW40aDJ1MGZFMUFF?=
 =?utf-8?B?aFhpck0xMXZEbWVhMWhUOE1yVVM5MHIvZy9EUDlkYlJPeHBzUFRaMmJ2c2R2?=
 =?utf-8?B?bkFiSi9Hd3gwNElWUDhKam95UWFjTjBRVHNwRXVXS3RaTjBSZHFsbHhrL1E0?=
 =?utf-8?B?NHRiaXpYbFQ5dEZWWEVkYXFwby9HaE93SmprQ2I0SERLZ1RUN0V0ZmtGNXVN?=
 =?utf-8?B?a3M0WHg1b0hEREVKRmxhbWNXaTc0ZDJQQnVweHkxcXlVQmNscm4vWnZqTVVJ?=
 =?utf-8?B?cDRrS0VjYWRLRmdnL3Z3V2JqdlpENDUyZmN3Z212QjJwWVQzb3hVRk1KazNC?=
 =?utf-8?B?d1k0MUk3TXF1ZWFyaWZnbEg2cFdLalpQZjFOTTFHRHVIcmdMTXBxTFdibWxq?=
 =?utf-8?B?c09PLzhkUWF0VjdiUTF5Unh2aVlLbGs5cXV4Ynpyd2FSOEdtcDFiVFJCMmZ5?=
 =?utf-8?B?azNGb3UwUUNqd05DUTU0OWl0c2RRdEtvUzZXUjUxTExVdXE1QnkzdDhVVjJJ?=
 =?utf-8?B?LzlWck05VmpsZlQydm8yWTJxMHpHV3RsUktzUys3UlNhbThSQ1FxRExUazVy?=
 =?utf-8?B?RXV3aks1SVZkaXA3TG9OWTBLdTZuVVQrR3FITUQydHUzdThnc0o5dml4MzRI?=
 =?utf-8?B?Z0FBcDhRVzVYd3RhMlZVbjEzTnZDczkxVUhaOEdkcEl2MHRpVXI4bUtGVkFP?=
 =?utf-8?B?SzNBTG9wM3NrUHVlcXlxUUJwbkJ2SGdqR2hvSVBKdzZqcFMzU3pOZmlpbm05?=
 =?utf-8?B?WU1ZVG9EV2pSQlkvSTg2SGtwVGp4M243WGp2ZCtPL2E1dHhkK1Z0TXBJZjhI?=
 =?utf-8?B?NkI3M0xtR3lZU1Fqekp2VG1pdjVKcmZra1F4V054WENzZE0zRm9hNkxPWEdz?=
 =?utf-8?B?SWpMR3FRZitidXhZWTQ1NVcvTitlN3hyNkFrWjJjVS9NNGFYM3pBSFN5R05x?=
 =?utf-8?B?aU1zUGZGMnE1TFVRbFlTaVV0UWlKRlBGZnBVbUd3N0NhODZFM29tZWFSSm9S?=
 =?utf-8?B?ekwyUlg3K0JHV3d3VS9yWEp6dXdpTkhiMjFVeERJMk52NmJKd2lyWTh1Z0lC?=
 =?utf-8?B?MW80M1k4UnB5M2VHTXNLT09CdkR2SHpQNGF0b3lJaXRBSkZNOXc3UjR6WnFI?=
 =?utf-8?B?cXBqRkdkRXhnVWxHcDBCRHVNcHJvSkszL0ExUnFZdWx4TFVEUlUvRDJXRUxH?=
 =?utf-8?B?Y2pCV3lpbDY2YjFJbkVwWGlHcFJZbHYySy9IdTk3N3MvdmhZdXdVSjVmUVNE?=
 =?utf-8?B?VkVxM2xkUFRuT3dNbitUcm1OVzlGRFhsVHRjY21CbEd4OFRHMHlORTBmZnRR?=
 =?utf-8?B?b2JMOUphVDViK0pNSE01MDJRbG81anpaSmNBN1FLdE5vcFQxK2J0bUtKMjE4?=
 =?utf-8?B?RGVpNXR6dGlEcWJBeUsxUW11dHA3VkhjZUg2alUrckVTU0Nab3NMdUxwNHFn?=
 =?utf-8?B?SlhnWFRERnJmU0hDd1N0V040eGZvanpKS3Q3dVZZMmc0SFVNekUvMllWaFhu?=
 =?utf-8?B?dWF6MVVkeEROY3ZaeFc1eUUwMWlrNzZvSlNsUUxVZTRucEdzME1sQnJtKzR0?=
 =?utf-8?B?dy9iWWRmdFRMeWNNWk96Y1VMRldxSFEzWWN2OUY5bXUyMDdzL0lVV3prcTJT?=
 =?utf-8?B?Y0dJOHFuNzFiN2dQa1NQdC9GSStrdFFoL2JWT1dNM2puUml6Wjd6eFBlTklZ?=
 =?utf-8?B?MTIyaEhmcG03YkxNSlBpNnJNdWVyYjBKNkF2QkgxZ0NDekxmM2lCZFdhamp2?=
 =?utf-8?B?T0VnZE4ydmFtWWJrNFJKc2pOMXl1VUd4MkUwaTRvamVlRHpFaCtic284eGs2?=
 =?utf-8?B?VEFIUzBITjdpeDBRdk45U0Ribm1FV2NIWWNhdU9ZczE5bGhaRmFiU2dtK29U?=
 =?utf-8?B?Q3FvcE1lM0N5RlY5ZFcyKzdrK3N1OFRXQWg5MVVSNlVtWTIwVG5kV2dTeldw?=
 =?utf-8?B?OTdBMDJURTdxNmlOU2xJTzZ3ZGNEb1lPTHhNYjJqSnh4Mk5PcUYvbDAydmE5?=
 =?utf-8?B?NWEvazdrWHZSZ2JxMUNyLzRNYndWY3R0Z3FZOUdrb0VKeHk1Q1puVXJBNkx6?=
 =?utf-8?Q?V67VAa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 12:17:49.0393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a09237-4565-46e7-4cbd-08dd8197b288
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6280
Received-SPF: permerror client-ip=40.107.236.85;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
> Enable the appropriate memory region for an address space depending on
> the address translation mode selected for it. This is currently based on
> a generic x86 IOMMMU property, and only done during the address space
> initialization. Extract the code into a helper and toggle the regions
> based on whether DMA remapping is available as a global capability, and
> if the specific address space is using address translation.
> 
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>   hw/i386/amd_iommu.c | 30 ++++++++++++++++++++----------
>   1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index ad5869e72fdc..3f9aa2cc8d31 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1529,13 +1529,31 @@ static const MemoryRegionOps amdvi_ir_ops = {
>       }
>   };
>   
> +/*
> + * Toggle between address translation and passthrough modes by enabling the
> + * corresponding memory regions.
> + */
> +static void amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as)
> +{
> +    AMDVIState *s = amdvi_as->iommu_state;
> +
> +    if (s->dma_remap && amdvi_as->addr_translation) {

Hi Alejandro,

I know gnew0 initializes addr_translation to 0. but should we explicitly
initialize it to 0 ? in order to make it more readable.

Regards
Sairaj Kodilkar

> +        /* Enabling DMA region */
> +        memory_region_set_enabled(&amdvi_as->iommu_nodma, false);
> +        memory_region_set_enabled(MEMORY_REGION(&amdvi_as->iommu), true);
> +    } else {
> +        /* Disabling DMA region, using passthrough */
> +        memory_region_set_enabled(MEMORY_REGION(&amdvi_as->iommu), false);
> +        memory_region_set_enabled(&amdvi_as->iommu_nodma, true);
> +    }
> +}
> +
>   static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>   {
>       char name[128];
>       AMDVIState *s = opaque;
>       AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
>       int bus_num = pci_bus_num(bus);
> -    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
>   
>       iommu_as = s->address_spaces[bus_num];
>   
> @@ -1595,15 +1613,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>                                               AMDVI_INT_ADDR_FIRST,
>                                               &amdvi_dev_as->iommu_ir, 1);
>   
> -        if (!x86_iommu->pt_supported) {
> -            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
> -            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
> -                                      true);
> -        } else {
> -            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
> -                                      false);
> -            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, true);
> -        }
> +        amdvi_switch_address_space(amdvi_dev_as);
>       }
>       return &iommu_as[devfn]->as;
>   }


