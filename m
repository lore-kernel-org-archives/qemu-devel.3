Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19A1CCF2E3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIm8O-0000p4-0H; Mon, 19 Oct 2026 08:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm8D-0000aV-Ab
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:21 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm8B-00047c-Jf
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:21 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8QTtZ3460294; Mon, 19 Oct 2026 05:06:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=po3EEb9dG7/G0E+Na053cQN8h6xsnwFa0pjZGUjYe
 P8=; b=tOMVb/sQxDKYRay9HGLrNQ1vBTyj2zKggrW0QNYjZYqD7BfLAOWfs2/8v
 UxJx1pPzNyZloWeiKPu9rqTJL+nLXftHIZC0/k3n/oPLH+1lRx98YFPk/36BwXgm
 tK7eAbaPnBir46pJa+gjMWnwjVDRYW6EY0nkIWHwsZs2veE1Cf3ruyhX528waLMy
 oS82b/uw8D8tK5dLph6ObXnIO3jhwwd/QAX/ilto7cu9rDqmC0aY4jfAzLhXkrkm
 3FzzfsdbWdLFO09YUKtuzXGJDf7nwYdHBqUZevwvJ58mwPog0aJ3JoVo/hlnEiQ/
 bHrMGJaAlqe0/4qa7xnLpGfwfT5Qg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021105.outbound.protection.outlook.com
 [40.93.194.105])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hc8jwkfub-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:06:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wv45yEzcQFDAmDS2ikfc5aRsYA4UkWDeTJBGPaqgJ95AvkeAulVAAN81uPwDjAp6IYKcaQ+KORC7UG0VhtxsrSOa1AJglh07dmkwzQIQ8yEjLeGRS4t5xUmWWuljBKDlZQfrOozcFZryi8UaH0aeywUkK8YIXzmwXK9x4dL+3LP1r9LwleOSFWeaLxqaWwM1jgnXBIp6cWkCdP6Z1qO1qLyagaENNPHZ6tw4/wVE2sluZRXf35S88P2WyKlorw/rAF51TolkJS30uLn/lEf9HAcGbQGRcSpjZuQmCNUjQTfYajc59uv6z11vTsDVwLZ01c4Dz/1/HOYgbZy831zAUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=po3EEb9dG7/G0E+Na053cQN8h6xsnwFa0pjZGUjYeP8=;
 b=TdqJ7GZTuIAFyuAw8u9RXXfO/zyj3oHiRPfiVgqfz4tQfssOcnUdE2R9lXWvcisEbfgKQpLLrFXARSX1FmGiQaRuKxDz/6BvI/acRVbjcLqBeGhIOBpaTZQhjrk4r/JtWtgEOS607+VWm7PUUegTkpbqg5x3Gia/OWuM9iJEJgJFof2OOulcNYyESBhBkqtd19qmlHhHSLUKVUxn/KX+JbIjsVBEdtKk5XKbZdJfYDq5XEtP/Fj7kFM9hqhFlQATBXnX0edb41nUiHfqunZCzJ3BVDEq3Ln8gwWS+M98kLuKqKuCvytOEHdBhyRSdYoohQDIgtI3ua6movow+wN1ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=po3EEb9dG7/G0E+Na053cQN8h6xsnwFa0pjZGUjYeP8=;
 b=GOZUOM7Ux6BwxWs1VVf1zXRbyOC2PSs2fQtySNTAM/AG1Wp9V/8K43+zenUqn3EUdOnVx27GTOcSeSTUDtTusXRDdPNR+akoQLXCludVii48lS+9L3XxDfwZ4i01xuRoiWbisEfEF0Wai5duQ8C1Wybj6mlJGan/B9bMaod2QXzqJN6nhkZilZH9lCe6MKz2CPAM4qtxaZOqHkEtcsD6AoiN1SSJ4RqIp9ApkSGFisOMB977ENqU05vll0uqs9YxMEa6o0S/iWYJZ+xgx9dHMdirjkVY+mFgXc8j+U09uvw0wDO++ANxclXnntOOqeVARJDPg3hzGzWe4A5JPj3ZeQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSWPR02MB11441.namprd02.prod.outlook.com (2603:10b6:8:354::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 12:06:09 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 12:06:09 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v3 15/28] i8259_common.c: convert to use DEFINE_TYPES() macro
