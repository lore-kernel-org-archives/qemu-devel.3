Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD9EC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfeN3-0002X9-2T; Fri, 03 Jul 2026 09:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfeN0-0002UP-Pi; Fri, 03 Jul 2026 09:55:54 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfeMz-0006Zu-49; Fri, 03 Jul 2026 09:55:54 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6635uKbI1995843; Fri, 3 Jul 2026 06:55:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=dR3+N2aw9U9kf+VthbZifqsWgG2Xp8bM7rKKEjNgm
 3c=; b=UXVlWYOSOSVqVR5A3jGM4vwM9DI/0lydMDnFCmzvZHZntsrXWYKpiUINb
 MtVezAlVCbAmm2wvDkI/3dzCkmNSO0MbmcjYzp8QvjS4VHZdpsv7+NkH7wFwym+W
 iP87cjLR/IKjKxHrznfaJ7/luVDUqU+6O7z2xn1214cLCYTBgFSjvHz9FHs1x11a
 7wrna4F5bHGQ/ZZxt6wefdKbLhxDcpk6tDhgYUvlaAfEw9fKNfPAf+v6eIPIMzfx
 bmoryhNWI4Jr4VC/FkglHAEexGlwleKN0NqG0K4YzU8nOYfBWh03N86qVAoUsevz
 tibVjtzfZ8zgK8vp+G0x4XIA7vIjQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020104.outbound.protection.outlook.com [52.101.61.104])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4f5d5hcmbd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 06:55:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aEI26aDQOO5svHPdwniZIGU8yLeGGBIgXF+tyEUjn26pPk97D6vz/hmu+3DoUXSsG4yfLIofK2oBuWu9vWqGY3furiqfIefXUPsa5PZuvrBJ13ZnpCxhDWki0CqUYlan0wdeSYn5Ljm6wBMVfn46puSn4XmGgnypXTU0aKDwMSVqjo8PUUPoQNdLIy/POd/ro1iuT2W6v7b2c4jx1nmJGYTLmSfCGwFgd2Wkbg+bhV+EborCDGK1kcLZVQS6DIFbbofnHHRYTi+/4lsOcDPqvTgoIws+QOC0i+6fG71y2X85QogfifKiLhCBgec67c5Y753xWdQ7SbA98IDipB5XCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dR3+N2aw9U9kf+VthbZifqsWgG2Xp8bM7rKKEjNgm3c=;
 b=fybChRolBjtDp9NnXi8IauhE+/d32Gp7OupMPcgzV11Cxy+ByrVou7g+JZyvWx9n+Ny5R8tWMwumuT2DD/Z/jSEfasSfISuw+cRi5eecE6QH5XoM+6Ou6QCaKCcmVKaxPQmcqBhUxvYL+jP8XMFHubdtPcpYKpT83N6LHerfJgysfqc+VHiQo4p9g5dEsDuBPyyx6l7C5lIRxOYYapujFFW0U5HJtlnHO4KEc7vNmkLzDJvPkYF1UajILTvtH/S/T/8w/FN+LSS6nxc+4mU2KzrZTwgmq3mUmOgIQPWuPX1SOBqC3C6fvj/SUR12Hva7GonpOHpqKgKvP9/rEIRbAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dR3+N2aw9U9kf+VthbZifqsWgG2Xp8bM7rKKEjNgm3c=;
 b=U96G048bKbhy1YqWrzu/s+9draBUnTQBMJ5oK195sVUgLHHw59E/NpKqPv+drFoKc2Gbt6CtioSMpiHDXmpepBSWtCksL1l5nz38ihX+/6R/nOcI+e0ql1mutnPFAhsHFvV+X4Lb2UoQqGHGvGm7vMa85U33Y61448CXJGG05STF09Z4aHa+egdlCt5N5icdQ7ykX1Nu2F7z1d202PC3E/eWav/W8vtDf2Yf0gjAXv3f57vdrbH2tq+zxdWSZCfqhrkXRerZcfmDDVA7Sz7HhtNxEz0tNlvKGLQMuW0lnn6ZFc0L+9kjWmWHpHTYFNhUnoDoAXGDNgwyhF1PwEUsqQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY5PR02MB9016.namprd02.prod.outlook.com (2603:10b6:930:34::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Fri, 3 Jul
 2026 13:55:38 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 13:55:38 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, berrange@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v2 06/12] hw/acpi/ich9.c: move initial property values into
 ich9_reset_properties()
