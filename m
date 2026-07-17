Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C675DC4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:54:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkj0d-0006OX-2H; Fri, 17 Jul 2026 09:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wkj0c-0006OK-Bi; Fri, 17 Jul 2026 09:53:46 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wkj0a-0002YP-BO; Fri, 17 Jul 2026 09:53:46 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HCHkL23858911; Fri, 17 Jul 2026 06:53:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=84dMBHtO4WDraU+B8fy1Fg6mijzf9K7ohwzne3j0e
 zY=; b=dEdMKgaxEJF/zdjplS7szzlQmxSAhkafmvptGr1HFXhz93SHBqwYyfWXW
 9tjq5nLjQmIYiY+zGt6M7/bFZI/GnoQDS3mWc89Ealg1A6eO6trrLdS04wuEd+rN
 fhbh3Aseh0f27VXHb7SN29uI2pUP6CLrZuTJD0+Gli95TBE4jBtTsI2SRW3AqPQO
 5YkUVK73Df/L4fBQw6qnrkn3HV503OsPTHOcPU7g4YlFgbwwq+uosPhDexrwjMdc
 GWH564KQALTS8aizAJdrAHHq+pxJvWEMPRhLOQrU4ddjs/sAaw6D+Wjscf50DPJe
 40D28KLR0+Jg5uZoPavM/XTod/toA==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11022082.outbound.protection.outlook.com [40.107.209.82])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ff7ks1rkb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 06:53:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLtyKbYL2WpEqfacB+HmpJiVXt9fpdMktyZFQVd5nAr9CsDMlkLghhPFfgwmD8T7FftOMITEhtwtA96/3sOxNOsHtZOzD5RRNcDrRlI0jWRdJkepoCIVLTV/Z2Vu73hVGGLK/muAcRRlRTSuGtX1TiQTDpi2W1o0GVm1ErZFvoH2vY127n+s9c2cc9fYDOg8ND3FlS9f1/E7R4mAsiG/tQv11y5FrW2cujc6kSvu6SwWgJELtUYaVp6oUzfCSImVoJcwd85lMojBrk5hVJ3v7uR2uGD5YJ1AJYbfmYwO5AkiFIWIfXcIW4oVWhvH5CLbb5eHMYLl1qhKUi6FKpZlaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84dMBHtO4WDraU+B8fy1Fg6mijzf9K7ohwzne3j0ezY=;
 b=omSaDhFan9+Khr1uzApR2MwBaiySWnTjoRxErpQz7m8KNubR+nwqCSNW0NwfYtbxvKltQ5R2pd821n/OkRmM6FzyITNIe087F3KmcrWvwpPMy8Dq8zIKE4Vpsn/iY3FNBGCISzq11JH+jMqmlHt02nTYia00An/hcYzTtX88ujGYeXXW/Je5X9aqSFC/KtK0jM0iDfMEWtgWfVrlkSrDWUasODtkr4rgRXM7qjqanxR/hi6k3ARGrviLeiGLa2FkYhMZrsDw3PGKqETPoh8yugLMr22MW36u5FvSb7EibE9AR5FHGXF4blppguiSO3FSMEB2DZMrlAbOkZPX57AiPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84dMBHtO4WDraU+B8fy1Fg6mijzf9K7ohwzne3j0ezY=;
 b=tW0dtIkFdHx49VZV2OuuAQrstcd6e6xiPbMPWdJrKv4pE2viBahj5bPXANx5RSA8PmaDyWfxSKQQPAy6i3RunjM7HmU7Lzx78PBmA+fxXkxV9QZKZCC1LeQFa/MEiaWGgzpGO5EUp05rvshmw658LtrK2er9l2vdESj2zTEJma0hb4FDJbKXHuDKrJqOpUsrdh3aXzdq0gZm5yMxgvuULnOxjaCFNW2G1mkHS3A4VBhl88gF/bhTyUrwvQcTkmQK6lDSu61mq5a2oMvRUl3liUGJsVeVuZM7Rmqt6mW7QqxbOtfDiX/jInF65SyQfq/amFE2nAPgeSvA7FXLgGqVAw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO1PR02MB8540.namprd02.prod.outlook.com (2603:10b6:303:15b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Fri, 17 Jul
 2026 13:53:22 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:53:22 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 pbonzini@redhat.com, berrange@redhat.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 6/6] qom/object.c: rename object_class_property_uint*_ptr()
 to object_class_static_property_uint*_ptr()
