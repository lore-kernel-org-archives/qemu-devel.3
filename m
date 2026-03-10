Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C298FD4F09
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 17:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w00zr-000639-5q; Tue, 10 Mar 2026 13:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w00zp-00062s-M7; Tue, 10 Mar 2026 13:35:53 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w00zn-0006fi-LH; Tue, 10 Mar 2026 13:35:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0UShF5rRbO5O0LoHV6q6OuSEK5L9x84isJMxx1zCpDy7dN+Ui+P+AlsP8dk2Xz8pRYEDhPGvaLX2M3iTK+LFGuUFE9DS9Dp1aYVnDnG8OT1qZvCzSUsy9smf1OkVWm8E3SvP6ZIes6mYKzVjmh9sTEivqEMHAQKwkcCMuGfc8PV9vpgVvBhvU3rhiFKQLswLxCBvDaS26dSDVSUdvVv/GwvmGSzSNPaTPhep3DWzb17kClHfPPMTtsMTh3BK9SqfM7nh1jg4TOxT/sDZlLiVtyCzixsd9gCy0nkDKeEapcXJgFLCVXFc+e5GwkR+UGoBEaMLYbB1Vppd8RjylwLlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClYS6VuPko1q3eM2kJSrXn5bwroxPNXD7Qt6szwkU+M=;
 b=B2domqfOVbeIRwtfmu3HFkGm6e3muktrxXVuzS9JLxOkhOS1VLKIyU4hHVcTaqzrT0hIQDxaFmo8YGSxMonNPRYipaQP9JO5fGVruvaaCP1NIYmNkQFSn+IiP/qPRmWPWqRJ5VhU2LUpwOUzxzycXx+i3aD3TfK5pcxAVgwnG6EBzatEc6oHhr/vbXC0ssal9e/aUww+R1O4BV7Lo5CDkZtJUy0RfjZAuxSprUPsOzmGmW3e/mZJCGxgbI0uqMXeIEwJFAddfp2/mYUhAomebkr8r6dLU4XAmkRX2XHoHnfViQCETUTdyYfV1xHRPuf0eFlIoU8Pp8MdQu8lAmpKTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClYS6VuPko1q3eM2kJSrXn5bwroxPNXD7Qt6szwkU+M=;
 b=b2D/1VZCrrcau396w1QtasOGba+tmTesCnn3zEBpHrplt6DwgVCtW5S23ynd0JiZ4OgVKNBf2L8acEP47t8lAXhoc+r2Rht14Wtsm9SHRWh7TcWJ9WQonwH8qkoQjpaQt9jZf+4g7RfAmLJqgBuayCX1rpaDuufuK4fGi12RqeIf65ezVZeJjTBLz8RSPbc6Sx2YBo1blxkFVUJ6TQzzvFPLJTJgXEVawWdG4MtJjHRX9RZGPAm+Hr7i9weIK0ZMUleQ7AlzQ7SP3SzqCUA4cRFErT/28Zuiy7d/J2MHtMqOeNfwu0xiBx+Xuu16O0k8AKdHiXW4i+AzL6/yMsRFSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 CH8PR12MB9814.namprd12.prod.outlook.com (2603:10b6:610:26b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 17:35:42 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 17:35:42 +0000
Message-ID: <251680a6-4e05-4caa-87ce-2bd364707504@nvidia.com>
Date: Tue, 10 Mar 2026 10:35:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/8] hw/arm/smmuv3-accel: Introduce _AUTO support for
 ATS
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20260309192119.870186-1-nathanc@nvidia.com>
 <20260309192119.870186-3-nathanc@nvidia.com> <87pl5cnp06.fsf@pond.sub.org>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <87pl5cnp06.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0066.namprd11.prod.outlook.com
 (2603:10b6:a03:80::43) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|CH8PR12MB9814:EE_
