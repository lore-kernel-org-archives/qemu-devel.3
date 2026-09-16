Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB72EC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6nB3-0002XB-2P; Wed, 16 Sep 2026 06:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n8x-0001Ke-8r
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:40 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n8u-00033D-Ab
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:34 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68G8Ooof768822; Wed, 16 Sep 2026 03:45:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Jy1v04X56TCY5cimNIdgAFOsHOMy8I9bpWBMtANdR
 tA=; b=pWRxEbwvqnF6Z+gbQw0tVVDRTnVrL31Chv3FbbP3hLyOgmmDw9qbA9vv8
 Dzbz+GzmtCPNFFqfqgoAyTMgzBrajbE0YQDlY414Yk9riRm4rRi0iUln338G/+hp
 d9LXGKLL8GENEkHrPgoV2fQ3gsaovUDYztis4UU6O31MuG4yee0ozyA53fEe9Hfb
 lYguyINjbqFnuxbkS2M9WdqTDH3jYm7U106DXhaR3g4wI2Idj6A9SsgaqeYiffgw
 KXU/FL1YUeeFZQIhcoLjkMBboFC7BUY5Pt5HWTDypkmz+4mG01OJbtCPZeI+FtAJ
 7BbMT52G4UbFANV0XRxPUI1e+0Bwg==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022120.outbound.protection.outlook.com
 [40.107.200.120])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gqdhm9r6q-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 03:45:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXxEsjAaWUWgSimyTrdo5AaAZrIjYQEBapDnOJSQ6YGN+A4jPzqfP8SUi4DYq/ENuhn9tmQv4CuPedOR8Vng6/nXvNTrWyVtvFiqiH9MADhCb88QlBA1m8ynac4kGWJRHELpaoq3hAO8LvqJqlqQ7PC9qZfuzEdhMiAP7S40nP5BfXMDY8zd8GgtGI7s/BAmIWtocO5MCIjJjZxB1sftfX8zu3Jhl79HrsAns+f9x4m8Ho62BjgGQQwpFR5aAf3pzL8jLIc1zyq9Lq6UF1r6LKYRI9T0x4SjgrjgLT43ihl3eUmdpJJhv6x8rO2LI26XBOg2Mez0cGydxYIY6UstwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jy1v04X56TCY5cimNIdgAFOsHOMy8I9bpWBMtANdRtA=;
 b=hxYF6acavvPm2wxGhYlHUsx8qIoHdxR2dKmK5bqyqMOqIw1E2J+PDwG3Rp929Sq3r32PflAWVHfVuMPkYO+Owha50RRkMK2m0KlaVsg8Daqixf/FAXO9nRbcEG6+NPPLGdL6W/3stbcKo4NqlWEXktRqH+Z/s11l8eHmyreXwN7/Gd3kauYF2nSkjk+gw9nyouZEKWZxtKZeSxR4MW90e5JPuLohd4nIhVlTag7IKz5jFHwdPcrdhbmEW0wYybft46KBRbWIRC/USYt634PFl/9DfE6/9wCdTAHgUNWBz3AsEr8KmG1wkJlnfikm9SFzWIvEhNttZA71K/JefhxFlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jy1v04X56TCY5cimNIdgAFOsHOMy8I9bpWBMtANdRtA=;
 b=mdAx/NZDFw8qqaZSFH2r1j6P4nk+ywr0Z/uv6RfnjENqrCcXxCbzF2e4AnqF4pTwWRbNtvXjhzx/sXHMbY7QG/dYSEXUw2S4ygnYxWP03ZiLZHvVTdKVcnHl94gILkO6mTf1bB7YB/h4UxMgwftXR5ZnYAxa4eB4NLuhfByp3/Pbit+qgQN1IFBEFj238euDu0ciYIUO4XUWdAxgXm6IT2jrIdoaS42X5dQIff7jT42qeMC4nDJ8SrAifixV5bwGWwaePxOTIqHCob5gd5WulZMvLsYX31s5/PZjgksz4wxB53pAz//uWiI1qqLRegcTv0xyIENcbSvS6dXUVHBAeQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PHXPR02MB11343.namprd02.prod.outlook.com (2603:10b6:510:3cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 10:45:24 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 10:45:24 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH 13/22] i8259.c: introduce TYPE_I8259_PIC device
