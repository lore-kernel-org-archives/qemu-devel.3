Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72CDC7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 19:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUVq1-0008K6-Aw; Wed, 25 Jun 2025 15:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpx-0008CU-02
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:31:13 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpu-0004OS-Gp
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:31:12 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PErU52026909;
 Wed, 25 Jun 2025 12:31:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Z/e9VLMgCEHUaKTkvcLXsmzB6Ct2x8k1UMhh8itlt
 NE=; b=owV8bixdPYgYHlrsf7WapR0bSrbQQ9oC+D1mPDW3lcuCRk7RqCTuzMdZA
 ybZovQeRIIweNFsrXI0PwAygs7GD6OhZ0S50h2bE7bAHXrR9UW9ahRaYmCw+e2uA
 NMsQNGMCUgmpt9G5mopsGsE+TrjtBWYnAgkYFaDCJdoiTgY91PLFxqNaYYEvbUMt
 fzeju7Itiyky7qe/qSrLXLf3w/v5lREvRygYcZSyYrp0kTXXT2DmTwgavE3k9ddp
 EYGK3jeXFEH+RFK2WJz+vasgkWJI1+rjl3Y40ovEnVV/r78Pah0a0XUefVesed/B
 +wUPw1zrxgKI7okM9XURxYP4/0a7Q==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2095.outbound.protection.outlook.com [40.107.93.95])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47dva0hhuw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 12:31:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=juV77C3zR5cawgtN6thvD1BxgnYZV0shLM69GI+/FLaPJTDHq7vrBiOumf4P5qCn9B+S0zZRJfR5XXDGU/w9RHQW5VOitDNVGwJgyTlLozhztQnMlXGSOPGsRM7jYfSCRuVN0KPoSgTWizzho7K4ivm/ULHQJu1U+pDFmAnigTA2l6tUy6ZhGuwoGu1U7xQ/OGsx3HXBKqH7N/HZDSSTK48B66nrR7zzfZXGmVTgnIw4ZCVsjJ5E7dtC8lhmpudbdCoIwZMPgdq2Ko7ma6DygpMB7vvGWTL0L+FUhBuVJ4//SYxJMp92oAFadwFV374aCVyQxZfMTXxZlYvAdlc++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/e9VLMgCEHUaKTkvcLXsmzB6Ct2x8k1UMhh8itltNE=;
 b=TfVnMPsk2JZJPn44CAdVNYnph+Rcbp+tc+CJSkuMvD8PLJ1C/8exJ6tNEXJEMF3SbUBLsIH9e/HwONGj66il3KsIpmVrmpv+34de1g8oTwHaOyzfeos9w+Vio9Pa7Todzmx8FU1BAwJybR36WEeLPVopy9JTf8M0rBgpjo7b1/PcUMIH0Jh+4O4CD1pNMx6Yg1pRLdiwOml+8//2hSyXaV7vX4MMyIxmXbUkSVgE4UipcsnZfDbGwtQhqfps59axrLZBMvguRRjpUzmuuqnd/KSfMkp9CS7rq4P6BDbNgoXjre12Vihng7rH4RvEUelsf6NgSDrUwbGU4xySzrFbww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/e9VLMgCEHUaKTkvcLXsmzB6Ct2x8k1UMhh8itltNE=;
 b=StJaiVQjetrgqH1r5wDVqe6G3R625YVfVIdfLveEFw7St/LxW5GXkxbKtj2Y/L9yhuFEjYR4ddBHVYi5n7JiDCZ2DBe4kptVtPWMKVBh9VWN4r2+ppnJgjsZ1x99NdKYzExAC4r+iBXuzXmyT9DfnE/iYz8jzt2+drsy//6h+mCMfRb+qrDKaI5uOB8nraYqXHW3aB3DhGcRxDfXDbHooBDLwrkwCaDR9CHHilWk+d/ZmzwJbLpVWmESVDIfrPFQMnohsdqeIWqN0MU+E+x3GbtAtquYVUDdQ8eHA1uoos9g22KX70b8SPA8fjlfXUFE9prTbYfGQ7+dLUqp/FT0jw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA0PR02MB7308.namprd02.prod.outlook.com (2603:10b6:806:d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Wed, 25 Jun
 2025 19:31:04 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 19:31:04 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v5 17/19] vfio-user: add coalesced posted writes
