Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C2EC3ABC3
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 15:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCgaK-0004uq-6s; Wed, 07 May 2025 11:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCgaB-0004kU-Ta; Wed, 07 May 2025 11:21:15 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCga7-0005sW-If; Wed, 07 May 2025 11:21:14 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5478jQk5030157;
 Wed, 7 May 2025 08:20:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=PAO5ZaebVeLqx2qfx1+b245+QW8C9u0fO2l8Yl4nv
 sI=; b=h67Rb2SQGCbflGp99bpHzflVbVmuUt6bqaqbeBwog0yqSgUUlYkaCQ0Rd
 75TyJZS6ZEtSXe0ywSSI+Tx9isW5AKDbTN5Dxz7oq837AIDZm5gfpJcp6WpTjXnO
 lISVAJ5dwba10w6rRd8FQYloqq6SALCZDVaNZU6AUtfVjVnR+v7OzF7Ab/XF8aBa
 cq1woZCnTFKz4amsq8wVc/frPyRDIrQy+ZoXLQvGLmUNqZ9LDeKDPqGduuyAaAMl
 SKdbKg+SZXHNWodnjh/bnzNvKsWuXZCE87l0VaizOoP7pS06h+Ai3amBUJ6VrVUE
 RRb98VexG7Vs9MsQTyVSp5z2BESfg==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazlp17012015.outbound.protection.outlook.com
 [40.93.14.15])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46dgp91ek7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 08:20:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdLBmqVzQ8kAZcd4U5Orf/JDN9eMCKjb9s/XD4Hc4iZ4dKTGlzRQO+RKvUsvdezEzS4JfZoQNElmDUNLrEpS2wtRHuvc4MXAbKGduJRmLH/fj1WjyWOHrFK/f4b1n24B57P2j0p0fNgmfEm+AOXSpRzBVNuiDgNO8gritTiLcXftLH9+vo1ImYrawgB9YY9epczqKlXSUpsa3CeHShnC/8i/XPlsZ1jxQPTBt4Da0ZQhBGCBcTxzMQlwavsd8s59QGJDE1vI2ZfTT5OYFdglGKpPDeJQILZqNNdpw8eXFYx+Ss90YI7N8muEhjwJyUFD69gkLJHo7lucCeLrQfpszw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAO5ZaebVeLqx2qfx1+b245+QW8C9u0fO2l8Yl4nvsI=;
 b=NWDNFKDsCrFKQdGkTY3KVL/3Eni+QtI2DKXm1k67zPUYvFL/7KDxbplUB9MpwbrVAlgYJ8jTKVhgMhPm/Q2COOiOdoZQcUEoZNcw/JTMKT+DdTf+pa3IVPEa7lW5cnYIElyuuHOhcRF+ecQgzuH+0I8kmziHgzGfnFmVeZxou4GGHXnMfxzs+Ps/J5LvlVB+MOKkLgH38DKEgASUKhw16utVFdpSCN713zfccudBvPXPbya6VT2WSV7EUdKO2TApMCqszlKjc1F8Qqasx35uRy66xG4SZAm1sx4Hm5EV5njLDwBWAfxbFtoiMyAfH1n/fC8IfosoI8QtPRQtcCdV5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAO5ZaebVeLqx2qfx1+b245+QW8C9u0fO2l8Yl4nvsI=;
 b=OjJnp62U6cvwoZQnskAXghhgHUsSSbwFT2TSSA9OZSupJ7g9WRNP7fUFkS9iyJw/2G+1z280SDuEjpXQg2UIL5175kCiM2vBmGGtnJi3cDl46yYKCjW4N+6P4eTNx8stLXPV89zKPwhrl6brFGC7wnbehw2CrzpvN79wyVGfzdtnCxUiBlwOpKA2VsHD3Q7zWDSzNqKfdedaUAcKkVi+GsHLCcPO8A+O/KBTb6GvyBq6OA5RZhISEbDNDzimPCPlQ/He5VHkQmYaTzb39g/KDdN6MmqE9frZGJfrs/wraA43/bkYJx6GexuVomFWghQeYav3Yi1/2ZomZAYaAqXXRw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BL3PR02MB8220.namprd02.prod.outlook.com (2603:10b6:208:342::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.17; Wed, 7 May
 2025 15:20:53 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%5]) with mapi id 15.20.8722.011; Wed, 7 May 2025
 15:20:53 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>, John Levon <john.levon@nutanix.com>
