Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8670C369A1
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 13:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Vo7-0007NN-SH; Wed, 09 Apr 2025 09:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2Vna-0006c9-Dz; Wed, 09 Apr 2025 09:49:04 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2VnX-0005gR-Vq; Wed, 09 Apr 2025 09:49:02 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5395qVN0014865;
 Wed, 9 Apr 2025 06:48:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=EqKoLwopr6Kf7+k6Zh6AlzWMg0KBj8nOBnuE8ryei
 XU=; b=kPkmnkYe0x0CEwANDiY01NvO8lSjK6hUjlaIAgSn1Su57Vifk2g3Aj1xP
 C9lxbb1A66FtSoOcdJ9iZH0m2AZWQ40L+jgjsZxH2cxNi1LeyQaWwpF/bHArBz43
 6kC/ermsAdEYIejSjpqcLV4cjvIqPfwZ8F5VUFND3wlahan6RQO6qGeg6QKKwal+
 hyy+FTIqtl/sqydd278zmImx9HdyLGy10DEn7miH9SXDI0qdAxGPAhiVwQJii1ZC
 gVon5WuB0ZyqjJnM3WyRBBjN8L8CVbzdOKlJiD9YRTjOzlAwfFBu2e8ZK6jWOUnp
 V5HUHtDP1cE6HaUEup6Kzu5oFHANQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazlp17010005.outbound.protection.outlook.com [40.93.11.5])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 45u2mhj3ka-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Apr 2025 06:48:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzK1Qb4UL4fzdUgim0lPc9mfLt6Cf1+hm57XeZdsL4qV10e1iN/sCbBPEAESkzJ2Q2hBRKl4PpuyKxvge3XUX0pdAR2cngMqYKtmlaKea+wwndUg/0Ur8RSLOTLoq1/rPXCthFZHw36tbJqh034/jLT0Bx6AwsLlhJBiGfaU3vMmFx5Abx8B1XH5JrvucV8VhA78Mo7vJIQMLgVhiooMLURO4jrjuvgdlxzFho5JTPrGkuGVFYIwyf1XbyJ6hn1ncjutJ2ohS4FB2BBttTfVMhruqICx8asAYPLNDVwlxC/EmNi/ueVD+s9QxEXq1XGg4yH6FXCcNVur6QhkOsSVCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqKoLwopr6Kf7+k6Zh6AlzWMg0KBj8nOBnuE8ryeiXU=;
 b=ddZS8qO8L/beE8fIaCrKnlWerl0n5u4S3mq4lQRir64yHAB6IeaZcK5XIJ50lGRW6UR8E/hc5iBntlPLBx0ax6VqU09zvjsLLF4h9VqkyVtE46XXmGMP5ZaW8h1cIEPmLuNK1GV/9u/yDZWynVB1vQGO6A6zAaAGOaN9DoyahAMfoLyNGdpGUuihD6cSU/mctqnn9TAcbYCxdwboedc4/4zlUw6wKVR5bGIFWeHzCGYuEX0WyFGYSFUs1ImXIc1X5KJ6AvaVHi3O4hFSbGPHNIEfrywFoUr+rBonWHoL9nt+UpPzLpaEXT2cKprvs+vJE2tAfkpZsHKx/HclqpsZpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqKoLwopr6Kf7+k6Zh6AlzWMg0KBj8nOBnuE8ryeiXU=;
 b=gLtSX46vXqVCSWpBUFa18qFiRTXY58lqoR9Pe/7Lo45bubE5ouCs9U5GyMoxDztVvpr/I5TYTBhWsIGY0jPq88BzYefpvUBMV5qeyyU5ha8SWE96ZnPvBEtgvvAZ+E2vgGIakZjUGuAFeoDwnZ/kY95ka6maiuGrXDGId+Q94lktCAoFw7qHP3vTKCSeFK2Y2n1kYUbQLcDe8xQa39NmyvXVw13vH8IX7gT4Eyy20WqZCorp/sW/xdTy+4bCK11DT4AId78gS2mWBfhHKk5bSHic/xLjIbHxMJ9JhBK3yZL2jomUlhCINzIkrR/R0rA9t3r8T+rjAS7BE7Vckh+x1Q==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7486.namprd02.prod.outlook.com (2603:10b6:a03:2a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Wed, 9 Apr
 2025 13:48:54 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8606.027; Wed, 9 Apr 2025
 13:48:54 +0000
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
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH 12/14] vfio: add region info cache
Date: Wed,  9 Apr 2025 15:48:12 +0200
Message-Id: <20250409134814.478903-13-john.levon@nutanix.com>
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
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: 63438839-5297-4dae-f95f-08dd776d4472
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tt+ILOQkKuQ/EXMUWvmhFlbooH0M62H3+u2gou9Oznehu7PtXc6+MA0Lksk1?=
 =?us-ascii?Q?030uLKQO2tYatftaKrXkTRuxHjisAMVB8E5igjlk1z2GGZlEchcG9bNMrgNJ?=
 =?us-ascii?Q?4t69Xe7dlTGepJM7+iuFeXEbC/weJUIWzLt5Ls4YvMsJNOvKb6QIw92Mm6Hr?=
 =?us-ascii?Q?p0P58ay1C2z6tPKTW6YPFhVdWLg7jXDbVmztHuT8hR8GoQlcAzdcvvQP5eWB?=
 =?us-ascii?Q?pgrzARvC8b1ON0QJXL1i4RSowaECCdEys/UqDUXXPK3Ra+X16r9OlBDsWWRv?=
 =?us-ascii?Q?lolOaoiQprwwPCX9A3PnS4agLzIe2SqCZH7KSCj3zKnPYSiOZXwnVp6+CgDz?=
 =?us-ascii?Q?MI2zUuhxaNXH1c4zB81YexRpdcyYQQPVj9mWBXoWPFblf9DeyI1ZIAmRXxMN?=
 =?us-ascii?Q?J6zTPpJvxiyC8zh5ad3dtHeeKSzyL+9d3nooBr/sPHHVmUqmZJfJqLbZeZWu?=
 =?us-ascii?Q?waIyIaZyyyagY2NldumXTp+Jmm7N7m4WjCgyh4GsXjwGSi0/nhLpVuQDtmkU?=
 =?us-ascii?Q?o9wnH0BICMJDoz6uRn3gSm+u2Q3/OHTfIP8SJkCRj9cuuaZBs7Ek7pW3K+Rg?=
 =?us-ascii?Q?BZVW95E9e59RyseA5BgukOaKYthbs1foS9jFSKGqRNI5K2RzvSWdRg6Vxe11?=
 =?us-ascii?Q?sS0s/rBAWAz2JySwvJ2brtQt9sDx+HvZ0eARw0KzHglmbJiKl0dCdpwx98pp?=
 =?us-ascii?Q?tvCe9xOcYvAuY0d4db0nRpZ4w5JapoeKAuCyvsWxlwzd0zSRT+PdnPLcqZ90?=
 =?us-ascii?Q?b2Y1Ym6HkT4sIlGyHg+qUo8ii7XI3M02iLI82UHtprEbx9yHCj/Ljm+ruc16?=
 =?us-ascii?Q?EqOf87a347IikSFUpUR25DafJhmyp7tkzWv4bxrYM5bOpwehyKk7bwmTC/st?=
 =?us-ascii?Q?RdSRz1bNBNRKNAJo9yWMsgD/LYplFP3iYMR5/UoFT1xPoysB7jknjoeUJ2Rk?=
 =?us-ascii?Q?WN3Co0MZyDif6FzH4LUMUHCbDcCt3DM531+2C2Hj5KiZrH55PpUU0qtbTgYA?=
 =?us-ascii?Q?nb39LsJqHiUp1xi+ABZzimv7SsVsidaHz4K1MEs+gLoPIUVaBnYRiPhQVgu+?=
 =?us-ascii?Q?V/ZkfiWRqR4ak+2Kfks6y69znvjnYUptmEQgEF+Uqqq9CeX+jAPbxuaDp4B3?=
 =?us-ascii?Q?GI8qW3lwir3OPCoKHywPAA5RjvuQrjlvefwmpCixlZf7iaaCMWpHQZxmfdsO?=
 =?us-ascii?Q?nnl7pLvBmSBCrPF03N9CcLmQrc797lm9V2ZTiFA+7TU0WRtTo7vJWUEcC88N?=
 =?us-ascii?Q?+GcJt/PI+Rbro9aJ/YndcMwJhrMJTQIcrLc323yjBssUQulzn9XoOG0bGJqh?=
 =?us-ascii?Q?fCTnuKFwpbWqWlI8f1OxE8JcauoCR2f3zPdNvP2cLqKGRfRWj200Yeg2zc3V?=
 =?us-ascii?Q?bJ8x6Sgo0ZWJJ4NjRFO35Wmh59GpGbtndrzSFZ3taZG80aX0xA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?97iuR8wKUZ+uR9NaO86TP696opUehl1IrEdzxIpp5roNLYCSYi+eFB85cIvY?=
 =?us-ascii?Q?Ef/zLm09KUvYUdUa9/+PVwJgbG3TlyKXyGyaDbDGGLljRiqW/Cqh4UOpVnCl?=
 =?us-ascii?Q?D9/HjrZZUJvLpYXj6ivl8S1r9cRTMQT3L8wpCtZlMB+Gvt/7+nxN68C2jMbv?=
 =?us-ascii?Q?hISQPAexVL4wQLQsvltipQycBOppcAwSv3uMrKJzPlX9vY4A9aldDtorPLmG?=
 =?us-ascii?Q?AkI7VW4ZLWuLAFF3Czyxb6Y5iwYqxI4LJxSThY0pFlHRnW4OeJgQOFLAWJ9F?=
 =?us-ascii?Q?+f6aVan9d3B+NL84rV3ZNLxLXILfWdjOyh0b5XT/u4805DFx/2FkuN5rNci6?=
 =?us-ascii?Q?Nb7oHp/nRvq2ChOpDJNl2idTtUYtxcs7rhbAf2ILd/HUulx5FN09mVBwqDLd?=
 =?us-ascii?Q?4SOleFGaBdlFlJ4cfkjiX2M/871qbWwST3ssQ9kXC4SpSb+8e95UrkqE+fyT?=
 =?us-ascii?Q?P33C3lb8OeocWTgnaT2gFjtWNFdZ9AgLvOPi//4dnAqyo1kERvGaPD4Mn9Cx?=
 =?us-ascii?Q?L1spPWLMAXsGLhyVc2U2NZvkPDrrmAFzgga2JMh0Ln/j8PBpKhkja5vPhqyD?=
 =?us-ascii?Q?+3716FTG3xvcfcoFRP91bWls0ZWAWyyB5aqC3Apimw165eLZDyk+yRJPKU3u?=
 =?us-ascii?Q?TkrP2fiDgq37S0c1ykOHgyBUx06cGuv4YTKATT6qoISWnDhL6mbkBqaTqDFs?=
 =?us-ascii?Q?rFvxny/SOVHKtGwqqWl5ElhJ07wx/cdmnuzqFg2ofHSKPDCWiyYytNqm0QIL?=
 =?us-ascii?Q?cfIwWlmiJOGO/Pdpm4ZL889+HYkfXUEvAeUygaNoXaU+ja8eqiuJpX/AiRfT?=
 =?us-ascii?Q?B6Zl3cN+Yz94YKqET86EIEeho8JvT4GxSs6TF2GOIL6SvbHClr6gKtLIt+1h?=
 =?us-ascii?Q?cu+B1ikmSAh1WJuobLk9xsBAb6++1wAGKJW3ewWodh67YEuvwgpwvmoEGp1O?=
 =?us-ascii?Q?LAidHyYnk0Tv36kmBbegRbGd7AONuzmpNI9qNF8hD3XNgh5/X5p9nrc2fdZg?=
 =?us-ascii?Q?ZIBPAn6l5DrPEMhG+yqbDYcf3xRjyKyAiIM+Sx6tL8cxehuC3nzi4ldTJaga?=
 =?us-ascii?Q?dB3RYOBcjJO+as38p07Picp9kgqgiLjfnVGethiKEOn2v+c7v8x2ed42WftS?=
 =?us-ascii?Q?0JtTp9mhfH15Y4fqXzKwgti/vIXlJzHLf7YvyWMgubm7NtDNIfDLtenuUAUs?=
 =?us-ascii?Q?/XVBlrSHl03V2iui51lkF5XwHBjTUW7uv7Y3GtqL4S9/2qXVDkEZm/i5SAdn?=
 =?us-ascii?Q?ohM2hEkhWO5vEFVeowUFOo2f4mtXVHYaWXdLTJP4Gq52rSbdH+UxCq/Rjrs4?=
 =?us-ascii?Q?g9F9kdyaw6m+shhDzztS1jhG6ZPgQLGTPf0yZVrLcPyq8+NjXxdw+IuyqHby?=
 =?us-ascii?Q?vKysFimfFRha1N5r4aHChvkhU0j+urRz9UPsYMd35Ij2DU/7p2//H260eMLm?=
 =?us-ascii?Q?OLGQ3PJSa6wZuE7Hnk7gANJeXmZ3aA9K5y/aoEayg9PGGxwH2FTmZq0z2nSN?=
 =?us-ascii?Q?AgfEIqqJUbk0rUKE8DnHK1lciHPmou8G4rSqQHDw4c2cbIhBemrO22Dwfi6R?=
 =?us-ascii?Q?/5FJvz2YSDDxCP0u39jFbhcwMYksQTrAUMovREfg?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63438839-5297-4dae-f95f-08dd776d4472
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 13:48:54.1663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43g+uGX5KvW8HKM9Tg8P+krr82OGmkXKqFoLSKxblwrrU7hRV1Cqp05qWtJdjDpQ8c9Xx2mUaNI77Yjt7t+8tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7486
X-Proofpoint-ORIG-GUID: VLSOtggaSdKyAppD7Rj7_eF58HRev_b4
X-Proofpoint-GUID: VLSOtggaSdKyAppD7Rj7_eF58HRev_b4
X-Authority-Analysis: v=2.4 cv=JPI7s9Kb c=1 sm=1 tr=0 ts=67f67ac9 cx=c_pps
 a=8NhCg2oU0sQOR5chO7ltBw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=nwHpM9hI2HXnMGzLlGAA:9
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

