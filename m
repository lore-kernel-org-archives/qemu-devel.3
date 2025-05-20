Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAFCC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOWP-00039v-4F; Tue, 20 May 2025 11:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWN-00038f-Ls
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:04:47 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWL-0002Nv-1R
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:04:47 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KC9YJr030516;
 Tue, 20 May 2025 08:04:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=NPawAWoNC+uXrHhvCEVORa5TwP5yxncau6nPhBYV/
 2c=; b=a0IHxPlnRGf6r+H129oSV95Igh5cPmus7gbJKH0l2YzjN2z2ciYUW+k+s
 d4l+lsV+bQyuDABmfwGZd2V3NnmCyBlo+q0cBSWsYGVLCpfS7Q2ESbTCrLDdarAv
 U3w9e4lzr4x/RBrqz7M/xq5EGHKXQQIQb2QlT47/Wh0lauiJPxi6si4LpTUl52xR
 jWAc7cVcCKUDcfjnP21v0zDeEzqVbneHjn/zMfQPlIJG0NJXwEY8+L9pK4YwJsuI
 8x7mEDkaV2RRdPC9aR/qjeBzbiZSpXxvf2SvQHNLnjF5bVuUFfPWkHOEhftVDFus
 Ua3AuoUhuzD2CRF5sLLUtKelk+QfQ==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46pshhebvf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:04:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjbKtMQSeZJWbQjdDPBJiTwkfXPXvbLhJGBWQek58af5IZtjtVKzu6F+37KFfmZzATTUCAgNE16j1p16wFjit3aORpmdF2Zvqe+B5h6RcGRSJaW5CfLN0mkXx9ZKbsVG4iSxOwu7TM7/wb4y/OqHWyVoyo8im2mBrpTl8LyzvzZffYisqNGoTopgk+mBQUgoBzD3u3/YCVO/V5g6FLc6ZH1heevTNwz1/rVK/VlNgwSUG75LF0hwwg7gwoumL9VHL9cyp/mgpH3HgQhtFbFQn6/RLNtiZNuRbu3RLzm8NmFeYbTWD58DCwTv6qbDKG6TSIKuHygzK8Y3f9h00Ry6vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPawAWoNC+uXrHhvCEVORa5TwP5yxncau6nPhBYV/2c=;
 b=bl3fa5pTlUsIjho4nJM2jP7NwYwciDzUjoK13jiAz/xePSmz78PUQV7lleeV9xifOwiRxmqP0gpQpeA/M/WFNGRZeA1re/eNL91AjX9PZFBpIeYD/67LsUGTNU3SSwGm77SUGzegkVMrgDHuNGgPSHX3bPC1gxtuqecTOXkKDLHWlQfefsvjEwyTS8EGE2ZfrvWW/ccX3JmeppIHZFc0vNRvRJZ/ajz+u1zB1CY6i6tNWzG4wdSVPgSUrDRq/LKV2TMP4RZHHzI0Ou+N8b2gM78xk714s2+LkSoVFMebaiOmdXyJzcu3BfzVI+WdM6YILTZPVyWJiEay4n0RUHpo2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPawAWoNC+uXrHhvCEVORa5TwP5yxncau6nPhBYV/2c=;
 b=tl6RWhtsoyepJIn2nfc8/OciB0mmm3az5VxiUWQgGRIEeoVIOxO/n+NLcAm7Zz+vGjeSLVdRuSnQPw9hiWTvWwwGaOieIL9cOXm2JvuBEUbVIeLrtTsAppGPV80vTTtRSLM1PiYnSLATvFuMMg7aE6tT+g0ckK5Z+orXPW8XksVAMcXIyHwisueSbZnf+QB+LI8DN1h7fb9CQBWD6Vw4I1xsItTkpFg33i6I7qjGXKHifLCpXgbY2B89gy1rkLzu+d022P69JrLMk6dcvxb4aFwni431KPdWRXmM/5bFYJ3fsDhG06WqCSlYla0Q6EHWWrJJnsMpvTd7rsxg5cyH9g==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA1PR02MB8462.namprd02.prod.outlook.com (2603:10b6:806:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.23; Tue, 20 May
 2025 15:04:40 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Tue, 20 May 2025
 15:04:40 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v2 06/29] vfio: enable per-IRQ MSI-X masking
