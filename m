Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB20C5AD49
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 00:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNh9f-00030V-01; Fri, 06 Jun 2025 20:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9c-0002zB-Ck
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:20 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9Z-0006PS-8i
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:20 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556J65fB008460;
 Fri, 6 Jun 2025 17:11:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Lg0f18ItSZy8fyxg8r6nI4gWEiG7RAQGDVLx9207J
 fc=; b=kJt2+oz9DlOrvAbF3Ml8F6e+pxjaxQu9Wzjk9M8PO2j6FI6IbgSYzYDqU
 mcQ694rehQ/EclmgfEmNHqcHFSZ3FD1S5hwWldTvvyBppfVIZ/9WJverawfqTn5n
 b85REiZgLLEQ3M1Ss6yYFXHwJEnh5cCpA2RKgVkL4nRCalpoCuvYg2R/O9f/m8C9
 gJzjTq1VHZWCqd8W0mH8ZEu7sB3VMEf6yei58KC2CKvnW0jjAw4D5QD25CvpxGsY
 jYoCl2ZJVfGiqoHkT6MjcgZzwmnFSeeJAc3tIl2Fy8X6NEixmNYixN6XpWVDtqmh
 lNIJTKOYNFnYfrPLLbWQz10hY56Cw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2108.outbound.protection.outlook.com [40.107.223.108])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 471g843x7d-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 17:11:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjHCF3MX77EIPs1B69FvxJpFB+wlklWeX7w+e2Th3kSgg4gVx4X7NtW4sv5E75J8zFFGACNlBazGBwbmvuMIXOrBS7hQYqb5F9evXVGFodjpon/wgFy+H7XRDe/pvV9fk/fW2t5wbqPvb5FdQYOS43h0TE6E9NCW6Hz0VYoDxjNQbp0d7QVHg5O+FboWkFV4SExJkd7+FMKZRKdYJBM3FEjNxJqTohIpsDvTfc62XjMTwji1dMgZ6SOtDu6IJtRyTBPUQ6mPfLb6UzqQ/nM0tnzwLJmgdEqqi4T3HuLU8ecCOZ14C9NFtndp8FtUoVG4NtKcNsHu8SKLeu9I9sZw4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lg0f18ItSZy8fyxg8r6nI4gWEiG7RAQGDVLx9207Jfc=;
 b=rBr/9P1dni/o0cNrALFHHWHhRgTm5RE7/NcGjBe9Zd1r6HsY+9Zl0TELjcCMXVmw31c92KIMhDoXkD4wmb0vFGfWz5BRg1NgrxNCaPHIJ98emWtIwfM+Ko10SZTf4Nc6wvVI0j0l0BD8L2gf5EsZ6DDOvTnNnEyC1vvDnJX+FLK1PuqJVU7RQDuOPVifKibEdCtxKxO5QdiCQWdZxWfjPkW+NfXUOJ3BjYvyqocjVgF/lCdl7NwFRugDWwwIAvwAVUa1MKc0PJzSjOqM/t/oCqc5bPoxjU+gMHWpZafi03j34uNrCiO1uGyjsD0krdf9h9wk5k4SxuhpaGwXLsO2fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lg0f18ItSZy8fyxg8r6nI4gWEiG7RAQGDVLx9207Jfc=;
 b=ffiya0ENxG8alLx1SsMDPZG8viFOqYM0+u4oXqtUZQ8Q9YtzGPCyGUkns4rvN80eZJzX3u3Js2ZHbPsRBm4hiZ9UQGsScYwRVp8Rta/iUNUie1j9Hn2IBDhsfV3elbXK/9DguT1k0kanGOrPovZv2ApSSeC0Wec5h4eofhuoHTwZJTNxtoWTr7dzu47wz/+6J1HHT2s84nxJ+iNPPtjidsh9JF0U18FRWuy0/yljCnar8wimhhMKGe+7wVJEcpkYP6z49gBzDJIWHyrwK3IpfAhKhKPbrLSk23kh3xtxyLiUv1/rorTTkWKFFKGEJyU4dtvpf0Ca0cAmkQszplmFDA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8715.namprd02.prod.outlook.com (2603:10b6:510:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Sat, 7 Jun
 2025 00:11:11 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.016; Sat, 7 Jun 2025
 00:11:11 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH v3 09/23] vfio-user: implement message send infrastructure
