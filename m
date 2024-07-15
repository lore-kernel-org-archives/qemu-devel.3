Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8658BC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 07:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTGOU-0000jb-FK; Mon, 15 Jul 2024 03:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sTGOR-0000gR-6c; Mon, 15 Jul 2024 03:45:07 -0400
Received: from mail-am0eur02on20712.outbound.protection.outlook.com
 ([2a01:111:f403:2606::712]
 helo=EUR02-AM0-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sTGOH-0007DT-Sj; Mon, 15 Jul 2024 03:44:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XceeCF7HghcFqZOAdHZ8wMGAkPmZ+MD+ZKCtB2waP/ZVWphYM0zZkjpVZ63+br/Nk3b2Hrn3D+JIUNiBx9iGo5hvJISiRNCNz7KLwjIGpFYzYTeyi1bAvT3azzpqY/nZ3F9jmKJJ88kDVDswyS3cy2umIeVEPAZ2uFuymezPA+pdxFQxW0D0tykrxdUkgDQqVTQZtOpjXjGCRDr+qyKIPqf6xvO/qjKguPRvTwkIwqKXMVqxjABqaeSpfQRSZDMh9OmJKKUWbttoyOQwjbFzsOdocaov01Mbjxv25pfmF6M4ReV3etr5pGZTl3ndo7uAB6AhSC0JfAWBfA6z861UJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04HjlVpj4siRtD7bPYqmaZJae01EXGv96WjZb4WnD2A=;
 b=qQvWuA59wXZLhOxSejanpKVhTQVLVVEj3wWA7DUgt+MmRX+UMliOXUqYx+DuHpYrQK0kFI3oKYEMZ6FyH0tCqX6hNv+VVW2Kvgrbz7Ucctl2aQSz7X6lhC1M0HiSF7zsO47IXbPSRX/7rWWB+VKc/c8ejvjjWwmq6a65KXsjqpyY6VTXOJgzDrq7GKP0iEv8xGbnaiVf3RAnJdPOubL4bCD4N5FWI4kH1L+stRyxn79D1Yf/O6F5Nk+QNyObOOTCPWv8imAt9K0TBf1l6WQFxVwwwFeQZGOhoZxZ8nfD1/KLhmjAgPa2d0uOgatg69SrcaBiESTyJ0LcdP9k4q452g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04HjlVpj4siRtD7bPYqmaZJae01EXGv96WjZb4WnD2A=;
 b=kawA46QyMSlKeIafAQRBeOm0Ex6atJ1jcfOQ7rmwh/VA1N8/JQJH8ZzdwF5EmqgAVrlnrxBF9XuJ2ZEArGseQ7U2yZIdn4ASis+zk/o/G/Msbuj74sD69XXe0sQ78vfgGHtq3vYLN106fxS7P9Hs8wwQVcR8NSsP3RhxxZfHrzoGd7htBee9nwOfnmM5m8IJKVkVFm2Pr6kudopUTKXGKRGjW5APjGpzue5093NOgviYg7QwDn79d/4/Lj0doQz88QfwqEjIvp7QcGdh3ZBfu7rYZqNe4dytThoB5SIidLmsApnkuWyGBunLtIBJcSmApxd5iFrW6VhllNH4C4p99A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by VI1PR08MB10241.eurprd08.prod.outlook.com
 (2603:10a6:800:1be::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Mon, 15 Jul
 2024 07:44:43 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%3]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 07:44:42 +0000
Message-ID: <60a7976a-b9b5-4427-bfc4-103eef3e281f@virtuozzo.com>
Date: Mon, 15 Jul 2024 10:44:43 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] qcow2: make subclusters discardable
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, den@virtuozzo.com, stefanha@redhat.com
References: <20240513063203.113911-1-andrey.drobyshev@virtuozzo.com>
 <cbcee281-fdfb-4a7a-b33f-b71d90368059@virtuozzo.com>
 <e3bc4070-4b24-420e-9e98-376eee3659bc@virtuozzo.com>
 <126aefc2-de33-4b37-bd58-9d1079914ae6@virtuozzo.com>
 <f73e386f-643e-4776-8d16-2a43ee1b56aa@virtuozzo.com>
 <87b54f1d-aa46-4553-97f7-784dd74e700b@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <87b54f1d-aa46-4553-97f7-784dd74e700b@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0076.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::9) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|VI1PR08MB10241:EE_
