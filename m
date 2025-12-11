Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8E0D41C24
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 18:49:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTljH-0005bu-O5; Thu, 11 Dec 2025 13:49:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1vTljG-0005bL-He
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 13:49:30 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1vTljE-0002Zt-T0
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 13:49:30 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BBEPET51525017
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 18:49:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=c1bTFIm2JL5+apMWaM0xz/Eu9Ks0AHJSTR3mChQvWTQ=; b=bI
 SqX9LpMWtcNGM7keXp0zZYg7fdO5NM7smpsEaILwvo+Cs1efrChie2Zw3GglWhh6
 opzUd010eTqxyKpt5d63FReB+pnUeWi4MykKri8YZx14fEB2x60hhKUBnud3dWpx
 EUYhJfdX8lrR4k8dJVQdA0w/ZRSpqnDUsALniKP0v8c+4kEq3m8h2+UCnHwWkDgh
 SFKWbPPvRSYIY/SjHabqfDEjhzygyN0ZXOX3kue/VXhRUuCdYW6KwvamxtmE9jTS
 zDW4wDwxjW4hh988/tAKy1KwBxGVmH8cLa9SHTCLFg6hdtGQIUcwAHpvsdWi9Z8o
 +gO3nDdVK/l/R+ePKdcw==
Received: from dm2pr04cu003.outbound.protection.outlook.com
 (mail-dm2pr04cu00306.outbound.protection.outlook.com [40.93.13.62])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ayrpajbnt-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 18:49:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhTCD6cVqls42ZeOPnZBLkS/DkA5dLtTdXQiaKxLZUYl9xf4O5Mvy+Ne3xj6NLvXpv/DJ/LMxOYLKBrYlBUZk60vdiDgEeYu5nlvKT2iods+RQ/6ACCo3ueCYV4SPubVKzZ7GwsTifIZUZCWNZkfDuy206jM+4UxwxZMd7V6iv2WFHOkgsIu4XmVdI5/p7340Es51ukH17Eq2YvCuMhSh04SIPmyHISImDhT958mmMM2fAi0lB3W0Etspkq09eipwgU+18JMFs9dkXrSBIGQc1ZUoPzr5xlu9qSpDEjRA7goNohb5fJ4oTiJVTk5ez4h7eQ0sMUkf0uuqc5UJqRazQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1bTFIm2JL5+apMWaM0xz/Eu9Ks0AHJSTR3mChQvWTQ=;
 b=pNXpGZAMKze2Lfyt973w3naxteRyCWs10r27N09RshcWEK24T36lkHC29qi2GOaD1FpDZwtGbasoqhl5pU2uzXQo+hvon71Ah0IlRg1684UcmLN9rCRMTu0bL/XojQbUZQiTM8vf+YoRFgvR7b68YiMw8DAe86mBVn2hAJ6PxwexpyqLGeiEn9CsxtM+GYZiH8G37IotKCM+MxxWfy+caugcKz6WOSq3qJikl4mwZE7WkxU87az/GOG22u/UHQ7hpWDCgX45FrauV9e0ZhIoOjgLkF8CRniTjm45ZEY01Uiw/EtxHGoFWqAGm40isyv7njEBRr0U+JPuvzUDgBjaWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from CO1PR02MB8617.namprd02.prod.outlook.com (2603:10b6:303:15c::20)
 by BL3PR02MB8003.namprd02.prod.outlook.com (2603:10b6:208:35a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Thu, 11 Dec
 2025 18:49:21 +0000
Received: from CO1PR02MB8617.namprd02.prod.outlook.com
 ([fe80::5a28:4da0:a734:9bcf]) by CO1PR02MB8617.namprd02.prod.outlook.com
 ([fe80::5a28:4da0:a734:9bcf%6]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 18:49:21 +0000
From: Mark Burton <mburton@qti.qualcomm.com>
To: Richard Henderson <richard.henderson@linaro.org>
CC: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>, =?utf-8?B?QWxleCBCZW5uw6ll?=
 <alex.bennee@linaro.org>, Matheus Bernardino <mathbern@qti.qualcomm.com>,
 Sid Manning <sidneym@quicinc.com>, Brian Cain <bcain@quicinc.com>, QEMU
 Developers <qemu-devel@nongnu.org>
Subject: Re: Record AS in full tlb
Thread-Topic: Record AS in full tlb
Thread-Index: AQHcaPk/84BXpnny1U2sGuplCRM7l7UcjP8AgAA+u4A=
Date: Thu, 11 Dec 2025 18:49:21 +0000
Message-ID: <2A86D9C4-7EA7-4275-943F-D75801B5539C@qti.qualcomm.com>
References: <A5D46F85-9B92-477C-B964-1DCE2A1CCF19@qti.qualcomm.com>
 <0d3b4338-2c31-4e42-8a8e-319f3ad4029f@linaro.org>
In-Reply-To: <0d3b4338-2c31-4e42-8a8e-319f3ad4029f@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR02MB8617:EE_|BL3PR02MB8003:EE_
x-ms-office365-filtering-correlation-id: 0d5d06ca-ec0c-449f-0fea-08de38e5ff3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?KzlYczhPanRUQW1BMkVIZmZ6Q08rbjhuekFpQ1N4YU9DTWtVQVRObUFGOEEv?=
 =?utf-8?B?V09UWG9XQ0NvOTJhbTFLZnpMZmE2dWVyTm1aTm0yQ3luRVJjejZFUFR3RnlV?=
 =?utf-8?B?WDNHTWdMVStGTUozVytWTXRqSHFEVnhrRjZQQzRDalh1emMrak05eUdsZHRH?=
 =?utf-8?B?NDNwbVBBNXQwN2oxNENhT1Jyd2xXSXNvTk5YRjlMZUZQcVF3WDQ3a05XRnBU?=
 =?utf-8?B?aEhBaGlFc2xSc01HMGRnVWRvWFQ4c1JsSGt5MjA2akN3dVAwYldlTHUvWWxL?=
 =?utf-8?B?VDVCVFJzMkhKbE0rMnhRUEdCWVU2K1NFbUdlbVdYZTZhNUNlQjkydG80Y1ZO?=
 =?utf-8?B?YUJvU2FRck9VNVBFT0tITjRoWUdLWXFNNXRnNlFDRXdEYUJLN0s1MnFMS3ZE?=
 =?utf-8?B?WUVoNWtDTE1yMjNkcDRNRUZiQkJYTGFrZG9mUUNSQkVWRHBqLzdVQ1pwc2Y2?=
 =?utf-8?B?cDJoNmVHanJlQ3NBNitvcmRRT3dNV29xcHdxaW5OSWs0a3VlN0F1eWcrMTF0?=
 =?utf-8?B?bjdnQzNmbS9LUThVa3JFSVBYQjdPN05YSlNlb09Hb3BDckNRbU05T0JDc3g2?=
 =?utf-8?B?djQxNEdPM2h2QlhNTGtjOVFkNU1ha3p2RlRpS09mUnA3VGczRERqdzA4bVJa?=
 =?utf-8?B?eVFCVWF2eE1aYXBQWWNnaTJiZkE4dmF0OUp0bWNMbzk4aUl6OElXQ0c0NjQz?=
 =?utf-8?B?OFV0NlY0S05pb0QzMnVMbm5uQUFCWkltYmQzYVRueW5oU01vOVFIVXZZVFZX?=
 =?utf-8?B?S1VQUW1SbHh3ZFNDK2hhc2MzaERIQWNWaVdPQllMeDk0dzQ1OGhTOUJFVDB5?=
 =?utf-8?B?cEhZbEt0VDdzdEZNUEZSRzFzMjVJbnRtVkx3OUxGZGx1S1ZNNHl2WjliTnhr?=
 =?utf-8?B?NEQxVTBwTzhHMDJobVYwTTlsamFIZmR1dVRXa2VaRTQ1a0hFakJ4V3dvcnJu?=
 =?utf-8?B?WDd0eGM5RGxPRkxjTWJlY1Q5NlJZOVNhU1VORnpWWlJXUmZocWRQWVRUZjRW?=
 =?utf-8?B?bCs3TnFTc05PZjhDSWNNNjhqM3VoaVJkTndsNkxFdEJKME5HZDFIK1ZTcnRZ?=
 =?utf-8?B?d3RORGtoM3haY3ZtSHlYV0p5UnlhbklGSFlLRmd1bDdKUVhsR0NiZnRtcGxJ?=
 =?utf-8?B?Q1RrR3VYVW9HTmN0bWVmTnR6bVV5MUprTE5KSmhKWUxubXRDYTRGQmovaDlM?=
 =?utf-8?B?TEx3azhvbmtxYjRXTmdnVjkwY1dQaGxRWnJ3TXdUVnczSVNiN25yeFpRWnhn?=
 =?utf-8?B?U2xEd1AxQVJ3YjFiYkg3WldZeFdpRjRnVDBVVHhmTnVqR1JOVVdZbktBUWZx?=
 =?utf-8?B?b2VTcUNXQnk1czVYaUJzVDJEMFovdVNzUklzWjU4cG8wd0s1eEl3a0p2dXJn?=
 =?utf-8?B?S2dzaW1lK1lFNjc4emJjU0J0R3UvczFsaTV1Unh0MmN5aVU2TXZmL2VZTU1a?=
 =?utf-8?B?dWFNem5tSlVRbWVvQXE0eEx6STlOazR1d0NYVU4wYnY0dVN6NjJoeGFmOFE5?=
 =?utf-8?B?S1VBY3M2dTdvMmVLUE8vVnFhcC9kajhicEhwNjVwQm1tUEkzM2l5V001R2Jw?=
 =?utf-8?B?b29jZ2xGbUk2bldQOUR1bHgzV2d6d3pMNmN6eTgrT0tYSzhuYXpPaDBxbFhS?=
 =?utf-8?B?TDB4cmNYWkxOdFVpUjMvNzdGbjZ1S1lFK1hOeFM1eHlJMmJCK200MlVWMzhQ?=
 =?utf-8?B?UFRLaWlCTjlRa1N0WnlOdGJwZ2hUejB0NzBKN2dmcm0wRFg2QTRwZE5JcjVx?=
 =?utf-8?B?N3lUWm5GT3YzcmwvVjNUVkZ2V0FvQUQ1cmpVMFNBVXErdjJqK1N5bWE5UU0r?=
 =?utf-8?B?N3NycVVzdmR3dG1GVng5VklyU1pMV0J2ZnJHVk1YMUh0ZE9Wd0srTHdaOWlN?=
 =?utf-8?B?TnRkV2tlelVLVjRKSjVXR3padVBQV204QmluSjVBMlNxWnRsNk9WYzZxUDA3?=
 =?utf-8?B?azF0NEdodWJpK0xsZ1JwZ2ZCMjJLc01MS05nSzU5RjZBZDhEa2hkTWZSN0VJ?=
 =?utf-8?B?aFI1SS9OeHVjTTBKK0lNTmYzbnBuU01uK2xFNEUwM2hFSG9IUGNLTjkrZjhN?=
 =?utf-8?Q?s6fn+D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR02MB8617.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHd0SEZLSi8ramdsM2VNUHUvQ2g5ZkpOSExsSXJVd2FBR1RyRys5K2tCK2dF?=
 =?utf-8?B?VHRyWDhCQmhmN1owL3NISUNzamgxekhoT0FZak9NeER2aFIzK2dUUVhrbzVs?=
 =?utf-8?B?T3Y2ZlNSREswME16REJ4aUQrenpWcWx4V2hBVnZIc3UrNnBXTVlaR0NhODha?=
 =?utf-8?B?eGVQWUIvRnpMMXdMNVpUWERwVHRTcUlKY2dCRnZQbE40dEQvVUFESkhKRkFx?=
 =?utf-8?B?MmkvSnhsOUREc1Nsbkc1RWVvL3JDUzVRQjJyeFJGNWhadTlGUlZoVzM1RVNW?=
 =?utf-8?B?ZE1nNFVpQ0ovSUpWbnRpalFEbC9PUXZxVVFCNzNXTTR5RERBbDBGaVk2L2N1?=
 =?utf-8?B?azZoc2VDRFpvK1hDa3VZMnFUTkNCRTBaMmlOZDJ6WlJ5V2gxN1UySW54em45?=
 =?utf-8?B?ZytCb0NuRDcvaVhqTnlKdDhUWEtNLzVNWE9LaEJBRE5ici9lb0IxcDNzMVhY?=
 =?utf-8?B?MkZzL3Z4RjJlcFh6VlpWajd4aTNIZ1dsZlhsYWRJeE41Y2pENVVvRU04alBl?=
 =?utf-8?B?Wmw5LzFTMDc1RGI1dmhaTWp5ekpkSEVBTTFtMXR0WFlBNE1PVVBUc0ZFZnlV?=
 =?utf-8?B?bEFCb09wY3Y2czVQWThDSXNjVnA1VFBvd3RtTmR2Y2tHRy9oRy9zRE1TTnl0?=
 =?utf-8?B?SjY5SjZGbEFjNGlkMHZKRmtqMzZUU3FIOVNxR2FTWWJqWllNeGtaYlJDVko2?=
 =?utf-8?B?L2VrallBemluWVlWWTVyVUxpR0RrcHZkdjBvandWNTREYkszelRSRm5iSEFt?=
 =?utf-8?B?TkYzOFEyMjl5b2pGaTlWN1dSZlVFcERLd1JpWkhwYWwzQThHdWEweUFoOVpE?=
 =?utf-8?B?VzdYNmxpdXhIMEp4UjZpTFZYSG1OVmNuQndVc29DcVZ6QzhzK0Jod1RxZndC?=
 =?utf-8?B?SVZ5WEZJVXB4NE14QUQveERreE9qbHozcjF3VXNiZ3gyZmtTTzdydXhtR1ZM?=
 =?utf-8?B?MVJ6TXJnQ281V0ZUMEJaeGpMcXNJK2dIZkZBNnN2UGlYSnhuaUtYNEozU3Fk?=
 =?utf-8?B?bmZsc3VQTFFqVFFWbGFZV1poL05jcG0yTERjQWZnZjFXaEFoOFBPNFdiSVc5?=
 =?utf-8?B?RFAzYXlwUTlmQ0J3WW5wMlhUVWltTHZLRzA0M2JhOVYySXhBUllib1k3QlBh?=
 =?utf-8?B?bnlmb0xEOUc1ZWpjbXdCSk1YRTFmaWZoRHcrcjZ3ZW8xRk5SakluM3UvdHdy?=
 =?utf-8?B?Ly9MQlppbXpxbnB2OUo2QUFaQ3hyb3I5aGI0cll1TFdoRXNYVTM3V3BoYVd1?=
 =?utf-8?B?TGZMVnlDd1UwU0p6ck9tNng0cnNRTURqajJVelJQRE5lRS91M01qL1ZmdmxX?=
 =?utf-8?B?b2xGS25jSXNXRW5jSU50TkRFd2MrOGdHeFdFK1ZhTG9GanhRZms1ZHAvMk1o?=
 =?utf-8?B?VlAxeEx1RkZnZXU2SlhsWUpUWTNFbmhWZTdkUWxCeXFSbHBlYzBvYnkvTHdS?=
 =?utf-8?B?TWpqeUZHakdQRnk5dzBmVjQxdWZjdmJSRG5Qem15bE1YN3RHMGFXNkp3TGo4?=
 =?utf-8?B?SW9FNFRjQVRrK3ltQS95TkYvQkp0djZXcWZQSVJPb2F3T3NrV3lSbWFzNURy?=
 =?utf-8?B?R0ViYjhTOWlPSVRFRDlSMTFvQTE1VmNwMW1aMVVCZ1FlL1NYbER3YkViSnUz?=
 =?utf-8?B?RnowV250ZHk2M2VyMFN0V0p6RFphYllVNVp5ZE1HcjRtOUY3WHBzcHEwMDZl?=
 =?utf-8?B?RitFeS9lRUhGOWUzeng5eUlndUYwM3ZuNFJqTU1FM21DYTdMcWhjdWlPVTZp?=
 =?utf-8?B?bWRmRWVOaXpLeElPc3JZZHJmTndRR28wTkZMMEVHMEJUQmdTdnU2ZW1QczVv?=
 =?utf-8?B?cFkrOEtFaklHdWM5U1BXOUhxd0NSYS96aDhjTUhHV29TMXkxNVlMaGViSkRh?=
 =?utf-8?B?eDY2c1l4S2lwMzRWYmk0eHJ5ampjWEhzYnhRY1drL2hETWlwRzZiamhZNXFH?=
 =?utf-8?B?eWZ1RFUzMEQzZFpnTEpDWFcxWnJMbnhDSUswb0JMdS9vUjFGN0g5cmdicCtW?=
 =?utf-8?B?M3dMY3F4K3hjZ1Q5bEYrd2ZzUUFZQWZ4ODZTMzhvTGdNalQwbEZoUU9yMVd4?=
 =?utf-8?B?MGcxY01DbDFodFd1ZmlWVVFKcFloS0plaHl1clRaWkJ3SzNZUElRQnZmYmNR?=
 =?utf-8?B?VFBLU0R4SjlQaDFrdzIrTFBiVUtjT3NQenNJVDNneHdkRHFua2xlZ3hBTkNx?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0B6ECE4C71FEB4FA8A42BF8A068448B@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OVo2Dkjl6SehrEMl0j0NJ66dKk+92/GQQB58JOOg8srYvO9sPTtqCdo2fSIh9GmQfCdIYSzt1I4+f8D6w4GQPYhIhNENr/rW5LR9UXI1oO44aUE9KlOFmNiYkH6f2+t2pPb3/HEeo7CrK5wh9wOMGHgWaGpid80/utWxwcZHFJRLk0udm08QFWg/5A/dJ2lT1+xH0UQwCPJIHhtH8VPC4fKwxdRo+p3pl5kqsbnYiA8PYawUXN3syWFuXespcZm7S8rwTWh+Vr7RwCao27fXa8ziMIcxFQFsnaDC27MJnF4tTbj39vq5BTeHoyWStff9pvITYi8RpBzeaT73xIfWepOa7AGa9WWo6O8WxK1UNJZEyp7GAzdVa9h+kUkBw3F9FVAskCXrXSmAKaec3d6l5V+c5g3SyjUFvJ1AgNxVNwNyvATxRj22MSD1vwNHnyI8Gws725i6MB5eM4K8m6FfczZkYHezbpjiw7hKPFoliYl1Vj1kSyItgqDF6U4pHYBH4ASwseVg6TSGEsCWoyUkPHvo56/jZX1ee7jtZ8YRgs6clOBhAdGqQVOVRCU3sdbuCaSydTlzkhOAqPo8OitnnDvIAeRLvKnXCdMdRe4gh0CiPHAUHhsifhsOdBM9N5bD
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR02MB8617.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5d06ca-ec0c-449f-0fea-08de38e5ff3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2025 18:49:21.3793 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: op6OL4GspQiT2WJ0iLv7pGBy7KbWD7VIAfEpE0dqy8MY5PBmvebTpcwqLlFLoD8l4exAl8edehSAZqPmMQSpaKK3Q7JDLwnkc+BYD+XLW8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8003
X-Proofpoint-ORIG-GUID: 3BLQlxGMBITX6fWed-zrUxskdJnz85wE
X-Proofpoint-GUID: 3BLQlxGMBITX6fWed-zrUxskdJnz85wE
X-Authority-Analysis: v=2.4 cv=G9sR0tk5 c=1 sm=1 tr=0 ts=693b1235 cx=c_pps
 a=ftK1B4U+KuHZUR4f5igEJw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=22a0iAbIeQN_5jsVTaUA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDE1MCBTYWx0ZWRfX//+O9QIrxFFl
 2mCuQrPtgDaL3fxVYb1EBVduBz0v1g1OAmmc6ZIQ1XsSLo6NRLppSmSakUmoYC4zScYMUXN2RCw
 TffQCfUoVzK1MN0sUiCBQQQ5ACltwDGFEupN/Gklw0GU3q5DxySWiHIMwBeqIWj7a7mQubau38h
 j0fJWm49ydWINpHXEOWoH/KEtWwAIQdaeJVy5e9Lqlc9TCUxvdZqr8JDzGcdllF55FzblauP/Yf
 LIEUYXU4aw15TWYai3ZekMK77Xb/bEv1vzhKhFVDsg2xYhf+LwTAk1mHWOH5Vad1Qgb0JmHBA6U
 gm1BVhXXcvUTJh3OdSPZLZGAVBcEe/gvgrgs+RY9aDpMmryvafjdT5uGhRaOHq3nc644f0tVUqn
 Y09Aw2B/OYiP4iZ5ontpSK9alI8m/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_02,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110150
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mburton@qti.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gT24gMTEgRGVjIDIwMjUsIGF0IDE2OjA0LCBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFy
ZC5oZW5kZXJzb25AbGluYXJvLm9yZz4gd3JvdGU6DQo+IA0KPiBXQVJOSU5HOiBUaGlzIGVtYWls
IG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIFF1YWxjb21tLiBQbGVhc2UgYmUgd2FyeSBvZiBh
bnkgbGlua3Mgb3IgYXR0YWNobWVudHMsIGFuZCBkbyBub3QgZW5hYmxlIG1hY3Jvcy4NCj4gDQo+
PiAtLS0gYS9pbmNsdWRlL2h3L2NvcmUvY3B1LmgNCj4+ICsrKyBiL2luY2x1ZGUvaHcvY29yZS9j
cHUuaA0KPj4gQEAgLTI2OSw2ICsyNjksOCBAQCBzdHJ1Y3QgQ1BVVExCRW50cnlGdWxsIHsNCj4+
ICAgICAgICAgICAgIGJvb2wgZ3VhcmRlZDsNCj4+ICAgICAgICAgfSBhcm07DQo+PiAgICAgfSBl
eHRyYTsNCj4+ICsNCj4+ICsgICAgQWRkcmVzc1NwYWNlICphczsNCj4+IH07DQo+IC4uLg0KPj4g
LU1lbW9yeVJlZ2lvblNlY3Rpb24gKmlvdGxiX3RvX3NlY3Rpb24oQ1BVU3RhdGUgKmNwdSwNCj4+
ICsNCj4+ICtNZW1vcnlSZWdpb25TZWN0aW9uICppb3RsYl90b19zZWN0aW9uKEFkZHJlc3NTcGFj
ZSAqYXMsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGh3YWRkciBp
bmRleCwgTWVtVHhBdHRycyBhdHRycykNCj4+IHsNCj4+IC0gICAgaW50IGFzaWR4ID0gY3B1X2Fz
aWR4X2Zyb21fYXR0cnMoY3B1LCBhdHRycyk7DQo+PiAtICAgIENQVUFkZHJlc3NTcGFjZSAqY3B1
YXMgPSAmY3B1LT5jcHVfYXNlc1thc2lkeF07DQo+PiAtICAgIEFkZHJlc3NTcGFjZURpc3BhdGNo
ICpkID0gYWRkcmVzc19zcGFjZV90b19kaXNwYXRjaChjcHVhcy0+YXMpOw0KPj4gKyAgICBhc3Nl
cnQoYXMpOw0KPj4gKyAgICBBZGRyZXNzU3BhY2VEaXNwYXRjaCAqZCA9IGFkZHJlc3Nfc3BhY2Vf
dG9fZGlzcGF0Y2goYXMpOw0KPj4gICAgIGludCBzZWN0aW9uX2luZGV4ID0gaW5kZXggJiB+VEFS
R0VUX1BBR0VfTUFTSzsNCj4gDQo+IEFkZGluZyB0aGUgYXMgdG8gQ1BVVExCRW50cnlGdWxsIGlz
IHVubmVjZXNzYXJ5IGJlY2F1c2UNCj4gDQo+ICgxKSBFYWNoIENQVVRMQiwgYW5kIHRodXMgZWFj
aCBDUFVUTEJFbnRyeUZ1bGwsIGlzIHByaXZhdGUgdG8gdGhlIGNwdS4NCj4gKDIpIEVhY2ggQ1BV
VExCRW50cnlGdWxsIGNvbnRhaW5zIHRoZSBNZW1UeEF0dHJzIGZvciB0aGUgYWNjZXNzLg0KPiAN
Cj4gVGh1cyB0aGUgQWRkcmVzc1NwYWNlIGlzIHB1cmVseSBhIGZ1bmN0aW9uIG9mIChjcHUsIGF0
dHJzKS4NCg0KVGhlIGlzc3VlIGlzLCBpdCB3b3VsZCBzZWVtLCBpdCBpcyBhbHNvIGEgZnVuY3Rp
b24gb2YgdGhlIGxvb2t1cCBwcm92aWRlZCBieSBhbiBJT01NVSBhY2Nlc3MgLSB0aGF0IGtpbmRs
eSBwcm92aWRlcyBhbiBhZGRyZXNzIHNwYWNlIGluZGVwZW5kZW50IG9mIGFueSBDUFUuDQoNCkZv
ciBub3csIHRoZSBpbmZvcm1hdGlvbiB0aHVzIHByb3ZpZGVkIHdvdWxkIHNlZW0gdG8gYmUgZGlz
Y2FyZGVkLCB0aG9zZSBzdWJzZXF1ZW50IGFjY2Vzc2VzLCB1c2luZywgYXMgeW91IHN1Z2dlc3Qs
IGFuIGFkZHJlc3Mgc3BhY2UgdGhhdCBpcyBhIGZ1bmN0aW9uIG9mIHRoZSBjcHUgYW5kIHRoZSBh
dHRyaWJ1dGVzLCBhcnJpdmVzIGF0IHRoZSB3cm9uZyBwYWNlLg0KDQpBbiBvcHRpb24sIEkgZ3Vl
c3MsIG1heSBiZSB0byBwcm92aWRlIHRoZSBhZGRyZXNzIHNwYWNlIGFzIGFuIGF0dHJpYnV0ZeKA
piB0aG91Z2ggbWFpbnRhaW5pbmcgdGhlIGxpbmsgd2l0aCB0aGUgcGFnZSB0aGF0IGhhcyBiZWVu
IHRodXMgZXZhbHVhdGVkIHZpYSB0aGUgSU9NTVUgdHJhbnNsYXRpb24gbWF5YmUsIGl0IHdvdWxk
IHNlZW0sIGNoYWxsZW5naW5nLg0KDQpDaGVlcnMNCk1hcmsuDQoNCg0KDQo+IA0KPiBXZSBjYW4g
aGF2ZSBhIGNvbnZlcnNhdGlvbiBhYm91dCB3aGVyZSB0aGlzIGxvb2t1cCBoYXBwZW5zLCBhbmQg
d2hldGhlciBvciBub3QgcGFydGljdWxhcg0KPiBmdW5jdGlvbnMgc2hvdWxkIGJlIHBhc3NlZCBh
IENQVVN0YXRlLCBidXQgYWRkaW5nIEFkZHJlc3NTcGFjZSB0byBmdWxsIHRsYiBpcyByZWR1bmRh
bnQuDQo+IA0KPiANCj4gcn4NCg0K

