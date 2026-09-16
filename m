Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8257C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6n8Z-0000Wj-U3; Wed, 16 Sep 2026 06:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n8T-00007P-0R
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:06 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n8Q-0002mS-4a
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:04 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68G8q4Ub541814; Wed, 16 Sep 2026 03:44:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=oCxDLQQ0JtOJx+l00uKoBh/UgomiZOIYm3LR6JQrD
 XA=; b=zHHVnhS6ojghbU7jIp7YfnsSZ+e6aA3ok8ZgOJCPNrylUk5KqJ94VlSqg
 5b3DSQ3sY9KWKUrioIMa3dr57cOih+jJ4GcXRnHGjL1Qo5rHnRwDYwJ98LpsOwyg
 Mbkc6CIMe/wLnOEQHNOkhc85ivF5yEYsYi9rmYFnzVzzaJQbe2/iDzlO7L2ghj9N
 zjp6UwdYa4HNO2Uq60uGcILT3gekkRnf8Q+V3BWOTM+S1yrpbvJp9a/seHcCtskS
 sa2ieIYqn2qeybL77cb+kFuKtcg5UedwNIU5WeMJy6dK/i15IhuuYE5u3qZAxHWM
 D1qOULVZ+1Ab9mKdr6/R9ui7FsqOw==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020103.outbound.protection.outlook.com [52.101.56.103])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gqa0pt9xw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 03:44:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4Ytt+ZAMJcNRjOYNEiYnROly+7klnM2ruopQOO8rs1MNNKFNzyjNNwbRaSEExOYCFX4aiqGdZ8wOtArYcJM1A1w884qMB4iQmWijN9qK3PSm56Ao+T1b6Gnvq0lbaA1ztC//9N4kt1dVYCojCb2Mr0uJ3mw61P7hh8DivtNB/8h2KY8jIHrNTufGszDwQ1cOkQpuvRfPp68eLAbaf37KqSwx1bUec1PV0095JLS0wFwjiCGxSBWLiDQbLqXqOPYnuJKE4g3eF/Dj4/cTMlTO5vFc28pkleY13ghanhp8zs4DsauTvon4qB6tFewXt1swOVVgjmAEdFXSn18Dj9few==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCxDLQQ0JtOJx+l00uKoBh/UgomiZOIYm3LR6JQrDXA=;
 b=e9bt/ipdC/4WmHDbuq2MYD4CcMRGRbcAKM0sCeHJ0sP79abTyyN8J7BtKDtphnz8BgrN7IO6OGtS+rZtjeYNsfFuw+ucli3GRFvuAPyo698qc4e01KGVMfvM6JBwnGcudN6imAu+hRKPiIubXoY/iZQyw74OXmw8V9CrR5LblkTPtQ7cyexS36NbHwUJYsPmoF4OvXcALSUMeKL0zuVFKbhiLkCuFT6b9VH59+4k6oAym6UEk0GJNQpBXo0pXyEuAtnolwoRfsqUxK4M+t+5+6aivJ+n0hXM2sa2rqtC+DeDALSKYnc/uRAKqnzGrR9ZMbiLB0xowxKfqwutPE4vvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCxDLQQ0JtOJx+l00uKoBh/UgomiZOIYm3LR6JQrDXA=;
 b=VAagvSOdYPhz7ilzs5Q/RrPHgqJ+0Ki1trQuX52D+fQ7pZBp0dGATP8yocyJUIiF0WYlvCtJZu9yI4ivhskoej0AK9QFBNj4GZDLjCePSnbv2apyM0w8EI7Im/MACfSaSkrfjDwMA9rkbCKVvidZT50GthLukwDkhOzi8dba3v4IZwHh5Qifp9HJFxAOfrvKlgwclOwK3/lHvTiH52vXjFZgiMX1KzumZWRmVr6Fni05WM5DpZkE9c4TjFmh0hskigzlz5KmVtRJQE6RKjnQfquOsAJqgjujmIA9X1fWo/Shi4O7kgt/FYkne8o5EgtHOCc1fS8c3aT0f2ZDkuXUCw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MW4PR02MB7380.namprd02.prod.outlook.com (2603:10b6:303:74::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 10:44:48 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 10:44:48 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH 03/22] i8259_internal.h: rename PICCommonState to
 I8259CommonState
