Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086C2CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uraY1-0000FL-Bv; Thu, 28 Aug 2025 07:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXz-0000DG-2c
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:12:03 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXw-0005WR-Fs
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:12:02 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57SAR2b23581295; Thu, 28 Aug 2025 04:11:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=iOHedt5jRSDxiY8AuLdAuf0HAnQDiIeeTfNX5c0mr
 og=; b=xABoy/svVf4XCcmy7voHVMQbS9CfSfgntezhme/GVKEbBLi1cPbN+QPrQ
 DynzzKKIFLJsnzUexD8E7RuVKN1ozWgbdEhI0o+J8QeMBejUomVgEcdTp347Phha
 fKUXnLpLs1k8nk9Olj0UqBrYAYswPuipV+FRQN2kA7YRQg6VNTd6fesq89jhx+7u
 zEr9MH3v4b5J0POnu18aoqSQruwaIWPU//WQdVrpddcU/RfxwUfsG6O5DUtTHlc/
 PIquYSfA4rG59DD8k8zR5qhHBxVVDjs7fcUZ9/0qygFNgWoHhTuI5H1WU42vf3aR
 nG0h2jlAeeQ85UQiSNGkc4gmKQDNg==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022109.outbound.protection.outlook.com [52.101.43.109])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48tcc316m1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 04:11:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AaLZ683oMBGkKJSmZw8jq3HHhSNGOZeZ51Mu4CI3g82qbw8mRcYIGqEm3WqurO+LTw3Dtm5ba8z6pRx4SVIH3ikd0vbyHQBaL2WIsuhQ9fwdc2p5EW1dfNh1Q1VAQw4iBKnfB9RkVQGQaefMh9/Pu+c+wnZwLe5AFdHNWqdbFlyDRyQSnj9wla9fT+6uIeS6IDjbxVR77ACU1dyZI6QRrzZCig0oOGC0YSltwOSAsI84nP+WurWA2vjuiAkg8fDQXD3LwZqzJ9CiE1Jo/p2ddZnTRyklhCyaOqcuieAIAKmt714VwEdLtoiH2GANJtkx95evC5SBXnG+CbkdaTFeBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOHedt5jRSDxiY8AuLdAuf0HAnQDiIeeTfNX5c0mrog=;
 b=OkR2Xju4qz8K+MOBdnXLHJeJyofviLym7qdyBt3DsLy1xChVzNMzEIDfXYRXuegNgP7jAw5zHs6o2vkIcP+YYC3pXhU/dODMhb9FF3zE0Lyq9aSh5zSCAGsOl1XKpZopiyfKTl69uCYp4HaTztcxAX+cPrBYDn4N3EQCZkQAsMKscVLNv6s879upq2pzk1r2h3IhD8yfvQDA5L6h8gqFv5EAk83UZ1oT2lUksLnQzhJJLWCrErXeEVB03BdAlnBI/tTin8uVfVHJxKLG6imGUvOj/wBVraKixu3oM6Ra9FkJRC0l52y0xWV4lOlGPD9N3mTX9GT6hJkzyqS8NRAxag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOHedt5jRSDxiY8AuLdAuf0HAnQDiIeeTfNX5c0mrog=;
 b=q1uA8p3ad7mHNU5jUCaCVHM1bqcsertd2LzoDvhGaNLfFRMU/Gc2eDckb1n30FioAadDysfuH37ztQoTgXXBNfLTFD7wb7v/O5uMlb2Q/08zm9F0k0UJ+igdWM/YxhpUA2BkSYdc9P5LXpu4DNtrHTHz9cmx3/CPkgYsbCloUhSER8+1ky8LbBm75N6wG1Te+eBwJw18JlPtFZ9UvEQWgQO1r/EoIpLfLcoa8DWk/h+dUw6mXrvqsX/qfETWMvgvH6on4C7F0+/msfLZobV1z+/VplJ9E/diKpjrGDJgwmte1NPgr1vbLi2e+NRNm2uKywSnBdh5XiMszQoJQrOTKw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8077.namprd02.prod.outlook.com (2603:10b6:408:149::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.23; Thu, 28 Aug
 2025 11:11:53 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 11:11:53 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v7 16/19] hw/i386: move isapc machine to separate isapc.c file
