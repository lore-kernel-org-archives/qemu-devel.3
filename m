Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB19C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6n9P-0001a6-Go; Wed, 16 Sep 2026 06:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n8b-0000hy-GZ
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:15 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n8Y-0002pF-U4
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:13 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68G7x6qC579616; Wed, 16 Sep 2026 03:45:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=VGDCeduTgR2HUCuVX9bXOtAEkzXf6+m9yLeGk+5Fr
 i8=; b=V8DF21NKiAi4zMAehbr36+SVQSsenEC6bZQdEIdWjYq9akjE14ipNXVRh
 hxYRTKkYynKiFzp7CzGni7w0bAXRsTmwEdCjjVrKSHvN04mQhBCI8lb5YzJkHfgf
 E1bkbNMgseTlt7Dnr73coich9UZqeEP0OTPblcbj2a1fuOKFOK9mf/DJEGjB6dtY
 Iwxbw4EgRyv45QZVLQMXoAb7x8Yiijd9d7MUFKVq8YGCiXX0fwwy+QeUxb7lhfII
 +nvWtP3M1U/23vzbNlijek+IixzTWZ0ANV9PcaYqQLu3dS6yORx4Nm0uFuIWUvVb
 aixgAoW0nj3MDvNEP5Tjfz7WKnI+w==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022116.outbound.protection.outlook.com
 [40.107.200.116])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gqbtb9yac-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 03:45:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qkf3qoHTf1uYCMWPKn/7dEwabeJMIL84DzBmszzeq52iG2Tsbbq8RrhN0zEaK36edHiExhKiGKmHkX0+nBTUVz/AxtjwuuhcScOupEc/qjTb+cx5b38y66PwesaALfFjvb7svLHLI0EKPlABgBs3xZ8BHGT9mATnwlShQmXxXeT4+edm3jxQSt+h3DHpNUEyM/QqEMzQMATwCLGeuCoEC4fIdjQ+daTK+iVqttoowqEjVBwYmsZAyYU1hMApNCGWGV552mm7+xeTvfTwGz0AwYExQaV8RPR3I0onvilrnuGE+joueMvQXWJ7iXZaFWFzoGVUZoGlHBcPmNJA2kwqJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGDCeduTgR2HUCuVX9bXOtAEkzXf6+m9yLeGk+5Fri8=;
 b=FlPNxqKbSHpP+ECI5znJr/uX14A0i2zeTs3jxziaMJL3lbriCPYtwN4pdySX2COR7bU17MOt4lA5dBHKYTyi9PzZatZHz9YZtbuqBmOU+9FQ7SyKTZA13r6YQh3ZykanInwbyKVWw/cWJNda3ShbxrqyfSzdJwTKEmpvnI6NoNTrpeOMFVNH+VTF4I8YyAkI39VHXOs+Y/Og2ly9m3q8EVa9+J/AwU1NuAXmA//7o+b35lK7UJZLvXYg7M6+eIGw5iV5SJKlkfD6gm40foXYeV8FfTU1wRjX1Ge/VTxiPtFR7QWs8/qh7b2lI9DzWDXVgYy9f7gVwbE7tBZ6/SwFnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGDCeduTgR2HUCuVX9bXOtAEkzXf6+m9yLeGk+5Fri8=;
 b=h0MBpQsVoaayr9IABN3DQ5XMLKTKE2JoFvqkNhmNEkc0vXvC0hoBiP+pIdhEfE2QuCefZqKFxdfnfBZsdJ1Glvp52Lc7/m6S4SK3on9ZJYNP11Eb7v5yx5SdtuJiByBzu3+qWDi+/c9XoeFniTvmiU6JNIqKqx1sjNH2Wkf8fvupB/BJEJ2tMQOhO+7PHynqBmO1JBrL6gMAuGAZ9XvDbVy4ysgnTgerYLa7RpleQCLbXBtTfR/R67cK2HPLWKYTubLK9Fi8wAnPnPuKEu21nBeOSqlKS2pJN4iX9tx/6oLHuTKwlBKtcMySmosTJIquduAc0w0Xeqv2afX/eSYHLQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PHXPR02MB11343.namprd02.prod.outlook.com (2603:10b6:510:3cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 10:45:03 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 10:45:03 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH 07/22] i8259_common.c: use i8259/i8259_common prefix for
 functions
