Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713C3C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 08:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugJ8S-0006zH-6C; Mon, 28 Jul 2025 04:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ugJ2J-0003Kk-Vn
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 04:16:45 -0400
Received: from mail-dm3nam02on20628.outbound.protection.outlook.com
 ([2a01:111:f403:2405::628]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ugJ2F-0000PI-E3
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 04:16:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6QEgxPbHG+3k58793CbVNFBqyMHrSoeYRSitEserAjWloIGjM0j3IXQsPjC0Z5VPHdyHU4oER16ovInw9I2g27vJLX1TVwEGZslg5nlXw1Z+c0vLgYI93wFrHlcr2zqb17wkelTok8BX9Vfxv8Zc71nM9YKhVnD6a8Qy1K9AcuvRQlyhHhCy8DG+I8fkMjOFP+HzqLN8yoqM3+TIRAxFVBTpDVGF7eCfMdkuFHSIfxR72ukCTQ7bihCAafV71N9AaNuZmFYjzhJz3VGLne/8BDGgS5t9HlQ7UsNeZtL6M5eNDUzc60gnTCDZ3bw/lIQvWfxXW2O12EMjOfcRcHgmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ET2BiLy/19mme5W7+GcbyYAbB0K73WHWFUlGv6KUxc=;
 b=Qs1q1G/86/JbPg9lnBwMsh+1GGFpOoeu5k8MwCIAdD/cnRBI+ZfNz3uGHpLFwh6VKHX+d/tLo4ry1qk6+hR/gs+ccIBeQOEGvNbGk7HB3q9H+v4FDpRuAsCthRb1o2y9tkBzaEtDHK8bW05Btm3d5k1XwjhBu3s+Ffo5wn8Fk5qsqkrYuufPZ/L6RhnLJ2UoKHdn5V2yp55cFBrS6PfUTl9AMFBLwu/Uut3pHI38dcFP00rJ9UTPORAIK+caGfonvOouTnLN1BBjxdq5mAVIOZvhLd4ZE1kaa9RrWdrIweavmrkO2PcFVzqmpGe1530wDoLEfHQG+8Avkf17oCUYqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ET2BiLy/19mme5W7+GcbyYAbB0K73WHWFUlGv6KUxc=;
 b=uFMkkg3Xsw7M145miEkmzYh43m1mh8K8CjGXmYymefLbJKxn1egzfietGzDBwjBiynE1ShR4RSBK/hs85KEVe8QnYRNggGQOAQeKLWUbkOKW7mfJOCPMO5WlShbGGnBIDHafzwRa62nz9dIhriWL77uZ126Q6OaQuVBr+XWukGw=
Received: from BN8PR03CA0026.namprd03.prod.outlook.com (2603:10b6:408:94::39)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.26; Mon, 28 Jul 2025 08:16:34 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:408:94:cafe::74) by BN8PR03CA0026.outlook.office365.com
 (2603:10b6:408:94::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.26 via Frontend Transport; Mon,
 28 Jul 2025 08:16:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Mon, 28 Jul 2025 08:16:33 +0000
Received: from [10.85.34.242] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 03:16:30 -0500
Message-ID: <905f4467-2294-484e-b27b-ed3dbdef6bd3@amd.com>
Date: Mon, 28 Jul 2025 13:46:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] hw/i386/amd_iommu: Fix amdvi_write*()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <richard.henderson@linaro.org>,
 <alejandro.j.jimenez@oracle.com>, <vasant.hegde@amd.com>, Ethan MILON
 <ethan.milon@eviden.com>
