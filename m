Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABEFCE8349
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 14:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svH2j-0006Bh-K8; Mon, 30 Sep 2024 10:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1svH2e-0006Al-Q1; Mon, 30 Sep 2024 10:06:25 -0400
Received: from mail-vi1eur05on20728.outbound.protection.outlook.com
 ([2a01:111:f403:2613::728]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1svH2c-0005hu-U3; Mon, 30 Sep 2024 10:06:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vue43kbhhB8XO9GqpiXnsR//AtRh+vZoijCQGv34J2SU3vYYsXF+KddhQDCZ4bD3Z/bJsLYHCDlT++mI60xJUAv2FsAaSJ22LOsNXkH2kXPrvVmcxhwAv438xVmg5lKCC2LEJuVDGBp1BE5ooPX8aCL85qCejBESe72TepXAkzmuUU5aiLEwvwVMCvg3SWNY9hXRs0cLZ7hYjFzwon4MTRyoarNGBD2fehtiF4PIYUwb5gm1POHFNg1K5D8+doVyX8l+K5PJhNxJS3KKEhXTvXwEo/YqLvaUo2ZXasf6wwOvfozRbAIdt456cJyaIJo3hT2Om3tFeqFifWYBSJbEvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48UKd5X5ZuL8B+slsjjVQut+uJQEYa+5yQonmI8lDtw=;
 b=pse7vlFN/B1r24vnAmvCKQ9fdUUR7HRyw8sZKtX9oQOIJxYJsPRM5rtAWTq+B4YappyBYC/1dv+HsjeRIOphUuqVQNnAu2vQrWQedctlMKkmscFUMHmPf3kDT9LVIbLe4HwwYkHHrkTCC9W0LPZ5NGXAcjG+9L4TYWYuA53jMjnIvqtQg2Gt4J1ErY1lhtesivkuKqij/ir0rLSHm7ozDR/EY9CyNTEG/XSKsFOwDADIsg4Ms2dBIWJK7iYNR1FQ8o2c0V/TXpKkrTuHSSr7AP0s3Kht7Je892tGL2zdyDgxjEtNGz/m23A8YZ3rg9fFQZqKi0w377hJl7C8nwV1MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48UKd5X5ZuL8B+slsjjVQut+uJQEYa+5yQonmI8lDtw=;
 b=mdsUhuECiEJOxyd/b9BDm4DIDIrfjsfxRuqjAw5aYdPMeyXHMDNiPMyh677By9GAS5x69DAXLWtmO9qqnuF+jmoqgpkVf5NXaMc8QfQJvjC7WLl0w/B+q1J5XfO+Gpx1TlpL7PazTvOMTMWQGRaFaybBd0A+rBMVhYHYrpg8dA45MCzuyTBw3UOQaGMTmqq63w0C7kieYacmPGerk8JKyd01Mz3QzSBTEUl+HdBjzg7SEUFtXZla/OQS7K1n6mmjq8NWRO7z5X2xbRhER/prGy5zlSYPulQf2qGFFGrUPRlgm7Ox/zNosuFFAjqwuclZN3nWYcTjjWC/AjxwSQxC9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GVXPR08MB10586.eurprd08.prod.outlook.com
 (2603:10a6:150:14f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.13; Mon, 30 Sep
 2024 14:06:13 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%4]) with mapi id 15.20.8026.009; Mon, 30 Sep 2024
 14:06:12 +0000
Message-ID: <0faf2b77-0cda-4823-8c3f-986be7d6964c@virtuozzo.com>
Date: Mon, 30 Sep 2024 17:07:21 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug Report][RFC PATCH 1/1] block: fix failing assert on paused
 VM migration
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eesposit@redhat.com, den@virtuozzo.com, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20240924125611.664315-1-andrey.drobyshev@virtuozzo.com>
 <20240924125611.664315-2-andrey.drobyshev@virtuozzo.com>
 <6fb3340a-f685-422f-acaf-ad968e854847@yandex-team.ru>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <6fb3340a-f685-422f-acaf-ad968e854847@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GVXPR08MB10586:EE_
