Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DA3C44502
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 14:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfebS-0004SX-FT; Fri, 03 Jul 2026 10:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfebQ-0004Rm-Lz; Fri, 03 Jul 2026 10:10:48 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfebO-0002du-HX; Fri, 03 Jul 2026 10:10:48 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6636sFtL2069494; Fri, 3 Jul 2026 07:10:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=pDCGHeyNc4UNkJ1/2bM6/ZAyr1INWb/pNlWQQhIFa
 nQ=; b=bsCa9fOQa1qd2eLzHAQ6fL7XtHx6nFwfwdNB/KwG6rsCPMJWfMfdJyCm/
 PNDfedX7c/J4krDbxlXQ9ioIkgpkmW/q9+xGod2m1p+KvyQzguPiv9QF/3cZ0XKS
 kLp6pgPkLsOBqTSfvMMRMu6rfHJF4yXdzM6V82qGZoEIDqyqmmwGJzYU4JZmEaMO
 ZJWKW6jBJUXz5ARUhCZvGXUnYBhVMmge+xjCNKrP8zx5luCSp8p+d/241fy+4slu
 MTplZHHzFGr3bzTI/Aus1C8T6LKRTKoWOtfapTmYxlkEK+lMZvBjQDsCvSHGRT41
 Na0I7j0c1ULIuSamUxDQJYp1SAqeQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021114.outbound.protection.outlook.com [52.101.52.114])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4f687k0ufp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 07:10:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JeMw96BsXqfQrHbj7Gjb4GBJlA1lqKcDKLziH7Pc7jZiR0ci2Xd5EZySeFAkkKmdTtITho6Yk9aEp+FK/06JDxHdLeN03o5SmX65x9BCPfRPgoWy3RJRBjlmMIUhXIv7qUJYi/qme+cQEFevHmKw92I5Rq8Jy0obaiP5//wvJ8CLm9U+LqnRUMwFlr5GjsiWHRvsUf3pzOsufw9OAAdqTGzJ63YGJoCFYmQtZAXPJRDQVHOwfQ6ZJrTjdcv2jzzxOxJF4A3t7T4AM7bjJzn96oDzJuFMiCvIyQhUQtdRUBRCd9x2YjVt6GKnotWyHPjR+x4TMR6U5XjnwYMAPglR6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDCGHeyNc4UNkJ1/2bM6/ZAyr1INWb/pNlWQQhIFanQ=;
 b=bQCFHyhy1Q3UrajPzLT30+cqUyYqvozL6IJVgFHyCCZDrdQxKLGQMF0iNCm8oCwsVGuCHk2D5Jy+gjPvaRX6quj+mU5GnKgiPpu1meoQF07H284Hcvu5dJis+OseertKCrrkjG/skjli0CkmIjbeP1frUv5RZxIoiXJsWwC9OrHeFQMhyecPV56uO3UxLoNIUBCePnEONVwEkMbJ2O0Z3CiI0oXfzz/1IRXu3SD0JgBns0VVQPaKHMWHaLVKsFdqBa20xaZ4eAdekBtlknq0x5WS1rSWfsuZL21NH9pX+zk50gbAKQuO7IUcFUdcX6VczTpMzgv0RAd5RwnEl1zYcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDCGHeyNc4UNkJ1/2bM6/ZAyr1INWb/pNlWQQhIFanQ=;
 b=qAYjE5KrLn41tAA73wNv7U4TBK78vB4mzjA13AcwllPozqQAexr510lXj1e3KFQhmTDhrgwr6TGM0kqh5mkO6DrwNtl0k9GWhiSgL7XNd3QL9qW6x0+saXJPhu0DRV7Onc9riBUioQ3kCh4RZNYWGma0usvqvhBMR6rNWvHt/Bz8Xdu0+exfAMQkrigGDjEDcJMEdmU9C/A7dIqNjej1yIYJ3fIDx7OIKJbhroDRQbhmghqAz+Vt2ppo3qyaSLeAD9sgIW60p2h+T8CCHz53S1/UeffIJ7Cxka9N00ybsLozRKH7FBNPsNcU+aYrbwmzUgMpeDkZen6v2C0Np65hTA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL0PR02MB6483.namprd02.prod.outlook.com (2603:10b6:208:1cb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 14:10:34 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 14:10:33 +0000
Message-ID: <faaad8c7-e879-474f-8b32-a17d3af060cf@nutanix.com>
Date: Fri, 3 Jul 2026 15:10:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] hw/adc/npcm7xx_adc.c: convert NPCM7XX_ADC object
 props to class props
