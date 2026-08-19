Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BD8C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwgVB-0000mk-Oi; Wed, 19 Aug 2026 09:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgVA-0000m2-3d; Wed, 19 Aug 2026 09:38:44 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgV8-0000hR-88; Wed, 19 Aug 2026 09:38:43 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JCowRQ145325; Wed, 19 Aug 2026 06:38:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ORRjYN2y55yiC/8Og3FAGn9w5Ttz7ljZM3DvIAef2
 uA=; b=ZmNEE4OcXh01h6ONhxR1n1p5QgNcCtVLacXLBUUlSzg7+bFVPfbXD9Cvg
 H+NqkQIdrfXjfRbPeGPSpVJufktudDQPT0vGJGObQ9mdG+5mWAEqMLLVWMPngowu
 /mCokyKMGDav+Do4dquwIci3fugK2C+Djt6yo1UasRJa7pJ0d9/JOLUzd27spFz7
 /7GZVHgMcAGsK5fNt8a/sbWnody6jzYAXygQqnTjf4Z7snS6/qpHtgP1FjwoXIYJ
 M67pgqRB2GyJ2brWU6Ewz/trwzgcxZnwT4IhjPfzFAK02i11wZ/AFsCevKzehit1
 261EhgjAsYXcMChfrUn1HChqBtJPw==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021124.outbound.protection.outlook.com [52.101.62.124])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g4uw5jqvn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 06:38:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTV6LcPvMWayAfDJgUVwrcd4xvAxJo/1kz0l78XGD3PMSVW9owJXJoqxcqHGWAm1QobFgx9TsJXUfp3OXhc52+MbUD4Tm/9dOTbhjquswPjchOakVgoqZaZMgiXsoK7fviDCuVuJE1NUQ/ip6lQ5PSHbPURbeADGsHSrL18TG3WzLLaXZ9LMVAJbIViZFHCjbph2fnG4vH5zPI0cJ2Mz6fIaI9xjNoa7YOXuzziaqQdfLH5Lp55GglSlAjNOqOF8Tldjdd9F863sv2KGF2wIs9OPEDKxxoe5s44+xz+R20l9ho1EWfkGBkvZyzEdZ/HtdptAZMk/T/0xxdwbPBBqpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORRjYN2y55yiC/8Og3FAGn9w5Ttz7ljZM3DvIAef2uA=;
 b=mUyQcvAHOLGpuRc1lqG5m5Iyvksw9r0HIX0tkQO+fd+C2KnF5/hvR3hViMWsNICEt/tMMm9BmIs4L+LQqoaNK1dsWRwjm2VSACIw0W/s/IPc4Fa8HDjpYwNHdIeo874VjjPJS0mVOfwToOtXqsjOLOrLHDTxJhvKOndRN2uEbfWBN2r9sWP5pwM5H6e2A6aax0zEXvIXBELN1EnOw80CgpNwXzw2DhyUNhgPKg/qmnHjXBklLnO7MbC7S4xNFm5RPGitIuitDIkITT2TwgKCu6/qeU+ODfKMnHSBa5/7FT5c1lDpH3LKk3x3qk6tjUff9h3Fx96dgMfwwrJAd2u7BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORRjYN2y55yiC/8Og3FAGn9w5Ttz7ljZM3DvIAef2uA=;
 b=dAEzsENI5xU6hZu4Bh232f+U0zXfN93imUEItOAPEjW/oK7f64jO4FcZu7Fl9F5HlUUmC5uvQdeMveaNNgA2KChdZRW1K+6XHpHOF9KJIPAtO3fbx3lf53Oq2ivlePTaJEhi2wsYR2g1J9QVh79z9VPdL1QUPngxs5VtHc+53427XyidWtz5ZHaCZ369rDUzGKsu0yNS25qYa6biTN8U4kMjIL9eZgNZLjgYWtUhR/Uh1qh8eHYIiUfV4j9i/T1aWxzMWsZGu8iRIR95H6+4FKjtMjt6ACHeind318voFf/5kZqhmIb4eX+2eyiw1QrzgbnNtAXyTn1bx5KmTDrN3w==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB7336.namprd02.prod.outlook.com (2603:10b6:510:d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 13:38:23 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 13:38:23 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v3 01/15] qom/object.c: introduce
 OBJECT_CLASS_PROPERTY_SCALAR_GETTER(type) macro
