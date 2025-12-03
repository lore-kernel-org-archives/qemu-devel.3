Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99B5D12696
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 09:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQjMi-0002zN-T4; Wed, 03 Dec 2025 04:41:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vQjMg-0002yi-T5
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 04:41:38 -0500
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vQjMe-00012a-KR
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 04:41:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3ZaG+LLebtOBn5vquSoqcESvR6hOoSjcE6teAKVOM7E0d0UehiZVxjQgD5EgJ82vOXni1Cym+mIg20Y4hEuuoJuqY7bW8vpflHacsDizc1wGYLarouz+oIpzzVj7tvJPMfI7XjzwqjS+GJdupsutlKpgf4TRkz/IpnSAkQar2y/TNrbxxUohcO4d6Ypc1dXGKLTWK5biGzmsFmrIYG6DLplCc1JGIngKvapxupxg/P5UpTwANVVGfBc9ST+AG19DpQIjt1FfFVFR5WKwQp/eGUtuApLAG8sb4uiZ4B4EArAoIKfgS9o3lgWnbKnr7r7N1HxxKkJBEthvLsMkYK9yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thKVQUz8AkTs1B7IROgCsZKYLmxD1LV7cv9Tu+rTQwo=;
 b=KPcE2iVJ6Cwj8RxbdmNeotx5XzjnOxXbZkUWfKKUVQGGwJxSmpjZxFYqTpA/tsLJuRuUptsbRfjL7b/o83nLewfLU3nli3d3gFIWJVlPgicYyC5zntffFvQV84ZD6U/nj1NUtBbxlYTecoX6+THJ/tNSUcEXcMBuGis3PoC1uFr3nsdxyIPbHXsxHiVI2O4GvpXim3qDvD215IQIglxyL/WAiqlNGkhl8jIqW4363eKxdEvLANBPisenxJlBa6ZDUJnFTN1hWJ87dPTg1xx7M85RFrsc6PJTtc7+csB2Vri2YyQsSyP639HAxndL4y5LfEx/MPLa6ot48GfOqN2mhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thKVQUz8AkTs1B7IROgCsZKYLmxD1LV7cv9Tu+rTQwo=;
 b=p6ca7ySve75manr/fnURzkhM5xPdopN+/23bq9wDNO7GCKQxj3Tp1/ZyxYAPSjq0dUZmOmZhaOqxFMX0qUN1j8f/6W791riemlqDRlpG2Iq6dbrjil0J5dFlKTtjxhdI0pJI08vU08ERZMta2Iu5ZvBrFKScUYUleYY/hZ7QBaXQMqqbhFi4Mm8n4aRFd3HsCiCG07oqdltHHpMvRfSq2c2YZV/qLAZ/WRzcv+GfAkLlzukMjeZUswql0BxjQJhyxbeqgX3ZKgHdw73QK3EqJeWXhOGebQrerwnejr6U8KxJcKg2N7rQugEd5t45mScyEUwFGlRp2L+/6srX05fTVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS1PR08MB7634.eurprd08.prod.outlook.com
 (2603:10a6:20b:476::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 09:41:29 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%3]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 09:41:29 +0000
Message-ID: <3eda31c5-84e5-4ad1-a4b0-74b112e33256@virtuozzo.com>
Date: Wed, 3 Dec 2025 11:39:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] scripts/qemugdb: coroutine: Add option for
 obtaining detailed trace in coredump
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peterx@redhat.com,
 vsementsov@yandex-team.ru, den@virtuozzo.com
