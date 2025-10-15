Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76819CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 04:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8tOE-0006qS-MB; Wed, 15 Oct 2025 00:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v8tOC-0006oh-0d
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 00:45:28 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v8tO2-0005Ja-SA
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 00:45:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCRY/gvZYfKr9dQXjkHJUrzTIDQI9t3n9dcsH4iPNhpFvIXZLPRfRcI+ORSUVrrcygTxxGIVSKdSdbqJR31ePPSj/YdzaA/MUyLmkL3Zaa+nWOvuhwhcx6jEq9OaaPF+OQme6Pe0fc1B0ZoaNoZ/e6Ok1Z3iL45gEnjZ2MwLSXzQYJ8ge/E9bOtCrrQK/DJnWXOvTl2WyF3fSEdMpM6cLDCpbJCYCTtm1oG376y8l6TS3VyLkZ06dAKA6zoLdyM9c24Vn/kNRipbrTocOP97seHcstI53LqJoMXMzrt3DtolR43zUMsaKAnjvIB97xp9fKmrGyHz7gBNCdKpKnsvoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byOO4BAuIaSmhjGKmlboMEU+M+Ecn4tqC42vLZBqmLI=;
 b=IcAgPqTmWI1Kel/URj3EctBPMdkgUpWfKYKj+No6T9GzMH3do5SR18eXF9THMI1aaS2AuP7qyI9tZ14UZm9s50yxJaZiAb74RRpM8dHKhjMKqJGOZHa9Z3vwwI5lTMo/4Rw87OO93ACNybPq50c2b+35wkulHsfu87y9aYAaVbnN2fwjUgTTDU/SRn6k5beRIM2w1gHr56XRMBR2CZdgtkXusIe2mKHoG8GXtmZ6R4r34aPpdCTg3ZatdZSOf00ArR5xgiI7w4w7u1g9yZlaiWs/ofzBbtFbdHe5SxoX/73D8pIhqCMRzn8Q8zz2k5FDK0yeUwoKa1o015d26YFTxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byOO4BAuIaSmhjGKmlboMEU+M+Ecn4tqC42vLZBqmLI=;
 b=XgwydI+V7AXV21aiigGgfatlorhIonfFuA4ljQvZjK9KXHAxwBeJR/DZPryjZctej8IvG1LR1cqSRKzFNDY8yW0ccM9sO6W7f/iNJXRpfzbRgJi/QM5nK41WXkKwAqjNuZNTGi7sLnOOZHyEcbDyFNy1D3zHBV/Aoox63T78IkY=
Received: from PH8PR02CA0006.namprd02.prod.outlook.com (2603:10b6:510:2d0::23)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 04:44:59 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::8d) by PH8PR02CA0006.outlook.office365.com
 (2603:10b6:510:2d0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Wed,
 15 Oct 2025 04:44:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 04:44:57 +0000
Received: from [172.31.35.81] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 21:44:53 -0700
Message-ID: <e9fa3517-a33b-4d7f-9a06-e334c4ebae1f@amd.com>
Date: Wed, 15 Oct 2025 10:14:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] amd_iommu: Fix handling device on buses != 0
Content-Language: en-US
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
 <marcel.apfelbaum@gmail.com>, <eduardo@habkost.net>, <aik@amd.com>
