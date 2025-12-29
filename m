Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB4EE92724
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 14:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaEG1-0006z2-N8; Mon, 29 Dec 2025 09:30:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1vaEFz-0006ye-Uo; Mon, 29 Dec 2025 09:29:59 -0500
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1vaEFx-0004KN-SX; Mon, 29 Dec 2025 09:29:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+O1eBy7taMopCEisu4RLl0lNLK5y/jP+ZgUnoVpxbKteuTIVvULIJxsPOV3JLXD+UGG6+LkdxvGZO9NDdvQxlj/htsZxUQxjIm23Blvd1JFqvKME9m/d2JfTaVCdGPUwlLgg4ZWahkYh7lbeAfjhRri3WeVkJa2WDlvAElqKB6AUe9oAXZeZvVzyH32vG7nnbT0a5DgSK2JUeLiYI9f2udWRFahHHPuu4sOcWJbH2GBW6KkXh8UMJMNGGK+1aAe+9XJAlED+sreYXTCKaelNc76RsMFMWT+uufe1B8/pSJu+yoyN5WOL/AvyuAlKLR2ivzQMOjFDE6uKVXpohRzuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHlT0ZGoc/an8az2MGCtSBbA8S4DKl/lnUrPdC93+gU=;
 b=eQNKB1sPws2N0HXjqnlZHh6YlP2x284Qg/DtXLjQ0b1XH2vjCysECfbs+UzwcLJB02EuRr5/sg/OLjMdTMAS3ZHZSl/kVflv3CF6iYy4xY0wKSpxazdAbG9wmxd58MM54qNxjFIV00a9npxXG4Sy4q1NGOJN/GxibR6Wf1BTccRcBaKTdzYZGeC9/s4Z6CSgtzK/vLWaZLoV7TZxS1wgJoQVh9fXc2xKyrq+vvBlLFBujG3gB3v6yKVF3lN8AW5GeKm1F1QauN6ZfxxIoyt+rDdtKs3IfXVEZ3LjpIN4I7EBS6dpOiD3etBOAiHJZGQATQuQeswK285t+gr098TKLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHlT0ZGoc/an8az2MGCtSBbA8S4DKl/lnUrPdC93+gU=;
 b=VT9szQV/HgAI7kBpz7yHQtH7Hxye0t4eCxx7U62DTZqcV9aExt3Bha3Patqp7pGshaPkOihdYg8EAVQ2ljaHHLKWBb5iTEWZJ91Xv9u2QcGZ3MQv+R1nOX2DJZ32yqJbQdChxvdn6AFpq56eO/b8BQXO9eYO3YaM2+YT8k7AFjzy8rLuFcDj1eZCWpeCaB0KuWM/rP2C5nHp3/wYl5V+jdabLvvMj+BY28Nbo1579vN5ikV/mupadGOwTku3eMklQR+Hw3zvJYhhCOcPP9ZXTsEHButrK/U52cVzLcDdD6sy9AfSdfyZktrx7p0YJqDaJE6SpulrEL5/rF2A7LJU0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DBAPR08MB5605.eurprd08.prod.outlook.com (2603:10a6:10:1af::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 14:29:52 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%7]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 14:29:52 +0000
Message-ID: <62286d8a-eb8b-4753-984e-1e294d96529b@virtuozzo.com>
Date: Mon, 29 Dec 2025 15:29:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] qcow2: add very final sync on QCOW2 image closing -
 BDRV_REQ_FUA processing is broken
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
References: <20251219180813.1000884-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20251219180813.1000884-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0085.eurprd04.prod.outlook.com
 (2603:10a6:803:64::20) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DBAPR08MB5605:EE_
