Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBB1CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 14:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8faM-0008Hr-1o; Tue, 14 Oct 2025 10:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1v8fa9-0008Gi-GL
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:00:55 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1v8fZz-0004QC-JI
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:00:53 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59E5iwIl2750652; Tue, 14 Oct 2025 07:00:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=87W30K/p4IsUMSN
 f2FnTBaJ7L+zW3tRbDAww8UkJGb0=; b=bFG23PRjit1zDsliYRlaPxFR0h4Bmh9
 0m9ZDdvBo19Zqt7z9OTCUI3OYcRAAzTlc36TPiM+N3OXPY/wBecLApVaktpK2gI/
 byt8JcL9a4Y4djTvtSPn1OJQjOdcEcf3vyOqXE9Emp8BRlUQ332HDdOgGLuv7/7E
 HVGiLlSmG5PG15oT+fyqfsR3CroqksMc9ANRZ3c5NRx4cgxcegkWfv/1p6SDdSRP
 lICj/tOnPc+vcmpFsuv27cCzIO4cm1K/gG7pcE7XAX4UOCYMtpRBP8nANvHoK7dp
 OXxt4//jwViHiG6wsPffZmUCT58NX/c+UCjK0ejTedHksOP0KTrZGtw==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021076.outbound.protection.outlook.com [52.101.52.76])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49s5a0te6e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 14 Oct 2025 07:00:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmHxUkMUZakrWQj0fh4095CsMYIgJLeMqAjqAjGRASYUKorUhr0MDulV15gPa8QEOYVdPn5OJ1Dg1+x3KY/f4yIN2HCS1AwkBP/ZGVS7QHQXLbsglXOSHAHbKEPzYOwveHtR9Ukm8jCymxEt0bQSQBSwJ80X9HKH5s1A9uAtBNrr3cWpf7xL59j5ibyJk2pp/9Hxai8UlFL1KyL7njFv6ztpnrrbcNPbeUKkWR2bSRLJZiI13vdIpqjS4G2c/5mbMi9hdUp9mVD00KtRJjIG+cmCEFhW4HoPFQbzLcuLsnLVC04p8m0tWTEFz3VS96TpkfpR8XCZz9IgUqoJzpS2mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87W30K/p4IsUMSNf2FnTBaJ7L+zW3tRbDAww8UkJGb0=;
 b=uarIwWqA42Kp1mo9a9yUoKDhbwvcP5V/h/ylNq9PDUFXhlatqn0vZPXOQWE4MGsDfX0tGyNxRdQfU1XGTtFfM4ydGNYbOON7CdoJDXtUr98Bxy//URwU31spYJ94b+jneEhfzzTbN0rc5sZqwtf7X+ECRfmHyDF0hoRimmFhfDe6KUuGMS0tuE72zYq4ojFi8AXXVOe2/EIQaMXGpYwumDCBj/IIfTRXTWzTf6aW9b+fXzKi5ucE2k+WePy8/ACYU4G2B8yd4/0WgK1tMFuj90IyjeVTTmfbTxBND2znzEE1UkMt4DmYDa8PkF6dWNONb+Wr6TMM/UDqiik4YY3cmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87W30K/p4IsUMSNf2FnTBaJ7L+zW3tRbDAww8UkJGb0=;
 b=MeIJjZhpeFi6tgg0xDQF5SxuALlz/rWoKgHC1C8EDoICXmum30a/xDwqisU2yayLA+th27xE8hb1mBbQYlfl77jE2YI/fAwXkbcsjoXT9S2epL3uo41+1UZWg87fsgRP/amx6w990unwfJZHM35vnJc7tQr8ew36Ayf74s0d/EnXBKRRPpguvAeqVqxVrAjkr5X74i5A1T46WnZEbriVPD2VdDGhHYFwyhFEld2QVratJT2ZkTRN31VgqnMddisR3c5LWCgIwkgxRQVvdn/4FHe9+tCHi1VpJ7UonJiTCEP8Ix4WHB00WoWg7onAgegRP/zfGp7UG7txszKv68f/Hw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by MW4PR02MB7154.namprd02.prod.outlook.com (2603:10b6:303:7a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Tue, 14 Oct
 2025 14:00:33 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 14:00:33 +0000
Date: Tue, 14 Oct 2025 16:00:26 +0200
From: John Levon <john.levon@nutanix.com>
To: Alex Williamson <alex@shazbot.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PULL 25/28] vfio: add region info cache
Message-ID: <aO5XeknOrUtvLJO9@lent>
References: <20250509131317.164235-1-clg@redhat.com>
 <20250509131317.164235-26-clg@redhat.com>
 <6519c5b0-46d2-4097-bb37-7a78f9087f68@redhat.com>
 <aO5RAIX6WI0MerI-@lent>
 <cb4b8412-f1a5-4c7c-b2f4-d65b72194412@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb4b8412-f1a5-4c7c-b2f4-d65b72194412@app.fastmail.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P265CA0256.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::16) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|MW4PR02MB7154:EE_