Date: Wed, 19 Aug 2026 14:35:40 +0100
Message-ID: <20260819133816.3497033-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
References: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0046.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::14) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 56dde5c5-eead-4e92-2a5f-08defdf723b3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|23010399003|921020|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0Wb+UHcsl+Elzi7GE3Tl0yo4tit85lfZ+f7OdgHdlBYikcqiiqr+Ypv5LgMZaKSZdV9xLuhydG3tx4s0NQLi7o1Jvv1yKQcdOazWxhUNPNf6LvEqO/vYzyl80PNfOUZXEC+KRtsDBP8xGsYNwFg17AkCFUc5KUn0Pafz8ytKBVguOMWdBPs8nCNDVUmuEqeC42RnGwfqx2bZvfWriFSfLd2ly5oMeI7FcIJOF/39gzla98gk5zm3XUXcC1Ih9szzQVbqIM1AOr3kStReq03x763+Ahj2y0BoQ3Ib3gq3vZg36kPb/bgJMnQST5pIIaafwmwU6xxxTD5dgK5l4mK13AOh7SNl5ldQD3TxEEO9f3acEBli7mcLk1qumBEOA7xxP3UfINyyGhX3OfvxITJm3U169nFlslc7rq3mUgtKeCaQIJaVuzZInGwCLcthrAjpj7dO7KKzbwmmFdDStqAYP3JLM3dJbTWAzckP0fdN1Ev7U1C2e1MTT9ISucUxaJMDM76kSTk6QS1f9/5nPdmFyO5an894jLEkTYu5rxCIiWnjiESDLZ42haQ0eaoICL323K3Wry3DEvTR/4BRWN5qEety/8lfcVojnTpRGnB1zRVVx0S+pRUK+dBS9v5MacnYuD7vmMdu28tubn4ii/hKBYq1JxoH7Fv7jtaswQ98DG6++ssyU3gFq6v2xJAi8srOchX6ZedSb/VHr3/pukC5Og==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(921020)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gImVbVRCGAKFiPcgTTFar2eysVmV/xWN/miTBWotDsKhKbGVFhMUyg98U+H2?=
 =?us-ascii?Q?QqylSLdMPv6yiVWbTnkJm7URizq/9ZtOuEpYPGhr5muGeX3xzbwrQv8lHpAc?=
 =?us-ascii?Q?sCgJtMRwgwRxmMopPNjCytrJwZ33DHDN40/tGP4uWcR4iFDJhWR+DyvoIWdp?=
 =?us-ascii?Q?cNukANaY7TcyiEdfht/u7/EAhHPHzqvRZKRw2YI9u87A6Qp0xRsr9gWi8f1w?=
 =?us-ascii?Q?9XvDU0iid/twya2l60RYDLASk9E3tkhyis/Bu3TH6ZOtYCiflb7ohToLAxHe?=
 =?us-ascii?Q?AoU3xJRYThV1x8aRdfsbMEL7V5EOcyPoKOaotzwaREjLaGU1Fql1kd9SgNCW?=
 =?us-ascii?Q?johTU8ptD7aKBxIdlVQX/6RuhZu4Gaw39rDvEMkgBlnEt66dSIOwIwvdNYqc?=
 =?us-ascii?Q?oAH09J6Vp9nB4z70UsN/vtH6GedTUEfbeavrWCGUmqtYEPCncJt1Cw0VideV?=
 =?us-ascii?Q?efnXoa+0ttUsJfGKC758PpbR1gsJlLhg43ocSi5CGNbneqW8EIHiQOy4ZKdW?=
 =?us-ascii?Q?wQhbgJUyaRG5lPbOilJOLomHdCdIbY0qLHFBuy2lFupcg4BrhrmUn4Ua7xt+?=
 =?us-ascii?Q?3sw4h3o/vUhZm9DzRwgS4XcACRWBI3+t5LlnCZCaxdMKCHftorsUIySIoXwb?=
 =?us-ascii?Q?uhKBJR1M0cXoZU429+BmMT7IaPDZy36Ja6GiBRfoH6T6jC1QzddyZzV04ENP?=
 =?us-ascii?Q?6swp8IN/CH+OxqXFgAhFpEn6ueKp1CRmCYrT6IYWIiO1LBB41HflUgYVlMQQ?=
 =?us-ascii?Q?ryc2lNO1hAEsGp2P4/c/R/C1sCFPX7kN1SWti9XzHK3GQ0B4y7gJSuFQMzzz?=
 =?us-ascii?Q?wJy0AkT6D73LblQAgvzjUUt7oN09APV4YkrmDMxcEENJqh99t5K2wHxCxYqH?=
 =?us-ascii?Q?TiR4EvDq1cAYYWWU0Sqtsa0OqYPn3watxqj3yH3E3jCacfMGZBOc1kOj4eqa?=
 =?us-ascii?Q?7Mhu7Z/k9gPbMRElq/soHStjnsTfMe7xuNXSINn8elDcUMLVUm6+dpgUvYw4?=
 =?us-ascii?Q?OllfxGDnihX6znZ8C41r6r7nRutoPe7K6uAj608kZjAKLvBihZMTvzhEk64e?=
 =?us-ascii?Q?RYzweqpe3k7kahmR0QWUK0EWXBYlWtndiY9mMCYU/uodJAkg0wHUM5WjphMC?=
 =?us-ascii?Q?uUZukYTEgzTUhVs7kS53oVxc7L5kyKtXHrPtLB9FBiKnhNyJQh/N2Dfhkfyv?=
 =?us-ascii?Q?96x8ULKaK38AlJYdzi3V/k9YD7MQmc6xkwSo7Ae5ajkVAcf4WJrJenFE/DnW?=
 =?us-ascii?Q?ulT6q/SQOqBduTI/X+9cuQdczjVgzq5iCWYgrIcWr5QkqPK/0T/yEHKhoVjZ?=
 =?us-ascii?Q?fmr350ZpYdgDsPnq/0i1SAXl77zFdP1ExIJNg0IXJq8lDNmdLAK1FDAlZlY7?=
 =?us-ascii?Q?MVl6I6hm99qnTaGkmFopv6jsA1ZaqBoLUgf8GJXUUJJkk/owiI3Xs2HsVEoK?=
 =?us-ascii?Q?olcJ3MFzXoqPWoRq/g3PlXkCZPNfzlbYhglXwGdaGh+sXwscwO3DeDJHoZyE?=
 =?us-ascii?Q?3cIcp7EvMIeHx3vVQVCvrxBr5rdV6wqSI3eCjWSARrYKbxbKCzWn7aiBRpQI?=
 =?us-ascii?Q?HHz+MilQC5F5IraOZK6fnqeDUXITVp6gJv5nFQOgSIdEXzFsEXADCDHBwgmv?=
 =?us-ascii?Q?sh9M+JP2uljSgn78YoNX6iZJWrdWpN6k5t37OMYuQBEFuA9IJ1Ivqhj0tyHl?=
 =?us-ascii?Q?HwvkhDvqoNiFEY5f4nd2Nn174KOmtX1TGldaK9PGv7GSoDupKlPtz3x+WLI3?=
 =?us-ascii?Q?u5sRZJtwl2bEPpf/Ha9letozv9rwmbc=3D?=
