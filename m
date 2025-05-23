Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86B8C54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 11:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIQIB-0002OF-AK; Fri, 23 May 2025 07:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1uIQI9-0002LH-5S; Fri, 23 May 2025 07:10:21 -0400
Received: from mail-vi1eur02on2098.outbound.protection.outlook.com
 ([40.107.241.98] helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1uIQI5-0000Vx-9C; Fri, 23 May 2025 07:10:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohJVoBY6IQ3ip27QyFgyL+H0prgAagOoIS4hYKrIywkLvYl5N5YHFLZNnJDlbnSKj+pfUaLtpCcAZlj+5vfg3c0HHI4u/X3O5H4glYB1bI0GxYFLwLtwNoymaa00nDlNo3/oNV8zvIZ4epx+L1TN6GQ/ZKEQ4POZt9lK1HiItIomku/E5aJ/XZOiLM5JnSRRnqNNEHJuCwxeu51pMtkdUSmABnICGbXNw4kFo5eEwLRuTcW9eXqP2AivEmkYLbVrRYDolxR+BPuORZz/Acd8ERZpLqkjpBkLJvH3NZPcp6yMNkQ/DqL8U/SzPy8aoUbj24yALCYp7fnhHWjNCymUmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGQgJ/5rdwJOiqorgHtZL00rN23DGg9H1wUAKMQFG/o=;
 b=mNP6XBjQ78Lhdlq+WuKUzvyf2esT0gngCFsJV/6tpqLIm7/+7d3SjRpgLOz9IVKGNcoAgF5Cssk4A9G4jgx8ij1QXxe6gONs5Qm4o0GJ1DeEJ6UJtmRrRNAz6ThD3R6xWH82kyWKy+oXL42P7IHhXurxPfKpTXXuKQUsLjN9P5AVPjkMcT+GuuRBa0S0uThTGgNwK4gjQLAoeZcX6Ktm35mPbKqaAX952iLUOtKF/lVJ37hDqKZIJXuMq7zVoa2m+A6O8kS4srJV9a5SScC2cxSqbWYLLDWjl0tozVj+/ZEBqBjosRCHazg1lrrRpb2Qe9M59X94ydRO2GU1nfEvvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGQgJ/5rdwJOiqorgHtZL00rN23DGg9H1wUAKMQFG/o=;
 b=l9crwrko5qHfES4rN4dk9ZDgoQrHFrIk+8uUBCYnV1L+AdFYCr/Dhol8D4B8BYpHuxbmegyO/Y76vkUZ/l0i8XLwLk38SnzaPU+JZTolp0q6QROLBLh9KPD2pvRYmc+W8WF3GcMRh16kKE5QZrV1GEOp+i43KihqfLuG70yyiIFvpt8fgj8qSNU8qEYhB4OWSZ9sbLbIBsGuR0aMRGvvXSzlzmczVCAF1sqhUqtyac1LwUqVoWrrvCtPvSOOehFREz1SYM7KdQWx0rM6m9CaTcxEbRUdXuQru5ZoJRYYWDGllXa0JlN+d1B/0aMsGQPHHKmM1x2SnnNIsLHLthRt2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by VI1PR08MB5504.eurprd08.prod.outlook.com
 (2603:10a6:803:13b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Fri, 23 May
 2025 11:05:08 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%4]) with mapi id 15.20.8746.035; Fri, 23 May 2025
 11:05:08 +0000
Message-ID: <df4826d3-fdb1-4dc6-9e1f-f87cbd8e08f4@virtuozzo.com>
Date: Fri, 23 May 2025 14:03:14 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] nbd: Add multi-conn option
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 "Richard W.M. Jones" <rjones@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20250428185246.492388-6-eblake@redhat.com>
 <20250428185246.492388-7-eblake@redhat.com>
 <3233ad9b-028f-4136-9391-2130ecd5d4fe@virtuozzo.com>
 <fqocrea23tvvi73ld7yvhhw4h7ojv7qzf3jygw5ggxdu3ksb2a@l5l2duiwuzox>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <fqocrea23tvvi73ld7yvhhw4h7ojv7qzf3jygw5ggxdu3ksb2a@l5l2duiwuzox>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0248.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::7) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|VI1PR08MB5504:EE_
