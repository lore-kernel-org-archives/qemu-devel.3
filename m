Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53FBCCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 05:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIhD5-0003fi-81; Tue, 11 Nov 2025 00:46:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vIhD2-0003dY-Mi; Tue, 11 Nov 2025 00:46:29 -0500
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vIhD0-0005sN-EP; Tue, 11 Nov 2025 00:46:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8mKgKA7VckUun093ZRzd9JaB5lexzyUqpjXxUgbeAdrPe6+cam5Gv5qsovnquVDNfwWIqD6lPTB4zxaQx8zQQDjPkF5BwbbmhPweMrjgBhzTtxgYwirTv8LybW6nSu0+pEvsM8eo6leZRiJCT73ZApYf8qFV4zzFT9BGrTpjZ67gvqwernLZ1NsFdjjxMQnsSdf1rjnj6hv9TYwhna8VZTWmZNphdOzr5jJdLBca+b3xr3T9SA/7m3OnFg5tG5ZuJoXDWWaESUPAVlMIuWJLYCmLqNjTHy9gRDyKv3AQYINtk20uqMxvnXY1vSrs4h3IRujJDOjKw0IhNCjTL1x1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rt2Hig76ubE1oF4cme4Uv0LC/uHJ6E9EdHIZ4zPBvS0=;
 b=C6Z4P/HdGNZ4zrWCHH0FIM5mckzoU8+Z/2UzxOCBtK2HNgcwxSoXikCJ4iBoYz66pMhsJKCwQGCV5y8gpyK75x4ZVdxtcxtul3JDGmXz3BTEf6ZWN3eb1I97VIjGneLfqNkAsRsHyD8vE2g64oYeFzdjOcOYRSxSjoA4qyVqorog0nWyw6R3crvMxKfqTeLtvo334bOyXsRD+HxOt8uMd8z6kUU35tyl+bFjXyr50FhMekJG4aOuH8GNlZDIMV13sQimVw/8nM6nYpgvwJb/vqotOR75Z6JAZ+hn4vIwE+Boer+vBJ+4SdJiNCtH2whxd4nSSt4a6oe04CJKjnBrlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rt2Hig76ubE1oF4cme4Uv0LC/uHJ6E9EdHIZ4zPBvS0=;
 b=qpXh4oih2kGRO43DrFR34ScvQD7EVVSa2LSV6otCZyoT5i1pJ7HLVfvL2LGn7wwTPur+y9ABjfVr+X8bInBDrabSntkKT8GuNGYNahotqsyT32swnyxAkK0WODgem//7jOeziYnZABSi/x/gj3RYJ5eYV93Hqj2+gFu5mINLYJJhly2svnS9rauWZbnyGy8Axa9UTG0mJhqwfswIGKyjXSSCigoypUEdNCJh2pU79gOeU9e4bKVlmGoIIp7n/Ce2HcTE2gWNXRgrpyaC39hCZCc9uQHpYtpqSzVlLt2OBEkmxrwznJVU6WNljizKzryKmugwCRz8Mv1c8P3hejJSHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5544.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:242::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 05:46:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 05:46:17 +0000
Message-ID: <82b3079e-0bff-4b27-a0e1-204d787fffc4@siemens.com>
Date: Tue, 11 Nov 2025 06:46:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/17] hw/arm/aspeed: Attach UART device to AST1700
 model
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 'Peter Xu' <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: troy_lee@aspeedtech.com
References: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
 <20251105035859.3709907-8-kane_chen@aspeedtech.com>
 <1d1cf03e-204d-4029-b188-a0e49a59d853@kaod.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1d1cf03e-204d-4029-b188-a0e49a59d853@kaod.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0243.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5544:EE_
