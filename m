Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3B0CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 19:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urLVh-0000Qu-ST; Wed, 27 Aug 2025 15:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1urLVf-0000QG-BN; Wed, 27 Aug 2025 15:08:39 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1urLVV-0004Qz-UI; Wed, 27 Aug 2025 15:08:38 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57RGl8Yg2966708; Wed, 27 Aug 2025 12:08:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=p04WiRrRLHnXA
 8K8qn213Sf4gZekVem1M6IL9aVA6zw=; b=DsFhvHoDeDG3dr3/vi0I6KnCx+22L
 BoBUYHfbWAIK3sTzOs40UsJTE3AXR5ReMjG8EqDzmhcZ6Zx+sUB5AgF+zdITRKjW
 DXXAZJdn84n1Ik206MIUFkfSVsQoeZcK9NswPugP23L3Snw/BPeJOAleCU+Faq+g
 7n7iPcTiXKRzmG+1s6xNOll6K+3+c0ubiGfJriUx8zHimOlg5IaDFoKL7/sP2ze2
 djdC5tpBHZq8iIl8e/e5X3PaWySE1d7JA+Lyc5Ywy1zUFTopwIyYhgk14HpLJFQ7
 zHnxTZHI3Br6aRfd9az/VETtF/hg5Tx02HP7EkE/Y7F82AbBZocTBKoLQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023106.outbound.protection.outlook.com
 [40.93.201.106])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48s9prv9v4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 27 Aug 2025 12:08:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whqJm4ET3BVlu2YWAL5HUeHuokoUhkBY+ia4eEWRyR59aKgiir5zFuuvFaGe058qdBp58Vh9xoJvNtXS65ql1gWqNc9td8Hk4ysOoroAY36DwP5wfDmZ0xO72c6D/at4sex5Jda8iVnb2vYtZfhf/w8bMRBC2umWWxnOwZ7tflzWWf7yt5TFrtN4wWH4wJjR/x5Vf7Y2/jCqgsGTdDbZpRER7KUeBrpgheA7PSDD15K8HfcI6gEDd/BuLTVivzwRUkUIb9IjersVWIXAsl1vsIbJ2Sxuuwn0JBfPNztBzqppmMBZzRwJLmNmJx5aGONtwn29pMFasUBzbcc3bPe9ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p04WiRrRLHnXA8K8qn213Sf4gZekVem1M6IL9aVA6zw=;
 b=Nyxi9ivEuxlMWb9KnR/pISqZaMnZYrMdQnXH1oFwoCjGwa4VNBOxJsEcJWaIX+jpNFjen/1Nc21iKfUZoqxf//o8uhuTiyM57KDGreQPGh9iNwXqPHThZ++5N22RSvYbTnubbejNKnKbHa2Rx1HkZHKAAm+qZbpOQNYQ76AYxBL1jUIRI/r5zF8uCjY61V+94eqKt/ttm9mxeLg1gAYwz+fKubc5VgmHGgHz3/dvENhLZBLkOgzSKtBCNvGh90Qg48y6UJRGXXWM6HkJ+kxOM47UPP6hblwsmxxuGtr6x0bmc0423LP3lxbYbmNK7pKb1dSA6ihBPBiY0j1YIBVYrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p04WiRrRLHnXA8K8qn213Sf4gZekVem1M6IL9aVA6zw=;
 b=ngeNKBf7j1gFFjw5gJ4MWkalkjvJeryioYckvwjxYIOhxuvUidE2TWNg/edrm9d3R7quHMFefDwwM6ikF3TZr6+bxTa4NTCvVJswla6btVHLS9jWgI5v1t1xpTrxzdnIydBI2YtKhr+C2xqMGxXp9IPhSYLMsEX9CkZClipybCmMjqNWuXm66gDUpgiOSjbVqLjb3npFBE0ohEgbkivgDXXQDyoi5iDZFrgpIYy52QKeVgxUfcf4dq9LyTgOSYmVQOHYVHlHqJQRbI19eigGiLwEIMolMUBt5PRzUAw0qVmfF5mdKMu1dm9ygGan9G9p8ekWRohr64AAwsy/GuD3eg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH4PR02MB10659.namprd02.prod.outlook.com (2603:10b6:610:247::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 19:08:15 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9052.021; Wed, 27 Aug 2025
 19:08:15 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>, qemu-stable@nongnu.org,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: [PATCH] hw/vfio-user: add x-pci-class-code
Date: Wed, 27 Aug 2025 20:08:10 +0100
Message-ID: <20250827190810.1645340-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0108.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::25) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH4PR02MB10659:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bcde58a-1776-4569-9e2e-08dde59d12ea
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y6lZIzfJOo61ZJorufOdLYRI9B1nQqaCjEzSvtttD1zYzWm/7+mIRMO4bQIt?=
 =?us-ascii?Q?vnyU4qKnJ0g50T313HgHgL04r9NvvLiVnV3wTqpsoW4GmmnOHjuhMWkV3jB7?=
 =?us-ascii?Q?IOQzXyj8gkZ4rCG/p0UgpNuZ8lCgJgS+0nG8XztqITUioWwtuk7Z+gVOd9c6?=
 =?us-ascii?Q?YBuNv42hkPj8clALDPdS7IugujEI2Ine1FQVFusDOk2dvlWoH75wB6klFMkX?=
 =?us-ascii?Q?5u+QavAeGApsQ90jK74FbQqzkgJVEJvTZP3Cvf9BJEJ35cSJKKTKqvQnTEa5?=
 =?us-ascii?Q?WpMEX6vaP9cFA8Xpdj8Wz5fap2pTEvDUvrgoyPnPfGnCipM0bFkTI3WTg+ax?=
 =?us-ascii?Q?BVpS0kxxiFz+XB+YPo1an+j5wONmGch8R4NABwhyS9tiFKSUqPPYJpgIuhHx?=
 =?us-ascii?Q?iMmtPB1fq//4TKVBPzO+FRDKTSfP/fKpf7n7ohNJvENSiwkwrbmtuNLzYPy6?=
 =?us-ascii?Q?IpgffEMeQEerzknzgfhWVxQEnR/CnVNlM5KtDrFTDQKXjpbxGqXL4KqrGkzm?=
 =?us-ascii?Q?6o5+eiXsHSjBk74XErgQNlfQwOZEFry1BHoZaKkWhNkJi1IE+wU34EiBrQnv?=
 =?us-ascii?Q?YmHw7N5EQZQKk3wUDq5n4/7GGkPGfMpoWjSYdxmp13kfk+fM7UbEZno9RDav?=
 =?us-ascii?Q?nMphj6vu0a2VFjD5WpbtS0ffDxKvDugO7lnUYsX4/cMtTAeNlrRB+BhZ2stq?=
 =?us-ascii?Q?LnwezdT/4AiRccu+hwcpn7NZhhDxFUNdPV4puTZ7WVQDR1B+uzsFLkDUSvDl?=
 =?us-ascii?Q?r6q8uttC4KBgcRLLIuiX8JdPg9absiUtwLN6KsBKNeGaR3FuF/Au+dVQ0+f+?=
 =?us-ascii?Q?x3RO6QCf96F0Ecwuc0fCk8tfRJJn0aq6mLZLEmvFFX0C3h+HsJVuzR3awR8D?=
 =?us-ascii?Q?pGLPbnSsCX3izqAb81WHmdQXmIW/Kc7M1llpvMm7B8rNTdA4TlfcjaMV9v7G?=
 =?us-ascii?Q?EXyLNSLMOojw67O62E4PO/jTso21cW/FH6zlmDpfVeo0ZpPEbd18jX9h5vsk?=
 =?us-ascii?Q?NAakiZTGzZwO4TfO35K+kpbvJtHVwloaKlZLGIgA9Vfr81kWq9ztjsT6AZwS?=
 =?us-ascii?Q?z8lJD/P9GGlT62TfFJHva5ujWsWSxlZlMiHyQnDwMlWo4vBOt/qyaihOVm5a?=
 =?us-ascii?Q?nkhdVMhkpI+vvWWXm9i8pDofYuGsBh5ZJQ6+LsH7Kns3NQWHk9RobB39HYeV?=
 =?us-ascii?Q?GSeopLmECYxSiraxD8Cfc9JG+gJp4ha6kPxv0WWpnn0AGCPzVQDvzVinjK2Y?=
 =?us-ascii?Q?wTH/+PJCTIxn4PA0cNGocde3226a1Mahfg+FcKCCCML0JXyt6J63ZK+4PqJv?=
 =?us-ascii?Q?ua7L+rqjwTsRKIfInpnuV7w+qQq8vSGMVWcZFKr7gXwsJ/UFSw0T3GoF8y4N?=
 =?us-ascii?Q?rbnAuRPTtVpFepcPvey8ffkjBR/auZmfqB23adcYeTkgfkIINVy0YGYZDWrX?=
 =?us-ascii?Q?P2ZC8YeyJOE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JcQ4FYzedFanxlkTsXNPTflouaEOCaDO5hGHSoWtTtlWm4OTVZCibXci4HC+?=
 =?us-ascii?Q?yCSas/X8RrbqWX4GxEqkw5v39MUE1Yr6xWOw53Aifzsa4EUF4upvtYChjgvY?=
 =?us-ascii?Q?XBO/VGNZWLqhlWWzHZX5jfEZhL8yLwyN2ZQoMyPWs9tSeUooCNumWlQDiBOG?=
 =?us-ascii?Q?eHfHsyBmih5Zg23JTRQDj2fB0JI9Yxs3S/wl0qhIs7QdWnoes6SH3Ea/IeGs?=
 =?us-ascii?Q?Kr9ygt2F6bQSoCrO3crpqbwTp5nUeIfwPx2y2m18EFsJWWhCEXcllk1xNrSV?=
 =?us-ascii?Q?bv6cN02uTVnGO125dQU+2PvLhyDDKG/rPBrJ09ln5xYDl9k+vD1TkEHF7jPG?=
 =?us-ascii?Q?niRl80Gsg56XFxagY7QIgkYOkxs1p9WCQdBdo+2JnF1tJCn7qbgyH65F1W1M?=
 =?us-ascii?Q?9JLT/EbMdPQvDt/TPVPnd6efvGWapimPv9tKHSm4ybv3lfQrdAkB8PGFYMlM?=
 =?us-ascii?Q?+aky92g8eXiEKdHP98uOGqtXUwPhlOwNfLAMLrhWMtS5faU5+CxdEqp62IBI?=
 =?us-ascii?Q?E5Dok3z+2uwVHBH3QyujsfGKD65xHWzdOyXS1pplhUxJTEfJKRoYJZB/wg7m?=
 =?us-ascii?Q?AeQIGpIGT0KUpCszCUHfOoJBzdazqN4fMEwKvWqd6A8fHN70w9Dskjh/yFh5?=
 =?us-ascii?Q?0rLn+cwlA8fin2CM8G6VZQI6n2fxXFSK3dYFbx2QFRYLTljvvNN8NqAEto0y?=
 =?us-ascii?Q?4zCZu9u1Hg+MbNCzjbtxUIuUn1C0s9E3weJMWJY0tFvER88+LZgcWOcTDHIv?=
 =?us-ascii?Q?GLj56pKFeRmHpNafatjNS+PN2VooJ7CgLQC0F2oxBW521hfFxPik+5nQ2ieF?=
 =?us-ascii?Q?0VRoMshf+wlhuwnnAi4pcw4+nMoHYfrGOtoLlpjejNqEqsB281rbBjfGZv+8?=
 =?us-ascii?Q?HE5t+75JU7IIIMB0zvPa/HDSZBwnjfyYb3hGNdkCOwzpBkMGZTg0eDK4ynNi?=
 =?us-ascii?Q?eGoI2fAuc3iNsEwB7gxAzD7+kvGmJgZCX7O1+9CUoHjvEb9B6upRdN42otRY?=
 =?us-ascii?Q?r0efqsYZqaGoMetViddOaDMJOdo8BNCWWVrY8ej9o5dSUPMT7OLOzhe5JTGC?=
 =?us-ascii?Q?aVj6m9ZsWuM+66LHOv03Ca6FQNtLCO8ztvaM1ihNnO2fmf4S3sAYFw245dl1?=
 =?us-ascii?Q?TkbI49yxpYcDEoVoii1tozZigLWmASFOkqQlnWRoUerVJbp8sAJb8UyxmqyG?=
 =?us-ascii?Q?4SxLXcnbueAfJF0yplmeZdWi8Vetgg8cHhZIUBCPadRgETBxfS1ETaeA7PaM?=
 =?us-ascii?Q?rlxsbHAmZPDV4k10ZBuWk/1lmhcAbydi33Yq6p4eEo8fsr7P0SPRNx6oTHR0?=
 =?us-ascii?Q?18x9BnmYzBOPHwmpBNoKaKk+bDliOuqhYApZ350+WMApk8wgX354OQpl+Pu3?=
 =?us-ascii?Q?EwyG/IFXMHGlJ0lxKDAARTyUTW91edu351lEh0pK8OHk3cooYXFK/9n20n6V?=
 =?us-ascii?Q?nz7fz0x95neEG8e0SvcYqnNU9NGCMFYAK/L0hLCmwcdA9WKriIvqxCOO4UH6?=
 =?us-ascii?Q?n6oBOv5EUsOw9qtZihZbwVgGNSyq1GJBiW9jnNhhwMeYLdY+RX25QuBxDpze?=
 =?us-ascii?Q?CX3IKATQ32mPa4Cx1pAKXyWLZvnmxKg25pBcMMms?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcde58a-1776-4569-9e2e-08dde59d12ea
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 19:08:14.9573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+dcgiNEhoiWVS0U9hmnSjdmBLiBHv3jJKSq2xY9QRZ8Z1h0N63sNVGUD5EZsQ73drznFWL9cp3erE8z/xrcBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR02MB10659
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDE2NCBTYWx0ZWRfX40m02sAQH02+
 TAZFl7kToIG6Z+B9dgsG/ugB8YocZNoYFEa0uBKmQV4E66XSIvKSldRuq/LCjCjT0wN1UtmB/5I
 Tw79+ms8YeVN9uV54E1cXylxUgK3dcJn6T+rpCZR/jzavpbawxtuTiMbtigq/EYRT6nXO6f9p9F
 xVncpq/LV8pKvSxMFfCNqeVIfU3hM7CXj+9pGUBSAUdApiF2qHzjU1nMx/W++dtLIER02psL4/e
 cAdSbz4TmdK4JMwbaq9s7pNKap3HiZ8cRzZ9NujGIPRUzLbv1NbecyX+wbZtHV1L096DfqmSHT5
 xSiS0EoonVOBdAoj0gAebiOS3BmDldXt15+ybKICo0mMGUVoYzkHKEqdSyH2pc=
