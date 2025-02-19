Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377E5C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 14:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklPT-0004sN-B0; Wed, 19 Feb 2025 09:50:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklPQ-0004dY-E1; Wed, 19 Feb 2025 09:50:44 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklPO-0007do-29; Wed, 19 Feb 2025 09:50:44 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JBqX12018818;
 Wed, 19 Feb 2025 06:50:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=TF6SxOBcL7NnUxy4Y7t98bPkndE6ynnFrD+nCSwzU
 Hc=; b=OeybuQtnYZEMIv4wrndPH3O48HU/2sClK5Eewm+LbkwC7MdMZIwgu0mlw
 gsIiV9CbbgIa7zUI73UZFhrSpWqFng+scxW4DIcdG+IIjvJsEI5za3L7E0vO5Zka
 VVJYpyzwpI+yle37iuEWsX2A7NmhLBZ7FXi4Aeq2gYf9zxJwKtHQZ71ilIB31jFH
 rZgCN5YnRPiXh4/c20LzUD/xOpV9Ycv4PLN+FlLua2TIm6YHRZSwfm2f8jK1/tzM
 RPECDzZVPzwTpirvTFUGW+eIMzWweCLpx+WLAbPZL1z/j1P6YWoHsZFqHVA6DN1R
 Q2w9JcSSdqN5W4c3BGasCFyjCaeTg==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 44w4basxu9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 06:50:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5BaJ8HM9f6r4fXQ6gE5r6cJICA4r1a+c+r/cfEy5hdn27+7VU0DhHSbIcH2orntuS+3blQpzqGiTK2PtKPQ3rsMRmrnhPWjU6QrWRpn6kqjHe76e6HOhm7YhzhlImuMeE3Oo7EJ1Kq8Dkbcy+gPZsmtaFaipr1APtTh+S39FRgJZ0vFK6HFkybuLfRBmDd+hXYZ2h4Ocb7Td/VCc819/B3Uqpx7pEJS5ZHE/sv3cB/9vIoYaetvD8pNhwigxYJVvYtR4th5/PZ+5ZnUr4iWgVfrTUGbneu1k95X6nnKtI2uYKDronVzd+LhwZtJV+9284V15UGXVyMGbdL06ewRZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TF6SxOBcL7NnUxy4Y7t98bPkndE6ynnFrD+nCSwzUHc=;
 b=bzScnLDqYEEE0pboc7VI3NJyooSpvFEXNiGqp/P8/EGmg7Bv03SNMUYTWPJP0ELKKW6Txcxo9nx95/pp8lBl6Z04uwdXO4loVx1r/EKokudsOEt0U+8oH+Bt9y4UoXjuOerSGto3JGFOuICp/2rQtojiFKwzi7k0GzYr8OhWUNfKnKCT9b6SkZXIecYcEeNFL0Ug9+MiXikAQn5bMaA+XL7I32USVXTxjoUocM0+E1q1uOcM+Arg6OzWzD9PTt4AzpSbqjObMN9wuJrjr7265tbMCNl/jRQ+/GN2kDrJ837LqFZSq3x8Pw9SvoJ1ZjQdaPQ4UQ/gDnkdDrb8oVAYIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TF6SxOBcL7NnUxy4Y7t98bPkndE6ynnFrD+nCSwzUHc=;
 b=pLe/+xJ97BXotDrJGc9Lh8lWFaxgojPq4ojJOWwnBTpGJiAA8Kryd5Dn7Hr4tpVUxFsp0RLeE6ag4nkkMwtOaDJ6Omrs5As4QwcWrZH8LOTUA/B0jK0kfqhiY+LadJBEHSFbz4RvFnXWBj3lqASNUS/+ojZ9wA+XllcCQ60+m2Cv7/UjmU3WxB6GPSFUVJRVXtN/2TyOqs5crV6lA0Al+T0BEpaXntZicaHtH6fc7rpcN+Bi2VMjReXkvSenaOTHhrKN5yCJfRuOzFxVv7WVF6AJyGp2Rxww7hV6Cb+s5N9aIDjXUcJj7BUCoAL1Xcx2fKVhd80/pBwsAfqsMyfoLA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by LV8PR02MB10096.namprd02.prod.outlook.com (2603:10b6:408:181::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 14:50:36 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 14:50:36 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Jason Herne <jjherne@linux.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 John Levon <john.levon@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH v8 25/28] vfio-user: implement VFIO_USER_DMA_READ/WRITE
