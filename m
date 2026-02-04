Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4070AE8B399
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 04:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnUIN-0002N4-HS; Tue, 03 Feb 2026 23:15:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vnUIL-0002M3-VJ
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 23:15:14 -0500
Received: from mail-westus3azon11011058.outbound.protection.outlook.com
 ([40.107.208.58] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vnUIJ-0000JX-QQ
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 23:15:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k56cH1tIZdPkZ+z/6VksTH65/E90LbMV6iz7/4HwVtPO+vdkCcIrX340nm8Uj4fGjjURFrg6ZM7eQS0pJnWPLEJeKkbqXv4EkkzyGLdiypkCRBYmE+NM6cpuGSyOyeyFROrFL0u4w3xZTWVs3Gta3VxUiK7fj6CFv8j38gMH+yTJj0bzBC1APjK+tc1hE+elzsucBRuJQxFCHoUwO8UnvKlmctl7ldq48ACVte/cauoy58+66a/grtx/6GWBqaevb0nxhxfEor5sFmd+xozHraH9riJILz2rW9NVQvdTQtWqRfFygkBCXlaGKnKZijKFhR7HpBfU9ufA6kNog6stcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iux/Sp0C6GxBAIQdiiieQWeqnJKgb+Lr+q17TaV/az4=;
 b=ZY8pZixYwjthTlFmNkRKRNQ5YMYqGbZN9KSTDVLjcNhf8REpEs5vG7iscTf1A+LV+PBAaSFX8swTFBmp3CPlWXTGEiiY+A9lGLAJlBTYpqETIu386kHFwmM345A2UZoyeIT3IwAA2LzR/oMMQiH48tJ81/eQvHRQbIpUy3UKVREPJ+WqYuOxynoF7QB8H3vE6KwPVbKXkdCKiuSa88RXK0AjoQcPVDaYrHqehv+qCoSuEjHWgULJghRfhsF3BDYbRXKesCCBI5984qBDJ3piNOpWwD5ycmEZixh5mw+l10PuBkPbhISAcJlfNBWnqxVoIsO6/1dVufIqugCkLBpYiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iux/Sp0C6GxBAIQdiiieQWeqnJKgb+Lr+q17TaV/az4=;
 b=e86XihikdfQNBvjN6qZQ3K0tWaClNHAUbRY3wcJp14N+wGrkynXSY2R5a8Mo+5I5ZvYa+Wd95e5pY32zfv485DZlUepoUt3HuD+847FgV6l9AwnFjhkOq1iYM6lw9x7+fwN/xf1hRiTy7dlrQZvPiT97wyD/MbrQAd3pQCpoguI=
Received: from BN9PR03CA0286.namprd03.prod.outlook.com (2603:10b6:408:f5::21)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 04:10:03 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:f5:cafe::1d) by BN9PR03CA0286.outlook.office365.com
 (2603:10b6:408:f5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 04:09:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 04:10:03 +0000
Received: from [172.31.190.188] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 22:10:00 -0600
Message-ID: <acbdabb6-bbe8-41aa-9c39-de7d5c9a1c55@amd.com>
Date: Wed, 4 Feb 2026 09:39:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "mst@redhat.com"
 <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "vasant.hegde@amd.com" <vasant.hegde@amd.com>
Subject: Re: [PATCH v2 1/3] amd_iommu: Use switch case to determine mmio
 register name
Content-Language: en-US
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
References: <20260129102814.4488-1-sarunkod@amd.com>
 <20260129102814.4488-2-sarunkod@amd.com>
 <85c7506f677e3a9145eb8be2212ee62c0b92169e.camel@eviden.com>
 <df3b9d64-b47c-48e7-a368-715a74989cfa@amd.com>
 <0edcc43c-ac6a-4407-867a-4240982f49ec@oracle.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <0edcc43c-ac6a-4407-867a-4240982f49ec@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: d57e0c47-9e90-4f47-3e59-08de63a345b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUxFYndLSHFNQklvNk10WlVLeWJyYXNtTUVrR2l1VTVwYnhta2ZJeWhNWGpI?=
 =?utf-8?B?TWdzS3NOTExWTkJPQmFaN1pIbmJGaUltajYySHNDbWVZL2JuL2FmR3NFSW40?=
 =?utf-8?B?czIwYVNwWmU4empONHl6eEIyaEtwSXVzTG5EODE4R3ZuNmZaZlFnRUl1a3Fn?=
 =?utf-8?B?Um9VSnNxOExoTm9DOTVkZTRQVTVUcGF4WDA3bzN4YkZiKzFOUTNJbDN3MGFG?=
 =?utf-8?B?elhaWitGdFhONWlkbHRZZ0E0MC92WHJJcW5Tb1NUV0hNcmxYRjlLcllaOWx5?=
 =?utf-8?B?VmFSdGVXeVVlWHE2K1VmcmVwS241OG55RzBFM0toME1HUC8xS2toU0dHRnlr?=
 =?utf-8?B?TGlsOHhMdjZJZXYydXNYVnllVzRKcStTQlJMdngyZS81azFkQTZRVlB6dkdu?=
 =?utf-8?B?dFRrU3E5aU92NHVwN1NyWk1zWjAvOWJDUU5OSzVic21JSXpqRjZoQUR2NmQ5?=
 =?utf-8?B?UmxXdmNuejJjeWlicDNua3ZRTFAzVE4vdlEyUURxRGh3OFd6VEFUWHB2Uzhr?=
 =?utf-8?B?NERWUUIwcXY5N0NrS0R2TmxjaDg1K0Q2T29sV3p6MG8rVFo3dDNSNmtqMEZ1?=
 =?utf-8?B?aUdzNk5wS0JsQmtVbHRPNzFETE80QlJmanhEeDdvU2h4R1lpQ1QvUmdML1Fi?=
 =?utf-8?B?eVFNd2VCOVNTRXVZdEFxRmJUOThENjdXNTl2R0JSYUY3Y1QzWUJIeTVmVTcy?=
 =?utf-8?B?Y1BuVW8vM1M3V1U5Q3drYXh3VzdaRzllOHJwRjdhWkI5U21xZDB3QXhwYWtP?=
 =?utf-8?B?TVIzV2NHUXBDOHBvb1NYbm9XMGNocTRmYzRkTTZIVk1nZ1J5UmxZSzhkeDk2?=
 =?utf-8?B?cnlvY0MydFNrY2V6ODh5bnZLdmhuMnhiR0RsM1AvY3VWSEM0UHYvNVE3UVdp?=
 =?utf-8?B?SVBia3F4UUdGU1RzTGptZEVFWG5iM1lmcFJqV09ka2pvRmFWKzBZaVBjS0FE?=
 =?utf-8?B?eXkyTEdXY2lwekdPSThobFlKR2w2ZXpIdmlPYmx2TGJaZHBiaktqOWcxV1Vt?=
 =?utf-8?B?VWp3aTV3NElodWZYTWN6TWVlMWFWTlIrYU8xTWpRY0tRSFptNG41L2ZMQkwy?=
 =?utf-8?B?U3JLVFFySmRxVm5EY0YvSEI3TG9BcGpiUTBRUFYwbXQzbC9jYnNmenVTZ01U?=
 =?utf-8?B?YTFSNUVsT1VySHZyUlNmYVZQTjJwZG8yQ2pYcnJGWWFRTElhdUFndGU0WXNR?=
 =?utf-8?B?K3c2aFVLTW5DcVBGaDgxUnVYbVlWUnhWQjlFZ2dWU0VlZUpmRTc5MFJidGhB?=
 =?utf-8?B?ajZYM09YV3J6NUpzWENWY2FDbmgzTjNtN21abm1EL1NUcVBCdHR2eExESDFP?=
 =?utf-8?B?WS9CNVVSM3plY1VxbjRzR3VXdDNVQ0Rza2JLcVVOc3R5VithOTRGT0hrY2Nm?=
 =?utf-8?B?akFBSitTN0VmcjY2N1VLUm5hUFRqcHJmMWphZGpKcDNrbnRPUzJ3K2pzL0c3?=
 =?utf-8?B?SXppQ3Bjb3VZSkI1N3htZXlsRDBWWk9tSVFiWUtIdzE2U2x5YnVhOEZWNTE3?=
 =?utf-8?B?Ty9rT3lOYmMxcU4rd1RhR21tdi9NR0lkVjVYRDhET21McFdlUjVDU0NwUW8v?=
 =?utf-8?B?YVF2VHpYT1BaZTlDZlFwS3cyS0IxM2txVzVHNnVJMjRQcVROMXlsR2FEVnNk?=
 =?utf-8?B?UzFoTldpdjk3eEJyMUltaDVBVW44Ykd1WmlDNWZTVmRVenF3c054RWJ1RVlU?=
 =?utf-8?B?L2x0WmRRM05KU0x1T1RkRzVQMGd2dUN0NlNwZE93TjRYQWQ3L1pheWtDYWJL?=
 =?utf-8?B?d0ZDdG5FSWxEb2hSVzNMUWRpd0VHRVFRbmsybVhmSCtLM1FPdXFjaFdXQ29p?=
 =?utf-8?B?azNKRTlDbjR2RWF2OVdTNXNPQmExWXc3VDU5NWdDVEhyZG5xWHZJQnowdUZD?=
 =?utf-8?B?RG1ualRQeFV3R0s0RHhGUzlKbXNacDhpNG5vcWdIcVREbkJMZTNVZ1pPdE9U?=
 =?utf-8?B?WFdxRE5Cckxvd2dISWFQYXo1QllpTGc2MGh4QXRkMThIZVpxeDdiblNPOUxv?=
 =?utf-8?B?a0VTNDUxVEl5cmlyR2d4MkdpTXR1NXVhRm1UbTBkSnZMMDBLdTV3Qk82ZGd3?=
 =?utf-8?B?ZUkvaTFKbTdLYUpDeUxOcFAzNVJ4SU85aElxYzVOdHhla3hHQ1Vub2treWlS?=
 =?utf-8?B?cWpRcFRVakM5bWEzNFcranpnc0ZXUFppSzR2b0pxQzRkTUtqMU9aanI2aGQz?=
 =?utf-8?B?Q1lMZ3BsUlRlR1NJVWtVSEVma2gyRWoyTWVyRzZ3YjFJSGFYbktESjRDbHdn?=
 =?utf-8?B?TkdiWVpLcFpLYmRWTmMyVkN5akZnPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tAI258p2x0EIt3KDzUPu/FLW62xSpfNAwVt/J33UzlbHWb60x7HN8I4Dz90MTGQCgtXc67JPBv4euj5RsuQOAGhfUL85e2xSnmjhMqiq0uPIyG4gpOIi6SMtbG3g1bSQ9+51coF+ov1H7pOM97v0q3xgmM0befN/H7lrRGVm7Je6bwckWcKLJ3nsr7y5vgqPf+xm1bhZq0QLKSoNwH2sf6kPkR5FVwlE6hK2gKCufNwOIpvSU/aEvbN1CqnAyikgSFnGm2ZggnXYBiGJaWprqPZN40pk8H5qe/P/YHDo7KayHIBu0FFHPdHQx2zev012eaEsUeIgwCjbvd9nhmN4cmbpQX+K3BVQZN//u7w3m2pRwH7jV8gUL5/QYT+GK47p4DJg85Jzho/pveBaktQdKcViSTvWmgHAgPyuxLbTTmyxMpz1tnl3ijUThhGhAlTT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 04:10:03.2817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d57e0c47-9e90-4f47-3e59-08de63a345b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732
Received-SPF: permerror client-ip=40.107.208.58;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2/2/2026 8:47 PM, Alejandro Jimenez wrote:
>
> On 1/30/26 3:04 AM, Sairaj Kodilkar wrote:
>>
>> On 1/30/2026 1:09 PM, CLEMENT MATHIEU--DRIF wrote:
>>> On Thu, 2026-01-29 at 15:58 +0530, Sairaj Kodilkar wrote:
>>>> This makes it easier to add new MMIO registers for tracing and removes
>>>> the unnecessary complexity introduced by amdvi_mmio_(low/high) array.
>>>>
>>>> Signed-off-by: Sairaj Kodilkar <[sarunkod@amd.com]
>>>> (mailto:sarunkod@amd.com)>
>>>> Reviewed-by: Vasant Hegde <[vasant.hegde@amd.com]
>>>> (mailto:vasant.hegde@amd.com)>
>>>> ---
>>>>    hw/i386/amd_iommu.c | 65 +++++++++++++++++++--------------------------
>>>>    1 file changed, 27 insertions(+), 38 deletions(-)
>>>>
>>>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>>>> index 789e09d6f2bc..62175cc366ac 100644
>>>> --- a/hw/i386/amd_iommu.c
>>>> +++ b/hw/i386/amd_iommu.c
>>>> @@ -35,28 +35,7 @@
>>>>    #include "kvm/kvm_i386.h"
>>>>    #include "qemu/iova-tree.h"
>>>>      -/* used AMD-Vi MMIO registers */
>>>> -const char *amdvi_mmio_low[] = {
>>>> -    "AMDVI_MMIO_DEVTAB_BASE",
>>>> -    "AMDVI_MMIO_CMDBUF_BASE",
>>>> -    "AMDVI_MMIO_EVTLOG_BASE",
>>>> -    "AMDVI_MMIO_CONTROL",
>>>> -    "AMDVI_MMIO_EXCL_BASE",
>>>> -    "AMDVI_MMIO_EXCL_LIMIT",
>>>> -    "AMDVI_MMIO_EXT_FEATURES",
>>>> -    "AMDVI_MMIO_PPR_BASE",
>>>> -    "UNHANDLED"
>>>> -};
>>>> -const char *amdvi_mmio_high[] = {
>>>> -    "AMDVI_MMIO_COMMAND_HEAD",
>>>> -    "AMDVI_MMIO_COMMAND_TAIL",
>>>> -    "AMDVI_MMIO_EVTLOG_HEAD",
>>>> -    "AMDVI_MMIO_EVTLOG_TAIL",
>>>> -    "AMDVI_MMIO_STATUS",
>>>> -    "AMDVI_MMIO_PPR_HEAD",
>>>> -    "AMDVI_MMIO_PPR_TAIL",
>>>> -    "UNHANDLED"
>>>> -};
>>>> +#define MMIO_REG_TO_STRING(mmio_reg) case mmio_reg: return #mmio_reg
>>> Hi Sairaj,
>>>
>>> Shouldn't we define this inside the mmio_get_name function and undef it
>>> after the return statement?
>>> I think it would be cleanup to make the scope of this a bit smaller as it
>>> is specifically written for this function.
> I agree with the above. I think it is a good idea given the ad-hoc nature
> of this macro to keep the definition and its usage together and undef it
> right after to avoid any confusion.
>
> I was a bit reluctant when I proposed the macro because it affects control
> flow (the kernel coding style frowns on that even if QEMU doesn't
> explicitly forbids it), but I think this is clean and easy to parse:
>
> static inline
> const char *amdvi_mmio_get_name(hwaddr addr)
> {
>      /* Return MMIO names as string literals */
>      switch (addr) {
> #define MMIO_REG_TO_STRING(mmio_reg) case mmio_reg: return #mmio_reg
>      MMIO_REG_TO_STRING(AMDVI_MMIO_DEVICE_TABLE);
>
> [...]
>      MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_TAIL);
> #undef MMIO_REG_TO_STRING
>      default:
>          return "UNHANDLED";
>      }
> }
>
> Sairaj: if you don't want to sign off on this specific pattern, I can send
> a patch for it and we can review it separately.
>
> Alejandro