Date: Wed, 16 Sep 2026 11:43:31 +0100
Message-ID: <20260916104435.600211-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916104435.600211-1-mark.caveayland@nutanix.com>
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::31) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MW4PR02MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: f52442b9-c85d-4c94-e8a9-08df13df87b5
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|10067099003|3023799007|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: pzBTX3ZpHkQEMssxpYlRUxBmCcytQ06n+Cyzla4PFCi55Nv1Ztc4BJ508xXZk530NJ7LuhG6310lDTbI4dir6VMnLevE0/Klg1V1N4f2QGzFjLRu1cc1Nn/ZPT6oUl7wdrDwmf0aM50X/fac2qH2PK5ZjjPmqnQqGbQCblwpGckyypuKqSDgrA4fqe7wPwitWOh+OZuplVbUdFWWwWj3/uRKsm7Ng84jhTioAsRoiAkHl1yiAwQnBlQqHiR+3jeY6W5p81iiH6+WaPQkQAavdwu35GRbXIz/yhHaump40KKL37nhYGolscwy1nS2WUr0YfgyqtuFjxESKbAScgDMKqm9CSwJD1z1EJ0NccPzrOSo6hj+MhGAsRm6eqXXMf+g+vczvfPgyiT2UJ8TfBBfT6S+RaLe1Byz0wc9jHdXUmlQkR5Uw0H6M+qYNquz8LxTR2iyAs4fJtoUQWM9vR4MCpMWn/JlYpoXuhZBq3rw2AVPG0kaQPNvC/2INXPRsS8XBUXNB0Kwb4VY5wf2POwfJdDju+Chm8IISFStIbuqtXdo4WON0qyoxZwnjfddjSfiRYwPXOJYZ0UvCUS27H/zN+bMdoahU6l1omiGvKxSr5HQJ6L4iZWXemLkBlB8OG3C49+RTBK+NRGhb6gFGZbvOKFg+binYLVQanLO4XEP1ZE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(10067099003)(3023799007)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DGx0rcPHr9WquJH6dWY5Ml7TrVKKK8i2Vo2EBBfa3amL9XVhgpjdo+xEiMUN?=
 =?us-ascii?Q?QEttGsBgL9GGbnqshQzavuVj24yGkR2Go+6DW2JWIQYuDFKPNHqky/3ySkvE?=
 =?us-ascii?Q?PCBEkZ6xwXVCL5xhkbAY5wz3eGageuAY1CbR39nfZBD8GcXQaQ0zK5v/4JSu?=
 =?us-ascii?Q?2+vQmt4TFtz4lhrzi9Msepyyy83CHwuTpFgybzAFZPESP0MdW4tcVt3oQLQx?=
 =?us-ascii?Q?Nd0eLboFCtACojz4zUU+iWAKgk3obs+sbQlK7nSbgZwLs+tSNfQaMbYbr8hT?=
 =?us-ascii?Q?+IzfX79EcUm6Gv3njDQRSBt4CaFjxNHBcZJWyZuGxRHIgJ+QXVdi07/rMEPM?=
 =?us-ascii?Q?lDlCDRKB6tMFAZuh0IdtErsLw1mM2HQTZudB6gtdCxs5XtQkeAASBAqFgAxV?=
 =?us-ascii?Q?J/hQ/kkTcFYIJBhhHLOp1eoVdyHHDwtZjBiWnU4Cyp3ndPOiJti+fNe5wjH9?=
 =?us-ascii?Q?egwZOkxncgldAspLHQN4D0ZvKdOo6q3mOFALew1qC2wmKEamyW+yo1OneMc3?=
 =?us-ascii?Q?qx0uXZ+ekNMvGBPBjt6r1FV8cn9K/IIjY5f0/mgmNlCW/6uLzeYIKREz01Xs?=
 =?us-ascii?Q?FkyATZ4ftOgyIcu5uOzUp6u8eHAwUloi/giXFJttE4o2n7DxMcdJpY0YsGeo?=
 =?us-ascii?Q?qJHfZyMjNDQAqxKRjU2fgO/v4ZYPsRXto5iyO1M5IVF1W+ru/kiJB040TjF0?=
 =?us-ascii?Q?PJ8RHedcELkQuNkYOvQcoQmPLTEkBcWIXivinBNQ86ZsrNl3iLwy4kaGaDdz?=
 =?us-ascii?Q?6C5T8fJFo9RSH00TCtZMdslI1nupKcabR37tvnOJa53bEHvmZktaORMY3UQp?=
 =?us-ascii?Q?qvtkn5fBqE87bkFrJWx8SkPv7UUpDHLGbMWClBgMo/dGuerJNvYSRDUWqRHa?=
 =?us-ascii?Q?sNB7QmziKinzouEkojlWVpPDLtTB7yPhzOZ6xM9V6g5eLtGsZKZAUsj27TtH?=
 =?us-ascii?Q?uUaENN3aHBM06JWrq+HPO1YVhbSMJwjar4wSkyY17Txf7r/0ordHkS9+LuO/?=
 =?us-ascii?Q?kIiEvuZTezb01QTpyUJeSUfKd+kDMqlT6S0BR7fbzz22Dz5urnl+647wE0F5?=
 =?us-ascii?Q?ckPJCDKZN8C09OJ8o6CPYwXGB6CqzR5g4SdYbAPpoSBzm9qxumYcni85gAYZ?=
 =?us-ascii?Q?WXi+bWjAHfWo4F4zXtw2mJKfRFi9/cMrymbPbpL9hRg6aVSgyEXcUrP2fEFR?=
 =?us-ascii?Q?+82+zsQI5SYbXPGoRyt01X0JZt6u+P3wtVTj5cEZqSMlw74zjDiqkuhHAY1l?=
 =?us-ascii?Q?8YGmaFcCddl2lw0fc1vQhKlwQZszZuKWZbE7wU/07ziGDV9dqI0xITs854V+?=
 =?us-ascii?Q?6iKlOPH2XrUijQmJINIsb8T++4fDZWZvn/BeK6/kW1ZZ0iNrQ+I/Hi/1K2sd?=
 =?us-ascii?Q?F/9l1LlP6vJwkMU93PLOmbQek7eOv4ob0I2LsHCeKabahQPjg3/5+g/g1fIN?=
 =?us-ascii?Q?P+AYIPvjEDd4xcryGvhdTb9qRcObtRLpLVg/9skthzhsW6vLF6px2btHQt+E?=
 =?us-ascii?Q?H0kdO5MU3p//i/1njokyfZOliVzgI5zYJWXNUhtfNgJmv1K3GHUSxQUe19/1?=
 =?us-ascii?Q?jq2yRIdKgdtqhkz6pyFPzetIS2X6UPspxzaitkpDMhgsu4PuLXf5Ll0Azh6d?=
 =?us-ascii?Q?MdMITmEoprfZcsZIhvZHj86zU9PcL0rBagQP4cFVIojcha3WcTEjYuqJqQnm?=
 =?us-ascii?Q?JQJype+4bwD5FeEDHsBu7uBOkZIrOlbnNOzxMWGoE2QZ1/slSRy9xpVnGlqj?=
 =?us-ascii?Q?eOHqcRz7j8fVaTvw+H6dHAIY5LF2/oY=3D?=