Date: Fri,  3 Jul 2026 14:53:08 +0100
Message-ID: <20260703135512.3213964-7-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
References: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0173.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:344::19) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY5PR02MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: c0dc7379-ec89-4700-beb4-08ded90ac30e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|23010399003|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: +2RQ/GOtGHvUw3jKWP4C8rZWilowjm3h8ofyLe4LMkKikhgjQ2dGd5EWEZzeUZbIpipsbumw87tjmUo6J9jBMsZDrJogJsosH+33bOxxtCncZrAaebybE5KoOYCp+3CCHRbXI26sy2F+Dks0gC4TWb6c4N8PsMioWFIPOwwxVaBn7WL54d0vMrxovd3zjQpDqP25gJ6JIPVNmVINzX4VEy1AmVuRvsWoDh1th7pq436Uy54nWoN795/5+CQqIQNW7JzT4hKFOGbcUs+SJOrahyY7hL3/pHo1C7ImUtZ3Lu+uc/H0PQ1jDuE1HuSldfGHt5eeXz8F+5ozT3IWDg4qzGGl20w4YrdQzKLLopm0MeUKoGi4B7lazWKCjJnjCrbQnIyP3Q9xX0/ZJvBIvaeOogefMqxlIKYIHejPjkMxJYjwzm0q3vMl5agobjI3nEaIIAc/L1JWuk15usuwtL600UI/0D0J687QbQt3dT09bhaxSGzjUnhI+LBGC6TKPa9Yn1DuQEv8YJ2C1gVfX/EMNGz9WYr88dPRGwMZBg7Bgm8MwqN3SH3Wq9PS5OlPiHusfRwgODUGvilv+AbqROswLKDj8MUaL+1OO1OH/VBXFuu2rlI1SNtKEuHkRqjpiPgLDgzea932JKswqtA3ZgdPAB4NijyfOejqYH7CgMq8475cqpscALSbJwiW8tbY6B/QxoD4izwumo3T74gaWYGxMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(56012099006)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8JEz69sP9mgRc0zZD8OZZUE190Kl+QfooGlGoEjDACXerggcf/fok3USyUHe?=
 =?us-ascii?Q?EIRYPFodGk8yuK6ghHPB01WLYhJ7hd/QQ/UZUYVd+iO3vUwGWLKyX6oa13rX?=
 =?us-ascii?Q?+c8e8JQ6gMNOMHY06aYZbXr1/U1R19plrIRnlzOigxRR7J8U31TAQ5A+nb1H?=
 =?us-ascii?Q?7zbKhC0HnMz5WoB7TITyAhmwurPtXb73iALwIcI4BufR8iLV0ViRH7SiYcVY?=
 =?us-ascii?Q?pGzR0mLUN5qIE+jVrtp9J+AHxVD8McWm4Uy+D/CoMlDAqEyRmtg9rjZZOVRJ?=
 =?us-ascii?Q?eLCo1ZnlNKe/96XNVBvIekwM6QidLpLwdIuAbTI4a4706fEbSI59gGs3pE4/?=
 =?us-ascii?Q?eWxjyzg+Uuaf06BzmX1dx6h00Q5Aici3NwxTbk5ITWp+SFYQNwoVaR4i3qp8?=
 =?us-ascii?Q?zisvTQfxP6cZEN4xKyVNQGP360CNVM0diJBEDTCJVLYig4/Ai1sv4vI3oNVH?=
 =?us-ascii?Q?RanToCJT//JAM7pw2HQ6FGx7HuBbPOMhIuA3lEHA0pIrV2xM/FuK7DfUS3PM?=
 =?us-ascii?Q?XLgm9dzkVsSWNUoowg/cIPhz34Unbnds8WmdVZxrFth0Huxt6InumQnah+l8?=
 =?us-ascii?Q?zZZj4LqmuHPQ1Ufqt0b+WMXwNEQQN+CUtcKXgyUxQGI9qQUBt7qrWLCWafXC?=
 =?us-ascii?Q?Phrx6018ZuHXWYY4k0CEWMd6NNDybRWgPUCxCOL/D7IQWUKitSkliZwG6uKi?=
 =?us-ascii?Q?5qF+xYAK1uO01slxrQXbcZWD39tRYp9LP0vuJuPsO07PtxSjTCuCG6BuBQjA?=
 =?us-ascii?Q?nWk0O2IpTQYc1IM1NZQIADA+ob579nG/+LfHBOw8bzreAq6EasLxz49ueKMc?=
 =?us-ascii?Q?IKGLWOEL51cfubTjc5QVUXLoieXgpBlXV4mWnumwWAY88HaW9EGvWWzPW986?=
 =?us-ascii?Q?eF9H3FIMpd5SDeTz6yKpat/xRvY5zNUTFE2R6rdWOSDglZuWvCn4DjK6yEe9?=
 =?us-ascii?Q?9mvVOyRsA3Hxn59vGpvy+tccBvIDoKeufRlwnzVi0oPQvTxi8mVnesCBYZYK?=
 =?us-ascii?Q?LF3+knstVdOzKXq5+lYD96y4qfbDm+5E6RlZJhWMQcLxBcUALRdnj/aomaD+?=
 =?us-ascii?Q?PWdtzKtjJJ76YviFhMjxwWjFXdOhwjz/K3OqqI/5cwRqOgdlkZr6hZNsUcXN?=
 =?us-ascii?Q?8VvWSA1jDAIn6iZIvX7UnE5aOqbLaMWDA+dbHj5rJfU4e7clMgxPCitpc+x+?=
 =?us-ascii?Q?IwwFqoev4EOUClSYXWVslrMOLENbLX6vCC/GHI6qt5Umwy4UwIw7vlTCB70+?=
 =?us-ascii?Q?IuF8NkRUbkjUyttfz6BXr70bFslcdFTkwmxm3ubFnvBdsRlFfFsPsN+18hBs?=
 =?us-ascii?Q?r5aIL+eatrePtGfOrRbgFaDi/+iHDZZYyu7R57Xa2AoeQxvT8FYIzNcQY7YV?=
 =?us-ascii?Q?fj7RKI2xvwaluPwyneY/1Jz78tnSWZbWZ6ayJZj/u9BTqx4BgHuUS3n7M2s3?=
 =?us-ascii?Q?u+JDGcI+fIB/TP9CD7EooYVI+h+wKGDpAMPKefnK4XkrgvryLvjoBKSxo0wQ?=
 =?us-ascii?Q?FyUFx3b2Hh9l0WDYn4muco1P3mKy5QMKL2rqdPHB/mvWxf2EpJLYh3kUh1Mb?=
 =?us-ascii?Q?BXcBe9FsTklZuAh9s6hqjjHC3wmKXinatVQNPXpVRrvOJUQayCFWQ0Fhn8zR?=
 =?us-ascii?Q?Lj9zOFDW4g4PrAJnfCJDYmd5YaOWELXELTVGqbI8jKN+uixRB/KGn6tS4XA+?=
 =?us-ascii?Q?N/SOJNo5CFb764DshCCZobYf3qr4Qb4YS/fsodVLmyB35e53t1i+bcB35YxR?=
 =?us-ascii?Q?0osR3+Z+vTwzKiaUy5etUP6UDr0UZXw=3D?=
