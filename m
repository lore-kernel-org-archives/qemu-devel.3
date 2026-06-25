Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F47CDE008
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 11:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wciAH-0008EI-Ll; Thu, 25 Jun 2026 07:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wciAD-0008Dk-BK; Thu, 25 Jun 2026 07:22:34 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wciAA-0005tX-2C; Thu, 25 Jun 2026 07:22:33 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P3ccnT4113625; Thu, 25 Jun 2026 04:22:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=suZqV+MnyLFYxVEvr1OI53JFjKAiH1AXRNOezpPTX
 40=; b=r+dMROCdNvCzh1FjcjeFF6Ou+ORoCmIC+t5mQ5W8q5V5+HiPU5d8tev74
 BYz1mIWsBvjqFvrZVV2SIFtkvTaxSkKAKJWNJ0BKHIBJ//Gaya9CFbHH+qIQJUrU
 Zl290kpSoTHIagj4Jh7RJ0842F6+RhEbquzTY/OCUsscK4LT49zGW0PehQIcS+Jq
 O+nnQcR+WMQ0OftG6mqqLT+27ILayS5M+heuFaXsNtpTjykP4rBTQfshdj64UqZ4
 PdurGO9IicWUY/6I+dA5xZSugGvdmwL84J8NkVdaqzUkfpqFi6C1LguQJtyMcGsO
 ro6RqrjV22tVNATgULsQm7sv5X8mw==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021079.outbound.protection.outlook.com [40.107.208.79])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4f01dkvfwc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 04:22:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkr+nttr3tZuF9OD3FN9v28IQvZsUGb4QlyHTsSGawnEb1VmGRzhs5OIUID0rSgUDuHyPXVcnPQTce1fiak36Ct0teAWFzCRm6VqRb9V+LWKTHvhOUPN3dTzs8/1nASmvPl4Q5Gy1NuKm22VjH5JkKWr71cD9E+LABokLHnPPFlXIFdeJbpuHE5F2UUNAEHFT2pt6Ot6ml+25ZqloqKesM4rO1/GbjR8k9IxUA4F2vCGH5Me0d7EZO91FK+RTSBwtrRzMfTw4hfejcwQUI5LMmBqtP6IcaI44ijR6ffi5AZgzqSNYrbjXyevV5bcnMGwo5S4xa0QbkZB/T0Hj13rNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suZqV+MnyLFYxVEvr1OI53JFjKAiH1AXRNOezpPTX40=;
 b=k9lwE9br9AQuZHv3Tp5RMfxUAf8f3xB4TaWc2KQan8U4xQNOQKcWJaGk66+Lkb/X9ygn9Vnpj/wbnQOiNaRgn1yZ1PZRIYIJp36y7vPy/0TrtZl7l2irNtPatCa9Zx69snWMuuwP7f8o2Yr2FuY2SkIovP1yj9i+gb7sgACZFsz5jZYRu8TQKLtvUQghFUZlRBPmFnBD4BK5vMF9BvQiz/ibdKupsWZIVIEsHrxNcZQ9i9R22UMjAlOX10r5CUghRoDLZQxCKR12ZxEoRyrQCLIdzq9sZ0KCKSvJ0sg0zKdlxR13VQRaPiH3LHj/P0b9pu0cHpH3lH5R/ai2Gj/hJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suZqV+MnyLFYxVEvr1OI53JFjKAiH1AXRNOezpPTX40=;
 b=bfGNyD64nRkdAuUr6Tu6u/pzaYI5gTivuis3s+NE15k7DjLPQcyabz+VFym5VcbZNmEOBfLJSnvb6SspBZn7Od5RdKMamsNL1XFJUm663yk1yx/q/up86WX13Y6jF5VsInfAE7bzlp8a79M6Xro2PVZY3KZi/ff0YjHajKNVnyxmWbzJ9/RXM7anyVlVBocUW/LJ64wb+b44KCsFfEi5Pb73/DHeQLEj3J7r7rlzeUb7dC/NjUok2AlcvHNKHd8JU6mq5caMogIBsoB+mlJ0L0E9un1kpNZ0FSRTE1uS8ZLxfCaX0iJHVCa/3K62IHBFlKc8MhNjduFAkZX2l/mX1A==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CHXPR02MB11329.namprd02.prod.outlook.com (2603:10b6:610:2fd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 11:22:19 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0159.016; Thu, 25 Jun 2026
 11:22:19 +0000
Message-ID: <d4596d4f-8b4d-4b3b-9a69-8f873b5a04cc@nutanix.com>
Date: Thu, 25 Jun 2026 12:22:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] hw/adc/npcm7xx_adc.c: convert NPCM7XX_ADC object
 props to class props
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: kfting@nuvoton.com, wuhaotsh@google.com, alistair@alistair23.me,
 peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20260625111201.1645847-1-mark.caveayland@nutanix.com>
 <20260625111201.1645847-2-mark.caveayland@nutanix.com>
 <aj0NozEEuUg8PpAi@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <aj0NozEEuUg8PpAi@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYZPR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:930:8a::25) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CHXPR02MB11329:EE_
