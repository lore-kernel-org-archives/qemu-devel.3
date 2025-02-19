Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B4FC021B0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 14:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklOa-0003LE-Ci; Wed, 19 Feb 2025 09:49:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklOY-0003Kg-Hz; Wed, 19 Feb 2025 09:49:50 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklOW-0007E7-Hp; Wed, 19 Feb 2025 09:49:50 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J9K12V024315;
 Wed, 19 Feb 2025 06:49:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=TO+bwFhGPGzXhvJDbbFkpLIKPKdPUyL7isPRaKiTw
 S8=; b=TflzW9VzxYXNC/Z7r9ZsHo6P547Hwd9Q5XAU+sGvnq6wkhoDMZbhBohxs
 sM/fl4hgCuJGp+mSuk2581eLpbnqsuOQX2tqTfIdnAfhP2EA/qse5Vaq2qSDC1DO
 Qk7xzMPULfAPKK/cWYbNBjxdxgG43syBj1QGK6qA0va2u7E39OuH4De4mEGTURrm
 YLMIXVt/Ow+odW8dF6QZEyOPC12Tp4vt+WTf5S/Aez6CtKfwX7bFexyLu3u1bqTL
 5RWRnbWDAFcgfKt0bK5UJ5ROhh01OGkTq1BKbWToOVSgPrvWQix9wEnGho5i5g+a
 Eg0ZMUkCYWF8qP1jaZiQ7XE8GTo4Q==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazlp17011027.outbound.protection.outlook.com [40.93.13.27])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 44w4basxrv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 06:49:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHtqqxSlZlWVQlTcOn0c/0G/orHo/PrdGEJFJjPHZ3VMogjq+HwJ3shxqMDtwD6KISTHvJjZ76bG03ZufbJ/622rW3v20dEQY80rilH4EIv45VSkqhPkN/0UCuKCGSCYmiEGPgGF5PkzprAw2mt/oC1hTIwqHmbbiwduoZ8TfqIQr0UnsWMBe77ixIckTuTiKKkabHrjCetqsNgRVEcI5YHzYapcc7YGi/riZ8HnQSfZyy9IBSjZfm4hSt8t7WkaV/lrXilKgl7CZ+QyzklLhBYJT4HVhzG2KuVvNVGX+krIXFGKSz5Xwji12ouHiTEDwqtQ8wm7p1DiGfpGnrbS4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TO+bwFhGPGzXhvJDbbFkpLIKPKdPUyL7isPRaKiTwS8=;
 b=EkxfiFAgerNAUycQRjMTIzE7CSJug0T0Bbfkz1JSw8hzu7PH/pY04USz9KfO71aOM93AezojjAYXG6RVqO3dUO1il6dwvwdTWdKXPg7UHWaMws7moydOvIxgiRCK/V2gwv5Whm89drysBNkLrDgTeTF4UUgzh0esAzsbcTC5MyQvYJxLrANm75h3pc1W2qKZAHEQuDM9XblTPD7uNXOvUlILCj5T+JQ6gL6dDW3ceiyG142EXTFROXlbs29SsPX8Tl0WUcdH7xc1ENgCLRKS/I5inR4QsfnASvYG5pPILLHLlBm3xI0e91VoI59bgUjIt/GBUJT9xBM3wHD5mYovMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TO+bwFhGPGzXhvJDbbFkpLIKPKdPUyL7isPRaKiTwS8=;
 b=okO6ZmYgGBHvfnQMBXT9UBeWCUkSx3GpS9QDIVuW3G8ufLjnY9xCCfZ91FklRbmXqb8b34N/K+uLNOnZbALjEw+kb9Ru2PcFXmteXpfNwe/yZhXKVL3+fCPfgfIUPARXm0R0J6gxWWVT5sLuniR2t+oH8AOPjG7ZOk5lNZynsLCx7Bmqd8p4ahWEbLS6SmioLMvl4VIVnFwqZMYZMoUqBAH/6Fgk5y2vDpnrDbS59g/Vi6YfPydV1M60jG51t78J2Sav4muqgEKavscS3qTwMiOLWZsspanp5tOu7ZyWmxM8Focl2AI8gqoLG3AfTFQmdypwNp5jFnO3BCi9t5BOog==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH3PR02MB10559.namprd02.prod.outlook.com (2603:10b6:610:204::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 14:49:37 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 14:49:37 +0000
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
 Jagannathan Raman <jag.raman@oracle.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH v8 08/28] vfio: add region cache
