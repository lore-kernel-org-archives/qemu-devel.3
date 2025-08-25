Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A9CCA0FE7
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 16:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqZoZ-0003dH-Rd; Mon, 25 Aug 2025 12:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1uqZoT-0003c5-79; Mon, 25 Aug 2025 12:12:53 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1uqZoL-00064I-TX; Mon, 25 Aug 2025 12:12:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=woUfxFs8hEQJd8o1HbIf3JPfn4S81M88rMsA72BdpoOKHhdgiNMC5ch9Jq2h3C0DSgorUUJtxmuVcVrcXX/eKu1paKTZz0gZHkUBDLJXihtJT1WfI4v58KM3qH8qeH0uGSlwgbl0zMjJXkUOwcPDZZR5tyz3P+ezeTxBAK/DwOV0RJeeyqgb4Uv1J99QezrsUoKkAafBIEwzlh6Xh/s68CLpCWYainGKekti8f9biX/GZXN9dnI4zOf5Qr9D2WEnnpcZV7Ou4HkK4ifaPB0Bsn3mefJGx1sQWx4dUlhl0i5MW1JZTvuXBOKBmCX3L15TCf9TbefTmcpCd+NDibULtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqS8oJYShV/Y6aBFGYr5sMucW6RWXJdAeacNZazNKTk=;
 b=FlSfFVDvXpZ5tOhAdYvuHwiuWJZuFURdSJ/SZwMrx9MOsXEEyoIajLO3keVkrnby6SM4h+QOAqFzB9vaxy/4Yj1xf+k5Bw6Vc6cA168HhP28Zrv3K0KCPxf3AhofQ2FPe8BSkrTwTyvkC4XRVB9umwKw4oSVw4g7Wv2ByBTtQFklnrSfOpuZvHR8flAFWNlEJu8HFcD4KIfo47HzpS1EY6DWV6SZEHGI5SHdMQwfHdUxtJgbYUYahpk8OQnfxCC/Rv7n8PXzagyvdqgVghePgqvzZQP05tPQoqdgrT3UaLydRzOZbp5euB8O1KJrXmMtAJtXQQujwIjzP/XmV3yfiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqS8oJYShV/Y6aBFGYr5sMucW6RWXJdAeacNZazNKTk=;
 b=tnosGzkDIuw7K9DtLvF0IG9QbEFkWSP+8n7KV5iYqiezuJu7TO1wTEcyV9x+fO75TiOcYodUmwwGgDehmkDXvo/EguP5bVpneoNZ/vIh7Zp+H6ulfYN8rAzMQ8CpDo2bgkKUfXS4GF1GfkTKpITFgSJwxr6n+FrxJBawwKJ7n1fU0xHSNg7WfmwvHRgevIL+ggP5G4BfBQj8YJ7qMGyxXOlVy7vP/DUfkfVoepAzvg0xuvkkV+MVK3XrdkeHi9iL4mOm2vB8AG0jH6WLbKj89kIv4JhT0Faa1ZIyGfzVODjLjx++9a/EaKaw+pOCH203U733X/eUor72yxIqgFCcOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7192.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 16:12:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 16:12:31 +0000
