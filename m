Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B12BF459FC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 18:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBGw0-0003od-Hn; Fri, 10 Apr 2026 14:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wBGvu-0003o1-Tl; Fri, 10 Apr 2026 14:50:22 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wBGvq-0005yk-On; Fri, 10 Apr 2026 14:50:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftZFC/qwMtdUKasi/Ii1qM/blBodram13JYiLIcdOUav5J2slq/uK6eTlRvdbDjBVjHNuCyLQ3xrUkF6+73d4Hb+YouwEwTE3YKu2ZSoNuUKqujIx5lkAnF1nSmKNEk3R4OH4zPSVjb1HzAgJQh5rD6MhAfm3EYAjZt4WW4hKGtxiPTlDMHUD1Z1Ikg+EIeDjylKDIwokIYaadscXchD+M5cXw+q2k90SKemO6389moV5gCbgQ/xU1YZFRFe45I7KSxSfGdgUV8iGhEORZf5sutGBWJge0IZrIPDCAFSoeZJWi4/e/qfp+Bxz5iOukpk0bzRU8IIR5KLQPvPzKgnsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xkyKw2ikx3h/ZaHwklkq28Kmk+lT3fcK88oiC2crNc=;
 b=pphl/FlG1ojz3KTPtIpt6AfwvufSF3fBqSQm/93/sSfzOgljISMckKXp0EKz/lEWzPHT0cBADuqUYDjKu1XZ0a+mWWAJ9MT7nlkYmIi8IyqchYop2t+8pOg+eERW0q9WMp3eLXn6MKQ55J6F/k+0CwMDEy9cs9F6t/kx11aopJteuXQe16RLMnOToP0my1DA7ZUorU/hqngg6WoUyM17L4Px8MvG2ZBPi1fPekMOO8XXXH3rTfzqTtjDLOdg2QTkhgwLEpsagqyk5miHWfpjGPVldXP+Bm7Bd5vLyOkYub+vGiQeOcK5N1I3Z7OpysmE0XDU/YR0SA2o4LfZUF108Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xkyKw2ikx3h/ZaHwklkq28Kmk+lT3fcK88oiC2crNc=;
 b=gyLkDgFvueVfEDNSsbFfYZBHCwWh/yKecWf0PxkTzbFBR5xCbefpdxTAuzj+CMeTU09gx8MUYC4XVuGE2aYqrIEFRZIqflTCGHy8NvmlB8YFDjjFuZelzamuybuK5vdOukQTR7NKPc5KYgmlOTDq4ZF0AuWCOExfZTc15aQVTlMZFuPQ4mPcgMdhCaQrFq9GopqCbobnO65ntZSm8LIBnuE6e8x0iZTYLC7FFFNOhxHJ4+bi83zcpnHXs9K7lJqPMsevmXHXE7o3zYuzDLYxHTH+QpQwV+X74pvkcLCFxLilxAK8dN0L7m6KIeZNpIlGDrikKVH1hrghCI9ui2aRrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA1PR12MB7735.namprd12.prod.outlook.com (2603:10b6:208:421::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.42; Fri, 10 Apr 2026 18:50:11 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 18:50:11 +0000
Message-ID: <9ff7d303-cb0b-4274-9fbe-c834a542b2c0@nvidia.com>
Date: Fri, 10 Apr 2026 11:50:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] hw/arm/smmuv3-accel: Add helper for resolving auto
 parameters
