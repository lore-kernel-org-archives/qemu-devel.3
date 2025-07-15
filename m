Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E77C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc1Q-0001DP-Jh; Tue, 15 Jul 2025 05:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc0g-0000As-U6; Tue, 15 Jul 2025 05:31:43 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc0b-0005i2-IX; Tue, 15 Jul 2025 05:31:38 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F82SQ1012288;
 Tue, 15 Jul 2025 02:31:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=HFb6I2TEBMJYg
 1UC7uTYax+K6XvJmFqmfXVb/lhtvFQ=; b=p7gwdskqZeSV0uWmT+V45nxDdxlBL
 zZuUfvpLfbW5Dg/kfkD22V0KIS2M7IcAudw+C0uhubSfAt/K63HUNQ2FGDWfxwvu
 gWsDlndEK5+oLpjEG+Wq237OaD3ANp7qqmLNgoQTaeJI4+Oy/yedLfweK+Ko0fDk
 yt58SVnw9gySR/Fi4sue13eFBQ+wbr70sEMCS8rCqWHSxlxSaGWNglgYNhWVQV7v
 CkdQh9ks26NH/RoprIgpCw6Mu3Gdt+aUdF3N03V42S75WdGtwFbKKUp/6baAYg8N
 JJPxTZqoEO50MPRSKtI4zX1PAI868WvQoRSsBkXVaWT9UqnQJR7pnD7mA==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2122.outbound.protection.outlook.com [40.107.94.122])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47upsh5p0s-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 02:31:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQzq1jsezC9Aq/1if8yF9rVlfN2tNM3Z13Q17UVZ8teqilpHnvmIgB9ao/2R9ycWOFdSXcRY7ZuRfXtGMEIUa0F3wQ5JxQD8mGKfTodf5tP/T1tomkILJtfp3p3XdRGDtNaVbE28purvKTtEPL88km6QfFgLIGhUxA9pvFh+5UI4zUgakECtT3eoX7V0eI0otICDkoRiYO5MwP+C/esuczdYlN2BdRgpT+Qgcpqkj5Bfeauj1jJ2BM+dXtSNodmJacqqGyn+hRPuKbtyCpc/lmzCUXt04ScJJp4DovdeKV15Ewdf0BSwq4C/9KkMaIGWpOdNMLLlklgULF3/uXOYQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFb6I2TEBMJYg1UC7uTYax+K6XvJmFqmfXVb/lhtvFQ=;
 b=vfFawSnY4k/ST2ulWuSbRPwa6RjgKisx0LfbKPn9oVlyRaiLw1ce5T/w2CEXB3cCEW3aNaI5YQ+OJ7GIGXDI7qZdEp83pxfpyRtq1yyXiBHix+7NoS7egi8SFAEJxWOPPQ9l33l8T45AzXG2zMCAITy6Lyns8b63ma8jch7qGXdSXVG4lRcSiGF2Fb/+2hkU8W3fsTya1ETrF9TJlcmjwegoWzHS+w2LU8BRPvCIXnKr1ZSWdTFqsTFhMj4Q1hTk7rud8ZsOIVoIRi7s9Zdbo/HzJzXXnJYChIGd88jpIli8gDmr2zNu/SkpgTQAYs+f9ODYTo5di6lXpcYyWLYuqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFb6I2TEBMJYg1UC7uTYax+K6XvJmFqmfXVb/lhtvFQ=;
 b=lNYhC0B+nsgOUG2KiKg0c0zBmR18JZ9/EAonFCpR7LiFxmaNJuHbUaa7Y5MRhrTQ9ZQbixU5Dfff0203m7RUPSvhtGmyTjVeG/eK2izJGDbipuEszpZxHo4a9ioRcnSUzEsxj7u5dC1bEPM0fnFH4PQM1mNHGD9xak70rVTlqQdRs3MBVDQ9Mb4NIH6jFO4rez5aPd2MQrTEGMF/uu4JdVrvMzyNvcXZxrmW7s9PAtA3FYQyJcaqdlwU9DswJwtkMt3Ie6TcGo6neGivVako7p9JC+BB21uK5NquC3So2DovT/MmFCCb3lT5FKWV5ExOTn8nmcM24F1BXIlFW/YTAw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH7PR02MB9386.namprd02.prod.outlook.com (2603:10b6:510:27c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 09:31:20 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:31:14 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 00/22] vfio: improve use of QOM and coding guidelines
