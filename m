Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0712F1125851
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0MOA-00025m-55; Wed, 11 Mar 2026 12:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1w0MO7-00024f-Az
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:26:24 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1w0MNz-0004Cp-LP
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:26:19 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62BFxa5I1379583; Wed, 11 Mar 2026 09:26:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=FkTABDem0I/g5B2ZBTqMqct6n/QRniPpkIQsferBv
 9U=; b=peog6JmGg2gPgg0R0H28aLNcrgOfUF9PUFCDVitqAc6ZHYaDfm07eUwFJ
 hejrM6WL2e2pHG28zW1Pl90WYU0U4Z+W1Cs2+9HH6YiG64nXGk3JWR14yKlJpeL9
 r3wogST7S4PTMQxGkKEwY0xd+5dqZEdRgEi8QCZNBsi88t0Zy69sAnLFsPTPupcC
 mw7euyll4L8j85IJmnxa+2er9QniOG6RC76SW2FRxTDSKc61o5kBmfWjzJ8Ydhnu
 7Iwmnb3Wh6P18Xu+PNaaDRpsh07proNScW1EUt9Fab7VKYVSpz/3e91SbVw2AWPS
 EIZAw3b3btpkgvpekMQzbhg6Sr8Eg==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022137.outbound.protection.outlook.com
 [40.107.200.137])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ctu64adsf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 11 Mar 2026 09:26:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCJ9wZkykFu28WzpZxJC9N0PM/0KjR6ZKuQWtxZGbTowAF3gRomYV2Bw/8EhcrG6UJVyQNn/FniSdno3t+6stymZ71SSI3ElIKyoTGOIvGdnzfHpsNCQPQuUix/VtsBOzi8mKIHBqipHRWCQ4v4OHyGs1JmvSfAMH3TQfJS/wU8TSHzp5RE2BmOjZEOzlzY8065bPwa+P89cNXVokVGvzI56SmJv9rLnAl6eKznvwrLORhQPOUprBvYkSyignKc6VIM16RQGh54VAkN7PJpHyGzRGxF8LJQbi6PDO4qP4jV0Pkf2NqcTfup1Mw6uA54e5HWMS+rkOcgkiyXSajRREA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkTABDem0I/g5B2ZBTqMqct6n/QRniPpkIQsferBv9U=;
 b=uJoR8dELCda1A1Mo1Wb+4jI+PuZTcmVsbl0uPW5Wqig30wAosFh1MlK+4ft1KNA+gfqUGeck9V4KkqyDdeIBjQj4iHVlW3WgCX9rTB8KiZTAJ0xIlGAQdFIesiJBOuWa45ZL94JJJAUbb0IbTlQtgfHrSYDsSgNPdktaQptBDs3KYq5DGAJeZ73RItol2bKYRtMw2AnzmK6bBEp8Z6Th/KobVP2QkbBI44W9yjFN/5twKqDbc/AJGu/ymDgXUL3k1WdYxwyoBJvMdWZpldajnjGczZj6xYIR01ElmHZiq2wJ5JODO+K+DEboAJ9gMcwp1Y7hXJdVknJYvlsuJ4zgnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkTABDem0I/g5B2ZBTqMqct6n/QRniPpkIQsferBv9U=;
 b=y9OOwKumD7seLIKiaT+KVhsnkZHZTIOKogekQ5V+IkB7ZNskG+90+23Nz0bZxsWGCIjrueJEeGR1Rs5QAIwhNdz/LR0iJkAgPAFLF8qx6BVOmRLpGigRVCAqWpXiZckyQ8js8HYFV2WcCWxJgyY8tIj6Xhu6BPchUz9RsMXJj4RXLcs2jwzmppcVTBIgrzs7U49OvirG9YrNG/zNscAEmcVGIioAoPmtz5cuVGc+79rRMPu0cf6DFJqkptfsS+JqUSuqFihiKc9XSC8pzixBGr8oWMURHT6X77RdTBfvSg79Dif9HWKWooHH/2wwZ9m1fJXuXSHg2++lbsm5eCvlyA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by LV0PR02MB11111.namprd02.prod.outlook.com (2603:10b6:408:334::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 16:26:11 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 16:26:11 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] hw/acpi/aml-build.c: add aml_irq() representing the
 3-byte IRQ descriptor
