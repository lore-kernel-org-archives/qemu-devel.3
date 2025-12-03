Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5083D12691
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 10:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQjhu-0004XU-2P; Wed, 03 Dec 2025 05:03:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vQjhs-0004V8-JA
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 05:03:32 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vQjhp-0002yx-L9
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 05:03:32 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B37xXUY834742; Wed, 3 Dec 2025 02:03:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=OjbsQ4asgv+IMl6PxX93eHGUlwPMYUuJDrZoMz7WD
 es=; b=R7BjCeTuTyIpIYdeUtgnD6ZYes6ZqCb8UKdwCGXbpN3WR186iPGC2Msln
 r7MHHo/rMCQ5S89Ho2a1VNPOu91P6TKWr2uWPNSg6LoQpe7Q79Rbf795XZCLqiT6
 0pLpf6pF+le0meeg1jgzD0mP2NtiWuY3Oz0Nn28XVZZyy0LKRfjvaDZbLsAN6IYb
 l/57mL+OJbhVBebgBaAGofctXxprImiDpXYDTOjuPYI7F9xkUwlzk6RFU7NANvvz
 u33n898FxMKySysjKFMG6G9iaKs7YKuotxD8zGTGO0dTlLv3j9w0XnOlBESNHKXH
 d6TQjDYSXjeXVTg/WH8D51WfLERFQ==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020112.outbound.protection.outlook.com [52.101.85.112])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4at4909wwb-4
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 03 Dec 2025 02:03:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vg7NN1tWT4Hsq3fgYdfvYNkEShKM0mBhEIotzMvwS93rwSqIUDxPBtmRBPoUGRY/P0Ni2CdsJEQ47pDYBzmUW5jT8yixPTuHHhMxIyrVPSqT0sT+AeAOYYn0Xgiety7TPDdo/34AP+y0kvFndITlKCwoN5VMfJ7BQBLSelx7sFpuNrvf1OxY+qrkTn0UqN10mvz0aeRhJzasYlSiK+RKH2sRla0uUqo7J6PuoWwpYgeLbOWxlT+6Fqn5EdFVR1S4y9lGSRnDIEbo3MjCJw5IVeDW123le6eexe6S8DX85XR2DmO9j9UC3V73dsQOx6UyQnFbEC2euMNSD0e32Wdnbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjbsQ4asgv+IMl6PxX93eHGUlwPMYUuJDrZoMz7WDes=;
 b=tWp+cka9VNoBhsuD0rFmSuIzNDJ5lxw6ed2vyEnv3g50TiW3nBVEXz8u4v6gbjR23E0c9U1VEQ4jR+ScMbTy1YUpQ7rp1pNb6KQa/jWG5HU2livyvCVH4NY8BnZSV50At1WVEs5fGXHrlnQ/JI3ssBdkELCSI/IK9YNX6zWPAoC+Kkrx3EHS7hum3Es9e+6ZWzuHAAP4bUot0Zt4X6DTCN43SGamKefq21Pjos9AvVJVjnhJ3u1AjRXFliJ7YsvlaiCMERIL4Sh/R2mJ+7SLEArc724KESHwtBT+pEOFw7ILBMMVXcW7PQHoB4OSVlku5uleJeWbUlImHgCGxvWe5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjbsQ4asgv+IMl6PxX93eHGUlwPMYUuJDrZoMz7WDes=;
 b=t9d/n+cCCld7SLY+smrJEf6UAz+dOVKrFcl2MBgzMw/IxeL7z1zAsPpNLppdd/mO0oOaa6hmZIkRElWTOf4ymYOweLzhkOersOorfIP5E2LPaXt0XyJTNDhLTN6PFjTFKxjZxjrszTxGz1XDtlamj7gRso8D41ACt9zV/9VDHZsojQN0uOvSeqoPug1VtETHo2c7lZiWv0kyyCO1l8tBpQi5t4FsJ3tTJQmpivcfpThFY0NZZMXJKifBAr5Bc9ubjE0a1cT2x/YT1rldU1PTqbC+HEQCY2yLgMALReFpHqUKjSy2pz4fOjQ+qcikE8glHHRM4FKJ9gl5QX2ZX7iN2g==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DS0PR02MB8927.namprd02.prod.outlook.com (2603:10b6:8:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 10:03:23 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 10:03:22 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 3/5] vfio-user: refactor out header handling
