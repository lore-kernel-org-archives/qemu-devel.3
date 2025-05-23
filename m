Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F2CC54EDA
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 17:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIW6G-00042r-Jf; Fri, 23 May 2025 13:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1uIW6D-00041w-8T; Fri, 23 May 2025 13:22:25 -0400
Received: from mail-am7eur03on20725.outbound.protection.outlook.com
 ([2a01:111:f403:260e::725]
 helo=EUR03-AM7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1uIW6B-0004wB-7T; Fri, 23 May 2025 13:22:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CsAVazPjho0nG1/VErCmy8X6dlqx9WhyKgWv6Fa59eHtQz4XjZ9yAhHZ1h8l4kqFQ8J4vheCWHZmDCQlHBpd0dbhhBzglSkZ/ZjAxisxawibILG66Mt9/EtmQoUIVniXCSgu4eTIN3tS1iZhjnFNo6dEE5BPS8IAoNvuayyXxtRVB2mvG4tf0krprSJJEZU20z9nmgMsR648hi2zGNHcW5CDczYf8O3Hh6ec1eUWE0zybsOaiPbff3udr+//dsCJu2XzXQ0nhh9WIk6Pxvkd0R+3ly81T+0zah/5lA0a97NMwXeYvtk3CNFk3t0hCe/3Vqiye98Yit9yvpHNIZJ0HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRHfuNmeTq9W6kwSOzNLkAVV9e7a8ZgzDoiuItYx0xw=;
 b=CUqzyLj3Oqa2pFVsOL5r/sFehVF+zhrPsZhZyg+lII3B2umejoB0/o6BTN4HsenQQ/DYufyjx+Ko03ZEWIQquZ3RbC5nfq2MC8jrLNmKyNJN7BY/VFcIXnhxawSQg7mwLA9Ex8xwAaBDBvhrE/MNhEwGU6dHIrz3ovpWwFaK4uJzikAs/I6+Dh8Q7JQ5BKwvl1Du7n1phoisFn3uBrj3l28S1dvIKyQMWzrbkGOV7x+EPAwtgD+v9QARMfosmne47FfrHFxJv0+vw4f5CIa24kqfJQ58T8oU0oVxW7CvTYDlHDPk9EEeqpaFSYw/OfbdhWjwpudbwZMuhiAUg6Abng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRHfuNmeTq9W6kwSOzNLkAVV9e7a8ZgzDoiuItYx0xw=;
 b=DqCm3TxroT6KWtG5ym4ebIffL5S+n0NmSoGk/mRE/xIPMJCrj6eNhEAU44lravqqCAszeV3uEmxSk0pCPof0XUeTRj/keCXIbKJBDKfo1haebVnjb+0P0xz64LwXCHG6aIQFptLkJnhUc4gD742tBDIv/gMFZmLzaqB/xUG/XfWE9wXJ5ki03GsAOrQqPhbiRnCxd/Zvbsusxr9+66cBKCbwVj9cZQjgE5sZyLKvFmoVfeV6LNgWBAevMmn+tJSEROwqUZCx+IiR5BIcr4AjJKVuRTfpzuXr68I9KfdS5VSqquuxm3J+TRKbaLQwOfxK+yAf+4K9b+HRCRc925TQwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB9364.eurprd08.prod.outlook.com
 (2603:10a6:20b:5ab::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Fri, 23 May
 2025 17:22:18 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%4]) with mapi id 15.20.8746.035; Fri, 23 May 2025
 17:22:18 +0000
Message-ID: <9f8355c0-3e00-4e9b-b8dd-3997f5236a6a@virtuozzo.com>
Date: Fri, 23 May 2025 20:20:24 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/24] block: mark bdrv_child_change_aio_context()
 GRAPH_RDLOCK
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 hreitz@redhat.com, stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, xiechanglong.d@gmail.com,
 wencongyang2@huawei.com, berto@igalia.com, fam@euphon.net, ari@tuxera.com
References: <20250520103012.424311-1-f.ebner@proxmox.com>
 <20250520103012.424311-8-f.ebner@proxmox.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20250520103012.424311-8-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB9364:EE_
