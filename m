Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 593ADCCF2D6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIm8z-00021b-8e; Mon, 19 Oct 2026 08:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm8t-0001tj-P0
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:07:03 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm8s-0004Fy-0S
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:07:03 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8Oq051634764; Mon, 19 Oct 2026 05:06:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=qMHM6pEmEweBChs82szaxAk8IybJ8PAiFa8eJRnz4
 zo=; b=VIQGO/AZfLGAM6zr0nYXqnq/nE+nTUol6Sa3jIOUiWP95ara38PI2eSU8
 80xJgsu5laYdysWwRRx/7cmJFc+phskMdIeXG0O0x44vB6VpISBBP1xxrLabccuN
 7B7Opk86tXJWWQ8ms1yqDN7TFcbk5Xfg7A23dLol4P6DA8Tv5Lpl/OcUmOhbR4mX
 3KHemcL+1KFuoddIRW1+RO8TSdppyhFXVKU6xkc2YDumvSSOiOmNbn38aW5u4Z1u
 7ZeJdYWm0lSVvtnqYHOVZM1x/ATeiKcx5B02XFj5jiRPC+whfDWj5DYwe80Rkz+W
 kPch99BoMS+wISlEpZmLTAHMOQ9BA==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021089.outbound.protection.outlook.com [40.107.208.89])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hc8bckgcp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:06:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQX5tKrmyZ35Aj/cTBGgxgBA+t3Vgi6/WaR4qPBjoS98PbPI13QOztUAH0IMQDBru84WKxRBJH1UTZWnujSuiudpJ+G6P8mgx9xT1M+Sril/+UQOxtuLwM3ySB4+lX7vO2AXBl+6Sz91JO2vfXjhQK1R70vU5X804TtfkhSeg+CYlJSNguRRrLfKL+dHLjpkKmkk2BFYOYQrOC19pVYBa7j6Pw6Tgj+FHlZGXbSoIN78vLhZ6rwH+3lEmS5Qdf04VQHIKW9B3hkdow4Sp5Q0DYyEV91M3I2Ufv36QCJB4DULjDu6tl+s2+7+ZjHhNdzO67OINkXQME6sJtfgl/Rdvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMHM6pEmEweBChs82szaxAk8IybJ8PAiFa8eJRnz4zo=;
 b=Z3aPWhMw9dfGHR1O43CxT3fT01LIFRcjCDFUIOCliQCwnQnXfVDO4pblYYEDLjxA/KLXbmttTbaEfycIcj7YTFH7WtfjMn6CmKre78qz0V3SXZrZlMusDiz6rAZQlEO6UQqEMFSvTy1+dZiPo2K66Qy3YwMN+f8sGKVMj6AVpKwHWj1MVbOYrMauwpbW5IyO9DUzXY0ibYlYRyB1n26LEyd8cz2q66EDyV0o7pbPfWiXY088TiwWSqoPxzTu+VUvn5PFpdVlCm6AUAaCAzi32wdMCoOmyzpUNddLQgU6ktt40wWbb0YQXcgFEuL2iiGZGOVTJTew4FAW659COnexRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMHM6pEmEweBChs82szaxAk8IybJ8PAiFa8eJRnz4zo=;
 b=vvhLMCe9es2mOdoH2hPrdFv73B+AATJfTjrBqv5Sczt/Je7+3G7JwGZbCTWmpZsUi5c6BJXC9PcWrD5Qk4J8JsbijXHJFVRoBU2eD044sYHlx+biKzNrgZdB8MvFTYqS+akWKEfxCJA8mMYtrsdaa4nrirR1K0cGIPW3LNdmHs7b7Onw+No+9XOz95KjRHuft8XeIQ4bWG9CIHhO2qQuCeg5eXRFJW/oxZyOGqccDuCmeOE4Gn9dgTJtjtH+vb4qvfum8hRLqNNTnLREVxHlYO5nvIo8OfH6BZs/fbTg5tGSVwLCJL/ZL/3ZTUps/zPTvwqudNT90JckX2MmQBATnQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MWHPR02MB11820.namprd02.prod.outlook.com (2603:10b6:303:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 12:06:44 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 12:06:44 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v3 26/28] i8259.c: switch isa_pic from I8259State to
 I8259PICState
