Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA8CC7115A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 10:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR6qZ-000159-QO; Mon, 16 Jun 2025 06:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uR6qY-00014c-5e
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 06:13:46 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uR6qW-0004ud-5b
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 06:13:45 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FHtYMT027789;
 Mon, 16 Jun 2025 03:13:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=w/dpLZ11oQdon
 kSnf/ghA29IW1DVW+5+FS7YgIIatns=; b=F4GYOSl5n0sUwOSoWGyi73B/KLoqS
 wHjXIdJQ4t12PRMHdsKh6YoUYIjZBDdx90zg7y54r+Pi3mdUrk1J6jYD+msSy7Ey
 shpIvqjfoZyDFB/cMiDA5+m+6NNyi/wNefSIztZKM6o74si5gG2ME/gWJG3vbRBc
 RAhEiYTIumtmmHteak1YoL673ZKFkF35DClLH4Xplrvvhjm5p1OcllcFNlb+WpUa
 XUwTqZtSp1fnGeGa+S295JQz21eTm+FC0ymtPRNwhE/2vnAZ7UDQu2JItk0e56tt
 A7/9/OOBRXcJSKjaGu99+8x4NXmmG6NF/cXgEqEPqI3BSt0bykbuAnITw==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2137.outbound.protection.outlook.com [40.107.220.137])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4795dujyrf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 03:13:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLovqgnsPg2/wHUxkHTXSpVSvmuOCSu7CgvYSHFXGAVwUO2Ap7NNXW2Zuij7m31EbA1WiHRP9C9I80lz8YwiZo9mSzArPzUJSEun71DLTS1j9igewd3NqtBRYkgpMJ23cXh7MkPrhELBFeI+vClLJkW8t5JQ0ecAzwA3wuiKe24QQcpNachLQAjHR7x5BxTnhUMK1+50oejWPrGhXwv90w5YYSM426v1ar/53P92mu+AQ/ho854P0OXPoRw1psZdJ8AJyA/Paww6DT4hzvx23MK/gSdIKY6sjpQLvDfpgR1OU17bG5r4eavThIyDDobio1mKyRBFWlTF8iiRp+zN0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/dpLZ11oQdonkSnf/ghA29IW1DVW+5+FS7YgIIatns=;
 b=nny7ZOoZ+IbGgvZYjqaRBNR3jqEcqwJvmBDCG4a4znXH08xO8YpRi809KtQqJ0IVT4HjuaaIQC4b/4cI+wP0AscPWanNLtwMQDKpFHprAJH5rOdcw/VBMRaEIzDGvM8iaBiqFkOkOt6WKddJd0poZnw0g2B3iI5oM7s3JwXMY1/cLQ9dxMeb1QfBK8eUH/BfmD+0Y9CBbNLOyAxcbh0ELt1P5BXDoQQn5lAgHPw0C4Gms01HhLZU1XSKkLo4hQ9gaoi5IOwehKHur2vmMXaMduMEYnEklaSD7O4EN2+vAFWelYzeSbNrQQEgpSK1poRwtVZpGmrNJLNEXTCjHXq63w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/dpLZ11oQdonkSnf/ghA29IW1DVW+5+FS7YgIIatns=;
 b=DIoKQ+t0tarcsUoKLiYHCniOL+EX8KRFinBXbEBvZx0l1YXj4CqfCLXM/6Eb4dfAoSocQpmj9Qk6pOhI9YwKff4twtGI4rtLnqLpDFFKMvntJ7JGRtzMi0H1JURgD6sf9bbbEKSQs//LA5ziaKjfj8xR++imTW1HsNbHVjQzwVAUMeOTuhOC4RDacyELdbsOHIRJByCaXXmAJPWPdN6zFiQO/3a8r0I+bO78bK60R3vRjw6tONLbptnalp21Bf1g6wjCxZV3aIV2pPa4FeZbVcvrkOS42lNyODrQERjA1J1XA4kQy43G/XMTAs0vhtbfUMwoST5od/B74abwHnbu8A==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DM4PR02MB8885.namprd02.prod.outlook.com (2603:10b6:8:8e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 10:13:40 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.024; Mon, 16 Jun 2025
 10:13:40 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH] vfio: add vfio_device_get_region_fd()
