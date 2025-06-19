Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BB4C7115A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSFNb-0004Dg-0u; Thu, 19 Jun 2025 09:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNY-0004Ca-5v
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:32 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNV-0008DQ-Lh
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:31 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J8A05v013187;
 Thu, 19 Jun 2025 06:32:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Ove+EINyRJPK8DL5E3/dHKlBUNKPuLS4ob73rl4KR
 68=; b=Cx0ZRk+2hdd0Yfij+mJRoxEREGkxQWJUxHe4Q70BYXnUdojebrsOH24IN
 LWLIjmBfP/2MbMjP3xtBHtnqTQy8qomqRbZVPVV/JeBTGU2o+5Zb8T6xSOGArV69
 CTskoxIuwGqE+57ZYFgzzVawA9aNKdNcWwJL0CqpvNWnPjEJEMS9NvS+0cT61jwV
 a1dckDHjriqzgkLwJh/lMwKZ3+WburS4c3EVDO03nIikAtsNiQZMs5L15TthTP7n
 QGMGw47ig03Ly1Nmqw6XYF35ghROrKUe2PdsJWYI9yncKHbHpKEkxRre5wT/635/
 g4hn7HRTh3RrfVAohaTNoGp/HFYMw==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020121.outbound.protection.outlook.com [52.101.85.121])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4798mykwq7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 06:32:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7TkYc5Uon0se87V1xVTdARI2Qowv/FraEudUQAG/AW764tuHcq8loXLNuU9OlKD5xpVga1ydTbZoIONdudyao4djoeyRgUhoJ3IU9kp0mKFevNFvyZUZXtVM00drcZdAuRgm3jlkoMEJ31Cilc1DZl89XghOSnJ0j+qugHgPEoGONaPxRtlDUHmNle4H9ASaXBJNE6SwFjE6RiqmmdT6ZhdRPjIBPn8xxflFUvatf4rvL63Xh7xdHlgLN2YJWrfkaCo2RYLZz1fTZFp3n/MUUB/naSDe2wnwc9ZOkdSI6M6Jw0qskl7DwOOnBqQiMf3icv0su/THerkVYTLmEB45w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ove+EINyRJPK8DL5E3/dHKlBUNKPuLS4ob73rl4KR68=;
 b=gj7Xs60Lo74vYlSa/CcJ1xLirAmw7yk4kLTPNmHhJi+lioLeZYgGR1yqK7FFPdsOfOPAOMSN8JGuyjHRn5oBxR5bgmme6adFiir5E6JDwFWwBeB0wAE+Bl5aY+4kun2o7yJdMS+3zxou2GJ6gtUAN1mixHf2kdp4GkT0z+tYcWGOGnTYZAaVALf+Lx4iZeTqJwus8fpvcwA9j8+LUtUyZi3o8IpImZwIzDQ06UITMBvT91jt5POm2PpuMS65Rnln9lqWjoRIQKsZQWmjaQMY8Sa70NzhPy+38UkxSRkVoAMr3w6/iDKJefBX8O4LPGtq+6juZaAdZlm0AP1jSS8EiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ove+EINyRJPK8DL5E3/dHKlBUNKPuLS4ob73rl4KR68=;
 b=AdHdRdyJSBQWhEvaRSriV8DIIqormD9rTGf5CQUeyq+SB0kzSfnUbwh9PWMP46zt0q/flLnW42k84gIdl73kP9ch96a47KR4WQvGC02mQc8c434Vgi7oorOF+uhNEv9ImhUcJlsqEdkaGRJUPDSEyP0leviUQDFElNDkGcPbIXl9rFGdXhBkr0hN/75bH+mdvNKeiwSKFCIS1FBCwVgK9EMB9OSvFmmw/S15OZiL/wMokM61FQdvpvbDzyDdok/Ldi3WDvLIBaRO/wCbbCuj0+Xj+0rwahEu1ZzL39EBwmcQvDqN2mh7qrIaZchxS5mfVnJAt6TjZ4aryl6z/jsF9A==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB9383.namprd02.prod.outlook.com (2603:10b6:510:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 19 Jun
 2025 13:32:14 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8857.016; Thu, 19 Jun 2025
 13:32:14 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v4 06/19] vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO
