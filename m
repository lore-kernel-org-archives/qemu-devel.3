Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BAFACCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 09:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Ekr-0002cf-F8; Mon, 13 Oct 2025 05:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1v8Ekp-0002ZA-99
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 05:22:08 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1v8Eke-0004Ro-Ua
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 05:22:06 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59D87UL53515550; Mon, 13 Oct 2025 02:21:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=xXI2a/dD/sesjm2ZdceVR0cWik4pHx5E5+bT3vjBr
 Gc=; b=IWxJGQ03yNXxZfdlOAL6nN7fUMB7I2SgnPBmZViQnyyggPdW8hqUcv7X2
 b8eMUDikUeKs47pYJke6sAnVtgA4UMOHsAYBFTbPjqs/7TwvQRUKMl8+aIcnxw/z
 yiTF8kYM6MKVL9FNeVGHr4HtITTZy6BGCxaEK/U43SE2Xanm1JiveQPtqSMpEwnO
 YWaDQRBBHiNhIfMdXgJZUKjwkGSqQjNTGd6m0oZCBbnxgqMXSWbNdaBoBh8aiB9W
 aC1Qyh2hOBWkPTqyc+A1+BgPCE/lksiC+ocwWaAWCSDrJ/N0KmY/5ySpW8lgu582
 kcxhqnyppSSVA/my9KxuQCJgu0qbw==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022095.outbound.protection.outlook.com [52.101.43.95])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49qpj9asjr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 02:21:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRZyosukG6Izh3dbiXshlrsEGRq+4BeEZ2/YEAHFz27Y7boN3buYA1pz2ln+3tokoHqI14hpsd0PvLIgAD92rZHi6Gm2eTp1CZ+8Hg1nB/I+skl1h1rf0wRvywHNrUC63DvlqZjNtRxNfdCUzeJ8f9teNgSNYhaRZTzx11+MrjXz/Lj8nIH+tDpRthAeqQOZGBr9eAZtGsptPMV0uBqlajqfxME1WjCoakBamL9OhDeUIaIGgZxYSq+FxsXK6fNnXh4LDTgGmU8gUnFIAFFkSwMcNLpmDJzK4jxhAbynEoiGe1Y8GeHCvEedtwtaCTpd0dj/z9jJ+bawMJkz+BmFgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXI2a/dD/sesjm2ZdceVR0cWik4pHx5E5+bT3vjBrGc=;
 b=ybM6DHIZtV/vF93Z+6j3jLSH3rymcwkD5+OpAv+j4n5xtROrxAewJuzpWFWig+l77EkjJa2AuCEBKwOcC6r0epJVfODMgc7jbEp9GzYy1FNY0M7ooEFj0RmJ57luXzAACGHmmzuT+YzZn8QRNz7jFAmcpDZ9onGVATAYxNF6NXscj7DQprEpNWdZI1+eaEldO5LfugNgG8qTq91pkHRwHeqc/QteRIC8bdlaRzWfTr50SFZ4pAQjD4mr4EoqOIZNqE/LKy67x43HcBzt0GBpJD3o5rZavvTX3XH7b5zSKu+Kc9EEFEt6gEzFrMYfa3wQwbt0nrCwWaquJFzBomRm/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXI2a/dD/sesjm2ZdceVR0cWik4pHx5E5+bT3vjBrGc=;
 b=AJfBFzvUAUPBZf3QdUdahH5Qsa0yr9lErSL8ShRx8yHVEY7o1n8GK6jr8qtnQxRuAZiExn4p8MpXwBPeXY0Qp+0oRk/pqDXxdYh5LDwx8l/mNpjWF+TqEj1a3VpDXoJ273dR8RmaqxcrbjOuwRoLIpiSg2FLJbgZExqjYH3lCgpnS+XURHRJn/BWlYdI6TBB8YUopaYEY9P7eVzbDtikGzlf9fOCj6j3UL65S7PQlvyOD9Y6D7iRMgDv8M6MnMDRb1EmFbnfMO9Fo5v/GoWRyqk9fjC+E85P9rA8OksDLwP/ZSWtBjQSImhAXGmKNyTDWaiy9ncBilhPrelsJds+iQ==
Received: from MW6PR02MB9817.namprd02.prod.outlook.com (2603:10b6:303:23b::15)
 by PH7PR02MB8955.namprd02.prod.outlook.com (2603:10b6:510:1f9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 09:21:52 +0000
Received: from MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c]) by MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 09:21:52 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Tejus GK <tejus.gk@nutanix.com>
Subject: [PATCH v6 1/2] QIOChannelSocket: add a "blocking" field to
 QIOChannelSocket