Date: Fri, 17 Jul 2026 14:51:46 +0100
Message-ID: <20260717135254.508701-7-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717135254.508701-1-mark.caveayland@nutanix.com>
References: <20260717135254.508701-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYZPR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:930:a1::10) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO1PR02MB8540:EE_
X-MS-Office365-Filtering-Correlation-Id: ad055042-51c0-4f20-48f5-08dee40ac435
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: tc6kuB5DJQZU4hGIfi0O5HIb1FiOvPuLfCiCr0lO3nrO8PnC3S2k0B+GnH5Vp0f3+OPpmIwBuQTNo/j2xbSwCVWbcNvHiGGoRjTBrQnpNmfnOpL1eqbtHOdtCmpiCOAXd4YL1lW/vJuHLPSgRt/cbJ/PEi8PCg+VPHcRftykc4l8geG5XzWuXmddHR5cWFVIEJG4kvDTkceSV8H9Yaa2Nyu3iKty0CP3XPVCIBKVLl+KzEY+7vdNM1vbYKUnOdKaOddmP1DrymZX2JLHb94gFLNbgjtpiyNTu+F0ZOi1PcTZBlac+yMgGNThsmS+Ok0L/uhlW28y9VOrJVZ5lnb+NP57VfWVzdt9MOG0YR3T1hnkchkwVaTyr1KAd19YPBpeBbWBHgwGr9nx0K/6fCv5QbxOxdhnN14C6xo9Yx9anjfS8R8HbGqGziauxSES41NpgPdWI8oiSqvPtvxHe7Xt4NNoIv95axG/3NxRJluu23f6G8OmeqPfHma1Bq8VXgWgzmmgwaJbzXD8PTFLAgV025znUq0gQMv8OA0fljLSzJ62tT/MxNawQ9vE0yO+RLCq8q/pRZ+yDrqIywncnR7oNWPO0dQ3pVE8vbp6T3n4AMdJMiwlKkiEcWSA5ODzPBJ51hjIlcO49Ovy88LbmFtva4en/uLMeqQa20HX4qaROk8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7SO0vlKFY/SSw3WqdPTf2ZZGqaU9j0BTknqqdhTyFxQR2BCqkH7KL/pP016c?=
 =?us-ascii?Q?VpCFWGSnau43NFlTu0N3eQ67ajtZ+k1M0uCBZsFxRoGyQO17z5eDm+oXXsL9?=
 =?us-ascii?Q?A5eKGelHXCKEYf5sQyA3PClEIfP2rc9wb7EFGxZMqrLkPgdsfimFw/iM5ebM?=
 =?us-ascii?Q?hcW+aqVIpdIIvrRhwxZ1H1TLR0nj6hfkxS/UIBeWRhk6/KIv0hTcSMbYtX3i?=
 =?us-ascii?Q?1qrAi9NZ0Lg4EJ2sORTlCL/RCW+le919PNtXgYTZTnXSNenDpCvp2nVHNgz9?=
 =?us-ascii?Q?JRb125lQeVfrFTArt50G5YIf8rJUCDXQs4M6Td8FclmCTC69dbIO0DzGkz0C?=
 =?us-ascii?Q?IS93yRZNnlsxwKSKLfp1+isheDMQo6rI496NchTBVhdZOBxPPcybogAdh5Ps?=
 =?us-ascii?Q?WJ+JdM8lErdbhof/5uijfsR/pbJz5dLOuGWNeaj+DvWMNs1kRP5Uiqu2WAk2?=
 =?us-ascii?Q?Cdzphzyfo7UKjOKEc9+Ucx/oMhTSlW5Yvm7FAkEi2oXfU4+7noLAydZ4HDMN?=
 =?us-ascii?Q?iNu6QQQhTbCRLIAAhaT0nrmDbv3QaUh0zElbpegysnBSL+Oox1LAImGwalHp?=
 =?us-ascii?Q?bjjr9fXRm/aIcYSMaiThQK+HByZ1EsZsa4UGudy7XnXCFB3xt3qMdpDB078l?=
 =?us-ascii?Q?FJzg3wJDE0JmYwOny+FKZtdhtV+BJkDb2Ad1q0MmHiQras0OqekjH2v/Chp3?=
 =?us-ascii?Q?g+GjmIjAD0C8ylG612Ks7IJ1UiOYejfpYdisXtOLNIcoKNRz8Dizkpac0Wjs?=
 =?us-ascii?Q?qmf2J5pjEWAnftl0Ae5viNXAzwISLi4+GHtDrtYijZNDVw0vx+zLp+1ra4FC?=
 =?us-ascii?Q?b5JE666OGGY8QdDRw9OlQIMZS/8vXnI+/2lRWfTcdgvzqeYb8ippFti7ZWo7?=
 =?us-ascii?Q?kic0kIqPN/M/0cWVrHKIsRPPvyfCYOCa+GAQteciddL/89+NqSZ9Y0otvXZB?=
 =?us-ascii?Q?8Xpmb6wF7K6PEpzQU/y9rRliCtAurZvOXZmp0awnuaurE4czB9b3sEdnI455?=
 =?us-ascii?Q?3V8sZCxvuX8FdOA4S2RM1DgojNhFTq699mm22qHnE2HJr6qIgZvkc1pRK2I0?=
 =?us-ascii?Q?OeBNQVLzGgs63GV5UdAanmmdUVEaZoCGPDSMzorFNSDyeQ2XT4B8Um6G/FHZ?=
 =?us-ascii?Q?Z8u3e48XpcYiKvGnOMNT4jKIFcGoyk8lmBBk3Ntu65Knwmm7jQi4WBp7RfH0?=
 =?us-ascii?Q?vs872noKHzhzHWwYkVmVOddFmnTeETk4N5QHJJ6A59qszTT6Sj7g1UJtdSvP?=
 =?us-ascii?Q?l7Z5omyT4ZbVB/K9FMncucz/vPeTz6KYrU9iIOuQ5L9khXaYB7gLe/WuZmAY?=
 =?us-ascii?Q?c3PfrqqNWuyO+ymDp3CgbUQSHQ5KQZHtkbyy9y1oO5Lz1zXszmEqjpui12cX?=
 =?us-ascii?Q?+UlbD1J2oU3yAsEN8z6uetf9t4MKh5If6ExOSqo8u0YHbsdbCQusUkEGZcCQ?=
 =?us-ascii?Q?RqdQ0igi+wZ6cDfNcilDz8XlKRq/8JsNsEsCvTvywxgeMbigH2eD8dR3xh5r?=
 =?us-ascii?Q?9h0dfwj9LBg7bdWzSLuvoA2Bcx0ROmqRoYrjsr5KW+St8KYMewxhvN0vMAp/?=
 =?us-ascii?Q?Qwr4Rp/Z9s8S+Z7s9m87I+mlpSvQ2uPLPH4p/7AGC1mx5TvfjDo++cNGhdRM?=
 =?us-ascii?Q?vgdWItQ0tsFGugx0JYPa6NzxJejTCyI9HZpOOWDfGpPcVpMut8h3ZTEr/8HB?=
 =?us-ascii?Q?wyCQCz8QUgA7/EIyUBVX6gLiiZvk9Wh4WCvNfTWVuwwOTsIPly3KyWoCYcQV?=
 =?us-ascii?Q?ep4j14dTNkAQWo1pIupNsAGK2ZV+6i0=3D?=