X-MS-Office365-Filtering-Correlation-Id: ec249b17-eea4-4fe7-cab3-08ded2ac04e2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: PlF0g1j8WJCrgCFyrCjn5JwEZlUPl7YzcU4olC2RSdSpKf0PPnTApKUYBsHgUgj6sYqWVDWA7k7vQ1cZsYgAkUQOO2/wcnaqfP1XFWZ4C/02nJ4tr94iXjMXE/c+fmRlTvrKA3RkMmQZ8+ikDfPnrvDIlGTBKNZEql1TbNba1bFVnCGAUpDm1GmbKUJUOmH75DtDrd4m0EWtHWvTULJthkEzARwSyoLidsAoRpl7ZScyK97R+Vsg27ckTPP9WKa/bttk+GVpxHv9yndQV1uoJfYWhzVzWhbUAmpkaM2VzjM54gAAfp16C52pV4woa1yA8jY17FHAV9G4WIcGQDZF6y5lI1zA/LjleIVQ8VHfEzvTmfGQYXpos/478BIFiJPOo2COdtsrEBckCXHtzYQJYvnYe1cot9Y8Bd+MtOtFdbZJZdQqkYL9oSSTNvU4bZAgq5UjbLCWYwihkyeltUQ4PEnbdjOXqiV0dQS0Pp//AtO+67ACto5G43YuB21VVOAAJJTbf0mxhOyNJKRc+v507j0cR7nDrnlaYRnJmcFmHGRyc7KgvjGletxkMQ+4/Scd/nTFgW2x/3VQyXKlenUOEmzxBnt2eMMN4dqLvV9hKErTtBzKLEemiiihxksjuyK5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjQ0Zi9BMHhTSnNnU2tFMVN6WTdDOC9OeHJIcGVwWmFJdnVEUWhxM2hyc2Fw?=
 =?utf-8?B?QkI2dDRYV0syRTUvVlZJWTNGM3l5ZGxpL3lYeHFPcWcvM1ZQamlIdnVmN3pT?=
 =?utf-8?B?cS9TYXNSemwxc0FzYzJCYnZzSm51ckdHbmFYV0NqeHNQaWhSNzRndXNjenZE?=
 =?utf-8?B?S2grRXNtQVNBS01sTHkwWEtsYkZMaXRaSWw5anJiUjRoeGh1d29nRmNuM3Q0?=
 =?utf-8?B?R0VHNlRveE1TQkhYMkZzWEhteHY3UDNRMjdpNDk1L2FGV0txUUdENlppR0Js?=
 =?utf-8?B?WXIzZ0pXQlJpSmtacTRxMFNEL0lYK3F2dHlWWVhGcUQrVStyWElKTzhGYjdy?=
 =?utf-8?B?UDgycWRHV0VlWmxWYVJ6cmwxdzJaV2UzRUtTa3RLSzVEVG1FTUZyRDc2cXho?=
 =?utf-8?B?VmV1Mlc2NXYyMEFxUjhiRG8wN0h2TnozU2dwYTRleGJhMmEzVkpkdWRHdEVG?=
 =?utf-8?B?dXpzaUFYOEdhOTFqMkpDV3R0MzZOM2NRL3ZpWXJKVWtnMVFLb2tBRFdzMDNk?=
 =?utf-8?B?Q2RHUTRRMHR6M3dmSG01NXo3SUM0cmxJS2xrSTNTTWp4RXgrbUg2cTlhdk15?=
 =?utf-8?B?UklyS1Y0K3JXV0Y5MXc2T05HcDEvWkx2WllGMG9aT3ZhbnZaSmRoUEZheGFh?=
 =?utf-8?B?Z25TNS9kT2NHU3VDZ0R2UDZQUnYrWGZqNnAzSTc3VCtuOXpCTkt5YnZlYnVJ?=
 =?utf-8?B?ZGQrSzU2VjBGUzhtQ2U1OUFUZ0FiUnRtOTAxcnpkZnUxYWxmMTJwUkVXcHNZ?=
 =?utf-8?B?dzJKdHc5UDVPU1VLekVOdTBYMWh0NGJmc0ZpM1Npc2tBaUZMR0ZScDQvZVN1?=
 =?utf-8?B?cDVQR25pbks3VVlGcTF4TS9WSjNheHYxenFrbW1UbFJqcnZkcUNUN3V0cEJp?=
 =?utf-8?B?TUpCL3JwSDNCNUI3Qll0TUN5QTlRMkhtQ0xvNjlBNk55dXc3R1NiQTdsZTdJ?=
 =?utf-8?B?MmMyS3ZOcG83UExZWXpBRHZzRm9wSGUvaXMya0xIc25BUGRTQVV0MjNjZ1ds?=
 =?utf-8?B?dk91aWc2L3hvT3RJMmRFeGJHZk9SRUJjMFdDZFpEOGhSTWRjakl4d2JUSzd0?=
 =?utf-8?B?RGkrWTE3a0Z2bWprTlhjZllzTElvWkRqOEVxb0w1MWtnVmhPd1R6Nk1kaVhn?=
 =?utf-8?B?aVVnd2tXLzk3Mmdma3dUZkZUL2cxYjVvQmhEeVp4bkcxTTloZHVscnNrRXBj?=
 =?utf-8?B?TTBDZ3pHUGo2ZWhQRDhFV0dOSHFZTVVUZHZnLzREU1RSK2FuR0paZE45d3k4?=
 =?utf-8?B?dnZ1akRpLzNiWUdKQzVBdzk1b29JOVIyR3Q2aW81WHlTaHdoYXBUZVJBR2h3?=
 =?utf-8?B?eEtLVytEWkhGVWdNSElMMk9LTm1JZ3kyeityb284VlY3V1dQWVRmZFpSUmlj?=
 =?utf-8?B?S2NqZloreFdEOE9UZjMvSENBRnl0aElnMnhpN0VISVZVMXVyUmRFSzh0NW5H?=
 =?utf-8?B?ZHpFTjhWU0E5MlpjMUpZT0pyTVZyRlY1akRGanVSeXFqZDNFUFNGcXd1RzBa?=
 =?utf-8?B?VnEwZ0RBYlR5VFpVeFo4Z0VQSkNva0lGL1NPNnNVUXVjQjZiQzFadHJmUmZ6?=
 =?utf-8?B?WXpDbWt2NUFaYTJVdXV5aVp1cFpaWGIzaHk2aFlFWXF0aitXMkVySG9XdGhC?=
 =?utf-8?B?cXYzMkY4R0s2cU53dzV5eDJzbGlqamFYZXNJV0lZcGwwMGlUZnplMzdrT0tI?=
 =?utf-8?B?MGxSenBmb3NQektaRzltL2xaTHg5d2NEbVE0ZnlkemhlMGJGVldNOVJWVnRO?=
 =?utf-8?B?Zmhqb29pbnhwNlhYNmR6MERhRy9xUDZSaThLY1E3N0ZZaGU5a05mYXVnVW90?=
 =?utf-8?B?UVhjTjZLR0k3cHRPcHdGdkZZLy9jZUJWWGlacmhldTdyRjBtamdNWHpqM3kx?=
 =?utf-8?B?RmF0SVlPSjQwUzI0L1E1cHpwKy9ISmhDYzk0SzZOYXV4cXdNOHdnVmxJWDBK?=
 =?utf-8?B?RkpPOWpvcXJkaXZmQXE5RGtNMkNFQVZWN3JGSGx6Ui9UaU8rWEFleVFSbGt4?=
 =?utf-8?B?bVlUU0puc0s4aXVHb1J0RDlHWHMxY0prUzFhY1A0VjhTdDZpZzdyZlMzWnRm?=
 =?utf-8?B?NWd5YUxTMitGZXhidDV2L096NE1YTHlRT3o3SWlmRE1KUWptNGlYWjVTL2o3?=
 =?utf-8?B?L2hJMnJGRHVmSlY0UTJjWGh4alNXa2R6cXljTVNEOTIvYVd5Y0l6LzF4OFky?=
 =?utf-8?B?QmhzMDVsTWtzY0s3RWRBL283S0ZMVTFsSmVYRTFwN1FiL1lES09XU2VVZW5q?=
 =?utf-8?B?dDlKMStZdWtINUkzekFvN29VSVJNb3FlTnJ0NU11OWZsMHdFTTBLNTcya2M3?=
 =?utf-8?B?ZFFPQVZML20vNSsxdXlENC9RNkxLdG9BaW9aTDFtTlhWMjNJUTZTbUsrL3pT?=
 =?utf-8?Q?cJQmOc0BsXvy+M54=3D?=
