Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F73AD2D0E6
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 12:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfdQk-0003jt-P8; Tue, 13 Jan 2026 07:23:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1vfdQf-0003Zd-L3; Tue, 13 Jan 2026 07:23:22 -0500
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1vfdQd-0003n8-Sq; Tue, 13 Jan 2026 07:23:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPQZposklqG+sVNfeuwczM7doAD1Vs3VF+1YrmHi5QiTHbcMjthwvUFrYMCLrLx5wBTFoHBKN4HRcgNvx7APoyC2KYmyXzPaL1+4ZTE8oEGf0HGEN02eZOeI41MbzrCTYKzyT+1PICbz95S9Cn7N7wygTOkVhTe+EcHqQS0IYnXB8nQiANRAZ6XvpVp1BsVLtZH27WZY8eYdXPzYxSCWrST1yTMFRylA7Dzrri+tuiwnUa7iEIDaLcNP/EMfMY2V/qhcV1Q/dz3vew95uRQgDaagQJWkEUh7eLclaOzrozJj9xllg6Y+up+MjbGeF60N8NykVrpDRGMlKJRfd0bLpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPjtV7jSBvKxVU7xG9iaSF/TVx3XcnrQSaWrR46g2CQ=;
 b=TMu1p0K2lbPZw/RYiEhA5s48KAfZPSp61FD4fkAOZNkcI0M1JGQRfIOFvOi6nlNsPZXnrDMvwzuEfb4sJ4HSeVVydW5t9fKZ3F7QWtAruqxfgzJr3G0Ao1THg4b51OGqiYcxJWda4JQzbSkIfQw6mxK32fBk7t1KNPd37VSJFQ+n8zVTeo0sCfSoNFa4zb2VJBrGs08YYsWOYCpBbP5DP8NVEQjx1z0R+QZObGD4CW70dglaJFIVF6XN79Tep6MBb7J8T+q+yBFRtuAIvu+D33DC8t9nOhERhmLxIwdf+Y+IRtzudmZ+mi0TyI7tU8To2N4cUWiXvvp7e8taUPZhRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPjtV7jSBvKxVU7xG9iaSF/TVx3XcnrQSaWrR46g2CQ=;
 b=X/FIn6U3BgQdD3xM8thtKnPnCZWNvwT/uW03IN7vJoqAxmCQZB4EGDIWpI1H1t6VZYnV+J7Cnw9EHZmk0vj07CfoOF7mxwo/qdLPbPvXRtY//tsLh7I4OLrrID0xdr4AuY8p6fN8+6iJXCvUd1u+3drJJ37MInPyWFTLbDSVdQF+0QfN3STCHWMoVzOkG8MCGa0uFOGNYC32wAoQerT3dtEhApnFQlOv68/kGpq3ZpNX4ietNF8ve/qX7dZ0aqkMval1B1Dbeclr4EFbVBkOQ+urgf7E6nPtZDnOoGrtC+W4hI6iDi/zIsh4QPg4Q79RNNnsgrAQJFbpVp+HJjhhRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB5894.eurprd08.prod.outlook.com (2603:10a6:20b:23d::22)
 by GV1PR08MB8081.eurprd08.prod.outlook.com (2603:10a6:150:97::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 12:23:10 +0000
Received: from AS8PR08MB5894.eurprd08.prod.outlook.com
 ([fe80::d983:dffb:be99:e7bf]) by AS8PR08MB5894.eurprd08.prod.outlook.com
 ([fe80::d983:dffb:be99:e7bf%5]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 12:23:09 +0000
Message-ID: <e570d467-b697-4c51-969f-3242c7abd5e5@virtuozzo.com>
Date: Tue, 13 Jan 2026 13:23:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] fix potential data loss in QEMU (missed flush)
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20251229161740.758800-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20251229161740.758800-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0240.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8c::9) To AS8PR08MB5894.eurprd08.prod.outlook.com
 (2603:10a6:20b:23d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB5894:EE_|GV1PR08MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: 96233f0a-4353-4738-1c53-08de529e81e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eExYQjJ3enpxQUc5RHdaSGp2YjQ1MXladzVSMTJScFVqc1N2TG13OE9OTmVj?=
 =?utf-8?B?S2lIc2gwcXRDRkNjdThFc0tINnk5OHRlWWgyMW5zWHRnUjcrbXg1Sng2VzZK?=
 =?utf-8?B?UFVXcmFrdlpocnZtNmNQMjVXdjQ3ZWlNL2x6TUc1SWpTMmFVUUo0b0lZbmVZ?=
 =?utf-8?B?cnM0WGVvamUxQjhQckJYQW5rTCsyZjJHMzhCc0V3VXlCalBqeVlFVW9UVHVq?=
 =?utf-8?B?Yk0vWjVmdmJCT1ZqWVJ5U0ZGUlZzbzV3WERab09FbEF3ZEFtaFh2eDZQdDdS?=
 =?utf-8?B?V2pKM1ZXUmpEcUtONGlTTFI1ZmdINk0xZGJONXlKSFAyQUVSeCtrT0l2MnNK?=
 =?utf-8?B?MWs1Z3ZlellrQkcxUG9DQkc3UDQ0aThkTEcxQzdKZkRtZEh4c2l6N0x1SU9U?=
 =?utf-8?B?RTE3ZDUwd2VoQUJZVm5ZdGhwZFBqbHZ4bXNid254YXdmV1RPcnBUNElyMGla?=
 =?utf-8?B?OWtnbi9jTHVhOTF2c20wc3VHaWxhWkhTUVUzT3pQN29ra3lrV0d6M1NuYWFl?=
 =?utf-8?B?TGRhQzRtdisyYVlWLzQrUHpwcXRqT1htb2dHUVNHS2VLUnRIWllWcFFkUlJS?=
 =?utf-8?B?N1lqdXIyTGU3Q2xwMktBaHZhZDlzRWlqK3ByaTh6TEV1RFNjTklrQWlURzBT?=
 =?utf-8?B?TG0wam1HZThxbVlFbWNGWU4wNzk4WnFXVHhXcTF1OGdZTnhQWlBDWG1IZWd0?=
 =?utf-8?B?Y2ZycWtUcGNJSFhQU0g1WnJ5YjdwdXlOQzI4Q2VNNG1XMURTNUYvcTRIRXBO?=
 =?utf-8?B?VmcyeVhPMG8yMnJReEc2Q2RTV3AvSXM5NGxzS1pHdllKOGpvZGNHYy82Nyt2?=
 =?utf-8?B?Y1pzeTdLeEYvWmtWVkd1N2tJNlEwRUs1RndqeFJzVnkrRUhVMm1XUnV6cGR4?=
 =?utf-8?B?WHVXN3pPb1ZxcGNiOXhRbC9DYjF1UEI2dk1hT2NEOXZ5YTNudFErV1FZTUtx?=
 =?utf-8?B?WWhmZjBVczBNcC9JUUcrYjhZM0FrWmVuSDBicmVOUlh3c3B1ZjdrN0pYZXMz?=
 =?utf-8?B?YjN0ejhFSGoyWGJVanE5NDA5M0FKclFjYTBmSGVOUit5RnBaQjgwckUyMklv?=
 =?utf-8?B?anVOT1dpZitFSUpJQXlnR0lMcyt5ZEhXMnVOR21GTml6SWc4Z2tYK1lKTzNz?=
 =?utf-8?B?dWZOTDlUV3gyMkdYQnA4K3ZIVTNKMkpTWVNHYXNvejkxTGh4ZkFMWndVZy90?=
 =?utf-8?B?c2hWNGJDRGV2M3JoVVRKUSthU1Ria1B5a1lVQ3RSa0R2SUI1cndQOXpRTjNv?=
 =?utf-8?B?UUZ3ZElGMHY1azc4ck9RbGlLQTlGbHNyMDNCbC9rRE04RWFRb2tlRHhRaUFn?=
 =?utf-8?B?enJnVm1ISmhJMVptOXdjUTJSd3VMaFJLTHpDMFBPT2NlUm1NY0lEbEkyR2kr?=
 =?utf-8?B?bittaktnQzh2bFVnSW1RaGVmWkM3djd0NDR6dXZjWlhDVUZyTFRqOXp0VEQy?=
 =?utf-8?B?TzlkNVRaQkhjMFU2VW4zQkRxSkFFT3NZcTZOMGFOUlNXbDJhQ2pUSVI0SDdU?=
 =?utf-8?B?ek1DY0xOcUVacXpYL3VWdjBGWHgvbCswV1BpMkVUcFBickhxQ3dSRjQxL1E3?=
 =?utf-8?B?WFNQWkR5NnNwNFA4dlVnM3dPa2pSd2VmcFg5dlBHS3F3cXk0QU5xWmZEK082?=
 =?utf-8?B?djc3alpwMnl5K2JSTkJvaUZaaTFnQW0yUHRXSEN6ajRqM2IrRGtxUUFWT3pN?=
 =?utf-8?B?SmtDb0x2S0RaUktnSkxDVkVZeWFwNTdTTmZCSTd1emZZY28vWFVjcVdLbHdK?=
 =?utf-8?B?U0F1bWg1R2pNUllXaEFBRElYUVZHZ0c5U0R1TjIrdkg2TXMxT0Z0UnQxa291?=
 =?utf-8?B?ZDExVWk5K285MUZKZFhHQng5QlZHQytySExPajVLLyt3eVZ0ZVFvaGZ4WDJG?=
 =?utf-8?B?SkNBbVpobU9kRzFLdVdqSmJRZDlqMUI4bmVnSlFYL1RDZEYwTEQ0Wk9sc0dq?=
 =?utf-8?Q?1wXQGgDMQdihHot7HE6A4FOLZse+GIum?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB5894.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFEwc2lOUmZselFVUUFoSnhBc0xGSURFRWRYeFlHRkVreWxaaEE5WTNSUmNw?=
 =?utf-8?B?U0pwNEZxNnVDM2V4c0gzTlZaZURVSlFIc29Hd0R4N3RUNUFOWmZWc3l6eWRt?=
 =?utf-8?B?L2NxbERkdEZ2WEJiZVowQUhsUmxacDErUUZibGdQNkVaYzFhMXdFOXFSekNY?=
 =?utf-8?B?OXFOYVhTQWNTQXFCVnN4VUxiKzNWU1JmUGNOUjdzWllmSEU5Tkpoc2ZUYzVX?=
 =?utf-8?B?NEw4cWlVMVJIYzB5bVFiVmJMZUxMelk5TzJJbE9yTnpqczhQTzZGR21CMGhT?=
 =?utf-8?B?TS9kZFZ3cVJwV0JMZzR3WG1XR0F1YjVOUnNHbjF1TzRtM1NQSVZ3NjNLc1lX?=
 =?utf-8?B?RFhWbVlZSkIvK2tLMGRIMmJBQ3E3eEZQd1RDMXBPaUhFNC9SdzFKVEZzOTBH?=
 =?utf-8?B?RUs3QzVNc3hkK25sTXJJK3F5Q3dIN2h4MnVKVklpNWF2dUVSS1RkeEJNbG9B?=
 =?utf-8?B?SmpsSUQ4UW9CU1NGb2NzYitwWFUrTmd0dktsTTNJV3MycWpaRE9DWUdQWmg3?=
 =?utf-8?B?TDIyYS9MYTZpNGU3RW9uVCt0Qkw0REVlRjcrdHVKOUNwOWpOdGpLZnFxN2FH?=
 =?utf-8?B?VENrT3oyekhoNTNHaUVQR1l0aFlUQm9UUkFEY3g3VjAzRldIVmFUZDlkM1ht?=
 =?utf-8?B?dkQ3RnB5OUM2KzlFcWdNYUx3c2lYcUZZMHZaZEd4SWtRUVpHWjE3Q2Vibnov?=
 =?utf-8?B?cE5tWmRnZXlWWWo2dDVkcHZCODBYU0crSjQ0VEJ5RGJEZEFBekZXNzFsMjIr?=
 =?utf-8?B?VjM3SVhNRzhIVFJlYXovckZ0UWJLNC85Zzc1WFVQQXJndExsTDlheHJ2TlhP?=
 =?utf-8?B?Q3E2bytXUTFRYjZIU1hFQXlMVEJSUGZIVmVPM1R6TmgzY2ZpS0dkRWxvTWFE?=
 =?utf-8?B?ZERpS2lQMkxPMXNETlY2aVE2Zm1qSFU3eDNRVks5TGwydkxibDBvSUQrZTN5?=
 =?utf-8?B?cFRmejBFbW94eXUxRUR6bjl5TlFpQmJwNVJWVDd6b0N6aUU3ZzN1bXYzdWhi?=
 =?utf-8?B?SmpIL0JRRjZVQ3RjSm5hTUxHUVhLa1lMOG9LbVJQSUp6cm9Gb3cybUMvSjdH?=
 =?utf-8?B?dUlnSHJkTGh4ZkRZelJqdTlhVjhtRmFsNWd3OVIzWXBLZmU3R3VQTmM5SlhX?=
 =?utf-8?B?aDN3RW5kNDlBVkRsK2JTVk1pT1NzTXQ3cEppU0Y2VVZGMEIyblMwWlkvS09z?=
 =?utf-8?B?a2hhVlNGWEovNmlYU1dkNkRlSm5oZG1IZWdvdCtaclE2REhnZXRHbVJydlBR?=
 =?utf-8?B?bFNiZGcrQ1d2YklwcmFvUjBGenUzUmRzb0Q4ZG9PMEViMVNhelRrVFM5d3Ur?=
 =?utf-8?B?aEFzNEVBcnRvK0pabTlLeTg3aEZWTmZmclNlK0ZveDdZbDgyQTh3MlErZS8v?=
 =?utf-8?B?bHJJSWdWNjVpMXZCeC9kS2VlZDZkcXVEdk03WnZXN1owM1EzbnVuWHM3ZHhw?=
 =?utf-8?B?NEIrTm8xeG4rNVgrQzEyQXJKcHJ6YjZmcWVZcEVvZGRVWjd6cUNqbEZJdG40?=
 =?utf-8?B?MEtYbWVvcmFPa0NKTm9VakhNWVRJaGE3Q1ZLUnk1SFpaMkp4ZTcvYkhUcW9E?=
 =?utf-8?B?Z1AyVyswcHR5YnF6QnBQZVpkMUNzaHJkQ3hIZXlHampWNEpQZGZtLzJoY3JB?=
 =?utf-8?B?MTJRMFVVaGhnSFVYMzNiV2JUUUhXWG04c0NvaEh1bEVBamRyR0NBdVBnTUpr?=
 =?utf-8?B?aThNbTFsRnhWbVNFVzRZbmtlMFd6eHNMSGw0cDFKckU2TEQzaUxoOTZ3NktX?=
 =?utf-8?B?N3V1NlRqWEVsbXhUc3hsOS9KUEFONTlKVFFjcVNUTU8xb3U0OWR1dHYyKzF6?=
 =?utf-8?B?WXhpc0lXV1JTQUVCM0dvUndiMHJ6Wm5OMFN4U1FBb25uQmRWdCtiVk5jUEpE?=
 =?utf-8?B?NW90UFU3UWJ0SUpGdWltdnF2b2I1K3JUOVZvZjUwSXlKM0EvYnpOQ3lpSzBH?=
 =?utf-8?B?UUt1aitYalUwb1BPNmdvc2UrS2pJTEtYQkVsSDZIaDFqTjBzRW0vc2lYTXlF?=
 =?utf-8?B?L0VFNHdRQjFUUWpjS3lpS3RINXR5WlNYOFNrWUdnSTE0V1pJUUhRd1ZkTjIz?=
 =?utf-8?B?YjZaUEFoRWE0UUFlUHQwa2NmbmY4bDJsVjVIOThNSVJyRnhJVEQxSUh1R1Bn?=
 =?utf-8?B?akNuZDNuTUJDcTRyckRNTUZjRStZeVNGZm5HVnpjemJ3UUZHVm5QeGtGUkxN?=
 =?utf-8?B?UW40eVBlL2k2cTBrbkJOaXNlOWZQU0tCTDU5eWRpUlk3bkVLVmtVeGN2OFht?=
 =?utf-8?B?NTNQcFYwYlV0Z2VkM3ZNZGlkMUxkMzBBUHlDaU1SV2ZSQVNtdlRVdzZ2VXNj?=
 =?utf-8?B?QXFvOGc5VFp0cW9wTmxLalIrVGY4ZHg2TktuU3NQcHNKZlgxSkJjdz09?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96233f0a-4353-4738-1c53-08de529e81e7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB5894.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 12:23:09.0166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npjmJJcvRwKXIZBJwE7m/cfhXQuDFYmtrOT3RstswNdBFJ6ZQnTOSViMfjbj7GZxdK5Lqk1JKanETeIaCF0ZWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8081
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=den@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/29/25 17:07, Denis V. Lunev wrote:
> This series is a followup to my previous patch sent under
> "qcow2: add very final sync on QCOW2 image closing". Could be considered
> as v2.
>
> This series addresses two problems:
> 1. bdrv_co_flush() at the end of bdrv_driver_pwritev() and
>    bdrv_co_do_pwrite_zeroes() could be effectively no op. The problem is
>    that bdrv_co_flush() is optimized internally this way to track real
>    requests which were making changes in the image and without such
>    requests from previous flush() do nothing. Requests are tracked using
>    write_gen on BDS. This field should be incremented after write is
>    completed but before flush is called.
>
>    This could be considered as potential data loss if caller relies on
>    BDRV_REQ_FUA flag which means that such requests are really lands on
>    the underlying device, which could not due to missed flush().
>
> 2. qcow2_update_header() must actually write header with BDRV_REQ_FUA
>    flag as image processing on open relies on the fact that header is
>    actual and it is not possible to reorder header modifications and
>    image content modifications.
>
> Changes:
>     * added patches 1 & 2
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
>
ping