References: <20251013050046.393-1-sarunkod@amd.com>
 <20251013050046.393-2-sarunkod@amd.com>
 <20251013041059-mutt-send-email-mst@kernel.org>
 <6fa9b33c-31ff-43f6-8ab1-8d200c832c94@amd.com>
 <20251014050023-mutt-send-email-mst@kernel.org>
 <c585b4c2-5bde-4aff-a3b0-370bae5e9c0d@oracle.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <c585b4c2-5bde-4aff-a3b0-370bae5e9c0d@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 50351eb8-69e3-4605-3f00-08de0ba597bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGtvV3E3NmZOL1dHWVJ2TFkvMFBPYmdOWTNhc3dNL0dzbytkR0FjUlh2ckNh?=
 =?utf-8?B?MnpKZEtPblF6NjBzcnZTZXlBWWpPa2JpYkFob0dQdnZORXB0bzFRWXdNZ2s1?=
 =?utf-8?B?SDRiZEpzb251NW91V2RibXpBNFpvc05yZ2svN2JaWUxib3QwS2Zoa3dqL3BW?=
 =?utf-8?B?V1dpNng5K0FDRFJ6OGdOTmdtbXQ1cmZ3a3hXOFNOMFRlR0lxUWJzN29oeGx1?=
 =?utf-8?B?aDhyd3NPMzBuRjNYcExhRFZZRFI4K3JtaDMyYkROZUd6K2ZvYmpieVhkQ1BF?=
 =?utf-8?B?Z1liUThqRFAyL2xrUFhScjNoRGt0UG91Yk4yNDZIMklQeXlwdFplL0czREhU?=
 =?utf-8?B?a3BVNlhXSVE5bWFtdUNqbWlVNGdYRURyM2RMcnRCN2NZRXI1RkhJelVzclZZ?=
 =?utf-8?B?TEIxb0RTNlNJcUlSYkxqcjRQNE1OS2M4K3dUeHBqOEJtemhzWC9RUzhGNHU4?=
 =?utf-8?B?emVRWU5SY2RJQm9zQVM3d1JyN2tPeTIvRExyL1pNQXhlOWZKRGk0MjQzMjk5?=
 =?utf-8?B?bml2dmRmMXFodVlrdXFYR0pVbUJ5R3NzaFhTVVBXQW1rRGI4MldPYWsvK2hY?=
 =?utf-8?B?Y2RrbW05WTQ2aC90dHVJbHdSTkplZlk3ai9MVG0rTTJ0amJTVVdXS0VFc291?=
 =?utf-8?B?S3ZiYUFjVUE4MHRDN3hBeEhJR0x3ckZYbHJUNGE2RnpIY1FESTM4ODFpcFYw?=
 =?utf-8?B?ZkJuc3NoRDNQZmdEbVlPdlVZbHdlRlZMM1hSVE9DV3UzWkFmZ25TQTE4SWtW?=
 =?utf-8?B?L05lU2t4MXRlNmQ2ZzJkUlpXM3JEYlhQVXdPRmFFVHpialYrcnordXpBL1dm?=
 =?utf-8?B?OEFmS2R6SGQ1MnJBaTZTQmgwY1c0dnNiRm5UYWxhdEN4YktyT05VYUVRdGlG?=
 =?utf-8?B?VWdISHY2bXRFekFGeVVFR3VGVE5RWDB2cmRtakVvem5RdUN0UUV5OUh0a01z?=
 =?utf-8?B?THRRZGRGMXhjd3B0MWp5T2JCWWxyTkxseHBvYjhUNUxxRGtEWmZ0RTZ5UXRW?=
 =?utf-8?B?K0d2RU1OQ2V1U0t5VXhHME4zU3RpWGI2VDRCTE5ld1ZwYkhNUENtb3FNSjB0?=
 =?utf-8?B?UXlDb09NbmlBUUVkQ2luN0l1QjhxT1g4bkVicWg2MCs0a1hRcFJDYzM0OWJr?=
 =?utf-8?B?aTE5YjNjejFzWkV4eFRDVWpsK3hYN0tDV2YyY1VOOWdXbU9jdFJYSnNLa3hx?=
 =?utf-8?B?SmRnQXVZcmZabEExbldmalhzTm43UThqNElaUjRpZ2VIQzBoM0dHL3ljanJI?=
 =?utf-8?B?VHN4b0E0WGthWkIrWlhOU2FwZEtOWlA4NWY4UHpDQUJUNXFpdFJmR1V5K0Mw?=
 =?utf-8?B?NWMzV1BPY2dLWVpSTFd6cDh5bEd1M01sbHRIRmFxZHlrdnpBQW9lU1I0dGJT?=
 =?utf-8?B?SjJwNEQ4NTVlNytReHV1QlBPK0JmN1JMaVN4eWRxT0pBQkViVjA3dHRldjM3?=
 =?utf-8?B?dkJ5OEN1djl4T29kc3BLMTFhdlZGQk95L2QyN2pPTmZZLzdudThjQ0MwWHZZ?=
 =?utf-8?B?c25iQ3pxOG9adlJwNWJkbXllWTRhN1Rsb1ZwVjEzaEhuWGV6VXpDNzhDamFp?=
 =?utf-8?B?NDR3RUtBT3pRWHVrTm0vb3V0eXZxT0Z2Y09VR09QdWNPR0V0Z2RDaEhZeGJG?=
 =?utf-8?B?ZFBhNS91V3h6WUZIVnJJeUQrRFpOaHM2Y3Awd2ZmNEVmWER0UHFlSkpodGJ6?=
 =?utf-8?B?R1VNR3NqYXdaaU9kbTA1TVVyRmpMcTBDaS9tUXVUTE1aM1N4eVc1dE8rOEdZ?=
 =?utf-8?B?VGFqMERENmhJK3huUVVvZElMSy92UmU1VGJjbk4zVVJET2tjMUt1Ly9SdDVy?=
 =?utf-8?B?ZE81K0UzZkVMN1NoUy9FT05KOElVY1Z1ZkdISkE2aE50Qlc3U1hRSU5vcVAy?=
 =?utf-8?B?YnlGRjV3UGpsTm1NT0ZsTDBFQ2JDNEtxTXA2VzlGUFpuNU5LUWxuTzZNR3F1?=
 =?utf-8?B?UktPV292ZlBLVHIzdXl3cmVzM2QrRU01ZEVOSUI4RWc4Zk04VWY4VXl1bEtT?=
 =?utf-8?B?dUlSOUo3ZXYrNVhWWEU4emFoSFlPODUySUNTemdYUUtMZzRFSndSZVhEUlda?=
 =?utf-8?B?VCtBd2VIZHloRzFrV2prL212WUpCMmlReEc5QU9ZbEpaeDZ6NThvUURFS1Z5?=
 =?utf-8?Q?q1dE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 04:44:57.5939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50351eb8-69e3-4605-3f00-08de0ba597bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
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



