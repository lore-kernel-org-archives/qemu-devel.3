Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38A2CEACC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 20:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vK0Ax-0003gp-9h; Fri, 14 Nov 2025 15:13:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vK07Z-0005Hb-Ne; Fri, 14 Nov 2025 15:10:26 -0500
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vK07X-0005W6-0A; Fri, 14 Nov 2025 15:10:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLNjF3dY1Bpcci309OxGWU3hC3Q0rmcrfDzEbWye+TKaI9Pdd5vwDcx7X6GSorONF+8OBEfHahDOomQNwWuCyysaw477hfu9itzBBkbTnFUWlCAKmHoCAFWoVm2kSEt2MTnrbs/fCKlOV9NSMFW3j4nUA/P1BcOBeO73poz04YIiN9ppexTH1oh1B7+MU/jy81TrP5vw6erVQcGJAPyP5NolKuudv1SbFtZP2BffhPeGggcHZx2GlT7YvhKTjWhtCl1WT1+Kfaz77WjBRiSbTLP2QGjxXxr6I7jFsiKL5ItuOQ7s0yJLyL3g3QH4WuGnJkyrAqgg2hOet2rtoLZFug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VI4jRkdEnmrVfUHJ80SW/bWMv6jUZ3pHb/1JP6Q381I=;
 b=CdV6Vm2vzP4N5tLPjGNBkFc2iRxy/j6RblbBSYoXUxeorQEuwKOomp6tCFuuVkxk7E8TvZxU1fn2fMKSSkWEU4mCmot+znLhqFxcbE42TL2onCyU9tn3zK/Eg6TUafqMK30Lu0f8yNP47JqBu0GFv4fRb8kk9YR3Vh1w3OkiJg6dT2tQD9GRPO8N3G+KkeJdBCWK6cVS+dHDBbn4XRKYrNjbWVyVK3Q4oQzlUc2TdxdYNoSDxMvjwAQ5CR0g3SXWYpoOjLBI9/q30GjbR1MHNWx8Kuhu4fnDIMixAVo6zXVsVCJokXighWVZ0a902KEohRkojIbYKSpBXXc1RfoCTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VI4jRkdEnmrVfUHJ80SW/bWMv6jUZ3pHb/1JP6Q381I=;
 b=L3hool0fC1U+ndz6Z73ruu2WEm/qCbExug79VnJ/dM6PGcsjg3oIHl8N/VVkbZuNauCfyVfv3axa7mCkyJBb6J9SRKs8/6sQNeE9+1z79dsAiLFZuxQ28QxIrquA6PvK2zg4EP0NmGAIP6dNH0LUKP4/ebV9DPZ5oRAf1/EgUNMHWooXpiprytOCvkjE9ZXvGoMpESwivN4djeopBuhTAKi129wkAUQZeyQO2Kfm/B5TL3WA+gqBLVWZ1ZVvLnjuiQMBqS2RNhW4XIpB427WF89HEl9unK3AB+Dicm3JQzjIkDURHzJGiPFNDHy8gmM8acqzMZ7TK7FsIIc9XM+lSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3966.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:163::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 20:10:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 20:10:04 +0000
Message-ID: <ef372dd2-68e5-49ac-b10f-857fc9484599@siemens.com>
Date: Fri, 14 Nov 2025 21:10:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/sdcard: fix potential out-of-bounds read in
 rpmb_calc_hmac