Date: Tue, 15 Jul 2025 10:25:40 +0100
Message-ID: <20250715093110.107317-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0007.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH7PR02MB9386:EE_
X-MS-Office365-Filtering-Correlation-Id: e540ba46-0b69-441a-dde3-08ddc38257c0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t9mS9FbTPsPHK3cBdwryvAvLjNgq/oNnWoMOu8PRrk8ek/2IspUSfsoXLTN5?=
 =?us-ascii?Q?UoWtnNSzCmgFTxR/PayOhctinwwZIWqyJGu8EqXkLsXXRif0VcNHu13Ae6c/?=
 =?us-ascii?Q?p6PQwUkiIowjkvAYSwKwRPzCDxZMT2PeOauHmBnttaX6jmqlNZAsqGmqTFNY?=
 =?us-ascii?Q?kafahdYi7pGh30o7fG6kktXRuJN6sBvwgebicVKRY9v9qyP6K19PMGQp9BDf?=
 =?us-ascii?Q?45jIHrEnOg6eWDJzpF7LGJcWybAPOEXfTmm+0lXuoVO1YBAsIdeltM2XTBRb?=
 =?us-ascii?Q?HZWC7KCaMnvpOGJsc90VAKOTcTIyWy9B9cqIz8ykbsanpawNaaIYCW3aEAJy?=
 =?us-ascii?Q?OFox5g4Mp8Csooba7M+UFzMQFjyYdc06blTPy63vMvXZRpvk5lU1DfZFGbgU?=
 =?us-ascii?Q?+hbhQP6Ql4JwuzbBxKY/Hx2V16A+zyamT/J06RINNF9iWYMKtdrbQzatnBus?=
 =?us-ascii?Q?dN6G8f+bpN8ID9uVLjugIYZyY2ellxVOBnT9+tPWPrbCNB1xEch6InRYGgVd?=
 =?us-ascii?Q?Q0wvof1oUbwEGBeCkaEp9pbwRwLGoTO/1pom3oq4BICcnARm6nSwcHTVu0oG?=
 =?us-ascii?Q?NCvse1N+h+EMoDSWLwxLJao24WKLwpzyCU9ox4rNT9GZvFO8/U2qzY0cP5t0?=
 =?us-ascii?Q?cjIocPAyflzM1wklBvOqEuAAoHZ7VYVbH1zF17QLSB50iSQ/eJo1rS+4lBTI?=
 =?us-ascii?Q?YZnJ8/EB86lvdIO+bLxpAVgLWFTQzteidw5QZja8uLwQEYrzOQZKowsH0zmB?=
 =?us-ascii?Q?CSu/b7lXwuCJ7jLbFCIJxvzc2RZBNoje/RNwlkoOxSwFYO/Mibrq3iGxd27M?=
 =?us-ascii?Q?+iY33naoTG9HoNJnJ/i6ICf3WsvK5v8LLKmnnsvkRxxTSkgWIXuIxM8S+peT?=
 =?us-ascii?Q?WFjF3jFBR/mvcC+6lUGnNK/8dn0aozy6ng2+VL2t6+QA5lOEwrdI4qanxVPr?=
 =?us-ascii?Q?aGwHC9tUTg2H4F8vzsD0zrOAH4CpBNcXekqPtN7c5Grx2vJ1+UbuNj6DNnND?=
 =?us-ascii?Q?P54z2nyj7f1OQPju5bd240r77vcY6CMdkplrjb5wO+IH3BInwr4vKRHb0+tB?=
 =?us-ascii?Q?rNIxcOIeuY14fLnABNQjz+i0xxQfF2Vagoqpyq5PAVpgPMZIsINx0Lb1UQ9T?=
 =?us-ascii?Q?IC1aLqi2Hz2sKOFcAvM0K+liSuLWnbeYMlKSzFMkn7sfjvlLsjU+L5HIBhXt?=
 =?us-ascii?Q?4BvMDZBqPm+cPHjL0PMb4mZ+OGf2gGTHYZdaWrLD+fQDdbrkhaMJX1/HJs+3?=
 =?us-ascii?Q?BWh6dFVtPvTQVy9POFlSvrnHb1nn+8uLrlPWGRZj4lWUG5yK4W6+/onD5Tg2?=
 =?us-ascii?Q?A32ovluYyeyFBjoi4vgb97IbXDDDhQqMbRn7FW7B8fuvD0RsXz8DjNwWwK7Q?=
 =?us-ascii?Q?y5nOQwQXUp9qeZOmq5LhK03LlPfQnnkE+wKsqsQ7a4plWhCvlpMqg19IPbDY?=
 =?us-ascii?Q?vdAENvfLON9ffZGwMt9ytHIGamq4/kwiIGQu9FKs8x3wcyVpUuUaVw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mcP0RRZ75Cm9iRgy0G0d2TLXL1KVFjv18BK4GlxA6mmCZYg62lr0lOKBqUhq?=
 =?us-ascii?Q?StvNTCIMKrBK1q+fArLVwWO8doUA0PLZt8naMyg+FRk48q/EdOp1tHMgUIQP?=
 =?us-ascii?Q?NdtvdIDDLdvLekj7AhNrkr7nyVpHMNiIGBbyGOObSv/ACRYuF6tYOz1Deen3?=
 =?us-ascii?Q?faKaIkv0bdlRimS49EDr7g8ZHzaNr1ktmlDPPf2TFH/FMFoy4ssioTOl20gD?=
 =?us-ascii?Q?T9hxAj9Wupd/QQ6mmukgnoU+MSmtuWfL6G33TB50BaFG7nMJ9FiaC+edLslN?=
 =?us-ascii?Q?Wx7RnlWmdigfScanIlBkVvSgK2vFrc8UvPfkf9KFS72fHGoJomaIOrujhRzs?=
 =?us-ascii?Q?9sSd4Pmf6YydFzN0CJ4U1k2pZFF3PUXV2VZua8APuqaAgTj6wBwy3ig4qRFt?=
 =?us-ascii?Q?JR8IGRRWvXkpOp14yLuUyonW4+S2uVNVAqoPuyg+nG57chzJw+amRn3ZoFqf?=
 =?us-ascii?Q?ARfz8EQdkveezX3trzNm6nTiouZ45XdGgLbkRBNjgd8mO8MrXZ+1Epg0x+J7?=
 =?us-ascii?Q?bgcv2qWUzGqbwDFJORe67fcWPpNl2VttAZ+SGY7FZSldlABZysF3QNQM20z2?=
 =?us-ascii?Q?kTiwTz2IOIuLe8UMUsfMiU0nIw3Or5Pwo3LHODahG/o9yXaIGbz2TXhh+qrg?=
 =?us-ascii?Q?RzqtbIGjfheJmvNxdfWYSSVidvc+ce60o+/G38TlqbgHErEIMJD3otS74ail?=
 =?us-ascii?Q?b0W/vH1W1owMxtQFv1VT5ZfnZl5DSNxOe4UCSurGyyDCXlOUQLNC09c5dVsz?=
 =?us-ascii?Q?b0B32StByrAwLg8DQxiNjHa0I98rSHJnl4aG6RRw8nZHKHeVPBextu+p3MME?=
 =?us-ascii?Q?rDxoo86Zp+cBzZRFhCWJdBRdFIIVEvIunm9Ehj1Dq8jW8zmS2/K+uazpesdC?=
 =?us-ascii?Q?z8tk3f9ckwnlAqD3RWnzFpe8RBZPorSqQ0gUH/k1XfM2HLPXASDU9SZo0ud0?=
 =?us-ascii?Q?lrb1kuk6qyRMtHiAjxNO6up/izst91FKvJqAf128n5NdwbGuxePalafaihlK?=
 =?us-ascii?Q?m6fnDmSijh2M9IgEl3HaClhWwkCWAyi0NmN3c8Shjhk7Gy24f7nodfAGafK8?=
 =?us-ascii?Q?5izKPEAzEjX8XG6n1T3/xvG3eh66c+v9Y1nCBpkHETxtuQ5jbECB7YCqdQU5?=
 =?us-ascii?Q?891VVJoMBuXBOSpaXGKTJhU8zpLoIu7NtARm67Ip5I6iDqnAHOIduLz0JZyx?=
 =?us-ascii?Q?MMEwEMSwe8nH4TZMLx6vLguaTT3/hl14TttvPD789RlUF4j5+v82C7KazKAf?=
 =?us-ascii?Q?IPbG5khYhdMeG6sTkCBZ6JwQLS187K+m1Ozbro0x7ONvuLQTk0FrhaG2XDhF?=
 =?us-ascii?Q?mAhklyVwXP6mAeqMDoxDiaxDFIwKTzODmEV1O3UUkzOVmFgRDRzF5/+J65BR?=
 =?us-ascii?Q?wWGL1i+12XPIm0/VTNMUz21BgxmuG5vMXHrn2H1dOtztccQFRlRHH66WzrDy?=
 =?us-ascii?Q?f+rw8bN57SA+2gecZIiQEkDsbH0tL3xWKDlPodBTSL/m5q/sgNvVUMjCFZ9D?=
 =?us-ascii?Q?9yH8MQK4xMSwkD8Q8FMmXGIn1tr4/8FwVraeckEeJnLPZtjgWJFVrHDeiGno?=
 =?us-ascii?Q?ohwftXLTTddgq339GKT2GZR3WAsjPVBqQKpvt8bUey6+GLHcpbwVGORlXly2?=
 =?us-ascii?Q?NJwrKhNIa90T+LwNGFzzGSQVq8fvzuNvs+SUu9aURucImv5vXsVP8ssbXVq2?=
 =?us-ascii?Q?V5lOOA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e540ba46-0b69-441a-dde3-08ddc38257c0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:31:14.4826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMKNXb/ceEU+GButNqdUocfFKIi0dQM89En75gvILWiLd21hIw8qw0px9rfCM/vT7b5t9KfXYtuV4Au//OD2AzJ6YP5fRKazDHMn/mF/Kps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9386
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4NSBTYWx0ZWRfX7sqTUWsQa6Nh
 ey09THRSGrYZuPPD9W7qbQqwQREY7JsAt7yhvDrIWiiAh8RbFRhoIXkSgzrQAcUSgyu699+Aqa8
 cKQDcwqBqZ2c+arwy0ZWiTp/hwBPJsG7/tDrwYt+wlKnxefqiNZ0TT/mWhZnaiSD6PSCYoBZ0fk
 PFMYTfOqK/+SM6IKG5ip3lEPGFkHzQtJpPOTQDvuVgkBzP6jQ+WR1n60YnXg3OloPgS6qvzDBww
 fiH68POyjhXMCg7RUYlTs2FB89WqgbBebQLiZujL95t5qsNlCZREawNE5gKQZI5Pj/4K06HFgoP
 R+ET94QG2Q/qZIisWzUkxZ1srM6MYEG+UAKbwwUIzfqgAO5h3hnhA8QDjwvlo8/9w0bhQxr66af
 kaw9fIA52Mv6akYUEYw82BIue1nfMIByVeiTK0XEQ4prFvqLCNIAhMgaqN6kyj9dfUtsP7u0
