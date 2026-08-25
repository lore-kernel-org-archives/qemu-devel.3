Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4913DC61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wysow-00006A-SI; Tue, 25 Aug 2026 11:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wysou-0008QV-N9
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:12:12 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wysos-0006bf-NP
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:12:12 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PEbjEJ2320315; Tue, 25 Aug 2026 08:12:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=fID8zOoq/N1IwsNe8uQ2SeRwYcGAKmy+aMhOA2c9H
 0Q=; b=x5mZXMnWTc3J2HjUe6P8Ga333c0NvViDmgWicMsSsCjfjPdEeA82Fm3A4
 dwmrRskfUkOdvEcN0xcCN8dvLmG94uIpvTnujFg02AXJOsfXIszcBXloJKSQHt/S
 Y/6IqIxET6vV1HGQdOzHgU0wK/1dobkv/nX/DE9EdEtWsB22pg/JfJEjnaj05N0W
 keBwnaQMyxhw3wXwKIlvT6dLIes7F/CdZmEovhMTSEIzR719UNpouveNqzv21Tz3
 Y//NGYHmpZjmuK6G6TllbjDHBQvoBxgb22VoFSKFDwgejoMTYsfurM9fyjniXZVI
 DgxJzSsAkRAsI2NCdJFDeQJn1VOeQ==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022076.outbound.protection.outlook.com [52.101.53.76])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g7bavenfe-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 08:12:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxpJjkAAV9ksHuydTkFqzA1ENVhSJraBbTcH0ZpU78Cz5Edi+vq9fEsK2Jx9LoRhFnulcR81NADUP4LBH6AZWj6EIseznam+uIl83G129woCEdeTIeZh7kFH8qdEQDp4MZvDv8ksHB3r0Kb1iAbjycYyjbjdGgL0/Q8EEI4tiAxzmsfuOXz5trpVA7jRIZyfA22LlHtf0DgvHvwFtaIELTCAE/r02ps7aC0dZ2QiEZJEsCR4lqq8KZQkO76plVpl+3u2BVfIeqhAuy5TdIYp9lJBS/Zq9dCyiuiJoe1XKm32RqZ2/pJHrFA/iBsY5AMYRJf2fmTrpGeBSBCZlR5eIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fID8zOoq/N1IwsNe8uQ2SeRwYcGAKmy+aMhOA2c9H0Q=;
 b=bWRmo6wqCJl9d40QigLVAsd9dkBHcSJaJg488WX1C32xX0VkguuYk2OjT4eN3L9RbujT2E6Efe+JPXUSFXdAf9R1V0u/+rLkjfMtJUPlwTp84QJ9zK8ML8Gm18HRSKubtZhRj9ZmWrKmFm1Gr00Ke/GmjkVMdhZbe0IUkCaR25Dd9k0K0PCN4DCRoMtAxod/QHkHYHhaRIZ7CVHShW2en3GTGPp6rNgNjv7naMh4I1nxx//DM7amg6rZuUc5ri8zcn5k3EM3g47F2TbFl3JazjqYbFati2xkcxcIhTDq9+n9nidxqDhiu9IASLBKs8vr2tCrncIffYTQYokT0y8rdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fID8zOoq/N1IwsNe8uQ2SeRwYcGAKmy+aMhOA2c9H0Q=;
 b=aOyUSDb/QEB81mVWxVyYMLFKCGAoKj21dRmD2FxA8THvUHL1S6sxswZXl2MvZBjOwIgVHmwsokqeJyBf5m571ED5lAYhaU1Huy4+vIPhm5vPzs45HjSm1112kse2/uWPbqowO4cwQQjHt3mJb/MZNFwJNrm3++PNm5Ogs+Iq64ZAve3eKCiTkmQAhntRRDyeoFyc0LDBEdsA83WNdPLjdFbL2O+W7p/fWvKbKNq3ZbVGHuSI7avdOu/uKQVg4Nugu40gSImjlbUdEkED6xGeNMaCkCeK1QFkMzLOR8Vjdl2uYlZ1EtZ9hI+im9x5sgsfWkjC6DD+Pc2RPPzVI+pNag==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO1PR02MB8855.namprd02.prod.outlook.com (2603:10b6:303:158::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 15:11:58 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 15:11:58 +0000
Message-ID: <6bfe8453-dae0-41ff-b023-050dad6eff8b@nutanix.com>
Date: Tue, 25 Aug 2026 16:11:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 36/74] iothread: fix poll properties typename
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
 <20260818-qom-qapi-v3-36-24b8bbbe3d86@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260818-qom-qapi-v3-36-24b8bbbe3d86@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0061.namprd04.prod.outlook.com
 (2603:10b6:806:121::6) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO1PR02MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: be96fbfc-c358-4676-4dab-08df02bb34ef
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|4143699003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: u2Ih3aa8xMIv+zQ5rGCB3GYPv5+CMsvFLPelo2dVmlg7+PPOEZj+KThB204l9UUy0DhKOhev9SSu94EeYpHTmCP7qP5dAI6C2vELbJO5M36bScZyLuS2fxPaeISOQ64Npj9Yy5zbZ4lLa/uPU5DHf6kExERDNUYGItLkBIHzAn2t8jff4IDN6VOvWVPWfW0G0a3FKMfwKoiVDUK4vp9jhjApJylOlHJ7pSLcOZbp6sPQ+AIoRywm6kvkwpvD8rO9/SfTO9RYlEe9BflfjZkFXrpXRNEewek+lCayPFC4P7TcRv0gJ/ExnvGg/0vN5k+uXKVckbipHQX1ZN3rT9Qt/xpks6x2ZrzO5gNtnxcptMcep7InflaOW83JegREvr1uHIgVKGnjNpUK/TUpzNga3Nst+KAfsuV0Ca//mzb1YI8iu7f1JPUTk16cL+MTxbhFlj151Ivo8OijU/3G1O05n9uEDM9NkKG7iRagn94b3NS8HiMNO/0goHAHhP4+pyiyhxWW3MhjidLFI6jAMxCVPy05UYlFrYcj0hLSfx7EYkgM/0jTQUFD0BqN7WfxLLMOY6dSNuAY+tMCMIdGwUlCSpVC/srWMCo+mspKa5S6MpEgTkIL6viao0VH/BQivEm0r+U+3J8whGF3npkr14yrDlEA5wLb268FK3ujKIavIaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0xCWnY4NVRFR01QVVkyVER5RC8ySmZjM3pUVGZPYVNKR2RPYnBnNHp2NTlJ?=
 =?utf-8?B?MzdGV1c5L1dENlZsQ2ZGRmtzRDhRZHR0bjFVZDc5M0s0eFpWS0RIYldYV0Z4?=
 =?utf-8?B?MHFzeFh1c2pRbDI0c2dXNy9oSU9YSzJ4KzFqN1RxcGM0YmdJZjd2Ukp6OXBw?=
 =?utf-8?B?UERtanYzR2VRcUowRVVsaU5SdWpDUWxXeWNuRkN5SVRZd1NnbDNBMmdUeHFT?=
 =?utf-8?B?amkzK3F4aC91eENXZDlENVhrZXF4RkZOUmJOUFhOOEFkelZJWEZEY0VqTTNN?=
 =?utf-8?B?WWpBVXVmdzRpNEY1K1dpTzdQeS8zUXlrMnFCWHpxWklYaXV5b010QVBaMjhO?=
 =?utf-8?B?VVFNRUZKV0JCVFVodW52U0g3TFlaSE5iV2RvQ1lyRjFoZUZJNTlRQmhGcUtM?=
 =?utf-8?B?cHQ4Rzc2WmFHQTJJd01qaXB4NnhUaTR4U1MyV0dWdkhreUpLaC9BNWtveXBN?=
 =?utf-8?B?VDZETUg3VHhJemhyL0tWVmt3dy9mMHNJY3RNeWlKdmZXYXVrS0IyVVdoZ3FT?=
 =?utf-8?B?L08yQXo4SjFIQnYrbnMyOVhycFNoRklYVGkzcWE1NVlNY25DQmowSmxFZjFZ?=
 =?utf-8?B?ZUlGWXo3SXcrMFVzMVJ5cTNjbVRiWEdTalhlelU4cXA0WWV6UTRyUDNEMEVH?=
 =?utf-8?B?TTRXaDVsLzZrMGppUGdQVndRKzNzQVRzOGNSdnl5eUVabmRaOFdXeTA1N0h2?=
 =?utf-8?B?T3E5RFVWTk40YkdIOExDaDNZUDY5QU9KSXM4QlhHTWpvMERDWE1YTlY1QTV2?=
 =?utf-8?B?NlpualkyOXplS2RPWHk0cHRlQ1RONGZjT3Uxc3dxYXhWNTRwTXcyQ1VVTkxK?=
 =?utf-8?B?QVZKTjlqZ1ZDWVpyUVBWWjZJMDZkaEJRU2N4VERzLzRkOFFqUGhHYkhtMGU3?=
 =?utf-8?B?VU15TkU2dWZiZ1ErdjlYWXdweWFvMmc5dmZnbS82NUNCQUxadko2N0xoVmlk?=
 =?utf-8?B?WXB6d1lhT3g5Yi9pd0k5YXVaOG9HQjNzcEdSZ2RkMWJ4Zm4wcy9GUTF2VWNu?=
 =?utf-8?B?V3cxb1pmcm9rWFJyMjkxekNqNXMxNWR1aC9PS0RXMXhsQjdVNjBkM0RWcFI3?=
 =?utf-8?B?SjBrOW5EczJ1ZFRuWGEzT2RIMUJRUFg5QS83M1Zzc0JSRWFxZ1RKbTFzaDFQ?=
 =?utf-8?B?SmUvVkpwR3YraUkzK1k0VDd5dG1NS0ZWNEFHdSt5Y0MwMTNDUWRreXJnYlpq?=
 =?utf-8?B?OS9RWFhtVUtkRUZEeWNEZnA1MEE3Y0NMdnd3cVh5SkJRZ0c1cHRRVC9YTVly?=
 =?utf-8?B?Z2pYN0EvUFRoK0hLdlYrTTBESmhoMmtGeXhEUU5jeTRCNUhULzFEeDFhN3d1?=
 =?utf-8?B?VUppTks2My85TUZQamswZHQ1RGFKL3Z1cDdKTGNwd2N2dGlVVWErbjAvNDlC?=
 =?utf-8?B?RVd3Mld3d21HMDl2aXNFcW0xSUV4M0ErZXBrSmVDSzNjd0lEa0VJSG0zMFFr?=
 =?utf-8?B?MEdCcEw4ZGVxTlVTZXlwNUpBanZyRlg3RDNvWTh4TWtaTlkxVml6YlFGZ0hl?=
 =?utf-8?B?L1BWOGluQ2xCYzhqbGZadlZ5Qm9PQnFLZ1ozck9PYXUzbUxYSEZOREZWYWk4?=
 =?utf-8?B?V3BNYzJSSklaR1VieEhwMG44MFlWVTA4RlIrcFZQOGRXc2lyQTFsWmFBSHVO?=
 =?utf-8?B?eEEvMTAwaWk4ZUxXZENEaFM1TDIwdU5MWjRBYjhVcjExa0dKalg3T1paUld6?=
 =?utf-8?B?S3FWaVR4YW9MSVhTNzluWnRka1JqakpuRE5GK1FtUmhxSUM4SXNoOXNKSnI3?=
 =?utf-8?B?cXpGTm5kT1hMQW5kNms2dmV2UjVtaTZERENCMnFuNCtVeFF1ejIraVNGKzJs?=
 =?utf-8?B?VTFiUEV4a092M2FXS1pmb1B2M2F6YUFjeXJIeFAvRFRMVWpMZVd5QTJtQ2ZH?=
 =?utf-8?B?QTIrQ3dRRitkUE5vMWlzcE9nZDB6VW14ODFsVUxPRXdnbWFyRnFWQ3JGSmZj?=
 =?utf-8?B?WFdyZnd4YTVGZzZyS3loRURqc3VWekJVYXFoUGl1S3RmTlB3Z3QxYWZJS2l1?=
 =?utf-8?B?c3UrdW1ZWHJsa1FUUWZsWFdFdVJXYklIRUlwM2p3a1NudXF1bjVVMDdrTFlG?=
 =?utf-8?B?OUY5a0hnb2w3Z0JXRGhjalFIUVVqZmFQRGRDS3pNSGlIVnVJbkxIK3psbVlO?=
 =?utf-8?B?SVVLa0EwRE0yTnU1ZUFHL1FZTGFBaHR6dU44OEFkKzRYbHRmTXdVaDdETU1q?=
 =?utf-8?B?UFRyWktjZTh6TXM3MC9sdWluZEFaNjZQbllUOHdWWGIxOS8rUW5mQjJ4NWla?=
 =?utf-8?B?bzlsajVEYXNXWXlMcjhuSFN4aENleGp6ektTY1JtaXlDeDRxZURPZEUxV0My?=
 =?utf-8?B?T1NKUDVxa1M5aW1wUXpSMlBuWHkyaXlIL0NTSTJsWEhySkY4dk9BNEVKWHBP?=
 =?utf-8?Q?W7SOLi/ULfwAoVPQ=3D?=
