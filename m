Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC597C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 19:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUVpo-00085n-Jc; Wed, 25 Jun 2025 15:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpm-00084m-2y
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:31:02 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpj-00046C-Bp
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:31:01 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PH0WYC021654;
 Wed, 25 Jun 2025 12:30:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=jURN3uf0w13uVCJ0T2hHXiHI03MMBd71E1aociHKr
 PI=; b=B/k0GX3+xHvEdVV5yJFNfqS5X205egf0pNWSCJXcF2v3foRIm9BUJjded
 gFRRLpKnTvuXn0RMv6NlSSP/Or/h6vL1nNJL1dcoGyeltWUxgZHJ497WgUk1AV+R
 pOBPoDK0MFFVGlsK77KaZVuDhPc7zNX1iaDMjeP+TCNEFVXOmXXGlTtav5+rTx3R
 ttQK88PFI5AIDnhxt/aW+7ibb+Yfgoyuin1gH+kD2+oNkxinAwt58CQ6MEuzX85S
 rRxeAJgweSUt9NGaGWnoV3ddLyY2pOCvzVxg0S+YjxpnyePVmUAwqUsqz3hdtVIk
 2piqEVF60UilZPGJXhc1J1Ak7Ckyg==
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2118.outbound.protection.outlook.com [40.107.102.118])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47geghhf92-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 12:30:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLUAgiCHGC9yF0W0oFdPh7nnO93qv2IEI/zvMKi/CMPmKI9YB44oDHkBuJsKmIDhGgfkFC6d1YjGlFT+VgMQ9hbNaLPbR8oi1Dtj+01DdOS0G4MmhHVkN4PEpGaIoNIFJUks/sR9qoFjA8vsmwuPDKAk2e2gWSi8qIXrx6Ph6Dz8fLjNHANF5neXFhbcOa2xhGm4GIMcGMLs2JDilb4a2SFDGEJ2jO+wavm86RLxYp/g78B5kRvyY3XW5rYJ1+US56uDMIQU6byM7tdjASnbV1gxHGHFUF/JJASfq4ZDUKqHDZIgObgZBLuE+M2V+fxSlO6x/JGbIvRTOHmNo95zbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jURN3uf0w13uVCJ0T2hHXiHI03MMBd71E1aociHKrPI=;
 b=csOzU0LprTI+MBhu8fOC+W6BFm4+P1sj8ut+5Hy5bNVn4pyk2AW8zI0ZzOhjDe2QQlQL9vURvs7fR9BpG5DsoHXDebWFBAyVnA0b/1kNbLhcnuPSnzZB2qV87swemhbdeTdfFBzN+Wveu+JMfFKsFcEinp+N/1Tiene1v7JLPeG5AQnKp5BfadoUph6iKu50L6S684y+Ec7pibEDcLNRmVxeooxmn8Azn8fvIcCMCnt7lv53oCPhEeGi3jeLkd0cDENXsA3wNKqAAA/zMKyhHWuGBP9A/y3BY6kQ//mLafS7zT/+HuYMUc/M3nsL5PBHdRigBvrHl2wecRPLST328A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jURN3uf0w13uVCJ0T2hHXiHI03MMBd71E1aociHKrPI=;
 b=ShPB1jleKbCrVXyd21FkavqkvTjpxgmLZ/XOwWYe6KjfXZMiQLqdhbN98ycW30jE4nGSQpfwZeb1iihB6HrcTFe8q3ln8nGyQORjsdKpCf4nzRtTkxjcfyOP30pL5Aei2sYll/8tHHm7o3yGrmOocz8GWHWQOF7cog7LwLxOoyIpoQVkyNKn8xnLgHFpM9gglHi1ryuWS37bEfstqhsnE15Y1fWy3ycv7KyK9XeB0qjmaXG77yaKhxmsPEUT4q7ulcYO3nxmZfkpPpKuyYr8Zis1Z+LnZyG8WHfM5Yaij+hP2bUZBuBeAfqMobsrJmLXYxaYBpWZOlRU/ft/hrF/OQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8535.namprd02.prod.outlook.com (2603:10b6:510:dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 19:30:55 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 19:30:55 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v5 14/19] vfio-user: implement VFIO_USER_DMA_READ/WRITE