Date: Mon, 13 Oct 2025 09:21:21 +0000
Message-ID: <20251013092126.3480671-2-tejus.gk@nutanix.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251013092126.3480671-1-tejus.gk@nutanix.com>
References: <20251013092126.3480671-1-tejus.gk@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::19) To MW6PR02MB9817.namprd02.prod.outlook.com
 (2603:10b6:303:23b::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR02MB9817:EE_|PH7PR02MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 3966c578-b90b-4496-cbe1-08de0a39f1f8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PqwCPaVFndTaMWlYgkSj8/RMIYA+wp4fDhrPVa6H6XzebSOIPVkC48SjUTpS?=
 =?us-ascii?Q?UbTRnH7DVVEdCPb2Jmi3XDeDXA4IQ9wr8xFT9zLRP8U0TYbGiLwou7mZqL5T?=
 =?us-ascii?Q?QeAf5CTzk47avBmYZgev6zb56oI92eHmaPSFOmjXI/LzT17g4GnIkLcpstNd?=
 =?us-ascii?Q?1TLh6JKZabHYHLJEJfqiJm0hDMdjBA1XUz3rjN1ERwiwqhp7x/fACuxEIUtk?=
 =?us-ascii?Q?hvxgQ6KLM59wfR+Lc77ZaHkFT8GzHnMawXV9T20og+Mjqu+pviORivVM9cy1?=
 =?us-ascii?Q?JkpIaOUkihVAPT4oVFRlnAkYxbJXmKohh9TTreoyypfi5PGhwrmM2HvWcc5x?=
 =?us-ascii?Q?ojI0PxyN42203c5BGd4XGdKqSImCJ45Edwv2NsTITOWPdt075xthG0d3wnXF?=
 =?us-ascii?Q?fL5kbbDMPd2VEEODvJMUdtf2/4nNmw9YWzI/HoUGUQEXRfsnUEIo80rvBAkT?=
 =?us-ascii?Q?Zv3WnpvZJqmzzH2i6eYbcI9R6aQ+CN8vm/MYnsnhxHlt2+ixkSxpyoW+JsFX?=
 =?us-ascii?Q?hWkjMOMtnK4YwakBoGNjBPDixr2OPfQ8TmDeq53p5dAhGQg+ene5Uu6Ix3Yb?=
 =?us-ascii?Q?MAJYH3Ior+TyXr6M+DCJW6bo/XpNdPdmeyn4fZ5iQaVzqLlWWo862qqwzPEc?=
 =?us-ascii?Q?JLH6YlvUxEfjHxXQmC3JfSHsI4NLRYO+tu/p1gHBz+yWci1PyMJoFX2/fDJg?=
 =?us-ascii?Q?c65LSySUbVUdmbuubUEXxuAG2J2YBqhzN8XUkxZ/Fd5/TLj1MPQJVNRXLub4?=
 =?us-ascii?Q?i5mQlc3eun29Ejz37qGumgy1iGgwECDB8qt/aRZ/pnw1KYdZXWoaChyURzMo?=
 =?us-ascii?Q?lGTaWNlhbJa5x1gzA6EmtE+BdHsBx5gYj60rCf7hnNgZ1hT7hxsl8VYPWZg2?=
 =?us-ascii?Q?35Xoknknn84Z6uDgD8ZgyvjXAZ/29xj/t4X6J0pJ1UcmxZXnBxs3fMQ5gakK?=
 =?us-ascii?Q?BnyPWoBDyCzzbstLSKnjID+w0usw/axgauIQ7hOPwYQ1LqYErz75of+dBirZ?=
 =?us-ascii?Q?6ZuDwD0Q4/RtZy6xpMMUfg74pqMyfy2uV8mwlmCabXlyiJSr4Zvul8pgQ1Fd?=
 =?us-ascii?Q?A4IB8lr9Gwpf+eptbeBArkZGe1IeoSN17gR6eg3H995J+VoCEYa65W16OEgl?=
 =?us-ascii?Q?GuCGenejELDAb6OGgo/5hzkwQCOX3pOBNQx4lcpMpvkCofoLngJRKOPK7iN2?=
 =?us-ascii?Q?s9j4ChUY1ECwg5Xx/M58e9lBtZ1Yd/wLixN0bfvfdaRHU5kmY0uqVRgfM/TN?=
 =?us-ascii?Q?is6e9SMLGHvSpbvI8gYt7q/QiWjl5L6CoQQsqEZZDsoOAR4sXHyB3OdvA6Rb?=
 =?us-ascii?Q?ZzRCHY/c7PaGZ1PoS3FYudjwlT+zqntdT7Rv8a8Y9RDIH9QJGjPNuVDwjzPh?=
 =?us-ascii?Q?nLn4tD93rC2CsuYk+nbWK4GoZlFD69l3TCx6gL1asseY3l1OzJgfsS2IIxRx?=
 =?us-ascii?Q?Ck4gNYv5CE6iO8/3GNCQqk5COzAzbBx6z6YcBwCX2JZ5sqjOwmjlDv2Fbwc3?=
 =?us-ascii?Q?SuucUFHzdPzqazjE8LJHl2OGD0hrqDEj38p8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR02MB9817.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VSzlaE+2Msm3OdE1awPNglx9XB8EZDQ+XJdnO7DvRij4Y75J6lVnLc2zTnW9?=
 =?us-ascii?Q?LWAKJmqw1YP0tkyCOT5L3K54U9QvyT2Z+VCFNeMLCWjmhPe7E2i/8UGuxLYA?=
 =?us-ascii?Q?h7IPNm8RXaIzeP5FZdCVLn9rv+pu005FEMKvi7+hYCIStAkxgxxiq0PR79u2?=
 =?us-ascii?Q?4auYxpuxrT5wcKNV3jdUvGIPZlJnWD5Hb+4W3H1kxO6Cg/Cn5QbayC9f+XH0?=
 =?us-ascii?Q?Rr/GgeMRDB6ffuBR2ny5yAKsLz6g6Yw8xonPqYAYY+bn0qYwDNf5+oL9Cuu9?=
 =?us-ascii?Q?Z3eKurNvssYU6gwECfBkNwvJp1rqtGmlcI4dTsHaHFYcETIJrDF5pYV3tDWX?=
 =?us-ascii?Q?8qbvDLajh6iBdlk+m8hB+cR9HfA78UK6Ng23i3Cd34ZNKRUPesflA78DmkrP?=
 =?us-ascii?Q?6be17keMUd1L1nGAYTJC3+2Zou2/OoyBPJwM4fe1qB8gSLLTJ8Xplxr8Ielj?=
 =?us-ascii?Q?aeQ6cZOMtj3VFxHNnepc2gMLPAvR0f0I8IIx/GY3PafRNsV2legdgInNyMhE?=
 =?us-ascii?Q?sp9H5jd5vBKCEx/FMN12urkYd4L3r0lvnsmqhxfXbBRa4T0bULQL7sGG87sS?=
 =?us-ascii?Q?9iq1JPUMRYa3Yg2H4ydKPCe9WSJlOFQhhCgI+A7x8Bmwm6ZOwdy/y8SQsx0J?=
 =?us-ascii?Q?fJYVnzoMhTFp5XsDyi6G0U1eFZEW7zIAQksaxgbCT9Q3ZitApCVHrARN8pzH?=
 =?us-ascii?Q?YlZqo88iTTliYhy51mWVg328mtJ65leXFe7fXpXOQf4A6FBmKm6TRUKPtoDI?=
 =?us-ascii?Q?F/3bQuhqImzreDCDC5loOZ8JkyVp7ntEyK1dDks13TXEV2CVGXZkYOw6YMyw?=
 =?us-ascii?Q?vWPlvJOllSGBIRLol2/Cgp45u2lUaDTMmI1T1TU2UAVKxvvReQwHDBJ8QhY9?=
 =?us-ascii?Q?Bhy04AuONYNlhzIYQg5IFPZA58qUYDgsP/6OwF2AGoYtwJ/2kCR2D7LPNKjm?=
 =?us-ascii?Q?YC31wNsbilDSVSbg0byG05DpsoXZJ9OCt86JrBtfKvk71L62XzsLXUWofHb9?=
 =?us-ascii?Q?qQo7xcJe1O3PdMMbvm2GrqmZOt2qUmuBx+/QFXHFu9REPhW1eqcauyDPrDOy?=
 =?us-ascii?Q?kxJR9QXdbh827Yp5aVEILIGq9XfPNRRKQVFJhS2GQOamNmh0p10ai7AkFP4c?=
 =?us-ascii?Q?bzN/ALig3y6D4qDHhlPXKfp56yJLkSSdby5mP4BWm5Sj1aCElqPgFmrgQfMm?=
 =?us-ascii?Q?E/PZOBM4Ie6BWy2g3BO+WWJoFtiUH8tI72QJDE8yMHSlc34XpcRvjwz77Wf1?=
 =?us-ascii?Q?xpg21nj4pVP/K6kLCHUiodvPGhD9boSTvYR/OePmMbI8wlMzPAyMZGnYhcXr?=
 =?us-ascii?Q?WUp89w31kyptSfx3HFCKsZiDhVImjY3kb7e4ux05ZwXH7ozeiJa8UARLNHzJ?=
 =?us-ascii?Q?BVDSrh4w29q8wRxOVzp+ne+hRTarrTg+Cmwcfog5mpCdHG1oPhD8hHmEn6y6?=
 =?us-ascii?Q?s/uJ4LykeqvdIv0QgN/HUTt24/JNfpl7zpb/hIUON/gYm4onBFHhM66hoj5a?=
 =?us-ascii?Q?zDvQnU3kCcguifLCuLB4HlPIn5dDckaAShh9WVMWGZqWNyXn/HoeHFgZlNc1?=
 =?us-ascii?Q?E4vR30ndWJNikm85w4tf7PSEE6rd+VyWXrphiss/?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3966c578-b90b-4496-cbe1-08de0a39f1f8
X-MS-Exchange-CrossTenant-AuthSource: MW6PR02MB9817.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 09:21:52.3850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFCCXaWKDyYn/ogd726LqtmQf9cfeFf6yGAqHHGbMW/2Tpi8qW+femh9f/RBJWjh9xffEp8+E6I7JSfeJYEyFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB8955
X-Authority-Analysis: v=2.4 cv=aPb9aL9m c=1 sm=1 tr=0 ts=68ecc4b2 cx=c_pps
 a=kkxl9DAbGs3C2F6ePkv26A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=pg60GzFlFQrSi9hmcNYA:9
X-Proofpoint-ORIG-GUID: YKmQrNjotUxl-DhbAjEbSNGZF-on4iRk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA0NSBTYWx0ZWRfX/ql41a+qKy9/
 Hz7O/d9DA5AW1529K0Er1rvKkTDdMG2f0dZDCHjxwOKpdiRvGaLy5CVgVjxsNe6Yin8kEGwt8JN
 6Q1W2Z/4axxfRyGlfKN+B6BeqN3kDWucDT5HmTyiQZxdeqAm2tYpBZYbzkVXdr+gvGGWXTBvT78
 PSrUTVyMC0KFsgrbi1y/Gw72lJuBUnWenOYWq7Lt2aYnzXCzN+9lo/TF0tAdZMn9hPMZHdb0bLf
 hk8jMARPekfhyAWkSVSkxxYpFU0BFjg3/rHpTPbWvC4VWJGwd4phQ//ySqKhUjxviaerNS2LeyT
 xQHTAzxJMM80dsvzY6dC0qErnHjGEsyx58DhJMAn7A+x9MiybDTkSrKu1u6nf0Oxef4Rmufdlhm
 1I0bJ3ge+3k8cRz8ZX5MUdUtwZWOGA==
X-Proofpoint-GUID: YKmQrNjotUxl-DhbAjEbSNGZF-on4iRk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=tejus.gk@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Add a 'blocking' boolean field to QIOChannelSocket to track whether the
underlying socket is in blocking or non-blocking mode.

Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
---
 include/io/channel-socket.h | 1 +
 io/channel-socket.c         | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index a88cf8b3a9..26319fa98b 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -49,6 +49,7 @@ struct QIOChannelSocket {
     socklen_t remoteAddrLen;
     ssize_t zero_copy_queued;
     ssize_t zero_copy_sent;
+    bool blocking;
 };
 
 
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 712b793eaf..8b30d5b7f7 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -65,6 +65,7 @@ qio_channel_socket_new(void)
     sioc->fd = -1;
     sioc->zero_copy_queued = 0;
     sioc->zero_copy_sent = 0;
+    sioc->blocking = false;
 
     ioc = QIO_CHANNEL(sioc);
     qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
@@ -859,6 +860,7 @@ qio_channel_socket_set_blocking(QIOChannel *ioc,
                                 Error **errp)
 {
     QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
+    sioc->blocking = enabled;
 
     if (!qemu_set_blocking(sioc->fd, enabled, errp)) {
         return -1;
-- 
2.43.7