Date: Thu, 19 Jun 2025 06:31:40 -0700
Message-ID: <20250619133154.264786-7-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250619133154.264786-1-john.levon@nutanix.com>
References: <20250619133154.264786-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::6) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB9383:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e9abc9-83e7-4327-6b12-08ddaf35b3de
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xabnLLMAHTWR4xYLjH21KhQwmkpnewbCRyjxoOWMvbJ6nVnA3sNhx5DGlGFc?=
 =?us-ascii?Q?EY9PC7dBuljQmmfDvYgteEQqDQbpMFj/AGn2Z0tudH3KsHMa8UxPPY/D1rKI?=
 =?us-ascii?Q?DcuskjJL4CPToV0dQU2ix42JJb5JMD2QSqgQG22Q73P3t4y0TjsbuCoV5prO?=
 =?us-ascii?Q?yEnF1bXHYOcbpjSTN/gufrMHRuckGXBvfW8XGDRipwoo+X0R5UVSV0p9uqDy?=
 =?us-ascii?Q?+iykXELWJ6uclku3NMxfyi0v/2Bma/pdR1t6nIyCZPiLyzfs65C/ZrNNKyVd?=
 =?us-ascii?Q?xBQkdzh6GWkr88OryZZ7Ca5HHw9IHDTj+9DhxYiC0p4YDFbBzOcUqmvS0PHQ?=
 =?us-ascii?Q?rTYq2eO7ZXHhWT0XX5PonK6lGX6TxPkhijf5bGaedKtv3Z6cHP/eR+ObTmgl?=
 =?us-ascii?Q?l37xwa4k6Rs73ZHvyoPhuEC00MEJyHY9vDYUKLl4oIgkCsTvDhWW8G4sool3?=
 =?us-ascii?Q?8mBEYu1TYqoz2h5M6rMrLJNqGTqFC9Owkd0/PkVOSHf4PIo9n1fcMzuHPlau?=
 =?us-ascii?Q?MjUgjuzMOtH3o2Gf7j8q5K0Ugv/myasZwtd+FgpNLR209mDyKYa3go0IS0bj?=
 =?us-ascii?Q?nVDlwT5AXsJ8urobenfl0YpSyTnLyWuhXCr6PPu+XVj1MkTQtozI2xOTTPT0?=
 =?us-ascii?Q?ow6ei6TH9RRAAITcsgDdrlYMSNG3aqs9QXmIYPYm42GVh5t/4xMYNORB6SJ7?=
 =?us-ascii?Q?SksCe5ubPkQyVAgzSxeeHoRxbT1ULdVKusCmF/WkGBH6xNWm4oo2fk1wFvj2?=
 =?us-ascii?Q?m1kzVDGleGEY8tKK3ryYb1AhilBrX6xq2DAjn1nHfwdspqwHQkntzilHnsrx?=
 =?us-ascii?Q?k3tEVOC8Gh5Fz2GNE1GTPcW+qe4lypSq26yjZAIlwVWwktQM9mbotuGEvNI9?=
 =?us-ascii?Q?st5jSvfhx3rA/Yty83wEWw3Dw27nwV9PxDL1eCpJ8NWNBeic3D8tdylNyMzL?=
 =?us-ascii?Q?8Um5HwdDLiE5efJxPRvYgBMBLaIGI2d8bvC6c5+Ohr0lt13OOaF1cC3PQLQt?=
 =?us-ascii?Q?nsODyWRGRR84cKhSYh6tk3ZG6QOrFF3TrX1pLHO/LbO2e6kIb1NAJP4Z/1Nv?=
 =?us-ascii?Q?J+TwtkhcKAWXkhmzx3leC+bT5y/eYlQZA31gQItPOgsL/ffgsRiDUJoWDRRn?=
 =?us-ascii?Q?kV8vOTqVMbrSgebGOaKU+U9vJFCwfYN1Ld9zPe8mzz08fMyX3QIkgbtAoiSA?=
 =?us-ascii?Q?JgMcsOdM7Ux1JAyshTBSHV4PHgs83uDbSgleyI6podk8KLfEfVxwdgVRcxhN?=
 =?us-ascii?Q?pMFjBddWh6xVUDdBEDDoltY07mWmgiQfs1RODBelXVs7ggu5qTJt4dJu/wSI?=
 =?us-ascii?Q?DpyvEfstvV070jgZaNPdAA0ezl2guRotumRuNEnJ74egg9EmjyHjl266U9AG?=
 =?us-ascii?Q?hJidTK72LDkIV2UVny/aVFMSXisyzz3OcUid+cOIBs+XAFWdAw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TufNtHKyw8HFFdE9cJ+PFr3l6aETt+LhaOVu/7lZXAi6NGsQCFiyQf3wGQgH?=
 =?us-ascii?Q?G9HmgVoPBRi4ml0BCM0uK6OHzr81ipPEjK0cpeQlGTVioHvIlsJsSU46F4JA?=
 =?us-ascii?Q?nTpG6Er9vUkwE/ipvWb46m0Dld4eGgbctdvzbEtj/tQsttcpSXJZduiufs7K?=
 =?us-ascii?Q?cCWTzYLc0xjwxorT8jvR6R6akiRzGEam9oiGEzPuuCwb5AXseQ3buKockI8b?=
 =?us-ascii?Q?usuGX2GMoLvspC8AfgVpQEG1BlpO6PHf4F92fDMilDyKP97k1m3b88PKmzOY?=
 =?us-ascii?Q?gVRZNv5Og65+WZRwNbe2t96s3HcKJeGzY7rt5+MJjXEC1uxFuhCUF3XI+xW+?=
 =?us-ascii?Q?Y/qI81uL8lX4e/j7z6baK7xfes2wkyY+3if7HDM+kJj3sc0ohQI1sQaS2SdV?=
 =?us-ascii?Q?K1eNVQkdZOVDyCATUDDS7qb2JmycALRa0HHpAJfI4qDesluLfADOWgq+dPx4?=
 =?us-ascii?Q?gEnH9S5heKQqsx30dAWkv1oFDFAqDlseD2aKHsf43AZz4HIahOQtOnuG5y/A?=
 =?us-ascii?Q?LOB4WJ9vjXy5B7k46LceAw+1rUmToywaJHaRtAgFdCO/4l352TE9iI/2lxhM?=
 =?us-ascii?Q?hQqcWTCBfvIKlnUsh85W0k/M1ReFMhEf9VfRr6ku9xK6298Lm63zbIZS1HTA?=
 =?us-ascii?Q?hMvLbKS4aLfU3tyLZTEl+xu2BdTJLP3xkAadoZhOBSmS7Tikrt7nS+kbaD68?=
 =?us-ascii?Q?Dv5Y77Z2ep3gVfILFZPe+uZe1qOq/HpCEsW5qj/Ei14Bk/hFN/yYTJnyxlS/?=
 =?us-ascii?Q?EtSWjVEXLLFoxjmPMZWY1teSI7pdgRO1nxqVAHLfugrimKnEBbagu0fliFBG?=
 =?us-ascii?Q?RJ8oNV0JV8CUvv40ZHvvf6BvUsD212ZKlzQVlzOej6EhIjUqREJ8rZ38BAM9?=
 =?us-ascii?Q?DdEXgdzw0h+jkNZKy15WlJniy8wCBH3ZDCryD4YZPeT6IKd66LzU39WexcCj?=
 =?us-ascii?Q?KRKo2UFmiKz9bm08s/Y0uodsUWD4ovwffvr/D+HAxYvMOYdoh6aDdlj6mZj6?=
 =?us-ascii?Q?pVcXNnMxxZZclrbeKf3csNmPHro64ViE4BmzeCnWjAk3Gm75A2Jspq+S6CEz?=
 =?us-ascii?Q?eul5BDEu0cm5SmrdmZPsibgaBuXaJqhr1cAlIHpz+CIDFhPU0oQ8YHX52SEB?=
 =?us-ascii?Q?IL/B4GqboKP2Kup8euW7uHidGd+rxWoY9IjLHy+VCg7bXwyzwX2hXyjHpsRt?=
 =?us-ascii?Q?y7lBK/A7wR6nohlfeGoUFgtfgyu919rqpNWVoTBnEsysdi6L63XOqUBTbfA7?=
 =?us-ascii?Q?eM5nVu+c1GF/aC6W544PyBJ1L1kx8/wpd+tEJ1MFGmaVRZg3HoY983u6p0qX?=
 =?us-ascii?Q?mBZACXatGw7m8I4GfL9QzoDryDDdumG8NoQjBKn7v24MOL8DpRJUUgpwVosl?=
 =?us-ascii?Q?ciIwPRGf3WFAX5q2atKkHm23+x4FqEudRwPQ+wwIKSdQNKcY2H9v4clUtajI?=
 =?us-ascii?Q?+I50y8Ej+LCUSFNYzOWB/JZXadY9n7TGOYQsdlD8dgLNo/2e+nAx/fm1RpK4?=
 =?us-ascii?Q?4cLn48p+K0xMS4yggQ8iEocBunC6Cq56wglyiecRMV9ynQTgpgE1NLxzkh7o?=
 =?us-ascii?Q?yPlazyHnNFfaR0DAhy2VDemBEQSpnCcM+sdNiXVL?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e9abc9-83e7-4327-6b12-08ddaf35b3de
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 13:32:14.5428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ic/Ja+1IheD0dl6oSWT5xcgSqSUX0O10Xg5BI1bksvCAixEkYFGg80XMSZLOfZqhDMER+H/ah1fY8jdOlIEmWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB9383
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDExMiBTYWx0ZWRfX71qei9q4TThA
 87yv6GZ+KTP1AuEVq13vJ3BGp3RYjZMPvUVv9rCeb2Hx8HGIGvYX6g8gMadQAqHMgi02DiqaNdl
 NTdCV3cPas7SsLzx9Jv/fqcq/SWwHp33I28koHNQhwCyxxxW/Axljj/Xqjv+KEP+nITO53ie4Mb
 1PzR+DMMLy/zavJ4jdyZbde2jKv/Zxuz6HdAbphjSk7xZj9Lfzk3f4OltCTOP7Ufw+YdvAfnJxK
 E2C8XcdLTSLVnUOIwsvQNu010c32PJzR7GbH4IGNBaeuRmwAEF61tPuK/Pjb863bxQvgnHSf9uR
 VyP0IfgFdfTznEuKA0W0daKqFvMGKf9ZvciAO+Z83UuOfGWCeXzbdTyuLemD/Py9RbVxOQRwrQR
 91j4NpIYrxLUGdcIn7SBrHqbNvGOq5d7vbvyeb0Y+7gyCnGeCICQwUYc1Yl+pR3MZ4w55WdA