Date: Wed, 25 Jun 2025 20:30:06 +0100
Message-ID: <20250625193012.2316242-15-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625193012.2316242-1-john.levon@nutanix.com>
References: <20250625193012.2316242-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::18) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: aa751081-95d6-4713-f5de-08ddb41ecdd0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xhmgbMSPSATB6L2hP6+j+o1ljXKmDFMdomEA3i8hv03dMLo19RCqfKOV/Tq0?=
 =?us-ascii?Q?FHorcitYT/3lcdcAuV28qFsBDYukcURt1YDov9wvzltPiUSZk/POJsOE4scC?=
 =?us-ascii?Q?B046pd5FerA1rf1cKVUNWx1YKRXA2VGm/0teMm0mrtq9Q9CquMzJUXnOWwcz?=
 =?us-ascii?Q?aEOklCIraokgCqJzxqnB8u5BiE1oD4Wf2duik1Fs+spG8LE8zEdERBb8eIuz?=
 =?us-ascii?Q?JtQSMzRpdr6WFBN08avgNtMHtiBV2BHl4YAidVENgdAM2j+CSt/3jXKUYtuA?=
 =?us-ascii?Q?PoH8nbgdWTyarHuwoX8puvv5hj0BHgU9wlgLOTKFwW+5h8u2Kv4uF0MPSPLW?=
 =?us-ascii?Q?Kxdyf1MNE6oaZ/Z51OLW0kHorCeMd+8NxHBEUTdkc/FHMLmMAHuP+cvLAby2?=
 =?us-ascii?Q?YdZ/LlP0g9hXCRnY6CL7tE7cf3R6EK9WmupFP/48x4XVLTTdY++5cc9T0C1V?=
 =?us-ascii?Q?+vGz+DFQMq1Kvn5kO/Eg3SlUrqPECv9aFm2YVFkqzh2vR0gfvB0thsMHxVpN?=
 =?us-ascii?Q?6r0Ukx7DgB692I6v9Nbd9wdu9PMZO526boo7j6Cpc0kUTtsx7KTrMYnwdJab?=
 =?us-ascii?Q?Kn0ck7hVBNfu0NeHnlXnVivUda/G+F5PNz3zcvAKWuXSYpaDGnhWakBxhR97?=
 =?us-ascii?Q?+Euuz1litPE7nkk1OaoZ7/spErIMpNOSdbKBI3nWzGngc7LsfcJkhDrKPFtY?=
 =?us-ascii?Q?zyybzw0vwLhgKf299gFmTNEiZ3K0585Ue2RxOX/cAohnnetH1LLcdTk8w7mK?=
 =?us-ascii?Q?MX4l4StXuTg9gKe1HYrI6IYiUy+qZSdbNVozAt21/mL8FSlXr/wn5pD9iHCP?=
 =?us-ascii?Q?lSSZ/u6MlzAZub7mL81Pp1/ILHHEUCIUiurhbBZvyG+JB39NwJkFroVSNxhn?=
 =?us-ascii?Q?4R7dK7TFNvuYEHzmfYxH0repA2mXGpe8M6ziGClh+3Rsfq9ggCtD7o2TyqxV?=
 =?us-ascii?Q?lDBl9u8QQeeLuAgesrMM2SidVcqIsZma9KaVhFCUng3xGUEtxySLAmB1G0gQ?=
 =?us-ascii?Q?fbVVwgx6oPC1Nyx4Kb9mtwQtXx/fGcqDe1DydJYpgkFaUzRyYArCREC70dEl?=
 =?us-ascii?Q?qcLorHqWO+nvbeORCP6xqITKUdLago6Np5jxHdgpUuHhYMAxjgCVnCIMLuW3?=
 =?us-ascii?Q?6DAaCRulX+CMZVHDHZdQOE+5Y/u68pSUiba8rkgl0SuKEHaTnOf32iOp/N1N?=
 =?us-ascii?Q?QgcWYJw7IBNzEcpw7dRPlva8drlOvptsdV/AGTS78GUOvxsybJimVa9zQQx8?=
 =?us-ascii?Q?pb89m4wMA8dMKbFYFhmOUkV9FG8DqUJoRd4g2Xs/rIToOkU9//moFhZOygcw?=
 =?us-ascii?Q?AxbBTh0w8BpeKJYUCgc8v8YsoqlTG4N322VLH3cw0rJZNsWjilat59YxgaOK?=
 =?us-ascii?Q?Ba/LsRzN+Kljo+RR8cudzRng9l4DCp1mWY1QvjvGxa0q9TuVq4cqBceJU30f?=
 =?us-ascii?Q?S+S7ottBf+4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ogom+2771g6xd/7eydvAUL/ZGh3fmKf0cutHgaxNeSGTzIjSJiK87PeLWJWO?=
 =?us-ascii?Q?u8LRnkOzk4vDA9J40WLqzBNlfSM211Xkju0GtL6NrAMScAogGKkEJkZtuLs8?=
 =?us-ascii?Q?zPb4HbW1qP/kfqhyH0TqRlB+onBaT8PUdb0wH4Ii1FxQqYAor4pccaOM/yzC?=
 =?us-ascii?Q?xGL4vXs4j2kj3OBJhXGLc6/F7Ot7xqrso14rVFCfapTvj9Q5Fj9pI9MMSQsI?=
 =?us-ascii?Q?Wd4dmUPe/R1ujMIUxIx88Men4DS4L1/4nT4XUrnBPiCioxxXkZqekM0r5x3k?=
 =?us-ascii?Q?tG9IiJyBy6kbS1464LlwZTJd7aAmB6gsIW0yXx1eOzDxeUTKkxuzJ5g3+1A0?=
 =?us-ascii?Q?5XkrQ/xTEG5mUl9POIAizlQWQt+UvhzTkyQ2vW+i3nC9p+KJwegEOAwv9Rdt?=
 =?us-ascii?Q?fhL/xIdWetx9tA7Fxp3ja+Ff+DXNjmcf9La/9LrKwp0nHM7hk1x3Onhcw6B3?=
 =?us-ascii?Q?i7VbqIbaGxt23S4Afn6Qt3qJnzizFcJHCyhuRwmEE4KWeH6QrU03VadYKsYt?=
 =?us-ascii?Q?f+kp45cmT8xskx4A+61xfvcwRj25zFyqLxpsZAS0Af3aLTJtvWAFVE+MlXxd?=
 =?us-ascii?Q?83M+3NMn0J0C9ck5LNiq48ok5cjIhySzoIIQfQpJaKCI+mORtzRRa6N7rRCd?=
 =?us-ascii?Q?yud8Gbrl3kD/l3iYD772mi6WM7wpqqGsow/MT8xt99KtxnqPi6DBLzGS0IsV?=
 =?us-ascii?Q?kCUUEcXTgJNL6Wrhg85yWRQPpPeHAS6dHBx4M6THu7CxojC51KWe2SHJTfrj?=
 =?us-ascii?Q?Mta69aOk856mOIDcQXHXn06RZUMf/xkB+fCl0z0uInMO7iWPjF6lLQfSVSZj?=
 =?us-ascii?Q?T4kDWjtexCGc+7stI7b/J070NoikpMVwsNlCRaclpSrWExMNbpU7IwzRFaaE?=
 =?us-ascii?Q?gTswYpywzA4J8eUa/bPiKyE//E3IGwCgnDFlXnLOE+Fi1xdeOoGvFEejuY+d?=
 =?us-ascii?Q?MJQ3eTeSEskn0exdMwG4gY/0PObfQU0J7HZ9heHhMtJpNqMHm0vJZFsGem6T?=
 =?us-ascii?Q?8EgdQqrss+OU+xch7LdXUOlRpsJi4eLVOzkiqj85ofphtgqpGr/n1gQSASUh?=
 =?us-ascii?Q?uc//EOZu1wcNAMIv/qySZOUE2Uuvvb9SLBjVOSY7BV61mN5SD0pTJ3zogrrU?=
 =?us-ascii?Q?CirFoJwE8tED5j4Yo+eEewEzgJQ4hOv5IETpLZL8Hh8UABbxQFH6GKy3vQvm?=
 =?us-ascii?Q?HpkfH+sN5JJBijxJ6iDEroiFA0EyVaNMa7Zahb3ebAUpDho/ztKZJ0u5a+w+?=
 =?us-ascii?Q?wa27IQTgJd54mXECi5dPzxjcymoyhGihGwXdTQkKZDAV2HuAOmmaM3QOfJYB?=
 =?us-ascii?Q?PPt2dh6qPfDogg6v3jGOVlL8oBzKOhhCETVT+6hTDGKGVZ35fgYxktl6Q0CH?=
 =?us-ascii?Q?vX4RCdPuy2VOCxnRcgAHHrWS/JWfQGPcHsW2Ei151z4HolsBxUPyUwpQbKvo?=
 =?us-ascii?Q?jUC4s0tMhE8yOEZvC4MTWZ3+CVvxT7rIDKAAULbkNL3OIBrm7LTkY04HUZZT?=
 =?us-ascii?Q?CnF7Wh8beOykexwJO9OGLvA6JxYmBQsIkjRq20Rq6luZmrlJajnBnCqFUHJD?=
 =?us-ascii?Q?jfnZwGr8Znjlc7cgwogyRuNOkZst3aHA5osD0eh0?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa751081-95d6-4713-f5de-08ddb41ecdd0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 19:30:55.6618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIcE5rtD3jk1I0VMEM7aPkFqKkCFOzOTZ72bKTZLcYx9mx1T53HTUF9XBbbZlc/9BclJFBaFy2v4zUNooQdCXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8535
