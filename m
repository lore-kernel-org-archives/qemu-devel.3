Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16ECDCCF2C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHir2-0005fK-TF; Fri, 16 Oct 2026 10:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHiq0-0004AG-Ac
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:23:13 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHipx-0006oe-1o
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:23:11 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE58vc1681992; Fri, 16 Oct 2026 07:22:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=TF9awKXkBCrr4rHv9LgEquEb3ahubq6gRo9qNTd7t
 jc=; b=tJMUcPaf9dnYYkuxtxuAqABVClHLGL/F6VcPg7NBoAMLwgtG9oTrthHbr
 Bv2TjaCgy+00Q/Q93VqwErApr3pMJhALR+i+26xp+gcH8ETdfB4PQllt3sN4CaZH
 kosV4xsyyTI5PCqcWbcBlN1N4jsVfr4lTt4FfAcBgIaLZKeaVMZ73pss4jn1zNzC
 0SNRojgoqoUTMPqbW+nF+N0iqGYAyPoa8OOTgA4wi0X3TfYQSGE2fOyYbdr7wbU0
 KcQdcRU7LP5w0VHynR1Ina4SIoG5NgoAf/+QUnt0GPquwoL1uFktl+Up62tjnwgR
 GzNd1P1eN1344gSfawRt3msUj2c2Q==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021130.outbound.protection.outlook.com [52.101.62.130])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hberu10kd-3
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 07:22:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEsJUnkoqwM1Gm4DJQ+PrIDD0PLPeJepLVkK2Ks+Xg/Mw2c5i1OEsVliUAt19Fx+tFSlSzwrNwlNa4uPiObXw1QS0AP9R7/WeKryqGC8P1OsFloJ64fxiddeoMkywEDCKoLGmvf9o6/igZbVJkaaW4E/3GhEh+fL87aN01bfHfwiLn3Kc4z5I47Vlkyh7b6btWkssgcAH9vl+5ChdXLmu08eCEslmDCo9A6+QHaKHylc56i9u3swCgLtAUAgNdZfNDqumyicj+N1dKJFrTItMhZI4CpAEC6Qcu84FKyAmMdlYqHZfBQSthDUzsZHPGDEKogq9zCeqcC1qiywXq1Giw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TF9awKXkBCrr4rHv9LgEquEb3ahubq6gRo9qNTd7tjc=;
 b=MtV4fKv+XLOHEDbSc2QiirjqW7tXUC9Nm8vrFVZEP79/YKU9GO8zUGbhDur5QeblnCIdy+8ZjZmA/Hdfy28999H28hsYJfhVOdokHNx7txuMZQd8u6bz5LcXblNZ4VnYFral8k6qIs7dgJYf+Ipcs73yvKMH+dxOaYT27tGQ9folNkfMaSNtrS3z1TDRLWUqbkuwbz5uvK3cAbeZOUNkl50DHlNRJb+fWzswtmLNO18lTDetsffVDbC1fPQf4RDVHtvNBi/+A0liNs5QuOzPt6NRtU8XUigg3xeNBioDe0fJbY/1IQNclrVLoZfLl5ApLDaC0WEZ0+Zyf3XBcugpZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TF9awKXkBCrr4rHv9LgEquEb3ahubq6gRo9qNTd7tjc=;
 b=hEltSo+/aKMEBK4Uy8SMG4KSfVuBjCu+qcuYDPPrJDJS9agUola3AhNLBG91fJ5F5k6nG0zD5UqhSnY8oYJC4WtL1EYszqJiVISP8KcIxLTH2D5cxcW6a0T1VTOUmev4D0D7EX1R62SW42jkdbEZt8MgaHBns3LphxArN7snxYeJmzj1IAz6HyDx2SldBFboLgBei6Bx/kGvNfPyF8KN5GB8n6UE8d2T/9PPrb+yJo7w9e64AhjTYa8iXnnV7LkcJ4Zkkkh/LlPytwAokYqAchmUq19Ge9+vgVpnPl+xb/M/vkaxPc+ZN9A4EkQ5MBK912HGG+r0V2ze88t339V6mg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA1PR02MB9592.namprd02.prod.outlook.com (2603:10b6:208:3f5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 14:22:25 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 14:22:25 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 26/27] i8259_common.c: remove static irq_count and
 irq_level variables
