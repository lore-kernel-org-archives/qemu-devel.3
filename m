Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B134CF31AD
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 11:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLgam-00082p-UB; Wed, 19 Nov 2025 06:43:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vLgal-00082O-8M
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 06:43:19 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vLgaj-0002PR-67
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 06:43:18 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AJ6g2ko3465867; Wed, 19 Nov 2025 03:43:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=qDiWohZKdXYEnWk91oMYqwMyJbLdkX3JlynJi1GD7
 3M=; b=PNE7LG0CYQtU2LSDUEZTcPFnnNkE6EJSJtnkpVo5z2ctXevT666zpPjM0
 sPhcSdTyM/9DMC+dq2gCjx7sj65NkBpMK0WOV2OY8WaUMvzmaNxHv/tlcwSwCKYj
 W1BGZEpHLGv7+117mCSfpcjrcy494uxaeXP6tqYMTc8/osFCCummfr1Ei0Ma8OIK
 yZTfpKZSgasEZz/kOOzlD9ZW0kNR+hsm+AfmFnS2ml6snDO/mg/iZx8EvxTv0cEq
 YfvdkuUqpLLt3n6bgNsqbJ7/9Sd6FoefbTG9qICObRFiVQh1O+P2stJbbt8U5Rf0
 pB9Yryx9urVgR3IAsni8iXR3GovEQ==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021079.outbound.protection.outlook.com [52.101.62.79])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4agb8mcgac-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 19 Nov 2025 03:43:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jpqqBCPXHxeA1tFLIW+zVQWppsmXpWrCcQ8tq6exQBQWL1FmYxDJaycxE/ed900JjBaJA5nGdi7ZTyS0KrDS7Xkej3Uiko8+4v+Ea9j2kb/1KAoGUp4/kjaVVCm+qT1FZzJYZ5wDGSfz19XYE4xDPIon2cTl8Jm+RMLYZAwYqIjxjgBcIbmWGRb12zN3qhsLbeIY/elHBidIlNbXmhQI+QVBWpyAglrq/LPEofiLy8stwJKWYpiXOYwQh4uEAqVvPlWGUdOF7QT7Qtm+FlB/HjFBkKlcDThK2729K36daxuDvOsDLoIULgqHo8mzIQlZITwjq95q8DLpXTcwxCh6Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V96lPHNifjNgzAYzYr7ddc+nTPDXwNlHSZuCwYxH+KE=;
 b=dVys8H05ROJfU/CvsZQ3Ve3+1OwLLu8S1QQp5kwh9QAP7XaOk/qBn4rTSz45DThOoWXWVijFQ1VcKuB9G9aUqrUOFEqcRWB+dgaV5kk09McJlgDaZBH5uJu6G+j7bwELIwoAiWfcu+/tUg+QpvtlifTUlHliiGiGbXvqdKOgKZUX3Rl2rtaokiGH/nfSeot7TyXOdTryZcEbA5/C34tOOi2SJn64uJYeauYD8sFhdZSSWiijtTjzr7g1Qznxr2Son250eR6zWT5rOUPxp3FFYZ1xGVP1n8SmhB7vlpVQNeqlo5R7E5/RZpa7tCZSKXIuhEUREC+1w6hqARFadLDkPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V96lPHNifjNgzAYzYr7ddc+nTPDXwNlHSZuCwYxH+KE=;
 b=FcDG20QdVlhbKfw4i3jQgtRXqUhr2mqYB+iOn7l8m7XeowKQiUoRhYzdAy28N+lrPBsH1JKQrmWEtuxy3/EgEBo5A7UvplHCvy6F9etlSNDdH1OMK6e7pctWk3Y17swGxzDsgDR9Q3HGpJv3MOvRr9k67xP4AX4QbkabtB77Pm4phfbkNjLPmBO7u8vUjIdyjws7/P/yMmNFMFWMxIuQFIr2zCcbyHNZvfKyhvf1YKQVLyKMReX8mUFvP4TMqvciB6cBknANU5/qk1Yh1WMLJQ7f4khAt0DJ3g49f2tdbEQKIqjNjeqvwOzrhGjNpMhOo2zpV/AmvvNZ1SyZTlkcqA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by LV8PR02MB9949.namprd02.prod.outlook.com (2603:10b6:408:188::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 11:43:11 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 11:43:11 +0000
Date: Wed, 19 Nov 2025 17:13:07 +0530
From: John Levon <john.levon@nutanix.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Manish Mishra <manish.mishra@nutanix.com>,
 Tejus GK <tejus.gk@nutanix.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Jon Kohler <jon@nutanix.com>
Subject: Re: [PATCH 7/9] contrib/gitdm: add mapping for Nutanix
Message-ID: <aR2tS7Vb4DbKUxDU@lent>
References: <20251119113953.1432303-1-alex.bennee@linaro.org>
 <20251119113953.1432303-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251119113953.1432303-8-alex.bennee@linaro.org>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P123CA0193.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::18) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|LV8PR02MB9949:EE_
