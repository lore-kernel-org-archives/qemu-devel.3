Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92749D116F3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 12:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOxZG-0004oa-4s; Fri, 28 Nov 2025 07:27:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vOxZE-0004o8-AE
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 07:27:16 -0500
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vOxZC-00016e-5U
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 07:27:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C91+f2/5XRaXpZ+0NH33WXHraww0hNuAUepx75A2YCxqmrPTSLyXTEkCTcV5ztWzlly5nUbY/bstOrl9lqmqqhoK5lAkPDe4uydsfC/+BbKY3joqYmyj98I17L/Z5P1WOeuv8vHf0E6bRqkbsVy+d2l/ltNoKJ/TEm6Q7Qu59xJPtv7/8RftQRHjw+FlPuwcoqrUGAz9Zw2RXMS0fCYOjy/uro6eJ5lt15C8i8BOfctDWvkTqfXfyrVzItOiZcts8d96h6x9hB1Y4gZHCfaw+ZR3q99CG1OnIGgYu8N5P1KCZ0cSzLycs6UVuyvN9YrrUh7ZS7AYDBonqBLgCKiygw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzHcOL/DVHhW+mFYdA6hO/jGWq8EUXR8n/hBup2m7vA=;
 b=Pzi3Y1o9urH7lpt45XChtkiAWlf00yRUlXbtLOF5dPg42LO0s1O3ViHJBKyEJKORRXQZFj1yojiXB+SGq3hFtv9KICHiq3AshLUQWZa/uqs+bIbdWk0jMCp8/pSl7CegjIE1l8QpZrOVVySfbP2oE097PFlIBkxia323yTzjCe66QMNk2/Hx6LJd9gMV9AFDDUv4XPDyt9q817JyA1+O5mgmBcdaD/KKH/4rHS0JsvOyZWCy8urjL/L5qw0UcidLnM9a5OS1ByrqOWpEP+AagBcucxy+38HDiC4WHdifeIMLGdOiJ1q9zmGurGfYZJrafkj3nZ8yimW8rVMUwN+YxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzHcOL/DVHhW+mFYdA6hO/jGWq8EUXR8n/hBup2m7vA=;
 b=syJ3WoGZdqVKmdY/+QAak8sA++lcRzprz4O2FXv9WAbTZmQ8rk2ClgMxbJx1L52qK/Wl8Go+djN18pvYFXsK9M+e3KLNqCZxhzmIwP2bfE8w1IYY0p+sbsTS77qJoUuS3mVqdGbDWKts0TjPaqZRT1WyEM4n1lztJVHAm9sbEMqIHLLT+A/Z7Jj6QJo1VHuN7uADgPePd6NNeAFX/FYj/7ijSvlC+iXOAsBxsKp8laj/xOSCo3qwsZwGl1MpGezf7/aftN/9s76zhIfZ/bwpTUbKwU8XPG1V7HKEHsOzfc1ipY+zKMgd/ZzF0/hWuAkpvq2Of1wAYZ3ypQaFQi03pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB7494.eurprd08.prod.outlook.com
 (2603:10a6:10:36d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Fri, 28 Nov
 2025 12:27:07 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%3]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 12:27:06 +0000
