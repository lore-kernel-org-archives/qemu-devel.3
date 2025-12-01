Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2763DD116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 09:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ0eG-0006Du-DW; Mon, 01 Dec 2025 04:56:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vQ0eE-0006DL-J5
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 04:56:47 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vQ0eB-0001wW-9j
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 04:56:46 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B19r1Qe1346015; Mon, 1 Dec 2025 01:56:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=V5SGEcykyIcg7kkW61/msA/tfzdKNwXkhKT/wbI1b
 9A=; b=fyBGbs+1BMoMtTlde+tnN6IGD8OIeZFkogWFhdvok7vUJ95cl2ucC4uPn
 PQPvoY7N7hKP9465JzkdZsfQjRJ9nPZ2v8dLx18U25EaP4tDqAzHSq2J1UpzLk9Y
 UAc1XyWo7OQ1HLM7p844HqcNojn7fRtqlZr2Vko0BRWSlCMLhDKYfUpj7cEsAyDR
 SydRoBhIFjjdgIEkiyVAm1sOyUqaKmwuy20QEeQhZt/WNm7QflDmroPG9QovB1Tf
 sllmQW0xu8wazc9vXlJuNmr6ndQJWSLyllIHg1Jf76IRy+p+HaCo+lD1ihqcsT4w
 kvNwffdftpnSMo/TKjjjMtmq0Uk9A==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022114.outbound.protection.outlook.com [52.101.53.114])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ar11e2hs5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 01 Dec 2025 01:56:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9pQAWZWMb9VTFxUE/sEQORrZtYDRF6HVW67BuC0ovDNosQp9kbGdYqV0bnbCRyehW0Ubmg70jfc/cCiT2yGsmsbeHCsFeiwCXYQefhodUIZd7MtXtqXaAzCxAIZVBjyX5uUpSzecgLf0JIRzhkGn18oOlKsiZG1PHycJ947ic5+0NKojHbMD7NTDlD7O/fXgdHWQ7xbd8ASaWtrKMRdPiKQ35eqzp+X10hm0vJfGPe0rnGOcGQkMkDYW4A/NkJjylmBAi7wmxSHWlYOuRi/h1wxEiDJnPJzJc2HWVHIHg3R+WGSu3TrhQj8aWknRa55RJBs5UjedB+eBiZ9aapauA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5SGEcykyIcg7kkW61/msA/tfzdKNwXkhKT/wbI1b9A=;
 b=wtBTYC/jWd5bcKj9G5vYzDsqGI+2rRjJzlQV+Z91nkO6Mq9VAkNFE1eR8ejAvRaH/2IzzjtQLHIvMdiwWpz/cYtbVgD32cekyHP6oxMKx1anESVhvOTSXgZq04wI+5vPmPcCuAz83vjppM+ZsRfUjJrm/fxIry9lgm+xg4fQaQ/KuejpvsaeAfX3YdE/43iZQgzXoTZx1ZLxYCEwBcOQg1ApkFZXWtglNhvvjmoLL1ZSaR0UFZnLvp96eQ2++7CTI3HGohCHfvg2EC8ZtBKhCCa4ztwno4dG3Tt8nExAw3WQwIJrrzKP4XIQKtAaiy1J1VZOdac3jE10hpEAQKYcbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5SGEcykyIcg7kkW61/msA/tfzdKNwXkhKT/wbI1b9A=;
 b=FwkjF0FEGRNyQQP2SMlOlpzRUcJS+Dph4CjkbI9pMmLkaSF5uX/VRZQWXRbjsPkiNCrDvZpBhTTXH5I+88tjI96r12LXYztbJNOEQMzoSHqv2Wi9gMzo2+DhM3vH2sXDa74oXQczWqpPIG6QsHf4lB6V4XdEQg96QnaPuqMpIoQHbVsKY7bFhS05kotdGMyCeA3j3tBeSxuwRZpvo0Az9xgy2bbsUCuyJ96Qmjmyg+MCQlcLryIDwzONXvcEMsFC4eq1dM9owMtTa5RKZymS1IkDisYbBW3/zkztYYwNU4mUgmiIAQUHqaZX9sqYSNqBlliGV2F5ZbNltMyZPJcXcQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA1PR02MB9865.namprd02.prod.outlook.com (2603:10b6:806:384::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 09:56:28 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 09:56:28 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 3/5] vfio-user: refactor out header handling
