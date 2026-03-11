Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E57A1125857
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 17:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0N38-0003EP-Hx; Wed, 11 Mar 2026 13:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0N35-00039D-0l; Wed, 11 Mar 2026 13:08:43 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0N32-0002EM-KK; Wed, 11 Mar 2026 13:08:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAq1qvz+XncXW5adwJJv3GV/9M/iJk0280DsDh20LGE6u/N5ONXHcQUV3oWa5i5vVYEm0/K8MPkokn8wHrFc/EIpMsqJI+AW0NMm2+dHzDYo4pXUPiAxC03TnGrAR0O6IPW+Ojpu0hXsx/GYV3RZsyg/Yh6z1/NpNe664nyWx2mU8yRHAAPgAu+t3ZJIjsTrBi8NlUj+z6Vl581luz+80YfEcLLjtAB9MocxGwa4TZMwy6ebjW7xOi2OGgNnwaNoErJqp5lu98yc4Gq0+D6FjnWCHhNbNvh03EVy1IkQUcWHIFo9zeze8FDLF9ccQmdC/dfrDcBwSWP5RIba74wCLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzS5WHkhHMTF5O2mtE22tHGu/f1etGMc2MwuC4lgCvc=;
 b=RD73JUkcf5OTHN0c3H+U/c9zJc7LFWY5dEQ0D0+EHkHj8OXbUDtQmAGntP5yv2teBsuvxqtnq8lAVY1HugDosbjJa/gPtkfTQOmS70Aeo2ToQmzuSxJB0bzbkkAS5tujQqNapGyhaA4UgrO7t/7xo2HgIJNYcGpDV/KMItxjiBBUYprGu0dlJdrg9DTGURkYOE8vUcbml1/okJnmpzEjaLZHAX5NXoQhVszQrxxeUTqWK1GpC1BsLV7/GE6dXYTuGvsj9OHTE2tKapCG/xZFELBgT1QNqkEuoeX4wPGmTSGGkTbk3UYetD5hol/Fra7V50srLCqntURtYV2VRn3pWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzS5WHkhHMTF5O2mtE22tHGu/f1etGMc2MwuC4lgCvc=;
 b=aBM7LpkPDMFrGuomK0zDt0luXNC2dkKVsR5+DzBMoAozkILw4k9dM+tdfRcVuRP4XCH9UX7fSc61kb800UnZ2YWG6eeaBan4rwi7/jjwrqQGgYsV0fo7ZSb7dv5e4qzcW65UW+kVJ4xRECoTHX9UfyVX/k/PmvAP8o1VahbcE7Zc5wAykJlgoymoRcjPoaDY1NtS2HBrx9Tn4P4kjLu1C8C7ngDoiNnYiOTHF6P//qduYtCfc0SG5GNhpXvksSw8OibU8hu4GjDHmWK3d1V95HhpCubTt53SqGl74aoOtZrODJtzg8+M8d+7RRCIYBAc/CmCsRNnh+Dc69Xsa84mXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 SA1PR12MB8843.namprd12.prod.outlook.com (2603:10b6:806:379::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.12; Wed, 11 Mar 2026 17:08:32 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 17:08:32 +0000
Message-ID: <0bdcf7d7-136e-42f4-9fa9-d31f6ae6e19f@nvidia.com>
Date: Wed, 11 Mar 2026 10:08:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/8] hw/arm/smmuv3-accel: Introduce _AUTO support for
 ATS
To: eric.auger@redhat.com, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Yi Liu <yi.l.liu@intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20260309192119.870186-1-nathanc@nvidia.com>
 <20260309192119.870186-3-nathanc@nvidia.com> <87pl5cnp06.fsf@pond.sub.org>
 <98e7dd71-6669-4a82-bec8-f1dae2d861c3@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <98e7dd71-6669-4a82-bec8-f1dae2d861c3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0042.namprd11.prod.outlook.com
 (2603:10b6:a03:80::19) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|SA1PR12MB8843:EE_
