Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E637C54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 21:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHrSp-0003K6-Aq; Wed, 21 May 2025 17:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHrSk-0003Jh-DE
 for qemu-devel@nongnu.org; Wed, 21 May 2025 17:58:58 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHrSi-0006oV-I5
 for qemu-devel@nongnu.org; Wed, 21 May 2025 17:58:58 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LDUF60015403;
 Wed, 21 May 2025 14:58:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=c2AkgAP3nYDghVn
 HeFriu3Cm2ZSxKU9IZUfXeZwK7lk=; b=yP7vgPCJvk7SrCMg3IXw5+/5dksJE/S
 ayzazNYNrIIdmjVhMClYYU5PLNR15dX/PP4O/WaSrafd5UzWL5vbCSJXvmoS27lJ
 guTQC8qc/DjvOjz0lNugMV3FcCQcyYy8lojHz9/MUT1fX7I5/ihZYw2rjA9cjObz
 bbn95yff5UpMl2F+EX8hHXC5P9VIF1sD5IhnybrMr1XycVbtkJJ/2OhPxs3VX/kM
 krFXtFbPI2KjKAqKjkBWRfbjMK/WsOJJin7aAL+dfmo5SB231UmlnV+z90EBcGcA
 hFmKF2igxIUuOld/I12vKdk3mQrnv33C/aKWRzHzL8sY1JgLmBH5+wQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46rwgrksan-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 May 2025 14:58:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZQys0DrVeUN73vlzCe+gm8MOACnamsLcDJiHaDZAy9yOU3Hxzy/g6eG4GEGOTMl8cDQOR/5NABak4+bdeSeOBwEIm+s6LCys6GCRvyViCinRIqGx4OOCtsUw0Dk7FZxGabwRYGnMjkR7ZYk68AonTbk3tkcCYlVO1K7QQ9MQSCKhsubmqwoBUgw+0tiWDnBNq4bNBe5ux6q9I/WHnEIg9KhbxvIZFLe1LSwO1Y0v/PHgQ5j05RXMcceDdZN6XGKfK8F8Gp+98XRhGpi0M+o8PAPiTGpWUb8UnBNMShwppgyOKWCO/aE3k771rY8PyvGKhCbOGZQAPfgkwedoDLAFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2AkgAP3nYDghVnHeFriu3Cm2ZSxKU9IZUfXeZwK7lk=;
 b=uzCcDQnICrfdLHmq/ipxaLOgulxcJzA0mAKsXLSyR2x1ERK7G2B+um4wjAZtd6h5QMIX8V6RYYcQYpvx7yLhSgCrM5oAibhCVfITd9WHHo2JXE34lb0oectUuC64b5+368Ck7ZvgSBCFrfFRbCGFuEf6Tgtno5o0Vpg++nTI9k0vqopAKIMBKmcMCMK0VQqfXFHz8D9hHnMszIS5EQ/XDceL+jKT98RET8L6uZ3AugVPzFR2paSnNXQIVgracxl6sZuSXPZHsguIXqXSHojm1JfadqeafwH39jTCT8KLuhHVqnBFhWyDT8Ei7mN4U/sQkR7GQiM/XWkNArIcNJ+tPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2AkgAP3nYDghVnHeFriu3Cm2ZSxKU9IZUfXeZwK7lk=;
 b=X/eWGLoOwHHDZdwVMwVuho5k6uLEhNLgEdJ7DgmHTfb3ZetnRMGlLG+FqBbOY58gvorzvMv5RkqZ1wKMV6Z+KPOExO7UjWmkU8CykA/+dMbNaQvlfcEsbxd0BLaCU9bCNDk2/xebqdSHmnz9gxpxSjYVomSQPeR/ZyVhI0F2tj2IRmr40X4Cj3lXUKwhxz+GUE+Wr0Yu9kudf1z4CRovkufLBBrQk3r1yz8HdIF6vWcQrplen8rRPPaQAQiE1AZDTFE/rNxKYqXq5WymHFA0Xo0f5F1CCf6bXsf6G60jMGMEiiIumRGEaPMDei4IGf5xpZ3f4ke/N51evUQmzsinRg==
