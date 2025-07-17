Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95ABFC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 06:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucIQn-0004s1-KY; Thu, 17 Jul 2025 02:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ucIOz-0002kg-P1
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 02:47:53 -0400
Received: from mail-co1nam11on20615.outbound.protection.outlook.com
 ([2a01:111:f403:2416::615]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ucIOw-0002JN-TI
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 02:47:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9zdZDRSc24kR5dLUfdLxzLYURKowr1Q+eP9BhZiCDEnCWW0Av/28jfksXxoslnZwzeiQNmCGTTZeaVSuZeWs7UsuL939opVhokFIrWetdk1opA1DMct3g/SlHW2bwyrv8Ghsdue87206rLJRcSpd8UA5r2x+Y3SNt1oDRm9A8BCSk8HBK/yVIGgaQ6WD7CnUXDAajmQDA4odp19bDgEiMbkqND9QXgGuZEjD+JEPNPqsVlalWXqNdv16qT1Ek5dRzGAU29yVkroioWROKNkyNt4E0Gs9Yk6THti8iBzXRt5666zX8waiDnRO5I5N2DOPjD1FwCF8dzHZtHYoSyaZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kZ5O5rhWKVVKmtc+Dazfa9eKYOEgG1dWMpyqvqQFVo=;
 b=ewjZ1S6TCEdgTlzSWMiWgNHiYAWHCxzkpYayulGetg7IDdpB5AJ0OIbFDWky8/A4StdmX+BP1cPmqJHsQYdfaxOKUtUPJoM/5gZyKSMwF2sRhczHMdVf13mU7IudN1rsviFkUfHpmUPJY0bWIADU1B6B2rDRrDAXfdFWSyVp8hjvhsSXOJQXFepC79CmPPNeVIRm9VP9BM1F8TVo62u66ecd/hgFqciicZM+QNCDiVY5nbrvPduD9hBHZFc3VgCY8Jowf6wHGgPgj6q0PU+93ShAvh4PDP3PU5Lr3Jqb6CyZJk7ExuLlzs0nrN5A6R954LCCm6U5/A4GHTp9UGU7ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=eviden.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kZ5O5rhWKVVKmtc+Dazfa9eKYOEgG1dWMpyqvqQFVo=;
 b=T+X7ZuuTOwTcoW0ELvsRQB5kegL/uiUGarojsZRW9oS7PUa0nvUW+2CPPGZNZ81GamLnzIlM7+AIyvb6xSC8RIywEckAqyiowDSb+agTDntXFA63orCYPCFxApl9OcrYwWbOXX75wGi6d+45NVKj56D83i8kcA0iLIInNi7Y7yY=
Received: from MN2PR01CA0026.prod.exchangelabs.com (2603:10b6:208:10c::39) by
 IA1PR12MB9740.namprd12.prod.outlook.com (2603:10b6:208:465::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 06:47:23 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:208:10c:cafe::e4) by MN2PR01CA0026.outlook.office365.com
 (2603:10b6:208:10c::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.32 via Frontend Transport; Thu,
 17 Jul 2025 06:47:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 06:47:22 +0000
Received: from [10.252.206.76] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Jul
 2025 01:47:18 -0500
Message-ID: <e1596050-e84f-4235-b839-35834ceefeac@amd.com>
Date: Thu, 17 Jul 2025 12:17:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] hw/i386/amd_iommu: Fix handling device on buses != 0
To: Ethan MILON <ethan.milon@eviden.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "alejandro.j.jimenez@oracle.com"
 <alejandro.j.jimenez@oracle.com>, Alexey Kardashevskiy <aik@amd.com>
References: <20250716073145.915-1-sarunkod@amd.com>
 <20250716073145.915-7-sarunkod@amd.com>
 <2c247f13-c36a-4257-abe4-2be9e463d0ba@eviden.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <2c247f13-c36a-4257-abe4-2be9e463d0ba@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|IA1PR12MB9740:EE_
X-MS-Office365-Filtering-Correlation-Id: 7950c777-a253-4d40-5b6b-08ddc4fdc850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnBOenJGb0w3ZDB0ZkZ5bHAyQkZzUC92YzV1NFJQc21LME1MRDFkdmtaaUsr?=
 =?utf-8?B?WE1LeGRvdEdPT3g0M3pJTUhNVkVnZVNmbTJsMTNXNllXYk1rQkJtd0dqZDFG?=
 =?utf-8?B?Z0lHenNtK3VaQ1dTL05zTW16cTN4MVUwVE1ud1dZRFY2WHNSSzkwSDBxTFR4?=
 =?utf-8?B?SUxOT1VsOGpGMElrZEZ6TUpHb1A2emZqbjdaeXhSUmhoM2hGbW9zbkpwS0d2?=
 =?utf-8?B?UkVrTnZJa1N2SlloZFJPT0c1NjZzdGlTMDl0TUs4UUhkK3cyUWMvNit5alpQ?=
 =?utf-8?B?RENQa20xTHIrVkw3UU5aUWJpQUlSWThXZlFFRzJrTkwwOTBiVUJxYTlwWExw?=
 =?utf-8?B?M2llNVNUVkdOQ0xYNWVoS0h3ZGhRRVBPMndDVXJrMmtiRzR3S2tFWVZxbkZT?=
 =?utf-8?B?NjdwYmVldHBCL0NvanIvNlZIOVdoYkRIa3JUd0dYd1ZjcnpFT292NXJrZTRR?=
 =?utf-8?B?dXV3dTdVYjJQbFpIT0hWeDM2Y2p0VTk3L3VZNVZaN0dablJEQ3dGNTVRZUhu?=
 =?utf-8?B?aUlXRFpFWkxPUlNPS05VUDkvbWV2OG1BVmsycjViazZucFl5MjlGNG5ETGVO?=
 =?utf-8?B?bUV1cG9xNk5ibnpZYmtFQzZXQS9ET0t2OWRaMndESFlodUsrdmF0Wk93M21G?=
 =?utf-8?B?QXM3T2ZOcXRxU1lXbExuT1pXYzdQY1gzUUlSOHk1dmhKMTJyWUd4cFNlWGY2?=
 =?utf-8?B?UStHVXdITkJjN3lJSEwvZkR1SW1OcE45M3g5UWt6azFOeXE2Q284TjV1U00r?=
 =?utf-8?B?ZU1zakNEMHE5K3ZNYjdtV0szWDM1UTZlL1NZZVNyVmxYcGhMWmFQRXBJaDNw?=
 =?utf-8?B?eUQrUTExUHhRaUhxSEgyQmtiZ24rc3E2V3lHMmYwLzBDcHNZRlkvSWJCeVRX?=
 =?utf-8?B?VDNvRlYwZnBlS1JlNkwyRlJ1aExwVjZpKzZXSEpYRmVwUnVDdlpBbkg5S3Bt?=
 =?utf-8?B?eTlBWTNNZTVtRFN5TlhoOEVKUHVjL1d2Q1IvZjVEZHdmc0xPUHhDNGF0S1c4?=
 =?utf-8?B?bkpOZjl5ODNieS82VG9OMXBRU2M1YW1FcmRSeFRHVDdCRHBlT1I4ZTdmSjlT?=
 =?utf-8?B?R1R0QXFEMjAzd0k4ZWlZeXNxMXlzaE5FdG5TUWExM0FBRlY5VGtKUEloN3Q3?=
 =?utf-8?B?SVVmZzdFd1U0dFJJZHJzc0kvL0dzWWlBdjJFVHQvQWZjSklRWDJ5NFhDbUVR?=
 =?utf-8?B?TWpZWUhOc1JDV3QxcUUxaEdkS2wyNGxJTTdITldmc0p5cjl5VEU4dzFiTWxT?=
 =?utf-8?B?VEdNKzY5UzFXQUlHZ1d2YU5ZVGQxcG9PVU1jMWs5UStQa1Brek5DV2dsNHNh?=
 =?utf-8?B?M1BIR1d6VDhOZElmS0lHK1pEVVNUTlhQdnl4K21LU0hmYnZ4akFPVFJVSnZh?=
 =?utf-8?B?bFBtaC9xZ1lCRUtSWGQwaDcrQWhhd1ZDMWQrbHlQZk1qeUh1YUdZN3pFM3di?=
 =?utf-8?B?UmRwZDE4RHpkZnI2Z2x5OStacHZUeURGd0h5QWlpTkdIUGh5THRBQlAwR2NB?=
 =?utf-8?B?cEhWUWJtaW9XeXc4ZklSQXhMYWN5M0NjOENraklhZksvSjAvQit1dEZVa2hG?=
 =?utf-8?B?NWRvdTVtTlJsV0ZhcEJ3L1hIdHdENzJiM1hicUhPSGxETkliQzFGSDRMUlVx?=
 =?utf-8?B?MXo3Z3RGTHQrZGlObWoyWE9UNTU0QVk2TkNLS0UyRVdiR1NHbUI3SC9EdVJv?=
 =?utf-8?B?OWVpaGMvbno1NG1jV2ZwS1dXbjR4NGFrVXdtR2FVTXE4UDgva2VBUy8rSnpz?=
 =?utf-8?B?dDBKcHRmdEJmYzlrNElDbk5TTW5tZzVDU0tqMU55R1JheUxlV2djUHo1YTFq?=
 =?utf-8?B?cTM1WWVzenRnZ0RLVXhsSmNNa2EzMzFydVhpMTJVMnZlczBQSFVBWEFtWGx6?=
 =?utf-8?B?TlI2UU5lM216OXhZS21qeFhHV3RubDErVXUyeVQybVF2QkxmUCs3R29FNDJk?=
 =?utf-8?B?aDZBZ2xGc0JoQkZydzN1OUpLMEl4b3Q1VVRCaU9zdTg3ZHFXYzdyTldjRWxj?=
 =?utf-8?B?b2xHeVpVR2tRam9ZaHMzTnp5SzIyV0s5L2pWY2lLVjlId2NEUjlUZ3Z3eURG?=
 =?utf-8?Q?8X+ou7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 06:47:22.2528 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7950c777-a253-4d40-5b6b-08ddc4fdc850
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9740
Received-SPF: permerror client-ip=2a01:111:f403:2416::615;
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



On 7/16/2025 8:48 PM, Ethan MILON wrote:
> On 7/16/25 09:31, Sairaj Kodilkar wrote:
>> The AMD IOMMU is set up at boot time and uses PCI bus numbers + devfn
>> for indexing into DTE. The problem is that before the guest started,
>> all PCI bus numbers are 0 as no PCI discovery happened yet (BIOS or/and
>> kernel will do that later) so relying on the bus number is wrong.
>> The immediate effect is emulated devices cannot do DMA when places on
>> a bus other that 0.
>>
>> Replace static array of address_space with hash table which uses devfn and
>> PCIBus* for key as it is not going to change after the guest is booted.
>>
>> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> ---
>>   hw/i386/amd_iommu.c | 124 +++++++++++++++++++++++++++-----------------
>>   hw/i386/amd_iommu.h |   2 +-
>>   2 files changed, 76 insertions(+), 50 deletions(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index a34062153194..33916b458611 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -59,7 +59,7 @@ const char *amdvi_mmio_high[] = {
>>   };
>>
>>   struct AMDVIAddressSpace {
>> -    uint8_t bus_num;            /* bus number                           */
>> +    PCIBus *bus;                /* PCIBus (for bus number)              */
>>       uint8_t devfn;              /* device function                      */
>>       AMDVIState *iommu_state;    /* AMDVI - one per machine              */
>>       MemoryRegion root;          /* AMDVI Root memory map region         */
>> @@ -101,6 +101,11 @@ typedef enum AMDVIFaultReason {
>>       AMDVI_FR_PT_ENTRY_INV,      /* Failure to read PTE from guest memory */
>>   } AMDVIFaultReason;
>>
>> +typedef struct amdvi_as_key {
>> +    PCIBus *bus;
>> +    int devfn;
>> +} amdvi_as_key;
>> +
>>   uint64_t amdvi_extended_feature_register(AMDVIState *s)
>>   {
>>       uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
>> @@ -360,6 +365,42 @@ static guint amdvi_uint64_hash(gconstpointer v)
>>       return (guint)*(const uint64_t *)v;
>>   }
>>
>> +static gboolean amdvi_as_equal(gconstpointer v1, gconstpointer v2)
>> +{
>> +    const struct amdvi_as_key *key1 = v1;
>> +    const struct amdvi_as_key *key2 = v2;
>> +
>> +    return key1->bus == key2->bus && key1->devfn == key2->devfn;
>> +}
>> +
>> +static guint amdvi_as_hash(gconstpointer v)
>> +{
>> +    const struct amdvi_as_key *key = v;
>> +    return (guint)((uint64_t)key->bus | (key->devfn << 24));
> 
> I think it should at least be a xor, but a hash similar to the
> intel one is probably preferable:
>
> return (guint)((uintptr_t)key->bus << 8) | key->devfn);
> 

Makes sense considering that guint is 32 bit on most 64 bit machines.
But I am not sure if this is a good hash function (with uniform
distribution). Nonetheless, I will still change it to intel's
implementation.

Thanks
Sairaj


../..

>> -
>> -    /* set up AMD-Vi region */
>> -    if (!iommu_as[devfn]) {
>> +    if (!amdvi_dev_as) {
>>           snprintf(name, sizeof(name), "amd_iommu_devfn_%d", devfn);
>>
>> -        iommu_as[devfn] = g_new0(AMDVIAddressSpace, 1);
>> -        iommu_as[devfn]->bus_num = (uint8_t)bus_num;
>> -        iommu_as[devfn]->devfn = (uint8_t)devfn;
>> -        iommu_as[devfn]->iommu_state = s;
>> -        iommu_as[devfn]->notifier_flags = IOMMU_NONE;
> 
> s/IOMMU_NONE/IOMMU_NOTIFIER_NONE
> 

This is part of @Alejandro's changes in DMA remapping. I already pointed
this to him on his V2.

Thanks
Sairaj

../..

