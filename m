Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F332CE99057
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 08:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB7g9-0004c8-GR; Fri, 10 Apr 2026 04:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wB7g8-0004b0-68
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 04:57:28 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wB7g6-0003HT-4i
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 04:57:27 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A6DD1W2662394; Fri, 10 Apr 2026 01:57:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=geXBTcFkUK4cPRoKb8fpHXGO2hmlo/SzoMwzOyCpL
 OI=; b=b4X5DVhTMK44ZFpNZOBYeNC6E7Pk0PnAqRKsHdZw6WyZo9Mn/luj3/+QG
 SeO+M2fJRcOqLwS3V6DD6KIoadAbIxIB7IO5y5oBS3FizMWZYtuyqBZumK0YMnhp
 RKuc3iGDrEtl9CSSuMPW24zZoIoSvt1QQDvA9b27gRSVmTbT6yxOT9xYUI4FITrg
 CoppocwZ6se2nMNX6rDyJf/zpiXHIptCyhlodJpKw+Qu7xQ4I5BHmVyj2GlT0Uob
 oNd+L5ivqHcfmdAxuh0FLTjKpiTOb7PsKcs/og4z/aPyATT9IKqjwZJEEMBRVJk1
 vRfdG98XJGWkx8yZh40z2O1mI8P3w==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021083.outbound.protection.outlook.com [52.101.62.83])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4def2k1re1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 01:57:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNp3Xy9KHwGE+pLq+hj2qQ1EnRaVOXVm4mzjKjbHExgv/B8YOAM0oUqYWXZrKEwGRIUeHqNYW1AMj5PZXzFogmhHL7oZKLJ7KInmSASp71VZW2FeBoDsXEZtf0WvHiuDPapOvD2n0chBdjXSbstxrMkeA5o2nB/D8IielE0QxBTbAXJ2CJEIibgy3bUeiDKv4TZX96y5LZLx4ds3eHAHtAJOP5HK/uR/S4thtaN1FrzG+EsQrmjzIvXTMwx5ZhAkx/1xfENoarzZ0oSYUpYs/ZRcfM44Y2w0jT66Wv6MtdvBNtwRwUTJUJWiYAUZWK7MPbakVk3y5g1ai6Y4kLLYtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=geXBTcFkUK4cPRoKb8fpHXGO2hmlo/SzoMwzOyCpLOI=;
 b=WfjKpdtBY7xMk+rnVpAPIF6y8XyvCh1leBqNUWm4bM28TpLoeGfUPoNOC2ZpGHHfOnBL4W2a/3NNNkzcWgGX+2YLRPLLlnE7/NJqbxg5G48jBqKtI4KHjLKuMTZLcZW6zhaXSaGCv79VmfYjCNydGZBv1pQSrnzhHXn0r714yDXGAIbJ3FdaBCFgxvck/zC4dVw6NAQ2RerwwraOv92km5Yg8wc+A8M4yp/SJy5igldn9Yer9qHHkUDnRpL4OQGoO4VgeIvCP+rD+tr9yuSjYCCMfzbwpfMqc7shSRZO8TUb5VQcH89l2TlCtn97Tz2rHJbQbvOb8uke6g5ARVD+vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geXBTcFkUK4cPRoKb8fpHXGO2hmlo/SzoMwzOyCpLOI=;
 b=d7Ap2uFJsZxq4eX4MZC9Sy1gqQ08714VSOULFdekExg4lFUYLr/7zLZ7MqS7UQfR1FfA+CwLGRMhvhFAsBQM8cpejrxvHn26zqaPz/PQYu9DVmF3+dqE9N4dA72vCFJRqFlk2x+AAv56vXG1gNyXJhYGo4gf9Mlwi1G47Q7DhQH/lhH+mVZ9hBlYGELiu3nfQFe0Ev2FI8SpDzuvb3dezkcsyoUmXEsf4/ECN8gGrJ0FU+qpqfxSz8ItEsSZyspYd9wZG5uu7QJN/6Nnpv5vQemTI9CC4ghF8afFyc2E9KaiBJJjt17W1u4hLeShTXfvAfNhGhFWCeBdTSbGulyxhg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by IA1PR02MB9256.namprd02.prod.outlook.com (2603:10b6:208:424::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 10 Apr
 2026 08:57:21 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887%6]) with mapi id 15.20.9769.035; Fri, 10 Apr 2026
 08:57:21 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH v2 1/3] vfio-user: support VFIO_USER_DEVICE_FEATURE
