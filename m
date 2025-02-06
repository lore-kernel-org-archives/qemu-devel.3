Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3495C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 17:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg5xv-0000Qj-0O; Thu, 06 Feb 2025 12:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tg5xr-0000PW-Fr; Thu, 06 Feb 2025 12:46:59 -0500
Received: from mail-bn8nam04on20608.outbound.protection.outlook.com
 ([2a01:111:f403:2408::608]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tg5xp-0006fN-IP; Thu, 06 Feb 2025 12:46:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVMjkcJN4KL7jD6WVtyPvsusIvF3g0v7XddSYyKUt7PzRKeVfzelpRkQeEtlrokkDRrC5kKHw+JnZXRcii9+sIgv3ssYPzCjB64ddcu0BnPoOGYEX4ZHABtNUoeLwf7UNfr/LQF2VbT8V+7KuqHIz1mS3AFLtCYEGg+VLd564WE2ay7MYPc5MTdjQ0qtFwcQ7WbH5rljsnTulbTD5xq/n5hU8eMdSaqka0Nf/yIGAGVEvnIgneZeuoZYfFFAcQYcaZq+lv5VG8P8N5xaZJGru3XRtFPQ3L+ughvG1RoziSX9uhV0I4udZTySyon6+J+yElO+b1vK48Cf7G8HokskRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gQDXj1daIVznuwukGyX+eFQGtJVGosm+aug1Z2eC8o=;
 b=ujJ8y6xwYF3umFnFFIVnOR8T+GcGBWJm/G30W+r1iDD86mfo0KRmLGySNOVjUyPYt5lwUjDTyLd9RXO8tPIBV1Ut1wsQx50OMh7wflUH+1apq7Z5DDGQZHU31FPFiDmWdZe/68KDR1a198wJZVg8SPKAe3wynWVE16wCyAcSqDrcf/aqrAjOlPELFCOrW//rrVsX/R6PRIEMgh7BkfL/UIEtf1FM+6NN40CcrEoJ9hXa8we9Q2mEkfRgdM61V2bYGSydHwaqo6fQLPW1WivJsSLYBkv6doWf32O1+Uf8HqRsXhd4sh6O7Y5wyx5uJz1JHr37PvSRQ7WB0zuTGEzv7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gQDXj1daIVznuwukGyX+eFQGtJVGosm+aug1Z2eC8o=;
 b=fmRMl4UghOMEcyZE+za7buQ9Iz+ZqSwhsZMMaDsyZGeOiAo1kksmL2D8ocO8nlGjc8vxgJpiGS0inzzb5X1RnvOdvjMKWBF9DvBtMIuPY8MlJb4gUS/leYh7//CjP0yl9b3eOvvvXfFyTSHjRUWsMlhCpbXOCnX3N3WThH16LCoQsOTTfOg2iJpAKO8c3nvw5AyO3VtHBtwMIY7UL7Spu9RT93r5FztmB6hhdhWFxDmUVPbmj6IEYEiJkjvD27OWXW94hwPxbrZ3sV6tMU8VjNojLyNnFP4TxjJeWBAYDnCpdirA2fyURMIw5TJiCK0sd88blLr/54ZT6ekp7TOEtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Thu, 6 Feb
 2025 17:46:48 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 17:46:48 +0000
Date: Thu, 6 Feb 2025 13:46:47 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Message-ID: <20250206174647.GA3480821@nvidia.com>
References: <Z5uiGnAxUf4jXTEI@redhat.com>
 <7ecabe74e0514367baf28d67675e5db8@huawei.com>
 <Z51DmtP83741RAsb@redhat.com>
 <47d2c2556d794d87abf440263b2f7cd8@huawei.com>
 <Z6SQ3_5bcqseyzVa@redhat.com>
 <f898b6de4a664fe8810b06b7741e3120@huawei.com>
 <Z6TLSdwgajmHVmGH@redhat.com>
 <71116749d1234ab48a205fd2588151ec@huawei.com>
 <20250206170238.GG2960738@nvidia.com> <Z6TtCLQ35UI12T77@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6TtCLQ35UI12T77@redhat.com>
X-ClientProxiedBy: BN9PR03CA0505.namprd03.prod.outlook.com
 (2603:10b6:408:130::30) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV2PR12MB5869:EE_
X-MS-Office365-Filtering-Correlation-Id: e7f86272-8b30-44a1-c10e-08dd46d63b17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N25VTDBtOXVkLzB3aCtIajQ1T0NKRG5zSTJER2FhUmMzT2t2MlUxU1VjYUdR?=
 =?utf-8?B?VVRYaTdwVnM0VGNLZXgrRHpDTGswUWVhZUR2SithblRGYnNFVUh4UUNWVUVY?=
 =?utf-8?B?ZWRXMnlHYm5ORDFEUXBRY2hUTitWZmNMeHFGTTRiRTRUaWx1ZnkwWFZLUUZy?=
 =?utf-8?B?N1ZnUWczZXFPVU5DYWlISEE1L3YyYWJSMlY3RXpUSUEvM0pVc2ppaGM4Ri9H?=
 =?utf-8?B?d2VLclpzSUFVWDFTYzZHYXJOa2FRcGY3TVRxSVF5MU1sMjRWd3IyRnZrUUdw?=
 =?utf-8?B?TjI4UG9JRHEvaDBoYlFQbkxpK0pPNjVKRTFSY0hsYkhvQ0EvWkF0VXJ3M1Uv?=
 =?utf-8?B?R29WUXR1cVd3WVhJcEN4cTdoOHZIQ2c4NE1hSk1yYmFLSnhKZHd1eExKVmox?=
 =?utf-8?B?OFZoWDFDR3NyczF5OTVDdWVreEY3YTVseGY1MDJSRjJMR3dITE1pUk5iM1J0?=
 =?utf-8?B?RHY0TndDYlFsUkhCaUdJeVZmUlJLNWFLeitYSXd5UHdoOEpPUUExdHRPemlC?=
 =?utf-8?B?UnJZdTc1Q09kUEV1V0ZCSDEwakprZ2Z6aUlyMW5lZ2tmeFljR1hNRlJhZWpZ?=
 =?utf-8?B?Q1Aydzk1eXhEUUFWdld0ZDUwdzB1eXpzUkFWTFdqZFk4K2o5djFTR0V5bnUz?=
 =?utf-8?B?MEhXUGxvc2dMOEhBU3c4bDU5YWk5TE4vaEZ4SFpOK3VaVzJ0Zm1MMXZOWFNl?=
 =?utf-8?B?Q2xLSk4wZkdhZHFMTEcvTGJWd0l6OTdWUzAzY01ORVlSYXU4M1ZqSEN2WFJS?=
 =?utf-8?B?K2lMdVhkQkVHaVBQWS96K2dCKzR5OTFGOU9EczdwdEYzSEoxK2hieDFHMkRR?=
 =?utf-8?B?UDNPaUFRSnVYbVBmYVVycjV1SmhCYis0VzJ2Z0hnNjhLWlBoVjNTWWYvaTJT?=
 =?utf-8?B?am95UkpJdWRybEhnOVgrcFJSdm5PUHpwOFV5ZkcvSzZqUXBuUEJNTEUwdEdR?=
 =?utf-8?B?V2IwcUk5Ny9NeDFiYS81YmljeVc4SUFsNGtjR0poNGdLZWhqTThLdjdsT1JS?=
 =?utf-8?B?a29SSW1LaWgzUWNJbEFxSVNVZ2dmZ1RkaVR1NEJzdGd6Nm9EZjU1My9ZOEpq?=
 =?utf-8?B?YTJjdStFQ3ZJRk5NdkhUKzdHT2RkVHBLTGJJZFhvWWk4bDVjRk5LMnNrUXF1?=
 =?utf-8?B?dkFBcG10UWNUSGk4WEJwMURTU2Rzb2NsTWxmRm1sTHRVdDhnMXprSlZDamgw?=
 =?utf-8?B?WVZyVVhYZjl3VUxuWEtGdGtrQ1MwUTA0V2tFVVhyTGRMdXlrRzB2ZGxOWWNJ?=
 =?utf-8?B?QkR1cE54Kzg1Um13VUN1Zkl6dlhhQTZLbSszYzV1VGQ0YldmNG5NOThITHBo?=
 =?utf-8?B?eDJDbmZmbEJhaXU5bi92VXVDcmlmazVjeUpkZHBseXI5TTBSbzJvMHJEcVAr?=
 =?utf-8?B?OFl1RTNsUHdxQVVHd1Z1YTdSM3JvL0MxS3JOelRrWTFpdlJGeFlOdEYxMjVz?=
 =?utf-8?B?TVVraXhYU1BUSEtNdUQ4eTQxZzJ3WlVQQ1pTQ0dNVC80ZlcxVHpzbHluUk5F?=
 =?utf-8?B?RW84c0JvY0ZEZDE4SE14R2YycVNmL2dLUmNTSHc3c0wxb3dQQUR3RGt5TjBN?=
 =?utf-8?B?VDdReW1ha1A5WFpCcUgvSHgxRlRwMkQ3MGpOZHAzSDhiWnVRakwwRm96NVYv?=
 =?utf-8?B?eU1JdzUzTXJudGtra3lST0x6RGpJM25zZHhTTnRKZzZQRTE0RXVwc3JMYnFG?=
 =?utf-8?B?N1FNbjhhM0NIY1NPRXBnT09CbHlQYzJWZzFOWDlnRDFCVjZqR3FYQmVOYUM1?=
 =?utf-8?B?MEl5ajE1ZFdNMlQwbGZYeTlvRG1UbDhqak9idFVoeGFTbVlkNU5wZjJYcjVH?=
 =?utf-8?B?U2tqRzFOUEJtWXVmR3hFWkp6NGJ5OGFRd0Q2SlpLeE9hMmphWXluQ2pFQVoy?=
 =?utf-8?Q?oAiYoQJVRky/D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGZxRnRBSDBLWEgxS3hTVXJ5aTlXTE45NDFYTTIvSml4OVRXUmxycGR4WTJp?=
 =?utf-8?B?YU4wNnJiSWxObXI5ZE92QTNZbmN4TE9zYkcyY2RNUHNlZXRCYjRUZkl1QWJY?=
 =?utf-8?B?aWNtYnN6b0xKVmlET0dablBrSzA3cENLQzJ1WVMrZ1Z5Wm5NYlRJbE5VTzFW?=
 =?utf-8?B?d1J6aE9XSm14N2RtSG9pMGlMREFHQUhSMFRkaWw4TjVBdjIvakhRK2VoSWR3?=
 =?utf-8?B?Y21TQUZZSytqZVJvL21NR1FFODlHUmdRL0ZxekFoWEdCRktPUGY5eFE1Nncx?=
 =?utf-8?B?TFdSZXQ2Q1FFQ1FsTVZjaHo4MTM5QXJXS3QrUEc0UmF4am9qV0liL1dXaitx?=
 =?utf-8?B?VzhjTkhHcStSZEY5R2d1aC94cVl2NDRTcEsrQVZDY3UzbmtacU1mRUhxQlJm?=
 =?utf-8?B?cXFLd1NuYzhmVVE4VTFhdFNWemdNNmczMkx3aXVwdjBCcEY5M3dwTU4xSUo0?=
 =?utf-8?B?OURNL3l5TC9IOUhrck5OOFk5OTFiazlOcC9KWUVjaE9wc0dZR2VXRDF5ekFE?=
 =?utf-8?B?VVhWVmIxT3A2eEtxRjFiZXo5cGltY1k1eDQ4T1BaOEk4QTNvM0Uvd01HbTJk?=
 =?utf-8?B?WjlMTVQrdG1zTnJJTnh2LzNNczVmSENiY0ZXTzM4TXowLzlkSm9PQXBvbXVz?=
 =?utf-8?B?amdIejBRRUIyMjNXa2xWQVgxTGNaaXVFci9vdENpS3o2YW1iS2RaL1lDSnE3?=
 =?utf-8?B?Ty81QkJOL01DTm1kRFc3UzVybnl6Zm9GRzBURGdjS2loS2tXQmttOXp1SUhv?=
 =?utf-8?B?dW1IOTNzd0txZVlJc3JXN1lYSzlucW9EZWZjSHFVbHp2WjRHSXRKR2dMT2ZQ?=
 =?utf-8?B?aFhlUmhmQWk2ay9uSWpRQlpqUXVwVGUxT0FHZmloVlJ5R2NmQU5hYTltV2Jr?=
 =?utf-8?B?UnhOQmhUVGdzY2hOUjBITW43QzdMbUxiRUtnRkFneVRPRnhlTkoxc0NsMXEx?=
 =?utf-8?B?NlRtZVJlc1dCK1JvYUNWaW52UHNLTmE3bWZGYVNwc2M3WGNSeXZPaW5nZ0hj?=
 =?utf-8?B?QiszUlJPSk1qanUzOGxGbkJrRElHU3RKQTNUaWpVQklvUDBkT1dQcEsrODV5?=
 =?utf-8?B?eEJPaE1Sc3N1aytMWElDbUZ4RkdBQWVQTlJGUktTc1pOcmV1UGdDbkZNZ2xm?=
 =?utf-8?B?ZEE3RnBiU0lZU0pIeGVpd2IybnEvWE43d2pQcjdzTlVhcFc1TjVtV3Y4ajRL?=
 =?utf-8?B?TGhCUjlVUVlsdUlKWitKeTN5dGZlNWNUYTVQVEhyMGFmNVFMbFhBcm8wMXk5?=
 =?utf-8?B?cEpKWGwyci84VmpHSFI0QnU2c1JyTnByL3BGYkRPZTB6dVFjZk5EUU9HZFVK?=
 =?utf-8?B?ZDNrNG5DMi9LNGZlSThMQklQVXJwSC9haEpVN3NPQ1FRQjhBRXpnalNzeWJ5?=
 =?utf-8?B?elArNTZIa0tCSFZseE5YTWhFQ3JCUndnN0lvVUFaT2EyTTA5VzU1TUF0Vmp0?=
 =?utf-8?B?R2ttWFBFNEIra3prSmxNaDRQWVcvZWJBRUduQTVuVGpVNEtSejFYMkVEZWVX?=
 =?utf-8?B?YlY2SWJ0VnhnU0hwZUF2a3NpNUVLaUVrSkhzRThPS0VGN3l1Z1VlNHcxNDVO?=
 =?utf-8?B?OHI3aStjYXZEbkp5OHhreHFLSW1kbWQwNitNMXlzbytHUlhodUNpVGtlM1Vs?=
 =?utf-8?B?V0E2bERwV3kwKzVQSVkwZzhMVWluREhTTzluMnVSd2RHVTRsY2tiNVlqdjUx?=
 =?utf-8?B?OXZIdVJVZkZJU1R3L2w4dnNXKzNjcEpZbHRSTElCVEdQSHB4UlFnMithdDVz?=
 =?utf-8?B?VnhuSGRSTU5ic3RPc3E0U1NUT3lzWW1tSEZjblVCNm5jN1pRYm9Da0kvM0E0?=
 =?utf-8?B?VCtmdDFhaXY1NkJvNDFGSDcvTXhHbWdnL1lzMmdYY0RiVDRyZTB3Uk53dGNu?=
 =?utf-8?B?T0drUklFdld3UFZGbHQrR2w2Z2JrNW5LS3dzUWgwZ3h4aXo2MWFrM3VpVnNz?=
 =?utf-8?B?RFZZL0RxUDUyYlhhSkRBNjh2L3dBMm1CNVdUUnZ4bGVOTG9TaytERFhtb2kw?=
 =?utf-8?B?U0hnTFlGSlk0MkUzVzFHVitnVDZKSFBYbXU5RGZlalRaVlF3aWlpQVE1RXJv?=
 =?utf-8?B?Z0pONmhNdE9CajQ3bE05MFFpejJ6S21RVFhCQmtFdlcwZk5seUdyemRqUFVr?=
 =?utf-8?Q?+7Z27aJshqnNqqzlmv044kkgs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f86272-8b30-44a1-c10e-08dd46d63b17
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 17:46:48.6914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ALOq9PQ1VMpywIgsv3bFtVP36XW8KyWINNtsFS3n8nLilBpV7RNcEcKQjmxrpb72
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5869
Received-SPF: softfail client-ip=2a01:111:f403:2408::608;
 envelope-from=jgg@nvidia.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
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

On Thu, Feb 06, 2025 at 05:10:32PM +0000, Daniel P. Berrangé wrote:
> On Thu, Feb 06, 2025 at 01:02:38PM -0400, Jason Gunthorpe wrote:
> > On Thu, Feb 06, 2025 at 03:07:06PM +0000, Shameerali Kolothum Thodi wrote:
> > > > If we set the physical/guest SMMU relationship directly, then at the
> > > > time the VFIO device is plugged, we can diagnose the incorrectly
> > > > placed VFIO device, and better reason about behaviour.
> > > 
> > > Agree.
> > 
> > Can you just take in a VFIO cdev FD reference on this command line:
> > 
> >  -device arm-smmuv3-accel,id=smmuv2,bus=pcie.2
> > 
> > And that will lock the pSMMU/vSMMU relationship?
> 
> We shouldn't assume any VFIO device exists in the QEMU cnofig at the time
> we realize the virtual ssmu. I expect the SMMU may be cold plugged, while
> the VFIO devices may be hot plugged arbitrarly later, and we should have
> the association initialized the SMMU is realized.

This is not supported kernel side, you can't instantiate a vIOMMU
without a VFIO device that uses it. For security.

Jason