Date: Wed, 16 Sep 2026 11:43:41 +0100
Message-ID: <20260916104435.600211-14-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916104435.600211-1-mark.caveayland@nutanix.com>
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0182.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::7) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PHXPR02MB11343:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f8559f2-1bf2-4f92-104d-08df13df9d2c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|10067099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: kqkNYyfUzXHn99juzjFDmXWP6HZyCnqZbbEYlhCHfbtXG9DGLKV29MNB8uZFblsY9dgT7SdlXatzi3/zijRH3l6/Oj7PQM81iF3Dvq6umQfiO6CO6DKp7znX+Vde2NLvx44h7M5mluKqgbswWgrfThJ8m5TLn0LT/NYt/zm6ElIdShk2aJtzJ0oVM/tnw7AMVN4BhVL2ADH/79x17CS6WQfOALpNdVeS/ssZvWEwyH7ASm+IYly3mFXDuK4hnuL0I655DDcE/ZlCMqeuC9UNQ6otgZNn0QBF0kym1rR2KOMySSR1DZ8MVYs44ciuzj5kMdsaqrsKta9Armb88gkqVbnlNMu7yLNPvX12dZ2oecVhFg3AhaJh0gufuIK/5im9d4dxPGACp02jJo7pzYGegrQ5Ez3M6vXENmHEH5JyrFNRuKvFZwM9ZLl6kAG4498PmGzpizymrie6BPZbdoo6W7nSZybe6ZEL4IIOH9qIy22uHpE2OkpQZXsoce246yvPoCQUZWWL83NgxjoHFcwB4H37P0G5PZCQCmnWFvVLeX1mn6Rgk+6vUYavoa/oKktq1ADnnGCTnSPmmC/gNKRl0rysVTPwlatzsAIX1ykaZ0WEkNmeCT0UfE9AQOwMuO6JRbxoqlG+7pcXHpogUNteeWyJb4ZRLnikg/JM0rCFg+8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(10067099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fO/qg/o4mWVX6Xp9u2DdQgDWXFk8ZlXRJ/IblQrGlOq068PncphbdmG6HSSg?=
 =?us-ascii?Q?VD1ILevdii4eiKxSIJ5OmGJZOo/pCigqZKYUtp9ijftwBoIudt4OXKYGPMyi?=
 =?us-ascii?Q?tvl+gWc/g/qPdVDfeR4EFmk6WztfoUDLIIiTosEi9Xs0MBS9ZZXkifAjM/bM?=
 =?us-ascii?Q?ZvkYvP9fNjtBOFMwBV5fzmaIjaQVu8jMJAUtf0s+q33EPqVhOwj4mB2lWTlG?=
 =?us-ascii?Q?eDhJiD/WnKQWmh47O5EcBl6/Tc7w7gwrx1D4ze0qWvjMpm09J3vr6SrvqnOr?=
 =?us-ascii?Q?LplR8pJ32IjX7kXf8bezryJbLU2oEph/TWTU8mBCw/FJ/QY4rYK5Ea2ZRC80?=
 =?us-ascii?Q?iB+DyxgsD0RKMj9UP8tJ5RO0bLm2kWJs0lXBVQh3m1MZ8qWgAUJK3+1n/DnG?=
 =?us-ascii?Q?I++wtvRcdP2mKDS5limDMBpNwSqV34kjm9wOm/VyBBN5FyQJXE4cTCYyw3+r?=
 =?us-ascii?Q?dxVyKOGlR9m15jO19BNBXrhGvD+8PDgEV9gsxsDt0zLH1W79n07vzw0RUkgf?=
 =?us-ascii?Q?dv464GpEyZR8d0D9PDbrGt1XXFZx4h33jFPbYYrNvNZAcoU/wxU1jGlba6iT?=
 =?us-ascii?Q?ORQdHXul2cmLA8z2+XmBpq1Trd+fVUCsXu5iRbRUGFlCbAhr0njhJrB+eOfD?=
 =?us-ascii?Q?HzsauaSRJjn4t0YVxDltqGd0b1DvjBBmCjOEiUUDtmdLI0qTbhrB19xVxlib?=
 =?us-ascii?Q?Cmq/1ncf96+w1Dsuvn0zW/AwdFwZ97VLe5pN4gVukPO/rnn3u/6pzzrUAKHa?=
 =?us-ascii?Q?rhE4qHxWi/PIwiwH2B7YJaqVS6GhtFUZi+GXJWuKHRZMz6fh/s6Ca2V8InnQ?=
 =?us-ascii?Q?ZxqnnSpzKL9bREGPdpyoZJsYyWvXIBYJJMnxmj9xuFzzpdN5yAJC5YOp26nJ?=
 =?us-ascii?Q?gvFk3GTiFLHgfIffu5SltIZRg1VXnzRvne8Ww4QT9N/M0KKiZQsjWdqWagOE?=
 =?us-ascii?Q?IvILDkBCNQg5q9Lh4a3KzrnZPssXyYZGRibMOs12aG5d/N9RzPcjnewd9Sf2?=
 =?us-ascii?Q?5QzkZOmWRqHoSN6gXe/FBe6UGtVbEXnojyAIfyosw4mqI94dgiBtogDQn7fb?=
 =?us-ascii?Q?z9nvVJ61MjZMT+eksMpwqaUgihJOV2fYilmDcxn3rF6W842dlik89uR5P0ad?=
 =?us-ascii?Q?meI9TrTdgS8SooFZwXiQvn5A8tQh2NIhz7hBgSgkedeMlojFOgonjP2H/xm1?=
 =?us-ascii?Q?xiPHH20a0TLwMmBbtwzRuj+QU390mU2AjXTWyRDAw491HgoXaRhGag7v0vXz?=
 =?us-ascii?Q?wW3PZGNapAdjP+FxUGZ+ouMAzZYbVB64wnFyWiSGESs60B+2bNsL2JC+MyYw?=
 =?us-ascii?Q?SKxGAXuUUPDHWWbR66+RAA3eUyQjXNQHu1BXGW7OSFi5szvi6qMeOy5JoQlY?=
 =?us-ascii?Q?df9SiBCfGfPNCfFPhdAy3u2OvwGJNwgDFtspviH5cef4r3e32EXTo/0jEre6?=
 =?us-ascii?Q?Vy3mWp/7+4zS2NM3VH8GqCmJbnN0RAVB+1LbwYskbhD9L8jWqa4EXC/k/MQO?=
 =?us-ascii?Q?XJOa7ID98t+qbEke326LhRyeDHn7xGPRoOyJHJWV95aGa0DidQr+V3QGLKH1?=
 =?us-ascii?Q?h4HJoTMMYBNem2YohLLofe9rGHkNL8Vgpyh6tmbEr5J9u/aGSwzo/L53d6Fe?=
 =?us-ascii?Q?eNxOYxSC8UMr/3WCVGkaFUuazDFTpnq1NX0DjAnNgvtU6z80/bDwvLE8Hoqv?=
 =?us-ascii?Q?4mz862JUrfGwSGAkBiZPmzC2Ga1seFE3ojg4YqJDYH6aLr+xZArV9raFohbi?=
 =?us-ascii?Q?CjonJENfGKfVgLbR8xzb0DC+T6Ge+/I=3D?=
X-Exchange-RoutingPolicyChecked: Zh+aTXM23hqHIdvBbI+8g2nITmaZWJAbOwtrRA9q0uYroeNsjrg0nccH82mgA6dgQOTfemyx5wi8vPGSg8d9MwwYkPrRQgFm1OmHhB4pis81HManflorzUJL3k6nMkGpirSNk3VkgJytQ+OB9o92dbst23eBiEk1Uh/74SQTrCgG2GXza51zQYbwCYcJA98OW+dGPRhS2Qzgxko6fVuEyWuRsIotH7hUsWM21bpoLyHsRHmJCnmr+tDKCOZgySPgo6UzPClX0yBIa91eGYU/EOQLSqmcWT1BiHnq2XXcdkYq1fWdhG3/SBowgWRy+pXcqXsDLMb9dc060GB2hWbzIQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8559f2-1bf2-4f92-104d-08df13df9d2c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:45:24.7474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QW+3vlhqxQ6aYe24vIgD/RNLUekWgayHi42HnVr+xdp0BLjY+FknQC6OlBhj7T5DYB9KKygxOJRJsnyayRPuNJDulXyl38Gn5ksqe5iktzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR02MB11343
X-Proofpoint-GUID: etXJZf7p4Z2i7zg11tkyG5VuRnhs_8Li
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfX/EIlMI7ap35K
 vn2Eo4a8QuJsBEJZp3EyzlZYe5VFyyybBukoyDr7n8lAcWVhrlIeGcTYgLfv/guk5IExNz73vGv
 RqufHpVQ3i5+oojwtWt26ALpxoSKwHs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfXxeoiuqGmZ0sb
 vAqxMlEq8JNEdXAV70Yuu14GI7/trknOSpWcLOSe3BJiJW9Oq/JnbZc7UteOdKYIKsDVhD9b9+T
 fVQioZxRGOC6MSmcPS7A6bYFZI5tmvCBNbyXsegsOhuBCk6XpTCkmImeFuFjrQQwlBSfZ8Zj9R2
 cFVocbL2G7UgXTu+pFh0jD5ey/cyp6aopfxYGujRd6hyRG5p18SRUUK6OG4dNYzLus9Oy3Qv1tO
 enjjprwd3PK93cqGSi8DzLtn5/OCHKIDQKIJPgLjCCllkjj58tGeWeAxEF9bPP51V9RimVLnoEu
 6sAwx1mRWBILO8lOfmvzssVuqN+h+N+U0qcEIC0kz1Uh5bMcuwN9x8cb5lfNeVUIK9bhUCPQT/C
 IwIUp0CvLkMIzJfDFyOLId6v4aw7ZbTH3tRjXf7UfdToVZh7BIoN31Fjh/NC986mVzI0lp+iJgk
 3PI5mhLusQ2K7RylPtA==
X-Authority-Analysis: v=2.4 cv=IfkSymqa c=1 sm=1 tr=0 ts=6aaa7346 cx=c_pps
 a=3SCk7X9PwWHtu4c5+rqWlQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=wVjqpWDhUWNmLA9U0x4A:9
X-Proofpoint-ORIG-GUID: etXJZf7p4Z2i7zg11tkyG5VuRnhs_8Li
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This device represents a PIC for an x86 machine consisting of 2 cascaded i8259
devices wired accordingly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/intc/i8259.c | 133 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 118 insertions(+), 15 deletions(-)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index af33b71591..fcc94e12f8 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -25,7 +25,9 @@
 #include "qemu/osdep.h"
 #include "hw/intc/i8259.h"
 #include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/isa/isa.h"
+#include "qapi/error.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "hw/isa/i8259_internal.h"
@@ -36,6 +38,22 @@
 
 #define TYPE_I8259 "isa-i8259"
 
+#define TYPE_I8259_PIC "isa-i8259-pic"
+
+struct I8259PICState {
+    DeviceState parent_obj;
+
+    qemu_irq pic_out_irq;
+    qemu_irq pass_irqs[ISA_NUM_IRQS];
+
+    ISABus *isabus;
+    IRQState i8259_primary_out_irq;
+    I8259CommonState i8259[2];
+};
+
+OBJECT_DECLARE_SIMPLE_TYPE(I8259PICState, I8259_PIC)
+
+
 #ifdef DEBUG_IRQ_LATENCY
 static int64_t irq_time[16];
 #endif
@@ -392,30 +410,24 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
 {
     qemu_irq *irq_set;
     DeviceState *dev;
-    ISADevice *isadev;
+    Object *pic_obj;
     int i;
 
     irq_set = g_new0(qemu_irq, ISA_NUM_IRQS);
 
-    isadev = i8259_init_chip(TYPE_I8259, bus, true);
-    dev = DEVICE(isadev);
+    dev = qdev_new(TYPE_I8259_PIC);
+    object_property_set_link(OBJECT(dev), "bus", OBJECT(bus), &error_fatal);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     qdev_connect_gpio_out(dev, 0, parent_irq_in);
-    for (i = 0 ; i < 8; i++) {
+    for (i = 0 ; i < ISA_NUM_IRQS; i++) {
         irq_set[i] = qdev_get_gpio_in(dev, i);
     }
 
-    isa_pic = I8259_COMMON(dev);
-
-    isadev = i8259_init_chip(TYPE_I8259, bus, false);
-    dev = DEVICE(isadev);
-
-    qdev_connect_gpio_out(dev, 0, irq_set[2]);
-    for (i = 0 ; i < 8; i++) {
-        irq_set[i + 8] = qdev_get_gpio_in(dev, i);
-    }
-
-    slave_pic = I8259_COMMON(dev);
+    pic_obj = object_resolve_path_component(OBJECT(dev), "primary");
+    isa_pic = I8259_COMMON(pic_obj);
+    pic_obj = object_resolve_path_component(OBJECT(dev), "secondary");
+    slave_pic = I8259_COMMON(pic_obj);
 
     return irq_set;
 }
@@ -429,12 +441,103 @@ static void i8259_class_init(ObjectClass *klass, const void *data)
     device_class_set_legacy_reset(dc, i8259_reset);
 }
 
+
+static void i8259_pic_set_irq(void *opaque, int n, int level)
+{
+    I8259PICState *s = opaque;
+
+    qemu_set_irq(s->pass_irqs[n], level);
+}
+
+static void i8259_primary_out_irq(void *opaque, int n, int level)
+{
+    I8259PICState *s = opaque;
+
+    qemu_set_irq(s->pic_out_irq, level);
+}
+
+static void i8259_pic_init(Object *obj)
+{
+    I8259PICState *s = I8259_PIC(obj);
+
+    object_initialize_child(obj, "primary", &s->i8259[0], TYPE_I8259);
+    object_initialize_child(obj, "secondary", &s->i8259[1], TYPE_I8259);
+
+    qemu_init_irq(&s->i8259_primary_out_irq, i8259_primary_out_irq, s, 1);
+
+    qdev_init_gpio_in(DEVICE(obj), i8259_pic_set_irq, ISA_NUM_IRQS);
+    qdev_init_gpio_out(DEVICE(obj), &s->pic_out_irq, 1);
+}
+
+static void i8259_pic_realize(DeviceState *dev, Error **errp)
+{
+    I8259PICState *s = I8259_PIC(dev);
+    DeviceState *pri_dev, *sec_dev;
+    int i;
+
+    /* Primary */
+    pri_dev = DEVICE(&s->i8259[0]);
+    qdev_prop_set_uint32(pri_dev, "iobase", 0x20);
+    qdev_prop_set_uint32(pri_dev, "elcr_addr", 0x4d0);
+    qdev_prop_set_uint8(pri_dev, "elcr_mask", 0xf8);
+    qdev_prop_set_bit(pri_dev, "master", 1);
+    if (!isa_realize_and_unref(ISA_DEVICE(pri_dev), s->isabus, errp)) {
+        return;
+    }
+
+    for (i = 0; i < 8; i++) {
+        s->pass_irqs[i] = qdev_get_gpio_in(pri_dev, i);
+    }
+
+    qdev_connect_gpio_out(pri_dev, 0, &s->i8259_primary_out_irq);
+
+    /* Secondary */
+    sec_dev = DEVICE(&s->i8259[1]);
+    qdev_prop_set_uint32(sec_dev, "iobase", 0xa0);
+    qdev_prop_set_uint32(sec_dev, "elcr_addr", 0x4d1);
+    qdev_prop_set_uint8(sec_dev, "elcr_mask", 0xde);
+    if (!isa_realize_and_unref(ISA_DEVICE(sec_dev), s->isabus, errp)) {
+        return;
+    }
+
+    /* Wire up secondary cascade */
+    qdev_connect_gpio_out(sec_dev, 0, s->pass_irqs[2]);
+
+    for (i = 8; i < ISA_NUM_IRQS; i++) {
+        s->pass_irqs[i] = qdev_get_gpio_in(sec_dev, i - 8);
+    }
+}
+
+static const Property i8259_pic_properties[] = {
+    DEFINE_PROP_LINK("bus", I8259PICState, isabus, TYPE_ISA_BUS,
+                     ISABus *),
+};
+
+static void i8259_pic_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = i8259_pic_realize;
+    device_class_set_props(dc, i8259_pic_properties);
+    /*
+     * Reason: must be wired to the ISA bus via the "bus" property
+     */
+    dc->user_creatable = false;
+}
+
 static const TypeInfo i8259_type_infos[] = {
     {
         .name       = TYPE_I8259,
         .parent     = TYPE_I8259_COMMON,
         .class_init = i8259_class_init,
     },
+    {
+        .name          = TYPE_I8259_PIC,
+        .parent        = TYPE_DEVICE,
+        .class_init    = i8259_pic_class_init,
+        .instance_init = i8259_pic_init,
+        .instance_size = sizeof(I8259PICState),
+    },
 };
 
 DEFINE_TYPES(i8259_type_infos)
-- 
2.43.0


