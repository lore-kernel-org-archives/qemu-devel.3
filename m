Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0347CAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 14:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13UL-0007hz-SE; Tue, 23 Sep 2025 09:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13Ts-0006ZA-Ex; Tue, 23 Sep 2025 09:55:01 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13Tp-00042o-Az; Tue, 23 Sep 2025 09:54:55 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58N6wA1l4104506; Tue, 23 Sep 2025 06:54:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=0XjrkscHp3sN379raU5R2e9NOw/OpURqlftWjSenA
 W0=; b=C77d5lKSEmoRIchRnYowN7pN1so35qPrVF1Jui0C/K4E8MbsLdvXwUhKX
 mckvXTyP0jRwsF72qc48CgwqyDU/KhJvmOECVyy6FOd6Q093zyf0+dFj3UAoT5Me
 3xpl5j5u++SEzrwArVsrzZ7NZu+xwfSTSfcEflLrx5udM09sOA/4Z1kka1SNN5X6
 ye4zvzrGrodLA9CzESIRGfrwY3TuX4jDTDnEmjIqEJu5kEo3UcCvkYkfdAx0lXCk
 Yd/zMuAMpRtq2ZHFpSJlU9bgCo1rwDQjbfDZSH7KGVWbV8tGZNiQqqHSH7w/tDQn
 xLpxphutca7kQhvz/QTwnVJR0ufiw==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023094.outbound.protection.outlook.com
 [40.93.196.94])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49bb1fa89p-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 06:54:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cByQJeT5Otn1ZOlwc60/4UkTLyaN3Yyv83BzADklhFJy31+aQfT55QzkFF9BPZ+dlqpfHz0HJhPTFzx/yMGOH9Xg2OS5yDV9r12YjeWY02NtFdISw3T37XGAJqyrcJyYH8XZWhLsZqO/hEpN82KUGXho85GdppCzznz0hMS0syuM8s2lrtr/ffjG4tjUqKBLf7m8HR2dO/Is2G908f9G+8RlHC2oYNJMS5twkQ92TKJ4DjAtGswsa8bo9hYpkjkGQu3W2qzKJL1VC1odmqSKRgbzoCf9iVeGBd9czBiyt69LbeWTvM+traE+AzsTZpj9m6h7/uEs9Kdz00IZNDLOAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XjrkscHp3sN379raU5R2e9NOw/OpURqlftWjSenAW0=;
 b=nbUKHGsttllhW3kdgsZeyCCc73RILlxjYh39vtcxzUGAR3Rgz5x9jADUhJ4Ip47IgN/5dFMooKc4S5HEH6mGNM8MmFYaQZqt1PeERBQWCQBkqBLz76SQbr6gezqwhZxfjX9FllFEn1jBvDCsCCnbWipuEW58BwZZtm7SeuaxJ2A0rCSEk269el92SJn10A8NmuVs1DTIU+p0LSBZW8AHXZVM+vOZP81VAw2HNV8fX3tLm+6uJ05oYdfkIhJEp5mbJ8W24xFTmlDyBprEiWhbFInm6KhQaths8W95CP6LvnjaNBaWtwrkYzSE5YPo98/2P0q/BvJi2qVbkqgzlP38Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XjrkscHp3sN379raU5R2e9NOw/OpURqlftWjSenAW0=;
 b=bfvKoZYC5DybF5x4qMH2vOVTKBt4UlZVmuDO/tYZumLwiTKPIlCMxgxjTLpBUTHF1hv8hADv33b3UKakA32J4codfmi7Ke5yWg6/QcjOXxKswc1IawTkBeogTrbSxWao47lZaey14MYBi8a/UwPb+5TCXv3tpouRyD/EpEXCOz6d7oWYSjHlMAq3v7M43lu1KIpeeKqrFQJT42cFT+ESkwWvQRMMF8tzxDddQNt3nsS6Gq3hEi2ubFOBFGLyyP6CpigagVG6KVXts7b4eI2eZvq32Pebp2QZtr1yJhXaellrbAL4XK1NR6CubZI+rW+i4kFwvJ8bNQ12HrhcPMoZIA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7742.namprd02.prod.outlook.com (2603:10b6:a03:320::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 13:54:44 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 13:54:44 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 13/27] vfio/pci.c: rename vfio_instance_finalize() to
 vfio_pci_finalize()
