Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DDCC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 14:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfeyM-0002Vv-6B; Fri, 03 Jul 2026 10:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfeyK-0002Ur-4r; Fri, 03 Jul 2026 10:34:28 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfeyI-0000Xj-G6; Fri, 03 Jul 2026 10:34:27 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6635u60A1994803; Fri, 3 Jul 2026 07:34:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=dtm2nq8N2e46i3bGGrTUnGI4x9LIFyNbICa3GRLw/
 Fk=; b=0HlVZ+IX4v5nw5zM5uvtofz+I6f723VBZoEHlPlR+GODzkcJD75XIS0R7
 IDqoEKL0uPOf3Avz5zS5QRkfzOFCyQs9VZ8ao7GvH7euHNofKJKtaVaRrXZGMNi5
 tNq49TFGnXIrt63PjWFnMn0dlQPx4W+ml6qyZPfAnolEnBGdSfMH/zfJBN8wSy3A
 o0avbRgU4QaqfWE6ru84HwMqOgNyPtHJA80vtVRZETHf6adDz3dlKPdTQH5e+X0a
 eR6AMGUixNaHCi0Sv0G3TNf3dOY6dMuZlW0iiibKRIJVBSVbHxvZt/q5aD9288RY
 1ZkGppe0oEXMRZAhJOEjTmZTtuMeA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021074.outbound.protection.outlook.com
 [40.93.194.74])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4f5d5hcptx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 07:34:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/3gYZS13lSRaD60SdBi2ttaIAhveGcqSBGUGRB0O//VrHI1n+wsrX6d2/IXuFkCOR6azz8Jbv8/0Du/ZpstAmKT4/3yxb4yoOai2/osJNGcvwn15g6t6/IAXc7Cx6Z90x6XCjWoRTFIGe0XCC7nmbTkoBFbguZIM2KxOFWcTtK5++zpAl+vdoAYpS0GEanEGSocZJs1e2lU8rqxaD2wpUWgeT5fBkI+fmx3UE/KyWJ4Ol8WjKK8C/8g/ZdS3VG1WwSkveARp+5+dKeOA6Cjb0npZ0Rc3+XPvfd3v5S8IbJMWKudXfMwG7OZwZ/A1W7FHsq2TPzZg+H0O9iWrh1USA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtm2nq8N2e46i3bGGrTUnGI4x9LIFyNbICa3GRLw/Fk=;
 b=igYxYYvaWil3cl2sce2vIQTDOKbkGZq7sHZJz0z4QHvyD+2dwlXo+GarTU24N2jIYJMsDe8wtVnwE4ClsM1zi1DE4XuxaY8K2PqaPiMS6qdKSW/SpFH1ijLmlWAxUNnLdunInEb8pg1mykxsE+SHs57cHbZRUXQ6iLhGGybYFHv6vIU7GlJ7kGJjTDb2pMG72ejFxON+onAa9qEHFpZPyx2ld3+EqBTJrlYIMAUk4eCsTfAUkFSMfSYq05XJsIRqKyPjctkFE94GSpqEX+6MTIIwh6GWKB5iN9DqaQrtRZ1KtQwMOatV9MSQMCEH8budGPEl3iFq5XkEgdjrs2Q9ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtm2nq8N2e46i3bGGrTUnGI4x9LIFyNbICa3GRLw/Fk=;
 b=gzs3u5XZKMuhPmOiEV7kwCbaRpw7M06nekHwyPvJ92GGwFNroNfFy30ZbaXeBthCtB0eDJ3RSv77IyxMFKDi+NjP9N/rODeRoalx4Uj8LXwL2wagdzQ50AodbzdcxmQRNbDoehymOZf5pg7/WITn7VmOjOxKGrpWySy2OJ47FAVYcF/IPlSr6zMuynDmE/vzfiugozt2YBzShl7nJXMVOMUz76wlbsKLlArCjMEhbxBA7GOquRLOR54qPaulPz+PMArET/lR3iJQeR2+g0XK4O79w1plYgPUgISG78q1pnrrM5le9X1d3KElQeFIQi6N8N9n46NYmMU+zwC3rpJsyQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO6PR02MB7540.namprd02.prod.outlook.com (2603:10b6:303:b1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 14:34:15 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 14:34:15 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: kfting@nuvoton.com, wuhaotsh@google.com, alistair@alistair23.me,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3 1/1] hw/adc/npcm7xx_adc.c: convert NPCM7XX_ADC object props
 to class props
