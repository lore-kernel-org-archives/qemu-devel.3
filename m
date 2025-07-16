Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3589C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 13:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc1o3-0008RZ-9D; Wed, 16 Jul 2025 09:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uc1gu-0003HX-IG
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:56:57 -0400
Received: from mail-dm6nam12on20631.outbound.protection.outlook.com
 ([2a01:111:f403:2417::631]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uc1gq-0002hW-Se
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:56:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PRYXzWXvXGJ3Q3JOTebVXsy47ML4wFzuVxrd3yDOHCCI6GMnZGsCvVJuaFgTRNOP8LamLH/z2CB65H+slXaIrmg9l9YoUz7OOKHGHqQXHdsX0fBAPN2d2BYlczLOOkjObau8/g8VKCiNS3IBNOUcuj2hL0CJJ/qfc4xTh2AzrJvN126fZvS6laZZbXsWrTOthHJH1eQPVMqkAxdFF6Cimk4gL5VPgGVBhq18b0xiqIadGLWn+9HNgtAVDfsoYVViH6H3v8DTVH+alIXhJWXRYjUyabmCMVsjJnDTzzLQ+mUyq0G19rMgdM2RmMHqgyHmx17masHBZxTjueQt+4eokg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gZ36hZY0r+q9AgpsAXVolYgFnie+1vpoP6dWr7rutU=;
 b=NJi+wlLIucT084l0R8f+pgRA6VRC948N1Cvqg/sVxq2aGZmQqL+/Aub55e+d6qEc4tS8Y5t+Ibkb7sPPsWhrqtEFcSo7aBmhpPHORtNXJ/2FBmQ6C0ji1/1Ub9JTKfBAAiGew0N2ArFQMxA+aYUrKFT5AXer8SKJOebenbZvAKqp38YylFpG8axMX2fFTXw7ULZgOmPkIXWh24gmbk+3c5gqxla5yeqnP7Q4noBrjQ5vJ/h9u1gBr0OD/AHRMcg2wjS0qrhxfK49mv7XOum4vb9WK/iUCEwr2yx8FYwX2cA3eckJ4IEQiUoXHAwL8Z9u8a6pduXvzKQH9n03y5ANmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gZ36hZY0r+q9AgpsAXVolYgFnie+1vpoP6dWr7rutU=;
 b=z3KcNJ3QH4BgJHKUk2WSAEQgZjWgwxzeHUsVRaxNcgPuMW+RoBzbyfkkGSpe60Vud1QEETO71xlV3rvZNZzFBOVP64ws90g+97QlPWDZvYrpW+czh+DjOcZyefoxAWNkZAjljLQjQzw8ZssIMIhrxDmpKEw8KTDw+hpeA2hKD58=
Received: from DS7PR05CA0076.namprd05.prod.outlook.com (2603:10b6:8:57::13) by
 MN0PR12MB6246.namprd12.prod.outlook.com (2603:10b6:208:3c2::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.32; Wed, 16 Jul 2025 12:56:43 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::bd) by DS7PR05CA0076.outlook.office365.com
 (2603:10b6:8:57::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.12 via Frontend Transport; Wed,
 16 Jul 2025 12:56:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 12:56:42 +0000
Received: from [10.252.206.76] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 07:56:39 -0500
Message-ID: <a184b8d5-4620-4b21-99c4-0fc859647d14@amd.com>
Date: Wed, 16 Jul 2025 18:26:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] hw/i386/amd_iommu: Cleanups and fixes
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <richard.henderson@linaro.org>,
 <alejandro.j.jimenez@oracle.com>, Vasant Hegde <vasant.hegde@amd.com>
References: <20250716073145.915-1-sarunkod@amd.com>
 <6e56761c-64b1-43eb-9ff1-316b6de082e7@linaro.org>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <6e56761c-64b1-43eb-9ff1-316b6de082e7@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|MN0PR12MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: 846dfce4-7347-416a-d654-08ddc468367c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWR6YStaR1BCUDkyS3pLb1R6WDlwNHZER2NFcUJrdmpQNXhkenpybjhWcDBw?=
 =?utf-8?B?cTJTN2p4bVh6djlrSWgyaEJheWdPdTRKaG9TSTUxOW9tTERLaXU0R1JNMUpL?=
 =?utf-8?B?WmdTUSs3bWJrQW1ZYmN5eXI4TWFJWmE0ckdYekZ0T1RFRUN1ZDJXL2RKZmJV?=
 =?utf-8?B?Ty9rclJTTnZoaS9BcWNKMEJmcGt3UDBueWxDWmhWaEtxUldMUGpjQ0VmUm8w?=
 =?utf-8?B?ZmNsa3hmNFQvaEplWXMrY2Nnbk0zdVNNU1ZVNzlzTUdNSmRwM2JwNm1SUG1j?=
 =?utf-8?B?YmxQTHhwRVN0Tkg4aDRXSmlIVDBSa1plbmhmTkNHNlBjR09pQ3V0eXo1VlY4?=
 =?utf-8?B?RmQrcEpCWGpVMGIzUENHL1BMN1d6d2pUQzhxem5VNjkvOXRBYTk0bExCYlVI?=
 =?utf-8?B?UG9nN3EzNFhsdzB1Nm9ld09JZmJuL3BvWUdHaWtDSVZUWXBGR21KMTlPTDky?=
 =?utf-8?B?V1pPaWluWkJsR1ducEtVN08zMXJiVWNzZTBrVmZMSnZkUFRiM29mTUpnRFYx?=
 =?utf-8?B?U21EazVFR3JIMWVTcjdLdG5NOHNqMzdYcm5La0ZzUVZXWEdCeFA0MkFuMEQ1?=
 =?utf-8?B?dzBsRGRvVkoyb1FxbTdNOHlFeXNzZ2xDQjZKMk52clJ3Ymlrc0RPRFBsTFBY?=
 =?utf-8?B?aElJYWd1QnBvRWxNUFg5OXpUWllNcWJNakZ5Umd0VUZTY3hEOXRtbUl4cCti?=
 =?utf-8?B?d2dZNVk0QW16aWwrZlF6MUh5TFNHZ1owZjY0blRDK1BhZnhDd0VJbDhPU2xM?=
 =?utf-8?B?eXIwYUF1NVZQbnJKMC9NTHpzSGo4K09yU0hkUGxxSVZETGhjWlp1WHhHRFdW?=
 =?utf-8?B?cmU1QjBEWGN0UjhIL1hOT3l3YWsxenl3Qng2UnA3aldPLythU1pHV0x5Vjdn?=
 =?utf-8?B?MlRnY2dZSnE5dktJQnZKWmhvTXZPWnltVTF4ODUzTXJsRTJwN0RmMWIxSkly?=
 =?utf-8?B?YmlYS2dmY2hueHh6ZjlIR0JKK3YxRGRGK2pwaUVZSnRyTmt0dVpCRnhlVmRm?=
 =?utf-8?B?S1l1ZlBOT0VPTVNQQXhUTm53RUdhdnJMRWFXLzBZaU1aYXpwcjJUdVVwd2Zm?=
 =?utf-8?B?aHVXMXUvWU9ud1V2dEdXQzI4UEkvNGZvRStMdWRwNm82WExiN1BTS2pmZlZ3?=
 =?utf-8?B?ZkQrRnNQZHhTWVJGaFUyc1BUTE9vWG9Ta1ZaYWNzaWFIQUJkdkpnaU1WNlk5?=
 =?utf-8?B?Y0pvSUtZT1dRYWIwaTRVTFNBY0FMRHhPcUJIWk5Xc2RISTNzL1FsU0s0bVZo?=
 =?utf-8?B?NzdjazYxc3Nvck5MNEVNQnBJeVhGbVEwc0Z4TlhPV3N2SUNPK2ZYU01TQytT?=
 =?utf-8?B?RzRKMFZ2MGVwQlFLTXp4MFk1ZEQxR1A2Uk94VVJGOVF2YnpqRDlzTjZTMFUr?=
 =?utf-8?B?cXlsNmtoaFFhV0dRYVY4YjRqMW1xcWFOdldNMklUb1MvQ0pOeDVWcjd2QVQw?=
 =?utf-8?B?ZGt6K3BBcndrN25wUzZjbHQrYy9teElCWUk3eUlYWGYwbldZdXF4OVdTYUsx?=
 =?utf-8?B?ZWlRRm9hQ2dDdURIRDNWK2tjaitZSzcrRzdBZ0JsSEtpemVBcGgveG5jc0I1?=
 =?utf-8?B?N0VyenVRMXU2RGpFWThMT0xuTzRLYXdXajk4YkxzTEREdENQUkJPaWwwMSt3?=
 =?utf-8?B?ZFNyZU81bFBFNTB0YTBqSll3R21zaHVFMThTeEpycUhnN3BDWTFZaUttMVNi?=
 =?utf-8?B?RVVva3NwSlF2ZHUvWDFFeEpvZFFOV1Axb2NKaUw1L21yTlR4WTl6bjVTMWgv?=
 =?utf-8?B?aUlEdTkremo0Z2FkTXZoRTRCeDFKdkpCMkUxc1BpQTVtWUVMUkJaTFkySHFD?=
 =?utf-8?B?RWp2Nm9LTGFjM1hubHhkQVh1VHBnalNTay9RQW9PcmtaaEkrQzk0QU40VEQ0?=
 =?utf-8?B?VlVramE2MnVFY1dFMWdnenQxRElRREs1eUNqRTZqbGxSOTVrOFpLM0s1cFZT?=
 =?utf-8?B?bCtMM3pEUzhIcUhkZlpGM0toSDhIZFpoK2ltUE9OMWh6SHFoR1d2Qk91ZktK?=
 =?utf-8?Q?qxp2j5wu7n9XUUNiWuUvH6iEvUMs7s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 12:56:42.5484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 846dfce4-7347-416a-d654-08ddc468367c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6246
Received-SPF: permerror client-ip=2a01:111:f403:2417::631;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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



On 7/16/2025 6:07 PM, Philippe Mathieu-Daudé wrote:
> On 16/7/25 09:31, Sairaj Kodilkar wrote:
>> This series provides few cleanups and fixes for the amd iommu
>>
>> The patches are based on top of 56c6e249b698 (v10.0.0-rc3) and 
>> Alejandro's
>> DMA remapping series [1].
> 
> 56c6e249b698 is 4 months old, we are about to release v10.1.0-rc0.
> 
> What is the point of posting obsolete code?
> 
> I'm not going to review further.

Hey Philippe,

sorry. I missed to add it in cover letter. Intention is to get feedback
on this series. Since this is on top of Alejandro's series, I will
rebase it once his series gets merged.

Regards
Sairaj

> 
> Regards,
> 
> Phil.
> 
>> [1] https://lore.kernel.org/all/20250502021605.1795985-1- 
>> alejandro.j.jimenez@oracle.com/
>>
>> The series is uploaded on github:
>> https://github.com/AMDESE/qemu-iommu/tree/sarunkod/alej%2Bcleanup-v1
>>
>> Sairaj Kodilkar (7):
>>    hw/i386/amd_iommu: Fix MMIO register write tracing
>>    hw/i386/amd_iommu: Remove unused and wrongly set ats_enabled field
>>    hw/i386/amd_iommu: Move IOAPIC memory region initialization to the end
>>    hw/i386/amd_iommu: Support MMIO writes to the status register
>>    hw/i386/amd_iommu: Fix event log generation
>>    hw/i386/amd_iommu: Fix handling device on buses != 0
>>    hw/i386/amd_iommu: Support 64 bit address for IOTLB lookup
>>
>>   hw/i386/amd_iommu.c | 217 ++++++++++++++++++++++++++++----------------
>>   hw/i386/amd_iommu.h |   9 +-
>>   2 files changed, 146 insertions(+), 80 deletions(-)
>>
> 


