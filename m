Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8249CC71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 11:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRqyq-0001KA-JI; Wed, 18 Jun 2025 07:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uRqyo-0001Ja-Nq
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:29:22 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uRqym-0002Z3-Du
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:29:22 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HNt88q012156;
 Wed, 18 Jun 2025 04:29:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=sUhS4BwRsQGCCetPr0N7vU6RlEldFxH529U2kEOpb
 +M=; b=24AHSx+6KiS7qeLDQ5gvogyJsIe8ShUi2rdd7fOPCeFi1K4UvYB0APLqn
 K4jYSBSk5qNnPqbtMZjgJKV6pGXvfUOSXdjjsk3jhjn2F6Q+VcLXPzRVa4OJwcn9
 CYVyVYjd6OoK4gYgQEzU8X35XUEFlwc3ypeTA4vZa7/2xaWm5zG0ndSfUhQ4IS4a
 pqysLcJ3tpLCQcMQ3d4PRpW7JkfYAOc1KPHasAq+kKvw+XwmTR6xCEeGrS1GkrI6
 zrm3OKzAnJNCxYB+hMof41fu7hXmuB3lA+ve3pV5YG+XXf/Ti018tcsJYGQlorzs
 AXaaU115AnPQN4L1qQ03Z2AZ2aP/A==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2134.outbound.protection.outlook.com [40.107.94.134])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4796mbgp6v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Jun 2025 04:29:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBWqgyoIS+nf9IBYmSNz1LtCYkmYtNAuRvltmzMnZD8Ghy+KbK1OmfUy8Nx7a0aVbLJ4CfkBpbd62x4i5oT2PER5WcJKQACkqbWNsPK5EJPqrrCJAPbuJsorvD728aWzIcwDdcxv6hJJSTEzxWLL+pz8QY2c1jmNLS2yyZyZewgQzYgDKEp+LuWA2DGRkJM8YVGlZVsvUD5RXRlnqyz+gnZfP+g7OKNYfU9Psez8XWD5ZLwD9iPIaLiaZCRAHlM0fSlbWdd7SG2DKqoDk0lXhjuem5ld6byAKRlq26vGKscqQqc04Hc3cEor+ajxtEwQgRWoGCSACkwE4ruE3ZCaOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUhS4BwRsQGCCetPr0N7vU6RlEldFxH529U2kEOpb+M=;
 b=QXix6NDzdVy6Q3ntjpahw/sVDG7NM0bSlbvNQ1TLSGG1MRjH4SpUIgh24TMrtOmXrIpO69uA8J6q0VIdNPxgVL8Fkq2Npao5RgulcwPoJ+tTAHMOSy1IwcZP+WT7QLPhXtv5ic3hYIxy/rPpIPa/Ff9ZjAxaOWBwN307p1DK2N1+R3Qv7GKxs5Qd7kfN8cu4iYsilPDFTRkUtY/4z3E46Gha1MHKWgXyNc3eRJsiLW6Z1JiIhjKmh5O6Zj/ZJvXVGmFh5bM2lOBCT/ekPJi7FzKNuHzlJCxXkBzHeZvIoLZWEotfpra96JD9KDS/6OcEvVFRFhv6dFbKcSaH/Kxtxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUhS4BwRsQGCCetPr0N7vU6RlEldFxH529U2kEOpb+M=;
 b=VpRLVTrKhY5DZbXLOoMZ019TlrQF/eGBZ33poMwkLN1H0trDgNRowfcjD49JUupiQLuKi5cL1AY0+5j75GHu9LqCuVDmF2w64bUbBz+/Iole5urL3/Ig5FCT0JB94GajmbaEGJtzfXQNFBKRwyjXsGM5KcA4OuuHa+i3muFv6P6U/ViMtw5a4/R8wLIQvA97yWpPdzHvHRWGSqyU25+i1FN7DI5lRv2Hg4HXTFyFFsen0TbN5YPBnWvxRPGmyKVU/78Tch0YUE2XLYh4fpWvK9fOa760SmlpARnPk2QB0HjGH0Lh0UtXy++ZLVYro8D0m27L3XCLhAj3om9Nwb2oew==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7295.namprd02.prod.outlook.com (2603:10b6:a03:292::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 18 Jun
 2025 11:29:16 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 11:29:16 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 12/12] hw/i386: move isapc machine to separate isapc.c file