Date: Mon, 19 Oct 2026 13:04:58 +0100
Message-ID: <20261019120517.1448687-27-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MWHPR02MB11820:EE_
X-MS-Office365-Filtering-Correlation-Id: 77c01717-1a6d-4654-1665-08df2dd97196
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|261009223027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: A9lr+kUSOAJm8FYA2RIIXGY0Wa8YJzq8o6CvXiwmFijf83TR5FvrZQXM/CgmNNoV6Jd7O+/rxDwbrfNwMZWD0Wp/BRdeNR+VgeYEYgeBD7yH04hmU5ZeB+T3nOjjxFAId61OloaiIaoa2DP3FVhaXUc44M3cjkmU5WXTWn6nL4lYxxrVQUmI4frbr7LLyn8quqbljN0Md+HOj2Xwh6mBeXgzxvJf+A2/jjmC64SpaAtjVn+153mR9WKiu2JOENYH344sop3dvZQ1I44+K5tPXvD6c+eS2SqC+TFU692KNjz9wErxbo2eDZdoZzoVIOMxJG9LFEDetbmy0ri0Ov2AhbKAieBu8/Ai/LRWiQa0nFrxjn9CLI2KdyPAqxDr2F4NfAClZh1micH+vsF0E6DbfyzxL5O4mViqO5qYHHSvzVpOgTOYp9H44kjoeKn7+Pxt+wOSp42exZFDoawhNFoDvjJ0F5CuvXv5xGN/zT7OwIKRFsjwVKEA6mA6axDiJ1lRc/LyOHaeaFeZjM140vMo87DCrRjuMcnOgB0ihZHZWoUsWtX1iVdGbyZd5LcavZGwqmwhDkGo4xX/2EJ9mptLfB5z7lIbKwC7dQ/Dla0vR7buigE/9L+QIrFN9Gu1DABcVubQIF8VbSGea2MKiPuMwFN55l+iVv77+DSoGQL5JKM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KUvYU9gRj1MTedK/pIHkbsHZdOZlCkLek2g7xg+8ADmCgsD9OavBHcjv7kmP?=
 =?us-ascii?Q?WUwmC8/TSZD9/YoTGzm6+UBlhPZSsjXrzmv2r/1WD56PCfz2f7eIdGTMjKTO?=
 =?us-ascii?Q?UooGhmTAg42qN+bjpO2IL/fwOhQ6Of9TfCqzToFghjaVmdb0+VIcCHQ1TbtV?=
 =?us-ascii?Q?8JJWVrvYPXlrcWd+RizCLws7EACHxYy61SBp/g6bxIzIbthn9yO6EBRorXzN?=
 =?us-ascii?Q?f0z6yazlCFTbOBvpBGVq89Pzv5qTb6yUqXg0G1EIptrMdXnkR9cm7iX+UTDn?=
 =?us-ascii?Q?Fzxgnov1hK1U8yrKfG2s8UzJGFbqaPH6TrUUCCkaeXmF9MAUiHCQy2QQhDaW?=
 =?us-ascii?Q?bOCKYbLke+aLtfm62bm5pwLGqh99C5agJmB8zY27tHc2zmgl79/BqW7OKtDC?=
 =?us-ascii?Q?H8tAOADzBPL9UNypCPyg2V9s3yYSTCV+RTu60XP8GoNZr0//vchV5shRkHkP?=
 =?us-ascii?Q?r/774ooYIiqrAGRwDXmB5iVIZOmYMXktI/KzpAuFOdKAF4z4BzxYL/2gYw+S?=
 =?us-ascii?Q?XY9eUPxkXrVYyU8DGc6CPJCC9dp4afwD+/GrAm4dpl5dlvEsNDl+aKsMXcUw?=
 =?us-ascii?Q?lPCjRm2312FgRzKDr5OP+jAy8KxoC5lxhjOz+KC8StAZ8K1lkwj5vyYwyXWr?=
 =?us-ascii?Q?FXwb74FVz2aj0QHyqPy/V2uOMniEMtLBvQuiVJbMmFp5/15qMg6YT4bcnF6s?=
 =?us-ascii?Q?MdmVYwDOYTUif5wfYoB0q+mkQ+JeEFfFQJtKWhJEZHKFwFPLS711IjRTrS66?=
 =?us-ascii?Q?f0v7VAcRkcmssHgv25vKFTTK0u5qqKdNyfTpnUCxGJBE6zUIvvks8NI+ldZJ?=
 =?us-ascii?Q?fqkEElhG2gzXENEje+RKY3GFWfwO2xJTIBAmSxy6IITk+BnBL1f5e8XK91VV?=
 =?us-ascii?Q?YmGwLOR0eVo3mNvjOQXpzYSWZAB5zRq6bvWshuEkygBjXql5LtTjfL1O6z9f?=
 =?us-ascii?Q?G11A7qpasE4cwSkZaf5folqrMsPOyAQ8GUalYaF2/cyLrCML0mjsr+g5ZSMx?=
 =?us-ascii?Q?puhxhOO+J/P9yYF8MQV/ingzBqTz9oPN5UGAw3v1zsUIAlv365gtqWJ3SleM?=
 =?us-ascii?Q?Tzm/mHYifHgBvw1ABSuaoXnPVjbDxaWQZwxzBjPt30vc44IF5sYX3Csi0CPu?=
 =?us-ascii?Q?/ozffIZfawlKwwyeUe/duvYoZoKaN+zr5McErIG2J7qQKpOQaQs6+cWgnPIE?=
 =?us-ascii?Q?hR99+yVuhIiM7rSByDdtfoh39dLSMvporZcBiwpRYqakkAlDir/nqFqC4FHm?=
 =?us-ascii?Q?6S8yGbXzOqV6CO0kLshfm6nfHygDQSTzOrsa+s1gIyncOpeOmj2Pg9ip3L9G?=
 =?us-ascii?Q?nRnoDLzNZvdL0OX19ElrGu13duLvnwkVT28YPGaEGa7RePKHA24n5d03iRSE?=
 =?us-ascii?Q?0149GQDIj3JTf70y4nKE70t8cBTHUMscjyctTipyJp2E3MEm1XCzsSkWQbNO?=
 =?us-ascii?Q?4WJkQ+6O4qzwm+sE6IGt7JYf3bHIB6oy/nKiNhVZOH6pvWxnR+2Iy7CT8rN3?=
 =?us-ascii?Q?OYFd4PFY7iFDTYPIWqwZ9Iiz0A+dt716A40FU/TWDLEEF2cjCtykEqQXO6GZ?=
 =?us-ascii?Q?TXAbjLW6HGYYH5ZUdssYAeRAtIR5J6owXi93uUBfcGn5VeyRVCIGJWwjVvXc?=
 =?us-ascii?Q?GTmk3Kyum0zppiVSswf6b/BpBZiZW0zvSKaW5dz2kAu9e/3Vln1niB+sN3Ct?=
 =?us-ascii?Q?eXt0VmDucqoRef0q1xfxR+fXFoGIC7hMg90ohM6n+0SAf4Ft8Xc9I2QC+cV9?=
 =?us-ascii?Q?pZsp1w4jBz8AgDJHXecm/sL4+w45pWA=3D?=