Subject: [PATCH v3 09/15] vfio: implement unmap all for DMA unmap callbacks
Date: Wed,  7 May 2025 16:20:14 +0100
Message-ID: <20250507152020.1254632-10-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507152020.1254632-1-john.levon@nutanix.com>
References: <20250507152020.1254632-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0055.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::22) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BL3PR02MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: c0dd14d0-4864-4d64-ab3f-08dd8d7ac188
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?157vi83ofh901G3A+70131jIGeVCDo9bpfq/RDH4+2QCx5VV5tp1a6StgKcf?=
 =?us-ascii?Q?VPJ5W/5VNIDaCj8NPBRfKpt493nWVmtiVHxTiexvNIQz10l4+9huISreUFgq?=
 =?us-ascii?Q?K3Zb2PUTUYn6Zaq2pcnbElZ7yU2lh3LgcDCpepzP6KYlD5eCPEUGb6Y5nnmA?=
 =?us-ascii?Q?kh83jdYMF5qC1+JzzQbXh7YVcritmFJeuXTmd1uEDVWK3tSt7wP7tJQbNBAF?=
 =?us-ascii?Q?ZmFS7aLOtYBSAuoTM4DlV3t/AY0tPFUEQMwa835mI8TOw0JdZxRZQDpQj16f?=
 =?us-ascii?Q?HEadyFTL6q0FXJEZqZsiMoRQk22FihxOW35V8RNBKdUewl/5+6FyiRsaFprH?=
 =?us-ascii?Q?ZZqB85M+rXaYvPuIx5603JANo4J2jeobkSqQPdVsaoxPkltE6cK/hGdsDmMD?=
 =?us-ascii?Q?ec69KtAApZkx1wkO1uGpjtGTSJGJL5VzrLO3/YkNod6bXr5hw2ounUTJAion?=
 =?us-ascii?Q?OeWdQI+d4yVM/zuU+IR+PswrbZd4XNenLhXGxluku3qfbwp5IvDlqEsiFda5?=
 =?us-ascii?Q?79LF6y0zxrCoQDulZH+j9a/0AQKXwLwYx3Tj6r0D28GrttyjlXX7DBVGj/b0?=
 =?us-ascii?Q?5v6/ELbYbaytcuEBXvYkcWRox6L5RcqTKrN97hSKx693Ncv/gAcUHSDa4mW2?=
 =?us-ascii?Q?XoozAW7Lx+WwvzpPWoV5nkTJjjoO7dBlvkbzXnW+E15b2FZeAhjr7pztChcG?=
 =?us-ascii?Q?/XgX6778ShDmHqr6XnVYY9eLVnoVt9UjKD77gt0Q3LHINjeA/ZH2LoapjiIC?=
 =?us-ascii?Q?GmK7BXHRkG44ZTNoDLABIaF+AwLaAJ8zv4fHvwWQIZCXdO6RqXjBwZYtOuTi?=
 =?us-ascii?Q?JH6q2gSUHI6LVkJY1Grd/kR4wOebYZyuoRQIRyKY9NhvP9x6xKN5TjQrtizd?=
 =?us-ascii?Q?idRSB5cF1CBPR7dFJi1q8d22QwFfeRC58DQCYg6+knjl/fkI+vu/sL+F2TOe?=
 =?us-ascii?Q?aaK4tG0ACpOkw6wPt2SrAWV35rNEU2nl8dkcgk7m3fiKdnmCcddDrFbxFwmD?=
 =?us-ascii?Q?Oh+YEa7YNcFedP0hH+TSOyh1Hkdf0r5Q7szcTUTw8SDzd9VUKScz7DYVwqc2?=
 =?us-ascii?Q?ub782wNl70Q2UWf36Ct+PAyUDvn30SrdzHvtapNMbg16il/2WZHJJAVh3zrh?=
 =?us-ascii?Q?CcP6kJnU3sBteMlhiqFXQ5qLh/rYxTkX8CrdCcEbVt6xTRGWvcndKV8/4AHm?=
 =?us-ascii?Q?1LDT0giQs1V6ClkFSeq3CCkeeTY+RLB472Tt8CfOk/307cxLngt/0b5qlYju?=
 =?us-ascii?Q?7MyT81FBpHGkiqdxRjJnCAHqo0IgPZyymhtzNUjUNvF/4og/TIpLgy0rjYKW?=
 =?us-ascii?Q?yf1e8ALd5B0vg9NKWuSkIkc94NLEh/YdBWY6bMOih2rKEjtIaz4ktutYnDbr?=
 =?us-ascii?Q?fFFsZMv+HMJXIiAJT7UP/uC2oEuVIVbOi5oVm5XcuvaCJkRt4gJCZyH7b8II?=
 =?us-ascii?Q?WGrinAxbuds=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UnNI1Z/6TSZlLcbyTkYvLLnVFrzg2jmf4IB392pLLAwj7zxKTS4MXuGAYXTQ?=
 =?us-ascii?Q?ruM6DCfbXs8eYE/pmoVDGr010J58g/ihEtjUr15ZxCPzw9VqrjKn/iZvVCW+?=
 =?us-ascii?Q?ZfuDOifdy6KhfpCGdyrQR1t/v/BbgpsQjSlm7FxPobrJKjCyThmfv6OiErQb?=
 =?us-ascii?Q?ozBZFN3C0U6oxQCCEYxc+XmNr5bu7TXWYfQfiq9uqZyPgMtBwqsgzB9LmCst?=
 =?us-ascii?Q?lh4RMMKu2YeiN+N2wj5y8pQuu0lfXMjOvOogWY9awCFYFYRbYNEubtP70+Hn?=
 =?us-ascii?Q?eIWes183fa8QAsl1JlOfPophArBiELG/ooDMHn9bxU9uwqfpd8DhNMMkEzJN?=
 =?us-ascii?Q?hWIKmWYEQimwQc5wRX8EOXT3lniz15B4fvxNjG6438eo4QuepHdtcBYR7Ssm?=
 =?us-ascii?Q?yzao33vkplyuC6w8MynEoAYTDKTSBP/G20hNRSgdP8f/g0jHxMZVzD6kcVBQ?=
 =?us-ascii?Q?dyGtikJxgW8DCyO8iNTAxph0uZ/42LX1UPYIy95u3zqYNK8xPqHUJlj1zRty?=
 =?us-ascii?Q?YoayKOQKNslfFCcJ4wVnGY4t9RTWqsnLo3nxwmHhcd3RTgIZOuLv1bZ6X2wS?=
 =?us-ascii?Q?fGbFqH4NFAO+SByemET97SMf1MolMinB2Jn/WzC6IhGNFi4JcManZ1VNHVSo?=
 =?us-ascii?Q?85WlE18+2OrB+13mk+1vagCmkfnTTDtsJTTL6zsA9fY0q95klh/TmnNL3GIt?=
 =?us-ascii?Q?OQeQonsw7v3JdRvu+hrzYkYZ/US4sPR/WJMF2nA6WP0ZZQma8Xudo6fDmZMo?=
 =?us-ascii?Q?oCgk4Z7VJArg6V9Zs9yLCA7RKqMJfPIcp0IL/g+55KZY59DxUUCDhyXjn49U?=
 =?us-ascii?Q?92W1VajtrbZGoVeZrwS7bVrZJMQfH9jhUKpHEFoeyfJhIihitjCP5qYVlePS?=
 =?us-ascii?Q?NRs1VpJ6CBaBiaoXD0i3QpNpYwUd0prKoxmyZgpHza0VI+87vBkysUYzbLR3?=
 =?us-ascii?Q?5MegJaDuRaYbS36f0P4BlLEfTYG9ZMadfIlc7GNMptHHz4KD5sltDFIfoaod?=
 =?us-ascii?Q?LMpocVoiM0itYXzjFG4Xb41mFVQrn6NKTiTBvoCb1zwQRzFxmWA9Mfc8ujJ2?=
 =?us-ascii?Q?DtXjqVLKAuoTclKh9YOX91TVuOxFoz/sTuSEsdx6j56PNg3KoO8kfcUhZAqv?=
 =?us-ascii?Q?Pw72cIqVDMWa/+CmjHxsPGZIa/9TDx+7YLVyBEb3QaAyUDpuK7E4pKTjwDtM?=
 =?us-ascii?Q?ESzRSF61P03N2GEAHpwTP54lpXNBdb9XoDOboLrllNKWuhaPohfR8jpERPUL?=
 =?us-ascii?Q?UWKFg4xNt7oSBqmE7vsKZfprpgY4A0oF0hqLwBZxtJ6pFYLSQqLOQxw1EJXL?=
 =?us-ascii?Q?zkTGJ/ZUBu+gUjJUbCQ+apQGkA4VcMMfJ5VO1gU7yCH3qNZVOgrevyE6Z2aB?=
 =?us-ascii?Q?3V1Lz/wtVB3pIsHRihwgal6Drc5294VCJu8VXokMuCInahMeZSKGj8tkRhCQ?=
 =?us-ascii?Q?xATt+wTTE6a41XlFMoXBvTIgYNL/kzhGbKPl0+BbTUrJBxQaleUECui679na?=
 =?us-ascii?Q?rFR71e2TFLD04x5z6Eov0cvqc33MB5PhczvI7Q6SPN+vAr8JZ3LXdvHhigDr?=
 =?us-ascii?Q?LV5d8wO8wH7GzAkdlDEt91lBWlmGa2T4jXFbpR2s?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0dd14d0-4864-4d64-ab3f-08dd8d7ac188
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:20:53.0202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHF1IaAwJ+FWxNiDsN6WZD4Y5I8Ibt2LtiW0NPYYVpmFG/NLvcOR37zhkQMzDSbsJAEG0iX3lkIkAYpxx012Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8220
X-Authority-Analysis: v=2.4 cv=R6cDGcRX c=1 sm=1 tr=0 ts=681b7a5a cx=c_pps
 a=/gCfq7Ne1cdKKt0NGwu3qQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=q38O2AW38pV3Lvc8SEkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE0NCBTYWx0ZWRfX9O6EVRFxHX/K
 6tS9Q9OChpKBKdj2hbD7TQw0Ca1jABIqYj4Y12euXYU4T29J6aAfETr05wcAzSyHwt45tJFrdvZ
 Rd37cfqwR0PL4TldeQ3uqgW02oMzhhHJb5/QSGXf/Shf1P5v7373iRnhLix32+FpcZOu+zKcvOh
 q+Li4aojZSn0fi8lCApLAhesKNOjdXPsa56ZYMNODmOC4Aw0Vl+XkLNKILmaNByS9/kuX05kf29
 o8m3s9K6GnPCXMmYAyyvuvtchTnN+WbkqUBC/mvF8HBeDERuT9Fpfd7y1MQ7ZPC2WAqdYxucKBS
 UOsOlg6eox9kgYgxQHsHd3LaQFYQ8bSk7iLDP2TP0d/Jhwy+4MfJNZ2qSrI8oaIcTJjmj6yrwnQ
 gEg5lMt8AgtZqeDW51nQC1tmB4aj5CS1WwfutFQFsWVSUDm1wu0dP54bsaDfuK/Poy9fuPcF
