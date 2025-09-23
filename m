Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296F0CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 13:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13Te-0006RB-47; Tue, 23 Sep 2025 09:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13TN-0006Jm-Ts; Tue, 23 Sep 2025 09:54:26 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13TM-0003x6-4F; Tue, 23 Sep 2025 09:54:25 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58N9Yjpk2985871; Tue, 23 Sep 2025 06:54:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=9FP9JrVRDuLpFHNZFHzrkMF2TPHz+UqOB7rzj+s+M
 Co=; b=Qs6RpCHoProej/YiDbzOI2sQ0uZfpbhoiQopm7MNVi0I/iLwHdBFua4aM
 Gx1a1EAqW/lSRxpg7LPhk8bxP0URFgyg+fFFNBucBHNKJQuTyoFuCLizgDJy7pOP
 jC1YmZeBHJ0XOMACf/rWtLbT2HXeZdx3FgjnO7NWI5CrmBhPtPsde/mzpREKjnBM
 pdP9GTo7RLLweUVRFUwLbCrVaR89oOHv1THqo1yRb/TCB9Oe6gef/6krWXtFtP3/
 Z827D+6L1GdIe/jy7SrDhHNCJlQLXd6wVPqB2ocneXcPXeihl9SWf30Dy/XE7+eP
 V5Yh4I5dqm7NOtgo26mMzjzfVtQtw==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020114.outbound.protection.outlook.com [52.101.46.114])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49b6tju015-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 06:54:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWuw75CoIDewuthLN1OyzvAuUmrx2nWGB99a/eXeArQA1TJOhcLjp7tgwPAJANBqKHIgNa+WzZhECwOmw99pfm3gTb7Y3g5tzcr23iLxV8avIVb84hP5IFoCqHv1u/r81mg+44h+3xUsK9OGpADW7HZ1V3iSMctXFUOpduOerLf+wWt9GY+x9gzSj2Beq0hmwLxpSfQKk40HsaiZ1HqaGAS2B1FUJwzYGGqNb2BauFdTza5TIvb8Rm9aoZEJqQBEvNQB2PMHN5adpcPWWneCodSj7E0NkLQ4FT5QU9QvsR0aC+vqxIEMapWcwlq+xhkRAMCcUSotLfYLc+pLiQDrQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FP9JrVRDuLpFHNZFHzrkMF2TPHz+UqOB7rzj+s+MCo=;
 b=eid6H60Z95+bfwDqopv9DtSdiu0/Xb7kFAWBN4ROUFov6WSTsC8qT5q/WXHVGaWSCNMDL7PilnamNWdxzNWHSDbU7QmnjgjyhBofGY9LhzOb5TD6dbe6CigBrYzEENOGR1Q0TlXMxy/GGAnlZIUemMUAcf8yDvhHX8wXt2pEl+wC4iA7p98HAwK5asxXxl2sYn+yOb4+QbonMybdIgTXIH+Ms8cqJtingEUreFGSNT8WLRlP/FF+YrbCGCWcEt8MCId9MUuXt82mvkYCM7ZiBlBTsZ8q3dBc1gMbye1XQgXTjMe0ZIZG/ca5QammJuIyIVXBYIfshJe3CgBg2MQAGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FP9JrVRDuLpFHNZFHzrkMF2TPHz+UqOB7rzj+s+MCo=;
 b=J4X1fCk8D1Xm0eJ71G6fRiWhy6JzLnwUIXMAy3Uj5P0Gqi+RInXmuNToyZ+uSlm6hPZf0rgXu1zRda0VMhRy/WuiDXhfcecNYGdDiK71/QF/v27bEuev+T8Mf2RvIuVM1X1EuNpbwJLBN0QWqWpVDX5DwifmTvCX/jQuQ2kKKgOvED7F1hHYSyg/wt7HZ+cdj45OatnnfXNT8bDGRGXVXb1l0VQa0ep4yOK6V2d19+01q+hAKIEuOju/HpeJXzBT53ohZXSXi23Tv2n3ZUI4tApZjVuLOsVtq6ZwGe4WekAB1CMVqwAk0AQ+lAoam8dT3OlyscCG33bGOsVUUbgTbQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB7037.namprd02.prod.outlook.com (2603:10b6:208:206::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 13:54:15 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 13:54:15 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 05/27] hw/vfio/container.c: rename file to container-legacy.c
