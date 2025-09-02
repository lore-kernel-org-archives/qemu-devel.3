Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A187CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 17:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utUxl-0000Wp-1a; Tue, 02 Sep 2025 13:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1utUxI-0000MA-A2; Tue, 02 Sep 2025 13:38:04 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1utUxF-0004sX-FM; Tue, 02 Sep 2025 13:38:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLjamltIwh7i5anPUK4T/U22jNUyk8uD9XSefsSfCAi6K9YXfqsxmvZCaib71gN1sbmoi9mYv3TZpqfMj1tS8iWhSnrKpP4YYMCfR4sKfZMTJZvk6JkEEKlS73z3g6tqgl4Zs9TCLLIejYOeB8OpZow/cGyZaVAQcCH3Bb/raHKJ1rWLkC7CiOafkKLQmUnPpF/rU/Vrht/QygIWyMCKeVipcdq/N9s5M3mIXmCsoBdxyDt2WciPRuAZ953h8w4qrxNI32FlXWiRBfkkBQHwxYek1bkAD6X/yd6oOVgi9q8dw30SdiFSW8K1y1opbpnv1zPtQp5urlwHVB7YnuLtCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJmp4354d4a+2ydfCUtaZpvX2Y4UGy352H/O6goSrtk=;
 b=rHBnlGo+eij5bOs5/EoD9fTrZKTS6uJweUPw0jKizVNlgOul99SR4h3PUu4QxTFY3o0f4Q8QZh9v332tWO4Ih0QOwh2CymzigHBYxYF8toyD0pt0qrnO+ZGoqB2eAUS2vjcihhP8IWbNvqg52IHglxFXYX1s2Iyl0VsQY83817df2polX/aAd72RCc32GG+BR2XUv9L4a1YkWETZ2B4Af/aDFd44/Kx4W/yyb6tWT8QqPaz+QhZQCT7Yh4l1cTvE8fKBaxkGHaNYj+sxWK737E5clIy5uUpXasKXdYigzb4rIdb2geG7Z0cgoOjPbQBIRLuyiDQQ2+Jz5FDW0xYwKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJmp4354d4a+2ydfCUtaZpvX2Y4UGy352H/O6goSrtk=;
 b=dWRLjNamj/6n+uvg9yb5NYN2gXHsUne9bfc1teAAZNbQPXX4FJikt2L36PMoQX84zBFXWQhrgzzacsVDdRyody3jD9TfW3i5NuO9/IvO3pLbKp4JFRPaWjvwqe/roSDYTSBjh9cysMBETGBkKwjzsdqQjBste/bOKeC8PyYxUUCBionIiK3/uVpsGEXBB+/BvFY99k8GbT0+3w11K6hV3OI6rFC2Idtt3yJbRXGxnV/xFlgceW7MysNkOxx8vY839VupVI6bjnFjIf+zHXmkxy3vSgPHIJ4nynA6oyMBt5cGcUo0UsN1hA3elbagUPEI8P2QitYXozCRFxIEmgAwrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PA1PR10MB9150.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:443::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 17:37:55 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 17:37:55 +0000
Message-ID: <1a7e47de-0021-4180-90a1-b249af8d22e0@siemens.com>
Date: Tue, 2 Sep 2025 19:37:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] hw/sd/sdcard: Fix size check for backing block
 image
To: Warner Losh <imp@bsdimp.com>
Cc: =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-devel <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair@alistair23.me>,
 Alexander Bulekov <alxndr@bu.edu>
