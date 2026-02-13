Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9A1EDF173
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 15:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqvXY-0006fa-3P; Fri, 13 Feb 2026 10:57:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqvXU-0006fI-GY
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:57:05 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqvXS-0000wz-O1
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:57:04 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61DFZNWg1275101; Fri, 13 Feb 2026 07:57:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=gkJZxwCthmc4DO+2m+kLT027xHe0nDlfZ4pIBr8Ji
 sA=; b=Uk08Qpm/9io/xuk9QqIkwOHVZjQEeQUnp1eXSR3VuygYlFTj5Vmi1G/NM
 iydRjNahl6I7BWX4sFA9+mU+79O9fWvhAZnk8a/WzPjxxF/Kr4GFsUNxD0G5QMvl
 G88RR9kisB7c3AByYWsNyDs4vEIwh0X/j77Ffiqwxp+9g1BMa9dK1rT4ZJiABJc2
 dC/8nN1nwaEW2cYXayMQyg491XMfTwx2u18SdI8piXTqttYLgixMtWdsNMzET/mF
 OUxw67TuGq7TBwGOO+tF7P1+Oy15jKyJJTdk4x+xMHs0j1/+kr/ra6LxFdXeHaHv
 ffKOVZoEnLzjRuzUdJmfGZFJ9xt2Q==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020101.outbound.protection.outlook.com [52.101.61.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ca6qwg1dr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 07:57:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HsTLmYxWBD9Gxg2DtGHw4e6T6f2Q55AnSqOnhDDql4ilZvHymCq9mfXwaj4+TVGlnr8DhYgqAGsiROao/ZBtalsGFrfrncb2JGtSjjX4BFnoUImet6BgdHawTlIoAKG+1V6YfHMY0MFEoqVMW8tH+bwJgyXHNDIkZH06tA8DnWZsYLPDPf0Bhli5r99LYc4fF7Wave9+6suHNJHlp9W6VgLv2Hds3fDz12rlaawuwHf9ntnOvtYxb+9FSJDtvTFsD3M2r622BeCysCB2VtsDzf6brqusMRyT0kMpeYDNIbM3sHqUlrZHkiV9Y5HdPDKrlF5TND4oHQKxGptPDHSZuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkJZxwCthmc4DO+2m+kLT027xHe0nDlfZ4pIBr8JisA=;
 b=ZWcH2koeXuBxaABmf/SsHzual5rypdzpLAh9uQ/GB/wWqyp3on7JqV0JHc4ZwNyLD14nxUXesgcDlwjR5Q2M+e7Uwj/tvdSZDE8nGTrqwKHWdZLdcWO1Iyji1BjJJeoFfm2Iff6oO9h7GFdRhdhlp27tMJF5lPSWWNdL8901Z7ESu0d86zjER7UrPiPpCFcpr48vqMjGu8p0lmqYLXsOqYeDsEI1o67Glb56pY4Ey2rHNhm5hyVzEkw1Sd01Ii0SfB3spx432pSL2fHb3u1KF+IFW7doZv6ohPF1IJsQ10p93xNz/TPmYrybbY3OwbuLdeDIO99bodqBjnIjJlAtzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkJZxwCthmc4DO+2m+kLT027xHe0nDlfZ4pIBr8JisA=;
 b=mfrtbgdRUQFa5/LsM94lFpzyu/BRmbJUCYa06sktpofiMqliUbPI6ZRtFP8k5wS1c+f0hAWLk4N4/+X928qzlB1dYdsuuZbv7ptB+OCP3QhLHTZr91T36/mU9qc6pxsrlSsie5C4XeM6LDvULfk8sSdJBWJPt0X5J+ZXLMPay4Fo6AVTkV99IJSrgqfuX3QtYH73kpbvY96xoZwus1m/cn3OhfVckwYfSh+XwbicPvGhAZ5ZcZVr/ba1LCI0/J0o1LyDQ9WZQJq7O//gxWy8XdIkKJozBYKvKI4OhtMNmy0bNepo/FN+mLFqq4lYqR8BJkk2XZydv6syH5AtAI293Q==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH0PR02MB7866.namprd02.prod.outlook.com (2603:10b6:610:ed::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Fri, 13 Feb
 2026 15:56:57 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 15:56:57 +0000
Message-ID: <0ab12e2a-906a-44c7-90c9-e3c86675adf3@nutanix.com>
Date: Fri, 13 Feb 2026 15:56:53 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 37/43] audio: replace DEBUG_AUDIO with trace
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-38-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-38-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:610:76::13) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH0PR02MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cae3c15-c3e4-4e40-d3c8-08de6b188444
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkdiakdycmtaemNndVpIUDh2RmtPWHh5SWgvR1B3UzgrN3p2bDhHcS82b2Vm?=
 =?utf-8?B?YzIxRldWWVRmYUlYT3dia2RqZjd1UjFiV2VVUnpmV1VvUGNma3F3aE9mTWdr?=
 =?utf-8?B?WkZrMlZSQXpuMXpXQjhKa3ZQS2JGcWdiSFkzZUtsVU0rL3JUU09Ib2ZVb2xO?=
 =?utf-8?B?TTlJdWpHY1E0NUJTYkdEUVJOSGQzSE1wbTJ0M2FEeENzTmQwb1ZZcXIzcU93?=
 =?utf-8?B?NkNyWGM5ZTVpaDJBWHVNQk9IQVI5NW80QU9BaSs2U0RJRXJoeHRHRTZTYXoy?=
 =?utf-8?B?OHFpT0U4enRVeGVPVVNDZ254TUhFTEh2QVRkM1FUOVBubWYwL1hBNCtaaENl?=
 =?utf-8?B?ZldDRi9aZGlQTERkVDdsSXp4R0h2d1V0aCtMckh1cHFUVmUwc1RtZHRjL2Zk?=
 =?utf-8?B?cDdhTS9UTEgxd2JLcThVNjdudE1IdjlXTElncW5rTy9GTEJVamR1Ulc3TFVU?=
 =?utf-8?B?NkFBMitWQytEeVVIQnlxclZRNjhJR1NQT05ZTEVIck5McmRmQjJ6MFI1ZERC?=
 =?utf-8?B?UFFKczRkRVVBQTcrZ05nazNvbVdoT1R1MGJpY3habWJJWkNWN1M5RCt4SjMv?=
 =?utf-8?B?WHg4UTM4TnJUbjloZWRNcEkzR1BxcmdzUHVSQi9paFY1bnpXb251RGl5OE5K?=
 =?utf-8?B?VVhDSFJ1TVRYZ3RaQmgvTEdhUUhIcmtyTVNqYnJrVURLK0FBTkxWVjRkblNr?=
 =?utf-8?B?SlFrRko3ZzlwS3pPaW55M3d3OFYrNStVU0QxNnZXcDNXS1YyZHo1Rjd1Q1N5?=
 =?utf-8?B?d1JwS1U5bG9SNWgxUHpwaVFzUkxPTERDNTlab3lXTGpnRTlQSWZJeGd6MGhJ?=
 =?utf-8?B?bDhUU1hkNjA2Mk42bFVNbGtzdXQ3b2hEQ25DK2VkY0JHVzNHZVJqSXlkNUIr?=
 =?utf-8?B?QU9BMVZ1UTZkZmphRllvcG1zMUhKQktBcVdEMjhJZHJBUEN2Q21mVjIyejY4?=
 =?utf-8?B?MVlGZlh2MTRhWlVZc3d5SGVoQU4zdzVlLzBwSFdST2lRcW1KSmF3ZU9zSUFU?=
 =?utf-8?B?Qk15RFNQa2tPUGpSa0hCSzBoa2dYNWZtdE1pVGgxZGg0YWNUV0J3a2h2R0xy?=
 =?utf-8?B?c0w3dWREVkZzK3RXNEpyLzBOSk03RUVlNFBCZTIwb3NRME51alVpSEIwTGNx?=
 =?utf-8?B?L1l3aHNzSG1NM3pWSnNqV2s4ZTRodkpkRFNaOXJYUzBDcjM2Mno1ZlBTdlFj?=
 =?utf-8?B?Q1p0cDR1UFNWTW5pTDdZOEFzT3FQK2hiNkZFQUJtdXdDakM0ek1mY3o2UnB1?=
 =?utf-8?B?b1MxbEtXZFlndDdITVN0TWwxaEhHUi9TZUhSYVE3eERXd3JRc1QxcTQ3Y2FO?=
 =?utf-8?B?RVRQa2daNk9LUHhCdGlpNjJ3Tlhpd2ZYRG1tL1cyU1hUd1RoU05TK01oajNX?=
 =?utf-8?B?WE43K0dSVnYyVVZXZHE5ZFFma3hBVktTSnlvK0p1K0E1UjZqeVVhcUR1RkhP?=
 =?utf-8?B?ZVAzNDhvUUxxUHhlSURybXpSWUpjUjBXUHhlMWowZW5hTmRtNGxlUThURnBW?=
 =?utf-8?B?TUkycnY2djhUa29kSUw4clI3bkpOZ0pVQi93YU1WTU80VXcrcTZ4RnBKaStM?=
 =?utf-8?B?VTdPckFaOTZGczBId09uVGJSd1YrMnFNYjlkRXJ6ZVhRNmVZMndMeHNOQnEv?=
 =?utf-8?B?UnF1aGVkRlo4c21kNWZ3UGl2eTZOWWRlTy9LbzFjdTArQ3ZycWd3ckxpVE9P?=
 =?utf-8?B?dzBUdWxIZndJbDNKZ3BOR3BSamJNNVFVMXFPYU5lQUZ3MXZzUWZZOXNIRExi?=
 =?utf-8?B?ZDFLVS9RWDVWTUcwSDV5azRtcndtQzNUQWhUNGQ1QldwcjFFTTQrWWdxVm83?=
 =?utf-8?B?Sm1jemtsdit1SjR3ZmNtM0FJekRidTIxb0N0cG5yaXNQUDMyQm5qOEZoVnpj?=
 =?utf-8?B?ZHpsbk5rRk5sV21yTVRrVklkMCttY1ZoeUV0MDhoVkcycHNtWVhQdzdNaFVB?=
 =?utf-8?B?ek5PS2hGMmVCR2ZKL2M2UUh4b3dFRXdvdzBrdXAwNGMxZTVwTklxY1RFZXlO?=
 =?utf-8?B?ZkcyL2tmNG1LSmxGZDQ3RXB0ZGQ0UUxERHFMN0JubS9jN1A3ZFJkOERiRXl6?=
 =?utf-8?B?K3dyVDVoNWZMdVByNWpqd0RQb3ZxRkh2ZWhqb1QyUUFSQmJuMExDT3hyYita?=
 =?utf-8?Q?DUE8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWVJYm9VM2R2MXY0VDVEaStQZ2wrbVA0aFRyOUFZWEl3c09pYjhPM3YrV3VO?=
 =?utf-8?B?ZnY3ZWdqdGkzVGpXVk1WUzNwaXY0cDlzajRQakswTnRDWC9pL1JJQ01KQXRM?=
 =?utf-8?B?WEVEcnk2NVdSTXZ5OXVzVTROeWtmb2FKZUtIYkZrbHBYSjRyOWgrdHEzb3Ju?=
 =?utf-8?B?SldmbEhzNUZMV2hiN2ZVM2Q1NWl2dG9BajdNZ0NRUWR1N0VEandKY3JsU1Z5?=
 =?utf-8?B?bEpIYTZ3WHdtUzhmaWFETFdlMVdoZkg0ZDUvVnd2UjVkRGdQRUp2SDVwSVhl?=
 =?utf-8?B?N2lSY1ZBdll3QnEycGZiWUF3WHh5cDdIL0hjZGZRSXNUQysvN0ZNUFNRVjgr?=
 =?utf-8?B?UVFObGU1MFdPaXRRZFNVaThHSFcrdkN2M2JUVlBWK0lIRmMxbGN2UCtBcnFH?=
 =?utf-8?B?VUt6VzArYXEyUGRGdDNMQnNjaEVYczdPc1ZocW02NEZPdnBDTDFCcmt4ekZ6?=
 =?utf-8?B?MVZPdnE2cE1iVzQwUVNDREpnN1NkYUR6YlRuenFwYlFFbWRwR0dDc09ZTnps?=
 =?utf-8?B?dmw5Z2EvUHdURnUyVm1iY2Q0VzVYUWF1ak1uVVltZVZmb21GQzBORXhrcU04?=
 =?utf-8?B?aWhGekNNOTliMlV2L3BhcVd2Zkh4QmVtd2tDS1k0NHl3WEs3NURFaUlUeWg2?=
 =?utf-8?B?eFZOVFlwa2RSUk9FSFIrbE44cW9jemNXRWtlS2RaVUR3QkcrNk5zTjRCUmV1?=
 =?utf-8?B?UUVyQS9OQk5WVkRRSjUvUE9UQ2pYblpRWDdkclhsVGFoSENrblAxOElibER6?=
 =?utf-8?B?SkFKY1JkVE80Qk1FbjNXd2taYjJSRHF1TzVNVHBqWHVuQjJIeVZPYk9hV3NB?=
 =?utf-8?B?WGNGZ0tOTWFTOHlPWFRPbWJMM0JPWnpRVm5RK1VhbnNzZTFGbWdxR3pUbVZ6?=
 =?utf-8?B?UXBTaVZWMHlHK0hnamlEYXp3bWJyU0Y0NWV3V1ZpcEYxQVVySUZmaWMrSHpl?=
 =?utf-8?B?cU4wWS9PWEdEY0ZHNTNsUjRQd3lHQUdKcFQyMEg2VUNhVzZiYjd6RTJQM1Mr?=
 =?utf-8?B?WnNKSUVxTmFTNUdUTWlOZ0lhbFZGNjY0enpXRm5pcUNSNzNEMWp1alQwNmxj?=
 =?utf-8?B?NjRLRlpOM21SY1FoL00xZk1Uc3RCNUVYcGlVbmFzRDNhRDlQWklVTGN3SFJ4?=
 =?utf-8?B?Qkx4a1c4cnBuUGVPc1ZRaWo2T2FXOWl3eVhQeDBXQW5jM2R2WDV5LzNqSHBl?=
 =?utf-8?B?Q2hZNFZoTnpYSGhLd0lyM0FvQ1ZzQm80ZlhISkxpNFoyQW9YbVRrQzRsS3BZ?=
 =?utf-8?B?aWdtMzI2bW9OaHJISXIxT2FSanZwMWFnSklRbjdBZFFOcjdLNW9vVUlDYURv?=
 =?utf-8?B?VjFkY09FYW5NMDlFMkFRRG5kbHh0VnlrZm54aWNicWxyYmhlTWdaR21HWFNn?=
 =?utf-8?B?TW5NaFpoYXdkd3RXV1podCtwZTNtWE40K1FyREhtSWRjMkZod1kyWGczNlI1?=
 =?utf-8?B?cTBJbnRKR2xhbkI3MStHWXNQdXJvSmhMVzNKWkhyYUtPQ0RZbXlZQXc0Yzdv?=
 =?utf-8?B?aTRkVS9McGVuTGtzMnZmVWx0dlNGNEp4Q3RrMzhzTWdHK1R2QVZwZDFDZTZD?=
 =?utf-8?B?MVZpRWkvc2FjeVJDSVZyMEFuYVZ1eVY1bnBJUmhIcWRHMHAzUWFHQ2diLzhY?=
 =?utf-8?B?NlZpZGZuRm5DdW1RVGZYL3QrVjNmNWhVQWp3QUx3OHZDRzlTMG5OVGpjT3Yx?=
 =?utf-8?B?Y1pqMng5Wm45NUhvdXpFYXd3ak9rZWRZUDYxL0NGemFFbFdsTjR2bks3aldU?=
 =?utf-8?B?R09sRkZHRWUxYVFkQmEwL0Jlb1JTL1VUQ2k2cmxZN0lJNTJUMG0yRFBNb0lt?=
 =?utf-8?B?d0RiTlJqRnFnK21CYllIOXpLaWtGOStPeTNSdzFzQTJKQm9qSzBMMS9TN1Fs?=
 =?utf-8?B?d2FmL2liZzMxWUkrM2E4UzBibzd5Rlp6Myt4ZkZzbllyYmVsUmF2TWJBWHhJ?=
 =?utf-8?B?UCttMFRhY1BSMVdFVzR4OXRHRUtNL2NOUnM4R01JaGxhMXY2SlFObkhhK2lH?=
 =?utf-8?B?N0hEOHlXV2t4TnZXQkdMVlJyZ0ppZ0FlWXRmdFExbGwrelNCMG1VU1E1Ui9T?=
 =?utf-8?B?NG1PNS9oNEZ4UG9YUlJ1bUwrcXlVUTF3enJEQWs2THEwUlpJMmZ6bDZoSVdD?=
 =?utf-8?B?bEhCeGF5Y1ljLzZOdWh2UUhSUEwyR091bFVFUWJEQ09oRnA2Ums2bmlDaVdM?=
 =?utf-8?B?WXBBQnptYzNVUU1OVElHTm4zNjZaZ09JWnRnTGpsRVB2N1p5SG5leGtFZTFa?=
 =?utf-8?B?K1dnUnFTbHlrNWVlNXRKS0pDa2ErbFlDRDI1a2RFblc4bVN3RkVxK2F3MkVG?=
 =?utf-8?B?RmRWZDZxR1U3VDVERWNTZWQxRUZ2djZnSm5GeFVES3FQRkJVZXp5NHkrLzRD?=
 =?utf-8?Q?tAZCoUesGAqlcckw=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cae3c15-c3e4-4e40-d3c8-08de6b188444
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 15:56:57.6796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0I1HDH2W3IwMsf8VsHb18esE8B631q348JVaf5j3tXqHJGN8D65BCCv/wp+JeDEOtiz4hQCKMGaVZ3NGTrLwkTEIMjwePFFhwWa4GSjbd/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7866
X-Authority-Analysis: v=2.4 cv=EJILElZC c=1 sm=1 tr=0 ts=698f49cc cx=c_pps
 a=ONVPZRIUl3/knk75a7oMmQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=xRC48k9jo03fMZTQLywA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: pdxE-2UVVs-y7qz7LxNM8u0zw1CzhKGv
