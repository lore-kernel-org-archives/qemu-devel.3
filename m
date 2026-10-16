Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAA6CCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHioH-00021H-I2; Fri, 16 Oct 2026 10:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHio5-000204-Dj
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:21:14 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHio3-0006d8-0Y
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:21:12 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5Trn3245884; Fri, 16 Oct 2026 07:21:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=VvBsGWO4glzVmPvokyxe2Nx7Um1RGGQAso/hL5pwN
 eA=; b=FFg5CeVG+OKgNRMkGA8NQ4mFm0qcmaCJ4HnGoRwj5eEZde7P7+G20fEyU
 /mWhgUg7gEXT3SLg68G1pFb65F09eCOwr6Qfsz0hHYrw4aFFXsWttGwVoYXrVoBj
 1GKkcHS7t169KEm/U+HikJ+lJuR1nLGsStPYN186Ddst8E2jVSLUFR1E1RtzxpPs
 I6OD5XGmiPWcKxOrgNmVb7nmI1cRqYuj3on9CY7Fdh2WaZ5oNAySsj4Gm00wco/p
 rrEfVOYfFTRGxSmCsGhoa9hjPv71FJ0R4RlIOTA8SD06WqatifltlR+yq+aSpdZc
 Jd+zMReC777biFzn1wEUBh8ggC85w==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022077.outbound.protection.outlook.com [52.101.48.77])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4haxj93890-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 07:21:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKCNWUkoAoZiZKq+siglnFjaXfbpqRYExET0dYXpe9AfAcV1n4N8su4hjs5Amu41KIRR0HxkVfx6cPaOIEnbtsPvZgeIZfnnCSk7LEgbPVywzqOpYdl+ayT3m2zOCDDCxaEcIeKZP1gCMIZ2I+Z+2wBeGt8o3/UAodAXcMqvtGeEbIBDfbR2xOVsFjXKtY2/FtYTDKiwGGMCd+Ml5Po/JOrzJS6DWT/Np16mqL2AoKIgQMQ9becGT+gGphnUg+oLxZQp4QY6+fLO1nm8J0N9IGEzNtkKOQps/iI+BZXUons/iT0h/zArRUtOMpztAjhB0ZcVNbKmyQXTWRBtZCTxPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvBsGWO4glzVmPvokyxe2Nx7Um1RGGQAso/hL5pwNeA=;
 b=ZDfzwFPi3CIbDYj7rdZsOBle17mtKbunRbHjtYMCRCJK9+Hw/zhlVior/4dzj/b+6IWGnij4N9ZVZfMm+GKGEhaojxajp9LlQvCGJj82knOTks2ur7iNsWQKDfqxLLBwyk+3h7JYamG79yZR1enWhqKA8rAllLYK5Gftf7BSiIicfdAAERRPGdayM7Ly866fCgOI4b4z+lTmOpPD3YS5FsgrJHOMVv0W2aciw7QXt2GM6oSD9J25XVRYEA/C4TxTaWFg69WQanlkRT13LOamUEdh5htmAezEMf26huYCt3TJUey2U6UL4buqaXWWg3x8l4dNMTp5TT7vndRcZrM47A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvBsGWO4glzVmPvokyxe2Nx7Um1RGGQAso/hL5pwNeA=;
 b=qhIsngsoencFWzN7xc9csW9t8OYrNZNe0pW9HBQQYN+1/+j9aNk3lJauF3lEEvF6TUI9dfEp3WT1E20N9KYzsWqDxXnEbu1/Jbt/WqWSnfXY21D6MqqEXS4JU4HgNXPeHLfXe/RXXMqimLUsZNKpubScBg6/0FeVqSBmIiF0NawBxGIvp7qyaOksdsV1h3nIBjbDf6JerFDCFnrl6PhcnBEP+TqnoJunzg+afC0C4bRPS1Wpx9EgyiIfZRh1nhbI5AMK/Lelkb7lNjezFNR9SzbEZYt0rQUbAw8cR5UKrtnbdWVTa0xxfMmJ+YvZU/bi6xvovEu3h9PD8p2DOL3YTQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL0PR02MB6547.namprd02.prod.outlook.com (2603:10b6:208:1c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 14:21:00 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 14:21:00 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 06/27] i8259.c: introduce TYPE_I8259 device