References: <cover.1756706188.git.jan.kiszka@siemens.com>
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
 <CANCZdfprQZTVskt-EPgT-ALMO3HU-akdcw+yZ5=9Cmu1F00etQ@mail.gmail.com>
 <85b059c1-4a08-447b-a908-8af6b22d06c3@siemens.com>
 <CANCZdfp5AvUQNJ5m8V=z=R14CRwauSP7Qg+1FZ7VV_Ztb5Rb7A@mail.gmail.com>
 <CANCZdfrqiFBP9vP76yjvurmE5KX=OvC7c6vnUp66xr8jc0zaMg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 xsFNBGZY+hkBEACkdtFD81AUVtTVX+UEiUFs7ZQPQsdFpzVmr6R3D059f+lzr4Mlg6KKAcNZ
 uNUqthIkgLGWzKugodvkcCK8Wbyw+1vxcl4Lw56WezLsOTfu7oi7Z0vp1XkrLcM0tofTbClW
 xMA964mgUlBT2m/J/ybZd945D0wU57k/smGzDAxkpJgHBrYE/iJWcu46jkGZaLjK4xcMoBWB
 I6hW9Njxx3Ek0fpLO3876bszc8KjcHOulKreK+ezyJ01Hvbx85s68XWN6N2ulLGtk7E/sXlb
 79hylHy5QuU9mZdsRjjRGJb0H9Buzfuz0XrcwOTMJq7e7fbN0QakjivAXsmXim+s5dlKlZjr
 L3ILWte4ah7cGgqc06nFb5jOhnGnZwnKJlpuod3pc/BFaFGtVHvyoRgxJ9tmDZnjzMfu8YrA
 +MVv6muwbHnEAeh/f8e9O+oeouqTBzgcaWTq81IyS56/UD6U5GHet9Pz1MB15nnzVcyZXIoC
 roIhgCUkcl+5m2Z9G56bkiUcFq0IcACzjcRPWvwA09ZbRHXAK/ao/+vPAIMnU6OTx3ejsbHn
 oh6VpHD3tucIt+xA4/l3LlkZMt5FZjFdkZUuAVU6kBAwElNBCYcrrLYZBRkSGPGDGYZmXAW/
 VkNUVTJkRg6MGIeqZmpeoaV2xaIGHBSTDX8+b0c0hT/Bgzjv8QARAQABzSNKYW4gS2lzemth
 IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPsLBlAQTAQoAPhYhBABMZH11cs99cr20+2mdhQqf
 QXvYBQJmWPvXAhsDBQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGmdhQqfQXvY
 zPAP/jGiVJ2VgPcRWt2P8FbByfrJJAPCsos+SZpncRi7tl9yTEpS+t57h7myEKPdB3L+kxzg
 K3dt1UhYp4FeIHA3jpJYaFvD7kNZJZ1cU55QXrJI3xu/xfB6VhCs+VAUlt7XhOsOmTQqCpH7
 pRcZ5juxZCOxXG2fTQTQo0gfF5+PQwQYUp0NdTbVox5PTx5RK3KfPqmAJsBKdwEaIkuY9FbM
 9lGg8XBNzD2R/13cCd4hRrZDtyegrtocpBAruVqOZhsMb/h7Wd0TGoJ/zJr3w3WnDM08c+RA
 5LHMbiA29MXq1KxlnsYDfWB8ts3HIJ3ROBvagA20mbOm26ddeFjLdGcBTrzbHbzCReEtN++s
 gZneKsYiueFDTxXjUOJgp8JDdVPM+++axSMo2js8TwVefTfCYt0oWMEqlQqSqgQwIuzpRO6I
 ik7HAFq8fssy2cY8Imofbj77uKz0BNZC/1nGG1OI9cU2jHrqsn1i95KaS6fPu4EN6XP/Gi/O
 0DxND+HEyzVqhUJkvXUhTsOzgzWAvW9BlkKRiVizKM6PLsVm/XmeapGs4ir/U8OzKI+SM3R8
 VMW8eovWgXNUQ9F2vS1dHO8eRn2UqDKBZSo+qCRWLRtsqNzmU4N0zuGqZSaDCvkMwF6kIRkD
 ZkDjjYQtoftPGchLBTUzeUa2gfOr1T4xSQUHhPL8zsFNBGZY+hkBEADb5quW4M0eaWPIjqY6
 aC/vHCmpELmS/HMa5zlA0dWlxCPEjkchN8W4PB+NMOXFEJuKLLFs6+s5/KlNok/kGKg4fITf
 Vcd+BQd/YRks3qFifckU+kxoXpTc2bksTtLuiPkcyFmjBph/BGms35mvOA0OaEO6fQbauiHa
 QnYrgUQM+YD4uFoQOLnWTPmBjccoPuiJDafzLxwj4r+JH4fA/4zzDa5OFbfVq3ieYGqiBrtj
 tBFv5epVvGK1zoQ+Rc+h5+dCWPwC2i3cXTUVf0woepF8mUXFcNhY+Eh8vvh1lxfD35z2CJeY
 txMcA44Lp06kArpWDjGJddd+OTmUkFWeYtAdaCpj/GItuJcQZkaaTeiHqPPrbvXM361rtvaw
 XFUzUlvoW1Sb7/SeE/BtWoxkeZOgsqouXPTjlFLapvLu5g9MPNimjkYqukASq/+e8MMKP+EE
 v3BAFVFGvNE3UlNRh+ppBqBUZiqkzg4q2hfeTjnivgChzXlvfTx9M6BJmuDnYAho4BA6vRh4
 Dr7LYTLIwGjguIuuQcP2ENN+l32nidy154zCEp5/Rv4K8SYdVegrQ7rWiULgDz9VQWo2zAjo
 TgFKg3AE3ujDy4V2VndtkMRYpwwuilCDQ+Bpb5ixfbFyZ4oVGs6F3jhtWN5Uu43FhHSCqUv8
 FCzl44AyGulVYU7hTQARAQABwsF8BBgBCgAmFiEEAExkfXVyz31yvbT7aZ2FCp9Be9gFAmZY
 +hkCGwwFCQWjmoAACgkQaZ2FCp9Be9hN3g/8CdNqlOfBZGCFNZ8Kf4tpRpeN3TGmekGRpohU
 bBMvHYiWW8SvmCgEuBokS+Lx3pyPJQCYZDXLCq47gsLdnhVcQ2ZKNCrr9yhrj6kHxe1Sqv1S
 MhxD8dBqW6CFe/mbiK9wEMDIqys7L0Xy/lgCFxZswlBW3eU2Zacdo0fDzLiJm9I0C9iPZzkJ
 gITjoqsiIi/5c3eCY2s2OENL9VPXiH1GPQfHZ23ouiMf+ojVZ7kycLjz+nFr5A14w/B7uHjz
 uL6tnA+AtGCredDne66LSK3HD0vC7569sZ/j8kGKjlUtC+zm0j03iPI6gi8YeCn9b4F8sLpB
 lBdlqo9BB+uqoM6F8zMfIfDsqjB0r/q7WeJaI8NKfFwNOGPuo93N+WUyBi2yYCXMOgBUifm0
 T6Hbf3SHQpbA56wcKPWJqAC2iFaxNDowcJij9LtEqOlToCMtDBekDwchRvqrWN1mDXLg+av8
 qH4kDzsqKX8zzTzfAWFxrkXA/kFpR3JsMzNmvextkN2kOLCCHkym0zz5Y3vxaYtbXG2wTrqJ
 8WpkWIE8STUhQa9AkezgucXN7r6uSrzW8IQXxBInZwFIyBgM0f/fzyNqzThFT15QMrYUqhhW
 ZffO4PeNJOUYfXdH13A6rbU0y6xE7Okuoa01EqNi9yqyLA8gPgg/DhOpGtK8KokCsdYsTbk=