Date: Thu, 28 Aug 2025 12:09:59 +0100
Message-ID: <20250828111057.468712-17-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828111057.468712-1-mark.caveayland@nutanix.com>
References: <20250828111057.468712-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0008.eurprd05.prod.outlook.com (2603:10a6:205::21)
 To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 43ed3f62-d0b5-4cc6-34de-08dde623b151
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lrnWHdzbn602I4MD54AkbmOug4uKPH+nFpGopuQK7ryxwTJSWVlGnuo3GFIN?=
 =?us-ascii?Q?8kuniqJ7GT5V/wgvXLU6DAxrXKgCqekJCi2RlLBOdzilVzA6V71ntiIscDJM?=
 =?us-ascii?Q?hpqxp6ASLYo1EOsSUs0/T6V8h/KzGNxZYTe0Y8piOBjBjhfVMwEk5KknVlaH?=
 =?us-ascii?Q?EcJ0DmCt6IS+AwKUq4O7VdWZnzdPg8u4SMdFrBKTcLYmchdMuU0T1QYlaF3R?=
 =?us-ascii?Q?NmhjDOiQayfmZ87cR9Czrei8s2k5KU1wzBaaCWKqwNOMhxgwP2BjqnvyPwcN?=
 =?us-ascii?Q?NIFIVho4sGlVolv4O6ISvObTKb+CrDLZCIo/YJdXg+EbO5nI6orgIpVlb6BV?=
 =?us-ascii?Q?3S7OZI2hPTro7LX/NCSCE059Ygveen70Q5O6AX0RlkdLKYNySozEa76IVieG?=
 =?us-ascii?Q?M5wm+l1NDX6Yw76TBQfGswujD0HDPAp5+D5l/sbxbzW42IrVTkIOOj4D826L?=
 =?us-ascii?Q?M6EbSW13WshNvLmZOdAkmvl07jIMfP9s1Eubu6MN+zcljM/ngCK0D9GDXWaL?=
 =?us-ascii?Q?DdnqVNsif4wsiv4h42RrBK60b/CPHsaZlPOnH/wplgZlNlSBJTiIL60hEPot?=
 =?us-ascii?Q?poYdjnfYZvpm5MLJvz8sZtAsp4iOQOAweNfDRVcrKMc3nW+Oa77krSGQMyKV?=
 =?us-ascii?Q?eSrRK+ZvaPntkJVGRRrA2gml95vksltBVCN316XvaxtMpNe7H4awxiYbVpw3?=
 =?us-ascii?Q?xwK7Ut2xQazjv0zygCZwWdSgwLvNL5eMEP+1tsylikCVP0n9dR1dOpdgrZkf?=
 =?us-ascii?Q?zJ37O08iDGN26zejceVlh3r98FO+Te8hVKgnuNTeN8IYXiwee5+vK4AV9YO4?=
 =?us-ascii?Q?Qqewivhem0wr1GhbGSa+tyje4sk6BQunR0T6QnssxBwkU/9Y2S7lCv2VNTcv?=
 =?us-ascii?Q?QG4597eeS6weSCaKAN76k0SAAstGjRFybw0vU0C+eZFpFIBd4DGkRixl0Wkx?=
 =?us-ascii?Q?r1xhe4LuAUHBgA3b3xYUt+QXS3dmBDBeqU0Bba2Xp0REyeg/IuvuaJv5YRhp?=
 =?us-ascii?Q?xMGaC8bTm3hpOGR0ayRqq/odIn5lkP2e72BCx1tUOquwHZRGPS5f+acrghQ3?=
 =?us-ascii?Q?sQ2IFT3gV8QJ7Yx63Tf338vxDVyNI7hDBuLs7meeAhoyfa/S/pElcW8vMsJS?=
 =?us-ascii?Q?DOhWleZqXpuqLhoHRdf3aRGrWwcoLZGfHPJt1zSpm9zUfYSJ7lc6qLHVIb8N?=
 =?us-ascii?Q?R9xcAvfpZZ2QPgrys+hbL5AmaoY4charGYH0oAQZrZrK38B6Zu6Ni3/SWJDl?=
 =?us-ascii?Q?U5rk+E7hMVnkMk2mQBrV2CH8DF2k/xj02Euj7wHIZAvspmJucDTxe4yBa7UU?=
 =?us-ascii?Q?CIVNUPQqJvrv1BvT2VEpItrQCwmjLg8hlIrJoU7phYiMo1dDu1X8i5bXMIv5?=
 =?us-ascii?Q?KKChZSgGg0mCR9lGkwz7I3FAHBDApMVfl9lQ5iBehWdf6PnUbwszuRh/Lm4J?=
 =?us-ascii?Q?JS8EmX/Mux0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W79byzbmU0yEVKtEzlvsePB42jaUJJayf+40yA9wHFFT+u6u25MU3s/ohLNs?=
 =?us-ascii?Q?IKuU/1+K+gseNq1SAdcihyXPwcp9Hl66dNNJg2dJ4G3SoDLOHiRdIFlC9O6q?=
 =?us-ascii?Q?KUUs39jHAB/x1AQLVg1aOIfptQVT/pX7evwW8cy8hqPUqff19D/wjpdRwYuL?=
 =?us-ascii?Q?eQZdKpwDwKBTgCZIhtOiizHGBVZeQEcQh72nx/GkskwuLn+eMW4+bKA/CXQW?=
 =?us-ascii?Q?1bGNX29e8ZV8G6vG3XTiFNzIQ5SV3xVlpIe8frCJqcBhduK/mfRDRkVB6ok4?=
 =?us-ascii?Q?Me1MC551rZQicRNVJI4vhS8NhzApDQT9FlFyFrxc1h94AyGcIda8WOJrJJ7J?=
 =?us-ascii?Q?SXjvM6Qx4XIW1SSfFkVqCNU99KFNcvcJLuLPABv1HX4YXUbflqqlVlVlJC5I?=
 =?us-ascii?Q?leJonQhAgnT3gca+9QM+TSxK4quGuKba74L8yK4qgvP4u4JGfCU4kdACUDHD?=
 =?us-ascii?Q?aADVK8aYJ/DdP64mWWG/uff97GEt2mNcJtPL266v6kp0K5Joer8+vbZIpSor?=
 =?us-ascii?Q?fqY0Ff5DlqMskMvqdI0p1tlNetdtZINFsqVPc+l8hKKhTaKtdtCDsMx2QoYK?=
 =?us-ascii?Q?u1qJAz/ZJe7jhUrkNlzccVhoPg2v3HY5tANAdkHXKgBe5SdlAgxTS4GcHIG0?=
 =?us-ascii?Q?1L84elr9GrCiJTuFzcKYvk8DE3zQK1FNSC6emVw+/RfYv8KVEeDNJ9w6MT3I?=
 =?us-ascii?Q?kzf49zO9x+lciZoWLZwrsQyS6nemZBN+ynFjRiu1BkKhB/WBRNDPDapN6WnI?=
 =?us-ascii?Q?N01Itv+83nOrH6biWueMvO2My8LBid80L1amqjT6Gw4ocQQUEO8om7B4Ez7Q?=
 =?us-ascii?Q?KEhYh5m8PrkbCVaAnG5BgZbsw8zp72gTsFC0+uUF2Y2mJNBp5ounSOQd8EBQ?=
 =?us-ascii?Q?uWrcF0Sh391HRFWp5o16oAG5Np+o9lZgaRUF2NBhMPq4KgMMF+JOZw/8zVLB?=
 =?us-ascii?Q?2dEOOP8x3g713zRYXt13OiRPYK9ZXjbLJ6OsmWSsZrIRjtBVtWduDvDAB0/3?=
 =?us-ascii?Q?z8UX3uvbDMtcdOZVsuyDazA+6n2mAyJIwsu5WnwZkfDXwRmw6uJEbhHRzqzJ?=
 =?us-ascii?Q?cJvjj4y1yvhPJ0PdNJg7Nbjc8cQArNHrra5CVfSwuQraJ93pVR2imlXn4J15?=
 =?us-ascii?Q?eNeB2nXw3iNN+W68i8VdSp+ooZ8j/b4Obf2mEo9ytmK08q/Rwd/9UX9Pybnz?=
 =?us-ascii?Q?oJ3yBCUPB3tx4bJOpdGrn7KKIV73ljEkRTXQ2s/OlTt8XceIjqgSR47aePUg?=
 =?us-ascii?Q?Cty2mMKX4fCSzIcZHYOOFgqc/goroDZd5OMAlMag8kthqOAdtckxk6GYBhEA?=
 =?us-ascii?Q?cWVeIW2pc0f0rDE9YdGoVWEDCHjorBOJfrq2BFIXZOy6GFLNGqL/paHLo7ca?=
 =?us-ascii?Q?7DlZ3OBbzRWVGB0b1er0MAvCugGJUZmNcFdHVIPNKg8r68eYHNWOy3GmbGrb?=
 =?us-ascii?Q?VeiroFg7GPmBN4CWzmLLySWh+T1PtY+5Hz1N3B0Y51EXdLK439vVEk8YPh+d?=
 =?us-ascii?Q?MiMCpyxr0rVP8mL6MEZOUz1DzhCWW0Q/v6r9swSJTHQejU50R1hnYUw7MmuS?=
 =?us-ascii?Q?DZo4Ywn2eD8eo26UZ90YCABpS55LslRDTPjcy1L8QUSmbyERdsbMDT5xTpAV?=
 =?us-ascii?Q?mRwGMPkTwhmHt/yFfRqsgjwq5RGMr03+M+5xvNDAbNeZkF+J4Uw/dwzSb0q+?=
 =?us-ascii?Q?E+oOmw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ed3f62-d0b5-4cc6-34de-08dde623b151
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:11:53.0553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hB4GvYiXrW8O1DpaM6QN0vBoGex2X/GHxpd9KOyRmnnzO9vsKuuW+2+4bRtV3ZtPQk5MzB6mbTlR+ZgUn9pIYTfSMof5imU1ixjkc/Ed2nU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8077
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA5MyBTYWx0ZWRfX1G7oHdxNK78F
 cxtB6kN/jDjPWQYNHINZ3/1kuj1qnwuQ8hA/4oKmTRZG5hHyEPdtxCxb/DKmuIMUePjPXPmSU43
 IQQox097EFGxQjI4PL/R89xDRg6soXWC/H1Q7v+A15aEpvX4Upcq8ZTtce/5P5sNWd/Yqy/xgU9
 WkhpGTWtt9dexWHqZMeDAFh174suqBZjb9Qp38UwppuBXekeyAlgu5s9KvMrslQXaSTdZ2hoW9C
 uckql3qoUnnUlQK3nMcgsCvWX2aNJ2AngtVS7vIn5v0/DdfsNp2aNcSIXMAZ3MvNYuEdzbqROC3
 jLiK9FeJv42hyZuqoFi6nvX2r2QM1Llg6uXUVfNZUC1mxhqwXwoLo3JHboCXRI=
