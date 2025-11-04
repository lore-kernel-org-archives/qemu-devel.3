Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA8FCCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 14:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGHoC-0001cx-DX; Tue, 04 Nov 2025 09:14:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vGHoA-0001ce-Qh; Tue, 04 Nov 2025 09:14:50 -0500
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vGHo8-0004o8-S4; Tue, 04 Nov 2025 09:14:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUxT9A3vdy9wi+mnQvahoiDkschXOe405jjAyJL4PfzHtnjlnFBUIC2yNhw6S5VZ5uQzHlk2ZaN+dG+1+PSER29IGFKKizgTq/89ohoPCNzlUyZTDWnjMjNT01WBSMIMYPonoX7vXsyVk/oHENtvatToC2xPGB+Uj5uAp2v5E5+Mc5K6slh3VdxNvvmBCsiZbhP3A3oNMa5Zu0HxZnCDchrfK36HxB/ZeGlxZIHrNkQKPiWfp+iUszlw7z/ak8fz6ekZ9k4mK0gQEqmH9XhZf1kLu27FRd6TCqgq+4s9voceJOXo456IPc6yDl6a/K/FRWhZBuHBIqdBFjzV/DSxsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62II8EE4mPrPECgEX8QpZlvPGMRyuXe+updoAcR5TWQ=;
 b=qsfEnrL1kyBTggbnoxpWdYo2ZQgMBYvETnGyshHmqTZwhdy9nQ08SSIHNzkK/7BWTGLreuGBeg97wExZU6NFb8PCZsfZuo5S9llEDx2clOAiTMtqZ5aE/G1QLC1GaZKVxC0jiZCNoxenUvSc/fz0CQWairRt0szW/IiF5yLx2jgE1sgaZ9EGsdd13Q1CZbecKstTNiVPLEVknadXAnUFy7fWGtgStxf11tJTj4r/mKeLl2d6LIg/h+sJF1sGFpiLd4Q5fPnVreAc3rV3yKGFOAaDU7yuF71tvyaYn6TeqiMM+WbJAqMDYVZCeWIioSUa5Nvo/qUzqPamdc3SJ2/pqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62II8EE4mPrPECgEX8QpZlvPGMRyuXe+updoAcR5TWQ=;
 b=rHsm1sw2pc5o4W1pVd/yjJW40cH4WUSHzBcYjgG0bzvXSdJdX6b5R9zqB4sG1HLvMR+ih8TwVB6UykuDcnCK8+pAicCLiBq/x32YQ7PuuBzHKzwFmjH87rmpoo/JNd1l0XVUg6lPB5TFb5eAeFwGaJ/Wl6ndeEVRsWwJb1qSYJ/hpYbbcjtEdj1WaXe9GuEQDvUlOcNzdXfnHjXgs/GhZBdvE7FWer6OKzuTZAuD1aRiw7hjAqJ1Tts6qRNGs99UdJtbVEKZ2QCYH4fHxWzbdOfFj7iKW9O5yr6ok5Oc/mOLNobDiIYzvVFt0MsVNDxiek7yT/UAI78G7+s8PEhYNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7535.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 14:14:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 14:14:41 +0000
Message-ID: <278cae30-6852-4089-84b3-f4d4710143dc@siemens.com>
Date: Tue, 4 Nov 2025 15:14:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] scripts: Add helper script to generate eMMC block
 device images
From: Jan Kiszka <jan.kiszka@siemens.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Eric Blake <eblake@redhat.com>
References: <cover.1760702638.git.jan.kiszka@siemens.com>
 <5c9c6495ad4afc9d11f856bafcb797fed8fccecc.1760702638.git.jan.kiszka@siemens.com>
 <bfd49f9a-0a37-4e1d-b7e2-f0e59943915e@linaro.org>
 <08287450-4889-4329-b21c-87fde274b13f@siemens.com>
 <b4becb69-cf74-4e1b-97f3-52756b8a69d2@siemens.com>
 <dcb21299-f6b1-489b-b952-aafd64dba31a@linaro.org>
 <55f73b5c-a4c5-463b-a507-6617ebde67b0@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <55f73b5c-a4c5-463b-a507-6617ebde67b0@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7535:EE_
