Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF8DCA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 16:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utUFk-0003ES-9k; Tue, 02 Sep 2025 12:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1utUFh-0003Df-Vu; Tue, 02 Sep 2025 12:53:02 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1utUFf-0004uB-D5; Tue, 02 Sep 2025 12:53:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVe5e07/xyE49LQXkQok6Da5rn7iqY8TDjE7l98ewUtrEmBvpn+5lMtjN/XF66enq/CucVkps8S2e/FrLAjVb4tZDIwTtfkCiHyuTMLvnzm7NZ33dNbwCXWoi7uDNEcjaoSjVOl0S+HjqIe8vAYskF5diPFftVoVhW1UD0JH/INlLseEyfYxMGEFiOlG0ifKnwH7chOWPcBW44L6KofQUr9Q/91TxIJqYX1/JaPw4yY9wIu7FDwJT1v5Wy4drvrZgVSWkqsMD5LKnH5M3jeayeSWwqTblQ5PRpU88HVkDFLsJgKt1PVE7uuNcr6JXqi/JUfkRdcwidJrt4FX6dvMhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLopyYUncNbDKe1x/rDSz5FjpbL8kRXPQVuBpfWTDKQ=;
 b=qBhKpHMHg77TC+Jh3VBI8362DwWKn/fepHS+mLlco+jTvRbgiZDP4fKgw3KpySpDezJFtNaEgGM2EF5QSscYapl28WNK+/1wZrqIBB4syVC31iW9hoPQIaA+dOuyxj6ro0XR9dBdMuqvn4QtWy8acLvyKLNqB3deMnIvb+U14vqozFGqQdzp9vpFrKDrGCOFXizl6+RAbEoQU01rRgHelf911B+DUIru8Rh4dfgXPL0knOifNkTejHx8aOcnGpfgqk5WJarPQ6TkSS5JmZv+qPY0qB1eofvK07mLI/6vTTM88MoB6WFvHwuntq5JI1CpVhGklZvBu9MVc3Qxfm6B3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLopyYUncNbDKe1x/rDSz5FjpbL8kRXPQVuBpfWTDKQ=;
 b=UQr3WSrhrCkAMzJwS8/7WWkvp+3EUkXO/e2Sgp3Sd3D2xkCHCNwAtaI8HBRFSfWYQwqrHugMtIahemocQzrNJIskNV2Hgmi5h28cTavCrWw7wTkpQx2cZ4NfjyQoY+T3OfFCLqf8ZU/ZPXcwxUFssisq0cJAhpIOXLAE8i6ruVHCdG1WEJiFbt2jn5WhY0NgODTB9V4kmx9O6gFUv899gddPTMvHv75feFxkaVj7cn1Bw19t9zxWGkm1hLojuIrbSaTf2xtzcKm/4B243SsCz6555wZVz8+qL3fAZYEi6a3kCEcc21E9gYdCEgaDytISk4bsAaF2sq6uC2nZu7KFrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PA2PR10MB8651.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:426::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Tue, 2 Sep
 2025 16:52:52 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 16:52:52 +0000
Message-ID: <c2722e53-87a8-4b16-8f7d-4a370c4c5b46@siemens.com>
Date: Tue, 2 Sep 2025 18:52:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] hw/sd/sdcard: Fix size check for backing block
 image
To: =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-devel <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair@alistair23.me>,
 Alexander Bulekov <alxndr@bu.edu>