Received: from BY5PR02MB6753.namprd02.prod.outlook.com (2603:10b6:a03:209::17)
 by BL0PR02MB6532.namprd02.prod.outlook.com (2603:10b6:208:1c9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Wed, 21 May
 2025 21:58:47 +0000
Received: from BY5PR02MB6753.namprd02.prod.outlook.com
 ([fe80::94a9:746a:7967:ba88]) by BY5PR02MB6753.namprd02.prod.outlook.com
 ([fe80::94a9:746a:7967:ba88%4]) with mapi id 15.20.8769.016; Wed, 21 May 2025
 21:58:47 +0000
Date: Wed, 21 May 2025 22:58:21 +0100
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, steven.sistare@oracle.com,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [PATCH] vfio/container: pass MemoryRegion to DMA operations
Message-ID: <aC5MfZcbVR8qlun4@lent>
References: <20250521215534.2688540-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521215534.2688540-1-john.levon@nutanix.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM8P251CA0028.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::33) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR02MB6753:EE_|BL0PR02MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: ec9eca8f-86e0-447a-c7b9-08dd98b29e67
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/TKQaT+tt6j5g9f/tkLjUXar1hxo8avSbuuB9178jsIDRLjW2UjO2hO50FWf?=
 =?us-ascii?Q?9lFSvHaOvFt43mb+KRHB3EJ7Pz1e22Qg2ZtFvsVgMMUpnQ93L0j2ySfVM7dD?=
 =?us-ascii?Q?0hlTCBkzhUlkeB+HM0D489k+J46ruk226mz/c84yKxBC3qCWlEk1QO3Qnp3a?=
 =?us-ascii?Q?9KFxuCBXYzbrBAjEUW1LjMJmS6Bu9cRbNf9RY4H9UURRNZTLce5skU5ikntP?=
 =?us-ascii?Q?eUdETwMz7Tja9eqUwQ2WF2ItWg8jACfpceuIGeyXCLsgiznw1dmBiwYEMSRb?=
 =?us-ascii?Q?w8Yy7+qxofGifiGodE1YzVkXkzWjyCHiyekxNn4GrfANf+TVLOGzba5poJQi?=
 =?us-ascii?Q?jprKr0Cl79e2Jc41aMCDFu8t/9QZ93+QcQ4SAKxpYmwN40hTBLW2Q5b0FYkv?=
 =?us-ascii?Q?U1zyxttfDlFJv4w+1sWIqvI5Rnna1VSp0Hy7lH1HmE/DkMto8/GlrKKz7+lB?=
 =?us-ascii?Q?TfYD9aQgWv+xCtqrZvZ5NJGkXD1WLSLP+piAXpWfe0XSWRQCjgvVdInfWgs4?=
 =?us-ascii?Q?Xohm4It/6l7kYzD4edBYMDI58uGYgEo63hbQPQmR31xI46pIdmGmbJb4UErX?=
 =?us-ascii?Q?Rztt6pu2xtcY0uTEnoD8oO15sjYCPQHmdUrLpXnUObFvJqWSJqaey66MpR0J?=
 =?us-ascii?Q?nhgxDocSeYSaS+hdTRy8adZL5EcigAt1mloXpIBg3Z4uoIEOuudj3p0kV2EY?=
 =?us-ascii?Q?ZTMZ6HoO/34NV4RqHUDv59vp/EN6h8yN5EovKlLUAGY8K3yzEIo9Dd43FXty?=
 =?us-ascii?Q?Q92c+2ofi5h2x7g1vgEZmL+LvJnMLm0DpFFZRP4zBpNg0oNY+hB17FYVbNM3?=
 =?us-ascii?Q?SZlrCGlyGZCYi3e8qdsc+SyMgewKSRFlGwX/T106mcprNilSYyV9fBIlZDiM?=
 =?us-ascii?Q?GFfQphpfRqidZk5/cl3s2NSTE0eGNjxor0S+0rmCk/yccL8/NCq7Llqv6X4u?=
 =?us-ascii?Q?rH5u9nhsmXAxkNvTbZM5pdwmQxTwPcZcRsn370Bore/fi5OWPRQZlZLHHVGC?=
 =?us-ascii?Q?s1KEMee/F7ZMorga05cOQVnEdlwi1M64nWJUI7i2EEn5l4cz5YtyfPvPkedV?=
 =?us-ascii?Q?NASCTy7ewYU5Mwss0lmtX8K1hVsrMm9jzMr7S013THiLrVUNOckNPOAu/VgS?=
 =?us-ascii?Q?oIRUj1Q1J3QALfdpeoDW3M+SmdKYTpTJtGxIyJl+mp4MytwDVniH/uMqsK6V?=
 =?us-ascii?Q?joXbFSEJoMjmnZEC+G1yhaFjoxbT1dfFCxv13VQPZQSqHhCNhXJGUrQyddVl?=
 =?us-ascii?Q?tz9lPJWxukeTywS4kaWhsbttRG+iPGgYUw4y/RuGAaBzpWnJUw/fv4i9oxcG?=
 =?us-ascii?Q?+iP6EOlchAD/584+egQgbxoomoDZWESv/WFSsZ7ZqXF/PJeZnlyEmZni3P8f?=
 =?us-ascii?Q?M5Gp0746TwBoVul8Og0TyTXv5wCuldo7iIZznQ/bhIhj0FdMI6qTGvaM6Kyr?=
 =?us-ascii?Q?Q6eroZl8Seo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6753.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7inUS116pylvsheQVoEeWMmptKdpGlYr2UpwyYlbiI70ODDljTD5n3C/RioY?=
 =?us-ascii?Q?CZCNZCvxN+fPLl6BR8e4M7h7xD3ts5D3cLCKYv2dNmTGg8ZxrVQW5Kv7wir0?=
 =?us-ascii?Q?K0X0/L8UWpJMETvIzrquiDM81tY9srhgfsl+N9oMw07ZxvTgcxZUhnDihh76?=
 =?us-ascii?Q?Gwgq2eGeP8IYK52WwjsCS3D/Krr/9UgEsBLDDxKoueWAaTXWbWfvzwEFEeds?=
 =?us-ascii?Q?UlcaiLv1Qo2LIKmRvtXETJOEWrs1cr5E9MnXHqXNGOkoxiaV0GxSp1/0iiVl?=
 =?us-ascii?Q?7H4hVsGnyK81cT5Ys1isdKhjJMj+60KtQ/5FmGifdI7Xdfh+FMNUTBr5yfdS?=
 =?us-ascii?Q?pKC8JSiZxpXe4D8o9FfzEwkR7TTWekJufP8G9k/zuiupm6kUaLnJgF1CtRaJ?=
 =?us-ascii?Q?mlB085ZLUn1eSWt9MCVW3sxPbbp1bJxiD+ci03fVRX3yeKuqWlAL+0kk+SFC?=
 =?us-ascii?Q?I/NnS1WdwG8ZC8PC33f8Z/rI/sLNRcfAfKQXU1HU+YQeYeeRBTcvB4UUC/UC?=
 =?us-ascii?Q?EXDo0UXRP4N/f7agxuMqlMeXfQGufFDstzOGWQm9uxTduT5NMnCIdMOk5V9x?=
 =?us-ascii?Q?66cj11y+UPUTAfxtnxTA6Jc8Q6qPtdywiTTqkNOZd9x0OtjlrU+YyS11VCm/?=
 =?us-ascii?Q?H6iwRvVl0F/nVuakZTE63RzTsTGy+xzvU8/H6Xird0P5DgyaeTy1RKMcIBJV?=
 =?us-ascii?Q?CciDMYiQHURwhxhl3OAQk8qRHJV/sr5X0hcCqAUja0wyIf3MUjkyJRIKrYAH?=
 =?us-ascii?Q?3UOpUWj63GZfKOOj9cIUCqHcK1I4kiXLpEE8TXimgt8NXb0JrxVgKStXXSZa?=
 =?us-ascii?Q?Kx7QlzQ47O++l884tfK4AoebfyCUXQeDswd5a1eWK5/463mNXMH0/hCO+BbN?=
 =?us-ascii?Q?yAtOeruDvmmjLM9txT8JEF6JOP8oOF7eW/9nL4CfIQhTXmGqZwlA+MVLhRcA?=
 =?us-ascii?Q?GiLPLbxKkw4G7VT9YOzolYWPw7gkn08HYhjXZuuwpV3Ya1hVwOuSF0F9nj0x?=
 =?us-ascii?Q?rdVuzHjiPUFtholRvgsDUyHBDL8nmgjvd0uKMHRH2lCrZDi1JSGzD+UZwf7X?=
 =?us-ascii?Q?AWL3K2zRRXkyKVwqVH4OGDkE+lhayvfF7Itt1yIDhc5WyNY4e5ISkaUwhYRv?=
 =?us-ascii?Q?38kINqW73OLes1LiTAkXLrNbEO4JaqUGUkbUGOPul01k914/X8jdCdV0CCu8?=
 =?us-ascii?Q?vyrCRB6RWeSeLu2QRbbbhdg7Tw/v0OBVg10VbMW01qIHGs6hdaoz4RkbJI9t?=
 =?us-ascii?Q?OvdLqBaLO7NZmInuc3cEC8OrnCu9jbY+PfBBdOT8YqO0D4hysSIWPnamB6op?=
 =?us-ascii?Q?O9EFSGOOQtHbT3RNucJ67Qka0L3Eb1giacygpoh+8WoPriHtJH3CIG/JVOx9?=
 =?us-ascii?Q?fpL4BUub/SIMfD6IOChlBhAEjzQf2ufJ8mxwxyJaxI+JZ0czNbSpkNPkXZP2?=
 =?us-ascii?Q?2SNK5v0hY+c9zZx3Y5f3T21IzHXgnmhNE53b2w0LxQfgFs6xR3NAE5MyhDsv?=
 =?us-ascii?Q?qP70isbHBA9IDN1IKFrQXNhcia144wFGp/BsinuxdddcD3BGep8/krcguRHY?=
 =?us-ascii?Q?KVGV/VU8+IUCfqMucQIa7UkoUjtxR4oMSay/MsWv?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9eca8f-86e0-447a-c7b9-08dd98b29e67
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 21:58:47.2595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EEOahc9pjXuPmisyo5DMpqRVqfsBCPebmP7VvfcrOjZlBw5gpbzkGwa5fxtbJsmpv4qYQhbf6zYk5cLgHOFvfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6532
X-Authority-Analysis: v=2.4 cv=C5/pyRP+ c=1 sm=1 tr=0 ts=682e4c9e cx=c_pps
 a=F+2k2gSOfOtDHduSTNWrfg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=SD5T3G2FGIATuYCGgz4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDIxOCBTYWx0ZWRfX6aZoaaHyjPl6
 lDScU8nCCzAI+EKNjVufIA4G/yYwjSlA1/z9hXw4HCH2W9QRFUjo7prclf0FQNjaBQYDZVO/Ptl
 3rkytjYnaL55kog4mBPB1MdBXx8yQEiWZwfbiHN9SE3n6GW6m2vFRmjCjjKtiiGqwLicqvY1ASK
 HHhcWdp0xMCFYrclFvouEeB7o4DLl6tznYG21ms4qPNPtzl3gZl6KunSZnwNpCDHI3p89I/hgeH
 ODVaBCIGJ1W6MojmlN+2bHtv/X28Vfz6XoaBq0F7WM4Y2FdAcSNdP5LtjUjDa+qyGAV5spwQ/kx
 CQDYdH0HFw2x8puYWimYHQoBA/ChevQWhOooAFfhzUz14nF/f0E+Fw9Hl3n1exb/uVEM8ZEEBT7
 2bjkwcEGNLJukEUwyHNfUpG80ZYgFXRK++VgqLHe4auaSd4iBqV5E9BjCmUNsx4xFmdcRP/c
X-Proofpoint-GUID: La34pLO0WAeYKF45NL1YEcfEYkCaKzfp
X-Proofpoint-ORIG-GUID: La34pLO0WAeYKF45NL1YEcfEYkCaKzfp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_07,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
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

On Wed, May 21, 2025 at 10:55:34PM +0100, John Levon wrote:

> Pass through the MemoryRegion to DMA operation handlers of vfio
> containers. The vfio-user container will need this later, to translate
> the vaddr into an offset for the dma map vfio-user message; CPR will
> also will need this.

Sent this out separately against vfio-next as we both depend on it, thanks.

regards
john

