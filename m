Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E06C282DE
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Mar 2025 09:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttkZ1-0000zP-Pl; Sun, 16 Mar 2025 05:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ttkYu-0000yw-2h
 for qemu-devel@nongnu.org; Sun, 16 Mar 2025 05:45:40 -0400
Received: from mail-mw2nam10on2062e.outbound.protection.outlook.com
 ([2a01:111:f403:2412::62e]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ttkYr-0004Fb-Mj
 for qemu-devel@nongnu.org; Sun, 16 Mar 2025 05:45:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzEmpcvZLTDIyUeZNN7+y+1VRKup4U+QFA80abvJ2VF/XPvNbRwbvTMG1yTXVLQko4KfVD1EtXcQFEVt2BzAn2WbTMMAoyZAkIntrHT0UY0koBjn3YrT46t0tK7A8sw7nsT13ZjoCinKRfYMHSOesYM6yHwQ4xIAq5sV5nAoH3OfpRcgkb8D3HGphEGVPREpkUM/xqO9YQk5+wybWuXUQ/4HBC+pQTlfT0equzO3EIUP3MSthXQEUfYAZ/5pg7aLtMmh7zeCky6kImHr+DipN8lNLQBGNIYnfRNVuwtlhhtgMUXtZqoUlDqrxYXsH74QqJEluuIZ0at6SHZFlWJPyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0agkIFpsISdZZDpavNnfjpsq00GJ21xAG8IDOnHuIAE=;
 b=AefRty4h60RCUu0F2BVa2q/MX0BLx59yj1qB7dHWhaCZ5EmE6dhSOxNve5Qq+UB9Zxw5yDwlYlGmTw1dbef3ou0lEDs+ntQD0cht6KvjMchjTflb7NwIAsyQReCiQkIJu5wVZ0WzZ5XbK2FHllyV8VUzwd+1XpEouV3v1cU9BBA5EavPVNjo0RIiZDeyrjbFBsgfUkMVF7rw8V+b0fg8leGqs0I4rCMYORWm1932FTpYyQQx08kmELYLRA6OtmXuiJ/hZbLp8SQSXnyAwHZMnYeLtFtFevTHQtwFNI5nrbgVh3OJpsXB5uQ9eekB0fJxten3Bm7mrQmWg1yt/Trjqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0agkIFpsISdZZDpavNnfjpsq00GJ21xAG8IDOnHuIAE=;
 b=URPYd1gAhbtymer5PyrOsJ1DOsi+v015zXZk6i29yuiEkYpBUYaW/zgFpqHuDjUZ9B4NaOC9JgUwUpAZ9pZFYb1geP1Z25wBgfAn0xLzJj/ou40vS1fnAGAbKcDaaLkZTNb9lu/gvvUNOd+u4urmNvAVnFi9jQGczZBqu+JMrKM=
Received: from BY1P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::9)
 by PH0PR12MB7472.namprd12.prod.outlook.com (2603:10b6:510:1e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Sun, 16 Mar
 2025 09:34:24 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::9c) by BY1P220CA0024.outlook.office365.com
 (2603:10b6:a03:5c3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Sun,
 16 Mar 2025 09:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Sun, 16 Mar 2025 09:34:24 +0000
Received: from [10.252.206.76] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 16 Mar
 2025 04:34:20 -0500
Message-ID: <a6a1b0d3-7ab4-426a-a8ee-8934dedb9ae0@amd.com>
Date: Sun, 16 Mar 2025 15:04:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] amd_iommu: Update bitmasks representing DTE reserved
 fields
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <mst@redhat.com>, <mjt@tls.msk.ru>,
 <marcel.apfelbaum@gmail.com>, <vasant.hegde@amd.com>,
 <suravee.suthikulpanit@amd.com>, <santosh.shukla@amd.com>,
 <Wei.Huang2@amd.com>, <joao.m.martins@oracle.com>,
 <boris.ostrovsky@oracle.com>
References: <20250311152446.45086-1-alejandro.j.jimenez@oracle.com>
 <20250311152446.45086-4-alejandro.j.jimenez@oracle.com>
 <0be5765e-2ade-4743-a089-0846f60943dd@amd.com>
 <0e4993c5-33d8-4dfc-8089-0efa50881f8e@oracle.com>