To: Peter Maydell <peter.maydell@linaro.org>
Cc: kfting@nuvoton.com, wuhaotsh@google.com, alistair@alistair23.me,
 berrange@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20260625111201.1645847-1-mark.caveayland@nutanix.com>
 <20260625111201.1645847-2-mark.caveayland@nutanix.com>
 <CAFEAcA8or7xgrNvP2G_in3Y7TF_N4s4mxHoU+mPkS5-OsZLMug@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAFEAcA8or7xgrNvP2G_in3Y7TF_N4s4mxHoU+mPkS5-OsZLMug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0083.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL0PR02MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b54cc4c-ebfd-4497-35a7-08ded90cd91b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|6133799003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: +J0aTa05ubCHydJRnREqClk7ZLHR+Oo5qqS82JO/yhX1JNrO+pit3wzq6FvgPQA/qOsZNzjfel+GGhZWNCT1IlpFGnIBylWiuzSv9Uh4zHJkzQAq8yRx/ou7Is2BMOj8CM4tuY75blQU4a09OdfRvw/XoOG8ssrwj/L2JSsv9cWBQJCV4F9GLp83qquBVV19BSXm5CaRJrCnXV2WGxdh3iuicegt6Fj63YmdYwLL7EWs53qusnGE+k+npoY08dI/2fh8SnZpzGVcjpcYEt9JIQj7+aFo8CdaQnrZnVmjMfyXQLL6uHASDi6FXn5OYwXn4B04RcENXzxaObEEyDobLF+F3/VpNOcQ2nI5bOe13vZx8Anv6nKComnyQ8ievMPw3SS/JkVgLxBeZy4346qTIGZXtbqcoYfmH3rxyZn1R+432czTOuJn7gS18gfSlesD1XNc5i5l1bhJSpCU2FnKVDkuymWnW6ZTCdXq/nrvzHT6xiJnYRG8zIY/Fy4jcZpg/phY6tE8AtjDn0u9c/7ivj06QQ9MJmZQs9kUzuHcIeY1UkCCjlqrwFzO6Igxe6bYvLanX7bMB6XCE1E9k0FNkavJ/FCNw5LY4k8je0Ue5NY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(56012099006)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkZGREwyM3dFK3JuMGs1dGgvRFFNZjFOVEtNUXJoN0Zrbm96cWNxTEF6NHVW?=
 =?utf-8?B?b2lsOWN5UUlhWVFkUkc2VzdhdjJzZGtBbSs0aXhBenI1SXV4K2o1Ums1T1Fu?=
 =?utf-8?B?Zm1reEdWQlNucloydnJXa3FuMFZ4WjNsTkNxTWVyU0ozd0kydEZZUTkzR1g0?=
 =?utf-8?B?UTlxR1pLekMvcmFGUkh2R1JRb3c5aHhuTEd3RG9GVDdaaUd1Mm80NDBLMkVK?=
 =?utf-8?B?Nm1jS2hyalRYMXcxZDVYQ0dtWEJKZlV6Yi9XYzZ0QzJlanUvbXptcXJWOUlN?=
 =?utf-8?B?eDhCRnQySENyQUtuZWZwZWZwRWpTMFJhK204ekR3cHV3WVZmdXZzV1NaZ0F3?=
 =?utf-8?B?N0tGeSttbnNzMmZORWl3ajdSTmRXSG1RemF6ZjJaZ09uNDRrSFlGRkZkV3lv?=
 =?utf-8?B?TUhCL0pnREx3K2YzSFc1dk5scXhwLzMvSFJHbnRJSXQrMGhLVW1EbkR1RjVq?=
 =?utf-8?B?VzFJOGtwcm8xbHVmRGxFV3hialdQVzRiK0VjR1VDMHNCRWZaaVIwYm1naTdK?=
 =?utf-8?B?SGYySWF5TDhwRHNFK2h6Mk1hNm90amtaUFo4d0FCMVhMM29FWnFSRkJqL080?=
 =?utf-8?B?YWpNdUgxV04rbktRWDV4bHZlV0NhUU12bWZmWVhpb2VheVJRaERtUmtPdWJB?=
 =?utf-8?B?M2ptbGMxaEovM2tNc0JuWXgraDdYT2l6TFAxY2t5cm0wMWpNakJlYWlMMUh5?=
 =?utf-8?B?OFZEU3U5Sk9uUnlXeGhhekpnNUkzUlY0djZESDVLVWZqZEFXVmpPT2hpVWd4?=
 =?utf-8?B?N2srdGg3MFRmVjRoZFdDbDRwOU5sOUdod0czVG5rK2pVVTExMjVFZUovUmtw?=
 =?utf-8?B?S0Y5TmNZUUpqRkZVUFVsdEtVNEE3WWVoWlFwRlVONnZOUWNsQ2RKRjJoa2JH?=
 =?utf-8?B?eHRpdjFoUXBSYUNWR3FRT05VcGY3WWJuMWVuaXUwV3Fzck9GdTBSdW00RGtQ?=
 =?utf-8?B?eHpWbE85cW1Jam5NV0UvZ29ZQS80S3R0MlpITzZ3dTBtdUNqRzg5d2o1a1ZE?=
 =?utf-8?B?cXVwMytRamQ4V094bm1jTEhVczF5ZkZMWEQvUSthNHh5RGI0a3pGckhEblhR?=
 =?utf-8?B?cS80YTF5Q09kWHp4b1NtSjA3ZEEvU1RlbzFNMW91dGdoQlVNMDdZbzNsVXpB?=
 =?utf-8?B?R01VSGRZUWNoVDN6bmFTd2pBVmlHbUphS1BraXkwYzhyRnd2ZFhjSW41Z3NP?=
 =?utf-8?B?V0xPQ1hhUk1iY29sR3R1K2dzanJYeFFwMDdkMUNNTGQzZCs3MjljYjhOM2Rq?=
 =?utf-8?B?Y1BXMHdhdWRKcnkyYTVRUzk2WkVTNVVETk9vaWtrcksvUnJmTllUYytpZXRu?=
 =?utf-8?B?S215SmFGZitMNzFTZHRXWGhlYTBIc2VWMmozaE5PNkNIZ3dZSjYzOUYxLzlK?=
 =?utf-8?B?aitUd1VRQmFLaUloRFdZbU9yeFlBUG5iK3NFN0FXUlBxOVAxVW9ldzBSenpF?=
 =?utf-8?B?czdIM3JvTzlNVEprNk1JejF6OFIxdkZCWFRhaEpFcTVZdEJNbGdyWitHcHRX?=
 =?utf-8?B?NnJwSHZOWElJN241UHM0TlhoalhRYXcyZmZHQUlGZ1NQZ2svSldIaU5PQzdL?=
 =?utf-8?B?R2x5V3pkWGZkZGlROVVKUFY4TGt1cm5XcUxYdTBPdlNGYkdyb1J6Y2I5NExD?=
 =?utf-8?B?YWtpa2JFTE5PRW1Ea3g5MWZMbkZiS3J5VnJHVGE2SkNCNFNyUmZGSXB4Rkd4?=
 =?utf-8?B?a2pmZmNsdlFXSXhrQ25NcXZ4WTlYUStRODVNd0k2c3I3aDEyMzJoWWkyNHJv?=
 =?utf-8?B?SThEWFBWemZGN1FoQTdlVCtDY0pDV0R5NHBiZFk4dEZPek91RXl3ai9xOGFw?=
 =?utf-8?B?K1VGODNCcll5SVdDQ0NMZFZERCtzd3NzVFZmSjlUcjZBejNlemR2VTFEOFRS?=
 =?utf-8?B?c0tuNUFRZDJLYlJJNDhGSENyenE0UnppbFVUWXNHenE1V3I1azBBTjBOaDdK?=
 =?utf-8?B?ZHRhTE9rdGRVcXlzakRWVzFXZzVjam9RSS9uTDFSTlJ0RWpVcEVTN1c4S3Fl?=
 =?utf-8?B?Z2x0Tllzd1c2SGhNQmluL1A2dEhRWEl1VlJVQ1BNQ2NGbXh0RHp1cWdpNkJT?=
 =?utf-8?B?Z21abFFDVWlYd1FnQUk4UzBXSGZvRDN2NUVaZm5DbUFMYXlJVCtwSklMeTlF?=
 =?utf-8?B?VngzeEVQV2cwTGI2UVdhS205ay8zYlVwY3VQVmVzZVgrb3lISGtINGpVS01Z?=
 =?utf-8?B?LzNNMk5hTjhtUjdvOXJCOGluZlV6eVNRYU5qRWc5RHhFbXBWLy9Xa0pFOXU3?=
 =?utf-8?B?NTJLYzE2MTRVN2dVWjJkRjlTVnVWVWZWL20wcldKREx3dEIzRU5wQy8wL01N?=
 =?utf-8?B?ek84SnJCdUU3cm5YVWVxTVJEUzR4UnQ2RmM4d3JtdXUrYlB2M1RFUkxoakIx?=
 =?utf-8?Q?z8U9GOPZ0b/uAzbQ=3D?=