X-MS-Office365-Filtering-Correlation-Id: ff6483bb-46a3-468a-c6b9-08de20e5a251
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmliVWJHYmRBTUFwSDFzRWxIbHNieG1QSVJlSTVSdlBQaHd4ZXo0WjZFK3VI?=
 =?utf-8?B?RnQ1ejJudmF5K0UvTHNMN1EzbytleUR4RHVQNkNqeVAxeFRwNEJ1c2FaN1ox?=
 =?utf-8?B?RGVwRHhkRUExOFRsd3FsRHA1dTN0OVdsMm1RUUlaRnVOV2U5MXViL291STYv?=
 =?utf-8?B?RFpiOFBtREdRRmpIekFsTTg4QTFhYW5sd05ZbDh2a2lFL1NkKy9iYjdCelBh?=
 =?utf-8?B?c2NCR0tweFVtZDRUTjQxdC9kRS9oYzR0YUlUaU8vZmR3YmRybWIvK0ttZzRS?=
 =?utf-8?B?M2wzNWNxYzBGZXliT2wyT3RCWkNGZFg2bG9YZk0zQk40bjFINkdWOWxtbzkw?=
 =?utf-8?B?SFkrTTM4UUNzZEdaNDVEMGg5aG1kR2h1b2ZMMy8zQW1RM1lQY2NEZGs1NXlJ?=
 =?utf-8?B?MHJwdmExaml3RTRNczc1TE9vMGk4UVRZOXJEa243TGxvc3N1VkxuMlZpQndU?=
 =?utf-8?B?MEZ2bTJhV2xDSG1DWERiMk5KRVJieW9yNEx3SmxScUwzbE9vQnZaa2JpOHdw?=
 =?utf-8?B?KzRaYUZNVmJEY1VyT2J3UlFCUDZKa3VibU0rUy91T0hWMzdvcS96ay9MWDJK?=
 =?utf-8?B?dDBPWnQ5R2VobW1lSWs5MEFISy83OVNJMDR5Y3VTbXd4ak1FRzJDTFpQVC9M?=
 =?utf-8?B?ZEhaRWM4TTZyZDhhRHZ1TGZDV09aUi9lYVhRcjRzdmpKdXhtNGxFUE9UckRM?=
 =?utf-8?B?Qm9QeGdOeitkRnUzUGxqaDRmZlp5VEkxQzBteElBWk1kcWV0OUE1UHpXTHVI?=
 =?utf-8?B?ZTJSSFNTS1dTZENqRHB4Q2lxaGpqUUhMWlBUUUF6YUgwMUxWN3p2Wkk4K3RT?=
 =?utf-8?B?MVV0MHpwQkxlajl2ZUNKV3F6Vzk5OWdFdFk0U3ZNOUZlRDI2SkV0L2RFNkU4?=
 =?utf-8?B?WTZnZW1IL2V1WmlyMjh5OEZEYyt6WEtlZmU2Y3F5SERDMlpLZm9zc2dPRFRr?=
 =?utf-8?B?NzVTcDRBcjhiQXdyRFZXQ2hvQ0JZdld0MFhlcm81MnVVb1EzU3lCNUs0VkZ1?=
 =?utf-8?B?S3BXc3lFTFJkbEVLNXpxQVQvS0ZnRUJZUXJUazdKaGxMenJBOWhGanFja3A0?=
 =?utf-8?B?d1NCUjdGNE85dmFDUUtFWDEraWlpN1JIS0hody9GRW5XMFFNaVg3RyswczlB?=
 =?utf-8?B?UzJEa3RQUi9hc1YyaWxkay9PbEFRTmYybCswM0hZMVExVUFtNGhvK0I3ZkE3?=
 =?utf-8?B?SlZPVmp5S1BiamY0cGxjbHNoSko4THpTQ00rVC85aDdSemFmNFZCMzlOQmZ2?=
 =?utf-8?B?TWZhQWlTZFRuaHdUbXJuTDRrL0ltQUpMY1ZLdUxmeVJSNFpGS09tOG5wdFJW?=
 =?utf-8?B?K2Y3dno1My9jYndudmJKZHZlWVNzQWpSa1FQSTFsbGxUTXl5MFFDS3BHUUJk?=
 =?utf-8?B?RURHbUxpeGZDdnYya2hPRXUwY3I3UXJxbHdvTDZOOTUvOVFNSXNaV1F4Y3FF?=
 =?utf-8?B?N1hxK0w3YVU5V1BFRys5NDVGRWVSSml0VTNvL3ZNaHJvMGFmMWgzQWxNZ0N2?=
 =?utf-8?B?UjZEZVI0YjNNcWlQUDNnUlNhUlE1cWlBYzlFWC84QjNGaHhKSWRUNXZFc3lJ?=
 =?utf-8?B?K0JzQ2d1NjEvOENDQVhDRmo3VDVwVmozeVVZdjRONWxOYmd4UHZNaTV6YkxK?=
 =?utf-8?B?aUZHYkFuZkhRaVBmK0VER3A3bjArY1AyS3F1ZDJieTBOY0Nna1hBYzVvTzJz?=
 =?utf-8?B?NnlsYU5zVzdKY0tOUjBmbHJFcVBZUmcwL0RkYlQ3dll0NXI5QW9rdUJ4dXlO?=
 =?utf-8?B?OXRyQXEyYzZ0am9Gdk5mVjdUOHJPNEJPRnBxYkI1QnRTZzlxdFVORG9Wbnh3?=
 =?utf-8?B?eUpZZUdwejh2a3FnbEtjR0QwR1Zmdng1cnVJaFZoc1hKMWhyTy9iTGxpUVR5?=
 =?utf-8?B?VUhLclNYUjAvQ3ZxcUQ1WXRGM2FReHJMcEJvOXJZcTFVNG8waVB4YTBuNW9i?=
 =?utf-8?B?Sm5yUU5kZWlUUFNFSDBlWmVkSHo4TC9jQ3J0VG5GeVF4NWFid0szUnREcGJ6?=
 =?utf-8?Q?6Y0LAahV5tegF7FLb3EaiMTttqTbBs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020); DIR:OUT; SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2xiOG40WCtaWkZEbzRxZmNTNVNLSWlVUmxXZUkvVllNQmtUdHkxTmpFaFNV?=
 =?utf-8?B?cjN6SWRkQmFRdnBmbFdtbjVvVlhmRUoxNStJLzJSbHIyRTN0emcwZkZhMmtl?=
 =?utf-8?B?RmhiZjlGQkZQZzZub0lyTW1ETmZmV0xGR3pwZFVCdUxLRXJKb29yV0VEUjhk?=
 =?utf-8?B?dXNVenlmWlRZdFA2dUkzM2RjNzhKRGhEcVhId3Zma2xjNDZ1eHJLUzJ6WmVX?=
 =?utf-8?B?VlQ0UWc1eGtXVi9MYUFodWlVNysrR1dVT1R1UjJpM3dYVDQyN09qQjlMYjlJ?=
 =?utf-8?B?NmtoS1ZIaTRpTEhNUHlQQjlzVWhtOUlHaEFGOGhNbTZJS3hkVmpraFkvdy91?=
 =?utf-8?B?NS9pMXhzMUM2b1RTenlPK0JrcmNFakhwaW9BMmxhL0M2OEUxL3NGN1lUME5a?=
 =?utf-8?B?TGIrdXJPODAzcjQrV1RJV3hjTUtMYjNuN0dDajFFdmZlWHFmTXJzdkJYTU9E?=
 =?utf-8?B?VDNvYVZjdDFRdE1XOWJ2cFp2ekFXdUdpNnEzanBWZnlVblo2bGlMeFQrN0Iw?=
 =?utf-8?B?Q3pFY3RPVzBOeXpSWm1WK20yZjRRMGVVbURHRUlaV2haRlRmUjZqbS9BK2Zm?=
 =?utf-8?B?SHRlMFpNWExwVTUzUGFHTmtJT2tiQ1dzaTNMRElEY01HUGE3RVpCWWlESjIx?=
 =?utf-8?B?NG1sOHZqYWxTSGdxQlBVd3g0ZlU3Ujhwa3A1akVWM2RpdnhNRFhJRFE4SWFK?=
 =?utf-8?B?YW1scnJFbUdDUTdaQnNqdTBtTGFZM01xNVZyY2JBR01GUytoS1JuT2o1c1F4?=
 =?utf-8?B?NEpkelNmVGlkeXEvVitDM1B1RU53NHQxbklndnhsMkcrTk0wc0JkZFRLbEVS?=
 =?utf-8?B?bFp3bTgvU3NMTzNQYUlNeDEvZXQ1VzF3ZVNuWFRMVUtFcUMrZHhPcmY3TnZz?=
 =?utf-8?B?anRGdndYaEdMa2hjQmhXWGdialNTbG9XUDI2WUNwWHhqcXgxRVNHOGFlS1RT?=
 =?utf-8?B?bnB2ZE9jaGdMbmF4NldjcWNTeXBGWlhaZDZOMTlRcnJ5UW9STGZyRHJmdEZT?=
 =?utf-8?B?QU1nYmFraVlJRi9KRHZWMmpiS1ZFRXZab1BjRXB2UHJLQ3hiOXRhQ0U5ampJ?=
 =?utf-8?B?VWpRNFVYMElDMmxOUDhwblEzZ2dwQ0tMM0lkM0gvTjQ3YkRJL2hGa3Ava3N6?=
 =?utf-8?B?b0xiWFV0VmpTZTd4ay9NeDFLNVUvS1Z4Y3haUEx3ZXBmRUtzWXFlREdsVXpR?=
 =?utf-8?B?TDIza1N5QlM1NERRbDVpRS9XNStmNERibmpkSEhUd0FXL3ZhSHlIcUJEZzZ6?=
 =?utf-8?B?WG9ma2lPSTNFR3BLMVRucWY3NnBnUXVBOEp4eGJkRWNGUTJFZXgyOUNpUU44?=
 =?utf-8?B?d0o0TEpUajNNczNDVlF2TXoxdzQ2R1hEVjZGbjJBdnZqUHNnM281RVoydTAv?=
 =?utf-8?B?TFVQNVJlVFh6RkJueXM1Zk4vaHZncTFTZUhxQzgwQm55aUk1ZXk4RG5EdjVv?=
 =?utf-8?B?UzZRNk5OVVUvWFRvQ0VMRll4QlFzcHlUV0RhKzRHT2hsVGFSTUk0N1Bnek5D?=
 =?utf-8?B?OGhQYVMrcWViVmNrL0tJc3NlN2ZNVUpscVEzMVpIM3hyR2VWaDVmK3ZUZEdn?=
 =?utf-8?B?ZEpEbVZoRGZiZ1FXemVhSWZWUGUzNzIydmo0c2tnODF5NHNqVmFZbi9WL0xN?=
 =?utf-8?B?c2gyNDNFS2pWN25WYkMyMEZEdDFFR3JDWnBxcm1CelVYWko4Vi8zNVEweWJQ?=
 =?utf-8?B?NlMxZmhGNFQzR2VuVzdVL0YyTDFqdlU0NTJuNWs1T3RiQUdHaWZoM2dWaWtR?=
 =?utf-8?B?SkFndkNlUDJuT3dOdXErLzdXTzRnamNabGFqdDRVTlhBc3F0YUhrdjVSOUNE?=
 =?utf-8?B?MGptWkZneFY1TTNUMGNnMUxQeDR6NW0wbnhvOXpicTVlZGo4eDBiUmZWN3ZF?=
 =?utf-8?B?dUVEak1NNk9BeHI2ZXB0Z3ErMCtaeVhhKzl4WVkxVUF5R0hIbmd1V29MSElH?=
 =?utf-8?B?Yll2WWxrVS9jSjZOaytXdTQ1Wlk1R1NPSnRPRFV5UmkyK1BvMzdRcUx5ZUxm?=
 =?utf-8?B?Z3NzVGZqQWVUNDNheWxWWDNGdkszbUhQZTdlNkUxR0V1cXUwMnY5dFZ6dlZt?=
 =?utf-8?B?aDA2VWhZMUc0L1JOc3YyMXMxMVRDREZGeE9IWEZvcnZUbW5HWTRZbVZMT1FR?=
 =?utf-8?B?OFVsR29FYkZob2xQM2laMTN4K0sxOU9hemp0UGk5Nlkyck5QdFovZ2I4cXZJ?=
 =?utf-8?B?cXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6483bb-46a3-468a-c6b9-08de20e5a251
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 05:46:17.7750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugLlZ/d5t0KWL6uhG57KgqjcAP2rfPwgQuOJ/3Be1fe8bqcMCPBMAjyc2HGyv1HdHyiUxh3c1B9sbLoog4KQ5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5544
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=jan.kiszka@siemens.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