X-Exchange-RoutingPolicyChecked: ZUfylXH1oGOz1fHaF3hl54YSPgdasDqmBEVyLStGF/msOpCXEACcMza1vNs3HWhCf0syx+j3uD43vkqlPngQ38MFhbMPUwDUobnZqSTIbKoJeTniBTXsds0q1auJW+E6Lau/yl0WN/kyu8RIrQlaQjve7KtYD0GhOwoR9uOBcDBf8Eeo5svHONbaC2k7hz+ME9q16CEiXJOrRxlW5/nNL+xlh3riQeJElSzc9+mg0+p7LJwaagu4VheX3Df9vms/YZnSuuR39VP5Yn4M/iM7gTOLXRTjLsJ2YkZuTVvz2eVEWdvUFdonVbTJ196vuF0qccqH4UgbbJkJ+gpNyQrvXw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be96fbfc-c358-4676-4dab-08df02bb34ef
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 15:11:58.1175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8CAJV4A1ZYQC6jI48RDUnJya3+ovBIX8YPkGsnoOpvbmNC/58vQ0TNAHnTnfWP0VIlRecjMcTahPyLm37hf9QWDa0km/6JjWHcrBY22YV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8855
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEyOSBTYWx0ZWRfX4ebQefnRUfwN
 N3TDS3ttKvy2h/bGDzHxYScNqSNSl5SdIzF6VtaJ8jPV14k45bNq2kiqkMyaWLV3p19GhPfRuzq
 TFnUQzYLrLWKACss4flYPzF0kl52y1U=
