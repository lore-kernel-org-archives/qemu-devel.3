Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35196C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOXl-00058v-Bi; Tue, 20 May 2025 11:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOXS-0004XP-1V
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:54 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOXP-0002nf-6B
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:53 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KBaTfg018814;
 Tue, 20 May 2025 08:05:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=CXd2NeK/ET6uD8gmkhbk2vh4nYzQVltKbqv/Wx4cy
 uA=; b=ptsdOFMBAZTS0NsjR/rah3CbI7VRqVPaNufgn3fYttvN6YppL/11tH2Nz
 ThknssiB9rDjPeIiqCvPW1cmUq1n4jH/qKhIKaFcI++FQky+hdRIORW1yB+B9N2g
 Qq91p9zNjwyAGORJUBjTJnt3lQyf3ajCmbHZH4hTK8SALvdr6+abAN5xEpEftolg
 SqHR8z950EGuJqsYL+K7tg4qzE4rv+/4F+nAeAtkIZULhER8izHp8WfxuBynaqU5
 LO22O4sDiKv7ewnWIQYa6McWufztd/XT09WbnfObMT3maacIBa4IUoWQ714u1qRB
 L7HsHiwduLrfdl6eBNJ80wesqsWyw==
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46rcm2hygu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:05:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xy50z93GvxBkmisWdtGUUDmLCTCZz0UitFbx965xLL3wdNr5UwlLLtvF/i+UVOWb359YgVC3xtcs7e3fQkD935Vrr8V8gy892NuITjpIozgZKvkMhYNFYPIWcIytgQvPAEQJhqEhFWZTUbylzYz2xyETZRAmMDpf5t6cY2sN7s3GUteqcz2+pmW/ef0HEoO0+4171nCS+lfUQPBj8PTr/pOlhmgiMJirdln77sh23pSWRD69ry1JiW1/RDVE7lX1VvxZ8hkClyYonYQHnHy+OfN7iJIOnlE+j8IgaZnXcAIy9Ac6n9zHbGeJV7wKG+OkBljz21b9X3l7IVVBiUzFew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXd2NeK/ET6uD8gmkhbk2vh4nYzQVltKbqv/Wx4cyuA=;
 b=Fvl7g/ciZ96K/1sCMrGMkM8DlV48tLapbw0qzfB0Ql65Kda2EMr20go03wuM9P1jNd8uyoInEj5ha2V9lFiUbhdHZqaL7GW3luIqhouVZAyG6aReChrJF1GLbJgeW+Ach2EqtuPYHlWOjmEGZ1jZRZz9cUktlkI1XbLcRuWjXsAQfn9c55sRK+GfQ9pbEuFwOM8TPEMK4H/O+w3S8NSWyz+LmL1P7dngqo0FyrZ2i5Pxx1gMHJUgETufeVRdFz5Nq7HwCSiWHZLFdHsKoN920THe0mwATmThVKg6j1WiSHaDqQ1JMPr4ix0rHFXQ5QFic60pgenSnPfzk2JF5EDpyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXd2NeK/ET6uD8gmkhbk2vh4nYzQVltKbqv/Wx4cyuA=;
 b=p61tleRs14gutYRODXNeaxWO2dGaS3l0U32qoKwRroK/eiojq+8lUlzNb48FuXobr9V0+tKhamEyVPNdYB2iMuYSyp1lCWEl7ydtnSdZqMKnzp0OCv2vpjVnzKLxhQb8ILLgm6nf+8BIFQlCpyppV+C1GBjBzp9+9Lei6eOJnvub1TjRB2Vh7BYxee2YIIrDY6fvwHfkOV6qxE39/VqDn/WAo1aJIOz880tm3HzVtC07GFZ7fcJRXt1BmkyOGde4+YnTHGMfwX84FDLoY3mP/zo/T1+FzqxRK4x5jKdXnw1Ggn5nHVCufB8lGUSgzkU/t5vTe7rlzIGvr3q/hF/SVA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8582.namprd02.prod.outlook.com (2603:10b6:510:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.23; Tue, 20 May
 2025 15:05:36 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Tue, 20 May 2025
 15:05:36 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v2 28/29] vfio-user: add coalesced posted writes
