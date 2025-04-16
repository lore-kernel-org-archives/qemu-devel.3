Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD899C369BD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 12:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u51ql-0000su-Vz; Wed, 16 Apr 2025 08:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u51ep-0001hA-RM
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 08:14:23 -0400
Received: from mail-bn8nam12on2062e.outbound.protection.outlook.com
 ([2a01:111:f403:2418::62e]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u51em-0002Vz-2R
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 08:14:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpoWWbTJJsMLVDh79QiUulmFPdCzlhFVBACqz9SwwVGqyc992uJn/okcxPIy7q2mEl6k1PdiIf2Ros13aOWvz0V0k28MalKKiErCpHG0oNruEE+B8y3anWXo4fVxHqPNW7Yu3BoSjN4yyuSW4sheao3PFbOrFrhh6dszTVPW1NH6KC/5dAzpqbyDcDb9i54maDnpB3EFq4/VPK8I+nI5cDypcdW4VyJ56BqTULI300+/TIIcgshwGg/SEcnR9HPc9ivwmaGkvuVQWyd9FECW62hRDuPi/LfQRxqze1JRkKrQe/6tdQ0LCtXDoKXKTpjOLLplQnok3qBLrujn80nIoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9VwuNqEOHRZMiykn+/gv0RL8QubYZkGSuaG0g1z+IA=;
 b=a4XJrjHtRSnr9hznzREEBQCTpy3DRYtPVn+Rn7o/mu/KnUg2DZKa+XOwGr5QBpXTGkScPvGiv2gT8WTnKPW+cqmCXK2D+5vdwQfezqAoeyKA4RmOSYKynvGZ1hjjXKhTW5Af7uT+3biQ4Hws6l9N93jkUPIzc3kIuudt+ApgWyUh9840enDfX/pbaBF/m8b0RsKw9bi4jk5w9ATJVIu0TlkMQYWzRR/xh6qxt4zKIFAthR6RWRbGLlmuufhR0d+NgROr9M2p7wKdCnAtKktg28Btw8Kmgmc/58CiSdLePwv4cWi3A0zIc4HRVDE5i9MrG/YQUZQfsLneSCt36V7m7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9VwuNqEOHRZMiykn+/gv0RL8QubYZkGSuaG0g1z+IA=;
 b=QGkzTaY8WPbvIx1IFX9bLMSBrj97AxzNR+3tvYORr6bpk0pqTJri2z3eAW4XcDGg+jTlNZLs8BAEgIGeiSBsNEC3c5ZG/oi3ZarsfAUBOGtp91BDZdoayE/JO40YE9yLXbe1M0mg2ZWA/EFljgQbTAQVp8fxYdPiQXBsmZbVoWI=
Received: from SA9PR13CA0111.namprd13.prod.outlook.com (2603:10b6:806:24::26)
 by MW6PR12MB8960.namprd12.prod.outlook.com (2603:10b6:303:23e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Wed, 16 Apr
 2025 12:14:11 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:24:cafe::77) by SA9PR13CA0111.outlook.office365.com
 (2603:10b6:806:24::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12 via Frontend Transport; Wed,
 16 Apr 2025 12:14:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 12:14:10 +0000
Received: from [10.85.32.54] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Apr
 2025 07:14:05 -0500
Message-ID: <d4c11455-f28f-4052-9042-5d2c2ed9329d@amd.com>
Date: Wed, 16 Apr 2025 17:44:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/18] amd_iommu: Add support for IOMMU notifier
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <peterx@redhat.com>, <david@redhat.com>,
 <philmd@linaro.org>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <alex.williamson@redhat.com>, <vasant.hegde@amd.com>,
 <suravee.suthikulpanit@amd.com>, <santosh.shukla@amd.com>,
 <Wei.Huang2@amd.com>, <joao.m.martins@oracle.com>,
 <boris.ostrovsky@oracle.com>
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
 <20250414020253.443831-4-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20250414020253.443831-4-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|MW6PR12MB8960:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d48e482-ccc6-4298-4a1f-08dd7ce03190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2ZGdnVOb0toYngzUzJjM2VnS0R3K3ZyQ3YyRTRQTFRrK2srRnNZMGtZdTFJ?=
 =?utf-8?B?bnFVZGEzeUlyMEhlNzZrYUd4N3U3YndURUJQbWdxcU11em1UaEpPOG5BQ3Zx?=
 =?utf-8?B?NWF5R2MxTVJiUUxRVzFGbzFCbnRXL1hlMjY5a0QzNCtGdUNVZk54RVRaV3F1?=
 =?utf-8?B?bHhRTEFiVkpWamh2Q0JHU3hFU2dkamQ2YkdpVkZKeGYybUhQVXlWRmZmUTNB?=
 =?utf-8?B?Q2p2OENyOUthSGFpNnR2d1RrVE8vbjFPUXFLU0RlTjZIMm45U2NBM25EWmts?=
 =?utf-8?B?cnZ2MDN6TzZaQ0xjenFJS2haRGJ4YmVDaVozMDVnUDRHbXFENU81K1VxeWFh?=
 =?utf-8?B?aGxZTnpZYnJZbER3ZXVxWlVNRnZtTzNORFpFaWdLbDc1aGdzak9RVmNEaHc4?=
 =?utf-8?B?UCtkbm5DdTRkRlFrVGVaa1Z6NklpRXlYRVNZRGpYTmdPL1cvRTJpYW0vcThm?=
 =?utf-8?B?c2JqNUxBRmNNSGd6ZXlUTGNHR3lkRkR3aGtibUtmSC9LNDJtKzNwbGtneFBU?=
 =?utf-8?B?YTVHRS9OWFFOcEtzR2gzUTJ2MjdFbTZMM054TFgyaW9aUjFmL1Y0c09lVC9v?=
 =?utf-8?B?a25WVWNSYjhoK2J2NVdYa0puOXBmbmsyWHh3bW5pQkFobXZzWEI5eVlVc3pP?=
 =?utf-8?B?T3BqSnRrN2J2RWpsWkh0T3doTW5LZjF1ckV3bWJXdy9QTFcxNDdTT2hqQ2lu?=
 =?utf-8?B?NVhiQ1crOXFxT2d1QUN3RDNEempTTDE3endpb2xTQVpVTUNWY2tqUFovZWor?=
 =?utf-8?B?T0R0SEVXM1FmYXpMdW5Rc3hKYnl2dkxobG1YaEFhU3pVQys5MENzMU9aVFh5?=
 =?utf-8?B?Ym1TNFJ5SnpkMmJ3Y3lJd0Z4S1U4Mm9KeWRXTWRpUEIwalRkZ1UzQmpxeUsy?=
 =?utf-8?B?VmNKSWY1Y2xlWm5YWS9LVUJIb0JmSzRYWFFyUlkrUnZRSmc3VUhKUnY1OHpl?=
 =?utf-8?B?MXEvNUowNjl5YzZhU1I2TWhhZkpYZE9kRXhGRFB2MHlDQ2FTM2ltbUNEZ1pl?=
 =?utf-8?B?eWYyZ0pEenV4TTlidjQ1WVRrK2ZtcGNHdXBnRkhoTFcvcUtleXlaT05LNmlQ?=
 =?utf-8?B?dFBSRHRWVmxRWDk3b2l4cWIxTW94UHZNMlFYdVFWaEFYVENyRlFIOHZiWUNl?=
 =?utf-8?B?MTR3Wk5HMWYwZGluUFJqMmNYL1RIdnpyZ1E0ejhIMkpSOHNrbUNFRkNpKzRv?=
 =?utf-8?B?QWJlYlRRb2xtVXlXQWtDMGNYS0VUYkxLdnI1dG5mNVZNYmJxVGc2YktIazZK?=
 =?utf-8?B?azVSdjV4T0UvOGlnaTFiODNoNmpSaWxYalpucmRtcFZZNHBxang4Y1g0akF6?=
 =?utf-8?B?OGZmTW1JUU9LdlpScEdvSkE4M2dqbU1ad0YwM1JaeHlZb0FCQjZadklxd2hl?=
 =?utf-8?B?aUxsMzZud29LTjlQYThUYjhReld2L29UZlh6MzdibmVSVmgxTTdZSFlDcDJx?=
 =?utf-8?B?TUVJdEpZeCtoblNyUWlOQS9La0pQbVhkVGt3T2YzZDAyd2JQSVcyTHBJZlho?=
 =?utf-8?B?OVduQUJrSEZuS2hPaVZPVTR1L0xHd1RnN043NmhRMUUwbFpDUk1KRStoSk5y?=
 =?utf-8?B?MnBSNG1CYzJKUEZIeVZZVlhneUZHS2pFa0pVOFArcVRuMVVyMWZOemo2UE12?=
 =?utf-8?B?elExK0lFeTY2aDN1SFlCQ2tJVzQrWVJ1YnA1Wm5aakZ6MmdwWnhybVZ5dDUw?=
 =?utf-8?B?Sy9nUTJjNjAwdmZwbjFVOGlsMnpuNHlRRk16aWVFSEs3cHVseDdSMVdwTnZj?=
 =?utf-8?B?NC9SZ3JZaWg1WSswQ21HVmxpNlQyWm5YVngvSE1vckp1R0lMN0hKRW1TU3ha?=
 =?utf-8?B?QVJ6T3NNSlVNc1MzYnpXaUVsYVg2NGQxQ0JxWVdWSi80Z1JQRkQ3SEtDVGVY?=
 =?utf-8?B?OVEwb2xIMzVrMXVFYk9GK053a25tMTlzNG81NXBvUVE4U3RCclo5QkhCQUk2?=
 =?utf-8?B?VlZYS2dycGFvWUpxZWtpZ3BYaTZVdFdIam1lYktJOUdLOHdwa0d5L3VDNXBj?=
 =?utf-8?B?MXlKbjk4ZGtneC9SZHV4VHZsd3NOQWkvcHgzTDJuZnZvQ0FhSlRkS29oNE5m?=
 =?utf-8?B?UzYySjZDOHlhTitQS1FiblM5TkRmVXptNlBrdz09?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 12:14:10.1911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d48e482-ccc6-4298-4a1f-08dd7ce03190
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8960
Received-SPF: permerror client-ip=2a01:111:f403:2418::62e;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

Hi Alejandro,

On 4/14/2025 7:32 AM, Alejandro Jimenez wrote:
> In order to enable device assignment with IOMMU protection and guest
> DMA address translation, IOMMU notifier support is necessary to allow
> users like VFIO to synchronize the shadow page tables i.e. to receive
> notifications when the guest updates its IO page tables and replay the
> mappings onto host IO page tables.
> 
> This requires the vIOMMU is configured with the NpCache capability,
> so the guest issues IOMMU invalidations for both map() and unmap()
> operations. This capability is already part of AMDVI_CAPAB_FEATURES,
> and is written to the configuration in amdvi_pci_realize().
> 
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>   hw/i386/amd_iommu.c | 34 ++++++++++++++++++++++++++++------
>   hw/i386/amd_iommu.h |  6 ++++++
>   2 files changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 22d648c2e0e3..8dbb10d91339 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -66,6 +66,13 @@ struct AMDVIAddressSpace {
>       MemoryRegion iommu_nodma;   /* Alias of shared nodma memory region  */
>       MemoryRegion iommu_ir;      /* Device's interrupt remapping region  */
>       AddressSpace as;            /* device's corresponding address space */
> +
> +    /* DMA address translation support */
> +    IOMMUNotifierFlag notifier_flags;
> +    /* entry in list of Address spaces with registered notifiers */
> +    QLIST_ENTRY(AMDVIAddressSpace) next;
> +    /* DMA address translation active */
> +    bool addr_translation;

I dont see any use of addr_translation in current patch.
maybe define it when you are really need this flag ?

>   };
>   
>   /* AMDVI cache entry */
> @@ -1561,14 +1568,28 @@ static int amdvi_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
>                                              Error **errp)
>   {
>       AMDVIAddressSpace *as = container_of(iommu, AMDVIAddressSpace, iommu);
> +    AMDVIState *s = as->iommu_state;
> +
> +    /* DMA remapping capability is required to implement IOMMU notifier */
> +    if (!s->dma_remap && (new & IOMMU_NOTIFIER_MAP)) {
> +        error_setg_errno(errp, ENOTSUP,
> +                "device %02x.%02x.%x requires dma-remap=1",
> +                as->bus_num, PCI_SLOT(as->devfn), PCI_FUNC(as->devfn));
> +        return -ENOTSUP;
> +    }
>   
> -    if (new & IOMMU_NOTIFIER_MAP) {
> -        error_setg(errp,
> -                   "device %02x.%02x.%x requires iommu notifier which is not "
> -                   "currently supported", as->bus_num, PCI_SLOT(as->devfn),
> -                   PCI_FUNC(as->devfn));
> -        return -EINVAL;
> +    /*
> +     * Update notifier flags for address space and the list of address spaces
> +     * with registered notifiers.
> +     */
> +    as->notifier_flags = new;
> +
> +    if (old == IOMMU_NOTIFIER_NONE) {
> +        QLIST_INSERT_HEAD(&s->amdvi_as_with_notifiers, as, next);
> +    } else if (new == IOMMU_NOTIFIER_NONE) {
> +        QLIST_REMOVE(as, next);
>       }
> +
>       return 0;
>   }
>   
> @@ -1700,6 +1721,7 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
>   
>   static const Property amdvi_properties[] = {
>       DEFINE_PROP_BOOL("xtsup", AMDVIState, xtsup, false),
> +    DEFINE_PROP_BOOL("dma-remap", AMDVIState, dma_remap, false),
>   };

Please add a description in commit message for this flag

>   
>   static const VMStateDescription vmstate_amdvi_sysbus = {
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index 28125130c6fc..e12ecade4baa 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -365,12 +365,18 @@ struct AMDVIState {
>       /* for each served device */
>       AMDVIAddressSpace **address_spaces[PCI_BUS_MAX];
>   
> +    /* list of address spaces with registered notifiers */
> +    QLIST_HEAD(, AMDVIAddressSpace) amdvi_as_with_notifiers;
> +
>       /* IOTLB */
>       GHashTable *iotlb;
>   
>       /* Interrupt remapping */
>       bool ga_enabled;
>       bool xtsup;
> +
> +    /* DMA address translation */
> +    bool dma_remap;

I think you should use this flag in the remapping path as well.
I am aware that you are using it later in this series to switch the
address space, but current patch will make things inconsistent for
emulated and vfio devices (possibly breaking the bisect).

Also newer AMD IVRS format provides a HATDis bit (Table 96 in IOMMU
Specs [1]), informing the guest kernel that V1 page table is disabled in
the IOMMU. Its good idea to set this bit in IVRS when dma_remap=false.
This way a "HATDis bit aware" guest can enable iommu.passthrough.

Also, is it a good idea to have default value for dma_remap=false ?
Consider the guest which is not aware of HATDis bit. Things will break 
if such guest boots with iommu.passthrough=0 (recreating the pt=on
scenario).

[1] 
https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf

Regards
Sairaj Kodilkar

PS: Sorry If I missed something here, I haven't progressed much in the 
series.

>   };
>   
>   uint64_t amdvi_extended_feature_register(AMDVIState *s);


