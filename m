Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781D9C61CE7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 00:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNh9X-0002w2-Ul; Fri, 06 Jun 2025 20:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9V-0002v3-Ob
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:13 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9P-0006NF-7H
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:13 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556K9XAd027707;
 Fri, 6 Jun 2025 17:11:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=2Kqsm7S7nVPh0w+Hj7C+jzcdhYJsfDn8jkSJyyG3n
 hE=; b=wSnUVDqKhm5QWLDatwrSLhcXKHFLZveq3Z5sk43eYmStb9k9nIouO4ASe
 AF2aElOWZqHIYdsY8SlNdEPmEaW278xX01YbdvpL4ZeKubC3AvAUZPT2S0XQx+mt
 JvMAOfoHfCW1tydEvB4Ip7x6DEr13lWuK5llbn6K1G6b2hPIY1w7JoUgJ9VRnn+Z
 6rNAVS1IjJ1A3TYHxOmxfSSlz+MfbO1Zl1Q05il4ZYrHxVf2yTirgpTTrGaRKJWn
 fXCRgMpTBnptZNKbNGKJ5JztUfHdLQKQ7ex24a14QuJ5HEldox5u+Gq/gjnpevlT
 OHLRaqgDbU5uA2jWNYGrs1ZGZ8mtQ==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2127.outbound.protection.outlook.com [40.107.236.127])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 471g813xsu-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 17:11:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8P7fLS2VQJojeKKotDehRY9njVs/L3XC43pg47w0eGp70bx0/SY6QYt/6U93S+h5zRcGp+HJB8Qn88OwtxrkvJITd/zYmvwkTW7CoT6ggYhKlTxUK+/wnK3GObdnZyTFXze71npLmaIJh2XmfDfNH/0YL2f1KKewS0zjxx0rJZprq9Ag/gTR+rU5k94XXvLgQ6s/lf02gL5TNKkLPljk9qOjnXDVpTLl9gqtX6nixiRDQbReZjPDriV5HoQtHLDZV7ygO9yl5C0g51fghjMz2qeH9GgIc6KE0/aWj3SQLr+isUne2/GpcjorVuskAUImj8fhirxAorUtF2sp+JDsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Kqsm7S7nVPh0w+Hj7C+jzcdhYJsfDn8jkSJyyG3nhE=;
 b=b9ZMwQOw1snkyZplXzX91K5l74KXZFRelf1x1y9/1pWhsTYLyEHrcx/R2vP4237zF9JRGABOSB5uTjEPopDUuB5Md/7+/992+cJU9tSnQLekpXVI/eO6wVhvAkJkRxKhu51BJZSg8jjXUMYJipn4AzhegSsF9y9ODCTxV/7Jh7yRVnCjakluu9kLvVM2Ftf/9m/xqI5nSGq/S/HWMlF+NKsoC6cLabyNfx7XFrZIMW1ZZ9zLKHjJ5DFqQN+3JEPJF/CBTDQc9zBPW00hY4oiLu3ajf8cBaojxz/udRPg7uv4bj0+bCrQsFeGU3aRUNG+dKDOGaYJovvPISotQPBHtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Kqsm7S7nVPh0w+Hj7C+jzcdhYJsfDn8jkSJyyG3nhE=;
 b=Wc/8fRSgYYx1qqHw2cN9U/RgflRRJFRoL6+V+lT4p4i4zXq8WtD852krkw5zAhjE9TK+zbd+yNHz/RTJBm6AULnOdXiXGOvEIPQMHpsi7PRSC2lPJ2OcIH40HIn0JprXnvm3EOdRpd5qHOhcSuklCjTD7r2qfqpvW4ma9dsO1YVy2/8bqXeKDzYP4arTXVWgTPO1j8d8gEcq6eA9bjQfbkIEnOEMocmzehlemBbwY3lVdDZEJXx5ry1jffAVL3aPh6+cqZUEyeSPYrcqtcxsfVhtNPooGcmY2X6aFQkPBFSbXP+jFFggnEdKZlBHb7eGsBXgopAriWxY+HCA86dMKQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8715.namprd02.prod.outlook.com (2603:10b6:510:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Sat, 7 Jun
 2025 00:11:00 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.016; Sat, 7 Jun 2025
 00:11:00 +0000
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
Subject: [PATCH v3 01/23] vfio: export PCI helpers needed for vfio-user
Date: Fri,  6 Jun 2025 17:10:33 -0700
Message-ID: <20250607001056.335310-2-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: d4106bb2-2fa3-44c4-283e-08dda557c899
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4WRtPhQKSFKemYSrC9fyndGrriXteuHEICG/pkDj0hpodFAWdNxpBT7Ip7+0?=
 =?us-ascii?Q?bEVd2nNHe8XykHWAV+gswwgzlCItSjlTCXorH3I3q4bCO9sCZ7QL3EXrv5M/?=
 =?us-ascii?Q?vGu+swJn9jepvc8sfxcAQDdJohnUx7zpQi352/2E324qxAHGRgLOocnP7Fao?=
 =?us-ascii?Q?VEof60v7/MeMwEpjgqMbYNzqkI5TIHuRjBSxO7nHIcAaYyNASoqz4Kbw4XAg?=
 =?us-ascii?Q?PXWgTBeKTUMF+yEM3ke7CpDJR0F151Q5njRFg8u0RjOrFJ8MwURzbAHdF270?=
 =?us-ascii?Q?E3CLhWbsP1x+zgQoHm4q3qmJXpwOXyXJH0Yr8wHmB9oE/hCGc05rqfywQ7AH?=
 =?us-ascii?Q?cevaEXmQGrDQVSdTurGD3gBx+IwC3b8pcqyp51H3MTLr1GLt1mz8HYzewaTb?=
 =?us-ascii?Q?uqp9uI1qEzcNbmmfCad+vd1ivGHv33X7aFsL0YXFoVH+BiE82BCPD0hdh5kB?=
 =?us-ascii?Q?zdQ8WHFyFQagGVqvP8VoHUZ/WBWoz2nH7NTaY0LlHZ8SHuFkT/cijdRt1sZH?=
 =?us-ascii?Q?JGRG4WypnOJEoJBdSuz0UtltZFrfEUBZQCVKBmEvy0hcynoTATNPNV2m1X8P?=
 =?us-ascii?Q?qLrB2p7igseVKqANQbmehDnQsY3O1gNyDT2E7nLZCx5U8Cd7MJiab0mX60cq?=
 =?us-ascii?Q?1zsRD0O3dDIfOpWgBgkJfc8W6GWsRd/LLtvps4dnmisOKSg8hGFdTvhFdg+Q?=
 =?us-ascii?Q?21gIz1EdKi+17E58k82skaF4Sx6aEVV2+2c3qIS+8wLFdSUtWqY5Cgr22xkW?=
 =?us-ascii?Q?o85f0q1FIfC8aZ6l1lz908Dxuk35YguJRc54aGQBAyWrgDNg+VcEIz3IOOuo?=
 =?us-ascii?Q?nlwgm2PWiFQu9pKivZCGhJZo5/MKMEFLDfiivGjOSKcJB+IYSKLxUSzLZujE?=
 =?us-ascii?Q?1U4huVGdZT+M/axLZgwGbTl8OHl7KijVPcpKRUq689L6J1D20kbB58UHL6oT?=
 =?us-ascii?Q?1qRq0r9tXO1354jwbR88g6pWhqqcrWtKDa+BiJy60ORkX71UsZL+y+eQnLK9?=
 =?us-ascii?Q?nqYrIdZpJHj9FFhB0VDGzVNG8MZG8Bngo0cBIvcprdQCRqDSxgvyfZ+t8C2O?=
 =?us-ascii?Q?3UAtTTfXLvbXHDfHBBBxb4EQGN+y0F8UyDgKQOjHU3tR7J31hFu3BFLm4HWt?=
 =?us-ascii?Q?ifUtoW/OsxKbr6AdWRo8HU9jjX7ibd8egZY1c0EFkXNYag+HkixOHB5tqLJP?=
 =?us-ascii?Q?kA7g607Zun6t5TVdALuxAQbfyrG4i3Y/gLU3n0/ZtLCWrk8+mhGIm/+a+rtv?=
 =?us-ascii?Q?E/VuEG/Zv7ki0JXAVTqsOWmBEuLDZ3/GrBbFkgRn85KabyFZU4HC8JRkpsnF?=
 =?us-ascii?Q?dx31d8RIDJOytIXRIHGdlDQsHsd3hwWqq5iSTlAvdHt2E2XJvpL6KwexucOf?=
 =?us-ascii?Q?jLUAhQW0xYMrJrHy+lAT6bMU3JsM1p5kh8bybdhTqXrjB93F5sCzgwKCOpEM?=
 =?us-ascii?Q?s1mnolQVZKI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8I9uToGgzWioepNcrm620+dgOVA3gNuC1ob82g5KbiMLm1oolhfx2iynBtZU?=
 =?us-ascii?Q?TnwIayr2XGhJeDx/Nd2CNwTWvrZpuM8T0GIQQPZCywJEtYKCXfcJZFJyujP7?=
 =?us-ascii?Q?A8anrdfILWd84bypRpsd997lypaU0vYj7Czwew+xCwzV7YwRO0UUInt9p3Rr?=
 =?us-ascii?Q?wnYWXmEVdN3E8qwcC7WVp9eExIvGPnF0wNhx1AfXT1JP7MltkO0hAkD+juzf?=
 =?us-ascii?Q?wCBhmE/2xNub06ELOR46yUMMMVlpjADytynwgE44dHqzFfgBlOX1lVIgAfbH?=
 =?us-ascii?Q?JZ2jSfjtPSnVS8umpyCRfoFSxckd5I49u06NjoObqexzWxBAtm9Wb6fbb/EO?=
 =?us-ascii?Q?9oAm//eMOnYIAWnCU/DUZNDPq6fNfSKHFgUk1lE2f4/PoRzv39xgNXvVTwfo?=
 =?us-ascii?Q?53O0Vetn4RyXqISqQWt7LRMCeiGo55rpJSJcCgIRPN2sPcQaHU9Iwrawsj6Y?=
 =?us-ascii?Q?ADpjf+75cPchthBO3GiOKanL4FRPKc2/M0lEEH0cvPXSTF78zaz3gkQ8J8XS?=
 =?us-ascii?Q?It6eFoVp6NnaJ6VJ7eO/bInNs3dlChEDYFj9lVvdCxPQfDSAWGfXRb8OoSAd?=
 =?us-ascii?Q?nQ6uahqOoR4pJJLj+Xk2f+t5xx+DST1RGOSzPGioAM1U5OGXh+r87EPO5cEU?=
 =?us-ascii?Q?125Rb0vF38ssNAgQF5Msy7UHpjX45yNgbvxnk1Wpu6z/hwNQRyovSe9sUFLB?=
 =?us-ascii?Q?IuLBbgJoLQ4Ayt8LheHvehdUHEQjSLr4pBytyj4Q0VFQuA7SspTrzbXC+zWx?=
 =?us-ascii?Q?275r/1Lb8tUKjFNOIdegLOv3ExWGhmWFz6unu7p/NCIWdD7MHjYEzmLXwIwh?=
 =?us-ascii?Q?GjqNffIPbTyYE991uBZJWpswGUHqoztpA0RBOMYo9BgAlcZCsMrG8JDQKCKB?=
 =?us-ascii?Q?7Gc2An+c+YVy+bjROl/nJsZarCtRAOoQE4WMuPKIp5jOemZZB/gJmUr7j4li?=
 =?us-ascii?Q?11TmnQYPP8RyGeyl29PgeKDlXADE+Cr2oRDitJKDkZa9sFD4JIUzKUm4MNrB?=
 =?us-ascii?Q?S/WuKzy11jcnflkxxV12rLyGEjTYzbnwgPt6LcjKD0lEO5f1XfdaVa+QEFtC?=
 =?us-ascii?Q?EB3v37FlJvqrXfhiz4H3RbvGro1+4jTIdEAnPRfQ5JqkM5jmzrZADkGv3ptp?=
 =?us-ascii?Q?XCG9mWN8qVUOtZ+dKAAZ1csnjAKAYqfBgtmmlCfEbBF3XmITn9NdbsU9XOaN?=
 =?us-ascii?Q?xVGFu54RTJJarwGBWoxSrWsOhn1uT/YeX+DyHKPZ4u7zOjQYanQH8cevlbz4?=
 =?us-ascii?Q?ALV0PYO2N8C9PT+/wTGpuIJ2gcjx4xtGR4FS+S62pEnG86GZ3aIUDLVxcSfD?=
 =?us-ascii?Q?qFKG2ytWetyuMNyXrKW92jJciOMnS55ger0dJ9N2D2IoAHkrZ/m9IAN54z7s?=
 =?us-ascii?Q?naTP99qzcFOtp/WNL/dXGEGQA+LwLBcKgfg7I/KVtMkFaVvQJVLJ40xvtvFt?=
 =?us-ascii?Q?2U8f8zTMlZtAQq1dodgLEvNuKTgaBO7sfU7MbjiIWziOQhPHrWW5m7J0drLT?=
 =?us-ascii?Q?e6Z4orXUTzGSSh0F82jn+fDkbjgiw4Vc3pFgSBKRoHr/3kKk9oh8D7fXNzaZ?=
 =?us-ascii?Q?2kWaC6VPY45xxCw3Ivepot2oRDR+Dy6kTqcP3nAi?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4106bb2-2fa3-44c4-283e-08dda557c899
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 00:11:00.5491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UnGwPZaesA/CpVkMRMW4g2zXRdM2nxHH7qVaxW+ap4LOb1wMGbYtizY2gYyaGyoOfFauw3uijsEbw43M9kNsmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8715
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE5OSBTYWx0ZWRfXyCc5IQVz8kMB
 OkHrOoKByVvKIOFPiWVgVMXlrak8B1d+iAddKw5tuvvadvJj6KeHkzlfWO8xj6zHzNyWp3fraYz
 qlcVxDJKBhCW1eFV6q6eG5M/gfuHepBxzTTdQcwB1EbAFJDjTwAo0Zk4CvRNXcRrUaEH2kEdRZZ
 DfiwJeG7sJpU0OREcU0F0mP8stOALCw2BYcfezDZYqqbxo7ivGXSBCdO2zSFDHuezpIYG/310Qb
 ejfdJ4YEjel+Rsbtv6c0Yl0hibubnNHS6Abl4TIdFWbkyzgMxgDFTWHnWa2dFK0bTMEvVN99YDo
 s2G6EkymkWwPxBdMBMCKWiUC0ucKIX/ZlVhSjTiSUauQ2btzdjeTN3Sphn5hjetKpNTtSMlZ4tB
 gn4NyUcPrEcxCXNAkz+nxgl0rgGwmMy7bX9h5uNsqbwgPj3AFRK6ytN8rUaWAbd64FxMVjVQ
X-Authority-Analysis: v=2.4 cv=SY33duRu c=1 sm=1 tr=0 ts=68438397 cx=c_pps
 a=PuycMPbAwArgayjkkQxHog==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=29XCgI2txZ024MPHgJUA:9
X-Proofpoint-ORIG-GUID: OUgP1CwhwLRDhV5XmJXcgW3OD7BJ9Kd_
X-Proofpoint-GUID: OUgP1CwhwLRDhV5XmJXcgW3OD7BJ9Kd_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_09,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

The vfio-user code will need to re-use various parts of the vfio PCI
code. Export them in hw/vfio/pci.h, and rename them to the vfio_pci_*
namespace.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/pci.h        | 11 ++++++++++
 hw/vfio/pci.c        | 48 ++++++++++++++++++++++----------------------
 hw/vfio/trace-events |  6 +++---
 3 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 5ce0fb916f..d4c6b2e7b7 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -248,4 +248,15 @@ void vfio_display_finalize(VFIOPCIDevice *vdev);
 
 extern const VMStateDescription vfio_display_vmstate;
 
+void vfio_pci_bars_exit(VFIOPCIDevice *vdev);
+bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp);
+bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp);
+bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp);
+void vfio_pci_intx_eoi(VFIODevice *vbasedev);
+void vfio_pci_put_device(VFIOPCIDevice *vdev);
+bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp);
+void vfio_pci_register_err_notifier(VFIOPCIDevice *vdev);
+void vfio_pci_register_req_notifier(VFIOPCIDevice *vdev);
+void vfio_pci_teardown_msi(VFIOPCIDevice *vdev);
+
 #endif /* HW_VFIO_VFIO_PCI_H */
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b1250d85bf..a49405660a 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -103,7 +103,7 @@ static void vfio_intx_interrupt(void *opaque)
     }
 }
 
