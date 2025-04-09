Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54223C369A1
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 13:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2VnD-0006Ef-1A; Wed, 09 Apr 2025 09:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2VnB-0006E6-P2; Wed, 09 Apr 2025 09:48:37 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2Vn9-0005cy-Vs; Wed, 09 Apr 2025 09:48:37 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5395qVMw014865;
 Wed, 9 Apr 2025 06:48:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=mZA2n6ehrTVXpqxxxwJ1IW1hpnQOvilZbBpsRGeOO
 jk=; b=a1KkDFQF7PUTr+L6p7gnlJsdhBYZchyLYyHyZvklR9z27smcXBECh0POu
 srv8VRXenpogO4sBeJUMfKJboroEsGk5Kb1I7bN98GUk1igiIcLNMiZZPxMf/RO8
 VA9MomoJceevENjVtymNRgIhH2C+2BB+td1QOqgb/bgEKsGYAP41WZN007HDIslH
 4toMFAo1Ke6FMII57NGv0+lTb0Uy/KF7whi2ujLkaS2K6m5xT2QQjjolvlcz37Pb
 351F9wgYA1zvkbVtXmFzYtJ9077WI/Et/4WL2rw5AyhCtCYa+koSUIiW64rl9kA4
 dWyARX9QN4P4BFjb5+lFLl+Fm1IVQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazlp17010007.outbound.protection.outlook.com [40.93.13.7])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 45u2mhj3j0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Apr 2025 06:48:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uA/SqNzgu2OAnPjCPcI/PbacBCy/3XU8Amu/cdZXndiQ7iHmg42DGxYTol0F+q6h1JmDr9gYE6jOUO3mZiT8VgINSyGcLX66lCsBprffh0ba1O6MBMUnN5vZzRsD4sqwSbfqqFd45L5lm1IUoXQhOEL9RIbqfj2d76l9d1DX65vT7FciKQtP2QP0qiAsGDghci6aG96yxDr7HtCkQSDShPpaAShQWzTv/E77DBb7I6dXRcBmZrSEx5Ikq8lExFgbhc8adXzuygyez3fgGLqOU9PkbleiTYFGsMhW/T3I/zK+CibbyIl4bnY/u0lw5kH3O6TgOdNvF9NNh7d+XmuIbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZA2n6ehrTVXpqxxxwJ1IW1hpnQOvilZbBpsRGeOOjk=;
 b=NcIilVakMaS9orUQR1cLbtgZZgTp0uHh65sXSuau1/cs6VhP7j3hnOJJytlinFq1xLqCGtVkWv78LU7OuQlfX66WjNpoHQWFl/pRnWQR0fkwYrMpgONXvq0Ygn7yY9fhjaxi3sIyMVsfgEtW9lgoDuIT436TC4ACEMHqHoKgpVfCmHEwrNR1s5tLe+UFD17MfKINhZtBLMbyxU/1sNSXVz9uDpPBXbcwb3xY7+BGIhvt/ZLc5NnJq5nyEe+9HzrO0anxOogbFPo/UAwSyBBF9tT85TgAZJT6pfM/ozXNfMdWDuOtB5E4ldv/cSBT3U3TFhgKCqS9NnPNw2rK3pCFEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZA2n6ehrTVXpqxxxwJ1IW1hpnQOvilZbBpsRGeOOjk=;
 b=KCz1BN0OVDMB7GACHRkk/DJ4Vr+V5gYq3ixOo2v8ZDpmD667SbXHHK5FyMx4BoPC2kBFiqqlg11bYTr67sEkIh8nYAxcEqtuRo517dSCAlcPTvlaea+UYkLKxfHspJ+keV8oX8Or1aFsEEo2GCg6IFZlonjsWTckoi9cJOi97xBQhhurBzjTdqiw3aB6PEVHB7J6AACxTz7QDC2W8esmmCkz9iHw15ZHQQQcXnaQtb4Ej2i44tqd3PtigY+WM5psD2XBV3KkyiJnPvLxJYW5JmJXg3sMZn6cstIwLa9ZYOAkjizQ7AFVwsqeTTZHWgzIH/4nQg3D9sMkI6CD+vKsmA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by MWHPR02MB10356.namprd02.prod.outlook.com (2603:10b6:303:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Wed, 9 Apr
 2025 13:48:30 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8606.027; Wed, 9 Apr 2025
 13:48:30 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH 04/14] vfio: add vfio_attach_device_by_iommu_type()
