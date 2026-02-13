Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138ECEDF14F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 10:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqqNl-0007du-D6; Fri, 13 Feb 2026 05:26:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqqNj-0007d3-7s
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:26:39 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqqNg-00076K-On
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:26:38 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61CMRIUT752466; Fri, 13 Feb 2026 02:26:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=c5oduhT3Opj5S82hKaw5f+sbs8z0NpGQz66Uf0RnN
 /g=; b=zblS4/kr5lNpsU/duYT8gB5PTqt2hr08qCOOf2dGZEr1D7qvAzjn9GXUO
 gdH4L+LkJhLFEIwmtpYnoQF0g6tFTXkP67MDVvQqBqUVAT0pawj+3ZlC4nKhFAf7
 e3CARqWFboULsQ0v/YZLxWobf89ElbvmabLc/0TBAe6uv/UwyNm1Vs9lEfjzuQ9s
 bmrGUHgv46eyZNyq/+3ZMAzgZ1bleX49GoKHahLj3Th8K5RvHsZlMw/7gFGyDw2a
 JCLxNB8z3645zB5BG+FCXFsrG1WoYQJBflYiswdtcakQhkx8CsO/R84VKcPN5wNS
 SwsipyaxMAUBeyGMAxiBRSWL/B5UQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022086.outbound.protection.outlook.com
 [40.93.195.86])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c8ctc8nap-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 02:26:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2gQD/OAZKEf/cTrqdfYO7cXxBgvwZA47IdJIcmSiDzh4GTF5R5ueKKh8P6W9FbICpJ5ZHSyze95sOr2U3ixAG66Sr76aDZyTKrdlBNKOrAhhzMZi+q3gdoXxkFdWil4O5i0POa1rDU6TdEf8F6g99Bgisj87bldRgQV7NIB7zGdkvK4PU+xSKdpEjYokwX17xAda+5ExIt1v9K4965v15rdW51PTP2p9YrpgeDuj1xd9mv3w/OU0SUZsOSw39ZnQOG/WNuITte+7Mc2txwR7slbOVSCHBYkX2fkx/Z06MzwllJCygJ8FOEyMYTU2bgfRKNWB03/acCGbsSSzLtPYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5oduhT3Opj5S82hKaw5f+sbs8z0NpGQz66Uf0RnN/g=;
 b=k/TNm99FKUadn+71mBU2Ok9+9/a+9dFabxBDCWFGUqicU0K/kp7ETZ+zYKbZjhLxmpnjWrpqxa2srK5DUVKVTv8VHgaE5YLtnBQoDQapVaboARWDMZV8ZqlTFXmsKxusM4xtYU6Vt0MNYaumf07yFcZMhs9YYERNuMKPxQBHIubBcqG34LjiDXRUgI4zpqQFVuSkdUjRempso1eitWTsJEEVHtTq4B2Celv5GNkyxKmxeprISGFBcxzkwWDa3Tq63bC4RueyIMCI0Mm+AiFx6bOjjpDpmHmDKjGmYuHvp0tHNH5/W7fuUKbfek+ABf5iX8r51Q7jkY4nGznXYFssow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5oduhT3Opj5S82hKaw5f+sbs8z0NpGQz66Uf0RnN/g=;
 b=goTc2jOWUAFIDrjmnLmXkI6PHk/UlXfp6Y7J8ngruzqFKSPx1t+o/fkVhQFd09H8T75G4CLO1MK1i3+ZkA1mFPZN1TCZOzyP/H4AOEzA6US5GTDGnF4gckOLWi0f3ZvYj09Uhm96FfMtyP8XVSnBe06cKDWnm2I9wlcYo58D3SFCkwW7DkCnpXmUP/MLNJltkbeInkWEW9098qJdPmTNUpnJ5Dodt8bGdwJQUt8YTtytvyfShWrmX/lgBDClZ93xSjwpsRRcc03oyA+0lFzOsu3L9kjddYmQVf04psOwSq6gVOJGdXt011Yw9g1RmTvYRmbiHnQ8+DnH5Qr1j8oxxA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL0PR02MB6548.namprd02.prod.outlook.com (2603:10b6:208:1c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 10:26:29 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 10:26:29 +0000
Message-ID: <b237b995-7813-4634-a8c3-9e3df588ffec@nutanix.com>
Date: Fri, 13 Feb 2026 10:26:25 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/43] audio/jack: convert to QOM lifecycle methods
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-11-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-11-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0264.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL0PR02MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fce94a3-e112-45d4-9ca6-08de6aea598e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHJmdUF3OEJnWk0wNVRValJPeGZRamEzZU0rOXZmK0I5TEt4OHlpRyt5cyth?=
 =?utf-8?B?TUhYMExRVmJQSnYrcUhlU21XWFZ1NTEwb3pJNmRDb0d1WkZIQnVUb0wvQmJY?=
 =?utf-8?B?THhhNHZkbkIycWZIV2tTbTNQd2VRamdhc0UzWDZDZDJwMGxBQWU4N3JXNHMw?=
 =?utf-8?B?SDh5cnJPTDZXRVM4NHlZenRJNFQvY1ZySXJpR0cxRXdUZHIwKzhWMDBCSm9v?=
 =?utf-8?B?VnBlVnlVdWk0SkFzU0Y3SEV3Sng0allFcE5BdHhvR1BFVFRXVE00TVM5cklp?=
 =?utf-8?B?U3JHL1VyVW5sTE9TUUk2NjBKY2UvVE5Pc0dKT2FHTG4wVCtBYnMxU2c3cTds?=
 =?utf-8?B?MWZDMjR6Vk9pV1FlNUg3UzgyTXlPR0hqbC8yWHVldEIvS29OdHdqc1Z0OWlp?=
 =?utf-8?B?NTA4WUhLOEVqeFVzNGJXSlU4TFh4N3EvQjZxVGxjclJmTnBmME8rNXNNdEdR?=
 =?utf-8?B?NUlVSHFXUnVndHduQ2laK3lCMTg0Wm04Z29KTnN6VnRESStHamFSbEpsLzNZ?=
 =?utf-8?B?VkhMYWN2VEwzeHRYMnJiR1luYTRFNEdUTlRoSTVoTUMvd1RZSDEycktma09M?=
 =?utf-8?B?UGN2eWZGcm8zbHBOYUVJaXlRUEVkUjBEMUc4SDk5WTdZSmsra2lFTXZNd1hR?=
 =?utf-8?B?NFQxMTZ5KzRPOHhlK0ZhRTQ0emZyL09HOWxsNzFoQlNtd09uTHIvKzVrRXd5?=
 =?utf-8?B?TUVVbjNqMVJycG90eWZLTjRhWDlWZythRmNvWXcyaGtJZWJ3bmJ4Y29wQW5Y?=
 =?utf-8?B?TWo2OU8xa3RMcFFOV0hFUituTkxXMzFmb2dpYzlpUjRvNk9qMUFwTEx5L3BK?=
 =?utf-8?B?Nm9OUVRZUDB4WlhjWGRFY3pIWVllLzU4UXdUUzNOQUpSRWFwRHZ4RUlhSjYr?=
 =?utf-8?B?Ni9jVnZXWDkzUXc3QzFha2dsMHAwRG1JNmF3aVFiaTRyc2MydzJlajQvMjlV?=
 =?utf-8?B?NllDOGlWVE1oeDdhZnlYbzlqbG5lem1sU1NBdkFUNVdXemorMWtCZkY3OEV0?=
 =?utf-8?B?cy91bzUydWJuektUOUY5MUlHRzUvZldqcGtmcENVbHBmVG51dVZqUHhHOVNt?=
 =?utf-8?B?d0dUQllUUjg4SzdlUFVjRzZXM0pvRE1SUWVnQzQ2WktKK29aN0J2Qy9IMVlx?=
 =?utf-8?B?KzVCalJBWDF0SVlzL1ZQbEI1UURodDZLZTB4SklmZEhyMXM2QmlYKzZ3THc4?=
 =?utf-8?B?ejlHUFdoVXRHQlFuNktjdm5zaUIzSGRxbHFqTnl4cGpJenVaZWVvZVJPYmVF?=
 =?utf-8?B?dnVVZC9wSTdGd3hwSEM0K2RRaEtjanVlRTNTSThmYmpRYjJ0NHRuRjV6QlVr?=
 =?utf-8?B?U094cTFsenJjZDY4eUY2Y3R3Q0duL1ltZU5jMW00NitZcERua2NqbEkyb28w?=
 =?utf-8?B?eHFqRzFreGJOV1JaM1VEbC9oVlkwUmdBd1AvbnVCQmdsVzF4aUFYS0wrdFlj?=
 =?utf-8?B?RFkvZzh0SUt3VzNLMjB6aTF0RFJ6ZXVaVFhTS1hOZ2ZDa2lqeHhNbVB4eXpo?=
 =?utf-8?B?bmE1ZUpVZ2RlS0t0QjA3S0gvWFpEUzlHUWxsU1FqQ21yV2p1eEwwRGRrTjdL?=
 =?utf-8?B?K0dpVVhGZFVvdzZzc3BYcFJua01TRjRPbHNrYmIzZEJpVmhIc21qY1R3MlNN?=
 =?utf-8?B?MjI5bmZZVXpEZE0wWUM2RU5NMkJMU2k4NVBpeTRKZE94NlpQb2srak9zYnZH?=
 =?utf-8?B?OGh0dnVNcTEwSm03UVcvdDEycnp2TXNwRFhRbnNReW0vWEtHUTFzY1V6czZi?=
 =?utf-8?B?cWNxVVd1VGxHVUhqUU1xc0VKclh3QSsyOTRzazU0RVU4aXVLUGkyZEhKdkIx?=
 =?utf-8?B?Q3Q4am41aVJSdnJVaWVCdXg2YkUxOFN2NXNSWUx2V0VQUjNaVi9nbEpDUXRl?=
 =?utf-8?B?K1lyTkFmc2RnVmQ1aDlJelhWZzNmNXlDVm1SV09iZW9lMmRDYXRjc1BJN01Y?=
 =?utf-8?B?ZEt2SlZJYVZ6OUJhcHpUQVdMVDNBMXlxM2JQaityc1pJYmlsdStyNHp1eW1B?=
 =?utf-8?B?THhMNS9PZ1BJTktOQW04Z0tmclNSSkhwbkN4T05ZRGRWa1FRcE96TW9QeWZG?=
 =?utf-8?B?Q3JDd3YxN3Y4REVvSVZvVnR2VnVWeW92Q3BQU2Q5KzIrNHFiVkR1RlRnNmJE?=
 =?utf-8?Q?28gY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXJDZTdDaHNKdFJVSnZ3dXVyU2RyMWNtTzhMOHVRYzI4T2NoMWN5NUc4K0dw?=
 =?utf-8?B?Z080ajFkUGwvWlhuNVBnYy9xTDAydEE2akhwNmdaOGFsOFk0bzIwaW9mc1or?=
 =?utf-8?B?YUNkNUFxUkRkRjg2WkY5VWhiRTBxcWF2cFYwUy9aV1FvYkNGOG9qNC9PZ2FO?=
 =?utf-8?B?cndMZWZXQXdnSjA3Q3VOQ1o4UG45MnZieDFXOEVHYzdnSFlvZ29jMnRwUThh?=
 =?utf-8?B?MVNBcjhtc0k4NEJWQXBNVW1PUkxXNS82OEdYVEdWeEJKQVdhWUxTMmlzSzF2?=
 =?utf-8?B?UFdsNnR1M09PalZmR0FnNVBrMkhLbmtBaFl0L3AvcGlGYXE3L0l2ekRIc2l6?=
 =?utf-8?B?SFVFOVpFQ3NJYnhTSVo3RVV6N3g0aTlUUE9SeXBJUktuVUpIY3BnS2lXOVdX?=
 =?utf-8?B?OS9WdEFSOUxlbFVQbDkxT2N2MkpINVFUdlFSSmd4c0hFcS9zWXhBeUNZM3VL?=
 =?utf-8?B?MTJTbE5ObHJESmtiWmxQbGJMZmFqZlVHeDNnbE4vNE1qbG9vTExlQUJMZDkv?=
 =?utf-8?B?QkxXSjdqRFZEVDQ3U0tXQ3MrRWRMektxajFBczJsTG5hSGZSNWpDdDFNcXRN?=
 =?utf-8?B?SU13Tlg5MmhVN012RG8rTzRIN1lEc2hQWE01eVNreE01RVlScTI4UHB2cmZ2?=
 =?utf-8?B?eXowakI4QkN6ek91NzNHclo0Nk5BR29ROFdkdjVsUjJXK2hzTUJ2QlJRZ3ZB?=
 =?utf-8?B?bCtqSU9iYXFrSWtEQkVORlZsRG56dVJIOWF6NzVPTnFZb1R2UHBjYmF1R3d2?=
 =?utf-8?B?RndkTVlpRHhwc0FiSFNJSUI1WDZyY3BtOTREVmJpc1J5alBab2tCZTIxZlc5?=
 =?utf-8?B?S21Qc3d1SllYUHZ5YW5vaGtwMmNub2VpbU5TbnBMVkw4SGRHOU41aFNtSmI2?=
 =?utf-8?B?YS8xMVMvZTVxVWdVUGFqcG9NMXNVYW5ZRktXYmFPQnplWkc0SkQ5bi9mRDlh?=
 =?utf-8?B?Wm1seC9RTStkeGhiM3JwaW5ETm1TbnNIakVkOGwzMzc5TjV1eGw4NVl0UXdS?=
 =?utf-8?B?YU9jVnBlaW1LYkFtSEd6MGpBekhBM054ZHlrNGh0K3VZMjJYOUdEVmxlbGJk?=
 =?utf-8?B?WnRWVVkvWis4UUtqOVI4M01iNlVQTEJiN3ZoQkpuZ1dFOFhvYmZ6dEFvK0kv?=
 =?utf-8?B?Wk9XKy9yZ0tZVWxUU2lCRUk0KzhGRExrR2V2RGkzdFM1NEFBRWdLbWgzWjlZ?=
 =?utf-8?B?Ylk2SE15bmUwVHI2NExiNnJBMEN2RmgxVjFSak1CVVRHTVE1b3BIcmtQeEtJ?=
 =?utf-8?B?NzFMNGR0QjF4OG9uRzFzT0tkdFgxR1dEY2J6WjVUaXhiTHRDMkhOejVSc2k4?=
 =?utf-8?B?ZFdlTkcyOXpNYmlOZUc4TTlqaGh6SjR5QXR2ZTJRMGZGZWdYWlFJWW5UcGxF?=
 =?utf-8?B?akJLRGx1S0pBUlBUMTUzZDl3d2ZidmlScnh2SldWRkxrUmpDYzlKWU9NRTQy?=
 =?utf-8?B?aFBQUXNhYlBwdjZybUY0MEhBY2dJZ0tJbHZSZlFHbmNtcGMwM0tJbW85dWRx?=
 =?utf-8?B?RjlpalVTUEU4ZjF0MnlpdlAvYzYwNDNPS3JLcEdGcEhnWmhIL1VwTm8wM1U0?=
 =?utf-8?B?SnBQeFlZMTVUd0t5bU9wbUU1UEFqTTVBMG84bDJ4VzVhc25Fb2RiaUhCTmhM?=
 =?utf-8?B?TTBnaTh2ZXFFRUxjK2tMZGZHVTc1ODdrajREblc5Zkw3Qy9nZjlDQ2gvbFN3?=
 =?utf-8?B?RThwVlNOVzM1aUtJZXZFR1Z3ZkpiSTBvbER1QmkzdEJYTyt4czJzQ1JHc1J3?=
 =?utf-8?B?UFJyS2FMOVhpZnBDakNyU0RiSS8ySEtROC81MmRNbThLZ2RzTTNZUm1xRWRI?=
 =?utf-8?B?TlBtRGhEUTVQVG9wV3RhT2N5QmJYUndkRDVWMEdJcEpJb0JPSG1jVnYvMmhE?=
 =?utf-8?B?ZmI5c24veVZYUGt6MkZpVFNUanpSNEJHMy9TbE9jd2JMU0J3ckJ2aWVjTXZL?=
 =?utf-8?B?YlVReVZMMXd6SUNEbmU4TTBGc0MxWEI2dG41UXFEL1dMc3JWNWhoR2p1R0Y1?=
 =?utf-8?B?aUZmRG5HR1F6QXdqcHczMEZyWDZZcE5UanJnZEFyVVJhOXhrOWRobGFnK2hS?=
 =?utf-8?B?WUt5Y1hRL3RXMklIcHBmR093NlBnTWxLb2x0eHFxWnYwUU9kT0tmYkQ5dGRy?=
 =?utf-8?B?c2JaaDc3eXRuOE9hMzkycGhaWVl1a1l5dkxybU1CYzRUSExRUVlyS1ZhWU1V?=
 =?utf-8?B?QldSeTA1cFV3WWhlS2txQkZwOXA2Z1pyM0Ewc21SU3dSZXJUbFFsa0xmWUtv?=
 =?utf-8?B?VHBZYUIwelI2Y0kxU0cxOFYxTXhFcU5CNGhVSXlGNjNEM1BLRFo1WHBtcWNo?=
 =?utf-8?B?OUxacm5YUzdRQjZ2K0gxSWp6RDF2QXA1N3NzeDcxTnlkTDhEVit2c2N1MHpP?=
 =?utf-8?Q?5R/6GimL8Yf3H8Lg=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fce94a3-e112-45d4-9ca6-08de6aea598e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 10:26:29.2663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DktZdEDb912pNwqiT0UibiRupQh0EPW2InkRzGnRtCGWLfQFdNCalwxsYOOTD2RKGSZQb6CMKp4W/YVAY+Zhu5JfXcC29/NHURkqv4Q/1sI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6548
