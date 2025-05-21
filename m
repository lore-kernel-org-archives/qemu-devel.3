Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8520DC54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 10:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHgfL-0000JX-Br; Wed, 21 May 2025 06:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1uHgfF-0000Ij-FJ; Wed, 21 May 2025 06:27:09 -0400
Received: from mail-db8eur05on2071d.outbound.protection.outlook.com
 ([2a01:111:f403:2614::71d]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1uHgf8-0006IW-Hn; Wed, 21 May 2025 06:27:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugK6XSyDkAbqjP0zw3RAhV+3MJkC5rupVHpiuojSYaOVGRuWyVycCkZ5yjwBG6kqsW+dyNp7qx2znFY+YzuKiHYoJ+bEA69vFnBUrGlw197TaI4qWBCHQTwA6RMiG76CzKom4b7PNXm5Ioaf6icGiTIF9+MLEgTOqOEW5uhWu+52KO/dmKR+1hLCiaRUAAvPqmnzvOEv86dQaYiIVcErMUitL9mpLTIAqeRy4qf+bEpO0jb8BKhXRX7HXOlF3ECSrKzf73Hf3SRgKBIkm5wFwVpyFBrt4X5/3lcyN7TifVOMtU9vUOz2dESrdcMm4ZYbPjhUzqRh9GILSM8M23B/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RYMgH6WAWfv0mpOe7kJJgEkVZE8n60jd1QCFhBbcGE=;
 b=oDOhkqbf/BQ15wvKI2r4ziSaO6rYwN/e55JplAKNwVzi7H1ccIxtz2SfqcTzF4yTbq7N3pJv+KFKDtJtP8L34I3wBDwxwOQZO/LBZkeasSMlWnUXziiYjnP8M71B00i7+CrNEEUP5KRSM+gaaFo3gvtMax5/AZtN+JMP+HpH55YYT+/0okA8R9cgiNzb/AxqNghUqqT+YZmunVaRlmHtkZl9T7N7pRkX2U+Nzkopj/EYU+t889wAUjQuu/6x+36734WzfYTq0H09iEx9qyriuMzIsBz7PO824rZGe4HY/iauEldvk71iUlqy58cGjDYHzYnOnK456HkEVSCkED7crA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RYMgH6WAWfv0mpOe7kJJgEkVZE8n60jd1QCFhBbcGE=;
 b=XP8XBZ+1p1nUT/TCoC7gzEl2I2Whl+nPAu086cJqq+3n/gNJxvZD2H5tOVktQBO4ecvgB3VpHYBpS5u3NgiLsaocBYBNfJaIxN+L11zJTIsWJKTQf3rqgaUpspjviPxdAml7CUGg6Eh+cekwbAG5G0HZq590v+3s9GcyE4qYzeYdJHd6FYzK12aSYk1RaAC57CUd92Gckfx6jTenKEaDVBF0jUg6TP50dNV6z6IJf1L3akyRzacvjmGaKamENFFBRJRGMKRbMDzQyyLN0DsZeKMWk2gcGlZVmYS/h4UCe71xZy8D+40B7jaN+UTqRQ8FffqSfgkydilL13vW+jutsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM8PR08MB5732.eurprd08.prod.outlook.com (2603:10a6:20b:1d4::16)
 by DB3PR08MB8795.eurprd08.prod.outlook.com (2603:10a6:10:432::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.19; Wed, 21 May
 2025 10:26:55 +0000
Received: from AM8PR08MB5732.eurprd08.prod.outlook.com
 ([fe80::e543:a83c:a260:602b]) by AM8PR08MB5732.eurprd08.prod.outlook.com
 ([fe80::e543:a83c:a260:602b%5]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 10:26:54 +0000
Message-ID: <791949d4-8931-43e6-93fc-5e4ffcf1328e@virtuozzo.com>
Date: Wed, 21 May 2025 12:26:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hbitmap: introduce hbitmap_reverse()
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru, jsnow@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, qemu-devel@nongnu.org,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
References: <20250513013238.1213539-1-andrey.zhadchenko@virtuozzo.com>
 <20250513013238.1213539-3-andrey.zhadchenko@virtuozzo.com>
 <x6elam26xqiepon2bvrhpejczvia6ksqn4xviov5vhh7e7vfrc@yucgtxyeabe7>
Content-Language: en-US
From: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
In-Reply-To: <x6elam26xqiepon2bvrhpejczvia6ksqn4xviov5vhh7e7vfrc@yucgtxyeabe7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0295.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::9) To AM8PR08MB5732.eurprd08.prod.outlook.com
 (2603:10a6:20b:1d4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR08MB5732:EE_|DB3PR08MB8795:EE_
X-MS-Office365-Filtering-Correlation-Id: 469ee07e-f9f7-4813-8ee2-08dd9852018f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OXBGbVRPV25ocTd6cnJ3TE05RTEvYmsvN0F6L2dVMkdKcnROZmF0V1NacXp5?=
 =?utf-8?B?MS9mMm1PelNIaE9hWVoyV3BQa29IRHErVENvL29sOTQ0ZTBDK3VUSXJRakhr?=
 =?utf-8?B?dTFIU05uUUJ1SVNaZFgwNFI3dC9rYVpOb3NTUURZcTBseFpobSsxRjRNbEJI?=
 =?utf-8?B?R21NWXdDTGVQbys3bEJwSStyRCsvbmZXT2lwaDNVOGNiaEcwWFU2YVVvN1Jh?=
 =?utf-8?B?Vmo4OTZ3d1BqOC9BRmNtV0lWL1BtNjBobnVwZEJ0aGFyMUduc01iTzNOYlp6?=
 =?utf-8?B?N0o5WVRIeFlMV2k0OUNXbWl1dDkrMVhobnR5VU9IWXRWamFYUGlVUk05eWFP?=
 =?utf-8?B?SnovcWZJamordmlIOElEaFVHWi9VVVQvNmIxRlFwdUhicTJGcTlkVGlhdW9V?=
 =?utf-8?B?TGQ0VStBM0s5UGExNmEwRmxvMGl0dVpPNTNMZERJeGVhWkVNR1dhS2cxdG9C?=
 =?utf-8?B?a1VKNDBETHllbDU4eVNyYzgxUTFwaFpFWnVJTzVJV1J0aCtJaFR5TEFwTGta?=
 =?utf-8?B?S3I3ZURuRXJhV1VYNEs4aUVmZVpaUWVXMElRVDRyY1luVE9ld3VkaFdJQ1Ez?=
 =?utf-8?B?RjBSb0s1RnJqK1F4RytYOFY5WTJqcEJNYlV1MU1MSmdrVEY4NTFoTk5oVG9M?=
 =?utf-8?B?Z3VVU2p1bXpZUHMyMGtyWTZ5cTQ4cEk4Z05FN1E2Wnprb0toTCtwZTN4SkhD?=
 =?utf-8?B?WGxHV2JxdFFEbUU5VGZYekhmbEFhL0xkZTZTb3liVlIxenJjenEyeDMxWkpq?=
 =?utf-8?B?K3lyVkRpRGNreWovak5ibHBVZTZxK3QzUWVkd0dqOGVMLzQrOXVPMkd3cUVj?=
 =?utf-8?B?OVkyYzBjMG9ReC9jTWlTYlZNZG5EQkVJdGh3K0pXUFFPalhHcE9xUmU5ZE8w?=
 =?utf-8?B?dHF6TXZRcDd3ME5IWkdjM1lXU2ZPZUNKMkF0d0s4bzVBdzVhbk1iTlBOWWYz?=
 =?utf-8?B?VlFNK2ZrR2g1SjR2UnhjdjIzakU3c3EwalFFcUhLNUZVZmpvSjhLQ1hpWkZW?=
 =?utf-8?B?V0pKdDdiQjQyeXBld0cyM1l2UFFNeXlrd0RVTUgxNVdIaGM0SEZtRURjSnZZ?=
 =?utf-8?B?bFpwUWFVTXdWSmFhdlgvKzJlOU1VYStFRUpqT0NmTVdCYmJDeXM0clN2enQy?=
 =?utf-8?B?ZFFROHlJMVN2aXZtTjZxcURkUVk0eG9UOUlNZDNReGoyeU9memhPeWpEZkFp?=
 =?utf-8?B?L0VMblZyd0dyUDdBQy8vNEovOVlIRUVBUXJEMlBUVWJyN0dSLzAxVmgxTzk0?=
 =?utf-8?B?alRlc2FBVWxiRmZQMEdrUVE0SXlPZkhCL3ZOSTZwNXZlSGczdmUyZ09tL1Bt?=
 =?utf-8?B?YzlvVjA5NXh0SkdvcjdWR3pzTFZ3QzZxbDRWSGNXY3lMekVnOEV2cm8vcWVK?=
 =?utf-8?B?cmh4ZUlmOStqZ3N2THJkZ1VnY2d0WnV0VW9wWnV6V3VITGVwdWZzU0RFdUJO?=
 =?utf-8?B?VzFySFhCT1E0SldLenQvT3Y2WndUUTVnOThsZkMrY05ZRjk5ejVBYzcvdEp2?=
 =?utf-8?B?TW10RWIvU2ZNOFBMZkdWZjdZbFZLQ3phZjFZOTB1S3NJUkd5ZWFtem1xNDBl?=
 =?utf-8?B?RGVBY0FGMVBpQklGdkpkcjlFSTlSclM2bEt1KzVIc2x0aG9KUTVEY0V4ZDUr?=
 =?utf-8?B?d0hJaVNZdzFrQ0FESEZaNHFIY2IrRDR2alI0bXE1OHhGT0l1aTdGakswaWRX?=
 =?utf-8?B?OHFrVmJxbjJtenpoMnNxN0k0bkFUcG9hVnYxaWFnc1BNYi9yb2M0ek1POS9o?=
 =?utf-8?B?TUVZQm4vbGhRNDlCZ2dLa3lvOXRzdlNYd00wQ29lWGN3SUU4ZmpsNmVVNHBM?=
 =?utf-8?B?T0lCbkNPR2U3RmpjdFR4NTVoTzNHWi8vRFA3bzkzKzdNRGdOZGJsblVxamo3?=
 =?utf-8?B?Zm4rUnVkQWZXaWVVc0kyL0hlOC9GT01IWnh5RXBXUVhjYlE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR08MB5732.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDJ0alh5VlhVZWdlcXovdUUvejhUcUxjd1BmaEN4Unc5T1ZUaXViQzZxajZR?=
 =?utf-8?B?OWcyREZZcFJndHY1VnZNK3NrWVBuTlR2RDdJK21mNnk5d3lNT2krQ0NKWnJh?=
 =?utf-8?B?bkM3MUxmaVlsVjNjSDFhRlVtTFRUcDFNMWhiMDNtK2ppTGJuWjAwV3dhbXU3?=
 =?utf-8?B?NzB5YmNpeW1ZQ2NoazB3Z3k2Z0ptSXpscGJqODRqbDgxT2l5N2ZPNFRZSHF5?=
 =?utf-8?B?K0MzM0JVT1Awd2o2Zk5MVS9oWFFqU0hKSnh5Y1NiRnQ2WHRQNjBlNHF3dE1v?=
 =?utf-8?B?ckJkSm9yY2ppeVI1Q2hoUndPeXBMc3BjcVhWalRxbjJqSzEyNEQwbElzRlFs?=
 =?utf-8?B?MFZlY2FqcUJ4NHVlaFY3Z1FOUThoZzRWN0dJSjlic0IxNkVWbUlZMGFqY25m?=
 =?utf-8?B?c3FZaFA3L3RXSEJOaFBYbTNOTWlzRlFDTjVnVHFqZ3ZWMjAyN2srblcyWHNa?=
 =?utf-8?B?ViswK0FXV0JFNWZRNUtwUXBVMGJEYzdWVzVodmg4aTdyMW04NmVlR00wOEZI?=
 =?utf-8?B?cDd2WFdOamN0cWFyY1FsUEwza2d4ZnBkSnYyUjFYWUdFWk16UU54RklXNzlV?=
 =?utf-8?B?MFBpYVg1d01XWldub29ybUtrbitGZVVHcjM5VHBPOGVOSTVQZ1A4Nk9tOXRo?=
 =?utf-8?B?ZVd1ek8vWlNKUDYxeENjWVY4TjFFaE04aEJyaWs0SUdwSWE1RnY0S2JPSHh2?=
 =?utf-8?B?YytuWnVPVzFuNTZBeitpU2MveWFmVEY3Nk1qUXdpR2syUDlkS1FDV1FPVlFn?=
 =?utf-8?B?YlFyWThmeFZuK3NlbTJ3cDJveFZZSm5lUXFsWTduVU5jbEdlWWloOW5PWEJV?=
 =?utf-8?B?Nk5YVk9kc0cyZnhrMjduU0grd0NRbU5GaEQzbzFiZ1ZNMFlFNFFDMGR6NnpE?=
 =?utf-8?B?c3pHbWRyQTFxbERQY0tEeVFmcjh1SEllYU5nK2ZTeVY5RVVyUFRiZENZWGQr?=
 =?utf-8?B?Z1RJTExiYjliUXY3UFBJRnJLMXJrNFBVeUZ5ZTdBVXpSbnlvOEsrZXNiZjRY?=
 =?utf-8?B?ckJ4R3hFbk9TWFZwQ2hkMjRSUzRQbGJCZkhpYUFhOVQ4Y2c4SjNWcU4xQmhT?=
 =?utf-8?B?eWxKUlJPdzZxMmZZQ1NNQWZpaHJHeStaL1V3WGRLRnQycFZsUS96NWhGN2da?=
 =?utf-8?B?aVJiSUE0bm9lSjZSdnFwUjhYS2xiL2F4VEpxNFBFRFl1MGs5ejkrUVFwdFUw?=
 =?utf-8?B?emx0dlBpdkdQWTMyTVJkUVgybkEvSUM4bmhEek96ODkvOGVXbEkxM0hiTDA0?=
 =?utf-8?B?a0tmSnJkaFV0MS9pbHcrYmRqSjNsQldScGJDWElZSmJtUEhZSFNzaC81SHdU?=
 =?utf-8?B?YmZLMXozQXV0VGJLMU1BR1hHbjdYbUQxdDNVU01qbUpveWovZlJYeW5aN0JK?=
 =?utf-8?B?d3c5US8zbVNlUjNqS2szSHp5YmdwTEcycnA5MnducDlPbm9tODZnY3FBellt?=
 =?utf-8?B?eFhhZW9jT1oyRUFjRUFod2JQUmh4a3JPcklpbG1KdUF6bGhRQVREdm12bXAx?=
 =?utf-8?B?TVljUENrU2U1eGdBbHR1SGszZHpGTkY5eEpjTTFCdUJiV2RZYjNJVWFoRFNY?=
 =?utf-8?B?TVAxMi9obW5tNFE4dC9SbGkxS2RBTEdJeHgveEp4b1pxTHhnTG5GdTJuVmxD?=
 =?utf-8?B?UWhLRXpBUmZHNDhUMHh2U0RCZkdGQnVLT3czRnNsMlB3S2htZlBZUzE2eWlm?=
 =?utf-8?B?U080TmgwcFVzNUZwNUdqc2xoL09RbmpsQUNTTnVHYVNrNjQxb0tlWDFROFIv?=
 =?utf-8?B?UFNmT2JmZUtEWFF0Vy9UVzROOUhCQVl3Z3pCSkpZallDM01hK3Y2VXRsRDlS?=
 =?utf-8?B?TDVycEhRQWYzMVd2Tm5GbmkrZjB5TVEvREVrRnRtRkZNNVRYL1NJcGszTm5y?=
 =?utf-8?B?QzVld1lNSXNlc25OelhwYTJWZEdkdHBlRlRJcFI3Z2RFUDNwZDJWOC9HSUpv?=
 =?utf-8?B?a2xZcFk3RzQxajI5Z1NYRjQ3VWhUWVhreG44TjhFTTFhTWMranNTUkhNSXAz?=
 =?utf-8?B?S2Y5dmFlQnNZV29UTmxMRjlQWmxVcGIwSnFiVGFaVy9na0NMdXU0NHdOdUlr?=
 =?utf-8?B?aDBDYm1TZEJUNHArVmVGMW1Sb1hpVkI4MmJIaDNZMWp4eHFHeGIvZXlEeGhH?=
 =?utf-8?B?ekRaTytWOUh1OHNZUjd1ak0rWE9jRmxCNmpOS0I3Q1kyVUR3dytTbjZaaVBl?=
 =?utf-8?B?Snc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 469ee07e-f9f7-4813-8ee2-08dd9852018f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR08MB5732.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 10:26:53.9758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMI1a5aLY1TO9RrmB074e0abeLMwQRykReR7hsZLE7Zk5YAPT89VRbwENC4nt438tWqLE0V6UdTZdJgIx0TObvWjHBTLsa0dC06xTwGFs5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB8795
Received-SPF: pass client-ip=2a01:111:f403:2614::71d;
 envelope-from=andrey.zhadchenko@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
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



On 5/20/25 18:29, Eric Blake wrote:
> [?? ??????? ????????? ?????? ?? eblake@redhat.com. ???????, ?????? ??? ?????, ?? ?????? https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Tue, May 13, 2025 at 03:32:36AM +0200, Andrey Zhadchenko wrote:
>> and bdrv_dirty_bitmap_reverse() helper
> 
> Is 'inverse' a better name than 'reverse'?

Yeah, it sounds much better this way!
I will re-do the patchset

> 
>>
>> Signed-off-by: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
>> ---
>> +++ b/util/hbitmap.c
>> @@ -940,3 +940,18 @@ char *hbitmap_sha256(const HBitmap *bitmap, Error **errp)
>>
>>       return hash;
>>   }
>> +
>> +void hbitmap_reverse(HBitmap *bitmap)
>> +{
>> +    int64_t pnum, pos = 0;
>> +    int64_t size = bitmap->orig_size;
>> +
>> +    while (pos < size) {
>> +        if (hbitmap_status(bitmap, pos, size - pos, &pnum)) {
>> +            hbitmap_reset(bitmap, pos, pnum);
>> +        } else {
>> +            hbitmap_set(bitmap, pos, pnum);
>> +        }
> 
> To me, reverse on 1110000 would be 0000111 (swapping the order); while
> inverse would be 0001111 (swapping the bits but preserving the order).
> 
> The naming change will require respinning the series, but the concept
> makes sense.
 > > --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.
> Virtualization:  qemu.org | libguestfs.org
> 


