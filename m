Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CC4C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 15:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZteG-0005ud-Gk; Thu, 10 Jul 2025 11:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uZtW2-0005R2-8r
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:48:56 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uZtVy-0000yV-DP
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:48:53 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AFDUwg019162;
 Thu, 10 Jul 2025 08:48:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=23CaQvgfw/Ukg
 h/APcBnpW6j9oceFkQFAx+qZLNFTNQ=; b=IbKAFQqsbo85gms/BIV1YPlUsvYP5
 ZTvw/Dn/QsOpllUCW35PwgBXGO1iVfXqDA+6Wjqap2jeARWqPOFYiwAOArljilO6
 kw7s5/2ZnGnwv5hlrrg8pd2wwxSdOqfMDlASl6nGKFSPBIOg/OGxqeujWpP2gL/h
 A2BPyR/E7LEH+zXcv+39sB/6kc7QPUHZBWM9TDbw7GvJgqVWfguk9M6d4i3/a5aY
 j98AqevEluQx8VcVXvl3VvOT0OtNyUqkgN363vpMvw945FmJ+c/GDoGv5xwyYZka
 lCUKRRD/6e8PGJQvK7J7MVO1nFC3j9b/OiR/Xh4OIGIGmo19ykNXxhvvA==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2105.outbound.protection.outlook.com [40.107.244.105])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47q3k36e86-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jul 2025 08:48:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfYXBgOEuyJQSd766aflb/obZ7p3CeSNatc/v5Km2EcYs/pKFK1VEolw4VR32+4NgiYD7NCqhiOUSFaRpsq6+tpiiYyNIsSNyEBOiMFsmasqgMB+HF6mzCInOvYx6pYv7IKIwMqtd97N5n+0L1N2UlKwF73eAGYl2opmfqt9ojQTM8+FvOksOAQeKWPg4kq5i40faDufyLfo7e46quLUQFDSctOZEIVeoMie1yVwOA8S9xyk8yTUI8EfWwNYUOk2AZCzj8ARyeBcixx9hgzlvE0tikj0Bp2uPLTEss0quq/4ecHL2Ib6xbnHbLp6pbqJASyC8xEByMpSBUSrv2OWJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23CaQvgfw/Ukgh/APcBnpW6j9oceFkQFAx+qZLNFTNQ=;
 b=Zuf2T7YMbeSSw+QA1c6FeQOMwx/4VHRhTPwJ9/djLezfnYp63NLvWalw4vIlaNcAuFcSCtjrzi0BK+F7r10nGVsfMgUIB+Icv0PNTQAxNQZjbST5/0Eof1tJg9qFNwbcSmoFTSvuJ902Tcee6ccWj2tTHidaK5VfBeaNHo94uN7KD0jcW8oiDnYVa2+mM3gb/Atcly0TsESY8sYAlhnZc/xFL7ldBe0s0FagixcHSgI4ANgvo7hcL4fAuXNHOidmkPKiSoqE7MuV/U3YvQVkd2JheUZTYn3obfqGpHA9I1ySL49o3ubzr9OvXPEYwM37FXtrcJAwBPdt33W9LnvIMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23CaQvgfw/Ukgh/APcBnpW6j9oceFkQFAx+qZLNFTNQ=;
 b=uRvPVaKEf0SU4SnJOLClo810Y5Dp5V+JFEwuAV09P467J6uT7QR5Ct5zNJYY1PCBUfYLJKYaMPDuekgYbCyD3yoWIMiiC3/Js8VTLN+gAPog+8dKm7B+zqcjyztCxEbOqul/+6IDNpcNr1WRR6RZT4IFWWnjbT7h66FgoO3VyKcmwCPoKW6EUN27+8BcIGekqCt2U7x97+nU2Sfovo/HIMJYyz1hrS8LhTGsubhfUBy73iRfYYJGaju5nz7c6kt8/0Od1GjEd7TZwt2PrPmwg3LDsjEujzpuSPaanJPWID7zl+joauF18EJLHXA97H2tvdLWZMKEQ328LVkhmsepQw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH8PR02MB10897.namprd02.prod.outlook.com (2603:10b6:610:2bf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 15:48:46 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 15:48:46 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH] hw/vfio: fix region fd initialization