To: Peter Maydell <peter.maydell@linaro.org>, zhaoguohan_salmon@163.com
Cc: philmd@linaro.org, bmeng.cn@gmail.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, GuoHan Zhao <zhaoguohan@kylinos.cn>
References: <20251106072818.25075-1-zhaoguohan_salmon@163.com>
 <CAFEAcA8iWqAgZzH7u3jYTEb-fjjsBWAp3WJY24xAKN8CpdVw9Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFEAcA8iWqAgZzH7u3jYTEb-fjjsBWAp3WJY24xAKN8CpdVw9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0450.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3966:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e135533-2445-4cae-a1c6-08de23b9cceb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V092VHFRbk4rcWxqRU5xNlc4eWZDS2tSWEtHdktkRzRyUEFMdnpaYXQ4NXI4?=
 =?utf-8?B?L2IvMWdlSnkrR0M5T0VOZkVyQWJLZXl0ckJtQmZ1d0RXd3hEZUgyOC9SRXNJ?=
 =?utf-8?B?eGhZNm9UNG9QZ2NnNGxvOFFxVnY3VGxHYnd2cDdreHRsNkJvc2xXcnhzc3pU?=
 =?utf-8?B?YzBRdUsrUEdsNFpNWDRiL3d4OTUvbGxIR21zRFNaRXlWbVZxNGh0UWVPWHEx?=
 =?utf-8?B?cE5SRXVONkhRN1NmMWJucUdNN2FOdW1sQlF5bzZRcHlzZCtqVGZFdUx1OFdM?=
 =?utf-8?B?ODBud3NpdktIN0xTQ3EvNTFVQnB3dkdHUUkzYmE5L3dUQmZGenNwU2psSFhB?=
 =?utf-8?B?MStmekNlTG9vRDhJYk9HdC82cXh0emNGc243YnZWQnlKVnRJRmM4Wi9jcGM3?=
 =?utf-8?B?VVl2QnZTVmtUT1h1UWx0NEw5Qlppb0xQTWRhQW1XWHhjRGFZVlo1azR6dW1t?=
 =?utf-8?B?RldpQ0hBa09QNXZjQkR3enJhV1pzNjRFRjgyd3NIL2Z5Y21NSS9CcmM2eUZF?=
 =?utf-8?B?V2xLaHpINFp6OUFpWHhMQVJHRFdWdXcxZjFSQm9DaHFzYklYWnlUVDd6akk0?=
 =?utf-8?B?YStGODBNamxmRUFzMDRsZUkzb0FnaC9OdndDZ1I0MkVpUjFpZEtMWmVVTnVr?=
 =?utf-8?B?TThhUW14eFlabWVyNVRQcVBJQWhvaWNaNXZncmhsbmYrb1J4RnUzdXFLK2ti?=
 =?utf-8?B?Yk9SeGMwbCtkNTN0U0UrUWhNbFZDeWlTNmRTN2txamtEWUxsbUtqckorQlZH?=
 =?utf-8?B?NXNDa1VZelk1WkVnVW5qZUZMNzNlcUUwcDVDZVU5ZHl2THRWdmNRQjdUMGdw?=
 =?utf-8?B?UzIrZzY0b3NzbHVPK200UUdYRkRMWHJDQytRUmVNdDFkdHROV3RhRWhJT280?=
 =?utf-8?B?ZitiRWxYTVNEMWtTQktIY1lLeWxldVowcTk5U05pZ3ZCZnRCM3ZvY3BVTXpC?=
 =?utf-8?B?MG0zUzBFbDhlU3A0SGxVV2FLY2FjTklxMmlZa25YUGN5MjdEYVJhUTAwWVdH?=
 =?utf-8?B?WWxFZkFnMjlEN3JXdGgyK1I3M2IrUHhHcHFCQS9lWVhhTzFKbllyaWdCenFE?=
 =?utf-8?B?a3Rhdm1UU2V6Vit0clJ2bFliOTJaVTVnNlVQWVdVQWM5MWMzbVByVm5rYVZE?=
 =?utf-8?B?NXl1OE51eGF4QkwwTjhwb0lpZ0JsS2Zyb1pqR3BXeXljSjliWktZSDBLK0NB?=
 =?utf-8?B?RDNFMmVBUFU5Q1dXWkJ1dk9EcHlsVVZFVXgzTkJucDFvM3JDSUdQaWd4Q1FR?=
 =?utf-8?B?SkI3VXppWElvUUxlQVdtUEZGdGZGVTBRajNOV0tLazJDUWVwVCtOU1pkL1Bi?=
 =?utf-8?B?OXNMdXNrSjFuV0IzRFlDU0Yra0F6NmpaamVjaVZPN1pCOG56SkRQTkpnd3hp?=
 =?utf-8?B?eWUxaVVvcWFKbHliN0U4dGhHZ0h6Y0V2a09qQTlmeXY4Nk13S2c5YUFjS3ZC?=
 =?utf-8?B?VGJYUlNRbWorN2RxVHA3aEFTcVB6RktpQTdrdWtaelVLSENuS3N2SDZXeVIy?=
 =?utf-8?B?UUJoUXBXeGRHZ2t6a1VNL0ZEVlhlRlppUmVoQ3hiSWlvUWNRbVo1UFNib1JJ?=
 =?utf-8?B?bkpNNnlDamR4eHNveTBaN3RNejlMY3dCZUVoQWlTZS9tU0cyUjQxRThHMVlE?=
 =?utf-8?B?MisrM0drZFAzUGZTbUhrL1haRTUzSS9pLzl6V0hudnpPcTJrSFJ0Y2F3NHhL?=
 =?utf-8?B?dmdZWDRoZm5LS1ZYNWR5MG9jYWw3bzU2Q3FSeXNCdWZSbHY3UVZ5L3ZBOU9L?=
 =?utf-8?B?Wmk5T01BNTU1WHdvVElGK1ExL05HL3k2Z0YvRHU0RHh6SnFKNTF5OEk4QXFN?=
 =?utf-8?B?NkU1S0RSQ2NmZmJoREw2eW5oS0xUaEJ5TmNqZXNNMTFNUDNHU3NBMzF6cnRK?=
 =?utf-8?B?all3S2ZIUEUxUFQ5OTRidXlPd29RNmFUR0oxZFEydDBzM3dONzNrK0Y3djR2?=
 =?utf-8?Q?J0n3ET3KSJmNzNKIzSkVoKNFAyP29mex?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjBZUGxtQmxGcTdmSnpnR0FhTmRqMVNoVE5Cd0Z2Z2xFVjZUUTVKczZURUo3?=
 =?utf-8?B?M1BvUUJCQ2g0Y2UvZU9ieHVhV0lhVys1a2crWElodEw4ODB6Qm5QTElncXVz?=
 =?utf-8?B?ZDhNd1p5c08wZzhjcFVLc1VzVDFwekluVTNxUVhwd05xUlFCUFJSa2NWanJM?=
 =?utf-8?B?S2ZHYjU5TGRGMm53eGI1VGJySTVCWWdQQWY0OFQyOXBsekZ3ZTdmbXJFWENi?=
 =?utf-8?B?ZGoyMG91Mlc5Q0dQN0p3QUxzd3dOMmNNUWpZYlhyUFhxcnBwSzVsWFcza0oy?=
 =?utf-8?B?NERLRjcyT0VOMWViRVFEMVVxcWE0Y1lMaFhta3h2dERNa294aERqVG5XcXdn?=
 =?utf-8?B?dGthVHZ3NXpVODNGTHhSK1NnWW1Hc3FjVjZHYlhFVUhuUVJjVy9lYkt4QlR3?=
 =?utf-8?B?TXpqblUrN2NUdjV4Z2lidEVYSHIreVRRYWpoTHBQZFpvVUFvV1VRT3owekQv?=
 =?utf-8?B?d00yajluVktVMUNpS2t4cFNXOUpCajcxVll5ODlMS1ZqbUM2UDBPRDcwZFFk?=
 =?utf-8?B?Q25HR1ExMzhGbm1sMllmMTBBTWcrK0RycWU0bWw2V2hFbkR6RXdhdjNDQWkz?=
 =?utf-8?B?a09Rd2poTXlyMlhVQjhaR01OMUlDcGlxK2xKUC9ESVBJMUVxQlh0WXVmMzMx?=
 =?utf-8?B?REtvOFFFREdySmVvZ1ExcW9QQUt4UjZFU2h2Rk9uMlRYK09ydVNUbnFYSnlE?=
 =?utf-8?B?REpySnQ0NEtkTjFmSGFIa1NvYk5yMjNHTWhXQ2Y4cXY1NmdRQlV4RTZqYjdl?=
 =?utf-8?B?dGhuKzNrMzgvUXJwQUQ1SUwrQ0tyVmdlRjRjVlFUTTVoemRQYkZiK3Boc0Qw?=
 =?utf-8?B?YU1kM1NYN2dmdXFZRWQ0cmtoTzM5dm4zMUNLTGNiU3U3TnBkcTczZWZyY3RZ?=
 =?utf-8?B?aTRWclV0RHorZUdjMS9mWVNNYUE0d2RwYXkvcGdBYmJqbmNOWEVCMmtTdUE3?=
 =?utf-8?B?MVRTN2FTRTJRMTRzd0FnWlhzNUJ2YXAyeHQ2dWFtNHdISE14clFjdGZEclo2?=
 =?utf-8?B?L2c0V1FlTWNkYTg0UHIydDFKOTB1bXRlL0NLcE43Nm53L2lNN1o5ZFZpdmFt?=
 =?utf-8?B?M1FYa09TcHJiQ2MzYWNGZngxZ0gyNmxSZ3V3SmJiRXVEZHlLQUtlTERpREgw?=
 =?utf-8?B?UkluN0hhejRsZmlwcEE1VFVERDNwZ20wV0JQNWgyQ2NFSVVId1pTZ3MzVjE3?=
 =?utf-8?B?cFNBK1djZytjc2Z0OU5mdFZOeWNnVVZ3LzBoeXhBRHNiVVhSMkZrbDFvMVBG?=
 =?utf-8?B?WGw4b25USXhVNW95aUV2VnJDWGRRYWR6NDFRRlpmTXk5UjVQMCs1bHhwWXlv?=
 =?utf-8?B?OVh2elRkZlh5MlJSM3YzQnBIMUprUDQrY0VRN044NG01Sy9qUGVocUs5ME1z?=
 =?utf-8?B?bnRYN2pwWTJMaWdNUlIwRU95djNwUG5Jek0vUWo0dlpLeEFvVTJFSkkzei9N?=
 =?utf-8?B?a2VKMXR2NHJtM1NhWkJNNDhhQ3pCd1VoQ2NPQjF1ZE5nWWYvRTA5Q1dOUVVj?=
 =?utf-8?B?ZXByejhuRHhiMVdRQnBiNThva3JXa3ErcmNKQzdhODd6OHBiUWVFQ08ydWFX?=
 =?utf-8?B?L2VsSW1DUDF4bGZCYTVtcUZpcnBYRVM3UDloWHoxdHpUdi9talk1R0h2eXJz?=
 =?utf-8?B?TytaNXRjYjBXMEJ3dElKM3p4VExYSzI3S3ZaU0U1alowNmRHcSt1VzVBbVl6?=
 =?utf-8?B?ZFpJcUNWK3luRmlUTWxKZG5PY0I3Q0NBb2NuaFUrLzNBWFhJRHgyWWZqY0ZQ?=
 =?utf-8?B?TzA3Z0pyN0UxaXJGRmkyUE8wSWl5VnZtQ3RvZU1pNjVrTkJ6ZHBDbk9sMlF0?=
 =?utf-8?B?ZjBYUVE1c00wKzFDeDJuWHM1dmp6aXNaT01URjErQ0s0bXZ6QytIcnU1SGZB?=
 =?utf-8?B?OHF4WVZLMkt0TmlMU1BaYzJNWUhpL3hxZSszdGg3OU5WWnBmaHI1QW40U2l6?=
 =?utf-8?B?S2JMY1JKNTNDMHZ1cnNTY2h4TEJKdk52Z3dDbUZXNHRRZ2ZGWmt1R0ZETU9s?=
 =?utf-8?B?bnJ3aDQ1ZXJWWDNFV0dHaktiTlpQUlgzUDdia0Q4aE1oUlFMdFU5V0RnM3Z2?=
 =?utf-8?B?OEFZMFJOUzZ6dUs1aWhsNGpWelNZT2dTZ3J2U1FtenBlaWF2VnErUDJaWnNF?=
 =?utf-8?B?YmxQU2QwR1dYRFVNZTFwZlAwMjlIcHRnT3gvS3JaVXM2b053bDU0T3B0T2dR?=
 =?utf-8?B?dVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e135533-2445-4cae-a1c6-08de23b9cceb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 20:10:04.9250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fz4OcNBkaU6dfyEh2nEbiB89pbJ3X+WFu4D+fQ11Ed/x4vGTpFV851+vbh1EHHP47D8fGpN/RQK9uhvTf0Mpqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3966
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=jan.kiszka@siemens.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