X-Exchange-RoutingPolicyChecked: WmsPWTLLElGgb3oD70RYy+9T2+9/USj1d3SghiyZAGaB93/SLhbMiYUeZsIGdB6kzYY+c731bPvz0DFJDGfVzVPvCk1bIWC962BXNwmRRfJ8QnOJsMoKyhNzM24VA8bMpWdmWlzieuQMzKE/FeOvcUcR7+4Kt1tljvo1Re7w2Xg4RZ8pQk2e8+A7VHE7JjXN9873aHGbhNzkv3Zo41zZUahw9smjV4KdpJ0RI2zdBmy6IGAa5dRGpxXKPxvNKw3aA4KXInIRTvuiDi69rn+4Zw9Lo0Xy4oPdSjhMjac9vcZUmaSb9HUf1EIk9YBei2f/CcQJqu1NTooNklfkpjwmFQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad055042-51c0-4f20-48f5-08dee40ac435
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:53:22.8076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JIxu5sckuAwg5VdEveeJhnQZylSkcGdYS3/gjQrpIsKtbPprvYbUr4dTgK7AwnL4pOoe5pxfoEIFm+9qu2su1pg8wfON0EVh/KQcP7oiZ2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8540
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE0MSBTYWx0ZWRfX2O+ys1Fu/SfY
 cNaaVsfsKT68hS+QpE7nfQqxCbnyUvHuAfFmsaW+jbodPxAMESninif2ULoSPByQxDKecXMfnCD
 VE5iap+Y6cLUmWrdq6sn8YDZUyQxiNcwpjUOpgGFGezHT7HQGnbx5xKflf1ExSydtAnLHfxNUXF
 asdm0BORlo2rT7V7jI9eXOn93r3vXejdzbSU9LR0iuNfa9nd95ecEWDxvYmWYEfirksq/qbx18T
 rpFGPeNIA12mLhdvaLsAJh9nwgxDEXY40URKse7hZEU+ixUTnmoBM6eyp/Lr+LMDVeQxIF9jz6A
 /uRKkPV1E+6NF/1WEiZfO82UocZoNf++Cvq0MxeF2w0TBs2kcn87i2eqz/jeteF3qFGg7cFLDlk
 CbQ6Cx9FiqyneR8uhH3ZWE8KsiGrMA+iwVOwSKju8Aq6i34l5srZk9iwdzZ/5DEGXtwipQKvobY
 n5O/cSEueEz5VGZDKBA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE0MSBTYWx0ZWRfXxXTZ69K59+l3
 aJCpsoVvvuEnqbgI4sp2CnN2aB91h6jn1hv6r9vD1YYOdW2vS5E3o06vY+J4dHnQ54JmSD6AL51
 30sQ2sj2C479l1x525lHOcqq/NejfMo=