X-Authority-Analysis: v=2.4 cv=Yd+wJgRf c=1 sm=1 tr=0 ts=698efc56 cx=c_pps
 a=N8kEk6x4ntq5/8uFt7L4kA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=mcfIx8YYz8mIsyAnrtEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: NDJG4Z7iD5MQ1TbPO-3SV41PJukB124o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA4MCBTYWx0ZWRfXwfhGVpGK8+Zr
 hYm0Y2h8A3cYrvTt2A1hs/WvNkB16SLdTjRqwLZFgWBWzZVOaUbUSbmaTwbbC1feSUkEy/MbbdD
 fh7X4ymwyYmrGrZjF+lRIgqBUzY3Q9TjM0E50li6rX7wQQ8v/utAnOfULw90kc6XfYJkGVpwD9b
 TySsqRWUSOvHQp0RMBmUNs1npebCiAxgNrrSj5Lnh3r5JS4V41u6jhdoIxG/4oHOf1rsMyMKqwd
 cEv1ue9bZAftzDQj4RDepr0gYDDmobBlN+X476A30rASNTWchXJybvUx9piwgzxKksjIvHQ8hQy
 AHN7hIxUhyDq5Ekn5980UTi7/bmxL1apv6dFsSWekXZ7uB42r/DYqeeyKbGPTGrrO4amVs6fbJK
 b11UH5BKb5MW6iYCBvdaWHyX8PgrZgmkiDdgQcgsCOZ/JvQK50t78nvXcqxqlTwjSfKupwgmudV
 0xoRCXxfASsQp7u9zmQ==
