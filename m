Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B20CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 05:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8XuX-0006lx-8k; Tue, 14 Oct 2025 01:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v8XuP-0006lY-DZ
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 01:49:18 -0400
Received: from mail-eastusazon11011045.outbound.protection.outlook.com
 ([52.101.52.45] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v8XuL-0000cM-9M
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 01:49:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3acLg1WeuRXH1RS6QK5lSRkpq0LUhcdXfoD9niKqaLZ3WiNBU2XCuyLCRAhKbjuZpGqvkWTaQDA5hi7D0ZBKGflaSfrF2tQW8GPz9FWSn4QyX//Ld+K/1W+148jtLqDw0g2Gjc14lSlH6DcITxZyFllEdmmM7BJzN0CP3wBn18YmHEFx3ZRLs9eBNIrSsvvrSNXb330F8VbRb6U81GkqQZviBI9WKV8pcIekRdV2KZpbaSGdP5VALKhGigeNKM4sXIp2oghiPao3389zttfJiO1wQfW6NFxwbm6I2jezLVIZzmIs90Msnh77/ptbnWIye15LshYKTtaZamRq3MdGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlfPxoF49mjgAh5ZYy20PkUlQMq9bJ16y9I1KzUfSNk=;
 b=xVNDUSSzrFx+TrSKRipSg6HbuoQjTVbLujziNqbLDT+GbBXFhILtVvaYlQmIvHVKdOogBGpAsOP5vqpEeEt9c0uOtR2WM3RIbCIqNVlGGw2anAYhFtuPHbl1o6mJmgB/yCSsZ1MhZ8oHP4lrBNBAKMm0DSgm7MAPOVHTpxW81YnA1oYghGZPJl3S2fOiRTUSwf53Df12GL+A/FklTZ0yzRAtrbSnopJ93BP2TU90bOFBQ/9V7ROj/Odp1zQQerTi3xRWnPzf64+luiU5S49FMY93Bwo7HpOzaFtD9m11W5EZEU+biJoqrNB2bff7CB9GxvVnPyYOGnZo5ikgKqZWFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlfPxoF49mjgAh5ZYy20PkUlQMq9bJ16y9I1KzUfSNk=;
 b=Tl/2ITxQq3VH7JtnTkGy2gTiBtOlNbz+j0R+gRZUYk46I0s4NpKd5worj7Of0tmBUHEF8BNQmdNydUg+I2R97S4y0lV9LWs+Tenz3lsbBiRjWxZkFE3j6N80e1wXE52/ij84AQ5ZX6QOo1OrBA54MqCVRN0Lh9oBXpOGhSUSTTA=
Received: from SN7PR04CA0224.namprd04.prod.outlook.com (2603:10b6:806:127::19)
 by DM6PR12MB4089.namprd12.prod.outlook.com (2603:10b6:5:213::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 05:44:03 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::f0) by SN7PR04CA0224.outlook.office365.com
 (2603:10b6:806:127::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Tue,
 14 Oct 2025 05:44:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Tue, 14 Oct 2025 05:44:02 +0000
Received: from [172.31.35.81] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 22:43:59 -0700
Message-ID: <6fa9b33c-31ff-43f6-8ab1-8d200c832c94@amd.com>
Date: Tue, 14 Oct 2025 11:13:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] amd_iommu: Fix handling device on buses != 0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, <alejandro.j.jimenez@oracle.com>,
 <pbonzini@redhat.com>, <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
 <marcel.apfelbaum@gmail.com>, <eduardo@habkost.net>, <aik@amd.com>
References: <20251013050046.393-1-sarunkod@amd.com>
 <20251013050046.393-2-sarunkod@amd.com>
 <20251013041059-mutt-send-email-mst@kernel.org>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20251013041059-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|DM6PR12MB4089:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b51a761-5eef-4991-38e4-08de0ae4ae82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUNIbzNqMm9Wa0F4cHZvbVExdFdDWXlqczdBQmRPSUl2dVFVUlQ1eDRRclBt?=
 =?utf-8?B?UVc0T2tWbEk1TmZRNTdmYjYyekpPRlhqd0M2MTNRdUVqdDBkaVZFMGxTNHJ0?=
 =?utf-8?B?YjByeXZzUURtN1BpRVN6alJBSE9oNTJRa3gwS0pCbitOV2lSOElBVm83NFMz?=
 =?utf-8?B?YnhCUnFMaUx1cml3UThmWFltYW9wM1hNbStJdTJrZlRnOU1pTVlDVzdoUFFr?=
 =?utf-8?B?WUpML3JMZ3hNbFhmcWh1eXloMUlxT1ZMK093K3UzMFNtTU9ZYmltaTI4NThs?=
 =?utf-8?B?L001ck5aZ1FjanAwZE9lQUZ1WEM4Q21GdUY0dm1TVUFCNVBYQnhzZ0FSS0xW?=
 =?utf-8?B?UE9qUjFUWm8xM3o4RDJYVWNnNktKVUV5MDZsU1Z0dzFmOUM0cWFWZXBpN3Nw?=
 =?utf-8?B?cm80UW9pOWR0Q0xlN1FUeENuZlFtYXF5bGxtMnErTWd1eEl0TkEzOVJVRjBT?=
 =?utf-8?B?dWh3MmQzcjc5WEplNmIwNUtGalJVSVhvTDNXNXR1S2haU3lwdWthTjczalpH?=
 =?utf-8?B?TEVwUjkyZ0VNcmY0aFgwR0NrZnRHOVA4NU9Ud2xRcExBaGpJaTdiOUZrbnRG?=
 =?utf-8?B?Ulhra01Hbkh0S1N4NklBY2ljZzF5ZHFBTCtyYk1RRGpjZzRDYWEvTlkvWlFX?=
 =?utf-8?B?TFEvNVFRZlFwNDNTYm5nZmpyWEZPWWpxT3JjMDhyQjNEb21vMFdYcTkvbDA1?=
 =?utf-8?B?Ris5R2txWForTDloMlQyQTk3WU9SdVhtVDI4UkdROThoejVlOE9RYWtVRVVY?=
 =?utf-8?B?MHdOYml6VGZqS0lxK080YkRBVERmQzJ1bmIzM0pEZ3MxTkZ1NGVGbi9KVW9X?=
 =?utf-8?B?aXB4VFdTWTFlcld5dFVOZ1pVUGVBOEZQYU01MjFQTXRLNUFDZlhlMEFvWkY5?=
 =?utf-8?B?UDVpd1Z6eGhzNVJ5Q2k4OVNKUVIwUUkrbE9CWXVRSitPWUNmQU5zQXVneEsw?=
 =?utf-8?B?NkdwTTFra1h3Uktsc0JsR21CcTV4QU5lV3NSN1A2NkQ4dTNlWXpQK1d6Mm1B?=
 =?utf-8?B?UW1LakFsMzNKcXRQL2dkQmxGYkgyYTN6c0RmcHFmY1hrcXhCMjgzMFpYanJP?=
 =?utf-8?B?dzkvVnJtVkpxR3haOGdWUWZKdnJ5OW03WUY4cGhjaEZYK1BZY1VYMmwzUjdp?=
 =?utf-8?B?M2MwRFFlYzBTWHlMR3A0QkE0dDBUQ0w3aHV0QUFXdDBESkpkbUt1ZmVFcWla?=
 =?utf-8?B?Q0ZocURkWE1kclRnYjBhVzRnc2s1WVpoVTZ3d3JUejVvbmhMVUlCRVY3MkRX?=
 =?utf-8?B?WXZjdFJlR3VSbGFEL2VZNG5PTTRJSVR3NlZOd0hwMHY3d1pDRityODZnRXpv?=
 =?utf-8?B?U3BYMnUrMnZaS1EzR05vZmJPbE11NVNxOU0vcnB6UjVpQmVNajkvemVVaUFB?=
 =?utf-8?B?amFLdk81KzUxTkxlT084TTk3QTVTdU9lQklCOWU4WUQ4dVVBenNtMGJSRU5G?=
 =?utf-8?B?bHVSaDVhWEI4amFSR2tQNmtQc25td1J5dENWeXZwV0I5ODd1cyt1V1hHKzdX?=
 =?utf-8?B?RG5MUTU5V29wMDVvNE1sVzBqT1M4ZmhJMVoxRy9wMUl6T2ZySVVjb1VtcXhD?=
 =?utf-8?B?YU9nZHdqQWR5MzEzTCtoYUNzWmpxem1pYnRFTm8weU8wbGdUZk5IUXlpSEtH?=
 =?utf-8?B?YTBVRXNVcTVKRDdIbTR0dWYvZkF2MCtaSStPQ3ZiK3JDeU1nUVJSbmtVNEpu?=
 =?utf-8?B?ZFEwcmFwNzhuTnhaTTk2MGdaaTNpQ29vN2ZzUjYreXVyUkdLaUlOckp0c1Fs?=
 =?utf-8?B?cW9pUmd5aVVrWnBabi93MmxmMGd1UXNURjA0Y2Vld1N4SWxlTThZZlNyenUr?=
 =?utf-8?B?UXE0ays0MGVxQ2N1QVZUa3htSUJLK0t3VE1jQWxtQy9BYVBPblF0cUJaTTZZ?=
 =?utf-8?B?bnlsaEoxYVdSeDF0TTUrWVJkWU5tcVkyTXhSWUQxbGQ1UGxxVHQ2eXJpcUpE?=
 =?utf-8?B?Y3d1MEMxUFdTaHVxRXdYOW5CSGlqV2l6RVhTWTErcDhlU2pjdkliTUVxTy9o?=
 =?utf-8?B?OU1oUklUWXdXZkVycU8yd2I5QmJFb0RUUXpDYVFsRitmU0Q5ekVBclloTUZD?=
 =?utf-8?B?OTdoWk4rV09hZTJOb29OOVRzdTFsNmlaaUxBQWVSMURyc0RQLzF1MlByRDEy?=
 =?utf-8?Q?AB9o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 05:44:02.9421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b51a761-5eef-4991-38e4-08de0ae4ae82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4089
Received-SPF: permerror client-ip=52.101.52.45;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 10/13/2025 1:45 PM, Michael S. Tsirkin wrote:
> On Mon, Oct 13, 2025 at 10:30:45AM +0530, Sairaj Kodilkar wrote:
>> The AMD IOMMU is set up at boot time and uses PCI bus numbers + devfn
>> for indexing into DTE. The problem is that before the guest started,
>> all PCI bus numbers are 0 as no PCI discovery happened yet (BIOS or/and
>> kernel will do that later) so relying on the bus number is wrong.
>> The immediate effect is emulated devices cannot do DMA when places on
>> a bus other that 0.
>>
>> Replace static array of address_space with hash table which uses devfn and
>> PCIBus* for key as it is not going to change after the guest is booted.
> I am curious whether this has any measureable impact on
> performance.

I dont think it should have much performance impact, as guest usually has
small number of devices attached to it and hash has O(1) average search cost
when hash key function is good.

>
>> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>
> love the patch! yet something to improve:
>
>> ---
>>   hw/i386/amd_iommu.c | 134 ++++++++++++++++++++++++++------------------
>>   hw/i386/amd_iommu.h |   2 +-
>>   2 files changed, 79 insertions(+), 57 deletions(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 378e0cb55eab..b194e3294dd7 100644
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
>> +    uint8_t devfn;
>> +} amdvi_as_key;
>> +
>>   uint64_t amdvi_extended_feature_register(AMDVIState *s)
>>   {
>>       uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
>
> Pls fix structure and typedef names according to the QEMU
> coding style. Thanks!
>

This is something I am struggling with, because the name
`AMDVIASKey` does not offer readability. Maybe we can come
up with an alternate style which is readable and does not
differ much from the current style.

@alejandro any suggestions ?

>> @@ -382,6 +387,44 @@ static guint amdvi_uint64_hash(gconstpointer v)
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
>> +    guint bus = (guint)(uintptr_t)key->bus;
>> +
>> +    return (guint)(bus << 8 | (uint)key->devfn);
>> +}
>> +
>> +static AMDVIAddressSpace *amdvi_as_lookup(AMDVIState *s, PCIBus *bus,
>> +                                          uint8_t devfn)
>> +{
>> +    amdvi_as_key key = { .bus = bus, .devfn = devfn };
>> +    return g_hash_table_lookup(s->address_spaces, &key);
>> +}
>> +
>> +gboolean amdvi_find_as_by_devid(gpointer key, gpointer value,
>> +                                  gpointer user_data)
>> +{
>> +    amdvi_as_key *as = (struct amdvi_as_key *)key;
> this assignment does not need a cast I think.
>
>> +    uint16_t devid = *((uint16_t *)user_data);
> would be better like this:
> 	    uint16_t * devidp = user_data;
> then just use *devidp instead of devid.

sure

Thanks
Sairaj

