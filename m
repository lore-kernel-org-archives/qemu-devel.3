Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D94BC5AD49
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 00:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNh9k-00031w-8a; Fri, 06 Jun 2025 20:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9j-00031a-46
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:27 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9c-0006Q0-CW
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:26 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556Kvu6n017760;
 Fri, 6 Jun 2025 17:11:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=zxCsFErulNbPOxCKbF3UavilB4wcwM+IwtZ/BHwWH
 H4=; b=G2ChusJdhmH0nBqPeaEYmPiuHtvmn5sVQs5UNdQr7vzyG5lmntkIzFdNu
 QnExma9kEGCllsHEpwoYzh+6D1qYJu1KM/bYQebz0Bm5+nyChbzWGFCMYJYCBTmz
 Viml7hX97AaoSAFvQ3p6i527xWkP9T2nWGPw3k8AE63rdHyp74hKgdQXE6eabu19
 gH4Kkbb4o2CJmx8YUETnkXDU9wgn2QbVcP2omOZCTpX2ICHSZYLp2c7mFvHP0GAq
 vN9leU+RMSk9Ia/lrOqPfVhLmwVrL/T8f7p64fMs9b8JIIN2UaEiK7kcMX38B+Za
 EIZkXvIhJPrgHJ/W53D8rPZfppJaQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2137.outbound.protection.outlook.com [40.107.237.137])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4747u3r8fj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 17:11:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJvACoM3BZW3/WXV3EfQRJrop0Tf1gvv4Vw60i6G+jA89gk/Vgldn8wIYglYXZn5jVXl/IGJqjBYnV6ONvqKfpS83VEK1gG6ZbQZa3BCyjHppSlu94PJjHMrSUAgekCqeCmUp7WXUCQzVevH5T+6oVRjQ266VPGI5+bfRmEvpEFCJZF9C+9KSf44arST4wCHEX3eD7wDuOj2d2p4qDSgMpbg4ze0Arh6jUzVlpeK9zout18MUCoYlW4IWYZzJO287YeV2xIzOj9tl9bvZs3VdVXDJ6OlpDslFr7NhjvyhF5wxBThIDF8or5H5NCgZnoIdWw7WZd+Auz5ZUI4Lvvm3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxCsFErulNbPOxCKbF3UavilB4wcwM+IwtZ/BHwWHH4=;
 b=YhpUhV9Ff4YUOj5o0PoOFgFdE3qSARVxJ1bGdNKQKbI2vewqgjn3CZTacfarIcNRQX14nZUcDPRA8gQxzzNDjBwspDmajgEgzV+ZoOJBCvJSibwR0MFVoBBz78OnQLQtfsYz4VG2d2bHGGIGihITmqRiDhxzuhI8pbAmLw+G5+a4IfvwPIpS6WtGexL9NS3c4X0pYDQCVtK4DHuBi4up8IEsGOWbLljooekHUIYcd8xcnqKcj2lbPeS78VDP/XgdnKdIIu/j04E3ra0qGfBWbyS5JH8K+OuO/wmqkc3X+SJdToXYmR6kpYescS/LA3buna5JTR1rsQmZ2I06RM3JWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxCsFErulNbPOxCKbF3UavilB4wcwM+IwtZ/BHwWHH4=;
 b=Js5/7HqYShwXjneNtd826PZRaX8KnnSTK0pXw3I39NuksPk9ZDyASfZBkJBdlaCDaa+jW3mCBjFPA+boAWvJxXReL27nGbGwU1KMYPSScC4rZAmSu9iaOWuTSG2OAgB3uaapO8dLPbaKylOUUw8gCccbWe7tT3vcvHewqTZWbSC/D/8RXBcSrFe+OTjkJ3/5q2cT0j8r9oO3QC9fbvTnuQllitnJxGX8GhMDDO49HNbglWfoDEfMct06FfIsAqZYw8CqsERE33hb5t/vUa+EVMl6wxB9h7ih34EAJdMwu6DSxMXu1ulepbzJQqNuY/Lstk62cn5nEAh/L9Q/kHSQJg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8715.namprd02.prod.outlook.com (2603:10b6:510:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Sat, 7 Jun
 2025 00:11:16 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.016; Sat, 7 Jun 2025
 00:11:16 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v3 12/23] vfio-user: implement VFIO_USER_REGION_READ/WRITE