Date: Wed, 11 Mar 2026 16:24:26 +0000
Message-ID: <20260311162605.2976339-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311162605.2976339-1-mark.caveayland@nutanix.com>
References: <20260311162605.2976339-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR19CA0002.namprd19.prod.outlook.com
 (2603:10b6:610:4d::12) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|LV0PR02MB11111:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa9bddc-092f-45c7-6ad4-08de7f8ae874
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 6mnxotWX92m9BGjkHYtSa66hEf5fpFu5/b8xzhHbMetT0VuwlqD/jBmRVQET1ix4jJ85XXXQIsa5iBzWboRB/mwx0qa+OstJmX24VIqx7W5KNVRElCTe43HKIgotISBC7nrQRML8V9yvcNyU2MtAXYiO16UrlTpmnlT4DI8pYF/ZB1JkFGQ4nl5D7SDUlP9Iu8mgCdMk4u+TczZPv+zfKaRIgPeBZUvtmZAgZE6uwyVM90yO7f2ZlWuvEpTbjH1h9gVLzi3MBMRC0g8y6Oq3oLOPVmmGsjkH1Sk5x9trl2kNdU4BTBsPq730a8X7LfFrVi3YNdlWl82BOL9ZI2CwoB3Xn5q10RJiH5DrfTanA8C5I1ao0cIaLind0g9VouNqKTD2RQXsGJBU0XxaTuXIW2l+i3pvDrmmqm+lbD8kviohgVPYYiSFRU7KwsORJToRhRmEEYKP1rEHghWmkHI9m+RM+InNNDst4jvPQAvp8bfAU0zwKuPQSvxtngkvmjyLJdH+qj2T1HHTIShUtUUvwTx2kMwaMJnw76oKQvBj6Jz8bzO4/eiMD75rpIeSqjdvh2EIx5QL8659txwzeqcUV1vR3a/SzoNlCaEbpxTw2Bpr1gIbB6Geul2c9EI7bhm8iyA3YDniLXr29LnD5zyiJ0oGVmLYV/NpFWY3uN6DhTlSxPSS15zV2wP0JT+WqNaYC0Krg31PRiDnAZ7KraUGPPB7XzIJmIlSxJxugCsvYKA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yi0W9NuynjeeYH0rKnDIoEByb+URySE/0m0XorLfLYDrCrBaYeMt5Q3xXDqc?=
 =?us-ascii?Q?ifTQTr9PJ6pszX3V2fzIPvGHo7UmOkK/pqau3pNYpK/FV62f4wT0Brs2swS/?=
 =?us-ascii?Q?yqk2aW+wQTXDOu0YpOTh4KL+wq6jC0umcwxNKJJqD78wCAB9FBBFPRFAODbM?=
 =?us-ascii?Q?4iliDdIpWScrYZqwEAlTS/mv9hjb41bf9o/bEx3MNTVd9E4ia1yjYvN2sp+z?=
 =?us-ascii?Q?7iBWkrotKiRFG3vPyjuYP1Dl46LSVOCEKBjPpba2yfSHr5UdF6WCdH3JpfZl?=
 =?us-ascii?Q?cZidxSNHE+ZDS/Pny9lp5BJqGVfLOu9Fyoci4sfFAXSielt7Fvtoc880uC2W?=
 =?us-ascii?Q?DMLIs1Y7O95CWIK/ZJTvErBsKqlVXlxOy6q6LRgWA5HNPd012kHX8vptZRS5?=
 =?us-ascii?Q?IzRyljiD5Tten3xTLHQLPYzCuejuxpMrfKzJXJgt9NkZORvYc9FXA4eFX1wn?=
 =?us-ascii?Q?tBJWRZNg4YMbkZ/2vuFhpYN4dG5qn/2/3xX2nSmIU/5w7WrmX0wt/Q10UEXS?=
 =?us-ascii?Q?F8om6IkIyvLlqfY/FVcR4/u9amd72RViV+T0xILJWzrSCIUJR68bNEon/XGp?=
 =?us-ascii?Q?osMMR3orUz1Y6VOtR0GrdWcu5S0Kl1uVdxvAtAfVicXPalFC6feIVzUbVc9m?=
 =?us-ascii?Q?slhjqcoR2KXFNE61DiUxyK/n7S8wZe4AvibAeqEkf6nAq7LnnL54DOPXmJv4?=
 =?us-ascii?Q?1oeI3Y0cQuWIkXQDBtqqPlLFabH35RBqB/M3DP1AoUkYibmEkzpRe8gyfUOc?=
 =?us-ascii?Q?iFUwn5n1Unw+bdaguCBC0xQulpJiimlRGIJ7/rbKmHzsT0ZtgiHwj3G5H9sN?=
 =?us-ascii?Q?+x/3UgmjPVFZGS36IBlLb9352QGwfstV/kGPgY8mxlB3ZbKAoKIz6dqSYtdA?=
 =?us-ascii?Q?RZ8jVtkn0DkOL1reLhB6dG0+HSiiYwcl6k69sCK/W7u43Nb8X96nCp5HdfxH?=
 =?us-ascii?Q?DmQGo6m0iifdY/kISV0s7mSrs5IrodUjPxMs5NtB33/mHUbssHkZt8Y65r6j?=
 =?us-ascii?Q?TQuPVRx8xxRW9juvw8dhr9tt2obwKx7TOHJwuUxKjNKDiNGUbr6VzQlOfQmj?=
 =?us-ascii?Q?Cua0aS5FL6Uz7w29mPlUA2+cDklSEwlCOzQ19Y+WBVJVl69eWRrOz8h0oxqV?=
 =?us-ascii?Q?dtwDMpCpz2VnA9bez11JW4DU6ilXdjHISmcs7jJApP/vIrxTZrPaFRc+DPSr?=
 =?us-ascii?Q?ASVaT9YcJETYCcEzjsWcK2YjLnWNJBPSjWE9E29B+8JuJ5xMBaM5DG+IK8bF?=
 =?us-ascii?Q?0IP2tsRHn6SjtZfrwyfoafMoNzEGRNsBe9Wb933mbSip8Y2DiLI2EvyM/SgB?=
 =?us-ascii?Q?Z2SWXN5/lRsG9TllF69Xivb6UsCUVD1SN8D3XA4z5SDnOZAdRNXC6h33Yhbh?=
 =?us-ascii?Q?2c/mmlNRIJ8rVCf4iBc034Zp06D0qccxhZH9DpuDZJERAaLKGkW7q99bScQ7?=
 =?us-ascii?Q?/n+1O0xl4+pp6ht3Y4YXkjs7DKpxCLQlYzLhWGcHAUyDDjL3Zov9Nx2n62og?=
 =?us-ascii?Q?Dliw3AlTg+QzipBDMIpDGNyuP0IewjRrpODRkxu2qb6Zn3bZqbepTqnZgtYQ?=
 =?us-ascii?Q?7I4oLFcJIqYKdfH6DsuzhgDxUc89KPIRpJ9WwMYyv9uO28KfYVFd/FctaTlm?=
 =?us-ascii?Q?v9/qOQ+pEzo8uXmutxL56x6bBinIJP/+xixMrQDvyID/x8AoLHBtqlFP7BCG?=
 =?us-ascii?Q?jnUAlQx32bCoEIs+BDGMauJekcraMy/zFoKpIHfHXQ2S0P8bZwBkUybuM6bK?=
 =?us-ascii?Q?5tzjnoX4pec9wIgvMecycDzUqhxVnZY=3D?=
