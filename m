Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC1AC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 10:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq861-0003UC-7W; Thu, 06 Mar 2025 05:04:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1tq85v-0003Tn-QP
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 05:04:48 -0500
Received: from mail-northeuropeazon11021093.outbound.protection.outlook.com
 ([52.101.65.93] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1tq85q-0005XY-RW
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 05:04:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBa8oNYmJ/zGhGJRFIdT16eiitxOj2Ux+NZIxOfUBfpRY+Inz2SEtxICuEx48P2MTSaVZBO6NR76aLhR0+b5jwZX6FMv5pbCTdxulYWseEfCFMRJdy+0WbM9IKZgk6T6H8hHL/CeTnfy7xZG0oRsYHtyD2BAgL+wWgV9TAy2tGHRUCk0cPmwRfqUGSWSjrTX4XfH3eJLSxDfIZrUjV0lfXbO1fxJJFUJ4vh6mqjYqheacemji3lB8T9+iDg7nw0JVyf5GOA8X6DjY2gemQlzi5DiZnk2i12Ulg/jlBcFmh2oehVi4MSlao4Pys12Za2o+ysqQ2wCpitjGaqh0HvRjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOTnRLoA3fAfWeuqbgauMQB6UcQAuFNMw1FKaeL2AwM=;
 b=GdY+Vgq+xEXimGugDclbOHOmyvtaPhjIVjMc1UZU8GDFojKkHDXZlHfQwG/T5V8ndoV/DDN42AKWLM9M2W96vmQS3iIO+cL/QmXI4ke+kqe5InpQVEw7EmT3XonPfUzRp3NtVT7Ln5E/a9gJ/XGoxiaZUMF2Fhn/nWAjg9TbhPb9mY0uDhUGrmjj3rLgrsq3r8S++JxFgMqQ0S2i6/F9aL0jklfdJIViCHMO3UW0RCoccsf15LaQvJDXdFOaIjkGyAaUJKDoi0YT/sIesAXbMJ5fCRt/aSWNUKeqHgfT1eNZMYQ+BVBU9im8Q40YKiiFHYiwooKnN4MI1utkoNlw+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOTnRLoA3fAfWeuqbgauMQB6UcQAuFNMw1FKaeL2AwM=;
 b=bu+LjMA/fh2gsLFZSLuaTGKWZ3vQofyHrW/d6uRZXuN1nA9Ecy7jCtd9fgSmoMpm0bjbqUjDSekVQ3zGUChTn2HhUfwpxWFcGcCw+mToF4A1wuZYpmhWASWA2p9PNScsHY1co6R2tEfx42VcHe4CfgesieRatBypQuDhoJ6pmqvNoBvknKc6/CH2kL1WCRZOkE26QbFXJELDcSEUmKjVP/H2uxkvZkH8AEzvddSMOC5vUVyIeKPqOZUz5xYGxbWsjLXKrve2BilmM8TAzaSs3F9+BvPYidhB4fSWMcZSbJTxyzliRh1utcVlyFrH0XRXbGiAXu1ZxqIGgOqyJ6G8iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AM0PR08MB5506.eurprd08.prod.outlook.com (2603:10a6:208:17e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 09:59:34 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1%7]) with mapi id 15.20.8489.025; Thu, 6 Mar 2025
 09:59:33 +0000
Message-ID: <ab3e61fc-a79f-4c6e-b8e9-d7b501c84644@virtuozzo.com>
Date: Thu, 6 Mar 2025 10:59:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG, RFC] cpr-transfer: qxl guest driver crashes after migration
To: Steven Sistare <steven.sistare@oracle.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: William Roche <william.roche@oracle.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <78309320-f19e-4a06-acfa-bc66cbc81bd7@virtuozzo.com>
 <6fd87c40-92dd-4290-9fa9-abd014ddf248@oracle.com>
 <8c79212c-4b0b-426b-8563-3e7d478ef24f@oracle.com>
 <4a74201e-7394-40a5-910e-36c4255ed9fc@virtuozzo.com>
 <d03329c3-a55a-4818-8d41-7efb2e6af1c7@virtuozzo.com>
 <d5a37291-e183-42b5-9b9f-7ed736f0c367@oracle.com>
 <063ee0ac-0568-4413-835b-e620f8d70761@virtuozzo.com>
 <76d393fa-4c40-4331-aa5e-381f34c60c3a@oracle.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <76d393fa-4c40-4331-aa5e-381f34c60c3a@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0087.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::28) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AM0PR08MB5506:EE_
