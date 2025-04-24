Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078F8C369D1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 10:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tbT-0003a3-7m; Thu, 24 Apr 2025 06:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u7tbN-0003Xq-A8
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:14:42 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u7tbL-0005Ld-4C
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:14:41 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O9SsCP025275;
 Thu, 24 Apr 2025 03:14:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=if8r8YpUjVWW7futaXRvuyov6fCGmFV5h55IXcznK
 /k=; b=J/hZBPBGRCvHRNexrXb2u+dul+/mSiPv6wqgBRmTBX8XGvGDsUxhjk3Vl
 0PxwtzC6SGFNAhMt8QE5qIHsVP2y3MDZiIjkkmGasElRjHUsxHevIZrkjwD6tJaw
 dYNcKX/wJKC0JBfUBRhtXjLckMsLgkBef9+pix8Y8Ua3n98aLG2Sx4SDAENFms94
 7N4AQa9f5dIkDxgaXKP5f63BPz1b8P9Fy7JZa17dKLp1aqDGy4DNT6np5LPJQpcN
 tMv2q0ANg1EjD2TfSoBm+VAW4R9lR8G1cVNLjBfXDasuYDy4BMpwP3yXyem17egO
 XcULUrutnJT+JOLPb3hoDYRCUk8Ww==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17012039.outbound.protection.outlook.com [40.93.6.39])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 466jhvm45m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Apr 2025 03:14:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oaQ837wXVYLQigCeq7NjwhJLhS6XrNUkvxAjS76EQq++SQCsao3CtYeQQ/ZZPmwUJp+2LKxoo9UDrAHgBLzrrCCn2jL+7J9m15Nlxlw0rzg0nAush+NHj1wmlLgM2n2KfkXg/l/Q9EQJH/mtyNYjDIgJgmja0nUmScXe2iOWUurT3bSoTrkSX+uwXOlPU0bEScnFUU+Ne1lmi1+rNBVneJppmq8hOkxIaqXy/BlPr3rR22iG6kYvQZ2OMvAdO0MPpsAVNn9KljZuoanNBa+861BZevfrVkZ4u9ATXax+yXxCRqMkPP+6ihw41qwQdJ3j/U9ACebyDixkqPooXX41xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=if8r8YpUjVWW7futaXRvuyov6fCGmFV5h55IXcznK/k=;
 b=YwUpu3wo08tjllzPf4U/vK0IRwzOo1uVkzcfD0H/YOieQa9PZ4kuHSGU0C2HATPj5HdelYjnWLlL9+4nkiS2g3a9qA6pFBlMqIuwdYcF6hIAdXo2nbyI1oa24ruJlS3hbHbKWxPzk2b18H14Z92o2dRPsx4DBws2W3ZTJbW7mhuSS6gTOdSGmiTjW0nyOmSc6UvAGTO1UPdZgF8MjcsCqnEyoRrUUAQBiFeLHPYDSUyDIVftNePsb8Ioyn2njNboCwAKWkpcu9zok/6P6RxvuZ/UMoP5hXWP0oFXf/Apc586YH+IBS09NPipOSnZiAwm/d6t9ut3Qmh+6NLa10tE3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=if8r8YpUjVWW7futaXRvuyov6fCGmFV5h55IXcznK/k=;
 b=v/OnBd1Wu9YLib7pWEqmN9pummHPELiKa5xRwWt9PWbNLElr+jbDSGF9lv2CqsXqCu2J+kUYxvyCE8EpZdpeSQ/wG+znbvWpgOpkfQS9GPIEZMGyv+8lGrKCrM+EJkatRMYKpIYM0AHk0l3TPLoeYHpptWKYBiraCHoquOnivefjurar8i9gEZ76kYzaztnnhwu72xKAnnUmgVbHKWUfUtusTvvfzuKRgYvq0CBIHaqK1xczssuHGwWf0yoiefzi3c1m5FdW2uJBZ994lutPtpXBHJvPE7awRp5YYZnuxQY/VWTsFSeLUuZYvVeKvtZ7rtBWLpnFfRH8jiSVq2dsDA==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 SA2PR02MB7707.namprd02.prod.outlook.com (2603:10b6:806:136::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.8; Thu, 24 Apr
 2025 10:14:32 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8606.029; Thu, 24 Apr 2025
 10:14:32 +0000
Message-ID: <9f71ab55-523e-4720-aa1b-2b3271038df5@nutanix.com>
Date: Thu, 24 Apr 2025 11:14:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] target/riscv: Include missing
 'accel/tcg/getpc.h' in csr.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250424094653.35932-1-philmd@linaro.org>
 <20250424094653.35932-8-philmd@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250424094653.35932-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P251CA0004.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::6) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|SA2PR02MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ff0c6c-c758-4f24-fcc6-08dd8318ce15
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXRVcmZIYW9EQWVCUkxZcjBaOWUzL2ZJdFVENTMxcmJPbWRBWFZBZmRaMDkw?=
 =?utf-8?B?L2ZVcTltWU9TU0RQdWFBZHc5WUl0dXBlY01pUVI3RjY1QWJaUHMyczZZbGc5?=
 =?utf-8?B?aGg2M1FxSmFSdFRkN0c3ZnowMW0rKzN5WUJPdkFPbk1pSE4yQkNFb3RHeEpE?=
 =?utf-8?B?U3dDS3QvWENkQU84K1R5UWNyQnJac0VDa1BVUVkxcktMOGwrNWpOdFN0Q1hB?=
 =?utf-8?B?Q2JNY3BjcE95d241Q00veEtoeGovNEo2bWh1WXd4RGVkZ3dYaEVEYy9XSzZa?=
 =?utf-8?B?K05TUjMxRlFKR2w4Zm0zbTQxaUJxMjJwT2g0SGlQRFljRnNKNjdvZ29NclBP?=
 =?utf-8?B?ZGJnRjlyd1Q0SUhLUlZyczRzZzFlS1VCc3dQZ3hKczFSZ2JPUUJFYUNtdGJU?=
 =?utf-8?B?eTc2ekVpNDZRSFRUR2gwN2JCbi8xdVoxcnI3bWwzU1VQZCsvaWtWWHd6Y3dY?=
 =?utf-8?B?M0sxaGljTThjVWR5WWpsdW9ndXVvMGZRczQ0NGNtd0oxNlBvempRZGtieGYy?=
 =?utf-8?B?a3J5dXNkUFVWRWNwQlhXSHFFSUFES2p3Skd5dGQxWjYwelJRUmFERXVxY3dp?=
 =?utf-8?B?UU14bzBtaDlpd2RrQW9FSTY0ODZrc2p3dFQvM0NHd1V2SjZEeUhMTlVTT0Y4?=
 =?utf-8?B?YlhsM2FuZHFWWVNJOWE5bDFTTzhXTVdTZDFJd1F3Uy9PQTNNc1ljem53Rzhr?=
 =?utf-8?B?T1JyTGVaREh4OGhTR2hFMVZJS3Bteno4WHhCWks5WDZaU3RydXdlUTB5cDhO?=
 =?utf-8?B?WWFjZ2c4M1Jxdi9ITWZqbkJJbm0rU2NucS8vYmhBcUNCVHJTd2JUVUxVZ2k0?=
 =?utf-8?B?Ti9lV3pCdFhmVzR4d1h2c05RbDNrT2dqR2VlNTZGbVgvRnlsdkV6Vzc1bHpF?=
 =?utf-8?B?RHhYTHdQTFZGVUlVTTBzWDhNRTNXQkNOVU4vb0V2em9rSWt3aXJBODl6VnQw?=
 =?utf-8?B?eVYxemlhM3h4N3pzYUtYOXV6dUExVzk0OEJIWWxSMk9McVUvaEhlWUZGQWNQ?=
 =?utf-8?B?bDFnWUwxMUJaNC9sN1J4V1BYT1BsNUQ4ektoWTYra050V1BXNTRHbi9Ocko2?=
 =?utf-8?B?QlpKY29VV0ZOT0ZWYTE5RVdiYnpWbG8zTVdsSEJtV2JpOUxPeU1mNjc5WXln?=
 =?utf-8?B?S2hiTHdaWUc4T3FFSlRTMFFONXdIVVNMTGNzc1JseDlhek5UclFQZmI3cnRV?=
 =?utf-8?B?OVlZYUl3UHZIQlhOeFdCdXVTK3Bwd09nTUhCRDhWZDJwMkJOaUFZOHprNlB5?=
 =?utf-8?B?eElXWSs4N0pVN2pXVnFzVzdEVmZJNXFNblZieUJ1M0FYQSt0WmIxc0ZhS1BO?=
 =?utf-8?B?WStjdzdibndPZlpCdVl2TlI5VnJhbUtKZ2Q3R3JtNVFSc1hTT093UG1ldnBh?=
 =?utf-8?B?bHRHdnVDV1B2c2laYlBoZTVyZUlVNW94ckZXN1FMU0tIZ1c2MHF6UnliSnRQ?=
 =?utf-8?B?czh4NzNCN21VNmJEWTNVM1pNY20rRDRXTlgzZDVsdHRUc2JOZ2hkdlpraFE5?=
 =?utf-8?B?eExPSXNYYW1RN0UzSnhqaWhkeUV5dDUxZWFHOTU1azRvdTlJOElzOEFkbHo2?=
 =?utf-8?B?YzAwQ0pMVWY3U0FSWmZLRzg4cG9WR3dEaDlDLzVrcXFmc0NpZ0d1Rmt5S2Za?=
 =?utf-8?B?RGVkYlMzcWVKME9rR0J4Sm5mSGs1KzhBdG8vVUR2cGxOUWJKaUwyMTRUZGZY?=
 =?utf-8?B?cHl1Y29xblNETkNodVJRbVVYOGtPU1NhSEUvc2F0TVBaK3R1VUNsL1B4SGk2?=
 =?utf-8?B?Z2J5MTRwVGRzV1E2MEtjSXpDS3BpaVlHT1NPODAxaTA0dHFuZExhUkZ6Mzdh?=
 =?utf-8?B?THVhUFFhMkcvajdGcGorT1pMNzh1SFloWklmWXNQLzVueHFTNzBFM25BQVJH?=
 =?utf-8?B?d0JPRUNySGdxUlY2MlFBaVdtdnBlSlNib2lXUkNlRmtlYjBwcHVka0xtSGFx?=
 =?utf-8?Q?QrVr1zT8b90=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a21vZXJOUzFHc2lRekxOd1lBeHppQTAybjVGU2xqWUszK1BWeXA1RzJEY3Nr?=
 =?utf-8?B?T1Y0SEpqZS9qaHlQMkFYZ1dnT3k0bjRKaHFVQkUvNFNWQm1jUGN6RDNya2hp?=
 =?utf-8?B?M0lIRHY3TmhCaHpZYmNPZ1UxcmQ5RTkySDNkbFJ5OVFqNXg5MmNZdExpNXZU?=
 =?utf-8?B?SjRoQ09NREduMllNY3RMSWJiYXNNeTNVOGpsY0ZGZzlkS3ZlVm1tOVg1Qmd5?=
 =?utf-8?B?MHZGQUJPS2xYL05vMGlIenJ5NGZseE5BTHJaMEp2YU16Yi9QY3ZBcWZvWmpn?=
 =?utf-8?B?KzJ5ckM1Sk95NnF6dit6dTJJMzkySnFma3JoZDlBSk82LzZpRTZyZjNUbStN?=
 =?utf-8?B?dmxUeXNvOThSc3ZQSmNKay9ORFd3KzVVeDZ4RUlZdDJ5MTR0Ums4clh4ZmFS?=
 =?utf-8?B?aytCanIyeEh0eHhFRzhUZjJkbmlFdlVMbWJvdEFFQVFlc21uRitJTnFjcWZB?=
 =?utf-8?B?RXo2eS9lSTZES0tUQjVhZm15bE1BOXIyaEhQVUNPYkZCVDNFY3JrellGSFUr?=
 =?utf-8?B?aWl1UzREZWxsRktLM1pIZ0VaZ1RnWDgxeVNKWEJyMTdQZEtOZmVOaU5RbEtN?=
 =?utf-8?B?OVdQSFNhMHYybkNuOUQzdElZZHFuQ0RmUUxVcDZFVXN2anF0WFI1Q2k3TEZm?=
 =?utf-8?B?anY2bUFzMFJkcG5hRlpGMlBWd0lLdjVrbnU4VGNiQldqcFY1anZCdlZuSGhj?=
 =?utf-8?B?OUVYdlhDLzNRbnJ4RzhVTlAxV0k3YmpLT2puN3NNOExrQ3dpUTd0TndEamZP?=
 =?utf-8?B?WUd4Mnl5R2pjR1haNXMzVXQ2Vzk1bUNFTnBrU1hiRk5jVXNqbzUrZnNFNGtG?=
 =?utf-8?B?NVJkN2lCcHcyMTZxT3AxTkxvNFlYMS9BL2ZOTnEwNzBJZTB4SmttdUtnMDdB?=
 =?utf-8?B?dUtRdHFKWWZ0NWRuVytvUHBBQytPQWFCV2dxK3U2M0w4ZXA4RDBJRGJGaDhm?=
 =?utf-8?B?NFdicU0xK0dQRnlrWU5TcE5YSEdOSWlYZW5QcTByZU9kNytBbm8vWTB5OWR0?=
 =?utf-8?B?SzdXS1NlT3ZxaGh2NmFrdkplZDZUME9DdjJTOUtJYTNZM2Q5TWp4V3N3V0ZM?=
 =?utf-8?B?Y3dtaXIyUjdIK1A1a296OFpJb29VZThZNDV0L1Bvd2tOS0pyTmpsYnIwYzJ2?=
 =?utf-8?B?Y01PYkdwZVBEZ2pYcXdmVkdrTHBSTldVcFJSTHhwMGFqT01zRGxqK21QWTZU?=
 =?utf-8?B?UHVvSERySkNXUDhlbmpld1kwdWJmL3E2c3BKN09jMXVzUEtBZWdjSGk3T0FH?=
 =?utf-8?B?dzQrUmQyMlB3blQ0T1FzM2xDbnQwWXNqM2NhT0tFUkZYOTRtaU1ZYi82WnBw?=
 =?utf-8?B?MFV4S2RaT2M5V1dlUU54UXlGZExyWGRZc29SVGlCbTdBK25TbW1VWDhQNC9Z?=
 =?utf-8?B?QTdvdlVuNU9tb1lxcHlqdUE2TXh5NCtNa2k1Z0Rtd3ZRRmtHWG9lNlIxRUZi?=
 =?utf-8?B?UHVNVWw3V1VyMGM4ZUtHaUdoQ3lORVVEY2JrSlRiNjcxcUxMYmNDakR0MU1r?=
 =?utf-8?B?VEhIL1RNenYveFF4UXpLWWhxOG9aSFJxU1NKUWhiLzFCZDhNUUltR3AzZDBP?=
 =?utf-8?B?QmJkeUFCeEVWTjMrY0dQaG1PUnBrZ3QvYWE3TENsWlJaSFRiNXpsSEprdFFP?=
 =?utf-8?B?ZVp1YXVRcGxvRUJiZUJIeDBURGxaZXdzeFZkdDlsUjBnOGV6OXh4bmtoeStj?=
 =?utf-8?B?dExIK1FsSU0vdVdqaU15Vy9ZakdBUVRBMlRBZ2t2Q25SaDFVSGV0VkxGdnht?=
 =?utf-8?B?NzVvZmlUc2hXSnNTU1M5UkExL0lmdGNsMGVvamwrbVpKMVVqMkREWWZEWHM5?=
 =?utf-8?B?ajhjcDNVdUVOOWZrUC85aTU4cUdXeVF4QXEva2Z0K3ROY01XMHA0YmhaeWpJ?=
 =?utf-8?B?ekhUcVU3M0hxaWtpdnF3K0VORGI3K2dxSktDbWkzU1lPUGlLbGR5czhoZkRD?=
 =?utf-8?B?UmVNM3laY3JTNzcyaFlqdGl6TCtFZmlDRkRPT0dPaTF5SGp4NnVEalhMZmFs?=
 =?utf-8?B?RmRKVGZ4SGZxbWl3YVJqbTB0UGtLZEtwKytmUkVMcTkySHpDWlNSdGJrYUdJ?=
 =?utf-8?B?aWFKYmFQTU5UTHR4T2VLOW1PT2N6a0FmZXE4aDQvcmlrZWVGWVBac0hISzE4?=
 =?utf-8?B?bUVaNkJMVVZjVFlvS3dqcDNieUtqQkV2UmxDUjQxSWxCZklERVBrS0F3YXcy?=
 =?utf-8?B?VWxtbGdvdlV6c1lqbEI3bU9ZYjRxeFppNWlUb3BKbEJVRTBFTEY0MHNZT3NR?=
 =?utf-8?B?VEorZzA5Uk1UdkU3RUVVcVJqZytRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ff0c6c-c758-4f24-fcc6-08dd8318ce15
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 10:14:31.9389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOuaDwHMOZS9KwmhRHMOz27z2QKpLzpGKWGzf6MluaVAbjJ3PN5frbi8blD5J/fJ7PTMry4NZk0oW8SwQWfhxmQtZrti+YpeiN3AFL7VgCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7707
X-Proofpoint-ORIG-GUID: wcdRYf42qtO-P9o2RTeKwP4GOdLwcKUh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA2OCBTYWx0ZWRfX48FSMtVOCjq7
 rupLwIpUKn6nccikmTpfopLfQL/ZnhK1waMSNXYSIQ+e1pv6a4wSuhKYRkL1puiWwHneVQsEdR9
 cxUjkNgkCM4d2VJNQ57awEi9CJv6BZMiMidoGvIgKoru5PL6nQSyaSKkoCzboCzZtEGPVYf/aMJ
 TS6So8KMmWBJyOvdpjqRqqVSuC8eB4Dtdtf/iRth+Isx+/T+/iq4d4FK8vkSPBOIonowA3A45Sq
 Nmbx0pRynLy5U8FJbql4AmZGqLmeOdkhr1YCZZpkLzNo6ldKkDfej4JUGZAVZpAqanDEifJge5P
 QEMm7NSZbyX9m4OvDOdS9ePWlZ2ARvpB3GQY8y2FqmjyyJHd7vOolajBC7oYZFatKXhGWUIcC5r
 vzMwPSnqNigvnBGnTt/0Ol42Bvw//MJumeHEvKjBRrM23uOEti4FRDXhbsstMH+ff8PsMNFS
