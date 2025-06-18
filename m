Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DE7C71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 11:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRqyI-0001BQ-2J; Wed, 18 Jun 2025 07:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uRqyE-0001B5-IW
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:28:46 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uRqy9-0002T6-DR
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:28:45 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I4kZVC001616;
 Wed, 18 Jun 2025 04:28:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=JYZYS8zI/tjU/
 16J9pFNqZVir/UQQKqsi1+FTiw7Dxw=; b=LF7/MOQvCfflmBestoC7DMhpoiIC4
 lcI9+TU8MLm2x0OqrjLW/V+EsdBrNMwn0XmrHNDg9FtLOBj6IGCG8m5eU8rXEP4N
 Tm85vjRBsCJ2zx1zZkFeJDwroVOlQSYBV2Fr9CKLDhIgejaeBSF4UXJNFiT6/Uab
 ZN+OLHUWZMjmYSiAnfwp6YXVyD/YV5h6sSXPyAfmVFaQJVHuV/V0WJ/1FrtTynuU
 VxVsrmB3R/gyzHkFxRHop9G6y40hja2swE0VdTjR4pRP6bR3GKEJUjkC4uVrVK+t
 JiXW4v9PBD+gG1iZYETzM+q3oJnBdQrx4+fXXktPTXM+aZNbUB8pNxyyw==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2134.outbound.protection.outlook.com [40.107.93.134])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4796mbgp5j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Jun 2025 04:28:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfKgPI7MV6QrxhRyL3W3DHU/SiOAmMOgPl0PcdQo4or2vujv+ewlrNLbAbNuzPTWiMtbdqb1bqKDwSWhYkOEbcXhKRSh2tOEftu3uOzncQRADI6ZfS6Y/GfdDwTysffaSn28ounghi3U7UY2ZwrH9zs329q90JyzShHwEtKC4AKZPkCaectIDNirSJR+UAgLejr51friIGHhs/Hetgsyqz8TXY2BiqJbchnQDlLL/fQrJ/51cAAg+GxC+3TpSyzXjdxiiWv55r9d5qUHdCohBgCG4QBX4b9hEtD1YdsEPNPExSzC662xyw3MCMUSO1HO+UuhraJ+5NVlfiDhbFzMJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYZYS8zI/tjU/16J9pFNqZVir/UQQKqsi1+FTiw7Dxw=;
 b=pN67s7A9uCCsOiss5YsrX5tJ3thn2Qk9FRlxdLg1s8fb2f7C6BHX+XEyhBKFc3yHNdQ4vGEXODWLLjdb4yJCW3s3l/h6BHVVXfEGxDcHHmzgssBtotLNa1++r9PmV2yWkVCVTFUhlLzv76ubm6DNwpNCxG+eRmbRcdlIOAogb+YU2D4DPkOY3cSghtM7IqF3+KET5EMdViqgMCzVJfMbsJ1tAFZ+NJh7n9VGwVUyIJ6K8BoAmDSNOvROOSvzrdQAkGMOwgsSuPaqD+Q4DnfCnselNSCsFeXmMTKFtQxFoAG7YWd0UAB7Drk+5Q3sm5m8lias2hdfygTR9iA8epm4sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYZYS8zI/tjU/16J9pFNqZVir/UQQKqsi1+FTiw7Dxw=;
 b=MUeE+dVLE8Ob0HJMgw/ps6zU06UmInq0qL6Lq37spTdsw/LbO4ZA4Yax77j9UJf9DzYQb9jmeuIVHhm72mbrJdq/+fqQgwexhVVP+vFXgw38WKBibFmUUn4n/mbzimAIvrnAo6hmsH4g0731sHVLiH9z+TNUhNlLvVYGwqV8+C+IshXHZyALcdNYP5V0pR93ZX5IVIoQdA1gA9EJ0rPG88nmPp2Tg+x2spHcmHzy1KlZctxo+5XJKHwq/Ixbd+36JJmZTbi+cX6o/uOhl9vO48vng9am4n2wRUTWO4cL2vhQG1vI5I6G/93nrC9G3Jrpo9zLUNTVLvSJpKyfK6m18A==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9632.namprd02.prod.outlook.com (2603:10b6:208:3de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 18 Jun
 2025 11:28:31 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 11:28:31 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 00/12] hw/i386: separate isapc out from pc_piix
