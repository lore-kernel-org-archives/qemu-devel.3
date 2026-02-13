Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96AAEE36A0
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 09:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqpmZ-0005im-94; Fri, 13 Feb 2026 04:48:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqpmX-0005ht-3W
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 04:48:13 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqpmV-0006rq-9J
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 04:48:12 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61CLNsLw752405; Fri, 13 Feb 2026 01:48:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=j5CJEjbQanrhxrknP2D4RyqF4yANFBphST9n/s9Q5
 jM=; b=MZzGRUP4baNjFdA6coCw8l1UvlkiWxu17Cw6nzqWqU1q9teGBef/QU6A5
 BRux9OAXCbQSMXCAkGWjElQInCmf7kFEJHowLQJAIDDG1+UQIsyreO8dJ4CRXeK+
 taLhnay+SlG+yC6y430Yf6kjU7+m0TiBQ9MpSEN2wTJ7DYRiDSOA+R1e0la3iD6P
 PWEjkobfiI7NO7h9Ol2ne8sKmFTnmiBRFrX6CbIhj3KmlN/pHv5gU0DzUCYICS2V
 31d9Twde3YxpgqwaydI0tT5MjEKWLxsUsii1wDQZZy1/a/cwckzJMYYogl9PdHed
 s/iTRwcs2bI3Z6Dwkj9gsBVnVls2Q==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021080.outbound.protection.outlook.com [52.101.62.80])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c8ctc8j3t-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 01:48:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EV3tZ8Ev9ALvikoU/iXwkQQwU0nYhmhlHVVIjVAU9/o7tZ5YZ2PpXk3Z4DfJA8QTZmFm+EG9/QffvIjhp+fW5Lzp180lLDo14CUJM1mp9xSyAmQxWzfvGA20DzGLyn2Q67HorHXMd7c45VLu21gqFigd7aqf/Ex5wvv3RMDqDAUpGaL2wkjgeqxFkCrYp0CWKCRUKHavevw0dliuTe3VQNl7IcVK166F/sjA9WFdg9/4evCHW87g40LvdtXcXPBl/u/XF2JAjVZ+3CY27a6/QgdEXGeWo4+0u7EVLxZh9EK60jG1CZtmpbskXUhsC9rgbGd0XZteKOVlC7ew6sbMWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5CJEjbQanrhxrknP2D4RyqF4yANFBphST9n/s9Q5jM=;
 b=N9bXlJMbcUzTAgUc7FZ/vEwlNlgJxw+q5Al9XqEU/zaEAw7oAPTCRFZ7PKMNm10P7lywSz8fAUJ4sJfhXbCg4vq73K/tAhYmlsxhKkRKmh/xi4bCMMfBOKPeqwVWkDW8PI9SIYQT7pHrD98eh2mPs3Kx44hs7aPIQTQ8fMO7AQ5qRaOkIxyZgxjWRCijrWQpBg5JLY+ZeSsf/sTtIh7WOCvZ57XywS1/jS1G7JO0z+t+4eYQnAlKoO9smzr542dywypk5T2o8aj4CCb7cymXhrxMM1iH2TNI7Zg9c2FcbIr+4fh+1fvkNA2dDEKy4v4tTVTze7QSOexx8Y23NJ7TaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5CJEjbQanrhxrknP2D4RyqF4yANFBphST9n/s9Q5jM=;
 b=aNOw7UqL/LLcwyGRxNGQzBQNrswpBOSxQQSj0gG+mWlfLesYhpX5SSdZLHGj3LuKawuVCCACMSW5wkhVLp8dZODkG/X7NXj1K2polx0f4MvuvnHjVwbKC6ZXAzzPItFe8YSojI41KcPhIwySl4cPNzjbksZ8D5fJylqCFQLGNHwbKnBmEHsunZ16Rglqs5q2jufCzgWdETxXPvhdsIwJehwC3GvqgElweWAOs/ZYf4G4jcRQM/YWKjHWVUs3DIr2aDdi9Gkcae5Cwk1w4HPcFepShDhpOJns5f1lWe8SDFXus1sNOj+6I+qOknclhOM3a56Vs69NDqux8rNxYm+ILA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA1PR02MB8852.namprd02.prod.outlook.com (2603:10b6:806:1f3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 09:48:06 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 09:48:06 +0000
Message-ID: <45bf06a9-a4d9-472f-8386-0de1ec07dde0@nutanix.com>
Date: Fri, 13 Feb 2026 09:48:02 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/43] audio/spice: convert to QOM lifecycle methods
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-3-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0003.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::10) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA1PR02MB8852:EE_
X-MS-Office365-Filtering-Correlation-Id: 924db915-dd4b-4d12-0144-08de6ae4fcc1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2wveEVYSm9nY0t5YVZSNVA5aWhQcUhaSXhRdGxhUmhwL3VXSFdHb2ZUN1FQ?=
 =?utf-8?B?bzFmdGZ0dFZoZWo1c0xTZlg2TXpxUmVaM2JpZlRDaTM2bUhRcy9WRjZqUU4z?=
 =?utf-8?B?TTZzOGIwZ1duRTBGTkpxcUZDdG5laENrTzJyV2ZuTXBIMkhhdENYcjZGVFo5?=
 =?utf-8?B?aWhiQ1gzV3JXQk5NYmtaOVBYYlZzMGRjaFJFK1RpTGpRZkpFLzErbW1oLzM5?=
 =?utf-8?B?dXZaZTdCQUZPS3BzK2pTeFEzL0FGbDlJS0w0a3RpK1BUYW5XbE1IQ2ZySXdv?=
 =?utf-8?B?QzBsT0VKRkk4S3JKTFNVeXF6ZThSV2NRMVBSREROMDFwYWI3dEFSYjkrVFNQ?=
 =?utf-8?B?WUkyQ1V5NEFxNUZVTFRBM2JnRVd5c1k3dktoM1dUVEtDbGNFSFY1bEN1U3lx?=
 =?utf-8?B?Z2JzejVpanFMaHNoTyt3V0ZKWlAvalNQdndyTDBHTGNHSUVlVWMwbVlqdGNT?=
 =?utf-8?B?TzdvRENjQ2tvRk43a2pBcWZ1VmJDVHdrRWRJaWYyaFFWQnkrenA3M09sc0U4?=
 =?utf-8?B?aWZFcGVPdDFKQUR0OG1qV1E2bzAwUEhRdEhZZWRhR1o1RTRrVS9YYlN5OHY0?=
 =?utf-8?B?a2ZhK2x0WFFDU0w5Y0M5RUt4RklCb1N5dk5RaG0xNzcxc0EvbERDcHdBZTI1?=
 =?utf-8?B?Tkhua2Y0WmJCM1VveU1mU0xmRTFrNllvNEVRcnQ5YUdxOXlZTzc2RVVONzd2?=
 =?utf-8?B?dUgxSFlFVHhhd1hWYmpPMk42OHAyaUtOY3EvQTNURlNmMUFsVnp2UTFLZzgx?=
 =?utf-8?B?eWJtWVI2aEdWcFpsa2NDeW9UL2xZdlBaV3JjeUE4WC9ycVc5Snk3K1p2QlNM?=
 =?utf-8?B?QXFHc29iKzNNTkVVM01nNjBDUGNwQkdYWGUrQVhsbUlLQVk3VVhLb1pIYUlp?=
 =?utf-8?B?b1ZwVVZzZTFNZGZwRDdyakFiT0pJWDJxdGtOTEQ0U0hBSTZSeUYyRUZ6OXZM?=
 =?utf-8?B?ZDRiZm9UUXZrY2pWQnVuRGw5Tkk5UnBFSUNBYVlGRVh3WXZxT2pYSkRkbDVO?=
 =?utf-8?B?TmI0eWswZHB1RVdiSUlVOWFWK0NzWEIvSXY1eWpJd3M4emYweVB6cTcvR2hq?=
 =?utf-8?B?TG9zRkEvdWVRMyt1UnBsd3hNeURBNVF4TWJySFg1eGNwREJsWGd3NWx0MmR6?=
 =?utf-8?B?MFBVdXhsYm9VbXF6YWxWNGRVRk9nTE1mT3RZWEV0QXJkMldXL0ZTblFqODI2?=
 =?utf-8?B?NWY1bzJlY21BcUl3U1pRUHZXZ1JMcEc0LzhpRnIxV2FvUUJYOHQ1YTZwbk1F?=
 =?utf-8?B?dUpUVmRPc3pkbFMwZFlNRG1KeVprMWh2aGZ5YXhERjNIRzJ6ci9OZU12bnFL?=
 =?utf-8?B?OW52Q2t6SVVXNHRDVS85aUFFaXN0SDFlTnIvVGNIa3N2Z1VqMzBCUkNBME9p?=
 =?utf-8?B?bVNZaXpSdE9oZmpqcWpJNFFDc1o0MEdwVmhnd3EwaTFVdWk1UjFGZHJsVGk1?=
 =?utf-8?B?NUNPSkxxRUIxemM4amdFTGN0bGZrQUpoZ1BNQW1Vejh3ejNoREZiaVlKR3V6?=
 =?utf-8?B?Q3hiMWtIdUszM0s0UGRtc1VTVWovVkhyNm10YUxlNjBCd3pRcTBsYnJsbHl0?=
 =?utf-8?B?bWVNOHJXR05rZ0ZsdEJNclVXZitHbW01ZGk0WTFaemk4RFBBRHNWVmNuak00?=
 =?utf-8?B?bEUyaWVlb2tmRzRCeXdKbEVLZEVTRFJNMVhMa09PZktjWVI5cVBPRFhBVWpj?=
 =?utf-8?B?N0RZVzVKSDJreURtcXhkMnJDakR5MlFCaFR1NklpdjNRQVo2Y3hVUkc3bU5R?=
 =?utf-8?B?TElOeXlyQlVobFlEV2M4Uml6anYxUlZaQytwMzYzZzVUM0tFeklJUit6clJk?=
 =?utf-8?B?czF2UXpLVzBRbXVBRVZmTVpKRndjM0VVazFNYnZCVEU5S291MXlIQ1Z6bG5p?=
 =?utf-8?B?bnhOYkwwWUEzZG5WZ3piSWxVWTUvVUs1NnFZQU9xOHNOY2R6NHNKa0VxeTMx?=
 =?utf-8?B?ZXZ6N0dRSUpGd0dwVVM1RDN2Q1M3TWx1Sm9iSTExVFJ5Z0pjRWtEdTRDSjRq?=
 =?utf-8?B?ZmNKVzhIT0QyS2dhZFU5eFd0Wjd2azZEcmRtYVBqZFZxYmdBenZLZy94Nk5U?=
 =?utf-8?B?NG42emRNbFdBY051VGpPZnpkK3JSUWdlQ3MzRHYvaU5JWW1PQVZ6K0Jkcmpt?=
 =?utf-8?Q?Hzz8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUxrMm40MXNHcjRwUkxBQzduZm5PV1c5cHVPNUYrZkR0MHJkOEJseUlaVys4?=
 =?utf-8?B?bzIzL1pqTXhHTWJTM0IzN1R5bGt2Q041emJRVnlPUGY5amVNcTJHcWdqYUNM?=
 =?utf-8?B?bWlsenBZUXkzNkdzWHBWUi9KaEx1Mk54NmdQQzIvRXV2enFIKzJWNVFBQlRO?=
 =?utf-8?B?K01WYXM2d2M2SE1CbHRUMjIyd3RFSzhBRGJtQUZvSWV3U0ZUL1BTODBhZVh6?=
 =?utf-8?B?b3MzNXZjNkYrbkJTdE9rL1JCUHY2MzZQY0J5cExwSExXSGl3blJ5dEk2STl2?=
 =?utf-8?B?NnhabGovNmt0dDdoV0pMSUd5c2lUcDRqaUZIOUNJRGRFQjhxaVhQdXQ0SHVl?=
 =?utf-8?B?dkt5WHVzWXpNQ2FqREJyL0NCYmdOc1BXNDZMdmlGMFIyUXZSWkdBV3BUcVZX?=
 =?utf-8?B?TGcyY3dEWHlwM21NYnhZM3hZTnNONDAyNEpDNVZxLzg5K0dRT050ZnBpOTZF?=
 =?utf-8?B?MXdFOXpOc1pkeWVXd21GN280NVZUaWZCenkxb3JrbUN2L0hvdUM1NmZMRmdn?=
 =?utf-8?B?WkdrZ280emhlcm9Md045aGc3ZDFzVHBnNEc3UkJWVno0bWg2c3FXQ2Zxb2RB?=
 =?utf-8?B?VlpkL1M2S2Y0ZjJ3VS8rZDZIVUl0clRwNUJlVEcvUVVKSGl4a3NnUkg1enph?=
 =?utf-8?B?SE1lYWtyT2UrRTJ5Um51VXRTU25weHc2aktPejdTWUErOUVNQitTWVA4ZGF0?=
 =?utf-8?B?Tjg1SUlJd1J0TDVua0tEUm14dGhxZ0VCVnBXby80SmdmMU9uN29jUFM5NHhV?=
 =?utf-8?B?WU94UGh2R3FkL2xHejVOeEY3MTJJRndxY1hjcUpGUnhWRkRRd1kvUjB2K2Q1?=
 =?utf-8?B?eTNLQjBrOFRiMDJZSWNLMlNKbUpLVVdWVkN4NEMrTkYwVWxtazc4QTlDbkJC?=
 =?utf-8?B?dUJxMlRWUWc0TGszYWltNkNWdGdHbGJ6RjJoMG4xclhJSFROMGVBZ3ZZR1Nk?=
 =?utf-8?B?bVoyTTZZamJFbXpsTzE1eHhiMmMxRllzRWFpY3dBdDlPWUQ4ejRlSjhLUTRZ?=
 =?utf-8?B?bTF6bmZPTTVrV2YvUTJ6SkZuQnhPWUlwZjJMSTFzR1BUaHkwZmtvUkxiUC80?=
 =?utf-8?B?SktwTGluM05kSVdobGUwbDFVQUROdklidlZTRnYrYU56MkY2VnNlY0ozL2ZU?=
 =?utf-8?B?ZDdlc3o2enZFK0k4bjBLRkN4S1BXU0M2QURzdTdGR3NLTnVaelJINjNkNEJV?=
 =?utf-8?B?dWpHN3FuRDRzREwvdW9KSDRuRFIySVJ4djMwQXBaTGJDRVUzWWhZMFNnbXNx?=
 =?utf-8?B?Y2FYSHVJRVhJVW1KN2xBTmtQN29STnBDdWFpQjFZU25sU2NjWnljbUYydTFU?=
 =?utf-8?B?SlFqcjJHczA5Rk00dUFKNU52Und5aHBDT2RWNlFIS0VWNjBiamVEME5YNGlQ?=
 =?utf-8?B?WWo3dzBRVWxQZW5xN1I0TUZEQitYTkRSSndxRldDZHhGd1VFNEoxRk5WT1Fx?=
 =?utf-8?B?RWtVbTZ6Z0lQVnBEaGI0T0lJWVVXNjliS0pqc29XN3pUYUEzVklWd09JSWZv?=
 =?utf-8?B?dE9rZDV0dGtkcE14N3p5d3pCVjBZU0hnMnVSaGdybFVrRkl3aUNIc1l1NzdX?=
 =?utf-8?B?UzhQVGladGlDM2xaamt3dDIzZEJibWplc0w3N2JUeHNwOTB3WTh3Y0p0ZWZ3?=
 =?utf-8?B?NW13U2lsUFM4ek8vNEcvSVVUWFg3b2ZrajNrdFUwTWZiZWl4N3k2dlBXcVBR?=
 =?utf-8?B?TjJkclBJOXIzM1VTcjNMK2lsM3NEKzRzOXo0VmtmV0dBTUsyNUQybzZVRDlh?=
 =?utf-8?B?aGZBNmV1TGpJbFhpZ3BOemZlOTVydXp6d1pUVHVyeENoRENkZ3hmdmhNTnh1?=
 =?utf-8?B?aHpNbnpkaGJzck9PZFY2V3FQeGkvT2ZKUDBFekxTdHd5UVpGc0g2bWZ1WXE0?=
 =?utf-8?B?aVI2dTJDRU0rVkwrbGd5azQ2eHd4ZHBRQ3dOWXQrQXNWaVNQVjVqV0o4S0dk?=
 =?utf-8?B?UzR4b2NsK1NYbG1kNnAzZnY5N0NHT0ZodC82eStId1p1RkxCR1lzZjhrU3Bz?=
 =?utf-8?B?SkM3MkowdWdtaDZsVWVscm0vdWwrOHBxRFFLVkZmZHR5MmRVSzZUMDBpd1RT?=
 =?utf-8?B?NFJpaFNHc2xLTC8wWFNmNHlnV2RCREl3cWcyUmVpNi92bVROeUsvTlpFOHVx?=
 =?utf-8?B?NjZPRHdXNVlrd3pHNkY1Ni9HUExvQ24yaWtnQUNEanlid0ZMUnhYWS9YQnBE?=
 =?utf-8?B?VEE5T0pIWUhwT0RPRVRTUEFrc1U5QW1TTWc5Y3RGcDhLcDREUW45MG41UlNP?=
 =?utf-8?B?OWJmSWNFa21uMnRtSWluV2lWWC9FNHNyekZHcVBuaktOTXp3UVk2ZDBTbU5K?=
 =?utf-8?B?VElxcUJzdWIwemFpbmQvRHZqVXFlUnpONzk0SEszbDM0NHBWb0VvVXVROFBk?=
 =?utf-8?Q?vbZeTbIv9JCozfWk=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 924db915-dd4b-4d12-0144-08de6ae4fcc1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 09:48:06.0125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wusFhl86x6aDn6TqexgAMG84QpbB2+zoW5Pz8YxYyrhcicu4qp+b83Z6ANnIU76X2gdz+FyVk8THx7adURA+0HD70pJ3hKTXjB1+CvMqq5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8852
