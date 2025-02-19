Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7036AC021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 14:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklPV-000500-19; Wed, 19 Feb 2025 09:50:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklPS-0004n5-BC; Wed, 19 Feb 2025 09:50:46 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklPN-0007di-S3; Wed, 19 Feb 2025 09:50:46 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JBKnF5003929;
 Wed, 19 Feb 2025 06:50:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=3UIxPx86gPTh5N+zlwkv3sY4JZRFdiQ7kvskGd/V+
 eE=; b=u47DgXi907QqMs1tod4lJHzVxJQzZZ8y0+lIdmLlpTIGzZdWRAtUXDOqc
 ausAWY0kgMx+N1gqBokG1UjP4hnTrNUfh+zwCfy1A2Uzf3Oopr2W5KALWqmvaSkB
 2OulGiNigCahXCZJVNGSVclFysF6sOt68b0WtsvichsrzZyBOYCBF60gzN34hpjV
 JaUkzeUPsPv9hmNc7CR4iTiEoO5SpLJrNgQF002nOpQJZ2ecYaSc/o/uOvGdILth
 UhSOWFIcSAJK7VYydzdNaEWGu2pIZPmmjC46E/QkwV/AaRg0wJBQOi/HRVERdY5T
 hUmCWnIH8jl9E1jxC6SVBgVFvy/ZA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 44w4bdhy0m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 06:50:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oD2r7wiYNgBIcUvC/7oD5OMQXfa9rGkKdClzxopVXCIvA6vkUEgRK9iQTU/m0BXzc/LdLHFvOGiNnl+XGsENl0p3Qgq/EV3KTE3tAseUDRIQCrJMLMzRQ3JNvkftgbeeWy0NqeyC1lP00BLLrzPk7Tfx99bJC8S4FuAg6/Hld9dNxpXdHrB/RgI8T7CYvIhkgDrfkvgcA4fybn81bv6G2sOHV5g+B+nJrPUx6L8wt/YV7py2yyqilG3iqIsSQ0PXaog0xCuRUBpxSIBZ1/48OrjvAxeEADkq/ui2i0SRLu+ntPpfIeYRDmWzOJyFKY//24NPBfISPZ6yLwL8juYlLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UIxPx86gPTh5N+zlwkv3sY4JZRFdiQ7kvskGd/V+eE=;
 b=P7nRON6v+6cjjN1WD7XNTeJIj0AWdWsxCwofy1tht/VufN3wvXwF1txb2yP/Zz9d0L9jU77kQxy43bHZk9Lx9KXK4bkqCWh1zBkNPUFsMIDmfijOGO5NvvegItFAXzgOTXfcPI3lAe3ajsJbB7GU/vek6bATXkhkf9ykFwT09SSNmBGrzvX7QI+5a8tAnOAMVu22uGI1ZJ4AyHcMtXZ42AY1ipK1Rm2f/aAje4GPIPXHB2sEdSkh5azexePnT3EFTZc4PITyFlANyNxxBMOFnIFBKG3pQsGeROA7t02hyulN1WjxYZIdekFYIPp6XzsmcTjQiM1V3CywaHrGzMJzjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UIxPx86gPTh5N+zlwkv3sY4JZRFdiQ7kvskGd/V+eE=;
 b=rzkccA/Z7rYn6SEwjF+HZzsyqg0xNx25shEYnyGWBRzBsW4XJpa+Lyiw2elj395i5e374r4Pjb166zkodK9+n9ae4mE44lrRJHCTX++EMtw85HVTEKM2NJdQU5b71GfvpLnXeFfRmAKjCgizbJygZ0oSsfNMVVbxowFE4n0Ixgs6EAuqjZWPLnLA8ismPYRPdl/uyCYQpxDM1zr3i93G/TU8NjWxHgDQYPkGsyLBu86ZmpinK39nC3QJh9dU9pPiFFvJDOCiWNiDEwv0YDlXnSvWYRCPNHL0+d7y/wmHoq8SixtzwJ8ITsXaxFOiTkgnDYuAR23/keadCxMKjivPww==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by LV8PR02MB10096.namprd02.prod.outlook.com (2603:10b6:408:181::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 14:50:33 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 14:50:33 +0000
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
 John Levon <levon@movementarian.org>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH v8 24/28] vfio-user: implement VFIO_USER_DMA_MAP/UNMAP