Date: Fri,  6 Jun 2025 17:10:41 -0700
Message-ID: <20250607001056.335310-10-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250607001056.335310-1-john.levon@nutanix.com>
References: <20250607001056.335310-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR22CA0004.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::19) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: c975a5cd-5d4b-4171-7733-08dda557cf4a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yTmbydjMZXAxpIy/F9nqsQRufi/s3KZ7OU21n+jr476dhGbaw5nhhVbvcbQq?=
 =?us-ascii?Q?usqLAoESIjb4GXdcW8pmU0oA8LWRlIgAmNY2u5wF6Lm5nf5tL7b21VIvFDGn?=
 =?us-ascii?Q?XAi3IVkNlz6pwuTXhXgufoYRPSmyinpJp3MYZrfDrxuP1H/m4IcFvUXRDaX9?=
 =?us-ascii?Q?7rTUx0EpS2AR4E74c7IFnpD5TbGqEfOplTcBv0rxFR6crfPxolE8ZqPbTGak?=
 =?us-ascii?Q?ez844Ik4ZDkXWaCIU9Hj3tUGmwJ6co4wSF7/Ln2cTllVDFgQCmWQx8KDcw9i?=
 =?us-ascii?Q?smJeRNBL8jWG3OConkeNwx2bqXuYfCIMLlzWyDo959MZd5Wnw07eDENbTJRp?=
 =?us-ascii?Q?V82t20ZchIrRpGYFwgd81xQg4/GvXE7kOiUaJBKBu7vadlw9sgAKUhqPFubk?=
 =?us-ascii?Q?54x3tFHDsWb6o/UKbbz7LfY4anrmFVAG/AdHZLhKsLu4k7LC/b8IKU+u2ubg?=
 =?us-ascii?Q?WsWgrtveKCdfdXivHW5Bg3XrTok27W0OJgjk5aeqitG2Kmpb3vmyDHTCTKGW?=
 =?us-ascii?Q?VjdrA/gyYUKWzakODWjCWWHDsVoBL3tNBYv3V/kl9sY2DgnlGbHJ6EBMGCGI?=
 =?us-ascii?Q?DE7gFtscgwyHf1r1JUhvSdU+NzDjL2YNidoncRbCZDyMtPkzBOjpLoZ0ZcBg?=
 =?us-ascii?Q?b7cZq7MQFjgoln0y9a67kGmjk5Ckf1cVsFD6jNipziK/20GAAL9x1Z2Dg12p?=
 =?us-ascii?Q?z8878+WyxisuvKuchZHOLRy83N4gwr2a8WvKIv8bJI3VLBREJs4YRr43PVl2?=
 =?us-ascii?Q?+Fn842rc7G0VpU9jAjiZeYaDCFJ5AfA0WuXtqfxlwn4ExRMOy+wGOgr4GlGP?=
 =?us-ascii?Q?KGDf49rWCT4j4Mga4tED1Lvs1bEYx4z4pAJN7kmnVU8jklCu0bWIK2Z9beEq?=
 =?us-ascii?Q?6VJmKOsUea58v6HeKK18KGAImbRTjKNVFPHqObPT/38Wmkhl2yKFbPcrXg/L?=
 =?us-ascii?Q?FhcdTjqekXp3XVmkWlP91ffF+cQX1ITEechLZZ5k75bqSM2PN3AdE2/NeoeM?=
 =?us-ascii?Q?L+E33CRDy1KpNtWeVsMgaPlews8Zi30Vi3CevV++8cfLOPAgrIfB9Kf+VGmE?=
 =?us-ascii?Q?MDnUQmFFkzfPctZ5gkA/iQCIxp7IdiNyKXnwY8Kf44ioxOihP4OGAg8kBqEA?=
 =?us-ascii?Q?naU6MGp+cBJ2X/RFxBveUsONqqmXWTc3vhFk4CDK+qXm7C/y6ZMwCPkQ1/WE?=
 =?us-ascii?Q?GKA9YVW/ao/1IZznDpXXDHDl9Xr1NNfo+rvKHDmI9zkbCuUCUZS+zGBuj2fJ?=
 =?us-ascii?Q?JduSaxmEChZx0dUF9MqGPcNow2hEt7nxhvNhBnyrvUeAu5a/GTUhDqQVWCTg?=
 =?us-ascii?Q?dTW7ryeyh9nykgZLSO3O9hbMGzLzcnf2LhKnrNCP/G6qpgJ34jeeUA5l/c70?=
 =?us-ascii?Q?E2SEIZNN5Tf7Dz1ArV9hDwCNolTmKACXhU1toyE1bep5TS49bZgzoQvsFbIe?=
 =?us-ascii?Q?31u6y6V8nHI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tnIzRGuZuHKVUs/ul1SOyy80a87K7qHNTlDTeyGtEBYI9YxIVbSg2Dpzh8ll?=
 =?us-ascii?Q?SDj1gXkyAT+0lXurge3VQn2Hsw7X/6F0nP6QBqCOJ9/5JyGRc5VT83oM1ZgR?=
 =?us-ascii?Q?1rtBujZ3OxmNklLIJc6JB6tHbcw2UmW1mzOoFmgcmmiya9x9TLwybkJuK98I?=
 =?us-ascii?Q?5ycFX2SLTLlzX36E0j7LCeWbkGrwbq4Si/mrSbP0ymrPQFacbbnhTS6imsU8?=
 =?us-ascii?Q?6zkCJZFsEljoWX7LkBygtm3e043bVysZjOEfuLZtC4dpPRnI+18NmaZqEGHz?=
 =?us-ascii?Q?js6y6AeCwTPzljiYg+3lAvcuT7u04vrxryDyccc7oOXEtkNt5piER2YLOUJC?=
 =?us-ascii?Q?oaNRlAk8x2jGJqsIublhNw1aeX95EHoh3oB8aT0K01kxDbN7ZfQKUQfFcAfw?=
 =?us-ascii?Q?kYmcyEZF+h+hQjRzCzju76oB/nS54d0oYsEB6UZ8bWD1IDwidwT9nGm1nbSb?=
 =?us-ascii?Q?eumekECqk7rZLwyYVFlfQsgvZdHgEfF+Er+og/xIJLBKPCLk91q1wGWjeTc2?=
 =?us-ascii?Q?VAW9Us8wNLFeOA1G4ORf/W7bPwrFlGeu5pVnNxbskIUI0m38PcOSvjP9H6/I?=
 =?us-ascii?Q?vFazfOrECwk7xwUO18HojOF8akyMSM74gVe6H2ZTVyOIIbdumc7nV062WSbL?=
 =?us-ascii?Q?TtJdVBiTwVsdNJD4zEEKBjpvfCE0Cd9vCoz5TxLP6A0OYdnSmK7znZqEl3jh?=
 =?us-ascii?Q?Fd2zwkxogjORitNja1jBccYgqVQKMDBM9M9M5W19zZGm/VNoP6VrvZV87Tn1?=
 =?us-ascii?Q?mKNmgxju/aAvOh8hjCkNEEzkpu2GI+8Rjlilkc1zje2U/gVJ+W7RzEPIVT0x?=
 =?us-ascii?Q?bJGuQtku5yRUW2XqlIM1tHBn0hMN8Fx/D+4pQRe8Qp9NsCw8VPEY1/SKCxc7?=
 =?us-ascii?Q?8SNojiygKF8qpfiSiPeDuTa/vwMA7YgbwT9ff+KyE9hogZjoglemzyPBQt5E?=
 =?us-ascii?Q?lZ81dDzL4MqY87WN6OzlnOjgHOkSv5OlJJbi7JpmYjZSh29i6F57kOp4TmEo?=
 =?us-ascii?Q?HnrYkc1g8T/XEkw15GdsBT3a/QNw2OV6DozyvTvagxrc4Es9D6c/+/WlJxxO?=
 =?us-ascii?Q?UL7HhLJAojbYN7T1BbWek7RYQzcWgeZnv51OQAaKt/mLEEdvN9Tkz5cG2lby?=
 =?us-ascii?Q?ijKUAaQHysy1nh8V+RFRio3Fw9MWo6HhRxuffF2vPc9Io5GXGeU06bLiNBlA?=
 =?us-ascii?Q?0iu0Lb8OuvbGeGhEinGz52Yiw/VOu1M/8rKcNHt/bb7UjF0CcT1KAHYcwDpp?=
 =?us-ascii?Q?d+zXFSuXCzN6gz9dirr7BqwplUP/XNKUAhgY6vPqIgSrlKHC9EKptucumSKQ?=
 =?us-ascii?Q?z5+8X+RoiCetsdBMClPE9UtGmjVjDztLPo28bGteH3w3nHsBERm7OywylAdE?=
 =?us-ascii?Q?Axev1a1milIUeJjd2JGsmthGwGhb7c0KA2LAuqGwgrB7tOe3O5HwjrvoSidW?=
 =?us-ascii?Q?TpsDJJyUy64QEcgplk6pCushaplyH7HGoXebQni3KBRx6CR5JphvXMILGdrf?=
 =?us-ascii?Q?4jl7YADzlWkGWyrUew5+WjNyFsUzSvk9BQbaSh5XEJb+RFiztf86SoFjn0Tp?=
 =?us-ascii?Q?QWYgBjiISRMmn8kbcdqQWJ+xwRsc1esB6uLA3xm6?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c975a5cd-5d4b-4171-7733-08dda557cf4a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 00:11:11.7290 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: doE0L/GiLY0HkXHUY0gDiBsaHVS3+8kF+bW15s1oYiuQT+pljTJ2h5M+pUYgY+bOyxWiWxUgR1vB2/txYv2QCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8715
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE5OSBTYWx0ZWRfXy4JhsfRpY9g1
 f5/ujXh9iMRZMkJjTYpJX8K1olJHhPC6sBZLIXnowqRayibziP361K1o4bAelSMR3HcHTbqk5m7
 srDJ3cA7K0NO5V5/CkycU6DGlxUZMQH9TmZpu47rRmFfjUl3n0HpJPhGTkxyUNLskH39vC5Fw4v
 9p//Tbcbg+3Idj0E5Hq8vWwDC0tLl/vXN3qtMw3nySrSdukMvfDJIGXnsUX+JTBein6Pim/Gxe5
 xf+TkpDEMBqGJpQ4n8ARVsuLLp9B22y0RevDq+Kp0GHf0/KYiGDE9M3Yd2xTKpwEkmbXHDv6d+X
 GvWHyqTPsdKDkIn/1gfwG9FuJqgJjGd85rwEr4tq6PS9q0c1zEejUvm916Dir1rGA0j81liPmjQ
 9ifsqAo547hW0s/3AmVJE5+WM3XxUUlF0xjhgMMVHlgkCPIwnzRC8+PpJdxL/80jrZSwFDQX