Date: Fri,  3 Jul 2026 15:32:17 +0100
Message-ID: <20260703143408.3235231-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703143408.3235231-1-mark.caveayland@nutanix.com>
References: <20260703143408.3235231-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::29) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO6PR02MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: 457bfcef-d539-4e31-e70e-08ded9102877
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Hn4UEx2gVHx2tLRSb0UP60W9jyzUPgExUmtrVwLsBD5mj3tIT84IHenHoUSnqMdy1WQiWOabLzwtt+evWcjlmH2P0Jh7jN/mZvr0/+4C2XUFAhxAZlxpzjOjcmgem9vPgOyzgGwkVt0Ww9jk3jt60zHH48aB8ydyvpme0IQ+sV667OJ1+OMnNJbEPDkW0QGbBObkJI3U8kYmBAaevb27qofhvZkbffjWO1rhrpisZUp6Nk7jIAK5W3vD9A0+q3zy9+P/3DbdOvXmq77YvRAmuChr6R/4Jva9nTVgYM2TOBpSTVz4mpViAGCAucEYU+Cc+sm0IHTMPpBMJXqeqUejsK3LbBBYGEQfD3VoSkVt4f7pwwvMozLx2isCu3LzCThWh/zeT7+dR04RKQHo7Wy4ood/C5Wp06/nYJUEBTajcF/2WTA0uuuaseDKXv1S+Hxmuk83wqGlC2zHmQMofpnkKAgrTQpsCZT5K8BFiFQY609Uibz0SkBkFnD0OIoZA5YfKD8DeROlfDBeuEYSTh/ra/CaMTNUCD0q6deRaswPAwzT9e7GVz28DR0xewmTJOuNp3eQgi6ztPAxg4Y5AgOLyx0xJYbqxVoNg8xg1exFyCuwC7bs2G+Ie8Xya0PBe1jvvzNu7BCcG2ZT0KOCKLIEYg8PTuKj0G6AMcsEpqxlDl0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7GRWQthrCDJRo3MNpkpa17O4iCRnv4T0I3l1Lh28CZWkz9vaxWdzgNIPfR4t?=
 =?us-ascii?Q?KNOOCdfzvMh7L8aHomC5w+O/OZ7hcH4+xOjIpYD1bB80YBSIOLps+wQcYohH?=
 =?us-ascii?Q?xa8tM1xOWEf3IXD/4iNkxtl0qSQ6kanZvutII96PLWzxu3Dt4zsZv9tKan2t?=
 =?us-ascii?Q?rooZFOZ35/Yv0zb095Z8VS1+eJ4eNX78Sdvaih4n2Vv/yG5GhGBow+Tb28/o?=
 =?us-ascii?Q?EdNfr4TTj9qUE4Kk1kuAirnTAST+Oo3xZ31GJ/Hy85I4YI4YpflBBmXbN00j?=
 =?us-ascii?Q?oqKUkXmEZ+x/PeylFyMzCDwYhJqYNJkgjJfQqbs1x5012Q/LJ0cUfnOmpdFn?=
 =?us-ascii?Q?Yqzdme3gbGSjCodR3/ihY+9VH8qf5/GMjtNiyLKJf/WnhYEg24n30oQ+kK3R?=
 =?us-ascii?Q?DgvnZZdq6tbViFsGIpHJpnnFD9vQImHmpScu4UTFdX/j/72UQ8n3oZu3k15A?=
 =?us-ascii?Q?gVtm8masBWGr2k2RR0YyjjklhOwjvYOXa4VxYCjIPzBbOqawH99flF/A4Gya?=
 =?us-ascii?Q?6rbXEeHj5yPd/csDwnx6remAH67FfJSQzLHDuU402iSBfFqyDBydUsvVSm5e?=
 =?us-ascii?Q?5SrlBj+H64DDnlMjqKnEc6raxxR6uek3SHWEt+M8TpH+dsAKMB59FYrDFsdD?=
 =?us-ascii?Q?oG/mDYisVhGrC6UP4t55BOMUhmuqxQCTRDQwjE1TirpSA6yu8zMUPnjiskcc?=
 =?us-ascii?Q?Owh8CGZDX3VgaTj1099qnIpEOfHFk8pcDfvRU8JcQcVSYjGgB250cfbxk7Nr?=
 =?us-ascii?Q?9X4AHew85JIFseobaCvoZAAcPLZxirWiAhaBH6oIC67TdQsIy7XdipNi3Yqh?=
 =?us-ascii?Q?ztKVCWYB9V055ipCH6rZNQnxVQXBVgJTu+yRHXmyqjrbDZsL5ONeORUg1J6h?=
 =?us-ascii?Q?dZJKUdzKMys2dnSaMphShmi8HhUpNnvLzBK3QKyjv6rOyvgXkHloaVlbCR9/?=
 =?us-ascii?Q?96au7np0eK4LQcBjgaEt/BTn8+xatfgc63suLb1gk5CuUVbCypzHsYXimyiZ?=
 =?us-ascii?Q?nxRg7ngL7mz1hZQFBk8waz9TvQ2U0EwbvBxY13ZlWqG8FxzghYAN4SQ+pVIq?=
 =?us-ascii?Q?G//9Uz3Munm6zJDNEA12vHKTkf1G6xUhKLTK2pfNUONU7NB0LzRpIEEMc/wV?=
 =?us-ascii?Q?anViBXGCvbzmbluGeGBrCiXWWyMdqgbSWo++FRpJJU/GtRy+L2oCiitwRpP0?=
 =?us-ascii?Q?hEGtX9pcyml7YQpwBik1mWOhnnC6rJiE1N4gjQogk6AccdDwqi+A4YZA7eqz?=
 =?us-ascii?Q?gjsNe/fOsGaNTBMs5uY8UKoGj0FKCf1YFvo0r3bfIoxTb1SKb8QkL4Q95aeS?=
 =?us-ascii?Q?QvAUAT9wjgAQg1yIUSYooyjNvJyY4oV+AA+YoD2/2HNGIlMzX0QQrCRHMI3H?=
 =?us-ascii?Q?WyK2UkRbODncE0Ci2lKOErTF/4Oyv4BOZHo0niK8fVji1Ame5WolUKvdEsGY?=
 =?us-ascii?Q?a0ovHmcnfMvE+PqkQGd/kZnlxvISM4aqAukoQtI4JeKxaiD1N3xE4ohtKhaU?=
 =?us-ascii?Q?S6xLo/T7oxyhXVxWUpcUiF6w1oVEbpqjSpoq6yrmVpnVf1tqtm3iCtTVmaqR?=
 =?us-ascii?Q?WOrfaHhUvDevEApidymnTtFPqOeAEhXyeO4beWQaAhUQyEhAIpg0cqvh8qcy?=
 =?us-ascii?Q?4MAidRqDz4R19bW977zBEBVnl4cYQ5A27mc7EwHJzC35eDLhOYUEYhOAuXEd?=
 =?us-ascii?Q?nwxBDfkwD7wypIUWX4U1FQet9aFPLZ7sagtktcKexPr7p4U5KkkUYLTJUykE?=
 =?us-ascii?Q?It3baxMVwiqHly5GFogEMDtJb6Z8O00=3D?=
