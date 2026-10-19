Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5622FCCF2E3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIm83-0000Aa-QX; Mon, 19 Oct 2026 08:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm7U-00005z-OF
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:05:37 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm7S-000423-RH
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:05:36 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8QDOq3008558; Mon, 19 Oct 2026 05:05:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=TAOVXQJDaXE3btj5P/XXf0XEZfGBwKpBJnEaqxNFb
 Rs=; b=MLcqxrc5PtBIDB4M5Yn9lVF5DFlM27CAgzdxLX2JeUazegDygFVhAI1Jr
 2WsXVsHI79SAzAUn/SPypny+OcOiTk6+aguI9FyX1wjJDOUOW0zG3peMTsUhgRW4
 VHQxppq27kTiwLeeJso5Dk3lUnsmjzZ6V572gyFi33Gwi9kSXbgIR5Yz2ZkJYpdp
 /ltJ+J/4pOdq7tP1LIOsJj+fy7SjnOnICa5pKCmwKmuEQGj8/T6jyZXEJyiFwHJU
 o7r+BjjBp7N/7SPyrQxhZyl22iokA0ycaoHGKlrKHwtWAQQAL0mzLW3uei6O7ndg
 7Mm6Z4m2d6GJkm+kESEzCdOtAqryw==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020088.outbound.protection.outlook.com [52.101.46.88])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hc5bpup5m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:05:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2jTaQKWhqhTQPBUNYsU19fO4bk/6o08+3TvQZLldYFLY0hAx/bxTcNoMzb8D+dqomQF1eqnxfVjtSJSWdyChO0Nr3JMp4HhMPBDG67XCkw5q/v9IITZuUDPcojfYa/7cLv/Efi6xIxCRoPvpqqlZOStZ4SXtm1XN3z5TQacxk1MEzdVjCf+sgEK9g77gJaj+t3DiFsnrlLWyXXhs7m1Doual3KH3GzwGsqCBgr/5toCYVFLPjYV37I3AoQtQ3cVoNPKsig7X15ZmhD4fZulyWoi35d4iebxGnD/bHcmTtco9E2fb6z8qIJlhsZOQbfYXPI5efv7H3J1Ubvx2X4cwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAOVXQJDaXE3btj5P/XXf0XEZfGBwKpBJnEaqxNFbRs=;
 b=KkTCm4fIdtMmuAUYv8iFXjE3ruyCCaGNXG91HqiJJX2Hncqds4xIbOGNlVc2i5xkJAW8QprzVisMHFPHRKIz//ZIb2o3irg4BZW7BMJt2ECoYR5A5TMDP/auUYFqfs40Av+rnAkH6yrSEqerilCeDSf7LtLynT1tR2pkkT5j+jaG07s2BEG4EU/wSWy9B8lA9iD+rTFw3Bfz89baKENYkV3JMOQ5lOomEolKVUVmjJ2mkjsWzojwJR7Y5Gf1EsKzI0bj3Q49QzRyNNTTutIGHPrFvqMtIwQ4OezczbAPPSh41wLU3QDEtwdVG42LAkewJrp+Gp1DLLKDZFnUtY4fGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAOVXQJDaXE3btj5P/XXf0XEZfGBwKpBJnEaqxNFbRs=;
 b=rrr2FhDMHFGqoSRxhGp24xNpJ0sthXxLY91hT2HRihrl5hbWDLBFbzGAA+QntJW2nClKt1d7s3BD4EJw+Qn0Mc2QbD2THbeG2GpExfKQYy7UUU1L+nntRvfpWBKQRGdxtcE4P27Ui3ePGqn1YaspMkW3GooDJsFmV2F0OPRzbokt+JnqehLgUmR39sRb5Y8ZuYeDGxxSZb+fw3WPGk5q16zOgjNKn46NttcWHrrJowptV/Ej+QGlqTD7qlzmlLwpCqagzk1MBl9M0QM3Z+P8FTb9te60+LbGcjv4c2L9/1Dabje54id3h74/3O2I+czRm4iYxB5J2uBwsAzliR7LGg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSWPR02MB11441.namprd02.prod.outlook.com (2603:10b6:8:354::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 12:05:27 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 12:05:27 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v3 02/28] i8259_internal.h: rename TYPE_I8259_COMMON to
 i8259-common
