Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9388ECCD195
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 10:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBVwd-00037v-Gg; Wed, 22 Oct 2025 06:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vBVwa-00037P-Bq
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 06:19:48 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vBVwV-0000zY-FG
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 06:19:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GW6aOmSovsp0wMcpinS1yWstRZ3uCwbpaXCK6p7RRX7fyVNlkhQ9dIHGwUKdU3ON5sbmx0opn7NYWfJUnQXLeRpE6OXkqwI2Bg8wnxFnXwY7OigUEJbMMwbX9WwV/PRVcPE60RZBDH9C2kfdeVPtY/ZsksqbtdL5/ZmC52n7lBQ9+oB5QSMdjGj4UUApJuY9BAfTixHBdcOlar7KuBtCz4EyNBKha3XDK0lSBVi4eaoCOLAY6Z2G/otQiIFSnuQpTwWV6H3iURcaTOxVjghxuVFiSxSGF/ZinfoggBmWqordL8JDBMcIE1tleA+6o1qfYLC2JTZN8nGGFiXyZ82tcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lObWz96HNz34CJmFZLFKi/zf4klGd0vy+EycYDow450=;
 b=ndIT6htMRHQKKgfbmYgwFaQ61BTAqVmqxfJJhADvTxiwZAsyXXN5xZZhaYxEargdrszpsB6JoaF31IU4VFK2oZijyg3cdL8DUtKPQw3BNNVDUJ9hDRz7TOtiRMDOkl+xjk1l3a8Gc1cgGkijYBlUuYWc7M/FlIchYYvIjO3FbXRmPQZvWW0uyAShIYoauErMb661L/aJBnHeSvxuFYHRcDvBmRmGgq1FjY+AV2A/lG8L9G8nMQVo1Oicxsf9XTdynGAfXeTTVo9kP0N2uf7maKKf0C1GDQN5pUmrumRKKNsC7n6r4RR0Xl7bG4y5bqef00etcn6VeN3BLPhoTc3hDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lObWz96HNz34CJmFZLFKi/zf4klGd0vy+EycYDow450=;
 b=R9+Z690mPXj8um8eUng3NMT+rpWoanMxQExG2o3tyhbmA9oQOZtlMEN1R7j53yCcItTTmazPSLr0YXOh7+xSefcML6QSZ6oV3SCQg4tw0g0zQsagWZcD3Py7UbKeFbqeO4cFbI7QhHFQKk7DmatzhE60kWr0kJa5nwAeYotAzFM=
Received: from BL1PR13CA0229.namprd13.prod.outlook.com (2603:10b6:208:2bf::24)
 by DS2PR12MB9613.namprd12.prod.outlook.com (2603:10b6:8:276::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 10:19:36 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:2bf:cafe::d3) by BL1PR13CA0229.outlook.office365.com
 (2603:10b6:208:2bf::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 10:19:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 10:19:36 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 22 Oct
 2025 03:19:35 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 22 Oct
 2025 05:19:34 -0500
Received: from [10.254.202.150] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Oct 2025 03:19:33 -0700
Message-ID: <4292fabf-1ae9-4bb1-b8df-fad527592786@amd.com>
Date: Wed, 22 Oct 2025 18:19:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] numa: add 'spm' option for Specific Purpose Memory
To: David Hildenbrand <david@redhat.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>
CC: <qemu-devel@nongnu.org>, <imammedo@redhat.com>, <Zhigang.Luo@amd.com>,
 <Lianjie.Shi@amd.com>, Oscar Salvador <osalvador@suse.de>