X-MS-Office365-Filtering-Correlation-Id: aa6299e3-0b10-4930-4342-08de0b2a0b0a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fFil9Az9eURLAd3QcpIJs7vnNlAqNGYLhg1bnNE8+n8vUEuL4e/E5V/YIuqX?=
 =?us-ascii?Q?0D8qyxUWVWibbrDcN2ehTmd+i4KnOhzgScGy//Zfye6JpAwf8MRKD8MizlU8?=
 =?us-ascii?Q?KFGjngdavDaZ0ZmUHF4NABHy6St4aHI1N8aYVR7XJwewuVgudKeK7GjSO0y6?=
 =?us-ascii?Q?O7rjMUfFM7F0l2vFxP+NthFz52ljz0cwDpTL2GYKopWgWcqmMPD2M8AIPXi5?=
 =?us-ascii?Q?Fy/s1ofyAt3SmaVD05ywAsEhl2zCTFIo34Ho9Q6PiBzqnVqZWKjB2apeuOXG?=
 =?us-ascii?Q?02wxZN4XkthrZqpyGv+uHB9/nFPIbEBy8EfN4DwdFfDhNMCHGd1vBDrsZPRP?=
 =?us-ascii?Q?z171HjXjNzPI+IBTLKfk8JwvBE1w88PVce7Wx9HRAMl7cwZjUxrmLy4ooHdd?=
 =?us-ascii?Q?eBac+ODZ6xu96k7T9F+q+Db82xizttIU71vGPtGXMr4OWYey3HsHkXoU/dla?=
 =?us-ascii?Q?T68RhGCyuS95isf0HLQCqI2SR+nGKiJS8Z7xAG68JkVY808hXsfUFawD9Xz6?=
 =?us-ascii?Q?t3cPxR/u6XC/ZoMw6kw/tYPJrEKr9yXIo5LxLxfhVPCqxoZE51nlII/bGb/J?=
 =?us-ascii?Q?/pbPstbmvjbIP366gMdlVIpUhFtpJQNw/Y82nRluYyVcWX8hoAvBRj/0ZzVc?=
 =?us-ascii?Q?BJJnLdZuj2H67AeGTlLffCsL+EZ3bEhDRAOd4jlMSz4oanBFll0Z/lavuos/?=
 =?us-ascii?Q?g7WMUeqovcmEvMWoG/zj5kfal0vNjfI37NmHNHu2h4rTK5xUgmHzDrWMpPO0?=
 =?us-ascii?Q?LtnNzM6cuJuCqI09WPs66Wm3MGIaznTAoqhuht4gVHbdRB/BlYuUanUzbP4i?=
 =?us-ascii?Q?IBTFafj43G9k3qgqK+e7fA6hkG1twFOc8qRmhT7QXWzhy12MM/qpiIiNqCKP?=
 =?us-ascii?Q?KIxRePFZTYAr0CU/Bh2H2zS8Tf9t3FHM0vs7Uta33Dy0OOtG3KBHC1XirsrY?=
 =?us-ascii?Q?oiNp3fffb8RQ8BX+kHNt8QQsx1Pws1MfClOfazc4u61PYL21H4lKvC8CNrDd?=
 =?us-ascii?Q?I1yoSsWMBEyz5wIgCH0640Xi6Py8kz0kKobBoL868wjnOR9kXxRzFsBAa6lZ?=
 =?us-ascii?Q?yk9dCdQrduMNaIcNjXUIfwfG48udAMVQaSMeEKEEKLcPkD/8k5EdHO96giI9?=
 =?us-ascii?Q?j0+l0PZlBSP/5rgbu2MHEDO6kiUdiDJHWsH8skKvvUmFDbcXIIx0Xq0h6Dph?=
 =?us-ascii?Q?dwUcqlYrmRMALrVu7je8lLrbEuDJAZtJLr/MyzjwdqtyX2LEpN3+eUUK6RgX?=
 =?us-ascii?Q?SmhCJ0ylAqYruRAUFG21io8upSJWK80REorSuZipsiEPwN5hDPAi2K+oQQ+M?=
 =?us-ascii?Q?bVLvYkL7ri3InACG0W8C+7fNEej2mB5RkrDmvlBDZDRm0ezfYEg9CwJeGLkd?=
 =?us-ascii?Q?pVdENHTFMHk6Ma2y4BGarpZNto8bUMeeD0YNIp+BV+d+38tCL/scQwhJf66z?=
 =?us-ascii?Q?lXFnabf3BbIaIYhWpy+UGUJYkIF41hsO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?puNkyvXvnwV3QuZL7Fdt+FDx6Ytkrhn6c6YREdCrkIlD/ay6SInLGOUKwcKg?=
 =?us-ascii?Q?tu4yjQ/KayjeR1uY6/Hcp7a9iadT6eNacmS3k/rZOXVBpcbp/nOAqBJCxWaL?=
 =?us-ascii?Q?eWuxB9VPvYYnY5nOPUbdejLlhL64aIelq8zzDzOzDKh0kYe3cj4m7PXBopV2?=
 =?us-ascii?Q?YFGomAREC4d3KI0XFTJMYxODKmDsO4ipPpeH+zjYeNvJXQXgN68slwHmGPjG?=
 =?us-ascii?Q?p0tBuYyqxuiPAOiXOBVdNuaSUKVlUQDX7DjqR6RfEWavIFrCZS7nbbHreTXt?=
 =?us-ascii?Q?+NpaIkgJgyoSH6zSrQxFzRLV9jQBxXXQDvy6FXfrCOT9wPaRDKv4arctdSrj?=
 =?us-ascii?Q?DIhgvDn+XTJVuPNFb+KDhoNlX3+vCYeUquUzLmd/qyf24xNG4H02POuotFpu?=
 =?us-ascii?Q?Z7TFIAOpEVD4ohc7p5EIeBjBi6oe3oYA6eY4FWSn2/bdHZSlIG9jspenTuqz?=
 =?us-ascii?Q?7CGnfuLc3CAjqAsAKMcbNSgFLxfdvdH7allFehzFvpv+j0zmQPfH9lR4AzMz?=
 =?us-ascii?Q?HLUtGetJu/U4y+AwTbId31Y9AdM/J70k3o6JorYQBZDwH0hH5zDoJJz37rvo?=
 =?us-ascii?Q?IVGW8r0i4OCF1kNRBiDoHPuexF0c0RrsjeQEcunbOqWF8roUmPj05OPgpo1J?=
 =?us-ascii?Q?pq00M4MAInAXfBfL1g1QGgsJUQ8wA9W1g4tgGi2wXvPEcQ1cXxX0hcTV7/R+?=
 =?us-ascii?Q?75SXBEpuSYWWV93CWEA32z9MzTFrswR9IFkGyJBO8kJrVZpRpJE+pFpEgs7T?=
 =?us-ascii?Q?eSOHBJGqaWe2OvZkAyk4xgEDwosDPRuyQtmJiTMpCxZmnlQBpxjj3Wg+l7F+?=
 =?us-ascii?Q?/Imq3z5dz23JsrLzmUhh8RCJDp+x6g+x2sJ0/MhmHkzCBFEZLfBz5DMkSQG9?=
 =?us-ascii?Q?6ReWAYI7qtfPQovVEjt9lZy8btwPT3zzpUFVgQMOfK8FFvATOK12HMacuAPe?=
 =?us-ascii?Q?7SPjL/V2nQh0VCQJYZQbEcJlLP6PwjzttCxTI7W4mGHo5HNzLwj8rgTLVSk/?=
 =?us-ascii?Q?nRnKKGhb8+uUrDygc4VmhSfBfnhduN5yDsMlEsCU4iEKMYGh33eEj2XtTK/+?=
 =?us-ascii?Q?7TwT1S+X21MuHFXzOMdRl7x90ecU5wDhgF0WiCaTUfjFqpySpx8e9EE4alzp?=
 =?us-ascii?Q?4aLYb5ukgNjMViBmV7pYVNzHKk36HdoTFb8okpsQGHjjl94+p0zP4fhJl2bW?=
 =?us-ascii?Q?mCBWcXrsVD5bQblUeIXuQyOn4swBl4jKtjh7tYk4R2M+plr/zGb3i7AK4NGF?=
 =?us-ascii?Q?v8oZnT/SQ0Umi3p0LuVp+jECPPpKoeHulpA1hEX3SyQ1EAjQdobOgQjmGkAu?=
 =?us-ascii?Q?oygCUlsYCzA9wDkXhN2DRawYeSioCTcxs2jN4AaQ+S+jiJpolbKfWuJCvnK7?=
 =?us-ascii?Q?36Yy6sraW2IwejZn8x7LFomRgT+eDm8CVGdEIvS6sipH+12XeVrqPJlQScUt?=
 =?us-ascii?Q?fu/NpPAdAVBy2PeZamOZDSwbZZLp8WOaDfQB0vowrhci2l+jsV46S8pl8yHl?=
 =?us-ascii?Q?MkzVO4Fhnm1DlOXl4h75+QYg0YM5Z+q8XlXLMKEPkQ3U0C+q2Spa/kpteXln?=
 =?us-ascii?Q?YWdZ85KrhLgmkZuyI15Kfb1bWGZ6dcuYY97snrW6?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6299e3-0b10-4930-4342-08de0b2a0b0a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 14:00:33.6454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+tV6MhvSRJhbxj/EUI/YIF/OL8QlT+k+1pGcjQPuRWYGXmuqYsRlbI3I1+5vvTWjc6ZKK5tUD7IVYeDPhV0ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7154
