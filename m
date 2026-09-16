Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40E1C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6nCT-000475-Rm; Wed, 16 Sep 2026 06:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n9F-0001ZO-R6
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:55 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n9B-00034j-MW
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:53 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68G8i7xW353641; Wed, 16 Sep 2026 03:45:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=CVzucpNfOsd45ZWBehwp5Jyz8xROMk2RY6hnw2IeO
 3w=; b=eqlHxThBwdbt0dsXsG+Zh+BQVviFsN/bpnm4KDjhfc3zjz8mSNCkxIzqN
 PbDdPZEm8X+UCoHT6aQX6IcteY3bVqqtxd0i5FlR8JFT2BCSvSfVRoXutShZ6nEN
 Kl7yuI/H33OSJHIyxaoV/wV5nc3g0ovfJEeUzUi61V342rpHnI877E9Eey9AqXhd
 qe22EBY8eKeRPtLjvLssxEmdVlqH3QY0wnWkGU6winqcDrvbD/Bqsq8MQ6kTLc3u
 c5qH72bsPnyVOk7BFjUSJM2Y7/PLWuMN3audCxSOj9u9TUj5RwVme82V0QCRbhEj
 TimAtZ7RBAM+mxeZ8LOpOr0A6cGoA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021132.outbound.protection.outlook.com
 [40.93.194.132])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gq9drte7e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 03:45:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ft3EhXjbGPe6426enODVOjnTr/xChz3Rfi8srPexCaVXvlOaoCK0U+EL1w4rqYY8pj1nuhAb9sFRXESHgeowvdVrEKffWcHQb5pZkaLNq49y4A7aFIF5SBV0N9UGmSkfdPAfispEhjiKIgOI5X8GwsfHyOMI7CKJ42nWIWprOUOOXBLpDT74cMpfuNM1n9fIs+xpDXrBBultK2Ha2x0AmEMJqBPZNZw/GhAC9z24Fc0liMp0bzL3Uezs7+dAO2XB+WrKK6xBpgejp2hUuYAjwwFW5N/80RoDPzZFaiQJR5GVMbqLlpqFTETnqr4IEsl9iespO+haSAxNZhHMbLNylA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVzucpNfOsd45ZWBehwp5Jyz8xROMk2RY6hnw2IeO3w=;
 b=jMzdcyW2qkNY+r1P8qLJmbL8ufq+rMNCN3GAThZ/yDSW1Eq1AIhn8EXHaf+kHvTVon3ZUzZLgtfk/LgGDAKcBJMSWkZS1USl6KrWbpVbODNXtYjFBUaUhHsUXLQmrerjRf52VlUlacERzvhHMI1oH4PzijydiF+qXMbGOHrACCt3vPYAH7QRwwMwo4xpQjsy7krpMCjB7jC8tqNf9GRL57SVScdYdYFPveEoCEt0bQWNJa8CVvFXFnMC+MrTPeNYrFBmGB6Giob9/AZBTkPQ9yWKDmEy4svCg4jH9npDsGdmhqv931irurSxBZ/K4/8mY+VMooJyrMzYTcBZEaznCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVzucpNfOsd45ZWBehwp5Jyz8xROMk2RY6hnw2IeO3w=;
 b=LlvGyLg8+dWh68mocmH/mnfWSThgE0S+NHwAfsAbOja+N902MR7xTQzP9+TmaYUwCrbrTwwULGpM9PckXzhBLJYcPBIoZHab3yrjGgqkpzrNt7wUf4DtjhLOJBb/zVsmPmmjQhQLQEVZ7s7qzQW8Vmvl9II4HKodC8xW6XyodCi6ELz+yKW9flaRzPhzTOFfXW9npNcb8dqTELVS1NajKY6WXRiQGg/MvZwm8kaDHFyBEzPqOwPJNCJmAOwGxbFuS3rR9HzUTG8mCPHfLadxNFZtfSRdYH8Xv4x8EHLwPnfcEjuNaABoez+LKzbSpUaDWkXdTilFKCTpsa86v3Ui2w==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PHXPR02MB11343.namprd02.prod.outlook.com (2603:10b6:510:3cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 10:45:42 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 10:45:41 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH 18/22] i8259_common.c: remove unused i8259_init_chip() function
