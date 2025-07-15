Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87077C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 05:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubYbU-0004bn-Jh; Tue, 15 Jul 2025 01:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubYbO-0004T9-NJ
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 01:53:19 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubYbE-0005j5-Ru
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 01:53:14 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ELHIpF026861;
 Mon, 14 Jul 2025 22:53:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=23CaQvgfw/Ukgh/APcBnpW6j9oceFkQFAx+qZLNFT
 NQ=; b=jH2KOOZl91XSPDNVhKeR+IQDpZuPFvko5eOQFynQaKcLqA9lVWAH2l60C
 VDHC68bhiwrbbJ4oQBCGdHv1DGA4ruc6BDnISizaWgeKWzLhDWuFBszhJgGNE4GK
 OxWwjgrNvyQMkrYHuDP2IJ8RxiNqzjPppY9RGU+GVv727kaceEqKMlslMWJGdH+S
 eZ7bJTcBKrwUQ/l3fYEIdPJtSFiCmBfu4yiW4VHFz15Y/uk7qdAuN1TtycZUg/V8
 zPwHJCuubbXDiIQwaSBV/aaIqZwNl9sUuS5jmMep9FVwoBM3S+ux3Rj4d+JZySRt
 aAxYEAiixZpiMqoGrD62f1BTT4asg==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2096.outbound.protection.outlook.com [40.107.220.96])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47uq81d9qh-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Jul 2025 22:53:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRya67w5Jf5EPiXmZ0B3HgzisJpC6WwXvcx00QLxMFW5YAQaEKkyHJehuOTsLrLExJxrQHE3rgNj1vVktg16ejhpNhVop0/rmHjeQQhFxkgw7YCrsIzoOXjoAIiSLhM26NOTUSEGmS+n3Sr6FeF+e3MVWA0oscoGJGVpu9AuZB2QlDyI1YyIpqt+1oujdYQt3M6Nb7xTba+Eh9q7ztEY8ZRsAMlhGnrcHhnNryUARcOLj2tS+pKVbJr0aoQoq+kXh4nL3lcABGsyvP8ywWSFE7r2S4vVTo8nEdeFIBwUIbRAf1x8XtZgznDAmYTGEkkcCukJR8pFwMqsiyZImQBDWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23CaQvgfw/Ukgh/APcBnpW6j9oceFkQFAx+qZLNFTNQ=;
 b=VgITQGrbnfkBXPdJ7nHgR/aZIwUsOGvTJR5fKj4kN6eCnUJIw+u9iayyYSm+mM00NlSjJV6AiGMUjsEjpxvYPIVs9vpRcYLr1Y7sXA10OD5wCNxzUvwo7keq6M0LN/qBLl7TdBwcYD0rLco8oBZyPuFIDfq3NqZl5uKPfnmsWLja5tELDFHXchCyP3Ju7GAeqgoyIA4BwsAxKMxrKUPqVyl2N09E15AG9MIu6PA5UujdDWiinwi2SlS/1U/m4NYbRjwONUFeDWgfuoQQunAaHa3MKO+NzLZYkEkp/A163P+IJLGuAGlezCRbcxpORzdAVEDUxk53Si+rrREl27qNqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23CaQvgfw/Ukgh/APcBnpW6j9oceFkQFAx+qZLNFTNQ=;
 b=gb24AeY1jdiaDn64fR+7bqVeo0s9mMxqfuV+odH4qlz5IWD02Sqpv+hZ3PfameokD4u9znBfjZOy4nMUXhq8V+K+1MNWwcXbigADIC6IUAeVjSVfLou3oi0ZXVNVllcyW/5/+6IZ8JsmD3HMXyPljkdFjCFGinXXBkiUXuGwjjXv/CTHmvHiKyIJSeu08z7xWjwNHkpcNIJ0ii6KfLeBk25MYZyCdXfSl3LbG5/dotDdbOXdenRVo9R8uzoVsF08aPcL12wfJbbqPRv+XHgzDj4F9jqGTkp/kYpQM+Yf4MGkt1NDjkvfbq3YwijADkLuM0T9kKYuc7wLmncwC3MYdA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8841.namprd02.prod.outlook.com (2603:10b6:510:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 15 Jul
 2025 05:53:00 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 05:53:00 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH v2 2/4] hw/vfio: fix region fd initialization
