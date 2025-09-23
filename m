Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDD1CAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 13:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13UB-0006vv-FR; Tue, 23 Sep 2025 09:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13TW-0006Oe-Cl; Tue, 23 Sep 2025 09:54:35 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13TS-0003ye-Qj; Tue, 23 Sep 2025 09:54:33 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58N90Uv7612415; Tue, 23 Sep 2025 06:54:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=RJ52FPGx+EDlkmhMv7Obbf60XihqX0dEkld+1aPK6
 tM=; b=nCVVwKSe1bVL7oFjWYSbo0zbttJdoR1WIC43KCBtOCFmsUQelf7jjwqvP
 am40x9sMQlD+AXiRNOC605X1edhuEXuxTNBB8A0p91uHFG09V9/0nFHYtX9R3GJp
 gITPQwCrZUaSiLVlbZms4x+YuPfpr5aDJeFViE8Edj3Lr+p0torVAUJNEHG8Fx6R
 FX0+XBRXXKWbAto3ScvyBXsffC6//BmYJLBDENHEp4L7v3RCg2w2GI9gbqRBBeeJ
 6GKyPf+nUeiDYiGHa7k9WoT5DAjyVtPnnaTkYQVDvzAAlVj0umusdhqMWF70WpmG
 q1AhGfjs38P/UWJjkbc1Ezqg3GROw==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020078.outbound.protection.outlook.com
 [40.93.198.78])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49bfef9q79-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 06:54:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMak6Q29VShQWxSicSX556hgaypSpFnwJ34rAogycf3FX8K08LsoIlQHo1c0LyZO5698nMLVdGmNbGJCdsu0rFKeu0XblJkbk2dNk3C+44wQSGKhMwKa7iA9wn65JTypnt3cq4Up1/kDN2kBO+A7Ea9m3sAU6T1ZSj4UIcdG9fgY5Va/fvjaOczToqNvlCsR92pFgLUh87f6FX+pxWyisfzYrPJNwKDa1X00ZesS5Da5PYg5Pd24hBseBPtrimqmbSKafq7IpaRFWzhvnxh58DalxxaROuwMdh+/2kadDvU19FVAECGCJQLmCGpP1VcQDAH6VuEX+2MUzDiHUim2uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJ52FPGx+EDlkmhMv7Obbf60XihqX0dEkld+1aPK6tM=;
 b=kgnR0TDb3C1jzPWI7wgV0sBIMmuXOlFW6imqwXy1CidDAXoZrLZ1vdIVr+F/vVDoO6d5qiaRHQe91JSt3QBsfqdJjE8tvSqhgjNOzcwbL7lWibEjgcL1SEarEQhbuVt8/znLDQ7uWlV7y5kQIDyzDq2YWf4+nv66QMJ37WRVu+vrs2wwmRI5FOlscpfPGuZ5YnXDLAHKgSW5e3gU15EGWZq4ueZwzekoqGZsqiffZbvKUe5RGP25s65qem9MaQc5l2+ozI5z1yzjOy8h8znCR3vIPE0Ps331dt6p15dqyzNa4gOTOGqjKYLhE8pTr/PU8Sc9N142873wIfGYX4VjoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJ52FPGx+EDlkmhMv7Obbf60XihqX0dEkld+1aPK6tM=;
 b=RMJS6Jo/NDg8KV+ierjzfWelXeXkLGoCKLk8vk47H9OlJ/LUxgbtyNkywRfUQkD3OFPP2+JS9dUoyJPTgVy/EWJ6GNJYs6E1/zjZClZCnTHrDij7CBP+/HwvDVQSHs0aZcwNYhrXHhkfVjJku8k4If5NSx7TZIYkdzNvH0Rxs3HItPWpncZGUwjAbBsnEhWDfaTopr6Y7iWoYw1a/Nb9wW0eI1On6+BaAxGsyaqVWWcA6kMN0qg7IWTpy/KBP2TWPmfJHapifWSsfaeTWs3t3CGOBewVXnwHeUu9Y4ZVcpvD6gMKRo6vHUgOEfQLkyAQwikQO+GuvSAQxTsgl12b8w==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB7037.namprd02.prod.outlook.com (2603:10b6:208:206::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 13:54:26 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 13:54:26 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 08/27] vfio/cpr-iommufd.c: use QOM casts where appropriate
