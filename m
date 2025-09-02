Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE48CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 17:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utV6n-0005pJ-J6; Tue, 02 Sep 2025 13:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1utV6j-0005oC-O0; Tue, 02 Sep 2025 13:47:49 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1utV6f-0001xz-LD; Tue, 02 Sep 2025 13:47:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8cqXm/65fnlR+1IVP3XRnPgcrQ1KlyEnJmNlWhtbtYyCV/4ds8zcZO0WTXCkjEftNUFs0uyGBi2eGEQ/ahzP04V5gv8RULkvLLHTu+E4jc5sDSauueEcgbgPms5Hl+GGdVYi8s5SpnUeT2iQRjIcSAK8ooBMJNdYNXhyzRA8Auz9sMc8OawZlbXi1sqkpnYj8esE34L2ximwoy6LLZ7ldNaPfYCpchq79j/ah587ftx6gjfefwwY9XzUfAnfixa7YfjAZNJ8z+L34AWIui4sz0HEfkUzUC8DqY3W1XQReBn0yYpvoTg003LH1iUz/cTEGJvsdw951UTSwrNQXtd6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ned5xGEPiSn66E4B0ONT+Ar/q92z8qcqGPGPl+dRxio=;
 b=BleN6LaZTCrBtOwlT1v2WPSUJExsSL6t9870N2DmaaH4alrVQoPdxhVqru++XRwfQn2RWwzEgllTU7baxEjIFV/6+JpkUs003UtZMYDPH06vAcSYgRL1lm4gtUm6sEeVUQ/+4mbnxOc5lNbzPhzXeUaCAoez+eE++3bUbWDlLJoAZCUj9xlkhOxNB0Kuy+Js6N0qdKx1XXQ4MlZib4O6bKHpCO1ttN+7k9kE147q1gJTBX7BxGubPt6WkDfkEUf1vVVlP74ocnALvcpqboeReArL0M9dxntkUbbzu5w4HYga1fAyDZ9L//73dJDe7Ve+IJp8kqcS37pz2da2JO5QXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ned5xGEPiSn66E4B0ONT+Ar/q92z8qcqGPGPl+dRxio=;
 b=a8qlClFWEFtX1x8y1bO/3Tmy2J0rwwrSFYv15HU3ZmpGcn013MDC0X84SPVo3PxpEi3klnOryQktexXnw0MJA7sbdfvM0pYZJW962JCSCmnU6/PQ0PE63Kbih/UDJaOnFrSUyYWCVsw8hs2vso82DMvGMxe+Wn4+bms+HUejG2NfoWYFKG10l+Zi/f2soQA41nyltJpO33jIgj1zehPvA7oLGPS5000frokIPySrl1VW1KYExhr18PfynFtSAMaGCiAiYVyobZa4tqcLUdP9omcj47VkCIsP30UPcZ4tOIBZELXIv6Nu69Ujpy0JkUomi/EdmCC9mSYCAgC8k5uvvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by GV2PR10MB6455.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:ba::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Tue, 2 Sep
 2025 17:47:36 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 17:47:36 +0000