References: <cover.1756706188.git.jan.kiszka@siemens.com>
 <86217712232abd5152e7dfa98111f57b9b78d83b.1756706188.git.jan.kiszka@siemens.com>
 <6289fe04-82be-4a34-9fed-b0cc08e3b8f0@linaro.org>
 <a9fdf524-0ca1-45db-be39-7bfccc468f0f@siemens.com>
 <11808e86-cee0-48bf-8fbd-de13a9a25ed0@linaro.org>
 <4c039b3c-dc2c-4478-b1bb-90b925e56245@linaro.org>
 <c8e1a073-7702-4bad-b7f1-2b4f51da47f4@kaod.org>
 <03a51e36-9a15-4b49-a310-c36a4d0af360@linaro.org>
 <2abbaeda-f9dc-4045-a9f7-b2b48451255f@kaod.org>
 <42310bdb-4fad-4df2-b7ad-3ff3f863e248@linaro.org>
 <d21f6449-e646-42fc-8277-b011a886e9c9@linaro.org>
 <41d2e67e-3345-4720-b3aa-1051224025de@siemens.com>
 <21b6726a-1ceb-4782-a219-36f32cebb774@siemens.com>
 <a1463f9e36d8b3e6289859bec9a0a5a758709316.camel@pengutronix.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <a1463f9e36d8b3e6289859bec9a0a5a758709316.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH3P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::31) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PA2PR10MB8651:EE_