Message-ID: <97fce5d7-eb6d-4698-950e-94d5468d5696@siemens.com>
Date: Mon, 25 Aug 2025 18:12:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] hw/sd/sdcard: Handle RPMB MAC field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <cover.1756019920.git.jan.kiszka@siemens.com>
 <8ea56ae040ef1037e44fc864c159e2f96f23f059.1756019920.git.jan.kiszka@siemens.com>
 <51a9f857-69ff-43f6-8f3d-c7e5d5870c99@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <51a9f857-69ff-43f6-8f3d-c7e5d5870c99@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0205.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: 6955fe70-c43c-4b2e-ec4c-08dde3f23191
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2c4a0k5d20yMzBUVXQ0MnlJL3pVdlhIK2hFY25IbzRxYzdCWW82am40R3RX?=
 =?utf-8?B?aXkvZERFYkV0bUNzaCs5cjE2cUd1N1h4KzBUVHVjb2Z0SXdXVC9pSlY2Rzli?=
 =?utf-8?B?cTdFb2tCK0dmS1RmRU9uWS93a3hDeGRTMGx2Qk9PMnpiZWVJeVU2S1VYcm1j?=
 =?utf-8?B?RTh6UlVYT0hwcHk4WFVGd00ybmU1dWh4UnoveEowbVMzVzdyaTEwek9KbFBv?=
 =?utf-8?B?YmdhYUJ6SmtxVFNDa3F4cEVSOWNZSnNDcEpDL2hQMVl2L3kxNWp0QVJRenhL?=
 =?utf-8?B?ZlpVV3pHem02RkRuOFlHRUZYZzlLc1hHajhielR1TWZ4Z2ZCRHQ2OG1oQVVu?=
 =?utf-8?B?T3NMYS9qTEdBZng0c0xNMGFSMUFGL3JqVzFvaFdHWjJDV3Jlb0RlZ2R2Z21k?=
 =?utf-8?B?UG9JK3NISm8yc3FDb3NSMlZ0SlVpY3pUL3BhMUJha2xiTzk5UjFGdXJMQVRO?=
 =?utf-8?B?RmFOWnByaUVPUG1RTllUQTVCNkhKUXd0bDVrTW9MVXBuZ1pDR1VZaElvM0lV?=
 =?utf-8?B?UGtGUEMxUHNaQVFsNGd4K0w4aGJLM2IyVVFuWXozV1lkVzhyTUdrV0VHOHVY?=
 =?utf-8?B?c25jZ0VnOU1BUkwvQ1dJMFFqZFhnRzI5K05kZ0FLOWZ0dG9vYVRIakJWUmM3?=
 =?utf-8?B?KzI2RXB1Z0orTjU4SjZrNDRKb1dlTVNrdzI4c2NKWlFFMk55R0RVWjUyeXFP?=
 =?utf-8?B?c2JIU21BcWhDandKR3kyeTFsN1BUelVPMWliSWdRYnc5OE1vZXR1bW5NemJx?=
 =?utf-8?B?KzVSK3RpZCtOOUlrZWpiQWhvSGdReFZ2M1BHcFMxdDJiSDdFVnZRV1kxRzEx?=
 =?utf-8?B?VzhNemFoQktoc3IzbFU2VHhnTmxiZjc1WGh5dFlKL2JVdUUxcFJpN1NPU1N1?=
 =?utf-8?B?akVzaXMydUt5MzRjNjJTdU4zMWdVbklaT3VMTEhNQ05tOEwvSzd5cldzV2dT?=
 =?utf-8?B?NUFTNlVLdmpURUFkMTU0SnZqQVVBejFLWm9ZeDVCcTN0dWVVdHF2MVF4U2Rk?=
 =?utf-8?B?cmYxRDFWOG03V3YvaWIxcllXTEIwTlVTUjdHdEQxNTNKdllFTFhFc05FeWZV?=
 =?utf-8?B?WHlNZ0J2VFg2bkgvbUR0ZE9vTkdPNmFsTjJsT28yMXFneU81dUpxSE52SVVH?=
 =?utf-8?B?RzFPbnJDNlhYK3F0R0p6cS8yaTNmN2RxZzBmT0ZhSnpIMGVNa3g4SVdhL0tV?=
 =?utf-8?B?bGhTNEtMUndMRjFMWWMwclFVWlVucUFKRFJKRHlra2tSSDg3ZXY0WmpVMnky?=
 =?utf-8?B?ZlBRd24wVWJ4QzJBY1lCakQ5ZTMzQlhNVXBCZGd2UEg0ZnppMDZ2WW03UjRh?=
 =?utf-8?B?c09LRThFaURrTHRwUlhBL0ptSEhqZWtIZ3pZM3R3VGc2alhkV3VrVmxicGFy?=
 =?utf-8?B?T1VlQmtPSXNMUUw0Y3g3NW4vTlR1UERmK3lFQ2hEaEkvRVVSeERrWUxzNUNI?=
 =?utf-8?B?cjdDVk1XclRCZVNiSVR0RDMzTnhVT2cwN3JjRWx3R3lsUlY5WlVBcXFrV2Nl?=
 =?utf-8?B?TXNDVVdpZE5WZXdQdWtwSDVNQ0xZVDk0a1o2TnovN05oblhXaVIySmJCdHgx?=
 =?utf-8?B?QzE1elY2SGJSWDNJTy8xNnp5RVdGOTUwYW56R2hqZW1tVFpIT0FTdW51THg3?=
 =?utf-8?B?YkVtWnNCeEs5MEdDNzN2ZU1sM3ZYL3hhV0xVTldOOVBYYURvYkVlYWxPcjVi?=
 =?utf-8?B?LzJEVEFWZjhZWEw0R29VVzRaQ05hSHF4STJpQ3lUQ3MxVzQ0TnpYcC9BbXh3?=
 =?utf-8?B?bTArR2RnZXBzTTFCSjhDMllkYTFZTkNUdWJ3eHpFZEdwbExDTG8vUlJMcXZn?=
 =?utf-8?B?OTdtRDFJbUQ1L2kyMEo3dEk5YlFIcTVMTkpoQWVNaGdsbEt6OXBQM0Y4VHNI?=
 =?utf-8?B?OUpta3VtbUpNbW9XU09EdVU2b1NhTGs3VVNHUS9sYVNsMnpQd2twcURlQno2?=
 =?utf-8?Q?8Oy+kU08zu4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmtnNENraHE0ZW1KWGgxTThLMGFXTzRsSkN3T1NFdGhHVjQ2aU5Rck5mVFJn?=
 =?utf-8?B?THFxM0JkYmVCeTl3QWRFa0w0OGc1bjhoNGpMR3o4b01Jb0dBZTRTeFQyWEpI?=
 =?utf-8?B?ZFZPNFZtR1NQblZtUDVpZSs5TW90SWhmU21FUTl5dVpmY0NlNnBjNUJTUTV6?=
 =?utf-8?B?WWtMbFQrWEkxR2hLY2JRRlJsWTBpMHhkMDl0bWFKbzRteDdnRityOHFWY3pZ?=
 =?utf-8?B?YXRWeGc4d2lQQTdTc3l6Slh0V2lzUldyNDVqT1lNVW5XZnJpWnZ1NXhZOWZ3?=
 =?utf-8?B?d0tTaUpEdHBFbEppeHRkbE1haldLeHhITHNLdk5NQnluQVdzb2JINWYzZFZJ?=
 =?utf-8?B?RWswbTdWVXBrcXRIcjhLN25JUUJLNHhSVUllZUkrT0trL3Axa005MmRTRTVq?=
 =?utf-8?B?QTg4NkpEeTFsSU1NY0NWRnY2Z01aZFZTY2l4QjUyOUhwS3p5TEdPUnpVcWM1?=
 =?utf-8?B?Njg0NndpNTdaaGdkWWl4QXhsYW5rd1BkT1VSTmZDcU5ySG9TZmZhY1hJSW1y?=
 =?utf-8?B?M04wTTFOcVJGUGtvOWt3anNqelNhZWtnKzBsK0xvVFFLdG5SVE9EQlRwU1ov?=
 =?utf-8?B?dG5XWE90QlQ5N0hZRVBBOUdGSyt2cUUzdXJkcWo2R05ValNlcTcwUFdUdXBH?=
 =?utf-8?B?RGV5M1dtbEM4RVZHM2VLeEx6NUZJNjJGUmQzOFBSSDNYbzAyQVFSU3BxWVBs?=
 =?utf-8?B?clpUbTNDREhmL2hkZldKclJzTUNRZ3JBOXpVSjRtb1ZYd1daeDNndi9kcHpF?=
 =?utf-8?B?amF0bkhJUldpUEJFM21Xa0tLYUFzdEUzRitQUlNLU0NJOEZpTkVLeVNoMmdC?=
 =?utf-8?B?ajU0TzdSV1BaSnRVSTZtUHNNdVBtUjZ2RWdBWWpRTmlHZDdWOVBhUjE3MHRa?=
 =?utf-8?B?RUVRbjZKTDJvWEZOUlJDWUdCa0s5QVkvbmhESHd6MzMxOU1TdVJ0U2swZ3ll?=
 =?utf-8?B?ZTFhQldpRDc4Ulo2UHVHK0FNbkx1WnRQeHc5MjA5alpuUzQzL3MyZ2RoZ2pY?=
 =?utf-8?B?Q2pjcklBR203RElIdEhnanJrR3R1a2lpTHBFVXVUVEdQZU05RnprYnZHbWJK?=
 =?utf-8?B?VUs1TTJjVktOWDJjaVphVXJscVNrTVN1SGMzZGRHU1Z2MEkyRVJrZGdDRVNU?=
 =?utf-8?B?WVVzZ1pyTnl4d3RtWUZoZzQ4c2ZQamp2dWtMN241TGpNREdRVUNNZVpqc282?=
 =?utf-8?B?elhjdTU5dGtpc0NQM3UzWUg5bnlib3lTbld6cGhSWU1YM09xbkRhZ3JGaUpL?=
 =?utf-8?B?Z3JHa3JXV0NTa3FIN0FRSXhiOHJZWWswQ0h3akkyT3l0cWJORUJ1bHpkeGJj?=
 =?utf-8?B?UUZTUUlhdjNDdjUzS2Q1RWE0NjNMdnNJbHRjdWRnZ2ZEblA5U2VHZVVQczlX?=
 =?utf-8?B?aHRPNVZ6NWkwN2ZiQVJYcXF1QzhGOHFnUFJHZ0ZNbDMvNUtNS2h5RFBtSFlx?=
 =?utf-8?B?SzYrK3NXMHl4aDN1bkRHeEx2WW5MaUpBcGhsMnlRVkhBcFc5VzdqWjJGbDRj?=
 =?utf-8?B?N2YzLzZSdFd2dHNJVS82aTVmV0dQNUZ4UFd1amlVUXk5Q2tadk9veFpaL2E3?=
 =?utf-8?B?TGc0YVZiY3JVZk5GYlltNnRWTWVKMjllWU54R1RaZWwvZk5OdzV3QitQK1VW?=
 =?utf-8?B?cVpBZGJuVGlBaGlsQStuclZaQk0wbEdSRXozWlNpYi9xRzZ2bUdiY25nWHNZ?=
 =?utf-8?B?VHZzc0VaWnQ1T25TV0l0MHdFRk1mTmo3Ukh0TVBrRFF4ZFZpV2M3YUMxK04z?=
 =?utf-8?B?ak9EQ1lLYUE4aHp6RlhqU1FLc283WXlSbFppYVRLbW5LenFxNmtLdHBGL090?=
 =?utf-8?B?NjQ0a3RxajZqMFhEUmgvdi84WDI0VzdaTTNxM2VKdll5Ryt3bVRxQ1VNVjgv?=
 =?utf-8?B?RDVzdlY2ekkrbnlzeGNSa0I5cXVaMEFkbEtMeHlkdDByd1pnbGE4SGhzMHJW?=
 =?utf-8?B?UlBrWlplczN0RlA1YUNYQ3hmcVl0aXFyMUJZZVBYc1M3SVpPK1ZKL2xnMEtw?=
 =?utf-8?B?RkoyYUxZWUpvcGNmYXpRN0tvUkx3b3gzMERlcTIzd1NXMHppNVliUlFkSHZZ?=
 =?utf-8?B?QjRBVnZKS045QnpKZnJxOVY3WXpiZU0rRHEyNzJkQnFsRHhLZlpVWFdYTzJQ?=
 =?utf-8?B?UkZKbmpudWhRVUhHREVFeE93RG9GaS9zVzdaeWlNMm01Y2VqMUFudzl2REt0?=
 =?utf-8?B?K2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6955fe70-c43c-4b2e-ec4c-08dde3f23191
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 16:12:31.1652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4JPiVTPMCTb2ky/38QdMNftelMsP4603AAakTrOBqHR+a2dWu02gfXgRz4rWLiHm8wvd4J9ic0fbxPJbSnrOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7192
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=jan.kiszka@siemens.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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

