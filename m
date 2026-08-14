Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797BAC5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 09:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuo8y-00025X-MV; Fri, 14 Aug 2026 05:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wuo8w-00024p-HI; Fri, 14 Aug 2026 05:24:02 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wuo8u-0002Pn-P9; Fri, 14 Aug 2026 05:24:02 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67E7ip8c1293082; Fri, 14 Aug 2026 02:23:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=o+Xcjh1heYZqeApVYpsRCA3NC3R2BqnEy6WEhicWl
 XE=; b=VAOP3fs05AEditaVQfjy20ofWt34Oc/Z1avYrplCFEqVgoj147fsY1BUc
 1B/R9x69Y3GqmgTOom+GAMJY+gOMqzAWzMQndx1BpPav8bWWbswFvbbmVT6m0nhW
 8tvKulTH+xO51DpG8b/UUoA8/ZCZ5GGDgasTNQ5iKkneCqBSozAnCUc4976AClGJ
 Z7ryjBpdUlEh7fNV947RadwWirlcKtUnHYa+OTWzgN6B8JTiZWTjMnbciGdwHGvX
 ZN+U1YfQ09WrfEVHid32Ej4BWy0YZrVwHDibLVRXOb8+0RYIRRZzvNkacnILBuXn
 cob4Hixs3VjZ85p/Kul9TTGnOyfMw==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020136.outbound.protection.outlook.com
 [40.93.198.136])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g1p0fh6f5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 02:23:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/S75Z68sdmt24opHvXQreBWK0Agr5lBc9VVwMtwBkxXrUfdxHlcpmK2sXLcfC+83yDGomWqdAp97b/aJmJtQ3iQhGaZYTSZUnr/Ds57mHjA4SfzD9ohlq05hHXV3FcdxHccc65B/f6r+dvpkjAwaEvpJhFDxYSzMxhcrLHdO1qnM4XxXKpSzyXxxqSIdwwBmNhFaogmZ0y8QnAK+LaxCK3AeYqMFVh4XNW+PkgkKBogQabaWU6PmmNn0i1MK2+ig9BixmWJ3njGvxPwmYMxy1UKnNQ1CHKG+uVb5Tp0SoKvatG+YezSJCqfM5wfoOCLA6rU4V07Heg9skZqJ9UQMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+Xcjh1heYZqeApVYpsRCA3NC3R2BqnEy6WEhicWlXE=;
 b=gAkp55DtCjTUmSVaU0RrGMa/bjC49/TmlFCDEqkvQFbfLnlXzelom7m733UsukHvucf//FMry/fOuCwNuxzUelzfNKoNlGkgXKgkMy59MSaK7RvwmOS7Sl7av3q5V/qZzSp4+jffrD4yT17c56aZK7CGi8Teu2zlmYdrcIiNUEMzXn5O3CuotvLJvrfwMntCdFlbamdelSmX9rvsJtGvm+TdkRwbgplvEP02GjO8avyyzI67868aAsHJJejmXTXdE1scc9v+Aox7c3QutgAUeO8icoZwUKDkKmY2cEB4a8Eo3uXaJaZSMgszU4Eegx3yeGXATuaI/F9T/9dSqdTgOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+Xcjh1heYZqeApVYpsRCA3NC3R2BqnEy6WEhicWlXE=;
 b=Y2FCpldSujql6eA1QZ2+lmovm5RmpGKKI5LIH1giciUekWoOgEIo40HU7bljoH/IgX/fy/GxLRKBzlbStiC9hUKCQGkmctdMljxOoSMFzON/arECe/fRvJwE3yEd0vXJPdNX7KvIsVjhAKInvffHsZPfiA59RB//a02K56XWUwsymZl1mrMYmn+a/InrtlQCv4wMH4brVDfd6Zqmm9a6eliEu5tpDzEPtI4vUQs68O1U9tsVDdoZWwq2G3Pk5Gu1NKNn7X4NyQqO/POINX2PbFQfQcYYG60H6LpnsIsGiqXO8IzW3+p6eSA1nCu/JrztLNFGnjCy2r7pnKxz8RSWuQ==
