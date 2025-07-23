Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B33C83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 17:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ued3e-0000z5-N9; Wed, 23 Jul 2025 13:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1ued3F-0000s6-A1
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 13:14:45 -0400
Received: from mail-westeuropeazon11022131.outbound.protection.outlook.com
 ([52.101.71.131] helo=AS8PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1ued3A-00063n-Er
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 13:14:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFyx8PlJ4F9N8iHbzILmaUej0PvaCT/vyPGdr3IhUKPg/cHpr0qA8nlXjJoDQY8Z630DP9x5k0Yfkh0u8uke0emQFw0DiTgCwnZQZbB1xZqqjYyBzF7hzcSJqxD0Wyp9s6a+jrIK/DFBUiPjKolT4m1wvxfok3K2HuNHXtj2goqZvH8jMO4Wq9PXA8XETRAQaneu76lN2YxLhaAekldtDZTRIP8EZmC24S3UM4sJxkSoZi0IvGx8rhyvhMQLE8iuSZTKpGjLBgn/U4RQM7j5zMMg3P0vz42NG6fJxMzGmcWarVTR3Si7euzXBKmmOEdCq6uPZFksJeNcie34DCCk/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luWm0lsPvQr++id/URWjekBxXieazj/Sjes3LLbKKVw=;
 b=WVHbjcvHkADd9alpNof4l1NrbGMy1TnSCn52E+Mhxa/XRbUsc+0Mwr2evDgmsPVbxc9Vjwjzf08dzrbHo7UHaykhFMeGLaVchRweFvDZz6iriaiFm61ErSx1z2JHYQYnMu/o6TKYyH4FhB1AGTsG7FMmPYJ6hn/Dy44jEme1T8qzfTpqRa5U+DdRQTRWDrnxaQHjJ6yBYRbTLNmWzBfZ05yhwVUYrgWzmXhnyxahwkIylkTIBgTakhMrTDH1qTH6/Iuf/momKQF1fcK1EQO3opYTqvS3cBTZ/xrkjnVGzEJdS+rVXtcdkBL2KJNVOMkXz/Pd0lLKOSlqcv/6nZ2q7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luWm0lsPvQr++id/URWjekBxXieazj/Sjes3LLbKKVw=;
 b=EC0evhSqPwL+ns7JT/XYHXwYIk56bEReBprYKOTZvIOc6t0Xwk4qU+uW9U5IlOIVmSQ+jCWzqwn1sxGXnfpEe9RPF76/EktSLlkwJZtED20c+onkpzvFQCCA1/vSFtprW0pJqe4U4ag/K2RpNsqvLtEE0NEGKyy4jlJvj2faQpClRWSzBVFPvsUSImm8oWOWe8R2We3Bl8W1qgjwMUn19H+XH7pXNz0zSWQtnTcgTMndMQvQ6AGjBpfvQAUWoEexEJ/LFM23ZvBcIw1cJFuW6lZkZX87iABU2x1DXj8RksGPlspEu5J92JLgrjxmQFYwyY3GHtgsTGl29+c5HnZdsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DU0PR08MB9322.eurprd08.prod.outlook.com (2603:10a6:10:41d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Wed, 23 Jul
 2025 17:09:36 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1%3]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 17:09:35 +0000
Message-ID: <e598a9a4-9995-411f-a73e-26f06b3d3cc4@virtuozzo.com>
Date: Wed, 23 Jul 2025 19:09:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dump: enhance win_dump_available to report properly
To: Nikolai Barybin <nikolai.barybin@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250723170402.75798-1-nikolai.barybin@virtuozzo.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20250723170402.75798-1-nikolai.barybin@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0138.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::36) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DU0PR08MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d4bdc20-143e-47d8-3fab-08ddca0bb287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWdzTytSVWUwSzVmdmVJQkFBeG5qSTFmMFN2OGR3eEFjZWlabkRwWStHaXlN?=
 =?utf-8?B?QlNpKzduOTRPSjNraExDZEloRllnaS9hc21MT05lYmRZWVlHOXA3aitiWnNF?=
 =?utf-8?B?WHFKZmxoMEZJS2NHQnNENlhlUFpOU2FjZzFNM29oT1JsQ3lzVG96aEkrQ0Jw?=
 =?utf-8?B?R1RzTjY3MXIxTGc5ZmIwVDR3VzRuQVhuN1pSSEEzcjY5TUlOOTdvU2hiSGJQ?=
 =?utf-8?B?d1NCMitYNGloL2pPcndGUTRnUkxqV2crTWlMbzNxamdEMEhucE1TYjg2dE01?=
 =?utf-8?B?Z1NhV3VxbFEvcXIwM1o2b0dGMHlrT0ZPZGhOUnY0ZEc5WUJYUHBMVHZJMU1B?=
 =?utf-8?B?cmNscVVpblVhVVZ1bVJEeVEwRUdjQkpZSHkvTmpzODB4R1VTQWdYK3V1NlhO?=
 =?utf-8?B?Q29YV3dZZitRSlRCcWxTUFRNbWQwSlIrWEtwczNpZ2tGN2haRmd3bWJCOWo4?=
 =?utf-8?B?TDgwV09rdkUyOXl6TFFJODJZSVZZWVVoT3YzQUU3djhTMTlKQW1EMSt6VVhQ?=
 =?utf-8?B?Y1FvOVN3YmRPQVJwYVVySjFSY2JxWjc3RURkWXJZZ3c3dGRMU0x4OTFiaGNT?=
 =?utf-8?B?eUIrZmVya2dYMlJxK0pXc21DcWJsOVQxeEplUzB5dVRUTk9rYVB6TldMeHk4?=
 =?utf-8?B?UUlqTjRRY0ZZVXJBL3ZKamFvN3M3cGN1NktGY0VpclhkOUFodWNIR3czRStm?=
 =?utf-8?B?MWtyaHJLbTdCRzJKbkhSU1FlNlRGc3ZNcmlDMXREdTJkRFlDUThSMWZWL2xJ?=
 =?utf-8?B?M0o4RXZVc1B1dmZxcmEyY21DbGVYc1gzcGgyOEhHanIzc0JraFBKdHczUmU2?=
 =?utf-8?B?YnUvM0tTb3hzZG9sR29sT1ZzU2ZkRnpTNjJ5UngyVm8xVEN3cnpXYUJwZTNF?=
 =?utf-8?B?dGlpWHAvM1B4KzBZQlYxM3gydHJnblZ0MDY3enV0WVNyQXpVMlJ1UldYZ0Nk?=
 =?utf-8?B?c3RWMjNGeWVpS1RNc0tJUE82YzBPM2swZUUremt3MWVwNm4yaUxZOTk1RUFO?=
 =?utf-8?B?eHBUUlFSdC94UXo5UEN0bkRkYmhjS3ZweUJZWVRpRG5tenJSR2UxaGg5OWtz?=
 =?utf-8?B?VmI4TlNubzNZdHJFU1VFKzNWbTdYL2Y4RUtkUFlQcWpOQmFGZGRxNkdMOTM2?=
 =?utf-8?B?V1ZYcjVoeGhVcjl6NXk1M1FFa1NSWUFvMmQ2TVR6RFg2NkNaeVh1ZWlQLytq?=
 =?utf-8?B?c2djZ0NJSHk0U29KNkdQL1Qvbm1mSEtQRUlLMm5WVHcrOVJNK1orK3hWTmVX?=
 =?utf-8?B?V0tCRFFDdlp3bU9kK0sxbkdhTzd0THRKSEorRFdDeFNTdTlkS3hMMUNsdUNP?=
 =?utf-8?B?SVIyK2hBY2RLRmtLbUk4RUdoU1o5K0lEMTlMd04wOFF1VFZ6cU51OS9JcEY1?=
 =?utf-8?B?aW5BYXVmelF0N2RPV29OZkNzWHdjSXh2bGxzd3ptclpWWUpsY0dOV2RuQUxU?=
 =?utf-8?B?clFCSXdKSEdXWWg4MHBRTi90QmRrMWlXNkhoWTdKd2xIbGM5T3pNWm1ld2Vo?=
 =?utf-8?B?bnRtcmJqK2VCV1k1SW9xcThadmg2czlMQmw3UW9Vem05QWJ1QWVNVFNMVmpq?=
 =?utf-8?B?cmdpNGp3SndOVy9RNjM3SGhJTnRhbCt0QkVwbndodDE4QWZ0VHZxUjI3WkdE?=
 =?utf-8?B?ZFNlLzYzbFZZM29uYm52MnFIenJkRW8wUXFDVytMRFFDWnNydGlwUklVU3Bj?=
 =?utf-8?B?Z2lyOW1YVklyVTAxVFZ4NEVueEl3UWpzVlkrYzg0WFFWeG9HZG8wek4ycENX?=
 =?utf-8?B?a0RHUWRtYWpYSXBsVVRLcVVoclVKUzNkSUZDMFpjTjk5T3RaY0MzTEtFOC9p?=
 =?utf-8?Q?QIYAHxa/8aEQF+o9C5GrDyf71TnW0Z4lF3uZ4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1BQZEZtUTFxb0x5MC9rQXY2N0RWMXZBZlBFaVJ6ZDdqQ0h5QzVFdThLOTE4?=
 =?utf-8?B?QllWNTZ0WEdIb2tsRjNjV1dTWkloT0phK0RoNklXSkgvZFpJZmhXdm5KdDhu?=
 =?utf-8?B?THdSeUFmSkVhbTlWTDFlRkFXTE1ma0pLRnpCanJvQkFjNnJDUmhsN20zTU5u?=
 =?utf-8?B?b2d3bTRNdzJ6QWVBU0lFdTdCWWR1UW93a2tsSUVKcC9LWWNkNS83akVLeUxL?=
 =?utf-8?B?WkJpR3ZuYjYzVGMybVZZQ2ZQeXVMOTRHOFY0UTdsMnlWVzBPTDI2T3JrR0k3?=
 =?utf-8?B?aVlXY29tUFFjQ3Ryc24xOFJtYTNNS2ZLazZ0RjR2cVZwL3kwRDZseDJmWVE1?=
 =?utf-8?B?ajVQNnFBajd6Zi91L2lGWXRBNTJpT05CN1NhOVBsVmNIODh1Z01xenk0cUFS?=
 =?utf-8?B?NXRQUHNDWnNSbm91N3JSejJBR1pLaVFXczgvZ3U0SVVNY2ppV1ZZOWFIbmh4?=
 =?utf-8?B?QXdNS2FOMk1vRFdZL09WWnhTeVM5Mmp0WUJHVlJHU3labVh2ekh2aCtweWFE?=
 =?utf-8?B?VXoyUXQ5bVFqaXdPNFhaTk1Cb0R3OElOSlJIc2M5KytKNzA5ejlwa0llTnhB?=
 =?utf-8?B?QjlEU25maENBNTNENERmcW5iVGo2N3F4Y1JCNGxnYUtzYnkyRHBkanhFcHRt?=
 =?utf-8?B?aVVGTTBYYXVBNmVlY2xMUTUxMTNJanFTdVNnemttSVNxdW5sdXhUcmdsTWg3?=
 =?utf-8?B?ckozOUhNU3c4KzRkYXNqVlFxUmV3NThqNEQySVZQaENrTEdNWDBBdVBIaW4x?=
 =?utf-8?B?bjhOWFVDaHJGbjVseGptY0lXd2lmWWI2Nkt6UE9XQThJTlBNdkpxR3c2ZG5H?=
 =?utf-8?B?QmtwMDREQm5OQzVRMlRCaVlxNnR6aDVPRUExTHpBUWtJSC9GVHFyUTRoTVFY?=
 =?utf-8?B?UzgzNWhwRlYyQ3hob0YwQ0ZOSUVXbmZFQUtWaWpQSWM4L0JCZDZGK3MyL3lm?=
 =?utf-8?B?c3BKcyt6TGlwRVB5TFBNUEhmK0gvSGdRWmJZc3hybG0yK1A3djJXWHNFNjlW?=
 =?utf-8?B?TlNNRGVFS2YwTDhyYW4xYW5zWmtYb291VGJ0V2kyZ1BqbHlJUGtmYzNLbkRU?=
 =?utf-8?B?bGtvZ3d0T0x1TWhRUlpoVHVOVXcvbzd1RjZjRkVaZ0t6Q2tSMVo1bWlNZHEw?=
 =?utf-8?B?empEVXlicGRjY2FWMFBTaVpLc2JRem0yS0J0bGFqNCtBS2hudnYxVVd1SnY5?=
 =?utf-8?B?NzhFaUVKQU45WkUzSXArcHBwZkdiRUc5MmlobE0ydEVsK3o4OHh5RGxvOWN5?=
 =?utf-8?B?WlkwWWdIN1dLdUxOYzNqTStIQ2JYU09wdko2RndKNjNTUUtmTStVcHRjT1FP?=
 =?utf-8?B?dHVMV0x0T3ZtdGVNemVFVURwWUc4bEQ5MFJmbVhhL2hIRFpMMk0zYzg3OGg5?=
 =?utf-8?B?RVBNNW1wM1grdGZkbjVKR285TXEweDlwTHVqTHBBWVdHcERBVk9lWWNybkNr?=
 =?utf-8?B?OVpsNkhvZjBNaVhJRW9QKzZCVmc2S0RsRXVFQnlWcDhHcU56alNmNHJCRGZM?=
 =?utf-8?B?TTJGVGxLY0ErOGJwYUhkdmZBTm9wZC82NmZNcnZyK0U4aFlBMk5Pc0FMOEQw?=
 =?utf-8?B?VFJMaFR0emtaZUFONFl1RUhLeGZiT2VwWHlUM0gvODJZRU9BYk5uajFZUUxK?=
 =?utf-8?B?RXFYOEVlR0g3M1d1VVVsMk93ZDQxc0pmQ29ZTnpIZmZBSnBpNUFVSHRVSUlB?=
 =?utf-8?B?Mi9FaGx1S05USGdjK2NDMU5ObXpIRC9qSzVzcVppYzlwb2sreFpkM3BBblRI?=
 =?utf-8?B?UHZtSDZXOFVXcHYzZ3kxdTUvMHE4eXdYTXNmYVRtOHFhMTVwZEFZUWJhZy9P?=
 =?utf-8?B?ZnV2VEtXSk0xd3JGWlhSVUxOdEk3VzVYT1hGbmFaRVBydTNyMzRveVBnbUFm?=
 =?utf-8?B?bWk0M0Y2ajRWRGpZZS9ycHMyZ0s0bjcvUlp6TEJNN3I5MDlra2x2NnZwSlFG?=
 =?utf-8?B?MUk4UUVLNVNmaVZETFBVclQvbnFjZUphZTFHVlhtTys4YjlDRzV3N2tOaVlm?=
 =?utf-8?B?bUdsbjJzYytVZXF2ckwvVVZYdGc0LzA5SlNHbjdlSnFUdWJPblNBaGxsN2hR?=
 =?utf-8?B?NjExYzZFNXI3a0NHSUh2L3ZpQlJyZCs3VmNVN0hZY01iUjJZQXlhV3dCSVVa?=
 =?utf-8?Q?mfOXn+DoxJlw4C4RCCv2/ITkS?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4bdc20-143e-47d8-3fab-08ddca0bb287
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 17:09:34.6492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3S3/7UCCSQjS5HBevA/PNNTge0HlO3/CwSxuiuJAk5gZDT8bQWK5tU0dyceMxCsjf7NTqEoCh8r4hY2Y/r5U7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9322
Received-SPF: pass client-ip=52.101.71.131; envelope-from=den@virtuozzo.com;
 helo=AS8PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/23/25 19:04, Nikolai Barybin wrote:
> QMP query-dump-guest-memory-capability reports win dump as available for
> any x86 VM, which is false.
>
> This patch implements proper query of vmcoreinfo and calculation of
> guest note size. Based on that we can surely report whether win dump
> available or not.
>
> For further reference one may review this libvirt discussion:
> https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB/#HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB
> [PATCH 0/4] Allow xml-configured coredump format on VM crash
>
> Signed-off-by: Nikolai Barybin <nikolai.barybin@virtuozzo.com>
> ---
>   dump/win_dump.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 60 insertions(+)
>
> diff --git a/dump/win_dump.c b/dump/win_dump.c
> index 3162e8bd48..4bb1b28e63 100644
> --- a/dump/win_dump.c
> +++ b/dump/win_dump.c
> @@ -14,14 +14,74 @@
>   #include "qemu/error-report.h"
>   #include "exec/cpu-defs.h"
>   #include "hw/core/cpu.h"
> +#include "hw/misc/vmcoreinfo.h"
>   #include "qemu/win_dump_defs.h"
>   #include "win_dump.h"
>   #include "cpu.h"
> +#include "elf.h"
>   
>   #if defined(TARGET_X86_64)
>   
> +#define ELF_NOTE_SIZE(hdr_size, name_size, desc_size)   \
> +    ((DIV_ROUND_UP((hdr_size), 4) +                     \
> +      DIV_ROUND_UP((name_size), 4) +                    \
> +      DIV_ROUND_UP((desc_size), 4)) * 4)
> +
>   bool win_dump_available(Error **errp)
>   {
> +    uint64_t addr, note_head_size, name_size, desc_size;
> +    uint32_t size;
> +    uint16_t guest_format;
> +    uint8_t *guest_note = NULL;
> +    size_t guest_note_size = 0;
> +    VMCoreInfoState *vmci = vmcoreinfo_find();
> +    ArchDumpInfo dump_info = {};
> +    GuestPhysBlockList blocks = {};
> +    int ret;
> +
> +    if (!vmci || !vmci->has_vmcoreinfo)
> +        return false;
> +
> +    ret = cpu_get_dump_info(&dump_info, &blocks);
> +    if (ret < 0)
> +        return false;
> +
> +    guest_format = le16_to_cpu(vmci->vmcoreinfo.guest_format);
> +    if (guest_format != FW_CFG_VMCOREINFO_FORMAT_ELF)
> +        return false;
> +
> +    size = le32_to_cpu(vmci->vmcoreinfo.size);
> +    addr = le64_to_cpu(vmci->vmcoreinfo.paddr);
> +    note_head_size = dump_info.d_class == ELFCLASS64 ?
> +        sizeof(Elf64_Nhdr) : sizeof(Elf32_Nhdr);
> +
> +    guest_note = g_malloc(size + 1);
> +    cpu_physical_memory_read(addr, guest_note, size);
> +    if (dump_info.d_class == ELFCLASS64) {
> +        const Elf64_Nhdr *hdr = (void *)guest_note;
> +        if (dump_info.d_endian == ELFDATA2LSB) {
> +            name_size = cpu_to_le64(hdr->n_namesz);
> +            desc_size = cpu_to_le64(hdr->n_descsz);
> +        } else {
> +            name_size = cpu_to_be64(hdr->n_namesz);
> +            desc_size = cpu_to_be64(hdr->n_descsz);
> +        }
> +    } else {
> +        const Elf32_Nhdr *hdr = (void *)guest_note;
> +        if (dump_info.d_endian == ELFDATA2LSB) {
> +            name_size = cpu_to_le32(hdr->n_namesz);
> +            desc_size = cpu_to_le32(hdr->n_descsz);
> +        } else {
> +            name_size = cpu_to_be32(hdr->n_namesz);
> +            desc_size = cpu_to_be32(hdr->n_descsz);
> +        }
> +    }
> +
> +    guest_note_size = ELF_NOTE_SIZE(note_head_size, name_size, desc_size);
> +    if (guest_note_size != VMCOREINFO_WIN_DUMP_NOTE_SIZE64 &&
> +        guest_note_size != VMCOREINFO_WIN_DUMP_NOTE_SIZE32)
> +        return false;
> +
>       return true;
>   }
>   
please start from ./scripts/check-patch.pl