X-Proofpoint-GUID: pdxE-2UVVs-y7qz7LxNM8u0zw1CzhKGv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDEyMiBTYWx0ZWRfX62+ZTMEM1pMe
 4OdfHLzIWZNkxWIVDNq3uH2ydjehnbD+iXJd08IxbuvHo1E/+ylaeob/Zz7oDwX0SvDT4JKKbGY
 JkHAtpuwfQs3ICy+hmVAyUlzZoHt2+q6F4Xv4eg463F457iSOIv9sBMsyR3YL1P98KZnG90WqRS
 AMfHn3Sn1FYhQPNvGuaosLHUCjtGuFLbCjkthEfsM2GzaZvLME92WPPr6Qo/DdoHzIAHvUNLx+R
 GXPAOrwpmOHmLv5fE9UaxDFKnavyfF/yFlvdIJxP5DN6AzeQCsX47J3A5S4QA6dqHOq4T7jBr3w
 cldwd/Cg1M50xTfrOVjiMIykUkLaXid4gxc8o4EXkKDyzJvj75Wwbi1qjPg/9VZXL1+ch0ltnfW
 0HQk8CGSPdwQXGVxL+psu4LauEEO62gXwlwupxYfDqMXfq1R6CHcF8xKVUwYIQ3TgXUH8fpwh6N
 qHIu399nPzFZMjKnKbg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/01/2026 18:25, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio_template.h  | 10 +++++-----
