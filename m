Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06CBC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 10:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9MwV-0000Xu-6C; Tue, 21 May 2024 06:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1s9MwT-0000XS-5I; Tue, 21 May 2024 06:42:01 -0400
Received: from mail-vi1eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2613::701]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1s9MwQ-0005NK-Gr; Tue, 21 May 2024 06:42:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auQWZ+nGuoY/2C/wNQCOpBHhV9Ne9u08cmcTsgYevTFpAr/zIrLofQmVP0umWFitiwzk4O9rFbUgluQigGvGTVxbblU/yp6w3nLtCrMok+gRlWFut3v6tuo+BVje3muXigr1iLQMmT0rSgoL58ZqqU0WUngBXiOZbL8h/8i6rv7EOLU0hW35R735LkJhagDbkXg85KNE73aoh5oPJ38cyLsImqSUPQOSdjrOWvsefATyVVH/kxvigAm66TMANV3rq+kGkMPHVOyCObYmwNOKDR6MYqpUbiGS0DmsZ3xk3qQwMP4vtD1dRPln7BF1cqRJmyxYDllU3drARkSXm1nh9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9COLMnfTdYtTJ1GaUaCJJI6HjrhHWM2idtZO0GAM498=;
 b=FsYv12Q5roldJs+qM08KkKxKsS+YXshzMAGUo7QFn3ANJBtQdFtpwWP62ekJhnnjUezpYtp8KhTiarxjDIKwjd/P7sUKIccupbIcXkLeBdX6WFcW0QOySFJ0BzadKeJTA6zOGNVXTRi17EM/QbmI2+/4pR2UO9UidZRUuPgka932a7jrgr12xlTjZsHe45J2d6QQOCDwS9aQuW47Rxs7R1l0Bm7a5T5Y/ZMp5o1ROZHXSUWHvm8bkLSLXLOzg/gtU+9IgqzEYETFkN7azyKuqGgSuRTvtxF9fF+2iM4nIeLQGYqsa7Y3abR1QMOevbLVHb0y6fBnoccuFYiRY2nULQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9COLMnfTdYtTJ1GaUaCJJI6HjrhHWM2idtZO0GAM498=;
 b=iKwVRAwo7NVKPJc+BsRBjWHxFTgZ0Z/n6C7GnooaaRvjG8TqKKasT+tikB0ga7hRj0ttgcWId1YfqwzlNMHOCQy6WbIsaxmXEhHsZ9zyXtTEb3H+xvS77FLiJNintJLMHe+Zm81qnMjitudSThtzYI/3pGtqpXyVfCy+zRP/lUXY+zKL2yqr8E9KaMGBPsN7wReDY8jT2vDkJW7rgxBQkrquZPrkSUVUtPMzXaZBdrHvDCC0haionc9A8daL5Bdkaw+IsYUMgcHpHLQGVfz/1oYoM1BR3nM8796iRZinIpsuZ/c2gSYtcfm1Pv5EekVs4KEe10Kg4l9taB8Hp2uM2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by AM0PR08MB5442.eurprd08.prod.outlook.com
 (2603:10a6:208:182::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 10:41:53 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5%6]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 10:41:53 +0000
Message-ID: <594f3477-d38f-488b-b740-63ae08e01ee0@virtuozzo.com>
Date: Tue, 21 May 2024 12:41:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] qcow2: make subclusters discardable
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, jean-louis@dupond.be, den@virtuozzo.com
References: <20240513063203.113911-1-andrey.drobyshev@virtuozzo.com>
 <20240513063203.113911-10-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20240513063203.113911-10-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::10) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|AM0PR08MB5442:EE_