Date: Mon, 16 Jun 2025 03:13:36 -0700
Message-ID: <20250616101337.3190027-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0020.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::9) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DM4PR02MB8885:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f94b2c4-07af-4e39-ea1e-08ddacbe7748
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JPnIjtB6R9e0DKqMjIle16wcQTobePHpJZxbOvwS10JZlDD8tOlaUS11MQ6e?=
 =?us-ascii?Q?ha92w50ZxZtVAWx3RgQA7+1oGg8R9VBmwdoSvLNVDe4eD71CkRtUMfj3oSsG?=
 =?us-ascii?Q?E86q4cBYCpZechMQczT3DVcmJds3B62piSIUIPeAvAJaFsISXK+gzc9HUzWf?=
 =?us-ascii?Q?YS2G7jH0qG8QE91ox2fUm1MbZU/vjREGeec20cYHoBvB5QXseb4vJOGtXJOF?=
 =?us-ascii?Q?KGBxZXRgajKp7ULI171I/lPoloha1yjhopUIPEqd4TkEguiu1CpnomLGv/n/?=
 =?us-ascii?Q?LJbUnYJQYTU2vCwkvhVH3SGi9QvWUefwhbLWtlDrj6vtiD5jt3fGjQ46LtKV?=
 =?us-ascii?Q?y9E9bhUJFsq24/KYRFxBOfllDm1zV6sOcPzMSaW+ljT1cwDc4xyuR4yOl6MH?=
 =?us-ascii?Q?FNF6Wxck68SC4rMn5MFgZnLajBCJMWSn3UoHYp5NRhSGWJTN1qN4O2QMgcD+?=
 =?us-ascii?Q?u8ihf1Y5kFdRGj7z6+rAPSWMb1PZaaNRPElgH1lBVXMPMr9008zVhgWwcSL2?=
 =?us-ascii?Q?B1RfTQWwNIyYqd9uTPBHX2x88KQ47+rX05ZPbVstNOxBrEhf6P4Q1VqAFhZp?=
 =?us-ascii?Q?mE+xs2OMhDArblIVV3uGX2TsZEx1PQAIiDUyGE8cAPuOrWBIyJJlYkYsfcs4?=
 =?us-ascii?Q?1c85+Z9l2nyYj7CN2m2BukRKp8paHJnHhP4BEbtuTXhwLm4uhz5IYKzqBMkD?=
 =?us-ascii?Q?xnBkaah7LXOAyG3TiK1XiLaiUZrwQ32kdsz1g/cFhpO4mstipj5AMy9teOm8?=
 =?us-ascii?Q?Rt/L29mcbXRkFZI5DopmT0z6HOOPBBoXl8MoW55Q8qjkiSc6eF4URX+IuOZ9?=
 =?us-ascii?Q?txwOdGAel8Qo4ookQqxxrWhHoo82nEpuTF7SOjJICAlqpDQ5sYNcamTLE8n7?=
 =?us-ascii?Q?dr+Pm1STjG6QiMgsUTaLd/HXhwVp6i/lIRkDWpW19dSjebObyScXBIQT7h1f?=
 =?us-ascii?Q?meGQtNEbOSLTqOjYflTsrfOymoAuwsprwEy1zVt4hk7eEHF1blT4s7NFghO4?=
 =?us-ascii?Q?/nbufBTyyPbE49uoVaQ7oYVgoXnqXJZfX3nKbFjknv+OoWBzz+j6N7XTNAMt?=
 =?us-ascii?Q?C/X+B5gPyzsjCV2OBY/gPF0+M45Jxio40apB9sY8C9FzexBB0t9663uY4VH5?=
 =?us-ascii?Q?YkFLDxtoCrorR0Hz7QQvD6nqir49Yy1V3gtacxv8JZpxCj2tl2sZ364cvdK+?=
 =?us-ascii?Q?OvAIh0UY4J0lKCOefDRNdyIA0b6k8iMUzt209sh4YHZZvNOKmerRc9mRx0Ar?=
 =?us-ascii?Q?MVBMGbGcDTroivatx+3NijMDLRSAHslzmz7ltOLFJJKg4KKzdVRtR7DZ9jql?=
 =?us-ascii?Q?9enApkevxmcVWVBdbzBUtVaJmtNdJYrS6IjmSqyAkaJzb8h4DI64d31PLndG?=
 =?us-ascii?Q?CyjWFVBQf2yslMglatu8XMpO5ClhopgUI80QbtZyQ2OHMxglKyfhI5Tv5k6Z?=
 =?us-ascii?Q?xxFHmVnvzpU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wCv9pPpAMaLaPZthtCfHwojBYLGdTqkWc1qB8l4FKM2SlcO5crzl/9g/zPyZ?=
 =?us-ascii?Q?h8rD/gs3MuQnlvCLlX770KsIyNjkMK4Ga0Olf41rKk8g8oaIO/cLTL/Lejrq?=
 =?us-ascii?Q?peVycHBE95Z/7NogJNEhfrDXmSU8MMaI/YXJLVkMZqZC8TzkyeVDRlknIINe?=
 =?us-ascii?Q?2eMd6Kkt3MdUoDppdgNYW86Wt2WsIh1hT2NDW4Jt+Cbkpfi6hhvaCzBSiwJE?=
 =?us-ascii?Q?ix1Uwqmh4Lry2U+8fA4ZFLEsQkk0HioKXw7UOH03S5Q06gYCBTN+0Kat1r8D?=
 =?us-ascii?Q?+tkQQEuy3fD6KiJ3hyYvRuUq5+t60n/3hsR5AfsjAk/NtZdFJ9V8Zwd3WLav?=
 =?us-ascii?Q?tLV+fm+HUvjMLY0gDBO7oVGJYxVD75fwTrggoEXEOPF5H0h0hIV07OHPB+Bs?=
 =?us-ascii?Q?yA/Sj29iZgn2dMEFdzojQlm6HlbXz8k2qrLSjWjMLGC88LJa9gKznHB1KvDI?=
 =?us-ascii?Q?mZ90zEN9Ym+rXxZ9iCor54uZ4pzzYruXDsbrgH7S/oqkihtx+qBwUX5RU7AU?=
 =?us-ascii?Q?//JugpnV+fKrRPodPuRsSFpauz7FQeh8iO+jDl1spyP90vWEHsvIepUgSt2m?=
 =?us-ascii?Q?RNxJO+aqljhCN1EQzjtvyZyc7+mddvZv0LbcZDVGF9jhGIhf+SeDpH733geL?=
 =?us-ascii?Q?J4CRLlEAaSZ+N8Diw3ZWjEMy8/muGXWHtjuXR71k3IJg5lZ5wVKCu3cnMCOu?=
 =?us-ascii?Q?oU71A4MJxkMNimTfCFo0KrtDNHCqhaKLEGhrRKxhqy4ufAotK4TI490Iy/XN?=
 =?us-ascii?Q?WxPU200Fba+H5NLLFnqh6RcXY16aUSTsmTDd2iTq6IYKfKdlHB48KQBHsqOo?=
 =?us-ascii?Q?S5W1XLcrsncZlGeEkur1GfwNDzcTljXpyP4ck9pE0BqLOQYJ2Os5n+4rfdxg?=
 =?us-ascii?Q?3/qkFuItzs/9rEBftxJ1T3dhp+wUVxjT+R0AFn/ueRgWxv3VZ2pFvFxNYRAu?=
 =?us-ascii?Q?LQhPyfxK2hhJQR2+TUPF5U650zkMcJC7hvK/fprOpuqGL16+uB5sCp2lM7jj?=
 =?us-ascii?Q?z5cAjo11j9WGSiK0cS/QCl4bdd23omzg54REeBoiIDDJ9JZJpENQ+odp+ugP?=
 =?us-ascii?Q?ydE9Zv+7dbfTdoLss6U7Xud9s7t1Y0ZIVQ496E7+w5fZ6TKYIrq2DPsW1cfU?=
 =?us-ascii?Q?T6q5aT5vjWZLQpu6Kg4LevLs61tVJWobUAIbhmHg6pSv4dx8wHYN0q66imzX?=
 =?us-ascii?Q?45mN4ZR/WVl1X06IweGz0l+q6F4ZBfR8BXw6N9UE+mRXAf2E/ofsuahN5cXQ?=
 =?us-ascii?Q?NIRqVGCbBFRCSN/P/4oMEieqjxfgrOg15lJc8dL+kVrJt1uRcHhsfYKPHnbA?=
 =?us-ascii?Q?nT7dJOBCWL+bIEbLHddr+X+9YGVLo5s2f6suO1sAEMWXYduwreoEjvCgPtxM?=
 =?us-ascii?Q?URL6mayKt05uIX4ANdvajwJFzuXsBizwqu+pJJPDD0RBL09mBKdQ8GuKhU7b?=
 =?us-ascii?Q?S/7RjK+s3Ax6NqElc7FMUw2V+cEtjizpzyOv8OFm2rrhCUvAE+MXdaOoQdyV?=
 =?us-ascii?Q?bYqyXyA7hNafk6ALiyGw6EsBz/cz6KDTIUYALiVHRmOxrgxzSQ3q1ey5gBdo?=
 =?us-ascii?Q?19h3rJFZaR4NtNzwaiCG1AeczL/TTf/ByChQdi1m?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f94b2c4-07af-4e39-ea1e-08ddacbe7748
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 10:13:40.3060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRBVJnFQ6uX54V8hifFPJiSQkUaTn0dBl/FAh4ILAr7dMYASVL6ymvwh5fNJNjMWzYEAkgMcpN3wXFkn8EHstg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB8885
X-Proofpoint-ORIG-GUID: kYyOJu6Wp3wnHuxfR0MGQtjY5rG-E161
X-Authority-Analysis: v=2.4 cv=VfT3PEp9 c=1 sm=1 tr=0 ts=684fee56 cx=c_pps
 a=uhh9Xr6CjD6FiqEknFfS7A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=2ykqmQ6g2myoCToT75MA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA2NSBTYWx0ZWRfX9bMLaeIQKJ3C
 v7hc0GYA7MdZfUAx8reobXjaj9KXlWJcqkmvG0/qOtZbt2rLbOzddR3Go+twstAvmcbjM/LHXym
 4D4z7YtzItoYdiDjwnf4EIAbv0B1x8saJ71gIxb7FlIJkbHIqqItESH+cHGON4e33GxjEJvUzFT
 BNizE5qQGK6A/NmONgfPZK/PzzROvz0NjRrBL/jkhwp8YAd67CGkR5Q0EjZpHShEPDLCFMHJz+5
 IKhuF6/9uFFGoMm7dZ63GPZPgZs2aV9bFOrB3z7MUryS1MsMjqRh67L+f1FuDKHG3O7CPeox2wV
 JpK49Q2TWxtRQN5G+UtDYBJCafXKU7JhbtGn3Gmkw9M9da0sW6/3AF/TL9Ee3V+X4KD/y9Bz0d5
 2qN+0T8UR1D4d8XSm/VH2+sXtL4X2KsxPOlwuZxX7fx5QoPEM4Ql1M9eEI0VxOY4yBwmMYlp
