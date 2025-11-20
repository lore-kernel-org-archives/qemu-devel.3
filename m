Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D35CF64B3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 04:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLwbD-0002y0-IB; Wed, 19 Nov 2025 23:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vLwbC-0002wy-2W
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 23:48:50 -0500
Received: from mail-westus3azon11010036.outbound.protection.outlook.com
 ([52.101.201.36] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vLwb9-00087u-An
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 23:48:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ji32yVWDiqxpDBZ4kS8tS4sI5Ys3zgn4mkWtk00qqkVtoh/erPUVBhPPl98pI1SF63KjMtwX0QWLh2ssegNQOBRax+ochpVK8mCPUphNnpHrfID89sgEB1VoqZC3Pm/awzmr2ih2wM1ah0fvt0ztHAZKj+vW+eYLtnZ+3g/wtKC+ENsL7EwO9LwoKNu7CdG0dP9Ruq5mN/XbZzp3B/5HA4YYmm+viBzavA9B7weeDlLQdp9nqpAyfoabeghjiGUuXGNy0qJx0gO8uSE8QbROzzyZbkyxWX4mKsLErgO59BE0pJwjvYYF1J+dFCC0papuDbl6fk4kbHSHfxfCSxCuhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/+200eSe8/3BEs78crYN0b8AhoOGa8yX35waLQqe0I=;
 b=AJl+iBaO/Emgw2+134bIOMDtOvgGbfxh2NXpqfDjMzQLD3gPnaVT7EFaRA8EgPvTzScWZqiwQilJN+eokKhwcWddo/qYDRAY1wHFGtmOA5BqFboaZbJqieeTzlhKkiVcrgqZhgTqNuL/PfKVOJWG2nLi9peNCwFb0J4fFA7nJAdSHwHw0hKbIfuejTuRz202gr3Gu/fIF/Jt6zLt+Q8Z5p4FZQ7s2YJecHIr5Tuqg8+EmQCuB8KuFgLCZ6CSndsrNvKz6DwKsm5Y/PsSWyANETT0SWXeydmpsFLV15DRCEXe+rzIP1PvEqJ8bth/RPRhNhV0WzJKOdoUomXlsZ2Gag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/+200eSe8/3BEs78crYN0b8AhoOGa8yX35waLQqe0I=;
 b=MKa6nqUif60i33urczeFFKvxNhxDEbP4xQnbWqAHU8g+uo2fxtgKU8ia1zhRCMvxm2v9agfKYittEed3i8M+SqSdyIzIlRIZjA+lHyvakgK9zdwNy14/XA1AcY66ZKL7Mq2WkusyUQNSUlVgdz/xseBtaAD+gRJFxmDjoWn6vug=
Received: from BY3PR04CA0026.namprd04.prod.outlook.com (2603:10b6:a03:217::31)
 by CH3PR12MB9195.namprd12.prod.outlook.com (2603:10b6:610:1a3::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 04:43:36 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:a03:217:cafe::7c) by BY3PR04CA0026.outlook.office365.com
 (2603:10b6:a03:217::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 04:43:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.1 via Frontend Transport; Thu, 20 Nov 2025 04:43:36 +0000
Received: from [10.85.40.78] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 20:43:33 -0800
Message-ID: <c8e2ca43-c577-411a-a8de-176c5f85c15f@amd.com>
Date: Thu, 20 Nov 2025 10:13:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] amd_iommu: Use switch case to determine mmio register
 name
Content-Language: en-US
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 <qemu-devel@nongnu.org>, Vasant Hegde <vasant.hegde@amd.com>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>
References: <20251118082403.3455-1-sarunkod@amd.com>
 <20251118082403.3455-2-sarunkod@amd.com>
 <eaf49cf3-e56b-40f1-974d-207969c7371e@oracle.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <eaf49cf3-e56b-40f1-974d-207969c7371e@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|CH3PR12MB9195:EE_
X-MS-Office365-Filtering-Correlation-Id: af68534d-e92b-427f-af4b-08de27ef5e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rm1RTmFsZWVnL2g5T1VHMi8vUi94Z1VUcjRaekhkMitVblcxcFhlUnoycEtB?=
 =?utf-8?B?dXljOHVuMUY3cmpONnMxM3lhQVJEYWtFbEMwa0p4NUg1eW5RZnRFUnRKMHh5?=
 =?utf-8?B?T3ROM0ZvVlMybHhCWjdCSXM3SFNXaVhsSDcwU3J1Z095VWRuRWVicjlwcHM3?=
 =?utf-8?B?c3daWUhWSUdJQ2JldWJxWndqWFpUdUZORzJiWDBvMXZGNC9Bdmpod2poM2lz?=
 =?utf-8?B?KzIvZTFwa1B1cmhZdmc5TWpMZWxGL2UyZEFSbzZtSklWUkhMa2VGMkdIanht?=
 =?utf-8?B?WkpTY0NLTHRYL2lKclhVeGV0dG9YNmVXem91WTBrSmVNMzVaZXNEUENRRW5B?=
 =?utf-8?B?VGFpaFRVR1hDaGFjSXRFZ3g3aFA2ZVVmT1dwbWtZc1pyOXVLVGR4UEVnZ0t4?=
 =?utf-8?B?U1R3ZGV1RHVDYkEvd1ZwRlQxNytORDBWM0pyZVRVQkRMN0JyR0dKQ2NtOWFy?=
 =?utf-8?B?V3FaVjdBSkpqUGZKNXQ0aWVJYmRNZm52U3BiK0VPYnJ3UTZjVC9LT1haS1Rr?=
 =?utf-8?B?bzZjTGlmUjhkMHJpQ2pNaGd4dWIrcFZDSUdzMHNSSlQ1SEdPcC8zTW1XK2tU?=
 =?utf-8?B?VjdaZVlSWXFoY1hMREhLRGU1eGh6R284d1hZc3BXNjJSMlRlaC9tRFp5QTVq?=
 =?utf-8?B?VldRc2wwbU8xZTVpYkZMZW8vODdQdGtlL1praCs4VC9hY09FM0J4NHV6d3JR?=
 =?utf-8?B?K0I5RUVwTEYySUJFNHgvVFdmZEVDMlNnU1RIOVZCNnQ2UG8wVTVnVlBmT25n?=
 =?utf-8?B?eG5KRlZSSldCb1FZTkJGRHIzYmN1RXFTWklwQTVJWUlFVEU0NVdsVmxFZlM4?=
 =?utf-8?B?SjhzN3g2Mk0weVJYR3VYbnpEcVJYZm92U0lzUHZNVnRqT0lRSVd0Wm0zR3Zy?=
 =?utf-8?B?dUxLSFdGWWo5bnJyZ2duTm15MDRhUlBEQjFyNDdJQlRHeHVvYXNpUVRyVWMr?=
 =?utf-8?B?THpRdlhZVVFmNENYR2ZmcjIzYVpPVlZHc1F0aXFmcll6bEpsejRDc2xSQXFw?=
 =?utf-8?B?eU5ISXF6cmExb2JpZnRqbXYvU2RwVDduVkszMkNkeXM3U0RvTVgyLzBsd0Fv?=
 =?utf-8?B?QUxZNmhqdGFQOG05Qkw3ayt1S2QxSmZSVTkwcEZhM0RCY0xjNXlWQUlRaUlY?=
 =?utf-8?B?anY4MXI3QytMWW9RdCtIT0ZrKzBsSG4xdW1XU05QNkxQY0k2bGlreGpjcG14?=
 =?utf-8?B?emJnSmNmTXFtWE9zQjhYV0YwR0ZtRXJoenpQdzlqODNvTFBrOGk0a2p4bXBv?=
 =?utf-8?B?ZkM4czRuZEpHc1NiditkYWRYci82TmZEY09qSmdUMTh5dkRyWmcvbEVGL0Zk?=
 =?utf-8?B?NE51amlNSjYzWVZRNVlMWkZGbXMzVC8yM0dHR2ZtVHIrcHBsaWRuSXduOU9o?=
 =?utf-8?B?TDBkRFRGU1cwelpUWFJmRzkzdE5zcDY3SVBzRGVHSy9rOFB4dWdmQldqOXVS?=
 =?utf-8?B?L2tER2ZJTXY5bWRyZng2MGxsQ0l6STNucUxVVFlLa2kwWGdEdG9XMlRldXBU?=
 =?utf-8?B?NGFMUFBUTHhoR0cxa0M4ZVIwYVZ5dFRVM0VxVzJYd1lKbDNDd1kxUE00UWZ3?=
 =?utf-8?B?c2swdHYwM0NqelFGbVlHd3NLR0dSRjE2OXdIVnB4ZW5VSlMwbDhOeWloV2xj?=
 =?utf-8?B?VFBzVHZrSGJGMU9qQUYvSE16MHE4alVxYUNwOWVwbXArY0JQVjhkTDF5TEk4?=
 =?utf-8?B?QkhMWDNYYWZzN29MVWVhWldFek1xelNsbkxDWko4Z1FyZWJnNC9nUXN1NVZn?=
 =?utf-8?B?ckIrTG81SDRPTEVEYVRUbUk2N1ZoZnlPV2xHWjNXcjUzSTVYWEUwU211ZHZr?=
 =?utf-8?B?TlY2bUhHc09SL2pYNnZmQWI4NkFpdStEUE1nemRwVlR2TnVxQmdTQmM5eFRZ?=
 =?utf-8?B?eDBGcmVCOFJ2QlR1RWlLeWowR3A3L2RCMnQ1bHpJbjVLNGxpQytiTkVpTWlU?=
 =?utf-8?B?bHFNaS9WVjJzY1k4RTB1RlZGRWNuKzlkSlQxdzd1WW5wOXE4YjlBTnliUmVj?=
 =?utf-8?B?RHVEQWhTVHRqK29yTSt3RjBVSUF4d0cyWEVZUFgyYlI3bHRBWGlXTWUwQWs4?=
 =?utf-8?B?aUE0YU0vSDJhVmtjVWxRcmxOekF6N0hqVGkvbTdQNW1RSGJYa0J1WHZkQ2Ns?=
 =?utf-8?Q?mkEs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 04:43:36.0249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af68534d-e92b-427f-af4b-08de27ef5e06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9195
Received-SPF: permerror client-ip=52.101.201.36;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 11/20/2025 7:06 AM, Alejandro Jimenez wrote:
> Hi Sairaj,
>
> On 11/18/25 3:24 AM, Sairaj Kodilkar wrote:
>> This makes it easier to add new MMIO registers for tracing and removes
>> the unnecessary complexity introduced by amdvi_mmio_(low/high) array.
>>
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> ---
>>   hw/i386/amd_iommu.c | 76 +++++++++++++++++++++++----------------------
>>   1 file changed, 39 insertions(+), 37 deletions(-)
>>
>
> [...]
>
>> +#define MMIO_REG_TO_STRING(mmio_reg, name) {\
>> +    case mmio_reg: \
>> +        name = #mmio_reg; \
>> +        break; \
>> +}
>> +
>> +#define MMIO_NAME_SIZE 50
>>     struct AMDVIAddressSpace {
>>       PCIBus *bus;                /* PCIBus (for bus 
>> number)              */
>> @@ -1484,31 +1469,48 @@ static void amdvi_cmdbuf_run(AMDVIState *s)
>>       }
>>   }
>>   -static inline uint8_t amdvi_mmio_get_index(hwaddr addr)
>> -{
>> -    uint8_t index = (addr & ~0x2000) / 8;
>> -
>> -    if ((addr & 0x2000)) {
>> -        /* high table */
>> -        index = index >= AMDVI_MMIO_REGS_HIGH ? AMDVI_MMIO_REGS_HIGH 
>> : index;
>> -    } else {
>> -        index = index >= AMDVI_MMIO_REGS_LOW ? AMDVI_MMIO_REGS_LOW : 
>> index;
>> +static inline void amdvi_mmio_get_name(hwaddr addr,
>> +                                       char mmio_name[MMIO_NAME_SIZE])
>> +{
>> +    const char *name = NULL;
>> +
>> +    switch (addr) {
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_DEVICE_TABLE, name)
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_BASE, name)
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_BASE, name)
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_CONTROL, name)
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_BASE, name)
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_LIMIT, name)
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXT_FEATURES, name)
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_HEAD, name)
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_TAIL, name)
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_HEAD, name)
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_TAIL, name)
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_STATUS, name)
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_BASE, name)
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_HEAD, name)
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_TAIL, name)
>> +    default:
>> +        name = "UNHANDLED";
>>       }
>>   -    return index;
>> +    strncpy(mmio_name, name, MMIO_NAME_SIZE);
>>   }
>
> While I don't believe there is a correctness issue, and it is a clever 
> construct to reduce code repetition, I had some concerns with the 
> implementation above, mostly on coding style and maintainability. I 
> can go into each of the issues, but as I was trying to think of fixes 
> it just became easier to write the code so...
>
> I think these changes preserve your original idea while fixing the 
> problems and removing unnecessary code. Rather than diff from your 
> patch, I'm sharing a diff for the full patch. I am still working 
> through the other patches but the upcoming changes should fit in with 
> no issues.
> Let me know if you agree with the changes, or if there is something I 
> missed.
>
> Alejandro
>
> ---
> (compile tested only)
>
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index d689a06eca..6fd9e2670a 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -35,28 +35,7 @@
>  #include "kvm/kvm_i386.h"
>  #include "qemu/iova-tree.h"
>
> -/* used AMD-Vi MMIO registers */
> -const char *amdvi_mmio_low[] = {
> -    "AMDVI_MMIO_DEVTAB_BASE",
> -    "AMDVI_MMIO_CMDBUF_BASE",
> -    "AMDVI_MMIO_EVTLOG_BASE",
> -    "AMDVI_MMIO_CONTROL",
> -    "AMDVI_MMIO_EXCL_BASE",
> -    "AMDVI_MMIO_EXCL_LIMIT",
> -    "AMDVI_MMIO_EXT_FEATURES",
> -    "AMDVI_MMIO_PPR_BASE",
> -    "UNHANDLED"
> -};
> -const char *amdvi_mmio_high[] = {
> -    "AMDVI_MMIO_COMMAND_HEAD",
> -    "AMDVI_MMIO_COMMAND_TAIL",
> -    "AMDVI_MMIO_EVTLOG_HEAD",
> -    "AMDVI_MMIO_EVTLOG_TAIL",
> -    "AMDVI_MMIO_STATUS",
> -    "AMDVI_MMIO_PPR_HEAD",
> -    "AMDVI_MMIO_PPR_TAIL",
> -    "UNHANDLED"
> -};
> +#define MMIO_REG_TO_STRING(mmio_reg)   case mmio_reg: return #mmio_reg
>
>  struct AMDVIAddressSpace {
>      PCIBus *bus;                /* PCIBus (for bus 
> number)              */
> @@ -1484,31 +1463,27 @@ static void amdvi_cmdbuf_run(AMDVIState *s)
>      }
>  }
>
> -static inline uint8_t amdvi_mmio_get_index(hwaddr addr)
> -{
> -    uint8_t index = (addr & ~0x2000) / 8;
> -
> -    if ((addr & 0x2000)) {
> -        /* high table */
> -        index = index >= AMDVI_MMIO_REGS_HIGH ? AMDVI_MMIO_REGS_HIGH 
> : index;
> -    } else {
> -        index = index >= AMDVI_MMIO_REGS_LOW ? AMDVI_MMIO_REGS_LOW : 
> index;
> +static const char *amdvi_mmio_get_name(hwaddr addr)
> +{
> +    switch (addr) {
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_DEVICE_TABLE);
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_BASE);
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_BASE);
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_CONTROL);
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_BASE);
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_LIMIT);
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXT_FEATURES);
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_HEAD);
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_TAIL);
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_HEAD);
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_TAIL);
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_STATUS);
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_BASE);
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_HEAD);
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_TAIL);
> +    default:
> +        return "UNHANDLED";
>      }

