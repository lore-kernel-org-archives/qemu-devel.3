Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF47CA0FF0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 08:33:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqp5m-0003IP-G8; Tue, 26 Aug 2025 04:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uqp5S-0003GJ-JA
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 04:31:30 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uqp5J-0007Vx-Dd
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 04:31:24 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57Q6mLiq288236; Tue, 26 Aug 2025 01:31:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=CuQgdSrRjgGPUlUSJOGq1cNPCX9+NLqRMhVg2G/ku
 Js=; b=v+sWwknedH7E4KJL+2hlt7BnuXa0k/RFVvOGNOoppvNXpuQEfqVICqjID
 WWVvt95/uOyurGRhqU7yAtOC1uOUZnDoNeZg1Kc57rtsdVB0IO8j9aCNy9XhPnRO
 fFRrX4TfPgKbZerVoZRSGr65kzNWRCgVP6xpZPiKlyhsB8vBvOIpRwINCy+snBEx
 oAhF6ltun5c3kL9w8lBxhKCG++qzBMijYDAoMXWllRC0+YsV9QABefAB6gaAaF3f
 E3Bzgxrv1c78dE8DGjT7/pngh41TOEZilNBsnnu3CQFoRhZvke5huM8zgqh0nljm
 FAQ649HKrh7nqI3N71XhBCHwXjHOA==
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2099.outbound.protection.outlook.com [40.107.101.99])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48rvy81hu1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 26 Aug 2025 01:31:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGyawzBAc4w9MBHso6lIpWPp44mcWvubvkoVUe4zC5sSG3Ihq9dQ69eKB92CdHINxyQFoyqIK3Z4JmjyOhKyl3RYxvkv25hpmbcPBWLiZ2K8tGWy0g+oPRcoD1KTZeobIoAIOMm7r4Op8h6y9kt9Q6VPyj1pVbQLqHvd3OFYiwrUxwrrvOW3qXjWXStkGzjeW0uBy1Vd1Lm8ifsoq6k4pmJr+D3fv3RRbnz2tAsTjG4lGUJrVrwudBV1aTI55QWuTyHOSubtoXdPMHIPuHsND5IHK7uTSu6TWApRMGkIvyy9wb8jFgdE2GNuYTCAG2MUK+MrPOiosFvui+9zFcKVLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuQgdSrRjgGPUlUSJOGq1cNPCX9+NLqRMhVg2G/kuJs=;
 b=vPNGl0geKkNvBqTuMdBe12zmGJXSTyFdc/70GuJ4p2r8/kig6nhAJB9iYb9esBitHKmmGQmwZS1FFjYAPx9A6VUboxlS37YD04PpN2JJUlUD5qwPC8CYi36v18/Hi1r/F6D9pNrGhXzmg4U2w92tatZW7O+JB2lc2m0RX40yiwl5lND1FsyhJYkCuqtBPewoN6F0MrevP41u6SI3Ba7/ep50se1ZSg99ksCSuh9NiQqs47MZ/nzi2vkhevs4gyHR6dlJppQQeJ0cqyGoyJenSi7zlP055V9OzHXbtGQGEUwCgcyj0R8V9B1qtKraM2Aiz21Fj2xflYCBfpHwOC3jDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuQgdSrRjgGPUlUSJOGq1cNPCX9+NLqRMhVg2G/kuJs=;
 b=eJLlF0T3951Ve6NaicDS4qWac2c1/5zw/m08LhraM77i4xJDBDlxQysGY9Sg/YXq81Z3ZnaVaNABT/zx3wgqib7gCZaazyveu3Oik4zFjts0THsfGGgzT5E4sAvAMwSdjIZVsB0XK4LvWtkpE5YRVY4LPeoCwRkBD2k4t7PeQ5nbhTzrVY7M6+HcYTPkMdltDPPIjMvLxePT9uqRvwtfJxaCHDzDjjEuUqsJ9fNScWDU4QPjA9YaEzxSKUVgsXWndazCIm9a9tZLhUjWscKY/L7s69fPYvwC14NuMEkEGDFYajbJxvcO5gNMTsJ9yI0T+8/lSrTxNYnv6UedpNWKnQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA0PR02MB7404.namprd02.prod.outlook.com (2603:10b6:806:ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 08:31:08 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9052.021; Tue, 26 Aug 2025
 08:31:08 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 2/3] tests/functional: add vm param to cmd.py helpers