X-Exchange-RoutingPolicyChecked: FLNEpD0Fv3AYU2IiBIP84HxtJ70EmE4cQCCYGh90Hw9FJxvWaTVADReY796rRuOlb83PtiLTbp04eofoZl4Amijjid+6T95tdJX3W1UVWq9NE2YF90hKndQZI/Iy3Ja45eohpLDvXtrFPPSpaf+7hwTengfT0v6VLjImwhOySiiya/2ivR2tOrBooowawwC78vWpUCsnO9rQYLfgR60qLPz0UW7EHxvsFvobZY39PVdFv0k6iq+2TChabKehtZ726ThDGRSMoI8L8ybxeiHHWGuVbonq7rzAr1O4FvwZhDwxCjUprerJwztagxAJJ6Rt7Oc0GTK1qmK+mvhJiMNsOg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0dc7379-ec89-4700-beb4-08ded90ac30e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 13:55:37.9648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zi4knlOj/U+h14FlC3ZizaLdQoOvEoZes3YrzrisTuhCFUeZdIuXZg8h4ITGwDMCulzAh2GKsDnjZgrfaUC6YX9cqUHdltnuDl6cK0g9k8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB9016
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNyBTYWx0ZWRfX3BlQ97Chdaau
 iMQNe3sRgHyi50J+YkeLHImODihRjHNz63bgFIz5JI0pl7Imjv3pzI9w+2TAcbZMi/srs4/8fYt
 SgyfCXfHot6OJhe2TrA7GLlO36FDPocbbYBuco+pw9tMW0TTs/X9u0jakhnKa0IMy8Cv0qvvs9j
 SyWPy8tXEAnb4ShIygt18xscrGpUZh9LUT46ww2prLPn+XOoFkzyE9wIQ61mHYho6TpGDm1d5Wv
 w87YJRo7gi5aknzjiESJQPsIImzLzxP2fYNMusBXj+YeIay9ebEgMk74FLeaB6mmLQYmRBv962T
 VJ9jWB/Wry/OdzhS2N6Ihma7yJdllfmRFgm5N4IEnOkSKfJotpO1iDMK0uKA9L2B0bj+1kDoZbt
 bOzJBkVGfI6xk65yg3dkOol3M2YBlhWYgLZv8zeAsyenSen8rVN/pLrRUnK9xTWMsMCN1Hx8Jf6
 m2vX0+xTeaXkQLJ9UiA==