X-Authority-Analysis: v=2.4 cv=Yd+wJgRf c=1 sm=1 tr=0 ts=698ef358 cx=c_pps
 a=rDyEm/81vvKQCy/iKDMZrQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=QPHc7w8wcm5UVhAUiF0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 5O9U-_4RkeO0HLbMmZ1Ng8vShsyfQIz7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA3NCBTYWx0ZWRfX6NuYVTlwpoGs
 hu4cF9/MDCOFy8ndKhP/z9iWCznGVyosG7B961TRNUoIZMvmNzgbqNFpH8ez18/a6m/29M0qJzC
 cUxvQHc8ZilrNhTohT4oMBVB7ngTzCnRzBsME5YFGYYwawxigzk8ckZG66v6gARSO6TI3P1ogoB
 Gx9Mg820llNElh5o3YxAhmPstbOp3IdbCQRRdZZx/FGJS3JIobJDkDz6lAJ7VDvrzt6Rla2Wn0E
 4J2H8sAFvoMgfeaTXQYp8x9+om8VmNXsafwi5/ECf1PdK6Zu1pLGibOsFz46K8uMzdqu6ZXg17k
 IsvNyKzQHgeLhDRy/I80aLwn7ZAvRiiYy9v0PoN9SJDwOaUyjr8K0snNGFMPJ2e2syXXXQR/NHZ
 QJXGx33A2C6hCufsEJZKvg9bLqp55ZCuy8WQM6m8ekNi4Le6DPVa4A910YRYiR71Tex3URqfvxO
 pUltjDHthwzpuUtq1OQ==
