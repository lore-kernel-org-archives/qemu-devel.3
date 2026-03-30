Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE2D1061B18
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 18:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7HdE-0004aV-EU; Mon, 30 Mar 2026 14:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1w7Hc2-00047Q-F2
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 14:45:26 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1w7Hbu-00019P-AX
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 14:45:21 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UGK1s51679045; Mon, 30 Mar 2026 11:45:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=GLQGSNcfF2U85fryUec/oN+4gOzP8dMQPSkKzl560
 8U=; b=FTmh76Qz7Xh+W2Br2Ur7ywh4stMbjDbLKDi1+1sGqLSQcBe4Aq21JKqlJ
 hzVlNrp8zNPmBNzjuBkVfTHRLLmoOvQ6evyRRBB+m3FjruOgTZHthZGWM5de3pNQ
 2Tt6DMtQqKByEapYsTuinsrg8mBEvvg5K8sXMrc0caHLmpdsEeAioIa7qv+eBUNN
 8orQ12S8Iiwba0JKASjpFqNGahiVvFKZ/gQ+B1pZ110jGydVwzD3wqa4Nz55bbYs
 E32LX8n70gB8pIRa7p6hxCB+eUuAc+m8S0tcIzK91vjDRp4VTa3EN/EEUHZd4DAD
 F9CR+TSMEm2tPHb3hTTvxyDTI+2oA==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023127.outbound.protection.outlook.com
 [40.107.201.127])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4d7vku8c73-4
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 30 Mar 2026 11:45:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlIxXVLydJflQJ0kwrLUQHqF2lv+swk75UJs93dKxPyGfBhhOpGPWZPsLO0eMrkHMsEjCdaiSwtm7PxaAuFNf/6xdrI3+qeImlhb65+OS1K/1fQDHqXBL5AF9+Ig93ba8/zCG/oLB6pyHxGFM8y1ql8v6X9Z9qPTEGg11LF3xq8z16UJ0bbvAgRARrtuHaXj5IiGHOC/aavVOyc51wK744sq4Iue/CgQnGOVlk3vyOJyCfJ4RbDOzBN50+xINr87y0z/ay+Ev9q+hkSPBeWI3rNVKLrUvZH1lFaShP3TJI6h/66uXVpCKUEtOlIEs8XoKIvGthRcu8u0WNK+dKVIOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLQGSNcfF2U85fryUec/oN+4gOzP8dMQPSkKzl5608U=;
 b=nHMq9Hppgs/JwPLM5lkS6ycS0jqde7lcll+OMCYMs19FtmWaJOkSaT9NZO4ZD6BrWMdcSeJ1TWsnWHYxnnKtXi5WPPa+nKJFQRetr1gmATlE1z1fUnFHz4PhPJfz8aO5EhnJk41FJJuph99dgdxQFXvdt1c/LwHL2zLFV+SlPsrjeuUH0zJ2Y3ezqFrqEjwvPif8LT8BPsiC7RKG51GIY8mykJNtB38ea9V//ptTxRmyCyrO0pRZf0iGZ7SX7MXC0AnX9cV8pRkVMfkaTqNEPulAa3VBB3zG26g8anh/BsIrWzvXt1cv56+TNOqAAIUBZpZB5bQGm/OlO4hf3Pe94g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLQGSNcfF2U85fryUec/oN+4gOzP8dMQPSkKzl5608U=;
 b=dcwlkSeqKeE3/HU0hDUaHNSx1T+ugz2VUy3cgGdi5LrT5B7wlMtXMANuAVGceU2TFUgV77WLGs3SFKNZfO8S5pjSawFbdwptHgJgL94hyKLJcz8pJErUc+Y+exEtkpFvhGrwYLlXfWNRb8phOynXmSCerYjjNQ2Sz7g9Swn4qoDKs4XGvxHgX3sl4h+/isHZBWH2o838yLY1DLcP6HNdT+J2iDy3M6Wst76yg7Xazcx6ITe1PDv8ZXaVK4T6N4yjHrmT5gAhZdu26arrIDnn6vOb87dQf+aortGYs5ou5jIP1Gr1VIbPwx9dwpHjc8If8gAahvTVxEG4pruJQ1PTLg==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by CO6PR02MB7618.namprd02.prod.outlook.com
 (2603:10b6:303:a9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 18:45:00 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%3]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 18:45:00 +0000