Date: Wed, 19 Feb 2025 15:48:38 +0100
Message-Id: <20250219144858.266455-9-john.levon@nutanix.com>
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
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH3PR02MB10559:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e14f789-4d37-4ad7-3d4a-08dd50f4a1b0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4X+8w6RIkHdZ79J2+RihCzjaif9vqI0MJDROZlfk6y9C5mWeCUoUH2/6Lvs5?=
 =?us-ascii?Q?8t2LvtAHaBGq0PxL7WSf5v4BttRl6fTqy3OmRHzbcr74pBIMm1bwR8mvvgI2?=
 =?us-ascii?Q?oz/v55J/sWRg2A5L0+Pi+2By9CMcMSwwzkCGiu4VsPldB/xFau7fb8fWaX06?=
 =?us-ascii?Q?LHbAJyrBe2q+lEd9o1PbDtCvZQQZ7nGlzB2YZJcBRwJFo1osB0RTbVQGF08N?=
 =?us-ascii?Q?H7cViwa76vJSuG176mRGs9nptiMNY5XKMQc7JZRWY3+TEK6px+nI4BSfjeX1?=
 =?us-ascii?Q?HEtCyZZ114luLA0VYRRyTeSGuxDj8CpZbMoOk35P7n5t45hbACinLYPkalRY?=
 =?us-ascii?Q?NDupdsnIbcxbiQllgr/E2Rbww25VCVZ2m2zOpEFzTYGAG3dWS9zqWN5Qikai?=
 =?us-ascii?Q?AJdh+g794UQIWC/eQg9kw+S352WOdtjVuEM7o6FVQVOnRM2c20FLN4K8/7Sx?=
 =?us-ascii?Q?JwDj62l1/g/t8/bl3BorvyqrHFJKClpMrCIRBVKvGuSr+XvTfhQHxXztFJod?=
 =?us-ascii?Q?xEq9HYUjW1YdK9WcVGyWJXr39M5nQGe5hC1Kh5YnbAwL9O/EGmZrMvkRu8E+?=
 =?us-ascii?Q?SmVgEMCxdzYPOi+2aeApUfeNX7JfZhrqCqdJ5ZDqr9OLnlc2GALGUnMkwsWL?=
 =?us-ascii?Q?WqzJRbOTSQ5sPZe2Cp4fMRLqX8uDbYosMQBv/MQ5qglox59HVSxfvCP6Uqll?=
 =?us-ascii?Q?LjCZRu39dSTsdq6nzywDzGWWyWTesDmwffxFdCnHeoKKpAujJU+2aNbXxAON?=
 =?us-ascii?Q?4gKPaP3dcRTy96RYiyC1KNQeieqC7TzuTLjsceAEDS0KOIU8DhmZRO3v5sRX?=
 =?us-ascii?Q?uEb3wrbgZk12R0uVHRYLsx+jlwpoN2nSXjbOhQgcToJJ3nIxnDtPCouhH3Mm?=
 =?us-ascii?Q?AVnmm/5mM0GROfaYgl3pqV9/YxuunB2VFmKYlpjXbyfNOhKr2Al2awDiozfH?=
 =?us-ascii?Q?AOUt5WCQOMjfgw6POAVjwBaNyujcTNVD+OZZvnIGlMTSkguUB2a+ZBFxlsq4?=
 =?us-ascii?Q?nPwK62eJJKXYW0wNhCK/sW6Wfc/SjckpWcgjWuHza/z0+SbC2dfQe0bM0CLg?=
 =?us-ascii?Q?2JDJSjiKPL/tseNVFkTTERfwyNWYeJE4YkrfMHftESYtfB05pU4llJDZsmfA?=
 =?us-ascii?Q?0fC3y6aEXSreLGg9fFBZMu0vG+S3r0ssqLbBmwvTZUKOtY9DZKo1sfkQ2rPE?=
 =?us-ascii?Q?gaO6xdDKRPcrxLxQUnkH2T2KcvPzYt6FlsW6ppqrb7XqFQwwVFUK4CiZCl2g?=
 =?us-ascii?Q?CHvnbWRMMFTxwpjTJT4KRXP/ybubgYylp4c49SnbuLJUX6DXKrmU8Rj6s/57?=
 =?us-ascii?Q?6W44chKym+pTTiNaeEeL/WPD09wKXb5pSOPEQDxUxvo+CXx4nIj9kOlMguq1?=
 =?us-ascii?Q?vtJ5Zz7s2uNOs4lZyyZFyWuMPgYf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qa3WN+s8pZdwICHeLOdI0k4YWVS1V3zo/kNam+iKIHOSPGs7AClKYxxOhAaQ?=
 =?us-ascii?Q?mni6I9Bx/Dz2sbfR4lS/jV6uZY2xaiIKyUEBYfk4UY9jwzK+sDetqNd4a82u?=
 =?us-ascii?Q?Ew9Nz+UhjnyvTg7WQcPA6qNVOHAFtN3hzQtQJHak4EsgBsCdyXSVJVMB+PxK?=
 =?us-ascii?Q?3UTgzaF6DSV0LBp2TlSHH8DhQdWx9aH8HiAF7Fqqw04V+c87ZhpdLe2rF4/v?=
 =?us-ascii?Q?Z9ejKMd80Pz7nX3Rmx3dl8n71DYg6w5P7mJN1L3fl5oeK0u323wPtHn5RQnV?=
 =?us-ascii?Q?0YhVjOuamU32oMSczMeKfZQa/at/q8vVsqAAua+vkdlB9+XVmQEvwL++SpV2?=
 =?us-ascii?Q?rYoao8la5/1m5GrT6dbRKjzubaYUK7GKSiH33zy/nexZbaiAjSwHoNWH3OHL?=
 =?us-ascii?Q?CLS0XJbWcmNC5s61ugjtw1RGom67Tj+Y595buZLhcJxys69+B/CN8WGULdpR?=
 =?us-ascii?Q?SEUPbWP4mT6hLhOb+QI+ItgEWn47AfEMDQgngW2IH8cbkSYEWdxnG8HIEzmt?=
 =?us-ascii?Q?eNjn/10/Aiu+7jwlvC9Shi+X6kJ8ZNrjF4EmhrHO8ZwDYFk9spftXbL7RcHN?=
 =?us-ascii?Q?NeVkkhAsT7Seac/qfeHb/16nATuGrW/OL4j/C4S7eVzFQjfu3r6SNxHtGJos?=
 =?us-ascii?Q?Pzlztpd6WRfD41YUCFZmnmYMFs2crpc2byiKdwb2VnB30QBaLQzexSON1Z6K?=
 =?us-ascii?Q?LhE/lUgj+kA9hEnEdQ5hdY0zhcESyvcojDwpXwwovRYKRipvRDS0x6CVgnGG?=
 =?us-ascii?Q?RoLI6PyoCwzGwAFsgSS1Pt5pip0u0/jwaNsgPx8HHvedOzZbDF7fKC+N6KqQ?=
 =?us-ascii?Q?d7uMqnKxjnsla1s/46Hx6H5S6loUrNi4qn/cfX3h3uqPMnBivdn0N9bpxeYH?=
 =?us-ascii?Q?DLV714Ey2qfbFUrLt8OuO3I9/lLbfOG8fV0uGzJHSfvUDGDWorvxnyBFIofc?=
 =?us-ascii?Q?XU635hd6Qwl5srq+iVEY8HfEilKXxg0weLo9Jp9UZhHF+QBMHTxWvxiKBeSa?=
 =?us-ascii?Q?VVvLmtixK4x0Xf8NzKfWVtVnZbE3TlMi1FQUG+G2CknT412lHUsUcjKGPN79?=
 =?us-ascii?Q?ognADgmMAya7Dc+DUCe/xTTkuzj2b5YBUQ41yFzcpfVBEBjYhonqPeJmwq49?=
 =?us-ascii?Q?9yWFE9pMohnGtlty3vXNEH99+AjezpvvmJ/CaoCrLX0yrJvWe2HdZEnYTN25?=
 =?us-ascii?Q?6SHgnMda87b2ek+0KeNXZ6fzs5zf9XrZz5YCRkcvmaB9YrJfwJ4l7i6uZ7LB?=
 =?us-ascii?Q?KpOBcT09s1ojyZgm3BxAtybwlW/BZV0/jZ33cHGEG1m/fYI1fuomzXCpFcQ1?=
 =?us-ascii?Q?hBlShQkrH/XnL0439CbSzk0gAi1sxsya57mfiF+knzbGRj7StACbR9JEMdDj?=
 =?us-ascii?Q?mL3oHlWyErUhA0dKrk2kMwHm/gHNGNTgfrgODfQJu5Zqh4kEynG/FdVVORq/?=
 =?us-ascii?Q?xbSMnbYpr8kNqhMAaDthL2VPQsbr023C53ua3sxIj0hNOcyzOwVzH4Lt1DNG?=
 =?us-ascii?Q?eLC6YhM9Ithrz/odDlCSohW/o9h9BWdJ0b+W4D6fTDsMiQMiQTnnth7hQ8qk?=
 =?us-ascii?Q?juTpAv47udinivSivBT5qJn8WQAhkvjWIyjxinXB?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e14f789-4d37-4ad7-3d4a-08dd50f4a1b0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:49:37.2696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qP9ejPushGGuqVecEg8/2mV/IxPvHlAOiIxkECDsbyhzc+pVCpUeE5nDCRFDssnoIyPw8ytRD68DMp0brCkCUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10559
