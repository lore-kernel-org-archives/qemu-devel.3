Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C096FC4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkj0N-0006JQ-KY; Fri, 17 Jul 2026 09:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wkj0M-0006J9-5I; Fri, 17 Jul 2026 09:53:30 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wkj0K-0002XM-2k; Fri, 17 Jul 2026 09:53:29 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HCInCx3906957; Fri, 17 Jul 2026 06:53:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=T7DdbnUdyxBXiM+z/+aU5NB89NkrrA5jK8AAQ8jjL
 PU=; b=enKtY5/zsFvOeAoJmCdYubrVMn+JeySWlEGrqJo3acsSZSBsx7x+UZ7zB
 j4zfdhaXOIGUFaNd/ahJUcwZwzEjv9L/7KFmGaJXZvx6wg4f8uN0ZgPwA3Cooyec
 Zo0o8a27XN+Fl03vyejn0i1WzsPWNR7EKR0JewvNnYZRfDPcA7jqVkhI1Zi/RMLA
 sSyNSf7DajIlDa+qYtZMdsHtJkrIGu8za0it7Gp3WaKm6+IqMU4SiL/DWkwX7VoV
 drnd9bBxLNe5cOfdfF+wyc4jGx/oCXO1scv/UzrkhbaRK37bATp+nXvsvJSfw74d
 kWzwD67vGRWxxaRnLttcx9PNP6iNg==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023141.outbound.protection.outlook.com
 [40.107.201.141])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4fedvwdqa9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 06:53:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/alV/+y/BrPuTgT0XM/YPP2Y5//r7gKTZQcz5aQMfyJWWV/xaqqjuXTjIDY+R6Y7p5HOZf/yq35g1wr5iD2MxEkpXOj93nL4vyZb9R63SEKrS0wphb+GOPltkhjaU5U3AtFtxeLG7niWwCJuqpPd21Dq4vh/UbCr7pxMZjCbtMX87oEzJQGg7mZ5jP9F7cXcHPud1xuWUc8dgfXzt7QMvdwnDBfh+3Okv8B2I+nIhgsk2wmCMjVvLOuRtah6qWuq2tSpe4nnm0a0M9KRPdq7ctwT0c2HbLCXpQdH+UnDxzp1wmoGdjvLkb2jAUShpixxh/uEiUCp4q3NEVbUcGPhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7DdbnUdyxBXiM+z/+aU5NB89NkrrA5jK8AAQ8jjLPU=;
 b=DtNeq3IEQ1KG7NkvCnzlInYGR4q9Uqfg5dtA7YZtlFh90AOxWuMXYCFdR3+fIvkVlfK8VAtJ0QM62oDVOzkrRbm3v1GVKE32QHJ0rjIrxQlW07w65T1iPBsJMN/nETJ5wQfTN+M1FcgNhoIh81q8xkSpfUPIIAYqlD3Cjn1D7L3l4w/PpUzYwuid7oM8o1LIDJKvKPZyaQAoqY7q8Xyn1h2i1T5R3olc4DMwraYglul4W574aHdftAE89Oin9LRhSpvV1WB45rD7tMOV2hnLelf5Y0BLKh7ilwNTgnbjrX08MMuE0bDEXyH6UoYAS7Ym2rmm2djNNvxinZXMKrcKgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7DdbnUdyxBXiM+z/+aU5NB89NkrrA5jK8AAQ8jjLPU=;
 b=ndkNF8AP4FQUSLHMzTL4k2XR2R9PUKGC8LgDGncz3LwnYeXTegREs0PxPxCj05SwBncqE0cU9f6lPYrM65y9yqCWSF6+PPEW/TMAj3nz+lYeksKHfcB+XfsP+Hz0t44flgbaCt/zDdYkzV0sTl5iPmgn+8LgiU4USHrVC2UOmIsV55clKhwlUQq+B58RfphzLVl2xYMioPgTxfaB18Dup5U72DvlwFFjxXZ6mTf1XoXnwb/LvGWax6A60vvmcFEU/xjn8D2HBkbWHDx5QsB5IKs+61WBi1IG6xwnIBUWyQes4KJe22S9Iu8JrhSPNg8AoR40aH/z7Td5kzFsxbCzTw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO1PR02MB8540.namprd02.prod.outlook.com (2603:10b6:303:15b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Fri, 17 Jul
 2026 13:53:19 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:53:19 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 pbonzini@redhat.com, berrange@redhat.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 5/6] qom/object.h: add missing documentation for
 object_class_* property functions