Date: Tue, 20 May 2025 16:04:17 +0100
Message-ID: <20250520150419.2172078-29-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520150419.2172078-1-john.levon@nutanix.com>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0021.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::26) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8582:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec7456e-32bf-40d2-ff5f-08dd97afc64d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lWmohK0NhlF5psuiWK2vSAy1xcNT+V5vrtXhTatxJWwnzM3/81vJIGWDR7vQ?=
 =?us-ascii?Q?dPX3nGXVTAPMq9cf4V5gkyKJPkCIT12NQ4s0RVlMnf+rHVZKjoBtbmbtOgjA?=
 =?us-ascii?Q?Y4eidSh+BSJa+OgGHRffVA+cMS5Gk6gAcoEpcb8c0Yyf9a2giScO5bmrijVn?=
 =?us-ascii?Q?xN7c3uk9PVNwm1EZN9YAlQO4i74OlSmakjnaPVWuORha0vhlcW9P+wDeZcnl?=
 =?us-ascii?Q?nzUA/Izlk2w2TE4m7CFuOXY8Bm+2FDBQ1tVlU72noauwyuVL0Rk9eZ/g4J0R?=
 =?us-ascii?Q?7pCBgIZ/ZlbzDDbvGibts7tk+RKQCDq+BCXmhdSlH5aFilSRbjQLBC8J8z/o?=
 =?us-ascii?Q?ipdDiCrXZUZIHcKDKd61/U/uW8W5yspVqnWY2AiR0QPxbjJOqYx/DdzU/tdi?=
 =?us-ascii?Q?PQj+cSONsz8Cx5GtCG1Ww1mfXDlA5GKePyXiPGOGlAcOUYv40iL7wWl4+o+6?=
 =?us-ascii?Q?WHdnirzC3NsX32nuzdhr51vOMZgoVYUCe4/qmm4EHyPd+Zryg+sgn3KrHYi7?=
 =?us-ascii?Q?z4rF5ajDv9v2nwzA3XCUunZEzVY8D/2VkB6M2DJq1KZMml8zA2p0zt1bO6Ot?=
 =?us-ascii?Q?kCsyY+D/hbaC1D2l/LSTtRdYf8XqYzgMV6jjLAEDuNsX5ugLko2G+6QkTXzk?=
 =?us-ascii?Q?kQl2qO9BoAvCacRyNpcxXS90SYQ19C2MR1KgtYKSAMznaQ64N1+CLsUmQBIE?=
 =?us-ascii?Q?P/9KYyOlqMVe2r4XRSBoqY/CgQa8e/RQNrQhtIfqVB7HfC9RxhAlnF362MLp?=
 =?us-ascii?Q?/hPlQ+SK8tl/CzfOzJMkpLfFvneMmN2E4VzSTFxiwbJMb1E5kLd3OxG6RXAe?=
 =?us-ascii?Q?zkhLizV+7IZtXGSrFGvSWSPXNSCG6BQF/jKvZip69Q+8ln7iHAfKoisMUd0s?=
 =?us-ascii?Q?8CUX25VSqqkMnpNH6UZjwJURTD1BAHeqFB2Ke+AcOoMsCjuWpACdta2GzpMU?=
 =?us-ascii?Q?3gXLRlwQ+xeQbwgAn24smuM84eYq2Y/ByGFf5HE5pl/QvQLZvG45kkda3NR2?=
 =?us-ascii?Q?Z3ToooHsuVVnC/NLuoZKNCE68kftRxQFuPPh1O4EiGgaNU1Pj94jrlXcMVta?=
 =?us-ascii?Q?asZwzjdiXIPw7MmA8incZ4U8fPwQy5XyJKaBXzcDHzSiylkN32Jvzk7bWXxg?=
 =?us-ascii?Q?akEM1cKrMLe1D8zqMylA/3olX64FnhQ3APabpTndaYbTCxMBZ4YvvntZtT0e?=
 =?us-ascii?Q?A7ZqdGyp/sTPytwqT0etZgAX6D6+lkLmV4lL6v4LHpgCEqtOk6QcHDaa/Ecd?=
 =?us-ascii?Q?a62OVf1tjd5S5F5XQiu3uoZaBa+OJqN5dbYvJZZDNumzf34XdLFO4JrpRmyC?=
 =?us-ascii?Q?y1q4x61+01z/2TRncnr5N1Sj1g79ItMHx4Rqx9UNfQObJ7j9n6Y1OvVZgJC2?=
 =?us-ascii?Q?wkLMO3tLOvkdh8LDTgpTHFXUABYD/hGx6OKNnkXCY99FcZQvyg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sWeFPF6jzOqZ44Grq5Ox2dCK7MqPV5KlHaxCwYajXK5Z01dxAlyHLDTy5UTo?=
 =?us-ascii?Q?rmRXpFu7Iw5jGt5Nbzp583eFiBoTFa5F9JpmJq+b3RTuitht9jG8VQJVhj2c?=
 =?us-ascii?Q?Kh38x4+PQgEDpge8pL+SJBwTFzmG5V+RiwrmZh//4/E/Pqponlaa+86+XZ5r?=
 =?us-ascii?Q?9PvMp3Mn2HpT/aYXSwuBLBZlN/xoYwUyhcwelpqzIVXUzZ1xucNRhVYNBXBO?=
 =?us-ascii?Q?PU260TaacnQPvGIHhq0VrtYNp+GHzzvDyfOCmIcAYZsq1/0mnv17RVpV/HsE?=
 =?us-ascii?Q?MIckyyD/s0HO48mIqRr4Je5vd0PCG5Mk5La3aZ5CKNd2Um70PxgU+Aksdokg?=
 =?us-ascii?Q?J1BjTRnbilPykhiINIJcmVcGCqR++tUUffwzQe+8MYakmJBUJxEksc3flXH7?=
 =?us-ascii?Q?evuMeR3xmKLY9h+qVM7fZRIrIvckUmCUnyuw9Fwhybw/oZNntlf5ntMhNIh0?=
 =?us-ascii?Q?A2anLqFjrrMz2MNb7C8gLr978XpEV+kHLW/2InF76P/tKUs/6m3qnDEqiIG7?=
 =?us-ascii?Q?nei787stgfBfeVCi86AOwbe9bB1L7AdiKDOMCZkXXKwULsmfeYHXqS9D1AJC?=
 =?us-ascii?Q?cOezJqMhAtznKUaNhP86R1jV+t8BSDV2ZC5Gk7yYyaHASdcA0I1FRmtZz6qw?=
 =?us-ascii?Q?hpYItiq/lRR4BSym0zbYFDJ7sg53mAvR1TCQnQW3ygp6VTRH0OgxiEmcgjTN?=
 =?us-ascii?Q?P2u1IzacRdK6vqtVZJ/IWt1Y9RkqXJKBqHQuLgwrTZL7x1PfoaMevuqCcpQu?=
 =?us-ascii?Q?eHD3UM9BWDQzA1QGPFeygxS4MDnpZuw2TXKziSI1Hh/cLK2Y7j49kwBdGAZS?=
 =?us-ascii?Q?j9IHsgZx5m5cXt2lbu49Wjm091zG+a5oVA67Un7e9NyJHtD7jXReKHEEI/wx?=
 =?us-ascii?Q?NaUecnJz3XRyz/1EJDXfiCM6YvWEptajdIn8tvb8yRy5tCNV7A2X2gDyhihU?=
 =?us-ascii?Q?QUpX/kJ1XN0asexcEgsfAXEyqTvwnkMfxPVKtcSoDbC/RLstFlqM0R4JjZvs?=
 =?us-ascii?Q?BN7p0HxnO1ckkH1oZyplk55kbREG2K8nx1wi92JoriHYGzgtrVpTetVyZuRL?=
 =?us-ascii?Q?z6GN7E/9u62TZ6vtSExgcgFDNeVUiKC84nXkvd9Y5iQ2YkZjNiKuanPcIhB/?=
 =?us-ascii?Q?LPXL67OOhBPXcjbPb8BQkKBYIaxz4eeoy2q4MDjSTt8/IaENMjkl2n1AsnvS?=
 =?us-ascii?Q?9Y00WyWyR5xUBz9JkK2CPX+NoUX5aBmjIrQhVYDKcOkbOmws2q4fFJancXw0?=
 =?us-ascii?Q?QCxKCELrzaUZQx4VnWJNJJpplhfIejyN1Yr+qrXcnQAt0z7GNYPojr8zMjr5?=
 =?us-ascii?Q?UMvPUCnQUwD4CZwIwgLf5uAqMShZYoULa8QIm334s7BoiDLti4IAiS1y8YxO?=
 =?us-ascii?Q?TN/SitfvkjJQcg4ZvNYkdGXXUEDN6rUO6zQ2I9UXP9ihft0BY9zLUxmEF8cU?=
 =?us-ascii?Q?qe+E9dHgc7QfsjZYophqjmP1Ic2Shr3FeMelCfsmufeIwHYqVXH/Vw6QAJ9V?=
 =?us-ascii?Q?lBSoTccAJIPgVEbtRLqvBsU18gpYc9es9AichAKV4rYWqfwvKLgnGTctIKJJ?=
 =?us-ascii?Q?B+vrFbj1Tmc+d9Nx2fCtqQtblFETKt0YgFiAFK40?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec7456e-32bf-40d2-ff5f-08dd97afc64d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:05:35.9848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdleM4H+zBAQKrKlLkpBSZictGqYckTCbGSVTVvZ/b9nlGskgWHD7TGE/3hXQ06wjezUOUJMLMiYE3yYryB1DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8582
