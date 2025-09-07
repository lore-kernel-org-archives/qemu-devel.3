Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90D2CA101F
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Sep 2025 19:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvLQE-0000Hw-PG; Sun, 07 Sep 2025 15:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1uvLPz-0008NN-SZ; Sun, 07 Sep 2025 15:51:23 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1uvLPo-0003Vd-3E; Sun, 07 Sep 2025 15:51:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fe9+qUOjNwhhKjcYFGNq2rIOPN8+MER2LmrT/RnbfvOJmvHDmwInJiwmrXGMfjXxm5oDb1Mmw7lSanUrS4ck4oTjKzdUgMDlmZ5jZ063oCBpsPArFXRq3lT6WVlIX9TNCndo/uL7tp+gFoZtGnFHUsUuKrlA/hkvT7D/J5wxv+bEVG+sVUVKb5vJ9ZQplwWUv8mt21avvbk8mVp1lEQo9gf95657IDMKxn7e48mJNbxGzv6LBBskyFlHTeK08sU8lFFcYdrWJWFqLwpRnbEdsuMpiqRSW2qGS0tJGDXqBHdho9jQUvXYv8Kgqrez3nTWmkjrGpP9hK7/snHh+daUYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/4OTQrVG7uEYAIhv8EksM66QVGNnqdRf3x1pQdp6rc=;
 b=dOmEpCiAwTdVe9Cw1Zq8PvTJNn1YCxIWFPhkrpJfbC+z63UJjeh/EpFYKgWLkAw+UQg8kztO7zdwlw2AshENXmwUkNTik6ixgQUc8ewQfkmWUpmxyXsfFvcwocLX9MtBsJA65ulWCUuBghnA4/EPRWj6V3TsoNQTRCB9yQaBBDc7gnHIKTt9ZUKcMKmiat/TqTJn2wViHZ0a4zDa9if7TIEDK+b0LGeg7ZdvXEQ75+kK+kciCW+/g6A6idNQS8BD3753d7eGWNsSJdkB5VzBFlh00ahOfErZJfi96TX4gulBKvRGvr/igGjeKZf4/auIsDhUJGoG5B96ZyooxpjsDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/4OTQrVG7uEYAIhv8EksM66QVGNnqdRf3x1pQdp6rc=;
 b=zpNGRMQJWH8cPAm7c0yb2oQ8UGC5J4o+5U7I0/NPQDyb6x6xDrC5WbBponryxVjfNH7arXy+bDUxSqkN8GBNtY+c5ulv6lk9K5U/ONzCCBs3ETBbIvJDfsvV25gzt045ydlXzJFwIamAySJDODSni/Uu8SFW/oTV8FPsP3xi77fUrJvsTS9yfSNRBbotptazol9czgfcC/bkRScFd1GjbH+2P+MLcgQSNFK32HFR9EnvLnDulLOIheivghVrnivD13Z2lq8V4VAzCN54rfijg/GhGD2Zv1PVPOAbsI1HVaPQUtprDuJVxg7ikwTxpvsZh2gg0bGEvY4X6Z9s83vxRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB7965.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4fc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Sun, 7 Sep
 2025 19:50:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9094.018; Sun, 7 Sep 2025
 19:50:35 +0000
Message-ID: <dae51a1c-2ec9-46c5-9650-d042cf6d35a1@siemens.com>
Date: Sun, 7 Sep 2025 21:50:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/sdcard: Fix size check for backing block image,
 part II
From: Jan Kiszka <jan.kiszka@siemens.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-block@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Jan_L=C3=BCbbe?=
 <jlu@pengutronix.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>, Alexander Bulekov <alxndr@bu.edu>
