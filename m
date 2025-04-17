Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F460C369C2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 10:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5MLQ-0001ao-QG; Thu, 17 Apr 2025 06:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u5MLK-0001S7-O0
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:19:42 -0400
Received: from mail-mw2nam10on20626.outbound.protection.outlook.com
 ([2a01:111:f403:2412::626]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u5MLH-0005v8-AA
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:19:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WwCMMPIC+ltezeqksBBBmzcoctX/wxNRbU6cBAAuNZw6WPU10vSw+M6Z0R4Va5SAYGpw0ZAJvxH7yHtEkLkx1s6h5sV5kSouwjYu4oATmfLmpGH5Dc4/y3hhghTr/1eQ5avaR48XlSJtBpIRopGbdeoBU0kcVWGm+MktB5WT2UMOKWVrcbhpEZNV0pQtK31kWArxYkYMV6Yu7NPX7heCoLF3hUESGcw1pYlgowKs9ojTtJzzQOgKcuR7aYp/J+XKtNuMKwFW6KfH8MqGfJOKkVYGMbvg8VRlGnhuPiSQcoYedQmtBW9NEz2trPcR5PCxvhn6Jb+KFOxC74SSGre1zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/egsK004Awc7pVIEwBMlaGqDg0EkcQMWHuetzo0X14=;
 b=ZLeNxWfPNcEXhjS+q+jBPjAYnfcBaiWOyICcs7zm5dts9wYsueUAqWjoym0I2KKXmoLwXWwxko/sN9aNrd+G0NuGVa77Sw6AkGUsVzigHv1Y/9P3/YQLVR5TfCV+AV9wHNEOcCo1L4qV1+eqsJUWr3ja68UdBmNVp23DJl70saTHc1/6SF5nkgjSwcWaqdaAsUy7veSYGJL6Ube4GSxki5HknoBO+gvVvsxeK3M1gF8OBIy1opHRJ+EVsCcVCrTFewOJImvYH0fLiBezjPRL8f0lZKtLf1hWw+Mni0IPeUkQt2p7F1T37gi6JkyQo0uj3tDBAY5xDoMU7n82sEuPVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/egsK004Awc7pVIEwBMlaGqDg0EkcQMWHuetzo0X14=;
 b=DXS6IpUHP9/Y81NzngaxkHXW/JLZQay5tKoeMeafr+Nn03/iMQL6ROCwW/MzEr2epjNa110HnjVY8/QvIWe2kYO0of0Y0ePoM39Bezxm9yUd8PoiNiJRhAW4M8UsYG6RGOSkyrh+nBfWgY98JdWMgxj594gfhB3Zi4QfqSOQp14=
Received: from MW4PR03CA0246.namprd03.prod.outlook.com (2603:10b6:303:b4::11)
 by SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Thu, 17 Apr
 2025 10:19:26 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:303:b4:cafe::32) by MW4PR03CA0246.outlook.office365.com
 (2603:10b6:303:b4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Thu,
 17 Apr 2025 10:19:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 10:19:26 +0000
Received: from [10.136.47.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 05:19:21 -0500
Message-ID: <ce1ae384-ab88-4de5-af14-9479394b9182@amd.com>
Date: Thu, 17 Apr 2025 15:49:18 +0530
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
 <d4c11455-f28f-4052-9042-5d2c2ed9329d@amd.com>
 <f14bf894-0c95-4bcf-8a7c-25dfa7ebe76d@oracle.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <f14bf894-0c95-4bcf-8a7c-25dfa7ebe76d@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|SA1PR12MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd2ab4f-e319-4e14-11b5-08dd7d9954d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|7416014|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEVLQUpURGwrWkoxaHFFdFBCR3RoU1p2L0NMQWl1bHhsSjhJZzVQV00zYnZ4?=
 =?utf-8?B?WWVuS0VZTG4ySjNoYW95QlloWHhkb1ZHa1FmVmVVV21YeUtWb2s1SXVSUjg0?=
 =?utf-8?B?OTcxd3BMV1pYQkRuNjBhbHM1dHFPN08wR2VpQ2w3dTlFSFk0dXgrUWN3a2tV?=
 =?utf-8?B?Y2t4NU8xWC82ZmtxOHZ4ZjBFZzV6bmZtaGE2VGVjMC9qcHJ4S1oyeDVsN2dT?=
 =?utf-8?B?eU93QUJNdktneDdtYU5jZmtaYkxOVGM3dzVrU0ZMbExJZVVUbS9wRXR2eEhY?=
 =?utf-8?B?U2l6UTdpZzdCNmhvNUgxdjhBcmJnd2hkMWJ1Y1pNdTFSTUowajFoR0MyamZl?=
 =?utf-8?B?US9Jakg4ZU5wZ0t2NXdaVEMvZHFGUllFL29zSzFPWnM4RHVoK0FWQUh2ZVcz?=
 =?utf-8?B?ZWdKME9VNFJyMVY1TnJ4M1ZBazZCdjQ0QVNrU0tZd0YzT3Fua0Vpdkx2WWNu?=
 =?utf-8?B?ZnBrNjFYYzJ4VHBQVGk0MXBTc1lIa2E4a3VHOHFNUXhRUlJFaXdFaXFXb1dL?=
 =?utf-8?B?dzYzNTdjbWcyWm9PMHN3UHI0S1ZEWXVXQWlCZVNmL1ZjYndpa3ROdVVUM3Bm?=
 =?utf-8?B?ekxoZHlLck5UYXFlVXd6UlYrSDhCb2hDTlk4cHl5VFFub1FmMlJKV1VtMEhV?=
 =?utf-8?B?OUg4V1R1eWxuT2puUjAxd3NFMlVFVVM4M3REZlZLQ1NMdURUUCsrMEdxNmNy?=
 =?utf-8?B?NkNDamtXYU53NW1jdTFubWpySENuUzgvL1kxSW9WcHpIV29IbjBRZGxNaHcz?=
 =?utf-8?B?bk5oWXhqUVdQUGNwSllPVWVHVWNtcndkcHpKRUNnMk9SY3JGREZGUkZESTR3?=
 =?utf-8?B?by9CQ1JreUtJZFVVYlZDVWtmZjB2NmROZThKTzE2MWF6ZEY3ZTRpY2ZkVjR2?=
 =?utf-8?B?UVVNUWpRNEZteEZBOTNvOWlHTWRWa2xsN2xKcjRyMlBOWWM0QjVnb1V0Mzhs?=
 =?utf-8?B?dlpNZVU0RGRBMXhtTTJUWGVmVlBEOEZ5UEMvdkZpQjVlbGRxVEgwcFpjSkkv?=
 =?utf-8?B?bFFSaWxIbFp3bjdRSGxPVG5iWmZTTW5xZkJReHhHKzZFWG5mMExMZzdtZEhv?=
 =?utf-8?B?Z0hORHRDbmpnbHU0T1NoQURxdG1QK1diTGZLYzExeExma1RKak11b21aWlha?=
 =?utf-8?B?WVVhV2haOXUvWkZSNWFGYWhTTDVMS3RkUFhkL09TS1lEYk9TNDl1bXlSWHlx?=
 =?utf-8?B?WDh4dDFVZnQzbXdidXZFcmNYNitXcU1oWGY4NkxhOUJhREE0NDQ5aGZwMWNm?=
 =?utf-8?B?SW1tenhsYlBsbWtuTzVJcjdaRnlNZ01BM2NPOEpiakVlU0VqTjZZTFRkMGNz?=
 =?utf-8?B?UVQyTjFOc0ZJaWgrNnhGRElkcTZ6ZWNzcTVobzJNNFRucFNnN3pQaEFuU1F0?=
 =?utf-8?B?MG1MMlRuMG5sYUl3QWdtOEVIb3Zmb3BXOC9UL1g4VkNYWGxPY3A5K3NpZVB6?=
 =?utf-8?B?ZHdaSUlDZG16YlFSdVc2SVZyUUF6TGd2ZDN0Q3B5RUI3SXBQaHdGUlZwN2pM?=
 =?utf-8?B?ZmtVa0pRSlF3WXk4S3RPNlp6WjdoYWpTZEhlMExxcjdqOXJBSlZUbHIwR2R2?=
 =?utf-8?B?UXFFU2NxTzdualhJQngyVk5ONTlMWHVXWUhzVk5MZHY1aEl4MmtQTld6M0V2?=
 =?utf-8?B?M2I0UXFubUtFUWM4MmRhMmxqRnlVZVVsR3VOSm5TZ1FzMkR1UWhHSGRQWjRG?=
 =?utf-8?B?elltK2ZGUWhBeTJuYmxVYmZnOXJUNWEwWEJzY0hwU3NadWZ5cGprSFRXSUYw?=
 =?utf-8?B?c245WStLcFNVeSt6UXJTZGY2VWVxaU9XTm8zSnhWb0NTd0I1U3UxWjZHUlBE?=
 =?utf-8?B?OFBlZmRBZk96Q0gzTXltYUtQNTEvb0w0aHNkdW10N0dlUUZjQnhvU2pqOURZ?=
 =?utf-8?B?OER0Q09PUWh2QkdVMk5EajdIRENoT1JOeVo0T1lVOC9pczVuYVBjOEVaRG9P?=
 =?utf-8?B?S2djeFIrMUtWZE44U2J3STg1RWw4aXdQdUl1Z3VVWEZjcWdQZVY1YjR6dHFY?=
 =?utf-8?B?akVhQ3ZiTEJRQ1Q5SlM0K1NRTGFQZjNtSi81WUVuYlovaVNyUTcyeU1XQWk0?=
 =?utf-8?B?V2hQUXNpR1c3T29YbmFPSng1eHR3ayt3cmh0QT09?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 10:19:26.1659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd2ab4f-e319-4e14-11b5-08dd7d9954d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971
Received-SPF: permerror client-ip=2a01:111:f403:2412::626;
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



On 4/17/2025 3:47 AM, Alejandro Jimenez wrote:
> 
> 
> On 4/16/25 8:14 AM, Sairaj Kodilkar wrote:
> 
>>> +
>>> +    /* DMA address translation support */
>>> +    IOMMUNotifierFlag notifier_flags;
>>> +    /* entry in list of Address spaces with registered notifiers */
>>> +    QLIST_ENTRY(AMDVIAddressSpace) next;
>>> +    /* DMA address translation active */
>>> +    bool addr_translation;
>>
>> I dont see any use of addr_translation in current patch.
>> maybe define it when you are really need this flag ?
> 
> ACK. I can move it to a later patch. My rationale was that this patch is 
> adding all the new structure members that will be needed, but it makes 
> sense to split it.
> 
> 
>>>       return 0;
>>>   }
>>> @@ -1700,6 +1721,7 @@ static void amdvi_sysbus_realize(DeviceState 
>>> *dev, Error **errp)
>>>   static const Property amdvi_properties[] = {
>>>       DEFINE_PROP_BOOL("xtsup", AMDVIState, xtsup, false),
>>> +    DEFINE_PROP_BOOL("dma-remap", AMDVIState, dma_remap, false),
>>>   };
>>
>> Please add a description in commit message for this flag
> 
> Will change in next revision.
> 
>>
>>>   static const VMStateDescription vmstate_amdvi_sysbus = {
>>> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
>>> index 28125130c6fc..e12ecade4baa 100644
>>> --- a/hw/i386/amd_iommu.h
>>> +++ b/hw/i386/amd_iommu.h
>>> @@ -365,12 +365,18 @@ struct AMDVIState {
>>>       /* for each served device */
>>>       AMDVIAddressSpace **address_spaces[PCI_BUS_MAX];
>>> +    /* list of address spaces with registered notifiers */
>>> +    QLIST_HEAD(, AMDVIAddressSpace) amdvi_as_with_notifiers;
>>> +
>>>       /* IOTLB */
>>>       GHashTable *iotlb;
>>>       /* Interrupt remapping */
>>>       bool ga_enabled;
>>>       bool xtsup;
>>> +
>>> +    /* DMA address translation */
>>> +    bool dma_remap;
>>
>> I think you should use this flag in the remapping path as well.
>> I am aware that you are using it later in this series to switch the
>> address space, but current patch will make things inconsistent for
>> emulated and vfio devices (possibly breaking the bisect).
> 
> The change in behavior happens only if the user explicitly sets dma- 
> remap=on property in the command line, which is why I made it off by 
> default.
> 
> To eliminate the possibility of using dma-remap=on before all the 
> infrastructure to support it is in place, I will move this patch and 
> [5/18] to the end of the series. Does that address your concern?
> 

Yep, That works for me. Its always better to introduce flags at the end
of the series when we have the infrastructure ready !

>>
>> Also newer AMD IVRS format provides a HATDis bit (Table 96 in IOMMU
>> Specs [1]), informing the guest kernel that V1 page table is disabled in
>> the IOMMU. 
> 
> Sounds like this mechanism could have been used until now to prevent the 
> scenario where we can have the guest request DMA remapping and the 
> vIOMMU doesn't have the capability. Seems moot now that we are actually 
> adding the capability.
> 
> 
> Its good idea to set this bit in IVRS when dma_remap=false.
>> This way a "HATDis bit aware" guest can enable iommu.passthrough.
> 
> I'd need to research how to implement this, but isn't this enhancement 
> better added in separate series, since it also requires a companion

Yeah, I agree. Let's have it as a separate series.

> Linux change? I don't recall the Linux driver being "HATDis aware" (or 
> even HATS aware for that matter), but perhaps I am mistaken...
> 

As of now, we don't have the "HATDis aware" guest. Its a fairly new 
flag, we are working on adding support for this feature.

> 
>>
>> Also, is it a good idea to have default value for dma_remap=false ?
>> Consider the guest which is not aware of HATDis bit. Things will break 
>> if such guest boots with iommu.passthrough=0 (recreating the pt=on
>> scenario).
> 
> That is not new, that is the current behavior that this series is trying 
> to fix by adding the missing functionality.
> 
> As far as the default value for dma-remap property, I think it must be 
> set to 0/false (i.e. current behavior unchanged) until we deem the DMA 
> remapping feature stable enough to be made available for guests.
> On that topic, maybe it should be an experimental feature for now i.e. 
> "x-dma-remap".
> 
> 

But the current behaviour for the emulated (virtio devices) is to have 
dma-remapping on by default... I still think its better to have this 
flag = on.
Honestly, I am confused here...

Regards
Sairaj Kodilkar

>> [1] https://www.amd.com/content/dam/amd/en/documents/processor-tech- 
>> docs/specifications/48882_IOMMU.pdf
>>
>> Regards
>> Sairaj Kodilkar
>>
>> PS: Sorry If I missed something here, I haven't progressed much in the 
>> series.
> 
> No problem at all, the feedback is appreciated.
> 
> Thank you,
> Alejandro
> 
> 
>>
>>>   };
>>>   uint64_t amdvi_extended_feature_register(AMDVIState *s);
>>
> 