X-Exchange-RoutingPolicyChecked: hQeZtmraZnfYRxn8Z5UI9gsemxkpDddB0R40kaNYiibfxsvwSTZaB6LUuISXyYHCTg6IwQRkyqDvsU8Fm/rFiQQRfo0/1BlITW1rpbZsk8YMzYuLKuTIuv1J/2DvovkidgEorvBg5celJ2dQHAVYZ9C+WrcELGPTdZ2YpJunW1KVNg41lMuZirvVli8Q82Zs3jwkVodUxCzp89X+SVx+iOxG6Xkzcm71MPJGkHV1yeyLZt5KJJz0A41ogW2xf1uqaZ7NpvCfNaMZznvM8BqL6lj3FtUJkM4YlHl2dlWFeQXBD36Zs3Kr6o7Lmxjfn7IWf82RFVZIOe7BTVlB8xaQ3A==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec249b17-eea4-4fe7-cab3-08ded2ac04e2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 11:22:19.2591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJurV/i2YAtx5YpNBCURQgrZy6IHk0zQ7NLNT8cD9GujRYtCP1276YyoYEPHMmVi2sZgSMHqVUkIwmI8tXbe8k7M71/yNmUMra9M8h/Enug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR02MB11329
X-Proofpoint-GUID: b2XRW-wv8Vwl923nQCm_rULZzSAmMtEI
X-Authority-Analysis: v=2.4 cv=LYkMLDfi c=1 sm=1 tr=0 ts=6a3d0f6d cx=c_pps
 a=OrhHz3+zTO+bBwkwaozMtA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=GaQpPoNlAAAA:8 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=_D8b0-00iCe2kPsQz6QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA5NyBTYWx0ZWRfX4us9OYIQn8Iu
 5KXRSK3TvtKTeDPTop0j3SSM8Lks7jTho8kqWYJKbFFc/qjW44CweOODC4+6b4oDYql9McahLOu
 dMwCGGTFrMXDek6QmS0ZyrmU8ejQ9hScdCFgedOfHm8LTi2lEWzgN93KZMZOz6yL2yzxPH7eCQN
 jomVLL64w0bwMi+yBe6pscCtvavRSzt4l5HpM8kJEGtnxCqL2BTKtzELlQxJHbdKjSHYifWT2OU
 c1I7Fl/p8gdIMXMn1fjzIczxHwWmiAEQ/Al6HAqWVxvA3+rtsbcxZPxgxkYq2gMjl2zuyND1If1
 QNxY+fgqswp6HOFnqART3uqZh5IKtkx6uWeAuDQ2USkzt7fFdVFKFV+jAaeH69y4rYS49/BUFfH
 69RP5DFqF07NCZjewkQsrDh+lIgw2ysx7mbA606EtYobpZROjJKTOzvxtwcV6YyH+rrcXo9mcSY
 gM9P42X3fqsqOJiSguQ==
