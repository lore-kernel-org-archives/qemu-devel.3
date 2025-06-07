Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E507C61CE7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 00:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNh9X-0002vV-4L; Fri, 06 Jun 2025 20:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9U-0002uO-0e
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:12 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9P-0006NT-7K
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:11 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556K9XAf027707;
 Fri, 6 Jun 2025 17:11:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=TzOG5lHzWpuuyob4EorkqBxc9Wvjp4DQ/aa8BE5J7
 Cg=; b=bgQfeR35fQEk9MKZBlACXtDDzR4UGVupb8F8yYFy8QjaU1P54gIDFPp3a
 RBXn6KHsnEGhxOvu/ObukSzPEv1hcLnYVlwjL9sia7YiH/tq+hYFHLJl7ZeOSjJD
 owH0xNx2ZbGZcNmj6fXzQeHxT1YozOSOACD2/ljePF47t/U165kcCxtxh9Z6T1hD
 TDqw3gOaLBbiH5YieS4xni/qhROxow7AnQJRX6eSROj/OuzoCeSgKW7A2GiiGbbO
 Z/vnrZ1U12a9YAf7vjEGHMUVNXw8bgBAx5IDzPiB0PUWRf1NlVteEBw1HU9UlYgM
 RlQiaRnGhQUrgDGq/4q0lu/3QfEJw==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2127.outbound.protection.outlook.com [40.107.236.127])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 471g813xsu-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 17:11:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpnpqmdVQxSI192MMqLKSiegLemJc1YsY+ZSQsqCiHYT5rZwaeSmA1uspwCLh8TXljq/2cHd7UX/d1gi4IVLgsfBw++bhCk+EGWyl31z4mOyjwcvAjT9OBa3us/MPY8Mzy3FQVQ3R7ADJD/eUsUki2UxrcTphbGAsphYIqSaz4P25XXfDsfExvofUT/YSDT6FmDJ1MVpkujFhDErfK3HPw1lfqaJeo4cn829bJKFzgY/xSmgB7v6WF+I1E6ZoNgjwyFlDCboWGuVH8vuv5SbrEvf4kiv6VMpZHbSfuDlLZ5W384NUDAzpmhOmPjmOwBStRD2HF+jVZPPe1aaGD6fLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzOG5lHzWpuuyob4EorkqBxc9Wvjp4DQ/aa8BE5J7Cg=;
 b=x93zdT+S7uqhGPpZmG9EcbEzZQCARfj0m+YNq3K0e7UeBoPw7JdE31kQD4ZycY0fy6TRMpQqpowy2bpfOpR6bQA9skee+BZZBd11acr++dB8JxaVJZikgR0bPb/KiIlIY2QF6Z7la3LU7Q3kjg5qVmDqI+No2Gy2gSAFuTKJ9ryQ8dNmv2Pakul5evEzZUf5J1WefLXXRceljUy7YecXX/UL/+cJ+jidi2mHsmp12F1PtGClDKqlKXEL/FPhEnKek18veM8A5J9Cx99Zlzh04oVbNDVNktL8o16ntaN3ocuEc+tBVTwzWgb+474NJZx0/XNyBC+AyjA603PJ55xgxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzOG5lHzWpuuyob4EorkqBxc9Wvjp4DQ/aa8BE5J7Cg=;
 b=DtbLd46tq9y2kmRelBfbmOaUMRzZBQFvoLB2CU5taCcTPiIBvQz3WWFsnyYcdn7lh5cGn9Q7ceAokNizg1vxM1KEooJuYSmd9ZeynUSUWNdb7ydziVdak/XY3Mo1MS/21B1wV+Mzr5TjcC+RrHBzFiugmZKrQ/oW9cBNkNmgvYGZPim+JWG+N1BJ6FHae7l/yaKkcwXrryGDI5m88AKi9rzZ7DV3mlCaNpfGGoysi0JXhWhw/RN2+7s3IfLs2Xo03sUWhXVWHL7m/vM0x4qaC7Al5a2IB4N6bk8nmH1z5PCl4ZWB6cfswNmSpnpYQEfaz+yG8OhopzRT3WNZm9eRZg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8715.namprd02.prod.outlook.com (2603:10b6:510:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Sat, 7 Jun
 2025 00:11:03 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.016; Sat, 7 Jun 2025
 00:11:03 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH v3 03/23] vfio: add per-region fd support