References: <20250724064745.4091-1-sarunkod@amd.com>
 <20250724064745.4091-5-sarunkod@amd.com>
 <a8f89dfb-31a1-45f7-b67d-a54ddccf5e34@linaro.org>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <a8f89dfb-31a1-45f7-b67d-a54ddccf5e34@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: dd3040cc-b93b-452a-cb70-08ddcdaf10a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXpDZWZhZkxmL050UGJLTlRUdkRrNUJJTFpkTGJ2QkNwYW5WOHFpSWJJOE12?=
 =?utf-8?B?T3I1RlVmRTIxYVVHWWtGNERjUWx6MWlhSmFVQzVZVDJaS1N4QnozMCt3RjFU?=
 =?utf-8?B?NGFwY0dGeXFGSHFuTVJoSGxXK3p6ckJiQnprVnB6OVNJa0trNGlJSHZnTjZ4?=
 =?utf-8?B?VTdJdUZuVzlWQ2hlbURPOFNUYVpwMG4xMU9mRFdNbHRGY3JiSHI1YUlsQUx5?=
 =?utf-8?B?RUhUV0N1OGFra0wxS202c2JSdkIxanpEbmdiS1JGSnhZK0J4aWRrOWdSNCtO?=
 =?utf-8?B?SjlsUEtFakN2ZW5HMWJDRUg5K05VTm9xdnZYODFtOXpBUURXZ3hqS3JYZTd4?=
 =?utf-8?B?Y1FnZzRhVVkzRGFraXpnOTR5OHNFOTRVVEQzVTgxNUJlVnhjdXkydlBTZldY?=
 =?utf-8?B?eDBuKzlJRFVZVjk2S2NRQjk2WFQ0aVZSc010dzlYOVMzQ3JBQ25SaEVYTlU2?=
 =?utf-8?B?d1ZFTUp6RG9FVlVOeXQxZVdhYnNVTGhQNXRHMEY3ZnRBRTRIMExEOFlPWlpP?=
 =?utf-8?B?eXBEQWRpYVFJcEVaeWZSTnJvRmY0WnQ5VUpOQis1K2FJd1l6NjA2ai9qTUw5?=
 =?utf-8?B?aldseHN3VWdxbU8vamJyNm0xTTlYOHdYS0tnTDhFMjNuUTZzeFBZSmk4MDFN?=
 =?utf-8?B?ZWUvSHd5di9FR0tpdHFpS3BTYTN1VGZURC92QXpaNmQwTnMvcHVPVVRqK3VX?=
 =?utf-8?B?UVJOV3FtR0szbE5BY2QyREJrRndmRm9CNHluUmo2ZkVDY2lGUWljZGsxMktB?=
 =?utf-8?B?czBpd0o2NU5hSURNSXNXS2RSZ1RwaVRoQ0NrS3RaZ2wyOHk0bmdhL3pGdVdx?=
 =?utf-8?B?dERiajNPOUE5NWRPRFptR1hwVFhSQkZLS2FHY2FqMEQ4SmFjOWJCYVVkTDh2?=
 =?utf-8?B?VFVxbCt5NnhFZjlFMlNJWnNlVy9ISnNRVE1zM0ExNFBmbkU1U0F0enlMKzgv?=
 =?utf-8?B?YXFMbkJmT1lmTkR6d0hUWEx3b0J2a0FZTE1waUlRVDl4Nk1tL28yY1hoVCtt?=
 =?utf-8?B?SG1uNlplc292d25RTnNtbCs2NlpwMFdMVEROOGtQOHpQZ21DRmJLWlAvd2dj?=
 =?utf-8?B?SmRRZDgwS0VrWHVUSmkxaml3enNwREZweDhQaWV6aUpGd2FwTzhTSXJxUDRO?=
 =?utf-8?B?cWxmbVRlZWJuN0VHNlV5a2QwRlhDSlhSRGVsMDM1a1hJUTNFQU1ia3JBS2RG?=
 =?utf-8?B?L0d6VGJrZG5FVGNFVlp0OGh5SktWdG4rR3VPeEtWdmpvTE9uVDZLelR1TGdn?=
 =?utf-8?B?eUNyczFpVE1KVit0b3M2MHdOVEVzeUR4L1U3MG8vV0dydXlVbVZtOG5Wckln?=
 =?utf-8?B?ekd5dEx1Y3l3a0hvVTlRdDNFYmVPZHFiQlBnWFloMGRNL040REdvSXBMcFBv?=
 =?utf-8?B?OWZkendVcEJjWlhXSU1wY241aXJZdWcvRDJwMG1CSEVSQlFLWXRERlF4QWNB?=
 =?utf-8?B?ajRKZnAyNWwvWlh5Z1VXTmR6czFLSWlJeXhuQXZxdlA5eE9jZ3hGblNFcGM2?=
 =?utf-8?B?VWRyRWhkZjFmUjhkZS9BS2Jwd21IVkxTM0FtUlFEbnk5OFFtZFU2OWRtcFlN?=
 =?utf-8?B?MVgvMUxyTW9RNlRpdlZWQ2QwbW90Z2VsUEdYOEtORlVHZHNDZFZZSUZRV2lN?=
 =?utf-8?B?UUZSME0rRGQxWDBpeEZNSlphR3VjVG5va2ZnODZpdkFFM2NoWmI3R3dCUmhJ?=
 =?utf-8?B?NFBiTk14a25zaUtIOUVobFJjVFhnaWUyQUNkdmpvMndRK0dXdVQ3U2pzRjFt?=
 =?utf-8?B?WU84TFcreUQzeEVuNFZWWmpVK0tTaUhrZFBQRjRTZSt2akV6UzNKVlRDS1FO?=
 =?utf-8?B?R3MxOENhZUNFRktVMTYvaGVHZDIwaGNEY3k0aFYzU3R5R0h0ZzJHdzdreDY4?=
 =?utf-8?B?a1FOTXZ5dDFiMzI3QUxQOVBLSHpiaHU2OHJjc1I2alQyUThWQ1o5THdMZDBs?=
 =?utf-8?B?TENXUkZXeHk5bDhNdlI1dWg2QnFvKzByWnZxOFlvVHBqaW1qcWhYWllVNUQ3?=
 =?utf-8?B?bUZGTStGWkpwU1VyQVA5Qlo3VEFPQkRrNzlYQlA4NUtDeXl6UkpBcFBqOUNV?=
 =?utf-8?Q?3VdYXj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 08:16:33.8439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3040cc-b93b-452a-cb70-08ddcdaf10a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392