X-Authority-Analysis: v=2.4 cv=U52SDfru c=1 sm=1 tr=0 ts=680a0f0b cx=c_pps
 a=VIUGDxI8SzY5XGtng4SOXg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8
 a=aWV92-H7LAQdJQubTAcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: wcdRYf42qtO-P9o2RTeKwP4GOdLwcKUh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_05,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 24/04/2025 10:46, Philippe Mathieu-Daudé wrote:

> "accel/tcg/getpc.h" is pulled in indirectly. Include it
> explicitly to avoid when refactoring unrelated headers:
> 
>    target/riscv/csr.c:2117:25: error: call to undeclared function 'GETPC' [-Wimplicit-function-declaration]
>     2117 |     if ((val & RVC) && (GETPC() & ~3) != 0) {
>          |                         ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/riscv/csr.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index c52c87faaea..13086438552 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -28,6 +28,7 @@
>   #include "exec/cputlb.h"
>   #include "exec/tb-flush.h"
>   #include "exec/icount.h"
> +#include "accel/tcg/getpc.h"
>   #include "qemu/guest-random.h"
>   #include "qapi/error.h"
>   #include <stdbool.h>

I'm mildly curious as to why the target needs to include 
accel/tcg/getpc.h directly as it's almost a requirement for TCG, but sure:

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


