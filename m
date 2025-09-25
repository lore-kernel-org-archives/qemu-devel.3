Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50485CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 07:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1gaL-0002SG-On; Thu, 25 Sep 2025 03:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1v1gaD-0002Qn-Ov
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 03:40:06 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1v1gZk-0000Pz-RT
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 03:39:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcV0YGLawRpBwpErUIy/5xd3ZXQYWAws8MPWe/+Rw/22YQFV4if4ghCTl9pRmzZNac3d7bqOSTaq3fP8pkf9hW764G0YQEOERdzC4nFLfYq7eyMtWovgbu+ca5X2Jnk/5lAFzRW3Z3whjQWYciGIwf1ZHY9l9s7tXACkaxpqI85115OylICEW6fFtqBEdD9ERKWcUUIHwonY0KTLLu6qME2pIRPBEhCvJtSXaAnTieHmS9UigBGjK3wTc82cR/6bx/iXY4E8PaLjjhUqfaGaWypRozb3Mu4NnECvJ8aYoHXcV7cpCDtb10dXDIX/31XDKVH3kWLLoc0jf9kv0RCC8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXobpMPvSwrGJUMH9XwnXRtp0YG65ZKvP6Wpe8vcmmo=;
 b=V4hTO6iFV2G8X+TO9EEeKC1DyVeHq5t+2Ve6zAOcoZG+LUG6IKOvmdZ3xwd7t3KLgZqWI6EpAbOJ5idXYo/UXnmV71+EvvX072u9fp+eKySlVTpwgXT3JlOfIDRGldGEa/q/GcrCXRZaEQAVBTz9CL2Gb3U8GfD5yQEZWbFCYFuGf473TbXop+YIqUX29n5UI8wkx+d1ucUA8UsfTlM0iYD5VHqwqm0O+pfkUmWgjePErkg6ChDbk8D/UhKM8QPwdEDcyMeBgRFxZ/66ocrNehs3KFA9TrEHyz40b9k7skIhCexpbnHydJcrN72RwYGSmFohf6BkG0ztlFC8ST3L0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXobpMPvSwrGJUMH9XwnXRtp0YG65ZKvP6Wpe8vcmmo=;
 b=cmfRcIpxHHVVjgfXggQJxht7Eip5W/o4ywg6l35fbG/D2rfaViHT1RnDpG7FZ4r26cfONQJwfsh6Odpz8MWnhNrwI8ox9zFWn6d8CbVk1F/3MXQefsqdDhotJjNBP0Wykgh9upMsJy/hX1FH3vjKlJDfTY20kLVy1NfE+iI70I0=
