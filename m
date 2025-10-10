Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDF3CAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 05:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v75O6-0004N6-T6; Fri, 10 Oct 2025 01:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v75O3-0004Mg-H4
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 01:09:51 -0400
Received: from mail-eastusazon11011057.outbound.protection.outlook.com
 ([52.101.52.57] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v75Nx-0004ih-EY
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 01:09:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ko97VeboGSHUbJVaSkcwmbTmmjR/honk2vrzgM1dw4Cy5eZTkRTT+ZodQVKN4uu3MjF5lwPFbUb3XllG8DLjON6zIbl2lfu1pYNNiHpHTDCUlzEYTQbcP9jOlr6JfOrj7rbP/PyGqT3p/eVU/BF17rStVqg7QNmwPJig/ZqEK5LOZdyTfJ/QpxggqtQ64xfnDLsicEbNHxlDaWo8ns49pOmBdIqPIZYXnPd0UbLAdt4Hm2QIpguEIFufUeqxv/x76hE0xXbn+SXm3RiTPIVFNL6p8VZXmUKMG+H2fGInu56+qeIFO3RGJNEXt0EsEX+91q2EPdESOpoeTuNeBI/H/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xU2r0sbk0vclN/uQ1LS/pEr4d6V8hO0qvI4zUBdZ4ZY=;
 b=DcEkkBv452ya7Qca/c2fhiykZFipiUFzFDUEC+S5WdAjJz5KdrAa6dVp1lgGzAcSsVMlIIVsSyvBPhSh4MXgjzpcmJ6HA4pWG8H3BitK8aOQJrxtPUp6RuJeySLleN1ak3SMFnhFaYhzcr3lcHMuqbvsVeiT4IhVr+jiJm/gGBfYMkLwSFfYKKKK6VkhMzHno+B+Xi9tHd32573cMTIar9b3LjhEuVg3oxDN70bBaigGweQjwcUR63b+gjPtRL6PVmqTpYush2jvnR3zklYpbG54CjoF2egJ+9NhfAkFWlnkiUMK11OgVVYLhKCwyL6rOaNIV+w0qjyuAlQIwSjrhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xU2r0sbk0vclN/uQ1LS/pEr4d6V8hO0qvI4zUBdZ4ZY=;
 b=KO7rE0JwLt3iolGe/6eXiSsOT7Z08BtDYCOjd69KofHjO7tsAUc/1xjgcXvuKRR678tXus1iP+zQsT/FHuf0h8x0Z1gjIpKhRycLev5PIaS4k9E/KB50z8YcRLpD0TyZAFOT7vsTwNvM1x5irZgTiLyidwCMH5Hl7g9XjSNIqBY=
Received: from CH0PR03CA0267.namprd03.prod.outlook.com (2603:10b6:610:e5::32)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 05:04:26 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::58) by CH0PR03CA0267.outlook.office365.com
 (2603:10b6:610:e5::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 05:04:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 05:04:26 +0000
Received: from [172.31.35.81] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 22:04:22 -0700
Message-ID: <a285463b-bfc8-4a5e-a233-5a87f8b3846a@amd.com>
Date: Fri, 10 Oct 2025 10:34:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/i386/amd_iommu: Fix handling device on buses != 0
Content-Language: en-US
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <philmd@linaro.org>, <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>, 
 <marcel.apfelbaum@gmail.com>, <eduardo@habkost.net>,
 <santosh.shukla@amd.com>, <aik@amd.com>
References: <20251008164324.21553-1-sarunkod@amd.com>
 <20251008164324.21553-2-sarunkod@amd.com>
 <3756479a-aec6-4fee-ab8e-7629f9d87960@oracle.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <3756479a-aec6-4fee-ab8e-7629f9d87960@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|MN2PR12MB4240:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a635ca-b0fa-498c-afb0-08de07ba7c20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UG5JOGdNNjliR2RzVm41bVQweDNabll3MkpZeSt6a1ZWM0dlcjQyb2NuYUd1?=
 =?utf-8?B?VVVtcFhVbWpOMmwwNlNWRmZIMkI5RGdnNjJ2TUErYlc5WGJQUGU0UHRUbFZI?=
 =?utf-8?B?WnJiNVk3YTFPdXlwbTdzL2FhVWIrN2lER2o0eHl3S004ZlY5NkhyTVR0VFJh?=
 =?utf-8?B?aFVQYWtheEN5OXExM09KOTBidTFyZFIxRUh2a210UWZxK0cvVXZKeWZTZlUy?=
 =?utf-8?B?STEwcklBOHd3STVON2s5SWpTdTlXbGdYOVkwUUZPNWVOa1AvUmlIU3JFWmZU?=
 =?utf-8?B?NW1sWDFKOXAyVDJCeWN4UDV5b2JtaFdKZXhGK0lwN1o5WnFQRFYwVDFUNGpB?=
 =?utf-8?B?RHZ3eG9HK3J0aEtCTGREb1RScTNrcFFqZXFTcXdGSTg1THdkWXpkK25nZ2ND?=
 =?utf-8?B?WkVsVWhaYnpGZHJ6c0U3QTF6cXlUU3RINys3N3VCUTlYQjB4K1pRbXYyR0hT?=
 =?utf-8?B?ZjhTWTVhYTlQeHR0bUFEL01xc2ZNRVVmY1pFQkdtNzF6QTZISU5jaTNxZm1y?=
 =?utf-8?B?U1IxQlN6TWZ2QXI4eU0weVJtMjNRaDRpK0FZRUZYRWZDNjNYbWw3R3piVW5a?=
 =?utf-8?B?bVpWZkJBWk9EOUZpV2ZldmprYTZhZzFvR2RQc1A2VGlpUzdtanU4TTkrLzh4?=
 =?utf-8?B?aDhxTlBPdlNLcC9zUVZudjFPVnRBVndCcEJoOEdlYTM0RWNEZFFWbVhreXpF?=
 =?utf-8?B?Sk1odTJYS0wwQmdabHE3TFUyLzlHQ1RHYzlRWnBwK3BVdEtUNG9URmo5bEVR?=
 =?utf-8?B?bDJnb1h6MFkyYW1qUkR0R0MwS0tydGtyZ1djRldRTUZCM04yUDhKNklZK3Uz?=
 =?utf-8?B?RUhYRGxkZk1uN2o2SlFnWmZOZUxXanRLUU93YUlCTXZqSUxiTGZ4Z1E1cDZ3?=
 =?utf-8?B?cEtrN29TRjY2akdLYVluM2JzaDM5L0Vabk5IL3ViOTFrc1Z3OGVxRDhsNTNq?=
 =?utf-8?B?S0pjVVh0Q1J6WTUzV2tqWVdvM0ErOXZ6c05VVWYwQi9lMkE4M0VmcUd2N3JC?=
 =?utf-8?B?TUpieGFCNUQvQlZVekpSc0VIZk5lcHUvaWtHRnJTeTJMUW5GczN6NnVNU0Yy?=
 =?utf-8?B?QlJvazFyQ0Ftd2EwRm5vcUVUVUxPekVIbENCdmREb2RuZjdpdkdGZkRzdzEx?=
 =?utf-8?B?bWlXK3JvY2krR0szVy9GSC9UVXJMQlBqaVMvZEJ4VlMyNkxiMmExeFVONm9M?=
 =?utf-8?B?Z0NnYkg4THQ2L1VhcEJBTXlKUi9NTkRpRzdHUWxmR05KdnYyWDJFWEN4VjFs?=
 =?utf-8?B?OW4yUFhBUzZqZ09pMFRZSGdaVHBabnZLNWplNmZBZ2ZBTmRZaWtnd0NyREJJ?=
 =?utf-8?B?Tkdpdkd5T1NuSmlFdHBHZlVhaVFKaHBiQjVIV21NeFNURzlQMjYyU21yNXdD?=
 =?utf-8?B?MkphOGpPTXYwZTBneW9iWTA0T3hDTFR4UStrRzMzTEU4NmMvaEZ1QldqSkNt?=
 =?utf-8?B?MmVvYlB4TUtCb3NPV1JLZGYvbVgvQXE1akl2MFdRUWM4WjhVQVBudU03MTlk?=
 =?utf-8?B?NXBzTi9SL3BVOSs3Uys2d2dtMUJxN0pNVnN2RUtXUjhVU1cydFBDVllTNlJF?=
 =?utf-8?B?cDJJTkhsQ3N5RUhPb2xtWFlBR2lVTHhKNXY2RncwSzdaTVNlWE15VUE3MEZa?=
 =?utf-8?B?N21iRGN1VFB6S3lxVVFlQjlCRVJlS1BUVDc5UmxoU25BRWlKMWRDbElGbUFJ?=
 =?utf-8?B?aGgxRWtIRWhDcE9RTjlRS1JIcWNlM3Y5Vi9WTzVrWVRXVEJJNUlVQlRHdzNI?=
 =?utf-8?B?ZEFYa1RlUlV3dkE0RTFzQ0lIQzF4c1M5cTNHSnlRcmk5OVVSVk0wZjMxWjFC?=
 =?utf-8?B?NUUvMzNUWnlxMGhvWlJrNkxoVXBNTkVDM2dWc1ZSYytIVkU0M1A2c0gvUXRr?=
 =?utf-8?B?OHhlQ21ubndzTW1XN2E4TUhVM21LallFQWY4YlY1TVd6b1JYNmt1VmtQWTdL?=
 =?utf-8?B?TXBBa2ZBelBPc3lUSU5tUVY2YkVVa3VGZDRsd0RqREhBUzIvNER2Mm93YzNX?=
 =?utf-8?B?M25ZV1pUbEt4aktFUmdjb05ZRGthZ1lzc0hRYngwak1MeEhpNElmYU85QzlQ?=
 =?utf-8?B?c1JIRjVidFN2dmUzZ0s3UW1VZkNpTG1uZEluSktTTzJFcWJBNllkdmtrdGs5?=
 =?utf-8?Q?GUJQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 05:04:26.0296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a635ca-b0fa-498c-afb0-08de07ba7c20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240
Received-SPF: permerror client-ip=52.101.52.57;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 10/9/2025 9:47 PM, Alejandro Jimenez wrote:
Hi alejandro
Thanks for reviewing

> Hi Sairaj,
>
> Good catch. This issue makes my Linux guest unusable due to kernel 
> watchdog errors. This patch fixes the problem.
> I have a few comments, but nothing that would fundamentally alter the 
> current behavior. Please see below...

Yep I also faced similar issue.

>
> On 10/8/25 12:43 PM, Sairaj Kodilkar wrote:
>> The AMD IOMMU is set up at boot time and uses PCI bus numbers + devfn
>> for indexing into DTE. The problem is that before the guest started,
>> all PCI bus numbers are 0 as no PCI discovery happened yet (BIOS or/and
>> kernel will do that later) so relying on the bus number is wrong.
>> The immediate effect is emulated devices cannot do DMA when places on
>> a bus other that 0.
>>
>> Replace static array of address_space with hash table which uses 
>> devfn and
>> PCIBus* for key as it is not going to change after the guest is booted.
>>
>> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> ---
>>   hw/i386/amd_iommu.c | 127 ++++++++++++++++++++++++++------------------
>>   hw/i386/amd_iommu.h |   2 +-
>>   2 files changed, 77 insertions(+), 52 deletions(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 378e0cb55eab..0a4b4d46d885 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -59,7 +59,7 @@ const char *amdvi_mmio_high[] = {
>>   };
>>     struct AMDVIAddressSpace {
>> -    uint8_t bus_num;            /* bus 
>> number                           */
>> +    PCIBus *bus;                /* PCIBus (for bus 
>> number)              */
>>       uint8_t devfn;              /* device 
>> function                      */
>>       AMDVIState *iommu_state;    /* AMDVI - one per 
>> machine              */
>>       MemoryRegion root;          /* AMDVI Root memory map 
>> region         */
>> @@ -101,6 +101,11 @@ typedef enum AMDVIFaultReason {
>>       AMDVI_FR_PT_ENTRY_INV,      /* Failure to read PTE from guest 
>> memory */
>>   } AMDVIFaultReason;
>>   +typedef struct amdvi_as_key {
>> +    PCIBus *bus;
>> +    int devfn;
>
> I'd prefer to use fixed types i.e. uint8_t for devfn. Keeps it 
> consistent with same field in other local structs and existing casts 
> in the code (e.g amdvi_host_dma_iommu()).
Sure will update it.
>
>> +} amdvi_as_key;
>> +
>>   uint64_t amdvi_extended_feature_register(AMDVIState *s)
>>   {
>>       uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
>> @@ -382,6 +387,42 @@ static guint amdvi_uint64_hash(gconstpointer v)
>>       return (guint)*(const uint64_t *)v;
>>   }
>>   +static gboolean amdvi_as_equal(gconstpointer v1, gconstpointer v2)
>> +{
>> +    const struct amdvi_as_key *key1 = v1;
>> +    const struct amdvi_as_key *key2 = v2;
>> +
>> +    return key1->bus == key2->bus && key1->devfn == key2->devfn;
>> +}
>> +
>> +static guint amdvi_as_hash(gconstpointer v)
>> +{
>> +    const struct amdvi_as_key *key = v;
>> +    return (guint)((uint64_t)key->bus | (key->devfn << 24));
>
> Any particular reason to build the hash in 'big endian' format?
> I don't see a problem as long it remains consistent, but it differs 
> from the encoding used by the PCI_* builder macros in pci.h, as well 
> as the vtd equivalent code.
>
> Additionally, using uintptr_t instead of uint64_t when casting 
> key->bus is a good way to document that we are hashing the pointer 
> value itself. In practice I don't see any scenario where there would 
> be a difference in behavior (the result is truncated anyways when 
> casting to guint), but
> technically/pedantically uintptr_t is correct choice to convert from a 
> data pointer.

There is no particular reason for it to be big endian,  I will make it 
consistent with pci.h

>
>
>> +}
>> +
>> +static AMDVIAddressSpace *amdvi_as_lookup(AMDVIState *s, PCIBus *bus,
>> +                                          int devfn)
>> +{
>> +    amdvi_as_key key = { .bus = bus, .devfn = devfn };
>> +    return g_hash_table_lookup(s->address_spaces, &key);
>> +}
>> +
>> +static int amdvi_find_as_by_devid(gpointer key, gpointer value,
>
> this should return a gboolean to exactly match the signature of the 
> predicate argument used by g_hash_table_find().
> gboolean is ultimately an int, but I don't know if a strict type 
> checking tool might complain now or in the future, and since we are 
> already using glib defined types we might as well keep it consistent.
>
>

Ack.

>> + gpointer user_data)
>> +{
>> +    amdvi_as_key *as = (struct amdvi_as_key *)key;
>> +    uint16_t devid = *((uint16_t *)user_data);
>> +
>> +    return devid == PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
>> +}
>> +
>> +static AMDVIAddressSpace *amdvi_get_as_by_devid(AMDVIState *s, 
>> uint16_t devid)
>> +{
>> +    return g_hash_table_find(s->address_spaces,
>> +                             amdvi_find_as_by_devid, &devid);
>> +}
>> +
>>   static AMDVIIOTLBEntry *amdvi_iotlb_lookup(AMDVIState *s, hwaddr addr,
>>                                              uint64_t devid)
>>   {
>> @@ -551,7 +592,7 @@ static inline uint64_t 
>> amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
>>     static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte)
>>   {
>> -    uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
>> +    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
>>       AMDVIState *s = as->iommu_state;
>>         if (!amdvi_get_dte(s, devid, dte)) {
>> @@ -1011,25 +1052,14 @@ static void 
>> amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as)
>>    */
>>   static void amdvi_reset_address_translation_all(AMDVIState *s)
>>   {
>> -    AMDVIAddressSpace **iommu_as;
>> -
>> -    for (int bus_num = 0; bus_num < PCI_BUS_MAX; bus_num++) {
>> -
>> -        /* Nothing to do if there are no devices on the current bus */
>> -        if (!s->address_spaces[bus_num]) {
>> -            continue;
>> -        }
>> -        iommu_as = s->address_spaces[bus_num];
>> +    AMDVIAddressSpace *iommu_as;
>> +    GHashTableIter as_it;
>>   -        for (int devfn = 0; devfn < PCI_DEVFN_MAX; devfn++) {
>> +    g_hash_table_iter_init(&as_it, s->address_spaces);
>>   -            if (!iommu_as[devfn]) {
>> -                continue;
>> -            }
>> -            /* Use passthrough as default mode after reset */
>> -            iommu_as[devfn]->addr_translation = false;
>> -            amdvi_switch_address_space(iommu_as[devfn]);
>> -        }
>> +    while (g_hash_table_iter_next(&as_it, NULL, (void **)&iommu_as)) {
>
> Lets keep the comment describing the behavior. This is something I 
> want to discuss in a separate thread...

Ahh right, I missed to add the comment after deleting the above part.

>
>            /* Use passthrough as default mode after reset */
>
>> +        iommu_as->addr_translation = false;
>> +        amdvi_switch_address_space(iommu_as);
>>       }
>>   }
>>   @@ -1089,27 +1119,21 @@ static void 
>> enable_nodma_mode(AMDVIAddressSpace *as)
>>    */
>>   static void amdvi_update_addr_translation_mode(AMDVIState *s, 
>> uint16_t devid)
>>   {
>> -    uint8_t bus_num, devfn, dte_mode;
>> +    uint8_t dte_mode;
>>       AMDVIAddressSpace *as;
>>       uint64_t dte[4] = { 0 };
>>       int ret;
>>   -    /*
>> -     * Convert the devid encoded in the command to a bus and devfn in
>> -     * order to retrieve the corresponding address space.
>> -     */
>> -    bus_num = PCI_BUS_NUM(devid);
>> -    devfn = devid & 0xff;
>> -
>>       /*
>>        * The main buffer of size (AMDVIAddressSpace *) * 
>> (PCI_BUS_MAX) has already
>>        * been allocated within AMDVIState, but must be careful to not 
>> access
>>        * unallocated devfn.
>>        */
>
> I think this block comment can be removed now that we have a better 
> interface to retrieve the address space.

Right thanks for noticing, will remove it.

>
>> -    if (!s->address_spaces[bus_num] || 
>> !s->address_spaces[bus_num][devfn]) {
>> +
>> +    as = amdvi_get_as_by_devid(s, devid);
>> +    if (!as) {
>>           return;
>>       }
>> -    as = s->address_spaces[bus_num][devfn];
>>         ret = amdvi_as_to_dte(as, dte);
>>   @@ -1783,7 +1807,7 @@ static void 
>> amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
>>                                  bool is_write, IOMMUTLBEntry *ret)
>>   {
>>       AMDVIState *s = as->iommu_state;
>> -    uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
>> +    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
>>       AMDVIIOTLBEntry *iotlb_entry = amdvi_iotlb_lookup(s, addr, devid);
>>       uint64_t entry[4];
>>       int dte_ret;
>> @@ -1858,7 +1882,7 @@ static IOMMUTLBEntry 
>> amdvi_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
>>       }
>>         amdvi_do_translate(as, addr, flag & IOMMU_WO, &ret);
>> -    trace_amdvi_translation_result(as->bus_num, PCI_SLOT(as->devfn),
>> +    trace_amdvi_translation_result(pci_bus_num(as->bus), 
>> PCI_SLOT(as->devfn),
>>               PCI_FUNC(as->devfn), addr, ret.translated_addr);
>>       return ret;
>>   }
>> @@ -2222,30 +2246,28 @@ static AddressSpace 
>> *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>>   {
>>       char name[128];
>>       AMDVIState *s = opaque;
>> -    AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
>> -    int bus_num = pci_bus_num(bus);
>> +    AMDVIAddressSpace *amdvi_dev_as;
>> +    amdvi_as_key *key;
>>   -    iommu_as = s->address_spaces[bus_num];
>> +    amdvi_dev_as = amdvi_as_lookup(s, bus, devfn);
>>         /* allocate memory during the first run */
>> -    if (!iommu_as) {
>> -        iommu_as = g_new0(AMDVIAddressSpace *, PCI_DEVFN_MAX);
>> -        s->address_spaces[bus_num] = iommu_as;
>> -    }
>> -
>> -    /* set up AMD-Vi region */
>> -    if (!iommu_as[devfn]) {
>> +    if (!amdvi_dev_as) {
>>           snprintf(name, sizeof(name), "amd_iommu_devfn_%d", devfn);
>>   -        iommu_as[devfn] = g_new0(AMDVIAddressSpace, 1);
>> -        iommu_as[devfn]->bus_num = (uint8_t)bus_num;
>> -        iommu_as[devfn]->devfn = (uint8_t)devfn;
>> -        iommu_as[devfn]->iommu_state = s;
>> -        iommu_as[devfn]->notifier_flags = IOMMU_NOTIFIER_NONE;
>> -        iommu_as[devfn]->iova_tree = iova_tree_new();
>> -        iommu_as[devfn]->addr_translation = false;
>> +        amdvi_dev_as = g_new0(AMDVIAddressSpace, 1);
>> +        key = g_new0(amdvi_as_key, 1);
>>   -        amdvi_dev_as = iommu_as[devfn];
>> +        amdvi_dev_as->bus = bus;
>> +        amdvi_dev_as->devfn = (uint8_t)devfn;
>> +        amdvi_dev_as->iommu_state = s;
>> +        amdvi_dev_as->notifier_flags = IOMMU_NONE;
> Keep IOMMU_NOTIFIER_NONE. It is the correct type, as you pointed out 
> in a previous patchset.

Ahh right. I missed to update that field while rebasing patches from V2 
of your series to master

Thanks
Sairaj

