Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A21C87FCC
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 12:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhSIA-00035L-9Z; Thu, 31 Jul 2025 08:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1uhS1E-0001N1-3o; Thu, 31 Jul 2025 08:04:32 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1uhS1A-0005Jt-BU; Thu, 31 Jul 2025 08:04:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkPK48IyIBkSo6P/JTFI0iIcbWnF4ijFghLH1vCDfBPOR/z1P28w0de2Yn0fSm94BmxlqqovQzBXC+2QofmGrAQl+Vla97M8hdmbmXC8qOCYBVWaMcOiSiB0Mh7nBioqBqt7lZpkdKPvo3hjrEkOh/m7WTqTHnvcqa4z6i48r8EWEyFboD18PhBRv6zBTjuodC1MRE6jTZbdUEI0wmwLJO1a2R1DeSY+tdT1zCLYYzDY/yZ1sd4PK3QvO747nNWgSNjNDrlJdh0pFfFQVj+fs+VwTZuKnNT4n5MLxIww2xp6MMkC5VD3MsRyOkVXWtLftLSSyU/5xl7bP65AZnmFOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57uAk8bmsH9POd8mxrCN5TFmdt5Mm7NKUs6SnoS3RkM=;
 b=uIEYX0FVNXUHVWzv7pINC251gsHt/kux8TyfrxbcRL5PGptaraT6wZ2vamXgVCMMiHt3GUWlbghm71IpclphqfR+WG7lxhvJTRJsTYsAk+A+6jp8LcuuVKs1wCXoqd7DukKQaZ5p051b09n3pUYwR/VAuyJRCqF8gFeyFoZIrN++9Qd6+lZYBHeqlU4hEHv23l7Jj4RI1SfMQd5hJ10F1oRZTzBxCJdOoMKCgFzk+UD/g8KNhGadd/IF/riANZlr2kCCszYLnsgUt7y7REG5KF+hA+faWH8FwJAOBWPmex8y/jhJLMIakthx2sqUUckh88FBiSrZPEeSHdz8do1kaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57uAk8bmsH9POd8mxrCN5TFmdt5Mm7NKUs6SnoS3RkM=;
 b=yYVS/jzuAi7ySVQgyA5zA/P3bTCF4ioiYZIEsez0oYu+KyXAEwqmenj0Rv+/xK3OJ+3VHAYngz0XLi0HvEI+y1WgGZA6BFNcyeTBakp6+BXRZK3GtP79eS7KeqfO6dQreg2dGOJq/BF1XIJty9awW4eSQ2ylPB4yFjOCv00Cqt5qqPgx/g48OiBWYGJmYm0Iiv5k3xMc3oFIyncJ0S2mJ4j9Lbc6lAnrCgvVSGkPnoE/fY4vOBmuVE9UAFW6AauPxxy4yx5v/YiCnYnI24AtToXlCy7Pmqc++j2tQ1EynUmjBZABY5XoZfu1/7mxjmX63GRshZjnZwWO+/xjeZE3HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS8PR08MB5942.eurprd08.prod.outlook.com (2603:10a6:20b:29f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Thu, 31 Jul
 2025 12:04:08 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1%3]) with mapi id 15.20.8989.011; Thu, 31 Jul 2025
 12:04:08 +0000