X-Proofpoint-GUID: 5O9U-_4RkeO0HLbMmZ1Ng8vShsyfQIz7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 27/01/2026 18:24, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Migrate the SPICE audio backend from the legacy driver init/fini
> callbacks to proper QOM realize method.
> 
> The spice_audio_init() function is replaced with spice_audio_realize(),
> which validates that SPICE is enabled before delegating to the parent
> class realize method. The empty spice_audio_fini() is removed as no
> cleanup is needed.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/spiceaudio.c | 34 +++++++++++++++++-----------------
>   1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
> index db9158284ce..b72424055c0 100644
> --- a/audio/spiceaudio.c
> +++ b/audio/spiceaudio.c
> @@ -33,16 +33,33 @@
>   #define TYPE_AUDIO_SPICE "audio-spice"
>   OBJECT_DECLARE_SIMPLE_TYPE(AudioSpice, AUDIO_SPICE)
>   
> +static AudioBackendClass *audio_spice_parent_class;
> +
>   struct AudioSpice {
>       AudioMixengBackend parent;
>   };
>   
>   static struct audio_driver spice_audio_driver;
>   
> +static bool spice_audio_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
> +{
> +    if (!using_spice) {
> +        error_setg(errp, "Cannot use spice audio without -spice");
> +        qapi_free_Audiodev(dev);
> +        return false;
> +    }
> +
> +    return audio_spice_parent_class->realize(abe, dev, errp);
> +}
> +
>   static void audio_spice_class_init(ObjectClass *klass, const void *data)
>   {
> +    AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
>       AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
>   
> +    audio_spice_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
> +
> +    b->realize = spice_audio_realize;
>       k->driver = &spice_audio_driver;
>   }
>   
> @@ -89,21 +106,6 @@ static const SpiceRecordInterface record_sif = {
>       .base.minor_version = SPICE_INTERFACE_RECORD_MINOR,
>   };
>   
> -static void *spice_audio_init(Audiodev *dev, Error **errp)
> -{
> -    if (!using_spice) {
> -        error_setg(errp, "Cannot use spice audio without -spice");
> -        return NULL;
> -    }
> -
> -    return &spice_audio_init;
> -}
> -
> -static void spice_audio_fini (void *opaque)
> -{
> -    /* nothing */
> -}
> -
>   /* playback */
>   
>   static int line_out_init(HWVoiceOut *hw, struct audsettings *as,
> @@ -333,8 +335,6 @@ static struct audio_pcm_ops audio_callbacks = {
>   
>   static struct audio_driver spice_audio_driver = {
>       .name           = "spice",
> -    .init           = spice_audio_init,
> -    .fini           = spice_audio_fini,
>       .pcm_ops        = &audio_callbacks,
>       .max_voices_out = 1,
>       .max_voices_in  = 1,

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