Received-SPF: permerror client-ip=2a01:111:f403:2405::628;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
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



On 7/24/2025 2:20 PM, Philippe Mathieu-Daudé wrote:
> On 24/7/25 08:47, Sairaj Kodilkar wrote:
>> amdvi_write*() function do not preserve the older values of W1C bits in
>> the MMIO register. This results in all W1C bits set to 0, when guest
>> tries to reset a single bit by writing 1 to it. Fix this by preserving
>> W1C bits in the old value of the MMIO register.
>>
>> Fixes: d29a09ca68428 ("hw/i386: Introduce AMD IOMMU")
>> Suggested-by: Ethan MILON <ethan.milon@eviden.com>
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> ---
>>   hw/i386/amd_iommu.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 2183510d227c..bbffd07b4e48 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -124,7 +124,8 @@ static void amdvi_writew(AMDVIState *s, hwaddr 
>> addr, uint16_t val)
>>       uint16_t w1cmask = lduw_le_p(&s->w1cmask[addr]);
>>       uint16_t oldval = lduw_le_p(&s->mmior[addr]);
>>       stw_le_p(&s->mmior[addr],
>> -            ((oldval & romask) | (val & ~romask)) & ~(val & w1cmask));
>> +            ((oldval & (romask | w1cmask)) |
>> +             (val & ~romask)) & ~(val & w1cmask));
> 
> High code complexity, hard to review. Do you mind introducing
> intermediate well-named variables for clarity?
>

Sure !

>>   }
>>   static void amdvi_writel(AMDVIState *s, hwaddr addr, uint32_t val)
>> @@ -133,7 +134,8 @@ static void amdvi_writel(AMDVIState *s, hwaddr 
>> addr, uint32_t val)
>>       uint32_t w1cmask = ldl_le_p(&s->w1cmask[addr]);
>>       uint32_t oldval = ldl_le_p(&s->mmior[addr]);
>>       stl_le_p(&s->mmior[addr],
>> -            ((oldval & romask) | (val & ~romask)) & ~(val & w1cmask));
>> +            ((oldval & (romask | w1cmask)) |
>> +             (val & ~romask)) & ~(val & w1cmask));
>>   }
>>   static void amdvi_writeq(AMDVIState *s, hwaddr addr, uint64_t val)
>> @@ -142,7 +144,8 @@ static void amdvi_writeq(AMDVIState *s, hwaddr 
>> addr, uint64_t val)
>>       uint64_t w1cmask = ldq_le_p(&s->w1cmask[addr]);
>>       uint64_t oldval = ldq_le_p(&s->mmior[addr]);
>>       stq_le_p(&s->mmior[addr],
>> -            ((oldval & romask) | (val & ~romask)) & ~(val & w1cmask));
>> +            ((oldval & (romask | w1cmask)) |
>> +             (val & ~romask)) & ~(val & w1cmask));
>>   }
>>   /* OR a 64-bit register with a 64-bit value */
> 