X-MS-Office365-Filtering-Correlation-Id: 8634a8ec-b8d0-4d2c-c5ba-08dca4a1fd36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnkzOG5ST0RUeXVIcmNsVnB1b3dLSDFoU3BqbS9WbFcxbWhuR1BQUW55MVIv?=
 =?utf-8?B?RzZGS2NPWnQ3cjQ5NFAxSTBaV3RLa3FmbXVIdVRjU2FVcEFFc2NlMXAvdE5h?=
 =?utf-8?B?NnNJNjc0UWVQS1hvKzQ3S0NYZW8vTjFKTUF5VW9TN1diL3BLUkdvUmdnMWg4?=
 =?utf-8?B?Ync1Y0R4aUtJNjZWZ1pCc2YvOHJwc0czMEdYMFlYV3gwcGdGRFNic2ZVeFN4?=
 =?utf-8?B?ZmxRT0kyelR5eFZoL21oUmpDRGtvdjJ5bVRqdVgzRzFyOVpBWnVrU2VLZ1Q0?=
 =?utf-8?B?RmtGOUp6bFNvYkVCeWdXQWVNdEQvaENWaWpOU2JHN04veUc3MWhQa1p0NjJU?=
 =?utf-8?B?b3ZJNytuZEJUdFgxMDNwWGJkSHhIbEVNREFtSjN4Ri84UEg1d09yNEltZy8y?=
 =?utf-8?B?MzFCWmVobU4yOGpqTjNxWS9zMERYZVc3aXp5RXp1cFVnTnpST1pJQUNaZklR?=
 =?utf-8?B?b2lWRWVXUDkxclY5ZXdQTStQeWw2d2Y3UHZ5UXY4ZHVUVmhUeUNBanV1YzBG?=
 =?utf-8?B?ejBYUG5CZ25PcHpOem5GTnYwSHBKb3lzNFZ6Mk9ya1BMT3ZteXBIaGkrK1k0?=
 =?utf-8?B?U1ZTUFl2aXQrclBNSHYxcWdlTDVUQlNYUUhIRklXeDBmdmQ3eklkbGVMa3BV?=
 =?utf-8?B?VnFpekxpYlRYYTdkUVR6WGNZWGNob1hvZkFvZ3ZLM09MYzNucTVVcTFwQmZh?=
 =?utf-8?B?VHZKSDdjRGEzOTAvUmZUQ0dSaXlPZHZ2SmE4TjA3Q05NTUJvT3o5aUF4dU9S?=
 =?utf-8?B?Um11ZzFoL09SQ0ZxTnNUeGd3N2E1R2srY2R6VFVQUGdrcUtkSVVKNW91MDdR?=
 =?utf-8?B?djBtMlZiZEZCSmZ1Mk5vekNuS3R4VlljcTFvK2lOQmcyR09mTE5uQmF4UGsw?=
 =?utf-8?B?Tml0WUlKcUsybEFHN1c1RGxYOWFTUGNrMjdrQWR1bi9GM3czQzBySjZhZ2F5?=
 =?utf-8?B?cWRkWVdZWm44SlNCMC9ydW1zVHI0V0ZqQmk1a2VTbUV0RUJ0OGo5SmRwL2xv?=
 =?utf-8?B?d2V2bHVJVlM1SFBUK3UzcE11RVlQQU05ZkR6TURlYlI0V3FYZ1BlUW5Ha1Yz?=
 =?utf-8?B?cEY0VWcyMlZpTW91bFdybGxFSnRKQVlpYytxT0hnbGluSXhKdnBVQ1AydVZW?=
 =?utf-8?B?UU91VVBxdUcxQnpoOVVzMGNWSEhMUmFIYmkyTWN1ZTVBLzRLam1wWURGYzZS?=
 =?utf-8?B?USthQWd0UTlrN0lRWnNQQzVFellaS0JCSS9rWEE0WHRPaUlPdTZ4NGplODRC?=
 =?utf-8?B?YWdFVkR2QnpTZWZqbEkrQnQwUG5aT0dCUmxUWFFiNjRxTmJUOCs0M21JS0k0?=
 =?utf-8?B?c2VmdlptU3JyQWUzM3JNYnNjWGlMRW9sRFNrcHN3Vlh5VjA4RlJoeXJ0aFRa?=
 =?utf-8?B?eXJKdWdUb1E2djBwU1RlSmpZSW1IRm1nRFNFbFB5V2x4NFZ1TDFBbW80dDJt?=
 =?utf-8?B?bFp0UVphZ0VzY3dtcXFNTE1rdVpzSXpMU0ZIZjNvNnRVVzBuUEsyTFhWM1JW?=
 =?utf-8?B?UUxrdzBPUTNMSzNXZ1pySUhBbkVveDhDL0NHbWtoOTU5cDBDQytPR3dtUlpv?=
 =?utf-8?B?WmVUZEl3SzRKYVEweDlTd1orV2Z0ZkgxdVZHazFrT0hkS0tyTXNMREQwZ1Vt?=
 =?utf-8?B?b3ZZWmlmcUpWVXJrTHNWM1ZWVUpqM3g2dnRDa1psY1prWHV6Q0NsV1hSOE5B?=
 =?utf-8?B?OWVRMlpzZmpUeUhxWW8vMU1sZWtXUm53d1VMY1U0SjhlaE53MkQzalVJUEVB?=
 =?utf-8?Q?6zMoQy7ytVQBTKkjks=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU9JNDhRUUU0d0FpcllNTWJwbG84UVRwUFZ3NUZCcGRzeGFxakgrVTlHbnZp?=
 =?utf-8?B?T2lTQXRkSXA3c2dvZEE4ZkJTamVxM2tIRG5TOVU4YUN6S3FiU2xEMmhtT2d2?=
 =?utf-8?B?SVhHd0thUldsbDVhL0VXMkhnUHdhWnhEQ2NyQ3RxUFpNY0EweHdRS3c3M3lQ?=
 =?utf-8?B?NE9WZGhWZWI3cThnS2ZtbzZPclByUHNLV1lRT1YrT3lZVUNSbDIwL3lBa2FQ?=
 =?utf-8?B?eUlTWmUySkF5OTc0Ym4wWlNDK0JYcS8xL0NTNjhDd2srcjFGWXV0K0MvbDU2?=
 =?utf-8?B?dGNGQkhMRVZQdVgxMUxNa0ZRV1BKN1pUdWljNHlpdHNhUzNMUzd6NEs3TTVH?=
 =?utf-8?B?TnBNTlJ4eFRDTDBBNFZhS2NnWktZVWN6VHlrZm80bG5TSERiZ3E2a2kycGdl?=
 =?utf-8?B?cnV4Y1dPc2Q3UHZsV296cytRNW4xYTREUnRtWXZnN2ljalZ3c25xQmVBWG1k?=
 =?utf-8?B?bWplaXUxZzEyZU9uTmNzQnFwZlc3QmF0Rlk2SUlmY0NBTndFajQrNFNUSXVr?=
 =?utf-8?B?ODJDWDNWMGxZSGpSNjIzYTY1Ylp4dlMraTBLeC80aklMOVNKaFFWbm16cHZG?=
 =?utf-8?B?bnZIUHVUK2hjeUY0RW51TFpGWVN6bG5kQ1BDQUt1L1pRQXkyRzhRc2hhS05a?=
 =?utf-8?B?UlV3ekp2L2UvZGNCQTdwRmI0UDNicER3eUFBUzJBdHFuRkd1ZmplMDVGcHJ3?=
 =?utf-8?B?ZCtiT1oyMG42MGdQTTdjNndCSHN4YlBCdDlQbklsclhDdThKUzdSWlBCTkRZ?=
 =?utf-8?B?NTM0YXpYczJRRGQ4YVZCUWtJMFBBRW81UVhKWUx5WHhKa3lFWFVZTFFXSktu?=
 =?utf-8?B?OTYxZjM1YkVQc3JVeGFTTmVRdnF3d3dpcmlxQi95RW91VkplR3MyYWlzM0Vo?=
 =?utf-8?B?dUdzNEhZaW1wcVpOTnR5WDF2SENUb3BJd0NHSmlPWUIvNWdZZDZqWE5PbDJW?=
 =?utf-8?B?QTJ0dkNWSVIxVGR2aEI5TXc2UTlQOWkwdXJOL1p4WGxuY2lPbzhPZ2lyTllQ?=
 =?utf-8?B?c0xyT21FNmdZSmFwZk9taXVPbTZBSmR1eFpLQmpjQUhDcHVZVjlPbVZHbE5V?=
 =?utf-8?B?K2lKYzdNc0RuUytBeEZrUXFwR01WSC9FeWdYM3RUK2VldGs1eEtheVp6VHdO?=
 =?utf-8?B?YnJaTmlmZkZDb2hBdlBVeGIweGp3NlRrRlNkZk1lV2NzNEFlU3ZOR25TOUVL?=
 =?utf-8?B?V2lSb043MHBkTnVUdk9UOUF6MzFiUUpFV3c4RXc1UVFWUXA4OXhoc0Q1UFlR?=
 =?utf-8?B?VjhCcHNxc1NSOU9ZL2xpT0tqS2FSWXdoOGlITDU2TmJ0NEIzWmtaNzI4cUd3?=
 =?utf-8?B?NHpSazd2TXlWOG1PWmZwdGtIc295OHpsMWZOWmh4VHc1SmRaNFh0cmg0c2NL?=
 =?utf-8?B?cUZsYUtSU2tkSXpheURlTmdrL3dDbkx0OHJyWmVuR3g3U1h4Q2lYczc0RUJY?=
 =?utf-8?B?dGtzcHRpc1d4WmxER0hQejcvZjhLZDVBUXR1Ukt0RGlESGhEYWp6c0pkczVq?=
 =?utf-8?B?ZU5FUmFUY1U3SS9WOGhXWlVTdHF4c3JwVU95Y01sL1NjeVYxSGthc1hPMGxq?=
 =?utf-8?B?eXBjU0F3d3NrNmpNMlhEWGJXVWRHZnZ0RE1zQkFIMktna2ptRXE0QlFjYitn?=
 =?utf-8?B?NGhCY0VrdEsvSTFsZ2k2QVdKWjVaLzhaQnpmaFltY3U2RDU5KzY5U2xOaktu?=
 =?utf-8?B?Vm5YYStVcEFmUysycHVpcGlDa2grZlIxY0Q3VWIzVy94YXppWHg4Y0wyTW54?=
 =?utf-8?B?U1F6TTVEZ0xXaWFrSEFkaDB5ZStjQmxYZVg2YWdXdll2cHNDQkxtUjl2anB1?=
 =?utf-8?B?Ni9VWnV4SmJuZDdPenozTm1oVzJqaE1GRXQ1Wk1WSVZIQURKSzhtRFBWWDhj?=
 =?utf-8?B?WWFvOTRGV01XVzFlRmlLVWhOdlo5RVQ3ZVFDbThabnpRSk5vbkI0U3FobUJh?=
 =?utf-8?B?emRGRmZQMW9BYnc4cDR2NHYrNWJRTnIzZW1lQU4zQ3FjYzlWNzdrSDc1d0xT?=
 =?utf-8?B?N0FUenN6a1J2V0ZiS2Vyb1IwUCtNUWt1bFhLMkdsY25USVZkMjI5UVNNS1Vy?=
 =?utf-8?B?TkJidGdPWGVPUTBPa2NXQW9CRENyZTE3VjhQRFZlZEluZk51QjY0OEVkOU9F?=
 =?utf-8?B?dWlUb3VhQ0ZJTVp0QXVmUkJYZFhrYmU2ZlJsTHp0ZUdLSW5BTXJUM2QyYk9F?=
 =?utf-8?Q?pC66232/1OJ/jnsdZj+l2t8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8634a8ec-b8d0-4d2c-c5ba-08dca4a1fd36
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 07:44:42.6707 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8CS6ir+LDkHz3hKH4SUy2HqY7YXLML8WodToeIB7WlrTsnojD9Y/qQryIIfDZl3EfMUDqDbyrlyUIK0OfW+VZ1tYob0KPPtjUTnxS/laFBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10241
Received-SPF: pass client-ip=2a01:111:f403:2606::712;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR02-AM0-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On 7/8/24 10:06 AM, Andrey Drobyshev wrote:
> On 6/24/24 10:43 AM, Andrey Drobyshev wrote:
>> On 6/17/24 9:39 AM, Andrey Drobyshev wrote:
>>> On 6/10/24 11:53 AM, Andrey Drobyshev wrote:
>>>> On 6/3/24 12:19 PM, Andrey Drobyshev wrote:
>>>>> On 5/13/24 9:31 AM, Andrey Drobyshev wrote:
>>>>>> v1: https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg07223.html
>>>>>>
>>>>>> Andrey Drobyshev (11):
>>>>>>   qcow2: make function update_refcount_discard() global
>>>>>>   qcow2: simplify L2 entries accounting for discard-no-unref
>>>>>>   qcow2: put discard requests in the common queue when discard-no-unref
>>>>>>     enabled
>>>>>>   block/file-posix: add trace event for fallocate() calls
>>>>>>   iotests/common.rc: add disk_usage function
>>>>>>   iotests/290: add test case to check 'discard-no-unref' option behavior
>>>>>>   qcow2: add get_sc_range_info() helper for working with subcluster
>>>>>>     ranges
>>>>>>   qcow2: zeroize the entire cluster when there're no non-zero
>>>>>>     subclusters
>>>>>>   qcow2: make subclusters discardable
>>>>>>   qcow2: zero_l2_subclusters: fall through to discard operation when
>>>>>>     requested
>>>>>>   iotests/271: add test cases for subcluster-based discard/unmap
>>>>>>
>>>>>>  block/file-posix.c           |   1 +
>>>>>>  block/qcow2-cluster.c        | 346 ++++++++++++++++++++++++++++-------
>>>>>>  block/qcow2-refcount.c       |   8 +-
>>>>>>  block/qcow2-snapshot.c       |   6 +-
>>>>>>  block/qcow2.c                |  25 +--
>>>>>>  block/qcow2.h                |   6 +-
>>>>>>  block/trace-events           |   1 +
>>>>>>  tests/qemu-iotests/250       |   5 -
>>>>>>  tests/qemu-iotests/271       |  72 ++++++--
>>>>>>  tests/qemu-iotests/271.out   |  69 ++++++-
>>>>>>  tests/qemu-iotests/290       |  34 ++++
>>>>>>  tests/qemu-iotests/290.out   |  28 +++
>>>>>>  tests/qemu-iotests/common.rc |   6 +
>>>>>>  13 files changed, 490 insertions(+), 117 deletions(-)
>>>>>>
>>>>>
>>>>> Friendly ping
>>>>
>>>> Ping
>>>
>>> Friendly ping
>>
>> Yet another one
> 
> Ping

Another ping