Date: Wed, 16 Sep 2026 11:43:35 +0100
Message-ID: <20260916104435.600211-8-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916104435.600211-1-mark.caveayland@nutanix.com>
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:a03:5db::9) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PHXPR02MB11343:EE_
X-MS-Office365-Filtering-Correlation-Id: 4146b6d7-058d-4c5a-1d2f-08df13df9056
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|10067099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: E5xM66L2oDgB8wvZ+4HEIRdGsSbN0BUCrz5ut2H8axVqyvIdSv1NDJgjAMcVlsPCXxPUigtCy4GqYkHN36PyQ4FoYVn8vmtyupqT/TGE8gaNCvd0A9pGp//kjgMOfC4JqAYPYDpL6pXEgN8O/5gU3gd59ZK4DI4ez7RnBShEVHanjdgFZ51eWlwslwD8hpDBD+FG2ukErHVxPfHskLIkaNy5xxNP+EqI2W2ChysmZC5v9OT5na3vehSFyBMKW4PEfaLkumxyhK11lfYv2V7O0qmy/bGRnKV8saDKwGoLQShjtjXnX41f9xf+5m0+fxc/Us9VjeTMmGs+dgCVNPuppn9jC7PmB2QsOSeJykr00euRQl5TG96Hdwl6AmbTQo293Y3aXgK1bvWJWjDYVfoZzO+Z2Zj8Xc72QVv9vu8/rKhRURPgW3wh68rH66hiAR5p2J0tpD2esIwB8rHj/gsDoq2gIOJbUQX4duWG/MY/zZqw+RJOUqkBKeHCUICzFm2t9+KxbVVyIJt5OdzWUriPWfVu2/ED7zNCWQRlTH7mfoJURw8GSllh9RfV/1nCiVuR3UPYec3qoT+OigX98vchzuNGQgl97rwKNvginQGPzS78PuBuZ1zgejG5Wg1mOjWCCdS0XykGizyjHV4wS049wmtFr50eshc8/ty2Oa3BQ6s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(10067099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1IlOgYxR/ObmOBJp62O2rQ7nVpAlWy31BHH4tmbhF5YMBN7zB/4HWZ9JGEfw?=
 =?us-ascii?Q?kIaeDTTYY2mSIp7CiXsrRAfuL7zhdflnwWeTRy4bgX6CK+OGVawT84iAzqmW?=
 =?us-ascii?Q?mANNh5Usq9+d8dYchmTm0Jj4NrhvKvYUP/ldY1ecQ1UrZAJqz+VGAJBZRB+n?=
 =?us-ascii?Q?GN1U3Au1nVQdIIYTJxURpeZpZfQnqfQwbZnlKCGoNBr3AW+O4BbvErzCUUNK?=
 =?us-ascii?Q?WTNNBa3TaCf/A56B+05R/2SmaE/rO3s7EhtHaRNKvVBwsEODX9zYhWsY8pHX?=
 =?us-ascii?Q?0m/ovZRSv6ozsNV+vSxc8d4c3MBfHGA2TG3rNeOZmEG79898wOO62Ul7zfLN?=
 =?us-ascii?Q?QEELH0RFYsVizmdjoOtcvSC66d0MM8IJc9YR4h6wXGSIEOAVM+5ufJ4H+4hM?=
 =?us-ascii?Q?254EN7HzDqIySt9GXIOe/lRBbUADgHuvgZ2bjB0yoUnLAzNkdN0RPi2lMzJ/?=
 =?us-ascii?Q?wh7U+T00tW5RIITj1uGvoEFGVFRfVmBWXVqImYZA0BO8j4Z+5Zy5f9HtQZnF?=
 =?us-ascii?Q?CuzbvVyhrR5/pqtZei6stA1vSRcg2W0FA3ux5RGU1RJgH2R9+0XsHHFss2vB?=
 =?us-ascii?Q?hTMuk7dYJSvpSuInpj6WNwT8XYXuq80P1cs7VSgbm+fkch+62HFJPWdPx9BN?=
 =?us-ascii?Q?6kWeveGW5CpXfKGfCMxE/qGcBwN69sBLMsg2hqH4MD97r7xSvevLwJkfLfzK?=
 =?us-ascii?Q?+NaysCYuwsh473gwRqVsSgBzdkAcjjoctEtccB/8+6mWAXSFJz21byOSjoES?=
 =?us-ascii?Q?cEuSTvLRuvWlt33QWRXlBKK7EyfdRzkvMgX1XF71tU9hxLMClT1mMSBDhzvM?=
 =?us-ascii?Q?Iu01KDRMNReAFoYhQRLJjCKJkV8BFs9y36QiFxq9s1wS7XoCJLp3gWVrUUbs?=
 =?us-ascii?Q?TCwGiy3/ZbvKFwpSULGcH1lPKf535jsesn7nidin/TN/CqNVNYSlXsBb00Ng?=
 =?us-ascii?Q?/mstHlEdLw+9/yyAtd03w5BqeTqMDvg24VQryjvYh/QQRUcds30niqzIocql?=
 =?us-ascii?Q?yVRhB2I/i7JtTPOFa8nNkAPSBw7y4TwSQK7DCYxQVlxTedFvOpKRD6TMGtHF?=
 =?us-ascii?Q?7BxelcmGcOIfH616uRMlAzMD1uiyCHOeJBONFaf3ZlPXFpO6HVSMd0z1OGob?=
 =?us-ascii?Q?PLiEkirTaVlXtxBL8dA2CA2NUXGtE350/CSz5l/pRbAacosd1klcKypOXyvJ?=
 =?us-ascii?Q?DKrN1osonbyF6M54ucsSCP4nqPF+426H+9OEeFR1YXEBx9c9+9xZC6Z6QECY?=
 =?us-ascii?Q?0COJa4H2YEFhIb6kYuKs+GHs6mfExu0znRul9E9q6pidesYuoKoJvH/kD248?=
 =?us-ascii?Q?c6Fy3GFz7/bja8GyIVpoXNxR0AT19wWQxAEC/x/4+saTgH9j6kyYJOW81FR7?=
 =?us-ascii?Q?nunLDa06MzJyXNn+xKcbzCu6dfB9/LXhXu+3g9OjkE5DmB+pm6JpfJZ5Gp72?=
 =?us-ascii?Q?vy/hInBqXSbTPq40/ezoHEJRly+UNSu8zYnfTImJZk3x+5tMetQNcSbGjQtp?=
 =?us-ascii?Q?LE5mMQvMyhrFH0pBWPG1RstTTditcuK9l1B46j0S3L3/PCJHQ2wEKCkdd9Vy?=
 =?us-ascii?Q?js2BdAetD60EM58brKALqg6rQlGHRvZF8jxpDJBQxKNfjh0iiQyaFzz3p5CI?=
 =?us-ascii?Q?FHDpPtiRZ2j2Ki9E6al3MQq8/zRxx3uzsmVGLGIfclaYFOoA6frinMkeg2uH?=
 =?us-ascii?Q?InemVceqbYQ656tasjv43kEETwfNM75jj71vZQppS3dBp5AvUe8Axqpl9D4w?=
 =?us-ascii?Q?akwo+/zFvNRUN4bk+BKoU2ccVraLP8o=3D?=