Date: Tue, 20 May 2025 16:03:55 +0100
Message-ID: <20250520150419.2172078-7-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520150419.2172078-1-john.levon@nutanix.com>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0021.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::26) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA1PR02MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: b14d8ea1-1325-4aac-c974-08dd97afa4e7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FI8jcLDvKKtq7UMh6pSI0Gkb2ECk9FV2Ykrm51JGGKlbunVNHI56eoZNb0+T?=
 =?us-ascii?Q?gGRaiIlaTzlv5Y3aBSz52DfamDFh+afszmKVb38wX0t6WgoXCIuqPXmF98NK?=
 =?us-ascii?Q?L/nC4Wdy6mZPjn0QvfIllFtsIf7y5HkTta33OO4xyEOgM9hgxZQjhQgejO8I?=
 =?us-ascii?Q?A1QMZQ8bnfTtBe6MxaN9UtBSrsJiu38+OHYDcsgwxah/eHv2Mv3FEZn8fBNi?=
 =?us-ascii?Q?eHAasZgqg9Yy3TP2pAX3PfkJpBIfV9KeHqUUotkNXR4mUy52cqCeIfmeLDCf?=
 =?us-ascii?Q?QG1xRW3Q0iqA0389IAPQ4X0S2pE5PZdC0RJPKBb3kQhj1em5becfev+okown?=
 =?us-ascii?Q?OkaSgL8QNXT7/nVW1KElJPjxlaCOMQSY9Ue5EB+T9kCYwUH2uNE2VPC9OXzV?=
 =?us-ascii?Q?Nfhse7VmuVzdXMxX9YQ8XGUbi9i0BWnlMbp6kRMmvzWrO+aAiDJbpCr3bIWY?=
 =?us-ascii?Q?nX5lnZ0WQlgnpBlVXpDQnVuCHzpZiRRsgq7+Hzq6ED/IWAKpuuGmLKl1gw7R?=
 =?us-ascii?Q?qKSG8rE2KCc/zehSAgEcCVLS2C+5+6+C8yXbv3GQbpmWMh0XOf1A0Qq5uJUS?=
 =?us-ascii?Q?F+YultvByIf2tsCSVnxCFfsS+/FYkJPHKmS9GAH1GkcdclSc3ucnJYz+eMM8?=
 =?us-ascii?Q?drEI3LjpOI14bFzhXLVi/wUJZ7OndxgxGEol+egiWd9J0IKPkAzZdKsBHHz2?=
 =?us-ascii?Q?84X6OZ7h2UOE+nFZIh+uNcyYcusK8JRn3gVe8B4WMQWqIm++5qCoCgBbApGu?=
 =?us-ascii?Q?0JarMnPsZIAbeaK4KHBZnrXnjamTjoN+KFEmYBGCx9Xrmf3e6DYDsKYT1fDZ?=
 =?us-ascii?Q?Ry7idiekt53y31JeED+6jyXQg97hEpeM05veZ4ejutgwKuRygnVZgeW8IdM5?=
 =?us-ascii?Q?zs1RrlV0UXTyjMRtEnAFXVCHlHLEg6d7zL+62BuM2PqZoOfL08P+ooKM5+aU?=
 =?us-ascii?Q?luPNPoWlW8PUjscSXMXWEjLxMgCPc4bBtLa1BGE87yOJf6ZXJmXbu3MKx2cr?=
 =?us-ascii?Q?Z3lwGaD+QxwFZQfMqsWryv9TscSTXn6zSRJ/U+7dMfoTSCrAS6OOXkKImK0K?=
 =?us-ascii?Q?FqhZ622hDnOM6AiTOads0IMj57fQ1umgUWPTMN1P4rTHaC7Dln8x5C8+ykSn?=
 =?us-ascii?Q?McxNiwlELvcToQzYSdfuo6+uYPPi7MYTNg6aI+KTlSe5t1MUTIAlGZS22j4m?=
 =?us-ascii?Q?WW/e6wICbOJSDtAAVpvq1r8DUjWfYReulyJjVs8HiqoDC9GXEWIBY+/hWy+M?=
 =?us-ascii?Q?nVtUVSfVhud2j3PBou9qtV9oXjOo5N8e/E2ukC9PUAofgmg/ELKh1wiI3WnH?=
 =?us-ascii?Q?MYZRKs1BwYcxWOHgwg40Ai2TRqAP7zQ3g/+/pIC1l5MqoB++XjIL0bexGvjl?=
 =?us-ascii?Q?dgomiGIoCYVRg9D6Dp9gBPyrJwtfdsv0l7XbZ7EIjV4CO9j7DfUlGUfb5ZRN?=
 =?us-ascii?Q?695DOccPYjs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xx/lvPTiBxoDKlKTUx6uH2iPXTPrbrBFdp54VVjYbvNBupE1/4NAPyAgqCSO?=
 =?us-ascii?Q?4p5qvnWVISPPmIq/WLJwV+y0xkV5ImJ8YYGkRmUQVeFVZJlLy1efmNSlnI/R?=
 =?us-ascii?Q?ffmY8j2rDvM3KmiyHpEKDdM5z4f3zcK5cACi1NZ0PLyqHAvdkVfwqCJqbsNV?=
 =?us-ascii?Q?e6ydRObCVNcTqpxgeEdEGbbxIJhoP9mbe+jpQZDxI35S1nedXo3yrffUe9wO?=
 =?us-ascii?Q?eg7Ro9LkJX0BRjNvHOxs1zXGNmqVMHjSMBMKG5ZXSYWPd0uKND2Wn1iTv7K/?=
 =?us-ascii?Q?u0Ma1o8AdeJrLD7A4eJT0llffPUwF3zLxMkqSrk8iN4tm7fxm3vfvxzpiCo6?=
 =?us-ascii?Q?PqnJdKXaTg3qZ6WXPlbTuFe4TVN3bzVPLlQ+3gx+i0pvG710hXni37G2aO0u?=
 =?us-ascii?Q?Zo9xaoMsTfHDInXRowV92MYbim30GDswLFdeULUmAzykmP+U5RueK0QPRjAr?=
 =?us-ascii?Q?qdLjSNrmWzrUViU4P5K4mq1z5LYSwtCAKKyGEo1WMKtHPZvD07g68OR/ss3+?=
 =?us-ascii?Q?/uZb7ibIAPv/dzTOcuPJhj4HWPsiHf86vUVe7XiF/WxZvzXWE+FvyjEWweVz?=
 =?us-ascii?Q?mGqqxBeqw6t3B3LvZQiF3TNuW/e13sGouM2u3clYCG3CpKWFF6TVvoQJB1/V?=
 =?us-ascii?Q?Nd16MEXN/7z2006PUCe/akd0rc6WP8OF4NwyK7lycxGCK5Qj5bBNhixIvVWF?=
 =?us-ascii?Q?4/5nqfjZe5mSoVK0zZeV9Ag//X7ZiJCrpPdXwsAy8M2boZUrpwog8SCySjr5?=
 =?us-ascii?Q?k3nAc4K48iQQ7JFgbSNwJwiB8Y21GEt3Yad3jCHf4RJCdpB14UfOYCO2732I?=
 =?us-ascii?Q?BrpCF+A5x1gA3vuIQ5/DOjk3ME93Qyqet0/4y6EGc2Nxu3ER/KBf5b0dKgEL?=
 =?us-ascii?Q?QztYtFMMTM5WIvVYijnjvo5igMViZLn2B4Bm9+xchBARoBx8tNmmstYdnVwH?=
 =?us-ascii?Q?bOCD429RF7dvWT2Wwn+v5Sj1xjobHHEwlRsFyS7jim0zELlvmW7Ykgohx02m?=
 =?us-ascii?Q?swQzf7lfSbPNzrR5RRK/eqHHfHB04/KBP7eK144VWRr+27F4mIBbF+3OF01o?=
 =?us-ascii?Q?LTkTAIMRLEeNBmolbTYvh2HM1VVm3mlhjoEqb0rKMTUhdQcqWjdnjGAICDBi?=
 =?us-ascii?Q?5LYkXQR4zcHKlbgjARAGBaQ8y8Sh22W++RZ7U1t+X1g8caDojyHhJPmyJBaj?=
 =?us-ascii?Q?MhXqkokqN4yi0JOvXcKflmy+TTdQrXlLu2GfPJczYkPX1Qyjkb6UlCEloQ8i?=
 =?us-ascii?Q?fP+yxNFkiD12GaMvbjyGZlWkbiUuFp82eBaIrzVTT6fWby3IuRZRTzkt4Iwv?=
 =?us-ascii?Q?il/5XcE+TuB/pPHBymK4wmWBPyuEHsiEoVTJK6H0uzzDTtlaJxvUhT8DX26z?=
 =?us-ascii?Q?lroD7rQaXBrP5pxc7rjB7pH2b1Lm9v9AI1azLm/Nir+gVJQYc+sOiz4viDQg?=
 =?us-ascii?Q?ALqWvh1aRIZmAbFcueP4fqH4KJY1QBzbxoB9OJ46157SgoL2QU8wTVPyowXv?=
 =?us-ascii?Q?TQQ3YklRwYYjA4X2/qG2doRqorwjEBXgT0PSTONOzE057I7YNn5qMlKc5zLI?=
 =?us-ascii?Q?F/jSeMSqqp1I8zsRNcm3nd1OLA9chNQH7DBiuXs5?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b14d8ea1-1325-4aac-c974-08dd97afa4e7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:04:39.9591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51ee28L3tOHyrSVGJ8VHr1J3Od2PZJbM93Shz8vTaXeg/MSG4LZSvKKdLcQgS2Wjovva6MalnzEqyeIMSPEZMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8462
