Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81196C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 08:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZn2s-0000qA-23; Thu, 10 Jul 2025 04:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn2m-0000aB-5q
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:54:16 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn2j-0003bg-Tk
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:54:15 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A63DGL022335;
 Thu, 10 Jul 2025 01:54:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=7c32xvFohDD8H97QIyuNbxoDK62h7Z2h/Vl2pKCPQ
 bs=; b=vuLpn3nAGDAO8ePn/IKTYJJ+jvgN20qoFh3DpSQYXRwhrJHNzOzbEkk7K
 NkWrvFpa+6qqQQMYC+q6U26VIZ9Ce7iExNi5WrBRfJ6hFFGCB7LbO6IWd3xozH5U
 2/PDxCERbqBL37vBi58Peq0Onm3fqIAz9qyGSsW3sgtVvenR6e7Ly/ASJHF2dsD/
 7Xd0tM6fz1Rlakb/6budyOLIeQpOJeKHUkmbE8tSp5DBWDr2aDip7Vzli1JOmp9b
 w8IGgu2K3z5q+8orDGtNu8vRgyIrT37u+GKABmP2WyscbvkpREHQOKarDKDRHEpf
 c7hFp97n0DZH6Ca2xMhjnRaFTB1WA==
Received: from cy4pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020131.outbound.protection.outlook.com
 [40.93.198.131])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47q0cvn29n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jul 2025 01:54:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2chvCb7dhyk7c0cdlyEvSBnbY6MR3Rr6d87EqtvwU/T4WSc6LqfMBUgRU0EHORjvPrPQSjPWPd/HZ88bz/8OTHwPKTrqnsD5c7VBwpk1J85C3hT9Nyz4KoqtmhCFO2kZND1NQU0bdxlvvG+rAzsXZM5NP77JLwzZLDygSWb9reIdZvgN7ipQaqtMvEPEngvIhXB86FfQkipn1evIOPEXowjxMFqU1lqyb8WVHUuslRUwlZedC1VAoFo6gs5mnhXjUs0MnzsIcErBvRPvu9JEyHjMMsatXUBER3HBrbDP+OCg1rVhyJM3sN2gwNJ7efqgb4/xpqxoGzytDmWlquw5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7c32xvFohDD8H97QIyuNbxoDK62h7Z2h/Vl2pKCPQbs=;
 b=e0cjx8V0dnpnp8a0m/K1oHzG68seEyKGBhtzZLL9RQxvDp/aX9j07JpFHP36i0dP5SpXYJDU+3B8o3J0xcT3LU0nuU6hBYfUXFbX8w3Dy2JdekZU3xU7Qx6F7kY2okTpyUezaEJDmUplX8A7nDmJTFljg9Z75bX9BYc7StIL7T5qZt96j92ikvahvIdxBG+6vK2iRHpC/st7YlujX2Ixyv91V7uklgWdXucwXaecGXYQnwILt4YzyszO2JbwAOuMgRTCNB+immzVegN4z3YLrjLRLjNO1wUoFLbSQ1aEF6vIwlcA+StMJRb3NwKGZ3QW2ZtKETPI3ifAhds3hcY09A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7c32xvFohDD8H97QIyuNbxoDK62h7Z2h/Vl2pKCPQbs=;
 b=ufAgXxxAK1v7Lnx7OXu8QmsDiMjqMo3YocwPQ6rXV/34tsoHo4BcZLe//EXUnW8xCNy6UjdNCPyd3J9dlbgMllNqB9Ws387Bix3GtARII6u1IiRASoCL/94Tkl8CVzDL8HQQLyrjHGimRAwEe+8TUNrh8rVA68sp2kodTK8aE5RccYLQY4ctTbLJH+wZYh37GgCAPjKbbII5nXj2w8LSBgILvAIDOEAybMrtKA8gYLDrBqse0FX5ZkC7TsvAltZ1Yu0s4Ri/oSwR0m9O8PqQgvzQlS5IkDXviVtyTxq+kttp4AJitZsJiJIbZ9epDvArEQLfMeQ/CsNoa40TDSoSHQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8048.namprd02.prod.outlook.com (2603:10b6:408:16a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 08:54:09 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 08:54:09 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 16/18] hw/i386/pc_piix.c: remove unused headers after isapc
 machine split