Date: Tue, 15 Jul 2025 07:52:44 +0200
Message-ID: <20250715055246.422834-3-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715055246.422834-1-john.levon@nutanix.com>
References: <20250715055246.422834-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::18) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 27d217db-0157-439c-6e27-08ddc363db34
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QC6h7g29x+7SUqTtpfTt//zeM/NPvXOTuXJHJbnc3d6stlEn6aNPkE6iyyHJ?=
 =?us-ascii?Q?el+Rw9+NeyuKuvunaaIWSlKHoxko0irCnKW4Rgs/cpXezgQYPgxPGdeocLqW?=
 =?us-ascii?Q?Z3QpzmA0v9tZc9h5+LumsQoraU7SAQQ94uWs0AH4KEmxDLC4bwyO+IfZOBy9?=
 =?us-ascii?Q?Gm2rh7ZniPHY+n+waErRhkn5cGscti1t67ZWGW4tQcEA5e5+Ir2CRnB+MSzR?=
 =?us-ascii?Q?q+MTys/q3RMIjpTEu3hNPv83X/s/0fLNyyxlNQLS0znzYT36lmp84wEiWADI?=
 =?us-ascii?Q?L5qmKbX3lgcXbrS+g/NrzFQsgI9v2Vb/fGhZ5pEi9gF3Rs7SvP3LCtq2cBUn?=
 =?us-ascii?Q?7An05wgr7aclnxQ3fONx90pdc6Aoh6VrUhl745zzkW0I6Tv4F+2QN3krVh76?=
 =?us-ascii?Q?51AtNCAgmIE1jpS6qHxWSOYxjdejVW+Z4MFybtZl+CNovH+ezKOuE0KNFvSm?=
 =?us-ascii?Q?H9yt3IAKMlXRgD1jWRAURKp2ZNQWdfS0UgxgCbN9guG9aaMzfjwaVIgToJsS?=
 =?us-ascii?Q?EVfe4/2i9r0CgBdJ+ufLFyz5igiwMgUS2ObY5M2pnGs9Q2P7nNVvp8SUinLS?=
 =?us-ascii?Q?sjbrR/HNAzFAj0IAbKdIVXYfmkRXKjkXNA5m4DymbPWvr2WucED2CG+fF7Si?=
 =?us-ascii?Q?sgJPed/4FkA48ty+FIY7Yzl2jFUFsTMsGFKOkCSkTE1ZkFzXgQV9sjVWkheb?=
 =?us-ascii?Q?ONX/Bqu7SS8KOAE8n1ejooghkNYagCkaa/fhsp6gQHhfCe3Vknu9sXTbA/M/?=
 =?us-ascii?Q?m37Z1DW7JKeKvWj3hkln5ug71bYnv3UhgtRSvkMzirwyOBygOjJbGRG1d4JH?=
 =?us-ascii?Q?YWjfsZb1luxgn8giR3SFCaQ2+i7D9Ul8szrv1Z2Xt3AjMPKOwCbcVzh8/TXl?=
 =?us-ascii?Q?rGEzOwS0k+ZvBbeq4oiMo2rHtc1O+5xAcmiw55Vgyl7Pm8aokVS7Tm72EK95?=
 =?us-ascii?Q?eFNPFzsPtUpQuuoXL+x9GL095IAwCaBChdN1HSd8O7TEH3T+OunEF3LhIjam?=
 =?us-ascii?Q?C7Lvl5V5rOhxslH5thp2zvmh5H5dKxhINZ2yr59o0Y7UsA9lXhoIgmkPJWTU?=
 =?us-ascii?Q?luLQyk7Y+o7poFEVIPwSMaWLSwSO7mgaAUJMIu5TnJoDS43EjX9YtLzIbwPc?=
 =?us-ascii?Q?SP8JplSdoQt3ruRIO+DZrGxqPiXCF5j931FsstcOFqLEXWplbe3KsP49zanT?=
 =?us-ascii?Q?vbEzpc3KHxJ6RXwgcxni5iA4PQlxisc7UAvSaaqOz4X8a9EuIwuPcBjBQxZN?=
 =?us-ascii?Q?I1OJW6MrFxvyNLCfJpdrM0ouIgDtFa/iunK/FxL2rQvCyGaflpLmM5bdLJEs?=
 =?us-ascii?Q?IjickP5zd+VCgbPxCJFwBClzUHtp/8o5if3taABhuBnYEUTC6PQGww7aLCrL?=
 =?us-ascii?Q?gDQXSREcyoWX4QCnw1BiLjuZo4n/cx5gLgTA3QjmTk9nCoSuQy5hLIcbGELt?=
 =?us-ascii?Q?CE/uWJeOQVo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?smuCNvXFPdntv5IbINp/xSW9pfKKUzSv3bAI4OeLCaWVIqfJk8VvxlIyCZRB?=
 =?us-ascii?Q?6kt403rso8RXCgxVtgilckrrd4vvN2BqzPs5TKiHkD+LrIYAjB21B9cJZ8jI?=
 =?us-ascii?Q?FeYubO6NQxaADDkkyMunNjIpIJmCSgvNSpeEDYYZERBWmgdC0RQYDJfhIgp5?=
 =?us-ascii?Q?wUbJiLE5tS534t4WL4bIRy3/ezCQQ/Yi1nx4mGuj9lTo81me7rLCYcGJuSgb?=
 =?us-ascii?Q?UgxVYiiNhrNhhZKgD+zZgf5sMN1pwhc8Mq9+k8ORiifSukpJlptMop8I3ses?=
 =?us-ascii?Q?LGhjnZJrx+fbf4cP5TpX9wxB5ptiZBgX/XK0wCSbds2dmSmZttCoH8UJyAvg?=
 =?us-ascii?Q?bKFO3C8IVz2YiDAKfvldR6o+GijRdh8R+nkF/wSx5RhK9qQWso9DE+6Jnus0?=
 =?us-ascii?Q?9ZrvjkbV0Npu2f2px3dCkUHUGehxb1hPmPJu8I4K0XhhG1F5AebQ+OVu8q4G?=
 =?us-ascii?Q?PWEmw39MAVb5arYJ857+dhn9hBRzKOc9Rs/7omA9kez+ywUTuIGSkyg1Vz/7?=
 =?us-ascii?Q?IfGQRqroOxoVnkzxdC92JlBwi6SdaT8jKKC7s+6sWhkGmQbdIlxuSbegLhk6?=
 =?us-ascii?Q?DLePU59qdyC0LnGVX/VxfmasURwo1hjxL5YJhTu5jE/CkTPHPQOgBr5bIiNp?=
 =?us-ascii?Q?gagV+pxM18C2JUPGRMkBmEcq1+UWAayRVSbpV+M2mBlQiTnsdyRCubkiS8eL?=
 =?us-ascii?Q?JFe9juLBWx+4Vv6o4f3ay2TOo5R7BgGa6BQ8DtFNNrCf070+3SWZIs1dcSMG?=
 =?us-ascii?Q?ouL6dw5dvJRAvt1gsgkEWQtqiKdhOmjrHrG2rax45zSLW7dgZLsjkSUzV901?=
 =?us-ascii?Q?5bGWVbh7i90XXATbWOoGrL0cBX0Uwa+brl+oHy90QUK2c58gG8ql4VXYyDp9?=
 =?us-ascii?Q?PkMyQsbvcNIxXOq4dNZOWKBft0fb37GAO6z3N9f+jKA5IKFxKIloCd0//6hl?=
 =?us-ascii?Q?8GVbU4qBgYY+aseWtrOOXFyGWZWOJdlptUbWWQUcKRokBJreCtlTzl13L3ID?=
 =?us-ascii?Q?D9CFQyPsgtwMefzhUTI2SMXK90Ve2wART/sDwaQGGhW8L7JpcDuFmTt01zV2?=
 =?us-ascii?Q?AQsZsSsiffs6u++luDKD68BbDWsOdktK5eFQV1CizamwL31Gziivzsgvz1MA?=
 =?us-ascii?Q?FA3MRuAgOzVfZBRrZngpUq7+4g1ePWS4DEvIJNXN12irZmG4DJBJUi7GYb3P?=
 =?us-ascii?Q?sn1Q330hl/Bz3LHYRlQrQiZgykOjHdzKfb4p/BX6uUSh/hsvAYq0vgSXPXJc?=
 =?us-ascii?Q?JXhWETHwrwenOA64NQ21zQ/p0EpDm30GsX+iFK2ze/ZUVZen4Oom/oTf4kpB?=
 =?us-ascii?Q?shkGuPyM1KOzCULJ/1d5unSElIdTcMuuqpRfVUTGCc8I45XkhUmHIpj6Gcqy?=
 =?us-ascii?Q?IZpUpSyoCG9LXmX4BRRBkneOkdV0qFq8Qq+s50W5qByVHrqU2ZCz78Xs8QSx?=
 =?us-ascii?Q?RFCGzJWeIYeNYEBze+WrA/V7cMurKBMQmGCQxZkUrmVQKwQrp6w2A+kl5kjb?=
 =?us-ascii?Q?VDixTPIb6i8zAzamlB+Tx+pdQoguVaTWJYHh3OcYzkutSBTCfDVCQy1pmNVg?=
 =?us-ascii?Q?BNkNRpb3wscUrfb/TdZvN+Rfo3u0bnvoybV57V3vffWsubyoAUjTpNGQqom/?=
 =?us-ascii?Q?qQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d217db-0157-439c-6e27-08ddc363db34
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 05:53:00.4957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/FPJiM21Pgoyl6xDKdr1gYj9lDgviyzUehptPHPv7Pkqa34Tt/ZWCcavBllr8x+oytvt2tEf38jvTWkJSqlnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8841
X-Authority-Analysis: v=2.4 cv=bL0WIO+Z c=1 sm=1 tr=0 ts=6875ecbf cx=c_pps
 a=+jfnsvNtYUVjUhI0lc2tVQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=sV9AKFzeoAo0iIp09WIA:9
