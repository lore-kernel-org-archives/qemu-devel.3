Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2A9CAC594
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Sep 2025 12:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxlme-0002U3-Iu; Sun, 14 Sep 2025 08:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1uxlmS-0002TQ-II; Sun, 14 Sep 2025 08:24:32 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1uxlmH-0007KW-HI; Sun, 14 Sep 2025 08:24:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQx9E4DIxxRLxdNIGJ6mrfb90UlVMAxv4Zwnb3rqY5a8EYsZDQJRF+u7g7+OP+F9UkJB4UrYPus9OrzoAW9EXeYZ6uFwljCGQgRZhsmHlqcQm85d4rjlGNW/P1MfglmNBMFiTfplthRlIH1y0jPUObSZsvS624ITariIJr6XR0NRYPfPGDVX1di0Mg7gGqj9KoFyc/TckMQTpIuWYfDv6qDW/AkIZE1wRU9DSdZSeIqJO+42jB5kWT7rnN93214UZyWGNbqTavpjKKMYJ5yw1R/jTHjwtcT19DVZhXmPCVAOahAePhvVdENKMgMdkLAklh6U46/GaYcSrHDYb7H8mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StqUYs2dkK1gXuOzwZLryiZJnlGMtqe/s/g9fNVFhXQ=;
 b=kpSQFt7GoRlF3xvK6q6tTtN26+FUq8VxlUV2WsNpa8Z0Pu0i6ju0FnrCaq0IFyXcVJW/VR5kCafprWXLC3oWoepnXSMYc8z99TJ4PzPYXdMngDoMz58yjgv8d0XkUJBroAJ3N5XC+aXACUv6mCO9LaOR8+kxZQMY34/JbznUG2wnxHeHw//dRojJ7SZbAezOV1jHZa6Q0Gehttsf9DOFmmK2q6xzUWoWVD/dWssaIA0j9UCZ9vos6eNnF05qG8zOQWla3sSyaSQ8oGVSUUdEDU4iSU19YIWmMWPi7j/2mE7gFXT9kgAFNB1EL5rE462k0qYTQIYgw+8zHmo6rZBfig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StqUYs2dkK1gXuOzwZLryiZJnlGMtqe/s/g9fNVFhXQ=;
 b=afOo0BEBcFLbxmMAWkO3xBUlXBBp6UFOhb8wKZJVKuSBdQSgoUFW38W9l0J938pdu+bfitxZ7VUfJvIVOwQfBzNuYcY3Sm0ecn3YwGuilC6VlF/ePDeplRlW75Uf5f5YccCoy1v5yHa0NFTALRAjFuRTmJql/ElclBnxRMxeUmlmEzH3T4Ntb97Knkh+UTLxrVuq/i0YY62t+TTm/x7R9EhcMHekM6AxGKZmbdyaczA9zMVafxlwftJXrXZ9COcniUC54xqeSoZm5IRyOI4scpIYPowrL2WkrKT5XKk2h36XwP9oTchHAA8W1OxBzVlAHrWJuW+pdyV2P/hVmMQedw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DU4PR10MB8780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Sun, 14 Sep
 2025 12:23:55 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.9094.021; Sun, 14 Sep 2025
 12:23:55 +0000