Date: Fri, 10 Apr 2026 09:57:14 +0100
Message-ID: <20260410085716.877185-2-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410085716.877185-1-john.levon@nutanix.com>
References: <20260410085716.877185-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0404.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::32) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|IA1PR02MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: a4f9b01a-d38b-4e2f-bdae-08de96df2d35
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: c49+KgfehcyTtupRzM9K+ZXMWAxkxcz5sk6Vt/2Sy+nPxJh8cMcNX/jt388z0HpvmlB11inEfy+CE+0jlNN9zfSgWq/wYtNHDBHvMpYiPIciQtnuSk8Fe5cVvYAOvCFhCXq+xkj9ycJkNPT1G5HGQPyOUW93O+zoHjnbbRlN9bC6DRxhUX0wNDtswNLw+GbniScbRzuIXzFOUeyvqdZMl9rgjf8xB9PFsBiymZWgSUowas9CHbMQxJE524wTE62tSvBPhPVM2h3s52U3DFHk/pX1E8lU/rYNIT4Hvzd5+7sH8rAhM9cwmuhTM+yD9JsxnlO5eO1cd+43BY7RAy6MdUCm85VdwlAkYfIUuXtTThAwseAqezU7KLWzV8RgKcNlpK3F8W5/ZyL1GvmhpALaiOILrVrvccGmNatkyLEOV+Hj2X3UyIV09DYDw52q6rMRk0cePfJ7D9DHfErqW2WpGvKjBPu+GDGFLMu6aIwsAwCYgpp1nOFkNad/4jMveXybP/TwWbsgxaZwxeZOJKhT82ru05fpyo+ubuh0PQs2bWIpzgq2QfuLi1osIJT3NpPCPvMaKqEWw818nm7YsYcNta0h+YHykIUyixnb+7hdjLiHQVVF1Zmb4kEwB6BsFvoU1dNPrxGVxX+tFwMauwYh+DhtuNzSZMpHGW4eVm+8CxISRNmbZ4MAhR7Rb2b8zBZzsv+2HkVpgAK8E17lyJ4JeJS6dYDgYtR73P8xh7FhVUk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nM+OQQCWpoCzmnQTkIVUOPDHmHrArHdazLzhs1ebV3hSPfXxfEy1o4Gr9P9/?=
 =?us-ascii?Q?pp4lIkPEk/2LKkFhdeuuuB6q0FNA0mrcpdKVY8OmAdRHE3y/MflHtJasl6Sz?=
 =?us-ascii?Q?TorBXVU8rYFVmoqFVUz5Tg0olJIXqIkh4qTlf6BdYmAh5D9dZz5CZB5Uckvo?=
 =?us-ascii?Q?csX6z3bfYkJG2CPyHtK2tGyC2gxHCFrnXZZk0b8IMgu2hgVNgrYmVIa+w0yh?=
 =?us-ascii?Q?iWFeuHdobxgeZEjVFrC8dFmeHcMXub/wDtYfSEdePXArriVqRij55ZtHTAbA?=
 =?us-ascii?Q?ONSOvH3nAtCGO/hDjh+FBdUM2OK/cG0wzHEmOV9yRWNdZl2ccWbteEJKz7Tq?=
 =?us-ascii?Q?M6YECYj54bL4mjNUHq2gJI4ElvUUAu+WT279vRFDi6oNxcrmfY7tRj1qoYXw?=
 =?us-ascii?Q?E1V1OAl4tx79Uh6gz+3x5eD1s1ilKNHkd6SMzz5kjEYOUzaorK5sXqiE9Nn7?=
 =?us-ascii?Q?4U765y/Z3sXbwQqeZogmpEK7bAhbFXWhetCm8T5IDHdRPqG4fw9K24sImEJP?=
 =?us-ascii?Q?KdWV0mUUFhE1xKTazNWmqxVIDf4WrpoogAXdRktoVymubv61MrCipf0Y2p/W?=
 =?us-ascii?Q?OoHITyAnIE7fJuhzZrItw7egzq1xv9aTcjq0K7iDf1S1iyDNgVg/q+4R/Rr6?=
 =?us-ascii?Q?IqF67KnXzvR2rFUO+VWteM+kvEaxv8w7ZpTzESTA+JBGW7KF5GLDWf43Z4/0?=
 =?us-ascii?Q?h6ho5P3JAO9L/Jola+4tV46I9PEXoFrDYP9GOn6Sw189VKsbCDkrXhRnOaTT?=
 =?us-ascii?Q?PzkWGQNbfIdrLWwAni0mVtVDqKMT7J4c5ig3p62UtKrIhQSERmlhdvEhdm9A?=
 =?us-ascii?Q?O1ZSqDqFPuT2ldTmiAA2b5FwbJpnsEQq8YdBnHuXviNpiqFJhGNLekdEY3xA?=
 =?us-ascii?Q?W2PHa08UtSCiAxBPSGiDSEDEy2/DP4a9TM74w8EviyPmAwg6AOURLhdnAGu8?=
 =?us-ascii?Q?qkpu+t0n5d7pZZI8Te71jQXOvNkDWgFHCdFu80FmZl8i+VtH6o61EsQbjHPb?=
 =?us-ascii?Q?3+5uNzwvDT2GvrryJ7rRlB2h0uQRfh6UVdPMBjgWDpYeP2lTp4bD1bgWQPte?=
 =?us-ascii?Q?sB8Ha1QKNxfEH8QvKSzOG7o8NSbIxCXFBzk1zvtaB3dHj96SgJuCWHPR64FI?=
 =?us-ascii?Q?0l3p6eelb69EPHnToifCQ++bclOtZQFrB99Jwp5ISRc9VgDjPrBAZ1aCCTN4?=
 =?us-ascii?Q?WL+cHxp6B1Khd2w1X5L1aObSZbRcvCCdXh3g5TRJLH5K0iBEI/oNfhO3YuXu?=
 =?us-ascii?Q?l4ugXbY5sny7ez70Y6YyWYBo7cAnilXeZm+avBMJORb+UPg0lfMcmTJ8mDF8?=
 =?us-ascii?Q?DgBXBHJxqmSlnRMr6zlEB8K+tQBsrGOlNpt7TjNByT7NzJ2OKd9QZtz7FYv8?=
 =?us-ascii?Q?YbhGYSBzyxuKIldeHCDoGqXz33f0inaLP1+U+Jnd82yYtWq8HsfCtmuKTci/?=
 =?us-ascii?Q?EXtQcUN+HKOweq8D001ahYNvyFm4xiKkAHGWc34Dtq5MwVCJSPfimCjqLbj4?=
 =?us-ascii?Q?u68yORNl42XT8wR5YLLitEjLGNmUe5BCYgwgrujBIlhbqdt9i3uXzANRMkno?=
 =?us-ascii?Q?e/yznXIKd8c/MD/ZYjgs6USv2jAA0BU/xvw0X6RmeuUgdT6pLpRDas5q4nkj?=
 =?us-ascii?Q?axvZ2UFnBQcNHp3b0wPWPA4KcZYA1c+nTfADtscY7A+2hQy0V5Jyq6govHHz?=
 =?us-ascii?Q?deGtgSGqutzVJbnvcgT0EHYH6HTJfMrD1ApoNjzIPr9a52UZ1uHVks7VMIgB?=
 =?us-ascii?Q?5GT/4BSBTA=3D=3D?=