Received: from SJ0PR03CA0191.namprd03.prod.outlook.com (2603:10b6:a03:2ef::16)
 by DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.21; Thu, 25 Sep
 2025 07:39:22 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::a5) by SJ0PR03CA0191.outlook.office365.com
 (2603:10b6:a03:2ef::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Thu,
 25 Sep 2025 07:39:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 07:39:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 25 Sep
 2025 00:39:21 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Sep
 2025 02:39:21 -0500
Received: from [10.65.97.37] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 25 Sep 2025 00:39:19 -0700
Message-ID: <d5a087bb-5ed9-4463-9674-7c1748852198@amd.com>
Date: Thu, 25 Sep 2025 15:39:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] numa: add 'spm' option for special purpose memory
To: David Hildenbrand <david@redhat.com>, <qemu-devel@nongnu.org>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, Igor Mammedov
 <imammedo@redhat.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250924103324.2074819-1-FangSheng.Huang@amd.com>
 <fa625f3d-6493-4213-b317-23ab1e16ac37@redhat.com>
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
In-Reply-To: <fa625f3d-6493-4213-b317-23ab1e16ac37@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|DS7PR12MB9474:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e20257d-1da3-4657-4e38-08ddfc06a51f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UExOcGdoeTBhaFVvVXk4RWdMYjFZRVFZRXh6OE03MzB5VUUyRFhyMTJtSmZZ?=
 =?utf-8?B?T2NZQzhodmJvdktBcExzQ3NpQmN2MDUvN3YwQXdQSzVKZ1Rjckk2YUtCNWtO?=
 =?utf-8?B?STBraTRZMTVpTG5RcDNjK2QyWnoyNzVrczJQclhrTGFEU2ZEdXBWbm90SDlO?=
 =?utf-8?B?S2EzQlpLK2RLd1JPQmdPRVRPTis0WTV3d1dhUFkzbDA1UkxPYjJ2dU5RcHp3?=
 =?utf-8?B?Yk9PdGVMUHMwYXRnOFlSaVJWNjNiaFVFWHNudkFENnB1WG9iTk9qZDAza3VS?=
 =?utf-8?B?RUE3QUZSNEdtTnF5MlA1STJJbFRqRFVYZ3ZOMlU1YjdwRG5zcGR2bStmZGo5?=
 =?utf-8?B?Qmo1ZlRzVlNFWERNSzlabzRMejZmN3lCQWZwTlMyclJiY2V1MmJtZUdoa2ha?=
 =?utf-8?B?ampyd1FQa0p0QmxrcFZ3TnRCYWpZMm4zb1FUUUJpWUlYL3ptR09VZ1M5Z0lO?=
 =?utf-8?B?dmUrd043Yks0RjJLTWVQaVM5TzlGQU9VMVFjaE1CZUh2OWZQTTE4OU05Nmhl?=
 =?utf-8?B?Nlk3bEtTb1pBVUdKTjMrWGFjUWMxZCtMMWVLa090TE12UE5uZFlMUDJsbWI0?=
 =?utf-8?B?ZVpCa3NzRFd6UkZCYnpheUptWEtOa01pMVl3VVlRdHdkOFFIQWxoQ0ZXaUh2?=
 =?utf-8?B?cFhiNStualFmcWdleDhyZ1ozK1VxcjZ3dVk2VCtoTHNpdTR2ZE4zemJzZ2h6?=
 =?utf-8?B?S29xbDVVMGJzNUNYQXBycjA5aEozd1FTUytxYTVUa3FML0xMUFc5aHBqQ3Nz?=
 =?utf-8?B?VXhuSlc2Wk9CeUkxVTIySjhGWXczb2hXOXhKNUhhVXRPMTRva2lQSzZ2YnBw?=
 =?utf-8?B?S1Y5eUNDT2N0QnJNUk11ZThyek9mQkRPQzNodE95SzYvRHR4STJlc01ORXJm?=
 =?utf-8?B?a09NWGFTNDlOa3NIbkQ1VEEvVko4dmJJOWpKcTRjV0FUMlEwUmRVV0t3Sk9l?=
 =?utf-8?B?eTN2M3FMc0MwRWJtajArejVNVjZZdWorUGltKzU4VE5Xekx3Zzc3U2tkTGFs?=
 =?utf-8?B?cEs0YlE0VVV5SSszdmVCVjRTaWlVS0JGbjduOHlDUUdGU2ZxTzRGWmdRQVhU?=
 =?utf-8?B?R3BOSHp0Lzc4cE9NaEcwcFduNmNjV0Rid2VLbEt3MjAxQnpsRmZqOVZhRU9P?=
 =?utf-8?B?MmtzbHR1Y294cFNka0pWQ3p6dGdjYkRaeDEzWkkxRERSR3ZoOWJRK0cyMElj?=
 =?utf-8?B?bmViK3BlcWt1bUx2SlB3N1dqc3J6c2EreWp1RXI3S2hCSnVXVmp6eFpuNytL?=
 =?utf-8?B?bURRR0NkOTZia1FCUVBvUEJzc1A1T2N2U3pWdi8wZlJkekdHSEpmSDV4ajhK?=
 =?utf-8?B?SCtLYkplTnZaYUk5cHJpRWNiSklvZ1NLOEtvWTV6N09PQmxOa055ZnBBdUli?=
 =?utf-8?B?VEtpT1N1UldmNGJjbE1Ueit3a1hmOXZURS9neUJVRW8zOWUxbHN6VWsyK1RJ?=
 =?utf-8?B?KzdreTA3MHorQVhTbnhlZWJFcVBjS2ZobG9Xc2lvdTlndW5iU1NlMnlqMDl4?=
 =?utf-8?B?dnBGeFFPL1ZadjFtUE82TFJjTTkxTllsU3BVRUdNMytreU5QdmEwN3ZBaFhE?=
 =?utf-8?B?RVYySGdoOExpd1NQM0lNQ1M2TzBRbll4QXZnaEpLYURweWExQ2dMY2tSelp0?=
 =?utf-8?B?bFZDaVN0WU9BZVdyVjVnS002d2F4Z042Q1FhR1luVXlsWUdGdTFITnFjNVIr?=
 =?utf-8?B?UThYZEpXOHhaZXpWVnRFVm1YZHBtUmZWV1FLLysydEVUVnJ6NmNGWFo5RU1u?=
 =?utf-8?B?U3RjSTh4RklQRFg5MitSMGdRRTZ2T0tCaTE1eGdGQ2hjMFZTMmFtM0g1RFhO?=
 =?utf-8?B?SzFodlFxNTgvMlJxR1Fpd2RVdDVoaFhYT1ZCWUxKY1Q3ZFhodHpRaHc1Q01H?=
 =?utf-8?B?NlZIS09pWUhoVHU1UDdteDJEd3p5UDZyU0VUUUhZaEkyYVZlbHNvaFNJaTE1?=
 =?utf-8?B?bCtabE1QbXczNGRCSlcrMW1uOTBteE9WV0UwTUhiQW84eEdENW9uNFFMODAw?=
 =?utf-8?B?ZVN2eUJrNE5mb3hsK2s4Qmc1SE9qYUlDL0tPMEZiMXQzcHRubEFrcDFXSEE1?=
 =?utf-8?B?VjN1LzhoYjNMOE0yNHhxSHROcTJ3QithMWEzTnMycTRIZThZMFg3ZEdqTENk?=
 =?utf-8?Q?8Zfk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 07:39:22.5438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e20257d-1da3-4657-4e38-08ddfc06a51f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9474
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=FangSheng.Huang@amd.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