Date: Mon, 19 Oct 2026 13:04:47 +0100
Message-ID: <20261019120517.1448687-16-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0013.namprd21.prod.outlook.com
 (2603:10b6:a03:114::23) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSWPR02MB11441:EE_
X-MS-Office365-Filtering-Correlation-Id: 4796ebd9-b609-4371-9a45-08df2dd95ca7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 3gSknD9vFVWEMRCf83RiUdQeP2j7+6PidSWO2Dz24ejvrgjlu8RWA0kHVn7gIhrnYyQk8hYuqmpUYM8p/NTSWChPlqUGy+pMZh1zl5i+NH+xVpMszTG0bfUHICmecEbvUTQFPHTTh0FCCBlKtuOMUzBPDB1mTxDM7pP7xy2wU52S9uXUCqoFKRrMA8OMXojJW1Tda8UKtIJLOO/iAOq6xvz/kb8jWbpv3EPa72qAaUOKf1PpSe5vjwJVSOb6sB//NBGQo0OE8OzzMMmLYJ4aPXXKHQ5j+sHbCqDctoNKYxQ4dFGdsMqwKL51IFjBxzgLiB8PxXj+q1WHtZq/VtzQDRNFKG7xcInAcB4Rj+e8n4O9dbZa2yBwAu3TL88zjhMHnABryWnrAMxc3JvZSgrTYemGPd4j2L1V6Hbr9oRT0rhSHMuNgn7TIrXd1weqdJAV/rYijEknGxFHJwICPwQ5yURhESlV6LrHVFsHzt7tAQkr/YnWXskfsag88/PQCfm+wNbuOGYtmgK3hxiVEdV8klNWVsJM+3V1nWCVRCAIMQuN3+5V86R4xqL12yXNZoUeyRZBxK4MQ90bnEKbUFYBYxV3BzA02LjBy3uA/pUNajRcY2XEX5tJepeEERPKkeMfP3U/juEBIwC0+ChtHfCejB7Slu8y4sgA9GYfmKUuDgs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zQyS8JjoF3YdPpLgqw5KEDaJhBJiHqPDsL3+3otD5JO2ql72DeW48k3UQ5i3?=
 =?us-ascii?Q?6T/5p17Y84ZBedcmT1e12GgVXeac3zU1AaM7nrdE5s9bgj82ZgOPtsqia9hm?=
 =?us-ascii?Q?xByOtdDc6aR/HVDrI6TwGMaEABztvC6gyWKyS3nZ+SlM0N3oTGXikhhHf/ks?=
 =?us-ascii?Q?4qjPpzogYdvOCsXecl9eN+WKCqaJ6AAG/nFkrScDYJLGUKa54T1uBPrqAZ6d?=
 =?us-ascii?Q?P3X2CLrtQg48c13gZZXO+CD1XOGrgzo44sr8vzGSRURF5an5sMJ2YAkO43KO?=
 =?us-ascii?Q?CdtKERYoTnPqFmMCItFWOCKjDeRDN5Tqs0mssIrQr6sLpDk7T76AW92HjROd?=
 =?us-ascii?Q?XTJpnfmv0JJxN6RL3Wn6qyR4Y12A+lf8xdkQFLSr6ap0RqlE95l0y9AF42tx?=
 =?us-ascii?Q?byHjeUe/4y8Z8/5uO7rmOh2yO42Vn6qYZH1QSKOJGYyj+ves6HowJOrSEU80?=
 =?us-ascii?Q?pstj/alSCnHzQpaUTuG1q2sERSrJiYXVuY1hq+8x8jXgeKBvhPCeqXnQb315?=
 =?us-ascii?Q?4Evi0YKbVV68Lf3GwIDOE7jbwuksPZr3o+7GPy3an+f+fhGb3VLgPKMX2+CA?=
 =?us-ascii?Q?LaYqjvYwo/pSbiCapNclOZ1Uk2lo4F3XXXeZ/8AfZ8rQadLImZNql94RyWTd?=
 =?us-ascii?Q?7iakXwH3KYN1NBxIlfV+N9sDynJDrgD7MyOccjch5jEa28/p4pB3/dXa2SIc?=
 =?us-ascii?Q?H++tf4jVbgXLdjmllre2PcauBnRIKN1R+9XCALn6OBYCj3Gh/T+uBXpiiXj9?=
 =?us-ascii?Q?upV5u/VwYWwvnFVBM5nwpibTtzT6dJiuyB0PVwkFWVxjqjRPxSEOjVp9n989?=
 =?us-ascii?Q?wXrq9ib0ul46GQm48pTgI0IL/WfIt+ZWOhd++H+hlnz+nsSVf9JAxlqZItEO?=
 =?us-ascii?Q?6JCfYeKiBWvf+LNJFwKt5d9Si3wnSkrwxeEWyyI5+MYLBQPDuKAdY4bJMinb?=
 =?us-ascii?Q?+NkEboWA9fpoFn0bkS5RzzYHk+ADKkryAClwdNyR3YyG2v+kfsTmdRpmgWY3?=
 =?us-ascii?Q?MbwMoRWstpaBtuhhcAiLQPDxGwCsfdNpL1B9NSlZIeAHoMU7D0OQ0SnKvLyl?=
 =?us-ascii?Q?7/bum/ls9ts52xg121EawaImVxgNuh/6/hC3rrgVoi8OYY9fJneg9l0ySbzl?=
 =?us-ascii?Q?4sF9dZ5L1tsWERQ65IYC0wQE1GTfa+WSmkyde8c2OnkqS1ItIp1E07q+qdAp?=
 =?us-ascii?Q?DujUcv/IYVgLFne76PB3+cFEtu8yblk9JbM21tqPdUue62LpkCaD78kkdyWw?=
 =?us-ascii?Q?HTALU34yIWQn6QF9Z7rvy7c7mDmQjuXTWrgT0OQPOsjdBbYPkCpV5YqjmVoJ?=
 =?us-ascii?Q?i5JOTDObco9zqgWaBv4fHKvCVbb7YaCRGbbOCzurkJ43q2kffr+mp+VPnaFr?=
 =?us-ascii?Q?VDTFaNxgs/XT/5gsLuayWrHoed2t874yKHici9JUKp2Ye23IvTx0rr/t42dQ?=
 =?us-ascii?Q?JbpfY3kivj/xImXVycRHYYpRrKUXC4Zek7voA2Cj+EBNkoPybPJn7sl55tIX?=
 =?us-ascii?Q?jw8FZAqFe18GJTDZlt6S5ZFAtarwKet6lyN0RIjOPzeK0DgkImRdeU4nkNGv?=
 =?us-ascii?Q?o4/3Mp4JAvvUMJKtxbnlgF5OdtFuk8KNNYW6MTldD9r4oWl8QUepe7UXx6Ea?=
 =?us-ascii?Q?LI2WY/W17/D6P15qoah6r6bKjm1AEme/5GhKK/NH+eOk05gXbODqGCf4Bzud?=
 =?us-ascii?Q?COEy+Riow2KNag1YxIsfPutQ6K+rVyp93ZIQV+eU9qJX2jOasDDHDWbDIzFd?=
 =?us-ascii?Q?W28yNZf6/WRfYgtfczSamaZR7Xy2QDk=3D?=