X-Proofpoint-ORIG-GUID: 9p29fs5j0fzAqnAoZymMKXmDkSXZrG9j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA1MiBTYWx0ZWRfX6jNbHd15Gd5+
 ysYF9Q4gIc2QTGc6vIjMIOXwIto+aL6vLzdEpRF1YTwQFsb4VOdi+ICFZ55Nor3tK/r+NJA8i4c
 7TaUekzRmPVFQ7FMsQtQk0b88FcIft/Y95W4Sb9qvITRJJbJzkPVYX8nVLKPDbCgAOTUO3ckDEL
 GsRC5q+VHaXkLTPADqkoRJrdJt7gigFdWCfvdv5tQTz8VBNQGJNutx6piSRldwZrISFdjHawcFE
 JbysuHbRvdRGdIRUtZaKI2wsHbUKi4gIphTMihTvkF3SNgmWi0VGkvEaZUn1AgZkhNQn/XNJTY+
 5e7bUBbQsoHbtK3C0KLdsAjlP4paUOiQVjDXY4NxujbJ2b+PpRo5ejFPGFZX5YC/Cf6RcNxfnl8
 ItHbsQX7aOc8cxEyKgasn0DJxZAWw2BemGLwkbx2V5xLBtg3Wy0QEPgg2lKKMI6bCP9HvrFc
