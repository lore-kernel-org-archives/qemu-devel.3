Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B4DC44500
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfZtL-0001Tx-P0; Fri, 03 Jul 2026 05:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfZtJ-0001Tj-UY
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:08:57 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfZtI-00085j-4C
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:08:57 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6636sFUq2069494; Fri, 3 Jul 2026 02:08:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=anS5ymXFFNAH2bV4NOX34WjYyDwvEY/VUYLdLTvHz
 lw=; b=UvV6tEhqiIRWkxII81i82t6zcYiI88n7U3yjtZD2u6MwTm7K+BkzxAhgz
 3FqTxJS85zmCCAxM6Hrw2K6qBcqeX1VhW6EpBCqetXYmvL8iSphNU5ezGWmSnhpX
 58djlPzm/wJu2uFg5J4TCdnwDnSPqkSsUShM7dF1O+sL1Xmjk/yVpNnvfpAhMHna
 TItN+iiiUR9DCqnxiEdcYTKFFjq6fqrOY3b380+E1aANfkNaWvKo4gyougIl2Egv
 vNc0otlvL1SlpgNxE/eB7WJcH8mT/QRyPPmtjbOXDkGPRhFR0thgzcq4mKdRYkG0
 bhErXiQAp3suGG8ki5ZG8kloa8wsQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021122.outbound.protection.outlook.com
 [40.93.194.122])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4f687k098d-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 02:08:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVRQ9Hl2soIaMIN5/L/IU2tpH34ME0GbThokEJ4d/Ok9xHFCFCvZLMNPfk5UP7QfWeBm68Av62dYQXvRNou64aJ3y+QfcFX4pFY+0s57uGYrJx+Gkn0fDaZRRNf8r+jVWuj+8uwyEDSYjsKhp7x+LG+9uWyXFIbHFSsgApjg07sfvv1poPRYDEZ16M0N4RLg9WvcNSl7LZGMOQkxYw3vamGK+hjPrUmmZ+OzbmXSRfd+UbN7T7buFqcqsQ24yNxWIw+t3QtbdF4UDWRV7dpYblDo4daahKi63R3DPVfBQHVXiJ22Gi1Qj+i7y/mgwP/mdDqKtEKGzY3LRPEbUFtoTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anS5ymXFFNAH2bV4NOX34WjYyDwvEY/VUYLdLTvHzlw=;
 b=L+Adz8Ggxh+8QUSX1n+0xNP8KnrK0AHc3PUi86E4NjVUcC/wd+HH2pyapAauSsnyuwyGQw5G85RHOFE/OFmYd7UEvPftPR98Y7MKVA+HM8IUVILWeoKpMBAOKx3uiWIq1DQNXdY0Sa6QDnM7MuunR7aeN2cVwm76nFqOnistFxe9P+DlPU3nQ1GGkryVKG6LqEuArkT9FJ637LD3zic+ORvGSg3Cow6uRwXOJ8FzW4JnZTmNSQVkzWRw/f4VgAsAuiPh6vZ3iltrLXndPdor1Sres0sXYPOEASHW7H20c1fHZww8XY8owiOxQOpPv8rW1QToqBGNv2PPsprhcOyldQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anS5ymXFFNAH2bV4NOX34WjYyDwvEY/VUYLdLTvHzlw=;
 b=B+h2iPwqJKfKUT0rfwxeA8uIuxAS9uXOrYin80+9AHpqv4gBrCXTew/TLzKIcIJtW9V0cWiE7FV7TkBM0plHypEGl7SD37uuh4/2v8Qw0ZKKbuTgkQoyQtgmW9r1dmNF+aXvD1IqFQgeeTpa33meTpdrr88ZrUHAo8pRDXgez1BWzX9lAmGg1897aNX+BcCCtRoHOfd1/Xcr+mzuYNf7LrqyFWI+BPY374rbWlK3uprvEQ5NvXLMcDCI57/EXeLlMTMjJZACGP1FieYuRw9jZsImZzZm7Z4kNcsPk7B4s5zkFvglVuBAKP5BMJKInNmJsflkUyT+TEzaKxxGYVvI3w==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA1PR02MB9420.namprd02.prod.outlook.com (2603:10b6:208:3f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 09:08:52 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 09:08:52 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 8/9] hw/i386/pc_sysfw.c: convert pflash0 and pflash1 object
 props to class props