On 14.11.25 14:39, Peter Maydell wrote:
> On Thu, 6 Nov 2025 at 07:29, <zhaoguohan_salmon@163.com> wrote:
>>
>> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
>>
>> Coverity reported a potential out-of-bounds read in rpmb_calc_hmac():
>>
>> CID 1642869: Out-of-bounds read (OVERRUN)
>> Overrunning array of 256 bytes at byte offset 256 by dereferencing
>> pointer &frame->data[256].
>>
>> The issue arises from using &frame->data[RPMB_DATA_LEN] as the source
>> pointer for memcpy(). Although computing a one-past-the-end pointer is
>> legal, dereferencing it (as memcpy() does) is undefined behavior in C.
>>
>> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
>> ---
>>  hw/sd/sd.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index 9c86c016cc9d..bc2e9863a534 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -1161,7 +1161,8 @@ static bool rpmb_calc_hmac(SDState *sd, const RPMBDataFrame *frame,
>>
>>          assert(RPMB_HASH_LEN <= sizeof(sd->data));
>>
>> -        memcpy((uint8_t *)buf + RPMB_DATA_LEN, &frame->data[RPMB_DATA_LEN],
>> +        memcpy((uint8_t *)buf + RPMB_DATA_LEN,
>> +               (const uint8_t *)frame + RPMB_DATA_LEN,

Yeah, the originally intended micro-optimization drifted off into
something questionable. But this mitigation is unfortunately broken -
please always check the outcome of a change proposal or, if unsure,
contact the author with your finding first.

>>                 RPMB_HASH_LEN - RPMB_DATA_LEN);
>>          offset = lduw_be_p(&frame->address) * RPMB_DATA_LEN + sd_part_offset(sd);
>>          do {
> 
> What is this code even trying to do ? We define a RPMBDataFrame
> which is a packed struct, but now we're randomly memcpying
> a lump of data out of the middle of it ??
> 
> The start of the struct is
>     uint8_t stuff_bytes[RPMB_STUFF_LEN];  // offset 0
>     uint8_t key_mac[RPMB_KEY_MAC_LEN];    // offset 196
>     uint8_t data[RPMB_DATA_LEN];          // offset 228
>     uint8_t nonce[RPMB_NONCE_LEN];        // offset 484
> 
> so frame + RPMB_DATA_LEN (256) starts 28 bytes into the data
> array; and then we're copying 28 bytes of data?
> 
> The existing code (frame->data[RPMB_DATA_LEN]) doesn't make
> sense either, as that's a weird way to write frame->nonce,
> and the RPMB_NONCE_LEN doesn't have the same length as what
> we're copying either.
> 
> Can somebody who understands this explain what this code
> is intended to be doing ?

What this code does at high-level is documented in the function: We
reconstruct the hashed parts of all read RPMB frames. For that, we start
by filling the tail of RPMBDataFrame from the nonce field onward. Then
we place the data of the individual frames in as well and hash frame by
frame.

I'll send a better version that does not confuse code scanners.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