X-Proofpoint-GUID: HoeGrYWw6qmC7GSiNGR8JhabBQW7Ij9F
X-Authority-Analysis: v=2.4 cv=TvXmhCXh c=1 sm=1 tr=0 ts=684383a1 cx=c_pps
 a=A3LX+wu56ikakVX7ADtWTg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=UnscCpd6-9sbi9RN3AUA:9
X-Proofpoint-ORIG-GUID: HoeGrYWw6qmC7GSiNGR8JhabBQW7Ij9F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_09,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

Add plumbing for sending vfio-user messages on the control socket.
Add initial version negotation on connection.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/protocol.h   |  62 +++++
 hw/vfio-user/proxy.h      |   9 +
 hw/vfio-user/pci.c        |  18 +-
 hw/vfio-user/proxy.c      | 494 ++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/trace-events |   2 +
 5 files changed, 583 insertions(+), 2 deletions(-)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 6300c681e7..74ea2a94e6 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -53,4 +53,66 @@ enum vfio_user_command {
 #define VFIO_USER_NO_REPLY      0x10
 #define VFIO_USER_ERROR         0x20
 
+
+/*
+ * VFIO_USER_VERSION
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint16_t major;
+    uint16_t minor;
+    char capabilities[];
+} VFIOUserVersion;
+
+#define VFIO_USER_MAJOR_VER     0
+#define VFIO_USER_MINOR_VER     0
+
+#define VFIO_USER_CAP           "capabilities"
+
+/* "capabilities" members */
+#define VFIO_USER_CAP_MAX_FDS   "max_msg_fds"
+#define VFIO_USER_CAP_MAX_XFER  "max_data_xfer_size"
+#define VFIO_USER_CAP_PGSIZES   "pgsizes"
+#define VFIO_USER_CAP_MAP_MAX   "max_dma_maps"
+#define VFIO_USER_CAP_MIGR      "migration"
+
+/* "migration" members */
+#define VFIO_USER_CAP_PGSIZE            "pgsize"
+#define VFIO_USER_CAP_MAX_BITMAP        "max_bitmap_size"
+
+/*
+ * Max FDs mainly comes into play when a device supports multiple interrupts
+ * where each ones uses an eventfd to inject it into the guest.
+ * It is clamped by the the number of FDs the qio channel supports in a
+ * single message.
+ */
+#define VFIO_USER_DEF_MAX_FDS   8
+#define VFIO_USER_MAX_MAX_FDS   16
+
+/*
+ * Max transfer limits the amount of data in region and DMA messages.
+ * Region R/W will be very small (limited by how much a single instruction
+ * can process) so just use a reasonable limit here.
+ */
+#define VFIO_USER_DEF_MAX_XFER  (1024 * 1024)
+#define VFIO_USER_MAX_MAX_XFER  (64 * 1024 * 1024)
+
+/*
+ * Default pagesizes supported is 4k.
+ */
+#define VFIO_USER_DEF_PGSIZE    4096
+
+/*
+ * Default max number of DMA mappings is stolen from the
+ * linux kernel "dma_entry_limit"
+ */
+#define VFIO_USER_DEF_MAP_MAX   65535
+
+/*
+ * Default max bitmap size is also take from the linux kernel,
+ * where usage of signed ints limits the VA range to 2^31 bytes.
+ * Dividing that by the number of bits per byte yields 256MB
+ */
+#define VFIO_USER_DEF_MAX_BITMAP (256 * 1024 * 1024)
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 0105479d02..33e8a4d83b 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -40,6 +40,7 @@ typedef struct VFIOUserMsg {
     uint32_t id;
     QemuCond cv;
     bool complete;
+    bool pending;
     enum msg_type type;
 } VFIOUserMsg;
 
@@ -59,6 +60,12 @@ typedef struct VFIOUserProxy {
     struct QIOChannel *ioc;
     void (*request)(void *opaque, VFIOUserMsg *msg);
     void *req_arg;
+    uint64_t max_xfer_size;
+    uint64_t max_send_fds;
+    uint64_t max_dma;
+    uint64_t dma_pgsizes;
+    uint64_t max_bitmap;
+    uint64_t migr_pgsize;
     int flags;
     QemuCond close_cv;
     AioContext *ctx;
@@ -81,6 +88,7 @@ typedef struct VFIOUserProxy {
 
 /* VFIOProxy flags */
 #define VFIO_PROXY_CLIENT        0x1
+#define VFIO_PROXY_FORCE_QUEUED  0x4
 
 typedef struct VFIODevice VFIODevice;
 
@@ -89,5 +97,6 @@ void vfio_user_disconnect(VFIOUserProxy *proxy);
 void vfio_user_set_handler(VFIODevice *vbasedev,
                            void (*handler)(void *opaque, VFIOUserMsg *msg),
                            void *reqarg);
+bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 93bd0e1361..bcef0ea341 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -22,6 +22,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
 struct VFIOUserPCIDevice {
     VFIOPCIDevice device;
     char *sock_name;
+    bool send_queued;   /* all sends are queued */
 };
 
 /*
@@ -90,6 +91,14 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     vbasedev->proxy = proxy;
     vfio_user_set_handler(vbasedev, vfio_user_pci_process_req, vdev);
 
+    if (udev->send_queued) {
+        proxy->flags |= VFIO_PROXY_FORCE_QUEUED;
+    }
+
+    if (!vfio_user_validate_version(proxy, errp)) {
+        goto error;
+    }
+
     vbasedev->name = g_strdup_printf("VFIO user <%s>", udev->sock_name);
 
     /*
@@ -101,9 +110,13 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     if (!vfio_device_attach_by_iommu_type(TYPE_VFIO_IOMMU_USER,
                                           vbasedev->name, vbasedev,
                                           as, errp)) {
-        error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
-        return;
+        goto error;
     }
+
+    return;
+
+error:
+    error_prepend(errp, VFIO_MSG_PREFIX, vdev->vbasedev.name);
 }
 
 static void vfio_user_instance_init(Object *obj)
@@ -154,6 +167,7 @@ static const Property vfio_user_pci_dev_properties[] = {
     DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
                        sub_device_id, PCI_ANY_ID),
     DEFINE_PROP_STRING("socket", VFIOUserPCIDevice, sock_name),
+    DEFINE_PROP_BOOL("x-send-queued", VFIOUserPCIDevice, send_queued, false),
 };
 
 static void vfio_user_pci_dev_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 4a654d7597..0bc12da865 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -16,14 +16,19 @@
 #include "hw/vfio-user/proxy.h"
 #include "hw/vfio-user/trace.h"
 #include "qapi/error.h"
+#include "qobject/qdict.h"
+#include "qobject/qjson.h"
+#include "qobject/qnum.h"
 #include "qemu/error-report.h"
 #include "qemu/lockable.h"
 #include "qemu/main-loop.h"
 #include "system/iothread.h"
 
+static int wait_time = 5000;   /* wait up to 5 sec for busy servers */
 static IOThread *vfio_user_iothread;
 
 static void vfio_user_shutdown(VFIOUserProxy *proxy);
+static int vfio_user_send_qio(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                                      VFIOUserFDs *fds);
 static VFIOUserFDs *vfio_user_getfds(int numfds);
@@ -31,9 +36,16 @@ static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 
 static void vfio_user_recv(void *opaque);
 static int vfio_user_recv_one(VFIOUserProxy *proxy);
+static void vfio_user_send(void *opaque);
+static int vfio_user_send_one(VFIOUserProxy *proxy);
 static void vfio_user_cb(void *opaque);
 
 static void vfio_user_request(void *opaque);
+static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg);
+static void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                VFIOUserFDs *fds, int rsize);
+static void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
+                                  uint32_t size, uint32_t flags);
 
 static inline void vfio_user_set_error(VFIOUserHdr *hdr, uint32_t err)
 {
@@ -52,6 +64,35 @@ static void vfio_user_shutdown(VFIOUserProxy *proxy)
                                    proxy->ctx, NULL, NULL);
 }
 