Date: Mon,  1 Dec 2025 15:26:19 +0530
Message-ID: <20251201095621.2786318-4-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251201095621.2786318-1-john.levon@nutanix.com>
References: <20251201095621.2786318-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0576.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::23) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA1PR02MB9865:EE_
X-MS-Office365-Filtering-Correlation-Id: ddb0965d-75a0-4c1e-5908-08de30bfe5c9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h3VV4zwWL5AontbTJ3U2nO7Eqk9qCqj0TXtkmCxqQYeSlCdjLcMWL3om0K/m?=
 =?us-ascii?Q?PUZYh4SXFt6h1Wu/+7zinLIg2byjt00a8+RrSSWAD2qWMuvQwhRMSaBp19O2?=
 =?us-ascii?Q?j5EbLkbCANKjZnNhFf67KeRD8hgiK4GS+mnt0YJfY0VQDpXETKRK5W2kvgDX?=
 =?us-ascii?Q?kW/TXPGEFpONBmYm30R0qHb2MrxGjjdAenWVQ6A32PpK6B/sKi+X9z3mH+he?=
 =?us-ascii?Q?/oRRv0aIi6wALEiv1AGhmTB451xnZ8GxsJuFXq72iMJP9Gb3Vs9Ehm9D1rls?=
 =?us-ascii?Q?OYshh0/Ht68bWV6BbmG+sI/4QBybqMcYqEw7c1Df1ew/asBSsTDnrk5AfXgo?=
 =?us-ascii?Q?ohVE1N3QoITQ4tPtiJU7HaWuYV21ZRKN3QsyQiOPIHqWn3VUksTXryEnfRLM?=
 =?us-ascii?Q?FTKEZup3o7ulVISfWEbtI7mHyk/2vSC/El9XgXtIyA3W7o1az/J3CHJW01kR?=
 =?us-ascii?Q?NXAqtBAUZgFGF7JLmJSbyMrg6ggpxUShwm4t1etxw3mI6kRufsToI3UNV6LE?=
 =?us-ascii?Q?vLBcZhULmphuDR9+MiHRCz8w5cXwwFvpSBf0t8f6ocmqea5RvVkxGUHoMf3A?=
 =?us-ascii?Q?8orfD4OGg4AJNqsTueH8LC2RP5cXs0cGoLBoDdhuVoSSpZvBW9sB3RWwgUxU?=
 =?us-ascii?Q?xYDHLx7TXn/UzECjPia6at2X9zfB1SnKALo8zNL4O0uuC4DES7dysp54aECd?=
 =?us-ascii?Q?LKAf3RbcfLOqANrF3mxYxDGf9oQxfKymcqXgaIbdf2u3tcPrtFKx7MxraghO?=
 =?us-ascii?Q?RkC1EjM/Pk7mH6DapgprVfAu29WHS8ifAmW2yxJSOyuo8erszuvDvH/7gR0l?=
 =?us-ascii?Q?OVGX65RU6WiLDBnTUGZM4QDd5/hXalwNbCYwHgMOXbALfOiLA63qY4mKNoQC?=
 =?us-ascii?Q?DhhTarJQXbaSGBPuAqEgIwyoQ4C37NTskbCllCftbOT+9Lqv3iwpF1vDfzjl?=
 =?us-ascii?Q?H8Hr6ErcoJ6cNfkCAtEKlD/aQKWp5avesHg9v4wmPVUcZzA6AKrTF1wnxnTc?=
 =?us-ascii?Q?iwDGQ1SnRB6MLwExNXK0qEtWc/T0wprAvFewnRxUXmsZs2H20vm+otnDi39r?=
 =?us-ascii?Q?uwBjVx5CVND+wJypqt9Tn02h2KPuPQFKgjAjQs/TFM9VYHRrRjtn+pZE6u/E?=
 =?us-ascii?Q?ipKyLiLVI4DKK23bL6wRGTF4zNCltj3nPpLBs0QnNt9/LvVice8JQX7gitC7?=
 =?us-ascii?Q?OuwhHanM9bqlW8R26AGydreqNNzZwftTmy1wXCfMyu2+qrjGh0vRLIaEb2nV?=
 =?us-ascii?Q?OL6S67qK1k+Vx5sWKUohw06wRtsIseRvLI6yOsfWYn1NGwWVM4wYUHjv81C+?=
 =?us-ascii?Q?tVGTtIy0oIovjxkiOu2yL6xSAbO6FirPtM3DNvDHl5L/KPfOeki6LBaHNH7o?=
 =?us-ascii?Q?RD4/vt+ONtrlkrjRn0P7hOEtxauxAY6tJPg8/440NlzQuN+FSEMfmem9eNeS?=
 =?us-ascii?Q?YTmImg7tQceKHGxp1Zp92j0SDW7++yk5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o7KV+aToniDAGsHGE8SaNB53tgniCkxtVM0jOPRHAEtLH16roQuUsZ87r34X?=
 =?us-ascii?Q?tIOBCb68HnB77fnHwUFgU8FQfn0vNKRS/VvlG1ljD0iNQlhpp0GJ/6TyD6+w?=
 =?us-ascii?Q?gjP5tQZlqhziGoMea8DGgP/a/HqniDPbKAD905gnjCkA+E5kxSSMMUFmufvA?=
 =?us-ascii?Q?3XTLbck1lCALNXMpkwfygnnuZo51LmHPc4/KZ1/uva8Kl4ZyU0ml2aOdGEsF?=
 =?us-ascii?Q?yJ+WWwcbqB7Y6kWeBXlEALCkKOBA9n7L7RE1k6HRe5Yx7bzX2AX9RRksOyRq?=
 =?us-ascii?Q?9yM/7YoDszmyXKdCGSus0EJiO9l6poMDAY8dKT+iOHyKrmWMyqG2mBICELSN?=
 =?us-ascii?Q?1nzq9YYTG5k4QFZInJYuG7MLT/Fg6Lo07+A5TQQ7qOgF2328tmeBRYXO4XjB?=
 =?us-ascii?Q?Hb1BWhKwtgO7XgPiy/GNpeOcFltyMNW8Ki15lOcmFefMS0191ai3mPdRYOOh?=
 =?us-ascii?Q?Is1KarohBG6ahFa9inkFZqOEdCrOgbRhUTybS45uuvyUmVDHEqKuktaFHQfE?=
 =?us-ascii?Q?Eqi4EDCHODyltfG9Iaod46XRTiAygEZj4j+hoKWnWvw+A576zrEdqY+BJqEP?=
 =?us-ascii?Q?5TT02YixJPh0stO0Qj/ilSzT/OGmstKcDpRsSNO7ZyJBZ0Z+PQzabQFUrflx?=
 =?us-ascii?Q?XW+65jfrE0QLaaQvy87JWIx5D7QbwHcHy/QJLKQQAZzE/FWWYal6d2l9nKRE?=
 =?us-ascii?Q?Nq0G3rHO0a4ehX6XMfUVH/TnSJmCL1q6If71S4F2rlxBYFZHQp3FeBtl4NF9?=
 =?us-ascii?Q?Gy5OCp85MceKVUdk6y3BS4j2iwIX04oc0zXDHevDiMHDSSkvonBJch5nVbTe?=
 =?us-ascii?Q?LjJXbUMwocFJGBqSMrTwhKq5Pb/wpOKdUh649PfmKUGfek/0mMpIzonoC/1C?=
 =?us-ascii?Q?hJ5Dv1+jeZWHyk0LnHPGLlYpgLv1X6uHD+wxPmkmGRMFlwmJokh60YfKSIzj?=
 =?us-ascii?Q?nPTmHlHDpfUBj61m7H2w0tabqliMYcvTA+7+Kl+YGYod9rma5d2kiCeOoXYI?=
 =?us-ascii?Q?XxHV97AZ76qK0+woL4sWt+Om+SHA3s6qBHa4cd2+kTqFYT0zLQ6Bl/1ocusj?=
 =?us-ascii?Q?oL6+tAx6CIm5DDXjF46zTz7023Jq60phwgX4DIVBwob968OVFR2OiCvOCYx5?=
 =?us-ascii?Q?g8sUwGyi4XjAgoRgYIdBiW+KMw8bpe0T0AVzv+QLl4UepnvepS5bCReM/Ol7?=
 =?us-ascii?Q?OvueUBpftQTaKxIOEtYw40+N825jaMbMelkLfIWPqLdvxTOKGIl1Sau/4wfh?=
 =?us-ascii?Q?u/PrCDrwROvGk17tUw7UjbsyllqUWg6f/QQQmQvnGzJ5Qzes7MfV2o+HXJ6C?=
 =?us-ascii?Q?miriglIr2IgUO2CSy+39XHM42e0/WI8aVAcumyz4+G8hYkIjAzW86Sc0FoP/?=
 =?us-ascii?Q?zKBmimv5DQrfPMj8SFvQYo3TZLWzoES01vwfC9wevWR/DaihM34pRTOOu0P3?=
 =?us-ascii?Q?8Mo8U2Mt+ZZeVYpLBS66WxLd67fxhLSAdPxl2F0vUUNqWY4VWrlcDeYM4FF8?=
 =?us-ascii?Q?t0Z/aozX1lw4+AVYXqKXJRtcQ0eVZupHVBOpi8ji5NGJLUCafLamUv59xYI1?=
 =?us-ascii?Q?NS+7JvGDG9vLcvTNyoNEnsQLoK9dFgVNxO1jNV6L?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb0965d-75a0-4c1e-5908-08de30bfe5c9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 09:56:28.6147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18zEaduS/ipRu0f0MNNuu5Fpn54FVjWTVXFStD8rqFAY2wnd/wGXXlIS4XWyHMoLct6emTqAa0Ujo/DxP00mHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB9865
