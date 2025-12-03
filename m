Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07CDD12698
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 10:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQjht-0004X3-Ka; Wed, 03 Dec 2025 05:03:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vQjhs-0004Ux-Dc
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 05:03:32 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vQjhp-00032b-IA
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 05:03:32 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B37vawe1650674; Wed, 3 Dec 2025 02:03:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=MxBb4zecwGQxLDLzd1/odZYSxAW3vCgOOK/Ticakl
 Sc=; b=OWLEq+gscWHUX8Ly4soWiIgzEliXnRdJAmLcXBLnfOLXh9looQ0F5HMQz
 O5v+3pCq2FQLZiKXoXeDv82sToYsAR7FMApK5AKK1uTw+wGP2YhbwPHUhKnz1cUq
 0QB2bqGlraiXEvItcg5b1aqy7CjUl1XrEtz12lLQUiHPINuZWQG+NkjyJTcX6tsq
 ebaSFYdhf1ad6NZ97ysjRaHSVwhAfStHPfLlh8V+MfZG4bXcD2A2TptIFVpJWuLB
 S+T/V1nqWzX8zT4ivLwnCqwldz7Q9KfbG9PvqTqBjPtZzrGBdBvO2HFClrjVSsAm
 ocwNk65VzmbSH0FF508yJGwjGUvDA==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020079.outbound.protection.outlook.com [52.101.85.79])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4asrrxujae-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 03 Dec 2025 02:03:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Up1xXe7Hylvpr+qijtlxNot1NahzQ6cxJ9gI9dBQ6kYfqJf6Az9n7QL90CykDn+yh29UhV7I6a6OLFDdISYYl2J9/Xeeu3Wr9nNtjwHqHfHJ7oNP1sX3FV8KnTjTqYnGi865LIt6bsvyP29PSZtVcj/6hwjRMU+KPVujwVvVFCRZKtMG7WiotT3ze3hu3lvIaIlgyzxFCMH2VyOCOARFyXCNb4AGZxId1C1juKbfCEoEZe9YSoFpdJkRGgUrN07CEPco+djI8Y/4SMm89Hr4KCMpzP29YfRC5JXlk3LJLJOpHxqWCLApOtdxQler+Rcgp5LtAk9oYWqENT9p1/M/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxBb4zecwGQxLDLzd1/odZYSxAW3vCgOOK/TicaklSc=;
 b=aC26Mij/1e+fkvrEEvI4Nll2G3BwZpPbFdtZbpFreCGNzfdhq6Pvztbtja8Bfw2yczZ74Tn3XB+RJYUjCrSISscF9nWNwo7yx2UlhMz1lLTmKdi759ra7sOJA7Xn4hXvlk+CUguDfK/JnCnThF38tnmoc88dMYxhIh6zxOJRPbaoRKlw5TPGevEkCpBXwYiBko7w/8wE7xwgehhy7GjW+neIbB0kxH9zl6fyH5+73BWMHkDvWCZlAtoI2anqDXTBVNhxgJ6MrROHOo78OGmaeCWCxZrvbpIjaJJGbepwdMsmZAsD32myhKtgaFmfFQXjKZbmJ/cOdAO42ZQlwFDBsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxBb4zecwGQxLDLzd1/odZYSxAW3vCgOOK/TicaklSc=;
 b=u2nrJeleSBLE/LYUc6h4gB7gM13zhnpM+fHeo5Bsco9G4/gJ1PetwrkM+CYvoBr09SPptIcqa+qfNK1S1lhvOZmYYr9p9Jwfdw2aYEcEd2jfSsdB8+nidNi0w6nd65+JNSkTzYIIu2Vft4QQiy75HTWmTOU8V2wtx82thstiC55j+88F+KGP6adXfk5Z7I8p24l2bQ/2X3D83k8tJaetZZiczJ5e8H/LxY1v7Xr8NXIsckv/L8RaH/ZZUD6GrLQ2oRKlDc9L29l7mJ/5XVpi/H55N07qk2aknzjuslVF20g9P/OAjq9OvxkUJSYGAdISLKmwuDT/L7JlaKaa6X2U2w==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DS0PR02MB8927.namprd02.prod.outlook.com (2603:10b6:8:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 10:03:25 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 10:03:25 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 5/5] vfio-user: recycle msg on failure
