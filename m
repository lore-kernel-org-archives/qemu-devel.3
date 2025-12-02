Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7A7D1170E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQTPA-0008AQ-7d; Tue, 02 Dec 2025 11:39:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vQTP4-000891-01
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:39:03 -0500
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vQTP2-0000mE-AB
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:39:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jp4Xi1ht98x8zdSBWwJBJaaJmk5W0FIPj+PLPPBqvPW9ZT5Q1w8PgZQYSzIJg39UgTwnn+dKBNSAXqeFHS08r3Ehc2C5Rg2SLfV2N7zlMVTc+K6+SiVqZWgWPp9A4PYeyPu0b65gsnnwxzOPqUu13V/AQa/nFA/RglD7zhkmxAt/OouabtZVlvq+a7TUfAUh1AOCwg2ww3Vxl5I6e+Ju9rLbv36n5xo47aZ0IQyL3GakLIvOCbEWZtAa71485/jQQdwDhDyrW0hsmVFlDeRsQmK3+zL9v7fywyQ70/LZYE8YC9p15GbPZyNcDDt93Ch2fHZmlO+Yb1Tm0SDsu+xoSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bxTCZGlml7NHK+FSBZeRLmiHL6fTWQoEDzJIIOoww4=;
 b=Qa0eDWSaLQaFWpFO4B67udd47RGyoRTbZD9hoybmDPMeq1660r13BrxIv9am5YEfgOAkjNWoODXW++XTQv7HMt2w0cABbY/XeacIJCuPNnmxN3nFHnUZK4H5Wit2P9h/9Y7H3ExOKBvBJ6LZaBt8neNcrk1w5Ixq7RLi+4sj67P0Fj/4bcjqRRne4CCTuETdzIzaaAFV4ZQQcO6rQ1SDqJG2r0CpMiOH3xswtMpm9d0ccC9DTzrDGgOPMu2WY/cbhNJYJRkMK/nDAtemVLhT4XjzCLpfPJC8FnE/7jKSe0Jfa07HheIcI2Bz7M6GL/944zM0A5dv/Joz7saYwk+OuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bxTCZGlml7NHK+FSBZeRLmiHL6fTWQoEDzJIIOoww4=;
 b=qMdHsDvqt//ikvLfDOGZlxHI8yihH/y/p/Bb9Dsy1DHVC6xzqYmYKf9gLYehdoC+aPuhfjqFmU8j53WzclmPfOj/N+scE1r41/KjRYjqAofPZpyjc0cO2DHl2sDUzD1XlqAzeJqck8jVz+9iMHmc3d75xyOyFELSsZ3iyeafxFTyvfguK6gS0zSshzqwHNZipoPdhnD+QKt69B5saIQmGM8qgM4u84NVDa19bb/f/YFAGV4bTLqLqN1o6E0TQfPffriHWjbFOxE2neW0IXT7rxasySCvRQFkCRRF0eQASJWPViUGIopAcCAwIn9yzb8StKZRBxcFdGdU95e+QmgXiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS2PR08MB9391.eurprd08.prod.outlook.com
 (2603:10a6:20b:595::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 16:38:57 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%3]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 16:38:57 +0000
Message-ID: <be8c7562-0206-4209-84f8-64db3307d53d@virtuozzo.com>
Date: Tue, 2 Dec 2025 18:36:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] scripts/qemugdb: coroutine: Add option for obtaining
 detailed trace in coredump
To: Kevin Wolf <kwolf@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, peterx@redhat.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, den@virtuozzo.com
References: <20251125142105.448289-1-andrey.drobyshev@virtuozzo.com>
 <20251125142105.448289-5-andrey.drobyshev@virtuozzo.com>
 <aSggPDzhqem_jxnR@redhat.com> <aSghvhrBXL0xxL1a@redhat.com>
 <ef51cf63-16b1-48c4-8070-0acaf618ef3c@virtuozzo.com>
 <aSh-1_qLRNGCzV9H@redhat.com>
 <ce8c9c03-5dfe-4f0f-8394-e9ba95f0f09a@virtuozzo.com>
 <aSmhGomQvDyiQ57z@redhat.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <aSmhGomQvDyiQ57z@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0223.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::16) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS2PR08MB9391:EE_