Message-ID: <9f7fc688-7676-49ff-8f86-fac347f70f05@siemens.com>
Date: Tue, 2 Sep 2025 19:47:30 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] hw/sd/sdcard: Fix size check for backing block image, part II
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-block@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Jan_L=C3=BCbbe?=
 <jlu@pengutronix.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>, Alexander Bulekov <alxndr@bu.edu>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0048.namprd14.prod.outlook.com
 (2603:10b6:610:56::28) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|GV2PR10MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: 89c876d8-f41e-4635-3cde-08ddea48cd91
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WURPdHNKektDcFJXbmFLa29nL1B5OXd5bjBNZFhvdXl4eGtBRmhORHk4MW14?=
 =?utf-8?B?aTJjT05NMGVLR0ZDYlJqOGpBVjV4ZFBTMXVTN2k2MGNIRStNT2loQmNZcUEy?=
 =?utf-8?B?Q01XeGlMM3o3Z3h4amZKaWlETjByOGhjWm9OUG91clp0dEN1Zy94VXNvSUJu?=
 =?utf-8?B?c3h1SWFKSTdyRXRBVEFCeVpCT2pnSWZSdURSL0FybWxGZUVNbjd0NUxXQ2RC?=
 =?utf-8?B?cjV1cC9TTVZ5bUhiVk45dXRjTlRlR3pJaGJFTkRTNFUwME5ZUWVqUWMzL2dr?=
 =?utf-8?B?YWFCY1FLSTNXMXhrQkcrMG83elU3OTVDUWVFZHljeTN4aERhSWovM0lITHpp?=
 =?utf-8?B?cEFxNFE3d1NuRnVuc1ZhS3R5UVlVbXRQSDI1QjJxTDRnTmlodXF3VTBsSTdr?=
 =?utf-8?B?elE2RkMzbEV6WHpYazJCclBweTZReVhvaklnWExuVzBnZHpkaDVYeHk2TTl1?=
 =?utf-8?B?N2NuMmluMWw2YTQrMm1oa09ERUNjZHhVam5leXdjd0lxYmswV2t1clk5bnlM?=
 =?utf-8?B?ZlV2K25ZYWVKYTB4NTlYRWhYYUlXSXpLdFpFVUxJaFBIUkE3TnFsZnFXOXpW?=
 =?utf-8?B?aXRzdFNaU3hFWksxbXJ1L0wzeUJmdGFwcGQ5VU1JaFNHcTRSYmF0dlJsUGFX?=
 =?utf-8?B?TDR2NTRDZmJzQmNlSTlDTTNFa3VVSlBraTM1dGFjTEhqVDQyS1pzOWJ2MW55?=
 =?utf-8?B?YlVNVGUyUFZ2TUh0dXFpUXd2M1BXYXlZQ0t2c3JObXVibTJCc3dGc0IwelJr?=
 =?utf-8?B?YWFHK3VqTVhNNGtmRld4cmRwNE9scElmR1VVSnRoVXZmZ0Z6dERFRGtDelZQ?=
 =?utf-8?B?K1lhVXBJZlF4MFdkL05oRi8wNm1kdkl3TUl6T1BnNzJEVEE1Qm04SU9KaFVG?=
 =?utf-8?B?R2czSmIwUEpuUjBsSEhwRjcrNHhla05jY3p6NHNVVWNvWEFRLytMa3dZNDJz?=
 =?utf-8?B?NXFQQVhNbHViWHpYQ0dQVUhYVVZyOG1LTHptaTF0OXRaaEdvWkk0cjNyV3JQ?=
 =?utf-8?B?YXdhV3V4M3JseHdaQThtWkxnYWN6MFZ6OGtzYXZFeUpCajZJU1o2MmhvY29F?=
 =?utf-8?B?bXRyTWJRRVFwbzJaN3lvWHdTQi9uZHBqdGEwSGcxN1RRRUpLVG9YeUdiQm9J?=
 =?utf-8?B?K3JvUk9VTTNGTEMyVFVXRUZCMFBPRE50aVhVL29rUWJONTk2RURNdHB4NFV6?=
 =?utf-8?B?NzdEeHNGN214Tk5ML1Y0TXhDUjMvNzNxTTY2eHJvd05zUS9TQWl5aWR5amg2?=
 =?utf-8?B?cHJWczJNeFJBZ2tvZFU5SWpubENMMEh0QlU0eDRTZFp3eFBrY29KUG9mdk15?=
 =?utf-8?B?aFh5cW9oYXJEOXlaVnJHVDZRMXk5ZU1kMjJIVTh5RFN6ZFZDUHRyeHdENmdr?=
 =?utf-8?B?ZmQ3QVFNekkrME1DcHpMRzF5b1Y2dTFWZXBESmljSFkwTS9mT2FIUWJnRHU5?=
 =?utf-8?B?KzJwNFBrMVZJMmNHSmtoLzM4MnZCQ3hlV2F0cHlNalVLb3Y0NytHaHhyV0p4?=
 =?utf-8?B?UEdQWWFEaWxCMnU2QTcvTEtaaXZaU3hNdEVPQW1pYi9zOUxhK0JmVGpLell4?=
 =?utf-8?B?ejRxSHhybG9nSDlsRCtZYUJ1ZDY2SEgzVGNBTWxsbkJiNXFLWFRsNFR5OVkr?=
 =?utf-8?B?Q3pFTDFZVFJLYUFwREJrTzJwRW1COXAyWUh3TGczMG45cUJTODd6VkhnQjdP?=
 =?utf-8?B?RnJ1d3VkWHJxditjaVNla0duak90eWZFVjR1UzB5c2JHTkw4L05Zdm9ldkJ4?=
 =?utf-8?B?Yk11U3ZLdEQrbWNSY2o3WmE2a0RZMzhHQnpldTZIajkrQnE0UTVlYUdwKzk0?=
 =?utf-8?B?L3Uza0ZwVC80a3MzSTFDRU93clFWallFNG4ycmJ3WlBab3ZoUnpNRlAybnJH?=
 =?utf-8?B?RnpndVJ0dGdVTnc5TEJMQTFHRk1hNUZhbElwSFdtOG13RnpWVFIySTVkNjZO?=
 =?utf-8?Q?iUs4jTPF5VU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUNZNUJSOTkvRXhvQ0NGWUJqVzJaWXBsZWJURC9QUUl0aUVQY1NFWUcyN2Y3?=
 =?utf-8?B?c1VXaFRsOStWNzYxSlZxa0cxR2hYbG5BVFY3a3BTM1dKVjlnMGREeEYyUjNG?=
 =?utf-8?B?ZHZHUTRiTjNwTWxkVnVhWUp2M2tFM2MzZmMvQWsreDc5SHQyTUV4ODFNcWgx?=
 =?utf-8?B?c05zRHRISExlK2ZVRzRHUnBhbmdPdTZwVERyZXNsbkRjQzdTOVJjZ3JkY2hw?=
 =?utf-8?B?QjN0NlBZOHRQeWIxYy83K1lzZHNDZlhXN3poTmFvaUpwSkhyN3pJTzVzUVBi?=
 =?utf-8?B?TE1Sc3cyNjArVGRGR1o4cmErbS9wWXcrK2hRa3BOMEdFYUxpVm04VXhDTGhm?=
 =?utf-8?B?V2ZaekRmOFRrc2dET2FWVCt4N055TXFKSXpuUzlhZGpEUWJKZytMRERiUUVl?=
 =?utf-8?B?UklzZTRHVUNESEd4QWpkQ1g2N1FGR3l5anBmejRhbTljZnZDbFdEMG41N3B2?=
 =?utf-8?B?RTIzOStUN1ZBL3dYaWdmekVJUDB3N2tXSzZ4T2c1NGdGRllJbHlzNk9EdU1F?=
 =?utf-8?B?RHpoaTRPV3U1OHN6V1JRV3lVMi9EelFIWGNRM2d2ak5RTnBaUjVOSUtheEp0?=
 =?utf-8?B?aG9nd1dkMGhtQUo1eklKanh4WFY3dXBvcDljL2dId21iYzNkSExjaEF3T2Uz?=
 =?utf-8?B?aHdIV3BiWWFGUGxXdFkvQ1M1cVVzdENtL0FmRjZmRmIxTytIWHJGVis3TGNH?=
 =?utf-8?B?OFl5bnVLcGJ4OHJCelduZjE1TVF5MTBid1FuRit4Z3ZYRjNuWlVyTFNLMytq?=
 =?utf-8?B?Q3Zub2ZUcUd5SWJKMWtTSGVENms5c05hMGQvRDBPRnFucGUrRWxtT1VTdEsr?=
 =?utf-8?B?TkcvVmNFclpzeFNVeThIUUEvandGanBiMzMwc0RZOTJIUG5nY3Q0eXVtUGFz?=
 =?utf-8?B?eE95TkZ0SnY5NFk5QnJNSzJMY0lQVEVPZmFVd1lXVVZHVHdubkwzTWEvVWl2?=
 =?utf-8?B?cXZvZ0lqczZFWnpIeXJhK0k3TmN3SjNiS1N6QjhOdXVqWjBoajYrLytnTnRI?=
 =?utf-8?B?ekt5Rit4SUxGRUdtZ0MzNWNERGFtRUVpMjc4L0RsUUVUeXh1YzllT0VtbG44?=
 =?utf-8?B?SHE5VExZeTZ5YWMxNEl4clc5ZzBsTEQ1SW9FZkNpVjhxZ1F4TUlZbjFweitW?=
 =?utf-8?B?WEQ5VURrTlVEZEFIUThCRDgycHhRTW1vOGhta3MvMHZTSm9LUURvNGtZK240?=
 =?utf-8?B?NDBDbE5iRUFMN3M5VkVFdEJTSHZNK3pLWnpSZWtXVUF5NEJqVXVkUzhYYVV4?=
 =?utf-8?B?eVJhUG1FcHYvclRCM1pPc3c3UjBLbm9DbHd3TTBxRlJHU1duZ3JIUnBNc1BY?=
 =?utf-8?B?NEljSkg3UnRMRTFsV2c1U0duSGt5eEViVGU4RElhMkpmRStDczdQM0thZkpq?=
 =?utf-8?B?elN2MVRRbU4rSzd3MzRjUkI4WnE5UDk1eFp4bklUTTNTZzRDUW8wU0NMT0dm?=
 =?utf-8?B?bnRHMnArMGJ6bitvUWtkdDNzUFJTdlNSamQ3TlovdTNNN3lhV01KQmsybWZm?=
 =?utf-8?B?d1NUSUlqWWhCQVBGeXN3b1luekNMSkJMdjBCK05hY3FZWW1Jbmpla0V0ZUdP?=
 =?utf-8?B?eEppYWlURWsyM3VqUkFrQ1lNbmtpcHZrQncwL0c2eUozOTlaS3pYazMwWjRp?=
 =?utf-8?B?c2doV3FPQWpIdVdqVmM2QTF6RUJtN0hPYU95NFNsR21BL0VvbWpXLzZYa0ly?=
 =?utf-8?B?TlRWMU5DTkFJZUd2NnZDRElhUExPbjM3T3FjNkQ2TTVQQUhnWWFySC9ydUwv?=
 =?utf-8?B?MUNVbkw0WlkvMnI1R04yeDg2NmJGWEIremFrTTI4ZkxSRFQ1VGwxdDN2OXl6?=
 =?utf-8?B?ODdyVkJMY2NNQ21mNGJXU3ZkVHl1a2R2ai9nL0M2NWt2TVBpQnZCc1VTWU95?=
 =?utf-8?B?TFpGamtQY2ovL3JReDRQK05JQ2UzYjBFRDMwUEVGSlU3TWlFdGM4RWNUR3JD?=
 =?utf-8?B?bnhwaUdhUzFEYkpRV1grRWgvMUVqMHdsUnFBRzhDK3JIL1haRDEvbEJiNy80?=
 =?utf-8?B?Z1NNd2pxN3RFeG42djh0UjRZNGlLVUZJQnQ4L1hrSVRPZ3B2bkk4eW5oZnJa?=
 =?utf-8?B?cGFlSm5vVGE3SExLOFJXQy9WM1pVL200dkpwaGQyQjg2WmR1YkROcC9ZNVNG?=
 =?utf-8?B?YVZyRFphS2Ryc0tnVnNmT3hjUW85bm5TaysrM2NWeFVqVWlPK0Y2SGNPYloz?=
 =?utf-8?B?Zmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c876d8-f41e-4635-3cde-08ddea48cd91
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 17:47:36.7394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBPqeawX+C8HB4kNNvCcA6XPPLbA1L+RWUCBwnIVw5MJW9VMr7Lwdq85lpFaI0uPWt2TixtWgwxc9ZPr/xn42A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6455
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