From: Jon Kohler <jon@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH 3/3] target/i386: add new Intel models for MBEC enablement
Date: Mon, 30 Mar 2026 12:34:28 -0700
Message-ID: <20260330193428.1663253-4-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330193428.1663253-1-jon@nutanix.com>
References: <20260330193428.1663253-1-jon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:610:cc::33) To LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR02MB11133:EE_|CO6PR02MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb38fdf-83a1-437f-637a-08de8e8c726a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|376014|1800799024|56012099003|18002099003|38350700014|22082099003;
X-Microsoft-Antispam-Message-Info: L/ppU0vV6TLHii+QGavqK3Zu/u5JnTat+CXfiPHNN2KbDlKSUw4ddwI/OBUxpTgSlEHdNcppuNfeFeQmmtU+VsszHtpLWbIb0dpGQvF/kWMFxHxUs2njaxiiyr4VFoHhJH687yAC5Nj3r0zhOjsIwa7IwOn3hDz3n6sNWRlIh+AjT5HYKCwushpweBKRF+U0CJHFQvXqnBMk4NZfUfVoDHhzsLZBXhbUXy59jpqGiX8c/WlZvCGCU43XjAIxiLu3pqhu4nhOmoL9xhGyzXN49fM52x+nzXFp1JBOajFgLbkc/jomGH7asalYumSkiMaCz4U6x5brqMPk3O/+tcn8DV1AK7Vr6yxzS4ZKNxARPcWvl9K7pmUYlL4M6gvjfl/qBrXO5kQBzc7C+ohn/2gxgZhsMl1bHYOTeFV3u0mIPqzBqQ1jNK3lRMgc4WnRd5dp85yPJWb7r8uzb045to86c8v2qc8llazjSWgAsvXRNJ0QMbQaZvYasUQCSofCSU5TaKIETsyF5kKVNzN2V7iQByQ5dIRkwwBROIlHB8U7tROn2nNmP4dJRMlyjfLyKhOV3XcN5J49vnDHIblA3Q7yqv9NDBM4wXN2L5s4OCeSd3XEYb5px8WFh8h3L1a9gj4C/6s0zqXiv0hw2x5cqRS8GSnHeuy5O4uQkOxfQkUb3tf8I47KRID8XHIjG2YF4qg8VQiDqA5lW2v0GHbz7AqOstaQkDJeM3ohUq+mgQZlLN+9JUenf+7rMsVeRgQzsjI8Mwug2sO9pme/oJ0usyiAN4tBrKQ1btnQ6wpt04biHU0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV0PR02MB11133.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(376014)(1800799024)(56012099003)(18002099003)(38350700014)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9rnOnq/3AE/D4n5M+Nzxk1o6QSg5jnkw5zJQl6v5KVYsnKORpMpwvClr771e?=
 =?us-ascii?Q?US6Ovol94qMBKmhaJ2cHi6PWtm2EFC7N94vB/prCbKyQGO7a+qDkCOKjgOkd?=
 =?us-ascii?Q?zKidJU82/VhTgPN2akJFW0aeOSIUIIyhMOCcsdxj56E/GeD4bgkunMjwZBYz?=
 =?us-ascii?Q?a2tk5VjuS9hnj7bmPNEE24ydCO9H1HxLw+7qoWMC+7TWsFDimAV+SEyk24V5?=
 =?us-ascii?Q?tbV9abbaGwYbS4krnlm4wNsBxJVgEH50Mx3FAVgnFdXrDHdt+A832VhND/7/?=
 =?us-ascii?Q?XYeBbsZNMzK9YMR08wujLfwMDwks87Z4EvrRYX+6JSYGalYkO5QeZyVVUWK6?=
 =?us-ascii?Q?UntFe6stAk6R6Zqd5Iv6K5LpgTMbd6AziddR0XDQjWus0LirQ5IP29+wDr0e?=
 =?us-ascii?Q?C99pTvuQXl2fCkxHSiBPWdHv5H5AdbUTKG63W2at8MmQjCiTPczYahWVjOmG?=
 =?us-ascii?Q?zu0fk0EtQxEaSbTmi6R3cBSvnvUqbQpG1/1wAItsHBwbjB0ZkuppKnddzQ0x?=
 =?us-ascii?Q?4YdigILVbuXOIVsy03GrsH8PCmlfmYWR7a5atUnsEQb1rvU3AI3yzp0j6FQH?=
 =?us-ascii?Q?pwmkuXz8x1Fu9tg2Dw9K9uok8J2MN2aV2lXHokYvnBiTsThZQMYJ7fdV8fBI?=
 =?us-ascii?Q?nNme5ZxO3TtPIQfJjS1bjELmKRi+3OJ6uAnNNzrP53iZwztkvClqsx3PseFJ?=
 =?us-ascii?Q?8tVyxq91ZK9vQ/fpFe2yEgG1nk3tJjEv+ulBS+xo/W1rM73DYSmY4nswy37z?=
 =?us-ascii?Q?nxNEC9S+4yxsgVdLHnl7CqmejvYfQhdh7pGDCiEVNUmWT4bKA0Hw09bZddw2?=
 =?us-ascii?Q?RBsy1rACyuDdMbECVQ/kHpGLMxx/cmOJcz8iECOX2gkt9V5IT1o7Gog7oerH?=
 =?us-ascii?Q?ffAFx6hxTIzVIzMEO986oLdDjc8Xez1OlqtKxvlqbsX03OZ9woqUR3JuzTxk?=
 =?us-ascii?Q?naAlE65KS14FthMLL8olFM/BtSP1hTto7hVU6vu5uR0+S5vy9BF5meXJmdOJ?=
 =?us-ascii?Q?uZBkT1/ntw2QdTqRtJzRfiyH8JPopWEcFwXcfV3vkQegwmi242WcEdgh5zP7?=
 =?us-ascii?Q?/z4mj52K0qy8yeTBN/cXgX4g9D35YaBpiOYH3Y0quPlXCq5NejFfBGLwuHbI?=
 =?us-ascii?Q?T8TvzssDYAZuENsp5mobVNnSu0vFkn0jm/PyvHE3yhxbdEvDlVP6MnVStZuM?=
 =?us-ascii?Q?n9lblfVVw7eaIznq5GNKMHqkGGRclBqcSfKpgwtN9uV6VDYWWWIwsRLVAuWF?=
 =?us-ascii?Q?1hHn2d+8ZMGdkhfs6ENxlstcXxz2lltcyu9SqSY0wNd2v3cNiA1b+7GGTAH9?=
 =?us-ascii?Q?+hxaaaA2cIikIbLMBcAXJ9QNXbSzOfrHAJ2k4pPNEqDaiN8gnOzKpXuZkUwT?=
 =?us-ascii?Q?cHS1L8Jae92gDdLAshu0DcBAm8btaTJ2gBb4EmXkKCoDqqYh0TU3OL4MmgZW?=
 =?us-ascii?Q?p/rjUaVFI+u7m9wYN1mS2MTRb3zhG/suzi8Xop64E6gpkyZDI+bwZN3Vru7E?=
 =?us-ascii?Q?6hP1P81IPjJGSfoDiPCC8NKmtb6ev7dZSqZ9iQWKKeWbUMMf8w7KnYJFlhpO?=
 =?us-ascii?Q?TOhfRIyEruUQfgmSLVVpKcj6g0TAAmkrce5sWAUbCp/KaGmqYGcZts8HCxfa?=
 =?us-ascii?Q?0zAaEH6cZz7d9Eir0GRXwEed690QVLwydiWTTfymtMdIJfp6H52trICxDOtv?=
 =?us-ascii?Q?1WLi2MtCZmT6/ikn52RDPhpqnVVqFQGpOfgrnzoV0C+km7zZ8Ii0OC74kTt7?=
 =?us-ascii?Q?F775gCZj82Te1d6xwf4N1iYPWpcQSDI=3D?=