Date: Wed, 19 Feb 2025 15:48:54 +0100
Message-Id: <20250219144858.266455-25-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9d629eec-00c3-4118-28c4-08dd50f4c321
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HOawGSZJFvqIj7FEQdv8mdJeK3r0EDPa1foov2l2HleU1MJnNsXxq7d9jRI6?=
 =?us-ascii?Q?k6i0Z1KaulNEWrtCtbOch6EUpmZ+motDOTn5jp+4HE+SQvsGeuA4DrATrn2m?=
 =?us-ascii?Q?vCIR1baEkTizAUTZUh+PpmQ4+48p9ng3SO0Y6eEE2Y+a8kiBRHg7rl6p9IUW?=
 =?us-ascii?Q?ZEzoLwJf4GraYipoVGmQPubcVVSSV1xsvkCowcvnGDfNuipcnUvWQZnckedY?=
 =?us-ascii?Q?wfpr/Nhl999GRRDj59kZCfbNFS1fx8CQTp3evW8XpJJk3Bf6CfB3Q/QklgNx?=
 =?us-ascii?Q?ThkBGY7SK9MdoXGqqLZHX0dmbx4kGRMNWtPsT4OO5FkEM6t/6H2hqUn+XcSy?=
 =?us-ascii?Q?9QUWJDZF1Da2JBCQrMxocJfX3SxytWI3724T4JbbyDAbMox18XgIancfId9/?=
 =?us-ascii?Q?W2R1qx2RNLvolSRvjO1+Rl3q3kV3jAfKZxNjLSweJ42CbgvCUHcCr3N2GY7A?=
 =?us-ascii?Q?nOa7hKv4OGk6J32u2o5Z5KuoF0P7j5WcCk8YgWo/LvmqT7X5tMAp6F3IvdCo?=
 =?us-ascii?Q?wKsudixDXibKy07A1pmCIlfQUadxIvpQ6cmV0TDWwYE6VN7mdvTPRE/Y0hVg?=
 =?us-ascii?Q?V+U3R8+vmwgwdcVmyIk35NJeSRuHEaUDydl9wt9QGj7eMnKq8F1FNZ5d7SqB?=
 =?us-ascii?Q?owbw6uZkuJO4iqzKToWdTTpcigOtW76OovMvCUWxumFGTMsZ97uub9t9ufis?=
 =?us-ascii?Q?oslfvGwH7zDkxmmT93A7cH0gV8Px4uhUMcNuGGECcpoeMbTLlaI0Xg+IUzo0?=
 =?us-ascii?Q?EFFJXK123DqA/Y9gn3poaXNAL/Oh4M6mnVuyoe8ILLp5JYDE45eS0AjxO2XY?=
 =?us-ascii?Q?6982RJIZ2WSwh5Q2+yMZI1dsA2+9GLZCcCedKlA09e8+7R2e4Q7HSY65iTeX?=
 =?us-ascii?Q?0f0VRQzAIS58x2dSPn4x/ZSNeN2Es/Frjecx1/65+PoGOsNeQ0XAXqLc2B58?=
 =?us-ascii?Q?TTRQhpE9Z+THA9F/v81t67xmuhDRFZQaEXa8tkAL9wMRUDVppUybN8hRR5ls?=
 =?us-ascii?Q?g84Uy7FCSbLLjjuH4BVX3VPehIa0xUKH+asPa4UaGufJOv35yDsd1nibsfR6?=
 =?us-ascii?Q?9gJxPGoVCLBpEAZaNMJCcV0wZw1hKQgmV1qlUjs1gG7ZTyOt9L/w5xBIFcJg?=
 =?us-ascii?Q?K+YAgDs12o949gq9zDRDpIFlRU7UqvVJ+lH471InCT7TPiJXJFW5zxN+uPmJ?=
 =?us-ascii?Q?nSnmcWtSbQvmXtqP5ICqhjbHhAYHSqrMdSePQElyoAJa6jQb1qSAtunf6M5J?=
 =?us-ascii?Q?NuK4ayiQtjLhYHHuneaVyEtJE/L2nH6d78oUw7sa1dLsjQImZ5qmmZNISurg?=
 =?us-ascii?Q?el7tCndZZOt2a1FBYQ2qwfekWM9zNGtqBqZil5G5FPsmLRDS2/WxLAK+ylXF?=
 =?us-ascii?Q?XwPYXIk60Fb4i7uwYr1Wx8V1Yl1e?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bKH7q5XHvb79yplWp7yXwFirZRRyX3R5pxeSbg99agYblXaaKvS6obcX2k1u?=
 =?us-ascii?Q?3aTJnpQUTCXQ5CEhE84RuHSmAF2GpCsCqMr7BxqVqAcA1/m6S3FlmRwmwNaC?=
 =?us-ascii?Q?/jkyPeLcsK4S3yT/iA/ieD2sTpyHSWduDJkBb3n0aN+k5u3gUQtWdXC6vmDL?=
 =?us-ascii?Q?/36mCQd7jqfAxNi5EF9jajlOkZqlR+b2C/DZsp0E4PZAJSiZQNecZgc0hwRC?=
 =?us-ascii?Q?UEUbKC/TOJVp4mr+ZvVK5OXDHdVkuxSN99ASC6paeFB8ezxjBoxMyLZCUkiU?=
 =?us-ascii?Q?qLqoTJYkTpSpFFemjdPp/D5IQBSPNtrbzh2QvpUwjBMsR7RKpgJCiPx4E3Rd?=
 =?us-ascii?Q?rZbsUx+TR71U48UELy53NER+q9qFRqZoPrLva3JUg+8+61MBkSB8Vg9YpM2R?=
 =?us-ascii?Q?h1j8rzRjxTk5gYP1CGTEGAR0nV//YGpq3S3jL/NsibHmY4TNoL72/T8WNXts?=
 =?us-ascii?Q?y13g+Zmd4rrRtI8Puu1kuFFyHM1ZAvWM/3+VVJG3eMKubyHop642Zq+fYDUD?=
 =?us-ascii?Q?CqHuW9v6RAoiuFn+3/PkzIGsr1LpyXtYsF7VlgAukSufdsRj/NFczVGZR6+N?=
 =?us-ascii?Q?+3A52hoQWiwSBMEg5Ex3LMhq0VqEvlQMfY2zcWbn69LiDSZcFf3Us95XnB8U?=
 =?us-ascii?Q?4fPanL2SS7r3oh4LTXLQHL/YRHF4ZA4If8mFVytgfzOWcz1jteWAzFaxLG2c?=
 =?us-ascii?Q?WLuD26z7PtUXVU8TEsJM5P8RZQ81/1JNCEnRPw0G5wLGhVjP2K45nU+B2JJc?=
 =?us-ascii?Q?YEEncpR+TwY2mjTypCedDaFJ/D2BszUCktG57VrZYm4pIHRnOsCnkOJTOmCx?=
 =?us-ascii?Q?rH3FDaJvz0InQ8M2ICwQMorg12WJ07lMP95Y2uW0bHFK+EJVhHxcybeqC1+f?=
 =?us-ascii?Q?P5ArfSKLNROB2bxOBlcte7EPEMkm8K48JHrs/BVgSrgM7TRiXMnAdchKSBpj?=
 =?us-ascii?Q?65UIsLCzaxdTWuUZeje0Pd9cIBNcekuVeVcgNI31G2PDl0FO2qWTiLye6ntI?=
 =?us-ascii?Q?mBUrFOEtfNwK4iOPV4GxaK7RaerehcLqd7hBRsguv+ciY/AQ9d8w5847y0cT?=
 =?us-ascii?Q?cJCBxaAf4CgPpGYmTc7JAhKIRNa/1zHoKU3b8JzdBoMM3UxVdRCstOg2BOhw?=
 =?us-ascii?Q?YWmpdsa6keSBzFYQ+FbjusAvPq+S2mhdbilHFV3sW+oANWEo/W3NU5lXMTEu?=
 =?us-ascii?Q?H9LpU7FicKt6hcPORtzrTCNVzOy0cCuAaJRYq1/xoLbo9yn3z4CTstfrg0Df?=
 =?us-ascii?Q?h4Dy2G1hGdV3Om3CR4Rgak85kR+xc6PppxPjfkTNlCG8+bwytZk6qC0K5g03?=
 =?us-ascii?Q?akKX0R9PJFQU/SbIoUhDgpBJXnu5KrJHFc3m8sKBTxydUXaMb2tEB9PpGj7U?=
 =?us-ascii?Q?vXLLwN3Bu7PBYNeNG6ZRpFwA80qmfIGwihDPk48Wbzz1Si1mHgdusZz2yVpq?=
 =?us-ascii?Q?0m87VdawZLt2HMURd+4mbIGCt0iH43AcyKW5MBCL2zxauMWVHoRvh7qQyLo6?=
 =?us-ascii?Q?8spKFuBLZMfIDjC0a1cKLmhCwOPloWlwl97YNyiPpD7bj3NyeUzCvnzEFpjS?=
 =?us-ascii?Q?kgE9lWU0z8kB4bfm8E226dqIQb+L3aSoZyVJSy/e?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d629eec-00c3-4118-28c4-08dd50f4c321
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:50:33.3934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rh6qfAj1EXDnl58/8/DKiht0FjOenl1Mom1PosfYrWe8LkfTb5BQz5nOwV1Ybq3JFSXVvwFnk4ts/TPK6DL0cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10096
X-Proofpoint-ORIG-GUID: qg9YaZBJwDuQWLhOGS82Y4hF44JpfPiX
X-Proofpoint-GUID: qg9YaZBJwDuQWLhOGS82Y4hF44JpfPiX
X-Authority-Analysis: v=2.4 cv=Fo7//3rq c=1 sm=1 tr=0 ts=67b5efbb cx=c_pps
 a=WCFCujto17ieNoiWBJjljg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=RQZ_2NmkAAAA:8 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=LQllIVlj0uuMV4zLHkkA:9
 a=46pEW5UW3zrkaSsnLxuo:22 a=14NRyaPF5x3gF6G45PvQ:22
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