Message-ID: <ce8c9c03-5dfe-4f0f-8394-e9ba95f0f09a@virtuozzo.com>
Date: Fri, 28 Nov 2025 14:24:29 +0200
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
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <aSh-1_qLRNGCzV9H@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0402.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::14) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB9PR08MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: 08bcec27-42b6-4bd5-fe82-08de2e79719f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlR4bW8yUytWbUc1azN6cXVtTnpaU2pOS3d6RTJYRVF3Y3BzNVJVU0xEU3Vk?=
 =?utf-8?B?RjFoYnJWaUpFeGVLek5kbE5peE80K2lvakRzWDZLNWhFUkMrQytqZXRPd3px?=
 =?utf-8?B?ZzRLckRKdTFIcDZ2aWwvdkNEdTc0NXpUQm9WSTNObDA2VTBXSldlNGlNQ1VT?=
 =?utf-8?B?Z2J4WVFuZVY4dFB0d2Z2cmgwdEdjYXlzNkNGbkVwTHREcVhrSVQ4dE1wUU1L?=
 =?utf-8?B?S2dnckRKdTFIWTQ2NVN6Mlc4dWU1TXY0aGk1Zk02VDVTYktIY3c5THp3RUdM?=
 =?utf-8?B?NUhQK3M4akUwSHFjRUlVYmpLRXRqY2lpV20xVUpJVWdFaDhHM2FLS0xmVmo5?=
 =?utf-8?B?NW9BN1pZeUxUZnp0clB2cWp0RUY0V0hZaE9OZ2FDSVBBRHBqL0lDNXQzYWt2?=
 =?utf-8?B?UFAwY05WaXp6WXNMa0svZ2RSQUZiaTF4aW1qbXduZE1GYzhYQmEyQnh6SzBr?=
 =?utf-8?B?OVdpQ2lpVzk2SVBwV1NWRHhjbUNVM1RZaE4xQlZSYkdzb0xZc2Nvd1B2OTM1?=
 =?utf-8?B?STdzMFNteEdOMTVMc0lOK2FnaXZjUlFtOUYybFNIU1M3S01hb0MzYk9XK0ZQ?=
 =?utf-8?B?YmR0RmNhV0dXMkxnTVRxbzJGM2R4QjlxWnM1dkM2VGtnS1pIOS9UQTQ1UUdW?=
 =?utf-8?B?aTNLOTdHWEIzZkhsTm1yTDlUQ1ZLZy9tUmJQMUdrdEwyUFdPLzRhRGkzQUl5?=
 =?utf-8?B?ajNKY3pSSXFmWWJlZTdKK0kwQWxQZlpHenNOcWswbG1tbm1iNm02bG9OYkM0?=
 =?utf-8?B?TWRtVnd2Qm1xK3VyVWpUZHlXTzVoRHFOYWwxdDRxYUxrT1EySENmUUdhU3FC?=
 =?utf-8?B?d3RjVDdHaldsMWgwN3JQN29WYnJJeXV5MjlieWtGTm5RY3BqYU1ablcydEpO?=
 =?utf-8?B?dzUzNEJ0bzc4ays4VjBsb2xaQXRmRnhRVFJ3eE5MWHpJdjJ0WE9JSUg4YjhO?=
 =?utf-8?B?bFp3QnVLZzZubzhleSsrYXdUWTJodXlQTWVrTGxxWEREM09BRlU2VUZYenRk?=
 =?utf-8?B?Nm5YS3JLTHBwbkM3VHZxcERkODBkOXRDa1YvUmlJVHlmeS9aeG8zaVJWSGtX?=
 =?utf-8?B?ZWlxemF4MzBqNnI1aVdWRXRqYnJlblhRSXpVVWdvUk92UG5CajY5Vi9BRHpN?=
 =?utf-8?B?bVhFWlZ6dndZRkFYVFI3aTFVa2tjcjlGK2VkMmNOS29EVm5wd3VUS1NldUN3?=
 =?utf-8?B?Sm5RenMxRDh0dzVOR3hCTEdwaWpFVDlBRWVnK3ZiLzBGUXBXR0ZaYVlqeUJa?=
 =?utf-8?B?VUExa21lUmxrVmFiZjZVZVp0c3NCdEpVZlM3bG03MHhiQ0twNjJkQS83U3Y5?=
 =?utf-8?B?cldmL09SVDFzUW1aUVIwd1VsRURhUTZFZG1KS3RobnFNTHVOTU1nKy9vSXMz?=
 =?utf-8?B?VWRaZzFmZktnaXFyT1hpWVdOcG9BUzNLelBIVUp6TnczcFlmZi9TZXUwWTFl?=
 =?utf-8?B?dzRrdWQyVHhqZ0VXdFIwNW5Rc2d1TkNmbXJiYW4ydVhQYTRSdUZlT3lhOHpD?=
 =?utf-8?B?OUU3SEdxM1U1MERLZTNVZmkwVjhPQ1Z3aDl0WlA0OTMwbjhLck9xc25rY2tq?=
 =?utf-8?B?L3d6M284NlZVMEpsSXRSOXpnUysrTXExdFRXcHIwTmdmVVVqTkZTVUx3YnFh?=
 =?utf-8?B?RlhwYzc0TU5NTTdTVDluR1BnRnhkbTRFLzZPTXY1R3NINndqTGRDekUwT0RD?=
 =?utf-8?B?c1IrOU9FSFduemlJckxxWG5FUmlWV0RrTGZXY25qVitpdmN5d0M2Vmx5SlEx?=
 =?utf-8?B?L2JkOFU1aVMwb05pVHlQRXVrSTJ5aVRGS3kxMU5ybWRwRW5iWC9DSmVEU0kw?=
 =?utf-8?B?bVI2SW13U3ZEYlhWK2J1SHZTajhINjFaWk1zTHdiV3J6YUR6VnZUWlViVTdo?=
 =?utf-8?B?Nm5tdGNlTnM0cnBIY25CN05BUEtrelR3d05WVGgwV1I0SVp3UFB5Y0RIbkN3?=
 =?utf-8?Q?7yMbLlgkXTu1WlrG1LGDLGV9qNeixanS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1hXenJ1cEJmdlY2dFBVVzVIdk1XVTR6YzkxYzNTSUE2VjhnM0dPNjdSU3lX?=
 =?utf-8?B?d3hSeUEwQU5XSXFrbk1Gd0JVN3BnRTJML3hWTnZ0a2N4a0loWXBQRy9vdlM3?=
 =?utf-8?B?bVBTQmFjZGJQbVhOWkUrU1U1WEZHaUZWSlpuQWxMc2I2QS96S002dWJRNDNr?=
 =?utf-8?B?M0VzcUxxd3JiUGRsQk44dG12cy9UOU91RU5mQzhBZDNsWXNXZmlYN1dNMTZJ?=
 =?utf-8?B?MzZhUnZaWjN3eldYK1hrNHFqdmdmU20zOWhEWUZWemprTVRNTjNodmNmV1RN?=
 =?utf-8?B?dUxTQnJGcGNDU1RIcXhsRnVSQXozNjd6eVhXMTlUTDk1UXJiUUs3NTRETUZs?=
 =?utf-8?B?ZHgzaS81ZE50Vll3UnhoQnFMM2hZaDVVUndkb0JhWGdRdWVzbUtZenlQaVNS?=
 =?utf-8?B?TEF4V1RKeWVjdW83MU5uM012M2lrajVTMHdZRjh4VUpLblRPajJzb1RXei9P?=
 =?utf-8?B?RFhTMzlOSFVqTzMvVjVYenJTekwrQytCcnkvQjczM2E1Tlg3eDFaSGFkZHJH?=
 =?utf-8?B?OW5VU2hEaGdhNXQ4V1JBU0pvN2h3RkpHNTFSeFYyWERUS3VuU2gxbjN4bmhQ?=
 =?utf-8?B?cWhXc2QyRXVkR3dsaWt5L0hkWnRvMUN4VkxablV3M21HbkI3UTRLVGV4WlNF?=
 =?utf-8?B?OGVEdWl6UitYNDVyQlh1Q204dG1ITnlvVVc3K0pKQ1ptUnMzd1c5NUU0blVI?=
 =?utf-8?B?MFRINncwQlo3QWVwaDg5aFoxZ0ZpSDUxNi9kOGxqY3JDekJzR1J5dG1aVFlM?=
 =?utf-8?B?Z3dQNlFPRitzRkNKV2gzQVFyQVptTTVRaEtXY3pkbGpVb1VCZnFtTkxZL1k0?=
 =?utf-8?B?R0dibVR2bDRLWnR2bzBGc05QZWxBbm1laG41MnJGVEl2ZnlJL0VEWFk0VFpu?=
 =?utf-8?B?MWdzRXVDZWs4TmJMeFBoK1RFbWlZdWZGU1FwTkhWWWZDRGI1bnJLUGNZMVFV?=
 =?utf-8?B?ckZOcVhGbEpEOXA5QW82UTh3YjNaQU1OaURpMnU1a3BHKzhiRFBTb3ZHc2d1?=
 =?utf-8?B?MEZkN1VIZEtzR1B2VGVFSXNQUE5uUjVTMWpvS280ZHoyWkxrQ3loL24vRnUv?=
 =?utf-8?B?YjBMM29jZDFvNW1jbmsyeER0T0JXaCt5MGxxK1ordUI1cUhlVHYvSWM4Y2xv?=
 =?utf-8?B?TnVYb09UZXVEc1Q5MFJRenRKUHlrZk9UT1k3cHlpQjFwdWYyYmZ1ZXRDMnky?=
 =?utf-8?B?RWd3eVNnWmJOV2FleUc1VTltYVJadE9zRFEzSGlSQ24zc2x1eDgrOG9zTysz?=
 =?utf-8?B?UWVEalhWeUU5c2pHcGs0cmNoQmxnVVpvZnRpWEszUE13cGd1VWh2SzdTYzNl?=
 =?utf-8?B?NTNYQlNIeE14dlAzOU9xTXNTR2ZDdXBSUGpMcWRXaTFianVUOGttVWpNUG5j?=
 =?utf-8?B?VHdZbkwwUUVxS2RYcGxPVTR3WGZpaHIzVDJ1VDJET3VCYjBENFd2MDRkZXZG?=
 =?utf-8?B?eEordFNsLzhLMG1IdjNucXdhRmFBRFlJdmhFMGs4ektra0tkaUExS3NkVndN?=
 =?utf-8?B?dHN0Y3dMdlA3WG5vd1dMOGJhZldEUy9zQlN6MXFmN1NoekZQNVRiOWtWVlZO?=
 =?utf-8?B?K0NlTGpjOGNjVnB4aERVV3pZM1FKcEVtR0Rwa0xpZjNMNWMzUDVwc1R5eUJ3?=
 =?utf-8?B?TjVaUmxHTFJTNTZ6SVNyT1ZjeHJyYmJvcFk5eUVROHEvVTJPcVRMMVlwRFB4?=
 =?utf-8?B?dy9sYVp2Q3ZmUERRUXhnMklNelVKeWpWM3Ria2JTZkFZZXJIOWJGM0c3dlNl?=
 =?utf-8?B?YVk3eFhPcjZGMWQwamZtbUJ3bW1ER2U3WXZSTWRHdG1GWFBoVFVsM0Mwb1pw?=
 =?utf-8?B?ZXlsd2VMMXJKcnRqL0I4c2IrdWswQ3AxTERqYkZTdUR4Z1FBTVVOL1N0c3Nw?=
 =?utf-8?B?aXhaUm9YOVQwVzFmMnNCczZYYnMrWmdGTjJyY2NvVWQ0L2Q2MDVDUUhRL2sr?=
 =?utf-8?B?bXRJcWd3UFk2SUhla2w5eThlOFZrcjFZNTBTeEZxZy85d2hySkRSOStGRHhu?=
 =?utf-8?B?T3BwUjg0NDlnaVlLVG5HaDZuUlZrV3JhY2dpYjl6aGpnMXdCZ0tNMUxmc04w?=
 =?utf-8?B?OUlWV0JSTzVyb3VLOGVSVFVnLzNNK1F5dGx6QStHYmVRb0lEUFlMd0g4cERl?=
 =?utf-8?B?T2pPbC94ZmFrd0NLOGMwdzJlNXFySm9leE5ZT2NpTFN3K0pzNHBPTlVVWS8y?=
 =?utf-8?B?NGc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08bcec27-42b6-4bd5-fe82-08de2e79719f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 12:27:06.6985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ck9jkrzGBQ20VUC/z0Nv2wV93KjUejRjforCK1A+7j6NXjZOcwOWW1OhlxETgXtfpa6xCtcrxPWxoypeQes7jZwbNUDzoRCoAnxrW9OWo5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7494
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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