X-Exchange-RoutingPolicyChecked: ThBfAIov6SwxEmtU1IWSxrzMULODTFryhRQnMP98CkI3LMBeNGe3KlVVR1fYNJeGa2V6eLb5ZXlhiy+oqnX+EoTEHfi7qHeiIMvtBgvM0tBmfiD9bveHkwi0rj5QD4t3pJksbgMZwAXwwRvbi7v9cmmw/QiErnaRW1i8Hw9U96AlP2KTDW7nWHeI5UhhtTDXuJHWuD13CXvP65LKZ7jiDDISEUC47qqaC04wCZajKzVaEGx36OhccHx4yyFxfh4F3OXonpgRydGqcWN9n3va73MoMulzpLAE7JnJ77R/rnoZ6QGdRC3ZZtxx6j4DdO8rIzK36MSRb1N48YRLR/W74w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c01717-1a6d-4654-1665-08df2dd97196
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 12:06:44.8856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzuW5BhXad1XnS1RzZQODsNwfH/cSal9X52UWHfF2hw2nw//UawicofFDfFFhJKFVW3J0LoWdjy3pefaT5+S6gZry4vgRWKrDYm7ynfOO6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB11820
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX9+k8ku3sSSu1
 iiuTjQPsT+besID2LFxiiYRDKNiMd+TYRSMw/+HlguwHoEA8Iw3+6tB0kQ9cQb0I2b1phQuGOyl
 oUVcZLpvncooMGHrwgtBYxlShTHUCS8=