X-Authority-Analysis: v=2.4 cv=HZoUTjE8 c=1 sm=1 tr=0 ts=682c9a42 cx=c_pps
 a=o99l/OlIsmxthp48M8gYaQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=pwxC0n7aooic8zlvp-IA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMiBTYWx0ZWRfX5rlIErOpNZAX
 dRsSidGtlc/Id5wu7hctkUt6cjbbR/W85EtXF4ilEMnGH7mT7wAGIaK+d1b3vTGMVj1hkd+c7jN
 GmK00WxwYvaV1jdPupRlV7zRu75AtyrdLYlNvrBsj8zX8ZvfmULSxazJSVHOnqJq2zCO4PJ7DV/
 McsimWgQaGCrBjs59in30GmXrAaU3EHfqSY2+SElkAA45Vjm38iO/+E+2q3IulplFwIWBQKZn4L
 Asj8ubz+4YrZ1LOj70mZ5krQiEFM/J7+JzytQ3gdFj3l5gHqbOh8nqRGQ5vNR+r2z9X5xp3ywJ4
 ix7NoknQDCy/nuugYyWuUOwHv8AKb2e0dP1qgP0bhNd+X9JAVxhEp2v4M/8C80XVC1MATVuxLbt
 bdQxs5NWnQEirt8P9XGvRB9agq33K5DDaJZUGMllDr/bBSVFiAtg9Ko5Q1kW+dI9pucCS242