Message-ID: <b39df1c3-cf68-475b-b8df-4723fc196d3c@virtuozzo.com>
Date: Thu, 31 Jul 2025 14:04:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] qemu-img: add sub-command --remove-all to
 'qemu-img bitmap'
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20250723192916.1065781-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20250723192916.1065781-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0112.eurprd04.prod.outlook.com
 (2603:10a6:803:64::47) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS8PR08MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: eb569336-2822-4e75-4231-08ddd02a5a9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bEEvd08zcjdGV2hGMjhIeWJuWGZuKzZvMnBhUUVDNHMzUzVETDdGRyswWDlr?=
 =?utf-8?B?MTIyK2VGem5CaVBnZjVZVE5pc0wzNmdUWXBWUnBlM3dxVFlhSFB6VmNPS0h2?=
 =?utf-8?B?Vnp0S0JmUTczalo3Y1MwMXpmYmhBSkJqbXBSb0c2ZVBqaXZJMXk3NENwcW9k?=
 =?utf-8?B?U01BTTZ4T0JxdDNvNTl5NDRYZWZkWEVYWFRRbTk3b1g4QnBxc1p6dk92ODZv?=
 =?utf-8?B?b2t1UHZtazhVVk4vc0VKV21vdDRtL09rVUtUMlRtQ1BiT1Byd1hmNE9hUWFC?=
 =?utf-8?B?dC9UNS9LTzR3UDZEOTJuSkV3c1ZEKzBpaUNLN0R5eVVkNlIxZTBZVEk0RTl2?=
 =?utf-8?B?eEt0cVpGcm4zRW55aWh2MFNVc3puYzR2VERKLzVaUk1uWW52VitYSjZyY3Az?=
 =?utf-8?B?RDBzQW81MGJlSTN6VExEcmVpTXJycjRBd0N6N2t2VGRCT0JmL1lRVGJzTFpI?=
 =?utf-8?B?V2wzdFRLbkhNbmRGR3Q0WHYzWDJPTkpycmJhWEc4K1A0MFZXVWEwMUlCK0hF?=
 =?utf-8?B?VFpOdm1xclh4VkdETEJPUTB2SWFXMEl1aDVaWFdQcWh3Yk9aNkhJSW43aFZr?=
 =?utf-8?B?QkJiNFptaUZJbW91M3ZiWnV5dEpzR1dmV1ZtU0lqcy8wOXd4T1NvUDRLSXlw?=
 =?utf-8?B?dmZSVUJUMGROQ01zS2NKMGxzS3RVaXdHTy9kdjhuUnFOalE2L3p3VXQ5TXFH?=
 =?utf-8?B?cXUrcDYyOUxPOUVMZm5nZnphZFFDNWVqUTdRc3ZlQVBYZTVZeFJLOVRnZnFQ?=
 =?utf-8?B?TTVlQWJuRk9TZWJKQSs4QVljckpNdVNtM3BFWGNzS2IwNTl2cW1YOEN5aTNa?=
 =?utf-8?B?cHdTbml3eVBUZnVJUkd0MUptOVdXMzhGUHVES2RTci8xTGpXdnBmUHdsT3Zu?=
 =?utf-8?B?RUtkN2hVNFBsSUs1MDlYN3c4SDZFUkliQUhjMW11dnRmSXgxTHNPYnlXNm9C?=
 =?utf-8?B?RUgwek1aRm1lcEpIYTlCalFYdzMrdEhJWnRaN05OZ3hDNW5LdHBOQzBEVkxY?=
 =?utf-8?B?VVRUQnU4cit5OGF1bGxSamdYaWJqU0Q2L3ZZSlhBelc4U2dnTVpYVUNoc1c3?=
 =?utf-8?B?SmdNazJTSDVUOVNxamdDSENYeitjR2VJa0JTNCt6dEpkRnBnMmUzcVdrZ3hH?=
 =?utf-8?B?SG9EalZrN2V3akhtVHhvMFBFb1IwL3Qwdzh1Y1J6WndvRlNsbWJ6VEV5MG1E?=
 =?utf-8?B?cWVQZGhBVEZydkxrYXZRVVNwWTFFcTBKSDU0SVdpdzgwSUV5ZWhMakRZMHky?=
 =?utf-8?B?K3hNUVdjVTFBNUZxbzBJZmVVT1pBOE53bFJwYWVhSlFYSklsYzZ5OTdxZS9p?=
 =?utf-8?B?RjY4cTU5U3o1V1h4MU1uSEo1TExoRWlNcTZ1bEsyZHRyRGx2UC92LzZrQ2hQ?=
 =?utf-8?B?aE1Icm1NSVVxb0FKZXBJRXhWYURXeHFVbkZNN281czRraWZ4ZlIrUytUKzJ3?=
 =?utf-8?B?YzI3WEpLM05SUTJINEZRQ09zSTNITUxtNU5CZGV3eFBJUCt5Z1pYQytscG9t?=
 =?utf-8?B?aC9EMG1KQTQ3ampnMFh3aW1laXN2V3JGTk00Tjk4aDF1dUdycnhXbCtERE1J?=
 =?utf-8?B?OTEzUDkwZjN6a3dIbVRFRDJKMGdYUi9FM1pPa0dTZ05XTFg1dUVRYktNM0Nk?=
 =?utf-8?B?VWVZNng2dzhLd1pGeDRaU0pvK3FudE90NmNwL2JVQWg3OHluaGVUVHNpOVAx?=
 =?utf-8?B?c2JHMlR6RzNCQ2dFL2RKR1BpU0hIc1ZUb05EMHFxNFZKV2lINSswMElyL0FN?=
 =?utf-8?B?eTY0YU5wWXl1dnJCSy9EaXhTYXgxdHFWbjk2UnUzT3EvRWJuYmdDT0o5aGV3?=
 =?utf-8?B?SHU2c3N2NVVOUklCeGtpN1FjVUdDMzM3bTJoTXA1OUVkbTNNa1dCVStYaS9x?=
 =?utf-8?B?alI5NTFBRlUyM24ybElJdTlLRkNhQ0x6OElvY3RHVE5FcHdVdktVVS8walAx?=
 =?utf-8?Q?IyDE9aWKp6c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnZIRlUxcjRMQ2w0eWc0ZjZna25HTUUwS1UvQTY0N2svS1dtVkR6ZlpLTXRy?=
 =?utf-8?B?bmtTRDR0d1ZnYk1mcENVZWoxV0ZIZW5TV0NLOXpjQXJzWEVKMFlQblFZNUxL?=
 =?utf-8?B?N1hwS3RSamVLejNDMjVLV256L05PaGlFOGYrVU9RQzdyMzNZekEwTTZ4MkM3?=
 =?utf-8?B?SzBSM25ZSUR2UXFRdXRtZnR6aHZrbHhXTXQydGNBQ05UZHNtRHV6SHNjcXUz?=
 =?utf-8?B?ekZGMk5BbWNUZFdab3ZlelhDSHFVcTRsMlo4VjBHS1dUcHl3SG9keitSY3ZL?=
 =?utf-8?B?L3N1ck9OWkJJanlPNjdFRW9sdGJ3MzRVYkJEcFBlWXpPcGdoS0h2eFVwdmw2?=
 =?utf-8?B?S0tReFlrZkVqemVlQzVBWTRPRGN1MExQem1ERjA4STAzdnBvT0tDdTJ1cWV6?=
 =?utf-8?B?QzFVd2RZWlZpVk9ocVpMSTBrejQ0V0ZsSmJQOG5QYWhFcFhzU2xnS1p3RFg3?=
 =?utf-8?B?eWd5OFo4RzN2NHZjcVJ4QThDb29Dc0FZWTk5azNLaS9PQUgyNHgyS004OUdI?=
 =?utf-8?B?c2lxeGJVd2Jaa21PNlExRmloS1BMbTAyLzNtMXBhRHFrQUQ4Q044K0lRaU5B?=
 =?utf-8?B?QWpWZkRaWUpiVDVrQjRrdkJPbnZxZHgwU2FXbXY1am1SVkhCdmFONDNvSUJq?=
 =?utf-8?B?Vm5jTmY0d0U3MkNUT3BHeXZDRzJmQi9KNmVJZWNJdlN3TWRLNmpmMjZBaERN?=
 =?utf-8?B?eCthcU1BQkdXRjFwUk1FZE5Vcjgya1FQZEZ4U3k5REtwN21Sci9DemFUdUJC?=
 =?utf-8?B?QUx5dU5mVUlQcUhRVHBoWlIrazl4U0lGSWVaQzJIYTB5bUNSTkFqTzNlbkk5?=
 =?utf-8?B?NDZSZ0FTbzJMRGRSbW1pRkRwWTEzZjBadklYTU0xd3dpaTBXV0Z4Q0xhZFNw?=
 =?utf-8?B?eUQzLy9TbGF3MUpsYVBZZ2xoOVJtK0M4OGIvQWIwMndwUk1zd21mbXlpRWhz?=
 =?utf-8?B?UUUvcXVzTExuaVJNTzh6QzR5ZW5HMjZsUUx1NmsvZ2Q3bkpIVDk5QnZkbXFs?=
 =?utf-8?B?S0RiNUFFY1pqdGJSN2RSci9NbENyM3NkQk95RGs5bjk0bkZXMGVBL1hTVmVN?=
 =?utf-8?B?VzZMSTJObVNwb3NzL2h5cHQwb1greXE1TFZsdWFkQ1FaYWZyV2JpbmF6WnJW?=
 =?utf-8?B?VkgyZ09JRmtYVXZhODR1NUtZZFpMMzBzSnNoU0w2YnozNHpZUG9ROTN3Y0xN?=
 =?utf-8?B?WVJMenEzVDlXNGR1d0s1UmF2TkNZb2N6RHNORUVWTGJlQzRERS9td1J6TU91?=
 =?utf-8?B?QWFNTjRYMlpxUWNtMUFDRGs3STRwN0tPL1NkY2ZrZkRTekR1QVRuZU9nOWV6?=
 =?utf-8?B?bDNETk15bnlMRDZFcjYyMld2ZlVwaWxoRG9lKzBjVmUrN3k4RW9WUEZNQVQw?=
 =?utf-8?B?WjIwcDVnSW40bkk5V3ZiUzhGTHd3QTBLVUNsY3V5SUZsSEYxZjlGaWhpVks1?=
 =?utf-8?B?RFM4U0VjSUd3U2VPaUhjM0pNOGpEanU2Z05sYjl6UW4rU1Q5aTBpQkRxdEt0?=
 =?utf-8?B?aC91bzRpcW40dlNEcGZ5VmpMeEdvblRlQ2ZNVjNTeG82UDliVnZWRGZreEtZ?=
 =?utf-8?B?c2NDVVJIMDc3c1F4Mk5kaXVTWDFURXBJTW1rekt0M25hUC9PMHZpdzNPR3pl?=
 =?utf-8?B?R0JGT2QrdE9SOHFUT1RQN1NDNkJxOXY1bjdGWjNvODI5NXova01wM1pONFNa?=
 =?utf-8?B?NTR4UmYzanZrMjNFRjRna0ZmWE42SE80WVh4N3VJalFaQmNhVkhHNmJuRGdr?=
 =?utf-8?B?QXRPay9GZ1MxaUxudDFBb1oyenRVY3BnQmR2TTkraExDaEdMQ2prUFRlRTdV?=
 =?utf-8?B?WGhRSEFsd3ZaNDhnVXdDUUhvcG1OaHorVmdkaFdEdm1tazJ3emxpUmlRVGxO?=
 =?utf-8?B?RTY1VUFZMlJmRmdQUlFvWERQUGsyb3Zncjg3bmlaZHNwdjFvWEhqK1FhV1o3?=
 =?utf-8?B?R2hBc2hYWG92QzJ3MlBEVGsyeDI2MEcwdFh6azlnYWxFTm9saXFQZFJOQUp4?=
 =?utf-8?B?NjA2K2dSNTNLRC9ONHIrV1l0cThBVllJbGs2cmh6WkY3eDZwSnRXUkpUVFBS?=
 =?utf-8?B?d3dBcWszZW5ad2FVRmZhRWpnTDJWcmVaZ08vTUtwemJRdWJtdWpsWjhYN3ZT?=
 =?utf-8?Q?zMNMYY/kCKw+4BTUPE6I6etAD?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb569336-2822-4e75-4231-08ddd02a5a9c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 12:04:08.5173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BToc7XAzaOX6qAcxDJm4vIcjtLcPms/Y0bQ+jOa94tqN7127xCssdKcguU5VqJJfuVOKgg5cobM5WMgmTLrxfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5942
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=den@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/23/25 21:29, Denis V. Lunev wrote:
>  From time to time it is needed to remove all bitmaps from the image.
> Before this patch the process is not very convinient. One should
> perform
>      qemu-img info
> and parse the output to obtain all names. After that one should
> sequentially call
>      qemu-img bitmap --remove
> for each present bitmap.
>
> The patch adds --remove-all sub-command to 'qemu-img bitmap'.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Michael Tokarev <mjt@tls.msk.ru>
> ---
> Changes from v1:
> * rebased to latest head
> * adopted bitmap help to the new layout
>
>   docs/tools/qemu-img.rst |  4 +++-
>   qemu-img.c              | 47 ++++++++++++++++++++++++++++++++++-------
>   2 files changed, 42 insertions(+), 9 deletions(-)
>
> diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
> index 5e7b85079d..db739ab5c8 100644
> --- a/docs/tools/qemu-img.rst
> +++ b/docs/tools/qemu-img.rst
> @@ -301,7 +301,7 @@ Command description:
>     For write tests, by default a buffer filled with zeros is written. This can be
>     overridden with a pattern byte specified by *PATTERN*.
>   
> -.. option:: bitmap (--merge SOURCE | --add | --remove | --clear | --enable | --disable)... [-b SOURCE_FILE [-F SOURCE_FMT]] [-g GRANULARITY] [--object OBJECTDEF] [--image-opts | -f FMT] FILENAME BITMAP
> +.. option:: bitmap (--merge SOURCE | --add | --remove | --remove-all | --clear | --enable | --disable)... [-b SOURCE_FILE [-F SOURCE_FMT]] [-g GRANULARITY] [--object OBJECTDEF] [--image-opts | -f FMT] FILENAME BITMAP
>   
>     Perform one or more modifications of the persistent bitmap *BITMAP*
>     in the disk image *FILENAME*.  The various modifications are:
> @@ -310,6 +310,8 @@ Command description:
>   
>     ``--remove`` to remove *BITMAP*.
>   
> +  ``--remove-all`` to remove all bitmaps.
> +
>     ``--clear`` to clear *BITMAP*.
>   
>     ``--enable`` to change *BITMAP* to start recording future edits.
> diff --git a/qemu-img.c b/qemu-img.c
> index 7a162fdc08..ddd449c1ed 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -86,6 +86,7 @@ enum {
>       OPTION_BITMAPS = 275,
>       OPTION_FORCE = 276,
>       OPTION_SKIP_BROKEN = 277,
> +    OPTION_REMOVE_ALL = 278,
>   };
>   
>   typedef enum OutputFormat {
> @@ -4992,6 +4993,7 @@ enum ImgBitmapAct {
>       BITMAP_ENABLE,
>       BITMAP_DISABLE,
>       BITMAP_MERGE,
> +    BITMAP_REMOVE_ALL,
>   };
>   typedef struct ImgBitmapAction {
>       enum ImgBitmapAct act;
> @@ -5010,7 +5012,7 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>       BlockDriverState *bs = NULL, *src_bs = NULL;
>       bool image_opts = false;
>       int64_t granularity = 0;
> -    bool add = false, merge = false;
> +    bool add = false, merge = false, remove_all = false, any = false;
>       QSIMPLEQ_HEAD(, ImgBitmapAction) actions;
>       ImgBitmapAction *act, *act_next;
>       const char *op;
> @@ -5026,6 +5028,7 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>               {"add", no_argument, 0, OPTION_ADD},
>               {"granularity", required_argument, 0, 'g'},
>               {"remove", no_argument, 0, OPTION_REMOVE},
> +            {"remove-all", no_argument, 0, OPTION_REMOVE_ALL},
>               {"clear", no_argument, 0, OPTION_CLEAR},
>               {"enable", no_argument, 0, OPTION_ENABLE},
>               {"disable", no_argument, 0, OPTION_DISABLE},
> @@ -5044,8 +5047,8 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>           switch (c) {
>           case 'h':
>               cmd_help(ccmd, "[-f FMT | --image-opts]\n"
> -"        ( --add [-g SIZE] | --remove | --clear | --enable | --disable |\n"
> -"          --merge SOURCE [-b SRC_FILE [-F SRC_FMT]] )..\n"
> +"        ( --add [-g SIZE] | --remove | --remove-all | --clear | --enable |\n"
> +"          --disable | --merge SOURCE [-b SRC_FILE [-F SRC_FMT]] )..\n"
>   "        [--object OBJDEF] FILE BITMAP\n"
>   ,
>   "  -f, --format FMT\n"
> @@ -5060,6 +5063,8 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>   "     with optional multiplier suffix (in powers of 1024)\n"
>   "  --remove\n"
>   "     removes BITMAP from FILE\n"
> +"  --remove-all\n"
> +"     removes all bitmaps from FILE\n"
>   "  --clear\n"
>   "     clears BITMAP in FILE\n"
>   "  --enable, --disable\n"
> @@ -5089,7 +5094,7 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>               act = g_new0(ImgBitmapAction, 1);
>               act->act = BITMAP_ADD;
>               QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> -            add = true;
> +            add = any = true;
>               break;
>           case 'g':
>               granularity = cvtnum("granularity", optarg, true);
> @@ -5101,28 +5106,38 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>               act = g_new0(ImgBitmapAction, 1);
>               act->act = BITMAP_REMOVE;
>               QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            any = true;
> +            break;
> +        case OPTION_REMOVE_ALL:
> +            act = g_new0(ImgBitmapAction, 1);
> +            act->act = BITMAP_REMOVE_ALL;
> +            QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            remove_all = true;
>               break;
>           case OPTION_CLEAR:
>               act = g_new0(ImgBitmapAction, 1);
>               act->act = BITMAP_CLEAR;
>               QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            any = true;
>               break;
>           case OPTION_ENABLE:
>               act = g_new0(ImgBitmapAction, 1);
>               act->act = BITMAP_ENABLE;
>               QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            any = true;
>               break;
>           case OPTION_DISABLE:
>               act = g_new0(ImgBitmapAction, 1);
>               act->act = BITMAP_DISABLE;
>               QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            any = true;
>               break;
>           case OPTION_MERGE:
>               act = g_new0(ImgBitmapAction, 1);
>               act->act = BITMAP_MERGE;
>               act->src = optarg;
>               QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> -            merge = true;
> +            any = merge = true;
>               break;
>           case 'b':
>               src_filename = optarg;
> @@ -5139,8 +5154,8 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>       }
>   
>       if (QSIMPLEQ_EMPTY(&actions)) {
> -        error_report("Need at least one of --add, --remove, --clear, "
> -                     "--enable, --disable, or --merge");
> +        error_report("Need at least one of --add, --remove, --remove-all, "
> +                     "--clear, --enable, --disable, or --merge");
>           goto out;
>       }
>   
> @@ -5158,10 +5173,14 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>           goto out;
>       }
>   
> -    if (optind != argc - 2) {
> +    if (any && optind != argc - 2) {
>           error_report("Expecting filename and bitmap name");
>           goto out;
>       }
> +    if (!any && remove_all && optind != argc - 1) {
> +        error_report("Expecting filename");
> +        goto out;
> +    }
>   
>       filename = argv[optind];
>       bitmap = argv[optind + 1];
> @@ -5199,6 +5218,18 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>               qmp_block_dirty_bitmap_remove(bs->node_name, bitmap, &err);
>               op = "remove";
>               break;
> +        case BITMAP_REMOVE_ALL: {
> +            while (1) {
> +                BdrvDirtyBitmap *bm = bdrv_dirty_bitmap_first(bs);
> +                if (bm == NULL) {
> +                    break;
> +                }
> +                qmp_block_dirty_bitmap_remove(bs->node_name,
> +                                              bdrv_dirty_bitmap_name(bm), &err);
> +            }
> +            op = "remove-all";
> +            break;
> +        }
>           case BITMAP_CLEAR:
>               qmp_block_dirty_bitmap_clear(bs->node_name, bitmap, &err);
>               op = "clear";
ping