To: eric.auger@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Shameer Kolothum <skolothumtho@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <20260401010231.4166776-1-nathanc@nvidia.com>
 <20260401010231.4166776-2-nathanc@nvidia.com>
 <10540f3f-28b6-4cbb-9736-d6e8a01bdd76@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <10540f3f-28b6-4cbb-9736-d6e8a01bdd76@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0072.namprd08.prod.outlook.com
 (2603:10b6:a03:117::49) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA1PR12MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: bd4c0c29-596e-4fb4-2b36-08de9731fe20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|18092099006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: pxkiXQbr4jEyDP5bbgrb4JGSl6FS2355xlEuHVXFu2zYEN3lXl1V/Lt8Gj0KtORCAnaFK5mEISDzNxKW80Vu3Opnpm9UAYj7z0aYhHH1aBffQ1psRDNxx1Et2y6tqdqKVPdUHCIC5h13mD1p6ZiB/BQ4OEAfubKRDl57POeYB2pBQizfSVkw59p6NSaDdNF+FqDV7aAMip6Zcx2pyaYT7RBpPd+1SKtam7urE3fB57M0R7WTnjBnxNnTlcK3N5xS5/3o4ZYeSMizz2yyKz6y/H8UKCMNT8zVOxlKiSx7NbyyABoam7JkkSIQgvzrXnjDTyRTPBJYvSJ2xxw01ixR5ImcEymLaqCYfb2IB0mjG/tStGDnOLMMXXQi1VttGfh8D5y8tnRP8buGWOiI7KdUUIN6RN8EvZ6nTRxlwCeI/nc7/9u5BgigBlIwE7tS2yafT/aUHWbIauHlE7NaIRjLNJI4hr2ebtDRUrArApvmf4fUQ5Q7wQu87Xd97c0SscmOtMR1mmK8HiaeD5EueGIEGyUOz115xOCuZ1abCwHUNkIYBeDszjmMlXiS5Wi1L544OX+hNpBIZMcuikWLQhctrAC9Lrt3POmkrATEgW6sRF4dgFmcJu79A0a8rr5IEtJlj0698LszxIOVu2eiHJe1w74twx8RT9fTmjuDmmTVvcUGuBPweLrj99jm9E50USQjzIgITbPmGB0vGzVi771V6Cg1Ab4KlWNj6Y3/HLrw1T4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18092099006)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2Q4NW40ZWR1Tis2TWJKVlFRK2FLbkFBUFdFano2NWFMckxIRDJ4M1RtaElW?=
 =?utf-8?B?a0JiR0FlUjBZcG4zWWhteXZjbjJmc0phYjZuTVJ6TDJ2MjNNays0Z2cycllL?=
 =?utf-8?B?VkM4ZVFPZHB3ZnMwZWwvcHhuNlJ6bGlqbDFLcTAvUmFyZkZ6M3M0QzhOaG9s?=
 =?utf-8?B?blZYRUVqL04wZ0FaZjdYUmcvcVM5OGg3RXZsRVhaNVF1Z3VIbGJ0U0tnNG8v?=
 =?utf-8?B?RytDR1FuVzVGUTNvcFdPTWxnUkNVVEkyRTBxcUJwSWh6b2RWOWRndjFDTitp?=
 =?utf-8?B?NkRVcEtPQU4wUURrT2E3WS9Kd0ZSVFQ2VUh2Y09hL0Q4Q0VNRUgxNFg5RlZt?=
 =?utf-8?B?V3NXclhUOVBYa1Zaak5CUCthSE9oczBYZE14dHMrWHMxdmUvaUF1b3FpSzBr?=
 =?utf-8?B?UnFGVzdjbE9QWXBBZ3N6cUpJQ25YekRuWUZHTGFwM1krelpOcmx1SjVlMGJY?=
 =?utf-8?B?Uys2SWszbDRDeXRXc1VDeDEvR21WT3AxZXFUVlgrRzZBQXVPSlhrRWJFYk5i?=
 =?utf-8?B?UGJYZ296dDk5VGdreWRqRUpOb0QxTDdlejNWMzhKdnZ1ZVVBSm1rem9nTGhI?=
 =?utf-8?B?TFovSlUyQVRPNXg2dldoNXo5TnljaXMxYTNiSHlJN3YvcTJJWkJuYVlKY3pL?=
 =?utf-8?B?RUJZVDlOblR1NXBUbGpLSUlYcDB4ckdmWjlVcm5WRjJFc2liajk0cEMrc0JM?=
 =?utf-8?B?QVJCOGtsMzFVQytQcnN1eW4xMC9HSU80TldrbExMWmgxd0lzQk14UVU1Wldm?=
 =?utf-8?B?cXVQalpNekgrQlVIblBtQSt3aVZaMHNTRnNCRTUrTDdPRFJHaTB2V3dJbGxj?=
 =?utf-8?B?WnNPakN1aTArd0ZoN2NReVlWZXRGampmTW9JSkpySVB4anNaTEJUaTdkNG5y?=
 =?utf-8?B?SHF6ZEVleGVXSVlCd2lNSEt2TEw4TWZHR25kWXVvaGo4eGtGbHpNN0hQUUl0?=
 =?utf-8?B?RVlzVXVoaWpaR25ZR00zUlU2end4TEhPWVFjK3lIZEZldncvS0M2MHZ4MWtk?=
 =?utf-8?B?a202R3lkWSs3S1VZZm1wMFBvbjFuT3FVYUR0WFF2bUZIVEdmTDJMMnRwUGNq?=
 =?utf-8?B?S25td0NoUGU4MDEwNkUraWtmMFZCQmZMcUR4K1RyaUplQlNKcHhoUTJ4ZHRU?=
 =?utf-8?B?K0hlaTAycmVDRjlpcDBmdlZJQVFabWE1RE0zZkpNeTB6ZmpRNHhLVnNQRmpk?=
 =?utf-8?B?emlTMUh6OU15ak11c08yNTBxM0t2SzFiVi9vRWtiUEc1alQ5b1dUeTcrUWdR?=
 =?utf-8?B?V0psUzd5T0Q1UFNSNVFkOEFoWkltMkhVNmRqb29hL2llU0hwWmlQVVJ1RXlh?=
 =?utf-8?B?S1NoTDNxM2EvSzZkcHVoL2ZkeDFQNVdEQW05Y2xJWWNkRG96dFdRVzBFRTZS?=
 =?utf-8?B?MTJXSEl1YXh5SktZVGs4cFRyUmhHN0NwQXR6Z203Z3ViazM2K0xLck40SHRj?=
 =?utf-8?B?SFd5bWYwSHVVUWlxMElIQ0ZRU1NyY1NrbjBjOTJDYnp0b280eElLMWJtcTc2?=
 =?utf-8?B?YWUybnk2N1dLdjVybktGbmN3cFJHcmIrWlRmdUJCenpzMjNjTUVIaDI1TG13?=
 =?utf-8?B?VElYZzBBL2tRNlFFSXE4U0IzVlVUSzZSR3ZpNEx5NS9mbmY3amhua1NpajBB?=
 =?utf-8?B?U1RFNmNJTW55VWVCQ09WUHp1TkFCcEJESE1TcHdkOEdoS2hpZVVvWXE2cTl0?=
 =?utf-8?B?RFd2dmtzbFpYV29BU0RZWlcxV0lDNlBIRHhWbE55cmV3TnRiNko3Tzd2RVhF?=
 =?utf-8?B?QllWczZZRlovcXIweDl5dEM2ZlRkVEZLU00yZEtNbHUzeDBVZSszYTU0WXJ4?=
 =?utf-8?B?ZXkzQTJxeFd2T3BQMWd2RzU3UTdNek5CcjFHMVR2MmlXbFJCd2lxdm5jS1pC?=
 =?utf-8?B?c2M0ZkVrdVJEQ3orN3lqYi9xYWpyVCsreWpZRWFtWTEwZndpOEF6cjRoaVdY?=
 =?utf-8?B?TjlQSjBtTVQ2bkdIQnFaUHVnekljckNVeFJiSFh2aDlqcWxnZkZ3NG5YdDA3?=
 =?utf-8?B?RXhITWViTTk1OURxVGROT0h4QVZWa1BhS0JVWEp1Q1VrN3NKRkJXVm5hVGt5?=
 =?utf-8?B?bW5SMmdRT0U3bnhxeUpwenM1RjRuMFVCWmIxSTJUdWdLMGI5eHNySTFSYU5B?=
 =?utf-8?B?Si9nSjgwV2EvR3dEWE5BNkd5ZGJHbElwRlRtNERLWEhNTjNhMkc2NU9OYlJ2?=
 =?utf-8?B?TlFCNWI4OWZRWHVjZnhrc2o1UGhWbkZLZit2NDluVlB0R2hadjRaL29CTEw5?=
 =?utf-8?B?Y3o0dEhWWk42YUs4U01pT0NFZTI0MlhLa0F4aHhwVTNINjVYbzZKVC9OVHQy?=
 =?utf-8?B?UkwwUXN1bkxZTVhublNHaUxiUWE5ZE9QTml0YXpBWk1wOE5NbnJadz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4c0c29-596e-4fb4-2b36-08de9731fe20
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 18:50:10.7867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R75zedgzoWrs8NxwDjr2/qMbQj753pXNJ7MoRRGJWo9uosq78r425OuK+39T1t6BQkgBJ11wPtRAiWYqeIxlIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7735
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=nathanc@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