X-Proofpoint-GUID: NDJG4Z7iD5MQ1TbPO-3SV41PJukB124o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 27/01/2026 18:24, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Remove the legacy driver init/fini callbacks from the JACK audio backend.
> 
> Both qjack_init() and qjack_fini() were no-ops that performed no real
> initialization or cleanup work. Access to the Audiodev is now through
> hw->s->dev instead of the drv_opaque pointer.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/jackaudio.c | 30 +++++++++---------------------
>   1 file changed, 9 insertions(+), 21 deletions(-)
> 
> diff --git a/audio/jackaudio.c b/audio/jackaudio.c
> index dc86724d28f..7fbc37ef4f2 100644
> --- a/audio/jackaudio.c
> +++ b/audio/jackaudio.c
> @@ -44,13 +44,6 @@ struct AudioJack {
>   
>   static struct audio_driver jack_driver;
>   
> -static void audio_jack_class_init(ObjectClass *klass, const void *data)
> -{
> -    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> -
> -    k->driver = &jack_driver;
> -}
> -
>   struct QJack;
>   
>   typedef enum QJackState {
> @@ -518,7 +511,7 @@ static int qjack_init_out(HWVoiceOut *hw, struct audsettings *as,
>       void *drv_opaque)
>   {
>       QJackOut *jo  = (QJackOut *)hw;
> -    Audiodev *dev = (Audiodev *)drv_opaque;
> +    Audiodev *dev = hw->s->dev;
>   
>       jo->c.out       = true;
>       jo->c.enabled   = false;
> @@ -555,7 +548,7 @@ static int qjack_init_in(HWVoiceIn *hw, struct audsettings *as,
>       void *drv_opaque)
>   {
>       QJackIn  *ji  = (QJackIn *)hw;
> -    Audiodev *dev = (Audiodev *)drv_opaque;
> +    Audiodev *dev = hw->s->dev;
>   
>       ji->c.out       = false;
>       ji->c.enabled   = false;
> @@ -662,16 +655,6 @@ static int qjack_thread_creator(jack_native_thread_t *thread,
>   }
>   #endif
>   
> -static void *qjack_init(Audiodev *dev, Error **errp)
> -{
> -    assert(dev->driver == AUDIODEV_DRIVER_JACK);
> -    return dev;
> -}
> -
> -static void qjack_fini(void *opaque)
> -{
> -}
> -
>   static struct audio_pcm_ops jack_pcm_ops = {
>       .init_out       = qjack_init_out,
>       .fini_out       = qjack_fini_out,
> @@ -689,8 +672,6 @@ static struct audio_pcm_ops jack_pcm_ops = {
>   
>   static struct audio_driver jack_driver = {
>       .name           = "jack",
> -    .init           = qjack_init,
> -    .fini           = qjack_fini,
>       .pcm_ops        = &jack_pcm_ops,
>       .max_voices_out = INT_MAX,
>       .max_voices_in  = INT_MAX,
> @@ -708,6 +689,13 @@ static void qjack_info(const char *msg)
>       dolog("I: %s\n", msg);
>   }
>   
> +static void audio_jack_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->driver = &jack_driver;
> +}
> +
>   static const TypeInfo audio_jack_info = {
>       .name = TYPE_AUDIO_JACK,
>       .parent = TYPE_AUDIO_MIXENG_BACKEND,

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