Date: Wed, 16 Sep 2026 11:43:46 +0100
Message-ID: <20260916104435.600211-19-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916104435.600211-1-mark.caveayland@nutanix.com>
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0095.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::10) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PHXPR02MB11343:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f07026-3969-4637-0487-08df13dfa76d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|10067099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: nWFSEh+wjfS9xTxhUHJZmZXI9vckJ/ffqTXv2IDdEaIwwyAnB8v77gGKPfrNd2iLQt5wIg08X8+33xQo4iXPENXORR1j3voPc6gn1BD3qQN0af3eaiDo4m3oQuc3RXEhyTOAPaeeDfKyqU2Q1QlILRmBwChS4sNBkp+74qo/VNXTXttXqanZa+7hV/XytnHDwk6QDAaE2+13f4Zh7/r7a2FGJOJ9Kb9eehM9FhPk/vbJXJ4eNJyGRXp5TMzmZFkmdbFdmzWtvlPMxTDFSHZo2A/v/tZFWRk+G592HdU3i3Fx2aruJdBbKs8zvlMoaG6tJmniOh4ofH47k+n9lDnfblZWanWsJrTV6H0w3AVfkPg5CG6ttm8W5lfSlIs64bh/MXFlQcWKBc/g9nDCF8UzhXFWQPXaMS+4MbgeHME/tjB63LDBYC3AOrTgusjfnF/wMgSLTkxcbAdESzl+i+2zJMZF6oPLqW6635/wtP9C0gpWUlH/H+yydrkCxvqgpEgkExq4BnE0xx4OPqcrl2qzVX8WgQ2ZomTMS054o4fG2I8e0VEKyyCN8Vzh1M976f7QLA22DnOQdK2C9HFQABCv7Wz0JZ//grLI9Nh01CcmYSOwZR46oN3fSOq/szFXctgemPMyvLKN/sKpLy8+dA2tDrJ3X/Zu1rmibba7iZ5fyGw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(10067099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xqaaYB5G5dEIfMvaLJ8Ma9IONtiEHSU62+8gjaY415EE5Y+vckV3+weBzzRq?=
 =?us-ascii?Q?LfFIsC32UTleJzJ8ELuFXFoOEJoCpKd4MLO8p4vn6UoEY1w5q18iHckaWV1c?=
 =?us-ascii?Q?V3hq40LO0qVWI6EsKIXlV5AYMAt1XtkoJZJe/zUE8j2x6Ei5tLC4pFDjC4EU?=
 =?us-ascii?Q?qYxFPxy0FiSxvvZoFh0JzyuhxpOmZLS6krzhYtlKuOyvNGfqWxJ/2L1FWJi3?=
 =?us-ascii?Q?9WVFUnC+I28nBTwExOxp0468wZPmQQ7HC2FBq6MgcQ9Db6rDUdNPmQvvGiDF?=
 =?us-ascii?Q?HvvM/8xxGX706mdDXJ3BJv5uq4Fb9mZL8iGTlAjz+k3dliVHKgJjiALweARW?=
 =?us-ascii?Q?SoK+5/zmbUQ4V6fIHU4rymoovQ+w0/+RkwvYHerYH0WtiyutTwC0shycY2Am?=
 =?us-ascii?Q?MovNy60OniwaeQwnedeNTQvvM6cipTCstyJQewVRo7mU/2VfLfL5oa/cne7q?=
 =?us-ascii?Q?1ei4Xor/S2yZSxiXlVVhHo8VTkkrl1cWqxDu0n/cEwB/GgtMRSSC3fPFJ3hj?=
 =?us-ascii?Q?h3Mt9d5uz7spz6PHfgrAk98xqOcM3EwQ5ECEIoEbeSe7GFOHwZElgK9pLWV+?=
 =?us-ascii?Q?st9YJV/EDjE35YCZRLBMx+STUxuq5Dk702lTr3oHBme0ZDHPYo3bQOMmqcuS?=
 =?us-ascii?Q?nApyyzl6JdTgxEh68xF1it8IF6ajo5MHRl7/H6sXVt9jZSxh30u3SW3Fa14M?=
 =?us-ascii?Q?/OlU4JhOCnvCEssAY/kYQ8KW0Vnl3PGOw9ZId+MI1dNBFdsyX6WIjX2cr7LR?=
 =?us-ascii?Q?51AUEo2p3C9NKJ71H3+tyWaXR+zWB6FMFhQe1x/ouE8Kp4vPbHRbXRh/jrVY?=
 =?us-ascii?Q?bqTh4Rg70bhG8zLcDksqiox9uofqa3w6WPhfmwTuEiN1PCg3COI+aDVUYZDD?=
 =?us-ascii?Q?Hz8wSMLnOWARuzHj7BPW1Sxeb/gV9uRsVNCIy2ileGwKE6WwR9fzU/ou5kiP?=
 =?us-ascii?Q?3jCJRAFFEtN4Iox7whKmaNSutyHQuBMGzC+xIt3kheN1f9K7HWBHNZ5ZTj2p?=
 =?us-ascii?Q?KVHruimnwBI1tr47l1v7Y+UJSAWvKeBHGJ7skJV5uZmM0H39OBsNWEjrJH1B?=
 =?us-ascii?Q?tKV4KWoz14iIZ3W3/OJBD52C4jW3yiXUz+gzG/JMYpGiC4IZTDhR1baiqJaQ?=
 =?us-ascii?Q?puI6qPze+RvyXc0A8bDgaudstsQyv57EBjdmPBRPE3sLnRTBuMfvDpUzsq84?=
 =?us-ascii?Q?6l/nxds7ALjN5x2td3EnaIHvWBYwt1XGrEYhCEn92JQEkOlundiCf9jMO0mb?=
 =?us-ascii?Q?a0NqIeDJi63nqX+ONio54Zb193H9hGOHX1j3Tge58OPaueHfwfzFgme/PgDs?=
 =?us-ascii?Q?PT/cIlfgoUeP5EdQBNotKvBXmiuHfSAGhWHjxrJf5VMDkd+NIoLUujFfMFJL?=
 =?us-ascii?Q?5dwkrnQZ28KVEK1Oex9zPVE5KkA/P9VsvuJlIG2XVuM0V3Q1jGjHMfeUWhRZ?=
 =?us-ascii?Q?zHOfRJ1ukM2rK4KOHbBCucGFxSc919nkv9EVmFc+jK1P0SJ95dsmNRl8QQhI?=
 =?us-ascii?Q?egxXIr+H25Mh8bdr9DnN4dq2LaNOOz/uWpTN0utUSSD/qmzwnc2zwEIW0cEY?=
 =?us-ascii?Q?fZgsibwOPUgryo5KNT7RGXByXbJhgQ66A+0g0+BUxyegVwZnegvkgDJthZxE?=
 =?us-ascii?Q?wxtC1V7NiFoJt60XG1Vqbpo97j6MMZIrwSR0+ZFupKC7BTcDbL05O8U5I++z?=
 =?us-ascii?Q?bX33dS/JGAUhOjSfpdSQgjm8+wb9Q0pI7HUDim781hnUKUmG8M6bziURyMor?=
 =?us-ascii?Q?pLETKZ4M67xMa6aGCbSv+Igvu+HL9XY=3D?=