X-Authority-Analysis: v=2.4 cv=G84cE8k5 c=1 sm=1 tr=0 ts=68af57a1 cx=c_pps
 a=h/zdu8LGojurgwVeJVxNZw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=fGrUU2wE56F6oUrtNFoA:9
X-Proofpoint-ORIG-GUID: kqjdNlMtaTh2L9_OsFj5nFae4vO8Tjni
X-Proofpoint-GUID: kqjdNlMtaTh2L9_OsFj5nFae4vO8Tjni
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This new option was not added to vfio_user_pci_dev_properties, which
caused an incorrect class code for vfio-user devices.

Fixes: a59d06305fff ("vfio/pci: Introduce x-pci-class-code option")
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index be71c77729..dfaa89498d 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -406,6 +406,8 @@ static const Property vfio_user_pci_dev_properties[] = {
                        sub_vendor_id, PCI_ANY_ID),
     DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
                        sub_device_id, PCI_ANY_ID),
+    DEFINE_PROP_UINT32("x-pci-class-code", VFIOPCIDevice,
+                       class_code, PCI_ANY_ID),
     DEFINE_PROP_BOOL("x-send-queued", VFIOUserPCIDevice, send_queued, false),
     DEFINE_PROP_UINT32("x-msg-timeout", VFIOUserPCIDevice, wait_time, 5000),
     DEFINE_PROP_BOOL("x-no-posted-writes", VFIOUserPCIDevice, no_post, false),
-- 
2.43.0