X-MS-Office365-Filtering-Correlation-Id: fd51d8c7-208e-43b1-bebc-08ddea4127f3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QllBSnhkSHkxejN0M21aOWdnZlNmZC8rL2RnRFpzUkxjTStvdVRtaGg3cnRE?=
 =?utf-8?B?Z0JMTm10U1UxNDZqMEhzZE12Tm41Mit2RTFRaE1MMW1PSndZVTNnR1B1dE5j?=
 =?utf-8?B?U0U3OVB2RFBUZTBxT1hPTEZGaUJtZFRwV21VL3dsd09JSE1PWFBoT0VGbjZU?=
 =?utf-8?B?WjJWc1loTVVXeEhIVVR1ZTF3STBTSnJaVUl6MXBNTlQ0Sk0zWFRPZVZUbTZZ?=
 =?utf-8?B?bjdBVytHd25xOEpWYWtUZVMzbHJha0dIcGFncDdxTkpkY0Z1ZCtmMDUvYmV3?=
 =?utf-8?B?ZG81RE9Tc0ZLb1RGR1M2ZTRyN1FGcXU0WCtmVk1zVVJFcW1nZE84a1FHLzRQ?=
 =?utf-8?B?WjhyUnhvWGFUOHBsSi8rVnl0cEtWekVzREU5RURzYTNSWlRkMUNjZkVzVWpS?=
 =?utf-8?B?N1JiM1dVWG1qNkY4ZlpmM0paYUpOL1JyYlF6S0RsN2EvNmZ0bW1KekQvS2lj?=
 =?utf-8?B?NkZwMkpYdXQ4aGJiQmI0eVVPZXNYN3NFa1lOcWdDM1FwSHVmb2dpNnpRL3Zk?=
 =?utf-8?B?Mk1qM3dieE80aXAxZ2tOZmx3V3QrUnJKOVU0dTZRcitZaldGRXI1TXVRak1S?=
 =?utf-8?B?bjFtMnVMYkFINU51OWpab0FTQmpvdkVyeDBMVjU5WkU1cGk1dmtzcDVqU1dP?=
 =?utf-8?B?NUU1bXRDVDBtR1JXc2tnYU4zUVBvUWlwTU9hRmZVSVZxY0syMnJSdWlXQXJZ?=
 =?utf-8?B?ZUJwQVdMeC9NeUk0QzBNdVJXR0tIdzhoTUx1Rm1CckEwMFRqWkthenAzU2pJ?=
 =?utf-8?B?SVJPbUU0STZxNzdxajZCWFpMSzU1M0d5S255M2kxMGxPV2hCS0R0dloxVWZM?=
 =?utf-8?B?MVNjNlNpUTJLSzdaZmNVV0dBSFExNC9FSnBrWGNzZDZ5SjREZjBTWElMbzFs?=
 =?utf-8?B?d3JnTkVzQm9GQit4SjRqU0gvMWwwa2M4d2t2ZnBiZE10Nmw2Wjc2dkZRRXVq?=
 =?utf-8?B?TGx6aU9EUG1OK1NmRHp3TENGSC9uTElMSUhvOW5BVzQwOWpETkRPM3JmQTN2?=
 =?utf-8?B?TmFrWEtRWUFTeVFQM3pYMEFDcWZBN2xQaEVIMkxBKy9lUTJvRUpyYkx0QnJB?=
 =?utf-8?B?OWU4YUJkN3NhNlpCNUlCaDdUWjAwV0YyM1RkWnVKdE84VTJubTNIKzIrT0wx?=
 =?utf-8?B?MXNQZitIV0JhYlZhMUxIb3JXY2laMk93TnZoUStyTWlZS1VrTnM3MldybXht?=
 =?utf-8?B?NDNwVTR1SzFzRDg5YktuMFFldlB4Q01NTHVmUk5DTDRmK1c5M3RrM0U0ZmdD?=
 =?utf-8?B?ODh5RFpjVUVRWXZ1Wk8wT3g0ejRnTFpoVVdnLzN1TWhxN3JOb1ZkTDNSL2NL?=
 =?utf-8?B?SUJMc0NRRjlWVVRKQ3hpY1RhSVp1ZXRyZ1RseGtzc3FJRG55TjRuK1owcVlq?=
 =?utf-8?B?VlRKdkk0MUtKdTM4Mng2QnN0S3ozY0NSelc4UXRKTmlxQlA5WUZyZ01ORE5o?=
 =?utf-8?B?M0VzUThnc0xpOEJLZEVlMGRkb0ZqQ1RKMTd4V0V3K0VvbjVEdE9yV2tWSy84?=
 =?utf-8?B?TWhRamloWWlQcUNSaVFkVkZCMTd2ckFQc1hCUlFMZjhOeGJMclU2eVhMeE5M?=
 =?utf-8?B?blJEbllPYmd2UE11NVh3Z1B6Wld0NXJGS2NYVS9ENG9qa3R1QlNYaDdDQi9E?=
 =?utf-8?B?aHZxcUpWeTkvdzNTOFdTQlZ0NFZNM1dGZ0loUlZQRS95b3k4R2pNbUlCNnlM?=
 =?utf-8?B?SzF1VFNCSHR2dVJOWWk0WFl2aC9Hc1ZuanJSZ2hZQ3lVMkNCVHVGWnZnRVhS?=
 =?utf-8?B?M2tlM045TmhxUy85QXlFamVHT3ZEMVF4bHErSFd2NmRMa0wyVG5iTnFER2x6?=
 =?utf-8?B?d1NHdkM0YVZnTWFzME5EZGdCVk9XUWNtaGZXZ1o3aEE1QnhXTFNxTEFpY20v?=
 =?utf-8?B?Mm5yaFFkL2Fkazl5RVhLUmIrM1JCMWY1bGo5ZCtXZ3Z6K3VVbUNBQVY1c2Zw?=
 =?utf-8?Q?hejL5XQxMKQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUZ6SFNnS2k4VzM1QWR1REJhNTMrNnZtNVFuN2U2NU9MQnVGOHIrM3pYRnE3?=
 =?utf-8?B?TiszTVNkRUx2L1JGYUlKRVo2S0VxaFZ3emkwVzNCc0d0Wjd3U01yTUZPRnBl?=
 =?utf-8?B?K21Xa2ovaWN4ejRqVTh1WXBNYUhueWlOS2dCL2tHbHhVZyt4YXI4OG5sWGlv?=
 =?utf-8?B?NHZWVU1MWDA1N2VQeWlRYUM5VnJuLzRjM1dtaFA3MG10d2IwMHRvQkZkNzlh?=
 =?utf-8?B?cFJ3eDdxU0NPcDJxWUJ1WkdJTE9LelRiUDJCcUk0SWpVeE42ZE5UcWJKK2dY?=
 =?utf-8?B?cC9qM0loM3BxcytBZVh5aklxMHlDZHZrQnJFVlZJZDJsRHhGUDlneWFVK1FI?=
 =?utf-8?B?TjBoVUkzL3lYdmhpWEtVQ2NZY1dDak1GYzhxYm1sK1c4Tm80dUQ1dHQrL28x?=
 =?utf-8?B?dmNzMXZmVE00eVo4MGNITVg3UEpoM1NCMzAxQ1N0YnowZEgxdzdNemFheHpP?=
 =?utf-8?B?ai9rai9KZVhPSnJudmV5ZXhIZDRmaEsreDZlT3FyRm9yaUM5RlZvd05xc3Ix?=
 =?utf-8?B?Q2I4MUlTMkJJSlB1YldzWlpZTGVscGRaVlVyNUdyUFF2NngxNWJKYWZvYVRH?=
 =?utf-8?B?SGlCQ3pNbG9lRkNlbXFsbXdFcnFQUVd6VHJzTzZYdnczWUVDYVJYN1JReHRQ?=
 =?utf-8?B?OTNaekZqRXVhT0Yycm0ycHNFaWovYjR2L0NoK3RZby80Y01JaDhHT2x6WlNy?=
 =?utf-8?B?YnRGQU4rY0Vnc1k2Ynd1ejNYWnRma0IwdUJqWWlrVEYzN3V6VDFoN0FEb3ha?=
 =?utf-8?B?eVBQNkRhYUlZS0dkeFY4SCtGSERFYmhrRjNIcCt5NWg0MytaeGQ5K0JMb29t?=
 =?utf-8?B?NVd3Tk5zZCtlMXZzRWxPa2FuMTlqYTVLNmxXQWNpRzdwR0JUV0pxa3ZPb0E3?=
 =?utf-8?B?WWFJN3NkTnE3YTA4ODE5YkhQMEt1YlY4WjJVYlcwRDdLdGQrek5hVzgxSk9F?=
 =?utf-8?B?NXRESkFKK3Z0UE1oYkNOdUpjR2g5QmxEZWlJLytsVXJZR1BXQWF3dTE3aHdu?=
 =?utf-8?B?ellmdDNqUnBKdWl5aktiMFZ2QS9mVllSRElpSTBQTXRLSFBMVEtyRjhmMHUr?=
 =?utf-8?B?YzhQUlZCZkhlL09SbjdQNHRpYWhyR3c2VStNaEhxKzhRd0wxRnRkWnRLdVNk?=
 =?utf-8?B?ck8wd1ZqWmtzSFRpbnQ4Vmtadmw3bmZjOHhCTExlMEVhcEhPM3VhakpHclB6?=
 =?utf-8?B?bG5FYzVYWVRFQ01CQnJKSXBONzgrZ1BXcWRxMlJxdWRGM0MzY2ZiRThrQ3hZ?=
 =?utf-8?B?K3F5Rk9wSk5oSm4rWGRmM2Fsb29zcXRlR2lJU2VLdUkrK0Noc0NhWDAreDZ0?=
 =?utf-8?B?RlZsWDRXMGFraXpXMUVJdERNVlY0bWtCZ2hDdGVFcFl6THQ3WE1IaE9teHcy?=
 =?utf-8?B?WktJVVJHRUs4bmk0RnBSaDBjTzdPRmd1UXo0RDdpbEtOTysxRVIxMU9mRVFj?=
 =?utf-8?B?THFIc3E4STdabytxbDA4bS90b1JZWWZHS3c1NDYxRDNZejNtQ3ZJd2V4ZHpk?=
 =?utf-8?B?R3VuZTM0T3Rjd1VabnFlY1lxM0RZNVlEVlAxaXBWNktEMFdKQkJTL2l2R0Nh?=
 =?utf-8?B?TUZpNFJKVHlqN2VkVEROM2VqdGRRKzU3TWxLUjFncnYvVy9RU0w2UHpDcFNz?=
 =?utf-8?B?MzdkM3BOcXFZL3RiNlc1Y25US2krOEJ5R0Z4b3ZXZER4SklubSsyaGVlY1BM?=
 =?utf-8?B?NHlsbDRseUtib0x2MDBmZUxaTjNyeE1KWlVIMlRNbjZLdFljdTNlM0lraXZJ?=
 =?utf-8?B?YUF5cHhtcHVoQjBRWjZFNjRqYnpwOW96T0JiNkhyek9PLzk5VElQMGpNS2dU?=
 =?utf-8?B?MGZPTzhKVm1PdWpYeDI1eUZhNXREZVd6a2lzTzJYN0hCZGlGZU5LMEEzVldJ?=
 =?utf-8?B?UUQyTFFONTFnU25rZlJuZzJHV0huNGZjL2pEVGFUUUVmQzNmMXVXQUNHb0lO?=
 =?utf-8?B?TlR1Y3h2dFlJNjFsVFpBWnNBYmthbWJMY3lFTU9FbmVqN2lMdWt2eDZCSjdU?=
 =?utf-8?B?dWoramZnWG94eXk1czNzaCt1azJudzEralFQc3FpMlRwRGM2NmpJWmJSYjNj?=
 =?utf-8?B?NUV5OVd0cWMvTmFaWjZSUDNLMkVabW92ZHEzUGVnZ294OXJqdlJoSmhaNVJ1?=
 =?utf-8?B?bnJaeGl4QTFISGxrRUIrd0lmVkQ1S1BtNlJsNHZOQnNWRkw4TWFvc3BjUjVX?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd51d8c7-208e-43b1-bebc-08ddea4127f3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 16:52:52.2870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TCm6dxbqIEHNOiwNjD019kuU+ZL25AwckhuCoq+k8+9DQARm3rPy1Zz48i6YDKwPmBtFPClCfK+Sopvlx6HlBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8651
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=jan.kiszka@siemens.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

