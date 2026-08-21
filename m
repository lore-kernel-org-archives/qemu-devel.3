Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C06C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxNFP-00075k-Al; Fri, 21 Aug 2026 07:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNF2-0006si-1r; Fri, 21 Aug 2026 07:17:00 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNF0-0002Jv-90; Fri, 21 Aug 2026 07:16:55 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L9MaKB1940235; Fri, 21 Aug 2026 04:16:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=1hK+3evjbBHDqvxDP3UEaLoDtWr2syD+NMrYiBt2D
 zE=; b=gKfBxR2z3Y/f8LkJa/SgwunaK+gujPHphJNLxyjXKXwNRZwkVpHg4c8+I
 8zpim7eA4jM2NufmnYnW3kacEr08mfCPODdPnWPzWE1ZtHALrIcaYVksP2wjGEZV
 EfPvftmuMY5XjXlbpf7rOaf3rSc6GalE6kcZO1zL3Or611Pr/zcPUj1DdlMPLT66
 a0P6w6Rx/7s3tl7UeMZmR6BSQeYi8qTeDCv24wS2RWW6MUQ3kcIcF/o5YhqzxZgU
 4iN37rOfuDYdh4+5FGh+sIPcpC+Ew4qes71fx67t/QzAC7i0UJvcFIHCT6wKpVxK
 dIjubWxrYvJp8zbGx71X6qQ57i8EA==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022119.outbound.protection.outlook.com [52.101.48.119])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g6jfhrcfy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 04:16:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0termeI3SH7w7PHBMh7v01xgpTmY+dCTL9rHvAKDCOL2zhffBVdLZbs7dh1CdRhFZ486z/u+C1jsiOWo9Zr6Vs1FUQ0KSWK+8cfrC8lUxSpNKZ8CqKEoNvZLgfalphBRWOxKPxpJckVoX+bII68ffwrzQnPK/rUB0cGKzEcEZNyFgr2f9CE5bpPn6OELIDGEkxDf5tXuPiGwNwE1hnvuVrG9Jybi8A0HpmIVtjGEA92E1dSBFOI1k+0I4ZIxBJNfrxRX7vxC/OZPmmC98TVUkdZSfPopY8ECsJBgTDVQj0dx3AvFFnTtVdsYgGyRt+cvNAnqp5I8Dsh5Xg768hzIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hK+3evjbBHDqvxDP3UEaLoDtWr2syD+NMrYiBt2DzE=;
 b=rsy7ztVBikwIb44/YZNDEA1SaYElPSxEAzAm1oy4ikrQH5OR6nY8S5tre61e+zNroGfXeaV7T7AGAljmg641iECmtBurfPxwIMCuJivQmjY5Kl2BiG1B1en+bD7qsFNishM/KFaJYDVmA2mWk4pF5oKsT8oq4w8UUI4jSkKRtkHHznkRpS+8u3KcMnwdLtSfFAcOc3rsjinQOmsQus3QsdDbewq16ufLB42mVLCADoufcivcBoLdbQ3jlzIHPSU0GR4DcWBbobo9la5D8x7AhBAS+9d0gy3rUK5QLvhVI6TA8W43zwWeYI2JdCnBn91aBz742ldEO4pc6E1cS97lDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hK+3evjbBHDqvxDP3UEaLoDtWr2syD+NMrYiBt2DzE=;
 b=efTaiOmUrjK2df0XgMOnn+bGfdoebcv+HpUktfKGfJRJOtqkVyTjsetWLrDW5pt6bJuY4K8iDQLfr4TEPrXoWCXF70pg/GugVc+OZVbnM1nCpF1437/o/4+auzpQyE+9ldz7FsVOjIdQiD9yNeq5fdGhuvrzGSnaJVpGM+DVnjqqCqbS/+z1LBcbRNOOxMuzo6B9gtfSoS2pXVGzG8U5nz7Ja8ggPiyMz9SNXCT+JyTui/5WS0aEaSCuCdQMVWjtX9sL8GOGz+fqqLj0+sRejkIktFpWfP/oxd448LhgrBWs+bPnsgzYGedaTSSOf3mf6i8KUSmfytk5WH5OnipVEw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY8PR02MB9524.namprd02.prod.outlook.com (2603:10b6:930:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 11:16:42 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 11:16:42 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v4 13/16] hw/acpi/pcihp.c: convert ACPI_PCIHP_IO_BASE_PROP and
 ACPI_PCIHP_IO_BASE_PROP to class props