Date: Thu, 10 Jul 2025 16:48:42 +0100
Message-ID: <20250710154842.1267253-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0215.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::22) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH8PR02MB10897:EE_
X-MS-Office365-Filtering-Correlation-Id: 843c6b9b-182f-40f4-d55f-08ddbfc94138
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uHo4M+xvQNy0xXUToHkrP7NfFujnn/kDlcGL5nuZ8u9WHa80JWiKdcqmRiOz?=
 =?us-ascii?Q?F+8tZn0AeJXImEGn1DYznaltp+ZgW8xIVkdmx4UiEmS34K9YXrk8e3CXthrE?=
 =?us-ascii?Q?COs7HfSMcMorcr8u3EXafhmBRgD4K/4nqlIeFnkjFgZhPqq5+9fLUTllB1++?=
 =?us-ascii?Q?T1JvA4TtSEIJB52Fw7tuus1vVB1wubwkaOIvwDqXiq44yNGuIVsZct+nu6/q?=
 =?us-ascii?Q?AqL7ofMq8PNOF1+aEgt3N+Q3C0O1AfAMDBrhHjvc0r+ii8EK0i2s+S31a7t2?=
 =?us-ascii?Q?gKsOxiNvPHtQb4ktobRX2XtUyhlbMwnKnG9U0w6sLmu6TG6eYKwVNo5/lHYA?=
 =?us-ascii?Q?hxHHLfju417e/8egjw6VqQdXrdn/+QazU6O0s2JV9CoH56kj/RYXi7Wui0vv?=
 =?us-ascii?Q?hvmza+rjJpjE2lRRZnVwAChuqS4sRZ/Tz5xcldCV21/UNCko5eYYHR2bkyTb?=
 =?us-ascii?Q?x6yc+ftqp3HsujmBOcJiuKsBhZ4UVUgOHImxN1u9PG8AlrelZBqlew8/viUL?=
 =?us-ascii?Q?QeSJEHDxJHaH8vfGEHO4soh4jAg1XbcrReD3vdk/XTa1eKCjdhIuEV8mNeVO?=
 =?us-ascii?Q?hIrxS29tKmf5sTnRjbq29PTYOQrdEdmd5WPhsGFvQ6+F1EnQg0+orcYMPkxP?=
 =?us-ascii?Q?VmTHG9U0rjWRoS56QzMHY4VUP6mTZKc09O8Jv2z+ZwMil9So0CJz4GUp/i+G?=
 =?us-ascii?Q?vbV5TYdz2FzSWOPFCj76dELXf6OGyuNGo076RqblBLUgDfHCuidRt+XBRxro?=
 =?us-ascii?Q?YDj2fkcXEZm2u9dUOnkVApAwNk2JjpPfGhYXTfA70vaqvj4oLa7K767T2s9A?=
 =?us-ascii?Q?YB995lWDqIirTYFIJxF4+p5aNjmm35U0gCZOUGLKbcMpmRVK/9DRmPnBM4b5?=
 =?us-ascii?Q?XyYgDgJ3Mx7Ln1dESPYnNmL39+MLSGwA4N9gNKg63/AVsgeJ/NfVLL40pd59?=
 =?us-ascii?Q?1z6KdGPegOTkvQTu366GYkW7x9rYSSBNMppHSAwA5Q2r7bawq6t4vQufPUtT?=
 =?us-ascii?Q?bESig8KTg1LX0szKYaCTd3fT3YyvfR3E0O7u3tmY80OqTEZDpz+AP+IHYUMC?=
 =?us-ascii?Q?mqtY1lm3pG/IQPaUyyjCocLDpN/QmVpla3ZR+EeG9t0etXE7c46FpRq2hQRl?=
 =?us-ascii?Q?8hy7/nSzkvg4PROUxHIC3CRJi5eSFTelsy24P/EsiUfCRbw1hndzKX9qlAIw?=
 =?us-ascii?Q?t6N3wn4FEdt0V3aWz3jvRC8XBdhHVd0X7uY96tS7xGoZX7bxUgtCl9x6YkNC?=
 =?us-ascii?Q?/1nt2W69JQXavqWmrwGZzh5OhVeYr580BZ4LFp06QiqgIY5xGCLlQHmThv4o?=
 =?us-ascii?Q?Hj/PSQcITGRpVx5yLfk+JfW5urFkRox4arwQ3YvuByvJJCyQMC+xpLc1oSQc?=
 =?us-ascii?Q?fQijlQ4SC13DWC554Pc1RbbHHHk4gv2i/9xukHmtBYGjFOXPY2mXwM4IbzSP?=
 =?us-ascii?Q?Z5xHVjHJ+VA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xPpVRyuzjG1Ks35jFvIPFfKc8gw9Nc7n7D1QMa+szRgZkUd6UvP6edaURcAg?=
 =?us-ascii?Q?RuhzuJ0MDbCM7H1yRMxY5QqAoT/4emNC8qljFPK2/U3tmwDqviTfQyTtoJAs?=
 =?us-ascii?Q?7PB0Ux+7AJutRlvYHV9tvj4m4qRyKAHuaRNRVsiKyYKuAbNfc8QFQZpXRqHk?=
 =?us-ascii?Q?j2sBpQJdx3gUxeh62Hq1RfWkvbuTrlrb15Ip03exgGZGzR3G7mSYUS48dh4m?=
 =?us-ascii?Q?hpSMgvr/Ov18sRtW9uFlSjceLqULOa6/JUmeziJ23SdlqBIZilRDPtcqUHGG?=
 =?us-ascii?Q?fHKCUF2xqPKbZl7eL+dFt2qglPEXZrcqikumn2bNMdkn+RkP0nLmQaOG5dLk?=
 =?us-ascii?Q?VNIRSv0vFQ594quh+GcvfIDjHJYigXxDY0YIitoSYwXhiGVGEWeqVreoghkO?=
 =?us-ascii?Q?T/oYsivhO3oNJAzzqRTfRmIBoVGW9kkq8p+RT1g0dUvDC9IHeJeKW+EfczKR?=
 =?us-ascii?Q?ltRspb2y6Tr7LZZAMqneLqXfcjpXhWUiPXJzI0qDvgDWh+EElTn8mkk+rcH3?=
 =?us-ascii?Q?n8+s6Fn1gBOmiqzFBxv7R2ixYBg6tkEXWVXGDIygPcOAqOMSt+IOPn9HrCSB?=
 =?us-ascii?Q?/B7pix6/9d04tB+V+YixsVHkhDhg61CYTg1jidsUA0YD/araW8S1fsAo8UZm?=
 =?us-ascii?Q?riLzdPhJzvYMsI6zqsAV8mazdZAlWDQR1lnKq0ZvQkQApWXKX+gyyI0LBuDc?=
 =?us-ascii?Q?haW56uj42mmzkLncJ/vy3HHQjWo7+aFWd922GIaXw4nlUdhHqw+2XzWuIit1?=
 =?us-ascii?Q?dPvDVYcpKQhb8JuUngmwwawwpeBhn6dwyMGgbXOD0vfZsuK3LqZPDtMGa34K?=
 =?us-ascii?Q?rC1OzSySbt9Ey19iStOgm3XS6xlyP14x9DrOglQkdex7OjDjG5kfbztzgT9h?=
 =?us-ascii?Q?K0JTDtfHPQP1Jq4OsJHz/XX79deUVmIl1v3ZIdWwX0l5CyniV2yvaTkXOp78?=
 =?us-ascii?Q?tqvrXpfo5LWPIDSs30jBnYWIrIJw2xDr3mVSdRrBRAcCkdDyuKLSa8hGZQL2?=
 =?us-ascii?Q?/JZcA0a00XqLFS8CZyzWEPud4obnjrU+djxW/dT6oHh3a+ZDI2WBuKMInwlj?=
 =?us-ascii?Q?dhjgRVFapEaJEckh51fOEtUeHg2jIJzjHkrV8Ri2e7fNXoIorxmpHLxFI26U?=
 =?us-ascii?Q?45YlEOfUBQFXjIaPlg+rpL4/7s1B5pyvCFwtRHvcWiohc2+Ys1mjics77dKB?=
 =?us-ascii?Q?8hAsWzXvl+6sT1QN8lwSrh2c+oStRof9b8tpCeHiYfDamBjRChJwGewJhB9r?=
 =?us-ascii?Q?gLlb+/P3jNwPXe/WuKwbDXldX+AMjwmIrVG0uPIGS7svdmSLjk7MKzfRiKTz?=
 =?us-ascii?Q?E2ttbQjYS7B8wGaXkVt1IcL/X6M2BQmBVoC+fnTnMcTdH4oDG7Z4qKzdNdHY?=
 =?us-ascii?Q?6vJPQ0MepGtfXZszhCwwy1/3jTnYFkCbKPKCoXbpE9VHxdmptRlAj/e1us8I?=
 =?us-ascii?Q?LgFNP/ir5j9Q9a3HnB4U9hc3OLwsMMshZTj8jieJ5Bva1TGXPUcY0Bk56VPu?=
 =?us-ascii?Q?1puoyqKEFED34WosGjQZFF29WELA+bqh3M0E7aAUMmfvUBOIygenTSGNKhe5?=
 =?us-ascii?Q?bPmECCRs9TetrE5PAj9C9u1tU81TG3QudQlqMmgl?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843c6b9b-182f-40f4-d55f-08ddbfc94138
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 15:48:46.1866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LfvV4K731oFJChGXNN4+zGSpXj88lfU4gIkxFkuVVcMckTiqYYZmzCR1YEL12JMN6t2E0tbIEAENIcRSIVDrOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR02MB10897
X-Authority-Analysis: v=2.4 cv=UNDdHDfy c=1 sm=1 tr=0 ts=686fe0e0 cx=c_pps
 a=W7ZfpJ52Y0I/iYNgY30rAw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=sV9AKFzeoAo0iIp09WIA:9