X-Exchange-RoutingPolicyChecked: LO36VBsE4ttnpd1KNn5us77MgDTtRmdExKjxTYxAwjvDcmuZmfxPW2A2BoWusFAnu4P3xoprsfIUGUfLt4qeYK1MFvucGWw0VmnY6j+9hpZN2g2kuzt9qTawUcsWrGNuzZQN/AmeKdKSxJmHRu5OTWIqIFcHegbUXcDogaUjsf+EbgjVuJ1RdGhr1B1DUEeFozO6bG5+tYV4B/sbxAhxE3gj8POLiSmSJgQjLLyZPoKExzzEZwXRMRv3F4VQ0arktSIzkLGEXrk/uvcDlYG/jO7uf47R0TsCqPeBQF0Rx9lkx7fRGGdaWCnxpzvx81OO5xhW0sDTJGSp9Rti/6ppHw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457bfcef-d539-4e31-e70e-08ded9102877
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 14:34:15.5516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gGFh0L94WwcDqqnwGH5cBb9PVsLsiGCUUi8YmGBn04NwZsy+AsVyWB4jgsJx4UVLrVWkcQdaHzQkUJkiHQ/Df9fw0Z+bc0MHVQgisv2D/Pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7540
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE0NCBTYWx0ZWRfX5O6Y56TKzumY
 vtTAuKwbDB/rwYCzKpoyfc7Gm2j6FJUvOR2e5U+rNYxbvAHSJHTesLbmquuaGA/cxNKuCLpaZdC
 UfAd77rK2fx47yGqaSSenBWvFJBt6jwEJpDt5AyQQGuYXbc4WymctYMMT21UtyXU3wv7MdTDDLe
 RUH3M9AwAYDGzgGsgTgGcUoUSNAbnWF8QVT7/wcAKppZDd1B1AHmkxbx6MQwJyDKwcgjqtNyVeJ
 NewdnV5caJug4ZevYm3voFwlK3gRrV8p13acjllex4QVSAy74s2Pin2mDaYm7Lp4sxHl2/3W3RR
 82A7IWQrX+NQ7gZMiCxYSF4K5DIE0WQ0QoanNkpp0s07pNFxWmr5YfwZvnwfDC97znkbbBuA+p4
 DUDnGbKByQq67D7aAe+2YSiQYFIXh95UThC2wcfKS5nRnyb2k7XAAZTFEIAdrNItYixoZ2vgquH
 wzGdTaY2N/CsOutecNA==