Date: Fri, 17 Jul 2026 14:51:45 +0100
Message-ID: <20260717135254.508701-6-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717135254.508701-1-mark.caveayland@nutanix.com>
References: <20260717135254.508701-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:930:11::13) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO1PR02MB8540:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ca6af32-746d-4b44-64f9-08dee40ac20a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|56012099006|10067099003|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info: j0KJw+w4mmv3eCbalYqo3uxh84NnT3TlESCpyz+lKM8N5DeyWd6O7stPZoNALNd5A68h0xZN50IMceHFR+b9sW5NLGva4caTwv5LSdnmvd61mf484m+QxNMVOgIFsSSIdTk71ioGEb9kZICHNAGLV4pieCOk3DOxMCAwzMVSkxQ0N/zU2T0C2gvBnUY6TZsCqoyD7H0ImtlUXlRmywzPv1Bu6el+Ci8lHI70LtYVo/+HhILI2kBnAof/w4kaX17J2G7kzawSmaWD9In/V4F9jmgjNbMmUFjy2aYekDp8CbmNckXBl1C2QQC+KDZB1xLqBGJfXKZUC7rTjuDQvSrIqRxgUKD49d3JwwPD/vOohpEBHBqvy4cKBXPJL3uSJPO3rs+jJ/t8D9zL9s4H6BnsUc+q3FqJDFqXxvLm3Y3j84x/kM39KoTNP6v02CZP8w9FuJm6YQ+sRJzoxY7EbjBgTbuZ5BO8Ee2GFVB/fyCyBLsO/Kpw5nXTDf/TcA+5KL3Hqh65ZuNzKoMtlb7bQFMITL0LgUd3iQxS0fMz9r1fkl2H4jaBLsunGreXwsiiT9vmg3lGCfOh+d/gDHokwo4vR7y5K0+XC3JIJqG5McEJj5EmG8mu9m/JMrexsI/jde0YBnbozVkkRqhEULp3EkZmFhkiuRsIGJjhFmz5C00+tQ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099006)(10067099003)(5023799004)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?11o9tnEPYXWFlsR55WYPf8o23SkOIVGVOET90bCCDXzdXVD0Er1hIIoU5Ls5?=
 =?us-ascii?Q?uJHyDyxLjw4sqlgc8CCXBg8QPWHXHQgKQXQefLLI9jckserdzHJOKHxrdhQS?=
 =?us-ascii?Q?Yr3/ai8clyT2xj02m47DGhF1VaiArFYTvFC3l2M5Eef9DELrft5jbs6hHq+u?=
 =?us-ascii?Q?q0ZyACXFZurdNERv6u83BIEbLgY/NuB3YghnpYsUwu8OWigzVMPoowOuqaeN?=
 =?us-ascii?Q?LiqeGAnpjzvpoPEbZhzHxpyIKlQIoDOEBdoFuumgNoDCD75exNgszQ5UQ9KE?=
 =?us-ascii?Q?R8cyejw2pRuczpCcXnl3SpFuGXJ3xP6ZkBzYLdumN5D0O1uW6VTgzkvU2LYX?=
 =?us-ascii?Q?s7KuevEI/x6dFxZ5LKvdn3gVGwZeBDbsRtA4NTvj4A6uQ7g0HpxDrVP8UbTt?=
 =?us-ascii?Q?W+Z6ynyLD8w4StHZHe5qFRp1sJtddVwDG2m/D0/Vg7v5RuxBuOQhkAnX2x5K?=
 =?us-ascii?Q?AfmlsNUupqao5iLjv1KKcBCJanPg74k92jhus7XznJP6u1pKhHktC7qedRLE?=
 =?us-ascii?Q?S7rz4AJg9aqXBbo8TlqGs8NfhUs5jQe2hy2JAswVx5p+FZajVDSkr4k3JA/E?=
 =?us-ascii?Q?M8M7cG6RAXf8DnmOW8UamY6NwoP1v84CGiJnPz1nmAl2sC2ZO+KuWgAUFvod?=
 =?us-ascii?Q?4d808Ubbcqv6G7WlXJkWveoIRrUgg8cY2tZh773dUdq6pWDnKY/lDTX3nVS6?=
 =?us-ascii?Q?FMLcQkyCduAbmldXrD2ZqOwHWuqnB9+d4VuemwdAv+GeHRYscp2v2klo6Zs2?=
 =?us-ascii?Q?wzfaKffQL/6Avv5EFFdmWeDGaWv6i9tDjFNkHjzkp/LvgiIoUetfDXDmeRbh?=
 =?us-ascii?Q?IZaXStZlc6NFTmo1y+PAKNx0egh/BHxjAgnpd8fStPxpGplb2CRvsl5czdaE?=
 =?us-ascii?Q?xOEnNc/8OmpE+TP9DV1gsW7zY7oYAnot5DajIfcZKONH6xQkGOhYuOqPFOlq?=
 =?us-ascii?Q?5UdMSeO4gImWlmFCnvySyR41DnDWIm3l3FJFCfbFFzPtNO8MWgoP0TWpuBxL?=
 =?us-ascii?Q?sqjDQZ2nPfda6z8ub0PEDlzXbT1L28Tm9UTy9aDM3872ARIXwqKdEbTlgrOd?=
 =?us-ascii?Q?v+sYPSWGitQe+rEUNNRAyvS9DMKjgb5BQCqQe957KYXGQz6PHwJqeTcAp9+m?=
 =?us-ascii?Q?M2fiAtOYdmd0Cg2DM44hLwOqVKViN9lMtBxI6UBgS3rmbVCWk25nWrTKut6U?=
 =?us-ascii?Q?XxKMzNwK9+/XC8MwfwofIoJyPiZiLRJnLr0c/6PEyhWbEMoSLfIZprJO/sCR?=
 =?us-ascii?Q?lwmthurVxfdAqqm97k2YPDZQbHmpUbKmr8NdnKJUiyYySMRwS+1SHYgq+56d?=
 =?us-ascii?Q?fyFTl7Qx/ydgpIwygTx5+Xy4g7j5Y8yDz52hXJPPtTcxu5aGrE6kK+G6lmpS?=
 =?us-ascii?Q?n8HOB30r653ydJ/a2MjSViNDLh0zNXDzLwdZSZKgbD90osC7Uo3pSKKWnIRM?=
 =?us-ascii?Q?NPin2WkP5bVhFJNbm2t/HyMxkuE5LJK22QE27gGKJHcfNEQBBa+NcsFhXinh?=
 =?us-ascii?Q?sX+0gSTs3QaWE/nXpNd0YJUtWvFV3FK467guWugOjykLeXJ9vumVCPRIuSU3?=
 =?us-ascii?Q?rCgBo6SNoF/RY8nhB7ZKXsEuCiMAcYrEVIMXDsxyawCoWzmP9hBEL/IsBxhM?=
 =?us-ascii?Q?m4xt3rjefnBTmdJAlxEeIl1nfTPxbfxPwqJjG7+AbwDY1mNAxB27VZ/WfDmo?=
 =?us-ascii?Q?qDy0TN+SuD6O3bt7cHw9821TQOQ9IB36aQCC4XrpRZxPpMLHUBn/Nqw/9Sg2?=
 =?us-ascii?Q?zlOQ9BhqnyQhmTWSvIxcVr2PQ4TTK3k=3D?=