Date: Fri, 21 Aug 2026 12:14:25 +0100
Message-ID: <20260821111550.276011-14-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821111550.276011-1-mark.caveayland@nutanix.com>
References: <20260821111550.276011-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0013.namprd11.prod.outlook.com
 (2603:10b6:806:d3::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY8PR02MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a397a9-6039-49b7-f6f5-08deff75ad84
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|18002099003|10067099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: cKD91XM8rhGJwlrGlB1ORCNz2bGgz7EFqfJmE9IM41qx0UGaFvYzxJ24ZFC4ByzwBbBzoPOw4RoA98b4kjvefLNYGZkZ5zxEy14PMatFI+JZ64yWF5YOP1iZZY2ZJCdSka70RVryApfTjvH7mMHfGf35W+VohpG2817X+oZrrfSDwp0rfSewl/zZfD01m2hlaUzrcKkaQcyGHPAKTFOIqUTJZiBChzdsQwlzKvPxxOGw830QsFQRhX9qFet+hAeQ30A4V7bgFcSqTKihtYHYtCV+ECUZ/u5wzj6epCjentVePFP39ALXImWmlQ8q2ao4Jsip9Sc566zKGXQPZbfsr8n2JTR/7lpi2JzfnpLTwlN90CbLC8VFPIWzp6IxvEfwG+xa+MmPS6ybN39+HcTl+pPhXVU2rgI+WtSzijWwWz4lPmGm2hPyP6z9173HUgAJ4270XWQRXHm/QOBFOBu7BvY537afI+uTA49tdvCPAX8gDv6JPm3GMVlycTxjXUV3cE2aY4icy5pjID91btaqLS/mNXWLTq46fwEOdgrPMFxuK/OPD8dslca1YWm2EslF6AlWzc27GfyiwRpksWu/QjCOG0fqZ5JwWSgUx9kqcESOJ7aNoib6hKmdksrbIQMUOUiF/QniqH79/ovle2YWyofv65uwrdIbU6lQ8VAiN5LKKtwuWGx6TzUtK9ZbMYtZNGcf2CfqWe2jkXw3P/nwvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(18002099003)(10067099003)(22082099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0tCYWQ5YWp0V3lEcmdaN1RFNm03dTgrcUxrV3laalF4ODR2dkNrOEJFYjM1?=
 =?utf-8?B?MSsvVjRXNXZSZ1NYWUp0MmxYMXdrNlpPbUtzYTh0d0x3NWprMXlidE9DNDFG?=
 =?utf-8?B?VzVQc0R3WnVPdU5iNk45REFpdC9pRHRiYTRnZXNFVUIvcWo1V0pkV1I1V2k4?=
 =?utf-8?B?cFFvRXM0OUJOdWY3NHpzSE1Mc1FEM3ptTkxSeTkvMytqRkI0TFBXQ3B5MGs5?=
 =?utf-8?B?M2NCOWtoWXBUNWx4blVrZjY4V1JXYzF4ZmlEcTFTN2EzcXdBOG5vOXFZOW5E?=
 =?utf-8?B?YjN3VHljT1dWUGZia0lpRGpFbkJBRWdzTHdLMDhhK0hDZFNMZGJxZVdIbGFH?=
 =?utf-8?B?TlVBVEVQaFQwSEJPbnQySHBsYVcvMW02V05MU0lrcWE3OFVFQ2VUdEdUYTBr?=
 =?utf-8?B?QU51dzUzY1JBSnNsajFJZm9helF0Q05FTkUxa1UrcWh3OWZBNXAvNVBaWnBi?=
 =?utf-8?B?ZDJEUnNVd0IwcTRxZW9RN3phYURHa0hOdHE3cHJtNDRJVGxKWGlLSlZ0cUFC?=
 =?utf-8?B?R1dhbHZZdzZkL0ZHUnRZNStFallpamsyTVQ4OVNLKzNYTW9vM1JvV3c5UGox?=
 =?utf-8?B?d28xWGdxRStKQ2lYNXd0YU90U2Y3YXRaeTMydzV6cWFaSEI4U25qYy94Y01O?=
 =?utf-8?B?ZjZvQUZWMmNnUTJLdVdBaldpUGlHVXAydnU3N3o2MGpveXlkbTV1Ylg5K3cv?=
 =?utf-8?B?em1iby9ndEZHeGs4d1loRVlEZHhnbzdkaWlPRHQweFJ2VG93RFlLL0owUERD?=
 =?utf-8?B?dHN0bEpiYklQY0dIZi93MkttK2pYekgwWE53STY0d2lCRllIOWF4MHdyODM2?=
 =?utf-8?B?N1poN3ptR2ZOWEZ1SlZiT1pPVm9zbnpBdlEyNXVRZUJ6cDJTZ1RaZUZOVEVw?=
 =?utf-8?B?dzEySzRVRjU5eW9tTVdvajcya2J3dzlIaUFYakE0UkdKOGJUeWcrUVduRE1t?=
 =?utf-8?B?MGE0WXZJRVdzcEp6dFppclpVbzkvdERDL1BtMlMwQ0ZtTjM5cGNuZ0thUFNO?=
 =?utf-8?B?REFqbm5ybE5nVjNXWDRjM1R5czU3TDFSdTh2bDlUMDdtUUJyVXZoTTZKSFov?=
 =?utf-8?B?NHhPQ0JMTWZjdWNuY1VvOStVNHhvU2FDWW8wRDRQWGs0cC9SbFRRTnNWVVZj?=
 =?utf-8?B?eklxNmErUW5PbDFocmhwS0t4TkRIMXdTWVQ5NnZnVUVTbnpmNWpYaDcvWlg5?=
 =?utf-8?B?S3QrS0hNdVExSStRY29EeXBxdzZKRTk2LyttOER0UjRtMXQwa0lQTWJpWGNO?=
 =?utf-8?B?dWI4RC9iNk5udVk1U3BxM0tjMFRsRTRIV00rYitGUnp0U1BHOURVOTIzSTk2?=
 =?utf-8?B?Zkc0WE5hRmFtMG53VHh2T1lQcEErTEhmY1QyeXZJbHcrWXY4S0ZDcWh1Q3BT?=
 =?utf-8?B?UGdRNFBLZHZDd0VlTzhIbUZwSGZCb3lST01WNUFWNWhWNkxJVmF3UFhac1B2?=
 =?utf-8?B?OWlwaGFHWUNEMmxEa2xwaFVlcitvM2paVXBvN2hhOGo1R1FEU0lUZmc2N0Ja?=
 =?utf-8?B?OURRM2VKczlWZG9wRXo2YVEwSit4Z1l6ZTJDcW55YjRoZldDM09YZk51R1ZR?=
 =?utf-8?B?c0lVY1o3bXJHNFArM055RHBjZHhON3l5VklEU2xkZVcvWHVJWmh6bTdGVTds?=
 =?utf-8?B?MVpkdnZvbHlGT3VmZUkwcmpzRWhPYmJpYUdlSi9NdWxja2R4bEs2M2FwbUJU?=
 =?utf-8?B?YUduR0tMZUREYnNaRUhnWGVOaDEzWGdiVWNjZzBLMmF5bHQrNzZKeEFlNjRT?=
 =?utf-8?B?TFc4aSt1R25CTlRYbDVaRU0wSE9PckpiV2pCbWNyVC91R3dlbGtrbjZsYjAx?=
 =?utf-8?B?TEFGS244cHpIOTkvMDBidEVFV3JvdGdmMy9HbS9waHlXaUxGSDhOcTRhWDAr?=
 =?utf-8?B?dlR2Y2F3c0tZR1FEUTVIQ3Exc3NDcFZWZG5WN3EwdHdSTzFaQTRGVzYzYVpw?=
 =?utf-8?B?WHdKNU1tZjhSV3B2bmZ5NkFWVUU0Z05tR0h0bG5nZDl5MzdkTkNiT2NRbUFL?=
 =?utf-8?B?dUl4K2dvaVQyM0JTUzh0c0ZYeFYrTWxhM2dWRWx6V0ErNklMQTFoZksxN1lN?=
 =?utf-8?B?MjlkNG5KMGlWWHdzMWdBL0lMT2tBQXNIWDJFeElkdjhCM0I5am01Z1RqNXBU?=
 =?utf-8?B?QmhFTk9DT1VLU3p5cTg4dnlwYjRvaGFTMDlCekhhOXIzZWQ1UU1heUFLMkRT?=
 =?utf-8?B?L2V1bnpkVGg3KytRdXpCY2Z3MStUa2dUVFVpaGRjSE90Y1FFdFZNZ2tqSE5J?=
 =?utf-8?B?Nzc1TWFWckNQaUVOQVpFYWZvWm1XclJHOGxBNnhoSFFqeXkvZ2Z1YnYxZExU?=
 =?utf-8?B?c1JUTy82OVZkamlnUllPbUtHWjFaNDNFaXZJOWYwbTdOUzIzUkpkTnFVaUNs?=
 =?utf-8?Q?2wYZ8YtfZIUdTSi4=3D?=
X-Exchange-RoutingPolicyChecked: jsLYSqfOK/KHRLM/9uK2+6Tuqe1NqFhL9g+oe65Jf6G90DbZrJwNGMUQVimdhRuZDOePRe4RT6+soDeEuB2nfPct6VnY1Er66bBSZGuSFuyM0jckkEIlFhgvzHKHpSXF8FLD5tYw8Of3isURQrvOcnKpGDy7h54NuCpTOBXSlQXIzQO9iutbbn6+kD2iS49IgxkH1YnTvK94zglBthSa6tW1+KRn7tQG5yTu1SA8s99Do4P+I4Qg8L1V/ojHYH48+d8iIkEdLTKJDLOqBO9QeY2ZtmaW8Fuuwbp2fw5K1UgJAgDPYfcQEr2vpC/HcCfZa1aTXRD++BY4aWxyGf58Kg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a397a9-6039-49b7-f6f5-08deff75ad84
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:16:42.2537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2tLz5yHCEsmc4HBuTaH15NINgxzyd5TYLYRqPyXpUL3LQCIWGfwOePBwKJKLpfWi4Ja3C9KlI//Yf1TzmnvN91LS+3g0FJAyV2KUb6koEjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9524
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a88339c cx=c_pps
 a=xSzMZOIKDOBgwsc4tMfFrQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=pnBmNuUOYQARQnUSyu0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zgNHVeyF9RFleZjKwXZEgpYY4-ZkElSr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX2ADj3K1XqBrk
 wFpn6NpQ0b5S+qFRHJcKkKQhqnfzXMwELL/s/QbVmEJdurUxdiQzT5chhom2Yrpa0tn4Ov6Pgm9
 0rMlJgRK8rud/2SqSzLICjuTM78DmsA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX9giludlJQWAA
 laHi81HVXlLE5j3hX2sS4P7gLlEb7fHmP8qx6Hq0o8XqGILG6PKPHp9td6G5vjjDc05ZVe08Y6I
 gdI724WVb2/KBvGk/g8KJYy6n+x1VVmpzeB6kZt+Yz7KpmagPKYe9LnZRFcM6qR9lqYU8qEN0vn
 /aSqZPuJh2+kCt87egSoOx40Roh7bqepJXOfZEF/CXn6/88JdWg2ZE/PwcjMOKJluFhjnopcHtG
 v32oCHeU+hIE/+qmQeWutbhqAbIfWXvh6qud/z5+ku7z2hqJNSipqlHt5DaeCSY4BgSP8GXKFg6
 U9QleqX6kPPutp3CK1QIExVDnEKOte8YQwedcpNSvgazVe5YfXfCRd6gSQJze75spFyZAjTGPUV
 RvsClzxF76559sqB1in/rF1LC3FMG7NmHC6r1IH40pPkHWwUZc5jp73oaW4UvWHMDwY9J/2GQBL
 haJm72Pvmljph1kL9Aw==
X-Proofpoint-ORIG-GUID: zgNHVeyF9RFleZjKwXZEgpYY4-ZkElSr
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

Since the objects referenced by acpi_pcihp_init() do not inherit from a common
class, add ACPI_PCIHP_IO_BASE_PROP and ACPI_PCIHP_IO_BASE_PROP class properties
to each referenced object and remove the object properties manually added in
acpi_pcihp_init().

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/acpi/generic_event_device.c | 10 ++++++++++
 hw/acpi/ich9.c                 | 10 ++++++++++
 hw/acpi/pcihp.c                |  5 -----
 hw/acpi/piix4.c                |  9 +++++++++
 4 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 9e9416d406..67c9e9b3e8 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/visitor.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/pcihp.h"
 #include "hw/acpi/cpu.h"
@@ -608,6 +609,15 @@ static void acpi_ged_class_init(ObjectClass *class, const void *data)
 
     adevc->ospm_status = acpi_ged_ospm_status;
     adevc->send_event = acpi_ged_send_event;
+
+    object_class_property_add_uint16_ptr(class, ACPI_PCIHP_IO_BASE_PROP,
+                                         offsetof(AcpiGedState,
+                                                  pcihp_state.io_base),
+                                         OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint16_ptr(class, ACPI_PCIHP_IO_LEN_PROP,
+                                         offsetof(AcpiGedState,
+                                                  pcihp_state.io_len),
+                                         OBJ_PROP_FLAG_READ);
 }
 
 static const TypeInfo acpi_ged_info = {
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 4aa8d36f54..e3d526ce57 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -409,6 +409,16 @@ void ich9_pm_add_class_properties(ObjectClass *oc, ptrdiff_t pm_offset)
                                        offsetof(ICH9LPCPMRegs,
                                                 keep_pci_slot_hpc),
                                        OBJ_PROP_FLAG_READWRITE);
+    object_class_property_add_uint16_ptr(oc, ACPI_PCIHP_IO_BASE_PROP,
+                               pm_offset +
+                               offsetof(ICH9LPCPMRegs,
+                                   acpi_pci_hotplug.io_base),
+                               OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint16_ptr(oc, ACPI_PCIHP_IO_LEN_PROP,
+                               pm_offset +
+                               offsetof(ICH9LPCPMRegs,
+                                   acpi_pci_hotplug.io_len),
+                               OBJ_PROP_FLAG_READ);
 }
 
 void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 87162ff2c0..a91f523c93 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -502,11 +502,6 @@ void acpi_pcihp_init(Object *owner, AcpiPciHpState *s,
     memory_region_init_io(&s->io, owner, &acpi_pcihp_io_ops, s,
                           "acpi-pci-hotplug", s->io_len);
     memory_region_add_subregion(io, s->io_base, &s->io);
-
-    object_property_add_uint16_ptr(owner, ACPI_PCIHP_IO_BASE_PROP, &s->io_base,
-                                   OBJ_PROP_FLAG_READ);
-    object_property_add_uint16_ptr(owner, ACPI_PCIHP_IO_LEN_PROP, &s->io_len,
-                                   OBJ_PROP_FLAG_READ);
 }
 
 void build_append_pci_dsm_func0_common(Aml *ctx, Aml *retvar)
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 9b7f50c7af..1d209ac96d 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -607,6 +607,15 @@ static void piix4_pm_class_init(ObjectClass *klass, const void *data)
     hc->is_hotpluggable_bus = piix4_is_hotpluggable_bus;
     adevc->ospm_status = piix4_ospm_status;
     adevc->send_event = piix4_send_gpe;
+
+    object_class_property_add_uint16_ptr(klass, ACPI_PCIHP_IO_BASE_PROP,
+                                         offsetof(PIIX4PMState,
+                                                  acpi_pci_hotplug.io_base),
+                                         OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint16_ptr(klass, ACPI_PCIHP_IO_LEN_PROP,
+                                         offsetof(PIIX4PMState,
+                                                  acpi_pci_hotplug.io_len),
+                                         OBJ_PROP_FLAG_READ);
 }
 
 static const TypeInfo piix4_pm_info = {
-- 
2.43.0