X-Authority-Analysis: v=2.4 cv=JaS8rVKV c=1 sm=1 tr=0 ts=68b0397e cx=c_pps
 a=lEAIQdlJR7AYAfTETB4wFQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=7bRSbqZUHoZiyr9U6aYA:9
X-Proofpoint-GUID: 6cFOOKENSzvCcKEd5njdH0KX9yW1IvGv
X-Proofpoint-ORIG-GUID: 6cFOOKENSzvCcKEd5njdH0KX9yW1IvGv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

Now that pc_init_isa() is independent of any PCI initialisation, move it into a
separate isapc.c file including the ISA IDE variables which are now no longer
needed for the pc-i440fx machine. This enables us to finally fix the dependency
of ISAPC on I440FX in hw/i386/Kconfig.

Note that as part of the move to a separate file we can see that the licence text
is a verbatim copy of the MIT licence. The text originates from commit 1df912cf9e
("VL license of the day is MIT/BSD") so we can be sure that this was the original
intent. As a consequence we can update the file header to use a SPDX tag as per
the current project contribution guidelines.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 hw/i386/Kconfig     |   3 -
 hw/i386/isapc.c     | 190 ++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/meson.build |   1 +
 hw/i386/pc_piix.c   | 172 ---------------------------------------
 4 files changed, 191 insertions(+), 175 deletions(-)
 create mode 100644 hw/i386/isapc.c

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 3a0e2b8ebb..6a0ab54bea 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -96,9 +96,6 @@ config ISAPC
     select ISA_BUS
     select PC
     select IDE_ISA