X-Exchange-RoutingPolicyChecked: ApdhEFyt3SnY0+JvdhLK3bv3qGYyu1Sr6/KMX2Gq5uBwhJX3LKqTfL6dwvxFJDH89yJW1hbaG0gqF/y/4SIWjOe6a2d2O/MqAj5TG8Kt8rrU6CItUFbuMR8OqefNJ1mgrbd9RqtPaLGqr1wNqr2Z8kmUu5vlp41mzR1oMLVmOdZC5/tTo3raBMXUE/Z07SpSB0c+A3OHfIbUXNm4u8Ojx5wgTxoOhgZCljj5lmZUecpdXaP2wzRrecsxnVgCvNIIr/65TNVCCtQZ3vWmlTwl+M102DBCCvnciNbLc9jUTXFkOxGJyUPy0/e34rCmq2SGFwgaCDaDEK3WOO9nGBfFOQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca6af32-746d-4b44-64f9-08dee40ac20a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:53:19.2542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VGKGPKSGZMIf9LqV6zPEGMLICAL+kiGv8ViWbjgY0bgzhAGQN3EK6IQtd8JqPYNivWXB2VLj18leQCSTOsZIDofCNV6nUt0zaLj5jMLvXq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8540
X-Proofpoint-GUID: VdGygJqNSOPzpZP47gB7nVXjQ2ymsZUL
X-Authority-Analysis: v=2.4 cv=ZOTnX37b c=1 sm=1 tr=0 ts=6a5a33d1 cx=c_pps
 a=Fw0ky2jKRwgN+c0iFCliFA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=lESd7L1ileNoS6jXIgYA:9 a=B2H1HY6s2cwHLFEM:21
