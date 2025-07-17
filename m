Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD48C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 05:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucHT9-0000be-MX; Thu, 17 Jul 2025 01:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ucHSk-0000Va-Uj
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 01:47:24 -0400
Received: from mail-bn8nam11on2062d.outbound.protection.outlook.com
 ([2a01:111:f403:2414::62d]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ucHSh-0002dk-MV
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 01:47:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUO6e780YRXSU6CvnWV3YRt6TxINV+cK7IY3KlmCTe2hsDGut9y2eNkFfz8R6VjQoDwUKkFzxXPqP8tSU7wi+jdxNGqdeLwn2GJz26abWcep4HOzrlQEiWlqnQl2p+pgv5BgERcIqFUVriwQ5uNTwa5X6G+IDFNDB8+3/W6jqLIyegKnLh+aqWPreoyTGi4LpksGbcOW0HbdbV08aMCsAHybTZZ8ZSCy+4yDv65Nra7huht7JYRqNJwAHR/PHrwbYS0jSbmqfyBJLDS58RLJjlDi5shZCNkTrk6HaY/tDO6vyYPoQyd4Ds/9FzTofld/Y0GZamzeptpe//u7VR5itQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wedi7j5Wa43w7Y22VWA5KbcCPunmhxtj8Zs5KaJslW0=;
 b=YfI48avFvu9eHZv7aUhUb7lyClq5szrImwns8RSQzDzTqEOYf6BfLVdMwob2C6ST6l4Ve1tafhJnH0X1Ikkhgr5HVoZGqMKwpU0v6Xd+iwyttESE3aenQzmv41dEFDhhK5Yszu+feMYTGGdP7OEOy4gXSwmHF75XgZq9JFE5jmCz9R8H4imEOQ0FNh5/DByiU6e3EUTfkn7QXLcPuOc6bKfmp0iUwanulGfzG5QvPy2VtGyvY8XT7a7vtOeXvsx5jm0+WXYz6m9Nfk4lnl+4dSxYEfLakH4Hb/PtoIBwiSIJ+TpBph8XhwlFoOZSltQoM5lUPOkml9c2LGa3w1b1Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wedi7j5Wa43w7Y22VWA5KbcCPunmhxtj8Zs5KaJslW0=;
 b=ZXKUz2RIQpKB2iPmfcPwc48kfMyXKho6xMQQEctg3QpRHbMELPX3q/qbI9vzleaxFFxgZUXj0viynBffNO+PNqmO98H/Sd7g9BbK+rpDLlWONSCgl6GGnHWwt9TUUhQto6LNlkiT9QgzTRrQch5hDGNC7qrhHZ+oLnaG9ORaFHU=
Received: from SA9PR10CA0021.namprd10.prod.outlook.com (2603:10b6:806:a7::26)
 by PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 17 Jul
 2025 05:47:11 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::10) by SA9PR10CA0021.outlook.office365.com
 (2603:10b6:806:a7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Thu,
 17 Jul 2025 05:47:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 05:47:10 +0000
Received: from [10.252.206.76] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Jul
 2025 00:47:07 -0500
Message-ID: <9570378b-0084-4acc-bb87-7ba4c454ddc6@amd.com>
Date: Thu, 17 Jul 2025 11:17:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] hw/i386/amd_iommu: Cleanups and fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>, 
 <eduardo@habkost.net>, <richard.henderson@linaro.org>,
 <alejandro.j.jimenez@oracle.com>, Vasant Hegde <vasant.hegde@amd.com>