From: John Levon <levon@movementarian.org>

When the vfio-user container gets mapping updates, share them with the
vfio-user by sending a message; this can include the region fd, allowing
the server to directly mmap() the region as needed.

For performance, we only wait for the message responses when we're doing
with a series of updates via the listener_commit() callback.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/common.c     |  89 +++++++++++++++++++++++++++----
 hw/vfio-user/common.h     |   9 ++++
 hw/vfio-user/container.c  | 107 +++++++++++++++++++++++++++++++++++++-
 hw/vfio-user/protocol.h   |  32 ++++++++++++
 hw/vfio-user/trace-events |   4 ++
 5 files changed, 229 insertions(+), 12 deletions(-)

diff --git a/hw/vfio-user/common.c b/hw/vfio-user/common.c
index 160a1f0536..b78b9e57e8 100644
--- a/hw/vfio-user/common.c
+++ b/hw/vfio-user/common.c
@@ -44,7 +44,6 @@ static void vfio_user_shutdown(VFIOUserProxy *proxy);
 static int vfio_user_send_qio(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                                      VFIOUserFDs *fds);
-static VFIOUserFDs *vfio_user_getfds(int numfds);
 static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 
 static void vfio_user_recv(void *opaque);
@@ -57,10 +56,6 @@ static void vfio_user_request(void *opaque);
 static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 static void vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                                  VFIOUserFDs *fds);