Message-ID: <d1cdafb7-e249-46ea-b29e-cc8f0ce6b9ef@siemens.com>
Date: Sun, 14 Sep 2025 14:23:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] docs: Add eMMC device model description
To: =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <cover.1757422256.git.jan.kiszka@siemens.com>
 <2a8d6226903d8dcf9615b5ac5a40522b6bf2f7c3.1757422256.git.jan.kiszka@siemens.com>
 <4d7760a559948fe8b16517fd4a17abde0606bae5.camel@pengutronix.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <4d7760a559948fe8b16517fd4a17abde0606bae5.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::10) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DU4PR10MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: 27f4c5aa-ae83-4233-05bb-08ddf3899236
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z01NeVo4eVF5UGRrcWJpcnE5ckpWbmd2SFRrVytDUUFhWDc1cGxZc0tMYk1K?=
 =?utf-8?B?MXUyR2lZeHlPZjJjWlluYVRsMC9mOWdPZ1NRRkNwRUhsTk1iMW0rUHdyeWxG?=
 =?utf-8?B?TkpTVVE1M3dCeEZtNzJ5YWFHUDNIdmhkN3hSVFJ3bXRybkJodFM4Q2Q3RjBS?=
 =?utf-8?B?VmZCSTlXLzVsL25BcG4rOWhlWFE3VHNSOVB6eittWlAzRTZxMncxM2ZPZTBW?=
 =?utf-8?B?K3BMYWppWmJlV29VMDI4QS8wbllMM1Q2OTZpVDZHd1R1dnhRU2FlRERvODJT?=
 =?utf-8?B?ajhjbWVHVCtFT3JaK2dkV3JJWDdlMmpxdzB5TTliRTVTSlJITGd2RVVsczR5?=
 =?utf-8?B?QVFxYTQ2cERvdkFZa2t6WVZyNDhqc01kSWtqSEJGNEhPVUtLY3VEbWxqREpo?=
 =?utf-8?B?VWFzcldmZ2sxY2FUQjEzSXVYMU5rdzRMMTN4bnN3MUpsNkNsUVlpa0o0OG9X?=
 =?utf-8?B?b09JUzIxcEtHbm4xQTBkN3BDYmtHcjcvTDJzR2MwSHRxckYyRDM4Z21BSWVK?=
 =?utf-8?B?OG5EZGVWWFFRYytZR08yNktYVWQ0ay85OEZtTDJMbE92SXphQW5GenEzYmJt?=
 =?utf-8?B?a1JNeHhmUGtNdG02bUtkNEVMYkM5dXk1WmQ1ZVMwQUhxZ0xZeTRhaG56NUpu?=
 =?utf-8?B?NmE2cFNNWStQYXZPeGoxMmFRTjAxL0VhNU9DQTU3TlVwYzVJV3RraHJ3UzJE?=
 =?utf-8?B?RUtrVmxVWEJmNkdhdkp6bUgyRnkzQi9mSllQVWFSNXF1UXVCRkdlTnhjOTNE?=
 =?utf-8?B?K1c0NzB2K29DS2FTYTYrQTRuTWIwUVluQ3BxK1pWZCtDN0djTW1xTXZJbnRu?=
 =?utf-8?B?TTZSSzBUbkdvd0VIVzlYVUZwMGpJcUJoMlNpOUJKVUhhbHJ3dlhRS0FlaThW?=
 =?utf-8?B?TjUrK2xFZFpVeE5Lc3VaMTFybXNxWUVmZlNWYm43NjA1WjNXTzZ2NC9hQWxX?=
 =?utf-8?B?RlBCRlJpQkNpdlVsamFIUFlwdHNrTGRCWUhYV2dWTTNsR0RCWFluYnlYWWVk?=
 =?utf-8?B?aGNHR1JNTkM2ODA2eWhwbmJuUFd5MXBDVFppYTVGUUFvUWw1OUpQNlNiT2FU?=
 =?utf-8?B?bDFDTWM2ZUdTQ3RLQ0JJRzd0eUZjT1hoMzJnazhDS3V1UGhaMlRqaEdSamFv?=
 =?utf-8?B?b2UrazNTaWlzZzhIZ3g4cEZOSGdWME1DNEsvai92dElZL1IzeitGQ2twdFFq?=
 =?utf-8?B?cjJOc2ZYcFZCRmdocXN6ZW4xYWh2UTJCQ2Y4MHVST0hqK2VscGYra1VaK3ha?=
 =?utf-8?B?STNESC9nL0FkbkM2ZW8zM0dFbE5ZajZTc05wcFI0TWY3dUhGRDh0SVd5NE1B?=
 =?utf-8?B?Q2lRbklqa3NESEZPclVSVXh0a3VBVm8wa2liS1J3TWVUVUxqTDBnNTdxUkpJ?=
 =?utf-8?B?alFzOUNtTkw4dEpmTkxMWjllWWxoN2l4bVkwUlYvd1MzRlR6SEFCRzEySzJF?=
 =?utf-8?B?K1hSNFJQckV5NnNvY3VtQ1VJOThjRTRNa2RoK1UxMlBrVEJCVUJFek9yT21R?=
 =?utf-8?B?bDRUTVJUQXJMejVGQmlSZFc5cjFzQ0dxcHNWbEViWWw5UVpuVWdQR1NvU2cv?=
 =?utf-8?B?RkdRNVBjV1V5bldERTdJN2xHRHVhL2wySmFOK2JITmoySlFQcnUwOE1oK2ta?=
 =?utf-8?B?K2t5byt2cWRWS2NSUjNmUU5RK3dmY012d3VPdjdqcjBDU016TzM2a0RNWmo0?=
 =?utf-8?B?cHh3a1ZqSmp4Ym5YaExBOUNjTklDZFdWZmV6UUFuWWczRlJGb2o1K1ZTcU5Z?=
 =?utf-8?B?amN2L3d6dHRVRHNEd0UwYnpNT3VrTGdMNE1ET3JQYmoxV1QwNkY4NGYxK1du?=
 =?utf-8?B?M1g1eXhXRkdxaUtabWpVVGNVbTN0TEtSSnhBSXhpOEJiL1lDYm5aWFNFT0h4?=
 =?utf-8?B?NkFkdEE2Ni9LdEx0UXREMzJXTWhmM1pseGZUbWt1T2VWYWhvWTZpZkkzYnVx?=
 =?utf-8?Q?u6/kLI9k8QY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmowVDVmRGk4SFY4cEdQSW16Zm9TSU5Db0FOZ05Tdm9jOUkyckdYSzFxbFo0?=
 =?utf-8?B?RDRhZjZvZXlFd241V3JSeFRnNGtYWFI2L2NMTGsyOVpMeVNzV0xLSFloaGpt?=
 =?utf-8?B?dCs3ek0wa0tzNnFTb3crMzZJRHM5TG1HeFJPTVZFWE84RTlhWDhjKzJmVG0x?=
 =?utf-8?B?S2VHajNUNWhjWnFqeFZZNFVNZ1Joa3Jybjk2RTNMOHlSNkVRNWxGVTlZSlhH?=
 =?utf-8?B?K1M2TXlwVFdJaENpUW4vS2RpMG1UTGJVeUpoQlc5N2dldFhpY081bjkxWHN1?=
 =?utf-8?B?cStseFkvM3BpekRueUFub3BiMURUSWNLOXR2c0dJMHhxa2FDYktXTERZaWp3?=
 =?utf-8?B?ZmliVVloYWhmdVdrK3N2SFZybkxYR0x0dm1hSEpSaEJCMFFVaTVMRWFvQUZt?=
 =?utf-8?B?QTR3NFpKUmRkQ0xkc1VleUNUNWQwYlg1eVY4T2R1QkVYbVc0MXNvOWFtaXRM?=
 =?utf-8?B?WHFwVUtaWU92SURTVFM1Z2w2VzBiaFNTektNM1RFSjFycEFXQ0sxdnhqSHhE?=
 =?utf-8?B?MFFQZzBjb1lsTG9iNEM3aVRvdUx3eE1ka096R2VtcjBibkIyMGtzemtOMUxx?=
 =?utf-8?B?QUUvbVdyZTVxeFZpdkVVSlRQVWwrRCt1RGNwL25hek5RNjJHbUJiVDgxaVlv?=
 =?utf-8?B?Snc4cVVBd0t6M0VlN1pzZXZJT0JGVExxSnVCNCtmQ09SNlJPNmZjZVVlQzRH?=
 =?utf-8?B?eVB6NTh0OGM0TGdNbnJnWXVmRDRNMUdYaWhBdTZwU0gzOXZyMVZ0eFpOUGxT?=
 =?utf-8?B?cXl2alMwK1ZvWGRFa0xNd1JtYmhiVnJ6UUdiYVlpY3I5eHNqK0VjdGNFcjha?=
 =?utf-8?B?SW5BMWlOaFhEQVRTbm5zODhZdFVhWktqMENsMkcwYjh4MzNxOWUzYUlFcit1?=
 =?utf-8?B?dS8rK0hrVjJKWnl3OHhHdW5OUXN0TFg1MW44Y3U2KzNrdkRNdERKZzJMZm9Z?=
 =?utf-8?B?VHRzaUZUbWtWalU3YmIwdllxTFA1bmUzelRObENyaUh1QVVmM2FBYkFnRVlw?=
 =?utf-8?B?Q0x5d1dRS0hZVThtbWxoV3QxNEdha0p6TzNrUG1OYU5xQ3htWld3N1Y4Nysy?=
 =?utf-8?B?MGhiU0IyUU9uR2JiNlphWGVqTUo1Y1lpNkRhOWR3SEpnNGozSUJaaU1ZYWJX?=
 =?utf-8?B?TzlDYmJnSExJSDc4bGQ2YXR1ay9aaFlReng0VFdVYzZwQU4vWHR5ZnNaWEZl?=
 =?utf-8?B?b1ZDQ2M5TXdQZkRqTnc5eDZidTFTaXVVNFA1U2NWajA1NEhaL2pJSjZ2cmJw?=
 =?utf-8?B?cXhvVzNuVWp2cjZYZlRBVmpGUGV5SFpRakFVOE9vbzV0T0E5ci9IOXA4T1FP?=
 =?utf-8?B?bTQwT21oUCtJSjdSVTF5NnVSbFdiVFZLQWQ1eGtEQ0dydlFKVUhGRWFWK2p1?=
 =?utf-8?B?TDQ0L3pDaUFhNnE3THBGenJtQmtuVFp1NHFjYjJOdmdnbm41QVZnN0drOVlN?=
 =?utf-8?B?UW5IbXc3a0ZwV1c2M1c0RUd6b3VlZkN6T1NFcUQ0d2ZZS0FvMTlmdHkrZGZZ?=
 =?utf-8?B?SWRqd3RhTmVpOTFYOEtqZkRTYWJkM25Db0FIWWV5WWlUZGFtbmRaS21wQUtU?=
 =?utf-8?B?cG9xSTVkamZhZlY2VlYrK25FN2xCMXBSalZjT2lIZWduTHpkZHhIUTBRemFa?=
 =?utf-8?B?L05zNHJmWXlPTitLR2wrWEVzWGt2Q1Zod2hoNFIwcFVnME5wYWgveTM2MkFE?=
 =?utf-8?B?ZHBPNFM2NGxMRmIxalhDQk9BWVQ4YWVKQllOTDgreDlWcm5ZeEtIVytqOUw0?=
 =?utf-8?B?eWllZkNKNlIrOEY0R0VhOGhzUDlUWnRnL3pCNFZGZGtURHFtTzdpcDVzdHMz?=
 =?utf-8?B?MWp3RjRycTNySkZwb242c1ZyRUk3b1FIQnplNVhDL2NObG5rMHl4RTFEeElG?=
 =?utf-8?B?QU1DMXNYVWdkZGxzZzFIMm9CZThMRWVVcFIrWTZKQXBMckx2UWVBbEJkS2RU?=
 =?utf-8?B?VVRMZFZyVGNibTRxS2IvOW5MNlduNXVnTk5xSXQxbGVQVlluL3p5T1pZVTFq?=
 =?utf-8?B?OFU1ZVZnL0h2ZWRUUGRDcWpqR3lyNHAyZER1N0QvbjdhTDMzSGpzeWo1WEN3?=
 =?utf-8?B?QzE0aExsZHpyNzZuR3pLOTZCcHBGVkVZNnZTOVFHUmJJTjJxcVhDUVVocWFv?=
 =?utf-8?Q?gwnI0Hh9qx38umQ7c+HmY0lja?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f4c5aa-ae83-4233-05bb-08ddf3899236
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2025 12:23:54.9980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lcahYl8iY/trU280paS6clrQM6pOcGDs/6HvgpmrGHj2Dm9WtZZUlnOeM5uiJOaUXEqvyjlRKNGep3P0GCJkqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8780
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=jan.kiszka@siemens.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.91, SPF_HELO_PASS=-0.001,
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