X-Proofpoint-ORIG-GUID: VdGygJqNSOPzpZP47gB7nVXjQ2ymsZUL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE0MSBTYWx0ZWRfX28g38t1Lkj9p
 PYqez8jq7UWK8q1CfMq84NVbe6K4D5HJFLz40DRm6cKaDjZ6BSVfeE4qfiEhoLhMsOy0UqoWtIL
 AXOqh8WZxBP4ERP2FRTkpG9a969wDC9kmLJ1m67/HSiqUbEM+hS5XdtJw6M/WTwuojS7+DDxKKh
 qNz+qLBiJRtVmkc3utogSXpRlp+kfhze4TeTd0xE7XaF8K+KUtTmDBy4c0No5hqF9Gc15G8HJHC
 SJKjxherrfclgBU2ekuBcfSOJvtiU6gTMg6L8FU7VU3vhJqO1sHQ8fG1NXi8Zm4jTPLLJ6257PB
 NxSpHoGfXUw6BzibxMrRFQ+gTYLSaOEtScYTxYK93H/SKB5VuniGL77yHWy2JnCp7hNywdnXaDk
 o8g6graQIIHU/t3H6bDklR+GUtTgCLUWlbs3QVhLsmu5DfL+91/JPrANEMt+AbJC6Y33xSQoV68
 T/J/EOwIAAic0A6qTEg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE0MSBTYWx0ZWRfXy4Sd1cJZJ2B0
 hDp63vGHvpBLOTAX+FU+uuqmc57j/64oFsFMtEZNw1cmz9FfguOqG3pbaIQ1goJR6mVtGYjNZKN
 FKAV+TCSQWzVSxZdgsWqX/VK7aMehII=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

This is so that the object_class_* property functions appear in the generated
QOM documentation at devel/qom-api.html.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/qom/object.h | 136 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 4e7fe2af7c..272c41cac7 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1818,6 +1818,33 @@ ObjectProperty *object_property_add_link(Object *obj, const char *name,
                                             Object *val, Error **errp),
                               ObjectPropertyLinkFlags flags);
 
