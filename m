Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1CECCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHipi-0003VR-R4; Fri, 16 Oct 2026 10:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHip3-00030g-Fq
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:22:15 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHip0-0006kK-KM
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:22:12 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5JgU3050717; Fri, 16 Oct 2026 07:21:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=YBENO+AVPrr9uTUjU0EffDFLvrFbeW1XWzcjaPVFV
 10=; b=TSIhQLVFGwj6fbaA2GdfaEKLqGVgRqEdQYGxp300ggbHy7PcJNF36ALIO
 8Kd4PAh6T4R22BMy0DQ6GNKbNLDhUZ+CypbjVhr+L0Wp5qVfcCApA4gkiQn03HxT
 MTS3fjLQoBQlDVT0rCxL2p2ti8a2BHgzXic4+R12AmOJQzY7EaovPwCu0FQ/KDlx
 ysNAAxAjGMtSIJoc7SNXJxW3h2sszQDnfXe0MLJ0c128YVl7hOJqrNY7d2LM7yCJ
 i5XqjVJEonWVhoUKs8XZ0QeTGbq7gtmFnMEU5yyRxQCDCmnolWWtNUoeOKLRUCPw
 DSI4pkDBjrPpn3acu3Xd0ijLaLtmw==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021076.outbound.protection.outlook.com [52.101.52.76])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hb7t19qsb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 07:21:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMHEqxa+8VNhEJCJ3Vu+Q1OpgfTz2olpN3De7dgGD9ewTakFPJYJm1ocRfPK9tiFB4cQpjnol0T5GBGSPHtWAJMPHSzup6TPyuTnOj2Dbds1tsW2lIxiBYP30GXhBcksu2vm7FvrBoVZ+4tfggz35AKaCqyej9in3VWnhIgeQxJrUECa8WTbPcuoSbGaN9DbM/B0pbyDNP5YO82bx6kVvF00x3sJ///c8hQQU9pLYWKERxyw/e82/xX5XV2qux/0hACUOIAUgSXpc9tjnhUPHIOvlge5TwZnAiLLP4hM1n48j0qiUVpd8kH+2Cv6FJqR7pp/nYkC0Kx8eL37biAyMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBENO+AVPrr9uTUjU0EffDFLvrFbeW1XWzcjaPVFV10=;
 b=BglMhNcHuYCZCe0SsbE+KVm0/E2mhQRza/YnYsV3adpIHnd1YG3fo4YomGR7SR5zTr+a+fHnAVaKXuRby1nDjEpT2+VFZHArVZ5VDDJxGTVkpxsEZeBNhWkzW9UpD+hzlwGM7ut1Srq09noWGPhZjDj3YtF5dTm2n4tnLsDDLTeefFxQ+7PtaciRvyL1m+s5IgaqlBgP1ji0U1xLVIWJNqDxPcgZI8WWJu26WSntkLeyaFiuN/9KiUvKRZA/QLsiSfkuD+HjVSV46NwBOEMJlide5WtRPK+zJ6E9OARIs+bJJUh8vM9vpxtiGEs2r4xGUZBmM9o0iZ863ZINETvKgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBENO+AVPrr9uTUjU0EffDFLvrFbeW1XWzcjaPVFV10=;
 b=y0yc5k77mP1IFuLQhsLyjjrdwnjEpScLgla58rQL3fEV4pdKCVnyzAq9IntiqCTBs5zFLfhp5KJJHwThmSCswz4DPsFZTSxrD8MRGolYzDdfOaMDujvGMMwmhHc2MHE35KSiQ98u18KLCzeyCAWchAHQMC0tnUSHtEUne4v+4nVBLZwMp9lA3HGT7j9FV7JwqkBXrb7B9Il035dD+ETxj7uI5bOirF5lqxrcrumzHIhrIM09A/ZvHH+cWci0vAyUbhhHdrFN8TdIHle9OQ90kdW2HFBXisrHaYtavGdWEfl/y/Clp6tq8v32j/0api3YBj7BLjcT8uSovAw1zaYr5A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSVPR02MB11424.namprd02.prod.outlook.com (2603:10b6:8:352::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 14:21:47 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 14:21:47 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 17/27] kvm/i8259.c: convert to use DEFINE_TYPES() macro