X-Proofpoint-GUID: kYyOJu6Wp3wnHuxfR0MGQtjY5rG-E161
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_04,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This keeps the existence of ->region_fds private to hw/vfio/device.c.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 include/hw/vfio/vfio-device.h | 12 ++++++++++++
 hw/vfio/device.c              |  7 +++++++
 hw/vfio/region.c              |  5 +----
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index d45e5a68a2..1926adb0a3 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -256,6 +256,18 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info);
 int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
                                      uint32_t subtype, struct vfio_region_info **info);
+
+/**
+ * Return the fd for mapping this region. This is either the device's fd (for
+ * e.g. kernel vfio), or a per-region fd (for vfio-user).
+ *
+ * @vbasedev: #VFIODevice to use
+ * @index: region index
+ *
+ * Returns the fd.
+ */
+int vfio_device_get_region_fd(VFIODevice *vbasedev, int index);
+
 bool vfio_device_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type);
 
 int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index d32600eda1..d91c695b69 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -243,6 +243,13 @@ retry:
     return 0;
 }
 
+int vfio_device_get_region_fd(VFIODevice *vbasedev, int index)
+{
+        return vbasedev->region_fds ?
+               vbasedev->region_fds[index] :
+               vbasedev->fd;
+}
+
 int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
                                      uint32_t subtype, struct vfio_region_info **info)
 {
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index f5b8e3cbf1..d04c57db63 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -273,10 +273,7 @@ int vfio_region_mmap(VFIORegion *region)
             goto no_mmap;
         }
 
-        /* Use the per-region fd if set, or the shared fd. */
-        fd = region->vbasedev->region_fds ?
-             region->vbasedev->region_fds[region->nr] :
-             region->vbasedev->fd,
+        fd = vfio_device_get_region_fd(region->vbasedev, region->nr);
 
         map_align = (void *)ROUND_UP((uintptr_t)map_base, (uintptr_t)align);
         munmap(map_base, map_align - map_base);
-- 
2.43.0