X-Proofpoint-GUID: yRPapSqIcVF35bCXkoZutB8GcBs-OhIg
X-Authority-Analysis: v=2.4 cv=SoaQ6OO0 c=1 sm=1 tr=0 ts=682c9a0a cx=c_pps
 a=XlWNgFwcAB8XWrBhwjv7Vg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=_brLm_9mC3lTafiPIV8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMiBTYWx0ZWRfX4fCv7K2E6pHU
 eiZR10fRgpVbiYTXmWu8ukw4gcIy9S87jobk+TsOLq7S5IJx4CKKYXSS0NhQyY/gbTqtqM9OIQ4
 9new8Q/lccPx36D5LRuHqRUt5tLalGt8TlNia3JgsuT59x/3bO5RQVUvkhcaXZ+SC1QLxCPM+Cs
 TVHDea96En8GpgvUt+Iutf2Gy2PQwk0/XpEFa+mZkPLxUheDF1gBbjt+Omt54/5lcB106uEVkQY
 eTZmdIREeY3D2nT6NlkcMj29HNdA4nDNRsXrhEvAOVDY5OFlUD9tl1nYxwODeb3Y4YsKv/wxJZq
 hpQZ/vLO+HuV9UBWShh/M82mgLUub9kA7uWQq9UkEtsE5Ur5zRPnXjzPN0mo5amqMG9XlKb5qEX
 qZ75i08ESgG9JoHsCkA1RjNp/XnfNMyyeXhEzXoQjEkrW42vbbuKq4nxv/tHIhpdGMMfEEIE