Date: Fri,  6 Jun 2025 17:10:35 -0700
Message-ID: <20250607001056.335310-4-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: ec4b6eb2-c8da-4c24-4e2d-08dda557ca3d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xWx7njxUsfMjZASckcywSZAjTnX+2ZRHKtM+3dU2DoqJ2tClufzUaKFyAIFz?=
 =?us-ascii?Q?1fvl3mvLOdo0BLTw1To3orvXChG6VfNuVxQVK6wN7B3MQSdeLoFTcpy5eQBZ?=
 =?us-ascii?Q?U2rAsAO5eB7e1Q0hEkrUg9QOrvqTrQfCRW8jyQ0rnyFKXXTkersJyI5RNHVb?=
 =?us-ascii?Q?W9tXMYdKyCWuDtvHF8TucTdE1IUGpjwSgqCIs7aG+HE43pQUg+zIu/mbOD1i?=
 =?us-ascii?Q?QykOARb2tcBJdqL914BUF+Z+En5Qryknr7gRY1DWWmXkUMQh3q8q48JSBoL7?=
 =?us-ascii?Q?8L3T3G0mdrs7MyWvvQlkMXpY1yoCwg3FEd2ZIs1G3zpSUQ6croRS44B1GLaK?=
 =?us-ascii?Q?kIlpMG7kg5vTMEZmOsLRl9abllSB0B71lF6QemGAAK8gAM6uJG7XsBy8Ohw7?=
 =?us-ascii?Q?PtmKXaKR8PWzjns2a4Nen3DBKdJYAKyvivuImO3Pa590N5Y9VPfXBQkWHdWt?=
 =?us-ascii?Q?HQDWOr95WLJgejyVljyv7H6jQxGkC3p4jJNDHMHvh+47StTZ3xd5cNi33wQH?=
 =?us-ascii?Q?0BNhLHAN5BkLJQgySL61IFbFiim9RRs3/hT34DFDzUGG9ncnGzjeel2y8s7o?=
 =?us-ascii?Q?AjMy8iCxDGvYa81nCBJio5FKH3pz4j4w97OzKPP7P7GQGkdtWjnZVKLtxAcC?=
 =?us-ascii?Q?Sp6D9M1W5bUeZRDBq5Fxp9HCqIlDMht8L1DvYQybkJEW24/lGPbMwmA3LMrC?=
 =?us-ascii?Q?S9VtMQrDxvCjuW9ydNu74gi+3WlAv0ko8scs4YE/5MnnPtJJv8vqUFa6eCGX?=
 =?us-ascii?Q?s9AgshXlWgz3yrZrB3mkJcEyJmulWK1RpWg4il3Uz41Mlip6oxwuALGwewsn?=
 =?us-ascii?Q?YNjas+QWyvyEZpUjbrnuQvPhPArgorgPGxjNrCIwYSFo3M4lmYxIw2tww2E1?=
 =?us-ascii?Q?8V4HXaHsJkkMouVFEjwsbFEUGZT2d1XjkNxSDh0E3p1VmUqiuwEyjqTqnX/j?=
 =?us-ascii?Q?OWjrVZv93VZmGir5fXbi0EKq9iQO2cMQFEobqh20IhhhNgx2vio/dtD6QuKn?=
 =?us-ascii?Q?bjbmAo6JsUhUpDhtoeYYPt5gClqVBwLLzytitYLb0+4lp5uQahkhmX/EhVg4?=
 =?us-ascii?Q?ZFMc9Uyq/7T2ZysEStMlk2sRwxQaRYrA16xumexUeAYaSg9KvqM57LVsmngp?=
 =?us-ascii?Q?ml+1STgC67KvVISPwwkfOTdEz7R00+7mPjsO3ySIjyh56jb4Rkd6ipzaus7P?=
 =?us-ascii?Q?4UlWUdm9YkyPwfTg/nBBJhDntiec1J/xPMSGvPZfwidyTNuKqdExZ9O/AaSE?=
 =?us-ascii?Q?EzyBqCsx0jaNISYLg+UOVPfaS3ShkqwY+lfsYHtLVdssrXhl0FufCIjk784t?=
 =?us-ascii?Q?IJAXv8UVwXC5H29kRknKaX/yTzrXKRFmR5wH04FlysoatsTDQPRaUtS/N8//?=
 =?us-ascii?Q?nnHI2IzZw5Ug0xAZSk5XWQvDYGW92gaC6WYrbFek7Cxr/wKN4yDYZfbdpB/9?=
 =?us-ascii?Q?imT+0L2m8eg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G8k1s1WUCzFHSPxdGjFCBrxpaLNPsKDLbprAxVml0Wy4F4Cye54r3kAPi6Zj?=
 =?us-ascii?Q?cL9wmq1bz4RklZ/hYoYzUmOP6SoCxaa5EmwTbmqt0YK3osX0okAGWs5GHsZB?=
 =?us-ascii?Q?WxcLcNDuyJEmHZOwp7zdLmK0EVNaiTPVMqO/avxhtPQv9fmBYYre+F4R/jcC?=
 =?us-ascii?Q?Zz3rmyIHAZJO526skQ0FwtLv+XhfWwgYBJ+016FUmUfVdJ1MnuYacfM2rekB?=
 =?us-ascii?Q?ULzAa0pBFGiKdc29RbfaoFI6kkno9VnJwmUEW9Q6wDnypXNZ1nRMrt1w0hwB?=
 =?us-ascii?Q?vN3JGIH2Oyc8Pprx2kJvOl3BHbSyiRK4gI28XY8TMne9DQ2Ax+yOJCAhMWW3?=
 =?us-ascii?Q?nQkUfKBa1JNkxwyU3xqjGWevutXHe02w4j1Y4E4Xr6LFoF6q0mXPLCwgSM/Y?=
 =?us-ascii?Q?JOF1Gh9HxVvwqey5tUt2nG6nm7owc55D6BTEQUV5YDNZN9+lBZLmXOfI567C?=
 =?us-ascii?Q?ayhO9he72ZcwDSAptgQG5flLZr2cxti+ItKb1HMgDJy/ubASEzq7R1VFb5lq?=
 =?us-ascii?Q?KNwv4/nITSYnk44Oy+GrBErtWb/efMYl096eW2BGlLcoEH4bPuKqkt5fCwix?=
 =?us-ascii?Q?k++pI9uB2FRvVm7L1DRq6SR5mQxL1hsZQr/ZUjR8PNnZNxnRG9QCQKLl1msn?=
 =?us-ascii?Q?LQmjqJeZDNXZTdrUYfvwrfTe9nWQ9bK2P6KdQsXi03hiJvZPtMPNERig4SfO?=
 =?us-ascii?Q?fVUbLE9pVB7ZxHNlOnXLteR691Jg4Ni1PlSI0hbBMIlfS8WfbcRnLZnFiOZe?=
 =?us-ascii?Q?LfvHqXbJkriQj+3602MHXx6KxymSzxcqkHOiSUXPPpCn2+3GbLveVQz8z5A0?=
 =?us-ascii?Q?S/4PNc2C6W/P4lqxyeVE2dSV88BnJN0SERVG5WhtHdMKDmgVUlNwEAiCx8P6?=
 =?us-ascii?Q?ElA6OQRiy3EY50qNa2sXAvkyReTqMAZbZk41x7Z7o3NScDQO7e/6gXoHolzX?=
 =?us-ascii?Q?bsO3mM6qB1z7gQQ19rhjwX+Xl/oRWayZVYMGMOUw5UcMmdE0ez73X5XfhwTE?=
 =?us-ascii?Q?SIi//j2SC7XMSa1C+awA0zNOY6D8CEOkfdtrDUi0QANyUsHT9qaGam8eA/kn?=
 =?us-ascii?Q?/2jQEeAhlUxZu43mkUELy7AImlos6NtOgeysVAmPyx7E48GwHagBO+CfSQpS?=
 =?us-ascii?Q?kbLtKBouvxGHFWXZgtF2YS/fP5RoG3qoLk+KKUU6Rg/RaMgcX87BFaZk/fuf?=
 =?us-ascii?Q?xG45rbo311BXRZp20qUGUqWWqgrarLZCKTWBxX2y59JYiFoXEKyenn4+vfsB?=
 =?us-ascii?Q?htyrpddUX4DDBX6RtgHEOy0kyvHa6g7W8us//dnBy9AknbscCqFHzz/izdLH?=
 =?us-ascii?Q?vunAYkgRx09FBhPMTrYw8IQLOwjQi6boTHj+YkoFV88eIhAM8Wo/IoPSsZxX?=
 =?us-ascii?Q?JbGZzoSTkQF8Ik9ZwH/9iLZHF5ndl1uiF09nJOo5vNQ1EcDtMPWwMjCXWPe2?=
 =?us-ascii?Q?14fl/rkxXsPVRGkh1HYRgvLTjHUI/q68GTPG5C5QRL5+nGWtD04nkPzknF76?=
 =?us-ascii?Q?2kwKz73j0NfRZG3gBFCjtxFM/iMW6t+CwLzrvPGThrDJvH6noVh3idZGlA6U?=
 =?us-ascii?Q?J0Yx9n+pvd5CCygVbpLv1frtncnM/MGZ//Tpm7S+?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4b6eb2-c8da-4c24-4e2d-08dda557ca3d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 00:11:03.1887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PCiVl9mGEa3X4n0WnP90Hxj/U9i0ebh8yEby6qEZawn3p3tM5FMBPn3uYqvkZKYF8vwwvE/OvO2I6uDUBCmTlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8715
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE5OSBTYWx0ZWRfX9boENOywHE7m
 cCsXf1Oo7JYAK+pRYCshQ5dwAzZRGZ4lQdaFz6celeLzm6HtUUrQiFq0dp/rBc+QrqpGS1e/8Ad
 RUjEJcijdd4MF9Hk/ootxIdhhIB+rxrw8SnpAd+cLwneEEf/znhJmsPv/dRFZAoTt0ppVhrjE4L
 FUJw8/fFWiSYXWxkDDTrnlm32PWnupexm7U19S+MDA3U2sudlwXPw0iKiu9z1PWF5ysRdZOu+e1
 fVpAX9ugx07kjtk0BiQVYBzXA4wC8VQrVe/xl8J3+hNSlcw60YBMe6wDud0BYu1dQPuSU26htUz
 V/hcUgBTPO0AHq1zY5LG5adUhJ9FA/5V4fCGI0lb8HUqylK79mXnJUFguwljmpnxBgkgFcC11tN
 WmznWzRnIeqTEhmNdimmvWoz+ANUsebXlWe/q+baWyylz8Q6XEriX0UI57nuE4zjbgouoZER