+static int vfio_user_send_qio(VFIOUserProxy *proxy, VFIOUserMsg *msg)
+{
+    VFIOUserFDs *fds =  msg->fds;
+    struct iovec iov = {
+        .iov_base = msg->hdr,
+        .iov_len = msg->hdr->size,
+    };
+    size_t numfds = 0;
+    int ret, *fdp = NULL;
+    Error *local_err = NULL;
+
+    if (fds != NULL && fds->send_fds != 0) {
+        numfds = fds->send_fds;
+        fdp = fds->fds;
+    }
+
+    ret = qio_channel_writev_full(proxy->ioc, &iov, 1, fdp, numfds, 0,
+                                  &local_err);
+
+    if (ret == -1) {
+        vfio_user_set_error(msg->hdr, EIO);
+        vfio_user_shutdown(proxy);
+        error_report_err(local_err);
+    }
+    trace_vfio_user_send_write(msg->hdr->id, ret);
+
+    return ret;
+}
+
 static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                                      VFIOUserFDs *fds)
 {
@@ -92,6 +133,7 @@ static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg)
     msg->hdr = NULL;
     msg->fds = NULL;
     msg->complete = false;
+    msg->pending = false;
     QTAILQ_INSERT_HEAD(&proxy->free, msg, next);
 }
 
