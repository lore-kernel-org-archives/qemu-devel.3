Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730ADC369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 11:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8HdU-0008Na-Jg; Fri, 25 Apr 2025 07:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u8HdS-0008N5-0F
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:54:26 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u8HdQ-0000Ox-0D
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:54:25 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P29vwt031395;
 Fri, 25 Apr 2025 04:54:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=6Re5N110ep1ueTq4DBCf2DavH/LCjXqGi9Yc28Yca
 tI=; b=ojs8JvIo7Npm4RzKbTsAAy2y4kgElE/+d2cDCsfFIPErrM3U0AtsvWDXE
 PcSyI6NhOkgBRxBmapRXT6ZpR3lC/zoB6SRjKN0b3SSk5hRcopXizAiNS/JfXW58
 0QBGRCKmJZdkVrAPYfLKB0GFMl2au491rtvF9zwBw/YZP7jr3d2UgGYaRDWKIK3v
 ZhZjMc+XJvqsqxV4+IvkWJMcABgZf9XngtgYqKBNSf6HQ6jCnVWlylri12eSpGqH
 /Tm80boCv6+SHz6fGZd733i/gYAt3Zrn0eDtDYTcaXs3mWzQRiFoyke16r8MKYMm
 Kv7Lc5LVIYzNyPWYyx++DaSL3XwhQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17013079.outbound.protection.outlook.com [40.93.6.79])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 467ww3hayn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 04:54:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3POsufyBCKBuYQG9FGtKCGUvPiOdZ+rPG1UTlyyb1jmLK72CPnkXtFgclD+Bcg+BZsaeZ3VsSQ4oBJAmt+WargwD6UZHCZC2hxVbzOLjrWuYqahkHf9g5K5D2ZGF+g38kS0r5IPlHLwzEPl8b4Y1z70TMpqy3GbGxUQZiEur0k6S0j7WDrpNlmMPsi09C8U6UlHhk98wXdZb0KOjTGgN6TG6kpOXtOiWtt7zf5+kH9dP+JRb0I+YIs5hiESA5DS7eve/21VPbJjTK6HSqhbfN6Z66YytRulrMHruTFm70+CdmAUyJ/JCimxUgkUetbC2ljpr70Js+6QYAG2GmqVDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Re5N110ep1ueTq4DBCf2DavH/LCjXqGi9Yc28YcatI=;
 b=j29X0ynprWruMGdkx7fg4yK/h4h8O2RNGdQXu9ZxPzbcNOgLt72g6h95F7l9BZTGiQU0Q7A9f7UfVFPv7XPcv2sfv0mAknqMto03uC8Z8i3ONvEz8LzVfFpsZsd9oziDQ5T+IsNbE06KTisZ25fuchwixOH2k08td+/JYALRH/fg0ayiSsQRsleySwUTVbHpUmcCpPl3gzf6x67W3ge+NV9y9lkz35ZisWdH/2Lcpp9k0vpS5Idd8K7EOH7ISN4NJVwScxXiSqAQvNXvi96+GtOQ/D74DWr9BmrSmJngjrgpldt1hWHQtegyjcdOTvVrkq13OuKJxuW1puDPAPBouQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Re5N110ep1ueTq4DBCf2DavH/LCjXqGi9Yc28YcatI=;
 b=LZo+nMkYPYzQHBWUs8ZywHcJSVQeEvOlhBv6cG7emUr2kxbSef6mUzs51ZaVNEjlLf3uMvysxgs/UpRr30Kv+xelNtnCo+EQP8XQgJVC2KrgMUkCWbiR8mKKaZqw6+XfVxvz54Rc2fpM5KNKe7Ljq+UV26v4o+cYnaQpcWt4ccfQ8pq/DInMe7fW18xzdjw3gBAIRqJVNrjBtPfLwZD09UE1vk7m70HsP0kWc9YMTdq7iHqWJ+eH4/SfmQBLBR9IW+T23Uk04DxM7qXS2sUqYyHTAWlE5BxtDNNK+8zvNP/h4NpJoo1L7Qj2i7UWef5nczXzbnugYdJuTsn0m+bnhg==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 BY1PR02MB10337.namprd02.prod.outlook.com (2603:10b6:a03:5ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.10; Fri, 25 Apr
 2025 11:54:19 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8606.029; Fri, 25 Apr 2025
 11:54:19 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 05/12] hw/i386/pc_piix.c: remove nvdimm initialisation from
 pc_init_isa()