X-Proofpoint-ORIG-GUID: H_swtzs3f_FY399lThEdAhOPp9_2VvEq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzNiBTYWx0ZWRfXysK8d27DhzrA
 RcX5l4p66J/vX5rdKs2nN/FIVpXWq47W/09ZuWIVgumdQkVG3JqM0IqLm7H4mWD0Xs88C2AnVZf
 7wupLsA4iJ7OV5XGsP3NQ8+EyVWF61CU11RMyf+NLiwtO1msoBKqtmd0ljl2T9fnfH1LpSIdmMf
 3Eqd57vGbN1VCB3CfkziUxgw/eYsmHXaRfr3FqY3/iDpveg4b5L7euxNJnkS3BT601bABDZ0S3r
 pDC618JZ6klwuNCUyeDB4JMWCkIJ7tXHMpCrqyIOc4G6w3kfCaQ1cb4SimIoX7IAIbs6HynyQb0
 hCGomYqKX4oplbA0DVCXYpKsrlQMc02Bm6SWu+JkdgHuWb0FcuVNxwxwEjP9aEh71Q0ocYzVwxU
 eiobm2AbXZvTp96BJk8F1zXZOgFQ5/YyUn0iW8k0OGLlTaaX2TVoANRxBHoy1rBhbcBflj/f
X-Proofpoint-GUID: H_swtzs3f_FY399lThEdAhOPp9_2VvEq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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