X-Exchange-RoutingPolicyChecked: YcD6MZSMCONWw8x+BbjvbCs8vtVU7+5wNb6ZTXc7ud9QVhiGoQClBIVVkmdwPUExg0uYpwGnRDgtzLW/JmPbIfj33LZso0MaTzIemMDO8Du+eaec7uXvVSbJcukbAXcjFKJK5rosiDQt1MeUSIqR+huQiJs2TAiynb6qgUYHR2/RQbdgexFufpYVFqTDr+jBwOX0BHsK6MO+Cqhmt45KHKpz4oBxJkzwWDYSfNKRS8kPH8RWWCAfB7xqu6F3M351UkFL3+ONQF+HjxtetKhQ9wLOWdtIP1PQvKewLSM40BRAFhZ0c4WTbLCgflCGh7VCqyK87rOXOaNGiCoU4h6V4Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f9b01a-d38b-4e2f-bdae-08de96df2d35
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 08:57:21.5085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zj1bcJsjxxv07c6Cr8UZC7hLao57ZEsZRTwwGq6NCXE2EsDIy4cS7VLl46Orjheiab7vpXxJiiLWcuGeRoE+Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9256
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4MiBTYWx0ZWRfX8eTD7LIQwxOv
 Jq/SXnVqwnJippXHF69UzxmkNGT8IzFbnjWyvJ/TfxBXDBfK+WgzV/0uduUlyiY+Yws25sI1wC2
 NB1UfP+Ktp4x5YgHMvt0LI8zTYSA9p9/C0wqbEqvj527PfpAKVkyvPWGxEsA87j61WaUVvPdxLQ
 0/zLhbDaTQR9/aeYls0UYF7i9Q+ADWN8fZPXTeWCuYhVgMj/moM7lXsyR0Ne5gTbsyaymet0GxH
 jxkcyxO0O0ELEfP088T5fShFdcEw5s1nINT0IbnsXP7MpXUrZUOFODLDRqdr6nchDWkPCmU6qfu
 yP+3IXdbJiB0tkqSVLr2+xO8ZbVLsrbrO2OEou5mWGNAIToscokivRorK8b3K55I88dNQRPCvIx
 a1cbKJFTGhJyTAn61jFqrKPcDilETJq6DCfpc0cGl3AMWjZVdo9fHyIGQIply3Ty0MKHx2UbgE6
 a5hkXwkgxm5iG15DZ6A==