@@ -386,6 +428,54 @@ err:
     return -1;
 }
 
+/*
+ * Send messages from outgoing queue when the socket buffer has space.
+ * If we deplete 'outgoing', remove ourselves from the poll list.
+ */
+static void vfio_user_send(void *opaque)
+{
+    VFIOUserProxy *proxy = opaque;
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    if (proxy->state == VFIO_PROXY_CONNECTED) {
+        while (!QTAILQ_EMPTY(&proxy->outgoing)) {
+            if (vfio_user_send_one(proxy) < 0) {
+                return;
+            }
+        }
+        qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
+                                       vfio_user_recv, NULL, NULL, proxy);
+    }
+}
+
+/*
+ * Send a single message.
+ *
+ * Sent async messages are freed, others are moved to pending queue.
+ */
+static int vfio_user_send_one(VFIOUserProxy *proxy)
+{
+    VFIOUserMsg *msg;
+    int ret;
+
+    msg = QTAILQ_FIRST(&proxy->outgoing);
+    ret = vfio_user_send_qio(proxy, msg);
+    if (ret < 0) {
+        return ret;
+    }
+
+    QTAILQ_REMOVE(&proxy->outgoing, msg, next);
+    if (msg->type == VFIO_MSG_ASYNC) {
+        vfio_user_recycle(proxy, msg);
+    } else {
+        QTAILQ_INSERT_TAIL(&proxy->pending, msg, next);
+        msg->pending = true;
+    }
+
+    return 0;
+}
+
 static void vfio_user_cb(void *opaque)
 {
     VFIOUserProxy *proxy = opaque;
@@ -447,6 +537,119 @@ static void vfio_user_request(void *opaque)
     }
 }
 