X-Authority-Analysis: v=2.4 cv=bddmkePB c=1 sm=1 tr=0 ts=692d6659 cx=c_pps
 a=PPij9JC9dsFwf49xmEs+Gw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=YItANLEf2SIYaAbUJgsA:9
X-Proofpoint-GUID: aa8FxaAeJhNKZvJ30ovH3ZN0yJVBalTi
X-Proofpoint-ORIG-GUID: aa8FxaAeJhNKZvJ30ovH3ZN0yJVBalTi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAxMDA4MCBTYWx0ZWRfX3ivrjQjhk/2F
 TFZvJekXhYEdSu+UCMSXCMNNxkTwsWrX6wsTNt6XfNT6b0uZIiAZT7ctaJxXsQP4dztcAuVcYXy
 j5plyvpeh7HRTX1HebgQWHk7MflFRUwV47VZGtk9+NyafslhlNxFXT4NY9kWQRm3GgWUfXow/UJ
 AFH0ISf6GfUBQgOXNt6oYq0qZJz0GlaQALEIuW3fyjII9soVQveM8RwDGxJHmOu3EUj2OXXgwp1
 EtZ1HJrkE+AdhkCUY63SqNdG4XszySq1p5PjdPOeMdxFFNXOQvYHf0YGovRFvOBJwNzJgayLbBh
 AEBVrLxmGZR3t3pcc87UGTXkhN5B8OcNfA1Efm/liB65Jla453SG9aqtJhCFwgCUYur/hsIhcO1
 6guFy9VaZX4yQ5l4OV51HlnTTdJxwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Simplify vfio_user_recv_one() by moving the header handling out to a
