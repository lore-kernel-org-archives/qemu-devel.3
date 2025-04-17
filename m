Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA167C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 10:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5MNx-0004Cg-Hp; Thu, 17 Apr 2025 06:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u5MNu-00049U-Jc
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:22:18 -0400
Received: from mail-dm3nam02on20606.outbound.protection.outlook.com
 ([2a01:111:f403:2405::606]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u5MNp-0006P6-27
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:22:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rr/Z1OGlUA07UAAoqOSPrTCqw0gzWk+ttZH02Vv8vIB+I6+SJbNwYESVuxppoxO/8tOODVuOp+ituleiUgQbbmB6ATAikJtXfX2FAjYRTtYo8CSDhd3QpYh+dNC/p/gWaVvhWyDn5YgDhfqiDkBXcxP2wqxHMQe9P8i2IDxhKAgqre5Bpba+xIVhRRO25DytXrXJhYHk8NAD7AAcndkk7xmUcy3QjJ90B5ab5rfs6tf7Z+hwCSPpW/tUkznO5/LbcqW3lkxxF4SmFxf1MbuFeO0FWT7UEWAmu1oG8G4xnyvz4im0yvKSQpswBiljHh88pY6QOpD5IPL/a+2XHYqoPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIZzYanvuAKmjS4oWdct4MQFvFFfFdW/0y77RmuChAw=;
 b=s7YdgIImPX0/+T0DzuqO2xTTAGbVjWzvjdp97C6hkhMAR8jjM97UTR6iqwbdNVYY1VsAB82/PzhCrROHKbU/Z72Bg+K1qiuH+nlLWXjbLr3xIZE5mg1ai4BqNO5fLTMw06wJ5G7rddu0pQoCUFauYZpMylOL6QLD3t8mgRantXCj8kI2aryogIcDuMQDqzNN6KUvbkfeeJ2OMo4vMNQCHAbIRk2I+jrTAcgusp2/decYAWnG4tj1/4zeZ1Nr9iC4Zd8DWR/G7fHCmV8PBSIkSKuzp0YOFNYJ5nx9BjXIOwP0WtSSICoxRr9W8M1QAzG8h91D3BpJVomwhPIbeZfiEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIZzYanvuAKmjS4oWdct4MQFvFFfFdW/0y77RmuChAw=;
 b=kVZFRJRFJkRBRFFPFYbfbWMatJUF0yrpa7Y9sLv5d4Z7FU2C2HC4KdqSwwEV6G6lrPevB3NYEJyLrGQwYhWM4UKOynchmzMS3p1sbCMISEZ9hCpjK/BGM1bx8TABXSlIkmn/72zRpMa1QsjzR+GgKwFbY4TY7VYQH09p4ctV6ek=
Received: from MW4P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::21)
 by MW4PR12MB7192.namprd12.prod.outlook.com (2603:10b6:303:22a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Thu, 17 Apr
 2025 10:22:06 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::5e) by MW4P221CA0016.outlook.office365.com
 (2603:10b6:303:8b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Thu,
 17 Apr 2025 10:22:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 10:22:06 +0000
Received: from [10.136.47.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 05:22:00 -0500
Message-ID: <610d0e59-4ca2-45a4-b22f-dbe0e9098200@amd.com>
Date: Thu, 17 Apr 2025 15:51:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/i386/amd_iommu: Fix device setup failure when PT
 is on.
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
CC: <suravee.suthikulpanit@amd.com>, <joao.m.martins@oracle.com>,
 <philmd@linaro.org>, <vasant.hegde@amd.com>
References: <20250410064447.29583-1-sarunkod@amd.com>
 <20250410064447.29583-2-sarunkod@amd.com>
 <914314b3-611d-4da3-9050-3c8c1b881e40@oracle.com>
 <63acddc3-bc7b-47e4-9e7c-66bdc40f23d2@amd.com>
 <c0a214d8-f9d4-4fa3-8262-88cdd4372878@oracle.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <c0a214d8-f9d4-4fa3-8262-88cdd4372878@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|MW4PR12MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: 760b59a8-b830-4ea1-2ace-08dd7d99b43d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWhiaHlsR1NmblkyZDdtYmJITzBtWWtFdDRBK2h3aVQwK01Fa2FmTmYxdXVU?=
 =?utf-8?B?ckFBeUVacm5taW4xTkJRNFhlRisvUEJkSUtkQlBzQXAycnArb1ZYRTJONFdv?=
 =?utf-8?B?cGxUdW4xQW4yeVNOTnYzdHd5anVzK2Y5WUlnM0RISW44a3pCNUxQMnpMWERX?=
 =?utf-8?B?allMMjJMaERyQmF6Q0kvZlN5Y3l1Vy9yTEtxeU9XL2VvYm5lWFFpN1JPa1RC?=
 =?utf-8?B?VE40Tk9vRzBySlgwRmFQWFZ5Y2FGWmVEVXZ1TkZWNm5vcnFIM2lXTlFMcmlC?=
 =?utf-8?B?ZFEvaDNaY1VROXJVcTd1MDZ6dHBzYWlLVDE0RGU1clUzZDFnSmkzeG5VWFlC?=
 =?utf-8?B?T3UvNUhzMnRiaThQSTFkMWphN1J4cHVUN2wwbmFVYVJTZUEzRTdrMnZRdW44?=
 =?utf-8?B?M0VlNXZqMkVXWjU5aVc0TjVuMk4wK3dNMk1hcDBkZERCTVpLTDNXTlc0bHUx?=
 =?utf-8?B?NDg5c2VZTFc5eTV3ZUxkL0pxbGhvSkRkdUl6UVhXSWRrRkg1NStrS0Rpcng5?=
 =?utf-8?B?OGdkNWthbHY3eVNDcGtMbEF5NjdQU1N3VTRzSzBZbEYyUHRNS1ZnVUl5Z0RK?=
 =?utf-8?B?S1krTXFxUzEvQzgrc0dOdktpT2UwUS9mbUQ4UFB2eFI1VVRpWFlzNmpHSE1r?=
 =?utf-8?B?NG0zWm1qM3FNM0lkdlZyQ2hJRnQvMEFXY1BPVCs1d2Y1Qlc1ZnphVWxKTWxz?=
 =?utf-8?B?Q0p2WXJBei9YT21uOW0wYm5rbU11bnhIOVQzSTIvKzdOS0ZNOHJaSTJmT3ls?=
 =?utf-8?B?NHJNQ3hwZkN2N3d2NlBwOUJVOUZSYWtBZGlzWGE4WkI0LzNWVGUrSWVLbmhk?=
 =?utf-8?B?QzlGWFR1VE9yRDNCVHpLMTZWdUREQWN5TEtWRjlZUjhiZERrekJMaCtnd1Jh?=
 =?utf-8?B?aWJQT0dJTlA2QnNvNFprUndwWThSM0dsZnYwbDFpVE52YmJ0cmdvK2J6SXhj?=
 =?utf-8?B?b0t5ZWdrVUlXRTZXSWJ5bXJDUEhZTnI5Z0l0QjF6Q0toc2lYUHd6d1dRQVNn?=
 =?utf-8?B?bVBralZGazJJVmpuU2VsVkNIU3RhWEpsVmlDVlk5YVRZdDk0cndJVmpiNHJm?=
 =?utf-8?B?Y0ppT2dlMjBRRnh0bW45dmpOMHF6NFRPZTVrZkFHQ2RkbldWRVBxUitpd2RE?=
 =?utf-8?B?NFNVZTIyaDNwSEhpSkR4V0N5WHB6SW93RkY1T1JSYjViWVdzbFpPZ3FFT2Ev?=
 =?utf-8?B?bkpWTXY1N3Npd1U4SHJVWHB2akpDbnBTQjF3Y2pnWFdxOXBLN211a0t6V2Vx?=
 =?utf-8?B?RUI2ZXZEQVkweDlVQmRoODJwV3NqZ2pEd0xuZmNudmhNdEwrd1pvbFJNVHlR?=
 =?utf-8?B?UEFvZXNxbW1RUUhNMWJRa0pHb3ZDSHhubll3YmcrZHkrMjZYa0VoS2VCS1I0?=
 =?utf-8?B?OEU4ZEdwWmx4Y01EbzdBMlNXRGgybXZiV3lJNm9vRWZWVzNzbldXenJVZTRN?=
 =?utf-8?B?VjFGWkV2TUljQ0poZEc3ZTQ0MWhCU3hESThJaERLVDA4TmljMlFjbWRMcmZP?=
 =?utf-8?B?V2NwUnp4Ly9xYlBwaHlSWStMZnE5RU0xbUhTWUNvWk9LVTBEODR2Wm10aW45?=
 =?utf-8?B?SnFsRGNBaDd3ck94WDArOG1rczRyMTRPMkZTYUh6S1piVTVocnVGeGM1ckh1?=
 =?utf-8?B?dHdETkxqcC9vSEhnZlhuWVlIeXU3bFhlMDZ3T2tQWUF0THA3VUYva2YrQXpk?=
 =?utf-8?B?aGZRZi9ZZFQ3MVQxWUJqWHFUWWpJL3dBdTJsTjRENHFkQ0JpN0lkVng5NDRS?=
 =?utf-8?B?cURrOGZQOThpdmRWbUNLNS9Cakg3Z0ozc3lVcW11bmFsOTh6ZElub2Y0Tit1?=
 =?utf-8?B?TG9pUUQrSU5CTktITkc2a2U0UFlDaDYrdGJGQ0xNaksvKzVVQkVnMmJPZ2h4?=
 =?utf-8?B?bjF6YlVkeFJaeFpteHM3d3RaeS9PdG9nZi9pbWY5NTBWaGE0NUdwUkszNmFq?=
 =?utf-8?B?OG9TYytTRENHL0NZYzJFQ1ZYVG9zcnB0TDYza1BnWlh6b2NhbGpzT09pc3pT?=
 =?utf-8?B?V1FoeUNxcW5QOVlUdTZGNFN6SFNLaHd2NndGdVl5M1Z3dXBwQ1VsY2dPcmVs?=
 =?utf-8?B?MEY1OERSdWUzTW1MNVNHUHBLU3k5VnVIS3BtZz09?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(13003099007)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 10:22:06.2448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 760b59a8-b830-4ea1-2ace-08dd7d99b43d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7192
Received-SPF: permerror client-ip=2a01:111:f403:2405::606;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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



On 4/15/2025 11:58 PM, Alejandro Jimenez wrote:
> 
> 
> On 4/15/25 2:38 AM, Sairaj Kodilkar wrote:
>>
>>
>> Hi Alejandro,
>>
>> On 4/15/2025 1:56 AM, Alejandro Jimenez wrote:
>>
>>> Hi Sairaj,
>>>
>>> I'm conflicted by the implementation of the change, so I'd like to 
>>> make sure I fully understand...
>>>
>>> On 4/10/25 2:44 AM, Sairaj Kodilkar wrote:
> 
>>>> Fix the issue by removing pt_supported check and disabling nodma memory
>>>> region. Adding pt_supported requires additional changes and we will 
>>>> look
>>>> into it later.
>>>
>>> I see that you are trying to essentially block a guest from enabling 
>>> an IOMMU feature that is not currently supported by the vIOMMU. 
>>> Hopefully that limitation will be solved soon (shameless plug):
>>> https://lore.kernel.org/qemu-devel/20250414020253.443831-1- 
>>> alejandro.j.jimenez@oracle.com/
>>>
>>> But in the meantime, I think enabling amdvi_dev_as->iommu when DMA 
>>> remapping capability is not available is likely to cause more 
>>> confusion for anyone trying to understand the already convoluted 
>>> details of the memory region setup. 
>>
>>> To a reader of the code and the commit message, it is confusing that 
>>> to support the "NO DMA" case, the nodma memory region must be 
>>> disabled, which is the opposite of what it is meant to do.
>>>
>>
>> I dont think that I understand above statement. What do you mean by "NO
>> DMA" case here ? is it iommu.passthrough=0 ?
> 
> I meant it from the point of view of the vIOMMU configuration (since we 
> don't control what the guest can request). So in terms of vIOMMU modes 
> and corresponding Memory Regions that must be enabled to support such 
> modes, I see it as:
> 
> Passthrough(NO DMA) --> MR: iommu_nodma: enabled && iommu: disabled
> 
> DMA remap --> MR: iommu: enabled && iommu_nodma: disabled
> 
> But I recognize that view/model is probably too rigid for now, although 
> it should be the "correct state" once we support DMA remapping.
> 
>>
>> Essentially, I am trying to support the "DMA" case that is
>> iommu.passthrough=0 for the emulated devices, by reverting the 
>> changes> that introduced the regression.
> 
> I understand the goal is to make emulated devs to work in more scenarios.
> 
> Because of that view that I mention above, is why I don't think of 
> c1f46999ef506 ("amd_iommu: Add support for pass though mode") as 
> introducing a regression, but more of a prerequisite to support both PT 
> and DMA modes.
> 
>>
>> If I understand correct -->
>> The original intent of the flag (in case of Intel) is
>>
>> 1. To turn on the optimization which will use nodma region (dynamically
>>     enabling it) if guest configures the device with passthrough (pt=1)
>>     for given context entry.
> 
> This is why I said I am conflicted with the implementation. Your change 
> always disables the iommu_nodma region, where the default for Linux 
> guests is to use passthrough mode, which "normally" would result in 
> iommu_nodma being enabled. I almost suggested on my first reply that you 
> instead forced x86_iommu->pt_supported = 0 in the AMDVi code, but that 
> creates a similar type of contradiction.
> 
> In short, I understand what you are trying to do, but I think "the 
> trick" as I called it below should probably be documented.
> 

Yes, I will respin the series with better commit message. I understand
that this patch can cause the confusion.

Regards
Sairaj Kodilkar

>>
>> 2. The flag should not enable no_dma region if guest does not configure
>>     device with pt.
>>
>> Intel driver does this dynamically (for every context entry update while
>> guest is running). But for AMD this is static and does not change with
>> the DTE updates, which is causing this regression.
> 
> hopefully solved soon:
> https://lore.kernel.org/qemu-devel/20250414020253.443831-15- 
> alejandro.j.jimenez@oracle.com/
> 
> Alejandro
> 
>>
>>> To explain the "trick": this change is always enabling amdvi_dev_as- 
>>>  >iommu, which is explicitly created as an IOMMU memory region (i.e. 
>>> a memory region with mr->is_iommu == true), and it is meant to 
>>> support DMA remapping. It is relying on the "side effect" that VFIO 
>>> will try to register notifiers for memory regions that are an 
>>> "IOMMU" (i.e. pass the check in memory_region_is_iommu()), and later 
>>> fail when trying to register the notifier.
>>>
>>> If this change is merged, I think you should at least include the 
>>> explanation above in the commit message, since it is not obvious to 
>>> me at first reading. That being said, in my opinion, this approach 
>>> adds potential confusion that is not worth the trouble, since most 
>>> guests will not be using AMD vIOMMU at this point. And if they are, 
>>> they would also have to be specifically requesting to enable DMA 
>>> translation to hit the problem. Unfortunately, guests will always 
>>> have the ability of specifying an invalid configuration if they try 
>>> really hard (or not hard at all in this case).
>>>
>>
>> Yep, I should have explained it in details. Sorry about the confusion
>> will keep in mind while sending future patches.
>>
>> Regards
>> Sairaj
>>
>>> Alejandro
> 
> 