-static void vfio_intx_eoi(VFIODevice *vbasedev)
+void vfio_pci_intx_eoi(VFIODevice *vbasedev)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
 
@@ -111,7 +111,7 @@ static void vfio_intx_eoi(VFIODevice *vbasedev)
         return;
     }
 
-    trace_vfio_intx_eoi(vbasedev->name);
+    trace_vfio_pci_intx_eoi(vbasedev->name);
 
     vdev->intx.pending = false;
     pci_irq_deassert(&vdev->pdev);
@@ -236,7 +236,7 @@ static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
     }
 
     /* Re-enable the interrupt in cased we missed an EOI */
-    vfio_intx_eoi(&vdev->vbasedev);
+    vfio_pci_intx_eoi(&vdev->vbasedev);
 }
 
 static void vfio_intx_routing_notifier(PCIDevice *pdev)
@@ -1743,7 +1743,7 @@ static bool vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
     return true;
 }
 
-static void vfio_teardown_msi(VFIOPCIDevice *vdev)
+void vfio_pci_teardown_msi(VFIOPCIDevice *vdev)
 {
     msi_uninit(&vdev->pdev);
 
@@ -1839,7 +1839,7 @@ static void vfio_bars_register(VFIOPCIDevice *vdev)
     }
 }
 
-static void vfio_bars_exit(VFIOPCIDevice *vdev)
+void vfio_pci_bars_exit(VFIOPCIDevice *vdev)
 {
     int i;
 
@@ -2430,7 +2430,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
     g_free(config);
 }
 