helper function.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/proxy.c | 101 +++++++++++++++++++++++++------------------
 1 file changed, 60 insertions(+), 41 deletions(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 82c76c6665..87e50501af 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -218,6 +218,61 @@ static int vfio_user_complete(VFIOUserProxy *proxy, Error **errp)
     return 1;
 }
 
+static int vfio_user_recv_hdr(VFIOUserProxy *proxy, Error **errp,
+                              VFIOUserHdr *hdr, int **fdp, size_t *numfdp,
+                              bool *isreply)
+{
+    struct iovec iov = {
+        .iov_base = hdr,
+        .iov_len = sizeof(*hdr),
+    };
+    int ret;
+
+    /*
+     * Read header
+     */
+    ret = qio_channel_readv_full(proxy->ioc, &iov, 1, fdp, numfdp, 0,
+                                 errp);
+    if (ret == QIO_CHANNEL_ERR_BLOCK) {
+        return ret;
+    }
+
+    /* read error or other side closed connection */
+    if (ret <= 0) {
+        error_setg(errp, "failed to read header");
+        return -1;
+    }
+
+    if (ret < sizeof(*hdr)) {
+        error_setg(errp, "short read of header");
+        return -1;
+    }
+
+    /*
+     * Validate header
+     */
+    if (hdr->size < sizeof(*hdr)) {
+        error_setg(errp, "bad header size");
+        return -1;
+    }
+
+    switch (hdr->flags & VFIO_USER_TYPE) {
+    case VFIO_USER_REQUEST:
+        *isreply = false;
+        break;
+    case VFIO_USER_REPLY:
+        *isreply = true;
+        break;
+    default:
+        error_setg(errp, "unknown message type");
+        return -1;
+    }
+
+    trace_vfio_user_recv_hdr(proxy->sockname, hdr->id, hdr->command, hdr->size,
+                             hdr->flags);
+    return 0;
+}
+
 /*
  * Receive and process one incoming message.
  *
@@ -230,10 +285,6 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
     g_autofree int *fdp = NULL;
     VFIOUserFDs *reqfds;
     VFIOUserHdr hdr;
-    struct iovec iov = {
-        .iov_base = &hdr,
-        .iov_len = sizeof(hdr),
-    };
     bool isreply = false;
     int i, ret;
     size_t msgleft, numfds = 0;
@@ -257,45 +308,13 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
         /* else fall into reading another msg */
     }
 