From: Jan Kiszka <jan.kiszka@siemens.com>

There was another mistake in the size check which 8c81d38ea5ae now
revealed: alignment rules depend on the size of the image. Up to and
include 2GB, the power-of-2 rule applies. For larger images, multiples
of 512 sectors must be used. Fix the check accordingly.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Not fully tested yet, but as staging is broken right now, I wanted to 
provide this already for early feedback.

 hw/sd/sd.c | 48 ++++++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 2d34781fe4..0f33784bd0 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2759,6 +2759,26 @@ static void sd_instance_finalize(Object *obj)
     timer_free(sd->ocr_power_timer);
 }
 
+static void blk_size_error(int64_t blk_size, int64_t blk_size_aligned,
+                           const char *rule, Error **errp)
+{
+    char *blk_size_str;
+
+    blk_size_str = size_to_str(blk_size);
+    error_setg(errp, "Invalid SD card size: %s", blk_size_str);
+    g_free(blk_size_str);
+
+    blk_size_str = size_to_str(blk_size_aligned);
+    error_append_hint(errp,
+                      "SD card size has to be %s, e.g. %s.\n"
+                      "You can resize disk images with"
+                      " 'qemu-img resize <imagefile> <new-size>'\n"
+                      "(note that this will lose data if you make the"
+                      " image smaller than it currently is).\n",
+                      rule, blk_size_str);
+    g_free(blk_size_str);
+}
+
 static void sd_realize(DeviceState *dev, Error **errp)
 {
     SDState *sd = SDMMC_COMMON(dev);
@@ -2782,24 +2802,16 @@ static void sd_realize(DeviceState *dev, Error **errp)
         }
 
         blk_size = blk_getlength(sd->blk) - sd->boot_part_size * 2;