-static void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
-                                VFIOUserFDs *fds, int rsize);
-static void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
-                                  uint32_t size, uint32_t flags);
 
 static inline void vfio_user_set_error(VFIOUserHdr *hdr, uint32_t err)
 {
@@ -152,7 +147,7 @@ static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg)
     QTAILQ_INSERT_HEAD(&proxy->free, msg, next);
 }
 
-static VFIOUserFDs *vfio_user_getfds(int numfds)
+VFIOUserFDs *vfio_user_getfds(int numfds)
 {
     VFIOUserFDs *fds = g_malloc0(sizeof(*fds) + (numfds * sizeof(int)));
 
@@ -655,8 +650,38 @@ static void vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
     }
 }
 
-static void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
-                                VFIOUserFDs *fds, int rsize)
+/*
+ * nowait send - vfio_wait_reqs() can wait for it later
+ */
+void vfio_user_send_nowait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                           VFIOUserFDs *fds, int rsize)
+{
+    VFIOUserMsg *msg;
+    int ret;
+
+    if (hdr->flags & VFIO_USER_NO_REPLY) {
+        error_printf("vfio_user_send_nowait on async message\n");
+        return;
+    }
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    msg = vfio_user_getmsg(proxy, hdr, fds);
+    msg->id = hdr->id;
+    msg->rsize = rsize ? rsize : hdr->size;
+    msg->type = VFIO_MSG_NOWAIT;
+
+    ret = vfio_user_send_queued(proxy, msg);
+    if (ret < 0) {
+        vfio_user_recycle(proxy, msg);
+        return;
+    }
+
+    proxy->last_nowait = msg;
+}
+
+void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                         VFIOUserFDs *fds, int rsize)
 {
     VFIOUserMsg *msg;
     int ret;
@@ -693,6 +718,50 @@ static void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
     qemu_mutex_unlock(&proxy->lock);
 }
 