Date: Wed,  9 Apr 2025 15:48:04 +0200
Message-Id: <20250409134814.478903-5-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250409134814.478903-1-john.levon@nutanix.com>
References: <20250409134814.478903-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0028.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::33) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|MWHPR02MB10356:EE_
X-MS-Office365-Filtering-Correlation-Id: e050a559-507a-4ba0-c396-08dd776d362a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1CsPNWXg793sSXCwgNpWsluB0QsFYIzJpcnu2IbHZq8nlBG6SLIfnUYW3e6b?=
 =?us-ascii?Q?HvHxSqlObRlfaOl/fGUjMqiUUYKcF6fcLazq+A+ZF5r9WCFkQWwA7erCWaW4?=
 =?us-ascii?Q?b2XZkiBsuKS3eQA9rnr1+FSGHAVohw4pD2QMnPd7mFCsrvZEHLFIpctvVUBI?=
 =?us-ascii?Q?d+fF1ka3afUKmaW5mUZeb2b66VbsoXtvCMOl6hgU1jo374FNTC07aooYJqie?=
 =?us-ascii?Q?6AZhUZ2tvUf8fMjTdTzVGQFgyUqYsFEkEgEi9se7P+aTqdLD8r12ZAm3kKHY?=
 =?us-ascii?Q?aHCIb1Cjxry3qscMYBvBXbixyOdfEOYu8U8YkrtmT3lIumuO13Xf6896pdvg?=
 =?us-ascii?Q?Y4OhXfshzK9FNlXC34ellBGAUFGG9dI57AB2A18WFPUlASjtyotBLUjIkDgC?=
 =?us-ascii?Q?ebStIrB+dIWqH2LLl8S6VLj6pE4wJi7MLAxXDFbeHBew1QMoP1pVgooBFIM+?=
 =?us-ascii?Q?8DvBpQXgnXw7Rd4TnEn0s2cc6OQCb/k02Aw3NZ5JYSl7cj85Ypd+tUAYYy2z?=
 =?us-ascii?Q?TbUwPPqLxCCj7CYVwhUSXzP4uXBW9TWq8XYz6GwtUPoVYcnyfA4/2d1kvzJL?=
 =?us-ascii?Q?qAhdPQkDFn67gl+1Fk02CwKjR1nAWrT6cF86dfUhEIXo2SHs8O7o/BIm547X?=
 =?us-ascii?Q?LpSPIjR5O4DufzfyChJ3fzsOQ/OGlWsE6u55FpVlDiHOCM+CSKtZWiL4pJlW?=
 =?us-ascii?Q?EcCLZupk6F9aorqP+HLl9t+SKGbJfH6tTPTWuMzkzJjQ4IRf/yOrUAO07AEC?=
 =?us-ascii?Q?2PxBxzLUy0M+PPQKJEocADqL33IMjgSRel26ON9PxwsSW1QJ8uu/aZZ8ovpy?=
 =?us-ascii?Q?ivsJen0WpzSkuLIxdYWIR1sKLBsDzCRRncvMo4RBddn7tGk5MRL3LuB49Ayh?=
 =?us-ascii?Q?svzLZ19JdIuGPOiaqGmKKRYa27W4ash9Ry+nQJ/Zwd077yFwxqzTfN+P0LgR?=
 =?us-ascii?Q?Yc5paIYApP4lwbdkxy6nLcVRl2GRikxmVycaORd5XVsfCtKm1xANofYUdo1B?=
 =?us-ascii?Q?jS7bAIVhhE3YDUZJQzwI8goHk/CgeOICDSBwZFcbFF8zG8UtuXKYWGJy7BvL?=
 =?us-ascii?Q?BTDvbi2Cvfov1P/KUpLwGPHNKt+Wr0bXibuI6U9vIPvye8F6SLlIjtUb5caZ?=
 =?us-ascii?Q?/cVPNT0/PXV8b2/eGoWaGoYpAnhVNw8xp1B+TeiF2LWYBSQrTS7LbpGyveNi?=
 =?us-ascii?Q?lDYG0fzgKWJ5WsVEXqI6kZsJk0Z8ZchmDqqVZUH+mWbWWD4aiYkBr0JYA2C7?=
 =?us-ascii?Q?imTwL4U1XfvyoCAErm3LGhUnDUmFfhOnVG9z6IsVmcKoWOHGVQLUWC6tm1Gn?=
 =?us-ascii?Q?rQrKMSrDvY/IROQuEo84YwAVLFKfhAeLG7BkQU+dG4OsxDO3T8BilKCn4J4G?=
 =?us-ascii?Q?ga8TbuFcYsGCuIb/M+QXXiAehmLz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VA7vayTUQ2swH4LhlqCEr+zMnXXSJArx8CAF9EPGwqD1t6cyVWTvEHHCMwp2?=
 =?us-ascii?Q?2P8uObPTUaw5wh/yhswBro+dB261rU1idC1yy5nnfqmr/ZrtLaEh3w+HP3iJ?=
 =?us-ascii?Q?WgHv+drV2/MEY4BlEmcyxQm02qfPDpTNOt87+zE3HAx0afW2p/N1N6NLXYv7?=
 =?us-ascii?Q?vuJvgF1uwso2LTyLiIwmKQMluhgV+ldJJII+wcG9C/+fdFdugFJBJ7iGvmTm?=
 =?us-ascii?Q?XtrLPZMdt4hZaWUzkSIw1m37WXpOxZDM4QAHnFMyt8qbrtcjqMdVf/9VNGhW?=
 =?us-ascii?Q?nSedhgfjuT5kCyG4gIN2v/e5vxFdzzoXO8cvbzx8K1+guVBQyITd6vKay+zM?=
 =?us-ascii?Q?ot2uhAKLAmx7NS5o32Ri2IMBWVLHbR6j0xpt0sKj5xVTxwytdI6dUeqDp+Ut?=
 =?us-ascii?Q?9DjN+X5JXkppXd09d6Gt3aMvuKw4lSKjbgR0FCJcXJwlrvdUxcH6efGvOp+q?=
 =?us-ascii?Q?IuUSPjEEvJf7e3u24cpDosMY/Bo5Pqix90UAhzMOROAMAwiZFsyWIGudsrQ3?=
 =?us-ascii?Q?x+QkRl8g4OtobJWlBfOi7i5BcgOiW599dlZkzjAx17jK3Jeplv1YW1qSoJ6D?=
 =?us-ascii?Q?ephxzP/4EZ23QNhjT2ciDrj/1hmZhv96o/Cy9Y9KfLs5qjfWMPbzuKgW6pTu?=
 =?us-ascii?Q?HntN8rA0Bl8eoy9p2wvIG2qavL2rsyxMyFUmwBB5uWuGDSxl70VDR9DiTuoo?=
 =?us-ascii?Q?Dmt3QRXn6ouS8YaANuYEWLv8aLYizPKzPtPPHbVr0fWEq30EzZy7KhKHHO/R?=
 =?us-ascii?Q?oDjYeWQL6SZY+z5xkcuAR8NsYKOOfhfwCsiTftMvJrddeRZ1/uch8PePIPvl?=
 =?us-ascii?Q?8KHU258CimLO70aGUV2r0+/abiaBFSOI0UHBL0IdC3NyVaPmsxKVrVRzfumO?=
 =?us-ascii?Q?1T+viZ5Fg1wD1TPbN0kdnnCPTp5O23yq0bq3q6m/7d1GD35kcjGlR14MXucD?=
 =?us-ascii?Q?J6d+VsWeMg7OLsjljRcYCwFbarv39kFfHB8wqfrfQVWvHGotJjY8OvoJNLOd?=
 =?us-ascii?Q?/HS9D1oh1h0xf72vgzlXdbH1Fgm4MbApG0LWsRAe+MX1zQjyvA6igM7ZYc9k?=
 =?us-ascii?Q?1u/nndAKxTs5rLQk3KyVeu20Ab2eU0I6cIeBuAw4FazxgAwxLuLb7aFTO9gG?=
 =?us-ascii?Q?gmp3rYN/WmnZ6O6o/hatesEykJfPyRSidT0VTanorYoELZHK5lcqZoJYLu6/?=
 =?us-ascii?Q?kTkMNfvY+NIKk5wqykkNI6P01hwC3qUl8ObLqJHflsr5Q0HfkhSucjnZEXem?=
 =?us-ascii?Q?02altBkqVTu4DlKyur9Fw3OwA3PTU9WqbbuFx9BJbLCLnSGGjT0+GINLlN9q?=
 =?us-ascii?Q?r86sGvmeVJJ5fbYHizZSjIkk/w8x1FZEIuIy7VTY7zmp9X6UqMyUz/cOpoAC?=
 =?us-ascii?Q?wPAuOM4eoCK5QqfU01BRt7TdNDGDyae+NeTtEMuBNXasNkK/wlkghCY0kuXx?=
 =?us-ascii?Q?164OUPR43qkyfPrA1USL0elvpR59HYzbaMtt/NiWq/yxsRAiXgXFreNhPjYK?=
 =?us-ascii?Q?FMoC0S7LpSt+DF/ARWuaq3i66xMUyKQzPnWllImbcLJDtOT6LeconALtlsqr?=
 =?us-ascii?Q?MO1lHfzDFbgmA5Yq1qwEZwJcbUN+CS9N2Hg389dP?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e050a559-507a-4ba0-c396-08dd776d362a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 13:48:30.3381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmsvrJIhZvxrCB+OiCDI80bgjXXEYRb4kBEv2AoLS3IFEvj6VwzR5zfkeiE0aDTiYkapq7CKubHAlTJM+vLENw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10356
