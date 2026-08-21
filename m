Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04224C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxNES-0006eo-FS; Fri, 21 Aug 2026 07:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNEQ-0006dA-Gf; Fri, 21 Aug 2026 07:16:18 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNEO-0002Bn-2j; Fri, 21 Aug 2026 07:16:18 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L9NUo41903094; Fri, 21 Aug 2026 04:15:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=uIZEil2v5vMG+
 YHNZ+gxeP4jnvNbjqDoaVbE5Rcr0rw=; b=BTNqh7p3lVMMx08+Qiq0Wx8IwQQ75
 PPGOXEkY5Gy9T8dmDxYOyWwjDIW6c+tz4yjaGdd6CNUn1TsBbNhKBXA7QgOlAFWe
 Yw37u8+6SucKM0T3FXlOi0tSpASMwgCTM9xreC7nex7eQcyB+PvXf3NmVTDGjEx2
 NrW0/NOM82mKguPFN3HGi3uOVdazlzebw8lzT2KnMWMM6jW+/Xz2b+SIzijQJSeM
 2SPDOporC1p/5Diw+ncPmyJwyfpTgEipy/+Q8n+YyS3tU0EQkk2qbO47Z+KqstyS
 JwmiCsIvUM+PaTCZgsC/t0skcIds2rc9lVpCmHuwGaYEIsyDNyjwQrl9g==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020086.outbound.protection.outlook.com [52.101.85.86])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g6cm1s0sc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 04:15:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5PIRt2abD6nIwRcGq3+mg07XhNyZrB9Fs5fZLwzJk8OTioQ+nlE883lIgWCiqzLqX2w4wJNvgIjqzSOrB3K2zce0cZU8Gi6jE0M6VzBrh/iFozdq6H+SZ1NVXsl7Ng1lXfBsGyj+a5IvYqUz3Er1UbXTRM5HVeWyzPISoy29Km81tEMfY+lO8zDMqiBWvL/mHLsKdQrUj5VgQqE2943kXVR5d/Xfp7Nq0UWBkAszlR6jGfwqnaqt3fJiwKCRru3m2+Ke5wKd1RNT0kjW2fmZuJVkhGNXs2lkddOT0eaxBXOdrIpQDOgAHfv2QbdoruKaYz8d7WWziYH6qaMBQlKRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIZEil2v5vMG+YHNZ+gxeP4jnvNbjqDoaVbE5Rcr0rw=;
 b=DoMNazQjI8qw6baUjoffk0t/4OOQFj4FPPkNBZzq88AG8ycrOq//I0MmQ4CFjM5rjZYIvaHbxmqPpiRkueOwdz62THfLTYk3SC04X0JJ+S7pbEOlM5SmMQ8ux4O3GuZp/Xy862c/Ciry4P3UFq4diCi0Q4k6C/AlqjMSaeNTjWkoIMPOi5I8LMvE9/O0+MjpmO7oYnPPtQ9QCtZdI+1TEWzrsDimq+v8Hp4d85pNmFkdJPbrw4yKVUDWHXZ6dgnQ2UawdbdgBJMw0uRj9XiujTicTc1pYb/hK0TPrKMAbThC1A1UxE8+WQedE2y1M/QdmCngKalYbj2QXytQYbDb8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIZEil2v5vMG+YHNZ+gxeP4jnvNbjqDoaVbE5Rcr0rw=;
 b=EP9xEBknJjPlXB84XyAKAPPQuoNzuHw0294N1ZFykZC02sGyKz2ftu3UvU3czwsNhHPr1olL8yG105FgNmedkb3T+3RzYjLpCga1W9YavWR1eAsQimh3K0aHyloIyNaFuDblZbLW5f8BrqkkNDexxV+EcZqgGq7jZYeqKZ0qruAV4v4oJCSxpKuT5run6EXnSE7MoRlsk/D/knjXOIkRa5eb7ZR2U6Yb7zf7y09AtmXG9PVskj7bLEVcAJmUn78cU8QA88gfK95N5Ne29vvk78Ukcj1ucGLsnAM2JhN4JXGNrWvivBdZyPny/M819B+JnSwehGLVTnkzHittCwNDWQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY8PR02MB9524.namprd02.prod.outlook.com (2603:10b6:930:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 11:15:53 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 11:15:53 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v4 00/16] hw/acpi: convert object props to class props