Date: Wed, 18 Jun 2025 12:27:05 +0100
Message-ID: <20250618112828.235087-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0149.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: 0af8dde3-a38c-43bf-875d-08ddae5b4101
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hlJ6igZbmSZkXdZoIm/7jK60qUZLK4DP62nXI42AyHBjJHKHMda1ac7M4NDD?=
 =?us-ascii?Q?YHDROvtO4gI80b9ntftI203AZB+EHGis+Y6H6WnUEKz/RW3GBPIBN5sw5RDN?=
 =?us-ascii?Q?TTeSM2BaOCTdPAheUJ0320oyHvjAK9qg213rns8TJW16Nd7u9NVbD1prONQd?=
 =?us-ascii?Q?MveUrT5+M+941s6rm/eTma+u2wwXKBQ84828/gFbY34Eo3HsMlOxnR/+ClZw?=
 =?us-ascii?Q?ohb1g/QSfxppx9pB840BEyLk531d974Gr8+eKUecTY27Dd8iQPhM7ejf+Q/l?=
 =?us-ascii?Q?gvsyG0T8NjoSsHJqBnjpdUzNIeCZ7ObSgNMd4/dLzNg7WvOjsNSmyVvDWC/B?=
 =?us-ascii?Q?HaIEeBhKcz7xuZYbFZ+rg0AOZuwmSbPCDRoYyDuHopuaSIX4tCtvRgV1Z3Du?=
 =?us-ascii?Q?Djx+xnfjrZvidrAGErwCWhsjfOTFGkZBHP9PP1mDvJHVemT2UptSBv14J1lK?=
 =?us-ascii?Q?ryz6IKpeCT3oPjoERFAYEZmDXCVyxP6AdPPoJlAOcCpwAVZrayICWNP9CWFa?=
 =?us-ascii?Q?RnDVsq4R7Z7Af9oyPh2avpGVWoVqlo7sLXfyFGw8RGoZbvBnLlhI5Jzz6eLb?=
 =?us-ascii?Q?6qMzUUCMm8nBaFhCFH8lR/3ecYm+SPBpg28Ktvzqot5ch/WGd6NQOqPtW3TZ?=
 =?us-ascii?Q?eTZpq1o85hNLvuCUd4ekAYrpwSXKkD+0jVID2Oi/QIFlUO7pPAgPLnpATxs7?=
 =?us-ascii?Q?fEd/q2yxw53TL3QKcbunkNl0byyJfezNGjDZLxXH+6P7q6lqLi2BBcg5v+Oe?=
 =?us-ascii?Q?4s+Xh13z/3reujwIRt6khHUgXspzKJ/7E/aQhexRMidqI9RYECcq3dt3jXih?=
 =?us-ascii?Q?VZZ3C/V6+/mNwrMucJrLse3o/uVNWZ8dGai6nrxOT1TcWdysOh2vWxVXkR/+?=
 =?us-ascii?Q?kLGewtG20QNLrK4u3bKbTxVGbQ3TcbwHVYvtyIPBq/GwBY3HPJw6JMp+PG4M?=
 =?us-ascii?Q?7AtJ99skIjHRTwOdrqVql0NrnTFgOk2Vu96K3E6oMzNGteBG+fD8lUmPBMLh?=
 =?us-ascii?Q?Q1bIdJFpESIeYx0JQSPzK5aUGIfnYZ2Ax7scIIBZgJcKUwr81WReyTV5B4UK?=
 =?us-ascii?Q?9TvixCYlXyE/1G3F2NdnCaiRNDexoWzSBV5yb/oWbQMqWCUqBBnYChHs6I+j?=
 =?us-ascii?Q?g0Z4I/oQW82Zt+nXUL8D8zl4und6GjXKUatMWILc7jB9Gl/QGVxnIkXjG57k?=
 =?us-ascii?Q?VpycL6hGaOPSgdzy6on1yq53fbWIOOVQajRBDWANGckPSPfxas/T+3483//I?=
 =?us-ascii?Q?FIhMTyMiiS6h48p3jYSmy9FfLOhzusSXLs1Kf1AYTSLT2a25gjOi/v3b7POm?=
 =?us-ascii?Q?sYZvcNg4Klgfy8h9jACKQp578/WE/d9pE1XfwYd59DZlsAO+HUrD5e+qrOPt?=
 =?us-ascii?Q?OXjfwfYoObeafP9L9/c+lzYzX4McPsJOFpOFdhF0uAz+tjooUi8Gse6rjZ0h?=
 =?us-ascii?Q?NEFm9EY86vU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/4Jc9VvKPrBk+6HOoVuerlGLptlhQd2dQiW2FhewMMxmUlTVf7xXWd4A0h0Y?=
 =?us-ascii?Q?uWT3WUjGk5RwzA+ogLy4gUzGtwtebcQkumOEvTpDGAx3sdjjsfABmsmRMr1O?=
 =?us-ascii?Q?gmdh2yPNf8VZsiE+vfSTzybQX/raRPXBNW1ivQHZi8GVhyFmgBkuc1pdwL9o?=
 =?us-ascii?Q?OoCX+VRuGNTAwilBBBdQwIqq5kVAyDYnV4UvuVld11hb5Ujj6+3t6STJL4ET?=
 =?us-ascii?Q?qB93BW2fxJ55Hz4iFoMxbhvmWgKMp+6dFyyTgSek1OJirSwjtZ0VJ7EvPSiD?=
 =?us-ascii?Q?pL/y7HkXQ6GwcyBmf3+2SHaur37AskDl/L2HtGDKlH6abKfKRLqjnmA5KWbz?=
 =?us-ascii?Q?Hz7RGVnyGsfxVikxQOY1KYTBON4L+PbO9x+M382vhH6NUpI5WqCCbEVL3jre?=
 =?us-ascii?Q?HNhTBrB/zIwXLdCWYsGNZXkg8BHt8rxzZbqMhOxEJng/Duk/Yv+RJMUjKb4j?=
 =?us-ascii?Q?Feb0aBr04N9OSILl4+JiPZTSuTUlEyHp+htUuIEHVgFRGDc17RNz/Jh1JJfu?=
 =?us-ascii?Q?R+tMNPUxy7fqICU9s94iuZ/+U34GWD/Enle9mH4yO7AIkolJmVzwb/94lINS?=
 =?us-ascii?Q?Dy1w3R9FoAZATBEM+pcX8nF9UmyyAf36G8aQzr9GDd6UdqNymS5gSFfajM8F?=
 =?us-ascii?Q?N2cbf3GiPQTtwRIHFX6J6N3kcnQ1TRUM85+aQaj62+Km5KrHmVILwU2uRyfT?=
 =?us-ascii?Q?Qk11dLookBl/liAhO8vxGCghU0vGSN2OsU6vtncgIAC7AafwsqrYlpNOBUwi?=
 =?us-ascii?Q?YHT2H26K0qp82kS2xDJ+cwuVtltISz8hLdWz73HmvL7T//2xkT2mQiZS9CxW?=
 =?us-ascii?Q?d0TN9h/hzH/h0Do23CK9AlPZFSeNTCOSEOr0gpnlYg5wjZbs3JTbLMKPQ2P9?=
 =?us-ascii?Q?FrCfxJ6qv8wDKajGOu4foCMCGB6akHydmi3ovfWW6vc4XBqeE8qTW4LJmsiE?=
 =?us-ascii?Q?uChnNV5tIqDf+pnnp7O5E9+cgawbGkmlWm+bHeYrIz7OgzqatOMGAJacIjEI?=
 =?us-ascii?Q?+ys0RfwQwGDbtihAoTwiR7jM5M/2JT00frUe9kY9/AgJ+V0mBPso51hAl/9c?=
 =?us-ascii?Q?rEouf1TzJEpxAicWmdb6h6DCcSMA4OETUEuetBkcd6kmumtbhduMsOkgit/4?=
 =?us-ascii?Q?wX+2ntqovTRHG+0MQDqEAycxiMem9As/Q4hXhogvqgQ6xrQJJxstJaB+FgPL?=
 =?us-ascii?Q?NGGVIrhF5ojsGR9TxAUfRrnG+aA6G8JjGeM1C9VAmQ99NU5YrHqbJVaJz/4L?=
 =?us-ascii?Q?sVB90mhN0RUH8aRk4E5FEl9lS7m/uu/D+58Fj6coZwL0FO0SlS3s5humEZbC?=
 =?us-ascii?Q?sZFo8Jq7bvbbafMXr98yXUQjkDLEixt2aDq/DohhyBPr5fThfyVJ8+dPLZbd?=
 =?us-ascii?Q?Ut+HVnFyxHyNYfhxjR1G7MtVY2F6Whgjh7yFvueuHqV3wN1NM+swubU21ZXJ?=
 =?us-ascii?Q?S7z/Ky2S6anoY36uA3AOBNHlf9NK4hSHnHGwhtM8Lgc4tdnjKh7/QCr5UbUf?=
 =?us-ascii?Q?QRUvghqhS/a+lVB72vrRpsxBS3fDjHIS91B68qU8lRaR5S+07BYDZ/W/vesI?=
 =?us-ascii?Q?H+8Sew9JulrIPFbOhhC2SApBnS4C33OE8huc0XSpL1X7VzQ41XcEgBemyqNu?=
 =?us-ascii?Q?UOI3CCK05WM99TnAyep17+yGT4Ln8f2k60HOcDBSxJg8pPNGpFIZD8ny5HEy?=
 =?us-ascii?Q?/cW5Ew=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af8dde3-a38c-43bf-875d-08ddae5b4101
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 11:28:31.4910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4sE9yQSIk8ZEbzKzUdV+f6dvXFIVcdHDKGLbSCPLB9fZ8BU3Px3KRIWbVvOa9LtRk3+qQlmESs1WqbTHULIyswkNDybQMN2UC3wse2honQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9632
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA5NyBTYWx0ZWRfXy1FlNU6VMrs4
 otc+WwqonkIkNVtCc0ACqGdKYkh/gFblHvRW7jlCfYupKCLpKKCt4G/09gA0vi9WOCJ1/KZqMPB
 BDqhu91kSd2emrL19/MldlzLGPaKY8oPOjy1ASgjRl6Yr3MsIv5IZuCUnoiLf3VoXv2YQtZBE6y
 HXtjLZfrz4tYFFAkevg9UoZZUIXGlzWSSSMWUPBvChZeP/UtIW1Tz78YjDgIVIY5h/eZI17/tW+
 1POsGR9iXttSid/JJQhUUq9O/ox/iRG8EJPrLkL62gs8bpl6Z1eCg9sCCUR/bjwyH2HwRlllra/
 krmAB/E68LoJGHJTNUvWMAIJLYYZko9tNKu4ScEwyaUJZYhb8dPjiv01W1RpUOe9NO2kMQxeZX2
 02VQSXuzcmW8EVRPJLsOj3ExusaulSDyou2yap1IkVfPxqwxVEg74go0L26YVqWWBTGth0z0
