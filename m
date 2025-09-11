Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B86ACAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 16:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwjtI-0000td-LJ; Thu, 11 Sep 2025 12:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uwjtE-0000jA-GL
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:11:18 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uwjtC-00075e-IS
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:11:16 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58B8cqCf955221; Thu, 11 Sep 2025 09:11:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=lgeAff9qXqdb8RS
 aA85P9dGxWw6tBrAQ356lmoVbBaE=; b=hmXC1vK1vJZLQsJqpYVb/n6K0cHV4iX
 058FFNR6U9heo1py+9JcRowc8N2T7ejfJ0XOLSjd5v0XIwORZm3XGpochCJo5MCP
 BwczQpWl1GVE3gfmy6xq0Jyies8/D/VrVpQ0IRPLvv+mFFSWHgfjmzdQ6L1FDOlw
 p2D9rJV1QR0CcLiZo2EmO5mntwoYlKx2fwkyOEFfzxyA9+c6IqLph5ZgyXMbf/BO
 MfuqQNUBYfossE5gP1tCOoh7El/JCRTpkdb2tH4VEQK8GKLdwndJvYFCjzrdiLmo
 91EFGNwvMdLRiVKfxvW87Li/5HeoR31b9sehaYLL8lXUWhktSBMnI6g==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2114.outbound.protection.outlook.com [40.107.244.114])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 493fun29pe-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 11 Sep 2025 09:11:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdtPT+oLU43dKEjyv/ZZRY0qc8J3+UnsUyYA6y2IMEOq8t/0Ho0ctU6YHsYrn9ShAkP0i93BJpDipSmCuxrmUTtbs9Trz3AwCf6T+hc37QdKmFskh4m3KH2kxumNpR+A8MbX8s79xDOhnpvks5wqkCNb3tW09zWV8ic5JNHlDPcDXDdGnX05v/sDdQPXOXqdzFzVhLyWf6gGag+s+3tAMagTKmGU5bDNQbquxgLOy58vjAYuQj7kTHQAX76v6ANvZXFqZyCGZgMhZfRvzbTC1KbTLUP+CUa3q6/IpJjCZszgY9egfMXOfqvD9YxF8Qh375fsIXko4UP482hrm/RF6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgeAff9qXqdb8RSaA85P9dGxWw6tBrAQ356lmoVbBaE=;
 b=rBmnwj9NRv5qG+dg75Xme8g3luscx1wkrDEnzHP6JXbxpp6qmHucpGVLVx6I+fWOt+SXz3Py6eGoQsvcoDvpU/qj/wBjyb6VvYQy+M3pjjmqzeOuyfAEuX10wp9NSiy0o9auAwB+ERfaqm8W8xf8CbsLa81aUwIv9a6KFaMC0fPiAWSVAQ7+Ys+tphu7qJ5gemysqp+tVz65qc5LoCHUKuhvlOZQy6ExSPcpiXoUibRxAnCpgZSNIDt/Yo/a7mguxOaweXBHYFBxEqMnAxy5wPJ83Q+FyjycaiEwWIENYnV6BwALw7PJLgevCiAqyBUQBuYleAfW2F8u6KGNVKb7rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgeAff9qXqdb8RSaA85P9dGxWw6tBrAQ356lmoVbBaE=;
 b=uV0V/OWMFysHQgmif4nRMz8QPFOYC8tb/sa32/gsm7Wq3PRp8yyk6owSBjrz/YDUws7StFBS/qvtt2POsYn5PCoP9hlzsxf62+eXwwVEp4fMh9wAmWLRpLtiDcbuSRkyQOELXBfJ9sn0sR7QfrgAI+mb0PIsyLa4EjhktwV9hbHE+ylRAklNm5PtPbCrkbU4draVXm+qkRIo8dNqriLdj9U5GhklsAjw5qiHZctOQ3sam+i6Pq2Aex457/Nh3cjS0u1OTs+xlXcorECRlgz7i1jG1dJxjvKvvhZhXQuzhCoC6ceHAvUfiLjQskhBlPjRAoYWsjuOGW8hZSun2h0Vig==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BY1PR02MB10506.namprd02.prod.outlook.com (2603:10b6:a03:5ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 16:11:07 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 16:11:06 +0000
Date: Thu, 11 Sep 2025 18:11:02 +0200
From: John Levon <john.levon@nutanix.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [PATCH v5] tests/functional: add a vfio-user smoke test
Message-ID: <aML0libYHIsteYJH@lent>
References: <20250911142228.1955529-1-john.levon@nutanix.com>
 <0d71919b-d5f9-47cd-9979-a692f3cf6a8d@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d71919b-d5f9-47cd-9979-a692f3cf6a8d@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P123CA0022.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::9) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BY1PR02MB10506:EE_