X-MS-Office365-Filtering-Correlation-Id: bb582419-d568-4cbd-995a-08dce1590a8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?djNZZytIM3kzVndQY21ZTTJNcTd5TmM5aFp1SUZUS0lJZXJncklRcW5BWTNm?=
 =?utf-8?B?SDdRcGZ5SnVDTThHc2R3QTJJQTIrQ251L21qTlZmK2NURnh4OXBFRjk0QWUx?=
 =?utf-8?B?YklITk04UWNxSXVyZ0pZMVpwbkhncWViMmg3UC9HVk1XOE1zbFNRQkpKU21P?=
 =?utf-8?B?ZHl3TVIyTTBaVEpSNUJ5anRxeDQwajVWUkpuS000VWxrdHhJWmt1M0FUb2xi?=
 =?utf-8?B?ZHpzMTNZVTVZUEYxSWt3TVpCVzNwcjhoR0VYMUtUVVJqaXlRNE93TlJqbUQ0?=
 =?utf-8?B?Y2U1ZTZQVDhtUy9WS1N3a2toeGwrQXh6ejBkRW9RYXo5enIyNHlZaTg3TC9v?=
 =?utf-8?B?NmhrNXc1N0JWdS9IZHNPbmFoOXNTUkJIMDRPQXNvbE5tbE1WcGEvcU5YREFr?=
 =?utf-8?B?MXdCcTJxUVBhelVsNWdWdm1XbDhKVVhRL0FFRm8xYnF5ZjlWSnc4cmliN2tF?=
 =?utf-8?B?bG9UZzVjaytsQU9UZEwzMmtXekN0YlQweVhhckxlK2FaY1Z1ZHJWQ2ZNQXUx?=
 =?utf-8?B?K0VnR1VqelN4YjBrOUUxbTNsZW14VlBRWXFocWVjalVadU5jbGt4K05Pd28w?=
 =?utf-8?B?MGFtcXQ0SFZMMlJNMWxIRTFzRE9jSGpOSDZRaE4zUWNHZEt6b2wrZTFFY1BX?=
 =?utf-8?B?R1l1Z2cyaytwZnVSalpkL1RoRHJ1WVJwUWVoS3MvbWs5NlhraHFzbmxqM2ox?=
 =?utf-8?B?REIxK05uOC9VR2ExbW5SS05BNkNoYmJtbmxpYU0rQk14SWlwd2pDaktJaU1t?=
 =?utf-8?B?Z2R5aGR3VDlZdHR4NEI1UE5xbXNpR09VbHlnWHBNdVkxMHA1R2FKQnV6L0Jh?=
 =?utf-8?B?Z2xJV0ZCTCtzRHFObnFrOHNrejltNkFqdnhqL1VQeitpMk5xaWszOERlVnJM?=
 =?utf-8?B?QWhDaUowSXJ6alFYMnpLTnM5ZElJSVdKM0l2OG5YRVdxb2p2ZTB5Rlp1czhZ?=
 =?utf-8?B?eHNHbWxqVzZUWFg4ZkRaRFpYL0t1eVhtdUpBeFlXd2tuS1BORG05Tlg5YlE1?=
 =?utf-8?B?Qmp1NklyWGVRUzM1ZytFZXhGOEg2RGFqcTNSYjl1UitKYlBUcHFZbXJiQ09x?=
 =?utf-8?B?c1A5Sy9xODlVT2sweVFpajBNNmZXRXNid0VQQW9HYnRhZ3BEVVRvekE0M1M4?=
 =?utf-8?B?TFgrcDZ2QmV5Wit4SVVFYjRlRm05bi81RFFjUGM1MFV6RnJ0Nnk1WGFTR2Za?=
 =?utf-8?B?YlRNYldtdlpmVXA1Y092WVBmL0hFZXFjaHExbGdud0V4akh2ZEVBOEdZQmtu?=
 =?utf-8?B?STcwbmFLVGlqZjBBOGdLbTUvNmxsd3UxQi9IOERWUXBBTy96SWhyaExrcGho?=
 =?utf-8?B?YVZycW5KeTMwVFkyMUdmMDFFU21FdkRBK0c5b25CWEdMNUxZbmx0RGxzZFhK?=
 =?utf-8?B?amZtM2JpUTZEekNRWFVNSEczVWRZcFByTk85THlaS1FaYXlkNVNBOXcrVFVM?=
 =?utf-8?B?V0dueG56UGhpUHptVzZEVkxraWx4MGU3QkN6V2VGWkZTMXE3aktiVFNjQ2JG?=
 =?utf-8?B?eStjMnBGdkdWcnlHUjRDMkRNdkd1L2thNjkxN2VWa1BCMkgzK3gyYkpucTln?=
 =?utf-8?B?eEJMTEczSmhPTTkzYU96ekwvWnBZZ2RwMVU3NHFWN1E4V3lHb0F2V3RVb3p0?=
 =?utf-8?B?U1U2TGJkYlAzWmFhMXBkMGpKUlozY0pVTGkxUUVXVDNTSk9weWVxd1AvMy9o?=
 =?utf-8?B?clViRXVYSnlaWmxOSWVGVEt6MDhtYUZ1QWpCaG5vUVQvSlQyWFZoUWF3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHJ3K1AvYi82UmVZalFCYUlRRkQ4M1RYdEIwZXgyakhvV2I4cmI2VGRTQ3hO?=
 =?utf-8?B?ZEtyS2RYTkM2MmpXbEUzV2ZEWHZzL3JpdFZMMzdjRVk1bVpzTFd2K01PSm9K?=
 =?utf-8?B?Z2NzS0tZTzNRTzVOUlhiR1hhWWVHejdMekIzU1ZCaWxOaG9PTDhEYUs1by9N?=
 =?utf-8?B?dDBMWmFFZm5XQ3kxYVdZM2lJcGNKMWI4bmlLZWx2a2lNc2graEIyZ1RQYi93?=
 =?utf-8?B?dmRGZzNNVnUza2ZTUHF1bUNlY20wU0huNllnK2ZSTkk4bWJOUHhTYWk4S0g1?=
 =?utf-8?B?eWR4L29xVTJZWGNTaUxtZU85cXpPbDdXUlJQNnJJazZNTmt1MWhqRVFjWWVS?=
 =?utf-8?B?RytKM0JmbUpJdnNhRy9hVktBbGw1VnhCcE9ncXFORzJ4OGRrMkVhR3ZQc2JT?=
 =?utf-8?B?QnRYU2ZLeVRvYlZ5YWY1WndobVVvVi9VdUZlV1lTQlpHS2RMWGF0cGlqQXNR?=
 =?utf-8?B?THhNQlQ0WHhHNXNWbVNNQTRMZW4yeVhiQ3BlRE9sZXpxVGhSdG5uelBkYkNI?=
 =?utf-8?B?ZWNUcGVvZkFtR05pZlE5ci9hdHZXTE51elQxUElLVGhURjVZRENXSlNIcnRq?=
 =?utf-8?B?eVIwc0EyeWNYRTBBVEx4dE1FeHpCV0ZBNUtzSlNRZjFRbTRob1IrMlBYRUZT?=
 =?utf-8?B?bG9IdEVTVy8yUzVCbEVYUXNiMk1hSTZSQ042b1d4a0E3YXdlNW0rZ2x5OW1E?=
 =?utf-8?B?TnFGU0NOdmNDTEY4VWdtQWFyRi9RZkxJN0VnOUFTMWlRMTU3VzhUSkpWYk1z?=
 =?utf-8?B?WXV1WmZYY21lSFhRbkVCSzlTaVUzSGRtQU96RDJSL2x0UUg3R3A0QVField6?=
 =?utf-8?B?UzBnYTJrRjhxQVUzV3E4dVRzTHU2Y05nZmtFRUtXRS9JR1djRjhjRFFCVWI1?=
 =?utf-8?B?N2svSHNvV3lBWjFKYVBiYlE1eVR4UWpHYS9lZHAvejVjRXVEck9ReUZ6bkMx?=
 =?utf-8?B?dmJLa1A0TFgwZ0tlaE5xNVk1MExNY0txL3MybTRsbklKb0FhWGxqR1JtRmNB?=
 =?utf-8?B?eC82cUR3azNYVytOcG1lVVQxanRRZ0ZsMERkNXdjZldnYjdDSXAvb1M5bFM4?=
 =?utf-8?B?K2daaVhCN2FlZ2V5QXAyMTcwR2FuWThVa044VkZtK09ScUYzcXBIMkJhSHNM?=
 =?utf-8?B?QUZ6VGJOMXRXbTdCaFV2WmZrVEQrSW1pSVBYK0NVQ2FPSHY4ZjU2bHJGRUoy?=
 =?utf-8?B?cTh3dXFPYkwxVVZIYm04VDFFSnJxNGtjRjA4Y3crV1hTKzZRVjNKVzdFOVNv?=
 =?utf-8?B?YlloOWJhZWpUL1RIYndzOHZLVnYvVElmclhqQjlZa1o3YitGT1J5TEEyR0ZZ?=
 =?utf-8?B?SlJlRnNlSVFLVEdjN1FhbDJudTkwRExyV2FjcjIxVnhqeStPK0pDeTlsTWQ4?=
 =?utf-8?B?UUJ1eWJMdGdCL0RrbURhS2FCMjVNalg0NXYram1OVUtzOEsxcXpUV3lwQ2hs?=
 =?utf-8?B?NW44MWlkYi9mR1k5b3NjbFd2ZzUzZU9HbHlwdVV1SzdyY0hTL0NicDBJSHZ6?=
 =?utf-8?B?VDAxNHpndk5SSG5UNUFjb3kyZjBDNENXYjZpaldzd1UvMElxN28rTm9rY0p0?=
 =?utf-8?B?TW1mNGU0VGRBSUFBWnhjNDlGR2VraHN2bmxBRzZDSjFIS3h1ODMyL2FPSlF6?=
 =?utf-8?B?MGdzMDhMUHQyUmNoNEovUEZzYjV4MkZBbU4yakFOQVFpQzI0V1RvNmx0V2xt?=
 =?utf-8?B?VnVJWkY4VHlwN0JpNklLRmtaTzZiUVhYd3pZR3NFeUx1KzZtVjNGa1N4ZjRo?=
 =?utf-8?B?TkNUVWloNG5mak1kckxDUXhIV3lSNHp2a2tsVWRhTGYxTE5WTUtvRmpTbEhp?=
 =?utf-8?B?UFBQZ3ZzdU5ieFgvVmJnWDgwVEJoUDJiN0p4UjAxL0pqcFdNVjVseUYvT21p?=
 =?utf-8?B?SzBqWlNTUEtBSTZoWUVOUlF5d2ttb3VLV2dkNWt1alh2V1BKVE1QeitwSTNY?=
 =?utf-8?B?Z3AzcWM2M3pla1ZyNy9FZFp0WEFnTktzakhQSWEwR05IMk1ITXkxRGtlZnRo?=
 =?utf-8?B?UlQ0VTMwZUYvSDRuRlp6b1ZwNlljU1NhYnVLRjFBRU9WeUxzM29pTkFOTGEv?=
 =?utf-8?B?RmovQmVsSTdsbzU5TVdKU09wVE1zcGp2blNqU0lZSU9BNlNMaXBQK2h1aWhv?=
 =?utf-8?B?SWpWVm9LQTUvMmE1bUJnSUxiemZ2V3BRZVkrYmVLNTNCNnVWd0F6Z2JQek14?=
 =?utf-8?B?TVE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb582419-d568-4cbd-995a-08dce1590a8f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 14:06:12.6872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /o1QnPx8fTNdVKXBp3Lf7VRB7rAaIYFJlNpB3GZPdwbQc60+mOOIEU5Ujw07Tve5c6UBJJPnwgVKyFDAxSwsu9iPWSfVz9mPKnaz0FhlQ1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10586