Date: Wed, 25 Jun 2025 20:30:09 +0100
Message-ID: <20250625193012.2316242-18-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625193012.2316242-1-john.levon@nutanix.com>
References: <20250625193012.2316242-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::18) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA0PR02MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: 880e45e5-7bd9-486b-9414-08ddb41ed2e9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+GQiUI9um+TIXEOK1sVHGa83dFsrySlxLIN1v6joMn5cf9JS2W60i4zaryay?=
 =?us-ascii?Q?dH7E7d70IKKRv9asmP+HUxGy5wKmngQyRm5Voyqgnld3nmV152g1mvMny6d+?=
 =?us-ascii?Q?vVvDmYoa1kkxLFDuq7pgVWO+Hav5qVVA+CB9m8KJcswZiMAdQb9MMn/NMGFx?=
 =?us-ascii?Q?EREiReyUqvO91+csQFxNdBFfx1+HKedeBaLOJLiIAU1DFW7gNZoC0RVoU0BT?=
 =?us-ascii?Q?PzzvjD6jjoO+kRZDfaxmMow8ValMjcXW9MLrx/oLpiMsa/3m6tB5f0Tn9mtv?=
 =?us-ascii?Q?Uuf6qnTk9Vq5C0BIuWWQWlB4sbJ6vjc1OqHkZhptFMdbdOnEB98XfZ5nmcmz?=
 =?us-ascii?Q?lZFv54ypW295uhgpK3DEPRbAayzYJjzgxaKoeiz8VxeGP86ZqDdiEApn9Mbx?=
 =?us-ascii?Q?uoux/7g7FX6wocGTyABioD45SyXg7mjQD9+ikr46+UmWjVunA2Og1OWwrrE8?=
 =?us-ascii?Q?MASPLWMm9Jx775fK6oXA0T6wkFhjuj93ogjp1J3yAey1h0PyhKjfHcTGoHnI?=
 =?us-ascii?Q?QtGU4God4dV93NeDDPMsUswjkkk23A5aAoRDEWX4S9LHXywGqFKWvWfKZ0rJ?=
 =?us-ascii?Q?ERarBdHQ+fLStPAPuPQwRuiXGPkBFHv6UC51zERtEhK6lunrp/VMSJdG0uW8?=
 =?us-ascii?Q?wucrXG6r7SGpquG7U1Asiiouzkyr8PsEu7a1CwT+4SNq4x4YGmzCEZNSMpvV?=
 =?us-ascii?Q?+nBR627wQBif9qtTsGzMh97uE2pGvjFZzLzP0JsB5/Ad7MYtHik5cvGnAR9e?=
 =?us-ascii?Q?byNhN4gdpxP/CbKfmzNSZncOPEKnSLj4iZl5ly7buFg0A2gZOAcOVsOlDKYR?=
 =?us-ascii?Q?URdNodYre4D+d8VDAa0BQu2ctxK7vVvKXkowzYITKzc2RKZG2mbujFCDH2ef?=
 =?us-ascii?Q?aPVS5pvN9XGI0WoE11tmAEqvw/OGZJRM43uXyV3KIMf+6thjueXy0BJ0Nmke?=
 =?us-ascii?Q?SFPKe4VX/n66++p5wuQhXuAWlAWvcJ4rjtRvXhfBG9EMGU/q7aHM6jWoDbSJ?=
 =?us-ascii?Q?h48GBLlSVHUnInG/pZsTqNll7NbpnjJN8Dsu6qVlGQEUMIleMIEha25PwUhM?=
 =?us-ascii?Q?/uy/0LD9OflHilxQjuwgHZX0zTSuYdAgyDulblFqopcgXDTZIPrI4M+K5VHV?=
 =?us-ascii?Q?CQSPWkm39u4a2no1p1NozPhxeEMro6H6l9olhibh2qpTSQAsVuuNqjEDb0bx?=
 =?us-ascii?Q?LRcqr7fzke3mnnRuTclcjE/HmYAdsVtZnKsKENH4wQr6O1boMqHpy22iiXGb?=
 =?us-ascii?Q?sbm9ACyCDkrp1VorbNpXCaPAItLJlyJO24YKeJa7HCMyZn+AhneEho47eiFQ?=
 =?us-ascii?Q?wnNvAiwGNv4fFLMgJeTutGhBivoLifRIY75Brvm2bTcAzBf8I1VwH3ZfZ90c?=
 =?us-ascii?Q?035M1yba8QOBIdXb426Lv5xUC8A0t9xVnzz+j3gJ/IkKzXgv3A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ywdl14d4JhzpGDrWzwKSBCNLdfoty3AuegNHlHRKGq2pQZOeiVExTfW0S5MZ?=
 =?us-ascii?Q?29EnViExtJ5mDcjsqo1pFGp79BnwxtEA+XBzFbJhKHmu4gpYOZ3wWhrbQMyz?=
 =?us-ascii?Q?TVWD8E7nTi08YFheotirMKdqZ2H+pv0rpaCGmH6Wp6hZD6wuV3AR/IjMhIFS?=
 =?us-ascii?Q?3HKftLwG/mt6aUyDUXYvWXRbI1jfRIZD7aUhc9/u/+4sx/lCFBajzh3nIsBq?=
 =?us-ascii?Q?Dmp1R+7SgaAR6VwKHFv96Rb4GzNVq9bCRmEyz29LCMobLVRp//Dgef27/6Vd?=
 =?us-ascii?Q?TUG4gvrxj6b030puyGFl7MnR/Se3k1tlfeRNG8XvgWGfLDSraxhqnxffLSiw?=
 =?us-ascii?Q?OETnN311+t6BpA98XHLaX4YYEbkcT0niWLvPZxU3gDF1h9PuSiaOKrHjs3I4?=
 =?us-ascii?Q?wwqfyCYdz5g+9tLVgTi78YYUaob4nohjJZ54lAxCpsaCyQ3CRucDDJIRibh/?=
 =?us-ascii?Q?Ad0If5nkgfz4eb2tLZ86Q3Ta4NPGGlnhDEY468EqRs6fuNLV+e7Uqf+A2F7m?=
 =?us-ascii?Q?MAymZyatkN4z3jKwaI/rF/7lXDZrvepOqWSJ8irLpaihTT5kPlzauACbS2bp?=
 =?us-ascii?Q?dEGc9vtJiyQIoM4I6Z/+XLRIrcHHX8aTtY28XmwLk7yLl1A5ZX8VusueGN92?=
 =?us-ascii?Q?K+15ycKyDMzloXY704U6fLNdAAOXOauOmRy207VBFL8eAZf1YOaxTDduFJ/S?=
 =?us-ascii?Q?c1EVZyOqtwx2/i/lJyfmTF09ImBebiIeGQLRFew4biA8bygw+tshdRKfZNVp?=
 =?us-ascii?Q?W9bIV1j+JZ1c+p+/iLTD/oaSVOKNkxZDaOaQL6809fW5kKh6b2wI5S04Dqus?=
 =?us-ascii?Q?tGymTb4bHoB0tWYdLr7yx0b3g4GWjaIOnH4dy1elRzv9LaxUR0Z1Y/E2TwEA?=
 =?us-ascii?Q?9Z2mGViIBgN0cgG+WOI+EpYDsPqZo4KbhC+oQLo8Lsdp8ie5KOx/uqczrqtY?=
 =?us-ascii?Q?ZtHYHHJWyQR7e5WHNUDTUIozTYl3BsmbvedngQxNiF2BeFpHKOFSnXgjnTow?=
 =?us-ascii?Q?J8gvG/oFTlOPfeNMUMaeIhKheGWYFAfnmoRQOYFziMIigOGiz7uvrNUSeYts?=
 =?us-ascii?Q?XGJpe2B7vQ+YHMEWjd7sa9wj94EKek+aXgYv2r4KB1m1FJ2tDsv0XQGI2BCs?=
 =?us-ascii?Q?nKKGeKDXRgISKsoWSU0e/ZlvdJPy25sRiOEg1QutGokUWZWqHsz2bq09FXiu?=
 =?us-ascii?Q?UvYEedM/sp97FOwuThztMd1s2ZYcht5mPPdiCQrtTahZAnKtEGLagMx+rya0?=
 =?us-ascii?Q?ghfhGOOfsp/Gk/ILvWluoZRzIaaOYgIBBBPCB/FV2gKo7fJyc5R7v0dax+U/?=
 =?us-ascii?Q?9cZil3lf/FrZ5EMqP/TmNE27Yq0D8QV3v/qvaLHVTd6WTrxpVeC6ZMpkod4J?=
 =?us-ascii?Q?cdzBl9BIVY7V2sQsJHEmqQdk/fg5NSvPtlIcv3FVqrvOAdzwOeefCWQQhqwE?=
 =?us-ascii?Q?bvJ8I+G6nBv6f96Jg6rShTNSnH9O9WeGjitix97jVVnNLqZfHvefkS6uCg/E?=
 =?us-ascii?Q?VhWSeC6QaJUmucKPVnd6TCe79gSSHacvGH6bXmtEwXAS2lRfBexrkzAZVjME?=
 =?us-ascii?Q?V3NQbk9rDWmNl8LYOov6aUkVOyo7TU7vg4FTsHnk?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 880e45e5-7bd9-486b-9414-08ddb41ed2e9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 19:31:04.0592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jv1uLSr3+q8gxEkpWQU75e6eAzWYhZJ1q4Yv5+PQh6sIGziAP0M0eRDdvtcRfzgqaAbvsDciPbNaYYZMJmAWgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7308
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE0NyBTYWx0ZWRfX4CMPZ6uUbRg1
 GidxXy5gthbkQKHABRQRkYW/KCLfHCRAfUyaN++jIuyAquFGpD3oViDBynOmuxfkn7vd+LZcbCU
 ktDHaV2/SCuUPHmFzZuJp2sGqoluKvpjkkd686kMiNTuP7OEgNRZ5Md2HgLs3cjDEbx/y5WLnpC
 ED7evedRJ+EayCIjcp/op59ThClHb7YlwC7acBuUaerm7QlMMZX6V0IoEj2sMZGto6OKkPZlI53
 ju8sXIZHMtbFjNecCFrJ+5ILWJppESafhvfLQT2xuEYpaeFMS3epDJjlk0QT7eu/BDeOmlgBmHO
 YCBgf/I4t9XVqfoa7XlwMgA2UyEiTMB1CnAjr4zM9I3FL6FVahho+B7vGDZddIBJj85hDdtqAYA
 y0I3k6NheJokuqwwO6CzX53yE386uviAf39aCjrv6QEUfhKzYWWNNvRnNR7IsGghlcFhuuWQ