Hi Alejandro
Although this approach looks good and faster (since you are
returning a pointer without copy), it has a major flaw.
You are returning a pointer to the "local string" which can
lead to all sorts of nasty issues. This is why I am copying
the entire string to the destination.

Thanks
Sairaj

> -
> -    return index;
> -}
> -
> -static void amdvi_mmio_trace_read(hwaddr addr, unsigned size)
> -{
> -    uint8_t index = amdvi_mmio_get_index(addr);
> -    trace_amdvi_mmio_read(amdvi_mmio_low[index], addr, size, addr & 
> ~0x07);
> -}
> -
> -static void amdvi_mmio_trace_write(hwaddr addr, unsigned size, 
> uint64_t val)
> -{
> -    uint8_t index = amdvi_mmio_get_index(addr);
> -    trace_amdvi_mmio_write(amdvi_mmio_low[index], addr, size, val,
> -                           addr & ~0x07);
>  }
>
>  static uint64_t amdvi_mmio_read(void *opaque, hwaddr addr, unsigned 
> size)
> @@ -1528,7 +1503,7 @@ static uint64_t amdvi_mmio_read(void *opaque, 
> hwaddr addr, unsigned size)
>      } else if (size == 8) {
>          val = amdvi_readq(s, addr);
>      }
> -    amdvi_mmio_trace_read(addr, size);
> +    trace_amdvi_mmio_read(amdvi_mmio_get_name(addr), addr, size, addr 
> & ~0x07);
>
>      return val;
>  }
> @@ -1684,7 +1659,9 @@ static void amdvi_mmio_write(void *opaque, 
> hwaddr addr, uint64_t val,
>          return;
>      }
>
> -    amdvi_mmio_trace_write(addr, size, val);
> +    trace_amdvi_mmio_write(amdvi_mmio_get_name(addr), addr, size, val,
> +                          addr & ~0x07);
> +
>      switch (addr & ~0x07) {
>      case AMDVI_MMIO_CONTROL:
>          amdvi_mmio_reg_write(s, size, val, addr);
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index 302ccca512..ca4ff9fffe 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -45,10 +45,6 @@
>  #define AMDVI_CAPAB_FLAG_IOTLBSUP     (1 << 24)
>  #define AMDVI_CAPAB_INIT_TYPE         (3 << 16)
>
> -/* No. of used MMIO registers */
> -#define AMDVI_MMIO_REGS_HIGH  7
> -#define AMDVI_MMIO_REGS_LOW   8
> -
>  /* MMIO registers */
>  #define AMDVI_MMIO_DEVICE_TABLE       0x0000
>  #define AMDVI_MMIO_COMMAND_BASE       0x0008
>




