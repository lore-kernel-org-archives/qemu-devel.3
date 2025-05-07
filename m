Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B148C3ABC3
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 15:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCga9-0004jn-U1; Wed, 07 May 2025 11:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCga7-0004dd-4S; Wed, 07 May 2025 11:21:11 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCgZu-0005s4-GC; Wed, 07 May 2025 11:21:00 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547F6LPD025060;
 Wed, 7 May 2025 08:20:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=W13NCHLngB1wZu0vIeUXgBOsZUeb95FQSD+L4kIqj
 To=; b=k+qCJSCGfmFEupFCbpimKXrR1pI8lXE3YzgCBslb2dIdky2Jtm6L7fV7+
 XgMX47AaEbhbCIMCzjn/eFSHLzHOl0lx5C09lUrqqO/p4iRvqMUU9At0VWqzJYC8
 KmkNuGgu6gR9aX3J6ElP+mGaJVKEu/1+04bFVAs1Im3Hkxq92QYgkilEL/JNDkuD
 z46I0eFaNqCRy+Zjk7Q9hHf24JDSl54Ntfw6hGQ8Dcg2T02LXqfmzwEnhwNCsqYN
 GyD5oI48ZCW8k+1kZK4LkzIjKYzXXk7v2pX+7QZ/Tf4ERU23V2MzDAmsigMU0iSe
 bQ6hL1rxdSbTihK5ded4EYfZKpFxQ==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazlp17011028.outbound.protection.outlook.com [40.93.13.28])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46df2995n4-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 08:20:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPwUCBF19a4diUvtOagXJf9iasd8FkQJnAfN1jgcQyRXCr5zj8NaF1P2Y5pMEdUiQIlcND6/mVbspgA5iFRu3ajyYqZ/ROpop0Fs+KP7ZN3bKKBvbbtoHSU5xXtS6mJyC37QcTzV/RKG3c2al3Mm2STX/5LgP5XCCux9rBswQiVmXfNeKGg4ZAWFpf4EInzFxkxkJAuJKIPlTs39nlzOlT5PL5bl8uHp8D5q9vIO/6QUDN5faIOUfEZ2gCWA2CAagPMgvh2Cwej8G210vxZybXQwWx480IPFrdjSvJZ2vQJy1M/GAph1FmxC9WdTmec+Rdh2CaOe6vuMQVmN1Oi2Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W13NCHLngB1wZu0vIeUXgBOsZUeb95FQSD+L4kIqjTo=;
 b=i6m46uKAvrnFddk2L6YlURMPX9amSvtS9j6rLdX1byzWAspZOEeegRx6gjxjgaiXytYeJyT8//SK1ofUK88+80TDq5QyILBfKYbh3Xac/IucrqSb1BQ72yqTvTSseEtb6usCPVvzq3RphExz7KpVKHbIRz7jvArw0ecbmMLXln7x/eKcH32L+QCdUf+zCVpNetoUi7XM24Ubo25s1WN4B10a9KDHhnOULKxiKl+kjaCHlLUWJt/ED0OuGuwhbTcyF0RLHwyvC+t3wscc7TBUxH30VQVsOAMQdRTxiUgtW+nBTO968MQqKD0gThweBNJIx3U2bcEAXvlFp4rbhvEYaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W13NCHLngB1wZu0vIeUXgBOsZUeb95FQSD+L4kIqjTo=;
 b=iSAbyVK72XzugfABAi43xAbqDihpQMG0NpgJkt2BFUgTqD8lGZK+TOTLWRaHjS4jDS7IdWtpLs9jBU61tIuMynYKhOgZ25EjvEgpJ5Z9f2vzQdEuSj8kthm5gtBuOaEGFA8Mrt55GK9cu+QJsBpOeg5DN6os/IkP6fs2Fj6M8KW00Zoxth72SwMBUiwSxQIg5rdSllLErxm9kMJke+4d/WZxocICJkeDSGoRFHg/txo2Utvt91wgJ4gZRaNFM422XHnLJxcp64sZH4Mz9GoCXPaMRnOlFVPElna143GETHQnvIaEsVxtJZQT5lZM0KNdhTQq/p2S4/cMZujoVaRc0w==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BL3PR02MB8220.namprd02.prod.outlook.com (2603:10b6:208:342::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.17; Wed, 7 May
 2025 15:20:44 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%5]) with mapi id 15.20.8722.011; Wed, 7 May 2025
 15:20:44 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>, John Levon <john.levon@nutanix.com>