X-Proofpoint-ORIG-GUID: jIuhTR15-4bm_KW9heIF8jV1Of57ioYa
X-Proofpoint-GUID: jIuhTR15-4bm_KW9heIF8jV1Of57ioYa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_05,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

Handle unmap_all in the DMA unmap handlers rather than in the caller.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/container.c | 41 +++++++++++++++++++++++++++++++----------
 hw/vfio/iommufd.c   | 15 ++++++++++++++-
 hw/vfio/listener.c  | 19 ++++++-------------
 3 files changed, 51 insertions(+), 24 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index d5f4e66f1c..a9f0dbaec4 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -119,12 +119,9 @@ unmap_exit:
     return ret;
 }
 
-/*
- * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
- */
-static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
-                                 hwaddr iova, ram_addr_t size,
-                                 IOMMUTLBEntry *iotlb, bool unmap_all)
+static int vfio_legacy_dma_unmap_one(const VFIOContainerBase *bcontainer,
+                                     hwaddr iova, ram_addr_t size,
+                                     IOMMUTLBEntry *iotlb)
 {
     const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                                   bcontainer);
@@ -138,10 +135,6 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     int ret;
     Error *local_err = NULL;
 
-    if (unmap_all) {
-        return -ENOTSUP;
-    }
-
     if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
         if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
             bcontainer->dirty_pages_supported) {
@@ -185,6 +178,34 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     return 0;
 }
 