-    /*
-     * Read header
-     */
-    ret = qio_channel_readv_full(proxy->ioc, &iov, 1, &fdp, &numfds, 0,
-                                 errp);
-    if (ret == QIO_CHANNEL_ERR_BLOCK) {
-        return ret;
-    }
-
-    /* read error or other side closed connection */
-    if (ret <= 0) {
-        goto fatal;
-    }
-
-    if (ret < sizeof(hdr)) {
-        error_setg(errp, "short read of header");
-        goto fatal;
-    }
-
-    /*
-     * Validate header
-     */
-    if (hdr.size < sizeof(VFIOUserHdr)) {
-        error_setg(errp, "bad header size");
-        goto fatal;
-    }
-    switch (hdr.flags & VFIO_USER_TYPE) {
-    case VFIO_USER_REQUEST:
-        isreply = false;
-        break;
-    case VFIO_USER_REPLY:
-        isreply = true;
-        break;
-    default:
-        error_setg(errp, "unknown message type");
+    ret = vfio_user_recv_hdr(proxy, errp, &hdr, &fdp, &numfds, &isreply);
+    if (ret < 0) {
+        if (ret == QIO_CHANNEL_ERR_BLOCK) {
+            return ret;
+        }
         goto fatal;
     }
-    trace_vfio_user_recv_hdr(proxy->sockname, hdr.id, hdr.command, hdr.size,
-                             hdr.flags);
 
     /*
      * For replies, find the matching pending request.
-- 
2.43.0