X-Proofpoint-GUID: RR_TpwbaYi9KW0zvTRsDokR5WMPCbGS7
X-Proofpoint-ORIG-GUID: RR_TpwbaYi9KW0zvTRsDokR5WMPCbGS7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

Add new message to send multiple writes to server in a single message.
Prevents the outgoing queue from overflowing when a long latency
operation is followed by a series of posted writes.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/protocol.h   | 21 ++++++++++
 hw/vfio-user/proxy.h      | 12 ++++++
 hw/vfio-user/device.c     | 40 +++++++++++++++++++
 hw/vfio-user/proxy.c      | 84 +++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/trace-events |  1 +
 5 files changed, 158 insertions(+)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 8f589faef4..f747e70e50 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -42,6 +42,7 @@ enum vfio_user_command {
     VFIO_USER_DMA_WRITE                 = 12,
     VFIO_USER_DEVICE_RESET              = 13,
     VFIO_USER_DIRTY_PAGES               = 14,
+    VFIO_USER_REGION_WRITE_MULTI        = 15,
     VFIO_USER_MAX,
 };
 
@@ -75,6 +76,7 @@ typedef struct {
 #define VFIO_USER_CAP_PGSIZES   "pgsizes"
 #define VFIO_USER_CAP_MAP_MAX   "max_dma_maps"
 #define VFIO_USER_CAP_MIGR      "migration"
+#define VFIO_USER_CAP_MULTI     "write_multiple"
 
 /* "migration" members */
 #define VFIO_USER_CAP_PGSIZE            "pgsize"
@@ -221,4 +223,23 @@ typedef struct {
     char data[];
 } VFIOUserBitmap;
 
+/*
+ * VFIO_USER_REGION_WRITE_MULTI
+ */
+#define VFIO_USER_MULTI_DATA  8
+#define VFIO_USER_MULTI_MAX   200
+
+typedef struct {
+    uint64_t offset;
+    uint32_t region;
+    uint32_t count;
+    char data[VFIO_USER_MULTI_DATA];
+} VFIOUserWROne;
+
+typedef struct {
+    VFIOUserHdr hdr;
+    uint64_t wr_cnt;
+    VFIOUserWROne wrs[VFIO_USER_MULTI_MAX];
+} VFIOUserWRMulti;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 22ed66c54f..ae09b9cc60 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -88,6 +88,8 @@ typedef struct VFIOUserProxy {
     VFIOUserMsg *last_nowait;
     VFIOUserMsg *part_recv;
     size_t recv_left;
+    VFIOUserWRMulti *wr_multi;
+    int num_outgoing;
     enum proxy_state state;
 } VFIOUserProxy;
 
@@ -95,6 +97,11 @@ typedef struct VFIOUserProxy {
 #define VFIO_PROXY_CLIENT        0x1
 #define VFIO_PROXY_FORCE_QUEUED  0x4
 #define VFIO_PROXY_NO_POST       0x8
+#define VFIO_PROXY_USE_MULTI     0x16
+
+/* coalescing high and low water marks for VFIOProxy num_outgoing */
+#define VFIO_USER_OUT_HIGH       1024
+#define VFIO_USER_OUT_LOW        128
 
 typedef struct VFIODevice VFIODevice;
 
@@ -122,4 +129,9 @@ void vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
 void vfio_user_send_reply(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int size);
 void vfio_user_send_error(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int error);
 
+void vfio_user_flush_multi(VFIOUserProxy *proxy);
+void vfio_user_create_multi(VFIOUserProxy *proxy);
+void vfio_user_add_multi(VFIOUserProxy *proxy, uint8_t index,
+                         off_t offset, uint32_t count, void *data);
+
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index eb2194c0eb..79375ddc96 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -10,6 +10,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/lockable.h"
+#include "qemu/thread.h"
 
 #include "hw/vfio-user/device.h"
 #include "hw/vfio-user/trace.h"
@@ -296,6 +298,7 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
     VFIOUserRegionRW *msgp = NULL;
     VFIOUserProxy *proxy = vbasedev->proxy;
     int size = sizeof(*msgp) + count;
+    bool can_multi;
     int flags = 0;
     int ret;
 
@@ -311,6 +314,43 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
         flags |= VFIO_USER_NO_REPLY;
     }
 
+    /* write eligible to be in a WRITE_MULTI msg ? */
+    can_multi = (proxy->flags & VFIO_PROXY_USE_MULTI) && post &&
+        count <= VFIO_USER_MULTI_DATA;
+
+    /*
+     * This should be a rare case, so first check without the lock,
+     * if we're wrong, vfio_send_queued() will flush any posted writes
+     * we missed here
+     */
+    if (proxy->wr_multi != NULL ||
+        (proxy->num_outgoing > VFIO_USER_OUT_HIGH && can_multi)) {
+
+        /*
+         * re-check with lock
+         *
+         * if already building a WRITE_MULTI msg,
+         *  add this one if possible else flush pending before
+         *  sending the current one
+         *
+         * else if outgoing queue is over the highwater,
+         *  start a new WRITE_MULTI message
+         */
+        WITH_QEMU_LOCK_GUARD(&proxy->lock) {
+            if (proxy->wr_multi != NULL) {
+                if (can_multi) {
+                    vfio_user_add_multi(proxy, index, off, count, data);
+                    return count;
+                }
+                vfio_user_flush_multi(proxy);
+            } else if (proxy->num_outgoing > VFIO_USER_OUT_HIGH && can_multi) {
+                vfio_user_create_multi(proxy);
+                vfio_user_add_multi(proxy, index, off, count, data);
+                return count;
+            }
+        }
+    }
+
     msgp = g_malloc0(size);
     vfio_user_request_msg(&msgp->hdr, VFIO_USER_REGION_WRITE, size, flags);
     msgp->offset = off;
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 13f2407845..dbaa322952 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -16,12 +16,14 @@
 #include "hw/vfio-user/proxy.h"
 #include "hw/vfio-user/trace.h"
 #include "qapi/error.h"
+#include "qobject/qbool.h"
 #include "qobject/qdict.h"
 #include "qobject/qjson.h"
 #include "qobject/qnum.h"
 #include "qemu/error-report.h"
 #include "qemu/lockable.h"
 #include "qemu/main-loop.h"
+#include "qemu/thread.h"
 #include "system/iothread.h"
 
 static IOThread *vfio_user_iothread;
@@ -444,6 +446,11 @@ static void vfio_user_send(void *opaque)
         }
         qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
                                        vfio_user_recv, NULL, NULL, proxy);
