Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F2AC021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 14:50:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklPH-00047t-Uf; Wed, 19 Feb 2025 09:50:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklPE-0003v0-57; Wed, 19 Feb 2025 09:50:32 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklP9-0007a0-OU; Wed, 19 Feb 2025 09:50:31 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JBNXdE020678;
 Wed, 19 Feb 2025 06:50:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=iuKF4UJzddEc5h/Rz9H7FfhJIcYYfZ5IJCF3eIRC8
 G8=; b=alHUR1j/ARXHw8TSnxfur2ay03gIhAfCTj6GA5yqsRB3We30eqcA9AKJ6
 17kUbgomuz4OmZ7jb+QfICkwdsuf2HxZUm9XeX2WcB1aOuvVJ2l8V6kf63FJmDYx
 FxgDhvHrZnnLc6uvFdNoiAXHWkgHUceQMcCQaHNlugSG7t1YRu/JPYritXzWWd2V
 ROCEibSY4BtRdCzq4tevidh2gI6BOL9BTDxXLKHjn4/CGlpXA4p92Ua9PfWF8OIL
 7tNX6eTG1P1ER5zrQM3UCxwoSrLsHn/iEuedyqShEm2XfLzchv0dKUnPdfn30ohO
 sW6SW8EsixEr504TPBOt9E18Pe89g==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazlp17010007.outbound.protection.outlook.com
 [40.93.20.7])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 44w4b9hyef-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 06:50:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OadSdvypRCHlHfDwPTRLmD9sDnNx9sK12nunA7wGfnvqK7vjHhFPswd5+NsKTkVzswnxHFVlbDr3GFB9L8II+SXW3RROOS73g9lV01WQW+0VCuaElE7PqoQJY3E7+fTOVJyvPBeal28xSGbTpm2jg3iSGKcX26TQ8Xqr4pZv+0X4Rba97t6ZjuFheaKIfiHOJ9V55YUgRDCN1+/CrdRtzxLFCFppz5HBhSXURiP5Iw8zkhEb362ve28ym/QH8o3I4dITYV8IwDiTYjm29palj7NAn29yFHuc5mqbV6Jxb9oY7dYWQL3d4/SPxCYOrnhmCrZM9cv14XByGpnsFGdOhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iuKF4UJzddEc5h/Rz9H7FfhJIcYYfZ5IJCF3eIRC8G8=;
 b=oILdIlqx9PylC2f3PslYegG++rLAkXK+fCQt8Ps09NXwBaNf7sdpz86GrpZlGVUFI/qJnButVCTwgwDqdGb4DHG7+BTPNwaW5yhqBrb32qBcGY/cvKnFCzqIl60i47E7kix1G7BjF9Pm9Krlw3HE4K44tlYinYcWgXp4WW1np5wIytJk05dit6IcknHDGY7/Jl2EqXCtw6jzAj6chNRd2fOAVNR6HqZyC+g3/2NBZ6Q62VDHucyQRY9K2dnD1Sqb565oNFjmXp54wkdzT8S6h3NKX8DjriWbPBuJMAoulD9i63IK10RPAdxc5ghXyS4L0XgKqjB9qhqbmz+iWt2bPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuKF4UJzddEc5h/Rz9H7FfhJIcYYfZ5IJCF3eIRC8G8=;
 b=sCuSxQjFTrrHMjw+Ec6fGd+l8Yd3Rk7X+v1b/0AFNcoSBLOECmGjY1uCzl4Hd02GHo6JiPbVBzUB49yfIBs/N2mjI1hLESp726N5k66KjKCTcJWJtiXPrKmCegvfHjvd69U373VKTzJVkshteAWZIT4NyXlLhpxWmk4pi+FGq7jyp6ius8K0x4rXV5y2MpRoVyg70zl+2cMf4WHELoICSESXSprpM+doGfQrqozbyfg9DMgmeuCpzAWiEU4R5ibVCUo0LXJyYiL3Nu913uVr5Kef592czAdXd4IP2iaJj14k+we78TTsvATwa5g763IsjpKyTSzcN5c2pTsq6bt2Eg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH3PR02MB10559.namprd02.prod.outlook.com (2603:10b6:610:204::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 14:50:23 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 14:50:23 +0000
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
Subject: [PATCH v8 21/28] vfio-user: forward MSI-X PBA BAR accesses to server
Date: Wed, 19 Feb 2025 15:48:51 +0100
Message-Id: <20250219144858.266455-22-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2e59852e-f461-454e-c345-08dd50f4bcf1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o9fQmzlFNM25FtbRaS2sGlkn4iBKXOKNiFMmD5dAU6q4V7plBpxPS0lsBJTm?=
 =?us-ascii?Q?g1NDoNtbGgcJrrRhw/BHFcviexpMLepkC3vmTQzv0lwuuZoMTM8Soog/SpdC?=
 =?us-ascii?Q?GTNiX2Nmp1++UFaECkOBAtG/7DTCeBvJr9fThAZqhoW7KJJpXUYvEjFXxsZW?=
 =?us-ascii?Q?ZNTBmEumLFbgO6t1KaSjgGGC/exSE+1KwO9fubVW2Zy1GVoPRBVn7goFc2R4?=
 =?us-ascii?Q?ultjdyJfUcu7iPbj/hfGdM3HP6sElJ1golDNNC+WnM42UcE4K2BwelNHY5dB?=
 =?us-ascii?Q?kO7dh1RiNrcHLcOjOjrEVsurXdLI4a8rpIwHL0m6JNsynVFF9c+6jj71tEHK?=
 =?us-ascii?Q?JDXGC1c7o8xppMA4P+77hbrzLbktvzmc7tfFaPxL9A6cBf8Ewd6PeBAIg7rG?=
 =?us-ascii?Q?fiKpySI6fIh7vA8dy91hfO5j89Ey7JedufDaLviO86Wwb8RB9sw6DKo/cdz2?=
 =?us-ascii?Q?INneQUyabD+Q5YdiqId1FJia8LjE6phE0uFgjlvOi4bE1iklaf4vZUdRooDE?=
 =?us-ascii?Q?afzUipocB4TM6Pyo++SqKn1CC4C1olU+Jeozmro0gTc5u0ZTqPZacTB5KeCh?=
 =?us-ascii?Q?sR7Dts/HqeaL780jV+UFhAeT+wKSYP+TliCJ5miAeC5kEWxxIar0f7j0zaKx?=
 =?us-ascii?Q?tdZZG2IzSJ7lI81MiM+XHxhZl3QfpmCRKSUDBk4t9lsIGCQ4KLo6b4PuDvcC?=
 =?us-ascii?Q?rWZjbLQaoz1+8pCcJeoYEqAUxoHU/8lhphcTVAojDyGi2dyRdwJrpcjI9eCU?=
 =?us-ascii?Q?TRQATiebRtSLNlp4vWFX5AXq1uNecEwJZzUYN4QkICOHxgFl/mjfKDLWbA0G?=
 =?us-ascii?Q?uuo87/ewZyXMxjS2fE9aEetbqB1/nxp/1f7jqKhbw/K/Iyayt0WYkqk7Kp4v?=
 =?us-ascii?Q?qlGapj0eBBIsMIgYrV8Itt0KWPS2QoizxAcjQBkpT62U4dp0FSyQPS5NISYB?=
 =?us-ascii?Q?kXXex8+nHkt/aEfL2BYf6aVKVs9DeBTnl2DS97QcNgte74rsyrV73kKJuvwl?=
 =?us-ascii?Q?M4L972F2EuvKwXTy+N/sZ0GRdd8TvAPP6vdiDvmFRQXyWRmONtkK9QGFn9sG?=
 =?us-ascii?Q?RINT+BaBnd6jvcwph+23ADTR0qxlmIv/F5d2DFFQYz3iDU5tV5QE7BDAYvRQ?=
 =?us-ascii?Q?1a97bw481W/D/7zZxm0cLO+SuwO4lMlL4EOxu86GUdpj3kxKf+U4N4nq0Lf6?=
 =?us-ascii?Q?ot5wJD/BHeTJPqTGuY94kfvIKE5u70Aw3UaPRYlBwtoYehKsNA+b/U8B+GqD?=
 =?us-ascii?Q?L4sLkT+J2Conl01X7xBBEQPTdnxwB7QlieGyUg8i2IhDHlf2tZX2e7LpwcwN?=
 =?us-ascii?Q?rFq/w/hnobVDmFS0XvECP9yzzHI+TcLj0RF4GuGUflRYqSygBInFBE+FtkMw?=
 =?us-ascii?Q?T/VSinVL0Ks7KBR1evS1oOBE7dMP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w3UHfyra16MDnIvIALmMwdQzsgIZSSGp3EMkUrZrH6kTuH9mAb6pmftE4PF7?=
 =?us-ascii?Q?iDOXwvw6P8byKXPR9wC+gnm9fOGeBde+Bbzt6ACl6jS6gTR2QRpy8lrHZrrc?=
 =?us-ascii?Q?N/mSlT+3ODZGcoKS3qwhJiWHPLsj4kZ+4NywNzzidldW0/pmjp2oX9+KVN7A?=
 =?us-ascii?Q?hYR0SzBzRBj3zJnnUHX4vc62YrfjZHE/xtwdqLfQoI17ILos1A7/20p37jh/?=
 =?us-ascii?Q?8GBNzml9fIgfckBntL2DxPh5weZuTJI7NmyGh+r+U7UXotm1aZ8e1wFgYFV4?=
 =?us-ascii?Q?9Mq0O4HSTWW8Buu48JVsnf9M/zXN4z/2B18vCsw1Yr+NQIiBohi+xFzOSxGb?=
 =?us-ascii?Q?2+UO2+naec/Pmh8WTRd9PLPOcxBsLPByG4KqGxQT8K3amOgM29gHv8abuvJd?=
 =?us-ascii?Q?9HnFEUyf3xpxPhPhKUNYM9jnpn8Jbf25oCBd8JW1InodBnhvZfd0zlNhd3Oa?=
 =?us-ascii?Q?elYgVYM4fKY+9K4zU60bdiUQh1otS1c9IvqmsVbXFzDiELr0Ilqrgw7wlYfK?=
 =?us-ascii?Q?o3wNpvlSsBXjkRGlswVuhZg2zuU6yqzGlLmu3JXzl8IS/xGWwfdlyrjAshyT?=
 =?us-ascii?Q?m4Mo6F5lAaiOXQOMj705VvklksrXwKoET8oyh1hO/AJDhyvSs+oNYEZTqxuH?=
 =?us-ascii?Q?w5tU3q+gFGVMwuhZcgD4rKsItb/LSNxDd9RR3AqjnuEtdhZQkyrC11h7VsfP?=
 =?us-ascii?Q?TihxQaLSMt1aa2a44UprdMujFfE0Lsx9JOKB4rR7M2EkYP0fHf7j2G65Y03s?=
 =?us-ascii?Q?TCHOk3CQVwijPws3jeV5cgRL5BfoY5Hzk7YP8yzjoD0wF3FOzFcixN4lJi5+?=
 =?us-ascii?Q?DJ5W6RLbQqjAa2hkYt+6j3CkaB4RsDAFH2r//1VQe9Q/x3NP9aiHx6X0+1Sd?=
 =?us-ascii?Q?CtMM43Mxqyi9jTGFlWkxnZzIrtwzjmGNmvVg+SgDXDJO1eHclssJkRSSNnl2?=
 =?us-ascii?Q?ojENKakJCpUrDfOx55XBFCBZhzlrlmRaiXBJ2k8DoTJZ1TmRNRMH+gfrsXgY?=
 =?us-ascii?Q?77+xsug9eaynlfcMYrDcevzOJ9sO+wx7eLNnguC8eWfjf05m4syC7XOwN1Gv?=
 =?us-ascii?Q?jJAyscuajRy6AcPT0QzPzsseNe9nIAiGDPhn0N8946fEt1kY7pcyrTn9H4QJ?=
 =?us-ascii?Q?9I8pkxgfMnZWhnOHDFW08DKy2FK/k6nL4GVHaiALFnr/+Mh8plQLJUGF4CxE?=
 =?us-ascii?Q?Gst//Krk/ghzzZ6UsQRPz+XbASNHdx4Z5UGi1vVy/wyjVO7freh9EFnFHc/j?=
 =?us-ascii?Q?IYvvmfdM6k2UmJSTCooGbRm+UYsYbkT5hZoEfHcyQGsxhuJy1OdHtmmifutL?=
 =?us-ascii?Q?cCaql5pCrshAjZaq0H4yNNjrWM71Ja+W/Uf39vqTph68rAXTEqtq0TQcKA6j?=
 =?us-ascii?Q?nppjbeCfFOAs258jHaTmwOLbTGZeNi8nJ5TC9agAM3aWae0IB3vD+b/iqZqc?=
 =?us-ascii?Q?kyO2NqeAkBHcu+a6ZJVKw8KL4/aUL/V44ahQWIc3C2EU+0xNd2j+2nD5TRrD?=
 =?us-ascii?Q?ADjaFUpQFgYk7I+a120PyJlELMhZ4IpGsK3OcyST1qC+9eFuIqFqGUb4y+K7?=
 =?us-ascii?Q?8+811kTUJq1TpTxm4TmVzu5JopEabXikkuKHLea9?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e59852e-f461-454e-c345-08dd50f4bcf1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:50:23.0169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Odg0gPqYUyX7iKB5oYFyI27lHhge4M3tHWAnwj2jV38hdxH5IqPxiHfdzW8OJLGv/cX829rLIaygqOOTVTbtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10559
X-Authority-Analysis: v=2.4 cv=e7j8Sbp/ c=1 sm=1 tr=0 ts=67b5efb0 cx=c_pps
 a=2D6/CIrCIWs5X5ruZf5FWQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=1d_4kwcE-g3AVD5dyDkA:9
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-GUID: W-dsrnnRVv7eEiwIPZ0Tozsbgy52MpYr
X-Proofpoint-ORIG-GUID: W-dsrnnRVv7eEiwIPZ0Tozsbgy52MpYr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_06,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

For vfio-user, the server holds the pending IRQ state; set up an I/O
region for the MSI-X PBA so we can ask the server for this state on a
PBA read.

If VFIO_IRQ_INFO_MASKABLE is set for VFIO_PCI_MSIX_IRQ_INDEX, record
this in ->can_mask_msix, and use it to individually mask MSI-X
interrupts as needed.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/pci.c            | 63 +++++++++++++++++++++++++
 hw/vfio/helpers.c             | 26 +++++++++++
 hw/vfio/pci.c                 | 86 +++++++++++++++++++++++++----------
 hw/vfio/pci.h                 |  2 +
 include/hw/vfio/vfio-common.h |  2 +
 5 files changed, 156 insertions(+), 23 deletions(-)

diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index b8c1cc34c2..cf1e642399 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -40,6 +40,62 @@ struct VFIOUserPCIDevice {
     bool no_post;       /* all regions write are sync */
 };
 
+/*
+ * The server maintains the device's pending interrupts,
+ * via its MSIX table and PBA, so we treat these accesses
+ * like PCI config space and forward them.
+ */
+static uint64_t vfio_user_pba_read(void *opaque, hwaddr addr,
+                                   unsigned size)
+{
+    VFIOPCIDevice *vdev = opaque;
+    VFIORegion *region = &vdev->bars[vdev->msix->pba_bar].region;
+    uint64_t data;
+
+    /* server copy is what matters */
+    data = vfio_region_read(region, addr + vdev->msix->pba_offset, size);
+    return data;
+}
+
+static void vfio_user_pba_write(void *opaque, hwaddr addr,
+                                  uint64_t data, unsigned size)
+{
+    /* dropped */
+}
+
+static const MemoryRegionOps vfio_user_pba_ops = {
+    .read = vfio_user_pba_read,
+    .write = vfio_user_pba_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void vfio_user_msix_setup(VFIOPCIDevice *vdev)
+{
+    MemoryRegion *vfio_reg, *msix_reg, *pba_reg;
+
+    pba_reg = g_new0(MemoryRegion, 1);
+    vdev->msix->pba_region = pba_reg;
+
+    vfio_reg = vdev->bars[vdev->msix->pba_bar].mr;
+    msix_reg = &vdev->pdev.msix_pba_mmio;
+    memory_region_init_io(pba_reg, OBJECT(vdev), &vfio_user_pba_ops, vdev,
+                          "VFIO MSIX PBA", int128_get64(msix_reg->size));
+    memory_region_add_subregion_overlap(vfio_reg, vdev->msix->pba_offset,
+                                        pba_reg, 1);
+}
+
+static void vfio_user_msix_teardown(VFIOPCIDevice *vdev)
+{
+    MemoryRegion *mr, *sub;
+
+    mr = vdev->bars[vdev->msix->pba_bar].mr;
+    sub = vdev->msix->pba_region;
+    memory_region_del_subregion(mr, sub);
+
+    g_free(vdev->msix->pba_region);
+    vdev->msix->pba_region = NULL;
+}
+
 /*
  * Incoming request message callback.
  *
@@ -154,6 +210,9 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     if (!vfio_add_capabilities(vdev, errp)) {
         goto out_teardown;
     }
+    if (vdev->msix != NULL) {
+        vfio_user_msix_setup(vdev);
+    }
 
     if (!vfio_interrupt_setup(vdev, errp)) {
         goto out_teardown;
@@ -206,6 +265,10 @@ static void vfio_user_instance_finalize(Object *obj)
     g_free(vdev->emulated_config_bits);
     g_free(vdev->rom);
 
+    if (vdev->msix != NULL) {
+        vfio_user_msix_teardown(vdev);
+    }
+
     vfio_pci_put_device(vdev);
 
     if (vbasedev->proxy != NULL) {
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 6bc7600ab1..2ab30fa91b 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -73,6 +73,32 @@ void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index)
     vbasedev->io->set_irqs(vbasedev, &irq_set);
 }
 
+void vfio_mask_single_irq(VFIODevice *vbasedev, int index, int irq)
+{
+    struct vfio_irq_set irq_set = {
+        .argsz = sizeof(irq_set),
+        .flags = VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_MASK,
+        .index = index,
+        .start = irq,
+        .count = 1,
+    };
+
+    vbasedev->io->set_irqs(vbasedev, &irq_set);
+}
+
+void vfio_unmask_single_irq(VFIODevice *vbasedev, int index, int irq)
+{
+    struct vfio_irq_set irq_set = {
+        .argsz = sizeof(irq_set),
+        .flags = VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_UNMASK,
+        .index = index,
+        .start = irq,
+        .count = 1,
+    };
+
+    vbasedev->io->set_irqs(vbasedev, &irq_set);
+}
+
 static inline const char *action_to_str(int action)
 {
     switch (action) {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index f85215417d..b9c7e13053 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -520,11 +520,30 @@ static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
     kvm_irqchip_commit_routes(kvm_state);
 }
 
+static void set_irq_signalling(VFIODevice *vbasedev, VFIOMSIVector *vector,
+                               unsigned int nr)
+{
+    Error *err = NULL;
+    int32_t fd;
+
+    if (vector->virq >= 0) {
+        fd = event_notifier_get_fd(&vector->kvm_interrupt);
+    } else {
+        fd = event_notifier_get_fd(&vector->interrupt);
+    }
+
+    if (!vfio_set_irq_signaling(vbasedev, VFIO_PCI_MSIX_IRQ_INDEX, nr,
+                   VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
+        error_reportf_err(err, VFIO_MSG_PREFIX, vbasedev->name);
+    }
+}
+
 static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
                                    MSIMessage *msg, IOHandler *handler)
 {
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIOMSIVector *vector;
+    bool new_vec = false;
     int ret;
     bool resizing = !!(vdev->nr_vectors < nr + 1);
 
@@ -539,6 +558,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
             error_report("vfio: Error: event_notifier_init failed");
         }
         vector->use = true;
+        new_vec = true;
         msix_vector_use(pdev, nr);
     }
 
@@ -565,6 +585,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
                 kvm_irqchip_commit_route_changes(&vfio_route_change);
                 vfio_connect_kvm_msi_virq(vector);
             }
+            new_vec = true;
         }
     }
 
@@ -574,38 +595,35 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
      * in use, so we shutdown and incrementally increase them as needed.
      * nr_vectors represents the total number of vectors allocated.
      *
+     * Otherwise, unmask the vector if the vector is already setup (and we can
+     * do so) or send the fd if not.
+     *
      * When dynamic allocation is supported, let the host only allocate
      * and enable a vector when it is in use in guest. nr_vectors represents
      * the upper bound of vectors being enabled (but not all of the ranges
      * is allocated or enabled).
      */
+
     if (resizing) {
         vdev->nr_vectors = nr + 1;
     }
 
     if (!vdev->defer_kvm_irq_routing) {
-        if (vdev->msix->noresize && resizing) {
-            vfio_disable_irqindex(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
-            ret = vfio_enable_vectors(vdev, true);
-            if (ret) {
-                error_report("vfio: failed to enable vectors, %d", ret);
-            }
-        } else {
-            Error *err = NULL;
-            int32_t fd;
-
-            if (vector->virq >= 0) {
-                fd = event_notifier_get_fd(&vector->kvm_interrupt);
+        if (resizing) {
+            if (vdev->msix->noresize) {
+                vfio_disable_irqindex(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
+                ret = vfio_enable_vectors(vdev, true);
+                if (ret) {
+                    error_report("vfio: failed to enable vectors, %d", ret);
+                }
             } else {
-                fd = event_notifier_get_fd(&vector->interrupt);
-            }
-
-            if (!vfio_set_irq_signaling(&vdev->vbasedev,
-                                        VFIO_PCI_MSIX_IRQ_INDEX, nr,
-                                        VFIO_IRQ_SET_ACTION_TRIGGER, fd,
-                                        &err)) {
-                error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
+                set_irq_signalling(&vdev->vbasedev, vector, nr);
             }
+        } else if (vdev->can_mask_msix && !new_vec) {
+            vfio_unmask_single_irq(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
+                                   nr);
+        } else {
+            set_irq_signalling(&vdev->vbasedev, vector, nr);
         }
     }
 
@@ -633,6 +651,12 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
 
     trace_vfio_msix_vector_release(vdev->vbasedev.name, nr);
 
+    /* just mask vector if peer supports it */
+    if (vdev->can_mask_msix) {
+        vfio_mask_single_irq(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX, nr);
+        return;
+    }
+
     /*
      * There are still old guests that mask and unmask vectors on every
      * interrupt.  If we're using QEMU bypass with a KVM irqfd, leave all of
@@ -704,7 +728,7 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
         if (ret) {
             error_report("vfio: failed to enable vectors, %d", ret);
         }
-    } else {
+    } else if (!vdev->can_mask_msix) {
         /*
          * Some communication channels between VF & PF or PF & fw rely on the
          * physical state of the device and expect that enabling MSI-X from the
@@ -721,6 +745,13 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
         if (ret) {
             error_report("vfio: failed to enable MSI-X, %d", ret);
         }
+    } else {
+        /*
+         * If we can use irq masking, send an invalid fd on vector 0
+         * to enable MSI-X without any vectors enabled.
+         */
+        vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX, 0,
+                               VFIO_IRQ_SET_ACTION_TRIGGER, -1, NULL);
     }
 
     trace_vfio_msix_enable(vdev->vbasedev.name);
@@ -2772,7 +2803,7 @@ bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
     struct vfio_region_info *reg_info = NULL;
-    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info) };
+    struct vfio_irq_info irq_info;
     int i, ret = -1;
 
     /* Sanity check device */
@@ -2833,8 +2864,17 @@ bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
         }
     }
 