Content-Language: en-US
From: "Arun Kodilkar, Sairaj" <sarunkod@amd.com>
In-Reply-To: <0e4993c5-33d8-4dfc-8089-0efa50881f8e@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|PH0PR12MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d13f073-0f4e-4dc8-07e8-08dd646dbcff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDhTZVoxUTczUDlYU2hWYllrM1dGbmkwQmQ1NzVUdjAvMGV3V1VENjg2Y0F6?=
 =?utf-8?B?OE43NnZJU3B1OGVmN3VRcm5ud1NsVjU0TEFqSXlnKzVQbERSWm13M2xVVDUy?=
 =?utf-8?B?SldGanN5Nit3bjJ2WTJpNG4waVl4Z0NHVjVBd2tKTCtIVThlMHNKb3FRV2di?=
 =?utf-8?B?SFY5VHlPN3dKclM1S2ljQTBrNnVSUVdScE5BUnMydnBMRW1HODZLWEJhLzht?=
 =?utf-8?B?TzJJZWRkUUtRTTMrMEt5UlQrbXVqR2k0SzB5QmFZYnlNamdGdnNBLzVWN2VW?=
 =?utf-8?B?eVNTbGZ2MS9CMkZGeTB0OGFwUVRFSmhwQ1FaNWNmbTJmWmhJaE5qa0prL1Za?=
 =?utf-8?B?TDdsd3N4dFNUb1ZxZVJVNkhvcDB1elZ4WmxTemIwaERYK1pSWmRHUWZ5RkVq?=
 =?utf-8?B?c0VrdVRMWUcxanZaQ0s3L3M5MnBocENQUmZWdWl4cmxZVVQrVC9nQUNadjV6?=
 =?utf-8?B?SStsUU1WdEtFbktIbEJsQ3Q3YmwxZ3pEckJ2WVloRHJxWDNBQjVybnR0dkpG?=
 =?utf-8?B?NkZQblhYZFdacXpOZExNR3F0QU1sSFBaQy94OWd1dHZ6T0l1YnNRMVZIcmVn?=
 =?utf-8?B?NzU5d0M4Y1ZXZkVtVDdzdFhSVHRpK0phM1MvR2Y4dDBZS3VMd09PVU5YR3Ux?=
 =?utf-8?B?b0YwUld0NUZvdTFMQ05kNUlIUUFLcU1KRlJjYnpQSnl6MW1oVkN2cHkwVFBX?=
 =?utf-8?B?dU9VVWZUaS9KZTZYMHpYTTRqM2Jod2dPbWdYWWFwNFNFQXZSUVZsUFNQQW1w?=
 =?utf-8?B?eHpLQXdSNWsvVWl0bHpyY1graWdsNGJkT2xFT083RHI4NUltd3RVTW9VcEQ0?=
 =?utf-8?B?K0UyS244cnV4RFFyN24yUE1pOUo2WHAzMUQxa1NvOEhtTzI1SGQ1dUhFTkNr?=
 =?utf-8?B?TG45cm50bG9GVnQrczg3NExqRlhuNzJ1MGNDdVl4QS9jNGdhYVBhOThUb3VO?=
 =?utf-8?B?TDdzb0tCTzdDZ09XUm42cml2UWJIRmdibnFjV0dsQW1KWTF0MjI2TmgxRmtv?=
 =?utf-8?B?azhDREtFN0JROTNzQ1JyR01wOVVGYU5KYzdUazZNaWEvd3dtK2xiSXpiTktD?=
 =?utf-8?B?aDhWazduS2w0bnhGZ2Rka3NqdkVjeWVxamFPWnE1bUFjMXhrcU1hMXBhVU1s?=
 =?utf-8?B?c1pCUGNjMUF0bVNOeEdWU1RVdDRiTldYc3EzYjRqZEM1V0w2bEcyWmJGeXc2?=
 =?utf-8?B?UklkNHdjbjZ3TnZ1dHd0MVdYUFhNWjNSeWhOdi8yeVpRemZTanBYd21BWnpR?=
 =?utf-8?B?UVBpUytnSWh6WTRkZXhURXBuTVBxOG11L2RRU1ovVERnMjdYazVZNng5bzZB?=
 =?utf-8?B?bUlWQ3hZc1puSHNsZnJ5TWU2bXhjWkdHdE53cmVRWWgwKzBwZC9neHplNkVm?=
 =?utf-8?B?VGxQZlkvcUZBKyt4QWdlcGN3UGZYOVNURkZ6THNYQTlLWjRsWTdSOEFKRDEr?=
 =?utf-8?B?aUhJWVMzeW9lMHRTRUxBWEZHMVorMjlWdVJqYlNZWi9DRURXMURuNnZxTDRK?=
 =?utf-8?B?SkRSRUZDVkJaV09RMGVzVjViaVJ3bzRCbVJ5bUJFQkMrajg5dm9QV2JDREdt?=
 =?utf-8?B?QUNWUTJWb1JBalVtN2NhbTZVQTBzcVhRdURqWXpVN3g4cVhHNy9sUjY2WVZ2?=
 =?utf-8?B?eTZyWnp3QnFhYkI5NFN5UkN5dmRrS3lDb2Zic2wyMjJJTFA0bzlWcGppYlV6?=
 =?utf-8?B?Unh2NEFaSVBSVE50WXQ2NU1ZbEhJS0F1Y3lQSTkwSXVyNGVaRTRJYTU2bFhh?=
 =?utf-8?B?YWpQbEN3Y3gxTGRHa0NDSUV3Vzlsclkxd1U5T1FaL3JRRVEzT0E2TUxaVVRX?=
 =?utf-8?B?Z0d5c3NMRWRsYldIT2tMOE0yZ0d2QUtiRk0rSkxjYm9seGNCZDIwd0IxSG50?=
 =?utf-8?B?Ly9wS3Zld2NXcXkxYzdJSzRYbmRJRWNHYW8yN2tESEpHRmtFdFQ0ZGI2WkdP?=
 =?utf-8?B?K1JnbUJmTGs2MFluUjRhY084bmx5YjFTazhrajdadmVMdVFtWHkrcmV2MVFD?=
 =?utf-8?Q?5qkqTeCAVtkhcNbuRaKGfy33FnVYjg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 09:34:24.0271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d13f073-0f4e-4dc8-07e8-08dd646dbcff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7472