+
+        /* queue empty - send any pending multi write msgs */
+        if (proxy->wr_multi != NULL) {
+            vfio_user_flush_multi(proxy);
+        }
     }
 }
 
@@ -464,6 +471,7 @@ static int vfio_user_send_one(VFIOUserProxy *proxy)
     }
 
     QTAILQ_REMOVE(&proxy->outgoing, msg, next);
+    proxy->num_outgoing--;
     if (msg->type == VFIO_MSG_ASYNC) {
         vfio_user_recycle(proxy, msg);
     } else {
@@ -571,11 +579,18 @@ static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg)
 {
     int ret;
 
+    /* older coalesced writes go first */
+    if (proxy->wr_multi != NULL &&
+        ((msg->hdr->flags & VFIO_USER_TYPE) == VFIO_USER_REQUEST)) {
+        vfio_user_flush_multi(proxy);
+    }
+
     /*
      * Unsent outgoing msgs - add to tail
      */
     if (!QTAILQ_EMPTY(&proxy->outgoing)) {
         QTAILQ_INSERT_TAIL(&proxy->outgoing, msg, next);
+        proxy->num_outgoing++;
         return 0;
     }
 
@@ -589,6 +604,7 @@ static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg)
     }
     if (ret == QIO_CHANNEL_ERR_BLOCK) {
         QTAILQ_INSERT_HEAD(&proxy->outgoing, msg, next);
+        proxy->num_outgoing = 1;
         qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
                                        vfio_user_recv, proxy->ctx,
                                        vfio_user_send, proxy);