References: <20251020090701.4036748-1-FangSheng.Huang@amd.com>
 <20251020111534.00004a29@huawei.com>
 <40005e02-17df-43d1-a1d7-0b3bcfefdbf1@redhat.com>
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
In-Reply-To: <40005e02-17df-43d1-a1d7-0b3bcfefdbf1@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: FangSheng.Huang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|DS2PR12MB9613:EE_
X-MS-Office365-Filtering-Correlation-Id: 26387904-d0fb-403c-8c86-08de1154807d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHNwTjZQaXBRdlBOZEp4b1pxTnowNkgvYmkzb3N6ZGtLU2NmanNHMVByQWFS?=
 =?utf-8?B?R2JRUGRoSnI1N081T3hqY3ZYdytRR203bkw0VUVqZmkwL0ZkRVJUTnNlRnFE?=
 =?utf-8?B?R0pTQU5DV3VuMzJTeVZ3RmNOTEdhK2g1WE1TUkZNcXdSaWQwL3NIZUtNTm5C?=
 =?utf-8?B?ZWpNdGJhRG1XOXB6ZUxHYnZwb2hYVm40RzVEOXFpdldCQVNyUHpsUzlBc0Y4?=
 =?utf-8?B?L2dPUFBzQWIxT3pCOW1YV1ZZUTJEcGx3K3RLNE15YjZxWWJtS0FpQUNSTWtv?=
 =?utf-8?B?RDNVNk50ZG4ya0s4aERDbzdaVmJOemtNaUd1a2VIOUxwUnRkVnU2SG1kb25K?=
 =?utf-8?B?MlYxc05pRFFyeTM3aERLNHY1dGgxc3ZQdHh0RG9YZEZPaWdrUk02SWRyWlFt?=
 =?utf-8?B?T0hXODY1TGNXRWpBSGZLWUYyRlgxWWRCM2ZmS3RTOTV1TEpRd0ZHWHc1VDY4?=
 =?utf-8?B?em80bENxcUlZWUdpVU9ZbXBDUjdxUkJ6eVRHYnVnQm0zUzlsZlFTT1VLREJY?=
 =?utf-8?B?NXFIS056cDhtbEVqSUJSVGZZWUduZXQ4RXdnMmpydy81cS8zVFlUTWxIWFJm?=
 =?utf-8?B?NGZUd0ZxS0t1VmpKd0laQzBNTUhWYUtmeE5Ja0NZK3M5bm50VHplMjZxUVBy?=
 =?utf-8?B?OTV1RFNlemZqK3NXdzlNQ0FuSjduRXljbDgxaTRZT3kvNkxDemhSNDIxVDU3?=
 =?utf-8?B?aGVPd0g3QWR5aFBQZlc2K1BLWW5iTHIyYkZnS0xkMkZzR3hFRnFTMHJzM0ZH?=
 =?utf-8?B?cU5pbFhNeW5NQ0dMNDdDNlovUHdESEVDVTVyMUNpSng2VWVCdE8yakF0Nlk3?=
 =?utf-8?B?dmJNdFBDTlQ0SEtDYVFORUEyOTludkJnVklVYkloaWJLWTI5dnl0RklpZHhN?=
 =?utf-8?B?S2krUThndDVobnFVaS9BU2dBaWkwYVhVVG53SkgvZlVtR3AvV3laTmhYSEJh?=
 =?utf-8?B?czdySTBOK3RlTnVoM3hsbndGbmx4anZMeHdycS85MmxiK2N6b1hML1dsdk9L?=
 =?utf-8?B?bU40dFBuTzFDMlF6VWh3RUVHRnFSbENHOFJGcWVoL25mK0FWdWE0TCtXRm9a?=
 =?utf-8?B?WUdjMVpZRm9MZjVoamo2M05VVXFGQUNLMmY3c004S2ZpUis1WUhKSU1JckYz?=
 =?utf-8?B?RE1zMHdjTFBJdWVReW5KQzFUSnhTcmh4bTNTVk9oL0Q0VVh5eklnSm9uRlVY?=
 =?utf-8?B?SDc5ZzNCc2dpdU81a0pVaW9SUlVFR3VpbDJXdjJoSk5CYWdJTlhxckdzYjNP?=
 =?utf-8?B?L3A3WkFLWjM2N2NuZEZoTVo4TVFLRXdWT2VlZUpkNVdweHBqT0tXamFrZEJ2?=
 =?utf-8?B?Z1QyMVhJby9QcmQrdXEvYThKNVBHUVV6bkJpTlVMUmhzS2g2ME83RHh1NFZF?=
 =?utf-8?B?SG9NZkJNeTN2T1RxYzc0ZWIrcjNBanc5N0VXQ3VWMkxhMWUwMXZVN000QVBq?=
 =?utf-8?B?N3pjLzJxekZ0c3JzMFpmbi9yLzFzRVVLVGxSVk1XbTl3cE5UVC9hU1AwWWxo?=
 =?utf-8?B?bUh0UjUyUDBieUFmb00rd0hhc0tuZ1JYYlgyMzYweFFTTXdLdncyTDhKN2Rv?=
 =?utf-8?B?ekp6dEpjZmhSbEtWaWExK3BsdU9RWXJSUmh5QVpBUDVFUDhMRTNsQy9Pb3Qr?=
 =?utf-8?B?UjZwcDZleTR5UlBSTUlFSitLNHB4eDNDMGUzQkVPWTlKN2UwM0tQSFhqakdv?=
 =?utf-8?B?cEgrZUlZRy8xQTdSZFN2ZWE3Q0pteFRSODNuQi8rNE9jQVpZaFhxNUNPNUNo?=
 =?utf-8?B?cE1IeTRMTHllaTZzR0VPcDE0OE9sdG5YUGxHbU5oa0o2NThhTHE1WjlGYldz?=
 =?utf-8?B?ZnhvN0t3SVhNUlR5cENnZnd1ajFOOWp0eC9kbndRWGJ2ZjJsSE9laldpU1Fy?=
 =?utf-8?B?QkhRWkRiVy92Z0dZTUFyV3dLMDROaFVhTWtjbjJuSU5obmVrYTdTL1V1Y2ls?=
 =?utf-8?B?eUgyR2dTU3NkTko0dk5uTXNob3F4citvMFg1SWtETDExZUhVVjdic1lkVFVp?=
 =?utf-8?B?UmVkd2xkWkhod09EZzNYTW01VkdXanBlZ3BMYllhY0VHSW5HYm9qWDJRbHdk?=
 =?utf-8?B?dDBySFlsU0pka3VRR1pBN1VoYVh2RUVCWSt6NTNzNFp6ZFFURmgvTkJQak9s?=
 =?utf-8?Q?Ov5k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 10:19:36.3391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26387904-d0fb-403c-8c86-08de1154807d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9613
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=FangSheng.Huang@amd.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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