On 4/10/2026 12:26 AM, Eric Auger wrote:
> On 4/1/26 3:02 AM, Nathan Chen wrote:
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Introduce smmuv3_accel_auto_finalise() to resolve properties that are
>> set to 'auto' for accelerated SMMUv3. This helper function allows
>> properties such as ats, ril, ssidsize, and oas support to be resolved
>> from host IOMMU capabilities via IOMMU_GET_HW_INFO.
>>
>> Auto mode requires at least one cold-plugged device to retrieve and
>> finalise these properties. Register a machine_init_done notifier to
>> verify this requirement and fail boot if it is not met.
>>
>> Hot-plugged devices into an accel SMMUv3-associated bus will re-use
>> the resolved host values from the initial cold-plug.
>>
>> Subsequent patches will make use of this helper to resolve 'auto' to
>> what is reported by host IOMMU capabilities.
>>
>> Suggested-by: Shameer Kolothum<skolothumtho@nvidia.com>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   hw/arm/smmuv3-accel.c   | 14 ++++++++++++++
>>   hw/arm/smmuv3-accel.h   |  2 ++
>>   hw/arm/smmuv3.c         | 20 ++++++++++++++++++++
>>   include/hw/arm/smmuv3.h |  2 ++
>>   4 files changed, 38 insertions(+)
>>
>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>> index 65c2f44880..a0146c8d31 100644
>> --- a/hw/arm/smmuv3-accel.c
>> +++ b/hw/arm/smmuv3-accel.c
>> @@ -35,11 +35,25 @@ static int smmuv3_oas_bits(uint32_t oas)
>>       return map[oas];
>>   }
>>   
>> +static void smmuv3_accel_auto_finalise(SMMUv3State *s,
>> +                                       struct iommu_hw_info_arm_smmuv3 *info) {
>> +    SMMUv3AccelState *accel = s->s_accel;
>> +
>> +    /* Return if no auto for any or finalised already */
>> +    if (!accel->auto_mode || accel->auto_finalised) {
> I think you need to explain the commit message when auto_mode is going
> to be set (I guess at least once an accel  prop is set to auto mode).
> 
> Also can you detail this case where smmuv3_accel_auto_finalise() would
> be called several times. Here we return directly without looking again
> at the prop values. Would it be meaningful to continue and check the
> collected info matches the ones already collected? Can it happen?
> 
> An alternative would have been to fall back to default values in case no
> cold plugged host dev could be found. Can you motivate that choice in
> the commit msg?
Ok, I will explain in the commit description auto_mode is set when an 
accel prop is explicitly set to auto mode, or if the accel prop is not 
set and defaults to auto mode per the later commits in this series.

smmuv3_accel_auto_finalise() would be called more than once in the hot 
plug case. We do not accept new property values in that case and re-use 
the values determined from initial cold plug.

arm-smmuv3 accel=on with 'auto' properties requires at least one 
cold-plugged VFIO device, otherwise initial VM boot will fail and it 
would not be possible to call smmuv3_accel_auto_finalise() more than 
once in that case.

>> +        return;
>> +    }
>> +
>> +    accel->auto_finalised = true;
>> +}
>> +
>>   static bool
>>   smmuv3_accel_check_hw_compatible(SMMUv3State *s,
>>                                    struct iommu_hw_info_arm_smmuv3 *info,
>>                                    Error **errp)
>>   {
>> +    smmuv3_accel_auto_finalise(s, info);
>> +
>>       /* QEMU SMMUv3 supports both linear and 2-level stream tables */
>>       if (FIELD_EX32(info->idr[0], IDR0, STLEVEL) !=
>>                   FIELD_EX32(s->idr[0], IDR0, STLEVEL)) {
>> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
>> index dba6c71de5..3c1cd55714 100644
>> --- a/hw/arm/smmuv3-accel.h
>> +++ b/hw/arm/smmuv3-accel.h
>> @@ -26,6 +26,8 @@ typedef struct SMMUv3AccelState {
>>       uint32_t bypass_hwpt_id;
>>       uint32_t abort_hwpt_id;
>>       QLIST_HEAD(, SMMUv3AccelDevice) device_list;
>> +    bool auto_mode;
>> +    bool auto_finalised;
>>   } SMMUv3AccelState;
>>   
>>   typedef struct SMMUS1Hwpt {
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 7fead1c3cf..09ea08eb18 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -37,6 +37,7 @@
>>   #include "smmuv3-accel.h"
>>   #include "smmuv3-internal.h"
>>   #include "smmu-internal.h"
>> +#include "system/system.h"
>>   
>>   #define PTW_RECORD_FAULT(ptw_info, cfg) (((ptw_info).stage == SMMU_STAGE_1 && \
>>                                           (cfg)->record_faults) || \
>> @@ -2020,6 +2021,22 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>>       return true;
>>   }
>>   
>> +static void smmuv3_machine_done(Notifier *notifier, void *data)
>> +{
>> +    SMMUv3State *s = container_of(notifier, SMMUv3State, machine_done);
>> +    SMMUv3AccelState *accel = s->s_accel;
>> +
>> +    if (!s->accel) {
>> +        return;
>> +    }
>> +
>> +    if (accel->auto_mode && !accel->auto_finalised) {
>> +        error_report("arm-smmuv3 accel=on with 'auto' properties requires "
>> +                     "at least one cold-plugged VFIO device");
>> +        exit(1);
>> +    }
>> +}
>> +
>>   static void smmu_realize(DeviceState *d, Error **errp)
>>   {
>>       SMMUState *sys = ARM_SMMU(d);
>> @@ -2058,6 +2075,9 @@ static void smmu_realize(DeviceState *d, Error **errp)
>>   
>>       smmu_init_irq(s, dev);
>>       smmuv3_init_id_regs(s);
>> +
>> +    s->machine_done.notify = smmuv3_machine_done;
>> +    qemu_add_machine_init_done_notifier(&s->machine_done);
> can't you move smmuv3_machine_done in smmuv3-accel.c and also call
> 
> qemu_add_machine_init_done_notifier from smmuv3_accel_init()?
That makes sense, we can move the machine_done Notifier to 
SMMUv3AccelState since it's relevant to accel cases. I'll look into 
updating this.

Thanks,
Nathan