References: <9f7fc688-7676-49ff-8f86-fac347f70f05@siemens.com>
 <b672f2c8-8298-45ba-8989-fc830914e61b@linaro.org>
 <8d063b06-7cc6-4069-bd17-73985d60b507@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <8d063b06-7cc6-4069-bd17-73985d60b507@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eed4290-1b50-41fe-b0ea-08ddee47cfd3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUdUdncxbld2WEJuazJId25CNHNoVTdxMTVVT081cjlnMnQ4M1pPQ004ajY2?=
 =?utf-8?B?emdXYkNGSmlDSFBiV2o2UVpwSnIrUjR0TGFnV05nSTVCRktzRzB4REV6RTRJ?=
 =?utf-8?B?d0xaR3lNQUc4Ly9mL0ZjYTUxU3ByMFg4eTBQV3hsblpvNkl5SjNhZkRZbEdO?=
 =?utf-8?B?YkxrZ3h0cUFrZ005UVFha1ZZVUdmRVJ3eXVmdW14WkZBdzdKb2JJWTlPSzhD?=
 =?utf-8?B?dGNVVVQzaHQxN1B2WU1JeGs1a2o5WVlwVDhscUx6NTUrN3FNYmsxOEROY2kr?=
 =?utf-8?B?MU93Wkx4aDBrS1Jzc3U1WjhKQmtZY09CbTFwRFVxeW4xVzBlUXFxK3orZFlK?=
 =?utf-8?B?ZXhvaWZPUVk0SFZaQXhRL2hXeDZGSTdvcG9SWnduaG1ydDN3bkJjTHVjTFFZ?=
 =?utf-8?B?VE94Z2pXS3M0clpEeEtSZFZxY1JMZE5PZFM4eWp3VUVJdDFlNW5pZllYZ2Fl?=
 =?utf-8?B?NllUdXRpeTRkVm1UUzYxOTlidVRneUdtUkhTU1pkdE8yT0FSR1JoSHhVMUpT?=
 =?utf-8?B?Y1hSUXg1RWdZUHN0cTVpVjA5aHJEb1lXNjZvUGhUTnY0ZytPQkJsN3VqSCtn?=
 =?utf-8?B?TEdybXVvR1ZCbjl1SlpzYmhBOU5aMnpSVFlNQ3VoVmNTSjEzRnk4Qmp3b3pw?=
 =?utf-8?B?ZDRHa3VOREMwelo0dUlwMjBxK3BDcmNyOXZSRXNwNnN1ZGpXVVplNkpNR2gr?=
 =?utf-8?B?TEw3ekt3dXNDZmpnNnJ3V1VKelZzN0pSd3ZMdXE2VGFSamE1Tk9NWEJjL1VN?=
 =?utf-8?B?cVlyZTVCUDJGUEJVWXBHazZHbmNUTVRFQk55YWhuWnNlckk3MytJSEYvYUpE?=
 =?utf-8?B?K1RkWFI0UDJhY0hGY2ovOEhmUSs5a3BqOU93N1BxcUZGb3ppUmxBb1REYkdC?=
 =?utf-8?B?SmN6U292TC9vSkp0bjcvWXU0a0MxeWV5bzFXRFpQL1l4WTcvcGMvTlhYVDRT?=
 =?utf-8?B?Nm5HRUVucWppT2RqVjEvVThDb3lvUzdVd1BEdVZQL2QwM2pYT1grTnlUTk5R?=
 =?utf-8?B?U09kck9Cb0oyaUNNMk42TEF4QUpaU09ZVTNLdWtrUS9FUktrYk9zNjZqaCtk?=
 =?utf-8?B?eUtRWHVjWXZGdDZscDM2L0sveTdURlZmWjZyOFRrMWg0QVpYTDJBZlNXTzMr?=
 =?utf-8?B?UGJZbDI2V203a2hWa09WUEs1MG9YY1B5V2MxSFc3R2ZZaE43Q3V0YStITld3?=
 =?utf-8?B?bmNmZVhER2lMR0oyUFJUekdGT21aN2hNTlZCR3IyNHJyUTFYT3RuN21NYlQ4?=
 =?utf-8?B?dkpLNmVZeUVQd2ZwdHZTNTlRMXNZcVZvYmZadEJhTERFS0FPQXpVUFlTdnVl?=
 =?utf-8?B?SldSOEk5Wm9La2U0QkpOaWhLZHdxYkFDT3JObHJIbEw4UWE4VE1VS0NsMFNE?=
 =?utf-8?B?dkNuQ3BkeHRFU2FWc1AzVHRKUnJsL1Z0RDRmS3NsM2p0UXl0cGlGQnRSR2dq?=
 =?utf-8?B?eCtuMGw5Z3h2czVnTGpiNzdnN3dwSGtBUU9Ub2VGSGU4QXZjUGJQVGxPVzRZ?=
 =?utf-8?B?UlVuZHlXQ29ZLzgyYjB4YVA3ZDJySmpMa1dHZ2RPaWU0UVVWaXVFZFliZ0tk?=
 =?utf-8?B?ZmxneEtLam5LOTI2YjF3TW5rWDJ4dzVPcGdoRlB0MEVBeFpHNFNqdjJIUkxC?=
 =?utf-8?B?UlhzRVE4RnFTZW1UbEZRNDRzakxsMFk5UlNlRHJRL1JkdkpjYkkxSDhsRWk1?=
 =?utf-8?B?TmVSRTJRWGhTcytEbm5rRjkvTmRqS1hXbGlaYmpMWGMxSHM0RFRXNUJpVllm?=
 =?utf-8?B?VTJqS0NvRkhuNndtcXlGTFNBWDdEdVdsNzJmQmNTdmxtVEF5TzdESFdHZ29H?=
 =?utf-8?Q?tpebaQ40J9E5AJSRv9Zk1UYP0hsr4kxC6RbnE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFlEQk4zTkNRNEljL0RpWnNzYU4rdklVQk5yL1ppN0hQN1dkTnFkOW00S1pZ?=
 =?utf-8?B?WW1sRWZzOEcxN0h2VGtFL1lzOEFhZWdHZXJoZUlpR0NKRTY5YnFEWGFWVEk1?=
 =?utf-8?B?NUpWTkVJbkdQbzdWSDhaUERoM2oxWGcyVHcxYVkyN3h3WVA5ejRTSnNyaWsz?=
 =?utf-8?B?TFd4VkRIVzRuaVA2bTJjc1NYVnp6Uk83MlZxS2VtRnBYbHh4NExRdTQ4VDNa?=
 =?utf-8?B?QVBIN1NndVEwUXo3VmxOeW5pY0tURjIwTzhOMVJacU5BN1dVME9UY0NUb0RP?=
 =?utf-8?B?bFZ6b3laRGFqZ2hUcWJSUDJmMmRUWEtZamZCd2phTFg0ZytLWnZTOGdZOHVG?=
 =?utf-8?B?U3EwRGpMa1lGNXdNWE1QazB0clZpeXRxUGdaYkhQa3FXMVdHMjgybU4xRmtU?=
 =?utf-8?B?clZGQ0ZudlF6bnAyYmVQWG5rZHA4YkZpUFdRVUF1YmFDMzZKT2xuMHJsUkxE?=
 =?utf-8?B?ZytIL2RkU3BKK3N5bEVDYXNUM0REMUlwTURoR3FVYXA1ZHdKTlVaNTFMYkc3?=
 =?utf-8?B?czhabk5zeEh4SzI2dkx5U2FpUEtMb095elp0NjJQRE4rVkpmbWdwYXdZWDZv?=
 =?utf-8?B?VHVaM09QYjFNRlJINnovcmY3WGVQRlBvdlYraTUzUWlGYXFGUi9JSVRRMWtD?=
 =?utf-8?B?bVoyOW5ldEM2eWVDWTM0Y2x2bS9leGtIVHpuUXcveU1qWWlHR3NMSXJwZzNp?=
 =?utf-8?B?OEZOcTc2MUJZUzVmcXBTVjkwdlYvTlAwdm51WHFrNXFnZGF0bS9nKzZ5M3ZY?=
 =?utf-8?B?ZmF5ek1jazA0S295d0tRMWV3T1E2dThnSE5nUkQwdHRNbzg3eEFrd1piLzlk?=
 =?utf-8?B?OVFZYzhVUnBPRlo2WkdreTBLSDFSaXpiZUROcW1uSnVVS3FFWkRpOXU5TzAy?=
 =?utf-8?B?aTJWQkFWN294M3RCOUFVQ2o3K2NsaXkvOWJWRW0xeXhJSHZDVEo1VTU3dHdx?=
 =?utf-8?B?TlYvUFBXaTlQZGlWcmdzRkVtRmRhUnpubW9JMHpKbGJKcW1OZ0NFM1NkdnRH?=
 =?utf-8?B?Yi9MVkEwNDFQVEtMaWxVWllLOTErV2tWOTVNbWRsUzU3Z0NOdXk3RE0yMUpT?=
 =?utf-8?B?N3RTbUthS01yd3VNb2ZQSXRTK3YwTU5MS2pkNXNnOUV1cFJFM1VMNnRwcTVE?=
 =?utf-8?B?eXJrM2RpL0JBZmlVR0pmZEFiTldOVjNaaWdxbU4vVk9KMUdEZVZqSHBPemNG?=
 =?utf-8?B?cnN0clhzWExNVXJiNzVkUVBwRHMra2s5RmRZVFptemJsNUpRa0tvem0xUVFZ?=
 =?utf-8?B?NDBKRzMrUk1nS01tcnpDQndpZm9TR1owVnBtMThjNUlkTHhUM0hwUEN6U2Nj?=
 =?utf-8?B?Q3lidHA0MlZLdm41UTBLOTVCd2dzNnVMNWhuai9hTVpVcUxmQ0NsTUV1dWdF?=
 =?utf-8?B?MmFxclVYd0U1YmwvRWxZbGFucGtPNXZ2Ynp3WXZuQVZScGdvZjI4bHJFclds?=
 =?utf-8?B?T0JNVVBndzZtL3RJa3RydVQxYjRnbjdBR3BKTkMwdnY5Y3dRQTdXcjJ0Szh5?=
 =?utf-8?B?UUpjWStOS2xicXc2ZTJ5RG5jcy9jQ29RTk1tc3ZRV1pQOVg5bUd6WEhlWEp2?=
 =?utf-8?B?UlZrT1huZ3VYQWpjbUJGc3d0QllJZlRVdGtpOFo1NmliL29uQTdSMU92QWhP?=
 =?utf-8?B?SmI4eWNmT09ZQXh3akxwZVMzSStBdzVJbzVuSFlac1ZSanJpSWNtSWtmUDE3?=
 =?utf-8?B?WW5NVXY1dGNyb29zZCtqd09OV0MxdWpJWUpwVkZiWVRvZmtlZllnVnMvbWVJ?=
 =?utf-8?B?VmpRaXhjbkRFd3FWQU9xc1FWdDdnVVFBck9yZ0cwbWc0Q3JJajlTb1c2Y2dv?=
 =?utf-8?B?ajZYMXV6dVhZVE9OMFJORURteWliMStMSEp3MjlKcjNKbm9pd0Flc3MxbEds?=
 =?utf-8?B?ODZydGhnaG9mK004K1dWRzJoZVl3OGhoRW5CTVhQdWZmek1XT3R4c1BTOWtz?=
 =?utf-8?B?Y1BscDQ4QzhQWTFWZzEvOE5PekwrcGxrUTZlampQSThVMWRTNEN5MTZWcTAy?=
 =?utf-8?B?aDYwVTI0QlUyejdHbXVuUGE4Qld3WFV3WnpWaEVrVXFOMWNKUjNHb0s5Z2FV?=
 =?utf-8?B?bndrSG5UUGkwalJydXpRQ0VFT3I4aHl6bkRTUjRKM3N2OGFmUGJteDI1bldL?=
 =?utf-8?Q?Av88/phrAUWskBD8t2DwWmGiF?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eed4290-1b50-41fe-b0ea-08ddee47cfd3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2025 19:50:35.5322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNvQhbXDK5bDijDV2iqH1Nj4HaaX44Rv1guN0kObSN4Vazx+pnswuPwBQIzLGX3D578nuGOl7/iYvOuUYHPe7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB7965
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=jan.kiszka@siemens.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=2.131, SPF_HELO_PASS=-0.001,
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