On 09.09.25 15:28, Jan Lübbe wrote:
> On Tue, 2025-09-09 at 14:50 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  docs/system/device-emulation.rst |  1 +
>>  docs/system/devices/emmc.rst     | 52 ++++++++++++++++++++++++++++++++
>>  2 files changed, 53 insertions(+)
>>  create mode 100644 docs/system/devices/emmc.rst
>>
>> diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
>> index 911381643f..36429b1d17 100644
>> --- a/docs/system/device-emulation.rst
>> +++ b/docs/system/device-emulation.rst
>> @@ -101,3 +101,4 @@ Emulated Devices
>>     devices/canokey.rst
>>     devices/usb-u2f.rst
>>     devices/igb.rst
>> +   devices/emmc.rst
>> diff --git a/docs/system/devices/emmc.rst b/docs/system/devices/emmc.rst
>> new file mode 100644
>> index 0000000000..3bd70c0e94
>> --- /dev/null
>> +++ b/docs/system/devices/emmc.rst
>> @@ -0,0 +1,52 @@
>> +==============
>> +eMMC Emulation
>> +==============
>> +
>> +Besides SD card emulation, QEMU also offers an eMMC model as found on many
>> +embedded boards. An eMMC, just like an SD card, is connected to the machine
>> +via an SDHCI controller.
>> +
>> +Create eMMC Images
>> +==================
>> +
>> +A recent eMMC consists of 4 partitions: 2 boot partitions, 1 Replay protected
>> +Memory Block (RPMB), and the user data area. QEMU expects backing images for
>> +the eMMC to contain those partitions concatenated in exactly that order.
>> +However, the boot partitions as well as the RPMB might be absent if their sizes
>> +are configured to zero.
>> +
>> +The eMMC specification defines alignment constraints for the partitions. The
>> +two boot partitions must be of the same size. Furthermore, boot and RPMB
>> +partitions must be multiples of 128 KB with a maximum of 32640 KB for each
>> +boot partition and 16384K for the RPMB partition.
>> +
>> +The alignment constrain of the user data area depends on its size. Up to 2
>> +GByte, the size must be a power of 2. From 2 GByte onward, the size has to be
>> +multiples of 512 byte.
>> +
>> +QEMU is enforcing those alignment rules before instantiating the device.
>> +Therefore, the provided image has to strictly follow them as well. The helper
>> +script `scripts/mkemmc.sh` can be used to create compliant images, with or
>> +without pre-filled partitions. E.g., to create an eMMC image from a firmware
>> +image and an OS image with an empty 2 MByte RPMB, use the following command:
>> +
>> +.. code-block:: console
>> +
>> +    scripts/mkemmc.sh -b firmware.img -r /dev/zero:2MB os.img emmc.img
>> +
>> +This will take care of rounding up the partition sizes to the next valid value
>> +and will leave the RPMB and the second boot partition empty (zeroed).
>> +
>> +Adding eMMC Devices
>> +===================
>> +
>> +An eMMC is either automatically created by a machine model (e.g. Aspeed boards)
>> +or can be user-created when using a PCI-attached SDHCI controller. To
>> +instantiate the eMMC image form the example above while assuming that the
> 
> s/form/from/
> 
>> +firmware needs a boot partitions of 1 MB, use the following options:
>> +
>> +.. code-block:: console
>> +
>> +    -drive file=emmc.img,if=none,format=raw,id=emmc-img
>> +    -device sdhci-pci
>> +    -device emmc,drive=emmc-img,boot-partition-size=1048576 rpmb-partition-size=2097152
> 
> Missing ',' before rpmb-partition-size?
> 

Thanks, both fixed.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