X-Authority-Analysis: v=2.4 cv=SY33duRu c=1 sm=1 tr=0 ts=68438398 cx=c_pps
 a=PuycMPbAwArgayjkkQxHog==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=w5k4ZZm-TmW3-Hdf4mgA:9
X-Proofpoint-ORIG-GUID: vIXB9IIhEiRzMOCAa4n3atmF2moY4hnG
X-Proofpoint-GUID: vIXB9IIhEiRzMOCAa4n3atmF2moY4hnG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_09,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

For vfio-user, each region has its own fd rather than sharing
vbasedev's. Add the necessary plumbing to support this, and use the
correct fd in vfio_region_mmap().

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 include/hw/vfio/vfio-device.h |  7 +++++--
 hw/vfio/device.c              | 29 +++++++++++++++++++++++++----
 hw/vfio/region.c              |  9 +++++++--
 3 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 923f9cd116..5cb817fd6a 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -66,6 +66,7 @@ typedef struct VFIODevice {
     OnOffAuto enable_migration;
     OnOffAuto migration_multifd_transfer;
     bool migration_events;
+    bool use_region_fds;
     VFIODeviceOps *ops;
     VFIODeviceIOOps *io_ops;
     unsigned int num_irqs;
@@ -84,6 +85,7 @@ typedef struct VFIODevice {
     VFIOIOASHwpt *hwpt;
     QLIST_ENTRY(VFIODevice) hwpt_next;
     struct vfio_region_info **reginfo;
+    int *region_fds;
 } VFIODevice;
 
 struct VFIODeviceOps {
@@ -172,10 +174,11 @@ struct VFIODeviceIOOps {
     /**
      * @get_region_info
      *
-     * Fill in @info with information on the region given by @info->index.
+     * Fill in @info (and optionally @fd) with information on the region given
+     * by @info->index.
      */
     int (*get_region_info)(VFIODevice *vdev,
-                           struct vfio_region_info *info);
+                           struct vfio_region_info *info, int *fd);
 
     /**
      * @get_irq_info
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index d0068086ae..29a8d72deb 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -226,6 +226,7 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info)
 {
     size_t argsz = sizeof(struct vfio_region_info);
+    int fd = -1;
     int ret;
 
     /* check cache */
@@ -240,7 +241,7 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
 retry:
     (*info)->argsz = argsz;
 
-    ret = vbasedev->io_ops->get_region_info(vbasedev, *info);
+    ret = vbasedev->io_ops->get_region_info(vbasedev, *info, &fd);
     if (ret != 0) {
         g_free(*info);
         *info = NULL;
@@ -251,11 +252,19 @@ retry:
         argsz = (*info)->argsz;
         *info = g_realloc(*info, argsz);
 
+        if (fd != -1) {
+            close(fd);
+            fd = -1;
+        }
+
         goto retry;
     }
 
     /* fill cache */
     vbasedev->reginfo[index] = *info;
+    if (vbasedev->region_fds != NULL) {
+        vbasedev->region_fds[index] = fd;
+    }
 
     return 0;
 }
@@ -360,6 +369,7 @@ void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
     vbasedev->io_ops = &vfio_device_io_ops_ioctl;
     vbasedev->dev = dev;
     vbasedev->fd = -1;
+    vbasedev->use_region_fds = false;
 
     vbasedev->ram_block_discard_allowed = ram_discard;
 }