References: <20250716073145.915-1-sarunkod@amd.com>
 <6e56761c-64b1-43eb-9ff1-316b6de082e7@linaro.org>
 <a184b8d5-4620-4b21-99c4-0fc859647d14@amd.com>
 <20250716092916-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20250716092916-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|PH7PR12MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f343d8-222e-448b-8a45-08ddc4f55fb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjExU2F1YjhhVnB1SW4wZVB6TXRqQ2RWb001QXQ0NVNZN1VmNGU5M0VoQ2Vj?=
 =?utf-8?B?bHdFZGo4QTdrU0JjampON3d3VGp3Y3d3Z2RmemVuUHEweXhvUjhoUXZlYnZD?=
 =?utf-8?B?OHlpYSsyMUFMK3VpTGtKa2pJMEN1WVhTTU12T3M0ZTRIT29qeEUxMnBNZlUw?=
 =?utf-8?B?NUdpNE5LS2RyY29NK1N6dVN2TDg5NGFvYUk0WGZNdHY1UGtrUFk2cGZsWllo?=
 =?utf-8?B?eFl2OHpyT0JGdzJoVE9wb01aL3Y5Zm9wVjRxV1JoclZnaVBNdDFzTUdtcjJS?=
 =?utf-8?B?S3Njck9qWFVGckNGRzhmTi83dkY4b3kvUkw0SllyUnlkcWRkOFJjU2FDbjQx?=
 =?utf-8?B?NkFrVGdrSmtmTkVYRFVxWUs1elFZNlpQVTdhbmFNM0tHd2NPenYwOXR6L3Z2?=
 =?utf-8?B?SFhydkhjVUd5cWdrR0dDUDJZNzg1TFRNcU41MS9GRVc4L200RnJzMGdHOFYy?=
 =?utf-8?B?eitOeko3ZFFRL3p1YlgrYTR3UTB4RVlhSE5GakIwdjl1KzB3WitLYWx0Z1RG?=
 =?utf-8?B?TXF0eU8wSW9MK2hNbEFNNmU4VUwxOEl6VVVhK0hZRCtnVDY0UDhicWxxRGpn?=
 =?utf-8?B?MXNMQkplY095cGE1dG01ZkNkUzNteXBjd1hRWEhuckIvd0IrS1VpMnZtWlpq?=
 =?utf-8?B?VitoZm1tWGVvNkE4cHUweDA1QmJlZzVGcmZlemFjenNZTllWRll2SzQvTGxm?=
 =?utf-8?B?K1lSQnQ0cTlwR2RKM3dXbUl0TDVLc3hhZXY3Z2VFZTRwS21yL0FyK0dLZG9T?=
 =?utf-8?B?NjVzU0UyTDluL2xnejkvemNtT2MyMzN2dlMrZnVuZkhBL3pYc2QxWFlvUUkz?=
 =?utf-8?B?L1pqODVON3YvcnNZQkJPOFBwMm9JUUhOaTc0STBFSmNpeE16cXdTNThFL2l2?=
 =?utf-8?B?QitWUHNXT29MbUZjbXZCKzdEWnAzODN6U3BwMXAwV0V4cWNhZ1lnb2R6dVhn?=
 =?utf-8?B?R251U1RPZnQrc3ArSmo0VEFVcmZhdkwzcXRpeVBNRmM4SDRUenJWSWE0TEpP?=
 =?utf-8?B?RzFrY0lSRVloOXJBdXRBNCs0bXJJSTlybkZad2hvZytWRWFaV3hnL0xkZzJx?=
 =?utf-8?B?d1M1RE9PTlJNdTg1VDN3bHFyeThFSDhFTzlTMEdvNUMzT2UxclY4MEdkUWlt?=
 =?utf-8?B?N1REUkhmdnI5enhROG5OTDZXTStaTzJqbkdXcmd4ZVBGcjBxeXhIL1NXVEJm?=
 =?utf-8?B?WnR4aEJXUnR1OGkwQnZkU1VCVCtqNTdWYVIxRWZQU1crbmNJaWVxQXZ1SnBV?=
 =?utf-8?B?WngvejdmbjYrWnR3QVYyNEk5RkZpQ0cxQVI2YnNXK2dabTlZWlAzSy96Vzl4?=
 =?utf-8?B?MWpMR2d0K1NseW9BcFNkL1NzVTNQL1lUU1Z6UkNUdXFiK2tucHdrUVpDbk9w?=
 =?utf-8?B?Nk9hajd1RmhkOUhyTXdoWkJiWmE1blYzNWtLd3lLaWdqSzhLQkYxaEkwTzdR?=
 =?utf-8?B?eENqUlRESElOSFZVMS9FU29ETHhmcU5EZG01SVBROWp6elJITkZ2ZHNjSndF?=
 =?utf-8?B?cEppdUhuajZ5ZGpnMEVWb3VNT2xrZzdjUDM0RjNyb1hNSHF4RStUOWNPT1VB?=
 =?utf-8?B?dDJXb3VLTDBXZEtKdWxjb0poSW55UXRKcU5aSWcwMnpxYjAzSmRxWWdpcWl1?=
 =?utf-8?B?Y1pLYjB3a1Q2S3YvWU9vbEgvb0FWNDZ5Sld4eks1Ky9PSjFaMDE4Rm1kMWxq?=
 =?utf-8?B?WkFVekpxN3lYUFpPVXNtTXY3UlJKc09DOTNRUzh4SmxMNHhJZnZ2dk5zNEtX?=
 =?utf-8?B?QzV4ZGVNMnZGLzUraExKT0JTUzIzN00vM0ovUzg5RmVOWlNCaXJ6Zm0wTHE2?=
 =?utf-8?B?UTdKdXZIRlZWdzc2d3NxMjBJdUliZGV0eUJsc2laRWE2UUxmc1dkSktiM3p4?=
 =?utf-8?B?d2twOGVBSDdkVlo4d1BxcXA5Z1FndmhweGxKZk94Sjc3eFlTdXhjd3FkR251?=
 =?utf-8?B?NGpCNG5zT2F2Rmx4UW02TC9iZXVTRjB1eVhsMitBVDNJZVhyaHNhZjlYNXBN?=
 =?utf-8?Q?F6BKIgzZEwW74v1H//fAqzkb16AgAY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 05:47:10.7579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f343d8-222e-448b-8a45-08ddc4f55fb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8122