Hi David,

Thank you for the quick response and for bringing Igor and Jonathan into 
the discussion!

On 9/25/2025 1:03 AM, David Hildenbrand wrote:
> On 24.09.25 12:33, fanhuang wrote:
>> Hi David,
> 
> Hi!
> 
> CCing Igor and Jonathan.
> 
>>
>> I hope this email finds you well. It's been several months since 
>> Zhigang last discussion about the Special Purpose Memory (SPM) 
>> implementation in QEMU with you, and I wanted to provide some 
>> background context before presenting the new patch based on your 
>> valuable suggestions.
>>
>> Previous Discussion Summary
>> ===========================
>> Back in December 2024, we had an extensive discussion regarding my 
>> original patch that added the `hmem` option to `memory-backend-file`. 
>> During that conversation, you raised several important concerns about 
>> the design approach:
>>
>> Original Approach (December 2024)
>> ----------------------------------
>> - Zhigang's patch: Added `hmem=on` option to `memory-backend-file`
>> - QEMU cmdline example:
>>    -object memory-backend-file,size=16G,id=m1,mem-path=/dev/ 
>> dax0.0,prealloc=on,align=1G,hmem=on
>>    -numa node,nodeid=1,memdev=m1
>>
>> Your Concerns and Suggestions
>> -----------------------------
>> You correctly identified some issues with the original approach:
>> - Configuration Safety: Users could create problematic configurations 
>> like:
>>     -object memory-backend-file,size=16G,id=unused,mem- 
>> path=whatever,hmem=on
>>
>> - Your Recommendation: You proposed a cleaner approach using NUMA node 
>> configuration:
>>     -numa node,nodeid=1,memdev=m1,spm=on
> 
> Oh my, I don't remember all the details from that discussion :)
> 
> I assume that any memory devices (DIMM/NVDIMM/virtio-mem) we would
> cold/hotplug to such a NUMA node would not be indicated as spm, correct?
>
Yes, that's absolutely correct. The `spm=on` option only affects the boot
memory that is assigned to the NUMA node through the `memdev=` parameter.
>>
>> Project Context
>> ===============
>> To refresh your memory on the use case:
>> - Objective: Pass `EFI_MEMORY_SP` (Special Purpose Memory) type memory 
>> from host to QEMU virtual machine
>> - Application: Memory reserved for specific PCI devices (e.g., VFIO- 
>> PCI devices)
>> - Guest Behavior: The SPM memory should be recognized by the guest OS 
>> and claimed by hmem-dax driver
>>
>> Complete QEMU Configuration Example:
>> -object memory-backend-ram,size=8G,id=m0
>> -object memory-backend-file,size=16G,id=m1,mem-path=/dev/ 
>> dax0.0,prealloc=on,align=1G
>> -numa node,nodeid=0,memdev=m0
>> -numa node,nodeid=1,memdev=m1,spm=on  # <-- New approach based on your 
>> suggestion
> 
> The only alternative I could think of is gluing it to a memory device. 
> For example,
> have something like:
> 
> -numa node,nodeid=0,memdev=m0 \
> -numa node,nodeid=1 \
> -device pc-dimm,id=sp0,memdev=m1,sp=true
> 
> But we would not want (and cannot easily) use DIMMs for that purpose.
> 
>>
>> New Patch Implementation
>> ========================
>> Following your recommendations, I have completely redesigned the 
>> implementation:
>>
>> Key Changes:
>> 1. Removed `hmem` option from `memory-backend-file`
>> 2. Added `spm` (special-purpose) option to NUMA node configuration
> 
> That definitely sounds better to me: essentially "spm" would say: the 
> boot memory assigned to this
> node (through memdev=) will be indicated as EFI_MEMORY_SP.
> 
Thanks, that's exactly how the implementation works. The `spm=on` option
ensures that when QEMU builds the EFI memory map, the memory region
corresponding to the specified `memdev` will be marked with the
EFI_MEMORY_SP attribute.>>
>> I would appreciate your review of the new patch implementation. The 
>> design now follows your suggested approach of using NUMA node 
>> configuration rather than memory backend options, which should resolve 
>> the safety and scope issues we discussed.
>> Thank you for your time and valuable guidance on this implementation.
>>
>> Please note that I'm located in UTC+8 timezone, so there might be some 
>> delay in my responses to your emails due to the time difference. I 
>> appreciate your patience and understanding.
> 
> No worries :)
> 