X-Authority-Analysis: v=2.4 cv=fPo53Yae c=1 sm=1 tr=0 ts=685c4e71 cx=c_pps
 a=iWk1tyVozQW8pnTusJ1YCw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=vgBDHfCE-WenxT7XOAUA:9
X-Proofpoint-ORIG-GUID: 3KckbvmXBpKCfLpWDQwCumcdBfolj7fp
X-Proofpoint-GUID: 3KckbvmXBpKCfLpWDQwCumcdBfolj7fp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE0NyBTYWx0ZWRfX8P4ngin/pSUP
 k292SL9p2d67UThrM+uq9o6eIKv5IL9PHHn2VMeCjiEd1bNhj3AB9eGHLeHex0JBNfw8iNsiAXK
 7C0kYJfn7BgX9AyiZ5fbCRgmn7a4Lg5kjqpmVjNLs3Jh41u9SgdDZsrWsWbW4Sq0/VJ/wLIvqQh
 UV/Q4HE76J2s65flgR/CFWNU55+DFzUua1cdN2A/UZgjn/qz8Ype4FErMEQVxIGsM5aw8d6EjYZ
 VClXeti0kCtuH76+Y3nfPUoSNZfuD0zVlElMUPvnIbg99gUYujbTSLRDAhpYteIoRAvgY+9fdso
 dwrj33MK7Me5G1bJDj3ecTYgQEhrUxzmn2QRbjj6mkar71La59NMIUiA//o0j3Z1nh2kHouqAqz
 fWSgG5HS9WvlJu1OlSqzL2PFa3vKlI6G2EmjakDXBgH4c0GSQKxDaP3ktENWt4BSZhQi/vLz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_06,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Unlike most other messages, this is a server->client message, for when a