X-Exchange-RoutingPolicyChecked: gyEMWDK/WfVk0yNZNHNv38NLqUMoTqqlR4YfoI8/t8V491zZKinQ+0hHw8YYEZD4emBtRqddeSduOKT5Y1L39SYKKN2Pw8oBDQqZwQnCfLSmNum0XD/0a5HraLYSrhSrX05YE2oUCuKHAG4MAioIk8sjQ6ztyphx6HN5dW9f/pou7gjY9vNVdf+ePSuti7NRVQnfZfxdWzJ89yB5tAcWPygEz/yD18vkxl7qyruY04fZR0jpTWaZLGl5GQK6JbxqP0zuOz3939gJ7vAyBeLPnctdW/ztF/FeZe27Bzvdin7MzlPjhuV5oubJNkGrm5CJoj3A002yKTxPTnj5qdEUHA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4796ebd9-b609-4371-9a45-08df2dd95ca7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 12:06:09.6290 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sPISeUbywyvEdtlksSVJJ7T6xqiLPJ3qSzcIc0YxKsRxzbyVAcokWwe+xbEWXM9RP6tJ3Y3yucEUMyhWnUyJG69oONZKshEvSBtI782SzuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR02MB11441
X-Authority-Analysis: v=2.4 cv=OecNnRTY c=1 sm=1 tr=0 ts=6ad607b3 cx=c_pps
 a=zmg3q5OHj3OrxBnMicu8lg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=bPck6Z4TT5Um9jj7BtEA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX/RnbWjU9u61G
 +P9ynO/lUwCx4Nlb0krTGm1eNCUu3Qp9tU4my8ICs/53UWplXw/9oZ2NEDC6THfCuc4HfNZJhmt
 kvvr2mfJLw9Y8ggIdmcXbFONyR3ZCEHVSoIINwYVLgAmUQbDxQgNUK1cDiupQ/G0tQFyvxQB8Hs
 yCYBjV5isfNwdZXa9VNgjepDcbRiP3DUVMEnSZqCj7N255JHShUdHF57uFLc0Ez10LwQLK6q8C0
 WpsvSFhnu1LOHKDWNEGl0kH2khqGwf2LMUk3qgXlT6THXSwiqPwxGF8ORI5bem2K4mNUgr7eXnv
 p6Vo2qUS3gW4hpzxwz4RIxqQ1GtBkCsUwnZCCXwa68ypPe4wDUGfyUl5XYOT/M0L68pTBtf5cov
 BeFTHNpgwrFw6ncXJv4r/6nZRKf2qTe6QSOkuHalXxKPHKICUPoDRgrGwaNz861gkxKkmByutCi
 ldGAXmT0H3QoIRKzKSw==