On 02.09.25 20:21, Jan Kiszka wrote:
> On 02.09.25 20:09, Philippe Mathieu-Daudé wrote:
>> Hi Jan,
>>
>> On 2/9/25 19:47, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> There was another mistake in the size check which 8c81d38ea5ae now
>>> revealed: alignment rules depend on the size of the image. Up to and
>>> include 2GB, the power-of-2 rule applies. For larger images, multiples
>>> of 512 sectors must be used. Fix the check accordingly.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>
>>> Not fully tested yet, but as staging is broken right now, I wanted to
>>> provide this already for early feedback.
>>>
>>>   hw/sd/sd.c | 48 ++++++++++++++++++++++++++++++------------------
>>>   1 file changed, 30 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>> index 2d34781fe4..0f33784bd0 100644
>>> --- a/hw/sd/sd.c
>>> +++ b/hw/sd/sd.c
>>> @@ -2759,6 +2759,26 @@ static void sd_instance_finalize(Object *obj)
>>>       timer_free(sd->ocr_power_timer);
>>>   }
>>>   +static void blk_size_error(int64_t blk_size, int64_t blk_size_aligned,
>>> +                           const char *rule, Error **errp)
>>> +{
>>> +    char *blk_size_str;
>>> +
>>> +    blk_size_str = size_to_str(blk_size);
>>> +    error_setg(errp, "Invalid SD card size: %s", blk_size_str);
>>> +    g_free(blk_size_str);
>>> +
>>> +    blk_size_str = size_to_str(blk_size_aligned);
>>> +    error_append_hint(errp,
>>> +                      "SD card size has to be %s, e.g. %s.\n"
>>> +                      "You can resize disk images with"
>>> +                      " 'qemu-img resize <imagefile> <new-size>'\n"
>>> +                      "(note that this will lose data if you make the"
>>> +                      " image smaller than it currently is).\n",
>>> +                      rule, blk_size_str);
>>> +    g_free(blk_size_str);
>>> +}
>>> +
>>>   static void sd_realize(DeviceState *dev, Error **errp)
>>>   {
>>>       SDState *sd = SDMMC_COMMON(dev);
>>> @@ -2782,24 +2802,16 @@ static void sd_realize(DeviceState *dev, Error
>>> **errp)
>>>           }
>>>             blk_size = blk_getlength(sd->blk) - sd->boot_part_size * 2;
>>> -        if (blk_size > 0 && !is_power_of_2(blk_size)) {
>>> -            int64_t blk_size_aligned = pow2ceil(blk_size);
>>> -            char *blk_size_str;
>>> -
>>> -            blk_size_str = size_to_str(blk_size);
>>> -            error_setg(errp, "Invalid SD card size: %s", blk_size_str);
>>> -            g_free(blk_size_str);
>>> -
>>> -            blk_size_str = size_to_str(blk_size_aligned);
>>> -            error_append_hint(errp,
>>> -                              "SD card size has to be a power of 2,
>>> e.g. %s.\n"
>>> -                              "You can resize disk images with"
>>> -                              " 'qemu-img resize <imagefile> <new-
>>> size>'\n"
>>> -                              "(note that this will lose data if you
>>> make the"
>>> -                              " image smaller than it currently is).\n",
>>> -                              blk_size_str);
>>
>> First, no rush, your previous patch didn't make it to master
>> (CI failing) ;)
>>
>> Again, this painful restriction is due to CVE-2020-13253. Per
>> merge commit 3a9163af4e3:
>>
>>     Fix CVE-2020-13253
>>
>>     By using invalidated address, guest can do out-of-bounds accesses.
>>     These patches fix the issue by only allowing SD card image sizes
>>     power of 2, and not switching to SEND_DATA state when the address
>>     is invalid (out of range).
>>
>>     This issue was found using QEMU fuzzing mode (using
>>     --enable-fuzzing, see docs/devel/fuzzing.txt) and reported by
>>     Alexander Bulekov.
>>
>>     Reproducer:
>>       https://bugs.launchpad.net/qemu/+bug/1880822/comments/1
>>
>>
>> Reproducer being:
>>
>> ---
>> #!/bin/sh
>>
>> cat << EOF > inp
>> outl 0xcf8 0x80001810
>> outl 0xcfc 0xe1068000
>> outl 0xcf8 0x80001814
>> outl 0xcf8 0x80001804
>> outw 0xcfc 0x7
>> outl 0xcf8 0x8000fa20
>> write 0xe106802c 0x1 0x6d
>> write 0xe106800f 0x1 0xf7
>> write 0xe106800a 0x6 0x9b4b9b5a9b69
>> write 0xe1068028 0x3 0x6d6d6d
>> write 0xe106800f 0x1 0x02
>> write 0xe1068005 0xb 0x055cfbffffff000000ff03
>> write 0xe106800c 0x1d
>> 0x050bc6c6c6c6c6c6c6c6762e4c5e0bc603040000000000e10200110000
>> write 0xe1068003 0xd 0x2b6de02c3a6de02c496de02c58
>> EOF
>>
>> ../bin/qemu-system-x86_64 -qtest stdio -enable-kvm -monitor none \
>>      -serial none -M pc-q35-5.0 -device sdhci-pci,sd-spec-version=3 \
>>      -device sd-card,drive=mydrive -nographic \
>>      -drive if=sd,index=0,file=null-co://,format=raw,id=mydrive < inp
>> ---
>>
>> I guess remembering we fixed this one then another path was fuzzed,
>> so we audited and realized restricting to ^2 was the safest option.
>>
>> I'm not against unrestricting the model, but I don't want we raise new
>> CVEs. Users adapted truncating their images to pow2 and accepted the
>> downside.
> 
> Problem is that this was completely wrong once boot partition support
> was added. I agree that we must not expose more disk than there is
> backing for (which was to my current understanding the background of the
> CVE), but we need to use the correct rules for that.

To underline that: An 8 MB eMMC image with 512K boot partitions will
make the guest recognize this as 8MB - although only 7 MB will be
available for the user data area. This is apparently only causing access
errors for the guest now, no longer out-of-bound accesses.

> 
> But we probably also need to check if the backing disk minus boot and
> rpmb partitions is not smaller than 0...
> 

I've enhanced my original size-check fix accordingly and will include
that in the next version of my series.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