X-MS-Office365-Filtering-Correlation-Id: 7260586e-4d25-439f-511c-08de31c149b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1VneWxReFFzNm5ZdVB0NHVrL2ExVlNTc29sVkdiZHM3ejI2cG1kcFFjT0FZ?=
 =?utf-8?B?VDNQWlRkaTdkMzFHNno0cmgvK0dZaDBvYmp0MWtTMkMzdlpDZ1gwSkVFaDRo?=
 =?utf-8?B?YlZrVGVnZkh5VHVpME5TUEh0ZForVDNOaC92UU9oY0M0Z1N6SDZ6Zkx4aSsr?=
 =?utf-8?B?eTU2dml3dmhna3NVZ3grRWVrOHhwZkdKTUw2YjduK0FTdGpBbnFDZmh6ZldN?=
 =?utf-8?B?QUlsRzN6MTFIVmphTlJLRXZvUFdvZWZyb0tvWGpiN09jU0syRXJSaFB6K1My?=
 =?utf-8?B?dUk5OXZJeDB0SHVNNEIrckdHc2tLRmdVRmI0ZGlHclpDaEkxMGdkOEVBMm52?=
 =?utf-8?B?eE1HUGxJNm1XOVNvUGFtU3F2cnk0VUtLckcxV2FVZmluVnBwL1Q0YXMvWFd2?=
 =?utf-8?B?SEdDR1ZjY29mTFN5MDg1TVpTeXV5K25xMFZBSWZWQndlZklxUFBPd3NCcnJu?=
 =?utf-8?B?Tm9hZUg2dkN4dGl5RGFyeDJZeTdUQXJxcjdyMDlSVW5nUTVjelY1T1N1Ymc1?=
 =?utf-8?B?YmJESG9kaGpGZE5UWUtuY2RFZitqd3g0ZitRdHc5aEwwSnZ1bzQ3L2VOUDMz?=
 =?utf-8?B?cHNSMXBCY05Mc21EbHB2T3JqbDdVUTBCUkV6ekhUNk5MdDd0SU91VFdIR0ho?=
 =?utf-8?B?RDk4aXloeXVuaGNuQWYrazNvZWNnOXZ6amtHNVFqZmZLb1dFTFZqUVFMc2Nt?=
 =?utf-8?B?dlVyWUsyaThWNXpXM0Z4RndyUG9aWHRrRG9jeXlWR1lWQms3dEZhYiswTHZM?=
 =?utf-8?B?ZVR3QU10L09RWk1DNmc1WEZaMStPNnQxRmZJY3NoNXU1NFN2UmJaRnlMNVhP?=
 =?utf-8?B?cTVuc3hSQ01IUXRiMElmMXBPREFIbVhKZ2kycnAyQ0pkK2FrRDdOL3JRSkZV?=
 =?utf-8?B?Nk9EUzhjWlVsckxkRU1ndEV2R3hLTzlOZWN2NjhzWko4UTc1akl4NEdYODhz?=
 =?utf-8?B?RFY0WTBCRnBLcEZhcUVLdU1Fb3kzRjI3RG9SbzJ3UWIvV1FFWWZJdVplU2FZ?=
 =?utf-8?B?UTlxdGh3NWc5L2JsNzJzYUlWUTh1Tzc3UXdGTmhaa1NGQVZWbzAvMFF0SzJy?=
 =?utf-8?B?OFRFbDdMcFk2Uy9UZG1WYXJ0dHFFVnN5RDkrWDkzUWhwMlFLYUpiQUo4dWV0?=
 =?utf-8?B?OHQ0aGJKNTRHN3FOeW81bkNRYnVxTmlicHBTYmVBdTdEYUxqZXAxT0FQVmdR?=
 =?utf-8?B?ZHcwQTFZOUxMbTJabTlBejI0NjRXQ3VrcFhHNVhTTi9ucVJpM0FHenlFeHJo?=
 =?utf-8?B?ZU5tMkUrL2NMK21HODRXbWhkUnUzb1RYZGM1TDVIUThaSnVQdVhTYldNWkI3?=
 =?utf-8?B?UFdteXdQaFQ3RTRnbVd4UDBlMjRLdGRHQW42UXlzVnhTcmZrWklFNjVUaWlw?=
 =?utf-8?B?YkpBUkpiNENZVzNHWStsVWZyZ0FzMFYwNjVIWW5ySFhPa3FwN1ppZzFsMEk5?=
 =?utf-8?B?RjhaRW9nWjZ6dHViZGx2dU5YSlhIeU4zT0ViQ2xoMS9abHRlTDFaQU01b3VI?=
 =?utf-8?B?RWRVa1oxU2xJd0hCQXYzdXNzQlkwZUpQYUFQVTR0TFRFRE82ZEVaaWM1aVAr?=
 =?utf-8?B?S1hpOHBlWHY5Q1dFMVluZjNtWWRLZHljMFdRQTdpaTFTRkJMdTEzMWY3eDJM?=
 =?utf-8?B?N1Z6R0FkOHVZVmxhM1BjZjg3SXZQdDMveng5RUorNnJrUzBtRjJmVzNZRzBo?=
 =?utf-8?B?ZXlpVWlDemplSE9QWGNEcmwydUtBelJkNHNZcFJObFFrQlprelZ5TDIxOXVv?=
 =?utf-8?B?U2ozdG1pK0U1UHdHQkUrbUd6V21HS3NpMVFsYlRtSkdIL1EyYWdsNnRNam5h?=
 =?utf-8?B?VWRYL3pENFR5UUxxNm8rRjJ1VHhZbk0yTmdFQmZjdEhwYkJ3YnlQRzhYMTlY?=
 =?utf-8?B?dGhJeE1oZjhkdG5aN3JVZUIzdVBIN0drdWoxT0NLV0VLbnkzRml2NTN4RDNS?=
 =?utf-8?Q?44CnQ+ULCea10DTG5/+9fvLi4VC3FHrE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGZtOE4wOWQ0SlI0bGsyWFBkcGxNZHZITjFjcXdhN25Md0NCSitsOHU2M2N6?=
 =?utf-8?B?YnpKNGZ3NVBCTVcvRWFiN3VCSjc4OFBIcWRIU3ZuQWFXNUhmS2x3UmpIem9R?=
 =?utf-8?B?NG1QRnNjUGU5d3lCamZwUHI0MEV3Y0g2aEhLemxKWm9rTER0NnkvSVlmZkVz?=
 =?utf-8?B?UGpPRUJtanNJbVdSQTB2TEpJNVVXTVpScFFPNVpxYmNCTndaZFBXcWNKUUY3?=
 =?utf-8?B?S2lkbkx0TEY4aU55dk03QnVDd0t2Z2llcTJoYXJTN1pRMlJXTTRDOWozMUxE?=
 =?utf-8?B?QVRCWk1RNlQrZHBYUXh3TXNWSjhZYlYrMXhKbTZMZ3BZM0F4TW1MQWkrQlZN?=
 =?utf-8?B?aHFYdmVuYVFKRnhxdzJnZGtqWFZOOXpidFRkV1g5aUUwRStURDd4RGhSMWJl?=
 =?utf-8?B?UTFzdndPUnlUREVQZnZMTy9zeWVzRzV6em1PaU5DOVB3bUl2WDNmSFIzMWN5?=
 =?utf-8?B?b1hhaDJFV0Y1dkZnMExXZHVkWXRrWCtDcFF4S0lWQ3owdGlMV0d6U3FOWVNG?=
 =?utf-8?B?dzlRbnBXRGoyLzFtekgvTVpNWlFVT0ZtUmFhY0UxQTRpZkdvc1UwWjZMMWln?=
 =?utf-8?B?c2R1VWI4ekFVa3lRR2hMeU1vZVVYZVdhUUtUVTNWTStFQW9KRGl1WVRFdkdV?=
 =?utf-8?B?TWUwditoVmM1M3k5MHI4dVcwcHY3emNSL0V6WU0yMDU2QTNLSHkraXFjQm1R?=
 =?utf-8?B?UzUycFpWZzlnbkhqb0F3TG8zSWl6OGswczgwQXF3bElGdUpnQzRuQXZXWnRE?=
 =?utf-8?B?RElodzRiSk5zdHd5dllaT1pWZURyaWVsRHhNckw1VjZnTnBjQ253c0Y0K1Ex?=
 =?utf-8?B?bmZ0QzZpcUh3aEIrUldtY3VFMWdZVjZ3a21pL3NDRHNvNWpBdUdKZklkdjVR?=
 =?utf-8?B?TXdGSEVWeTEzajViTmwzUzVteDRUSDd1NzI2Nmlkaks5a1VYK1k3a01yZVB2?=
 =?utf-8?B?SDV5b0tTcFFySHprYmd4ZmNTQURZbG9HZWVCeU9yN3JPUEJGeGU1RjdqSnFF?=
 =?utf-8?B?NzNPZFFJU3V2RlhqcENtbUpKSHlqSkRIOFdOWHlodThVM2kxNUtoV0pDdmdB?=
 =?utf-8?B?NXA5WURCNzhlOFhhUXZDUEdNRHdiYkpxNURvV0VaR01TQ0NxRVBnOVI3bmhi?=
 =?utf-8?B?bUx6YU9CS08zdHZhQlN4TldUYzB4TmI4RCtvRCttaG9pbjBuZy9sNHRqanA2?=
 =?utf-8?B?cHZXRm43RCtLdk9Cc3BWWENqQjJXRVJlRk8wd2VIRnR1YUNtRlNmQVBJdFhX?=
 =?utf-8?B?TG82RXFZY0VuYXIxYWphWVlWaW9RYmN2eWU5QWZ0cER3ZGg2Y0JSQklVOCt3?=
 =?utf-8?B?dVpGL2Rsajc1MCtGMWV3NjZ6ZG9NQUcwd0djQnRuSXFDejdjOHl3YzkwdUFh?=
 =?utf-8?B?aEczbVJOYk9HczRicmM1QWt6UmtoNTMrMnpGanVFdVl3aWY0ZkJVM3QxMDRl?=
 =?utf-8?B?UjJ1NUd0YUpZc25jWmN4OTlLeTkxVG4zMis4YTZ3allURGp4eGNxVU5iTUhC?=
 =?utf-8?B?SmdtcmdPUWNOYlJxano4aVZRSW9kS2htcEV0eC9TWXUwMTJ2Mjg5MWRRaHNq?=
 =?utf-8?B?Z0pFcmJhWEFCY0FweGlvL2RhYklCRmwzdFgyblFvdmtZVDBLNUEyeS92S2c5?=
 =?utf-8?B?d2IwNWpoL1JBeUlYRHR5RjBQQWM5eENXNWdlelBUZE42eFByR05TWjZFdjdG?=
 =?utf-8?B?UTZXV0ZJQm1IZ09RbEpmbHFjdG5VSy9xNVVQc3p3T2ppU2tRalNWYTFwSlA0?=
 =?utf-8?B?VzNXa09uL0xqKzVOL0pyU24veW91YWExL05qTi9qbEVRYWpySlVDbnpUTVh4?=
 =?utf-8?B?ZzhTZjNXZk0rdkdvOWV6QVA2REhiOXBITHlGb2dKemx6dVBHS1Bvb2pYTXBR?=
 =?utf-8?B?NmVqZnhIVC9lc2pwYjIxQTA3RitDVHFQdXh1MjhzdXhpWEFadjBMREkrdm53?=
 =?utf-8?B?dWE1WWRVckVyd0g4eEtDUDlieFNoTTJJdHc5T3IvN2JwWFpEeVlIWFc2azVi?=
 =?utf-8?B?N0NWdUZKZGJqZUxRdUEzRzZDVldldHdudHJ3WnlpQWtSL1ZEcFJ4cEJPaW1Z?=
 =?utf-8?B?YldJbGdPczJ5TVlxZGd0THFUU2Q1eGFnSjJiam1ra2ZYZWJydVdaU2FTZnRE?=
 =?utf-8?B?bFZQM0xuRCtSQUxUbTMwTytxY0xuQmVteFVnbkhSOEkvMHBLaU1CUWo0RWtR?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7260586e-4d25-439f-511c-08de31c149b6
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 16:38:57.0349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vDcK555LknAWPiGASfJ93+TYvxePpAOv4kGQNk6da9OcUM3B1ovc2sX6vggnoenD0h9y4Jok/gRrMR6NRUP3PU+gm7mWcv2Pf4sIAuULtVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9391
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