X-MS-Office365-Filtering-Correlation-Id: d9681e87-51c2-4dcc-63bb-08de7ecb7416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: mq9D/wrLnU8KDqc8wBPXENOtfYFNi+hEzM0BH9yD87b3Dx9iipdGwv72ZcnKiA1RCEBP7B85O4tBxh0wkoBg96A/9SChdFH5zz4RQmb2itUtnE/LJBVtIQDhT+fycJDefCIPBhcRzYIpWGN2qwm7RElIQ37D/9ffRWlBwZzaOnOfdTuVUF425myDB7sP8IyLTIbN5wpY+Kfl61FB81vtaYU8NrSUiQA/ruZXGZsMnql2hMkH0/3jYvURHtomMa1YDPSDydVbjP/6X2OvEI8NPBxzfLa5ms6ClkHgm1+dJAbP0qT9a2E9M5+iJuK0Z920Kt1fjyuZ8Qmar2kA0wWxowp/5GIuu9rvS+5+tFJc8KvFxRFgdZp3ftuLdnidIz9Fj+CzLxdW87VtVBWYr/rS9Bs1BJ16AaGWMHp0KkmCfsjR8660/AEltMPpdtSaLCZJqizynjL2xmonQvjC+J3snIviQL1G6vPUaON2utfRT85VSDLdTQqRzvpnyFCqdGQgNhgKMhi87VZUA2LYtTjiNdTDoUIpDoh2+5ShD4INHS8zXRQhFA0AI2De9g0r1Mu6MubgxMFjUQg5J1dkty1D2LJDlLB2gRUx2Dk740QIDj4NUNLK4QTEfUvCnNj9HJQFy62RRoSB8PZsv8jRVgfeH0AK7eYjN2rObXgSl2JOTv5abPnQhk2TkUBa4qLeqMKZJ0KLEGFweVNRiqsq4zm7ApThz8SrlO68T1evMrFfp6w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnBDVVg1b1FxOEt2cFVlMXlHbWJtekxHa0tka2pQSWdvSVlkcXRWUEZpTzlL?=
 =?utf-8?B?WWVFQU94M25PQUcxYkJ4a21mQnRvSjJhb3VPbVk1bmtQMXdZMDNDTjVTWlJl?=
 =?utf-8?B?djIwVlNxTkdnZFF4Z0ROL2R4SHljTXZOY0ZnR1dEMDRoNXJNS05pMmNweEJm?=
 =?utf-8?B?Z283Mm1hb1BHM2xQQUlkcUpIclJhallWY2F2TDdSMVNyY09vQWZaSEg5T2pL?=
 =?utf-8?B?NE9ldVQrMmxwaHQwU1NqUGtWTndVRFZUSnR5cklFUlRIU3U0STVpdG15OWdR?=
 =?utf-8?B?eHdhT1JOK3hYdkJ4ZDUyUVlYNXBjYlVOZlh4L2hlYWV1MExUNWc5cENacC9t?=
 =?utf-8?B?bUM3c3ZSRklQeXZZb055U0UrQ0JNMCt1dHh3R2pRTUxvWkJlM3hDeERmWHlt?=
 =?utf-8?B?M1Jic0o4eWxSVHh1UCt6bHpzUUF6aWU5WlZ5Y2pwdWxlYW9iS0hlWUxEcnJE?=
 =?utf-8?B?d2g0dmIvVnBmSDYyVWVSSTZDaTJ4OTMvc2w4WUJTWFN2U2wxaEdDeDBPL0pZ?=
 =?utf-8?B?RHZ6dlEyM2hOdklBTG5qOWluelFHWGFOWjJabkZyTG5TcStEelZMRzhWWUpZ?=
 =?utf-8?B?b3pORS9Sajc4UEpObGZhM2F4ZWdVWTVGTzdsckVoRVRSWnVvWHdaVjFGdjky?=
 =?utf-8?B?MHZlbVFTckZsSzZ6cjJKTWFoV0F5RTVjZm9qRnIrSUp3QVZxbzdtNTNBNUtr?=
 =?utf-8?B?VWFGUmZySzI3Njc3WmN1d1RNSlpDZHh4cXFnNXVqTUZhanpRRmZIMEVSTm1t?=
 =?utf-8?B?U3RWMVFuVEQwMXVSMmVmTFE2am5sa0NkQmE5YUhwUTBWR0pjSTFmN0l5UGFS?=
 =?utf-8?B?YytGOEl5aUJPaXZSdjJnc1hxYU51NVRpaDhVZ21jcEJob0ZRRTVTRllkcXE5?=
 =?utf-8?B?MjZrYzRJYW11UGVxT204ajUzVWxTRldHMnBiRkpzem9hRnAvNUkvU3c3VHJu?=
 =?utf-8?B?eW1mWmJ1d1hmUCtVV0xKYWlaWnF4SzdqRVN1RDA3bGJJK2NoeHgrOHNFNldJ?=
 =?utf-8?B?MnR2RlNOM2Ntc1BBdzg3NmdNQzd1aEFoT1M3dlBHR3NaNWErVmZvbDVwdCtF?=
 =?utf-8?B?bGRQSkN4bHA1OVBHK2NrdzArQ2dFV2loTGZaL29DQXVEWHZRTzJBTyt4QVUr?=
 =?utf-8?B?aEZZY1Z2ZXdrUlU3bzJCbFYzbTY4UjhndWJJTnhLZnR4Mm1PWFNlRVJiYkFq?=
 =?utf-8?B?NE9kemFueFlhODhTZkpmOHh2K0RUeGdDMEFIQkplMm9YWTkzbEs0Vm5MU0ZD?=
 =?utf-8?B?M0I5eXc3a09qWEowbWxVOHBUQy9GVkdHZ2RvcFNIV1ZwSVZLUGhaY3Q2YzJG?=
 =?utf-8?B?Y3d0N0FCZXBjeU0rcm1FR3RzSVZISmpoa1BraDc0dHg0VkhtL1g1NEdGa1Nj?=
 =?utf-8?B?bFQ4Q3dGcmpkaUhET3FPMzlLalRYOUxmMk9lUmV3L3lmR1JicVd1c3c4RzRH?=
 =?utf-8?B?S3lqRU42VjVRNC9XSzA5UjVYaDNBZjd3SjRxNXNFWXhSZmdzdnd4L2wvYWVo?=
 =?utf-8?B?SVBzK3dqTnR6NDJGb1czcEFHR0I2U3did3dYaFhZd2xxdW5vaW5vU3BxS0wy?=
 =?utf-8?B?M0gwOHVxb3lOa3lGTEhHQU94a2lzRVdUWmhIV1NsRU9ZZTlDVm1zVGhkblhQ?=
 =?utf-8?B?aVFsSkp1dzNaZmRTVkkycERzZTZHdGhkSXhCYmZYZmVwcWFFZFY0eW1DcHNR?=
 =?utf-8?B?bVBMNkI1YkZBVWxicnR5MWRaRlp1dk1yV28wQWhhOWFSemxZa1dPM0xIUGdL?=
 =?utf-8?B?dCtiWkF2Z2ljMUYrZm1pU0xuVXpvR0t0ZXpQMVBYa0tRUzg1L2RFczFpeGsv?=
 =?utf-8?B?ZUdNUU9FUFc2a3VlaGpKdWs1RXNHZXI0WG1rb1d2blU4UGVzbElOeGIxQ2JO?=
 =?utf-8?B?WnBNaktEN0Ryd2s5cUJDMGlRa21jVXF2eTJwU2hhemVoSVF3eUxFUFg4QWd4?=
 =?utf-8?B?WWJtelFBMjNIMG5mc0Z6eGxhSnZsaUxLdTQxQjJsMkVVQjJqbVQzaEtLUlBB?=
 =?utf-8?B?UEZnYjFvRXBva2pCL2RQWUVCcjMyeVoyeGdlWUNkb3kzQmt1ZitYVWN5dk1a?=
 =?utf-8?B?Q3V0UFBqbkIzM1hVVTcwUGMyTGUzSjRYekFqR0hzajRyN3VSdmRvZWFGL20z?=
 =?utf-8?B?VS92b1FFSmt5eS8wTkdzbXFXWUg3aG1UTGZ4cHA2ZW80QnRVNk41L2F1VDFl?=
 =?utf-8?B?TDhIdVlTT3h2c2pEZUxidmFhUlgrdnRYcTVoZURLeS9NWkxGa0x0QldNWEhJ?=
 =?utf-8?B?S1l4b1VXODJybXp3TUJqSXI0UUhzdjVzbkhXaTNaUjFRVmRLSEw2bjZUcWNm?=
 =?utf-8?B?UmlNMnRDMnQ2UUVoMjk1MXJzekFCbUlPRmRnWU5sMTN0SFE3OXhaZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9681e87-51c2-4dcc-63bb-08de7ecb7416
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 17:35:42.5653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Poa65Vqf0sttkWWVG5hj2bW5nITTG+IYeZ1DVlmhV18SUDfe/09YCKW1l3nzm8Qsp7WTYHJAvG0+RaTItx8WZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9814
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=nathanc@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