X-Proofpoint-ORIG-GUID: Av4Mngm7XN31zF3rFlykTrzmNoS94q4l
X-Authority-Analysis: v=2.4 cv=fKgJG5ae c=1 sm=1 tr=0 ts=69d8bb73 cx=c_pps
 a=f6P8eh4LYcQUHlEOLA+94w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=P6-GAGG-IN1-BGcB38EA:9
X-Proofpoint-GUID: Av4Mngm7XN31zF3rFlykTrzmNoS94q4l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Plumb through vfio_device_get_feature to the vfio-user server. Note that
we translate EINVAL into ENOTTY, as the existing generic vfio code is
expecting the latter to mean "unsupported".

As part of adding a trace point, clean up the trace file.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/protocol.h   | 12 +++++++++++
 hw/vfio-user/device.c     | 42 +++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/trace-events | 23 +++++++++++----------
 3 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 3249a4a6b6..2a0c31e7c5 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -40,6 +40,7 @@ enum vfio_user_command {
     VFIO_USER_DEVICE_RESET              = 13,
     VFIO_USER_DIRTY_PAGES               = 14,
     VFIO_USER_REGION_WRITE_MULTI        = 15,
+    VFIO_USER_DEVICE_FEATURE            = 16,
     VFIO_USER_MAX,
 };
 
@@ -239,4 +240,15 @@ typedef struct {
     VFIOUserWROne wrs[VFIO_USER_MULTI_MAX];
 } VFIOUserWRMulti;
 