Date: Wed, 19 Feb 2025 15:48:55 +0100
Message-Id: <20250219144858.266455-26-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219144858.266455-1-john.levon@nutanix.com>
References: <20250219144858.266455-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0154.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::21) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|LV8PR02MB10096:EE_
X-MS-Office365-Filtering-Correlation-Id: f9273137-43f3-417f-29a1-08dd50f4c51f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?obaT+0mmNOSsLnPLUaHzQuwEapY/D0f0MIf22VLZtN4eUUwz39nCwYjiCqTt?=
 =?us-ascii?Q?YPZ43uyNF85UtriF5BnvwCfGT9HyfWnG2fFUxe6jzIKMPL2Umn9k4IPdoWx+?=
 =?us-ascii?Q?lwv1iwKeet76a11vD9t3ewItwQIbGs+zUOYCa4KCR2HuSR3KYP/CPU6iQKCm?=
 =?us-ascii?Q?huXg1Urv3YF3a3Pu2z56vgfcIUTkeAo4ZrQc18k/keQzbn2Al8CbFT7QVHzo?=
 =?us-ascii?Q?Dj5uKlz99a4eztmzvAnF2MVePDZFlQF8nK8p8vqzAB7pHlDB5NM6+y3UsHrD?=
 =?us-ascii?Q?OUhEuKloOSYrrH3z8ye66P5sHerMHmnCKR/QF+9GI50hE0ck1PI50BIHvsfN?=
 =?us-ascii?Q?laHFPKhg7qn4G5ef0sPOtP7fSJcNOm4BgDL5+QpUCwMilr/xQr9iRHkZU6i5?=
 =?us-ascii?Q?NjML4lZZYwdhcrlcibLZ2930ewnXDu9nyqedzyJUVHTo4Mgau9rn8rGsW7fx?=
 =?us-ascii?Q?pmmBhMgTVqyEgvvi7oxd6vrXGwneWX0/Pa/7CmeLLbBpzNQo8QbQHyV1+KXM?=
 =?us-ascii?Q?v2aXfqoPQx/sBh3MLB+2kkYL49l9dpqGJcTyffXRRKFDLrgraTSX2fvXELmy?=
 =?us-ascii?Q?fec/zgc21sLCSM/ThC8B2e5VSOOwqW73BFcjVglEfh4qMwBzgk0ODQjsfdXf?=
 =?us-ascii?Q?hSNsYo48qoV00o6Y8NaduwdN/Mt2V01yNvGr9YjDYrGWhpFK165frNs3dJE0?=
 =?us-ascii?Q?6s7Sgxqxe62epd+ylyWyDg3CSyaktnM+va3WvKVu86VEI5N2lrXd01koCYhn?=
 =?us-ascii?Q?CRVdtiqx5QVVy40Wk6b9EBvVlwkNo7ciFgETU1mC0ZqqOStCuQC4BBwP3dmq?=
 =?us-ascii?Q?rxDDp0RZExNt2EVJ0PX52gj0qWLcRm1WFC1AFAriHO9+sv3lIDvyWfNzBjKK?=
 =?us-ascii?Q?IS6ESoeuApkR6Es6+3O3dhRGSRNakWzR9QNsXAmBJDOJB860qjp5K37PT8GC?=
 =?us-ascii?Q?W1q8D7B91PmTh8Ur6am85zLCN9i+63+v64hsg/jEvOhio5zzWyD3mrfvEnQD?=
 =?us-ascii?Q?a/JHfgqwzcVuiE9j1aQNdprtgEXh/GmppbXcYal39GrJmlmfuPvxx9sgN3aE?=
 =?us-ascii?Q?Uk6KLzCHm/xMQxWcN/tzmNwuYNWpduKSVQaHR8JxZgF9JfH5RhvHMYxYTlQB?=
 =?us-ascii?Q?gnCmrJEEP/yHAUUCtBNx0ORNDgiy85mnONIHMBpJkoA6AWc14HHgsHsakUax?=
 =?us-ascii?Q?30dH95aUxMMVCvKm8scgXMb4AgV4Rq35iR/WNE4lk70uSgoA52APVTfMfslz?=
 =?us-ascii?Q?xidPAwAi7Dxpnm7G47GmZx5tA0slcW9iUWZ1l646WTPv6v/jFejHiao9ybBg?=
 =?us-ascii?Q?zMVV+IHLNi+Jz/OzpczH+9cRPOEP3/psIqLoX7lNPsveJ5+CRaiIYQjjhrC/?=
 =?us-ascii?Q?I3k4N6Pc+j12BVOigQXee+Ea2zBd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9UiahmsCrwKmzTHYqlhbGegJ92EhQRHS5PewzmD2/E/l2mqC+SJ+SypKqOpQ?=
 =?us-ascii?Q?B89MJPt3kpJvBT3ZMQdACzjcfqtHsAUfbl4WmAeGYGhPZa0xRBOT+YKIxRFN?=
 =?us-ascii?Q?OQv0KIYZGJij5u6V1m3dGYW3bIkBMWTuq9DwbtXwtAiihxOjKqIXBt9S3Pqf?=
 =?us-ascii?Q?La/DNPU48Kqs/+U04P1f8bQRaRMZV/RhrEnApe6vNA8X1K398w9MwV8StOkG?=
 =?us-ascii?Q?GJuqix5pCdISRdg7eYarv9/mzjyuXICSk3sjIMYHogwzh0k7Kq5PliVvPjh7?=
 =?us-ascii?Q?j7qM2srkG12HqZ0O7uQYT2kwTVUZ615f0d2WmsMFJ7BnFtxcwi5jdPIq/kCU?=
 =?us-ascii?Q?VnWOIfAjbyBMwSuLwIpnRj8tNP/W8wPIoUkvOGDipGGWah5VgMFXaT316r/B?=
 =?us-ascii?Q?LXir1KMMlSIh0B9GnAJZEygYJC3T4oZTu1aVVgcpQoC8QvW+WQW1x9YCWhFf?=
 =?us-ascii?Q?Ze5RygI/4W8vSVFMXt6L7y2loGSl0w6hsSikuYBWIb8oJLPHApvUcnO1IcPI?=
 =?us-ascii?Q?c1cTjjtMung8oBxzzHB8Oqvz+8926pFoZJ6zjotMMdmaOJZSjE/JiNfGerJk?=
 =?us-ascii?Q?clxFpHhEdKpDONFrUt0thE8Gfjae5yx7i6i5es8i9rdB5otVnL1SkRdv0rbb?=
 =?us-ascii?Q?ej7NFKnuoldlIUfrRcbpZ1h4aX4V/GvQ9MMATCeh24OVQvHLWW61c9YKinf7?=
 =?us-ascii?Q?ttjS45dhh1YS7C5xLBJ1Bp5x+GSX77kq5/7MpuJ5LJViFLAKQWJ85YhAB45B?=
 =?us-ascii?Q?3uhu83gR/C9jbcE/aCGbls+1TzCr4AWG2tcBXBtkGFWXlydC2JhCLIz9QSat?=
 =?us-ascii?Q?9jy2R5L5gWivd/cgGlA7Sm9phiGyHHmdkJoVu45lQMls1de+qIaVQfODc1Ec?=
 =?us-ascii?Q?9TGKcW/ieTjbFjM+BklESOyKiChTf2GjhzsUtdqwundQijjBR/DeZhc08DKs?=
 =?us-ascii?Q?+05JNED4AmVZGCLwmKPoNpk1pcwWTeokwniVfFOcr27FFHs1lXajclLhpska?=
 =?us-ascii?Q?JyUKBs39SSP5PPJp/Mad4suCxTalPKNjHu4y4xrHDAuYP7AbQ762Is2WKxhZ?=
 =?us-ascii?Q?63McjZL1zJDTCToto6B9QXR8BuPMKu0w7wiDr7QCNmHWhwr2AcJchWbVjuxs?=
 =?us-ascii?Q?7fZ7UbUzyl5o7+gv67hb9cM5+K7xatspH9HY0AStCCdnYQaMkbKQSwQ6ejvY?=
 =?us-ascii?Q?Dt+nvWy562ZWWOrsWszPMzND92G5dcvs5WOWK7sT55+5Ppqogmi1YjwlorZE?=
 =?us-ascii?Q?wEfdqKOIuYZFEnYJxgdfDaQ7R3rYUtKW5kpZJYAG9uM8EXClhrkuQ2pxrzP5?=
 =?us-ascii?Q?VJvDf4p5+3PfV8fh2B7ALzZTLy/LXNWHjAqsCSt0+HQAgF1dzQ5Jpw0VzgZH?=
 =?us-ascii?Q?3upkcJ60rwZAOwCTjgZOsbsQswx9R2qGRIuxz0aTdDZcdlZhChVoFzC1Vr8e?=
 =?us-ascii?Q?+2CuHwIw2MYWrhdB9E8scSdEe8/LVzDE+qyYjtNd4rNxNImgEx9f56gmFqAH?=
 =?us-ascii?Q?sC3XSxsL7d4uDHClMX6ZKwCia3T+HcCklWe6ghne18JnvoVfUBFl3q+fpNu8?=
 =?us-ascii?Q?eJ57062PVpdUatjLhMRxs0TZisO+oxAIbr7AliUJ?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9273137-43f3-417f-29a1-08dd50f4c51f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:50:36.7284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJ8pmv8Ww3zqAKZt48tuR68uVfa6jOaS7g1LZHzEX7pmdwLsuL97mFPAoziuu04U+GJ2tYRuS7QIyvgzNbVmgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10096