X-Proofpoint-GUID: MpzQRNtRbaVkCRf23UvOOCMY5XI4Wmji
X-Authority-Analysis: v=2.4 cv=V8joQuni c=1 sm=1 tr=0 ts=6ad607d6 cx=c_pps
 a=rgmdkwC1tPsVJMj+r4rvFA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=Re7Oh-p8VE-n4k5LXTMA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: MpzQRNtRbaVkCRf23UvOOCMY5XI4Wmji
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX3wFJFBlK9PAg
 zyl8OKpxn2xhUJlFdP6hsWt7rF3afagVfu5lMCPJsxsVMgYg3is+M+7XJ+TqNGl0kfbF8Jh0xvI
 GdelwVqsD+GQivE/4xWtAn+nByfwu/6Fa8eqJs3B8X+/hK0HdFRc0nW3IhcnMuqZH4qzn1Vfvhx
 4aCikTEhWjMUY8nhw5VFGvmR4DEtcqpubfJnoOZ+UxHF5kltMRX9LPhYxiGmBLW46+7IJVKargL
 RaAzFy4EaDjJC8Mh1WbF7d8/BpdsAZf7uMBoBZ0xKkG38EMAdj8Yp5GDpbjbyyLXB6cuFBPIW5E
 JxcAmcJBMukPtZaWk7msAU1Zc8l0PQzZ5ghN+Sf7jpi9XdHrG8nK+Q6in+tMaxKMz9D1A+rfbTs
 GUy1y+vGRNiPRDvOunm1J9Ybilyot1drmJst+nSNN0av1JCJfkcIbo31sAz8Jag3IBFWdMG9ce4
 Lsej+lAMadCKw8WCHog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

The isa_pic variable exists to allow the output to be fetched or read (fetched
and acknowledged) from the x86 PIC. Since this can also contain a cascaded
interrupt from a slave i8259, switch isa_pic from I8259State to I8259PICState
and update both pic_get_output() and pic_read_irq() accordingly.

This has the advantage that a i8259-based PIC device contains its own internal
reference to both the primary and secondary i8259s, and therefore it becomes
possible to completely remove the slave_pic variable.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/intc/i8259.h |  8 ++++----
 hw/intc/i8259.c         | 34 +++++++++++++++-------------------
 2 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/include/hw/intc/i8259.h b/include/hw/intc/i8259.h
index d51a7fde32..4922f88d5b 100644
--- a/include/hw/intc/i8259.h
+++ b/include/hw/intc/i8259.h
@@ -5,9 +5,9 @@
 
 /* i8259.c */
 
-typedef struct I8259State I8259State;
+typedef struct I8259PICState I8259PICState;
 