Date: Fri, 25 Apr 2025 12:37:52 +0100
Message-ID: <20250425115401.59417-6-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425115401.59417-1-mark.caveayland@nutanix.com>
References: <20250425115401.59417-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P250CA0008.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::13) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|BY1PR02MB10337:EE_
X-MS-Office365-Filtering-Correlation-Id: 770abdd1-9cad-4cfd-ebd6-08dd83efe988
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JcXEa9vc/PjIqF7BGhNQi50lUKssLYyBBn0osKEHEoZShlxylyxUDTDSTKac?=
 =?us-ascii?Q?RS2IjQF+lnpS8s//tV+PNIEn8pCf9mTl4oN81/u4Hpjur+JBo+MLL9wimcYO?=
 =?us-ascii?Q?iD+sxt0at8utviRYLZCEok4TsXsqZg9dl5Xxcgr5Sfont1FDeltewOKSSBEd?=
 =?us-ascii?Q?f0d47HXAp3vDEk0J458oCV9qOdQi8z2eS3iqVTDTdx3h3BuzUWfKsg4gN4x5?=
 =?us-ascii?Q?62C5fEvs77UIIrUEj+KP94f8a+Qm/7df9VgzGUCKFsdw2538P87T84bETFd1?=
 =?us-ascii?Q?A0jDAt4PJwEMzZ9iQ5EuGcgd9+jugFM2RrWufSm3x6kYnwm0Vfw5t+mj9KUk?=
 =?us-ascii?Q?mG6C2dTb+KdRwU1geIc6ddNMjaCXEpfzX055S2+k7Rrb05qF/cGZGOiRBeex?=
 =?us-ascii?Q?GveWsfp0HF2QBy/f5jRpPoOHlfi3ro+SKY0Tes3NJhE3JjyIs5c3oJ0QD7k+?=
 =?us-ascii?Q?FaiLgkmsPudLJ6YWPgUue4X4G4Y+jHS+QGE+mFerGx86INoZoZERitqKnZY1?=
 =?us-ascii?Q?cFhfQ/qHqfOjJ1VOz0SKzEaVpV+xoI7MIns4NImHObW/LzZhqCggVpXb4Dl5?=
 =?us-ascii?Q?iZwMcUKvb7seOU8LucJEKH0RsQr1T1fHnURQMl5cXcEzcg/brK/9PTpoHmcH?=
 =?us-ascii?Q?CeHlTKsMjHsEC4aTZ57WH2TqXtB7DESw3izirEVcANnUeBtj097xeT8f0CH0?=
 =?us-ascii?Q?4+ox12TOSdUgYS9b9EkU5a3ITD506BmCRmdbS4djk2L+/0dgJYIQSCEi2evK?=
 =?us-ascii?Q?u6UiPf8qqy7w/A4sQYLJIh7RIF5cblk+GsIAHl1o46TXdnAHmzhOAd/Bo5n/?=
 =?us-ascii?Q?ZhTnd7XbjbFj/IcoAXeNvmlS2Ojqbm0oCHU3EhUPx31oLN528pRSgA44nDc8?=
 =?us-ascii?Q?+k5DP+v3N86PKu8wKXNaYDCrb7KJoNfycTHX67Avwg8JIAr+iVoODZHsgO9S?=
 =?us-ascii?Q?H0szna/gg1T/ykHC+MGzOvAqvX3DJW0JGOZguUSoNGaEngULs27RTYIxtZvj?=
 =?us-ascii?Q?VUogVQGybm6F9kfHvkDr5JFWzUrlPk82OdMD0xrQ7Jle5hi/3EyXIMF1BTS/?=
 =?us-ascii?Q?e3TaC70T2WgTWneEqymWl9GJiKZTEZuZ3uRGgpeiOaa2oRXAxF9tw+tglbN9?=
 =?us-ascii?Q?sJP0XNHfaJTqKgQ2qw0qH/2RJP3oiida402G83m8+P9cfWXxikroRKArCmEI?=
 =?us-ascii?Q?NL1GNfQGP3/bR3CX85/RJDaRnu/MYvgRNmy/XjzrNXtkZjm13IJdN2It8Ka6?=
 =?us-ascii?Q?R1FgV+DyFHe85c2MdHo9uvIzZAkFgYNOtBYJ9sqIDlnwE17ep6v9K05OMsKt?=
 =?us-ascii?Q?OxvCHmhyNXHddPB7QJN2ZTT1VkQzZvyTu0Y28PZhiz0lcH9CjYeU0FWA7DrA?=
 =?us-ascii?Q?9h7FOHpvJ/HnhzDyp2R8C0RHa8aLxKN14peQZOP8kfUKVKty4IR6Y2wNdEsj?=
 =?us-ascii?Q?aNNFHN2JYns=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P4ECl9cxLEU4xR/PC/hiscmOJd24AbC6oTocUIBBcTZVsYKMCsgmALRB8l2P?=
 =?us-ascii?Q?6dC/zTNeoe0KzekbznASupgUeGIRXMANoodIMd7L/iF/sZ/Y/iaC2rEKy2gx?=
 =?us-ascii?Q?2DcK9RfszhejwsPgyBcjfhLvCb8w8g8QIWlPjVQjsLhnUzqOzZ4gVsWIQRhp?=
 =?us-ascii?Q?o4p1zAwdfcnaSVT58DwwA+FPfIXEfVImMSeQLHwbNRiWkBBB+DG2Ch5NHbdd?=
 =?us-ascii?Q?6hGhpO6ZDvUy8rYthEHSficV/n+aJPwYHfpOONZ8ScJzRzoEmpkBdtPLwN3B?=
 =?us-ascii?Q?47saG7Hue5UHZkCivFIwPYvdT6eihUU+5BvSNAWzCuBYjDCJ2t8A37GX+5rY?=
 =?us-ascii?Q?82IcTdsKN/c6EeF7DD6paEZDhfWmH7USb0NKD/5o985oYABW72PjWnvIs0iH?=
 =?us-ascii?Q?f1rylpMWunJt1EtyR3LCpiY8oU4bG4zBxEj6FFTePR7af14GLzQ3coQGozI5?=
 =?us-ascii?Q?X1i8d/HUFpG0vyyx0HEvYoGguQ8jEQuXdn4iSTAuYOvvRmVON9XZ91GyZNBF?=
 =?us-ascii?Q?Wn4/JeVW8hzb2g4hJ0nwAtHEq1kgrbFHDvU2klINX08rf0d2D/NCB+/nDDXf?=
 =?us-ascii?Q?MiHZrkSXY/GsPEFH7fXiy+ggp5a8zlc1u/IUXLgwJJr/i7gmnvLfl4zYSjNj?=
 =?us-ascii?Q?ePk30zalRJ7YDfMinaqq0y9E859VGZmzk6qzcmmdTac+lcjtfUbGS5az2puk?=
 =?us-ascii?Q?q5EJJF6HLFqvTXswkUiuOkpt2+9Z7Lw04l0OHfl+lZUK1VSFpSY4OMubRagu?=
 =?us-ascii?Q?WbXiU4z6je/+jpwgHwVyxGRTzXlDGIhlphRdJI/L8zU+DbL9P3GTeq6QOOyS?=
 =?us-ascii?Q?USqa1qEJCXp1TH6AeyiRYPtG2xH4+xRf+LL1UXxdwSgtubvI4yfwN2bJfFyr?=
 =?us-ascii?Q?4PXccehfKA5zeNXMiUTO5oMlr9PHS5azrf6/zW5oYQk1vXXJKpeBhukRlIq/?=
 =?us-ascii?Q?ElJJkmXRwMLDIsBBZ6ykQampoOXKsJ2iLBKfDF/LNYfMVWLPO9Px9DjS6eMq?=
 =?us-ascii?Q?OLSJDHuWnqHUNtE0W7aentacmbi9603fT+nxI2n0T8hiUfLNNnkSRmfpMlZn?=
 =?us-ascii?Q?nxUiP2G02mL96SLzleV1HRxpQHNrRJ6zPoiH1qwAh1T3p59Jo7+ZQH+6/vec?=
 =?us-ascii?Q?SlQ6jPA5XxJi2NPKFv/PZv+fgESQoLlirGFDxN3xZLpTNM85gUVyW7heKji5?=
 =?us-ascii?Q?pUEXHsUcCIVttfuo8OMmQAAUkexkLJiLQjtT+loBIgQIgvRaPOrjuc7LnuGX?=
 =?us-ascii?Q?8MxZPkC6EhuSfk7aDycYkpt8fnutpN9lLeQy/MBD0A924t4Yrn9G+9gsdNgp?=
 =?us-ascii?Q?bXAbbqLQTmAs+pcPpwUa8QNi7R10gON+gng4iahQfcQGqiHMfvbnpofZPX4o?=
 =?us-ascii?Q?Paq4HqPcB4s0zyFxAkoFwoGIbS12rjo9sciMi9mg66fnNvMWlYNIs2ZItL7o?=
 =?us-ascii?Q?vBa7VWFEg/we0uU+QjfP608EZRelekfErJ5ycnm1kereO/rasS+oWhQYrCND?=
 =?us-ascii?Q?yORUQr7QaBRSWmrRlhRzGtw7FGMMZ01ZavAkKKHLnBVjTTSk1tXdZejRv4Wm?=
 =?us-ascii?Q?nwXy7psOZN/vCwA4As/HAVATxNJ1DfiXficRB+OZ/gUkcFLGVJC8yIPazo95?=
 =?us-ascii?Q?rMWd4Nf4rmjEMsvhvzSy3o40THUZPXOBnhnaw25lNgZ/rYxb3Isradf8vxoW?=
 =?us-ascii?Q?0pQcxQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 770abdd1-9cad-4cfd-ebd6-08dd83efe988
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 11:54:19.5785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjmiqNgqT0RQQLl/7xj4rHglJ5dSWPoatyVUu/s2WrMdANEWmRgee22BEamEi50zL6jvcr3GnZOPOyXEh1OVS/PUOWBIBVxWVjwL8RdGrrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10337
X-Proofpoint-GUID: FfdjiXVNJtAHgGovhm3C5Z5nPlFrVMh0
X-Proofpoint-ORIG-GUID: FfdjiXVNJtAHgGovhm3C5Z5nPlFrVMh0
X-Authority-Analysis: v=2.4 cv=AMUSjw+a c=1 sm=1 tr=0 ts=680b77ed cx=c_pps
 a=K1+iGLXgNHoxMcL4Lb8acQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=XL6wrB0Zc_gxRR1ig4QA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4NiBTYWx0ZWRfXyxnvsAkt5FLj
 xAMBqMPtgyyHO737ZWmhTSbW9besOzpEBsu1PUVZd3IbvFdcf437Mp41PR5vn7FlzaVW/seTIjy
 AHRuuMxSbDsrXqxSx6YkSAhCI1X4YkK/VAvUgHPD7bfFQeh40qOIU+WMCF/UKxIs8rEN+yFi2Nk
 srG5dOsMEojkflSt3kiO/xHSzlH0Hb1wKjyi+FnboNctP7EGmy5kHoDs295ah4n+pjsLxbkPznJ
 iI8srR4iZph0dIUYjN0BGc0Jj33ryUkO9iaa4a6qixoIWJ5ucPTvLOS3YyvsHR2cAl6yPWyrJg4
 2uBhDEMkELb4iLYpjdWf0fjenGt4XjnPelpvY1fuI7dlN8Nb+tJ7h1+EK2/5H4liw6VFgfhdhg4
 2pIyEjsuruaKhunpx0ncSshfYh1QcyzcsbK26mUzQqa/aQc00s+yESMy21UZEk+aHtqp5RLt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
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

NVDIMMs cannot be used by PCs from a pre-PCI era.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index a12f63dad6..1e364ddf26 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -557,12 +557,6 @@ static void pc_init_isa(MachineState *machine)
         }
     }
 #endif
-
-    if (machine->nvdimms_state->is_enabled) {
-        nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
-                               x86_nvdimm_acpi_dsmio,
-                               x86ms->fw_cfg, OBJECT(pcms));
-    }
 }
 #endif
 
-- 
2.43.0


