Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AC8D10381
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 12:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOEPE-0000AL-6m; Wed, 26 Nov 2025 07:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vOEP7-0008Vg-CD
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:13:51 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vOEP4-0002F7-B8
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:13:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mB8AF+AaCzM7STtQE3bGOldTQQK54wuVnrocsahnt2HqjaAQ3yjwSmgcaQ4NFmWRxbDOn0ETBdakXgoFdS8aWo7A1OTyhXj3XKzKkjN4HIhFW6FTWcTlCcy5+Tmu0sTCsc/rs7ZI4Uvk2q+4c9J263v0Q3lqIHY3m93xUxXjPjSPaQCG5sbW0i1eJWaWCrW0qRDQxTbG8fx8ITmbot0Pe2EiP0N0a2ZLPuIVPb2U5/V9Zdre7ZUhYqbm1ArABIzb9KuHKy7bAtH6HxBVj1+/4L0pBZJ4TN3Al6YiuOfLQAbpqIBNrFdA2yXaQu3MMz62N7Bd/BLPAM3oQTYY5NOVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KPF6C9eExdZSmNdNXNVaU4j3M1RGKT3wr8KxvCsHVU=;
 b=ca+WZ6I5zRe1oh1F4RcejzpSkz9xwyNnIaHj9Z4N1vjbIpJDMHn9Fn5jP+DcaeYUSWXl85HroYN4atBRtABXRgjaBs+l2/tVACDZWAZETa2Hna0u6mBFvyMbjuJgD5MSmZf/pU2XnP5D+6Mru5+tqY0oMm19wJMCCGP6wqso3QBKdcmHl4dTuwol+rsYoV0S0cT2UiwrV+XSLlnwqyck8Z0P6Mjj0no8HPeTjLCnz2cRybwzeUF3ADvoQT4pPVdSW1EOE3GGx7ufiRfGibfG6yr1C9ounnUBJZfQRAZX6cP1dXFD1CZGnIexEJvOa795ZJU0OPZjXzDABNIjLpkdVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KPF6C9eExdZSmNdNXNVaU4j3M1RGKT3wr8KxvCsHVU=;
 b=Sb0yNjAJexVezNzvjcRvKxwdhyhVrnGKxTgfGXfv9mQzoWuW6PpX0Ej7x9NsC9BUBDEC9lf2swkEdHMNbEZPuslVMmZaD/EYukCn3CXT4fgRcOrOIEDcG+nzFNL0sdL7xmkk79KYchQGl4GD8m+DNjfDcub7QIEf3cyOcDA4LQo=
