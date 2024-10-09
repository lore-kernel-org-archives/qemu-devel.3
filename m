Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 047D0CEDDA4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 14:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syY4r-0003Zy-PY; Wed, 09 Oct 2024 10:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1syY4p-0003Zl-IX; Wed, 09 Oct 2024 10:54:11 -0400
Received: from mail-am6eur05on2072b.outbound.protection.outlook.com
 ([2a01:111:f403:2612::72b]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1syY4m-0006Oq-89; Wed, 09 Oct 2024 10:54:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0k9CALZd/4XHynXwJ2Wa0/iPSIBokYP6Ug2V1Ns+izTQQzi6lWcMUPviTsCKLmpcfjM3l1O0vJHw8GsmZqJJd46viog5ad5wmp1R1IkfUnnMn1zIILEG6h35AQiKnkPQFWdLgLdOHd3zyaL7CXOrE2Q0xrtldpPAkr/cv+gs68Zemg25f1W4kiQKsCGRjrSrkJd3dVyB2T/JPcIx6WSQfGrTwDDz4/CyurJTBcpjyUBIbdzUFwZmudikFRxnxAtjZKbFUfYL5dSEorV24ar8P1f5vI4jwFxb67W29NXWL/H+Q9khLIgKANwLVAn7bAxSwaxWUFNEF8NYZWefQgNjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nneuOI3Fet7GtwrMBHJWALuu+hw1N4gG/z9V3/IHOuk=;
 b=kSmxa4y4D6rDBK53IcuezyuXCjPpUMi2v5HqJ6WOLwueHQPPBsGQaSgBphzpxgbfFlo3/SdYekfRwY0SNS8tOu0HL1KQw7D13ixk7tX0Tq6Fw/FVGBawOIT6vIDVpLEVOhwuNqUIegw04BnYUwWwGwLYWwGTGHnVQRGoNOyqdvUWaDkONE+LHF1s674VrSzRIDxoO+eonWTZhDeyzNyxPD2Byh/G+AvJaq0gJ9XrYp8xglXfl+la/Fvi8LL5F3GWrrPJgKZi8Wg9mxPQgMRG0uC3PUQGA/2Z0vm6fj778ty3CaFnHwtvR+S9kWLg/oaMg3rM2AVpddBRQz55ALlzpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nneuOI3Fet7GtwrMBHJWALuu+hw1N4gG/z9V3/IHOuk=;
 b=AvdYy9kLvoqRzzCTK9VKTC/fhh4P6FwQ6MUL7wcuq5xEHdhCiLEyO5+BRuRmJstfQVxXIxTP74k/KcCcv+KD4MZ9JbdkSgVbk6yoWuSd9ilHDEzM0+0b79i6oi5vizyZTZL0Z7+gMwQ5gvxVlHDrIacBE6RHsUY1Xuvl1nLrqIdDIT7WCH6wiFtjpYBv5uLwQ123W5H0Cw2tIwibwab+TBg4pzik3h1+nVXPXerT1yzLWl+dWZPO8yHZWU2dILBHCM3gMgt3Q+rs/XQ3tHPV6GK7DU0sMUx6x5zMrCvYQBWa6/Q/88vUkaggp3b769CnAD9BDL7/RR/LAg3ZXarukQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAVPR08MB9882.eurprd08.prod.outlook.com
 (2603:10a6:102:32a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 14:53:34 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%4]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 14:53:34 +0000
Message-ID: <9167b2bf-723f-4ad0-a525-8776ad9e69c3@virtuozzo.com>
Date: Wed, 9 Oct 2024 17:54:53 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block/preallocate: fix image truncation logic
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>
References: <20241009140051.771660-1-den@openvz.org>
 <20241009140051.771660-3-den@openvz.org>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20241009140051.771660-3-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAVPR08MB9882:EE_
X-MS-Office365-Filtering-Correlation-Id: d2e12086-9de8-4797-e155-08dce8722606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGI4MUhNUVdsV1AvMjF6OFZPalhBek54SXgxbjlkU2VXSnVWMEhlVzhYWVBS?=
 =?utf-8?B?QlNMSmo1aCs3S3FUN3ZsNUFaNzFTN2xHSWtaNUtLRmhkbzUrZHlHZHdyZEJa?=
 =?utf-8?B?Wi9XNmVSMHRHaHY4ejBMTXBqK2RFaHlPQ04xVG16ZVRPYmJUQldkUll3c01C?=
 =?utf-8?B?WCt6VEgyVDFBdFFCVnlpWDg2L3QzSDdWdFAvbzV4dCtJVklwdjU2WVZyWnRC?=
 =?utf-8?B?bXIxZVlHa0lwVHF6N05qdWtPYmlpVU1xNmM5MkM4NzF5QzZlMG83eG04OGti?=
 =?utf-8?B?dFdnbmJpbzJEWUtFWVpTbUZldWlaMDhndWZtQ1BiWTdBdWJMSktqWFFibEQ3?=
 =?utf-8?B?dlR0amVEMWM0Y2dSbHA0ZkhMYnBwNUd3a0dLRjJRellzS1k3RVJkdy9YQ1k3?=
 =?utf-8?B?Tk8raytsbGh2MU9qeFZ6akVkKytSdjJZTjIrU1RmbXZhYmF3NWNlY2g2SkVD?=
 =?utf-8?B?MGhnSThwQ09OejJpRWkyRStTczU3MmFtbEJGQ0dacW53VVJ6am85NlFLZFgz?=
 =?utf-8?B?c0tKemNRV1FXbC9FQ1ZpaGdyUzhtdTFUR2hlbXhQSHhCRW91Q2EzRThBVG9B?=
 =?utf-8?B?SEdmandybENFKzRobkVpd0s0cy9sdUpUN1JZSnFFZGY2eFB1bk9WQ05DMlBU?=
 =?utf-8?B?aFdWRnVLNkdFOHY5Tlh6VHQ2dWppSG1WU3J2d3RDcGdpdldva0d6blh6WWkr?=
 =?utf-8?B?b0hjZExBNThvenRld2JlTnM1Z2YrZHZqSkZ1TkVBMjVob1Bac2QvVXY4QVJI?=
 =?utf-8?B?VmhueUVxcklkODBHZkNNTzBieEwvZHBvN1Jkdms1NVBlbWJCeUpPWDkxMVZa?=
 =?utf-8?B?ZmRqUGRJbFlYM1dJUmwrd1I4TDBWRTRQSHVxdTFvQ3NLM1BBT0dEQzUreTBY?=
 =?utf-8?B?RXlQb3cwUkZwaUlKUWJNSHBVTDJyM3Zxa3ZON1l6Sksvdm5YRk5vTXFMbkVX?=
 =?utf-8?B?b0Zud1loVmJFRjZ5a3pndzN0ajhNYXg1bVhnOVRJR291Y0gwblh1Z0tqK2tD?=
 =?utf-8?B?bEk4WU9STVJINlJ4aG9GVk9QSE5GY2lRNSttZkFLRk5zWVJVWGMwNVQ5Y0dI?=
 =?utf-8?B?am5EdmRacGRHOXBDaHhENjVJK0p0SWtYaW5QZXp3Uy8yV0JtbXFKWEZpREhu?=
 =?utf-8?B?RGJ5VWluTFFhOWx5dG1jeDFuVnU1TmFWVnlWRWpVNHZkTkxJSk4yMUdEcXMv?=
 =?utf-8?B?dTRhWEFlZ2k5NlRhMWhkWXhrMy92bG5GVm1Vd3ZaOHp4OTFpSy9tdFh1TnJ4?=
 =?utf-8?B?THFRa0N4MmtVSC9TNmFTQUYrZHU4V2tHNlViR1QxYmtuOWtsUk90Z1Q0Tm1h?=
 =?utf-8?B?azVOTXZSa29HT3h6bllRNE51dE5HYWpoU2NydjNRMlBHdlpuK2doV283K3R3?=
 =?utf-8?B?Z3dBRUhCQzRpWENXZkZpaGNkdFNPbW9aczJYUWJpM09MeDd2ODFjVmpWbGE4?=
 =?utf-8?B?akNpdnBOQnNvbUdlYVhadnJuYk5ncG80V3I1c2o0bUNsVTNnQnp4aW5zWmdY?=
 =?utf-8?B?ODBFVDhxamE1c0h2SGxRWmY1RHZUclIwZlFjRzlseHp6Y01wc2pSUzU2RXJo?=
 =?utf-8?B?aHg4OE1Xb3NoRGpRRnJ3TkVJNHNLaEtUbjU5alV6a1BMRzVXdDQwOEU2WG83?=
 =?utf-8?B?eGxlWHhOUTdzVkw5T3o3QWN2V292SkYySHRmRUN4MW96U0tzUlkxTVZJK3Rn?=
 =?utf-8?B?MjlMYW5vcVE1TjJlck1wM2hwbThYMzlsOWxKanl1Ky9iSVlicjRTNVh3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFRlblZKME9BK1N4aTFmMWRnVUx3SDRrMitNQlIrRHVYSndkc0RzeDRyN0Mx?=
 =?utf-8?B?aE9UczJnVHF5alZ3V2RyMzlHUzQ5Y0dTK3JnZWYwdzFsdDRZbXhKK2xjRlB6?=
 =?utf-8?B?dithazkxNGNKMkRvSlpBdi9WdWJVTk9LUlZ4bUNRYkhVR2tIdnZobnF6SExj?=
 =?utf-8?B?T01HcFlYVVZOMVFZK2lnTVduZVJJYVVBS21sOFNJTmQ4MCs5WG9nWnZaRWdC?=
 =?utf-8?B?ekNmTGdYellyZ3FndFhKNXpGeU96bFBFTTJJUzhqZDVxME5QdkZDZHZFMndP?=
 =?utf-8?B?dGkzRkN1UUo4dk9ZQzVWWmNOeDgvbGpBOVo4SkMrUWRaOGloNGY1VjFtcDY2?=
 =?utf-8?B?clVkWDBmNWFHb0dqM0VDYm50Y25RRmFCc2pzY1hCQmwxSmJiRlU2bmZKbWty?=
 =?utf-8?B?OXZFSVlnS1dNN0dzc0xETXNUZlp5dGtnTUduNk1XdzNaMzJHZ1VjNVAwY28z?=
 =?utf-8?B?RVBZbXBFaHZEYTVMVDIrZ09rSWRBM0tqTUs0YlN3ajErMUFrU05oWjJTTUgx?=
 =?utf-8?B?UXc3THRXYTlrK1hFK2RCRTNBS2ZWMUdvVml1dlNRU01jQUFsdnlJcUp0VlhK?=
 =?utf-8?B?dThYL2lvdWpNNFBRVlZwN3ZMZ0k1TEtwUVZDS0U0ZXdaOE5nWkxFQW00SlZt?=
 =?utf-8?B?Y1JqQVFaTWZzYW51RGdlZGxGVjlNSnlwWXQwcy9xMnFUOUhkQXZmaHhLZis4?=
 =?utf-8?B?bklPdGZzek9MMFpzM2tQY1NBL0UvUkRRV041RmM1ZlI3RU9EejR2WERvT0NP?=
 =?utf-8?B?djZnK1pxMUpXaFRFWnBWMkFWUnpUQkdyaWFpOXpickJmeXJGV1lUbkFoNTVN?=
 =?utf-8?B?RG1ZTFpZdkJ3S3YvRWxaOXdvZXMwSTdKa1pRblJVcHZ2VlZvUU03T3BIdnRv?=
 =?utf-8?B?bDJ1V3JKRU83TmlOQ2xxTUtUeWlUYkU1U280b2ZxZmpyNVIvMTEzdkNKRlB4?=
 =?utf-8?B?Y1dFdW5ncGxTQlN1bEtDUDI4Y0d3WWEwbVlxbmtWcGRQK281SXp1SnB1UTcy?=
 =?utf-8?B?WGZDMWVIclB0YmpENUFJUXZuNzkrRkg0MmFkanMzNXhHZ0NaS1NURm96UWx5?=
 =?utf-8?B?MXQxcFIyQmlPb2lJRDBZYnVpMVhFQUV6TG9uY0I1c3lkc00yT2ZTSHFKNVl4?=
 =?utf-8?B?bERXVjZZa1dPaUZwcVRPN1pGWmpmTjBneENiNlUyNWg0aXZKMmVFSDRDUTVE?=
 =?utf-8?B?bytrV1doa1VVejlOSkNadHpkbXdIbkdtRncySVFmZXdFbVJxaEloYzY5cFo3?=
 =?utf-8?B?TG5xLzZEUnJ4L0V4bktIVHBRckgwQ0hvL01zYlRSM1pGV2Rjdm9yT0RrK2k0?=
 =?utf-8?B?Y3MzNk5oL3M3MlM0SUlxa2h6aG54ZWV4eWdwT0hHaE5yTDBjcFFTVkdWQkJw?=
 =?utf-8?B?ekFEYUlJelpiTUtWNk4weHM4dGp6aFp5TUxIbDd4cTM2V3lzalNINmJTYjJC?=
 =?utf-8?B?b2pvcU1WOUZrVjdmMnU3ajZYSUFUR3dOUEs1YTV5WTVpMDNhbEJzTFlWZXVu?=
 =?utf-8?B?RDJoSkVHUEdJNkIxQ1pmZFB4UHZaQ0EzenFjZnIrd0o2ODA5QnRHTUFLSVp4?=
 =?utf-8?B?cUV2MEhWMWZwSExmK2NLalBPTnpwS2FZNVZxT3ZMMFREZ1Z3R2w4ZXVUUkQr?=
 =?utf-8?B?bmEvVGtlYTg5VHhqMzV5d1VSM3p0V1Q2TlluT0VycUFxWll1ZGV5L1RXa0Zn?=
 =?utf-8?B?YkhDMldxZklhSFFyNWpnVkVSZXY3K2xHb09GMnJPdE5STVBDZzBaa0oxSjJ2?=
 =?utf-8?B?U0FOUVhSSjEra2p0OFY1czgrQlc5QmFMK28wd1RzaUNzTm44dkFVaThOdjhH?=
 =?utf-8?B?Uzc1NEF6N09XaDhWUmlSc0ZPcit3NUJxZTYzVVYxRnBiOUg2Q1U2cE9pT3BD?=
 =?utf-8?B?Ulgxcm80OGcyRGRVaGp3OTd6bE5kMTZWRGxEaGJ5d0hzSWVoTGRVNlA2Z0RO?=
 =?utf-8?B?RXNXcTRtaHRjYnA3dG9rbnJRVU5qcEptME93R0lVQWlVclNneFg3RG1Zb2p1?=
 =?utf-8?B?N3hNOHNiTjJPaVQ2Y1dWVTNqR1ZiZXM1UUFjekoxb243bktHaEI2NFRwaGhS?=
 =?utf-8?B?bVZ6Ni9XaFJMblVWdGpVMlhnbTl5U09ISG50bDJVVlV6RXZ1RWVncGdCdy9v?=
 =?utf-8?B?clFqQU9jVThtcTdWSUlCZjJBOTZneWw0eGx1ZDV3cWxsd0FNTjBla1ZoZjNG?=
 =?utf-8?B?OWc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e12086-9de8-4797-e155-08dce8722606
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 14:53:34.2510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4XfmiNspMDaPWBxkrl+WfiifETDg0Ogxipj99UwSoCx/D8YlYTb/t2YMfaO+MR+aG5m1LIbdizZizso+xbUCKFx4a3ptEtC8WWAnrJB10g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9882
Received-SPF: pass client-ip=2a01:111:f403:2612::72b;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
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

On 10/9/24 4:58 PM, Denis V. Lunev wrote:
> Recent QEMU changes around preallocate_set_perm mandates that it is not
> possible to poll on aio_context inside this function anymore. Thus
> truncate operation has been moved inside bottom half. This bottom half
> is scheduled from preallocate_set_perm() and that is all.
> 
> This approach proven to be problematic in a lot of places once
> additional operations are executed over preallocate filter in
> production. The code validates that permissions have been really changed
> just after the call to the set operation.
> 
> All permissions operations or block driver graph changes are performed
> inside the quiscent state in terms of the block layer. This means that
> there are no in-flight packets which is guaranteed by the passing
> through bdrv_drain() section.
> 
> The idea is that we should effectively disable preallocate filter inside
> bdrv_drain() and unblock permission changes. This section is definitely
> not on the hot path and additional single truncate operation will not
> hurt.
> 
> Unfortunately bdrv_drain_begin() callback according to the documentation
> also disallow waiting inside. Thus original approach with the bottom
> half is not changed. bdrv_drain_begin() schedules the operation and in
> order to ensure that it has been really executed before completion of
> the section increments the amount of in-flight requests.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/preallocate.c    | 38 ++++++++++++++++++++++++++++++++++----
>  tests/qemu-iotests/298 |  6 ++++--
>  2 files changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/block/preallocate.c b/block/preallocate.c
> index 1cf854966c..d78ef0b045 100644
> --- a/block/preallocate.c
> +++ b/block/preallocate.c
> @@ -78,6 +78,7 @@ typedef struct BDRVPreallocateState {
>  
>      /* Gives up the resize permission on children when parents don't need it */
>      QEMUBH *drop_resize_bh;
> +    bool    drop_resize_armed;
>  } BDRVPreallocateState;
>  
>  static int preallocate_drop_resize(BlockDriverState *bs, Error **errp);
> @@ -149,6 +150,7 @@ static int preallocate_open(BlockDriverState *bs, QDict *options, int flags,
>       */
>      s->file_end = s->zero_start = s->data_end = -EINVAL;
>      s->drop_resize_bh = qemu_bh_new(preallocate_drop_resize_bh, bs);
> +    s->drop_resize_armed = false;
>  
>      ret = bdrv_open_file_child(NULL, options, "file", bs, errp);
>      if (ret < 0) {
> @@ -200,7 +202,7 @@ static void preallocate_close(BlockDriverState *bs)
>  {
>      BDRVPreallocateState *s = bs->opaque;
>  
> -    qemu_bh_cancel(s->drop_resize_bh);
> +    assert(!s->drop_resize_armed);
>      qemu_bh_delete(s->drop_resize_bh);
>  
>      if (s->data_end >= 0) {
> @@ -504,6 +506,8 @@ static int preallocate_drop_resize(BlockDriverState *bs, Error **errp)
>      BDRVPreallocateState *s = bs->opaque;
>      int ret;
>  
> +    s->drop_resize_armed = false;
> +
>      if (s->data_end < 0) {
>          return 0;
>      }
> @@ -534,11 +538,15 @@ static int preallocate_drop_resize(BlockDriverState *bs, Error **errp)
>  
>  static void preallocate_drop_resize_bh(void *opaque)
>  {
> +    BlockDriverState *bs = opaque;
> +
>      /*
>       * In case of errors, we'll simply keep the exclusive lock on the image
>       * indefinitely.
>       */
> -    preallocate_drop_resize(opaque, NULL);
> +    preallocate_drop_resize(bs, NULL);
> +
> +    bdrv_dec_in_flight(bs);
>  }
>  
>  static void preallocate_set_perm(BlockDriverState *bs,
> @@ -547,13 +555,13 @@ static void preallocate_set_perm(BlockDriverState *bs,
>      BDRVPreallocateState *s = bs->opaque;
>  
>      if (can_write_resize(perm)) {
> -        qemu_bh_cancel(s->drop_resize_bh);
>          if (s->data_end < 0) {
>              s->data_end = s->file_end = s->zero_start =
>                  bs->file->bs->total_sectors * BDRV_SECTOR_SIZE;
>          }
>      } else {
> -        qemu_bh_schedule(s->drop_resize_bh);
> +        assert(!s->drop_resize_armed);
> +        assert(s->data_end < 0);
>      }
>  }
>  
> @@ -592,6 +600,26 @@ static int preallocate_check_perm(BlockDriverState *bs, uint64_t perm,
>      return 0;
>  }
>  
> +static void preallocate_drain_begin(BlockDriverState *bs)
> +{
> +    BDRVPreallocateState *s = bs->opaque;
> +
> +    if (s->data_end < 0) {
> +        return;
> +    }
> +    if (s->drop_resize_armed) {
> +        return;
> +    }
> +    if (s->data_end == s->file_end) {
> +        s->file_end = s->zero_start = s->data_end = -EINVAL;
> +        return;
> +    }
> +
> +    s->drop_resize_armed = true;
> +    bdrv_inc_in_flight(bs);
> +    qemu_bh_schedule(s->drop_resize_bh);
> +}
> +
>  static BlockDriver bdrv_preallocate_filter = {
>      .format_name = "preallocate",
>      .instance_size = sizeof(BDRVPreallocateState),
> @@ -600,6 +628,8 @@ static BlockDriver bdrv_preallocate_filter = {
>      .bdrv_open            = preallocate_open,
>      .bdrv_close           = preallocate_close,
>  
> +    .bdrv_drain_begin     = preallocate_drain_begin,
> +
>      .bdrv_reopen_prepare  = preallocate_reopen_prepare,
>      .bdrv_reopen_commit   = preallocate_reopen_commit,
>      .bdrv_reopen_abort    = preallocate_reopen_abort,
> diff --git a/tests/qemu-iotests/298 b/tests/qemu-iotests/298
> index 9e75ac6975..41f12685a7 100755
> --- a/tests/qemu-iotests/298
> +++ b/tests/qemu-iotests/298
> @@ -94,8 +94,10 @@ class TestPreallocateFilter(TestPreallocateBase):
>          self.assert_qmp(result, 'return', {})
>          self.complete_and_wait()
>  
> -        # commit of new megabyte should trigger preallocation
> -        self.check_big()
> +        # commit of new megabyte should trigger preallocation, but drain
> +        # will make file smaller
> +        self.check_small()
> +
>  
>      def test_reopen_opts(self):
>          result = self.vm.qmp('blockdev-reopen', options=[{

This patch doesn't seem to be applying cleanly to the current master branch