X-Exchange-RoutingPolicyChecked: GxPX6SCW9Cx5S8NQQAYvNpZxBnz93myhLerMer4aX6/0PtFRs68rZ1oX41jm5iatqm0vx8vlHQsRH0cFyaHh7XS9/wvwu2IOa5ChVvOChkU7OH9YL5zVD4UI1yU0kPJlb0LuSRT0QlffIPVIP+LGQQ3jWZmCgmX0fLiGEnQokZRJfuZwwJMYV+k4TXSSwO+NJX4MEBayszV9GXpyIoKML1tDcMA1+llJhZlDQy3M6PpecQkPkXCAsyVOO0uFNIP2PUdm363C7lMSoCxO8ttLBEHFB5w9OowVD3QZgYyElZ2p1I9IovebbLEiR/pA1foAyb7wa/l9G27tvT+v7f286A==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f07026-3969-4637-0487-08df13dfa76d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:45:41.9344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKIf7ThANs9prk6b6tofJiZCRA9/GWvhtMqiGQh6711F55QPb9UfIJrJMfzP7xxOj9R1eisCJonivRP17jSGC3eV6L4yKrv4RXvy/lXRRoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR02MB11343
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfX0nHhkCfUIt3m
 jGuhlmbQ2ch1t7ETxdqpB6tPSUDftOEvImB84pzjNgSBKDmWGXsNk9Zo4RZn1sPS7V3jPWzVlIf
 A80YHaF9P+AbJBdgms40/RKEpcSaBoSR8PnZiMF6oPLSV26/YpQjJqW9b+7ErZ/d8thHJRWZUmz
 j818jK5XGsZA1gcQl7SbtNtXx2xB5BkzuRiRL5V/OapWsFgwIyf15ygL3CjPyVmDpB1w+Mw+vnW
 r/Ggy4PKcUVFsdyRvPC1aQ/DtpPfrkHAx1pwFfXkCDq8Hy3IO30DrJ8PdkA4wZXeWsLxNzEF7Ch
 Ca585ciTVd9gTsk3MV8HiqVJq4BgdIwDIkEIM8L25TKedeyUez5lZGUNeHGnJfROoYi8vSSAYt9
 350C0VjIZT1c1NFGlhswByMIqgP/He84R+fVixtgRurmuCt+uDLYoJ+tkCayvq2Shur9S/kGpH7
 4Bmsh6rWtlYcWhsJkZQ==