+void vfio_user_wait_reqs(VFIOUserProxy *proxy)
+{
+    VFIOUserMsg *msg;
+
+    /*
+     * Any DMA map/unmap requests sent in the middle
+     * of a memory region transaction were sent nowait.
+     * Wait for them here.
+     */
+    qemu_mutex_lock(&proxy->lock);
+    if (proxy->last_nowait != NULL) {
+        /*
+         * Change type to WAIT to wait for reply
+         */
+        msg = proxy->last_nowait;
+        msg->type = VFIO_MSG_WAIT;
+        proxy->last_nowait = NULL;
+        while (!msg->complete) {
+            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock, wait_time)) {
+                VFIOUserMsgQ *list;
+
+                list = msg->pending ? &proxy->pending : &proxy->outgoing;
+                QTAILQ_REMOVE(list, msg, next);
+                error_printf("vfio_wait_reqs - timed out\n");
+                break;
+            }
+        }
+
+        if (msg->hdr->flags & VFIO_USER_ERROR) {
+            error_printf("vfio_user_wait_reqs - error reply on async ");
+            error_printf("request: command %x error %s\n", msg->hdr->command,
+                         strerror(msg->hdr->error_reply));
+        }
+
+        /*
+         * Change type back to NOWAIT to free
+         */
+        msg->type = VFIO_MSG_NOWAIT;
+        vfio_user_recycle(proxy, msg);
+    }
+
+    qemu_mutex_unlock(&proxy->lock);
+}
+
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
 
@@ -827,8 +896,8 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
     g_free(proxy);
 }
 
-static void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
-                                  uint32_t size, uint32_t flags)
+void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
+                           uint32_t size, uint32_t flags)
 {
     static uint16_t next_id;
 
diff --git a/hw/vfio-user/common.h b/hw/vfio-user/common.h
index c09637dd48..f7cc02d2e7 100644
--- a/hw/vfio-user/common.h
+++ b/hw/vfio-user/common.h
@@ -65,6 +65,7 @@ typedef struct VFIOUserProxy {
     QemuCond close_cv;
     AioContext *ctx;
     QEMUBH *req_bh;
+    bool async_ops;
 
     /*
      * above only changed when BQL is held
@@ -96,6 +97,14 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
 bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 int vfio_user_get_info(VFIOUserProxy *proxy, struct vfio_device_info *info);
 void vfio_user_reset(VFIOUserProxy *proxy);
+VFIOUserFDs *vfio_user_getfds(int numfds);
+void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
+                           uint32_t size, uint32_t flags);
+void vfio_user_wait_reqs(VFIOUserProxy *proxy);
+void vfio_user_send_nowait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                           VFIOUserFDs *fds, int rsize);
+void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                         VFIOUserFDs *fds, int rsize);
 
 extern VFIODeviceIO vfio_dev_io_sock;
 
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index 0c487dbb92..3974bc8a8c 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -23,18 +23,119 @@
 #include "qapi/error.h"
 #include "trace.h"
 
+/*
+ * When DMA space is the physical address space, the region add/del listeners
+ * will fire during memory update transactions.  These depend on BQL being held,
+ * so do any resulting map/demap ops async while keeping BQL.
+ */
+static void vfio_user_listener_begin(VFIOContainerBase *bcontainer)
+{
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                                 bcontainer);
+
+    container->proxy->async_ops = true;
+}
+
+static void vfio_user_listener_commit(VFIOContainerBase *bcontainer)
+{
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                            bcontainer);
+
+    /* wait here for any async requests sent during the transaction */
+    container->proxy->async_ops = false;
+    vfio_user_wait_reqs(container->proxy);
+}
+
 static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
                                hwaddr iova, ram_addr_t size,
                                IOMMUTLBEntry *iotlb, int flags)
 {
-    return -ENOTSUP;
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                            bcontainer);
+
+    VFIOUserDMAUnmap *msgp = g_malloc(sizeof(*msgp));
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DMA_UNMAP, sizeof(*msgp), 0);
+    msgp->argsz = sizeof(struct vfio_iommu_type1_dma_unmap);
+    msgp->flags = flags;
+    msgp->iova = iova;
+    msgp->size = size;
+    trace_vfio_user_dma_unmap(msgp->iova, msgp->size, msgp->flags,
+                              container->proxy->async_ops);
+
+    if (container->proxy->async_ops) {
+        vfio_user_send_nowait(container->proxy, &msgp->hdr, NULL, 0);
+        return 0;
+    }
+
+    vfio_user_send_wait(container->proxy, &msgp->hdr, NULL, 0);
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        return -msgp->hdr.error_reply;
+    }
+
+    g_free(msgp);
+    return 0;
 }
 
 static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                              ram_addr_t size, void *vaddr, bool readonly,
                              MemoryRegion *mrp)
 {
-    return -ENOTSUP;
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                                bcontainer);
+
+    VFIOUserProxy *proxy = container->proxy;
+    int fd = memory_region_get_fd(mrp);
+    int ret;
+
+    VFIOUserFDs *fds = NULL;
+    VFIOUserDMAMap *msgp = g_malloc0(sizeof(*msgp));
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DMA_MAP, sizeof(*msgp), 0);
+    msgp->argsz = sizeof(struct vfio_iommu_type1_dma_map);
+    msgp->flags = VFIO_DMA_MAP_FLAG_READ;
+    msgp->offset = 0;
+    msgp->iova = iova;
+    msgp->size = size;
+
+    /*
+     * vaddr enters as a QEMU process address; make it either a file offset
+     * for mapped areas or leave as 0.
+     */
+    if (fd != -1) {
+        msgp->offset = qemu_ram_block_host_offset(mrp->ram_block, vaddr);
+    }
+
+    if (!readonly) {
+        msgp->flags |= VFIO_DMA_MAP_FLAG_WRITE;
+    }
+
+    trace_vfio_user_dma_map(msgp->iova, msgp->size, msgp->offset, msgp->flags,
+                            container->proxy->async_ops);
+
+    /*
+     * The async_ops case sends without blocking or dropping BQL.
+     * They're later waited for in vfio_send_wait_reqs.
+     */
+    if (container->proxy->async_ops) {
+        /* can't use auto variable since we don't block */
+        if (fd != -1) {
+            fds = vfio_user_getfds(1);
+            fds->send_fds = 1;
+            fds->fds[0] = fd;
+        }
+        vfio_user_send_nowait(proxy, &msgp->hdr, fds, 0);
+        ret = 0;
+    } else {
+        VFIOUserFDs local_fds = { 1, 0, &fd };
+
+        fds = fd != -1 ? &local_fds : NULL;
+        vfio_user_send_wait(proxy, &msgp->hdr, fds, 0);
+        ret = (msgp->hdr.flags & VFIO_USER_ERROR) ? -msgp->hdr.error_reply : 0;
+        g_free(msgp);
+    }
+
+    return ret;
 }
 
 static int