X-MS-Office365-Filtering-Correlation-Id: 525baa88-3015-4ac4-6520-08de7f90d28d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: PEP2m/Uz1KRaL0C7LgavtCSbNu6PS4EYNEc6RpX0/7mtHelwUz0fpc5CxEVLCHZPRX13fWOd6aBkUJb7zi80j54n3K2TJQ0D0n5NKIhVDYaCvNMtwZQkCHCsRezA+WO/bFWVMeLNZnXxyIcT5JYPtZ0k7WeL8+zwZexFtjP4miAebsYHgoor6Mt2/M+lL7MAdm0FZb76knOdNLNLeir56JKQbSkOuzEDEfNh3yrbEDjxNLNpNYew2HDZv0ZZYecb81dwOQfDHCRTSKBFd8wqJFpRoEyz20HkaWVh/jvfzVQgMeNj1lVcJUmrt/gFRbmi6rW2MShx4qs1bxwQtpC+CuYZcfQ8eWs8K8j8el0bjKAqGEGcOM8/ZK6B5BdDmTI4zxdgSo44poQqaYGtcOgQ/AgiD1TTkxsnaddtC/9aBkYqME1b27bJwREKwoeDaQDki9cjomcuoR2k+2o4dV6MfFGqNDdFpGHvQINq4cfacJQrKPGWRMhv75V+y0RywYumIAIFsiHGcZkQ6gPr/rvjXII5dMKXAy8cJ2nSWg0iMdWhfKPbAwPD1VVjnst1Fz15AdPnHvZxD5KBdlZBxVfb6SWVFHbSs3KNRls72nzFdgOUHkfFCS8uUs8YrOKWB85sALxN8V9EljB/p+ueK1CuEdyezUJNHqz1w/21t9+fF1X4Q+hu8Kd/ubZEH7BR1xGg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlBYYjVFQ0Z0WGtWb011Y1NELzFKYTN4ejlBMFZOY2VSdGYwQlI1eWRtWWdi?=
 =?utf-8?B?TmxGZ3lMcjJaSGl6Vzd0Wjc2OGpzTTRPeTN2UXRLQnZ3ZTN0NlRyUy82eTVN?=
 =?utf-8?B?OS9FaVpTOWN5R1RmZEhVMzI1NEVUT21ubkZVdXRXcEswc3BZdHIxcCtIOXdk?=
 =?utf-8?B?cjR3SW93RkliS3Y0eHZLWGQxTE93dG5DSnFJSXVoNDlkcHpWaWlhQ1QrbUg2?=
 =?utf-8?B?cVpuMzdKdTRuWGg5bnlTT2xHRmRPTGhJTGpNQjBPR1k1aDVvdDFnNUFrbnhj?=
 =?utf-8?B?M096czdERmMxbFh6UVdQcXFGcURpU3BFMDhwNXZEYmVwWVU4OU9WYk5IY0tJ?=
 =?utf-8?B?QjZlSU9CZW9rTDNwMEgrZzkyZUR6NFdTYzMyVXBVVFk2eXV2VkJXZGtJRGtP?=
 =?utf-8?B?T1greVNDTDlTTmdQeWkwNHZkeHVleUQxVTVpcjFRSXpyU0s1UDV3U2s4c2Vl?=
 =?utf-8?B?QXVpQ0NKNC8rT3kvT3U5TnRoTncrTEJnZ3pIbUhZRk4wRFRJTFNTeVFuekx4?=
 =?utf-8?B?Z1JFMFVlbVEvSmM5aXF5V0VUU05yTTlpWEUzQTR6bm5BMzhyb21YVG9TWG5Y?=
 =?utf-8?B?bG45SkthSnRob0EycTkyQjFWeVl6NGJtaXVPTDlaWHdDczdnak0zMkM3elNj?=
 =?utf-8?B?K0FuOWJMS0d2Tk82aTl6b0FaMEJSdkpwcFYvSmZmNXlsbzhIUGI0S0x2aUp5?=
 =?utf-8?B?eDl4b1BUZXd5ZEgvWVVFTEpXb3BSWG9qZG1JUmFlSWp6TllYSjB0bFBWZFdz?=
 =?utf-8?B?eHc4RExWcktVcEVibTA2dWVIZ2JzNllvWnVGQmRqb3JXZ0NQcExjYmZTRHQ3?=
 =?utf-8?B?TElhbVY4dXBoaE1zMWF0ZFQzSitkSGZZWmxkTCsyZnFPOVdsOWdWcWVqUm4z?=
 =?utf-8?B?QWhVcDhVd1pCaGNoRnhQSzl3OXlZZkUxSUIrUk1LRzh3WWhyOVZPRHlWOU0w?=
 =?utf-8?B?eXlZaHluZUtzejl1SGg4bjhEb2cwRURiL1Vad2JvRzRXRUpoMFdPY0M3RVp6?=
 =?utf-8?B?SUxKamRNa29lNG1jcyszb3VCR1lkUnNoTFEybUFzUmdHcU5oRmRQeW9ZaGxi?=
 =?utf-8?B?MlVaeTZJT1U1RW85aE9WSUc3WGNyaEIzUURBNjR6R0loTTJDVTBwbU4xRldO?=
 =?utf-8?B?ZFVQTDNJRkI4aDNJUm5kUzZ4OGYwNVliS3lFV1FlYnhFRkNwOUZiZHJsOWU1?=
 =?utf-8?B?aFVkcStTQitvNzJ5dkJPTnRDS1RwWTEwaW1BZzdrMldwVlJGbmZUeklLMGRT?=
 =?utf-8?B?TnFYTFkyNUVqRUFJVmhiYUNPNmF5YktXejFQMFZzN1hMWXA1WnBTc3dVMXhV?=
 =?utf-8?B?TVZHcVNNQmtSN080dDk4S0pJcTUxN2E2cjNWRWtNeDJmTVFKYXlDdUU3R2ND?=
 =?utf-8?B?RFFYYy9BSGpodWZ6Rzd4bG1UOHZtMk1WM1h2VUlmRWtONlQxdkhGSkZDSHpB?=
 =?utf-8?B?WmJmNVh0OXQvVXB4cnRHa0pQSGpYS25rZklaSlNzN1R3QzVTa2paaEFFajVu?=
 =?utf-8?B?SXFOSm1GNjRONGJpcFpMSzdrazg2SUYrZXNHVDl1MnUvRXpOTFNhaFkxVHpU?=
 =?utf-8?B?YkNEblpmVUtlWCtaQTZlekFJVlVJeVhTUDZSd1JGNTRCem4zR3dleGpUYVg2?=
 =?utf-8?B?a0NqVCtTVUxsMEJLd0l3aXlSQTZzZWVkTlV1QXB0OTZQcDN6eExwb2lOQUkz?=
 =?utf-8?B?cUdtSE5tVkRZNDE3R1BVZTk4Z2lFa25rWnoyM0g5ak5ZeXZncEpWWm1OS1cx?=
 =?utf-8?B?di82bXRQMGZ1UE1ZMFZEK1dqYnR4aEhvV0xydXNQeWo2ekpJRXIzTWM1VTFT?=
 =?utf-8?B?akxudlI0d0htWTFXaHFWMmtaU3VRR29JR09heGc5RVFtWEpjNjBkU3UwTTJn?=
 =?utf-8?B?Slp3M09pTXJ0aUkzSGpuTkxmZ0kzcDAzR1h4WksvMmwwVVRKeHFWc3ZiclQz?=
 =?utf-8?B?SDhGYktCVGd1TUhGSWE3YmJXb0lMRWN1UWpobHRNKy92Z1MvWnY4UlVMU0o0?=
 =?utf-8?B?N3hCK016ZmF1a1JmaGVWdnhtTUo1SFNDcW9sNFhwWUR6K3JQM3ZKQy93Qmp3?=
 =?utf-8?B?ZEFYVytReUJNbTNBUEJ5Z3h1REtMZy9VSE9wc1k5UjJWc3NSVlhEbjc3NTI3?=
 =?utf-8?B?d1cyWXN2QVpjK25ac0Q0S2IyTGw5OXduUUg4T0ZGb3VDN0RGYmVMdzdHSGw3?=
 =?utf-8?B?WUF2ZUdRRW5NczMzTCtJVEN0a0NyVXN4b1p5ZFpDT1d6ZXFiYnNDSkJwcGE2?=
 =?utf-8?B?VWFRaUN1RGZ4Y3FwWmx0ZnlkSXFxc2s1cEU4cExhUzR2OVlrTlJiTFYwT3lD?=
 =?utf-8?B?R08zNGhoYXlVRGgzYU1ybkI0b2JZSERwd0JQTWhxWm9tZERveURjdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 525baa88-3015-4ac4-6520-08de7f90d28d
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 17:08:31.9515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhZQCrNzPZepHlOE5KoQzOXG2UsonMBnX0Ll+0ZCzfwKRShdJtsdSeAlreUpoiBi0e0sS3rEiByYby36cFOkKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8843
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=nathanc@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