X-MS-Office365-Filtering-Correlation-Id: a44110da-1147-4acf-51ba-08de1bac7f2d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UW5teFp1MHMvb2hHdEpFYTU0THVpbjlzUmZJY0dOQkFEZVhDUFFhTmJabXI4?=
 =?utf-8?B?cVRSME5XVGlSUnFOc0FQR2lSdUVIWGM0SEtUYUtzSDF2cFRkSURxT04zMlkv?=
 =?utf-8?B?R0R0Slh1OWNmOXhQKy9mdDVvZmZMWHVTV1VFZFd2eHN0SjlWOTlrTzZMblht?=
 =?utf-8?B?YStZWGlRNFI2VEIvUVh2Yms5TE5WZEcwcXlzbmFuelJnNlVFRk03aSs1T0Q1?=
 =?utf-8?B?aGNYSGVhTXJueW5CT0pnTjFneVBGUUxPK3lFOWVvL3ZQdkdOKzJmOHdyL2JQ?=
 =?utf-8?B?K3NVVlJWNGcxMzlPL3hxN0FwaXBIcDlXZjlEK2R0RTdtalN2Q0x4b0F0bUtE?=
 =?utf-8?B?ekMrOEM5ODFOSHZtN3ZLSHJnK1pLNVJqT3UvL3pOaTdDV0JFUXpTbGhMdmF0?=
 =?utf-8?B?SmVYMFJCVTFqWGRWbUVxVlAyZjkxRCt1S1piOG5FMzJWV2h0RWZXNDkrai9H?=
 =?utf-8?B?VVhVV2xTZktma2hNcGREV0JvZlJqRnNLYmxYQzVaNGVBaG9Dc1FuQitPMm83?=
 =?utf-8?B?M2VBblZCSS9NQmd4NWtmN0hEZFo2MjkxQUVkSUVqMSsyb1haQmpCYXhSa21F?=
 =?utf-8?B?bFp2SmFybm5yZTArODBDNDNBWDM1Nkt2YkVqanR5NTF2eHZIT1JNazBRS0x2?=
 =?utf-8?B?UWh2TWZXTUxManFVaFlQQ28wYm5IcWxVWVNDdkxoSXFyQldlakNPWHh4cFF4?=
 =?utf-8?B?ajlUYnZKazZYNE1saVE2NzUvbEFzcUxjQTAyRUR3T3ZXU0o0YXgxUWZjd3A5?=
 =?utf-8?B?WjF2bnAvV25ET1JqblZ4VGRSNkxHTE5WUUxzRXl1L1NxV2tDSDlFZUowQVhE?=
 =?utf-8?B?UzZST0hMLzlGWmRxdFRpK0IyOG43SHFnSGUxYXNyYUlLZnN4UVg1emF3RXAr?=
 =?utf-8?B?NXFHR1NEVStYN3lOZVNYQkovdUlOcDJWU1lTWURGWjRRdndicDl5eHk4ZG5Q?=
 =?utf-8?B?R3NNak1sUGZBVlFjdTYycTNyVkwwTjBvazgyUnhMSDdtakRuMC84ZXArdmdv?=
 =?utf-8?B?TklMOFQvMjhQNlVoWmRxeTlnd2FQUmJXenlvSTBPdmxrd0tubXkzd0hQSk1I?=
 =?utf-8?B?NzZ1blVQSmlNdFBuUlVyVDN5NXpOV2FqY1Y0ZVRLVGoxRVk5Q1cvUHpzdzdY?=
 =?utf-8?B?NndObFZzNVRxZ0lxSHZGb3Y4ZjQ2aVllOTVzb1IrazYvWExwVHBSeVEwOE45?=
 =?utf-8?B?di9kNnIvTmlIVEJqV1NOeTFBdDVWSk5oMXVod0lOSWV1SWFSeitMTFNSeGw1?=
 =?utf-8?B?SkQ3YjlMZTJkL08wS1RFd1dtcGVlVlR6T3psNjRMbE9sWXJrWGNzWFlVZHpo?=
 =?utf-8?B?bkI1VmZTWjB0S1Q5NnpET1RpS1pQcG5YZEtVQnZPR3RyazVubm9PRTZSUnU3?=
 =?utf-8?B?dU8yYjN3NHdicnRzV1BETVdHK2J1YXFZdlNPbk9iQWl5YnAwU1IyeTlhZTZE?=
 =?utf-8?B?eGZWSGdwQzZLOENpMTc5T28vZnV3eVY1VXl1cm03L2QwekIrNy9kblRNRzk5?=
 =?utf-8?B?b1NaRm53TVdjNW5pYUR5eERoVGI5WldlVnF5VkdrUXN1dHpEUTM4Q3BsR3pt?=
 =?utf-8?B?U2xRVGJPTndmakRCazFVcm9pVGZwQ1dqZmw0d2JLVzNtaVFJY28xZDlKMGs3?=
 =?utf-8?B?UmFzUElrNjJUUVhMUy9oNmplZFBBajkxelFvdldyTndhUGJmc2VrWDE2WlVU?=
 =?utf-8?B?eGdFemZxRmlHelQwUHhDRDA5OXdFQ3ZFcWlvN1QraEZWLzJMWmE4ZTliU0Nn?=
 =?utf-8?B?UXJzOW0wMWJYN0J5bVAzZ0wyTFIrODFyQjlZSjVwbGpEeVl0dC9HNUF1UVNY?=
 =?utf-8?B?TGowU3Q4TldQRDNIVGVGTDdpSUYrOTNwMDU3WjhmKzBicUxCOEg0cjMvaUM5?=
 =?utf-8?B?aytyZUY0UnBoZDZQU1JwUFZhZCtTOXo4MEtvRHlRM2hTaDZqZjdzL1U0N1Fn?=
 =?utf-8?Q?0E8Z+9zERcuA2TkzWPcNOVucmWJRGggq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkNVcy9sQ0t0WWtUelpnQlpQLzNlVjk2WXQ5WmFYcFMvNFNKUFZZaEpaWjhI?=
 =?utf-8?B?QWd6Q3ZvRmpwQmN2OFJmWTBQNkluS3NKeXp2QmtiNTF6QjJMTXVFOEVCVlRr?=
 =?utf-8?B?ZmFVVmE4aWJtYlR6dW9LT09oRjJmSVpvQjhXeUgvaE4xTFpxbDFjRkxpYjhm?=
 =?utf-8?B?TS81YTNjN2l2dmVrVXpSekFJWmpiUzVuR3Z0UCt1eSs5SnlRdnB1VTFtbU1M?=
 =?utf-8?B?WmRWSEN1YTRXZjdrdFRRNXBIWGdQSjJyYlBtcG5KQ2xKOFBEeVVnblhMU1BF?=
 =?utf-8?B?VitWMEFPQWxudnB3T3JqM2pIbFRlU0FIQk9ZZ3hLNENuaHE1ME1RWmMyZHBV?=
 =?utf-8?B?TjJ1VXFaMUhhQXoyaWlWa2NkREZaWW1WU1JBN3VLTElmbzVmSk1uTDJHSkJm?=
 =?utf-8?B?WGpkREI4QnZZaTBXMVQzZEZGRWx3VTdxa0ZxbCs4anNBSm1Qb3c3eTFoc0JY?=
 =?utf-8?B?eUtPVnNqa3I4TEF6dk1oRk1QNGJUaG16THZUbTdxTlU1elZ5YzFYbEdFMnFl?=
 =?utf-8?B?Q2NtMU8rengreTMyQ3NROHFzZ1JjamdJWkkwaldTMzlQZlA5S3JwUWU2ZUVM?=
 =?utf-8?B?QkgyQkg0VzFhSVNqa0ZDWjlyNVJRVGpReW42WW1OTlNwUkkvVzBRdnVGNkpq?=
 =?utf-8?B?cDZXeXdXaWVnem9qeUM3c2FDMEk2Sk0xaU9MRTlDeGhSSDM1YlpoV0RVa3lr?=
 =?utf-8?B?dXlCM1pDa1NnZ3RFRHgwWDBMeG40Vmw3T2I1MW5MdDl0UWlmc3FlVmQvVHFw?=
 =?utf-8?B?RTkwRlVSajlRNjFVU25LMlZKNnpzWmVWTnJKd09ZbWJVdGVuNWcxOTNNQ0ps?=
 =?utf-8?B?cmd4NllhWkN2SGZRbTVhb0ZTMkRQSTR3N3dLZjNXSTIxYkdCZkhyekp4Z0dv?=
 =?utf-8?B?bzVlNC9obmg2a01SL1ZyRE9uT0FyalRiekRxeTdQVFM0UEtPL2FLRitmbTlD?=
 =?utf-8?B?Yk9hY0hLbFBwT09zOE45ODR0d2hWenQ5TmxxQVNuaTlTSkdaK25ORks3ODlV?=
 =?utf-8?B?K2JVWThMd0RUZXh6QmJlNHJWbE55V21CcWt2ZXBSdkFLRitQTzJaVjB3OHdt?=
 =?utf-8?B?N205VHQyazdNZHJ1aGQ3c1lLdWlOb3dsaktCajJkd0RUakRHTnQ4ZnAxaFFm?=
 =?utf-8?B?bjkzbHNCUnRCTm9tZVBIMVhqWEIwbDI0Yy96THNXK2cvaFRZMzRHOUVXMm5i?=
 =?utf-8?B?R29pbHN6SVA3Rkh0NU5WT1A1alVSUW9FYk1abkU0OFlDY3RjRDF6T2RSaHhv?=
 =?utf-8?B?SEU0clY2TG5LN3RJZERtUDhoN1hBNDFYTU5zdGxxemZkNkExeFJEWDdIazlk?=
 =?utf-8?B?RFhYaWdjaTJWb3o3NUI2MnJqWHliVStKYnNESDNaVjNDTlFNUWM2d2lLYTFt?=
 =?utf-8?B?eHRXMC9yVmF1UDZzd1BabU9IaVM3WmpHeHBJTHhmWURlOTl2Rnc3SWdIYlJL?=
 =?utf-8?B?YmY1YkpzMzN4RjhMSTNlK3l1eXkvNGdSN1RIMDZnVnNXMHlvWjV4SnJpcDZm?=
 =?utf-8?B?NkNFNklldVc1VkZnMkluUVZSb1BNNzlXTjNtTnllODlkdXVtdTVQQlp2ZVZj?=
 =?utf-8?B?cFFiZnhqRGpwQjJaRStjY29TVVYvL2J1b2JKWnBpYWdTUDhvL29zMFNTV2Fi?=
 =?utf-8?B?R2gwT0tGSHFoMHA4b3RFKzJMMDZlOVpwNkE2b3JSZXV0bS92U1RaTlM1aXhm?=
 =?utf-8?B?NWJuK2VUamVhNXV4VmJtanF1T25yNFkvM0g2NWlaUEpEcWRsQ0RvN09pT3Zv?=
 =?utf-8?B?aVB4YjF4SmJ6MEZKUFIrR0pZQzFPZktYK1dYM1hvWkp2QXZielBKejlhb21L?=
 =?utf-8?B?S0g1eVhNWlhXNTlveEh2amRLaTZjZENPemtFajJBck4ySnhoWElINGM3U3Ey?=
 =?utf-8?B?WklPay9MbFpRdVdOU012d1l6OUt6ZW8yRVpqaXE5ZWVBeGV2ZVdFcTBsUHUr?=
 =?utf-8?B?NmY5Y1JKcDlFZGtRUCtJOVhhUzJWSFFJbDRHaUsrMWw2UzZMVEQ1eG40ZzFO?=
 =?utf-8?B?MitjLzg4YkI4Wm15ZWEwV0tqVGJmYWEyMnRtSmZJM3docU9JWFRmZ0FTT0Nq?=
 =?utf-8?B?cGZqWlFaVWgrb2kwYU9OcTVSeE04eDRhZUNucWxNLzhURjI3WXJ5aGlYS0w5?=
 =?utf-8?Q?W4yOClszd4fdFnxdqpX2Oh9N0?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a44110da-1147-4acf-51ba-08de1bac7f2d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:14:41.7049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ar8/HFyPrvFYoaTd6C2zs5bWxZ27v18hNjaUMLFml4AG8PBj6IRLgF3xIwjQ7u4BGKr5KDYDophLv8+LiM90wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7535
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