X-Exchange-RoutingPolicyChecked: U8NGvWKKxM8P2dYs5GHFpKLjk5CfDjnTmv/PcxL61aUwDBiM24Yx4xhpWB5vsiEwfmakiV1dfvLM9uZ9pN+YWr3sGjNjveYpYzHaSUs01LMqR0tXUo6KEQK1Sn36NItA3Bto95MZYTynSStQdIRwo5BSr+VTzGmUFHAYOcuAcCpO5rXzGhlczvhtPRIJ10fJN945phbnorEGrMK1i7Iv5K6uHbNDwAjP+6HiNYkVGNyYKPjnlekIuQUEsfc3ayLjoqdHP5ncydq1zNdw6e7jiA+12ThOOe3wEDCHjNKA3bNX3UvpKTOFlYzRVCiDzy3dRzQ0XJz34cX8fqD6Af3gMw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb38fdf-83a1-437f-637a-08de8e8c726a
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 18:45:00.0896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rftqftkITxGwmB7Gi2Des60MIodkb9d9QXybL9VFfXj8wR0OEHiCmbM+lwBYA0tl0W9ZOz/MPXpcsUiwvkxAw/ToIhJ5hq+biwtZ5LbF3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7618
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE1NSBTYWx0ZWRfXyGXKxsbhw5JB
 Hy0wEs55AvLEZDgmJXdVSFaucnxGSE0dGlpzhh04lbyCbA2+48fVbgNvVJfG7HdDfOSH1ilNYR3
 4Y0n0566qfp3gawPzxEKeQ6gByaNHCW75kurE+szokCfvJnbvvu/IsIFBnNvUSmyCfMsl89+QN/
 Vhn7BS8Mb91Gx6u6AGcUhdY3873mQfnp+2bKahK4fPYQ6BcGtgTeiQ5JJ7HcQvBpw0zhB2cA9rO
 thkUdixNaaY0+2BLzpFc2F0tK2QLJqsxYqw9jt9LOJpvFsd3iqDYHM46Lj92wTuRpoTNMV8ulMQ
 iNaYuI2fva0aLajtmoIB09VDWpFWa6Y7Xq2MI4oj2J5MNmDZlSEKe1gL1FBa8w+PeT6x5NfC4gh
 ZSLuBUhnB+qEIU5WhddS/ri9ulgp0BpOL5lzZLyX5SIp2zMvvAjljV+rEavP2drfYpyYKJBE3qY
 uOHXjA9a0M7iPal3++A==
