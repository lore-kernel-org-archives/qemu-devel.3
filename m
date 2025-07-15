Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC0DC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc1D-0000yS-R8; Tue, 15 Jul 2025 05:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc0o-0000Pu-Ef; Tue, 15 Jul 2025 05:31:48 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc0j-0005jI-W6; Tue, 15 Jul 2025 05:31:45 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F7IcNS005300;
 Tue, 15 Jul 2025 02:31:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Y7J9etYeBXPDINCCregNyZodTS+6dZKFeLPWPri4E
 cc=; b=NKvCa2DFNghAjP7hue9i6lh90tT5InIoE97R1kTcK77H9QL6ZLB8ePx5u
 sapjUWhTxm7Fh+1M1C4mrqk49MKo4hSXEHmFYpbIrfb9JMZhOMkRg729kGNDNKED
 mXH/wgZxH5zFPoNYi/AqlqWAEbPLQ7tbmwnTlwNrfPm2QeQjDoRlicoGUJEp5wzT
 a7tVITPrSeLM+eFmmkly+bk65Ss0iWeZPiffNkPXIRndteH1XNBRaHdnx3T66wQk
 8x09pUjUTbEXRvHV+r3m3JZS1k3AXzNWl2Z8nCGgbztF4JMhbVuWr1ZhMOx+RoV7
 DJeBNkn3N0dpJknqOPX06D46ipubg==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2112.outbound.protection.outlook.com [40.107.244.112])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47upsh5p11-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 02:31:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2d9XbIbVkHBC0gqYK5ORyj6bJzgYTiFWnNnQSZYxfFrtOC1e7fbFQ60YK/JU723MtffZKd3+Os14OBmAnhV/trh1nme2WUxh7CtoRYW0SToTC21XMme0d+fQzFMLSurbfTHxk7NX7m+bNn5ZrVVrcvMqXXwIyEX7yCerUBAOxmVa4000ritzV5ioM9sp59CmzXqJ0JDgyha6AetypHVsQ9gsfOWW1cqSkf15MeNc9dor8NscLmIf4BPbVAi/hLP9iaIoTTQXpsGnCXGmqtwow2hoQUL8Fk+JOlE8bqfjV6FNv4beImcfyKd0PW9MP39ROP0w77JmT9mMdJMkxB/Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7J9etYeBXPDINCCregNyZodTS+6dZKFeLPWPri4Ecc=;
 b=C8fTOOYqksPNSioboFtG8UzF+ni5HM/PUP/ZTTJARGZsuztZNJAk4zCAxaj1BOn5sQaG9R0Ymvssob5m4S4QffO3uSpgmS/um81s+tN+8PGZbhPyPSnDhP9lcMTyEhploXgiSntyDfe4+9QdLtGbcYD1pW2wmPqFwYS66Nfbs8rGkj3NHhdrCFnjRVGDP/Q4+rBXGEnFn5jUYzsk2MTSQVuxZk5f384j9P8fHA9yI3U76x2sKO9qtWUTWxfzt9BHMGKbk2gD3qnGedn91dt1W1Udt9QRkNaVQZK5JQlQ8cewKXrHpVhlYJXWILt/ZxAfENofDaPx6MI/Mt17Cem62g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7J9etYeBXPDINCCregNyZodTS+6dZKFeLPWPri4Ecc=;
 b=W2+7MpW9OBP7A3x9qVfoL13v8BiyOKco15HIhvN5JK1LkR36kZuCwJikZ5c1vjAVbHrKyeK1YfTyQ9xiDbtzKoZ0F+sZ3wKTUWuSaJST5KhmxLMLnQYjA7NhOhsM+ta787+YWxbhp0NToN9ExoSK/Fi+fBYjnUjkFdtXG3h//qBA+VqVF8IsEThe27niouSssL6VgNHnNMdb0SQpXvZ3RsVu/wSaKnFYlVslqknFwzACgg3sn21MY++OhCmErFuBCyx7D8YE9lHFgS0ieOqE5g0T0dV2wVCaqNw8bxSo6pYFtDVHBorq4REb8A7Wkq8SwHyqvfsKU3MiQvaAsjFq4A==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ2PR02MB9770.namprd02.prod.outlook.com (2603:10b6:a03:548::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 15 Jul
 2025 09:31:32 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:31:32 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 05/22] ppc/spapr_pci_vfio.c: use QOM casts where appropriate