Date: Fri, 16 Oct 2026 15:19:32 +0100
Message-ID: <20261016142031.1204281-27-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0162.namprd05.prod.outlook.com
 (2603:10b6:a03:339::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA1PR02MB9592:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c00dfc5-7523-4ce3-3569-08df2b90e63f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|56012099006|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 9ZmbQiGv3cuWgyNi6qCP8N+vlRBk7bujvyzZ47buzxCZc836nqPn7j9E0WWJN1uiS3uM+R9my/U/xbQT7VmTHOoJOdX9BpqtyEXMKehjvgo2Bj6o3scLFmuz9n+HTXcwdchjXVHUtXr3RX3Xb51TpdETFH7lhaCvPGQavZdljjHtx6zAKXQeWTnSkin1WOTAMZx4CH+fq4Zvmh4fP2nzPk7kNf2dyyU7iw0bETz70Y6NYdSwLfPaY7rRFrS6k9Ijjpr+Nrr3tnwkYc88ypRC8gLGm/M84+Z/8eRsCwtXEfxBczvLJ2zDeJnGCmnpwq9lTRhdojrKzS4bYMNlkr3aitaxfqPjzeglmOabmwO4Zm3eyeVrwU1bcYwZG3qZDwPQUWGcLqTV113nxSngftR9SRibjyVGAtx+HNLk9E7NhTrg366uywsqGgnhwU7kGMxyR/sB9z3ohj6D18WYqdA9Rldme2n8EeMWLeLCiL0Sx8egsVn+bKm5zSdPXC8rLoQWE0/xAhuoRHVBCP11qGltFAqQZWibTc9demyhqzMf6/AQO4csPvRVd4N9+Ptr+p+4XayJx7/SYgEcsfh5TGi85kwbjtTrweF1SkOYMJNc/VR6OyZgn5V8aAF1sOOCBSGLVLgobrLlwyBRUWOQ8xnY2kPuVfKSnDGo4XVXZZSIUXo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fJj2t8g9LTrxgl4qgQjn0YBZV2X9c47xWHkL8xAS4rE5KY/3Ht7bocPHbLlT?=
 =?us-ascii?Q?vt6/67wVCCAJd4bOVWyFtDe19ak6xcU6kR1b/0I9W41Bd2Tx9Czkb+22WmGD?=
 =?us-ascii?Q?Fit/XpURJJxcmKuxQTtW4Gt22wlgjr3P6hh914NEdWjihUxgX86tlrCZGQOp?=
 =?us-ascii?Q?V2TUXYuvhCaHIyV1edZUl/UV4HROyoPQAVv60DVEPGPnOevRYgFmir5Lwv74?=
 =?us-ascii?Q?SB8OlOnrNV2MryME81jFZ6S21lcehgY5C0RfzSKSw6MnCvTisZNbHnkrCLlX?=
 =?us-ascii?Q?vfJFADr/e2a5P8VAetDasjjXgSSEVAXDtFsTiFJ+0a+/i2TRiIc84Y1H5Q1G?=
 =?us-ascii?Q?Amon87Mw7zKSzcFABusi+46oxTtTpWbNW17ozy4Np+jtP9n/MDlfIY3yaKLm?=
 =?us-ascii?Q?9xKgEnf1ws/S6ykAGJkvgJX4K2htWGQK4mrQLxoVp4LkB9Y0qzADgiwN9icJ?=
 =?us-ascii?Q?D94JVhiQ/j0xIkPDBjA6sKfMiMBgWUKYOzh7yFGzuLRY+lXcS6/uX9Z+VpD7?=
 =?us-ascii?Q?6h2HJBJ3sw6rXVSQuB2We9fRAaHu4T7Z1NqgIsVTSxGkHIikgyedObJ7vpN/?=
 =?us-ascii?Q?OC2c2cOQIE2bbqHD/CkwQS9SjEF+Z52B8Tk6VAaU19IEbzKexEjoqYgya/Z1?=
 =?us-ascii?Q?AN+Xic7uMdZAdw7iuh+1S4HN1qaz6P9A/PwcC+K/iP/AiyIUPjMhjBAIVQHy?=
 =?us-ascii?Q?mIAETV3fkt+MoXQBIz0G4AcRe+OhrZzpUU8hofGGRfxf0dWoGgyfBSGWrf4W?=
 =?us-ascii?Q?ejL2wB0XYDgceg1YRRsx0qSrDGttugzKpOJTRxQ0Cv+vezEmAy++lFvV1R6w?=
 =?us-ascii?Q?YW0UviZp41NbeM8pIuXT3sxCZv0BLjHDc6Q/Bjz1F8myziItI49d3yl66idk?=
 =?us-ascii?Q?jHUgib6zBF0GPa9sGCIWqp3hvF6d+6h3qNngTGL6/zLEkGDc0jktUS8qMxmq?=
 =?us-ascii?Q?zl+OyVudG2StqB6ZuL2vHR5PRc914o9mtwKMY/rXPAh8au4ifKqaAeArtjlB?=
 =?us-ascii?Q?0pj90eEEOhR3NqxPHjYKkYXAwUcIh9FjIZJsY4aTEZRYR1ZpEPrWQW8ejRBM?=
 =?us-ascii?Q?JSzvpsSjLpGsbKBwNJ//9Ls1agSjGbd8vcgQX0g8hdLavW/quyyQBsoU1rLm?=
 =?us-ascii?Q?DP51rOnfEpoRmsdsDlSA/PDiu3YtVh97VTn/hJ7yej9VOp/yLG0QoolcC5Nl?=
 =?us-ascii?Q?vmPEaHW/tjsWaX7LhWAWcvfvrWqFYoXwNRSSUcQVIjHX4K2CODourvrL4ah8?=
 =?us-ascii?Q?uonPkMdrA1b0KM06bzlvRbyrbwH2JPUcPrzJXDYkbTMRP3PWlzSzaGVTVnRP?=
 =?us-ascii?Q?fS7riqdm9f81gkaU10IYSm1axr0RyAsjdd4eT101h04yxjmvlhukQ7KiyKdL?=
 =?us-ascii?Q?N+51/2d1Xytgevx9WoAgSPZxQhkmgvWW5CPdMY5d0+fdT+KgeV3xKKQDZUHY?=
 =?us-ascii?Q?MiWGKjmbXjub96TnM/sOvKlfbMY3nhGTcrdKgwPk44ZkqOa8KUlGVyNh79Pr?=
 =?us-ascii?Q?+yULlxYhVQidu2Xr0SK1Ai8RyKr3Oq2fCjnryfWz8Kpo8YsxV4qE8khth+kv?=
 =?us-ascii?Q?zaYDpQto+EfmBi9DcbuPHTHCdQhYRS6s246QFPqmJTZJY+bdxyY8q0CZH68J?=
 =?us-ascii?Q?VaYPmB9/rby7yZ3zuLT2JioYoWj47fwRqAuvEjNiD/K3IFn8oU17fV/rq/MZ?=
 =?us-ascii?Q?jTpnDHG09X6DmJ2saROleSNj6Kcg4GZ7j5WUol7qy9KJMxiTUSekQA50yRYN?=
 =?us-ascii?Q?0FejQANGWJTHNPeBHmcYRavTQBTbrqU=3D?=
X-Exchange-RoutingPolicyChecked: ToTsIdLdPu29YiBOWdz9b1IK0wHmCk0LLd84KpJKU8YiY2eFqDs/k+Pm7em4gyfVi8B+l4RiAK18P8+lAFcTX86UEjrZNuLELDph/o5Sqk7lJnEvAHvyTqjHjZTEe+0W0SjT9UqThf2ZEG2wjrCTu0Ts2MN9X/DycMumPK2R5SmOlCdwNg56uz9kG8SzyUQnI4pxWmviJdQSwzYjLeeFDOiRcdLk6X4DNXaJ2F19hycp9Higrnb6CXT1/QOxkeFZ3ilYtjYUMzQ74W2AsYdtKN29g44+2aiM923ggtuOMgDSAUIp0QRevt4mPHb0pv28LbpC0Xbckd5NxGE3xQ5sRw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c00dfc5-7523-4ce3-3569-08df2b90e63f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:22:25.1030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7ZIgA8+QgO4ZFtLAcGxZvXwArbWnfXVAiL7ZXxlweJaHc/fndExXdihApKPTshXm0e0SXi8jPlPNXIv2Zjku+69Szl/mnQ3niutsatol7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9592
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX/D/nIcdkaZDv
 YP0NUURKP46e6NPB3wzpdcyCcqJLLsKsdtRlL1HOoQIMYzJ69/+D1JXBgfqkKADeN/OTLEHt6bu
 jfa/RROWioJu6I9UrAv8Cprku6hBCCjdidcIvg26YtBnZxA/74N8azj3svwfxc92VnqWySjJz6L
 8Rc3uyyQF6EPrnMq8HRRyav0vbZ7P733u+7fuF7q/z1bP9YrAxqnEGuLFf5Ub1NO5O53D0JWeTO
 jLfQzuvQ26o3rkm/RLhRNnlkqrPh0yCP2cbS3YArGXYPyYSUvfDSyu9jfgWVgeWYsLIpCQuniGz
 wNaFZFuP/7KkjO4Yo5FetB6pIcrXGGVUq21umxZT24I6a6fZytMLZUa9JhKrAb4WsxcztKZp74Q
 cEXeWwRj6I7nIbD0BQfnYqJIfLLJmCF4eYkTJjVGhZRGBe3i0HkzhKk8xnGAXXdZpEJ11dDOUP8
 ebgLMh6ybkGu+bv2nww==
X-Proofpoint-GUID: ImplHB_Y0D1bMyUUQs9ecSG5PfgMSRir
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX3jc8FpGTCmyi
 QYqBZiqXjH0SP04CYYaR50G5tNNvB7EHqjGBmTTWTo+/3O0XCEAp033tmWwqMsfoB+ygfaPnO4H
 EHNFFbzSxOEaDInLAWf4V+7s75tAXmI=
X-Proofpoint-ORIG-GUID: ImplHB_Y0D1bMyUUQs9ecSG5PfgMSRir
X-Authority-Analysis: v=2.4 cv=KMLPn1Fo c=1 sm=1 tr=0 ts=6ad23341 cx=c_pps
 a=7kgNGXaSmB15KJ6u7rEBag==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=m9Rx451XjQ6kX_1OFlEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

Adjust the parameters to i8259_stat_update_irq() to allow passing in pointers
to the irq_count and irq_level arrays, and then move the arrays into the
corresponding i8259 PIC and KVM PIC devices.

Doing this allows the statistics capture logic in i8259_set_irq() that handles
incoming cascading interrupts to be removed.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/intc/i8259.h         |  3 ---
 include/hw/isa/i8259_internal.h |  3 ++-
 hw/i386/kvm/i8259.c             | 20 +++++++++++++++--
 hw/intc/i8259.c                 | 40 ++++++++++++++++++++++-----------
 hw/intc/i8259_common.c          | 21 +++++------------
 5 files changed, 52 insertions(+), 35 deletions(-)

diff --git a/include/hw/intc/i8259.h b/include/hw/intc/i8259.h
index 4922f88d5b..42d6f992ac 100644
--- a/include/hw/intc/i8259.h
+++ b/include/hw/intc/i8259.h
@@ -20,9 +20,6 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in);
 qemu_irq *kvm_i8259_init(ISABus *bus);
 int pic_get_output(I8259PICState *s);
 int pic_read_irq(I8259PICState *s);