X-MS-Office365-Filtering-Correlation-Id: 37d4e583-1f0a-45f0-84e1-08de46e6bad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkRMQlg5TUZpYUs2UlYwcmhyT3FjTnBtWUxIQ3piRnczTjRVVUhZVlBhdGdJ?=
 =?utf-8?B?a3RFaUUzT25XNFk5QjJXWHR4UmJORjEyWFM2cHZKVFRDZDVuN01rMFpGZ2NK?=
 =?utf-8?B?a21lZTlsa0s1enlxRTUrbUZnS0NxUkNleE9QTlVZdU45dmF0ZC94L2RiTzBP?=
 =?utf-8?B?QSsyU3hTeVFoZmsxV2dYaG5Kc3lLNTgyQlRMVWN4MVIyb3A3WXlwVFRhOEI0?=
 =?utf-8?B?QVFrUkVzU05pdkEyaXgvMEQxYitCMGZOMGUrTnJHOGZHV21oMmtXejlwNUVX?=
 =?utf-8?B?aXd6WC9YNU9rRVVocXNvS3BtVTJaUFdhS3FZTXpJVGVabGdTTm03Z0V6RlN0?=
 =?utf-8?B?c2R3L0pESGYyMmtJMHZHcDJQeWhKVkR2Q0svUXFZeDYveGFyZElOVVRVcm0z?=
 =?utf-8?B?Z1RhRjhwQ2ZhR2NGenZOYThOd3V6c24yTER6RExzM1ZlMUgzbGY5NUtHTVRD?=
 =?utf-8?B?ckhWeVhMK3RnMWRwRTNHQlpzVmMrbGNoN0NZYmJKWVUrSFNweUV4c1kxTW9G?=
 =?utf-8?B?bVJ1U09OQW9CNEF3Vm9TT3A1azFjenh5OGd1MzNqYU1YMUtPTVgwUUswQUVQ?=
 =?utf-8?B?bmlRdGs3aE1pM1BZT0FBVlBGV3lWUWo2TW1aVzlCMkU5Z0V1NjV4Qzg5bXdu?=
 =?utf-8?B?eTEvWXU3TDlBeWx2RjZnUFVydDZlTURhTWpzVCtWTFYzd0Rld3UyVzV2U2xO?=
 =?utf-8?B?YTJvanRGS2FwVVYrNm04bFY1Q2VDRENsOVgzRU82enpOWnh3Rms1NHk3OFF2?=
 =?utf-8?B?R2dUc0p6NnVYNngyMzNWRWwrZmU1U05nZlFqVzNxSVRONDVoUEt2UUxrcTNT?=
 =?utf-8?B?b2NHTjV0c29yT3ZyNExHbEdNNEVaNUEwMXQ5VW8zSkU0UGRuTkdUYkVFb0FY?=
 =?utf-8?B?RFMvemxuc3J4eExLbEhNV1hhNmxEbXBXWjVRcXcxS1NzUEZxR0JwUDBsTC9G?=
 =?utf-8?B?VGVRRk1sRjNPa081NG4vcDJKTUl3aktmK2xOM1l1M2FtSVV3MVRlS3RIQ3dI?=
 =?utf-8?B?cGpidmpyKzBpZGZaVHM1UFNFc3k2Ni9TOHNkOE5Sck83bzM5T05PdENJcjZL?=
 =?utf-8?B?UEZ4K3V3RU9OVnpRVWN2eFlIWXYyTDhPUFNyV3RHVEhZNUJXY0lDQ3FZSmRK?=
 =?utf-8?B?aERlZzQ1QnFsNzczV3lTdmg1YVdYVVY5dlB2bXNxVFcwSTJraURsMzNERkRK?=
 =?utf-8?B?aGJKY2kvZ2EyamhKOVFYN1pFQWtGbGNMZXlldXh6QmNvV1RjMTd3RHJRRjd2?=
 =?utf-8?B?TU9TbjNjVlp0amxJS3JqTzgxZHJ4ck5HakU1bkhjdXNzSTRFUzVkeHJ6emNq?=
 =?utf-8?B?QWJhVkp6TUhja0FkY3ZpQ0RaeVZtcTVZTUx4ZDZ6eEp4TnNlV3RMcGxjbU1m?=
 =?utf-8?B?SEsxSWJGcGF2UzE3MHdwNjUzcWJiTHpBcXRsV0xCR3FlU0o2WmQxMUVrd3Jh?=
 =?utf-8?B?UHF5OEx6TGFtb1JuNUEydzZaQ3VmZnk2M0FtT2huMEYzWHlXWlFXRkZzYmZK?=
 =?utf-8?B?M21qMVNqUlVZWlA5cTBRdE9pdHgyRmIrUVF3U3JEWHNsYTREdmU3T0dRZ0Vx?=
 =?utf-8?B?ZFR4NXE3ZHpHVlJGQ0IxVHdTL2FrMDkwYmhyZFVmSm1SVDAzMk11cERtS0Nt?=
 =?utf-8?B?ZXpKclg5ek1pNGtjd2lZbFpqME9nSVozcko1Z01UV29wS2RaRFBjR05JM0hm?=
 =?utf-8?B?RUJqc2JtMnkzbys4V2Z0aDdVMkk5Y2w4WHFMdzkwYVVJUHdvNlByR0JOMDRG?=
 =?utf-8?B?bHJET2U3RnFVUGtqYTh0ODhWRFQrLzFoalhIN2IrT2I5aW9GY2QyV0YyNDRm?=
 =?utf-8?B?QjhlRXcvM09jNWNzKzRyeno0NGpTTGNveVdOVDBQSTdFdzZDbXQ4ZXE4QmxC?=
 =?utf-8?B?am1UODRFWEc4UVFieDdwNmttNGVWa0k0Rm1VK1EySWR5UXdYTHBMWlVveG4v?=
 =?utf-8?Q?rfEgSu6+5cfsYaGihdwvsklfnCLhImJ5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHZMSnFXOHNVZWNPR1o5OS8wT3JVTXdaVks1OFBTbFcwcllSV0x4eVVuQmEy?=
 =?utf-8?B?dW5PMCt1STdldTNqMjR3UVdCT0lHTEtLVTBoNDE5TldjY0FmWkRwQVNFempt?=
 =?utf-8?B?ZFBSRnZMRmdxejFVWGVxWitZak42Z0hEMG9va3cyZG8yTVg2MFVkY0RPTGdH?=
 =?utf-8?B?Z09KSmJYaHlEcmNBSkNDN1d2V0FiaCtUOUFkdkNnb00xbDJvOUF4L09xOGdD?=
 =?utf-8?B?TlA3VXUwNFdrR0NVMy9yTXJOUXliRUpSdnRUWnV4VUxiakZsWnVPdldtNXov?=
 =?utf-8?B?Wmp2ZXlXYzNvUzc4QjZuSURYenJJWTAyYUt2K2hKSkNTbHhMbjBZWkpDNDZO?=
 =?utf-8?B?ckZyTk9WNDMyOHo4T0dSdnFFd1hqajc0NUlxd0drUHgzd0kwV2d6cGEwR2Nk?=
 =?utf-8?B?bllqL2IwY3RCajFoZno3aHR2WkVvWFJJVktqUDloR0JkOC9UcktmT0gycjRq?=
 =?utf-8?B?MEhzQ2I1RTB6U3FzUjJ0QWRlWnRrVHM4elowcUZOOUlTRWo0UDliNHBoZ1RI?=
 =?utf-8?B?RnYzTE9SdG5mTUE1VXpLZUs0a09Ddm9SeTB3dnpmekNoVk02UGtqYWY3bDhy?=
 =?utf-8?B?QVNoWEZZajJYbE1tVFB3eXNVUkFINGxvUmpteHJGTC9UTEdJNmg5NjNBNW9p?=
 =?utf-8?B?djZQOU5tZEhkZDNKZlQwRHdFZDRjbHdQc3UxUThBYmg0UGgrR0hVUDJOalNs?=
 =?utf-8?B?MUNtd1BiYzYvUUFMN2VSckVyeWJVVHRxMEgzeXRjdFJOWUFUdTFHemxkb3JS?=
 =?utf-8?B?bTFBSmZUbFZ2SmZURnNQNmRsdXVuVy9VRHBsS21lWHgrUitKVHVvUWcwUGNn?=
 =?utf-8?B?RHlOeGZ3RUFmTFoyWHgrOUd4MkVNVkV4d3NEUXVkcHlJQ0N6MU5lTFYzTVBK?=
 =?utf-8?B?NCtEbjQ5czlxblFHMWtKNC9zaDZ6SklqWXowL2E1a3EwRStmMURCTFV2UUl4?=
 =?utf-8?B?dGk0SHpwVXdxUjhwbDViQlorWnltT2MwU1dRaEdTU3ZYb0pDdStyUXJYWHFH?=
 =?utf-8?B?WlppNkhFUFNKcEtDNzZPYVN0M04rVnFwVEFGekdNTExscWY1YXNhdHR6ZkhE?=
 =?utf-8?B?aDJMMHZadXJXOWp0aWZiTVJXNzlnUEFSWER6REdBeTBoUEFYejJYZDFtVHJB?=
 =?utf-8?B?YksyVlE4ME54SXEwZDVXNXFEbXhqeEk0dW1qaGt1SllZUm1nVXVtYzlMYVdr?=
 =?utf-8?B?a2I4U3V2aE5HL2F6RzAyd1ZiY0g5andqSm1rcTc0OVVsL3RqOURia0NNRGhO?=
 =?utf-8?B?aW5hNFZ5Z3Q3UWdOc2p5Y3VRUlZudVE0OEd5VE8wYjg4dnY0WW4reDMwd0ps?=
 =?utf-8?B?RDlwYTY4MENoMWtvV0JFUG40RWQyYklVdVRoTGlza0pidWpBYTdUSjBFaEZK?=
 =?utf-8?B?UGtOLzcrd1F1ZzR4MW4yY01KVDd5UDVtcGNKZlNxc2w1bkMrT28rQjlqTFdQ?=
 =?utf-8?B?bmtEdWN2dkQ4KzZESnM2ZEpTYkswTTVXdGNwR0ZubVhrN3RaWXNrTFVHYmVC?=
 =?utf-8?B?Smc0QUxxbE16N1JvWG5XdS93N1RxdHZvdDNmdlAxMGx5VSs5ZWloM0tsdG1T?=
 =?utf-8?B?dG9qUk45TXRrMG1kMnUvck5HanJNYVNaOTFreVRlQkVxQ3hVeTJobHM5WXN0?=
 =?utf-8?B?bER2VWsvbXlYVDJkMkVBb0xyS0hSbkdoSmp2RVU3V1QrZUREN2JSbjRqN2Nr?=
 =?utf-8?B?Z09JTUtDdCtyV0F2NWI0aWIxa2FhYjNUQm83bFptTWJRUDZwOEdiUUxycGho?=
 =?utf-8?B?enNjZVlIZ2pkWUlTN28va0NRUmM5UHp6STdCdFBnS3QzcVJJakhRWkMySXhY?=
 =?utf-8?B?OHpTSW5OTFBldVh4S1htdnY4dnhCUmtVbG9qS3hCZGlkMkZWNUdpRFFlQkVK?=
 =?utf-8?B?eU9HaXBVQzBEZTVhTytHVWkxOGhXMUMycGwyNitJWkFtVVg1N0xCV2N5aXZN?=
 =?utf-8?B?NnB0ZEVlSTZVYkZqYmp2djZMcmJOZ21ZUG9OQjFMK2EwSjFWSDhMNUJib0Qr?=
 =?utf-8?B?QlMrRUpWK1l5MFlsa1gwTDQvaElSS0FHb2RidndTdHVYRVVoY2pjak5mZ0RM?=
 =?utf-8?B?WFpUM2dFS0Zya0FHcXVtMHFycG96bmFhdXlMZVE0c01yR0NjWm1QMnRXdnQ4?=
 =?utf-8?B?TG5MMExqdlFOSFBoai9ld2g3MGozZnlCbEhhVnpjMnFpVXhnNjVFaGQyOXNm?=
 =?utf-8?B?RWlhNk92NDFlSGlXc2hSY0tQSkoydmJ5UlQ5T2Q4YVY4aTYycFE0SmE3N05w?=
 =?utf-8?B?OVRFMkhDQXV6c28rZVlibWgrQmxpcGNvRDd5ci9qQ0kxR1hiblh2aVI5UElt?=
 =?utf-8?B?YmJ6QndFdlkwUGRLbHBFNEFvdTkwUkFVb0cwNEQxVHRZYmhJQ0FsQT09?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d4e583-1f0a-45f0-84e1-08de46e6bad8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 14:29:52.5460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDjn/esV4ZbO8z12PXzp9RL3d9TQnvkWGDeogMpcxTowcx594j1U+fyOsqDbK3XtUjb4FjZomagcGr2N0dZxFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5605
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=den@virtuozzo.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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

