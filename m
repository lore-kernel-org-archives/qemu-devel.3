Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAB6CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 09:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3WJe-0008HT-MC; Tue, 30 Sep 2025 05:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1v3WJa-0008H5-4Y; Tue, 30 Sep 2025 05:06:30 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1v3WJT-0004x2-Fd; Tue, 30 Sep 2025 05:06:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qaKcqKSXGE2dFvJplWdpPhWFCRPWl/C72sUOxZsoBl/vWg3wVnMZPrw84JoC0/YHeyimSKgCmQMkQb4160EsC+qjK2+zrnxawDgOXAoBf7N2auVpRQSmBXm/XVoilZIjwAOga0AiEtBEwUCLTJtIdrcelymOx6JNxkVNvdGfx6qUhImsFPp8KpeCD94Lo/xtk6PqTBWWW56Nz7GUpxQCQbqfUnkpsVT4KWxoFWmM7v4TrVmB3FVctdfP7yrvRg5kIZZhKqRgsY7z6Hae6aBlE7Im4uDy92SKzC7dcRQyN8NXMBMQyedVvLC2u+Dy9VoaQzXidowzoEU8PR/r2GtNNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tfs59oYkx4JifG72FT5KM4t4CthUXOIS+GQxn+nX5vY=;
 b=Jb6K1N57P6OHx2zA/oadLGVHuo154DEZ+16YC7erUZ8bjh92juYrWATVW8t6nF+JxtBrbdxmP171x9YTN81/soueQK0aSQJ7JjtxS4JEuYZhxX9sKP93NAXpja3PHDKa2cwmRSaezNNZFO9mcs7tNroa3HLEN6LVFs4F4WzqRxLWpw3by7R8x0IyJ2iG2G95+xMWt/zUV6Qp0C0O7keF26fw2U4ENzwYmx5s6OBUTuaX0lxnnQUKrLkkbLuyS1Ff+FgU7NmhonD8gGO/HClN1eJdAQ/8kZAlea5KUr3RXCM3BqiQ5RjZwVYePYr2luwaY1HYjiEvNTpIZYR7hgKZ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tfs59oYkx4JifG72FT5KM4t4CthUXOIS+GQxn+nX5vY=;
 b=YYRI+o2OnWkhvFCqO90muRC9dJiLPAISzGg3Yz0a8OgGiksEgh9iGjQhmk22iDb8tdI8V2JtDYNss/YpDti/O1RjEZkZK/NNYMfepqf7NGUJpWbT4tnw8M81KmYa3aYDU45uiIzDwzssPhaSeMC6D6rXv/G6AL8HVfk7G/hNSeyTALqXNkpftXVa+EzYvvCPBiXnlCG4Cll4Zucf3wdWMZKj8oPr2FTmF1Aw0T31VfiVqvFNTZvu5Db0eCf1v0o0rTQtp4b+fJvPYO65+YbAgOAIQqNCMciY3L+yAay6xj0shbfAEaL0POSl5ZvjNL2OpCE4keDb7S8nsfzUAoCmcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3739.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Tue, 30 Sep
 2025 09:06:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 09:06:09 +0000
Message-ID: <aa63efc6-8edc-4db4-9221-a1a54fc1cdce@siemens.com>
Date: Tue, 30 Sep 2025 11:06:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] hw/sd/sdcard: Fix size check for backing block
 image
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, Warner Losh
 <imp@bsdimp.com>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Alexander Bulekov
 <alxndr@bu.edu>, 'Jamin Lin' <jamin_lin@aspeedtech.com>
