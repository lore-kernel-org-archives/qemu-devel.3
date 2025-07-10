Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BF3C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 15:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZtaK-00032u-Tf; Thu, 10 Jul 2025 11:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uZtUx-0004tV-ER
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:47:53 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uZtUs-0000tp-SA
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:47:47 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AA2nvA010933
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 08:47:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=yo4+S4np3jNmR
 TBIusS47+N0pD0J6H4ypRfJziURAPI=; b=dO/XwEerNFaZnKAbwkJl52Tc52QTU
 05DEAs6pVu6YjcOysl3tqPoY8kTy0nj9aUjAKGZoW2N2ubbllBYZX4w6yws5WulF
 azb7yo9r31iiypQ0qcprNU9VSoOC5VlOwvYQhzKMH2ITsiWJy5ZsEn4xnveQmj5r
 ItEz4MqeOcAdJ7WzYelkNdDbH7pTffTfvOaxxTKqKKlGOEIMmcc4ir6umgSgjfi9
 YrQd8JsP3Fz0zk7btPUZPaimn3e1VPDm9tnJJdG1Qg7O0wONHhMVCO67Spun4kbJ
 Ni1Jmc0/hBZlzD0I72UJTZ27lwKZIma4Dglg5lkeCTZs3RAWRlIqh3FFw==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2100.outbound.protection.outlook.com [40.107.244.100])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47rkcn21ws-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 08:47:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOjm6OvQT2EEtJZrP+x0/xiTgRYAu2DKwy3V2UvIyg+yVD+hkpY2H6bHXfQOr/pruFeWEZgg7EV6hdO/jbPAdiOABEedWMPLYhxd1maTyACczqaQ80A9cNxP/Xz6SuiYJ2xKMP+5aC7fSZfFxiQtpnEshRYjc0UeyX/l4reMYHgUR5XVQ4sCqyHIgeY0P9/kQG0V13BymJCap/tfhGp85w9/KtaESZ38OIbgKLGA61I9JE72PB1gysP1sf4wg63nVqAc2k8nigWH+sPSVt4alrt9q2XQhYnrE7/unnvDVqIez0qpFW/tzPBTzbj2XC4kht0CGFIDcdJP9lx3WlteYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yo4+S4np3jNmRTBIusS47+N0pD0J6H4ypRfJziURAPI=;
 b=jL9lz5ZoVFxaePWkbiMsm0mbJknPabuiH8ysBScyNrIZavsKT66JuC/E3ugmHgOywM6yN0z8YGF1tnHS59TjefhYQfMr6P556MpqEG1gWZi8ymyxb1zE+uL4HavOOMAx9rx207EBzJly1WSZk2YdjLxnNlbkcJyztmr1Zs1+8fJqLtEJRtPN5WixRkbY+oSI7dMYyNSgBXRB3vbWkMtC8qnfmkYzywAxwyD+RIG+h+ZWy/16bzfjFA4MDumTjVVauyX40W1dRAI1LJcgReegwBreQvtv7AetQA3Ne4bj2PNnZeGx/K27PxZ2ZarwcuDLX0wr4BHbs70XaS/fIr4XJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yo4+S4np3jNmRTBIusS47+N0pD0J6H4ypRfJziURAPI=;
 b=fzLD9LTt9BGtLFUriQfzAT7GwbYJVhBNkAdedaXXF1qPIHfidn2hGSfpPDy6redmAbbfGkUkB0v3C9VHqQz3DkXYwYi/gyABt7WBXDnPUGHO6A4FjhpRTu5zee1o33QMBrGdvczXUYmtDlPX3puD6+YeDczmqxnKo37ZUCIma2wA3txNVlw2S9niOl5uwyr3LV1UXYf/PY1gigpEFKizWmyRPTOOoC09nKJh32FAaWfn8nYtLfuGwG0SUKF52jGb2aHe2S4O+adFgvljCEtZGocA/+N00O886tjSwNn+N46/mIy2Zs08MOUoeMkRzPek30wv5pNlEekdkvKp1oaH5A==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH8PR02MB10897.namprd02.prod.outlook.com (2603:10b6:610:2bf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 15:47:36 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 15:47:35 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH] hw/vfio-user: wait for proxy close correctly