Date: Tue, 26 Aug 2025 09:30:59 +0100
Message-ID: <20250826083100.1058305-3-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250826083100.1058305-1-john.levon@nutanix.com>
References: <20250826083100.1058305-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0016.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::11) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA0PR02MB7404:EE_
X-MS-Office365-Filtering-Correlation-Id: 8670e07a-25f3-491a-f125-08dde47ae739
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a9+VPdXlV3UsBLoqezGAxoi02O3P3jUr7M31BayLddUI7GFyfQhMxbk+TACz?=
 =?us-ascii?Q?G8vkKEXcCKzRimsyFVf++xC+CGJt6ZygAs8dy1GBhooviczsLU18Dg/ItlmC?=
 =?us-ascii?Q?SaOfC5ATp1yZVYRQSBBV2pjVaKpUgyU3OGSd7oTIQ5LRK1ECEy+0mPfyZm6J?=
 =?us-ascii?Q?vjFdHBDTLEskytMIboc7CvkoYv4I2/625dwVCFA3pLm/gPT60YvmRAuDtnCx?=
 =?us-ascii?Q?lk4G7rAfTwVy9hnjyVe7xQ8TAZFpAEV3iScpX1NaylHZA7VvBO444igJuG3p?=
 =?us-ascii?Q?pVYHLGaqvuEyNY3xo88Q2w1YW5P1qSzDPINSK0Wz2coYwunuViyUpvi8Lbvl?=
 =?us-ascii?Q?MGsHrYEnp8in36mJSsJs62v/A+RC26qIQWWkfzCVfRk57pRlwQbxIXnm/Cj2?=
 =?us-ascii?Q?sJnouctWj2YxPrNIoRahcZVrgFSC9zFv3REORnP/6jNo70YpKSAVmRB4zib8?=
 =?us-ascii?Q?7Kb5q3+zxgVUarOCjQ6zI7KaP2nEKw1KlKu1+oyhOLiT+GX9/tNYu1k6Xxbt?=
 =?us-ascii?Q?sK9dqxzaJmj2tzYkVI4ervwVrodDtoZaWB5VkdDF1VldHkxg1Mq8vqd68hfl?=
 =?us-ascii?Q?8ulUPVLVNr00p5tND82btodZnXjjSwwOUZcGtz5f87UPhehSwzFyMvcLmAWe?=
 =?us-ascii?Q?K/xfbw3ujfbShJdQV+WjyH7dEAqhsCvyjARlCJDJHVWhc3wXq0/nyUZktouB?=
 =?us-ascii?Q?ZwEXhf5pe8O0qQhZQE1CZ7JVbDffV4OapBzsQhf88dXlxZwlVyRQjgmX8wHu?=
 =?us-ascii?Q?1tTk5ZONoHzJ4Z9dtB6VnLwWp8lsQW3g0kOHlEeRDPPJNCG+ODqMTUGk7yY3?=
 =?us-ascii?Q?mOIG1otAekpXsoV6kHanQr75PJ2sgUNdZbhIfAOP043tGGf4A9OSqZj3A/At?=
 =?us-ascii?Q?PonduNAZPo1eRSaD06ScH0M3UYL1+4JOfR2nwvMx5hCVrITPkoDEf6qO8pBa?=
 =?us-ascii?Q?pPjC7GtiGG48EUxoXj4vpcH2G4wiTKMEzHn3wFWoVO3WuLhw3/Y6hZXsPOB9?=
 =?us-ascii?Q?sg8g8TXmNQunkYefRW58fbfciLKUbqirnIXcCCaZQh4MKU+Vh6RsqYaCTkXt?=
 =?us-ascii?Q?/atxNgN1C0jEqQc1Vl+AL9Oc7IgNHbhyQPFuHQ4URKaRsWrge4/RO0mOh1Qg?=
 =?us-ascii?Q?8CLgUr4jgudb4pHtToI2JKQRzlvFqYoCz5jC97xinUJ7vd7PA5jT0IlT8/kd?=
 =?us-ascii?Q?ebahz4XGvZOQ0qjw6IS4IdjXJGd05oMSk5XjDRWOjsLmnV2PyN6JnVYnUCtB?=
 =?us-ascii?Q?U+tTFwmFi3SnUUtPGzdPLNX853ZF6SyEaMwArQRxufI7vauRwbP9XBJ6n0pu?=
 =?us-ascii?Q?VqmntCYwtxQ5zSzb7e5g5uXXNrWSN+8f3Z3y/xHeHG6CmWPGQb6UY/jkXLSz?=
 =?us-ascii?Q?/ZbyqZm5IWZuOM0NpMqou+tgzuTIWcfg0fbPydor4F+Q1Xzhjj9zp/2MQ93J?=
 =?us-ascii?Q?Ds49Zvtnrjk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s5SCJxYX/EYlKiiJHgXezhjln2tJoLHPW6nxY3DW04SH9AA8UEzZ3vusdRgq?=
 =?us-ascii?Q?d0WvYtj7ug3RTHgyP4zCkf1zaw5twtHAXA4EogSAct1k9Sz6uSkQ3nzN1Gc6?=
 =?us-ascii?Q?Zzfttwgeu2NtaHRsuA1tzMDVcupuCUsyl6pMaHXzTZ2lu1cii/20PrYwzuuZ?=
 =?us-ascii?Q?rD8N2+AU+HJU06RFt8oddK7La8LMEDON+To2bF3Mki6p/TmCVvfBMkyfO1Ql?=
 =?us-ascii?Q?RnRmu/4m2pgpWhy3hSHd+ijrD158unpMRbaysf7BvLhwe3uVWBUf0pZxk9bo?=
 =?us-ascii?Q?aRVwQsO8SbwGhOc7eZUz7kSPIWpu3GFH8ggx9Jw/yUt7SUb2gaRsZ4E+WFD8?=
 =?us-ascii?Q?x8qcFIBwdkQbag9c9rXqQhNnUk+hht2H/RdWOf7SuipwWBewV9he6lcBQVHw?=
 =?us-ascii?Q?7OtQ96z0iMmZemvpp6MPW/uO+AJNvG4KEF4O7kR9FHjM/C4tO4VyPpXJl457?=
 =?us-ascii?Q?DB8LB3U6bxt22GKMHlaNwy8dg9Cw3+D96FhDC5N5Vt4fC/j6T0dNvrfVouOB?=
 =?us-ascii?Q?mcAmNM67lVuvhvy1ZaAlp0kUWncGQAISu+DcyPYf1bAfuhMGdtkCO8NUA2Vy?=
 =?us-ascii?Q?KHYmHbRQCKeLqmhuetWUP/U7qaYignbZgDrtRBVHg2P4XNVdEv2am3WnqfzP?=
 =?us-ascii?Q?A1oN7dUw2ykHdFnv3Y+5cpScOuE0Q8j+XUUzfn3nhEJc1sLS3EMGXVArHe7V?=
 =?us-ascii?Q?knEG5jf97dt/tzlRMoIi72CrbbVjIL6j7EtILLTCoAMDKLNBVGWHOK+LdhOH?=
 =?us-ascii?Q?aaKQ1xwvgMeYaKTsLfLziQW4q0zdskQwUOERQ8JfKpKNihLoNtC0X1zvNidt?=
 =?us-ascii?Q?lG0UQv1551Vb4SZU+rHjhpuRcaCG1Ty9C7Et6vuURR6NTmhMqlKMerWINNpb?=
 =?us-ascii?Q?fIHZsVn1qL2S8cQpHqqyvty2/qJMwed+fuWuu60D/PPoCJ7FVXkj3v8Co4QZ?=
 =?us-ascii?Q?VmzQomZJd9Dti9hTjwF/bsoW633CYlrnjK3w7IRJESmyJkbgZZBqlIN/LkUq?=
 =?us-ascii?Q?sVyAbewjldGYux13/DW/fLP/RXoLug5we623STQUgA41W5keow6zcMP+pxJx?=
 =?us-ascii?Q?tW/yd4RuTVmXnkQtlJSMdXwKU/z0TJ5FLA6auhbRLH5tDm0cKI52UxQU91lv?=
 =?us-ascii?Q?ip5B1JVvoSKnj0hn//zYDaHbwki+1N7h3P+xWYXsl/HfF5a2pmrymaCeiceS?=
 =?us-ascii?Q?07PzO7LXRadmEpi0SsCbl/yvVD/60Zw5bpMmRjk/PHNNBJInjvMP4PpcS49x?=
 =?us-ascii?Q?ArwrBdO46PWg82vJlhMtzsNEuicDn+tk15KYOU9r42DmG3fsg+nLC2FgHg8h?=
 =?us-ascii?Q?QHMgRROdgwZsGkP57Ay61I/lasCjwyizImTzItE8iA2xR4jQRuYGitF+LHwF?=
 =?us-ascii?Q?PzrZ3VyFN3An+/HsVSpTAiZLzBUOSmQVmGcuq9fUBBIBWn2Jhu0BixYvCNpd?=
 =?us-ascii?Q?2yp+Zh8tgbut7CovU0zSCCDOgLTEhxPEM+qKyUF4emvVudNN9IL4S9zhnKbr?=
 =?us-ascii?Q?orU4iiha7gXBzYeKizE0nmG9GAe5qjPFSQWTyW/Rl2DQz92DieMNaqd+6GiU?=
 =?us-ascii?Q?Z3qkxCd9rTbk1LdOoCRESgeOqeJASahiP56Jz2DW?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8670e07a-25f3-491a-f125-08dde47ae739
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 08:31:07.7119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XnjSj4KlxoOz2tiG6L2p6Lwu+4laC/hLe30d82UReqtgGfqzZu/+UkZzbQdqki+BxE3J1PkQ+IXwiRrj697BIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7404
X-Authority-Analysis: v=2.4 cv=JNw7s9Kb c=1 sm=1 tr=0 ts=68ad70cd cx=c_pps
 a=BDhOPDsQvggip5BazaeBNQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=XuhTMkjeje0lLBXxpz8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDA3NSBTYWx0ZWRfX6vJL/Gb2bNqi
 1JqJ7Kawsi8ff9XfvvMkB6o0xwz+nDwPD0fBzIVPZHLdoQOVHc/YIR/r5bLgGZwED+rDBbblWfu
 UyA2zWrwKQOEYMhAgapXaxELgXRQ3fV8mWXJrfS05gXtBslXeTD9vZmz2djCurEHokCQoCR4YNL
 I2aS8gg6N/4iLbPdsXMZZLUSZFNEZ8/0+4u674/OCp/T2ScYfLGMyUA8uSpSN8ilXRNgfBUoi67
 9nTQpFwH0SSFmi2tcSkItAvGwoBUCrFp1sHVukAgPUW07gWhXRAXRHkKK51p4BazUzWQ537rvoW
 RfaVvQyJ9CYDCDzUeKFt2RJytaXe6ZL72SfI1eEvVDSObDMSj2cEf3oxl6xn4Q=