X-Exchange-RoutingPolicyChecked: K/KzAe0hZHMSzSW//6HRfJ6ulpLkYA8GiicScDWe9AdsKI7gSKZ5xo1VmvTW2jqSQImmGSRZpzxDaPWXtBKieAKcFBUBPZy70Qr8O5GDtoJttM5YJWPXeww+dUZdfRpEImaUpSXb2cvYeLoGN3b2sudYxRrgyadBPftunDWZTyymlvp+Bgo/avRLQjORJyKLQJBWfIAQHeioAVp0MbTU4FBK0FWNJSTkeKhYTdApZdupaD1dBipsDcbp1d+mJIkNdYsDmTCcrykLzwQho+C71bsN3abHlH0J8KkqHCq7xtYTx+tH+V9x9Zl9/0GS7Y1bdGXizFHkJ0Vt74LUo8fQDA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b54cc4c-ebfd-4497-35a7-08ded90cd91b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 14:10:33.9113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QNF97p/I7qn+QxArjPsn8RHtrJbRisGUMKX2DL6X6FXLvTHhfSTDtE4O1cGsMqGwDbIkux2skodCMGNFcKQVHgKV4xiWhEfqv9zAIh+AHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6483
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzOCBTYWx0ZWRfX41BodrYJmJCh
 aRuKMc+syc3TS5+ry8JDeY6GDb3Bkj6cGAgFKg4rP5UUf0D1Ogen7ue55LUSSePwmcIfK38S7/K
 vkCL6321yZ/HMkQ59uYcUTW0NMazUxJr3YKNBc8523s/wB8uX5xBX2v9zuJmfXm2r6/b+WTqRyf
 mZ/ccpyFvndh/LFiYnCbrqUBg2wuZKBBxK12RJmKLSZvjiBW08pz1m4KOVYcpe+bp26MNUo5rTj
 iJY8labUdJ3zZSEHHf9/+mNP9Y/S6A6DxgKrxAoj0sJKAjh3f5FF+1tM1mMahgjrOtBAIqGBfNT
 6qW3ZthQ3SWusrw1lsrbw9yq1k+ttynIx8OOO5eAeAJ1vlQX2c3oUSUgoxL7k8JOJMwai0b8rjm
 jn07QKATjQc+uTvfWvkDIB4N8uIViwj3jTGpkjemct7HL7uC+Eve8iweGJTKXNePyTa7d4FsC+m
 rwOw9b6tRTWZIcxPl3w==