Date: Fri, 16 Oct 2026 15:19:23 +0100
Message-ID: <20261016142031.1204281-18-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:254::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSVPR02MB11424:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ffdc3f-0a42-4cbf-f03a-08df2b90cfc8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|10067099003|18002099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: ja5sO/VtfoyKEJpIDMNve6lZX4Osdl2tpjOhCf8e+pGPrwdsONADQ5148himFqhrYyPUgMhb5dMCKUI6zKXghrUNIwrxG6ZAxHp5+WuDgRYGfuIu8HlMO2lBQs6szRhYDl+l08iiWcpV8EBGhcXek8ARZLC+rivDOdktQh/dsE3KgtqPLegEIlsejdxckoeL5BpllqzPYQRNAx54OOyXysIW5zoEGIorTE1ydOClO9Wv52uemDBneFz2c13Ak2f7fZg4Oq0NEItpHWiBLQ8h95Swz9oJ1YoL2lCWtvBgwb4M5Npgbao8ve8bPoxu+fHJKxcseLxZKrrjfrBueYxH6y9sKv8BCgwmrXW2J28yffkGDVsqrBk5BDmMOyrwsRclDi8fVC2N57GDXW722evDoeiTdcnmgX3hJmQqowR4AJJQv+4fVb3mY1yR9dBbYLUAK1zxxklx8/W6nK6fvl4wLZUn1nigNIT8prDFwIs5g4Mja/VmkCyT/nOdZ3P53udeiltXFFmLkD6F822SBjh7U2Mlmntej7XFt/Cad9gR92SB3tke+zsKUbCBJsEsA4bw+ML/0QoCtqn/TYFGml3+1z9r4NUMJFtNAaRYd7Y3uTn/9r9YCxQ+1Vg8KdtOW3aX+rkkSlk5yYn+JNzXyB4NvMBxwvloQt5Ix+THxQxvsSM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(10067099003)(18002099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ydPtBzWaeJIqLY9DLlFLnielkCW67P+MlMaSU7uWuNl4YctqctVQyZyAueMM?=
 =?us-ascii?Q?SN2kYgOopkt29yeBiZCd0QYh+0LvvK2zoO1fJM0Lq1E/CLmYzQvBkpq56SOP?=
 =?us-ascii?Q?rljBYWPy6GiXlBANRrARHou0Xw8rD+pDo/aYf5ld7x5hAWucpMLP1qQ1yq6/?=
 =?us-ascii?Q?sBSgQ+QOpx2Pxzy+T6f7XoIBsRR7SCuR5uCPwoVD6awc6F6I4Ahh8S89K9Q+?=
 =?us-ascii?Q?mkZlqGJStSIrRxJi1Bv6rwACEN4jIiXJSp7sroA1SteGw0Odm/h1/wAMEPv6?=
 =?us-ascii?Q?NHyNERchJAbLxvXklnrzKQmgBgze+0hv+bB1MlL03zaQCW0NVACQeL5DMN4T?=
 =?us-ascii?Q?cUxcDahnpqM5CsDvG7wnjNR/dOfhYS9wbViBgz2F/XaCSdlH9X5DA2LuQgZl?=
 =?us-ascii?Q?EWJEslN+JN02xpvSVTAmiP29LpGc3Em5r8OAaQoXQ3rASBdDSOHreYHg08E/?=
 =?us-ascii?Q?MFDBpHySTQeVY2qc1/1QAWxD6v1ZNClOsb5oJsL3kb9y0ktIwf/F7jrpav1X?=
 =?us-ascii?Q?Id2CGZPqvuGJlnAS/9P9oDcyBkCdIce3Y4TXBy0xXIv6eYYzlDz2te6um/sI?=
 =?us-ascii?Q?k7E5b8lKZfiQiUZIc2K8oenCUPDIfba+aUQOdt6lBW2WS1wB79vpxHKkpnEi?=
 =?us-ascii?Q?ZlYZjzKyyqQeIKGl9eXXIIp8kDuvuAsQ2maMs8WG0cDwZu94Q4NnMWO8VwcB?=
 =?us-ascii?Q?fyD3hJSrHJOFX2X9aackhkbJMYxlAbSr0z5Ho6A/0hGbcTcsGc8VOrHGv4mP?=
 =?us-ascii?Q?FDwbKRbAKN584Uk45ckPPtSQ2oDNblBNaxFwc2HBcpIgDY2bMdZL2H2G/hvt?=
 =?us-ascii?Q?hsVsb2/oVE+4LairN1kDroAHpFHXYVEQ3xCcPWwiC+bA+zSis6+0URvar7Y1?=
 =?us-ascii?Q?wwm8LbOTrn+oTW0gh2xTChUD7o0+Y7cScbXt8hr6bHuWq4Ae40uJGLBI8BXw?=
 =?us-ascii?Q?PDC/h00Puh0lgxy1WBvMCsAZ3mY7bjc/TUh8J0Fe89wBDWnxbUqivns1/URn?=
 =?us-ascii?Q?6o+mATT3LH3E6ocP083yfibfiNKtFZEz73OzSWHImu2luBFgo2HPDs0NE/eM?=
 =?us-ascii?Q?Ysweho1B1yOzzUGM92EfjlcLexgw8noEEBO6xUNdS0/OCYfl90xP2f1eDph8?=
 =?us-ascii?Q?Y+vDGSHiGHLbZlIzsOG8CVxCoeDhoWSFq83pZsvg1C7rNcY2/wLLBdeedKjO?=
 =?us-ascii?Q?hg/MBRFJuDJPEJUwemMTiE+GUtMnMnKPyHM0N+C7RqeLZCCHCrGH7KOVLiUV?=
 =?us-ascii?Q?C7rXIRBw/qIMf+0NhOUV/o20RDV1heZn0r1aC4YF9BFO+LRHGtjfAu2LLBue?=
 =?us-ascii?Q?m2yIsF9EpTWwrwPBqRIa+dxfa7pCUVamwJkFbn/w3XHbF+O8ItDWk6fStD6p?=
 =?us-ascii?Q?aNDCvNB0YFk9WxF7lZBiRFfEJgA4beUpYbOZOYxXVd8sF7KfWF5TGfGsfQX5?=
 =?us-ascii?Q?xs6u6y/fiETVM3Fkdgi/1MqVGp2zbY+UBwxn5N3hiDVTW583yvvzJ5m6nQx5?=
 =?us-ascii?Q?WZ3K8U0uMVGVTPLOHTN4la+R3rCtz430DjOmjLBmRjgRw7XAwSsKGrwWYxCk?=
 =?us-ascii?Q?5Bm8Fo1Q8KK9fdxCdXP+JlrrHN8Xmjegte6MOO1iwY3JB0mXd85pQvI/jIQQ?=
 =?us-ascii?Q?TN1tv4w902aGNieprhCoAAAeE8jULMZZj/rsB7gisbnd3Y9y34vPh/2pUNrc?=
 =?us-ascii?Q?OpjrIkb9FIosOFqVmnXeeEYicWbsqKDiOpABzKbKCNKBcfZHTJsKKTwOlq0u?=
 =?us-ascii?Q?kO0bUi6XYLSIBsGyKiJ9mv7kLMJmNFQ=3D?=
X-Exchange-RoutingPolicyChecked: oW95PpnVf1v7XGjQKtzJoiTtd/v+Gocblzb+QbMm7iZACz1vfgXD4U79ylsMJf6OilP6qyARQsFNTPTPWsMzGKZb6pgvhd/lQ+VshH2AuWTYkaFwjaT8j9X6F9lHRc4uQNbnlmJMOhu/q9N70seexaMH86iamo49BD4jcTzute+LJnQE6Fur50vtBGG58pRSRt/r8ZWAZ0Ic8MYC+YplqwJgTN/umTNRaQEH50ECtC5MScRgB/SPFGML3q7JpubE1o6/zt69/3LlT+yMzlJBhHf1YRgRCuqZmOGRDaPDlIzEJv2qElxUuSS44ObnkC/ahgCj0sfMFrFysjeQeseaMQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ffdc3f-0a42-4cbf-f03a-08df2b90cfc8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:21:47.2107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vHckLfFReYsR/AF3V+lTmUedJhJT1JHx9nCIE5by1zI2ENTuRFo8+lwIvmgCKg6he5dutnSmXOsdUrVdgBjbA4nzgIT2FzL9wUg28z2MUFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB11424
X-Authority-Analysis: v=2.4 cv=LsYHWXdc c=1 sm=1 tr=0 ts=6ad232fc cx=c_pps
 a=iImJYxtVBKilH24NLj+lVw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=CQnoaSmAlUSJywai4vEA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX37bWWlROPu1x
 4/kdC/xVyoUZXpB47kZQY4ujHZC9XdOY6IL9xs/rRJi2DinCUshhYa2zMWz7TsZLoQ9IKsXhiVN
 oePokq6KHoVdyYXZEK6Hu5BJ5dz35Oo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX5//kecltZS4q
 Jl7T8Hocxhh1fQd0p/HLMSDlFSdqCEJM23MwFT/9fZE40DL6tQ3j+uRoStkCek4VoCsoR9DN4yo
 DlQeeiALDLlAtC5HNGlGnflXSa09QaDiEFZDroni5ygQmSMj4ZJKom4kQmI/fpy2uZpXwwlHrBj
 3826A5/my23i/CdWYGV2wPAigpIQvL6eE5yANFMrmQ5YcoHB+Rhxh61F20MOceI1CpjDEalqNmd
 mgBreGk6OYXM51rDcpxGMTnAGKmQlr3T4qXv3+5oLxUhTplFYp5/CKg35fPH1OPmKDbTTVmbPuY
 W9RpsViTmvDpTllxyhjfn3WQz5Y6OBfOdzbNZDuUiIGvo0+MhSKfmGIHPQGjAyPYVLZ/A8XmPG+
 ZVwJr1I5FOzqzhxuuEGN3aV//gP5L64Ir5ivwd9WZmlm0sMoTKBr2lpTdbSYptAQ9LlFjF/4ejJ
 Ucs8ttds2t1VkEkpCzw==
X-Proofpoint-ORIG-GUID: IGZ_pgtczq3NalqMEMKPUJZ7An8LRvae
X-Proofpoint-GUID: IGZ_pgtczq3NalqMEMKPUJZ7An8LRvae
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i386/kvm/i8259.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 952f58be11..9ee23b5695 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -154,17 +154,14 @@ static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
     k->post_load  = kvm_i8259_put;
 }
 
-static const TypeInfo kvm_i8259_info = {
-    .name = TYPE_KVM_I8259,
-    .parent = TYPE_I8259_COMMON,
-    .instance_size = sizeof(KVMI8259State),
-    .class_init = kvm_i8259_class_init,
-    .class_size = sizeof(KVMI8259Class),
+static const TypeInfo kvm_i8259_type_infos[] = {
+    {
+        .name = TYPE_KVM_I8259,
+        .parent = TYPE_I8259_COMMON,
+        .instance_size = sizeof(KVMI8259State),
+        .class_init = kvm_i8259_class_init,
+        .class_size = sizeof(KVMI8259Class),
+    },
 };
 
-static void kvm_i8259_register_types(void)
-{
-    type_register_static(&kvm_i8259_info);
-}
-
-type_init(kvm_i8259_register_types)
+DEFINE_TYPES(kvm_i8259_type_infos)
-- 
2.43.0


