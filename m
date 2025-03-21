Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1546C35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 08:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvXxp-0004c7-DJ; Fri, 21 Mar 2025 04:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1tvXxe-0004bT-9W
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 04:42:39 -0400
Received: from mail-dm6nam11on2085.outbound.protection.outlook.com
 ([40.107.223.85] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1tvXxa-0006Gx-HM
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 04:42:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/cok9tW1mdc5FdMQSb5aHtmhqEsuvgdp8uuSg0ZMZRi3efGeBsJb158yEmqAUpJEJPOfRp+DrBuO9mMxUKKgBoCVC6xIg3cMudebBF4Mf3F778WzVZ+W5ZdypiuQd+zEMs3Iteg0poS+loZIs+umLtmktE90/cgFid81Ua9pWX5OTV37ev0deda6TWU0uFcflTBf/SOSL182Q2oTU0SBGh7jBf0GVk4JTP+lHjYv2B5NvHr2lgmdtbTzntNNDQud/rpiPqhhI/blczs671bdGs/s23PXChdlbueQuwzsjIAaVdfgU6XI/vyn01ixK1n7Ya8dJsmzI/++KB433WmHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgUm0hv9MtxNj/2IREskCtv47YJxzMA85I3X8JQkD+U=;
 b=H0LidmoXWrevLOU0AbriFbfeQ2WNuQpFFOyWvuy/9XG6HAazxUTNTodNR2+6woZnWax5Z/8vN/emqIZS/yydrjSS0VUHO9TPNBbeLBYrSe7l2I7h85fCUrJh1GQCXsTl0IMlFYvpGZrIJOD+VUni/IuAhP1crLTdegYP/KlmoxcdKgm1PEtS+tVSSXBz7Q0aChIaqnkpi13EKSYQ/ywsB1IYjPTFg6Ms4ful8LEEnWgwDX+quWaV0hWa0wzec/bHKEtUCJux1m4ae2LEEFxEb/W8r4VKwdfdNpObfPki4PtlMEA9e3TzL3T0zNaog/rS/+W3XrmRo2eCzGb/wGxFkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgUm0hv9MtxNj/2IREskCtv47YJxzMA85I3X8JQkD+U=;
 b=KZaXlDMXCoY8m91Bp8hmUOQj+VMN5t82PLQ1G4p0ndknFPNUBmS5Vy+y9tra5dCQkb6bV/S+AHVWk+V6qD8oTnACov/180SbRaBvjoKIJcvapNmXHunZMDU8jtX3fVyX2uIG+V+gSXnYEePJeW5P+Cu0BnzT6wXcPRWGcw4eeQQ=
Received: from SA0PR11CA0194.namprd11.prod.outlook.com (2603:10b6:806:1bc::19)
 by SA1PR12MB6893.namprd12.prod.outlook.com (2603:10b6:806:24c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 08:37:26 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:1bc:cafe::1c) by SA0PR11CA0194.outlook.office365.com
 (2603:10b6:806:1bc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.36 via Frontend Transport; Fri,
 21 Mar 2025 08:37:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 21 Mar 2025 08:37:26 +0000
Received: from [10.252.82.171] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Mar
 2025 03:37:22 -0500
Message-ID: <8ad12ea6-bf76-4ce0-b896-27f6e8db4969@amd.com>
Date: Fri, 21 Mar 2025 14:07:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] amd_iommu: Do not assume passthrough translation for
 devices with DTE[TV]=0
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <mst@redhat.com>, <mjt@tls.msk.ru>,
 <marcel.apfelbaum@gmail.com>, <vasant.hegde@amd.com>,
 <suravee.suthikulpanit@amd.com>, <santosh.shukla@amd.com>,
 <Wei.Huang2@amd.com>, <joao.m.martins@oracle.com>,
 <boris.ostrovsky@oracle.com>
References: <20250311152446.45086-1-alejandro.j.jimenez@oracle.com>
 <20250311152446.45086-7-alejandro.j.jimenez@oracle.com>
 <48b257fe-f3e6-4882-a7ee-9a790b1eab3e@amd.com>
 <c372079e-4d20-4196-be2b-6a7ea9b23622@oracle.com>
Content-Language: en-US
From: "Arun Kodilkar, Sairaj" <sarunkod@amd.com>
In-Reply-To: <c372079e-4d20-4196-be2b-6a7ea9b23622@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|SA1PR12MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: fb838567-2d8a-417b-72e0-08dd68539c11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aitCM1Uzb1kyOHJ2eGRaSkFMRTN4bzVsZ2kyUjJJaWxPVjY4TlA3OUlYS3Fp?=
 =?utf-8?B?NXpFQzRYTkwxdk1tb0dvSXVkTFVFVFlaMjMxR1dCeTd6aEppRHBSdWM5U2g1?=
 =?utf-8?B?MThoRWk1Z1I3b0ZtaFpIOEsrNmhqbnFndVJ6TWVZaWloL3pMV2VlREh6cnAr?=
 =?utf-8?B?RTJHdWtnS2pJZkxEMTVuRlU4SlJ0K2o2cjg3bGZZNnZKZU96dHlHVk1obXVU?=
 =?utf-8?B?ZmJueXltaFhweUJHTHhCNnNuQlY1MFdnTkU0UzZqYmFpVnFRVTFRVXY2Y2ly?=
 =?utf-8?B?c0Z6NnA0RDZKd0NKZFBndGE3N0dzNmMxQ1pZK1BzQVBvdEJtOHhnZmx5VUdQ?=
 =?utf-8?B?ejgxdCtBREUvUUN0REpYaWtFL0dESEticVRRY1hQSlFkWHlCNk1ZV0lvVFVU?=
 =?utf-8?B?YmdBZGh2YXgxeXZYOFhUSkJiVTVXNGJMWTV3Q1BpSENObWl6WVZrWjY5cUNW?=
 =?utf-8?B?TjAyMVRxNnVCbnpVNkI0SEdjUlJJbTgxOUNESXE2c2xodE1LUE1CSE91NkMv?=
 =?utf-8?B?b0xqejZMOXVFeDEzblcva2g3ZnUvcUdSYkM2MkpxdXp4T2tGdGZvMXJ1UWF6?=
 =?utf-8?B?ZkFPL0VYaXFzWVdGWFBiY2Fydm9QU3U5VmU0Q0twY2RzNXJUOGlIc3M1cDZi?=
 =?utf-8?B?TXBzc2xDZHZxY3NCMnhFSFVmVmVWa0VidzRJUG40amRMOWp5U1FON2VwSzFp?=
 =?utf-8?B?VlowVVZDbGVZNE4vb2VjSDlabjVpdlNTaHFCZ2lURnpWbjRraGxuMEhHWWxl?=
 =?utf-8?B?Y3RGQmg0YTVobkNNdENURzBQWHJwNVBCWmt4RUFmZ0RQLzZ1ak04VWRIVFpo?=
 =?utf-8?B?TnVGSHR1MUJyakR2cjV4UFdRWm5ldDRoK3dydlFJMGxBblg2N1A4TkV3NWJr?=
 =?utf-8?B?REszZDU0Nzg1SlJZZFVzUzFZRE9RWkowaTk0RDhjd0M4NnFuK0pyTkI0dHFR?=
 =?utf-8?B?cHZuZXZQL1RpeHBPN09ScGlJZk5vclIwVlpxR3o4WWtOZzVFdFBKclNFNlVz?=
 =?utf-8?B?eGdOQ0Zpb2xpNGhLMTNlS1dmQ3gwUzZNVENzNVNZUWVPWmNVTFJiYkNiNnVE?=
 =?utf-8?B?ZzhTbGp5VVdpdm1BcVhYUXZUVXNTcDNLcVA1NmRaNzZrTHcvdmNiaFBUUHlP?=
 =?utf-8?B?eUNkWk9qY21xY05KcEZRbXllckxJNG9MVDZES0FJS1didWhsOXhKVkxtaU5J?=
 =?utf-8?B?MUk4S2FyMnoxMzFxODFZZWorZ1FUWkp3KzFLYmFGdmN0M2VXSVZSMnRxVHJp?=
 =?utf-8?B?WllvdVBvMUZaQTQ3ZDFiTFRLZGYrUWZqb0h3YXpmVEdOeWIzT2YvSDR6b0p6?=
 =?utf-8?B?V080b3dLSmliU2VYeHRKZXRWQXNHK2hCbU5zUXlxVFpOV2NFUlh4blNacjcz?=
 =?utf-8?B?T0MxTlQvUXErWlFOZmVzS2hrZldiblNQOVpVUEttMzF4OFZ6ZWVhdzRnRVlT?=
 =?utf-8?B?QS9jeHFUOVBwOXJMUDBMaFovdm9ueUpwZm5PSnkzNFBvbDVJOGhpRWNEQlZ3?=
 =?utf-8?B?TG9VNkdINkVScHdLV2prYnBwMlJnbnQvMXlkU2dmY01TeTNlOERDQUc2b1ly?=
 =?utf-8?B?eDZjYmtORmlLV1pWVXpyWktWbmdkcWdEVmtHaUwyUGh5TldHOHJERHQyMkp2?=
 =?utf-8?B?eitkY0tPZTRycEE4ZlRKaHN1bElST3hjZWtzUEFYYUhITkRQUXZ3SDJUekhX?=
 =?utf-8?B?amYrM3FMd3BHWElFY3BnOEV6VHNPVXBxOGZnOGFpQWl3OGRQdG5Tdnhta1J3?=
 =?utf-8?B?Z1Fyc1dXZ2sxa3BGRnIybXdGVGVBUmpJRGI5MnBmTkFCVWtWM0RPK0R5alY2?=
 =?utf-8?B?RDIrM01GbW1qaGZrT2V0SVI5WVZCZlVkUkxVNXNYbElKQkI4UVNUS0t6UlY2?=
 =?utf-8?B?ODJQNS9tK2VoOHk5WEFrdkFhbEJ2U3hyRVF6cTNHVWcycTg0Z3VaQVZLb3Yx?=
 =?utf-8?B?bXFrQmh5MnpSRzVHQVdBOWIwSDgvN3FFVnlUOGtXbEJ2RnQzVUdvZXpka0RI?=
 =?utf-8?Q?JDPG688a0QYpGo0XvGfUmkcNpiJeA8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 08:37:26.5816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb838567-2d8a-417b-72e0-08dd68539c11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6893
Received-SPF: permerror client-ip=40.107.223.85;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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



On 3/20/2025 10:26 PM, Alejandro Jimenez wrote:
> Hi Sairaj Kodilkar,
> 
> On 3/20/25 1:11 AM, Arun Kodilkar, Sairaj wrote:
>>
>>
>> On 3/11/2025 8:54 PM, Alejandro Jimenez wrote:
>>> The AMD I/O Virtualization Technology (IOMMU) Specification (see 
>>> Table 8: V,
>>> TV, and GV Fields in Device Table Entry), specifies that a DTE with V=0,
>>> TV=1 does not contain a valid address translation information.  If a 
>>> request
>>> requires a table walk, the walk is terminated when this condition is
>>> encountered.
>>>
>>> Do not assume that addresses for a device with DTE[TV]=0 are passed 
>>> through
>>> (i.e. not remapped) and instead terminate the page table walk early.
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
>>> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>>> ---
>>>   hw/i386/amd_iommu.c | 88 +++++++++++++++++++++++++--------------------
>>>   1 file changed, 49 insertions(+), 39 deletions(-)
>>>
>>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>>> index cf00450ebe..31d5522a62 100644
>>> --- a/hw/i386/amd_iommu.c
>>> +++ b/hw/i386/amd_iommu.c
>>> @@ -932,51 +932,61 @@ static void amdvi_page_walk(AMDVIAddressSpace 
>>> *as, uint64_t *dte,
>>>       uint64_t pte = dte[0], pte_addr, page_mask;
>>>       /* make sure the DTE has TV = 1 */
>>> -    if (pte & AMDVI_DEV_TRANSLATION_VALID) {
>>> -        level = get_pte_translation_mode(pte);
>>> -        if (level >= 7) {
>>> -            trace_amdvi_mode_invalid(level, addr);
>>> +    if (!(pte & AMDVI_DEV_TRANSLATION_VALID)) {
>>> +        /*
>>> +         * A DTE with V=1, TV=0 does not have a valid Page Table 
>>> Root Pointer.
>>> +         * An IOMMU processing a request that requires a table walk 
>>> terminates
>>> +         * the walk when it encounters this condition. Do the same 
>>> and return
>>> +         * instead of assuming that the address is forwarded without 
>>> translation
>>> +         * i.e. the passthrough case, as it is done for the case 
>>> where DTE[V]=0.
>>> +         */
>> Hi Alejandro,
>> According to AMD IOMMU specs TABLE 44 (IO_PAGE_FAULT Event Types), IOMMU
>> reports IO_PAGE_FAULT event when TV bit is not set in the DTE.
>>
>> Hence you should use amdvi_page_fault to report the IO_PAGE_FAULT
>> event before returning.
> 
> Good point, I had not considered this (and really haven't paid attention 
> to the page fault reporting until now). On first impression, I tend to 
> agree with your observation and will include in on v2. That being said...
> 
> The current role of amdvi_page_walk() is to be a helper for the 
> translate() method and ultimately the IOMMU replay() functionality. 
> These are needed for emulation but do not necessarily correspond 1:1 
> with guest-initiated operations. e.g. VFIO code will call 
> memory_region_iommu_replay() (which ends up calling amdvi_walk_page())
> when syncing the dirty bitmap or after registering a new notifier. The 
> guest would get IO_PAGE_FAULT events for all the regions where a mapping 
> doesn't currently exist, which doesn't seem correct.
> 
> IOW, I think even this existing call to amdvi_page_fault() is not 
> necessary/correct:
> 
>      do {
>          pte_perms = amdvi_get_perms(pte);
>          present = pte & 1;
>          if (!present || perms != (perms & pte_perms)) {
>              amdvi_page_fault(as->iommu_state, as->devfn, addr, perms);
>              trace_amdvi_page_fault(addr);
>              return;
>          }
>     [...]
> 
> I am aware I am jumping ahead a bit too much, but the point is that the 
> whole event reporting likely needs a comprehensive review.
>
Hi Alejandro,
I agree with this and we can do a comprehensive review before reporting
page fault in this path.
I think in future we should separate these two paths (replay and normal 
DMA translation). That way we can report page faults in DMA translation 
path and keep the replay path clean.

> I need to study the area a lot more since even the simplest/only current 
> use of amdvi_page_fault() right now is not very clear to me.
> 
> Alejandro
> 
> P.S.
> Also confusing is this assertion in 2.5.3 IO_PAGE_FAULT Event:
> 
> "I/O page faults detected for translation requests return a translation- 
> not-present response (R=W=0) to the device and are not logged in the 
> event log."
> 
> so this suggests we should not emit a page fault i.e. don't log it in 
> the event log.
> 

Here "translation requests" means ATS translation requests and not the 
DMA read/write. Basically IOMMU emits the IO_PAGE_FAULT when it fails to 
translate the DMA request but returns "translation-not-present" response
to the device for ATS request

Regards
Sairaj Kodilkar
> 
>>
>> Regards
>> Sairaj Kodilkar
> 
> 


