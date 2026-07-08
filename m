Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E88C44501
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 09:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whOWa-0000U8-9r; Wed, 08 Jul 2026 05:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1whOWQ-0000SU-EU; Wed, 08 Jul 2026 05:24:52 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1whOWN-0001JJ-Fu; Wed, 08 Jul 2026 05:24:49 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66888FNC756792; Wed, 8 Jul 2026 02:24:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=w6iYjzOiXXB3ERkGU0mdXTZ0rXsRX7RST2wbgNf1G
 8Y=; b=F36zDJ0lpSU/uvRHB3Bi/OJiOrNlHtGl52mFU574JKWi10eKMW24I4vtN
 NeAPO3tnxOOB45Go387itg4HwAtaI8v5y7vjBsP/ir6X5NIshBNgZdQGWyqpwxC8
 dqh7zW2OuFFMHR+43spKcjJbHcv+6a7vMIWdB2WPkS3Je7P2g4VDrQSe1c1nNjcg
 GwPql+coe1Ht7lJMnoCZzMIVxO301K8rQkr7eBkLjfMeJAbiry4UzxdzPDkMxVAE
 NYPQYf69zUPohxJYgbvCdy143i7l4myi6tT7jclh85NHoX09zqOwQ0y+KFvjUL4e
 dkHWaj1YppcxAsRcGRp4N1IPwMMjQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021103.outbound.protection.outlook.com [52.101.52.103])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4f9674a11c-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 02:24:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHI+n6GLRC0Df1IYQHXnhHtYyr0Xk6aTE9XWzrgtw0UT+G1g2L3VKpnBfbE3trpMgBxboz7H+K6OtxtmOIQdlYghYHpalcbSQk0CPOkYItFq7GING2EyXuVNQ0Nz1jBJaA0FH+Pdss6HShzL5z6jCoTcl304I2FNF0lh+DsYTp77iXuD79bir3LAroe/QbBrybyO0vJwxfrkyM/pwfhMO7WdcBeDkUSOfg7wWhDeswtExOjkFCdwP13XKVe1tb9Q9bJEat9IgfiI3Ex43piz9OYljELVL/bqSO7xTfa7zkJkvFq1GPGAVc77NBV1+SjhuM0TIdc3fYfo05lZDyj70Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6iYjzOiXXB3ERkGU0mdXTZ0rXsRX7RST2wbgNf1G8Y=;
 b=YJ66kf2avlvfgrDfofE3/4EhFNgBoFwkPl//6ktfMIdog5wUZhZzXrIEnkSLKbD0J1nBdHR9cOS+lHc5o598wwdnAeHFDMKDtMvOHWB13CyBHcv0I63x10PZc/3+ivroOmy8OoRKcegruki1hs6TQCC5mtlHaMw+ThPKSUG6w09PKO/3JRyPh3So8sBZCJYU8OQRfq29fRIcF4HK5gHj6LCW/86uBPu5+n8SM8kIo8/JVjV5xNUdBJxIowrK/DHhneal55urj4s8t3IQvzqDVrxct8h2SnTahRWLbbOYd29KMTd+PYjU52t6IsZgbniFBNKr/kyiDEHglAU4g6jEjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6iYjzOiXXB3ERkGU0mdXTZ0rXsRX7RST2wbgNf1G8Y=;
 b=CM2CWNENtjXl7VYQAHIhl0QeeFjXL/mf1ubyeL+EC2r+3W6MsSdmxT3XNbRcr7pSgcsFFsqgrL+b6Fn9yUHJcsptWhY+2sxNa+j5uOKf6Vm0qYTHqTMXSkwKtmLQ+emOuocEBz6DhpyJXjG840wUYCekEravtCjHlI6qjhI5HEWKlsiMPgtN/Ky1rC9MXd1ui87Wx3m+P97pHjWEtlKsWiF6GiQzezlm9vr85Z/Dh6dTPi3pUGDx1D2IeBpe+emYLfyM2LiRDQFPp8snLPO1ROTgCtn9aUUI21ZZ/cFkJbvKtndCBrRTPxDn/YFFANdxAr0baDSpS6gfM432IEbBOA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL3PR02MB7875.namprd02.prod.outlook.com (2603:10b6:208:33e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Wed, 8 Jul
 2026 09:24:25 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0181.014; Wed, 8 Jul 2026
 09:24:25 +0000
Message-ID: <9d808449-20ca-45b1-9d85-e33d4ae31741@nutanix.com>
Date: Wed, 8 Jul 2026 10:24:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] qom/object.c: rename
 object_class_property_uint*_ptr() to object_class_static_property_uint*_ptr()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 philmd@mailo.com, aurelien@aurel32.net, pbonzini@redhat.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
 <20260703135512.3213964-2-mark.caveayland@nutanix.com>
 <akzrbOKbBwZAKK8D@redhat.com>
 <40fcfa42-ff8a-49a7-bc69-6a3c2ae03e38@nutanix.com>
 <CAFEAcA_kvoyrUUUL=1b6xd6=aO-XKvkhmMyrmd33d0OwSGHkQQ@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAFEAcA_kvoyrUUUL=1b6xd6=aO-XKvkhmMyrmd33d0OwSGHkQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: IA1P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::9) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL3PR02MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: 398e8e50-d53d-446e-f6c8-08dedcd2b3cc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|22082099003|18002099003|56012099006|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info: wxS0xPWdHQZVbRZYoGcn5xXcD/vzt4KDDKVT8iK5zkO4/qmnBHnSn7FGJyCi/WXqQd/zM5II8t8+jThoqzzR1kMfkh/jWyVGOFOsblmYX5fLAWg797jBzjoIMi3nAKJ2bXW/C4f8o1p4shqs69+heKZDi80BxM40+invw2JRTL2QI/bsI0gmEWE5uIFBlYalL117GeSoWVfERnn6/KEjqaz4STOGeJsBRoC+4iamR0UFjur3ZCFl6wGpO3soI6Yieu6k6VS+zbJHZ+bZq3pzXQUh2jRXoKmz0gElHakVNYOq8R0H7a7h9lCg2Gsbr3ytDwVp4GuBEuX0+nm0VOkQnHMmuxO3rfo/rd6XemYScQ6/RyytTVQxZkR5u9Dv6cW3/Bni8XMEZmOuo2nuGzJ1wKxtuHThpc8Ub7pQYrzbdWu1LMar4iJ7tOZbhq+xS53i7RKTwB8qDRe9rynR/clUtnKpv1aYo3kL58DddoZ4P+txKK8Aruxjiq1yxsWcM4fVdvbIWEoNmCRgoNocj2xteR7cmv8mlCuWK6wDWQXa1FY4xTnocVewOxfotKyvonnvAzPMuEdxPRdHGghx5g1X7jKGyulKb591+sTBjvDYsAbwgtU76FbrZx9NYJ4xkL+NGmuzEAuQIyCnBLk/p447EXT7zdfryfsPVOxweZcpy20=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(56012099006)(4143699003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2hrbzBlcG4vSS9SOFNIaG5ZRytuWXQ2clBCYUFyM1ZZRUo5VEtTSURaRlgz?=
 =?utf-8?B?YXNQMTN1T0hWcmZ0V3R2SWxzMFJENnZVVVVkZ1lOTlQ0Y3NBS0ZyR21ndVQ4?=
 =?utf-8?B?VnhVMW5OcHRzTHlqcU0zSTlmYlJQT0dyU2tSK3FHZGpKbStuZURnV2MvYVJJ?=
 =?utf-8?B?UHgxU3VnU1JueGQ5VmNFTEg2MUFPa1hsY3lYKytzQ2pTeWNSR3hiTzE1c0oz?=
 =?utf-8?B?dGdQZjNKUWxhY2hoWnNDVFZBZjZ4R2didGFRZnlablhydjA3MDZsaDV5NVJt?=
 =?utf-8?B?VFcyVFV1Y2JrWTQ1eFNSd0drZEs5VFdOdUMrUlcyUW1pOC84YUN4a1VuVnBx?=
 =?utf-8?B?M1lMRlgzZURJRHdVckNabTQxaFVHNWlhNnhLVWc4MUh4QUxXbUladnFqa0x4?=
 =?utf-8?B?WUQzc09SRXlGUVA0UC9ZWnVWL2UzRDkvM2RwVWU2L2JRVUFQbWpTa1dzR09U?=
 =?utf-8?B?cVBsSk43TE10RXNIbFgxZzJ1UDM0UmZUOUtRMGNqM3k1TFhSU1JJeE9TOHox?=
 =?utf-8?B?T3ZNclRHVnZlaTVtbUMrN1huejh3V092MFczU0Y0c1p4c1FZcXhNMkxvckky?=
 =?utf-8?B?MFRNbFNaOC9zaXg4WkxsSUtRRm5Yb014K0w5cGREYXBqcXFPTUFCQmJEanN0?=
 =?utf-8?B?TXcveXNZVi8vZjY3amtpV0Z4d0ZXWmRTMGY3Q3pnclNEaXByMDYvTmdETFIv?=
 =?utf-8?B?UlhTNXdYY3IvdTE1N0NIVFlLN0dKNXRjUThqSnhQOUlRaE9MWTlGRGtUT2Q1?=
 =?utf-8?B?TnJNQlNYM3BoZmpBSUp3dGUyNlVuZWNqT3JNTncvak4vejhIckVZckx3ekRm?=
 =?utf-8?B?dEQ3aU95ZlJSanVtdkhrNm13OGRYNXd5dmVMUVRCdDZLY3FCQ0hDRFlITHVT?=
 =?utf-8?B?TTlTclBhekkwRTEzd3FXVTQvUzJmYittVzcwWjVYODhoaHJVU2w1d0dOV21i?=
 =?utf-8?B?dU1iMTdiNzliOWE0d3g1TlJhc1Fyc2hLak41RUpSTGhTZTVkY25LVG5oQm5w?=
 =?utf-8?B?em5qUVFVbDR2QXVjRTNobnpOUU5GazNMTjl6ZGxtL2p6djhqYy9kc1IzbStM?=
 =?utf-8?B?dkZqMTQvMzU3V0N5Q080UEE4Y24yeDZRaVhDSFZMc1hiZ3RFSGFDSTc2RS9v?=
 =?utf-8?B?N2NLZTZIRHBlMFdacDEyeUlSa2ZDRFl4V0ZNdTZDSWUzL0VwL0xxWkpQdi9G?=
 =?utf-8?B?eENtWURUa2NRcTY4dlhkVDBycGc2anJnRmdnZVRnUUFEcDNnT2JsbDRpWFow?=
 =?utf-8?B?UzRuWHZTU0FYRHF5WDNJRTFZQVJ4bC9SclJBS0hweEQ3N3NRd09UWmluOW1G?=
 =?utf-8?B?NzVxQktTTFJtUXdNWXdhRURWdlAyREEycXRLZVYycmJrWjZTQ1E2Qll0clVz?=
 =?utf-8?B?YlR2dDBNQUxmT0JWK0RhaUdxZVFiT3BNNHU2YkJlYjNWcTU3eklvdGVobmlU?=
 =?utf-8?B?REtHa0d1V0t4VXVrWTRJNCs5K09FWU1mckxNQXpEZ2xCT0NrR0R5RTE0TFdU?=
 =?utf-8?B?K2Q4TkpzNUtaM3FFdmUxVkZJUXpPOExzM3NqZHRYTVM0eDBJditZTnhGMERF?=
 =?utf-8?B?Z01USkhpYWN5THZHemVGREZ5VXY5bFo5bVNoSGE5b2RQNzlpbUlReGRQVW9N?=
 =?utf-8?B?allKQzhsTmR2OXZaRkxESXNwUHhTZythZXN6VVlxU1hSVU10MlVOeEJCTjFE?=
 =?utf-8?B?Zm0rbTdvVUNwTVNzRDBCS3NWbitFbDRiNEt5L0tSRy84MGtVNXRqN01GWnlw?=
 =?utf-8?B?OXEwT0Y2WjE2M3BTZmZyWGk1NnE0Z3RTcnFZcThuOWhaZEJnMWhWM3F0S0VU?=
 =?utf-8?B?ZzF4eHZTdXF5TFhJV2lmMWVobWlDMjNpczVRS0p3RTlrQlpZMXdFSDR6VGYz?=
 =?utf-8?B?RjdmVGJwV3BlNXI5UHhYSjgzRE9EaGM1KzVObHhCSnNzWmFtMUV1alNzd3NN?=
 =?utf-8?B?RHBLTmdTc0xENFlqYmxrRlJiUDllN0pNRU1DS2N0Vm9Ma3lqNjJCR1BzL0JR?=
 =?utf-8?B?c0xDL2dwUWtuYzAxYlY2TzhlVW5OSVNCT1daSGRBRFRGYkpOQytIVVdwQkVZ?=
 =?utf-8?B?YXhyZWxVNEZKdVRGL0lhSW5taTd4MWFMc0lVQ21xajMyWTQ4clFmNDFKR2pI?=
 =?utf-8?B?aUhEK1EvV2VXMFRXL0MxNFI5S0dPYnFVU2RHSnE1Ny9Md3M5MmZaOUUwZnFv?=
 =?utf-8?B?S1ZYR0gvSnhnS2hKd3dTVzcxUFJnZlNwOGtnSjA3M0pLVk9jTjdzQ2xSRkla?=
 =?utf-8?B?eklub0xDeWkrSFdBNnVSVktrcDBjelVsUTN4NGhqVjlDVHJadCs4bHkzbWtJ?=
 =?utf-8?B?NzBGdGRuVEU1dnNrcFlDZG1CNVo2MjBwVlNaNldudWw2NnpnV3FDNmtxaDMr?=
 =?utf-8?Q?SjhmbvxehdadLPBQ=3D?=
X-Exchange-RoutingPolicyChecked: kOfNvfWNKt+iJ1x0IXwSpOjzFnjWSNmxuBJrZgUTLZyM21DGYLliWhlEB3lJ2NYXomseFnUGzrG/RtZV0Ev6DgejgbKW9DyfCAazt13oYsvccjepuBS9Y9W8lHDzgojDM8SgXeJp98kEHiFAn+VP0qx2vEC9QX0Mb0KebbYxAIt9hkpTB3rMwsN3Df+5Lw9xY+j1qJY4v/Dw6IoTx3JGOlhOTg6BZdsH+kTWGM6Ez+B8mMilSBXiRw4Zr9A0nEEubc9g5GO27kfMBkDODgtDH/4F9tBUjugeHuV81EvaEiqP1sW4xQWsi9eVEJ7ZPIv8behCBzQi+ledW8vNqsvBmw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 398e8e50-d53d-446e-f6c8-08dedcd2b3cc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 09:24:25.4511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K38tVz0LQ1WnVkOq+weg9TPD5ThUuQq/KFWRB5645sKGcWQE9XHuW+zCrp+0WWr7HUxB/4w8kf9STZI0qUzasIbVI0qR0ln6pFs1qCUykvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7875
X-Proofpoint-ORIG-GUID: d5hUgRPjg27voF3YwYLadjetnFe3Z3NB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA5MCBTYWx0ZWRfX0W/PsAzHylxu
 ZrdOjKDpp6XLWYpU//13fEdepHujh9JlVaVx4BqhgcTL4wbH11Ih86TdwE/Jo9PI0OyEkrGBY9e
 SsV7JDGkSEc1T3ZlOll1s1FlbWNSpimOaqqMKVSCu+nnN7K4A1aPcmHsdlNLvzvqM2H8HumetAL
 xaEUpg8z99YYyitVxfzCdVfaz1DuXA5bxjWy3VBgGdzW0gsQytaSi8MrVN/KXCEHSWASgWwfgDY
 CC+u8U+QOPIFwad+LmmVB8Bxe1n+Y7/jjNW73JHSdu5W/AuITD0qQWNGXqXRZWmRDlI3orfTseu
 apFx52lhMwlnpxaMn9K279k4aHZKSMczjHaXTB9CIFcSVY+ex1O6txch+/bluE2mTO0IZBAAgyn
 exOPHBXM9IdYK1fPgbZ/DTM++s/P9aqNA70pNdS3/1f9CUXiGWqiwmp6XS03aOZ50tNCWOd/fFg
 uD3Z/Kvg0mq7EnZCxlg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA5MCBTYWx0ZWRfX8uJ8g46Dgvma
 MNssKIZHEBhHODz0MAVVLALISqlJm9URIg40SKPZxdubpHPpVFIg8qqnr/7Wl/HLFOQR/A1uMXX
 Em8Mb35NUPBBG0tu6oMi8Nytfb4YCvM=
X-Proofpoint-GUID: d5hUgRPjg27voF3YwYLadjetnFe3Z3NB
X-Authority-Analysis: v=2.4 cv=fIgJG5ae c=1 sm=1 tr=0 ts=6a4e174d cx=c_pps
 a=yD2eIpN93qk0sgAC8tXY5g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=tZsU35MwjIHnEiXsHhUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
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

On 07/07/2026 15:19, Peter Maydell wrote:

> On Tue, 7 Jul 2026 at 14:08, Mark Cave-Ayland
> <mark.caveayland@nutanix.com> wrote:
>>
>> On 07/07/2026 13:05, Daniel P. Berrangé wrote:
>>
>>> On Fri, Jul 03, 2026 at 02:53:03PM +0100, Mark Cave-Ayland wrote:
>>> I wonder why "line_size" isn't merely a field in the machine class ?
>>> External code ought to be able to fetch the current machine and read
>>> a line_size struct field, surely ?
>>
>> It certainly looks odd from here: one of things I wanted to discuss on
>> the call was how to approach the conversion.
>>
>> My current thinking is that the aim should be simply to convert
>> everything as-is, and avoid attempting any refactorings or converting to
>> a device class prop via device_class_set_props() if possible.
> 
> Oh yeah, I was going to ask how device_class_set_props() fits in here.
> That is a much nicer API for the cases where it fits. I would like
> any QOM-level API for setting up class properties to be as easy
> and convenient to use as that is for the basic "there is a property
> and it just sets a field in the object structure" common case.
> (Obviously the more oddball stuff will need finer control.)

Having a look at these series, I think we can come up with some basic 
rules as to whether an object property could be promoted to a static 
Property:

- The QOM object in question must inherit from TYPE_DEVICE

- The getter and setter must only set/retrieve the value with no
   additional logic/constraints included

- The object property in question must not be a QOM array element i.e.
   a name of the form "foo[N]"

- The object property must be declared with OBJ_PROP_FLAG_READWRITE

- The object property must be defined directly in an QOM init()
   function, or a static function called from it

Does that seem reasonable?


ATB,

Mark.