Subject: [PATCH v3 06/15] vfio: add strread/writeerror()
Date: Wed,  7 May 2025 16:20:11 +0100
Message-ID: <20250507152020.1254632-7-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507152020.1254632-1-john.levon@nutanix.com>
References: <20250507152020.1254632-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0055.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::22) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BL3PR02MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: 17564f1f-c529-4b49-c582-08dd8d7abc36
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JNn2PxRtWjx7/sFFk9ynWdJf7pJIB35sUQ875M5vcH3zlBdZZGn9Bt/Q0ruF?=
 =?us-ascii?Q?ZHYwbjWaZYL0jLOYLOL6WAVnnc4CONbOlucN51cNTm9ULWiWtuWO8hl71zQ0?=
 =?us-ascii?Q?GLcv9bvT5a5cyss2sKIWGQOpl833MoURYtaoX3i6XX3tDBewqP4uiE7OhDRw?=
 =?us-ascii?Q?DMP7EqaEGa9nlFkv75rB1QYOpsWpjns1QqpjXe6ejTTg71KAFM9e0IDy9Rvr?=
 =?us-ascii?Q?09sbLSSVqN3T0OXdxTaTVgZXq7YTKR66pfxkFsxjAWqLoTeoFubheUrTCfLU?=
 =?us-ascii?Q?MuhMAtIRHvxGNkLpcwxMW75kxLOBv8gZcSxH+iPXgFcO1SNaaZP0edWuk39G?=
 =?us-ascii?Q?zVcNNxKvg1cc+bBqfk6tPtvWHnp7YRcYhkWnHPGHZ471xb8DDQMv0CpT2zvr?=
 =?us-ascii?Q?26P7HMRvS4LDxHEn7eGzkiUSD7lgjtuLPxqtqcuk+Kc7hLNEmKnNzd6HZWSP?=
 =?us-ascii?Q?Qa3IB+vCo4pwB/ZfinSALrIQ3HLVeccYnFKhPgrPSKJdhaDyFqxN+T6VqUCd?=
 =?us-ascii?Q?+gxcRRk1Jf/i3gL/v9rifv8Yo0T3llR5SV5FNpKBeTbTgkHo0yYPHFKnW5KO?=
 =?us-ascii?Q?9VwzTyYMQm0CuU6HGrDfporngaO0tMs8copZqxgn1Kym4qR0YsmMUH1i/KDY?=
 =?us-ascii?Q?wXlcs7Lonzk+ed1+508dx/f0aMUWVSBrgHlq3ib0WpPneE1uyKpN+eYEL2QY?=
 =?us-ascii?Q?XlIDIdwxsB7Z9jVpziexzKMK4eKKSoDFmcHavrqxYLa09X6iD0VNZFp1JCwc?=
 =?us-ascii?Q?3yLlKnDHNNv4QE8kL+k8/mPxn0dzfA445aQ6PmYjDk32yOQ3ZCpngiK/OcU0?=
 =?us-ascii?Q?sGDD7PAW44E8iHguYTzUFG+GfjXGO1z8t51HTtCJqZGKDpT/ccXDQpKmwEs+?=
 =?us-ascii?Q?dT3LBVaXVIfYFamNZuDysrUk4Hp0W7KjydJJjuMNNckW4xrSiaBw48OGoeY4?=
 =?us-ascii?Q?G4d3jFW7bnSx2Sk7aE627YwKkznHm7+4as2gGqakaNHyLP4XN73WdgWnM+Us?=
 =?us-ascii?Q?FDeVrHR7Ir1sHcZugqpQfGvx0eeEKeOCLDf+XPj6v4RMbSAMKOHJ3QI39Izj?=
 =?us-ascii?Q?3STFCTRs8dRm+iRSHg7Flexr+dt8tCl/70q1e62BqgPO4D2mFftWI0xbFctd?=
 =?us-ascii?Q?tSd4+hV1aR5tYflAu6FS/4ckmNxin0GSgc2fs6lSyrcaCEc8o/01TRHUYLjD?=
 =?us-ascii?Q?V46wX22u+5Tc3x8rLLvdO5sFRuibvSvsxs0d6r3YZUrYgfUJsQFtbrt8Ko1l?=
 =?us-ascii?Q?6woUmW3ZJJLm14MXfGCVIEyW0+3QdfwJNNiznjJIZHC11+a1kCgowYfqqLCk?=
 =?us-ascii?Q?isBkqNBjiP0TyVrsDLhaO1KzTsbIjPZ6+KTgWATwXrQz1mfO2BRK3mOJE4cs?=
 =?us-ascii?Q?mqd3gUeTbjpBqPDn3hDb73RRhmyDGR4CIT78hiViDwhOfxL4jerxKbRyoUXy?=
 =?us-ascii?Q?coh67FQKf54=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m+dmIR7u7uMoCyzOy2xBLO64g89Y8R97+MgVnirm371j+wuWWhrnUaEIMooL?=
 =?us-ascii?Q?RHf/wqWaw0gDMuNShcHMeJQbesgt96A33aKJ9q8dqL9T+G8mX8PD6Im9iPps?=
 =?us-ascii?Q?irV62R6d322f50Pxsgzg7DROTJWZnjvCbGXdcn9YtDSsEaCR5O3RDLsUXPZQ?=
 =?us-ascii?Q?VR0xwrGgvJmdF+0UcmYlaeRLxuOeixZUKJshb9VgxPwbqT5TPLdwxsA1+TSo?=
 =?us-ascii?Q?Vll8VagHbAXFDfcZ/w+zBw6ocazigy1EC6ho8Raun2/q2s/bq+G0eKF5Zzai?=
 =?us-ascii?Q?DBXl6TYrZ18XzrJZCgCxpPFbXjCWFSU/h8uyNukKe+pFjFv2WCODGgRuEqZy?=
 =?us-ascii?Q?KIGbHo+nzsRzGUc8SLztlfElwN4lFWJL96aLZY3Z+8oIG30jI+zYYksLMHWl?=
 =?us-ascii?Q?8F3+D0JpN3Uq3Obz44cfu0FdFCCLEOT36Xrobf8glWY6+K+94eK1AHjYq46F?=
 =?us-ascii?Q?dc9Q3m9PnSe96qUe9Gzeuguguld88TJHPcc/NiHszv50BDuwzYHv+muxGO8C?=
 =?us-ascii?Q?NipR3XdykNGKfwex2v90WgTDKERMYdfNNlVPz2HtqPGqFpAdH4zIAfpbMYwg?=
 =?us-ascii?Q?UAh8XHC8BYVyxc5Pt/h41AAG5e1MifuFsAyGKApwSI1d9KorKJNE1bYM6B9D?=
 =?us-ascii?Q?OQ446JMx3IxBy0ZiUtfmk5EQSO40FcfUA/cTo7Dq4eco3VzhbgEZAI9AdCnz?=
 =?us-ascii?Q?jAhwNu8tYJZN3AbWfRW86tWqaZH/KHIf11sg5IkvuP4ne6xsrvHzpwHxigJS?=
 =?us-ascii?Q?2091l4rJs/bQoYWM2W2iNB3C93JdrxsguWE35oLaOfLxZy7PevoqOOIfyh3G?=
 =?us-ascii?Q?eyEuLY3mIT3o4/ppEJEBVoPYwRQcp5nguVYeChhEkOL3zxICdP2r4PyK85+u?=
 =?us-ascii?Q?opYq1umBvZhGd768/1cBVs6UFZHqiTDb88idGCAnGccmaCvtFkeHK2psAe/d?=
 =?us-ascii?Q?nA5mv9W3Jx//xQykHsF7FJz+ReVWgocqcWoPgsP5OHf3o9H0Eqt4qhWPLBzx?=
 =?us-ascii?Q?6NkDW2zTSpjOq8H6R+7iMWgZ+DEHVicEysEIh4++nVsWpRLHJXMkgbsQbc0V?=
 =?us-ascii?Q?ymxqYa4dYh5WPr0Mwl2fWe5S3xfw9wusbjryzONj/6YG7EryIwjbcLgSmAfR?=
 =?us-ascii?Q?nSvG7RNZFQpHeSDG6KmDaD9FQsG4lnrxxwvmhJ0i2U0YvTI2MLQEUeHim5R/?=
 =?us-ascii?Q?eAD+pvYUUVBzVHyhQZO6Pg/qFjQTsxKWoQz5wx60JgQV0MrY9NJVpq5q/IhZ?=
 =?us-ascii?Q?/Py4ICHrjCUaVyYE08s/6yM6wbMjVEudYGz/WTvNpMNm4FRtBaM2pIXytuEh?=
 =?us-ascii?Q?v5bJr/h2hwiCKcrYf17Z1rSdik7of8N9+KbUPxReAVMnwpJP8dFQHfGfZyy/?=
 =?us-ascii?Q?bZB1DcNFOsqzQX1WuxjvoP5IjOx9jHMD4RUFFKzqvwA0TynZIpQ6wDEgoHam?=
 =?us-ascii?Q?Cz89tPVWY1Tcj46tK4jzHaOfWVXSl41Ny4sfWXsE2DyDBv0dci+m/eyDhDPb?=
 =?us-ascii?Q?VCEi3k9zjS0y1CIjcQDif3qmGnXEHLvWDNx6inJuJtTmbCp0aEOqmCxksU88?=
 =?us-ascii?Q?A71YfuijtMm+MzKBQUMKiOTODTBjMlC1Zpn9sk40?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17564f1f-c529-4b49-c582-08dd8d7abc36
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:20:44.2471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AdksOOcz0UCZI+QE9bjBGkDNeNFzCTUx5bqhHWb6l+G/jK1Cvlq5rGmlBfoAefPp6OKnLsoiS4QGFzJaJt4QdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8220
X-Authority-Analysis: v=2.4 cv=WtErMcfv c=1 sm=1 tr=0 ts=681b7a52 cx=c_pps
 a=P5WujBTXSBe8sApKbu0jwg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=CTig3WpMzfVrydTXZnwA:9