On 25.08.25 11:47, Philippe Mathieu-Daudé wrote:
> Hi Jan,
> 
> On 24/8/25 09:18, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Implement correct setting of the MAC field when passing RPMB frames back
>> to the guest. Also check the MAC on authenticated write requests.
>>
>> As this depends on HMAC support for QCRYPTO_HASH_ALGO_SHA256, only
>> register the eMMC class if that is available.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>   hw/sd/sd.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 89 insertions(+), 1 deletion(-)
> 
> 
>> @@ -3122,6 +3201,7 @@ static const TypeInfo sd_types[] = {
>>           .parent         = TYPE_SD_CARD,
>>           .class_init     = sd_spi_class_init,
>>       },
>> +    /* must be last element */
>>       {
>>           .name           = TYPE_EMMC,
>>           .parent         = TYPE_SDMMC_COMMON,
>> @@ -3129,4 +3209,12 @@ static const TypeInfo sd_types[] = {
>>       },
>>   };
>>   -DEFINE_TYPES(sd_types)
>> +static void sd_register_types(void)
>> +{
>> +    int num = ARRAY_SIZE(sd_types);
>> +    if (!qcrypto_hmac_supports(QCRYPTO_HASH_ALGO_SHA256)) {
>> +        num--;
> 
> Instead, expose RPMB feature in CSD when HMAC supported?
> 
> Something in emmc_set_ext_csd() in the lines of:
> 
>   if (qcrypto_hmac_supports(QCRYPTO_HASH_ALGO_SHA256)) {
>       sd->ext_csd[EXT_CSD_REV] = 5;
>       sd->ext_csd[EXT_CSD_RPMB_MULT] = sd->rpmb_part_size / (128 * KiB);
>       sd->ext_csd[EXT_CSD_PARTITION_SUPPORT] = 0b111;
>   } else {
>       sd->ext_csd[EXT_CSD_REV] = 3;
>   }

I need to check if revision 5 still had RPMB as optional (current ones
definitely require it), but I don't think rolling back to revision 3
would be good idea. If start to add more features from newer revisions,
that may cause even more weird results from the user perspective. I'm
not saying we are fully compliant in one or the other version, rather
that we need to work towards becoming so. Have to support multiple
versions along that will not make it easier.

Jan

> 
>> +    }
>> +    type_register_static_array(sd_types, num);
>> +}
>> +type_init(sd_register_types);
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