Date: Fri, 16 Oct 2026 15:19:12 +0100
Message-ID: <20261016142031.1204281-7-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0149.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::34) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL0PR02MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d1b002f-fe0e-45a3-9c86-08df2b90b3de
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|10067099003|3023799007|18002099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 3GkPqLbrJbMyvJCWksV3LqFG38XBys+LTPXEuPoe2KFgoh2BoOqokxN2pjfc32jGbxr1SHXpvTT93xOjIYDpy67p3fHlhUkwuKZ4DUuGHh0spl56hAsR/EfURNIeP12DXbTX6ueu7uHsQaU5iKSf74uzAHhU9ZCCbRbwMwUaKoefKSl1wPJ7PUPClaHrmfH+g4ZTCz01pGbpdkOHakaoyjB8bPah8AAFbveVw5yiHQ4EjWQbMj+L8mzyK66YGb/klntH7eDB+GC4Q3aWvu4CBwCplbUg6dEKiPS4M2oKk5xSr+09gljzCQSbFhZeJNvGPjH5iPe/3XLoS2qwphpLfOvBxCqDdNlbEkS+URLdAXWRRvgEaDLlyXgUj58caLNo+Dx975pEX9LJQAzVKXo/qg3KbJHkJxIcWC7kW2qHNdtmyJ1fZq5PIjGkMR8RTMUppBQcfB014qj00xBLM28UvyyoaMMgcQWyB8nx3aSiQpWtuY4JsVrDQsD+etXpj6BLfbLgBqJnDnfba0CgKwh5IYzzLCBYj0HlsahCI3c6Lgd1GvgPoWKxssNTQiPw+p2lDl0W7XGPbYSadqBtmSN1qvDcRFpi4+wR4kvVmJO3kQXe6rW5ykPglO3vdgZJcv6DhxeASB1ZvtgdUlLu4IG2Ssjrk8IPuEiq8r6KrmvJh60=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(10067099003)(3023799007)(18002099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QJ5F7sNAs3c5JqTMEVyFYm4LYEo/9iF8sWBPpKgb/xnKlcgaeewPCG4mL3U5?=
 =?us-ascii?Q?kodXdg0YHxfsPB+N2/RuHkWf8pqDCxwUFF5JMTiCSR0wU3kWX+Xw4sDlgFpN?=
 =?us-ascii?Q?CHi0PdvSxh4IA1YaqcdmRtDz83aYSI/5mCbiu1Q2Gne91zphqD2FPR0m0Mf9?=
 =?us-ascii?Q?0Ok0TIFJkR6T0gsMOiey7yzVYjb0L2jYlWkQHt4XfsJlRIn6Ou0QL2mlmKmh?=
 =?us-ascii?Q?sUlwCNM0DWFMweyvWQKZ08q7ZedL5n9Yc3Nq3u66xZS0+4emxVvsjaKpVfrC?=
 =?us-ascii?Q?0JiGVBNPp1Rrj4GVPG4ifuxxMZs07QrFdjEVt0m2l1UYnecgYiFjKssadrMs?=
 =?us-ascii?Q?AQ2xlPDY3BeC+gGhBAmxSR/48Ncq9itekO7mgTtElkoguk+XbnWp8VfGahXL?=
 =?us-ascii?Q?J75YsZqo2WlW1NmcNIcmAYE0a+s2g1MvaAp1pffej54Xgelc4vFU1CeUsJp5?=
 =?us-ascii?Q?Es+rURa2puuH7dW36nnj6fwsVfN6/hJ96Zp9pQwal99ZBnTTVsF2QHVhj+yo?=
 =?us-ascii?Q?f8iz6VUDYsGY+qFMxK6GNjYsb0Pp2SKdYlGQYiaWBYV0YyiIobVueg2uWbKw?=
 =?us-ascii?Q?1+qKx1mGYOHHSFXUAXveieh+PJOwCwAqGoYCOxPSvLQamRzbBkOSEwk76kRd?=
 =?us-ascii?Q?MPs7T+LJ3FbvomlTw+no9Ug6U9HZOVdMtwT7K3ohfvzKcZ3OdZrUz+R1YSE8?=
 =?us-ascii?Q?ZaNUjbwOe9krKnkOwvp33MlulxklPXeulpRzbD/KwawblSoXp7AQQe60aINW?=
 =?us-ascii?Q?Pne9QzGy96hmKwmUwvcV4jnhWj3NoM3BwR0aJrc5U65xPwOOvBF4d+jKmMuX?=
 =?us-ascii?Q?ezuxMAW8Uw8mbzy/CpmWoPJ3IaLKQZBOUmrNn4hUqwFA5LPtdHWemiMzMmDn?=
 =?us-ascii?Q?g8gfGya6PUbSkEO1QAMGYO4/fmF7pbJpEnPXaKcbbK9q/DhB7I/axZPbir8D?=
 =?us-ascii?Q?IX/lA6xt32/qqKiPjZ+AGd0OpuhAIiNP9f0n2XaePUHu8M6/3jgvUaawVQm+?=
 =?us-ascii?Q?xgt/G17c+4qRt/t582+bOFgQuQJN4cvyltSKDGldJ+1M7BvskEYOlWrjmbEL?=
 =?us-ascii?Q?HYueKl6nnbBJ+H4rMyAjsgPDfYh8fkaw+bd3ZSN4UKAMxVHXBTmVfMTs4Cz8?=
 =?us-ascii?Q?hsVOtSsz58tBr/dfOtgoKlCiqtqOrCfb6Wp/LKdZElVMMZXR8Q3LsKuZ+jtA?=
 =?us-ascii?Q?uw5bJZdV7zZXOgsHmFxVjZCFCUzB89kuu3lZIhlg0l7bL5xltwpU8uJdYoZG?=
 =?us-ascii?Q?5wXinSFfs/rD6qZzbmt410KB4XWEhq3D/tQk8o7bv8rHVCQFZjwSJqI/4lAq?=
 =?us-ascii?Q?piMquyBr7waT/4RFNJ0OwXTnVPTsulu4pSLN9ptppntBVrptF8agOjIcP3Mp?=
 =?us-ascii?Q?7iA+olLowLS5MJz82nTrlHDfmXOd56LMNS1jTO+Urvg62Km0VGWur4TinY3I?=
 =?us-ascii?Q?dSV/OzbJpXK9Gewnnn7I7EBokEdo4c2hZNcc6kqmg7lfqHy2EgwEf38ktozu?=
 =?us-ascii?Q?ZeI8l24zZn0tZZAJL9XfL/nfP3Gp8kbwW0gPOjPjnGKaBuJezL25/ipeY+M9?=
 =?us-ascii?Q?V0/zfMqVjbrEytfn2qLu5Y7St+Eh567jAjZurWOj9nMpLsFR6sMrhIKY1qc+?=
 =?us-ascii?Q?KTxXozB6xlduUx6jwzlaeaDY9m0xyBUVnSlfrg3oZ2EAUwuqov4aXCfJbu8g?=
 =?us-ascii?Q?miF0gBiLiU2DJfII5TVrIXyDH0zJ5fwoFIuff3hYl2lSqHyFoFSuw6ZmCMM8?=
 =?us-ascii?Q?IA0M7xylpcaGc1CiwTN3VlRMwnPrqoQ=3D?=
X-Exchange-RoutingPolicyChecked: qjLX3P5CXEXXlU8Uwz/57+EqPtY4KBL8E++oocg053R5pna1KMQXkeNbS7nolwodKTrbnpG1R3cchwbrh7JMpalJuO3grk6vKJEFjBgmnKciI3BnAiLPtUpS1igIjZ0/QKm8fsY6L1kFw0xjOlBYRkRkQhij6Sr9mB+x++GGoKkrj6PhketIodXDvxgF2wtlhrFJTHCoy3y5j92xtt4afkkC+Qjo4AVqYOytpoXe5Da1UC1x9rUIrDiL1kMm6r+MthSAIGoyvaza63rCCER6LVPDigOT1sER2tW72kwXQOlbnQm6RNYoQRfJtQhbRa5RxZg9GRozDOCrY+kZiv2iRA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1b002f-fe0e-45a3-9c86-08df2b90b3de
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:21:00.5139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yhqcFWdzDQb6aRlQ6kAFow20gkf/RPBHVZxncvFbwMVYou7vp9jYTR+gAWsxYWrVek0DUchQSHg6CvuBiMFeGswsKbyAmywxyJE/cm40Vgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6547
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX4qJbuS5FJYjO
 zSY/FoEPEhFpcV3ct1RRsIlH81IhU2N4tO0faRHZ75ld3ilq6Ma4nbhIuHCWdZDxk1D4TeyrtMt
 mnruAXTZ1ebQoskZo7ts3HrQaMUJRZo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfXymmzam89rSfM
 9dXYgeNB90LA1Akbc8W+1L0sJMagiEPn1kKKmHHzDs7ZyRi/RyAi7knPCwic4+5iScGE3KyLmBb
 nA65dHbYtutlpegcXw7f16c9Uthsp8v7eu/6ZRo1c+uLlud8ZXnYse1R6ksp7xHlRxvLGkG8ib5
 vfsaZb/N3JSrZgz/sxecpKCrP0AkdOjOumqYTQgs+hWJYKGa3IQyNztmOgnWann0627l12VvdKG
 6v0duc/LO9y1d4RUWk2I1c3fQzOxmWmvPQJk05k4WsZcHbj4dezqwDt8StrY/x82N7cH9aHkoOu
 N0YSL5VZLQowisa6OsdwVZRqgCEW0W/U2D/Vyi5jOS5EdRHdPYDekg4/0CZGgR9oPTrEB8VfuED
 7mY+5+3y6JW4UNDwsC7Jkxtcxor/3rVyW5etC9DOHez+wsVYTVesV2lyy7HaV2yKnztK6qZEle9
 xKCkdxSVDQm8LolOMQQ==
X-Proofpoint-ORIG-GUID: Mpch45Wwd0GRJIoTb_E0UajNookbBLbI
X-Authority-Analysis: v=2.4 cv=ItOL47/g c=1 sm=1 tr=0 ts=6ad232cf cx=c_pps
 a=PNgX5FSHJLFuI9i88Gvv6w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=RO_YwWr2CJXTu7lAkVcA:9
X-Proofpoint-GUID: Mpch45Wwd0GRJIoTb_E0UajNookbBLbI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

This device represents a single emulated 8259 PIC and its associated class and
ensures that we can safely embed the device within a container device.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/intc/i8259.h |  8 ++++----
 hw/intc/i8259.c         | 33 +++++++++++++++++++--------------
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/include/hw/intc/i8259.h b/include/hw/intc/i8259.h
index 1921a30371..87ccd55a4d 100644
--- a/include/hw/intc/i8259.h
+++ b/include/hw/intc/i8259.h
@@ -3,9 +3,9 @@
 
 /* i8259.c */
 
-typedef struct I8259CommonState I8259CommonState;
+typedef struct I8259State I8259State;
 
-extern I8259CommonState *isa_pic;
+extern I8259State *isa_pic;
 
 /*
  * i8259_init()
@@ -16,7 +16,7 @@ extern I8259CommonState *isa_pic;
  */
 qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in);
 qemu_irq *kvm_i8259_init(ISABus *bus);
