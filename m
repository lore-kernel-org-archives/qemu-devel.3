Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FC7CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 17:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utVCC-0000h4-2l; Tue, 02 Sep 2025 13:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1utVC6-0000gI-Im; Tue, 02 Sep 2025 13:53:22 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1utVC4-0002vo-61; Tue, 02 Sep 2025 13:53:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLIYGLKtEkXFSyRH0vUxcR2GaDRZIpk2twyKcswQeEYPz/muVmmLuD9dGgBGB30qYMN+vnBvGCxZFMaRbMxb578p0ACEWkMJgHNrR0p1JBINaL4uGQU3YnYm3RKSuXfju1p9+FvOMXAClKb2YXnguIcMX/SHdNDAA3ebjAdXTZiyHYa51RXsEGqlSEJrEkfEO4uR8XusoN2SHOzz8FTPL26sWkVwzN8oxGEAgpG8kdCi8E7emjU++UNxuEEIzcLo2wKXSz5h2mOSBFLAXcASOgabRzCI2e40gHmcZpbmLsYziFaTRy3rO4badn7jcrpqK4u5whbs4mrPG3SXLq1MPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fulwDc++WFyAiX2+DCzJhJ7b83IKS6gLMlYIrSpXkZg=;
 b=YfqBD2KiruFxS9ewShch+tY6uoPnWAHOr5ZuHzeeTwlIYTK5qhmkfRkNwJRnxhKH+LsX3XTHMQjNCE2VDyKtNbQoF4/lqapJkv2LiX9ZECNT/rYG4vosrjm0S8gIZV+dZAqNfo7tTNVkF4KKgAHAyo0BfD33VPr6L6QVplE710oBZ+YvheFFX/2cAfrFyTYFpQPEdt4Z2V0dGFfvCzL08DHrrsHRtFnEzzBUYZmLLMLgjP5oAUOWDn9hX+rF7EU6+Fh6LvTMAP+eqLh2ZQ21QzruRVPEHXMfM6CN6fiAnGlPHW8FYt7M7XHpKTBt/POuVlRqQh8h2Y2xRRm4XL/9zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fulwDc++WFyAiX2+DCzJhJ7b83IKS6gLMlYIrSpXkZg=;
 b=MolhU72PA1+ZvTQuE1ZtsGdahz85EfA6RX8FRFGdRP9q7liuyPzJaocd+POdgS4iQQPV3lXuHR3dHbvrouSfIlU2dKP1QWPdmpiFoeWW1XiHn8ppoc29LhRPgb4IecdSJtW1kgeR22o8EDTlWLXDohoFB2zPzO0r47t4BtIjkBizFtuhcAejCOmOPX4TR74KWI6nlpquibL38y1anIRHS/Sfs5GgULAk7jiERi3qaHA6vaZQgGElkMijQR69yNMrnTVE1goY/dubF3K5UczCWnxmJWy6u0R1HZDzMKWlWGaPY992Aht25kIzwQyk+HNUsh/T/Z4zbf8x4AsQP4CLog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by GV1PR10MB8444.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1ca::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 17:53:14 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 17:53:14 +0000
