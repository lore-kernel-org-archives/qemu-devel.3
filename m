Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BEFCCF2E4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIm8R-0000wo-NR; Mon, 19 Oct 2026 08:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm8K-0000ff-3W
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:28 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm8I-00048F-FY
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:27 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8QSCe3508827; Mon, 19 Oct 2026 05:06:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=YBENO+AVPrr9uTUjU0EffDFLvrFbeW1XWzcjaPVFV
 10=; b=cU+9bHkgY3GwwRF+VbPi0uo51N/74s6Mcyzc3xax2/gb4NyDl/eWmq6n8
 t8eNTzRkMnNA7eVlZEPjKQhZnipWQs2JpMWqdxZojEswhQYhRh9a9rqaJ41i0URR
 kUOE637Q63/L66tKNY11Hf6LsF0lrmXQnh0LE4y5fofvx6rjRSiBliAuvabPay5e
 MASaMCP8HUvrEW9B6E21m0+5DkuGjHImN/j1AN/AH4yehy9sR2eYeJH21csoWptO
 lqz1qIcKcZkTaEk9/WG9ANahAOQl5X0L3T+oy6yzL0wJ2+Y0gVkixSaARoTPZmYf
 t1R0Jh/ktZ0oTc2HbyHVbYmsikxWw==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021083.outbound.protection.outlook.com [52.101.52.83])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hc4x43qpr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:06:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNkgQLPzICIJnVOdz391/rjrUI4CtiiTo9IJSF9KMt1Yi0CUVhl4TSob/J3Vq+HS0X6THgZf+sgYnretP20apRldE/Q19iFChHrHy3VH+8kFi38uKSrcg1TWgwvBjuxMT2Gbyyq/KmnUoRQZfX8h7ty8OWB1XJY9ZJWaCtqywMG9ZTkuuiJv6HlXyezPi3QxCpfaTNePUE6ENek5YgGA3NE20KbvqwJtyC77dKvppQ/sbSwUyv4b4J2vICJpzL+Hx3YG/l14PnI0iTjwV8JQhm3OrqSlQwk/SJa0+aDUD0LNVFgDG9IrV0OsJ19PUyQbdg2D0imt94k1EwgU4ZvCTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBENO+AVPrr9uTUjU0EffDFLvrFbeW1XWzcjaPVFV10=;
 b=nn5nMRNP5N5ZkizTDPcA4saEyGf79fML1NVU5rQ2pdjH0qH+NwgQ17K/Tns7PMwPumUJ3ZEfT9v9BWCbqOKytabRYt5JvhxafMKdixkQZ/1oDC1AwVgLDyO/H4Sn8zrkE3jzMqB9dGkFvI266bmpP4Ny8ob6Wmq2dfELa9LAqhbyZCnHUHVVpnLrsTH2e354myS3qzRUa4OghJVEx9x4KDaPgkd4u71JLCgf4iJgl3bawUQIuk+XJK/Zns/jUw91MU0yoHe5LDTpE4BZz+qk/zvG4I1v404RCYQrexXRq8cmd5Q3+de4/Qc/MyZHiK7hQQQg8iNFT4rjDqhm/NOppQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBENO+AVPrr9uTUjU0EffDFLvrFbeW1XWzcjaPVFV10=;
 b=EImVt5OVXuAeJVdNyAcMrZpdHxKdAHjrEBAviFNWRwaOoynljPR6DwPon79H0PxLnmp8cZtOdwDAEXHbbUYLYwCi/cPasHRBmbOYmQrlxzTWSNZHuTmU7Yta/OjxxPgisrtjKFdQNUC17CGLSQC5b5bvdmWmZ6iIaSW4NmL9jBK+1YS+YNTptnH8aJLaUZJbcuAHdOTir5wZ6Dji/o2EtkG29oF9QHynACdfAjCBtyPiW4l58gEJRrNpYAiu3j/RvVTIti2isdVLs0F1eOVOHeVyvUUdpq+rkrQukZ/0vAJlWA2lQ3dDHeICl3BviArJRueAy87HwE0cI5L478wLaw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MWHPR02MB11820.namprd02.prod.outlook.com (2603:10b6:303:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 12:06:16 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 12:06:16 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v3 17/28] kvm/i8259.c: convert to use DEFINE_TYPES() macro