On 04.11.25 13:40, Jan Kiszka wrote:
> On 04.11.25 13:33, Philippe Mathieu-Daudé wrote:
>> On 4/11/25 10:26, Jan Kiszka wrote:
>>> On 04.11.25 07:30, Jan Kiszka wrote:
>>>> On 03.11.25 14:12, Philippe Mathieu-Daudé wrote:
>>>>> Hi Jan,
>>>>>
>>>>> On 17/10/25 14:03, Jan Kiszka wrote:
>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>>
>>>>>> +if [ "$bootsz" -gt $((32640 * 1024)) ]; then
>>>>>
>>>>> Running on macOS:
>>>>>
>>>>> scripts/mkemmc.sh: line 165: [: : integer expression expected
>>>>> scripts/mkemmc.sh: line 169: [: : integer expression expected
>>>>> scripts/mkemmc.sh: line 179: [: : integer expression expected
>>>>> scripts/mkemmc.sh: line 191: [: : integer expression expected
>>>>> scripts/mkemmc.sh: line 200: [: : integer expression expected
>>>>> scripts/mkemmc.sh: line 202: [: : integer expression expected
>>>>> scripts/mkemmc.sh: line 204: [: : integer expression expected
>>>>>
>>>>> $ sh --version
>>>>> GNU bash, version 3.2.57(1)-release (arm64-apple-darwin24)
>>>>>
>>>>> When using dash:
>>>>>
>>>>> scripts/mkemmc.sh: 165: [: Illegal number:
>>>>> scripts/mkemmc.sh: 169: [: Illegal number:
>>>>> scripts/mkemmc.sh: 179: [: Illegal number:
>>>>> scripts/mkemmc.sh: 191: [: Illegal number:
>>>>> scripts/mkemmc.sh: 200: [: Illegal number:
>>>>> scripts/mkemmc.sh: 202: [: Illegal number:
>>>>> scripts/mkemmc.sh: 204: [: Illegal number:
>>>>>
>>>>> Should we replace s/[/[[/?
>>>>
>>>> No, that would be invalid outside of bash. There must be a logical
>>>> error.
>>>>
>>>> How did you invoke the script? What was the value of bootsz then?
>>>>
>>>
>>> I tried with dash from debian trixie, and there is no issue like yours
>>> visible.
>>>
>>> What problem could macOS have here? Will need your help, don't have
>>> anything mac-like around right now.
>>
>> Don't worry, we can merge v6 code part, and add the script / doc
>> during the freeze period.
> 
> I will send out v6 then. It passed local testing, and I addressed some
> further details.
> 
> A colleague with a Mac offered to have look tomorrow on this. It is
> always a pain there regarding the subtle differences...
> 

Linux:     stat -c format
mac (BSD): stat -f format

Seems like "wc -c < file" could be a portable alternative to "stat -L -c
%s file".

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