Date: Fri,  6 Jun 2025 17:10:44 -0700
Message-ID: <20250607001056.335310-13-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250607001056.335310-1-john.levon@nutanix.com>
References: <20250607001056.335310-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR22CA0004.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::19) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: 143caafb-a789-4d10-fd15-08dda557d1f1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T6JBd8TR9BFYjHwnptSlP07vsIEeO1KDsf2c69bEVgfKPOSmEjbIv2gt5xcF?=
 =?us-ascii?Q?GSbd1ZG4HIemgU95HaqCSHFh0NfdPPDDK55QuuDsB0m/64YKPIjJsjpkqHki?=
 =?us-ascii?Q?7s/haACjEbfTSYEX7uKqI4ffat1EyUN/pf+kCRii2YR8ZwjF+DSTjs0WN6f7?=
 =?us-ascii?Q?YRKy8F9eXSPQ+4prdv9wjZ7T+n0K4puIM8K5w7w28NauMW8/j848tpqarvUo?=
 =?us-ascii?Q?pd8aY5IUUxTXqXQ5e92ZHjsTE1draDncwpeXOlxL2hH7A/IfbIw5VZRWpPQF?=
 =?us-ascii?Q?GXFaT667xd1SikqKnQSPFMbqVrsBrUDv+tiRvCwk8JXBGGEZ/eWLNpcDyHYj?=
 =?us-ascii?Q?PeCauWVQ8oD+gk5HTPlE9j7pkGDficINTC1SK7qnkvCKoD3jIdFl1UlWQs+d?=
 =?us-ascii?Q?I1QDBi6rNScdQRx7u00VUrHck3nyYk2hkUW1flkmd4wzp9zXWwp4ok3aswW+?=
 =?us-ascii?Q?VDw7MWxbVTyCjD55uSkkIXy5st8CEyvTRqHME3ATbruFyTUxgZhi9lcFJ/a4?=
 =?us-ascii?Q?asMOVEBuGBrjp0vVmAJUZXsGMiEhr0oitCGM4/WQd/JTmuNxr62UMhl6wuRR?=
 =?us-ascii?Q?lnX6nETF1bIGlHKMxBcZn+QQV/j1jzpxjLAHfJ8Le31p3MTASPjfyED9S3aO?=
 =?us-ascii?Q?wfezAHnaZy79V9ZDF8g4NvbDZvQllQdZU5t5qKlZlucULqxRInfgHmSLDq5I?=
 =?us-ascii?Q?cW/Oz5Qk1poOG13f9quH72/6zO2zk7arSdFUQwmNEYKjAj3OYIgBTHX5xBPz?=
 =?us-ascii?Q?5R14+yY1GjpRZlnGE39cF2tSAbxFX5eqENc1nkFq2EFL/9wYJ4djW8urdzuH?=
 =?us-ascii?Q?wLlQ3H0L+2wxAoJYaYZJlj2Vh04osZ5oROMbpFSeazP16yGicBHGDQHM4f51?=
 =?us-ascii?Q?5OmJxRNYKxB+j9FLUYCNtw6tgUdLiDicRvBj4ixizWafordJpyI2UqsPCnh8?=
 =?us-ascii?Q?NrADEFGMeuCMBGKo15YZmLy7AshGUtT89IoSItEpPzvviMyQM+1LQfn64xJo?=
 =?us-ascii?Q?ypcC3hBtbwx7sed4VRtnULUt9QeonUxfki24OekJbjMVAhT1h5hkuYgstfbz?=
 =?us-ascii?Q?tO76f66fWQFXyoXXrq3o4K+WAINyPw51pT4+Mh8bH1ryA0qFNSWHmapyJFCf?=
 =?us-ascii?Q?mQGWVgCD1Gd4pG45i62x9rSpEfs+txKFfLPDYHOPKVv5m2TWe5BWpEswQ3Yu?=
 =?us-ascii?Q?GvPhrKE3y8w52yJvtgw5KWipq8NmKKVVgqM8dsQ5mm1m9kmgw5Dk/yFhyYhn?=
 =?us-ascii?Q?3r6MSrI6TcfF3YI8iZ/wkEiRcAqFOHwKVZedao2DzrT8m5URUsjkZMgN82YF?=
 =?us-ascii?Q?stYN3Bv1CNHMazl5rZPi9LmD5ZR/WwKdN1lqJii8ay0v25L0aEimNe/mBhJ0?=
 =?us-ascii?Q?uXEjfHtiJdgF6pWp+cGjoHwrLJCv+FRQmiaK5J8k5m8CEXdI19wo2p5RGrin?=
 =?us-ascii?Q?h2Kq7rc9kEs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kWOgkL9ZSJJFHMjQJ1Eggz2k3jF43CG47Zo736xfNgw4X5dA6aNnn8grZaCe?=
 =?us-ascii?Q?ga224wrZ1TzAgNiKo8WNs3Y23xuVoBDM8/hSqORFxEtZg5QuxDmw4PT+QbeC?=
 =?us-ascii?Q?RjYQdcRwQsgXt8v15DqzEx02cCswEoliW5220N04EkxgywNbm+nmND2xWiyB?=
 =?us-ascii?Q?alC2zxPAN/QVXyd1hJcPUPPQzbjMQRUJiHXVx3IC6ykWhp0RqQlojpuSSSWb?=
 =?us-ascii?Q?8wuj5xPkQd67aoQ0wmJeHJhY0WCPWixutsgMGGfau7ogDVH3FoSML4Sk+4ua?=
 =?us-ascii?Q?fdr2yBrq5EGdV3VmYHNOg9QZj2YUdjAsjjMzfRdzVKUxJv6dij0R1OuK694X?=
 =?us-ascii?Q?kZsuuBNQaBWGvGJ58pTZZNaYkcLz+pVywu/0yMC1jkMU7xhbjr64U36KD5vT?=
 =?us-ascii?Q?C6LT86ywP+jpWHVZMzQfxSc2aAbNogtmGn/4daJ2nX3QgzZNqKJuzxLOFQ1J?=
 =?us-ascii?Q?t2RK32lZVM1n2xSN0+1Zh3+6B3c9zySA7jhGiuy2MyO0BwRtOTsFQbY3TtU3?=
 =?us-ascii?Q?Zt9x4iF4vEAM16tPZpFY4U2DWwFUviHcV4EoaMJI1z0CNOWgjASQ1ERj/68e?=
 =?us-ascii?Q?eAghZvK5oGh3ZZ2YN/m6ackpGN6vcVce+svQuuCaa7vgJvD2oDxPeIwNgQXe?=
 =?us-ascii?Q?/QrEPW66xWN/guaITNynGICoBGPylWWq7B8aO+1FtieBH3C8tLr5g53Wl1fe?=
 =?us-ascii?Q?ncgMpNG951RZxikcRrEfO9MFToEP4j3ZPqX83kossw+0tVHXEcn6wCEw9p9H?=
 =?us-ascii?Q?chtIeenyX3IwX8RBAobQNPa32SO0LUSt27Lm1eExsTNpGYom6yvKU37+V72f?=
 =?us-ascii?Q?1g5bYpPqKn4ugnwLVZyy6wp69cueg+V1pz8J8HSgjo6W8tUJEWhGGY9NaUsZ?=
 =?us-ascii?Q?alSmbTyoAALw2fs0xWcoEGwbiASNemJolEAcoXUmF9lDAo4lT8PZF4n8zBRA?=
 =?us-ascii?Q?6D3paQpycWdKNmD+1cyT7dwiG5ObuIt8t8NlCgk04N6o8zlBPeV9RXNMRjMm?=
 =?us-ascii?Q?oJJCVfpZfhzQcAntX45llREhButds8NXkcIM6j15esqWOPK9mbBci1ccOiNc?=
 =?us-ascii?Q?RD55eqRB5faj/gVvliX+rzr3Xn7lehR4rLUCIsI6E+BRaolWOJ1bV+vcHioY?=
 =?us-ascii?Q?PufdIov+t2nO2LwsPdKG6sDxk6GFMRTn9B+Rtvz/fL4+K7JGw/ZSe6mI5HZh?=
 =?us-ascii?Q?a57tef3TaojYvi7cf0yHKrPARS9es+TOMkekXY5O4Qq+HQ7q2x8DFsFBEnSK?=
 =?us-ascii?Q?mBMvBNPbkXp5rdztuavyMkwCdtIJaJPUq83KeU3qA3gC+bRwYgGyvhxrB9qW?=
 =?us-ascii?Q?J93r/x2aSQVpQXu/14QaKwt5rTDO0JhZInhCkkOqi/aUtuwOZBJgXffFl4pR?=
 =?us-ascii?Q?ccA54G4zN2JRb+/5ZU3xWUFupIs3ExgY3/zHlALRY3tSUpLfXXTW7ApGLy8X?=
 =?us-ascii?Q?dKx2XmsA/eS928ntzGKZf5W7LH67lPJsM3PeP1nygA2ykgoh2NeKnU9bLvEO?=
 =?us-ascii?Q?vnLgUMf17JQKuABzKTA0D1zCCTCRUdEegY2aQwfMyq+fSgnRLI5vwFGbWQ4c?=
 =?us-ascii?Q?t+mnutcCy6CwNEukru2SZb6q1oXPqoQVEW2Pmbtr?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 143caafb-a789-4d10-fd15-08dda557d1f1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 00:11:16.1033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2n4ed4thEmDXFGsBMfBheVsybfazmgCWlfASrxqk1sJJIfiPhH9Ozo9ZfnOpWsdljRt01gdxzBWkgUWwwKdcbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8715