X-Exchange-RoutingPolicyChecked: l6hIHhTBwDaGueVRjGWHVE5fot0I9Tgz1tezms6OyggUQiXoPOWY1LfnAqluh7Lq0fYayA1WD3WzvE/3QSXVHNj1CIsBfZFUXhQVCwA/FhS2BOzNOMpEENyhIIkeoPVpV6yX1QKDg4F5OX/uwM34+r7S2H0Mho3uvJko76fWWLg5xupcvsK7bKvFtRUy+7Law+IGNR2TrpZ0RFNHv7K1/ttAECMN8/WSnqAnCXF+feGE5KFcI4M32aqEq1mpYtcO5DkPNss3LhOZPwPCn2QNHNkK7I+UCynDEM3nAaxlZhshoqSIbPGEl0TSqGnOzkQrWnzyfvehlXY9JnZ6FmCPvQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56dde5c5-eead-4e92-2a5f-08defdf723b3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 13:38:23.3527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YMpKCBpQMwenGtjOWDyEs4SmSCjSzt2zaFp9qVzV0KmsHsIeiuHbGpAkecWn8PMmAyXryqKAxtcQ2OTagKqLf6fz1jyOGDCNmR1qRyBKUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7336
X-Authority-Analysis: v=2.4 cv=INwyzAvG c=1 sm=1 tr=0 ts=6a85b1d0 cx=c_pps
 a=xVCXbABICjn79FXy6fcvAA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=sXIxgEWn3KJhRak5j5kA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfX59Ue+dk9B4kg
 gVvMb9qdzkQmHyon/TzzWrtmrJ8tgjwcoNIMj1JontMfd4VrwXtFDFHficZsq0vYkBegBDaFRJy
 3UNtOntN6yzrTnS+XKT6ui0ceMOcrAo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfXwrAXHDShq1sw
 OFinytmz0OTvHI4HUClqKzh+gHcIycnmL2ibkfhEdjnFUNYrEe3GqdXcA0RQSm75upHOjg7Kyuo
 GqziksoRqnWop6Jm7M64yGJvOJL6rs/PDYCMDhTvktwy3gKUDWBlLr9axIyHF9j1NiK2h02cIFs
 SsqutLBejnKCrKVSIYBYLMJgRRbPXLjkGbI7B94ApIC/Yx4noM2WCF0XK8cQtxpgZsXweOuTV4y
 tpVCqGbRrUvz8PaBtV6zdmsvysOtcGMucAAAAOiVnSCgMn2OPo6IHG/htTPcx56BDLzklV9p8CN
 OGv8AXDX9QArXGqgSJxxyZjGM+/lNrTkrB03TIVPKUKXZRtCHok/pYQ1077JAHqGYcXZD1OrglF
 78Abx25BJblP+jG0UJoD/eIQhHsJ/XxcqtPAsMimFIUvJ3eXFii79kohuVkXcehlIE2GByFWlWG
 OB2LmcsV+fP7GYXinEA==