+/*
+ * VFIO_USER_DEVICE_FEATURE
+ * imported from struct vfio_device_feature
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    char data[];
+} VFIOUserDeviceFeature;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index 64ef35b320..b8d2b7c1a8 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -74,6 +74,47 @@ void vfio_user_device_reset(VFIOUserProxy *proxy)
     }
 }
 
+static int
+vfio_user_device_io_device_feature(VFIODevice *vbasedev,
+                                   struct vfio_device_feature *feature)
+{
+    g_autofree VFIOUserDeviceFeature *msgp = NULL;
+    int size = sizeof(VFIOUserHdr) + feature->argsz;
+    VFIOUserProxy *proxy = vbasedev->proxy;
+    Error *local_err = NULL;
+
+    msgp = g_malloc0(size);
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_FEATURE, size, 0);
+
+    memcpy(&msgp->argsz, &feature->argsz, feature->argsz);
+
+    if (!vfio_user_send_wait(proxy, &msgp->hdr, NULL, size, &local_err)) {
+        error_prepend(&local_err, "%s: ", __func__);
+        error_report_err(local_err);
+        return -EFAULT;
+    }
+
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        /*
+         * Client expects ENOTTY for "not supported", but the protocol may
+         * return EINVAL (which should only occur in the case the feature isn't
+         * actually supported on the server).
+         */
+        if (msgp->hdr.error_reply == EINVAL) {
+            return -ENOTTY;
+        }
+
+        return -msgp->hdr.error_reply;
+    }
+
+    memcpy(feature, &msgp->argsz, feature->argsz);
+
+    trace_vfio_user_device_io_device_feature(msgp->argsz, msgp->flags);
+
+    return 0;
+}
+
 static int vfio_user_get_region_info(VFIOUserProxy *proxy,
                                      struct vfio_region_info *info,
                                      VFIOUserFDs *fds)
@@ -432,6 +473,7 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
  * Socket-based io_ops
  */
 VFIODeviceIOOps vfio_user_device_io_ops_sock = {
+    .device_feature = vfio_user_device_io_device_feature,
     .get_region_info = vfio_user_device_io_get_region_info,
     .get_irq_info = vfio_user_device_io_get_irq_info,
     .set_irqs = vfio_user_device_io_set_irqs,
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index abb67f4c11..503e1c82d4 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -2,19 +2,22 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-# common.c
+# container.c
+vfio_user_dma_map(uint64_t iova, uint64_t size, uint64_t off, uint32_t flags, bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" off 0x%"PRIx64" flags 0x%x async_ops %d"
+vfio_user_dma_unmap(uint64_t iova, uint64_t size, uint32_t flags,  bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" flags 0x%x async_ops %d"
+
+# device.c
+vfio_user_device_io_device_feature(uint32_t argsz, uint32_t flags) " argsz 0x%x flags 0x%x"
+vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
+vfio_user_get_irq_info(uint32_t index, uint32_t flags, uint32_t count) " index %d flags 0x%x count %d"
+vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_t flags) " index %d start %d count %d flags 0x%x"
+vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index %d flags 0x%x size 0x%"PRIx64
+vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
+
+# proxy.c
 vfio_user_recv_hdr(const char *name, uint16_t id, uint16_t cmd, uint32_t size, uint32_t flags) " (%s) id 0x%x cmd 0x%x size 0x%x flags 0x%x"
 vfio_user_recv_read(uint16_t id, int read) " id 0x%x read 0x%x"
 vfio_user_recv_request(uint16_t cmd) " command 0x%x"
 vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
 vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
-vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
-vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index %d flags 0x%x size 0x%"PRIx64
-vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
-vfio_user_get_irq_info(uint32_t index, uint32_t flags, uint32_t count) " index %d flags 0x%x count %d"
-vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_t flags) " index %d start %d count %d flags 0x%x"
 vfio_user_wrmulti(const char *s, uint64_t wr_cnt) " %s count 0x%"PRIx64
-
-# container.c
-vfio_user_dma_map(uint64_t iova, uint64_t size, uint64_t off, uint32_t flags, bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" off 0x%"PRIx64" flags 0x%x async_ops %d"
-vfio_user_dma_unmap(uint64_t iova, uint64_t size, uint32_t flags,  bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" flags 0x%x async_ops %d"
-- 
2.43.0


