Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9ABBCD37BE
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 00:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMbF7-0006aD-LO; Mon, 11 May 2026 20:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wMbF5-0006Yn-IX; Mon, 11 May 2026 20:44:59 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wMbF4-0003NA-3m; Mon, 11 May 2026 20:44:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwFbw9C03A9JuSA9Ir79m8LnxJkzkX3TsbpX72gNoragPbce7NqaBghrz9oLoUTg1UHgUMdx+2UxBW0voB4Lcc5d8G7BMbG+K04hKQKFhNRTVV2A5M5JrcYPs5H1E22w69h388lu8kZWrm1ys6seECLGijkqNrJt1Ue2UWXxSDHhkIJRIFvmb9JlqkvrQwjwIoH14GunV2yx4In8p1rTAmGfJBGDfRGoCKAtll+U6YZ5vQp3/Ix+VhRU7vn63q2KNB7n/JqsZAQkYDwmltYTOAlxefcClvRgh3ArUcNlB1YAr+eSEnYiGCVr4akaZIPP9T4usJE/kxsYNvRg/qDwSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wgu3cBMyLecwzj5yTnwWHtjQkr5m/HFL6Gxy3qqgtQo=;
 b=y6f1yi93j6sxj8P5vl2Ww014LrVZxIgogl5HuiC3LWFFmVInTYAMjL/zc2DoiTtliQtRh3LCDvFQisIGN470/YThk2iJu3OD819BW3HW5hz2Y193/PLnjfirJit06VGKL2lWHdOkyXtmxnnTBlFJVppj+Hq/X71+TgBhEA1o1oGcqT1bN0OKH7V9M7KC6rw5fMdh9ktzn5zzwJLUtM+Wq0V8ZrE4rVUwmOp4x5pNXcXMNM4qEDYY6OSxA1BvIpOAsNpwrBH2NV+FCniUEfiV0Fhlj5SH4+fHIDph7d32v59Ycl/VCiWiL6/jqvnn3kGgyT4bQCrzGtQtlA0wlUCeCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wgu3cBMyLecwzj5yTnwWHtjQkr5m/HFL6Gxy3qqgtQo=;
 b=qZESG4HNRg3DalrXaRn6up9nBtOEvFAbVh4flzIFc05Ix7TA+gbtbc5uJo1dLrlyZLXoIvmNCdAYH6c3hc0VOTItuC0cHvJ8K8TcBfclGuBooyHXR76pC8+N3ht5uHS30OyjocxibkxDR5DM79arAnil2a+EMiPs0UFzKKoiuFsDmjQQPudHyEZg5b8HyDBbSbhhsQyU7jXsI6nwaQnH5IsouVUJ+Lowy0jXZRt2iOTK2MAdwMEqOPBRvyRPxw+ex7SYdTIFdcajHJkcru2tb78IGnTGzRGPtz6l8Spl34/Mpa4ZXn0UCxeoNijJR9e8HQYomVhcgSSPQI5L2ssytA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 CH8PR12MB9744.namprd12.prod.outlook.com (2603:10b6:610:27a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.23; Tue, 12 May 2026 00:44:53 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 00:44:53 +0000
Message-ID: <75cf54c6-341d-4473-a849-2a4245c040f9@nvidia.com>
Date: Mon, 11 May 2026 17:44:50 -0700
User-Agent: Mozilla Thunderbird
From: Nathan Chen <nathanc@nvidia.com>
Subject: Re: [PATCH v2 7/7] qemu-options.hx: Support "auto" for accel SMMUv3
 properties
To: eric.auger@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260422204335.23116-1-nathanc@nvidia.com>
 <20260422204335.23116-8-nathanc@nvidia.com>
 <cfdc0d2e-59ed-4460-adb2-23dee2ca157b@redhat.com>
Content-Language: en-US
In-Reply-To: <cfdc0d2e-59ed-4460-adb2-23dee2ca157b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:217::28) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|CH8PR12MB9744:EE_
X-MS-Office365-Filtering-Correlation-Id: 93ec7828-6b52-489b-beda-08deafbfae36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: zRIOTbdpKejAuAqrBUX3segMiW34kM+EL1jezjJfvrMVqn3aAiMAd1YLEEkYGVyws/I7Wu2MB4CEF0SErPZY+IgZYJDnVje32/DrhYl2gA06k4YHKBVsfKLPp7yE4DhwiIeZCVTTSKy5k9rFdQslR7KegMLdR5tcfZKFA9O5z+ozy/XJq46x0eU+UvNHxIRFEOtWBgOOBTIx73eTgJ8xI7SDYVR4+rR8k1IFjBZYzrVd/nAruE9XDbiyP1NrMOVnaTL2vEa8eWCB0Efs0adB8waiZv1FFTinxQi4iGtXjZSbi4a2zmiGqHHB3hsMmeNG++bljrcVvFLRjU57QijzbhE4htC2NBAojWqzrwVRYnUB+BQ6OIRYeR2Ps8NeJ7PkEn3DkwuqAtGel0vV/TVOr4heiuBVp+5zZvVqZq39gGEddxYzDYKJ2uf+AEFdxVKIgHTDVIfEgNYrYQwtrcAtDfP7vCNdMuP34aw+COhh4X/YOHzwuwuHTcw38mQvsaX3sS+J7CR3SyITYfi/RV68rTutR5tB2ahgZ6kCz/wXhGIN8P8smHdYdarRa5o49VFt6knGAjoxWk4WzH6H6uTtCrsfusJ0bthGoEY8QMiy023rCuVbxTabXjfwqnNcMaCjJnv64zh929k2n/xguXLNRUnOZ7HuDj7lyP7JD24PKlxdIHk9vckDwoPZOSE5+/qF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(3023799003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnhLa1pWZWFiSUFIMEppNldIbXZPUWlTNXBJdHpQQmdRSGcxdUpKaW5kOXdP?=
 =?utf-8?B?MlNSUUFNN085WFNreTNzK2MzVmtYamgxdWMxNFJ1SXVNWnVXd21NNlBPUmVR?=
 =?utf-8?B?Q1hjN0RIVU56b3V2b005MFhkTnBvSHVLcTRpbHBaaE9ldkJ6RGdKbzdXTWJB?=
 =?utf-8?B?WlVWbnN6aVZXYVM1WTFNcTJRdWkvaXo1b0MreWpkUHVDYWRidDF5eHZKODJJ?=
 =?utf-8?B?VTlrd1IxTXBEZ3h2NnkyejdyR3ZWSFp6RVZNaWxlYU1udC8rVlIzdWtSbFBl?=
 =?utf-8?B?c2t1dklmMm5IaUFyK3dWa2RidExlbVY1TkFvRktZa2ZtOEFXWFRCSGVRMXlw?=
 =?utf-8?B?ak10L0FWZGdpenpwYzVWQ3FrMHNWVkwvb2FhTXRxYVRmUlh5eStTK2lkUGg1?=
 =?utf-8?B?SnY1b0JFblYrVGZBdDlBMXRWZURhcU12REZaTWgwR1QrT2t3TkUwV1pKS3lL?=
 =?utf-8?B?a0FOL2owcnVSaGIyNUxseGp1OWI0Z3U0WE56RlFuZU1EMFcxZDNDRXhJR0pS?=
 =?utf-8?B?QTZvU0tqMzR4SGNVRnJGMnJvSXY2RzFpSnJqNHhta1MzcDlVZ1BjS1RZSVo4?=
 =?utf-8?B?TU9JRy82eWxEQ3NlWE1pQ0ZFcmp1dXN4b2IrcURzQzdSL0xCZnBsbUluV3VH?=
 =?utf-8?B?UUZVZDgvQnhzYTVvTFdYRTdzOXdLNmNXZHVJRjQxMEpSQ293cTNBdmlJL01L?=
 =?utf-8?B?NXZrc0Z0QXlTdWlBVENxR21veXJYbjNaQXA2L0NwRjJqVy93aTF6QjJ1RWRx?=
 =?utf-8?B?QTEwRENQZHZrRHAwYVRtZUU0OUJmUkhDUUNpWVVMM0tBR3lNeTZPMVJlS0hr?=
 =?utf-8?B?dnVtR1N6a3E2WkF3REZJWSthVmxWelN1U2IyWmJvZDlJSDNMM1dKVmZ3SXdL?=
 =?utf-8?B?cGR6T1ZONXpNYjNma0xZYlhQRTBRK2RrUGR2cGthTDk4MlNEQWxZZkhScTR0?=
 =?utf-8?B?V2pnNXRUTmFVNEV0cVRhTnp0RWVEaUVrS1JJUjRvTi9LSkY5TXk4SEM1OTR4?=
 =?utf-8?B?NXQ1dU1QSVc2c1k4dktuVUlBMHdkSW1xdXZhVUJrMVRkTHl2WFFZTjEyUzVO?=
 =?utf-8?B?SmcyVW5UaUxyV1VvRWhGWkNYS3lzMFRCKzl0VUhxZDZmeGRzTXJzdy9GQmoz?=
 =?utf-8?B?ZDltTEgrTTlqV2JqNVNmYlVMUm54OVQybkYvaE03S0pQL2dLWmNjRTBXdHNk?=
 =?utf-8?B?eDBsUm9qMjNVTm5UZStyWjdYcktMSjhzT0UxSk8rMEl4REx5dFBPYTlzaEFS?=
 =?utf-8?B?Q29TNURBUTNqTGYzWnBlNUF0Y3diTnpXbEpnb0xDckd6NUxiNDFrMStKZFh6?=
 =?utf-8?B?YlhpcUdLc0NKeExSQStkWTR2WGV5UWR4bkp5Nk9rVFpwYk5xL0R5UXNYY1ZJ?=
 =?utf-8?B?SS9jVW5tS0Z2emZWU3VKTjZ2N3dnWHVPcXU4YnVsRVpZVGtBeUZ5N1ZWazcw?=
 =?utf-8?B?bExNQTA5UzNTaXlYT3lrZCtuZzRCbTRkMGx1R3hHUmNDMzhkR0lITDMzalFC?=
 =?utf-8?B?N2ZkdTdVWFJlSEFKQnVvR25nV1VHYWk4bFM2MWc1SmVDcjFQbGJ3dmt2WUhm?=
 =?utf-8?B?ZzljaVZjY0g5dmFBeXBWdFBUVnh4ay9hb1NnR2FmWlh5M3J1RHdXSUo0dHVU?=
 =?utf-8?B?UVgzeTVRenA2TDVBaXlMdG5wbWJxZDNCNWNjWGY5R2J1U1FGKzFpVjBRWVdF?=
 =?utf-8?B?MHN1YUxMdmczbUxuMURsNWJZNUVCL0tJdW02Y0d2M21PYmJCaUZKanR3dXVm?=
 =?utf-8?B?QmRVQlBCVUQ2NVBLdE1KNjJUbm1RR2JPRVppWXN3Qkl3SmYxZmsrd1FHcmRw?=
 =?utf-8?B?RWFTaDZIZUNSNW9YNmRtekdJak1zTWtvMFRpdVliMFNaVFZNRWcydTNHT2tC?=
 =?utf-8?B?WWFtamlreXpuUXAzWU1kNmMyQ2J1MWpwSW1nVG55KzRDb0RJbUowVEwvdjBt?=
 =?utf-8?B?aEpOUTcxUnlTVGt5dkpBRjhrWFVmZXpEN1hrNmc3MS83UUEwT2lCOGVBMW5s?=
 =?utf-8?B?ZmZ5cW0rZm9ZV2hHUDV2VWVBYmZoL2lERGhNMWZIRWYyQXArZVJLWXhaVERp?=
 =?utf-8?B?OFJxaTFnN3pKVlhvWld2RDVXeVZXeDI3NWNKbFppWHZYNC9RZlFYWWNyOFVE?=
 =?utf-8?B?VWRsZWRsdVZJSXJlZlk5Y1RuYmJGdFg1aE5BbFNrTHhmOVBVV3J4Y21XZ051?=
 =?utf-8?B?cXNSSXhkaU81Q2kzZEkvR1hEbmFHemZlMW9zQkhOQS9nMXBnd3I5S0U0dDg1?=
 =?utf-8?B?RGFkeWQ4MTNZaUdyb2dYdzQ3V2Y5TzlhaGNEVGhQRWprY1prNDFoSjF2RXN3?=
 =?utf-8?B?cXV6ZGN2RjQyYlpxd0NCVlRBNVhkOXVYeC83bk56SGJ1S2VVSDJ4UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ec7828-6b52-489b-beda-08deafbfae36
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 00:44:53.0870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xXtKPGLYbfy8G5RHNikW0eipNBXbEwIWBh8nE7g2SD4Q+ioKkfOpD0ifQw2ihmf3kqRwEBuBszEVLybm6MSzVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9744
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=nathanc@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Hi Eric,

On 5/8/2026 5:08 AM, Eric Auger wrote:
> Hi Nathan,
> On 4/22/26 10:43 PM, Nathan Chen wrote:
>> Update documentation now that "auto" is supported for accelerated SMMUv3
>> properties.
>>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   qemu-options.hx | 33 +++++++++++++++++++++++----------
>>   1 file changed, 23 insertions(+), 10 deletions(-)
>>
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 21972f8326..2c6ba16a26 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -1291,30 +1291,43 @@ SRST
>>           Enabling accel configures the host SMMUv3 in nested mode to support
>>           vfio-pci passthrough.
>>   
>> -     The following options are available when accel=on.
>> -     Note: 'auto' mode is not currently supported.
>> -
>> -    ``ril=on|off`` (default: on)
>> +     The following options will be set to auto by default if not manually
>> +     set. When accel=on and these properties are set to auto, the value is
>> +     derived from the host SMMUv3 capabilities via IOMMU_GET_HW_INFO. With
>> +     accel=on, this requires at least one cold-plugged vfio-pci device; if
>> +     none is present at machine init, QEMU will abort.
>> +
>> +     If accel=off and these property values are set to auto, the values will
>> +     not be derived from the host SMMUv3 capabilities. Instead, they will
>> +     resolve to the defaults described below, and a cold-plugged vfio-pci
>> +     device is not required.
> I would simply say:
> 
> If accel=off auto values resolve to the non accel default given below.
> 
Got it, I will simplify the accel=off explanation accordingly.

> 
>> +
>> +    ``ril=on|off`` (default: auto)
> ril=on|off|auto (default: auto)
>            -------
> 
> I would rewrite it into:
> 
> Support for Range Invalidation, which allows the SMMUv3 driver to
> invalidate TLB entries for a range of IOVAs at once instead of issuing
> separate commands to invalidate each page.
> - with accel=on auto means the value is automatically derived from the host SMMU
>    if explicitly set to 'on', the host must also support it.
> - with accel=off auto is resolved into 'on'
> 
> If we have this explanation here in object_class_property_set_description()
> just explain the basic semantic and list the valid values and default value.
> No use to rexplain the auto mode semantic.
> 
> 
> 
>>           Support for Range Invalidation, which allows the SMMUv3 driver to
>>           invalidate TLB entries for a range of IOVAs at once instead of issuing
>>           separate commands to invalidate each page. Must match with host SMMUv3
>> -        Range Invalidation support.
>> +        Range Invalidation support. If accel=off and ril is set to auto, this
>> +        property value will resolve to on.
> Same for the others ...
Ok, I will leave the auto explanation out of 
object_class_property_set_description() and keep it here.

Thanks,
Nathan