X-Authority-Analysis: v=2.4 cv=cpSbk04i c=1 sm=1 tr=0 ts=684383a7 cx=c_pps
 a=kojefl/8vcI7rOD5WQpBNw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=lEmlVuBv_BsZ2DPd9E8A:9
X-Proofpoint-ORIG-GUID: TDq9rpSTV7F_B5DjjWccUbT5SuCzfjVt
X-Proofpoint-GUID: TDq9rpSTV7F_B5DjjWccUbT5SuCzfjVt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE5OSBTYWx0ZWRfX5cv4JKSMVuJC
 HX2ARcyz/DUkP23ioXneAk/t3mi8xaqHFXxe4y5usXvi0D8WqLCw7TAWwYWzV0qfTlyiX3rrR6E
 6jULGxfJAwDZ/xslepqQgST/mVRSu7YJuI1RJyAXIV4hiJhTR3/gjdy+7ZqIE5l5B3WkyfyiU8P
 35au9Dm+kvDeDjVyjgx72VOAnNJWfJg422Co0/8cdh/8ZeconTJ1EUvXxzUlD6VYJwz+XbDG+W4
 4idePTPwdDJm4xpV8oXXP4yPSmTjKbYCCEWJ3lJGYtKUk+wqSBhJcTzaQOR+0mIrvU7Imsg3y3b
 Q/47oYuuz5LgUFXVVOoiyYOHzbOUtGk+7Em7zZ/x6y2gs3vGz4vedIIbu4wcFoOgAZlv3IUHia8
 vt6Y9bOoSuvJmjH0adN56+PPjuQVBIwXuNeF4L8rnuu7KFRfiR27H/4kur88Heqy5qEx0lol
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_09,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/protocol.h   | 12 +++++++
 hw/vfio-user/device.c     | 67 +++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/trace-events |  1 +
 3 files changed, 80 insertions(+)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 1878d44c51..8e6ccbe9e8 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -141,4 +141,16 @@ typedef struct {
     uint64_t offset;
 } VFIOUserRegionInfo;
 
