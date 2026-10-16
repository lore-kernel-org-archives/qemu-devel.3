Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D31CCF2C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHip4-0002wr-1d; Fri, 16 Oct 2026 10:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHioj-0002dI-LN
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:21:54 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHioh-0006iD-Qh
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:21:53 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5mti3125736; Fri, 16 Oct 2026 07:21:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=4Zzg/I05mP5n7TY2uFK7TpWDkHes0ZRgUzLc2R50k
 64=; b=BsVABufdpTHxVBf1rZmKW1YXMoJ8A+fOCwwFZKC1fWCsVLEH5lFWo3zSr
 uVI9oD/pv1P1pTbN4azkjHP8wHFNi0PKUoTVr7ZyGw+LfxKhDHTYFdT9yKgCR0Qb
 smMRV5mdJ22n8p/MbjVvliuG9xJzeCdq3pXWaK2xnoc0CQGAYX5OIzzT7FDCn9NT
 G/vYYtuXVCPx29BjVAo8ULIU+OmOQO6eQJmRoVGZ1b8yI7aOWQ2htw4yk3Q9SR7S
 WqZ7WfxqPTS9ToDIX7cNN3+bldqPrB7grerlc0WwkvZAIESaTloVWznnanXAQzeh
 KA3/UYtgp7pc5RzRAmmn00NMSgzYg==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021092.outbound.protection.outlook.com [52.101.52.92])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4haysxu3ct-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 07:21:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGHkxAcfccQJNVMIybVsJ9qBmZUuevjH/rO/7X8kRukR3GCa8MFwxAVSHzpSJ/uFKE5RVGShZVP7Dih+bWq0eDE2l145VxyP5EyHQ6OSHC+bhGfrkqruaIvNX6MX3UfjhgOf64TiVx/qmEBt+AijS5WReDC3lClA/cr5qM9RnlsfzzaMTY5hmm5WcJwzZBtG0BLfAYfqmweiquRbWlomxjC4GHw+5l9U1Y2Pn+3akTbmROAKhmvebR+iJwLI6kMbM0xf0SL6r9Msosf8N5aW4HGkHZ5IGrnpzKH6a+NyFJoSTKyY0Y5Th9ehl4crOQ2km/OgbOX01CcHokmPJvAcyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Zzg/I05mP5n7TY2uFK7TpWDkHes0ZRgUzLc2R50k64=;
 b=ZeE+TUJukb9eiofgDg0MbFlhBF+MTGPPSn9uc6c/NrYoeQO5Vv+SrvQe7vYl5luoASWtrmkqs0aOHKe8rwe38MJVUnsodHOg9uuO0kgejjP+CCgkA5vyjM40VS2+7XH78UeYjYvWGeqDl4e675QXySXYqCyU1R/NWUqbkAQUp5P74BOspvnvRR/NvLmDy3uu3RbmbetT3XKabE8+ttx3dQk+egxFMpp0as5eQ7THQ4LuHkTE5SfHhdzqRts5qVTwNd6tFkj0XaNFOVLHOesrbBg6COOPX1tgKPfq4JC/FrkljBQx/6xsnFmTsNWtJSR6T41GC78ozqHYI+PWJRM5Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Zzg/I05mP5n7TY2uFK7TpWDkHes0ZRgUzLc2R50k64=;
 b=OzvHEovqkXOOdQeBpT8uql2t+FxpSZ/wJUB9b51bMzVPHEOENsxjFBSbxjb6fEdtw3YKbLJPL7WEYm9Qor5wAOURDK5+iGY51t7M1rGAtTm3ztvMyiuXktqLDVdEzeS8o3pt9+jwsaR05bmMkPoSMVwq3CxbsMdZGKaAgdO/pJj/DIdLNseft9k2H1dShNa+Bkea0gcKbxfczKLJXHBcZrxoi+9bRFH8pJPM27wW5JmaWgFDsCJ9WcPHX5SiFa3useom/m0X+MX9MJqfT40lDDyyVRe4hZXVs7OsRzbIut2SCeoX7BxDbSFOlw7cA2glf4jkFxXoNU7U5oAfEYGfTg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSVPR02MB11424.namprd02.prod.outlook.com (2603:10b6:8:352::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 14:21:43 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 14:21:43 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 16/27] i8259.c: convert to use DEFINE_TYPES() macro