X-Proofpoint-ORIG-GUID: UlWlS3-PANTYhF7JWIkkeUqcDdFmKJ0L
X-Proofpoint-GUID: UlWlS3-PANTYhF7JWIkkeUqcDdFmKJ0L
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX/e3ANpbUCF+O
 8eQsgxxsicyQ47q7x6CUtyJJnORBsD2QdTd7MNE/qFMNd5pK++Kf2V2u9Yryo2IpgcMWpntKcMC
 +Vl9NmMGGcTji8RglZ2PbYVRLGUF1j4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/i8259_common.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index 31bd663439..09b761321a 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -220,22 +220,19 @@ static void i8259_common_class_init(ObjectClass *klass, const void *data)
     ic->print_info = i8259_common_print_info;
 }
 
-static const TypeInfo i8259_common_type = {
-    .name = TYPE_I8259_COMMON,
-    .parent = TYPE_ISA_DEVICE,
-    .instance_size = sizeof(I8259CommonState),
-    .class_size = sizeof(I8259CommonClass),
-    .class_init = i8259_common_class_init,
-    .abstract = true,
-    .interfaces = (const InterfaceInfo[]) {
-        { TYPE_INTERRUPT_STATS_PROVIDER },
-        { }
+static const TypeInfo i8259_common_type_infos[] = {
+    {
+        .name = TYPE_I8259_COMMON,
+        .parent = TYPE_ISA_DEVICE,
+        .instance_size = sizeof(I8259CommonState),
+        .class_size = sizeof(I8259CommonClass),
+        .class_init = i8259_common_class_init,
+        .abstract = true,
+        .interfaces = (const InterfaceInfo[]) {
+            { TYPE_INTERRUPT_STATS_PROVIDER },
+            { }
+        },
     },
 };
 
-static void i8259_common_register_types(void)
-{
-    type_register_static(&i8259_common_type);
-}
-
-type_init(i8259_common_register_types)
+DEFINE_TYPES(i8259_common_type_infos)
-- 
2.43.0