Sure, I'll send the V3 by tommorrow with all the changes

Thanks
Sairaj

>
>> Hi
>> I think this is probably okay as its unlikely to cause any issues in future.
>>
>> Thanks
>> -Sairaj
>>
>>>>        struct AMDVIAddressSpace {
>>>>        PCIBus *bus;                /* PCIBus (for bus
>>>> number)              */
>>>> @@ -1484,31 +1463,41 @@ static void amdvi_cmdbuf_run(AMDVIState *s)
>>>>        }
>>>>    }
>>>>      -static inline uint8_t amdvi_mmio_get_index(hwaddr addr)
>>>> -{
>>>> -    uint8_t index = (addr & ~0x2000) / 8;
>>>> -
>>>> -    if ((addr & 0x2000)) {
>>>> -        /* high table */
>>>> -        index = index >= AMDVI_MMIO_REGS_HIGH ? AMDVI_MMIO_REGS_HIGH :
>>>> index;
>>>> -    } else {
>>>> -        index = index >= AMDVI_MMIO_REGS_LOW ? AMDVI_MMIO_REGS_LOW :
>>>> index;
>>>> +static inline
>>>> +const char *amdvi_mmio_get_name(hwaddr addr)
>>>> +{
>>>> +    /* Return MMIO names as string literals */
>>>> +    switch (addr) {
>>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_DEVICE_TABLE);
>>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_BASE);
>>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_BASE);
>>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_CONTROL);
>>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_BASE);
>>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_LIMIT);
>>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXT_FEATURES);
>>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_HEAD);
>>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_TAIL);
>>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_HEAD);
>>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_TAIL);
>>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_STATUS);
>>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_BASE);
>>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_HEAD);
>>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_TAIL);
>>>> +    default:
>>>> +        return "UNHANDLED";
>>>>        }
>>>> -
>>>> -    return index;
>>>>    }
>>>>        static void amdvi_mmio_trace_read(hwaddr addr, unsigned size)
>>>>    {
>>>> -    uint8_t index = amdvi_mmio_get_index(addr);
>>>> -    trace_amdvi_mmio_read(amdvi_mmio_low[index], addr, size, addr &
>>>> ~0x07);
>>>> +    const char *mmio_name = amdvi_mmio_get_name(addr);
>>>> +    trace_amdvi_mmio_read(mmio_name, addr, size, addr & ~0x07);
>>>>    }
>>>>        static void amdvi_mmio_trace_write(hwaddr addr, unsigned size,
>>>> uint64_t val)
>>>>    {
>>>> -    uint8_t index = amdvi_mmio_get_index(addr);
>>>> -    trace_amdvi_mmio_write(amdvi_mmio_low[index], addr, size, val,
>>>> -                           addr & ~0x07);
>>>> +    const char *mmio_name = amdvi_mmio_get_name(addr);
>>>> +    trace_amdvi_mmio_write(mmio_name, addr, size, val, addr & ~0x07);
>>>>    }
>>>>        static uint64_t amdvi_mmio_read(void *opaque, hwaddr addr,
>>>> unsigned size)