In-Reply-To: <CANCZdfrqiFBP9vP76yjvurmE5KX=OvC7c6vnUp66xr8jc0zaMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:610:4e::29) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PA1PR10MB9150:EE_
X-MS-Office365-Filtering-Correlation-Id: af6e199a-05ad-4510-9989-08ddea477312
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGM2VC9VYjFhZ1BmNXUvdytTZXNFZ3R5V1lINTJRZFE1TkdNVFBVbUhjV2Fs?=
 =?utf-8?B?cHY4UTdDWG43TVR3ampoZ2ZSODAxNGtSQitMVHlhNkx5ZVpxTzY3alFEdHhj?=
 =?utf-8?B?Q0YyRnZDb0ZMcmZ6NFRrSE5FWlEzUHgzMUVEK3g4WC9lRkpHc05yZFhHYVNy?=
 =?utf-8?B?T2dCNFEwb3pPTDJxOSt6aUNJVzMwRzY5VHV1bldwMktqUitzZkxHcVlWVHh4?=
 =?utf-8?B?TzN4MjhxNzRDTDBhOUJGS283VHNIenVpN2M2azRvV1lKOE1XQkZmd1pYWDJa?=
 =?utf-8?B?R1pvdzVVRHFlYi9tU0pEb1BsWjVIaGJ5bFk3L3grbER4NVlDcVU4eWJSWHdT?=
 =?utf-8?B?aWRUNVhLMnBjYXhOU2FSMVgyRjdsNGUzemdNWG1CaU1Cd0JYZzRUbG9lVFcy?=
 =?utf-8?B?UW1xMHBTRzZhWGhhazhwa2JEQjN4czAvaW1IM1lRQWhpenA2bXhCZkRTajds?=
 =?utf-8?B?YW5pczhGeW9IeFQ0KzNtYTVKd0pTdkM2RjdpVUU5cFJQY3drZmZXRWpRaWd0?=
 =?utf-8?B?alVJN0dtNzZKL3hzdmNXQ2ZpWFYrcWlnYTJOM2ZWSFNweE1ndXFYS3NLb3pn?=
 =?utf-8?B?YkdWQUpKRFl0blhYRmtkVjhwdmxicFlPTEE2dDl3ZGh1K3hLZmo1cUVpR2Jr?=
 =?utf-8?B?ZHZoOEljRkYvWFNxWFR6aDg0dngzNVJZSThwSG56SUltbXB6YWNvRlFkSHRQ?=
 =?utf-8?B?TkxkWjg2VUovT2g0Tm54enE3NG1xNFhLVzVweW9yVUFTZGFrYVUvWEF0U0V6?=
 =?utf-8?B?b0NrNGRkYjU5MlBobmNyZUtMWGhnZkUwMUQzN21mZ2VRZitVdi9yWlhvditY?=
 =?utf-8?B?MTJJNUZzdCsvK2oyMC9qUVNvVzNQelVYVW9wdXBNY2p6UVpVUm1xZFBlVy9N?=
 =?utf-8?B?K0dEbE9uVGVtRURRVE1USVd0SzZZZnFOS1c2WDdxRFZpTVZMS0pBUlhvTjQz?=
 =?utf-8?B?bkpqaEg1N1NpdTlWb04rdU5WR05IRkUrcUdaN2ZkSm5wbm9MK25PdXlmem55?=
 =?utf-8?B?UXBnWnI1bDMwVWxCWjVvZ3hqL3NJK0xFM3FqOWoyVWFNSVp3VnRqNVh2NERR?=
 =?utf-8?B?a3BrcGNNRDVPZXFQekxEUG10V2IzT0VDMTdvM1NPQ3M5MnM2Mi9Id0IyZkpX?=
 =?utf-8?B?U00wRHJYYkFjZjhORGR6RHNxUkduV253cVl3a0hWaXBpR3ZSTFJ2V2drbmNL?=
 =?utf-8?B?L1R5ajNqWVhRY2JmVVN0U1NJL1BZdHBpSXJJK1JEcjJCQmlBbU5hbWtWRHI2?=
 =?utf-8?B?VzFMRmgzN2NLQWVpa01udndZaFIzVzZ1VHREaWdEbXJMamtoTUJ5M3BKZUxP?=
 =?utf-8?B?Sk1pNVFZVEhXeUN1RW9XUXJaSk9nTlRjTGlUYXRXdDQ0ZHJJTDc2MHpnenBG?=
 =?utf-8?B?UHJYYWozL0J6NFpWL0pERjNLL3hObDROZTF1Z0d5TjdRci8yT3o5V2w1YWFt?=
 =?utf-8?B?VTJqNC9ObEZVWms4cDhrL2VGa0lCMDdrUzJ5NWZkT2ZQbVRQci95VUZleHFm?=
 =?utf-8?B?aWJqS250QS96R1ZrTkFmZzdOeExZd1JqOGh3WHpnVFVNMWplTzFDTW0zRC9C?=
 =?utf-8?B?WXIxVkxxN1d0NW94MlZIZnhBckdmYmgvK3BJUGN2aVRQZE0rMTFjcmxXYmph?=
 =?utf-8?B?citmejFWc01tVlZ4Vm91YktXS1JISmlueXNsZE1SN2VFZEtWTzJYYlhORFJj?=
 =?utf-8?B?VXhsQUxTTGppM0ZhMDBDdzBmRFM1djJLRWZPemo2Zy9ROHVqWGNCb2d6L3JG?=
 =?utf-8?B?Nnl6UWFKeEZEYVZPdmZvMUhVcTJvSlI1MHNsV1cwTFpvWTdRbm50bFYzNHA2?=
 =?utf-8?B?TUJSOS9sa2FQbFI1aTBBam0rZzY0NC9sT2FpV202SUV1S3hMd0pBMjU3NGM3?=
 =?utf-8?B?ODladkFDdkJFTGdtK1pFRit0MkZSa0N5ZlhGY1NIOC9MbDIvSk1kalQyd0dl?=
 =?utf-8?Q?OTBwuuIWWbA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTBucytVc0dGNGVHREtvVm9RV0k0dm5meEc1MTNOZ0x2b0h5enhJclNUTzc0?=
 =?utf-8?B?WlVvZGFHTmg2WUdHN29WemsyUVBnVzR4bUE2WjhBY2x4V24weDZHK0VxSzBk?=
 =?utf-8?B?QTRHUDdRMVVkaFdvLzRZcDd3K2JrYnJ1N0p4ZmZaZ3N3RHNncmxSUXFhTzN1?=
 =?utf-8?B?Si8vZk9vSDEvMnpjT2tXdkJLYmYvUmgvUEl1TlV1TCsyT0RnVFpWa21Kc1hO?=
 =?utf-8?B?MGIvZkFxYWFWMkRmVmRkK3ZVeGQvdEhvcEFRSzlTM0ZtNlh4UndhaCs1LytJ?=
 =?utf-8?B?KzBxTUFUL0Y3cFpmV0t4QzJMWlhKbHZHamhHNjQ0V2o3UUF6alJxTWlvaGJK?=
 =?utf-8?B?aTFmdE9BamNTVXhrZ3RweC9uUG1EdTQ5R3JzZFBMSDMvYjFIN3VaVXhmNHc2?=
 =?utf-8?B?L1FScFZkN1ZzSzVpOCttU1lVRTZzVzc1ZFhWTUIxRlhmY0VNTEJtbjFzWkMx?=
 =?utf-8?B?MnQrVTVYc2w5Tm5qOG9SdE5MbFhmbFJIM3FUdHFCNTg3QndCUEtELzN4emg3?=
 =?utf-8?B?dHZzSjR1WTBRRWdWSXA2b2JVNjg4bE1uTjdRVkU0Q3BxUjBJRE5IeVJvN1gw?=
 =?utf-8?B?Qzd2RUZwZGFQY0Rva2FpZFYyWUNxMEgrZjE1UWxnL1NlVmkvR2sxM1EzaEZH?=
 =?utf-8?B?SWlYR1pPbmhNUWF6VVFLMHdXY2ZlTUYzU3dSTUQ3dlIxVXl1cGpWQjA4V3Ex?=
 =?utf-8?B?MTJaVm1tM1FXZXhZRW1tVGFmbjhYMXVFeWVQbHcwRzdBQi9jUmdZanZCNGt0?=
 =?utf-8?B?QzhNS2RZc3ZPYUllRzZ1L1NlQ0s5K2x2S3NNbTZmV3pYdXk1TzNMcHVaUno4?=
 =?utf-8?B?UFdQaWpGYUVIUXJDMHdjeXFYeGFNQVBWeXE1QjUyaUEwWnZlbk0rR0tPNFJt?=
 =?utf-8?B?dlUvMjlFdzBmcHU3azFnRGR0b0JNVkxYRDQ3WjJrZHVRa3d3VCtIWUltTE9V?=
 =?utf-8?B?QXJ0dEl4WnE5ZUJURllYU2tKcmNxMVpZb3ZXQ1ZVSFp6bmxGbmJSSFo5UGtH?=
 =?utf-8?B?b0lsV0d2SytjUmpidFpNT1dSVTJubk5QS2NRSVM5NFNsTVVqRDNDNVZmcVFr?=
 =?utf-8?B?VnFpZjkxMkhKTkdYZkh2L3loN0RjLy82WjZyYmE5eXdsaFppR0dKKzIvYVZ3?=
 =?utf-8?B?eWRrOXdURlhIN2N0RVZKSkw5TWQ2eCtaMklPRVYvTkM3L3ZTSVRCWGpBL3pZ?=
 =?utf-8?B?ZnYyQm5GTUFmeXE4WERwKzR4bmswaWpoUGdodGg1N09VREVRQlVqYzcxTE1I?=
 =?utf-8?B?aGRITFhiUUtINHBvNVpXTHFsWnZpc21DT2VIMStwWTROSjJWUy9SemFFUDRH?=
 =?utf-8?B?UGROVkJMUWRaVThLWEQvSTN5YzRiN1lRUXhRT0EwOWJ6R2R3aVpvdGoxaVZI?=
 =?utf-8?B?SmRSM1F2bDF6SXNSaFVPcTVhbC9rTDFhV2JaV1dQbjNBYjJJUlF5OVdESVZa?=
 =?utf-8?B?Y01HcHNIejRuNTV2RmhidFFzSzFTVGl1cGhmRzhMdHhGWnhwQWdRZlkxeldt?=
 =?utf-8?B?K2lmKzFQQmFBNFdFRWorSHRQbC9tcFR5T25aWU1HdU53azFEY21HeGRjUWdE?=
 =?utf-8?B?SkQ1dHU2MlV6YVFjRTlRRCs4ZXd3YU9xYWpGMTUwajVWajdpaVNJNW50dUNE?=
 =?utf-8?B?NXJXNFVzbkJVbml3V1IxV3hlQyt1RExQQllDV0FWVTJFcCsxY2RrdzR5UnMy?=
 =?utf-8?B?eTBkdzhmdlpDK2huSGNCeXRvR0tXcjJIcGVHWTJGbzIrd0FYMy85cTFEOE9r?=
 =?utf-8?B?OGsrYm0rVStvKytBN3E2Mi94ZjFnd21rdHJsdFpnK2tFRWRaZVhwZGFVMjEx?=
 =?utf-8?B?anFMSUlPZkdUdzBBcklMQlNHeWJxSUFUOTAyYkJKaVRQeW0xL29vQ1E1Yk5w?=
 =?utf-8?B?YzVqU1VEb0VjTDlFTkRDYTVsQUdWMXVmbDFaaXFmam5xeDZEK3ZybEZYMjha?=
 =?utf-8?B?MFVBMWRXRUwrNHVTSzlVY3dYTC8xVm5oRzVITjljcElzUjRqOFpBZUlZMFhG?=
 =?utf-8?B?V242UkpUWDZRdzJXWUxLMWViNklHYUJKbGprd25VUm5CdHF1WXBzMldhYSt4?=
 =?utf-8?B?V09hMW9UcXQrdGhxdjZVdGx6cUxxWkpGSU1HdVZjWTRtZ1JzK3R6NllKYmNS?=
 =?utf-8?B?bnJ3WWpFdzhya3dnVU4yekNqcGhMTTF1amFyS3ZWdjZDUEllMTAvek9JbnZ2?=
 =?utf-8?B?SVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af6e199a-05ad-4510-9989-08ddea477312
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 17:37:55.2482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yc5tsV65QSl7eJcVR5VLpyNrAU98x0oyqVvRx2sChcszqPuM0vpvas8JNc0VlL3e0wzrp1DyPx6VctDbpqmkWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9150
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

