Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3460106FD7E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 04:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0uYd-0001hc-48; Fri, 13 Mar 2026 00:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1w0uYb-0001hA-90
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 00:55:29 -0400
Received: from mail-eastusazon11012029.outbound.protection.outlook.com
 ([52.101.53.29] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1w0uYZ-0005hk-5g
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 00:55:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s42hWUY0GREfC4hdNJIAmlkiGIQ/JKB5e4CH7asHxD3ElYqoj71vmEQKcQXHczFInrxmmZU8PYhWkJr3VKafeKr70d8CGVCeEzrZshlHWUHiwVmjGko8U2aJpJVUoy0uV9bAgX6SL8VNifhCKp0OLkPSaYw+6y8oxTta4aE19NZ/N7vHrYZprnIVWX3pGOqxkKbVaenAjtGUml2U27y+cLmKFKHpV3y8Kbdxs4ALYaDC57KO0octcuKefBuYbDq6TILgcSYHyUKHAnEqYADJfm9KBLBEHnQJCz4A8kD5RlTRaeAppR5Hwi9TkqEgQLRj4XC6yWijJfrsbcDDAa+Hqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jARUJeGAkcwkiqBy6QjTLyhWBP9CRWgqGm/AsOrMdT4=;
 b=dSfcEOpEhKBicMEhAEWUMBIRNQuzlgVgAPIcHgBZ0OpQGfQZUazt77XTcA9cneOuQzpI1vMC3EiGqhQBuUtJztvU6y1vcz/LVb91c1ScFSlJjx/WD0GgyvhHnCbVWMB/mQ1nSsvI3BZa91oTD+Kznxk0DKSTF8kieWL8+4u9qK5Np2HF687YagyBG090VMQBvyLgtAjYUoAumj1qFQ+pLHyMXXD0x8W0BYULFZcjLMMOMNtV7QFiUyH2Tx34uVyUOpYNZ3gTlRWYu1Xw8wqvExHH6fKyvmmiHbQq7wD4sJxk/u+GIlbbqEYCGoKCgtIAoEl/UqACdNeyrkg/F5sDKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jARUJeGAkcwkiqBy6QjTLyhWBP9CRWgqGm/AsOrMdT4=;
 b=MJnyp9fUVT6Ezs1gl/wOCu09KAc2nOap0FpiVBQKaW2zG0T2T4rC7GagKcdrRCbxWmd7un88aiLR7Vn0wlxsHG39IScidGAUqekgf2c6iy5mSW8pfJU4gT4LuY6fOh6lIPie0THeBF6KgB6qvV+Ne9Id4QDsv8teLhzfurQaNnA=
Received: from PH7PR13CA0011.namprd13.prod.outlook.com (2603:10b6:510:174::26)
 by CYYPR12MB8870.namprd12.prod.outlook.com (2603:10b6:930:bb::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 04:50:17 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:510:174:cafe::30) by PH7PR13CA0011.outlook.office365.com
 (2603:10b6:510:174::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.15 via Frontend Transport; Fri,
 13 Mar 2026 04:50:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 04:50:16 +0000
Received: from [10.143.201.178] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 23:50:13 -0500
Message-ID: <11d3f547-34a6-4ccb-91e4-7dbe55b8ad29@amd.com>
Date: Fri, 13 Mar 2026 10:19:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <pbonzini@redhat.com>, <richard.henderson@linaro.org>, 
 <eduardo@habkost.net>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <vasant.hegde@amd.com>, <clement.mathieu--drif@eviden.com>
Subject: Re: [PATCH v3 1/3] amd_iommu: Use switch case to determine mmio
 register name
Content-Language: en-US
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
References: <20260302115130.5903-1-sarunkod@amd.com>
 <20260302115130.5903-2-sarunkod@amd.com>
 <913090df-f03b-4b56-837e-cff31c617a58@oracle.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <913090df-f03b-4b56-837e-cff31c617a58@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|CYYPR12MB8870:EE_
X-MS-Office365-Filtering-Correlation-Id: 8170a72a-8f13-4cf9-5809-08de80bc05aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|7053199007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: XnRo0WufHBSKwZ2SSE2FzIGfkewPEFa2jyctCRPNOpA+ZhY4qIuZuomXY6FjnQKS0//tGbyGnjlY1fxZZmoOsdYodMKvwCE9yYqy28wChpFShT3k4c6ubTZfRIdkPgKQQzD4nQffuNUFrQPTB5YYqxWCjTuqvW1YS0l/3b83n9NQ4ErEYCIog18h29rhFxgprmBGaBW3Pc922sV4FeTb77zRuYa8Z6MzpCExVqKSXLFLEjlnjL50KHFG5Z+/Cx7nuyZdiA3rDVrCmaZA4Q3QowSbRWCtbNbccS2R2fT4gl9vvPsz00sUhzBiZLvzX63bxHxqXJAIRtPvnWBUONYRPtk4ZWOYW4X4RENvJuz60ox6eFz64znNx158/4i534jea+BDavaOlKWklv/2QVe/WUQ9wWEmR05I0goz6JdAz13Sg7VXvraHXartpj4BZiB81wCM/sO+bhMuyLMmwR+C5xCCsQc91MraWhAgSpUmFpf7+iPJ+YMdyhVbZUKzOOARIMbDmhp+IFjVZEvhndD9ZI3yECncuRtlkQ02zSkHfkzqNKED3WKQUHTaAGCVfSEIHLz5NVSfSj43GfJ5goVJg2eFHHnT8pTwVMA1WCE+d9TPn2c+b6D+kJzUODpf4LCV79j8k7i+/gp528tx4ZWGX6fpq/9bfXQOcaFfOPvSbvziRqNXs2PvLo8LxnpKpQCrYf/GPLTRo1/lGwawSR79vatjc9JpZy58so9rzhkBdWXdA7JitOi8I8rmn4f+ixwL3sbrrhCk46dF+51JKn4Iaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(7053199007)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qQ/VVtICXK3aW8BEcvvdMMJpCWUft/J6XFr2gg7LyWeSZ6sTlEgq9y6moIiCgHeDZNI+Csv7sTfbofNHK6sxR0pfqSWYoB1Qw3vYM44qB4LbTNesBrIZnwevID63JYsDthSSMzI9j1mG15Ye6OP+ajc/DVVPlvMkiXSoxPVQRoEvCw0JcYVQHXOSGKushjL8WJLGfn2OEnhV11cIue4lNE2YuLCHIKN5lyjOZwfbzR7I0iSA79epk60jFPV/BA/XABAvG9kIDJr9czUMARoDKF1tgdHiY4S+JHiviGz7A1e5nRYcj2ELRgwrappohUcWKMPhxzV5UyxW53z0G+5q6ntpZKj9k5EzfB7kN0xqmw1TzznRWyDI13V7ER1c9UcFKvgiF5aHUjqFwOFDVFuH/54x4qz8Sx0JIwZfS+/BDZxQ8wCajujRZuwQOqHmTRTm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 04:50:16.9570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8170a72a-8f13-4cf9-5809-08de80bc05aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8870
Received-SPF: permerror client-ip=52.101.53.29;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/13/2026 3:29 AM, Alejandro Jimenez wrote:
> Hi Sairaj,
>
> On 3/2/26 6:51 AM, Sairaj Kodilkar wrote:
>> This makes it easier to add new MMIO registers for tracing and removes
>> the unnecessary complexity introduced by amdvi_mmio_(low/high) array.
>>
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
>> Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>> ---
>>   hw/i386/amd_iommu.c | 76 ++++++++++++++++-----------------------------
>>   hw/i386/amd_iommu.h |  4 ---
>>   2 files changed, 27 insertions(+), 53 deletions(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 789e09d6f2bc..f5aa9c763d02 100644
> [...]
>
>> -
>> -static void amdvi_mmio_trace_read(hwaddr addr, unsigned size)
>> -{
>> -    uint8_t index = amdvi_mmio_get_index(addr);
>> -    trace_amdvi_mmio_read(amdvi_mmio_low[index], addr, size, addr & ~0x07);
>> -}
>> -
>> -static void amdvi_mmio_trace_write(hwaddr addr, unsigned size, uint64_t val)
>> -{
>> -    uint8_t index = amdvi_mmio_get_index(addr);
>> -    trace_amdvi_mmio_write(amdvi_mmio_low[index], addr, size, val,
>> -                           addr & ~0x07);
>>   }
>>   
>>   static uint64_t amdvi_mmio_read(void *opaque, hwaddr addr, unsigned size)
>> @@ -1528,7 +1505,7 @@ static uint64_t amdvi_mmio_read(void *opaque, hwaddr addr, unsigned size)
>>       } else if (size == 8) {
>>           val = amdvi_readq(s, addr);
>>       }
>> -    amdvi_mmio_trace_read(addr, size);
>> +    trace_amdvi_mmio_read(amdvi_mmio_get_name(addr), addr, size, addr & ~0x07);
>>   
>>       return val;
>>   }
>> @@ -1684,7 +1661,8 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
>>           return;
>>       }
>>   
>> -    amdvi_mmio_trace_write(addr, size, val);
>> +    trace_amdvi_mmio_write(amdvi_mmio_get_name(addr), addr, size, val, offset);
>> +
> There is a small change in the trace output here from the previous patches,
> and it is because the use of offset in the last argument vs the previous
> patches which still use (addr & ~0x07).
> My understanding is that the offset the trace uses is the MMIO offset
> (which gives a mapping between the name of the register we print and its
> offset in the MMIO space).
>
> The offset variable that amdvi_mmio_write() calculates earlier is the byte
> offset within the MMIO register, and it is needed for those special cases
> (i.e. hacks) where a guest driver does not write with a full 64-bit write
> to the register, so that we need to delay the side effect until the MMIO
> register has been fully updated. That is my understanding of the code that
> does:
>
> 1709         if (offset || (size == 8)) {
>
> 1710             amdvi_handle_devtab_write(s);
>
> 1711         }
>
>
> i.e. don't apply the architectural side effects unless we write to the full
> 64-bit register at once, or offset is not zero. This last condition meaning
> we do word writes, and write to the high word last i.e. offset !=0.
>
> So in short, I will fix the call to trace_amdvi_mmio_write() to continue to
> use (addr & ~0x07), and will also change the switch condition in
> amdvi_mmio_get_name() to use the same.
> No need to send another revision, but I just wanted to highlight the
> difference so you are aware of the change.
>
> Thank you,
> Alejandro
>

Hey Alejandro,

Thanks, for pointing this out. I got confused because of the same naming
i.e. offset in both the cases and missed '~'.
I should have used addr & ~0x07 directly.

Thanks
Sairaj

>>       switch (addr & ~0x07) {
>>       case AMDVI_MMIO_CONTROL:
>>           amdvi_mmio_reg_write(s, size, val, addr);
>> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
>> index 302ccca5121f..ca4ff9fffee3 100644
>> --- a/hw/i386/amd_iommu.h
>> +++ b/hw/i386/amd_iommu.h
>> @@ -45,10 +45,6 @@
>>   #define AMDVI_CAPAB_FLAG_IOTLBSUP     (1 << 24)
>>   #define AMDVI_CAPAB_INIT_TYPE         (3 << 16)
>>   
>> -/* No. of used MMIO registers */
>> -#define AMDVI_MMIO_REGS_HIGH  7
>> -#define AMDVI_MMIO_REGS_LOW   8
>> -
>>   /* MMIO registers */
>>   #define AMDVI_MMIO_DEVICE_TABLE       0x0000
>>   #define AMDVI_MMIO_COMMAND_BASE       0x0008