-bool i8259_pic_get_statistics(InterruptStatsProvider *obj,
-                              uint64_t **irq_counts,
-                              unsigned int *nb_irqs);
 void i8259_pic_print_info(InterruptStatsProvider *obj, GString *buf);
 
 #endif
diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index 2807409eff..e0002843a1 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -70,6 +70,7 @@ struct I8259CommonState {
 };
 
 void i8259_common_reset(I8259CommonState *cs);
-void i8259_stat_update_irq(int irq, int level);
+void i8259_stat_update_irq(uint64_t *irq_levels, int *irq_counts,
+                           int irq, int level);
 
 #endif /* QEMU_I8259_INTERNAL_H */
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index b56e4fced4..3e65b243cf 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -45,6 +45,9 @@ struct KVMI8259PICState {
 
     ISABus *isabus;
     KVMI8259State i8259[2];
+
+    int irq_level[ISA_NUM_IRQS];
+    uint64_t irq_count[ISA_NUM_IRQS];
 };
 
 OBJECT_DECLARE_SIMPLE_TYPE(KVMI8259PICState, KVM_I8259_PIC)
@@ -117,6 +120,18 @@ static void kvm_i8259_put(I8259CommonState *cs)
     }
 }
 
+static bool kvm_i8259_pic_get_statistics(InterruptStatsProvider *obj,
+                                         uint64_t **irq_counts,
+                                         unsigned int *nb_irqs)
+{
+    KVMI8259PICState *s = KVM_I8259_PIC(obj);
+
+    *irq_counts = s->irq_count;
+    *nb_irqs = ARRAY_SIZE(s->irq_count);
+
+    return true;
+}
+
 static void kvm_i8259_reset(DeviceState *dev)
 {
     I8259CommonState *cs = I8259_COMMON(dev);
@@ -129,9 +144,10 @@ static void kvm_i8259_reset(DeviceState *dev)
 
 static void kvm_pic_set_irq(void *opaque, int irq, int level)
 {
+    KVMI8259PICState *s = opaque;
     int delivered;
 
-    i8259_stat_update_irq(irq, level);
+    i8259_stat_update_irq(s->irq_count, s->irq_level, irq, level);
     delivered = kvm_set_irq(kvm_state, irq, level);
     kvm_report_irq_delivered(delivered);
 }
@@ -227,7 +243,7 @@ static void kvm_i8259_pic_class_init(ObjectClass *klass, const void *data)
 
     dc->realize = kvm_i8259_pic_realize;
     device_class_set_props(dc, kvm_i8259_pic_properties);
-    ic->get_statistics = i8259_pic_get_statistics;
+    ic->get_statistics = kvm_i8259_pic_get_statistics;
     ic->print_info = i8259_pic_print_info;
     /*
      * Reason: must be wired to the ISA bus via the "bus" property
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 7c9ce2315a..8b1dd57849 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -64,14 +64,16 @@ struct I8259PICState {
     ISABus *isabus;
     IRQState i8259_primary_out_irq;
     I8259State i8259[2];
+
+    int irq_level[ISA_NUM_IRQS];
+    uint64_t irq_count[ISA_NUM_IRQS];
+#ifdef DEBUG_IRQ_LATENCY
+    int64_t irq_time[ISA_NUM_IRQS];
+#endif
 };
 
 OBJECT_DECLARE_SIMPLE_TYPE(I8259PICState, I8259_PIC)
 
-
-#ifdef DEBUG_IRQ_LATENCY
-static int64_t irq_time[16];
-#endif
 I8259PICState *isa_pic;
 
 /* return the highest priority found in mask (highest = smallest
@@ -138,16 +140,8 @@ static void i8259_set_irq(void *opaque, int irq, int level)
 {
     I8259CommonState *cs = opaque;
     int mask = 1 << irq;
-    int irq_index = cs->master ? irq : irq + 8;
 
     trace_i8259_set_irq(cs->master, irq, level);
-    i8259_stat_update_irq(irq_index, level);
-
-#ifdef DEBUG_IRQ_LATENCY
-    if (level) {
-        irq_time[irq_index] = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    }
-#endif
 
     if (cs->ltim || (cs->elcr & mask)) {
         /* level triggered */
@@ -224,7 +218,7 @@ int pic_read_irq(I8259PICState *s)
     printf("IRQ%d latency=%0.3fus\n",
            irq,
            (double)(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) -
-                    irq_time[irq]) * 1000000.0 / NANOSECONDS_PER_SECOND);
+                    s->irq_time[irq]) * 1000000.0 / NANOSECONDS_PER_SECOND);
 #endif
 
     trace_pic_interrupt(irq, intno);