X-Exchange-RoutingPolicyChecked: fiXGG/uq0ni/TD5YsQf+7XB/3OIi5Zv1pXl7JC7vQza+86dveJaPmGWeJpTDFwXpBOGykzZ2JS08XJTGDFIv/Ik+VfJjJFuazbH+XFfIYrbysGAzu0u+ihlnKT+hA04meHLgU1GsAnD7nSMDX6NjdjRz5C3n44kR2Wm6LNFgUK2kzlYUMDWDDuhwexHwYLapaTVkkhws6hWenQ/gf+qJ3qOGWfOkgfszF5vEHcwCQSs2f4dpk/zy7S9o21/huJFX6vW9kkbuPXFX9q8WvwIqOEhYOXotfk5bjTagB4l8cRmYlQ9nKzuV7XmMD1CLwgwZgiCkxjwL5ROJc/mvWrccJQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f52442b9-c85d-4c94-e8a9-08df13df87b5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:44:48.7674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: joFT/uxeyLQxacYAsLt5so5Cj94sXdpPTkuk9Z7ONz+biwg88xqWimaFgb7+QbpAsF3KOW+Z7d6WDqEK31J58PjW0mCBiNMjVGTGSnh497Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7380
X-Proofpoint-GUID: rnFeN0odM08iXz9gj7odNRaiY4vShV-e
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfX7zmgByKtVDO/
 sMMsDsb/pm66Tyhbiqn9Pzo2XDLbPuo8OseAdQRmsa+uh/c5a0XYpI5/4cFzd0y7PPWtHL7EZvC
 kytv7cVuk9sdK8xzAzm2OvuwozUwhfg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfX6FAZ131tOhRZ
 gXuOMU/atiFn4btLM+IMqIqxsBgPcRi+gH917zBDxuaNT5crThTk2RNlaYIPy0VGOJ/8Z43K+yL
 PccjQNWTKYE4JI/YXcEUYCSLnkBLDkAs0kNl3j5XRLVcptaO6x1D5s+4NUAbe8uOvQA3+yBnssM
 TDzomF7y/jtqzkfx6kF5Ex04w7vWZbEZTUOjEbwGCJ6T1RxAb36QEu1fPcAWrr3EVt+9q82bjTD
 NidRibG9wJqHh53ku9Nre6MIWO+7wh0gKGY01dR2f+fmoOIMM+Giz/f1cGzprwDFgjzE8For/7s
 DwJnuhzTLBI1yljFZxnBlanPFKLv14TCid3GsRtLbIO/YvkU8V32sqfepGKH9f7zV44sAD6BawA
 5x70Shc/eT3NaLAU15Ik+2X+T/ZY54nkip1Et992tBNOX1AM/Ikwh5hSPVN7saFkrw9jzy6iBER
 BIgMD3fVHR67hpWBfDw==