-int pic_get_output(I8259CommonState *s);
-int pic_read_irq(I8259CommonState *s);
+int pic_get_output(I8259State *s);
+int pic_read_irq(I8259State *s);
 
 #endif
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 856075a754..81827f2734 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -35,9 +35,11 @@
 /*#define DEBUG_IRQ_LATENCY*/
 
 #define TYPE_I8259 "isa-i8259"
-typedef struct I8259Class I8259Class;
-DECLARE_CLASS_CHECKERS(I8259Class, I8259,
-                       TYPE_I8259)
+OBJECT_DECLARE_TYPE(I8259State, I8259Class, I8259)
+
+struct I8259State {
+    I8259CommonState parent_obj;
+};
 
 /**
  * I8259Class:
@@ -52,7 +54,7 @@ struct I8259Class {
 #ifdef DEBUG_IRQ_LATENCY
 static int64_t irq_time[16];
 #endif
-I8259CommonState *isa_pic;
+I8259State *isa_pic;
 static I8259CommonState *slave_pic;
 
 /* return the highest priority found in mask (highest = smallest
@@ -170,11 +172,12 @@ static void pic_intack(I8259CommonState *s, int irq)
     pic_update_irq(s);
 }
 
-int pic_read_irq(I8259CommonState *s)
+int pic_read_irq(I8259State *s)
 {
+    I8259CommonState *cs = I8259_COMMON(s);
     int irq, intno;
 
-    irq = pic_get_irq(s);
+    irq = pic_get_irq(cs);
     if (irq >= 0) {
         int irq2;
 
@@ -187,16 +190,16 @@ int pic_read_irq(I8259CommonState *s)
                 irq2 = 7;
             }
             intno = slave_pic->irq_base + irq2;
-            pic_intack(s, irq);
+            pic_intack(cs, irq);
             irq = irq2 + 8;
         } else {
-            intno = s->irq_base + irq;
-            pic_intack(s, irq);
+            intno = cs->irq_base + irq;
+            pic_intack(cs, irq);
         }
     } else {
         /* spurious IRQ on host controller */
         irq = 7;