Date: Tue, 23 Sep 2025 14:53:11 +0100
Message-ID: <20250923135352.1157250-6-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0023.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::28) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 143dba11-f01b-4f75-a55d-08ddfaa8af20
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|10070799003|366016|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FrkLwr7xa8ufGuhmmWRJ+AWuygKiBn8fcPJm0vtG0XL1LoUl/ivXL+rX86gn?=
 =?us-ascii?Q?PAWAYU69VYLbUEmTh69I2QmfWH5gTCDCLEjGsVtJPHSvijQM59A3M/OaZi29?=
 =?us-ascii?Q?2GZ2qZo6DYq66MK/kCHrVxBQ7wAVrmClDOF/xeGvYNH/e71R/TT5MlHRWzDF?=
 =?us-ascii?Q?Q9s5WXOHXwH9N9VMl9lRcThc6wXNhvGnXTPotzVnT52FGvJrYBW0b3dYWCqZ?=
 =?us-ascii?Q?/an6HMAIhSDaoGjyvsyFniCQcVEL5QxMlbqPNqYWPvE6a7H1B96IX2JacVGA?=
 =?us-ascii?Q?I5oDEq48z0ib7ZTKZ7b76Sj6lUXAFFgS9a9ZUixe26Z8uqz31Ve3FJdB1Ilk?=
 =?us-ascii?Q?dfPdvjw/jaTmcdDosuUwNp4aECE9o14VGIn6tO1wjipK0AdL0YZXrPClKsJJ?=
 =?us-ascii?Q?oW3WjE2DW98Fu7dVCUAvgWSxw4lDz9CGLW4fDw8ZuqI5Hu0Ct876ABq95kdD?=
 =?us-ascii?Q?CEbdjIKU99wzG/Y3k09VahvgSnXNTlH32oZPiTPC/YBBmjPnoHT3nzkGwH4J?=
 =?us-ascii?Q?gXqntfwribeY2o+ZrgkPp6PLiIYRTS6P2GeKKzbq1t+SN6ZcmkoTKP4Uz8W+?=
 =?us-ascii?Q?RlIbpbelhgxd67DV2boDSwN+gwHkmT/8MGwMtQwzT0nBsktbK7NGzc1rPB4Y?=
 =?us-ascii?Q?bx3E0Kq9+DNMtWtcxuAoiVOi3jy0BvuH1kNtnwlr3U0F3I0w28c8Z+f0DrHZ?=
 =?us-ascii?Q?AEAh7iHkrowNyd7zpa6UXM75SeCBSijXRST7JYVszEMqc1Ke8btLmp4/Z588?=
 =?us-ascii?Q?xkJj/K5nfZp03uccYFBloKzuVXQj0fACfPLRQ3oWw35eH2RlpmRdT05sEpvc?=
 =?us-ascii?Q?S6WmFbm9KsPn+cVVb/rw+OhfKx52py+kC00lGbLp6hlI5UPhWycV1AkNz96B?=
 =?us-ascii?Q?Fy+huD6gxMbvsJP7JArrYz+xBjZsx5iK+bisttR7McW0pXaSKIYXwJBtlF6T?=
 =?us-ascii?Q?KUcjkf4eIJisOwm3h17HDVggjvG8uWhHQCJCzAwiYL68FjyQvvRIgx+CAU9Z?=
 =?us-ascii?Q?DmS1jxYXqzFYK5WAEgY6WhNYidA/y/Hk/o4x4X+0M0o7VIHgK3TsXd+2vvGS?=
 =?us-ascii?Q?aWTzd6JPiJT/I60LX4HyOMVOYMwDw7EkEUF1eZzZ44PEm8q6Asx3GA0ntKSC?=
 =?us-ascii?Q?uKWyJFPkaNtOQGnEUpLH4gv8W7v2Y8HwtCfAwalXDvCLr2lCwEIVOKAVUCVS?=
 =?us-ascii?Q?dDM3C2KMP1/muAqhanPXUUsp789lmZMV/WV65KMv89I312gAIy3A+CM0pZe5?=
 =?us-ascii?Q?P2Pt1e5Wp1kVAr1qYZqWufz1xBw14oh0jyw+ZV+bxRKw9ZaSOq0goIAHekiT?=
 =?us-ascii?Q?LQKv01XPU3uzOeW9qQlPRWwX6X5D4Dv5BJzWRcynngumo/BfH2khIFJirkjS?=
 =?us-ascii?Q?16GBBZ1uknk6Ue/AsWiSEhGEm/iihSP8HThOpgnc9BwsvQLbYKLibHvdb/TG?=
 =?us-ascii?Q?Z2RxnPajv0+Deumq/NOeis6jGXrNWLGqOsZxzmLgbypcXhO+cuGcZw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VZEJ9y2Dt1Vgdat64del2rAtMZyl41Zeuq2gV3Z/8GQHpb3V2KPcB57jYVbO?=
 =?us-ascii?Q?ujyUQcXvuj/78dSafVnE1xtaPsLwtbEJldkwilXxYBhOw4rXgZQRah7wd9e5?=
 =?us-ascii?Q?7wZUZqQXhQT+VvLOSPuLrLVayA0HNAGx/MDRSmA1j9GmztJ7SS28cBLPwLZi?=
 =?us-ascii?Q?8+y2K5VBcv2XpBgS3G51XA35GqaFJ27IxrvNvRztg04GC9bxB6yAvx3yd2xd?=
 =?us-ascii?Q?dSRp32XFgiWWZAGrYYaDGyU9unavnOHIDIKR91L/8M3HMtHuDoCqPfoCDCK+?=
 =?us-ascii?Q?yWfXVWmLgs4h8e/My4RFIX40qvnLcgefLNw5tPus7mXgY5hL0+OJxcnWt9uJ?=
 =?us-ascii?Q?cbiMl1IVK/7b54SxIQrhNVXBUXykP/lcFn0DpNB/FNN+g0LVX53rL2cQuzE0?=
 =?us-ascii?Q?imqf6y1fi0qTOJbicJtCLepdKgehJFiABVQFMoGuu+2S7KGubgXw4Tfk9mNR?=
 =?us-ascii?Q?cmj256ajVZHbXIdUYezOm47UCPQv96YOfYPRjzmflDCyXxUaB/jFtJ0ZumIf?=
 =?us-ascii?Q?8LESQmB/Agbm13gqX4qqshsCdyhhnst20UwaeWgR1Upir4hlh1HtFpAwrE63?=
 =?us-ascii?Q?TLwUD1BElN9RGnzg8dGd9hb+2efPTvTMUCfRFVMvkKOIqIJEqw4dHsICRruW?=
 =?us-ascii?Q?beCmbnAhSn6OGf4U7+aDarBiWSV4Y7WzglP0YHwkg0uRaOVCO1TxMuOLYxhP?=
 =?us-ascii?Q?KO5QkM/TvkuEGb5mLPB5vs5oiYbk9NiW3aBTbgiRh061pP/28W+abYr4RnJH?=
 =?us-ascii?Q?h0QgQL6dnui5b75y7ztfevDQkSR21gUnNHpxv5wnBcorZbF4Bv80So0NSsgS?=
 =?us-ascii?Q?Ce9/zeG9ADJDVD3HGfeS/l89ALJZhK7eEA6ICWMQuWvLtEpmzTh+5sWv0EOP?=
 =?us-ascii?Q?vSBAtBS6K6J4HKnelXY3H0M8PmZcCgMhHSiCrfB1h6Kihsqr9SZjlhGEF8aS?=
 =?us-ascii?Q?ox/tBZChS0z7cQWOAbDYTXleLR2KOG+uO6HyZoSF2Iu8qr21NWygZWpanCXb?=
 =?us-ascii?Q?OcgYfDcx3Qvt3ekR/gYnqGKl0UaiECDxv9DGok3kczNPeySiUwj/dgdEzNtM?=
 =?us-ascii?Q?7c31/tVDS4JWnQIlmKAwZpWC3V0EOspR99oL0fgj1fHtpNb6223GzKues0ID?=
 =?us-ascii?Q?OSu2cGMyyKwFVdjrfczbK03ggZfuUz+mlfuCWZ0o7Tu94KqI0N1IC0hYU2op?=
 =?us-ascii?Q?NXFCjYupLxWUIVSQuWpFQV1PU1wbJ29Q9dOFFsN6/cuiXJ1cbTw2uoeRkfYs?=
 =?us-ascii?Q?ADkExz3V5PVg5W9Dwp/27XRAaIwmPemASYDapO8u+ipthsHgu0TWJu+PdPJb?=
 =?us-ascii?Q?6NRQ4UVpS6XWbTq+pdhUEXsqSaTOv4owMFLO9YadmfNlSzkKcFu1JwbvQS+1?=
 =?us-ascii?Q?sXDUe56kP50ZNVKNFzxrNrCCfIXSlCymC46o/mRdBRzuA0BhNRh8dc+H8wXM?=
 =?us-ascii?Q?iydv2o07zEwza1vrYsw+W6L8d2AnNzgQX8b4B8tJq3QC8hzUBhCL3gVDu/v0?=
 =?us-ascii?Q?0vmlsDcpaIrqdfzZSkB0loj8Ydg/xZtebHKEbZNbWTagU24AZHwwCRnstOz9?=
 =?us-ascii?Q?ad81Wl76tmo84WjuIeO9DQsKsfOQslHRdCTl9I4WwQJkIqUobTuHO0MqwLTU?=
 =?us-ascii?Q?zgAAJpHIZDhuFvQM/AYkZlfuptmetGqPJ4hjbRFWJs4uRXeMshF6E79g22zi?=
 =?us-ascii?Q?Da+8kA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 143dba11-f01b-4f75-a55d-08ddfaa8af20
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:54:15.7121 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zgEfKizFlpHlmf/a3nw0xZnBQJv00PmxIs5Ve72YYSJMYwGCG3Kyp4f0fs5go24lkpm9OP/I3AHOTi5tl7jlr7hxQ/+z61wBjWmhEkDMHqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7037
X-Proofpoint-ORIG-GUID: xkd5fP8e4fD9d9__uDWU7x-_t6Ex8c59
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEyOCBTYWx0ZWRfXzC2fublOCFb7
 dmMHoeqda1gr+AcXNNA1W4KkoZYLxvSNHpfjAhRgrppwfl44ITJdY5DqlvBV6ZUchz91Hqq60vV
 I3RIpfLxEyn7045LeK6R2b6nstqkhXYIJv5Cb4nCfkIYzIOPwm1Y39xaqjmN/ad1JFQAnd0N2a5
 ybwgL3zdesO4l4N87OrsZW1/V2s8ciBq2mXYIQk5+Ivo6gdf57zssIOJn9N/6a67CstkoaDp6IJ
 c/cDbTAOfBIlLQoop3cNoyXAt2ulRVV2eGzlQermcyMHx1lxam6FcJVGcnm++a4uZKrGtibtDNt
 Hwl/Hnld/HXwr9HYGihumiPU1VdZ5KO6wBhwmTtAZleWB3ImwU0mQmkJZjeB1E=
X-Proofpoint-GUID: xkd5fP8e4fD9d9__uDWU7x-_t6Ex8c59
X-Authority-Analysis: v=2.4 cv=BJSzrEQG c=1 sm=1 tr=0 ts=68d2a689 cx=c_pps
 a=LvphRkG1ZSFrSK8rCZP5oA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=qse9ws9tkOKHSfBmG2oA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

This file is mostly concerned with the VFIOLegacyContainer implementation so
rename it to reflect the previous rename of VFIOContainer to
VFIOLegacyContainer.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio/{container.c => container-legacy.c} | 0
 hw/vfio/meson.build                         | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename hw/vfio/{container.c => container-legacy.c} (100%)

diff --git a/hw/vfio/container.c b/hw/vfio/container-legacy.c
similarity index 100%
rename from hw/vfio/container.c
rename to hw/vfio/container-legacy.c
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index d3ed3cb7ac..62b7a7eaac 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -4,7 +4,7 @@ vfio_ss = ss.source_set()
 vfio_ss.add(files(
   'listener.c',
   'container-base.c',
-  'container.c',
+  'container-legacy.c',
   'helpers.c',
 ))
 vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
-- 
2.43.0