Date: Wed,  3 Dec 2025 15:33:15 +0530
Message-ID: <20251203100316.3604456-6-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251203100316.3604456-1-john.levon@nutanix.com>
References: <20251203100316.3604456-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0456.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::11) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DS0PR02MB8927:EE_
X-MS-Office365-Filtering-Correlation-Id: ff0e6620-1729-4170-01cb-08de325332df
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xo9edFNf4BkQMBhBeb4h/z/e8ib9bdC51D+toGOGfuFOq71ubm7ofDt37g6u?=
 =?us-ascii?Q?A0Rb/3e7KWPVTp/lQTf1xNEdc4oMIofpFsFUdQVAK/zacEVR3EHtEbMypot9?=
 =?us-ascii?Q?u04ExyPoj2PrSEIzKM7JjBbGpA0+rpOHFGiJEBUdqkpUYIM4S8w/8fzpTpIW?=
 =?us-ascii?Q?C5+zWSKi14dwj4SYeTww7rgM8J5gs+335BczUwOu5gNT6kHPkHvqW9EdyDu0?=
 =?us-ascii?Q?3buXEhggYsOFtRLqMqsAAyVRBtmxZCjKUPg3xI3UYb13gyGqhfi6Mw9FZU0Z?=
 =?us-ascii?Q?ix/fnPYGRk+BHKGcUP3UlH3xxu7IdSBwoXS8bgX0oL7tMRVz9H5jGhg0weT2?=
 =?us-ascii?Q?c3f2zfyHOOH8p8nnVDaWwSTqtCANNTzs4fZGIlNtRS/JQ+9tLsnQwDAAMdhu?=
 =?us-ascii?Q?26yyzB39KLhPt6LmzhPC5ZbVAR4lz2+MtUMckb6IXnD7T5tmw1K/S4eqr2ku?=
 =?us-ascii?Q?Uij64TudxtGU2ExlfHyP7j9n+AuyD4hVZfD3PKM/+vtDRGZRcgC996vxOdPy?=
 =?us-ascii?Q?WJxDMt8H6mAmwGAXkKlFSTPdq8g1M2oFXdpr0a0nX9o6acG3rSraf0xzHNjU?=
 =?us-ascii?Q?M3NE69V2ZLPDVzAejLQ/icbIPlLfeOyQrsm7LgfQ3bP70DzbB5V3ELfH/H1L?=
 =?us-ascii?Q?PIXcx/PauTO7G2HAQk0afUMHS4n/9NmLmu900QqGR74wE5bC7BlaHLkb3K4W?=
 =?us-ascii?Q?Hwm1S4naUa/WfTpyTnZBQvKlYQBG9rJeo6xFfqkryR5826d4lc4FKi0WsLdG?=
 =?us-ascii?Q?VK9xwQipwN7TBUG6VVduZ2DqWYL+XDs9iaxV23RnC77psCQzngnBBj5qDe3Z?=
 =?us-ascii?Q?nadAN+fC/U44BfT6wixNhdy+HBrx3S+xnnF3nR8Dc4RN7P1z9qd9ge764pVn?=
 =?us-ascii?Q?6uDmqNwRPPiJcHgwwtew9FXRTSysyD7o7LCFiH1zBgo1LdyPK8dQh0WVO71L?=
 =?us-ascii?Q?f/TVqh3vg8z4/6YdWinUV7paNIfyILT/NAW+6VvaDm2i1+//Rfr0K1pr4UUk?=
 =?us-ascii?Q?8vgUnB2qyiqfIpezxM7H4B2pcMQVTDVb+KSpnvkvzBRaF7DjK/POzubwD2aM?=
 =?us-ascii?Q?sY1bGN1/yawWE+L9l6oxh82uAR+xqpCjsX6l2HYsZRgqMLR2oYGOmDZ000eN?=
 =?us-ascii?Q?CxSuVPU1Gnz9+BBN0Ld3XsdT39aPB394oKx3klFpof22qoE+BnNWO3OGygvs?=
 =?us-ascii?Q?ZUQZKiA/FKIJFPLZd9dFlaPIC6ALgJIbfGNIVvBCCLEqO3BZEexKHGUsDXBg?=
 =?us-ascii?Q?QFmbuz2NYbnuTHBb4AD4PhI/MzqwGyWRX5lFADONGl698e0RslxgU97YRzmp?=
 =?us-ascii?Q?7XuQ/iAi2YaOsmx2eYXavuYR3ZXBigmvN9GWY9U3zm2FuStmP0gdvyApQL7O?=
 =?us-ascii?Q?NmAkOQfTzqy+YIZOKE/Q02ouGmSfhzYgK7GXEb8mzqjHkylQuM/kC4V/Gymc?=
 =?us-ascii?Q?J/MjLLERUEj5J4z55N2fyfoC6Bk7NjPa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0TnEZqh9Po9mgbiA5Hg+TMCC6j6SfLw9n/9g8ceOOh1c0C6j8EyN40QWFtwI?=
 =?us-ascii?Q?7sksW72IeAMP7ApuwJdBnoeN0YhDiwgwyqLKiO5CBNpS/2QCb4i+KlcEVUKx?=
 =?us-ascii?Q?MHGTUrDU8UrMQw93vDp7Pv/kjH2sTl+i14pieUZc6t6annU+zl+SwRbb1UEy?=
 =?us-ascii?Q?Zz5vWC4wUaeMfjtcBAb/4eBUaNY23Qe8OG9SdK59SyYiFF8/VgIUIc0DPmjk?=
 =?us-ascii?Q?2Ybe9RVdR61Ijk5gLhJ7E6VUYhLYzgbA0iznrK5q9580XQOtrlsMXUf2EQtt?=
 =?us-ascii?Q?1ED/P4m6hlamCxvWxcRMT2WJLxeLZUYVQzFbauYCGa1W+q4u4dlWRJZFUUK2?=
 =?us-ascii?Q?20jq/cvNz0KOXHuxsSUmdPS4RVfli8DyVWfkTTCp/rRwOxf3RQ/Zqirygy+b?=
 =?us-ascii?Q?dKcVCE+NeX+bIwp5P5cFO5I7kmMXWnHsbMBIoPIPX+4crqdAbY3bWvOLJepA?=
 =?us-ascii?Q?FfFCgdBfhDKDoMHhe3Er1AjGnrBevtlGBopXl9/623d1RT5nLbnIGn8abB2A?=
 =?us-ascii?Q?oiKZfJ9roY1bYX+qpGUEGixO7XVZcvthzamfYm+7ejFjcNE+PE+ryl9FtOXI?=
 =?us-ascii?Q?vDcdLhdeFdshujPdx9kjG0P/riP/ZRgIDXGf52iDvBeGZBKbSkd22pf2PmKE?=
 =?us-ascii?Q?KagmjkRGa1eJshp8V0PNvLXYjN3lpQw8j+OCpZ+vg5dWSwoLZLQJXHp3uNZ1?=
 =?us-ascii?Q?bEnY4bv9VXFF5sOX/iJSOJuxwFFUSrbLbkERQcZjx48XhnCZPTsQNjpElgQ3?=
 =?us-ascii?Q?yjQAG9cI6BPw766qWVU1sZshkEigewcLuzgZZOagRZlVDDj0QMQh1Ae0wG8b?=
 =?us-ascii?Q?OTDUD9kqTsB3Ija1ySaFqKCxcRcq1M/V/D0nLKpXcdopYqbfTXcORGAbHrIW?=
 =?us-ascii?Q?5zWy3kzdTgURiqQjhs3y4ZjgcNFsbsYgDAnjwOJAMCh8Y6BxbIMm4lst3i0i?=
 =?us-ascii?Q?c7um6zb41rxkmbdBeTb1F3vM9nH95/pAaasTtsJr64vzUEIO0pblShdVsJe1?=
 =?us-ascii?Q?scfkDO3q65WtpQJZeNUgztr/kkhOP1PG3fh4mALHJrXnq0jrXciTJ3vooz+m?=
 =?us-ascii?Q?7ld9Lx0vtzIt9ak9IfMsLmBT5Ie1bJgCBqKHDJLYLQGBdU/8vX+Hry9PdgJu?=
 =?us-ascii?Q?FaENcfvB1LqwDnq+WOpbAhsJrN6CBjjBJyOX1IliYxuGG2UOJddfsEdU6yHL?=
 =?us-ascii?Q?n+OW8eCIDto9frXt39PB7VG+Ww+TpMhw7VZmZ5/wWZWdNa5ScMreN2OhhXY6?=
 =?us-ascii?Q?iwacFXVnqhdIV4/Zpp34WUq+a13TpMSgITOhjUBOgs+l8pmLvs7KsDfSplto?=
 =?us-ascii?Q?QTmkQYkqvQz97JwtsBIYdHRc2zwyLTS5ouBuOZcjNzm3KIRDf+KvSNAS77Wb?=
 =?us-ascii?Q?uNxMBLicjJvOQiuC1rs6OI7p4qtWnk34lE8zsj8m8CvHSK4MdirumaIJYfW8?=
 =?us-ascii?Q?I2nRgK9DO2mvEjjoQOx8l8k5dhYQRfyjpGrU/AZFCuv9IUBkfNp0bk9zBPxJ?=
 =?us-ascii?Q?vqTnyH2+JKLXmjwNIlx+akoVLfejYBY0hgxG9828lNWiAIU5fAdYhdu+PVsz?=
 =?us-ascii?Q?xo26CTMQzvIYgMpszDQ0v9McRvmeSYvHIgN/IZ4g?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0e6620-1729-4170-01cb-08de325332df
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 10:03:25.2641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxJcUiOEZ0Enb6nXHXA377Nk1foTbZFz7sKukZK52fP1YynxAVfWgvP1UBZfbmErAHDai2hTZlTIWxyGQZCm1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB8927
X-Proofpoint-ORIG-GUID: oNhzXSxGMLcj89yz14BY4F_KPo_O4CrH
X-Authority-Analysis: v=2.4 cv=HboZjyE8 c=1 sm=1 tr=0 ts=69300aef cx=c_pps
 a=pMGFFt+mz1AFwwggCsQ+3g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=J75VCkS05BzDYCChcPEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDA3OSBTYWx0ZWRfX+MFU/KOxRRZz
 yowy2UT+fLutM1yy2dp4Y/O7cfPIZSe27KQvRnLBNdMqQYXqx8QqP2wXyfOX92OzzLLOBsbtJLw
 U3ayMjua3mdJqxBTv6yYDr66LkLTeEdbxUCWVzBGuWY+QWE+GbIX4/M/gjJ+p6bGygjVB7oZ8lo
 K0n4s3D5+jpZBjY915ckU+fvlZwYQwv4Im4A2r2Oed02gHEHQrwTWz02zcUrZROr9Ccq9Cc3t+u
 ov0ZUQZ2KI+7aaEtzDc2Hyh8iWzdOPstqsk5aGFHfudz9BNBdcYUfF5cdO+WLgpknpPiYq1qP24
 5Oig82arnIGFZLMrzsZ+fjKZFwF9cq7Y3D2MM6qkconIHm+xqcpMz0CEBMbLUGLewQr5UZn2XPK
 BAOgRY5915fqyKQmL4Ve7VGQwkLvKQ==