Date: Fri,  3 Jul 2026 10:08:01 +0100
Message-ID: <20260703090814.2993188-9-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703090814.2993188-1-mark.caveayland@nutanix.com>
References: <20260703090814.2993188-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA1PR02MB9420:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f34f2d-0f8d-4da9-cc6e-08ded8e2b2cc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: VP9mJHpjZP14GLBmzRoc93chCiDWNa7Y6jFJtO0V2Nh6FDLMIqJ0PTx2PejFkOM/HnbspcYJ49WLvYpw5EUJyFje4B6sp0pa768tNEbNOfCcivjtSVZZEPUrLMuCvzrPjQRkLx314fOM1+yOBmV5jYaGuEvrMD/xCYUtljbmVGe/ep7nPBhb8TASzrUZ+RAeSo50g9u7/MGxQ8R5Rx7YFdtrqI4wAr0LCZB1hrXUTYz4OGdYiiQX3JU3xxuRmYvqGaIvBs+8xjVR9Fa4Fhi+qU7xE8a0LahB2K2gqSlqUOPSWVCVxEGuiPK1tB1gZuiRi6ncQm18D5C3dWdIvcj4LG90iTvYorrQUYOMdz+HaVKNoInb9LV94t/CUM6anzikOoijXuxGo2jQKbwTZbsMs2jEDxTdpd86pSvOMpiL+RjPTiH40JUKQF/q6QefNsaZ91+h54fKglQIGQLxFQ8Vg/d67eCdyvzKmBQcX9uzEF8VBdrSqZyi9R4auoxVOT1Euz0VqT9uHfy7C9L2WqNUQH7Te9ogMuDRcMBBFPuH5FG9cUvzTzh/mVfDKT7ZNP+l+kYidnhKEjqjLdVbbU4mVZS++SDV9ZH8z2OZYlhNQvS4CeGEa4ULgcq5iqaBnQHNFMrtp+Vwq6kCeBSDejSG12ths3wnoBBNcSCcH/qyAm4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hBq5EUGbagVfKYWTM9Cw56SeiRhU669tMdrrbffmOql71z5ryHVzvHJUwzEW?=
 =?us-ascii?Q?oLKToF5jvRyFYE0MhzP6druK+iUe+tMk4CiPI+FeUODV1SDNQNcL27CP54ka?=
 =?us-ascii?Q?bhAuCl5+RceS6ucyDz3LfgfEefEcSp4oObbTPmOOkvgNRRM6ZajqM9JZ+/GO?=
 =?us-ascii?Q?jRehVTjy761PrXnDjVJCd1PR53DWwYlwa7tp0BVuQ6sfQkSXkGO1eUoSiLse?=
 =?us-ascii?Q?3ZyNH0Adtg4XvFVlzxucTHa5swaSpbScqCe81xm7mT4Obi18ldjTmgwH3BhQ?=
 =?us-ascii?Q?xr8A6ac3/m8dyWwAJ7UBi3aI0U81KELYyF4cauYeqIdzfELfQKH9OTuxG9L2?=
 =?us-ascii?Q?J9ejjUZiAfHN26k6qJAC0c5OXrxHDkBivduNpVSRkpSkgNJnVxh4EYu9rGOn?=
 =?us-ascii?Q?oeY/nSF6+kL8jT4hH+u03hqzgiy7REllxR+F3XWKDauVgV+jN/3HTGusJl66?=
 =?us-ascii?Q?HD34eVT2g2CkXn1lP7DOkEWxA3sIBfTT9zqbv8oduCdozusOdNz8nHA59Vu9?=
 =?us-ascii?Q?JElSR57KrUXrlf5ANs2MhkC9VCTS4PC0HIBI0I8H6tjuS1K/D2mx2AFtrLnD?=
 =?us-ascii?Q?hR21u96qntUl/HO2lRz6C8j859ud10WZSW9XnWjLXykQgof9rPeiqIqK8vW6?=
 =?us-ascii?Q?cdGu+XDxeec/Tc3zZ5vzVscWjOqVJkJWdzM6q790wdmooxuH47EB5pF/i6qv?=
 =?us-ascii?Q?GcdIdu/nuz896v82DW8GccyQDBZLxsvFGBG5VwEcxabKRMRTY6U5rnnjhxXZ?=
 =?us-ascii?Q?D1BCRskAR/eEuOdfaE4hMXeZT733rMhyxPn8soh4mLjsnelVcR8JGkZfouwQ?=
 =?us-ascii?Q?hBnNO9Bke5/L3xDPFV3UB0FchTZYt2dwAYyFDzN+7TJWTnqJ5kn4Hr8RkaM/?=
 =?us-ascii?Q?IQ7ylZx2pq0RByossRaMLo37NWwxQJN14xr2hhkM/2jDJ+MKIDEyvGUxLcc4?=
 =?us-ascii?Q?ieNuFdxNuCY38supjh3aDpxs2V3V/xPaZ4rh05T0e9CHcF4KvXX81H5Kl33E?=
 =?us-ascii?Q?alJTaOsihO/xZBkg6CslSljBoJK8IHR6a1MTTH+0m0/85f0NPEl/bKa3h9BM?=
 =?us-ascii?Q?5bcSbXNi3iQjMcpIVx2d/BrDQERjjo+3RXjAOWDXrjEZ1G+BIvC7Fm7lCOUQ?=
 =?us-ascii?Q?X0H/PJ1Z4D1FaAzswn0qJp9yqBTaDZLTJPvpn5aX2EHl4wSCwzohlFZo52LJ?=
 =?us-ascii?Q?iZ/FB9wrS13fq5BSph7ohH5ifW9SqNX9fmvTk7bqe20V447rb3MNiEc/3HH7?=
 =?us-ascii?Q?nIGUWyorEuV84pHqEN9nZCOxherV6Z/A9T5w4+L92vkV3wjXx4XzPk68Pje4?=
 =?us-ascii?Q?Vvlk8dSQgnq9gtg4/i9ppg6UtHFGlCVtW/TlGnVRhVQt08sDygA0yVS2aX3M?=
 =?us-ascii?Q?gQe0rpx6U2PmM1J58bYIMStbuocRZEiucsiDiX6RmUBaQ5IrN7ZF0u/PhFER?=
 =?us-ascii?Q?TdiiqMKXwgTXIAYuszPpPpOx43yAx3akd3yGwLEx/1MBgcYcaT2gbq4eNYLA?=
 =?us-ascii?Q?aqBjvLNai3ePAOS7KLCnkH1+rH5ABJDEO3nuHPxzs3bbbu626/9MA2ye7EfF?=
 =?us-ascii?Q?8RdbIL2s1868dtaeDhd/BQbGms7jGrrUldnQK1Fut6Hlwo/GXnvTkKQPqmFA?=
 =?us-ascii?Q?fCmrshLlC3ha4HX6+E13iLjeZRJeckiAAIOkjfX1pHRywlUOmWLBCKyLrkVQ?=
 =?us-ascii?Q?ZNdI5CB1w6AQYS4zaUyeexqWuHbey3TiFhip5ziQKm9YW890xpfZKbBrOyIA?=
 =?us-ascii?Q?dqFsL+VTOa4L1rA8/tegkOjozay3WZw=3D?=
