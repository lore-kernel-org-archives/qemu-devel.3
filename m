Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84F0CEACC9
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 20:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vK0Pr-0004JM-2a; Fri, 14 Nov 2025 15:29:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vK0PH-0003lA-5k; Fri, 14 Nov 2025 15:28:31 -0500
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vK0PE-0004St-Nl; Fri, 14 Nov 2025 15:28:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WwuvA9X4HX35cyjWdeuw31Pkh+rMzTiYh5Pae1zBwjdv3P0RXeJsG+wzDo3O883k0Yy4O/SA/ZEy9slOPyw6Z+E/mYHjPbbgulRbZNzq1I+0IhRIjBC078s2+p7I0m5F//5QwzYvBmd3AM6DzCONBgMnICqFEDg6YYEGsCJe0dIoUzgXIwwqIl81YhHn4aj7DtEkRZvY8Ar0ay7iTvZdwHIPBe3EHPdFO1hwTy3T0nxG+bTghG2kjQZFI1Sc60g+BWUx/NOHGEB183mBB0WGYnDD6AMh4d8+5zX2n2dNKg/9jdetZHMJP9L6YI/9jsDuxSrHPapH65Lx1qnQya8B3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBDuOV7Y1dic5W4tsXM8p4a8/aCP6tUomaeh5Or9BdY=;
 b=EoQFYYG0DK2QyLfimxp001wog/+WEPA+x7AX9BFrVtDFW/EBUvdVX0lAQJM1FxlV+bSPlaGxYPpWYARJdQVsQDHS6+/FqVKs/3Ig5POHZS+dusIh6mnxyl7tL04Oi0O2sAiM6GiRUvoHHJJmdnPTtlhdAbdi4fkKglrFU+JzFACHsYUkC7lM7ZuftjIO+F1Q2YvX8f0a9k/DaFGY/S5Z9rX8hVaFtDVJyfhy7ZeUkJVmZsdzX/k+Pme4wD+8z3CMz+HJsWXCH/mb30MhlO0Lg4IMVE+aCd9+rdJIieeXoLEpd8LlL4O1PjzOh88sWxiZPG6g3SdgBI93j1zPtBGZkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBDuOV7Y1dic5W4tsXM8p4a8/aCP6tUomaeh5Or9BdY=;
 b=JMp4+7/DoZE5rvbyr04GZj2NwgtTdHoyFQiWPJz7MZSASQEWLXtR2QPhiByN+r6gdLk+LAQcRuPGN3sF8/ibI7PdnfuGBlRNO2fAzMB3049bvoCGyK67KBIAefCrxHa1k2+UkLdWsV46EV6zT36GoiOf+LMMfiy8ZDJ5lCgoVQ8LENUROoTmbRmbTJUC6Oti8IwNKCZFlSqyJSIEdIbNFduEcG0W/F7tDtkcMxLfxbNyKbHLw0bb15/t8+5tOG39aqr7HnARA7Kazj4C2nun13C1uztvnYpL/QtLT3q58FdLy2v4rqaAx87ExH2pHbF1nKMwYaF7KcK8vSGk+g+xBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3598.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:139::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 20:27:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 20:27:46 +0000
Message-ID: <b083940f-8d50-4aab-a4ac-a88d1988fd07@siemens.com>
Date: Fri, 14 Nov 2025 21:27:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/sdcard: fix potential out-of-bounds read in
 rpmb_calc_hmac
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, zhaoguohan_salmon@163.com
Cc: bmeng.cn@gmail.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 GuoHan Zhao <zhaoguohan@kylinos.cn>
References: <20251106072818.25075-1-zhaoguohan_salmon@163.com>
 <CAFEAcA8iWqAgZzH7u3jYTEb-fjjsBWAp3WJY24xAKN8CpdVw9Q@mail.gmail.com>
 <b4d9cac0-8f72-47c2-8357-021c6d6efbc4@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <b4d9cac0-8f72-47c2-8357-021c6d6efbc4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0432.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3598:EE_