Instead of requesting region information on demand with
VFIO_DEVICE_GET_REGION_INFO, maintain a cache: this will become
necessary for performance for vfio-user, where this call becomes a
message over the control socket, so is of higher overhead than the
traditional path.

We will also need it to generalize region accesses, as that means we
can't use ->config_offset for configuration space accesses, but must
look up the region offset (if relevant) each time.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/ccw.c                 |  5 -----
 hw/vfio/container.c           | 10 ++++++++++
 hw/vfio/device.c              | 31 +++++++++++++++++++++++++++----
 hw/vfio/igd.c                 |  8 ++++----
 hw/vfio/pci.c                 |  6 +++---
 hw/vfio/region.c              |  2 +-
 include/hw/vfio/vfio-device.h |  1 +
 7 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index dac8769925..14dee7cd19 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -504,7 +504,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
 
     vcdev->io_region_offset = info->offset;
     vcdev->io_region = g_malloc0(info->size);
-    g_free(info);
 
     /* check for the optional async command region */
     ret = vfio_device_get_region_info_type(vdev, VFIO_REGION_TYPE_CCW,
@@ -517,7 +516,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         }
         vcdev->async_cmd_region_offset = info->offset;
         vcdev->async_cmd_region = g_malloc0(info->size);
-        g_free(info);
     }
 
     ret = vfio_device_get_region_info_type(vdev, VFIO_REGION_TYPE_CCW,
@@ -530,7 +528,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         }
         vcdev->schib_region_offset = info->offset;
         vcdev->schib_region = g_malloc(info->size);