Date: Mon, 19 Oct 2026 13:04:49 +0100
Message-ID: <20261019120517.1448687-18-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MWHPR02MB11820:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e51ba10-eaf1-4e25-5074-08df2dd960a8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: d80rMGGt3ybKd2pGVHwitUfQYIF2O6T961bTUq0yVLmwtm+JKR7bNAQZWMXtDCvudJ2L+gIfO7MF8JXu/IbzSgXX1JvOX10CXhIi73jAav2IoH0cgzwUE4tRdaCZi1jAYgwIr57Ukf9IEEjufrBbuqRbk4ulmDGPjCbQrz1gnNgy8xUhUtceL5r1M8scOBunz1inHSZDWR4UotHgSudvk7ZCb6apGx74sTfiI7p4XT9J/vfeHW6n9kAWaLzs5fyBOdQwifV6ZEzqnl0YYz8Ivw4Ynfen6y48pSTQyX8yNerFWdTe+VI/Gy9jtidjRM1WFgSqYq6/xqFZJfQU1ns1iQlY1NRnpiSyhk7YJvexUR0K4W1lnGiuL7ayvpMqcnSK0PX6o5X45zTJPWimYY7IQfUShr2GE6YxVdAQVMTRXoKYhYtFFV87v335z99pcO3WA1dA+7olBOhAFZYR6RNwHRV3LoSKb9hl5szoK5QlWEOeujrggj4iswsoe9+AAV585hCtPmMB9VmSF9WLVFdfifpSFgE7nuuhNpvwW0+YXySNvU3P/DvMuIfgTE5BhJwM/uWbXiXG7HPdEXjH0ZRo+cKN8uXpG2JiCNnQRu04oF8658IUULCaOd3ZMmngJ19oF4hypoyfGA9Et3YmootSCbsPthG7KP88vLBqmkjcjWE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OPVE0T55G/GthBDAdbkHkLJjV0q4GprO9bQYQBXL4ayzqESwc6eHvD5XJoxS?=
 =?us-ascii?Q?Umk+eAZnEBlThTZbYqrCUolHcJ/gIK2/nZzZVDBrK/95Li0MlzIGEZvaWvxj?=
 =?us-ascii?Q?cg1ZKDrLhfYmyuqUpNiirq9Lya0NU8r1PeeXG3t5OzpyG+uZsl+3jEHjWqbC?=
 =?us-ascii?Q?w112bjtg2eJs9r1EpZhJI0MAsDN343S4tqPgRnRsTosFNxQW+0z+S8O1d6m3?=
 =?us-ascii?Q?IZyqgaq6Bt3CTbiyy9eMCLu3npCgnthAaV8Sz/e10cQzoNpcTLtt5N/00lnz?=
 =?us-ascii?Q?zHgkIvpNteUNXaL45CxBlxeUHrcSiVMgIdCoUgUmjZJx/P46nAY/xxwkU9wc?=
 =?us-ascii?Q?Jh8yvUP6vXNOYiMt4uv6LWA8d4UY650qMmKPjgrWlk3EXEvA0S9Aq0S0PMqo?=
 =?us-ascii?Q?k7VcVf2EJehXKPrC0f5CCWvpzTYQX44qrtdlDWEOFmbA4tJF8dbwA5cYseY4?=
 =?us-ascii?Q?Mn5BEaOFC2g16DBD7GbpS5luXtkBfT4yw9qBNKcY6TyIzebma/sdR7Gy/7cU?=
 =?us-ascii?Q?CKJ92ZvSW5ZFbyvlCn6wOaPGEcg9695uu9BGja4ohXUdOjwnmed8LUlIJVC3?=
 =?us-ascii?Q?EPA6mxhfzSHu2xrbe9cbQ8lp7vP1G1G711/fSowOCB2ULqQ4OSYT4nwJQie4?=
 =?us-ascii?Q?nYDcdJBwZfvoc3kM0kK0cymQn7/c4QS0gTvtbliS94W5/40BF0qYyDNbMy4F?=
 =?us-ascii?Q?DcLPjvVXjzqOQi/rsxUI46LlK3R0MzPSBHHrh/QzdBWklIFpVn0OOEAWbHAM?=
 =?us-ascii?Q?r9kpc0Y+QC+/i/taYuTIu/LQTqZBBthQkglvTI0fuXcASgueXAYMHlgZucc/?=
 =?us-ascii?Q?HEHpAgECUAjA8z12dGRj43XYO+b4OG7owHGky5g8L6Bfzkv2zqgKmNaOAEQi?=
 =?us-ascii?Q?9rAiY0iWKBis24rGYvB/5H4sSYgvHZYui6qOc2hlp3F/a0y8shHna1KivlEF?=
 =?us-ascii?Q?famqXaJvOdGYOWdan7ajTB8cxFwnSsUuawpsjwsJsiqbid+ltCo7B+WlOLP3?=
 =?us-ascii?Q?HmrZlC3WJSaRuksX5C67AZy+Sf3IipfrzqLJ+p5e2DcojfVpHqa/KwwSdRPg?=
 =?us-ascii?Q?KneXedOuYVPxo6hmgMyXCB9rkzrEsho0EudR9jsJ61oNMPxiey8eec6/VEX6?=
 =?us-ascii?Q?9YPr49auqTuoRwkFjAc3UL6OtaUr89/rTPhcd7QY0AenlKkI1TLmAX4wayDK?=
 =?us-ascii?Q?RKkqLLLxsKu+hiyUhr6sgL7zGbjP/PMXH+3bqk5ZxZmaMxcnGHGiDMfBxqPq?=
 =?us-ascii?Q?BGFK7nIA5SfMizBg0lpmaFyHAjmOVsFO/3+Loe+SJqZVA5Z/jkhynfHsgL6z?=
 =?us-ascii?Q?8FFvlzrsfGEW6k3M32fqAwFc7bETYUNiWJF++mh002RGNnYCeotMym5NppZN?=
 =?us-ascii?Q?8fo6db4zEa9ebATKT2HitQQ6zB0iJ0l6fE3xFHZtnU7yMsiyhgCVLvm+E+2s?=
 =?us-ascii?Q?CcXc3ytKT/lc5hnseETEzYPC/k8fokxlxY87uvF83Jr59GnXBM9kaljnIHLc?=
 =?us-ascii?Q?zCVsZGHd79nTKENeuMTmwSuKU5tgo+zZUC4SBLLCkhcP1LA/nNlypMYCKMiY?=
 =?us-ascii?Q?/61DMZpupUPymPXW0FEWiXE0aW3wRKWRufFBQ6sHaS8LfjQ4KZu685hW/iXD?=
 =?us-ascii?Q?YCobbjUO2OCZ3yqMc9MuerVWZ66aAz18b8Fs/KHpfW1mrak8DLugHxmOnwoL?=
 =?us-ascii?Q?zJ8LlAQ4X8XWCudV7U1lLBzaVSLI0dfI86h1BTZwFyd0bH/Y8IxdskEToZQ8?=
 =?us-ascii?Q?II70NgaPTxMKmEe9n/uQbUomcDe9Ql0=3D?=
