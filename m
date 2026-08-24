Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CE0C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyUtw-00079h-0i; Mon, 24 Aug 2026 09:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyUtu-00079H-17; Mon, 24 Aug 2026 09:39:46 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyUtr-0003i3-Va; Mon, 24 Aug 2026 09:39:45 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OD196l3155209; Mon, 24 Aug 2026 06:39:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=fD7WQcCHJo2+756YTx6iQ/HgndbibOuWqLywjl+44
 gg=; b=qi9WC1udGyl4z3p8lUfISuMbXfnaLYCwDCcEigcwbpsJpXQTEgxovX7w7
 78ZEjXm1SfgbS4ctrPQ8rfOQwik0cAP0vidrvrSPbfa5mMmxGZsnamJnRHwS/ZJ3
 Ldbr7CsIBYrh5fSLZglV4NDNQyJC52ei8vQZx7z1ssC0ChMslr0FAJzAuRA4ewrL
 96Ajp3v5KucIFiy/IRdf5M6Ts+VQuq/ZNaoAPx0Xg8Ez3FvNcdRDC6E4k2efcnKx
 oa5M832ImcgqDggHq85N/V0aBh5sWsR87h7XEDgtQEBmg95q5vImPvC6Vae2hCrs
 JOayIBf6CrQtumZRnbM14H40YIZ1w==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11022083.outbound.protection.outlook.com [40.107.209.83])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g77p5bm0j-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 06:39:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Duj7O8xUBhHE3I9scakuKY586cJFtzonlCq0dY7Z+MUzKgQqBJNZ0SabNz9G+UyH5v/NEiAJj0lrVs3pSDIp9YVQZPv8O2eaJXppGaJVHGxh2j84dd+SZ6mJMw4aNMzwRd7ZBsob0NTxMy7FFEa78xl5Y1st0JgJ1D2gJdbDyBqxCfV4gwb1Y+yocMgsZ5UBJQm+yzjoEeu8L9z/hzMtfVnh1X0de4u/LvxbfIdDQPZrhE5fg9X1mVSAT5QCaY5XRuAHsh7tUmFvvQn6AXPrWvy8GgjL7sabUF7cD/bqYNP+MSQRdX1rrkqvaBu10Nl2ONb5D6iv5BT0QA75nm/nmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fD7WQcCHJo2+756YTx6iQ/HgndbibOuWqLywjl+44gg=;
 b=Ke/bUCWdXub+FJOJUTJp9fs0WH/i8oP3e0E/BHsla919/SFunCixuGsT54pFL70oQDPc0QPybaIjZKZSQ/NEjR35A+xYbMMcuhEQzTnlZKIia08lQFnP/mYbt7ZXEIYeV0iG3M3Rzne9+rPhZdDvyaMewr3XjnbqNJySFTsXtmvOapthZyKpJ6PuXMf4m1WTtLed1UDUdTVTn463dQLuzdM+syVgsFUs816IUMjbc7KBFojKNxtuIBCFYRkyNeHVir1wji+SAriwnIEVbBZfv7X4Q+TIHQ2e8Tsko1wSEtOLpXc3L5YT//HkTXuk7DlMDWn7sq1Qo5T+sFWgusP5jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fD7WQcCHJo2+756YTx6iQ/HgndbibOuWqLywjl+44gg=;
 b=uaNWC/OFwenyAwXRdASTmSpghyTXPfNvYJhNPaXkSDfd2hPu93gErzTUkMBOPRfgRART3y/MATU0alKo/c3PedVcgJ2tgAjXoKy8E2cT7ERZoIKoIxifR6fV2gjMRxF5mid2wgVJ5uuhWCotccRCcVRJufsJ3Fox6eU3AD/G3cqcoiEzB1B4GgFNqsydBFVNftfpnmpwDyx799fRTUeZsQ4TTDbDxw1Qs4qhAZLTqNZhp7eloJGGz1T5MrwNbhsRUFY3W3aMj5Upg6plPYoEMkgqIvnz+9vR+JrCrOY6l2pL2cWcJPqNer2zOmA71+QLmgcC79o15xV6cL2XUFaboA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSVPR02MB11963.namprd02.prod.outlook.com (2603:10b6:8:41b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 13:39:16 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 13:39:16 +0000
Message-ID: <4e90bfff-3ea2-4931-83a6-3c414679f7ba@nutanix.com>
Date: Mon, 24 Aug 2026 14:39:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/16] qom/object.c: add
 object_class_property_add_bool_ptr()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260821111550.276011-1-mark.caveayland@nutanix.com>
 <20260821111550.276011-11-mark.caveayland@nutanix.com>
 <aow-wlxrMnOS8Vqv@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <aow-wlxrMnOS8Vqv@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0174.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::23) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSVPR02MB11963:EE_