Date: Wed, 18 Jun 2025 12:27:17 +0100
Message-ID: <20250618112828.235087-13-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618112828.235087-1-mark.caveayland@nutanix.com>
References: <20250618112828.235087-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0074.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 399c9ab9-896e-4445-d6e7-08ddae5b5bbf
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SPQEGmEWqj3vwwuWbB9DQHDTHMICTQkfI/e7gAvk99vEk1THEmvqehHTwoKl?=
 =?us-ascii?Q?0DhyL6mPwqlKwcvbXgiw+zq+FbANDHfnMyRdozYuBulwWi5ir+VjU9PLDCJi?=
 =?us-ascii?Q?BOHuUtMKQNuj5biJelUI09iFrEAmaOLtU2nMk0HmsOlfn8jJ19CsMY5z8eRp?=
 =?us-ascii?Q?560o4nDTTHwe0JlebbzK1n6UIVvKXw9O9YAKYQNQwUepBFQojzNpoz6EIutR?=
 =?us-ascii?Q?W2aABKSPoC3jhqRCTlFaJO21v/ffRYQOCsOXPp/EeYcfI4q6akQJNG18RqTL?=
 =?us-ascii?Q?sOPkVaAyZ8Wt9OCt2C6gP9khdqV0Ge3tLzjctrw8JcblMeDkET7bCf/sxTdL?=
 =?us-ascii?Q?7DmwFZdhQqSjap36F518z2/jnAzj/nFuQ7MwMbf2HegUBtO2ePNBPPSRMBHl?=
 =?us-ascii?Q?mHGLNFkFKQyR77s9woRLQ5oViwFRiHxdZNdEOEofeYbKgn9xn3cblQ5EY8Kf?=
 =?us-ascii?Q?5rMr/X+eAP0U/bN77lGW6Qlz3vVAlMPBkKtSxHl38T4Lc5zvOi9sh8YOZdF3?=
 =?us-ascii?Q?UER/72wmpxxhFvb4rqu9J+B0u56Q9oWEaE8ltquZlXVa86xflGX60wRtBBVz?=
 =?us-ascii?Q?gaqD1WyNLY6iPNMQYrfRRTlGyxDkDlV0SZ7qa0rq772HLrHGC4Rg6AqXyR9e?=
 =?us-ascii?Q?aJTSb4N+34CQ91lIhGmwaddl5nS3x0ow0hBtqbkJbLM5AJNJZHMKCgNbG2aL?=
 =?us-ascii?Q?zi0oPkVDNclJZq1SyeMf/WYs4gLBVLVgjd7Sam6pYzL8XS1lVP5hhJ+InP5h?=
 =?us-ascii?Q?B8UCC3Onc9sLm+Sgjyp0dNBDnyMKuLc3d110HwIh1PFNWTIM+nTyVQYWofBH?=
 =?us-ascii?Q?oJFk4ll+ppshoud4pyTG4N1rjYW3oGvjg32OMFiTiyMQXwrwASbQP+uxu32W?=
 =?us-ascii?Q?mH8Pe4ogZKIi8EuXpOmZxOv6ZzIFSjdOmLRKscHzPPe5MX/FNPAqKntSCYwp?=
 =?us-ascii?Q?tjf3M+bO3L+Dl4QOiuq3PIWZ8MJ3WUKX8l/CAsnjWQ44foitqDuBW2YTm17i?=
 =?us-ascii?Q?UAey3vxRTYEtZpyvURLu4Dy1wTJCl6gxeVS3wIZ8A/XPS04wp9xKPt5HenLy?=
 =?us-ascii?Q?bryEAp8XYzKHRKlGv39Oj1x6E7hZ0t4GqCSTL1me/2IzbbOI85A4ql96D6y9?=
 =?us-ascii?Q?bq7k1kKTrHZdYuOFkQK/oalzi0TizRfrjXyMgbmz3zWIvkNUO7NOb5Fe0NT6?=
 =?us-ascii?Q?/FHbAPjL03LIj3/Qwv1dUFfDhuRgrBdgXZl6ROdi7ZiNMM0udqa2qGsAaWM3?=
 =?us-ascii?Q?BufUfLLN3aOTu6mpb3WaOQ2+nxDF2D7wpN6Tg/0XPZBKvEf5imU/hBInsiCN?=
 =?us-ascii?Q?ZqlMj68Z/NBnwV0INJimDXPZ3tUJJ5BWBfxEMGkegtoC2uwpzy5g+YkNwfLM?=
 =?us-ascii?Q?XzBjaVwZyrlHOKKoE+hxmOW+PtazcK1SCsOJZDe5WyREGfgm89b7yGEjSwpB?=
 =?us-ascii?Q?SKrKWUMjuw4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HWE19n/eBtorI27fo/3noN+ETXR1BM85ne5Yo6Uoc/yMZ9bdu4bjy6KZuW/R?=
 =?us-ascii?Q?jaIFzTGAVMuSNggnLHCF2s+5mOQ/EEvb6ii/zbx/Hq5pHmSBlcav7d5H5OJg?=
 =?us-ascii?Q?0RQ123UnmEIrZmhs0YaoZVazw8FejGMGMwsL2vuKwxxVrUaK/AGfA3TuARr0?=
 =?us-ascii?Q?0BEPSgMkkbL8BnA+tbC0cJ0vFTUZ1RbpMPzRU8s1DH9K3qc7eCTV6T7gcW/A?=
 =?us-ascii?Q?hfqRzShH/Lm1yWMFFnSsEeOEVW388iaMY/8BM47Le8eb7PlMp1NN0E0d8/hs?=
 =?us-ascii?Q?cndDSRplhgd6mJNw5CWJ8jWmX1da6t4d0MXOW1ZQ6J+YRz/td9+GcckRs42X?=
 =?us-ascii?Q?7KsIGYbgzJcRHHgrhXIOOkGsPfu6vMtIBVmeq7Wyb6nze7IoIDtBWuD3ld3c?=
 =?us-ascii?Q?KSgqHvh6R34kfRcFtE0m4LW+5yDcisKc0sdDYNxL8gVWSDpxm6++Vy+5D7Mp?=
 =?us-ascii?Q?/OUubFfKYQldlsIbkZq+xVSLEjLsYypKpjoCLkgTR0LDVIkwA7vMaxr5jDhh?=
 =?us-ascii?Q?XlC9cbD7YFcgEA1KiAdsuN1G0Y7YcAvC9ii3EKTxDIedjepiD/ORnHfUImOx?=
 =?us-ascii?Q?KtdFhIfKi9P1ac7BnZGZ0s3q2BODTf4mhsmy7HmRXmy0SuC82KfgS7Ma4PfY?=
 =?us-ascii?Q?sYcEOzDMR0fC46FADZnu6fYqGIfcytzElVx5+nkn438in6TYQi/mIOrJERNK?=
 =?us-ascii?Q?Tk5K/xG59l6QVfGtD9ToRc8B7r2qxwIZ2U90RwbSUYEElkIRTRWTMrdQOXyz?=
 =?us-ascii?Q?tHQrs9pzkbcY8JAjpJtRRcBu5SmSLNpAGJ+QEWVJIgijA+6LmPFsUeLSHx/5?=
 =?us-ascii?Q?HRtWHn2aupu6lBDSiOGfenOrtw3BedmXVkoInysvtf9ZFlMUDqoitvwMHVYE?=
 =?us-ascii?Q?GNBcmrYjsgsa0lP0miFBZ0QCmT3vS0YkbDWfHtzTI+vmUEfx+k172eji+ESI?=
 =?us-ascii?Q?kEH51TyjhaxE5a/0id1zEGIimRv3SRXM9isS9VXxplebVRbFMDfkS0ctdY1g?=
 =?us-ascii?Q?x1cBkO1Gm9oE2HluPATpc9JVE5s4kMVjUIgJ8dZhy6Jcpy4e9KMf3pOfHpSH?=
 =?us-ascii?Q?pxfW7NkykU3MH59DT8lCyYL+Yr6/S0fmyWIuzkF6IaRPF2E0oGrax79gJA66?=
 =?us-ascii?Q?PruV1LBZEQsQqXG3LckWNwR2dBuW0vvlQMQ+P4lJ25mL718+UeKNrw5j6XPI?=
 =?us-ascii?Q?btcqN7m/SxgNY3Q0Wjuf7hD3SeL9bx0LipuK1UtlPbjiVMgF1U6dBEqeXv1V?=
 =?us-ascii?Q?lVDv1TKftAkVyQRHBNVqmGxQtyFfOkWUZBB+hJaw1nW500F6cE5MiUXjCWIV?=
 =?us-ascii?Q?93F3elAGx7Pbv6/QPBnmtouSfOUqE9E/EebCDEuOGtB5l3AsoOh53/bzCIGq?=
 =?us-ascii?Q?2ObLf/FjNBtosUKbmw1XRHRidAV6P3obKHpQR2J9BHIpLHqU77vVVWEXMix2?=
 =?us-ascii?Q?MmUdDI4iNIiqAt3G+JYO06cixTMdCqxlBW9BxuHnFNrVjVKUVjjTgofe1Otf?=
 =?us-ascii?Q?TiktA/gaJftPU7SpaFJiidNs1bDmstZiM15+YbFQKybX5ocH1l6dzIYVxnwZ?=
 =?us-ascii?Q?ro4nZKvoD+p3SEs0DWekItgDPviEm9S6cPnzszTtFLiAOPp15wFneayy29zW?=
 =?us-ascii?Q?XJwgQSrgGaE6zR05xRVVEdfatf8QHVkWWV6Sq60VZzzBG4ekFIEKmKhUb63u?=
 =?us-ascii?Q?Y/v7nw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 399c9ab9-896e-4445-d6e7-08ddae5b5bbf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 11:29:16.1929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2uuNRwwpWm1wR5oislHxmiCCPVlrzzTLBBtxNW7Wo6kD2j7RNT4qisHFCGLt/5czw+KSjoN7ya50K7BX0IZ54pm9L8YUIv+Qwz6MRucgRpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7295
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA5NyBTYWx0ZWRfX+xQAirzlgWy7
 xctM5oMmxZ4pafaEDsk5ZKRiCO7SnqLRdFNXw26q42NCKSrrv2J2U+TwPIIiVsYDCC8EE0vvuWJ
 2D2b+9G31GQfYQEO+7G6cn/YTRBcbAjgD/EBivqB4JuP3A+mS67rIkTfoE0uQBMMOZ2rtuwm0uE
 lb89tzkDOKdDRvx7oyR7Ra/zx4HSIIrdSZ8pUUdr+CbRN8fxIyTF35RShbhaCybZMq/39iS/jnJ
 hBeN8dQDy5Mq4R+/MYudC8QWA45n0/3FntaZsXuLLY/Rsh+wRVdN4RR1lG2iYOwL8wpYCiVmok2
 G9VZK8lUG/XaAkS3DEsdWYins71gAmBKYEAduKuGRjfSy7oe2Is8SvFHdA1/3G61Vz0AXmD/tsv
 ngv9hdcCZmMDieML89UXETIRxLUuBT7tWKBe4hU+XdJFo9pZb0g5ZqYKPikFla1lkkOvYPxj