X-Exchange-RoutingPolicyChecked: vfYI+t2dF3HptCXQ029O9LLZqhT2RibIVRj+FsEsdrRix/Oh283gca0k4DwJxPIuEhI3bsh8+KErBbugPtpBPMt8OE4ZpFVyxDhnGrbwoaNH60Tdff8TuVdNEvS50NWpUj023iuthJ/AkKQdkFkOKa7cCqI6epvAsqGQBzBRhjXBhsZRpAgJK219RKQDjPDnBC93uiz2S2Blx8R2H+SSZPLyvwhGgMuP0h+f2RxQ6bFyKIP0pttzJJdvfFpyEPXxV0Sv08CFquZZpfNWvTzviuB+ormIUDM1F7fC9YFFLxdXqHV0FBj8Jk9fPOG+Ld3HNGXKwY7Kg6bvA9KMgNC4AA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e51ba10-eaf1-4e25-5074-08df2dd960a8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 12:06:16.3497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5OffBO2pQinvHfeUIwTy7r/BAfcG/b3Pp5WGfEbwxrQeBe/UcD7lyQ79iLuu0dhAPW5neZHgqcySdear+CaeltluNz0/Fpydr+SYB1ur58E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB11820
X-Proofpoint-ORIG-GUID: VxjcBY-mQhR7NocekDvFRnIvdTEhHwHy
X-Proofpoint-GUID: VxjcBY-mQhR7NocekDvFRnIvdTEhHwHy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX5N7a8u0CC4Ub
 12zekDNudziF9jGf64U9+7EcHeTN7dYvpHNMiywaYZgfPBXzeCScoeJ7hxz+G/tlRrbVFmY0cyE
 xivPLnX3rwNZnVsYM2MaLsJCeNl/Xco=