+/*
+ * Messages are queued onto the proxy's outgoing list.
+ *
+ * It handles 3 types of messages:
+ *
+ * async messages - replies and posted writes
+ *
+ * There will be no reply from the server, so message
+ * buffers are freed after they're sent.
+ *
+ * nowait messages - map/unmap during address space transactions
+ *
+ * These are also sent async, but a reply is expected so that
+ * vfio_wait_reqs() can wait for the youngest nowait request.
+ * They transition from the outgoing list to the pending list
+ * when sent, and are freed when the reply is received.
+ *
+ * wait messages - all other requests
+ *
+ * The reply to these messages is waited for by their caller.
+ * They also transition from outgoing to pending when sent, but
+ * the message buffer is returned to the caller with the reply
+ * contents.  The caller is responsible for freeing these messages.
+ *
+ * As an optimization, if the outgoing list and the socket send
+ * buffer are empty, the message is sent inline instead of being
+ * added to the outgoing list.  The rest of the transitions are
+ * unchanged.
+ *
+ * returns 0 if the message was sent or queued
+ * returns -1 on send error
+ */
+static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg)
+{
+    int ret;
+
+    /*
+     * Unsent outgoing msgs - add to tail
+     */
+    if (!QTAILQ_EMPTY(&proxy->outgoing)) {
+        QTAILQ_INSERT_TAIL(&proxy->outgoing, msg, next);
+        return 0;
+    }
+
+    /*
+     * Try inline - if blocked, queue it and kick send poller
+     */
+    if (proxy->flags & VFIO_PROXY_FORCE_QUEUED) {
+        ret = QIO_CHANNEL_ERR_BLOCK;
+    } else {
+        ret = vfio_user_send_qio(proxy, msg);
+    }
+    if (ret == QIO_CHANNEL_ERR_BLOCK) {
+        QTAILQ_INSERT_HEAD(&proxy->outgoing, msg, next);
+        qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
+                                       vfio_user_recv, proxy->ctx,
+                                       vfio_user_send, proxy);
+        return 0;
+    }
+    if (ret == -1) {
+        return ret;
+    }
+
+    /*
+     * Sent - free async, add others to pending
+     */
+    if (msg->type == VFIO_MSG_ASYNC) {
+        vfio_user_recycle(proxy, msg);
+    } else {
+        QTAILQ_INSERT_TAIL(&proxy->pending, msg, next);
+        msg->pending = true;
+    }
+
+    return 0;
+}
+
+static void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                VFIOUserFDs *fds, int rsize)
+{
+    VFIOUserMsg *msg;
+    int ret;
+
+    if (hdr->flags & VFIO_USER_NO_REPLY) {
+        error_printf("vfio_user_send_wait on async message\n");
+        vfio_user_set_error(hdr, EINVAL);
+        return;
+    }
+
+    qemu_mutex_lock(&proxy->lock);
+
+    msg = vfio_user_getmsg(proxy, hdr, fds);
+    msg->id = hdr->id;
+    msg->rsize = rsize ? rsize : hdr->size;
+    msg->type = VFIO_MSG_WAIT;
+
+    ret = vfio_user_send_queued(proxy, msg);
+
+    if (ret == 0) {
+        while (!msg->complete) {
+            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock, wait_time)) {
+                VFIOUserMsgQ *list;
+
+                list = msg->pending ? &proxy->pending : &proxy->outgoing;
+                QTAILQ_REMOVE(list, msg, next);
+                vfio_user_set_error(hdr, ETIMEDOUT);
+                break;
+            }
+        }
+    }
+    vfio_user_recycle(proxy, msg);
+
+    qemu_mutex_unlock(&proxy->lock);
+}
 
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
@@ -475,6 +678,15 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     proxy = g_malloc0(sizeof(VFIOUserProxy));
     proxy->sockname = g_strdup_printf("unix:%s", sockname);
     proxy->ioc = ioc;
+
+    /* init defaults */
+    proxy->max_xfer_size = VFIO_USER_DEF_MAX_XFER;
+    proxy->max_send_fds = VFIO_USER_DEF_MAX_FDS;
+    proxy->max_dma = VFIO_USER_DEF_MAP_MAX;
+    proxy->dma_pgsizes = VFIO_USER_DEF_PGSIZE;
+    proxy->max_bitmap = VFIO_USER_DEF_MAX_BITMAP;
+    proxy->migr_pgsize = VFIO_USER_DEF_PGSIZE;
+
     proxy->flags = VFIO_PROXY_CLIENT;
     proxy->state = VFIO_PROXY_CONNECTED;
 