X-Exchange-RoutingPolicyChecked: 5YRUKibA2hiJ9PqmmM9rwmMIpGc7DVXUyCIey9xs16rLt32d6/3QlAV+seMJHqA26x7ZdsJqIW0pcDH/1rWUbuqMncPynxAOflPSaXKdkbXURO1Ryubr2Bz3emJTaoWqan5twZ2VWpovu0UBdcM0TpULk++0p1oWqD278Dft1tvrBwGGEJ8fDbY8Lm+KhLEaZGHpcVIHxmj2/8ic6+JdKkS7fOAQNGBS1lnvk6UvZv6mPdMuRn1FwDnrZKoJ59rKle9pYlen++9Yih/VT/JKcfas184K9/jkOmKw56UFyFWdXxj8QMjFHMQSKi0hEG6I2qwDEKsAaU8jzwHT/40yOA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4146b6d7-058d-4c5a-1d2f-08df13df9056
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:45:03.2135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWhIlFW1/4jw0IWsdiuI4HJGUleFdTnVoBMFw+RP4dbJ4JOmGN90jCOxFwTUDE8EYUPYCeYu7qnOlJRbnOrn0l45e1pN5+R2Vn/KiDa7+pg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR02MB11343
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfX1OOpLJspM3rC
 ndxqwP4IWOJ1PhSdnAXwNH8dhfW9tJuVX3BJW1YG+cKIaaHlWgHKCzSvetVr03jLvPjBDKlNUqU
 /1v1pa1NaGL73Pa8XXmzAJtaT2aO8rs=