References: <cover.1757854006.git.jan.kiszka@siemens.com>
 <48930c1092424d22dc2171140378de19e0814ef3.1757854006.git.jan.kiszka@siemens.com>
 <c144202b-0d99-4507-8a57-35df1ece3cc0@siemens.com>
 <2070f7bb-cd1a-448f-ba87-50d75e24f4c0@kaod.org>
 <b09cd869-39e7-4a62-b452-4ea39ccf4df0@siemens.com>
 <e992011b-ac3f-4770-97e8-3c0321410e72@kaod.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <e992011b-ac3f-4770-97e8-3c0321410e72@kaod.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3739:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f052716-96ff-40c5-6675-08de00009868
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2lFaFlqV1ZQOHJWR0M5RkpXQ0hMUjNicVRmbENPdzBkOFA5Sm1SempEcVFC?=
 =?utf-8?B?REszZXdhSWlhaDM4OG52YmlQNEV3d3hRYmlqYS9vZTk3ckgxZ3pNUE15disy?=
 =?utf-8?B?UnBrbjc1VnlLVndUbmdoNjNocmczdlBGNTlUZFJoNG83RDBrd2VxUnQrZVdM?=
 =?utf-8?B?Q2xDa0RadGQ0d2hhL3RaRkNkRGk2T09iRUplMzBUSkVCcWc0WDVTTFQxb0s1?=
 =?utf-8?B?RmNHS1J5Zk42bVVndndMbVhnRmNobzVDZ09XZjF0cVIyTVNDRExlcUpBS1l3?=
 =?utf-8?B?U3l3ZWR6MHpKQ00vUlBUU0x2aGc4WjJpSTdNaUJ5SkU1Ry9Sa3k2c1JhQ2RD?=
 =?utf-8?B?emJ6a3MzQ0UrWlh0UnpBUno4cXptcEhMYk1YZGVmcXFaNHAwNnZCM1ZBaUJY?=
 =?utf-8?B?Q283eXl2V1llempqTFRVMlgvbjZwSGRHY0tBTkRubk9IRHNXUllIbGNpL1VU?=
 =?utf-8?B?aFZwTGN0WkMzZzI5Z3hYMTBsUVVsckFhOWcvbXJsbi85Q3BBOVNkSzZlVmRy?=
 =?utf-8?B?Yms0M1p4eDhHcHRMYWViTTQwcFd5bWJpYjNxUkwzdnF1V0dmTjQ3VWxqcVU1?=
 =?utf-8?B?WUY0Tm1Db1NCUHQ5aTFyVHZjMXBDZUpqYzB0dFFJTDc3V2ZRQTVUNCtpZEJK?=
 =?utf-8?B?M3F2N2RxRzgrckZ3bldCVkVjUXZ5RVMrRmN1MDFCKy9ESFlucVFKR0RwRVE5?=
 =?utf-8?B?NnI3VlVTNDJwWVZ3WEVja1dtMFk3SGwyVmtwUUR5ODk3a1FqY3dnRHR5c1VE?=
 =?utf-8?B?Z2xLUTI4a2gxMWJta1UvRDZsNENsSDdFbnpFZXIwMG5FMEdBbjk1ZW5DUjNN?=
 =?utf-8?B?a1hjYWtmVDVVR3dBMW5wYWd2UWdOaTZ2ZkRwRm0rWUl2ZDlpbGhmR0NiWXh5?=
 =?utf-8?B?MFp0OFEweGgvejhaWFI5NmJ4cE9KUHExNW9pRmROcmxRRTk4N0RFNVU0VzVZ?=
 =?utf-8?B?RzNmUVdCSzdPZTNtSEhjRndMbUxSVFpReTErOUFjSStWZlp2K2NDRHdmdTZB?=
 =?utf-8?B?UUdTMnREdUYyMTBjSFhoTVVhUXRSeWtaQkdobDF3ZjltNjBGSXpnU2I5Q2d5?=
 =?utf-8?B?VytVdk1wUHNQbFNQNmZRcVlGVldjMDdUcm5xU25LdlpXMUVzUG4rY0VWWXBX?=
 =?utf-8?B?WVk4S3FOYzhwb0ZHSVBSbEw5MERrYW9RUnlRZWxqcWZ3U1MwQ2syTWl5YTU0?=
 =?utf-8?B?VVZzVGNaS1pjTTBqNjkxbGhobnNKamVMOHFpZXNUckowYUI1R0FoeEdwdnFv?=
 =?utf-8?B?dFNlcUY4ODk2ZEdmU3hyb3ZJQWREaUY2Y1ZVb3pYOXFlWlhRVTNOR1ltSmFT?=
 =?utf-8?B?NWdkQXVJRTNaUzY4SVFCTjlJQnYwVnVaMDQvbmJSVWxEbU1QZGtzQ0x6MmZD?=
 =?utf-8?B?ajRnVXJGelphQy9JWjViSXlIY21jaDhWTEpzWkdNTzUra2x4bXVkY3QvK0ZQ?=
 =?utf-8?B?WjEyWFhBUjYwU0MwQ1JwSzJLUVhmdjhsK2FvVUY4S0s3ZlQySGU4OWtOWFp5?=
 =?utf-8?B?SW4zdktXem1aaFdGSUZYOG9ybVI2VVk3SW5RajFiWUgvelBqQ084dllCbFRJ?=
 =?utf-8?B?U0RQb2Q4UDNOV1N3Q3pQeVhWS1haaGhCSU93Q3VaS0tReGQzV3ExMkVUbnZC?=
 =?utf-8?B?d2N5OGJYU1VvTjdTdjhtaHVoVGttVXB3bjAxdnZOTG1DRTJhQ3JpZTlVQ2ZZ?=
 =?utf-8?B?TzlsSjFkdit1blFsb21SaXgwVHd2MVQ5eTJXeC9kR21BelB0UDFBMXhpaTBX?=
 =?utf-8?B?a1lEL3hMWGpSaUUxRll2MHczb1FPV2RrL0g0NUlMYlo0LzBaS0VrRm85UmJS?=
 =?utf-8?B?QXJOUXlTbEcydS81Z1VmOHF5NWEyaWNocnZyQXh5QUc4cThscFJRbmRkY0xN?=
 =?utf-8?B?d1RiWFhZRnp6N3ByK3hHWDhiVEVKWTlQeWxxUGp6a1BBQzdIR1lLWDZpMWFC?=
 =?utf-8?Q?HR+gX7euyycg7Y2ScVk4LMjJroYkx7Fm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzZKSEdSOVF3dHp3dnZudjlPcE0vME9tMFc1b2VrdTMwL3BTT3BreFZ2SkNv?=
 =?utf-8?B?b2daSlZTR3N1Szh4QmtxVkp5Qk9RTTg1ZUpSd1pjZWRHcFpzcklMSG5xVU8r?=
 =?utf-8?B?R1RPbTBwcy9lbjU3QmREUDBIY1lsNVJVYkVMK3FZbFdqeUNsQUtCd1A5TDV4?=
 =?utf-8?B?bHRpY0lDQlBlSjdCbW1zdktZM1JGcWI3cGdkRXBIMmdTRVcrZXJaZFN2N3Uv?=
 =?utf-8?B?Q1JUbStYOFRCbG9JZzZ6bGlWWEF1c0N0Z0pYOFR6UXBOZmFCZXMza09KYUpS?=
 =?utf-8?B?bkFxSnRqcnpMa01XUUJ5VXRVNmtGN2NQb0FVd3lJTDZ1ZEJnbXRMTlEwUmUy?=
 =?utf-8?B?azhqR3dIN2EzL2FxSEhNazZCQm5LSFZIWHlWR25tWExrUUlmSEF3MG41dUJt?=
 =?utf-8?B?WW9BSDArYVcyWExqTjhMb3RmT3Z1a0NLUGtOamZlRlZlZ3lRSzVuTWQ0RlRK?=
 =?utf-8?B?b29zWnhFNFBMSXlWTVNjMHdTYU9aRWw2NzJUZ0N2RWVrM3NDUVVzdzI4NVlR?=
 =?utf-8?B?ME1iZjlRT0diUVZNcXJTSERPNGdnWVNhdENUR3l2OXh1b3hWOUl1alRvLzUr?=
 =?utf-8?B?a3RYVmJTWWd4aWlwRHhRRW9PWHNRa0VtcG12UnI3enRIT0hld1ErUjhZNjJO?=
 =?utf-8?B?ZDEyenlsU2o0U3lKYTRobEszc3Nyak9qY2FiM2p3MENYRXNybGpKWlZlN2VH?=
 =?utf-8?B?WWxRVlM1eVpyRDFEV25LV2xsb1JrVHJQOEhqSlVUVDZ6TXFtQTQxaklBQ0N4?=
 =?utf-8?B?TXBhL0lOQkZUTVFXRFkrdkNla1RJdGxzRzMxNlZPRkE2dkpEOEluUmJVNnhY?=
 =?utf-8?B?bWZFd1BNUXdxcFhaZU1QZy95TzVSWmMyWTRQaXRobm1VWVpHRFFBYjJHODhy?=
 =?utf-8?B?bnordnQzQ3phUEg3TkZIc0xiYk0zV3ZBVTA2ZHFOSDdQaWhpUVB1bGxOMDNu?=
 =?utf-8?B?NXNBR0t0MTRuSnZHSTJjM2NGSlVYTjFLdUlySGxaa2J2RkU5aWFRWXhMczlO?=
 =?utf-8?B?UURaWE9qeE9aa1dVTzRoeDRMS2N0SlYwalV4ejV2c1ZMdEo3NSthRHN5Q2Mw?=
 =?utf-8?B?NDBueXhsVml1OUhzdWpCb0kyaEpTeFJ4NHRlZ21JNHJVNGI3VVozdHJ6Tjg2?=
 =?utf-8?B?S05PcC9JZ1NIUFdVcTVMWktaTy91ckpHOWxmQ0kxQkR2MHdPOHhJTy9uYmpz?=
 =?utf-8?B?aU94NUJYMjJhMmlud2pjaEJ3SmNqMUk4bW5iUDNEaEF1SGxjQmVwWSt6OWFm?=
 =?utf-8?B?MHJwaSs3d2JzMktsNTcweWZ5SEp6d2pwQkIvb0FEUmlHNm4rMjAyRlRFRnla?=
 =?utf-8?B?NE1NTkJMZHQ0MGorUE1qcmtETDJGbzRUekVvczJFc3lBNHFQcDA3N0dUQ1RH?=
 =?utf-8?B?bXArNWk5L1ZJMUlzR21sVUNmVUlyNVZ6R2dlWkM1MGlEMDd2dFUybDArRWJR?=
 =?utf-8?B?R1ZveURaVFU2NTVSek9selh1a2x1NENObTJpWGtvMGpQUG5wdHozeHphWjla?=
 =?utf-8?B?NklNWlpxdlVuTnpTSHNlcHNCZk5KMjlMRkZPRFcxdDFTanNGa0RWREZGVGdh?=
 =?utf-8?B?UjVSMkJ0SmtVaEJ1WXdINkorUVFwUDMxK1JIa1BGSjAxVzlKMm11bThKUlZS?=
 =?utf-8?B?NjJjVjBBSml2eFByMVhGTnBRNC9QOEs3c0tKK01zREJyY3U1ZjFSNlJUU1B0?=
 =?utf-8?B?ZmM3bkRKS2V3c282OW9FZENnbFptZWhyV01RYnJSeFJvcmxMK1JNRGxTS1ht?=
 =?utf-8?B?YmdEdG9VWFJXeW1IM1JMRlcyU2IzVXg3UzYyVHMwMS9UU3REcFNqQ1ZFMW4w?=
 =?utf-8?B?S0FKL0dTbXNER3JWTzZIRThMRmpDUUxUazY4dDBDZ295ZEJhMGRYdXJvckp4?=
 =?utf-8?B?M0RFWlZXTVNJRmcwbXdNRzc4UTdtTzM2WXplOGFudHBjaCtRRUhmZzc3cHZB?=
 =?utf-8?B?UXFhRjd5WExKK3AxUTZpbXN1Q3J0NXBRRXNKRURYQTQzMXoyTWYrMm0rSkYz?=
 =?utf-8?B?L0M5d1hlZithOElhSWdXN3FicnN6WEdmbHMzeHZHNXM0aG43TE52alAvUW5H?=
 =?utf-8?B?SHB6OUNveUZVQjlqVDg2Y2FMWW12dzNaSlBrU2J5ZThzckMxZVd2R3NkMnNN?=
 =?utf-8?B?dU5mOHQ4RStydVk3R3NGRXRRSGtRbmtXTzdBNlp0UVhYSG9nQnhLc0d3emQr?=
 =?utf-8?B?cUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f052716-96ff-40c5-6675-08de00009868
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 09:06:09.4297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dSCHkrFstN+cWviXETHiW65mvq6WLl5BxXwh1+oJJIaeaF/7Hnjtx/qUchEYS3r6J63PczJyLWdZcapfj5Tmnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3739
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=jan.kiszka@siemens.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
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