X-MS-Office365-Filtering-Correlation-Id: 134d31e9-2217-4fbe-ecbf-08df01e51787
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mLiZYE1KUcxS6c2jB+vMiphYJ59ERjDfjSBXWb8gzC6j28PFQkyYu3/bUbpzpToSp1c8NCPwzGwDDcyXT/nIE6yvARGqdY24O1cBpiJm2wnoZiZBVuCzA/Q0HAWSDtuT49ipdAULnKO66EoKJRnW1FmJ9gC/1ZctZDKYqmCZfU36C5t1EOoY/zox+NunD3cAD/wfuP5cVMjgdq178CjWGinTg90mr/0qt7l766dPghMgVE6ThPxeX5x/M2YWWqhIjCdQ12ZsUhzyTuVHI6DnKSU5yWJRd1NNOd1xSKyCdQW4UZOzGjfrJDJ47s2maoHe1XqJcLaoYu+/cWomrury0LbtklcPIBs7rY4xIYdXtNvBwXcUjoLELiZcP4SRrnKlJlNoTQfYYWweH26Ags6SHXXcEudGJ0jGAIh9gYX4fBBas160X3TnlgfAAZev2jg7EpA1v3k++IHXTM9UxgJAUqQH8hOBKCQEcDFFRUc76WZ4V4JfL5B9q+hUJ/WhNzDDj4HTTwCSxxqt9igqIkluVUOijS9ckxOvRyTP93PzWGb3vBELYMlwJ+qRhMCjyWYHUZgaGqaWkLHkiDjQSUsJqaq6y3+YktvCWda4/iyHqZmkgP1T89MTOaRa46+297YaQMevPu+VpS/oGJihmGTM+bY6VOB3JUcR2y+VrmYdLmc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3kydlZIMk4ra0NiaEVndkFlNEFtcmZoU3BTNllsZ2l6Qk5PS2xreGp1Z3JX?=
 =?utf-8?B?NTFSS0g5aDNVcGhHS3Y5d3IvS2tLKzVJelB2MzY0cW1JaGRGU3ZFdmpRMjhp?=
 =?utf-8?B?NzJxazVHMzlXV3NtYWRZcHl4Mkl3SXRXQXdiUlJzeFdPQU44UGQrei9ieDU3?=
 =?utf-8?B?OTJxeGRuU0RmeitmVThDYmNtc3o5K3p6ZUdWaUlsalNsMEVtSWxmcFNEaUFk?=
 =?utf-8?B?ODROYVRGc1lzWHhoNTFnR3pPbkgyamhYRU5BVTNIc2JwVHBjWEpOTTd6YXdK?=
 =?utf-8?B?Qjhzc1ZoN2VXWmFxZHh2QzJwaytpMlo3MlNYRmh2NWw2S09iZmVnMWl0Rkpu?=
 =?utf-8?B?d3V4eFVQVGFxRHRoK2hUZHZpWlZ1SDVudjk2WUNGc0Erd25MUjF4Ymh5NWd2?=
 =?utf-8?B?cXVIMVg3enhiajVDVXVwSGdmeWUxbXV4cjQ2UVpCSmNVZUhhNFlRN2pibHJt?=
 =?utf-8?B?ei9YZ0d3OGxVNHdER1F0MFlwQ1NwSE05UTE1RG1NSDhCd1Y4bmxLUXhiT1NN?=
 =?utf-8?B?ZDR4eDZJV1FiSk41V1BoZ0ozWHE4ak8rN29JVjVSOERXTjFPUFYxaWJqUnFO?=
 =?utf-8?B?QVk5K1Q5VlJIYkhmWmVySUxvTjBmbVJTektkYjF5Q0kwQnZ1SG1NTFBSV1Jy?=
 =?utf-8?B?Z0tML1RtMEd1aTdNUEw4c1JSYWNpUUd6em5yeFkwN1pSVUNFU1B5VjRXS2dB?=
 =?utf-8?B?KzRuRHlpZEgrWFBEdXphdCt4OURzYjdzcERxNmtwTktGVHlwS3pUcDl4VlFu?=
 =?utf-8?B?SW93emhTSDl3enBOeVBKeVdjcWRXRVduVVlnYy9VQ0xKdHBHUlF5Ri9OTFBT?=
 =?utf-8?B?UmJvMURpcFpmTEdlY3lnYnc5WXk4L00yekE1NklUVmNJeVppZ0xjK1VML2Zw?=
 =?utf-8?B?a2g1YjdGOSszZFg3S1pOeUZTUWJxdUt1Z0hPbTRaOEt1RllPd0ZhOExHbGpU?=
 =?utf-8?B?bXkxNUt6dmZVTWJoa0NPbUtBOVdCOXJOam5Fd1kyQWJkdUJSUTZWWlg0STZp?=
 =?utf-8?B?TlRVaWRlaFgzdzIyM2JnRWxyNmJOcS9qcFh4UDdEbURZK3d3aHRLNlo5dW1v?=
 =?utf-8?B?VVh2Y2dzUDBwVGNrb0pvMEd3WDFrUmdjdHNucllZM1Z1S1AzU2VYblF4d1NZ?=
 =?utf-8?B?dnJnd00xZXBRMkdLVWUyTGJWY2JWczQ2eDN5bUFncTdlcmlZRkc2dEszU2Vm?=
 =?utf-8?B?MUh6a0dDNGdjY0dzRjFKaWg3bDYvUm9tME1xN1VUWVMrRDRTbmtXWXM2cWty?=
 =?utf-8?B?elRBLythWXorRVhHeE5JZWFuRjFBQ0krOGpwNWJweDZPQWh5cThzMVpnOS9t?=
 =?utf-8?B?aEpaVW8xNnd0NHY0Rk1ObG9XbHJQWmplRlMrV1paMnRTT2lPRHpZVlNUaS9S?=
 =?utf-8?B?UnZRS0FyZEpZOWp1RjZ6YkFtb2Q2YmlCY3pSUlEyTUNnZXpyWDVseTBnS2dm?=
 =?utf-8?B?SGdJOFlCcFljbmxLaytoQTFsWkdIaDRzSGZ6MVBFalEybG0vQkd1MWNMVkNG?=
 =?utf-8?B?YUVGeUw4OHNoY0RrMTgyVmFDNk9mU2hPc0EyVklQMC95a0dZeFpjYWhBeVor?=
 =?utf-8?B?QzhDYVNJVnRFRm9UbXhXVklNWG81YktyVWg0dWI5SjJnZ1RTdGtIa1JndDZi?=
 =?utf-8?B?MVBsZW1zTHZoL2VwV3BSOWZiVytTZ2dCRjUxaTkrZ1hWdmpJUEdNZG5OVENz?=
 =?utf-8?B?L3EraTQzaDI4MUFPQmdYcXdCVmpXU1d2N3FabVl3dGttYnFDOXFGMTBSMHFO?=
 =?utf-8?B?bW14NnAwRjNoQ2ZVUEtic001QkE1QXhWb0xvSWhqRUJNaTZEUVhqQmFTUm10?=
 =?utf-8?B?MzBHaGZLMG95b3M4V29DN1JHamR0UkM3cVVNTEdnMDN6TVdXbXphcmp0TnNT?=
 =?utf-8?B?TWh1SWU4MnBFaTdrMXNZaFdLUWNtdmNjNVptZGp4eEQ2eDhmOHg3dkVjQnJh?=
 =?utf-8?B?NHVERnhrN2htUEl5K3RHUEdHYUY2M09NcnR6cHdSU1NCdFNFZS8yN3B4Q2lH?=
 =?utf-8?B?ZExYRkUxa28zSzViZmtrRkVmdDhaeFVRUFBiQjc1QmZZUDBTYVUwR0l2SzlR?=
 =?utf-8?B?ZFppb0tLS2F0MkM3TlpEWjFvZ0d3RGttTlYyYkVPL1Y3cXNhVFUvaW9jQWJy?=
 =?utf-8?B?aDZINVhPR05IK0JiZnRsakNoTHRsMVJlMWNmb0V5UlJHYjVBWU5sbndkcWtR?=
 =?utf-8?B?d3hKV0YxaE1salBNajZZSkVhWHRaN1lUVlB6cDRFbVpJZFNYQXY1SWhnNzc5?=
 =?utf-8?B?YkI1RVZIbmorZ2pmRHRvU2tJeitQVWtGWlZFTW91NE5kenJGVFNmMitjaENw?=
 =?utf-8?B?cFBlVlczUG44RkhiK1ZBVzlIbjRGMm5FcDdRQVJuaDNOOVFwVDJMb1A4dEJN?=
 =?utf-8?Q?P8yy4OCIf2Xalg/0=3D?=