On 3/11/2026 8:31 AM, Eric Auger wrote:
> On 3/10/26 8:05 AM, Markus Armbruster wrote:
>> Nathan Chen<nathanc@nvidia.com> writes:
>>
>>> From: Nathan Chen<nathanc@nvidia.com>
>>>
>>> Allow accelerated SMMUv3 Address Translation Services support property
>>> to be derived from host IOMMU capabilities. Derive host values using
>>> IOMMU_GET_HW_INFO, retrieving ATS capability from IDR0.
>>>
>>> Set the default value of ATS to auto. The default for ATS support used
>>> to be set to off, but we change it to match what the host IOMMU
>>> properties report.
>>>
>>> Add a "ats-enabled" read-only property for smmuv3 to address an
>>> expected bool for the "ats" property in iort_smmuv3_devices().
>>>
>>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>>> ---
>>>   hw/arm/smmuv3-accel.c    | 25 +++++++++++++++++++++++--
>>>   hw/arm/smmuv3.c          | 12 ++++++++++--
>>>   hw/arm/virt-acpi-build.c |  2 +-
>>>   include/hw/arm/smmuv3.h  |  2 +-
>>>   4 files changed, 35 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>>> index 617629bacd..8fec335557 100644
>>> --- a/hw/arm/smmuv3-accel.c
>>> +++ b/hw/arm/smmuv3-accel.c
>>> @@ -52,6 +52,12 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s, PCIDevice *pdev,
>>>           return;
>>>       }
>>>   
>>> +    /* Update ATS if auto from info */
>>> +    if (s->ats == ON_OFF_AUTO_AUTO) {
>>> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS,
>>> +                               FIELD_EX32(info->idr[0], IDR0, ATS));
>>> +    }
>>> +
>>>       accel->auto_finalised = true;
>>>   }
>>>   
>>> @@ -124,6 +130,13 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
>>>                      smmuv3_oas_bits(FIELD_EX32(s->idr[5], IDR5, OAS)));
>>>           return false;
>>>       }
>>> +    /* Check ATS value opted is compatible with Host SMMUv3 */
>>> +    if (FIELD_EX32(info->idr[0], IDR0, ATS) <
>>> +                FIELD_EX32(s->idr[0], IDR0, ATS)) {
>>> +        error_setg(errp, "Host SMMUv3 doesn't support Address Translation"
>>> +                   " Services");
>>> +        return false;
>>> +    }
>>>   
>>>       /* QEMU SMMUv3 supports GRAN4K/GRAN16K/GRAN64K translation granules */
>>>       if (FIELD_EX32(info->idr[5], IDR5, GRAN4K) !=
>>> @@ -844,8 +857,12 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>>>       /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled it */
>>>       s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
>>>   
>>> -    /* QEMU SMMUv3 has no ATS. Advertise ATS if opt-in by property */
>>> -    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, s->ats);
>>> +    /* Only override ATS if user explicitly set ON or OFF */
>>> +    if (s->ats == ON_OFF_AUTO_ON) {
>>> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 1);
>>> +    } else if (s->ats == ON_OFF_AUTO_OFF) {
>>> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 0);
>>> +    }
>>>   
>>>       /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
>>>       if (s->oas == SMMU_OAS_48BIT) {
>>> @@ -923,4 +940,8 @@ void smmuv3_accel_init(SMMUv3State *s)
>>>       s->s_accel = g_new0(SMMUv3AccelState, 1);
>>>       bs->iommu_ops = &smmuv3_accel_ops;
>>>       smmuv3_accel_as_init(s);
>>> +
>>> +    if (s->ats == ON_OFF_AUTO_AUTO) {
>>> +        s->s_accel->auto_mode = true;
>>> +    }
>>>   }
>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>> index 068108e49b..197ba7c77b 100644
>>> --- a/hw/arm/smmuv3.c
>>> +++ b/hw/arm/smmuv3.c
>>> @@ -317,6 +317,12 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
>>>       smmuv3_accel_idr_override(s);
>>>   }
>>>   
>>> +static bool get_ats_enabled(Object *obj, Error **errp)
>>> +{
>>> +    SMMUv3State *s = ARM_SMMUV3(obj);
>>> +    return FIELD_EX32(s->idr[0], IDR0, ATS);
>>> +}
>>> +
>>>   static void smmuv3_reset(SMMUv3State *s)
>>>   {
>>>       s->cmdq.base = deposit64(s->cmdq.base, 0, 5, SMMU_CMDQS);
>>> @@ -1971,7 +1977,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>>>               error_setg(errp, "ril can only be disabled if accel=on");
>>>               return false;
>>>           }
>>> -        if (s->ats) {
>>> +        if (s->ats == ON_OFF_AUTO_ON) {
>>>               error_setg(errp, "ats can only be enabled if accel=on");
>>>               return false;
>>>           }
>>> @@ -2128,7 +2134,7 @@ static const Property smmuv3_properties[] = {
>>>       DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
>>>       /* RIL can be turned off for accel cases */
>>>       DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
>>> -    DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
>>> +    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_AUTO),
>> Is property "ats" accessible via QMP or JSON command line?  If yes, this
>> is an incompatible change: JSON values false and true no longer work.
> So what do you recommend to extend the property values. I guess we had
> some existing scenarios happening in the past. What is the best way to
> proceed?

Is it a requirement to ensure boolean values are still supported when 
switching to OnOffAuto? I found that the x86-iommu intremap property had 
a change from DEFINE_PROP_BOOL to DEFINE_PROP_ON_OFF_AUTO [0].

Should I add a custom property setter that accepts both boolean and 
on/off/auto for backward compatibility, or is following the intremap 
precedent acceptable? I'm happy to implement either approach.

[0] 
https://github.com/qemu/qemu/commit/a924b3d8df55a395891fd5ed341d0deb135d9aa6

Thanks,
Nathan