Date: Thu, 10 Jul 2025 16:47:31 +0100
Message-ID: <20250710154731.1266732-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0052.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::24) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH8PR02MB10897:EE_
X-MS-Office365-Filtering-Correlation-Id: 88457613-58e0-4241-e69b-08ddbfc916e8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g+F/05HvdA86CP7I7rC6BrNi1iMXqOI3EUsQPkC35TsFavGfP7WZlRy7/kLC?=
 =?us-ascii?Q?y6MnNC/uabCmUOalDr8BTsYuKocmHBY+ghjWECtU2y+BdjXDdred3McY0ZuB?=
 =?us-ascii?Q?zzJojNYICjOGCVGn1iQayGYPsDbSdx6DeTDQx9Veg1b1b1CXYNCZA0dkYWc0?=
 =?us-ascii?Q?gTshNhdLIJgyP9BPlJVBFFNkeENzDLZ4J/0PiAgib3S35uKzrg2j51GhFbpK?=
 =?us-ascii?Q?XqLrDogxRBcHPGZfy21rcGWeoncIlseD2bL1tisXKQs+xIhBAhWV1eFeUpPR?=
 =?us-ascii?Q?p3CQR2A5NpL+bOI2UN4HZc1htynuemiCN2WchatzZ8s23Okcb6MEB/SlKbED?=
 =?us-ascii?Q?rboqewTfMn90ORP9PhLvJyEmoihiIUITe5sKlni07G0LXElRtuwV3SfnmT1F?=
 =?us-ascii?Q?QMMAR2S9Ulknr+AeCXIlv3KAjDfDMdygKpXKhLClcpZP5sY4deVw2OD1fr+3?=
 =?us-ascii?Q?IaGT5hipUYGGmx3+GJfplKnVNOaPBH71XVPknHlV4vTgb1x+AD32CbtHO43J?=
 =?us-ascii?Q?s+d+5vF3N69W19Sjn00r/+q4utZKz69w8s/t87rpmedgF8PCKgoQZ6XsylCn?=
 =?us-ascii?Q?zg6pt/GNWDycHfM/2sMmFXZnGwZft6P4k8RYmVKPuZcf8XrMz0B/4txKotlJ?=
 =?us-ascii?Q?zs8EpXuxWmuKMceM3KE1wVa5PbPbP15cgQlC1G6SUTm/RPpU7WVOQXVEbTKP?=
 =?us-ascii?Q?h3MxWHTYprJDw5mulf6SjPIjmCJWsMjTGyv3h0IPPoGFwDszAN+kLt5Wpg7C?=
 =?us-ascii?Q?DHrpIQbUmTqnd4CZPb/3F4cHNmvpgypPTJk5bmDZDDJ5hLys/PjN6q1hDF2n?=
 =?us-ascii?Q?/OLvR818AEpb5RG0n1XA0kr8pZEhUBuZjs/u6R4XQBMBxlSEtrCEPDqm5xo7?=
 =?us-ascii?Q?XwIpM4cxUj3D0xdktUU6+6fQ6KcQVS+FPHbe5X/CWyKJdE58mJs4pNPOzXZn?=
 =?us-ascii?Q?kvtXpJBsxBPWQIHkYTxK99OYKvorczj/yMiR5hfXx4yD4ZNV88oicjbbUrVX?=
 =?us-ascii?Q?ePSuzZ1LbIEAdSBqn982Q16bZJNok9KR9NaC7TqWSfaXJFrfW+fYURGflmKz?=
 =?us-ascii?Q?QisL2DH0i+PezXFMfnVPwq2K8tnjkqbNI1uuehxdKmFGoQ5oaYQkMiEdY6uC?=
 =?us-ascii?Q?bwKpCGL/3MIWtZqNofPSeongeQBSPhKiwXYjJAo2AlHm96z1n3lnqq//Mncj?=
 =?us-ascii?Q?TV/u+TGVC3liFXhO9/L1zZ5vO9LCOIsKcGEWMp7/53BMSpAbkVaxJer65+gH?=
 =?us-ascii?Q?eO23eqhrEemBbeVyKgmrwngkQW32a9ibUfHXK1zLrTymjbkVD9vzkJhUHvbf?=
 =?us-ascii?Q?3NjlUGSqbCMwAEcyltCLwQBYkYgGeLpHjQnKlsx7RNRcdDahToVS1oFQgG2K?=
 =?us-ascii?Q?6crewlHxUPKnZUEGg6CYgUoylxuAwKqlZStHShB4bkTZKyQaMu7iKdvxAaxB?=
 =?us-ascii?Q?CPJEXa7/q4s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5C+l/GwElcz3HsuMWjBM4FwowQbzoyEhs3iv62+rbSEaBrsa26PYvUPnB25j?=
 =?us-ascii?Q?HqK8q2/c03gONiMD5ys3D0bDjdjL1P1iEJJIo6Z9rszYbHOH7tLXV6B4sHDz?=
 =?us-ascii?Q?dHeFoe8C/BAEzGUrj4/aOGI4xjxCOHXU05ymRP/WAFWEpcGYtlSQBldP+oL3?=
 =?us-ascii?Q?9KU3lVpWj/LzpHADrQ1x1tq2t9fz2EbZmA6Go5V41KeWF3Zjv2JykTNsZfXZ?=
 =?us-ascii?Q?o+koXAtdDNhAX0Kwpb1cRJIxFMLfVxz7nSZgrkdI0HoFepbkNdxmuZ7AYl5q?=
 =?us-ascii?Q?l1Tv7Ohe1LJmwaVPM4/5F6Leyas6qgJ6kSE5XhW5pM3Vrm/yeMiRDDHAVkl9?=
 =?us-ascii?Q?/fygS7uVyj4Qw7jSbl+k3vX6zr1ewsslcB+64PT10S+rqu3Lf2yZQIXmB+9z?=
 =?us-ascii?Q?CFiBU4macN2kNs4ZgWQGl5sopjyffauDdxHsPoRtgyel+eFHCpZfW6jGjP43?=
 =?us-ascii?Q?bOpMAuY6R4csw06riisic7uA9hwTCmzVb03A/CW1pZnHdvi3ep+0o3AVYnXY?=
 =?us-ascii?Q?Rj+L4ON4/0hUvldiEDfATFAAQlZRlyiEAJGkYqxL6i7oxJQdVsjPTjd/boWK?=
 =?us-ascii?Q?h/2RZhRVp2kXoV7u713EXG98hAKAJMfnEooDISwldSrZrAGYs8N58zXNqnJ7?=
 =?us-ascii?Q?LSHJrpLOqnmhsvI6iglC0FyLsqsEIeMbL5PNsZVFvb1Jvi3CtfKHtKGl49JU?=
 =?us-ascii?Q?YoiwcP+aTYBdb5FpvbwKdgZ4yos1+HzolVZLsapDM6Ub847n4ik4PvoZFIt8?=
 =?us-ascii?Q?XAnKvYeVuldAVF+wPYt0xVZ12oBKD4pTTzJ65GbRDw38SlGOI7fG+/FT/qHE?=
 =?us-ascii?Q?Uxbj9Hz2K2vraE7DP66SGa+56tlkdcN+0OPqBLeroY67ouDMv0tyxkztc/yC?=
 =?us-ascii?Q?OxANmncomZYEcnDTXwInibiRUhdIyObdjuvSWC+JgG/l2rqR79RtEz2cDhqD?=
 =?us-ascii?Q?gdiMpz5VqB+23nz66HNe/byl7QmFCWoqAbL2daQXm2MuBD69LlQZmC9Lg2G6?=
 =?us-ascii?Q?5iFHreg3HAWIHdPhmsCLK8GqgAxy7pHsOE9OClBmjpK9/UumZxrPiko8sfJV?=
 =?us-ascii?Q?hIby7opjs9xzMAjG2RO9UMqFz+oUpX5w8LDRdcnRlGwwPmgRkMWJ4RB3lllT?=
 =?us-ascii?Q?G8k54mBC5SO2gf7I/rgvYGf+1pGQI+VqE29P7eAE9GGX5mHjokguaRT5FWll?=
 =?us-ascii?Q?LmBm0Xjr1+6x7PK9Tt2mUsw0k2SzK+WipSaztzbI0r/WfAsJXXE1zNEYBoQx?=
 =?us-ascii?Q?kD0PDKk9zoBciB0PIrlzF5WSG0fOwN/pBxSL7kl29soUV73Ihk2AC3nF3qzk?=
 =?us-ascii?Q?yxVraec6TRlEjU2+3mv3NuPloRFFQKQj8LGrdx4hloH1ZobPBv2D2jZTq6MU?=
 =?us-ascii?Q?KtKOL66E+lUjKBXH+qC4Z6jNVaXymDakQZfQpRSERHTprzYcxP0mYUg5hlih?=
 =?us-ascii?Q?GYcLC7Ljv4iGpQtfyf4L8dc+6cdBvLUD8Qw8jxnYg8kXObwpPdvaGdWy16WA?=
 =?us-ascii?Q?slN7LMprHlPZK3uLWgkkfsKycRUVuhPiuhAcZsJovh3QGgoyERB31Dt9m1DI?=
 =?us-ascii?Q?vYW1AS3xGDgjyX4An1p5OrjhKBVS4kGoRf2LYGbq?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88457613-58e0-4241-e69b-08ddbfc916e8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 15:47:35.5449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4D5cfjSlotifv19BZCPcCStM+i052g9r1tXE7l0PSEUJf6LWuwJEp/Xi/YOBsS1xxzPOs4X8rPflZ6dSuSgAIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR02MB10897