Date: Fri, 21 Aug 2026 12:14:12 +0100
Message-ID: <20260821111550.276011-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0072.namprd11.prod.outlook.com
 (2603:10b6:806:d2::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY8PR02MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: cf06e14f-109b-407e-8f93-08deff759095
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|3023799007|56012099006|18002099003|10067099003|6133799003|921020;
X-Microsoft-Antispam-Message-Info: P/zMb0MBRTPCyKRQJ5MInE07bmK7JoTHiy94ygOTmDdhp6LGNflKeg+6DT5tEIJyn4RhEODgBOQ3/eylET63Iq0ryhTbJQ8PQJOXkyI9HCGrEmbJqx0MpGpwg0P5ldIhldX4FMLtZB8JVbSi5DmpEldxzGHQUUy2TgFVgLpn4H+mUxmTnvw5u5igtXz7dhPKvPKG//LItaU1wApR5PLnFHICw8Nc/QVrXFVuFN0vBeknV45zIzy9oG4RHNjPYHPE6vgA2y+bbzz/2+DXngo5hwjEaI/uZ1SqVIDB+clXcFr4XD7UXHUYqoNsGqKBiB3na+kJHkveJD0K4HZcvvXv0zUtoM/EGbxaKTNbq6+OW61XxfwHDAM1isC0rcqjwXF55NzlETIUKmjr3JXB/PfwTCjfrD7ASfqnqb8JcdAX4U1WJku9s15cxcQO7BD7BS8O3loi7w7aQwj7BMx8rEWV3VRXqXDZJ2ICgFwdHhafZOpawgYg56ixKIFk/q4h5vwi4iHdDyZJbe9zKCdsD/KJ7wl9sU0xJdz8Vwe64lC0/nBr8i77HqHf8MX/3wIvsfB3BcXgxK8W96UV4yF4Qg6TcVdzNj1fFYnhloaiBx6cTaf+XZKqMmjXoPl46A9cf9KTTRINH/K2/5oHNY/BRveCh/K9yUjht9+HK5VbT9dO5nE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(3023799007)(56012099006)(18002099003)(10067099003)(6133799003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmxESXk2ZUp3cHZFb0RNRjJWcWttcjNoZ3JXRXdLSWljRW5BMVMyUlB0bFZU?=
 =?utf-8?B?aHZIL05pVmFHU3E5eW5UQTJKZWY0eC80WUNIZnY3SHBPQTFmUXIzampUNkFs?=
 =?utf-8?B?Y3JDT1BuTkQ2cXFIb0x4djJUK3NWNzFEWElGU2JsR2ppRDk4TTVqeEpxK2t4?=
 =?utf-8?B?SitrNTVTRVd2UlJTbUV3OHFHbm1HaDNuOEVwcDRzaXgyVjdQN0dFdFVXeTNi?=
 =?utf-8?B?TThqWUpRa2NVc1RRNnRUZGlERVpLQXFnMHZLZEpjRDd4YlN3WmpJT1ZKZDRK?=
 =?utf-8?B?ajhmaEZlZ25ibGdJc2F3T3daS2o2ZHB2RjAwU0FTTWpONEJPRkNJcjdYcGhH?=
 =?utf-8?B?VU8zWXg3NGJ4Q0dmcDZoL2RRcm80d3ZRSThMTGI5N3NORzVINGp2QTJZaStG?=
 =?utf-8?B?UTIyZHdmRUpIenFXMlJaVEdmUFE1U0Z6amdMbkZsSFF1YzE3TkdIQ3BBdnV6?=
 =?utf-8?B?SUNWRG12ZnlYZ29ob2VvT2QzTkZNK1k2VGdrTkR0SFdFZnZZOVF3V0prNy80?=
 =?utf-8?B?U091aXlvSzRXOFMyamJsQzVvdUxUTllrTkYvMGZDUXlTbkh1bjRRZDNrdWp5?=
 =?utf-8?B?R0hubTFuc0huRzRudlROSnREajFKSmZnV3I1K2d4VVpMVDJsQjJuNlRoN2E0?=
 =?utf-8?B?eWsyR1ZodFVaQzl6eGN2dlE2T2hVelBxcWg4WkpxWHVSZWZweG9NdGM5QkhJ?=
 =?utf-8?B?VEU0cGlORy9NZjZCajZsczZsaXd3a2pTWGZxUitSWVR2WFJzRjZiaW9VckM5?=
 =?utf-8?B?MnJZbjJYYTh1dCt4K1Fod3VzenhRVzAvSkpyTWoyK2dkU0JaK1Ftck84QlBq?=
 =?utf-8?B?Wko5cDFkbU5ROU9wU1pCTzhiSk50c2h1U3FXSkNIYmxFR1d5WmR2c0dqN2Zz?=
 =?utf-8?B?NzFldnBoM3Q0aTc3anRLSzZTNy8rUjlySkF2b3FsS0ZMQ2ExbkV0ODFZbkd0?=
 =?utf-8?B?Ymd2Q1I0UHJoTjVPWHUweU5mYm96eE1RY1ZMU2t3MHlER0tOZVVsZkc5Nm9S?=
 =?utf-8?B?UzcwMjUzekNKeTFnMHhHTDNMTUp1akhYNkhaaGtmQXpzWXpLWDBMeGV3WTBZ?=
 =?utf-8?B?ZHE5T2JyY00xZEVSaytCNndPU3JZZVBFVkVqWlhDK0RFc3JhTG9RM3J5anRT?=
 =?utf-8?B?eVB4ZzZmRlVmZzY0a1Q5cG01eHJrMklHakVRV1NuM0dvdGQwb1kwMFc3QW1P?=
 =?utf-8?B?c0FIengxT1pZMXR6bEExQ1pHcS9YcU1IUGw3SExDVkNuTTZURWVESUNhL2E1?=
 =?utf-8?B?aWNvb09RR3Z1MUlqak9MNGJTS1lwdk9Wc0E3MlJxZDNneUs5bnRQVFEvR21C?=
 =?utf-8?B?R2hxYzFTZWNKYU5WZU40bEVUUGlqTWJYRlFFNTI4emp1REtjWUJpcjdUbjFz?=
 =?utf-8?B?QVpGQmQ0bjYzZjlVNnZMbjdlM1VqcHdCOXlVWnM4NUxBWUR5ODlpVTg0THhT?=
 =?utf-8?B?czFQWTk5Y3lRei91cktjejQ2aS8yZmFmOUdPSjZaMGhhTHg1ekYvaGJJa3M2?=
 =?utf-8?B?U0NYTFFMZmVicThQYW9zU0FyNEl3aG5EdzBqRjZYb1ZNSUswdmtFVTE4L2VQ?=
 =?utf-8?B?SlZyUDg1d2pUR0hsd3JMRUY4Znd1dGZDdFhGMVVzcWozWTI3dXY3dTF4Ykla?=
 =?utf-8?B?VGgyczUxTkxxZEpqRXVQOUJOeW1YM253NWp2SmVqVFJCUzF3emdDNjBvelVX?=
 =?utf-8?B?TEg4VGt6WmJFcHFtMXJQZ2U0d0UrMWd4Q2JxNWJFbGVsMjdxU3I5TUN5VFlE?=
 =?utf-8?B?eWhCUmdTTjFmcTRkdXJmaUNkU1NuSUtiRTFLRTBGaFNUdXFHTEZMak5qV0JD?=
 =?utf-8?B?ajJOeitlby9RMW5QNHhUd2JGL2JOeFRyN2svdDVtSTJwTTF0ZzNvalI4MlpG?=
 =?utf-8?B?aEgvOURRWjVyVEY5bWRmd1k0d2xraytHWGF6bTEwQjM1T0dyYXhSRmpGREhp?=
 =?utf-8?B?YlhUV3RCYm9WZVp0amRaUXRMamVhQ2ZZTGoyS3ZGaXdjaFo2SDY2cGVCV1lD?=
 =?utf-8?B?ZjVUNHdHMW9wUWpKRVpOOVV4RDhvOWFnVVpOMDNBbGhpNHNIMzRLdjRtY0hC?=
 =?utf-8?B?S0NlbmxsYWdwQmJzSkZGa3Q2b0RJenFkMXFPeUh1R0lFdlB1VlRRUzNNZ29h?=
 =?utf-8?B?YjRxTzk5dndIeVVOTC9rNVFNdFB2Sm82ZGlqaWVaU0J1akN0R25YSVlEbnBK?=
 =?utf-8?B?eGx5dmN1dlBBUzR2Nm5FT1liNGM5ZVZvUjVGM0NncHcvdmNrMk9JOHVUM1M5?=
 =?utf-8?B?SEVFcm5OL004RGFzM1prSWtvYnVRakVYRTFUMndqOFVZbGRSSmZQek9UblI3?=
 =?utf-8?B?VFVpaW45NWg4bGEzaUkvM25iNEl3MUxCN3MyOWduc0Q1WC81ZjNNKzhPdlFr?=
 =?utf-8?Q?JUQ/FCKiJEHrYE/E=3D?=
X-Exchange-RoutingPolicyChecked: fDpWc8WYY8Nn1UgDdEkT2n/f+b/XDUYprvNuvN8vtuXdEpMdpBW8mBUHTKsKLLM1tTwHCzHlZvJzj5QszQgq18eztYQro6RtZaJeQ1KIwhl3D3E7yG3E+LAsCNaIHdLIyomwmnv9twcq1p672G1WMZS1wOoGMhtEE5CjDFLq3McYvXz4WPMWEKfncffcqkHxAvO63XUtEMKgaZvIGwmf/8OnaT8WczVibS5AHRTiES8Nt8vwXloZEgSrr18j2fQGtlHhiDZPxHWyCa41OtkK+PBFkU/J6S/NROILwm/SpLBU+vKS56oN8G60//UjK+Q/Pg7Y3hwQ63a4275eDLm6rA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf06e14f-109b-407e-8f93-08deff759095
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:15:53.8160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YRqZWUvPVYT8UWH+cmR/MUQxKMSz+AheUiTW9+KJI/9p8Q6J/0xLwHzCPEdjmGTO3b5TQloUHyI2215YaK7bWhY3tULZckUqfS/ACwu/oac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9524
X-Proofpoint-GUID: SxxSH96jXYTXoQV2Ae1DkabGhw5rlG8n
X-Authority-Analysis: v=2.4 cv=J/qaKgnS c=1 sm=1 tr=0 ts=6a88336c cx=c_pps
 a=/fqqIPcjRwir4WodI5uPtg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=mDV3o1hIAAAA:8 a=GaQpPoNlAAAA:8 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=yiOi61s0K-w_ntCZxyYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-ORIG-GUID: SxxSH96jXYTXoQV2Ae1DkabGhw5rlG8n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfXwpQ/hL0m0eEU
 Oh/rWCyPDF+EwAn/3acllriLQtD5gEfOYGaY/manvUWcjEWKXfYIPdZLSsNvGj5i9ei1K0cR6va
 3U+DSfU5KOw+tweTG6Ey+fPoRkbiY6+7YB0ZriFzg2UJ3+QnXJNpOMlhmjLNVWx/Q+6dDxWVkKn
 sK76uncxtGQi3Ym9i41afElDZReb4xSGj4M/chA1daES2OxX7zqcZxIpsKXsfpA9NOiA79+KJ75
 uqJpC+NJ3WeEqK+mPhGzwTsiIfFVnDQYwBOc15IbfyAGBsrCAoJ7T2tweY6BkMjFf1TFljnHhMl
 JssIsY0haz7js521d1k7X9U3nU8KUvZeJFjCEJOEWVlP/XE1oTGwT8kqt0/er2Ym8EWLyoBr3X8
 YHRd+9OWbsmJbpz1/e7K3bnr/tHbSXVkongaVOW/dAgti9QTgdCeXEKfLaF67d1HjeUJnyPed+B
 GVmjmGKwIzO3W0MB/XQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX02EvmQKHsLE7
 4iYaV13igpnF0y9uIIw/yJzMAscIxNxRCP5oGNJ4RUDE9px994Vnb+9TKCLmNCg1wT3fIWVm/Tw
 IP2xO2e9ugKtvdyXJBfmTMyKOhVebIs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

[Background: based upon Peter's feedback at
 https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg07717.html I realised
 that what we really need are object_class_property_add_*_ptr() equivalents to
 the existing object_property_add_*_ptr() functions to make it easier to
 convert existing properties.

 There are actually existing functions with these names that are already in use
 but after observation these are really static properties, so these are renamed
 to aid porting object props to class props, as well as making the difference
 clearer.]

[Note: this will have substantial conflicts with Marc-André's series "qom/qdev:
 associate properties with QAPI schema types" at
 https://patchew.org/QEMU/20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com/.]

Since the use of object props is effectively deprecated, here is an attempt
to convert all use of object props in hw/acpi to class props. The eventual
aim is to continue working through the codebase, removing all remaining uses
of object props.

The series is lightly tested: it passes "make check", GitLab CI and some
simple local tests. I'm mostly interested for feedback on the conversion
strategy, and to get a feel for the best way to merge this series since once
the basic conversion patterns are in place, the same patterns can be applied
elsewhere and it would be good to minimise the merge window for such changes.

The following warnings below are generated by checkpatch but are incorrect
since they form part of macro definitions:

1/16 Checking commit 58e8d5fb5971 (qom/object.c: introduce OBJECT_CLASS_PROPERTY_SCALAR_GETTER(type) macro)
ERROR: spaces required around that '*' (ctx:WxB)
#41: FILE: qom/object.c:2720:
+        type##_t value = *(type##_t *)object_class_prop_ptr(obj, \
                                     ^

total: 1 errors, 0 warnings, 28 lines checked

Patch 1/16 has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.

2/15 Checking commit 2068ae0d4ded (qom/object.c: introduce OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type) macro)
ERROR: spaces required around that '*' (ctx:WxV)
#28: FILE: qom/object.c:2730:
+        type##_t *field = (type##_t *)object_class_prop_ptr(obj, \
                  ^

ERROR: spaces required around that '*' (ctx:WxB)
#28: FILE: qom/object.c:2730:
+        type##_t *field = (type##_t *)object_class_prop_ptr(obj, \


Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

(Patches still requiring review: 5, 6)


v4:
- Add R-B tags from Marc-André

- Fix comments mismatch within object_class_property_add_*_ptr() descriptions in
  object.h

- Add patch 5 implementing object_class_property_add_uint64_ptr() now required by
  patch 6

- Don't promote ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP to a Property in patch 6 since it
  must be marked as read-only: use object_class_property_add_uint64_ptr() instead


v3:
- Re-implement the object_class_property_add_*_ptr() get/set functions using
  new OBJECT_CLASS_PROPERTY_SCALAR_GETTER() and
  OBJECT_CLASS_PROPERTY_SCALAR_SETTER() macros, similar as has already been
  done for object properties

- Drop most R-B tags since nearly all patches have changed since v2

- Split conversion of static variables to static class properties into separate
  commits to act as a reference for future conversions

- Drop patch 6 from v2 since that has already been merged separately by Phil

- Use UINT32_MAX to indicate ACPI_PCIHP_PROP_BSEL has not been set in patch 13
  instead of -1. This is because the existing object_property_add_*_ptr()
  functions always use unsigned scalars: let's try and keep this the same for the
  object_class_property_add_*_ptr() functions if possible

- Add a new object_class_property_add_bool_ptr() function rather than using
  object_class_property_add_bool() in patch 10 since it avoids writing explicit
  helpers for each property, and there will likely be other cases in future

- Rebase onto master


v2:
- Add object_class_property_add_*_ptr() functions matching the existing
  object_property_add_*_ptr() functions for class functions

- Rework patch to use new functions instead of manually adding get/set
  functions as part of the conversion

- Ignore existing R-Bs since this approach is quite different to v1

- Rebase onto master


Mark Cave-Ayland (16):
  qom/object.c: introduce OBJECT_CLASS_PROPERTY_SCALAR_GETTER(type)
    macro
  qom/object.c: introduce OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type)
    macro
  qom/object.c: introduce DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS()
    macro
  qom/object.c: add object_class_property_add_uint8_ptr()
  qom/object.c: add object_class_property_add_uint64_ptr()
  hw/isa/lpc_ich9.c: convert ich9_lpc_initfn() object props to class
    props
  hw/acpi/ich9.c: don't pass ICH9LPCPMRegs via opaque for
    ACPI_PM_PROP_GPE0_BLK prop
  qom/object.c: add object_class_property_add_uint32_ptr()
  hw/acpi/ich9.c: convert ACPI_PM_PROP_GPE0_BLK_LEN to a static class
    property
  qom/object.c: add object_class_property_add_bool_ptr()
  hw/acpi/ich9.c: convert object props in ICH9_LPC_DEVICE to class props
  qom/object.c: add object_class_property_add_uint16_ptr()
  hw/acpi/pcihp.c: convert ACPI_PCIHP_IO_BASE_PROP and
    ACPI_PCIHP_IO_BASE_PROP to class props
  hw/acpi/pcihp.c: convert ACPI_PCIHP_PROP_BSEL from object prop to
    class prop
  hw/acpi/piix4.c: convert static variables to static class properties
  hw/acpi/piix4.c: convert ACPI_PM_PROP_PM_IO_BASE to a class prop

 include/hw/acpi/ich9.h         |   2 +-
 include/hw/pci/pci_bus.h       |   2 +
 include/qom/object.h           |  90 +++++++++++++++++
 hw/acpi/generic_event_device.c |  10 ++
 hw/acpi/ich9.c                 | 126 +++++++++++-------------
 hw/acpi/pci-bridge.c           |   9 +-
 hw/acpi/pcihp.c                |  35 +++----
 hw/acpi/piix4.c                |  51 +++++++---
 hw/arm/virt-acpi-build.c       |   7 +-
 hw/i386/acpi-build.c           |   7 +-
 hw/isa/lpc_ich9.c              |  36 ++++---
 hw/pci/pci.c                   |   7 ++
 qom/object.c                   | 171 +++++++++++++++++++++++++++++++++
 13 files changed, 431 insertions(+), 122 deletions(-)

-- 
2.43.0


