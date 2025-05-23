Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44840C54ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 17:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIW6J-000435-Cm; Fri, 23 May 2025 13:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1uIW6F-00042P-E3; Fri, 23 May 2025 13:22:27 -0400
Received: from mail-am7eur03on20725.outbound.protection.outlook.com
 ([2a01:111:f403:260e::725]
 helo=EUR03-AM7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1uIW6D-0004wB-Se; Fri, 23 May 2025 13:22:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vEoZzdHDWwjjRmkpKzBitTne5aIT4FZFPriUQPoTt9zftfrzkZCMpDLP7WIAf7ZZIG4WM+7tthqA33Z1UdmYN7RHDt46fzNJPe03BqFmlHRiXfu6+Fgn7xcl4Oz7aTrb+YpeWhNI4tIxpxU0D2tcE3oubqvXjRrvG9QgRcxRFpTysevRA8d58KytLeoibG0KvQBpRYUWu/sJwhHP81ymNiZ4IJxneNuAPUhVQZxj1+F4NLdgQJOrJDRGKUx18H+1J0II6wpCEcZaud5kEv9Oh/jmyJXHeUCUrDtxQKxtdqs9Yxk3lhEvTas4rPB2LLup/XLZU7jbqrO760kTvUllHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82SN5UcrDpY4oNAgM2k2vSMd5G1EJD9r0J9ILka09Zc=;
 b=cMSG9/0rZabHXRge100yor8XjVv4YJ7uRZbCvFhEQBRRD67OwwUJ+Dldjulm6xs7sRh0CHSa1XPAFQk+/aDjEcENnWp4o2xItEpjuxfEbYoxc7wHUuEpJvXTvG6sF2gFe+Hq0KKdADm8bL245E36mIRNQnAPeYQZGI0cjq6LATEWY0IUT8vLj9av/uVF+DOPn4i801k4SFdEzUO3FtF4bQmpsK7q5XXUWwzZMrEcSjX05UlAZb1BEOoHXb8vhzzOszuU0syYBQk1iXIxZhLF/pHcKx06sZTLHqtJ0zs8EXcgXoD1MkaD39p1e9hAZLqeJrYFi0hjS44e7upAeNrg4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82SN5UcrDpY4oNAgM2k2vSMd5G1EJD9r0J9ILka09Zc=;
 b=Yc3ZbxPqDeMYERShBV4tSO0Jg4YgZiFmom/wu8Qe6eFGh1MhKj2N/K3J4na1dHJnoHbvHwNyhpGpcD0B5LnKl3FaLcrPpWdhDTwUBmWo5UOENzksBe/f9/4PyBWygXykPcazzONsjH8vkxXQdxiUd/f77CoX3Ip02rNCvh1c6TYfpI2jsg2kbUw3uA/LKrn2zcvKUyVYVxo4+KF2Rzrzd5l0G/DdIb6Y8BD5yYGoh3r18iUeYLt8nsXGJ2aGrrxhEhQzxIZl++CohakYy+cYHIZiYG2sR+TPYwmfnQO27NNFs8YZEmoGi1bGX4gv/T4oBEnIEbzORyXgTfg9BA7Tug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB9364.eurprd08.prod.outlook.com
 (2603:10a6:20b:5ab::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Fri, 23 May
 2025 17:22:22 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%4]) with mapi id 15.20.8746.035; Fri, 23 May 2025
 17:22:22 +0000
Message-ID: <60217e17-e0db-4745-bcf1-8912f7c8676c@virtuozzo.com>
Date: Fri, 23 May 2025 20:20:29 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/24] block: mark bdrv_drained_begin() as
 GRAPH_UNLOCKED
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 hreitz@redhat.com, stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, xiechanglong.d@gmail.com,
 wencongyang2@huawei.com, berto@igalia.com, fam@euphon.net, ari@tuxera.com
References: <20250520103012.424311-1-f.ebner@proxmox.com>
 <20250520103012.424311-20-f.ebner@proxmox.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20250520103012.424311-20-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB9364:EE_
