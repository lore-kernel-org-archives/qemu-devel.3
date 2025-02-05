Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9A9C02196
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 20:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfmPM-0000zp-AX; Wed, 05 Feb 2025 15:54:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1tfmPG-0000zJ-Mq; Wed, 05 Feb 2025 15:53:58 -0500
Received: from mail-mw2nam12on20602.outbound.protection.outlook.com
 ([2a01:111:f403:200a::602]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1tfmPC-0001M2-A8; Wed, 05 Feb 2025 15:53:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIWpS016te4UbvR503u9BN05tCfoswd/0R3Cnd6/LcpwlHuxHrjTGcTxyoWm9WxfTNSQMHQWE7HhPg5Ib5dBxIvmUIbVHcjDcOJ9344rCzAMgpihRWMYal8fOMcv7Qx0P7cphydCrPoRKpK3inb75bCxUPeK5Jx35GwrfRfnasHLn/CLqKxOYOhX1RkXTl/o+zP/uQi6dAdlxO6SuufVU5U1gbMApoI5d/Wgb/BMP0DWGPfCd8ZZg2UrPHoLq2Qbhr4vMRCS08IuBY5H91xzhSDFAST+O/EfTJISFHHwVj9XcyM3KUnn+pVQE0moW9/lAHYQxDj1wwDixtSQ3BewFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPULv/lJNHtmObMrUUwdiz6PNj0ACmBIsOxWMmPZ5Nk=;
 b=whfQbgv4khhBUTuk0ThbhChDiNXjnMKxRg67VD2wRyxRK5S5e2/N2eBWSLxuh5VNlTQ7CWmYnZ0XPOvDQEl/6dAhmAneJRlrU1paR4Xde35Uz/5GDxv1DyL231r1OFt9gal6gLGEyiZO1k1kprnCgfUkLX32GKl7+z2Ul7CgiN1xr7Etn/z5l4Tuf5iI78lPAw0AwiQB50+vw4b2qUhQYOxpmR+/5A6gA+u5067uCDs8gG6ARqTM32HWAuV9dQUsCIgYAIhteFQQp3ZnbYpq/yXrn/CBhOSUI/f62Yu/UqRuWXv248laub8Wre4GU1g7sUfK3cEAjyGpSSKFI40qqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPULv/lJNHtmObMrUUwdiz6PNj0ACmBIsOxWMmPZ5Nk=;
 b=DTcKYPnE8kbhfPg5gaSae2C4k6d8anpQAnBYfIa+ik+lWK9UeHTGNI75hO7vIdfrSkTBVP4T5MkJQ1H8w7/qjOPjkofOt5afe7F0ehINdoikKOKjji0ByV2JzuHjsBhggNLR/2DsLqRpuJI1zX9dE7R9LTR6LHPxD1+15psCPr08Vb8ucXr4p8v+LHn8F5CTqxtl+KjMjbDjbwkcwyFngm2Xww7hOyhyU8jj2td/sdduRNBbmGwBuPXgxgHpaSDKcsiUub8JLlUw+o38Ec2Pte5UqcUdhmlvvRIk0UGFJ4dqtS3VfbmGlFxK6aOcJDxOOEpSHtXUwsI7RJFJIW7tBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB6838.namprd12.prod.outlook.com (2603:10b6:806:266::18)
 by SA1PR12MB7247.namprd12.prod.outlook.com (2603:10b6:806:2bb::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 20:53:47 +0000
Received: from SN7PR12MB6838.namprd12.prod.outlook.com
 ([fe80::529d:478:bc5d:b400]) by SN7PR12MB6838.namprd12.prod.outlook.com
 ([fe80::529d:478:bc5d:b400%7]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 20:53:47 +0000
Message-ID: <5709592d-cd1c-4894-a1d4-c0c4c61a2e07@nvidia.com>
Date: Wed, 5 Feb 2025 12:53:42 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
To: eric.auger@redhat.com
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z5uiGnAxUf4jXTEI@redhat.com> <7ecabe74e0514367baf28d67675e5db8@huawei.com>
 <fc91e1a798324390b2a556fae5d40f46@huawei.com>
 <20250131142404.GP5556@nvidia.com>
 <3efcea1171af4b2f81be842f2c55fe51@huawei.com>
 <20250131145411.GR5556@nvidia.com>
 <20039bbc40df453a8a41a863d74b9ff9@huawei.com>
 <c292ab40-3620-4e72-b043-4e3cbd7fd297@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <c292ab40-3620-4e72-b043-4e3cbd7fd297@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0159.namprd05.prod.outlook.com
 (2603:10b6:a03:339::14) To SN7PR12MB6838.namprd12.prod.outlook.com
 (2603:10b6:806:266::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6838:EE_|SA1PR12MB7247:EE_
X-MS-Office365-Filtering-Correlation-Id: d78a34a8-697b-42da-d7b3-08dd46272f6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDFVeDYrenUyY2tvR25NbEUrT25HSlBmcTgxUjhaT1U5NDQwL3FHcVNJQ0hq?=
 =?utf-8?B?cHRweFBXTm9Rc1NsNkNlMGw3aHNIQWptSEpvS3NHSFI2WW5Td3gzUmJ0MzRK?=
 =?utf-8?B?dDNvVldoZ0lrMDJxSzhGQjhWc3M4Z2RsVmpKTTAyVytENjhDRUR5U0JsWGJC?=
 =?utf-8?B?Y29NQzFMOERCWW1QQVhrcVNDL1JaTmlwWnVZMnZQSWNnWXhaT0g1MDB4SHds?=
 =?utf-8?B?YWZKcUtKbk9kc0NiK3dOVVFIZWFoZWhXc1NOL205TTduZ3RuQUZyd2p0OXo1?=
 =?utf-8?B?Sk5CWUQ4QXN5ekJiTW9mRHVmMThkWEhwVHRzMzUvRXAweHR0Y1dqZkJzclZG?=
 =?utf-8?B?ejBXL0s2dzhOSTdKb3VxU09LQlRYdXY3b1NJK0dVdzhjMzlyZDhPUUVSVm1I?=
 =?utf-8?B?NTNneXQ3ZEJoRUprTTdHVmpzZStMYm9OWXR1WjJNNjl1NnB6alh0VW43dFhB?=
 =?utf-8?B?OVdSanpXWXN4QXZMakRhVWRMMjZZSTh2c0NiYjRCS2JBR1JxWTJwUVJtd2pk?=
 =?utf-8?B?VlM0R0xLL3o5NHNMOFU1R0I1QnBjMmI4TEtBT3EzWFhIYjZpZ3R5Qndab3lj?=
 =?utf-8?B?OEhGT2tRMlZKV1RhSVJjUGdwZXdoNXI3UFVKZk9CcGRLSkZXV01ZMEQ4QUhG?=
 =?utf-8?B?MkNxMjNCSW5CZ203NEkzYm93L2NIZ3U0Y3RKRk5BRGh3ejdMWGdud0ZlNHBr?=
 =?utf-8?B?ZkNkSXV4b1M3OHRvbGxRdXY3YzZnWGMydDVzck1KMzdGREl4S21aQmovcko4?=
 =?utf-8?B?QitiaXVzSFF6NFVqUnB0VUFYeHZwbTY2N0w2d1dUd1JObjNoQmRSelZsZnRD?=
 =?utf-8?B?b3BmY3BTaFNlbTlvYmJodlByODdqMjJvUTZXWWFRN09iSFVWalBqcmQvMjd5?=
 =?utf-8?B?UDFyc3Fpckw4NGtqMHlUL3R2QlpyM1hjRGwxQ2p6c1d4QXVnNDJnc1lDRWYx?=
 =?utf-8?B?NlZKOG1VNy85d1lxeUU3R3UzQXo0eTdmK3ovOTBiTUFUalI2dm9DVTd2QXJk?=
 =?utf-8?B?cVJYbHUxRXl4bmQ0dFRsT2toS09NMHQ3ME1UbHBxL3hQNUoxT0tmOTZMNEtn?=
 =?utf-8?B?bWVVWWt0U3R2Y3lEaE9BOUdPN2x4TGRMcVZHYkpxb3RYdHVvQUhxU0M0cHdY?=
 =?utf-8?B?UVh0eHBJNUJ2RUtrT21jZ1Zha1k5ak4wTWVQWWZFdnFaZ1RTTGI1bEVKWjhL?=
 =?utf-8?B?RW9iaHFyWDlxV2F6ZzlsdnkwNEwzUkhhR2dJOTUzV3lxSktlNU43QTdEOXhI?=
 =?utf-8?B?WkhxeEJQR1QzdGlMdzdSZXBnWS9MWTJvNVd2aFJhU3lTVzBHQ1NOMkJpUFMv?=
 =?utf-8?B?SUFiVk1UaGhtTkRLM29OOUNXSGYzMFJZQ0IzWkxJczhBNkwxOG1sa2M0NnlJ?=
 =?utf-8?B?MkJIajFWaDBYb1BFWldvaHJPOTdJeXd2OVNHZHVVMEgwaXdteTRjdUJOMEUz?=
 =?utf-8?B?UzgzenRURjZaTTcvVnBaVk0yak95clBFVml1RmpyNVNnN0dHajJubDkwT1JK?=
 =?utf-8?B?L0dlRjU4UUNaRlhCSUVOdys2Z3ZWeVZxZU9BU0tIUmI1MmFXQ1NvS3dQVnpS?=
 =?utf-8?B?Q2JEZzc5QTE2akdCMVkxOVlpSDdMR1NEUU9UaHE2ZDZ2TkNaWUl3S3R2QWRz?=
 =?utf-8?B?dmNleGF0S0RmZ1lwYS9aMlR5UEJnUzE0T3NzSmZZcm50YjI5OGpXcXFhMElP?=
 =?utf-8?B?T0tVMzZkRmZSKzRXbTBCZ29xaUxQVU5LVjY2M3NBcUx1bXU1V0VRYVFFeVJV?=
 =?utf-8?B?R0gya1p6ZGU4cFdiVElyV2QyV24wN2VFTWJHR3diNno5RVQ2MGdCQmQ3OW9x?=
 =?utf-8?B?dVUrNDIvSzZ6WWM5eUJ6Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6838.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEt3N2ZuNjh6WGxFMVI2NjJtRjZRdnRlMGdPQkc5MjJjT0JrbjRpWUV0ams2?=
 =?utf-8?B?LzZ5c2dBUWplZ0tjRzV1bHVYR0VEQ3hCdzdQNkRtN3ROVU9QOVllM3hOM2Fa?=
 =?utf-8?B?T1M1b3VUNmRvMlBnVjBTSTFJeDQvSXJHTUM5ZExWZnlaYkhXeDRPUmsvQ2FS?=
 =?utf-8?B?dno3QjgyS1N3Zm5mV2RsRWNxeFI1Q2JpZzRzTlVZYisrQ0g3akpvM3FpR1dJ?=
 =?utf-8?B?djdnT1lxYzFuTnlhQU03SHZROVNVa0FLZlBjSTczWmo5Zk5QNUlXK0NubU9F?=
 =?utf-8?B?b2lZTnJwYVNOUDZGeDBQelAzd3daOTNiK241eG00RWhvVGZSY01SMUUwWUE2?=
 =?utf-8?B?R28xcEd6aWxzSmZyVVJQWkVyWWxuYnNjMjlPUGovbWhpOUtxTWJDaC9PYWd5?=
 =?utf-8?B?RHI5RGxqc2pQS1d5VTMvRXJPV1NKYUQ0bXl0VnpVOFRlTkxOSmR0YkRaWFM1?=
 =?utf-8?B?MzVWNjg5alNGaXN5QzdQL21mMmc3R2JJbVBrczV6ZDVTbzJ6eHRMT1N0Tnds?=
 =?utf-8?B?MVhLSmwrRTBMc1FWY0cwa1YzTzlEUHVuc21WMkplL013WXI1Y0VkcytKT2lE?=
 =?utf-8?B?WmdYaUxaOWt0UkV3Ymx4L2M5TzhTbU8zcjQ0Zm9aNXYyb1pPZWlLYzUyQTVx?=
 =?utf-8?B?SmJaQWZROXJic0YyeXRicXNVTDdNTWNCd3YydkIyQmtCZnR2UHRhd0I3NjR0?=
 =?utf-8?B?Ri9xcngxbEdHRkhkeldLT3phUms4U1o2WGdpaFJTS2FnUUp1c1l5SEUvSkw4?=
 =?utf-8?B?Ni9MbjdFbFBEKzR1cXJpd3VXeVBaK3I3eWx3NnNWdmhaY04wZzVJd3hGc0c0?=
 =?utf-8?B?a2JKV0tYRkk1cHZPeW5rQ2Z6RitTNjQveVF0eTBPVkR2ekFuSUgyU1I1WlMw?=
 =?utf-8?B?VCtBNEkvZWkxbXJNTjVYU1Q3cE9UT2l0VVBLK3N0QnJacUI1QzRjRXl3SnUz?=
 =?utf-8?B?T0ZoenJnYm11THRhaGhIWTVGbDRJd1VxQm83YjdsWnY0RExQa2RKUUpZeEl3?=
 =?utf-8?B?L0M5dzB4OFQvRTBXSkV3OHg4Tnc3SVNkZDR3OTkxTkJOMk00Q1lzdGVUS1Vs?=
 =?utf-8?B?UmxkUWNzczI3YVNYa3hlYW9Jak8wSDBBTHh3NkJwZUhZUE9VMk8vNWcwd3gr?=
 =?utf-8?B?MUk5bG9UMzJDM0dyUzJzU0VmQ0g3eEJKQVNVMml3V1FaajNiSnRLQ2xMZXdG?=
 =?utf-8?B?RHBVSU12YkxxN2k1Z2t1U1pkaE5nM1cxNzAzMStOM2h6RXlBWUJuczR5bmtJ?=
 =?utf-8?B?UThlMHA2VmRWNkRkaGxlcm4yQXpoMjJDV1RZQkwwMktYOFYwUmpicUpMWUEx?=
 =?utf-8?B?Mzh5a0UzdEhCQ0lTbXdyc29RU0drOEZtdTN6S2xsNjlhR0dicGxTeWVwdjZv?=
 =?utf-8?B?bW90RzZqUWg3U3ZaZ0FxUVA4QTJlNVpZbGhHL3VBSS9pTCtVeHZjb2ZjREo3?=
 =?utf-8?B?VkRuTktCeFNkcWwyYmI0b1diVndxSkd6S0xSazFsbytGeW1CVDhocDZnYjh0?=
 =?utf-8?B?R1BGc20wbTl5dE8wQ3F5ZXlTdDlOcHpBbSsyRU1NTk5KQURENzN2eldEcWxv?=
 =?utf-8?B?VzJqaDdOMzJSYUdoWFk4cmV3b1NvT1RuMnNmaXFzc2UrMXFpMDBhVHozbXVX?=
 =?utf-8?B?bnk3dlpxcFJMU0g3L0hpNDIrK0VYQks0bFg4L2lLcUZmd0EycXZqd2d3dE5H?=
 =?utf-8?B?ck40TmV4VnY2dTJpdlBBNTk4U0tvYytZaDdYOTNNMmdzNjUvNXQrdWgyWERy?=
 =?utf-8?B?bmRXendmbXZaNFVtcEgvSjg2S3Z1RVJBZ25XSzVXRUtacUtvMGlvZ21nUFM4?=
 =?utf-8?B?eVJobVdEVjFDTCtnMGZBeHNBZDNuSWl3RndHMytqSnpMQWVHNGpZeEFFb1Rv?=
 =?utf-8?B?VThkbVNQUnI2eDJpU3l3WkxTOGx6Zm1kaStlaU1EdEdtM3dwV1d5MnJTejBw?=
 =?utf-8?B?VW81bGp2TlZJRVNlbXY2eE1LWXNUYkg4aTJ0eHdWSlYwWEJGZ0hoVlVwcDV6?=
 =?utf-8?B?WDk1T2dwL1FYMFEyTVFJUWRHYzFXT2VmY3ZnTzB2Z1FiSSsxUmdXNmM2cFdn?=
 =?utf-8?B?UE5DZHYwc2RRSXFhS3Y5aGYrZFYzczhCNmlRcDNVWEUxSWc2c2tMUjlkdGZl?=
 =?utf-8?Q?qEFrEXgRVekyjRGa5kAuaP6bI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d78a34a8-697b-42da-d7b3-08dd46272f6a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6838.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 20:53:47.1271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlAAPirAEsWVk9WVJdDoLBiOONsVfQ5LPgdgx1rTQo3pr14BejhQsGWlDpsx2+wo/gD+++/xqA7UX8YeVP1SGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7247
Received-SPF: softfail client-ip=2a01:111:f403:200a::602;
 envelope-from=nathanc@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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



On 1/31/2025 8:08 AM, Eric Auger wrote:
>>>>>> And Qemu does some checking to make sure that the device is indeed
>>>>> associated
>>>>>> with the specified phys-smmuv3.  This can be done going through the
>>>>> sysfs path checking
>>>>>> which is what I guess libvirt is currently doing to populate the
>>> topology.
>>>>> So basically
>>>>>> Qemu is just replicating that to validate again.
>>>>> I would prefer that iommufd users not have to go out to sysfs..
>>>>>
>>>>>> Or another option is extending the IOMMU_GET_HW_INFO IOCTL to
>>>>> return the phys
>>>>>> smmuv3 base address which can avoid going through the sysfs.
>>>>> It also doesn't seem great to expose a physical address. But we could
>>>>> have an 'iommu instance id' that was a unique small integer?
>>>> Ok. But how the user space can map that to the device?
>>> Why does it need to?
>>>
>>> libvirt picks some label for the vsmmu instance, it doesn't matter
>>> what the string is.
>>>
>>> qemu validates that all of the vsmmu instances are only linked to PCI
>>> device that have the same iommu ID. This is already happening in the
>>> kernel, it will fail attaches to mismatched instances.
>>>
>>> Nothing further is needed?
>> -device pxb-pcie,id=pcie.1,bus_nr=8,bus=pcie.0 \
>> -device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1 \
>> -device arm-smmuv3-accel,bus=pcie.1,id=smmuv1 \
> I don't get what is the point of adding such an id if it is not
> referenced anywhere?
> 
> Eric

Daniel mentions that the host-to-guest SMMU pairing must be chosen such 
that it makes conceptual sense w.r.t. the guest NUMA to host NUMA 
pairing [0]. The current implementation allows for incorrect host to 
guest numa node pairings, e.g. pSMMU has affinity to host numa node 0, 
but it’s paired with a vSMMU paired with a guest numa node pinned to 
host numa node 1.

By specifying the host SMMU id, we can explicitly pair a host SMMU with 
a guest SMMU associated with the correct PXB NUMA node, vs. implying the 
host-to-guest SMMU pairing based on what devices are attached to the 
PXB. While it would not completely prevent the incorrect pSMMU/vSMMU 
pairing w.r.t. host to guest numa node pairings, specifying the pSMMU id 
would make the implications of host to guest numa node pairings more 
clear when specifying a vSMMU instance.

 From the libvirt discussion with Daniel [1], he also states "libvirt's 
goal has always been to make everything that's functionally impacting a 
guest device be 100% explicit. So I don't think we should be implying 
mappings to the host SMMU in QEMU at all, QEMU must be told what to map 
to." Specifying the id would be a means of explicitly specifying host to 
guest SMMU mapping instead of implying the mapping.

[0] https://lore.kernel.org/qemu-devel/Z51DmtP83741RAsb@redhat.com/
[1] 
https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/7GDT6RX5LPAJMPP4ZSC4ACME6GVMG236/#X6R52JRBYDFZ5PSJFR534A655UZ3RHKN

Thanks,
Nathan