On 11/27/25 6:39 PM, Kevin Wolf wrote:
> Am 27.11.2025 um 15:31 hat Andrey Drobyshev geschrieben:
>> On 11/27/25 12:02 PM, Daniel P. Berrangé wrote:
>>> On Thu, Nov 27, 2025 at 10:56:12AM +0100, Kevin Wolf wrote:
>>>> Am 25.11.2025 um 15:21 hat andrey.drobyshev@virtuozzo.com geschrieben:
>>>>> From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>>>
>>>>> Commit 772f86839f ("scripts/qemu-gdb: Support coroutine dumps in
>>>>> coredumps") introduced coroutine traces in coredumps using raw stack
>>>>> unwinding.  While this works, this approach does not allow to view the
>>>>> function arguments in the corresponding stack frames.
>>>>>
>>>>> As an alternative, we can obtain saved registers from the coroutine's
>>>>> jmpbuf, copy the original coredump file into a temporary file, patch the
>>>>> saved registers into the tmp coredump's struct elf_prstatus and execute
>>>>> another gdb subprocess to get backtrace from the patched temporary coredump.
>>>>>
>>>>> While providing more detailed info, this alternative approach, however, is
>>>>> quite heavyweight as it takes significantly more time and disk space.
>>>>> So, instead of making it a new default, let's keep raw unwind the default
>>>>> behaviour, but add the '--detailed' option for 'qemu bt' and 'qemu coroutine'
>>>>> command which would enforce the new behaviour.
>>>>> [...]
>>>>
>>>>> +def clone_coredump(source, target, set_regs):
>>>>> +    shutil.copyfile(source, target)
>>>>> +    write_regs_to_coredump(target, set_regs)
>>>>> +
>>>>> +def dump_backtrace_patched(regs):
>>>>> +    files = gdb.execute('info files', False, True).split('\n')
>>>>> +    executable = re.match('^Symbols from "(.*)".$', files[0]).group(1)
>>>>> +    dump = re.search("`(.*)'", files[2]).group(1)
>>>>> +
>>>>> +    with tempfile.NamedTemporaryFile(dir='/tmp', delete=False) as f:
>>>>> +        tmpcore = f.name
>>>>> +
>>>>> +    clone_coredump(dump, tmpcore, regs)
>>>>
>>>> I think this is what makes it so heavy, right? Coredumps can be quite
>>>> large and /tmp is probably a different filesystem, so you end up really
>>>> copying the full size of the coredump around.
>>>
>>> On my system /tmp is  tmpfs, so this is actually bringing the whole
>>> coredump into RAM which is not a sensible approach.
>>>
>>>> Wouldn't it be better in the general case if we could just do a reflink
>>>> copy of the coredump and then do only very few writes for updating the
>>>> register values? Then the overhead should actually be quite negligible
>>>> both in terms of time and disk space.
>>>
>>
>> That's correct, copying the file to /tmp takes most of the time with
>> this approach.
>>
>> As for reflink copy, this might've been a great solution.  However, it
>> would largely depend on the FS used.  E.g. in my system coredumpctl
>> places uncompressed coredump at /var/tmp, which is mounted as ext4.  And
>> in this case:
>>
>> # cp --reflink /var/tmp/coredump-MQCZQc /root
>> cp: failed to clone '/root/coredump-MQCZQc' from
>> '/var/tmp/coredump-MQCZQc': Invalid cross-device link
>>
>> # cp --reflink /var/tmp/coredump-MQCZQc /var/tmp/coredump.ref
>> cp: failed to clone '/var/tmp/coredump.ref' from
>> '/var/tmp/coredump-MQCZQc': Operation not supported
>>
>> Apparently, ext4 doesn't support reflink copy. xfs and btrfs do.  But I
>> guess our implementation better be FS-agnostic.
> 
> Yes, we might still need a slow copy fallback for those filesystems,
> i.e. essentially a 'cp --reflink=auto'. For myself, coredumps will
> generally live on XFS, so I would benefit from creating that copy in the
> same filesystem where the coredump lives, and for you it shouldn't hurt
> at least.
> 
> Another thought... it's a bit crazy, but... we're QEMU, we have our own
> tools for this. We could create a qcow2 overlay for the coredump and
> export it using FUSE! :-D (Probably not very practical because you need
> the right paths for the binaries, but I had to mention it.)
> 
> Kevin
> 

We can surely add reflink copying as a fast path option which we try
first.  That's cheap to implement.  The real issue is designing a
sensible fallback approach.

As for creating an overlay... That's an interesting option but it would
require everybody who wants to use this stuff configure their QEMU build
with --enable-fuse.  We, for instance, don't have it enabled in our
builds, as I'm sure many others.

Of course we can think of an NBD export for such an overlay instead of
FUSE.  But it'll then require root user to write to /dev/nbd0.  Also not
very acceptable.

Quick overlayfs mount with lowerdir=/var/tmp could also solve this.  But
again, root is required.  Not good.

So the most robust option, I guess, is the one suggested by Daniel:
copying some kind of minimal viable coredump part/range instead of the
whole file, which is just enough for producing valid backtrace.  The
only thing left is figuring out which part to copy.  That might require
some tricky ELF structure parsing.

Andrey