-    irq_info.index = VFIO_PCI_ERR_IRQ_INDEX;
+    irq_info.index = VFIO_PCI_MSIX_IRQ_INDEX;
+    irq_info.argsz = sizeof(irq_info);
+    ret = vbasedev->io->get_irq_info(vbasedev, &irq_info);
+    if (ret == 0 && (irq_info.flags & VFIO_IRQ_INFO_MASKABLE)) {
+        vdev->can_mask_msix = true;
+    } else {
+        vdev->can_mask_msix = false;
+    }
 
+    irq_info.index = VFIO_PCI_ERR_IRQ_INDEX;
+    irq_info.argsz = sizeof(irq_info);
     ret = vbasedev->io->get_irq_info(vbasedev, &irq_info);
     if (ret) {
         /* This can fail for an old kernel or legacy PCI dev */
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 7e126822f9..db1b2010fe 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -114,6 +114,7 @@ typedef struct VFIOMSIXInfo {
     uint32_t pba_offset;
     unsigned long *pending;
     bool noresize;
+    MemoryRegion *pba_region;
 } VFIOMSIXInfo;
 
 /*
@@ -183,6 +184,7 @@ struct VFIOPCIDevice {
     bool defer_kvm_irq_routing;
     bool clear_parent_atomics_on_exit;
     bool skip_vsc_check;
+    bool can_mask_msix;
     VFIODisplay *dpy;
     Notifier irqchip_change_notifier;
 };
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 5adbff4fa7..cf2033d6c0 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -267,6 +267,8 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
 void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
 void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
 void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index);
+void vfio_unmask_single_irq(VFIODevice *vbasedev, int index, int irq);
+void vfio_mask_single_irq(VFIODevice *vbasedev, int index, int irq);
 bool vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
                             int action, int fd, Error **errp);
 void vfio_region_write(void *opaque, hwaddr addr,
-- 
2.34.1