X-MS-Office365-Filtering-Correlation-Id: a2547e37-496e-44fb-b1c2-08ddf14dd02f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nUFN1gA1bAWYxvvn+Yo/bXC0ugM/Mo3eroKfeiY2G3AlUNSCKY7EAnw30RaC?=
 =?us-ascii?Q?r35ksmTyi/K5X604+uRmF66qqOCspvTDXDz2CnYUl3DwsIvGjmEVGNH7adLK?=
 =?us-ascii?Q?AUc72KIV/4U6TtERupmyAAPkW6nndlMj5DHR/H4VzwH0eE7dT+UJU+9SB1Tc?=
 =?us-ascii?Q?EtrF89Bykn8SeBCx+CcbdJDm7dgYxEJ7byNUghBWN748YOqHSrSHYWXsHcoA?=
 =?us-ascii?Q?HevQCXACdULFlQTRcN+A0L75Mxlu9wRgyl5Q5DoZeZUuKewnJoNfKw8hgYsK?=
 =?us-ascii?Q?vc8t0L8p/LU3kwI+88QsJcBR86xRPCe1YouelPsXAZrJqOi4P98kIM5Sr8qO?=
 =?us-ascii?Q?+v0Ely5w9fYRA1AMzAUEGMN2S2b4fYg626SYRs+Jv01UW+er/7dO3j2/Dcs9?=
 =?us-ascii?Q?GvLrc8T/tr+7gKB5y8O1+s0e2KTacN9NpZhHA1fuFiRcIf/ixdN9NXoSj3gP?=
 =?us-ascii?Q?MQ3GEmalv4vKg0N5+eF21bDogEi26jIa3v3plGYEyAFO+8Yfnl9lXMqMi84V?=
 =?us-ascii?Q?oJubhbUD3iHgxfrkfgH5TJUAC6quF4B4EZoHaFsqLzj6ANgLPvwyktKL159X?=
 =?us-ascii?Q?Wr6iXlX2ZdNKlw0IvqelMt8ErpKhJy7tUYimAJKUVG15er7SenXNTUmAIfck?=
 =?us-ascii?Q?mPZxY7HzhD/NZUrBZsjDiETTuPGhIWLJOstE/+ckVR+HAKpSNa5qmESi0QtX?=
 =?us-ascii?Q?LzUlZ1irrxNc5cXM7UHrxmeiXupsWcDqQavV20EW0TuqmZjgLSQubStTo4M3?=
 =?us-ascii?Q?6kS04B+V275mthRsOIEXb9gzoL8GnyCHiVHORTxxWk3gsly/iGrRTvGWg8Ky?=
 =?us-ascii?Q?dnhDBE0KbmIcsaBWICBuQfWzPCc9ZQjhdkQDTHi/8kZazSZAaBTGBCK5f/rs?=
 =?us-ascii?Q?fSgU3l02whrYLMRsudG3CkYbHz9bYVvLH0G5/q6s3soX3GHn3XaWe3neA2y3?=
 =?us-ascii?Q?QMK8sBo15FOXQwtuFfEMuxtluqTpf18qQ+icQvSfxArcb08MCE9BHu7BsodR?=
 =?us-ascii?Q?JDmtBR0Bw80vKfJZOr+NYZ8st6Kg2zfo1Od9WLlkjlBv09O+wSkaTuDAxJj1?=
 =?us-ascii?Q?41EXReRbUo9s6W7mIknJcsLB32SdyMuAPuUTEeXqAkFefC7UMI/MQbAykeAU?=
 =?us-ascii?Q?MHc8QzYX9FfFgeAxajbYXAp7cV3jwB1Jb9fOE7aSdol57ySY/IK+HnlW1GWd?=
 =?us-ascii?Q?n79PFI3b1rhkGdexhk0UEDrIlSv3R0Gutph3qmDuSDjwkHOnZW/ng5oBfSMz?=
 =?us-ascii?Q?kNfBznfx0DG75kh56x9NGfVAIM9tCE60onYFLW17ssz/Mu1fMs+TsBnbLSPR?=
 =?us-ascii?Q?E+6mN8JqxQRWGWgcFzSQBySH0TwE4ROcy4PHM7TRT/LUb+KxeSShrOU4aRKK?=
 =?us-ascii?Q?gBnwFFgMXvXxMc8LrKbouPZWFNiM/Z6AAQ7mrwyiezxuzU+uH/LEHcCLG2+M?=
 =?us-ascii?Q?dOxsDaFLvys=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TwZuUgIO8vFTgHZiUA1xwtEZjT9OxEQ0PB+I5NNk6GnLFFivT0+JdnjKSqC7?=
 =?us-ascii?Q?d9vT5gAHdr27EdEv/GvHcErnkybI5VOsnOmDOVNGJdBh1Mf7ZufoNcsDCXpJ?=
 =?us-ascii?Q?MGyvhpGkMqybU0RE7LLE9BH+MxUJILY5cpTbRMWY62ybcF6cX8Uv6Wnlocle?=
 =?us-ascii?Q?TpXqp5BHltY+0uGw8Qk+iXChCrL/QLuFU4ipAIoAK1DL1q0h5oP6e+hr7qxX?=
 =?us-ascii?Q?0tgERzovtbB2OR6fP+yV2iklaeSUc8V42zIFKMf1fELA0GN7sUfuBs/PL7r+?=
 =?us-ascii?Q?OoM3BwbSpx/B/z28lBXUGFoiFOjwpLILLBkY8xVdSClwj5uiiDt9hIc394J0?=
 =?us-ascii?Q?w1I2VEn3RAgnkoknxi4uvVp/nMeXWBCExPBdTiZHKNawWpAcJgaxhr5zWhUz?=
 =?us-ascii?Q?5nYsVW0vb9Cp5/N9mJJTwdxyQAEno+gwubmzvdFF1X3Ff6n1DjYLVQ8BYbG7?=
 =?us-ascii?Q?w2pMJr6WAerasK0j6Kbk6Y24O158bV5iGopSdPSNwXDJ13mkB3rI7lIR3eWh?=
 =?us-ascii?Q?hUpHwiBiMqp3iC4M38mKYi5REs5YBMELay+sXQ8yGQFpWvCD6nhTtX1lwPrI?=
 =?us-ascii?Q?Clze9VBg/AP+PRQPGZ3yRKdqFRDV6CUdrfzp2yxLp6fBsY7YCwctwsWomA4i?=
 =?us-ascii?Q?uPXb9wRHbaJ51/wIoJ88NAifFU8o1Q5JbU8u9GJTDkUaAm3thdZO2j+Bk+LK?=
 =?us-ascii?Q?nkVH+Le9L1G5eYyXNIM58QJaajd4LK9BTiHfokNwEITNm7+gZ0ZutFUgpCZs?=
 =?us-ascii?Q?X1A+HTuU7Mz+3VA583iBBarTNxDHehnsN1lJDbqq8hbSCLyQXTZPgRcYVZJn?=
 =?us-ascii?Q?ZncONUaiddKeem3kzeIpltLHDpkgr+sKl7KySmXFw9Tsm7s1GsVvOSwjsw8j?=
 =?us-ascii?Q?YQXTi5LBEfO7sCNveoPgeFd7j6Qbjpr+2+XusKQAOr4ORL0MNqlvWxdbGQ5Z?=
 =?us-ascii?Q?dEos9/IwtLCC8bh2L5yzpy1vE5D3H5tpAHFIgJLHKeBKq1wH5J5nKpf3TcR/?=
 =?us-ascii?Q?SlnHwbMMAMo/0MXRQJkz1kDDVZCq4g6AcExobIw/sV8kkOudPRz8asij4n1Z?=
 =?us-ascii?Q?LVRQlj2HKYWCxxoCHeZCDA6LF2K70KXzNRHSRSu0O8kaz++mKRRr3GMjAx9W?=
 =?us-ascii?Q?I4SDRD+jIIIta5Uj2I9EySmUItekNtaOlcgVL3/qYmv1geIIKm3++1EBWSwy?=
 =?us-ascii?Q?LxCma8UjovV6ZOhhY4rtkgrpd7g6cRv3KpOtBMVP090b2Bha1Xw+I3v/joL0?=
 =?us-ascii?Q?tdmBcIKXyzgGUTkpFfwIRtwA78a776VQhRtZVqXyAHI+DB+3voRuCttrE3SA?=
 =?us-ascii?Q?Hgc/+73rfeO2yxnWO40qZFQAnQeynzesQY65iiYBAYkbwP2GRDyWZ4xGO0sz?=
 =?us-ascii?Q?PVqjMffWTVF5XC24Ge9YdZ5IFBqu5paBORdfvTGaNI4qXloy6tJ3D/83XVAz?=
 =?us-ascii?Q?uhIv5vpFM29rul0D9HXvosphtbQj9KX9sZe/c5nUW7XpxrrUdioxtjKoKLm+?=
 =?us-ascii?Q?4+gTaJ2HfNUjQ1X+lQirCsHn/G1mdrSR4VpNgiB+4Iu4tZpOJU9TfFVVauea?=
 =?us-ascii?Q?WQuGPyqnXl2/ldRMYMeckiEWo3SqUiPviDIvxrhm?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2547e37-496e-44fb-b1c2-08ddf14dd02f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 16:11:06.6198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PwQiAa1ispOvUNNm/Mwnn1Zs92+0n/N5E5c2+Tq7msHUiM+I42b1XvWNYIOKDANS2E3kH1X5vV0FqFhIc3wPkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10506