-        if (blk_size > 0 && !is_power_of_2(blk_size)) {
-            int64_t blk_size_aligned = pow2ceil(blk_size);
-            char *blk_size_str;
-
-            blk_size_str = size_to_str(blk_size);
-            error_setg(errp, "Invalid SD card size: %s", blk_size_str);
-            g_free(blk_size_str);
-
-            blk_size_str = size_to_str(blk_size_aligned);
-            error_append_hint(errp,
-                              "SD card size has to be a power of 2, e.g. %s.\n"
-                              "You can resize disk images with"
-                              " 'qemu-img resize <imagefile> <new-size>'\n"
-                              "(note that this will lose data if you make the"
-                              " image smaller than it currently is).\n",
-                              blk_size_str);
-            g_free(blk_size_str);
-
+        if (blk_size > 0 && blk_size <= SDSC_MAX_CAPACITY &&
+            !is_power_of_2(blk_size)) {
+            blk_size_error(blk_size, pow2ceil(blk_size), "a power of 2", errp);
+            return;
+        } else if (blk_size > SDSC_MAX_CAPACITY &&
+            blk_size % (1 << HWBLOCK_SHIFT) != 0) {
+            int64_t blk_size_aligned =
+                ((blk_size >> HWBLOCK_SHIFT) + 1) << HWBLOCK_SHIFT;
+            blk_size_error(blk_size, blk_size_aligned, "multiples of 512",
+                           errp);
             return;
         }
 
-- 
2.43.0