@@ -470,6 +480,9 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
 
     vbasedev->reginfo = g_new0(struct vfio_region_info *,
                                vbasedev->num_regions);
+    if (vbasedev->use_region_fds) {
+        vbasedev->region_fds = g_new0(int, vbasedev->num_regions);
+    }
 }
 
 void vfio_device_unprepare(VFIODevice *vbasedev)
@@ -478,9 +491,14 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
 
     for (i = 0; i < vbasedev->num_regions; i++) {
         g_free(vbasedev->reginfo[i]);
+        if (vbasedev->region_fds != NULL && vbasedev->region_fds[i] != -1) {
+            close(vbasedev->region_fds[i]);
+        }
+
     }
-    g_free(vbasedev->reginfo);
-    vbasedev->reginfo = NULL;
+
+    g_clear_pointer(&vbasedev->reginfo, g_free);
+    g_clear_pointer(&vbasedev->region_fds, g_free);
 
     QLIST_REMOVE(vbasedev, container_next);
     QLIST_REMOVE(vbasedev, global_next);
@@ -502,10 +520,13 @@ static int vfio_device_io_device_feature(VFIODevice *vbasedev,
 }
 
 static int vfio_device_io_get_region_info(VFIODevice *vbasedev,
-                                          struct vfio_region_info *info)
+                                          struct vfio_region_info *info,
+                                          int *fd)
 {
     int ret;
 
+    *fd = -1;
+
     ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, info);
 
     return ret < 0 ? -errno : ret;
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 34752c3f65..cb172f2136 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -241,6 +241,7 @@ int vfio_region_mmap(VFIORegion *region)
 {
     int i, ret, prot = 0;
     char *name;
+    int fd;
 
     if (!region->mem) {
         return 0;
@@ -271,14 +272,18 @@ int vfio_region_mmap(VFIORegion *region)
             goto no_mmap;
         }
 
+        /* Use the per-region fd if set, or the shared fd. */
+        fd = region->vbasedev->region_fds ?
+             region->vbasedev->region_fds[region->nr] :
+             region->vbasedev->fd,
+
         map_align = (void *)ROUND_UP((uintptr_t)map_base, (uintptr_t)align);
         munmap(map_base, map_align - map_base);
         munmap(map_align + region->mmaps[i].size,
                align - (map_align - map_base));
 
         region->mmaps[i].mmap = mmap(map_align, region->mmaps[i].size, prot,
-                                     MAP_SHARED | MAP_FIXED,
-                                     region->vbasedev->fd,
+                                     MAP_SHARED | MAP_FIXED, fd,
                                      region->fd_offset +
                                      region->mmaps[i].offset);
         if (region->mmaps[i].mmap == MAP_FAILED) {
-- 
2.43.0