On 10/15/2025 3:16 AM, Alejandro Jimenez wrote:
>
>
> On 10/14/25 5:02 AM, Michael S. Tsirkin wrote:
>> On Tue, Oct 14, 2025 at 11:13:51AM +0530, Sairaj Kodilkar wrote:
>>>
>>>
>>> On 10/13/2025 1:45 PM, Michael S. Tsirkin wrote:
>>>> On Mon, Oct 13, 2025 at 10:30:45AM +0530, Sairaj Kodilkar wrote:
>>>>> The AMD IOMMU is set up at boot time and uses PCI bus numbers + devfn
>>>>> for indexing into DTE. The problem is that before the guest started,
>>>>> all PCI bus numbers are 0 as no PCI discovery happened yet (BIOS 
>>>>> or/and
>>>>> kernel will do that later) so relying on the bus number is wrong.
>>>>> The immediate effect is emulated devices cannot do DMA when places on
>>>>> a bus other that 0.
>>>>>
>>>>> Replace static array of address_space with hash table which uses 
>>>>> devfn and
>>>>> PCIBus* for key as it is not going to change after the guest is 
>>>>> booted.
>>>> I am curious whether this has any measureable impact on
>>>> performance.
>>>
>>> I dont think it should have much performance impact, as guest 
>>> usually has
>>> small number of devices attached to it and hash has O(1) average 
>>> search cost
>>> when hash key function is good.
>>>
>>>>
>>>>> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
>>>>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
>>>>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>>>>
>>>> love the patch! yet something to improve:
>>>>
>>>>> ---
>>>>>    hw/i386/amd_iommu.c | 134 
>>>>> ++++++++++++++++++++++++++------------------
>>>>>    hw/i386/amd_iommu.h |   2 +-
>>>>>    2 files changed, 79 insertions(+), 57 deletions(-)
>>>>>
>>>>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>>>>> index 378e0cb55eab..b194e3294dd7 100644
>>>>> --- a/hw/i386/amd_iommu.c
>>>>> +++ b/hw/i386/amd_iommu.c
>>>>> @@ -59,7 +59,7 @@ const char *amdvi_mmio_high[] = {
>>>>>    };
>>>>>    struct AMDVIAddressSpace {
>>>>> -    uint8_t bus_num;            /* bus 
>>>>> number                           */
>>>>> +    PCIBus *bus;                /* PCIBus (for bus 
>>>>> number)              */
>>>>>        uint8_t devfn;              /* device 
>>>>> function                      */
>>>>>        AMDVIState *iommu_state;    /* AMDVI - one per 
>>>>> machine              */
>>>>>        MemoryRegion root;          /* AMDVI Root memory map 
>>>>> region         */
>>>>> @@ -101,6 +101,11 @@ typedef enum AMDVIFaultReason {
>>>>>        AMDVI_FR_PT_ENTRY_INV,      /* Failure to read PTE from 
>>>>> guest memory */
>>>>>    } AMDVIFaultReason;
>>>>> +typedef struct amdvi_as_key {
>>>>> +    PCIBus *bus;
>>>>> +    uint8_t devfn;
>>>>> +} amdvi_as_key;
>>>>> +
>>>>>    uint64_t amdvi_extended_feature_register(AMDVIState *s)
>>>>>    {
>>>>>        uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
>>>>
>>>> Pls fix structure and typedef names according to the QEMU
>>>> coding style. Thanks!
>>>>
>>>
>>> This is something I am struggling with, because the name
>>> `AMDVIASKey` does not offer readability.
>>
>> AMDVIAsKey
>>
>>
>> Or you can update all code to use AmdVi and get AmdViAsKey if you 
>> prefer.
>>
>>
>>> Maybe we can come
>>> up with an alternate style which is readable and does not
>>> differ much from the current style.
>>>
>>> @alejandro any suggestions ?
>>>
>
> I should have pointed out the CamelCase requirement for the typedef on 
> v1. My initial reaction was: "do not use typedef" and go with the 
> slightly longer 'struct amdvi_as_key' instead. The style guide has a 
> warning about typedefs (which doesn't necessarily apply here), but IMO 
> still better to avoid it in this case were we are not really gaining 
> much from it.
>
> If I were to use a typedef I would use 'AMDViAsKey'. After all, the 
> 'i' in AMD-Vi and 'd' in VT-d are lowercase ;)
>
> But my opinion is to avoid the typedef altogether.
>
>>>>> @@ -382,6 +387,44 @@ static guint amdvi_uint64_hash(gconstpointer v)
>>>>>        return (guint)*(const uint64_t *)v;
>>>>>    }
>>>>> +static gboolean amdvi_as_equal(gconstpointer v1, gconstpointer v2)
>>>>> +{
>>>>> +    const struct amdvi_as_key *key1 = v1;
>>>>> +    const struct amdvi_as_key *key2 = v2;
>>>>> +
>>>>> +    return key1->bus == key2->bus && key1->devfn == key2->devfn;
>>>>> +}
>>>>> +
>>>>> +static guint amdvi_as_hash(gconstpointer v)
>>>>> +{
>>>>> +    const struct amdvi_as_key *key = v;
>>>>> +    guint bus = (guint)(uintptr_t)key->bus;
>>>>> +
>>>>> +    return (guint)(bus << 8 | (uint)key->devfn);
>>>>> +}
>>>>> +
>>>>> +static AMDVIAddressSpace *amdvi_as_lookup(AMDVIState *s, PCIBus 
>>>>> *bus,
>>>>> +                                          uint8_t devfn)
>>>>> +{
>>>>> +    amdvi_as_key key = { .bus = bus, .devfn = devfn };
>>>>> +    return g_hash_table_lookup(s->address_spaces, &key);
>>>>> +}
>>>>> +
>>>>> +gboolean amdvi_find_as_by_devid(gpointer key, gpointer value,
>>>>> +                                  gpointer user_data)
>>>>> +{
>>>>> +    amdvi_as_key *as = (struct amdvi_as_key *)key;
>>>> this assignment does not need a cast I think.
>>>>
> Agree. And assuming you take my advice of not using a typedef, the 
> line should be:
>
> const struct amdvi_as_key *as = key;
>
> to follow the style guide directive of using "const-correct" pointers. 
> Putting back the static qualifier from my earlier reply:
>
> static gboolean amdvi_find_as_by_devid(gpointer key, gpointer value,
>                                        gpointer user_data)
> {
>     const struct amdvi_as_key *as = key;
>     const uint16_t *devidp = user_data;
>
>
>     return *devidp == PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
> }
>

Sure. From now on we will avoid typedefs in the AMD-Vi and I liked your 
suggestion of
'struct AMDViAsKey'. Should I update entire code with this new naming 
style ?

Thanks
Sairaj

> Thank you,
> Alejandro
>
>>>>> +    uint16_t devid = *((uint16_t *)user_data);
>>>> would be better like this:
>>>>         uint16_t * devidp = user_data;
>>>> then just use *devidp instead of devid.
>>>
>>> sure
>>>
>>> Thanks
>>> Sairaj
>>
>


