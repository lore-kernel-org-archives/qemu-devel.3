Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E4AC61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyrSA-00049X-5H; Tue, 25 Aug 2026 09:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRv-0003vZ-QV; Tue, 25 Aug 2026 09:44:26 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRt-0002YW-Jn; Tue, 25 Aug 2026 09:44:23 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PB0xln1800507; Tue, 25 Aug 2026 06:44:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=CM1e3AllDlVnMtjksIIUAKoBPlumVcsd6OwNdqu30
 CE=; b=16t/L1y02McirQB1wt5Ok9ea8ALgWzoA92Ma6ivU5zLtE1o3rXgae2TBj
 4fqn6GbhUAfbTg1BvCCqJEIzxkiUT+ZQNirEg56e+Dd6Kc3pKbXaY8Vqh0bhaxQv
 yEXtBJQqtGTgaO20NHtWueDkzpRYquXTweLGaX+1C/0A/mQpbc+7uH0UeFqXzUDH
 jLdalt/U1F8XsX0gW043UC5TBG9t78hW0lT8tXZVppPzJokr/pIwgTN0o2enthGA
 xckiUPDXwFQnegZoJ0U5YPEZJp9oiXUgtRq7T+B8XV81vxBhxVB8dAVCfMQxJJMy
 Vpz7947w9idtlEC9liFum/3+EOaNg==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021086.outbound.protection.outlook.com [52.101.62.86])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g8sy9afgq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 06:44:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fy8pnhCbuREEbTrnXe6pHJETo0Pk1/IpFvpnrAxp+af+OVtgw4+dJ66iXKmhraL/JIxqLQcwd9yqUUFVZLjjmON98CbqoMXij4OazMR4AJq8vdluKOt/lFe+bDEeX0mTIhAQydwG199+Vfgo31Y4M8Wxi3nDY3zxEAu0GNvY1s93zV1dbQ9UjUbQMavGdhHicWtazTnuqjgRuFZoreyqcJMgQpivrANSuk6XwA5Ku67RdrVfzpAB9+5T/Wb/K8xoq39AgSYrVsyLmGjTRvEO3GzQ8r58/9aWQ85oyckkUROfIVgVrblHn29r0kFvfwu7Lnac6tW+QgplRD4N2inq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CM1e3AllDlVnMtjksIIUAKoBPlumVcsd6OwNdqu30CE=;
 b=gzlaaxfB57rvAwv58IpWl9YrMx/Hb1n59AthHRyTarPw4gFMoNdnyxVq1PJzcWW+ZxnlTzxU3c4k9E4l/Q0u0C4JeEfjJpIkCG6fYdNMv+UtVCSz32BrREYpxaJa/PqcWNvwx4oRforAnj/ajxYyj8yfiHFaO8N24q2giLQiuNVzKR+yEupQZzuSAOxeShIu3urRLEuNUH3DuhhU1lgliLvjfVQl15GwP8S8qCYY/9DK4SgvvoGW5255TLcuRaBjjHP3XMcen2lSICr92BSjzirSkd0yvQLAbZxaxwrfuG56FlfKvqoPkVW/8O5o2A7KCzJ4R9Ywv23mtdVBkpDdsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CM1e3AllDlVnMtjksIIUAKoBPlumVcsd6OwNdqu30CE=;
 b=NnPpAZEfQNPQMT3c3QOy7tTbB9XwgbbQaimSg6s3ppR8yT3R0JITCAb1G1DG+qtgq08zAN8ynvLOFVVkmhqzAURQRJb1ExMtjRlo8CIuUKxX0Mbfl2I59qXJd4Ece2Pdzx/XR5LFGPcgQe5XuTwwX7jCS8eK+k16QE4D82PtA453AJSi+twEV1i1cnG5J8zsmw0Pgl9mNoDFqr44y3+n7ayR8dsZmPYsyl/5p0Q/B4OplzLD7pIrVlziaZ+MNfSouEKcrNvwW+K2QydI0jvLwuhJbClF97Ll//WpjKx/9rS6UyPa2q7fanJdJ4YbIBUpzuvMtRHdXAd9E23yPyPpww==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB7557.namprd02.prod.outlook.com (2603:10b6:510:54::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 13:44:07 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 13:44:07 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v5 14/16] hw/acpi/pcihp.c: convert ACPI_PCIHP_PROP_BSEL from
 object prop to class prop
