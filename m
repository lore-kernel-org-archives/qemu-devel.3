Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF0ECE8347
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 14:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svHJI-0000Iv-JV; Mon, 30 Sep 2024 10:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1svHJE-0000Cn-0R; Mon, 30 Sep 2024 10:23:32 -0400
Received: from mail-vi1eur05on20705.outbound.protection.outlook.com
 ([2a01:111:f403:2613::705]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1svHJB-0007F8-GH; Mon, 30 Sep 2024 10:23:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUX+Dd9A+PBBNcwq6KA9dLtVuvLO33nmHfwVEI3Xn9PHLdhpvnTHIDbuAwjxWyovPraRHA83S7VSE3dgD3vVXg2r+3KCHIa42Xgcq6b/LA7uPooJ3aLDxnKw4A8d59V53wfgktjGccynt0PbiZHKx77+ecNRhHWEuV2NcdTLvISI8impnt3wnTdWt0D3QmyDe7STS4sR92/r8fegfFqdaE3/VCEs1OZKGK0K4/DKsWmPCIvkdjgN3sh6iGddHTO1HVQkBaE1kNtuUcBUA47eKb6by5w+xilwaeAJnQT4IsKRW3tsYgMfcxzJcaJX3ASagznynJYQn5hyfLUOfwdjaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QNpxfIgEClcvReL+HxxZSUdQ3WNItf0+IwP4LG2DQM=;
 b=hpuovLWl2Dt24RqRASnUz/Nxg8AUojXGYXerKl/+czSO8TspQuubKbEGrH+0GT0CJ3V92lAwKHeFblYLsR9U/SHKqyAnM+/mPxY+DFiDUHDFS0c0R+9jMTm5CS4elN3HGwNHc8APYG6p7Lf+tHNduEFWsBcYf7+U1J5acaZrAXwjAvMvvKIxrD37ol4z5TWJvcj2kyKoS1nNUtmlk0JaQ8E02O7sQTi9f9jo6Sf+zSLJHJ37AFnMH8jlvF93V6H8yBIiPi8xCHZ3DELteZy6Z8cDL2Fw0RxR0N8ARYfvLa6fNkhQRo99FFs4Nzz8CPHn8UA/hTpQQgSOjnfydmKiKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QNpxfIgEClcvReL+HxxZSUdQ3WNItf0+IwP4LG2DQM=;
 b=mOkZV2Awz3dnToypBjIP4QmIjAK3uMzdiqU+3pz6N4J/rZghbaKKgqifFQ9DbsRvA1DuTeVKZd+OrHGFOQ2AhgSzk0M8JDAjXtkWLHT3zMFDS1vmdY7YHCvLZEMK7hzQAOL7WmI7L4fV91a7D+bvcdloSUunpRRug2DROvB4MRZez8a+Kj6ogRlm5VW5zLQAQWAyVxqfqlguhFRCQGaUgDb4vcrzHogVq64pcCNV0OHG2V8oeYLKo41y2hFQDWQ4hVs8RQGjyhIZmTmqk7aVQhlvGsZVktj98+d4I49KSMj45Zwm4A4dqIv8+3NWpBh5mJ3k11xqi9fxA4WQCMRFfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS4PR08MB7453.eurprd08.prod.outlook.com
 (2603:10a6:20b:4e4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.14; Mon, 30 Sep
 2024 14:23:22 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%4]) with mapi id 15.20.8026.009; Mon, 30 Sep 2024
 14:23:22 +0000