X-Exchange-RoutingPolicyChecked: Qdi2DddEWaWaU1CfNlo281Ucl/9ndZh5hxUGgs7NcaPSXY0l3c6jIhMZszGYFuD0fwBgQkiveGTNvHT0a1hFvDowoGcClUPPKhF9rXpnSF4M8yJhutuQkdekfwH0xhtRA1mpc21l/le1ffbjBuBHtX/fxorgp+WMqFcQZuGoxBfEh2EKnNFPGGYI25a89hqqF6trd+x/U1hb84YKt5gasaWqQTv99WgtZr7dfYb0kPWR1Ir3xF3sXaiLdX5wOWmhW9k+gbac/SaO/djA4+OnsWn7kCOpjofz1oA5+q8ycz5uM8ltcJqgr2KoAVqOOcgOMAfOhKXii+1SB8TKW2ktnA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f34f2d-0f8d-4da9-cc6e-08ded8e2b2cc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 09:08:52.0935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51t/5Mz+iH7vDUer1MupoI+jkYtPjU71HDiq3zA9fsyMWHSnXDQrT+aRLMB1tJJWT9a5sbWNBSGM+i64ZKomX6NNGh5QymkbftBv+TFtslA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9420
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4NiBTYWx0ZWRfXycelOjPcPMiA
 ij6hBnrwd5I6Ed4JvhhTqgzLtS5ucqVTNt2DCK6mJrL3S+RdReTen+gtkp11ba0JJEfH1SOJI/P
 vtfRbpnUJrIW6Ef8dBLYxcCq6CYV3vUSVz9vkH//qFQZqscEqEtrmh4rdiKfv8/NPjXtedU7p1h
 xM9vi7UeEY35k3Yqkh9+jY6B2tJUyYPCPViyUsSmDs5TT6068Kjogg6KzVqFkbZpPiOIIoy/zJV
 10MoG1uvszF63Q7uLvwAJxpQVZPjm717x8ji4sp+tESno2GIQ/hgUJvM288omPgaVvpMUmQfXwB
 WsqlF1IahuZ/RMvFyEEVv4TG13yvEgD0mPaVpoHJw7Kz2hxFQfYYhDZAIzfwIjZ3VK8SEpHuP5o
 iiVJ2KNgsPPH/TwOxOCObh0jDI7hahi8vSxEKP6jNQcXbyzBVkgyfvSTsgyFmHcKoOQpyyzqDhK
 uva8gesyRDPviNJE3Rw==