On 02.09.25 18:47, Jan Lübbe wrote:
> On Tue, 2025-09-02 at 18:39 +0200, Jan Kiszka wrote:
>>>> I expect us to be safe and able to deal with non-pow2 regions if we use
>>>> QEMUSGList from the "system/dma.h" API. But this is a rework nobody had
>>>> time to do so far.
>>>
>>> We have to tell two things apart: partitions sizes on the one side and
>>> backing storage sizes. The partitions sizes are (to my reading) clearly
>>> defined in the spec, and the user partition (alone!) has to be power of
>>> 2. The boot and RPMB partitions are multiples of 128K. The sum of them
>>> all is nowhere limited to power of 2 or even only multiples of 128K.
>>>
>>
>> Re-reading the part of the device capacity, the rules are more complex:
>>  - power of two up to 2 GB
>>  - multiple of 512 bytes beyond that
>>
>> So that power-of-two enforcement was and still is likely too strict.
>>
>> But I still see no indication, neither in the existing eMMC code of QEMU
>> nor the spec, that the boot and RPMB partition sizes are included in that.
> 
> Correct. Non-power-of-two sizes are very common for real eMMCs. Taking a random
> one from our lab:
> [    1.220588] mmcblk1: mmc1:0001 S0J56X 14.8 GiB
> [    1.228055]  mmcblk1: p1 p2 p3 p4
> [    1.230375] mmcblk1boot0: mmc1:0001 S0J56X 31.5 MiB
> [    1.233651] mmcblk1boot1: mmc1:0001 S0J56X 31.5 MiB
> [    1.236682] mmcblk1rpmb: mmc1:0001 S0J56X 4.00 MiB, chardev (244:0)
> 
> For eMMCs using MLC NAND, you can also configure part of the user data area to
> be pSLC (pseudo single level cell), which changes the available capacity (after
> a required power cycle).
> 

Then let's fix the entry check - the code setting up registers to report
sizes was reflecting that already.

Patch on top, right? Staging is not rebased for updated patches, is it?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