Date: Tue, 23 Sep 2025 14:53:19 +0100
Message-ID: <20250923135352.1157250-14-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::10) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: f71ce6db-33fd-4197-4adc-08ddfaa8c022
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f5La91WgNamprGk3BP3k+ui5s9mS06Ul0R2Jw1DJ2AnTEN5EWsXYmfHsVP6C?=
 =?us-ascii?Q?hWhLd2cZIkpuGoX5XCoPCn33rJBISbghOJkbyx4nIWtX9PRHuXoCATeIpFq8?=
 =?us-ascii?Q?qFJQqFIHdp+1ZNtMxsFvwzz3rugEiTo/QrzdHst2jVjm6M9VAh5R8V6H6T4K?=
 =?us-ascii?Q?r89DEynV0wXdODtCvc+xWzpWlUtIyHFskCR3gVrrXjWnhbWEJ+NZLKTljTdK?=
 =?us-ascii?Q?6LQfd8g59aWFImYhogsBTqq616Oco01Jg1xlnDzA0uWGAhWpyglHLSpXlVmU?=
 =?us-ascii?Q?bd3NOyOxWvMu5BHU7oq1pTBSiL3N7VD0AdEF2c1uf7qPzGBxLaFtyMJDIq09?=
 =?us-ascii?Q?g9K4WwoEpf1FehB9DDDNQb1ItAtmixK5kNKLHlElkS12pLszZrJGhmmNfTIu?=
 =?us-ascii?Q?nVJSWzqz/Nmqaa6VDZyWhitl1DlmOUX+nltSKhoZ8SzqzzX+alCCfvvbPa7y?=
 =?us-ascii?Q?KOcXXYiOWIesFrznnbJBQyyE9qs67yBzFdiKZeB+wbeqLyfu6WwXU/yLu+Gr?=
 =?us-ascii?Q?AmHsQJB2ZBzelYR2dGm50yrVE0wc/0VuRVhy8hpQf4GtCsl8vqKOqhe3zlie?=
 =?us-ascii?Q?Is1n4FcNrB+1cjSk8ab39LezHtT+WFtkzwW0rccDQ7yen/4KzQ9+hjqaW8Z+?=
 =?us-ascii?Q?NyMF12LfsWIQYqMJPXnyRnwXUJL+xk0yrlPo65zhwWMnsOw16nYfC5N5prMM?=
 =?us-ascii?Q?4B07B+ic/e56yoT28G7aPxHtg+pLAIq8wC1lMikd0xj9IIXWXd20zDFcuxfA?=
 =?us-ascii?Q?2lWoT/6/MxbabTvfEVoJb2v4wmkBz9z3eWdI3berFT9viZxRyp6MzDP5gH3b?=
 =?us-ascii?Q?fkD1+q/mAOtAmaLukwzBp9Y7Dr8iUTtt5eWUYadeDCWa7H7WXGpy5oIlt2uN?=
 =?us-ascii?Q?/w4dgtWyeF7Bb3imXTbb9xdXp4qL6392i8+bqI6Szuoi+w0WtHIetzI8qnKj?=
 =?us-ascii?Q?Dqqe0Cnr5QLTUOCFvSqa/bCx8Z79LkHxTYUIkc0E2D76lHk20c5IO8s5JOiA?=
 =?us-ascii?Q?EPEpAn5afYfs/GgXZzHVCuer/EnN/CfDYJkL3qy3wuZyBrLSzRCdHzbW0Afe?=
 =?us-ascii?Q?zbYOx2e8YIYZbuIxz8ZL8slNP+70q59MHQBpGMAfv8zi6OOGaDAl4n+3ZDcC?=
 =?us-ascii?Q?4ijvOCSne2ra4FthJmk+NKIvG3X5emXJm1N+U+yN8NXlKkxm0Pd6+37Jg/YC?=
 =?us-ascii?Q?DY1J2CnZTguvDppu9RQq9sWpq3znLUzYvxdyFKBRUeYP0LhEj4hGHJ0rvvRU?=
 =?us-ascii?Q?HxK//YSnp22QbqKf+zmMPnP4qATLhrUxe88W2fYrX9apjkZXM2Yb9a+w01im?=
 =?us-ascii?Q?dIMznQc+93/junkvxfpikAEi5MWI5r18+m0L2GXeuPGEhxOH90LHQBRSxRlm?=
 =?us-ascii?Q?ze97WTQxFmwIyDzfFBi9N4dso7Dpn3kQtWBPxCaFD6A4tg/hGgtYxlOCAcfD?=
 =?us-ascii?Q?A4u3emJ6R9ghLBBNi967lOayt9cBgKPFU0S2qbozRQJQBl0JGJ1G6w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dHp3gXnt9YS3R37MIr/2cz7TiPXCIwPlrDmy+vAiYUWjQvWImhhyULDhO9br?=
 =?us-ascii?Q?EjycZT+6gMEU10VED6JJaio8WXEItBl+OcVGCZ/MtSn263+6poXmj8ikMrkl?=
 =?us-ascii?Q?JiUR7KzTNCP5fRgWFLxeTjMBhzI26HA81+tfdNJHnjT8EiW2U+WRE96BFJHZ?=
 =?us-ascii?Q?iu6gtfucnPRpGN9433Qj7Q0b1eHqdKmMhxqXDiyP631kNwpHmmwhn5GWxz29?=
 =?us-ascii?Q?FSTTusbUGo8eZh92NFkopKAPhLeekzbcdzkZqnOCacPcEBtRupBdNRHWn5pr?=
 =?us-ascii?Q?V17EjntATq2F7k+mjTJqr8tUabLsAlGdHkhcSiMx2RArS/E5iSz12ASNGZOp?=
 =?us-ascii?Q?jUmK9Zqey0ssVGgXIqhNo1ne3MW9Ls6y5FFWbeTiZim3oYEZDGXbPcsvymKz?=
 =?us-ascii?Q?iMrzOlZKYeQrpUx8ynJPxbghMmDm0QICojouN/aGq8SmttW4RB3QnIW+zGbx?=
 =?us-ascii?Q?itzXMKdLUAVvwVdLEsRCmC/x6nvfXZVA92nJJSx5v6LjiX+K9eU64B81WFdR?=
 =?us-ascii?Q?wWRtFmmZ/eRxWaHyVoDfuB/JAT7omZ3Oy7u/2kevz9mCuuQxEph+mwMFsZzv?=
 =?us-ascii?Q?CzIiLcxHnF6BQ+Fx6nymEyaEQVTnGz2HRpclEWwQN1YFA/HQTAJnr6B6hPb6?=
 =?us-ascii?Q?IB9N1GS3xLTvb61+yy5FBIVWJaC7kn5CbQxNmgZw0tt0w63YvUqO6KiDW4gx?=
 =?us-ascii?Q?dTLb09KVG00Dv/ZIR5fj853K7Rko/j5Z1R18D5oBX1lKLXd3pLlqUWRzGIQT?=
 =?us-ascii?Q?bSjWtv1uxHmsT4/BItsOVpCQk/IxzWt2kmkSViM94rSh/pwmxLAss2FeNidE?=
 =?us-ascii?Q?5R0ZgEG/AgB69Un9dCTgbfY1gIkNNl6dUkUTlCZ0vQQHKWEjx46MAvDXffJd?=
 =?us-ascii?Q?MKYhX+Ke1Iql+ga5/0TUUwhY7vmh2vPt9c39WBO+iTW+yReSV5mrHSF50k5B?=
 =?us-ascii?Q?+jxxljmEbjqFvrkROCJ0x1VB3owvjCA6rkDLwEbNd4PiXGn3ZbboP4P+WbyD?=
 =?us-ascii?Q?IWwTa50gCliqDvgp/gTKpfHDTQac2OpNvgkG39DXJn5IZWdzntvO1OnR8+wO?=
 =?us-ascii?Q?OiMNtuJN2sWRB8yJGb2Sn0eNiz38OJ21EgSbHJ7XH6+5wL0SVNuv0z0jOjg/?=
 =?us-ascii?Q?/metqOaCV6LkRwjq8QCqxkNYHJsbHHl1yXY1AMxAtEkvpZ1VOYEiKcwotCLx?=
 =?us-ascii?Q?JPvp5lnFLbG/jPWr5akjpFA0COdtm+tx55H1IL05Ianmgv6cihwi3z+IZ2tH?=
 =?us-ascii?Q?9jk6xphWeiohhIIMwAcWRklmXv5sn68hVbKw9c2Pl+dx/ZYKzK9autBjU4a7?=
 =?us-ascii?Q?/ZBGkCU5ibSCPd0I0cG1lQYgquswuvdDNJeJijGe0tifjGNU2exhaVks1Vro?=
 =?us-ascii?Q?3/S1nZ5D5rl87EJjeIACHsV594xvl+ab214qpAyhsI+rqeMZCLtUnfggg2N/?=
 =?us-ascii?Q?GOjZybxsBtvaXvgJNLZCnROPWt9ox4stJBxZa6OSXvDmGaeEsc56aHxhLqKY?=
 =?us-ascii?Q?BIG//6+322dUkFrbgYZdpM0f9AnJ1DugWHpP39Jw3pRNkCH3Ed4cNtJfiRRd?=
 =?us-ascii?Q?GEMPhD0xDt4WI+/cbghHFodcJK+bGDY9Mz8WJI6fVRdkPUh979DUx7FA3OIS?=
 =?us-ascii?Q?TFA8abR8FvA0mGdj0vWP9SOXecPjKEIe+Fu+fXqbio4oLZoCPHNQ3UlwfWjE?=
 =?us-ascii?Q?97FJmw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f71ce6db-33fd-4197-4adc-08ddfaa8c022
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:54:44.3014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33ZrhETAmazQeuXlYN9Xs8XiLxSLxs1d83hX/yX1mGtUy0Rq6Q/q1YaorB4vn+0/pGTlCqhGs4i74oJmR55V1c7HS5ShOUPAVWifdQMbmU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7742
X-Authority-Analysis: v=2.4 cv=C5PpyRP+ c=1 sm=1 tr=0 ts=68d2a6a5 cx=c_pps
 a=/amG0fyRPKkAi6MGe1IgeA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=Dh56xV8-9bS9yBysVCYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEyOCBTYWx0ZWRfXxigcAcnkxM6b
 qh/Ib6yIYrnlgHpOWH0y1bluTM/NaLAcScTL0fj4UkeQ9XCMQY3W/xIibZUQQYxludAW7jTvxpB
 HGfg3AKRTAJLdeicKe304uhl3sMyeJyjpTkQYp1WikbGclKqdM7RT/s6UNVLekgM5fjzWU8UaGZ
 Q0K1anRW6kORxhgu8bkedL2BhTg/CKJ9ts7Ykuty+XgW4LBgssZAQQEafDdPktBezy5dSou7cBt
 3IIJcLIlQO4dHPUoE1BiH/pHeEmYjOQa0TgDvHr+wdRLyLmHFrY2ov3NtCZBU2UWkmyQNvcpzr5
 4wCWqjz/xgDJr+dlMi8Jol1kwqCS6FEZeBPEFGoKlH29eVlRxNt+ATnXv32vaw=
X-Proofpoint-GUID: JSdFv3SpIg0QjNK-rnrMyzlovnPQSMH1
X-Proofpoint-ORIG-GUID: JSdFv3SpIg0QjNK-rnrMyzlovnPQSMH1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

This is the more typical naming convention for QOM finalize() functions, in
particular it changes the prefix to match the name of the QOM type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9046244e7f..020e611748 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3554,7 +3554,7 @@ error:
     error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
 }
 
-static void vfio_instance_finalize(Object *obj)
+static void vfio_pci_finalize(Object *obj)
 {
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
 
@@ -3921,7 +3921,7 @@ static const TypeInfo vfio_pci_dev_info = {
     .parent = TYPE_VFIO_PCI_BASE,
     .class_init = vfio_pci_dev_class_init,
     .instance_init = vfio_pci_init,
-    .instance_finalize = vfio_instance_finalize,
+    .instance_finalize = vfio_pci_finalize,
 };
 
 static const Property vfio_pci_dev_nohotplug_properties[] = {
-- 
2.43.0