-extern I8259State *isa_pic;
+extern I8259PICState *isa_pic;
 
 /*
  * i8259_init()
@@ -18,8 +18,8 @@ extern I8259State *isa_pic;
  */
 qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in);
 qemu_irq *kvm_i8259_init(ISABus *bus);
-int pic_get_output(I8259State *s);
-int pic_read_irq(I8259State *s);
+int pic_get_output(I8259PICState *s);
+int pic_read_irq(I8259PICState *s);
 bool i8259_pic_get_statistics(InterruptStatsProvider *obj,
                               uint64_t **irq_counts,
                               unsigned int *nb_irqs);
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index c3a3199b8e..b59e26cbc6 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -72,8 +72,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(I8259PICState, I8259_PIC)
 #ifdef DEBUG_IRQ_LATENCY
 static int64_t irq_time[16];
 #endif
-I8259State *isa_pic;
-static I8259CommonState *slave_pic;
+I8259PICState *isa_pic;
 
 /* return the highest priority found in mask (highest = smallest
    number). Return 8 if no irq */
@@ -190,34 +189,35 @@ static void i8259_intack(I8259CommonState *cs, int irq)
     i8259_update_irq(cs);
 }
 
-int pic_read_irq(I8259State *s)
+int pic_read_irq(I8259PICState *s)
 {
-    I8259CommonState *cs = I8259_COMMON(s);
+    I8259CommonState *pcs = I8259_COMMON(&s->i8259[0]);
+    I8259CommonState *scs = I8259_COMMON(&s->i8259[1]);
     int irq, intno;
 
-    irq = i8259_get_irq(cs);
+    irq = i8259_get_irq(pcs);
     if (irq >= 0) {
         int irq2;
 
         if (irq == 2) {
-            irq2 = i8259_get_irq(slave_pic);
+            irq2 = i8259_get_irq(scs);
             if (irq2 >= 0) {
-                i8259_intack(slave_pic, irq2);
+                i8259_intack(scs, irq2);
             } else {
                 /* spurious IRQ on slave controller */
                 irq2 = 7;
             }
-            intno = slave_pic->irq_base + irq2;
-            i8259_intack(cs, irq);
+            intno = scs->irq_base + irq2;
+            i8259_intack(pcs, irq);
             irq = irq2 + 8;
         } else {
-            intno = cs->irq_base + irq;
-            i8259_intack(cs, irq);
+            intno = pcs->irq_base + irq;
+            i8259_intack(pcs, irq);
         }
     } else {
         /* spurious IRQ on host controller */
         irq = 7;
-        intno = cs->irq_base + irq;
+        intno = pcs->irq_base + irq;
     }
 
 #ifdef DEBUG_IRQ_LATENCY
@@ -369,9 +369,9 @@ static uint64_t i8259_base_ioport_read(void *opaque, hwaddr addr,
     return ret;
 }
 
-int pic_get_output(I8259State *s)
+int pic_get_output(I8259PICState *s)
 {
-    I8259CommonState *cs = I8259_COMMON(s);
+    I8259CommonState *cs = I8259_COMMON(&s->i8259[0]);
 
     return (i8259_get_irq(cs) >= 0);
 }
@@ -428,7 +428,6 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
 {
     qemu_irq *irq_set;
     DeviceState *dev;
-    Object *pic_obj;
     int i;
 
     irq_set = g_new0(qemu_irq, ISA_NUM_IRQS);
@@ -442,10 +441,7 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
         irq_set[i] = qdev_get_gpio_in(dev, i);
     }
 
-    pic_obj = object_resolve_path_component(OBJECT(dev), "primary");
-    isa_pic = I8259(pic_obj);
-    pic_obj = object_resolve_path_component(OBJECT(dev), "secondary");
-    slave_pic = I8259_COMMON(pic_obj);
+    isa_pic = I8259_PIC(dev);
 
     return irq_set;
 }
-- 
2.43.0