X-MS-Office365-Filtering-Correlation-Id: aa23d769-ed11-4419-c03e-08dd99e9add4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SElnRnVhZHNlSmhzRDJJZlY2TDJMckh6c1VreHo1R3B3MXYxa3VlSnRDUHV3?=
 =?utf-8?B?Vm9Hdm5UNWdySlgrUzJwd2Jnd1FJWVdGcWdDR0RnUURETjFaRG9RV3lRT0xS?=
 =?utf-8?B?SkxiUkxNaHhwZEJEOXg2dDRCZWRxbGJaNitkR1BrU3Brb2FrZ3hCV0Eyc0dn?=
 =?utf-8?B?ME5aN2pxRmdTeUovMWFHNXh0ZHJQUVc2cUkrUW5sVEhqREgvWkYybjJSd3l3?=
 =?utf-8?B?SU9ZcmlMazhJU2tDV0VCY3JPZzVsVDdlc2lsVDlrQVNGRmU2ZHdCaUtIalFv?=
 =?utf-8?B?MXpBVXhjMkhQd2VkS1liYXlZZzhMdS95YlptRGJ6dEF4MkdJSkY1OVBzci9N?=
 =?utf-8?B?R3IvN2lPRytBOExkYnlvNGo1a1dVYThXak1ZTHVNTVRCUVgrNTg5Nk5JWDMx?=
 =?utf-8?B?b05KdllSMmxMR3BFaEcxdHZwanJhN0Mwa280M0hqSE15UkM5b3R5cDdlR0hv?=
 =?utf-8?B?Nk9xOE5KdlFINlJXR3hZcTRuZlVNUnpLU09TdlFLdlg4ZUFMakR3cGRULzhF?=
 =?utf-8?B?REZNMU5sNjdQWU9seTEyOTZTZVJuS0JUU0RWdEowUUlLVFdWL1VEUE1XcTFs?=
 =?utf-8?B?aDFxSGhnOHhKa3hWcEhyVEVHT1c5Z3Zxd2dMWE1Ua3BCYVV1aVRCY0VEVitL?=
 =?utf-8?B?NjhvdEhudzVPS1ZxV1UwLzlKbXV2d1IyUlFDWlp2SmxVU2VieCtzTFFTUm14?=
 =?utf-8?B?N2pocFZzUE5JVzBETXRZenJPUVNKdEErZkQyMlNXd1llbXlCMTBWdEpOSERl?=
 =?utf-8?B?eWF4UEpOWFppajF6OTViUFRYenJ2UjFJcFVpdXpiNHVWamUwaWJuODBTNkx6?=
 =?utf-8?B?NE5HRzMwc1J2VE5GN1VWc0hNQThNK21RVzF2eFBDQlZ1YWczdGxUM040VUtE?=
 =?utf-8?B?N01TaStRa1BIUk13alJ5My83alg0SVNoQnVQV1dOMno0b25QazZpU2tXaWlG?=
 =?utf-8?B?MWIyZ2V1QjMzS1NjMWhTbEV1K0VUb3A4c3FkeVBzY1pvWXQ2K0N0cmhwUXN3?=
 =?utf-8?B?TnVScDNhaDlCc2pXd3IrRnIzdVJ5ZHFna2ZQd2locUpYVFdWajlvVE9SSW90?=
 =?utf-8?B?UHp5akdVVU1JVU91MHcrS1lpSldyWWZwT0JNNk1ocTFLNzJ2U3N5VHA0QlBu?=
 =?utf-8?B?OWdXb00waURxa2lENGhBUG5oUVE4UG9Mc3IrSVAxTGlOZkxvSEsrZ3Q0SGkz?=
 =?utf-8?B?TFNnNmd6eW81T3lMRWRoZWk4QmFKMmNKYllpRVBqdjBkNFNVQUNtRXpEd3Fs?=
 =?utf-8?B?NEFGV1d3ajJHS3cyZ3NiR0s0ZGpyaWNPSkgzdWNsSUdYUUpac3hZa0ZGY09B?=
 =?utf-8?B?RmJxMmswR3dSYm9zY2tSWDk1azlHa1lQZGdac2hSSnhQSVQ0eTA5MTdRSElE?=
 =?utf-8?B?RFJVZVRLTEdkQ25udjd6U1d1V3RsdmhwNHFEVGFMMXAvYVhBM1lHanVVejMz?=
 =?utf-8?B?R2VLaWJIV2lEb3o3Q01xSDdYWWNkSCtLSnJHK2puSENnM0kwL004RFJPK2dE?=
 =?utf-8?B?NG9yQlZEZmlMYm4rNTk4QUxZYlNrejJDZDBoODd4TXhyaHNZN3Rla2VOeTlT?=
 =?utf-8?B?Y0FZdlhjVlBQQ1JrWVNGK3J3dGNRMnFWdnpRRHhINE50YU0vakhvcFpyeTEw?=
 =?utf-8?B?WEZjbTJNUkJpMU50anhlWG9kTkpEUGRkakFaYmpnTGlzTHZQdmNXZmRUckJ0?=
 =?utf-8?B?N0thZ3pUcFBiYW5hWkRYek9ObVAvKzF3OEhDY0FXSEhIdzgxbzZqUnhxQm1w?=
 =?utf-8?B?dFN1UXM5SWIrVWxDL0h1QUEvbjlmNm9ZalFOa0JYV081TnF5d1UyN0FsaWcv?=
 =?utf-8?B?NjN6bE05NExFRjM0aWZMWXIzaUJhcDFYVnpOdVBjZE9YZUlCN1dXVFkzUXlC?=
 =?utf-8?B?SzE5RXZRNERMcTkvejlHNmFhajA4RkpaQnFPa3lyZzZqRlRwUCtKMDV5SGdz?=
 =?utf-8?Q?PqluVGBI4A4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0JOWUFqR0tib0ZJNUp5ODZwQzBtQVQ5a2tNMEJMbU5XZmtoSGNnT2liRDJD?=
 =?utf-8?B?Q2lKRkZ5Umh2OHdWMHRkMG1qZ3JxWXZub0pvQzhPak84UFRhdmt2NkVpbGpu?=
 =?utf-8?B?UFpkeFNuWFpYTDUyUSt5WnNZUVNFTnhzN25JRGQ4UHREN015TmdJRXNUem1Z?=
 =?utf-8?B?TlNTZmJRVHBOUGVyNENVZGJkZUloOVhSWjlPMTBSM081MnJ2NEJTWGlsYkFX?=
 =?utf-8?B?WWk1Z21ybWdudm80MWkrOEpTV3dqYWpHTEJnWkg1dVc2blAyd1lHN2pTUTBK?=
 =?utf-8?B?WEMzTnNUcElGQy9NR1I2L1BKMEU2bHBXMnZVdkJFUndqcXlTd2VZNTIxc2pk?=
 =?utf-8?B?T2g5T015YzA1T0VZOUFqUit2NnZHYWc5cEFBSWlKendCT3ZrbjZtRWZiNUpL?=
 =?utf-8?B?aFJDamR5YXllREd4eFBTOHlJcDNQY1dSbWpoamlJdkxCcldIKy8zL2JzeWtN?=
 =?utf-8?B?dmRWT2ZrL0ZvTkhnQ01uYnYvdHhkUXptVG5Fb1pYNE9GK3poYWVFbmMrZzZX?=
 =?utf-8?B?RjhxamtVOUJRQWhYekR5R1luSmtxOWRXMkcxUzlvdnZmR1AwYk1iaTRXNTBv?=
 =?utf-8?B?OERlVW5xcWpXd1RGSVJwaGhDZ25UaDlqakttclVycXl6VTAzV3FnWnBXZ1Iw?=
 =?utf-8?B?ZDNaWHhiaSthbTM0QThkR1Q1OUtUczgrMnpoNGl5bUVQbm9MbWNjRWxhdUlB?=
 =?utf-8?B?d05lNDBpd3I5STNETVVRcUpMcHF6MExvQ0o4aksxUHhDWEpjcW91VGlTOU02?=
 =?utf-8?B?VGZkMzRsRllOMmh2UVNwM3dqZGIyNDZLaHVLckVJdkdIL2paZytjQ1Y0SGRx?=
 =?utf-8?B?c291VWlESjlKeHQ3cjZWdGl6dExaNVlOcmtuV3dUYzVkc3pYRHRKOEQrd3lw?=
 =?utf-8?B?SFd0ZzZ0bk1nUTIyS2gwTWxpZUtXQ2QxSTMvNXhjYVJyRWZ5TUJ6Y1BhcHdR?=
 =?utf-8?B?OCtrUk5OeDluZm5sVDAxUmVxaWIyMUlzZENqRFB1VWQxYlM1WVNQNWE2NFpI?=
 =?utf-8?B?T2ZabExpcFFpZzU1c2ZGc1U0aHR5L1U5TlFubkJBTUZ0dkRZUlpMRE5vV084?=
 =?utf-8?B?MytsMU52OHJMTE1aZWtCN0s3dVBtcXNJMUw0RFE0OVRqdWF0UUFvY09uRkwr?=
 =?utf-8?B?U1hZZDQ5ZjlZM3FHRzd0SC80bnc4NXRCaVJFUGh0bjdwRHNNeTA2amVCaldR?=
 =?utf-8?B?UFZzMnBWR3R5R25wTDlNRks2cGRNZGU0R3hPS2pBUEp3VGdrZDVqcVY4NzRv?=
 =?utf-8?B?bEJaZnlNS3M4bS9ySmk3bUJUdmxJR3g0eC9RYWxrNmlMSUk1NnhQQ09NenNL?=
 =?utf-8?B?V0d2STR2d2VuTzBRdHllS0NDQ0JIUjdrdWVLTWx0R3BoV2FYcmZjU2RDUlhs?=
 =?utf-8?B?OWlWTmlDczhpQUowL2RZdFB3ZU5EMzNXSnljdmdsSDZWOWxrYjRYVHV4aWIy?=
 =?utf-8?B?amVkRlU5N2ZQZVFyNnVaNnloMEJmSCt2Q2p1d0pQK0FjNEFLOW5tZXA4R3lr?=
 =?utf-8?B?M09mS0FzYUJlNG4zVWNIbldwYnlnTmVHUmRCbGcxMjh2Q296U1BVYUxEd0N6?=
 =?utf-8?B?NzZna3dza1Y4K1FUN0VzOExIbFJ6VGtZQkR5OVZsNXZzRFhQNVFFYjlCV2x5?=
 =?utf-8?B?NFVyV0toNkZoQWRES015azJHZWxsYVJyODZMbWhlTXVVdXU0ZVBqeUwvR0po?=
 =?utf-8?B?aE5JVGRLQjg1bVhUTVlCZ3lmR2xQSzdSRWlZT2w2eW1WcW9GMDZ6bDlDTW56?=
 =?utf-8?B?b0dDR2JQUFVqS1F4UnBQeGh1NTY5WXRmSmZwTWlVbnA5VWw2dHlFTTYzTUdp?=
 =?utf-8?B?ckM4N0ZvclVCMTA3K0kyZTI4QmE1QlFlb0pDam40bTRSbmRHbTRIOVcwMHlJ?=
 =?utf-8?B?cDZabjJzZmpzRnJXeTVwcndKOFZaRnZMZS95TjdIVXBWSGh3czY4Q0wvcXVK?=
 =?utf-8?B?R29KUWQvOFFzQUNUNCttU3RqSExxYjF0RDNqZSs5V1czQkZEc3FVZjh2YW9l?=
 =?utf-8?B?ZXVoS1I5dzM3clZWYUVFOEtQQlRtbENSU2UxN2tSbXhKOVhIcE13dHJGb1FM?=
 =?utf-8?B?TUk4clQzWjZCTTUrajVFTnN5UW9WOCtWUHBTR28zeksxUlhsZG1qeHFRREwz?=
 =?utf-8?B?Vm9GcEtaYW1hajZIMWJ5UmI3RUIrUlNTVjhHZlk0dm9Vd1VYQU5qKzBlakg3?=
 =?utf-8?B?Wmc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa23d769-ed11-4419-c03e-08dd99e9add4
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 11:05:08.1382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7DM4IlsrX/tRa4NkoFyGWmCp3/2pVH6+Ad1dfDDGVvnDnIrM8+93NtGDzRGpgv47x0Dz6zQF+jqohzMmK/jsuxmZxnqQigg2wQGfQtSC1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5504
Received-SPF: pass client-ip=40.107.241.98;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR02-VI1-obe.outbound.protection.outlook.com
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