+/*
+ * VFIO_USER_REGION_READ
+ * VFIO_USER_REGION_WRITE
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint64_t offset;
+    uint32_t region;
+    uint32_t count;
+    char data[];
+} VFIOUserRegionRW;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index 57793e6b2b..a767e4fb01 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -110,9 +110,76 @@ static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
     return 0;
 }
 
+static int vfio_user_device_io_region_read(VFIODevice *vbasedev, uint8_t index,
+                                           off_t off, uint32_t count,
+                                           void *data)
+{
+    g_autofree VFIOUserRegionRW *msgp = NULL;
+    VFIOUserProxy *proxy = vbasedev->proxy;
+    int size = sizeof(*msgp) + count;
+
+    if (count > proxy->max_xfer_size) {
+        return -EINVAL;
+    }
+
+    msgp = g_malloc0(size);
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_REGION_READ, sizeof(*msgp), 0);
+    msgp->offset = off;
+    msgp->region = index;
+    msgp->count = count;
+    trace_vfio_user_region_rw(msgp->region, msgp->offset, msgp->count);
+
+    vfio_user_send_wait(proxy, &msgp->hdr, NULL, size);
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        return -msgp->hdr.error_reply;
+    } else if (msgp->count > count) {
+        return -E2BIG;
+    } else {
+        memcpy(data, &msgp->data, msgp->count);
+    }
+
+    return msgp->count;
+}
+
+static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
+                                            off_t off, unsigned count,
+                                            void *data, bool post)
+{
+    VFIOUserRegionRW *msgp = NULL;
+    VFIOUserProxy *proxy = vbasedev->proxy;
+    int size = sizeof(*msgp) + count;
+    int ret;
+
+    if (count > proxy->max_xfer_size) {
+        return -EINVAL;
+    }
+
+    msgp = g_malloc0(size);
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_REGION_WRITE, size, 0);
+    msgp->offset = off;
+    msgp->region = index;
+    msgp->count = count;
+    memcpy(&msgp->data, data, count);
+    trace_vfio_user_region_rw(msgp->region, msgp->offset, msgp->count);
+
+    /* Ignore post: all writes are synchronous/non-posted. */
+    vfio_user_send_wait(proxy, &msgp->hdr, NULL, 0);
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        ret = -msgp->hdr.error_reply;
+    } else {
+        ret = count;
+    }
+
+    g_free(msgp);
+    return ret;
+}
+
 /*
  * Socket-based io_ops
  */
 VFIODeviceIOOps vfio_user_device_io_ops_sock = {
     .get_region_info = vfio_user_device_io_get_region_info,
+    .region_read = vfio_user_device_io_region_read,
+    .region_write = vfio_user_device_io_region_write,
+
 };
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 1860430301..3f5aebe7ac 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -8,3 +8,4 @@ vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
 vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
 vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
 vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index %d flags 0x%x size 0x%"PRIx64
+vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
-- 
2.43.0