Date: Thu, 10 Jul 2025 09:52:31 +0100
Message-ID: <20250710085308.420774-17-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710085308.420774-1-mark.caveayland@nutanix.com>
References: <20250710085308.420774-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0030.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::43) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 7747f0e0-179b-4302-5ce0-08ddbf8f5590
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nw8RZ5bE+Z32lWYYD6hcfdPOhqWSENNby9zD/uq7uG8iiRkbmv/hEgT4cVyu?=
 =?us-ascii?Q?td/Ib7egcRcYdyMcBQD5K7gCVegSEN3GaEAB1b4UpbxbdM4Y7gvjsD4jpYAE?=
 =?us-ascii?Q?QAdVkbAZDIpReCHPOAehb7QI58B17ZKbSiC/ekF5KsJ1HQVSRrk1JM+JUK/G?=
 =?us-ascii?Q?kaat8NjAe18dHitXUb1kCFGNXLUTnriKwcvtpM1+wZ02Tso/y3s3XajVcyiA?=
 =?us-ascii?Q?QU+Ae5JORIuy3s9xNXmRL4rfK3CiqMZki93Fzl5n4kbDWt4gsVmGzehvkbju?=
 =?us-ascii?Q?2lBlpbquwSiKUK5EMVsU/HcllURfgcHfSoFtxuyvl4YsWxN/dKNuO2MFsWiX?=
 =?us-ascii?Q?AlyVlkBO8phxTekhPN1vFg/b2gg1wAH98rpHeCW1JarECkwwPOKm2u5DfFEw?=
 =?us-ascii?Q?e3lRpOXT5GBCyU9IsyVxYJ0fglT3u/0lK3hNoQMNmZpsQD9TC0DPQUiWzghr?=
 =?us-ascii?Q?sSrpHkSEJCfJ3S8VKg7Pjj6Xhs+JPK23yiV7CIa1qprlq52aInOhK06dFuP8?=
 =?us-ascii?Q?iCLhXTxsJAu3rPq2kTXYu5JMm1J58rodMdap1OkfVH2B7Sc2KcBUzMo/OBQP?=
 =?us-ascii?Q?M5Dq8cvDXM5FXHEvDRBtnBAfPUHg6iPC+T4xvQAacaSkurhIIH5r1/L3xgQ7?=
 =?us-ascii?Q?amWpk4T/EDf3M8g0XeGkt/HJvjDjTx5xgU+RFViPQj9lw469QclvcxaB28yt?=
 =?us-ascii?Q?Tk/LcL5tNnLlJrjkyG3nsTSQkxh1P75HCERqBUFX11LKm3fIvH+rDSTeAd4b?=
 =?us-ascii?Q?S+smd/yxw5mVt6HqfbSQaUNSZyHcM/F9u7tQgucYAyejD8nJLGbnPGekWst9?=
 =?us-ascii?Q?lJT7ppre3P2QS7IzZABowBfDT2xy1IcZZDCrhZ5fxBHQSJ07U1zUKoUq3tnP?=
 =?us-ascii?Q?WcjxPJWPSDyLqDZE51Dd0k0LcdEC8hQhZBTZemMvDIXoVoIrDePbxO7liaHG?=
 =?us-ascii?Q?LqE2hqHT9V0eS5hKFYr3yZ3xOphGkZ8DaG8ms4SpvyO0o4N9gGFZORGxLUlD?=
 =?us-ascii?Q?M7P4w5iLyL53D9qv8TtYoM5FnyE5C+WoXomFHVCe9YZ5uO7QJi4XDiyZtb/q?=
 =?us-ascii?Q?enFOg+XFRV6/oKT+IrQJc/defLOQui/W3z4uVUwa2vHzAG6ltiJ7eFOy/BFK?=
 =?us-ascii?Q?AaA5qtXliVzNv6JtHOku8Jaxm2L1YhY7HONAEfBb5qiLobRyEMq9qsgsaood?=
 =?us-ascii?Q?EYS67dyYSJ+XYIM9+zSjbPH8FgjuCxkjeCWlvzJGlZE+fQcdsgj0TIL2JhXG?=
 =?us-ascii?Q?TVf1Ykb6u0JByVTiAZjZhLPO6AX8xYiURte2f+bQvYxyhP8Jwxw/gih50GI6?=
 =?us-ascii?Q?4iCMwYeKsMWrdgH520tEVaoAZMPFEGKlkwealKOPcFcp3J4wzWDOkrDXIpAT?=
 =?us-ascii?Q?qAU5RpQX86coqqG39c0Sxl9JDbKhe20t1V7ial8kEuIrX9ZtRA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BOGXzUe/vRjyNU0cEL+MQbwChkhpgz2afV8dEPxoc3cbF9swth5A3iRoFJUA?=
 =?us-ascii?Q?SFCjZAL6Ibjps7L/UXxLpaUJk0xMj8iIG7sBNVUScV018I1uUzoCiuLP9ME+?=
 =?us-ascii?Q?c6+oyKC0JrEO1c9COxNXpPgBi3y9UhaR9DUUTTWL9DBhVjX1+zapf4qoIXmK?=
 =?us-ascii?Q?m/KuAG0pE/pzVAtsk6ShZAW8X0ZK/iGCRuPE5r1/jNxLmQKG905udtncVGXs?=
 =?us-ascii?Q?Tli3bDbrx8v4p4Fn34LELOwMsvZhfeftyZnt/jaBSlL6aauxaR3XOpHGijMd?=
 =?us-ascii?Q?ikjNZhmhPA1LSz6Pby88wTChY4imPVDieVKlSpD0wXJom3EU0CJLJpx1IsMk?=
 =?us-ascii?Q?BzN9eJFT4Kx3maVbQGYZlkp/cf36Sv1Ax5m1Orfc4sWEaoMDz37kE7qy1gkY?=
 =?us-ascii?Q?N5G7wGtWoQgJacnlfuPH7qiSomcEhFeKobw2r1ITE8jus89nYuoKj95qjRxd?=
 =?us-ascii?Q?Gj+sUqiCHwAiNM0TSwfzsEB56sU1mRtgLwPyECFr48SBQuu2EDkk6UqO8BWA?=
 =?us-ascii?Q?gyf7VwjgW8zHZlt4TJVezFrfHNwwoJ5DbbDxkykHTzmzd3EGLBv5jwHL0gGL?=
 =?us-ascii?Q?kKGXfrg+Ar44BG+dV3S2QC/UvpcCYSx009Ym4qwvoq1zzW5nWAsfr617J25v?=
 =?us-ascii?Q?qGe9g36P02GU2qMBo8EKjxsXMtD5a5sHtswmVMVrQhq/7d6ccR5sqdwMk4Af?=
 =?us-ascii?Q?kVM7D2aiy5KVw9ZRyvTjKf+I7TvIA2Je39vDmL8kaV8AYFzuBVSmHp3SuM9q?=
 =?us-ascii?Q?Y4JBn4yOR3bOsXrMSxCuXfHuy+boT3OWRC2l9J9lLodC62av2EMAypAKeW15?=
 =?us-ascii?Q?MAebKqCbYwP9N+DT27k+83RrRvEOlin38TUjT0U/9khoxNm+4znIxLYh5amv?=
 =?us-ascii?Q?dSqrofhF3LAG4f3J1FNZSBOQLpiUDDntX/l8n3KrCePlZUFOT4JwVDoIx0KH?=
 =?us-ascii?Q?S144qoCEdPPBElGKoWQh9TI6qiktsVUrhQiN0j7sOQkzkwuERTXNvSXoW1sw?=
 =?us-ascii?Q?glC+NOZzTVYg2I1au6hHJBCPqzc8+kOR0PNm4z0lEmoQxYBDqij1GwkKJ6bC?=
 =?us-ascii?Q?BLDH044QBPzN3NQnJ2XulmNMXczvzhL0ygwfYhb+buZZ1nLRQEaGlaOv8hqc?=
 =?us-ascii?Q?JQS8HqZFE/VMGDJ0Zbr+rh2CkfsAO6AOMpOGQN4rIgapWEnm0D5BNraOCGU7?=
 =?us-ascii?Q?mUbyaQYQLB0MAbCXt2vrclYd8ST4NkxtNrgQb+4V2UgBnuvu8EZ661SwCRGb?=
 =?us-ascii?Q?CMl9UXyBF1fyUnvAmVUdoagFBq4m+Ekbf6OZOPh6O2xjZKCLMW+GOByz4xN/?=
 =?us-ascii?Q?3zEi17HYbOMxRKWaBNSFvZx1invW+xD+gUXu6HBVJc7hxWt2Nroov1m2yUub?=
 =?us-ascii?Q?n0TxeRb2iAAFQRaj53f3GIPRjW9kdxGfZI+ayirESXHhrpQoDXmmVe7lrzLF?=
 =?us-ascii?Q?gG9Ifp4YEmWutoHB9OBFLsbZaDSaFIclvTb9Yk3UhSSwY6T5L/etO6IRdGF/?=
 =?us-ascii?Q?Z9Rh6lHUmIwvM83Eqa1et8XOlSD+S6j1ZZmUGMTmj/LCoaO9kytBmRFuXSv/?=
 =?us-ascii?Q?OMyI/ovFkW97u6aWw0MYC1FKHPzk1x/87zazDbo1WMyi3nGp6/hcrRUWIole?=
 =?us-ascii?Q?7p/07zX4fGMUdLqSLSysEfGb8s/Q7yW7+WlECEdqNxMF/TBYC21rrfNWSR/E?=
 =?us-ascii?Q?pFVPJA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7747f0e0-179b-4302-5ce0-08ddbf8f5590
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:54:09.3994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t34uq+KNTXq/x7SMlW8eSjsa+Byp92R5VJvMWJv83ruGTCJWzwF6jvuWRT0Kb9RlJI7UYW7Ej8308A4AkYuM7huPAO0kuoBg6Btn2LXFe4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8048
X-Proofpoint-ORIG-GUID: zQOs1tYHc1njKR1rxmytoaAPxj_Sm369
X-Authority-Analysis: v=2.4 cv=ccXSrmDM c=1 sm=1 tr=0 ts=686f7fb2 cx=c_pps
 a=wLjL7U/RDB/pQmeqDiFFmw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=mByk-SMsxhCBlLGf_oAA:9