X-Proofpoint-GUID: pZ0vai2JnY8Vc6mSXxp73FwsyE2LkBGZ
X-Authority-Analysis: v=2.4 cv=bfyRUPPB c=1 sm=1 tr=0 ts=67b5efbe cx=c_pps
 a=CSNy8/ODUcREoDexjutt+g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=sNJ477vccCyBWE1g380A:9
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-ORIG-GUID: pZ0vai2JnY8Vc6mSXxp73FwsyE2LkBGZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_06,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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

From: Jagannathan Raman <jag.raman@oracle.com>

Unlike most other messages, this is a server->client message, for when a
server wants to do "DMA"; this is slow, so normally the server has
memory directly mapped instead.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/common.c   |  57 +++++++++++++++++++++
 hw/vfio-user/common.h   |   3 ++
 hw/vfio-user/pci.c      | 110 ++++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/protocol.h |  13 ++++-
 4 files changed, 182 insertions(+), 1 deletion(-)

diff --git a/hw/vfio-user/common.c b/hw/vfio-user/common.c
index b78b9e57e8..38f8eef317 100644
--- a/hw/vfio-user/common.c
+++ b/hw/vfio-user/common.c
@@ -377,6 +377,10 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy)
         *msg->hdr = hdr;
         data = (char *)msg->hdr + sizeof(hdr);
     } else {
+        if (hdr.size > proxy->max_xfer_size + sizeof(VFIOUserDMARW)) {
+            error_setg(&local_err, "vfio_user_recv request larger than max");
+            goto err;
+        }
         buf = g_malloc0(hdr.size);
         memcpy(buf, &hdr, sizeof(hdr));
         data = buf + sizeof(hdr);
@@ -762,6 +766,59 @@ void vfio_user_wait_reqs(VFIOUserProxy *proxy)
     qemu_mutex_unlock(&proxy->lock);
 }
 