X-Proofpoint-ORIG-GUID: ChVOWdsXWMRblWx6n34_SjBe_xFOTgnJ
X-Authority-Analysis: v=2.4 cv=KrhN2XWN c=1 sm=1 tr=0 ts=68c2f49e cx=c_pps
 a=got6q7fWVU6QhM/OxcbtWg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=2RzJbV6ya3AGQgAPwUwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: ChVOWdsXWMRblWx6n34_SjBe_xFOTgnJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDE0NCBTYWx0ZWRfX+KnRs0DuoXzV
 Xf2IGWs9Mo9UYpXtGaYIAXYZrbr7sOJGaJ6TspqELd8o/oJK4fB14XvIxJL99u8bgrh7qj02qjf
 KPI73LryuFDDzQVQd0PPSU8EQT/rud5DAvnUKdcoWY0vFUXAGX+DVUP4tlJ2+3i71j0JDoMQPvW
 hMrctlNisZeJo+ZGOBZcYivDeQJM28GsnDhu79eeTPfDeo0Fa0PmDL6mpilisbB6/H8/8r6tTOJ
 YJruuCzglXCDwFNG6XK3rOTClDp+zLtoxuIc/fkJNQXiQ5ZGcA74ht+tXLZB+PBusQ12PhEIDx/
 gdMi7J4WQJhZj6aADT4pzh6Q8QMAxClS3fN5SOLp7sPX2CWQhLtOjek5MZhJp4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_02,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, Sep 11, 2025 at 05:27:24PM +0200, Thomas Huth wrote:

> I'm not a python expert, but I guess it would make sense to move that
> description block next to the "class VfioUserClient(QemuSystemTest):" line
> so that it's the description for the class? (that would fix the "Missing
> class docstring" that you get when using "pylint" on your code)

Then pylint complains about the module missing docs, so I think the current
location is a bit better, and I'll add a single line for the class, and made the
file pylint clean generally.

> > +        # wait for libvfio-user to initialize properly
> > +        exec_command_and_wait_for_pattern(self, 'sleep 5', '#', None, server_vm)
> 
> Could the sleep be avoided? ... it's still a race condition (even if it's
> unlikely when you wait for 5 seconds), and always sleeping 5 seconds slows
> down the test quite a bit ...

Currently stress testing a loop that just waits for the socket to appear, so far
so good.

thanks
john