Received: from SJ0PR03CA0197.namprd03.prod.outlook.com (2603:10b6:a03:2ef::22)
 by PH8PR12MB6892.namprd12.prod.outlook.com (2603:10b6:510:1bc::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Wed, 26 Nov
 2025 12:13:38 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::24) by SJ0PR03CA0197.outlook.office365.com
 (2603:10b6:a03:2ef::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.13 via Frontend Transport; Wed,
 26 Nov 2025 12:13:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 12:13:38 +0000
Received: from [10.85.40.187] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 06:13:35 -0600
Message-ID: <3a372c3b-7edf-4e11-9258-7f61c3cdb670@amd.com>
Date: Wed, 26 Nov 2025 17:43:33 +0530
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
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|PH8PR12MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: b124debd-5a67-445b-5cdf-08de2ce53b01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rk04Tmlod0swYlcxZWhHeHo1eTM4VklyczR1ZUc5VSszdHBWZ3lSakVUQmVl?=
 =?utf-8?B?aFFzYmhyV1RKc3VQb011Q2Y5ZlJha25yNm52TUdWRmNONUxzOHRsd3F5bEEw?=
 =?utf-8?B?NlNmbmpWSTk1eWhhOWpMNHRJdTVpUnZEUFFldDIvSXkwUGtIWHh6b1gyT1p3?=
 =?utf-8?B?Y2hqRjVmZkhwVWFaTUkrQUVaOGJtVlNEYTdRSC9OdFg1dHgvYmJ3L2w3OEhu?=
 =?utf-8?B?OENudnJjUXRrWDVVUWEyMkhNQ1Y2U1Y3Vkw4Z2F3bzE3YW1CL0NwMDZ3QVZM?=
 =?utf-8?B?QnFqVElMQ0JEMHpqLzBwYnRmdVlsVnU0WWpkbW1qWWhjcy9LZUliekFva0Nn?=
 =?utf-8?B?MkVHVDB3enJXcjVBMmEwcm5FRCs2N0pEMnNNZC9xbU9qZ04xcGlLL3BvOXZC?=
 =?utf-8?B?NVB5S0cwU0JGQTd4UTBnOFA0SGgyWmJyWUMvb21kMVJTaU9RQnplNEJtY0Vi?=
 =?utf-8?B?cGZRYXNDTEVwYnNkN0d1RGEzVTJnakNvbDVMK1FleThuRXVnTnRLRG9JS2N1?=
 =?utf-8?B?dDNPeXBRWXFta2V2d1JrVzZvQ0p5WmdKd3pGaGdMRVU5YUNhYVN0RG93amJV?=
 =?utf-8?B?bkFtZU5kaU54VENsbit6bEVQVlphNk8rUDhKZjR4dzV4SXpJQmRFZERBdDJ1?=
 =?utf-8?B?Z09BZ0RUT3NVVHhaeU81N0RxT2d3cjducVFJU3lCdldlelY1MC9iQjd1a3gz?=
 =?utf-8?B?VDFZT1R0dE44c2g4NVlNSlBhaTVGMW5Kbk9xQ3lTVFFNU21ocVNOOStHdEVi?=
 =?utf-8?B?MHdyc2sxMTQ0Y056dnYvNkgxVm9TNHAwMlNIZFg0RDd0N2FVWFNIc3AxZU9K?=
 =?utf-8?B?eWV3bjlFRjdXQ1hYSVJHUDhtUzFvVkFVVVB3MUJOd2V0OHBVeGE1QmdkNkVq?=
 =?utf-8?B?bGZxK2c1amVobEZ2VXA3d1RuRU9VaG43Ti9yVnl0UDBXMHl4b0NtT211czBt?=
 =?utf-8?B?WTE2OFBjUTBGSHRPUlZFMHVRMFhaMUF2L05DeHhxTVRrZHpZTE9rQXIzMmEy?=
 =?utf-8?B?dlJGSU8rT2loRFpMdVVPV04vcXdON2gvWWd6R0F2NGZYRFB4SVVtcHVkSW9j?=
 =?utf-8?B?aEpvRmZIT3FwRzFaVmFtMCtsREFNWGVmYVg1TGhMb0pybzQ1SklPSmNGR3Zo?=
 =?utf-8?B?RDBESXdydUg4cVFFMS8xaHk1cVpEc1BqY2NMV05GUnBaUjAvSlVBTWxkVk5r?=
 =?utf-8?B?RlZTTmJtRmYvS3BKcGlON0lxamc4a3lGcGZNT2JlSWc3MXd6aFJxbWE3R093?=
 =?utf-8?B?ZE1LQ0RYbmxlaXNIZUR2WlVISlV6L0JCVDhadVBZUTAxd1dkNzljMnlnekU2?=
 =?utf-8?B?REF2ZFlSMjFGb0pHMVVhL2NvbGM4SEdYS3hBczhqKytzYmVXUGNtMWVmK1FY?=
 =?utf-8?B?M212bmc0eWlkM0pCTVltODlyeGhSOFI4bURhUVpJalYyUE91NW1BZGw3MkpO?=
 =?utf-8?B?V3MvNXIxRDlTL1hReUtpWjRHVkI3RU40Q3NQaTVkMmp0UEVNTVJMYVlNTFlu?=
 =?utf-8?B?TjllcEZwV0N4Q1pGaXZDR0srSCtSTXgvZmRDVWJrejJmWFVzMHdCSXZGaXBh?=
 =?utf-8?B?UGdVV25vYkx0alkraGNqSzJLc2xUWXI3czIrejRWWHdVL3UyNnFkeVlIblhZ?=
 =?utf-8?B?SzlpV2NlQnE3WSswdlliWi9CL2NSUVVWdEFDRC9UQ0tDTFI2MW1FckN5cURI?=
 =?utf-8?B?Y3F3akIvRlgwdUxpTzVEeXdhaDI5NmRvR053Q2dXblBpbXYrV3dBb1AvelRM?=
 =?utf-8?B?elh5djFEd29wdmgxdGZWTXlCQys3R2tKUitBbHVteFZFTXA4ckc0Y1hraXFz?=
 =?utf-8?B?TmlnWjhJLzBSb2dsREZ3ZXFyd01JUUd2V3dyK3hOTVU1VVRXSzlTdVgyK2hZ?=
 =?utf-8?B?RVdHTzIxV01GbzV6TU1zVFE5RFhhdkFVbHdPbExseVN1RkdJUTRVaWtQVmdH?=
 =?utf-8?B?SEo1U2RjNWc2YzNTSTl3d1d6QjAwb3IzZ1c0SmZYaXdPdWgrOGlaeEJEYTUx?=
 =?utf-8?B?VnM1VnJROHdITnc0SUxoVlZQdHpZZmxFc2J5VUJUNnJMMDhCU2tPdEErcnlI?=
 =?utf-8?B?a1liYVlkeUZNWWN0VW5SeEt1ZUhuaEdOMzVISlozQnBsRDNRaDVxWGs4eUMr?=
 =?utf-8?Q?XlKA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 12:13:38.0911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b124debd-5a67-445b-5cdf-08de2ce53b01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6892
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
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

Hi Alejandro,

I don't think adding a VMSTATE_BOOL directly is a good idea because 
it'll break backward
compatibility (kernel running on older qemu won't be able to migrate on 
newer qemu because
change in the stream length of the migration data). In this case we will 
have to increment
the min_version_number to stop migration from older qemu
I am thinking to add a new subsection as it'll not break the 
compatibility. Let me know what
do you think about this.

Something like this...

static const VMStateDescription vmstate_xt = {
       .name = "amd-iommu-xt",
       .version_id = 1,
       .minimum_version_id = 1,
       .fields = (VMStateField[]) {
           VMSTATE_BOOL(xten, AMDVIState),
       }
};

static const VMStateDescription vmstate_amdvi_sysbus_migratable = {
     ....
     .subsections = (const VMStateDescription *const []) {
                    &vmstate_xt,
                    NULL
     }
};

I have tested above code.

Thanks
Sairaj

