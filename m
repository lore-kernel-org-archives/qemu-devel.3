Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F7BCFA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 05:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMJex-0006kJ-Q9; Fri, 21 Nov 2025 00:26:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vMJew-0006hG-8i
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 00:26:14 -0500
Received: from mail-centralusazon11010061.outbound.protection.outlook.com
 ([52.101.61.61] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vMJet-0004YQ-Uc
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 00:26:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYH413jUgrhMkLOnVJEl+cpfdv/K9jqtGZTM/h55QiEYCl4ajHOEm6/O5B4g/TY3pbZDuP5qKIRZoZlSeqAbphxadQ3c0l5S4zORANC5byIoWV+3PZUykHOtjWOkUxXbNGm1h66ztYJ9M9bg/hteuI56yqsg3pjXt6tVBjwfbSbWnK0M3Nq3s7NHCjLtc4xUAoFmg/IHNfrocfdmy1lHWd6iFqS/ug0LZEegrBlH/u+OikPeZm8kvbbEIJnwxvk5P6DJDbZS/O3svji8pm8BdQb+4WeYteHLaFpYXVpaPeHP06Pq3NnerU5vT3cdIfAPAL5omn6Dv8+1E1TJleVRcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1TmsMR9JJXOwiq4wmLaUWiJozqul/f2s7VlsRH64mw=;
 b=bR6E6KMMoCuGwpKVL2NoC7mpGpHCwu30EaGAQaaXwdYRA4ShPsCcwA7l93x9gi2i7le5f+tHt8eE7mmYdSDeM9j2stWE7jtXA35eYbACAZB+ZoCxTVTU62ti5+kIzExW7uDIJMhCJiL9xj26LEhMSeaxYvIct87SNUoagoFd8H/AAMJPMrclLZnkFqGlWy6C/toNAX37PK55FE1eg+7Ac1VvkQ8r3cD0JpGDP3bjn60WzJyXWEEgrASmZyyvB1jk4pMCSf1moXkw2MrXS0tZ/sZuF0b0n4ZChW16EpNzu7leiGBEZmaH8VqdjguV3DXy+ny11KIUfUgkfOmgsm3Wow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1TmsMR9JJXOwiq4wmLaUWiJozqul/f2s7VlsRH64mw=;
 b=EpCF8+h5OB/lsELKS4GRpXNRiHcx9FGPRYYHnsDpUbGagkSZ+1pbsWjIAb0biMXInIBSUgUEvWG8G2Zr4RHe8+jIUpCxFb4oknYAFth2zafrddRUuQeiSi+ppaEu7ve7qmgAFYImndO0HjEkExdD+teN6tztBkHOJmTFPzOkCyY=
Received: from SA0PR11CA0079.namprd11.prod.outlook.com (2603:10b6:806:d2::24)
 by IA0PR12MB8838.namprd12.prod.outlook.com (2603:10b6:208:483::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 05:21:04 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:806:d2:cafe::ee) by SA0PR11CA0079.outlook.office365.com
 (2603:10b6:806:d2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Fri,
 21 Nov 2025 05:20:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 05:21:04 +0000
Received: from [10.136.41.133] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 21:21:02 -0800
Message-ID: <503782ef-f764-4263-8493-d18c162e0615@amd.com>
Date: Fri, 21 Nov 2025 10:50:59 +0530
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
 <c8e2ca43-c577-411a-a8de-176c5f85c15f@amd.com>
 <53a08e47-a9bc-484e-b510-faa76541dbbc@oracle.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <53a08e47-a9bc-484e-b510-faa76541dbbc@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|IA0PR12MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: d046db18-42ab-47d2-02b9-08de28bdc49f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2xhS0s5emJ3Vk85NzBaNWlVMEgrbDBRYWxudHR3QWtxNVc0L2hPbGxGb08w?=
 =?utf-8?B?M2tIcGV1bG12SmdRVXJoY2xpOTdGUTl2Z3ZSMkVjZkxid0VQWGwyOGt0QzI0?=
 =?utf-8?B?R2tpaGg5U2EzSC9yNmsyek16MExNM1BuN1BCT3JUY0ZYT0lyZk5mZ0lsR1o4?=
 =?utf-8?B?Ymxzcy9sdlpKbFg1MXlhSGpQTHF4NlUvMFNuTnZLQjhack9LejFpQ0NpVVdo?=
 =?utf-8?B?Q1lvdjVoK2pKcCtQYW9LVDhQZ0tKTkREdE50a25jb2JHdmZLR09WeW43dVVN?=
 =?utf-8?B?N1RLbzNtUVUzR3VDZ3ZZalN4aDN0UUZyeURjN210cWkzRWdwSW1FbWNabkRU?=
 =?utf-8?B?bEhyVCszbWdpSlB1akZlUGJyT2dyOVZabURrYUprLy9ZTDI3eENsY1BUZTFn?=
 =?utf-8?B?eXpqeUJYcklpTEpYWi95S3dXN3l3ZjlrdHZjeldMbWdPd3hHWUFhWDNRV0Rw?=
 =?utf-8?B?TzZZbWJCWGNWd0huNGtrR2VCTzFFOTQ2aEloeDJ4VFY3RWlHS2ZyS1FoaVJU?=
 =?utf-8?B?ZTVIZktnVjFzNjQ1aDNwVDEvaDJvMGlRV2paREFYd210a0x0cElOQkk1YWM5?=
 =?utf-8?B?azIzNHRrL2ppUzFMTVpVd2ZHNFZJT21RaGdDSmN2dzJWLzE1aWdvSWVKOWdo?=
 =?utf-8?B?KzVZZ0xyVUJlRytNenMrWXIxOEVQVmtkTUEyOFA2M2RqdTFkV3QrS1lybTdn?=
 =?utf-8?B?VGVXZm5RNTVQUDk2UlFwQlg5bk1xaWJ1YjR0Z1dJL1h0eUc0WEdrdFJVOURZ?=
 =?utf-8?B?Yko2cWpLSXN4SHhLei85aUdQNUV3eDlaOGhOVklWYVZlWEFtZ0FrVDQvNXFC?=
 =?utf-8?B?c1B4S2pjRVZLM0VudzB0Z0k0NlpVS2N5OHdrV1Avbno3OGVYWmNhQkVYQ3Zm?=
 =?utf-8?B?VWVoWmJ5dTN4cDV1V1NMdWJ4TkgvNXV1bjhveUVFQk1iQUdWNFdzcGtNbkpF?=
 =?utf-8?B?U0VKUVBMTTRCd1RlT3RVMVgyMXU3U3ZGY2ZEZVZvQ21KTVRsR2J6dU9tMzM2?=
 =?utf-8?B?bHg4UHZINlF5Wm9nMVd5UjcvM2VpTUlpUk5oZThJZHRNd1gzTlFTeGx5dEJi?=
 =?utf-8?B?TUVROUNZQ3pEODRsUzlzcC84RHV1ckFiNWtzajVKQ1J4Wkl2M0VSbFI2VFRx?=
 =?utf-8?B?M3EvWWt4QUZJSmRRRU43YW9kQnN2S1dCdjlFVEZsSFVNV2NDczFyQzVPNzB5?=
 =?utf-8?B?VkRqS2ZzWHZ3cU5MZDNvZmxNVGJuZUxyVkNVL2tPUGc5TURDeERVbS9RcFdB?=
 =?utf-8?B?SVdTVUhodW42UUxKc3V4RlIrYUJ2RWJyMUcwOXFVbUkyMmNuc05GWllDK0o5?=
 =?utf-8?B?cFJDalZJTzd5TERWYW1uKzN0SjBIWDBTUE01WjNEdHpKQ2RlWTVsS1dhaytT?=
 =?utf-8?B?Rld2OU80V1dGQXJBRmp0c2lJQXBlTHlJaDFKWVcyd1V0NEsyVHFOUE5xYldX?=
 =?utf-8?B?QW1YWHdWdUYyaUx4bi9BOUV3bU5iOGtDV2cwUEdSdHRta3Q2TEZuTkg1TkxU?=
 =?utf-8?B?NHY4VVZ6VllPSkh4M0l5M2kyUnQxWHUvZU1UTmdyT0hNK3EyNk8vSDM5dXF2?=
 =?utf-8?B?R1FzSkljaGhhdFZMNHMzOUh5Y2dWT3NyaExwQ0FNOTUrQ3NYRDFrekJoWUth?=
 =?utf-8?B?R1ZWV0FKRm5yU2FSeG5BTzYrY0NkZVZ2SGdqOG16bGRXcHIraEJwR3VUZG1p?=
 =?utf-8?B?bjNMcVdBS05DdjlBOENDSjN1VmZ2ZTRCUE55OXNpdENDYldUN0RmVDd5T2xt?=
 =?utf-8?B?N3hhUmxxV01sSDdzaU1wWVVveEpGQ05ObTZ1bTI3ZjFSNm1kZEtvWGlpMXFL?=
 =?utf-8?B?T29JQXUzQ0RKOVRwL3lyRXB6UEQyWEJ0YUM0RHZmY1JxVjBZZTgxYk1lb3Uv?=
 =?utf-8?B?Qml5MTluYVRMbzFmT05iYU5FcDhQVGdLWUwwMDFrNFhlcU8vQmFWK3VNZmdC?=
 =?utf-8?B?SnlkQ01RWG8vRCtTU050M1d4WjJKcnhJb2FyUWdEcGNSeEYydlZtV3JWY01n?=
 =?utf-8?Q?MwGcs/WnBq5tQvmPj1FCeERUNiOWrI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 05:21:04.5459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d046db18-42ab-47d2-02b9-08de28bdc49f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8838
Received-SPF: permerror client-ip=52.101.61.61;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



On 11/20/2025 7:01 PM, Alejandro Jimenez wrote:
>
>
> On 11/19/25 11:43 PM, Sairaj Kodilkar wrote:
>>
>>
>> On 11/20/2025 7:06 AM, Alejandro Jimenez wrote:
>>> Hi Sairaj,
>>>
>>> On 11/18/25 3:24 AM, Sairaj Kodilkar wrote:
>>>> This makes it easier to add new MMIO registers for tracing and removes
>>>> the unnecessary complexity introduced by amdvi_mmio_(low/high) array.
>>>>
>>>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>>>> ---
>>>>   hw/i386/amd_iommu.c | 76 
>>>> +++++++++++++++++++++++----------------------
>>>>   1 file changed, 39 insertions(+), 37 deletions(-)
>>>>
>>>
>>> [...]
>>>
>>>> +#define MMIO_REG_TO_STRING(mmio_reg, name) {\
>>>> +    case mmio_reg: \
>>>> +        name = #mmio_reg; \
>>>> +        break; \
>>>> +}
>>>> +
>>>> +#define MMIO_NAME_SIZE 50
>>>>     struct AMDVIAddressSpace {
>>>>       PCIBus *bus;                /* PCIBus (for bus 
>>>> number)              */
>>>> @@ -1484,31 +1469,48 @@ static void amdvi_cmdbuf_run(AMDVIState *s)
>>>>       }
>>>>   }
>>>>   -static inline uint8_t amdvi_mmio_get_index(hwaddr addr)
>>>> -{
>>>> -    uint8_t index = (addr & ~0x2000) / 8;
>>>> -
>>>> -    if ((addr & 0x2000)) {
>>>> -        /* high table */
>>>> -        index = index >= AMDVI_MMIO_REGS_HIGH ? 
>>>> AMDVI_MMIO_REGS_HIGH : index;
>>>> -    } else {
>>>> -        index = index >= AMDVI_MMIO_REGS_LOW ? AMDVI_MMIO_REGS_LOW 
>>>> : index;
>>>> +static inline void amdvi_mmio_get_name(hwaddr addr,
>>>> +                                       char 
>>>> mmio_name[MMIO_NAME_SIZE])
>>>> +{
>>>> +    const char *name = NULL;
>>>> +
>>>> +    switch (addr) {
>>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_DEVICE_TABLE, name)
>>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_BASE, name)
>>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_BASE, name)
>>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_CONTROL, name)
>>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_BASE, name)
>>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_LIMIT, name)
>>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXT_FEATURES, name)
>>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_HEAD, name)
>>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_TAIL, name)
>>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_HEAD, name)
>>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_TAIL, name)
>>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_STATUS, name)
>>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_BASE, name)
>>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_HEAD, name)
>>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_TAIL, name)
>>>> +    default:
>>>> +        name = "UNHANDLED";
>>>>       }
>>>>   -    return index;
>>>> +    strncpy(mmio_name, name, MMIO_NAME_SIZE);
>>>>   }
>>>
>>> While I don't believe there is a correctness issue, and it is a 
>>> clever construct to reduce code repetition, I had some concerns with 
>>> the implementation above, mostly on coding style and 
>>> maintainability. I can go into each of the issues, but as I was 
>>> trying to think of fixes it just became easier to write the code so...
>>>
>>> I think these changes preserve your original idea while fixing the 
>>> problems and removing unnecessary code. Rather than diff from your 
>>> patch, I'm sharing a diff for the full patch. I am still working 
>>> through the other patches but the upcoming changes should fit in 
>>> with no issues.
>>> Let me know if you agree with the changes, or if there is something 
>>> I missed.
>>>
>>> Alejandro
>>>
>>> ---
>>> (compile tested only)
>>>
>>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>>> index d689a06eca..6fd9e2670a 100644
>>> --- a/hw/i386/amd_iommu.c
>>> +++ b/hw/i386/amd_iommu.c
>>> @@ -35,28 +35,7 @@
>>>  #include "kvm/kvm_i386.h"
>>>  #include "qemu/iova-tree.h"
>>>
>>> -/* used AMD-Vi MMIO registers */
>>> -const char *amdvi_mmio_low[] = {
>>> -    "AMDVI_MMIO_DEVTAB_BASE",
>>> -    "AMDVI_MMIO_CMDBUF_BASE",
>>> -    "AMDVI_MMIO_EVTLOG_BASE",
>>> -    "AMDVI_MMIO_CONTROL",
>>> -    "AMDVI_MMIO_EXCL_BASE",
>>> -    "AMDVI_MMIO_EXCL_LIMIT",
>>> -    "AMDVI_MMIO_EXT_FEATURES",
>>> -    "AMDVI_MMIO_PPR_BASE",
>>> -    "UNHANDLED"
>>> -};
>>> -const char *amdvi_mmio_high[] = {
>>> -    "AMDVI_MMIO_COMMAND_HEAD",
>>> -    "AMDVI_MMIO_COMMAND_TAIL",
>>> -    "AMDVI_MMIO_EVTLOG_HEAD",
>>> -    "AMDVI_MMIO_EVTLOG_TAIL",
>>> -    "AMDVI_MMIO_STATUS",
>>> -    "AMDVI_MMIO_PPR_HEAD",
>>> -    "AMDVI_MMIO_PPR_TAIL",
>>> -    "UNHANDLED"
>>> -};
>>> +#define MMIO_REG_TO_STRING(mmio_reg)   case mmio_reg: return #mmio_reg
>>>
>>>  struct AMDVIAddressSpace {
>>>      PCIBus *bus;                /* PCIBus (for bus 
>>> number)              */
>>> @@ -1484,31 +1463,27 @@ static void amdvi_cmdbuf_run(AMDVIState *s)
>>>      }
>>>  }
>>>
>>> -static inline uint8_t amdvi_mmio_get_index(hwaddr addr)
>>> -{
>>> -    uint8_t index = (addr & ~0x2000) / 8;
>>> -
>>> -    if ((addr & 0x2000)) {
>>> -        /* high table */
>>> -        index = index >= AMDVI_MMIO_REGS_HIGH ? 
>>> AMDVI_MMIO_REGS_HIGH : index;
>>> -    } else {
>>> -        index = index >= AMDVI_MMIO_REGS_LOW ? AMDVI_MMIO_REGS_LOW 
>>> : index;
>>> +static const char *amdvi_mmio_get_name(hwaddr addr)
>>> +{
>>> +    switch (addr) {
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_DEVICE_TABLE);
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_BASE);
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_BASE);
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_CONTROL);
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_BASE);
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_LIMIT);
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXT_FEATURES);
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_HEAD);
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_TAIL);
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_HEAD);
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_TAIL);
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_STATUS);
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_BASE);
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_HEAD);
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_TAIL);
>>> +    default:
>>> +        return "UNHANDLED";
>>>      }
>>
>> Hi Alejandro
>> Although this approach looks good and faster (since you are
>> returning a pointer without copy), it has a major flaw.
>> You are returning a pointer to the "local string" 
>
> Not quite. While you are right this could be issue in the initial 
> version if you returned the local *name, it is not a problem above 
> since the strings created using the macro stringification operator (#) 
> are literal strings and not local i.e. they do not live in the stack 
> frame that gets destroyed when the function returns. In all cases the 
> returned pointer will point to a string literal that is available for 
> the life of the program in the (ro)data section.
> You can check it yourself by building the binary and looking at the 
> data section with something like  objdump, but that would only show 
> some fragments due to alignment of the output. After a bit of 
> searching, it looks like readelf has an option that works best:
>
> $ readelf -p .rodata build/qemu-system-x86_64 | grep AMDVI_MMIO
>   [ a1c37]  AMDVI_MMIO_DEVICE_TABLE
>   [ a1c4f]  AMDVI_MMIO_COMMAND_BASE
>   [ a1c67]  AMDVI_MMIO_EVENT_BASE
>   [ a1c7d]  AMDVI_MMIO_CONTROL
>   [ a1c90]  AMDVI_MMIO_EXCL_BASE
>   [ a1ca5]  AMDVI_MMIO_EXCL_LIMIT
>   [ a1cbb]  AMDVI_MMIO_EXT_FEATURES
>   [ a1cd3]  AMDVI_MMIO_COMMAND_HEAD
>   [ a1ceb]  AMDVI_MMIO_COMMAND_TAIL
>   [ a1d03]  AMDVI_MMIO_EVENT_HEAD
>   [ a1d19]  AMDVI_MMIO_EVENT_TAIL
>   [ a1d2f]  AMDVI_MMIO_STATUS
>   [ a1d41]  AMDVI_MMIO_PPR_BASE
>   [ a1d55]  AMDVI_MMIO_PPR_HEAD
>   [ a1d69]  AMDVI_MMIO_PPR_TAIL
>
>
> which can
>> lead to all sorts of nasty issues. This is why I am copying
>> the entire string to the destination.
>>
> FYI, this copy is one of the reasons that made me look for an 
> alternative implemention. Using strncpy is explicitly forbidden in the 
> QEMU coding style:
> https://qemu-project.gitlab.io/qemu/devel/style.html#string-manipulation
> and while there are alternatives, in this case the copy is not really 
> necessary.
>
> Alejandro

Ahh right I missed that its string literal and will be stored in ro data 
section. Thanks for clarifying the things
I am in favor of this approach. Will do this in the next patch version. 
Could you please provide your signed-off-by ?

Thanks
Sairaj

.../...