X-Proofpoint-GUID: ed1hgVAkNHJ0TvkMCkCzdCvtMJni9Dj8
X-Authority-Analysis: v=2.4 cv=f5ZFxeyM c=1 sm=1 tr=0 ts=68ee5784 cx=c_pps
 a=iImJYxtVBKilH24NLj+lVw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=l3W7m8C5rxN6rtHV5zAA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDEwNiBTYWx0ZWRfXycrpGVErAgl6
 6qn2o/RCUBil/imlHELpTfbCBT4wzLGqXmZ/c3yMa6jePU3apOCiUIRsYwKHnGrGJiISnq0nDJJ
 AyDwhOcY3fNAt0c4wmFJcHAajyfAh6tXBZ9hDQqtyVDClCbLmOOwIYYvDspPkn8uppowRBhJNWS
 TMZIEkKK6p1E3vTwTVqP0awyi3a34IvTVfY4A60EwOLuRUarbFmCXJ/xDAsVA2Oi5S12k+4aLPP
 uLoXhYuTDYuIvwAPHl0+sTo1tVqs0MG93+vxnjKNunLDFLDX8YkkyELx/nqHi66EZWQ4FbPPtNO
 4gudSbDUoTf7WV5MUPHK+8O75xsZBkQ+JGDm6Y3i9U9Cr/pXINVzGXBonMZEA/bSFnM+Cpw13uW
 n9104BpGva3BcUu15m3jqXtvz3OtVg==