X-Proofpoint-GUID: DFK8vIcjL0TRZLI20DUbocpELhi3o_SG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE0NCBTYWx0ZWRfX8velO0KXZt/A
 6cNMOL/Ch/UVm0sJ6d5papPx5tbpdD0zQOOKJsT49+P2a2cT1PzWVlqhT8knvdpMvHzg7QXRVmQ
 T71gDxDNnAJs5UVUWjSZVZTsnYzvevcZ3wUfbBDSLwkxPylH4kY2eyrVhqGwwHvQUZp6dNm4UQP
 Pie1985yQT/Ll6+U5+FjmpHAio2UeqNFwVNG/rWIXu+eLgd8rc07sv16Tgqz0c8T+Q0j9vxBGMn
 +DUHdBijx1asjMLpcY9Rc5WR7zjQnqMGfry/6nWrUIr5/QzfG3wedQhXC0rRgjMwDoQWO1aMdGo
 4XzP42M+SUYSXS1jYaHQ0XsjOlV7XhOTsymbyYj7PhfDplXYIGub76zqL6J6vu1HwVp5M3cWFg0
 7eqXsOkGIZUhbql1/NS5QhXJuLOjx3keWKCs4fBhimofvm5OQOyAEC8Y6cU+sId2SjCFdUnK
X-Proofpoint-ORIG-GUID: DFK8vIcjL0TRZLI20DUbocpELhi3o_SG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_05,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

Add simple helpers to correctly report failures from read/write routines
using the return -errno style.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 include/hw/vfio/vfio-device.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index a7eaaa31e7..4a32202943 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -115,6 +115,20 @@ struct VFIODeviceOps {
     int (*vfio_load_config)(VFIODevice *vdev, QEMUFile *f);
 };
 
+/*
+ * Given a return value of either a short number of bytes read or -errno,
+ * construct a meaningful error message.
+ */
+#define strreaderror(ret) \
+    (ret < 0 ? strerror(-ret) : "short read")
+
+/*
+ * Given a return value of either a short number of bytes written or -errno,
+ * construct a meaningful error message.
+ */
+#define strwriteerror(ret) \
+    (ret < 0 ? strerror(-ret) : "short write")
+
 void vfio_device_irq_disable(VFIODevice *vbasedev, int index);
 void vfio_device_irq_unmask(VFIODevice *vbasedev, int index);
 void vfio_device_irq_mask(VFIODevice *vbasedev, int index);
-- 
2.43.0