Date: Tue, 25 Aug 2026 14:41:35 +0100
Message-ID: <20260825134320.1039012-15-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
References: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0170.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::25) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: d7ef10e8-93c6-4f74-38fd-08df02aeef04
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|22082099003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info: Frf0YGSNsDRe1mbmidswHCkA7c5nBeSV87v7a/6uZSLTLBirnU9hFxkFfQIyI3rqwhzb2d7Sqt+NUw0ad8X9wHaLRxVorDwzHRPZ34HMLnkzzZBNP6xL7gA3qFkfjVq1FbliJM56I0R0GV8H5XQz3M41/D8zu8K409Y7J7+6g0UlYQXKTJl9vNwy0BPlj2Kr14xC3Bm5yivhZuDpXQDVUg/BJgIrP6xAFUlsCJJogS6I7tTkVFj0t0zngogubARgAOBxGJAS/LNGrHyme3Qa0DR5I8HYcXKDJIYbjyrasMkYxis6jOSwwyrn8Nhx/fVE1gC2/XgBen/1amRkoRva/5bnCz3nZuf4dGdjfp6tyNuYXmKTW2bYiiFZzOVvNLzfga5LmZhA88/byp0Q+H7EfuN4B61tN77zxjLuedggF57PEfIoV1D2falG0t4hIAqirRvyQlgKhFTouLCKkaFZ3Fpjz7bXCQKDaGBdJTP2OZxQU1QjLPRch+hvPZ5Hwcm+2cHD/mHE/isoYsCE5xm1uUT26bUZ0ThFZJ8k5s+0EjTlwPxLRJatIyGSMA3vmmmkXOquPH/L8ygZFy9Bf5OTKMJqo7rQ1284WMy2fx9zflMzFcfoORpCydIMMn+QPIBt9t4lpU/luTSPgtjTtfRlWUuNY/VGX8eSRTCZ2EaQybm0w1hoyatn4F1E6/+ef4SQK6xF4Vrm0RhRwoIYIogiGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TllSSUZ2dU13YTlEdnhZZlQxeWJXWWxLQmJiZ2V4elpoWlRuSVA0eGtiUHdk?=
 =?utf-8?B?ak5teEhrMXRmVmtpZForVmN1ZmxMSldnWmErRjBvbUxPV2Z1NUhhbWUxa2xx?=
 =?utf-8?B?MFFNUVNVU3NIc2NsNW1JNS9TSTE0cG50RmtsL3AwNzlQb3ZFUzBVRGovVVRB?=
 =?utf-8?B?djZkaUdZVFNKbUlkc05YbjIyYUxGamFKdU4zdU4waFF0ZjhsT2E2MUFjcEhR?=
 =?utf-8?B?SG9kTnIwekNqNnNFTnU2NlE1c01nOXJ3N3l3dWJWc0pjNWZFT3FMYWl5SVNI?=
 =?utf-8?B?WnZ2OW5nU205Sm9NNzBNeWhHdGlFUDBFdmNSdFI2OUlRREV3aFJ0d21QSVdY?=
 =?utf-8?B?SlFiaVh2TzZ1Vi9nbGd5bmozdHdtRHk1WEs2ZXdqWmswZ3BNK09yazlWcG4y?=
 =?utf-8?B?Nmc5Z3NiZzZrOGwxeGZXVHA3YXNsZElyUlNVUWV1d0xPK3FkVy9zR3hBMDF5?=
 =?utf-8?B?YWxuTW83eVFBSkszQzdSRnpCRTBxWjJyNUNyTzNucytVREc0V2l5ZkVjbko2?=
 =?utf-8?B?VUxEUk9VQlgxNUxRYmRtTjRYZ0pnODhhckNUSDYxSEplaXB2bHJLU3RUS2RR?=
 =?utf-8?B?bkphNkhZam9NaXlTSnJNekFiSkh4STZPNHBxRjFNUWZGNGc0VjUrQ1Y4cnN0?=
 =?utf-8?B?UkdnRlk5QUd5L214dEdTZ044Yis0NzNMcWYyZHFTOTU4Q2c4dXZFQ2FWN1hK?=
 =?utf-8?B?clVJY0xjZCtZUnF5a3dnZmpFNnUwNEZkZmRPQTRVWER4VXRkOXRwTkVGaitT?=
 =?utf-8?B?SS9YTXRJNGVmajhHWCs4UTVyQ3o2c0VQWXZLa29KUVdnZ0xMcTUyZEkxY1JP?=
 =?utf-8?B?SzkxbzFoREhuM0xUMlUvSmJLaEdpTU5xYTAwT3ZEQmpKcHBKNjlVOWk3d1Rl?=
 =?utf-8?B?aDBWVmZWUmFNeG9DT09zeEJKazZmV2Njdmp4VE5mZWNHcFE3R0M3Mk1sYWdt?=
 =?utf-8?B?MEVlQUhrczlaTEo1MEd6dmtDVnh4c0dFWXZuTTBRc1M1M0ZOQ3lCcDBESjdo?=
 =?utf-8?B?N3pTaDY3aXV1VXl2VUlLZHNTY0pZUG5mblNQMlpOVk9ZRGRvT3lqbWc1VDJi?=
 =?utf-8?B?dG54Qk4ycm9sa3VLcStmVTNVQUVxL21hNUh1bW0yNzE3Q3NzRmdhN2JyVlFp?=
 =?utf-8?B?ZFQxVVF3SGNySVdFaERhcytibzc5QndsRjIzVWduK3VrajFGK2JEZ1lXT0x3?=
 =?utf-8?B?M3NmbXNqc1VaWEphTFVLaUc0dVcyZUMrUEpFNzYvYmVjN1U3Vy83dXErYVM5?=
 =?utf-8?B?WlRnQW1yVHh4c01UaFBVZUdSTko0VGVwRnhBeFhDU09GNXY4WlNIYmoxWXJQ?=
 =?utf-8?B?dHdZZWd5cFlCdjBXR0NTRHY5Mnh4YjhaRHlIZ1VsYWxMSCt3ZDNkUnpBVHdW?=
 =?utf-8?B?VEE0S3B3TXdMWGpVK1lMWU1RZzlqQjBjNy9WMHNFdkIrSzZMVXNsNFVZRjNM?=
 =?utf-8?B?YmczNE44Tjhpck9MWFV0bCtYL2Q4MlFMWWVnSTlCbHNsdStPMTVlbEx4TGxw?=
 =?utf-8?B?RUxJZWZTYjhROXVPMCsyYVVxaGRCVzBwaW8zaEl3TUp2RVh5VVlxUXNHMkp0?=
 =?utf-8?B?T29BdVBhWmdSaDVxQ0h4cUoxYUdqVXlCeUx5Y1FlRFM5L09lU0ltTnlsL290?=
 =?utf-8?B?cDRGandieUdJTmdaR1pGTTA5VGw2ZzlGdHZqQm5aV1JwZEZyTlA0aFdTY0tp?=
 =?utf-8?B?bjRySWc0ZUZiNGx0ckE3TDMrSTJkU3lqT3lMVFYvRGJQdjBUcFZuQXU5YXp6?=
 =?utf-8?B?RlJnSjBnZDBva2JUeFRBQXRaY1lFSjZpbkR2WVk0enRici8vWmIwOFBOcjYr?=
 =?utf-8?B?YTlIeXhld1ZDMng3NlpneTB1RE5yZXczbFJramYyN1dGZUVha0ZDNFhCVGVC?=
 =?utf-8?B?NVNTRGxhSWsrS1RSUUMzc3lKZUJabVRTK295N0REcFVDTUFhbHRzazRFMkl0?=
 =?utf-8?B?VGtvN24yWkRXN2FCbjVsNWJwMEFXb0tGSjFiVW1ZWTVsNlJNVVNxMmM4eXNm?=
 =?utf-8?B?b2srZ0hnWGVVM1BxVEQ5ZXNtVHp3eVdyUithNjlqS2ZsUncyaDlpZmRNanJC?=
 =?utf-8?B?MVB4S2FqLy9XWDJIQnI0U1BuZEtSbDZxR3RPb1UveklDV2tVcUJWRGd3MDA5?=
 =?utf-8?B?ZFhMOVRIWVlUS0NNUjRvWUIvbk9yUW5DeU41b1JsVVVtWFdqaVYzbXBwNmpo?=
 =?utf-8?B?YXQzcHExTUVvajBuUDlJaFQyMTBCcEVnTlFPU0xveGgvTC90WGNoQ0tFNFpm?=
 =?utf-8?B?bDFEa3NMWDdpc2FyajZHeVRZbGNSd0d6YXZldEVJQlFPQjU4M21iSDhGQmd1?=
 =?utf-8?B?K2NGQXhtemVtK01FTXNtdXhUNE5vckhYUHNQUXBKZVBKYlJRdWYwNVJSTFoz?=
 =?utf-8?Q?/9egYhzHn59jcZk4=3D?=