X-MS-Office365-Filtering-Correlation-Id: d13cbd7b-5ed5-4a09-563e-08de2760d0f6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?ERpdnMcZ5ECgKv8G70Q9uecaeo5WOvk2ddVHSgizSJdER0t53x4JXYZeGP?=
 =?iso-8859-1?Q?NE5g661rmzt6/lBTCGjqnQmng/Hu+NqJCg9Ov+XYMPFjrQJoW5JCsROhXC?=
 =?iso-8859-1?Q?GG5mOQW6UZS5Vmd921Ko11A6ElGyCuBmnEBdgSyWBQvqOjlwMuFFXlY81O?=
 =?iso-8859-1?Q?0s9IzNuPppoVqp/qTVb79FVdq08GE3gCpxbJfGYv4ZhesgRfPOMrVwdy+r?=
 =?iso-8859-1?Q?seixPJbMxlvcmVV2duxCh65OIjBqs/kXKBgdElY3EzKQpFrfrxIMD53kj3?=
 =?iso-8859-1?Q?VuA/59j74FhyBrjwj0dC6yNg8Q5Z7AmW7lWwKwqMG/8RpdOSX5vmbYOhzm?=
 =?iso-8859-1?Q?0Zeg6+YYbKf//j8u/zKZD0iTRCtc93VibdCi63f1c4AoOdAYAbB6P6yy36?=
 =?iso-8859-1?Q?/KbMqzNP80PO5Mbx8aWJ0Ft0e1WP2dX5ZAUNMXIUmPgZ1idE/TvLMyn0nV?=
 =?iso-8859-1?Q?9rtEkWwpptYN9rMgBsKhDhWKmBxeh1jV8kOLbJ+8KqUqZz97yIa80NJ4jE?=
 =?iso-8859-1?Q?dw7tfVkz7HW5GTHM+7WA8+hqA6wmfIDJ3RFrh3dPsY9+optrxmDzqReryj?=
 =?iso-8859-1?Q?uTTHfJ7q1ZOgW0eL599/TI55rk4V4EgBwacSpKqF593y9Az5HvNca2zBFR?=
 =?iso-8859-1?Q?wX2GDnIedL+tbxONmrjvU4USqdFmREzvnwGVcroRSmJNyJJzu3fX0TvQWq?=
 =?iso-8859-1?Q?qsprkz6FqgcM6mP0G8qxJqySRGM1vTg9hcWfFnXQoeSGL7iDrEXN3fl9A0?=
 =?iso-8859-1?Q?Y4dTuG7gVuIPp7xsinIKv8SHFyP1RoMLC9K83zrUb/uZMKtrsoG39dROfs?=
 =?iso-8859-1?Q?VF9AgDK3zUaIUuBVY3hPcUtmCGn42AeJuSuH892/+AwtQWCyKhv97ENN19?=
 =?iso-8859-1?Q?EQ2mi983we7zUAqCIrS+QgmmjWVCVNFhl80Rb4ytLK995zXW3WD7J4MfHw?=
 =?iso-8859-1?Q?ewPCBwlJ0yTAvqmRymsV2Gj0UduqvyewtybgnPF38g93N8291M+LOlWzlU?=
 =?iso-8859-1?Q?TiQSluHtN+GFVyy5uPUGyV/XdNSSKkh24vs6s3DymNOGEwlCVRlSZ0v3fh?=
 =?iso-8859-1?Q?Hq+T1BXPm0t4nBOu8WUO8cdcr7Yko0+WcWaiNNrGruLmvGk0djp90g15B8?=
 =?iso-8859-1?Q?TtjI0mjI4PDHpE4JxVAeWwELtDGr786Trp25iTrVynmtTmoiTsE6ru+zAy?=
 =?iso-8859-1?Q?P231vhMANyN0QX8wNqdLtU7VVgKenEme4e18mNYeM8L45PyV/Q+09GdYn5?=
 =?iso-8859-1?Q?dVBbXshZvtcrehkDwwbLertFB5N3GYtn8//fw5h4wfvK1f0rVA/RtiOqre?=
 =?iso-8859-1?Q?WSrEJjTuPUye1d4iBysjtdQYNpL7YLyzjJk8uYsBx4424E5n3gl0aIhc2z?=
 =?iso-8859-1?Q?C2HG35IC7iMM+0ZBT/p1sawapBQl6PwPb4c3EAPEzfI8gHhX4N3NwP0On6?=
 =?iso-8859-1?Q?ZVgIXRtfcDBGXJDl4+mzOmTRcFKT3YKzSpjP25gGZg9Wc4JbfVIT/9XQWL?=
 =?iso-8859-1?Q?0Kj07Tzfq96DGCzgzTXsXt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8DQKr6rCikwqxJhcZI66ayZE2TBWYb2YRnazOoJV2sHemil73d8rXfDqu5?=
 =?iso-8859-1?Q?mp3OdSUIx2+bI0ZXPMJUoxJoEV9rXcu0RTH1ZXRtDM7XBqpAv6t4z9vdN2?=
 =?iso-8859-1?Q?vCvAJP+CFAm9eFEKLIGbzl9HutRMds0t+R3Ed5sTlfTZWEkQwsn5DOZMcL?=
 =?iso-8859-1?Q?6iEEzRCuNyIizmAy92ty/P7xkC84BqSnfkLtK3uLMTCJvjnbEBRilBUyEr?=
 =?iso-8859-1?Q?F5BvKumIQOraUDqZI7KeHCiEXW7qLlfsbFB9n1HMnDSYlBKHUlHkNtddtB?=
 =?iso-8859-1?Q?V6JZvzMZskpFAXHddhInml5XAdoM2T+TLE60ahc9Y2d1VFlcZwt5J8j0NG?=
 =?iso-8859-1?Q?J8uQ9BiK/QfVHDNWMgtQHdMtr+QmgHpdhv9U73WRSJB+jriLPprWVPJZn7?=
 =?iso-8859-1?Q?pdplib2AGsy76GS6mCXb76WIkymYBo0xg0Hvye13yS3brfAuh7BcrysoMm?=
 =?iso-8859-1?Q?4MLMoakAHfEAR7ZZIGs3Qcs9K70QJoJHTwXUj2xtWu/dn1D8blO8AM9uZx?=
 =?iso-8859-1?Q?3c42BFHaQ8eDFa4uRUwfhuSgXuVMkXL/iGiP9nhBAs5IyCSIQFJvN6CCW5?=
 =?iso-8859-1?Q?ZGaVD57CffXkBlfhwmhNy1SCOr1vusCp4C1oFj0xFQpLNfKKTIHdnfPYS4?=
 =?iso-8859-1?Q?wAVoQbSbwdq8Kcy6/8k8Onyw3fA4JHQojEW1H0/CVH8ur09YGB/gdMIuws?=
 =?iso-8859-1?Q?j3Y244j2Ss8NrkLLY3vkLEvVLQ45RTc5lnjFE2AVfzAez/FQDeNfBSg0tA?=
 =?iso-8859-1?Q?0+cbPcpuJ2Wh2o30X1p+5C2WrnpYNc3BL53J9oU0JFCoPCk4I0V1hBJCP6?=
 =?iso-8859-1?Q?0e+rteKE4w8ryOGrUhlg7//orEQ6COYuYx6BEAMJJ4CD9AMS6YuLIEctzj?=
 =?iso-8859-1?Q?P6u+KefcTWTSqbBNpOoPbJXNDyVJZOf7A2h+5weTfsn5lOT368jUJkYrvQ?=
 =?iso-8859-1?Q?xepzDSPDsFyYOX6yV4GSlvSNTt1cSRpB48WYPoCDnRG1DafYCgReAScyh9?=
 =?iso-8859-1?Q?VaPm/28kHqBn3WR78h5rQ2QoUV7CkRlJutdgVDHOFW8mCgspL0Clt5eCk7?=
 =?iso-8859-1?Q?z0MM8wU+ep+8nL6EyEKBhBS+r3OIzo5+3ut+Zo0OJnjVXgTN/zAzWVYElV?=
 =?iso-8859-1?Q?H5YvXLVe4rue1PwNiK+MN3p6/Gaci0kSdsYfm1x+iKyZ6dBtX7L0VuQs9y?=
 =?iso-8859-1?Q?s/ob+U4LX/GyWN88k0Hb8Lgnu/xWFdUmDFHHiGwUKvi3IALgdOkzHaeztO?=
 =?iso-8859-1?Q?+16WnBb4YI4+PcL7NcnA+mHEwXMO2QaZLy8E2DyyVjA6ZIYM5MgiXvPni/?=
 =?iso-8859-1?Q?sDICKwfL67yoj03R10uaL8ah3p2W1qEfmg6VkCTiWVj60ypTO2Gq7uZjnf?=
 =?iso-8859-1?Q?c7aZcEjZp4653DmJZtoyyLnfLqXqsYZ/gTSTKZNLA04kEPtm97OfaOqQJr?=
 =?iso-8859-1?Q?G1S7xW0jf5vte1Akd5em4enDoLiSMWjQvmMHn8NdTi1EX404lWSERpvF6o?=
 =?iso-8859-1?Q?xKLUTLj0Pi659HJumA4qEDxq5SO5pa7cbWEIwM+JhiAry+OGZ9G49LtoID?=
 =?iso-8859-1?Q?OpmLjUHBOPATwf2b7NfPyoSPJxi7y3lbxW2EIZjeKtw7A9NxN8RnKFTC/O?=
 =?iso-8859-1?Q?0gca1PF7NKMjF3miDkWs/btes6dFrL2SYN?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13cbd7b-5ed5-4a09-563e-08de2760d0f6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 11:43:11.0812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8lbYn9JGg4WvJXZtreJDz51GOnGQWmXw0BjvtBR1rG18e79kmYs9VqfdtmfZ921w9qM7n7K8ZRmWBKPE7Ss8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB9949
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDA5MyBTYWx0ZWRfX7lPQPWQwkK7I
 EgmRXU4sNCKqVAhlOYR4pZlWcI6dNRNyn9WnzEzOJsxF/z7bw4W+dtPx+FEG7b1Ub9swHB1aXRX
 U01wdoHBvtc1z/2sxLgCeZEpfaPIujfI+5qcHecOp/TGwDZaAUirK3YDnbakikSOs87RtBjFpQy
 jdekyr0+dwytyQ5+PRP41/csQZB9JMvDpbMbjJfEDyBWiqwHDE10cLwIRhYdqFM1yTPYkhMoBhT
 b68rZR25ZOWvQKfRegC1IebmBsWSxD9LUh5ylRSsTscWF4kcgsBIILJUhhHWykm6adGPJAgmR1U
 z/i7kQkcZ6Iw9/mdlsKDSN4w4PqmnzAkvDMV/QGIsqsTTP4PNLB3aH9mxXwZD9uNjEHdDUE6dKW
 NMx6PkWUNqadrqq6sFNxdBC4EvaInA==