X-Proofpoint-ORIG-GUID: lK9KV3mtnAPLkoxz1EFsAM0ZrwnqD_ay
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzNiBTYWx0ZWRfXzLoX5/r+K5gm
 +tnl+wfGegLNR9PU/9ERs/HJqXXujhh78LhvRld49PXBV41e3eOlnGJk4x4cqzdUzaxVEkRCGds
 n8gnydnkBj1M8rqyN19nLwCp0MndbS7SHFXhTC6TgE8oASqdsF7cVvDUcr5vQOGIbLm6QTJlKc8
 pQLmWlQYA62Zd+eT2upvl9nHCGoY20NDR6lfR1uEXotkfRTSy3z7bx4y9NUbQ/lfGTsc3hHvqBJ
 6+QtSuMOsGplxfrcxH5xuIVsxVUiOXKhgv8iS26ZZCM1LPGIyxTmcAWftoFjsd27PoLqst3NbHz
 j9R7umisgE/X2ZJM1LuRcoFnMpbLsG6OZrIMLK6ofJF5+qO2mNAnRyE2DzaMxcNTT5jUw/O3+Fl
 cvzVI0YLCpQvy5uIuv58rqlyMcq6tLhN+fbx1+OuWq6GczlPjzXIETwYGxFYMexznQCba4r9