Message-ID: <85e230b8-75f5-43c7-897f-5abb18799d52@siemens.com>
Date: Tue, 2 Sep 2025 19:53:09 +0200
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
 <1a7e47de-0021-4180-90a1-b249af8d22e0@siemens.com>
 <CANCZdfrgB5NXNSa+KHs9AcgFW8Qy+raj1a75DkuQeX2Lt1=aAw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CANCZdfrgB5NXNSa+KHs9AcgFW8Qy+raj1a75DkuQeX2Lt1=aAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::15) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|GV1PR10MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e2da957-60c3-47b0-1d8e-08ddea4996aa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WWhnRlF0L01iMzJneFlFUDRZTlJlcmZtNTFtQmZuVGhrdmFocnh5Y24wRTVZ?=
 =?utf-8?B?VVl0NmJweWVqdU1iQjFZWnlOZlpyWjFhaWlsR0MxK0JWczZ6WC9QTEYrVGtY?=
 =?utf-8?B?TDJEZmxUYU05RkpmVlZ0VE1GdVVCMjBBV2NKVTg0VFErbUlkODRFNVVVdkor?=
 =?utf-8?B?d0FiYVIzYlRBait6TklBNVlzak1HcDI0bDh2YnREazc1UzUzNkZ5YzFmeG1k?=
 =?utf-8?B?clJkcElZS3JaWTl1RmVPUFJJM2xRaXJDcmFXeGVrbklxRWZYU3pzWEhZYzNu?=
 =?utf-8?B?MmxBd1ovQ3B2bTVGY0FjSXFvdXZ0VEU5TXFlc3c2bnUvaUpZb00vQkE4aXRZ?=
 =?utf-8?B?ejBhY09rQnpFYWh3Q0J0UytlN1FuaXFSdCs2dStXaU12T1k2M1lZY1dud2h6?=
 =?utf-8?B?YjJJOTgycnl2YXB2SjJSSWlROUdtMTFpbU0wZWZoM2VuWGd3aE5WaU02SGR3?=
 =?utf-8?B?azZ2VEErN3BuaEI2QmNscXZhK1huS0xDVzg1ME1XUkZEUEh3akRVS2VWWFNa?=
 =?utf-8?B?bm5mQW1Rb21XVG9XWmNnam9uV2k5ZUNDQ2J1R3IrR2Uvc1pHcjVHNTZRWmkz?=
 =?utf-8?B?Qm9IUlhGVER4SnUxOEdqYk4wTUlsMkszc05IQWZmSkVualJPMmhDRXpPSlFM?=
 =?utf-8?B?UjhkeC9PUFJFQ2Z5NTZUbnZRVXpLMzdudzhZK01GeWdMcC8yMXU0b0dBWUZX?=
 =?utf-8?B?V3FGQjQ2ekJybXRhYjY1aVRWWUYxRFkvMFVkWVpxdEFxOXQrQ0VNd2hmTHB0?=
 =?utf-8?B?Nnp1QlB5Q3lhNlEvQ0JtZXo3alZWNDRJSGZhUUxtWmdGZkhGUVB3dzVHR1lK?=
 =?utf-8?B?OVo2UU9VMWZ4a2tMY3hudjZWK1llZFlGeWF4T2hUZndQeHpqakhWeHg4a0x0?=
 =?utf-8?B?WU8xbDJTb09KaFVUcEFDc3hsV3NhWUdIcnA3anhtd05EL0ExVWNqZ3FmRFVq?=
 =?utf-8?B?V1RhZnE2YVEyVlk1Z3p2SEpYbFlURU5PUTF5MC9PV2tWcGN1d0IzTTI2N3B5?=
 =?utf-8?B?TkFlUlA0cU40OWdaTm5INEJsOUNyNTBtM1NBb3pPcU55elB6SkdRNmprcFRq?=
 =?utf-8?B?VTE2SWdSR0NqVXNxdzZ6aHdUQkwvZnI5cXAwVkFrR0JEK2FoOUhQZGtSSVBL?=
 =?utf-8?B?L1J1UGZtVDE4YmUzdE1sb1pSenlmd1Z1SmJMTzdseWlVc3VlcGNkOUQ3bkdw?=
 =?utf-8?B?UU1BNzFoc2I3V0ZkNEF1VFNWUnJIV2ZXQmJEVjc0YkREL1lpUEY5dlMxdjRJ?=
 =?utf-8?B?UERTdUo3NlNCbTF1cXU4TUt3YkE1VXgvU3h1cCtrNDBuQXlsWnhsU2tBZjd6?=
 =?utf-8?B?UEkzMERLamNCK2dMbVhXaVlIakxVWTVLYTE0VlFVdmtvZjVyUWt1MzhqKzM2?=
 =?utf-8?B?dmFiaWVZczFRUkpuVTJpZzhGVW1IS3k5NTNBZk1objNTZzZiYlhiM1NKa1BR?=
 =?utf-8?B?NXEzTG90UjlRZldodDZaWVlFUEpTMHppeGRLbEl6Qm5JdnE2UDNkSURmT0xM?=
 =?utf-8?B?aDI0L3d1RnVlS3g4bXNwbUY0NTRhT0paOHFBVnZOOW5UcUd5bjJXRkp4QWdJ?=
 =?utf-8?B?bFZEcTlIZkl6VEVKdU5RbEFmM0Q2TmV6T3NJYjNBSWxGY1M5dW0rYXc2RkQ5?=
 =?utf-8?B?OE5iSENERzJrNm95TVptem9JSkw4VVdqZEM5VnZwUEQyMXVJanNWRVdzS280?=
 =?utf-8?B?SDhHdDhsQWlsTTRzV2VBT3l1Rjg5VlNxNFd5KytwSHZiNTJEMDE2d2Z6RC9K?=
 =?utf-8?B?VkhtdUdjUTJ1QjdkTlplZTgraVgyT1VQbnJNUkZRRnQ3dWNlNkdhQ0NqRExH?=
 =?utf-8?B?blc1YXIxWVRpejVIc0RvcVlaeFVWWElEdGJlRHg0ZzAzQnJBdHRnQTB4Z2M1?=
 =?utf-8?B?bWRhR1gyRWRhVUY5eWRoNzJDbmFxQUhaMlh0K1lxNFVFQTZLa1ljQVJ5K0x3?=
 =?utf-8?Q?yYZps1/mpiI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXRLb1VrS01KZitOay9kajM2Y3VkNm9jaHBYWm9qc1lyN1doQnMzRTlibGU3?=
 =?utf-8?B?bXc2WlRDVkc5WkVCNllqcFMxWHdPV0xKUXdGeHQyc2JWdXNqcU9kblVhL0sy?=
 =?utf-8?B?L0FmQmNEdUhlUWgyUHYzcFVlbVUvSGJPUlRIdFFCV0dTQWdMaWJBQzl4cEI2?=
 =?utf-8?B?U0hwUzdCMVdmNkxqNjVtQXEwTHlOamNMcmZIOGVNcG9kVDV2a2NhSHlrUFdB?=
 =?utf-8?B?c2xobUhTK1lyMmhkZGo4ZG8wL1JlZXRkNVFSek9UdlYwQkZjZGtGL29rQnZp?=
 =?utf-8?B?UVBjTmFJNmMwWEVibGk4RmFuNitYc1pZNVlHVk5TV3RrelBTS1JGRFk4MnVk?=
 =?utf-8?B?b1BEQWlNMmg3ZThjTGpIVFlEZG53Wm1JckhLOEMzb1g5TkdZcDJrVnIxcTJv?=
 =?utf-8?B?elVlQVZ2NWo4V2M4aHg4eDZHcW8xeXB1TEMrZGEyUmNJcktkYVNhL2NobW9Z?=
 =?utf-8?B?TVY4aS9kdkVMbjZTRE9pN3h5NWlTZkZUaXl5V0d3MlY2MHB1K0xYREVlNDQv?=
 =?utf-8?B?a3pEWUZrM3l6Mk1Xdmp1VUcxaGM1U1pkUGVTVHlQYzhHV0R6SHpCT0c2RnBl?=
 =?utf-8?B?Mkg2SG5PRWI0N1FqYnUrcncxTU15cEpHYnZRNDZ2Q3hsM3dLNjhqR3g2Zi9V?=
 =?utf-8?B?SW8vc0ZQd0xxQzcvbDNuZ2J6V01vZ3pId2pNU3dIakZRYnVnR0ljWiszWldF?=
 =?utf-8?B?K05VbzZQZzRMZkFxcmNrSGl1OExpcXVSR2FoaUk5RkFGN09jVzRIZlZaWFdV?=
 =?utf-8?B?YWFjT013MkJHcVJZNlJxbXhHa1gwQjltTWQrQ2FKaCtFZFV5cnVzTTZKS1J5?=
 =?utf-8?B?UGg4VitlVldBdG1KaFZLenlNbDlVaE5zZStJdk5GT01JQnBOSkdRTjcvMzVo?=
 =?utf-8?B?VEpMVGtzdDcwYXhhOUpNc1AyZ3FudU5RbkdzNkIyTURTQlZmRmxBTWMwaStY?=
 =?utf-8?B?bzA2UWpnUEE1dnhmTDZLNnY2VnRRcTQvRnA1VG5hbnFuRjFBOE9BdUNtMnk0?=
 =?utf-8?B?MmxTL1U3eHdtS3ZMMDZLVU1YL2p2T0IzOS9MendMZE84VVpCbDVDMjlmMEI5?=
 =?utf-8?B?SU1SekFwbVBmSVBTZXNTM2kxQ1l6MGRXR2puRTczV2FJdnpWNURnUlRPR3I3?=
 =?utf-8?B?K3RnK2NiZ0tlRnZYOHgxekZEMCtpL0k0U1dzcmlNYnVwN0xLUUU0cUp4NldM?=
 =?utf-8?B?S1F3QnFpd2xzWEM3emZqVlVlLzU2M1IzNlUzV20vemVEVFJnWVhDbUpGK1Yw?=
 =?utf-8?B?VmdVdXpEWjRTTzF3aytNYzBqSkp4eGxZa0VoU3VUNmd4WFAzMmY5VWJqR2VG?=
 =?utf-8?B?aHAzbk5SYVN2cmhqd2o1b0xCTUhtS0RXMHA4T2ZTSzhtK0hZcFlyWTdmVWhL?=
 =?utf-8?B?UlJEK3NFdFduMk5SNm44K21ZbnBYTmo5cnUzNTIzV3o1cGRXblVpWm1iTFQ0?=
 =?utf-8?B?MDBFemNxNVI1TkZBbUtzT0F3L2wxS1laUlJQMDUyTmFhU2ttbGZmdkZCMTZ2?=
 =?utf-8?B?YVJtYmVJUHIzOFp2RElYUFZBTS9yNXFQalpLMVFuNjFGZmRWbkhtUngxenZh?=
 =?utf-8?B?c1VZWHQxTTBNMWg0U0Ztc05HdkJZaHJaRkoxeWh2QjExSC9WcUthcWE4UVQw?=
 =?utf-8?B?NVFiTjBjeEFndGZqR0d4a1RrNEJRd3U3Sk93T2ErMUQwRGQ4MkFEdUcySjU3?=
 =?utf-8?B?aDhLcExObktaOXVjLy9FQzBHR0lvcUxmSjFyTlBKNDdZZkpvcnJLSWpOdFE2?=
 =?utf-8?B?NmZHSjd6WFdEeEpwTnpqb1J5SDZmUWdnZE1uY3lwV1c5czZ5RkxEWG5MaWxP?=
 =?utf-8?B?V096UW5USktyZUUxUnlYVzEraUVlUWN4Y3FVcWFDajFLNGpYeEFyVVJYWDVu?=
 =?utf-8?B?T2ZKbzRQd0VEL0ZpZzVEN290YkJ0Y3UxbVV0Z2ZHUmdhYWZxV1hXYlB0M2Z2?=
 =?utf-8?B?RGJBNHo0Y1MvRFkyU1ZoZEhveU9kV0dUbE80d2Z3T3VuZ2QwU0F1RFhOdzlr?=
 =?utf-8?B?VU10L2JmWHo1Njk1cHZZaWwrOTRoWkRuTFVOWGFHU1c2Ung0T0lMZTJRZGhS?=
 =?utf-8?B?TVIwanFQbFVGNWZDL2ozNnhyYXNBY250YU5WOTVXTk9TdHF1UjM5QXAxdjFI?=
 =?utf-8?B?N3IzVkZjUzhabmJHamQ5NUJTbkVMWDVlTWNkZU9sdG5sUkl3cFJqcEhObVFY?=
 =?utf-8?B?UXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2da957-60c3-47b0-1d8e-08ddea4996aa
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 17:53:13.9867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbcvjLLSN2DxMzsbKB00QwgWodaFFAcEZEFFE3pGk7NuCUJZXPkF9ZOxxq32ipODU249vMSBEEH2KGMRXFyluQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8444
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=jan.kiszka@siemens.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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