X-Authority-Analysis: v=2.4 cv=aJvAb79m c=1 sm=1 tr=0 ts=6a8db0c2 cx=c_pps
 a=6LX95kau/ZuHJnH6QujO1g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=_BW-VI6-JU7XRo9WEPIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: c3FA1-NHIiNgGABZz1cBKn9pXJVSy58E
X-Proofpoint-ORIG-GUID: c3FA1-NHIiNgGABZz1cBKn9pXJVSy58E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEyOSBTYWx0ZWRfX6me2Y6JVDGbT
 5OnUiZTOBbuMWnACP3Pn/aJ0qNdmN50lYf0rOT5uQA8u6n2SUcDpdNjCgEuB3rI/ZetlZ9Nm0c2
 mvQ50mKJKxrss6swy4bzbe0Lb/N8hgzcARSvRGotOxgNi2GRrhhPVtzLIqLypcU9DBDrnvi7zyb
 EiigFQinLr5evTRiF81QWYoB2LuGnSr4bFGkGfANvMy/yRf3f/bt3DD2rHQxO18JWbl6zFrcZyx
 /8bTn3KADwiyTD/aZm1dy9RWslMH8N/u5duXaOfk+FLzQXSgNuB6razk4Ae/Fm3aNHjMUBgKeKP
 HASAhf9THP7tUGyQYaifVAKnZjwtiex+qeNyIB0GlCAz84bvNgZQbcqOB/IoHXa5iJrjhJPwg+X
 kpUt9F2dhTYrLq7OM67WfFE18EO66cvnZuy1WxNf9GhN9f3IHUIUbkC7PtubrNqzdPS/K9mXqkA
 JJxn9pQbT3YYFJUEHrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
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

