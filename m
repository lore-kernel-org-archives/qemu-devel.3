Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C95FC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6nCe-0004p7-Nk; Wed, 16 Sep 2026 06:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n9N-0001fC-VP
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:46:07 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n9L-00035u-OS
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:46:01 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68G8IwgB639332; Wed, 16 Sep 2026 03:45:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=pkJiFODl6b5vPY8FgP6Q0oGKEYfQCpQNYQchDr5v9
 co=; b=e9049sm0PfHTdb/e3IZbpZjrt9trDXuLq7dPoe3fpbjxj/anCFZWZKGC/
 IxNYIHK57znEpgLL2gvBlq9LpSsdOwZYHbCRveetBHJrQPo6HiQBgDiL5uE/rIOt
 3dJw0cwNUQvM360SVben66CvGNt1iPiBhn/666+DdCERXqEgBqw6WyTTmcQBQOKD
 gkiiAIGd2KE73d9rx3GIWNHXszCOZiuHxX5g9PnpI37yPOFnAv3EWAtfcmEnFq+B
 zlV48ktvvViYjA0tmIG4hyE3Ub8XrdlFBIQQPjW4QaPnC7I3xwbNejjRaEGD+NKl
 YRsyO/6dr+mT4zWkId2DbxtxLc7Kw==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023142.outbound.protection.outlook.com
 [40.107.201.142])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gqbx0sysq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 03:45:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rY/IzxnfvawlFNkBlpQ8EedVOLOYiA6TurSUrH28gOvHV9G7qPBuNwfbtciQpp6GmJDJfcec5r1A2Uwk5de0t3NNxpQucCyGfwI85VbLk9nwmrPnfz9BvHBlRXjoIiUIulJaS8+HmiOGUQXzHG6zn+9u/14RMNA274qW9J2d9dz1PCvYgjOp/K7DkdqXe1IaK3hy1ZEYirwqfsf6XDGFXH77CFYaT8A7mYmOQ/OZrNYAvFW1L39JJ5OcsogvHbnCNEg1GffhFxDTFdJ017acAzBaplORhRODxHy9a3wmIT02ooNmeCl1CDxRX7N2flOyv5qjHNXzv6eWuuZiVM3jcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkJiFODl6b5vPY8FgP6Q0oGKEYfQCpQNYQchDr5v9co=;
 b=lwjvvX1cUnsEg99Jr9blNxLy1sXjPD1OzxfdIzUTIP6F177GA/PbedVXIghBelEBIptzu6DXj/HGPU2bWl2pJA+V6EcNUd+S9WuKXOexXl6zzzCtoSAZYHgYfpbHCpaJ8lv/HSs0/YVsxwTxyNAzmXM1HiPx7B0eD87W4pR5A4vWCP6Eeh8GLltmlnmkqm+erSbJfwztis0OpZZU/m5VVNi1zzZOvzkwzTVJ1dn8c/6BxKeHD+05qWPbiHVIDHCOnj/XNKxCpa8f6D4szZiAsHEY5GbmF1LFvtS5vDYQ3urvBEatzM8aabRhrV1GaR/Gx2zC0QxkyTGQrDX8g6nZbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkJiFODl6b5vPY8FgP6Q0oGKEYfQCpQNYQchDr5v9co=;
 b=YPmBrh44ongr2RCK67ATKBA2lSR2kdRpNWV3ZxNXmE8EV2s0orr61mrgzV3ndC6BDvz7m3B5ur65g1A7tbMejiclyg1Ef+Tz35+h4lACqrjJATvFOEqtXzV+hO8uguKod6/MdHbKe6/UvhUdO0iKFO6O50XbY7MfNfmbw2otoKVwmqxSdQgLshPEDu6qWFKGQ4k9w0WnIQmyXbRF8QnC3QJUtp5spF8Xe8dlTGydV0yOt02utmgsQ5aWzsghueC1JVMahGH8g60uWEThwUvLasHHHwwRvKLICX69CXhsP61ed4loy/dg13+sTtiMq+rYkvJt4+FXSBOg290d7xzCug==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PHXPR02MB11343.namprd02.prod.outlook.com (2603:10b6:510:3cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 10:45:52 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 10:45:52 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH 21/22] i8259_common.c: remove static irq_count and irq_level
 variables