X-Proofpoint-ORIG-GUID: 1LoA-P8ySFLkkX0P8s6wptaZLc2Nrk2W
X-Proofpoint-GUID: 1LoA-P8ySFLkkX0P8s6wptaZLc2Nrk2W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfX+F2H58qFmULN
 7qbJqLAI2CDvmxwV6pb3LTvv4VSok55hW0l1hvp2aES72kQGi4FqKWP+6tIMdQ0tuW7iiSeqbcJ
 XprMAKnufDxkMRR9cbTU7T81QGfgGcXh9ufdsSv2BkqNJi+liaWT37LlCCI4zNNMyioQFrCWq+d
 StW5FAZrLDoY/kia6C5MAKK5Tjxm9znztG1eQs8hEkQvjSBLwGCw11KitTOY2hMcOpH3Bfab2vI
 JSr7klhj3Rp4i4rCOSaDL8GbN+Cn2p1HykAFsHBsfntCFgFLr7u3xsYubXl930BU1CbJVh9TwSk
 hbqMObjXCeKy/vgdrAq/1V98UrRZEJZ9U0c76JacAU0cjCiquxtiQ4ulR9UH1puStwJ5GqWkfMt
 dzPlei4Nw5GAMTXJfytLY70CwShovWNxxXxRBfxghpX8/NBMy5DmDdyj7S/utDc/+QsCqxcIpZG
 O3SwwxrcSKzNFTtlm1A==
X-Authority-Analysis: v=2.4 cv=QYvzLcbv c=1 sm=1 tr=0 ts=6aaa7331 cx=c_pps
 a=iaCbk/XvQ83LTQeyZmlihA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=ox8dIxdxdu1w5TD4ToMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This ensures consistency with our normal QOM-based naming convention.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/isa/i8259_internal.h |  4 +--
 hw/i386/kvm/i8259.c             |  4 +--
 hw/intc/i8259.c                 |  4 +--
 hw/intc/i8259_common.c          | 49 +++++++++++++++++----------------
 4 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index e2b0b00f5b..282e437d25 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -72,8 +72,8 @@ struct I8259CommonState {
     MemoryRegion elcr_io;
 };
 
-void pic_reset_common(I8259CommonState *s);
+void i8259_common_reset(I8259CommonState *s);
 ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master);
-void pic_stat_update_irq(int irq, int level);
+void i8259_stat_update_irq(int irq, int level);
 
 #endif /* QEMU_I8259_INTERNAL_H */
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index bcfed11a3a..6c79907aaa 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -93,7 +93,7 @@ static void kvm_pic_reset(DeviceState *dev)
     I8259CommonState *s = I8259_COMMON(dev);
 
     s->elcr = 0;
-    pic_reset_common(s);
+    i8259_common_reset(s);
 
     kvm_pic_put(s);
 }
@@ -102,7 +102,7 @@ static void kvm_pic_set_irq(void *opaque, int irq, int level)
 {
     int delivered;
 
-    pic_stat_update_irq(irq, level);
+    i8259_stat_update_irq(irq, level);
     delivered = kvm_set_irq(kvm_state, irq, level);
     kvm_report_irq_delivered(delivered);
 }
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 131aaf9b04..0f823f9824 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -109,7 +109,7 @@ static void pic_set_irq(void *opaque, int irq, int level)
     int irq_index = s->master ? irq : irq + 8;
 
     trace_pic_set_irq(s->master, irq, level);