X-Proofpoint-ORIG-GUID: TdtxyHH0sX8Rzyh2uQ9V72yjW6y2yhnC
X-Proofpoint-GUID: TdtxyHH0sX8Rzyh2uQ9V72yjW6y2yhnC
X-Authority-Analysis: v=2.4 cv=LIxmQIW9 c=1 sm=1 tr=0 ts=6854116a cx=c_pps
 a=Yi5XoY1Pvk1/bV4Hj+lk7Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=u1fsugoMv0NfKDGiTLIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

Add support for getting region info for vfio-user. As vfio-user has one
fd per region, enable ->use_region_fds.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/device.h     |  2 ++
 hw/vfio-user/protocol.h   | 14 ++++++++
 hw/vfio-user/proxy.h      |  1 +
 hw/vfio-user/device.c     | 68 +++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/pci.c        | 11 +++++++
 hw/vfio-user/trace-events |  1 +
 6 files changed, 97 insertions(+)

diff --git a/hw/vfio-user/device.h b/hw/vfio-user/device.h
index d6f2b56066..5fc226fd58 100644
--- a/hw/vfio-user/device.h
+++ b/hw/vfio-user/device.h
@@ -17,4 +17,6 @@
 int vfio_user_get_device_info(VFIOUserProxy *proxy,
                               struct vfio_device_info *info);
 