Date: Wed, 16 Sep 2026 11:43:49 +0100
Message-ID: <20260916104435.600211-22-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916104435.600211-1-mark.caveayland@nutanix.com>
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0077.namprd05.prod.outlook.com
 (2603:10b6:a03:332::22) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PHXPR02MB11343:EE_
X-MS-Office365-Filtering-Correlation-Id: 7324f8ee-bb0c-4930-96d2-08df13dfadbc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|6133799003|3023799007|10067099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: mny/sBr/FrGXACmPXrz0nt/UdwC9w+7/2ZbBP5GQtLMbTWA0ov4gxTRt9Kpyf6NRnwYxQ5/Ik/aXEdu/Uj9UQWGAZePcYSWfhTxY4WbpGpzbrXucFJmrt3TrOX+cnKMl1r9f5FCj8dv59rFISyeKlPe1tjQtpBcA5fffGpbIht8YuKWE7iMe+qbrLL/D8IEUH+0tZ7NONrSESBbmZRSnGfl8lyZmMuNMjgAnce9wJuZ8mXtc2LUlK5WORvQT0Na1UNjsa6pVcTk3r3o6U17pMR/fezto2RsvfNVVdxUT+O2du8AQ7fln5V7v0G01Xd+87C0TbivwRASZoQx9GlT8ZeUuI/UcWysfnMvE8Qop0tRMLS+YTglw4ydnGcQmnPjr43K+R23fexkruAud6Wt+E17OJxtPB4gOG/P6hJm0cyGdbF3xMdGUXlwED2I19PXeg5h9kV5PcMx6b/bnxb/MFYhMTLE/fdrGlpYrt3Q/7DMqUpF0JhR/Me0G5D9+gb5lDs4vil8QMSNjIYBsCQ5YFbgthZwPPvBQ5fhYjmzA+qrQ7YpFC0/QlLUVa2QAUisbcUhACOjc9RAil/pDFkkkuH0M6T7u8Z8o5p8SlfsSnqG/N1AILi+ytcNcFBjfVcr5+ZmM4WaWuKV3Fhq3E9rsIeNeiRTb02rVKesHH2T1n8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(6133799003)(3023799007)(10067099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2X9TcRXiJULb99j7T6SQRPC2gtmRqJkHeZXbC9UfcqnS8sx+Ypwcyp8FZXYS?=
 =?us-ascii?Q?ABMuuwk37B1/8gkBe0LGkZySJ89JvUhsLjaXJ/1mcG+7myZVlFL2/jT108jU?=
 =?us-ascii?Q?OKjtK6GRxQ2dsVSy6Scx7Cm4a34b3rnscBKXAstHzEpFJmvfplyJbbZCl8Gv?=
 =?us-ascii?Q?ZVrUMfzF+oUggugqTSw72zW6dGtba5a1DOKczwyP5kp59ORZ/wHlyIPdYOYm?=
 =?us-ascii?Q?5CyEspxIzjcwSKYbv+ir30oSKdYG3R8i8rzrfDPLGiM2IcqQKAwc6DURIFXb?=
 =?us-ascii?Q?nU+HX4rRkUrEmCfCvHPDfUxOFyckb3rriznHoxSaZdOgzhqfD0wT8Sz2pvDO?=
 =?us-ascii?Q?4ylbOMj2nzGyDcHqUR5t3L50YUGvCTbVIyJmRSI/C81lavu+h8fmzVgn1IFM?=
 =?us-ascii?Q?zL1TVEgtj6mub/nmLZ/KJDvX3+/Trnecb7rQ2Jg5sIyNn38dBjahB30WvPiL?=
 =?us-ascii?Q?LUMQ9FuUve12fWArvWzvds6+UJL2cOE0enla68Q1Nu4mzNqXpGFTttXcYl6c?=
 =?us-ascii?Q?z0bYry+poVCpobr/YoNeM1sXUlXjOxJOzhhcHtTFyFoFGcLcF6lMUuIY/48b?=
 =?us-ascii?Q?spVZBmqN8q0DB5CasgpUJ73Rxec4Xhpv4xVFPIWZ8yq1s33XqddZ7WqxtFwJ?=
 =?us-ascii?Q?hojQ4m2IYuE1L0owiTR009Eh5P7fiKJiMhZ3s50TUzRB4ZZm5F7ISASWBUq6?=
 =?us-ascii?Q?Xx0bymFj7erCJrZgUXQ5B/DSwbeXjYRLk9tLKZRyYpr0ZtJi3iX/JBYq2b8K?=
 =?us-ascii?Q?inSl2YdzbAczMNNEgV1cNMcW6IYaCKIBGShZzMLdTunE+xN4EoqTaDy+W0HJ?=
 =?us-ascii?Q?XWVe7X20KOVEHzEIS8jdxL7aIwf3wDABFaium71xWZfCq/VNr9ep7DJf7xF7?=
 =?us-ascii?Q?mSvaxXkfZAsNEvJIh/Jypulqbj/KQKTY0+Qvf9d6eYIVmcA1H8Qbuurf+iwG?=
 =?us-ascii?Q?9NoIULh3pbX/8zkJh4mvzmSvouKdQMlbIFXHTyXoB8U1SrPBXjt5Mc10LSNG?=
 =?us-ascii?Q?FnlKEBBcMkV7xGf2zGlPZWPfG+q5CGZScjlD5jdeFSKuT3jUpF2JByZzu4Nx?=
 =?us-ascii?Q?EwEAENvn28NRJkagv6YILcRlbuwh9Ydu9cCt0id2mwTem19CeNaYEVXLDJDx?=
 =?us-ascii?Q?eJVRx5eHoYaJF+o5Iw6FuRorE2oQ1kWQe/3FS2yK5C3QLj0EgXKmMG2NQ0q4?=
 =?us-ascii?Q?wtutMBFgOB4n8aaAM8mr9fer8hx+zoePI3TaXePZYSB2Vli7wwJVAE7/W5Lv?=
 =?us-ascii?Q?CIeyU6xB6Ba7hv+rVuT5NsSUdPlFCg34UY8qXgjVrut+LP+zPRsX2Cng1Pwb?=
 =?us-ascii?Q?w+QPuGPjAzIZWeNFMcWpWDZHyubJiepvRAXxPe3g8w2w2jAhLmevZvGyJM6v?=
 =?us-ascii?Q?ySpTGeS7zTdLal8SbOqz+TYjBEr27iH6srNkee28MQ1hB2Fe9BCKjWinRQ+T?=
 =?us-ascii?Q?KYWjNOo7Asi0uG6JxSRC/odDcN4M85I5UfFrvyDaVBsboSeZPFazSKsCnQ7G?=
 =?us-ascii?Q?Te/1/IG+UYK09TgXjLbAzzczdrJHD5rr9XcQ1YURk6tm3NcGbrzEeLRGTLHe?=
 =?us-ascii?Q?y59HugkI0+2QlbHN6kBmiKaozmHFL5uM2YPFJO4VVn/W64cc1gqLTrOhoNGJ?=
 =?us-ascii?Q?bV2BXDhABNUyT7b279eC6iKRCk2iQhtexoMBq/Vc8sEYlUVWUAKefyx1T7+R?=
 =?us-ascii?Q?vxBcpU84mX3P73xIhv8+ZC3mT+j3MFnvtkeo+ZQ+P4R/+JUJ/WuYzfD6VMPx?=
 =?us-ascii?Q?tCAuwfbQtOWLyom57THudj48mrXNjaE=3D?=
X-Exchange-RoutingPolicyChecked: KTivrjYdFvR7SJHrTTBQzO5zaHde9OiVioRlXndUZzYsc9CQ4KNRDFEIoMJPBBdGQbvA/c9RKoVHge2XcgtSW3LxOE864nnbWD4Nhf6ZeEc77PoKt5nTtvRgp9n9sPoX6MoewabeRsALjCdpN2YB3H5PxAAUPlPUK99j8SCJrWh9yAFQG2lL+HzBATwFpIy09ADfz4fpvhaOnfmSBGFf/SpNaCeyqETrzoilx4UFtwHHZ7ANjdNtnVWIT/j6q6tDIBbH1fCeAL7c1ONutkOyZDEQYzshOwaz0V+MpU86h4byZI2BxCEeUzmInw1kgTNk+eGgv5EKp5Gdu1tM9nDGgw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7324f8ee-bb0c-4930-96d2-08df13dfadbc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:45:52.6825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSxUaaZf+rCVhXhIsmBB4cJg6SsDwqqWoeVwkOEUYYlsbMyXk9WXDqm5UIDfJcadDc76n9ijQFtb8p4GMg/bHZfOTEe2M4wUycvJUBlcADY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR02MB11343
X-Authority-Analysis: v=2.4 cv=Xq5vqlF9 c=1 sm=1 tr=0 ts=6aaa7362 cx=c_pps
 a=nzP3m+/CqRdBhj8fzGTHBQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=KJqig-R1GVLqmjI8InkA:9
X-Proofpoint-ORIG-GUID: WfxuQKVPr1TjN3bNhFd63-_04f_peMQh
X-Proofpoint-GUID: WfxuQKVPr1TjN3bNhFd63-_04f_peMQh
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfX5UNtd2mNsJum
 XxPo9EBN659z2gNVDxbcWR9b4FW+aTQPHhrSycdSTvKg/6vxyMmYwJSObgfzewZJP9PiidJ89S6
 692RIxLRpfIq9loS0TtKWqkiv+hevcU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfX7MOwfRkdisx0
 bjEnOu6jpiYP887LHQj9oYMyv5JwN3ofpx0aVnzUy7X2m4khh+fwq0etKCMQ8SNQbcC7unWMOVJ
 mMgTyDI+PMJLuCHbdcFo95VRILXapfrEAUiYYyi1mnsUKH8OHYDwTNPuCofBJmq+jjSeqMxw3i5
 fQd1x5raPK/EatgA2L0jTc9JpYaeU9D1a2l9/8WyIX83+spH1L1szQApbg4uC9PrNRGOvyXOS1Y
 PbfYRwHULsUcc36bZUeFxME25LSOjAL7G4y4tjHfeEFr4jqiMx5RdD6P/Hz5MXqeb1Olw1Ob/IS
 UIHhgmbf6tX8WnMz2vbSsafH/A3UdocCmmIw4LiibB/lReUzQMR5mQaXyFVTi2yDePbF+jcPTVi
 hYc5mCeDGpVigdlfD3Ue/FMGQlEfmgEG9y6ydcU5IdV0sA0bsLZBIQ6RvfhFS802t4PxTLlxpUU
 yeGZ2YvKI1Sb8FdrI6Q==
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
index 72be7c3de2..2efdaaca2b 100644
--- a/include/hw/intc/i8259.h
+++ b/include/hw/intc/i8259.h
@@ -21,9 +21,6 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in);
 qemu_irq *kvm_i8259_init(ISABus *bus);
 int pic_get_output(I8259PICState *s);
 int pic_read_irq(I8259PICState *s);