>   audio/audio-mixeng-be.c |  9 ---------
>   audio/trace-events      |  1 +
>   3 files changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/audio/audio_template.h b/audio/audio_template.h
> index c47a2f202f0..e884c8e9b1a 100644
> --- a/audio/audio_template.h
> +++ b/audio/audio_template.h
> @@ -556,11 +556,11 @@ static SW *glue(audio_mixeng_backend_open_, TYPE) (
>       sw->callback.fn = callback_fn;
>       sw->callback.opaque = callback_opaque;
>   
> -#ifdef DEBUG_AUDIO
> -    dolog ("%s\n", name);
> -    audio_pcm_print_info ("hw", &sw->hw->info);
> -    audio_pcm_print_info ("sw", &sw->info);
> -#endif
> +    trace_audio_voice_pair(G_STRINGIFY(TYPE), name,
> +                           AudioFormat_str(sw->hw->info.af),
> +                           sw->hw->info.freq, sw->hw->info.nchannels,
> +                           AudioFormat_str(sw->info.af),
> +                           sw->info.freq, sw->info.nchannels);

A little unsure of the "pair" naming here?

>       return sw;
>   
> diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
> index 5303c08a285..5165768a531 100644
> --- a/audio/audio-mixeng-be.c
> +++ b/audio/audio-mixeng-be.c
> @@ -620,15 +620,6 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t buf_len)
>       return total_in * sw->info.bytes_per_frame;
>   }
>   
> -#ifdef DEBUG_AUDIO
> -static void audio_pcm_print_info (const char *cap, struct audio_pcm_info *info)
> -{
> -    dolog("%s: %s, freq %d, nchan %d\n",
> -          cap, AudioFormat_str(info->af), info->freq,
> -          info->nchannels);
> -}
> -#endif
> -
>   #define DAC
>   #include "audio_template.h"
>   #undef DAC
> diff --git a/audio/trace-events b/audio/trace-events
> index 7a73d6eb84f..ed04792d508 100644
> --- a/audio/trace-events
> +++ b/audio/trace-events
> @@ -74,3 +74,4 @@ audio_out_played(size_t played) "played=%zu"
>   # audio_template.h
>   audio_open_out(const char *name, int freq, int nchannels, int fmt) "open %s, freq %d, nchannels %d, fmt %d"
>   audio_open_in(const char *name, int freq, int nchannels, int fmt) "open %s, freq %d, nchannels %d, fmt %d"
> +audio_voice_pair(const char *type, const char *name, const char *hw_fmt, int hw_freq, int hw_nchannels, const char *sw_fmt, int sw_freq, int sw_nchannels) "%s: name=%s hw=%s/%d/%d sw=%s/%d/%d"

Otherwise:

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