X-Authority-Analysis: v=2.4 cv=EZz4hvmC c=1 sm=1 tr=0 ts=6a47c2dc cx=c_pps
 a=iJ0/73tnBOJCmN8OdmQeBQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=GaQpPoNlAAAA:8 a=64Cc0HZtAAAA:8 a=hd8VEaDZGaa4IoOSaKAA:9 a=QEXdDO2ut3YA:10
 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzOCBTYWx0ZWRfX31gpBufZxRoo
 mp+n5LX7w6ImrvJAhi4vRWXz2aWvHAkaOoBayTWPYHIaO/lvs5q2+MZf5+iSevpuh9E3540Z4IM
 3Yn/ZhSOPgt3U/3lNpLCUOH74kI0cNY=
X-Proofpoint-ORIG-GUID: 8HcOWkCEtkYrEqf26HjjyzwE1pY8SjDH
X-Proofpoint-GUID: 8HcOWkCEtkYrEqf26HjjyzwE1pY8SjDH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On 30/06/2026 09:26, Peter Maydell wrote:

> On Thu, 25 Jun 2026 at 12:12, Mark Cave-Ayland
> <mark.caveayland@nutanix.com> wrote:
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> ---
>>   hw/adc/npcm7xx_adc.c | 77 ++++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 70 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/adc/npcm7xx_adc.c b/hw/adc/npcm7xx_adc.c
>> index 3584c27c75..833e01a913 100644
>> --- a/hw/adc/npcm7xx_adc.c
>> +++ b/hw/adc/npcm7xx_adc.c
>> @@ -20,6 +20,8 @@
>>   #include "hw/core/qdev-properties.h"
>>   #include "hw/core/registerfields.h"
>>   #include "migration/vmstate.h"
>> +#include "qapi/error.h"
>> +#include "qapi/visitor.h"
>>   #include "qemu/log.h"
>>   #include "qemu/module.h"
>>   #include "qemu/timer.h"
>> @@ -229,7 +231,6 @@ static void npcm7xx_adc_init(Object *obj)
>>   {
>>       NPCM7xxADCState *s = NPCM7XX_ADC(obj);
>>       SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>> -    int i;
>>
>>       sysbus_init_irq(sbd, &s->irq);
>>
>> @@ -240,15 +241,63 @@ static void npcm7xx_adc_init(Object *obj)
>>       sysbus_init_mmio(sbd, &s->iomem);
>>       s->clock = qdev_init_clock_in(DEVICE(s), "clock", NULL, NULL, 0);
>>
>> -    for (i = 0; i < NPCM7XX_ADC_NUM_INPUTS; ++i) {
>> -        object_property_add_uint32_ptr(obj, "adci[*]",
>> -                &s->adci[i], OBJ_PROP_FLAG_READWRITE);
>> -    }
> 
> In the old style we get to use "adci[*]", which avoids the
> boilerplate of creating and managing the string for the
> name with the substituted-in integer value:
> 
>          g_autofree char *adciprop = g_strdup_printf("adci[%u]", i);
> 
> Is there a way of keeping that with the new setup?

I did include this functionality in v1 (see 
patchew.org/QEMU/20260624153322.1470576-1-mark.caveayland@nutanix.com/20260624153322.1470576-2-mark.caveayland@nutanix.com/) 
however Daniel suggested that we should discourage its use and so I 
removed it for v2.

Are there any known places where we are adding properties where we don't 
have any loop variable available?

>> -    object_property_add_uint32_ptr(obj, "vref",
>> -            &s->vref, OBJ_PROP_FLAG_WRITE);
>>       npcm7xx_adc_calibrate(s);
>>   }
>>
>> +static void npcm7xx_adc_get_input(Object *obj, Visitor *v,
>> +                                  const char *name, void *opaque,
>> +                                  Error **errp)
>> +{
>> +    NPCM7xxADCState *s = NPCM7XX_ADC(obj);
>> +    uint32_t idx, val;
>> +    int res;
>> +
>> +    res = sscanf(name, "adci[%u]", &idx);
>> +    if (res == EOF || res != 1) {
>> +        error_setg(errp, "unable to parse index from %s", name);
>> +        return;
>> +    }
>> +
>> +    val = s->adci[idx];
>> +    visit_type_uint32(v, name, &val, errp);
>> +}
>> +
>> +static void npcm7xx_adc_set_input(Object *obj, Visitor *v,
>> +                                  const char *name, void *opaque,
>> +                                  Error **errp)
>> +{
>> +    NPCM7xxADCState *s = NPCM7XX_ADC(obj);
>> +    uint32_t idx, val;
>> +    int res;
>> +
>> +    res = sscanf(name, "adci[%u]", &idx);
>> +    if (res == EOF || res != 1) {
>> +        error_setg(errp, "unable to parse index from %s", name);
>> +        return;
>> +    }
>> +
>> +    val = s->adci[idx];
>> +    if (!visit_type_uint32(v, name, &val, errp)) {
>> +        return;
>> +    }
>> +
>> +    s->adci[idx] = val;
>> +}
>> +
>> +static void npcm7xx_adc_set_vref(Object *obj, Visitor *v,
>> +                                 const char *name, void *opaque,
>> +                                 Error **errp)
>> +{
>> +    NPCM7xxADCState *s = NPCM7XX_ADC(obj);
>> +    uint32_t vref = s->vref;
>> +
>> +    if (!visit_type_uint32(v, name, &vref, errp)) {
>> +        return;
>> +    }
>> +
>> +    s->vref = vref;
>> +}
> 
> In the old code, we say "I want a uint32 property", and we get
> one. In the new code we have to have a lot of code here that's
> manually calling sscanf and doing visitor pattern stuff.
> Is there a way to say "give me a uint32 property" and have
> the implementation be done in common for the new style ?
> 
>>   1 file changed, 70 insertions(+), 7 deletions(-)
> 
> This diffstat makes me want to say we haven't got the
> APIs for doing this right yet.

Thanks for your feedback. Thinking about this more I've decided that 
what we really need is direct object_class_property_add_*_ptr() 
equivalents to the existing object_property_add_*_ptr() functions to 
help developers easily convert object props to class props.

I've just posted the initial series at 
https://patchew.org/QEMU/20260703135512.3213964-1-mark.caveayland@nutanix.com/ 
so I'll re-send this patch with a "Based-on" tag for this series to show 
the difference in the conversion.


ATB,

Mark.