-bool i8259_pic_get_statistics(InterruptStatsProvider *obj,
-                              uint64_t **irq_counts,
-                              unsigned int *nb_irqs);
 void i8259_pic_print_info(InterruptStatsProvider *obj, GString *buf);
 
 #endif
diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index 53751b045b..53d8e087eb 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -72,6 +72,7 @@ struct I8259CommonState {
 };
 
 void i8259_common_reset(I8259CommonState *s);
-void i8259_stat_update_irq(int irq, int level);
+void i8259_stat_update_irq(uint64_t *irq_levels, int *irq_counts,
+                           int irq, int level);
 
 #endif /* QEMU_I8259_INTERNAL_H */
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 421c9279cd..ca661afc02 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -30,6 +30,9 @@ struct KVMI8259PICState {
 
     ISABus *isabus;
     I8259CommonState i8259[2];
+
+    int irq_level[ISA_NUM_IRQS];
+    uint64_t irq_count[ISA_NUM_IRQS];
 };
 
 OBJECT_DECLARE_SIMPLE_TYPE(KVMI8259PICState, KVM_I8259_PIC)
@@ -102,6 +105,18 @@ static void kvm_i8259_put(I8259CommonState *s)
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
     I8259CommonState *s = I8259_COMMON(dev);
@@ -114,9 +129,10 @@ static void kvm_i8259_reset(DeviceState *dev)
 
 static void kvm_pic_set_irq(void *opaque, int irq, int level)
 {
+    KVMI8259PICState *s = opaque;
     int delivered;
 
-    i8259_stat_update_irq(irq, level);
+    i8259_stat_update_irq(s->irq_count, s->irq_level, irq, level);
     delivered = kvm_set_irq(kvm_state, irq, level);
     kvm_report_irq_delivered(delivered);
 }