X-Proofpoint-ORIG-GUID: 6ArF63Poiy_p5Eudyha7ylnECJujuTS_
X-Proofpoint-GUID: 6ArF63Poiy_p5Eudyha7ylnECJujuTS_
X-Authority-Analysis: v=2.4 cv=JPI7s9Kb c=1 sm=1 tr=0 ts=67f67ab0 cx=c_pps
 a=DEmxRycgAktlIQzUTPloew==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=iLcevqm78QRhCGJnTJkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
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

Allow attachment by explicitly passing a TYPE_VFIO_IOMMU_* string;
vfio-user will use this later.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/device.c              | 24 ++++++++++++++++--------
 include/hw/vfio/vfio-device.h |  3 +++
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 4d940ddb3a..f74b9c25ea 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -367,20 +367,17 @@ VFIODevice *vfio_get_vfio_device(Object *obj)
     }
 }
 
-bool vfio_device_attach(char *name, VFIODevice *vbasedev,
-                        AddressSpace *as, Error **errp)
+bool vfio_device_attach_by_iommu_type(const char *iommu_type, char *name,
+                                      VFIODevice *vbasedev, AddressSpace *as,
+                                      Error **errp)
 {
-    const VFIOIOMMUClass *ops =
-        VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
     HostIOMMUDevice *hiod = NULL;
 
-    if (vbasedev->iommufd) {
-        ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
-    }
+    const VFIOIOMMUClass *ops =
+        VFIO_IOMMU_CLASS(object_class_by_name(iommu_type));
 
     assert(ops);
 
-
     if (!vbasedev->mdev) {
         hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
         vbasedev->hiod = hiod;
@@ -395,6 +392,17 @@ bool vfio_device_attach(char *name, VFIODevice *vbasedev,
     return true;
 }
 
+bool vfio_device_attach(char *name, VFIODevice *vbasedev,
+                        AddressSpace *as, Error **errp)
+{
+    const char *iommu_type = vbasedev->iommufd ?
+                             TYPE_VFIO_IOMMU_IOMMUFD :
+                             TYPE_VFIO_IOMMU_LEGACY;
+
+    return vfio_device_attach_by_iommu_type(iommu_type, name, vbasedev,
+                                            as, errp);
+}
+
 void vfio_device_detach(VFIODevice *vbasedev)
 {
     if (!vbasedev->bcontainer) {
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 1a2fe378d0..3563a82ede 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -126,6 +126,9 @@ bool vfio_device_is_mdev(VFIODevice *vbasedev);
 bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
 bool vfio_device_attach(char *name, VFIODevice *vbasedev,
                         AddressSpace *as, Error **errp);
+bool vfio_device_attach_by_iommu_type(const char *iommu_type, char *name,
+                                      VFIODevice *vbasedev, AddressSpace *as,
+                                      Error **errp);
 void vfio_device_detach(VFIODevice *vbasedev);
 VFIODevice *vfio_get_vfio_device(Object *obj);
 
-- 
2.34.1