X-Proofpoint-ORIG-GUID: ZGXUOvxiBcD6eJOR2zZj7naO-K53Wfd5
X-Proofpoint-GUID: ZGXUOvxiBcD6eJOR2zZj7naO-K53Wfd5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

This macro will be used to generate the boilerplate property_class_get_type_ptr()
QOM get function for the specified scalar type.

Note that since the macro is currently unused, the object_class_prop_ptr() helper
function is temporarily marked as __attribute__((unused)) to allow compilation to
succeed.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 qom/object.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/qom/object.c b/qom/object.c
index 47977b1f44..e32ae30bd5 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2703,6 +2703,28 @@ DEFINE_OBJECT_PROPERTY_SCALAR_METHODS(uint64)
 #undef DEFINE_OBJECT_PROPERTY_SCALAR_METHODS
 
 
+__attribute__((unused))
+static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
+{
+    void *ptr = obj;
+    ptr += offset;
+
+    return ptr;
+}
+
+#define OBJECT_CLASS_PROPERTY_SCALAR_GETTER(type) \
+    static void property_class_get_##type##_ptr(Object *obj, Visitor *v, \
+                                                const char *name, \
+                                                void *opaque, Error **errp) \
+    { \
+        type##_t value = *(type##_t *)object_class_prop_ptr(obj, \
+                                                        (ptrdiff_t)opaque); \
+        visit_type_##type(v, name, &value, errp); \
+    }
+
+#undef OBJECT_CLASS_PROPERTY_SCALAR_GETTER
+
+
 ObjectProperty *
 object_property_add_uint8_ptr(Object *obj, const char *name,
                               const uint8_t *v,
-- 
2.43.0