On 17.09.25 07:53, Cédric Le Goater wrote:
> On 9/16/25 19:17, Jan Kiszka wrote:
>> On 16.09.25 18:14, Cédric Le Goater wrote:
>>> + Jamin
>>>
>>> On 9/16/25 13:39, Jan Kiszka wrote:
>>>> On 14.09.25 14:46, Jan Kiszka wrote:
>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>
>>>>> Alignment rules apply the the individual partitions (user, boot, later
>>>>> on also RPMB) and depend both on the size of the image and the type of
>>>>> the device. Up to and including 2GB, the power-of-2 rule applies to
>>>>> the
>>>>> user data area. For larger images, multiples of 512 sectors must be
>>>>> used
>>>>> for eMMC and multiples of 512K for SD-cards. Fix the check accordingly
>>>>> and also detect if the image is too small to even hold the boot
>>>>> partitions.
>>>>>
>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>> Reviewed-by: Warner Losh <imp@bsdimp.com>
>>>>> ---
>>>>> CC: Warner Losh <imp@bsdimp.com>
>>>>> CC: Cédric Le Goater <clg@kaod.org>
>>>>> CC: Joel Stanley <joel@jms.id.au>
>>>>> CC: Alistair Francis <alistair@alistair23.me>
>>>>> CC: Alexander Bulekov <alxndr@bu.edu>
>>>>> ---
>>>>>    hw/sd/sd.c | 61 ++++++++++++++++++++++++++++++++++++
>>>>> +-----------------
>>>>>    1 file changed, 42 insertions(+), 19 deletions(-)
>>>>>
>>>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>>>> index d7a496d77c..b42cd01d1f 100644
>>>>> --- a/hw/sd/sd.c
>>>>> +++ b/hw/sd/sd.c
>>>>> @@ -2759,6 +2759,28 @@ static void sd_instance_finalize(Object *obj)
>>>>>        timer_free(sd->ocr_power_timer);
>>>>>    }
>>>>>    +static void sd_blk_size_error(SDState *sd, int64_t blk_size,
>>>>> +                              int64_t blk_size_aligned, const char
>>>>> *rule,
>>>>> +                              Error **errp)
>>>>> +{
>>>>> +    const char *dev_type = sd_is_emmc(sd) ? "eMMC" : "SD card";
>>>>> +    char *blk_size_str;
>>>>> +
>>>>> +    blk_size_str = size_to_str(blk_size);
>>>>> +    error_setg(errp, "Invalid %s size: %s", dev_type, blk_size_str);
>>>>> +    g_free(blk_size_str);
>>>>> +
>>>>> +    blk_size_str = size_to_str(blk_size_aligned);
>>>>> +    error_append_hint(errp,
>>>>> +                      "%s size has to be %s, e.g. %s.\n"
>>>>> +                      "You can resize disk images with"
>>>>> +                      " 'qemu-img resize <imagefile> <new-size>'\n"
>>>>> +                      "(note that this will lose data if you make
>>>>> the"
>>>>> +                      " image smaller than it currently is).\n",
>>>>> +                      dev_type, rule, blk_size_str);
>>>>> +    g_free(blk_size_str);
>>>>> +}
>>>>> +
>>>>>    static void sd_realize(DeviceState *dev, Error **errp)
>>>>>    {
>>>>>        SDState *sd = SDMMC_COMMON(dev);
>>>>> @@ -2781,25 +2803,26 @@ static void sd_realize(DeviceState *dev,
>>>>> Error **errp)
>>>>>                return;
>>>>>            }
>>>>>    -        blk_size = blk_getlength(sd->blk);
>>>>> -        if (blk_size > 0 && !is_power_of_2(blk_size)) {
>>>>> -            int64_t blk_size_aligned = pow2ceil(blk_size);
>>>>> -            char *blk_size_str;
>>>>> -
>>>>> -            blk_size_str = size_to_str(blk_size);
>>>>> -            error_setg(errp, "Invalid SD card size: %s",
>>>>> blk_size_str);
>>>>> -            g_free(blk_size_str);
>>>>> -
>>>>> -            blk_size_str = size_to_str(blk_size_aligned);
>>>>> -            error_append_hint(errp,
>>>>> -                              "SD card size has to be a power of 2,
>>>>> e.g. %s.\n"
>>>>> -                              "You can resize disk images with"
>>>>> -                              " 'qemu-img resize <imagefile> <new-
>>>>> size>'\n"
>>>>> -                              "(note that this will lose data if you
>>>>> make the"
>>>>> -                              " image smaller than it currently is).
>>>>> \n",
>>>>> -                              blk_size_str);
>>>>> -            g_free(blk_size_str);
>>>>> -
>>>>> +        blk_size = blk_getlength(sd->blk) - sd->boot_part_size * 2;
>>>>> +        if (blk_size > SDSC_MAX_CAPACITY) {
>>>>> +            if (sd_is_emmc(sd) && blk_size % (1 << HWBLOCK_SHIFT) !=
>>>>> 0) {
>>>>> +                int64_t blk_size_aligned =
>>>>> +                    ((blk_size >> HWBLOCK_SHIFT) + 1) <<
>>>>> HWBLOCK_SHIFT;
>>>>> +                sd_blk_size_error(sd, blk_size, blk_size_aligned,
>>>>> +                                  "multiples of 512", errp);
>>>>> +                return;
>>>>> +            } else if (!sd_is_emmc(sd) && blk_size % (512 * KiB)) {
>>>>> +                int64_t blk_size_aligned = ((blk_size >> 19) + 1) <<
>>>>> 19;
>>>>> +                sd_blk_size_error(sd, blk_size, blk_size_aligned,
>>>>> +                                  "multiples of 512K", errp);
>>>>> +                return;
>>>>> +            }
>>>>> +        } else if (blk_size > 0 && !is_power_of_2(blk_size)) {
>>>>> +            sd_blk_size_error(sd, blk_size, pow2ceil(blk_size), "a
>>>>> power of 2",
>>>>> +                              errp);
>>>>> +            return;
>>>>> +        } else if (blk_size < 0) {
>>>>> +            error_setg(errp, "eMMC image smaller than boot
>>>>> partitions");
>>>>
>>>> Cedric, I just played with some ast* machines and noticed that they now
>>>> trigger that error above when no eMMC disk image is specified
>>>> ("qemu-system-aarch64 -M ast2700a1-evb"). Is that a valid error,
>>>> i.e. we
>>>> shouldn't have tried to boot without an eMMC at all so far, or would
>>>> this be a regression?
>>>
>>> Only the ast2600-evb and the rainier-bmc have eMMC support.
>>> I don't think the ast2700a1-evb has eMMC support. Jamin ?
>>>
>>>
>>>
>>> The rainier-bmc boots by default from eMMC. Nothing really
>>> special about the image, the first boot partition includes
>>> the u-boot-spl.bin and u-boot.bin images at expected offset.
>>> The machine model loads the u-boot-spl.bin contents as a ROM.
>>>
>>> The ast2600-evb machine boots from flash. To add an eMMC drive
>>> (needs to be the 3rd 'sd' drive), use this command line  :
>>>
>>>      $ qemu-system-arm -M ast2600-evb -net nic,netdev=net0 -netdev
>>> user,id=net0 \
>>>        -drive file=./v09.07/ast2600-default/image-
>>> bmc,format=raw,if=mtd -
>>> serial mon:stdio \
>>>        -drive file=mmc-ast2600-evb-
>>> noboot.qcow2,format=qcow2,if=sd,id=sd2,index=2
>>>        ....
>>>      U-Boot 2019.04-v00.04.22 (Jun 17 2025 - 08:57:39 +0000)
>>>          SOC: AST2600-A3
>>>      eSPI Mode: SIO:Enable : SuperIO-2e
>>>      Eth: MAC0: RGMII, MAC1: RGMII, MAC2: RGMII, MAC3: RGMII
>>>      Model: AST2600 EVB
>>>      DRAM:  already initialized, 1008 MiB (capacity:1024 MiB, VGA:64
>>> MiB,
>>> ECC:off)
>>>      RC Bridge phy@1e6ed200 : Link up
>>>      MMC:   sdhci_slot0@100: 1, sdhci_slot1@200: 2, emmc_slot0@100: 0
>>>          ....
>>>      [    4.209117] mmc0: new high speed MMC card at address 0001
>>>      [    4.211765] mmcblk0: mmc0:0001 QEMU!! 16.0 GiB
>>>      [    4.233637] GPT:Primary header thinks Alt. header is not at the
>>> end of the disk.
>>>      [    4.233995] GPT:29624393 != 33554431
>>>      [    4.234161] GPT:Alternate GPT header not at the end of the disk.
>>>      [    4.234399] GPT:29624393 != 33554431
>>>      [    4.234549] GPT: Use GNU Parted to correct GPT errors.
>>>      [    4.235223]  mmcblk0: p1 p2 p3 p4 p5 p6 p7
>>>     
>>
>> $ ./qemu-system-arm -M ast2600-evb
>> qemu-system-arm: eMMC image smaller than boot partitions
>> $ ./qemu-system-arm -M ast2600-evb -drive file=disk.image,if=sd
>> <works if disk.image is large enough>
>>
>> Is that ok?
> 
> No. This is wrong.
> 
> An sd card device is auto created at init time and a 'DriveInfo *'
> is always available for index 0. 'mc->auto_create_sdcard' should
> be set to false IMO.
> 
> commit cdc8d7cadaac ("hw/boards: Rename no_sdcard ->
> auto_create_sdcard") seems to have changed the behavior of
> several machines.  See 'make check'.
> 

Just to avoid we are in deadlock: My understanding of this issue is that
it is not a fault of this series. Am I right? Or am I supposed to
address that as well?

Regarding the rest of the series, there was another comment on potential
improvements for the docs. I was waiting for further remarks before
creating a potential v5.

So, what is needed now to move forward with my series?

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