Date: Wed,  3 Dec 2025 15:33:13 +0530
Message-ID: <20251203100316.3604456-4-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251203100316.3604456-1-john.levon@nutanix.com>
References: <20251203100316.3604456-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0456.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::11) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DS0PR02MB8927:EE_
X-MS-Office365-Filtering-Correlation-Id: 370749dc-e836-4206-150a-08de32533189
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J442QE6MUAYzPoAp08YDpr+RT37P0e8MYB39zFILgDGLQGIGTMfeuAYBVe46?=
 =?us-ascii?Q?pQwYt5B5hZyI0eU31zQuj1Adh2HLMF8wn58XMwU5+eH6D+KmCzikXm7zXhdM?=
 =?us-ascii?Q?9NajoQMJyrVyLyLLShbYUyNe8h/0iA0BSRKMWx6jPoYdRq2UaISJ0tVWo3uF?=
 =?us-ascii?Q?7RwVX+5IknP9CKdHrP5ZAToCeap5akkYZ1fvQaTihdWgICSp2+WZmEGQJGqQ?=
 =?us-ascii?Q?lBa/Z7+tbbVTLwpmZ6doFaOC2yGssS00ow6vDFH2yf2/vBHJMVMNQ/M4oXrH?=
 =?us-ascii?Q?gwEWEljQPXVxZfVGxcqE6T9pBmRQ+P9SmqsR7BfnRyZ9VW/ieSYXZHIMavcX?=
 =?us-ascii?Q?WyxwsMmf1125tEAelSZkgs2o6UcU3YRwIaL94rGWWtxez8pkpLbZWEyujTL1?=
 =?us-ascii?Q?k3g8r9uul3r/Z38EC9kIIaL7VrvqaXrcv49uHFNejsgeLo3kdjoPCJPoDW7q?=
 =?us-ascii?Q?YXIIOJBchxxkvgUHSPR2BPho7H2U8aDtcQzdZrYpjb1qQcG+xwPtmVNyvQ8n?=
 =?us-ascii?Q?3el3Z7gExacjWsr3wb76WlTBv8QwgI2udAfF0tb4vjYLqfjpwzeZtaeXMh56?=
 =?us-ascii?Q?aPWy+5ZFhEXJtqOPB2RuYqztrXgJZhEGUvuP80NICwCTiRWlgZsNtxzshtCr?=
 =?us-ascii?Q?eIdnMbhoA9m14utPHk2e+L9egBpMZOzSObv5AdIm8LfVk4eG1jPs3zirbJCu?=
 =?us-ascii?Q?l2wvoq53Uv30+AXtqJ9Ix3g07g16NcGYwjBA4Tc8RUKUKaehBS4IEPHE57GU?=
 =?us-ascii?Q?z1IP0WSV7kS+AS9lMg2JhU/fkU4extXpYEf1w8INtOCfiZa0qiMPKIoMkwhZ?=
 =?us-ascii?Q?N604MjQ1KO7kSMsFoUQfgqYJSt4C8cRNQZTs5vM+IDtrMbMhE2JryKhqHlux?=
 =?us-ascii?Q?o1lqXQgK8En1WUd+jlw4hD3/nWbHXXA2hMXVwG4ytg5xNJ47HpExh7xwZd/e?=
 =?us-ascii?Q?hYxlmopmLX+0uXIKpMZ5VpGCoLbidBJ+v0Njdyfr9WcW0NxtVuQFh9gmbyGf?=
 =?us-ascii?Q?FzKs86PMc1VOiuw2IOEGcvuqZRwiZR8YiJRFV8gk0ZiToO3asj0XB/vm2pfp?=
 =?us-ascii?Q?5eC/eJw5YEujrrBWdsmdpbKbaohtFoGEZ1NDEkziMtUewwekmwOx+oy1fSl0?=
 =?us-ascii?Q?4vOYg5FncImJ9Q87C5gnqi3zpqsJ2GaWc4e3cas/LjoXECzgDLy3TGvMzQar?=
 =?us-ascii?Q?1P/oOg3Jkld5boeYtGW1TaTBSG8q+l5QyGhb04kmaBR3rk0upH2GEeYHu6sY?=
 =?us-ascii?Q?2sMY8XdOxSUBOe/lmzGonkeKo0/VIBRXN5PPgRzJf/0SKTkhg1Qf5X0Mhl+y?=
 =?us-ascii?Q?lWzNQR/BnYR3X3vN/dgNqYDx+MIeh2S7lcvNwwjMh9AzfMkmFv4/KA+efNR+?=
 =?us-ascii?Q?gK1ntrN4C23Tm1bEmvUiJ54dpqpmwit4UAolmoXeS3+caPDu9fg5nFWlhpKQ?=
 =?us-ascii?Q?pmfsz7WW4o4/wolqS4xZ6HrOBwjS5IWh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LC6Y3NNrXZQsRMLWkET1IktruTg8hUoKqDJ0yGPvcXox5QqPq9sDXaCmSFmu?=
 =?us-ascii?Q?Quo63ObKSlf/KvwAhwT5vi7W5AEv2bwIjrfTy9BgmvVxodoI/WKmKOK1XHQr?=
 =?us-ascii?Q?YJWHXebCGCRfk2kLTctLtlzQCiAH3vXCD9vYoCj/XL1Rmu6ZyRfMWZ+t3MOw?=
 =?us-ascii?Q?J0sze4Hz97IymxRhuSD/PsnNXq9cgiyJXoDy9dAHywv1+yvf0s1k0MpTzwjE?=
 =?us-ascii?Q?6VhB6qAN7p+crh1P8SJQt64m/kovKh4OGfZHar5i0KnvaUtu/2nkIjme2V8y?=
 =?us-ascii?Q?68QubB4/yNjEQCZ4Wlx6UUQql3MJFl6yLytYrzUV1dIII4IzUeHEEq8VA5nk?=
 =?us-ascii?Q?Yb+1S5kG6Ax5ST9vp5ORJbzuVAabnt5vzZGUpf1LRa7Zxx6GN+OJ00RVvX7D?=
 =?us-ascii?Q?1vHxZissndaInVU7KjXAdZfYnaqhyCQhRYjMcYjW1BbuHX7MJwutbKz+dluE?=
 =?us-ascii?Q?q4nENJ0poAJ2y381CsabraMMRGR0Pj9WBTFlkQdjxcZkcqSDx+WEJwqofi6D?=
 =?us-ascii?Q?dbGPxx4chVK/fF9v85NaB5yp+TdeTpesepYPJdZ4cdV5YE37Cpr/auzP/18w?=
 =?us-ascii?Q?mH53E32mtfwvtnUGh8ybweBsxXb1YRI8C4vq4Hvsf3O+g5T66NhxdbVyiIcm?=
 =?us-ascii?Q?Q6iYDkAQ63zxC+NiC8Yxy61si4P/CMCG0C/YVGQAnAlLn5wVPP9Q//rbvnX6?=
 =?us-ascii?Q?27vA8cMIwC4f/glG/L1mdUpTz/sfYtrm5m6yRQ7vUf5kF3YB+ZA+ZITt709k?=
 =?us-ascii?Q?SP0QyyYZHZQjRSIY6Ktkp7VZDdiwIqV9FWv221VNszH97S72Fw5PXW7uKduI?=
 =?us-ascii?Q?8UTqMz7F5SY8+LNIKiAFdkH3g9OXEQZNHCgzf8ujrbTIIPKhcwMkAc4O6q8w?=
 =?us-ascii?Q?DTXV1WJlF/xbRUNesd0G5n1C2bkTdeoRTD/e9DSvh3QyhW9nrMS+IbwLt+3S?=
 =?us-ascii?Q?cmFV7TRMocMF99sEtn0s9+8cB6EbboofNQ1pkmC2NdTbElwQa5Pmo1VpEMtl?=
 =?us-ascii?Q?gmrSlAhFlsFJSnEcufsTpjUwYqp2AJvU/EDPjT9Q1QaMvVfjCjCcoxaVyXeH?=
 =?us-ascii?Q?tQWr2cYHyO6LDr3YOJo5R3m+uJ/bc6NA1uWMKD88PqXN+Ejoo/3wTI4avOCW?=
 =?us-ascii?Q?wgLqcjN0iVF9O6ltRiwkjZZCy5hI8B+4CsbaAVVCnHpFklfhlGy9opMv+2Sr?=
 =?us-ascii?Q?j2QXDYGcwFWSct0qX/gsFAIkPN6lpPP/J0rhX2jJgsbu5SM/MZBdlpBN1iMM?=
 =?us-ascii?Q?a6UdU2Uu2a7fugyo64dzx2Om+q9teg47h+yp1qkNpeTpALlPwyZuw38KNlwo?=
 =?us-ascii?Q?k0iHOzIGU3AJaN49orPZXlKvQgy0ejsS99CrnJkbVAITxsWL5pc23GO1wVt6?=
 =?us-ascii?Q?0ze0eC4b+LRsKFeQ9fggKZV2b5826w0XQscNv4rRWCbKGjGdeSW2Pn5koq8Q?=
 =?us-ascii?Q?Q9yUiTqDzBAb1xrq6ud17atVoppb/xpW/Fi2qlvzHwLRSegHuh54pWRMcvsl?=
 =?us-ascii?Q?Uzrr8vAkNmrFEV+A5UELO+rz839RoyLUy2TdqKq79kLffG+Es1JSdEQSTRxJ?=
 =?us-ascii?Q?PdrvYKfA0Zp03aVgwvSRUrWj+vFUgJtWFYBLt1Yx?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 370749dc-e836-4206-150a-08de32533189
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 10:03:22.9110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +N5QsH776oz8DXPivCYhhsF/QOq0QYWSl+SeKY6f6SDzN/e1zH/RhNZ+LZhTKW2WAEn70aJkOWFwdq/Dr8fOgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB8927
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDA3OSBTYWx0ZWRfX/hVs8L6esEuD
 xKaUuBXARW/CTvKh8eKV1e2uem01xXn+pIWOq5+7RnHdzWevT9sNShbxF/6f+SJHj5/yFDdAoMK
 szclDl5VprdDV41K3Q9vrOofAblayQGuyBHDbG90cT9Sl/mmMjD09zL9i36CwXTMjEZNU/HdA1I
 XZKjqCB6/LqKXJMx3c6ZnhqSO1qx02crHsYh0xgjl+FFPyy2SkYT12fYP+aCOGoPGnEbohbHFKU
 Ca75MFvbxmMts2NV1ZLFSqLA98jzbWRsPrq5/BslGFP2WlfqmwqOP8cO39K4+LQxf2CKYlTgEse
 effbIfhqkfARvQCgko4gbg6+Sd3ZYfuEySJHuveULmCOYaRYwSQtJ6gO4D1k+3j5RmoyCdsZnwe
 muMZOCnIN5YMMw0daBEMBYfukiDJsQ==
X-Proofpoint-GUID: LONg9IE-P0F2iY_9pxbNrD4wMSkMhSvx
X-Authority-Analysis: v=2.4 cv=Gu1PO01C c=1 sm=1 tr=0 ts=69300aec cx=c_pps
 a=1sVWB/l5Kn3omZIicXSEwA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=YItANLEf2SIYaAbUJgsA:9
X-Proofpoint-ORIG-GUID: LONg9IE-P0F2iY_9pxbNrD4wMSkMhSvx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-02_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Simplify vfio_user_recv_one() by moving the header handling out to a
helper function.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/proxy.c | 101 +++++++++++++++++++++++++------------------
 1 file changed, 60 insertions(+), 41 deletions(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 82c76c6665..e0f9202535 100644
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
+    if (ret < 0) {
+        error_setg_errno(errp, errno, "failed to read header");
+        return -1;
+    } else if (ret == 0) {
+        error_setg(errp, "failed to read header: EOF");
+        return -1;
+    } else if (ret < sizeof(*hdr)) {
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