X-Proofpoint-ORIG-GUID: ed1hgVAkNHJ0TvkMCkCzdCvtMJni9Dj8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 14, 2025 at 07:49:24AM -0600, Alex Williamson wrote:

> > My apologies - we hit the exact same issue internally, but with a much older
> > codebase, so I did not realise this could be an upstream problem as well!
> >
> > We put this down to a bug in the nvidia driver - surely it shouldn't be
> > reporting fewer regions than are actually in use. So we applied what we
> > thought to be a gross hack of boundary checking, and not using the region
> > cache in case it's beyond num_regions.
> >
> > To put it another way, the header file says:
> >
> >    217         __u32   num_regions;    /* Max region index + 1 */
> >
> > If it's not actually the max region index + 1, what are the expected
> > semantics of this field, or of region indices more generally? We could not
> > find any clear documentation on the topic other than this comment.
> 
> '9' only defines the end of the fixed, pre-defined region indexes for
> vfio-pci, ie. VFIO_PCI_NUM_REGIONS.  Beyond that, we support device specific
> regions.  The GFX region is one such device specific region.

To be clear, nowhere in the code are we hard-coding 9, we ask the underlying
vfio instance for the num_regions value.

In this case, it appears that the underlying instance is returning 9, and then
trying to use index 9.

> There is no fixed limit to the number of regions a device may expose

Sure.

>, nor is vfio_device_info.num_regions necessarily a static value.

Ah - is this documented somewhere? And do you have an example of where this
varies over the lifetime of a device currently?

IOW, are these devices actually changing the num_regions value they report
sometime after initialization (namely, can it change after
vfio_device_prepare()) ?

Or would querying num_regions still return the original value, and in fact the
semantics of the field are "it's not the max region index, but the max region
index during initialization" or similar ?

> We're currently discussing a uAPI for generating special mappings to a region
> that could dynamically increase the reported regions.

OK. Probably should rename the field to ->num_init_regions as well as fix up the
cache, depending on your replies to the above.

thanks
john

