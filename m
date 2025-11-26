Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CD1D1037A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 05:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO7uV-0005Ei-2q; Wed, 26 Nov 2025 00:17:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vO7uT-0005A4-8X
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 00:17:45 -0500
Received: from mail-northcentralusazon11012051.outbound.protection.outlook.com
 ([40.107.200.51] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vO7uQ-00041g-RK
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 00:17:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVvEpxTAINrmxYrePERgMEa3AAufegFt9XTaMvLzI79TydwnIv4074cQaEyvSFCkSQvXtgE0ZYlYGS8EGZe2K1RR40hcE39llFTlpIVHxkuDgUcIdFk38dKigg+IA6+/9BF+oer0F1ZOEqSMCfdbp7xDdUpRA6jGsjBKeggmWfbXPmBtRwWwH9uWuHe7eFTNHk8trPMxZyBxGac2Wwd7GyXZ1GKgzWwdPLfUjPPI/2G63ubd1BIJHG6+m7wU8arR3XWJlySGwDVhYDLw41o9vO7qW9Ocx9ga0CKBshmLK6tL30lnIh87wFfZKsW3aUwmQYVz6yifxqoizAHPDkbzPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/UIfQCaOzpmZcOzeKqPKl8D4yxC143LH0Sien54YAA=;
 b=Yglz/lILvR8Okh457kMuIUpgxvW64JbO6N+SE4TdFmvh56sxVBPE5gOO5oeaR848aCCRBCJLVxEOmCRXUHRc0LBw60UaMOeEHCTXlks7uilNQjywXVGsmaBP5ZIxy9JMCagP6JpYO0xorjYdbuqOUd4OzjIAHSkn5y3O7Xr9l/xAx1cFv4eZgZVo1IbHIzdGH25IiUEfnMA7fSbTFzgBi1OOQQ+lZOHxO9mSJ5rNqw74n0qUo3rHpkc3JEJX8xFCik1KQq/xllovfcXIv2tHAdxoAetVYQ8S1Ays/4tQdo4G+ilO6rlVJtv5/fQpwPliQlAMKgDfTu2zxDgw0Ln2Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/UIfQCaOzpmZcOzeKqPKl8D4yxC143LH0Sien54YAA=;
 b=5INSYHK0dJyCemlYoHTXgJpDfAnAC7S+sCxL58zuNsP/Z+SppGCyPcmZE0RA8SFYzO/GPYaM0d/k563QfOJiP3aA7ZAY/8j8Ym2KO9pLRq6nEK1n0y0mt+/+1ZSWxWNgzpgrjNVnsGqqX9urVO8yRB0I5rrcNA3XtL5wOKkR4Fk=
Received: from PH8PR22CA0007.namprd22.prod.outlook.com (2603:10b6:510:2d1::12)
 by IA1PR12MB6601.namprd12.prod.outlook.com (2603:10b6:208:3a3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 05:12:33 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:510:2d1:cafe::97) by PH8PR22CA0007.outlook.office365.com
 (2603:10b6:510:2d1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Wed,
 26 Nov 2025 05:12:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 05:12:32 +0000
Received: from [10.85.40.187] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 25 Nov
 2025 23:12:29 -0600
Message-ID: <5275a84e-5d83-491b-9c0b-a97c9c345ba1@amd.com>
Date: Wed, 26 Nov 2025 10:42:27 +0530
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
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <40b36c5f-5e47-48a4-bd39-667040f53a05@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|IA1PR12MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e37c45-5135-4d57-a25c-08de2caa676e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2E2cXZkL3E2RjdIWXRXUG9wU1drdGJ2TWJRUTZTQ1l2MFdDekt2Y3Vob1Bk?=
 =?utf-8?B?NjhwYWhZRGt2RjZrRFd0QnVFZlFONlpwa0M1LzNPSmZEc3VWZ2MyT1lJcUZs?=
 =?utf-8?B?TkRiS0d1Y0EraDY5WENuOWhmb1dHMnlCdUJoOGdQZG9mc0QzaWUxY0FKcFdw?=
 =?utf-8?B?SDdDd1RCYmJWbFRNYWZBSHhXUDQ5eUY0amk0ckhiNkhSQ3Vac0gzOWxDakh1?=
 =?utf-8?B?bUFTRURRekdxMWtxVHZoUU1RSFFXQXJ4Y3lGVGtLelBZM1ZRcUVzREFIdTdS?=
 =?utf-8?B?ZTRZYS9jRGNDU2lIcnVvWkgrMkhLMFFKbzVOVjRXcFphVVhVUE1FdlZZWVI3?=
 =?utf-8?B?ODB0a2YzaStaWklLTVpWUW5SVmxvNzd3U3E2QlFLVHNvZHBRNnZsc3ZSaGV5?=
 =?utf-8?B?Y3ZqcUhYMXRLaWRhZ25SN2RodWNtZWJLNzZYVUZBSDZDWG12N00wOXZ6cVdo?=
 =?utf-8?B?ZERBaUl2NHpnRWlCTGsvTnlhNDc5QWo0S1BMRjZtT04yNGZGY3kzU1JrUWZO?=
 =?utf-8?B?b20vK2Z5dmdJMGdYR1lzSExFVUdneVdWdFVZTVJ0OHBsb1dScGNadlMzc3NZ?=
 =?utf-8?B?MUxTRkZINXVyeWdoWjd0aDVVanJtUFp0ZWZvTGVZZGVyRjg1TUpFQ2psZ21K?=
 =?utf-8?B?L3BlUWlGMEZ1RHV3YS9pOW1QcmJvL3cxS1JoWnFBc09oLzJYeGVYcjl4QmM4?=
 =?utf-8?B?Nm5SMUlpd0RIMjlsNDJxdVdLV2tRSmIvQXU3aGR1OU1ETXYrc1IwRTJoMm0v?=
 =?utf-8?B?Q2ErWVoyTC9EK2FCcFFhQS9GU1JEUnMrRkdZSzVoQjU1c3Q2REpTRTU1c2FO?=
 =?utf-8?B?TVpoMko4bDMvRXQzbmg5S0hSdGxzNmpYVmp2dVhHZjlQM2laODRNVk1KNUtU?=
 =?utf-8?B?aUJuWVV0K1lXQU1zWW4rZFB1K1RxMFdsMlRtVzFiVktJa1NjcTdhaDJCZmQw?=
 =?utf-8?B?d3pTMXlLb2tJMHVSYXFMQ3J1ZDJzRHBoTk8xSmhIdE84dEY4WDFINUJaVGpH?=
 =?utf-8?B?eEcwRWQwVGFRQm5Qb3NubUdqaEEreXAyMTNXaDVRa1RiN0VvaU0vUURvaGgw?=
 =?utf-8?B?NE1QSnVuWmd3MThrWm9ZQVE0M2xaWGNPNjhTK3VDRjZqZ0Rla0pCNW9uMklt?=
 =?utf-8?B?NjU3a05OTXJnSStob3VXcEIrRCtHYmxqeHljNlBDNGxna1YxeWRDVzhnTjNL?=
 =?utf-8?B?ZGhZcjJmSXZnV0lRNUNDNnNqK0dYRjJ0aWp5cjIzVGduTTdINDc0WXA1S2Vr?=
 =?utf-8?B?T1VobkplY3k1RjJXNVJ6Y3dzWDB6SXlZbytJYVN6cDNBbk12RlYvak04YWp6?=
 =?utf-8?B?UXl5RXpIMkJkN2ZmZ1pPb3FNQnpBM3E0VXJndXBCM2NlTnIzakhJT0ZydDNN?=
 =?utf-8?B?TWRya2o2OVB2eS91cCt5SEJnNU85ZDd6eDZqT21CRXpyRkRybGhNUDZPbmFm?=
 =?utf-8?B?UnNNU2tKWVNnbGU4VUtXY3FxSXdYbTRkdkllRmkzMEgvMVh6MUpqTExCMUNS?=
 =?utf-8?B?N3BNNSs3cm1CdTFMRlJ0NWxiL3VoZExhQUVXR05DUU8wQzUvK1hUV1pMWFhY?=
 =?utf-8?B?L0wyNDErZXY5YXQ5RU5ySGlGdGd4YnBoY1pnWEEydVo5YlBIU2p1azZiTWJV?=
 =?utf-8?B?L1pvbDFHOVlqTlczNUU3UTZwc3VDQitqR2loajdTdlVZMWFNVFdUS1pDWFVU?=
 =?utf-8?B?U1R0S2lVRTNmbVRoNzVlM2NOSXN6YzJHdXc3eGYyVHczT1BGdXRxdGEwR3VY?=
 =?utf-8?B?TlZRUEh6VXFsTytvWCswbXViZnFOdit0ekppeGdrQkxoQ2ZldW1pNW80QjNj?=
 =?utf-8?B?amhOYm5meWVLbE1vZ214aHcxcS84UTBOZFp2RFZBNzd5dU9tRnB2WlUrQ0N3?=
 =?utf-8?B?UFMyYlFjeDJ1cEZ4cTBPMnpQeGVLV1NCZEJTWGNQc3hPSVo1czJLQTgwSHlL?=
 =?utf-8?B?bnJKUWNVby9JSGphbUFLMVBSaXZ4ei80U0kyMFpvN3hPSU9DNmNOUGlzcmRw?=
 =?utf-8?B?YlN4U0pGZS9GUFJGTzVuWUlZQitNdFlPc29peXNodXRjcVVIRnZuY256b0xz?=
 =?utf-8?B?eWtSMjZXUzRlQ0VFdStXMUhZSWlHTjVTYkQ0bnlPbTNtb1ZJMWNWbFlsRFdB?=
 =?utf-8?Q?fwC0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 05:12:32.3936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e37c45-5135-4d57-a25c-08de2caa676e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6601
Received-SPF: permerror client-ip=40.107.200.51;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
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



On 11/26/2025 4:34 AM, Alejandro Jimenez wrote:
> Hi Sairaj,
>
> I have a couple of suggestions, and one addition I believe is needed 
> in the code, but overall looks good.
>
> On 11/18/25 3:24 AM, Sairaj Kodilkar wrote:
>> Current code uses 32 bit cpu destination irrespective of the fact that
>
> s/"32 bit cpu destination"/"32-bit destination ID"
>
> I think it fits the language used by the spec slightly better.
>
>> guest has enabled xt support through control register[XTEn] and
>
> a guest has enabled x2APIC support ...
>
> I think it is better to replace "xt" above with "x2APIC", which 
> describes what the XT feature is/does.
>
>> completely depends on command line parameter xtsup=on. This is not a
>> correct hardware behaviour and can cause problems in the guest which has
>> not enabled XT mode.
>>
>> Introduce new flag "xten", which is enabled when guest writes 1 to the
>> control register bit 50 (XTEn).
>>
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> ---
>>   hw/i386/amd_iommu.c | 3 ++-
>>   hw/i386/amd_iommu.h | 4 +++-
>>   2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index a9ee7150ef17..7f08fc31111a 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -1548,6 +1548,7 @@ static void 
>> amdvi_handle_control_write(AMDVIState *s)
>>       s->cmdbuf_enabled = s->enabled && !!(control &
>>                           AMDVI_MMIO_CONTROL_CMDBUFLEN);
>>       s->ga_enabled = !!(control & AMDVI_MMIO_CONTROL_GAEN);
>> +    s->xten = !!(control & AMDVI_MMIO_CONTROL_XTEN) && s->xtsup;
>
> I think we should also include a new xten field in 
> vmstate_amdvi_sysbus_migratable, to ensure the remapping behavior 
> stays consistent after migration. i.e.

Right I completely missed this

>
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 9bf36ef608..5940011ef1 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -2452,6 +2452,7 @@ static const VMStateDescription 
> vmstate_amdvi_sysbus_migratable = {
>        /* Updated in  amdvi_handle_control_write() */
>        VMSTATE_BOOL(enabled, AMDVIState),
>        VMSTATE_BOOL(ga_enabled, AMDVIState),
> +      VMSTATE_BOOL(xten, AMDVIState),
>        /* bool ats_enabled is obsolete */
>        VMSTATE_UNUSED(1), /* was ats_enabled */
>        VMSTATE_BOOL(cmdbuf_enabled, AMDVIState),
>
> There is more work to do there, but this seems straightforward.
>
>>       /* update the flags depending on the control register */
>>       if (s->cmdbuf_enabled) {
>> @@ -2020,7 +2021,7 @@ static int amdvi_int_remap_ga(AMDVIState *iommu,
>>       irq->vector = irte.hi.fields.vector;
>>       irq->dest_mode = irte.lo.fields_remap.dm;
>>       irq->redir_hint = irte.lo.fields_remap.rq_eoi;
>> -    if (iommu->xtsup) {
>> +    if (iommu->xten) {
>>           irq->dest = irte.lo.fields_remap.destination |
>>                       (irte.hi.fields.destination_hi << 24);
>>       } else {
>> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
>> index 302ccca5121f..32467d0bc241 100644
>> --- a/hw/i386/amd_iommu.h
>> +++ b/hw/i386/amd_iommu.h
>> @@ -106,6 +106,7 @@
>>   #define AMDVI_MMIO_CONTROL_COMWAITINTEN   (1ULL << 4)
>>   #define AMDVI_MMIO_CONTROL_CMDBUFLEN      (1ULL << 12)
>>   #define AMDVI_MMIO_CONTROL_GAEN           (1ULL << 17)
>> +#define AMDVI_MMIO_CONTROL_XTEN           (1ULL << 50)
>>     /* MMIO status register bits */
>>   #define AMDVI_MMIO_STATUS_CMDBUF_RUN  (1 << 4)
>> @@ -418,7 +419,8 @@ struct AMDVIState {
>>         /* Interrupt remapping */
>>       bool ga_enabled;
>> -    bool xtsup;
>> +    bool xtsup;     /* xtsup=on command line */
>> +    bool xten;      /* Enable x2apic */
>
> I'd reword the comment to indicate this what the guest toggles for 
> enabling x2apic. e.g.
>
> bool xten;      /* guest controlled, x2apic mode enabled */
>
> I am aware that other fields that are also "guest controlled" don't 
> have similar comments. My idea is to highlight that the xten is 
> "toggled" at runtime, and is different from xtsup, which is a 
> capability inherent to the hardware being emulated and set during 
> initialization.

Yep that makes sense

Thanks
Sairaj


