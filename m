Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DC3D3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 14:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaE9H-0004n9-0S; Mon, 29 Dec 2025 09:23:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1vaE90-0004lY-7e; Mon, 29 Dec 2025 09:22:46 -0500
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1vaE8y-0002GG-7u; Mon, 29 Dec 2025 09:22:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJw/28fgNSBjVmk4Kjtn5v4QzV5SyGkQk+1L7nMBJrXuAgSDpGBp5bko4ToROUq0MHTKl3VAJDKXZoVMaFUdhAzK454wqauasaFnGjYB0x1gQymQHuhWWWtMF08On3kyODItBDii/ykykyQrVPjd8FkEMr5//edTTnapqOAnKqRDECrMBmzYQCse3sHzhWuhH6sLHvnQtaQan0Op2AdN4u9Uhi3oJSkURmxp6zdKy5o8VK/1PlBNnQrO/ui90sqicqZimPtAD6s5Ni7zoxe/lOnDZk5DgHKPW9i+oUO0wfrNbmeE1XY3aW3N8k1YjK3j6GJQ3P0z1YtNh7CENTDCyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzYid6qTqNy3+9VzmyDEj7RMIAuP+/r48Xlx7JBYwUU=;
 b=Ym/9QXr5JdsO0yXdYxqd5cnGpTaM922u+E1D10OXyYM7wWYL9g8IgUGpBHXNo0Q/1qkqz2E66Ozgvzx9o3fk62+zqmW+Sb8it9ani5puPWvth80uVAuV2/IyKQQUEMdCvOh3+Sby3EzNAWSShBC1e1yTaVfvCS8ENsgr4wTCcZO7CbyDm/pIeOhLXqwG6irgy+2NFAz/Ldt+XNH6SAwhZhXm8AQeKbwXkMX1AwiLBVhkn1KE6J/nenkKXa5cSi97qshTJLnqXNdYfg58DQWB+lqFO7NDTKZlrE0JUqcYRCIo+l1soN3FhZoUqp4ms6L+RCmF9cTGNq3AoLsoTT/bUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzYid6qTqNy3+9VzmyDEj7RMIAuP+/r48Xlx7JBYwUU=;
 b=AJFRYtVNYjs94jMH2gKiZrPZGPXPvROqYn5Hnp/yDmEy9Ap0VWOAOfS0WkB2Uithm1kmijdLDLjnrHv7BCkOBS/+wlkgE2JY8cNKt7Vy86W7XEMhMMeIQBjUwIwA636aSsM9c8NEKtMq2GiTlFROdSYwD79/djNAk7q5rMByrmjeWNNdZIamo8K1UHj86lSormmLMQref59GpeHEUh9gIJWJ6A79OXMr+fUeqqFACfRwxN5der5lxLoPS41RMg4f6aryrvXmyzBdCdD+QitXwUpg3MUsB3QOFwv+eypf2hKDxGDmjJ6FewyTgKspsKLgnyw7wBIzTTGePrWwJ47ThA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AS2PR08MB10324.eurprd08.prod.outlook.com (2603:10a6:20b:5e7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 14:22:37 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%7]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 14:22:37 +0000