X-Proofpoint-ORIG-GUID: yRPapSqIcVF35bCXkoZutB8GcBs-OhIg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

If VFIO_IRQ_INFO_MASKABLE is set for VFIO_PCI_MSIX_IRQ_INDEX, record
this in ->can_mask_msix, and use it to individually mask MSI-X
interrupts as needed.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/pci.h                 |  1 +
 include/hw/vfio/vfio-device.h |  2 ++
 hw/vfio/device.c              | 26 +++++++++++++++++++
 hw/vfio/pci.c                 | 47 ++++++++++++++++++++++++++++++-----
 4 files changed, 70 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 61fa385ddb..43c2d72b84 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -191,6 +191,7 @@ struct VFIOPCIDevice {
     bool defer_kvm_irq_routing;
     bool clear_parent_atomics_on_exit;
     bool skip_vsc_check;
+    bool can_mask_msix;
     VFIODisplay *dpy;
     Notifier irqchip_change_notifier;
 };
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 8bcb3c19f6..923f9cd116 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -133,7 +133,9 @@ struct VFIODeviceOps {
     (ret < 0 ? strerror(-ret) : "short write")
 
 void vfio_device_irq_disable(VFIODevice *vbasedev, int index);
+void vfio_device_irq_unmask_single(VFIODevice *vbasedev, int index, int irq);
 void vfio_device_irq_unmask(VFIODevice *vbasedev, int index);
+void vfio_device_irq_mask_single(VFIODevice *vbasedev, int index, int irq);
 void vfio_device_irq_mask(VFIODevice *vbasedev, int index);
 bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex,
                                    int action, int fd, Error **errp);
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 9fba2c7272..d0068086ae 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -85,6 +85,19 @@ void vfio_device_irq_disable(VFIODevice *vbasedev, int index)
     vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
 }
 