Message-ID: <3b8d6cd6-95ff-4eff-8d67-2c4505c456c1@virtuozzo.com>
Date: Mon, 30 Sep 2024 17:24:31 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] qcow2: make subclusters discardable
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, stefanha@redhat.com, berto@igalia.com, den@virtuozzo.com
References: <20240913163942.423050-1-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20240913163942.423050-1-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::7) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS4PR08MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: da5db49d-8e67-44a3-7d63-08dce15b7034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azBQZGU5OWdub3BvaVdhckJGcGVhV2Y0RXI3RENJb0pYMmgwdlI3NFVYZ29i?=
 =?utf-8?B?SHNZUkJ1bUtkNHBZTk9sSnZGbmlxOVNyOWdJblpGRkxTRlk1KzhkYzBYNFgy?=
 =?utf-8?B?QUVhdHVXcU0rdGE0UTVMeFlmdWFvM3VuZGp4VjR5a3Z4aEMxWUE2bEJ2YURi?=
 =?utf-8?B?ZGg4WDBlWUwrTDdBcW1xUksvZzUrL0RzWDhWZ2VBbG9WZTJHYWIyK3dpY2pi?=
 =?utf-8?B?dXZ2SFdnYmJsbDBsaFZicHNuU1lOay83SWl2M3ZRNnROS1dLNU5ETzhKL2Rw?=
 =?utf-8?B?TUdaS3ZpNElqeUQ1RDUwd1dUSXBXT2V6QjFxMzc0VHdFdWhVclNGblViZUVx?=
 =?utf-8?B?WTdwcTdnaDZOblM4eUJrdlB6dHZGcDJBZFE4dU82Ylo3ZzFmVWlsYzFZKzNI?=
 =?utf-8?B?bGk0UnJQRWRoSmRTYmtpUUtNcUZ1L1ora1R1cTVyRmtIMCtCeVdPcGZVcEIy?=
 =?utf-8?B?RFhFZE80WGNteEFncnN1cHVlaGJ6K3ZRTis2TDE4dzRMYU1aNjBIR2o5UGcy?=
 =?utf-8?B?WW81b05qTXJyeERaLzdVclBOaFlNWnZJbU9halROR0RkaWxvYXlNZHE1V2pv?=
 =?utf-8?B?NS9TeVU0N3R5QkhEdzNvNmErM3JtcDZyWStLci9kQngvdlJFTGpkcjZBcUhD?=
 =?utf-8?B?NW5rNzlVVTZ6RnVlaU5FbnI2TUlFb3hhejltSkVOcGdFTU9IVkp3WFNhUTVv?=
 =?utf-8?B?N3U4bDA0d0xaTTd3T3YyYTBNSXNUN2hpVkpvVUwzSDdHTWc1cFhyalVzVENS?=
 =?utf-8?B?ckk1VEZvYkJtcW5hLzlST0hCZDN2NEVVTlNCSElsZEZ3c0U2dFYrYktsU2FC?=
 =?utf-8?B?VjhFQU4zNWhQaDJkdVlOTktoVVR0dmx0ZTZNanZPQVdJTUFCVHJaS0lzZ0Ns?=
 =?utf-8?B?aE54RnB6MWZMem1pb3UzaW9Da2g0WGVNVklOVWJNV3gzWkZsbzkvcUtjZWxu?=
 =?utf-8?B?Znk2NVl0TkI0bno1eEd2SFc4Nkk4MXlNZ1BWWmhmQm1uUTkrYU5selZ4ckNE?=
 =?utf-8?B?WnYxNGFia2ZtWUVKWm90UXhLbUIwM1MvbzlrU1BqTWZHZDlTcTQzSDNKVjdQ?=
 =?utf-8?B?YlVBMERKK0dubCtJTTA4UVFkWWdrQTZ3aER3VjNRMEZNenJVdmF0aEJTWE40?=
 =?utf-8?B?Zyt0L0NZQVpuQ0dPZml0OEVZVE1uZldlQk53L3NIU1kyTUlFTkV0am9oNFR5?=
 =?utf-8?B?OFZJekw3bHRWa1Bocy84UmxqQVd3Mlh4RVN1UjVNVUhSc2F6VDIrVXFDeHVS?=
 =?utf-8?B?WGNSTGtwWnoyenE2NUg0eFF6eDdwWWRTSDYvN25hU2NmL0M0Y1BqTWRidEky?=
 =?utf-8?B?MHhHaGpxM2J3U09BYlpnZG5mQUtnbWkveUxOaCsvREdZNGU1bEZpSWkzUk9h?=
 =?utf-8?B?TkE5L3VtWDFpcys1aUR3ZXR2WnVmcVhpUUtialptenVHcHcrR1JGR2ZWRS9r?=
 =?utf-8?B?ZG5rS0ZTN3FPWFBvL1I2Um1QK1pvNW1GbDd0UGo2bE9sTUN1cDExeUFnOWYw?=
 =?utf-8?B?dWU0bTh2bjBvSDl4alhqUXNGc2hwU2Q1QS9XWno5OFJaNEdvZENVbmdhQnRo?=
 =?utf-8?B?S1BQOGVSeEZtdm44OVBkUGdKWGR2NUxqMWhWTWxGZHhtcHFVbGo1eUpGRWFq?=
 =?utf-8?B?M3JLNkZxbERLbDR3YlVIUjJVM241MkxZSXlyVUErSU9ZY3N3NkxIdm9NWTdR?=
 =?utf-8?B?N0tMVXlGSkt1TkVFeDNPN2ZmRHFIQXJ4TlV4c01HVElySnJYQllYeWptbmg5?=
 =?utf-8?B?eGQ4UjZoMnJveU02ZHhuMlZ6cjZsbHVSRmZtQ3FUQnVtd3NhY3I0YkpCU2Rk?=
 =?utf-8?Q?H4I9IyGY7fqApFntKbPVwA3J+l5+utqwcrMqY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDd0eFUvMTlGZTV3alF3SWhGVjVFUFhsK0RidEFtWlNWNGsxT3ZINDFIYkRU?=
 =?utf-8?B?RExibXlPMUpCNUw0eDdsaCt1dXFIdUJYYmVjemZEN3NhV1lGdDlkRldhRk5u?=
 =?utf-8?B?dTQ4OW9HTWZ3RDc3V05pS2VsdHVrYVJLN1hYS3R4QUJ0aFJsSlVBQUZtb3Yr?=
 =?utf-8?B?MytQaWhwaUhxOVB0eUZ0OGhlUi9seVgzOWh0M0dlTFdTdFgrcFlvemE4RDEz?=
 =?utf-8?B?cG1HaEc4Rkh3M2JJNVRvNCtlYUtBUXJKQWdjYktXYkx2emNQU3lyUEZQaTRZ?=
 =?utf-8?B?Sk90Q01DTTE2ejNzWm12V3c5SzJZMEhoWHE5STdTZ2draDUrOWZHSElxQzJZ?=
 =?utf-8?B?RFBQdG8wM1FyeW0wYWN5S09UbUdSUVBRdEJneWR1QmVWZTc3c0N0QmFzOVFX?=
 =?utf-8?B?cFhjU3lYQmxoWmUwanZlTzRSMVpEM0htNlhZYkRmWCtEaW5kbGU5bFZNZlVs?=
 =?utf-8?B?eGJ3eWF5dFpvN00zTnZSQUxoY3Bnai9Iek5pa3dBMDRMak8vQ1ZsbThTVU1D?=
 =?utf-8?B?eFhZZWxaYVBoVklCSndGM0R0aUV3VklSVXFQSnNqTkVEV2Y2TTZtaGY4SDNT?=
 =?utf-8?B?U3I2VzJjczRtYUxRL0tHNjhiNE5wWmhKTkd1NHRuV2xpUm9KcE40M2lwN3Z0?=
 =?utf-8?B?cEYyYWlhVjY1cUpoWXFIZWpuQjlVOXVQNFRIQUo1VjBNdmZXd0pqdGMrOEdr?=
 =?utf-8?B?NEI4cTl0T1ZOYzZEUUdidDA0cDdmczV6MHJtdkwzOG5pazdiMkhNSWJMVVdt?=
 =?utf-8?B?TCt0SDRvNHQyc0FOU0Jab3NONjBQNlZmNTF2NFhOSzZkcGN0eFlCY0NXakpj?=
 =?utf-8?B?ZjlEWC9BYVBzVGt2ZERvOWVHODVIOVViMWpxYzBscmdxdUR2a3M0MjNhQjdQ?=
 =?utf-8?B?RHJXSXRxQlMxeVo5QXhJRytzNDVMTnA4Qnc3S2ZvY2xlRkFheGovL0Q0R3BV?=
 =?utf-8?B?SzRkMUFVY0lZLyttbTRCWTI3Q0Q0YjlDR2Vza3VrWnVWV3dqazZSVGppU1hS?=
 =?utf-8?B?SWFlZXYyUW0zNktmb0FyQTd2c0laVjFwaTBpYjNidVBDbWRrazMreG9DWDBB?=
 =?utf-8?B?ME1KVlByMWVEbEtJN1l1R1h6UzRZTCtJZ1Y5bERITlJweUFsSkM4U1gvaG1p?=
 =?utf-8?B?STFjbmcwTVdRRUJaMk1XUy9MQnBOY2FUd0NiT0t6YWN1TUpITVpjWjVQOGh1?=
 =?utf-8?B?VGpxNEF6ZjNtUjMyTUxVQWhhVTNUNlJRUndLcXFaQTBWeXJuMVhBRVMreFNL?=
 =?utf-8?B?eEdLR3k2RGNIVlYxZkhIUkhhc0l1bktsM3dyYWN3Nk9vK0w3RlNuTHp4bmZh?=
 =?utf-8?B?eUFrdmJ5MEQrVTR1SE1pVGp6cUJpQVVrcHJ2OGlyTXRYemZCV3Uzd3lmSVZr?=
 =?utf-8?B?b2lSSDNZR3B4L1IyeHhRbG9xVlh0NXhaZVp2N0xZVTEvM3kyYmI1QjJ2ZEYv?=
 =?utf-8?B?Qk4zMFVDQjF6OFF6QjlkMzV6OW13bExZeTNEYVJNMVA3eEdhRHdyMlVTVlR4?=
 =?utf-8?B?VEtCQzFheGpmSTZDTGZrYmlERFRJVUVUUTROUGNNV1VLUEdxMktPeC9qVjRZ?=
 =?utf-8?B?RXB0UnM5QWpXcmc2ZGpTR0I4NCtiVW5PTEJrcFlhRzkyclJ0ZlQyZzZDcWlm?=
 =?utf-8?B?aVJCZFQrb2hudnFKUG96d09WWWpvOFBOMHBUelJwdUJiUi9UeERoZkpMbWE0?=
 =?utf-8?B?a2lIWnNpR3ZHT1lqdFp0bkRJdFpRS2FhY0J5b2FsTWc0ZU9iQ08rU3B6czJj?=
 =?utf-8?B?S2pCdmhGbm5STXpTajRURHBQcjhueklYdjMvTGFaNDVWb3pmRFp3bHFBYm5Q?=
 =?utf-8?B?NitWbERRVkVFd1llRUhZbjAxR3N6Qy9oSnYvdDBWVllHbFpDWDlsUFUvNFM1?=
 =?utf-8?B?Qkltb3ViMmxENS9zVGlsblRSbmFJblVLb3RIeEF3eWovT0E1WlZNSWNWS1FJ?=
 =?utf-8?B?VG5UcVY2THova0tBZ3N5RG0zNmg1OG1OTmdOczl1N2ZBTVlTdmx0TGlFbjhk?=
 =?utf-8?B?Tzg5QlhyazMvbGtjOHo0aVA2SlpyQk5RUUlWUW5iRUxidEwxNGhROHhxMXlD?=
 =?utf-8?B?K1F3ZUp4WHVyZDFLbU5GMVpsWFRBZjMvOHBoc1pKdUdHaC95ZVR5SkxRQVlG?=
 =?utf-8?B?L1d1bWZYVVZKSGRMRFl3dVEvNnY4SU1sRGduQ2FrdXQwWWdOL0RDcjRTT0k2?=
 =?utf-8?B?L2c9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5db49d-8e67-44a3-7d63-08dce15b7034
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 14:23:22.1893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78yqqoVan/mYe0JfiZgCxhjtW96dnHEXFIs4zGJB5Xn+7Z9Hue4OqfHsLf15m0YkvN1+ifiNMdNIIZhNlGY/HH5zs4y83a7XCujuAeqxgsY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7453
Received-SPF: pass client-ip=2a01:111:f403:2613::705;
 envelope-from=andrey.drobyshev@virtuozzo.com;
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