X-Exchange-RoutingPolicyChecked: RKbOvvZYXigQjTUu71ESaJNSjqrA72HemDtFi5c4bYMEcN4tOODk9JWt42W/OjLbvQDGmagKzUot0cYK6/wn5KjQaGGHP3vtvVB3QE3RN6eYVz9hmr2Crrkx0MZFIttPTJeRDd7LQfyjTVsunqpQSypAsuyTb88j3RSsOMPqwO4q7btEJDTK3G8lOFAzwypbI+JBHenJ4nhZZ3ZSRPGS2lQQJGqjxoBFYg4G0uKiD4OPMWhSW2+jgMfBH697kroYhnCJmU2HAHRKYuzptMsPd5Yb1I8hcTviTv0OmVyk7bBVwVMyDvQRA4qM+KWFnQV+lfW3+MOcUxoKcSz+bsCbig==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa9bddc-092f-45c7-6ad4-08de7f8ae874
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 16:26:11.6965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87NObV3ajVMp4XgfBzOsv6L5+jl5WM/gsEaUBiJvdO8WF6bx59rguLFfLETq6YJs6DwJGdWrZ/9xA2u1ay93vfoHuUP+bL1jhgG1uqo/vOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR02MB11111
X-Proofpoint-ORIG-GUID: 8fZqXGKmAYtv_-kWVZII4Y0PI2aMHmen
X-Proofpoint-GUID: 8fZqXGKmAYtv_-kWVZII4Y0PI2aMHmen
X-Authority-Analysis: v=2.4 cv=ULfQ3Sfy c=1 sm=1 tr=0 ts=69b197a5 cx=c_pps
 a=fuE/7uQEd4exF76fV1vK5g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=1yB3SYwDT-OpB6Fa3bIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEzOSBTYWx0ZWRfX3LwJYPeMKaP0
 uEPXiOAiAUOHES4n0PU/FzW1K6UbpHJZH2iwUn20x+g+2KStKZVgHqMCrDf6Mli3qfHN7ZvRyrr
 hg2xO7zqquA9dK2ep6c0aocxAt7u6AG1z+uxt3iISlACOq9WKjoCQKrt2X41c5K0tMcang9kgSJ
 TIqYH4Fsio89xB6OaD6/GM0AmeSQaamPvMc9o10upg5S53fBHgyd3wSyL8IRjJKi1a0Xxa8yEge
 MNRuuWbTSISanaFmGbdl7IBdV8jIOgl9aHzftF7v58qFaFL1pEGKZ+hCj9NZjPIEdNYeu/oXwBv
 tixbahlmMyVcdO4d4p58u+YsgaR17bM0mEGjCI0idBPFUlt0RIdV8QodBb8SXXzegByx26+sWor
 YlMeQrev+WXB0HWGMxLyXX1YxmSRAjDgv16NfJtxr9XZBSi3uhfv06aUdgJl1V7Kxu50+bUs/p7
 kY5BkHsJrGqpvhTax1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The existing aml_interrupt() uses the Extended Interrupt Descriptor to store