+/*
+ * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
+ */
+static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
+                                 hwaddr iova, ram_addr_t size,
+                                 IOMMUTLBEntry *iotlb, bool unmap_all)
+{
+    int ret;
+
+    if (unmap_all) {
+        /* The unmap ioctl doesn't accept a full 64-bit span. */
+        Int128 llsize = int128_rshift(int128_2_64(), 1);
+
+        ret = vfio_legacy_dma_unmap_one(bcontainer, 0, int128_get64(llsize),
+                                        iotlb);
+
+        if (ret == 0) {
+            ret = vfio_legacy_dma_unmap_one(bcontainer, int128_get64(llsize),
+                                            int128_get64(llsize), iotlb);
+        }
+
+    } else {
+        ret = vfio_legacy_dma_unmap_one(bcontainer, iova, size, iotlb);
+    }
+
+    return ret;
+}
+
 static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                                ram_addr_t size, void *vaddr, bool readonly)
 {
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 6b2764c044..af1c7ab10a 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -51,8 +51,21 @@ static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
     const VFIOIOMMUFDContainer *container =
         container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
 
+    /* unmap in halves */
     if (unmap_all) {
-        return -ENOTSUP;
+        Int128 llsize = int128_rshift(int128_2_64(), 1);
+        int ret;
+
+        ret = iommufd_backend_unmap_dma(container->be, container->ioas_id,
+                                        0, int128_get64(llsize));
+
+        if (ret == 0) {
+            ret = iommufd_backend_unmap_dma(container->be, container->ioas_id,
+                                            int128_get64(llsize),
+                                            int128_get64(llsize));
+        }
+
+        return ret;
     }
 
     /* TODO: Handle dma_unmap_bitmap with iotlb args (migration) */
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index c5183700db..e7ade7d62e 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -634,21 +634,14 @@ static void vfio_listener_region_del(MemoryListener *listener,
     }
 
     if (try_unmap) {
+        bool unmap_all = false;
+
         if (int128_eq(llsize, int128_2_64())) {
-            /* The unmap ioctl doesn't accept a full 64-bit span. */
-            llsize = int128_rshift(llsize, 1);
-            ret = vfio_container_dma_unmap(bcontainer, iova,
-                                           int128_get64(llsize), NULL, false);
-            if (ret) {
-                error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
-                             "0x%"HWADDR_PRIx") = %d (%s)",
-                             bcontainer, iova, int128_get64(llsize), ret,
-                             strerror(-ret));
-            }
-            iova += int128_get64(llsize);
+            unmap_all = true;
+            llsize = int128_zero();
         }
-        ret = vfio_container_dma_unmap(bcontainer, iova,
-                                       int128_get64(llsize), NULL, false);
+        ret = vfio_container_dma_unmap(bcontainer, iova, int128_get64(llsize),
+                                       NULL, unmap_all);
         if (ret) {
             error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%s)",
-- 
2.43.0