X-Proofpoint-ORIG-GUID: IB0eoi_WbwKRn5prNQfnH7dkaWZl99ZW
X-Proofpoint-GUID: IB0eoi_WbwKRn5prNQfnH7dkaWZl99ZW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Extend the "vm" parameter of wait_for_console_pattern() to all the other
utility functions; this allows them to be used on a VM other than
test.vm.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 tests/functional/qemu_test/cmd.py | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
index c19dfc577f..8069c89730 100644
--- a/tests/functional/qemu_test/cmd.py
+++ b/tests/functional/qemu_test/cmd.py
@@ -144,7 +144,8 @@ def _console_interaction(test, success_message, failure_message,
 
 def interrupt_interactive_console_until_pattern(test, success_message,
                                                 failure_message=None,
-                                                interrupt_string='\r'):
+                                                interrupt_string='\r',
+                                                vm=None):
     """
     Keep sending a string to interrupt a console prompt, while logging the
     console output. Typical use case is to break a boot loader prompt, such:
@@ -164,12 +165,13 @@ def interrupt_interactive_console_until_pattern(test, success_message,
     :param failure_message: if this message appears, test fails
     :param interrupt_string: a string to send to the console before trying
                              to read a new line
+    :param vm: VM to use
 
     :return: The collected output (in bytes form).
     """
     assert success_message
     return _console_interaction(test, success_message, failure_message,
-                                interrupt_string, True)
+                                interrupt_string, True, vm=vm)
 
 def wait_for_console_pattern(test, success_message, failure_message=None,
                              vm=None):