X-MS-Office365-Filtering-Correlation-Id: 43474321-6f5a-499c-f1e6-08dd5c959816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzNROWp4NndKUmxhRkZyZnBxTzY2dmZqeitUcWsxYXVoSGtPWEl5Mk14Vllt?=
 =?utf-8?B?VnlydlpBMFhTcXh1aXRUTSsvMGFhUTBiNXh1dDJmNUd2OHYwWDZJclJDa0JI?=
 =?utf-8?B?Mk1pNE1pNFpLTnB0clJBZnZPRWxEUUhqSzBIcUpGdDNFSHdIRW1kSU9QQ3JG?=
 =?utf-8?B?ektRVDlPelZrS2ZlZVVMN0xnT25mTmErRjA2Mm5LRFhQTk5teSt4K0FqeG1I?=
 =?utf-8?B?TUp5aitTVnhoY3ZLTFY1aHI2enVvWGpCTU1JVENvMFhpOXR5dXZsaXR3WWh3?=
 =?utf-8?B?blhjS25yUTFBYUY1cWlEUys3ZlpUUzRBTTQzMnltcGFxaE9OcDgxNmxUc0Ix?=
 =?utf-8?B?OXF3akFXdHVwZzRLdzBNaFRBbnVIbXRqdnAxL1lCY3FLNEZOdzIvWk5PZEhj?=
 =?utf-8?B?RjFxbmZ2MjMrU1llbW85cjBCbWs5VUJHTHhlbGZKN21KSkw0U0VKTTd5NjF1?=
 =?utf-8?B?REFGZUV6c3lqVjkwNU5tbzk4Q2JqWElXTW1oMWpLcHZ3R05OVHQvTkQ5Nk0w?=
 =?utf-8?B?UkZFd25qcWdJbWxNemNSYnJVbHNZQURHaXlZaEFzTDhNMXVQbFlkaHFPM1l2?=
 =?utf-8?B?SjhqQnlwZmN1SklYTEc2bE03UDJTekdOL2FPZWxxTDFjNzE0QzVrNVV0Z2tx?=
 =?utf-8?B?bzZSblQwZFprQzBrWGFMVVI3NU8wWkVIV05lNndjcCtaZDBlamp0NEhZRVp5?=
 =?utf-8?B?MjByTURCRnNzbnc3emNvb09DVWNDTDFOaVo0T3E5T2UvbURCL2VWNDVQVnA1?=
 =?utf-8?B?VFVwSjI3SU0zampMbDZvUTRJL2doRzFZV3NJTkhpcUdsMVR4YnJ2dXZ6czR1?=
 =?utf-8?B?Q2ZYTStJYVpReWRQaG5WK0VZWDdXb09VUk5JY0NUU3FTSWZCRC95VlJZeWY3?=
 =?utf-8?B?cmpGRzVKZ2UvUDEwNmhyeDZqZGpSV1BLU0lZZEFBZmFxU2swRWRnL0VpeGJu?=
 =?utf-8?B?SzlMMXUrTWIwdkt4bDlCQlhiMjd5OWJFbndyNUM2QzdGY1d2azh5NTFVWldH?=
 =?utf-8?B?RmpXRUpJMUtxbHB5Z1F0ZE8yU0dRWEdnUnlGOUhISkVjdmF6WlNvRXFub1dL?=
 =?utf-8?B?RDk0OW5iTHM5eWwwUW9oemo1d0RZZmwvdUdKSjU2QWRNZlBudXRjRnBabEx6?=
 =?utf-8?B?U2NqYklvVit1WTVneGxKREQ1OU9MNUlTbnVCWkJaOTZmWVltQzkva0o3N2hE?=
 =?utf-8?B?Nnk4Yi9EdWtTTWhHdDZhU1RkY01xWmVtM21VTnBXK1hwTWp6czhlWHl4L1p5?=
 =?utf-8?B?aVAyK1FqM2ZwbUd0Qk5TSHVCOEVmN05WTTN2S3V1ZjlJNHN4MnF5N3hCTnpC?=
 =?utf-8?B?cTVUTVdtUFdnRXZldzVPbjZPMkdQVGwwS2hXZXhuVC9TOWJYUFlNeTFwTlgy?=
 =?utf-8?B?OWZpb05YcGJBVGU0VHF3WGM5Rmk4TlhneDd0WnBsbWhrZHVTdjVhQ2lCaGxF?=
 =?utf-8?B?ZC9rTkVlWG1uZ1ZFTGRQcVVDTGdFTTQ2dVlPNkR4VncrS0YwV0hKemM0WjRC?=
 =?utf-8?B?b3poMitKS1lodHFxaTdQU3gyRDJ5d3FCaWZJb0dxTE5LbEZQM0hBU0pKdUdO?=
 =?utf-8?B?TzNuaThuQ3BxTWEvR0Z4RzNsZlBQNmFKRDdRSGhFdnlQUUFtaUd1MEtPK3Zv?=
 =?utf-8?B?Z2c2aElIelhlS3duakNSVE56cE9ZdWtRVHFGZ1gyRFQ1bXRZSStIclZ4OVht?=
 =?utf-8?B?V294YzM0ZzdiT25DYTkvVTRqQ2d0OUJSakhZZmE3ZFhoM3RNeHJYZEYrekxF?=
 =?utf-8?B?T2xHRlFtMVlXMmdVMmZLK3FZZmxrdkwyVlVDVzlPRVlZODFMaklkL0QzY0VN?=
 =?utf-8?B?Z0RSYk1OM3hsVzR5YmIzUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1BPUkovM1FMeGh3VC9aNy9RY0dndjU4NDd5RGJ2RGZLREdQSzNjemhBQytQ?=
 =?utf-8?B?NXhjR1RFdTd1akU5RnIzWk93K0VETzRwcDdZTDZjcXAxNDlFcUFDbzArUGtB?=
 =?utf-8?B?TUVUWnZ6aUNJRjBDK2VIOUZkOUFrMzFUOThWRExDalowd1oySCtNQ0I1Ynp5?=
 =?utf-8?B?TlFYdkVjMXRXeG9qUEwxVTV1L3JkNEVVSFM0OEVENFhHdWJPT1dkRmhtVlVm?=
 =?utf-8?B?YkJobStIUG5wSzAzNFBqRVNrQjdVaVVLMEZsVTBKTFBmWmxETU8yWXpULzBW?=
 =?utf-8?B?YWNYZG1EeTN6TlZsd1FSSm1yRTMzdm02TjZlT3VYNCtncGxUVEFOQVEwd0pJ?=
 =?utf-8?B?V003VkNLTWloS2Z5MXN2ckE3a24yd3QwSHVuQzJ2OXBsZEtPWUdGYXp1OGhK?=
 =?utf-8?B?c1lVanh5TFh5Q0dKZ0ltdjQzZXkxWEhaeWRhZnM5Y3pRU0dVSm1WN3dKbndH?=
 =?utf-8?B?UnZUcDl1YTBMUFRwdTMybDNLN3ZFbG83UStTOFZWQmxBVEFJOUVXNDZHYndL?=
 =?utf-8?B?UXJBZmRUZ2hIMFZPQVpsMHljNmQ0Mm4wTXIzSkduMzF0Q2JIWUROYWx6Z1pw?=
 =?utf-8?B?VkFCMmlzSCtyRlViUkRDQWxadXFab1ZqRjVRSDFlV3Zma2xWaW5wNlV2SERI?=
 =?utf-8?B?UUZHaTB1cHNPRUZFbVg1MjY5VWEySCttaytvR2diSEV6Q3MxUkxyYzVrNzBX?=
 =?utf-8?B?Z1JleVdXejVXTmpNOVhhTEJkbzN2OVM3RGk0c0c1bTZGaWxOOWUvV1laUS92?=
 =?utf-8?B?N0hrREk1UHQwWmV5T3F1dTM3SHRvcHU5VWxQakM1MTFBd1pxclJFUWZnbmIv?=
 =?utf-8?B?UnZtcy9wVWhRRlROLzVBa0RrQnZ2aWVkWFo4WTBhRURPcVVsT2lJT3N1MS9I?=
 =?utf-8?B?eGVsUzFNVnpsU0M3MGpCbm1hQXFsWFRYdndyY0Q2M2NRQTlUQmVhOVNoeVkv?=
 =?utf-8?B?Z1cvbllDZ2tBTldGMkZBa05GTGJ0WG5EVnVZMWpiS2dyYjFvb204czFXREhQ?=
 =?utf-8?B?ckl3VnRJYXNqalU0QkF5L1FzTlRZYWdMQjdHbU1hOVlaNHQ5aG9qL2p1Nlg0?=
 =?utf-8?B?OGRYSlQyT3p3WWNBZ2p2WmxsejFtOWZuMHZsZUY1ZkY4SUplandnWGlsb1By?=
 =?utf-8?B?UWxTYXQ0MEVPQWJjUWlvZ3lMbW5DYmFiSEhrOVh3NkJ1bFFyUk5GdEJZak9M?=
 =?utf-8?B?ckxoaEZoZjM3STRNZWZwbEVkQkNXeGdCUnU4cmp5VkxBR2NmcnpNQWwyVnlP?=
 =?utf-8?B?dHg0bk5ScjYxaXBERXZPM0FDcWRCM2hYOHdPZml6NnRGMHhGQVFWZktpSG82?=
 =?utf-8?B?bE9NYTBLRkNXUEZaRmliWnQ0dk1yOE5jbHRPZ1ZOYjgyQW9uMXluRFZ1MERu?=
 =?utf-8?B?dG5RL3FoT2dpb3pjNzd0MXpEdEVPMTdVWVV3MG1aODZLbWg4TXR4OURKakVU?=
 =?utf-8?B?dGRqcm5VLzkwcW9ja2VVZjdqRkkyZWtJQlpHdVVKaGt3K0JvZVZud3phblB2?=
 =?utf-8?B?b1Z6b0VDR0hvclF4cWgxa2xoM01HSXBBd2tiMjFUMC9sclh2amtBYUhxY244?=
 =?utf-8?B?K2IrQ1RSMTlBK2REOUdIaklpRkxzaUlYbUluK2VZbnAvbVRTQUNod1RERFNL?=
 =?utf-8?B?R1JwaHBvQzJsaWlQbHRGbjVhSU5WQ2NyOVZmK292eEZaZDJPL3duVS8veHpR?=
 =?utf-8?B?T0pZVnBWTlFnUTNzeElGbCtpVmU0MUgwRlRrd0tkZFNhUUlBWXl2TThJVElI?=
 =?utf-8?B?Uk5nb2xVZjJHTXpDNVUzSzNtbkhmZy85TzhsaWJ1cUgvYkhBbWFmaE44VnVY?=
 =?utf-8?B?Ymd5S2pqQ0RmWGoxMGt0SDJmdkxCL2d5MzhNY3pKSkdKNFc1RHdEeS9QRUFD?=
 =?utf-8?B?V3MrNWFHQ0dKZ1ZpMUZmUDRGMUhTVE0wMGsvNFdjRk4zS21XMHRwdUc5dmQ4?=
 =?utf-8?B?N2hueGxyUXdqMVo2dVlKUUhpeVRETjJDWkErZWNHbEZTMzRGMktGZC90RTZr?=
 =?utf-8?B?RFhzVVk0c1ovVXBYSEN1QXVWdlBIUDhTSGM0cmc2eHp6Njd1TWlNaVYwVEtP?=
 =?utf-8?B?NkxTTDlRT0x6aVhNamFMUkNKOUcrMHZtbmh4cEtEQm5sR01WWDhKRWtwakhF?=
 =?utf-8?Q?ER8eBp9J0s4MtKTt0fIYxf44I?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43474321-6f5a-499c-f1e6-08dd5c959816
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 09:59:32.9907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2aIL8Kldi59HoiM0+yLjtQ3ZVNrMtJdvxdMFv3utpbGnuhhqPY4qK8QSG0xVHRr+vmoeEvDqy25TKWHhCicTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5506
Received-SPF: pass client-ip=52.101.65.93; envelope-from=den@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 3/5/25 22:19, Steven Sistare wrote:
> On 3/5/2025 11:50 AM, Andrey Drobyshev wrote:
>> On 3/4/25 9:05 PM, Steven Sistare wrote:
>>> On 2/28/2025 1:37 PM, Andrey Drobyshev wrote:
>>>> On 2/28/25 8:35 PM, Andrey Drobyshev wrote:
>>>>> On 2/28/25 8:20 PM, Steven Sistare wrote:
>>>>>> On 2/28/2025 1:13 PM, Steven Sistare wrote:
>>>>>>> On 2/28/2025 12:39 PM, Andrey Drobyshev wrote:
>>>>>>>> Hi all,
>>>>>>>>
>>>>>>>> We've been experimenting with cpr-transfer migration mode recently
>>>>>>>> and
>>>>>>>> have discovered the following issue with the guest QXL driver:
>>>>>>>>
>>>>>>>> Run migration source:
>>>>>>>>> EMULATOR=/path/to/emulator
>>>>>>>>> ROOTFS=/path/to/image
>>>>>>>>> QMPSOCK=/var/run/alma8qmp-src.sock
>>>>>>>>>
>>>>>>>>> $EMULATOR -enable-kvm \
>>>>>>>>>        -machine q35 \
>>>>>>>>>        -cpu host -smp 2 -m 2G \
>>>>>>>>>        -object 
>>>>>>>>> memory-backend-file,id=ram0,size=2G,mem-path=/dev/shm/
>>>>>>>>> ram0,share=on\
>>>>>>>>>        -machine memory-backend=ram0 \
>>>>>>>>>        -machine aux-ram-share=on \
>>>>>>>>>        -drive file=$ROOTFS,media=disk,if=virtio \
>>>>>>>>>        -qmp unix:$QMPSOCK,server=on,wait=off \
>>>>>>>>>        -nographic \
>>>>>>>>>        -device qxl-vga
>>>>>>>>
>>>>>>>> Run migration target:
>>>>>>>>> EMULATOR=/path/to/emulator
>>>>>>>>> ROOTFS=/path/to/image
>>>>>>>>> QMPSOCK=/var/run/alma8qmp-dst.sock
>>>>>>>>> $EMULATOR -enable-kvm \
>>>>>>>>>        -machine q35 \
>>>>>>>>>        -cpu host -smp 2 -m 2G \
>>>>>>>>>        -object 
>>>>>>>>> memory-backend-file,id=ram0,size=2G,mem-path=/dev/shm/
>>>>>>>>> ram0,share=on\
>>>>>>>>>        -machine memory-backend=ram0 \
>>>>>>>>>        -machine aux-ram-share=on \
>>>>>>>>>        -drive file=$ROOTFS,media=disk,if=virtio \
>>>>>>>>>        -qmp unix:$QMPSOCK,server=on,wait=off \
>>>>>>>>>        -nographic \
>>>>>>>>>        -device qxl-vga \
>>>>>>>>>        -incoming tcp:0:44444 \
>>>>>>>>>        -incoming '{"channel-type": "cpr", "addr": { "transport":
>>>>>>>>> "socket", "type": "unix", "path": "/var/run/alma8cpr-dst.sock"}}'
>>>>>>>>
>>>>>>>>
>>>>>>>> Launch the migration:
>>>>>>>>> QMPSHELL=/root/src/qemu/master/scripts/qmp/qmp-shell
>>>>>>>>> QMPSOCK=/var/run/alma8qmp-src.sock
>>>>>>>>>
>>>>>>>>> $QMPSHELL -p $QMPSOCK <<EOF
>>>>>>>>>        migrate-set-parameters mode=cpr-transfer
>>>>>>>>>        migrate channels=[{"channel-type":"main","addr":
>>>>>>>>> {"transport":"socket","type":"inet","host":"0","port":"44444"}},
>>>>>>>>> {"channel-type":"cpr","addr":
>>>>>>>>> {"transport":"socket","type":"unix","path":"/var/run/alma8cpr-
>>>>>>>>> dst.sock"}}]
>>>>>>>>> EOF
>>>>>>>>
>>>>>>>> Then, after a while, QXL guest driver on target crashes spewing 
>>>>>>>> the
>>>>>>>> following messages:
>>>>>>>>> [   73.962002] [TTM] Buffer eviction failed
>>>>>>>>> [   73.962072] qxl 0000:00:02.0: object_init failed for (3149824,
>>>>>>>>> 0x00000001)
>>>>>>>>> [   73.962081] [drm:qxl_alloc_bo_reserved [qxl]] *ERROR* 
>>>>>>>>> failed to
>>>>>>>>> allocate VRAM BO
>>>>>>>>
>>>>>>>> That seems to be a known kernel QXL driver bug:
>>>>>>>>
>>>>>>>> https://lore.kernel.org/all/20220907094423.93581-1-
>>>>>>>> min_halo@163.com/T/
>>>>>>>> https://lore.kernel.org/lkml/ZTgydqRlK6WX_b29@eldamar.lan/
>>>>>>>>
>>>>>>>> (the latter discussion contains that reproduce script which 
>>>>>>>> speeds up
>>>>>>>> the crash in the guest):
>>>>>>>>> #!/bin/bash
>>>>>>>>>
>>>>>>>>> chvt 3
>>>>>>>>>
>>>>>>>>> for j in $(seq 80); do
>>>>>>>>>            echo "$(date) starting round $j"
>>>>>>>>>            if [ "$(journalctl --boot | grep "failed to 
>>>>>>>>> allocate VRAM
>>>>>>>>> BO")" != "" ]; then
>>>>>>>>>                    echo "bug was reproduced after $j tries"
>>>>>>>>>                    exit 1
>>>>>>>>>            fi
>>>>>>>>>            for i in $(seq 100); do
>>>>>>>>>                    dmesg > /dev/tty3
>>>>>>>>>            done
>>>>>>>>> done
>>>>>>>>>
>>>>>>>>> echo "bug could not be reproduced"
>>>>>>>>> exit 0
>>>>>>>>
>>>>>>>> The bug itself seems to remain unfixed, as I was able to reproduce
>>>>>>>> that
>>>>>>>> with Fedora 41 guest, as well as AlmaLinux 8 guest. However our
>>>>>>>> cpr-transfer code also seems to be buggy as it triggers the 
>>>>>>>> crash -
>>>>>>>> without the cpr-transfer migration the above reproduce doesn't
>>>>>>>> lead to
>>>>>>>> crash on the source VM.
>>>>>>>>
>>>>>>>> I suspect that, as cpr-transfer doesn't migrate the guest 
>>>>>>>> memory, but
>>>>>>>> rather passes it through the memory backend object, our code might
>>>>>>>> somehow corrupt the VRAM.  However, I wasn't able to trace the
>>>>>>>> corruption so far.
>>>>>>>>
>>>>>>>> Could somebody help the investigation and take a look into 
>>>>>>>> this?  Any
>>>>>>>> suggestions would be appreciated.  Thanks!
>>>>>>>
>>>>>>> Possibly some memory region created by qxl is not being preserved.
>>>>>>> Try adding these traces to see what is preserved:
>>>>>>>
>>>>>>> -trace enable='*cpr*'
>>>>>>> -trace enable='*ram_alloc*'
>>>>>>
>>>>>> Also try adding this patch to see if it flags any ram blocks as not
>>>>>> compatible with cpr.  A message is printed at migration start time.
>>>>>> https://lore.kernel.org/qemu-devel/1740667681-257312-1-git-send-
>>>>>> email-
>>>>>> steven.sistare@oracle.com/
>>>>>>
>>>>>> - Steve
>>>>>>
>>>>>
>>>>> With the traces enabled + the "migration: ram block cpr blockers" 
>>>>> patch
>>>>> applied:
>>>>>
>>>>> Source:
>>>>>> cpr_find_fd pc.bios, id 0 returns -1
>>>>>> cpr_save_fd pc.bios, id 0, fd 22
>>>>>> qemu_ram_alloc_shared pc.bios size 262144 max_size 262144 fd 22 host
>>>>>> 0x7fec18e00000
>>>>>> cpr_find_fd pc.rom, id 0 returns -1
>>>>>> cpr_save_fd pc.rom, id 0, fd 23
>>>>>> qemu_ram_alloc_shared pc.rom size 131072 max_size 131072 fd 23 host
>>>>>> 0x7fec18c00000
>>>>>> cpr_find_fd 0000:00:01.0/e1000e.rom, id 0 returns -1
>>>>>> cpr_save_fd 0000:00:01.0/e1000e.rom, id 0, fd 24
>>>>>> qemu_ram_alloc_shared 0000:00:01.0/e1000e.rom size 262144 max_size
>>>>>> 262144 fd 24 host 0x7fec18a00000
>>>>>> cpr_find_fd 0000:00:02.0/vga.vram, id 0 returns -1
>>>>>> cpr_save_fd 0000:00:02.0/vga.vram, id 0, fd 25
>>>>>> qemu_ram_alloc_shared 0000:00:02.0/vga.vram size 67108864 max_size
>>>>>> 67108864 fd 25 host 0x7feb77e00000
>>>>>> cpr_find_fd 0000:00:02.0/qxl.vrom, id 0 returns -1
>>>>>> cpr_save_fd 0000:00:02.0/qxl.vrom, id 0, fd 27
>>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vrom size 8192 max_size 8192
>>>>>> fd 27 host 0x7fec18800000
>>>>>> cpr_find_fd 0000:00:02.0/qxl.vram, id 0 returns -1
>>>>>> cpr_save_fd 0000:00:02.0/qxl.vram, id 0, fd 28
>>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vram size 67108864 max_size
>>>>>> 67108864 fd 28 host 0x7feb73c00000
>>>>>> cpr_find_fd 0000:00:02.0/qxl.rom, id 0 returns -1
>>>>>> cpr_save_fd 0000:00:02.0/qxl.rom, id 0, fd 34
>>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.rom size 65536 max_size 65536
>>>>>> fd 34 host 0x7fec18600000
>>>>>> cpr_find_fd /rom@etc/acpi/tables, id 0 returns -1
>>>>>> cpr_save_fd /rom@etc/acpi/tables, id 0, fd 35
>>>>>> qemu_ram_alloc_shared /rom@etc/acpi/tables size 131072 max_size
>>>>>> 2097152 fd 35 host 0x7fec18200000
>>>>>> cpr_find_fd /rom@etc/table-loader, id 0 returns -1
>>>>>> cpr_save_fd /rom@etc/table-loader, id 0, fd 36
>>>>>> qemu_ram_alloc_shared /rom@etc/table-loader size 4096 max_size 65536
>>>>>> fd 36 host 0x7feb8b600000
>>>>>> cpr_find_fd /rom@etc/acpi/rsdp, id 0 returns -1
>>>>>> cpr_save_fd /rom@etc/acpi/rsdp, id 0, fd 37
>>>>>> qemu_ram_alloc_shared /rom@etc/acpi/rsdp size 4096 max_size 4096 fd
>>>>>> 37 host 0x7feb8b400000
>>>>>>
>>>>>> cpr_state_save cpr-transfer mode
>>>>>> cpr_transfer_output /var/run/alma8cpr-dst.sock
>>>>>
>>>>> Target:
>>>>>> cpr_transfer_input /var/run/alma8cpr-dst.sock
>>>>>> cpr_state_load cpr-transfer mode
>>>>>> cpr_find_fd pc.bios, id 0 returns 20
>>>>>> qemu_ram_alloc_shared pc.bios size 262144 max_size 262144 fd 20 host
>>>>>> 0x7fcdc9800000
>>>>>> cpr_find_fd pc.rom, id 0 returns 19
>>>>>> qemu_ram_alloc_shared pc.rom size 131072 max_size 131072 fd 19 host
>>>>>> 0x7fcdc9600000
>>>>>> cpr_find_fd 0000:00:01.0/e1000e.rom, id 0 returns 18
>>>>>> qemu_ram_alloc_shared 0000:00:01.0/e1000e.rom size 262144 max_size
>>>>>> 262144 fd 18 host 0x7fcdc9400000
>>>>>> cpr_find_fd 0000:00:02.0/vga.vram, id 0 returns 17
>>>>>> qemu_ram_alloc_shared 0000:00:02.0/vga.vram size 67108864 max_size
>>>>>> 67108864 fd 17 host 0x7fcd27e00000
>>>>>> cpr_find_fd 0000:00:02.0/qxl.vrom, id 0 returns 16
>>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vrom size 8192 max_size 8192
>>>>>> fd 16 host 0x7fcdc9200000
>>>>>> cpr_find_fd 0000:00:02.0/qxl.vram, id 0 returns 15
>>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vram size 67108864 max_size
>>>>>> 67108864 fd 15 host 0x7fcd23c00000
>>>>>> cpr_find_fd 0000:00:02.0/qxl.rom, id 0 returns 14
>>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.rom size 65536 max_size 65536
>>>>>> fd 14 host 0x7fcdc8800000
>>>>>> cpr_find_fd /rom@etc/acpi/tables, id 0 returns 13
>>>>>> qemu_ram_alloc_shared /rom@etc/acpi/tables size 131072 max_size
>>>>>> 2097152 fd 13 host 0x7fcdc8400000
>>>>>> cpr_find_fd /rom@etc/table-loader, id 0 returns 11
>>>>>> qemu_ram_alloc_shared /rom@etc/table-loader size 4096 max_size 65536
>>>>>> fd 11 host 0x7fcdc8200000
>>>>>> cpr_find_fd /rom@etc/acpi/rsdp, id 0 returns 10
>>>>>> qemu_ram_alloc_shared /rom@etc/acpi/rsdp size 4096 max_size 4096 fd
>>>>>> 10 host 0x7fcd3be00000
>>>>>
>>>>> Looks like both vga.vram and qxl.vram are being preserved (with 
>>>>> the same
>>>>> addresses), and no incompatible ram blocks are found during 
>>>>> migration.
>>>>
>>>> Sorry, addressed are not the same, of course.  However 
>>>> corresponding ram
>>>> blocks do seem to be preserved and initialized.
>>>
>>> So far, I have not reproduced the guest driver failure.
>>>
>>> However, I have isolated places where new QEMU improperly writes to
>>> the qxl memory regions prior to starting the guest, by mmap'ing them
>>> readonly after cpr:
>>>
>>>    qemu_ram_alloc_internal()
>>>      if (reused && (strstr(name, "qxl") || strstr("name", "vga")))
>>>          ram_flags |= RAM_READONLY;
>>>      new_block = qemu_ram_alloc_from_fd(...)
>>>
>>> I have attached a draft fix; try it and let me know.
>>> My console window looks fine before and after cpr, using
>>> -vnc $hostip:0 -vga qxl
>>>
>>> - Steve
>>
>> Regarding the reproduce: when I launch the buggy version with the same
>> options as you, i.e. "-vnc 0.0.0.0:$port -vga qxl", and do cpr-transfer,
>> my VNC client silently hangs on the target after a while.  Could it
>> happen on your stand as well? 
>
> cpr does not preserve the vnc connection and session.  To test, I specify
> port 0 for the source VM and port 1 for the dest.  When the src vnc goes
> dormant the dest vnc becomes active.
>
>> Could you try launching VM with
>> "-nographic -device qxl-vga"?  That way VM's serial console is given you
>> directly in the shell, so when qxl driver crashes you're still able to
>> inspect the kernel messages.
>
> I have been running like that, but have not reproduced the qxl driver 
> crash,
> and I suspect my guest image+kernel is too old.  However, once I 
> realized the
> issue was post-cpr modification of qxl memory, I switched my attention 
> to the
> fix.
>
>> As for your patch, I can report that it doesn't resolve the issue as it
>> is.  But I was able to track down another possible memory corruption
>> using your approach with readonly mmap'ing:
>>
>>> Program terminated with signal SIGSEGV, Segmentation fault.
>>> #0  init_qxl_ram (d=0x5638996e0e70) at ../hw/display/qxl.c:412
>>> 412         d->ram->magic       = cpu_to_le32(QXL_RAM_MAGIC);
>>> [Current thread is 1 (Thread 0x7f1a4f83b480 (LWP 229798))]
>>> (gdb) bt
>>> #0  init_qxl_ram (d=0x5638996e0e70) at ../hw/display/qxl.c:412
>>> #1  0x0000563896e7f467 in qxl_realize_common (qxl=0x5638996e0e70, 
>>> errp=0x7ffd3c2b8170) at ../hw/display/qxl.c:2142
>>> #2  0x0000563896e7fda1 in qxl_realize_primary (dev=0x5638996e0e70, 
>>> errp=0x7ffd3c2b81d0) at ../hw/display/qxl.c:2257
>>> #3  0x0000563896c7e8f2 in pci_qdev_realize (qdev=0x5638996e0e70, 
>>> errp=0x7ffd3c2b8250) at ../hw/pci/pci.c:2174
>>> #4  0x00005638970eb54b in device_set_realized (obj=0x5638996e0e70, 
>>> value=true, errp=0x7ffd3c2b84e0) at ../hw/core/qdev.c:494
>>> #5  0x00005638970f5e14 in property_set_bool (obj=0x5638996e0e70, 
>>> v=0x5638996f3770, name=0x56389759b141 "realized", 
>>> opaque=0x5638987893d0, errp=0x7ffd3c2b84e0)
>>>      at ../qom/object.c:2374
>>> #6  0x00005638970f39f8 in object_property_set (obj=0x5638996e0e70, 
>>> name=0x56389759b141 "realized", v=0x5638996f3770, errp=0x7ffd3c2b84e0)
>>>      at ../qom/object.c:1449
>>> #7  0x00005638970f8586 in object_property_set_qobject 
>>> (obj=0x5638996e0e70, name=0x56389759b141 "realized", 
>>> value=0x5638996df900, errp=0x7ffd3c2b84e0)
>>>      at ../qom/qom-qobject.c:28
>>> #8  0x00005638970f3d8d in object_property_set_bool 
>>> (obj=0x5638996e0e70, name=0x56389759b141 "realized", value=true, 
>>> errp=0x7ffd3c2b84e0)
>>>      at ../qom/object.c:1519
>>> #9  0x00005638970eacb0 in qdev_realize (dev=0x5638996e0e70, 
>>> bus=0x563898cf3c20, errp=0x7ffd3c2b84e0) at ../hw/core/qdev.c:276
>>> #10 0x0000563896dba675 in qdev_device_add_from_qdict 
>>> (opts=0x5638996dfe50, from_json=false, errp=0x7ffd3c2b84e0) at 
>>> ../system/qdev-monitor.c:714
>>> #11 0x0000563896dba721 in qdev_device_add (opts=0x563898786150, 
>>> errp=0x56389855dc40 <error_fatal>) at ../system/qdev-monitor.c:733
>>> #12 0x0000563896dc48f1 in device_init_func (opaque=0x0, 
>>> opts=0x563898786150, errp=0x56389855dc40 <error_fatal>) at 
>>> ../system/vl.c:1207
>>> #13 0x000056389737a6cc in qemu_opts_foreach
>>>      (list=0x563898427b60 <qemu_device_opts>, func=0x563896dc48ca 
>>> <device_init_func>, opaque=0x0, errp=0x56389855dc40 <error_fatal>)
>>>      at ../util/qemu-option.c:1135
>>> #14 0x0000563896dc89b5 in qemu_create_cli_devices () at 
>>> ../system/vl.c:2745
>>> #15 0x0000563896dc8c00 in qmp_x_exit_preconfig (errp=0x56389855dc40 
>>> <error_fatal>) at ../system/vl.c:2806
>>> #16 0x0000563896dcb5de in qemu_init (argc=33, argv=0x7ffd3c2b8948) 
>>> at ../system/vl.c:3838
>>> #17 0x0000563897297323 in main (argc=33, argv=0x7ffd3c2b8948) at 
>>> ../system/main.c:72
>>
>> So the attached adjusted version of your patch does seem to help.  At
>> least I can't reproduce the crash on my stand.
>
> Thanks for the stack trace; the calls to SPICE_RING_INIT in 
> init_qxl_ram are
> definitely harmful.  Try V2 of the patch, attached, which skips the lines
> of init_qxl_ram that modify guest memory.
>
>> I'm wondering, could it be useful to explicitly mark all the reused
>> memory regions readonly upon cpr-transfer, and then make them writable
>> back again after the migration is done?  That way we will be segfaulting
>> early on instead of debugging tricky memory corruptions.
>
> It's a useful debugging technique, but changing protection on a large 
> memory region
> can be too expensive for production due to TLB shootdowns.
>

Good point. Though we could move this code under non-default option to
avoid re-writing.

Den

