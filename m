Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FAAC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 06:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucIMq-0007L4-Ty; Thu, 17 Jul 2025 02:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ucIJ2-00032S-Kp
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 02:41:31 -0400
Received: from mail-co1nam11on20626.outbound.protection.outlook.com
 ([2a01:111:f403:2416::626]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ucIIx-0001ZM-Uo
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 02:41:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=POnx9033/Tmk4p1PggA7yHOvVKqClrXUDJLhiJWxBqWDSv2X3r3Dd3ynWM3dBKH/8/so7alpr0rZ05oVIk5ZaEhR8vLwtApQHhLuqqZgRenOPtqLHkNg5Op+llQjObbjqBZYy8edOW1/9cezspIOgmshU5foG514QVji/T2vTxk9ZV5Y6Wk3G707XTgo0fh2avDGwKsN3piP/3zJqtE6Y5MyFb2TKgoVgn26ATFYeXlzGIYb4f+siMaOXzqCBLLF1DXNrK3acssM1RJcdruHJe4w84APi/q8kn/ut6AZ2UViaJvfycloaag8mYpifs6n6GWxyeeZx5K01c3Ed8DUXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WMR7qdGOoEZrIUitDWuFJuTpYst7eUCipOOizg705E=;
 b=cmlrxABTDb8jh7euwuEMZcfj8eQxUftgC5Ix1wXUrd7g7ycsnyQI5HY4QYofsutfVtRax+WbAgHkOWJO09r5xLmHN3j6oigXoESvWMv+zJ11DSB7IjhQD4jyHBj6nb7a07JOhuEzqi2zwh4iGWrNsSovKjGbdmdt1kJf/6IkctHX4S7Nv5DTJV/k/+NKsCiQlYyPKB/wLIAdKyJ02zurc5tHlLdcS3FmImODrrYGNSsiOLvhZ50S0iKm0aN7q2Cj4ujxuF916ArAsDnxnqcCNPUT0vlgJ2w+P1Y3Hi+4N3flp0DVYiG9IXeJJU1jWRPmxT8wfBtJzr8CdjavcpQ46Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=eviden.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WMR7qdGOoEZrIUitDWuFJuTpYst7eUCipOOizg705E=;
 b=IqXgAtwpIaY0snHV7RIJIqvkVJJ/8WtAq09GSc63S88nY7PGfkk1c9KtaXF8Z0pRD9+oO0Ass5NqMMNhAD4QyuGMWN54gSZUASWlLKjD/56EJSFXmbEvOO7uKGT0cGE/5+swi1UXUufGTJLup2Vcb8rE3LotyriJRVrgavPe1S8=
Received: from SJ0PR03CA0064.namprd03.prod.outlook.com (2603:10b6:a03:331::9)
 by MN0PR12MB6367.namprd12.prod.outlook.com (2603:10b6:208:3d3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Thu, 17 Jul
 2025 06:41:11 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::40) by SJ0PR03CA0064.outlook.office365.com
 (2603:10b6:a03:331::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Thu,
 17 Jul 2025 06:41:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 06:41:10 +0000
Received: from [10.252.206.76] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Jul
 2025 01:41:06 -0500
Message-ID: <e1f6986d-a7fc-4cf1-937c-62a7b6128fd4@amd.com>
Date: Thu, 17 Jul 2025 12:11:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] hw/i386/amd_iommu: Support MMIO writes to the status
 register
To: Ethan MILON <ethan.milon@eviden.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "alejandro.j.jimenez@oracle.com"
 <alejandro.j.jimenez@oracle.com>, Vasant Hegde <vasant.hegde@amd.com>
References: <20250716073145.915-1-sarunkod@amd.com>
 <20250716073145.915-5-sarunkod@amd.com>
 <0ae88a3a-be70-47b3-9829-fbbb0dfcb8ab@eviden.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <0ae88a3a-be70-47b3-9829-fbbb0dfcb8ab@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|MN0PR12MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d862e7c-d892-45d9-8690-08ddc4fcea91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWZqbHlDTFJPc1NWRGhJTy9BVkZFZDVpTHY2dzUzZy9OSHFscnpNUzhMUmhl?=
 =?utf-8?B?em1sdmRGNU5TTFBrMDJpK3RHVGZkTzE3TFZWNFhibnJHRW5XUTlnNHZNRFVi?=
 =?utf-8?B?K3F0cHloejMxN0JYTFFYaGx0enVKRkdWc0hMTCtUSVJBTEJSUHFHbXVEd2Y5?=
 =?utf-8?B?aWp6ZGtZTWZ0ZXNad1JGVEhhK3Jqb1BqWXFBSW1CUWVobkhGYVROenA4VkpO?=
 =?utf-8?B?N2swd01XdWVDbUdYNlNYQ3NSdjBsY2F3NXczdm9KcUYrWDdCckJwWTJYWjVl?=
 =?utf-8?B?UFJIN0xmUWk1Smh0OGJOWndYdXBocVVlT2dCYnkxdzU2UUZrTXljc202clRt?=
 =?utf-8?B?Vi9sbFo1bDdUSEgvRkJ2VElqNHhWdVRVN0hFWUZibnNmbHlVNTRLTkdXOE5S?=
 =?utf-8?B?ckZnWm16OWFSRkNITWNSZUpGUjBsTXR0dUR0S3JGb1JGbXNVZ2txSDBiSTFS?=
 =?utf-8?B?SEZId3pEa200cStCWG5aSldNTlk0aFRscFlMWkVkemw2TE5jWHA0MlkzRzkw?=
 =?utf-8?B?SU02Tk5tV1VWVmZKaWh5TTJCckhGQjBqUStBSFBUYUhvMEQ3dXlNYkN5TnI2?=
 =?utf-8?B?NkxVZkFpTnBvK1NnVE5oeDA1enZ2Q1JhcllBbUZnOHArbVNwSUZJSnhFUjlS?=
 =?utf-8?B?RUpFM1l4bHU3ZXhUVEQwTmJHVDVTdlR6c2pOcFJQSDhCQ093YVhKeUFVUkhD?=
 =?utf-8?B?MU9qZDJIc2tTekUxN21LTjdkdlcyeTlKcWgxUzJXc1BsQ1ZHVStZTEowV2lN?=
 =?utf-8?B?M0Y0bVBkd0pNb1FLRDVKc2Q1eitzUko0YlRCdW9kQ1N2cUljeG11bTUyaVNS?=
 =?utf-8?B?dlpUZGVGVFZudjZDSXRHWUROb08rOWhBSGpuWHJwRjRoUkhocEpYb0RRY2Zl?=
 =?utf-8?B?cFFFZm9aN3RGUGR3R05GUmdHRm00WVFmdndBU2Rwcm5PeEkzQWorSlY2Qmh5?=
 =?utf-8?B?NnVVVjJsRFQ5THI4RVVnM0RqN09CbnArVENLYk1JM3A1Qmg4V3M5cGN6SjRT?=
 =?utf-8?B?UUtKSGY1b2FYWXZiQlMyRC96RXVMbW1kdWIxZzVrWUFWdGRyc1VZQitDb0Mr?=
 =?utf-8?B?bVYzRmZKOVBNQldmYUVTOHZUWFk4VWp6bnhVR3l5Z1FkM1FDQjQ3OU5YdERI?=
 =?utf-8?B?ZHNKS09XMElZWHRHNUdJa25kWFZ0WG1vZkVOODQ2Ky9RWGVmempyOFltdUo0?=
 =?utf-8?B?U0FTaXUzWUk4MCtUOHRFK1dnOHQ5TjkxUUJsWEVuWjAvUjM4VitRRGpDcGh2?=
 =?utf-8?B?RDJEdnFmVlJyS0ZUR2xicDNSa2dLcUpwbnZrMkNDWElEOU5kSUd2M2xQR1BD?=
 =?utf-8?B?NDZQaVFqTWpXSmJLRFJhSFJrdlpIZXFUSi9rNkgwRFlOOHh5dzFja0lid3RB?=
 =?utf-8?B?UkVybStXZTlsVlhtZzMwSisrWk9aRUxydnJLSlAzd05lM2dHbllqNjFUQ1Za?=
 =?utf-8?B?cHJ5SkpHR28yejFRMlp2ODFZeVlEWkVZYzg2WFcrYjFvcXlsMEd2NFpNcHc4?=
 =?utf-8?B?U25zemxrczF4VFBLTFpLeGVKOHIyR0lwVDVUQmczb092WU9BTzNmYTg0WXYr?=
 =?utf-8?B?cmVXMWRzbm01Z3dBS3BkY2ljZVlHQWJZSHhtczZuNFE0U09aeFVLSkhyNUk1?=
 =?utf-8?B?RkpMNEp4bXlVUkdvMDRsMzRPWTdtNVB5SXRuVjd6SGMzTGxqVG1vVm4zbTkv?=
 =?utf-8?B?ZDJ5MGJsMXZOdXFnL3ExRUZHMTd0QnpTQnNnRUlDNVNPbXN0OXJlbWp6d2Ix?=
 =?utf-8?B?d3luR2l3WDBOcFhvZnNBZWo4aXhBeDA5OC9TeXRTY2RJOFhIZWJFQ09LUWNQ?=
 =?utf-8?B?emJ2Y3lVd21Ed2tZRmcwWExxZFNPVGZyQjlMS2tpZjRnem1FME1tTzFBWkpV?=
 =?utf-8?B?Q0RwWDg1THBYMjlIeHVWODBjOFp3ckhtZHFHaHM5WmF3NU9ET0Jnck1NZzVr?=
 =?utf-8?B?Qksxd1JteDJxLzdlSE4vd0FRMDc1ZHFHVVBpaEVHR0VoL056UTl3TUFGMlJv?=
 =?utf-8?B?eDlnN0t2aFFMeURhbkZzem1DOTJFTXdDSks0WE5WOTJ6djJJMHBFTlVUb1ZN?=
 =?utf-8?Q?TB4Qox?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 06:41:10.1248 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d862e7c-d892-45d9-8690-08ddc4fcea91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6367
Received-SPF: permerror client-ip=2a01:111:f403:2416::626;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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



On 7/16/2025 7:57 PM, Ethan MILON wrote:
> Hi,
> 
> On 7/16/25 09:31, Sairaj Kodilkar wrote:
>> Support the writes to the status register so that guest can reset the
>> EventOverflow, EventLogInt, ComWaitIntr, etc bits after servicing the
>> respective interrupt.
>>
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>   hw/i386/amd_iommu.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 784be78f402d..e0f4220b8f25 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -1613,6 +1613,9 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
>>           amdvi_mmio_reg_write(s, size, val, addr);
>>           amdvi_handle_pprtail_write(s);
>>           break;
>> +    case AMDVI_MMIO_STATUS:
>> +        amdvi_mmio_reg_write(s, size, val, addr);
>> +        break;
> 
> This fixes the basic issue with interrupt reset, but there's still a
> subtle bug: any update to the status register clears the interrupt bits,
> regardless of the value.
> 
> The current W1C logic looks like an incomplete copy of the Intel
> implementation, and only works properly if the W1C bits are also set in
> romask.
> 
> We should update romask to include w1cmask, either in amdvi_write[wlq],
> amdvi_init, or directly in amdvi_set_quad:

Yep, verified it. The correct implementation of amdvi_set_quad should 
have (oldval & (romask | w1cmask)).

Thanks for pointing this out.

-Sairaj

> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 66d42f..48d991 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -213,7 +213,7 @@ static void amdvi_set_quad(AMDVIState *s, hwaddr addr, uint64_t val,
>                              uint64_t romask, uint64_t w1cmask)
>   {
>       stq_le_p(&s->mmior[addr], val);
> -    stq_le_p(&s->romask[addr], romask);
> +    stq_le_p(&s->romask[addr], romask | w1cmask);
>       stq_le_p(&s->w1cmask[addr], w1cmask);
>   }
> 
> Thanks,
> Ethan
> 
>>       }
>>   }
>>
>> --
>> 2.34.1
>>