On 18/08/2026 12:11, Marc-André Lureau wrote:

> The getter and setter use visit_type_int64, not visit_type_int.
> 
> Fixes: 0d9d86fb4df4 ("iothread: add polling parameters")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   iothread.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/iothread.c b/iothread.c
> index 3558535b40f5..76eea6df3861 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -315,19 +315,19 @@ static void iothread_class_init(ObjectClass *klass, const void *class_data)
>       bc->init = iothread_init;
>       bc->update_params = iothread_set_aio_context_params;
>   
> -    object_class_property_add(klass, "poll-max-ns", "int",
> +    object_class_property_add(klass, "poll-max-ns", "int64",
>                                 iothread_get_poll_param,
>                                 iothread_set_poll_param,
>                                 NULL, &poll_max_ns_info);
> -    object_class_property_add(klass, "poll-grow", "int",
> +    object_class_property_add(klass, "poll-grow", "int64",
>                                 iothread_get_poll_param,
>                                 iothread_set_poll_param,
>                                 NULL, &poll_grow_info);
> -    object_class_property_add(klass, "poll-shrink", "int",
> +    object_class_property_add(klass, "poll-shrink", "int64",
>                                 iothread_get_poll_param,
>                                 iothread_set_poll_param,
>                                 NULL, &poll_shrink_info);
> -    object_class_property_add(klass, "poll-weight", "int",
> +    object_class_property_add(klass, "poll-weight", "int64",
>                                 iothread_get_poll_param,
>                                 iothread_set_poll_param,
>                                 NULL, &poll_weight_info);

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