-        g_free(info);
     }
 
     ret = vfio_device_get_region_info_type(vdev, VFIO_REGION_TYPE_CCW,
@@ -544,7 +541,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         }
         vcdev->crw_region_offset = info->offset;
         vcdev->crw_region = g_malloc(info->size);
-        g_free(info);
     }
 
     return true;
@@ -554,7 +550,6 @@ out_err:
     g_free(vcdev->schib_region);
     g_free(vcdev->async_cmd_region);
     g_free(vcdev->io_region);
-    g_free(info);
     return false;
 }
 
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 37b1217fd8..61333d7fc4 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -857,6 +857,16 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
 
 static void vfio_device_put(VFIODevice *vbasedev)
 {
+    if (vbasedev->reginfo != NULL) {
+        int i;
+
+        for (i = 0; i < vbasedev->num_regions; i++) {
+            g_free(vbasedev->reginfo[i]);
+        }
+        g_free(vbasedev->reginfo);
+        vbasedev->reginfo = NULL;
+    }
+
     if (!vbasedev->group) {
         return;
     }
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 2966171118..102fa5a9b4 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -205,6 +205,17 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
 {
     size_t argsz = sizeof(struct vfio_region_info);
 
+    /* create region info cache */
+    if (vbasedev->reginfo == NULL) {
+        vbasedev->reginfo = g_new0(struct vfio_region_info *,
+                                   vbasedev->num_regions);
+    }
+    /* check cache */
+    if (vbasedev->reginfo[index] != NULL) {
+        *info = vbasedev->reginfo[index];
+        return 0;
+    }
+
     *info = g_malloc0(argsz);
 
     (*info)->index = index;
@@ -224,6 +235,9 @@ retry:
         goto retry;
     }
 
+    /* fill cache */
+    vbasedev->reginfo[index] = *info;
+
     return 0;
 }
 