+/**
+ * object_class_property_add_link:
+ * @oc: the object class to add a property to
+ * @name: the name of the property
+ * @type: the qobj type of the link
+ * @offset: the offset from the object instance where the link object reference
+ *   is stored
+ * @check: callback to veto setting or NULL if the property is read-only
+ * @flags: additional options for the link
+ *
+ * Links establish relationships between objects.  Links are unidirectional
+ * although two links can be combined to form a bidirectional relationship
+ * between objects.
+ *
+ * Links form the graph in the object model.
+ *
+ * The @check() callback is invoked when object_property_set_link() is called
+ * and can raise an error to prevent the link being set. If @check is NULL, the
+ * property is read-only and cannot be set. Care must be taken to handle NULL
+ * values for @val.
+ *
+ * If the @flags %OBJ_PROP_LINK_STRONG bit is set, the reference count of the
+ * linked object is incremented when the property is set, and decremented again
+ * when the property is modified.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
 ObjectProperty *object_class_property_add_link(ObjectClass *oc,
                               const char *name,
                               const char *type, ptrdiff_t offset,
@@ -1859,6 +1886,19 @@ ObjectProperty *object_property_add_str(Object *obj, const char *name,
                              char *(*get)(Object *, Error **),
                              void (*set)(Object *, const char *, Error **));
 
+/**
+ * object_class_property_add_str:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @get: the getter or NULL if the property is write-only.  This function must
+ *   return a string to be freed by g_free().
+ * @set: the setter or NULL if the property is read-only
+ *
+ * Add a string property using getters/setters.  This function will add a
+ * property of type 'string'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
 ObjectProperty *object_class_property_add_str(ObjectClass *klass,
                                    const char *name,
                                    char *(*get)(Object *, Error **),
@@ -1881,6 +1921,18 @@ ObjectProperty *object_property_add_bool(Object *obj, const char *name,
                               bool (*get)(Object *, Error **),
                               void (*set)(Object *, bool, Error **));
 
+/**
+ * object_class_property_add_bool:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @get: the getter or NULL if the property is write-only.
+ * @set: the setter or NULL if the property is read-only
+ *
+ * Add a bool property using getters/setters.  This function will add a
+ * property of type 'bool'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
 ObjectProperty *object_class_property_add_bool(ObjectClass *klass,
                                     const char *name,
                                     bool (*get)(Object *, Error **),
@@ -1906,6 +1958,20 @@ ObjectProperty *object_property_add_enum(Object *obj, const char *name,
                               int (*get)(Object *, Error **),
                               void (*set)(Object *, int, Error **));
 
+/**
+ * object_class_property_add_enum:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @typename: the name of the enum data type
+ * @lookup: enum value namelookup table
+ * @get: the getter or %NULL if the property is write-only.
+ * @set: the setter or %NULL if the property is read-only
+ *
+ * Add an enum property using getters/setters.  This function will add a
+ * property of type '@typename'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
 ObjectProperty *object_class_property_add_enum(ObjectClass *klass,
                                     const char *name,
                                     const char *typename,
@@ -1927,6 +1993,17 @@ ObjectProperty *object_class_property_add_enum(ObjectClass *klass,
 ObjectProperty *object_property_add_tm(Object *obj, const char *name,
                             void (*get)(Object *, struct tm *, Error **));
 
+/**
+ * object_class_property_add_tm:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @get: the getter or NULL if the property is write-only.
+ *
+ * Add a read-only struct tm valued property using a getter function.
+ * This function will add a property of type 'struct tm'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
 ObjectProperty *object_class_property_add_tm(ObjectClass *klass,
                             const char *name,
                             void (*get)(Object *, struct tm *, Error **));
@@ -1956,6 +2033,18 @@ ObjectProperty *object_property_add_uint8_ptr(Object *obj, const char *name,
                                               const uint8_t *v,
                                               ObjectPropertyFlags flags);
 
+/**
+ * object_class_property_add_uint8_ptr:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @v: pointer to value
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an integer property in memory.  This function will add a
+ * property of type 'uint8'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
 ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
                                          const char *name,
                                          const uint8_t *v,
@@ -1977,6 +2066,18 @@ ObjectProperty *object_property_add_uint16_ptr(Object *obj, const char *name,
                                     const uint16_t *v,
                                     ObjectPropertyFlags flags);
 
+/**
+ * object_class_property_add_uint16_ptr:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @v: pointer to value
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an integer property in memory.  This function will add a
+ * property of type 'uint16'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
 ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
                                           const char *name,
                                           const uint16_t *v,
@@ -1998,6 +2099,18 @@ ObjectProperty *object_property_add_uint32_ptr(Object *obj, const char *name,
                                     const uint32_t *v,
                                     ObjectPropertyFlags flags);
 
+/**
+ * object_class_property_add_uint32_ptr:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @v: pointer to value
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an integer property in memory.  This function will add a
+ * property of type 'uint32'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
 ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
                                           const char *name,
                                           const uint32_t *v,
@@ -2019,6 +2132,18 @@ ObjectProperty *object_property_add_uint64_ptr(Object *obj, const char *name,
                                     const uint64_t *v,
                                     ObjectPropertyFlags flags);
 
+/**
+ * object_class_property_add_uint64_ptr:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @v: pointer to value
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an integer property in memory.  This function will add a
+ * property of type 'uint64'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
 ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
                                           const char *name,
                                           const uint64_t *v,
@@ -2075,6 +2200,17 @@ ObjectProperty *object_property_add_const_link(Object *obj, const char *name,
  */
 void object_property_set_description(Object *obj, const char *name,
                                      const char *description);
+
+/**
+ * object_class_property_set_description:
+ * @klass: the object class owning the property
+ * @name: the name of the property
+ * @description: the description of the property on the object
+ *
+ * Set an object property's description.
+ *
+ * Returns: %true on success, %false on failure.
+ */
 void object_class_property_set_description(ObjectClass *klass, const char *name,
                                            const char *description);
 
-- 
2.43.0