References: <20251202163119.363969-1-andrey.drobyshev@virtuozzo.com>
 <20251202163119.363969-5-andrey.drobyshev@virtuozzo.com>
 <20251202193001.GB964933@fedora>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20251202193001.GB964933@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0206.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::15) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS1PR08MB7634:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db987b4-c5e3-4fc6-5523-08de3250224a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHUxQVJkMWd1RWpUR0VXRGs5L0lYQVVGYUNaWGpQcVJhNlJ0d2tla2ZESkFF?=
 =?utf-8?B?RUY5anlsNjJmUUd0VWcxeFYxbGQwOWEwZjJXaVNmM2NjVXFDL1ZVb2MzUldj?=
 =?utf-8?B?ZkVzVTE5b0VwbWhXUXFSNjZ4WXlLV0l2RVBLNDBadzVWWXg3cW16a3htemtO?=
 =?utf-8?B?Q3R0ZWV3eWFQSVduT2dSbUtwTFVkOEhmTXFtR081S2ZBd0dicllJQUNWTXdE?=
 =?utf-8?B?S25laDRqVUsvSmd1QlovWDV2akZkbzdSanhZNmw1dzBVV0g4NmY4ZjFLTEdp?=
 =?utf-8?B?NEs2YnFoMFJXMDlqYVV5OE1ualZ1UEc0WlljeTdEeXVtK3k1cFlxenQrR1U0?=
 =?utf-8?B?MnFFYXZLSGNwbHRmVi9Jam9BN3poVk5sWmRING9qYmxOZ2tTbENFYlRvdHRj?=
 =?utf-8?B?aFNsRktuN1hiNmd0YU1nK2wwWFE4TjE3QzRuS0Y2d2pKTytzZEVWN283OVhl?=
 =?utf-8?B?RUFhWDk4SXFZeVp3dkUweERDUHBoSmtQNGFBajFmeUR2cTJ5YVlWS3VsK0s1?=
 =?utf-8?B?OEZQNWVOWm1lQTJIVnhOc3g2WnRuajNxL25iUDlUblJCVGpTelhIdUVHbDE0?=
 =?utf-8?B?NVFxbVZBRTF1c2lrc2JZaS84TG1JNWQ4T05sVXFQeEhFOTgvTWlJV3NtREw3?=
 =?utf-8?B?VFZuTktOT21JcnB6aEVxdG56ZERTOU1uRStHUGVqOUFsa0Y1OExEeHhyVmRG?=
 =?utf-8?B?cEpLd1RqOEczMXd4dkt1Sjg1YndXRTE5dWpNcE5HOVlqQ09IazRpM1c5dGsr?=
 =?utf-8?B?bWFNWCtJdmNRVjM5ZXowNmtmTmRTb1RUYW5HY3ZjR0t0dklYSWx3TjIra244?=
 =?utf-8?B?THNnRTdkT0FGLytMbkM3bXA4TWpyWXlwYWVnYko5YWRMYkNJM1M5QW8zNXBQ?=
 =?utf-8?B?Snl3cTFnUFIvbGY5cGdNZFpUSWtKd0ZydElKUjBiRGhYakJ0Wkp1NXBkeDVy?=
 =?utf-8?B?NERTbHFVY3pFYmtWcktteGFLQmtFZGZWR3MrYUQ2Q2hNSEQ2K2szcWxqaTJ4?=
 =?utf-8?B?RnFCa3g0TEV3a0U5dUZMVlpoV3JCd2tKTGVmR29MMytnYnRwS1d3YWJxOWVV?=
 =?utf-8?B?SlFPUFZJY0NlQTRQQTRodkFTQ2p0K2g3Y2NvSkFuK1NOQmVRY1hCZ1lyUEVp?=
 =?utf-8?B?UWt4NWFXR1BnNWZ1OTJvMmJGbDI0aTcvMTZXN1RJNHhUSHUwbWN3ckZVU3N1?=
 =?utf-8?B?VVVCU3EvQWhZSWpJdElJOUNhS1hpWWIzRjNyRlhUb0Z6ZUVJUnJVb1JSci9U?=
 =?utf-8?B?a3lsNHlxYmdOQ3RiOE1jQ2ZESUVvUC92ak5yTTNBa25EbDBscDNGQ29CSFV1?=
 =?utf-8?B?VlBFWjlxdzcyRVE0Wjc4clg0eHc3aFdyRDMvSVVlVEpvaStBSjhPR25oMk9n?=
 =?utf-8?B?YXJXYzdRMzhza3A3UXJEWEROVHc3S01Pa0swa3JnUHRCSmhjSGxlQTJRV3kz?=
 =?utf-8?B?VitNZ0JseE16Wk5zZ0V2VUMzMU5PUE9KbGtJN1YrNmZ3RXZ3SGZoVU1KQmJn?=
 =?utf-8?B?anIzM0FxTVlyWEt3ZWl2cEsrODBxb0l0RjlnWU9mYVBPZldsZ0Y5WHJJaFNa?=
 =?utf-8?B?SjNNS0R2dk1aMWk2NXR2ZWlEbzVDaTNHUVFodWJLNXJaUXBPOUI0S0hCZjdK?=
 =?utf-8?B?QStZZnBobWw2a3J4cW1ZMFMwSWNEd29kWDFaWXdVZVpsMUV0ODV2ZVdMTU53?=
 =?utf-8?B?dXB6YXVVZ1pldG5uaDFmVDNhbDdJeWREb29pK1A5Y1NlQyt2bzVBdjNFdTJK?=
 =?utf-8?B?dklHRFZGempEdkZXN0pqcitVSStuWDRKZU9QcCtER0tGTXlxbk5QOGptWW11?=
 =?utf-8?B?dVpQcWJlZC9UeDJLTjR6QUdzQS8wbmlEYXlRYlVHdGVob0kyeXEyVDVBSG1t?=
 =?utf-8?B?K08rTEplNVF2Q0M3STBrMSt5aEVVN0VrQjQrQXQyZzFoZ0VmRUlUeVRKNGJu?=
 =?utf-8?Q?b63RllcewUzJ4P+wRcwT82xKMqXc9JQJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzdpZThQb256cWVMcmRXaFJ1ZmtLTFVtRGdiY2lLQUUvaTZQSjV2SEM2OFla?=
 =?utf-8?B?eDM0ZG9JY2ZjRitqMzlYaExlL0xOV3o3QllmaHRKMXBuVlpxSDBsRWVMbUVR?=
 =?utf-8?B?SjFwZmZNVzN3SGVZSUl0eXBHYUVxZ0JxRmZsVzBMdDFoaExaWnNtSGlKR2p2?=
 =?utf-8?B?SnlLNWtEa3M1MHJ1UUE5UkpydFpFNk9zdUlnNkJMbnZkWmJrdUI3NjJReVdF?=
 =?utf-8?B?cUFrZ2NqU0hwWlFOS3Ewa0dXSFQrMnJ3REdmOEt3blZlMjNta3ZIb3I2UnlZ?=
 =?utf-8?B?SDJNOXpzR1pjeXlTTXNGeXJKdVowbzdiYzM5QUdnd21uZGliaFFrWWJJM3d2?=
 =?utf-8?B?b1Y4RFZiZ3JBeDBVRm1OUzF3WENPUzdnM3QyT3BHQ2pjZ3FnWldVNnJjenhk?=
 =?utf-8?B?cTYwclU5aFFxOUhLUUViUXcwWXdiK2VrdVdFL0FUUEJBdGwxQXZsTWF6Umoz?=
 =?utf-8?B?RS94N2U4TlV0cjQzcG1OZ2lsU3YzOWxSYndNWkN4NkRJbCtFbGlkY2dxZmla?=
 =?utf-8?B?K2Z6VUlLdmpKOFBWSkNZUG9wdFhFZUV6QkI5Z25sNWVRbzFnU25FSU5pcWtw?=
 =?utf-8?B?MHhZT0NLb0JDT3l0TFhGcTEzeTc0dWYxcFNRelJFK0VFRjcwUGVQbHhSa1d2?=
 =?utf-8?B?bkJTV01KM1lERlFUdmx6VzE1NGFoNlRlbVBJTEYxRWFYT3c5Rk12d05PZCtT?=
 =?utf-8?B?azJ4VmxFZkpPNW03WERLaUJuWFJvSDlwNUl6WVJFTHdMSWM0RENWTkExRzd3?=
 =?utf-8?B?VC9zUmdtNmJjcTJlM29hbE16ZUtyMHNENSs4Nnl0em13bmdhdnltdEVsakhj?=
 =?utf-8?B?SXFNTGpHbXF3TlNDcXR3WGU1TXBVRnhXR1lLR0FHQjVSSDJGNzNjWjFhN1NU?=
 =?utf-8?B?VTcyOFgyMEszeTB5a2IzaEs1NHliSi9KWG83YXdSclFZdkhlTFlrd1cvekVE?=
 =?utf-8?B?THNGOThacEpXWDA2Nk9QdUt5cDZIRFlGdmZHbTdnZVpSQmZFVk1XNXAvdEMy?=
 =?utf-8?B?NTFKSUt0QmlwRVhOazhpN3JsaFI1bUdMbzRLSU9OWmxuYXBOV0d2R3ZOMGd0?=
 =?utf-8?B?MW0xdFhXSklFUTJqME9EYjhRVTAwV2FVWStUU3MvNlhrYnVFQnlyUmJVT01Y?=
 =?utf-8?B?TzV2S0k5aC93dGFsUlRVWXNOMHg1a1VaZE8yaTdXL3Vwa1NibCs2N3BKQysz?=
 =?utf-8?B?WlBmQzZIVXNzRU5KRFBXdzhYQiszdURhdUZsOVpKNE1rSHFBZ01YWGpVaDVu?=
 =?utf-8?B?QjlpaW5BNlpSY3puUkJUbmR4cEcrMFRGZVk2Z3BPMXY3VzQxUjBidk15Z21y?=
 =?utf-8?B?Wi8wK2xYc0NaWk5QYWtaTGhPTHRhV21MSkFPRVExQ1RHZkZBdE1tUWE0V2xt?=
 =?utf-8?B?T29wbjV4dFF3WUp1dFNMWUxzVXlGd2NlOFZVWFBrcHVvQkkzT3FKV1NzZDFX?=
 =?utf-8?B?Q2I3Q05wMlFNUzkwT1Bqa2VVQ091RDMrQTA3ZUhVckhud3BETnVMUG5DR3Zz?=
 =?utf-8?B?dThHTUhWVHhiTkVTWlRDZUU1dU52M2JGOE5uQmc5bWVsaGlvV1loMlRsSTgz?=
 =?utf-8?B?ZlB0OEpBaWJRNHRreHBKZktENjhnT3luN05xQkpiRmpWQWhzcktHeW9xK2l2?=
 =?utf-8?B?dHRiWmlLZUJKalR3K2ZiWThpTmpHakVqbVZZZmJGL1FSVDFpS3gzVDNaUHlE?=
 =?utf-8?B?Tjd2TFQzbVkzdCtVL3F3RUJpYXRmRUZKQzdoNmNXNnNKK09ZZWREWEd1VzJI?=
 =?utf-8?B?clhpanJXM2gxa25abkN0RWh5UjArdnMxNkorVjdTZmliS2I1ZkxtSEl1a0tW?=
 =?utf-8?B?NVRReG1NaDZtclNJNTM3UCtCRzRyblJ1OURWdXRuNXRzTUpxNDZGbWN3cXU4?=
 =?utf-8?B?MkYwMmxZQ0tURUxkbTdsWUpTU1VkZUxEVDBBY2NlWCtjUzdMdzZXUDU2Ungz?=
 =?utf-8?B?bDBXN2RCcWI1dlEwR3FKZEdUdkhoZlpaSFFGUUFhbWhWMkFyRWIrWE43a29U?=
 =?utf-8?B?ejFwMVdTYndGSi9GcUo4MVpwbjNxRlhZdzJsNG9BSHVHTVdWRnZrUTViRS9O?=
 =?utf-8?B?cVZtallCeFRId1VRdXZlOFNNdXhGYTRVMmJYRHZxTEZNcFpONmsvdjNzYysr?=
 =?utf-8?B?YUxaZm1XL0tRYVFYTWNBUVJaMmtvSUZVN2R4Q2N6U0l4S0dMVldMS3U2YlFw?=
 =?utf-8?B?TVE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db987b4-c5e3-4fc6-5523-08de3250224a
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 09:41:28.9237 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDkvlLD/tqU/HyU1XkFu4nRUDfKM85OPcY+e8el3p1nIbrGMeNVfoq1eZZ5fOCjX9g3G1jXMwHvxlGeNscDYvUju1gBsGICe4CYpRpHJLgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7634
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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