On 11/28/25 3:18 PM, Kevin Wolf wrote:
> Am 28.11.2025 um 13:24 hat Andrey Drobyshev geschrieben:
>> On 11/27/25 6:39 PM, Kevin Wolf wrote:
>>> Am 27.11.2025 um 15:31 hat Andrey Drobyshev geschrieben:
>>>> As for reflink copy, this might've been a great solution.  However, it
>>>> would largely depend on the FS used.  E.g. in my system coredumpctl
>>>> places uncompressed coredump at /var/tmp, which is mounted as ext4.  And
>>>> in this case:
>>>>
>>>> # cp --reflink /var/tmp/coredump-MQCZQc /root
>>>> cp: failed to clone '/root/coredump-MQCZQc' from
>>>> '/var/tmp/coredump-MQCZQc': Invalid cross-device link
>>>>
>>>> # cp --reflink /var/tmp/coredump-MQCZQc /var/tmp/coredump.ref
>>>> cp: failed to clone '/var/tmp/coredump.ref' from
>>>> '/var/tmp/coredump-MQCZQc': Operation not supported
>>>>
>>>> Apparently, ext4 doesn't support reflink copy. xfs and btrfs do.  But I
>>>> guess our implementation better be FS-agnostic.
>>>
>>> Yes, we might still need a slow copy fallback for those filesystems,
>>> i.e. essentially a 'cp --reflink=auto'. For myself, coredumps will
>>> generally live on XFS, so I would benefit from creating that copy in the
>>> same filesystem where the coredump lives, and for you it shouldn't hurt
>>> at least.
>>>
>>> Another thought... it's a bit crazy, but... we're QEMU, we have our own
>>> tools for this. We could create a qcow2 overlay for the coredump and
>>> export it using FUSE! :-D (Probably not very practical because you need
>>> the right paths for the binaries, but I had to mention it.)
>>>
>>> Kevin
>>
>> We can surely add reflink copying as a fast path option which we try
>> first.  That's cheap to implement.  The real issue is designing a
>> sensible fallback approach.
> 
> I mean, as far as I am concerned, you can keep what you already have as
> the fallback approach. Reflink copy if possible, and otherwise a slow
> full copy.
> 
> Or if the coredump can be written to, you could do the in-place editing,
> though I would save the original content in a file that could survive a
> crash. And after finishing the operation, the original content
> definitely should be written back.
> 

I decided to go with the latter approach as it's more universal.
In-place modifying doesn't take as much time, so performance difference
with reflink shouldn't be a problem.  I've sent v2 with an implementation.

>> As for creating an overlay... That's an interesting option but it would
>> require everybody who wants to use this stuff configure their QEMU build
>> with --enable-fuse.  We, for instance, don't have it enabled in our
>> builds, as I'm sure many others.
>>
>> Of course we can think of an NBD export for such an overlay instead of
>> FUSE.  But it'll then require root user to write to /dev/nbd0.  Also not
>> very acceptable.
>>
>> Quick overlayfs mount with lowerdir=/var/tmp could also solve this.  But
>> again, root is required.  Not good.
>>
>> So the most robust option, I guess, is the one suggested by Daniel:
>> copying some kind of minimal viable coredump part/range instead of the
>> whole file, which is just enough for producing valid backtrace.  The
>> only thing left is figuring out which part to copy.  That might require
>> some tricky ELF structure parsing.
> 
> All of these solutions are interesting, but honestly feel a bit too
> complex for a simple debugging script.
> 
> Kevin
> 