X-Authority-Analysis: v=2.4 cv=KKZaDEFo c=1 sm=1 tr=0 ts=686fe099 cx=c_pps
 a=X0TKh/MBF1+/LqYN1SieOw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=6aF94XPOkflKZwprq4EA:9
X-Proofpoint-GUID: lK9KV3mtnAPLkoxz1EFsAM0ZrwnqD_ay
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Coverity reported:

CID 1611806: Concurrent data access violations (BAD_CHECK_OF_WAIT_COND)

A wait is performed without a loop. If there is a spurious wakeup, the
condition may not be satisfied.

Fix this by checking ->state for VFIO_PROXY_CLOSED in a loop.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/proxy.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index c418954440..2275d3fe39 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -32,7 +32,6 @@ static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 
 static void vfio_user_recv(void *opaque);
 static void vfio_user_send(void *opaque);
-static void vfio_user_cb(void *opaque);
 
 static void vfio_user_request(void *opaque);
 
@@ -492,7 +491,7 @@ static void vfio_user_send(void *opaque)
     }
 }
 
-static void vfio_user_cb(void *opaque)
+static void vfio_user_close_cb(void *opaque)
 {
     VFIOUserProxy *proxy = opaque;
 
@@ -984,8 +983,11 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
      * handler to run after the proxy fd handlers were
      * deleted above.
      */
-    aio_bh_schedule_oneshot(proxy->ctx, vfio_user_cb, proxy);
-    qemu_cond_wait(&proxy->close_cv, &proxy->lock);
+    aio_bh_schedule_oneshot(proxy->ctx, vfio_user_close_cb, proxy);
+
+    while (proxy->state != VFIO_PROXY_CLOSED) {
+        qemu_cond_wait(&proxy->close_cv, &proxy->lock);
+    }
 
     /* we now hold the only ref to proxy */
     qemu_mutex_unlock(&proxy->lock);
-- 
2.43.0