Received-SPF: permerror client-ip=2a01:111:f403:2414::62d;
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



On 7/16/2025 6:59 PM, Michael S. Tsirkin wrote:
> On Wed, Jul 16, 2025 at 06:26:37PM +0530, Sairaj Kodilkar wrote:
>>
>>
>> On 7/16/2025 6:07 PM, Philippe Mathieu-Daudé wrote:
>>> On 16/7/25 09:31, Sairaj Kodilkar wrote:
>>>> This series provides few cleanups and fixes for the amd iommu
>>>>
>>>> The patches are based on top of 56c6e249b698 (v10.0.0-rc3) and
>>>> Alejandro's
>>>> DMA remapping series [1].
>>>
>>> 56c6e249b698 is 4 months old, we are about to release v10.1.0-rc0.
>>>
>>> What is the point of posting obsolete code?
>>>
>>> I'm not going to review further.
>>
>> Hey Philippe,
>>
>> sorry. I missed to add it in cover letter. Intention is to get feedback
>> on this series. Since this is on top of Alejandro's series, I will
>> rebase it once his series gets merged.
>>
>> Regards
>> Sairaj
> 
> Merged now, go ahead and rebase.
> 

Hey Michael,

Sorry, I should have mentioned which series I am talking about,
https://lore.kernel.org/qemu-devel/20250502021605.1795985-1-\
alejandro.j.jimenez@oracle.com/

I know Alejandro's cleanup series has merged. I was waiting for
DMA remapping series. But what I'll do now, is remove the patches that
depend on his series and rebase remaining patches on top of master.

Thanks and sorry for inconvenience. Will take care of this in future

Thanks
Sairaj

>>>
>>> Regards,
>>>
>>> Phil.
>>>
>>>> [1] https://lore.kernel.org/all/20250502021605.1795985-1-
>>>> alejandro.j.jimenez@oracle.com/
>>>>
>>>> The series is uploaded on github:
>>>> https://github.com/AMDESE/qemu-iommu/tree/sarunkod/alej%2Bcleanup-v1
>>>>
>>>> Sairaj Kodilkar (7):
>>>>     hw/i386/amd_iommu: Fix MMIO register write tracing
>>>>     hw/i386/amd_iommu: Remove unused and wrongly set ats_enabled field
>>>>     hw/i386/amd_iommu: Move IOAPIC memory region initialization to the end
>>>>     hw/i386/amd_iommu: Support MMIO writes to the status register
>>>>     hw/i386/amd_iommu: Fix event log generation
>>>>     hw/i386/amd_iommu: Fix handling device on buses != 0
>>>>     hw/i386/amd_iommu: Support 64 bit address for IOTLB lookup
>>>>
>>>>    hw/i386/amd_iommu.c | 217 ++++++++++++++++++++++++++++----------------
>>>>    hw/i386/amd_iommu.h |   9 +-
>>>>    2 files changed, 146 insertions(+), 80 deletions(-)
>>>>
>>>
> 