On 10/21/2025 4:03 AM, David Hildenbrand wrote:
> On 20.10.25 12:15, Jonathan Cameron wrote:
>> On Mon, 20 Oct 2025 17:07:00 +0800
>> fanhuang <FangSheng.Huang@amd.com> wrote:
>>
>>> Hi David and Igor,
>>>
>>> I apologize for the delayed response. Thank you very much for your 
>>> thoughtful
>>> questions and feedback on the SPM patch series.
>>>
>>> Before addressing your questions, I'd like to briefly mention what 
>>> the new
>>> QEMU patch series additionally resolves:
>>>
>>> 1. **Corrected SPM terminology**: Fixed the description error from 
>>> the previous
>>>     version. The correct acronym is "Specific Purpose Memory" (not 
>>> "special
>>>     purpose memory" as previously stated).
>>>
>>> 2. **Fixed overlapping E820 entries**: Updated the implementation to 
>>> properly
>>>     handle overlapping E820 RAM entries before adding E820_SOFT_RESERVED
>>>     regions.
>>>
>>>     The previous implementation created overlapping E820 entries by 
>>> first adding
>>>     a large E820_RAM entry covering the entire above-4GB memory 
>>> range, then
>>>     adding E820_SOFT_RESERVED entries for SPM regions that overlapped 
>>> with the
>>>     RAM entry. This violated the E820 specification and caused OVMF/UEFI
>>>     firmware to receive conflicting memory type information for the same
>>>     physical addresses.
>>>
>>>     The new implementation processes SPM regions first to identify 
>>> reserved
>>>     areas, then adds RAM entries around the SPM regions, generating a 
>>> clean,
>>>     non-overlapping E820 map.
>>
>> I'm definitely in favor of this support for testing purposes as well as
>> for the GPU cases you describe.
> 
> Thanks for taking a look!
> 
>>
>> Given I took your brief comment on hotplug and expanded on it +CC David
>> and Oscar.
>>
>>>
>>> Now, regarding your questions:
>>>
>>> ========================================================================
>>> Why SPM Must Be Boot Memory
>>> ========================================================================
>>>
>>> SPM cannot be implemented as hotplug memory (DIMM/NVDIMM) because:
>>>
>>> The primary goal of SPM is to ensure that memory is managed by guest
>>> device drivers, not the guest OS. This requires boot-time discovery
>>> for three key reasons:
>>>
>>> 1. SPM regions must appear in the E820 memory map as 
>>> `E820_SOFT_RESERVED`
>>>     during firmware initialization, before the OS starts.
>>>
>>> 2. Hotplug memory is integrated into kernel memory management, making
>>>     it unavailable for device-specific use.
>>
>> This is only sort of true and perhaps reflects support in the kernel 
>> for ACPI
>> features being missing as no one has yet been interested in them.
>> See 9.11.3 Hot-pluggable Memory Description Illustrated in the 6.6 
>> ACPI spec.
>> That has an example where the EFI_MEMORY_SP bit is provided.
>> I had a dig around and for now ACPICA / kernel doesn't seem to put 
>> that alongside
>> write_protect and the other bits that IIUC come from the same field.
>> It would be relatively easy to pipe that through and potentially add 
>> handling
>> in the memory hotplug path to allow for drivers to pick these regions up
>> (which boils down I think to making them visible in some way but doing 
>> nothing
>> else with them)
> 
> Considering something like DIMMs, one challenge is also that hotplugged 
> memory in QEMU is never advertised in e820 (we only indicate the 
> hotpluggable region), which is different to real hardware but let's us 
> stop the early kernel that is booting up from considering these areas 
> "initial memory" and effectively turning them hot-unpluggable in the 
> default case.
> 
> Then, the question is what happens when someone plugs such a DIMM, 
> unplugs it, and plugs something else in there that's not supposed to be SP.
> 
> I assume that's all solvable, just want to point out that the default 
> memory hotplug path in QEMU is not really suitable for that right now I 
> think.
> 
>>
>> Other path would be to use a discoverable path such as emulating CXL 
>> memory.
>> Hotplug of that would work fine from point of view of coming up as 
>> driver managed
>> SPM style (the flag is in runtime data provided by the device). It 
>> would however
>> look different to the firmware managed approach you are using in the 
>> host.
> 
> Right.
> 
Hi David and Jonathan,

Thank you both for the support and for the forward-looking
perspective on potential future approaches like EFI_MEMORY_SP and CXL
emulation.

I appreciate the constructive technical discussion from both of you. 
Please let me know if there's anything else I should clarify about the 
implementation.

Best regards,
Jerry Huang