-    # FIXME: it is in the same file as i440fx, and does not compile
-    # if separated
-    depends on I440FX
 
 config Q35
     bool
diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
new file mode 100644
index 0000000000..300d64b7ad
--- /dev/null
+++ b/hw/i386/isapc.c
@@ -0,0 +1,190 @@
+/*
+ * QEMU PC System Emulator
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#include "qemu/osdep.h"
+
+#include "qemu/units.h"
+#include "qemu/error-report.h"
+#include "hw/char/parallel-isa.h"
+#include "hw/dma/i8257.h"
+#include "hw/i386/pc.h"
+#include "hw/ide/isa.h"
+#include "hw/ide/ide-bus.h"
+#include "system/kvm.h"
+#include "hw/i386/kvm/clock.h"
+#include "hw/xen/xen-x86.h"
+#include "system/xen.h"
+#include "hw/rtc/mc146818rtc.h"
+#include "target/i386/cpu.h"
+
+static const int ide_iobase[MAX_IDE_BUS] = { 0x1f0, 0x170 };
+static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
+static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
+
+
+static void pc_init_isa(MachineState *machine)
+{
+    PCMachineState *pcms = PC_MACHINE(machine);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms = X86_MACHINE(machine);
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *system_io = get_system_io();
+    ISABus *isa_bus;
+    uint32_t irq;
+    GSIState *gsi_state;
+    MemoryRegion *ram_memory;
+    MemoryRegion *rom_memory = system_memory;
+    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
+    int i;
+
+    /*
+     * There is a small chance that someone unintentionally passes "-cpu max"
+     * for the isapc machine, which will provide a much more modern 32-bit
+     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
+     * been specified, choose the "best" 32-bit cpu possible which we consider
+     * be the pentium3 (deliberately choosing an Intel CPU given that the
+     * default 486 CPU for the isapc machine is also an Intel CPU).
+     */
+    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
+        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
+        warn_report("-cpu max is invalid for isapc machine, using pentium3");
+    }
+
+    /*
+     * Similarly if someone unintentionally passes "-cpu host" for the isapc
+     * machine then display a warning and also switch to the "best" 32-bit
+     * cpu possible which we consider to be the pentium3. This is because any
+     * host CPU will already be modern than this, but it also ensures any
+     * newer CPU flags/features are filtered out for older guests.
+     */
+    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("host"))) {
+        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
+        warn_report("-cpu host is invalid for isapc machine, using pentium3");
+    }
+
+    if (machine->ram_size > 3.5 * GiB) {
+        error_report("Too much memory for this machine: %" PRId64 " MiB, "
+                     "maximum 3584 MiB", machine->ram_size / MiB);
+        exit(1);
+    }
+
+    /*
+     * There is no RAM split for the isapc machine
+     */
+    if (xen_enabled()) {
+        xen_hvm_init_pc(pcms, &ram_memory);
+    } else {
+        ram_memory = machine->ram;
+
+        pcms->max_ram_below_4g = 3.5 * GiB;
+        x86ms->above_4g_mem_size = 0;
+        x86ms->below_4g_mem_size = machine->ram_size;
+    }
+
+    x86_cpus_init(x86ms, pcmc->default_cpu_version);
+
+    if (kvm_enabled()) {
+        kvmclock_create(pcmc->kvmclock_create_always);
+    }
+
+    /* allocate ram and load rom/bios */
+    if (!xen_enabled()) {
+        pc_memory_init(pcms, system_memory, rom_memory, 0);
+    } else {
+        assert(machine->ram_size == x86ms->below_4g_mem_size +
+                                    x86ms->above_4g_mem_size);
+
+        if (machine->kernel_filename != NULL) {
+            /* For xen HVM direct kernel boot, load linux here */
+            xen_load_linux(pcms);
+        }
+    }
+
+    gsi_state = pc_gsi_create(&x86ms->gsi, false);
+
+    isa_bus = isa_bus_new(NULL, system_memory, system_io,
+                          &error_abort);
+    isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
+
+    x86ms->rtc = isa_new(TYPE_MC146818_RTC);
+    qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
+    isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
+    irq = object_property_get_uint(OBJECT(x86ms->rtc), "irq",
+                                   &error_fatal);
+    isa_connect_gpio_out(ISA_DEVICE(x86ms->rtc), 0, irq);
+
+    i8257_dma_init(OBJECT(machine), isa_bus, 0);
+    pcms->hpet_enabled = false;
+
+    if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
+        pc_i8259_create(isa_bus, gsi_state->i8259_irq);
+    }
+
+    if (tcg_enabled()) {
+        x86_register_ferr_irq(x86ms->gsi[13]);
+    }
+
+    pc_vga_init(isa_bus, NULL);
+
+    /* init basic PC hardware */
+    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
+                         !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
+
+    pc_nic_init(pcmc, isa_bus, NULL);
+
+    ide_drive_get(hd, ARRAY_SIZE(hd));
+    for (i = 0; i < MAX_IDE_BUS; i++) {
+        ISADevice *dev;
+        char busname[] = "ide.0";
+        dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
+                            ide_irq[i],
+                            hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
+        /*
+         * The ide bus name is ide.0 for the first bus and ide.1 for the
+         * second one.
+         */
+        busname[4] = '0' + i;
+        pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
+    }
+}
+
+static void isapc_machine_options(MachineClass *m)
+{
+    static const char * const valid_cpu_types[] = {
+        X86_CPU_TYPE_NAME("486"),
+        X86_CPU_TYPE_NAME("athlon"),
+        X86_CPU_TYPE_NAME("kvm32"),
+        X86_CPU_TYPE_NAME("pentium"),
+        X86_CPU_TYPE_NAME("pentium2"),
+        X86_CPU_TYPE_NAME("pentium3"),
+        X86_CPU_TYPE_NAME("qemu32"),
+        X86_CPU_TYPE_NAME("max"),
+        X86_CPU_TYPE_NAME("host"),
+        NULL
+    };
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
+    m->desc = "ISA-only PC";
+    m->max_cpus = 1;
+    m->option_rom_has_mr = true;
+    m->rom_file_has_mr = false;
+    pcmc->pci_enabled = false;
+    pcmc->has_acpi_build = false;
+    pcmc->smbios_defaults = false;
+    pcmc->gigabyte_align = false;
+    pcmc->smbios_legacy_mode = true;
+    pcmc->has_reserved_memory = false;
+    m->default_nic = "ne2k_isa";
+    m->default_cpu_type = X86_CPU_TYPE_NAME("486");
+    m->valid_cpu_types = valid_cpu_types;
+    m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
+    m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
+}
+
+DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
+                  isapc_machine_options);
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 7896f348cf..436b3ce52d 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -14,6 +14,7 @@ i386_ss.add(when: 'CONFIG_X86_IOMMU', if_true: files('x86-iommu.c'),
 i386_ss.add(when: 'CONFIG_AMD_IOMMU', if_true: files('amd_iommu.c'),
                                       if_false: files('amd_iommu-stub.c'))
 i386_ss.add(when: 'CONFIG_I440FX', if_true: files('pc_piix.c'))
+i386_ss.add(when: 'CONFIG_ISAPC', if_true: files('isapc.c'))
 i386_ss.add(when: 'CONFIG_MICROVM', if_true: files('x86-common.c', 'microvm.c', 'acpi-microvm.c', 'microvm-dt.c'))
 i386_ss.add(when: 'CONFIG_NITRO_ENCLAVE', if_true: files('nitro_enclave.c'))
 i386_ss.add(when: 'CONFIG_Q35', if_true: files('pc_q35.c'))
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 3ea77b2c44..988c9edc32 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -71,12 +71,6 @@
 
 #define XEN_IOAPIC_NUM_PIRQS 128ULL
 
-#ifdef CONFIG_IDE_ISA
-static const int ide_iobase[MAX_IDE_BUS] = { 0x1f0, 0x170 };
-static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
-static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
-#endif
-
 static GlobalProperty pc_piix_compat_defaults[] = {
     { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
     { TYPE_VFIO_PCI_NOHOTPLUG, "use-legacy-x86-rom", "true" },
@@ -392,134 +386,6 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
     pcms->south_bridge = PCSouthBridgeOption_lookup.array[value];
 }
 
-#ifdef CONFIG_ISAPC
-static void pc_init_isa(MachineState *machine)
-{
-    PCMachineState *pcms = PC_MACHINE(machine);
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
-    X86MachineState *x86ms = X86_MACHINE(machine);
-    MemoryRegion *system_memory = get_system_memory();
-    MemoryRegion *system_io = get_system_io();
-    ISABus *isa_bus;
-    uint32_t irq;
-    GSIState *gsi_state;
-    MemoryRegion *ram_memory;
-    MemoryRegion *rom_memory = system_memory;
-    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
-    int i;
-
-    /*
-     * There is a small chance that someone unintentionally passes "-cpu max"
-     * for the isapc machine, which will provide a much more modern 32-bit
-     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
-     * been specified, choose the "best" 32-bit cpu possible which we consider
-     * be the pentium3 (deliberately choosing an Intel CPU given that the
-     * default 486 CPU for the isapc machine is also an Intel CPU).
-     */
-    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
-        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
-        warn_report("-cpu max is invalid for isapc machine, using pentium3");
-    }
-
-    /*
-     * Similarly if someone unintentionally passes "-cpu host" for the isapc
-     * machine then display a warning and also switch to the "best" 32-bit
-     * cpu possible which we consider to be the pentium3. This is because any
-     * host CPU will already be modern than this, but it also ensures any
-     * newer CPU flags/features are filtered out for older guests.
-     */
-    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("host"))) {
-        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
-        warn_report("-cpu host is invalid for isapc machine, using pentium3");
-    }
-
-    if (machine->ram_size > 3.5 * GiB) {
-        error_report("Too much memory for this machine: %" PRId64 " MiB, "
-                     "maximum 3584 MiB", machine->ram_size / MiB);
-        exit(1);
-    }
-
-    /*
-     * There is no RAM split for the isapc machine
-     */
-    if (xen_enabled()) {
-        xen_hvm_init_pc(pcms, &ram_memory);
-    } else {
-        ram_memory = machine->ram;
-
-        pcms->max_ram_below_4g = 3.5 * GiB;
-        x86ms->above_4g_mem_size = 0;
-        x86ms->below_4g_mem_size = machine->ram_size;
-    }
-
-    x86_cpus_init(x86ms, pcmc->default_cpu_version);
-
-    if (kvm_enabled()) {
-        kvmclock_create(pcmc->kvmclock_create_always);
-    }
-
-    /* allocate ram and load rom/bios */
-    if (!xen_enabled()) {
-        pc_memory_init(pcms, system_memory, rom_memory, 0);
-    } else {
-        assert(machine->ram_size == x86ms->below_4g_mem_size +
-                                    x86ms->above_4g_mem_size);
-
-        if (machine->kernel_filename != NULL) {
-            /* For xen HVM direct kernel boot, load linux here */
-            xen_load_linux(pcms);
-        }
-    }
-
-    gsi_state = pc_gsi_create(&x86ms->gsi, false);
-
-    isa_bus = isa_bus_new(NULL, system_memory, system_io,
-                          &error_abort);
-    isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
-
-    x86ms->rtc = isa_new(TYPE_MC146818_RTC);
-    qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
-    isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
-    irq = object_property_get_uint(OBJECT(x86ms->rtc), "irq",
-                                   &error_fatal);
-    isa_connect_gpio_out(ISA_DEVICE(x86ms->rtc), 0, irq);
-
-    i8257_dma_init(OBJECT(machine), isa_bus, 0);
-    pcms->hpet_enabled = false;
-
-    if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
-        pc_i8259_create(isa_bus, gsi_state->i8259_irq);
-    }
-
-    if (tcg_enabled()) {
-        x86_register_ferr_irq(x86ms->gsi[13]);
-    }
-
-    pc_vga_init(isa_bus, NULL);
-
-    /* init basic PC hardware */
-    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
-                         !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
-
-    pc_nic_init(pcmc, isa_bus, NULL);
-
-    ide_drive_get(hd, ARRAY_SIZE(hd));
-    for (i = 0; i < MAX_IDE_BUS; i++) {
-        ISADevice *dev;
-        char busname[] = "ide.0";
-        dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
-                            ide_irq[i],
-                            hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
-        /*
-         * The ide bus name is ide.0 for the first bus and ide.1 for the
-         * second one.
-         */
-        busname[4] = '0' + i;
-        pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
-    }
-}
-#endif
-
 #ifdef CONFIG_XEN
 static void pc_xen_hvm_init(MachineState *machine)
 {
@@ -887,44 +753,6 @@ static void pc_i440fx_machine_2_6_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(2, 6);
 
-#ifdef CONFIG_ISAPC
-static void isapc_machine_options(MachineClass *m)
-{
-    static const char * const valid_cpu_types[] = {
-        X86_CPU_TYPE_NAME("486"),
-        X86_CPU_TYPE_NAME("athlon"),
-        X86_CPU_TYPE_NAME("kvm32"),
-        X86_CPU_TYPE_NAME("pentium"),
-        X86_CPU_TYPE_NAME("pentium2"),
-        X86_CPU_TYPE_NAME("pentium3"),
-        X86_CPU_TYPE_NAME("qemu32"),
-        X86_CPU_TYPE_NAME("max"),
-        X86_CPU_TYPE_NAME("host"),
-        NULL
-    };
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    m->desc = "ISA-only PC";
-    m->max_cpus = 1;
-    m->option_rom_has_mr = true;
-    m->rom_file_has_mr = false;
-    pcmc->pci_enabled = false;
-    pcmc->has_acpi_build = false;
-    pcmc->smbios_defaults = false;
-    pcmc->gigabyte_align = false;
-    pcmc->smbios_legacy_mode = true;
-    pcmc->has_reserved_memory = false;
-    m->default_nic = "ne2k_isa";
-    m->default_cpu_type = X86_CPU_TYPE_NAME("486");
-    m->valid_cpu_types = valid_cpu_types;
-    m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
-    m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
-}
-
-DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
-                  isapc_machine_options);
-#endif
-
 #ifdef CONFIG_XEN
 static void xenfv_machine_4_2_options(MachineClass *m)
 {
-- 
2.43.0