X-Proofpoint-GUID: CZKmD4rYl3pgftHgVY3eejgt_S82BFTT
X-Proofpoint-ORIG-GUID: CZKmD4rYl3pgftHgVY3eejgt_S82BFTT
X-Authority-Analysis: v=2.4 cv=cJXgskeN c=1 sm=1 tr=0 ts=6852a2e3 cx=c_pps
 a=MbbdNVLKh5Pakk4fpNOBUA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=mDV3o1hIAAAA:8
 a=64Cc0HZtAAAA:8 a=t_fk4poXdalvXVda_iIA:9 a=Y4I1g1QRc_YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_04,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
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

For various historical reasons the initialisation of the isapc machine is closely
intertwined with the initialisation of the pc machine, which is preventing some
future improvements to the pc machine initialisation logic.

Since the consensus [1] was that the isapc is still useful for testing and running
older OSs, this series splits the isapc machine and its main initialisation
routine pc_init_isa() into a separate isapc.c file to reduce the maintenance
burden on pc machine developers.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

[1] https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg06137.html

v2:
- Rebase onto master to account for the fix in commit 0b006153b7
  ("hw/i386/pc_piix: Fix RTC ISA IRQ wiring of isapc machine")
- Replace verbatim MIT licence text with SPDX identifier as discussed
  with Daniel