X-MS-Office365-Filtering-Correlation-Id: 928d0c90-54e8-4aed-0918-08dd9a1e5e58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0F2c29FYlZGcUxIRE92Ly9rSGw3eWVtdDJRckZVREFZTjExQW1KQm1zWVM2?=
 =?utf-8?B?MnBHai9IZENEdXM5Tm9aZzFyN3BZdmFvZFNzZm13c0RhYXpZR1B0VkRaN0xB?=
 =?utf-8?B?R05WRm9wOUNjaHR4SUJ0d0pLM0FlWVRGZ1RhZ2NXVEFuV3lMcWpnSXNrYzMz?=
 =?utf-8?B?TWpabnF2N1ZicDR0SGhWTjdpYVkvSWJubE1ITkVDUTJKZkp3T1lPMG8xbHh5?=
 =?utf-8?B?WXdCcU12ZDRVeTVMSjdod21qN2lqRVFkTlhYcHMxVXhveTZMTnNFTS80M05Z?=
 =?utf-8?B?cTFkR2RPTE1qZ005Q1VDZkNtWDByazNzeEFxWEc5b1BoTEFMQVlyRTIxZkpr?=
 =?utf-8?B?NGNLYVdPM0tQQ0dTTkhaek1wTjN5ckIrNTdTajB2YjcxcHVBR3dPQUNUY0tw?=
 =?utf-8?B?T0tnVnR1d3FRQUd4RllTM3RGY2pTMTJXMDZFazJqRVZ1aTg1YXlneG14aGZF?=
 =?utf-8?B?eGhpdkNzbGd6SVJVMkc5Rk9DR2JNUkMzcnJlbCtLV1hvQkN3RitkN1lNdTFo?=
 =?utf-8?B?RTA5bjRCQlN4L016NW1jU2V0MjQvNnVvK0s2S29PZFV5RTBnWUNWSEtIZ2Y3?=
 =?utf-8?B?NGd0OVdXOVVUdEVVNXorVkh5V2YzdDdsRlg2OCtRL0I1QllnVElYanhPdDJj?=
 =?utf-8?B?bGF3T0owaUNmMmJnUGg0dS9JSTVVckpseTJzcVB0ZzBWSWZWamFFamhkSDNt?=
 =?utf-8?B?MEMwdGVmMVRaUEszWVdSUXZCdnNqVkdUNWRQd1JlcWFGZGxGalhCWFNjaU43?=
 =?utf-8?B?T0VOcmtyMVBRaE8yNXNlV0tlQm40QkZZU1VXTGR1b1ljKzd2MWUvRnNzSTBT?=
 =?utf-8?B?TG8yWjJhTU8wMVYrUG5SZnI3U3VLc0JJdE01VGRnT0pyb0N2Sy9nc2p4WEYy?=
 =?utf-8?B?WEdINnFrTWxGL2hXZEEvU2E3R2J3cmFrUVFWQjJLanlhQ083aHhzSFZPUmpF?=
 =?utf-8?B?Um1JU1N0dHg4U2NTVk1KYkF3TUxQTTNVbngzVDRhMjVqU0JWYUhaYTNpNTkr?=
 =?utf-8?B?QVlqWm93cDVsWmx2TU9BbGtoRVFQUmdFa1E0MmM0N1dSRHI2QUdFRTA4R1h5?=
 =?utf-8?B?T2VJbnIrUGZpcHNNSXd6T3JVNkNucEdINFdEN1V6bUZROVR2OXB0dWk5TmFq?=
 =?utf-8?B?S0FaSVdweVhKZ3JyMVI0bHFVRGw5NmxuVXFTNnZXSHFqRDFzT054WW1jT08v?=
 =?utf-8?B?RVBYM3VUcml1cUJlMCtxK2pmQml2RndqajVOdEJ5bFpYTVkySUVDL20yaU1H?=
 =?utf-8?B?aFI5cXZGU3FDVVRqblR3TlRYOWdIcHhkREl0WU9mWmM5WjR5bjZNMlViSk9v?=
 =?utf-8?B?OWtBTXBxMWNENGlOZVQxdkloYjBHRWJrNW1BRm5IeU5KMUVUbXJub2RJSU9G?=
 =?utf-8?B?VXVLZWFEcFRLMjJISjhsaUphbWo1L282UXNXRE9OSFBRVmQyUlJ2ekpWNHQz?=
 =?utf-8?B?SW1YSzVHU2lDRFF4a3NFTXEvdWZja09vWmhEcW9MR3JaUGZRend5NFFyb09B?=
 =?utf-8?B?UzlPSDZJMHlPZnlXNW9YeTNsVWhud3hJdU9MUWsyMjEzelE2YWhHVWxIUytQ?=
 =?utf-8?B?TjBHNU9wekd1cUs4OFVDNzZHWjRhQ0U3WVFCSmw5ZzBiVC9aTjVFcy96b0lt?=
 =?utf-8?B?WlA5N3F4Mm53aTQwdUo4bWM2MzV4MUxZd0F6V2pJUE9ZRkNkTTRkTnB5eXpr?=
 =?utf-8?B?S2hGRmJqT1hjS2ZmZjRlL2Qza2xWNnNsUC9JQVVrK1AvZmoxOGFYYktVblFG?=
 =?utf-8?B?M2V4RVFua2RwNEtHQkhucTFidVpzVkkwNmdXTlpCWmZsdy9FK1YvcEh0REln?=
 =?utf-8?B?dUVBZEdYdXNFdUlWU2hudlJPdnpDZGhrZDU5ZGdjSGZzNWM0SEwwSmZaaUxl?=
 =?utf-8?B?TlJ4ZVJDczlHeE5oblZWTmhRQjZja0VkOWlGSlB3UzhORkVsTi9abkVTWjho?=
 =?utf-8?Q?fMiYlsMZs0w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk90SWc2ZUJXaG4rL2x5ZGpEZU91RGlIZVk0UytpVytqRlFNSWJncUNPN2Ri?=
 =?utf-8?B?TkxYekJEVE9BVU5Ga2Y3Z25TUVlMemNZa0RXOEZGcVdBN0dmSmNJajZsbldV?=
 =?utf-8?B?QW8wdU5LendpYi9oY1NqTTZQNnRKWUJIVGRxNDlvRWpFcS80Y2RjajY1OEZD?=
 =?utf-8?B?YzJJRUdYY1d6RFJwd29vMzFIRmtmcm0vUS9rYmp1ZUJLRlRrMEtsSXRkNGpB?=
 =?utf-8?B?VWlNbkJsUnhwTnhlL2k5SGJUSGZLY3UvVUtTb2NMSDQzWHFMT2JNSjF4VGpT?=
 =?utf-8?B?bkQ2OWlkS1ROMnRaVm1hRWxZTUNTeCtVU3gweDd1cE1qSk11eWRwdUlGc1Yr?=
 =?utf-8?B?aHNUYVU3K1V3VmRGUnRlczZJYUI1bkkzMEwrTlNwdW9WdkpxRUdNZTlQRld6?=
 =?utf-8?B?d0lsaFVMNUdSSzAxZ2hSUEdBUjVKYW9BeGxyNU9Sb0ZQYlNXeG9ZK21kTnda?=
 =?utf-8?B?UnVMdG1yUW1GbncrZThHMytTV2IxMEhUS1VFVmVhdXhtbTBZNW9hemplUlQ3?=
 =?utf-8?B?R255eERRM2hvMGllUG5tR0RZWUMrREhLQjZ6YlJ6SFRLUmd0ZEpRMnBWL0Jn?=
 =?utf-8?B?M2JUUTVpNkZoN2R5L21QTzRsZStKVkVlL0ZjRHU4Q0VCN29QVkdmMllmZUpq?=
 =?utf-8?B?aDhlZm8xTlhBcnVMTDdvMlFDTysrekpwNUt3cUtScmVCT3ZrK005aUI5QlZi?=
 =?utf-8?B?NkQycVNoRWkzM0NBd2I0K3hwV05OVjJEalI3bm9WS28vR2tDMkgxTnlVbG1a?=
 =?utf-8?B?QWFsOWRTYmFDWCtqRityelRuWmUwWGVqOGtBcFkwV2R6RmpFTm84eGxObGg4?=
 =?utf-8?B?SHl2bFhudzJoYzk3TVVwemxLa2h2Z3F5U3VQelFjUEVIelNya2Nsb1R5OHJy?=
 =?utf-8?B?QWJPMzFoaFdJdm5oMnYreHdON1pySXo0bElCTzB3d0FrRlpKQmFPUHNYdUpJ?=
 =?utf-8?B?RU5CQWRCY3d1QUk1dncyZUd1VnJXdlhmakR0THFjL3lsNlBVeWhnK1dHRkpP?=
 =?utf-8?B?eEpQUjAra0ltRXdzU2F0dG56bGtncHpaVkxPdU8wM3IzQkt6eDRXR3FsaUx6?=
 =?utf-8?B?OUNMdlE1ZitsWExmMU9RSEpWeHNpaVUyUGpiQXZORGI4V1lMQnJnMGZjZWZz?=
 =?utf-8?B?d1VFTVAwQ2ZVMExlM0poWDdzWHZIcldpRlM1Q0daaUUvbWlCUnJLNFVHQjlK?=
 =?utf-8?B?bm5XdXpCQ3Q0Z2ZEMGRSZG1kZjlwUjd2RTl4eDFyN2drc2NMLzVRTGRPcGxH?=
 =?utf-8?B?cGVJUmJsSndDMzVvMnRzNDhwMW9Vb2VpZmVMNE54TUV5cTh1ekg3RWNENjZo?=
 =?utf-8?B?UXpjMml1TTZwM2NXcnBUaUFZOTEya3Z0UGNrMFJmc2V4bmtIYWo1NkdIUk5s?=
 =?utf-8?B?eVpyY2poSWcxVnNjOVFCNG9XYXBYQUh6ZkM4V3M1Zk9NV3A3a1h2UTZWZXYr?=
 =?utf-8?B?b1VDOHlWZjBYcmc1eUFiYnJmSW9sUytTUjBTck15WjUwTTBpWGh4RVAwQ3gy?=
 =?utf-8?B?UlNyeDNQcEladi9kSDVZRVFuOE9DSjJxWlJ4OWhZMTJTeWU3bWFCaXUxMUlW?=
 =?utf-8?B?emVzeU1uSlZSZEd2em1sOE80MWZWQkRBOEVaUXJTUjRIUW50MFVTZmdJV1c4?=
 =?utf-8?B?c2lTT2I5VktETS9pTElhWVlkbk9zT00xNFk3OFJxNWJKNWY0T0xTTXplTkRY?=
 =?utf-8?B?NnVtMVcydEtWclVaaHI4bnVVYmw5V3kyR1UxeURaUVlLL1NidVQxNTl4eXhQ?=
 =?utf-8?B?MEs5MUJYVlhYU3RxQmRFZ0JscjcrVmhjSnk1eVJNdXpOTWhBVjB2VklWdm5a?=
 =?utf-8?B?Q2czTmp2RE1scm9WVysrR0JWQ3N1UndUZWFHTURoQ25hNXRtem1Mc05vcVc1?=
 =?utf-8?B?THVxT2loNlpOQWwwSFFJajFRUTBRN3lDMUZCd0NIMnB0M1MyZko3ekxwd1By?=
 =?utf-8?B?VENLeTExUU9hYkprK3ltOG5PSkpKMEZlVmd2a3VhUlBKdkhkUzBNZzIrOWFt?=
 =?utf-8?B?RVBqV0FmNk02Qk1Kd1RUZWwzSXh5ZkRCQmVIVG01N0JUUHBaNHpvR3VEdGp3?=
 =?utf-8?B?RVNpRFkxZTFBNHhoUlZyL3BUKzZzcWZ2YVk0aFBQRDlXenI4VVRCcFdPdito?=
 =?utf-8?B?UEhqWTRXeitLUHhoZDl0WVZrY1M5aklzbzZtcXYyZmlnRUdzbStSL0VuWTZn?=
 =?utf-8?B?WlE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 928d0c90-54e8-4aed-0918-08dd9a1e5e58
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 17:22:18.0977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mtlj+y9OjtDksp87C/tq9ZTaxgdwSEVe7IyDL3OgvW6t9P8BhoF5r/PHFmT5f4ssI/yFtjnoKAJaPSNYxZKHXslKGhcHSP8V3OJHCIhiLnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9364
Received-SPF: pass client-ip=2a01:111:f403:260e::725;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR03-AM7-obe.outbound.protection.outlook.com
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