X-Authority-Analysis: v=2.4 cv=EZz4hvmC c=1 sm=1 tr=0 ts=6a477c25 cx=c_pps
 a=CN5Nmbld9GKaZyt1KupX+Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=vChACzxo6iogHhlksjoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4NiBTYWx0ZWRfX6OpokqMr1woW
 L5ePMSNpEmcWa7Kjmmv/4OVpXZdMenvEYHAZnwpkgJyfRHrOnzuE/JQGD8jxaVq1gDk4V6ML/m2
 P0kcYmzAIJpWbEqr3U3nHYHGAB6ap9o=
X-Proofpoint-ORIG-GUID: xDCwMViYNkAYS2D1KIRatrCb8gPj81s8
X-Proofpoint-GUID: xDCwMViYNkAYS2D1KIRatrCb8gPj81s8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
 include/hw/i386/pc.h | 2 ++
 hw/i386/pc.c         | 8 ++++++++
 hw/i386/pc_sysfw.c   | 7 +------
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 309de2eda1..16cb0ec01f 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -40,6 +40,8 @@ typedef struct PCMachineState {
 
     Object *alias_pcspk;
     Object *alias_rtc_time;
+    Object *alias_pflash0;
+    Object *alias_pflash1;
 
     /* Configuration options: */
     uint64_t max_ram_below_4g;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 13c9c1bfc8..11eef176f4 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1762,6 +1762,14 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
                                    offsetof(X86MachineState, acpi_dev),
                                    object_property_allow_set_link,
                                    OBJ_PROP_LINK_STRONG);
+    object_class_property_add_alias(oc, "pflash0",
+                                    offsetof(PCMachineState, alias_pflash0),
+                                    TYPE_PFLASH_CFI01,
+                                    "drive");
+    object_class_property_add_alias(oc, "pflash1",
+                                    offsetof(PCMachineState, alias_pflash1),
+                                    TYPE_PFLASH_CFI01,
+                                    "drive");
 }
 
 static const TypeInfo pc_machine_info = {
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 1a41a5972b..441e777191 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -85,8 +85,7 @@ static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
     qdev_prop_set_uint8(dev, "width", 1);
     qdev_prop_set_string(dev, "name", name);
     object_property_add_child(OBJECT(pcms), name, OBJECT(dev));
-    object_property_add_alias(OBJECT(pcms), alias_prop_name,
-                              OBJECT(dev), "drive");
+    object_property_set_alias(OBJECT(pcms), alias_prop_name, OBJECT(dev));
     /*
      * The returned reference is tied to the child property and
      * will be removed with object_unparent.
@@ -109,16 +108,12 @@ void pc_system_flash_create(PCMachineState *pcms)
 
 void pc_system_flash_cleanup_unused(PCMachineState *pcms)
 {
-    char *prop_name;
     int i;
 
     assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled);
 
     for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
         if (!qdev_is_realized(DEVICE(pcms->flash[i]))) {
-            prop_name = g_strdup_printf("pflash%d", i);
-            object_property_del(OBJECT(pcms), prop_name);
-            g_free(prop_name);
             object_unparent(OBJECT(pcms->flash[i]));
             pcms->flash[i] = NULL;
         }
-- 
2.43.0