Date: Mon, 19 Oct 2026 13:04:34 +0100
Message-ID: <20261019120517.1448687-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::7) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSWPR02MB11441:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe5c034-b5d2-45de-ac86-08df2dd94377
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: +nUn48g+JFHZlR5orUjhlPCFox39it8YXtjRIqMrjCGOLlvG5lHGE1IIt9vVOPmZs4mhzqnhAjEWMg9Y9+wKYm60N8OUnQcVkxIKlP4babY9mk3mcAlrdSC3M1FbHutahKl7/BgQ20lR8Jwv6D1wHOii391vY+LDZVzTfXBYTiN9kl4gkOgIa7eQJLu0W41MKCjxukPsf8f9eNyIXljzwzft8p5YI5vLsjanFjPoSlf3GDvJjVpCSRb5o4R13nSr8Pg2iG+qo0k6F/A4Gh5TDqCtm63dYJlFtXMUL2u2qSOPzFgl06j5j89Q3StQdYcQzb1TIZsD/YuTVzVl7/fbRCpKQ6W43HApBMZ3t9/ponELBhcFdJiwT7TjV4kj1e0dgEdnL7B3mgEHASvrACuIxXZC7hIUDwLN8zUNUAJBa5lTsWeCX8z/GGmEkWe87xHLkzQf7KREc1cX8W1FLtoIHEr43woJQ0JweVbi/DYi5sZINrSejLMMPRdmle7PQNg9NbK1wN8C6EHUyRB7BOjXSCVdboCuEU/jA89+QZ6ukdVFfoQRp0K8eHpbijN74+IUQyG3xX/bO5waRhcABDnSNpQYUt4qDvGj/LwgqF05nm7cIVgKDIeSr7K1UpXnM0sAAhMTEEeFvdA1X4unv7AYww5bpmoP42qsNdX/4l6WbbE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kG6PHnFJAVavp4lSzcLSrkv8cr6HRnaPaFyPgDBuA/yWEE3KM2gu70oKBpaa?=
 =?us-ascii?Q?g42hgswM4keP2nHGjyIVlAYQHSo67cnqrWg4N67zDygU6JfxE0jQLLIZyGMf?=
 =?us-ascii?Q?kmqFvGdIqGPyzApZqM7HTuFDNBs+NQgJ+ZzO5WWjJhWwqhCgVwlDzQyJrS7E?=
 =?us-ascii?Q?NMCNXLXbLBy8mGH551B5Cb72j1JOZ6q99NxQsSxIrhqF3jvu5Tm8r0Vfn0Fi?=
 =?us-ascii?Q?f7cVEmPIlK+RUJWTdX631mvaAfcS/JJiaY/2Y2zF2+l98Lmk9EE5xvMzM73C?=
 =?us-ascii?Q?PCKubCL57Tfj59/PBdYidyIDQSv0vok0wnyh2GhTpKjCA3CPM23oAdLVhCTz?=
 =?us-ascii?Q?1Kkv2mdN8aIZ0/AnXs6r4JwA80ZMlqXRzrx71b9w+YJ6Bh0HbS18eI7MZZ1l?=
 =?us-ascii?Q?TR/jw2xpPYwMDWnvsG34/S4lqX/r87YCevU8vZjM4gu6lkBIqrWzs1rrZbR/?=
 =?us-ascii?Q?Aq1rLI0CwxxVTxK31iTKXJ58sZ7XUQYiT6LnbHVh2gsh1dNDjibLriUDYaIh?=
 =?us-ascii?Q?lE3ZXuRubXKKrGWioqCUSxJnqoJJoZYgIZ0qQVdrb0h/FadIJZk0BdP8OgPV?=
 =?us-ascii?Q?RrgnN1/mvKlN0nC10zxihPat1KTdFpeGQ4Z37Cwh5k99j6eDq5qDDc/pa38R?=
 =?us-ascii?Q?Cx1htD6iCJkRFaFVCf5OXQXywb/HEXTaGAfjFMWFBrB6Dg9cHPFNHg5PcToM?=
 =?us-ascii?Q?pQ8t9NSibj52om8ge7zo81p1ISp9KwdHpV9pGvUxRRAdrAqpZNygZnUYHSWF?=
 =?us-ascii?Q?dsCMkIsn+uYIlLDe1KP0oPf9NkEmwBqZGjtUKMskSpx+Do94x/RL+/B0fBx8?=
 =?us-ascii?Q?RTluXZRrfmLqj4wm6G2TUWcbuqn/gpYt0BIikO3yxP+/RHxD1uTqPazplS9s?=
 =?us-ascii?Q?1Vbs05W7DSeIsWI/yuJzVsUI1HISyxNYnviqjzzy4F/haFscfjyKi/hOMgYz?=
 =?us-ascii?Q?/zzVmXPGFHqlx7hm0Hu1dLEA3ktuomdlqK3fCFYZWcioTicDdXi6G8S6E32D?=
 =?us-ascii?Q?zWEqtG4knCicXzYpZ06jxd+croReveKHhmSu/MnpGQ1n3oIql0jTFAAnLVZb?=
 =?us-ascii?Q?5c0xQcy9UGHUXbT+LMrGIpBrtaKS8kfK6CHKKy42TqLcHHawZtcP/bz2ersk?=
 =?us-ascii?Q?SNspqjya6y8WFijUDyE1ZJB1bxNMo1t5rO+CVrNhA7iirTIjVncqvAVtvLfj?=
 =?us-ascii?Q?RlI5OIHIPtOVFqIwu3PpY3ojk9AFqJE1Fq7Exo9HtASZh5vL0dPbmrre6VS/?=
 =?us-ascii?Q?qugVbax7E+7whP79btPSESlRUec4NSeBQbyMclOrX3ccfIzdLYs907YCv3dv?=
 =?us-ascii?Q?sep2vhcxlGYy2ya5nliLgoWoHiejHEGkVyRHwX4AbuzbxBpgavquBjLrbLZo?=
 =?us-ascii?Q?mbM1XFgYy51ncCSXqimDp/EztocdSs3ybQnFcX4eFwl4s5ybCA/pb7xP3dcz?=
 =?us-ascii?Q?fqZHOyFRT9oQBoN1IaLQ9Zo4ulklGsSIw2bLGs499h44Nb95PWgSWnLrGSFk?=
 =?us-ascii?Q?HJfJdSj5k8zDHgdSJREnCHS+ZmERnzlifLnNAgCdUSyq0095MDXr76QVcUnu?=
 =?us-ascii?Q?ECGCtgKvORbQOyiBbuDG/Q6ZsyPRIbffd693cNxTqnIqsb3UH3OrVnYHlZDV?=
 =?us-ascii?Q?NdmGY23XSmiGMYUVbKjUa+A5i7vgVK2rSYrBuYkyb0eU7zHP9moNFr6Thnsi?=
 =?us-ascii?Q?mGEeTDLatYUUmp90Offsv98tmf02ESoeiixH5W9dmCi1If0juNwPa6ctD5wQ?=
 =?us-ascii?Q?Al4ODPR7niSEiIuSvuVwVxVCsT3jJ7U=3D?=