X-Proofpoint-GUID: 72P9zzuRx2ByM6wR-GDyjDEnwtRU8voJ
X-Authority-Analysis: v=2.4 cv=Qohe3Uyd c=1 sm=1 tr=0 ts=685c4e7b cx=c_pps
 a=DIZmGg09oD0WH6Bj2PzylQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=-qxVb9sXb9au51uT7-gA:9
X-Proofpoint-ORIG-GUID: 72P9zzuRx2ByM6wR-GDyjDEnwtRU8voJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_06,2025-06-25_01,2025-03-28_01
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
index 3e9d8e576b..3249a4a6b6 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -39,6 +39,7 @@ enum vfio_user_command {
     VFIO_USER_DMA_WRITE                 = 12,
     VFIO_USER_DEVICE_RESET              = 13,
     VFIO_USER_DIRTY_PAGES               = 14,
+    VFIO_USER_REGION_WRITE_MULTI        = 15,
     VFIO_USER_MAX,
 };
 
@@ -72,6 +73,7 @@ typedef struct {
 #define VFIO_USER_CAP_PGSIZES   "pgsizes"
 #define VFIO_USER_CAP_MAP_MAX   "max_dma_maps"
 #define VFIO_USER_CAP_MIGR      "migration"
+#define VFIO_USER_CAP_MULTI     "write_multiple"
 
 /* "migration" members */
 #define VFIO_USER_CAP_PGSIZE            "pgsize"
@@ -218,4 +220,23 @@ typedef struct {
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
index 0418f58bf1..61e64a0020 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -85,6 +85,8 @@ typedef struct VFIOUserProxy {
     VFIOUserMsg *last_nowait;
     VFIOUserMsg *part_recv;
     size_t recv_left;
+    VFIOUserWRMulti *wr_multi;
+    int num_outgoing;
     enum proxy_state state;
 } VFIOUserProxy;
 
@@ -92,6 +94,11 @@ typedef struct VFIOUserProxy {
 #define VFIO_PROXY_CLIENT        0x1
 #define VFIO_PROXY_FORCE_QUEUED  0x4
 #define VFIO_PROXY_NO_POST       0x8
+#define VFIO_PROXY_USE_MULTI     0x16
+
+/* coalescing high and low water marks for VFIOProxy num_outgoing */
+#define VFIO_USER_OUT_HIGH       1024
+#define VFIO_USER_OUT_LOW        128
 
 typedef struct VFIODevice VFIODevice;
 
@@ -120,4 +127,9 @@ bool vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
 void vfio_user_send_reply(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int size);
 void vfio_user_send_error(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int error);
 
+void vfio_user_flush_multi(VFIOUserProxy *proxy);
+void vfio_user_create_multi(VFIOUserProxy *proxy);
+void vfio_user_add_multi(VFIOUserProxy *proxy, uint8_t index,
+                         off_t offset, uint32_t count, void *data);
+
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index aa07eac330..0609a7dc25 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -9,6 +9,8 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/lockable.h"
+#include "qemu/thread.h"
 
 #include "hw/vfio-user/device.h"
 #include "hw/vfio-user/trace.h"
@@ -337,6 +339,7 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
     VFIOUserProxy *proxy = vbasedev->proxy;
     int size = sizeof(*msgp) + count;
     Error *local_err = NULL;
+    bool can_multi;
     int flags = 0;
     int ret;
 
@@ -352,6 +355,43 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
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
index 7ce8573abb..c418954440 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -13,12 +13,14 @@
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
@@ -445,6 +447,7 @@ static ssize_t vfio_user_send_one(VFIOUserProxy *proxy, Error **errp)
     }
 
     QTAILQ_REMOVE(&proxy->outgoing, msg, next);
+    proxy->num_outgoing--;
     if (msg->type == VFIO_MSG_ASYNC) {
         vfio_user_recycle(proxy, msg);
     } else {
@@ -481,6 +484,11 @@ static void vfio_user_send(void *opaque)
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
 
@@ -579,11 +587,18 @@ static bool vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg,
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
         return true;
     }
 
@@ -598,6 +613,7 @@ static bool vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg,
 
     if (ret == QIO_CHANNEL_ERR_BLOCK) {
         QTAILQ_INSERT_HEAD(&proxy->outgoing, msg, next);
+        proxy->num_outgoing = 1;
         qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
                                        vfio_user_recv, proxy->ctx,
                                        vfio_user_send, proxy);
@@ -1151,12 +1167,27 @@ static bool check_migr(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
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
 
@@ -1215,6 +1246,7 @@ static GString *caps_json(void)
     qdict_put_int(capdict, VFIO_USER_CAP_MAX_XFER, VFIO_USER_DEF_MAX_XFER);
     qdict_put_int(capdict, VFIO_USER_CAP_PGSIZES, VFIO_USER_DEF_PGSIZE);
     qdict_put_int(capdict, VFIO_USER_CAP_MAP_MAX, VFIO_USER_DEF_MAP_MAX);
+    qdict_put_bool(capdict, VFIO_USER_CAP_MULTI, true);
 
     qdict_put_obj(dict, VFIO_USER_CAP, QOBJECT(capdict));
 
@@ -1270,3 +1302,55 @@ bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp)
     trace_vfio_user_version(msgp->major, msgp->minor, msgp->capabilities);
     return true;
 }
+
+void vfio_user_flush_multi(VFIOUserProxy *proxy)
+{
+    VFIOUserMsg *msg;
+    VFIOUserWRMulti *wm = proxy->wr_multi;
+    Error *local_err = NULL;
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
+    if (!vfio_user_send_queued(proxy, msg, &local_err)) {
+        error_report_err(local_err);
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
index 44dde020b3..abb67f4c11 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -13,6 +13,7 @@ vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index
 vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
 vfio_user_get_irq_info(uint32_t index, uint32_t flags, uint32_t count) " index %d flags 0x%x count %d"
 vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_t flags) " index %d start %d count %d flags 0x%x"
+vfio_user_wrmulti(const char *s, uint64_t wr_cnt) " %s count 0x%"PRIx64
 
 # container.c
 vfio_user_dma_map(uint64_t iova, uint64_t size, uint64_t off, uint32_t flags, bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" off 0x%"PRIx64" flags 0x%x async_ops %d"
-- 
2.43.0