X-MS-Office365-Filtering-Correlation-Id: b55e2051-d984-44b7-6a82-08dc7982a106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXhDbml6dEtnMmJqRzJkWU1sUjVkVzRaWDIwWnh0ZVNwVzZlVXcvNHlRQ1RQ?=
 =?utf-8?B?QzYrYzZnTjQvcDIvQTZZOGVPRk5zS3BuclQxU05LU2RsanV2ek1MQm1rTGk3?=
 =?utf-8?B?VnVBSUlRVHdoUkRua20yMExLb2VXV3g2MUg2cVRzTlpjRFl3Y2l3d2wyS0hq?=
 =?utf-8?B?R1htMjRCQ2Y5UzBOeFBMK29Va2NzcE03cXBNbDRqMjJuWDlzQ0RLUnNFVmxM?=
 =?utf-8?B?T1I1bktHOUZVME5ENFZXRUlNemFkVDNOYStabkoyaUg3cDIxZDZoRm1XYVVX?=
 =?utf-8?B?dHF1bGZVeHA5NDNiakx6UmpMS3dXbnFEdFZjMWl6WmNFczZXZEFUVFZydytN?=
 =?utf-8?B?RlA4MWJyUFV0eFNyTEFQY1oxa3k0cnIrSGg1RForRlB0R3Z4UTk4MkUxNXN6?=
 =?utf-8?B?ZTVTZ2kwSXRnOXNIeW1nNTZxdlQ5cFNJdnh2UEtHek11bzZxaTdHT1JjMWlI?=
 =?utf-8?B?TjhrY2p1VW1vVnMwWVdlMnFvbnRnVmxNWTVuUXMrRE5VN1JVTXJlc0Q5WXNl?=
 =?utf-8?B?QnlmcWVHeTVKaVArNi9vY2FFb3R0WnoyWUVZQUdzU1NOQ0xVN2ErazVIdXN0?=
 =?utf-8?B?dklnQ3k1RHE5SkdmTXE5cTN4QzM1TkRUKytaZzdUTklneGxhekRPbTJjSGpF?=
 =?utf-8?B?RVRaODRpRXBPWWI5OWRGaWlaTmFSbVdKVjZGZmFGSm5LMEt1L3ZpandmRThQ?=
 =?utf-8?B?a21zRDZJc3QrTHh6bkovZmRBU0NLWW94NE0wb2xvdFpRaHRKeVRhL0JSRXNJ?=
 =?utf-8?B?TjZzYkZIck5oL1lvTEErNVZYa3VMM2JUcjF2Q0NUZ2dGa29vSnlmZ0MxZmNy?=
 =?utf-8?B?dkFWci9HdzBLUEJRNnJWS1grRS9adldNd2M5NHhrZExNS0FvRTN4cnN6eWg3?=
 =?utf-8?B?anJhZ2lORjRSaGVCYUxURkx3UVc0Q3ZyN2tCaHpqUkFoYVJpTGdjcWF2TEp1?=
 =?utf-8?B?ZmZyVWlmOFgwcDM0Qi84ejRhTWVqMjY1VzZJcCtLVGdNb3pKL0dtQ3Q4b3Za?=
 =?utf-8?B?Q01taGM4V2xHMkdRUmpFTlMzNjdGWlNuY0lEb0hxY1JGOWhERFlBTmlDblNC?=
 =?utf-8?B?eDhSem1pWkxOTTdRUVFMS0VURTdIbHJ6Qi9ZTm1id2czSEFtSy82TGs1TlVa?=
 =?utf-8?B?cUxUY09aTUFmWWxCRVZFOUtaRmVoOU5zaU5NZS9qZ05zMzRXSUkySk9Jb2xI?=
 =?utf-8?B?blFvUlZGbXd1WWdNZXBObVlqb24veWJ2UlhlT29qRVB2THdzSzAxUEF4Q0ZS?=
 =?utf-8?B?bFpsaUxweUx2TGN6U0t4dDV3MXFMenU3TjhQY2U4VGdaL3dNNk5CNmhRQWRk?=
 =?utf-8?B?N0VuclRoek5mckRpUUxMdlhsMkpkTlJCL0ZDanVPT3I4cFREeldkYUdxME5u?=
 =?utf-8?B?cXprQm1KNlRDTnBMQVp2SisvUWxsTHNUN0xsV0tyMjFGNEl5dTU1KytKZXRv?=
 =?utf-8?B?T1NmWG1qd256Z1lnV2hwV2FHUW9BUU9MSmVMaGZ3ZXpSQUc4dmF5WldiN0pi?=
 =?utf-8?B?WDVwRG9ibUxZVmJwV3hlRjJSTTh6aU9QT2NETzNrZG1NSmhWU1dYTDFrd0tr?=
 =?utf-8?B?b0xKRzVCN2ZTWDMxUXFHaVpvSHBvOEV5TnRoZzN6V3VneGdiT0w3THdvOUx3?=
 =?utf-8?B?eDNMSDl6R3U2cWx1MWhybEpPc2R5bXdlYjNtNEZod2w0eW5DMU1vaFd3cHRO?=
 =?utf-8?B?cUdVT3d0NEh0dkpkMW8rcS9lcVh1bllLQlQ2YmRRSlN1TWwwbkdFT2FnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTlIb2d0WFJMTVVKbnd5YVhSV1lxazkxbXRpNjdQa3hxaWNsL1lXY3prZTUx?=
 =?utf-8?B?dkJMN0dmSU84WTBWMG03bGhqRFY3Y29xMlE0UHllYXM2L01TY24rNXpzUlcx?=
 =?utf-8?B?TGZyWnJQS3FsZ1FudzhiUzdWTFluTTVTRldsWGhWbVVncTE2UFdrYWtySEZH?=
 =?utf-8?B?NG56NUFBVkZvYUJpUmZvSWlIdGQxL3BRMDQ2UDBPN0g2R1h4d2NZME1xaVRl?=
 =?utf-8?B?cFkxMWJULzcyQkNsZ3RZMmlhMDNONFJSWW8zeUUyUStSTk40MFgxMTBSQVpw?=
 =?utf-8?B?bWVmZ2F5RStIbFRoSElRVG1vSDlkYmU3SEQwNWY0djJhWVJFbkx1VU9oOHJr?=
 =?utf-8?B?ZXpTcWgwajQyT09BeDJNdzA2RUdQK0V4ZnhBdEZnQzFIZk1iRVpPNzlxK01Z?=
 =?utf-8?B?c3RjZGp5eXhCTjB3clJXYnkvQjRwT1VRbysvL29XWmtJQ1o0ZXFZWHZIZlI2?=
 =?utf-8?B?dEVmOVNvUTRqZTExUGFFeEMyclpuTFd0MlEwYUp4b2diY1RGSTVocDJ6YWUx?=
 =?utf-8?B?eHVjUHhLbzB3WUQrUmJrRUhoY1BZcE5hUUIvNlhURk9LYStkOFkzeTZQcDZU?=
 =?utf-8?B?dVJ6bFZmeFRra0NKNHJ4Z1VJcmx2QTBiVlBGUWhVc0RrMDNZbk5jT1FrT1Iw?=
 =?utf-8?B?TWwzdU56Y0RzR0N4bkI5NkcvQUNCUWRjVExmTGpubXlkaTFtQ0tyQ293eHd2?=
 =?utf-8?B?Y3oxcGJ1OWQwMjhYYnFaaWMzcXQzVW90SGd2YnNXSnBENzhBQWU2UGZSNDNG?=
 =?utf-8?B?WVIzYXVXVFViQktzQnUwS1hKaVV2SjV2RXRMYklCdVhTTzF0RTRSWTdnZG5R?=
 =?utf-8?B?K1RCZ1pqYW5MRGFpZm9UZy9uRS9XRmdtczBobDFSczVZTXFZL2xXK1V4L003?=
 =?utf-8?B?bTR4ZXFaMm9YV2U0MUhEYkFXbUN5NFg2Z1FhNTBFb3ErbDMxdlpncGpqNmNh?=
 =?utf-8?B?ckx0c0FLZ1BxVkVZbVl2UERVN0gzQmJLTVc3R215YVhxbDBES2VBVEw5Y1My?=
 =?utf-8?B?RHJ5TTdXU1RtdHNkTVFyay8rUDNYcXc4M1hSUWlZY3lkVXFIUktPNDZUWmd1?=
 =?utf-8?B?VGZhd0lyTThDUWUzMko3TWFZc3BjL0krb0MzM3lGblBsYnlJbG5zY1RwRWxG?=
 =?utf-8?B?Z1E3VmhTS0h3enArZERxMWZVSnRqcHZuQWlHYnRhVlJMc1ZuZU9rTkx3WVhR?=
 =?utf-8?B?SmJmQjNKSFdmOHNmYnk2dXBkWnRKZWZCM3BvY0w5UXJ6blBxNTZ0OUdBd3hy?=
 =?utf-8?B?cG1NRS9CbDN6dm11L0JTdGwybVlJMWx0M1A3NVZHQmhCckNFbDlRSWlJWUF4?=
 =?utf-8?B?MjBMS08rc01rdHVPRUY0Y2l5ODVoYlR1RVNuLzBHeWxBT1o2V28rR0FrcUo4?=
 =?utf-8?B?cmJMdTRWdmZwMENETHhBelBQcGlPRkcwc1VDZXkvc0hiaVltdWpmZUhZLzhV?=
 =?utf-8?B?U0VWVVVGaEJDRnp0RlNXYkFJdkFJTit6cTQvM2RmNXlMdVlkWUJoL2svNEZY?=
 =?utf-8?B?bCtKR0UyMTNBdWVnYlN4ZzU3UXpROXoyWXVnSjNSbXN5L2wzaktmWHk4NmZY?=
 =?utf-8?B?aEpLVTBWck5xVkpTWVM2ZVQ1dFl2SE9rK01WRVBwV1gwUXdySGJTRFZqMGFo?=
 =?utf-8?B?eVUxd1h6MEkvd21ndlpXNnpPOGdTdFJDWlVWcVNnNXBYZVRRL0FLRWRJYWt6?=
 =?utf-8?B?cU5yb0lNNTAyUlFQQ2hOVFhWQkg2a0thelU1NEJ6MXhxNk1ieU4xNFVDQ0Rk?=
 =?utf-8?B?SENMdi9VL1p4TUJJTi9Uci84OG9XOXprTnFlYkhTMGhZZFhKREh0QVJyQW5W?=
 =?utf-8?B?NEpuNEJ1dFRzb1h3MW1tMlZyYWFkRUZXVkxzby9nRDYySGdDek96ZDhZeElJ?=
 =?utf-8?B?d1JMTjBDMDNFcWN2bTU5UFhBY1ViWnFxT2I4Q2ZGcTJwaWZTMUZUN25JRGR0?=
 =?utf-8?B?M0ZZNjNaSTRFR0VsRTF5bGtrSGt5b1A1U2xsR0c1bEpqWFR6aUNGdGFTNE1o?=
 =?utf-8?B?OExwYTRReW9vb2REYzZiMmhpaFdaamFXUFVpWTNnRTJWRDVsMnI4d0NnRWRK?=
 =?utf-8?B?cHIzVGducU5CbmdYT3dkaTUzUURyMW44TEs4a1djRVkyVGhDUko3RGtidk9r?=
 =?utf-8?B?Tmt1Qmh3Q0tkbGlqRnorWWVCa1hob0wvSGhlbVNjS1BMOTZmR25nV3VWa2ZK?=
 =?utf-8?Q?UNk2HmceD+PdMr1F+g5X3N4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b55e2051-d984-44b7-6a82-08dc7982a106
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 10:41:53.5271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkrtJu+mlediETcV7ZuaAEpdmOeNGiPHASRwzVa0d61fxeS1vq66yAIwkikW6kvkKqwZu+8rsQlRnalBkIc8WAlslAAyOFcY00cKE1gVKXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5442
Received-SPF: pass client-ip=2a01:111:f403:2613::701;
 envelope-from=alexander.ivanov@virtuozzo.com;
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