X-Proofpoint-ORIG-GUID: XOgCNsExYx6Tbd6cSiRfckgeDzcLNu6I
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNyBTYWx0ZWRfX2pJCDzDG7aMg
 +hTSA1qaXSDf/uybPcBbM4/zhnx9SmpiFwzboZm1Xh9vRN5mV1hdhwc5OufGBJ4kyfoHCtP8Ecj
 DneDXE+5u4qmD6GX+d5OGP9zBrjP8TY=
X-Authority-Analysis: v=2.4 cv=EMM2FVZC c=1 sm=1 tr=0 ts=6a47bf5c cx=c_pps
 a=pRYMHFsXyG92p8CuKGQZlQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=cyJIeLrgMFebCcwQBtwA:9
X-Proofpoint-GUID: XOgCNsExYx6Tbd6cSiRfckgeDzcLNu6I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
---
 include/hw/acpi/ich9.h | 2 ++
 hw/acpi/ich9.c         | 8 ++++++--
 hw/isa/lpc_ich9.c      | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 019f0915c1..30990fcef5 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -81,6 +81,8 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq);
 void ich9_pm_iospace_update(ICH9LPCPMRegs *pm, uint32_t pm_io_base);
 extern const VMStateDescription vmstate_ich9_pm;
 
+void ich9_pm_reset_properties(ICH9LPCPMRegs *pm);
+
 void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm);
 
 void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 5c7dfb2c69..5e8f8a7eaf 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -388,9 +388,8 @@ static void ich9_pm_set_keep_pci_slot_hpc(Object *obj, bool value, Error **errp)
     s->pm.keep_pci_slot_hpc = value;
 }
 
-void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
+void ich9_pm_reset_properties(ICH9LPCPMRegs *pm)
 {
-    static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
     pm->acpi_memory_hotplug.is_enabled = true;
     pm->disable_s3 = 0;
     pm->disable_s4 = 0;
@@ -398,6 +397,11 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
     pm->acpi_pci_hotplug.use_acpi_hotplug_bridge = true;
     pm->keep_pci_slot_hpc = true;
     pm->enable_tco = true;
+}
+
+void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
+{
+    static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
 
     object_property_add_uint32_ptr(obj, ACPI_PM_PROP_PM_IO_BASE,
                                    &pm->pm_io_base, OBJ_PROP_FLAG_READ);
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 9cec18a378..edf9783ec8 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -701,6 +701,7 @@ static void ich9_lpc_initfn(Object *obj)
                                    &lpc->smi_negotiated_features,
                                    OBJ_PROP_FLAG_READ);
 
+    ich9_pm_reset_properties(&lpc->pm);
     ich9_pm_add_properties(obj, &lpc->pm);
 }
 
-- 
2.43.0


