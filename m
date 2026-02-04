Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B83E9538C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 11:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnbOg-00045B-1j; Wed, 04 Feb 2026 06:50:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnbOd-00041M-R0
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:50:11 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnbOb-00055M-W1
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:50:11 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61465QEI2991336; Wed, 4 Feb 2026 03:50:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=LflEhjHg3ef5f2peSTQd0n7B4d9WkilEFxpT5wTxz
 d4=; b=ZrwAdjCaR/5x5Uhen1et419rKk8HQKcLVCUFPYEzD6P9aJJfqU58O72FC
 weF/NRo1z5Mtz335x/HjoBORBU9hNV2zdeY01uXmGKhdZ2iECo3wYAaP9zVevU4B
 bG2JXJEYq6f+fou3GvR/xIdEoO5q6JpaGbrp86RGJiAXlpjLv7ZIOEWsq/Y6fVeR
 AaVNpMmzdLus6xsXDwS5zCivUUrad8ZO4oBK0cx+rxAv6e2GuR5kMHGIbTEtSTmN
 Zuw9/54lvv7SKbwYawpCuii5nMIvV4f355TPD6/G/FPP5krC9yPYQorl11r9adKJ
 Bs+HYpD37O9DH1JtYgc0ngORhskzg==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020143.outbound.protection.outlook.com [52.101.85.143])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c3ntja6qy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 04 Feb 2026 03:50:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E68ZfT91OMHQncjnv3HwDUxJngwKxIW3wZ7XazL4eB3Vtjfksofi/F9o/SsTmD2gmucc3DAB2Mroxni2nOs0YWQom+zLVldP8SZFYfb7/o2qlNW5feSajcJT0hR6Ct2ZekOCejwAE44RAbjZFeJfwizFKzRFQtM9pO85jaQcAkYe/lsmT4mJ7JmY0T02iq1Da16ASc6OdD9sTSArtLpJQ7GklYB+Ex9NH+HDPFdXsnrALcqZCwh+rhVskdk9OalL8vKHNqFFMF35HJ61CSOYkLrBFZkr4sXZ4u41hgMW2xerXjVqxiCaoW/OQ7jBFXGLr/w85tPLqITxFAQBmrrs7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LflEhjHg3ef5f2peSTQd0n7B4d9WkilEFxpT5wTxzd4=;
 b=Q/85mmazrIseTzl/RyJizt9U0tT4M/hhzz0ck2nh0a1lvn5lB/YkTClKuqqaq75iSj/6seDIaOtfqpZ0lMayi+tYFNMazCNCi98aXhai+P8EUERxbEC+0hubH3DSsHDS4/IHXVB8pjIf0aEW5iABm5cXckL5FxSV668k+Yi0s5m1GkQVQZ/sLn6GooE8NzObUdhdKhQEF4Yyw8MK64F1iij0LUwDjjc1xJhBmt8QZrd3823hDYVW5dAmsJ7PM5ZjoZiFCUZVJp1p14XfZxQ+NzfAOk4MqcLbS09s3QvSwDVyqnV85l2QaoXBX2Xt7jgbCms6uDThwoTzrWA/NOBA6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LflEhjHg3ef5f2peSTQd0n7B4d9WkilEFxpT5wTxzd4=;
 b=y4i0ogJ4srXLxH7tnE+i5ct9wOSfZOTpVIJofSaw6kgkWaQjwqlYKe9FYjEOqbTrkpjTvE23NNp5iCRNhjBFwPeHauS1aec2iVF55ZG947+TMjSaxruKyZkree36CI4e+T8C+szuxlK0B1HhHQxp3jA5jWV7eIN6M+Jgg15VhrAYVBn0zL7Fd46e3fi2PoHS9Pz8sUzXfnUK8xMVYi7F8nlj7pQ19tru8a6orfCoAjHWwW4YGg1oPkMELowW/2+aOYcG26ngHNaHyJ5b2uEUtqn2y7jRCrxqItYn5XxFEm9O/Os3mJYapJVq6N9U0669NXNChF7fvmmsM87xMBIIhA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8096.namprd02.prod.outlook.com (2603:10b6:408:167::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 11:50:04 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 11:50:03 +0000
Message-ID: <d799845e-5e05-4e28-b3d3-a32842a9be13@nutanix.com>
Date: Wed, 4 Feb 2026 11:50:00 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 35/37] audio-be: add some state trace for debugging
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-36-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-36-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR12CA0018.namprd12.prod.outlook.com
 (2603:10b6:806:6f::23) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: c02ecad6-08cf-4f52-89eb-08de63e38874
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RENGRno4WVhDK05YTi9RSFFhNHBVMWpXcnpyQmRUdW4weGtVRDArSkVRRnlp?=
 =?utf-8?B?RDRjMTFSNWJvL3hqYmFwM1g3dUVVZFlOZlhlY0NzMXoxWGY0L1pveU82QkJ2?=
 =?utf-8?B?S04vWjRsTWdwVzJGR0RjL1Nwc0tCZkt6TmtvUEFaWWQxV2doOG13TzZ0RXFw?=
 =?utf-8?B?Rjg4TFYvRWx1ZlhzY3VSejEvdDZ0Zk5rbXY2NUxaZXNsL2RYVWhXTnJrMkJv?=
 =?utf-8?B?MkRJRXZtZjVUODBQeFRXM09NRkVPajMxMytzbFFpNzlMMmIxTndNSS9zQnJv?=
 =?utf-8?B?YWc1ZThTRGJXajJKd1ZYckRSN2NaNHhSUXJZVmpsQzlUTVBZcG1RRy80SjVL?=
 =?utf-8?B?VC9Hc1VxRGxHb1J4azB3RkZtTXhxUDdBTG5ZSDFhN3dDclF1b3ZJalRORWU5?=
 =?utf-8?B?d0lIOVA4U0Z0WW9QYmJBdlZRS0ptU1hhM0YvaWlUOWVnZEJnU2N2VTE5L2Ro?=
 =?utf-8?B?dWthTFFNeW5va2s2UmpnSlltMkpML1dyV21UTURpSEdhVHMwOGNIMVIyU3d2?=
 =?utf-8?B?a3gvRnM5NnZFdG1vMTNHQTQ1MzVxSlE5WmFnSms2dk5lMXB1M0NRT0xMNW9z?=
 =?utf-8?B?YTFWSU5ESjFGbVNRUE1pTjZIeDQ1QXEyTU44a3VRQTlFaTVRT0luVk5xNFZl?=
 =?utf-8?B?cUJYMEJOVXBpUENOSVVZR3BOZDZOOTJpWDFhYkQ1NG5IN0Zad1hJeUpDbHA0?=
 =?utf-8?B?SE9mZ3NFS0N4MXFReVp6V0I0b2VZbVBQaFNVYk9XUXZ1UjBIMWlZaUV2eHJZ?=
 =?utf-8?B?emM0TW4zMElTek51WHBvY2ZnMlJNN0NYSzl4S3QwUExJb3J1NG1xbE12NlZa?=
 =?utf-8?B?MmhXV3pBeE5FSUxlbWZlSEdsY25sOWFTR0JhSHRKMEJBdktCTFA4d2tuVXJX?=
 =?utf-8?B?Y0hPMmovazBNdTk1dnNKQ1hnZ1Z3WFdSS1IzUHg2bHVRMXpDVmltS1BzT1I5?=
 =?utf-8?B?dG4rOXFzV0YvQW13RkpBcjEySWhPNTlLbUtUMjcydkp3eFBtN0o0aG9Tekwv?=
 =?utf-8?B?YXZPNDJXSnRqVWVtSm9lRXBUVW1zdHlUUjZzTVdkbFgreHdlOHZVT2JMZDVm?=
 =?utf-8?B?U1BNWGZ6QVFaYjFSeWsveVZreUVLSGJWU21ZV0c0dlFDdDBRakh6cWxvV3do?=
 =?utf-8?B?UFUrelJXM3Z5dnAyZ3ZwRjZwOE9zazlYemw1QzFicUluVzNTeFlhcm9tREhz?=
 =?utf-8?B?cU10djlsczJrV2l0Ri9JalFYVHR2MWZGWHFIVHMxS21DakhMZ0ZqN25zalFK?=
 =?utf-8?B?OHJEZFVFVDZTWFFFUkkwK2g0NE5VMUJ3UC8wNGFaWmhtUlpwY3JKOHdneW9r?=
 =?utf-8?B?VUZENTdzNEpJTWtHQ1JRWjF4aGNZQXJEaSthWThISERKT0w4SFJVbjQwNEt3?=
 =?utf-8?B?aW5idW1yVDFWc01vM3JUNWxjV1dwOGxxamw4ZUR6c1RZalgxRDMvUkRMZjJz?=
 =?utf-8?B?cEZKbThqTzB2aWtIL2c5TFJHajJsNjkwTUN6dUFOdGhyZHpySldrOGxBTC9a?=
 =?utf-8?B?ck1zTUNBSTdad2VONzNoNERrYkhNYTgzOUNWQ2lLa1g3bm9KMkNVTkVFOHhq?=
 =?utf-8?B?RzBUWm12TnNNWTVqZXAvT2Y1VFRmVmhxQzlYQ2FrS3dBZlRRYWZ6SmtSTmEy?=
 =?utf-8?B?d09raGFoYWEwR1dVZEtmMExiaXk5aW1hd1BlYnI0M0Z4WVFSY0RyYnJqeDN2?=
 =?utf-8?B?Z3c3K25SK0lJMlluZ2YxWGVjR1JycE9qTmh0U1hlVktNWnplTFlmYjlIVC9Y?=
 =?utf-8?B?TGhGeG1EK1d0c05vT3VRa0V5RjZFOFJGUWdwUlJKc3BxQ0tEZWtER1RWQWJT?=
 =?utf-8?B?TmNrbkpxNncrd2pqTGFrQi8rSTh6OFRBZm9mL1pnR0ZSQlZnWjJnNlBZYlcv?=
 =?utf-8?B?YzZFeEU0MHExU09GaXRDU09hcTc5NFNURDN0OU54M2JmVnNPSEZYRnVnMGla?=
 =?utf-8?B?MHgxYjNqNy9FbXVvUHY2WjM2VTJWcnZZS3VtdTJ4V2J2a2ZyU1lQYWJReStF?=
 =?utf-8?B?Q0QxN0ZiRXJUdW54ZnBWWktQb0hFamJyWmg3QnVzeERUSXhXTDRNZTlTQlVT?=
 =?utf-8?B?VTFMcGV1QmxyT3U4YkVkclJUeVBLY2s4TFUzcmNQSzA3WjJuY1BMaEtlRUdV?=
 =?utf-8?Q?4QhU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHp3N2N5eFVQWVMwTnVveDE5UzhaVTAyZ1hUdW1neUJxdUxhSWZmeGRKYjB1?=
 =?utf-8?B?NkRmS1BsZ2J3dHh5d2hNdEJldzhxbjNQMkJDZTB0NC9JQkhRRlprR3RsVHNs?=
 =?utf-8?B?dHVwd3JFbVFwU1drVlR5K0swbC9LL25pTURNTFl1NzRzUnlsTFNPNlQ3OE9Y?=
 =?utf-8?B?a0x3dVVKR3hwM1Z4YTJvMEpMbDI5ZVVwY0wzQ3ZEcjIyRmIvNUFvcnpEbXhZ?=
 =?utf-8?B?NERzRERDY1pxWDVxNW5ET2JlN3J2d3Bway9JVEduK2Y4eWJGWUpMeng1eXVx?=
 =?utf-8?B?dmYrVDBJRHZOSEhVZnppZ2Z5NkJQWEk0R0RRdDI1Mmo3QnU4UVhrdlk1NkZa?=
 =?utf-8?B?Q1JVTGhkNWU3dUUyNDNGblVuQ2h0dUFWTTNxUmVQSEZBMnRvcnAxSzhlc1Uv?=
 =?utf-8?B?dy81L2RxRCs4Q1g1c01KMjJtaVJGNXRRWmNWWUFUaSszaHIxa1RWK0RZeVB2?=
 =?utf-8?B?eStabTJBTS9LdnVVaWhJNThjdzJSWHQwOTJ3OTBKSU8vWE9PcGxSM08vM2Jy?=
 =?utf-8?B?b2VjbTJHbDduQlBsaGVTNWFXeTNLL0ZJd2dSZU9BR1dBWERSL0dpeWFoeWRY?=
 =?utf-8?B?TlV0Y2VieVViK0dYZTBpZWFKL1ltVk9Wa0oveDdXQzVuaytzOHExeERZb1po?=
 =?utf-8?B?ZktCTU44MmNlV3lkeTVZaTlIYWl5eXgvU0VPWjVnNmdOcUhIOTlmUzVNc2Jk?=
 =?utf-8?B?TXQ1M1RlaEtPMEdjSWtEWU5WV3UvekpLNkRxNHpOQWh6QW9qODlrZHgwVFg0?=
 =?utf-8?B?Y0hCaFRaQ2xCanU5a2Z6Ti9kaGJOcWFZNUFCRGhvU3o5NUY5cm5xOHR5MXJK?=
 =?utf-8?B?bU9KQi9XSmcxaGE0YTMzYkFRdi8wUzdPMDh2dVB3QzZDaENiNGF6elo2bHlO?=
 =?utf-8?B?VEhKQ0NuTHdVbEY2QnRQTE5qY0NTbWZKZTE1eDlSUlYwekxMYVp3eGpGNldV?=
 =?utf-8?B?S21EeU5oYmFlSGN3aHA4d1cvK3JhMjhaODEwaFhkNC8rM0xrRVE0NlllbHlF?=
 =?utf-8?B?M05Db21HTW1xY0pWVFVPS3Q5QmJ5cHRwMUlOdmNuZVNzSXBxalJINXNqblNC?=
 =?utf-8?B?RWtVWkVrdjNnaDg0SkR4YmpSUlJ3YmY4TExLVm0zWGU0NEcrL1BHL3dGaWFY?=
 =?utf-8?B?Y3JRbWsrSUtvVmpPQ2NEeHg5UllidWZ4d0RCMHlpWnFtKzFaWUVRV1hjT1Ev?=
 =?utf-8?B?azN4RlJ5QXVYZWNFQVlpQWR5bEdhWnhpazhHdFdFWEpVYVd1Zm05Y1hoeEJs?=
 =?utf-8?B?S3VJbXFpQS8yT2craXMzZDdET1J2QnFHRjM4dHNublJ6aFd0bjVUbUd0MHpJ?=
 =?utf-8?B?eUx6eFdsUGZSbFhITGFWWjhodjc2cklWVkRBbURkaENONTFoUTdBWElXbEdE?=
 =?utf-8?B?VG54K1B1YlpURkNXMFVEbTM4TzJJOUVKbkdVSm9mSnA5cENJSnpmWllrY0J2?=
 =?utf-8?B?a25wNUtRNjVMSkxVTFFNUStpZUJNYm00Rm84cjVlem0xckt0UGFGdGVhVVRv?=
 =?utf-8?B?NFVxQ0RoemNSeFlXSFRGeDl4aWduaVpQR2JRaTZ2eVlqcGQzRmF3NDYwNEg3?=
 =?utf-8?B?ZTgwQWNhNE41a2ZSMUhSNjlEbXUrTi9QUS9JV1VzcXJ0ODlrWllOeVp1NVlG?=
 =?utf-8?B?QmVmWUEwOU1zRmorWTM1WWliZkhQL2lRYmthOUZ1TXFHc0lLbkxYeEJMZXdC?=
 =?utf-8?B?cnJiT3lQQXQxTmRsTVpSWkgrbndTUXAvaEJKb3JETWRhYUdPMTV4Y3BxcVBP?=
 =?utf-8?B?c29zK3VWS2tkY1NkTEgwdmtjamNZV1h3OTA3ZG4zd1MrSTVuR2xXT1ZoREtF?=
 =?utf-8?B?OHZick1KQkVTeVhyaTMrVHBveHdGeHptVllZcU5ZajdtMzV1c291REZNWlNK?=
 =?utf-8?B?dXpEL2IxbUJnQ1U3dzR0c0RRSWxURlNWcUFQWkd6ZDJFTmhDWjQzeWo3ZG9p?=
 =?utf-8?B?OEZkNy92RERvNGNwVHZtcGpaeExxZWNhdXk3T1dsZTJ2YXFCTWMyUkdaby9U?=
 =?utf-8?B?UUNyd2xjRGJBd09rSkFlbDNnc2JRbW1JZkZjQzF0YXkyc3NSSXk1OWRvWkt1?=
 =?utf-8?B?UC8vcGpNanBEWGlkZkgxTUgxS0NsZzVvNEFrYlNtcEhVRUcyUXZuOTJOZUxU?=
 =?utf-8?B?M3N6a0JsVmNXOWRlKzduR1BBUEV6RmxNcFgyb0FOTjZDeUVGUSs2QUVwUi9P?=
 =?utf-8?B?SnpBRmoxOXRQZVNjalc4U295QTJyMWhpVUJJa0hYTDBwQWV1MjVtd3g5ZWtJ?=
 =?utf-8?B?RWtiOTRSeno1YmwxVHVjZnlVNVNqaXB6VmxjZ1RIUU1GV1V0U1A1cHlLSExt?=
 =?utf-8?B?Smg5VUl0WWJIU3hjWTF5VUR4L2F0Z2V6bFFtTEE3RFc0T2MrWlhodVpLdE9k?=
 =?utf-8?Q?KeYt/LvJOeK8oHVk=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c02ecad6-08cf-4f52-89eb-08de63e38874
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 11:50:03.1905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2QalNOsBCNUJNaAu9BmqwsRdO43iVCQuUj/cdVU9hpk6r03VKjGCKHHZRqxBk2T2E4n5cYq4UWX5SWlyse46eCvSZty69NBxTXKz/201bs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8096
X-Proofpoint-ORIG-GUID: zu3GH06AQOdKlSN5MuV0_otdnmQemzik
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA5MCBTYWx0ZWRfX3F8ShPYmC7fd
 zyFzY4yaPgBeS5V3ny4t1DNORsKtorrDHCmDVY3nUZQwtit0S7CfW/sfCwkwctM0ATXBHOzrDYh
 O6kf2Swcsgmz0jlberJfXHh+CjI1AWXBGxGKunnbRJJQjIStgQzyV1CTONnOFRY29lICkkwLDJH
 FFQHRCdYoefYiMBuQQci/qGH2P75vmKlsj0/k/pO8Ljva8vQasXdqm6/CFWxqoMr6eIFuKGD6t3
 MU3AQkmo5evSvs68DQyUWiw7mUmh/MNiFufm/FoRwogUwElB9u/tyqQDHtqInSMdYJlBnt/0iZw
 KquexmTneqWbrJreyR3nhyc7ZgSrNbxdXkVpi//4xgpOvYDrJutn1bqG7FblVyQC8qar82xmzXK
 Kmc5sGO0pbxhpZOeDM9M5DOY9AQtNmIzxOGBL8mSplzndltlKsOyia4gL/EVbab4yMquS82Qvjb
 cHjs7dVWeixajut81eg==