Date: Tue, 15 Jul 2025 10:25:45 +0100
Message-ID: <20250715093110.107317-6-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715093110.107317-1-mark.caveayland@nutanix.com>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0005.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ2PR02MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eddc080-c2e5-47c3-0935-08ddc3826282
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4GER6VtvQkT/x8ccp9Rtxx+qWrlbsPldyvfpKBGF7Au+KeB+ruKpdwz6sSYJ?=
 =?us-ascii?Q?79eIuLLQYhgUlmcqpIIKS2pzZeS8YS2HltkTpBmOvF/UWD0z/NQ0OkFRtiXq?=
 =?us-ascii?Q?vOYR/8ZqR9Ls1VFVIOzRYwm+e6DBvLeEP6VWdfONbnqQ9i0PhQRmp8kK4aNb?=
 =?us-ascii?Q?n53wyJSNFNA3UqFyAeYihgPVlelINmNOieki+wYXHMeyTEjECwx0buK962X+?=
 =?us-ascii?Q?qMQSBUs6+HKMUozAqlylLneveiByfQxOhxVy8FpbKRURskJepcbQ6SgtdsPf?=
 =?us-ascii?Q?wu+wUOg6Fb3EWifVDfdhbGNG/sYUnrkYEl+7oTzolzq7MuIZpS/If02fL99z?=
 =?us-ascii?Q?/Qkey3Fs9B5Ucgo3VACgaC9SehWFi6cS3j7H16wupXjccwR9mOOioL1v5lMe?=
 =?us-ascii?Q?H6gs/AgeJzTvLlkLmQQAQTGUThP4kxl/R7nrbt5Q+WnCCP85yhmKrWrym+tg?=
 =?us-ascii?Q?iWxhRXn3GUordAM1xjJm0S9+arGuk8GET78oy0DLqTLHzb2+GBt22YbNRdUe?=
 =?us-ascii?Q?MIgh/aOu/9v2MXZB3LROUs/UHd0b6M4KLweg13cuI4xGzQhmIMBVCpMxu6hQ?=
 =?us-ascii?Q?42+HxNIusFQPS2uyWhH4a61hrTaNETZtBf9KzX81zqi8EpLBpghCN+UUEhDB?=
 =?us-ascii?Q?uK6lB1lOXGoqHW06swzm2yIfpHaUhOGDwa8vssU9ywpOiuSL11t98eWTMGqu?=
 =?us-ascii?Q?WYSLPloVySnGhH96Lc5DuG87JRJzGRSPnyqTixWi5LpMFzoIaxpP9x6Gc8cm?=
 =?us-ascii?Q?wdQH0rfubp+w+PYWTvQsiS5FdigdZzdvmUv9IoJDWrk+qDGHwHMf/J2Tx+4I?=
 =?us-ascii?Q?7H/Kaqbhgdkbw/G9FEf6DRBqK7aZlK2EnptE1iPnI/L7JpFIgnCp890z/iwa?=
 =?us-ascii?Q?O3CqrNc45Cf0YGYwSLaY/rVNR+oNcwFbSX5IbhjI52jfN6WOou26Rm2Idg28?=
 =?us-ascii?Q?5OxDBRKD2b0UQXS6FkTPH1Z8pNazo02pHUUZzkf2CceBC8Z1+i5w2p97UoC4?=
 =?us-ascii?Q?jgcSKpqqdfBqlvy7b/MsZBz1ArZRwi3WUcYcv7Kk0mVNasGVb2gZRqvc5PQG?=
 =?us-ascii?Q?appIpjigmL3+0C2GtFNj0nRBuK9fGFjNV5CTCEYb+kTtkurSrgEBTPpB6hS9?=
 =?us-ascii?Q?YVUeQ4ucirTvhgxV+KyhUrAmJGhscbnWPOC877tRBv6OsRDRZFZWnALn8HMM?=
 =?us-ascii?Q?BpPlaeDdz6uLEXAqkjB9/RgCokHcEqL/W/s98w3wSjsta1YHNFdKrPh06Skp?=
 =?us-ascii?Q?v5zRngCaz2P3UO49Udpx6RvN/8jsFhCoC2kIUTvmrr7llh9n7XNBV8vsMq10?=
 =?us-ascii?Q?T/+FxpPlMUMHyN9GUScWuQUFsa5EQnuN5d8TV16/jpd3aLr0qHntO1MHuWEh?=
 =?us-ascii?Q?PhI8Gh+j2X6CHORS4qlRflYCr1aSmiZYaF2GuhBMmYMjAFjxUcF7p6QQRKGa?=
 =?us-ascii?Q?UFlMDEQGF3SP8ZXHqwavlKm/6K7BQRg1esYGxBsGbxmiIlx2voVUtw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HdgNBaT0R8zVOomIp8u80+k1FC56gIcXRbmV9Wp8tERY1x9eMMXYZ8aiEPjG?=
 =?us-ascii?Q?FjhQ2u7C89LJFczfQa0bDaHth4D4DWH+DIQuNHYDmDIOnOzN2sHk3JFEj7t0?=
 =?us-ascii?Q?18EHYAJHcbL3yvg5dR67Hxo2RcvXZ4kOMXUpELqYnGV0wE0KKZ7k4TSl/wnC?=
 =?us-ascii?Q?zJePUiK/WLW3n6omZ0B/p8IYcfZrfhsEo5gh9pb1L2f8pEu3hPlPOJdcIvFX?=
 =?us-ascii?Q?rAg+iQS12vmZcBvwhFi9IvnZKLy5S/S14hq/ZZtcwxkv6Cei5Rtv49vktFcC?=
 =?us-ascii?Q?vp+SEd8h+C0pg7EYhMBhFllnFiWYvdeaSK2iRN9sTialsSqGKxz1je4r5MOI?=
 =?us-ascii?Q?YTZi5ejS+ZYuLt85bHNTQ287p4tRZdgtSfMHPbJe3rkSyTqZdS0/QhQwBgI4?=
 =?us-ascii?Q?GA5Z9bi6a1q3exsaHukfwNXpiRx7tCIljFdOhWL+0+ynKpPCJ3FyPykRl6vY?=
 =?us-ascii?Q?4kjYa/0TsT6XSojd73VkOPGLI4K2TUhHW6AoeOUpiinMxiO9ydXnkpAppbfA?=
 =?us-ascii?Q?Oz+/6HfZHBGKyyOPLl7Qf/W11URk73PBls+6FbZCtD/FunM+K4ZTUieZDyOX?=
 =?us-ascii?Q?oyqOxakInoG5xswbdDezCenSK+oi19WSWRBr0P42NKIls7g3d/xiAF8JWTyZ?=
 =?us-ascii?Q?kGUny/7WzDgIlO7oiedt7D3LDANGLbytKNIP75h5vYdVFfqPFew2IZxSTAzF?=
 =?us-ascii?Q?aXS3FV04egQVeFQCUU4e2BDxxMyojAuvaIintBOOOG8MTXBBvKhWUxhkZGLp?=
 =?us-ascii?Q?+7xTRLv+hNNUW8Z/j0vc0fG9x1y1ekJrUy0JrVOEudG05EMPg54oNVBrPOjN?=
 =?us-ascii?Q?6L20K50Td7qRvWbuIa3FEKytCSjEZ+zEVfkmBaz2HawrQHuDN9QOd8lcyxzG?=
 =?us-ascii?Q?BbmZ2zQutb3zMe+Gb7wG97lPoukenyg2E1GAFLx+sShVqeL960xraEMU7GMr?=
 =?us-ascii?Q?T1HuPV+oZLIma1X6kJO/kPoHj8Kl1wBJsM2UIo7Ixq5cSmAm395cyI0Qh2LZ?=
 =?us-ascii?Q?f55rA7kfRd3R6WD/hTdPumd56pKLIcKH/64e5iVZGo3p9GiNINzf0Om4BcDW?=
 =?us-ascii?Q?rFD8gcZTOCxUVFrtf3tsfurO1ajX59Idvf1nPV/gRciVMzyiFOixAjqa7Xxk?=
 =?us-ascii?Q?T/cVtrd5tfIoeTqj5XqRUFhDmwl/rdcy3ZjeAxfaMna+nCDAHON0e4XEOICI?=
 =?us-ascii?Q?26SCWq4fV4tYWAg/o10uXwOOONF/efW+mOLMGU9b6xFJud8hmFJKnWhpIqLH?=
 =?us-ascii?Q?VeQilfvo88nWzdoS/m/5IMAEVGtHUF1D+6ScvJcHTeQib4kRdN9HndSRGqxL?=
 =?us-ascii?Q?T4mmY+AV8GqzMMt4GHoQZASmm/ad13CBnEYSLPPG3CN5LQqBNlFTCNICzHep?=
 =?us-ascii?Q?lcxN5o0bZInesW0vwsaQ+5Yf91KRSYBOe4E6PYeIw8o9GcpnYYEizzKh2t63?=
 =?us-ascii?Q?+3MTfQW/Uole2uFkJ+ti3F8jtZpQONquJNQnUTjhfw2vTYfBMw50pke0AGZe?=
 =?us-ascii?Q?MHOoTiOr83GROFomGHmQFN6hZuyNTbUlRxqIOkK7ge73nBfbrVzSJyqjeAZ0?=
 =?us-ascii?Q?3KQ6jqMbs05peG+IDG9t0q4+InxNqlhzfkpcIMts54kmX9cH3d5omtD4fAIB?=
 =?us-ascii?Q?Pa0V8jeKJ22Mn126o8DrSJzeLtgcy4BD8UlRpEBNezsBaINsj+vWg/Ii6gSF?=
 =?us-ascii?Q?rSIzZA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eddc080-c2e5-47c3-0935-08ddc3826282
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:31:32.3250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1LumA6xN8CJsdJQGaQdEg19rZ6JuYtfI8ebHUa95UM8m9VvuBNDkvStXh8G7ALXgUz+ncJT8GA2IQOfeNss1lIysBTQKvTVXYAzpWrntob8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9770
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4NSBTYWx0ZWRfXyoMxSFGhrn/x
 1RRNe7x0WGGlWpb4Kx6ZK/Q19PgE99rBOf6SRWpxfx7tb9UfhfrDRHzRoNYfs5v4E8fexpVg2PP
 ArTpCzlNPQ8QsZ56Gdl3KoKaNbk7Oq5Emv+iRsKm9fLjW3p+TzRjy0VjgyK3Piw8LNXwpsjptaj
 jc6Rhpk8MkgRMK3Lqu0fqgM35gdd32rYU+ybkNUbiI4koFjjGvQSNC460QWcCcG8w6Fybmxfr+q
 69w0Fme+cbRfaA5H7rC8Fi6DTX8iS6qWKfsxB5npgcCjgEZpdskRwYoIOFMU1CMITnx4lj8B4RI
 TUKKoDWaYOOTMyHGsbM+MmM6R48g8U14ouqknIT447gSqLtsk/ecmLrTb8JwqEW9CyOpWZCvEDP
 lfqWZQAeqFPV+tKQbFHRzRDPkj5Om6Q9EY3S4knMr4MZR9rdoxiJk6TC7K/oWDL0gwqAS9Rs
X-Proofpoint-ORIG-GUID: LDG28vo77Dqf0MHQSeoPzH9jc_56dNW4
X-Proofpoint-GUID: LDG28vo77Dqf0MHQSeoPzH9jc_56dNW4
X-Authority-Analysis: v=2.4 cv=AoTu3P9P c=1 sm=1 tr=0 ts=68761ff6 cx=c_pps
 a=NAjrAmuI8YPp8sKDqomrzw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=7cpFXjLIhONz1FfLPCwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

Use a QOM cast to convert to VFIOContainer instead of accessing bcontainer
directly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/ppc/spapr_pci_vfio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index e318d0d912..7e1c71ef59 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -106,7 +106,7 @@ static VFIOContainer *vfio_eeh_as_container(AddressSpace *as)
 
 out:
     vfio_address_space_put(space);
-    return container_of(bcontainer, VFIOContainer, bcontainer);
+    return VFIO_IOMMU_LEGACY(bcontainer);
 }
 
 static bool vfio_eeh_as_ok(AddressSpace *as)
-- 
2.43.0