+extern VFIODeviceIOOps vfio_user_device_io_ops_sock;
+
 #endif /* VFIO_USER_DEVICE_H */
diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index e0bba68739..db88f5fcb1 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -124,4 +124,18 @@ typedef struct {
     uint32_t num_irqs;
 } VFIOUserDeviceInfo;
 
+/*
+ * VFIO_USER_DEVICE_GET_REGION_INFO
+ * imported from struct vfio_region_info
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint32_t index;
+    uint32_t cap_offset;
+    uint64_t size;
+    uint64_t offset;
+} VFIOUserRegionInfo;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index bd5860e9b8..e5ac558a65 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -15,6 +15,7 @@
 #include "qemu/queue.h"
 #include "qemu/sockets.h"
 #include "qemu/thread.h"
+#include "hw/vfio/vfio-device.h"
 #include "hw/vfio-user/protocol.h"
 
 typedef struct {
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index 4998019b30..3d39b9b98b 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -46,3 +46,71 @@ int vfio_user_get_device_info(VFIOUserProxy *proxy,
 
     return 0;
 }
+
+static int vfio_user_get_region_info(VFIOUserProxy *proxy,
+                                     struct vfio_region_info *info,
+                                     VFIOUserFDs *fds)
+{
+    g_autofree VFIOUserRegionInfo *msgp = NULL;
+    uint32_t size;
+
+    /* data returned can be larger than vfio_region_info */
+    if (info->argsz < sizeof(*info)) {
+        error_printf("vfio_user_get_region_info argsz too small\n");
+        return -E2BIG;
+    }
+    if (fds != NULL && fds->send_fds != 0) {
+        error_printf("vfio_user_get_region_info can't send FDs\n");
+        return -EINVAL;
+    }
+
+    size = info->argsz + sizeof(VFIOUserHdr);
+    msgp = g_malloc0(size);
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_GET_REGION_INFO,
+                          sizeof(*msgp), 0);
+    msgp->argsz = info->argsz;
+    msgp->index = info->index;
+
+    vfio_user_send_wait(proxy, &msgp->hdr, fds, size);
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        return -msgp->hdr.error_reply;
+    }
+    trace_vfio_user_get_region_info(msgp->index, msgp->flags, msgp->size);
+
+    memcpy(info, &msgp->argsz, info->argsz);
+    return 0;
+}
+
+
+static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
+                                               struct vfio_region_info *info,
+                                               int *fd)
+{
+    VFIOUserFDs fds = { 0, 1, fd};
+    int ret;
+
+    if (info->index > vbasedev->num_regions) {
+        return -EINVAL;
+    }
+
+    ret = vfio_user_get_region_info(vbasedev->proxy, info, &fds);
+    if (ret) {
+        return ret;
+    }
+
+    /* cap_offset in valid area */
+    if ((info->flags & VFIO_REGION_INFO_FLAG_CAPS) &&
+        (info->cap_offset < sizeof(*info) || info->cap_offset > info->argsz)) {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+/*
+ * Socket-based io_ops
+ */
+VFIODeviceIOOps vfio_user_device_io_ops_sock = {
+    .get_region_info = vfio_user_device_io_get_region_info,
+};
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 61f525cf4a..d704e3d390 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -12,6 +12,7 @@
 
 #include "hw/qdev-properties.h"
 #include "hw/vfio/pci.h"
+#include "hw/vfio-user/device.h"
 #include "hw/vfio-user/proxy.h"
 
 #define TYPE_VFIO_USER_PCI "vfio-user-pci"
@@ -103,11 +104,21 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
+    /*
+     * Use socket-based device I/O instead of vfio kernel driver.
+     */
+    vbasedev->io_ops = &vfio_user_device_io_ops_sock;
+
     /*
      * vfio-user devices are effectively mdevs (don't use a host iommu).
      */
     vbasedev->mdev = true;
 
+    /*
+     * Enable per-region fds.
+     */
+    vbasedev->use_region_fds = true;
+
     as = pci_device_iommu_address_space(pdev);
     if (!vfio_device_attach_by_iommu_type(TYPE_VFIO_IOMMU_USER,
                                           vbasedev->name, vbasedev,
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 6b06a3ed82..1860430301 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -7,3 +7,4 @@ vfio_user_recv_request(uint16_t cmd) " command 0x%x"
 vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
 vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
 vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
+vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index %d flags 0x%x size 0x%"PRIx64
-- 
2.43.0