On 02.09.25 19:48, Warner Losh wrote:
> 
> 
> On Tue, Sep 2, 2025 at 11:37 AM Jan Kiszka <jan.kiszka@siemens.com
> <mailto:jan.kiszka@siemens.com>> wrote:
> 
>     On 02.09.25 19:30, Warner Losh wrote:
>     >
>     >
>     > On Tue, Sep 2, 2025 at 11:22 AM Warner Losh <imp@bsdimp.com
>     <mailto:imp@bsdimp.com>
>     > <mailto:imp@bsdimp.com <mailto:imp@bsdimp.com>>> wrote:
>     >
>     >
>     >
>     >     On Tue, Sep 2, 2025 at 11:18 AM Jan Kiszka
>     <jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>
>     >     <mailto:jan.kiszka@siemens.com
>     <mailto:jan.kiszka@siemens.com>>> wrote:
>     >
>     >         On 02.09.25 19:07, Warner Losh wrote:
>     >         >
>     >         >
>     >         > On Tue, Sep 2, 2025 at 10:49 AM Jan Lübbe
>     <jlu@pengutronix.de <mailto:jlu@pengutronix.de>
>     >         <mailto:jlu@pengutronix.de <mailto:jlu@pengutronix.de>>
>     >         > <mailto:jlu@pengutronix.de <mailto:jlu@pengutronix.de>
>     <mailto:jlu@pengutronix.de <mailto:jlu@pengutronix.de>>>> wrote:
>     >         >
>     >         >     On Tue, 2025-09-02 at 18:39 +0200, Jan Kiszka wrote:
>     >         >     > > > I expect us to be safe and able to deal with non-
>     >         pow2 regions
>     >         >     if we use
>     >         >     > > > QEMUSGList from the "system/dma.h" API. But
>     this is
>     >         a rework
>     >         >     nobody had
>     >         >     > > > time to do so far.
>     >         >     > >
>     >         >     > > We have to tell two things apart: partitions
>     sizes on
>     >         the one
>     >         >     side and
>     >         >     > > backing storage sizes. The partitions sizes are
>     (to my
>     >         reading)
>     >         >     clearly
>     >         >     > > defined in the spec, and the user partition (alone!)
>     >         has to be
>     >         >     power of
>     >         >     > > 2. The boot and RPMB partitions are multiples of
>     128K.
>     >         The sum
>     >         >     of them
>     >         >     > > all is nowhere limited to power of 2 or even only
>     >         multiples of 128K.
>     >         >     > >
>     >         >     >
>     >         >     > Re-reading the part of the device capacity, the rules
>     >         are more
>     >         >     complex:
>     >         >     >  - power of two up to 2 GB
>     >         >     >  - multiple of 512 bytes beyond that
>     >         >     >
>     >         >     > So that power-of-two enforcement was and still is
>     likely
>     >         too strict.
>     >         >
>     >         >
>     >         > It is. Version 0 (and MMC) cards had the capacity
>     encoded like so:
>     >         >                 m = mmc_get_bits(raw_csd, 128, 62, 12);
>     >         >                 e = mmc_get_bits(raw_csd, 128, 47, 3);
>     >         >                 csd->capacity = ((1 + m) << (e + 2)) * csd-
>     >         >read_bl_len;
>     >         > so any card less than 2GB (well, technically 4GB, but 4GB
>     >         version 0
>     >         > cards were
>     >         > rare and broke some stacks... I have one and I love it on my
>     >         embedded
>     >         > ARM board
>     >         > that can't do version 1 cards). Version 1 cards encoded
>     it like:
>     >         >                 csd->capacity =
>     >         ((uint64_t)mmc_get_bits(raw_csd, 128,
>     >         > 48, 22) +
>     >         >                     1) * 512 * 1024;
>     >         > So it's a multiple of 512k. These are also called 'high
>     >         capacity' cards.
>     >         >
>     >         > Version 4 introduces an extended CSD, which had a pure
>     sector
>     >         count in
>     >         > the EXT CSD. I think this
>     >         > is only for MMC cards. And also the partition information.
>     >         >  
>     >         >
>     >         >     > But I still see no indication, neither in the existing
>     >         eMMC code
>     >         >     of QEMU
>     >         >     > nor the spec, that the boot and RPMB partition
>     sizes are
>     >         included
>     >         >     in that.
>     >         >
>     >         >     Correct. Non-power-of-two sizes are very common for real
>     >         eMMCs.
>     >         >     Taking a random
>     >         >     one from our lab:
>     >         >     [    1.220588] mmcblk1: mmc1:0001 S0J56X 14.8 GiB
>     >         >     [    1.228055]  mmcblk1: p1 p2 p3 p4
>     >         >     [    1.230375] mmcblk1boot0: mmc1:0001 S0J56X 31.5 MiB
>     >         >     [    1.233651] mmcblk1boot1: mmc1:0001 S0J56X 31.5 MiB
>     >         >     [    1.236682] mmcblk1rpmb: mmc1:0001 S0J56X 4.00 MiB,
>     >         chardev (244:0)
>     >         >
>     >         >     For eMMCs using MLC NAND, you can also configure part of
>     >         the user
>     >         >     data area to
>     >         >     be pSLC (pseudo single level cell), which changes the
>     >         available
>     >         >     capacity (after
>     >         >     a required power cycle).
>     >         >
>     >         >
>     >         > Yes. Extended partitions are a feature of version 4
>     cards, so
>     >         don't have
>     >         > power-of-2 limits since they are a pure sector count in the
>     >         ext_csd.
>     >         >
>     >
>     >         JESD84-B51A (eMMC 5.1A):
>     >
>     >         "The C_SIZE parameter is used to compute the device
>     capacity for
>     >         devices
>     >         up to 2 GB of density. See 7.4.52, SEC_COUNT [215:212] , for
>     >         details on
>     >         calculating densities greater than 2 GB."
>     >
>     >         So I would now continue to enforce power-of-2 for 2G
>     (including)
>     >         cards,
>     >         and relax to multiples of 512 for larger ones.
>     >
>     >
>     >     It's a multiple of 512k unless the card has a ext_csd, in
>     which case
>     >     it's a multiple of 512.
>     >
>     >
>     > More completely, this is from MMC 4.0 and newer. Extended Capacity SD
>     > cards report this in units of 512k bytes for all cards > 2GiB.
>     >
> 
>     I'm not sure which spec version you are referring to, but JESD84-A441
>     and JESD84-B51A mention nothing about 512K, rather "Device density =
>     SEC_COUNT x 512B". And these are the specs we very likely need to follow
>     here.
> 
> 
> You are right that this is in the MMC spec. However, the SD spec is
> controlling for SD cards.
> 
> SD Specifications Part 1 Physical Layer Simplified Specification Version
> 9.10
> December 1, 2023
> 
> Section 5.3 describes the CSD. Version 1.0 (which I'd called version 0
> in an earlier email because of its encoding) is the 2GB rule. Version

< 2G or <= 2G? For eMMC, it is <=.

> 2.0 and 3.0 encode it as 512k count (from 5.3.3):
> 
> C_SIZE
> This field is expanded to 28 bits and can indicate up to 128 TBytes.
> 
> This parameter is used to calculate the user data area capacity in the
> SD memory card (note that size of the protected area is zero for SDUC
> card). The user data area capacity is calculated from C_SIZE as follows:
> 
> memory capacity = (C_SIZE+1) * 512KByte
> 
> The Minimum user area size of SDUC Card is 4,294,968,320 sectors
> (2TB+0.5MB).
> The Minimum value of C_SIZE for SDUC in CSD Version 3.0 is 0400000h
> (4194304). The Maximum user area size of SDUC Card is 274,877,906,944
> sectors (128TB).
> The Maximum value of C_SIZE for SDUC in CSD Version 3.0 is FFFFFFFh
> (268435455).
> 
> So SD cards are yet again gratuitously different than MMC cards.
> 

Argh, then we need to take the card type into account as well. Need to
rework my patch...

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