X-Proofpoint-GUID: zQOs1tYHc1njKR1rxmytoaAPxj_Sm369
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA3NSBTYWx0ZWRfX4oEVxXeggm3K
 NSXMoQ0dNA6IbVCqzGnuGFg1NEqDMZtYRXmdba6LrP3SNz+WAL5wAXasx7CGLTbXRpBijK2efeG
 +XEZI/85Bve64EDH0LfAxcg1JeOkx+vznEuc230+6UgPxVI9vwEXZOsGXMIeOF80ImijpzJYCIs
 zCQkkoPQ2xYrMXtBg+MD27P7LjgzIajkO2SALs711G4wG2QZBLPHNNzplUgvQN5ObM4/R+65ima
 HAR49BbHIMevorBEAYLg7HkfkSjSW4AHgSYziu0WdelD3mCkZmKt2QGzlyClD+Fssd4FkkOEcFa
 IZFH4aAwbm1pIK2LTj9w91SYymgvRQlnDuEPomdZ8Hk3qLZgz/SIOkhHT2Ah4RnHs+UcvC5Cf1O
 Wi6wkwdpBBitQ+94K2HVwAaT1HsTQ0+WbKAPeVEkqCXe5U5wbWGgS7hfcp3iQv6B6m4TLs59
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

The headers for isapc-only devices can be removed from pc_piix.c since they are
no longer used by the i440fx-pc machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index b04c683e4e..ed5a313500 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -27,19 +27,16 @@
 
 #include "qemu/units.h"
 #include "hw/char/parallel-isa.h"
-#include "hw/dma/i8257.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/apic.h"
 #include "hw/pci-host/i440fx.h"
-#include "hw/rtc/mc146818rtc.h"
 #include "hw/southbridge/piix.h"
 #include "hw/display/ramfb.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_ids.h"
 #include "hw/usb.h"
 #include "net/net.h"
-#include "hw/ide/isa.h"
 #include "hw/ide/pci.h"
 #include "hw/irq.h"
 #include "system/kvm.h"
-- 
2.43.0