X-Proofpoint-ORIG-GUID: rnFeN0odM08iXz9gj7odNRaiY4vShV-e
X-Authority-Analysis: v=2.4 cv=Ps4G/AM3 c=1 sm=1 tr=0 ts=6aaa7326 cx=c_pps
 a=WPXs+xwE9Zb4LCNJX07eKw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=01ND9n3NiX1-kDoXiQMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/intc/i8259.h         |  8 ++---
 include/hw/isa/i8259_internal.h | 10 +++---
 hw/i386/kvm/i8259.c             | 10 +++---
 hw/intc/i8259.c                 | 34 +++++++++----------
 hw/intc/i8259_common.c          | 58 ++++++++++++++++-----------------
 5 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/include/hw/intc/i8259.h b/include/hw/intc/i8259.h
index 1f2420231f..1921a30371 100644
--- a/include/hw/intc/i8259.h
+++ b/include/hw/intc/i8259.h
@@ -3,9 +3,9 @@
 
 /* i8259.c */
 
-typedef struct PICCommonState PICCommonState;
+typedef struct I8259CommonState I8259CommonState;
 
-extern PICCommonState *isa_pic;
+extern I8259CommonState *isa_pic;
 
 /*
  * i8259_init()
@@ -16,7 +16,7 @@ extern PICCommonState *isa_pic;
  */
 qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in);
 qemu_irq *kvm_i8259_init(ISABus *bus);