server wants to do "DMA"; this is slow, so normally the server has
memory directly mapped instead.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/protocol.h |  13 ++++-
 hw/vfio-user/proxy.h    |   3 ++
 hw/vfio-user/pci.c      | 111 ++++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/proxy.c    |  97 +++++++++++++++++++++++++++++++++++
 4 files changed, 223 insertions(+), 1 deletion(-)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 524f3d633a..3e9d8e576b 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -200,7 +200,18 @@ typedef struct {
     char data[];
 } VFIOUserRegionRW;
 
-/*imported from struct vfio_bitmap */
+/*
+ * VFIO_USER_DMA_READ
+ * VFIO_USER_DMA_WRITE
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint64_t offset;
+    uint32_t count;
+    char data[];
+} VFIOUserDMARW;
+
+/* imported from struct vfio_bitmap */
 typedef struct {
     uint64_t pgsize;
     uint64_t size;
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index e2fc83ca3b..39092c08c8 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -101,6 +101,7 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
 bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 
 VFIOUserFDs *vfio_user_getfds(int numfds);
+void vfio_user_putfds(VFIOUserMsg *msg);
 
 void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
                            uint32_t size, uint32_t flags);
@@ -109,5 +110,7 @@ bool vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                          VFIOUserFDs *fds, int rsize, Error **errp);
 bool vfio_user_send_nowait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                            VFIOUserFDs *fds, int rsize, Error **errp);