X-Proofpoint-GUID: HO9sYh2cjeqJnqFnVN2Wil5sUP0P0shU
X-Authority-Analysis: v=2.4 cv=bfyRUPPB c=1 sm=1 tr=0 ts=67b5ef89 cx=c_pps
 a=U0KzkmEawxegXmCr7eTojA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=yLJTwCVF-aHqTr61_xIA:9
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-ORIG-GUID: HO9sYh2cjeqJnqFnVN2Wil5sUP0P0shU
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

From: Jagannathan Raman <jag.raman@oracle.com>

Instead of requesting region information on demand with
VFIO_DEVICE_GET_REGION_INFO, maintain a cache: this will become
necessary for performance for vfio-user, where this call becomes a
message over the control socket, so is of higher overhead than the
traditional path.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/ccw.c                 |  5 -----
 hw/vfio/common.c              | 12 ++++++++++++
 hw/vfio/container.c           | 10 ++++++++++
 hw/vfio/helpers.c             | 21 ++++++++++++++++-----
 hw/vfio/igd.c                 |  8 ++++----
 hw/vfio/pci.c                 |  8 ++++----
 include/hw/vfio/vfio-common.h |  1 +
 7 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 67bc137f9b..22378d50bc 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -510,7 +510,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
 
     vcdev->io_region_offset = info->offset;
     vcdev->io_region = g_malloc0(info->size);