@@ -572,3 +784,285 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
     g_free(proxy->sockname);
     g_free(proxy);
 }
+
+static void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
+                                  uint32_t size, uint32_t flags)
+{
+    static uint16_t next_id;
+
+    hdr->id = qatomic_fetch_inc(&next_id);
+    hdr->command = cmd;
+    hdr->size = size;
+    hdr->flags = (flags & ~VFIO_USER_TYPE) | VFIO_USER_REQUEST;
+    hdr->error_reply = 0;
+}
+
+struct cap_entry {
+    const char *name;
+    bool (*check)(VFIOUserProxy *proxy, QObject *qobj, Error **errp);
+};
+
+static bool caps_parse(VFIOUserProxy *proxy, QDict *qdict,
+                       struct cap_entry caps[], Error **errp)
+{
+    QObject *qobj;
+    struct cap_entry *p;
+
+    for (p = caps; p->name != NULL; p++) {
+        qobj = qdict_get(qdict, p->name);
+        if (qobj != NULL) {
+            if (!p->check(proxy, qobj, errp)) {
+                return false;
+            }
+            qdict_del(qdict, p->name);
+        }
+    }
+
+    /* warning, for now */
+    if (qdict_size(qdict) != 0) {
+        warn_report("spurious capabilities");
+    }
+    return true;
+}
+
+static bool check_migr_pgsize(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QNum *qn = qobject_to(QNum, qobj);
+    uint64_t pgsize;
+
+    if (qn == NULL || !qnum_get_try_uint(qn, &pgsize)) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_PGSIZE);
+        return false;
+    }
+
+    /* must be larger than default */
+    if (pgsize & (VFIO_USER_DEF_PGSIZE - 1)) {
+        error_setg(errp, "pgsize 0x%"PRIx64" too small", pgsize);
+        return false;
+    }
+
+    proxy->migr_pgsize = pgsize;
+    return true;
+}
+
+static bool check_bitmap(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QNum *qn = qobject_to(QNum, qobj);
+    uint64_t bitmap_size;
+
+    if (qn == NULL || !qnum_get_try_uint(qn, &bitmap_size)) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAX_BITMAP);
+        return false;
+    }
+
+    /* can only lower it */
+    if (bitmap_size > VFIO_USER_DEF_MAX_BITMAP) {
+        error_setg(errp, "%s too large", VFIO_USER_CAP_MAX_BITMAP);
+        return false;
+    }
+
+    proxy->max_bitmap = bitmap_size;
+    return true;
+}
+
+static struct cap_entry caps_migr[] = {
+    { VFIO_USER_CAP_PGSIZE, check_migr_pgsize },
+    { VFIO_USER_CAP_MAX_BITMAP, check_bitmap },
+    { NULL }
+};
+
+static bool check_max_fds(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QNum *qn = qobject_to(QNum, qobj);
+    uint64_t max_send_fds;
+
+    if (qn == NULL || !qnum_get_try_uint(qn, &max_send_fds) ||
+        max_send_fds > VFIO_USER_MAX_MAX_FDS) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAX_FDS);
+        return false;
+    }
+    proxy->max_send_fds = max_send_fds;
+    return true;
+}
+
+static bool check_max_xfer(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QNum *qn = qobject_to(QNum, qobj);
+    uint64_t max_xfer_size;
+
+    if (qn == NULL || !qnum_get_try_uint(qn, &max_xfer_size) ||
+        max_xfer_size > VFIO_USER_MAX_MAX_XFER) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAX_XFER);
+        return false;
+    }
+    proxy->max_xfer_size = max_xfer_size;
+    return true;
+}
+
+static bool check_pgsizes(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QNum *qn = qobject_to(QNum, qobj);
+    uint64_t pgsizes;
+
+    if (qn == NULL || !qnum_get_try_uint(qn, &pgsizes)) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_PGSIZES);
+        return false;
+    }
+
+    /* must be larger than default */
+    if (pgsizes & (VFIO_USER_DEF_PGSIZE - 1)) {
+        error_setg(errp, "pgsize 0x%"PRIx64" too small", pgsizes);
+        return false;
+    }
+
+    proxy->dma_pgsizes = pgsizes;
+    return true;
+}
+
+static bool check_max_dma(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QNum *qn = qobject_to(QNum, qobj);
+    uint64_t max_dma;
+
+    if (qn == NULL || !qnum_get_try_uint(qn, &max_dma)) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAP_MAX);
+        return false;
+    }
+
+    /* can only lower it */
+    if (max_dma > VFIO_USER_DEF_MAP_MAX) {
+        error_setg(errp, "%s too large", VFIO_USER_CAP_MAP_MAX);
+        return false;
+    }
+
+    proxy->max_dma = max_dma;
+    return true;
+}
+
+static bool check_migr(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QDict *qdict = qobject_to(QDict, qobj);
+
+    if (qdict == NULL) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAX_FDS);
+        return true;
+    }
+    return caps_parse(proxy, qdict, caps_migr, errp);
+}
+
+static struct cap_entry caps_cap[] = {
+    { VFIO_USER_CAP_MAX_FDS, check_max_fds },
+    { VFIO_USER_CAP_MAX_XFER, check_max_xfer },
+    { VFIO_USER_CAP_PGSIZES, check_pgsizes },
+    { VFIO_USER_CAP_MAP_MAX, check_max_dma },
+    { VFIO_USER_CAP_MIGR, check_migr },
+    { NULL }
+};
+
+static bool check_cap(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+   QDict *qdict = qobject_to(QDict, qobj);
+
+    if (qdict == NULL) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP);
+        return false;
+    }
+    return caps_parse(proxy, qdict, caps_cap, errp);
+}
+
+static struct cap_entry ver_0_0[] = {
+    { VFIO_USER_CAP, check_cap },
+    { NULL }
+};
+
+static bool caps_check(VFIOUserProxy *proxy, int minor, const char *caps,
+                       Error **errp)
+{
+    QObject *qobj;
+    QDict *qdict;
+    bool ret;
+
+    qobj = qobject_from_json(caps, NULL);
+    if (qobj == NULL) {
+        error_setg(errp, "malformed capabilities %s", caps);
+        return false;
+    }
+    qdict = qobject_to(QDict, qobj);
+    if (qdict == NULL) {
+        error_setg(errp, "capabilities %s not an object", caps);
+        qobject_unref(qobj);
+        return false;
+    }
+    ret = caps_parse(proxy, qdict, ver_0_0, errp);
+
+    qobject_unref(qobj);
+    return ret;
+}
+
+static GString *caps_json(void)
+{
+    QDict *dict = qdict_new();
+    QDict *capdict = qdict_new();
+    QDict *migdict = qdict_new();
+    GString *str;
+
+    qdict_put_int(migdict, VFIO_USER_CAP_PGSIZE, VFIO_USER_DEF_PGSIZE);
+    qdict_put_int(migdict, VFIO_USER_CAP_MAX_BITMAP, VFIO_USER_DEF_MAX_BITMAP);
+    qdict_put_obj(capdict, VFIO_USER_CAP_MIGR, QOBJECT(migdict));
+
+    qdict_put_int(capdict, VFIO_USER_CAP_MAX_FDS, VFIO_USER_MAX_MAX_FDS);
+    qdict_put_int(capdict, VFIO_USER_CAP_MAX_XFER, VFIO_USER_DEF_MAX_XFER);
+    qdict_put_int(capdict, VFIO_USER_CAP_PGSIZES, VFIO_USER_DEF_PGSIZE);
+    qdict_put_int(capdict, VFIO_USER_CAP_MAP_MAX, VFIO_USER_DEF_MAP_MAX);
+
+    qdict_put_obj(dict, VFIO_USER_CAP, QOBJECT(capdict));
+
+    str = qobject_to_json(QOBJECT(dict));
+    qobject_unref(dict);
+    return str;
+}
+
+bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp)
+{
+    g_autofree VFIOUserVersion *msgp = NULL;
+    GString *caps;
+    char *reply;
+    int size, caplen;
+
+    caps = caps_json();
+    caplen = caps->len + 1;
+    size = sizeof(*msgp) + caplen;
+    msgp = g_malloc0(size);
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_VERSION, size, 0);
+    msgp->major = VFIO_USER_MAJOR_VER;
+    msgp->minor = VFIO_USER_MINOR_VER;
+    memcpy(&msgp->capabilities, caps->str, caplen);
+    g_string_free(caps, true);
+    trace_vfio_user_version(msgp->major, msgp->minor, msgp->capabilities);
+
+    vfio_user_send_wait(proxy, &msgp->hdr, NULL, 0);
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        error_setg_errno(errp, msgp->hdr.error_reply, "version reply");
+        return false;
+    }
+
+    if (msgp->major != VFIO_USER_MAJOR_VER ||
+        msgp->minor > VFIO_USER_MINOR_VER) {
+        error_setg(errp, "incompatible server version");
+        return false;
+    }
+
+    reply = msgp->capabilities;
+    if (reply[msgp->hdr.size - sizeof(*msgp) - 1] != '\0') {
+        error_setg(errp, "corrupt version reply");
+        return false;
+    }
+
+    if (!caps_check(proxy, msgp->minor, reply, errp)) {
+        return false;
+    }
+
+    trace_vfio_user_version(msgp->major, msgp->minor, msgp->capabilities);
+    return true;
+}
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 89d6c11c4c..7a3645024f 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -4,3 +4,5 @@
 vfio_user_recv_hdr(const char *name, uint16_t id, uint16_t cmd, uint32_t size, uint32_t flags) " (%s) id 0x%x cmd 0x%x size 0x%x flags 0x%x"
 vfio_user_recv_read(uint16_t id, int read) " id 0x%x read 0x%x"
 vfio_user_recv_request(uint16_t cmd) " command 0x%x"
+vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
+vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
-- 
2.43.0