+/*
+ * Reply to an incoming request.
+ */
+void vfio_user_send_reply(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int size)
+{
+
+    if (size < sizeof(VFIOUserHdr)) {
+        error_printf("vfio_user_send_reply - size too small\n");
+        g_free(hdr);
+        return;
+    }
+
+    /*
+     * convert header to associated reply
+     */
+    hdr->flags = VFIO_USER_REPLY;
+    hdr->size = size;
+
+    vfio_user_send_async(proxy, hdr, NULL);
+}
+
+/*
+ * Send an error reply to an incoming request.
+ */
+void vfio_user_send_error(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int error)
+{
+
+    /*
+     * convert header to associated reply
+     */
+    hdr->flags = VFIO_USER_REPLY;
+    hdr->flags |= VFIO_USER_ERROR;
+    hdr->error_reply = error;
+    hdr->size = sizeof(*hdr);
+
+    vfio_user_send_async(proxy, hdr, NULL);
+}
+
+/*
+ * Close FDs erroneously received in an incoming request.
+ */
+void vfio_user_putfds(VFIOUserMsg *msg)
+{
+    VFIOUserFDs *fds = msg->fds;
+    int i;
+
+    for (i = 0; i < fds->recv_fds; i++) {
+        close(fds->fds[i]);
+    }
+    g_free(fds);
+    msg->fds = NULL;
+}
+
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
 