-int pic_get_output(PICCommonState *s);
-int pic_read_irq(PICCommonState *s);
+int pic_get_output(I8259CommonState *s);
+int pic_read_irq(I8259CommonState *s);
 
 #endif
diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index 289d08b7d7..7a2f9addaf 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -32,16 +32,16 @@
 
 
 #define TYPE_I8259_COMMON "i8259-common"
-OBJECT_DECLARE_TYPE(PICCommonState, PICCommonClass, I8259_COMMON)
+OBJECT_DECLARE_TYPE(I8259CommonState, PICCommonClass, I8259_COMMON)
 
 struct PICCommonClass {
     DeviceClass parent_class;
 
-    void (*pre_save)(PICCommonState *s);
-    void (*post_load)(PICCommonState *s);
+    void (*pre_save)(I8259CommonState *s);
+    void (*post_load)(I8259CommonState *s);
 };
 
-struct PICCommonState {
+struct I8259CommonState {
     ISADevice parent_obj;
 
     uint8_t last_irr; /* edge detection */
@@ -70,7 +70,7 @@ struct PICCommonState {
     MemoryRegion elcr_io;
 };
 
-void pic_reset_common(PICCommonState *s);
+void pic_reset_common(I8259CommonState *s);
 ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master);
 void pic_stat_update_irq(int irq, int level);
 
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 14029783e5..f10643a120 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -34,7 +34,7 @@ struct KVMPICClass {
     DeviceRealize parent_realize;
 };
 
-static void kvm_pic_get(PICCommonState *s)
+static void kvm_pic_get(I8259CommonState *s)
 {
     struct kvm_irqchip chip;
     struct kvm_pic_state *kpic;
@@ -67,7 +67,7 @@ static void kvm_pic_get(PICCommonState *s)
     s->elcr_mask = kpic->elcr_mask;
 }
 
-static void kvm_pic_put(PICCommonState *s)
+static void kvm_pic_put(I8259CommonState *s)
 {
     struct kvm_irqchip chip;
     struct kvm_pic_state *kpic;
@@ -103,7 +103,7 @@ static void kvm_pic_put(PICCommonState *s)
 
 static void kvm_pic_reset(DeviceState *dev)
 {
-    PICCommonState *s = I8259_COMMON(dev);
+    I8259CommonState *s = I8259_COMMON(dev);
 
     s->elcr = 0;
     pic_reset_common(s);
@@ -122,7 +122,7 @@ static void kvm_pic_set_irq(void *opaque, int irq, int level)
 
 static void kvm_pic_realize(DeviceState *dev, Error **errp)
 {
-    PICCommonState *s = I8259_COMMON(dev);
+    I8259CommonState *s = I8259_COMMON(dev);
     KVMPICClass *kpc = KVM_PIC_GET_CLASS(dev);
 
     memory_region_init_io(&s->base_io, OBJECT(dev), NULL, NULL, "kvm-pic", 2);
@@ -154,7 +154,7 @@ static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo kvm_i8259_info = {
     .name = TYPE_KVM_I8259,
     .parent = TYPE_I8259_COMMON,
-    .instance_size = sizeof(PICCommonState),
+    .instance_size = sizeof(I8259CommonState),
     .class_init = kvm_i8259_class_init,
     .class_size = sizeof(KVMPICClass),
 };
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 52e24d333e..45db87a2ad 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -52,12 +52,12 @@ struct PICClass {
 #ifdef DEBUG_IRQ_LATENCY
 static int64_t irq_time[16];
 #endif
-PICCommonState *isa_pic;
-static PICCommonState *slave_pic;
+I8259CommonState *isa_pic;
+static I8259CommonState *slave_pic;
 
 /* return the highest priority found in mask (highest = smallest
    number). Return 8 if no irq */
-static int get_priority(PICCommonState *s, int mask)
+static int get_priority(I8259CommonState *s, int mask)
 {
     int priority;
 
@@ -72,7 +72,7 @@ static int get_priority(PICCommonState *s, int mask)
 }
 
 /* return the pic wanted interrupt. return -1 if none */
-static int pic_get_irq(PICCommonState *s)
+static int pic_get_irq(I8259CommonState *s)
 {
     int mask, cur_priority, priority;
 
@@ -101,7 +101,7 @@ static int pic_get_irq(PICCommonState *s)
 }
 
 /* Update INT output. Must be called every time the output may have changed. */
-static void pic_update_irq(PICCommonState *s)
+static void pic_update_irq(I8259CommonState *s)
 {
     int irq;
 
@@ -117,7 +117,7 @@ static void pic_update_irq(PICCommonState *s)
 /* set irq level. If an edge is detected, then the IRR is set to 1 */
 static void pic_set_irq(void *opaque, int irq, int level)
 {
-    PICCommonState *s = opaque;
+    I8259CommonState *s = opaque;
     int mask = 1 << irq;
     int irq_index = s->master ? irq : irq + 8;
 
@@ -154,7 +154,7 @@ static void pic_set_irq(void *opaque, int irq, int level)
 }
 
 /* acknowledge interrupt 'irq' */
-static void pic_intack(PICCommonState *s, int irq)
+static void pic_intack(I8259CommonState *s, int irq)
 {
     if (s->auto_eoi) {
         if (s->rotate_on_auto_eoi) {
@@ -170,7 +170,7 @@ static void pic_intack(PICCommonState *s, int irq)
     pic_update_irq(s);
 }
 
-int pic_read_irq(PICCommonState *s)
+int pic_read_irq(I8259CommonState *s)
 {
     int irq, intno;
 
@@ -210,7 +210,7 @@ int pic_read_irq(PICCommonState *s)
     return intno;
 }
 
-static void pic_init_reset(PICCommonState *s)
+static void pic_init_reset(I8259CommonState *s)
 {
     pic_reset_common(s);
     pic_update_irq(s);
@@ -218,7 +218,7 @@ static void pic_init_reset(PICCommonState *s)
 
 static void pic_reset(DeviceState *dev)
 {
-    PICCommonState *s = I8259_COMMON(dev);
+    I8259CommonState *s = I8259_COMMON(dev);
 
     s->elcr = 0;
     s->ltim = 0;
@@ -228,7 +228,7 @@ static void pic_reset(DeviceState *dev)
 static void pic_ioport_write(void *opaque, hwaddr addr64,
                              uint64_t val64, unsigned size)
 {
-    PICCommonState *s = opaque;
+    I8259CommonState *s = opaque;
     uint32_t addr = addr64;
     uint32_t val = val64;
     int priority, cmd, irq;
@@ -321,7 +321,7 @@ static void pic_ioport_write(void *opaque, hwaddr addr64,
 static uint64_t pic_ioport_read(void *opaque, hwaddr addr,
                                 unsigned size)
 {
-    PICCommonState *s = opaque;
+    I8259CommonState *s = opaque;
     int ret;
 
     if (s->poll) {
@@ -348,7 +348,7 @@ static uint64_t pic_ioport_read(void *opaque, hwaddr addr,
     return ret;
 }
 
-int pic_get_output(PICCommonState *s)
+int pic_get_output(I8259CommonState *s)
 {
     return (pic_get_irq(s) >= 0);
 }
@@ -356,14 +356,14 @@ int pic_get_output(PICCommonState *s)
 static void elcr_ioport_write(void *opaque, hwaddr addr,
                               uint64_t val, unsigned size)
 {
-    PICCommonState *s = opaque;
+    I8259CommonState *s = opaque;
     s->elcr = val & s->elcr_mask;
 }
 
 static uint64_t elcr_ioport_read(void *opaque, hwaddr addr,
                                  unsigned size)
 {
-    PICCommonState *s = opaque;
+    I8259CommonState *s = opaque;
     return s->elcr;
 }
 
@@ -387,7 +387,7 @@ static const MemoryRegionOps pic_elcr_ioport_ops = {
 
 static void pic_realize(DeviceState *dev, Error **errp)
 {
-    PICCommonState *s = I8259_COMMON(dev);
+    I8259CommonState *s = I8259_COMMON(dev);
     PICClass *pc = PIC_GET_CLASS(dev);
 
     memory_region_init_io(&s->base_io, OBJECT(s), &pic_base_ioport_ops, s,
@@ -444,7 +444,7 @@ static void i8259_class_init(ObjectClass *klass, const void *data)
 
 static const TypeInfo i8259_info = {
     .name       = TYPE_I8259,
-    .instance_size = sizeof(PICCommonState),
+    .instance_size = sizeof(I8259CommonState),
     .parent     = TYPE_I8259_COMMON,
     .class_init = i8259_class_init,
     .class_size = sizeof(PICClass),
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index e2f997e161..17040bdb1e 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -33,7 +33,7 @@
 static int irq_level[16];
 static uint64_t irq_count[16];
 
-void pic_reset_common(PICCommonState *s)
+void pic_reset_common(I8259CommonState *s)
 {
     s->last_irr = 0;
     s->irr &= s->elcr;
@@ -55,7 +55,7 @@ void pic_reset_common(PICCommonState *s)
 
 static int pic_dispatch_pre_save(void *opaque)
 {
-    PICCommonState *s = opaque;
+    I8259CommonState *s = opaque;
     PICCommonClass *info = I8259_COMMON_GET_CLASS(s);
 
     if (info->pre_save) {
@@ -67,7 +67,7 @@ static int pic_dispatch_pre_save(void *opaque)
 
 static int pic_dispatch_post_load(void *opaque, int version_id)
 {
-    PICCommonState *s = opaque;
+    I8259CommonState *s = opaque;
     PICCommonClass *info = I8259_COMMON_GET_CLASS(s);
 
     if (info->post_load) {
@@ -78,7 +78,7 @@ static int pic_dispatch_post_load(void *opaque, int version_id)
 
 static void pic_common_realize(DeviceState *dev, Error **errp)
 {
-    PICCommonState *s = I8259_COMMON(dev);
+    I8259CommonState *s = I8259_COMMON(dev);
     ISADevice *isa = ISA_DEVICE(dev);
 
     isa_register_ioport(isa, &s->base_io, s->iobase);
@@ -118,7 +118,7 @@ void pic_stat_update_irq(int irq, int level)
 static bool pic_get_statistics(InterruptStatsProvider *obj,
                                uint64_t **irq_counts, unsigned int *nb_irqs)
 {
-    PICCommonState *s = I8259_COMMON(obj);
+    I8259CommonState *s = I8259_COMMON(obj);
 
     if (s->master) {
         *irq_counts = irq_count;
@@ -133,7 +133,7 @@ static bool pic_get_statistics(InterruptStatsProvider *obj,
 
 static void pic_print_info(InterruptStatsProvider *obj, GString *buf)
 {
-    PICCommonState *s = I8259_COMMON(obj);
+    I8259CommonState *s = I8259_COMMON(obj);
 
     pic_dispatch_pre_save(s);
     g_string_append_printf(buf, "pic%d: irr=%02x imr=%02x isr=%02x hprio=%d "
@@ -146,7 +146,7 @@ static void pic_print_info(InterruptStatsProvider *obj, GString *buf)
 
 static bool ltim_state_needed(void *opaque)
 {
-    PICCommonState *s = I8259_COMMON(opaque);
+    I8259CommonState *s = I8259_COMMON(opaque);
 
     return !!s->ltim;
 }
@@ -157,7 +157,7 @@ static const VMStateDescription vmstate_pic_ltim = {
     .minimum_version_id = 1,
     .needed = ltim_state_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT8(ltim, PICCommonState),
+        VMSTATE_UINT8(ltim, I8259CommonState),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -169,22 +169,22 @@ static const VMStateDescription vmstate_pic_common = {
     .pre_save = pic_dispatch_pre_save,
     .post_load = pic_dispatch_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT8(last_irr, PICCommonState),
-        VMSTATE_UINT8(irr, PICCommonState),
-        VMSTATE_UINT8(imr, PICCommonState),
-        VMSTATE_UINT8(isr, PICCommonState),
-        VMSTATE_UINT8(priority_add, PICCommonState),
-        VMSTATE_UINT8(irq_base, PICCommonState),
-        VMSTATE_UINT8(read_reg_select, PICCommonState),
-        VMSTATE_UINT8(poll, PICCommonState),
-        VMSTATE_UINT8(special_mask, PICCommonState),
-        VMSTATE_UINT8(init_state, PICCommonState),
-        VMSTATE_UINT8(auto_eoi, PICCommonState),
-        VMSTATE_UINT8(rotate_on_auto_eoi, PICCommonState),
-        VMSTATE_UINT8(special_fully_nested_mode, PICCommonState),
-        VMSTATE_UINT8(init4, PICCommonState),
-        VMSTATE_UINT8(single_mode, PICCommonState),
-        VMSTATE_UINT8(elcr, PICCommonState),
+        VMSTATE_UINT8(last_irr, I8259CommonState),
+        VMSTATE_UINT8(irr, I8259CommonState),
+        VMSTATE_UINT8(imr, I8259CommonState),
+        VMSTATE_UINT8(isr, I8259CommonState),
+        VMSTATE_UINT8(priority_add, I8259CommonState),
+        VMSTATE_UINT8(irq_base, I8259CommonState),
+        VMSTATE_UINT8(read_reg_select, I8259CommonState),
+        VMSTATE_UINT8(poll, I8259CommonState),
+        VMSTATE_UINT8(special_mask, I8259CommonState),
+        VMSTATE_UINT8(init_state, I8259CommonState),
+        VMSTATE_UINT8(auto_eoi, I8259CommonState),
+        VMSTATE_UINT8(rotate_on_auto_eoi, I8259CommonState),
+        VMSTATE_UINT8(special_fully_nested_mode, I8259CommonState),
+        VMSTATE_UINT8(init4, I8259CommonState),
+        VMSTATE_UINT8(single_mode, I8259CommonState),
+        VMSTATE_UINT8(elcr, I8259CommonState),
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
@@ -194,10 +194,10 @@ static const VMStateDescription vmstate_pic_common = {
 };
 
 static const Property pic_properties_common[] = {
-    DEFINE_PROP_UINT32("iobase", PICCommonState, iobase,  -1),
-    DEFINE_PROP_UINT32("elcr_addr", PICCommonState, elcr_addr,  -1),
-    DEFINE_PROP_UINT8("elcr_mask", PICCommonState, elcr_mask,  -1),
-    DEFINE_PROP_BIT("master", PICCommonState, master,  0, false),
+    DEFINE_PROP_UINT32("iobase", I8259CommonState, iobase,  -1),
+    DEFINE_PROP_UINT32("elcr_addr", I8259CommonState, elcr_addr,  -1),
+    DEFINE_PROP_UINT8("elcr_mask", I8259CommonState, elcr_mask,  -1),
+    DEFINE_PROP_BIT("master", I8259CommonState, master,  0, false),
 };
 
 static void pic_common_class_init(ObjectClass *klass, const void *data)
@@ -222,7 +222,7 @@ static void pic_common_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo pic_common_type = {
     .name = TYPE_I8259_COMMON,
     .parent = TYPE_ISA_DEVICE,
-    .instance_size = sizeof(PICCommonState),
+    .instance_size = sizeof(I8259CommonState),
     .class_size = sizeof(PICCommonClass),
     .class_init = pic_common_class_init,
     .abstract = true,
-- 
2.43.0