On 5/20/25 1:29 PM, Fiona Ebner wrote:
> This is a small step in preparation to mark bdrv_drained_begin() as
> GRAPH_UNLOCKED. More concretely, it is in preparatoin to move the
> drain out of bdrv_change_aio_context() and marking that function as
> GRAPH_RDLOCK.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
> 
> New in v2.
> 
>  include/block/block-global-state.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
> index 9be34b3c99..aad160956a 100644
> --- a/include/block/block-global-state.h
> +++ b/include/block/block-global-state.h
> @@ -274,9 +274,10 @@ int bdrv_debug_remove_breakpoint(BlockDriverState *bs, const char *tag);
>  int bdrv_debug_resume(BlockDriverState *bs, const char *tag);
>  bool bdrv_debug_is_suspended(BlockDriverState *bs, const char *tag);
>  
> -bool bdrv_child_change_aio_context(BdrvChild *c, AioContext *ctx,
> -                                   GHashTable *visited, Transaction *tran,
> -                                   Error **errp);
> +bool GRAPH_RDLOCK
> +bdrv_child_change_aio_context(BdrvChild *c, AioContext *ctx,
> +                              GHashTable *visited, Transaction *tran,
> +                              Error **errp);
>  int bdrv_try_change_aio_context(BlockDriverState *bs, AioContext *ctx,
>                                  BdrvChild *ignore_child, Error **errp);
>  

I think we might as well add the GRAPH_RDLOCK mark to the actual
function definition in block.c for better readability.

Andrey