X-Proofpoint-GUID: 9p29fs5j0fzAqnAoZymMKXmDkSXZrG9j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

We were not initializing the region fd array to -1, so we would
accidentally try to close(0) on cleanup for any region that is not
referenced.

Fixes: 95cdb024 ("vfio: add region info cache")
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/device.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 96cf21462c..52a1996dc4 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -463,6 +463,8 @@ void vfio_device_detach(VFIODevice *vbasedev)
 void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
                          struct vfio_device_info *info)
 {
+    int i;
+
     vbasedev->num_irqs = info->num_irqs;
     vbasedev->num_regions = info->num_regions;
     vbasedev->flags = info->flags;
@@ -477,6 +479,9 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
                                vbasedev->num_regions);
     if (vbasedev->use_region_fds) {
         vbasedev->region_fds = g_new0(int, vbasedev->num_regions);
+        for (i = 0; i < vbasedev->num_regions; i++) {
+            vbasedev->region_fds[i] = -1;
+        }
     }
 }
 
@@ -489,7 +494,6 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
         if (vbasedev->region_fds != NULL && vbasedev->region_fds[i] != -1) {
             close(vbasedev->region_fds[i]);
         }
-
     }
 
     g_clear_pointer(&vbasedev->reginfo, g_free);
-- 
2.43.0