@@ -210,7 +226,7 @@ static void kvm_i8259_pic_class_init(ObjectClass *klass, const void *data)
 
     dc->realize = kvm_i8259_pic_realize;
     device_class_set_props(dc, kvm_i8259_pic_properties);
-    ic->get_statistics = i8259_pic_get_statistics;
+    ic->get_statistics = kvm_i8259_pic_get_statistics;
     ic->print_info = i8259_pic_print_info;
     /*
      * Reason: must be wired to the ISA bus via the "bus" property
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 3f10777036..ac43995ce4 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -49,14 +49,16 @@ struct I8259PICState {
     ISABus *isabus;
     IRQState i8259_primary_out_irq;
     I8259CommonState i8259[2];
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
@@ -123,16 +125,8 @@ static void i8259_set_irq(void *opaque, int irq, int level)
 {
     I8259CommonState *s = opaque;
     int mask = 1 << irq;
-    int irq_index = s->master ? irq : irq + 8;
 
     trace_pic_set_irq(s->master, irq, level);
-    i8259_stat_update_irq(irq_index, level);
-
-#ifdef DEBUG_IRQ_LATENCY
-    if (level) {
-        irq_time[irq_index] = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    }
-#endif
 
     if (s->ltim || (s->elcr & mask)) {
         /* level triggered */
@@ -209,7 +203,7 @@ int pic_read_irq(I8259PICState *s)
     printf("IRQ%d latency=%0.3fus\n",
            irq,
            (double)(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) -
-                    irq_time[irq]) * 1000000.0 / NANOSECONDS_PER_SECOND);
+                    s->irq_time[irq]) * 1000000.0 / NANOSECONDS_PER_SECOND);
 #endif
 
     trace_pic_interrupt(irq, intno);
@@ -439,10 +433,30 @@ static void i8259_class_init(ObjectClass *klass, const void *data)
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
index 7980f86f1f..3511303c21 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -30,8 +30,6 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 
-static int irq_level[16];
-static uint64_t irq_count[16];
 
 void i8259_common_reset(I8259CommonState *s)
 {
@@ -89,26 +87,17 @@ static void i8259_common_realize(DeviceState *dev, Error **errp)
     qdev_set_legacy_instance_id(dev, s->iobase, 1);
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