X-MS-Office365-Filtering-Correlation-Id: 18555eed-73be-4568-7f2c-08de23bc45db
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEhybTB6NTJBMGRML0NvcU5YU1cyaTg3V0NoZWRLZEgrdThHUFRIY012b0R3?=
 =?utf-8?B?T0VjTGl0ZUJIUkFiSFFuUk1uL2N4bjB5Z29xdkhhWkdra3Y2WHQrRXBmNFEr?=
 =?utf-8?B?TGpwMnJnN2FScmZDaVBtNGFpR0lmZHUxdzZ4Z2dlUk52NVdnYjJmdHBYM1hw?=
 =?utf-8?B?M3VXUEVyMzlEZjdGajd1YUplS2puMlVaeXpac3BNc21OUTJ2UVpUTEVtNlov?=
 =?utf-8?B?NGYrQm9Ba0kzRjlwTW1lVCtYeGlEU2xUT05CelFPRWY5UWdXbFZMOExzNDR5?=
 =?utf-8?B?WXpyYWEwNktReVJQVHd6cmdvY3k3ZzBPT1IxSERNNzBjbVFkNW8yNmhORXp1?=
 =?utf-8?B?ZlpDMHNLdGdBcWdMcittSGNsU2tLbnpSTFMyZ2ovWnUrTzJLVGhjUnFDcXFz?=
 =?utf-8?B?WW5BUkdiZXJ2VFltM21wb096VlZZNkJpTktlS2RyRGFBYUdhbGhnbUxSRUhz?=
 =?utf-8?B?NHVGRmRJSmcvMUt1RXFVT3pBUjFVdGtnSmRHOUcvODgrMjh3cVgxNDQrY3E4?=
 =?utf-8?B?c1hNWUlvN29tZ2IvNGpLT0tNcmhUQUlwNTNGZVdmREs1bTQ1VjNKaStiMEJV?=
 =?utf-8?B?ZS83Skl1VGdiR0d0cEo1UmhpcktoUnJ2NmJ5bEdwc2Q3SjVpZUtqeXNKMThV?=
 =?utf-8?B?K2tsbjBabnE1VzlFdmk0YkQ1N2h6aFljR09sRXJKNk5IK0VlRjJnMUZ0eU8z?=
 =?utf-8?B?MkFBbmsxWUpXU3VKNEFwc2o1L0R5OTBzT1lQdjZuSEFwM1hBUjJHRW5xVFVZ?=
 =?utf-8?B?V0RBZHFtb1BRQjdRYlEvV1RhQ0daMGdpM21ScWFqNCszQWd4NTVNRThrZWMv?=
 =?utf-8?B?NmN0K3FvMjVJZ0tTYStlWUhIUVVwOTlwRzB5c0x6L0doTTI4VWUyY0lYSTZH?=
 =?utf-8?B?VDRDYS9uaGZBZjI1bzZnOTFnSG5uc3QzbnQ4SmRLMEpNVk5LYTZCdkRtVGxv?=
 =?utf-8?B?RDBBSFNKMndtRkhwRUE5NDdwT21DZWpva1VnOG11ZWZUVkY5YjY3S2RuOWZ0?=
 =?utf-8?B?Vk5JTkUzL3U5b0JQVHJuc2lhUHNCRE9qVVpJeWRMK0ZVL0FBbHE2cUxoV2J2?=
 =?utf-8?B?a2FIYWJRSFhNaE1uS0RqNUxYRlVDbVVMTXZuNWowaHkwRkVod3FpckVhRzRX?=
 =?utf-8?B?VmJMaUVTeG11T3hXK25rakt6cUtacXdRWFF4eWhRVklvcjI4MmFQaVFIU2tr?=
 =?utf-8?B?a2pESS91MnNxNFFEelQwVU9EbWtRdFpkMTMzMnltS0V4NEhONFI0d3hCR1dN?=
 =?utf-8?B?Z0MvS2xlUEg0QUV1RTFrZ3VqSkF4b3V1R3JxSUFBcnpuRzBPOE0wK0puMjRG?=
 =?utf-8?B?S2R3dUNhaE10bU5PelJZZDNrcDFNcmdPTngveEJWQzY4Slo0S0xCV1ZuTDJw?=
 =?utf-8?B?ZEs4ZFJKdVI3M1g2WVR0UnBwbi9mMzZHQ1Y3dHJyVHRJOTYrL0FLcW1QZTJT?=
 =?utf-8?B?cUc3ZGU3dmthY2U2SDhCYWtlaEE0alVxaW44WWtEMzFKU0VjTnBrQ2pjZ3J1?=
 =?utf-8?B?ejZwVCtvTTdvc3YvVDI0T1AreitDSm9zRlYrdGM3T25iY2VoVTR3V1pHd3NS?=
 =?utf-8?B?aDJ2UzE3MVF1a0VpMzVpRDdxeWNRSmV6aHBNbXJoWWp6L29jbUhxQmtmT3Rz?=
 =?utf-8?B?VDZZTm5Udzl6TDJUNVRkU0R5S2N0OWxxYWdaU3daYmoxTmVwZi9HZ3hEdmNz?=
 =?utf-8?B?cGxXNzBzSkFjclhTWGpwUWptM1A0aDlyd0lrVDFiUXA3RjdqWTNUcnNqMnN6?=
 =?utf-8?B?QVJzdzk4QmRIbWJkeHFDNTFOTkh4OU1rYmxTVUpoZUJlMURBeUgzcTBsc0kr?=
 =?utf-8?B?aG5qZW5hVUhlZ0pZRE9sdStSMGF4QWFlOEd4cy9tK3M0RVlMeTVWb2hrMHpH?=
 =?utf-8?B?bU5haXB4YllHdkFXVU1iR1RidjNmWUxPVWovb1MzclZZVHNKb1BIV2x3QnBV?=
 =?utf-8?Q?dSq1JhvwMOuGQysX2hLfoog9PtukMmQH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTVIYko2NHRrTHdtSmJWemExdmN4aFAyWVJLSExxOEltTU5FMkV0VWp1RHBt?=
 =?utf-8?B?WWg3aEtNYTR6Yk52UnZYejdxRjE3dFJGcU5WOW91SWZkLzh2MXB1dUZsT3Fa?=
 =?utf-8?B?c1g4TGhFbWpNd1EzR3dRUFloOHRnenhMcDBvNllUcERLaGxTUUltVXVRWkhH?=
 =?utf-8?B?VkcyZHhSbmJpQkNyM3FrY1ZuaWJjNEUvaGg0M3FXWmsrNGxROUI4bEF5TnFK?=
 =?utf-8?B?Q2tCK0MyTlB4VExUSHhCd3d4S0l2cE13SkdxTnNMZmVBM3h3dk80ZmpsNDE2?=
 =?utf-8?B?WkZDQlVFUnRGalJDSkRqTjRQQ0hHUVZ2WWNKU3lXWlordkxGQTBpbURZcjht?=
 =?utf-8?B?cFVyWEFEdWRRWmVLUk9TeHFYdC91bmVJbmpCUnptSEpCYkFVSXNqVGJDZ0Mw?=
 =?utf-8?B?L0J1VHVRUi9SSXJkRENsQjE4eU00UjBIN2pjcTdPZTU5emdwL25zZ1J4bkdK?=
 =?utf-8?B?d0RTa09VSEVGQUszaTFaVGRGTkNqajFqVFl5UnZIbDVmd25BRmVqL3NoYWpG?=
 =?utf-8?B?ZDE4djQwZitxY0U4T0t3Y1R5R1pSYTlKMlg4U05zTVc4Q0hNQ1JYcWJlZGl6?=
 =?utf-8?B?WXdVM1ZqVm94elh0dnA2MFd0ZUhLN2twdVlLNkhBVTVBbWUxTHI3aUExMW9Z?=
 =?utf-8?B?MDZEK0hqU3JpRklMNXFpY0dseDZnVzRMa2tkTW5GZGozQmUxMnhsZGFrY0tp?=
 =?utf-8?B?bTU3eDUyMDNpN2tRZ2ZuY3hOVUVRLy9QeDBBSHZFcnVWMzdZY0dBaytGMTg2?=
 =?utf-8?B?KzF4S0IyNGNpR1RGdXZHMXlHTmRPT1FvdUZoRzgwYmNpeVB3NDkzci8wOUFG?=
 =?utf-8?B?bkJWYUpXT2l5RHhUYW15UWZaUVNPMzlESkg1eHlUaml3R2dOVmdYZXBlWjFO?=
 =?utf-8?B?aUNhTkM1a3BRRnV2UW9xcDlRL1hBQ0lESlVYaGNFUnpaKzZPcnhNOTNDR0ZW?=
 =?utf-8?B?VTIwUnZvcE5hdW9FSjV0RnMrM1ptaWJ0Y2o3ZGxqM3VuUWF5YjFqMmdGeVMr?=
 =?utf-8?B?Vk94NXpUTW1zNEluSEJZanR6dEtYZ2xGcWhkT2x2a1kzb05OcVVSQ1BrMVhZ?=
 =?utf-8?B?ZUQ0dEh6dHpYNU02ZWdHYmVwbE16WjVMZ3IySDBMbU9aTjJmVjNEVFRXZWhY?=
 =?utf-8?B?TTlMRGxzQTVacGhNUVh6ZE1SVUVmYUVoRHpYeDAxUE0zNnBIU0czR0NPTkh6?=
 =?utf-8?B?UEg2alpTUVFrTXVidnNmdmRBWnI2YmFPUU5ydDFqWjRIaVNIUnRtSmJPTzJP?=
 =?utf-8?B?UHhER2k3QU1XMmtRRmVGQzJNWU5mTFdPNFQ4d1I5REVIMVZtTmZQOFRKanFQ?=
 =?utf-8?B?T0JNNlhnSDB6RXorQ0hYeGdvL1czOFpkNlZLQUJvaGRQeFNhek5XK1o5cTFY?=
 =?utf-8?B?VndoZVdUOGVZZzZXT09PRTFVZEpmRXZHVy9reG9uYXFXSkRobmdYR2tPUXQ5?=
 =?utf-8?B?eC9yTmRWOTZtSG1MUzhVMWlXeWVwYVJJSVBEaHpxTlhkU3ZkelRvcEdrbVU2?=
 =?utf-8?B?ZTM1WU1HVi81aU81WUdIdUVsMmw4eE4zVlBET1ZaMEN5dWlnLzhCUzRSRFcx?=
 =?utf-8?B?eVdkOVpjdTFUQjNCZVhrSGNuTGludUd4SU5DWG9uejUva09rZGxpZE9IWU01?=
 =?utf-8?B?aTZXVWZwYlhLaW1najdkYmJvL2ZFaEI1bkRpb0pKQ3E2S2xabGlNbmlmYXM0?=
 =?utf-8?B?dEYzNWxXUXk0bHI0ZmhsWlhjblhjMVRDcnB1ZDNnZ1A5K29jenN3ZEJzaEFq?=
 =?utf-8?B?WFVZcitzSTBNeEpzcllHallLdHhSZFNOLzB0WG9ndGtMR2poQk9oZ3pCN2xE?=
 =?utf-8?B?MUMrYjhDYm5jd3crMnhBOVJFbjFSaUwwQStoVkZHSTcxanVrclo4MFdkVlBj?=
 =?utf-8?B?dzRHUUlndUw1RXFmeGFqYm5lU0JYWkNPNUZCdEN3QjNLL1F0UE5DeXN4TWhJ?=
 =?utf-8?B?QTdJMm1BUjBMV2p4VmtYN0lJUURubUxsRXVkejdzMzZEZnBnNDJhYUhvK2R6?=
 =?utf-8?B?NFVTTVdpQUlCSFlwaXVJdXhjK2Zld3NjV2Q4Vys3Z2pnT3VpMWlWT2ZVRExZ?=
 =?utf-8?B?andqYXl3YUU4eUVUem5JQkRNOTB4WEJTQ3QrLzBlVUx1OTdSdEdjWDE2cWUr?=
 =?utf-8?B?N2NVZVFtc01BM2c2MGJOSFdNNy9mU04yNTRoTzVVV2RSVGRRS1lqU0Z1cCtu?=
 =?utf-8?B?cXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18555eed-73be-4568-7f2c-08de23bc45db
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 20:27:46.7011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gvmjj+UCpBxzXpv7YTIZV3Wbxpc3TVSkKv/KceLMNCIAR1dcTYeR8ewPo3a05YZh3Njlh5XC+Le+hjcsWnrhtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3598
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=jan.kiszka@siemens.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On 14.11.25 21:26, Philippe Mathieu-Daudé wrote:
> Hi Zhao, Peter,
> 
> On 14/11/25 14:39, Peter Maydell wrote:
>> On Thu, 6 Nov 2025 at 07:29, <zhaoguohan_salmon@163.com> wrote:
>>>
>>> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
>>>
>>> Coverity reported a potential out-of-bounds read in rpmb_calc_hmac():
>>>
>>> CID 1642869: Out-of-bounds read (OVERRUN)
>>> Overrunning array of 256 bytes at byte offset 256 by dereferencing
>>> pointer &frame->data[256].
>>>
>>> The issue arises from using &frame->data[RPMB_DATA_LEN] as the source
>>> pointer for memcpy(). Although computing a one-past-the-end pointer is
>>> legal, dereferencing it (as memcpy() does) is undefined behavior in C.
>>>
>>> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
>>> ---
>>>   hw/sd/sd.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>> index 9c86c016cc9d..bc2e9863a534 100644
>>> --- a/hw/sd/sd.c
>>> +++ b/hw/sd/sd.c
>>> @@ -1161,7 +1161,8 @@ static bool rpmb_calc_hmac(SDState *sd, const
>>> RPMBDataFrame *frame,
>>>
>>>           assert(RPMB_HASH_LEN <= sizeof(sd->data));
>>>
>>> -        memcpy((uint8_t *)buf + RPMB_DATA_LEN, &frame-
>>> >data[RPMB_DATA_LEN],
>>> +        memcpy((uint8_t *)buf + RPMB_DATA_LEN,
>>> +               (const uint8_t *)frame + RPMB_DATA_LEN,
>>>                  RPMB_HASH_LEN - RPMB_DATA_LEN);
>>>           offset = lduw_be_p(&frame->address) * RPMB_DATA_LEN +
>>> sd_part_offset(sd);
>>>           do {
>>
>> What is this code even trying to do ? We define a RPMBDataFrame
>> which is a packed struct, but now we're randomly memcpying
>> a lump of data out of the middle of it ??
>>
>> The start of the struct is
>>      uint8_t stuff_bytes[RPMB_STUFF_LEN];  // offset 0
>>      uint8_t key_mac[RPMB_KEY_MAC_LEN];    // offset 196
>>      uint8_t data[RPMB_DATA_LEN];          // offset 228
>>      uint8_t nonce[RPMB_NONCE_LEN];        // offset 484
>>
>> so frame + RPMB_DATA_LEN (256) starts 28 bytes into the data
>> array; and then we're copying 28 bytes of data?
>>
>> The existing code (frame->data[RPMB_DATA_LEN]) doesn't make
>> sense either, as that's a weird way to write frame->nonce,
>> and the RPMB_NONCE_LEN doesn't have the same length as what
>> we're copying either.
> 
> Indeed.
> 
>> Can somebody who understands this explain what this code
>> is intended to be doing ?
> 
> We hash the frame data[] + nonce[], and work on the card block buffer
> ('buf'), filling it before hashing.
> 
> This change should clarify:
> 
> -- >8 --
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 9c86c016cc9..e60311e49a6 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -125 +125,2 @@ typedef struct SDProto {
> -#define RPMB_HASH_LEN       284
> +
> +#define RPMB_HASH_LEN       (RPMB_DATA_LEN + RPMB_NONCE_LEN)
> @@ -1164,2 +1165 @@ static bool rpmb_calc_hmac(SDState *sd, const
> RPMBDataFrame *frame,
> -        memcpy((uint8_t *)buf + RPMB_DATA_LEN, &frame-
>>data[RPMB_DATA_LEN],
> -               RPMB_HASH_LEN - RPMB_DATA_LEN);
> +        memcpy((uint8_t *)buf + RPMB_DATA_LEN, frame->nonce,
> RPMB_NONCE_LEN);

Also broken.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