+void vfio_user_send_reply(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int size);
+void vfio_user_send_error(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int error);
 
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 49d12763ab..040660d197 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -9,6 +9,7 @@
 #include <sys/ioctl.h>
 #include "qemu/osdep.h"
 #include "qapi-visit-sockets.h"
+#include "qemu/error-report.h"
 
 #include "hw/qdev-properties.h"
 #include "hw/vfio/pci.h"
@@ -80,6 +81,95 @@ static void vfio_user_msix_teardown(VFIOPCIDevice *vdev)
     vdev->msix->pba_region = NULL;
 }
 
+static void vfio_user_dma_read(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
+{
+    PCIDevice *pdev = &vdev->pdev;
+    VFIOUserProxy *proxy = vdev->vbasedev.proxy;
+    VFIOUserDMARW *res;
+    MemTxResult r;
+    size_t size;
+
+    if (msg->hdr.size < sizeof(*msg)) {
+        vfio_user_send_error(proxy, &msg->hdr, EINVAL);
+        return;
+    }
+    if (msg->count > proxy->max_xfer_size) {
+        vfio_user_send_error(proxy, &msg->hdr, E2BIG);
+        return;
+    }
+
+    /* switch to our own message buffer */
+    size = msg->count + sizeof(VFIOUserDMARW);
+    res = g_malloc0(size);
+    memcpy(res, msg, sizeof(*res));
+    g_free(msg);
+
+    r = pci_dma_read(pdev, res->offset, &res->data, res->count);
+
+    switch (r) {
+    case MEMTX_OK:
+        if (res->hdr.flags & VFIO_USER_NO_REPLY) {
+            g_free(res);
+            return;
+        }
+        vfio_user_send_reply(proxy, &res->hdr, size);
+        break;
+    case MEMTX_ERROR:
+        vfio_user_send_error(proxy, &res->hdr, EFAULT);
+        break;
+    case MEMTX_DECODE_ERROR:
+        vfio_user_send_error(proxy, &res->hdr, ENODEV);
+        break;
+    case MEMTX_ACCESS_ERROR:
+        vfio_user_send_error(proxy, &res->hdr, EPERM);
+        break;
+    default:
+        error_printf("vfio_user_dma_read unknown error %d\n", r);
+        vfio_user_send_error(vdev->vbasedev.proxy, &res->hdr, EINVAL);
+    }
+}
+
+static void vfio_user_dma_write(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
+{
+    PCIDevice *pdev = &vdev->pdev;
+    VFIOUserProxy *proxy = vdev->vbasedev.proxy;
+    MemTxResult r;
+
+    if (msg->hdr.size < sizeof(*msg)) {
+        vfio_user_send_error(proxy, &msg->hdr, EINVAL);
+        return;
+    }
+    /* make sure transfer count isn't larger than the message data */
+    if (msg->count > msg->hdr.size - sizeof(*msg)) {
+        vfio_user_send_error(proxy, &msg->hdr, E2BIG);
+        return;
+    }
+
+    r = pci_dma_write(pdev, msg->offset, &msg->data, msg->count);
+
+    switch (r) {
+    case MEMTX_OK:
+        if ((msg->hdr.flags & VFIO_USER_NO_REPLY) == 0) {
+            vfio_user_send_reply(proxy, &msg->hdr, sizeof(msg->hdr));
+        } else {
+            g_free(msg);
+        }
+        break;
+    case MEMTX_ERROR:
+        vfio_user_send_error(proxy, &msg->hdr, EFAULT);
+        break;
+    case MEMTX_DECODE_ERROR:
+        vfio_user_send_error(proxy, &msg->hdr, ENODEV);
+        break;
+    case MEMTX_ACCESS_ERROR:
+        vfio_user_send_error(proxy, &msg->hdr, EPERM);
+        break;
+    default:
+        error_printf("vfio_user_dma_write unknown error %d\n", r);
+        vfio_user_send_error(vdev->vbasedev.proxy, &msg->hdr, EINVAL);
+    }
+}
+
 /*
  * Incoming request message callback.
  *
@@ -87,7 +177,28 @@ static void vfio_user_msix_teardown(VFIOPCIDevice *vdev)
  */
 static void vfio_user_pci_process_req(void *opaque, VFIOUserMsg *msg)
 {
+    VFIOPCIDevice *vdev = opaque;
+    VFIOUserHdr *hdr = msg->hdr;
+
+    /* no incoming PCI requests pass FDs */
+    if (msg->fds != NULL) {
+        vfio_user_send_error(vdev->vbasedev.proxy, hdr, EINVAL);
+        vfio_user_putfds(msg);
+        return;
+    }
 
+    switch (hdr->command) {
+    case VFIO_USER_DMA_READ:
+        vfio_user_dma_read(vdev, (VFIOUserDMARW *)hdr);
+        break;
+    case VFIO_USER_DMA_WRITE:
+        vfio_user_dma_write(vdev, (VFIOUserDMARW *)hdr);
+        break;
+    default:
+        error_printf("vfio_user_pci_process_req unknown cmd %d\n",
+                     hdr->command);
+        vfio_user_send_error(vdev->vbasedev.proxy, hdr, ENOSYS);
+    }
 }
 
 /*
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index c8ae8a59b4..cb93d9a660 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -347,6 +347,10 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
         *msg->hdr = hdr;
         data = (char *)msg->hdr + sizeof(hdr);
     } else {
+        if (hdr.size > proxy->max_xfer_size + sizeof(VFIOUserDMARW)) {
+            error_setg(errp, "vfio_user_recv request larger than max");
+            goto err;
+        }
         buf = g_malloc0(hdr.size);
         memcpy(buf, &hdr, sizeof(hdr));
         data = buf + sizeof(hdr);
@@ -702,6 +706,40 @@ bool vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
     return ok;
 }
 
+/*
+ * async send - msg can be queued, but will be freed when sent
+ *
+ * Returns false on failure, in which case @errp will be populated.
+ *
+ * In either case, ownership of @hdr and @fds is taken, and the caller must
+ * *not* free them itself.
+ */
+static bool vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                 VFIOUserFDs *fds, Error **errp)
+{
+    VFIOUserMsg *msg;
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    msg = vfio_user_getmsg(proxy, hdr, fds);
+    msg->id = hdr->id;
+    msg->rsize = 0;
+    msg->type = VFIO_MSG_ASYNC;
+
+    if (!(hdr->flags & (VFIO_USER_NO_REPLY | VFIO_USER_REPLY))) {
+        error_setg_errno(errp, EINVAL, "%s on sync message", __func__);
+        vfio_user_recycle(proxy, msg);
+        return false;
+    }
+
+    if (!vfio_user_send_queued(proxy, msg, errp)) {
+        vfio_user_recycle(proxy, msg);
+        return false;
+    }
+
+    return true;
+}
+
 void vfio_user_wait_reqs(VFIOUserProxy *proxy)
 {
     VFIOUserMsg *msg;
@@ -746,6 +784,65 @@ void vfio_user_wait_reqs(VFIOUserProxy *proxy)
     qemu_mutex_unlock(&proxy->lock);
 }
 
+/*
+ * Reply to an incoming request.
+ */
+void vfio_user_send_reply(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int size)
+{
+    Error *local_err = NULL;
+
+    if (size < sizeof(VFIOUserHdr)) {
+        error_printf("%s: size too small", __func__);
+        g_free(hdr);
+        return;
+    }
+
+    /*
+     * convert header to associated reply
+     */
+    hdr->flags = VFIO_USER_REPLY;
+    hdr->size = size;
+
+    if (!vfio_user_send_async(proxy, hdr, NULL, &local_err)) {
+        error_report_err(local_err);
+    }
+}
+
+/*
+ * Send an error reply to an incoming request.
+ */
+void vfio_user_send_error(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int error)
+{
+    Error *local_err = NULL;
+
+    /*
+     * convert header to associated reply
+     */
+    hdr->flags = VFIO_USER_REPLY;
+    hdr->flags |= VFIO_USER_ERROR;
+    hdr->error_reply = error;
+    hdr->size = sizeof(*hdr);
+
+    if (!vfio_user_send_async(proxy, hdr, NULL, &local_err)) {
+        error_report_err(local_err);
+    }
+}
+
+/*
+ * Close FDs erroneously received in an incoming request.
+ */
+void vfio_user_putfds(VFIOUserMsg *msg)
+{
+    VFIOUserFDs *fds = msg->fds;
+    int i;
+
+    for (i = 0; i < fds->recv_fds; i++) {
+        close(fds->fds[i]);
+    }
+    g_free(fds);
+    msg->fds = NULL;
+}
+
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
 
-- 
2.43.0