diff --git a/hw/vfio-user/common.h b/hw/vfio-user/common.h
index f7cc02d2e7..f8c61f2128 100644
--- a/hw/vfio-user/common.h
+++ b/hw/vfio-user/common.h
@@ -105,6 +105,9 @@ void vfio_user_send_nowait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                            VFIOUserFDs *fds, int rsize);
 void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                          VFIOUserFDs *fds, int rsize);
+void vfio_user_send_reply(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int size);
+void vfio_user_send_error(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int error);
+void vfio_user_putfds(VFIOUserMsg *msg);
 
 extern VFIODeviceIO vfio_dev_io_sock;
 
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index d520b7592b..e65c7eaf02 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -96,6 +96,95 @@ static void vfio_user_msix_teardown(VFIOPCIDevice *vdev)
     vdev->msix->pba_region = NULL;
 }
 
+static void vfio_user_dma_read(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
+{
+    PCIDevice *pdev = &vdev->pdev;
+    VFIOUserProxy *proxy = vdev->vbasedev.proxy;
+    VFIOUserDMARW *res;
+    MemTxResult r;
+    size_t size;
+
+    if (msg->hdr.size < sizeof(*msg)) {
+        vfio_user_send_error(proxy, &msg->hdr, EINVAL);
+        return;
+    }
+    if (msg->count > proxy->max_xfer_size) {
+        vfio_user_send_error(proxy, &msg->hdr, E2BIG);
+        return;
+    }
+
+    /* switch to our own message buffer */
+    size = msg->count + sizeof(VFIOUserDMARW);
+    res = g_malloc0(size);
+    memcpy(res, msg, sizeof(*res));
+    g_free(msg);
+
+    r = pci_dma_read(pdev, res->offset, &res->data, res->count);
+
+    switch (r) {
+    case MEMTX_OK:
+        if (res->hdr.flags & VFIO_USER_NO_REPLY) {
+            g_free(res);
+            return;
+        }
+        vfio_user_send_reply(proxy, &res->hdr, size);
+        break;
+    case MEMTX_ERROR:
+        vfio_user_send_error(proxy, &res->hdr, EFAULT);
+        break;
+    case MEMTX_DECODE_ERROR:
+        vfio_user_send_error(proxy, &res->hdr, ENODEV);
+        break;
+    case MEMTX_ACCESS_ERROR:
+        vfio_user_send_error(proxy, &res->hdr, EPERM);
+        break;
+    default:
+        error_printf("vfio_user_dma_read unknown error %d\n", r);
+        vfio_user_send_error(vdev->vbasedev.proxy, &res->hdr, EINVAL);
+    }
+}
+
+static void vfio_user_dma_write(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
+{
+    PCIDevice *pdev = &vdev->pdev;
+    VFIOUserProxy *proxy = vdev->vbasedev.proxy;
+    MemTxResult r;
+
+    if (msg->hdr.size < sizeof(*msg)) {
+        vfio_user_send_error(proxy, &msg->hdr, EINVAL);
+        return;
+    }
+    /* make sure transfer count isn't larger than the message data */
+    if (msg->count > msg->hdr.size - sizeof(*msg)) {
+        vfio_user_send_error(proxy, &msg->hdr, E2BIG);
+        return;
+    }
+
+    r = pci_dma_write(pdev, msg->offset, &msg->data, msg->count);
+
+    switch (r) {
+    case MEMTX_OK:
+        if ((msg->hdr.flags & VFIO_USER_NO_REPLY) == 0) {
+            vfio_user_send_reply(proxy, &msg->hdr, sizeof(msg->hdr));
+        } else {
+            g_free(msg);
+        }
+        break;
+    case MEMTX_ERROR:
+        vfio_user_send_error(proxy, &msg->hdr, EFAULT);
+        break;
+    case MEMTX_DECODE_ERROR:
+        vfio_user_send_error(proxy, &msg->hdr, ENODEV);
+        break;
+    case MEMTX_ACCESS_ERROR:
+        vfio_user_send_error(proxy, &msg->hdr, EPERM);
+        break;
+    default:
+        error_printf("vfio_user_dma_write unknown error %d\n", r);
+        vfio_user_send_error(vdev->vbasedev.proxy, &msg->hdr, EINVAL);
+    }
+}
+
 /*
  * Incoming request message callback.
  *
@@ -103,7 +192,28 @@ static void vfio_user_msix_teardown(VFIOPCIDevice *vdev)
  */
 static void vfio_user_pci_process_req(void *opaque, VFIOUserMsg *msg)
 {
+    VFIOPCIDevice *vdev = opaque;
+    VFIOUserHdr *hdr = msg->hdr;
+
+    /* no incoming PCI requests pass FDs */
+    if (msg->fds != NULL) {
+        vfio_user_send_error(vdev->vbasedev.proxy, hdr, EINVAL);
+        vfio_user_putfds(msg);
+        return;
+    }
 
+    switch (hdr->command) {
+    case VFIO_USER_DMA_READ:
+        vfio_user_dma_read(vdev, (VFIOUserDMARW *)hdr);
+        break;
+    case VFIO_USER_DMA_WRITE:
+        vfio_user_dma_write(vdev, (VFIOUserDMARW *)hdr);
+        break;
+    default:
+        error_printf("vfio_user_pci_process_req unknown cmd %d\n",
+                     hdr->command);
+        vfio_user_send_error(vdev->vbasedev.proxy, hdr, ENOSYS);
+    }
 }
 
 /*
diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 109076d820..6bc5809cce 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -201,7 +201,18 @@ typedef struct {
     char data[];
 } VFIOUserRegionRW;
 
-/*imported from struct vfio_bitmap */
+/*
+ * VFIO_USER_DMA_READ
+ * VFIO_USER_DMA_WRITE
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint64_t offset;
+    uint32_t count;
+    char data[];
+} VFIOUserDMARW;
+
+/* imported from struct vfio_bitmap */
 typedef struct {
     uint64_t pgsize;
     uint64_t size;
-- 
2.34.1