Message-ID: <af263158-4e59-4736-9961-32f613e6c892@virtuozzo.com>
Date: Mon, 29 Dec 2025 15:22:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] qcow2: add very final sync on QCOW2 image closing
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
References: <20251219180813.1000884-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20251219180813.1000884-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0275.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::42) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AS2PR08MB10324:EE_
X-MS-Office365-Filtering-Correlation-Id: 7adedb8e-fa3b-4492-13d2-08de46e5b742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0FqQk9JbXNGRHlEaFhOTFBFSG05ZEl1eVdVWDdnOXBsaVAvTm5PS1h4UnF0?=
 =?utf-8?B?V3pIVzVsUTlnNWNvYWdMU0lzR2Z1cjIvWndlZGhNYjN1NnVsS0cyT1RQMmdU?=
 =?utf-8?B?MnpReGdKbnpYbnp1aEl4azBoWldQUVlFYmsxK1ZBczZKRDhUbmdxRG5PYVFx?=
 =?utf-8?B?ZDZoYlRNcGR0Z2EyT1FFVTBDM1pVejFyZVNFV3lROGZLREFzdXhRMFVOWkY1?=
 =?utf-8?B?YzM3QlJlbzlhL3R0YStEYTdFNktUVkRrSGxoek5YWlUyL01JSFFqcVl3dkRz?=
 =?utf-8?B?K0FRNy9RUmltSjV0OWg5a1NwanNtRkhRRkhWTXUwR0xZck5yMW9OeUMyU1VV?=
 =?utf-8?B?MEFBM001a21jdDBxeTlhS2ZrTllEajhialVrd2o0MDYzbmpWRnRjT1RZR3NF?=
 =?utf-8?B?cEJwR2FlOVk1VHpnOXBXZVplMUdrdHdqS1Y4V0xsQzBIVnJjd2JKNDFnUFRh?=
 =?utf-8?B?UUdqZ2F0UFRhbkRpdWJBaVIvcDVKS0E3ajVGMXZMelZuRDRzRzF2UE9wK3Fm?=
 =?utf-8?B?Tm5zS1dmMXVCdTQxa0NRTDlzQXRkYnFkZnByYXgrcWdZUnhyOUFXWXNmZ0x2?=
 =?utf-8?B?eC9PRE5sMVRhZVpDcDR1SGdSbGpxVzBZeGRhRVdkbXFvdVd2NFh6aHpIS0xq?=
 =?utf-8?B?ZEV4Qld4TlJyMGp0TjhkZk4xcVIyNnRnT3VGYkVURzNyVG04Y3p2QnhvaWo2?=
 =?utf-8?B?djlreURrZEQxMUNvNlRGVnVCSldCWGsxT0M5R2gweFk1bWZrYnhIWU9wTmtW?=
 =?utf-8?B?cHVWaWJpa0hZd1RvTXVkc1RGbHRrUUVQNTNENnFKSTNrYlUzekF4Yy9iVll0?=
 =?utf-8?B?cTRRR0JFc1p2ZEJ0aUZoWG1iT3dscEc3bUUzZHNPRzNBR2NYN0I2OHozY0Qv?=
 =?utf-8?B?RjF0WUtTU3BTQ3BaTW1yOVE5YVJuMGw3SEdBNm1zUjM2U3lsTEt0V2duNG1W?=
 =?utf-8?B?T3hpUFpRYUMvMUhPZEVKa05QNE45aDYrM1pBL3dQRlUxV2pKOWloTGtKRDJr?=
 =?utf-8?B?NUp4d0VjVFQrb0ZjQWVQZGljdW9oUXk1ejBVRHhiR0tBRkJzK0dKOXFodHJJ?=
 =?utf-8?B?VEdFRWpPbW9CblNHMU5IZ1hsZmhiQWJDWDVWbERpTW1TRi8zaGNDb1E4RmNk?=
 =?utf-8?B?SjdqbW4wajBRSTNMMGlweHUyaXlMT3ExU1B0c1ZVZUU0TVZqOVZydWdUS0Nv?=
 =?utf-8?B?U24vQ1dRRmgwUDJlZ0ZyY245azZHc0ZRNjRuSENWeWorbVhtOWlLa3ZwbHFR?=
 =?utf-8?B?dW9hM1lyZnJNeXZqR3lhMm1QVFZjTGc1UGdzeSsya0JWU1pNdlRZZDB2czVj?=
 =?utf-8?B?ekNmNHhjaldCbll0SitJQ2FCSHBSV3JKU0ZCSnJodm5tV0pWbkVQcWtnUUlt?=
 =?utf-8?B?LzNqOTF3d21XdnZZbE13R0FYNW5jMnlzQUlOdjBNTC8zbWMwTTQvakRCK3I1?=
 =?utf-8?B?SWZrL3pVM054L2xyRXJ4cEZSaGgvNG5CUHVVQXNHY21RUm04bkJQS0FqRUFN?=
 =?utf-8?B?eDA1NnppYno3TUh3OXlURnpPbi9KOXdqYjhRTlNDQ3hUQVIyajJMemNhUUJM?=
 =?utf-8?B?V0U4NTIrMFc4MGthLzk5a3ZMZGc2WnllYnRWT3RTSmhKaGNGL0hyVEhPbUlh?=
 =?utf-8?B?bXhYbWthRmxaNStYdG1ITFhYeEJnblo1MGxkVnRDU0czeEk4d3VtSldxcWc5?=
 =?utf-8?B?djFkMkpGRTM4SjJueU1MTGV5ZUsxc2N4WXY5WkNka250Y3BnQWFRWlRGRDJJ?=
 =?utf-8?B?aEZPdjY4M01NREJvRUJHQVczRnJLaEluNHFnN2Y4OXR6NXAwS3E1d3NBUFBD?=
 =?utf-8?B?ZGlXcDBRcWRsd0xvZDNFdEdEekNsUGJWSW51SmYzUHZjQVZTU0REU1MvMWlG?=
 =?utf-8?B?SzA3Mnd6UnhjWm5US3ZDcUxrYVhRSmpmTTN1UlByUkllTUZidHRnaTdXdWNC?=
 =?utf-8?Q?xNLQ+XzkdiBCjztX52163B61PimLnf1F?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0JGNnozeXZPSms2S283Y3hPMTV2Yk5UMTNxZitnN3h6NWRxajd1aTJ6N2FE?=
 =?utf-8?B?Z1lqc2V5aytFY1JYbTN3N0NjS2FGOHVQVDRWdGlPUzJyMnMyM0VySHJZdnEv?=
 =?utf-8?B?WUtYbnNwK1hhZzJQVDZnNjNtVElsOWRMN0tLTHhYUFVnbFE0dEs3VXB6OGdK?=
 =?utf-8?B?bnUvTGU2OGhtZzZLeUs0YXB6MkVaZG56YUpPZ2tBTU9LNCsvOGZubXJkZkxP?=
 =?utf-8?B?NXZQTXRSaXVjcW9EVGpwVkNQbndkOHVEN3lCekZqeVZRb2kwSzE2L0xzemsx?=
 =?utf-8?B?eFRoMUxRTURZakZodC9FeHViZUJaeTZyalAxUVF2YUV6K3RoTUIyd2x6a3ZG?=
 =?utf-8?B?UitaS3ZXdWE1cXhxbEMrbEhiUThJR0pmMzlvS3RZTW5SWVpEWUQyd0NmVUF2?=
 =?utf-8?B?UDYxT0I5M1A1aU94VVZpMldqUnp0Z3NjV1p2YytyVHliaUxXN3JHc3FzRElK?=
 =?utf-8?B?L2tpMEhvVXRxY1VtTzkxZUFuQVk1b0dVaElQWW16ZDZCcU5zMjdzT2dydElh?=
 =?utf-8?B?SEhlWWdTYW1xZFc5bWxUaWczK2JyUmJaYXd6WHozUGFucWV3Y0w3SWc3eE1q?=
 =?utf-8?B?QktPSDVYZVcvK205QUc2RUQwOS9RM1gyK3FIUjI5TlJOSmc5SlJOS1BoWFZU?=
 =?utf-8?B?TXhsTTlMSllyOFkwUzBhK3RUeW1FbVZTUzM4VmY2SWcyMlNIdnE0Y3pUMUNQ?=
 =?utf-8?B?bmVDR0F2VlFDZkhEUGxKck92aGd2cVd3YlZpczlyUmc0bkFOQWd0UFpKWUNq?=
 =?utf-8?B?S0trK3g1bGlwM2pBYjZrb01reHdXajlNdTJST3E5bkM0UzRmbU92SWxOalY1?=
 =?utf-8?B?UVkxNWFsTFhMdEpYMW0waEZqQ3pXZmI3YW5nc1NSL2lKK3ZRdzEzSmpLc1JZ?=
 =?utf-8?B?N0JaeXdITnhZcHdtZUlJeFVHZ3p0dTc5bEM1SXdVbFdrdUpLWEltVm92ZlY0?=
 =?utf-8?B?bk1JY3U4dngxUm5Kbkx4RkxUakJ3a0s4OGZ1RWdTUW01MW9DcDQzc1pTSlRI?=
 =?utf-8?B?L0FMVk9zRDBlSUVzaU9VamQwMmJ2NUNKOE9RL01DdXp4bkE4c1J0SjJQSkV4?=
 =?utf-8?B?UGNtNnRSaDdkbDh2ZC9Hd1ZJS0lXQklpK0RhR0xpY25hSm85aGJrOCs1YzQ3?=
 =?utf-8?B?NFVsYU1XMUZKbUJVVXZBZDdrcHZpUyt5VEFXZXVCR0xIbXlVenJOVEMwdFJE?=
 =?utf-8?B?c3k5MWZCcHJsYUVWeE5ZSFJJeGdOMkZxMm5NY1dYT1ljZFhYb3dYK2lmbXQr?=
 =?utf-8?B?ODRIQTZuVXhQdm5LMjRlWEFMbEZjQlFRY2FhcU5FMDJSVGh0Z1Fldk01anRq?=
 =?utf-8?B?UTlzRlMzdnQySDR5SFI4TjdCVFg4SlZYUXdJNzZPazQvUXc1VEV1Y0JGQ2VY?=
 =?utf-8?B?UitqWFZ6VnpscjRGQWIxYXZzRmpPbjZSaDNXMmZ0ZW9ycXlGdjdla1hQMWtC?=
 =?utf-8?B?OXlKWkFHNVV1ZHJyczg0eS95cDNTSnVjQWtpK3hKV3EzYXp6Rzh2emJwbEVt?=
 =?utf-8?B?YTFMWVZCVHZEVmZUNjg1N3VVb0dHVlROYWRqQmJDRHhqbHlPNXdkaExSVWpO?=
 =?utf-8?B?THJVWUpBT3JUb3JEbFcyUjR0Z0pEY0xDVFNqY202cmpkNnBhSnVjdnRRNVpD?=
 =?utf-8?B?WHFvZWtlVG1SNHoxS2N3M2ZpTklKWlVjSVJFV1JBM1QxL2hScUtueGJ2L2N0?=
 =?utf-8?B?elB6MXdkN1pQSlV1TkJyMVlQY0tDMVlkS2dQSG53UHpROTM3c01JN0t5V3pT?=
 =?utf-8?B?M3hib2xGUEZQK1QvMkdBTGVIZ2U0Y1N3R0swUmNnWkVTR2xRMENnMHhxREhh?=
 =?utf-8?B?ejZUNjZ1bUh2bEpOR2dNdWtOcEI3anBqQUd6dnVYNmJTNTBmZllPRTk4YTdz?=
 =?utf-8?B?ejcwRW9RQUJPeHQ0bVg1T3IzKzVaaTVKVE9qeitqcDFPYXZWNlB6UzA1V1Z1?=
 =?utf-8?B?c1E4TVJseDM3WE5qaGdSaE9UVllHVjdOWXd6QkIwMmxTNkZRVVo2NjZ3S1E2?=
 =?utf-8?B?aWlHUUVpNFRvbTh1ZWxRL2s4M2g5WEZJU1BaL2hZMnhucGFvYjBId2pKdW1y?=
 =?utf-8?B?alYrUzdBOENzL0F3bHk4TDkwcGJLNy9jS3Exa2V4RVNXNDdnci85RXVsczli?=
 =?utf-8?B?enoxWEgzYkhubjFkcFVySm1KUXN1ekcrdm1qQTB3SDduVzJSM1REMjdiZUhT?=
 =?utf-8?B?dDI1S0JxVmRkdmN3Qm44SlprYzBxbDZsNVAyaDdmRjI4M0VkSE80akVISVdU?=
 =?utf-8?B?ODduemRIdm55d3Rpcm9zaU1SODFhRWNrVnRpVmpvNmNKZ0t1b3NTWlMydEJY?=
 =?utf-8?Q?L47SfdC2xwTgSB90Ux?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7adedb8e-fa3b-4492-13d2-08de46e5b742
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 14:22:37.0953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cOBErGr6Hcdal+YBwdN5khFDNrsw280lmPAvITEiU0bO5uggZ/l7PCSdlvk6Yitkg25FDmYRcSqcTH2VrsLMjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10324
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=den@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