X-Exchange-RoutingPolicyChecked: WabTDa/LDziG474YCG4CsOSl9xj1i8DwG30w5Xx5AiYpe5z5F5L1X+eDax2BEN0Ik+WEiP4h8ieIrrYzwOHj2VjUfojCeatqEBhm5978D11H6Lmr1tOkm395BixeRcsWsbH85BwKRK8WJNS3tE0d1ukBiPCNuZ/gl12kM+8WLGgTrIGMax/dSYGkal9m716jMly7jchDQpnQIZbE7ZSrS0ylmoLgId2e7AKDaWIp2l+FLCBEGksFlwut6NqFwe1fZ+i5B3FxV35p1A8wpp3TQgekLNXp76wm7Xl/53ix7wTshks9Afl6ErEaUdrE+FeDnTwNaHU/bsqvQa8tjq6vjA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ef10e8-93c6-4f74-38fd-08df02aeef04
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 13:44:06.9413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5XB+WKh/uAp38Y4wJQKYb/j8H2/Bj+j3d7M1vIwXyZ895DsFmlaNzTyIGyNbzE3D/TkSwc6CvrB4A2o5e2g2SGGwY/p1z8xbXBdEcu1yaog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7557
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfX+KTuMDXNNMo6
 3aRKX8Tg7lI5TMNUqjnDmu28BsbMotlBGKdsx+Dzo3N696jepfNmRWvfdiWk+WeALCRzrAlQtnM
 yLAIlDzyIwsAE5mxy5rDPbNNrcsoF1Z3CEqj5vBr0blbDvlEkmTL5VkQiNbt3zIo4hV/boM5c+0
 4YLozt82PyqJelqIKI5K1ukQRd+WWRBiAajac6jDGWPqf/J/ckp9QmwmUX2St4/bz4LH48SHArZ
 VVdR6D8EGPRLqGJ/TtPDskGMCf6ispabouYHHwbrisRwDQ+AdTXY2t6m94Eho+72CTLXLPvbwep
 akWnVNc9y/tujX5YFUnuIqkaJyTmBtG0lrfjubTzLvsPsAKd/Ta97wUC2UnkqsNk8pfZMkmqzbJ
 A3vwHs4s+S4BWOD6n3vS2or7TnnHJKykh0kTO0rIr2NjuDFhrjH2dh8Ilf02I07iEZnzarfmSfr
 CqCBcgWBmIZ7z2mgPZw==