Mark Cave-Ayland (12):
  hw/i386/pc_piix.c: duplicate pc_init1() into pc_isa_init()
  hw/i386/pc_piix.c: remove pcmc->pci_enabled dependent initialisation
    from pc_init_isa()
  hw/i386/pc_piix.c: remove SMI and piix4_pm initialisation from
    pc_init_isa()
  hw/i386/pc_piix.c: remove SGX initialisation from pc_init_isa()
  hw/i386/pc_piix.c: remove nvdimm initialisation from pc_init_isa()
  hw/i386/pc_piix.c: simplify RAM size logic in pc_init_isa()
  hw/i386/pc_piix.c: hardcode hole64_size to 0 in pc_init_isa()
  hw/i386/pc_piix.c: remove pc_system_flash_cleanup_unused() from
    pc_init_isa()
  hw/i386/pc_piix.c: always initialise ISA IDE drives in pc_init_isa()
  hw/i386/pc_piix.c: assume pcmc->pci_enabled is always false in
    pc_init_isa()
  hw/i386/pc_piix.c: hardcode pcms->pci_bus to NULL in pc_init_isa()
  hw/i386: move isapc machine to separate isapc.c file

 hw/i386/Kconfig     |   3 -
 hw/i386/isapc.c     | 145 ++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/meson.build |   1 +
 hw/i386/pc_piix.c   |  31 ----------
 4 files changed, 146 insertions(+), 34 deletions(-)
 create mode 100644 hw/i386/isapc.c

-- 
2.43.0