Received: from MW4PR02MB7153.namprd02.prod.outlook.com (2603:10b6:303:65::11)
 by LV6PR02MB12124.namprd02.prod.outlook.com (2603:10b6:408:425::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 09:23:49 +0000
Received: from MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd]) by MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd%5]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 09:23:49 +0000
Message-ID: <4a09aa8e-b0ea-4890-9a25-ff77503e249d@nutanix.com>
Date: Fri, 14 Aug 2026 10:23:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] qom: tidy-ups and preparation for class property
 conversion
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 pbonzini@redhat.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260717135254.508701-1-mark.caveayland@nutanix.com>
 <an2epcdoZPrz1T9Y@redhat.com>
 <1e3fe188-2406-4ab4-9555-bf04b6d1498e@nutanix.com>
 <CAFEAcA_u4zec+O1q9ZQHpih7EoH6nf4swbHDxhY6QEXGugE_nQ@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAFEAcA_u4zec+O1q9ZQHpih7EoH6nf4swbHDxhY6QEXGugE_nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0035.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::8) To MW4PR02MB7153.namprd02.prod.outlook.com
 (2603:10b6:303:65::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR02MB7153:EE_|LV6PR02MB12124:EE_
X-MS-Office365-Filtering-Correlation-Id: c50514e8-e394-445f-2078-08def9e5bf7e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VkLH4S8+S4D4gtWiBSFWIzjEBpaLORwi0VoV4djnrcei4dLCZG/3Dzf0z7mOfiwLmqmdbCMxtvLOwrNbgfKuVwDlac2xcOIDx9FZfInF0gapojtvHyMyj3jVayRvOMi2BAHo+zSdOacgumdggIrDjjRd7oUk94VqLFidoi0XANN1RsURCQeBBQBv08l1rBD+/yKqk5YhRD8QXgb4scyuSp+ZLB/91fLb+MQW1NRtQ90KsDIO63BlnQ7E0y80JLpql36MYuNz4Sv2/GHC2Qpqc/Q+KOpNp3490XlFIZEuQNosfrXUbkNx+IOQLcvbHib/+/8EQi6rAEIP4YOdXsMbFmezKxm4Vc9gPQWSjzjwWcfhXNa2tCcBpwPFF8qvFOyuuihjE4TJpoV7XYWXU7zY/uxQ/P/ia3os9aKekLCP7IcSOzxgBZVT0ktFu0LNi4UO4eqaanR4yZTyYc19HyadamII3JBEaFz20Vu3XRH5ZLHKsPx+9nbvTsl0UBrLpQVcgv7kgKwms7RJRo6jJhRX8U/hQpMbMBY2GyKvN1C1OIYTh4QrrpFnzOXNg3yxoBdu7h846Bp3mh7ySeK0CU7cPEQP94nlFMQNVbqCMEYOn0iApERm62i/H5vC/fBAeHahm6S2lzTBWDGrbRm4HiUuFM+SQ3+T38dYIpn57n5IgSk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR02MB7153.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFFHRitiTGZza2FFNFB5NmU3QkhicE44TG5RNmdBRG8zL290OFF4NFJlK3NK?=
 =?utf-8?B?RWFpQVc0dFI1SStmU1d2UFpaZlEvTCtaWmNCM212cHA1WHpXYVhLOUNwTXJk?=
 =?utf-8?B?RkFOL0Z2WlFpOFFRMHVNcWQ3YWpXK09jdmMwcE8xS0NDdnJXcERpOHJpYlV3?=
 =?utf-8?B?eVJSTmw2TDhGcm5DbXJBSy9Nd2hIY0Zrcmk2QTdJQU9ZdDRwdjdJaUt4Vllp?=
 =?utf-8?B?Mk1JT2dKb3BnZ2lGS280OG5uQlJIL2tHUmQvOWVOYjJUdjAyayt3RnFEMkUy?=
 =?utf-8?B?ZVQ3bHhYdmNuaHBROG9ZVHBLSVg5UXhock9CbG9BWlRtdVdkdXhOQ2dlTTFN?=
 =?utf-8?B?Z1ZoM0l0dHk4M3JmOGRkWUkrMmtxT1h0YUJoK3BQWldYdGltZWdteEhKM0dk?=
 =?utf-8?B?SzcySlVKVmtCZlcySGg2WjErOWxXa0RMQTZhRS8xcFVjNkpyd1k0cHUvVExv?=
 =?utf-8?B?Zy96ckhZRTFjaGN4RE9CUnA5TldPWXBtZ08ybVlueE4xcEthbnB3aG5aMm9R?=
 =?utf-8?B?bWRvZWVVK3p4akZmSVo1VkNSMXlUWUt3aFdkUkJHU1dhMlN0MGFpME9rRURG?=
 =?utf-8?B?RkdjVk1GSU96Nkxrem8xTUlKZUN1dzQ3QmRpUG5CZGt1bE9PTVNuZEYzbHRt?=
 =?utf-8?B?Q1RIM0o1VjZqRC96WFA2TEkzMUgvUW9aam8vWjQ5MVVmUjFybkt4T1R0Y0pu?=
 =?utf-8?B?VjZvbTEvZzdZTzdGNFFHaFVCb2N4OWQxTVBvRkZZQ0xhWTJwVnJDNUJUb1pE?=
 =?utf-8?B?NVVQandSdkM1M3gxbnRMbkltd2I3TWhtRUFuSjF0ZkxyUWN6T3Y1SXQ5WGhh?=
 =?utf-8?B?OE9QMEh2NjVQbE1IeHFqVkVpZVBJNlBxazgxTDlBNmdSMmRBTTk2elVnVW10?=
 =?utf-8?B?UVJzQmFva0hLTkp6Yk1MWkFDZGRDNVdTN3hmTXowOGFWVGpEN2lKWmpJM2Vp?=
 =?utf-8?B?SW9nY0ZCYytVUE9GamxNQXBWdlBoaDNjdCtGQ1V6cjJlT1hMOGFJR3NnT3R5?=
 =?utf-8?B?SVNwU0pUbWpXR3ZId3duekttTitTOUcxTXR4c0F0NDg5Y1BqNDZWODh3M1ND?=
 =?utf-8?B?MG0zNVJZSCtURFliU05WRk1VOTFHNWdwbzNzN1R5Zk1sbjUyakRvNXNveXZr?=
 =?utf-8?B?dkFBcHJ1NklPU1VBK292NUY3OHJXSm42U2YwK3hSanozSTlCdThCV3J3d3Ur?=
 =?utf-8?B?b3FWSUR1UExCRnVZeTFOTnVnYkRkb3NvZzhkZTBEeEppVzZIdUNXdkJpdmR5?=
 =?utf-8?B?cUVpTkZ2Z0dQb1B3ZUcyNDdCWkFpR0JWZFpLY21VajlFM01TRm1wSDV1d2RT?=
 =?utf-8?B?MHM5NDJHMm1WaDVjSFNFQVAzYkRjY2dMaDRQaW4rcXF2Y3JFbS9XR3dKSks3?=
 =?utf-8?B?blc3Tm00Zjg5QlpzMUNvSDh4bkpMK1hWWnN2SEt1YWZBcGROaFJNTldmVjlt?=
 =?utf-8?B?ZHFLaEQycnBYTjB3MVZXQzZia2lZa0lTYjhMK2dwR1BGSWYwbHl0clZacGhh?=
 =?utf-8?B?VDY2S080aE9nV3hDTkpTV1BuYnRhcXFSSUpTMEhTOHIrY3NWR2lWc3piNHho?=
 =?utf-8?B?eCtvV0xrTHZQcTFCNGNVMEZ3VVpsUm92K0N5Z0FOZ2kyVis4ZFljVGM3STJu?=
 =?utf-8?B?YTlqcmV2NDJCclV5bTRiQkJRcFVZMkgvYWFuMmoxWlFJUVZUWVRDcE82c255?=
 =?utf-8?B?R2lrNGUydXdjL29JWGVhQjAvSXB6Vk02ZGd0cHNKbEJnYURCc3ZZcVJGWFlh?=
 =?utf-8?B?ZmQwSWk4cW1YcUI4V2JTc21MYzVLZVdBVmdnaHhsUk9qU05EaGhzZmV3WlYv?=
 =?utf-8?B?Qk1IcklqTjdDaVp3SWFRb1lGRUxSa1BiaU95UDNJZFdER0E4U25mNVZnYzRD?=
 =?utf-8?B?TnF6NENBR2JwZW9lWWpRbmZPalYxTURmVkdVWDFnSnhnTlVGN2RJNnp2bUFK?=
 =?utf-8?B?cmhQVG9Fc1JNTGUxVXVLeEJYQjBQcE8xQVNleTdDcE9JQmZaUG5NVzlXU2tU?=
 =?utf-8?B?UVNJL0hidmdwSHVCWStMcDV1bEhxSkM2RWJkZmNGQ3BHOVhnRXN3cXNYM3Rz?=
 =?utf-8?B?KzU3aUo0UTZDQ0hXK3hiRVcrOW1QNGtmb0pxczI4NDlodzE1b3dnUXkxRjJV?=
 =?utf-8?B?UmdpUDBiS2ZicVVUVG4yaHZET3Zta2lYSGtpZ040T1BXd2c0ZURPQVQ0ckNR?=
 =?utf-8?B?aDVrKzhIZWllOEFlSjUyeGd3TWpFcWpnVTVNb21ybmZlenh6MjYwbVZNZmZl?=
 =?utf-8?B?TU1uOFo3ZmxmTmkxYm04VlJzUzNsS05KSkFZNW10eU5iL0dyZE82akt1LzVH?=
 =?utf-8?B?UG1na3gvdmZXT3Y1MFBHcEtRVGZuLzRCVGVFY2FGcUs5Z2xJbFFLbkNTZzhK?=
 =?utf-8?Q?R4NU3xqQfAdL7t4M=3D?=
X-Exchange-RoutingPolicyChecked: pdCEKbXT4aYvACr6niKr5xRslavTwv4ld16UXdDCXXNMaS2/kVMQHXBXNHZk3NGsz9mNgPST4sN8W8AukcdCt79V2U3glfdZ3Kzrv31WDyaZOzeUPuVYumSsfdnNDQGS6mXazh24JyZN529FF0yawnq8VzPSiHrh3a0MaMJBzC9dWUEoeFIXM4XNF8sQWqpeaPSt3uUi7mVngQdkfUokb3ZHlQVkIW0i9iAoNNA/CwLQQUg6lW+o6GQxH6Yz5eeJ32sI8NLNOra7lI2Ffd97zUIuAmuTXh+TrOt5p+bVY8sqJo0h3jXVa8vRqY16A82r5yJyW2q9WHjExgnN+gxa1Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c50514e8-e394-445f-2078-08def9e5bf7e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7153.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 09:23:49.5009 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSjzuyKRXc7RgLa24CvyJ6w+uKbejTHP6FI82eDfVmVmV0NP4BXtCiQewigwL0+IjT81knfb5GPJtvsRXaCnAz5QaEm01kpi6++6t7bIbDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV6PR02MB12124
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA3MSBTYWx0ZWRfX9stgBkAMoyC3
 sGrGJw05qj13njnc/ypQuvzs1YWNN4Yhgh7SdUCG/MHsAYESjl4SpU8SPvv0EXnX9H5KinyeN+q
 bBz8CX4zACNy6WtODUK8xxLfsk4Mzmk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA3MSBTYWx0ZWRfX5I0hajkRGwbq
 hXZvokhldx1gskI0qpxQs5gHwdjSnoNDnqBcnFegzQ0zlzZ7zB4MFwv0DC3bF2jALFf/uD+7cPl
 diJHQftF85EB//4JXXTn6odjd5IqkE4kZUjp3jVh29yMqsCRoW06acDoe8Egbh82kFgCra55LaC
 lj0f2Ly+W18G/DIdf/Kgyv4Sm1bljQGyjp1V3MJh14D5FoyZzsXJdmE36Znjbh5xydhSUhYsUxI
 qWf8qJ5dG7+Z9OO/33NbHWRTT5r33dXnwBb+0gSbR89Ywerx+Wxa7NyV0FhaF/eLCZ4C8Wi63DR
 oSMhT7Bs4AKnT4K7sALvdg5DR6P9qisEjte+4jk0PvbF0Cszr4fvx3eNA/p7TOFIySOUEQYLuAG
 HVMmKK93IGRPz2D1DxcaoQrt1n6eCs5ppKeKLd5WMqLcUt/DHokj6Lo0L7yTgaA47AK3KwF2rai
 Ap7m0sEG3ChTfS6A5fQ==
X-Proofpoint-GUID: UTS1aQBZccfrCBhZHLydi2X6mDpFgVw2
X-Authority-Analysis: v=2.4 cv=DJK/JSNb c=1 sm=1 tr=0 ts=6a7edea7 cx=c_pps
 a=N0p9dsNkTmNcAxi3Eyz8Mw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=YJTMvdlHesO36RGpVNwA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: UTS1aQBZccfrCBhZHLydi2X6mDpFgVw2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.759,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 13/08/2026 17:58, Peter Maydell wrote:

> (3) create a brand new separate GPG key with your work address,
> sign your new work key with your personal GPG key, upload the signed
> key to the keyservers, and tell us that we should update; then send a
> pullreq signed by your work key from your work address.
Thanks Peter - I've gone for option 3 and created a new key 
(F5826DF0B37512501DDF7AF72CA236E24629B1F4) signed by my personal key.

I'll attempt to send a PR using the new key and see what happens :)


ATB,

Mark.