X-Proofpoint-GUID: 9QGSRKUumBBAI9q--ciyxb2jqeRSEbdn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfXwyU0WjxcZFJn
 z1dusRKUeJLUkhkIUVWsklFs2ondDcYSSfh76crNC9Euoux04YijMp/XErsXxirTGPdGbOcU2k5
 wEz8ik+hMT8BkmHAnhdpFgiJLXf8GD4=
X-Authority-Analysis: v=2.4 cv=W9AIkxWk c=1 sm=1 tr=0 ts=6a8d9c28 cx=c_pps
 a=8tnDOA8lvRtpcZOACi+KGg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=Yyzug1Ypeymz-iOESlgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9QGSRKUumBBAI9q--ciyxb2jqeRSEbdn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
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

Move the ACPI_PCIHP_PROP_BSEL property to the PCIBus object and update all
callers accordingly.

Since the existing logic checks for the existence of the ACPI_PCIHP_PROP_BSEL
property to enable the relevant ACPI changes, set the type of the underlying
variable to uint32_t with a default value of UINT32_MAX indicating that the
property has not been set.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/hw/pci/pci_bus.h |  2 ++
 hw/acpi/pci-bridge.c     |  9 ++++++++-
 hw/acpi/pcihp.c          | 30 ++++++++++++++----------------
 hw/arm/virt-acpi-build.c |  5 ++++-
 hw/i386/acpi-build.c     |  5 ++++-
 hw/pci/pci.c             |  7 +++++++
 6 files changed, 39 insertions(+), 19 deletions(-)

diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
index c738446788..7ecb23d13c 100644
--- a/include/hw/pci/pci_bus.h
+++ b/include/hw/pci/pci_bus.h
@@ -56,6 +56,8 @@ struct PCIBus {
     int *irq_count;
 
     Notifier machine_done;
+
+    uint32_t acpi_pcihp_bsel_val;
 };
 
 static inline bool pci_bus_is_cxl(PCIBus *bus)
diff --git a/hw/acpi/pci-bridge.c b/hw/acpi/pci-bridge.c
index 394a919479..1bfc5431f2 100644
--- a/hw/acpi/pci-bridge.c
+++ b/hw/acpi/pci-bridge.c
@@ -23,6 +23,8 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope)
 
     if (!DEVICE(br)->hotplugged) {
         PCIBus *sec_bus = pci_bridge_get_sec_bus(br);
+        Error *local_err = NULL;
+        uint32_t bsel;
 
         build_append_pci_bus_devices(scope, sec_bus);
 
@@ -30,9 +32,14 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope)
          * generate hotplug slots descriptors if
          * bridge has ACPI PCI hotplug attached,
          */
-        if (object_property_find(OBJECT(sec_bus), ACPI_PCIHP_PROP_BSEL)) {
+        bsel = object_property_get_uint(OBJECT(sec_bus), ACPI_PCIHP_PROP_BSEL,
+                                        &local_err);
+
+        if (local_err == NULL && bsel != UINT32_MAX) {
             build_append_pcihp_slots(scope, sec_bus);
         }
+
+        error_free(local_err);
     }
 }
 
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index a91f523c93..b26ddf0a26 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -58,7 +58,7 @@ typedef struct AcpiPciHpFind {
 static int acpi_pcihp_get_bsel(PCIBus *bus)
 {
     Error *local_err = NULL;
-    uint64_t bsel = object_property_get_uint(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
+    uint32_t bsel = object_property_get_uint(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
                                              &local_err);
 
     if (local_err || bsel >= ACPI_PCIHP_MAX_HOTPLUG_BUS) {
@@ -78,18 +78,14 @@ typedef struct {
 static void *acpi_set_bsel(PCIBus *bus, void *opaque)
 {
     BSELInfo *info = opaque;
-    unsigned *bus_bsel;
     DeviceState *br = bus->qbus.parent;
     bool is_bridge = IS_PCI_BRIDGE(br);
 
     /* hotplugged bridges can't be described in ACPI ignore them */
     if (qbus_is_hotpluggable(BUS(bus))) {
         if (!is_bridge || (!br->hotplugged && info->has_bridge_hotplug)) {
-            bus_bsel = g_malloc(sizeof *bus_bsel);
-
-            *bus_bsel = info->bsel_alloc++;
-            object_property_add_uint32_ptr(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
-                                           bus_bsel, OBJ_PROP_FLAG_READ);
+            object_property_set_uint(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
+                                     info->bsel_alloc++, NULL);
         }
     }
 
@@ -730,14 +726,16 @@ bool build_append_notification_callback(Aml *parent_scope, const PCIBus *bus)
     /* If bus supports hotplug select it and notify about local events */
     bsel = object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BSEL, NULL);
     if (bsel) {
-        uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
-
-        aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
-        aml_append(method, aml_call2("DVNT", aml_name("PCIU"),
-                                     aml_int(1))); /* Device Check */
-        aml_append(method, aml_call2("DVNT", aml_name("PCID"),
-                                     aml_int(3))); /* Eject Request */
-        nr_notifiers++;
+        uint32_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
+
+        if (bsel_val != UINT32_MAX) {
+            aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
+            aml_append(method, aml_call2("DVNT", aml_name("PCIU"),
+                                         aml_int(1))); /* Device Check */
+            aml_append(method, aml_call2("DVNT", aml_name("PCID"),
+                                         aml_int(3))); /* Eject Request */
+            nr_notifiers++;
+        }
     }
 
     /* Notify about child bus events in any case */
@@ -848,7 +846,7 @@ void build_append_pcihp_slots(Aml *parent_scope, PCIBus *bus)
     Aml *dev, *notify_method = NULL, *method;
     QObject *bsel = object_property_get_qobject(OBJECT(bus),
                         ACPI_PCIHP_PROP_BSEL, NULL);
-    uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
+    uint32_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
     qobject_unref(bsel);
 
     aml_append(parent_scope, aml_name_decl("BSEL", aml_int(bsel_val)));
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index f6386088b6..d368913e76 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -1207,6 +1207,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     AcpiTable table = { .sig = "DSDT", .rev = 2, .oem_id = vms->oem_id,
                         .oem_table_id = vms->oem_table_id };
     Aml *pci0_scope;
+    uint32_t bsel;
 
     acpi_table_begin(&table, table_data);
     dsdt = init_aml_allocator();
@@ -1269,7 +1270,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
     aml_append(pci0_scope, build_pci_bridge_edsm());
     build_append_pci_bus_devices(pci0_scope, vms->bus);
-    if (object_property_find(OBJECT(vms->bus), ACPI_PCIHP_PROP_BSEL)) {
+    bsel = object_property_get_uint(OBJECT(vms->bus), ACPI_PCIHP_PROP_BSEL,
+                                    &error_abort);
+    if (bsel != UINT32_MAX) {
         build_append_pcihp_slots(pci0_scope, vms->bus);
     }
 
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 8837b69687..1696821048 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1198,13 +1198,16 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     sb_scope = aml_scope("\\_SB");
     {
         Object *pci_host = acpi_get_i386_pci_host();
+        uint32_t bsel;
 
         if (pci_host) {
             PCIBus *pbus = PCI_HOST_BRIDGE(pci_host)->bus;
             Aml *ascope = aml_scope("PCI0");
             /* Scan all PCI buses. Generate tables to support hotplug. */
             build_append_pci_bus_devices(ascope, pbus);
-            if (object_property_find(OBJECT(pbus), ACPI_PCIHP_PROP_BSEL)) {
+            bsel = object_property_get_uint(OBJECT(pbus), ACPI_PCIHP_PROP_BSEL,
+                                            &error_abort);
+            if (bsel != UINT32_MAX) {
                 build_append_pcihp_slots(ascope, pbus);
             }
             aml_append(sb_scope, ascope);
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index d3191609e2..e8e8a3b767 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
 #include "qemu/units.h"
+#include "hw/acpi/pcihp.h"
 #include "hw/core/irq.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
@@ -187,6 +188,8 @@ static void pci_bus_realize(BusState *qbus, Error **errp)
     bus->machine_done.notify = pcibus_machine_done;
     qemu_add_machine_init_done_notifier(&bus->machine_done);
 
+    bus->acpi_pcihp_bsel_val = UINT32_MAX;
+
     vmstate_register_any(NULL, &vmstate_pcibus, bus);
 }
 
@@ -302,6 +305,10 @@ static void pci_bus_class_init(ObjectClass *klass, const void *data)
     pbc->numa_node = pcibus_numa_node;
 
     fwgc->get_data = pci_bus_fw_cfg_gen_data;
+
+    object_class_property_add_uint32_ptr(klass, ACPI_PCIHP_PROP_BSEL,
+                                         offsetof(PCIBus, acpi_pcihp_bsel_val),
+                                         OBJ_PROP_FLAG_READWRITE);
 }
 
 static const TypeInfo pci_bus_info = {
-- 
2.43.0