X-Proofpoint-ORIG-GUID: b2XRW-wv8Vwl923nQCm_rULZzSAmMtEI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA5NyBTYWx0ZWRfX29JlmxNTyRj4
 1+MbBj5yNz/TsLL05fyHI/KIdPLVYU6NynvPZm3FI4cuHP7JiEFHX7tpbSVwv+XbVPQEvGA9wcq
 0x7tPIwm+zOjdHsDAqwQPeSH7DbCxmM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 25/06/2026 12:15, Daniel P. Berrangé wrote:

> On Thu, Jun 25, 2026 at 12:11:17PM +0100, Mark Cave-Ayland wrote:
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> ---
>>   hw/adc/npcm7xx_adc.c | 77 ++++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 70 insertions(+), 7 deletions(-)
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Thanks Daniel.

This is actually the 2nd conversion series I've sent, the first is for 
hw/acpi which I posted at 
https://patchew.org/QEMU/20260622112403.928954-1-mark.caveayland@nutanix.com/.

Given that such changes will cover a large amount of the codebase, do 
you think it makes sense to send all the series through the QOM tree? 
And would that require an Ack from all the relevant maintainers too?

My worry is that the conversion process and dropping of standard object 
properties will get dragged out over many months for what is effectively 
a global mechanical-ish conversion.


ATB,

Mark.