the interrupt information, however newer Windows will only parse the
standard IRQ Descriptor when enumerating ISA serial ports.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/acpi/aml-build.h |  2 ++
 hw/acpi/aml-build-stub.c    |  6 ++++++
 hw/acpi/aml-build.c         | 25 +++++++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index f38e129719..3394253b9e 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -342,6 +342,8 @@ Aml *aml_io(AmlIODecode dec, uint16_t min_base, uint16_t max_base,
 Aml *aml_operation_region(const char *name, AmlRegionSpace rs,
                           Aml *offset, uint32_t len);
 Aml *aml_irq_no_flags(uint8_t irq);
+Aml *aml_irq(uint8_t irq, AmlLevelAndEdge level_and_edge,
+             AmlActiveHighAndLow high_and_low, AmlShared shared);
 Aml *aml_named_field(const char *name, unsigned length);
 Aml *aml_reserved_field(unsigned length);
 Aml *aml_local(int num);
diff --git a/hw/acpi/aml-build-stub.c b/hw/acpi/aml-build-stub.c
index 89a8fec4af..3180c7c962 100644
--- a/hw/acpi/aml-build-stub.c
+++ b/hw/acpi/aml-build-stub.c
@@ -67,6 +67,12 @@ Aml *aml_irq_no_flags(uint8_t irq)
     return NULL;
 }
 
+Aml *aml_irq(uint8_t irq, AmlLevelAndEdge level_and_edge,
+             AmlActiveHighAndLow high_and_low, AmlShared shared)
+{
+    return NULL;
+}
+
 Aml *aml_interrupt(AmlConsumerAndProducer con_and_pro,
                    AmlLevelAndEdge level_and_edge,
                    AmlActiveHighAndLow high_and_low, AmlShared shared,
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 4b37405088..760e814edc 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1060,6 +1060,31 @@ Aml *aml_irq_no_flags(uint8_t irq)
     return var;
 }
 
+/*
+ * ACPI 1.0b: 6.4.2.1.1 ASL Macro for IRQ Descriptor
+ *
+ * More verbose description at:
+ * ACPI 5.0: 19.5.63 IRQ (Interrupt Resource Descriptor Macro)
+ *           6.4.2.1 IRQ Descriptor
+ */
+Aml *aml_irq(uint8_t irq, AmlLevelAndEdge level_and_edge,
+             AmlActiveHighAndLow high_and_low, AmlShared shared)
+{
+    uint16_t irq_mask;
+    Aml *var = aml_alloc();
+    uint8_t irq_flags = level_and_edge | (high_and_low << 3) |
+                        (shared << 4);
+
+    assert(irq < 16);
+    build_append_byte(var->buf, 0x23); /* IRQ descriptor 3 byte form */
+
+    irq_mask = 1U << irq;
+    build_append_byte(var->buf, irq_mask & 0xFF); /* IRQ mask bits[7:0] */
+    build_append_byte(var->buf, irq_mask >> 8); /* IRQ mask bits[15:8] */
+    build_append_byte(var->buf, irq_flags); /* IRQ flags */
+    return var;
+}
+
 /* ACPI 1.0b: 16.2.5.4 Type 2 Opcodes Encoding: DefLNot */
 Aml *aml_lnot(Aml *arg)
 {
-- 
2.43.0