-    g_free(info);
 
     /* check for the optional async command region */
     ret = vfio_get_dev_region_info(vdev, VFIO_REGION_TYPE_CCW,
@@ -523,7 +522,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         }
         vcdev->async_cmd_region_offset = info->offset;
         vcdev->async_cmd_region = g_malloc0(info->size);
-        g_free(info);
     }
 
     ret = vfio_get_dev_region_info(vdev, VFIO_REGION_TYPE_CCW,
@@ -536,7 +534,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         }
         vcdev->schib_region_offset = info->offset;
         vcdev->schib_region = g_malloc(info->size);
-        g_free(info);
     }
 
     ret = vfio_get_dev_region_info(vdev, VFIO_REGION_TYPE_CCW,
@@ -550,7 +547,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         }
         vcdev->crw_region_offset = info->offset;
         vcdev->crw_region = g_malloc(info->size);
-        g_free(info);
     }
 
     return true;
@@ -560,7 +556,6 @@ out_err:
     g_free(vcdev->schib_region);
     g_free(vcdev->async_cmd_region);
     g_free(vcdev->io_region);
-    g_free(info);
     return false;
 }
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 4434e0a0a2..1866b3d3c5 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1569,6 +1569,16 @@ retry:
     return info;
 }
 
+static void vfio_get_all_regions(VFIODevice *vbasedev)
+{
+    struct vfio_region_info *info;
+    int i;
+
+    for (i = 0; i < vbasedev->num_regions; i++) {
+        vfio_get_region_info(vbasedev, i, &info);
+    }
+}
+
 void vfio_prepare_device(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
                          VFIOGroup *group, struct vfio_device_info *info)
 {
@@ -1586,6 +1596,8 @@ void vfio_prepare_device(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
     }
 
     QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
+
+    vfio_get_all_regions(vbasedev);
 }
 
 bool vfio_attach_device_by_iommu_type(const char *iommu_type, char *name,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 37a3befbc5..36cd245c92 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -886,6 +886,16 @@ static bool vfio_get_device(VFIOGroup *group, const char *name,
 
 static void vfio_put_base_device(VFIODevice *vbasedev)
 {
+    if (vbasedev->regions != NULL) {
+        int i;
+
+        for (i = 0; i < vbasedev->num_regions; i++) {
+            g_free(vbasedev->regions[i]);
+        }
+        g_free(vbasedev->regions);
+        vbasedev->regions = NULL;
+    }
+
     if (!vbasedev->group) {
         return;
     }
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 4b255d4f3a..3c923d23b9 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -345,7 +345,7 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
 int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
                       int index, const char *name)
 {
-    g_autofree struct vfio_region_info *info = NULL;
+    struct vfio_region_info *info = NULL;
     int ret;
 
     ret = vfio_get_region_info(vbasedev, index, &info);
@@ -562,6 +562,17 @@ int vfio_get_region_info(VFIODevice *vbasedev, int index,
 {
     size_t argsz = sizeof(struct vfio_region_info);
 
+    /* create region cache */
+    if (vbasedev->regions == NULL) {
+        vbasedev->regions = g_new0(struct vfio_region_info *,
+                                   vbasedev->num_regions);
+    }
+    /* check cache */
+    if (vbasedev->regions[index] != NULL) {
+        *info = vbasedev->regions[index];
+        return 0;
+    }
+
     *info = g_malloc0(argsz);
 
     (*info)->index = index;
@@ -581,6 +592,9 @@ retry:
         goto retry;
     }
 
+    /* fill cache */
+    vbasedev->regions[index] = *info;
+
     return 0;
 }
 
@@ -599,7 +613,6 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
 
         hdr = vfio_get_region_info_cap(*info, VFIO_REGION_INFO_CAP_TYPE);
         if (!hdr) {
-            g_free(*info);
             continue;
         }
 
@@ -611,8 +624,6 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
         if (cap_type->type == type && cap_type->subtype == subtype) {
             return 0;
         }
-
-        g_free(*info);
     }
 
     *info = NULL;
@@ -621,7 +632,7 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
 
 bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
 {
-    g_autofree struct vfio_region_info *info = NULL;
+    struct vfio_region_info *info = NULL;
     bool ret = false;
 
     if (!vfio_get_region_info(vbasedev, region, &info)) {
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index b1a237edd6..b5425ba9c0 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -490,10 +490,10 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 
 void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 {
-    g_autofree struct vfio_region_info *rom = NULL;
-    g_autofree struct vfio_region_info *opregion = NULL;
-    g_autofree struct vfio_region_info *host = NULL;
-    g_autofree struct vfio_region_info *lpc = NULL;
+    struct vfio_region_info *rom = NULL;
+    struct vfio_region_info *opregion = NULL;
+    struct vfio_region_info *host = NULL;
+    struct vfio_region_info *lpc = NULL;
     VFIOQuirk *quirk;
     VFIOIGDQuirk *igd;
     PCIDevice *lpc_bridge;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 83fe329474..a4f99fc5e0 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -879,7 +879,7 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
 
 static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
 {
-    g_autofree struct vfio_region_info *reg_info = NULL;
+    struct vfio_region_info *reg_info = NULL;
     uint64_t size;
     off_t off = 0;
     ssize_t bytes;
@@ -2665,7 +2665,7 @@ static VFIODeviceOps vfio_pci_ops = {
 bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
-    g_autofree struct vfio_region_info *reg_info = NULL;
+    struct vfio_region_info *reg_info = NULL;
     int ret;
 
     ret = vfio_get_region_info(vbasedev, VFIO_PCI_VGA_REGION_INDEX, &reg_info);
@@ -2730,7 +2730,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
 static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
-    g_autofree struct vfio_region_info *reg_info = NULL;
+    struct vfio_region_info *reg_info = NULL;
     struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info) };
     int i, ret = -1;
 
@@ -3177,7 +3177,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     if (!vdev->igd_opregion &&
         vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) {
-        g_autofree struct vfio_region_info *opregion = NULL;
+        struct vfio_region_info *opregion = NULL;
 
         if (vdev->pdev.qdev.hotplugged) {
             error_setg(errp,
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index ae3ecbd9f6..304030e71d 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -151,6 +151,7 @@ typedef struct VFIODevice {
     IOMMUFDBackend *iommufd;
     VFIOIOASHwpt *hwpt;
     QLIST_ENTRY(VFIODevice) hwpt_next;
+    struct vfio_region_info **regions;
 } VFIODevice;
 
 struct VFIODeviceOps {
-- 
2.34.1