X-Authority-Analysis: v=2.4 cv=DqHDa2/+ c=1 sm=1 tr=0 ts=6ad607ba cx=c_pps
 a=X+j8kQviiGxwf3Sz5eWiEw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=CQnoaSmAlUSJywai4vEA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX/Bao0tWbSQ6W
 8emJhJfP2/4wAcgFcdOauBlCrHSodkuJnCfag5oKBiZBOY7OhC9cBP6zxwZu47X7dlt2U89jTr3
 Xnz22KUtZGxF6vWxrAPz+YorfkvRpOT4HUAKEhy9uNaC64H4uWHscPktbAbDxNRiBxY5L68m+yg
 IsSdFbdqlDNaP0TM50UnqiSvDVPT9iwJ+OQy276ZAHC8KQ0mmOmOmquFpNmMhwajtEWJlulxVpl
 nwt/f5IoMHGPstLSSgxPGeGazBfF2ZvnsM/mpUQznsIm66o7gtOczK+g2NP1fGK2WzSOOzii7Fz
 6jxbckoJ3aomU2zu+MFbJsFlqlhvQQyYzDnUQ7VS/jvNkzLmt+LOAA53E63TWc3dCrSbwcN+fre
 /RaRE1clh6MMQkDysUi5fvIUzfPzuKs6h4AreJY04G1nnE4iUKylsqH5f651YBsUVXWwLFoQ0ud
 W8JoUhl+54Z2PFAk6SA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i386/kvm/i8259.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 952f58be11..9ee23b5695 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -154,17 +154,14 @@ static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
     k->post_load  = kvm_i8259_put;
 }
 
-static const TypeInfo kvm_i8259_info = {
-    .name = TYPE_KVM_I8259,
-    .parent = TYPE_I8259_COMMON,
-    .instance_size = sizeof(KVMI8259State),
-    .class_init = kvm_i8259_class_init,
-    .class_size = sizeof(KVMI8259Class),
+static const TypeInfo kvm_i8259_type_infos[] = {
+    {
+        .name = TYPE_KVM_I8259,
+        .parent = TYPE_I8259_COMMON,
+        .instance_size = sizeof(KVMI8259State),
+        .class_init = kvm_i8259_class_init,
+        .class_size = sizeof(KVMI8259Class),
+    },
 };
 
-static void kvm_i8259_register_types(void)
-{
-    type_register_static(&kvm_i8259_info);
-}
-
-type_init(kvm_i8259_register_types)
+DEFINE_TYPES(kvm_i8259_type_infos)
-- 
2.43.0