@@ -1112,12 +1128,27 @@ static bool check_migr(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
     return caps_parse(proxy, qdict, caps_migr, errp);
 }
 
+static bool check_multi(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QBool *qb = qobject_to(QBool, qobj);
+
+    if (qb == NULL) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MULTI);
+        return false;
+    }
+    if (qbool_get_bool(qb)) {
+        proxy->flags |= VFIO_PROXY_USE_MULTI;
+    }
+    return true;
+}
+
 static struct cap_entry caps_cap[] = {
     { VFIO_USER_CAP_MAX_FDS, check_max_fds },
     { VFIO_USER_CAP_MAX_XFER, check_max_xfer },
     { VFIO_USER_CAP_PGSIZES, check_pgsizes },
     { VFIO_USER_CAP_MAP_MAX, check_max_dma },
     { VFIO_USER_CAP_MIGR, check_migr },
+    { VFIO_USER_CAP_MULTI, check_multi },
     { NULL }
 };
 
@@ -1176,6 +1207,7 @@ static GString *caps_json(void)
     qdict_put_int(capdict, VFIO_USER_CAP_MAX_XFER, VFIO_USER_DEF_MAX_XFER);
     qdict_put_int(capdict, VFIO_USER_CAP_PGSIZES, VFIO_USER_DEF_PGSIZE);
     qdict_put_int(capdict, VFIO_USER_CAP_MAP_MAX, VFIO_USER_DEF_MAP_MAX);