X-Proofpoint-GUID: oNhzXSxGMLcj89yz14BY4F_KPo_O4CrH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-02_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

If we fail to read an incoming request, recycle the message.

Resolves: Coverity CID 1611807
Resolves: Coverity CID 1611808
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/proxy.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index f2601eada5..314dfd23d8 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -412,11 +412,22 @@ err:
     for (i = 0; i < numfds; i++) {
         close(fdp[i]);
     }
-    if (isreply && msg != NULL) {
-        /* force an error to keep sending thread from hanging */
-        vfio_user_set_error(msg->hdr, EINVAL);
-        msg->complete = true;
-        qemu_cond_signal(&msg->cv);
+    if (msg != NULL) {
+        if (msg->type == VFIO_MSG_REQ) {
+            /*
+             * Clean up the request message on failure. Change type back to
+             * NOWAIT to free.
+             */
+            msg->type = VFIO_MSG_NOWAIT;
+            vfio_user_recycle(proxy, msg);
+        } else {
+            /*
+             * Report an error back to the sender. Sender will recycle msg.
+             */
+            vfio_user_set_error(msg->hdr, EINVAL);
+            msg->complete = true;
+            qemu_cond_signal(&msg->cv);
+        }
     }
     return -1;
 }
-- 
2.43.0