+void vfio_device_irq_unmask_single(VFIODevice *vbasedev, int index, int irq)
+{
+    struct vfio_irq_set irq_set = {
+        .argsz = sizeof(irq_set),
+        .flags = VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_UNMASK,
+        .index = index,
+        .start = irq,
+        .count = 1,
+    };
+
+    vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
+}
+
 void vfio_device_irq_unmask(VFIODevice *vbasedev, int index)
 {
     struct vfio_irq_set irq_set = {
@@ -98,6 +111,19 @@ void vfio_device_irq_unmask(VFIODevice *vbasedev, int index)
     vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
 }
 
+void vfio_device_irq_mask_single(VFIODevice *vbasedev, int index, int irq)
+{
+    struct vfio_irq_set irq_set = {
+        .argsz = sizeof(irq_set),
+        .flags = VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_MASK,
+        .index = index,
+        .start = irq,
+        .count = 1,
+    };
+
+    vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
+}
+
 void vfio_device_irq_mask(VFIODevice *vbasedev, int index)
 {
     struct vfio_irq_set irq_set = {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 5159198bdb..ef38b4692a 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -535,6 +535,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
 {
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIOMSIVector *vector;
+    bool new_vec = false;
     int ret;
     bool resizing = !!(vdev->nr_vectors < nr + 1);
 
@@ -549,6 +550,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
             error_report("vfio: Error: event_notifier_init failed");
         }
         vector->use = true;
+        new_vec = true;
         msix_vector_use(pdev, nr);
     }
 
@@ -575,6 +577,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
                 kvm_irqchip_commit_route_changes(&vfio_route_change);
                 vfio_connect_kvm_msi_virq(vector);
             }
+            new_vec = true;
         }
     }
 
@@ -584,6 +587,9 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
      * in use, so we shutdown and incrementally increase them as needed.
      * nr_vectors represents the total number of vectors allocated.
      *
+     * Otherwise, unmask the vector if the vector is already setup (and we can
+     * do so) or send the fd if not.
+     *
      * When dynamic allocation is supported, let the host only allocate
      * and enable a vector when it is in use in guest. nr_vectors represents
      * the upper bound of vectors being enabled (but not all of the ranges
@@ -594,13 +600,20 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
     }
 
     if (!vdev->defer_kvm_irq_routing) {
-        if (vdev->msix->noresize && resizing) {
-            vfio_device_irq_disable(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
-            ret = vfio_enable_vectors(vdev, true);
-            if (ret) {
-                error_report("vfio: failed to enable vectors, %s",
-                             strerror(-ret));
+        if (resizing) {
+            if (vdev->msix->noresize) {
+                vfio_device_irq_disable(&vdev->vbasedev,
+                                        VFIO_PCI_MSIX_IRQ_INDEX);
+                ret = vfio_enable_vectors(vdev, true);
+                if (ret) {
+                    error_report("vfio: failed to enable vectors, %d", ret);
+                }
+            } else {
+                set_irq_signalling(&vdev->vbasedev, vector, nr);
             }
+        } else if (vdev->can_mask_msix && !new_vec) {
+            vfio_device_irq_unmask_single(&vdev->vbasedev,
+                                          VFIO_PCI_MSIX_IRQ_INDEX, nr);
         } else {
             set_irq_signalling(&vdev->vbasedev, vector, nr);
         }
@@ -630,6 +643,13 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
 
     trace_vfio_msix_vector_release(vdev->vbasedev.name, nr);
 
+    /* just mask vector if peer supports it */
+    if (vdev->can_mask_msix) {
+        vfio_device_irq_mask_single(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
+                                    nr);
+        return;
+    }
+
     /*
      * There are still old guests that mask and unmask vectors on every
      * interrupt.  If we're using QEMU bypass with a KVM irqfd, leave all of
@@ -702,6 +722,13 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
             error_report("vfio: failed to enable vectors, %s",
                          strerror(-ret));
         }
+    } else if (vdev->can_mask_msix) {
+        /*
+         * If we can use single irq masking, send an invalid fd on vector 0
+         * to enable MSI-X without any vectors enabled.
+         */
+        vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
+                                      0, VFIO_IRQ_SET_ACTION_TRIGGER, -1, NULL);
     } else {
         /*
          * Some communication channels between VF & PF or PF & fw rely on the
@@ -2842,6 +2869,14 @@ bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp)
         }
     }
 
+    ret = vfio_device_get_irq_info(vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
+                                   &irq_info);
+    if (ret == 0 && (irq_info.flags & VFIO_IRQ_INFO_MASKABLE)) {
+        vdev->can_mask_msix = true;
+    } else {
+        vdev->can_mask_msix = false;
+    }
+
     ret = vfio_device_get_irq_info(vbasedev, VFIO_PCI_ERR_IRQ_INDEX, &irq_info);
     if (ret) {
         /* This can fail for an old kernel or legacy PCI dev */
-- 
2.43.0