-static bool vfio_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
 
@@ -2706,7 +2706,7 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
 static VFIODeviceOps vfio_pci_ops = {
     .vfio_compute_needs_reset = vfio_pci_compute_needs_reset,
     .vfio_hot_reset_multi = vfio_pci_hot_reset_multi,
-    .vfio_eoi = vfio_intx_eoi,
+    .vfio_eoi = vfio_pci_intx_eoi,
     .vfio_get_object = vfio_pci_get_object,
     .vfio_save_config = vfio_pci_save_config,
     .vfio_load_config = vfio_pci_load_config,
@@ -2777,7 +2777,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
-static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
     struct vfio_region_info *reg_info = NULL;
@@ -2823,7 +2823,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
         return false;
     }
 
-    trace_vfio_populate_device_config(vdev->vbasedev.name,
+    trace_vfio_pci_populate_device_config(vdev->vbasedev.name,
                                       (unsigned long)reg_info->size,
                                       (unsigned long)reg_info->offset,
                                       (unsigned long)reg_info->flags);
@@ -2845,7 +2845,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
     ret = vfio_device_get_irq_info(vbasedev, VFIO_PCI_ERR_IRQ_INDEX, &irq_info);
     if (ret) {
         /* This can fail for an old kernel or legacy PCI dev */
-        trace_vfio_populate_device_get_irq_info_failure(strerror(-ret));
+        trace_vfio_pci_populate_device_get_irq_info_failure(strerror(-ret));
     } else if (irq_info.count == 1) {
         vdev->pci_aer = true;
     } else {
@@ -2857,7 +2857,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
-static void vfio_pci_put_device(VFIOPCIDevice *vdev)
+void vfio_pci_put_device(VFIOPCIDevice *vdev)
 {
     vfio_display_finalize(vdev);
     vfio_bars_finalize(vdev);
@@ -2905,7 +2905,7 @@ static void vfio_err_notifier_handler(void *opaque)
  * and continue after disabling error recovery support for the
  * device.
  */
-static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
+void vfio_pci_register_err_notifier(VFIOPCIDevice *vdev)
 {
     Error *err = NULL;
     int32_t fd;
@@ -2964,7 +2964,7 @@ static void vfio_req_notifier_handler(void *opaque)
     }
 }
 
-static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
+void vfio_pci_register_req_notifier(VFIOPCIDevice *vdev)
 {
     struct vfio_irq_info irq_info;
     Error *err = NULL;
@@ -3018,7 +3018,7 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
     vdev->req_enabled = false;
 }
 
-static bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
     VFIODevice *vbasedev = &vdev->vbasedev;
@@ -3124,7 +3124,7 @@ static bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
-static bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
 
@@ -3214,7 +3214,7 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
-    if (!vfio_populate_device(vdev, errp)) {
+    if (!vfio_pci_populate_device(vdev, errp)) {
         goto error;
     }
 
@@ -3228,7 +3228,7 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
         goto out_teardown;
     }
 
-    if (!vfio_add_capabilities(vdev, errp)) {
+    if (!vfio_pci_add_capabilities(vdev, errp)) {
         goto out_unset_idev;
     }
 
@@ -3244,7 +3244,7 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
         vfio_bar_quirk_setup(vdev, i);
     }
 
-    if (!vfio_interrupt_setup(vdev, errp)) {
+    if (!vfio_pci_interrupt_setup(vdev, errp)) {
         goto out_unset_idev;
     }
 
@@ -3288,8 +3288,8 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
         }
     }
 
-    vfio_register_err_notifier(vdev);
-    vfio_register_req_notifier(vdev);
+    vfio_pci_register_err_notifier(vdev);
+    vfio_pci_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
 
     return;
@@ -3310,8 +3310,8 @@ out_unset_idev:
         pci_device_unset_iommu_device(pdev);
     }
 out_teardown:
-    vfio_teardown_msi(vdev);
-    vfio_bars_exit(vdev);
+    vfio_pci_teardown_msi(vdev);
+    vfio_pci_bars_exit(vdev);
 error:
     error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
 }
@@ -3338,9 +3338,9 @@ static void vfio_exitfn(PCIDevice *pdev)
     if (vdev->intx.mmap_timer) {
         timer_free(vdev->intx.mmap_timer);
     }
-    vfio_teardown_msi(vdev);
+    vfio_pci_teardown_msi(vdev);
     vfio_pci_disable_rp_atomics(vdev);
-    vfio_bars_exit(vdev);
+    vfio_pci_bars_exit(vdev);
     vfio_migration_exit(vbasedev);
     if (!vbasedev->mdev) {
         pci_device_unset_iommu_device(pdev);
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index e90ec9bff8..f06236f37b 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -2,7 +2,7 @@
 
 # pci.c
 vfio_intx_interrupt(const char *name, char line) " (%s) Pin %c"
-vfio_intx_eoi(const char *name) " (%s) EOI"
+vfio_pci_intx_eoi(const char *name) " (%s) EOI"
 vfio_intx_enable_kvm(const char *name) " (%s) KVM INTx accel enabled"
 vfio_intx_disable_kvm(const char *name) " (%s) KVM INTx accel disabled"
 vfio_intx_update(const char *name, int new_irq, int target_irq) " (%s) IRQ moved %d -> %d"
@@ -35,8 +35,8 @@ vfio_pci_hot_reset(const char *name, const char *type) " (%s) %s"
 vfio_pci_hot_reset_has_dep_devices(const char *name) "%s: hot reset dependent devices:"
 vfio_pci_hot_reset_dep_devices(int domain, int bus, int slot, int function, int group_id) "\t%04x:%02x:%02x.%x group %d"
 vfio_pci_hot_reset_result(const char *name, const char *result) "%s hot reset: %s"
-vfio_populate_device_config(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device '%s' config: size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
-vfio_populate_device_get_irq_info_failure(const char *errstr) "VFIO_DEVICE_GET_IRQ_INFO failure: %s"
+vfio_pci_populate_device_config(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device '%s' config: size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
+vfio_pci_populate_device_get_irq_info_failure(const char *errstr) "VFIO_DEVICE_GET_IRQ_INFO failure: %s"
 vfio_mdev(const char *name, bool is_mdev) " (%s) is_mdev %d"
 vfio_add_ext_cap_dropped(const char *name, uint16_t cap, uint16_t offset) "%s 0x%x@0x%x"
 vfio_pci_reset(const char *name) " (%s)"
-- 
2.43.0