On 9/13/24 7:39 PM, Andrey Drobyshev wrote:
> v2: https://lists.nongnu.org/archive/html/qemu-devel/2024-05/msg02396.html
> 
> v2 -> v3:
>   * Added patch 12/12 "qcow2: add discard-subclusters option" which
>     makes subcluster-based discards optional;
>   * Added a bunch of R-b's.
> 
> Andrey Drobyshev (12):
>   qcow2: make function update_refcount_discard() global
>   qcow2: simplify L2 entries accounting for discard-no-unref
>   qcow2: put discard requests in the common queue when discard-no-unref
>     enabled
>   block/file-posix: add trace event for fallocate() calls
>   iotests/common.rc: add disk_usage function
>   iotests/290: add test case to check 'discard-no-unref' option behavior
>   qcow2: add get_sc_range_info() helper for working with subcluster
>     ranges
>   qcow2: zeroize the entire cluster when there're no non-zero
>     subclusters
>   qcow2: make subclusters discardable
>   qcow2: zero_l2_subclusters: fall through to discard operation when
>     requested
>   iotests/271: add test cases for subcluster-based discard/unmap
>   qcow2: add discard-subclusters option
> 
>  block/file-posix.c           |   1 +
>  block/qcow2-cluster.c        | 346 ++++++++++++++++++++++++++++-------
>  block/qcow2-refcount.c       |   8 +-
>  block/qcow2-snapshot.c       |   6 +-
>  block/qcow2.c                |  44 +++--
>  block/qcow2.h                |   8 +-
>  block/trace-events           |   1 +
>  tests/qemu-iotests/250       |   5 -
>  tests/qemu-iotests/271       |  74 ++++++--
>  tests/qemu-iotests/271.out   |  69 ++++++-
>  tests/qemu-iotests/290       |  34 ++++
>  tests/qemu-iotests/290.out   |  28 +++
>  tests/qemu-iotests/common.rc |   6 +
>  13 files changed, 513 insertions(+), 117 deletions(-)
> 

Friendly ping