Received-SPF: permerror client-ip=2a01:111:f403:2412::62e;
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



On 3/13/2025 7:53 PM, Alejandro Jimenez wrote:
> 
> 
> On 3/12/25 12:12 AM, Arun Kodilkar, Sairaj wrote:
>> Hi Alejandro,
>>
>> On 3/11/2025 8:54 PM, Alejandro Jimenez wrote:
> 
> [...]
> 
>>> --- a/hw/i386/amd_iommu.h
>>> +++ b/hw/i386/amd_iommu.h
>>> @@ -25,6 +25,8 @@
>>>   #include "hw/i386/x86-iommu.h"
>>>   #include "qom/object.h"
>>> +#define GENMASK64(h, l)  (((~0ULL) >> (63 - (h) + (l))) << (l))
>>> +
>>
>> qemu provides the similar macro 'MAKE_64BIT_MASK' in file
>> 'include/qemu/bitops.h', you can use this existing macro
>> instead of redefining.
> 
> Hi Sairaj,
> 
> I became aware of MAKE_64BIT_MASK() because you used it in your recent 
> patch, but as you mentioned they are similar but not the same. I 
> personally find that using bit indexes is less prone to errors since 
> that is the same format the spec uses to define the fields.
> So translating a RSVD[6:2] field from the spec becomes:
> 
> GENMASK64(6, 2);
> vs
> MAKE_64BIT_MASK(6, 5);
> 
> The latter is more prone to off-by-one errors in my opinion, specially 
> when you are defining lots of masks. Perhaps more importantly, I'd like 
> to progressively convert the amd_iommu definitions to use GENMASK() and 
> the code that retrieves bit fields to use FIELD_GET().
> 
> I am planning on later porting the generic GENMASK* definitions (from 
> the kernel into "qemu/bitops.h", since the RISC-V IOMMU is also a 
> consumer of GENMASK, but I am trying to keep the focus on the AMD vIOMMU 
> for this series.
> 
> Thank you,
> Alejandro
> 

Hi Alejandro,
Yes indeed, GENMASK64() is more readable than the MAKE_64BIT_MASK().
and Since you are going to port it to generic layer, its better
to use GENMASK64().
Feel free to replace existing MAKE_64BIT_MASK() in my recent patches.
otherwise, I can modify it during next patch series.

Regards
Sairaj Kodilkar

>>
>>>   /* Capability registers */
>>>   #define AMDVI_CAPAB_BAR_LOW           0x04
>>>   #define AMDVI_CAPAB_BAR_HIGH          0x08
>>> @@ -162,9 +164,10 @@
>>>   #define AMDVI_FEATURE_PC                  (1ULL << 9) /* Perf 
>>> counters       */
>>>   /* reserved DTE bits */
>>> -#define AMDVI_DTE_LOWER_QUAD_RESERVED  0x80300000000000fc
>>> -#define AMDVI_DTE_MIDDLE_QUAD_RESERVED 0x0000000000000100
>>> -#define AMDVI_DTE_UPPER_QUAD_RESERVED  0x08f0000000000000
>>> +#define AMDVI_DTE_QUAD0_RESERVED        (GENMASK64(6, 2) | 
>>> GENMASK64(63, 63))
>>> +#define AMDVI_DTE_QUAD1_RESERVED        0
>>> +#define AMDVI_DTE_QUAD2_RESERVED        GENMASK64(53, 52)
>>> +#define AMDVI_DTE_QUAD3_RESERVED        (GENMASK64(14, 0) | 
>>> GENMASK64(53, 48))
>>>   /* AMDVI paging mode */
>>>   #define AMDVI_GATS_MODE                 (2ULL <<  12)
>>
>> Regards
>> Sairaj Kodilkar
> 