Received-SPF: pass client-ip=2a01:111:f403:2613::728;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
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

On 9/30/24 12:25 PM, Vladimir Sementsov-Ogievskiy wrote:
> [add migration maintainers]
> 
> On 24.09.24 15:56, Andrey Drobyshev wrote:
>> [...]
> 
> I doubt that this a correct way to go.
> 
> As far as I understand, "inactive" actually means that "storage is not
> belong to qemu, but to someone else (another qemu process for example),
> and may be changed transparently". In turn this means that Qemu should
> do nothing with inactive disks. So the problem is that nobody called
> bdrv_activate_all on target, and we shouldn't ignore that.
> 
> Hmm, I see in process_incoming_migration_bh() we do call
> bdrv_activate_all(), but only in some scenarios. May be, the condition
> should be less strict here.
> 
> Why we need any condition here at all? Don't we want to activate
> block-layer on target after migration anyway?
> 

Hmm I'm not sure about the unconditional activation, since we at least
have to honor LATE_BLOCK_ACTIVATE cap if it's set (and probably delay it
in such a case).  In current libvirt upstream I see such code:

> /* Migration capabilities which should always be enabled as long as they        
>  * are supported by QEMU. If the capability is supposed to be enabled on both   
>  * sides of migration, it won't be enabled unless both sides support it.        
>  */                                                                             
> static const qemuMigrationParamsAlwaysOnItem qemuMigrationParamsAlwaysOn[] = {                                                                                 
>     {QEMU_MIGRATION_CAP_PAUSE_BEFORE_SWITCHOVER,                                
>      QEMU_MIGRATION_SOURCE},                                                    
>                                                                                 
>     {QEMU_MIGRATION_CAP_LATE_BLOCK_ACTIVATE,                                    
>      QEMU_MIGRATION_DESTINATION},                                               
> };