X-Authority-Analysis: v=2.4 cv=K6cv3iWI c=1 sm=1 tr=0 ts=6983326e cx=c_pps
 a=VFd5apzHAUrRjeJ3DCr5RQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=P38ZuFq8D9Y-ftegFz8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zu3GH06AQOdKlSN5MuV0_otdnmQemzik
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_02,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio-be.c   | 5 +++++
>   audio/trace-events | 4 ++++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/audio/audio-be.c b/audio/audio-be.c
> index b3fa8d9c549..23083a75c3a 100644
> --- a/audio/audio-be.c
> +++ b/audio/audio-be.c
> @@ -4,6 +4,7 @@
>   #include "qemu/audio.h"
>   #include "qemu/audio-capture.h"
>   #include "qapi/error.h"
> +#include "trace-audio.h"

Are we supposed to be including trace-audio.h directly as opposed to 
just trace.h?

>   
>   bool audio_be_check(AudioBackend **be, Error **errp)
>   {
> @@ -134,6 +135,8 @@ void audio_be_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on)
>   {
>       AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
>   
> +    trace_audio_be_set_active_out(sw, on);
> +
>       if (!sw) {
>           return;
>       }
> @@ -145,6 +148,8 @@ void audio_be_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
>   {
>       AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
>   
> +    trace_audio_be_set_active_in(sw, on);
> +
>       if (!sw) {
>           return;
>       }
> diff --git a/audio/trace-events b/audio/trace-events
> index 7e3f1593c81..f7f639d9605 100644
> --- a/audio/trace-events
> +++ b/audio/trace-events
> @@ -26,6 +26,10 @@ pw_vol(const char *ret) "set volume: %s"
>   pw_period(uint64_t quantum, uint32_t rate) "period =%" PRIu64 "/%u"
>   pw_audio_init(void) "Initialize PipeWire context"
>   
> +# audio-be.c
> +audio_be_set_active_in(void *sw, bool on) "sw=%p, on=%d"
> +audio_be_set_active_out(void *sw, bool on) "sw=%p, on=%d"
> +
>   # audio.c
>   audio_timer_start(int interval) "interval %d ms"
>   audio_timer_stop(void) ""

Otherwise:

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