X-Proofpoint-GUID: J_-b3t95u5C-IsjMF6eF_fYIn6kM1IHX
X-Authority-Analysis: v=2.4 cv=BdLoFLt2 c=1 sm=1 tr=0 ts=6a5a33d8 cx=c_pps
 a=yElQ4muSOuhJtI3odKz4wQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=h1SgO0F2rs-OA2TRR30A:9
X-Proofpoint-ORIG-GUID: J_-b3t95u5C-IsjMF6eF_fYIn6kM1IHX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
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

This more accurately reflects that these properties are held within the class and
not the object. Update the documentation to describe the few cases where static
properties should be used.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/qom/object.h | 56 +++++++++++++++++++++++++++++++-------------
 hw/riscv/spike.c     |  5 ++--
 qom/object.c         | 28 ++++++++++++----------
 3 files changed, 59 insertions(+), 30 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 272c41cac7..11b1c9d2dc 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2034,18 +2034,24 @@ ObjectProperty *object_property_add_uint8_ptr(Object *obj, const char *name,
                                               ObjectPropertyFlags flags);
 
 /**
- * object_class_property_add_uint8_ptr:
- * @klass: the object class to add a property to
+ * object_class_static_property_add_uint8_ptr:
+ * @klass: the object class to add a static property to
  * @name: the name of the property
  * @v: pointer to value
  * @flags: bitwise-or'd ObjectPropertyFlags
  *
- * Add an integer property in memory.  This function will add a
+ * Add a static integer property in memory.  This function will add a
  * property of type 'uint8'.
  *
+ * A static property is one which is stored outside of the object instance,
+ * typically in global variables. It is only appropriate to use static
+ * properties when the class is designed as a singleton. If there is a
+ * possibility of multiple instances, then properties must be stored
+ * per-instance.
+ *
  * Returns: The newly added property on success, or %NULL on failure.
  */
-ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
+ObjectProperty *object_class_static_property_add_uint8_ptr(ObjectClass *klass,
                                          const char *name,
                                          const uint8_t *v,
                                          ObjectPropertyFlags flags);
@@ -2067,18 +2073,24 @@ ObjectProperty *object_property_add_uint16_ptr(Object *obj, const char *name,
                                     ObjectPropertyFlags flags);
 
 /**
- * object_class_property_add_uint16_ptr:
- * @klass: the object class to add a property to
+ * object_class_static_property_add_uint16_ptr:
+ * @klass: the object class to add a static property to
  * @name: the name of the property
  * @v: pointer to value
  * @flags: bitwise-or'd ObjectPropertyFlags
  *
- * Add an integer property in memory.  This function will add a
+ * Add a static integer property in memory.  This function will add a
  * property of type 'uint16'.
  *
+ * A static property is one which is stored outside of the object instance,
+ * typically in global variables. It is only appropriate to use static
+ * properties when the class is designed as a singleton. If there is a
+ * possibility of multiple instances, then properties must be stored
+ * per-instance.
+ *
  * Returns: The newly added property on success, or %NULL on failure.
  */
-ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
+ObjectProperty *object_class_static_property_add_uint16_ptr(ObjectClass *klass,
                                           const char *name,
                                           const uint16_t *v,
                                           ObjectPropertyFlags flags);
@@ -2100,18 +2112,24 @@ ObjectProperty *object_property_add_uint32_ptr(Object *obj, const char *name,
                                     ObjectPropertyFlags flags);
 
 /**
- * object_class_property_add_uint32_ptr:
- * @klass: the object class to add a property to
+ * object_class_static_property_add_uint32_ptr:
+ * @klass: the object class to add a static property to
  * @name: the name of the property
  * @v: pointer to value
  * @flags: bitwise-or'd ObjectPropertyFlags
  *
- * Add an integer property in memory.  This function will add a
+ * Add a static integer property in memory.  This function will add a
  * property of type 'uint32'.
  *
+ * A static property is one which is stored outside of the object instance,
+ * typically in global variables. It is only appropriate to use static
+ * properties when the class is designed as a singleton. If there is a
+ * possibility of multiple instances, then properties must be stored
+ * per-instance.
+ *
  * Returns: The newly added property on success, or %NULL on failure.
  */
-ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
+ObjectProperty *object_class_static_property_add_uint32_ptr(ObjectClass *klass,
                                           const char *name,
                                           const uint32_t *v,
                                           ObjectPropertyFlags flags);
