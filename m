Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4BFD10375
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 06:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOVPn-0007gt-FA; Thu, 27 Nov 2025 01:23:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vOVPl-0007ga-6M
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 01:23:37 -0500
Received: from mail-northcentralusazon11013069.outbound.protection.outlook.com
 ([40.107.201.69] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vOVPj-0005WU-7x
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 01:23:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1fMFOdKKUokyjsv3MsU4jyjxA/1kI1eF9r4RmBaY0QCGZgjBAgJkDRvYpyPPhH1AtrIVxeixVS6I8tb0jZ9QZtuE+nOcYNn9VsnDVp0Q2imgvseWjoIuyJBCP4zCvjPOYZEeCsmBIMg+Qu+rgPWkD337aYMJ5b22PoBZB8vVhOSaaXH2OU4oenSfTIBAvCCG/TVeREpl1XLk9V52ytvmXH/IDjUQCayEvuPk3hVnQBiosj5sVpCWdHKW2wSpQ6g2w8ymKF2DRVU7fuQA+wE2WkDGapnUEBEbUkz3g/j/w+fduKAk91pUKKuGQ9j6eQi+/IyIpQoIXbNFFFK5vif0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEPgf1wttoEgzjZHy3frACNN4uJM7YKdd0P7qcyp/6M=;
 b=CodgJDOtKPSbfMAebkbAy/bICaLBqSDEJxL4HELOmEnyBm7Qf6XD6x7fq7G8XNKGJtahZ6qknNucwp63P7T3WbyEIzoG7M45NGeE6SPQX/eRw5SlzGIVCMwCGleUeqIZng0Dk9xXiuDojUJohqQ13KUaRGC9v4bTBnPbThFxdvTDioL6VkITLsYIDqB2TqTmzAs4lIGpxPiQC+6JEnDa7mRJukKGRKTrCvn60X4HgQXZmJVnR9JBBZSvwlTOPVOm5Jh+7K4E9nEA8I5SGDCd3qjUUz0HharaQMJKCUEQSCPuSFabmtAdIVhNjFLOoEmo1nfov9cGKAOcD6CNlE7ojg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEPgf1wttoEgzjZHy3frACNN4uJM7YKdd0P7qcyp/6M=;
 b=mDtVPltF2aniOn+Nopp04CnezQJ8zM1BByw8RWdFKJPHqU8KUiQkUJ6M3SPEUWVkZcLri6Qpl0VWIjEyDtbqItNHtpDBWB8bB0yIdFY4eZ6bGChvG5KFjtB6jSO7wd54heGzCg8xGO/PbgYM2VtPZkiYoZryo5/ozxYQTfxku9E=
Received: from CY5PR13CA0077.namprd13.prod.outlook.com (2603:10b6:930:a::34)
 by LV8PR12MB9272.namprd12.prod.outlook.com (2603:10b6:408:201::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 06:18:28 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:a:cafe::e3) by CY5PR13CA0077.outlook.office365.com
 (2603:10b6:930:a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.4 via Frontend Transport; Thu,
 27 Nov 2025 06:18:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Thu, 27 Nov 2025 06:18:28 +0000
Received: from [10.85.40.187] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 27 Nov
 2025 00:18:25 -0600
Message-ID: <4817f10b-a58c-44d5-8b96-a0266363efe6@amd.com>
Date: Thu, 27 Nov 2025 11:48:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] amd_iommu: Turn on XT support only when guest has
 enabled it
Content-Language: en-US
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 "Vasant Hegde" <vasant.hegde@amd.com>
References: <20251118082403.3455-1-sarunkod@amd.com>
 <20251118082403.3455-3-sarunkod@amd.com>
 <40b36c5f-5e47-48a4-bd39-667040f53a05@oracle.com>
 <3a372c3b-7edf-4e11-9258-7f61c3cdb670@amd.com>
 <f7002e59-d0c5-4342-b647-196aa14c65a3@oracle.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <f7002e59-d0c5-4342-b647-196aa14c65a3@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|LV8PR12MB9272:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f093a5-02c9-40fe-8a98-08de2d7cc7b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1hvaDdZMzE5WUxxSVZaZ2dWcnR1RFBvc2tKUXpFYXV3ek80dlZoeWQwSEZH?=
 =?utf-8?B?ZnBEOGZUL05BVFp5WnB1RjJIRno5NnIvamlvNXNsZUdzQkxsU09YOTRKc04x?=
 =?utf-8?B?RVZ6K0JVdENIZktuR3llUGQrRmJnbzJZMzFLRXgzakhhMU5Db0J4djAvNnZE?=
 =?utf-8?B?cVN1WGNXTkRwb3h3SHZLbmZuMmkrNDlWUTZLOGs2ZFV5aU04SE51eHlhd0Fh?=
 =?utf-8?B?WnpZSnhrcUZuV1JZcGFpTGEvcXh1MndDRTV3TlJRRWc5NUdiZUpHMXh0U1dV?=
 =?utf-8?B?Z21sM3dudndWdklzZGlHYkVwaFBhNngxQnhTRXhrTkJ0bzliVTh2Qk1MMjBC?=
 =?utf-8?B?d3NCaThPemRLL0l2V1ExdytIV1Y3S0ZhcVF6WFArSDNCSTZkOHRoSitDYmFO?=
 =?utf-8?B?Z3VXVGlBTVB0aDhtRCt0Q1JXUFoySVNYbEQ5MFBMc0lickJzZVgzSGRoNmRO?=
 =?utf-8?B?a2lOZkxBbUsxaFpPS3NZWXJYWlZ6QlJGSm9GY2VWNlpTaGU2WUNyam1wQ2hh?=
 =?utf-8?B?Wk8zT29mbW44eFJGZEd3QjdTcnI4VU5xYlRLcVNVZnFsaHlKVmd3RDJBb2sx?=
 =?utf-8?B?d3pxdUtsUHZNUkx0M09ZTW5xMnRvODVvTkd5aGZDSjJHR043c21SYUpWUmJ6?=
 =?utf-8?B?Z2xqaFlDRlgvUHpscXk2T3d2UnBnS1ZzdFRLaW85aFIxRWx4azMzeEVyQUx2?=
 =?utf-8?B?ZStEaWlvUC94dlVLTVE1NmlVc281MHEzQ0ZyeGRJelAyeVNadXRuS1llNlVu?=
 =?utf-8?B?WkcxcTgzMmZmaHA5UHRBdWwwODJCQm1xR0dPcHIyR2Vhbnp1S0VzdUE2NDRm?=
 =?utf-8?B?SWhJb01HeDZpMXg0OVVINnRoSmp6SE00MVgvejcyMEFaMVROeHpkT1dPTkRs?=
 =?utf-8?B?dGpPblhVbmQzM3F4OWdIME5WcDhkYTI1dmovbWlDRnhGTGRZQlFETWpOQno1?=
 =?utf-8?B?RWdUQWhnN2d1SE9QVzhBUmd3Y0hKWUdYUnBGYTh5TCs2Mk5zVHQvVFpSN0R3?=
 =?utf-8?B?MUYwQjBrdFh4bUdTdGpxRmdrQmh0ZXhrVGxSQjdGVTBsRC8wWXZ0UWJXbzZs?=
 =?utf-8?B?KzI0UDNIT09odzk1dFN0OHpaTlc4Q3g0b2FwaERVM2pYSWl3dkg3VzJMNitX?=
 =?utf-8?B?czg4R3lTTkNRbGRCTmp2NEU1ck9uL3JodzFyYThaM0kra21STGEwaGllSWJ0?=
 =?utf-8?B?eXVYNjU0Z3lFS2J4SyttVVFYeWhwcnVxOHJONXFZNEZFZGcwbzVkNHN0V243?=
 =?utf-8?B?aHd5L3VFT1VHYVFzenM2SFVOUGJqRUN4TTRCaldwd3daS0FsQ0F6dXFWbkhB?=
 =?utf-8?B?M3FEemtVblZzYmFPY0Y2VmY3U0lqUmlJMkRWU1VoWmdpYmRzVWdpWWF3VHh0?=
 =?utf-8?B?QlJBdHBoaFl4RS9HM080dEYzOVd3ZEZwU0ozUEE0QmpsZ0tKemJqQTk2bkdz?=
 =?utf-8?B?QmVSNkNOUVR4cXdUNUhqK015V211cmQwVlYzTXo5K3RBb2M0aHRCd3ZQbGtl?=
 =?utf-8?B?R005ZXNyMjZHTHhGOTMvdzNoQTNhQ2FPbGliRG03ZjZQZkt3dStDTkMrSCt3?=
 =?utf-8?B?UjlSbWhRSGtIRlpWNmVKWHBWWkVMZHZmdzgzWm1jVTV2QWwvSmxTYVpPdEVE?=
 =?utf-8?B?YTEzYk84ZHdXZEYzaW9nOHFhbjE2Zmk3TEZzT1l6WmJRUEd2Z01JMFlFMXIz?=
 =?utf-8?B?L1pORFpqM0VNV3ZKZFk4czNEWmRXWU5KUFY5azI0ZURzS3BUemZHRGoveG9r?=
 =?utf-8?B?VFJMVWRtbVpTT0ZRZTdSZzBTN2U5TkgrRjlnakdyaVhsT3hFMTVycFNBZHls?=
 =?utf-8?B?b2MvZ2VNbi9wS3hoZ1N6NFA5UnN6Q2Nnc2Q0Mmo5NHUzdm1qOHdldmYyVU9l?=
 =?utf-8?B?T1czRVZmdi9rOGU1MkZ0ZlpuTUw5c2Y4aURYOW1lclJlSGsxek9ZSFl5WmVu?=
 =?utf-8?B?Tm1FUERWTndET3hyRERkTFZrWnVWVWNCWFlhMHNBK1RtSk5SUmFNeEE3OElN?=
 =?utf-8?B?T1pwdnVMSkJYcmQwYWI4SDVjcEdmdzVmWTJOV3BFS2xBNERXYWFRWGtKdTEw?=
 =?utf-8?B?cGpaMWNjTTlqTjc1aVhjNWE2T29VK0hpYTA1VEdhWUNEYzdySGVZSWx5eFBm?=
 =?utf-8?Q?aFMI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 06:18:28.2140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f093a5-02c9-40fe-8a98-08de2d7cc7b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9272
Received-SPF: permerror client-ip=40.107.201.69;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 11/27/2025 3:46 AM, Alejandro Jimenez wrote:
>
>
> On 11/26/25 7:13 AM, Sairaj Kodilkar wrote:
>>
>>
>> On 11/26/2025 4:34 AM, Alejandro Jimenez wrote:
>>> Hi Sairaj,
>>>
>>> I have a couple of suggestions, and one addition I believe is needed 
>>> in the code, but overall looks good.
>>>
>>> On 11/18/25 3:24 AM, Sairaj Kodilkar wrote:
>>>> Current code uses 32 bit cpu destination irrespective of the fact that
>>>
>>> s/"32 bit cpu destination"/"32-bit destination ID"
>>>
>>> I think it fits the language used by the spec slightly better.
>>>
>>>> guest has enabled xt support through control register[XTEn] and
>>>
>>> a guest has enabled x2APIC support ...
>>>
>>> I think it is better to replace "xt" above with "x2APIC", which 
>>> describes what the XT feature is/does.
>>>
>>>> completely depends on command line parameter xtsup=on. This is not a
>>>> correct hardware behaviour and can cause problems in the guest 
>>>> which has
>>>> not enabled XT mode.
>>>>
>>>> Introduce new flag "xten", which is enabled when guest writes 1 to the
>>>> control register bit 50 (XTEn).
>>>>
>>>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>>>> ---
>>>>   hw/i386/amd_iommu.c | 3 ++-
>>>>   hw/i386/amd_iommu.h | 4 +++-
>>>>   2 files changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>>>> index a9ee7150ef17..7f08fc31111a 100644
>>>> --- a/hw/i386/amd_iommu.c
>>>> +++ b/hw/i386/amd_iommu.c
>>>> @@ -1548,6 +1548,7 @@ static void 
>>>> amdvi_handle_control_write(AMDVIState *s)
>>>>       s->cmdbuf_enabled = s->enabled && !!(control &
>>>>                           AMDVI_MMIO_CONTROL_CMDBUFLEN);
>>>>       s->ga_enabled = !!(control & AMDVI_MMIO_CONTROL_GAEN);
>>>> +    s->xten = !!(control & AMDVI_MMIO_CONTROL_XTEN) && s->xtsup;
>>>
>>> I think we should also include a new xten field in 
>>> vmstate_amdvi_sysbus_migratable, to ensure the remapping behavior 
>>> stays consistent after migration. i.e.
>>>
>>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>>> index 9bf36ef608..5940011ef1 100644
>>> --- a/hw/i386/amd_iommu.c
>>> +++ b/hw/i386/amd_iommu.c
>>> @@ -2452,6 +2452,7 @@ static const VMStateDescription 
>>> vmstate_amdvi_sysbus_migratable = {
>>>        /* Updated in  amdvi_handle_control_write() */
>>>        VMSTATE_BOOL(enabled, AMDVIState),
>>>        VMSTATE_BOOL(ga_enabled, AMDVIState),
>>> +      VMSTATE_BOOL(xten, AMDVIState),
>>>        /* bool ats_enabled is obsolete */
>>>        VMSTATE_UNUSED(1), /* was ats_enabled */
>>>        VMSTATE_BOOL(cmdbuf_enabled, AMDVIState),
>>
>> Hi Alejandro,
>>
>> I don't think adding a VMSTATE_BOOL directly is a good idea because 
>> it'll break backward
>> compatibility (kernel running on older qemu won't be able to migrate 
>> on newer qemu because
>> change in the stream length of the migration data). In this case we 
>> will have to increment
>> the min_version_number to stop migration from older qemu
>> I am thinking to add a new subsection as it'll not break the 
>> compatibility. Let me know what
>> do you think about this.
>>
>
> You are right, the subsection approach is the right way of doing this.
> Given the lack of updates to the code until very recently, I think it 
> is unlikely anyone is using migration... but since the feature is 
> officially available, we need to do the right thing.
>
> A problem remains if we need to support migration from newer to older 
> (i.e. missing xten) QEMU versions. Then we need to have a .needed() 
> method to avoid sending the subsection, or otherwise the migration 
> fails due to the dest (i.e. the old version) not knowing about it. We 
> can try to find a workaround, but my thinking is that the added 
> complexity is not worth it, again considering the extremely low 
> likelihood of actually breaking a user setup.
>
> I don't know if there is a precedent for this type of choice, so let 
> me do some research, and hopefully others in thread will also comment 
> with their opinion/guidance.
>

I think .needed only useful when the field is rarely used. For our use 
case the guest will always
try to enable IOMMU XT interrupts. So we will anyway endup breaking the 
migration from newer
to older.

I think we can forbid the migration from newer to older. As you said the 
added complexity is not
worth it.

Thanks
Sairaj


