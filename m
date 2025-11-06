Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FACBCCFA1C
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 17:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH3QT-00033a-VD; Thu, 06 Nov 2025 12:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vH3QS-000310-8x
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 12:05:32 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vH3QP-0000tb-OM
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 12:05:31 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A6FiLHX1143749; Thu, 6 Nov 2025 09:05:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ZcYDgkkmQxB1s2eV3AjNuMvWkQNqfEg4pAycXfaRB
 Ps=; b=xesQY8/dUnykcsTFU2sF7MNnjcFZGvlFdZomJBK02icGrkcXbYpxo3o7V
 ZX/aH8pW6g6lc/eRyWoUAEDCcpRydbo1CFi6v/YFZJZ/9K8sshY38pJAw0umdDGx
 0kkGNs4i7+c/CFtKx68bkr+HeoE/uxwqlo9L2prS1PQQLyUQCg0RvOCbLp2dTHD+
 jw8krQu4TRmirqnYbXwPx+eu0HtWDAwW7WNnh/9rKqo+CV25bgZ7dmfgoFelXlIQ
 rdV0dyTeOMPLFvWlZ1/5/2XXa9pu1zLLn71PuUp9YeFcOsBWXBxLqgCZg9yPLPs9
 lrHSJYTJkHap/Jr/blbhSpZwZkoHA==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020091.outbound.protection.outlook.com [52.101.56.91])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4a8bch2y2s-3
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 06 Nov 2025 09:05:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMa2p9JIC/ImG4t0ashhMQt+RYVTlBXVfiMFu7gdjA/sc+cohb03N9nESG4ZaLMqSZS1vE2x8UgeXCb+YmXCmzOeMTZsnzLRE/135klN0//t+siyrPPfJTMshpugZ8OleqbxJND87jrX8FRo0q4sfWIDHSFngSwGUoOw/Hd7go7fdJcq6uGS2zLvtHbiPYKkpCPRQsOKPEPbwcFMThkY4V9IVGLwDKF6HzY2OZQQgAOoILiySIjpaontnbtSYSO5u6LJpX8EQXaF7DDX9ZPi9aitO0Y+3kfS0hyN3CNRcuI96nah5NJWhryKUmYHUpN6+3AYqca4/3kQX8nnjQSsZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcYDgkkmQxB1s2eV3AjNuMvWkQNqfEg4pAycXfaRBPs=;
 b=VcARSmOUGjqcYhaSKjXFXTl/U5a7GcuziUnhIFMfK7aI/JFRXIuPDeNkHUPZ/LPc77MR1P8n4UBRDu+/myGx0bPwk+6B0cwbcYm8EiF+YvI/+x41q0ZDZPyPAtc3t00SQ4lrE/HAv8dX/B1uIyqiZFYT1H535oDjHT5TgaKO28JSIn8dcn95Hb7yt9z+eaBSdx4nDRud/ZJ7h2FkUyhyAI/s7udWBRoHtjeeiYuVivLAPbJkGIC0Fab+11nZrwWtFWzgVvXhaurZpdUNKksCfcLN8fH1gbO5nNTOcgNfkMY5jbveFBKNKAvZq8g+aTfwACJz4/eiNp1UvkS9c6ZmRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcYDgkkmQxB1s2eV3AjNuMvWkQNqfEg4pAycXfaRBPs=;
 b=GSKxvr6cT4Ii0JPKYv1dm6XjXPKlmcVi80R2VgiSthafZ2nPxcEt9pU0ItOAMP56ATCj9OXUtgYISo3GhWqcJQ+Zjnr8/aASF6iMcgyynMGG3t+jYEZf7SFv1KLdaqqIrZ79c3dgKo2LPcsf+g4UZPhSUe18Ygm5t5NUSW905x2kGDnIgolKkSdxV4blZi8rEJj+JQUGYtaOzjml+ZC0w7bx+BsaRYUhSVtDC4XVVrB4dr6hE1adsRbfpvmiVRaFhNJgTCMCyy+5hZBChbgcowSZz6bD4SVEGz7jb3Arrb+5mmZAYrldq3HfA8q/N+YnVT5bRZxw2FDcqGxNXhC81g==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by BN0PR02MB8000.namprd02.prod.outlook.com
 (2603:10b6:408:16d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 17:05:25 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 17:05:25 +0000
From: Jon Kohler <jon@nutanix.com>
To: pbonzini@redhat.com, zhao1.liu@intel.com, qemu-devel@nongnu.org,
 pawan.kumar.gupta@linux.intel.com
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH 3/5] target/i386: introduce GraniteRapids-v4 to expose ITS_NO
Date: Thu,  6 Nov 2025 10:46:23 -0700
Message-ID: <20251106174626.49930-4-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106174626.49930-1-jon@nutanix.com>
References: <20251106174626.49930-1-jon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:510:174::9) To LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR02MB11133:EE_|BN0PR02MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: 325beaa6-20bd-42eb-7ef8-08de1d56add7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EZB/OUBShVsCrFtBA1cYGL7iEBd1ZxI78gbYdIOuVyDHPynZ0VyJQkfA3jTV?=
 =?us-ascii?Q?5hyrshCxY2P8FFsAyz6WoVbuy9LLrVeTnk7rEG8X2zEGTkWodc+TNyvE6Qlk?=
 =?us-ascii?Q?uymMaJqnSCuYm6zCN8Y/lc+i0yf9BpL1pqwr+e6BzmCSCSQTeePYKTJOm9OY?=
 =?us-ascii?Q?FLC0qKosoFFnUqp2jdeom+RH4RZkgcnRsB3HYWTYb90Qz1R4l/0xA7S5TJCj?=
 =?us-ascii?Q?h2tDBHzZzLR/KJTTY5sMYW1v1dBeta+pzi9WMywAui1942bWhnK1mFqvPOet?=
 =?us-ascii?Q?ZaXT6zju1bNku8Zg3PKpUJdx9gbbHpmdx6InZhKzwdiM184tXpKO4iurP862?=
 =?us-ascii?Q?ySL9d1R744NFbc7VGS1pwwV8QEiqyiTNAGbBt3t1cbeUfKKD88mqqq2HE0jy?=
 =?us-ascii?Q?C3NRdn7Ilosy4ov0eCKzCXwCkafLR6JiHAnde/Pd/mzUQLt3p4OE0yr4nYf3?=
 =?us-ascii?Q?eXTXUye4Ush4tiFIZTb9QUYfIDQ+XNaGZwxls76qbGoPspq/SJjABIomCWAZ?=
 =?us-ascii?Q?n80z5ksr1HPMRvXNBjm9c9kX86F1KPgcLbr2n3QRjt/fMWeQ1q5JAZnRoaKS?=
 =?us-ascii?Q?7QFS6vssLIjoxQ14mn/YpdbiyeyiltvU70wsGsGpMJ8wPnePs1xyL4CymwRX?=
 =?us-ascii?Q?11U2YKXrYlOIRYGh+TpdGwldP29lKmEFh1MQn7BQvw2KNyBgxmppI3BN3OG6?=
 =?us-ascii?Q?VSduJ+ZiHS7xcP4P1ya2t2MfEePC/EFHJPVowMskp7hRWg47Lh+qY2RDY6rm?=
 =?us-ascii?Q?9zxcbs399sYR9Z8RzaItbQmdpyYyoN4tBEtTuRt9lFZY6Eyh3B5Ey04RNdDu?=
 =?us-ascii?Q?Xsz3zBv+lREi8nsJZqWcrSUP/VI1jnl3wyltyFuu7gzX2B8AP9S4fzBr2zwL?=
 =?us-ascii?Q?FQrAHnXA+iYS5TsShCvd59nb1roYq4KsPQ7O/pwVBO+6fNE5/xmPYtQfoyuV?=
 =?us-ascii?Q?Var36Y3cVItz6wystTjoheqta6IvHfqwLBraeKKkZ5u9XDFTgHsebSnzmGnq?=
 =?us-ascii?Q?H4hoxYfBHHpRzoMgVgt0kd+vxOchy+Tq7Xkp54wJV1b1FZ68ezD6zQDhI5RB?=
 =?us-ascii?Q?vvU+yxqtjTQ1IEWmZ2RWnrvos4by/TVrA2fZEN3VbYmH3Zztsmr1km8D4Jy5?=
 =?us-ascii?Q?95JwPpJ279YFcuYESdRK2L+lB18TFHMdAJRRDfam2vOHfc+BzsVrvgphM816?=
 =?us-ascii?Q?QOBskyI7/5Y8WwKvYNFFKPJvFkQOOCprmrYXYN804Yzx9qNQt92VVlfd2PIZ?=
 =?us-ascii?Q?NOFkV1eLFXVp+gmWFdYD5IlZvmPmQOI5yd5MEFtIkBSekhZrPv1hOw3xbHBh?=
 =?us-ascii?Q?vWMlqw85gCj5mxlsKdk5lXHtUgtZ7AMmaE626AjRGy0GBXQkOw9NpMYoKyTq?=
 =?us-ascii?Q?+GoKFRCQWMJaMp9mFWoOQ356edPYUY7Bc0P0VuFiVKRVx7SWUO6QLwZaeu/1?=
 =?us-ascii?Q?glxv7ksBSWqALQ77g05oE3nNwSh2efObZnnm5/mCqtvStIveFOUFeYySWhIj?=
 =?us-ascii?Q?mkaWAqpKtLWoRkRYYLu0p81QxvqPeBQfjFQ0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV0PR02MB11133.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f2iso/UiwVA5mdAPErZomjfKhiADXcjhs5t6On1Psdu9VxZ9eyjAZ/mG3P3g?=
 =?us-ascii?Q?LijMHzJCtoYeKnLb7+VseodVKb/LIkAhrEMV0YWXIE2RZPVR0YaW0Xzvyt5z?=
 =?us-ascii?Q?7Jfgm3/ism86oG7sAcCz6G2vpERiJZl9N7XNe9n9ZMsLVnnjQA6qRlvg5047?=
 =?us-ascii?Q?bMsZTrb5a9eKun3IebLXcJ5VwzwwKHH8CZFZQgNdNEVDaZ5Pm+sWVy11VoGR?=
 =?us-ascii?Q?xxTs+KjWihf9WgqBJoX90VpYjVwh3/4YTV+lURbCPcY7Glnyt+XalRUEZ1tc?=
 =?us-ascii?Q?Ls+N3cPNyZCKFavGyzvYkqvfHRXkqjP3w3Lv+hpz8RG90MXjtME6JQG3JKkK?=
 =?us-ascii?Q?hJUp1R+9O3vDSMerlhm1kKZq50GwGxtETznvkMtqFYGRH/VVDqLIonWcB+XF?=
 =?us-ascii?Q?p9bUh+9QjZdJdq1TaV0ozGQPiT/bXtu5tDtZ6OpYQHEFrfzbTAJSb0ZYRd6l?=
 =?us-ascii?Q?etFM0mdGR1YTSXqCUir8UQq8iTJkvG/Ak+9lTwbF2Lx219YaLXm4ixONGNeP?=
 =?us-ascii?Q?CtFU0h7lJuSxb8kOBjB+fvMX4hk0InAUuoPMO7ZccH9C/jXREeGQfx4h79F1?=
 =?us-ascii?Q?Y98+Hh4Cj/sqqTP5vrSwuZ6IhHG1knsw149IZwF6HUjhz2t/ECti4+XVcNW4?=
 =?us-ascii?Q?S7ZPHas5zHisMfHW8XPSq86RZQG5wYLIFh/dKEA0uGu4eSexlEJZefUvdLHS?=
 =?us-ascii?Q?UNLh7cLOyXUhElxwi+RFCtjHJ3nT+NR3de/t4Ru3gXs2CXTKeoSKspFteit7?=
 =?us-ascii?Q?HcG4SEhZn08xqfbwjHtCUw1veYTQ+I4PCyAW2NDAf6a04QsCvvcxjF3wM5pS?=
 =?us-ascii?Q?2J+seMIgJKxnB24INpFLcUHjbtkQ9260rkfGj8PWlS9l2Au6ZOncq+oAN+mG?=
 =?us-ascii?Q?x6HjgWK69FsFBrQoMsZGSK9bntUPvZvW8USvNn9+ZlEHNmanyVestT9qWBck?=
 =?us-ascii?Q?JgB2UXdgPZfi07iilPgUnR2FcjuZtqpFf5hV19ang9xy3ulyu+7PoEvIFPlV?=
 =?us-ascii?Q?45O593vKX/VRgh/L7BeaOc3sO/j+ZI1eHWfB7TYIOE2BjpCoQR/0s7qO93nH?=
 =?us-ascii?Q?Y5tqKj29oh67/FX3a2APeTim42MHiGpFwDvc1w89I5BglW47YQuZP/7kTtl9?=
 =?us-ascii?Q?lbKYZJKJIj9x491HuQ+t4lLppgU2xb3iVUwy/9nCSD5TtuglRRXOF9AyZhJe?=
 =?us-ascii?Q?vYLSoLKIKCt379tqOMGHvNwh/m8a+HV8LS6zBs9n/AfPxitc1VrZ5WbhiPSO?=
 =?us-ascii?Q?Y6hiAWD6w3DWkuhUQzr9MyilJahKgSyx8NuGUIteWmx0aUBsE+esT7d6n06d?=
 =?us-ascii?Q?7ELzbS+1DTWmQgf3GK3xJwRs2CIR5hi6a1+0JbHXmUEooL8H74likXRB1F3a?=
 =?us-ascii?Q?vt8Wav+iXBLAlmvM1FMjEFCORxM5YgZNSryANQRrgHg03amFkChB4CClf+us?=
 =?us-ascii?Q?3DBWj3oeYpdBzqXbWSJc9PGSxtnqMgjaExnEdQr6oYoaTb3bLWGyy4k+tYGZ?=
 =?us-ascii?Q?MPKmbQEP2FzG0hSGp/10Sr5W0/jvGjjL6Ik0CJHvwenLqqSTAYwfw3XYAQD9?=
 =?us-ascii?Q?QQEBkkwvl+vohwOr5HvoqlmQtPbczDQijtIvKTPL/YETcYVgRusfbJmf/p/z?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 325beaa6-20bd-42eb-7ef8-08de1d56add7
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 17:05:25.5571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3ZxAQpB5pCkEPl55OZ0dxhTCsEiCdycjEzo/j3rqzsIg/5Z/c2dSY2qBKEx0U+E8alMpVlI04ZpWztojC+T0jp6jnnBxiuGpCjc9h85GFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8000
X-Authority-Analysis: v=2.4 cv=OvVCCi/t c=1 sm=1 tr=0 ts=690cd557 cx=c_pps
 a=DCeSEX+nBJmE/I7rcEuDsA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=64Cc0HZtAAAA:8
 a=J7X7g0SFKKtu9_AsvGIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEzNiBTYWx0ZWRfX7Kz3NocSvTyM
 VC6o9HO5ymHSabO1X1s+FS6dO9CNISe8tWVjf3xv5auBuwzzThyqu110AFoN6tkXG3T187GbLrj
 w1bQbBDw87AhT16Fem3NfLk1AuSGevs8Z1vA47e4GCqdKi8QxBZMmwHB0xdYrmwfhG5S4+EAAvm
 aJ8K2eybvfFrRtp4JlcoQHCRqkJgtB6n6Q415Zk0hKt83UyNkhwslAn1zMg6ODBzn8RpwD7GzYr
 1MB027WqcSBIG0K9xUDLKwgZEugYIj3dmFPUoA854hz6bi1TBp1RkERUeKEzL7Lqj4Z3EiF/LM2
 EIl8DUa2q0yndBLaYPVr0OnUCfJsT0OuvhfsoOHiQqFlfeyRwgRi84Vqm5FMe20qU8z4AqCzTXQ
 bW4t4rSLAM2KUCVnFPCmENvM7bF07w==
X-Proofpoint-GUID: EtKvC1r4LB1sDf5Ms_06GoNKtRIaFyk9
X-Proofpoint-ORIG-GUID: EtKvC1r4LB1sDf5Ms_06GoNKtRIaFyk9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=jon@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Expose ITS_NO by default, as users using Granite Rapids and higher
CPU models would not be able to live migrate to lower CPU hosts due to
missing features. In that case, they would not be vulnerable to ITS.

its-no was originally added on [1], but needs to be exposed on the
individual CPU models for the guests to see by default.

[1] 74978391b2da ("target/i386: Make ITS_NO available to guests")

Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 target/i386/cpu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e579b790e0..afbfe11733 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5282,6 +5282,15 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ },
                 }
             },
+            {
+                .version = 4,
+                .note = "with ITS_NO",
+                .cache_info = &xeon_gnr_cache_info,
+                .props = (PropValue[]) {
+                    { "its-no", "on" },
+                    { /* end of list */ },
+                }
+            },
             { /* end of list */ },
         },
     },
-- 
2.43.0