X-Proofpoint-GUID: ZZYRBx9ncjBbyeuGwQK5_JlPTG_lvUsZ
X-Proofpoint-ORIG-GUID: ZZYRBx9ncjBbyeuGwQK5_JlPTG_lvUsZ
X-Authority-Analysis: v=2.4 cv=cdXfb3DM c=1 sm=1 tr=0 ts=691dad51 cx=c_pps
 a=pfd1m+JhmiCErHYdEUHeAQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8 a=07d9gI8wAAAA:8
 a=yMhMjlubAAAA:8 a=fk1lIlRQAAAA:8 a=9qxNCY_qAAAA:8 a=j8RhgVXbAAAA:8
 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8 a=cOfP1fucIRZuglvrIDIA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=cvBusfyB2V15izCimMoJ:22 a=e2CUPOnPG4QKp8I52DXD:22
 a=U75ogvRika4pmaD_UPO0:22 a=3SzYsRL22XtqO3ZTpi69:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_03,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

On Wed, Nov 19, 2025 at 11:39:50AM +0000, Alex Bennée wrote:

> We have a number of hackers from Nutanix, make sure they are grouped
> together.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Manish Mishra <manish.mishra@nutanix.com>
> Cc: Tejus GK <tejus.gk@nutanix.com>
> Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Cc: John Levon <john.levon@nutanix.com>
> Cc: Jon Kohler <jon@nutanix.com>
> ---
>  contrib/gitdm/domain-map | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
> index 4e67c3e484d..c07dffc51bd 100644
> --- a/contrib/gitdm/domain-map
> +++ b/contrib/gitdm/domain-map
> @@ -35,6 +35,7 @@ lwn.net         LWN
>  microsoft.com   Microsoft
>  mvista.com      MontaVista
>  nokia.com       Nokia
> +nutanix.com     Nutanix
>  nuviainc.com    NUVIA
>  nvidia.com      NVIDIA
>  oracle.com      Oracle

Thanks.

Reviewed-by: John Levon <john.levon@nutanix.com>