which means that libvirt always wants LATE_BLOCK_ACTIVATE to be set.

The code from process_incoming_migration_bh() you're referring to:

>     /* If capability late_block_activate is set:                                
>      * Only fire up the block code now if we're going to restart the            
>      * VM, else 'cont' will do it.                                              
>      * This causes file locking to happen; so we don't want it to happen        
>      * unless we really are starting the VM.                                    
>      */                                                                         
>     if (!migrate_late_block_activate() ||                                       
>          (autostart && (!global_state_received() ||                             
>             runstate_is_live(global_state_get_runstate())))) {                  
>         /* Make sure all file formats throw away their mutable metadata.                                                                                       
>          * If we get an error here, just don't restart the VM yet. */           
>         bdrv_activate_all(&local_err);                                          
>         if (local_err) {                                                        
>             error_report_err(local_err);                                        
>             local_err = NULL;                                                   
>             autostart = false;                                                  
>         }                                                                       
>     }

It states explicitly that we're either going to start VM right at this
point if (autostart == true), or we wait till "cont" command happens.
None of this is going to happen if we start another migration while
still being in PAUSED state.  So I think it seems reasonable to take
such case into account.  For instance, this patch does prevent the crash:

> diff --git a/migration/migration.c b/migration/migration.c
> index ae2be31557..3222f6745b 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -733,7 +733,8 @@ static void process_incoming_migration_bh(void *opaque)
>       */
>      if (!migrate_late_block_activate() ||
>           (autostart && (!global_state_received() ||
> -            runstate_is_live(global_state_get_runstate())))) {
> +            runstate_is_live(global_state_get_runstate()))) ||
> +         (!autostart && global_state_get_runstate() == RUN_STATE_PAUSED)) {
>          /* Make sure all file formats throw away their mutable metadata.
>           * If we get an error here, just don't restart the VM yet. */
>          bdrv_activate_all(&local_err);

What are your thoughts on it?

Andrey