On 12/19/25 19:08, Denis V. Lunev wrote:
> qcow2_header_updated() is the final call during image close. This means
> after this point we will have no IO operations on this file descriptor.
> This assumption has been validated via 'strace' which clearly confirms
> that this is very final write and there is no sync after this point.
>
> There is almost no problem when the image is residing in local
> filesystem except that we will have image check if the chage will
> not reach disk before powerloss, but with a network or distributed
> filesystem we come to trouble. The change could be in flight and we
> can miss this data on other node like during migration.
>
> The patch adds BDRV_REQ_FUA to the write request to do the trick.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> ---
>   block/qcow2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/qcow2.c b/block/qcow2.c
> index e29810d86a..abbc4e82ba 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3252,7 +3252,7 @@ int qcow2_update_header(BlockDriverState *bs)
>       }
>   
>       /* Write the new header */
> -    ret = bdrv_pwrite(bs->file, 0, s->cluster_size, header, 0);
> +    ret = bdrv_pwrite(bs->file, 0, s->cluster_size, header, BDRV_REQ_FUA);
>       if (ret < 0) {
>           goto fail;
>       }
(attempt #2, mailer has rotten the mail. sorry).

Thanks a lot for Andrey Drobyshev who has attempted to review and
test this patch.

The patch is non-working due to broken BDRV_REQ_FUA processing in QEMU 
code and this looks more severe than the original problem. bdrv_pwrite() 
endups in bdrv_aligned_pwritev() which internally calls 
bdrv_driver_pwritev() -> bdrv_co_flush() bdrv_co_write_req_finish() 
Please note, that bdrv_co_flush() is in reality noop until bs->write_gen 
is incremented, which happened only late inside 
bdrv_co_write_req_finish(). This means that BDRV_REQ_FUA request will be 
flushed only on the NEXT flush operation, which is definitely wrong. Den