@@ -242,7 +256,6 @@ int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
 
         hdr = vfio_get_region_info_cap(*info, VFIO_REGION_INFO_CAP_TYPE);
         if (!hdr) {
-            g_free(*info);
             continue;
         }
 
@@ -254,8 +267,6 @@ int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
         if (cap_type->type == type && cap_type->subtype == subtype) {
             return 0;
         }
-
-        g_free(*info);
     }
 
     *info = NULL;
@@ -264,7 +275,7 @@ int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
 
 bool vfio_device_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
 {
-    g_autofree struct vfio_region_info *info = NULL;
+    struct vfio_region_info *info = NULL;
     bool ret = false;
 
     if (!vfio_device_get_region_info(vbasedev, region, &info)) {
@@ -427,6 +438,16 @@ void vfio_device_detach(VFIODevice *vbasedev)
     VFIO_IOMMU_GET_CLASS(vbasedev->bcontainer)->detach_device(vbasedev);
 }
 
+static void vfio_device_get_all_region_info(VFIODevice *vbasedev)
+{
+    struct vfio_region_info *info;
+    int i;
+
+    for (i = 0; i < vbasedev->num_regions; i++) {
+        vfio_device_get_region_info(vbasedev, i, &info);
+    }
+}
+
 void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
                          struct vfio_device_info *info)
 {
@@ -439,4 +460,6 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
     QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
 
     QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
+
+    vfio_device_get_all_region_info(vbasedev);
 }
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index e1cba16399..d70da1ce38 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -198,7 +198,7 @@ static bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
 
 static bool vfio_pci_igd_setup_opregion(VFIOPCIDevice *vdev, Error **errp)
 {
-    g_autofree struct vfio_region_info *opregion = NULL;
+    struct vfio_region_info *opregion = NULL;
     int ret;
 
     /* Hotplugging is not supported for opregion access */
@@ -361,8 +361,8 @@ static int vfio_pci_igd_lpc_init(VFIOPCIDevice *vdev,
 
 static bool vfio_pci_igd_setup_lpc_bridge(VFIOPCIDevice *vdev, Error **errp)
 {
-    g_autofree struct vfio_region_info *host = NULL;
-    g_autofree struct vfio_region_info *lpc = NULL;
+    struct vfio_region_info *host = NULL;
+    struct vfio_region_info *lpc = NULL;
     PCIDevice *lpc_bridge;
     int ret;
 
@@ -526,7 +526,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
          * - OpRegion
          * - Same LPC bridge and Host bridge VID/DID/SVID/SSID as host
          */
-        g_autofree struct vfio_region_info *rom = NULL;
+        struct vfio_region_info *rom = NULL;
 
         legacy_mode_enabled = true;
         info_report("IGD legacy mode enabled, "
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c3842d2f8d..b40d5abdfd 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -882,8 +882,8 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
 
 static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
 {
-    g_autofree struct vfio_region_info *reg_info = NULL;
     VFIODevice *vbasedev = &vdev->vbasedev;
+    struct vfio_region_info *reg_info = NULL;
     uint64_t size;
     off_t off = 0;
     ssize_t bytes;
@@ -2721,7 +2721,7 @@ static VFIODeviceOps vfio_pci_ops = {
 bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
-    g_autofree struct vfio_region_info *reg_info = NULL;
+    struct vfio_region_info *reg_info = NULL;
     int ret;
 
     ret = vfio_device_get_region_info(vbasedev, VFIO_PCI_VGA_REGION_INDEX, &reg_info);
@@ -2786,7 +2786,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
 static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
-    g_autofree struct vfio_region_info *reg_info = NULL;
+    struct vfio_region_info *reg_info = NULL;
     struct vfio_irq_info irq_info;
     int i, ret = -1;
 
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 04bf9eb098..ef2630cac3 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -182,7 +182,7 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
 int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
                       int index, const char *name)
 {
-    g_autofree struct vfio_region_info *info = NULL;
+    struct vfio_region_info *info = NULL;
     int ret;
 
     ret = vfio_device_get_region_info(vbasedev, index, &info);
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 9522a09c48..967b07cd89 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -81,6 +81,7 @@ typedef struct VFIODevice {
     IOMMUFDBackend *iommufd;
     VFIOIOASHwpt *hwpt;
     QLIST_ENTRY(VFIODevice) hwpt_next;
+    struct vfio_region_info **reginfo;
 } VFIODevice;
 
 struct VFIODeviceOps {
-- 
2.34.1