@@ -456,10 +450,30 @@ static void i8259_class_init(ObjectClass *klass, const void *data)
 }
 
 
+static bool i8259_pic_get_statistics(InterruptStatsProvider *obj,
+                                     uint64_t **irq_counts,
+                                     unsigned int *nb_irqs)
+{
+    I8259PICState *s = I8259_PIC(obj);
+
+    *irq_counts = s->irq_count;
+    *nb_irqs = ARRAY_SIZE(s->irq_count);
+
+    return true;
+}
+
 static void i8259_pic_set_irq(void *opaque, int n, int level)
 {
     I8259PICState *s = opaque;
 
+    i8259_stat_update_irq(s->irq_count, s->irq_level, n, level);
+
+#ifdef DEBUG_IRQ_LATENCY
+    if (level) {
+        s->irq_time[n] = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    }
+#endif
+
     qemu_set_irq(s->pass_irqs[n], level);
 }
 
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index 684290fb2d..3bafd81ea7 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -30,8 +30,6 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 
-static int irq_level[16];
-static uint64_t irq_count[16];
 
 void i8259_common_reset(I8259CommonState *cs)
 {
@@ -89,26 +87,17 @@ static void i8259_common_realize(DeviceState *dev, Error **errp)
     qdev_set_legacy_instance_id(dev, cs->iobase, 1);
 }
 
-void i8259_stat_update_irq(int irq, int level)
+void i8259_stat_update_irq(uint64_t *irq_counts, int *irq_levels,
+                           int irq, int level)
 {
-    if (level != irq_level[irq]) {
-        irq_level[irq] = level;
+    if (level != irq_levels[irq]) {
+        irq_levels[irq] = level;
         if (level == 1) {
-            irq_count[irq]++;
+            irq_counts[irq]++;
         }
     }
 }
 
-bool i8259_pic_get_statistics(InterruptStatsProvider *obj,
-                              uint64_t **irq_counts,
-                              unsigned int *nb_irqs)
-{
-    *irq_counts = irq_count;
-    *nb_irqs = ARRAY_SIZE(irq_count);
-
-    return true;
-}
-
 void i8259_pic_print_info(InterruptStatsProvider *obj, GString *buf)
 {
     /* No information for i8259-based PICs */
-- 
2.43.0