On 12/2/25 9:30 PM, Stefan Hajnoczi wrote:
> On Tue, Dec 02, 2025 at 06:31:19PM +0200, Andrey Drobyshev wrote:
>> Commit 772f86839f ("scripts/qemu-gdb: Support coroutine dumps in
>> coredumps") introduced coroutine traces in coredumps using raw stack
>> unwinding.  While this works, this approach does not allow to view the
>> function arguments in the corresponding stack frames.
>>
>> As an alternative, we can obtain saved registers from the coroutine's
>> jmpbuf, patch them into the coredump's struct elf_prstatus in place, and
>> execute another gdb subprocess to get backtrace from the patched temporary
>> coredump.
>>
>> While providing more detailed info, this alternative approach, however, is
>> more invasive as it might potentially corrupt the coredump file. We do take
>> precautions by saving the original registers values into a separate binary
>> blob /path/to/coredump.ptregs, so that it can be restores in the next
>> GDB session.  Still, instead of making it a new deault, let's keep raw unwind
>> the default behaviour, but add the '--detailed' option for 'qemu bt' and
>> 'qemu coroutine' command which would enforce the new behaviour.
>>
>> That's how this looks:
>>
>>   (gdb) qemu coroutine 0x7fda9335a508
>>   #0  0x5602bdb41c26 in qemu_coroutine_switch<+214> () at ../util/coroutine-ucontext.c:321
>>   #1  0x5602bdb3e8fe in qemu_aio_coroutine_enter<+493> () at ../util/qemu-coroutine.c:293
>>   #2  0x5602bdb3c4eb in co_schedule_bh_cb<+538> () at ../util/async.c:547
>>   #3  0x5602bdb3b518 in aio_bh_call<+119> () at ../util/async.c:172
>>   #4  0x5602bdb3b79a in aio_bh_poll<+457> () at ../util/async.c:219
>>   #5  0x5602bdb10f22 in aio_poll<+1201> () at ../util/aio-posix.c:719
>>   #6  0x5602bd8fb1ac in iothread_run<+123> () at ../iothread.c:63
>>   #7  0x5602bdb18a24 in qemu_thread_start<+355> () at ../util/qemu-thread-posix.c:393
>>
>>   (gdb) qemu coroutine 0x7fda9335a508 --detailed
>>   patching core file /tmp/tmpq4hmk2qc
>>   found "CORE" at 0x10c48
>>   assume pt_regs at 0x10cbc
>>   write r15 at 0x10cbc
>>   write r14 at 0x10cc4
>>   write r13 at 0x10ccc
>>   write r12 at 0x10cd4
>>   write rbp at 0x10cdc
>>   write rbx at 0x10ce4
>>   write rip at 0x10d3c
>>   write rsp at 0x10d54
>>
>>   #0  0x00005602bdb41c26 in qemu_coroutine_switch (from_=0x7fda9335a508, to_=0x7fda8400c280, action=COROUTINE_ENTER) at ../util/coroutine-ucontext.c:321
>>   #1  0x00005602bdb3e8fe in qemu_aio_coroutine_enter (ctx=0x5602bf7147c0, co=0x7fda8400c280) at ../util/qemu-coroutine.c:293
>>   #2  0x00005602bdb3c4eb in co_schedule_bh_cb (opaque=0x5602bf7147c0) at ../util/async.c:547
>>   #3  0x00005602bdb3b518 in aio_bh_call (bh=0x5602bf714a40) at ../util/async.c:172
>>   #4  0x00005602bdb3b79a in aio_bh_poll (ctx=0x5602bf7147c0) at ../util/async.c:219
>>   #5  0x00005602bdb10f22 in aio_poll (ctx=0x5602bf7147c0, blocking=true) at ../util/aio-posix.c:719
>>   #6  0x00005602bd8fb1ac in iothread_run (opaque=0x5602bf42b100) at ../iothread.c:63
>>   #7  0x00005602bdb18a24 in qemu_thread_start (args=0x5602bf7164a0) at ../util/qemu-thread-posix.c:393
>>   #8  0x00007fda9e89f7f2 in start_thread (arg=<optimized out>) at pthread_create.c:443
>>   #9  0x00007fda9e83f450 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
>>
>> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> CC: Peter Xu <peterx@redhat.com>
>> Originally-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>  scripts/qemugdb/coroutine.py | 243 +++++++++++++++++++++++++++++++++--
>>  1 file changed, 233 insertions(+), 10 deletions(-)
>>
>> diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
>> index e98fc48a4b..280c02c12d 100644
>> --- a/scripts/qemugdb/coroutine.py
>> +++ b/scripts/qemugdb/coroutine.py
>> @@ -10,9 +10,116 @@
>>  # or later.  See the COPYING file in the top-level directory.
>>  
>>  import gdb
>> +import os
>> +import pty
>> +import re
>> +import struct
>> +import textwrap
>> +
>> +from collections import OrderedDict
>> +from copy import deepcopy
>>  
>>  VOID_PTR = gdb.lookup_type('void').pointer()
>>  
>> +# Registers in the same order they're present in ELF coredump file.
>> +# See asm/ptrace.h
>> +PT_REGS = ['r15', 'r14', 'r13', 'r12', 'rbp', 'rbx', 'r11', 'r10', 'r9',
>> +           'r8', 'rax', 'rcx', 'rdx', 'rsi', 'rdi', 'orig_rax', 'rip', 'cs',
>> +           'eflags', 'rsp', 'ss']
>> +
>> +coredump = None
>> +
>> +
>> +class Coredump:
>> +    _ptregs_suff = '.ptregs'
>> +
>> +    def __init__(self, coredump, executable):
>> +        gdb.events.exited.connect(self._cleanup)
> 
> It's not clear to me that this cleanup mechanism is reliable:
> 
> - The restore_regs() method is called from invoke(), but not in a
>   `finally` block that would guarantee it runs even when an exception is
>   thrown. Maybe _cleanup() can be called without a prior restore_regs()
>   call. It would be inconvenient to lose the original register values.
> 

Agreed.  We might as well put restore_regs() call into a `finally` block
to make sure it's called in any case, like that:

>         try:
>             while True:
>                 co = co_cast(co_ptr)
>                 co_ptr = co["base"]["caller"]
>                 if co_ptr == 0:
>                     break
>                 gdb.write("\nCoroutine at " + str(co_ptr) + ":\n")
>                 bt_jmpbuf(coroutine_to_jmpbuf(co_ptr), detailed=detailed)
> 
>         finally:
>             coredump.restore_regs()

And also we should probably call restore_regs() during the cleanup if
the dirty flag is set.

> - I'm not sure if gdb.events.exited (when GDB's inferior terminates) is
>   the correct event to ensure cleanup. The worst case is that the
>   temporary file is leaked, which is not a serious problem.
> 

Hmm indeed, this callback isn't called upon signals.  I guess we can
just call atexit.register(self._cleanup).  This seems to handle both
normal and abnormal exit (except SIGKILL of course).

> But then this is a debugging script and it's probably fine:
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>