X-Exchange-RoutingPolicyChecked: M04tN2c81wlR6phRAaV7rv2SYyv1J/EvqDgzgmFUSphI5AwcM0P/wbxb4vR+m0LYY0McOGteDrwJZRrnyycBD1zdtLuCQ4k3nd052HSv92Rs88bPYYg2FeieC2fVT45ZsYnM+YBdJHweoYfelYLAhpglH2oqRFyU2mNRvvRkxcIGw1Fbq8+hIrT0KNCSZRnj8SOhVXRuNS6GaOzPAfSTHZP5r2nq2fG7j8Yg8H2RL5yjkFihBKVpgg222Ty+WC/QOOhDlxBPZ3SKezqzCHY72e08eZAa1dkCoxHXHDydZxEYIq5Dai+Wt25ILcVNkckvlB6VOfY5RyWJyfnVFHnvXg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe5c034-b5d2-45de-ac86-08df2dd94377
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 12:05:27.4850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4/kpMx8K1uM4cHBWTb2QTCNgGC9C+zw19DcRjvxrkRfsQOlsLdjI+IPitHrLosQzBJvsmIH6Bsc0KFikF7x3+/GxcrAEwB5n3QUfeNRkTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR02MB11441
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX941Z9YKrlg5T
 gQ82tqeoe9Nvgh3vzEHs0rWMuxtc57FeRQHPueEMNEB3O1TaLVpRzulfXSxtKOERa8QIqM591SD
 I5aI5VtRBUHwQQ3O9AX1iyPy+RJmwk3MUwllsawZlResopYSc93jb7KCEOGfCvxRZV1shG9fyzR
 91amN+iX/OVMidagVeAopLUA5Jzd+8xmhdUejSVUK1dpJOvsNac/vz5CqX7d0MYTR1q2ekAwQTQ
 8hvZqBc1S7lYT3g0o6WJXkWJOuU7mP1nJWI14vjKXpfTWpohzHkTd5WBKF9y6VvGw5Gu9NBgYHw
 7FApsJ/gCgRcLB7CyJIvEJcCVWDvFBk4krR/gnCX4OcQFOfmJDzSn0uhUnW9mv8gATd9jr+5FbZ
 D26kn7GzC3PrKpJJFeD6n+OH/JlSqyeOxLYxmgyVlogkZqtyjDnudcfD2dIdPptZ7DfIlylmoCd
 Nu067mZFlSU4ZuyJXmQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX42d+4ddb2/oO
 WYtsxiz04Ak+TsaSt1y18DLeq3UWOw/YxH0uMHRjiE96A9Us9RhUM4kwPCIBPaiFsRqbOaGr+Fl
 Z4+NEQ/sYSlHNAto1xQVkkh6o2aviwo=
X-Proofpoint-ORIG-GUID: l1Zo-RvBY4hMi7oYwfBDBVailFU-bN_z
X-Proofpoint-GUID: l1Zo-RvBY4hMi7oYwfBDBVailFU-bN_z
X-Authority-Analysis: v=2.4 cv=EKeTQFZC c=1 sm=1 tr=0 ts=6ad60788 cx=c_pps
 a=XrAAyJxZ/W28UfFUt0AM7g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=xWlEjtkXqD840QCPih0A:9
 a=cvBusfyB2V15izCimMoJ:22
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

This is to emphasise that child types of PIC_COMMON are all instances of an
an 8259 PIC.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/isa/i8259_internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index 54dc9036cf..289d08b7d7 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -31,7 +31,7 @@
 #include "qom/object.h"
 
 
-#define TYPE_I8259_COMMON "pic-common"
+#define TYPE_I8259_COMMON "i8259-common"
 OBJECT_DECLARE_TYPE(PICCommonState, PICCommonClass, I8259_COMMON)
 
 struct PICCommonClass {
-- 
2.43.0