On 5/22/25 9:44 PM, Eric Blake wrote:
> On Thu, May 22, 2025 at 08:38:34PM +0300, Andrey Drobyshev wrote:
>> On 4/28/25 9:46 PM, Eric Blake wrote:
>>> From: "Richard W.M. Jones" <rjones@redhat.com>
>>>
>>> Add multi-conn option to the NBD client.  This commit just adds the
>>> option, it is not functional.
>>>
>>> Setting this to a value > 1 permits multiple connections to the NBD
>>> server; a typical value might be 4.  The default is 1, meaning only a
>>> single connection is made.  If the NBD server does not advertise that
>>> it is safe for multi-conn then this setting is forced to 1.
>>>
>>> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
>>> [eblake: also expose it through QMP]
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
>>>  qapi/block-core.json |  8 +++++++-
>>>  block/nbd.c          | 24 ++++++++++++++++++++++++
>>>  2 files changed, 31 insertions(+), 1 deletion(-)
>>>
>>
>> Pardon my nitpicking, but it seems to me that the name "multi-conn"
>> doesn't really suggest "number of simultaneous NBD client connections",
>> especially when similarly named NBD_FLAG_CAN_MULTI_CONN_BIT represents
>> binary logic: supported or not supported.  Maybe smth like
>> "multi_conns_num" would be better? Or anything else as long as it's
>> clear it's an int, not bool.
> 
> Maybe 'max-multi-conn-clients', since it is something that even if the
> user sets it to larger than 1 but the server doesn't advertise the
> bit, then we silently restrict to one client.
> 
>>> @@ -1895,6 +1906,10 @@ static int nbd_process_options(BlockDriverState *bs, QDict *options,
>>>
>>>      s->reconnect_delay = qemu_opt_get_number(opts, "reconnect-delay", 0);
>>>      s->open_timeout = qemu_opt_get_number(opts, "open-timeout", 0);
>>> +    s->multi_conn = qemu_opt_get_number(opts, "multi-conn", 1);
>>> +    if (s->multi_conn > MAX_MULTI_CONN) {
>>> +        s->multi_conn = MAX_MULTI_CONN;
>>> +    }
>>>
>>
>> I agree with Markus that this setting value different from what's been
>> directly requested by user shouldn't go silent.  Having some kind of
>> warning at the very least would be nice.
> 
> Okay, I'll make sure to warn if it exceeds the compile-time max.
> 
>>
>>>      ret = 0;
>>>
>>> @@ -1949,6 +1964,15 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
>>>
>>>      nbd_client_connection_enable_retry(s->conn);
>>>
>>> +    /*
>>> +     * We set s->multi_conn in nbd_process_options above, but now that
>>> +     * we have connected if the server doesn't advertise that it is
>>> +     * safe for multi-conn, force it to 1.
>>> +     */
>>> +    if (!(s->info.flags & NBD_FLAG_CAN_MULTI_CONN)) {
>>> +        s->multi_conn = 1;
>>> +    }
>>
>> Same here.
> 
> Here, I disagree.  But that's where better naming comes into play: if
> there is 'max-' in the name, then the user should not be surprised if
> they don't actually achieve the max (because the server lacked
> support).  On the other hand, I could see how you might want to know
> if you have a mismatched setup ("I think the server SHOULD be
> supporting multi-conn, so I request multiple clients, and I want to be
> informed if my expectations were not met because then I know to go
> reconfigure the server").  Thoughts?
> 

Doesn't the "max-" part suggest that there might be anything in between
[1..N]?  When in reality it's either of {1, min(N, MAX_MULTI_CONN)}.
But you're right, my initial argument was that this mismatch shouldn't
go unnoticed as well.  Although I agree that it's part of the expected
behavior and therefore might not deserve a warning.  Maybe smth like
info_report() will do?  We might even print it unconditionally, so that
there's always a way to tell the actual number of connections chosen.
Somewhat similar to what Richard pointed out at in nbdcopy.

Andrey