X-Proofpoint-ORIG-GUID: IEKbG1lvSsfad3Zi4KpM087lB90SflRs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE0NCBTYWx0ZWRfX3D+Kfn6NyUbZ
 7nyCI2FpqyiGwvetdHsaOfK05P43K8wyKoAsa9rTMq0CqctfciZyFC+oyjWsRbaM6wUxSQ50i1v
 VJ6baxlrtPC8GutD89j786EgsQ3QRZI=
X-Authority-Analysis: v=2.4 cv=EMM2FVZC c=1 sm=1 tr=0 ts=6a47c869 cx=c_pps
 a=pHX0GuESvmlUVbyXmFftrw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=3bBUzViMNpvxIeY3a3YA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
X-Proofpoint-GUID: IEKbG1lvSsfad3Zi4KpM087lB90SflRs
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
 hw/adc/npcm7xx_adc.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/adc/npcm7xx_adc.c b/hw/adc/npcm7xx_adc.c
index 3584c27c75..27d42f87b1 100644
--- a/hw/adc/npcm7xx_adc.c
+++ b/hw/adc/npcm7xx_adc.c
@@ -229,7 +229,6 @@ static void npcm7xx_adc_init(Object *obj)
 {
     NPCM7xxADCState *s = NPCM7XX_ADC(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-    int i;
 
     sysbus_init_irq(sbd, &s->irq);
 
@@ -240,12 +239,6 @@ static void npcm7xx_adc_init(Object *obj)
     sysbus_init_mmio(sbd, &s->iomem);
     s->clock = qdev_init_clock_in(DEVICE(s), "clock", NULL, NULL, 0);
 
-    for (i = 0; i < NPCM7XX_ADC_NUM_INPUTS; ++i) {
-        object_property_add_uint32_ptr(obj, "adci[*]",
-                &s->adci[i], OBJ_PROP_FLAG_READWRITE);
-    }
-    object_property_add_uint32_ptr(obj, "vref",
-            &s->vref, OBJ_PROP_FLAG_WRITE);
     npcm7xx_adc_calibrate(s);
 }
 
@@ -275,6 +268,7 @@ static void npcm7xx_adc_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
+    int i;
 
     dc->desc = "NPCM7xx ADC Module";
     dc->vmsd = &vmstate_npcm7xx_adc;
@@ -282,6 +276,17 @@ static void npcm7xx_adc_class_init(ObjectClass *klass, const void *data)
     rc->phases.hold = npcm7xx_adc_hold_reset;
 
     device_class_set_props(dc, npcm7xx_timer_properties);
+
+    for (i = 0; i < NPCM7XX_ADC_NUM_INPUTS; ++i) {
+        g_autofree char *adciprop = g_strdup_printf("adci[%u]", i);
+
+        object_class_property_add_uint32_ptr(klass, adciprop,
+                offsetof(NPCM7xxADCState, adci[i]),
+                OBJ_PROP_FLAG_READWRITE);
+    }
+    object_class_property_add_uint32_ptr(klass, "vref",
+                offsetof(NPCM7xxADCState, vref),
+                OBJ_PROP_FLAG_WRITE);
 }
 
 static const TypeInfo npcm7xx_adc_info = {
-- 
2.43.0