X-Exchange-RoutingPolicyChecked: xw4BHqC5WSphUKspkGn0KoNlvzTUXoOG8ievNCmoDHsgwJz3xnTqatAiNeHqNM1CvU7s6lEtDMU22x2A46gqvdWYRDFLM0tfJV7TocdgpCbscak9LETMgbhzfsfhe75r5BYCDdha29mrHBdLtySH0SfvDSmqdbGEZEpOftY9Lu2uuk+k7D24RA8wTOh1zwZqDck4+rHDSXi5P3TOSuTdvJp2P98dv+NjNDzYvCM6VuSlzcWF2VtpPQX9v/CK9u3ziwgLgxwjLUPDL01LQyVn0C02o9scrNHaB5dV8TtgY1NFiWN22piVaLzNLXFB6jEXkvsWWNIjrOtGPsIvLcHOUQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 134d31e9-2217-4fbe-ecbf-08df01e51787
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 13:39:16.5020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEk2vhTX95eJS4L38EnHoDnf/yq0usZH+HYoIREKvulEJxo/LGmYgvGTWeT/Pdz9zBSGjhDNOLA7a34jpoFsbTpdXciN7vS44URfwuHWbKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB11963
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDExNCBTYWx0ZWRfX73a2m/vhvX1U
 j27hObq4r0RwdlXxzD1/ApojQEA2D4e1r0godq++ovU9HLCAuVW6bYjouFAdGeVX64w5Egt06AJ
 jo9rLQOmdbjXXGgbhOVg31RkApABYXbTDt0goSj2nqicMrGpuJsXm2cbeYSd263Mfors+HXpZ3c
 vZ8b8fYRcLWvyJfXGW/3e/soPNMLjvfZqVSZ0UFCU9Y/Z07GP47ppDmkpgVBv4cMif8OfiwIv9k
 aES3RBl+UqM6OMdRGesmpokVB2xYcTYxUVZn7sX9uX1PSIPBnvfy2FWKD/1UVDKn8AX7nh2vC0C
 QmtNThr9KsTmht/dgLefn3VIhjy5gyu8oYAIdjqgI7wQIoaoJZciWvFDBrsBLhcwVoqO03k2RBN
 /P36/rJKEnUlHYrMzFshwkzfA2LYki7nMT9FMH/4r7sJeVdJ4HbRVbrLcaa2hun5jIQyPFMcIMk
 1AkJ8yFkbDyo06s+rUA==