On 5/13/24 08:32, Andrey Drobyshev wrote:
> This commit makes the discard operation work on the subcluster level
> rather than cluster level.  It introduces discard_l2_subclusters()
> function and makes use of it in qcow2 discard implementation, much like
> it's done with zero_in_l2_slice() / zero_l2_subclusters().  It also
> changes the qcow2 driver pdiscard_alignment to subcluster_size.  That
> way subcluster-aligned discards lead to actual fallocate(PUNCH_HOLE)
> operation and free host disk space.
>
> This feature will let us gain additional disk space on guest
> TRIM/discard requests, especially when using large enough clusters
> (1M, 2M) with subclusters enabled.
>
> Also rename qcow2_cluster_discard() -> qcow2_subcluster_discard() to
> reflect the change.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   block/qcow2-cluster.c  | 106 +++++++++++++++++++++++++++++++++++++----
>   block/qcow2-snapshot.c |   6 +--
>   block/qcow2.c          |  25 +++++-----
>   block/qcow2.h          |   4 +-
>   tests/qemu-iotests/271 |   2 +-
>   5 files changed, 117 insertions(+), 26 deletions(-)
>
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 8d39e2f960..3c134a7e80 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -2105,25 +2105,106 @@ discard_in_l2_slice(BlockDriverState *bs, uint64_t offset, uint64_t nb_clusters,
>       return nb_clusters;
>   }
>   
> -int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
> -                          uint64_t bytes, enum qcow2_discard_type type,
> -                          bool full_discard)
> +static int coroutine_fn GRAPH_RDLOCK
> +discard_l2_subclusters(BlockDriverState *bs, uint64_t offset,
> +                       uint64_t nb_subclusters,
> +                       enum qcow2_discard_type type,
> +                       bool full_discard)
> +{
> +    BDRVQcow2State *s = bs->opaque;
> +    uint64_t new_l2_bitmap, bitmap_alloc_mask, bitmap_zero_mask;
> +    int ret, sc = offset_to_sc_index(s, offset);
> +    g_auto(SubClusterRangeInfo) scri = { 0 };
> +
> +    ret = get_sc_range_info(bs, offset, nb_subclusters, &scri);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    new_l2_bitmap = scri.l2_bitmap;
> +    bitmap_alloc_mask = QCOW_OFLAG_SUB_ALLOC_RANGE(sc, sc + nb_subclusters);
> +    bitmap_zero_mask = QCOW_OFLAG_SUB_ZERO_RANGE(sc, sc + nb_subclusters);
> +
> +    new_l2_bitmap &= ~bitmap_alloc_mask;
> +
> +    /*
> +     * Full discard means we fall through to the backing file, thus we need
> +     * to mark the subclusters as deallocated and clear the corresponding
> +     * zero bits.
> +     *
> +     * Non-full discard means subclusters should be explicitly marked as
> +     * zeroes.  In this case QCOW2 specification requires the corresponding
> +     * allocation status bits to be unset as well.  If the subclusters are
> +     * deallocated in the first place and there's no backing, the operation
> +     * can be skipped.
> +     */
> +    if (full_discard) {
> +        new_l2_bitmap &= ~bitmap_zero_mask;
> +    } else if (bs->backing || scri.l2_bitmap & bitmap_alloc_mask) {
> +        new_l2_bitmap |= bitmap_zero_mask;
> +    }
> +
> +    /*
> +     * If after discarding this range there won't be any allocated subclusters
> +     * left, and new bitmap becomes the same as it'd be after discarding the
> +     * whole cluster, we better discard it entirely.  That way we'd also
> +     * update the refcount table.
> +     */
> +    if ((full_discard && new_l2_bitmap == 0) ||
> +            (!full_discard && new_l2_bitmap == QCOW_L2_BITMAP_ALL_ZEROES)) {
> +        return discard_in_l2_slice(
> +            bs, QEMU_ALIGN_DOWN(offset, s->cluster_size),
> +            1, type, full_discard);
> +    }
> +
> +    if (scri.l2_bitmap != new_l2_bitmap) {
> +        set_l2_bitmap(s, scri.l2_slice, scri.l2_index, new_l2_bitmap);
> +        qcow2_cache_entry_mark_dirty(s->l2_table_cache, scri.l2_slice);
> +    }
> +
> +    discard_no_unref_any_file(
> +        bs, (scri.l2_entry & L2E_OFFSET_MASK) + offset_into_cluster(s, offset),
> +        nb_subclusters * s->subcluster_size, scri.ctype, type);
> +
> +    return 0;
> +}
> +
> +int qcow2_subcluster_discard(BlockDriverState *bs, uint64_t offset,
> +                             uint64_t bytes, enum qcow2_discard_type type,
> +                             bool full_discard)
>   {
>       BDRVQcow2State *s = bs->opaque;
>       uint64_t end_offset = offset + bytes;
>       uint64_t nb_clusters;
> +    unsigned head, tail;
>       int64_t cleared;
>       int ret;
>   
>       /* Caller must pass aligned values, except at image end */
> -    assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
> -    assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size) ||
> +    assert(QEMU_IS_ALIGNED(offset, s->subcluster_size));
> +    assert(QEMU_IS_ALIGNED(end_offset, s->subcluster_size) ||
>              end_offset == bs->total_sectors << BDRV_SECTOR_BITS);
>   
> -    nb_clusters = size_to_clusters(s, bytes);
> +    head = MIN(end_offset, ROUND_UP(offset, s->cluster_size)) - offset;
> +    offset += head;
> +
> +    tail = (end_offset >= bs->total_sectors << BDRV_SECTOR_BITS) ? 0 :
> +           end_offset - MAX(offset, start_of_cluster(s, end_offset));
> +    end_offset -= tail;
>   
>       s->cache_discards = true;
>   
> +    if (head) {
> +        ret = discard_l2_subclusters(bs, offset - head,
> +                                     size_to_subclusters(s, head), type,
> +                                     full_discard);
> +        if (ret < 0) {
> +            goto fail;
> +        }
> +    }
> +
> +    nb_clusters = size_to_clusters(s, end_offset - offset);
> +
>       /* Each L2 slice is handled by its own loop iteration */
>       while (nb_clusters > 0) {
>           cleared = discard_in_l2_slice(bs, offset, nb_clusters, type,
> @@ -2137,6 +2218,15 @@ int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
>           offset += (cleared * s->cluster_size);
>       }
>   
> +    if (tail) {
> +        ret = discard_l2_subclusters(bs, end_offset,
> +                                     size_to_subclusters(s, tail), type,
> +                                     full_discard);
> +        if (ret < 0) {
> +            goto fail;
> +        }
> +    }
> +
>       ret = 0;
>   fail:
>       s->cache_discards = false;
> @@ -2286,8 +2376,8 @@ int coroutine_fn qcow2_subcluster_zeroize(BlockDriverState *bs, uint64_t offset,
>        */
>       if (s->qcow_version < 3) {
>           if (!bs->backing) {
> -            return qcow2_cluster_discard(bs, offset, bytes,
> -                                         QCOW2_DISCARD_REQUEST, false);
> +            return qcow2_subcluster_discard(bs, offset, bytes,
> +                                            QCOW2_DISCARD_REQUEST, false);
>           }
>           return -ENOTSUP;
>       }
> diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
> index 92e47978bf..4e39354d02 100644
> --- a/block/qcow2-snapshot.c
> +++ b/block/qcow2-snapshot.c
> @@ -736,9 +736,9 @@ int qcow2_snapshot_create(BlockDriverState *bs, QEMUSnapshotInfo *sn_info)
>   
>       /* The VM state isn't needed any more in the active L1 table; in fact, it
>        * hurts by causing expensive COW for the next snapshot. */
> -    qcow2_cluster_discard(bs, qcow2_vm_state_offset(s),
> -                          ROUND_UP(sn->vm_state_size, s->cluster_size),
> -                          QCOW2_DISCARD_NEVER, false);
> +    qcow2_subcluster_discard(bs, qcow2_vm_state_offset(s),
> +                             ROUND_UP(sn->vm_state_size, s->cluster_size),
> +                             QCOW2_DISCARD_NEVER, false);
>   
>   #ifdef DEBUG_ALLOC
>       {
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 956128b409..792b106eb6 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1967,7 +1967,7 @@ static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
>           bs->bl.request_alignment = qcrypto_block_get_sector_size(s->crypto);
>       }
>       bs->bl.pwrite_zeroes_alignment = s->subcluster_size;
> -    bs->bl.pdiscard_alignment = s->cluster_size;
> +    bs->bl.pdiscard_alignment = s->subcluster_size;
>   }
>   
>   static int GRAPH_UNLOCKED
> @@ -4112,19 +4112,19 @@ qcow2_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
>           return -ENOTSUP;
>       }
>   
> -    if (!QEMU_IS_ALIGNED(offset | bytes, s->cluster_size)) {
> -        assert(bytes < s->cluster_size);
> +    if (!QEMU_IS_ALIGNED(offset | bytes, bs->bl.pdiscard_alignment)) {
> +        assert(bytes < bs->bl.pdiscard_alignment);
>           /* Ignore partial clusters, except for the special case of the
>            * complete partial cluster at the end of an unaligned file */
> -        if (!QEMU_IS_ALIGNED(offset, s->cluster_size) ||
> +        if (!QEMU_IS_ALIGNED(offset, bs->bl.pdiscard_alignment) ||
>               offset + bytes != bs->total_sectors * BDRV_SECTOR_SIZE) {
>               return -ENOTSUP;
>           }
>       }
>   
>       qemu_co_mutex_lock(&s->lock);
> -    ret = qcow2_cluster_discard(bs, offset, bytes, QCOW2_DISCARD_REQUEST,
> -                                false);
> +    ret = qcow2_subcluster_discard(bs, offset, bytes, QCOW2_DISCARD_REQUEST,
> +                                   false);
>       qemu_co_mutex_unlock(&s->lock);
>       return ret;
>   }
> @@ -4335,10 +4335,10 @@ qcow2_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
>               goto fail;
>           }
>   
> -        ret = qcow2_cluster_discard(bs, ROUND_UP(offset, s->cluster_size),
> -                                    old_length - ROUND_UP(offset,
> -                                                          s->cluster_size),
> -                                    QCOW2_DISCARD_ALWAYS, true);
> +        ret = qcow2_subcluster_discard(bs, ROUND_UP(offset, s->cluster_size),
> +                                       old_length - ROUND_UP(offset,
> +                                                             s->cluster_size),
> +                                       QCOW2_DISCARD_ALWAYS, true);
>           if (ret < 0) {
>               error_setg_errno(errp, -ret, "Failed to discard cropped clusters");
>               goto fail;
> @@ -5032,8 +5032,9 @@ static int GRAPH_RDLOCK qcow2_make_empty(BlockDriverState *bs)
>            * default action for this kind of discard is to pass the discard,
>            * which will ideally result in an actually smaller image file, as
>            * is probably desired. */
> -        ret = qcow2_cluster_discard(bs, offset, MIN(step, end_offset - offset),
> -                                    QCOW2_DISCARD_SNAPSHOT, true);
> +        ret = qcow2_subcluster_discard(bs, offset,
> +                                       MIN(step, end_offset - offset),
> +                                       QCOW2_DISCARD_SNAPSHOT, true);
>           if (ret < 0) {
>               break;
>           }
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 197bdcdf53..a65c185b51 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -953,8 +953,8 @@ void coroutine_fn GRAPH_RDLOCK
>   qcow2_alloc_cluster_abort(BlockDriverState *bs, QCowL2Meta *m);
>   
>   int GRAPH_RDLOCK
> -qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
> -                      enum qcow2_discard_type type, bool full_discard);
> +qcow2_subcluster_discard(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
> +                         enum qcow2_discard_type type, bool full_discard);
>   
>   int coroutine_fn GRAPH_RDLOCK
>   qcow2_subcluster_zeroize(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
> diff --git a/tests/qemu-iotests/271 b/tests/qemu-iotests/271
> index 59a6fafa2f..04c57813c2 100755
> --- a/tests/qemu-iotests/271
> +++ b/tests/qemu-iotests/271
> @@ -518,7 +518,7 @@ done
>   ############################################################
>   ############################################################
>   
> -# Test qcow2_cluster_discard() with full and normal discards
> +# Test qcow2_subcluster_discard() with full and normal discards
>   for use_backing_file in yes no; do
>       echo
>       echo "### Discarding clusters with non-zero bitmaps (backing file: $use_backing_file) ###"
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

-- 
Best regards,
Alexander Ivanov