X-Proofpoint-ORIG-GUID: FwHeyTbMKAx2dCB1HdueT412uNYwvxm9
X-Authority-Analysis: v=2.4 cv=AIht02iE c=1 sm=1 tr=0 ts=69cac4ad cx=c_pps
 a=MP9y2KnavyzKo3MGO/hTew==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=64Cc0HZtAAAA:8 a=AHWVbX8AQpaoLjqsGfgA:9
X-Proofpoint-GUID: FwHeyTbMKAx2dCB1HdueT412uNYwvxm9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=jon@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add models to expose Mode Based Execute Control (MBEC) support, which
is a Skylake++ feature.

Note: Future models can use VMX_SECONDARY_EXEC_MODE_BASED_EPT_EXEC to
easily add default support.

New models are:
- Skylake-Server-v6
- Cascadelake-Server-v7
- Icelake-Server-v9
- SapphireRapids-v8
- GraniteRapids-v7
- DiamondRapids-v2
- SierraForest-v6
- ClearwaterForest-v4

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 target/i386/cpu.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index aa7a91c0e3..0fc7132ef3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4767,6 +4767,14 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ }
                 }
             },
+            {
+                .version = 6,
+                .note = "with MBEC enabled",
+                .props = (PropValue[]) {
+                    { "vmx-mbec", "on" },
+                    { /* end of list */ }
+                }
+            },
             { /* end of list */ }
         }
     },
@@ -4912,6 +4920,13 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                   { /* end of list */ }
               },
             },
+            { .version = 7,
+              .note = "with MBEC enabled",
+              .props = (PropValue[]) {
+                  { "vmx-mbec", "on" },
+                  { /* end of list */ }
+              },
+            },
             { /* end of list */ }
         }
     },
@@ -5206,6 +5221,14 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ }
                 },
             },
+            {
+                .version = 9,
+                .note = "with MBEC enabled",
+                .props = (PropValue[]) {
+                    { "vmx-mbec", "on" },
+                    { /* end of list */ }
+                }
+            },
             { /* end of list */ }
         }
     },
@@ -5392,6 +5415,14 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ },
                 }
             },
+            {
+                .version = 8,
+                .note = "with MBEC enabled",
+                .props = (PropValue[]) {
+                    { "vmx-mbec", "on" },
+                    { /* end of list */ },
+                }
+            },
             { /* end of list */ }
         }
     },
@@ -5582,6 +5613,14 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ },
                 }
             },
+            {
+                .version = 7,
+                .note = "with MBEC enabled",
+                .props = (PropValue[]) {
+                    { "vmx-mbec", "on" },
+                    { /* end of list */ },
+                }
+            },
             { /* end of list */ },
         },
     },
@@ -5776,6 +5815,18 @@ static const X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
         .xlevel = 0x80000008,
         .model_id = "Intel Xeon Processor (DiamondRapids)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                .note = "with MBEC enabled",
+                .props = (PropValue[]) {
+                    { "vmx-mbec", "on" },
+                    { /* end of list */ },
+                }
+            },
+            { /* end of list */ },
+        },
     },
     {
         .name = "SierraForest",
@@ -5947,6 +5998,14 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ },
                 }
             },
+            {
+                .version = 6,
+                .note = "with MBEC enabled",
+                .props = (PropValue[]) {
+                    { "vmx-mbec", "on" },
+                    { /* end of list */ },
+                }
+            },
             { /* end of list */ },
         },
     },
@@ -6103,6 +6162,14 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ },
                 }
             },
+            {
+                .version = 4,
+                .note = "with MBEC enabled",
+                .props = (PropValue[]) {
+                    { "vmx-mbec", "on" },
+                    { /* end of list */ },
+                }
+            },
             { /* end of list */ },
         },
     },
-- 
2.43.0