@@ -2133,18 +2151,24 @@ ObjectProperty *object_property_add_uint64_ptr(Object *obj, const char *name,
                                     ObjectPropertyFlags flags);
 
 /**
- * object_class_property_add_uint64_ptr:
- * @klass: the object class to add a property to
+ * object_class_static_property_add_uint64_ptr:
+ * @klass: the object class to add a static property to
  * @name: the name of the property
  * @v: pointer to value
  * @flags: bitwise-or'd ObjectPropertyFlags
  *
- * Add an integer property in memory.  This function will add a
+ * Add a static integer property in memory.  This function will add a
  * property of type 'uint64'.
  *
+ * A static property is one which is stored outside of the object instance,
+ * typically in global variables. It is only appropriate to use static
+ * properties when the class is designed as a singleton. If there is a
+ * possibility of multiple instances, then properties must be stored
+ * per-instance.
+ *
  * Returns: The newly added property on success, or %NULL on failure.
  */
-ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
+ObjectProperty *object_class_static_property_add_uint64_ptr(ObjectClass *klass,
                                           const char *name,
                                           const uint64_t *v,
                                           ObjectPropertyFlags flags);
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 9fde0faf39..630b65f569 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -278,8 +278,9 @@ static void spike_machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_str(oc, "signature", NULL, spike_set_signature);
     object_class_property_set_description(oc, "signature",
                                           "File to write ACT test signature");
-    object_class_property_add_uint8_ptr(oc, "signature-granularity",
-                                        &line_size, OBJ_PROP_FLAG_WRITE);
+    object_class_static_property_add_uint8_ptr(oc, "signature-granularity",
+                                               &line_size,
+                                               OBJ_PROP_FLAG_WRITE);
     object_class_property_set_description(oc, "signature-granularity",
                                           "Size of each line in ACT signature "
                                           "file");
diff --git a/qom/object.c b/qom/object.c
index 622840f9f8..47977b1f44 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2724,9 +2724,10 @@ object_property_add_uint8_ptr(Object *obj, const char *name,
 }
 
 ObjectProperty *
-object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
-                                    const uint8_t *v,
-                                    ObjectPropertyFlags flags)
+object_class_static_property_add_uint8_ptr(ObjectClass *klass,
+                                           const char *name,
+                                           const uint8_t *v,
+                                           ObjectPropertyFlags flags)
 {
     ObjectPropertyAccessor *getter = NULL;
     ObjectPropertyAccessor *setter = NULL;
@@ -2764,9 +2765,10 @@ object_property_add_uint16_ptr(Object *obj, const char *name,
 }
 
 ObjectProperty *
-object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
-                                     const uint16_t *v,
-                                     ObjectPropertyFlags flags)
+object_class_static_property_add_uint16_ptr(ObjectClass *klass,
+                                            const char *name,
+                                            const uint16_t *v,
+                                            ObjectPropertyFlags flags)
 {
     ObjectPropertyAccessor *getter = NULL;
     ObjectPropertyAccessor *setter = NULL;
@@ -2804,9 +2806,10 @@ object_property_add_uint32_ptr(Object *obj, const char *name,
 }
 
 ObjectProperty *
-object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
-                                     const uint32_t *v,
-                                     ObjectPropertyFlags flags)
+object_class_static_property_add_uint32_ptr(ObjectClass *klass,
+                                            const char *name,
+                                            const uint32_t *v,
+                                            ObjectPropertyFlags flags)
 {
     ObjectPropertyAccessor *getter = NULL;
     ObjectPropertyAccessor *setter = NULL;
@@ -2844,9 +2847,10 @@ object_property_add_uint64_ptr(Object *obj, const char *name,
 }
 
 ObjectProperty *
-object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
-                                     const uint64_t *v,
-                                     ObjectPropertyFlags flags)
+object_class_static_property_add_uint64_ptr(ObjectClass *klass,
+                                            const char *name,
+                                            const uint64_t *v,
+                                            ObjectPropertyFlags flags)
 {
     ObjectPropertyAccessor *getter = NULL;
     ObjectPropertyAccessor *setter = NULL;
-- 
2.43.0