On 02.09.25 19:30, Warner Losh wrote:
> 
> 
> On Tue, Sep 2, 2025 at 11:22 AM Warner Losh <imp@bsdimp.com
> <mailto:imp@bsdimp.com>> wrote:
> 
> 
> 
>     On Tue, Sep 2, 2025 at 11:18 AM Jan Kiszka <jan.kiszka@siemens.com
>     <mailto:jan.kiszka@siemens.com>> wrote:
> 
>         On 02.09.25 19:07, Warner Losh wrote:
>         >
>         >
>         > On Tue, Sep 2, 2025 at 10:49 AM Jan Lübbe <jlu@pengutronix.de
>         <mailto:jlu@pengutronix.de>
>         > <mailto:jlu@pengutronix.de <mailto:jlu@pengutronix.de>>> wrote:
>         >
>         >     On Tue, 2025-09-02 at 18:39 +0200, Jan Kiszka wrote:
>         >     > > > I expect us to be safe and able to deal with non-
>         pow2 regions
>         >     if we use
>         >     > > > QEMUSGList from the "system/dma.h" API. But this is
>         a rework
>         >     nobody had
>         >     > > > time to do so far.
>         >     > >
>         >     > > We have to tell two things apart: partitions sizes on
>         the one
>         >     side and
>         >     > > backing storage sizes. The partitions sizes are (to my
>         reading)
>         >     clearly
>         >     > > defined in the spec, and the user partition (alone!)
>         has to be
>         >     power of
>         >     > > 2. The boot and RPMB partitions are multiples of 128K.
>         The sum
>         >     of them
>         >     > > all is nowhere limited to power of 2 or even only
>         multiples of 128K.
>         >     > >
>         >     >
>         >     > Re-reading the part of the device capacity, the rules
>         are more
>         >     complex:
>         >     >  - power of two up to 2 GB
>         >     >  - multiple of 512 bytes beyond that
>         >     >
>         >     > So that power-of-two enforcement was and still is likely
>         too strict.
>         >
>         >
>         > It is. Version 0 (and MMC) cards had the capacity encoded like so:
>         >                 m = mmc_get_bits(raw_csd, 128, 62, 12);
>         >                 e = mmc_get_bits(raw_csd, 128, 47, 3);
>         >                 csd->capacity = ((1 + m) << (e + 2)) * csd-
>         >read_bl_len;
>         > so any card less than 2GB (well, technically 4GB, but 4GB
>         version 0
>         > cards were
>         > rare and broke some stacks... I have one and I love it on my
>         embedded
>         > ARM board
>         > that can't do version 1 cards). Version 1 cards encoded it like:
>         >                 csd->capacity =
>         ((uint64_t)mmc_get_bits(raw_csd, 128,
>         > 48, 22) +
>         >                     1) * 512 * 1024;
>         > So it's a multiple of 512k. These are also called 'high
>         capacity' cards.
>         >
>         > Version 4 introduces an extended CSD, which had a pure sector
>         count in
>         > the EXT CSD. I think this
>         > is only for MMC cards. And also the partition information.
>         >  
>         >
>         >     > But I still see no indication, neither in the existing
>         eMMC code
>         >     of QEMU
>         >     > nor the spec, that the boot and RPMB partition sizes are
>         included
>         >     in that.
>         >
>         >     Correct. Non-power-of-two sizes are very common for real
>         eMMCs.
>         >     Taking a random
>         >     one from our lab:
>         >     [    1.220588] mmcblk1: mmc1:0001 S0J56X 14.8 GiB
>         >     [    1.228055]  mmcblk1: p1 p2 p3 p4
>         >     [    1.230375] mmcblk1boot0: mmc1:0001 S0J56X 31.5 MiB
>         >     [    1.233651] mmcblk1boot1: mmc1:0001 S0J56X 31.5 MiB
>         >     [    1.236682] mmcblk1rpmb: mmc1:0001 S0J56X 4.00 MiB,
>         chardev (244:0)
>         >
>         >     For eMMCs using MLC NAND, you can also configure part of
>         the user
>         >     data area to
>         >     be pSLC (pseudo single level cell), which changes the
>         available
>         >     capacity (after
>         >     a required power cycle).
>         >
>         >
>         > Yes. Extended partitions are a feature of version 4 cards, so
>         don't have
>         > power-of-2 limits since they are a pure sector count in the
>         ext_csd.
>         >
> 
>         JESD84-B51A (eMMC 5.1A):
> 
>         "The C_SIZE parameter is used to compute the device capacity for
>         devices
>         up to 2 GB of density. See 7.4.52, SEC_COUNT [215:212] , for
>         details on
>         calculating densities greater than 2 GB."
> 
>         So I would now continue to enforce power-of-2 for 2G (including)
>         cards,
>         and relax to multiples of 512 for larger ones.
> 
> 
>     It's a multiple of 512k unless the card has a ext_csd, in which case
>     it's a multiple of 512.
> 
> 
> More completely, this is from MMC 4.0 and newer. Extended Capacity SD
> cards report this in units of 512k bytes for all cards > 2GiB.
> 

I'm not sure which spec version you are referring to, but JESD84-A441
and JESD84-B51A mention nothing about 512K, rather "Device density =
SEC_COUNT x 512B". And these are the specs we very likely need to follow
here.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