@@ -181,6 +183,7 @@ def wait_for_console_pattern(test, success_message, failure_message=None,
     :type test: :class:`qemu_test.QemuSystemTest`
     :param success_message: if this message appears, test succeeds
     :param failure_message: if this message appears, test fails
+    :param vm: VM to use
 
     :return: The collected output (in bytes form).
     """
@@ -188,7 +191,7 @@ def wait_for_console_pattern(test, success_message, failure_message=None,
     return _console_interaction(test, success_message, failure_message,
                                 None, vm=vm)
 
-def exec_command(test, command):
+def exec_command(test, command, vm=None):
     """
     Send a command to a console (appending CRLF characters), while logging
     the content.
@@ -196,14 +199,16 @@ def exec_command(test, command):
     :param test: a test containing a VM.
     :type test: :class:`qemu_test.QemuSystemTest`
     :param command: the command to send
+    :param vm: VM to use
     :type command: str
 
     :return: The collected output (in bytes form).
     """
-    return _console_interaction(test, None, None, command + '\r')
+    return _console_interaction(test, None, None, command + '\r', vm=vm)
 
 def exec_command_and_wait_for_pattern(test, command,
-                                      success_message, failure_message=None):
+                                      success_message, failure_message=None,
+                                      vm=None):
     """
     Send a command to a console (appending CRLF characters), then wait
     for success_message to appear on the console, while logging the.
@@ -215,13 +220,14 @@ def exec_command_and_wait_for_pattern(test, command,
     :param command: the command to send
     :param success_message: if this message appears, test succeeds
     :param failure_message: if this message appears, test fails
+    :param vm: VM to use
 
     :return: The collected output (in bytes form).
     """
     assert success_message
 
     return _console_interaction(test, success_message, failure_message,
-                                command + '\r')
+                                command + '\r', vm=vm)
 
 def get_qemu_img(test):
     test.log.debug('Looking for and selecting a qemu-img binary')
-- 
2.43.0