On 3/10/2026 12:05 AM, Markus Armbruster wrote:
> Nathan Chen<nathanc@nvidia.com> writes:
> 
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Allow accelerated SMMUv3 Address Translation Services support property
>> to be derived from host IOMMU capabilities. Derive host values using
>> IOMMU_GET_HW_INFO, retrieving ATS capability from IDR0.
>>
>> Set the default value of ATS to auto. The default for ATS support used
>> to be set to off, but we change it to match what the host IOMMU
>> properties report.
>>
>> Add a "ats-enabled" read-only property for smmuv3 to address an
>> expected bool for the "ats" property in iort_smmuv3_devices().
>>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   hw/arm/smmuv3-accel.c    | 25 +++++++++++++++++++++++--
>>   hw/arm/smmuv3.c          | 12 ++++++++++--
>>   hw/arm/virt-acpi-build.c |  2 +-
>>   include/hw/arm/smmuv3.h  |  2 +-
>>   4 files changed, 35 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>> index 617629bacd..8fec335557 100644
>> --- a/hw/arm/smmuv3-accel.c
>> +++ b/hw/arm/smmuv3-accel.c
>> @@ -52,6 +52,12 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s, PCIDevice *pdev,
>>           return;
>>       }
>>   
>> +    /* Update ATS if auto from info */
>> +    if (s->ats == ON_OFF_AUTO_AUTO) {
>> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS,
>> +                               FIELD_EX32(info->idr[0], IDR0, ATS));
>> +    }
>> +
>>       accel->auto_finalised = true;
>>   }
>>   
>> @@ -124,6 +130,13 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
>>                      smmuv3_oas_bits(FIELD_EX32(s->idr[5], IDR5, OAS)));
>>           return false;
>>       }
>> +    /* Check ATS value opted is compatible with Host SMMUv3 */
>> +    if (FIELD_EX32(info->idr[0], IDR0, ATS) <
>> +                FIELD_EX32(s->idr[0], IDR0, ATS)) {
>> +        error_setg(errp, "Host SMMUv3 doesn't support Address Translation"
>> +                   " Services");
>> +        return false;
>> +    }
>>   
>>       /* QEMU SMMUv3 supports GRAN4K/GRAN16K/GRAN64K translation granules */
>>       if (FIELD_EX32(info->idr[5], IDR5, GRAN4K) !=
>> @@ -844,8 +857,12 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>>       /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled it */
>>       s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
>>   
>> -    /* QEMU SMMUv3 has no ATS. Advertise ATS if opt-in by property */
>> -    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, s->ats);
>> +    /* Only override ATS if user explicitly set ON or OFF */
>> +    if (s->ats == ON_OFF_AUTO_ON) {
>> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 1);
>> +    } else if (s->ats == ON_OFF_AUTO_OFF) {
>> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 0);
>> +    }
>>   
>>       /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
>>       if (s->oas == SMMU_OAS_48BIT) {
>> @@ -923,4 +940,8 @@ void smmuv3_accel_init(SMMUv3State *s)
>>       s->s_accel = g_new0(SMMUv3AccelState, 1);
>>       bs->iommu_ops = &smmuv3_accel_ops;
>>       smmuv3_accel_as_init(s);
>> +
>> +    if (s->ats == ON_OFF_AUTO_AUTO) {
>> +        s->s_accel->auto_mode = true;
>> +    }
>>   }
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 068108e49b..197ba7c77b 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -317,6 +317,12 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
>>       smmuv3_accel_idr_override(s);
>>   }
>>   
>> +static bool get_ats_enabled(Object *obj, Error **errp)
>> +{
>> +    SMMUv3State *s = ARM_SMMUV3(obj);
>> +    return FIELD_EX32(s->idr[0], IDR0, ATS);
>> +}
>> +
>>   static void smmuv3_reset(SMMUv3State *s)
>>   {
>>       s->cmdq.base = deposit64(s->cmdq.base, 0, 5, SMMU_CMDQS);
>> @@ -1971,7 +1977,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>>               error_setg(errp, "ril can only be disabled if accel=on");
>>               return false;
>>           }
>> -        if (s->ats) {
>> +        if (s->ats == ON_OFF_AUTO_ON) {
>>               error_setg(errp, "ats can only be enabled if accel=on");
>>               return false;
>>           }
>> @@ -2128,7 +2134,7 @@ static const Property smmuv3_properties[] = {
>>       DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
>>       /* RIL can be turned off for accel cases */
>>       DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
>> -    DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
>> +    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_AUTO),
> Is property "ats" accessible via QMP or JSON command line?  If yes, this
> is an incompatible change: JSON values false and true no longer work.

Yes it is accessible. I will implement both the ATS and RIL properties 
differently, calling object_class_property_add() from 
smmuv3_class_init() with an ats property setter function that accepts 
both bool and on/off/auto strings, rather than using 
DEFINE_PROP_ON_OFF_AUTO() here.

Thanks,
Nathan