X-Authority-Analysis: v=2.4 cv=LvuiDHdc c=1 sm=1 tr=0 ts=6a8c498c cx=c_pps
 a=9FtWz6uTepfq9RxXq+Llww==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=LyhtbYUw3Tb_jsJWIDkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mQ97R0fl3MxckHjZhktQHkmktMy3kl4I
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDExNCBTYWx0ZWRfX5QGkjkPgCouH
 +eNZqEe3PGL2uyEu4jMg217aUg2eMRvmckKCP1znZLDBC3D3r+FFI5LCVTmCAId2hgaKrlxJFQD
 OOgi0PIlPmA6O3muctXkZaJFy0wzPTI=
X-Proofpoint-ORIG-GUID: mQ97R0fl3MxckHjZhktQHkmktMy3kl4I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 24/08/2026 13:53, Daniel P. Berrangé wrote:

> On Fri, Aug 21, 2026 at 12:14:22PM +0100, Mark Cave-Ayland wrote:
>> This adds a class property that references a bool within the object instance
>> and is intended to be used as a replacement for object_class_property_add_bool()
>> where possible.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>   include/qom/object.h | 18 ++++++++++++++++++
>>   qom/object.c         | 43 +++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 61 insertions(+)
>>
>> diff --git a/include/qom/object.h b/include/qom/object.h
>> index 8dead29284..de37016ba8 100644
>> --- a/include/qom/object.h
>> +++ b/include/qom/object.h
>> @@ -2017,6 +2017,24 @@ typedef enum {
>>       OBJ_PROP_FLAG_READWRITE = (OBJ_PROP_FLAG_READ | OBJ_PROP_FLAG_WRITE),
>>   } ObjectPropertyFlags;
>>   
>> +/**
>> + * object_class_property_add_bool_ptr:
>> + * @klass: the object class to add a property to
>> + * @name: the name of the property
>> + * @offset: the offset from the object instance where the bool value is
>> + *   stored
>> + * @flags: bitwise-or'd ObjectPropertyFlags
>> + *
>> + * Add an boolean property in memory.  This function will add a
>> + * property of type 'bool'.
>> + *
>> + * Returns: The newly added property on success, or %NULL on failure.
>> + */
>> +ObjectProperty *object_class_property_add_bool_ptr(ObjectClass *klass,
>> +                                         const char *name,
>> +                                         ptrdiff_t offset,
>> +                                         ObjectPropertyFlags flags);
>> +
>>   /**
>>    * object_property_add_uint8_ptr:
>>    * @obj: the object to add a property to
>> diff --git a/qom/object.c b/qom/object.c
>> index f91764aaa7..635eeeac77 100644
>> --- a/qom/object.c
>> +++ b/qom/object.c
>> @@ -2750,6 +2750,49 @@ DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint64)
>>   #undef DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS
>>   
>>   
>> +static void property_class_get_bool_ptr(Object *obj, Visitor *v,
>> +                                        const char *name,
>> +                                        void *opaque, Error **errp)
>> +{
>> +    bool value = *(bool *)object_class_prop_ptr(obj, (ptrdiff_t)opaque);
>> +
>> +    visit_type_bool(v, name, &value, errp);
>> +}
>> +
>> +static void property_class_set_bool_ptr(Object *obj, Visitor *v,
>> +                                        const char *name,
>> +                                        void *opaque, Error **errp)
>> +{
>> +    bool *field = (bool *)object_class_prop_ptr(obj, (ptrdiff_t)opaque);
>> +    bool value;
>> +
>> +    if (!visit_type_bool(v, name, &value, errp)) {
>> +        return;
>> +    }
>> +
>> +    *field = value;
>> +}
> 
> Am I missing the reason why we can't use
> 
>    DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(bool)
> 
> ?  If so, could that be mentioned in the commit message.

It's because bool is actually a macro according to C99 which causes the 
expansion to fail.

I'll update the commit message accordingly for v5.

>> +
>> +ObjectProperty *
>> +object_class_property_add_bool_ptr(ObjectClass *klass, const char *name,
>> +                                   ptrdiff_t offset,
>> +                                   ObjectPropertyFlags flags)
>> +{
>> +    ObjectPropertyAccessor *getter = NULL;
>> +    ObjectPropertyAccessor *setter = NULL;
>> +
>> +    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
>> +        getter = property_class_get_bool_ptr;
>> +    }
>> +
>> +    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
>> +        setter = property_class_set_bool_ptr;
>> +    }
>> +
>> +    return object_class_property_add(klass, name, "bool",
>> +                                     getter, setter, NULL, (void *)offset);
>> +}
>> +
>>   ObjectProperty *
>>   object_property_add_uint8_ptr(Object *obj, const char *name,
>>                                 const uint8_t *v,
>> -- 
>> 2.43.0

ATB,

Mark.