X-Proofpoint-ORIG-GUID: tY5jqyKz8E89GXUA_poCFZlRSAa_rIkn
X-Proofpoint-GUID: tY5jqyKz8E89GXUA_poCFZlRSAa_rIkn
X-Authority-Analysis: v=2.4 cv=AoTu3P9P c=1 sm=1 tr=0 ts=68761fec cx=c_pps
 a=hEWPytJkew9UMlV5tkGFJQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=t5af-nFZHoBiCRm_S50A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series attempts to improve use of QOM within the vfio subsystem which
appears to have been added at a later date. It's mostly mechanical changes
that do the following:

  1) Format the QOM structs per our coding guidelines

  2) Ensure the parent object is called parent_obj

  3) Use QOM casts to access the parent object, instead of accessing
     the parent struct member directly

The benefits of this are that the QOM casts included type checking to help
ensure the right object is being passed into the cast, and it also becomes
much easier to infer the class hierarchy from reading the code.

Having produced this series, it feels to me that the readability could be
further improved by renaming the structs as follows:

   VFIOContainer     -> VFIOLegacyContainer
   VFIOContainerBase -> VFIOContainer

However I have left this for now given how close that we are to freeze.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


Mark Cave-Ayland (22):
  vfio/vfio-container-base.h: update VFIOContainerBase declaration
  vfio/vfio-container.h: update VFIOContainer declaration
  hw/vfio/cpr-legacy.c: use QOM casts where appropriate
  hw/vfio/container.c: use QOM casts where appropriate
  ppc/spapr_pci_vfio.c: use QOM casts where appropriate
  vfio/spapr.c: use QOM casts where appropriate
  vfio/vfio-container.h: rename VFIOContainer bcontainer field to
    parent_obj
  vfio-user/container.h: update VFIOUserContainer declaration
  vfio/container.c: use QOM casts where appropriate
  vfio-user/container.h: rename VFIOUserContainer bcontainer field to
    parent_obj
  vfio-user/pci.c: update VFIOUserPCIDevice declaration
  vfio-user/pci.c: use QOM casts where appropriate
  vfio-user/pci.c: rename VFIOUserPCIDevice device field to parent_obj
  vfio/pci.h: update VFIOPCIDevice declaration
  vfio/pci.h: use QOM casts where appropriate
  vfio/pci.c: use QOM casts where appropriate
  vfio/pci-quirks.c: use QOM casts where appropriate
  vfio/cpr.c: use QOM casts where appropriate
  vfio/igd.c: use QOM casts where appropriate
  vfio-user/pci.c: use QOM casts where appropriate
  s390x/s390-pci-vfio.c: use QOM casts where appropriate
  vfio/pci.h: rename VFIOPCIDevice pdev field to parent_obj

 hw/ppc/spapr_pci_vfio.c               |   2 +-
 hw/s390x/s390-pci-vfio.c              |  14 +-
 hw/vfio-user/container.c              |  26 ++--
 hw/vfio-user/container.h              |   7 +-
 hw/vfio-user/pci.c                    |  16 +-
 hw/vfio/container.c                   |  31 ++--
 hw/vfio/cpr-legacy.c                  |  14 +-
 hw/vfio/cpr.c                         |  10 +-
 hw/vfio/igd.c                         |  38 ++---
 hw/vfio/pci-quirks.c                  |  48 +++---
 hw/vfio/pci.c                         | 206 +++++++++++++++-----------
 hw/vfio/pci.h                         |   5 +-
 hw/vfio/spapr.c                       |  16 +-
 include/hw/vfio/vfio-container-base.h |  13 +-
 include/hw/vfio/vfio-container.h      |   7 +-
 15 files changed, 249 insertions(+), 204 deletions(-)

-- 
2.43.0