Date: Tue, 23 Sep 2025 14:53:14 +0100
Message-ID: <20250923135352.1157250-9-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR08CA0023.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::36) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bfe1c85-1732-44b8-1392-08ddfaa8b553
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|10070799003|366016|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6/pThua4OamFJuMeZzUx7IsfacJq51jOzVsT2s1LbS7/yii/SCR9eKJnu4yI?=
 =?us-ascii?Q?RZq9U/5D5sHqjakH9JzThJq5rfy9hi99+kbWOgde5uGIhsDI2WctsmSoR8vf?=
 =?us-ascii?Q?lzxcva7GD8HlFGS1W8febZCpVJ51x2y6sPbLjfwnQE6OhRO/aPvq2zDSi8F5?=
 =?us-ascii?Q?BiV56M8haHLK4KdnEAr4T5Xi0iwlvR3WYqZlVx6N+wqGfe8Dkg6QOtgNC0zn?=
 =?us-ascii?Q?63IeLRnSFx0HTLK4rhigC2c/t1fyKhTtfrxneK9sl6pBI5UCFVBooFxN9kfZ?=
 =?us-ascii?Q?NvTQRIRsLLbID7mg1/9l/I7NLJcQ30NWWZzc7UwoLlBBWlNE0EAtInlG+8R6?=
 =?us-ascii?Q?F+BsxvrO4sg9llGJ26wQ2XFeB+TY8med2ZKsgJnWIdL1GE0XYegjrAgHanD9?=
 =?us-ascii?Q?KVGTXr/uIcTnibpc/fajhij+eFc0rLHuZPrUTN1hYOIAn0UfHUD4R/VqHXPP?=
 =?us-ascii?Q?Tc+cvNwt8/mpvQtU5EqJvuunrkGUCYkydWYJbLUpyzY7ktlTlJ0peiocrYIb?=
 =?us-ascii?Q?7DQTnCifNZLO9XElbk/PtMNJ7ttjIj40KQl5f5BCMzLrCzDccERKrkop+CS0?=
 =?us-ascii?Q?i6weG3v/uC6nQ9MkqIl7EfvjE+RJDyLReXKg5+xD0gAU0uzgxpydS842MKkn?=
 =?us-ascii?Q?Qj9JPYgcGyIRSARvA9gNT8rGYmHG9ZjgYLRxnHME2RZYTGi8FMWHPjJsEoAE?=
 =?us-ascii?Q?1El9ys6tt/hwZ6vOgA4tSYv9EBlNS0agl8Caf0C7NmcpoZPfalCwbRSC+2Vt?=
 =?us-ascii?Q?hOCF+SCqyPyluNVteglDDdxjyr2aQPmJpAeKM6DxTYDAneMi5XVe0uBqNEYd?=
 =?us-ascii?Q?DZ57hZycafPrxIbDr3WOjcxJYOzsFcKE7/KydpwsXGMs5WmswflfNmEWdBdZ?=
 =?us-ascii?Q?awZrVzE9JhcDCQArmxyN1LyB4VJNT5B43GnBXp7Dd+EpR4Jg/5GTEWhq+iqF?=
 =?us-ascii?Q?TKOzx5Purs0kP+AxJtzX3sm8yG/LeqbIQP3YTBmqZ+TYF+CtvtQWKNZu/GKC?=
 =?us-ascii?Q?2002pAoLTuFQaBccXQVsHZBgt0aW6PPMrdPiSCu8K2+wwCvJ6zOMsxr/5Eu4?=
 =?us-ascii?Q?qwWENJ/O9bwV6IP2VrofCmwEwMic8kbqEwjvjaT+Du4LYsXVNNpuslImp8Xx?=
 =?us-ascii?Q?LuW6gVF3sG75CsvFDe4LYvJZXVYR3DI6mp2LTq2WuH6EWdLxlk1S/ujOpjdQ?=
 =?us-ascii?Q?fX1yOChbACPhh8NpCXq2Arh0KTUZ3URBqPKpqwp2EQ2oN3vEgGBNiWB869J6?=
 =?us-ascii?Q?mkHekmSBiF+QJRUvDe/bIRbcycEkMVw2kVGgSaMJuYVTcjh0HkNQU91bkWXy?=
 =?us-ascii?Q?33PdIysqF8O4qIPR0GrGAoZ0XQ76emDUNUfWYYOJkQpSUdVA/5rCtNwHVBTY?=
 =?us-ascii?Q?yIe62G7CiRDnYVzjh7FvJsH17dR76pYlkHpfgeCpQfjvQ7qzdts4uoEdYxvZ?=
 =?us-ascii?Q?4i7dgih7u7iH9bZLRB56ypT0hDJxXN9C9StJ4ei3rnKfnqiAJfSW7w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?45ye6fN92EflFinh8puF1/MxLz6dkI1rTzpyhFSTME9iPOW27jTUMOUnvxYv?=
 =?us-ascii?Q?Xl+X6BS1uPJ3bmPwYlfNLOWlTxOMEfhoYkwxYNWcpuTWpuUlN097wK5FQUT2?=
 =?us-ascii?Q?Ucz3XS1gVRyaTEuX4bTU2Qa0BWaInGnrSmK07fWjPigpBF46TdWaYjyLVAdC?=
 =?us-ascii?Q?79LDgEAgt2ut7t/+xmonJWs9gBcUUZTpoknAbc2Ycufvgu7rAVAldKpHSaYq?=
 =?us-ascii?Q?zxbjMZowQQyuoIp15Gc/CKyDn0t/vU/qeZtyA6QADJoKZIIn9qRpP+UednIV?=
 =?us-ascii?Q?04JBrb/YeWrN0dP//fIVEg7Keel5H1ckT2oRX8KCG1McTI3H1wQmy1Z1X4+7?=
 =?us-ascii?Q?fPjSltyKXuIWGF5hOe3X72I6FApqjnf07r03H1QIekHDTbYKLyYN5it0Mrl5?=
 =?us-ascii?Q?DTlHeiXEGNXrXBzHwJqVmPYZFQz6mvtCtisDQdOaxoYt/s9m1VeoCgD9mGUp?=
 =?us-ascii?Q?UAhqJy9HC6vYQXl1EsQdsooyaYobfFrPVC9wmOEzGPj7S2IU23Z2fEETUeFP?=
 =?us-ascii?Q?rel2x/hiaI6gdiNuFVVVaa68bM1qI1aI545SyT/cuarKEw5F61I1UOlPl5Q7?=
 =?us-ascii?Q?WD1XE6yMvGfu34l3JvtNz31jq3WRk104qOiicdn4PsQ+IA1+0fL3W5YydLK0?=
 =?us-ascii?Q?p9pIJbUf06ORY4CFEboeOJ0lmXtgKY1Zb9T1sEYjIRbCDunTxsH+e6UX1ia5?=
 =?us-ascii?Q?Am9+egGe8QuKHgBdgN49aYtY7H1nDUuOCIpXM4ywW/cti5JrzI1GN82zHZzY?=
 =?us-ascii?Q?oNgFGdSpJl3hN+AUXR6u+SarPwvRRX050qmgxjSrppwC/WN6PPpFhCu8OTXY?=
 =?us-ascii?Q?FBlkPHJnCHNMf5+wUEbFTGU5+bYFu0ARAQDZGOg5ANOojguz+Dmlt2PJQQiG?=
 =?us-ascii?Q?US0ByFmkNnYEYn/M7OPLamoqUNlwondud3Zq+FO9OYjXpfXCeKHFPwmamGyN?=
 =?us-ascii?Q?FMGsK7poXj7rMQJjKOzabGPfp4wR7Il8NZ1nWmG6aK/xzl+oyUc3QYH/OB33?=
 =?us-ascii?Q?luDfkDzhaSSI8d9jWewE0CHC2l/D/DybUeEzxP1f8dTjGnDl0Duygj5ixkm4?=
 =?us-ascii?Q?VtxSWSvQWUHoKu+Ge2xlGs2WdvPHx4ZFirQktvoc1CnagE+Pa+IQC6Ei6T8I?=
 =?us-ascii?Q?MPmSqwf4gusmi/nRGijXwH6wDcQ2QeSuzU4dtC31oe5wKovPVO9+9dQF4/ES?=
 =?us-ascii?Q?DGVX7xJSnIFlu4s7ucWsREeke3u6lCi0mmmAEPeDQBspyPmUTeehyUC1MbWv?=
 =?us-ascii?Q?JuoBlYanDrFYbAd47e8TwpuWUEEMvRTCQrGloOWUD8Q/z+6piBzOEz4e1XJK?=
 =?us-ascii?Q?zHFQfm0NUwk91+OIqKV4AKGNnmn1J8m8H6aVbv4RxYNefyK1dikUMYi8ehGk?=
 =?us-ascii?Q?iIABM38ZedtA3nUoWCTJYtHdXAZMIntBnIiA+PTHPxIp0U2WtyBrW11P59Yd?=
 =?us-ascii?Q?eSW5ko8rWrwfB9sXWgwFbVi1FoldLxKt85SSFqUF8m82fE/5MeVneJ5q85W/?=
 =?us-ascii?Q?gUcT0kOGqlXqj6ZXP8jmk4btxymSMrVfphXz8LWAj3ztGRlw3rH9fUBhHYQO?=
 =?us-ascii?Q?sWcbslzNFgNXE3b2zYe3G/51D2QpfZqP5OUosEFaCboWr7fHva5hTUYd2JL3?=
 =?us-ascii?Q?3caC1BqtEJz2hHvS2a83G568Q6mmuhn7t/iaMv24lzIiMBv5NaJ4WZlDxJ+o?=
 =?us-ascii?Q?mYAlUg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bfe1c85-1732-44b8-1392-08ddfaa8b553
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:54:26.1537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PFBUVYQEsFyuRD3Yni7tFd8koiN1h4fwGVtJnqR7QZ5pGHLTg4vzG+oXWLk1ZmMIkjXWVJ2kvDLJ+D0RRWZbf2G0Vx6H3ydVXJE7NBHBNbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7037
X-Proofpoint-GUID: dX9ukmFWUk-OlP64G8fPUNyYQrGZJcG6
X-Proofpoint-ORIG-GUID: dX9ukmFWUk-OlP64G8fPUNyYQrGZJcG6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEyOCBTYWx0ZWRfX0jvcuxf//fbF
 u77utQjD1kDv2akpLkkGMVxLBn/vk6dviMvLyT55+UazNZ8MAwHgIYJLVIjwX70FwV4C0VrBkCR
 xbmucGxpDu+Jq1zgnGuypEx7MAGMyhrUYRK47tKqiwFtjG0kK+GjDAV3NfFc+/nEUlRr+ff5n0K
 D752GHpYWCG29+/EyQQ3W+Y4lZcS/PHHipsQwoGaTfDEiNt+YCP8U2Chst/ygOvo+acxj/oQdL5
 cUNAKLKWtwctEJAmWf86ZPebtOGLPEjCsGpF8+Hv61DFej+Duc60Qbn079/aGlSo9129y39knPy
 EI+oIincrYoLrpGYWze6UNV63nuJ1e0+sGQHaaD7ZOfBAFIAsGUAdkDLv1HM/s=
X-Authority-Analysis: v=2.4 cv=eI0TjGp1 c=1 sm=1 tr=0 ts=68d2a693 cx=c_pps
 a=r5kpy6O4d1nOJ9DEYQWzwg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=BBQWohTTSvez9n_Z4ggA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

Use QOM casts to convert between VFIOIOMMUFDContainer and VFIOContainer instead
of accessing bcontainer directly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio/cpr-iommufd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index 6aaf6f77a2..1d70c87996 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -176,7 +176,7 @@ void vfio_iommufd_cpr_unregister_iommufd(IOMMUFDBackend *be)
 bool vfio_iommufd_cpr_register_container(VFIOIOMMUFDContainer *container,
                                          Error **errp)
 {
-    VFIOContainer *bcontainer = &container->bcontainer;
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
 
     migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
                                 vfio_cpr_reboot_notifier,
@@ -189,7 +189,7 @@ bool vfio_iommufd_cpr_register_container(VFIOIOMMUFDContainer *container,
 
 void vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer *container)
 {
-    VFIOContainer *bcontainer = &container->bcontainer;
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
 
     migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
 }
-- 
2.43.0


