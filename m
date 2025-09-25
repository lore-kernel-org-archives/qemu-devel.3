Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA08CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1jyA-0007wz-A8; Thu, 25 Sep 2025 07:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1v1jy8-0007wr-Bc
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:17:00 -0400
Received: from mail-westusazon11012046.outbound.protection.outlook.com
 ([52.101.43.46] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1v1jy0-0005cx-NI
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:16:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPGNCUZ5gkZNWyAH/nk7r7XKnhJPDi3o4IFO5yck2WAEcV5z9ovASiXYi1BL+7AZcNtyf/kwtY23fh2m7X/XAqVWG1lOBPHISuqNkkdSC6AMrCu0bHfbiUt/uCfeAw3WA9txwJxgFqJwUbSbKsPPz27vyyQIB9kBFDfKG+wt5egXqk8dbnNu9wtp4nDur35vQPrME4ZqXwS75otmfxdTLBE5wSxNRobtrGk8mD2fm0VVK1kXVLH5J4zqxKPgV6DhLWCDOfyWwNT+aCpCH89SFam+Gsbi5lcR5JEaH5UGXZ0mKtFgpWq6Gug7cYwsC/jC5ocM2DyI82ayZXdJOc1qgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxETBem5eo/dqqh+Z0La9l0ieEPO9jfkDp48WjtVAEg=;
 b=M3imCDpFLgX/dPbNNm6BSio9fTx6CPCm2y5WEEeyUA+PtT10/ABUmb90+PIfcTNxvI8zT5W3pJaet6U0BwxL441kkFx7AGPI1M4VSPWSZjQmuIL1szgX9HXS2tnB3TNfBn6AA5OVkNZnnW76USXFNHUXZQy4FH6mIpBdy/dBdz3UBCWJzB+GPc9pGHUcNp+XLv07w7+qeKkJ79h/KR5STi/ZGfCsYOpwbGRvax7TeO+CMRQFejwkoG3M7KdZay9bgo3J/SOLb5UAjJpE43lDtjYpulKCTLh1qci7DrAuGAld+R2c4KGzufPgZwLpJRXSKZaSGvNasdhWKdDMD4olwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxETBem5eo/dqqh+Z0La9l0ieEPO9jfkDp48WjtVAEg=;
 b=UE9rRqAo9eX01StgxaXLVAlq2ax4tliJkL/DXAvEz5a5mX4REtlTbKQJ9Dp5kVDUqSjvN5W2uO8WogAN5MqEYQf6ikG/pzGvjxDl3I1HcQF8z9FDQInKPiqlffJq/1nf2k1QSWwr/kySXknllwldHHzIedve3yWsst9sQjr6E4c=
Received: from BN9PR03CA0874.namprd03.prod.outlook.com (2603:10b6:408:13c::9)
 by DS0PR12MB9347.namprd12.prod.outlook.com (2603:10b6:8:193::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 11:11:38 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:13c:cafe::36) by BN9PR03CA0874.outlook.office365.com
 (2603:10b6:408:13c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Thu,
 25 Sep 2025 11:11:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 11:11:38 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 04:11:38 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 04:11:37 -0700
Received: from [10.65.97.37] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 25 Sep 2025 04:11:36 -0700
Message-ID: <ab4ad769-2ef3-40a3-8a2d-9d533f2a3eec@amd.com>
Date: Thu, 25 Sep 2025 19:11:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] numa: add 'spm' option for special purpose memory
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
To: David Hildenbrand <david@redhat.com>, <qemu-devel@nongnu.org>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, Igor Mammedov
 <imammedo@redhat.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250924103324.2074819-1-FangSheng.Huang@amd.com>
 <fa625f3d-6493-4213-b317-23ab1e16ac37@redhat.com>
 <d5a087bb-5ed9-4463-9674-7c1748852198@amd.com>
In-Reply-To: <d5a087bb-5ed9-4463-9674-7c1748852198@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DS0PR12MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e8475a-408c-4588-d695-08ddfc244c45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDFjZU45UEJoNktTQlQxd2tJQTJWL1ZTQjNrYnc2RWVYYWszSWZtVjlYU1cy?=
 =?utf-8?B?MHBPQ0NRanZSUk1WWjFOSjg0dHBnbmhtOVJqRlN5Mkp2VEZSZTVKQ2wvUmcx?=
 =?utf-8?B?Znlob29OVDNhdGRycXpsTTRLZDVYc0FVRkFvTDBJMDRHNjB5Sm9VN2RVU1RW?=
 =?utf-8?B?R1FFUDJHYUtMTU1jdzBlZWpwWS9WalNBZHFLS0VHbitTZEN0cGk5R1FIZGF2?=
 =?utf-8?B?Sk5jMmRuaTl6ei9DdlR3bE5vSGZNMnU5RDVaeVpRbWlkVTJjMHFEbmN0Q2tv?=
 =?utf-8?B?ai85TkptdWpkTkhxQUR4UWhhZ2JTOW1tZkoyQmk2YjRMMGlGNkdNTzRlNDVR?=
 =?utf-8?B?SDVwelg5M2J6bWV4eUFBcE1rNWlTVGozeUh4bXN4YTIwcVhDMitzR1NKVmVQ?=
 =?utf-8?B?alpRZGpHMEdOMG03Q3d4TlpGeC93eko5SEl3TytwcXdLb0x1WG5nYzVGRStM?=
 =?utf-8?B?TUg3RlpESURocnFNNnluQ0g3ak51Y2VxYWxPU0VTUm9nb3hPMU5XeWtZK0xI?=
 =?utf-8?B?STJtNXNxMERHbGNRdGlVSWVIeVJ3anZlb0UvcWt0MWQ4aUF1SGU0MlRaRFJK?=
 =?utf-8?B?d3BNVTg5b2pFOGFrOUpNOU9hdmErenNmcmg2ZFBQekdZM0x5YkNXNjV2ajVq?=
 =?utf-8?B?RHFLWW8wVjIzWEUrdlFJSnZKSXZuMnF3VFI2cmxZU3l4RkhFd1g3clVOek5s?=
 =?utf-8?B?c1liNXNyM0lJY05yb2VwVGFka1N3QnpYaHJrUWQwSWJkbi9hbG1GVEQwU1o1?=
 =?utf-8?B?ZlNIY0FVQTZKWEJtZVI2V0IySDAxVkpnZG55eDg3a2FqbzhGMEc3UmhHeE5K?=
 =?utf-8?B?U1Z6VFU1eW1Ha09qMWVtdE82UUV2SW53eCtJRlMyYkZCVTcwZW51ZzFmU01B?=
 =?utf-8?B?VXRFL29Ub0xHc2MvQjhFT0tENmkyNW8xUTRQcXRUcWhNaGd0RkNiVjkxTUlw?=
 =?utf-8?B?WjVjMkQvL3VSaDE4NE1qMFNkcTBEeEtzOStMYzBvNkl0SWhIbW15RWZZbndD?=
 =?utf-8?B?WVlWK3oyaS91T1U1N25xRCtwK01PWkVQZ0lnQlUrb096dEVydlJEeHRKRlJI?=
 =?utf-8?B?NFdtNXplUnJ5bzRNcEJxQVZNMThQQ09xZ1JiSW9mRE9UdW5KSlZFVklUR0lJ?=
 =?utf-8?B?TXcrUWhCRDk5NkRvbjJUeWxacFVraTVmY3NBWk1oZFI3VW9xczJoSjRFQVpB?=
 =?utf-8?B?VVpuTEcrNVYrWGFjYkhMbkNSN3E0Vzh1MWhxY3hMWWtleVd0dFphQ0ZWLzlS?=
 =?utf-8?B?azMvWUxjU01RWU8vbCtINzQ1c0FJYkZBU2ZNQUFUdGVKVEFyTFVSSkdnV29l?=
 =?utf-8?B?dDhrZElzMWQ2cWRhWmpXelkwVktrNC9jbTlrTWR4TTZCNldLTjBhOVVvZ3ZY?=
 =?utf-8?B?T1VSTTZoajl4b3pDdDVRTWV2Und6TjZDUFJUQTJTYStsSGtNek14Rm16akVm?=
 =?utf-8?B?UDdiS05pcjlWbjBMVHN0d216bUJHVHhXRDAyQTNIMWlYbTlRcTFWRFBKd3ZV?=
 =?utf-8?B?RUR5dVRRSzd6M2V3aUtycjdSVEljaXNOQ1lkaURkU3JiL1dkWUhMdDJqMW1x?=
 =?utf-8?B?ZWRhak5wL0VrWkZTdHJaSXhCMmdvUnRyTHloYmZaL0pOVm9EY1ZZTys2Ullt?=
 =?utf-8?B?a3dRWnl6ZEpjVjdDeEZQVmlQQmlCZnQ1UGZLdFFDOU1XWGxsT2dIOEhhMXVL?=
 =?utf-8?B?aEJvbXVScGw4RlVvRVVVSzFpdS9neHV2MEZhZlBlVStrdEp1WVRla1RicEZU?=
 =?utf-8?B?dDZlOEJRYUlhZzJvdnpsTTJzSStlRS9BeXArVldtdjFTcGQra0VMYWVxNTFm?=
 =?utf-8?B?WTZ1UFltUkQ4YWx6RElPUys1TVFldm1qZnhkUWc0TjAxeCsyeldjVWYzMVlC?=
 =?utf-8?B?aWFVR2Q1aDA3Rk5XRG1rZFdCeTJxcDAzTjdySGp0ODY0dHZ0elBoTlFac0ZG?=
 =?utf-8?B?VndHRDl6N3ArY1hmVUlLaTJGNzFNUms2c0JCSmQvdERJZG5FN1Vyd1I4OGJX?=
 =?utf-8?B?WW5uWktiWXZBYUQ5MlUvUHh2ZndBY1Z4Rys5WjhCeVVyM0ozVmVOb045S2tF?=
 =?utf-8?Q?+oTKEt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:11:38.4718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e8475a-408c-4588-d695-08ddfc244c45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9347
Received-SPF: permerror client-ip=52.101.43.46;
 envelope-from=FangSheng.Huang@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Hi David,

I need to update you on the SPM (Soft Reserved Memory) implementation. 
While
working on the OVMF patch, I discovered an issue in the current QEMU SPM 
patch
that causes overlapping E820 entries, leading to memory allocation 
conflicts in OVMF/UEFI firmware.

I'm currently working on fixing this issue and have already implemented a
preliminary solution. I'll keep you updated on the progress and send the
updated patches once the fix is properly tested and validated.

On 9/25/2025 3:39 PM, Huang, FangSheng (Jerry) wrote:
> 
> Hi David,
> 
> Thank you for the quick response and for bringing Igor and Jonathan into 
> the discussion!
> 
> On 9/25/2025 1:03 AM, David Hildenbrand wrote:
>> On 24.09.25 12:33, fanhuang wrote:
>>> Hi David,
>>
>> Hi!
>>
>> CCing Igor and Jonathan.
>>
>>>
>>> I hope this email finds you well. It's been several months since 
>>> Zhigang last discussion about the Special Purpose Memory (SPM) 
>>> implementation in QEMU with you, and I wanted to provide some 
>>> background context before presenting the new patch based on your 
>>> valuable suggestions.
>>>
>>> Previous Discussion Summary
>>> ===========================
>>> Back in December 2024, we had an extensive discussion regarding my 
>>> original patch that added the `hmem` option to `memory-backend-file`. 
>>> During that conversation, you raised several important concerns about 
>>> the design approach:
>>>
>>> Original Approach (December 2024)
>>> ----------------------------------
>>> - Zhigang's patch: Added `hmem=on` option to `memory-backend-file`
>>> - QEMU cmdline example:
>>>    -object memory-backend-file,size=16G,id=m1,mem-path=/dev/ 
>>> dax0.0,prealloc=on,align=1G,hmem=on
>>>    -numa node,nodeid=1,memdev=m1
>>>
>>> Your Concerns and Suggestions
>>> -----------------------------
>>> You correctly identified some issues with the original approach:
>>> - Configuration Safety: Users could create problematic configurations 
>>> like:
>>>     -object memory-backend-file,size=16G,id=unused,mem- 
>>> path=whatever,hmem=on
>>>
>>> - Your Recommendation: You proposed a cleaner approach using NUMA 
>>> node configuration:
>>>     -numa node,nodeid=1,memdev=m1,spm=on
>>
>> Oh my, I don't remember all the details from that discussion :)
>>
>> I assume that any memory devices (DIMM/NVDIMM/virtio-mem) we would
>> cold/hotplug to such a NUMA node would not be indicated as spm, correct?
>>
> Yes, that's absolutely correct. The `spm=on` option only affects the boot
> memory that is assigned to the NUMA node through the `memdev=` parameter.
>>>
>>> Project Context
>>> ===============
>>> To refresh your memory on the use case:
>>> - Objective: Pass `EFI_MEMORY_SP` (Special Purpose Memory) type 
>>> memory from host to QEMU virtual machine
>>> - Application: Memory reserved for specific PCI devices (e.g., VFIO- 
>>> PCI devices)
>>> - Guest Behavior: The SPM memory should be recognized by the guest OS 
>>> and claimed by hmem-dax driver
>>>
>>> Complete QEMU Configuration Example:
>>> -object memory-backend-ram,size=8G,id=m0
>>> -object memory-backend-file,size=16G,id=m1,mem-path=/dev/ 
>>> dax0.0,prealloc=on,align=1G
>>> -numa node,nodeid=0,memdev=m0
>>> -numa node,nodeid=1,memdev=m1,spm=on  # <-- New approach based on 
>>> your suggestion
>>
>> The only alternative I could think of is gluing it to a memory device. 
>> For example,
>> have something like:
>>
>> -numa node,nodeid=0,memdev=m0 \
>> -numa node,nodeid=1 \
>> -device pc-dimm,id=sp0,memdev=m1,sp=true
>>
>> But we would not want (and cannot easily) use DIMMs for that purpose.
>>
>>>
>>> New Patch Implementation
>>> ========================
>>> Following your recommendations, I have completely redesigned the 
>>> implementation:
>>>
>>> Key Changes:
>>> 1. Removed `hmem` option from `memory-backend-file`
>>> 2. Added `spm` (special-purpose) option to NUMA node configuration
>>
>> That definitely sounds better to me: essentially "spm" would say: the 
>> boot memory assigned to this
>> node (through memdev=) will be indicated as EFI_MEMORY_SP.
>>
> Thanks, that's exactly how the implementation works. The `spm=on` option
> ensures that when QEMU builds the EFI memory map, the memory region
> corresponding to the specified `memdev` will be marked with the
> EFI_MEMORY_SP attribute.>>
>>> I would appreciate your review of the new patch implementation. The 
>>> design now follows your suggested approach of using NUMA node 
>>> configuration rather than memory backend options, which should 
>>> resolve the safety and scope issues we discussed.
>>> Thank you for your time and valuable guidance on this implementation.
>>>
>>> Please note that I'm located in UTC+8 timezone, so there might be 
>>> some delay in my responses to your emails due to the time difference. 
>>> I appreciate your patience and understanding.
>>
>> No worries :)
>>
> 