Date: Fri, 16 Oct 2026 15:19:22 +0100
Message-ID: <20261016142031.1204281-17-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0090.namprd05.prod.outlook.com
 (2603:10b6:a03:332::35) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSVPR02MB11424:EE_
X-MS-Office365-Filtering-Correlation-Id: efe637f3-c11b-48f1-5e43-08df2b90cd7d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|10067099003|18002099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 0i/zb9aaJBmuKkcpNLFyiGWoOfUDVXPUrOFIbzYZt2sMlml1U6Mr/x+NpPAYzBz0LEMu37SKjv8eDVI0ET3NhsGHu6bOAuvG0blpIXnVJ89Zm4F8Fg8yyoFFkHv0mqQKjXXiW3haIY464eIK+asOdoBMlJbJLpoEVRVLth072c/Ck3gKQ9BQ3SGhTa3LI4r5hIxf2jPugC4JsksMwsddqsujiCHcljlDi5sK5Rh0mdldvs7YYbYfrEOnqKB16cvazd5raeWwuTSarpRKP2dBKKK7G2n5IZZIJp3XJ5685N1AM5/7OQg+HXk5zFxG3lRiVxTjy5Uy+5hR+oIbkpsFS9KNKavKXZ501iipjqfgbe441ql1Ol5KfkUo6gYIp0bG+UeTTdu6NmaZfyr4Gn4CiuL2sutksq8SBcGmmrNZHEUnlypJftUbnqJuntQ7k5kusP7Yh22cra75EhZPDyFyKrUITGlkej5FLg/T4cGPXyScZQx6caXViGnirs8nzBzf766F6M3eLGBsOBvnnpqoN+EVsO3N1iKYK8f01HJEOv9PBSSUTPK2ZFLxbfomsO59Z/wmgAQBbspIqjs8wwBt5GFX9lHH+YFH+MMzd/A9n0HDz3dCTx4rYgra2gsMLJ9BRdaDWXpKRSuXOie4Y1fcBUQNmq0OBw/OQlyYFLHHvNU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(10067099003)(18002099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Bg9Zq4TypHhRQYyEWrusTDlAeOEeQuIGIqUaNPPRAIvLThaJn194ByGBVmA?=
 =?us-ascii?Q?dy395nPr04eUuZUEh3tM2U9WXtcUTZ2yQ/E+svAakmQfUl/Z/Mlu/ykzP/99?=
 =?us-ascii?Q?XWv2GtE0DyaVboeuPdXsK3h5jAaj2MxzynfmowlkFEjDOKkgE7b0tKBEhL8M?=
 =?us-ascii?Q?5RvieXjl8WWjAbGgNiMnaWc6uSuUqQG7R/93gqS+wdrvGSCbvrhR3BwEJXOc?=
 =?us-ascii?Q?DnIMFiQaMgQASvGI5TSSEWswcgy+kzFXVM2W3h+X5e3aCCLG6gxLyDwWvMaq?=
 =?us-ascii?Q?bF9OugF+HU3UyVQk9zhVANnSWZfxdK5XemUJ3EkDRmfvwehJ46rs6LTfkMiG?=
 =?us-ascii?Q?cv7B/D3vy0cUsU/hbnvm3nnJftUMpkMP08r0NGQTqQTWje0/vSpbMenYDhP2?=
 =?us-ascii?Q?Nn1/tA4zAdyPPg2/xP9WTIRZrGItvulk+TuhZQOecqeKZhAP4LR2hZ0/Pw9d?=
 =?us-ascii?Q?YWYDkc9fooKYlvT62pAceas4e5Rz9gl0FSUzlsr/G22zMXqg1Z8rGfO60CXV?=
 =?us-ascii?Q?/c/D5BAicsc+96CEBbJffBO8IOw51/4vczW3t2UM8E757130/R8IsW1pkuiT?=
 =?us-ascii?Q?sFczHcG70j+jZGMVSTmMJge/qYaC9L/9fDIPxGcMRMqbttaFKHAEuK69FPOL?=
 =?us-ascii?Q?Dc/muYcT0Yj5a9qrh0bLlZYOwEL/xbLsCg44ZqHXrNsE6GcQFjq3gjl824tL?=
 =?us-ascii?Q?kH3ujyHwWnRQSxyyPt4hBS7tObc80IQ3l9iFRRsBBFyKeJVcGeMO97G8ieeH?=
 =?us-ascii?Q?2eoo8jNGw5j2PrD8utSP68uhvZJ9A4t6Ae2EaDO5/R5EXlcQx0AoL6x0B0Hv?=
 =?us-ascii?Q?z9dsOue82dXCT2mhSGw47UACMxrQPXSbpTOLlTLMPavbsoyBGPIzU8mNKTeq?=
 =?us-ascii?Q?bbQqD3G+Pbl4Z8oYdaROAoRThaX62VD88EpuAbR6nYvVWQrUsjF4rY6JAB2l?=
 =?us-ascii?Q?/LumFVPgRIpv4ucxzSDRnBs46Fa22Uhx4ZyHe0uU49S24YaAcR7LQfQrgzyy?=
 =?us-ascii?Q?zh0G5YrSAsoWoe816rsA46gUXKM9fteaKe5nC3t58eWExrr5tiqXbR+NCJm9?=
 =?us-ascii?Q?H8CdhmQhdWKTq1wtXp8dVk/DD7hwRkppHfcWf7tvMgb2fX5TTxnh/zKWuvsB?=
 =?us-ascii?Q?cBKpjuMyWNssGeZOVrK3N/gswCs97DrA0IaAOyYqrR5sr/JGAoNxj8mkKDqe?=
 =?us-ascii?Q?y15AVGn4G6J4e6Ngp0Cn3LdyBpUwmr96sTWtgJxUmOy4xOyFpMNMHAS8PL86?=
 =?us-ascii?Q?sQ4AvyVKNZjmxNGF0ComDcjgGHehmBwABp/Cd4myUJlLoXdtG+fZ7D8oGd+g?=
 =?us-ascii?Q?guDEodb5qW5lNVJ3Fd6LS5SWL2L8kfAUFGR1TS4FEhyo6sX7R0Fz5R1Qx8Ux?=
 =?us-ascii?Q?rbxWCop7GfWrKBAxVbNyJdDj6UlL5dZN2MT1mZ+0G0s+9AXQlS0XgeMgok0E?=
 =?us-ascii?Q?AsRm4tPBj7+nGkT3W9hKxuZK5ML4MdNQt8d2zo0y3/+ev05cpm7fv8KGJisi?=
 =?us-ascii?Q?MlA2KLdt2S2ChHWzwAB1L7SZTUnqCC3z6/dBebXwEuhjcZ61G1pZsF+txrLX?=
 =?us-ascii?Q?8qegUKh+jOTRNIQf3+Lk5kUjIMxYuqYY1LZkMBVEenDsAwEdkK8YYYG+km0o?=
 =?us-ascii?Q?AYw7UPQUeOpaR9FHvGNy7RMqnS4jfQehJjoXDUiMXgDof86B6q8Vx4zCpbpH?=
 =?us-ascii?Q?DPUxdWfPxohqwlO2bv3afRZH9Ok7SNqVzQKZqae9Md/g4wboDMHXVYhT4ks7?=
 =?us-ascii?Q?HSf6JKaktfCkzW30AgPsdRKSGOCpQgg=3D?=
X-Exchange-RoutingPolicyChecked: 5KpNv3oTcIuLKBsuiGXD64zFMHPSc+b6zExmRDe9I2kDiI8URLo0T+RagjBVWkO2D1FwoszGBac+oy0u+TwEVnSh+ojPHFFnBMynguVkzceDEV00kDlVM2O2uA0Wop2gpNSpw5WEjQ5FgIAt+wgyKMs63cySH+pqEB6oLGPC//29g9EgOONkt/zjz8ecWj0K7d37XIxIhx71+0OgWThR+eVXZdnW4GbwJoRrRZsUQTpwhOVhfAqi2y3Sswi3Wl4CKuWhyLAlc5IAX5CtEY6vW4GABSDx1bMD4U/jlAz42yNgdHXXaiP7B8MmhjzjboiY5NbWpsE9FjDQ31/Vm++u4A==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe637f3-c11b-48f1-5e43-08df2b90cd7d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:21:43.3944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F0VcqJqdL0OWWtDDq8d6tc2fKoOghENF7Vs+hszPvquvKWQpaqyGX7AtoPjPDasjWFlVPGEijAkZk6QtRON2a6tqUeWrzb4qhn+O4GQwEDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB11424
X-Proofpoint-GUID: 33B_WShAIV_5Zv9_CbVnyWwaMnhRYB2e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX+zZ8o0q5uZ/8
 82xBdkohUZVRrGmj1ob0L5VTNpzB90P5ylh6U2G/pUjEv9OH+EQxvdibvpT+8mAdnbOP1SM+QKl
 +FZIb4abPPEVXYuGJyDLtOltu90pEvx/6JI3W0o11aY7vNVBWyZp6Tpwkz0mDTkwwLwRugAX38r
 kxSVXua9wc2ZyxFErSf7g3PjUqJGFMRxcB4edKmXNqy0I4p04DyL+aeAqBK+xAU5e4k1ewzgsGQ
 RsT9EqYmV/YHSXibedNFZtqzdnKevn1iC+64r2t2pcAT7YPunmB+Mx9vxI4FjF1aS9S/jot1wlt
 YgRkN6lGE1fXjaP6WtF1MBbSvRUZH26Y3wDSuiY0RctbiRXUKWGR2A92KKLEar2s/AiR6wkVM8d
 zSpPUCclio/jYzdM6pQBLdGtPrAo/L1QVjPP4wr2QxgukwYWnRZLbwkELfSW93xKw2yWZ0dVB27
 8H/f8TWnnnljdM8Y3Ig==
X-Proofpoint-ORIG-GUID: 33B_WShAIV_5Zv9_CbVnyWwaMnhRYB2e
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX5hjKLYPA5mDq
 16OwMFVQYRyVB1mLtzBl9b7Xe7JM3qykKEcPs43eCkfbM2IUYMBAK49Q+dszP5jAcwkD1SBCY70
 jkra3oZefUTtTQCRmBWZPShc+FgMBnU=
X-Authority-Analysis: v=2.4 cv=C/x8WgP+ c=1 sm=1 tr=0 ts=6ad232f9 cx=c_pps
 a=LITHeb8NCZqLQJh3dVn19Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=lKrOaJ4ZLGcPJhkerdAA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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
 hw/intc/i8259.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 4b34e5a649..e5fa0f2e5e 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -447,17 +447,14 @@ static void i8259_class_init(ObjectClass *klass, const void *data)
     device_class_set_legacy_reset(dc, i8259_reset);
 }
 
-static const TypeInfo i8259_info = {
-    .name       = TYPE_I8259,
-    .instance_size = sizeof(I8259State),
-    .parent     = TYPE_I8259_COMMON,
-    .class_init = i8259_class_init,
-    .class_size = sizeof(I8259Class),
+static const TypeInfo i8259_type_infos[] = {
+    {
+        .name       = TYPE_I8259,
+        .instance_size = sizeof(I8259State),
+        .parent     = TYPE_I8259_COMMON,
+        .class_init = i8259_class_init,
+        .class_size = sizeof(I8259Class),
+    },
 };
 
-static void i8259_register_types(void)
-{
-    type_register_static(&i8259_info);
-}
-
-type_init(i8259_register_types)
+DEFINE_TYPES(i8259_type_infos)
-- 
2.43.0