X-MS-Office365-Filtering-Correlation-Id: c179eaac-7419-4180-ea89-08dd9a1e60c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWtMcXd0SjFadFlMb0dhVm01V2JFeTlabXRHdDQwdGptL1dVdWFtbjRmVXZC?=
 =?utf-8?B?NyswcnpOaTJlbHFQSURjSFAyUHVReThXSEtqL293RWc3SVplZDRLOEFuQWRP?=
 =?utf-8?B?NnN3OUp6L1FWNks5V3NUREJnYkoyVkloQ1psRy9VNTE5NHlBYUx4NTNEY0M3?=
 =?utf-8?B?TkxPWVc0RXBSVDBJaUR4VG16dkE2YlBCaWtGKzRBcUpkOVdyL3p4VllOYkFx?=
 =?utf-8?B?RjN0L05jNU9hemhJZnhjRHlPNVlIR1ZNa2poanhRODVYdkpSOEZMZjFaTUNW?=
 =?utf-8?B?WG9ndXRsckdIK2xsUkkweU5SdXV1RSt3RVk1NVZHQXl0VHFtR3BvTlkwYnI1?=
 =?utf-8?B?KzNpKzVRRWZFd3FjZUJYek1JUThBRnNpanJ0NFhEcmxEN0ZXVVJtRnBTMlJJ?=
 =?utf-8?B?cTEzY3p5TXRMYncwZzJBTFpIdUZPTk9Id09ZL0lzc1NiaTRDNnVXSktGUFFl?=
 =?utf-8?B?TklIdkhLcTZ3d0ZINndiSHlnT3FVcTZEbHhrVk1rTXgrV21wU0dxbWFFdTlW?=
 =?utf-8?B?bVBTVkcxcWpyMnlZdFRKclZ5K2tnU29YVHRVNVEzSlFNKzFEdUhhN3FMNDdt?=
 =?utf-8?B?WjRxZndKRFBVWXlObUZEcVovdWVHaTlRaHRUN1k3VzF0dlZ1SkowMzN3K3cw?=
 =?utf-8?B?cHhMYkVEYVJ1R0I2YXQ1cmovbW8rTzJ6Z3dKa21NWHhKUkRGK3pkUVplN2xu?=
 =?utf-8?B?aS9qazkvSmdaYlFNT1JWYlhGWUVhV05Ra2JONEVWUGtOZTVkckFSRlJaeFYr?=
 =?utf-8?B?YWo1VnZvZitOc0ZFZG1DTzhSWko1NG9nVzNQMUxKdFRjRzlkNkF1MU1jaFlL?=
 =?utf-8?B?WWxybUtRL0x0cCsrWTdudFhjM1pJZnJ0dVlxdzJjL1NLUHErOVc5c0hPR05D?=
 =?utf-8?B?aTJNVTQveUFtMThYTXJIanVhcWg2cHpwRkYybHBMY3BhYzZLS29wdDRpYWFU?=
 =?utf-8?B?enloZGQyUDY4cE5JcGdHYXB4U2dJQlI2NXptUGkxZWJiMzRKYmpSV3A1Sm4z?=
 =?utf-8?B?OFNyQ25YUWUvRGlQNkhMUmQzakxuQnoxekJVSHM5Y2NYNHBxMmNweUREVjVm?=
 =?utf-8?B?WnRrN3QxeHRNdDRiYnVNQzlVSjV0aktEQ21OUzhlY0pwZ2lLYVBKVmtoQjBJ?=
 =?utf-8?B?WlBQdS81SlM3dEVBWE5SbUNhMlhNbXdkbmo5U2lOYlk1UDhnWkpFTkFHc0F5?=
 =?utf-8?B?NnNsbXNHV3VTYkEzREh0R3RKT3UxU1IrNENNT0JBZDV4eGJrUWsvUFZTWHho?=
 =?utf-8?B?M1RkcHRrS053cU1GS2pFeTA3ditvbnl3eEhZbW1WZ2tOUVRWMllXZ1ZraDRB?=
 =?utf-8?B?YzlmSTF2Rk5zM0cvWUxHajJuNW9rK3RnMlR4TmdtTFRaOXhzYzBpRGRUSXVW?=
 =?utf-8?B?VGdNSm9HU1kvcW9TNHJ1YWdYdzcvK1BKODB3RU5vakxUbjZja1BZOC9nZXFa?=
 =?utf-8?B?VHRhTG9oWFJqaHpyVkJMYnlIcy9Pdnp2TVRnNFBIZVRkWHVPVWpORnh3eklQ?=
 =?utf-8?B?WlRUekFmdkgwc040cjZsbG5jblJML1F2YTVSNitOUVJvRWhJbVJQVzVNaHRW?=
 =?utf-8?B?RldqZDJkYXA5eFhGMUYvdmZoMGlvdFRoWlNDZ1I4TTUveDR2ZEMrTEppVkdC?=
 =?utf-8?B?RTFsNVpNb2Vza3JVVWdHRmxpUlpPM1VkVVRFQm5sOVVEN0ZsRjVtYWltYUgy?=
 =?utf-8?B?ZkI3VDVqQ2tFZ01vQnZsNHVOdUFaWFhobUxwcjRYQWFQUFpmUkNSNlR5TUZq?=
 =?utf-8?B?STlqc1B2ZTIwcFpuQWNTTnBWbUVIZzVhQ2U2TFNxajRzL2ZRVTV2TndvMkJX?=
 =?utf-8?B?a0RnTnRSOGhNSG1FckhoUytuOHZYb2pzNUVZZFc2WndZQlJWY1VCNXJVTkNG?=
 =?utf-8?B?RnlHVG5pb05aalNpMG1aNXZOekJESTdBUHAvQ2Yramd2b1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWRWKzJBN3hTUDg3TDU0N0xUM1FMK3dtU3hhbEVUQVJwUm9XUVlSekQ3T041?=
 =?utf-8?B?Qm4yczMvNlJwTitBR1NadFk4eUxreFJqUE94Q1JpbldxWjQzd05jWXM1cGtV?=
 =?utf-8?B?di9SMVdTYzk0K094NFNENlBKRzZqU0c0NzBONitjbkR2SjNLelZlcXlCOHZN?=
 =?utf-8?B?aFRDVFhCeEdsTzVRT25xQzVwRDlMRHJPTTNTYkw0ZWo4dENhbGhJVmJPRXFj?=
 =?utf-8?B?Y3YxTHcxeXlDTGVyZkdLMmVScDZOMFNTdjJlNVNsZ0tsT3hIOVVBUXpRNHZW?=
 =?utf-8?B?NWZmTzVxbjF1VlRvUWlhZHdRRDFWdUR3cXVRaDdyWFJGRVdONFJmYWNMTWNi?=
 =?utf-8?B?WktiZk0xaVNzbFNnWENXVGtrYVFKQTIvc3R5OFFEZ1ZSejFZbmN0ejdVQU9z?=
 =?utf-8?B?THY4dGNVSFd6Zi9wL0lhbE5VK1VlRVhYbndWTE15VG54OEVNTko4NkdadkdV?=
 =?utf-8?B?TmNaUFFWUVZSQjE0ejh1RVdJOHJ0WGV3VDVnZkUyUDFiRCtkWk9oM3ZGR3FZ?=
 =?utf-8?B?VTZ6Ky9mTFBZV1FwdHR2c3FtaFFidnFkeWZRWVlqQ0oxa0lCQkk3NFZ6TWIw?=
 =?utf-8?B?RDcxNmRnSEEwREZMVnQxaVpUN1dCTmFIT25sdXVLSFlzdlYrdkdLejJJckdP?=
 =?utf-8?B?bWw1b2w2Z0JnQkJCQnN2OXdYVFJmSzVQd0xaeUFvalFnanNDT3NRc0prdjJN?=
 =?utf-8?B?M0k4UzNkVFQ2RTdUVkdIYStHam5XbjBlU0ZmcUp6L3g5WVcydEhqLzQvL3dQ?=
 =?utf-8?B?cWxjVHpETHVQd0hOMXVINitEeVdvVkpYa3I3OGFDTFprNTlkZ05CUnlXckV5?=
 =?utf-8?B?Z290QnBGQWJnY2luN25sNjNmb3lPdmNseDBtUlp2b2FOa0tDNzVOSmlKaEVl?=
 =?utf-8?B?YkRWRGhURWlhVktYNm1LdjlPQTNLSFJEbGZ6dC8zUTdENlNvbWhsTVdCQ284?=
 =?utf-8?B?dk9tanhYdU1zb3J5S1YveVJKVnV1ZUo4NUQyV091Qjd3S1ZxbHVyZzVyMk43?=
 =?utf-8?B?am1xZUg3d3JsV2N3Yy94V0didU1ZUXhkaUk4ZnYzUTIwa3lQM0ljSlVCdkgx?=
 =?utf-8?B?dDdiaVJXMEpqeTBqVHRyalhmRWhaVnBmckpXMWY2cnB0alljM2h0K0lTN0pJ?=
 =?utf-8?B?eTMyVXJEVCtoSE5NaU05dWR2RkNsOE50MnZuRzBZM1JCNUloaFBKWWIxQ25E?=
 =?utf-8?B?dHhuUUwyNjRaTzJwYlZWRW9QQndicEVKVTRPdEhtekJPSDh5M2NzMktYUFNZ?=
 =?utf-8?B?bUZGWXZHa1h0eFFIeVgvL2tZd0p0U29HbU55aEVrRkgwQURydHh4OFpxY3Rh?=
 =?utf-8?B?ekNsYmlBUkNoenI2YnZGdlB6Q0xEMEFycklRMGVaMUczNkxQL0lKY2FzRkla?=
 =?utf-8?B?OGQvcFJ3MStuQmdYMlY5NWVRSmdkOGpoR3JHZEEwWG1HWlJiT0E0TnVaWDEz?=
 =?utf-8?B?ZUJoM2d1MExIMEdmRjI5a1c4Y3hGNE80ckhPSTBqdExMR3pSOXA2cndXK2dm?=
 =?utf-8?B?dXRlU21JcHJwQXVlTFgvSlZseUM0ZmszdjJUWktUYWppVXM4cERGcG16VkpV?=
 =?utf-8?B?YjlFa0EzSnZqZ1hxOStJMS8vWkJnV2s3RDVrUEdyQ0xKbTBQTWRZOEYvbjZq?=
 =?utf-8?B?SllJOWRjZEVlVElHY0RCZkx4bGxQUHpTaDNUOWFHdTlzSldNTysvZ1B0Si9X?=
 =?utf-8?B?dDVTSWhvd2VObk9HRHE4eUhzKzExUyt1MDN1c0U0SmdOSW9FM0RJdXY2R2pv?=
 =?utf-8?B?R0N2RDBqNWY4eFhybkJZa2pUSk8ya2pUY25NLytHMUJSRm93R2VZU1BuMVRa?=
 =?utf-8?B?VlNCSEp1eXNPcE9SZzdOd28xRXlyR2RnS2NRQUJVZXplYnk5S3psV09aODdG?=
 =?utf-8?B?Z2VJcGQ3K2Q2aDMwTiszTEE1MmkxOVdVdk5HNEhKZHlPMkNpN3k5T3AvNXZy?=
 =?utf-8?B?T1dMaVBYdTU2K0l3M0FLY013bmdPWEhxQUR2bjdxUnpMVE5FeFpBQ0xWTVQ1?=
 =?utf-8?B?bVE4Ritodi91cTdUZFJBMXlwdENVVks0dU5kUTBQN3lFTTdqUFhWd3gyMW4x?=
 =?utf-8?B?N2FhZ0dxamlGSkVaV2szZThoVENhUlVHL091NjJYMTUzUlFVdEloclBpZGhB?=
 =?utf-8?B?dUdOT21IT1huVGNqbEpsTzNyeDI1ZjUzb3JjcVJXLzkydWg0aDlKUS9YTzN6?=
 =?utf-8?B?SXc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c179eaac-7419-4180-ea89-08dd9a1e60c6
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 17:22:22.1629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gey0Ef0oOQ1Gt7jGSJPXCtIp2GdrL3iQSQG0IdU3/LGlU9UnmQ/kvjanekzp8Pq2ft+ewHZJl0tf3iVSg2bLQjRa9ARIrJdhE6FjDNmfmyw=
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

On 5/20/25 1:30 PM, Fiona Ebner wrote:
> bdrv_drained_begin() polls and is not allowed to be called with the
> block graph lock held. Mark the function as such.
> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
> 
> No changes in v2, but ordered differently (in particular, it avoids
> the need for patch 04/11 from last time).
> 
>  include/block/block-io.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/block/block-io.h b/include/block/block-io.h
> index b99cc98d26..4cf83fb367 100644
> --- a/include/block/block-io.h
> +++ b/include/block/block-io.h
> @@ -431,7 +431,7 @@ bdrv_drain_poll(BlockDriverState *bs, BdrvChild *ignore_parent,
>   *
>   * This function can be recursive.
>   */
> -void bdrv_drained_begin(BlockDriverState *bs);
> +void GRAPH_UNLOCKED bdrv_drained_begin(BlockDriverState *bs);
>  
>  /**
>   * bdrv_do_drained_begin_quiesce:

Again, for readability we might as well add the GRAPH_UNLOCKED mark to
the definition in block/io.c.

Andrey