X-Authority-Analysis: v=2.4 cv=XO2l2ghE c=1 sm=1 tr=0 ts=6aaa7357 cx=c_pps
 a=hMPBqNrkZiCD5Zgemr5n7Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=fn9E0C1quIHmE1dKZfwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfXzorE31bLTvO/
 7vxAMLg3k1BjAklsDO3NSE/msdZDiDrNPgwjOgiaNia3wX+3gtKu2XHhmeW1/2Lq5645sDvIisW
 4WbYoij/PfA+S5uGFLBeGUbP5FmMKdY=
X-Proofpoint-ORIG-GUID: lr9dVMnoDwcinhadbufyLQ39wMlyeJQh
X-Proofpoint-GUID: lr9dVMnoDwcinhadbufyLQ39wMlyeJQh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
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

This function is now unused and can be removed.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/isa/i8259_internal.h |  1 -
 hw/intc/i8259_common.c          | 16 ----------------
 2 files changed, 17 deletions(-)

diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index 282e437d25..390a373511 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -73,7 +73,6 @@ struct I8259CommonState {
 };
 
 void i8259_common_reset(I8259CommonState *s);
-ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master);
 void i8259_stat_update_irq(int irq, int level);
 
 #endif /* QEMU_I8259_INTERNAL_H */
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index ec229a0b5d..b3f2600523 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -89,22 +89,6 @@ static void i8259_common_realize(DeviceState *dev, Error **errp)
     qdev_set_legacy_instance_id(dev, s->iobase, 1);
 }
 
-ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master)
-{
-    DeviceState *dev;
-    ISADevice *isadev;
-
-    isadev = isa_new(name);
-    dev = DEVICE(isadev);
-    qdev_prop_set_uint32(dev, "iobase", master ? 0x20 : 0xa0);
-    qdev_prop_set_uint32(dev, "elcr_addr", master ? 0x4d0 : 0x4d1);
-    qdev_prop_set_uint8(dev, "elcr_mask", master ? 0xf8 : 0xde);
-    qdev_prop_set_bit(dev, "master", master);
-    isa_realize_and_unref(isadev, bus, &error_fatal);
-
-    return isadev;
-}
-
 void i8259_stat_update_irq(int irq, int level)
 {
     if (level != irq_level[irq]) {
-- 
2.43.0