+    qdict_put_bool(capdict, VFIO_USER_CAP_MULTI, true);
 
     qdict_put_obj(dict, VFIO_USER_CAP, QOBJECT(capdict));
 
@@ -1228,3 +1260,55 @@ bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp)
     trace_vfio_user_version(msgp->major, msgp->minor, msgp->capabilities);
     return true;
 }
+
+void vfio_user_flush_multi(VFIOUserProxy *proxy)
+{
+    VFIOUserMsg *msg;
+    VFIOUserWRMulti *wm = proxy->wr_multi;
+    int ret;
+
+    proxy->wr_multi = NULL;
+
+    /* adjust size for actual # of writes */
+    wm->hdr.size -= (VFIO_USER_MULTI_MAX - wm->wr_cnt) * sizeof(VFIOUserWROne);
+
+    msg = vfio_user_getmsg(proxy, &wm->hdr, NULL);
+    msg->id = wm->hdr.id;
+    msg->rsize = 0;
+    msg->type = VFIO_MSG_ASYNC;
+    trace_vfio_user_wrmulti("flush", wm->wr_cnt);
+
+    ret = vfio_user_send_queued(proxy, msg);
+    if (ret < 0) {
+        vfio_user_recycle(proxy, msg);
+    }
+}
+
+void vfio_user_create_multi(VFIOUserProxy *proxy)
+{
+    VFIOUserWRMulti *wm;
+
+    wm = g_malloc0(sizeof(*wm));
+    vfio_user_request_msg(&wm->hdr, VFIO_USER_REGION_WRITE_MULTI,
+                          sizeof(*wm), VFIO_USER_NO_REPLY);
+    proxy->wr_multi = wm;
+}
+
+void vfio_user_add_multi(VFIOUserProxy *proxy, uint8_t index,
+                         off_t offset, uint32_t count, void *data)
+{
+    VFIOUserWRMulti *wm = proxy->wr_multi;
+    VFIOUserWROne *w1 = &wm->wrs[wm->wr_cnt];
+
+    w1->offset = offset;
+    w1->region = index;
+    w1->count = count;
+    memcpy(&w1->data, data, count);
+
+    wm->wr_cnt++;
+    trace_vfio_user_wrmulti("add", wm->wr_cnt);
+    if (wm->wr_cnt == VFIO_USER_MULTI_MAX ||
+        proxy->num_outgoing < VFIO_USER_OUT_LOW) {
+        vfio_user_flush_multi(proxy);
+    }
+}
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 7ef98813b3..64fac9137f 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -11,6 +11,7 @@ vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index
 vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
 vfio_user_get_irq_info(uint32_t index, uint32_t flags, uint32_t count) " index %d flags 0x%x count %d"
 vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_t flags) " index %d start %d count %d flags 0x%x"
+vfio_user_wrmulti(const char *s, uint64_t wr_cnt) " %s count 0x%"PRIx64
 
 # container.c
 vfio_user_dma_map(uint64_t iova, uint64_t size, uint64_t off, uint32_t flags, bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" off 0x%"PRIx64" flags 0x%x async_ops %d"
-- 
2.43.0