On 12/19/25 19:08, Denis V. Lunev wrote:
> qcow2_header_updated() is the final call during image close. This means
> after this point we will have no IO operations on this file descriptor.
> This assumption has been validated via 'strace' which clearly confirms
> that this is very final write and there is no sync after this point.
>
> There is almost no problem when the image is residing in local
> filesystem except that we will have image check if the chage will
> not reach disk before powerloss, but with a network or distributed
> filesystem we come to trouble. The change could be in flight and we
> can miss this data on other node like during migration.
>
> The patch adds BDRV_REQ_FUA to the write request to do the trick.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> ---
>   block/qcow2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/qcow2.c b/block/qcow2.c
> index e29810d86a..abbc4e82ba 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3252,7 +3252,7 @@ int qcow2_update_header(BlockDriverState *bs)
>       }
>   
>       /* Write the new header */
> -    ret = bdrv_pwrite(bs->file, 0, s->cluster_size, header, 0);
> +    ret = bdrv_pwrite(bs->file, 0, s->cluster_size, header, BDRV_REQ_FUA);
>       if (ret < 0) {
>           goto fail;
>       }
Thanks a lot for Andrey Drobyshev who has attempted to review
and test this patch.

In reality the patch is non working and the problem is even
more severe than it appears. BDRV_REQ_FUA processing is broken in 
mainstream QEMU. Generic write path ends in static int coroutine_fn 
GRAPH_RDLOCK bdrv_aligned_pwritev(BdrvChild *child, BdrvTrackedRequest 
*req, int64_t offset, int64_t bytes, int64_t align, QEMUIOVector *qiov, 
size_t qiov_offset, BdrvRequestFlags flags) { .... if (ret < 0) { /* Do 
nothing, write notifier decided to fail this request */ } else if (flags 
& BDRV_REQ_ZERO_WRITE) { bdrv_co_debug_event(bs, BLKDBG_PWRITEV_ZERO); 
ret = bdrv_co_do_pwrite_zeroes(bs, offset, bytes, flags); } else if 
(flags & BDRV_REQ_WRITE_COMPRESSED) { ret = 
bdrv_driver_pwritev_compressed(bs, offset, bytes, qiov, qiov_offset); } 
else if (bytes <= max_transfer) { bdrv_co_debug_event(bs, 
BLKDBG_PWRITEV); ret = bdrv_driver_pwritev(bs, offset, bytes, qiov, 
qiov_offset, flags); } else { bdrv_co_debug_event(bs, BLKDBG_PWRITEV); 
while (bytes_remaining) { int num = MIN(bytes_remaining, max_transfer); 
int local_flags = flags; assert(num); if (num < bytes_remaining && 
(flags & BDRV_REQ_FUA) && !(bs->supported_write_flags & BDRV_REQ_FUA)) { 
/* If FUA is going to be emulated by flush, we only * need to flush on 
the last iteration */ local_flags &= ~BDRV_REQ_FUA; } ret = 
bdrv_driver_pwritev(bs, offset + bytes - bytes_remaining, num, qiov, 
qiov_offset + bytes - bytes_remaining, local_flags); if (ret < 0) { 
break; } bytes_remaining -= num; } } bdrv_co_debug_event(bs, 
BLKDBG_PWRITEV_DONE); if (ret >= 0) { ret = 0; } 
bdrv_co_write_req_finish(child, offset, bytes, req, ret);

BDRV_REQ_FUA is processed insidebdrv_driver_pwritev() and resulted in bdrv_co_flush() is __NO OP (!)__ 
until bdrv_co_write_req_finish() is called which performs 
qatomic_inc(&bs->write_gen); Only next flush will really flush the data. 
This means that flush semantics is broken inside QEMU and this problem 
looks serious to me. I'll come up with a patch. Den