X-Proofpoint-GUID: 94mZcSnFujs0jjggavmLcmNgyS8lePAe
X-Proofpoint-ORIG-GUID: 94mZcSnFujs0jjggavmLcmNgyS8lePAe
X-Authority-Analysis: v=2.4 cv=cJXgskeN c=1 sm=1 tr=0 ts=6852a30e cx=c_pps
 a=PAifPqZgaDtQ0C0O0TEnEw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=PTNn1_KP_szlgaPjY5cA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_04,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
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
separate isapc.c file. This enables us to finally fix the dependency of ISAPC on
I440FX in hw/i386/Kconfig.

Note that as part of the move to a separate file we can see that the licence text
is a verbatim copy of the MIT licence. The text originates from commit 1df912cf9e
("VL license of the day is MIT/BSD") so we can be sure that this was the original
intent. As a consequence we can update the file header to use a SPDX tag as per
the current project contribution guidelines.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/Kconfig     |   3 -
 hw/i386/isapc.c     | 145 ++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/meson.build |   1 +
 hw/i386/pc_piix.c   | 117 -----------------------------------
 4 files changed, 146 insertions(+), 120 deletions(-)
 create mode 100644 hw/i386/isapc.c

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index eb65bda6e0..a7c746fe9e 100644
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
index 0000000000..74ffd19307
--- /dev/null
+++ b/hw/i386/isapc.c
@@ -0,0 +1,145 @@
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
+#include "hw/char/parallel-isa.h"
+#include "hw/dma/i8257.h"
+#include "hw/loader.h"
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
+    GSIState *gsi_state;
+    MemoryRegion *ram_memory;
+    MemoryRegion *rom_memory = system_memory;
+    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
+    uint32_t irq;
+    int i;
+
+    /*
+     * There is no RAM split for the isapc machine
+     */
+    if (xen_enabled()) {
+        xen_hvm_init_pc(pcms, &ram_memory);
+    } else {
+        ram_memory = machine->ram;
+
+        pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
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
+                            &error_abort);
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
+                           ide_irq[i],
+                           hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
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
index f9d7967dee..8cfb228f13 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -415,99 +415,6 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
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
-    GSIState *gsi_state;
-    MemoryRegion *ram_memory;
-    MemoryRegion *rom_memory = system_memory;
-    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
-    int i;
-
-    /*
-     * There is no RAM split for the isapc machine
-     */
-    if (xen_enabled()) {
-        xen_hvm_init_pc(pcms, &ram_memory);
-    } else {
-        ram_memory = machine->ram;
-
-        pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
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
-                            &error_abort);
-    isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
-
-    x86ms->rtc = isa_new(TYPE_MC146818_RTC);
-    qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
-    isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
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
 static void pc_xen_hvm_init_pci(MachineState *machine)
 {
@@ -869,30 +776,6 @@ static void pc_i440fx_machine_2_6_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(2, 6);
 
-#ifdef CONFIG_ISAPC
-static void isapc_machine_options(MachineClass *m)
-{
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
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


