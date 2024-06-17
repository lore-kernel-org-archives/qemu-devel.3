Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27AEC27C6E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 07:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ6wa-0007Xk-28; Mon, 17 Jun 2024 03:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sJ6wX-0007XF-BR; Mon, 17 Jun 2024 03:38:21 -0400
Received: from mail-dbaeur03on20700.outbound.protection.outlook.com
 ([2a01:111:f403:260d::700]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sJ6wV-0006tS-JV; Mon, 17 Jun 2024 03:38:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THApHFgwP4hZ88dCgPV8vztA9HwGhduU/ITtx9xBCvExWjwqFyqUJTydhUkaiJAvWm5vCdRYkAeuzkmrhLfop2o495v3/N4DU7wO8H1pN6Ta9IlezCaLEkK1loXRLwfzysqS/fsToeGYFaIY0sMx03fD7ibqb3Q4yh8NXa6zsLUfBFhboTYSSyoY/drHBNXNIwPHDLyG8e+dEkwzSDIgIQ7O6Ea5hHNfMHbcVP7gGw9g+nChhDJKJtrWlMHqxj4gX3hqPYaD2SK1dyeIj1ar23y0t/6T64aGj7kykftXg+Lkikyczwm1Af8wulyRV9k9VJnrJ0uSrEbzD/lw8xlItQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKBDN6taZfO2t12CM5l879Nz+uBMmgYoPoVIkoJFsTM=;
 b=g3V4lpHgRwAJrYSw4WtinRDoN49x2n7ix1rAJr3VF4oCB2pCEh4oqwQsqC4RPbQXcz//6UKS0mNbnhO0StEjRD0k5pBVSzfu1IjIf1J879dsKlBh7/PYyBNnBPbefUo9CrtHcfO4D+fwWQm/Wzt3J9eIMQgJMTkj+zA5NRe1Y+g8JquEHkJJLstnrTkn2XsLj3zECn4nfIWBzmoLv8e6RY/ETYJ92Tw1xMETIwzHSivE+K3PdYvE34owN4LZPWSUvupWjQX/uKyI2pFpAiNrbVlggknzzdJS+3epdpz3/lSwDZRypNsKEF9/IESmRpvCWUqgJo/YvCSSogY7vBEO4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKBDN6taZfO2t12CM5l879Nz+uBMmgYoPoVIkoJFsTM=;
 b=tJ7EoVfHzwuvF7ConbRP5X+1s1trakr+G4noTqY6B1IoVmQ/hMEgrS87AnXIMU9JkQW7nBCcw4W0ke/B28rVG2wM/y3ldUEHV5T/RvL3EanQTNUcQ/L7mqEzruYpvmudk5ozml+xExPKDbphxksf44QgEfYaIpsv6Pq+7qaKzB4hzmdPEvBS7NvHy0trAPxjZdIueHHeXnxEWCHaHjSiwhUUFlu3fD/4qKGaamYVryFBeG+2qIPn8bmwe2FC2mq/V33kSPY4S/bKxKkZ/o/FmlyI3Jjh05iXxsAFfzYU/gA/2MZyDLdJwZy3M1g0X/2m+ejvc8kPMLN+IL9/R+tRrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU0PR08MB10366.eurprd08.prod.outlook.com
 (2603:10a6:10:40a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 07:38:11 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%3]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 07:38:11 +0000
Message-ID: <126aefc2-de33-4b37-bd58-9d1079914ae6@virtuozzo.com>
Date: Mon, 17 Jun 2024 09:39:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] qcow2: make subclusters discardable
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, jean-louis@dupond.be, den@virtuozzo.com
References: <20240513063203.113911-1-andrey.drobyshev@virtuozzo.com>
 <cbcee281-fdfb-4a7a-b33f-b71d90368059@virtuozzo.com>
 <e3bc4070-4b24-420e-9e98-376eee3659bc@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <e3bc4070-4b24-420e-9e98-376eee3659bc@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::11) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU0PR08MB10366:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d64a09e-f5f3-4f09-a78f-08dc8ea07018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDg0dFE4RVJlcjRiMDJsR0tKQzdKMmUySEZyVndqclIrTnFLNmFnOFczeGRZ?=
 =?utf-8?B?UmJzRk1TRWQ0bGtneEJtTjk4d1VvRE5vdk1lM0Z0Y1F6TUpOVmhOUnlBNksv?=
 =?utf-8?B?V1FEd2hoRXVxbTV0czNyUlMyV2FLRWtLUGFFRWIrc3FWNURnVGM0aGl2WGN6?=
 =?utf-8?B?T3g1NThKeSthcTRYRisxR0kzZjN6VURvNHhoeTl6M01nTGtEdzNLQjRTTDls?=
 =?utf-8?B?SEtyeDM4OU9tV0ZqTHFRZkhlQ29YN1l4RktGVTRlT2dLM0p3c2d6VUM5MEZo?=
 =?utf-8?B?amRxWklvcTV3UHZZUmZsMGlTVGFoYW10Vk1OYlhDa3ExRFRzaHBMZUozY25a?=
 =?utf-8?B?S200N2ZrazlxR2VJZ21QQWQwdFhuSk5kU2pTUUtEbXVwRUFrTE9oNHFQc0xr?=
 =?utf-8?B?bWtoTG11WFArMXcwR2RkbnEyeE1nWDBUa2xUVTBtbDY2YUZnODRZSWVqWEF5?=
 =?utf-8?B?TnhrdjhyMTJrR0JOTS9QSTJ1LzA0ZHNBbnpoV0d0U2N0eWFlUW02SUJ2cXFr?=
 =?utf-8?B?VFBhaE9raVAwSW4zbU1mdkxnOEtRWlBGdXFmdGh6WnBMZmRvRksrU05peHJS?=
 =?utf-8?B?bEFna1dzeVZnWkpGRUlIYUJ4dUJxOE96MHlyMVIwVVZYUkF0R1hESCtQempT?=
 =?utf-8?B?cUxjVklLYXBQRUZPdVhNZ0lSNTZkVEVpM09TNTdnRFhIckpPL2JYRTZmMHlS?=
 =?utf-8?B?QmZwTzl3clU1QWhCR1pJZFg1c01ORnVFcFdXQW5NWlQvWDhJUmd5SXZWc0Qz?=
 =?utf-8?B?K2xXLy9XWm84SEhTd0xGL3h2V0FxRE1HMmJVSWhyMkNlRGJ0TUlrOWxYNmlW?=
 =?utf-8?B?Mk9MZmNLYmdTZDhzNUF3V0xiSVAvOW04STlrY2Nqd2h5Z1FNU1ZTMVVwTGM2?=
 =?utf-8?B?Sm9jeWkwalUrVWQrM2RlR2JIRHJQTFUwdDU1dE1oblNFNmFIbkxnUmxtMnQz?=
 =?utf-8?B?VUVGV04xRGtFQU9hRFZWTlprUjI4V1A4aXFQbVg5N3U1K253ekYwUnk2Rnll?=
 =?utf-8?B?TzQwakliRWdydGdRN2p1bzMxVHdzSkNrMFBRRnZGYnRqR2VnVm50MUw3OTBr?=
 =?utf-8?B?Uk5xaERvM29La3lMMktkeUVjM294c2VCV3g0MjkyWUNZYTdmYkl3ZG45NnZD?=
 =?utf-8?B?UEp6ejM3Y3lDWHdINDN1WnNPdlhDRElKSEdRb3NFUGZNRFlLWGRvbk4rYU0y?=
 =?utf-8?B?QVdEaHNDMkplc3hKRkExVFBkUjY3SVNoSExndUgwMitIdDNYTXZISFlQaGNt?=
 =?utf-8?B?SE80Z21ULzJRNFF0ditHUDVBL1o5QXFEZGo4OXdqRnh3dlV2c1p1QWlLVSs5?=
 =?utf-8?B?a3hQemdTeWJrc3Z2MkVpbzk4cVlTOHJTYjhVdVZNT0pQZXJpcSs2bkFDODdx?=
 =?utf-8?B?dllTN09TMUdxckRsbDZWcWNFSmQzQkdYQmk1ZUk3dytWYVljbTJiZldyQUtw?=
 =?utf-8?B?Q01JZWFqdGtaREZOUm1TU2VxZE9XSXpzeU1Cd21mTVJjdEVIejdIRFF0M1lx?=
 =?utf-8?B?eGtGNm0vR0c2OE50U3V6dEpldHVKcjBNTFFSVnNTa1ZLd1NtMERXVHErazB1?=
 =?utf-8?B?eVh6d2NMcDhRL0lkeEs4b0xldkpEL1F1aDNpcTAwR3YwcmhpRkdxQm1TQW5I?=
 =?utf-8?B?N2xQajU0ZWRDQUpyajA4RGdFUm56L1NMT3BNQWlhZDFmS0t4OURWTVdidWRt?=
 =?utf-8?Q?iZMDenevQvG+DN0bl/WS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(376011)(366013); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXliYURCajh3SDBlWHJjTGFZS2RpOU9wQy9UUGxGY0JZUkRxdktDRFJ3QXE1?=
 =?utf-8?B?UW5QdXlYZ0Vza3A5NEVvSXdxcHZkQ280SGZ3YWI5b1lnQ1hnaWswV0xhWUVt?=
 =?utf-8?B?ZDBzeFMrbzU0cnB5d00rTWRmMWVJR0VRZU8zVitmaC9wWWozdFhCM0FPNVFr?=
 =?utf-8?B?R1lFMzJSSXVkdnZQaHRabk9zVVBzcENYYmc1QTdDZzA4MUZYOFBuMUE0YmtB?=
 =?utf-8?B?SWFEZk1JNXFYQzE1RW41V3lsZC9wM3ZnTjZCYXFlb3ZZSXlkMmgrU1o5ZGll?=
 =?utf-8?B?WG9JSjhRMnZENXFHWHBtWHM2ajlVZ2hJN0NFMUJQbUlMT0R5K0xEOXZyQVF2?=
 =?utf-8?B?eURXaUF6N1VncTVsSXhZOEw4OGh4OXA0TTdZTUt0NEJKQ2p5K1ZzWHMveXp3?=
 =?utf-8?B?YzlkL3JDV1lSNWFYK3YwTEsyMmF1NmsvOWFjUVpYcHZOVXNWNzVUM1U3L0Ft?=
 =?utf-8?B?NVY4d0Ivdi9nY0NWY0t0OUxITkluVXZ2N0pmcG5vZ0NuL0hNMGFqNG04SXB2?=
 =?utf-8?B?ZHczUS9jd3kvLytzQ0FsUUxtVEJRdlJHMEVIRHVmNEFVOHJneVc0TVJYUWVv?=
 =?utf-8?B?L2w0bE0yU0lMcWQ0OWdSZ1Fjajk0ZWJveTAxM3cxU1R1YVppUkVrdk1lZUts?=
 =?utf-8?B?RWRsekUxY25YSzBjYjhSRlFWVDFhQTg0WGlVNGgvZHhINmFtbUtRSCtBVlZN?=
 =?utf-8?B?N0xwV2dHN212L1dNNEZ0eThLNmJ6Z21jNmJiQVB0bENkbWxFYUxmVGRPUy9T?=
 =?utf-8?B?YWZFdEZabVhZSThpWkhINGVUSUdSNDVnTEZCZ0pVUWdtUEsrY29RSGFVQ1Z4?=
 =?utf-8?B?R25ycXVCemhlaGtJTmx1QjZ4bXdvd2lxRDRtMmF5dkFSaXB1U1BZOFp6SzlH?=
 =?utf-8?B?ajh1d3lDdE95dU45MGE3MXVzQlNQQmVQSWtLMkx0aEMvZnpmYTAzUDRmZ0NN?=
 =?utf-8?B?SmVEakxtOXRUWTd3OWg4NzlrT2hUSjFYZnprNjltQm8vUHpTd3ZEcStMQ2Nj?=
 =?utf-8?B?VnRVRGtQQUoxSTM2Zk80cEJIaEhjL2ZYUCtGN3B0MzZtQ1JMbk52c3JsUllW?=
 =?utf-8?B?WVdCRncyUDdmVHdDM1JCMjFvd09SUjhnbnJhVERVNXJldW9zVmU1R2FUZTBO?=
 =?utf-8?B?K2M4a2FuSVBEWGFITEJzbThjS3NNcm12M3V1NVBmaytTWTV0MG01TUJqT1l2?=
 =?utf-8?B?REUyMHhvTlovRThmUGFEVWpPUHpNb0gvLzluUkZxVkVCSzVEZUozNStiSVdI?=
 =?utf-8?B?cnpxV09ESk1aQkZMK3B3R2Z5YXg5bWt0MzJUWkNGUDlUaDNIUm9pdWhDVmhj?=
 =?utf-8?B?Vm9nc3NSQy9XYmlYZlRQY0VNeldLZVF1ek44bjEzdkMvTWlQUjI0ZE40MjFn?=
 =?utf-8?B?QWRYYnBDUUZGZ0w5QXNtT3lLQldOMnhUbTVLOHQwUlI1R0g5bnVXT1duSG4v?=
 =?utf-8?B?Q3BIT3VRdWJPQ29FeFlhc0NvMzNEMkVlQjRnaVlKM0I4TmJnT0dZeUQ4L25D?=
 =?utf-8?B?SUZ4QTl2dGVOT0NMOGFEWDlHS0phTXliNzJWbHJIVGt6OStldXpwZFBadzZL?=
 =?utf-8?B?LzFSM1oyclZaZ1VUWnRTcWNZNnNsUmdmZFdEa1p1RHJ2VkJ3SzY4V0IvOEg0?=
 =?utf-8?B?VmplcFlPQm82SXdxSkNKRUg2Lzc2NG4wblVndk1RYUNwZitxYTFGNGlkTnRn?=
 =?utf-8?B?Rm0zU0ZNTnhKT2NUZ1YwNG9ZMm1DaHZ5WEY4SkMweElKY2NsN3RINXluV1NL?=
 =?utf-8?B?NmV2SE04MWp6MEhoUUZndUlGc1V0OCtsYlJ1WXBqUXl5SFNjMTlyeTJJaG5X?=
 =?utf-8?B?eG9RUHFDV0dZTUh6YStLUTkzZGFTL2lqM3U0ZER6elZnUUtOWUZoZjh2MHN1?=
 =?utf-8?B?QWV4Zk1JTTJnRTB6cjBENDYxVmFNdWw5K1ZSS0ZWdldrckl1L2xETlJlVk1h?=
 =?utf-8?B?b2lzb2lBSWxlWWFkTktVeFg2WnlRc25nL0tGZ1ZGZ0tGUkV5anNYTDJiT09a?=
 =?utf-8?B?eUNQSUZQNUZQYUV2S3F1VDJiaFBpdDJydWJDaDhORVJ6cDBXeFdiS29IVkp5?=
 =?utf-8?B?S3EwWm9Uc1VQeVl0UzNrdUxBYTkxdVNQVTlvY0pHeEZBanlReTNpWExLZFJN?=
 =?utf-8?B?eFNRWWVaNGNJRkk0QTE4TjlRR3NpT1lOUE83VWtZTHJUNkZJUGVoc2l4SFNp?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d64a09e-f5f3-4f09-a78f-08dc8ea07018
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:38:10.8011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0KvY/Spo7Lx28nng3JNIWaa1o5fyfoXLHTF9IwUJP9v800eQNtZmBgoHIHhFOWtjpLbKMUUhC4SpDggEIHweX78Rm10ml76toP3BLgmyX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB10366
Received-SPF: pass client-ip=2a01:111:f403:260d::700;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/10/24 11:53 AM, Andrey Drobyshev wrote:
> On 6/3/24 12:19 PM, Andrey Drobyshev wrote:
>> On 5/13/24 9:31 AM, Andrey Drobyshev wrote:
>>> v1: https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg07223.html
>>>
>>> Andrey Drobyshev (11):
>>>   qcow2: make function update_refcount_discard() global
>>>   qcow2: simplify L2 entries accounting for discard-no-unref
>>>   qcow2: put discard requests in the common queue when discard-no-unref
>>>     enabled
>>>   block/file-posix: add trace event for fallocate() calls
>>>   iotests/common.rc: add disk_usage function
>>>   iotests/290: add test case to check 'discard-no-unref' option behavior
>>>   qcow2: add get_sc_range_info() helper for working with subcluster
>>>     ranges
>>>   qcow2: zeroize the entire cluster when there're no non-zero
>>>     subclusters
>>>   qcow2: make subclusters discardable
>>>   qcow2: zero_l2_subclusters: fall through to discard operation when
>>>     requested
>>>   iotests/271: add test cases for subcluster-based discard/unmap
>>>
>>>  block/file-posix.c           |   1 +
>>>  block/qcow2-cluster.c        | 346 ++++++++++++++++++++++++++++-------
>>>  block/qcow2-refcount.c       |   8 +-
>>>  block/qcow2-snapshot.c       |   6 +-
>>>  block/qcow2.c                |  25 +--
>>>  block/qcow2.h                |   6 +-
>>>  block/trace-events           |   1 +
>>>  tests/qemu-iotests/250       |   5 -
>>>  tests/qemu-iotests/271       |  72 ++++++--
>>>  tests/qemu-iotests/271.out   |  69 ++++++-
>>>  tests/qemu-iotests/290       |  34 ++++
>>>  tests/qemu-iotests/290.out   |  28 +++
>>>  tests/qemu-iotests/common.rc |   6 +
>>>  13 files changed, 490 insertions(+), 117 deletions(-)
>>>
>>
>> Friendly ping
> 
> Ping

Friendly ping