On 10.11.25 17:04, Cédric Le Goater wrote:
> Hi,
> 
> This change appears complex due to the use of routine
> qdev_set_legacy_instance_id(). It was introduced 15 years ago
> by commit 4d2ffa08b601 ("vmstate: Add support for alias ID"),
> for the PC world AIUI.
> 
> Adding Jan, Peter, Fabiano for feedback on the current relevance
> of qdev_set_legacy_instance_id(), particularly in the ARM/BMC world.
> I feel we could get rid of it and simplify this patch.
> 

I have to dig deep in my memories but if I got it correctly again,
qdev_set_legacy_instance_id is (was) only there to transition an
existing but self-registered vmstate for an existing device model to
qdev-registered vmstate. We neither have a pre-existing device here, nor
do the aspeed machines or devices open-code their vmstate registrations.

Jan

> Thanks,
> 
> C.
> 
> 
> 
> 
> 
> On 11/5/25 04:58, Kane Chen wrote:
>> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
>>
>> Connect the UART controller to the AST1700 model by mapping its MMIO
>> region.
>>
>> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
>> ---
>>   include/hw/misc/aspeed_ast1700.h |  2 ++
>>   hw/arm/aspeed_ast27x0.c          |  2 ++
>>   hw/misc/aspeed_ast1700.c         | 26 ++++++++++++++++++++++++++
>>   3 files changed, 30 insertions(+)
>>
>> diff --git a/include/hw/misc/aspeed_ast1700.h b/include/hw/misc/
>> aspeed_ast1700.h
>> index c2bea11346..e105ceb027 100644
>> --- a/include/hw/misc/aspeed_ast1700.h
>> +++ b/include/hw/misc/aspeed_ast1700.h
>> @@ -28,8 +28,10 @@ struct AspeedAST1700SoCState {
>>       SysBusDevice parent_obj;
>>         MemoryRegion iomem;
>> +    hwaddr mapped_base;
>>         AspeedLTPIState ltpi;
>> +    SerialMM uart;
>>   };
>>     #endif /* ASPEED_AST1700_H */
>> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
>> index 11625e165a..7151feb35d 100644
>> --- a/hw/arm/aspeed_ast27x0.c
>> +++ b/hw/arm/aspeed_ast27x0.c
>> @@ -1070,6 +1070,8 @@ static void
>> aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>>         /* IO Expander */
>>       for (i = 0; i < sc->ioexp_num; i++) {
>> +        qdev_prop_set_uint64(DEVICE(&s->ioexp[i]), "mapped-base",
>> +                             sc->memmap[ASPEED_DEV_LTPI_IO0 + i]);
>>           if (!sysbus_realize(SYS_BUS_DEVICE(&s->ioexp[i]), errp)) {
>>               return;
>>           }
>> diff --git a/hw/misc/aspeed_ast1700.c b/hw/misc/aspeed_ast1700.c
>> index 0ca2b90ff0..1c2d367cdb 100644
>> --- a/hw/misc/aspeed_ast1700.c
>> +++ b/hw/misc/aspeed_ast1700.c
>> @@ -18,22 +18,39 @@
>>   #define AST2700_SOC_LTPI_SIZE        0x01000000
>>     enum {
>> +    ASPEED_AST1700_DEV_UART12,
>>       ASPEED_AST1700_DEV_LTPI_CTRL,
>>   };
>>     static const hwaddr aspeed_ast1700_io_memmap[] = {
>> +    [ASPEED_AST1700_DEV_UART12]    =  0x00C33B00,
>>       [ASPEED_AST1700_DEV_LTPI_CTRL] =  0x00C34000,
>>   };
>>   static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
>>   {
>>       AspeedAST1700SoCState *s = ASPEED_AST1700(dev);
>>       SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>> +    hwaddr uart_base;
>>         /* Occupy memory space for all controllers in AST1700 */
>>       memory_region_init(&s->iomem, OBJECT(s), TYPE_ASPEED_AST1700,
>>                          AST2700_SOC_LTPI_SIZE);
>>       sysbus_init_mmio(sbd, &s->iomem);
>>   +    /* UART */
>> +    uart_base = s->mapped_base +
>> +               aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_UART12];
>> +    qdev_prop_set_uint8(DEVICE(&s->uart), "regshift", 2);
>> +    qdev_prop_set_uint32(DEVICE(&s->uart), "baudbase", 38400);
>> +    qdev_set_legacy_instance_id(DEVICE(&s->uart), uart_base, 2);
>> +    qdev_prop_set_uint8(DEVICE(&s->uart), "endianness",
>> DEVICE_LITTLE_ENDIAN);
>> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart), errp)) {
>> +        return;
>> +    }
>> +    memory_region_add_subregion(&s->iomem,
>> +                       
>> aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_UART12],
>> +                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s-
>> >uart), 0));
>> +
>>       /* LTPI controller */
>>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->ltpi), errp)) {
>>           return;
>> @@ -47,6 +64,10 @@ static void aspeed_ast1700_instance_init(Object *obj)
>>   {
>>       AspeedAST1700SoCState *s = ASPEED_AST1700(obj);
>>   +    /* UART */
>> +    object_initialize_child(obj, "uart[*]", &s->uart,
>> +                            TYPE_SERIAL_MM);
>> +
>>       /* LTPI controller */
>>       object_initialize_child(obj, "ltpi-ctrl",
>>                               &s->ltpi, TYPE_ASPEED_LTPI);
>> @@ -54,11 +75,16 @@ static void aspeed_ast1700_instance_init(Object *obj)
>>       return;
>>   }
>>   +static const Property aspeed_ast1700_props[] = {
>> +    DEFINE_PROP_UINT64("mapped-base", AspeedAST1700SoCState,
>> mapped_base, 0),
>> +};
>> +
>>   static void aspeed_ast1700_class_init(ObjectClass *klass, const void
>> *data)
>>   {
>>       DeviceClass *dc = DEVICE_CLASS(klass);
>>         dc->realize = aspeed_ast1700_realize;
>> +    device_class_set_props(dc, aspeed_ast1700_props);
>>   }
>>     static const TypeInfo aspeed_ast1700_info = {
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