-    pic_stat_update_irq(irq_index, level);
+    i8259_stat_update_irq(irq_index, level);
 
 #ifdef DEBUG_IRQ_LATENCY
     if (level) {
@@ -199,7 +199,7 @@ int pic_read_irq(I8259CommonState *s)
 
 static void pic_init_reset(I8259CommonState *s)
 {
-    pic_reset_common(s);
+    i8259_common_reset(s);
     pic_update_irq(s);
 }
 
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index ac8dc7cf00..e03bbb9a8c 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -33,7 +33,7 @@
 static int irq_level[16];
 static uint64_t irq_count[16];
 
-void pic_reset_common(I8259CommonState *s)
+void i8259_common_reset(I8259CommonState *s)
 {
     s->last_irr = 0;
     s->irr &= s->elcr;
@@ -53,7 +53,7 @@ void pic_reset_common(I8259CommonState *s)
     /* Note: ELCR and LTIM are not reset */
 }
 
-static int pic_dispatch_pre_save(void *opaque)
+static int i8259_common_dispatch_pre_save(void *opaque)
 {
     I8259CommonState *s = opaque;
     I8259CommonClass *info = I8259_COMMON_GET_CLASS(s);
@@ -65,7 +65,7 @@ static int pic_dispatch_pre_save(void *opaque)
     return 0;
 }
 
-static int pic_dispatch_post_load(void *opaque, int version_id)
+static int i8259_common_dispatch_post_load(void *opaque, int version_id)
 {
     I8259CommonState *s = opaque;
     I8259CommonClass *info = I8259_COMMON_GET_CLASS(s);
@@ -76,7 +76,7 @@ static int pic_dispatch_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static void pic_common_realize(DeviceState *dev, Error **errp)
+static void i8259_common_realize(DeviceState *dev, Error **errp)
 {
     I8259CommonState *s = I8259_COMMON(dev);
     ISADevice *isa = ISA_DEVICE(dev);
@@ -105,7 +105,7 @@ ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master)
     return isadev;
 }
 
-void pic_stat_update_irq(int irq, int level)
+void i8259_stat_update_irq(int irq, int level)
 {
     if (level != irq_level[irq]) {
         irq_level[irq] = level;
@@ -115,8 +115,9 @@ void pic_stat_update_irq(int irq, int level)
     }
 }
 
-static bool pic_get_statistics(InterruptStatsProvider *obj,
-                               uint64_t **irq_counts, unsigned int *nb_irqs)
+static bool i8259_common_get_statistics(InterruptStatsProvider *obj,
+                                        uint64_t **irq_counts,
+                                        unsigned int *nb_irqs)
 {
     I8259CommonState *s = I8259_COMMON(obj);
 
@@ -131,11 +132,11 @@ static bool pic_get_statistics(InterruptStatsProvider *obj,
     return true;
 }
 
-static void pic_print_info(InterruptStatsProvider *obj, GString *buf)
+static void i8259_common_print_info(InterruptStatsProvider *obj, GString *buf)
 {
     I8259CommonState *s = I8259_COMMON(obj);
 
-    pic_dispatch_pre_save(s);
+    i8259_common_dispatch_pre_save(s);
     g_string_append_printf(buf, "pic%d: irr=%02x imr=%02x isr=%02x hprio=%d "
                            "irq_base=%02x rr_sel=%d elcr=%02x fnm=%d\n",
                            s->master ? 0 : 1, s->irr, s->imr, s->isr,
@@ -162,12 +163,12 @@ static const VMStateDescription vmstate_pic_ltim = {
     }
 };
 
-static const VMStateDescription vmstate_pic_common = {
+static const VMStateDescription vmstate_i8259_common = {
     .name = "i8259",
     .version_id = 1,
     .minimum_version_id = 1,
-    .pre_save = pic_dispatch_pre_save,
-    .post_load = pic_dispatch_post_load,
+    .pre_save = i8259_common_dispatch_pre_save,
+    .post_load = i8259_common_dispatch_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT8(last_irr, I8259CommonState),
         VMSTATE_UINT8(irr, I8259CommonState),
@@ -193,21 +194,21 @@ static const VMStateDescription vmstate_pic_common = {
     }
 };
 
-static const Property pic_properties_common[] = {
+static const Property i8259_common_properties[] = {
     DEFINE_PROP_UINT32("iobase", I8259CommonState, iobase,  -1),
     DEFINE_PROP_UINT32("elcr_addr", I8259CommonState, elcr_addr,  -1),
     DEFINE_PROP_UINT8("elcr_mask", I8259CommonState, elcr_mask,  -1),
     DEFINE_PROP_BIT("master", I8259CommonState, master,  0, false),
 };
 
-static void pic_common_class_init(ObjectClass *klass, const void *data)
+static void i8259_common_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(klass);
 
-    dc->vmsd = &vmstate_pic_common;
-    device_class_set_props(dc, pic_properties_common);
-    dc->realize = pic_common_realize;
+    dc->vmsd = &vmstate_i8259_common;
+    device_class_set_props(dc, i8259_common_properties);
+    dc->realize = i8259_common_realize;
     /*
      * Reason: unlike ordinary ISA devices, the PICs need additional
      * wiring: its IRQ input lines are set up by board code, and the
@@ -215,16 +216,16 @@ static void pic_common_class_init(ObjectClass *klass, const void *data)
      * code.
      */
     dc->user_creatable = false;
-    ic->get_statistics = pic_get_statistics;
-    ic->print_info = pic_print_info;
+    ic->get_statistics = i8259_common_get_statistics;
+    ic->print_info = i8259_common_print_info;
 }
 
-static const TypeInfo pic_common_type = {
+static const TypeInfo i8259_common_type = {
     .name = TYPE_I8259_COMMON,
     .parent = TYPE_ISA_DEVICE,
     .instance_size = sizeof(I8259CommonState),
     .class_size = sizeof(I8259CommonClass),
-    .class_init = pic_common_class_init,
+    .class_init = i8259_common_class_init,
     .abstract = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_INTERRUPT_STATS_PROVIDER },
@@ -232,9 +233,9 @@ static const TypeInfo pic_common_type = {
     },
 };
 
-static void pic_common_register_types(void)
+static void i8259_common_register_types(void)
 {
-    type_register_static(&pic_common_type);
+    type_register_static(&i8259_common_type);
 }
 
-type_init(pic_common_register_types)
+type_init(i8259_common_register_types)
-- 
2.43.0