-        intno = s->irq_base + irq;
+        intno = cs->irq_base + irq;
     }
 
 #ifdef DEBUG_IRQ_LATENCY
@@ -348,9 +351,11 @@ static uint64_t pic_ioport_read(void *opaque, hwaddr addr,
     return ret;
 }
 
-int pic_get_output(I8259CommonState *s)
+int pic_get_output(I8259State *s)
 {
-    return (pic_get_irq(s) >= 0);
+    I8259CommonState *cs = I8259_COMMON(s);
+
+    return (pic_get_irq(cs) >= 0);
 }
 
 static void elcr_ioport_write(void *opaque, hwaddr addr,
@@ -418,7 +423,7 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
         irq_set[i] = qdev_get_gpio_in(dev, i);
     }
 
-    isa_pic = I8259_COMMON(dev);
+    isa_pic = I8259(dev);
 
     isadev = i8259_init_chip(TYPE_I8259, bus, false);
     dev = DEVICE(isadev);
@@ -444,7 +449,7 @@ static void i8259_class_init(ObjectClass *klass, const void *data)
 
 static const TypeInfo i8259_info = {
     .name       = TYPE_I8259,
-    .instance_size = sizeof(I8259CommonState),
+    .instance_size = sizeof(I8259State),
     .parent     = TYPE_I8259_COMMON,
     .class_init = i8259_class_init,
     .class_size = sizeof(I8259Class),
-- 
2.43.0


