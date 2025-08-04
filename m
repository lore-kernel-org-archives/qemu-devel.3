Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3332FC87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 11:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uitJv-0007Zy-7S; Mon, 04 Aug 2025 07:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uit1u-0002Mk-GJ; Mon, 04 Aug 2025 07:06:58 -0400
Received: from mail-bn8nam11on2061f.outbound.protection.outlook.com
 ([2a01:111:f403:2414::61f]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uit1s-0001JY-9n; Mon, 04 Aug 2025 07:06:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tb5A9M9G4rDYoW30bEaVaq9dtN8T+5D8hLPfAEBTmxKwJ+FEVMRZi+r6n79cP3/txy+QZpGEiOFUH8fcLoKAyqv+Fsp1gPx4ViFOina6vEVAERO1mEu4hG9qh+xa6L98/DXtj6RIZt/aggiyqzJoCPaY/96qNpcybodz1oLcAPAGqD3vO12po6rink2+ddKfd/5DMN7czEzJ8zxMj4hqqWbBcY549+sRjKKNbRYTAk9Iy/i0QqebDoV0y1C70lYvUf7Hex1Te9mlhPFhm6FYMDU7XBvrmfZ1Twjzgwkm/LSDXLpoN8HTmp0Bk3fsf0sRGvsDHVa/BSoZx4ffaT8ixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZR2M3eM3SZqIlz9owdBoaNGcRixv/sYqE1UnHWgC1g=;
 b=ksZJC0eawDPS+RAKDrgIJrnr3zH3eX2SQ4I8fo6uPBL4ctP/OGSIa2uf6camPdPJNfTyC8br2gs+FxxgSa6127RahO6iFdbhyXRxi9GXuk4srLptxaVd+tNBfAa6DDg9Cz/LrmWiseVktwHINxd10KtIgrVs4l0pTMWx3cZyh01/6T0hOSo3vVM5S5+thkfaqG9ogBo+Q9WlhvTqJg6RfX1TPcuW30aH+WZOeR6hoFoxT00peYqMa8XlrBJeNYgUQNlQ9xPmDcGxDVDjZmV0yHCrvOqgChbyHGKcoITqpgueX2k27Mk9CwnFW7FuKXcO9nVfnKHEA6qhk5TJkqKYCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=tls.msk.ru smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZR2M3eM3SZqIlz9owdBoaNGcRixv/sYqE1UnHWgC1g=;
 b=Z+I6udjLmnKv02DidSHgcuWSFEjtUyPmEz50fqyKUyNMjmhrbM2WpYol9godsHnTjxqTnCsmOQjrCzHmlI+LDUs7WyOaP/BdpVPrXxbpoU7K+0h2oqpAzwQuzgxnpQiZ9ahxvVP9JGMTqKGmbj82WzTLSzqgyreqZBydzlhHwXw=
Received: from SJ0PR05CA0071.namprd05.prod.outlook.com (2603:10b6:a03:332::16)
 by MW5PR12MB5650.namprd12.prod.outlook.com (2603:10b6:303:19e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.19; Mon, 4 Aug
 2025 11:06:49 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:332:cafe::fd) by SJ0PR05CA0071.outlook.office365.com
 (2603:10b6:a03:332::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.12 via Frontend Transport; Mon,
 4 Aug 2025 11:06:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 11:06:47 +0000
Received: from [10.85.37.138] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 06:06:43 -0500
Message-ID: <d29ccd29-d4c6-41fa-8158-93f9a21ab3ba@amd.com>
Date: Mon, 4 Aug 2025 16:36:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] hw/i386/amd_iommu: Cleanups and fixes
To: Michael Tokarev <mjt@tls.msk.ru>, <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <richard.henderson@linaro.org>,
 <alejandro.j.jimenez@oracle.com>, <vasant.hegde@amd.com>,
 <philmd@linaro.org>, <Suravee.Suthikulpanit@amd.com>, qemu-stable
 <qemu-stable@nongnu.org>
References: <20250801060507.3382-1-sarunkod@amd.com>
 <703d1159-7bdc-47b7-be08-64d7b000e45b@tls.msk.ru>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <703d1159-7bdc-47b7-be08-64d7b000e45b@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|MW5PR12MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce9cce5-7061-44d2-c018-08ddd3470127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVVUOWRIeklFV2VDSGFOZ1hMRzRlY2lIYWlkRmlBVnUxT2tqdWF3SXFCcVlO?=
 =?utf-8?B?ZitJN2tLNlVaeWJhRnAvd2xmbFdQTy9kR24zRkpWZnlIZWxJNDBrL01xZHRE?=
 =?utf-8?B?d0dqdVdOaVhPQ0JHTE1oTElORjJsQklxdWprODFTa25QcS80V1NVVms0V2dZ?=
 =?utf-8?B?bWcxMzJrUEVibHZLbi9sRXY2MzdLdCtUTjFuQ0FwOVlCaFlCdUdiT1lwVDN1?=
 =?utf-8?B?Q3VKaWVtZGoyaVhOMlA4ZGlvUkJnQms0NlBVN3R3YzdBSWcwZmRqMGFzL1Ji?=
 =?utf-8?B?Z1NvUXp0UjdJRC82K2FTT0JLYkZiZXh0RmZGcWExdTZOL2NIV1J6WkhsNG5R?=
 =?utf-8?B?NytMcFdvelNBZVlWaUY2YStVeDNFSXlGZm1LczJvbXo0Q1duMXVibUxHVXUv?=
 =?utf-8?B?YWw4VnZMVWMwUEYxeUJCMkxwZktTWEloeVhvaWlPV2hhaXV3c21zSUhEZDkx?=
 =?utf-8?B?Tmh6aWxGbTIwM2xjTEdtNXVJZklHWStxQ0taUW9HdGJBanRTalFMWmFOaEFZ?=
 =?utf-8?B?UDVWTlpOcmw4blZSYmg4V2x6SU1iemZwM0wyWXJvbTUzdVhKTDVzOG44R09C?=
 =?utf-8?B?ZHVsU0pzWkJmdUkyRDBqQVE4K2wvSlh6NjREN0kwVFJ0WTkxSXBnbWxjdDI4?=
 =?utf-8?B?emFTUDFzRUw2Y2RRZFZLL2dhT0JoN252ZnFVemRNMVZtYXRoRERiS1Rzcjlk?=
 =?utf-8?B?MmpnTVBDbmRLUEZUVUhRQXBmMjhIeU4rM3Rha3lSRFd1WHhUNXFlbHBqbnNC?=
 =?utf-8?B?VCtFMkN1RGNVYkljN0pyVjBLcnBNd3FQend3MnlaZGovNDI4VzA2am5Cc0o3?=
 =?utf-8?B?VmVKUHFmWEc4d2M2YXRhb0JqVWQ5N0pxUGs5bml2TktaQVFqeWNaY1A1OW95?=
 =?utf-8?B?akc3SEZKV1dJZ2VzM2FERUVleHNwQ0hSVEh0dlN4NHp4V2NaVUlxdW5Jd0k0?=
 =?utf-8?B?UFVHWUowL3hoTkt5OWtVbDVZVFY4cEsyQXZkOVpuQlhVZHU0SjhBVmFpSEpr?=
 =?utf-8?B?WHozcEtaWHliWS9EK3ZLNm9KcXBwV0JuQ01VUVJzVUt0RWRCaUY5Z0VkQXB5?=
 =?utf-8?B?SlF1cGFqTXBneU8ySGlDTEtBaENRQUR0V0hVTEhvL3llRkx2am9WM2Z5TnlX?=
 =?utf-8?B?N3A5Y21EelYrWW1LTVl3YVVQL3RVZmM2N1MzNlhsMTllU0tKNGltTmZxUlNZ?=
 =?utf-8?B?YkhveXFoOWZaUFIyNlpxU3R4Y1g0WFlxUGFsaGhhS29kUW5DU0g1VUc4UW1o?=
 =?utf-8?B?MG9nSHhHVGFDZFlSalZwOGxmcWlkcXZ4Q2lvZk4wK29sd1dRUnJCcHRaeG1a?=
 =?utf-8?B?ODdJSVZ1c3VzYkVUYXhNMndUdmdxMnV4YzkxNmNXbk9TVVk1WVRaNkR6Tkxt?=
 =?utf-8?B?RkVoRWlDQ0xicmRGY043NEVKYXREVFoxUUR0VUlWTUFqOUJmd2lhbnQ1TlB4?=
 =?utf-8?B?NHZJeHpSa1NtSmFZOGZzMjlldUhhK1lnNVZTYlJ0TFFiU3dKcjFGYXZyd2ly?=
 =?utf-8?B?SXRzajIwWkRZTkU0bXE4NGxHb2ZTbXBoMVZmK05zMUlWK0hiVzNFZ21YWmJn?=
 =?utf-8?B?THp2UW9KcWVyRGFVT2hZYXRpSUdzTlNjYWxzTWZEWitqS0tQOVBJd3B3dStV?=
 =?utf-8?B?YmdLOVBBVzI5RXYxd0VSWlFhOFRhRGNOcGIyS201U0pDVjI5aDF6UWw1RlBZ?=
 =?utf-8?B?bDZkcnVrODJOZDdaNVFtcmpKUTI2ZEk4TmswUVhzUjlUc1dEZjBmK1NoRlEw?=
 =?utf-8?B?NzBrN09WZnM2eVEwYmVGQm9obXBUV0Y3dTB2VGVHNFg0cVJZeklxUE9UaktW?=
 =?utf-8?B?R0J0Y2pseDB5N3FZVEJxSmdTUWZuSytVZitjdCtnRXp2SHorMXVkaXJBTVFU?=
 =?utf-8?B?S0xKUng4a2NOOWtwaUdlQTM5QVphTmJXSGxyRzdoK01CUUV1VHM1Y2V4VXBF?=
 =?utf-8?B?SkVFWkcrQ0ZEL0JIejllaEhUeEhHeFVWUmhWN1lmdk95S1ZhSExCM0JJS1FU?=
 =?utf-8?B?dnR5eTFEc0YrdEw3UElBdnZ6WWsxM281R3czZjBZcG8vVnF3Nm9HUC84NmZQ?=
 =?utf-8?B?VFI3d2NBMFhxdE4xZlVld2V1clltZStYcXA2QT09?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 11:06:47.0658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce9cce5-7061-44d2-c018-08ddd3470127
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5650
Received-SPF: permerror client-ip=2a01:111:f403:2414::61f;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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



On 8/2/2025 11:11 AM, Michael Tokarev wrote:
> On 01.08.2025 09:05, Sairaj Kodilkar wrote:
>> This series provides few cleanups and fixes for the amd iommu
>>
>> Changes since v2:
>> - Used VMSTATE_UNUSED() to maintain migration compatibility when 
>> ats_enabled
>>    flag is removed [Phil].
>> - Simplified the amdvi_writew [Phil].
>> v2: https://lore.kernel.org/qemu- 
>> devel/2e8f2b72-8fb5-474f-9844-61f306efeb2b@amd.com/
>>
>> Changes since v1:
>> - Dropped top two patches which depend on the Alejandro's changes and 
>> rebased
>>    remaining patches on top of v10.1.0-rc0 [Phil].
>> - Added a patch to fix amdvi_write*() [Ethon].
>> - Reset event log head and tail when guest writes to event log base 
>> register
>>    [Ethon].
>> - Considered "evtlog_intr" flag while generating event log interrupt 
>> [Ethon].
>> - Fixed comment [Ethon].
>> v1: https://lore.kernel.org/qemu-devel/20250716073145.915-1- 
>> sarunkod@amd.com/
>>
>> Base commit: 9e601684dc24a521bb1d23215a63e5c6e79ea0bb (v10.1.0-rc0)
>>
>> Sairaj Kodilkar (6):
>>    hw/i386/amd_iommu: Fix MMIO register write tracing
>>    hw/i386/amd_iommu: Remove unused and wrongly set ats_enabled field
>>    hw/i386/amd_iommu: Move IOAPIC memory region initialization to the end
>>    hw/i386/amd_iommu: Fix amdvi_write*()
>>    hw/i386/amd_iommu: Support MMIO writes to the status register
>>    hw/i386/amd_iommu: Fix event log generation
>>
>>   hw/i386/amd_iommu.c | 102 ++++++++++++++++++++++++++++++++++----------
>>   hw/i386/amd_iommu.h |   2 +-
>>   2 files changed, 80 insertions(+), 24 deletions(-)
> 
> Hi!
> 
> Is there anything there worth to pick up for qemu 10.0.x stable series?
> (the "Move IOAPIC memory init" does not apply to 10.0 already).

Hi MJT,

I will backport the patch manually and send it to qemu stable mailing list

Thanks
Sairaj