@@ -234,6 +335,8 @@ static void vfio_iommu_user_class_init(ObjectClass *klass, void *data)
     VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
 
     vioc->setup = vfio_user_setup;
+    vioc->listener_begin = vfio_user_listener_begin,
+    vioc->listener_commit = vfio_user_listener_commit,
     vioc->dma_map = vfio_user_dma_map;
     vioc->dma_unmap = vfio_user_dma_unmap;
     vioc->attach_device = vfio_user_attach_device;
diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 48dd475ab3..109076d820 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -113,6 +113,31 @@ typedef struct {
  */
 #define VFIO_USER_DEF_MAX_BITMAP (256 * 1024 * 1024)
 
+/*
+ * VFIO_USER_DMA_MAP
+ * imported from struct vfio_iommu_type1_dma_map
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint64_t offset;    /* FD offset */
+    uint64_t iova;
+    uint64_t size;
+} VFIOUserDMAMap;
+
+/*
+ * VFIO_USER_DMA_UNMAP
+ * imported from struct vfio_iommu_type1_dma_unmap
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint64_t iova;
+    uint64_t size;
+} VFIOUserDMAUnmap;
+
 /*
  * VFIO_USER_DEVICE_GET_INFO
  * imported from struct vfio_device_info
@@ -176,4 +201,11 @@ typedef struct {
     char data[];
 } VFIOUserRegionRW;
 
+/*imported from struct vfio_bitmap */
+typedef struct {
+    uint64_t pgsize;
+    uint64_t size;
+    char data[];
+} VFIOUserBitmap;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 053f5932eb..7ef98813b3 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -11,3 +11,7 @@ vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index
 vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
 vfio_user_get_irq_info(uint32_t index, uint32_t flags, uint32_t count) " index %d flags 0x%x count %d"
 vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_t flags) " index %d start %d count %d flags 0x%x"
+
+# container.c
+vfio_user_dma_map(uint64_t iova, uint64_t size, uint64_t off, uint32_t flags, bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" off 0x%"PRIx64" flags 0x%x async_ops %d"
+vfio_user_dma_unmap(uint64_t iova, uint64_t size, uint32_t flags,  bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" flags 0x%x async_ops %d"
-- 
2.34.1


